Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4EAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E4D611CC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9E4D611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4A26EA59;
	Thu, 21 Oct 2021 02:27:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FD76EA57
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 02:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Boe2uDBHrMLFWQXonP3BW5PUOHrnFXLfFSuLg5d+7CK0EvZcDfMXdELQUZxi8LB0CbzPEHY832e4hypMzLlQM+cNDX6QkPuLYzSr0Cmno6R4/WiQvX0KamkhaXlfxH/GSvtGmUFeaY4vOPy+yziRoRSTSiILCyoFa5UujflyPqF0Hf587Xlv8A2qHIiK0VIjGgRJpw9JhErbFJbWseUHJ4qeERHH0fT4d+RdDZwdN62Qtu3x9oarhuiawQGODhnayAAm6e+lzLf/Kqm+gYm27TnQxNwpqHeqd0MyuLsCUb+ZDUgerlrZ5tG+MPa8YiagNqtQHotOS77T0fZXG3nQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgKcSvAaS0uwSDjtsEByXN7IBhvji9lHx4WDl3O41jA=;
 b=P/cDc9hdU4JQT9NFOeQUsJKepJLyJG2NYrZbJeOrsNzBamKaJG75q5b89lkJ2EEA1ZDhTWD2ZKsqm552ro5XMTxR3JemZQPGVZLS+WKNHju2Yc4nLDBcGg8GDHQcm3HKqM8s2e3CXGwRmdpuHVsw5P3m1WoDjqpxgK82VgbpwIyBdVbYgSYgN5zNdkYZqKfHnGK3rmXJdHubIuQXoXJXEUghl26pd2nBWlPVpMsW1dwDA6L9gaoqB2iFfVV+SyvyMGSolBK0MImuIJYZWQh6LCW6JL5R3t3Gw+3YZAh8wcosThpSeP6yRtX4vnAvVYetWlWUPSiGgi45Oz4LUsnb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgKcSvAaS0uwSDjtsEByXN7IBhvji9lHx4WDl3O41jA=;
 b=sI1vo9AVTeRMua0lUlqJdWzERhqGOLgnnkKh/5PYkzX+StdBe0FQiJ0Dgp6SeQMjOUEk6NYBSaNGCWVkfbZLMFDwvuUO3zqxWonZTpda60F6hsP6/25ajJVmlFXvHIgGyTL6l6034xKnZkG8zEFZLjwFleXSaZaWi+YttnNapk4=
Received: from BN0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:408:ea::25)
 by MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 02:27:49 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::1a) by BN0PR04CA0080.outlook.office365.com
 (2603:10b6:408:ea::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 21 Oct 2021 02:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 02:27:47 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 21:27:44 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>, Huang Rui
 <ray.huang@amd.com>
Subject: [PATCH v2] drm/amdgpu: remove grbm cam index/data operations for gfx
 v10
Date: Thu, 21 Oct 2021 10:27:23 +0800
Message-ID: <20211021022724.576045-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57dfdbd-4159-4cf4-938f-08d9943a5f74
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14872EB0A987E8BCFC28D101ECBF9@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wd9C+QbG/IX3SdalX1lqRx10q/5oT4gk7JM617sHmY7btcXen0AzCTDZtWyBst7PiyI90Vr3CD81QbXY3dAtTFBPzCa4RWIhLppHujQXNcaOnng0dazrN9rGLwMsHAdZOgMAipnn1d3LIaLDkmROupjeAywyJ9WAompO3N4+M2hJuAaCBdZXjGO3wXwzak/ZeT8xxCaG4QMaCP7vpSjJg+E4yDL84RFGgmrE2rH8DChguJWa+2dSSKlfBN0nE6Ulc4kviWyVOtUFfrwdpW8Wh9jH8TLrkyrRaZsmlCSK2X8IPEYhVvfqHO5oYuOmfaLYcWq/6nl5m5ecDAvutBkqC9CvE77RVX+oOzE6wzC6Wdvq5Qq3vuK0wrZOHa/jcCaCXbWy5+5ss4B8anPCJJNExOqM3ZvhYpHh5kZ+2m69zQUJXyBTEbdX3QcVIIdv/u+6ZV9HIgoWQYXWVlujyoXkSZFUJ5EZGH9eK5B/h/NSNjVv5RSbg47Gt712/aHZmeYdxCCUpFUFp1eI4JSmfIllgnNWqctmvwknNYg7ZLmt0vgoYDN5jwUhoppVKRBSd9sW7mLiU9dztDQ62NL66wU3rfA54WO4DUe39gTdkZCCZKUYiY8ab59AkvOlVCWLhctqqFUEjRWf3XP48Ow8801waPfjFEG9fV5nnad5nLxmLgDwn7P7NTCqodV2uhl3ugpgGp85eTvf8yNhvCQ8KlpsrMtrLf9+i3gMzkXSU/uvIUU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(6666004)(2906002)(47076005)(2616005)(336012)(316002)(86362001)(7696005)(356005)(4326008)(186003)(36756003)(54906003)(508600001)(26005)(81166007)(70586007)(1076003)(426003)(70206006)(83380400001)(6916009)(5660300002)(8676002)(82310400003)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 02:27:47.8866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a57dfdbd-4159-4cf4-938f-08d9943a5f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
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

PSP firmware will be responsible for applying the GRBM CAM remapping in
the production. And the GRBM_CAM_INDEX / GRBM_CAM_DATA registers will be
protected by PSP under security policy. So remove it according to the
new security policy.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 71bb3c0dc1da..df54aa834f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -270,25 +270,6 @@ MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec2.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_rlc.bin");
 
-static const struct soc15_reg_golden golden_settings_gc_10_0[] =
-{
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_INDEX, 0xffffffff, 0x00000000),
-	/* TA_GRAD_ADJ_UCONFIG -> TA_GRAD_ADJ */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2544c382),
-	/* VGT_TF_RING_SIZE_UMD -> VGT_TF_RING_SIZE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2262c24e),
-	/* VGT_HS_OFFCHIP_PARAM_UMD -> VGT_HS_OFFCHIP_PARAM */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226cc24f),
-	/* VGT_TF_MEMORY_BASE_UMD -> VGT_TF_MEMORY_BASE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226ec250),
-	/* VGT_TF_MEMORY_BASE_HI_UMD -> VGT_TF_MEMORY_BASE_HI */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2278c261),
-	/* VGT_ESGS_RING_SIZE_UMD -> VGT_ESGS_RING_SIZE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2232c240),
-	/* VGT_GSVS_RING_SIZE_UMD -> VGT_GSVS_RING_SIZE */
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2233c241),
-};
-
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3809,9 +3790,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_5));
 		break;
 	case IP_VERSION(10, 1, 3):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_10_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_10_0));
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_0_cyan_skillfish,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
-- 
2.25.1

