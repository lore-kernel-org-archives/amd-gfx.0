Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B725FF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 02:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E239A10E9EB;
	Tue, 28 Apr 2026 02:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxGK/gs0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1926F10E9EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 02:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d55Pp0/JO6NnHGuD605r7AW37hfKigPVnZzcYFdctJmvwh24qQfx1HuEEmmudgz5WH1OOh9dUN1fVMYmju4GrcU5d+lK5kZikdFXQGoE3P42WhIm7kdAXpONjhifh3O430Duaux4P6a/lxZUEm482RAUYR6KfvzFgKaLvfUckavyakPTEgDfL0QPVlcpsKR2sNNJvf+fYNuBMGlxqXa/teJ2HkCxxtcQp06u+elFTQ15ejS9JC4zQigpEAXCZngcm6WRN0r+V+USfysc6HrMwRJpOsuvk85bsuKVXM2vK4Oh5b7UKjnbKEklPCq3sRu5JQvK7FaM5O5KpL2SYGSKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O//AWYyy3OxvVhVPcx9joLtR9D7qxs1Zp+JsDXHrdXg=;
 b=agOvvMljpSrp+oHNij5I9Tc7zSfCylTZRSrB4bxHWTUqLlOPhPZ3TSabu/rPhmzv7QaMAyYtPi4R/cn+ZmsBa2uldEFShO8HpjCTU6ph+zDPmBkRee9dHOHTTWI41HBfXiNVMt7s9TRNIrFZjFrmCoUSE8bET/lWKcDpm+J9vIXg5nQL7kj3yAwcb4DGjbt7QDumV98OTwEATdhy+PdOTqC5QqWFPgMX1NsiBGTE+SNFHINHD+cM5VtAtw9Pt/XlPTGJSYXHQZ99kVwF/pgWweE+TioRRIg25/g8WQ4REhVWEjuyzaavEa8nyMHU/lnOpkVl3s79v+C179ShLwz8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O//AWYyy3OxvVhVPcx9joLtR9D7qxs1Zp+JsDXHrdXg=;
 b=zxGK/gs09ot3gLhfR3X4jri6PWHw8lxIYuYzUiV54ZDiYIR4syBJD5VU5PsJqsc6Vf2ZgOehBa4lDVtTByGACyNopN63JXrCwXJuI/W+qd9Ch+5yk91WpvUah81sK0d25Vn4hwO7CwPDkFgNjScr64X3O9ft1oIRx6dm9SqZYgE=
Received: from MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 02:13:47 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::13) by MN2PR16CA0044.outlook.office365.com
 (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 02:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 02:13:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 21:13:42 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: clean up the userq unmap error handler
Date: Tue, 28 Apr 2026 10:13:31 +0800
Message-ID: <20260428021331.3730918-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d81a40b-02bf-4cc6-9ad0-08dea4cbc5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fYGQrvIBWzVzRF5ESu5qZPLNpMyuHD4wRh231L+200YkwwppPwWVG7YuU70+nn9MdGLfNqlo8tKYJofztbQWqh70Pur/5s2lBMlVxo4Vh/tT7kiuGMuOk6RL2razoAoyBQnEfFYn1mou0ATbC3CA/PqfwxxC6Hoqa2t9oFpx4e5frYMPQa0IVIFkarKsB+DCTYMX712ESgjAC3SRe+wGS0N0OM8eRfxlVaI1PmDOTffVrKTrSMa/z5LrxcExhoyX8czwcua7F6ma5r9DLjO6k7CqBvDppXh39NDrq2rEXf0hlswZGdMpPW+OP1XqJmL3mU70oaijQMXuctTU3ET2aUpFfXhz/Vw68uFEWOq2x2LqtXXnmOWIQIAq5VCdKatQ6uviOFtg7EfaSR3H0eckQYzbeceVRs2ry7Mh4FNEv0WGKTp28Ih2460OOtqsLbGRsIZwhGNLMEJaUYGrySOpocxu41q3OfoZrfoNQKZQKtAwqMsts6+JnuGZmSIVBQr6B5LZOY1K42ITxtBlnVe2UgOISnRMxzoLx0G3F1ZQCjIIh1DB/Vq1QhyMHj5dCfH2EhRSS8OIARdCdeWjKEbejWXzN+PoTCs1Ug8RgCeJ3ykgVZyOuT2E1WBAEYNc5xKNQowLqILmPhOfCMA7ZtVDTfsiuXIpmi/GLUylG8TGvMLqXeMnrG7P2wNfRwifN7MEtPrkftiodqqrj+EuvB8DHYuwIXIc3i83U95xQdgCGSWj4gYd2hoBnWoEk+QsqrxAS3tR9xYOeMDZD6/JPVwpRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cbFmuQlUPEWUs+C0uNJkUsoNl6wCevImkoFrSFkcbvHYUKKkhDtawjrcznvYqYfDwO+zNm9UzINft7XotuXmQOxS1BCnJ0mKHAPNEKQGUAgT2h4u6vznuYndCL2K6ykSzij5WuJF3MSsvutWzhZ39rVw01dG7uzXNolzrTyWsinf5hvxA8U1een0oJ+oF1tmy5OznPqKGXis8cyhABu4z2GeSIB4Ns6EpqzC8SgLImzVYsHhatsyXPAvRDPbVootOxWth7DreuuoIjdtrqTtbmBFtLZy3nM2dCSPrFGnLBUwv32y/XiXydBvBL8KG7X3rZXSnC1xecr0xZ2KqNOe3lMj0hMHqQtno+mx29Dn2gheZpLXKuLEV89lZG3KWPjESOhLjcJyCZ4pcYFaJAu6Om2v9AnIU8d2DfAoT/HC2+SAaIjw1GNEsJtPjfk48Lay
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:13:43.6459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d81a40b-02bf-4cc6-9ad0-08dea4cbc5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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

amdgpu_userq_unmap_helper() already handles the unmap error case.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 58b9477c0346..a6cdc157b402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -656,12 +656,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 #endif
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	r = amdgpu_userq_unmap_helper(queue);
-	/*TODO: It requires a reset for userq hw unmap error*/
-	if (r) {
-		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
-		queue->state = AMDGPU_USERQ_STATE_HUNG;
-	}
-
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
-- 
2.34.1

