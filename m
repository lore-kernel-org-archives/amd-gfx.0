Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B53C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E63112DF6;
	Tue,  6 Feb 2024 20:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cG1+QMLz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD48112DF6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr85rPH9ZLeM0X3Ye0jtAdHHa1Wqs5JUyRKGWJRtcSjODEg9eJJq9dGiVb6PXJ53M2MmhkWSgy4y5Imd7BbzTNX1QqhVRn1ZG8c0EOXx8oqYEQkTxpcgNiEslV6xJ0gToDX2QGcyR+YxsjTCeZsQVjX4rKnba8lPdD5WPmMw0RjsmPsqcbHbpwgMeYqeV74McjODbu+MT4gxNhj7ctBcYgk52mh9KC427BopI8oINl0E8SZIzkkRVfcCngIJKUF0kHAupmDOQo40ngpy7JYMPetcu6ciAblpbKZ5Dpjvq8WLDY/02pOF7KtzVWaiAd+7zNOHZeAB4g4Q1eE3DWMq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxPBpG5A3stAWPGOsCCUGcsLEd57BS3nC6QUl8dyobc=;
 b=I6lmk2pQwSJZ9rQqu9idqiN7qVUhU/TmfQDwhWTj9sFFCMpWMogZJHG9ThnEvB480h37YFLfy+KzruAW/9okhglxVRxMn5/GgmhLVfi9JccVmjF/GfaKkJ7mMWBCnj/fiBQ5ux9WUYjPCZFw/Z/D9X1jcdwRurb26/WWp4fejoZG11i4TtVKGLI0I2dubqSn2WM//AFuHl8aAIv2a2v2pyBbo/NOB/uy7ZaGZAxJwjQbUHsj4kCe0H7LFKGjxfjEpOh0qu7I7mVxupi4BAzsLJV/AOeGdmyH120SiasMewAup+N+PG1IQFXJbgL4ZuZME27JoA5a+bSWAAApl7GH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxPBpG5A3stAWPGOsCCUGcsLEd57BS3nC6QUl8dyobc=;
 b=cG1+QMLzrIeC4hmdj3S5GXuMH2F7y5+iknLWRUfa/xIYPnU5Yi0Uax6EJ+8IBqJLQN0+tqJc/B6KwXTaD2kTZGP6LTseiEqyVHHc31N0w6QdslZ9B9ob+3UKzUbMMlTdFn96Lhycu0fTvZGj4+KnkvOx7pn4ubzrNRvXMTIvJLM=
Received: from BL0PR0102CA0046.prod.exchangelabs.com (2603:10b6:208:25::23) by
 CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Tue, 6 Feb 2024 20:28:01 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::44) by BL0PR0102CA0046.outlook.office365.com
 (2603:10b6:208:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:28:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:27:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] HDP 7.0 Support
Date: Tue, 6 Feb 2024 15:27:41 -0500
Message-ID: <20240206202743.1671739-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acaf76c-6422-49e1-45f0-08dc27521d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL91nLpftXK+yG4r3w82x91+Rht4BOVIEEuXx+yUoJOQOTk64SdiF8lWXbwI5JxRIcfhlilI2RfBgE8I015BPgxEzpHV0mli9rQpsnp4PAfhipmqfMVzu+ilgzBVsBBLkwDf91/HKb86QMejPt7oLmfBW+Ylxomfm65X782w9A80zSY53ZdhjUN9DFFoTFGhDW0cas3F4vHpsaj7sUgfeFKx8nBZ+toEXSJ3RHHoRy5x1Mrm7F7I+F5uxIgh11Su+iHZV0QoDUH0oT3xDlBguGPM6hDPBf26T/9vKgfZqGaTCX73YANHl5wiQYNQOVyQaC/27mXsdOr1P5Hl+LPCtdxOk4onIAH0b0fgJ7LVKxb2uJSvBakWuttEHZsL5WKplXsxmKX/PqXuWJMfCzeCDx9DigIug7Kd9hUTd88ipDSOd+MieascU4hDaV92pZ/JYc8v9p41BXmRHjrLhOFqpF5yx7+d2aTCeK9R4ijkwWJkdGqor7b0Dm5+ArTtwtS6TE2XPSE000wWFp3L23NO8OdZtlIcjcYGXVrJQVtn3oX6a2bLqeaKazWhCFbCLtnfaZAFCn/bgvMD+P362uTEKgdH82W3G74UiGjYZHmJht2naAcrff40ROOHJzB05DHG4BswfyNKTD3ICyK3pGkunjBZBy5/6LMi2j5N6hOsU9ohqgVKbJ3hnUrMYx6jMxXg/R5Wkc6JdO99GyU2ZWdepTZyvPRbEqXKzlfIX6eV85Dfmk6IG4CMLUTwOkq13hK2D2GqBhkeFIAKsNbeny77Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(4744005)(5660300002)(2906002)(36860700001)(41300700001)(16526019)(1076003)(83380400001)(47076005)(426003)(336012)(26005)(86362001)(478600001)(2616005)(7696005)(40480700001)(40460700003)(6666004)(356005)(82740400003)(81166007)(70586007)(8676002)(70206006)(4326008)(316002)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:28:00.8820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acaf76c-6422-49e1-45f0-08dc27521d21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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

This series adds support for HDP 7.0.  HDP (Host Data Path),
provides CPU access to device memory via the PCI BAR.

Patch 1 adds the register headers and is very large, so I've
omitted it.

Hawking Zhang (1):
  drm/amdgpu: Add hdp v7_0_0 ip headers (v3)

Likun Gao (2):
  drm/amdgpu: Add hdp v7_0 ip block support
  drm/amdgpu/discovery: Add hdp v7_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c         | 142 ++++
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h         |  31 +
 .../include/asic_reg/hdp/hdp_7_0_0_offset.h   | 219 ++++++
 .../include/asic_reg/hdp/hdp_7_0_0_sh_mask.h  | 735 ++++++++++++++++++
 6 files changed, 1132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_7_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_7_0_0_sh_mask.h

-- 
2.42.0

