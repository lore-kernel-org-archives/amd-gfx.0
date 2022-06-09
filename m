Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56D7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 10:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBD3113CED;
	Thu,  9 Jun 2022 10:50:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1D3113CCA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 10:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJsJZXQEMDY7Ud8oaZR5oELp8ZLwiGBmrGJHvCUF/v9y/i9HicEzKdUGIZU58rD95EMq+p5X2H2hL0u6NmIqOQzoOzeewlgwS/WTDRaleg0G1OLe/rrta8+2snHs3OjMmYH0aGrDCvxG/GESEEtxk+YfjJmmlTXsbE3lVl48snlv4k/b78cRtc4RbFrmTP6q2VnG+TuzEa+71aVKI+iPe/2m0NwBTbdX/WhwmPapbiAFU1YVV9qBOkh9v++EgGlChFZZNB60Qw94N8N7fljQRfjo/n94tLFCW4MZn6YOGfTCI+jNBtDY1Mk/Z5L7CW99ucL4cdzBYAJ5rhX5zC12Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR1PU416C01xrkEvwGRjzo2CRIJbHx4VGeJ/GF3Zg4E=;
 b=m4Ypxonux8V7NAm4K62smlExjTGMSNUBKLyG8OMxab66BSjz5kZRRHOoCEgVlwhVMNqhkHD1E/f1knusYUfVOY2geU8cVFBMLgkIxLnJjcrEb7U23G6cRCPlxYkP5omqzc8bacx1s8GuV/tvNAAt5Ae94gtsDColL+/KsoSBIwKaoih8AQA6APGxbMHpXcrVAsyNXEYXRAkygF9jlWK6kDy2ydZ6oC8p9tWl4oQTAGZ8MISrRkhzi+hrfEkejR5HRemNIiiVyw0ePR6N+xEm91vGtXgESVUiTvVYTPngafId+05tmyksTKUNbB0o/D3aqcfNor9++TuG0nzps57wSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR1PU416C01xrkEvwGRjzo2CRIJbHx4VGeJ/GF3Zg4E=;
 b=Ny/ZgCxR/3S+JJwXbGTHRTAzbBcAaBzMylqzA3nbrbAIoSl8fogUXHQ0FnJlW36E+aVnPG6I4fAKFb2wREnQ0cx7HkZ5bPZF9qdPFyEuu4K24u+WJvC4lS+CZvpTRsDVVb2LO5ecEvPC/vN2gd3J1zRUQTXTC2cac9x7CSeAOXI=
Received: from BN6PR2001CA0036.namprd20.prod.outlook.com
 (2603:10b6:405:16::22) by BL0PR12MB2819.namprd12.prod.outlook.com
 (2603:10b6:208:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 10:50:31 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::29) by BN6PR2001CA0036.outlook.office365.com
 (2603:10b6:405:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Thu, 9 Jun 2022 10:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 10:50:31 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 05:50:28 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2
Date: Thu, 9 Jun 2022 18:49:09 +0800
Message-ID: <20220609104909.2163905-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a79913ce-a1d9-4cbe-24fe-08da4a05dfdb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2819:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB281971779452817A7720E4A5C1A79@BL0PR12MB2819.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGkREteH39SCMW5TPx4j0sT4zNEvEj9qE45WUzriUHbYVbhUKDVAb52CB57xB//OlzKtpeRqjCtzvWr9ptRTlsHgr+BqDMd56L4uCdP47n8SWn/f68lIdlMp03NhzQwju7HklxnjHpFbHCLpPt7JkDVACU5z6M1qt2+K4mPkXhAa9iub+r1eJeIcB3rdt+0nBIFqBcQ8F+PtAKvbwGY/nfPvfWL/MDNMad5N0bVuJoQ9QhAil1C7TmOX4pq0R3GQ710OMehy9IF4BlDaiSvS0mQvSZkZESu5HTfSYywYI6WdKxw+2NlD5yF5uc1Uxym2tlhNxxjonyaTkocZl+Q2OES2qsnl/NFYEntNynGzR0bYpqdcWlRO6Adk3iKGrk10UA9/+cdfJnac6Pgt9ZtuqAyWlYHTmpk4hXDWyMGQAPO+XiXWpnvOPcGB7eGVzsW7vItRGKwNILQYEOsknHVFBds8k4+ZE54teKaAwUUKY5fztleOCj/7gGiGXv0qeSOmqo2qrFYlVKfdOdM5SX5L10og+xkEu58zjttR3Fr6ToJyX0AYqb6tt3nmx32Pu6A2F9+qoUw72T67RZplX58LfgJBDpxGCbv6PkiqvOooPrmcwLuYnaF9Tq3qPygBoeT7l211QOHHLaaf9Ph7vGAi0Go+5iybYohIRZ/4SSG0IywnTt3CLJcbsS0HBI8Pgibg6sVixTx8p7ZIgGv1Z4X27w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(2906002)(83380400001)(6666004)(426003)(186003)(7696005)(26005)(1076003)(2616005)(16526019)(336012)(47076005)(8936002)(81166007)(356005)(40460700003)(36756003)(54906003)(6916009)(316002)(8676002)(86362001)(4326008)(36860700001)(70586007)(70206006)(4744005)(82310400005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 10:50:31.6694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79913ce-a1d9-4cbe-24fe-08da4a05dfdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Ray.Huang@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable vcn/jpeg 4_0_2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 91f21b725a43..7dd098351a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1888,6 +1888,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
 		case IP_VERSION(4, 0, 0):
+		case IP_VERSION(4, 0, 2):
 		case IP_VERSION(4, 0, 4):
 			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
-- 
2.35.1

