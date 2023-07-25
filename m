Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79876C00528
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 05:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AF210E14C;
	Tue, 25 Jul 2023 05:46:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E825510E14C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 05:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/BFTfpsCbhppKkLzvr4n9wbWagtH6fx+ypwFnwEfm5cQRxJtQhs7fUu7hsKKQaIszgxCjQFdq8cVPbquttCzKtw7xEdSo8BPriYmI3Vlm3wpwTOxGXPz1FKs+ITEGrS5u9AGVvaJzTsQllaoNnkNNFDb54A3hTpt8de/4/hhDakZOI1IcSvIy1Szr03PVMSDAGUagmT9C1xGyu7hCWDdT7wYZBs9+jLULMyMX0bf/OvN8iSKGbzAEMwr2YuxxLjh4szZ5VkNqtyTs5MeRQwnzmoPBg9U+1HbKCqMwLeB5tJBB/OH61qjyINfLJhx2m8snRZ96GC+cwIVxW5XDhxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM2uMt7vM8T90Az5iJrEphW7Epx2pmu0F1MRm1QrSzc=;
 b=HcYqT6n77MNjslL6Khb8OViwpgmyu6BzH0jZqGFdHxt7T4D6CWUeMFh3kzN3McKyOIZdlSOi96PYWdNE2crkqCf25DECGDpwgrrgRCA8CYzlzDpzAr+HbPxOb5UR+i+dIopZk+8TJ08XxipUiETdXJdGnijpf1rfbbqUVRnFfAGdxfLrlWwQlMZSt6ak6ng+7fP6EHDx8/eypN9qOXyHbrB/hEkh4NDEvFmEI8viT39TGmqtao4pA4a+FWwIvuWmpcvp97PqtdZ6/I2kJ8Xkv5reRw+JCU/Z7/I+mpx2N+RvGaNfCtQlxLZFX3dnAB+MEWxg1WqprASjue7aOARCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM2uMt7vM8T90Az5iJrEphW7Epx2pmu0F1MRm1QrSzc=;
 b=5G29sUa+adzhE9+WOKJ0GXqW/27q2fXhWv3VsV+eOLpVx4s7hztETG9uFQGDSsmjQf4FS1fG7l2zpUWK+9/mxy1Pwajv9MYlAEBuXd9dZXM/vaN6ZDm/mKkYcwdHIb21dWQO4aZqx5PGQv6SVmOgloybBQNOekn3TJaW3qekon0=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 05:46:13 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::fd) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 05:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 05:46:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 00:46:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Restore HQD persistent state register
Date: Tue, 25 Jul 2023 11:15:54 +0530
Message-ID: <20230725054554.3188083-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5287011a-14a2-4e78-6b9e-08db8cd274a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWfc0te+L5MQh9ZB1MY4eEJeZsn3kDFjbvP3jCZ/dFacj5KNY2WVHdrdLBvH+4tp1VlAfBbJPGhugN6b2kiTTWkaYQzXcMonslWfnEbtEBGKpKXW+jhJYdKQ73JgtP74uNHhIOXysCG2sEwIl19PUhJdA8mPReRrjaxC7+Eb5J2KuPxM9U8/ML3dX5A8NAWLa+UBKaobAw5AvWO99wJiJHc8A5gOeOHEWVsCn8+dKBj6X1YkbYmWoZry9YPcyuHIMrZ9ocSo3sF4Zz7CsR8wzIkIgkumQgMV3yq+N5tWYcmEMHUNOMBaeRVWWFc6kv85hwqUgTuL3IW+GMZRc9muLCcm/7ZHJV6G9R93QLZut0ASgy79K/IUe0etpKw7qvp1vuaE2mWtatbxrzj5KgxIs5Xr7qCFVcSaXS2IVtEfBsqcw8L0+84mIJKNkdz9+5p2t8ly2vUQ8oxRAT8Pv0/gpffgsTgcsb8rUR9Ie0ABSEP/krqn7FUFPcnSZ2otsX4plbFkUWmnnemkDWFVxMbBepIPtCOD1pGllQ2/8Nlt8+1X/PKuJpslzrHXgDZrM112D17drrl0QFKA8P/LeKJAq+7rMCJw0BWkbyprNOsAiVcnAETLnDzYRR+IrlXxBm9wdIzUI6RhF7DKghP/hWNKc1oHokbml2UHgFZfAhOFWQRPDEwqsejpHQ3mX9K8cFQdNp7xU/qxkGzxBG0s0sT5hxdmoskJoX2jw4O5bit6vlYA4qRFbPU1nzvqle/nvloA+JXCz7nC2A8FcF8rgHQviA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82740400003)(40480700001)(356005)(81166007)(40460700003)(6916009)(4326008)(316002)(478600001)(16526019)(41300700001)(70206006)(70586007)(44832011)(5660300002)(54906003)(8936002)(8676002)(7696005)(6666004)(2906002)(186003)(1076003)(26005)(336012)(83380400001)(36756003)(47076005)(36860700001)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 05:46:13.0556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5287011a-14a2-4e78-6b9e-08db8cd274a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX v9.4.3, compute queue MQD is populated using the values in HQD
persistent state register. Hence don't clear the values on module
unload, instead restore it to the default reset value so that MQD is
initialized correctly during next module load. In particular, preload
flag needs to be set on compute queue MQD, otherwise it could cause
uninitialized values being used at device reset state resulting in EDC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8b361aa87d01..306dc6533397 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -46,6 +46,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 
 #define GOLDEN_GB_ADDR_CONFIG 0x2a114042
+#define CP_HQD_PERSISTENT_STATE_DEFAULT 0xbe05301
 
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
@@ -1726,7 +1727,7 @@ static int gfx_v9_4_3_xcc_q_fini_register(struct amdgpu_ring *ring,
 
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IQ_TIMER, 0);
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_IB_CONTROL, 0);
-	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE, 0);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE, CP_HQD_PERSISTENT_STATE_DEFAULT);
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, 0x40000000);
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL, 0);
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
-- 
2.25.1

