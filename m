Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A412C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B4D113460;
	Tue, 23 Apr 2024 15:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ybnsz/7p";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1548E113460
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICsIWEhcB+LQsJ9PKqb3d0PaQvh1NeRLtgiRaBaQEFs1evwKVLJaXnxfIkcoFq2Tl+xS7k8fhvzpRbDDS3ZEsIaWJ5UuluSKe4blt/9jLh5lM2TKuIwpbn4nzjz7n5Cluvn1PLatZhd618Cm8ieO7m4Gt3BAsltxIzL2uowAIIym1hy2hoP36XBXirWEZb0Lb2KHkMBRwg3X4NR0xwNmz+w9lpTs5DpLBizRn4FgR47vRf2SYWLDKdGPqsSMd7M+e/7Zw18qxRe9sV/ZuCHK2ibICjoF8dt6f5go0ZGG6l8RhxC3ztzi5isbN275hV4TX6GynmM7yQgYsyYEQnaXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iIreQ1+HJmiev1z2bEWU39E0dFuGu825c8ykSAWQvI=;
 b=bP0WdAGwN7rYsgvOmz2H6P62/E0grkviRyqqo6fcensCGz8wkubBUt4VKiezleO9nKU4HHBKZks/DUv5J39uW0gqateivLHwZ1IpjZspfIjhF5hcEECTMnHxXfzqT5w/kqltoLtiUclhC/s1qTM81OrYgUtTSe795lg7RXvckRfLr7Q44q2BfjvqNQZsmmGb4ewZ5HYEhT4Sk6a3Rq2LlXD7+qYg0hIhiiejumFWV47NCbzwVDZ9+CtoPyddhE7qXftc45CmAPyIdMlrZxvv9pZDuhCtjcXmqYbXokQR8fE4hRO5YuV1AkxvmoudbL/R6hSKFm+556Z4W0hEYBuIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIreQ1+HJmiev1z2bEWU39E0dFuGu825c8ykSAWQvI=;
 b=Ybnsz/7p8FUth0MuWU37se4nhBPiNrhvc3xEaWXbujkAwgTNN0wCAnZZhFsOdZaYBfcB/M+6xuVF8ktaNevCjDYsUO9DqjB1B18xOokP2jKD3Y5+wEs2Ib1Dw8sjapTCzXZqIfqfG1lBInx9JXxryPKumRDL39GZ9ymSxTg45Io=
Received: from BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:29:37 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::95) by BYAPR04CA0013.outlook.office365.com
 (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 6/6] drm/amdkfd: Bump kfd version for contiguous VRAM
 allocation
Date: Tue, 23 Apr 2024 11:29:00 -0400
Message-ID: <20240423152900.533-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423152900.533-1-Philip.Yang@amd.com>
References: <20240423152900.533-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ac95f0-c9d0-4bcb-8244-08dc63aa2f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iQZnf/lL0ZcDFwkN7U0LfzWaL/MTXj+LSK2zefVt5RBc2zmQ0a4R/VPX7a4/?=
 =?us-ascii?Q?4mETGlh/IUUJ203/hhJDFSVqVfI4wMY8EF8MxpDDAiSMcNsMGyr48LoVOnwn?=
 =?us-ascii?Q?T82b3Md99qtqiuanfYHwrmacn5EoYErciYbiGsP0NqhEuntr+ajSBv4L13Qc?=
 =?us-ascii?Q?TqV7z4VxMz/1GhLVgkVHagwfpA0g+Z3ndkLdWY2ASXMqJ36t9YlS/V1qU1Tm?=
 =?us-ascii?Q?pA5qeulzTgsEFh3bI/pzd+1XXfXf7DQyU1dF+nqJ9TkCwwatBqiMfJR8/nws?=
 =?us-ascii?Q?l8zZe4S+F1CMRbMEvQidIs74Q8xSyrpu4yombL53uqBz91XExOuAB4kAhYZD?=
 =?us-ascii?Q?PmeiJ3SSuxIlzAjJvs/XjjLeG5+r7FaFXBK0q2Dju9agrUusbCN299692v31?=
 =?us-ascii?Q?Q1nwkZZC1fNEvUnRu2t+BskXslL6NYHFGwy7CMil0PMbLd8mYoaIVFl03qV3?=
 =?us-ascii?Q?xVfYHfP+NJzgB2GBgj0mWGJ1M1IsMV81ZwcDF1ka4DJbe6/v5DP0o67Z1wfl?=
 =?us-ascii?Q?VPoaS3Hh7YuiVa1F+A+LTL89Qm+6v6W8aI+8m5fkMYGQyDXL4LpfVPt8SQsf?=
 =?us-ascii?Q?Go12Gaxbh5WzjIqZmMs0ZpQrZOkdNsLCINKXDELbXYvqjWSpwWYgVw3jfj47?=
 =?us-ascii?Q?fjyhV8r0J8454Hlchtsk+fLnpZTatVQMyUy93Yf69o9+xF/08k2KdLMzwIR3?=
 =?us-ascii?Q?ABXN1wU/k8CdCnGAw9s1O4s9ZXKIiS0JgNlm1RX0PSCxB3vuBQFpcmqZcXUQ?=
 =?us-ascii?Q?XXX7LcIRT+CEL2/xf3qdjew1I6N/iMG1E2pIYiJh3nBReIRZR02TTZMv3zxJ?=
 =?us-ascii?Q?c5XBmNZQFr3o/DLfKajTczAu3Nquo/cT2lim4pkgrzlahnZeESsJW/xvtrS2?=
 =?us-ascii?Q?JOVSLfGK3XPPFjMGFIRKnKqRFS0mh3C2bo5QYsaXh9lWQIck0rcctkGBUqgk?=
 =?us-ascii?Q?LmuC8YznhmsNlt8Stwt1N2A+/jQWiqj/J+GavRs2CntYScyyW2mDW19lTOAN?=
 =?us-ascii?Q?KfrpoOPqAjDGCEHmILrIAn+qyDBnJttWxRhZeQsSxahnAwzITXGiOBZy+GEU?=
 =?us-ascii?Q?0q/RCYvEt4abaqUNbP5YUOaAq8VuhmvgMmzfAyZlf+Qd/Ljsw+uMymjueCQs?=
 =?us-ascii?Q?Cq04WH9ovnwnjXrijlMOBsWnxd37M7ZCG36PEcmFyQ974bPOXZRrnsh0WRi3?=
 =?us-ascii?Q?+YDv5J5KRg8EcBc5EIXwLnEZlLwLbc5bqHhMfRUvFIPm66WrT/wUyaDjCxTZ?=
 =?us-ascii?Q?8IYqsBuwWlKO6Esj6rvOs/3zAKH+h+APGahmmSDCaPyb6Is4zKD6NkkqLLmR?=
 =?us-ascii?Q?JF+yBl4Fc+WM+m1Aet0UdmWb6wMZ523upa/KHwn7mG3xfOCVMVZnXfzOvZRh?=
 =?us-ascii?Q?2wbVCRQJ5Y2/kFuQ9oiWoRJqwQf5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:36.4873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ac95f0-c9d0-4bcb-8244-08dc63aa2f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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

Bump the kfd ioctl minor version to delcare the contiguous VRAM
allocation flag support.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c1394c162d4e..a5ebbe98ff7f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -41,9 +41,10 @@
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
+ * - 1.16 - Add contiguous VRAM allocation flag
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 15
+#define KFD_IOCTL_MINOR_VERSION 16
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.43.2

