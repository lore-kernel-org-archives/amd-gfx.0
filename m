Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E60DC32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 17:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAE710E7B4;
	Wed, 18 Jan 2023 17:28:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84BC10E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 17:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfFOSHGMyq/3CjEnz6Zjc0f9Ltg9axYpruh+g9jwJUP6ZPnB2zEYLFKZiALXAlpbfBA9OXFpsakwwUi9SdE4oDaBpK7dTgEakhagJKYECgbgyoHyZi9LhDN1u27EkXCFYEAbVAbUiW5QtS3aoaRPhKgOrCIGPPwCB5UIag3gR66J983izxrkXbtcYD1ZXMwGagj6lzZ0UKjOILzf+amp8rD0auQgmYrmCDuhLphS6M2TE1RygHBZ6m+cYMgZmXXvHK/9TTO6XIyFA663DwWTwW2RNmXnrHgj9PlGIiUqHfcl6PFMYBykW7ysTNk7ymmjq0fAPySvH3qJ0Vo8pqOJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgNpR75+yTwMjIaOaLQxw5lH0S9cswexbEybeLixpJ8=;
 b=gmpFYItlvHm/A9OOiLswdwYQIVwQCd78BwKRzhpZivQMnMNJCYRcjB5ZAQnVLKKln/PMoW+jlCY63mEbV+jbwh9BLVMLgdQr2Di03efjajOpyYT+YqXH6v/5Fb1VGVffw5tcXxZBqNMZzcj0ENN2e6txpZRrJJLh9X1h9siQ+SSlnUYMQ2PyZ/LTwMConVHrSbakmzWM75eUQtxIl6ScqPAyIsePAyDaHQArXptOWmEpM0c6uHu5flpL+MzW6hHnmy7KF43rZNnvNddwDdHZ6G0I3VNuvdihyOvXSjhkFxPMKNOvnni0htbU7pu1aewGTTIjmozHcslNAM/jPVGmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgNpR75+yTwMjIaOaLQxw5lH0S9cswexbEybeLixpJ8=;
 b=18jvKMO6Lkz9LfyYuNPkmOgRL+vBf7bqA7gkkjGI0g6WBusyAa+e/T/zwOMYkgMn+hvKwBBwchWfpYQuRfhm+J08alMhRxTJ9ieC2oPxAc/3QjitztON5ULZO9swjIove8QqhSEuYsyo637CsTTFcpwUgoglCr05E2C37WSZbuI=
Received: from MN2PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:160::21)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 17:28:39 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::f0) by MN2PR13CA0008.outlook.office365.com
 (2603:10b6:208:160::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Wed, 18 Jan 2023 17:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 17:28:39 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 11:28:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Update AMD APU IP version docs
Date: Wed, 18 Jan 2023 11:28:37 -0600
Message-ID: <20230118172841.5690-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: d40be094-fe3c-4c6f-b630-08daf979702d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gj3X7oo8k0HT9TPMSBhImof/lDXxyv4vRxLUOs24a+tiMbKxGeOoVdBrPY/BWKV4HSdp5FpLN87hA8jMqmHvrR7sVsVKBcR+YSpN3qykLOO82Yq3KgMzAmQ6yXCDgbL2llqXIQbmzWs5Y/LIQaeVvlXSdelQipXgIdNGHIHdLReWnHiA24fguBFr7HacPMfUzDzI4KQUPV3skfdalVsO6BoT4xBtXRrTphWJIrBRizJPsyb7Qt/n+u3yfjYjOSVHu2bwwXg6dewhfrNGlYBtrg3aVgOfaap2ohRLzmKfWIeMUdrqR9Lo5TRRX4vi2TJbx6XYjCNHGyUCXvzd0fXlhWy8NdERm1C1nQWAiRP22eZw5KjN6ysM5J/ygg0zKxoIrXcKST/FUop8YMkQX03ipq3dqp2HfI0VgWHoDCcSJOQlhwVeEbBFfFPub61noo1vVaBFhq60yaFVUfN3OvVLXaaiPRFZvCXw692ELs+499zsDtja4SMCqvL4gFhuCyVd0HonHxfDPMGGJ/1UBUns//ounEA32R9IYxeVoOfy9Ow9gqj2CdSc4RlehSGm/diNVZDtJgwCAnJyexHHby6XRKolQh9ND6sobkOlX81A3ilzdYJHivQ5yERLDy6U9PEQLN7p7nmY9wdib0V7WdmP+7fUHZ9u1Ctv7Pz9ypk57KZjwrzYiE34lZAxmrMkGLu/qbU8mumk8efd+1NArwaWBrJKn7EA1/tMf8IQzgsmjP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(356005)(8676002)(86362001)(15650500001)(44832011)(4326008)(70586007)(70206006)(6916009)(5660300002)(8936002)(2906002)(36860700001)(81166007)(82740400003)(83380400001)(478600001)(316002)(7696005)(54906003)(40460700003)(82310400005)(47076005)(41300700001)(2616005)(1076003)(186003)(336012)(26005)(426003)(40480700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:28:39.4280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40be094-fe3c-4c6f-b630-08daf979702d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Guilherme G. Piccoli submitted some patches recently to the mailing list
related to removing IP version detection code.  As part of the discussion
it was mentioned that non-obviously some IP blocks are shared between
multiple APU parts.

The example given was for launched products Rembrandt and Mendocino VCN,
but in looking at the existing table I found that we don't actually
indicate the VCN version for Mendocino.

So I added this to the table, and then noticed we're missing references
to some other recently launched products.

So update the table with all missing launched products as well as products
launching this year that don't have IP version changes.

Mario Limonciello (4):
  Documentation/gpu: Add MP0 version to apu-asic-info-table
  Documentation/gpu: Update lines for GREEN_SARDINE and YELLOW_CARP
  Documentation/gpu: Add Mendocino to apu-asic-info-table
  Documentation/gpu: Add Raphael to apu-asic-info-table

 .../gpu/amdgpu/apu-asic-info-table.csv         | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

