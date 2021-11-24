Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BF6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 11:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B0C6E4CA;
	Wed, 24 Nov 2021 11:35:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA496E4CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 11:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVxoUP/wbCypgMqZGt6JK8/xXOMtOe4I2ZP7Vj15Da7kqg6pH4RyT//A+PmS9wvB+vN0UvTk0cMRs5ArbvecIuCI6wZzjGwZkFAt7Ayg8jOpgpAcEFw3go0RCfOGPIheVl99zhL0/9cinoVrCtKOe8Qz+WioBmDz2WMEddeMbbNxUpl1n+sWm7pgL+elR3RIufPy9TblnNS4toy6pLbGEcA1/JOhs/AXBhFtDUnnKhTRywLGu5JuIHB20CFUka/nxEU3XJTRRcwyKzi5tp+EAzilrDCVkQe3y4LNQHUAhuExSC+j04SCJ3ed4n2RtLb7y0uYFW9pMDn65rD1WqEcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aIfl2+aPEQ1aqxvbEMMk3XsAVY1WEVOPCEAhwT2Pww=;
 b=BOhPmZdi2wM6VJLw6HcthBy30A1kN/fw/0M9Zt4zvgnLuvTVloqUtX1dZSZE20r7ypVtxLhLaQ3mPcHXidDz0gI1VK1tBVq0izVIYbTY0TwjBvNk3uDdmCYutg4tUH1YBdy2fTJXp/9MoV5JsGXk8HvFnGI8bSMDT167beovWvyXdjPxCEbiPaS3F8sUOJeSCwPoAXQ0FJLs2OBJrmwKY/Elo2FZv+ViTiZ0eUHt/MbujlslrfMHFNKh11K2bHF1sGvf5PYdHQkeosfFBur+Fw5UIODi4+WJPj8DKiwseBl5yh37JEKS4CRTeVrM1wVa00UCGe7UKghbcq+1/4Obfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aIfl2+aPEQ1aqxvbEMMk3XsAVY1WEVOPCEAhwT2Pww=;
 b=sEFtjkNkDgDAlbq1h9YWTrTFqrkwlACEl/yiPX+zawzz8tJQZjqZy0N3K/0lbrRL6H/hXejNuN/03ScD8U+rJlo0ePQu/pY8qPDPg3Nx1PDDRZ/jNKX41X22SXTPTC5XyvNWC5MWPjUdf3pCOPFv8L06+2foOlJGsf7e8BFi6eE=
Received: from BN9PR03CA0469.namprd03.prod.outlook.com (2603:10b6:408:139::24)
 by CY4PR12MB1511.namprd12.prod.outlook.com (2603:10b6:910:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 24 Nov
 2021 11:35:23 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::ba) by BN9PR03CA0469.outlook.office365.com
 (2603:10b6:408:139::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 11:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 11:35:22 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 05:35:20 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip ASPM programming on aldebaran
Date: Wed, 24 Nov 2021 19:35:03 +0800
Message-ID: <20211124113503.116178-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86cbf548-2961-4870-810e-08d9af3e804f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1511:
X-Microsoft-Antispam-PRVS: <CY4PR12MB151143E158E10551EAD794B197619@CY4PR12MB1511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hji6Br2FySDyTjkVu4gPXkza44Dg2DOgnybS6WxsPwFeMWU2lClaZLLO59nZMkRijWdf9DQ4SBKQXSLNFK1F7gszHRxcfGfVFupNLeT9L8F5CMVpKig11qg7etDczrLaZk85gX+Fkk//GnFM6lpLhjTG2WmGE0EAxgI09UNrTUCuuzQ50wzqKDzTcV9GnRg1I3iQppJrkA0MLZew0IBGOpig3E3/wnQvUXdEtVib9QfMftr+e1XFPfYj+ZjR5hPiUykJbzgAxrtUXFg6vBDWVlB2yeL+fuqEOCTnzuHFIdB7htkpnUSXoUoLGPtF3B0RVTzfq+x/lJnbn0iocDgxIHIUjsqZEFombryrciCKfHVZeyLsOktc4b4Lt2vW4qR8uquGuAiq4avCpl6+KEbbNVwhDGbq1w1t6WyIGKnZKR8vdAz4eucRup6II2XSPDQ0pqc1H8sUZCPEgA69nkQKnuxoXdirJCRgXBCr+4WG+ZcItEOpJFWX21wlfsd48oCeEYC6aj3g9aOPZ+E2kHZbKJLzv8OoOZxNX6GhkaxEpHjAiOddCI8K/qANXRxrV8+oNzy3sUhyD7buRbvImVqYR1znbzg4pGNruyHc7sG1Y+ry5OHJlrmVA+i/pOByhjQ8LPzc8RUL45+Qk+G2OqEhXFTbdR0BM7JSVN+scx908PQzeZm0d8ii9Fi2lfI4RRTxnERknee8plrRPDC/TC9zhba2DWeYaLRkIUcLcbYZfn8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(6666004)(508600001)(82310400004)(54906003)(2906002)(70586007)(8936002)(44832011)(26005)(8676002)(4744005)(336012)(70206006)(2616005)(16526019)(186003)(426003)(36860700001)(1076003)(356005)(4326008)(316002)(36756003)(47076005)(81166007)(7696005)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 11:35:22.1724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cbf548-2961-4870-810e-08d9af3e804f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1511
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
Cc: Ashish.Pawar@amd.com, Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no need for additional programming, keep the default settings.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index e96516d3fd45..dc5e93756fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -694,6 +694,9 @@ static void nbio_v7_4_program_aspm(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
 
+	if (adev->ip_versions[NBIO_HWIP][0] == IP_VERSION(7, 4, 4))
+		return;
+
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
 	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
 	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
-- 
2.25.1

