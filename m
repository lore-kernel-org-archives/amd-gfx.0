Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E879C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 15:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEB710E19D;
	Fri, 10 Jun 2022 15:46:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBED10E2EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 15:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj0BbkX1y85ZMHPA8gmRGbI9lukWcY8lPk3n4bUuuMQjN6LdZQ39GzNuC2pYJS/LcrJQMSXELbnuaFHdLzBpA/T2sIOmwsvZAkszm+XIsoHgq/SNVGRV2yzf4k67YZMyR7f9CPpdOixuOgyTqQyTIq2VWZ9bpjZ4UNRvprH7WWNtQ6+0FCawG2kk27Sy0nR60ryJhdyVlmxqIj1M9rhTwp1zq8hX+sgy1RurCTysStl6NP73cMfOUCttMBP4BvnbX2H+9jemNTprPrJtm+spr4uwZs2lbflfAkZmiH4aeQt6u2yGzTVPekM6aDhLrrCT43BDYs1SlaG0vDgt0qXPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7Vo3NrmwArk+Llzd4fcQuumMPSSNutEBYmW9ZHaKEY=;
 b=m98/AEnaKFA3mjNXG1lWNyK5Aut5o3ZvzB6/9PYW12efOoBTkGpvObzdiydure0CucIQECMecGZcExLX6iUQ4o1MSCPnlGtE/kbc9sH1VMY+Qovpup8D2e6bE1pJfqn330atJOyYEpzlB2Z6POxz4tcPKfM0qJ1EODUNyP1SD8T6Rc9ejxgLITuycNazKtpPkZp+ZcjFQ4Wvj6rwwZN0SZ464xNOdH7GxnUZ+yLnVPlscR2soCTlIrmu8qLx/eIcxTKPyE1ANgxb/6lOhlCgTXvB3rCoJpZ2KvGCtPmhziGdIVvqezfG8fDmPznMkUXgTUjZbLefS9fpcwqwecbQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7Vo3NrmwArk+Llzd4fcQuumMPSSNutEBYmW9ZHaKEY=;
 b=FLb3RROwuj5kY4DgLKHTeKHC8o159QyGgeWNgsjQXUfnYeMMDXP0NWmE3qeQpJp8r9GB9hV83izdys/U9xY4t+RWFa8gW0ZO6XjDOZHOacCUAH/ddpribtAwFA8j0Z326I7jleXpu/LK6/fXA7KW8UMmKZmDOrr1bzq84UAJi8I=
Received: from DM5PR1101CA0001.namprd11.prod.outlook.com (2603:10b6:4:4c::11)
 by DM6PR12MB3036.namprd12.prod.outlook.com (2603:10b6:5:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 15:46:18 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::47) by DM5PR1101CA0001.outlook.office365.com
 (2603:10b6:4:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Fri, 10 Jun 2022 15:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 15:46:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 10:46:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: fix warning when CONFIG_HSA_AMD_P2P is not set
Date: Fri, 10 Jun 2022 11:46:04 -0400
Message-ID: <20220610154604.338282-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192d3a4f-adfd-45df-ade1-08da4af85c15
X-MS-TrafficTypeDiagnostic: DM6PR12MB3036:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30366B3BA2FCDC1F852EFCD5F7A69@DM6PR12MB3036.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CNOtLgo0pseMth77BChjTwRQj2U2QoF639woHgRdt27n58VTbSPLrAd2YvuufN7xLwDoDfuwkJrrosAW4zewQMDMSVIJn99DiNhbYmrI8W7ZA5b6ECS/PCPzkhDl+hGnXGoln/TOq19CK/4BW0AFPp5XY+kSwTaRI/lAIp+kExszQgoGj9t9hBIDlHqmhWoiPKGRuwpzXX8HYT8x0G/iyBjln3wkUq45W5Qn5cwmePJ4vjAyWhU3tVeUgK0xlY9X6JG/gjkskRwG5a/dgfxCCDoh125wi0jA7dQo8chnhkypCt8eYJYMV4+GVPbu78or36DrqSNTQqor4GLdEDiu7Ym6xjQtOSzKSfxLZwKSjqgebnuoPdfj47TlWvH5RDsP0luJeQpmtofBRxnuVRwUXo/RP9EDPa0iToXJatIe/EkL8PzereKjjiCnHSicf6vG3hLWAX2UhV5Bt4aCx7TNwcPfXUnhON+bnnjw2QAhBkAClblfq9YLImbxiKwwAmAE+TIkjtfst63Ohs/a9+U8uiMkDEH38/yaodLc86mBYnCxIepjHUtC1FT59wx0KDiOnIpiODJxITXZnkozET0UFTZKc2m+7TxL+zoeaAdFdgYG7/dmKqK3KP5k13x7KQKzEjeuyhgtpG9rbAc/ZhPv20f8I2Eaz139aDI/QeELL5rcheHH+3LWX8RFNQQo8oNWv1cDDwo7V1C4ITZddtpMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(47076005)(426003)(2616005)(2906002)(8676002)(7696005)(16526019)(186003)(1076003)(4326008)(26005)(508600001)(36756003)(6916009)(54906003)(6666004)(36860700001)(8936002)(82310400005)(316002)(5660300002)(40460700003)(81166007)(83380400001)(356005)(86362001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 15:46:18.2522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192d3a4f-adfd-45df-ade1-08da4af85c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
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
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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

