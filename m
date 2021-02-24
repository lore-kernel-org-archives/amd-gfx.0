Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 05:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3772960233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 05:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3772960233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F3E6EA55;
	Wed, 24 Feb 2021 05:41:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6686EA55
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 05:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyusT+SX/vjX8zi7q/dKQ1mtqJpeTYTswk2zjLJHANbppx6s/Nso0zDIP97cckP9wCGf11/30jdYRASr3E6tz/2owxjCnOqYFglp6vGxkvA464CP3J8bfdoj+OU0b4kPEwNLSKNVJG5orBLjTE6gdAEWrZ/TBaW3PnOt8gffjLf04cIOunZ9tiWXu8L8f7q1bNS4kCwvX7OBD9QLp43iRZmTdMuAxqP+m1qXPLTObmjxKRenXjQUpLCBpTlvmairiOuGqeW5N93i8kGUvDQjmVwqqMlvZH7Z70z8kvIK9xqzKxoBC152+cd3mWUOC/cIqfB80yHs0hyX4WwLPLuSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k68U7Q8Pr3Wwj3b5jf0m7sInFlbKh0lMSzt+tBFireA=;
 b=C5YKaWiI8tkVngrgh+U3Z4xhbcWHZHPLTc23XnQU+8MigJ/77Kjcy+rwqx3XYH5wtVRvWd8ZJAT+bs1gBjboL1g8GU8wdHQP+ROoVxDLakyFb9BzMbwyTSO4FDTpRqRURfVZbK+Pg8CQr0dtvVU1WIdicerKFWFNHII1u/Pzgka1+IQLMnMDfqR76xAZpcZsDqFXoTOLIRT8lWeh0ztDtsV1TkIjXhylJ2GApJMTa7OoXP2H+JPcd7Bfa1Dy0XBmrLQ/5drZ9LzS7QcWywMGI8BFo185yEwapfYqvotFz+fXgGpOsUg3tVJjSiAmqcnEMRlc+mCXtXY9UYT0jA6LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k68U7Q8Pr3Wwj3b5jf0m7sInFlbKh0lMSzt+tBFireA=;
 b=bjJw9LmGycbwGAnhXaMhXj6rdF8MghiPy2G8oRZG6f+cKIy732NtGZ8cictmrEb4o9JbxCpEkp2c16h5hWg72nGS8qtIXXkSLRF33fOyYRPu4ff6YKNq15Y0EWLWIUkHEyBX+0rQPT4yFnmROtD53d14Q/4pa/R7904hYhSjPVs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 05:41:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 05:41:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh
Thread-Topic: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh
Thread-Index: AQHXCm6dMM9mt0X5LEK6Nvd+htf0XapmypEk
Date: Wed, 24 Feb 2021 05:41:49 +0000
Message-ID: <MN2PR12MB448838BA028CEB21D263DFFEF79F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210224053319.29985-1-Jinzhou.Su@amd.com>
In-Reply-To: <20210224053319.29985-1-Jinzhou.Su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-24T05:41:48.477Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1002c8a1-90c2-458a-dce0-08d8d886e15e
x-ms-traffictypediagnostic: MN2PR12MB4829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB482910AB4D2FB8C96E625701F79F9@MN2PR12MB4829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wI/ucwT7/Nb1YlVICcqxRm5xhOIg3DJnn805qxr2fp2hHa9SkQcBQs+3IKx8eUqTnJPF3Sgc2gJHMdUIf3BPeAPzGMBe1EN1FyqIjj8X6aiej5OM3oNVDSLyebpa9IVWPcyb+67mIioR2ysqkIlEHAezka/JXSG3Q0eA5s9sWtdagPCAci2vqzeU7ruaaWvhB/iLJm+LEMMv3gkQYGH9bj5hdedQqwupmH3g90dbPNBiSRxkbm/eikjzKBHRy2gpP1Qhn0YOahF7gwbmpe1BVkMq16nfAwTlFbM4xaa23nwcOEuR1r7gq+t4EeOyvK1DDHcO+p0KCwamD4IuZ2Mm27pgr6OTXSfjZfNCFa2xtzh7XgCvTDAs8CcOosknF+zQh4mfqvC4cueTbozKd4KNusi2qrtk6bARJ9SXl7bXhEXvdD4lqSxUXLExsIZYeNJdTbNtq3YKvS5rVXhZyhy71z0Cycp2sFCA7xNjH4XagoPY7Xqz+Th7jlxgNNUAE89PJFf3gB6h+s6g8zuHUOAi/rbkS+o/BA6Z3Za3lzYneppRWPdqqlnIe/JMcOSvcKlO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(76116006)(66446008)(33656002)(966005)(86362001)(8676002)(52536014)(64756008)(5660300002)(66946007)(316002)(19627405001)(26005)(66556008)(186003)(66476007)(55016002)(2906002)(8936002)(166002)(4326008)(110136005)(45080400002)(9686003)(478600001)(7696005)(53546011)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Hl17XrIqRaBvxc7lwti2CIHQT+uCCd46NOzRU3uH3vASUWtdb82IzleWwZ0C?=
 =?us-ascii?Q?Soi5ViVCuQ1dLC0XK1ZzxJDiVU+uD12Mrne3NOIxVmiF9Dr4qU45ySMDCiR6?=
 =?us-ascii?Q?sq/cN4RQnDNstaCFhzALGh7wzOCyrRm2HUi+/wL4sB2FMwP1Py5uBRDqbb/2?=
 =?us-ascii?Q?c1OQA9GuyaqA/bAuK8TLkTDkMBVLD4+0JbE3gsHYxWhBGCfPWEbqGIsmMyw6?=
 =?us-ascii?Q?UVFgE1VypDa4s/Glq7dBFiuK9o8aZUafB26HDn9ey4l64Dh3zclidxZQ7HI/?=
 =?us-ascii?Q?BthsuK4J/H2nKhVHqrqQLXgWq2Gtzq/aTJOa5I2aSrz10I7P6Y5YM+8lAlB5?=
 =?us-ascii?Q?foEPQFXk5mQ83SDakVbQ3NdMaHglpQjXgo+QeDt3pSIBohMS1e4IsA3PzRFS?=
 =?us-ascii?Q?6Cx3Ri/o+yhTXMJ97ETA3iQ8GGCjkawQg/WHVrrIB4U98OvsB2EVxzqnKZlV?=
 =?us-ascii?Q?nUkbD008y+xJ13/Qrlm7r+Nujx3houYoMRBNXG9eh+iac8+HXvn3oN98OHoc?=
 =?us-ascii?Q?ly1qquVzqyNTYlfZcz79odoNSGyHSd1HfZWCxedgSdGTJIPiIM2eZzRkKIF3?=
 =?us-ascii?Q?p9ytOEjbra5s+E5U31KDrUZLxZQIl+7oNhOtk3YTDlq8dZWGeDZQCckZciPv?=
 =?us-ascii?Q?14umi+hjCuOX8IhBSg/iNiTHLosaKnArotLlodTWtDE0nwECgUIu+DqukUN2?=
 =?us-ascii?Q?D3X4eXmBHGZoOB380TAFHn6DjSUL5SFVOJpE+UrE6ITRTforizYKZp0akOnL?=
 =?us-ascii?Q?M4zkB7smaQYRSd4hq+DM+uR7ID4vC5QAfLxxaXFTPyu33/akFAN7FzioqBDM?=
 =?us-ascii?Q?Biz84kEVawsxo8Skg2g6qZgkfMuRbxGoQBsh+YL6b3vFNW5naU4mImjAwr7y?=
 =?us-ascii?Q?18vNX2wzkmNP4Hxi6EOZd5IsUUYu52jwtNtHpyKQ+WLBT1gKzwx5kXvX6wDa?=
 =?us-ascii?Q?6XeDuy+WtB/YlUdZioR1rM8zqay5NDuyMQkMhyAeFcYuPkWyeN72DxuwNv69?=
 =?us-ascii?Q?wfFbpA5UXRgA4MIGNFx9qwXmbBrM5uhtsaf3oa2jMujP79/X3r+RbIp8bhce?=
 =?us-ascii?Q?eBEc7VDcyq9B7WqLKtcIq3a7pJ4Ihp1mBYdmM+NWvtVMW8uziZkLkHI5F5fA?=
 =?us-ascii?Q?9WhdPX2HCqBz4Qsqt/RyMWZL/aqUg4Eumc2BSlif6g9sulkwyXDwLwDkOX9N?=
 =?us-ascii?Q?lZlPTRM/29o+1kyigVUG1/KAs4wnZDv92IXDN2sQ6wIQKZ/E0Lk6DmcMv/vn?=
 =?us-ascii?Q?dg7PbroaJtCmmmkwGP1tx5XQfuiLPnuqIfcLSgwu6Q6Xf0QG95PV7XWjPUyV?=
 =?us-ascii?Q?2m0PebaQOyLY8l/wV6Pnx+vy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1002c8a1-90c2-458a-dce0-08d8d886e15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 05:41:49.0376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP821OFMd2GVYBcmQp+kYSj/R50Yg+aq6MEwXrwY8SzVkEuokC6LvuD9sFQt9f9vbSTIbfOXWOvn3B271x+QXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============0442118786=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0442118786==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448838BA028CEB21D263DFFEF79F9MN2PR12MB4488namp_"

--_000_MN2PR12MB448838BA028CEB21D263DFFEF79F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jinzhou =
Su <Jinzhou.Su@amd.com>
Sent: Wednesday, February 24, 2021 12:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh

Add AMD_CG_SUPPORT_SDMA_MGCG for Vangogh

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 160fa5f59805..393a0d5905ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1003,6 +1003,7 @@ static int nv_common_early_init(void *handle)
                         AMD_CG_SUPPORT_MC_LS |
                         AMD_CG_SUPPORT_GFX_FGCG |
                         AMD_CG_SUPPORT_VCN_MGCG |
+                       AMD_CG_SUPPORT_SDMA_MGCG |
                         AMD_CG_SUPPORT_JPEG_MGCG;
                 adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
                         AMD_PG_SUPPORT_VCN |
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C791e8418aa8f4ff6eb5708d8d885be42%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637497416235253073%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DAjm4v5%2FRrbMGO1%2BbUGHByfzI3%2Bb%2F8GJY7hnIt6FHzB0%3D&amp;reserved=3D0

--_000_MN2PR12MB448838BA028CEB21D263DFFEF79F9MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jinzhou Su &lt;Jinzhou.Su@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, February 24, 2021 12:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Su, Jinzhou (Joe) &lt;Jinzhou.Su@amd.com&gt;; Huang, Ray &lt;Ray=
.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add AMD_CG_SUPPORT_SDMA_MGCG for Vangogh<br>
<br>
Signed-off-by: Jinzhou Su &lt;Jinzhou.Su@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 160fa5f59805..393a0d5905ab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -1003,6 +1003,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_MC_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_FGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_VCN_MGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_S=
DMA_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_JPEG_MGCG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPORT_GFX_PG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
G_SUPPORT_VCN |<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C791e8418aa8f4ff6eb5708d8d885be42%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497416235253073%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DAjm4v5%2FRrbMGO1%2BbUGHByfzI3%2Bb%2F8GJY7hnIt6FHzB0%=
3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;=
amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C791e8418aa8f4ff6eb5708d8=
d885be42%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497416235253073%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DAjm4v5%2FRrbMGO1%2BbUGHByfzI3%2Bb%2F8G=
JY7hnIt6FHzB0%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448838BA028CEB21D263DFFEF79F9MN2PR12MB4488namp_--

--===============0442118786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0442118786==--
