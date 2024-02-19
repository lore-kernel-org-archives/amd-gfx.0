Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74E1C5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 08:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B55610E193;
	Mon, 19 Feb 2024 08:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M6TYOSAR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8804510E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 08:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFQSikJnPo6aGlW5yPDy84UggMqCMKReAa6678f4Gi5hK0eHBstmZ2h367yMq6KGuER5muvIIfdNn5gyWWVeQRQJcVKlVN0qL3RNUjTJ9HiZ6SahUix/5UYq+aEVCvcsepfcOdDN33JiP/k+PdBfZL7sosOvWHpaGqzfJwYGKSx5CYCokFTW/ifgLL1lwUtXkvAsN6si+z94qKwYDAGrgMHLf5G0q1+ZqRD8FyfjEfGO/5jRKtDnMUqLeCqz0m5i2IE4QHf3XjyZIRxRniG4bJeVRtljW067uh+P8lQiWQbFLwYkjBtap99UJ7AGGjNlxFDmpGJTnSJM5QbNnP1riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUkJSAiKVl64ouwZO4z5lsoCrrSksxCLst43NhdGd78=;
 b=Jd7/SPPBBJ4nywQ7VcklwYOChBigAMlBw0YorT0VjEEpoFafowbz7Wguyjka+OyjpvPxuSalDpG0WT9hyYLJgz4KOPVrFlD98ZjlQtXnj0BDz/RHFsXssWUV6xEbl5D5y7S3wpUCeheSBk3T83IaNaXOeakcwasHUAvdRdCjtzl+4JElpRiUL6QHNyoXLuMK2yBx4mB5gZ3TLgo6VbMfE0/IpYXf5LGtN3Ihs85S7p/qnVF0/4lXhRJZphegy35+3E+xkOMOyCsjXAMVSrhhghDHVAbhwMHIRGzKole62tWfQRW4+9tISkuk3xiYe5m7oeMVXQF8gzOLjqc5nwWQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUkJSAiKVl64ouwZO4z5lsoCrrSksxCLst43NhdGd78=;
 b=M6TYOSARqpQTYdJPBQO/nrFdMHN14oyuOh2u1b8/8Pt6lTlmdNtegYQ3wGVfIcjCusA9drp6UpDx7fQ20t63vKq37CNmrLNit33RUdHSkZ+dSGuS2r1LfuRugbZYNx0huB62lcGZ2rZOUkUhpRCkRkIcmLctjyFPeIu/vvFOSUU=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 08:15:39 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::89) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 08:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 08:15:38 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 02:15:35 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: skip GFX FED error in page fault handling
Date: Mon, 19 Feb 2024 16:15:20 +0800
Message-ID: <20240219081520.316064-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219081520.316064-1-tao.zhou1@amd.com>
References: <20240219081520.316064-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8b6232-8fea-4fb0-a3c5-08dc3122f4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMcu1UV/Kof3yaXg1LBN9bX/driQIkhFUpdq8aR6Kh1C4sax6KyAXKs7abv4UskwXtfknWBaod+nKZbAVe2ZG5l2RFYB9xoXiGUBEFlW0Y+AGMML2tBxSWhQwXMLiOfc/FAEpcQ5DvrK9k0gyBQnypq7Nu7iohARAmLdDbEE8nK4FAWC+BreR1iKqxhCxYaIM7KDVZsdcwbmTrgEOwmTP1bxkxzKuzQrEKByWum8YnGR/LXoPhAEtOEsqXff6TGtJOtl1EGhgH0OJZGs6oKmL+cOJTnZ+1MKnZCaTiXRw8ou6mAls1JyeN4UA3AP1+xmqY0hW2jNXZVf0E+GqVSlBa1ZrGxyiPoNqByJ8d7BHCvb7xbNbsE18KNiR8jQ0Okuh8cNNdhAAaUxiCcMcGiOYcesE9qBZ4/TJd5F6BiiL4u4G5FpfRQYXjAWxrQPZHAS0xWmDovkDgKXaRn6MQv9ZFhRn23BqXyai6am23sk3OHiop1OyyPtV/HTebHNIKKumzdY12WmiP4BBRNVxPTlU0cNc+vn/BlL59fxGA6eYoZWmlCBxxyROWTSCZllvXLvL7h9YX4tLpzo6aVYh06gcQm3afrP+mkOfrWd/nkA2YfwtOHgvcAepaa5NpJ1QtXF0gHmsBPSkVxQ/mjqw/6UljeVbUBQvVfy/NZtWWwVeBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(36860700004)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(70206006)(70586007)(8936002)(8676002)(2906002)(6916009)(4326008)(5660300002)(316002)(6666004)(7696005)(478600001)(41300700001)(83380400001)(36756003)(82740400003)(356005)(81166007)(16526019)(1076003)(2616005)(26005)(86362001)(426003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:15:38.5620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8b6232-8fea-4fb0-a3c5-08dc3122f4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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

Let kfd interrupt handler process it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 773725a92cf1..70defc394b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -552,7 +552,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 {
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	uint32_t status = 0, cid = 0, rw = 0;
+	uint32_t status = 0, cid = 0, rw = 0, fed = 0;
 	struct amdgpu_task_info task_info;
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
@@ -663,6 +663,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	status = RREG32(hub->vm_l2_pro_fault_status);
 	cid = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, CID);
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
+	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+
+	/* for gfx fed error, kfd will handle it, return directly */
+	if (fed && amdgpu_ras_is_poison_mode_supported(adev) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
+	    !strcmp(hub_name, "gfxhub0"))
+		return 1;
+
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 #ifdef HAVE_STRUCT_XARRAY
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
-- 
2.34.1

