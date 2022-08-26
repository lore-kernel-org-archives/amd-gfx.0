Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA64CECAAD6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2583610E114;
	Fri, 26 Aug 2022 18:45:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE71910E114
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4cVBrdM4c7oMEKNg/Fi/6DuJk0Az1anlfPRYsB226ptx2n2qWZsk4OPLRGqRQDbHiM8KAyf6GWIoTyjiPRJjqO0eQqzmv/2PqqPvFQUlGFDZ/Bm3S9aYo56dr6mj7oHlRFlODPzY2PZt7FcF8A79LSY0M39Ea9LuTQ5sEC0Vfg9JQMLDZmJzIv06AI6WL+RcuYGMudQGJEhMhiT0yEfptoMZ2LX3ElFEkBPk/66/uhal7C0hq75fmKJ14S/IU8tTVBkdi/p0CtU0Wl7xCRI7sDGkMyIlr6+NUw7w7I9sjVt9hvf+VQfG4faDILbKdFWGftcMQar7fouNN2n8Gxqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uiyk542Pb9KnNppiyNo3zQQ9ETySJcBCDzE4rxTdXKc=;
 b=kobhHl/oLuEEKXMvvEU+GRug7QwM5iaLhyhRwiuCVrpaWRseSFqQy/Af2NG+exNivfyp564j7mmTsbmVIHma67qB3914N6yID0B+tpzRgF8S8TDWh9TotHPaIKkU1gWQQuQjXuiayqy5ax0iZvnry9ng2L3fMFvtEoOhJd5GyhTsxmkZhPimRI9S+zH6VuWgU8oWtZzwhOGI6Yxa25D2fqYKaRETZW/V43M1U3KpWSRaE8iq2+vNbbg+PyykX5CJKM3kMpZ/X6KeV0EhANGQthviTuCCpz2mmvjoU6eBR8bnPo1Dntvc51uz88BGoffcYDmE8syofPo3WiwzTk3VNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uiyk542Pb9KnNppiyNo3zQQ9ETySJcBCDzE4rxTdXKc=;
 b=jm9l0d+s1fx35IfpL7cxMd2l4fKdlsl8RabBZLWCwr6hXDFSWJhcZVyaByJz5E6hPeWaOj3m2pNpAgqxSP8Nt2aGhuJbxJ5S9HEeHbxfDDyfMHdBIhWZrriS8XYzMTpMHK5OaQLbyNkWSoEHqTdAvIz2Fs1ygpVzMLkmmwB0OcY=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by DM6PR12MB4652.namprd12.prod.outlook.com (2603:10b6:5:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 18:44:56 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::f3) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:44:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:44:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/pm: add smu_v13_0_10 support
Date: Fri, 26 Aug 2022 14:44:37 -0400
Message-ID: <20220826184440.855532-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53528ef3-2818-44b6-1201-08da8793122f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4652:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/7vMnFtkgU9s60h3Lk0krdxtOGga9eI0wZtPfXX8QLz2lqd/+28uK04AEPFhYFsSs7T2lWe0qH5jnnmqN5p2JUObtfNQVdzs05JPqtC4ydBipyVarb5YOv/fcaOFjhau6UEkbn+44WC6hSXcZNWu9S3noEXD4LIa/Uy+qQt633SCZSiD6Re2NbAbt9cEf4CVesOPS+du8Wqp3i2cmTOMIwQq6kNB0fnG0dhOHUe7ktF3eMOOxrfPX539xyYM+0Mwm5oEhXRrinzwqi+vGhaULIMwjf8iAFH3P1XTRX2kyQBLLOeJ/0HF722toqXq6Jl8xT9aTLXF6ZouWwRkgrXTLijM4KycfCAQYzrfMSt7CSS4SS2tFdHO1JM6wF8K2vL1nkgd2EjlpCaax9hMGlIgA2VMXN8VqBAnIwl/YM4ydyeQ4sOCLxfskKZ5zS9hIoPiJoQhcvZ/RlqTFpS7R/WHHlm0bkJl3scGOQ4IRh16Rjhs96hOhKvF6j3+YdQVwfES0ck5t5IXQR7VBZgYqHWs2aonCfJgFCfzsTMCyD++NADWfoycX241VADsTQrzHY3re3vymwo+mYxP41l3kl1B2CW3r0SGxMEXpH4XrvGFYMZSyv7bXnwbAN0OJhnWnJkoQPcFrb5MFATDfgQDxbneaeTWq8RNweF1oMIxI1ao914wdXUNrh9WaJp6Br3xzpKL6N/gU47rwbbkNk/h7XsGVDBCgb3sce5aDcng2BqbIXAyWKNpndsgQIYyeV2drMVRrrtEFvRyngRN8nAaCHr76r22uPhKQj//m+vWjVnIr40biPbuhk1jw+VhV2W1Hzt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(40470700004)(36840700001)(81166007)(2616005)(16526019)(356005)(36860700001)(186003)(336012)(47076005)(82740400003)(1076003)(4326008)(426003)(40460700003)(5660300002)(70586007)(8676002)(8936002)(40480700001)(2906002)(36756003)(70206006)(7696005)(41300700001)(316002)(54906003)(6916009)(26005)(86362001)(82310400005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:44:56.0582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53528ef3-2818-44b6-1201-08da8793122f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4652
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <KevinYang.Wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

add smu_v13_0_10 support.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 55b7910b4385..13c5c7f1ecb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -605,6 +605,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		smu->od_enabled = true;
 		break;
 	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 10):
 		smu_v13_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(13, 0, 7):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3651f6f75068..fa3e5d1d1d2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -59,6 +59,7 @@
 MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
+MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 
 #define mmMP1_SMN_C2PMSG_66                                                                            0x0282
 #define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
-- 
2.37.1

