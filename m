Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCF6E69E97
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B47010E86A;
	Mon,  2 Dec 2024 21:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WfNYhLEg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002D310E860
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trw6S6fRwOzhga62laYL+O4TUUREULCGOU1XPg0x6txCaGvR3iNdoZMy+NnPf8vDJZmPtHrP535PSjrdwLqb1aLsfkrhH1aQ2WZ1UD5yKVO2e7FG83ZA9XGjrOV4Jri23+aSWr7vDxdl1MAOBSiYGQn2JAOae0Xxd4xWcX5fM9PURMrIbb9aH02mg6dnO3oK1FZIZIQwyqs99IzyAwIAItNuBjlFq9Gk87gzhb9sgAhuY4tEnlCxaEJ9yfE++2hPcr4h//Zd+bGsG8eCTYuWRZd3eA0J8yrgNvYEsTTgOU/D9YNrOyK1NGLdgIjDJNVfOUCvJWtZiSAIuFl+dVSv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyzsDiO8hSwHtESX+koJHFwii+UWiSmV6UVaJKtX1IA=;
 b=gGo4q2zVF+NJtjd7X5kNycAG0kMzwTEb9J8XN3CI9TU3Gc40sVkHbFx4hs+X3Mz1v4ZaOYtBEB7bTyKKRJ9hJ0F3CDzdrpSNx577Ma3N+h9gubsBwlWoRmA+TQeAsl0m7agLnO1TGtPmvDj5tddPef40EC0aH9JYB0MG3XH6C43OLPhWKZzsBWOFmloLIBthCfKWVZcl4ONpVOv3ngd50vLNySzBkQKKnZHPmF5VDmRuwQ41es+CWhB+EdM+WNha6kHWL7q97YjP3b01QF9Dwk6Uoz7keBCvKMbq4u98PMg2FQ4/faV0/IWY4dXNntC3mpHO6/2LfjsKE5bXcyGjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyzsDiO8hSwHtESX+koJHFwii+UWiSmV6UVaJKtX1IA=;
 b=WfNYhLEg+nviz4Sqscxr9jJsfgNgQq+nTZW1+mtGrnA4gHJ9468QrHzIUAyc3+5S9YIuldI+/OSoDNuQw2i4MywptRESadY4lYTtvnv8oxw3OcJX7qmlTiwfLl73T601I7L5BxVmVekQacYofHD2PyW+PNjXtrsg0L5/af4kXT8=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:50:14 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::9c) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/11] drm/amdgpu: Set proper MTYPE for GC 9.5.0
Date: Mon, 2 Dec 2024 16:49:45 -0500
Message-ID: <20241202214952.1125211-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: db97b15e-e297-498f-06f7-08dd131b4d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bic1Jiq+kwjR6HzuC8cmBMgEUoMBbvYT23GLkWb9TsEaRWJ1nCDZOj1p5avk?=
 =?us-ascii?Q?xSlb4GdV8X73Oc7mFUDDBQR1YYMUuV7PhI/qIO2/guoNdeMIy+whVDyq/OzY?=
 =?us-ascii?Q?yZKhk2qmIrSjUpX9TUaaQm2OsMsEk0e2nMgba3b558KpEQhM9DM6Xzysi9sd?=
 =?us-ascii?Q?1dZjGTVx/esHpv4NlQXaIF28XIX7TvhNu6aHLezDWrro1mDqaM9vZVFyUOCy?=
 =?us-ascii?Q?k9xTTJzOWcM9UxkQvit2H6BpKdXmOuzVMx0uyvUHoqLcz7xutxUvcQPAUo1h?=
 =?us-ascii?Q?qRQMAmMCq5MnmKIJ/6g6uxlt18N5rIbLZEwNBVpI2zhGYVRpHKQU21EC620C?=
 =?us-ascii?Q?4+qX5xenAjtgh29K1NaZWumExidf8DsMdtWKN2otvy/GOcpo49CP7y/KlrfR?=
 =?us-ascii?Q?LKe3x+aP+o3eYmxtFUGisddJDlNYCa42WAqG/UhdSmHgB4QyUgcvBef6iRCA?=
 =?us-ascii?Q?9OiopIInHlEHPTc8wdImgWk15/hgDKq7oLs6uFaLC4ZzD/+RQ9vqxZOaRnJl?=
 =?us-ascii?Q?+dlFp8trfl562KIcO8zQtWDTbWJym2ziBW2JoSlkh6KNtzTMPoH4igvvEgfg?=
 =?us-ascii?Q?nLP9ljGk39IY8U0l/wlTi9PpOrYInXd/LSkmtnS7ttWMbiuWf8CPvbYnBuaC?=
 =?us-ascii?Q?CEqQhH1YvYMzoauUvF+i+YCLWDk5OuS9XUMvZ4IWvpIyajNWFLlB2WOeJwN2?=
 =?us-ascii?Q?Dif4MbCICqZ3IA6YBOO736O3ERFIReR4FQdqJIT36GZGP17b/HfjOnLlpbI6?=
 =?us-ascii?Q?YZoKPf/V8g2gcdWKzbzyOhHrY87EU8Ok+kRQooIr2F8w6Xouu15CQgj1e4X0?=
 =?us-ascii?Q?EnT7UDI/NgWsMGAKPsYVk7iy5MO5UdBg7Fd9HMWfrK1Z1msaxeKAoNxhNYDW?=
 =?us-ascii?Q?f1JYoClK2kZAiyj1iZMvNTtVKRVx3pLSId5pnlwZprGA+VjicfoQ0Ww+Ir3R?=
 =?us-ascii?Q?TW7gZXKsrwrBry7ctzxqI/R9lxJfYlGUpRtNJymNnPEvz8Ads+5hcJgQKZQn?=
 =?us-ascii?Q?KDvQsdbDxnMjfbpvrtiLWedHQWnl2KM4sKOa3iE0Y3fh7RsJon9cQozdiFLo?=
 =?us-ascii?Q?klW9w1zgSd0nCtmyMRtF0APpw8Y2sgMxFaAP471NZkvaY+3LyzAFS/ZTeFqb?=
 =?us-ascii?Q?1vaX2cS8oelmpurB5sMFmAALBmXfCbodrZwZrwPbQnbdOSBUU42xwMd2UZwM?=
 =?us-ascii?Q?4FWut1c9i9jzEUyvd0LsTh4xbP+Mg83FwozUGliHaPMRmqnc2xpvWGj9StKF?=
 =?us-ascii?Q?HjHzk547FmtIxW5O+G5u3EsVjaQYjunYQUzjc9oD4bZAUARMaKyvMrnmkhMv?=
 =?us-ascii?Q?5LzFVxJNkPlOs8yDn1vfhfIvu63jk8cShRp2n3zqAjhubapaoVlSWOXJ31sL?=
 =?us-ascii?Q?jdpRruHRG85v0e3fxvManI0Yuf3rC+fisiHXfErHONWd3H1Be8YxZQ8I6d7Q?=
 =?us-ascii?Q?BIEkTnBlMOM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:14.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db97b15e-e297-498f-06f7-08dd131b4d8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

From: Alex Sierra <alex.sierra@amd.com>

GC 9.5.0 local memory MTYPE default should be set as RW.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c096caf314c0e..315916bec6709 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1242,6 +1242,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		break;
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
 		if (ext_coherent)
 			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
 		else
-- 
2.47.0

