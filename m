Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9624C0018A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1F510E9CD;
	Fri,  3 Nov 2023 13:12:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F116310E9C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWAQu8qW6aYcdq2mrq34y0YKB6H3XbguBFph+wn53rKxIQXA6OBI3DB/LfHsA1IO5CT5Rp8LIHxpuNEqXOdEgEsymTTqFeqGXeZxBFI6yM787rf0tfJ58IUk4AKhbqR6llV18EMilb4waQc2TZePXSpwivm7ca+RzOZICbLET41GjSUKGicfxDP29HueGBSCYng/0IU1ob6XTIiwTGY5zhAzwDHuflsGC4wBDQP0GURncdHsPUYJZ6MiHc1ogQZLC5LLp3m6LzQ3NpXQvmXhb/ylaybh1KXhy06T3zEh9XaKsfECa2ndaAMEQb5xRnAWPRMWHKvyKpElylJ2GYnwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=Ao9mu+lbZG9zKx21ivV6G0Y5siVIMnJ6BGdnXPX9naFLTI48+VWEJIDwq6twWDrZUBE1Sp6jvP3N6c7MZrfGt3iXOsIquchFNOz24ZiZxYBWmOOHUXu5kaPCvInApYFJwMfvT1MX6YGU8wobMEzXOFNgeKrKqgzvcvUNrzMZzzaGTvAi+OZ/HAQi7qOKFNhasclOjAtL0tgsT2Zvk/gLpcAeKMhKuB3tFjyU8IQ+hRcSdkk/eM3X3LiB0IYMkrZwTDbeFI63LweUrS6gtKoLdaUdbNlfXBJgKU8pqXwXqAtyRjaH7X8zA6JTIqEG3sbvwBeQlGBurOjxVb1jzYu/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=3e/upnvO+ITp65STCGxL5V9PNocdUbq9TJO3DXzN0rZX2jECYwD7bgbw2bsraQpypEN/DgKOVApsWjCNxuBNPudEtlHZeNO4hLvIqAiuhab3L6vE3TvRDPwUclP6janWKzC8V7lck4mbCdVb7nbspPG7vOaOdr9vEsaRb5pBHeY=
Received: from DS7PR03CA0110.namprd03.prod.outlook.com (2603:10b6:5:3b7::25)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 13:12:09 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::53) by DS7PR03CA0110.outlook.office365.com
 (2603:10b6:5:3b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:08 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:05 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
Date: Fri, 3 Nov 2023 09:11:30 -0400
Message-ID: <20231103131139.766920-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: e896c998-e7ec-48a3-f9e3-08dbdc6e7c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ep7QUnvnI6hE7W0N7kszM+WuiqpHpJmihnDqn8zYQGr7WQ/XCHGUxkzOmoF/7HsoXzPgccq/townkPrZKBbu8BByHvC6AtfXjq9hfBaCUe2Hg1mG84jUX4KlDuMn191wuygdk1fr8s88PJbBTnIm2hbCLBDBby6d4SAk3kFZ4du0mzWeuQHvL7xsgloEB2KHaap4YFrXWwZUCO+2UO4rSn0oallFvk+iNFXnW67xqIJmWdHGiE96r6vyb7CZu2DmN4Isi2z3t2xSofGgIKPR/72vhA3xsxhX/doxy7qlVU/kxitnnE2TULOTnq3kKQ1bdi5FD+jy/QyQPZ/XmcM7SoYaJxWRALR+tafMB5L8wDWc2uE6BAxqMKzMxgnPglwgqWBIZv1O/aR4d1A2bIY1/CU+veRRhq4YKN4rvvEh5oh45q9xsYuTenlKvrRbWEW8VfHgvEb167Rj7Wn/MuUtENHxoegJLDlfy5J9ynJtAHAj6572PeMxmF8bG7M3z1/8BcAtHo6ZMCPdCTh1oSv/JLhuXz/hsVssVsKTKwgeEGZw+mPOYXKhkdqWSxQ/BPQQ6HNnLbpy9/7cl4o7EUwWOjoyyZwycO//8tJtvucWzKFBdtOsAiRXR1t5qRnmFxc4RzFGu7NHYU3PhUCyQI+eydw9jN4+LymiG82exKlxRjMFyPJRFY5+AEpfykIbQqejlRJYQJz7XD9TI9kOKyOn6QZidd0LQiEZUyL2Czr4d9muR5qd9L5q5atyvI1QJIXG4MHb0vw4MTrW0uQux7N3bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(4326008)(8936002)(8676002)(2906002)(5660300002)(41300700001)(40460700003)(478600001)(6916009)(316002)(70586007)(70206006)(54906003)(40480700001)(36860700001)(47076005)(81166007)(86362001)(36756003)(356005)(82740400003)(7696005)(336012)(426003)(26005)(1076003)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:08.8579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e896c998-e7ec-48a3-f9e3-08dbdc6e7c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement trigger pc sampling trap for aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index aff08321e976..27eda75ceecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -163,6 +163,16 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
+static uint32_t kgd_aldebaran_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 8, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -191,4 +201,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_aldebaran_trigger_pc_sample_trap,
 };
-- 
2.25.1

