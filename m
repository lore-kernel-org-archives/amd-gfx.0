Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E6C001DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 03:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D63D10E4CE;
	Thu, 27 Jul 2023 03:02:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C7010E4CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 03:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uyfw5sF95J/ChOQJfkkVyXKIfqqW5RLuemtQmXMHzkEcqqTwrnLbNp+4STLb24OmfUPIrVqXd81mLHuvVmdXb65Afoxkabj9o0AoAEhO72mizMujZ5wc84VVOZAihbaZKtGqnX4dwGsk6DmDp2mkidQ5j5G3kYdfEdIzGIWPo91Gr/vYlDSjTEKPvoFWA2ew3gkRhxRQu47jWiW1q++x8W5DLLDaehs2uASEFLvSgSMfmZTNumv6Tn5YERINpF1hh4NcWyT3hdNBJFlcWpVTXPmS9B/Y4ycBRvRF/1d4Qr3NrFM6Jhhnie0re6yT4QGfiwOGo9GHfanPhmb2kN2gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuDZ71yGg7Z1OdTZikwVMWUqpuopjkIjJ7vu1tivEck=;
 b=A2rS27sEb7UFh8TnU6lnt7ZvhunKKRUPKwisVZoJbrTt8t4AZgxLmDSPxElAJphaSDaM/9ykPbR/9UuecjbJmmO75T1kuOFsj8EOn1PuSYyLtriRU0MdQVfRZBdC1tb3LEzysDHs6MfhLLPz0W9XdXuGgR0H1ACEy5TpfPUwAo5wvBO53kT4s/I3vk5OpBnE6Crtv4qcF2jcMtBn57lM5pHvV53f+FTi3Xsx6iK93xafmGRHDRctGw90EsmI024IW+DBsb+35rrqLVOXyd3wrxfc1PciE8XUMQmKDBWp4225VuvfExkhGrnxaVfkzGt861A2Unx89Cs+FM6Kl5XSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuDZ71yGg7Z1OdTZikwVMWUqpuopjkIjJ7vu1tivEck=;
 b=s4FSNwt1sSBlcdndL1AqPNX4WLBUiFnSgZIUcVZwmytWwfcomH1aHDy9ozF3yDARIXeSTmF0siWYG7DAfdEpjFlZqD+k/OWtEOaI4vx8ELxWYEVfy8ZnWjsuz5PLKr4s5wLWNY2Uo2y6VYSnczoX0I64kCOoruGr55jIDZNsfOA=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:02:39 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::28) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3 via Frontend
 Transport; Thu, 27 Jul 2023 03:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 03:02:38 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:02:37 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct vmhub index in GMC v10/11
Date: Thu, 27 Jul 2023 11:02:22 +0800
Message-ID: <20230727030222.698498-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b5e3f8-058e-4086-6a53-08db8e4defc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: my6sD3IIBV00fs1la4ITHopV5rE7gg61UBELEan8qmwmMA9geKdkDYvWM6alkaCHWVeiDSrSvxXiL09EH9h32mjDdQhZlY0CbJ16qa0QIPMYcZZf9DC2xG99cH1+aF1gUGqRO69WAJySrdYdQNQRWNft+Em2avwl425sJ/X4lkhFuPp0ZPYvXgYBWcaCunGD5FyyWqi4p7RoSwugVCJ5LbkSy4XoQZhBl8RXHCJJE2eWdAhPBXheoZWkyQBCS39Jmv2hYoY8RrAOOqlt0ghjlWzx1L4H3k6s6QiA2EA0Oy5oxlbP+0grkbs59RB9DsAsMo94q0+83f5fRhV8daG/438XkoguI+kDBLpqRbAjNVh9k+3+XMjVjwZeq4nRMtB7KDPrvQnKSsOuymaYZ8ZFzgv3haDQUqlQ3R3Cxniyloqxn7rvrLLWmnYYOzpo/VXDi4eHtCnEeWjwGv/W8x398T10qr0RntgLSlSyTtuWT3aBa2rLQxCp1XdLSyoiOzfiYIaPNbf5hcST6FoM0J8qIyA0i/AnE1IVTVkuJ+CPKET4O1Pqu7awxYIzX6SePUBNsARklsdfg1er4jSZhUrpa9NKWQiMFcXAFG0lQOtOISUH1ni2sFXTjRh0UJO9dVHDRDzGE5YpyKjyyNSWZfpnd+zcLI2WdNSry2tdWNFmfEVavWL/LtJZZ/0ofleKE9IWQsJkEKDuF4qPgAGSPO5QByTmFAL3AadKKxn0oAgYxr7aAHDjfY121MIWSP856mAaPKizDIsatFZdBkQtxEP0Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(83380400001)(356005)(54906003)(2906002)(40460700003)(47076005)(2616005)(6666004)(7696005)(426003)(40480700001)(1076003)(26005)(86362001)(478600001)(36860700001)(5660300002)(41300700001)(336012)(316002)(186003)(82740400003)(70206006)(70586007)(81166007)(8936002)(8676002)(36756003)(4326008)(6916009)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:02:38.8503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b5e3f8-058e-4086-6a53-08db8e4defc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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
Cc: YiPeng Chai <YiPeng.Chai@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align with new vmhub definition.

v2: use client_id == VMC to decide vmhub(Hawking)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6b430e10d38e..fa87a85e1017 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -102,9 +102,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
+	uint32_t vmhub_index = entry->client_id == SOC15_IH_CLIENTID_VMC ?
+			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
 	struct amdgpu_task_info task_info;
 	uint32_t status = 0;
 	u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 604522f70d03..593f110921fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -99,7 +99,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
+	uint32_t vmhub_index = entry->client_id == SOC21_IH_CLIENTID_VMC ?
+			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	uint32_t status = 0;
 	u64 addr;
 
-- 
2.25.1

