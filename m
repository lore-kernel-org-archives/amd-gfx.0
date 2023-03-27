Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D58DC761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3616F10E737;
	Mon, 27 Mar 2023 19:37:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962C010E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwbrXeedNUD6lsx6sJ+m+Y2DeG2tm1jZXCyZPiovIDU2/QCBxHDQnp1NFQhVG4U4bILGi/uyQDoz8XzHLBt1bSYTRBDjaMxCYrTEmjYLLgnBKt3U8MEZYk9E7lrWV5u5G6zM0L/2rogOg+Yp8E3je0qkSArfviVDkAk2LtR6kP77GvqaWaJiuwOfokYJ2eAH7QMYh12LtXe+KcapHHySvrSihRUHYubNMXPngl9EMgzfIfcfgLr7/53orvRzB7SPZ6284xsOr2MpKffEK28reVLJiSM38KIcHMxl2ek7PV2qoESraKrYfJyLWH+b6b6fmNTRAwzxnINtXdlmLMsqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYd2wlorWKtuh+aleUpDAya2Uv8atod6F8YvDIDUJvo=;
 b=VwCNCvRhShrtCWUXKRcIP0ZEawQUqOTBTyimi58uWm5rpQnTnaF2vIxt+TX9XQHkwK3SiwjMjEPtmUcptMTU6Zdg2OfqPcdlnXCOCbVE7VK3lcl4OeB4t5MoS2uDAiTMQfHmYeKzqTH/gbgAP+r2vUvG2/ScBn1YF9BdZcYmVfFJ0P2HL7uJZG7xwbhDGfXg1LBgcJhX/bZYEUCfIUkr6K9c9j7B63drOJh1/g6otZB3C/vPdpObHeJOG1iTzNhlAIz0cULjXnAks7ymJ8EYANnDaOdqD0LKuiDKBOwMMG2Or7Yqn/I48cBTJ1PkURNO6qLCBZCgBbB1oMrCWz6R8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYd2wlorWKtuh+aleUpDAya2Uv8atod6F8YvDIDUJvo=;
 b=mDr8Um0N1zQnC1gKEf7EyHZ8DADdVkSnFJ/u2xKwPawyDdKZ+TJ+Q769VT4vSGJ1xjU79d7fnxtuWNWRmIfV1n2407sWzfNwBJizILIgx+h9VoBy4XuhW1gDJ5t6gPbv8jqcUuRzwPHnuMuuc/qOh/9KmZm/F42IQ5ewI2KKXtM=
Received: from BL1PR13CA0376.namprd13.prod.outlook.com (2603:10b6:208:2c0::21)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 19:36:33 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a0) by BL1PR13CA0376.outlook.office365.com
 (2603:10b6:208:2c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/28] drm/amdgpu: init vmhubs bitmask for GC 9.4.3
Date: Mon, 27 Mar 2023 15:35:54 -0400
Message-ID: <20230327193602.7901-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 562298f1-d172-4c26-efde-08db2efa9285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjsiEBYeod0j7CpoTtIcolqBEybvDIFaYkvrLjzBB5PIEp9nNu1lNYmHrPPRJI2wGECpJF/1VDrJtZxQrzTu4h3ALSAc2mmzWQoEgFEPznTIyIDMskrVHQZscDOjXkjqIDKAzx6Ri+U5F+o0DaYcsnrdjvNX7RTsCuYKH7WbZKkf+G4T7OVfwZLAoxHjorT7Wt1oQZ69w049mx/kdzmPoLWbcIDbpP8j2ToPoC7mPisQLX2LhxDPotnK974EK1LB29FjLUz7fEVuuxbwyCub8BknTm/5OsMCgEUE19fe0++MxXouMSdpU1ukzv4l8k9XbX7kKipmuxW4JrV8TaRBJJIvFay87gVtAbvh++7bGzPU1xk412AMA70eWc9m37AQ+Dd4lABi4Hrvzw4dOffCs+E/sq+J1jgTBbbHwgm63WkV6xOgsaDN7bzSrFlWJGK6Li4vcpsv3WqU0ClyhtA0TEJ0Hl+k+XDH/0ZBRXfMB+0D9WFbBgOYrdR/B+Nn4DW2OP3Qnty7d0Ri3xQvQjuB/fHQKRzQKc+wlnbYQtEFcNFYWUH3RppzQYLwRKtcrrlgtibpV0ur71+b1I+eCMzGWq4TZYLGjfB6LyZYDbcc6uhYOWSrc8FijRJJ4aGiss8B6GI1hrMne98I0tCxZmtOEhy1i5SuRU+P2v5GZqb0EyFn6c109OMnpUUqYXWwLrlKCr0WPxh95f9iL0DMyeyoR5y+5CboRCZB7OAUO8OMZ8U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(426003)(1076003)(40480700001)(41300700001)(186003)(6666004)(7696005)(83380400001)(336012)(2616005)(47076005)(66574015)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(70586007)(8676002)(6916009)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:33.7697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562298f1-d172-4c26-efde-08db2efa9285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Each XCD owns one GFXHUB.

v2: switch to the new VMHUB layout

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ce9ae3a5a9c5..63ea9dabe999 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1684,7 +1684,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 2):
-	case IP_VERSION(9, 4, 3):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 
@@ -1710,6 +1709,12 @@ static int gmc_v9_0_sw_init(void *handle)
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
+	case IP_VERSION(9, 4, 3):
+		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0), adev->gfx.num_xcd);
+		bitmap_set(adev->vmhubs_mask, AMDGPU_MMHUB0(0), 1);
+
+		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2

