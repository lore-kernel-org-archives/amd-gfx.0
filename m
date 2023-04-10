Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6019C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 11:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4AD10E2C5;
	Mon, 10 Apr 2023 11:48:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621FD10E2F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 11:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfztfueyC1YpiX4u9o428oek0mhJqDrYrqc5j5TaZh+6TVjgGQPXK52nPxB3Klz8SrSqucZ316IAXLuN0eGYVbsaGd+AbomWB2xdPrwjtD3nCJ6x477/DmZcnOE5NQbAllSObQrAWHFCg7Ejdj9FoBy65QLmMvtxzFjr9NUJuc1Raotjh5TBJtYFzuM6t45gGlU52kfBIDeFGD93ZrTsig2/RXzgsnqmouh09FAjpeUvRfypeUaaj1P+2VyHcEKfs035crs4pN5Azoq9JGxDZbImXoFhoAmF8KF1FZ+RfaAQp4cx9n7Yc270iRgVA4stqFFp6/gdZL6N13/btNeBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzeRyajc1ci26wGrESh8dHOLDwqxcOdpJeWnAn8LdqY=;
 b=J3tIuMSIS5pctM5NHVepOzQ6VComQi0f8pa02HRd0VVzKJ9GF5D3TOUoSXvdmdErMq6j5ximJMrSPEAMHX3onKm32LEA/+ggLYUW1/ht1gEbi+UX4L9ueJTJh4+u4YjtjyTTqFLP4Vsh2PpKMFozEOwteVKDwZmV2rDwCtQ01kPoVywI8stGCITzn2y1xKS2rZKGq89DH7MK4d5292F4LyQTBwnUJaD6Z2oSw2Ju4dK61zMQ019aLdyA9MgL8KvFS9TofWDQr08ofdjUmLc1/KrgjZoVGM4QpKXCBqCWA5yE24LBw/OghxEyL2Q4jJLtzSeaBi4nUutqPZPMPC7skg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzeRyajc1ci26wGrESh8dHOLDwqxcOdpJeWnAn8LdqY=;
 b=Q4LEySMhzn58xz/pY+QxQffvEkodULBOFqzP+tJ9RtOkfHsXl/A552nGzs1qz5nyL8SepvkFBBcnRNXCuiozSkZJzFoVwYcLy2gN0F5eCqNhGFsA7f57ZSiqi9/0hT9lXiAcAI0I8bHWySLn2o3d9834B91dsG2ZU58eqvxy6yg=
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Mon, 10 Apr
 2023 11:48:29 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::23) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 11:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Mon, 10 Apr 2023 11:48:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 06:48:28 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 10 Apr 2023 06:48:27 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Date: Mon, 10 Apr 2023 19:48:22 +0800
Message-ID: <20230410114822.750-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410114822.750-1-Stanley.Yang@amd.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: dd04af4b-f603-462c-ab87-08db39b98084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8lXgok3jhjvNUCmHevl4lkx3xT/YRQrK8v2zQhF/hhazAIVkswPwILXEdMQWOj9JSMX/YhuafN3M92nfyzhgYi2r1zGXkvULdzBU+MpY8gIoIstjw6gXA3pmIwVSDaMyUsrv8XOmmZNOfj1gkuMkyrCxaV2RMjkzJfNZWc1fvWZk6zOgWdUucyWcBqXhw5Cm+4TXzwDPnvmEwyN7Xz3zkPH+J4Se/JmdRxOm+tbWeBJhkSq/MGMM8/dFENFtqmpWQzJn+tC18qrUtcLgFIfmalzXWV8HY6SLgSB6GqxaODefBpwdRvKC5eCAbLw73Y4KZDlmWs8yWiae9RVbgSDiEtBVCqPhrCUdfyA9uHkUoXCUorZFBb3moPEeElQtj8DoQKvSrQpzMQpbt7IZ8ndHSfA1GiplUqFONUEjoxuh4HKXyuIAU3IoeDJjS0rPDciEYpQSLog7JEmjhgyAOaa5lKVrQab9RAW+XHORaPe+xM7Wkw/23RAe/yInURYLeICmF2Wh7ykyjY6WRtSrlfGv5AL+XzWhvqmcDByNGQ5NeB1Yv9K3ZzZhaDabs4M5RWR9PLu5ZH58wmRotvLu1NuEOuHdi+eHSU9CbbHt2Lay+j79nDMXwSVO6y+KPndRl/292QSGXTgp8GTT8tiDuVxOZX2GOEE6XJUVhxXbST8sYdyjrNKnIKvgEFFUIsi84dHXfW8YklKSYHPOezOY3tEhOOosXBfwASGEXxVOiaf/Os=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(2616005)(36860700001)(426003)(47076005)(1076003)(110136005)(7696005)(186003)(478600001)(6666004)(26005)(6636002)(316002)(5660300002)(4744005)(40460700003)(36756003)(81166007)(2906002)(356005)(82740400003)(41300700001)(4326008)(8676002)(70586007)(70206006)(82310400005)(336012)(40480700001)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 11:48:28.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd04af4b-f603-462c-ab87-08db39b98084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XGMI RAS should be according to the gmc xmgi supported flag
and xgmi physical nodes number.

Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4069bce9479f..d26a93272bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2430,6 +2430,14 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 			else
 				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
 							1 << AMDGPU_RAS_BLOCK__JPEG);
+
+			/*
+			 * XGMI RAS is determined by xgmi supported flags
+			 * and xgmi num physical nodes
+			 */
+			if (!adev->gmc.xgmi.supported ||
+			    adev->gmc.xmgi.num_physical_nodes == 0)
+				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
-- 
2.17.1

