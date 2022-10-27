Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29DFFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 13:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E254610E641;
	Thu, 27 Oct 2022 13:56:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CB910E63E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 13:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLveDhun25Dj/luNvVJKYG1yhGBhWdAp7K3chtcUN3EtFJsIDCZNqXhva+zYPqgv2iugNIu8IuS2fky7rjpATWP6PVbYxN4E9OfhavrATMTadG8AiM4ZEWYjXV4t0bPjFwqdzoz7gb80Be2XMbRo0uc354Ul7l+Q3GMcKq+Z2gYcQQxysQtWojE9/thBpftzgJYr/DTw2C2b4omR/S0dqOyhREECPQ7XJfBwyFw40SQsMWQFRdlC3+gJLiYRAOKyeuscB0iYIf2ptxNG6S0CH2goYYb+Pllde1+uZMkokQE0kL4xoUbjQfrB8LPmA+4qo0r63Vz02sz7Ip4/buALXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv0NSDJHlbBD5FBz9Zs9KDkzVRaZ6G9oYiMBjB5SuD0=;
 b=SEHoYUhoThFxC2hsjZ0quZOO2jDrgUfZE20A7KwU08q8v4QQ0meB4eqFx6qOX+dhQar/5X2ehMWQPhm/384OuZmoZfb6e7Jl73gFj+cqqbY7VxKwONxDrkCFuE8kfk2cdlsinqLR4F/k0vg+L6531yVQBdXY3OpX78nLyNEOeNXyRqcxG3x+kxHWbTzJi75gw8uCEVY5mRS/dvhKawMPtA+PCQaw9zFfvM2rLEccrLcW2eSO+TihM3XBcQk2YSVkHxcDI8n63boNHc32rUvkMco6r9bp4NWVsMeNCudojozzqk7Uzeo73pnIBrOQ+EuyoNH0PWslQv4goFIrJAlItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv0NSDJHlbBD5FBz9Zs9KDkzVRaZ6G9oYiMBjB5SuD0=;
 b=gq1GtxUZ8SnPRsB1zEl+G5bP15WMATwy0dVMS1m+AMLyCDpZIrzpwIkd7diVFt/6163tKxbwsENdGdauW0L5RsgATPQoKcZFLjGL1+iSV7jnhQmcGZOK2/0knpJ4SDpS0uaSjtkoCmH0mts1c6m+432Gj1UqFBbiTtYJFvsnO/E=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:56:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 13:56:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11
Thread-Topic: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11
Thread-Index: AQHY6XcUUJboQH2nFEux9XoKbxddba4iRMx3
Date: Thu, 27 Oct 2022 13:56:25 +0000
Message-ID: <BL1PR12MB5144244F27BC7BEBC1C0D92EF7339@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221026201042.989337-1-Graham.Sider@amd.com>
In-Reply-To: <20221026201042.989337-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-27T13:56:24.659Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH8PR12MB7278:EE_
x-ms-office365-filtering-correlation-id: 9055769f-c850-4d3b-7418-08dab82309e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMJU3Badbang3ImA6CKMoH9Lx6sNvOS8Ao0SeNOhNZRbxlqGENiwbF9jqZQzEB3t6zyYyPLinliLUxkoVWnZrJ38xXDP3HBvWjdyoVF/7Dk9S081RJd6vHVBieO49Vw0ooe0U7bilmpxHoP6ZNZUOey8JwwkdJu4kbM93kE7KpmH2TwBnWQTRBu1QJJVLTsI2SferaVOCFhj0HkUCc9Ft/mxTGuNt6FvFttzZoxdNqOURTb3kQVYsP5WlXbCqTszZzn/mZKn0RUk/oZjKsaJXkuTq+PRIdUhzAKUFS7fNy/goy3OpoeKkwzzuS2oVJXqnv7RjVnPo4xe4p99Co0i7rIQ7J50sI/PTECjDl/DWd+8/LA82Dyw3eqWiDWXuzfpRSUz8n5SZMF/Wjmp0e83yU+gL7ArgSLDTMJVlgHrzLNzzrGcfCkX4kJ0yDrV7+P5ogm+tE7cQhmWrP2ZjZj9SpVvh3JSMY6O7bzMjmYivvuh6yXBwo5Zs0G//p8QJTRlapnGO9m69qM1acA+13XDC7fJwffpDkdkzq+ozMEG36S3SuMc47oInYq4tiuh/+oJfEcYaE/2tiU9ubhxig/BW+ig149pFmhSlJyBAFs/4Rc0nu1cJFz1cVXTjEENPxP36Mn3XPJA42O3HXHf1nZqtnpGwdtygSY0ODqmfkiwZHBA4idEOcy4KqfAUlnEemwQ4+Rr5EcvHWtB+P4Grao3nZYWIrIjneWC8ojFhj7hAAcwyhNn/I22TdSmCiVWLLUSlTXccIHXUgiKBOlVXJSKog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(55016003)(53546011)(38070700005)(122000001)(66476007)(5660300002)(64756008)(66556008)(66446008)(33656002)(26005)(4326008)(9686003)(38100700002)(7696005)(8936002)(41300700001)(66946007)(8676002)(76116006)(316002)(186003)(2906002)(52536014)(478600001)(71200400001)(19627405001)(83380400001)(6506007)(86362001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cz+oqjXeca2TPhEJhWKHpiuYzadmtpbL4nGomqVBQ7tbyuYw9yViao8BPX19?=
 =?us-ascii?Q?u7ei6OLBqKxQ6ULDEiffwLlccFBhLceqH5t7qZNNltqghvYVQ+Khhm6qjs8n?=
 =?us-ascii?Q?lcawlbQ2im3u5F5Zfsk0pudn+DSNDJGcDB2XI6OK71P9Kja0SwmAWwPgqKlS?=
 =?us-ascii?Q?Evf1ayeLg26TZg40ibgqV2c+grtLmMypp61FKGLSU9D0kOpQtNgQKY6Xtatw?=
 =?us-ascii?Q?bqQo9MkmpWagIS47lIUHrtQnqmmQCo91fJcpy7hnuFYYIuDjmvPslWyI1e0I?=
 =?us-ascii?Q?zJ1j64xwr6JwvpXuVa+6vfdTDn1fV4dyF5wNtKwwCtIj4NB2XOIJYu1XPCMe?=
 =?us-ascii?Q?WfGyq0VM52T8qOLhPV2NpUr2NKIRpfN+s0ChEnMGJ+OKCPxI0cJfMyinF2mZ?=
 =?us-ascii?Q?wmI6e+DYSxg/JhSRt345+VmmIk9zTr5FmmYEqXbkB3pknv2eCOpN11193vgc?=
 =?us-ascii?Q?/+sp9Mr8PS+HxAocHSj6BY9TO8YhyN5sSNT/1daaWflazQk+hrkOYyySCl+y?=
 =?us-ascii?Q?ux0LjhmsTaa0jnjwUnhEfaUgrSwc4P4R1Kt6nemMY2RXqkQYDEtxfptZCLar?=
 =?us-ascii?Q?fD8R8XRX2E8XF2K6cThc8ttt/Kfe/S0fAoGWj1uj41SgQ/SV3YBW39CPSbB3?=
 =?us-ascii?Q?BvxYMjXOHtMTc0gueZLEFFqJ+V3scZbtkIKa2EFpkX2599Buie+CWqnzRMKY?=
 =?us-ascii?Q?QNoHOTWx0rvAoo5BfGLhjzSqj+2diLu7cU+RNjiabhb7m6u7PlDkJLqiHLC8?=
 =?us-ascii?Q?ODCw/qsKXY6dhodveuzYzefFQhw3HZjJ0eh2P1SBCzgSO/zZyJHehHbL/BHH?=
 =?us-ascii?Q?OHW1F3NTy6U6gP8u/HG0yQ8J073WDc/Nxz/GHpwDQZxQ14XcEVE0MTSba87N?=
 =?us-ascii?Q?TH3xKgqTUolxRgVXWk0p4BcNAGvHsKF9L2nHtE3dIMGmbd18rf/v9UkAYaqr?=
 =?us-ascii?Q?2726EEk92T1pGc46fY0rMJZWaHNnELLorclvCeX4NlvXqUaWz04wVOPGG7Gg?=
 =?us-ascii?Q?WosrewJZjL1hXWdKC6WT4SCl+gDchURoIhMR5clzwbnmLqMSNQ2UDbaAKcAk?=
 =?us-ascii?Q?PyUoVYmZ6lO2yglt0u7a7XrK7Ux21y1I+edMbWxUiETHBFxIw7fr6cbGB+yI?=
 =?us-ascii?Q?4JApTOjZ1jb47ncVG6nJuih5B2Qojp5zmWgENH8JyaEgU7svVyflSpaOOc7y?=
 =?us-ascii?Q?YjCBbIJoHdO3SoBfXgjBsZU4auP5VDbreVUZbivaTe2+Kxl7XvAMpalAUTkt?=
 =?us-ascii?Q?26llLnahET5jZB1HtD4z+md4bCE+KlnVgI0herwWizANYqZllfOibbcr2iv/?=
 =?us-ascii?Q?n4dCvUF3PlnvKroyJcQ7pieDsVCqxGv4mVh5d/6aCmkW8/AGPKFYUMJMJ0Un?=
 =?us-ascii?Q?Y/tpMktUBiEDIF6/9DTbgjZTQ8d13+Tq/2EZCA9ZqiTc+9K0agmYINHpmw0n?=
 =?us-ascii?Q?urvrz33P+EkEFhLRH2CJCQneYz4J1aPSw5pzPK6O+evKYb5sZiJfZM6rGJ8G?=
 =?us-ascii?Q?DGDsxCCpW4dx8d0ovO7lYHP9JkGLBB4WX/to4jjEIm+F5EUwZvwUoo4WWn8z?=
 =?us-ascii?Q?XKwJoFAW/6NT2UsEEgw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144244F27BC7BEBC1C0D92EF7339BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9055769f-c850-4d3b-7418-08dab82309e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 13:56:25.4857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QG5ZW3B3+xr/nt0FKPt/rlFaUu+ssb7AFzMhZENmK2VDxCZopDaS43e6c9kGqviDxGLxuHpyx6kvZcVe7dMM2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144244F27BC7BEBC1C0D92EF7339BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Graham S=
ider <Graham.Sider@amd.com>
Sent: Wednesday, October 26, 2022 4:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham=
 <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11

Temporary workaround to fix issues observed in some compute applications
when GFXOFF is enabled on GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 37db39ba8718..0d764c15f6bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -706,6 +706,13 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev=
,

 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
+       /* Temporary workaround to fix issues observed in some
+        * compute applications when GFXOFF is enabled on GFX11.
+        */
+       if (IP_VERSION_MAJ(adev->ip_versions[GC_HWIP][0]) =3D=3D 11) {
+               pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
+               amdgpu_gfx_off_ctrl(adev, idle);
+       }
         amdgpu_dpm_switch_power_profile(adev,
                                         PP_SMC_POWER_PROFILE_COMPUTE,
                                         !idle);
--
2.25.1


--_000_BL1PR12MB5144244F27BC7BEBC1C0D92EF7339BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Graham Sider &lt;Graham.Sider=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 26, 2022 4:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Sider, Graham &lt;Graham.Sider@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Temporary workaround to fix issues observed in som=
e compute applications<br>
when GFXOFF is enabled on GFX11.<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 37db39ba8718..0d764c15f6bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -706,6 +706,13 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev=
,<br>
&nbsp;<br>
&nbsp;void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool =
idle)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Temporary workaround to fix issues=
 observed in some<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * compute applications when GFX=
OFF is enabled on GFX11.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IP_VERSION_MAJ(adev-&gt;ip_versio=
ns[GC_HWIP][0]) =3D=3D 11) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;GFXOFF is %s\n&quot;, idle ? &quot;enabled&quot; =
: &quot;disabled&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_off_ctrl(adev, idle);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_switch_power_pr=
ofile(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_COMPUTE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; !idle);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144244F27BC7BEBC1C0D92EF7339BL1PR12MB5144namp_--
