Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EFCC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C4310E3F0;
	Tue,  9 May 2023 22:14:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD4810E3ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md58qFbHwpXq+wcSqJDeRbvb6Ow0ZWbhBMi9rAOFkTkQJ2ZJOaVxS72w2fqv6l5d3U7m54aNZMe9hcW9XFLvC3zLjSoSpI0YVhIJHZ/WKGo7uNNasSSb8KsaxGSTKXcn5eNwZREGJjPleqC3+Xja4QtjdYUoYuQpEW3TwfeOXwdDF9JZCaJgAlSvc+8eBO2H1p+BKcPPoBR9d9GC1QbngnyxRBcL221qMTLCWKRoglt+HqX36bgPkT1p1kGu00dEBx29JV7l0Q4itSR4jLglej+Li6Wc9oI18bwfEdRIflQcmVuoukfcHdAc02wRJZg/armZWVKNS//J6DVD4xIFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vucOyeyykVFFBrIUkRSdXMwirUPQej/MsHCi9A+q2gI=;
 b=Qx3kHJCmq1BUIsJ5DEaoV9ARb66fXgX0ahm6x/JGig0DSKcRcxak/Dbkta5qONKe4UGFkU7FFKTqBDj9YfT7/cHmyXVGmfYsf73+6HJkHKjipCw1bjlPEcz1E5DxWe72tg30Wnnw0fqv7oG20g0vqZ5I3yo90riFX98AjI2YekI+oFb1m8yzkFeHNIeEm68DEMu2X/geaygoTAlc6nzpQRiEtkvLV9csDGgPek/R52oA++x9zRbHD1hXz1WjVwN176pniWO0b8CFPC8zHsIR8z8k/TIXGE/wmzCPuL6wPDVtr2lIuz4cyFNXN4NNun4bsZWeRRrRRg04N2AEhCAmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vucOyeyykVFFBrIUkRSdXMwirUPQej/MsHCi9A+q2gI=;
 b=eVTggXps6B50yRMe7RkQ2nFL+fUQo88TAGApqIH5a7/I/9AE/8SmA+DEZmWXX8YdmiDRQzMVPahrJzA7kK//TTSEPkFA7yhZ0S1xJ++Ud5cWfZfmvvsfUwI1VNzmjwNZucLSH+R1aDEXi332Njmm/ccgiITF85mDOPd6tPwuV5o=
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:14:29 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::fd) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amdgpu: Move initialization of xcp before kfd
Date: Tue, 9 May 2023 18:14:04 -0400
Message-ID: <20230509221408.476829-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 553f36b9-a5ee-4f6a-b5a9-08db50dac1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xonDN0lEbUCs4P05squAcGtRSCqcjmpfDNeQG13SsyqrHKgNdYZD3p/o7e/MTth+seZ7REt1zi4u2q8PNUWb3WUnsMUNUry9OVaK/3mIXlkI7G+h42TFz5emMftERtpzwqzqcjT3EpfQ5+zP8u6qrvcrk2eh9DUbK9ySCdpP1OLTyllro+axaUaErC/IHceGOGk0lG4PSqfJzCBuu1UhYPdswoAFSkFql0qnYfmniY/YDCUrkpCYcELhtS0N510mK3oYtNJ0KkPToZSoN2rrQ3Ak7w4CcwTCovJbA6WJ3tO8i9Jc0Xc98aVgWeKLEw/rOF+i/Tob5w5/vzUZ9txxZp/cq5JCmwhVqKCM2rmnHSA3ccEtxpcfaLa32bL3/4ek4RGevvghDWFZ9Ngm1aXGQlC1nTwncCQGu2QRn3/50IL90++jGUvuhPw+BoT8xV7AxHNyOAcdbYzz367wBnXgXpWN0o7W4AvcT+Q2+NoM2Pkia6izvDcGdH1bZNt75CrI6MnqvF4+oxwhUAytqKKXcWbeEcWO2H/PmeMJj9MHrdw5YLZmqYmG50YFhMc8hALp6if3+hvTvcSocvOlMdu4DGFvr8avMsFMZ5sPZXGaRC7GQ7/aF+mMcndFOTt81R4wAgl32QY76702YnFbawhrf71MGdKCOFhyX2GuarOYO0M7iF06l4D4MMsmf0onwU2I2ZuAKOC9DCFqXW5pMWYN/o1FOCpBX+6hR3mI+AjFTpM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(40460700003)(2906002)(186003)(16526019)(36756003)(478600001)(6666004)(7696005)(40480700001)(316002)(70586007)(6916009)(4326008)(70206006)(356005)(82740400003)(1076003)(83380400001)(26005)(81166007)(86362001)(41300700001)(36860700001)(5660300002)(8676002)(336012)(8936002)(426003)(82310400005)(47076005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:28.9393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553f36b9-a5ee-4f6a-b5a9-08db50dac1ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

After partition switch, fill all relevant xcp information before kfd
starts initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h          |  1 +
 .../gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c  |  6 ++++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index e1d3727036a1..bca226cc4e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -113,12 +113,17 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 	xcp->valid = true;
 }
 
-static int __amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps)
+int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 {
 	struct amdgpu_xcp_ip ip;
 	uint8_t mem_id;
 	int i, j, ret;
 
+	if (!num_xcps || num_xcps > MAX_XCP)
+		return -EINVAL;
+
+	xcp_mgr->mode = mode;
+
 	for (i = 0; i < MAX_XCP; ++i)
 		xcp_mgr->xcp[i].valid = false;
 
@@ -181,13 +186,6 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
 		goto out;
 	}
 
-	if (!num_xcps || num_xcps > MAX_XCP) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	xcp_mgr->mode = mode;
-	__amdgpu_xcp_init(xcp_mgr, num_xcps);
 out:
 	mutex_unlock(&xcp_mgr->xcp_lock);
 
@@ -240,7 +238,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 	mutex_init(&xcp_mgr->xcp_lock);
 
 	if (init_mode != AMDGPU_XCP_MODE_NONE)
-		__amdgpu_xcp_init(xcp_mgr, init_num_xcps);
+		amdgpu_xcp_init(xcp_mgr, init_num_xcps, init_mode);
 
 	adev->xcp_mgr = xcp_mgr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 7e7e458d307e..e1319b887bf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -105,6 +105,7 @@ int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 
 int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 			int init_xcps, struct amdgpu_xcp_mgr_funcs *xcp_funcs);
+int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode);
 int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index aa1bb7883158..004400fb89b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -321,9 +321,11 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	if (adev->nbio.funcs->set_compute_partition_mode)
 		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
 
-	ret = __aqua_vanjaram_post_partition_switch(xcp_mgr, flags);
-
+	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
+	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
+
+	ret = __aqua_vanjaram_post_partition_switch(xcp_mgr, flags);
 unlock:
 	if (flags & AMDGPU_XCP_OPS_KFD)
 		amdgpu_amdkfd_unlock_kfd(adev);
-- 
2.40.1

