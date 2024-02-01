Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A673C47DDB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 11:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D1310EAD9;
	Thu,  1 Feb 2024 11:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h8ioCJV7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A85110EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 11:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoeL1NyFFReqfI8YnZufsslyfXO729x55gUifXAYuxU1G0+WYcs8lDUidQ83sErrJmHNfsSizpX+mrahZ3ZzABVsOMsrLKtTZlmn7g+yKm6AGit05qHm2U9jlb6RBP645P2CEyH5agblXSnWuyyopC762QQp9JNSnTLidC5srPiHDZxy9hrjJnmt1y5Q/vLhJamijE2FcRosEXvYngMPtm/H6iWyBZkAObgjlVPfDdcp/2JGRWikO+OdFa/VtMITSjvuJgz4kJ0l4Gk1VBR9ULPRZMqYoXHeZb6S6eSPdf+7Rs5JH3kUq5zqqIDMsMYw+V6OSKmTjqjrBoUkOS3zDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4JUrTV0t00t0oJzrOCBqTP0vGhK3UdtibBrWwrr9QU=;
 b=V7psm69WE+68lVlMjmoDK+qAxjjTfUf5rLpeFV220DAVGVE7V6iX8lRuF/rV3ZAG5p0ACSbrL2HGYyJw0rZ+4VdeBEWJG8egbbEBvg9WtQjcqspnk9RbmQROlnOenpY9F+e9ff3YuI2pv3em7mY6UhAVVHYGjnyQuIFYfwE+t5ZMdubZpe8wxslFE7wKtfxL8QL1BfQMhMVG6/XF3aqRGfE/F76J/08ezpApUZX/hlF97GiRbkZDPKlS3/0YsTqK1j6nCJ12Te2/WmtP/w3RodqRGHNE8eBCKFk76R3vuzT/zedEoQ3cjkhv6Z1g0x30CaQbj7CBFVCQ0jpPJ35FVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4JUrTV0t00t0oJzrOCBqTP0vGhK3UdtibBrWwrr9QU=;
 b=h8ioCJV71ECnUHvKbMGfdSgyTj5ykj2SEbl88o7y0swSfOlehmkPKSkEjYpuUKTQdK6VVz8GD81nwnz2Ht6O+0wECjFhw4H5yUPxPipb85/SogyqbLKHlrpnvkj9aWknksU5nqrE9btNgCIG4h9Vrup7UKi02lsSQYZK+arGpVI=
Received: from DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) by
 DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Thu, 1 Feb 2024 11:59:14 +0000
Received: from DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::fa09:dbeb:7a64:7541]) by DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::fa09:dbeb:7a64:7541%4]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 11:59:14 +0000
From: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg
 4.0.5 suspend
Thread-Topic: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg
 4.0.5 suspend
Thread-Index: AQHaVQWoPYNvUEbXMkWUMQwZZtryybD1YbyQ
Date: Thu, 1 Feb 2024 11:59:14 +0000
Message-ID: <DM5PR12MB2565AE0FE8B725872E73B5809C432@DM5PR12MB2565.namprd12.prod.outlook.com>
References: <20240201115430.4180149-1-li.ma@amd.com>
In-Reply-To: <20240201115430.4180149-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a758903b-0e23-417e-89dd-60af0c297516;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-01T11:57:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2565:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: a81e6804-23a6-4d2c-039c-08dc231d35ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7mpkzf69oXLCoQmlZVPBoFJD7GEmj+ca+uHF5PVGkecl/zUriOAzJm3hoVLQOvmWdAXJ/j8frrBOTkg1ZHWnuKKjRxvPgIod7UVc+ZVA7drK6tRJFJ8dtBVK/htvx4Q84NvLaXfVZgqt9ZJcu1dXn7gGWm2EsaD7T+ei3m0VjSukoivQtELCfKXgbZCcyzpvk/4ZQbBUt/+qZu8A7v00292Rmr6boBR1Lje2A9rbOs8CLmLPrLwE1rrF8Y0+9YHDxAFexpd4jouO+K7Rr2dxOKxC9FAKcPgQZLqVNuPdu2dsVbCi//MAojfT10sFn0pXmQJU/71Q+yCXIvAgrObqWhGl2NITrMQkQrksrZFyJG44IQqouWtWgomymtRtpLoYePaxekMdNZ9j+mne8zdPJ5k2RyDZbhnAhx3SJiRNc+Af4/HeqY1DLKt5NVkLONg5wW241FKkT/q/4KuH+SK9zAC5zbgmDaXte/Kh5Eazbue9Mtj/P3KIojaovZpaiFBByBw7n8Dw/h/opK5yZLaX9oHLI1PvMFAleoCT63VUFKTGYi2AvTjYxyd2Cbdt6/4of0XPWgwQ/5vrSnBYgwb185bW5f8FZGILRQaR2bJnQWZxavB/mPjnXfBI9jL0oa5XTRDp9iumMIXI1Ar7s0kOgxTOzNgn6+uL4z7plWRXAGg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(64756008)(8676002)(4326008)(33656002)(2906002)(52536014)(86362001)(5660300002)(8936002)(15650500001)(110136005)(76116006)(66946007)(54906003)(66446008)(83380400001)(38070700009)(316002)(66476007)(66556008)(122000001)(38100700002)(53546011)(9686003)(478600001)(7696005)(71200400001)(6506007)(26005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BT5ZgjIJw19OFd0TboxiXCZHNPJQUEPZu8y0Dmo76IHOm+IUyaoWgGcVgd4O?=
 =?us-ascii?Q?Nx7FAsd3Vt+yrHhPtFhk4uv9Et2z3yVmhxY3lVwPL22kqjRrnWjc1Vj7u2mC?=
 =?us-ascii?Q?WEfdTxc+mfDwrKy6SsVXzWTRaXyqgrneLQtFVspndNy34fJGrF/fJfp5i1i/?=
 =?us-ascii?Q?E2LSTMB0NQ+ZdXWpx788tGYzFsMe6VSAbe+6GPfVt/htB1AYumoWyZLh6GRC?=
 =?us-ascii?Q?Pars6P3/Bf3P73iCwkxqi0LBQsIwWLRi0Hp2uZb5ELrilC+39KsRL8DSVUG1?=
 =?us-ascii?Q?Hc9mZT22ocUTnusmXbQa8SWF3FAcXYe5/zrnlJ9OWha56X3Y5d9G+vtwVg5W?=
 =?us-ascii?Q?kAgXsJkYZC4xOlJDCXcIgt21R56XeGGPfd4eNYbsnCDxGPF3t++o4ZxgvkWF?=
 =?us-ascii?Q?TAqVDsKx6yizv5VHfFR2r6JXCZ1v59j2BDBoEf9Ehr0HEs3n1K4pxr+4BnQb?=
 =?us-ascii?Q?+6F6p47NHlIaTG9Pz6L0G4b9ZnqZ5Y5wl7Mn57mt9HiXrkKTz16iSVq+QZ+E?=
 =?us-ascii?Q?/Wjkk97vTeKXAUTc+W3bWUV3l2X2uwNhmwtq3rYHhgCIEdi4w6OAHYwZKUAE?=
 =?us-ascii?Q?OGc5Ojvmyb13K9gX/h+jWZDn2uHc+gejiyR9b5KKkDmAdJf5mgKoPcvU6vbw?=
 =?us-ascii?Q?Tcz0Do37915J/aIGpfuSvD8Yx+JD3DQavxk3tGlWzGmC4OHu/vRFsOnnXzBw?=
 =?us-ascii?Q?RoWC8WNMqyeABRMm4o7naoiRcBVhhKDhRH0Jdds/TRFVXbAGuXsGnz+GX/Jo?=
 =?us-ascii?Q?ksoAZ+td1rMHvG7U1O4anGNxatcSMB5XLCsvDvo6TtVI7EdBEh/H2Bq+pNTQ?=
 =?us-ascii?Q?KozEEuVZ0M/NVFzvoYbSlGc0DXar8qmHAL+vwZdCV06hDfc+WB6nPf/U6w0s?=
 =?us-ascii?Q?3qRumkE7oiIiI349UzAj0YGpmsvYRrTyxA74buK6w/mtCoK4qHGk5FSGHsra?=
 =?us-ascii?Q?kjmGjpZ+OVSb7u6voXuDj0pxjgP6WjtUhoLPnKfqkV276RYW27VBzuwPJw3N?=
 =?us-ascii?Q?UpRS20tZB0uGu03/ZA7PSDWxVuBZAH0CknjK2lq1ApfRenm7RpydpCCf5HqV?=
 =?us-ascii?Q?5Nqu64iocWOGhaXJF1YIrDq+OGxL9JoUiv/l+0NJ6ogVw9BTlqyte7+4O4ZD?=
 =?us-ascii?Q?fWWYMjRV8aO6lhOPcOCqeAvJwzUHxnubKVfZTH/gwJ6WIR4smBoCT5UQCB17?=
 =?us-ascii?Q?I4EfUOo8y2KBKng9seU5W8eol8CZ8+kHdAtN3p/qje0Tskt8IbQMDJVobPRC?=
 =?us-ascii?Q?QanCrkW3wF+dhR2B4bpWQ/9qXCTXPIyIMEzQdMAv6G7Ryt1cciGRuYfxgMbs?=
 =?us-ascii?Q?Vpv8vgLFZuNQoJhkUlGSWvloi3IC3KkCnJbnB3dw+Mzpyt+QWBv/ActDFWSu?=
 =?us-ascii?Q?drgPuyBD2pgaSHWqd9SyJHsBI7EEhweVH6QGbLxpFoWyB5X1NkHGhEeSVaMw?=
 =?us-ascii?Q?ujwd5lZiM1DCxnyRZp+/Ng4Q7d8WfvhLiZMa1mrqd3VbDTG+NxjS+QHTTwUq?=
 =?us-ascii?Q?F+Ec7rEsKp5TkUhj+70Tlz5JOvP9vK+W5osGfKBm6hfP8GP1HcWBdtCyB9Ox?=
 =?us-ascii?Q?0QhzgJn8i9iFxXaHe2c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81e6804-23a6-4d2c-039c-08dc231d35ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 11:59:14.1130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjQK7V7LFsBI5uicuG/klx3nPa2ilR0xqs1mZQtihvsiI5x92aN/rFZ5v3gW1jlI3srxjwwGjAPKHdM/+KquNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gopalakrishnan,
 Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-By: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Thursday, February 1, 2024 5:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jamadar, Saleemkhan <Sa=
leemkhan.Jamadar@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhr=
an.Gopalakrishnan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma, Li <Li=
.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg 4.0.=
5 suspend

A supplement to commit: 45fa6f32276f7ce571227f8368cf17378b804aa1
There is an irq warning of jpeg during resume in s2idle process. No irq ena=
bled in jpeg 4.0.5 resume.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  9 ---------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index bc38b90f8cf8..88ea58d5c4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -674,14 +674,6 @@ static int jpeg_v4_0_set_powergating_state(void *handl=
e,
        return ret;
 }

-static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
-                                       struct amdgpu_irq_src *source,
-                                       unsigned type,
-                                       enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
                                        struct amdgpu_irq_src *source,
                                        unsigned int type,
@@ -765,7 +757,6 @@ static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_=
device *adev)  }

 static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs =3D {
-       .set =3D jpeg_v4_0_set_interrupt_state,
        .process =3D jpeg_v4_0_process_interrupt,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_5.c
index 6ede85b28cc8..78b74daf4eeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -181,7 +181,6 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
                        RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
                        jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STAT=
E_GATE);
        }
-       amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);

        return 0;
 }
@@ -516,14 +515,6 @@ static int jpeg_v4_0_5_set_powergating_state(void *han=
dle,
        return ret;
 }

-static int jpeg_v4_0_5_set_interrupt_state(struct amdgpu_device *adev,
-                                       struct amdgpu_irq_src *source,
-                                       unsigned type,
-                                       enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
                                      struct amdgpu_irq_src *source,
                                      struct amdgpu_iv_entry *entry) @@ -60=
3,7 +594,6 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_devi=
ce *adev)  }

 static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs =3D {
-       .set =3D jpeg_v4_0_5_set_interrupt_state,
        .process =3D jpeg_v4_0_5_process_interrupt,  };

--
2.25.1

