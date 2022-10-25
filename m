Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66620FA373E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 19:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0072110E161;
	Tue, 25 Oct 2022 19:21:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32EA310E0DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 19:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqwRfYGwdDAN3HZfLEFAcujQFIkkf16euN+uU4VJ+3OH1xzrAzx+xlqbRSoUflDF23AvjmMbrhaF4cdH7l9HdpMbYdTppb1QkhyVK6gHtYrskj1hjJSAOjUqprFs1P7xnyYoBY2R0cw7IShecXO1RBoM/nOCUpGq2Ga1XMU9n5rHn6djp0y+G0x1Hh1qqfWHVQJToYmUl6fCRJnNjOtvTH6nIpNk/gfpjmgZvsxWmotZltebUHLc5QzsJscF/g89Lo0VVMkyyOrdG5pXT6R9qXxla6J4KmKb1VViqsy2ToMZFrVmMIxeHE2vjSc/rrV9Vw3swFjkMXnZ1raRbtU7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2dGRcRvsoKf4Xc5ZUgstgCsOyeI6o8gZBspcj8wdEo=;
 b=L3JI/xJQMprb6KsC6ru/3Yu+872tkWXISdazp5D5/5QmsBhlxe/tHOVF4YXOkB0dXfO9QOzMPqLrr3YFPQ8NqZoR2WuOmW19QQS/QpW1EyvdyCi4Tw2Tqat0rF8qyzYOiUQNeVkjQz0OXsj9MHYeIlHZ+c6MR4TG9auePf6xhjcXfJKa66CMVkk01CHF7u7tB9JY1XZf9ZNbCuczg0JmrpMveHTX4rsUltgZ5/PBd+q3BmeXvylhj2b7MLp+e0uiaCBQcxI4RUYZ2lH2Bx5sfLX+0rKuFAWWOujrEDHiN9aLG05RNVjJm5hzdGUm5iKbKA6GQSfcupT31aAnce4MtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2dGRcRvsoKf4Xc5ZUgstgCsOyeI6o8gZBspcj8wdEo=;
 b=Qqph6Pl35n2sHbPESdsq+D00iJVWS9SQdusJgoOCzlSb01Na2p4yYR2ghr7aJmezLHHam5PwwM88qWwa2/kPCq5bp7HlBcssf8E+KinPj4q6fU6Atp4q52nBp1rp9viDHn2Lqilc3Ttq+PNyXfhuAWwAW5IfRgj0qmFmrpk6zOk=
Received: from DS7PR05CA0106.namprd05.prod.outlook.com (2603:10b6:8:56::24) by
 CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 19:21:24 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::24) by DS7PR05CA0106.outlook.office365.com
 (2603:10b6:8:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.8 via Frontend
 Transport; Tue, 25 Oct 2022 19:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 19:21:23 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 14:21:22 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: correct MES debugfs versions
Date: Tue, 25 Oct 2022 15:20:55 -0400
Message-ID: <20221025192056.647389-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: f0375643-fe2a-4b0a-3d93-08dab6be1aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iWm3jRacci6xREkTL7/q7hiIGi7hQHjYekrg0zimi8tyILtIzpDLNC2vWuHmAj6OOf6CbpUZiq4NJXuww5aWqK6PY44auLk7pcVfygizs/i9zUgZL1DMk/mrd0ERsG9h7j1WVsb7ooMK2guKp/t5bbAD4mWJY/znd0E78IKqZp/YFF8pQGXM5hWkL0Ckk8K3pwJHZba1Ga9vlNGKzbXtvKR5NvXbzqaOefbX+gS3ApGmnHcs6EWvdoQKd16MSOrPpa5UxoNBr6ZrWlO7tZMjXFeEoa/82o6jFn+YcsCj328aB9C8fdK4+usbZFG8fwbqMYu4v+lUI81YmhJdD7PmnmMOvyegYbapjrJ9ikkXjCDBsqSg3NQrJxmgEV8127g2RwI6MgyOORVR3ko0upoadPeknJEcWPTv+9eehE9ezoX9YzYX4F23aBh8WShfIn9hxaIIW7HLxoKtokZYNeQtCaMmV5gB/VWrcGBTx3GSAP5aJ6YgIiXQT+YFkuSfwFZ2l8pnIdv4ojhFQRZBSJ4qDqVDpP00B70MCtRxg5Emx0OnT9YuicAinr0m7/ks0965vUxVQqQF8ZALW4n5oIoEtER1KXvQR/nPnDvBiyXrCnVAimPpbx3hBB9OgGAnnj7LuzYRT2Hc2k4qMjElIWhjqpp+zAfHFD9euANTxqTWcZvwO1+5HVuhamCilw994PmlCsB6LQYkgLAlhc/C/hwVtrQVyOJp0gU0CKPprZgKj/kn/kht6IGvcYbHQv1GdLqDdy3Ly9Yi4YM/Jd9PuJoCj0hDvWJ2OaPDWpKd2CiNnY0mZawzq2qZv1ps/lUAXuC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(26005)(41300700001)(5660300002)(40480700001)(6916009)(8936002)(70586007)(7696005)(81166007)(36756003)(4326008)(8676002)(70206006)(336012)(6666004)(36860700001)(82740400003)(316002)(356005)(426003)(82310400005)(2616005)(47076005)(186003)(40460700003)(16526019)(2906002)(54906003)(1076003)(86362001)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 19:21:23.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0375643-fe2a-4b0a-3d93-08dab6be1aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
Cc: Jack.Xiao@amd.com, Graham Sider <Graham.Sider@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use mes.sched_version, mes.kiq_version for debugfs as
mes.ucode_fw_version does not contain correct versioning information.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9c86a122eed5..363946de78f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -337,12 +337,14 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->feature = adev->psp.cap_feature_version;
 		break;
 	case AMDGPU_INFO_FW_MES_KIQ:
-		fw_info->ver = adev->mes.ucode_fw_version[0];
-		fw_info->feature = 0;
+		fw_info->ver = adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK;
+		fw_info->feature = (adev->mes.kiq_version & AMDGPU_MES_FEAT_VERSION_MASK)
+					>> AMDGPU_MES_FEAT_VERSION_SHIFT;
 		break;
 	case AMDGPU_INFO_FW_MES:
-		fw_info->ver = adev->mes.ucode_fw_version[1];
-		fw_info->feature = 0;
+		fw_info->ver = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
+		fw_info->feature = (adev->mes.sched_version & AMDGPU_MES_FEAT_VERSION_MASK)
+					>> AMDGPU_MES_FEAT_VERSION_SHIFT;
 		break;
 	case AMDGPU_INFO_FW_IMU:
 		fw_info->ver = adev->gfx.imu_fw_version;
-- 
2.25.1

