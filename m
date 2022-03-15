Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3E9C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304E310E511;
	Tue, 15 Mar 2022 14:11:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6238510E50A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEXul94T/jOVlIOrS3LydEfyhaSwIKSMY5/ZAjorppSaluqCyXFF5+ATQ6LWaFo54PnoaYmnZyGOXgaT+hYtmUaM7PSFFPOqdO6j/6zSuW/m0PWvfCMDizlIiq9AzjYW1GxEYJau5bz9aAA6cobv1Ywu6vVRkBni8iLkwQ2GCt3TkjE40R142ZU0bCxEfLlInwyDPTn8s0WfG0dg/bhjBriaY6pKhaRZuSdr62Og46+IrhMvxFocEp9vscbHEGApkBNki3T1AuR15yL2QmRkP0Rn8ubml3nkV/9IFTK8AeIW/okd1u3W+HmM5aAT6fKpYBRlwPOfbA8jyuf3ImXTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqvX6JMPHoxRIDdKaqHWrun1AuYfbLVzrScaXAmsBgY=;
 b=TbipMXAvZqBvirjY/8sCU2DhuAPBRV/IE8o6nQqFihcbPoN+f4Z/YVHq2Ge9hYi+wN1+ZLY/agJddAaWuwfSLihUXrpIt5ctZ2g65se24wG/0sEeKNcUebJIUbXGuTUZDMGt+Mn3Z44MctVgzEcNv8L9Bm+gtNkQGUH34FCa4Pynz9B/rWwTZyCY5bSo6KJ1KHHuAenEuRFA+FxEcXqpvmH737OephUcUUZmn9DV7Ebs9Txa+FFUu2x33y9IOzTIA9XzSKE38yc+UGchOcoNv9WXhZ0MAMcP6bmVBr1U2aqg23VUekCzQSVyCcYhIucjZQzhsgC0pg2jxx/9JkdoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqvX6JMPHoxRIDdKaqHWrun1AuYfbLVzrScaXAmsBgY=;
 b=0wXR61cYgIbxjbSERjuLtSTXQRz7zGxt31Z/tT6CQlqftgz8XCW1oeQn6S4t8oWQOohWLP8/S8GiifS27nLJZVj6v7bA2920iUp26gCCTTUsYNM44akpJMNNsSb6Avt2j3igIc0J8S20zumCjfsLXvaS1hPmSkhiI1kEJ3Iv2oE=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 14:11:53 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::80) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Tue, 15 Mar 2022 14:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 14:11:52 +0000
Received: from yonsun-linux-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 09:11:51 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
Date: Tue, 15 Mar 2022 10:11:30 -0400
Message-ID: <20220315141130.150367-2-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315141130.150367-1-yongqiang.sun@amd.com>
References: <20220315141130.150367-1-yongqiang.sun@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ffdb73-6c2a-4e54-32ce-08da068dc169
X-MS-TrafficTypeDiagnostic: BYAPR12MB2615:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2615E42991B75C8A61986CB1F4109@BYAPR12MB2615.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf+dws7//jtQWd6N/8UYztxBxQKgF3PZzNXmMypJqbDSTscV8jzXHZ1wgq133mk9HA9Iym3vzf1q7kyZEH2x/Ho4JYvae+oLEPrEZ09yqCFZa9EF2mwUcGacR6zBWzQIptivigfVJhQZjUbqRZnA1MQjhsF8+zk2RRXegzIK5l/D0JlPTpGIb+HHIbo7r/ubbgqd+VnnMvvIpuRmwMMD1t8fQphFFpaf06J67MrCxQrOGV+1Z2OBjKZcBAHFPJX6TfD27+Yxm4o/CLstbqaVXVzsvmtFz9FM3UHNoRDWR82CI81N1wgJ8kRt9Y1P2RngrLTFJeuwDypBFk/Al9VcBsCd+CwwRF7FPFFtnDG4BxMXdFeNlHtqnJPyjohjfvHS5ebDYsewd4wOBRz6be7QeeNVzPVee2cRmnz9oqvSgZBsFvmOaKFuugkUx5UhIo45VYql0lART3LBuLynjg2bAR1iZUW66Nj6VOF6xyOArU4SeOg+ejPuvSXYq8pIEfb7FsRXyd+JttmnT/h4xfVYDeqxyNCDe+/zvpbfiUf10t+sibwFjpVh28MoCjjbxIr/tkY0G9DeoVNTHTrn6t5MlR/TSh5t6n34Dv8nEkBJSHslCY7AHWQoaHijQahE5Nnr1c092hT0unIY5/B3+yS1wDaFfwbZPkxYNwNT6xPKSk4WIt72QD+0fd/7KtwCYWK0d54VDGeB7S09YBoaPhOVMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(2616005)(7696005)(40460700003)(316002)(8676002)(70586007)(82310400004)(70206006)(508600001)(54906003)(6666004)(47076005)(6916009)(36860700001)(81166007)(16526019)(26005)(1076003)(186003)(426003)(336012)(356005)(36756003)(4326008)(5660300002)(44832011)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:11:52.9680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ffdb73-6c2a-4e54-32ce-08da068dc169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2615
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
Cc: alexander.deucher@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MI25 SRIOV guest driver loading failed due to allocated memory overlaps
with firmware reserved area.
Allocate stolen reserved memory for MI25 SRIOV specifically to avoid the
memory overlap.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Change-Id: Ia1d1c4392fb792fa0186250dfc6270f35ffd6bed
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f18d050a14cf..7021e8f390bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -643,6 +643,15 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	 */
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
+		adev->mman.keep_stolen_vga_memory = true;
+		/*
+		 * VEGA10 SRIOV VF needs some firmware reserved area.
+		 */
+		if (amdgpu_sriov_vf(adev)) {
+			adev->mman.stolen_reserved_offset = 0x100000;
+			adev->mman.stolen_reserved_size = 0x600000;
+		}
+		break;
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
-- 
2.25.1

