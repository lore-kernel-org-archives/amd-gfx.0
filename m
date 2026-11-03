Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3728606A331
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ih6yma3D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7775010F44D;
	Tue,  3 Nov 2026 08:31:46 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D93B10F450
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1Pvm7n/1pIs4H7XfAJ0Lv/plUBm0NLm83UcWVIsK2/ZmjqAjFQUNJkwbJVWPSjB4NAjG2tDH4Aded0kIrxlXUrBBHTAxEvrugufPT/h/aymKnZeZfjt87JnxoI5H7LxRySWR78dgJy9WdnAIVnHCYZSd31MfyfrPi64VHxFWh0EXIqoyPktXswjbG0Nk9bqwhUOpgH8HclJ00/sR58TkXmNkOTThl5U+npeL1WooFs0eWTc/BzWbKb338eB19UQVOUImA6HOjO5H5d1RnTvZ/mdhvAafjhbO7qrV44irbDvhD3SPmmCG9eix++ZRtaoF78nLt47kBbp3HFczP3Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrWCuT55w70YAB+oywqB0Ct+IIms5GxhrANdP8GeC7U=;
 b=CwQvfTRqNm8a8zuwpKU+oSXPkxZREdzXbETkQA0giAyo+3JE/m8LSudB3TSVU3O38rmxEENhTLpvw5CykMr+9fcS09WmyDQL7qvtnVL7SPhRjHz9J9qUBeQbc4B6+zIABEBHUtfPnFo6zyYAdNh5frQLuyUGbnGywy5t+WOnoAWWE/0s6CmLj7pDW5C8WYi6C0/KIxVHqj13uTmtwVqYOlAyqszHic/2UPvA2/GzAJC5sCBJKCMoY7Hg1bL2gKvQDLU+A2zcWCpeA+t4ktnhAxsNTlsjBexPRNrroR07IRzXzvW2dd3RQja+axnI5ysZUJBRozPDXfbWPbLdPQB0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrWCuT55w70YAB+oywqB0Ct+IIms5GxhrANdP8GeC7U=;
 b=Ih6yma3D7A9TBxrOzrHYuOOfUJ1MIvMeNVUZRP/DwRF2b/Led725gCfeLvLOUMQwzbp0O0Npby/VO7GjvyKd039BrolH9Ahqib/8f/Ah+jStjSgrSP3BP9btx1k6w/9DFqM0DuUyMujck0eqbFI58DOzhc2U290fzkMZWB1fh4w=
Received: from PH7P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::14)
 by PH6PR12MB902451.namprd12.prod.outlook.com (2603:10b6:510:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:31:36 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::6c) by PH7P221CA0004.outlook.office365.com
 (2603:10b6:510:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 08:31:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 08:31:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:31:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 02:31:35 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 02:31:34 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: don't drop the gang dependency fence twice
Date: Tue, 3 Nov 2026 16:31:14 +0800
Message-ID: <20261103083132.3056003-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103083132.3056003-1-Jesse.Zhang@amd.com>
References: <20261103083132.3056003-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|PH6PR12MB902451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6e8f7f-0e14-4ff5-8bc6-08df3984e011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021135927099003|260925022911599003|260925021911599003|260925021311599003|11063799006|261021123027099003|56012099006|261009223027099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261021121427099003|10067099003|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 8pEXD3bYEEKyLFanLuDcZ1+9tKc3gu/DSVO6Li4G0aqDEZGWdANV3aMICSeWJN+L6+ve2wSk7tDhHmT2t5RZP7kTROMGzO0App/FQRpt9DtBafx35UNE2beITqLy+TpPQrrRF6d/RjX5ncb3rtFTFbPkb0U5GMCPd/5yvql8pyXDxhhWswzLnisg87oHVwYcTMOQgHN2y68ms9mRi7ZCZtrwJqZd17LaRMPkxmR4b8Ix7Fobfa27byQDEwLqStp4HtMtlZJ40HHdtml26i7I6i9wTvWH6KVdfKvgGEaQZ3l0/aS314UoWpvo3GZvPurboYk9If45ftE1IBZikP0iKtgw880V86Qk5E02ICW6IoDhydHesJAJW0YrGJLVPlk5QT+u2suavEErKNX4GLEZh9GFieCFAtvalFaL6JZkVkeRdIgSTZLAoxts/hI+jcaSeaSCgPcjlkx/Zkii3BcwENqZYH+R7dq85z3ubFACeUigFn6EzjxBKsDIYrB4CWhFMBQNvr4E+UTHtwtOBovdxPYcio7hMTm4OL1vclgZ5d0kPEK1d8U8UEvR3j2XgmRCXNnvAkiH9waJKMoRDj7xbEeU1dOeKjbc7eVXSGYyGDL3rfWN1fQiuMf1DSpSotKoglkCsE0OYO06oWfB7gHCoQUG1H4LoZI6jI1kzxxxTcSriSf2lIHCBng5A9ytqZtG+l3Xpzg3j78RZrTbTrs7kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021135927099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(261021123027099003)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GjM8qL10Uhhj0EG7TZA+8XB4H3Xe75Y9UO+5U/b0p3iM3ifv257DSYG76PU3ELGMGYtiVu5MGfShkax3HFCrxhYXgts5hB9znWx0TvarQxGo7cGIy2kBIYuhE/UfznpbnkXTRm7FrAoF5tz/EujLPahTSa8jRODHFIs3YBZPQ3cbSZMFDY5OhWzPR/Ov1HYpGoxTfWQqr9O/71WhegN23yqJ4u6GTNDZ6612rf+3Bn2mMIOa2jwxnBeLNNEfBrSz1milhESIl2e0mrFW435loudVnr+OAmliQAgoMdCiyYWJAn+hAGXzvlBJGWgM27B+Z0DD0kLIWVE3DoPGqYbUzb4LmPgFVL6VMfz++Cm09iAyGTHhzxPxLvR2LU9VQRcKMzg3G63oPNT/7WYV8WHjHESE6vghTwKmyRejXZn4+izNFY3TxF1GC+xFPLmyl5Xb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:31:36.6851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6e8f7f-0e14-4ff5-8bc6-08df3984e011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB902451
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_job_add_dependency() drops the fence reference when it fails,
but amdgpu_cs_submit() drops it again, so the scheduled fence of a gang
member loses a reference it still needs.

A GFX+COMPUTE gang waiting for another context, with the
xarray node allocation for the leader's dependency failed through
failslab:

  WARNING: drivers/dma-buf/dma-fence.c:589 at dma_fence_release+0x34d/0x730, CPU#1: amd_uapi_regres/2993
   drm_sched_job_cleanup+0x2c2/0x340 [gpu_sched]
   amdgpu_job_free+0xcb/0x3e0 [amdgpu]
   amdgpu_cs_parser_fini+0x435/0x710 [amdgpu]
   amdgpu_cs_ioctl+0xcd2/0x7a60 [amdgpu]
  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:dma_fence_signal_timestamp_locked+0x1b8/0x610

Fixes: ed21f6c3fe42 ("drm/amdgpu: fix another missing fence reference in the CS code")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b4555d8d108d..71e2b83faa12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1331,10 +1331,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		fence = &p->jobs[i]->base.s_fence->scheduled;
 		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&leader->base, fence);
-		if (r) {
-			dma_fence_put(fence);
+		if (r)
 			return r;
-		}
 	}
 
 	if (p->gang_size > 1) {
-- 
2.50.1

