Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA48C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 13:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5084810F03C;
	Fri, 20 May 2022 13:49:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C9C10E53E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 13:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf+suJuKeU0x2IiI70bG8/0CzRvC4z1DJmTL0ovp0+YYnd8lkqhW2ORB9dL7o+ltddRA3Kvurv8oK9MOr6pebDOwDQ0H4TAon73xqIRvAdPprz6vib79cWPWH4kepDydtGZUGDEypuGLaXMH46nvLGDsr/iGtDl/vpyJUi2c+2GZQ8s2JoPHIJ0FCaQ8CF8ywQHeLMAnL0/UIUx2zBkXWgJGUwMwxUBgHZC19pMCw9aM81kF9HjCMq6pJeUOu6thdnmf1CEgMOxqVf/9DMVmQEDdwLJmvQAY4Ttezf0m/gUt69HwmWcGu6j9nd2F0ekkBrAQBOSipr5e1VwGwZe/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZeLGDSejwaqiSU3qOH6/1jQ58MLMY/VwEwW8kTwZoE=;
 b=C1Mki3rKxQkTP/VmIN0Zreb8RWhCNTiOu72k4lgUvuWBTCbKqIZWQCrkabKyOSiAT14twCIxIMpfMm5uSb1ugtUEFBLYQ/cmoXYlbEAosGxgGQ+e5ocCjAE5kL3caMyHt2GZjPMnDA65WJ6Ea/Cnza9b/+pLIdJpWuNk3QroqsLHrWrId7Fi/6y2T0KjbsGuto/X6XRLEcmXUtyFtzGW1Z3uTQ4MDVzIH86SjjqO9bS7DUrV8owe0R3i8Nxnn5NHqlFe7LeQ2CwlIgrt7WaeI+r5pUgkwo4phJpznlmSPyHnaZlA437+GYmW2orile0Tcfbpyquri1rxgvJ2gMhK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZeLGDSejwaqiSU3qOH6/1jQ58MLMY/VwEwW8kTwZoE=;
 b=xOTDtyf/mOo4jsI2OD1Ic4bEPiemqxaR1gp1OJQTAEdoTrSvgD1KXc6Z0lkiJRw5HF/whj310618oJbgsYVeEztyzFi97C4i1i4y/xbuoF7TINN5Pr8VcZASSP6qUCFHw/DgElwpsZ9ELtLHHOyDH72h9BscwMqoHxruwhXZKcc=
Received: from MWHPR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:301:4a::33) by CY4PR12MB1414.namprd12.prod.outlook.com
 (2603:10b6:903:3a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 13:49:37 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::e1) by MWHPR1201CA0023.outlook.office365.com
 (2603:10b6:301:4a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27 via Frontend
 Transport; Fri, 20 May 2022 13:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 13:49:37 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 08:49:34 -0500
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Date: Fri, 20 May 2022 19:19:08 +0530
Message-ID: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94915e7d-43c3-4530-f81f-08da3a679474
X-MS-TrafficTypeDiagnostic: CY4PR12MB1414:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1414C8BAE2DE91AB92C4A82FF8D39@CY4PR12MB1414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c29TgFGN31k13eEKkl5pXbdtjy7l+9Ykv+/DRJQDwquhDsYIWB4LZLKOTVOzHcmtl4AQW4ywaEJ8gPW3b2AOnbydWnVcVg6WzUNCYSISGah0S0wucCcydRZA9c8xCImRT/XnIOxJeDzFq1Xdprx+F1tcZzrbKAUSLD/9xt6C6evdCeEMrg0Itnx8LoS1awGsczbMYhjOZa5SOe46vqoA31wv8jTJpGg/RIojn3lGkUS/Oy2cD/D9PKoVGQMpScURN8YA2C7vDHjT8W8eIRb6YpraesTPbbrO64nAysyce1ekW2wW0lXDCVKapqIKi+vvof/Yi8r16nH9u96g50JF2tQ2ViBRZ/T4CHUeRUTRNN6XuG7DTBaXj6wBn82wSn3otphCozs6dGrRaHLHNFcUCF7hKDF0nWfASPX4Dfz8WlA/ry5J4ILuwNrYCsgdejXtem6heWDF1GgHqG7EceLw1vwcrdlZqIs01UxF6rNIYwb9uudf+0WgXbXVqbbN2uGJ63dYhtOLyDskvuAFWmTeiXSaftHrDfizMMHmGoRQZCCOIWSQFeOYWBFtjZH7OnCaTMi/1PC77c41gEL/YXmzMdJV6u40U469fFpuIPznPM1G2ffuNyjB9gasJ5HU38MEk1KnoeIYZLobjheR5x6wdfLY1wxgvqJTRLiRoeoN1o0O6TNjAUT6Db0gzWZA2WVmrbgYjJ5LJZFGQwqKlqEh/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(7696005)(6666004)(26005)(47076005)(1076003)(356005)(16526019)(186003)(336012)(86362001)(508600001)(81166007)(426003)(8676002)(4326008)(6916009)(36756003)(2906002)(70206006)(70586007)(8936002)(5660300002)(36860700001)(54906003)(40460700003)(83380400001)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 13:49:37.1207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94915e7d-43c3-4530-f81f-08da3a679474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate memory for register value and use the same values for devcoredump.
Remove dump_stack reset register dumps.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 7 +++----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 76df583663c7..c79d9992b113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1042,6 +1042,7 @@ struct amdgpu_device {
 
 	/* reset dump register */
 	uint32_t                        *reset_dump_reg_list;
+	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
 
 	struct amdgpu_reset_domain	*reset_domain;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index eedb12f6b8a3..942fdbd316f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1683,7 +1683,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *new, *tmp = NULL;
+	uint32_t *new, *tmp = NULL, *tmp_value = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1709,17 +1709,24 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		i++;
 	} while (len < size);
 
+	new = krealloc_array(tmp_value, i, sizeof(uint32_t), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
 	ret = down_write_killable(&adev->reset_domain->sem);
 	if (ret)
 		goto error_free;
 
 	swap(adev->reset_dump_reg_list, tmp);
+	swap(adev->reset_dump_reg_value, new);
 	adev->num_regs = i;
 	up_write(&adev->reset_domain->sem);
 	ret = size;
 
 error_free:
 	kfree(tmp);
+	kfree(new);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4daa0e893965..963c897a76e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4720,15 +4720,14 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 {
-	uint32_t reg_value;
 	int i;
 
 	lockdep_assert_held(&adev->reset_domain->sem);
-	dump_stack();
 
 	for (i = 0; i < adev->num_regs; i++) {
-		reg_value = RREG32(adev->reset_dump_reg_list[i]);
-		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
+				adev->reset_dump_reg_value[i]);
 	}
 
 	return 0;
-- 
2.32.0

