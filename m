Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287BAC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19D510E51A;
	Wed, 28 Sep 2022 17:43:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0261C10E51A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brYMykQzYJ/2aiR39NDZgjm2nvkhuDTQJOarZk45B/g1O8MhP6ww0OID2t0U84bg3iz4zue30Y70tGQk15VI+C8tZ+MlK9jNcAUuDs47FM/Rh3A6+1l5cROguE5uIbU4lbViY5YJgAeN/f+Qi692LA33R0gvAZJLhmWNkT/HWOu8aeKhiBCpCHc36TJK3oMhGAdRd1ltA23VWpeG7pZ6jHT/dvWh6+ilJCWRXZ1q2EayAXy5+BKGTu78XB3BakKTbXAUSmn5BylQHW4AxUXJ9EaHFew70kDt5kNT+Hp4bxZMAJCaWoQA6577xi8I9uSeqq883Qmc5IUCngSO1L8I+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRWc2MqgLiQBnJcKjMhsAoLI+0xHcHcDkzIxLU1z4C4=;
 b=hE1G9wN3cZkrSNeyGTzK4wWAah+g8aCxWSJsnogNMPDyg/N9k9tpT4Y0LBiBRJ7uCAqp95olEu+7ezi5Y3BzrIlIChH2CuTIJbIRINvmOCTyyjUD/hCLs3dlCdDWaEjMle7s7XtaXOQZ5qmUiCOofKi8srd0mxc60ETi0thSCyKXYq7jsDGDGFXJHCNSUZzN3YF8a7OGjGhLM8usdvP87p1PrcXhi/Ur58oJLNNSSlC6qkFnJvPjOeW4kzaHpRA7q2CYqIjvJS+PDP5raflyKlD3d+LNcbJCGDT0IRjkGWgqhtiQTKmO+YGVdSi1+YSPsLs4EAGN62KAwZ6+XGQ7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRWc2MqgLiQBnJcKjMhsAoLI+0xHcHcDkzIxLU1z4C4=;
 b=K0aALk0aA5gVBDO11LVeDJsEdbwJWhhu9r9YLT8xiC6six8x2VWCm7NKlRlEX+WDvgyOdwjOd+ZNtKWhlDhRUPtwpCiF+1ita9Rvict0ofzbtOg/4zzO2qVo6gy9sIXDVetiUK132WNWT3Uc8ismk+uVmJsdjUgGY2fjPJXkNdE=
Received: from BN8PR16CA0026.namprd16.prod.outlook.com (2603:10b6:408:4c::39)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 17:43:16 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::ae) by BN8PR16CA0026.outlook.office365.com
 (2603:10b6:408:4c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 17:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 17:43:15 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 12:43:14 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Date: Wed, 28 Sep 2022 13:43:21 -0400
Message-ID: <20220928174321.13409-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ca020e-3223-4951-3ee8-08daa178ec32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMcep64wvNkhSA5biOS+6IS0UfCOT4QHLFvOC3GIdKF3AEPft7gxUHEhTntM/Eu99eJGyZxRQNntTrlR4jk2Sy2+Ol0JTJWKJ6YsOMBrLHxsMe3LBtffnRxk9syCHQ7WuNd8ObE7fgrwHsqRmiNUagDqwFRDkLwxQHRMjR5RcjbISZa6ZRO+IJKFdNmiGNgFIEfzs+dueGb2VJ/jDhDFfM43Elb2C4l/kkzwr3XUJjSYzhwrjxYYfWPTA/AtcT1QVfxfsDavknS2qBZRnb6WaZfGz/4lOm6AJy9u8GbBRe5mfusP6Y11sdzVTS91UZdmaSsVv/p0qrJ7CPgQNQNbqm9xcQFoitGkTrmfGqCEamFK8Ihu/DxNU/yLGIxcRELDtZ1smBhNCE0XxPDTAuMbLYTZCCuFjnWKr+Rrpo/rbyKIiTU4uJ899ewl2uUpJmO9e5lCjFgvzj2V1Gm9SEEkzXCzf+e5/7N+eg/IhDLUNwLsxU8qu8eBu7ldISOgAjrVeBtzmqTD127s0EeaVy3mB3ONkH68BByZqNYcxq0OKhoVAb0lIGePI0sY5bqcX9DcKL6loUgyJDSE+X3RkttOyx3FyUin1U58gmxxSwdrqsDO8uNw0bP0E+anaxcDa7aQyS6vueIVXoLtjGScRBJQEgmtN9QERYwUrRV/ZSFpRODhhdU4s0V5WXsz30PkM+ar3Mj4jvZW6RaNVbTmZwBLRHTLozjxZ+4qS8YmdnG+XGFRl5jRlZE9fTtc0OFvOU6b2BXI8i9XmFagigFH/h/Vkg901JHKoIjDyK4gTcGO11bvJMpw+7rFnfdzun2yWdvJ3hJVS+olW2hSbVRS6uwZhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(26005)(82310400005)(47076005)(8676002)(82740400003)(40460700003)(316002)(6916009)(4326008)(70206006)(70586007)(54906003)(36756003)(86362001)(36860700001)(81166007)(356005)(40480700001)(2616005)(16526019)(1076003)(186003)(478600001)(8936002)(6666004)(4744005)(2906002)(83380400001)(336012)(426003)(41300700001)(5660300002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:43:15.6584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ca020e-3223-4951-3ee8-08daa178ec32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: Vignesh Chander <Vignesh.Chander@amd.com>, Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov, the reset domain is no longer created so need to check if it
exists before doing a put.
Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 47159e9a0884..80fb6ef929e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
 	struct amdgpu_hive_info *hive = container_of(
 		kobj, struct amdgpu_hive_info, kobj);
 
-	amdgpu_reset_put_reset_domain(hive->reset_domain);
+	if (hive->reset_domain)
+		amdgpu_reset_put_reset_domain(hive->reset_domain);
 	hive->reset_domain = NULL;
 
 	mutex_destroy(&hive->hive_lock);
-- 
2.25.1

