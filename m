Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71284E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 06:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D805210E21E;
	Thu,  2 Jan 2025 06:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0eXkFIEn";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9AD10E21E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 06:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6qS/mXWCyZj/mAcw1zMiL2kD1l8LGex6UuwU32BNUl7JkJPv7ZsbkRDd/zmTseuYrHP2fsY5632f2aDRN5ZKAt66ei9DFWxofpMT/Dwhm0Ludm+vKko4kFx5Pq1JNcIeAmcJ2cTogoWtAnBxytYYYs8ZLZ50t2XUBwRC/V7BJptcvmnqngUrf39mwwYHW0vpolMg2nj5j9rNsbhaCbQdC8ajU7cJLJxtvXkwv1AJuK92bn8usy4IWIMl1scUKsV3+21z0kVRSFQLCZj1zXOHw+D5Pw04Ay5B+3vo/bIhd+wcCZPY1AArZqZjBBY6Jtp+/2/0NKDTE39HigwGclcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YS826vh/0Nv2slF9cfr8AXGq2VfO67bWuOvN7AYY6c=;
 b=wP+EHXlH3ugjf017M6+HIkXjedhkfykFu2nnys3tOQgc0bMbpZ2JWFFFNfEAPsyNHQkbhqJE0HjcOek1TsBMGd9BVXAkR5Dw1XibTnUueEmdhX6FwuZmsCl3KCNFWT8sOS2+rWX/TmS5XWuK9J2XtBAedxJ1TDnfsmymwZBfao1K2OtjsIPB8msj18TdBG/3oXHFZROyk8Ve137sAkyqS70xl3kOAk2FKI8qz1pl1cRCL547SBHH2koNqQ4L4ACKOgfuOzLIsvzTb/NqeYyQmSLYpov8Z2OAEeKQyzJv8swDdsxETPV+SQJ+GugqvMChLWhUk6xoGdRD3Z8KkfDXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YS826vh/0Nv2slF9cfr8AXGq2VfO67bWuOvN7AYY6c=;
 b=0eXkFIEn0ZTuAl4/WV7X9hZeFLNXszZxOduPFPL3FUoAkNBEDqPFd4F/2VDEzVDEFoWgwu/ie2kEnAcg54wbw/G2T10TcZHVmRXeSKDOPkqIaoErGG/4XygZSum9vXyPrhtOP0j/1hKOUPa+itJxyQeDO9fGtUP0eH2HnvIo0do=
Received: from BYAPR11CA0071.namprd11.prod.outlook.com (2603:10b6:a03:80::48)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 06:31:11 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::1f) by BYAPR11CA0071.outlook.office365.com
 (2603:10b6:a03:80::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 06:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 06:31:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 00:31:08 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Harish.Kasiviswanathan@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdkfd: test release process eviction fence before signal
Date: Thu, 2 Jan 2025 14:30:59 +0800
Message-ID: <20250102063059.2221560-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: cd239d89-a3a6-4014-1584-08dd2af70cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GLpeKJ0++tiLuGzaG5HpSCZYgI0y0+g9gDpDZzX4L7kHLfesC29ul2vpfk7K?=
 =?us-ascii?Q?D0Be9anAeH+Y7gLVhrw41utxDdQwFSvRVUri4q9wLaa39oRc1FVWPRou2Iwo?=
 =?us-ascii?Q?K5VFDrpmbA/af6wj08LjXZxN/NGxX0iwiM/cEslFpi4481k7qcto/Vybc6hl?=
 =?us-ascii?Q?NPSQBeu0nIBti873xF4oyjDKxzgXyVFgqDnK/fGkfu4dnd0/tJbtgA/8Q7EU?=
 =?us-ascii?Q?PB8DW3Q++JU5STY3yq+oebyN8g1Ku+YK66Um1Y5sxblmKb1bVSYmPZhAIh7b?=
 =?us-ascii?Q?RBDKG2iacqsKF06PuAQLqsl19ac+OlRu8fWOy9628AmMvoqc1ZL0CNOydLTr?=
 =?us-ascii?Q?wMZOz6iTBE5/sxnL6G6a5SxDXvfhyJGPlNpJENO4b6xlPYn+nGevQ6EZQ40K?=
 =?us-ascii?Q?ksevuPwUdedDGzoTRBjiRoqBxrXDrJAj59FInMdXaRUqYZCBCSCQU2ple39B?=
 =?us-ascii?Q?TPLKknZqiLc3fPMFqOTyP8HYI0NquI4OdcdO4cRfMMq9lUbK1dfaof3V1K8q?=
 =?us-ascii?Q?JYEtadsONkvo/ww1Wkp1az72i/O+03xDrFfynFcFRDOUiEy83fIyCWKHSPby?=
 =?us-ascii?Q?PoE9aUDO1D6jdx7KdIL9Rrm9Vy/ZZqTyHQ2MWR5Mv17sjuZBwZqoviCAuOMI?=
 =?us-ascii?Q?hte5X0CgOovCSdSwOW4Sps77i8yphR+vHMoRi3gOMnA7sz8X07yfbSCkZ7q9?=
 =?us-ascii?Q?JESfyEjIMxvB1aE5TD6OCSo7c/DBVQ6D5E1DSGbfHtVUmUdW6fgYhQun19/s?=
 =?us-ascii?Q?nxFaM4dc6f2XHr1EH3L1+RLzj8Wat4n1p35TDhucVjdeZW2UwrzTOoiV5kUs?=
 =?us-ascii?Q?ww6K5MIw+SJHxoHS4TEbYk8929Iabw5F0ru9DleHC8/dky1DSVFvuy/6A4P5?=
 =?us-ascii?Q?j6V/xASbEMbsBQsA+mb5v1Hub+4ruGrg0EM47gSBTAlUExQDwnyf6uXFmEff?=
 =?us-ascii?Q?0XrEN7nCUe69ySNXx86BTHRsHUH0GVerXYtQG99Rlgu8i10viDbAhmQnW1MD?=
 =?us-ascii?Q?OCFTH9X49QPxQztLz0azu+9R0G0/QNEQWn4kMWc6Y+u+QSfGva3VqkD/1nK6?=
 =?us-ascii?Q?DETWR/qKCmFOpF66V1a7IuqmGkVFqUkPr32qMhs2Vnvp7WvFr/yHNfXpVCzp?=
 =?us-ascii?Q?q1GyrabaVI2Tve24qu+oknTVwfCqmV0I3kF3/PCkJVE3eMDSm1WyOC4H9fZ7?=
 =?us-ascii?Q?xG4xgJvVU5QkCL+SzRX9/m0cNjVr/5rPsXJGqR8dUvWBZwGmrzMEHc0xQFYQ?=
 =?us-ascii?Q?VOEGAl5/coNgZgZb1PbGzGtvDeKP0sR4tgBqf5ATtB0Z4CzGrvEJ2xjEc+io?=
 =?us-ascii?Q?RDJSdVEfGMzVPFUoj/607PIU5zgFk9BnKdmIz5NaQI9zZycrV0yj73hkieTv?=
 =?us-ascii?Q?fYX78BxeKXkvxwcPqGynPyjydXKjMwy0glDkmZNEJOyi/B+mZu9paK5Uo2xZ?=
 =?us-ascii?Q?srQuNH1an8UKpAJFCf63XsXATo/xY8LLj8GD8xmcGX9ij9GpmhUXHVxwMfHI?=
 =?us-ascii?Q?vI4cc7IzzvfDWzk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 06:31:11.3504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd239d89-a3a6-4014-1584-08dd2af70cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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

It requires to validate the release process eviction fence before
signal the fence.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0976b5b0e8e8..083f83c94531 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1160,7 +1160,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 */
 	synchronize_rcu();
 	ef = rcu_access_pointer(p->ef);
-	dma_fence_signal(ef);
+	if (ef)
+		dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 
-- 
2.34.1

