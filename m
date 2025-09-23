Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BECAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5CE10E578;
	Tue, 23 Sep 2025 07:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFQ5o50q";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AA010E578
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thKdo8k+kWjeCwrqhYfWPSapfjwlRz9Za+qAZtBI9YxtOh2P+cKuwff7HbL00ROEyE3ywLW4thmsSdm8CuCkSa68l2/DIFKLVFFWgnbFa+DYSdaG4C95W8tlg30bHQigSHxhD1yWPDgGmRQbtwNWoTwj6BQXQmNUkiFTxB5XCrF0lhFEV4Pqnpi081kxnnA9VEiHyJf6iJR/sMompXbHfVY1+4+kW6zF73dIqwDCaHjzDmkOKi5wTJnsn2OS8JuWUBtCVWQ9r2HTkkFq6we3L3HKBVuBSulXZpzheycBDxbrFWy+pJbG+jc+LrGOTV7fFDeqTnFyiQCu1OC7XmxasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mqoCYaUUxlnOpicxD0sxC+Tt5CVQWuuC5I2FedFORs=;
 b=mlAxzabpVsFxylIQCPFH5TtVZAhVtqMVImB6FiU+TaN1UR18Yw48AxfSyUZ5Z1TTFoNpqrmEj7ZCaMmYrz1ZBXSWpHUVfbXswWS+3Cw6kp2G9uXyRXFGQsphKiSG3dSJKmYx6UjamlTuB/bg6o8JS/IBUCU46GbJEQaOnzqS0tiE8uM3sM8VXpvJ6pKJhXNmQFmFnH2cNymZb0dMv3rsH4ioVezI364dZe3eA1JC+Jd0chMR0KYfqt/ikB8mNG4E4BVq5Kw5gbsIwloH/+e1pWV2ETGR3tDfwyz63J/rj56YLF8A9VOAv6cUMHMrpw50Ijsh7sEDk6D51UoRGupsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mqoCYaUUxlnOpicxD0sxC+Tt5CVQWuuC5I2FedFORs=;
 b=RFQ5o50qlq0BrRityZm1oBUE2/K3b6JrLw2UKSTjX6hHRGcrXkaVDGhhmlB12y4N9VvMNbv9f+2TlpRuJtCmSf1BhCd4hXSOcl+SMbIK9SUBKHlgCuE7+13Rz/mZ7i4LT8Kj+mzFPbo4axAUY/StA21yL0X4zW3ZMCIkTCKR7OY=
Received: from SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:49 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::4d) by SJ0PR05CA0032.outlook.office365.com
 (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.17 via Frontend Transport; Tue,
 23 Sep 2025 07:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:49 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:39 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 06/18] amdkfd: process svm ioctl only on the primary kfd
 process
Date: Tue, 23 Sep 2025 15:25:56 +0800
Message-ID: <20250923072608.252345-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 32da5049-4bff-4f9f-500e-08ddfa728f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xfp8hpPbFgThKeo/JAafsAhYY7b0KCtyCQlqK8PYmrMn46IRkBH2a6DZqnV0?=
 =?us-ascii?Q?n6zvQLo11INln0MF9bZ+WYXXZjGwyeR01bWnmBgPjSrcX9J84MLQSiY0B1hG?=
 =?us-ascii?Q?vEIJVmSp+jVygeizHeJkN7sCZxxjUb5Vuhy6jaU1/GbudvKa3CUIDtxuRvt/?=
 =?us-ascii?Q?wGb/mms3CNvXXIOMsdN4ptZ2AKVnfztpGhwvviKxTJ/59RFof26YpiOv5trB?=
 =?us-ascii?Q?H4W/4NaWNqPK9zrBkMzBWAzQJ+wmPGnR2dIycuMNdIawEtTOEcz5zQRCPrxf?=
 =?us-ascii?Q?kq6lFgDu/t1m5cz2NgO6ESgdAEKQr6PJny0jD/rHqrpZ1vwKEbx9XZGcy5sf?=
 =?us-ascii?Q?5vM9AznYl/kMg5mDUCb/P7AMoX/2y/OWMgnW4kJwGwl6KLHmtU1vIPfHUs2u?=
 =?us-ascii?Q?jJEcuvCEN+ZQEaUxkPZrhOF456LsMxBwUuXvo7SEN+pc0ap0HiSlgaqbBglU?=
 =?us-ascii?Q?PzPD70OJLcOsy8LvxHk4nqR5Fu0CymRHGuikkEeDUJ121sS5aEa2h++Oi2de?=
 =?us-ascii?Q?7IuiuChs2Gy/DFj5Yra1zKOCsbliQSpWJ4QYdjB+gIw12hnV4omWRF0SGW7n?=
 =?us-ascii?Q?bTak1yztYKpqolpwqPYc+TiyUAJsDyluynaCK/ZhX57C4fWNvq5eh1IT/O+h?=
 =?us-ascii?Q?FssxdCBH37gXBRjfi6OxHh4LJ96pmYTomr6muWyBBYLUZ051GuqK2ZlN5F3r?=
 =?us-ascii?Q?4j6hBHm6SMlaKz5/bf2tyBDomE1WHl7hfxeeMtJQ75NnGOaLawDgakvY2c3U?=
 =?us-ascii?Q?XR4WAp8EHND7D4unt7mWG2fXlOWAcwX63YJH3HRqWAVwCiS9mOtmAQQNneVd?=
 =?us-ascii?Q?iAybunDlx7ZqcKWnjAkYhfe1agPFN9g7h0YPhwKi1CTL+Ymtphzib9tHCmUh?=
 =?us-ascii?Q?lNyhIOOaNylJlcCjTt3CBDtAM/faVYtqdF1ArVMNRy94M+ov2x7ExBTBDdxl?=
 =?us-ascii?Q?UHtDRxjmK0A/ekkfVBgfFJ3/RCu/fWRiDQKHRiaetdaYYSjxOHqTeLvutv8v?=
 =?us-ascii?Q?Ma9hL6oVTh1f/tMZPXR6vS0k8925uU5a+UFPJ6FehvHcyqZAL4Utj4Vd/XHY?=
 =?us-ascii?Q?rbL9mN+PQmz6eB2mugT2lCTkZaCRQgx9UCx03xz9+7/aA/z7MAlAb00N91om?=
 =?us-ascii?Q?mEpZ658VI8zX/CH73EttZBWijm+3OjOLDk8D4P4m4ve+9jUbbiSiLgmkIPmz?=
 =?us-ascii?Q?4SfVib+w8JPL5Ut+EjJxmchzoYCXWAArdlI9mbg3Mpoj796bzPKt+ZOUGvt0?=
 =?us-ascii?Q?ffv+BAGM23RXBcBs9tPBaTQDY0xTodMRSRZv1DsEAQF113Hc2GUxFN1ng+mg?=
 =?us-ascii?Q?n6NgbDkVoHyiI/M2S4U/VR1Ly7GECPj9FFytJN9JSrKo9auCiTvvQ2u4rXXP?=
 =?us-ascii?Q?BX3Su+kC3z2Car40GuHp2pgdJTvi8f/ae2www1flscNgby7SAwo0o6PFNiXh?=
 =?us-ascii?Q?70ao0cWzHR3K5LmXwgGUxdaGtsxczpy4qJXZjKXmfchMkjs64BePBQUggp99?=
 =?us-ascii?Q?QyBugPVdiGdf63cil6iRBW4GbgANXdSj2RKp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:49.0143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da5049-4bff-4f9f-500e-08ddfa728f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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

svm ioctl should only be processed on the primary
kfd process because only the lifecycle of the
primary kfd process is tied to the  user space
applicaiton.

Another reason is in virtualization the hypervisor owns
the primary kfd process as a privileged one.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e8c6273de99b..f56faf11ee43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1719,6 +1719,12 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
+	if (!p->primary) {
+		pr_debug("SVM ioctl not supported on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
-- 
2.51.0

