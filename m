Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C70C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D674F10E380;
	Tue, 22 Nov 2022 05:53:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6649D10E37F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/JXoq2NJ9Qn0dQAHaFqcK/1ahZTYnETY5P2JrHyA3YcIIoZlaN8ctiLz+41Ha7CdCxpx+MzxVFx8DEwHHhF8r9rw6jFf+waiiGE3X/E8/BtLSgpkPgO32rNuc7s/FeFDgbzlq0bOLW/ybniA4Fq3AizXZGlk/lSahRtaxBz/iCpYONVhy2F26hiwyDbgYqK00W5YOOIILZv6iNZ3Sj/fT0zp+mzCXkJo4/wIo5wAJ2RK4MfodIjytl4GHJA7r2WyIJLzhof1dtHE0KQ7p2rdi9WhbTQ8VI/PBmmOzGYM4e0FlhUbh4wdKXcIW1Nr5ykjHvZjuzTBdN5+UI914SdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skl44nHaRgCYO/hdIW7NyVcoZbGUrM3TZad4+wXT1eo=;
 b=PS5EmafQKAgb6gQKZfnrntEG8MAgo6ETjoUxPFPW+G0F3v5hSFoxPhg+726qEBDSikzU5HbZIslVamPGer0uSI3+mCFvEMp8Xgp31J0jMZh2+ltaTF7spgLMuWCVA85c+h4kEhkfWm+R+ljaNNjCVngLr//TxTPqlN2nEGtnLg/qCf9e8ffKzVWQQ341Jtp91b2OL6Oj03XT2Kwr9lnPy39ydNRBF+wNp+Et/i2GFFOQL1gqxQGczLupOEdJZnmhPhOay0hUavTKnMrmR9kHWeGsIWggkK7JiuB3nTZQ/Etqvs3zGsvANcm9XgN2/A9zgMGWc5RXe481CdcAO2TyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skl44nHaRgCYO/hdIW7NyVcoZbGUrM3TZad4+wXT1eo=;
 b=cY+TesREFaz2G+tVGxVUm0O7HXk2WbT5BqIdPMQokEOH6dkApzcTyeqfAjUjcduRs5Aa3/IAf3OwyCQsAaKk6GlP8JNWXOHCkqJosRqKTpVeQ64xD+3qV7GWTt1g86o7/UlWzpEU2pYGLpz/2nBeFLlWmiuXyf8Bi+blKotx+vg=
Received: from DM5PR08CA0039.namprd08.prod.outlook.com (2603:10b6:4:60::28) by
 SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:03 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::9b) by DM5PR08CA0039.outlook.office365.com
 (2603:10b6:4:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:02 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:53:00 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amdkfd: add GC 11.0.4 KFD support
Date: Tue, 22 Nov 2022 13:50:17 +0800
Message-ID: <20221122055025.2104075-11-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|SJ0PR12MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 14269cd5-153b-4315-2123-08dacc4dd1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiXhaYZHuk02gGtIUOCKLQyBH8hlbS4c/MLDrDpIxxXQLqeqqw3vlkmgCWpUVrDpGqdv8G/u2lpo/FpNembW8CgRdiPzthSCwLSqRWNAQ8O825dh1OekjiM85nLaU5T/iMGZSRVfCKCpkod5+itX7SRB62MWkHfFEcnQtZizmGPu2FehLTRKNS7x0650UV3uoLriD9jMWviZX3Wdv6wFmjsDFLAe/aNk9kkAMViT5Gnlp8dfjGRBwriXTr+0l1Fgn8dw3UiKxg03oThmPrO3IRFausAojGdlEE9D9N6vvNr7WZRHximXFaC3Ikp85fr64v+IE02WeFcF5vt1+6mO9+cWxfdaFRQI6xhnY2B+Gt1Xivlqw8hGnscDfMPQ/t+B562PMFNhwEDjySZhTCl7Ch8TaPh/zmyvRC+8fJH6dbBZ+IazESltwYqRYpPpHl2xgGccz58DeQTY3pHnIW5RFqHwI28lJvqTT+SOgjfxBzCMvEOnxBHu+Ly7VsQYHLL2gp0zQuI10iUenjYvZ59CcmmDPMyKC9kiErZZ7E9qa/hWr6C4dlQQiVX+RAFLMq29/pLQXM0KTknl3L4NSKD5cakSwunx7oOrrFWTkP6pJ6ZNByDXHxcs9+xzeQyUkVz3crhzBf/0RsQDe3ypgsmaoKIuYO7YoZ657rohTMDeuzZUc42uE2vmsQSKG1VICdG80C1TkY1JRfKbDFZexmiVoc56FXJ0skHb9vnnclYGgfs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(2906002)(40460700003)(1076003)(70586007)(2616005)(70206006)(41300700001)(40480700001)(36756003)(82310400005)(86362001)(4326008)(7696005)(6916009)(54906003)(356005)(81166007)(426003)(82740400003)(8936002)(47076005)(5660300002)(16526019)(8676002)(186003)(478600001)(316002)(6666004)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:02.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14269cd5-153b-4315-2123-08dacc4dd1a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add initial support for GC 11.0.4 in KFD compute driver.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index af01ba061e1b..3251f4783ba1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1521,6 +1521,7 @@ int kfd_get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pca
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
 		case IP_VERSION(11, 0, 3):
+		case IP_VERSION(11, 0, 4):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev, *pcache_info);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b4d24600e1db..091fc2bb8ce5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -154,6 +154,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	default:
@@ -395,6 +396,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 0, 1):
+		case IP_VERSION(11, 0, 4):
 			gfx_target_version = 110003;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
-- 
2.37.3

