Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB60C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 09:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037808BED0;
	Thu, 21 Jul 2022 09:52:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B2A8BED0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 09:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di/l50eU3/vhc9Vk30VrzmpaqW9XNdx79Wlr3tkx+h7U4QonaQ4oX0xZ9iBhvOPu2wgmchK2CFg1u7OzPFaixdlHu97kQxVDPhFyLOX1ghwxgwFALviXR3WBuNwRdxXE6OEewNFc7GznI3HFzJ6PInAY8ISbRj8CnLlvd+AzrS4J6WUAJlhryXnLyHZKk9+8d5/SsH2G4OboS35c+YO3SVXOcKrk1OPRpjGPYmX8a4thJ1Sj7lOV9F6RtElyWKji7aZAp3edT5pm0EFDr/n4XnBZMjnJ9kB37JwBqH1ffKYhaK4kKMu20lowRJ02EBMR6INMTbpFhkioO5XSiNMdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SALdbZ4PWqOJUjnN79xtk4Bjt1HYKajsg3rX2nUOjM8=;
 b=ak55tleGxbjyAa/t3MTDLjCioauOIOXC2FwORTqMaEQa1C0r8Lq2S9+hoTHPctl0B/Iw2mHU41oibu+s+pyxySPquotR/mASEFQzQUrvEIHUowqfSvc62fUBSIQJjKTko683LRdguE6oJY/hDmBXPYyIN6J7MMRmC2tiIVWXIpZo4LaloooDQ3UnJxrYpFcoqj/1RZAw00j46AhTwhN8B3RUlFrewD1qJO1ysz9Agc5qimKka/Sl5N0JIeylenyw0BAr1FJDYjBCPDuzSCK8WdLOXJdx2Usc1rwi582praOpU+UD4oA0rRV1lyLC2xhgtpMKuV8O8Rs4sdlMXOeB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SALdbZ4PWqOJUjnN79xtk4Bjt1HYKajsg3rX2nUOjM8=;
 b=wd9ytvo8T1xvX6Xy5mdEJFQSEzBZAHrDhC5MnwikUxDXg4OhO59B9N7sS2clYf6/izT80sUFLpYonS9STb6oWIVQx7aHwQB7GTY2RqD91YiSzCE0cCb93et0uVI2rDxsQn1NIqO4wjHU25/LGQVMNs2xvaCUKXabIIX5c8i7rmI=
Received: from MW4PR03CA0330.namprd03.prod.outlook.com (2603:10b6:303:dd::35)
 by BN6PR1201MB0051.namprd12.prod.outlook.com (2603:10b6:405:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 09:52:41 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::ad) by MW4PR03CA0330.outlook.office365.com
 (2603:10b6:303:dd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Thu, 21 Jul 2022 09:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 09:52:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:39 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 21 Jul 2022 04:52:36 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: sriov remove vcn_4_0 and jpeg_4_0
Date: Thu, 21 Jul 2022 17:52:10 +0800
Message-ID: <20220721095210.37519-6-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721095210.37519-1-horace.chen@amd.com>
References: <20220721095210.37519-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c5d542-d0af-4d16-8148-08da6afec06c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0051:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsOWesM/5k7aV7AzGfI+Qh2G1f9uOWw1BzAISBkFmeahJ2bzrQNrQqqdYWhb3ynuoA8C5FRpPIKMrl5G/xlzeoYtZ+VdV5o0ZqvJSrG4LCeEdX5UcqYDxGuOIc7URu8hiaZbok7tFw8TM1eMNo3RNUcXakJrWXW/BwTWs1TtpA6X7LFxIW1N7QOG/WA7JKVoyCSgTSNrmLlNJo04tJA8XCl8xfBTUdSXdEFfEja7NkfGY2cU8hpL73uka410F3mqeY+rGJ1uR1M54v0m2UJtG76QZmvpgMfI0on+YZARsSYkCLV97Mo3nMFNhUGVXRCTRHBh4nNb08vWM+qUfhMXeK5aE+sIqxDevxHpmOWe6Zzr3f9voRdsXQh9SSqggom29Ngl/+jd5NWB+l8cBOaIhyhEi/rrXhQ63paVh2Z5ffcGasXWaPu2NJH1UH5qnZywYwi9xbUzbCvQ2Cc0Bqv2uHseLNwV8UCYST0GnG/Wg75BzZESQO415mpR1xryPEi/T0wv0tcIBdaepARzTKT7TT2GpycvXUxmcJlgRpoSXqphImtpFhoaFKSyBCLVMCYBWXQhTfFJLaDLCphustq3x1mhONoe9LmRj+SCrs7myPU9P0VqjNsSkgxMFFY+BINTAh6AulQc8iiV0otHvPWV8nCa5K4YRzR0fJYQKDFAbpTcSio7nfJQH/MHmI2KrV1IYKdFiQXWxIuj0KC7+nbb8IgHpQ8qg8cfZgABZhLPcT7JtY00m8wwjST6Vu3I2YHVTwWU0HpqM6Dbv/fIrC9xqSknAnEC4YnoU8qUBs7Sp6DdN28zXq81YJPSDua39rzKqyjoM4iHMYMH5USgAwDHfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(8676002)(82310400005)(2616005)(86362001)(426003)(82740400003)(356005)(81166007)(47076005)(54906003)(336012)(1076003)(186003)(478600001)(70586007)(316002)(70206006)(36860700001)(44832011)(2906002)(26005)(4326008)(40480700001)(5660300002)(7696005)(83380400001)(6666004)(41300700001)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:52:40.7045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5d542-d0af-4d16-8148-08da6afec06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0051
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SRIOV needs to initialize mmsch instead of multimedia engines
directly. So currently remove them for SR-IOV until the code and
firmwares are ready.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f559fda2811f..3f7e1d683df3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1900,8 +1900,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 0, 2):
 		case IP_VERSION(4, 0, 4):
-			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
+			if (!amdgpu_sriov_vf(adev)) {
+				amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+				amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
+			}
 			break;
 		default:
 			dev_err(adev->dev,
-- 
2.25.1

