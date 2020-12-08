Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A8C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CD523B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CD523B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9EA6E9BC;
	Tue,  8 Dec 2020 19:29:01 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229646E9BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNqpRhbWp55Fj9rFrde0OmAULXRMaT//YXjTYlLyX6OHmsn2pio01e2rqk6uoml3xDlRZPtGi1gIo0nuHpgKoxi5YS/+BlsX+QWV1vMOcdO0X5ZCf0SEXNv3o1mib9TxqsmC7dkaJJYOlX5QkduWflQrg5EAKCpX+mK7137yQ/U64euohHCc5wou59+OJMtpqXGepTXAj8i+7JustqJD6/4Hoph93dGgEZbT71kq257EBN/ZucV8WJNluB1uYq+C8hjZwRb8vI5c9fnI2hmX89asjccIUb4Wcrgx4COXefOiOhceQdVUMFGbkLyKrs7umsk03EHWmnPdLeCgcexG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNcusmOZ8XacQRPIoZjjaXaVN4zW9UO/EtnBC6LC7T8=;
 b=WhLwNmxc1DNq4tbSF0ybAyt8CDvATcOR2qobSt24HVfxca67/ckQWIAw2b4dwSDTUsi2whyfw8sHTpf0RZKrcutVlmYm+o66qrhys4MVp2t+BGYzWjuCk2c7zY7ZVApVZhElRGg6JKjGCyW2vW0cu3dEQIwRGn/uO9KjohnytAW4Diqfw0HvY6Odjr7jgdYypCcFngUimgYvnZXBUHHc9CG6vTjr4GQFe8pbp2a+RfN5FGqKFldETK9NCHdxk6Q8q7xAXcLoH4FvMOcYreldpVJdCspYWPuomqsPqCZxaKD5BxUNiP1/4bfJrAd1h2z/Gia8Fiw6mgL44A4Ni0aD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNcusmOZ8XacQRPIoZjjaXaVN4zW9UO/EtnBC6LC7T8=;
 b=BXJp8s9T10XecjbpeFkkXGUse/AabGy2c0zm364Q/FDtr4Nmca3OckNtEIlP6as3cnQJANbvhg7VHHSmmS8SLKKLZtodA4pTqfCFPtD0EhhS1pnZ/T+ml8CNb4GernqSPY9JKiY1pK8hSJJM1HJJ8kRtF5Q6+Z+Ldrr0qDXbeR4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:28:59 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:28:59 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/13] drm/amd/display: add
 dcn30_link_encoder_validate_output_with_stream to header
Date: Tue,  8 Dec 2020 14:28:36 -0500
Message-Id: <20201208192844.23580-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78e86c52-18b6-4d74-9068-08d89baf8344
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388A69461B858978C9848F2FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:137;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cP91WsfrqMURDx/92gQzarMXVA0IeBfpcWn9PGhWntzgwcPdwDmJyB0Al4E/ArltHKDrZ8ykfKUBizXuWTZsXOMUYfsLbpxxdcfJI9B2r+RaHfESuEvlOlMKF5mwTTE1uf4HDFJJlSia9HtmMFJ+9sYRdcCjCMumT/zTCrLEBT6r0ZcmgSsnEYbzHP0d05tjyw0fIS2CB2LQ64fzvr8tI7yLSULcjW1eBEqSCajIVAVtIZUnhKo5kcuWhF1c2cMI9YrSjGsvyUG4VsMBVDBbREUsXMgK4aJ8XGg+/jEj+NmQ981onm7Tzc7LhpX1kBs/FlM+Xqzaha3eMDy3SwfCopyyx7HqWnl5DNZGDbowSG0UHAm4oUwF3i9frZ9gSPnrFTs5ZSuub5evnq+vWHG/nfjui6izphDJjJrcQJqNsMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z81vtPGAGqf/xi7VyWMlqFX8VROekTvzf1Ny7fFuLF/HU33KjchJyF5uh4gc?=
 =?us-ascii?Q?DIogLcVyBN57ldVEgWuf9r0AEHWL9mke32zMH1at/GUKPwFCvW/zbXtwihlW?=
 =?us-ascii?Q?LPyQA77tSEKoPf3i+0vbdfHOKUVpopSL5NzSbVfuBmqer+whJL9o4uJ0vzIH?=
 =?us-ascii?Q?MVtSyAYYix3STViT7LsL3rCIY3tR8P1afZxpQaYwBOiXjQPkgKqiO1prvq8V?=
 =?us-ascii?Q?gU/MsWKCiW16Wp84z6OMs1t+tVfb2c0YK4erzICZqqHhnCHybGtXL5a4UdWS?=
 =?us-ascii?Q?tBnwDgaSJEZ67fShQbRa3ngLUQqGGxDpZ1fM3+z3UpY/qC+0bHRWZgxibm7X?=
 =?us-ascii?Q?M3tDKoSZOR+CHREHmr9s0JNzIaCQXW/DovBcyq/+YOQNW2Eq8d4Yz5bZb7cu?=
 =?us-ascii?Q?oNCgZeUlCuOJXVMMSfCCJGAa38+cKnYRT1UKQUKDsosoMAlgCbbU4gjN6yV7?=
 =?us-ascii?Q?ypENXxLDEJL7Mk7r9Qe9iBfkH5fp+qzrtIiW1zmef8O9UUVSh8WGf3lnahTh?=
 =?us-ascii?Q?H/HA8sbB6stHQA9Ftal4xVy/+xOqmfe8L+SW7/9Z3SZwVxfbNH3zs66D9vyP?=
 =?us-ascii?Q?AUSFSyfj+XuVlcUGXmPFjxs4jcRKqj92RNiznzlAhTCTZLsUaYRG+zw8/mdB?=
 =?us-ascii?Q?u+RIuoFwvmk7DwlqymUbFRNMxnsg5RPF5X9eVWsVZmn6Uw8ZPj2ifZxdABNa?=
 =?us-ascii?Q?KMZ3YWn2wZd6y+Iu9HbUyF/agANP/BVadzgSEI1kcYgD1T3HR3pWieYrwe4X?=
 =?us-ascii?Q?mHPq23d+xm8QmnHpHu/r7R/kBMTjR9bst00zbkNfRjUxv1YCy+1rkUeB9NHO?=
 =?us-ascii?Q?SxwvgxRo+kzyYYc9VNI0vEorflrGnCRRH2EaFjkvhnof31P6HYOONFUKVWcQ?=
 =?us-ascii?Q?wRcYV/UVCTl02IAddL54QFs2Obkl1Ga42W1PKQguLkFuyG/4TfboHmM/HC8o?=
 =?us-ascii?Q?LouZkk6RqBvJu9EYEWJCMQ1ToTQxVKpp2gWcgvWIv5thcNbhWp0JsCgAZeWi?=
 =?us-ascii?Q?bxsp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:28:59.5906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e86c52-18b6-4d74-9068-08d89baf8344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhc84Els/ADp7lk+BmuyVUNKf3BM60obr+YI+UKn+xDcUuSwjrRJ4B054+F6k6LI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
dcn30_link_encoder_validate_output_with_stream was a static function.

[How]
remove the static define and include it in the header.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index b409f6b2bfd8..4592ccdfa9b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -119,7 +119,7 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
 	.disable_hpd = dce110_link_encoder_disable_hpd,
 	.is_dig_enabled = dce110_is_dig_enabled,
 	.destroy = dce110_link_encoder_destroy,
-	.get_max_link_cap = dce110_link_encoder_get_max_link_cap
+	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
 };
 
 static enum bp_result link_transmitter_control(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
index 2ae159e2dd6e..46ea39f5ef8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
@@ -51,7 +51,7 @@
 	(enc10->link_regs->index)
 
 
-static bool dcn30_link_encoder_validate_output_with_stream(
+bool dcn30_link_encoder_validate_output_with_stream(
 	struct link_encoder *enc,
 	const struct dc_stream_state *stream)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
index 2fbf879cd327..f2d90f2b8bf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
@@ -78,4 +78,8 @@ void dcn30_link_encoder_construct(
 
 void enc3_hw_init(struct link_encoder *enc);
 
+bool dcn30_link_encoder_validate_output_with_stream(
+	struct link_encoder *enc,
+	const struct dc_stream_state *stream);
+
 #endif /* __DC_LINK_ENCODER__DCN30_H__ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
