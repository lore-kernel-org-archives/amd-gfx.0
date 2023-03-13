Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AC3C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 11:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E7510E004;
	Mon, 13 Mar 2023 11:44:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1339010E004
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 11:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW5/lQrsM1M1qyDS23/Cyp9NYGudZj8B71HmC6ukLkDlUpkMkhL2tNmkZMHo0GMbxmxKmX706eq5ayW8dWwl8vdUuUdyCUJHBvZLP1+P5WLMALpxeRNfTrDd8SGy2I8rOkZ/PzZjwkDjLnLCsotvsSt6Hm1u3kP1FQQEfQrKfVsnhX5CIYRwhrQVqwSZ8uHBt4tdIdXe6Bv4MN6AnVqhveCCnfyNCvA/yjhH3R7Ecslh8/ygo9O9W0xBAvgUu1mFL7p1SQGM/9uEeo9PErrG08w5bvZeCnhP7PYPp4kIVgpP2pXNQU7B5osAV8y246twrARAYPRfYgnx6EifOYhRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBY3IOkhjrxw2EFDJ36St58EhgrgVFj5A36I30lQwEE=;
 b=VPTQLpfB3xQNskJg+3x0QXY5RhJ+8jExHPo1SvlYqkB8EPNc/3X3hXDNZJ/AxsPb0krV9jl6GUuqT0JrkqMYzEL90nqOvh9MWW701CWMOIfSc7RpmPj7qPHRKoPcOs4kFNiiYIAaw1aAs6SfthapzUUwsghmwKTgWfyClG16r+yeyGcFSbr07rDsqxd6lHuqxkF3hf9lNj9UxjaHSbRS753m9CrfCti0s6xV8VJtQ6MuXEWIWmDzqaHrPjh6pYvwNmuOpeK5Rcd4GHjzAN2CNAST1QknKvF+zdyTyJ1fxDGn/YXptMJWj9NP8HiOoQOjqxC/ZP6oC3m6eaSZwjJcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBY3IOkhjrxw2EFDJ36St58EhgrgVFj5A36I30lQwEE=;
 b=YWXN5WmLH5i12dMyv2eJdLLXChORasvrDZOwSED4vqNywPITd04W0eO728vE6GLZdHdyC01tcwrcLWxE18reCnGvmcJcSC4V/F1fzkOaWQQHsgD/ErjqZnoQ7VNVOpdyY/9y7Fngr02hyALaiT+X6eZZn18Xzl0tw/PpBDgp930=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:44:01 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::89) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 11:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Mon, 13 Mar 2023 11:44:00 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 06:43:58 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip ASIC reset for GC IP v11.0.4/11 when go to S4
Date: Mon, 13 Mar 2023 19:42:09 +0800
Message-ID: <20230313114209.148894-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 02733efc-0a55-4335-269f-08db23b83cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vyxm30WepRq5w4jn/N/jmSPo/0MQ1CB3w4t5PgRII/QrH7IiqMKwIZC3DACqK0xtdyYJR73G1Zi01Q7gLIWiFcYTpHQFpNJ2fT849fdOHZTjI9jpzFa83dIb5E583oQdpeccn8dmZoCqStlW5IDzsZPYgHnFi+qV1g5A7d0tW/RK4DSjHkKKt348dKbX1TiLeOIqgpmlTvv7AepEGYyfNGuKi9TBeewpFlM4/ilnF4wos3m5X8mX3YFRFp2mwx2h29D+fXBz+sdXiMpOvbPyUkk9CH4gtNrCqu17tLi1ZARqYuQgHucyjsJvjDx1xOwSknCh9GcVfmt3Q0tndzY+Jg21GE5mess+HBytLAN1SVPA46UNwhW/QKJjnVWLA8qDGahHMVD2QbzkqyBvTMFQmSA24L04AG6npLZ2axSDUGwg04ov36LIOyne8XsuEpG3HJMa+idA+HIGRu3XTxfIP7yvHRjw27oMaU1lVDIhgQ5tnJwEmK3bqDMrA6gsCNnQxvtPzzQSmGQIjoPkGwmzDVUwjw1jpqX5pAefMNcwRVVqTTJjy94AOF/2AaHvSj3Inw6wYPi1/onXTDXpdEIVEXA2XQwXL7/Dlud3koUImoRCQi8Omnu+pNfugpfecO9C9fz5PjJTBGtoR5XpVV5MkuBtP8/LQmKIB2yVSLTqnQiLdwxPBb+WqJoktNkICfQfVmg/4yH1mPDgPYAMVO8IZ8bbauLKMYzIVvxneaXJ9go=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(2906002)(81166007)(82740400003)(83380400001)(36756003)(44832011)(40460700003)(5660300002)(40480700001)(8676002)(70206006)(41300700001)(8936002)(70586007)(356005)(6916009)(4326008)(316002)(54906003)(36860700001)(86362001)(82310400005)(478600001)(426003)(47076005)(336012)(2616005)(16526019)(186003)(6666004)(26005)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:44:00.4094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02733efc-0a55-4335-269f-08db23b83cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim
 Huang <tim.huang@amd.com>, li.ma@amd.com, Alexander.Deucher@amd.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For GC IP v11.0.4/11, PSP TMR need to be reserved
for ASIC mode2 reset. But for S4, when psp suspend,
it will destroy the TMR that fails the ASIC reset.

[  96.006101] amdgpu 0000:62:00.0: amdgpu: MODE2 reset
[  100.409717] amdgpu 0000:62:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000011 SMN_C2PMSG_82:0x00000002
[  100.411593] amdgpu 0000:62:00.0: amdgpu: Mode2 reset failed!
[  100.412470] amdgpu 0000:62:00.0: PM: pci_pm_freeze(): amdgpu_pmops_freeze+0x0/0x50 [amdgpu] returns -62
[  100.414020] amdgpu 0000:62:00.0: PM: dpm_run_callback(): pci_pm_freeze+0x0/0xd0 returns -62
[  100.415311] amdgpu 0000:62:00.0: PM: pci_pm_freeze+0x0/0xd0 returned -62 after 4623202 usecs
[  100.416608] amdgpu 0000:62:00.0: PM: failed to freeze async: error -62

[How]
Skip the ASIC reset for S4, assuming we can resume properly without
reset.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 8fa9a36c38b6..ba02b0d9ef7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -980,6 +980,8 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 
 static int smu_v13_0_4_mode2_reset(struct smu_context *smu)
 {
+	if (!amdgpu_in_reset(smu->adev)) /* Skip the reset for S4 */
+		return 0;
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
 					       SMU_RESET_MODE_2, NULL);
 }
-- 
2.25.1

