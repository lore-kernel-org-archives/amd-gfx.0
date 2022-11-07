Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92F2C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 02:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EEEA89F1B;
	Mon,  7 Nov 2022 02:57:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E4689F1B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 02:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3Vjr/555rzetLGUcM0WaD/SbR3RnpmbP3v3wiomfqk6AUiI7iigrzmrKF4lXXPxg7dmjvjfyPpS4YCK3HCvUmoXDMNlid1Dz9Q9F37YIPYBlwfmI7pAh3Aref+KIOpzJDst0AUt+zY0IS2n27zgbgopgXejOdUBxQfB1SIzgteBJmV6KrZ4xlLKPAMZmQ4WCEah3DWJVt8hfP2fcVpo4tYIIVkXIY3sNvYVW39pmpcOt9WXBw42d0JYJgeOHQLIXbadUbIer0HNdnWGBReHVT+dN9cr3iKAMD8IdNsbqjHI4C7S5yROF7FF9MXWgZPA75tyMPvO6jSLkq0xapIiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUkK4p5QbGp4/j2bFe1+13rIVqWLfSOAqls8W0q9QKE=;
 b=X7ODgJoW7NClQiK+kYCE8tMDBl1gG3k/gen5hsw4JmuH5MBsI4MpGOfRB3nXQGnul/3i4oL0spDnMZsqIRsn2TrTRI8b/ZcyiRjKQ3Svhm0JB10fRJwKDy94kMoLMH6XuH6paBSGqme+Qy0v3usiAfrqdNeQUwrLi2eSw3SozYu3ZphQpE65rpyvTDPwrDRLuqetk2zq3z8gJ6MTw/eDpLszx2exvOdfENBjgSSdMBTqf/Z1AgvQqVbJm07DnBp7J+CQzWi9fpFd4KYn9BXi3gk21PXvUSCLVN8m4n013XjCsiUyeu+3Yx+8uk1HHEdXgRzRGNeEROfAEJQwYQKB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUkK4p5QbGp4/j2bFe1+13rIVqWLfSOAqls8W0q9QKE=;
 b=Rnxpf6VRlirZDcvviHqdQFRlVtHpaylI5Z+eUFd69hbnUF21nppsotTbma3841ViIJ4vureRe0eq270iX1+1ZlceTvH1hJo2i2PvH7s2FWATIKkKRfheyZ9fYbmfUAZKlvAOt9b2BjxSY7kbKb2p3qWNg139ArtcCsKO/cQ9tyw=
Received: from BN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:ee::14)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 02:56:55 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::16) by BN0PR04CA0009.outlook.office365.com
 (2603:10b6:408:ee::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 02:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 02:56:55 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 6 Nov
 2022 20:56:51 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Make kfd_fill_cache_non_crat_info() as static
Date: Mon, 7 Nov 2022 10:56:14 +0800
Message-ID: <20221107025614.1168989-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 9757d9eb-e69c-464a-55bf-08dac06bba93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO4YNU9RgOpYOrPf0UmpoCH1gi/Sif8SeSOSdVWG4MktGMUSdLPVZX+HS/NP9knv6VNCtNQA1Qx2ABPHwS1eKHRmYUHMG0/Vo1I3wvPdqIRIPOKnJrlHBXWAwLUe2qhyQz9mjHOnrSgqUJDBwDsD1ggvCJy2h3o9K1LBWEFAn0YGNvldUXAy+MZxJ/dDylIIRIs4edllRiqSRtyIs/r8kMonsaPy6UVyubQ3+h+WvtJIeyDIn8QDFrucWi/I1Tf1WnzJRENdGrECn0zzyKQ0ZLZEkVdehMIu2E6sZPZ8YauZFmtDY6ZKyfVxjz67ooyvjwnw4zj6Zl5v0SSkirDcipb2xIjVxXIXXMzQEOV0/y3whSWcWgPJdHLSAk1qSY67mV6vq59ZA5JhMW/youDUXEqsLBNwK1q7MOTblqkhyVCdneXwps3gN4ZP+1qHSgc39LO0rB7Cotk3nR3dC3SSemsBFViKqyHFTprbgBWivb9fxlbr4Pvr2HUYaS3ZN0kr74RU9QxGPZuciRCCruP12HbPvgRfP5O+S2oGD7vKoIKWu0oI+ivctgrQ1DuZAVYlr7suMpfblzASY5hya0KpSET7v2cm7aJKe++BJ15WIke42uCOItHIoiwD4hvQapWuTawcZizBO9VK2EnxuVcXNGqmPwmL+oOX3uJleW1DW7Kri4NMfXhsE8Y/QCgxn7DF+nt8465NpBTOgfvmsak66DAYCI0BM92zcHerAjRK9SNBv/VmqnU3qExJywhgYK3APScp13x0R19wdhqPuAw/hbTuCfH/A02RkuDaoJ8mpi+Q5nEhP1Mbxa7PlW5oX4Qj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(16526019)(478600001)(2906002)(8676002)(5660300002)(4326008)(316002)(70206006)(70586007)(41300700001)(40480700001)(81166007)(6636002)(4744005)(54906003)(356005)(83380400001)(8936002)(36756003)(36860700001)(6666004)(110136005)(7696005)(40460700003)(86362001)(47076005)(1076003)(2616005)(26005)(336012)(82740400003)(186003)(426003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 02:56:55.0129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9757d9eb-e69c-464a-55bf-08dac06bba93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_fill_cache_non_crat_info() is only used in kfd_topology.c,
so make it as static.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1d9b90d979c4..ef9c6fdfb88d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1723,7 +1723,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 /* kfd_fill_cache_non_crat_info - Fill GPU cache info using kfd_gpu_cache_info
  * tables
  */
-void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_dev *kdev)
+static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_dev *kdev)
 {
 	struct kfd_gpu_cache_info *pcache_info = NULL;
 	int i, j, k;
-- 
2.25.1

