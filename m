Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FABF4181C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 17:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C7F10E572;
	Mon,  9 Mar 2026 17:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QLLKrMwC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8529E10E571
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 17:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJhm4RPaj4lSnEF+SUvQJDvug/cqSnllgTT4UOiOfOcKkY3pUzMKNutYLp0yuuAfAEGea6pxqX9u+9bbcX3uOd/UFvTVknkgb1kESDNespMbrfs/EGq2FMJXWuNRZnm7Yfi8phBmcvZAPQy0rgDZVnAEiJgSIX5QmsVt8kl7RQX5gPlKUlSvYOf4I5PlB30wFV3Hn29YxKHkdOXIVgpoUR/4yeleONNOZ+fFJ0VYEqydnj3DFUM7ewix+aLdLKHwQa/EA6mn6nX96ryKzlW2ULNYLdLxc4ZnHahp0A8c5m74IfWwN8DUuANlPJwUgPOxSe/HTAUqxnHcAHRapSmbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoROfjzgD0abqyYSbxcFJkGRrkYtDgjWGACorfuDf1I=;
 b=WLYhYVUPmvzHrb9z2jt/51fDOH/8H7D3ZMHDm3hjuOYCHzf1OQareH7bTxf4nGMyO61ATpEVMmcuHhvpMsCK9fdSEKYqF7te6xtCbMZq4feoVHtK+xfEN6t8jf75c7v7Q55Z9GqzcClc++Y6wQNnmOOSM7AXNx8715Uxzd/bKw8fbs7szT9vI7RXu4SN72w6qPlqiIHngId16QW092BQpygyR9cIsUkJ58j7u4UQQuFyJdL4iwQqeyuqVLUJDrtxBK0R16WncL3cP6+2KNv3UePIpt3b2U6D8dF0janeKxsbKG36pW+ziBIzSO/c+39G+yGu7jZEpBNytHtM64j8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoROfjzgD0abqyYSbxcFJkGRrkYtDgjWGACorfuDf1I=;
 b=QLLKrMwCYKRms1RnrzzJXL/2AD02+fYrrNC8qpi4NNBX/lbo4K1DO86mKq3MVuYNy3n2MloBoWi+w3efBseEeK/Pwb2ROm1VHq0X3FkxiYt7eX0wWrjrqVCkMPdkx7lkopznmEadnmrO6MCB3zswg2MvuFU3hq73pzF80nfKcoo=
Received: from CY8PR19CA0042.namprd19.prod.outlook.com (2603:10b6:930:6::7) by
 DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Mon, 9 Mar 2026 17:10:01 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::c8) by CY8PR19CA0042.outlook.office365.com
 (2603:10b6:930:6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 17:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 17:09:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 12:09:55 -0500
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 10:09:55 -0700
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <alexander.deucher@amd.com>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <chenglei.xie@amd.com>
Subject: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to fix
 fence timeout
Date: Mon, 9 Mar 2026 13:09:50 -0400
Message-ID: <20260309170950.1982724-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
References: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: d8166d94-b483-4049-7f93-08de7dfeb240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: 0YNlM9Ab+Pk7REOT5TNdgl01mNzOGIlxMZm1GzYU1GBUvTAMJxlPL6BnCPOnIBc7nXAzNDmH3pnUCWKCeFh6hGmwTXO2CHj8hmcf4vHzm3eBvaRMGlHgqUA93gYmuiX5URJOLm2xfQBZxo0s6yBFOjP4Txydr6nTn5LBOGyadgKtCUlnRWVZyvOvROhhenM6ahonAoGc7MiuBkt9Rqv3lZJVhd1K27z0ezvR+PXCvTxlTA8Nqg977RD6pUpwSkH/xvko7w9AnX50YsXKf1indWetJLUJqXJraYCriUrKzAz/pJgxjpa8ZKEGOMC37HRmuavCoqENiCkaKgTZM9AZVZBQX6oPvjn01iSLSr4Z2gHF2hjkwwNL1RLbd/2y7uYVNpU/lheheT/8FRoVV4b3IVqCw9kDHvsY/UNae7dcvkl8WNV1uYZ/kxdKwIKierh0EGw5RR2ibBzjGSv0DvGCjj/vvv/Zy510YDyrLK1LdDkvwVZhPHvl+NyOlQ3KEchXqmSgLXEtJao1e3h8lPfPLSKZYH4D/SbsLNy2wgroIYLLciHdWmluKv+5mhqodoMZ5rw0t29+bNK7KMJpvNkXAvFrNYG0i5gPnrjUQj8V8wf6wTRJ+ejxkKB8D6GbDR6W2dJtsVbat2AqEhMPE8oF0zYsTxoMLAq+AI7JM3T4iSk2BdqRpUNxEXlFg3rBZD0FFLQQpM9NmvYy6MS80c7HlutJxKASPwLaO4XHFn2RcNsAow/0piw00CxVVyUtmH0SVTeGs3ebL25j9tZB2ybOXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WatgtqvPkJd0URw6PeLtL2AoYJCqYeIrjIjfzMV2/urwVkVy4twa+Fya/YLTka5+zqv3ELvUFz65l+z77HnKWy2soqlQIgtvG1hFZLxBxJtmEyoTYnazr/6La7Ou2fpJ3QOu9MGPyuA/R+ViIaMX98LexNPdj5U4KnUxFAZDht4bXLkJV8csslZ4Wuz5n65WBhrErO7pRhR8lAV287HF42P91jClas7Bkwe3umVTRsR21oUPcuigIp9Ea4m2qGtfEfKukL4OUmu3dVFolU196gcUURwzjZPXr3ZgebGS6cRp81DpdLJKOwWVgeZ45sChE0YeHEpUfEsLdcOTu23rnUBub5Xtdd9XBpoz4X3y9qXxWFct8f8K6PLuO4Z1rzrIktFx8oxmwc1e7YlVAg1O0uDtnWcWJ6lH69O988T6MPcXSwN2E9kuO9/1eVzR5P9l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:09:59.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8166d94-b483-4049-7f93-08de7dfeb240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
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

After GPU reset, the hardware queue is cleared and all pending fences
are lost, but the fence writeback memory stays stale. If the driver
keeps submitting to the KIQ ring during reset (e.g. HDP flush),
sync_seq advances while writeback does not, so amdgpu_fence_emit_polling()
waits for lost fences and hits -ETIMEDOUT, blocking further KIQ use.

Fix this by skipping KIQ ring use when in reset.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cab3196a87fb1..0021e763b753a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 	if (adev->mes.ring[0].sched.ready)
 		return amdgpu_mes_rreg(adev, reg, xcc_id);
 
+	if (amdgpu_in_reset(adev))
+		return ~0;
+
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -1202,6 +1205,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 		return;
 	}
 
+	if (amdgpu_in_reset(adev))
+		return;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(ring, 32);
 	if (r)
@@ -1298,6 +1304,10 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
 	if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
 		return amdgpu_mes_hdp_flush(adev);
 
+	/* Avoid KIQ ring access during reset; caller will use amdgpu_hdp_flush fallback */
+	if (amdgpu_in_reset(adev))
+		return -EBUSY;
+
 	if (!ring->funcs->emit_hdp_flush) {
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 20e1395b39882..f9db2b17105b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,6 +876,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 		return;
 	}
 
+	if (amdgpu_in_reset(adev))
+		return;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
-- 
2.34.1

