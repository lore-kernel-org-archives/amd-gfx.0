Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE44CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A44210FEEF;
	Mon, 29 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYSBN417";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9668010FF1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTsgP/H6oi92oIVM4A7ndOAtF7fn+Lsq9cUNZqyMknLoteDZLQ75INDRvD/y0qdFuTxiYsKkXof+d1/rqLS14kyk+/kcm0WeTnGDaFnmnpBQCma7SfSfXJMysY4H9eaI5Pfpbkj9cDaHttalNPHy+Xeq7RCyeatxIN+ILZeDxGoI3Nyj6d0KDTforGOaBeOwpby46XK7r/8FtWBMDTpLaHEdehqN3iop/yAUJEzmNQ5IQiusqR+PodHMOocnROC8XQP7xEpj6b0ItqLxjRwdZz2ksZfHQ/tAVqIDg1LExgRBQiJmkuINgpBr+GedFE+zNzmapmdqy3+ZZ+gOH7KncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDBeJz0QxEhaOvyvonV/QgkqffP0MaElY5tgumpxSvE=;
 b=XI/HL5vZc3p0Ysq1JI2lVubwSAtKa+VnAmnQcEZcplufpWYWt9dwZeKcE/5YxUZWHH4t/IHm6+Tfug5fUvIJiTjqj7/aw4DlQm64a96+9VoFzyK54kHgTORu7rr4f+HonTZmWe8UNM2QcaR02YrtUi2bGcsFTldCqh3dz5ibEbqnCmAGsDDH5EECx9qFi1vVFlAxBGqkWzBMO55PDSGwP3HlMEUf6OU9dSi9LJ7fp0UONyJJn8wkMZdJ7qlP14W6SEf8gc/W6WzzSYiUK0RTjKINAkPdIuVdhrKMagthU7Z3gX+5Va9QH4hkk5ebH8v1VVxNYZLjENcgQUiHbx/1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDBeJz0QxEhaOvyvonV/QgkqffP0MaElY5tgumpxSvE=;
 b=AYSBN417qa1vKPuM//1Ef23KlS+fs7h6s9Sj/6ZYnGMiawDqiqyLNqQXa8y7iDufTYGaokkyaHkZOzUwIe2e2bFVL0rUXLM4DfRpIJe6DvLBERUrlqreKpzVenc0uuCr/cIjWGztuJ7cCWY8AaD3/zJBZzWLY9YqTRRsJ4tMeTA=
Received: from SJ0PR05CA0132.namprd05.prod.outlook.com (2603:10b6:a03:33d::17)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:58 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6a) by SJ0PR05CA0132.outlook.office365.com
 (2603:10b6:a03:33d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sreekant Somasekharan <sreekant.somasekharan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/14] drm/amd/amdkfd: Add GFX12 PTE flag to SVM get PTE
 function
Date: Mon, 29 Apr 2024 10:57:25 -0400
Message-ID: <20240429145726.3459450-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc3d633-fa5e-4333-716f-08dc685cc1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbr/VmDBzLA7obH+gs/v/LVdcH2RRWDRj2qA2Z1FF4fgcNbWOZkjvVdPAauH?=
 =?us-ascii?Q?MucuKnJc2XL+Bv8Vf+sa0VovWECJZi1Vuz2+C2skl0IwMYeOjuUisS3jnOVq?=
 =?us-ascii?Q?kv4hjaeqGlu097NWvnLPTfxSoX68zz+dAYEU93LOzTJrXehTFF/fq6svNFwQ?=
 =?us-ascii?Q?ihEwHgF6lxkmtGLLLtPIu5hfsA747FmgIZhGzmgh0Dti5LVONeEVzDhFrCNy?=
 =?us-ascii?Q?vnUQuINrvip8gyebZVIaIcxCsFrTUCrPSyiCv57vHnDk/rOKmF4uZR6CB9Lp?=
 =?us-ascii?Q?ra737ySXjp7WBSL3k4yUin6hbsZocOfN7eK4p3IwhfupfhseV38qJQ6L+RYB?=
 =?us-ascii?Q?esAgcS6RCP3W4NqgQWX/R2xCD9XYyzEPaKDOe5kZeoE7JMAqx+zfL3x57swq?=
 =?us-ascii?Q?8HE5EwD0RqFjyfsGfAHR5lKGLgHIOYkYqX+HYj/ErKuQkZ/6IsrS6VF6nCc8?=
 =?us-ascii?Q?rx1Jr8D+ZgNEYLbqqvyPWBCKYWGrM+MGRw8iRNRTfYkjpilWoMnkO3098cng?=
 =?us-ascii?Q?o7cfY18/qNuscCwwc1rf9V4H1NQ8knEHJysXJ+owbd9MHLJo4i8Anl0VLI9H?=
 =?us-ascii?Q?jdVqDnepwfw4SUes9ADHrO3lSofCZ/w6+4ZIFzcumDmof1es6frSpOWwWeW/?=
 =?us-ascii?Q?u611fA3jD+tu2Ru/voNFOkf0qrBtyckA0pNbHd7/RfUMi+YriQbx5RjDwx0e?=
 =?us-ascii?Q?ExfGOHTMHMjKL8K1Y3aQY5wJ+yeaonsk6ZZ6HITipWaxsxKyC3u8v3XdgrdK?=
 =?us-ascii?Q?D56+9xTgtjAi/+5NSt4WUs9wP635IWnrSLa8NwNa3uAH6GMFeNiRw3hx3nmp?=
 =?us-ascii?Q?cfWOHyuFQNVtJyTfcZCQwxbdQUpHh+RcsuL0bqjtD6Kuh1GRrz1uMthFd7LN?=
 =?us-ascii?Q?A7nuLHOBtvp2UWYL3fG2AO4jDN8Gdrmy4owW2Mp2vw8WVLQMervfXb36e7m9?=
 =?us-ascii?Q?TQYgTcMIuNLtunqlozbYdsHTjlaaBI74qX+Q2oZ7w1TAa7nhV+bEEu6j3Ozh?=
 =?us-ascii?Q?TYjuQVGvnUCxjX7niEXwsuYhQ8RV4cKv3QfaVpnyWuizcFPk2X+r6MwSHcGH?=
 =?us-ascii?Q?GY0W1A43yXqeo8osnx48X4Yod6V5ySTvZtQ2c4YPK8f+NiE32fCTrujaAqQD?=
 =?us-ascii?Q?bP1mu0Y2mBxyaxPUA/BH8dUCNSX5nX7J2yH+tayGFHZAdKgzBZNG1LjpU7Ch?=
 =?us-ascii?Q?rBL6pdRxfxjO1Cvdkdhyw0ZBcxhiyD4T6LL4bl4ppXwc/QTwcXEjDBy2LPDK?=
 =?us-ascii?Q?pTV7imO1u2VnUM8Ab5HpbalTawCU1Ohp7QdryW75JJ0VuMTSYEaClBnYFv9P?=
 =?us-ascii?Q?B9+9qfXw3lSgnbsP1Q/PVLsH8Sall1+u3zLUHy48HAIt7HrJPyUcLoPcWgl7?=
 =?us-ascii?Q?5FXKtNg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:57.8094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc3d633-fa5e-4333-716f-08dc685cc1fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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

From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>

Add new GFX12 PTE flag AMDGPU_PTE_IS_PTE to svm_range_get_pte_flags
function. This resolves the issues related to SVM enablement in GFX12.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 386875e6eb96b..fc5ede17f7c22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1263,6 +1263,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	pte_flags = AMDGPU_PTE_VALID;
 	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+	if (KFD_GC_VERSION(node) >= IP_VERSION(12, 0, 0))
+		pte_flags |= AMDGPU_PTE_IS_PTE;
 
 	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
 	return pte_flags;
-- 
2.44.0

