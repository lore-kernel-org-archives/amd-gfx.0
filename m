Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEACC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189F010E41C;
	Tue,  9 May 2023 22:11:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D4910E409
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwcna2NNbR+/jgC1KcvUhuZ997QDTo2R8Hd40hZsPHKVdUqYx2quQuXb+A1lsTUiczywGDuxMMQCCkTTli1WaDpSGVp+BiZAYsk/lVKdsKvye4Vj5+lZUhWt++ekfW43+u+UDNhmZyhxrL1uuVJRUO5iTAnhvUKmKCvRCMO+6oJwODfEocux+MsUSlgzAjpnfRfLdfBSYP9xwFhwQnvrky1Q0OXhOzAMxxukrpLdy3tbnbfknGdBkypuqWWEtWipRoVVZZzi7Dv+/bcG6EB3yjIrcJo5XT9N6b53OcfSwsQYBYumV0iXciLRbtk3uJUnGpAWAdwhHoy5dqVOWRaBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCVPPcIfn9cEqS6MdzP2CMdXC2hIunw4F5DFUqRe9rA=;
 b=PO+8IpK7iY3QKR/mIavD8F094lCq+Nt0MJzJFJQoCtysFteymQc6uwPx78DClJaejKOY82r/K42YfkAXYfdvLsMP867KrT0pZzV68C0eR+jbceUvNn7OhkqygUA8gi3PjjZgVCxx+dOwsAeE3MjBSj6eDmmAGqbNFEjvsUgr6gpNjQCdFBlVJ1c8Ql7gTOUvtpmYzAjEPohm5kzfhdaIxMu33tBhWHc8b02D0RfjVt3HFMH/jyi/gNQrxk1C0USPhTZ6pGGqTldqjacNbrITSb9vDbgQGtOXVJyiTOj2c01R++BP3HwVaoReN0Fv9i3FvszcKZCqOagM+A2XbkF19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCVPPcIfn9cEqS6MdzP2CMdXC2hIunw4F5DFUqRe9rA=;
 b=LqkYWbB/2hdJZy5Tef3yxTCjH44X96Qo5/2TnVRS2QysM/70jJqlUuQExHDM2j4ynaCxByI9p4pKzkVQwEjSLQcRC/O17VUWhkyafhmKiVmMvZyGm0YCC5u4blSiXUT/VKWkNqxTCWosQLcOoNWYxuMB0F6UIckJcR93oolE1Pk=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:11:45 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::b0) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amdgpu: Add VCN logical to physical id mapping
Date: Tue, 9 May 2023 18:11:19 -0400
Message-ID: <20230509221128.476220-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d79cea-1f39-4697-e95b-08db50da601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvO4c6W74gMPimIn2jtDOV4H8RCw/rwcuNyL4rpHE3GSpGVLSCM1iEVd8xyW+p94lhcCyMsiceaMqelao+okq5LMORICj2zi99ZYmaBzw1J5Cy7nEtBTCLbVy2mBQ8T42aZopUilwXyyTDlD8VI9O26lEDVWQrwSoiiJE+xvZ84I0GdFJ9x+T3MKzbaIJqC8ygg4ENWMVaelxlTqEeqEnj0FXuTfwiirAv3zLiaTUQpy9xHIkG5Dd1hoN5pMZyyPb1Fg4SX3kilbaAGCAJmbGgnHDxcPVAj5R6y0tRZ2c4mdH6JQj7Ni2ZaLnqhEGAgkJ82n9LBSfCMOHjK5YMZEGDEVQEcbbMiAuC7OXhCA5nMc/Xl8jte7r6/BXeKvQUdGt7r0IDYVUQAIYO2KQBKK8A27KVElh50dif6zVz1GqjFbQSWAG1oFJYTlCMvJ+UOyqpCLHHMUvOFa3a1d1/3IFVV518pfTORso48rxSYkPAtu/X341EetaJPjWjZ6qhjG2CExgqPbU5rUrgy/AgttvbAMKUMVMnmExKI1UDqKnXaUSGFzaSRVX6hpMtdVoWR9GQ9pXiFDguIJ3CZ////FYBdBu2b+Wvkpcc3ItWVXhhDG6sw6aAT2hpkC2rSLMvH4OXxDSKl7khPJGyv6p/oUVTpJ8LFdj53hsoJBPI4yOGuHfk97C/IfYEIAtfZiybKsIhEnPzQu19rltdo7YZCvL3IGfm+5MavQTiWoRx3LLRM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(82310400005)(478600001)(86362001)(70586007)(70206006)(41300700001)(6666004)(316002)(83380400001)(7696005)(36756003)(5660300002)(6916009)(4326008)(8676002)(8936002)(356005)(81166007)(82740400003)(40460700003)(26005)(2906002)(1076003)(186003)(16526019)(36860700001)(336012)(426003)(47076005)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:44.8254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d79cea-1f39-4697-e95b-08db50da601d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add mappings for logical to physical id for VCN/JPEG 4.0.3

v2: make local function static (Alex)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Tested-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index fdc728f678d7..90fe77db9bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -82,6 +82,21 @@ static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
 	return dev_inst;
 }
 
+static void aqua_vanjaram_populate_ip_map(struct amdgpu_device *adev,
+					  enum amd_hw_ip_block_type ip_block,
+					  uint32_t inst_mask)
+{
+	int l = 0, i;
+
+	while (inst_mask) {
+		i = ffs(inst_mask) - 1;
+		adev->ip_map.dev_inst[ip_block][l++] = i;
+		inst_mask &= ~(1 << i);
+	}
+	for (; l < HWIP_MAX_INSTANCE; l++)
+		adev->ip_map.dev_inst[ip_block][l] = -1;
+}
+
 void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
 {
 	int xcc_mask, sdma_mask;
@@ -108,6 +123,9 @@ void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
 	for (; l < HWIP_MAX_INSTANCE; l++)
 		adev->ip_map.dev_inst[SDMA0_HWIP][l] = -1;
 
+	/* This covers both VCN and JPEG, JPEG is only alias of VCN */
+	aqua_vanjaram_populate_ip_map(adev, VCN_HWIP, adev->vcn.inst_mask);
+
 	adev->ip_map.logical_to_dev_inst = aqua_vanjaram_logical_to_dev_inst;
 }
 
-- 
2.40.1

