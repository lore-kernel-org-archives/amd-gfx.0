Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF1EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 18:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F2760F58
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 18:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70F2760F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EEF6E064;
	Fri,  8 Oct 2021 18:33:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F339B6E064
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 18:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQjTdIvtREZ2si3XsErglNZ+FSdDRcrrlrqop8mGEA1MqxWZRGQKj376chKK9g1Tz0W+MZ+WhCtUV3XjosgdkR6SEYq9Fobr3ud87KgiGYmD6bvspbnr6MSYHKvT1kATxrdGnAlg/X1S2LoVe8KnZC72DShqkJvwvz19R+nfRfvY1pS/qHnyzBXfKg9QT9rHOzzei7uuuAcZ14StJ9rHAAo4h0KZfqnaIntOtKcA25aVUQpa6/BpVVnCJykOPD2qAhyINcRn8txNJFK/FE5gFKox1z7PS12rGcUSmn2H9BO/7jkhkRri73Zs2+X5WptHgkw7e6lEfNA8WIo4MDls8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgvfLrZGwBdeShhfk3cvT3t9HRH4LzAMWcgCpe4hLtg=;
 b=IpkIcJPrrTnMZz++RK9/rGfO6eHrZLis/hUfEMHHVxnSC/5XJuvWsXNRJm/cK039aASF5jmKICD9mbVL8YoyfpVWeZESQdh9Yw4iKKctpr2HQviDjdnsgPPSp2eZWh4WXuYAM1g+GXzFjlerGsFcLVIks50Ut9sr+DRTTkz0c05a+AqC+UevDAqrSBFYDzunNL3JE86xB4Uy2GoG7DLtEGhDS0QaHERAyZ8ZTXgpdlkvZX4N4I41r0Qp/05ZHnaxVh9IXVEbBibcZXQ8qx24lR9KJ4NpOyZjY1V/l09vAdAhQGj4Onk67IJv/iuzR2rHSASGsYcWndHjEb32XNiezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgvfLrZGwBdeShhfk3cvT3t9HRH4LzAMWcgCpe4hLtg=;
 b=xcT8UTdrsOhUmCLYNFHgukm3ABid18fdK2KnOWEHf4njHMbWUkmcGaB2+axozIpgEj42kDGpeBCaU1e9u66TV4ITJ7psLAEhiSzOgJoVwQKqXLqcRYryRoVV73xed2tMGk1K4CLNwQkQNz6ikmlmDuuloXDF8zUAPIljvOLdFlQ=
Received: from BN6PR12MB1874.namprd12.prod.outlook.com (2603:10b6:404:fd::23)
 by BN6PR1201MB0196.namprd12.prod.outlook.com (2603:10b6:405:4d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:33:49 +0000
Received: from BN6PR12MB1874.namprd12.prod.outlook.com
 ([fe80::4d98:95fd:69c0:b738]) by BN6PR12MB1874.namprd12.prod.outlook.com
 ([fe80::4d98:95fd:69c0:b738%6]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 18:33:49 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
Thread-Topic: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
Thread-Index: AQHXvF8M2Q/yMOoPsUqTcgcj/Udh2qvJbUMa
Date: Fri, 8 Oct 2021 18:33:48 +0000
Message-ID: <BN6PR12MB187403ED1BD6057ABE9650EAE4B29@BN6PR12MB1874.namprd12.prod.outlook.com>
References: <20211008161021.1922011-1-alexander.deucher@amd.com>
In-Reply-To: <20211008161021.1922011-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-08T18:33:47.669Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: e9ee0df4-9de0-86ac-cb80-a691f7d8e81d
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a2ef41f-6dcf-4d7b-e9ef-08d98a8a2b92
x-ms-traffictypediagnostic: BN6PR1201MB0196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB01965A70E6B7D6F5142FF240E4B29@BN6PR1201MB0196.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gebWar3aT5919gW5RDRboFOEef5utV+m/5aY7Rv+9gsmGghPoV9eEHcvTEyjzHwAAkDBedJdlNnxcX+XJe/bSxhKj5IPgaAx3yQ7iaseCAJGwzfaZrp7R2C4AkMa2ojBMDD7fNv+K6ffch9+grX24p24SWgJVrxFP19FHzrsrmRQjnktC1VkzuAq0dU+OTnyd/bjGHjcB2lTVUjAJWSbikXb7vIbWpFwcUXmcFC8BjW0uH7a4pUJFok5xD56GaM8hkaLyqWjAiPjjT1MqMnGtcmk9tVApCUcIJqVBD78NQJG9BNtRMod8jGGM26nQn14oSVmOl58qw+5ZjNk0Ba9xM4J8QNTX1OrYum/J3GhYfThDQxquIeT9h25b87CQsDCBkFsmTkeU5L9VA7Zbg/9kPAp+GxjfLC70/NQICGmri45k+whrYSJNXU5EGELNkTOLUSF2ymLmeETxKfA0gXcVy/m3Kl1p/JdQC8aSAlay2ZinJ0jQFmBk3ueCNXpcsHOP0U677w1sbG9ZeMY77A2kEoIoxYg5u1Avrgx8Jmzu7WNaGpMQJphvyF2PhNH0FvzlXUC0LzepgGjjnXCtOxZ/fpaGDV3QGwcPbaJCncVfksGuTJuUn+J6CXw2xM0mHb4UpIOZMdIJKjwOq9qyTlTxdNMiFnHv10v7DfXlQCpLGghfFgUblp7hfUc+X03RoZWYQBg2/Ecybf49chmpK16Tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1874.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(5660300002)(2906002)(186003)(52536014)(33656002)(71200400001)(122000001)(508600001)(38100700002)(38070700005)(19627405001)(83380400001)(91956017)(6506007)(8936002)(53546011)(66946007)(316002)(8676002)(86362001)(7696005)(66476007)(66556008)(64756008)(9686003)(66446008)(55016002)(76116006)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EqV1qRNV4IuwgCv5q0kzncCt0MosWeBvSgZs4KR5QyHSNJHWZM9YmpQoXhm5?=
 =?us-ascii?Q?bJNoi/McpOgS1P30xde1FyU0MbGjEYbGciD3+sLlwEek5GuN8rvMejsHJueU?=
 =?us-ascii?Q?ii3M7MTa9s5LZ7dHsYtJ7iBO10wL2L75t0zwifzEZk9kwpmBnYkz8YS9qw22?=
 =?us-ascii?Q?Gsd6ekWOThMnXincDn/m98+AWTclvOBAPC775PCFe3hb9XBmG5etHhJU9KHr?=
 =?us-ascii?Q?4AJaYJPqjjdF6D+45yUc4NQs4S7DOussPTkVN0dvOoMIEA+4YFRg38Nav9kx?=
 =?us-ascii?Q?dCPvWjbLztCT7UqaKOX0HAdLDnIkamFHWtn+4rdw0XcPaWtFI5AzVQVqUG5N?=
 =?us-ascii?Q?U5dRFapvNB8AymgPIV5K28drSIFErEdkSECqSIfUaX/TsTklYFbCMajD1nGg?=
 =?us-ascii?Q?2kdTRjRABF3/OQlNlo9xKRMkUXh+THTedqOZx7yuNn30Gd6qLbPx6VVSRPFa?=
 =?us-ascii?Q?+zFWPncjiLidwbOW9aRhrFnqKOOuhjaz6LQ2ZattBjsDgrGyMJoUopw+iMGT?=
 =?us-ascii?Q?8SMMmp9PN36ziHasccf9mElBbNaodvDbe6K+sK/jW1ua1AFR7E+ZXGcoWei4?=
 =?us-ascii?Q?A6yqlR13O39sfnhzR66g+WYl+bqGAY8022jinr0K/vQ9NqJaDYO7JURNBwTg?=
 =?us-ascii?Q?mGkZmQDLdnYebStICzABk4L1zZrXqoHf/WMS9C9/HTVSrKJGb+89/q5uo1l/?=
 =?us-ascii?Q?JYHgmFZKAIU1zuE1aOAa3yy9dzaFP6LXq7LHL5gELe0WkzVUo+BUIQcnC34F?=
 =?us-ascii?Q?4VwiCiVQTGxj8yMyD3hSM9F1E+/HG98IgcsJz6LMHESaQqiFzReZ+agswR3E?=
 =?us-ascii?Q?SF8Gtt/bTotVy8Z3QhgUJkhenCaFAmfEcJ4170tz/iKH9QsCzCN09VG4DNYb?=
 =?us-ascii?Q?6SwJAO+jSWnrPn2lePpFCUScw5nBYkWOlPhD0BoPJ5zVFjpBwzN4WAsF4flQ?=
 =?us-ascii?Q?iaB+97wzsJBhKLi/8n1dNpkaNwpHJnOJRXelWZlVGqAjUL9eSoWmw47IAwhW?=
 =?us-ascii?Q?8+IW01rHreI8lN+7BwAXrzWNIt5oe8UyfGoJcc/XrmnVbP3ISxmozH/Z8nzY?=
 =?us-ascii?Q?ZejXUc43/BrGo4bI/oAHyvMr/jfa7DEJEaUKwqTIO4dZu2FD89py8OuCE8/C?=
 =?us-ascii?Q?0+WC3Bf7pHO3TJO1o3QG1YZ0zypC/DOtlQ1z1N5Ekv0KNSL0LN1B7VhVdTOs?=
 =?us-ascii?Q?nPi4eyqHNedMhAusp7ICPOUQK/GDtAduobfVo0lPM94hRFyuaIj0+sXDAhn9?=
 =?us-ascii?Q?9FJ17/Yw0VZiG1bh7Rz45f5arOateKAER0+9iC0VIv7fh4ZIVYMN3fqzNhc0?=
 =?us-ascii?Q?4m6NsEEN7FBRscpPm8Ea7tfd?=
Content-Type: multipart/alternative;
 boundary="_000_BN6PR12MB187403ED1BD6057ABE9650EAE4B29BN6PR12MB1874namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2ef41f-6dcf-4d7b-e9ef-08d98a8a2b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 18:33:48.9024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUNrkO8z4v9rk4VPO9Kedn2Oc0ItxG9Iq37p0hSZSgShesTOPhlAE8XpiGXnAWnp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0196
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

--_000_BN6PR12MB187403ED1BD6057ABE9650EAE4B29BN6PR12MB1874namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: James Zhu <James.Zhu@amd.com> for the series.



James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Friday, October 8, 2021 12:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12

It's used internally by firmware.  Using it in the driver
could conflict with firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 91b3afa946f5..3b7775d74bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -56,12 +56,15 @@
  * These are nbio v7_4_1 registers mask. Temporarily define these here sin=
ce
  * nbio v7_4_1 header is incomplete.
  */
-#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK     0x00001000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK     0x00001000L /* Don't use.  =
Firmware uses this bit internally */
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK      0x00002000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK      0x00004000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK      0x00008000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK      0x00010000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK      0x00020000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK     0x00040000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK     0x00080000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK     0x00100000L

 #define mmBIF_MMSCH1_DOORBELL_RANGE                     0x01dc
 #define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX            2
@@ -332,14 +335,14 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_r=
eg =3D {
         .ref_and_mask_cp7 =3D GPU_HDP_FLUSH_DONE__CP7_MASK,
         .ref_and_mask_cp8 =3D GPU_HDP_FLUSH_DONE__CP8_MASK,
         .ref_and_mask_cp9 =3D GPU_HDP_FLUSH_DONE__CP9_MASK,
-       .ref_and_mask_sdma0 =3D GPU_HDP_FLUSH_DONE__SDMA0_MASK,
-       .ref_and_mask_sdma1 =3D GPU_HDP_FLUSH_DONE__SDMA1_MASK,
-       .ref_and_mask_sdma2 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK,
-       .ref_and_mask_sdma3 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
-       .ref_and_mask_sdma4 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
-       .ref_and_mask_sdma5 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
-       .ref_and_mask_sdma6 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
-       .ref_and_mask_sdma7 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+       .ref_and_mask_sdma0 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
+       .ref_and_mask_sdma1 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
+       .ref_and_mask_sdma2 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
+       .ref_and_mask_sdma3 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
+       .ref_and_mask_sdma4 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+       .ref_and_mask_sdma5 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
+       .ref_and_mask_sdma6 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
+       .ref_and_mask_sdma7 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
 };

 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
--
2.31.1


--_000_BN6PR12MB187403ED1BD6057ABE9650EAE4B29BN6PR12MB1874namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by:<span style=3D"color:#c0c0c0"> </span>James<span style=3D"color=
:#c0c0c0">
</span>Zhu<span style=3D"color:#c0c0c0"> </span>&lt;James.Zhu@amd.com&gt;<s=
pan style=3D"color:#c0c0c0">
</span><span style=3D"color:#ff9d04">for</span><span style=3D"color:#c0c0c0=
"> </span>
the<span style=3D"color:#c0c0c0"> </span>series.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Friday, October 8, 2021 12:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit=
 12</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It's used internally by firmware.&nbsp; Using it i=
n the driver<br>
could conflict with firmware.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 21 ++++++++++++---------<br>
&nbsp;1 file changed, 12 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index 91b3afa946f5..3b7775d74bb2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -56,12 +56,15 @@<br>
&nbsp; * These are nbio v7_4_1 registers mask. Temporarily define these her=
e since<br>
&nbsp; * nbio v7_4_1 header is incomplete.<br>
&nbsp; */<br>
-#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK&nbsp;&nbsp;&nbsp;&nbsp; 0x00001=
000L<br>
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK&nbsp;&nbsp;&nbsp;&nbsp; 0x00001=
000L /* Don't use.&nbsp; Firmware uses this bit internally */<br>
&nbsp;#define GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00002000L<br>
&nbsp;#define GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00004000L<br>
&nbsp;#define GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00008000L<br>
&nbsp;#define GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00010000L<br>
&nbsp;#define GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00020000L<br>
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK&nbsp;&nbsp;&nbsp;&nbsp; 0x00040=
000L<br>
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK&nbsp;&nbsp;&nbsp;&nbsp; 0x00080=
000L<br>
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK&nbsp;&nbsp;&nbsp;&nbsp; 0x00100=
000L<br>
&nbsp;<br>
&nbsp;#define mmBIF_MMSCH1_DOORBELL_RANGE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x01dc<br>
&nbsp;#define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
@@ -332,14 +335,14 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_r=
eg =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp7 =3D GPU_=
HDP_FLUSH_DONE__CP7_MASK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp8 =3D GPU_=
HDP_FLUSH_DONE__CP8_MASK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_cp9 =3D GPU_=
HDP_FLUSH_DONE__CP9_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma0 =3D GPU_HDP_FLUSH=
_DONE__SDMA0_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma1 =3D GPU_HDP_FLUSH=
_DONE__SDMA1_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma2 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG0_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma3 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG1_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma4 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG2_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma5 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG3_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma6 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG4_MASK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma7 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG5_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma0 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG1_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma1 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG2_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma2 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG3_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma3 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG4_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma4 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG5_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma5 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG6_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma6 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG7_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ref_and_mask_sdma7 =3D GPU_HDP_FLUSH=
_DONE__RSVD_ENG8_MASK,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static void nbio_v7_4_init_registers(struct amdgpu_device *adev)<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB187403ED1BD6057ABE9650EAE4B29BN6PR12MB1874namp_--
