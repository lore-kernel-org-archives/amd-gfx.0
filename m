Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B32C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 12:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667FF10FC28;
	Tue, 24 May 2022 12:36:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0AF10FC25
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 12:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEitfK9Jyig0UyDry/uK6JPXY05ddiqstDa/6RzQnquatrOWj5B+s7lqQOx6g/XR/R53g1m4kbSSsut+bWpfhQmGLMXCDAy9064ZiCpAYtX9VBDBWg6IJjv8EPn3vokhsX005/Ah8qdtKiJUu+l7ht/KNmzycfIZJa3I5XGsnnXRuEMiFV33Ilxb+u3R0Goowp2KFmE7P3gMIFJ1ORpj2uSROa3V13R9g/lQ2u7ClcAY68EIZyoNPIItsHbLkE9KFvOuEgnakOHXulURqOnUkDuSSdympTh620bPW5TYH4zIqI9gfA07xoIe5A+wL/x/rYsAeDkkCqq6GNip1q8RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTsN0cQ0CAqzxwlhAsVAexny1Edf8dnsIswWSYRZp0U=;
 b=QbAe1WqKKpgkOhR+Fpecc2vbv82KjTNDrbJLvURYA6A/7UoCuYIFDGBIqtizovodI87nQ1+wuDtrf+opR1PAUDjRldLbcVQnCbNFGgiHwl/fBOpSYEdoo74VWgZFVzJ/FwF89AaZEQvvQ33asz7MfSbEiVzkmfEEgSvgPK5Z/0Rw3oR+0B5r/LcXUvZAGjx7Wyvtjo/xSnG9kfKO/EZQUlMBC9xXluMFYkksU9TKRC6VpMyYMjuEuDJEjusxJJ0WGN6gC2XxfWtUKGrtAVIlIvg1abPp/GBykGJOWmgrW6hIOkSX1JfUIUUZXulmjKt+6R0uqxFFWF/MjKexhiMtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTsN0cQ0CAqzxwlhAsVAexny1Edf8dnsIswWSYRZp0U=;
 b=rTn/haTRjmQOQZOXTuV/UpTQ/Dgtmz7DOQNEjhyUlKVJ3pUvE5wj9sNPcHZfRcMZgAJp/siXPNowuhWsPJlw4slDo+DsMM/TuRWIpcbp4WhG0gTLgvsw+hxbQe3j9VO1CgUZRBavoh/CbT4+/ixh0v9pP4/rTzQXlywbP8VnktE=
Received: from MW4PR03CA0332.namprd03.prod.outlook.com (2603:10b6:303:dc::7)
 by MW2PR12MB2412.namprd12.prod.outlook.com (2603:10b6:907:b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 12:36:35 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::9b) by MW4PR03CA0332.outlook.office365.com
 (2603:10b6:303:dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 12:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 12:36:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 07:36:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Return auto perf level, if unsupported
Date: Tue, 24 May 2022 18:06:14 +0530
Message-ID: <20220524123614.1487039-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c376747d-6862-4fa1-b0f7-08da3d820a72
X-MS-TrafficTypeDiagnostic: MW2PR12MB2412:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2412B4445317E60C3B9B9B0C97D79@MW2PR12MB2412.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZTbisrHE8fUdDj33c2C51lXcwF+WYrCJxn8U4FC+BmF57hLAL+97MR3CbHFXqjQtz3bHxCHpMUXbfpBuyLa7D8sXldtHWZ3KnBJ/RF1ZHjb8iswOwlaNGcv4Tt4KsNLIHdvsRc77DGXBD6UNJ0CbqHP9CmiwF9exQbKcuGmwJvhStzELm7URvRmXvr1YpDjL090SxoccVWRqSYaeqLu8X24uO+8w/jvQ+WiZ5t0BxT4ZNLql0uuoN/x5NJfSpVzlZtP4TUCj409l6mxAN/Zg5uLFRJM8350U9l6jCJ36gi1wHB+psgou938wevnrdS65/Ry+0SPC150ebZaEUfVDdauGdKZ7jLkrgjoODSJmLao9XrKksiWfx0+kiy39Y7v7QLo/wweE/zEOHdm86ZQWYgrCPQreVidcgJs5SQzlAVkLi47928nCRMQkvQIPoKxetARf0ysvmEIG8TX2fnHVWjFNsOrr/S22qReAbWuxw8wFxzjMlhXrUoOPrSarWdMCgpWo6QIK7GkLYxcxyuXK4/3Tog2mCm9q1tSUZ5dwXyJ/iECnR2xi58gN2csAou7phMdTkpurzAqpbrVeVML5SGGe9vLjDxeJQrroZk6Pb5JNRXhIuBE8pyp8nGM9fasJgWe2+Y8kQpiw4gjBKeS8WPWxwPAeCWMZ4LCpfLQg40iJ8J9wbIoc5QZ4CjcNq2p/kQQ0gjKBBGtlXbeR7TkXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(7696005)(36860700001)(54906003)(5660300002)(6666004)(316002)(8936002)(508600001)(356005)(6916009)(40460700003)(83380400001)(16526019)(70206006)(44832011)(82310400005)(1076003)(70586007)(336012)(26005)(426003)(47076005)(81166007)(4744005)(4326008)(186003)(36756003)(8676002)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:36:35.4803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c376747d-6862-4fa1-b0f7-08da3d820a72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2412
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When powerplay is not enabled, return AUTO as default level.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5472f9936feb..d1bf073adf54 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -770,6 +770,9 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
 
+	if (!pp_funcs)
+		return AMD_DPM_FORCED_LEVEL_AUTO;
+
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
 		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
-- 
2.25.1

