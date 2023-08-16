Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CBAC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 11:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2301510E357;
	Wed, 16 Aug 2023 11:33:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4050310E357
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 11:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfndpJQKznrmCtGUDMOrty5LzvagWqPJXTM//oceJgfIrGdGx2crStKUclZO0TUFnsAvrseo1ZBCO96CyzFFM1cuPA1dp8/vtH3fFDgZtmeaI7R/yIAMp100bel8/o8Wpw2O3jp/BAkeUMVdltNRVtym6Nz2eWaSQsmm7FCzSJ6Tinpw8jBThl4MAXtu+NJUvYBC7Aj3nDRmsRFYXhDW0/rT5hYrpbNe0e/3JjsZjfS6Auq7xHaY7rSEQymkjp+WuSTXk2AdrfAug3IBQFJCF+rT1vWmmI1EwKPHAlEUJFxR7Waq793ZJW+vDlCUDpmBP4WtUTL58pUM6zOV8eTBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbq3LHFy0Mfqd381OdUfVaxE2Oo83xkcMZUQaZfqYUU=;
 b=ZC5jHWEZID9IkLGydiHV5r4AMtAUlwwPrfj6fAWqNGU7AymwwI7I2Oh8f4MqWvvZzJd5YDBsBJGC+EdrHj1JapCBOvXfUFo+KovveE/ySYImFzmM1t1ySDkNhcgfVWXHPcKhNlKTUsxk/t6ILmlJg89IkwsI20N4tMyHFlUrn/tQ6EAIQJEfUZ1kGRoNNiZezy7YUuCQKVOenll0cEvYJwYAW4CvjQR3DhEtl1hWg8rcXFz9jQSypMj35OZwEraU34nKZ3GsEWV77lQouyxWzbcECTCyh/VK80BrmY80kfcks9wqts8KQ9R285kyn4vQDMWnFNAHZVXDeti3L18qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbq3LHFy0Mfqd381OdUfVaxE2Oo83xkcMZUQaZfqYUU=;
 b=a6wVpNF/m/WLeXTY3vOpgiGTUlMFn/f1zVoXWO7sMF4ueuMHJ4tZTdNmvjt13bgU1K0fGDZtObh/aIOKytS5uUWSINlerikhkLz42aWPWn/L/BJHGs6ZGg4sPQVbDYU5BaXfZnlS98N4OX3KhEtQUXYNKXpHBALj1j/rkFu2d0s=
Received: from SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::15)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 11:33:15 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e1) by SA1P222CA0126.outlook.office365.com
 (2603:10b6:806:3c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 11:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 11:33:15 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 06:33:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH v2 0/3] Fixup some coccicheck warnings
Date: Wed, 16 Aug 2023 17:02:10 +0530
Message-ID: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: a545a880-7f69-4e44-080b-08db9e4c94e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUxWRFP2rg5EfOJtW6MpXD+SRx+iSPypWDvL9Vh0FUTTb1Zd430o4CwuNhzLmyATZN1Wi5eOswbfLm9DJT3odtUGuY7S/jh/kQano+8i6CMx2il5kh1DdIQ5F1mq6J1jFJeoakViUdF8SqykiIHneAjZUR8pbjMOE/rD2pyZ2AcK/jIn7/mnM+cFfEVbhby/p96ePYzHEvfgk4pwH6tsLFIsLfJzYVglsEPwpeFRLUxxtqPxpGmkzMeOAK6Dx8CbOPsxRUPEWj0jP94j2kxRtZOwsBJLo/2aDv3rXrHawMODz4hJlTgXgsGQskZUylE17ybd9upzIc++adziEDj+49cZ0r3Ka6m77Q/arCa4rLY9WCPMr4ygrNI1HbF9BOoUBPLSMQtprLL3tomcO3sfavQoWuRZwLWFjr7P5/FoupJPVzkq7vzRkqZp080BmeO0aNjH5Z8ZvTBepEmogg2MUo+F0IS/jcJVmXk7+FM9uqedRHaB7Dp8kkU3rv729lYH/fBzHLjO5ADAWa03xTBJ+aJeJ4JvBjyo8zHOJTgATW9zsKQcRAY9UjI7nbG7cDCFx73N+rJabdj2jVRleKm5FNt0t+mG5utnF5+RuLzY2zvqgP2xsFLVFQcO40Nou2q7vfvZgVMrjn+uQPTlx5Pyevd0sLojRMYAixUalmOR/JwumDZsO+QLg+6ixdu79JuXVK2dFw+r1VLG06nITnx+m7f1ay0iJ9YwPuF11ujpEaqlxf+TV/+uPSv74gl4I3znvZ2pP9kKim8BI+ma12JSsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(54906003)(356005)(82740400003)(6636002)(81166007)(110136005)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(44832011)(47076005)(8676002)(4326008)(8936002)(40460700003)(2906002)(4744005)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:33:15.5041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a545a880-7f69-4e44-080b-08db9e4c94e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2:

Updated to max_t/min_t along with commit title message

Srinivasan Shanmugam (3):
  drm/amd/display: Update ternary operator with min_t() in
    'do_aquire_global_lock'
  drm/amdgpu: Update ternary operator with max_t() in
    'amdgpu_fence_wait_polling'
  drm/amdgpu: Update ternary operator with min_t() in
    'amdgpu_ras_eeprom_init'

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

