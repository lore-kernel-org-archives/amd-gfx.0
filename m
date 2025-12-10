Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE4D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024C510E68D;
	Wed, 10 Dec 2025 07:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/s+M8fk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5541D10E68E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mb/TmAtkryHKRSytOWXSWhDGFBUW0vHh1QYrhPXJlcRF3iQt2Imdkj9VPgWTG4V2hkxtGP5oAfvqX9ycSUpnq9uJS9+imHTKum73wBqO4ebTad3x7NKISxXDiVtisl9PzT7mILipw/dMsBMFVmmOlu4O0Z9d6dknv/0dXL9lmhvZrgrXMF/3Bfug8+J2BomcA+BU0ASIhlvPFti7ZFjIif+nVZfsJ8/nuBp65mV+E5WJ/i1jdZ+QjdHdQR8yoZkImZ6QcPHUc+lHFj65Iy+qtdg0AL5nY3EdNd1AVJE1O0an+SZpJn2aB173nmceHXhwSOKq8aPvv7X8PTgygsgvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWDjxYNChZQyEY65estgz+rxSHDHddblg5gNuymaB9c=;
 b=FFEMr7dGZz+oZCnQ+8aSrF41Ng0aS0vF3e4cRfJWUJ+dOxVwstwGcCcEu+/uvBXxOwYR72QH4OoL+vDNUHHXzZV+LAibIZwBU4KSYtU93Oc9l24CR8inuPK6cgSmukBP+JnpYjSKVU16C66d7ZBCFoRFUNgElUNkZavCZj3iLWPqe/om7WkRjw7bS12NY9UJT2wzi3QjkWmFL5XlE23rF35R+ZdCuaPdWCKHMzr9Ne1o4pSbY3dmELlkepL0MZoCz30cvPrsccozsI7/xMs14LP15f8+LMRp4CaBdcPJxPHZp54MgbkDPthcqfpddhVWfMEshVdHxrvMJyqzEtkvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWDjxYNChZQyEY65estgz+rxSHDHddblg5gNuymaB9c=;
 b=d/s+M8fk4ljQnneFeyYSlw/6SMRiRKMP2XJ2iHx3Uwltg4ykF0SCs+3R1bAR4wt66U6bVyg3UNfmObHmWxisgpqenAUcZ9dOps7Cqdi/CQrhKS4nvqhPC5KZvzFbPPvxEDXnkrf1O2AzewyS/Ky+0TYrZJt+s1pZ7Ebj9fsxGY4=
Received: from SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::15)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.8; Wed, 10 Dec 2025 07:14:42 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::57) by SA1P222CA0189.outlook.office365.com
 (2603:10b6:806:3c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Override KFD SVM mappings for GFX 12.1
Date: Wed, 10 Dec 2025 02:14:13 -0500
Message-ID: <20251210071415.19983-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b165fa6-6411-4c4e-93f7-08de37bbc9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OpQhRzjcWfhB0crAkeF3BzvhLUEuZDx9lGQBX9ZIY8LFeJF4mo2V+9GmTpi1?=
 =?us-ascii?Q?ANz0vtlQEoSROaI38nN3TVVSNUWwi2jMSqu6ZkVJg5ayeLx6fZBX04nopyEU?=
 =?us-ascii?Q?NI07/3NUSrOo8xXL4Xfnqh3aS/zW0PhBbZcVuymUkzmGA2jM3COBdEJGxvgo?=
 =?us-ascii?Q?0A0Q/HJFjJ/xfrdwClO6GSAY0juilqVmcwbypePdkSFNXavgsUqBaaERQ0z9?=
 =?us-ascii?Q?mUiBZ5vc21nk0IAllqqBFlCdCb5BsbKZ6Gogx0iPjayHcdNj+unEfwRbboyS?=
 =?us-ascii?Q?jpC5BKU9m3N9ov+wLicQ2J29f+D7qACXpMQVfxqMS+pEoi1WZ4Rg6YOUzsT2?=
 =?us-ascii?Q?sqjDMEdb5TbzZFgsLROEmPfhvdeGo2EIz4bd1Y2Z9K0tPdZHzVoHCI9cUMp0?=
 =?us-ascii?Q?yRNtmdXLwIs/tzALHpLKvv1AU/d5frtEcVGd+Dwe2cLO8tpDLgegU1nWeULh?=
 =?us-ascii?Q?D36fILRje67PgAQJQoaM3uJXek1Hy2B2unp5BLtU6XGhSE00zwS3YI5bOPFW?=
 =?us-ascii?Q?arhNETWH9ZgNFRpKIUBvCy/rXIqvegDid4F+5R+1xABKONsZ3+FI2H/8MZVu?=
 =?us-ascii?Q?s4K/qGFyJ9Qtq3Sq0e543dLWEHbqyl8FkaOpWEdkddiHm9WfxkYTXiqTSXFF?=
 =?us-ascii?Q?dluZDmLdnnpe7ep5yGM5DSRTG0fvp8T0w1kHYdISEefH+DxGYH4y9KgHw7Ae?=
 =?us-ascii?Q?nHu5579MxKV4X3Vt4E8N5cX6rhiMO7bw4JtPGUD9OQ4h32gfwB4S2ed2ZTtX?=
 =?us-ascii?Q?C56c9EA6qmfuNwPzDS+jF0IPw5YPMYOC3UfCFvcxqyL6ciUS0AxsQloYj4DB?=
 =?us-ascii?Q?NmHK5Cz84GAH9E/xrSDTjevqFkAhq0FxEMxaPIRs5gd+LUhdyPj1I5JoSvlp?=
 =?us-ascii?Q?rxO0ONR8sqLEFl9Yrk45o8fJlLH7nPXvnJYo2vgiGk8YJ+XmCtFdAvoLT9ad?=
 =?us-ascii?Q?6efKonf/6LAJTUbArIN9UgIJEwpfdHf9N5nc6enQGpXKxHSfNZvqqurc99cr?=
 =?us-ascii?Q?aCShjTAHAsR/MCTwMUyLomuB0tT2ItH2gW8vaYAl2NM6a8NTZWYVMGXV+RTt?=
 =?us-ascii?Q?BD5VvVDgeD2oiwT9kWXvfkKlncom7KU7hRbD12R1tGaxhzB572LX4y+Ej/6B?=
 =?us-ascii?Q?C+RSZHGv4fvPKy1bQHEK7w3UnWePmzKJF3EGTnG21zCohO7gxHuGNb5lAn+E?=
 =?us-ascii?Q?wmWhhF+9lkPDY1aymNzEF5w0eR/xVHxLizYw2ebCYR7A+JsYX14vNC723PRo?=
 =?us-ascii?Q?Bx+gwMgmWqXWKu4+X7By1gSVoy+wB9wbrzu+P2n0B2BTQ64q27/8re8xPUCB?=
 =?us-ascii?Q?621q2+d238Y0CfLxTO4BMrFfi9h8AsNsZGrn/CO0fRkep/Ip4YLzKPfCsmsu?=
 =?us-ascii?Q?vJrF8jWIB8i9BStMy78hFPCyIAGnlahkc/s0RNBJ26zEfziBlsom7emtpCCJ?=
 =?us-ascii?Q?Lh6LwXnZnVNQbO/HM9fidVaogFc2rAZ2nZLOUiZkE4JQUZIDUgfiHpd92DDq?=
 =?us-ascii?Q?1bcJLaAPwbj6258u97xFZ6ecvsKYrk0CiAtrz/mk0Suj/Nuils7YWj1sLMwn?=
 =?us-ascii?Q?tGfdoQKlmKnJjw8D2ps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:41.6872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b165fa6-6411-4c4e-93f7-08de37bbc9d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

From: Mukul Joshi <mukul.joshi@amd.com>

Override the local MTYPE mappings in KFD SVM code with mtype_local
modprobe param for GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3235774f3b64c..1ed08388d3646 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1309,9 +1309,11 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	case IP_VERSION(12, 1, 0):
 		snoop = true;
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
+			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+								AMDGPU_VM_MTYPE_RW;
 			/* local HBM  */
 			if (bo_node->adev == node->adev)
-				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+				mapping_flags |= mtype_local;
 			/* Remote GPU memory */
 			else
 				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC :
-- 
2.52.0

