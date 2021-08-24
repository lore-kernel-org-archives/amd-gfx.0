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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D46C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9FF619A6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF9FF619A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703536E041;
	Tue, 24 Aug 2021 17:07:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8CA6E041
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIe76qky7ltVIv4kemeApTeCr35HRkYJ8cJUSOdiuq7fqUOxj0V4k4eiEluPGJOlDrvCGnQ9ZobBjDeFIDb5P4iI69XYX/rLG714BgUsQgtbim3E+487U6LJKWjlzpCua+UulLRLtYZQaE9O9eHUrayaWjXJjhfN5G9TQHEJIi3PN06INrO9618EbcdBX1owTwE22SVIrNio/+eYDXetXPFzSpAhnyq44gsJGJ2raeIyq82oRZOxTUsM/s103SewPFV7J04ct43DxpT5quRX3iXgMUpigI1WYcqADzJT/q2POos6IutnBpMa7oGaKC553I8V3oPEkO1BqTCpl2PocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKF/GQ582Qk01e0aL10axC34QiIwfIBi+Yc53Ds2dxw=;
 b=nQT0xTKqxxaxW4/xnWTjZVAV9w+y5YOlYx9jVVpYNCTM9YwI2F0tDl9Xrun5yr54A2IinXAQqB4JhVE9SARm+ewJiB+4Z7rN0m576z39VUMTBv4esXq5oPTu+kxRDC7vkpfBgwXAOTRNg/AHXJB1HkQLFPVFgb5NORVSmR6N4FtoeJWLed3rkb2JPxsXuLX3k06oCutwJ+BS2ZCb9DUYyipDVuFIq0IDru1ro1ChA7b2TWiZaRd3lU0Fv9YHvadWln1uk92VXuAqDQ64RX3KlTDTXXB2oC0xpzh0NGeuxNbazyUDvQA5uUDGLiLeeNY2K9ZwUtQV6vB0jfX7tmAh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKF/GQ582Qk01e0aL10axC34QiIwfIBi+Yc53Ds2dxw=;
 b=jMkHa5n1krYD8zjZtBioZUOtnHF0DXSv9Be4M/GYVi7y5K67aX0eeF7AbHTW1WJcrSjleqzoq1tx2/Cgxp0EDuCdqcNTshrKLcD2E+sIOAjfqm722v1sIai2hZMl6FpH1DZ4ujvE3xTHkkt6n75Ud0mVxsD7qjCED0cTMq0q1S8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:51:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/display: remove unused function
 dp2_update_mst_stream_alloc_table
Date: Tue, 24 Aug 2021 12:51:03 -0400
Message-Id: <20210824165105.1913700-6-alexander.deucher@amd.com>
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
 Transport; Tue, 24 Aug 2021 16:51:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ada102-430d-42da-3cf9-08d9671f68fa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53175C8C426A47B606F62F3AF7C59@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBe++MgKDU+kucg6wu6XDK7iUkw/al2FR616DLN20NEOBtqS8Ac8EQW87AY/leyHWNDzfUoPpPQRDTGh/Qym4w9Imr/5ZUASQWrAc/oOQG3xp7sBZ+NPVMat+52sirnsXQ6+6l3EpMQHw595DGS02NYD3W2WvwvEkj2jIQYREKNLgmn3dKkc9wlZiUBQHvhKwbttDBtt5Zub8knJxIFtC1iEAq+SPQjaJ7SHjRz71qwdLlu1QMuzdOuPDyWmAV+UKczOqe4JZInRAnlePEt7keLTW1ZAfHhWg4PPjeteIeFzKZJ+dPpMaEWmEoPQfKihEwftbn3xobKeA1jfkQtp0ixGZTYhcs29FGsTwrG+JHYsdvDvHNieYcd5Xv46RLMedGymE9SAIATvQPDiqp3nSTQT2rdkmzOST/Mx/KAEJhlLEpmHhYhE7cD90q88Q4pYTh0lz34oi0IEzlwmc06sdeAHd9tIotCv4LP6gurfsOVziOAoA89wNZnFM3JQS4nvoxSjM4GTMmKjmnXL2s0yCYViYdAG3rvmXlaWW/KJzDh7TY069+mhPiaZyTlExWJ8nK4S5dtHFSBochDH13XEJClpftzE+3YIZG0z6KwB+rlexTcSkBwnZwrmsR5YOQCiSOv5YTMGdwv37t7aGVg0cn/PLNi4pF126NWa1vPoFBi+J5G6mqoOfprT4j7Gxo10HvedXsgU5xdoYYok9PcgjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(8676002)(316002)(86362001)(52116002)(7696005)(2906002)(1076003)(36756003)(6916009)(26005)(66946007)(66556008)(66476007)(8936002)(83380400001)(956004)(38350700002)(6486002)(5660300002)(186003)(38100700002)(4326008)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZkAlNyOeVUFgHGnWg1Db47ulFSRoDV26rPcGtwqVQZDR55VKgkS7Ll0clM1K?=
 =?us-ascii?Q?CQRK1h2wQz5ufoFMIDXrMzfb7l8vIcvPXo/x1Fj2RJ1ig+CIf4w6Sobz5AYA?=
 =?us-ascii?Q?+40P6moSEK+tWxC3Z41GcaH86kiS+3wHAvn93MA4D/pNuVNvOQfxtCl4oR/s?=
 =?us-ascii?Q?NMEzmHnSXzlKJkwGiOqV5/2IvIivqsqccMQYIUF2RDRNlpGS0Qszz7x3TCau?=
 =?us-ascii?Q?R2U//B6BZFHTOlTwOiwHkCKX4RqIvtvitJQAfqyClOcpWIWL88McvwSWFkLf?=
 =?us-ascii?Q?BdDqf5DlYLtE6LSqiLn/2wYKenxYOpgPA1OWFiRa014e7hCkmOwijGbBq547?=
 =?us-ascii?Q?+86boxD4Jc7yITv8xIJfCpi/Q3lI85xVS88IqrC9W9kqVOK17iptkuqPraHG?=
 =?us-ascii?Q?4Hazu1pr8euNC8ji/Zw2uWwRrhQaSh0LTFnlgu0To7tvMqcfzGJzBMV2E/SI?=
 =?us-ascii?Q?6HOrfX/CbQPOIg9XRdfRaFU/FKtYjUyduMz3Lf+5TP9femzhy34tLU2z1xgz?=
 =?us-ascii?Q?d7zq0EJJA/eJFVhOcaciSvo6c+2jcl57Hjo8DFbZVjdYyckWIty8XbL2SxwN?=
 =?us-ascii?Q?yEpXJruoCs8A7ISV1r5hbDhHbGTVjMiOAM3p8HMvgTLC8PsSVyLQluVoGoy7?=
 =?us-ascii?Q?JRsnwr+CcgYFwNwkshHeUg5F2a7rgG/unpp9chSDDkSIUHrSF8odQ8oOGVhf?=
 =?us-ascii?Q?rqTzoVKgZaxo12Y5vuX7Yre7psK2emlUQcSZLZmL7SqkfC7xNzShmNnSuSp9?=
 =?us-ascii?Q?g8WZYy8HK46nx8IAavILa3lN9UgDWupBQJMSSJLLH80OLrS5Q2NMOy/TOWoY?=
 =?us-ascii?Q?VB1LU/mp/LxOtS+5LN7IsfCyOvup+tI5Pw7DGor9KBwkpX7x9OZCf0yNiIr+?=
 =?us-ascii?Q?2igRlP/fdYc+ZAo+b8NI757Jz8BguZpmIBcgknMWpNwKu6+rBdYg07UY6JHq?=
 =?us-ascii?Q?JTl8c8oMGiRM8FAyyMccZfMrmgWDTJQxkmYc32EqZFtmkfdr1pnPDf9V6sh0?=
 =?us-ascii?Q?uHhVH5oA+RyhESj4eWdbDmMdIkcCmV07kbLbEK99czeErllJrQ08wIq9Hf+5?=
 =?us-ascii?Q?3aJ1AM2dPYNlZ+LIJA+LNk0le9YEF3xUnliVgZatbeRgpEY6oDtKZzAkWv1p?=
 =?us-ascii?Q?eyOA3rYuc9MMq+/GbZybpuWO7QFBF62sUOo3Ofcb/Uv3uxtlbXYVZnVPdFaH?=
 =?us-ascii?Q?1Z/S1e2gcO8QDsnXFKTlxMRMSYFaIQ2ACP9um8QJ9UpB1rTtHJoiKwIfoqnA?=
 =?us-ascii?Q?7HW8Ly4y+X96RjJ/EJ6+Ow5+IuN2atIO+iN0A5TM2WDP6vsO95m7uqV9qXaN?=
 =?us-ascii?Q?Rezy/CwNhFtaoT7QnpgsaAsW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ada102-430d-42da-3cf9-08d9671f68fa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:25.4424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gCbTH63p0tUn5P2N3ZKDz0HILpbIka1GDy3XDraM4vH/D3658J8uxCLsAl8+Kx+pRc5ipGbY0Bfc1aN37yuxg==
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

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 52 -------------------
 1 file changed, 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bb06d8e3312e..54ff4fb1ea03 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3181,58 +3181,6 @@ static void update_mst_stream_alloc_table(
 				work_table[i];
 }
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-/* TODO: Temp function for Diags FPGA */
-static void dp2_update_mst_stream_alloc_table(
-	struct dc_link *link,
-	struct stream_encoder *dio_stream_enc,
-	struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
-	const struct dp_mst_stream_allocation_table *proposed_table)
-{
-	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = {
-			{ 0 } };
-	struct link_mst_stream_allocation *dc_alloc;
-
-	int i;
-	int j;
-
-	/* if DRM proposed_table has more than one new payload */
-	ASSERT(proposed_table->stream_count -
-			link->mst_stream_alloc_table.stream_count < 2);
-
-	/* copy proposed_table to link, add stream encoder */
-	for (i = 0; i < proposed_table->stream_count; i++) {
-
-		for (j = 0; j < link->mst_stream_alloc_table.stream_count; j++) {
-			dc_alloc =
-			&link->mst_stream_alloc_table.stream_allocations[j];
-
-			if (dc_alloc->vcp_id ==
-				proposed_table->stream_allocations[i].vcp_id) {
-
-				work_table[i] = *dc_alloc;
-				break; /* exit j loop */
-			}
-		}
-
-		/* new vcp_id */
-		if (j == link->mst_stream_alloc_table.stream_count) {
-			work_table[i].vcp_id =
-				proposed_table->stream_allocations[i].vcp_id;
-			work_table[i].slot_count =
-				proposed_table->stream_allocations[i].slot_count;
-			work_table[i].stream_enc = dio_stream_enc;
-			work_table[i].hpo_dp_stream_enc = hpo_dp_stream_enc;
-		}
-	}
-
-	/* update link->mst_stream_alloc_table with work_table */
-	link->mst_stream_alloc_table.stream_count =
-			proposed_table->stream_count;
-	for (i = 0; i < MAX_CONTROLLER_NUM; i++)
-		link->mst_stream_alloc_table.stream_allocations[i] =
-				work_table[i];
-}
-
 /*
  * Payload allocation/deallocation for SST introduced in DP2.0
  */
-- 
2.31.1

