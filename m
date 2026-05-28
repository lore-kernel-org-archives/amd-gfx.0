Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B0ACD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 04:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE8E10EBDC;
	Thu, 28 May 2026 04:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4cdLRA3L";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527B810EBDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 04:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY/+Wcz8zX4tnXDJ1cj5hsWiRkgyIGgp9S1cVa8eT3yeMa8oi1aDXV6mIclJZI93dB+UnXV6ViEjxyNqb4x9FbwCpOLwvIX7ZNPKJLFMMKrMRMPanBSWkJxSK2qLp00JXxFak3CWsnyVpqwOVAcnylWN13b47HiZTBysJMGgS+eI5KcbfZ3e3MLNLewBiwX0nGnL3e0CI+eQsE3j5d16Ko0ndqK/lfZn9eyNF+gA6BOExAXjmSxgb6Bx99b2L2MpAVJz1Et2wzMGLwynj33gOOHwjCgj8dPpTxCscLNeDC85g2a9BRs0VzkJEUEcIx9wlYw3bRrQqAuFemN4+alNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcbmKQKh4gUQLgLckH8DD6E8BxFJZBrSinFCIMMcoI4=;
 b=MpTgluSYztMLgdbC3g8SlGj2OS9Q9Cjg5lseiBCNzqqMypC91hNe9w7u3YkERf5oPO2l0BFWbOLhS4Oja5MOEMtj/w51t6gHV2Z9D1MSdJxdxMC3mTMwEXE1gqVaVXDcg6LkCdDAY5jTHQkbAnbNF8nh1FNp4VKgmVFgWv/xeXXChZn3QOWR2HCTpGokSSlSzkRBnLFcejT0DgUYFeFLTo9fDKB+vhIJnJr15XtRn1H4Pyp+VhXfyMM+RETVGx3aq/lKQo6ip+703hGvotxBDfzmFHRCITS/6PVsSunXnxEbz0OvPGgyjJAf9GVSfRQ2UrOdv7ncATi+Pz/QHh/3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcbmKQKh4gUQLgLckH8DD6E8BxFJZBrSinFCIMMcoI4=;
 b=4cdLRA3LNwTipWAu5WMEhoqLwhdScwIQGQunyxgWBwLRz/a9ui+24EnYPoIwaHUrdnOThQHUm9uaZvWIEDU34RsWJONMzr/ZcBenIcXUQALUjuUs4vkJD/1dbqbWX5u7lgJJaM6bVH4AYIpWYZbg/a2Dg7RGHvOKLm2ntpD8QlQ=
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 28 May
 2026 04:34:28 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::80) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 04:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 04:34:27 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 23:34:25 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 1/8] drm/amd/pm: return -EINVAL on invalid CCLK OD core index
Date: Thu, 28 May 2026 12:34:01 +0800
Message-ID: <20260528043408.237209-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 069eb33c-6eec-4320-b9ec-08debc726754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ac+o0e1aig5cMIviUv8k1vuZzJhXgX09ZQE3CWoU/mDpgEJggP3SNPhTfjjLsU4M+HnB49C6tf9P36eT1zVv6JzD6ucMpKJIEAoHyc9LJnmdCHM71rD79ONa8ijc/VYxT5Bh1X8Ce/Q1sRLD2BN9vJ+BjxFKhxGaqGrR6KHHKWu1nnRC2h+peRU+qLf1hI2DLww9MEXwt+2LEVIJllPKt4L6uKrbho7ZPAy7NBVqIXtmuZg9+KQD0qfGDDWWf0DuPGUsvTxcpRwOpyuViiaS4NvjlSpB82uRDV2D201ZNiBmH+leN55nSQFgXfKLtTJqJa35Sufngv0QNpgwjujj8tb251lGezuFcf8EAmOF7ozFJQkXcLHN9P7o0GFpCHUCXlIqduID4wvJJddSo9Uj4GipKi0CpOAKWEIyK05HRpZL3xxA3JPu0tHj/YuRNOz0og+3d66WFDFUqoDG8GZra71UpX1cil8CPMPHhlmVm1u+TQ+9LixuCokOFm+BevchFhH/Fq9tgNzQJwSFeEaMUGmptLrpMdN9b+U/I1/6JVovaPF8sn2dW3n1C1r49gA1ITiKoeMelkyB6FrE2dofNjdIMtRnXTUU44DXEPRGpfkPt1mdoUYE8lzOs5/E22gTkhtlzg2Kqg+o17WElJkKfwQqMJrkIrXPHSj6X4AORu8KgccubjSesIEoIIn6InwQZuMehEjzSPS1TCR6AgTAI6WGhVB+Ifdt/ztpHnEDfcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MRc0rB/wSrsvtLtHV1Dm8Na72SQ59GSEOHB07U+FBbRvVR6b7RlcEIYCdi7fnrbiCwn8iKypAWlB7CdYLHnhsShJuvvXeuIn7vbjnHe0zYgwjXtv8c9efAHOXlE5nVsoPC8FCJQAx7tObUHLMacIziNA79PDRKvM3b/bX3jrJpvFJxZm4BFYETZ/xEhl3Yjs7KWbCJ0N9gBYNhvyIiQkAaTpTURJrwmKgWE/VEI6tGQp80VSxtx4iMEfDqso9zGML7uBbdzzXeX9Szo5KGOTYVbGWjhI1rsIrZZllkL6C6lht2AGo9DXSeFsDvjnzHfPBSsjZ8iD4k2iGZMHKDKSt0fv+F75s4xtg9I/We6didlgADhj1KPlCxxrm2H9uSjhcpMnuZ5eWW/UjH3Vbi8/GfoKoj+9YbmR0RumEog2m+ehbU0LdxIL/lBM9gj0s5gr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:34:27.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069eb33c-6eec-4320-b9ec-08debc726754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8
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

Return -EINVAL after an out-of-range core index for
PP_OD_EDIT_CCLK_VDDC_TABLE.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 0349c73eb00077..717ba46c893312 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2047,6 +2047,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 		if (input[0] >= smu->cpu_core_num) {
 			dev_err(smu->adev->dev, "core index is overflow, should be less than %d\n",
 				smu->cpu_core_num);
+			return -EINVAL;
 		}
 		smu->cpu_core_id_select = input[0];
 		if (input[1] == 0) {
-- 
2.25.1

