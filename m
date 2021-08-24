Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF00C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFB461BA5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DFB461BA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099AD6E075;
	Tue, 24 Aug 2021 17:07:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819E96E075
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcYP9vBkvbKNZBQA4aEp5P1HBtzf0teoVbzMGULkPAvQqEDzWzw43PrMehin9BZpQOCIS/kyjb5gtv3mCrVjkQxz8ZPBOv+xu02FT/nZtCg0JrhInFgowXrF15mm/oQhFci34TELq7yq8eo4CwI0PtyoE9m+tn3fDZH0xcib31wwLz/0qiyTnoSx76txRc8TTy/02j6knZlgdlH+jarSWoSnFBjD6CIfJjj/KDtmvGltSPjgSIheGbyEWJ4DIqUQHBtdtxEtjUWkrX19hEwL8+HD5wRrcZCjEvimW5FWnAPNyA1AYaGHhXCIAsG18hnQPeXXYHfxuNdkrOR3jskcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeHNBnzgfg5XZn2DojNU18MkUrhaqbcOMyJEfNccGrI=;
 b=OTliRxHH0nquQ7B5TXOWBu/5LgtyhPsNOsamzbu+C8aOkohlF2qsRaCWpvEa7Huyu+3Ei74t8xME25a3TYBkpNK9WxuoAMatjD9s8PJceFEVD+fNLh6hR5iyhunmvGgVn7V0z94xy/xY43fxyHHR0QbBs5ZspWARb1KF6++8OhWwyw2rlHKBBT/ffpeEmAk8pow+H5kbQavZ7ntRItQxGH13juXB7pw0pdDCltjWhUFX/CaQUWRWvC8L0Sac6fHReJi4HLgGJKzH3UpSRfpfjEJ6P/Kynr03Hz2iGpM3XSRC73yV8lgVzKo+nsQ2VQl2zSqAeISm0SbCctYJ5ckuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeHNBnzgfg5XZn2DojNU18MkUrhaqbcOMyJEfNccGrI=;
 b=cE3eoigOAQABhflktqxETVt+YPSr0ws90nhqpsng5dy+2EFJ6EVv7FhSxv07W8COQ8lIAI5mBWxDn8byD8X+FiV75UGU340gZs8JYcJQWmHlReDZbUopI8TwyFlAAmDYy+c/5TKIeOYJvRPYLRBWfNdx3rvMGL7/SJrjShWg47w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:51:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/display: remove unused variable in
 dcn31_hpo_dp_stream_enc_mute_control
Date: Tue, 24 Aug 2021 12:51:05 -0400
Message-Id: <20210824165105.1913700-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824165105.1913700-1-alexander.deucher@amd.com>
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a1329b7-8cdc-494c-0263-08d9671f6a48
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53171EA19BE0368F83544133F7C59@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIr//Ns1UOaRIalyqAwS4C+NZ5+UCLAdNLYqC0EMd7zpJJt7ulBGV2clN2HvKLjHwCPFli6WSUtcrkxrp5lJC6xMWPXOd4CIWEzi8YEEYw8ILEgbR5ZVMEgCIlrdAQ0byYoqPIrHS2EHM8WMde3agIwLst7YQDm/QMjD/oR7IOX+6GCkCA64zMfSPgOyujpQEkbXgzBRLW+lT3r+g0dl3CqFt1OWQPDn3ocMsHQZXAYXGDuUQaLqeCmzpmKkdnhp+ecmwNPGVksR7jzc4SKN2U+t+PX2u82n3j27NMqXv7ViPbLVTnixzlSTlPfGEz0SbZ99aqJsSs2fxhiIy/iXk8xBVJ8n3XJmAjzDUPVVSw1AGXskdKS2lQ5Lp1bIvRqjrxU934nUTJEU0zxRUtE5OGznva1sUtVS2mKm78oMBLjWagRumW2t6QOrYr1tI9mVV0z2h/JOVOY/osEFPGceHTcBawK5zYuewXECH199coemKN35Dcu8f54HjyYQyFUpbpFQ1tY5MaoOZp2/9A6CWh2RZRKoKYfIYDQoJKPyzgMSo8vZGD2PxYwyzB/ocKEHOvGvm/SOIPnci91j+uYIvjEe3Zi6kzHsVldr23K4C3LovI6tbLKNWvq6eOABJ+8Q+hw3RqC/UgFa4VpSmrtpB7knnflIknEXfqOInG/KJsFLpfxYD2AXNDpq+kWqjpjonrSYSbZOTucmYw2HOcuvSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(8676002)(316002)(86362001)(52116002)(7696005)(2906002)(1076003)(36756003)(6916009)(26005)(66946007)(66556008)(66476007)(8936002)(83380400001)(956004)(38350700002)(4744005)(6486002)(5660300002)(186003)(38100700002)(4326008)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byzQ4mrju5bNIOki/f+lOB5xHVOi9HgaN6gJ3zJKLX+gpbxMXdj2vfMTFreC?=
 =?us-ascii?Q?o8auMkudyOOODBtI3g9gyXhhwZwzehTepZbW2zcT/o7Mwa+4Kj7bFxg537yh?=
 =?us-ascii?Q?zwfRdghfNxqTTvVl2qXRl7u9/4zvy77tXhKgYVd6+JIillGf2JNdgF3dDY+4?=
 =?us-ascii?Q?tHQznV4DW5b7sWO54ADgQBPX0S8JrrSNBKgW6kadETWNhWZp+tAGwCWJUAQw?=
 =?us-ascii?Q?Sj7FL7aBQY0LIy9iX03F6l2NFdb2jxtA0rdOYlVqzVxEkRcCnGju0+DTxNoM?=
 =?us-ascii?Q?W4MNbLjCPcAO8xLN5dp2FIeFvZ/xNTSL2Hc/lrKAjgrVQLkIPZiTRxlLiLF5?=
 =?us-ascii?Q?fTFyYQ3vR9bzeA4fDO7hWtiABLynp97+/AFJg8ZQQ3pxaLEUA2W3Q/RF5FOB?=
 =?us-ascii?Q?ULFXcyU1G1bFATDW6/kw6bf4hCbdLZqirMOe/mxM7Q1f+vmWdj90YhnyPpUC?=
 =?us-ascii?Q?ZcyESnA33vWlKqnau1j5Hj160aZUnZJueA3xxPrHpSFCOgxdmRo1uae/bpi0?=
 =?us-ascii?Q?o1S7cHvCwZ+Gd2lA/7MsROgwxMP0Rccp0LlcGTYYeVR8WnWVQksIvjsmzvg4?=
 =?us-ascii?Q?5oR6p+8+nUKDMyRpi0vYPYfmsKlrEeQ+VNzFZBTAxwh/VpWvIdogYjuSNAmt?=
 =?us-ascii?Q?WVNiL2ppYdauoKR/w0FfxlmuPf/LZUEUDLHwuSNdVhPpnaLCpZWG5ij6LYop?=
 =?us-ascii?Q?SUVhj2qAZucLrstXRq2viVk3Lgv28Qauip82tWeGICsy45POEWBjkYE7sDTO?=
 =?us-ascii?Q?XdeXOMC1yBZVgvCLRaCP1kyOMw3Z5LdxAJ6MFEctTRrVhR8cUmRHvItUm9c/?=
 =?us-ascii?Q?F28P6BYn5F6yRtnOqKib/UeKc5dVbb8UyX8+iBn509vG8wHx2qgHZ9Ap/SNO?=
 =?us-ascii?Q?mwyqRlxzDJAv3RKyT7vhNmeip4//xn0em1ImBEATAiFEDiQ+h+R2Omg6a5YZ?=
 =?us-ascii?Q?Vzzj3O9zZr2ieNP9UXehc662Q2h6zDWPs9hx2QTUsOOQBP+T7cj/Z4LC+7Vm?=
 =?us-ascii?Q?lX/Mk8Im35C7vUVQqiqwqE9xjF+lWEe5v8MlBC5jiQiKcWhhNsjvHLZW7uRF?=
 =?us-ascii?Q?d9X+btugSLG48PNtq7qjaqDYqW21zHdfH2u/WmC9axitYkRPBSuLHDLWpbN9?=
 =?us-ascii?Q?Bp2QrdVxZihjCDHpb8punbskUE2YUq5uYdXhLlkXba+tws2hG6V3tK30F/5v?=
 =?us-ascii?Q?yfeSKY+byLG3FY8x581JEkP6N0wUSQu+0akxSw6AxKtZG+kKA/1RbiQCOMiD?=
 =?us-ascii?Q?dEUHGq9bEi59tgSYIQURv99bJUqP8mDo/Fi8X0/hCwnyGlhEBkSherUhfA64?=
 =?us-ascii?Q?XyfJVoFZzAuAIwKz+CY9cISX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1329b7-8cdc-494c-0263-08d9671f6a48
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:27.7563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIcnG+ApXolEagj6DIyA/2mUPlrouip9Bq6HX+hxInroLfH73GSDyOsTHlhLSX09GbTuJBZqEjJtJ3s+x9R3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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

Trivial.

Fixes: c0c9c87bcc5f ("drm/amd/display: Add DP 2.0 HPO Stream Encoder")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index bc265ee06824..25e4794eb9ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -603,8 +603,6 @@ static void dcn31_hpo_dp_stream_enc_mute_control(
 	struct hpo_dp_stream_encoder *enc,
 	bool mute)
 {
-	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
-
 	ASSERT(enc->apg);
 	enc->apg->funcs->audio_mute_control(enc->apg, mute);
 }
-- 
2.31.1

