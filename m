Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E24C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 17:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5B510FF45;
	Tue, 31 May 2022 17:02:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A6F10FF45
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 17:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqpaw+6RBSFyne94XHc+00KDOQiyObOvSW4CUmcChAWmIk7YFXb/YDYnfE23dOGGUWK8a5av+XKuqH0slbUgZ7HEDMc8A5o67aRfwiDTCFIu3FcZWudG4jarKjRr5BeeuZIemgdEKRV9bMYuAaPozosz2Yzn/PybRYp3aCCYaMYX0IVyVYP8TWtphjeRsWba1MVv6Zv0ilRk4LOoxCAlIV6B0jpoxN5557eLOazvHq5Jrch/WholaXhVbqNDmtGYwcKz99Sef1OPt51w3Pq353dHy4Z9NphWcgsdvYFvFWmBR8HYavMAfyQmn/WavaMANGx9C1e18EiNS1dxMOK8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Bj0RnUAgbfRZvYXKdY4s4SRIwpPdgGLaHue2G22agU=;
 b=SD4FrEGQGJ6MT9VTpKseEhLLO2m8/h687q6MlOlhxJzVNEDu4628O7b24X2Ev0Tz/5wLkP1AHvwn+w+mNwwct2PPTUpqzD0MrDKSbYYJM6M/BvTGN99425mho1DGXu5bGeZkVQgpQXgT1+rnALWOaP/AfYfR2Gjce+PLS0JQJh8KmBgxBC/+8EDZEKnwH8/E4zYiOuE+jt6ZNyeVSLn35PTm0okEKb0sFI54gU+X1ohdJEjeYiP0Pai2nyR9UorYS0uFZCVc4dFlsmKP5/oYH+3bfFXKXb2HKLlL0gsoDSudXrLHHolfPda0432K+GQwp57DLzrCTKuOZHtZvFn0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bj0RnUAgbfRZvYXKdY4s4SRIwpPdgGLaHue2G22agU=;
 b=VUjzldegg08Tr7JRaUI9af/+obTsI2OaZu6ONis1vZdBdO7aFCeRglJMafPaIuDpwNiQ1l4V95XHP1EigNxBKFcnvAftryA8RzDopGY/GaLUmUF1Mdu/CW0WQKh9UcTzMKpzNzBAbizogDq08KFK9mt/4zQ+ecTSN7qSGtUhXEQ=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 17:02:48 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::35) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 17:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 17:02:47 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 12:02:46 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Define config HSA_AMD_P2P to support
 peer-to-peer
Date: Tue, 31 May 2022 12:02:37 -0500
Message-ID: <20220531170237.809884-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a94a6f-f6a7-47bc-f665-08da43276398
X-MS-TrafficTypeDiagnostic: IA1PR12MB6257:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6257C740BFA822D62B7B65CEE3DC9@IA1PR12MB6257.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBGN6b82TyYHoutj4c0m976UT6GAJkzdE2n9thEwX24wXlA3JsAk2ksUzfvv4kbFCCpdIOF5lWB27AwHC7OOaloQulamOUdOjR4q/EBvS1Un6idO5oymw7cnKj9URkVAj/pRiH/aqGpSpLxdM6pINaT0cqXCyDmWakrUu+PL/rE7wIMammbWCP1cHNYjKliYw4hMYG3HnzYIT4ITFYyGHjD+/3cFZcQSHXtVmPH6McSKYZHV70HUwE3E0B6Id9H8qHOtcacJvcyWi+I4EgBsGhLk0kpbU75QduASzeH++UW75RbQX+W6585qiZw3wPrrzn28AI47KZgubTiVOcX7TGLe5XVTLS/2tdJ1RHoVFfmWmubitKiUSc0DS9ckOaLirYpszv2uN71KfG6CbS856lqwg07IusM0J5N4NQybS/adeB2zdl5q/xgW56B7HLeGU3QLUs1vOiuUVINVWWHK2hhbglWaokL+OWRNMAdLrF55angFSDufsSujKOw/+FdQZaC6QPsFtp80yWqMbE5vsKOdEycReYy7GV0+ExGa0cseUwmPo3Owp5Vg4UPSxUbFs4a2Yid30D5XClG+taYNAunV4Ee7Qtsue1c9ayff/FcdeA8EJ30izk0EAlpbMuCkRrr1/5yOjxkvCVubs9hjCJf0wE2blhaAgycI+gHDyBeTA1P/gDSxJe6zMHgG+F9+lmly7/IEH2wB3y/v5AdZSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(16526019)(86362001)(316002)(508600001)(186003)(81166007)(2906002)(36860700001)(1076003)(336012)(6916009)(47076005)(26005)(426003)(356005)(5660300002)(7696005)(40460700003)(83380400001)(8676002)(36756003)(82310400005)(4326008)(70586007)(2616005)(8936002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:02:47.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a94a6f-f6a7-47bc-f665-08da43276398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend current kernel config requirements of amdgpu by adding
config HSA_AMD_P2P. Enabling HSA_AMD_P2P is REQUIRED to support
peer-to-peer communication, in both data and control planes, among
AMD GPU devices that are connected via PCIe and have large BAR vBIOS

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index 8cc0a76ddf9f..26614f5f20ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -25,3 +25,11 @@ config HSA_AMD_SVM
 	  preemptions and one based on page faults. To enable page fault
 	  based memory management on most GFXv9 GPUs, set the module
 	  parameter amdgpu.noretry=0.
+
+config HSA_AMD_P2P
+	bool "HSA kernel driver support for peer-to-peer for AMD GPU devices"
+	depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY 
+	help
+	  Enable this if you want to access AMD GPU peer devices, in both data
+	  and control planes, that are connected via PCIe and have large BAR vBIOS
+
-- 
2.35.1

