Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED2C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 09:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074BC18A6AE;
	Thu, 21 Jul 2022 09:52:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF42D18AC6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 09:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSCG9rkbpT9B+/5zBQAUOqF/uHHEeLtlHLJwP5X3diTW/HoD1LHlceWQ92gZQko5wRCXTOFmiTR+Q0Oy8GUj/7v6Hbi+irgBF0SznZLVWhAFLQtRNUu4/kxlPmIyqmcwUEN9Y/ZNuFV8sSa/QTjvy3BtKqv4n9foDOSmzg/fPBwm0FH0qb9IYx6yeM5+h1iqA80qDa5mYxVMHoVPFOpOnQLyk5Ul5WpDZn/fqW/yx+jk68mOOrces2tEa4ZvJmBM4LItUQugaRvlFzwfwgUnWUZV3b91m6jb/ubrQIFV+VUgzzgDllGocEfPVxTHoEq/4ot5T+pijPqSmAZqPykF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA4SKQgkKN1sxS4gEZl0rUReMQLIoFYOp3TfIqQDgQ8=;
 b=nq3JLr9UGjkDNOfzYpMt+Ntodmbmelom4QgA+k/SiqwAo813nFOiI5EJWt4FcSwqTpLskejY9tWts0gFa1uSVlafxmoU8lCbpLrVxXLK1BZtkdnzEtxMKYyvdsOES0A3ariYclPyEdhMEHsulG7G5Txz48XmgeH6BDRnAd0d3vnxjhcUBjNIxxtqfM3a555BjHhpC8ULLZ30y3icRvgEIwdWGd+/XzMv568lKbMud7QYBP8+oXNMnabY1NWzL7cOTOAF7/teZrJP9uL9z/ldRAsW0mHQbH+WdWF0owP2BSetcYIN4tjC8kIV0k+e9o9zaIEkvRaVJqgpYoBqP7gHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA4SKQgkKN1sxS4gEZl0rUReMQLIoFYOp3TfIqQDgQ8=;
 b=qkVJ9X0t4k7iIj7m5ZAtv9sHNCM2d3yU5yUHPZGUGKcZKkXBijOP+3YIJOsGz3JHwNgmnaEqiT3OFGstCAK34OB99YfnQ1yKQRcZDoRSOl8S+xHfxDL9ldjKMiyWzS2Z1VMEO22brgBu2F+iIdynH6pyA5G17zagvqipDb9zXlU=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 09:52:18 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::61) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Thu, 21 Jul 2022 09:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 09:52:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 02:52:16 -0700
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 21 Jul 2022 04:52:13 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
Date: Thu, 21 Jul 2022 17:52:05 +0800
Message-ID: <20220721095210.37519-1-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5715a596-afff-4d20-ce0f-08da6afeb2e9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x00CRyMYDUSKBs6Z7Nu8BjTF1Yaa2Or/nQeXrrNxAxZxMmIZye9lBHzl+EjHhvHCIQ0r6FD8EPivkij+3SKOpI4Hys1i7jA8241Mwtm8qr8K8h6WqMeMVdF82r9PAXnGLhSFl5azC8TnGKqwjWEUx+iK1n5tjopNEha/QDcbwM+9qG9Zn09pUKbio0B9b8ZRmMBFhr8rhjA9Wb4eeImip6mmYsrHZlSPT95iCQpXIWL8TcNgnsgPIA5Pt8z3FygWnICUIe/wR7nofOIfBAVMUxZzxDOunXGb/aw2fwajFWsh5YGapkEKUYcRBZDTrR4bSwzuHJ0Yr8kcDpZ113A/inC20hAQ/yg5VEw9QpSxhAIZg/HMZSSOwWUW1vXbu1lyG2VuHuv+QoR626YtoqLCt6U2N6e/1/OP50Bd9SqY5ybFn0TqhhB8YW+yvOQFJGkCT47ybq/PpUph0ZpLq8fB7nvjRN4ZIZxZBYVQ8GCqsV9vHPKPxJZDt8BYTp6+qgD2qivwhis2wZYnSx5IafuYXcBU6No2XlvMBpVkwUkphFxK9qTyhPaIeGqI0p7i/JxqxvBCkicsZ5VGyeujGoXc8vVIB/ceL7EdmXmOVCxU5JnxcJ1DsMuZjAxS948vjAqwBu4S/wWC9HF+CttTDKeIl+gFVEXYm61lE09CKDQpOLOkryTVc2TJDT8WUxRMZQIsBkfCB2wKuWer5ds384+DwcQQ+Ohcuag1MQrl6zsaGazjnoHX/nsd5E7M5eRevOWxWuaajBKDrHQb6tcOovAtHHsHVsz7DB0ZCngVHrYI9eF0Q2WWHQJXU6isLLf6e/fQKVz87mwLXgQ9XML8Y2MRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(40470700004)(6666004)(356005)(2906002)(40480700001)(36860700001)(41300700001)(7696005)(81166007)(83380400001)(47076005)(336012)(82310400005)(82740400003)(8676002)(6916009)(54906003)(44832011)(186003)(426003)(8936002)(316002)(478600001)(2616005)(40460700003)(70206006)(5660300002)(26005)(86362001)(70586007)(4326008)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:52:18.0532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5715a596-afff-4d20-ce0f-08da6afeb2e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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

For further chips we will use CHIP_IP_DISCOVERY, so add this
support for virtualization

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 7d7044e9de2f..ab55602ff534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -705,6 +705,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
+	case CHIP_IP_DISCOVERY:
 		reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
 		break;
 	default: /* other chip doesn't support SRIOV */
@@ -748,6 +749,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 		case CHIP_NAVI10:
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_IP_DISCOVERY:
 			nv_set_virt_ops(adev);
 			/* try send GPU_INIT_DATA request to host */
 			amdgpu_virt_request_init_data(adev);
-- 
2.25.1

