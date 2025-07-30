Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC9BC87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 09:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453E810E051;
	Wed, 30 Jul 2025 09:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="27uIF1je";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D836410E051
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 09:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrAVsZZHFJdDMoB6TvTQLLSv1Q7zgR4o7fcSzU1aInru2fCWLEdgNDZjhUk2fiSSlHQUZDSXjfNNbENjOeeiFT5f8zJf1bpI/9XRmbv2r630yAqWU5S4cizD17tZg6shlpsBziAhbLW/o02kWOfj91iLMgkUMD0uJruBuct7B71ZYgkUBwe9Z0JWeBL7nVB2iGaVVBNpwT8iGG2lZwS3clepnJrPECDyrieVfxpEPb6Jreav7Pe01fXL7O0MEGBZ/3IamWg4BYUUsvN2DD/L33PekBPv9NQWrlSZz3WcAOrLjsU+ZSAZQhnLTLH+KIyoGgPebq9jjR8+IpLEEJL4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5vASOIC8UWypzslFMTB6zWlkobVE6osh9uPF3py2EY=;
 b=BGQOsxTfwBuLjBLxPtTao4HFCJ4hnYKGJLEB0JK48YBc6CJAQNlx4DE/DLf77kFCAOnFRSh21U/KtOOO9DstI++qkQNVXfKsi5pCOCGuKvdYuHpn1ZeEkUC0cgfFk/xMBXlpt3nt+AmN5mnBF2znq9GF0nzD+Qu/x6gyuy0oqKPrKwe/kgEbbYuNT20zj1egAL3gdcoL59lwu8WhjW0GLt6y13QYe6oFxNCLAYm+0V58rSub3fkxJPUMp0QowXPfZfUArkWZWPigi+SGrucNTPAxpUOhD2TyGiBgDxZT9o/aoEgFkPoQsIJX6tt6le5RocAgTaEWK0k4KCJ9Wh8sQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5vASOIC8UWypzslFMTB6zWlkobVE6osh9uPF3py2EY=;
 b=27uIF1jeKYxZFdR45NX7xJv1LjWpwn0LxdYiLXQXKUQ3HFU5ioxMBvgWrw6YIkaVn2f3BhLoSkyQTZyGQ6gM71UdoU3yg6xC8XOd2aicj/uhXp5VqusiA7n3XgG1uwKvPLL+2/TFqzt7ZhuaH/BY1S3sMasuSc/TFwg6Oxsyny8=
Received: from BY5PR20CA0003.namprd20.prod.outlook.com (2603:10b6:a03:1f4::16)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:25:27 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::54) by BY5PR20CA0003.outlook.office365.com
 (2603:10b6:a03:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 09:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 09:25:26 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 04:25:24 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
Date: Wed, 30 Jul 2025 17:24:54 +0800
Message-ID: <20250730092454.58644-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: cff7b60e-f698-4925-b2a3-08ddcf4b04d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMLaBuM62D9pbQSIBdyoKjZ81ScT5d/BEhvMxy3U63B/Flst3reCOPJ+2reO?=
 =?us-ascii?Q?eAMA5XvbUFzVxjhTmYV2Xa+mfpw/FiBowVZ5YUOjAHrmmVP8UQiHgSnBjd5M?=
 =?us-ascii?Q?ZrnbomHnpb4y+MA5NrjxWKGQaduG1KG1kyE4HCawX1ute5mlKcxytt+Fo5dG?=
 =?us-ascii?Q?SOjjDy/vp0uLeG4tnwKOG7jIh5ld3+f/Yf+8RmTPbP7wIbERKuOJxJTFGKfx?=
 =?us-ascii?Q?xyd1Wci4ZnDqpR+ACV+MlOFD97KNWX/3OrLpU4fU5/AC0KGhsIGcoCF608aQ?=
 =?us-ascii?Q?CDx1l0xhEVjaD21Y1jqVDmkIzBSVH5RItGfBwUelNb0BPtaHRwyTq5YWwHok?=
 =?us-ascii?Q?JX2oZ3+Ub1mvLY6Yk/qx1Awqt2nwqwkIT4I5KS4whXxjafFuyvs5BC24T3WB?=
 =?us-ascii?Q?asZwiu53hyqidPmtWsw9eyV58FnFYELd4GbNt2E+6GyWmMPWV/P/FT19yh8K?=
 =?us-ascii?Q?+qtweMFLlNo1c2kEo2Kgslb9kDBhod3IhxG0ChW4nxHWHp3xd68ZE4UoKRxp?=
 =?us-ascii?Q?YJ6mrYpL2zf+g7A97DU+Ov6KgFNbk+KUNCTTMtk0pRD5PNcaUYBHdkwykor5?=
 =?us-ascii?Q?NxJxDSyh201WSneMuL+kEYOaXppaBZiN5qb0FC+f3QwKwSPsDzAH2vg88OPV?=
 =?us-ascii?Q?pleiHs5+mHtDyH9qTSWYugqzMLUH3gr3DJHuMjG7PSE1p/3nXRdCeQygpIeV?=
 =?us-ascii?Q?bR6wE+AVa2t04qi8sTNJCnO20/PnOpanEaNkmQAFqj6hM9Nb1OQDs9mTtOqT?=
 =?us-ascii?Q?OC7OxvUZR7DI6xHhDreYamS1Pjslrgz0NyqkfpzOK78+DdQFXbFfCOTt1PGl?=
 =?us-ascii?Q?LBZslwD3KQxyBKQz8qc1VZXKAnM/hurfn/YlaQethXrQaY0mE15kvbqts2ZJ?=
 =?us-ascii?Q?bPc0Lmgi7qGANfm+3NoWSgdRttQAj02R50MjA1qSiZLn9DZl90rFsmj0Txc3?=
 =?us-ascii?Q?wryZ8vmi+JlTb+DJaTyEovktMarltq42ioUve6F8bObkWdVIW1K5TxipTiYk?=
 =?us-ascii?Q?qtTG8GprkQDVm65EB5HLPqPfqwUggZzejeTUo2tDI8xFpp6ERtPGJRroSHeD?=
 =?us-ascii?Q?vID7yDQg/i3+UW5GwZ5tJF198Tp9W0hKtlzFnCzMuqUz8LZozILY3wIbCPeo?=
 =?us-ascii?Q?LnjZSbqClI9PEl3TDLxf3aFf96bktjA40rQeMagbUyVXVfp0RjhHEEZZD3D2?=
 =?us-ascii?Q?uvH0i3R6DDHo2BdtJpvB/jmRMCpvBIcHyKgV+1Ga6ZrVDY6fYShTwR93K6tu?=
 =?us-ascii?Q?pfgpo66AYddTUMY/jjDX0q6S57yqCF1B3m44aoGoFfLNNETcqS/6ygZIcBGZ?=
 =?us-ascii?Q?16iJgnI1PPHSYrLLbhihPyficioubd/x+9fEr9tqapZ9yPS7wbAgmhcNLU+5?=
 =?us-ascii?Q?/WIekqvBgNW83KHBA3eiHJQW5au3eTizRj8M1MbplEfVHfCgQ7txDSGIs6HQ?=
 =?us-ascii?Q?/vKhdWa6uVPyJDBAq+TUbr3HZsYX/oxvhvVKmVEyIH41vTXmDSyn2ana8WaR?=
 =?us-ascii?Q?w/x1ZxTXmwpxOsGCZ1hOHKy/WeNt7p8bi2rX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:25:26.5871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff7b60e-f698-4925-b2a3-08ddcf4b04d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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

Avoid GFX poison consumption errors logged when fatal error occurs.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 47 ++++++++++++++-----------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 3835f2592914..59dbb9257096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -125,6 +125,27 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 		RAS_EVENT_LOG(adev, event_id, HW_ERR "hardware error logged by the scrubber\n");
 }
 
+static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type type)
+{
+
+	struct aca_hwip *hwip;
+	int hwid, mcatype;
+	u64 ipid;
+
+	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
+		return false;
+
+	hwip = &aca_hwid_mcatypes[type];
+	if (!hwip->hwid)
+		return false;
+
+	ipid = bank->regs[ACA_REG_IDX_IPID];
+	hwid = ACA_REG__IPID__HARDWAREID(ipid);
+	mcatype = ACA_REG__IPID__MCATYPE(ipid);
+
+	return hwip->hwid == hwid && hwip->mcatype == mcatype;
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
 				       int start, int count,
 				       struct aca_banks *banks, struct ras_query_context *qctx)
@@ -163,6 +184,11 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 
 		bank.smu_err_type = type;
 
+		if (type == ACA_SMU_TYPE_UE &&
+		    ACA_REG__STATUS__POISON(bank.regs[ACA_REG_IDX_STATUS]) &&
+		    !aca_bank_hwip_is_matched(&bank, ACA_HWIP_TYPE_UMC))
+			continue;
+
 		aca_smu_bank_dump(adev, i, count, &bank, qctx);
 
 		ret = aca_banks_add_bank(banks, &bank);
@@ -173,27 +199,6 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 	return 0;
 }
 
-static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type type)
-{
-
-	struct aca_hwip *hwip;
-	int hwid, mcatype;
-	u64 ipid;
-
-	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
-		return false;
-
-	hwip = &aca_hwid_mcatypes[type];
-	if (!hwip->hwid)
-		return false;
-
-	ipid = bank->regs[ACA_REG_IDX_IPID];
-	hwid = ACA_REG__IPID__HARDWAREID(ipid);
-	mcatype = ACA_REG__IPID__MCATYPE(ipid);
-
-	return hwip->hwid == hwid && hwip->mcatype == mcatype;
-}
-
 static bool aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type)
 {
 	const struct aca_bank_ops *bank_ops = handle->bank_ops;
-- 
2.34.1

