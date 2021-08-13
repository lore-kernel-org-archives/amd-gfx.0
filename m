Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4AC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5EA60FC0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 08:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB5EA60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570F66E560;
	Fri, 13 Aug 2021 08:09:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BD86E560
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 08:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjKKKrX8/bqLbBQ8jLrvbXNd9pfHvvDz7ykdvmCkYXuJYm4u8K7KMj6rCf/WoZ5g8YchTJ9f9ck8G1jc/x0UnYIv16X3vQooGsKWhrUlgbkqfYSAmqdXVugczHdOWxelKjEdRIiREF6Zm1C6z/ySLQay24YH+a3b7O7QbhCU5a2AsdkW+cE/4+/ztac8Tyd0W9NtzhXzvOdWpO/bPwteEMy9LzFTo6rz5LP9h7SN2QnZGJ7s8T0CpAp1NwUEZ5QZ+q1VsNMe5xYdA/lKgrhyIN3JEn7Kju6MlXaqgTQkF2LlxfzTfofs5dLXv2VNLzAtnSe96HwVbuD3CgbG6Z269Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmHJiIbvU1xyVsAMtPnmRPxerZGLEoeqzh4udA3GicA=;
 b=CDUkwv4ZNEoGUrP0IBYNr9p1THrLwqIU/8zQ3nIWa7eh0fPX2HuzIMe1/bp8eHeqmCplryj5QTsfz5wSqadBOwDjQGz41JujaHpytvZ0sh4CYZbJSoU1wr9gI4C5Vm8NpXzk6Ou9xiiIYFjwkUwgkChzIjGPAxpEm2QY7ciBuz6oJs75IApD4BNvEbnlwwTWS3jz377ecPjgyYqAOFvMjJ7S3GDNsyOtk+09C1pnPv7zPhoSJmlz9EmPtj+FF2RAjuON3DQZ+yDUiuNcGO+1urYpD0/YcyWM6sUpxx2VVBDp0CbPcrexdPpMTF7stluT/8bLkWInz1SF+sNgQ9K6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmHJiIbvU1xyVsAMtPnmRPxerZGLEoeqzh4udA3GicA=;
 b=VdPoCBO25sTP/B27t9AEeCfdTk4gxvIf7rMi30xrk9jfEW2VGc6wETqJrjTcY6K1AuuSr+shw5RwrAR7K5t/9jb6SPxAf+Up3R7+p5wWsxeo+/xwkR7mg9AUMMaj/E6ynIoPDuyDmbRuIr2P+wdV37cEdaqHe8DVXz1zOemu0Fg=
Received: from MWHPR17CA0075.namprd17.prod.outlook.com (2603:10b6:300:c2::13)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 08:09:51 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::8a) by MWHPR17CA0075.outlook.office365.com
 (2603:10b6:300:c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Fri, 13 Aug 2021 08:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 08:09:50 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 03:09:48 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, Evan Quan
 <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU
 temporarily
Date: Fri, 13 Aug 2021 16:09:33 +0800
Message-ID: <20210813080933.1348241-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 858e0c63-15ac-4fef-772a-08d95e31b9a1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2631:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2631AF8FC2C31294B1A06BE9E4FA9@BYAPR12MB2631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYuA+rQhmAtY8tb9XhczRte/p1YNAjbT0LIf/2gEfHvQY/FTiIeIxq2CKXdGz88ydxNbZhsfAjChcB8Z9Ws8ZBmwOJQhtj7kgD/Uz2VCAVniZy/eh/dH0DmSCdCD/eb96gJcfdto8S6yti5IaFTzrbLQUExCGKzsso2egSeWu+bhgyUfi/CisMdfn/TrWjRD9lF/l11ltzG5a5yblxoi/SX8K5hpX6FTB/IKVxH6Vvmi9cBdC9tZkbC2y8+ujLs1aSF+WJ74eyuCcxrW+zhlLW8b31Yi/NrIJY4/KU43RUn4Akqk5dX5UFvJWt0grYou/J6gvV1EwPZy1tUWPd91iaMFzzWdEBDdaNk7Yniw6ZfVltE31L8ekYS/h98l0nyzV1jqj9Lxcz88idjSTYVeCN7pDIebYJAzWsUTto+XCIRH0QMTNF1qjvvysJ9/Fm+JpY6h7lAyWkKjp7LFktcrJyaFjx4zg3Oe+a7e9Xx8X3TH6XSzkidA6sje/m+G3JFujul5gsxWUS9FMQTqi5/3LLain7aTTtYodfzBZ+1qpiswtsJ7gRZjYftrgdJruyIM/yL27L18uH32P0cWlsWmbmaxgaNX9RGA2Lre1cnBSwh4LaT3ttslVZ9jog+6FDykDBh3wxEQmmzj2Cs4aw23c0w5Qrcu4nCpYEdq/06FwyYnNJ4jBQj/XiSe0r7RK/l9YUmH5SpCpvNa+Fq5Odww8f/SfvKWZqR1+QUa+xuHAJIs40gzgVuRq4CAG6Q/CP2KYWzalbzlVdNA8gfXdEP7fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(83380400001)(6666004)(5660300002)(6916009)(36756003)(70586007)(316002)(2906002)(81166007)(34020700004)(47076005)(4744005)(82310400003)(36860700001)(54906003)(82740400003)(8676002)(7696005)(70206006)(1076003)(8936002)(26005)(4326008)(186003)(336012)(426003)(86362001)(2616005)(44832011)(356005)(16526019)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 08:09:50.8781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858e0c63-15ac-4fef-772a-08d95e31b9a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have a S3 issue on that SKU with BACO enabled. Will bring back this
when that root caused.

Change-Id: I56d4830e6275e20a415808896eecbadfe944070b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index fe9a7cc8d9eb..7210f80815b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -904,7 +904,12 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		return amdgpu_dpm_is_baco_supported(adev);
+		/* Disable BACO support for the specific polaris12 SKU temporarily */
+		if ((adev->pdev->device == 0x699F) &&
+		    (adev->pdev->revision == 0xC7))
+			return false;
+		else
+			return amdgpu_dpm_is_baco_supported(adev);
 	default:
 		return false;
 	}
-- 
2.29.0

