Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A89FC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AFD10E9BE;
	Fri,  3 Nov 2023 13:12:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AD410E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSZPRTPHtxcgdBjkSoTJjjGVs4/J6P3T/kSQtUqUfhtdbwBcJ53yWIdQYO96ho1Uufo06ZoCub7Ipo0WCnTAUDWimpMOjEUShj0+oJBfgItjQ4OkHVjc5H7QSi/Fq32p42PEG65uGEUHWXuff9vMvducYa6jRLuqwUSMzv/50FPrNwD4mdWg60mwbBTOFXYdfQaZ0F9z18NM5GfUgQ6Wyei02YCY3Uux49avAlfopYCpejEvlFKDIAlX204wDVOChaSKL5V1RTIcR8sWSZmv2ZwP8kXAPUXkufwe+ZRl7tHRWaYjNvaei07LMma3N/ZuYo+7DsdsutJU+SASV7iO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZiK0cxNyCS9aegZP6qC4ztCu0oZP335usKTwECNFKM=;
 b=R3VAIEc2WpEadl2lIelZNE9oUDTsBZ1+fWfFE/7iKuvxdfGD+NkVCBzNSb6lQqcVne9MzjxiE9tkPAqJ01Fe3Riv/Zp8/0PwJlYhIKFAgprkfpBLN/6+mXGvpAKrFXLdYstfaaqNRXCsnGDo6mNV7O4RxjBZkzaqon/6jA6r7STdG6/beOR3wSJ5vipwo0axhUdaUBqdKwD0QVyZbBP8r/AhtH5r9HohMeGEiyXHmQLr2kff6BrPKh/Xlwl7VhVWxR/25x1uZot1WiBWlseaJfmhHDql/rIAYUjsGmHsR+Qtd75MEeKvZozmmreewjV51tB7pXS9HsA7aR97efEvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZiK0cxNyCS9aegZP6qC4ztCu0oZP335usKTwECNFKM=;
 b=3o3D/R8X0GLgFaQO7ES8ZY2rbLGLarCbYiNQZETWPBnyFcOs5d0qnsPPWYIEwCxonnUj4AEorfPGIor4L/GFGG6awMcbZEoK88Of6QdcqYFRN65n8VFKGyAPAU2j9E48dJ4y4ycDAgxK3PNoyWfByAAkrotYYGmG8wVXef3Jgck=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 13:12:00 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::21) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:00 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:11:58 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/24] drm/amdkfd: enable pc sampling query
Date: Fri, 3 Nov 2023 09:11:18 -0400
Message-ID: <20231103131139.766920-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 512928a0-642a-4c5e-99e9-08dbdc6e7704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gfyn88d//CQS6P7Y9nDsbYJyCaOncnt3YOQk+LVk0fpQhE2Djk+nX2QTZTG0hmzz5BXQIlzwToh52+QjkJzMK72RHtQz4oitn5fvgsFE1bE//6k/6jY9zcY5G6ZcrJECHZSNRxFJKx6tow1EZNOTzTStcYz+6G/wTbbvX8fq81DBy3vLVpxjg17d2vvHxAMHduy/P1OeShV0wJSO/UXEayrz2qQ0COn8ZiOojY8qj4slyK/1xZX4SoS24pohRGE7yzROuYOWRLudJmMD2GFVEnVGm2koLZtGWv+pRnXQ3835wZnecZqwRO7T91eIy0CcsbKmxst+Ij58A91rtE/eeHFWGeYFPUJHywkzF1wersR3DXc1nxMwKhOQktr/FV0MPGGJSxaXCYQL8rg4ZgOJuUrXYyJZplaypoKjneVXN1QzD+av8i3H0rCb298k7fZLGxeVkXKnVyVYGRZzJvO4KIB2w9SAG+4CIGJLn0X47Mx/tFfNCe7Ncgke9vkfd9Bd4f9g8YIvPtbQAAfDKBw7LxnteZP0Lk02FxdtAWgR/VURzKlXvJtcfLa08nwjsTHXpqtiAtVVn7/1GEfZzXO7v6Bz3YFQzAcWgG5IRvwNgEZmt7XZv12oPCdEu1nQzexi2GwA3XvN/EzfsPo1aC0mvmiTzfIE7dOdElmFM5R540dnJTDxEWJW3ns+u/bFO0K4hfmGpD8fjq347Zf/OV3iKXjQsy5bo1EWOmcs1txQ0txDb0iugYuAwrlC0GS0NieD/HlAX1yafLyus64+ORKg7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(336012)(16526019)(26005)(2616005)(40460700003)(1076003)(356005)(86362001)(36756003)(82740400003)(81166007)(426003)(2906002)(83380400001)(5660300002)(6666004)(478600001)(36860700001)(47076005)(7696005)(4326008)(8676002)(54906003)(8936002)(316002)(6916009)(70586007)(70206006)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:00.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512928a0-642a-4c5e-99e9-08dbdc6e7704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling to query system capability.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54 +++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index a7e78ff42d07..49fecbc7013e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -25,10 +25,62 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
 
+struct supported_pc_sample_info {
+	uint32_t ip_version;
+	const struct kfd_pc_sample_info *sample_info;
+};
+
+const struct kfd_pc_sample_info sample_info_hosttrap_9_0_0 = {
+	0, 1, ~0ULL, 0, KFD_IOCTL_PCS_METHOD_HOSTTRAP, KFD_IOCTL_PCS_TYPE_TIME_US };
+
+struct supported_pc_sample_info supported_formats[] = {
+	{ IP_VERSION(9, 4, 1), &sample_info_hosttrap_9_0_0 },
+	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
+};
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	uint64_t sample_offset;
+	int num_method = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version)
+			num_method++;
+
+	if (!num_method) {
+		pr_debug("PC Sampling not supported on GC_HWIP:0x%x.",
+			pdd->dev->adev->ip_versions[GC_HWIP][0]);
+		return -EOPNOTSUPP;
+	}
+
+	if (!user_args->sample_info_ptr) {
+		user_args->num_sample_info = num_method;
+		return 0;
+	}
+
+	if (user_args->num_sample_info < num_method) {
+		user_args->num_sample_info = num_method;
+		pr_debug("Sample info buffer is not large enough, "
+			 "ASIC requires space for %d kfd_pc_sample_info entries.", num_method);
+		return -ENOSPC;
+	}
+
+	sample_offset = user_args->sample_info_ptr;
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version) {
+			int ret = copy_to_user((void __user *) sample_offset,
+				supported_formats[i].sample_info, sizeof(struct kfd_pc_sample_info));
+			if (ret) {
+				pr_debug("Failed to copy PC sampling info to user.");
+				return -EFAULT;
+			}
+			sample_offset += sizeof(struct kfd_pc_sample_info);
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_start(struct kfd_process_device *pdd)
-- 
2.25.1

