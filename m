Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE5CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0A810E169;
	Fri, 14 Jan 2022 05:34:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D78910E1B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3sr1C8iSU2DCiS6aSthJy4gfgxYxO1cVRTwBp6g4/Cs7DXFxuSrhDn4Byh5jprhRieKXSnpN5Metp9+OS4Kok2oG4YtGyWgEYQPMqbz4G5VIOAZRmnMxAGcG0zULm50WGtYlJjl493uvZDrWzyi12gytrn1uFrBEAlbfXC5Ql+XFuE+ndS3XMvWAwnfru4O9gjZsgglu46PDtDodW/u1yRDHuuEZDK116c1LeIY78J1xBybByqwYnGTUl1Y5YEo5qsErjTT3jYsWv8UNGb7sy9lAop8eAVgL4KsWapOVWhXeaY1bbTz4hIOpHfFlB+xoHKcVNpg9/SEtRdf7neSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dELOfA3TTyIO3zGuE+nBLKdh2kcm7jP2CKVzaER5/5E=;
 b=Eli2OdZvx4X2IlDjqLxPjK+9WBm7yyPEJhj8QWBorxJ2r7dAg8Pa3+jFUgDRQoeh4yKsBDDu5vCiJeRR76gktMT8RnJXhc5DEQ5EDio9t1RoUzaNNUN4kdXTaXvIhcoJHCh46I/pvnhJyvtkrkfFAjBN8mBfSfs1n2CP+T8ToSuj2IQzB7sod4g5fUHAIYI3W62eOOM6vfl6MEttmDN84wxiKDIjneboAdrvehXHbV3MJ7eNuAkoiAScVQyCSoI/w51QmMtVlBYqsKJ6zW3K8201w956Le0QPcSdMVK2GYLsfr+CVD7kx3Vf6Y50lqLnrR4F/PE9XlsghlmGYy4QVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dELOfA3TTyIO3zGuE+nBLKdh2kcm7jP2CKVzaER5/5E=;
 b=JG/mUaQzv/XouxnKr2FaBc4I2FLy0lxbM/4KiuKrmZvvBhp2TluaAtkpPKa7WInjbSpTa1CX0vTiYS3G6e22FSD31zKYVdHVUBz17AmHOL0wcDDiPp5JKVhcLF6SFiBr2F8nXvnxGVYj+PwWElIx4Do+Ivt3dn27BDSd+r15eRs=
Received: from DM5PR12CA0014.namprd12.prod.outlook.com (2603:10b6:4:1::24) by
 SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 05:34:54 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::15) by DM5PR12CA0014.outlook.office365.com
 (2603:10b6:4:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 05:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:34:54 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 23:34:51 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/5] drm/amdgpu: Fix the code style warnings in gfx
Date: Fri, 14 Jan 2022 13:34:04 +0800
Message-ID: <20220114053407.4035049-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
References: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 755902af-820b-4a2b-6e79-08d9d71f97d3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2557:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25574F81CA53FC15F9AC1CD4FC549@SN1PR12MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoKgR2SbExOM+EgCd98SglaDgdX/RXDGj+f4oEniPSX8IL32glxORw8WzzxwXqIT5uHnWp/jdqZpIAUPMiCD3a9OigGmJ2nzJTOVlxoAjMSwSraIIbkeGtofEfg4aCKWciUwk4/6oWLw6iLZStQBk8e5nZHh3v7fPCrgAIzcZ+Bn9ItIAqw7iGm3/cSXbPGofPgvCeFnS8+88SjpkLniWArcFtlYx1TOaUTHyZXw+oaT0lL1HY6AJjHi1DQm6mGYxfhI/FkhcdKbzpTDzdiQxcagXRZFCav5aFBr2DOk4f3X3k6H32jxfWP8l00RcUbJWi6d3G6X+o+xGNWKwahbJXSzBz2EP6WHy37sDTynaOBKvanBB4tWLi8CT9Qt7vkAvw0mcp5slpgf9CsfoVYhB9oMOjw2L5c8JUkj68PejeV7AbscNfSzolDT/GV+7gy3fJyGKc3WTplgyVg9DyeZ6GmVXdvgPMgy4qWUvq6o6BXhCNTVtmQ+q63Gb0hM7CZ0Db9gSzvocxw1Icbsc3TBBFf9rqEKE0UB2clbdl7TphgFhbmlilT89niDj1gpjEirpHycH3yVxvHQDmaciwzXZNZ35oLJN65Sb+zV2j4iVQcqlmopj0a+9oLF7aPCgHGKBhITpRn5b7zW4yme020+WPS9KLRs2kEAZ0Vjq0F7vBOF8GmoifTO/FZ2wNVpPZOLv4KKUw2KSFlHPkJAU13/XLNYSdxRbpfPImklZfMMT18VRf7EmZSfdbBAQ4zsHK2ou0QHdNNQdLR2R9aSrtEdttsjLW4MUZEY2ka0WbiFAOo+TEoAhwL37qp8UKdgLD2Wkv/6gL91BgDvvOSKkm4+6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(54906003)(1076003)(4326008)(336012)(86362001)(2906002)(6916009)(7696005)(36860700001)(8936002)(82310400004)(40460700001)(6666004)(36756003)(2616005)(426003)(70206006)(70586007)(508600001)(186003)(8676002)(47076005)(16526019)(5660300002)(316002)(83380400001)(81166007)(356005)(26005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:34:54.0028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755902af-820b-4a2b-6e79-08d9d71f97d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2557
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the code style warnings in gfx:
1. WARNING: suspect code indent for conditional statements.
2. ERROR: spaces required around that '=' (ctx:WxV).

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d36a6bc62560..e12f9f5c3beb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2314,11 +2314,11 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 
 		/* If not define special ras_late_init function, use gfx default ras_late_init */
 		if (!adev->gfx.ras->ras_block.ras_late_init)
-				adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
+			adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
 
 		/* If not define special ras_fini function, use gfx default ras_fini */
 		if (!adev->gfx.ras->ras_block.ras_fini)
-				adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
+			adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 7ec6243e015e..7653ebd0e67b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1930,7 +1930,7 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops ={
+struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops = {
 		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
 		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
 		.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-- 
2.25.1

