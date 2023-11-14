Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B43AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 02:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698F410E1A9;
	Tue, 14 Nov 2023 02:37:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBAF10E1A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 02:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOY/OdiHuHCMjveBwGUSvRBtO6Bs3gBuk0H5ULRP9mRFEDpjog1Qqtu0rzYOVC6YNbWoZdxlZsppCibQmyQbhDxTCPbFK4zB2zm+Hsu3XqhI3JL3pUkLYRbF3JLOYn3lSUfSa7N4hGEShQlAU2StP+nOtUqPkB4ddR3WEtW9Aa3uy8A6aZnb9sa33XCGW+nT2QWHoGl/0Aqf6TDfuu8nLZQABIxvdjDJDMwblAVQtg7UaGpbVl1Bz4uPqP+Z4QKzwzMBY9CUeNF/fu2LjPUB5JpdZZxeI2CLRqGdNq4ybWnBngGF5C9pS92NcKIbV8fkmFvFKFnuoS5I79+XmjZ5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU2wiB/tEB4f+OgrMqA5g8GsD8QF8MFXpoMta5Qe0Vg=;
 b=CHKX4oeKY7XpZQI0D0wjp7gqMCFUu5LnqBeIHB4BWZUQV5ssQ+7Z0zYCp2eoYFSY+UjK4zauH15Cn7LwJeUDtc2WUpFWr3S0dwvnFA2IXymxkIgH2waTBDSTvjXkoHSFnU9WxY1kR8Z7E+vJia6asCuTk5cNHkx0Z7UaXf1gnsOenZy6FlPXxoGfWSsvs2ZAwA6h4dhy7obC7Z11df0X1CZ7fC6/H0WWuPSq7Vb/pUap8S9SYDdv/9G+lB3rRDsRISgtkwxXGQg+yNkxwhoM1hD1P5qTKWLfjqtt2k+4FoSyj8xpghbLaCLTN4zxhVUvSoQD471Zn3fXRsCH0UKggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU2wiB/tEB4f+OgrMqA5g8GsD8QF8MFXpoMta5Qe0Vg=;
 b=Gg6+FCvcvb8XkVrrJ5vkqBgjue2kj5RYwIfVoH+EbK2Fs1qjIMps1Y4QcFJmpvk4Sm38Yg2Z1MMJZltpvvO0TamjWQ3e+xFKNphvcOleFjK8E/7hjVlJYx35/TCV12OKsOFfiuAgqfc73W0u/qadfhN3ZLdUgZk5hkOyKgetn3o=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Tue, 14 Nov 2023 02:37:20 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a294:a55c:ea32:7ba8]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a294:a55c:ea32:7ba8%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 02:37:17 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
Thread-Topic: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
Thread-Index: AQHaEt+QS10Ai7GqX0OnysA7gdyIGLByhnsAgAVsChA=
Date: Tue, 14 Nov 2023 02:37:16 +0000
Message-ID: <DS7PR12MB6005A5E74DC33F4D86BC6138FBB2A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20231109073701.1751965-1-Prike.Liang@amd.com>
 <BL1PR12MB5144F2D77CE97D32889DCBFCF7AFA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144F2D77CE97D32889DCBFCF7AFA@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c436cc2-2509-4ec2-baa6-315f7410e2d9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-09T21:42:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB6662:EE_
x-ms-office365-filtering-correlation-id: 6baf2b96-5595-479a-c364-08dbe4ba9e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIpvclupclZTPieSXyb0ADDs0MSb9HCSp/nFXgJQZqYolteOkoxl7emCbnXrmR7SiaX2XmV5gdU57ZzxBmOMvu+1NL0A2Ihl0MFhOTKB/3JbwIMr7SiWJPI2cotriG1ZfK0OBlc15VS4RhA5gAUx1sNQs3t17JCwPnJ8DaHoT4oyN439x6mRGbeHtIWEpz7NCm/RwaU/QqRkGFU+/7xrV70VjjcI22E0zM2rL5V9RvLLX5xyIc4zElwcTe1IOwSLZmtaUBk8NbNVhD3FgCdvmnphUhvlu8cob3q7Db1oFQiC8mpH19SWT6gx5AbX0fBWdz8uU8VlXjQqSRR3eg1i4LQwmeXAmYAkxbKds6uDITbysXdqrqTguwuw4QsoPpsyg4uli7heLKje0Eag8zq4W7H/O4DKngFlViDpQc/NGao8Gu2SzV14nu4mY5DWWTuNjfeF7nKe7G/cxhkG9mLsSMrXb9tvXPfEuIhziQ1DLn2236VbRmq3Mz9KM4ViVq/DDfyJUx/T5hS+SDO6apyrgMaPcXZ8x3W9MwekMuF5lLi4jtCfS5SKPySh2PffMYuqjNeLEZ1n8hZIK4WqkLz0ofAPzEc02J6U7WjoFgE/bOQ10p/gZeTY5iYORVI8yRmK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(5660300002)(2906002)(52536014)(8676002)(8936002)(83380400001)(122000001)(26005)(55016003)(41300700001)(33656002)(7696005)(6506007)(53546011)(71200400001)(478600001)(9686003)(316002)(66556008)(76116006)(66946007)(64756008)(66446008)(66476007)(110136005)(38100700002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8MphxZNNvZEI8icIGLXRnB5XNB//VAXVI5mOma9aM+/fztIIIe+/vwh22wrJ?=
 =?us-ascii?Q?LaaeEnxhEuSLjcpohYtBwHIp08abTFi98BS24II3+q44qhAkY7XRmMwHOR6Y?=
 =?us-ascii?Q?jzVQnuHSIqUOOMFNgfCzkHxjSZx9o3+y64LN0lyum+ohNYid071w9c4sAV2Y?=
 =?us-ascii?Q?IUtDNWmLAQIt3z7TD1u167XSr881wyPnxkamMKjKXmfrZTVkpXbr/2dTtkNN?=
 =?us-ascii?Q?GX7cC0GN7gJwe5j/5VVKX0WdS8bWEVLVF0kBo2lapG8xMefiLhaNtQ+CiP+V?=
 =?us-ascii?Q?KTPStrKZiffWDSKD4/S2CErFU2xME8IpZdsMTHpl9ZkUx4pQNd22O2tNRXKC?=
 =?us-ascii?Q?NFjwqIJQMPXiai86cEsidmIfYcDnHjwozGuEZQflUVtOVK1XtOKTD6N6HR5D?=
 =?us-ascii?Q?CCZ/seKb0VrApkh+zjujdER0HfxUuoYtSHLXGFLidBkxnL/XTCXMyglLNeuD?=
 =?us-ascii?Q?fWCety02QoFpKgNRg//MgiNSTPMKLUixQTIRbpRGRrfDRWPKJv6/3fTCPM1b?=
 =?us-ascii?Q?nBLOkU8X6e+AsG8PXhZZrmbLvATqe6Ya37nkNXDabsVVYORb1hYYlxrTvGXt?=
 =?us-ascii?Q?e2lXhtuG1Xsud77QKygFHipaUbSksFO5xJ1npt8kOwpXza4nv6PIMI4tIu8g?=
 =?us-ascii?Q?vic8HpljbyceJIZm5Y+N4w9vb3EhR06vhJlqycuuZJhrKhPEV6zXrujDYRLu?=
 =?us-ascii?Q?1RMzuUt0bR2O4xYLVxnG7N+d+MQE28ZwGBqaj04KCInToJhVLo8kX8aJlDnJ?=
 =?us-ascii?Q?97PcWBWMsRxcHwIQ1Z8zO3+Iz/rMWpMVqks8NNfdUcGglNkctji8OERFIr6E?=
 =?us-ascii?Q?QwurP2N+uHmEe3w5/iKwUXyiDH/QErfeyJ/taRgWoHv+ajkGfs9ZpYAJEFlF?=
 =?us-ascii?Q?UNWoyE25gGRCQsolAhCI8bzn7y3I0y+ZwFiOkeI3/t7drBnotLUeMd9vinH0?=
 =?us-ascii?Q?B42x2AhUOGIw/wOdltriuaQG36/Mqd9Q0AKZqj2SNWy+SX5FrkRfCMaLAH/U?=
 =?us-ascii?Q?W2i9zkRZTNAPZwh/A+PItA6g91caH2GD/S0SSLQRYzPOurP15fZHYz6TesD8?=
 =?us-ascii?Q?xVEC5Wzv/A3qsKnjD3EwECmgZLTRcGR9VC2GOcqQgLW+AP+47KUUR/1g1QTj?=
 =?us-ascii?Q?FDGy+NGIVMNhtAtqSD7eQAWkLCeo3+eJcEEHys+wTURWAyhlc7HfLYEokwtD?=
 =?us-ascii?Q?bdnQv7OWjwcs+DxOVcWAW8LXG0lzMzjjoL391prQY06fm2JIMgSBK+nMYfMM?=
 =?us-ascii?Q?6+ZLwQs+LnL89cjGdHtjdhNdI12ctWHIv+EqpJjT2DXsYUtf2hDafnjxI7FV?=
 =?us-ascii?Q?JjX1XdwdkQmtKw4f/0KBYy2g9w6j6h+c7boEa8CzGXLbFrX1yU6hP771REsp?=
 =?us-ascii?Q?IYQ47Qif+1t3/Q2RNo6uUv65IzqDCZTWcKbGmRbizr7f+uJ5sJVyhg9SIh4t?=
 =?us-ascii?Q?8HkvQhnZfA6h85eYSfCJL7JytVUfXzDEoqr9D0aT7MIm5C6bogKzCfuMuLSR?=
 =?us-ascii?Q?XQCJtBB9YLHYO3XogAIKylfamQDf6iEKSyYG9ND+rnXdQiz0PQiU1EBg0H3F?=
 =?us-ascii?Q?NZw6+Nsj8e7oSOMPF2I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baf2b96-5595-479a-c364-08dbe4ba9e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 02:37:16.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5ZTyQREoEqQ2FR2iN0hGL57FWgzABz1hAX1isErabo5wLXS3fVK61PtMdapjc/p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Friday, November 10, 2023 5:46 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime
> dereference usage count
>
> [Public]
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Thursday, November 9, 2023 2:37 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime
> > dereference usage count
> >
> > Fix the amdgpu runpm dereference usage count.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index a53f436fa9f1..f6bbbbe5d9f7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1992,7 +1992,7 @@ static int amdgpu_debugfs_sclk_set(void *data,
> > u64 val)
> >
> >       ret =3D amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK,
> > (uint32_t)val, (uint32_t)val);
> >       if (ret)
> > -             ret =3D -EINVAL;
> > +             goto out;
>
> I think this hunk can be dropped.  It doesn't really change anything.  Or=
 you
> could just drop the whole ret check since we just return ret at the end
> anyway.  Not sure if changing the error code is important here or not.
>
[Prike] Thanks for pointing it out, revisit this part that seems ok for rea=
ssign the return value when the caller function can't return a proper error=
 type.
I will keep this part as the unmodified since this has no problem for deref=
erencing the runpm usage.
> >
> >  out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 0cacd0b9f8be..ff1f42ae6d8e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -346,6 +346,7 @@ int amdgpu_display_crtc_set_config(struct
> > drm_mode_set *set,
> >       if (!active && adev->have_disp_power_ref) {
> >               pm_runtime_put_autosuspend(dev->dev);
> >               adev->have_disp_power_ref =3D false;
> > +             return ret;
> >       }
>
> I think it would be cleaner to just drop the runtime_put above and update
> the comment.  We'll just fall through to the end of the function.
>
> Alex
>
[Prike]  Do you mean something like as the following? I will submit a new p=
atch for this.

-       /* if we have no active crtcs, then drop the power ref
-        * we got before
+       /* if we have no active crtcs, then go to
+        * drop the power ref we got before
         */
        if (!active && adev->have_disp_power_ref) {
-               pm_runtime_put_autosuspend(dev->dev);
                adev->have_disp_power_ref =3D false;
+               goto out;
        }
> >
> >  out:
> > --
> > 2.34.1
>

