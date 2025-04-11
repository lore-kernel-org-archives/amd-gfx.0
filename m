Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC267C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D29610EC21;
	Fri, 11 Apr 2025 16:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yEut4DfD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77A110EC21
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6iJa/CvsvOQvQDJMzlxCb58THwMWlmDeUofkF4yBO0I2H3FwIfU51h8Q2cdiUJrkGbNeY6/9G1bxX8fs8xx1z/g9Q8nNiel/yJaoTzu4MqoktGRCDYj2/6+pq7CM4RlanaQphCAypdUSFSjvT5tiAcxT3HMimfcZFK3uqKZuEqm/yPOy+eeDzl2hSxjh1HXn1PVSd3GOcHZs2e4qxDJmpHQjaYKOuA+Z18rq3TMwuRgI3QFcef4NPweALlm6oS7u7SthrbAwABKpD4BfBsWQgtUL8nAGA5CXsjoZOPBbL6omfadFJVbnyziczVSawgxBcnjQKSr1EFVT6Uywbv8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/mGtbwa3xCo+XkTKmjY+Oabq0HlogMml62CBi7UTg8=;
 b=BAego67IHlyIgtxBCocYWPodUtpCBiBLvSF8PM52L3PUS01KcEk6P8NML939/OZLIMmhJDcdtyDXCx+Gekw9lI3kKsxSxanRwOVrR3wnCXGmmJ9YgWlDL9G8V3MRDMdxHVnWAmQtTtLrNzoNpLchI7KjkIw1IzU20LtnLvSoqrUOnGexSBY5aeecArKkgVgJ7YQwjeMCHFYEmEHJ9XQKt2+U3+yMCu6+jNorZDh95bFBM8jhP0CBLAN0pQPQOn1FZz5pZhkwCdjnoCbxYAeg8KmvdAL5J5xukpI+tWo0ZIN0GoE9pVelxv1MyUBZ41o0EOsz6cbi5enyseHd8+1t4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/mGtbwa3xCo+XkTKmjY+Oabq0HlogMml62CBi7UTg8=;
 b=yEut4DfDQa7fgic9+lWNN6jo3i2eTD+vAL9dhTq5POu2qOuWI36G1BVwcwxVz7pn2/ULVs7H7Xw/DFQiOax3gTAScReOK+Sec6lxSDxEBc5+axlSOufbga1b4eedUOVjhtEqSUTK3GutRMTQytAeFvk3s9kl+Clp2H6QdtXdXKY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:34:33 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:34:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [v2 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0
Thread-Topic: [v2 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0
Thread-Index: AQHbqFAW9l8SGk+lh06+IoHOztLb+bOerkls
Date: Fri, 11 Apr 2025 16:34:33 +0000
Message-ID: <BL1PR12MB5144FBD607DE33DB6B115918F7B62@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250408063245.2270202-1-jesse.zhang@amd.com>
 <20250408063245.2270202-2-jesse.zhang@amd.com>
In-Reply-To: <20250408063245.2270202-2-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T16:34:32.728Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6310:EE_
x-ms-office365-filtering-correlation-id: 4ceeca7e-8139-4ec5-146a-08dd7916bd75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EOZT00oTioavQ2k9oZADah25nTF6N/KgSB+gMH8B2DRkbZoayX0QPezK7h4z?=
 =?us-ascii?Q?hyDy5EurNC44idQbsSxUKrX7dSlZanSeG23ywTEN3iu5kcUzYoS9GsyJVjAI?=
 =?us-ascii?Q?Jw5kPDeturfl/XtnM3gfw1j9Yn1viZkKWxHfJWlJNsbk55hsRki2piOEoWiL?=
 =?us-ascii?Q?P637QpMXAASrliqMmyTOR9IiMmCP8LtqHtAzoEfYxekmLlpMLLEUFH321qpR?=
 =?us-ascii?Q?SGhVmMo/2EwdvGgAcHGql2YupR7+qHijtdHPqMvRrbm4myftgouLc8IsXVnO?=
 =?us-ascii?Q?NIuwPhPlNThZYTdDRwvIUSR6e7H4egs+hq+eigKbMn55Fo6RvZiAtiBW9h2M?=
 =?us-ascii?Q?abC0iy52C1fRNqov4rrcF86PKC3wveJHh0QSXwgsz/5dSNipfJGN7STX+bE5?=
 =?us-ascii?Q?M3TAFvlVzurR4lWzNwOi6PmV34KvVyWX1e0SNVWkTOUhljVhjiGOxgV8Q4I6?=
 =?us-ascii?Q?JZfTkm3mNaqxL6eVLt4zxnxL7huQBG1DjFRFXsNFP4MKhjU1bkAdV81lsjGU?=
 =?us-ascii?Q?f+ddsW0Nvl4LX7CyEQ8DamdzfvpGj4SV+tabMPqqoJrbcjFCXKB/6jtEk3CJ?=
 =?us-ascii?Q?R+H3HzSXFSXDou59nTB26QU9J7FY1WxaQHSXk/IjFc+ByNkDnSurgT75czyO?=
 =?us-ascii?Q?X/KrG5FUALDIyV4y9NgHep8uzsdu8Yg0MM2epYt6ywnV5Y9EWVMwxkxnSFNh?=
 =?us-ascii?Q?GdSCuy2azIAhcbdSsbi+FfZnp2+koNNjbcoKBBtYUyx7TV8yPOJOJob9ro4o?=
 =?us-ascii?Q?Udsw2vnqq1NCEoUI0mzflqmf9Pa0SVaPLwehYeZfasBvLk/CCo+54drjBXY3?=
 =?us-ascii?Q?0ZdTut34OZ19xRhsIzPn9FZ7cumDJsEM2glunVVlitcG08s96De6FRJoxEV4?=
 =?us-ascii?Q?Hsbb52MyadU0ndlABsjr26IUvbGBB8QWbh5iC8lOxAP+GmEAoVm+XtpZCLlZ?=
 =?us-ascii?Q?G1Z2wo+aynXsjYovKxmJ82xVIPabbkEeGfl4q0VoFImismFs9j5kySat85lQ?=
 =?us-ascii?Q?wxZ4HWg1y1HN94ECuPf+kIvLTHuXufiGDhLWXKcfAWGHmhGlUGiQn9RHEU3w?=
 =?us-ascii?Q?cAKGgNIJcH+Tv+7oj+M62CXZCnKWtdIT093MqDfla0skLZFFi/TefXl4h5cX?=
 =?us-ascii?Q?lrkq/u2//KTVmgrsrzfdXD6awnR+WjdLIuX0nPs8dmgSVM4x2+5XjIuEVUOT?=
 =?us-ascii?Q?RBvqBWSya/1xMby3j0YyCNaFASPlwEVdVMV+sg0kP7tsukOdwbHJWsQWAF6F?=
 =?us-ascii?Q?OcNvGhU7aS8NF8CtEuUJ8obf1s0oM5cbFRBJ4A4qWrGaGGVVxvl1IZ8qeRQD?=
 =?us-ascii?Q?ntU3Y3IMb9scGHO4m9Ffd3p1j3M653GtCK1FEdvGhnLvTlAm77w4mn7x1gmm?=
 =?us-ascii?Q?Cd1IjvWNBlO62GU5oRdUMg9pjkP8PudUquvR3DWDox0EJ0OObTdBsE2sQDdT?=
 =?us-ascii?Q?DrEsL2+WMP2xxrPh08Bi75JEJtZWjsvowku6ideJGkzWNX3Hod8uVXxR9XrX?=
 =?us-ascii?Q?5l2com/TYXWEbT0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UIVDnb7u+kz1OkOwAYHW4iIrj9CNajupe2nkabMnXyctEkKRNUUTge7L5tcn?=
 =?us-ascii?Q?VAc3uxBjYjS39jdQbrLJft+kfxxwSpCEXFMshMLXrNoitKI0S3xePtdsUjLT?=
 =?us-ascii?Q?WOFXpqIzXbdvNSYS1UF4cWOo02C/lP7Xzx3dbqH77ZRrtwCJuwHyiG8X009Y?=
 =?us-ascii?Q?mBGWv4cNy1u6kWVLd3dw1NgoZB6k3qwNflLgJ99My3/7AMf0tynqs77/dZgI?=
 =?us-ascii?Q?XCphr05yFuZb7IKaNRtz9v4FnTcqZVsP/GbLLiR/eJOm6/YWl2g9HatdiX1Y?=
 =?us-ascii?Q?x9DvjMwhuKlRtHfNo+Nt/D5NknJkPVkZNnUfFoqkYqK6HxNs+AeJ/WxznGLY?=
 =?us-ascii?Q?HcA8xYD4O9py8qUbKCO6bV/8X5aoljDJp2A2czL9sQNQv1xKSgyT9nkUVNer?=
 =?us-ascii?Q?n7Rj/MvBvDHoeSmfIKOx7Et4c99ACFqkbhc7QprvVJF3lOh8TQKHqJiYoIFP?=
 =?us-ascii?Q?FvgyXL1cK7XTn5vd+otl7mdxeDvUvxg+aPs8fn/xIIuQougTcSbxxbuUg5ek?=
 =?us-ascii?Q?x2wc89z4lCvWAT74MEgmRQawBFKP+N7T6LL8FjY60iVXqpWNnJbp9kZQWpHg?=
 =?us-ascii?Q?ti/p2/UxfY1GZBjWdKybKmr0ormFcyLNk1hg6kMI8crMUMQxEyXNsI4F1mIH?=
 =?us-ascii?Q?v74oZxuj9fISnuER3+J3/8AOBRJBL/quh65ZLG4VevNLIuGAkxg1XQDb9hgw?=
 =?us-ascii?Q?t75ztuoC8kGkof2JyR8PJVkyi8b/QlSFfZWtRjAc5Z8A5Dy1J2LnxxCkiIaM?=
 =?us-ascii?Q?fYp4C44tlzc9yELUY+tGcnTxQWmLVOfVSzECvwtEC36V0qI2xXaWwvkuonVi?=
 =?us-ascii?Q?rGyEtpbD/TiyTAaqq191JcfrmH1iwMikT+eZWvggjO+Hs8O96+D3ee496JFe?=
 =?us-ascii?Q?XlSTa1QcIrvbP7B0CLvbuyIbXdL9Apdh2cdp0NpeAES3UdGovKoUimR6RYU6?=
 =?us-ascii?Q?UVkLX1IIl2baOctmPgDu27nt9qmiDj0o97/wcVZeH0OJg3iGJvLYJLPNO57a?=
 =?us-ascii?Q?HQ2shrNmYAtM5qAiK/ZbuVo6MpjVlEXDUe//tnV0+UGRdyHAhoBNVovpogTZ?=
 =?us-ascii?Q?11o3fcHSIIAAnEwxoPIZcp3ofQpuBRUrwbGrLeV3uf3F8gq+pUH+ONtYUChk?=
 =?us-ascii?Q?6RzJmFep6KUYZLD+y41Fe+yKCJVYd0LWj8C1QusRC0RnUYZYRHQdU3qxLvy/?=
 =?us-ascii?Q?/lG8MLcON5MAZlXiVRFM+uYTKmKYNZQMQGBGnu1ta7ViSn74eIPkxH/emD86?=
 =?us-ascii?Q?KUbKS1LPRYBlycMkc6sxVlT6sow438yYn5O68cbmL7v7o9ZPinc0Wb6f6qYH?=
 =?us-ascii?Q?LBLZCfCSjEzYpMwypXGPl7KgCaQi3rpPo/3dBRPlb9SEJoK6HDVnKsuzGpci?=
 =?us-ascii?Q?2T6hbD1YcO14l2ko8HPwF7WQZJEeoCYshhsYpe/DuhyU1R0OkX4avX23gPqa?=
 =?us-ascii?Q?109wu6vkyyJ0DA/3ekgw39G9H52PCwdUjVdTI5cyUOA1nbj6x9wntqxlKgKd?=
 =?us-ascii?Q?QDDmGz6pqVRn/bRGTLYR033TOuTtsbLUb3eaOOMtFR+sk0bkSrjE7HGiBlSp?=
 =?us-ascii?Q?I9QoiBGLR6SDQsG32BU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144FBD607DE33DB6B115918F7B62BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceeca7e-8139-4ec5-146a-08dd7916bd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 16:34:33.1033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrzGuKKCjSMCPXHJB4jRFOSCXkjzXh9Lj849+g8EtiIWiHCUOHWSda1kKNW+9tk6lWEBYNCXAJFMKQAAqPEo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

--_000_BL1PR12MB5144FBD607DE33DB6B115918F7B62BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

GFX11 is a dGPU.  We don't currently have a way to deal with migration of e=
ncrypted buffers to system ram.

Alex
________________________________
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Tuesday, April 8, 2025 2:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Lazar, Lijo <Lijo.La=
zar@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>
Subject: [v2 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0

Add GC11.0.0 to the list of GPU generations that support TMZ.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 464625282872..1eb9242436ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -843,6 +843,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
         case IP_VERSION(9, 3, 0):
         /* GC 10.3.7 */
         case IP_VERSION(10, 3, 7):
+       case IP_VERSION(11, 0, 0):
         /* GC 11.0.1 */
         case IP_VERSION(11, 0, 1):
                 if (amdgpu_tmz =3D=3D 0) {
--
2.25.1


--_000_BL1PR12MB5144FBD607DE33DB6B115918F7B62BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
GFX11 is a dGPU.&nbsp; We don't currently have a way to deal with migration=
 of encrypted buffers to system ram.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jesse.zhang@amd.com &=
lt;jesse.zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 8, 2025 2:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&=
gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zh=
ang@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [v2 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add GC11.0.0 to the list of GPU generations that s=
upport TMZ.<br>
<br>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 464625282872..1eb9242436ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -843,6 +843,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GC 10.3.7 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 7):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GC 11.0.1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_tmz =3D=3D 0) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144FBD607DE33DB6B115918F7B62BL1PR12MB5144namp_--
