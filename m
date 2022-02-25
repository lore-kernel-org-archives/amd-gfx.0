Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D463C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DE510E90F;
	Fri, 25 Feb 2022 18:06:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E45010E90E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWrEMqcFO1am0lqJTFGRkIOvW2d+bCXYOpDb8ACQx5sz/IvBg0op3ZhO3oxImtnsHcl9zXjaFPL569AaFtKeH6CXR/Efng0M87DuBNpfhyOnPMofSXdRMu9bTe7DLq7T7a8hbnBhfcp0BlJw5SL5bprrlo7EE2cR2BLcVifddRs242Tf1EST45Bx973nwmOEt3orjKMQYLeu1yPzjYo2CJcaHFOtc194C+xwt2Qz1H3b7RAMdsrYnrUIRYkxUyHS0dApzG6XwtpR9PSORSpMWt9OkR5XUED+NFm/L+1sus7y2kEFT/Ope7VVNp266zWzMxkNZe3OnOFG8kGjeF8a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SIak23hKqZWUwE2Mrjer9CDMkDlCxA5r2fdiRkdN4o=;
 b=FWnFhJWYh3cuqYJsEvKlv++h5Dk1pFvHkAYtEbWjOqTt2tPGWGlMz8jMhM7bF/x0AiP3pouud3nwQT+ZPDzwH2qmeVFxh9MAdp37J00lNxUqvyWz5g5gMn3BFgKOXX94U4ntVENBjgdo/Lib4KQAd5PH8LrYxOcmRMt8xcKbgA5gE8+HYE/1K4Uv730Y5U58puvH/OUtSdIT+0FThx4A3/Rss1LTp4iy/AGCzJrgM8X6nQVhWd29ielmXBnAIRwwX/6Twpbwz1t0jW3An1FHPlhiXHSAAbBKeeuO6vpwZSlAE5KZ7ynAfYffuZ6LBSdjjmrhM6r8OhVdtZZ0ad2bnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SIak23hKqZWUwE2Mrjer9CDMkDlCxA5r2fdiRkdN4o=;
 b=1LRD9Vq7UUqM+CuRDkMNWLRKpNp+KcVEKPiQUvvjTqSR0LJZhv6A8CcfMa8OXICb6cZqhGZLtV+pDqLhMWK03hLSe+ROiqx8+sOfy4krkpmZfOiVumtq048LBGnFFwpvZskbk9i1b4ilVP78eJ4ih9LoJzi7/8U6J131HXmCAUI=
Received: from BN9P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::13)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 18:06:42 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::ff) by BN9P220CA0008.outlook.office365.com
 (2603:10b6:408:13e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:42 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 9/9] drm/amdkfd: Bump KFD API version for SMI profiling
 event
Date: Fri, 25 Feb 2022 13:06:19 -0500
Message-ID: <20220225180619.21732-10-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225180619.21732-1-Philip.Yang@amd.com>
References: <20220225180619.21732-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7eae43-bcc3-46c0-48ba-08d9f88993dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB383460C15004256D36D80C79E63E9@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKb47SrZHS7rDrhRPm56Szy5BBEj3aXLorUTnTCNVwrqGVyaKtYRJqReGpG6o8u8yg4u4s/oG51OL7hg/8LfvOnEMcs4w7L7NKhoyLzUu/LTf90uyd6SXTo0M5amnhfO75BJroSq0IjOzoOwJnaIaq74Rz060nBuZF/YN0AB0fEMs5zXqOW6XXK0kmn02NQLW+sE75j66W+HR8dV7k82DJy7VA0kfDB/EJmI9+O8sMYKs92QINb0baHazcKEvynH3LxJgIrMI6I3Rxrt/ZmN+RmHfUy764/trcZgAr6BxxUnmLOCp/PXTuinUaNRx3ZKKz3Wxa0STxqIIUBA5fH2IvQvT4hk1RWYUXHeg7FRm5wNxY5LAVCJa2cbkQJDRhptymTZ647VBOvOb7QoHR+krswSz7miYyXEmBo+O7ZR9DZSMoD9UC3DIKQ1ygG467DO3gcuFQgw8bvlmgi36+JxsOYsjDGhAighFFWGlBFtR5A+hXO52xVBILCM3pSadBqAYntYS4gtotQjKtN+j4XLKRzpwpjbuAYAt0pV3V+uv5GQtNjU0Qj621EM5o4oEpphXuZd8t3aoUgzBB5XnAzqM8wTpStvYZy17R3wzzFf2sardIeAS/UD8hyn5Z6poX4JflK5VJ+gtJenecU8kAzhneZOz5cZXc1Cy//DtR/sVM87J+2nVeMy0mSSWqVY7vykpfzkLyvIZIrhcb1IeJFfcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(54906003)(6916009)(5660300002)(4744005)(86362001)(8936002)(70586007)(70206006)(81166007)(356005)(2906002)(4326008)(8676002)(47076005)(7696005)(36756003)(36860700001)(1076003)(83380400001)(6666004)(2616005)(508600001)(16526019)(186003)(40460700003)(426003)(26005)(336012)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:42.3906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7eae43-bcc3-46c0-48ba-08d9f88993dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Indicate SMI profiling events available,

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 45e3c2a5cf47..a1ea9944cc8f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -33,9 +33,10 @@
  * - 1.5 - Add SVM API
  * - 1.6 - Query clear flags in SVM get_attr API
  * - 1.7 - Checkpoint Restore (CRIU) API
+ * - 1.8 - Add SMI profiler event log
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 7
+#define KFD_IOCTL_MINOR_VERSION 8
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.17.1

