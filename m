Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC5EC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 15:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0C8112220;
	Fri, 10 Jun 2022 15:43:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F268C112220
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 15:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3/Snnn9b6jItENmZuxR95LZrLTOUl3/J8eOnozUO38oEeEsvwBH/akBwrzdRnjv1fGuJ0G7faBW8Ip6/F9aoHVJjv7KdfTyaVj4+dfOy4KuQ8+9fbl5wJ8QMYjhJxM7n+69z4K3NPKqFOGEzuAEVXcdzi5L/SKr0j/Wgr/ke5z1RqaxdgrotcQ8vPhbi/0P438WTUHMQ+rOJDM4zWKtCwVslf4hJeipNuYrONPDWCVCqmWyrBwxEonul4jVKGdxEN293jHeo8pJhK06JStd17AmbZiRVKdX7DycAvvuKGxskr2wJ6MCcK2r+nn8mBcWeFJwKCtqLClFMX+dOEKmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx1b+S53k2TekSa/mb3Hivz5I0j33t4JTxJHj3P5pvc=;
 b=LyVuAT4Cq074aBaVfDOSm3i9wv7u9tLFBSVO8OHsD3+5u+wt+vnUL9lPV3VkWXVJjEljyKYEbFTmAcEDEDCHuFztMNwQIJCmsQJwj9x8MX9dl2ES9sDXYodGUAblGlhpeZGDVnyS7+afkGkzEY9m0B8uOBE/wU07ssLm8M3JVFZ0u57vkD+1EJkoM4JTYUpXbe5yBd3Kl5OcwOD6/Pdyxuh6+blaGBhq5uFmpX2q6rYHzZ/eUvewnKP2QjJ1bGmWyBQoH/nt+THF5DA5MW8AIh52siDgtGypAhxE58OVP9Ydr+RwRTFw2Nv8Tkwng9YVU01sePKs4QHCQrdPSARzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx1b+S53k2TekSa/mb3Hivz5I0j33t4JTxJHj3P5pvc=;
 b=OhWsyXdeghQtdyCWu9y84hpm8KP10jVF0apIDMB+9+SOYrIdMC5DhAU3Ip6PJ7uSFM2SpR92GCV7gQvlXIx8jK+StvO/+VpNe31fxx0evXCmc5kTuIn6u+2gaQlixPdsGZDdzTlMHmyR9JFLWOIUxLA3qkcYxdhE8s1mb584Y0s=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 CH2PR12MB3830.namprd12.prod.outlook.com (2603:10b6:610:2f::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.14; Fri, 10 Jun 2022 15:43:04 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::c6) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5 via Frontend
 Transport; Fri, 10 Jun 2022 15:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 15:43:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 10:43:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix warning when CONFIG_HSA_AMD_P2P is not set
Date: Fri, 10 Jun 2022 11:42:47 -0400
Message-ID: <20220610154247.338073-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220610154247.338073-1-alexander.deucher@amd.com>
References: <20220610154247.338073-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e19b99-6566-49ea-a59f-08da4af7e895
X-MS-TrafficTypeDiagnostic: CH2PR12MB3830:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38309C1D762421EDB1431208F7A69@CH2PR12MB3830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpoMsQwpI1/jEw0Qm1iGu2p1eXk6PfHwaKpWEwLBmUVlbQGIr6UeVikDWhIkxF0ixmtbght9DlPpk6NQ3IpSF4gESc7hP75OPnJCf1lDBxnxoRFcPn1X6dVQi2oPp9UqP00sW2dYO82EvUFAIEe9kj1aP6Tce7n8gGMlxYBpO6bmRN5DgeuuJ308Ba8rYzckCBzzKgysFTx6NI7EDiJbs+6Ixt+BHPmG3MQi7VE2NRNBU7nq25zFtmrtomUBRVQmBvYdnKfGOsB4UvWxJGmlRbcDZKHToiUgfQH+K9InJEiZ4k1sVh5Yx/OSnklrkhEWpYWrdN/fQWlg8Ktekzoa8pK1iqtIWF+R9cCqFW0zar5Ap+Kv8e0H6ZoaBPHpA9ryD0VjMD8wEgK2cvzINqPVNr1mq8yo8HEafQyszne6Qe2qrRHDJnwK17JVpvzpIkY1bvZUYd+DfsytVAUHTrc1XVVT2zrHiT4fsPlORds1IP4dEiBCoJXJbsS75lC2yncqHnY/f/BmWDQbh/lZGm3FW68BJKhyPcr7AcByRCY7/A7BP2iJq/KOQb/jqpw/KZyjOphCzp6MUaix7wFaIokarRwChBAt/qbdBeH+wTBZwqrNcOdzA2bCTJjEwVFUCDuK9my+f4TWDBJb4vVEKxKHrwMpuN9cW6P4BL5Z3IEsXuz35S2kT9liAQZp/+1A3jmTAaiKK68aqTbpimoX2Ijrbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(40460700003)(16526019)(356005)(36860700001)(2906002)(5660300002)(1076003)(336012)(426003)(508600001)(186003)(83380400001)(82310400005)(36756003)(70206006)(8936002)(26005)(316002)(86362001)(8676002)(4326008)(54906003)(6916009)(7696005)(2616005)(70586007)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 15:43:04.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e19b99-6566-49ea-a59f-08da4af7e895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3830
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11:
warning: variable 'i' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index aebc384531ac..88a0e3ac0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -773,6 +773,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
  */
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr)
 {
+	dev_info(adev->dev, "amdgpu_gmc_vram_mc2pa: 0x%0llx, 0x%0llx, 0x%0llx\n",
+		 mc_addr,
+		 adev->gmc.vram_start,
+		 adev->vm_manager.vram_base_offset);
 	return mc_addr - adev->gmc.vram_start + adev->vm_manager.vram_base_offset;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3e240b22ec91..411447357196 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1539,7 +1539,10 @@ static int kfd_dev_create_p2p_links(void)
 {
 	struct kfd_topology_device *dev;
 	struct kfd_topology_device *new_dev;
-	uint32_t i, k;
+#if defined(CONFIG_HSA_AMD_P2P)
+	uint32_t i;
+#endif
+	uint32_t k;
 	int ret = 0;
 
 	k = 0;
@@ -1553,7 +1556,6 @@ static int kfd_dev_create_p2p_links(void)
 		return 0;
 
 	k--;
-	i = 0;
 
 	/* create in-direct links */
 	ret = kfd_create_indirect_link_prop(new_dev, k);
@@ -1562,6 +1564,7 @@ static int kfd_dev_create_p2p_links(void)
 
 	/* create p2p links */
 #if defined(CONFIG_HSA_AMD_P2P)
+	i = 0;
 	list_for_each_entry(dev, &topology_device_list, list) {
 		if (dev == new_dev)
 			break;
-- 
2.35.3

