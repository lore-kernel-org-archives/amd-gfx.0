Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00348C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 18:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9875C10E2D3;
	Thu, 25 Jan 2024 18:57:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1EA10E2D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 18:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGo8awD1Jh2nKUAbwlPMjhIE43/ejZDlMOGS3g8+zolHL9eOLm6LwLdriO83/NDZlYYumArqVi9PUnb1nefbeedLfvksvnmnzCR93iyQ7KA3GF6OMR8kvniNH5CXULe88at9Tg3dJ75QDg1hUCy8Rrh+KXIrTGy77KZlBt1BouCbi/BzMcrbKjwx2AwzznK02uRoFTWMQaVNBewIy9NbdgbPpeNIyWb/Mhl73OFRQvZ4v1bGzzhuVnA4crkeu9rAcsPCYdRwDzcVuTXpq15udY7JiKxzd/+6m0vs7vZEQOxEVuB8Z70HUoSeYo1xpoG+foNsF/Lg11lS0wlINbJXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkpceDYacWdmR8XLx704pMxOWoJ+/RQZPsoG92CMpqg=;
 b=HF+pVEYNe59YXaN4fbWGW30sSVtrwbIMUNoe2HrcdpVthv7hXOSJme9UNATh9JRaDw7FstAyPUcCN+S9XnvUZTE7gw8mVzPjckQFl5Mmbcm93ssapOPNMAdEq6p8ozD47AtwpE+rndqqO7l2SCEm0m3e6YkzRCnY4OvtFtOqx4Km2KIueW3GvxLZxkS5N//Kicf7dtHI8H+SsKgbPvlUmvfpTHw1PmxKPUKK8sw4VHe/JDepdPC/No1GtbhBZ2e9JOsejjOQ5lYDecDpahOb9Fe9h36tY0+mY1Et9lTeYyKihO1XSOwHHeTd5nDWgy7xUTTrRR63h3HDoDTKJQW8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkpceDYacWdmR8XLx704pMxOWoJ+/RQZPsoG92CMpqg=;
 b=VDG0ySuanLy7e4TE1sdPkx0VgSkuLiwS/UUaKkBy+1qw9fjzbc/K0Stofm3cUTpcPnbplnQmEY5bAxQVgmZKCSYAyIvThuciW+A/7R5niNtZGI++EpdslmWJk53+WoVmaE0TUlF8fwuyIIsJ+RNMlqRDYjdoTVhm/cicrP+6nps=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 18:57:27 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::dd5e:e866:b2c4:2c05]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::dd5e:e866:b2c4:2c05%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 18:57:27 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/include: Add missing registers/mask for DCN316
 and 350
Thread-Topic: [PATCH] drm/amd/include: Add missing registers/mask for DCN316
 and 350
Thread-Index: AQHaT720pvqC+xmbpUeOtRJNv608WrDq4QYg
Date: Thu, 25 Jan 2024 18:57:27 +0000
Message-ID: <CH0PR12MB5284D5F43D6A99C73DF2B93D8B7A2@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240125183752.999995-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240125183752.999995-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-25T18:57:26.855Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|BL1PR12MB5111:EE_
x-ms-office365-filtering-correlation-id: 4478104d-669c-4961-4450-08dc1dd77984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCZ/xanGPe0kC55dwFZfSltmYHBJot2vfyNlhOhVLFy+Nd7JoYILAI0KRLdu9U7/wvKMXw+e5Ts8xvRl8JfMbZVkI2rfqNkX4jRqY0y8SCExOueEbD/hlcTt9qo/WZk3jfotlqUsebJ6XNKeJf0t00w6ck9IEsIftynJgv1b8oSOSMvCbJHDsExEg2SHtAVPDsAyu81fULbAbXlBAJdmagytvwlW+//rN2tadOmVaMUHl05t/dVu1Bw4edsQrbc0SiZXhcpKR3hC/JAN8De74mCoiSp/B2VdGmbKpt0OmXOznewdcA2Pgx2OaYk1JqHZZ8wZUTpLxZHSVqPkEemeS0fPa2b6mQ10Ye0tvzA+CzKKwWQahYayjT8tNIEqpUorVbIOA1xoHr1VQiTfE61RQM7FAGuJhECW9KKjAWQ5BvYOQKqOhruyhbJjh1jZX0iu+JoGbKa4+cK8+wNMbahjg016M3QSp5Kcb8rbll3uFF9XNHur/oxbsGHFHgTgzhvjDMKMH5a+ESWWe/XAp1ysL+F/6aIno84eyoGBCk5vTIns1MnO4qInZR5EYI2P7bCuTfnWVFPToxu49z0twgEL1GxcSo8S0Up6IA224R9qE4q38nj9b5+hjUOKWCeIkG+i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(66899024)(19627405001)(83380400001)(33656002)(38070700009)(86362001)(9686003)(76116006)(52536014)(8936002)(4326008)(8676002)(71200400001)(26005)(38100700002)(122000001)(316002)(5660300002)(66946007)(66476007)(66446008)(54906003)(110136005)(91956017)(64756008)(53546011)(66556008)(2906002)(30864003)(41300700001)(6506007)(7696005)(478600001)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmirkzqYsn5mVP08ObrLYpzmgRoQ1gG6FgzUKWQ/LhKDEr+SD7f9yi7OY1mo?=
 =?us-ascii?Q?kKSu/tJ//U5cf9+eAkyx+vp7DGWdT5+7Pef/QRXUjA6HPQZl8tXsMfg61Bdg?=
 =?us-ascii?Q?fMpQl/m8qCFk0vb1uZNlKen/1X/VyqZKzK+TtHfvHwNV4liaPkma0fmKKfOe?=
 =?us-ascii?Q?n3gLd/WjZCPpA70mXa+xEtKdLqySjtjcno5ap5brzmNissQJ/SCwzvZ7SovC?=
 =?us-ascii?Q?7dZIHHvV8fYpYApz7tcxq8/ncpZd7wH82Ps8EJyVEeQOt2eU2zCzy7N+msQC?=
 =?us-ascii?Q?4fNLqwdjuaKINOS6XQ3ddnDqxYz3cCP4yfIx3Od2+Nhu9QEXpus8kfdZuSnR?=
 =?us-ascii?Q?T7YRMhx0/rxUUU7Yva8tFW/PovN2tTsLw4oW/Ebb6gYc9ZfU3G6HO5QJjVxc?=
 =?us-ascii?Q?vjagQd5aMZAkQn0Vs389V84XT+K9lfB3TCgSJYr30iUKblTLx0rIV2Pkr0iZ?=
 =?us-ascii?Q?rliDPddZ2Zu4m6YYs3PfSi7I4DJQpqO2hROPizh0mrC8misHvEov7rHiyJ/a?=
 =?us-ascii?Q?RMRm7OdlD2JwwkB0woZ/f2tPn/PC+OOcZdQEKNbI9e9p4SjJKm7C10mhGOcq?=
 =?us-ascii?Q?Tx4Np3AcwyIVZPEvQpD4i470A7+uySFWYqxqorb64BSyn+oFc7BFIyvkLn0R?=
 =?us-ascii?Q?ZcHdhnpRyuZHU7709tg4KJNLb7Q3Zt0ZRGX0MFdEhqRcXOyhAEecI84zy1uR?=
 =?us-ascii?Q?BQtc9p5i3hnpQRrqGNeL1NJPNKBS0LFi2eyEnEpedKtrJie+y863hjs3X5Hb?=
 =?us-ascii?Q?9QSi+ap5h7fI7AZk73iS0WsJ8sjYwfyUPjs7fnQmmyoGyRbNAvsv0uScqV5c?=
 =?us-ascii?Q?kI20Q0dq3FglXacIic+LLURfESFP3VK4681X2lpsfdKgWVIkXthx8C8wAQWZ?=
 =?us-ascii?Q?zdvTyJoSYpc+HrqfPB+3tBDFR2UXeCykcXEvmUmL/1Rlm0Bf3Qy27GNDjjDX?=
 =?us-ascii?Q?rjfr0ap1U8+mw58c2DRjrBIN2A81REORcvarOCTYCs0rizgZ9cCN7W0nIZi9?=
 =?us-ascii?Q?0FvR8LLVaA61tOpJYvU4QUXany2TBUXGAvkYh8poP74omdOsGM1xCNZYf/y7?=
 =?us-ascii?Q?YTkVezMSX+ExHguGVq13OeQJRKa6oObw2DyM0x0jcJ4PjA2vNr+lB8RdM9su?=
 =?us-ascii?Q?wz7ktMjHUsDGT9M5zviRrjox0e/R399xkRtL98rRHEpla0hakXHzMiIW1feT?=
 =?us-ascii?Q?rfN3220MMi/TBYDqvI+xElz1p5bfPqHo/GPFdFZLhAQh5LWo6+M8OJn8QjAD?=
 =?us-ascii?Q?AmDiw+yv0rYoWbO5jYndI8+5uVpS7yWtnX3mzUkNZCTnabIGLPHucMJ6Cote?=
 =?us-ascii?Q?5h+DemQq4AuFgwX2igrOkquzqm/eR6G/X36duEKg/ppwl83P73yYFrVHVcnC?=
 =?us-ascii?Q?vIzdxDszr6WjUwVGz5Et59dJohzpGEVabUMvnBRHEQnJQfKwSujvBMiE0xQM?=
 =?us-ascii?Q?NuaTaSudxcq7bj7HNnV635rf3vr/RBsbCbjaMc14PDO3G3cr9Aon8oG/orSG?=
 =?us-ascii?Q?1WMZ1wrS5AKZ4exW4Q6uYxDM63PvoFk6fSzjOBkl1eJJDn16YJa0RYsZc00a?=
 =?us-ascii?Q?mJKZmadNqqPdrezxMXg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284D5F43D6A99C73DF2B93D8B7A2CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4478104d-669c-4961-4450-08dc1dd77984
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 18:57:27.3269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqtuW8siwGCPQkJrC5qn7Dsfxq95Tszq8HULa5hX81fT8n46sDnoVPrBo5L+HKpbTucLLIoZxPcjPrn7oBn5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lei,
 Jun" <Jun.Lei@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284D5F43D6A99C73DF2B93D8B7A2CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Thursday, January 25, 2024 1:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Lei, Jun <Jun.Lei@amd.com=
>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Mahfooz, Hamza <Hamza.Mahf=
ooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/include: Add missing registers/mask for DCN316 and=
 350

Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../include/asic_reg/dcn/dcn_3_1_6_offset.h   |  4 ++
 .../include/asic_reg/dcn/dcn_3_1_6_sh_mask.h  | 10 +++
 .../include/asic_reg/dcn/dcn_3_5_0_offset.h   | 24 +++++++
 .../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h  | 65 +++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
index 222fa8d13269..a05bf8e4f58d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h
@@ -626,6 +626,8 @@
 #define regDTBCLK_DTO2_MODULO_BASE_IDX                                    =
                              2
 #define regDTBCLK_DTO3_MODULO                                             =
                              0x0022
 #define regDTBCLK_DTO3_MODULO_BASE_IDX                                    =
                              2
+#define regHDMICHARCLK0_CLOCK_CNTL                                        =
                              0x004a
+#define regHDMICHARCLK0_CLOCK_CNTL_BASE_IDX                               =
                              2
 #define regPHYASYMCLK_CLOCK_CNTL                                          =
                              0x0052
 #define regPHYASYMCLK_CLOCK_CNTL_BASE_IDX                                 =
                              2
 #define regPHYBSYMCLK_CLOCK_CNTL                                          =
                              0x0053
@@ -638,6 +640,8 @@
 #define regPHYESYMCLK_CLOCK_CNTL_BASE_IDX                                 =
                              2
 #define regPHYFSYMCLK_CLOCK_CNTL                                          =
                              0x0057
 #define regPHYFSYMCLK_CLOCK_CNTL_BASE_IDX                                 =
                              2
+#define regHDMISTREAMCLK_CNTL                                             =
                              0x0059
+#define regHDMISTREAMCLK_CNTL_BASE_IDX                                    =
                              2
 #define regDCCG_GATE_DISABLE_CNTL3                                        =
                              0x005a
 #define regDCCG_GATE_DISABLE_CNTL3_BASE_IDX                               =
                              2
 #define regHDMISTREAMCLK0_DTO_PARAM                                       =
                              0x005b
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
index 8ddb03a1dc39..df84941bbe5b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h
@@ -1933,6 +1933,11 @@
 //DTBCLK_DTO3_MODULO
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO__SHIFT                     =
                                    0x0
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO_MASK                       =
                                    0xFFFFFFFFL
+//HDMICHARCLK0_CLOCK_CNTL
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN__SHIFT                   =
                                    0x0
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL__SHIFT              =
                                    0x4
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN_MASK                     =
                                    0x00000001L
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL_MASK                =
                                    0x00000070L
 //PHYASYMCLK_CLOCK_CNTL
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_EN__SHIFT                 =
                                    0x0
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_SRC_SEL__SHIFT            =
                                    0x4
@@ -1967,6 +1972,11 @@
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL__SHIFT            =
                                    0x4
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_EN_MASK                   =
                                    0x00000001L
 #define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL_MASK              =
                                    0x00000030L
+//HDMISTREAMCLK_CNTL
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL__SHIFT                 =
                                    0x0
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS__SHIFT           =
                                    0x10
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL_MASK                   =
                                    0x00000003L
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS_MASK             =
                                    0x00010000L
 //DCCG_GATE_DISABLE_CNTL3
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK0_GATE_DISABLE__SHIFT       =
                                    0x0
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK1_GATE_DISABLE__SHIFT       =
                                    0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
index 7cf0a625277b..33b5d9be06b1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
@@ -4802,6 +4802,10 @@
 #define regCM0_CM_DEALPHA_BASE_IDX                                        =
                              2
 #define regCM0_CM_COEF_FORMAT                                             =
                              0x0d8c
 #define regCM0_CM_COEF_FORMAT_BASE_IDX                                    =
                              2
+#define regCM0_CM_TEST_DEBUG_INDEX                                        =
                              0x0d8d
+#define regCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                               =
                              2
+#define regCM0_CM_TEST_DEBUG_DATA                                         =
                              0x0d8e
+#define regCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                =
                              2


 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5210,6 +5214,10 @@
 #define regCM1_CM_DEALPHA_BASE_IDX                                        =
                              2
 #define regCM1_CM_COEF_FORMAT                                             =
                              0x0ef7
 #define regCM1_CM_COEF_FORMAT_BASE_IDX                                    =
                              2
+#define regCM1_CM_TEST_DEBUG_INDEX                                        =
                              0x0ef8
+#define regCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                               =
                              2
+#define regCM1_CM_TEST_DEBUG_DATA                                         =
                              0x0ef9
+#define regCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                =
                              2


 // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5618,6 +5626,10 @@
 #define regCM2_CM_DEALPHA_BASE_IDX                                        =
                              2
 #define regCM2_CM_COEF_FORMAT                                             =
                              0x1062
 #define regCM2_CM_COEF_FORMAT_BASE_IDX                                    =
                              2
+#define regCM2_CM_TEST_DEBUG_INDEX                                        =
                              0x1063
+#define regCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                               =
                              2
+#define regCM2_CM_TEST_DEBUG_DATA                                         =
                              0x1064
+#define regCM2_CM_TEST_DEBUG_DATA_BASE_IDX                                =
                              2


 // addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -6026,6 +6038,10 @@
 #define regCM3_CM_DEALPHA_BASE_IDX                                        =
                              2
 #define regCM3_CM_COEF_FORMAT                                             =
                              0x11cd
 #define regCM3_CM_COEF_FORMAT_BASE_IDX                                    =
                              2
+#define regCM3_CM_TEST_DEBUG_INDEX                                        =
                              0x11ce
+#define regCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                               =
                              2
+#define regCM3_CM_TEST_DEBUG_DATA                                         =
                              0x11cf
+#define regCM3_CM_TEST_DEBUG_DATA_BASE_IDX                                =
                              2


 // addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -10568,6 +10584,8 @@
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL             =
                              0x3035
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE                               =
                              0x303a
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                      =
                              2


 // addressBlock: dce_dc_dsc0_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -10697,6 +10715,8 @@
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL             =
                              0x3091
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE                               =
                              0x3096
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                      =
                              2


 // addressBlock: dce_dc_dsc1_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -10827,6 +10847,8 @@
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL             =
                              0x30ed
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE                               =
                              0x30f2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                      =
                              2


 // addressBlock: dce_dc_dsc2_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -10957,6 +10979,8 @@
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL             =
                              0x3149
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX    =
                              2
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE                               =
                              0x314e
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                      =
                              2


 // addressBlock: dce_dc_dsc3_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
index fca72e2ec929..ff77b71167eb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
@@ -16556,6 +16556,13 @@
 #define CM0_CM_COEF_FORMAT__CM_BIAS_FORMAT_MASK                           =
                                    0x00000001L
 #define CM0_CM_COEF_FORMAT__CM_POST_CSC_COEF_FORMAT_MASK                  =
                                    0x00000010L
 #define CM0_CM_COEF_FORMAT__CM_GAMUT_REMAP_COEF_FORMAT_MASK               =
                                    0x00000100L
+
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT               =
                                    0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT            =
                                    0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                 =
                                    0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK              =
                                    0x00000100L
+
 #define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT       =
                                    0x0
 #define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT      =
                                    0x9
 #define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_INC_MODE__SHIFT        =
                                    0xc
@@ -27176,6 +27183,23 @@
 #define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_ON__SHIFT                        =
                                    0x8
 #define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_EN_MASK                          =
                                    0x00000001L
 #define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_ON_MASK                          =
                                    0x00000100L
+
+//DIG0_DIG_BE_CLK_CNTL
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_MODE__SHIFT                          =
                                    0x0
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_CLK_EN__SHIFT                        =
                                    0x4
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SOFT_RESET__SHIFT                    =
                                    0x5
+#define DIG0_DIG_BE_CLK_CNTL__HDCP_SOFT_RESET__SHIFT                      =
                                    0x6
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_CLOCK_ON__SHIFT             =
                                    0xb
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_HDCP_CLOCK_ON__SHIFT        =
                                    0xc
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_TMDS_CLOCK_ON__SHIFT        =
                                    0xd
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_MODE_MASK                            =
                                    0x00000007L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_CLK_EN_MASK                          =
                                    0x00000010L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SOFT_RESET_MASK                      =
                                    0x00000020L
+#define DIG0_DIG_BE_CLK_CNTL__HDCP_SOFT_RESET_MASK                        =
                                    0x00000040L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_CLOCK_ON_MASK               =
                                    0x00000800L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_HDCP_CLOCK_ON_MASK          =
                                    0x00001000L
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_TMDS_CLOCK_ON_MASK          =
                                    0x00002000L
+
 #define DIG0_DIG_BE_CNTL__DIG_DUAL_LINK_ENABLE__SHIFT                     =
                                    0x0
 #define DIG0_DIG_BE_CNTL__DIG_SWAP__SHIFT                                 =
                                    0x1
 #define DIG0_DIG_BE_CNTL__DIG_RB_SWITCH_EN__SHIFT                         =
                                    0x2
@@ -36716,6 +36740,17 @@
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL__DSCC_RATE_CONT=
ROL_BUFFER2_MAX_FULLNESS_LEVEL_MASK  0x0003FFFFL
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONT=
ROL_BUFFER3_MAX_FULLNESS_LEVEL__SHIFT  0x0
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONT=
ROL_BUFFER3_MAX_FULLNESS_LEVEL_MASK  0x0003FFFFL
+
+//DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE__SHI=
FT                                  0x0
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE__SHI=
FT                                  0x8
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE__SHI=
FT                                  0x10
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE__SHI=
FT                                  0x18
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE_MASK=
                                    0x0000001FL
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE_MASK=
                                    0x00001F00L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE_MASK=
                                    0x001F0000L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE_MASK=
                                    0x1F000000L
+
 #define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT       =
                                    0x0
 #define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT      =
                                    0x9
 #define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_INC_MODE__SHIFT        =
                                    0xc
@@ -38488,6 +38523,18 @@
 #define DWB_OGAM_LUT_INDEX__DWB_OGAM_LUT_INDEX_MASK                       =
                                    0x000001FFL
 #define DWB_OGAM_LUT_DATA__DWB_OGAM_LUT_DATA__SHIFT                       =
                                    0x0
 #define DWB_OGAM_LUT_DATA__DWB_OGAM_LUT_DATA_MASK                         =
                                    0x0003FFFFL
+//DWB_OGAM_LUT_CONTROL
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK__SHIFT        =
                                    0x0
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL__SHIFT          =
                                    0x4
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_DBG__SHIFT                =
                                    0x8
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL__SHIFT                =
                                    0xc
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_CONFIG_MODE__SHIFT             =
                                    0x10
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK_MASK          =
                                    0x00000007L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL_MASK            =
                                    0x00000030L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_DBG_MASK                  =
                                    0x00000100L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL_MASK                  =
                                    0x00001000L
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_CONFIG_MODE_MASK               =
                                    0x00010000L
+
 #define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK__SHIFT        =
                                    0x0
 #define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL__SHIFT          =
                                    0x4
 #define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL__SHIFT                =
                                    0xc
@@ -52008,6 +52055,14 @@
 #define DIO_CLK_CNTL__SYMCLK_R_GATE_DIS__SHIFT                            =
                                    0x10
 #define DIO_CLK_CNTL__SYMCLK_G_GATE_DIS__SHIFT                            =
                                    0x11
 #define DIO_CLK_CNTL__DIO_FGCG_REP_DIS__SHIFT                             =
                                    0x14
+#define DIO_CLK_CNTL__DISPCLK_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x15
+#define DIO_CLK_CNTL__SYMCLKA_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x16
+#define DIO_CLK_CNTL__SYMCLKB_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x17
+#define DIO_CLK_CNTL__SYMCLKC_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x18
+#define DIO_CLK_CNTL__SYMCLKD_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x19
+#define DIO_CLK_CNTL__SYMCLKE_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x1a
+#define DIO_CLK_CNTL__SYMCLKF_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x1b
+#define DIO_CLK_CNTL__SYMCLKG_G_HDCP_GATE_DIS__SHIFT                      =
                                    0x1c
 #define DIO_CLK_CNTL__DIO_TEST_CLK_SEL_MASK                               =
                                    0x0000007FL
 #define DIO_CLK_CNTL__DISPCLK_R_GATE_DIS_MASK                             =
                                    0x00000200L
 #define DIO_CLK_CNTL__DISPCLK_G_GATE_DIS_MASK                             =
                                    0x00000400L
@@ -52019,6 +52074,16 @@
 #define DIO_CLK_CNTL__SYMCLK_R_GATE_DIS_MASK                              =
                                    0x00010000L
 #define DIO_CLK_CNTL__SYMCLK_G_GATE_DIS_MASK                              =
                                    0x00020000L
 #define DIO_CLK_CNTL__DIO_FGCG_REP_DIS_MASK                               =
                                    0x00100000L
+
+#define DIO_CLK_CNTL__DISPCLK_G_HDCP_GATE_DIS_MASK                        =
                                    0x00200000L
+#define DIO_CLK_CNTL__SYMCLKA_G_HDCP_GATE_DIS_MASK                        =
                                    0x00400000L
+#define DIO_CLK_CNTL__SYMCLKB_G_HDCP_GATE_DIS_MASK                        =
                                    0x00800000L
+#define DIO_CLK_CNTL__SYMCLKC_G_HDCP_GATE_DIS_MASK                        =
                                    0x01000000L
+#define DIO_CLK_CNTL__SYMCLKD_G_HDCP_GATE_DIS_MASK                        =
                                    0x02000000L
+#define DIO_CLK_CNTL__SYMCLKE_G_HDCP_GATE_DIS_MASK                        =
                                    0x04000000L
+#define DIO_CLK_CNTL__SYMCLKF_G_HDCP_GATE_DIS_MASK                        =
                                    0x08000000L
+#define DIO_CLK_CNTL__SYMCLKG_G_HDCP_GATE_DIS_MASK                        =
                                    0x10000000L
+
 #define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_STATUS__SHIFT         =
                                    0x0
 #define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_MESSAGE__SHIFT        =
                                    0x1
 #define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_STATUS_MASK           =
                                    0x00000001L
--
2.43.0


--_000_CH0PR12MB5284D5F43D6A99C73DF2B93D8B7A2CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 25, 2024 1:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Lei, Jun &lt=
;Jun.Lei@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; M=
ahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Went=
land@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/include: Add missing registers/mask for DCN=
316 and 350</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Cc: Jun Lei &lt;Jun.Lei@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Cc: Hamza Mahfooz &lt;hamza.mahfooz@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
---<br>
&nbsp;.../include/asic_reg/dcn/dcn_3_1_6_offset.h&nbsp;&nbsp; |&nbsp; 4 ++<=
br>
&nbsp;.../include/asic_reg/dcn/dcn_3_1_6_sh_mask.h&nbsp; | 10 +++<br>
&nbsp;.../include/asic_reg/dcn/dcn_3_5_0_offset.h&nbsp;&nbsp; | 24 +++++++<=
br>
&nbsp;.../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h&nbsp; | 65 +++++++++++++=
++++++<br>
&nbsp;4 files changed, 103 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h<br>
index 222fa8d13269..a05bf8e4f58d 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_offset.h<br>
@@ -626,6 +626,8 @@<br>
&nbsp;#define regDTBCLK_DTO2_MODULO_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regDTBCLK_DTO3_MODULO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0022<br>
&nbsp;#define regDTBCLK_DTO3_MODULO_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regHDMICHARCLK0_CLOCK_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x004a<br>
+#define regHDMICHARCLK0_CLOCK_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regPHYASYMCLK_CLOCK_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x0052<br>
&nbsp;#define regPHYASYMCLK_CLOCK_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regPHYBSYMCLK_CLOCK_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x0053<br>
@@ -638,6 +640,8 @@<br>
&nbsp;#define regPHYESYMCLK_CLOCK_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regPHYFSYMCLK_CLOCK_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x0057<br>
&nbsp;#define regPHYFSYMCLK_CLOCK_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regHDMISTREAMCLK_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x0059<br>
+#define regHDMISTREAMCLK_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regDCCG_GATE_DISABLE_CNTL3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x005a<br>
&nbsp;#define regDCCG_GATE_DISABLE_CNTL3_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regHDMISTREAMCLK0_DTO_PARAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x005b<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h<br>
index 8ddb03a1dc39..df84941bbe5b 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_6_sh_mask.h<br>
@@ -1933,6 +1933,11 @@<br>
&nbsp;//DTBCLK_DTO3_MODULO<br>
&nbsp;#define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFFFFFFFFL<br>
+//HDMICHARCLK0_CLOCK_CNTL<br>
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN__SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x0<br>
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL__SHIFT&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x00000001L<br>
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL_MASK&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000007=
0L<br>
&nbsp;//PHYASYMCLK_CLOCK_CNTL<br>
&nbsp;#define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_EN__SHIFT&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x0<br>
&nbsp;#define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_SRC_SEL__SHIFT&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
@@ -1967,6 +1972,11 @@<br>
&nbsp;#define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL__SHIFT&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
&nbsp;#define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_EN_MASK&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x00000001L<br>
&nbsp;#define PHYFSYMCLK_CLOCK_CNTL__PHYFSYMCLK_FORCE_SRC_SEL_MASK&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000030L<br=
>
+//HDMISTREAMCLK_CNTL<br>
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL__SHIFT&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<=
br>
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL_MASK&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000003L<br>
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000L<br>
&nbsp;//DCCG_GATE_DISABLE_CNTL3<br>
&nbsp;#define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK0_GATE_DISABLE__SHIFT&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK1_GATE_DISABLE__SHIFT&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h<br>
index 7cf0a625277b..33b5d9be06b1 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h<br>
@@ -4802,6 +4802,10 @@<br>
&nbsp;#define regCM0_CM_DEALPHA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 2<br>
&nbsp;#define regCM0_CM_COEF_FORMAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0d8c<br>
&nbsp;#define regCM0_CM_COEF_FORMAT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM0_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0d8d<br>
+#define regCM0_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM0_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x0d8e<br>
+#define regCM0_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -5210,6 +5214,10 @@<br>
&nbsp;#define regCM1_CM_DEALPHA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 2<br>
&nbsp;#define regCM1_CM_COEF_FORMAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0ef7<br>
&nbsp;#define regCM1_CM_COEF_FORMAT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM1_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0ef8<br>
+#define regCM1_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM1_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x0ef9<br>
+#define regCM1_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -5618,6 +5626,10 @@<br>
&nbsp;#define regCM2_CM_DEALPHA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 2<br>
&nbsp;#define regCM2_CM_COEF_FORMAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1062<br>
&nbsp;#define regCM2_CM_COEF_FORMAT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM2_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1063<br>
+#define regCM2_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM2_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x1064<br>
+#define regCM2_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -6026,6 +6038,10 @@<br>
&nbsp;#define regCM3_CM_DEALPHA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 2<br>
&nbsp;#define regCM3_CM_COEF_FORMAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11cd<br>
&nbsp;#define regCM3_CM_COEF_FORMAT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM3_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11ce<br>
+#define regCM3_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regCM3_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x11cf<br>
+#define regCM3_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -10568,6 +10584,8 @@<br>
&nbsp;#define regDSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x3035<br>
&nbsp;#define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x303a<br>
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dsc0_dispdec_dsc_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -10697,6 +10715,8 @@<br>
&nbsp;#define regDSCC1_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x3091<br>
&nbsp;#define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3096<br>
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dsc1_dispdec_dsc_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -10827,6 +10847,8 @@<br>
&nbsp;#define regDSCC2_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x30ed<br>
&nbsp;#define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x30f2<br>
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dsc2_dispdec_dsc_dcperfmon_dc_perfmon_dispdec=
<br>
@@ -10957,6 +10979,8 @@<br>
&nbsp;#define regDSCC3_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;#define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x3149<br>
&nbsp;#define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_ID=
X&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x314e<br>
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: dce_dc_dsc3_dispdec_dsc_dcperfmon_dc_perfmon_dispdec=
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h<br>
index fca72e2ec929..ff77b71167eb 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h<br>
@@ -16556,6 +16556,13 @@<br>
&nbsp;#define CM0_CM_COEF_FORMAT__CM_BIAS_FORMAT_MASK&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
&nbsp;#define CM0_CM_COEF_FORMAT__CM_POST_CSC_COEF_FORMAT_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000010L<br>
&nbsp;#define CM0_CM_COEF_FORMAT__CM_GAMUT_REMAP_COEF_FORMAT_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000010=
0L<br>
+<br>
+//CM0_CM_TEST_DEBUG_INDEX<br>
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8<br>
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00=
0000FFL<br>
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100L<br>
+<br>
&nbsp;#define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x9<br>
&nbsp;#define DC_PERFMON10_PERFCOUNTER_CNTL__PERFCOUNTER_INC_MODE__SHIFT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc<br>
@@ -27176,6 +27183,23 @@<br>
&nbsp;#define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_ON__SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8<br>
&nbsp;#define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_EN_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
&nbsp;#define DIG0_AFMT_CNTL__AFMT_AUDIO_CLOCK_ON_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100L<br>
+<br>
+//DIG0_DIG_BE_CLK_CNTL<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_MODE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_CLK_EN__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SOFT_RESET__SHIFT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x5<br>
+#define DIG0_DIG_BE_CLK_CNTL__HDCP_SOFT_RESET__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x6<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_CLOCK_ON__SHIFT&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_HDCP_CLOCK_ON__SHIFT&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0xc<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_TMDS_CLOCK_ON__SHIFT&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0xd<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_MODE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000007L<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_CLK_EN_MASK&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000010L<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SOFT_RESET_MASK&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x00000020L<br>
+#define DIG0_DIG_BE_CLK_CNTL__HDCP_SOFT_RESET_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000040L<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_CLOCK_ON_MASK&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000800L<br=
>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_HDCP_CLOCK_ON_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00001000L<br>
+#define DIG0_DIG_BE_CLK_CNTL__DIG_BE_SYMCLK_G_TMDS_CLOCK_ON_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00002000L<br>
+<br>
&nbsp;#define DIG0_DIG_BE_CNTL__DIG_DUAL_LINK_ENABLE__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DIG0_DIG_BE_CNTL__DIG_SWAP__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x1<br>
&nbsp;#define DIG0_DIG_BE_CNTL__DIG_RB_SWITCH_EN__SHIFT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2<br>
@@ -36716,6 +36740,17 @@<br>
&nbsp;#define DSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL__DSCC_RATE=
_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_MASK&nbsp; 0x0003FFFFL<br>
&nbsp;#define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE=
_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__SHIFT&nbsp; 0x0<br>
&nbsp;#define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE=
_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_MASK&nbsp; 0x0003FFFFL<br>
+<br>
+//DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE<br>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE__SHI=
FT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE__SHI=
FT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8<br>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE__SHI=
FT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE__SHI=
FT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x18<br>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE_MASK=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000001FL<br=
>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE_MASK=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00001F00L<br=
>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE_MASK=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x001F0000L<br=
>
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE_MASK=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1F000000L<br=
>
+<br>
&nbsp;#define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x9<br>
&nbsp;#define DC_PERFMON17_PERFCOUNTER_CNTL__PERFCOUNTER_INC_MODE__SHIFT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc<br>
@@ -38488,6 +38523,18 @@<br>
&nbsp;#define DWB_OGAM_LUT_INDEX__DWB_OGAM_LUT_INDEX_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001FFL<br>
&nbsp;#define DWB_OGAM_LUT_DATA__DWB_OGAM_LUT_DATA__SHIFT&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DWB_OGAM_LUT_DATA__DWB_OGAM_LUT_DATA_MASK&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0003FFFFL<br>
+//DWB_OGAM_LUT_CONTROL<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK__SHIFT&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL__SHIFT&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_DBG__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL__SHIFT&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_CONFIG_MODE__SHIFT&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000007L<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL_MASK&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000030L<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_DBG_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x00000100L<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x00001000L<br>
+#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_CONFIG_MODE_MASK&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010000L<br=
>
+<br>
&nbsp;#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_WRITE_COLOR_MASK__SHIFT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_READ_COLOR_SEL__SHIFT&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4<br>
&nbsp;#define DWB_OGAM_LUT_CONTROL__DWB_OGAM_LUT_HOST_SEL__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc<=
br>
@@ -52008,6 +52055,14 @@<br>
&nbsp;#define DIO_CLK_CNTL__SYMCLK_R_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
&nbsp;#define DIO_CLK_CNTL__SYMCLK_G_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11<br>
&nbsp;#define DIO_CLK_CNTL__DIO_FGCG_REP_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x14<br>
+#define DIO_CLK_CNTL__DISPCLK_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x15<br>
+#define DIO_CLK_CNTL__SYMCLKA_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x16<br>
+#define DIO_CLK_CNTL__SYMCLKB_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x17<br>
+#define DIO_CLK_CNTL__SYMCLKC_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x18<br>
+#define DIO_CLK_CNTL__SYMCLKD_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x19<br>
+#define DIO_CLK_CNTL__SYMCLKE_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x1a<br>
+#define DIO_CLK_CNTL__SYMCLKF_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x1b<br>
+#define DIO_CLK_CNTL__SYMCLKG_G_HDCP_GATE_DIS__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x1c<br>
&nbsp;#define DIO_CLK_CNTL__DIO_TEST_CLK_SEL_MASK&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00=
00007FL<br>
&nbsp;#define DIO_CLK_CNTL__DISPCLK_R_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000200L<br=
>
&nbsp;#define DIO_CLK_CNTL__DISPCLK_G_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000400L<br=
>
@@ -52019,6 +52074,16 @@<br>
&nbsp;#define DIO_CLK_CNTL__SYMCLK_R_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0001000=
0L<br>
&nbsp;#define DIO_CLK_CNTL__SYMCLK_G_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0002000=
0L<br>
&nbsp;#define DIO_CLK_CNTL__DIO_FGCG_REP_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00=
100000L<br>
+<br>
+#define DIO_CLK_CNTL__DISPCLK_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00200000L<br>
+#define DIO_CLK_CNTL__SYMCLKA_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00400000L<br>
+#define DIO_CLK_CNTL__SYMCLKB_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00800000L<br>
+#define DIO_CLK_CNTL__SYMCLKC_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01000000L<br>
+#define DIO_CLK_CNTL__SYMCLKD_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x02000000L<br>
+#define DIO_CLK_CNTL__SYMCLKE_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x04000000L<br>
+#define DIO_CLK_CNTL__SYMCLKF_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x08000000L<br>
+#define DIO_CLK_CNTL__SYMCLKG_G_HDCP_GATE_DIS_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10000000L<br>
+<br>
&nbsp;#define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_STATUS__SHIFT&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_MESSAGE__SHIFT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<br>
&nbsp;#define DIO_PSP_INTERRUPT_STATUS__DIO_PSP_INTERRUPT_STATUS_MASK&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284D5F43D6A99C73DF2B93D8B7A2CH0PR12MB5284namp_--
