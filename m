Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3968CC83F09
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 02:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39F710E3F5;
	Mon,  7 Jul 2025 02:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iFJ3olZy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D1A10E3FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 02:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCfv32KlgelTQ9rDAw+Z3831DvBNjFULAMMT0TgPVUY2LZEUcpoEepufqZG4e/gzb09tnKRvLffs2HrpQKBuS/nGoUL8rPc4UkGxqJ+LZgGW27tDreEQ5bpCT5GyQnBmezXErdVOXwfJ4feMlw+cH+lEzhnViJIWH7m2mv4SJAnFpXdSMVCDjh6+omX7Kz0ny165kn6BeDJ037+usWYlRsJ9g/TNLCUB01HL7zoZ38DG57RAa18xfM/JLint6EjHlMJqsArWHUatTlATxKezxueVU5tzU2Vf/gWptxhxzuAurxkULlVCNyXc0YK+IWyRxfEnks+zobXkY8tpUAcM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPyj4Woc7ZpmIha977iT30j6sbRqG9OpUzJnrfsMxWk=;
 b=eDiWCMXekERzhDUyh8Bymp5BrE9elAea4fvlAXis0znWVnAU0tgr73aFX7Y/PoS6nVw4EI2arwZUu04dXijF8HxZ7yAIZ2Q0E9FkQy1ryVcPOk/wicuQf+3fg6Cu17FAfALwPXBUpT/OmEAVtTXkuOz617Lmt/gbyRWxzVKdmnXBdIdq1dt1jAMEY0uuKr4Njqfr/Cztpghl0DhBh/3ek9FQMi6OQmWu5I9RiB23EVUpsKwbKLcE2eKXpt6i6eAGxlLj7zBKuwlQJoMNEdyvkh6Q/MAul1hVLWM0uKbHInK3o4tNmbcN1fcULKGH+/gjiknh90hA3IlbnA2/47Ww+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPyj4Woc7ZpmIha977iT30j6sbRqG9OpUzJnrfsMxWk=;
 b=iFJ3olZysf8ORiv3eGxxbi+t1zqA2AzRM84Ao8xOMV0jILlIaj6UPmkoq/yAm3huZ0U9603yp99rUr/dEcFEst6x4b3ZeatgSYJgs+Zqop3UWeN4f25Alr0+cdjFtmLLXJtiyrrT6fOn+SZRhSJegX0FB1cU/NYx8a56y+DjUAA=
Received: from MN0P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::30)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 02:50:48 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::15) by MN0P221CA0008.outlook.office365.com
 (2603:10b6:208:52a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 02:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 02:50:47 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 6 Jul 2025 21:50:45 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shimmer.Huang@amd.com>, <Perry.Yuan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix build error when CONFIG_SUSPEND is disabled
Date: Mon, 7 Jul 2025 10:50:31 +0800
Message-ID: <20250707025031.647758-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec80ba7-86eb-4470-97b8-08ddbd011374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8z6f8UUcDgru9+66voB/5jC/olQPv+WViIPrkXOGxakViylaXZNW98+XDds?=
 =?us-ascii?Q?ApCF92QRAPHutfBZOkNvedoe5j8hDrRs+NbDo3op9cJmTK8vi5qxSuerhCxt?=
 =?us-ascii?Q?AN2wCup4CtrP9v294TWN08oNEL+wTH8+mn7NKXTRNU7Q8JbV7CzqFTNNx0jH?=
 =?us-ascii?Q?DBz8jka5vRFO9cqU1Vm10ip0V0sapEzgHnygsL8siNREL0Wkd44MaaZVxyhU?=
 =?us-ascii?Q?VjQifxPq43nzXoBXb3dDdGpnWLuoR850W0bFGXtqCe16UMqL12Xs4gKXNCj+?=
 =?us-ascii?Q?lhrPARtNtzSbwNx3IppnnVlP/qciGgVOBtU4txOtBJjbFU15fdJJtqh/fBHu?=
 =?us-ascii?Q?cNoV+nvbvPPux/iOHFF2Xk2ZOp0N11hDhPrfFxomZ9Xi+uy/Y4ndbtghIB8X?=
 =?us-ascii?Q?TRSlL/LbN2+ZDxmBp61BCfk6Uq6dRmNe+4NphHxKUBCuw+166wWUaW3/DNxi?=
 =?us-ascii?Q?L6YPNgDn3UQXB+JmBhmtzmRlApOwkOBIxvHvVQdlkjXMnVq9jDHhlI5bvXl9?=
 =?us-ascii?Q?X9Rk58D7tOUFU21alZD9j1ARr8tdtZJ3UQbQBhixhp4JWulSC1LIFvUtu+iF?=
 =?us-ascii?Q?nxuvbG5z6dtyOp39IhmHzY3CJ+XkrXHipIx8v6oQuyRobpXMPoCmQ56XIjFO?=
 =?us-ascii?Q?chAh4d6pZ/kIY1tkS4n7ljr4dexVbfiO52d8nUYMta4TAGhD6FEAVkNDUtLq?=
 =?us-ascii?Q?lwc/wb5aWv0CExx5J5O3hYzYJUeCk8zF5pUHj9HKDhlWJwGDFjjJRyvG/KNe?=
 =?us-ascii?Q?c7gH0HbbXHwpNjwQo93sWR1zABXSCvQn7tBB5r67hkWk9yKb0al3PDViB/ks?=
 =?us-ascii?Q?IWBAIcr1R/eA9TbR0bvecQdtPO8ZHELiAs97cnYF6WpA/yOJfATx6JCvM1bu?=
 =?us-ascii?Q?jGiLaVb88CTJPfdnlixF270jdjGRvwtFkLNNfND5dJgbEfigeIFVRv4m+1F7?=
 =?us-ascii?Q?DRlwb6qh3tNx0rufbzWC9+F8yHX2BSKC3fySJB3CMlkEjuIcm5t+sABbkrax?=
 =?us-ascii?Q?5gjujQqnD8QO/oycxgjYQN5FvvwSSDdfPpesBu3R0C1EvjSURO4stLITKPwp?=
 =?us-ascii?Q?hz8+1jYbzVWgKYDm7+pkpjZAqiR2nayQ3k4dPRqih51EGlTpEmvZhx4NWvye?=
 =?us-ascii?Q?lvtbB1Gi5fJc1osZxxHH6JJH+LHY5SLQSDOC7B9gGi7NH6Fio/12Owi7dAYS?=
 =?us-ascii?Q?7+nWXgB7jQB3jSfDk8mb2Kw82qVOjpMHP85cARRO8L1cJhHoxTS80uX9mwSd?=
 =?us-ascii?Q?jyFMqWGPETUG4f6ecf4kY7/cy1jfvm12RGiQtM7Wh3BG7pV817MNy62EsBUv?=
 =?us-ascii?Q?h+5eHE7PeBiK4qsH173HKsA9jkAwDX8a7UfSpUpWKzi4OOkyaugcpDJBbbeq?=
 =?us-ascii?Q?CPIXDm4lWlZrQWzCd5MCQ451rzFKrFiA5rrBV8pcIIFXUCbHH6WFbvgUj945?=
 =?us-ascii?Q?JJ0P51MYFbr1IIL36Vp6uiRVAI87ZeczE8B/tVEUsIzUEhZd3ZjbASeNRMG1?=
 =?us-ascii?Q?kZeFlRLK4hyApaLT9SAIF+1QWRDkaGxgJnB+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 02:50:47.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec80ba7-86eb-4470-97b8-08ddbd011374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561
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

The variable `pm_suspend_target_state` is conditionally defined only when
`CONFIG_SUSPEND` is enabled (see `include/linux/suspend.h`). Directly
referencing it without guarding by `#ifdef CONFIG_SUSPEND` causes build
failures when suspend functionality is disabled (e.g., `CONFIG_SUSPEND=n`).

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4f8632737574..d3b6518a65f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2588,6 +2588,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
 	if (!adev->in_s0ix && !adev->in_s3) {
+#if IS_ENABLED(CONFIG_SUSPEND)
 		/* don't allow going deep first time followed by s2idle the next time */
 		if (adev->last_suspend_state != PM_SUSPEND_ON &&
 		    adev->last_suspend_state != pm_suspend_target_state) {
@@ -2595,11 +2596,14 @@ static int amdgpu_pmops_suspend(struct device *dev)
 				     pm_suspend_target_state);
 			return -EINVAL;
 		}
+#endif
 		return 0;
 	}
 
+#if IS_ENABLED(CONFIG_SUSPEND)
 	/* cache the state last used for suspend */
 	adev->last_suspend_state = pm_suspend_target_state;
+#endif
 
 	return amdgpu_device_suspend(drm_dev, true);
 }
-- 
2.34.1

