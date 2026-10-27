Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6659606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d4uP2I+c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2EE10F56E;
	Tue, 27 Oct 2026 13:51:08 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0249B10F54D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+K5EvcRg2sYRTVJa4EymoGbirxCq2Y63F4FIzPPJQf6yzNw2DRC+x6P9QiVvAJTSXoDMZo+eRTJGJeZSJ3K8YptXm7OLp5Szru2Vm3VFvdiCOv7LwekKISGNfaIICOHFyBJcRQE7jGzKe/29ehDLEYyLiNvFhZiA4VnNL/JDeSEdera8qtRXFyhv6YwE7kil+SRjZuhM5a5VOq/KzXjjZjIYTwbuCPo3uw/r4SSw+wXvRVIm7ppVXCKsiJaTG11HGcdYDj+9ddlNzeXqv+bk0kMAd6H4I7O8EKQVIoQGf7WjhnQIbhdpHS1h5cg8/EXbl8DcOusPaKx4mYErLZdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyPekAbkYSVmfbAxPfwojahoInN1+8BKf9VoM5Q7EOM=;
 b=vH83mTI8phl2YkEfoixiXToKolS8sEwuO41m7swaxTnyfpJsZ0wOGXAHF8X0sgok2AMYIxMeq58r5T6983KB7MgYO9OwcN2ttt4tY3QxPyUGCS4BD5l7OJ80q6K6I25PLLpGBtfvEYP/IiBY48RPloTpRnLHPPyFuP65Eh+SBhncfOOoX+zJMY/HJDme2fPnWZmAHhfba2c3GE+KR9eH+T36/wXald7Lgitf5AnThwJVZ+j00np6IGDyvChWEYqEgJe9fhQuLig/fnvDDA0vKmvbPHWN7D6wHv+CAOsXPiblN0qkDQaBBwOZugYsVynLsYJmQwu8qY5Qt8NaI1jeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyPekAbkYSVmfbAxPfwojahoInN1+8BKf9VoM5Q7EOM=;
 b=d4uP2I+cCsxJ7IxBv3PpKdLv4m54NiUcPBILRHb380jfH8vnT+5qE4+Xb6rb6S/yRq0TgyAabsb8aEPWFWHve73E7fzzcTo57UTUsidMqCT2Np6kVPSMEj4zRC2YSrO+NgJ0x+dan96J1LZL6kHuDEoIaKY3wQNI4Ur+gHf0QcI=
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:50:50 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::33) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 13:50:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:50:48 +0000
Received: from RSBMMILICEV01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 08:50:45 -0500
From: Milan Milicevic <Milan.Milicevic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Milan.Milicevic@amd.com>, <Danijel.Slivka@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts
 for navi10_ih
Date: Tue, 27 Oct 2026 14:50:24 +0100
Message-ID: <20261027135024.1391-1-Milan.Milicevic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: f8dd6b1d-4c3a-435a-5a6d-08df34314ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 0dKoblM/xW9x7GFUKoLPHqj2guNGQS3Vt+h+vmvWrkHO6KiaNmyMyjrRIrgpgpsydWimevPLlM4BGSBzDk+YDkatp8STYi0t5i4PoI8y4MFNY03iZd8L+T91kU9Cp/8c97o2J/eyMAyDHbNbl9t8hKYnje91fFsX8XdSu1eIXhA8hSzr9cYzP50fNr10sbag1/Z6h+2V6IiFQv1LpCnShtbGDml8UbRMQe63netZp0WF0M0Me8zPcLcndK/+6pyLBxEs5kWx6Olul4n+rjCgL10AupXEGJiGi7GAzYLuzuyVXLf1BXZ2VhAaotpLSbEQZWDl8D4X6ZiSNxO/VoMqocGuX5va+PN3sB5SwhPKR0FxmRfR1/qN5FoUb+cQlaNTf6aXf+H8IPM58cldphM5moGd463njR+6FfgKdVc6oQFmzRyQBVxk7O2dc6WZ6uo8NLfIcFk8ttJuPx3txeVjf8y5TZnYz8pGvFIvBWfPiTz/IDPG4EYZYx5o1dI5DavyrzR0CmC7JxRsYa467CI4wBCpieabQrSKpBohSWlhlmq84iotBgz0flKMcAYRcvPUzsuShFjfWG8BMHW8GLaOmqh0FA0FLAZUpvP+ag/+NCElrvCOgxcz1qSKs1YkwL5CWY8O2r8Df7BY3Z/OJGpxA2m1zMO3Pzpoc+vh20jHfyQOmLBpJYt1+fui/EZiP2deEjdlTkpyX0CEx1B9HR8mIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ljgf22rPqIosrUrIFKogB0C3oMgS6106IahsXhiE7EVvvxGKisi8Y6vSXEbSdRuWKDXXQOj6GqvnEd3LL0/to0a811YF9A74li3HvnXz3OdipjGy9TX41GzLkkAofDZZD0dz2L+s29mqYhyU/so1rLHOgKPThSayzGBrWtDEm9YG7hhF/L+Lk5Zng7MRrs3+r2aMwOGDft9Fa1guNPn+OH4U5RbwHjN3TSDsCLUYq/hUl1r0gtvRFIYdTn1494s4oTSP+NMNQAufyC2bgnGA9RT+tIZuhf1eGIUs5VrHI6GyrJG64OpoBQp56aq+dKPeQbKC69ayjdrc4yX1rpJQubCGMn+N0pAsz2OHFppXbpif3M/b7RApAy42dRvv8UD5dbMhU+Jpjoi8jDpy92uHRwtWguBD5iofQfuJz1CszOXgjZGc5fhOlSvoWWEe2OKK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:50:48.6379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dd6b1d-4c3a-435a-5a6d-08df34314ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Danijel Slivka <Danijel.Slivka@amd.com>

Port this change to navi10_ih.c:
commit afbf7955ff01 ("drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts")

Setting IH_RB_WPTR to 0 does not clear RB_OVERFLOW if RB_ENABLE is not
set. Pulse WPTR_OVERFLOW_CLEAR after RB_ENABLE (and with
WPTR_OVERFLOW_ENABLE) so overflow is cleared when interrupts are
enabled.

Signed-off-by: Danijel Slivka <Danijel.Slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 1dae7df9ee17..6edef75846a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -161,6 +161,34 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
+
+	if (enable) {
+		/* Unset the CLEAR_OVERFLOW bit to make sure the next step
+		 * is switching the bit from 0 to 1
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Clear RB_OVERFLOW bit */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	}
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.43.0

