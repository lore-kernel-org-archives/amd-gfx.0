Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F757C54766
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 08:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C8610E1A0;
	Mon, 19 Feb 2024 08:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ViVwrTs5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C5A10E1A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 08:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLcW8CR3ZzrTlqz+9c84JrXdKW61eAE+8v2LmGjAPdntElUcw6T005wmEYbnn7HpBEpALcmzcJxhEVcGKa5DWE1Q5y0WICyPleVCu8GkdjcRerQXtOy6Y7fXaN0RS912NlnrhQgEXppZnt89KPJMu+6Fes093JkWa2yAhd7uOQcjGXElYnbTsfDic371SSgq5/X28/VJNnvFzK3+JxqztsogTnlsp8TmrmLWbmjd7j5tLCCVWl8oPW5W0W5EWwlpyhYyQjv7/yT/goT4yX/3pJCqHYyfDyuuC3DFm6tm2Jk6Td4iSjMFHbpWDz7YcZ7G+LhPnL34FXgmYzhiMbInrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGYUdkuU6SapPjKjXpQcCD2k44MooRodoqlJ5oyywkQ=;
 b=QwNhaUcsnBXLdjjI2R1B4HbhdT2MRaIAouBCpDnCLtuYr5m5HB25Ad+1BKkFEYpEEDcfOw4xpToPFwa3IBUmkTVXZmtalwDhQiBQME6QyTACM4TTpSBfI+pKfZuF1pvDe8SvVMH5A2iFXdTi0drDgECbJGSm43WqY9741p4ClP9xG9KIryxtZhd60VvUsuVElstkROLmHuQjiYAIrleZwfVy/71BbMQgl8wMp3bJoNNY1oEsGJsDuNyFUFIM5i0KL1VOSUZYCLexFOlwPmuEeuNH4GsH8x0VStYKtrd4ybHUeScpfuTZ/MIbRcw2ztIzPWXnBPCzhAu5PATNvo4SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGYUdkuU6SapPjKjXpQcCD2k44MooRodoqlJ5oyywkQ=;
 b=ViVwrTs5ye6elfNdi1wn199zfOiK2a2c0eFBQxqh6LHBqps5u6LLU+EOKJTB++e4Csp9mZWC760JC/Dm9YLKTEZxi0aH4DzkaazbvA6jS9TgGhKs3tK35AHxsw9Wx7lTcxZDJ0hr3ggyKtAp1zr5T8ys9I0tPDlcYBV92ao1e2Y=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 08:15:37 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::3e) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 08:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 08:15:35 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 02:15:34 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/5] amd/amdkfd: get node id for query_utcl2_poison_status
Date: Mon, 19 Feb 2024 16:15:19 +0800
Message-ID: <20240219081520.316064-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219081520.316064-1-tao.zhou1@amd.com>
References: <20240219081520.316064-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c88618-778e-4aec-5430-08dc3122f34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hcPfaUsi2MQTRhZ8nKEK+hkRwsK8iGu+czfPJeHIqqPcEZEZamrR+BxSrlAaMzbgVWejq1MHaQcLPoTvjSiRvms2XgNly8lE250yclmEwxGkFK2HVlSluO0uQGQKMKz3rvj8q2pV0zHWu0jHP+XcyOgsEcqusw/1Bzr1Sm0a+1KEMX+hjoMkb6qGRcXC6RBtwSJT6UEuD7sxtMaZxmGmnAUqfgdxOpbr8dNMA/4K5P6FVRYfzdCt0filf8Cr3BqcYWzNRsmmUbChXDgbuBxewN3XTbeK2vhfSYQ1YcLPYMSDTQyQvUWgUdq1js9RFRO10Dfk71RU7Bs6Q3xCYL74FnEz52WXPB/ogMDFRl/8W/6jTqO9G9mUGA549GTRvbuurTHT1LbzLPRVSORXMLsuljwLSIOvA0RtFGm9BZLGGpSBcOMe0dyZ3z15CgEAj2XRZD/sOaWuU+/1Jj55v5fPHpuIVawWY1bHSEJenwzqClcIVUHRK+p3DcTCVLurjYrKfThqsu2U6FaSLyJIbd2P0bdvGb6hd+41g3PH6PefK6c4pRnLw0w8JlPbc0GeFtu4hYoJQtXax75z3O7wWlZ/0aCNxklwhHMqvEFrS9cUc6sUpKj/9mH10WMAPUIo9Pp2UnM7FLh26tw/YjKRA4HDtfN7nyKW14/GDTOkw85s1s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36860700004)(82310400011)(40470700004)(46966006)(5660300002)(2906002)(2616005)(41300700001)(26005)(1076003)(36756003)(478600001)(16526019)(356005)(81166007)(83380400001)(426003)(336012)(82740400003)(86362001)(4326008)(6916009)(8676002)(8936002)(70586007)(70206006)(7696005)(316002)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:15:35.8901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c88618-778e-4aec-5430-08dc3122f34a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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

Obtain it from ring entry.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 9a06c6fb6605..747cb785a7d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -367,10 +367,11 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		struct kfd_hsa_memory_exception_data exception_data;
 
 		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
-				amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
+		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, node_id)) {
 			event_interrupt_poison_consumption(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 91dd5e045b51..eb94d967c532 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -413,10 +413,11 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 		struct kfd_hsa_memory_exception_data exception_data;
 
 		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
-		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
+		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, node_id)) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
-- 
2.34.1

