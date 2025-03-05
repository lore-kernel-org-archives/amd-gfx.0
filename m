Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C76C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 03:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1436810E02E;
	Wed,  5 Mar 2025 03:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gs3kckND";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A4D10E02E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 03:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6HFDYBGWZEKcBHcmSFhH88ZYiHOLaV+t9KCHnfOWRs/J88ca/hpl8lLiYdxd3ZGUS2EKYlLnf/aHxMN7cHTCQVBOf1mWXwGkeZ5JC1C74esrTxgV52YhNhvTdHOLWIH9A1NlOSXoZRSSOIb0c+EYMiTIpy96fPW97mzWEY8LY4w12vLJkTdLs7ZHZUXgTAFVwSE5r+oQ0wLwV/Q2IPvrzuT2luBQ2AFFY6y0h8Qk9sQ0fZKMVBT/SnjbZs5jaZHT/zOq4QColG52AfIDGVzfoNLFourzfmkeaPvm/U4KC4LMYT2wlvRnkmikW4ajhM2fZbClY8yFT5NeK3pMUSMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0GMPH0kZ80/ReUK/3XLVSZRfswNravfzYwSSS18y14=;
 b=qGm8QzU1UZzw0gvkqjy+3SChDrhUVAHbY/n4jTRlNcE7yXqaa9CwzFciqlRLjKt4cHhXb8LQeEcojZ3qnRSAHX+WiARBlc5ja/2mqWsNBE5LOcTMcBU7Zg54YC7CK3osDZg55TV5kq24hH9pDLHEik4yg8pFAEUIfenJcRtxrEPnVGONsntKt6GagBrLgFKPZN5UOz0/CzvTduDEv6OA+NCJ+g3ZvywFibXoyrFmhKcjJbmrfg6A2zuu8KtUVN6Wf32lfmTF8CMku3s1K4DI2ucQK2sOmpVk+NOtFZ0/tPxVikLX2f2BXapd+nAMt1cDOk55jPLOnHYuO5qUAB2SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0GMPH0kZ80/ReUK/3XLVSZRfswNravfzYwSSS18y14=;
 b=Gs3kckNDMc2r9BQQuWZXrJ/G5sbaRhN7PK5q6jAjH/+mvH1fA0QctAwY9y3jiiqFKP68gO01Rz7W5u6KKiJYamkiauAO3DfvzpZUXG7cw8/BzSMpnuJk/MOQa3kVxE4bAtkFfsKnPnDe5rjrNOLyCNH41q5jaGFvVutIdPl8Jic=
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 03:54:13 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::56) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 03:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 03:54:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:54:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:54:12 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 21:54:11 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix missing drain retry fault the last entry
Date: Wed, 5 Mar 2025 11:54:09 +0800
Message-ID: <20250305035409.3204812-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 747600de-2179-448f-fa28-08dd5b9964b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ekcc8GmJAAXh+PtTugTf+KVWwHTSy71YFPcMXlK20VDdBg4Q0oDMF/KlVto9?=
 =?us-ascii?Q?rOEWHyMUdNeCbQpnWQXWwPBk167W8GOjywHOJIGgoqc2aGsE3nWgUqB2n4sB?=
 =?us-ascii?Q?563GTzV0/1b1PpGmF5Xfx226xvKx+v+RNNz+4n2Td5ZJhbyPJ19m972GJme8?=
 =?us-ascii?Q?VrNL56S2BTRCW69z2AhRCS/y2yd1+kTMT1xcJ2by3PtQQsR+55rpQmShxAdt?=
 =?us-ascii?Q?/CximkGNXmqeAfNvQVUhozJ2pIlZ2Yvgq6+MoW+5Qj47x0Eljtf8be0gHVrT?=
 =?us-ascii?Q?KM6Hp+IG4hzaFoH44uuoeqOBCwkJKRpKWenjvC9LF8844IAUd2jHNzwwX065?=
 =?us-ascii?Q?IUEPEbTjNDZ7MAUFfRaYMJ0WBvyFZAYboTrjoWbOOkMyosyQs+umDjrZIgX/?=
 =?us-ascii?Q?WiiYIb2wSsXlGnMP3+0Qmgdz+Caaqxl0cciAz8ZW0RqoImRTXkKuagYTqwis?=
 =?us-ascii?Q?r9FArsgbm4Fi/GUudsoH+tsomEdH00G0Tb0KJoN1v15Y4IHWvJ82FyPTuEm5?=
 =?us-ascii?Q?tCM/4nF/pGFBLJiHfE5YPDMDE9WUDtnetZr5Q8XDT85UerYNA4Oc6SBO2w6c?=
 =?us-ascii?Q?H9k2kOzkiHsYk7Cug0LJwHnEI1f5hanAMGK2bOLgHxA19paP1lNzii5oOhqj?=
 =?us-ascii?Q?B6P0YAcJo5aclNycdYsZyZh+hMA7yqzgmb9D/vk9Rwwh2363QxJAYokz/qDG?=
 =?us-ascii?Q?ydSc4o2i9+9cwuOoYHOoeNyqhtPHtGSVIGgQENNd5cwhA3rFabQXNLz7c1sq?=
 =?us-ascii?Q?KLIzortWyCOOSy950GpG7rlVla2TEyjPqYPUsj/FatIorphJECdh/TLfW4lS?=
 =?us-ascii?Q?0+b6/m99A/kumFVZLDiDd6kUOBPxkVGqqjqxC1WY0TsaFiC29jWxeQCMSIC7?=
 =?us-ascii?Q?Llrk0Xfmt/FYMrxu7Ghf/YK0Z2g1iVRZwpdglbBT7H7HaA9gzVcYY+PxW33e?=
 =?us-ascii?Q?MpUlwkcixzcu6XfsyAQE2n3xKdZ0rU0wyAbOCOXTuFXSywz7enHqUe6qs2Qi?=
 =?us-ascii?Q?Xb1vH0mLbXlfBMAsDKSh0ZX7XffM5jYAnAsc8qanxlDra2dpc7f8O/9UrGGt?=
 =?us-ascii?Q?Zu74C+Ve798A3/u/0CU+rqnPoTzaIxxJgIzXw8KOkZVe+lX8oDXCW0HPVFZq?=
 =?us-ascii?Q?Uulj9qXmJ9bkjm5WeFDANKMgSt3MshWjid6/PK+vO+h8SuKWpMskK05fjo6C?=
 =?us-ascii?Q?iDVCZLGVqtuonYis/jX+byi7ug98W2nDCTBRlB0nhmwZ+cPRylYiTIqbj5aN?=
 =?us-ascii?Q?aQKuSgSqGnvUn0RuNgWWPibThD2NZjq5+uXhhqo86Htp29TQ4SJzz6u3bEHc?=
 =?us-ascii?Q?+ijJMDi8S76VomJLmhgwxb+9Zeqp+Aj04spzwnrmh6yVy2HSr/9FvMc5vFrV?=
 =?us-ascii?Q?s/MuKf/09UBkzOczSV69xIwYQ5IJ6UefjsKY+4Cd5PSrcDgXJwCNtXCJDsk1?=
 =?us-ascii?Q?zeIjoMv27vixIO3vR9kxc8RZmunlfgaVnrRi92lyo37MRoBl+oibZ8DoYVtl?=
 =?us-ascii?Q?hK3UXolWimKmR1o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:54:13.3559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747600de-2179-448f-fa28-08dd5b9964b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

While the entry get in svm_range_unmap_from_cpu is the last entry, and
the entry is page fault, it also need to be dropped. So for equal case,
it also need to be dropped.

v2:
Only modify the svm_range_restore_pages.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 7d4395a5d8ac..b0a88f92cd82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -78,6 +78,9 @@ struct amdgpu_ih_ring {
 #define amdgpu_ih_ts_after(t1, t2) \
 		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
 
+#define amdgpu_ih_ts_after_or_equal(t1, t2) \
+		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) >= 0LL)
+
 /* provided by the ih block */
 struct amdgpu_ih_funcs {
 	/* ring read/write ptr handling, called from interrupt context */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd3e20d981e0..d04725583f19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3010,7 +3010,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	/* check if this page fault time stamp is before svms->checkpoint_ts */
 	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 			r = 0;
 			goto out;
-- 
2.34.1

