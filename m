Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38D6C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 14:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297C110E102;
	Fri, 19 May 2023 14:20:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7B010E102
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 14:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH78RoDt/5GCuU8DxBrfe4roFqgfuSkmPMJ4Tf3FqVIIaBhFEAxz/zjvgkpqxMzkAvtx3ZdVUyLDE91t2SfD34Mxz5Fczpy60coiU/wGD5T3BvpHjaClONgvQbaa1WM7b1oc/Zn/0Ywlr4CCluqazZ04BppyJVh1/Tbd4ykHrfXB8YrIBFWTaFjlonYDnaZoL4KPRgKJrYaKyIsYNGuSy2eLOJDqv9s6aL26gY22CofGfJfKkfow0fnh8Nu2wrtmDWvyL7gcyCtT5gwQD3pSukPK1g00zINuCEtd9+wer7C0b1QTUyXbzUca+460LcYPe3a1NlcYz77HcA8txMtUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opgo9FqBEqDh355RzOSKjUCHTRo3PBFxq3v1g+RZxnA=;
 b=kTHC+OUmUbg2oLUrgyzW2/mhP4n2z4bfLbd0r1T5n3+ax18BgmJyRRhUf35reTS/p4yEcSkEZ6rdVv5wkkyJSH7aOVSrIWzaAHlrh3hunFA7e/kBo3S57zSP8G1drqCkHaXR1U5KRyuL5iMlLHKPurw82N/n9WX3MI1/IRnZ9z+a5zRM36SSZqX4+h9yXMHQz3x4J74VPiNIuKZp16GI05cidFI1+WVI+pOx/8VHPO1vciiBzAN0opjvRjNnngRIsMfbE7FfSW3y8fbeI+9U1aRZsV6daC5kR34BuQUB07w4btjt6cf9S+XuM2ZXo4qCRJmMubO48IgMukllFP2EaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opgo9FqBEqDh355RzOSKjUCHTRo3PBFxq3v1g+RZxnA=;
 b=ybftSVZqa6BNmbU28ah/nHA4ggMRNXA/6V6UwW63z8+JI3lheZZgd42GFWq8SIG4we1tHTpb0pynAiJf1AI/aGPPMgPU+TpowryNctQmHY94AbsjYQ3Dc0v40L+FaLYPL7XFRmBzqxKxNrNctaNIPIymFct7p38aHTA76r3Itpo=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 14:20:19 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::de) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6 via Frontend
 Transport; Fri, 19 May 2023 14:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 14:20:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 09:20:17 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Align partition memory size to page size
Date: Fri, 19 May 2023 10:19:14 -0400
Message-ID: <20230519141914.21508-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 542006d8-4ffc-49ba-0269-08db58742c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVe4YKbdR+6bGWaLvlkUp3UORNJdPSW9oNRVdcUqRloiDsZPd8wkXcel96hK6qayyp6Y/7uC7h7FcVjRAJSJUVav7yi6A5tH0YT1fC8gxKvnubcvX8On97avPFdcwFTMoVLJb5iytSY9jpKII0vK4mw9aVvxq+WxGcseIsXbrTP03H95QGGh47vOdm+TUOJ9JROhCzcY+Y/ffz8PqZNEtMyD7o4lN4pnlS9fD9W/q8pEjNAwDzLIVJ5XYSiL7yQXDVE4lHM1d3iGcm0Kf4TzRLxYaTi+q+lHNvdC7VmZTs4jzFCiBYiO6L7F0Kp24CEwUvVY7XsfPwqygVLUyGc8WMn7g+UvfAZzqD8x9A6BREkMnL7k61yjXvI0OK0qgNDBLwEs8WulTkLdwdf26dRuA5P74o4yFR6RGP7vv2C9u5St+PVcr112MrQzREkXQ/ZTTYeUxj+ZkCPJMN9uHwN9gOrtlUFWQOtpSZhJN6txcAvVumffoFc8hI7W2Etagf0czVP0nM9GnFqHUOM1YNZQzLM1axkvaIptpPTP5aqIX1WZ2ZdE8eERh6JrLn0THp9SgdGZtX2PY2ITtCR9y61x0oRjRPO+dsskWG3ZjglWsVrNXXTKQbTkQXNvLOGvNlir7jNTCGHueTZNIfaG3WojIWWcMSO9P1DCGEoZdPRZ93QImI0SYYJanux8VAvmLPcPgI5Bl/4PdwZcekki+sDg81d9IFimDByohOXCTJpx3Tp41xbUDK/9Kj+JUS4TCD8yUDpeDkOHsqCeRjYMzuRdkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(70586007)(70206006)(478600001)(4326008)(54906003)(316002)(86362001)(36756003)(83380400001)(47076005)(26005)(426003)(336012)(2616005)(16526019)(36860700001)(1076003)(186003)(5660300002)(8936002)(8676002)(2906002)(7696005)(40480700001)(6666004)(82310400005)(41300700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:20:18.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 542006d8-4ffc-49ba-0269-08db58742c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The compute partition memory size calculated from KFD_XCP_MEMORY_SIZE
may not align to page size if xcp_mgr->num_xcp_per_mem_partition is 6.

Change the KFD_XCP_MEMORY_SIZE macro to return page align size, so KFD
node memory size reported in sysfs is page align size, to avoid
application VRAM allocation failure because application may use the size
directly and Thunk requires the memory allocation size is page size
align.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5de92c9ab18f..66f80b9ab0c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -804,7 +804,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 	if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 0) {
 		tmp = adev->gmc.mem_partitions[mem_id].size;
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
-		return tmp;
+		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else {
 		return adev->gmc.real_vram_size;
 	}
-- 
2.35.1

