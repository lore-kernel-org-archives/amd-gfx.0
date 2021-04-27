Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859EDC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 14:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4307261151
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4307261151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AAA89F4F;
	Tue, 27 Apr 2021 14:57:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDBC89F4F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 14:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIMXZJTDEl0toKmKa1VoqjR0Xl7lDv9Q2tAPUv/NwsjTXn/rtNuZSXztnx3WB3Gf99+DVFuE6HiwEKcaHrFhmUxHxFI/SNSv//42uJ+J3zmP9M8e67WwIuD3HKZLZvbRWx4azIfWav/J5muS9i6ohyClEXrKIDLjUUwVI5TjL89K1X4U2w7XGwKERjhrTTUFgJKPI+27refu0/ZahqTwes/T4xAljfJHs3oNywp+IM+/fnX6djAqBmPEeXAEFfJdeV8UVulUoOp9mh3/t88225sxIAVG4eh6kTqHjnGzsIxpTWHfi1p9zTplcK9oySNexRR+cHILFqZ/USjq4uSXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ/l1U9B+zM+FQKKr+2HtcRbLfn4koM8CGbXwdNmpMY=;
 b=XkGmfjknGI8z9vJbOMm7YlRT3ix7ysPOHNGxHT3nZxt00PmrPGnHy2M9FvDA3QEBcP9h6euJ3KmUAIH78P1WMl+wmbGevOpk2L37w5b6nb1dWtF/9WyvlmTufBwjFkKZrd0r+1CoeBT8vpTQGfWaYX3ZUx3I7mHCYpuAk3gn2UM5rLsU1GC1lw1i1XWz8BcneTcigQEvXDIXpWpLj9rzdvrx+6YAI+O+1On42Id2cEOM3xFvf+mUd9flXlIRKZGDLhf/6lB9+txI342eIy4pUMiQQLk+rpBphnU/Ej4VgUC4P1riGH4fEPlkpkWaXfaz309jzfS8v7MJvgEw3Lhu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ/l1U9B+zM+FQKKr+2HtcRbLfn4koM8CGbXwdNmpMY=;
 b=jOS1iEFfgcPt/Y0cRdKMRI0kk4CRBQV4EuSag/PQFt4QIgOyOUGYIlZEhfb7ERfXtSTr0IdVpsTmHBujNYEMjzEA3Xh99ChNmoPY3L8VIAwpMUJ0A6gJ/vhP2vJadD+f8sm6I6Vw6i5jToRfeFLklxIxGHOKFDQX03B/hgUOzX4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 27 Apr
 2021 14:57:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Tue, 27 Apr 2021
 14:57:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix r initial values
Thread-Topic: [PATCH] drm/amdgpu: fix r initial values
Thread-Index: AQHXO0vuPJ0jl94WDkOIoI9T7G0kI6rIdF93
Date: Tue, 27 Apr 2021 14:57:18 +0000
Message-ID: <MN2PR12MB4488D7C365003DC156F19DCFF7419@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210427095838.10865-1-Victor.Zhao@amd.com>
In-Reply-To: <20210427095838.10865-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-27T14:57:17.995Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21ec5260-657c-4c2f-9456-08d9098cc0d5
x-ms-traffictypediagnostic: BL0PR12MB4738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4738A97F06CEEA5853841B48F7419@BL0PR12MB4738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1UfDyEJBQgZ2h00DivnTink//hYmaRcexy/ocdgc3KKKPIV9433zaVBX0rYq7KPC7R0W/pGdmvTf0vxOL//Laq5pqN9HATKnjJ2jHCVe+MsVPYG75LOe3t1dZ3wWoR32sMrvIq8SgYGeDNRj7CxFtHPQT9Fk4EgGRYfYnxTwk2TsLse4GFweHqbB47BtrT72m78XH90kzGmsk6cJdcowWjMKjUhO4ErDS8zLVbZS1B9bQICtzbqSd87UASFosxDI/8TyHLn23tRl44mOp4BrXWxeEHHomq53dloNIIl0RJilDtDGo1Dl74Jhh+N8bnClLisalisDWqilPql852VWOjxAQgvEjFxNFjwbg4hgEsFTWhrfplSnU65JgVAGlI4wmeYRI1URrl0gUNf+YcxRm3NKbYyjrHlOj1kZunrtKUhRgBsjnJW9tJxJqkKsSIv+ofvEJHVFM+igl/dOeKVGfmioQjmfYPA8dLZO3ZgVTJDHEjpnt8q4BF6LP/7uXP/3vEn+hTpSD1DCu/ADKtns2VAua5KFqBMhsKjwdH11UlI3/pG3JYwZ/qh3pOADmQInFmv0sSwEnT9AHoP9ErQ1fU7MoVIpGjhPy3vbwwicOeTqZzzWo5yNsxVR7DO8Q2CPGCOW623wrWP5K25u1g94w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(19627405001)(478600001)(8936002)(7696005)(45080400002)(38100700002)(122000001)(2906002)(8676002)(110136005)(966005)(53546011)(86362001)(186003)(166002)(316002)(26005)(52536014)(66946007)(33656002)(66556008)(64756008)(66446008)(76116006)(66476007)(9686003)(55016002)(83380400001)(5660300002)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TSh0BPSgXfh/3F+l84iEnvttLpDRxtBEZ/mbAz4lozkTwPX6m5crvbKDJ0W4?=
 =?us-ascii?Q?Ou/HfS8W9nnkh/bEoyhKY0HaL5luqdL92ZFY38x/4jfASFFUsOf8bSrsnxsu?=
 =?us-ascii?Q?fMd2QMHSIYLbZj6z3Yn4U5DTnFB1YrWUjaJaYxz7SGGIlGTqoshQaS5r1kGD?=
 =?us-ascii?Q?YQCFZYMPKLuNJrD0ghKQkNWRra/YpOzHZkrEnVRNAEt7NUzM8GfEoe/TfkFi?=
 =?us-ascii?Q?o+rd2Vd163C7QrjUVuV+3aIWZFLgJVa9ErLpbcNMnP8lRcLdga3eTqBLC3aK?=
 =?us-ascii?Q?ZTKFTh4/jnC8arYSw6QexKB3zp4slWMEyYj4ZoGCGsR+jIj1z/xNLBXAv7uM?=
 =?us-ascii?Q?XhzL5qmnwsoLtbCfm1bw6mFgpcw36zQ0YnlYgIFfYzR46DA6yjdqq0JmKF58?=
 =?us-ascii?Q?KQlLQD8zxmaBEMARbAYANuOFTbyg65Kee/o0bUBXMJzrz/eYPtBB4XYc4WxB?=
 =?us-ascii?Q?Sl3ez2uCPWmjzqQm5Hf6nwv9VDj6Zl9IvRitijMPQ3jcwDSHAaOLzilaj0dm?=
 =?us-ascii?Q?o3+ly6P6u+x45iJbBB3S2GvCWHTO3Fmt64P8b7y9toy29wKJBF48AtGPALqD?=
 =?us-ascii?Q?8p1otHykTXWPcXZm/Of2SD/gvu47jWgzkbz70g7+9EFtk9XNtSdwbvQd7oQK?=
 =?us-ascii?Q?qQatethhoJd55Ex+hCFpfbLd7tQSeUnko5VmNa43QR35RH/lQcVM2Mb+DinP?=
 =?us-ascii?Q?4gBRT9y4SJ/5LZp76Ip3DigwT6eDg2gZA55p7iXB4po+kVxLMBWeAkkuXBbH?=
 =?us-ascii?Q?XAiaMxd1qEoz9C8YbWCCJ2AbaV9Zng1FDSlhXzExuyxv/K1UZv5f9fz27Bdu?=
 =?us-ascii?Q?QYxDEvVLFPqY+4qaLDFDPL6BtSM1WqVJuI3PuCyqrnOD5wwvoXeINdl3DeHA?=
 =?us-ascii?Q?JqXRjZOUtVINm2V/YQiEZa7ruubyb6u2CE/PG+rt5Ul7dIFv0NtkyY8vAOhi?=
 =?us-ascii?Q?tsrVy4uusdOCQtVgVwHX/p3QWhQrLxcWBEb30DdbPKFduLp+ROaVc5Yrt0DY?=
 =?us-ascii?Q?iwiAtrLlMHOmxsiXDenkPlJPAyn15wnVqTv+N+an2da38GGrVn3dUzW8hDrE?=
 =?us-ascii?Q?r9Dwpe+cYjtV1u0L22KTlOL5fcJ2Qv97nYF9zElTRCIhLuGl/fyJmLztr8W+?=
 =?us-ascii?Q?NlBwzSi4oCus4yXGq1aJpjzRinSgtB78Mz6T8h6FK0ATbIkCp6n9nxmqCsQ3?=
 =?us-ascii?Q?fn13Sx1ZFzQ5kkGTMdI5R8YoX3gdwSXin76abqSXvZrCR0HGpR5gacw+q+Qq?=
 =?us-ascii?Q?eBQQ7q8cnEPRc0kV5j6YEVqNP/iXKkR6NFIr+5eIzwguNC7O5mOJvbM2VDw/?=
 =?us-ascii?Q?dwED/RBhBGrHAxyIq1hI7q7q?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ec5260-657c-4c2f-9456-08d9098cc0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 14:57:18.3844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 534/XPgdL0p6qddpIEh3/ETsiMxg7Mcj2pxia+FuIIUbOpXuijqsr58ux4021Nh19LCKzENoNHtwGxvxw6fdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
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
Content-Type: multipart/mixed; boundary="===============1012287359=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1012287359==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D7C365003DC156F19DCFF7419MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D7C365003DC156F19DCFF7419MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Good catch. I think we should probably just return 0 at the end to keep the=
 semantics of the original code before this was broken out into a separate =
helper function.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Victor Z=
hao <Victor.Zhao@amd.com>
Sent: Tuesday, April 27, 2021 5:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: fix r initial values

Give initial values otherwise sriov will get suspend of
IP block <dce_virtual> failed

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 0f17984fdea4..36fdffd103c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1384,7 +1384,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_devic=
e *adev)
         struct drm_crtc *crtc;
         struct drm_connector *connector;
         struct drm_connector_list_iter iter;
-       int r;
+       int r =3D 0;

         /* turn off display hw */
         drm_modeset_lock_all(dev);
@@ -1431,7 +1431,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device=
 *adev)
         struct drm_connector *connector;
         struct drm_connector_list_iter iter;
         struct drm_crtc *crtc;
-       int r;
+       int r =3D 0;

         /* pin cursors */
         list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C9611bd0b8cb74a8ac81308d909631004%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637551143345597240%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DokT4wUuJysPl1Fm%2BtdHtw4VgXoLJUhir%2BTa6Uuqpg20%3D&amp;reserved=3D0

--_000_MN2PR12MB4488D7C365003DC156F19DCFF7419MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Good catch. I think we should probably just return 0 at the end to keep the=
 semantics of the original code before this was broken out into a separate =
helper function.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Victor Zhao &lt;Victor.Zhao@a=
md.com&gt;<br>
<b>Sent:</b> Tuesday, April 27, 2021 5:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix r initial values</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Give initial values otherwise sriov will get suspe=
nd of<br>
IP block &lt;dce_virtual&gt; failed<br>
<br>
Signed-off-by: Victor Zhao &lt;Victor.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 0f17984fdea4..36fdffd103c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -1384,7 +1384,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *conn=
ector;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_list_=
iter iter;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* turn off display hw */<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_modeset_lock_all(dev);=
<br>
@@ -1431,7 +1431,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *conn=
ector;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_list_=
iter iter;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pin cursors */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(crtc, =
&amp;dev-&gt;mode_config.crtc_list, head) {<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C9611bd0b8cb74a8ac81308d909631004%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551143345597240%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DokT4wUuJysPl1Fm%2BtdHtw4VgXoLJUhir%2BTa6Uuqpg20%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C9611bd0b8cb74a8ac81308d90963=
1004%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551143345597240%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DokT4wUuJysPl1Fm%2BtdHtw4VgXoLJUhir%2BTa6Uu=
qpg20%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D7C365003DC156F19DCFF7419MN2PR12MB4488namp_--

--===============1012287359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1012287359==--
