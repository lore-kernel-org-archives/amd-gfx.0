Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6CAC4167E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 16:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D961A10E21A;
	Mon,  7 Feb 2022 16:33:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83E810E21A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 16:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvsxhIvHtYTRSGUurCm96k5Y+v95MA3wMWEr2ZgrgHUdHlbSTZxfhJ9DkCFs9IxKfd1Qq14y9PwOkldqQ8lf+kO20fhAmb6RV7q8EOop/beHxv9FrODbGDSI7xThXIdUrqoJbYfLOJSr2H4fEGq6/Tq2vrLc5ij23dXoMITl9MjKq82rJDZeTmlPmAMuI5Q+poZvzcpdWTAKAJNdVw13h1qfnydn7tVMXefEwfQTwFmhSYZ7J10nzuhfWHeS1QosYdJ/rbY9QhavOmqpsFrVaEtmrcGK3c+4p5rG6kfjf27V05p6AKg8ElKp/c03ndt6jmgnHfjYX7Ws/fRDQQ7nTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utqnQA8mw7OSrC+cTPEWWZM10GR7M1D/62uanif5Cfc=;
 b=oeQ1Cu5mVvbPOR7HFnOlTX/KAVLAo02NjDGO+LfvdrIANlEm9nL70sNfBYFlLAwpF8zXGE33cIV2N+Dt89Gs3RLm/zDs/7XEUWK7z2TtM6U7RdK46uovUSuQ2ra/1dCFD80Wq2lYRtjv+HKkVwuWntuRO5CMtPHc1xUHtHE3NxoRtRNYXlygk5/4DxcE3CHqikS+kcV39O9oxlFsz5w9fDUSKFLsYYYyvS0wRgAPV5o1TlsE9qynzV6IP8aLg5UCZsarC3mBNfSzlu/YZWDOiODVKtCAYQIVF3OgzQSBCHFmsIfs376riYnTfMr85JIqQ07vxDqXdXEtQxhlPr7ODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utqnQA8mw7OSrC+cTPEWWZM10GR7M1D/62uanif5Cfc=;
 b=LAsGbtK2bI1zzJXY0GKQpzoYEFbM+aKUN+wrTabSoNT4Fm+iCEIxNtSzTqVSkNfqJTtbGmPhNuuePtT6PLPKm47Gq5v2oLmbsLTulYLLUGVaGumMPWppTeLYtr7IBaOdgJQH/JPjzWx/eHtCRhyjen7vzpzdmqxHEoQiZw13sv8=
Received: from DM5PR2001CA0022.namprd20.prod.outlook.com (2603:10b6:4:16::32)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 16:33:55 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::b0) by DM5PR2001CA0022.outlook.office365.com
 (2603:10b6:4:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Mon, 7 Feb 2022 16:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 16:33:54 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Feb 2022 10:33:52 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/1] Revert Patch from Feb 7 2022 Patchset v2
Date: Mon, 7 Feb 2022 11:33:42 -0500
Message-ID: <20220207163343.39557-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4aaa987-6ef1-445d-e5e1-08d9ea57a205
X-MS-TrafficTypeDiagnostic: BYAPR12MB2966:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2966862286B4E18A0161137FFB2C9@BYAPR12MB2966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImiHE/djkB2iG1ePxtNe83/SQ+fMSZwP7JfnCBVdBWYBG6Q1WR/9x9BzhISWrojm3JstYLXdqOuLlOJTQvtbVbYvEUahqaXfqdy8qJZv+tCboVq1jFx2DqhA5IY8rchR3pURPHFac/TWla+LTe3jru2Zp7MOk23ox/PXELa9eC5ZUIV1+uXW/7YNJKsntBaMp+HsKCviu1ADRHOYYyrlpseQ0UiZLssSpzFJno8wfodN12swYhNNIDHHp9hSdpUwa5CRnyOg0+J6gXviEYj3eL8NovojhJ1NMdpSX4NUIP+u8DyqUueCFA1yIq0m0pnD4gXHpRZQM73TxDAee5+SJ1UIgGAsraazVLpLHHnKE6saBCiPyIs/9kneIcZcJNqDnN4OrcK711DWkEX9dIq8+M0YxOx8ZeudliXc6Ig+h9rXD/zj9ligM5J6+GxfnN5ezsG/vGjzyuz3G+yKpmJ5EdfzGhmqQWLtCvh6sEbjb4ow5hPQKmqJAQTM/XPI08BKCSVIz4XUqpY0YTbH6FvNu7Lfw2sM1rK+0I15Cp+WpSlS2AuKt0YuGsvQ8YVMoNeiXe0YVHqutkYbtz+iHiriNYMg3OGolblB5gbCH6D4HQHKDkZgq8xF/KfUfsG97PDL7/cB2xk0Tl82o0a94k40hy/GEwx/KiGLAKk+KVgTr2swSQ7i/ZUPpd0VgZpIZX6S6WkSXIJqUOUTQjhbNRC1Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(4326008)(1076003)(426003)(336012)(186003)(2616005)(36860700001)(5660300002)(26005)(81166007)(356005)(47076005)(83380400001)(70586007)(70206006)(8676002)(8936002)(40460700003)(6666004)(2906002)(4744005)(82310400004)(508600001)(316002)(36756003)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:33:54.9892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aaa987-6ef1-445d-e5e1-08d9ea57a205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reverting patch

Jasdeep Dhillon (1):
  Revert "drm/amd/display: Basic support with device ID"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++-----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +--
 4 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.25.1

