Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A5FD591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B28A10E5D2;
	Tue, 19 Nov 2024 06:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BR0wzILW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CA610E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD8cy1VA7Gapa0HsdKFaqIfOaYNSPc4T5emPIiQSdLqXA4Mil44dexp+ZNtS9Ne0chrENOlLgVbWk+d+Fa6cE3P0+bt/e0SbconjkiNyyzfRnM+Hra2unRiIqYt+bXjyxSrtX+QCVQBCtFRwuU9wo15zMBo4q6USe2ZE0ycerRTFlWqiYzSuyow60A7NjokQYk5BNEGgTxVxXf8Q1UEJNiq71IVT8uYHJWxS40oDrBg4gdtCNR3E1Q7j3l4Bl336uimLxXLbtH46lKBWU8hVpJUazvwiusRdecY3NesLhjay+nYTZGhQmPcWtc+6cD1V1qV4QVxdPOXsOgrvszr+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM2DPb6cvBYBCh5hOPAjaLtc/v9SfkvNJBqv+0W097A=;
 b=asTQ/w0Mz/Sh37hUFAaHWVM6MXCrrGhD5drbNup1HIzUm0iRWSXXdlIOsl0jELp7ZPiM/6j2DSyssSxjMk1N707Ew29tq2k2AP4SEYtrbL4cjO0L83ID9+MQTfzHgDUSt4sjSin88WgXppYrAsX/F30Kq33vQAJiT2eCH8yFsS5cPwFOr+IOTCMIN7K2B3IQO26Wi8LWuatW31yVPyCmyPVsauthV+YEbjQZZimfHUQ9uVMXxu4QZExCvcKXrC0bI6P5hdXgd2lloKI38uqxDlk0ydbCqVWNzRQjPWjRVb3wd1DGsmXSODFcbHGyAT+xgh6MhDrJRQ06n5HjwD7S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM2DPb6cvBYBCh5hOPAjaLtc/v9SfkvNJBqv+0W097A=;
 b=BR0wzILWp2ZFeMiiSFsJeHUZ6X+pidxXHStm+eAP3Vd9jV9JmmaO9yheObWkx/9F1mNCzkhgBT7rbJ6IxBj3nnE1pcQDqt76wdu55FFM0MddP+3HjyEUKasoT7Shxsuy92no97sJjWKPSQ+t7aOCN2KWdwWSj1V4Lp0M8BJuyM4=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:48 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::ae) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:48 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:46 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 20/21] drm/amdgpu: remove is_mca_add for ras_add_bad_pages
Date: Tue, 19 Nov 2024 14:36:03 +0800
Message-ID: <20241119063604.81461-20-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fca4a39-1eb4-4ab2-025a-08dd08648b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HnV19Ayw4mr+mzp+37Vrkh4CNgA05efkVosASfNz3CbyNEeQ3KSYkcUW/lEX?=
 =?us-ascii?Q?D2vDI6KTcyK06XkGDfDxIXsfvr3YUn1MrSkLq1bNLGquGRyKxTcCrvpyStEt?=
 =?us-ascii?Q?cys5WHFyHhLpoL519k67WBK5Bqnv3RLiXrdite6MSBbB3yWi0Gq8EO/16Gas?=
 =?us-ascii?Q?7Z5YGNoa6UzT9FSMV7qqE+kL+j8B1XdYnzUQPgih0K25eNQWoXdqWMZI+lg9?=
 =?us-ascii?Q?AqJUVV6nUEjUkS5Mxp+K2ydbqMsjODt/QytDR6k7nE4SHy0mSIPslw2a9G56?=
 =?us-ascii?Q?UpQCVobrFwetnjz+G578rhpdCTT2M0VGsi+vwFdMNDv4rkPndw1CVmRjXiur?=
 =?us-ascii?Q?i5D0qsvINJBOFfayzLAiJJvsp/J2owkIdfH7L8xghwTBuSD1O+S1Ufo3ixei?=
 =?us-ascii?Q?CSjhK8hpfxJMp4P8FTTzWbyMUdopLHLzhGFDFnii5RxQXfuD7Rj1fRxuTth7?=
 =?us-ascii?Q?M3VLLNO6oPyVMvCBb7KpNfTXpomfdqzVAYft2J1wlkYOvCx2HRHP3xajgkNi?=
 =?us-ascii?Q?qoUkcU5PjRTesBJoyRqb0COLjK9tG6+9hvPfS6ALI4mv5Np3VkJusLcUIql4?=
 =?us-ascii?Q?Ex0/A/5GHtFdp0xkejIPgiTOWKLF+B5swOxJ3WY80HAOQmz1n6SMTxolA6NW?=
 =?us-ascii?Q?3XQX/Ab6NOmCdSnaOanCBU3DmQybg2kGOepXWCZz6p9bIFkBz6ySxSviUPYo?=
 =?us-ascii?Q?6sjMZS2U+VH7pzxoml0UdU2IvMj7ki5MCdxcl4DcHvrYNB9tD7KmueEZ3/3C?=
 =?us-ascii?Q?BYocvHTH9CxLtql07v8bkWZ875IKdPICgRETuK5WmvT5UtQ00b4/BIoui+Ur?=
 =?us-ascii?Q?dfggJcVp/8XuqEys4Pn6/ZHYKggUC5pxKR9ELJC9JIeeAZpUSK4tXvyFOJNR?=
 =?us-ascii?Q?mQ4niyP1tUeYkd9bCBkwDsBnSSNpPOAtEnCFFTC5RRD3A6svsBPQqszdS2BZ?=
 =?us-ascii?Q?e11hX/2QI5g1A+zhux8d51Gq1Za9yb4n8jtagZtVDQl78khIWWYRvgMroJ4h?=
 =?us-ascii?Q?l6ugfZ0xim/uhxSijecF3a8PoDOlPhw1G5S9wqZ9iP+LqQ7YY7Kjb6mYvsKU?=
 =?us-ascii?Q?ONgh9iEgVS2sddUM9eyJwSzEokhhpjSR473nUlIrU8s58ZrdQ01dbCjh1O82?=
 =?us-ascii?Q?aeG6U9uoyjfW0tzpNv9qSQu1YeR3DtjtGcK0oAnpY6ow/P3Gzphy/8/UXQjr?=
 =?us-ascii?Q?W5RBIiM0QThmW37zIRc0Y2beRMAi/YLfKYY0YYZuf2aO3hr0tZbXAM6mRF9f?=
 =?us-ascii?Q?TIu/N9m12vbAxB0gPXQ47FXLLs9xCIVFrZefqzhLKvNE2N1U3cqgu1sKAwT9?=
 =?us-ascii?Q?rvoE6pE9emtMCLboOJxi2Y1TSPJ6NbH8+h0NBSYSUMZwI1D1anCQzsfEQuIj?=
 =?us-ascii?Q?YDt56nbxM4fXqXxoBSorVrZpA+d1+h6Y9aO8QSVPET6viMtEag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:48.1294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fca4a39-1eb4-4ab2-025a-08dd08648b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

Remove unnecessary variable and simplify the logic.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 76cd095f96b6..f98e7b1aa96f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2743,20 +2743,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 	uint32_t i, j, loop_cnt = 1;
-	bool is_mca_add = true, find_pages_per_pa = false;
+	bool find_pages_per_pa = false;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
 
-	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr) {
-		is_mca_add = false;
-	} else {
-		if ((pages > 1) &&
-		    (bps[0].address == bps[1].address) &&
-		    (bps[0].mem_channel == bps[1].mem_channel))
-			is_mca_add = false;
-	}
-
 	if (from_rom) {
 		err_data.err_addr =
 			kcalloc(adev->umc.retire_unit,
@@ -2780,7 +2771,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		goto free;
 
 	for (i = 0; i < pages; i++) {
-		if (is_mca_add) {
+		if (from_rom &&
+		    control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA) {
 			if (!find_pages_per_pa) {
 				if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
 					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
-- 
2.34.1

