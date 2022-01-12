Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4C2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 07:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C6F112113;
	Wed, 12 Jan 2022 07:48:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5532A112112
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 07:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjVqO+7ZdWgUNlZpHBU5ssiit/84V3N8fdlbkb+TJk9VjY2jonoXM9fp4kneNIR1BBO6ehHpetSdBsab08lvxcMnf2ImtD0xfwjEwvqqV1xlXMy8Mryvl6NOgYsfjcD9BCiA2AF9YaYFxtnN8TblWrCfANE3NooS01sKgsSV2uBw4HlSCVP8vIfgVaKTCO5Mvry4tIyRNuYA2yzaPViXar1BY7DEnHtiIBMClIPGS1SUyg/e1ZNpF1pqFcZ+D0o9y0LjkcmiUQhD7qRb3QTLkwCM9e98gKONYTqTEqmPlsG5j6+B2ezcMSCb7nCFhMJo2KV6ynmV+oJdhISR5ZqR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2EOAD6XF2H9HfWfAy5N6FgE7y8vJOBwxI8sZvbRU6k=;
 b=Vo5v5ISw2F/8XAjNWXDyebQ8Y2txa8FNJPEex1MG2hqfa1KbtvZaDJZ4lmNCTTNXTsIiTacg3QWLfg2Ns3Gb2nq1hweVfydjiKMu+JqY+jMzpnfLdIy4IxT93EIC0nv6Ul31ysK+meTk/afWuDTxtcBEY6nj2Nsbhv9LShsdeeauD1HwZ254Mp2FTKO4QCn9+bB5k7QTbB1J9LxHKz/BWFrvY8pd4RsCVF5ImlGpFTNnLQPgvFUYt7Pl6PqeY3TxReJuQKXErlwcwD6yF3Qe1au88f+GHfaQarspMHPLH/6SfWDzfDEbasfdflf0znsMoF3b0bzOKRv7SKnOJYYeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2EOAD6XF2H9HfWfAy5N6FgE7y8vJOBwxI8sZvbRU6k=;
 b=OQ/kRJED4vYZdIPusGf6U4FIpbXUp6dmYQiz8OPDie6LZkNjx+88R3rR0AcNr1U/ey/zzHhuJakI+G5gHlPTbjyNPn8fim6R9nAmS42CT/yEOIEs6RgLWD5/bQEbSyGOH0timf1DOKdoTIkbfsKowJnYYM0p08zQJ1VGVgGx2A8=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:25::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 07:48:39 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::91) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 07:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 07:48:39 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 01:48:35 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list if
 it already exists in ras_list
Date: Wed, 12 Jan 2022 15:48:02 +0800
Message-ID: <20220112074802.2867813-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d36fe6e-330a-4e22-003d-08d9d59ff26e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2593:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2593A571CCF095EE3DB9E09DFC529@BN7PR12MB2593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFo0tydZB7HnYTlhIW0E0FqurxfNRm+WEmVUbjWImEVBLqOnsvOQE4iw0/61fuVunQeDMIQPXdcUacHGk6ac7RyNpaRqRyhKNDTLmJZU0Qu1a0lto2NmQ67JcMINGMEDNhIBg+26R7nhJazV/ugtHjedTry/4YaRK01WtB78VoYnCI8HzuCAUHArawXLq9QgZTvEv5KPaSM0kf8/StKNf9mWvzRznhB+eVbDBfirf5x9/bl2An12wohX3tb8ihOcfex4IPNIsGrvUbWV/O7ZmZ3RT+jKUXq4j4+wf6GwkVVmyylcIXBOURl7AkLkNMzocwqMYRh7aVsoxXpSvKOOHabMLQw4GiayXeXka+B3hj6V2qK6PIG+LVR/jNwAQU2wtPNNTQ9nmObU9cfmuePRW5mbIJ6X+Sr2rvzN4gjZOer59yVL4xMtwX0kIjjNkKwVrjXXXTN9QcYjyY2EvNkkyZ6jV1B8gu8Wx7L/NwHsNIgnrQtUB5yAumauQg0wzPHnuI9hX5BRKyYSf+yCIhpTehM70anQF386c+zemXw9Cmdy/8hkD3KEmMwO0WRF8llpLlACjlaq9ooV4iSgtL6tpTuh1HzMRC4O8JC6b39N2UVpyk/jzihn5Tax3CwnIunNvhTVbxYyV92FSFhuV/cvx4cxO34aGi0SeWCLQi8Jh5z0TU4tJ0MAoWOaE2EHUtEp9bwW5zQ/ARMjf6rvB+dTOi1SFIQckfbJ65LuJaxk5WV5AMFSlX2Phsw8s/b6Bo4j71SFpr+CNKnTuyaCUEur1+MHe0SJgTP/b7U0aWBBIaWiKokg2eZ244HjhefgkzKOaP1oaZE1281JngYu6H5qYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(356005)(2616005)(81166007)(426003)(8676002)(1076003)(70206006)(70586007)(47076005)(336012)(5660300002)(40460700001)(83380400001)(6916009)(36860700001)(54906003)(508600001)(36756003)(82310400004)(316002)(8936002)(7696005)(26005)(86362001)(16526019)(2906002)(4326008)(186003)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 07:48:39.1572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d36fe6e-330a-4e22-003d-08d9d59ff26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2593
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer insert ras blocks into ras_list if it already exists in ras_list.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 62be0b4909b3..e6d3bb4b56e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2754,9 +2754,17 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object* ras_block_obj)
 {
+	struct amdgpu_ras_block_object *obj, *tmp;
 	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
 		return -EINVAL;
 
+	/* If the ras object had been in ras_list, doesn't add it to ras_list again */
+	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
+		if (obj == ras_block_obj) {
+			return 0;
+		}
+	}
+
 	INIT_LIST_HEAD(&ras_block_obj->node);
 	list_add_tail(&ras_block_obj->node, &adev->ras_list);
 
-- 
2.25.1

