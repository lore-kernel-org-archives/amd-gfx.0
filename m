Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631DBC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15A610EFC2;
	Thu, 30 Mar 2023 19:18:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F92210EFBC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnDqlId0psiaTVDGMz7dkMmLG6MC9J+IYdtJhH0GbLK5Vlxgma4bk+W39jTR874BzNxbcp93NPW7EBbO8HG9YPUfRX2mFIodnrjGv9MdZmeiy56S0wWhs1MIH5zYL42B99B4mJxiWzQU55LYbkzmy/sKH20td0wsXQwuL1kW2bKCJz2txv6FA9vsDneOm/R+VkMwDxqWbbpndoEftfqjCZ+d+oyb+KIefRPS6XQd4HjBBIQYLdmwW8hed5lDjOY6Nsk/sBoB3VWnLCSBO1aOa1kxXwLzzYiQb4Bh4PcUTgZOhZlIxhcibSF4OWN4z/7pZyC5ZV5mtjdMGEL6ZEoN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vkQS//RBRPX33u43eHiSnTEFYb+5aqrhcUpzsGiKtU=;
 b=fGgesfkIH1iQ9nnVTasWWTj9CdH34e4YxXFC+G7qTJ+AqbFWpzKlSSJsL9A09hzYTjvNRNXw90FZWIDr/B7oPH3UBdecliSueCsfSyvJuT3AUzEdmTqWFr+b4bHi1LunXrdQtVLb9ZHo6vML8zmY3agv6O0k/Y54wrv4UWOntPNEZ452iTaABioZij9RvudWZ21iwyBtoYGQ4p5FN2hyEq024qd9FmzQY2zlkav6JQk1S/Y1dfep9F8RiE5942Mlc5bhyDFiBHBPeLC8q9WD+omcZg1YI+9PNYI4lptMo/7cw8t0b2SGI7xRa2SAexanVNaClG76+q1DNxkzRAT9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vkQS//RBRPX33u43eHiSnTEFYb+5aqrhcUpzsGiKtU=;
 b=cVy+UM5TuBUrQXYpKC5KcXR8ynzRKk+LiyjQxUTD8cl24UlgI/pDDvuiX9lQspuPdD4Pu9nYOewoNZS76Ty3sCydZ9ypaIjY6taYujfy9RE40hlKkhSR+A969rOCPf8O3OIQ3iy1Td/nC3gwIR6YZ5u6qoWSsCRdFRw9G0wLC8w=
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 19:18:10 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::5) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amdgpu: add debugfs interface for reading MQDs
Date: Thu, 30 Mar 2023 15:17:50 -0400
Message-ID: <20230330191750.1134210-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: ba282868-951a-411d-a376-08db31537ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2HTxtWcVelrACUo6pRQj9Dur1Cg6snBYmddWWG8MwuKOqzCWKuF0S32813TMJrN5/Ojz/mux66PLrsuu7tA8JSOYd4LGH9kk3rdujxJYFf13s4q6GgFZXUmIskhDpNu/fgrqA2Qh4DaLePj1aHHavjOQV97OAdzaVyRiLUw9ZGOV2nxfDmYmG7igyVUj8NGlpWKJRfE42cz9ltHKHhK0GWT0a1FRe3JqlPzNIvi+F/GxDjEyO2aAQ8KHNON22Tw5bIjOUTsNIyUe3xBcNZ4s2oR0ZArSPuhgpOI3g6xaF1DoS68hT07At9CCDmQdpg2hS7Z5KRrLjP++/E6F3Fc3PKLanWK84RZRYzTreqGVZbihuLa0ghgFc3Nun0SDFMlxPRgdUX5SS7iXDm97oX740sSzTHLKLmSlUFm/bYAg0sTkUR4QZJUFiIt0lSCO7V0/ZgHuB+kkPN3d07hRGEpO8ElAprlb9q4irtUwLRKPQhWM7Sb79TMd+grm6s55u05cXr2EN39dVL7mX7nmQ6713SZfxNmTGZvIUMtVYWh+wp0VgLzO+tryirQYSzydWBcInyJ1fdrSusTA+XfGgqBsVIZWJKp6+t/1zwvLEaPGk9RENEPuOp/recMJWXUJRQLLTNOeTezM4S0Gt9GSWfoOLHbHllnbUM4ZasXr5hJikZ91wqG/kv0VRAI300CbcqzobJdUgpa3lESwu7bPwR15Hv7ISF8IQaLuPHL+euTrWE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(66574015)(2616005)(36756003)(47076005)(83380400001)(336012)(426003)(26005)(16526019)(1076003)(186003)(5660300002)(2906002)(7696005)(8676002)(356005)(81166007)(6666004)(8936002)(478600001)(86362001)(82740400003)(41300700001)(82310400005)(36860700001)(54906003)(316002)(40460700003)(70586007)(70206006)(40480700001)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:10.1439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba282868-951a-411d-a376-08db31537ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Provide a debugfs interface to access the MQD.  Useful for
debugging issues with the CP and MES hardware scheduler.

v2: fix missing unreserve/unmap when pos >= size (Alex)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 +++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..c3b7654678c4 100644
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
+			goto done;
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

