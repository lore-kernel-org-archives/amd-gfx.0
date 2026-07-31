Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEA9C54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 15:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3EA810E207;
	Fri, 31 Jul 2026 15:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ybhZfTCA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063FC10E207
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 15:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFu1DNN0bQMmxVntGxiDY68KuB/4Ys2BKnP4xystyfuhEHsLuQD1T+zx53dI30ePUgIb65Tvjy3f2+hFEXK8kM+8CkqRuqYDT1sY2b8zleh/KvR6LLb8todJnL00F9dXH2i94gwkwC5n2D3NBwCV+I7MhNWw2FG1KcdPPGz04Rzql7s9qRJYXyfb9TekFG6NUujyqyaCCXz+2K1y32QIN56uakjnFqaak3kTeQ8EryJbjgg7Gjkc8GHJodntNPCPUhpDHcoAFQ/369B59WdkAzzHpyhdmTD4pkyxsg3R19lpt/BPUjpO6ggHHsi+9brasgg+3eDt2nEKoicu+DSF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzMXfV/jNM1VZMQboVjvvmMviv5Pfuc7Cn8OXQ9myFQ=;
 b=Nh7lsBtxh5V+Bw02w1cjX3IXT/iNCw3Tw2Bw1gbNTmcSuSGJiTuFNrKqazpmDaGrzJFKFm2rfJD+hszMITV18acvBWQtfZoCZf+e5+dXw5oNqFeTGJIsOHt6fSRIxSrOjZtJvmOZl5Cq9fyMIthrQVFBf6MA9hnx1quJDr42ljYpudCdD60iAl3rWGR+xoHzEO8NbJeE5svlX//rOc+5B8AmBiD8kVUdvGX+Iv+SwdLGbv1mOtBBDlnZB1h0+/gKy5QXDzKOSJQYnICQGfSbBc4LFOfLqkibdGt89stmBOupRnc+ePDq65cgB3pLIP931tCA49p1B5tVoKItvjCG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzMXfV/jNM1VZMQboVjvvmMviv5Pfuc7Cn8OXQ9myFQ=;
 b=ybhZfTCA6EiIGK3ILczMeVkhSUo0LZGbS48ZrbIO8QnQ6wAYekoRFFP5pCtaiD+ffzzD2/P21uZ0Nr6T9fYh+EUINUOVFEelpc4e6HzbPumYH2l3s/ttYiEdRIwNEJrxURQGCk4B8yDpvhUkRoaTzOY6O8wyUzkvdtBSWI+awB8=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 15:03:13 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:03:13 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery
Thread-Topic: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery
Thread-Index: AQHdIK+0vMnnOI+uh0Oa0tA5spdJVLaHNmSAgACDdVA=
Date: Fri, 31 Jul 2026 15:03:13 +0000
Message-ID: <CY5PR12MB6345E08E9BA84E8C62475A4DFAC82@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20260731054428.116651-1-xiang.liu@amd.com>
 <BN9PR12MB530691A447278E095B2E7639FCC82@BN9PR12MB5306.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB530691A447278E095B2E7639FCC82@BN9PR12MB5306.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T15:03:12.856Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|SA1PR12MB8143:EE_
x-ms-office365-filtering-correlation-id: d348d012-8923-4219-5087-08deef14d7ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|8096899003|38070700021;
x-microsoft-antispam-message-info: VwffGc0732XiZeH0ys9oTdg8GsA5At4xvIKoesmow9SPzORjVGQQ+dxKrctwyXFUlqopwdBlQMIJ9xHRa5VMJ/KxibCY2rRAjixn6CvkvpmfTh4bnkgiBgwOQAw55hI/5Pyqs2KSs0u3YgAvXKb8Cn/j6/1kuVoN7Z79hdVikUxeBtYMA5QWuO9dDegA3K7xtygVnrO3BK9Own9+EqSDtCGKoXKSS5NIoaqt5WEmBY8CrZMsBypVO74KIOPnAf4icAdXWCrxqOpWjwvhqpgeI+iXHB/dbGCaySUb9h7fNjLfEALluw7tM4NF/YlzuPlNAk1j7mfaqWqn6aXjk269Sngm5t6U1w3NnYVFOy07o3ngISLig9d4ttdqypJy3LTmV19bimUNi8SOlTdiDdWbXRA1f764YgReO1lZ1BxMuqGz/vDm1UUD+qHFCsqNGp+SsAWP6jBXoLLSIVRhqMuuNgY8n6kDIu6HZ6ldXqeUu1EMC4Lzl8ovFybRWboimdCHvoRsxszjqNyp0XnLtAQdj2iD5sicQgqxEEuRunlMJZc7ET3CeYfow39DIssL715F4p5V6pIUYw0u8adZgNfqD8lF7lIEwztXScPsPImgJKqD8Pai4UpoG3FQO8rVuw7x2ZAntAutUT3cbeTPMJlp7dxDPD0gUvGvSF7VnLAiOuxIXob6QRiNULlS7o/EWJ7WfHYw5wkfH41Svh5V4YoQAMNlQL0mQmtrZrw+kR3xVhU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2fweUPLl1VYiX4PHENEKcO703NnRF/ZiVKIEOgwlpv2734NJ0esiTx7VTQMb?=
 =?us-ascii?Q?hdyY+IAsBOhhHKily0B9a3Tp5v/rWKdiFPhDHaLYUHLxVYXYgflOc6UQMwap?=
 =?us-ascii?Q?utK5TrdnyPmO4bs4MAGVj9VZXanoPDqyjtc5jTqwK3ltm7SBPm4+VoJdOdfP?=
 =?us-ascii?Q?IS6/xU11jH9Gl4DrF6xGDmGc0kS1b20hnnVqqphDb4oKchbJdGxeB8XzlV5n?=
 =?us-ascii?Q?kpKHuFuWWVGTDuuuDHOy8RC5eUihVwIyj2CVXgxT0NHtEdlF0o+Y8l8RiOfj?=
 =?us-ascii?Q?HDAXPOatfTR5p87mrfmEo95ER/2WuixuTXA4ScNQBKPj9fW52n6zekzjF7mq?=
 =?us-ascii?Q?3NxKHNzIH085DgY2E2TM9QFSVanwk8uzOHW5d6QeCSZYeeCg62+8jtG1hs7O?=
 =?us-ascii?Q?ZTUHuNYtgTsqDcH1Wr6sq2sfP+NXEqh339t/wNKNydunjafIpIWR5BZdJvFU?=
 =?us-ascii?Q?qdnPSVL4zA1vXB9svL1ld24ltiFLhKnfmPUv0AKA/cHochmY7qBQp2ugDuO5?=
 =?us-ascii?Q?ZOCdDpRmXDhziszCFOVk8iDeUgeZMWvaPZ3R69xyf0Bk7srSCso1hsnkzInC?=
 =?us-ascii?Q?UCnCN/zrwjknV2Fto/SxBVWAthI2oo1ld1eCnXNkSJZkkOGyyS5KKBRRrfHt?=
 =?us-ascii?Q?gCxK6TeulzeKuIkuec9ypjaOmClvmzVBOEnrt5jvDR/8VXBhSfNorBBf68nE?=
 =?us-ascii?Q?dUfxeE7ErzBq44uDV1rF5SWzQZKxFmyzfvrSxmoqTQjq8Qj6e6Dvtz/P7x80?=
 =?us-ascii?Q?cDTi910CSSggNIGrJmXsMOXn2N3hYAjBl1MuwcAnsu4CyCoAmHzfZHM5DisN?=
 =?us-ascii?Q?KAiGh1zApJEvEjnOqlNp8GymLBqWpnPFjO2hXaD8yBXoa3xuXU2Ngf+R3jVa?=
 =?us-ascii?Q?ysj+8vj9+P2RIbxaPtSM4GNB9mPsxzT+iDwznosQAHWAPa41rhDmG/ODPJSS?=
 =?us-ascii?Q?AjO4f8hIA2yt5pDwGd09OjdU7arGmXj+qkzfkl/TSAA6jGPPpDlJznaIFX1U?=
 =?us-ascii?Q?oqa/Ha0Qu6fE18UItYiGFCyRwc1duVmFJiLO9IAUkDcfbMVWxwpRYxIjoMpl?=
 =?us-ascii?Q?fR2CBe4MnyrCHcmivyPWqvhI0JFL8Brez0M1pLksaWV1eU+e+QQxHO219UiZ?=
 =?us-ascii?Q?c7dKLxvVgMgtmY4jQa2v4iAqINsgsKx1c/AayzHGieO1WGuXimUlz14KiAC6?=
 =?us-ascii?Q?ViSz7N26fESvFfVC9bDP3GzeS1tMZYNX7ePvPDgKLSC8xdzzvd4ITX+DA26H?=
 =?us-ascii?Q?3XS/O996WJ+FME0gS7ETN7mn2KrYFke8Ev0hajCucqUf09oxe84bOQwUQuUG?=
 =?us-ascii?Q?9PNnPGDJaWiaiuq7agjzEx71r+MMsYiq0F+KXHENxB/HLqm7IZOnWQMAvAcm?=
 =?us-ascii?Q?Mjwyy830QxfeWpdXd4PSlUgXvACcyYE2DQhW/LkW0XThQzR5dostUZxkPOBu?=
 =?us-ascii?Q?Q0auVxmMbrcpv4neWErSCC9n/+mmoKphrxXwQfKcQyPvdVxTVtOkOr79LRwT?=
 =?us-ascii?Q?tbRjXt2vDm0I12UvGuLti34fkZfSXtV8JEMvzPnGnf+PECryx3EYzJrN091c?=
 =?us-ascii?Q?VCfw4N60Loa/X6ARaVRUkLapKYlqvBTaHR7E2v0JSR4p5FFZvNR7rDEqMOkh?=
 =?us-ascii?Q?+A1A7QX0FWYncOBFHs7kgMWi7rcm3uD1JXtZp22S8gojvjHya6rWc1MPxaiy?=
 =?us-ascii?Q?VXUyyeOwV+4Vc3dzxSILVAKMVmDqYOaT0QRLoaFtT36U3jA2?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6345E08E9BA84E8C62475A4DFAC82CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d348d012-8923-4219-5087-08deef14d7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 15:03:13.3589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vb9xs+DbGCP83tPLc52xyfYASEeeQkU20xcftQeDG12/qF1pl9zSy501sx+1THvgPiy7kKjyU2ImTOnbIau2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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

--_000_CY5PR12MB6345E08E9BA84E8C62475A4DFAC82CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Sure, will improve it, thanks.

Best Regards,

Liu, Xiang

________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, July 31, 2026 3:12 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recov=
ery

AMD General

If this delay is only intended for fatal recovery, should it also be condit=
ioned on gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET?
An unconditional msleep here would unnecessarily impact other reset paths (=
e.g., mode2 reset).

Best Regards,
Thomas
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, July 31, 2026 1:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery

UniRAS fatal recovery reads MCA-derived ECC data through PMFW, but direct q=
uery mode bypasses the existing firmware-query delay. The recovery worker c=
an therefore query before PMFW has finished polling the MCA banks, causing =
the first fatal injection to miss its UE count or time out.

Apply the same 500 ms settle delay whenever UniRAS is enabled before harves=
ting ECC data.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d247d0ad063f..ad9a9545b1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2755,7 +2755,10 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                        device_list_handle =3D &device_list;
                }

-               if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode=
)) {
+               if (amdgpu_uniras_enabled(adev)) {
+                       /* wait 500ms to ensure pmfw polling mca bank info =
done */
+                       msleep(500);
+               } else if (amdgpu_ras_get_error_query_mode(adev, &error_que=
ry_mode))
+{
                        if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERR=
OR_QUERY) {
                                /* wait 500ms to ensure pmfw polling mca ba=
nk info done */
                                msleep(500);
--
2.34.1


--_000_CY5PR12MB6345E08E9BA84E8C62475A4DFAC82CY5PR12MB6345namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: white; margin: 0px; font-family: Calibri, Helvetica, sans=
-serif; font-size: 11pt; color: black;">
Sure, will improve it, thanks.</div>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chai, Thomas &lt;YiPe=
ng.Chai@amd.com&gt;<br>
<b>Sent:</b> Friday, July 31, 2026 3:12 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRA=
S recovery</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
If this delay is only intended for fatal recovery, should it also be condit=
ioned on gpu_reset_flags &amp; AMDGPU_RAS_GPU_RESET_MODE1_RESET?<br>
An unconditional msleep here would unnecessarily impact other reset paths (=
e.g., mode2 reset).<br>
<br>
Best Regards,<br>
Thomas<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Sent: Friday, July 31, 2026 1:44 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Subject: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery<=
br>
<br>
UniRAS fatal recovery reads MCA-derived ECC data through PMFW, but direct q=
uery mode bypasses the existing firmware-query delay. The recovery worker c=
an therefore query before PMFW has finished polling the MCA banks, causing =
the first fatal injection to miss
 its UE count or time out.<br>
<br>
Apply the same 500 ms settle delay whenever UniRAS is enabled before harves=
ting ECC data.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index d247d0ad063f..ad9a9545b1d6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -2755,7 +2755,10 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list=
_handle =3D &amp;device_list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ras_get_error_query_mode(adev, &amp;error_query_mode)=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_uniras_enabled(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait 500ms to=
 ensure pmfw polling mca bank info done */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(500);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (amdgpu_ras_get_error_query_mode(adev, &amp;error_quer=
y_mode))<br>
+{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error_q=
uery_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERROR_QUERY) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait 500ms to ensure pmfw polling m=
ca bank info done */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(500);<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB6345E08E9BA84E8C62475A4DFAC82CY5PR12MB6345namp_--
