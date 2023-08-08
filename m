Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83919C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 20:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C43010E0E5;
	Tue,  8 Aug 2023 20:42:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3162710E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 20:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCR3GUSQqNgmhssfHO1MaafYFS8Km6OuXasG2hTaSgLpqscnyxs2CmAzvX0rf4wdRHN9MfnMcbp8Y29v2/0sbn3IbUmdftAnJzDqKltW5g+JgpKhTwGz7FWMA6eMFedugcVVC05kmaO9YBWz54kgEwOyeV49f5W9mCoGUvTIbLL2kkJOmAa7oaG2J1ACuki3LX9SMQE+hVYrIJknVN15+iSFQHxeAyXxPdHOofItIW/C50hyJulCkHpDI6zcxCS2dQYTJFs3MJ9Yqxg4ruen+7BPg0NG0+TJRcktdp9mhHzznkP1XRBDDdIVtcAd0YdGq+bJo8/X1TMphm07QFsUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY0ZwRKpCQAaqX/y5RQjlCgOLG9sIimOJ4Q4H1u02sU=;
 b=DBz0YKfgVfbdqjYtOG39VsTHrkGwYIpEjnF8kPN6RdFeFuQl3DAluszW02iASdUIT2bDtQvpIcEh1wjRPg+GUkjCzXPjHurFtN7nIY+UjDHmJsIuu6EIimjEfhDjzO+x967bQzTHoM9xptubyOlqhf2dlE27qbSeLwiJa3GN0BcIl8TCVip+mEKSKfFsSd4JaxnyQtL7p6ZbnMjYlhUh/yQIq6a7S6gZAGcxWrvKkH9Mi4Ttp6mMf6zQfVI8ygY0f4RsW5Z+s726CU5KczsFTpWk/OyVzu/b7ID8eOJ1PYbD0xclqBZ9xRmfqLKOO6Jx0M8PyadVm4nG7b3/+7270A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY0ZwRKpCQAaqX/y5RQjlCgOLG9sIimOJ4Q4H1u02sU=;
 b=NKp0oukOcY7aQ63JN6BbEHtB92xjfHjUxQXuV2IxNRdqImjv1ke9VSNPt5icnj4urLGaIBKWGMQtSQC87oPOHzMOpHiz73SSGgPXqLYnghfP8Wkkd0+jAV4tKydd3WH4gnZS+UYXtmVPigc9gd9R5vMxtgPNk1BRdcT33rZYzE0=
Received: from PH8PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:2d0::11)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 20:42:50 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::cc) by PH8PR02CA0002.outlook.office365.com
 (2603:10b6:510:2d0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Tue, 8 Aug 2023 20:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 20:42:50 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 15:42:49 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use *REG32_RLC in gfx_v9_4_3.c
Date: Tue, 8 Aug 2023 16:39:40 -0400
Message-ID: <20230808203940.11407-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808203940.11407-1-victorchengchi.lu@amd.com>
References: <20230808203940.11407-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deb4756-6e23-4996-fa02-08db98500800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cHP5E9Wz6Xd45NBG96bkM3f9ZbmeBIYhraNoOTEQfYRstfwDgRsn4MLbJPswE+G1rKs1WqUTlDsqhES+R6k1PMGYJ2qPxxqX4fBkpWZwIN/1f7aRFzeRaZQTP9qAV/hNbCO97MgJJAQQZ/ayEj+7IFYAln5VtZhXnaRMqszGW4LA0Y0qBGNcR3bPX0XiNpOb47a9mEs9GLg4XFxm/5EGLqHKNUOcyrYp5iGePE6/AQ/lGsTXgIxuEvxWgkMdy2dLOiPJvN/pBhopPhNq+ckvVUdQOa7zogKVves/+MJrk1TRQSWSaCbYBWMyvYRnlv637bxfLTRPO+leMGejcZjYGwfHEotNziVuz4QEjaH+LhtSkXLcJVOd9kYOLo5ZlovvbNm5KCRFVQ5L8fROsbyp3R/a1jygRKSm6kupTcdRf9y2OpHd8t6GpJWQBILL3t9SJ2A2njAledl/BTCC65aMntNA3RocW3ugVdY6cBFTp29XW+cCIT52Yyk01OfLp14U/YrzvL2DbRLliOoThrKhp/0dqN/6jZCP2kIbNRL2U/67TyU3XnGFxyLcNg9P1fEak38TDleKwGPB5xcHjV82PrnyV4RWqhixctj3dASgryNvLcS+p5o/HVTXNdsyF1ddVOOidR+V2B6I2XB0PKq1Ba8yDRXTpNTn6VCzgWMxHJWaedA2PETyTgRxEssoaxPPKVVwhi+aEIZ7HTr5zCVzk3JF+0FLwUIjXe3hrege5pvJti6p7x//Ju2JkI95a89t4IKWmXp6QWOtDb+1wvUqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(82310400008)(1800799003)(186006)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40480700001)(41300700001)(16526019)(336012)(478600001)(40460700003)(1076003)(8936002)(8676002)(26005)(7696005)(6666004)(426003)(2616005)(5660300002)(47076005)(83380400001)(36756003)(2906002)(54906003)(36860700001)(316002)(356005)(70586007)(70206006)(6916009)(4326008)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 20:42:50.1363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb4756-6e23-4996-fa02-08db98500800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
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
Cc: victor.skvortsov@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx_v9_4_3_xcc_set_compute_eop_interrupt_state should use *REG32_RLC
so CP_ME1_PIPE0_INT_CNTL registers can be accessed with SRIOV.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 370660b2f843..8b779a103400 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2742,16 +2742,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_RLC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_RLC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_RLC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_RLC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	default:
 		break;
-- 
2.34.1

