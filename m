Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A434AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 16:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F19D10EB6E;
	Thu, 22 Aug 2024 16:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VeCKkax";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE3510EB6E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 16:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlhP3YtcIgry4a0GboCRIfvMpO9xhWn/ILvCij9PzbOMmbLlHvNq1c4I2PgVgJBLfPX/9Pls1fkhPtAu4xRlxzuIEDE287syInoRfjv3rjDQwSBxVUMq+DvBQyUxFWrOwCpLouakVFK7dn4cedj60sp6bjnuvVByVKRp59OW718ImmhXh83sB4nmboHAqn4KJykJedl4ozAUbMudQdvGx3tQqvKUZ9AnITYWnuvqpg/dvSJLUCvUlx3nlRIJm/ANuag5A57f6gdd+mvHam/cjZwf6pEYQzJ2hSCRwkdTJqhplscK/vREYc5IqlYMWr6wWtModCamWkZp92ltyXVMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bKtgMANE2Mfu6t3SYsScc4ajPhH4x53vDFiR8tHAig=;
 b=CtdyMf95BKQv04ljSbdgNHg5BE72EavzQvnBDByslCeEeLQ4v8KQzw7jSwRKpO9+iZSzH0x2xyij1X96ECoRb6NG8fZJQHL8t9MNv80ekC5ayqMW7VNNIpLZnze5Rvw03ZBep8vQ6xKNsRKIjoXTKGXeVzEA6cBRY6YAxiHb2DeMJ3KepJyWB/TlvQ/F1YPSXV/RyNEFItYiHLOLDaJUed5KcL3srPrRH8491roN3BYEQ0PKxndBvpQKnsYtAi6ceAZXh4bmS+LVNqqBgTRre2RcQ+cwScYRf8jXYT1snt70DdUV2SslDGLHKNB0Fl4JP+6U7x69iUcb//GDRMCKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bKtgMANE2Mfu6t3SYsScc4ajPhH4x53vDFiR8tHAig=;
 b=3VeCKkax3DZARvSQYVm0AQo+al14b6kfQAE2c30JNPjQT63fmAcDGFtuTZjyWtDRlfwz8ugDPq5LIkccidxYCQmyUDGwr+JEsterp/ohmsJ7czFLEYvzlpwwSM69QYSPhnWqdfnETliusCqjInaysxR15mOmu0074YeoU1toZoM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 16:30:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 16:30:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Add support for new P2S table revision
Thread-Topic: [PATCH] drm/amd/pm: Add support for new P2S table revision
Thread-Index: AQHa9Erd0mjZWMJfFU2/8FdPmRAoorIzeIKC
Date: Thu, 22 Aug 2024 16:30:27 +0000
Message-ID: <BL1PR12MB514475033C2EBE3B01A5046FF78F2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240822042050.1812745-1-lijo.lazar@amd.com>
In-Reply-To: <20240822042050.1812745-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-22T16:30:26.690Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ1PR12MB6266:EE_
x-ms-office365-filtering-correlation-id: 4b8d4d28-ba0a-4ba4-2724-08dcc2c7bb00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?63FuaJ/W2ssisEbWQ4tNWLQ0Lwz9AJJapB0ukRxxdakD2jNQt0YOoVscrh3j?=
 =?us-ascii?Q?/AJopz0UqruhoGDtPQfbNg5AIaA+OXoqkDA2aTrY/4HPVeCHLI6GCKjWnWKb?=
 =?us-ascii?Q?0gPpvDWqtCbufr13PvDBZOSJq7X2cVOlOpur+RjM7Ele9MwkPUVAcpEGop+I?=
 =?us-ascii?Q?rPEPkCY6YXJYU9AZgzMN6tDuWLJ7dyc0lRIsp5fKGmmZDkvK8gQQ4uMuUSwm?=
 =?us-ascii?Q?x+28JsRW01PN3xACo2LLlmfgMm/qetSIZ16taWnna7iTf1mu80Y0viFiMEF+?=
 =?us-ascii?Q?NuerLT6V/zRjz3C+CsL/k84UhpwM7N2Xe3N5zwlZ+3u4ynaAt4sMnv8U2U15?=
 =?us-ascii?Q?sPf8uiWSiqHmEQB4kCp7jgcx9N7blVp4GI0W/UQD+0GlyPZr44CcqaH3+fgy?=
 =?us-ascii?Q?A4aBnAGis9FMP6rMYYq3Vjgk39ZGyeKZdTDF4JwB5xfl5cxhSYb7KHuqiw7+?=
 =?us-ascii?Q?aNS8ge6Tz7i6N9d3wB1fX477NJqDc31aA4wy6RBEsD8jINGIBm8zPDyFOLP6?=
 =?us-ascii?Q?v5ybk/j8bjh4be/9jF9Vuae5krdn/c0Hh3gyb19jwHd9g2b71Qx6raD7/tvt?=
 =?us-ascii?Q?TQUwDDVuab4jrOEk+p6btrp8vl9CiHdi9NqSC61bmmzE6+kEcE1KtWriXcxp?=
 =?us-ascii?Q?i9TgYMnHQ7lsT0bs8cUzP9uA96EWh3toRvV6nJZ72fopwbL22kIqkw06OBZu?=
 =?us-ascii?Q?MyxQfIdh+YXHHYRZM/0gM1TAvmHgdsSrnlxti5C+qFSMDg8ULdvjjr9HAkI8?=
 =?us-ascii?Q?lAlCmA2RTcF/MILbJaYlAtzqX36eT+GMvcgQyhYJKky3dJZHQZzpQJRnOHf8?=
 =?us-ascii?Q?H6jLjBc5QXQEoS54hjgdz3QMVfIXERXsmM6Py1Zruavc3ZDNmzt7ETK6wjPT?=
 =?us-ascii?Q?GkvsMn8fKXqN+WSNdikL/1MyucnalqetMiVMGzlyn8ucPHnjMcNrI8N3Evfr?=
 =?us-ascii?Q?u1WCkVX6f6D/Dh+l9wJ1pZaaPzMGOqwtUDduv+oTI5f3Yuv3v5uVqGAwlCC6?=
 =?us-ascii?Q?dF2BpufNFiX40pObtxKcOp8rd5mwrnrLmYc8p7OG1nwXc7C6NntEsuhP7T9p?=
 =?us-ascii?Q?o1pTrA2xsJp4vpH9vNe3o+F2mc0GU/Duzcie8Ja8IBGKA67EZeUikReok1RZ?=
 =?us-ascii?Q?g5518hhzUmBBXjOoXRX0Z6U/0tecBsQXT4nZmF9PapKTUZBF4NUNVN5FlLrU?=
 =?us-ascii?Q?mWMFI10GT1LhVpJ2JRMwjQzmKrWWU4t3A6Mr7VCkNbNkNJnLOCDNYnCdrClC?=
 =?us-ascii?Q?A5iV7JwbflNPk4Qngb2qcNyKdbK2oA7r1tIbuU65AwGyTc4AmHu4MyijGt0g?=
 =?us-ascii?Q?LIDLi5Qfk7MED3AxzePxWBWAshgcxwYj8FXflYbHDVhta5dwVT/MB1Sdc0Ec?=
 =?us-ascii?Q?9fomPhunmO8QOFNHSVvrtD5WOIa1ohA21++WD30PREfWfPMGEA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MYPE9jyq6ly0kjtyejyfKEOHVhhhROHMsaKmz22/w/2kPUUe83cXDsZh2KMc?=
 =?us-ascii?Q?qtbrJQtMJ7Y4wLjWjJxVh+wZnQO2FR7mmoXf0PaHtHeSUOP+Y1ubFtNECZ45?=
 =?us-ascii?Q?oKSlItuYvi4s2feOjxEgCxXVubyxtgBdUYuiwTDB6zhlIFlwPoMrlI7gx9D+?=
 =?us-ascii?Q?RElF8eyc8scHS5IT2+d31DVXCxRf+cxTCQQk7AR3hpVn3CWNkv+jWIEqgmRr?=
 =?us-ascii?Q?XOkJwoUl53ToD4l8KYO9sK8sv+vxWHqkzZIZiOLWFarR7TfCoSOfvOwZHfee?=
 =?us-ascii?Q?DjurrQDBVT4LmGRhT+1Og7aqY/JyKvweeEZvO19xezaOKCwyWEayyqpXdkrg?=
 =?us-ascii?Q?hNENXSvXPagEqwhe8MnpPdYvbakRy+6q2nZoO26DUIoTFM7iJeXI7KiLVYAr?=
 =?us-ascii?Q?6/m0U6VWVzdD7HSRJV7JmxbzVRe0UkAV233Eqo9rDEJIfHpdyBfJRRiilB4g?=
 =?us-ascii?Q?ah+OCoem26RwYBVO4XIbkBJxFlmRI8xQUMf4i6ILEXa3vcrTPyNLmbwU4h5y?=
 =?us-ascii?Q?fQmq5/f09XAilNMaX4FQx7ZCHlLuXj+I7EPeMMnGJt8HtkGSIBbfq0mYG0Hz?=
 =?us-ascii?Q?wdZ6JPkjMcqlYZDPal0uMLUv3b9kxIPZA15FQHL6RBs0eJnt+FmMH6v/JPrG?=
 =?us-ascii?Q?+w+frnNBLXVuPjYBGBjtN+lYcGdXBmnVvPoNla166nqtQppzNxKlEeLghbHH?=
 =?us-ascii?Q?qSqNyyOW0YFaQ2ExwUgVQwMAdbUHBb/dXxxew0f4/3Qx3yUslAkaJH9R+I4W?=
 =?us-ascii?Q?Kx/VcfpJBn4xQv+dyoX+TBe4/c+gv/wpBnNxBmcaMtbdfwswUd8QHDkV4iuR?=
 =?us-ascii?Q?VhvukuYLCJHljOX5h0o018DKWsa1Hb/pFNOvboT1oLbkZBpkHvulv5Mkf63X?=
 =?us-ascii?Q?9ypVsnGTu/TjMD187Jjx0xga3vUcLO/PL1sllD5rkW/BUoFSVUYjtZd9Gin/?=
 =?us-ascii?Q?8C2k8pPbx9YdPm5UfAHCjmdI2C2NhaZy4Wc4HYj6YHZzZ2MycSupsTS+Yjg5?=
 =?us-ascii?Q?xnmR7P+1J48/fVSOA5Ir16OSGrM0KIcjVCffsOATPSLcZJa3TFmeG8RYPbGu?=
 =?us-ascii?Q?Cyq2AGSyFI1fdF9R1XaKOT4+1y+3ERDBIWCNY1fgxVWv0o27BTJPTFDUQqN/?=
 =?us-ascii?Q?pMS8ngwPQnvOHcL9hPUtyBWE0Ykn407H+krgvAXQuTHvI2qAL+dNhlTCnXHF?=
 =?us-ascii?Q?Hye9tb8fK6Rkp51NC3TWYowoaUrHmx7I6ZpRWhe3cJgk7hYqmiGVFAcQkItQ?=
 =?us-ascii?Q?WyfFXHOwWOIBAuydUeJt86KSXd3yaXJ9DIVgIZtg12degY4mvEJTf+J8BB6o?=
 =?us-ascii?Q?xPeTfwdCOhgteNerlD4SE5CNNCPH7hLiYRiTOiDDBs0X8KI2X6qYFqiRxRcx?=
 =?us-ascii?Q?dcRD7a57HDWnyHJUq5jSy8tlk1RsoPeLMLawlz5zae4s8TtKFCAiMc1LXMDN?=
 =?us-ascii?Q?rFq/qSnG9307VQ0/ohMisv5pS6xx20HmD82Hd7yLe/tX7+AfaLjlat6PiCHK?=
 =?us-ascii?Q?bGrzmE+2sUXuy7DlCRZq5xteIgYWAiJ4Ij2/i5wRM45mlY1kYWmg3MVYW/2s?=
 =?us-ascii?Q?A9WR/9HtYvdNWAKrnq0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514475033C2EBE3B01A5046FF78F2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8d4d28-ba0a-4ba4-2724-08dcc2c7bb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 16:30:27.0862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60/NRaVoORZD2YmYOze6i+Mv+iAL56hrZ9DXg8abrsTpwOt1RLkrEkuqOWKcBAlC2gP4D2iGsQthKAI1P3vKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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

--_000_BL1PR12MB514475033C2EBE3B01A5046FF78F2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Thursday, August 22, 2024 12:20 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Kamal, Asad <Asad.Kamal@=
amd.com>
Subject: [PATCH] drm/amd/pm: Add support for new P2S table revision

Add p2s table support for a new revision of SMUv13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7cea0862dcbb..ece1ffc1e56d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -121,6 +121,7 @@ struct mca_ras_info {

 #define P2S_TABLE_ID_A 0x50325341
 #define P2S_TABLE_ID_X 0x50325358
+#define P2S_TABLE_ID_3 0x50325303

 // clang-format off
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_M=
AX_COUNT] =3D {
@@ -279,14 +280,18 @@ static int smu_v13_0_6_init_microcode(struct smu_cont=
ext *smu)
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t p2s_table_id =3D P2S_TABLE_ID_A;
         int ret =3D 0, i, p2stable_count;
+       int var =3D (adev->pdev->device & 0xF);
         char ucode_prefix[15];

         /* No need to load P2S tables in IOV mode */
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       if (!(adev->flags & AMD_IS_APU))
+       if (!(adev->flags & AMD_IS_APU)) {
                 p2s_table_id =3D P2S_TABLE_ID_X;
+               if (var =3D=3D 0x5)
+                       p2s_table_id =3D P2S_TABLE_ID_3;
+       }

         amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
                                        sizeof(ucode_prefix));
--
2.25.1


--_000_BL1PR12MB514475033C2EBE3B01A5046FF78F2BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Thursday, August 22, 2024 12:20 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Add support for new P2S table revision<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add p2s table support for a new revision of SMUv13=
.0.6.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Reviewed-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 ++++++-<br>
&nbsp;1 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 7cea0862dcbb..ece1ffc1e56d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -121,6 +121,7 @@ struct mca_ras_info {<br>
&nbsp;<br>
&nbsp;#define P2S_TABLE_ID_A 0x50325341<br>
&nbsp;#define P2S_TABLE_ID_X 0x50325358<br>
+#define P2S_TABLE_ID_3 0x50325303<br>
&nbsp;<br>
&nbsp;// clang-format off<br>
&nbsp;static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_=
MSG_MAX_COUNT] =3D {<br>
@@ -279,14 +280,18 @@ static int smu_v13_0_6_init_microcode(struct smu_cont=
ext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t p2s_table_id =3D =
P2S_TABLE_ID_A;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i, p2stable=
_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int var =3D (adev-&gt;pdev-&gt;device=
 &amp; 0xF);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char ucode_prefix[15];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No need to load P2S tab=
les in IOV mode */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; p2s_table_id =3D P2S_TABLE_ID_X;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (var =3D=3D 0x5)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2s_table_id =3D=
 P2S_TABLE_ID_3;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, MP1_HWIP, ucode_prefix,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; sizeof(ucode_prefix));<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514475033C2EBE3B01A5046FF78F2BL1PR12MB5144namp_--
