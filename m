Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3512761168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3512761168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BE16EA8E;
	Tue, 21 Sep 2021 18:07:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A2D6EA7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt6wMGFKSyymxQO4ClpfBtmpeJgduPXIuLMxKyMetYl/+TePn6B7LBzK/9b4QEnYNddpFQflR33dSMP7nBsKyZx3oVtIp5CpJ8aZBmkAiGcXdA4+XX5xl7tHneCJ+n2gvBrqB7h8bPEPEoz5/tpLEpJnTcms53nPXmajLVVKX3iJihYJreTZ5RwhuY9Y3z8DYlTkkcK9Zaq4y78LXpc1A9B8qvDSLpzjv7rfQTFo23cdCCql30quhb/uZ1G0IkMmsnokY/j2wdBePE0LPeLX9nDNrR1HdgelYjh+EAyfm1epv+Jd5U8Qtt9sPQoE4w02gsv9rjWpEssQdvPYtYXcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cnmMNpQ75AWsnfgKKF0LPIGo8ytHPOSQPi69PUGSgSM=;
 b=IqDm/7TrHQ96XxHDdVRzBRcrH/TAIaQlWK6Miz9bl4mQuWpGZ5thgwGzIRaILmSY1EqiGFdV4ihseB0RpD2+gqrwFzmg1PLvMZTgI/fbFDHP/HDOWvB99R0kdYEP6MfZ0/ilAqWzv3nfeR7RuTf00HxykW6wokgh0YP0/WGp29PR0gGLZVXyWHGKpEUCjsfC97vHtEcCS0O2cSE1PlJy9WAlX9mIsbhBkc8fzYI4fk4tCQUcqzKCHRxBLmfiHoCl6URKQr4OrICjjz1EYvSfafU1kbvgv/7idxRhWw1LcpM+mHTN2bhscvdFK0PAZC6JXWUeQzerEYyDspGFcgvncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnmMNpQ75AWsnfgKKF0LPIGo8ytHPOSQPi69PUGSgSM=;
 b=Lh4CMYaSmyYGFhEhcSy+U7WO2eYPgSMzXUwtB7oIE2t+sUh8CnUFZIZDuY0PZB7X078VSb2Wjh4lwg3wVryUnn453uDOiFmde/CW1JRkgoEt2d6q59iGeAPEBlkfHKTim3zrRGG5dMGIHqXI/9NmiLMcp0Dd2KarXemy4QHqliI=
Received: from DM5PR11CA0022.namprd11.prod.outlook.com (2603:10b6:3:115::32)
 by BN8PR12MB3537.namprd12.prod.outlook.com (2603:10b6:408:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:07:51 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::12) by DM5PR11CA0022.outlook.office365.com
 (2603:10b6:3:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/66] drm/amdgpu/vcn3.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:38 -0400
Message-ID: <20210921180725.1985552-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e08c0a-561c-44c5-5134-08d97d2aba3f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3537:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3537CF0FDE3FBF80791B90B3F7A19@BN8PR12MB3537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T4G6SX11JDcipkex2FXT+xZoTHwtSWjA4lMrSQ9R4daH+tMhdQuiT1AM/sm/xYprRvJhRJvRwJx2qxS8wx5GLFoanLn62ibZpYhKTTnWAdj9qr0oqpiEW/rwIrjB/+6EclDrRQ0GAljlXDQG9EkqwGGNH+CH5vrzCOMRnhEdo/x1DDQakbeoC4LSa8UCG2tvN1/Z33zex51o+AZtmDwqnqGif91JeVOWzHXOMVJU0nBEKLLkiy9BYaNl8dL0eMLfQom4xZ41iO0wNe2l/S51sx5V0tyoaYZPlilSciCYsHmktnxeXrHMNsg5zJWEXA6gw9XiQQKGKDt+0Uf+2srE6SsWZnYe55jdEabNzK2IfmHHHLK8OExPjEzjRJnXukgYj4azpY/F5qTnRUHFjwTFkPQIwWgVS87MOK5YeW5lDnkmscLhfz9VNBigNIqDKo/i5BJwaghGd6mvJ2AdArWxl6IE2OQo/yhZrhMVDWreuBuQyoR7qIRRuaQXHbaSwcMgMc0t5IFUCHM+4Du+GeLbGbCp9wXmA7/38ZjygHD3buoifdHajlcaifh9D73XFbtcZS0vG7Vb1mMWEK1lk9RpQRsJOH6T8g758VVI1FZ2U0STR7l1FdDP3dXby8lEzu6uuAp0Djq0j0M3QvYMc2Wq4Q/YXbPy5aIKhcLsjPcMVjhkACpK8bjmd7uqqIOKO0xmo9VcN+sP4tLVFNCxDQQknAF4RwCDMtoUKHDN8MnZOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(70586007)(426003)(7696005)(82310400003)(2616005)(4326008)(6666004)(81166007)(26005)(83380400001)(2906002)(47076005)(86362001)(8676002)(8936002)(36860700001)(336012)(1076003)(6916009)(186003)(356005)(16526019)(316002)(5660300002)(36756003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:51.5626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e08c0a-561c-44c5-5134-08d97d2aba3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3537
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b1af70d49c6e..ef36ee0f3a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -95,7 +95,7 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.num_enc_rings = 1;
 
 	} else {
-		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 0)) {
 			u32 harvest;
 
 			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -112,7 +112,7 @@ static int vcn_v3_0_early_init(void *handle)
 		} else
 			adev->vcn.num_vcn_inst = 1;
 
-		if (adev->asic_type == CHIP_BEIGE_GOBY)
+		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 33))
 			adev->vcn.num_enc_rings = 0;
 		else
 			adev->vcn.num_enc_rings = 2;
@@ -1272,7 +1272,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
 		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
-		if (adev->asic_type != CHIP_BEIGE_GOBY) {
+		if (adev->ip_versions[UVD_HWIP] != IP_VERSION(3, 0, 33)) {
 			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 			ring = &adev->vcn.inst[i].ring_enc[0];
 			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
@@ -1644,7 +1644,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
-				if (adev->asic_type != CHIP_BEIGE_GOBY) {
+				if (adev->ip_versions[UVD_HWIP] != IP_VERSION(3, 0, 33)) {
 					/* Restore */
 					fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
 					fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-- 
2.31.1

