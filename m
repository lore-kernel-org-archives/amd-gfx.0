Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8BBC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A71A64F64
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A71A64F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C59E6ECE8;
	Fri, 12 Mar 2021 03:53:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794C06ECE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 03:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN2Ensp7WFRTehJ75mkdVKEJPBibS7i59WGOldaB1r6sAD4TfQDzAra0FHagqNYcWRgXl82PGpl1sH8wWyJ32qIaAuldbZaki5oTNlJloiHdv24DkkzZkFUG6KY4+8JOoej4dWEySSaF8gaSvrfJUi5Dc89Wqsx9l/H9rWvdrah/Up1eYW5vV4DxtHYSHfTIKONiZoZG9g7bHmBRk8+lm2mwSTpDfTnbw6JdlKvWNeRjUygSalMKcmq1R3qsRIjXJe+1QlXnJIwjaJmxCf+tkBlT8l8N8t5CLtrvZpFfgQPX//3q9LMZ9WPW+4JcS+ex/ifuZqdgWiv4pkn7iQQyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHCxYdaG7Y8YIL1m7Yq77emy26YTG2Ao76pLmoGBaVQ=;
 b=SKR8kWk+e7tUrqh/gaE7gDZ8784CaPaeyFwWlAV5DUZhq22vmbu7AObSUtUaBmNJb9+0L2PrjbUocqpIoifi/4CXvUgzrSVy5gYf6uqJjwd1ygFczfDn44CirLiZZJBVDy4aJyzljCmmSsXqvL6zWgxpR80oY5vhRazaxYPBo5kGHHo7CGBsT0QA/xASWZerl4cqpVGP0WKpntLvFDUVPGQ18hJ9ZuQgiMbeafDx5KCi+dO82JWh5GbVoad97wmsL7DfxNckdugXFekpw9ZD1VziN/IBTsEAp6oYRvZj57UtRKH+Ij+Z85YtGjP3KTvddJ9FCUy2+InfTRiYRZ+MOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHCxYdaG7Y8YIL1m7Yq77emy26YTG2Ao76pLmoGBaVQ=;
 b=B6OEcru24ox4AhI87MdjshN9DNU/XeXMBLdcEPES9TokXiKHHLxbB9bLA6b/grF9YaH+FCFucmlnJbfPCaAEb8qPt3VPzSe7fRUdNUBa0wmrgPXjjlMgC1hJPk9bQqSE22+7SFMnbDO+COmQ15imxhy2R1tt1mHPJbY8+bPQGS4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Fri, 12 Mar 2021 03:53:42 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 03:53:42 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: update umc_info v3_3 structure for ECC
Date: Fri, 12 Mar 2021 11:53:15 +0800
Message-Id: <20210312035316.2631-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:c9::23) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HKAPR03CA0036.apcprd03.prod.outlook.com (2603:1096:203:c9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.11 via Frontend Transport; Fri, 12 Mar 2021 03:53:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fad2f4d5-4b58-47d5-6531-08d8e50a6d6d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449AE362F92A54FE42FCECEFC6F9@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNpy92lp1Wg5y+/a/RXsxL76J7LeD94lMoL39nIg+2DolO+V9v26OEgz3fSMRfIwLI0qLEqeMmGXfgiQ2362XvwUUIRKJ5QWCTkP9Y8R/UGHMaNj05w/zxbpsUqgv8kZOkbP+g+xl/bCViPSyT6T+XX8bokSgHgYHPMhQwND7W1hsbgMp1x7bqaY0MYG/1VFZyVB/InHJOoESuv8U35uHEj0/bMmICBQ5w8NpQHVfhzR/WPA1+akvqUasXCdMv8ZoQKkOBt9sgowKQP8RlufC5YTu3hpEot8JiReSJkoa+3p5GVlVtFUYEhnB7hRa1jyvIfjyt/GjsJWDnAaYA3QmpvUxkbgwPpzt2X52e9upiPHRwDhmknH8pRntWRiNAYNi9EaDSsSHWFALUNmCntZH2XenVEAwGs+6qzMn6CImdB/rLuAYPE7sj7dik84rYvN6mcxqI3nDT3+E6KBVrv40zoJHDSerKzaRcbZHyMyPQt2omiM9tMvthdA2YwAp056L38Dt8lOmzcG77/fIpxkIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(36756003)(316002)(26005)(6486002)(2906002)(478600001)(8936002)(7696005)(6916009)(956004)(2616005)(1076003)(6666004)(8676002)(66556008)(66476007)(86362001)(66946007)(5660300002)(186003)(16526019)(52116002)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8ofwI6ET6MQvU0MKFUzmNzFsN8xZAsrEHUFaYPlRwcwtuTRC7P6mP69YdZy1?=
 =?us-ascii?Q?tg8suuGazPe6v1CQF257mTBfWfKJQPbJBQOL6KrQWi5360at23iDjE1WdS4e?=
 =?us-ascii?Q?sLd1IcgLmny05ohiTC9Bviurn/FiR3KmzrvT3aVEEEq6vOclO5ql2Oci1HPU?=
 =?us-ascii?Q?z6Tyft7GG4DwU3IoioZy8nd7aXF88l14iaN+u0MyhOg2z02dJpdWxNNHJJ5M?=
 =?us-ascii?Q?BC2Ii0hxI4qSU0o5KhJRLDlYkSD+X47yAM4sTfXnGO7XSds0FzPwQXLZq12Y?=
 =?us-ascii?Q?Zt7+SvT/5plWoa+8j12RV5aFIuWE3fC2KWbjgcSHDTxvfM11Gyih60BwDAfj?=
 =?us-ascii?Q?YbGyCvde8td6p60L49tv4wWz1QVJzTC/L8udWfUjCfHn7w1X/pM+b2uLJX9g?=
 =?us-ascii?Q?khUdbrFfnn084H3fbc2COOq2NeJt+VVoYoOn9De1aBSF8HosxALoDcMChNGN?=
 =?us-ascii?Q?s1cnWFiiD7W+UoaX5nr+jqTjes1xq6mtspIN739OSuh3wNdNjOLkEs5AfohQ?=
 =?us-ascii?Q?D5SNVhN92ihPNyzoEM3VfuFyl7Kf4sCgVK3adRzK5FSUm7fmBAx9r4DD3apl?=
 =?us-ascii?Q?TtRym2Pt9CbnL/Hkuzp5UgxFMiyr5g/7wpKvqLzEQoyoxJ1v6j0py1Tx7ue6?=
 =?us-ascii?Q?LivrwndWIQKV7B6JF5U5q9NSRAI4KJqUK90faPyXEVgu2zEzKXlZ16sdbBY9?=
 =?us-ascii?Q?22oIo4qKmSHeG9ZJ5sPYIXvW8zrAAIoY1X9PkDkbHJAkFk2bI9kDqIa9rsR6?=
 =?us-ascii?Q?KZ3aZhDtK92RgpsGbZAfuuoz1Uj/cK3NQLsHn2YJa29qBOCmpOgx9TyB7kme?=
 =?us-ascii?Q?BHsj9v8NqvM+0DL2FmTn5R/nVggutJ1VTob+KVAlyPUllxGc+6WZRMBaf7QD?=
 =?us-ascii?Q?gMZZ0ZaWy1HF5p+NqRB0XmUY7GQdZ+2Owf88VCxmVcx9qJdWammfWNnqOS9d?=
 =?us-ascii?Q?TTDRGGD87nm+sI5EvmExQox0R6IMzgRrSFHABUMEbjhGHAAXYGJzlVRX2Ng9?=
 =?us-ascii?Q?nHWovhmvZOYzTcTmpVqdbf9WeMnuvDcDZwMSy6MlsmVuxNn9ZdFt4FMCU/y4?=
 =?us-ascii?Q?vTDSaWB+yoKsjp7hmsGhv1KLbNT1n373QG5H0we60oImrPBqVEGqMe487xIu?=
 =?us-ascii?Q?RylDDf4cTPTWq5rXWMAv7gmQ8PyS3ld8GR87mKYOma8YN6fBazrdnBNWp//q?=
 =?us-ascii?Q?7smiGv2YaiqLGOgtvnDUl6oSJj4hY48uB47kD4mjpjJPawYbIc/Puw2SO+5i?=
 =?us-ascii?Q?39K+UM6CSAfQ+yJrznlK1c2+nIRGSPnbDc0pQV2MLI4B2QZfEf23V8y0hu54?=
 =?us-ascii?Q?EWB8tomRjoFu2eHIOCvwkcg0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad2f4d5-4b58-47d5-6531-08d8e50a6d6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 03:53:42.5097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0S9Gn7rhFGlcuOebb8qXdHpFM3kBXO6SzCjziIOmrvIhiMqTeOBo08MHiT2qv1a4dORb/eijs+7zCY4TGz63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

new member introduced in umc_info v3_3 to indicate
ECC capability

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3cb8d4c5c1a3..6b28c120c6b3 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2537,7 +2537,18 @@ struct atom_umc_info_v3_3
   uint32_t pstate_uclk_10khz[4];
   uint16_t umcgoldenoffset;
   uint16_t densitygoldenoffset;
-  uint32_t reserved[4];
+  uint32_t umc_config1;
+  uint32_t bist_data_startaddr;
+  uint32_t reserved[2];
+};
+
+enum atom_umc_config1_def {
+	UMC_CONFIG1__ENABLE_PSTATE_PHASE_STORE_TRAIN = 0x00000001,
+	UMC_CONFIG1__ENABLE_AUTO_FRAMING = 0x00000002,
+	UMC_CONFIG1__ENABLE_RESTORE_BIST_DATA = 0x00000004,
+	UMC_CONFIG1__DISABLE_STROBE_MODE = 0x00000008,
+	UMC_CONFIG1__DEBUG_DATA_PARITY_EN = 0x00000010,
+	UMC_CONFIG1__ENABLE_ECC_CAPABLE = 0x00010000,
 };
 
 /* 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
