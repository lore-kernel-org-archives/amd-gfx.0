Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D4DC48295
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 15:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F1810ECEF;
	Mon,  5 Feb 2024 15:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFUZtYIs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EBB10ECEF
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 15:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRWfIZLEPbWQTrJ2J9mKyH5MNWU1o5kQmN8Xjbc8rCSkIkj/AUfIIGlyav0SC/x6vju/lH86uezItINg6zW+YF7Vmevx6rkCdOBIWJF7CZynDchfA5i+pveZTgtvrQSpJlP14IcH4PWY0IHk+/K0XK72UbGhCkrGyMHdTtVzJDIAYiY53R10AOjwIsB3pO84WSGV3qcT9XoxstH/1z6cIlSakoCZbkT0dVDHJ6+uJin87k+js2sUoGIYG8/+8rJJ3bxphH8uMlLFjdNyXXiI/NpsoFSeyBcF0O/EzfSdFnKj/MeR8LdWtbxz9lh1UHtllcjX5ycfy2CL7VmMrzH/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEY5jKJ/ZtXF5H5xis9ByUjYrCZE7F1DtvWIsxvimRk=;
 b=iGwo4gnqfrjl6q3znxKBFbNhOjoBRxGvxYX2jVFd93HZ/MifW7EFo6LX0uJRnO7G6ksujXlnau6KraphdRrvP50OK9pWEpOfQQTU2J9RDQItTAdqGOmYQi/DaXmAmgkCs+wCaBt5l7ik8h+R0X03Rxqnq6aYhobYi0WgUVJfqp7A71VivH/SZxaf7im3Pnkv8dczO1tIsQMyDd9eWxBJoatEhoLimz2lJ0nk8//ChtT5GV8ZHFqcmemtrjoV/OJ7ypEp141jT6Bs4DYA1uu/kgwKWKc9kO/yNLiZPHbe6Z+9P40C1SmxIyJcKAOPinmO3zxEgsqsvqZRM45cpjOkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEY5jKJ/ZtXF5H5xis9ByUjYrCZE7F1DtvWIsxvimRk=;
 b=AFUZtYIsiudqs28G8+Zp+84WKO84SKpygRUhSsd/cASsSYeMvN7DuxyAQ5SlsH4tbQZ0Qwg+Qcss60McY1Dn2FMAgazvd0tlUdmd2GDduXukwcrN4FY4uHplr+yhOYpYWxHbIH2VyNXTjhVfi+CTk2mvRna+GCvLgleu0bXDyhc=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 15:18:44 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::a1) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 15:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 5 Feb 2024 15:18:43 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 09:18:42 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: only call sysfs_remove_group() for eDP
 connectors
Date: Mon, 5 Feb 2024 10:18:28 -0500
Message-ID: <20240205151828.20716-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d9dc59-a89a-49bb-b189-08dc265dbdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5MD9yymxCiMvQsmnuCqP0pAZjKHN2gELZVS+OxLIdeFfNxDXEA/DXKN54/MJOBEvydVGhEBl4zOk5at/YOD+O7OJeX3/IjN7QLFzV/+p6YHFNvpHWJCejGEw7zE3QNXSN61/NWlICE3bKPiwKRtdUxbisMoPURs2GuzOOCw9hZdS7U17OlzwXjRlarsGkEu4M1GT/VhFRXBAEbijflszcDvLLjCscayVaCcTZFTfLDjMLdx3MBMn3oLZAyvVuIA3griHnbA5/SiklH3xZN+3qHoAmYRc0hR3r0pHUdBZ/Z+KcJRh/kzGoAjo7MZO4P9/jr22Qg/gc7Te67ZkTwegNajL43kIXREW+Hoq4xf6dWqzpwRg9ytnAL9GwEmlSNgHg0W+q31ywLcT/hri/PEocd6QwloaetktvcgUsFxWxuQLqpkO63jPCQUthfXMrhucHWMjbEsZ6jjnD6e76F9VeSO9EhgOQr2HZ+zsmKamJfVY7O+52k6H7220QlvmKS3tVkthfliB3kHqwQRnSbqJOi6RCVVy2GzTr7N/wzGQN2XAnYNC7UPAoBWQuMEy3kZQdIUoj6WkcgNCAEEmn/kbVe9/GGO3E0A3fFtj6VR6xFhOyPrLuH1An/HIkLOHkNeXP9LWWfEPGYeGhlAUd75o4qGdpATy/i8FmdhOXuq4NFmmz7fea7Bg+Uqyxo9AtqJ3OYGFmsmKyt2ip4BH6qGUiLppi6+ajsvwpl4qlht9M76fjSY/lnfRpEcLTy1oXX19j/Zda3ij1wpRdqSjQC3HpWs5YDsFfuqFyQURz9CQN4Cf5tgz12wRIMeRzwjviG+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(6666004)(2616005)(1076003)(336012)(426003)(47076005)(16526019)(26005)(36860700001)(5660300002)(54906003)(44832011)(83380400001)(2906002)(478600001)(70206006)(316002)(70586007)(6916009)(8676002)(8936002)(4326008)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001)(40460700003)(41300700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 15:18:43.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d9dc59-a89a-49bb-b189-08dc265dbdd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

Since we only register the amdgpu sysfs group for eDP connectors, we
should only remove it from them. Otherwise, we run into a harmless
WARN() on device detach for all of the device's non-eDP connectors.

Fixes: f97e4303da16 ("drm/amd/display: add panel_power_savings sysfs entry to eDP connectors")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adda423615a1..b3a5e730be24 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6508,7 +6508,9 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
+		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
+
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
 
-- 
2.43.0

