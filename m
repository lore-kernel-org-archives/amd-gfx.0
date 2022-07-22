Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88779C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 02:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEDA14A695;
	Fri, 22 Jul 2022 02:23:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7AD14A695
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 02:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhj+VgRjbTrTfP2G014NZaEyhWFMpfkQYVMqy93xs/LMd0uPtnljCGuNWufwgBbCrWQpfoBvc8dxLFGLzAphpAq7SiJGpmz4oNnD1u26Zh9gsNi4/FwR9dqQLbu7QFrzI1+e8QLtXGOsCIajMvWViqefMYq1axPhDjYMNzMZr+aqFfmvs/SAGo69j8eE3ToppmJNg/wGVwERiGF/2dX3EyaBOql+XanJ3d5HRECkvAgglTd5alhGZgiFi/RK2CYhXYSiIV49w9B2VqGV5NfnLNwva88Yn5AGp3/q+qEj76Ad4luwgNgt156X6g4FbwOpUW3B8rpO/Hsu4pMwtLvDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I949F8N/slLAwDM5u1NpZOdT0eTKTMsg7ZVoNW8kSU=;
 b=Scb5zUpNihpPYxVTyQEy2U2ufvIpqdzGkLbfIAdYWmjr8ZBMP38ZhG0b59kiwzkqtpfqSedz06chn15vPnYPvZ/+VG2HADhu+qAk/yWHzMdjQSB8551ndIJ8tU36HNfXrp2U2QjZc8+N4RsKRqnBF61DSKU6W0AesLO2241qdu+TKMVzJtc5dIAw7rEwretKmznr2ujpoSibwsS6kTvA3HDGecgO2HSyJf/NRJWgyDzS4XMOg800gwqkeX0s866tZE3qzjHJDXlKOS4zRnViuedez9QeE/SDSfzOpjWUPiIJqbZKAY1BpB2+4KLCG0Qou/Yt6fzRIDnOFgQsJIGXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I949F8N/slLAwDM5u1NpZOdT0eTKTMsg7ZVoNW8kSU=;
 b=SgdDDLZeyG5J8n4TIa1jIW1BKXPteNNjiVaiST+/GUq6n05bcR3LCc9c+0s6jp/E/nv5GtXYeyXPiYF5LG8t7Y9ujdwwagPcxPDLtvmN6uMXIe//gnZ5YBg1j0Jq1nMp7LZmU6El4QZGEQTTCm619UmbTt6Er1UA6I7r3QhIUeo=
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 02:22:55 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::4a) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 02:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 02:22:55 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 21:22:53 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable swiotlb for gmc 10.0
Date: Fri, 22 Jul 2022 10:22:39 +0800
Message-ID: <20220722022239.728988-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6499b853-efc2-4768-e128-08da6b89163a
X-MS-TrafficTypeDiagnostic: IA1PR12MB6138:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ac+da5hvvcfEMDit/wMZOftYXYdsoFF3wtbtoVCNdXcDC0YKfecgjZ/qg+VtvcwnIMP6ZtfpMrN3zisWl7wq4OmaXrxxHEnITUf/mivr79f6566cwwrNBl2MIhBkx6GegHrRH/uBpVMXz7nNHPXi/t/rcz3UIQYQchnKbpCba3PVb64DWE1gg+JvGTsmv8wvGUvG7U4vhmX95NzcubisV0GJBQ10txKerHrVhoECXgeKGUG3siH4u2e4sHTe2GGjPM6epWXi0iiT8k/IJgFKHnpfcQE5RrHzQMrXaIsY11y7mErW+TtaB0enUWZ05nIhOCnZ+mKs7aC07kie1kj5p6u+sduVfNvKKgIZtt5SfZAAPgkBisb2QDoiwh/DsVK4EaOpy8CgfNHr0bTLI1+PUDf4ColiPiGw/hlcb2bvWwyx6kI0cFSXlaR/3mBxqLdkP+nrcHT3NJGpGp+sQh3H9F3nMH9aTrBaYI6Q0+NB5xQ8wp0CWC5IaXB6J400IbANpQvrZXA1JdCZIIQBTKRZQB6mN4rKeaBgxMrmAA6P/pUWNsFnVtMv0/0yJGcJDo2jJ5fZ6d6jBIztIvjgpsBzs0kW2QMExWTpwByETZvZ9g7gG79gTYM4BLycLebXJVFuMXOjNsLUa+/1JCH5tYo3tDcoCw9WP+1kwh9topWG+lTKzYRfJlnhPAfCtPBx5+dQE6LiSmMUmyE0lH/T+NL0phvOQZo2Ari276tIoFudQG/ewumhNevfNVX5ipxzN2DYxTcZ5bJJJZqWINWxVA72/UOQibA6Aqo1/SRPnrUzYUIM/3QfIKBIXAu7jIMTOobugJpwCiQHXyoSNuf6VpGrfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(54906003)(6916009)(8676002)(4326008)(86362001)(70586007)(70206006)(44832011)(356005)(81166007)(4744005)(478600001)(316002)(5660300002)(82740400003)(8936002)(41300700001)(2616005)(7696005)(82310400005)(6666004)(2906002)(40480700001)(36860700001)(26005)(186003)(16526019)(1076003)(47076005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 02:22:55.2589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6499b853-efc2-4768-e128-08da6b89163a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable swiotlb for gmc 10.0.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6470290aaf7d..a1a98c7fe8e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -967,6 +967,8 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 	}
 
+	adev->need_swiotlb = drm_need_swiotlb(44);
+
 	r = gmc_v10_0_mc_init(adev);
 	if (r)
 		return r;
-- 
2.37.0

