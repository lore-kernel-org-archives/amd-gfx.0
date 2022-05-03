Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F5C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F36910F388;
	Tue,  3 May 2022 20:29:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE90710F37B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGC7HV2b+MyrgLOc68KAkSaC9zzB2Ec8byKX9swTk/Gtjiv7fP8erwIcDCA+PUmo/vPyh0iBsIniNEa5nTSj1HKkuNw5n9YUqA1yqem/J4SMUJCQPByeudT8DniPCgVm7RdyL053i5Z0yQhQNnvq0CgenhHDjdHJ/nKjb+kHCNmnRql95vOt3KhhmYjhOAfbSRrMtq1t+KSVtPPwBPijWOjHNMu//qX83nthtFAsXqpuG5USreYAdPZ/85hLS2c2ZfVQ8pG6L4oRTGIitD2Hp/+S+Yc5sQeElXJHSwiUtPJiG21rYIlOEFhBqFzcegcG3KL88+1G6ramHbH9C+kMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30Kfs9m2tLq6S8GKVpMq/Cl2RA3R2mngD4ZN6sv86GU=;
 b=TjQmqGpkLx/mKIjnpdy+OzZiyz2twxoVZbARn+I42gkzsygc1FnUXuBE/6UmEO44VXaCl1ppVb0+JB46uj3guWDerNuxi1lyc78+T7xURY6q9aruidYex2/CumDlHUhbzvkGGZ9fAu/ek6suy3cSqqLOLAAi3CAN6oNXJHfGOeGIYuzwVYhHhmi4t2uXzzIGau92VcCjlKpDjs+B6fG8FBm00UGbdSAsgrcbMnyySDek3IsInTB+4Sye4rX0IqrqzEb0Eg4KNyhgDhMLhrG0RrXS00So8g9m0BD/+ERJXl8oZi3NSEws9cBCemNA4MaEymII8CEB65ansgvOn+IcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30Kfs9m2tLq6S8GKVpMq/Cl2RA3R2mngD4ZN6sv86GU=;
 b=J1BXEzQGItlLvLWuNZIy4l0xaOzNhoX4DLLtD36/V4+7J206wxLG0YIgZYL6ELgSdKKAZjU1vGB+o1/Y/QPa/r0VjO1jQ4CeQatPTJwDMuFN7QkY7So/VQhI39sCMTThXzXgDnTBc9NNPaLTbGg6TXFaTB1b6lFd/L9Itx6aWP8=
Received: from DM6PR13CA0030.namprd13.prod.outlook.com (2603:10b6:5:bc::43) by
 BN6PR12MB1572.namprd12.prod.outlook.com (2603:10b6:405:3::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:29:36 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::1c) by DM6PR13CA0030.outlook.office365.com
 (2603:10b6:5:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.7 via Frontend
 Transport; Tue, 3 May 2022 20:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add asic support for GC 11.0.2
Date: Tue, 3 May 2022 16:29:08 -0400
Message-ID: <20220503202912.1211009-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48a06701-e6f0-4e6e-1a15-08da2d43a3c1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1572:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB157208992C8415816E3EDCFBF7C09@BN6PR12MB1572.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQe3XH0W0IWIj10q2Mv9R5OPMUaRIleLqpQTlseoAy7Auo8MpW1h1xnUogw+hZOo1tjguKUVDtFF2sx6aZ/Nswci3yElVvOyANHw1pUWOlJKNlD3k0kFLZTbGuZxTwD9sN+QhxuONvtp+cNXfaNzTm6s66jLSoKQfU7m5jEWBR7qd4MkcgVBUmQ0v0N9u/MyXWQHWk0uP3SeFSyz+Y8Hep5DOO5itDoSPFoOV1tU++1oyzHY+7pM0WBriUeFmGXCCbNFpya6CZnhnI8q87e1Cl2/V+e9Oa84dYZoxl3qLF6aQ6I6sEcj/zHW/XCHsGEOV2YTPr+QgNIBUL+DGPJzvpZpg47MdW6DiA8LqKECZ6WBe1uh15LjuEFnHDiSn4PpN4YCAd8pQq6kYLZH1fiFGmST/u5A8hlDaGiWZ2PRrujJvHuDx8Xz1F6nbCzQ/Vz0gmnh953uP49s90p/vjua6PLdUT0cpPvx8yRY/KWFF3fU3ZIlq7e5ai4UCcyxqes0Qy7UwU88dFI2qcHSoJ4r/wa5p6jTCFjmgDlRqF01pIoquiBOkaSWlV47otRtDv1fwDzJmXyj3lOls49vSlH2WIGp4FaA5KqFBAXI9b9/merhuICf5/uNoRuI20knyWA5hJGeL5/Mtd1hk2ZWHxaMXl98JmOoBHRh2rD73Wiw+fA2ryUzzGF3H/4wI/F6McG3vxMqCRJSK1VNISOpDj9zdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(5660300002)(36860700001)(82310400005)(4326008)(70206006)(70586007)(8936002)(8676002)(508600001)(316002)(6916009)(1076003)(54906003)(2906002)(81166007)(6666004)(356005)(26005)(2616005)(36756003)(40460700003)(16526019)(186003)(47076005)(336012)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:35.8809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a06701-e6f0-4e6e-1a15-08da2d43a3c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1572
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Huang <jinhuieric.huang@amd.com>

Changes are inherited from GC 11.0.0.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index e9d79facb83a..765602a2cb47 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1520,6 +1520,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
 		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 2):
 			pcache_info = cache_info;
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3b6f1fc20ea5..ad41e6018ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -137,6 +137,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	default:
@@ -368,6 +369,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110000;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 0, 2):
+			gfx_target_version = 110002;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		default:
 			break;
 		}
-- 
2.35.1

