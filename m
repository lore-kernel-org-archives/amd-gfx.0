Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8F3D19518
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D9D110E47F;
	Mon, 26 Jan 2026 20:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2SUcMLUy";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2636210E47D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2RcBTLyHA76Xm1i7I4IBZumtTTb2lNWvLYaf5uQg34pDLndhiuYVSwEDkJIfEhy/0V3GdOPwEQzDXgWbq6B7XWEOYNVOQ6w1/5bzj2Gltjlu8C8OR9UKgCpOCIDmb3P8i46c56FdYMNNn/tI9N9vkJ9yjhllT9rmWSrjI1xvh/rxuFcDUeM8lEHfl16PsOurfjiQ+5ChRCX9M6n6sXllCHA6A1J17MPyPOmGegzFWf2id3ytcIwpRK6GpIqig1UluH88d6kpU1lkoQ4ab6xq71J765Lw8gIDx0GAod7/3qx2sazwxww8cmxo7wIDCuXiWaheuXLpWMOSP1Ze1aPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lfWzT8zJngFf5AuO4iKiuPanXXIVzQNrRMJTuYDsBA=;
 b=C9QjV/gudZ5d8MTa5xmdWMiPXZzKPphyzz/qBRmrVVDICEWm2Sgdq4cO/lWh2I22G4Rr8TWQtJVQkUxRmWHE3ZoV1eeb4bpPmUlQ4i8EBESQ4G5x2iaPhk8QKNV/LxWAvzoPIBIPeYbDsMTn+5BqEEyQGDJZGASPiRjLM2Fc4U4J0gxjnzEu78NqPACKlRf6Es3/2hSv1h0oGYu0ykjQ8IyPgkdvk8wiu8CLUmNTULP5wli1ig3yT1mf6vj4gy7cH65Qy13UHfWfsuJuf2xmwK7ptF+lRxRMet/OsoYkESid9kcrA1RDDr4OtsYpoexl4RVFwUVSYKcrx3P588yhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lfWzT8zJngFf5AuO4iKiuPanXXIVzQNrRMJTuYDsBA=;
 b=2SUcMLUyDMkbM3SqHHVfLaZ/iPTp1xElDXpTBYX/nMhjldX8SI6Utze0aICK+B7lHpmjGV0gHhuzGB+7+/iUMlqML6vO7OqISjYPou2J9V5Q077wrX8GjrLdyF1o+yEwYRHp8H8IweMWx+vxjzcj7sfLlYi+vseQVZruEnkKM6o=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 20:07:59 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::3a) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:07:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 04/12] drm/amdgpu/gmc9: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:39 -0500
Message-ID: <20260126200747.13527-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0cbfdf-0d43-4330-ce91-08de5d169a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLe/TVqCeOo9ThJPbmWLu+3A30X9HH5jHJD6AmUQAnO3UhEXqppbSJBA+3xk?=
 =?us-ascii?Q?lqsQbBqpkjNgOn2hSe4VdFBrZ9Q2IDQcez3FGJYwsiduZFQeWaJ1dTjYVm2o?=
 =?us-ascii?Q?5JDzihklSoBwPhn+LU9oofHJ7U87tiipOw+1d2Z13tEwZk3kBOJXq0abp3Rb?=
 =?us-ascii?Q?0uAZrIFDddPRfCInbJ7Y8wlyHAJCJxBoGkiMMFe/y3ADefsxBYk/62uAx+Y6?=
 =?us-ascii?Q?y7DuWtJGN8Ayzo6x7NXFkdhqGmIjEGhMz6QthSUpeme4cDisz1xxDcYNCcwl?=
 =?us-ascii?Q?MIxR9ak27ksnXPuaGmfDEyeo47yDzSD0f70yUorM0B/xv7tSQeRccZhbqKrH?=
 =?us-ascii?Q?iwVcXA7Ph8Auoddie4+5vxcGAfw6LIk45umTkAKyIrZImc70DarNfmYK4OyY?=
 =?us-ascii?Q?VoMMHVNDjAh2InA4LQHCFSDW4yB/UAN58izHmO0dbjyh5C3pHcEqxwDfIVNC?=
 =?us-ascii?Q?SMm7Zs9m7bqDFQRIgcxq7Z8OO3NdZjGAIhT5oFhZqfKn4Crwm0gbXLCl/Lc8?=
 =?us-ascii?Q?1CeLh1spqAUhzt4nTrJADz9FNlUXIGqX2uoPXaDTSuhKfe/79yd52E7bgfLD?=
 =?us-ascii?Q?DdY2jCyVbqgZdJ1YQSpfbs1n0fbAn+xDy0qAR4JvU15dbXbvxtZfLsxdZeqN?=
 =?us-ascii?Q?u3a1lRP9jgGNWRjEjykM2X11/nVuR1p6j6OlHJOfyLDjAQXKKIrL43HSWQEZ?=
 =?us-ascii?Q?kHb/f/z5hShPJ17YY8bvtGRosddPPoymD+Kmcbql4o749Hy0bSRq9iBGuJap?=
 =?us-ascii?Q?lEigkSMwNPeA/LSu7lL8G6Ba6C7L9OvcdxUGvjFU9q1V46A2k/rekHxMgfc+?=
 =?us-ascii?Q?wYoG+jcstncPspKLNQadi1qYQRqEHYuKLnkFg3f8yI6PNTPKBz3xOfzDKs6d?=
 =?us-ascii?Q?P2iaYPDe6eAjOPsFvcNCOT/R9VWgIgl4hFfiWaqjmZU6AO/IZZWP0BZ3UShA?=
 =?us-ascii?Q?ITfaWiebC3h/DrIgMhndGWT/xGkdXfFjcfNMMU1+ZddbHwAPt5GfDlz5LQ4P?=
 =?us-ascii?Q?ZlZOa88uhBfiKcjt5UzvtLwkqkEhR9LVHlDj4jZwRh9TylMUMkRq3FYLXjrA?=
 =?us-ascii?Q?M5vIIaKhRaNq7Fdu5JPdgBdl2wUg9Zyh1RTZPy/7dsodfDH/9Y5QMmpuKvus?=
 =?us-ascii?Q?Tt0vZENSKvsvU1GBDq2IwNF76eybZn7BY6YodjYFbiwcbzzSdBHknh4g+FqJ?=
 =?us-ascii?Q?PA99X2QRvl8AAfEuzCzBxpj58qv+2hQwijVHWSUWXpiFJJfy8k15l+meMf8U?=
 =?us-ascii?Q?h5Tgq/fUrJR79Hj+g+Xh7oFUrvc92yh37Gpr/fGJYtDMBbcEjNABHo+9rfv9?=
 =?us-ascii?Q?V2ExP7evfI+u3fnqH8yMuJP4FIqfBwqjMXijXQfP/YBYmYjKKlBvt3D2aISR?=
 =?us-ascii?Q?1/iwN2hROuqqtbzt+fl+Zxv8BAoZEQzkq3OOq2MQSBdMvDtqGHshEU9s80Bc?=
 =?us-ascii?Q?8IwcyANe7bJrOhc+MwW/O0phMcgdcB+xjits1rGAm5/tG8dOPeb9wJd0wPKs?=
 =?us-ascii?Q?CimBrXBJR8Gjo3uV9GwOvxyLtHGefpqZQNoPP+gcJUgkZHM+/hn5m4vHFuKG?=
 =?us-ascii?Q?0VAXe51AFex6aj2fnMYC4tjcqhlyWYc8lUivuQqR2xJl4zORb/iufZ0q8are?=
 =?us-ascii?Q?FATNw8Ay90yz2w9Ci5vGJFxQv6kDIWSX8vFQEYaZdripiLfCsHwME54QNTUm?=
 =?us-ascii?Q?Lwf3kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:07:58.6792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0cbfdf-0d43-4330-ce91-08de5d169a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2568eeaae9454..7a8e86efdfe40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -64,6 +64,7 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *src, unsigned int type,
 				   enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		/* MM HUB */
@@ -92,6 +93,7 @@ gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

