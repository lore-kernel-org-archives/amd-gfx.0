Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD9EEA3F33
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283BB10E52C;
	Tue, 10 Feb 2026 09:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6XgOyx3";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E44A10E52C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT+ua4fvmyVzD+JstechDdGR7Bjs1UQrfR2gRplNEBR4kFr5KnLsewNRN/WvPyp8GSzqXq9vuWii2k1p0KpJbKSvl7WVzK9Ldx9a8R3Pc4rHefrDeXC8kK3q7czrWumaKnSXhzUWTyW6Tk6zhl7PWR7cyWcPjs7lONsgZrxu/fg6XWhm0mhSyOei4ZokIPHhdNgCr425JnwAbM+/DiGesmuyEjwggxblDn/GR2PlAyOklS0thPaXKaayl4CO2ntZYmTWwkEufogRbMiWoypoIaMO60IIuyhWa+e0Nkc81u+SDMGwQYZmDi9lY7cZqi804TVL5MjKw/cT2sRY8on+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdjHOZNSniJ3cLg/IRHEo+xnIdoSp26HUJn/ygz0Sxc=;
 b=t9exJAk9Nmuhf10OSJYgupnEXmkE0HBPOQS0n45x27DRt/5oJSvcfyqlXORVAVBObfw/8T3Km5JUlJY2B0cvfC5yI6s128PVmuEDu5jhQ/oVd62meUfnU+6Rs8xtBddEyAtLHnbxCZM8wsIKcewSyYNlijZc5GbaDaakxV5MmiaWO+j2KH+x7wmxXAlAAekdxCdd3VwKZVk1p5HZ4j8g7LmmK9Br+046PcSRHiJBnYXIUg29wxY4qFd/shriV7V8jsySC6IyVFmJ9huoWvia75W12AZd+VqCEgd4dGoPIDuwFdCGBa9BzKt2qQrRs8T7akFvTtuKiAG90YZ8H8j/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjHOZNSniJ3cLg/IRHEo+xnIdoSp26HUJn/ygz0Sxc=;
 b=m6XgOyx3lQRqixhyRGBcZmSRN6pY6tsfgDVB22M6ywDBi1ieOCksca1M96GxN/JFoH69V4LeP1BJblcuiLw4e/tAn0+TOrqPg0Yi8uNOpvI/XX1Eh5UB30kObTMt2PH2633l1MArMZOzz0b2so+4wfaKffaSl/Lik5nz35CFd9g=
Received: from BN9PR03CA0385.namprd03.prod.outlook.com (2603:10b6:408:f7::30)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:52:57 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::9b) by BN9PR03CA0385.outlook.office365.com
 (2603:10b6:408:f7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 09:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:52:56 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 03:52:54 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <tao.zhou1@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 3/5] drm/amd/ras: Handle address check in SR-IOV guest
Date: Tue, 10 Feb 2026 17:52:31 +0800
Message-ID: <20260210095233.3078476-3-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210095233.3078476-1-jinzhou.su@amd.com>
References: <20260210095233.3078476-1-jinzhou.su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd918d5-536d-4e5d-4641-08de688a2ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p2TC5fBYfkxWLZGEGOR2UrVJ7PaQlwSlgyW50J8tzEnXjtVEbICaG4YuNG90?=
 =?us-ascii?Q?URw4Wp36x6ijU2oZnF64P628yrfjrPTG9P5gRkVgLm0cNKYEer/E/8kr9QdB?=
 =?us-ascii?Q?S6a6WkgAPUR4VpAhUTa3utJ0D1DIMXUJ9si6ULcQE7L3uvMIxqpd82pLRHiU?=
 =?us-ascii?Q?F43ZHgyURueI4Efjmxk/aNetyDV4eZzXYnAhgPFaxU85SiLNx6E7HC55c95i?=
 =?us-ascii?Q?jhpNDJTg0sKnZ9lz4M9JUR2hFV5KXfN8lBD7uH/+f4J/mmcELgrjdzVlgvpb?=
 =?us-ascii?Q?vBeAcMKDdhvTybbdUIU10hqNrKn2xMoJcboHYp0phBJKiNCQaSQ7VSza5Oon?=
 =?us-ascii?Q?0pesQptwsSHTa1pFPj5d/StYbbIYC8PcblSDrGR09f8cKEw1vqL/Vesy6Ed7?=
 =?us-ascii?Q?pPlzoD6WZBS1IVXEIH5YlzTfEEMDfIETprNuCxgBx51JR300+gcMO25cWeg7?=
 =?us-ascii?Q?++wycpevy+5qPJ1+D9cPvpNKHBZZfuQfE7eQIBe9RBkn1BXHNjJASu1ro3K1?=
 =?us-ascii?Q?Xy2GVOfrQfYg1eT5WO1TkMbvoD0h8QIKwAYvRPKJCMqsJdubx//KGGPei5vT?=
 =?us-ascii?Q?Y89pTusPZv4Bl8meDxEz1krf5b7P+ZizUNlVlPYaZyVLZVSPfAeSVrhtG/Xp?=
 =?us-ascii?Q?eDBGRoqp1Wvp75vapu94kyrjJjPmXRk6FIHBTu3NvHjcpgQlxABR8kUm/DaV?=
 =?us-ascii?Q?w9WIcVRD3GkycwzuZUcpHwttBoXNICrr+s+gYnV0bQiEmg62Z2CZkkV30DvM?=
 =?us-ascii?Q?lXItcu3zJ2mNTDwsd5OhQTQkGTEt54cVndbNQjDpF1PDwCxF37TFI/cZDCQM?=
 =?us-ascii?Q?ueFDhIoZ4I7PQ5/wokjD+NnOhRRwXTiM5XwZmP8x4JLSsAXGDMzBUqa25TcS?=
 =?us-ascii?Q?lAiPEygvgJRj7yKeBTo47ol0OW3YKhwmlDUiN6bWWE+mtxqbd2IzF6gdURjg?=
 =?us-ascii?Q?rb9Lnt8djvZQjJISeRDOo5ipL+nQZHqNK25TeexlbCpyf6UOHm6dcWvalRN4?=
 =?us-ascii?Q?Y2nkxtnnZTuCiJDxPCcTCjn99YKZtLxq++RWHe1zgWgaOLmAGaa/SI3rKF1z?=
 =?us-ascii?Q?CqJANIdk222+53oPiEEpRuGyuvFkKuYKrHCSxXGGBDB86LRovWeFz93j3GOT?=
 =?us-ascii?Q?3uCXEzUnbBIGuqc56EGN4tGs7lh80yOwZO2jzCaDLd1xyRY5fU4/s0gvJVL6?=
 =?us-ascii?Q?FN8vAyW5e7ySEtLCjqClLjb5aPqb7DrefDjX2DNoihaopLNcpv5FnIbNZS/s?=
 =?us-ascii?Q?wMEgnGUn2AqPHwF/BOMRpl39+SGg4TeXYELYdDZsb1dKYQVC0GjpnyaQ0NYT?=
 =?us-ascii?Q?wJ4Dd2jToCL6AvLZYZ/4vEX1bqN9thwv8AlUU3r76W8NpD2WzLU7/K9FWxFe?=
 =?us-ascii?Q?BzFpQeSRI/ZsvsGLsJxAbuSxvkFP9ZUN52I4dypg7+SRuxma+ORjo/Jrt7D7?=
 =?us-ascii?Q?c4agW+6Bge7XNX0FFxK8mAYrDqBpzx0G2qf07a6GMRHBQWL24omEE9QuB2Ot?=
 =?us-ascii?Q?yzjY+5WkhBRL1QIPi9y80uVjacD64cyx8ecM6cjL7OaTB1iFKsiLu8R7ZlSE?=
 =?us-ascii?Q?togQo0xvuWsamNw7EL5atPy8uhVMssOY7kuzUW71qUbZYmEg0LUUFwv+6iuS?=
 =?us-ascii?Q?l6UJ1gPBopkL829dL45l6yLVLXdYLSD2BRqbkaKgjLwYWa/t+pbADIx93JTp?=
 =?us-ascii?Q?Vb0dig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yHHI2JyLMFRYueJnZMauQ7kCq+c/3TNbFSvQZ3eG0lDQktqRsIk2WTc9WszWGs8Sr+eXRotQehJxGtGdg2tWlX3a54Swbaj9j1/mMpfenqir76xLu4nAkdyJyTJLvF1usodR+zzD76Yf1HmDsTPdgGqrRVSjyzVhO/QvxFLYGw6jDbdlkUDczYAwrMLSstErp/yrOMq9eBQF7XvdHQDdC+sIKvtF1HKuiBp9NafJhwT2LIpSRkCOF5vydF2Z7AOuKCmMJlWAwyNCPnvPQGZ2JEIgMIDAZXi1Mf178ETG0tRQcto2qruO8kgkQOh0O50K8jbfzQyUj96GgWPkSBNSiRkL/1sDtISuznI/ElYmxTOswukmLW2bWjk1oZuPYbWnUGDhSVmieznSZR34PQa/dn/1eCUIfE9C7y5oFrPloWnQuaA+S2r6e5bhGKGUcWOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:52:56.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd918d5-536d-4e5d-4641-08de688a2ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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

Handle address check validity command in SR-IOV guest

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 20 +++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index a75479593864..3e0ce9b004e7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -324,6 +324,26 @@ static int amdgpu_virt_ras_get_block_ecc(struct ras_core_context *ras_core,
 	return RAS_CMD__SUCCESS;
 }
 
+int amdgpu_virt_ras_check_address_validity(struct amdgpu_device *adev,
+			uint64_t address, bool *hit)
+{
+	struct ras_cmd_address_check_req req = {0};
+	struct ras_cmd_address_check_rsp rsp = {0};
+	int ret = 0;
+
+	req.address = address;
+
+	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__CHECK_ADDRESS_VALIDITY,
+		&req, sizeof(req), &rsp, sizeof(rsp));
+
+	if (ret)
+		return RAS_CMD__ERROR_GENERIC;
+
+	*hit = rsp.result? true : false;
+
+	return RAS_CMD__SUCCESS;
+}
+
 static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
 	{RAS_CMD__GET_CPER_SNAPSHOT, amdgpu_virt_ras_get_cper_snapshot},
 	{RAS_CMD__GET_CPER_RECORD, amdgpu_virt_ras_get_cper_records},
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index 53b0f3f60103..f4a4dfa4bdf2 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -54,4 +54,6 @@ int amdgpu_virt_ras_pre_reset(struct amdgpu_device *adev);
 int amdgpu_virt_ras_post_reset(struct amdgpu_device *adev);
 void amdgpu_virt_ras_set_remote_uniras(struct amdgpu_device *adev, bool en);
 bool amdgpu_virt_ras_remote_uniras_enabled(struct amdgpu_device *adev);
+int amdgpu_virt_ras_check_address_validity(struct amdgpu_device *adev,
+			uint64_t address, bool *hit);
 #endif
-- 
2.43.0

