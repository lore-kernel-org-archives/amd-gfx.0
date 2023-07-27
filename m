Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9544EC001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 09:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AA910E55D;
	Thu, 27 Jul 2023 09:50:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C845610E55D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 09:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF3rhHkuZMapC+CapOd5Ft+2WgHszEid5ZW7+ZxjV+4oPfuQoVTCnfytyuf/dY+LkG37sWMqJTmUzmkckI/AY05TTslklPA+5oT4K8WtPRPBKwAGOViAznkAehjBx4oFivEsHbJ7MkHk9LNG+jPrn/4Ctuj35eV+7ajrjWs8UM+IoXMNyrcUXbgmTpjbU3yAbToXVS2rW9wsShVx+ff6/+7Exrt73fqx7GFSPg1L/lZ4nWm8bsMad0IuniszbWWaoRzs2A9T1fk0wYdhuqJ662R3gE+adaVPNMj5xH2KhcpT4B25GOneNrC6V6PbA3uc6eExzu78H612KkULftmtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3gKz8yZkQabp1uf207NgjHJwE18p+YDnq5so7qwFRo=;
 b=FwPF2/nSsgnB1KkXXxvMRBU2bz2JhnGxRuE8q41mGPTmadewb2IAcaNUZy09V3YlJze3Zv9p5kqhrQFbMK0vuCHqA0JutapoYZaKZ/HWx6hyosd7rATm2K3w5N/wf28ZbyaVnNRUAEDCSzUH2TDn2l3moqGmRxE6ntPYe03IQVOP/WiTGUpKBiUaBCbxfIXXagve5ZaAvYFmX1g+t6ZjYuDOctIIDJzaWPq/q7N7TGYkN5rZxLkw6kclKFS9xNFlLgQ/e6QY56F0JODHJMUl0V3aRUEEPHO21gJb4OqIQvimjdZeMR5sPXU9KUIpfuk3HiOEAgpvfiF1Klz2SY8cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3gKz8yZkQabp1uf207NgjHJwE18p+YDnq5so7qwFRo=;
 b=ewqHuYdPuon3823AtnSNx6MSWxkPdJ8r7NXPkJ48VpfSNdStmQ1goCkyxGsj4naByecElzhfyNjOZpnpfAeADFn4qAieCGAkNE1QZdyXVcHPhcYKtcozJWP4kdniuMzgWt+dbnzPZik9YthusrDNqwRb2dcmGGnnkLr/MfZ7oxA=
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:50:26 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::9) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 09:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 09:50:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 04:50:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: only save and restore GPU device config at GPU
 error
Date: Thu, 27 Jul 2023 17:50:03 +0800
Message-ID: <20230727095003.1959679-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: debb042f-f576-4438-aa75-08db8e86e72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRx7190SdD6NZYWYH0gI9wpt+jsEeRedrHG+QngKIRmRluEq62wEhfX7XfjVu+oSynAX+Ihhdqe5qskjV4JvnBdEF1KMuLLFAgmINhdN4fcLhO6iHsiR7nNIC2zlr/CBpkymsVgCZnD03orzryjb9BdY1+Lj7Edno0VRcKbDc9Nhu09svoZMsAJlvnnhkomDfNoY1zI+9EEdCYDqxcgKE4cQpPMaY6U3AvAmbbl44L9Qe3dSIWRrrO0XDof3unHt0X5J76yTqOngQ5gPT5q+EttZMwiTJVywdl/1mDTnEG2DGZbIw1ZohhJuVXU5GDIYPU1Be5nSN+LNNr9LxB58C3KIF+XXG+e9eQSPZes3cZp6OBr/EhSTPlNxyg6DFlQpjfZxaAQpu0l5ZRIhJlwzAjtdVqYWZXwQT91NI61t8X0QUnJINsq2RNSAaIR2abhJr/UIWJ91vHZn3TtWYoFXtA0zVJ+mGeRiOPwji59MybjM4JmyP0Z3K9QAcwOqi8eVxHEogL3iKU/Fc1vtEfDx1Ol1+BkilcU+CItzroLkjAPz20maOyesJzRlME2ysmlC9mct+cglqETUNky/mPBSauWl9Jo+YER9Hfh+HzZuI/QPaTiFy7/tU21pLRZ4xiK7a6KSu0McAJMrE6N04FJLZxtddH3eblZoJRb8T7Bih3A9nfla6r/Ftx9phMYHU70LuAFv1bKIanBf9IHtIvkJTM+Nq/iwnluD6aNnZbzOIEHIZ2qIAo3iROyoe5215rlLZXAbkRn4O9JufQ0Yc0YZeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(2906002)(4744005)(40460700003)(82740400003)(86362001)(26005)(186003)(1076003)(16526019)(336012)(83380400001)(47076005)(2616005)(426003)(81166007)(36860700001)(356005)(478600001)(6666004)(7696005)(36756003)(40480700001)(54906003)(70206006)(70586007)(41300700001)(316002)(8676002)(6916009)(5660300002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:50:25.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: debb042f-f576-4438-aa75-08db8e86e72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's need a check on the GPU error state before save and restore
GPU device config space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 358dcc1070c5..5ef3c5c49bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3946,7 +3946,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
 	/* Have stored pci confspace at hand for restore in sudden PCI error */
-	if (amdgpu_device_cache_pci_state(adev->pdev))
+	if (adev->pdev->error_state != pci_channel_io_normal &&
+			amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
 	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
-- 
2.34.1

