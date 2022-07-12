Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08761C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 12:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2374933EE;
	Tue, 12 Jul 2022 12:12:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307EA10F82D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 12:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxePgAtdGthfugfxJwE9LONHAH4geBS4BLBwEz8mco4s5A7zxlmgf+4Du7VMLtTW+TpYjbSMCMy4IfTUZf4XSd9gkYFppu6y0s9X1otn9WoWC6FvRZSf8qLfdVbcS/od21ZaZ0nPRDGkM2bxrNB2QJ+x++7tHiHXChP93l7ZAGaO375/j58xwb+MLCYeCcRN4+cO6mpODTmFzKMz/eBILm030alV7A8DinljBOhpVPOiU8j9dDowmhivz3lApWl3mnpx53P75bgreXoR934sAG7l+9Rq7T1iCuMF193BsCRTLq+3I6gKdr3VOM9C4g4S2acVnqOiYWbQYHm93UWmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UEiBUw9yyOOns2HgS9p7VFXYOLFJ5oMEFVYqkOYbps=;
 b=N4UtPKH62Dt/uPE2wJUVT5aVjVOQ+T9Dx/sOJyxXaWynIdfiIEG/fH2PnHvZcID44K+9wBOehRfNkSLV2zNK9xp2w31OcraX7i1lMy2pYrw32t2O7yGYQPK4O09gH6CyuL4YNUYY/KCEj4U/sJIQKzptXEYJKegJ3qNms33SZTIS4K/S7xkugMlAiihX/lse+7czKpuf0hCMWQOVvFoA4DJ19QwbFqoZqSl57Ui3gYN7BSNOkOm++T1cIlb21h8CIpFv5TKemSvNHf52/273MHAOdLBxzxR/oXV9ESYVcNgHqgo3ixkZ35aqsT0sZownDZzwbMth0PfRVpcfQPHiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UEiBUw9yyOOns2HgS9p7VFXYOLFJ5oMEFVYqkOYbps=;
 b=otvVZkuSVJzWstJKmPMBsR8hRTNGXGdEq+w7OL2HUXv4PJruJeahsblVcyiEyqPktyZHeYnjPNX+xxtjN5UWIRPoqgymSmldZC5zAabCaemMFRVoK0bGSR3JNBH+X1gX7ovlBw0lzfnSB06zfO8sVJvj1prTOKtMY+c47BiiNxY=
Received: from BN8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:408:c0::15)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 12:12:43 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::46) by BN8PR15CA0002.outlook.office365.com
 (2603:10b6:408:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 12 Jul 2022 12:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 12:12:43 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 07:12:42 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix acronym typo in glossary
Date: Tue, 12 Jul 2022 08:12:33 -0400
Message-ID: <20220712121233.187868-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27e0bc4-b5f2-4e0d-703e-08da63ffd2e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Kx3/Vkt5cW0DGo51lftXA4Ccu+1vwMY9x13MY7WilZr5zHGclQtbwy+42WWeuX7ROYncHgWtUKOL1Wishyg5JayTszx8q0zL9/5hTh5bB6LW6YIdQSU6Oi01HJculX6BB9sC+vqO66ohKTyadAhw5i5vMsS2KRzfmjVLepmfKyx6+pbmG2R98r2drfvca1W7VbaduLywtNMG1t35Mj8ilyPIF77xynPwD3km+nVb2uaFjBHx2itGSBLOZkZQ7zlkg1B1B+OkcZ3tzv9bRmNd+8CIYV/C/EurGzH5T+hquqzfDGQEMdqgrN7uVNgfiPwJauQ+6OPYGBWFaTyBjpml7otbUEDLUBqXXtOZpUPHxwzWxgsa2TU2hJ+r0S0k1bs1X5hzdlm1DpgAPSo12b9RHx0k9Bdjf6kZ4+GKF9z4aiEeNiKMrkInu3gNava+C9boX2wrdtHeCeF1MdmCVW7AntFSjhSubXrE2/2bNhPXRmhTiWbItYaaECEQB7FmBSicGKXvSCtu3SRb9f1h9PpRnMCsCLo0ASWQ/v89iHRw/M/N0fhLGEUOSAuVxAMOpjMrA2viCpD52chd+O0DicMuoIsp3FtVnd0p/wfDTmaHiJKsaoxv+1UrTK6+E/UzYXnE+F0/ZPQGRwVnG2f3jqYQN+ffQb97lRKh+Oul7PZ/U0ZFC6klkOPDnJ5wgmqB/QOXB15txJpwyAmGAMGzMBtMCM0mfo8rG4qWzxH8rwxDUN3veto67hf7gDVQwg+Ao0I176bf+LVtBWNcFRla1Pg58l/zoc/MVCYDwNVQHLjQrfH2iuoXU8Zie2nHw3ygRs0/8jxSHtgcDpD+nhneoZTQc6JL7E2RlZovI4BnWpdAv8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(316002)(70586007)(83380400001)(7696005)(26005)(336012)(8676002)(81166007)(70206006)(47076005)(40480700001)(6916009)(186003)(4326008)(5660300002)(82310400005)(16526019)(86362001)(41300700001)(2616005)(426003)(2906002)(478600001)(4744005)(44832011)(40460700003)(82740400003)(36756003)(6666004)(36860700001)(1076003)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:12:43.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27e0bc4-b5f2-4e0d-703e-08da63ffd2e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The initialism of RunList Controller is RLC, not RCL

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index db924d37f93e..326896e9800d 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -75,7 +75,7 @@ we have a dedicated glossary for Display Core at
     PSP
         Platform Security Processor
 
-    RCL
+    RLC
       RunList Controller
 
     SDMA
-- 
2.25.1

