Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F08CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BC010E239;
	Thu,  6 Nov 2025 06:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmf0ui01";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389B310E239
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qk66AzI54/A1Ew2GTkLKHRyrODGuSLDsCcHBBvjQU2kHUqaVL1lUw/MsPvgDorimVpDb2fm80g3eOsCCOjpoMM4ucaQIzruRJUTUKAwQ/Wln20Uj4PExNQLVQcuvaTFahSrKmLrfqX/JnMu8Ag4qbmsMW3tvX6AHArWcAp7ZU02yq8gqp7iM1rdz3B9dpVoynJrW7dLiqUHkkm1s/NS9CNdXpBJQRE4y6uXmnDhEaFoVS5Ze/KRwfatU1QW3uCBfBrqIO+SUbDgi4uUoc8EBL2szCOTRjlRXZLLMMmK+s6JnIfAZs+usO+cyYr6EnX0TiisB0UpKRrciFYCmmzstaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf9T5hOTFnhyKs6InUPA/mvF5yHIkb0BiNPpKT53Zmc=;
 b=tN/nBgke2ayddZk9QaKzWe5rQgRSADPJ5eumEqGD66d/lTRzTJVR2Za874ps0+VGZcjSwXCPhB8Y9qWjfSIAIDq2VbXKfgg8F7hgcOiNu9GKxUYfZWdMO8baKA8L6OU0iMUoaafgEqsMCJwatGBF3NsLk1hmpZGGZgS375E5wAlrbST87Y5aDur3+TS3RlDoPaWdVC3+Y633hbXYcx+rdMGzqnaR4B768xZ9ub881XiXq4YD5zr52vWWkj4GD5yfHIH2lprTGB+WxrP06R3Qco9mv0NBTp/qJvqOBlf0dDYRzVGxQjQafS3GHdnAJlGvyhqYh08bU2P17cw7BFOs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf9T5hOTFnhyKs6InUPA/mvF5yHIkb0BiNPpKT53Zmc=;
 b=qmf0ui01xivFMGhvk9hzgkA/4cxkEBbX3QjEEUQWYy9qBx1fkTAfsfFJ5d4J7qaURl9ml/wdHedIPVDWacWrPrvz5bF3OUAJplx5WW3YhCMj9lw/AcAtH3XFonoGZn6KgDrqoCoThU9/u0E3SZqeWeswJs/RPSm7NapKjsNV27w=
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.8; Thu, 6 Nov 2025 06:08:08 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d9) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 06:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:06 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:04 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 01/18] amdkfd: enlarge the hashtable of kfd_process
Date: Thu, 6 Nov 2025 14:07:22 +0800
Message-ID: <20251106060739.2281-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b7d0be-da9d-4bcb-4f4b-08de1cfadac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tuTh1wPuc/ZH0rL2647zzpF7DGZkzo7Z1i45JfEiad+CV6+CT/34LgRZf6ET?=
 =?us-ascii?Q?1LF5jGittoXbd6jPUIVPYshltTlSoXn6CEbn0q+N80uHt/VyNTmPX6j9LB95?=
 =?us-ascii?Q?ZjCf4CoGUdq0OfD8g6ChBr5TLlW1zMoTk3y2OFDutNJ4BWC8SD9MPPsVoonH?=
 =?us-ascii?Q?tQM8K7GyMec+OFZNz+IP5V+d2VPDZQjX+j74w1CIja1N+reyHBQI48q5cgAr?=
 =?us-ascii?Q?q4AK6P4pDDarBMDArBO+VW+NB1+SvMYdOf6Dsm+momQ3H8H8I0tGM6/Bo28i?=
 =?us-ascii?Q?x5UMff/9/7+WUfaoX3pA+YbYveKRfwmomx1G6OFAVX6jNsQqj82JXwuRM6L7?=
 =?us-ascii?Q?CwURUkZFbCK16LwEInK2swSNs14P+Qaqhm58QfK7mytZWQ2mOGfXnp8RAL0F?=
 =?us-ascii?Q?Z+x1G4CvdSLrzjhg98oHKkB1KnfrXmV7rPxEXO+aigXTkwUGbG0AxVZ5+ol0?=
 =?us-ascii?Q?0CLARVcMsOOcv0gSPDZSbSX5aVVHWM/zMNse64S3BjNmXV1Gduh9W48C44Vj?=
 =?us-ascii?Q?Hb3XLbhGCVtKGt6TnmRb/Ixn7saLCYFrG9r96En6diPi3kVKo5VNLTZf3r3X?=
 =?us-ascii?Q?uxCMB2DsE6J0XKUIZd68Olwe2ZOw/VzOm3FoPDe7wRIlRR4dwxYBGAgBmGSg?=
 =?us-ascii?Q?ogmNhgxYb3exMyJJrMX73avecAv3P3A9qivwNqFOI+wvQEQFjpHy0pn1e2Zh?=
 =?us-ascii?Q?XITbfKzhIMTxMIR0TwauGPOBo9NTrW9irMbXP6C4tJlJ0dhMMmG5MhDjyqCr?=
 =?us-ascii?Q?08pe+3uddx1MDkrE7usnOkx8auBQU8K/pvhrrBxAXL1HQsEJ+THKiJHOGeOy?=
 =?us-ascii?Q?mWqbwlps8jw4Ov0/gveWF7JnFomq/eZJZGRwCpbkPg30WctZimERFb+EUJ+p?=
 =?us-ascii?Q?owh5WNuSpeUgKu9AdVdKzruJQYwFZn75GDPDe9mlbYhO6uUksvjdpgE3eQPV?=
 =?us-ascii?Q?CjdyI7nLTh1shWFvH3D/snYm/jLpjDucYhFPr9rfy7znkDSlQt5J3IF7CiqG?=
 =?us-ascii?Q?hIZDLtq6w3vc/kAI8cELabiUCI17Zfq7Za6Ifs0MpHwIJwf0SLE8pd46q0+S?=
 =?us-ascii?Q?0tQDJ4s+Lj4ndc99fsTOxvh0UGqz59uMkQH4rPurPcXFyVa6zhBjUSlZmGvM?=
 =?us-ascii?Q?by0iB4cjvDs/yolNhu2L1EMh0I25NF1lqnJc1feNRAr6eVoWivI+VYaoBDf0?=
 =?us-ascii?Q?1A3pEJ6f/fmL0lckFGuFyIOKvWu+tcyccQ0Cmv57gvMNfOE1GQ9ua91pF5yI?=
 =?us-ascii?Q?z48e7yx4A/zcvKcjkbDA+ISaULe02FbGE5C6GDKQIPn+KcP5m3ACEB2VvHRT?=
 =?us-ascii?Q?9Kl6JBeLW688Dpd8KF0t98BcPJ5DEg3cTWhIHaaymhEtbnxq7uPx0oVKu3xy?=
 =?us-ascii?Q?bE71yitT4spIdkLgncCy5OvrQkXw2hxdtJRC71daRIr1RSJdV/yUF0eNQzQw?=
 =?us-ascii?Q?H6TX0EIfZ+v0EMnpuKmIEvlyxeTkut5+B5J/DnjHGpqNgefsXQQOGE7M/g45?=
 =?us-ascii?Q?3KA2nbhpEW/6f8IfJTvqhGCA9UG+FO+pYOZVzjWRhpk3GYv0mM7pZePYbyTx?=
 =?us-ascii?Q?vYh0o2LLSVAR24B8o20=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:06.9357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b7d0be-da9d-4bcb-4f4b-08de1cfadac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

This commit enlarges the hashtable size of
kfd_process to 256, because of the multiple
contexts feature allowing each application
create multiple kfd_processes

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..d943ecf62a3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1020,7 +1020,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.51.0

