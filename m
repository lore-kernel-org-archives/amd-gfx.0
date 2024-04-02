Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE285C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7B510F4CF;
	Tue,  2 Apr 2024 10:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s/DB6Chm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F0610F4CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2Kdmu1j9pvOUth+ClplKTnU8G5p3J4dzx6u41OQgEWw9EKcbVFx6bj3ZI5kmlpvBr6WXpLcchWvRNuJ71P2y+Gq0tmFJBa9dAEHiUTYLpD9HSaZOcFXvj/BIppXslZzwAgK5N3gWsKYcUdh36BrAw3aCO2MgHD0CbOjIHQywWdjfKs0NperAAf4OmjpIVen20KSgkTGp/7q3jlDAvxkv/dyBxgBTZJVClpB+ywIcXVYVSKj5Kc1GCV9viaXt1Y521PyeZqW1GSWz2BXZ+7V5gwyIqqNW+0EhsoOXNGwNnwAzwOl+SANdppy8dak0GiNmVCeOdGWV6vWHUXWV5l5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c13C9VY7Tm4nlpDv7ARpL8/xc94UVYJ2D1Jqeih16w=;
 b=K1bZ1oXzqckjhfKaMAa/ySo9Asi1/32WKcrdibOL0K9xGOQnJ3UDSRWJsIxvlhrfaXTMAbua4uIAZcyaysAsUvaH3a0hXlNy/OPcibbRCjx0iXONHU3ZKJv4zhRgges9vpv2ZxzC13uPjeuLTcFB77tciU3KzX4yLF8HmEqbIw1wsG+fsheYotss5WfGv65qNp22YGWldRl0oOe3fYXGQS6PJEeK/BD8hAqKGdQP57DaGHud47D9sL88UOqbarKHejE8Qx1LjOjb6O59t3KeCyDZ5TUgkszYBlxyBqjvVsIw4qGqLFRj/hc/xVMHitCAYfY+z6NTkZv89CeltoOLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c13C9VY7Tm4nlpDv7ARpL8/xc94UVYJ2D1Jqeih16w=;
 b=s/DB6Chmc8JcQhEVaejgw+dzuR59k/SUgEgHPA8ZDtqQUhwfzw5xLhXuO7EJO5NOZDpaWkDCORJGzV9/iayL8Dx+5YlIV0u/yya8TLJDHQDAAt6KpiPPRBAx179LJUfkaaWK2ffrsUFT13lpFczWD9XhfH6fHplrFL2EngRG8rs=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 10:19:59 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:19:59 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Cheung, Donald" <donald.cheung@amd.com>, "Khatir,
 Sepehr" <sepehr.khatir@amd.com>, "Oliveira, Daniel"
 <Daniel.Oliveira@amd.com>, "Poag, Charis" <Charis.Poag@amd.com>, "Liu,
 Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Report uclk and sclk limit
Thread-Topic: [PATCH] drm/amd/pm: Report uclk and sclk limit
Thread-Index: AQHahOa0jqPf8F6Cr0CSUsqYcjzQL7FUxLaQ
Date: Tue, 2 Apr 2024 10:19:59 +0000
Message-ID: <DS7PR12MB6071B6F9851A0578D63DCFC48E3E2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240402101517.3373466-1-asad.kamal@amd.com>
In-Reply-To: <20240402101517.3373466-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b7178362-01f2-4632-86cb-bbc0236dcca8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-02T10:19:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY8PR12MB7414:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y493AYu4uONNZg7TGc4Jb1NGW8zLEqjo558hrx5/60A/SmEVMsq+DLqWkJ51YvhpzImnvs8f51Cqil97LQNzNkMvwl4x6soebKEUYZ70BC/ZksguHmK8a4Prgsl0kVHJfbqHVrn2BycKmtFwSE7GgugsQvrr67Xv3w2cPYpAhW6MvF7ohmbWtxVT3NM3Wr6avYQNcTgxv57SEDNIMgF5Bl/dRvuqYOp7scJ+IPeaxGSCvWcwyuerAlMcpJAPfwFfX32oLMrs4k22wq9A94XK0kAgDDHyNjGxmaYJS4z8AVweDSGlpMr5+VWCHPhfUEvOCSxMltrStGqJyJ7WGadskZXCC1t/iw3Tv4LyqXs7aFtqzG8h2d6XYFm+fAweW6gIxsvH6bLUqrJqqA6uHkHbwdw1DtQ+S3rLfI8ghzx5D63iS5HFl1/92guFPcz0TZqYzw2VWhGoPdldIcnAtHumEFOxmSiMZU74TMw6p3wfzY6ZCB9APNJizBkIF2c0b+01Dy1q5jMtvcUtQIPYqSL40Tz2VFw7I60GT6fkDlamX9kODdVAVe48OceTMi8eU8+spUmzc0+Bnj6WwOrFDQ0jptOgZ91KSLRDOVFsMFqWp8RYKIw/brvh7wKnFZKuAi5s/jxKYZQ0xLa1WOYtX5B8xry3vXxOgR1dToPddu/ovHw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?th3quZrqIYmw1Du9nr0LEP2vnewInjLEa3kHqYu3P/eZPUkuAjLzgKTOhYGk?=
 =?us-ascii?Q?u5+JQwVzvmD54m7U83b/4F5Iy52y+QUGPc8uYH8NICQAgPRc3yXrEcF/EVhM?=
 =?us-ascii?Q?93d46QZ5EyymcKuxu0ZgEa814G3KZTHZFGxJqYNSKKGiJnec2qdJ2r9TF1AS?=
 =?us-ascii?Q?/YUBgQUsJHRzHcMNx2eol18ki8Mj19i4YcipTf66LjFIexHy6nA+U6uOWG8F?=
 =?us-ascii?Q?MsrEJ/pzrfyw31LekPsgev1Yt9wTKZBrKezPVSRfQnIYkpPvR+ot3cNChy9J?=
 =?us-ascii?Q?Y0OH8EPCOIuK0wgIOtQrSGeeUNAzilsnhO3SAXZe+QT19BSXVoTK2Swxgly0?=
 =?us-ascii?Q?9Gxp1QHsETv8wDeSNt0JK8P/TmJwPNwaZay9UPEiFOaj/YgO4dmL72BZuSyy?=
 =?us-ascii?Q?F8XTvEPQEGT3zsCmCpVZeNFgTYnj+8VxRXfa47lBVO2OW5T8yzhSPEbW5EAB?=
 =?us-ascii?Q?n8W0sVM27Ce7Sazo6tAuvcTl6WHwbLVAspE+zatl7ovaOpuAIO3DO03wvx7Y?=
 =?us-ascii?Q?mtylMdMv0DHr+Ku08vF0Y03WQV4hUW/EKHq0sCzyza1Nzua3KvsZawH3oH1N?=
 =?us-ascii?Q?FkdD7vNMw1G+oRCW1RkKd7NLt+jRfVgjKoKovaO+d4ySepkZIorNP+EahN70?=
 =?us-ascii?Q?HmL517uH901tolwwrT4w8ZtQPKuoXIbhV3PyBh5pzfFW6okPo2WyIhDyiV+H?=
 =?us-ascii?Q?zUW74p2ihUlf46VvLrcyEGOQvY3NzUtd1LBAlzWnLQDRnyid6w6AGPmisXEG?=
 =?us-ascii?Q?csnZMJEOF3Gdwi78OteB1PdaWdVFgqs/7E+F6+wj+nyWGxEHtVb7Eq3Oxond?=
 =?us-ascii?Q?ZB67Z8GQhAM0roDFNXxy597xAYK/HBgdm1d1F+TogUl1o28+J9H2mNeH/FtI?=
 =?us-ascii?Q?WMZrBnLGZi35AmR86n8+E68IIwmtjbYdhiMCZCewLZ+W2fqitcYqgxBKAL/h?=
 =?us-ascii?Q?S+pV9dIuOWpPyoZhqNIq+ydpy5yxYhDujvfNWUhcx8gDxlqU5EURVLCWwV03?=
 =?us-ascii?Q?+SE2PGInFvKs+BvfmEL1Umyvj41I0GDdTwxbe0IZLUFpmoR4l9ubj/iErqp+?=
 =?us-ascii?Q?p8Xb8hfyTjZ0zs63KBd1xDy/imr8mBvHvZ4h8v5v3hyFiZYtZ/HRVhse4HjE?=
 =?us-ascii?Q?tPc1DefsIMrwjuzE74rn4osCcn6dIQMpznGTdM0hc3NKTpKTkp3XoFNz4Ye8?=
 =?us-ascii?Q?L9BMJEPonOlyDpII5f8DKs7STUo6hF4JbBVFvTCWpsa1NxKgQT+bvVs08lLc?=
 =?us-ascii?Q?8d24EFtGjzGwu8wxccRmJXsNuTiSA0PpXdvYKKGF1oq2Xs5WRIZADCJOAlVD?=
 =?us-ascii?Q?fxUK9LVFiC93morbe6PRBlD/XPXvpi3qS/IbOVkC1ayAIpSsXZVuo7L2HFEb?=
 =?us-ascii?Q?V+GhT9BC76xn09kjz635AiOm8vPr3CDy3mk7e/EYlN7Yv6kp5iCmRY0r9eM1?=
 =?us-ascii?Q?tcUXiMECzVebYUUxgHUXlxgWlbbOUgbW4ncyBpSRk8XpHShiJYoLh8o19G5j?=
 =?us-ascii?Q?xqewylnJf7MXLs/O4J+gvPeRohIrEelBpQLYMTkwkSz36EHsjcY7iYAmucVj?=
 =?us-ascii?Q?RoB7sNA6sRSiQonEYPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6144f89-b242-4e40-c3d7-08dc52fe7387
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 10:19:59.3166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pETYaH8I9g2xWGj0ZDdT6vhIkyiLxApra+LII93OVIS/igBJcK4Ay4nnIcGBZL2kda33qJm7Yow5VcR7XOrcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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

[AMD Official Use Only - General]

Please ignore this patch will send a fresh one

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, April 2, 2024 3:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Kamal, Asad=
 <Asad.Kamal@amd.com>; Cheung, Donald <donald.cheung@amd.com>; Khatir, Sepe=
hr <sepehr.khatir@amd.com>; Oliveira, Daniel <Daniel.Oliveira@amd.com>; Poa=
g, Charis <Charis.Poag@amd.com>; Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>
Subject: [PATCH] drm/amd/pm: Report uclk and sclk limit

Report max set uclk and sclk for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 575292314f57..f81096bfbf2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1010,8 +1010,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_c=
ontext *smu,

        switch (type) {
        case SMU_OD_SCLK:
-               size +=3D sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
-               fallthrough;
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+               size +=3D sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+                                     pstate_table->gfxclk_pstate.curr.min,
+                                     pstate_table->gfxclk_pstate.curr.max)=
;
+               break;
        case SMU_SCLK:
                ret =3D smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_=
GFXCLK,
                                                                &now);
@@ -1052,8 +1055,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_c=
ontext *smu,
                break;

        case SMU_OD_MCLK:
-               size +=3D sysfs_emit_at(buf, size, "%s:\n", "MCLK");
-               fallthrough;
+               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+               size +=3D sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+                                     pstate_table->uclk_pstate.curr.min,
+                                     pstate_table->uclk_pstate.curr.max);
+               break;
        case SMU_MCLK:
                ret =3D smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_=
UCLK,
                                                                &now);
--
2.42.0

