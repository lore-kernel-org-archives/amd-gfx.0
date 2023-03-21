Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD35C6FD20
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 19:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB51310E2DC;
	Tue, 21 Mar 2023 19:39:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE59710E132
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 19:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZRuI3eGR3nz7u+Ejm6KoXPbP0z75dGgRo1D1/E5kAXk8QJdhH2LxRBsTwhoYBRZ+bGhume259eNBdLIxgd/jZynFlXoqL7wIIhqIRgXPYEX65ymoEMEex0TAHG2LG+cLlN5smQ4dX+hcnXBk28oj3XsDuKU2j9m4+pXXoIOfnbpVGDBXN24lsw2jNbTK+RhF/w+GGPvj6jtxsaK8eWd5zWLNXWBKVo/M/c0nDcyTX+FHpmwd+ffUQ9IiWdFcCY1g7uU4KM68w/UJjFRr5cugobMo6RGqAnHHNx1NYCq9zVuf+tpkB5kDN1inhWf14muT/vT9irBJFcNTrLNOEa3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxgvF4dNXaiJVisACW0yS7Ecd0MJ+eCbIbIYmlzDQHY=;
 b=JrwET/7ioiHh9/qyF+kDgfS4Bqq2f3kiJVfGW+4toBc5ASGume05rkLGnO9Hv9/2unEZ3WctnN/wxFaCAxJGT0g+ZY6FFvJbaS77HUTyY4e7vwdHJKo4v5i1Wjlo55AERNajPmUgNgC4TrrEkWdth5l4I/5RHejpT7NCHJ0AJcJN0C8zvmQX1tq8l+9jGC95lGROXog3zObE70IcnMmR+c6hUGWYft1TTtoJvXhZBpB67Q5nTm/YTL7K1Fz98eZ1aQI9sMjYq9XecIjcBssQQyrxji66rMxp+DbCDAWmKA+neoT4DzG78iNtI6d6Q0BU4PpHwhxOlp9xrPL7WlJ1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxgvF4dNXaiJVisACW0yS7Ecd0MJ+eCbIbIYmlzDQHY=;
 b=zUxr+t9rNgfehNblUkcKGk0sXz1F4aGnDl7YDE2KQInQ7+AJJSl1ctc7Jhcr2gobdRoLhHInUBL0p9HyBydBXI8zNJ1W5Kwqpc6/YOcv70HGBGqcoLXrLgKn8BHyJADFFJ23ro0JxZNii2SU4iUhM0ZNYmMLXpRVMdRmgP4VIp0=
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:39:42 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::83) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 19:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 19:39:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 14:39:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add debugfs interface for reading MQDs
Date: Tue, 21 Mar 2023 15:39:22 -0400
Message-ID: <20230321193922.2029808-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193922.2029808-1-alexander.deucher@amd.com>
References: <20230321193922.2029808-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f7a576-7fd9-4ee3-d41d-08db2a44047f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TV1Awxyuk1yajHrpo3vE0fhZrbh9opfZHAjLuN/Jr5ZBiPwJ7TkXsoOy6Zzm+itMpe47MQiE5ODiYkdtjOujewfKRfpM0Nf8i80ZROiZd4UlpPIyFNKRhiPvBUsT1YUE+RqQN+12+EtI/Ed9C8PCd/gH/QGgNTpSB1orrcseiRp3uUIj6WP9elS8CxPyywRsW0UoeI1yzDo+XfNh2z6GCuTRQCT7f80ppdc+tMGwrX5srq8T3oO2iw6jjUXzhxW2e1y5WUSsbI+1/KoY+SOtURPA3IcLAjyw3kbgB92ocZSaFGkIo8g51ZRthu1g7WxfoSa2EhmF9Aj21Z48AtCRiehWlexTigBlcfs434WLU+tEsLwtnICphfeArYDPktwlm/x4wXK5UAvCPU1Imm+7In/LDMXNA7UfqprhbkGSEfFj07Fd0e0Q0dJ/GbqS+vLvBLMICGSS/TXOouc6iIJHB9OlPS7/QF34vqPE5XPKqfMnyAg2Tu3HjgkIC5iLliveM4P8X/Hgm2/iE7vHVfC3FCo+DHzodOY3wl8eXH+cvzCFKJAOZcTGdV/KlosG99fq8MNpnRKsChWPd4IYNvDa8c4WJTFIfLiSul9kbCqxh1uxGjJiDFGsw2qpfEzlWsrh788MrhX6zKpoBahFu+gK/yYvxGDjYenUhjCYKJUHAp7VZ8kqdoHfFTevx0obnIoUXs6GNwBf+0BnK8Wwig7yIk42bqx5yhXWBbfwF9dL/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(2906002)(82740400003)(81166007)(356005)(40480700001)(7696005)(40460700003)(426003)(478600001)(83380400001)(47076005)(16526019)(36756003)(86362001)(82310400005)(186003)(6666004)(316002)(4326008)(41300700001)(5660300002)(6916009)(8676002)(70586007)(70206006)(2616005)(26005)(336012)(1076003)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:39:42.4217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f7a576-7fd9-4ee3-d41d-08db2a44047f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Provide a debugfs interface to access the MQD.  Useful for
debugging issues with the CP and MES hardware scheduler.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 +++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..4da67faef668 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -478,6 +478,59 @@ static const struct file_operations amdgpu_debugfs_ring_fops = {
 	.llseek = default_llseek
 };
 
+static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
+				       size_t size, loff_t *pos)
+{
+	struct amdgpu_ring *ring = file_inode(f)->i_private;
+	volatile u32 *mqd;
+	int r;
+	uint32_t value, result;
+
+	if (*pos & 3 || size & 3)
+		return -EINVAL;
+
+	result = 0;
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0))
+		return r;
+
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&mqd);
+	if (r) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
+		return r;
+	}
+
+	while (size) {
+		if (*pos >= ring->mqd_size)
+			return result;
+
+		value = mqd[*pos/4];
+		r = put_user(value, (uint32_t *)buf);
+		if (r)
+			goto done;
+		buf += 4;
+		result += 4;
+		size -= 4;
+		*pos += 4;
+	}
+
+done:
+	amdgpu_bo_kunmap(ring->mqd_obj);
+	mqd = NULL;
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r)
+		return r;
+
+	return result;
+}
+
+static const struct file_operations amdgpu_debugfs_mqd_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_debugfs_mqd_read,
+	.llseek = default_llseek
+};
+
 #endif
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
@@ -492,7 +545,12 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
 				 &amdgpu_debugfs_ring_fops,
 				 ring->ring_size + 12);
-
+	if (ring->mqd_obj) {
+		sprintf(name, "amdgpu_mqd_%s", ring->name);
+		debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
+					 &amdgpu_debugfs_mqd_fops,
+					 ring->mqd_size);
+	}
 #endif
 }
 
-- 
2.39.2

