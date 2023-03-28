Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB82AC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D7A10E124;
	Tue, 28 Mar 2023 15:06:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2175E10E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGo5AA/ZgkjtFUrA2xMwrc6+vUxogHfiP/3+4Z0wuYJrr5X89QBvlTFFvnEsRtS102IcMM9/kr5Xhjv8WLw+LCNp3oSnJQRGfbiPpW+1V4WmI7QhPb0sI9Gm+cl84ffoOnaHsbQwY+6z/aV13p29O+evs/UCUb1M35//yqNu039mfsovxTUlTfYsKQHhHAAWEpqt6NNlZ0q5rVynm2N16lazla4OZbVWaAPjZKpY+eFzieQPWl2eksFpWODU+4/6Wh4eAC6DA825pOZuv2AUWv0ioKyOm24dxG9zap13BK/2hurbyaQMtG8FwkTgM6xUpmB2B+qzobmikldN5ArB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CrpszSFUlcsI30/S0VVu6FdAH5wMD1/SVCKiG65LYg=;
 b=G5Frq+sIf+yXEuW/bDzDsUTkEeRawaf2HFjxVGR5/yTCYTmd0osbXPS5tyqejbFDiJA6sJwA5UVTOxMJYiSogj90dj8bd64dvpp4FNIV1t1nDA2PEc1C/FsKS5271fZEqnkg0R5lwY+Q0qf8aCNalaDVErGOcoNjaEoAF9D9BWqSWHTdAr/+0/PURNdh7mqlRWJpfijm9n9ZRrc7BQ4Rn6+i25QUfKU2VvMbpK1WgpJaPNpGTmN1V3h8+WS7p7fV69MIKVHGLkFdIfIOLgjIoNG6EetRpGS07OPFYE+koVJlBBSC07RnVQz6v4F5oXWG9VEqZ8nZe4qYTf8Oz0g7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CrpszSFUlcsI30/S0VVu6FdAH5wMD1/SVCKiG65LYg=;
 b=JKkK8Ifol6AFCmOW1EvS9N7zaltd5F7O4l/ZZQQf08xD1NB3VXJbDB2Uk/pBtBcbRpGe4J9curI4SuIVzjijirUpJxePhkxjdL5AUtgtotKIX27BBiCOu6Z8Qzs1P6sQd6ldHA/7Un+VuXBnvgmvdFQaMzDipvXh6Ek1uzY4adk=
Received: from CY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:930:1e::27)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:06:05 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::c0) by CY5PR04CA0007.outlook.office365.com
 (2603:10b6:930:1e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:06:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:06:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu/nbio: update vcn doorbell range
Date: Tue, 28 Mar 2023 11:05:47 -0400
Message-ID: <20230328150550.1933519-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cc3bcc-3ab9-4035-2baa-08db2f9df3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSe8cLKKefFOL5S5LYeQRRN6DxL1SlDP6+sdRUyQxCUN2f9KMlkdsUoLX102lnHkpkN6mCf/rb6yeOIVL16nCZfCtJ/baD8BL0gBOAHM2ffVrwtlFkARh9llfMjzAFgpFFMBwRAbzrb66p6LrEqgXkncXRJh3miejMgw455Jce+IatKQfIHD2KCGCrgG9GXYxPlHu9knuhaOUJKhFVliXKC+7K9Xv/DMIiAi4bMuM+EK2sGJ8OrVrRSMVPHE4X+qo1GOvn39fhXI7/+ppLDyNwtdhVN/HXw0Aj5uSZsuypRz725ISak6fnqU8zZFEu41JqroQggKQGbFHT9yp8DzI80LXuU4qGW/VDnseld8FvRN0GcSm9lKOE5bLglNziCXbMU2LBkliy91wsf0tc2ChJjCmD5MbW9W0zN0DQou2AC5iEFtn/Slaibu8vWJJfvlLKsP+iBQUBxwiHY3T6O/OL39HEG+7HPPs7wGKf72wrg1x+WcF/jNkVa8kyNUiQ8Oct9vb0KcP0uFKxZxTzAwl3WyMjZjGnVFOKFLFXKbVDpeBtS4mJXpUOTTI0VKG1NAga0Ogdv8lAzgczKYShinPswNB4ylJwxg0ixTVVlmWS4CsP97NSZ2kZC3F8vMp+rrq17qqJ95GY3HaDdBBjGskJ53vE62joCRoWyQH1iqIIGf9aon7shKpWYG8HG9DAIb5SJzqX5/fA3sXAgqaUQeSAd3B1L9+bBySMXQlF6xdto=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(82740400003)(8936002)(81166007)(6916009)(4326008)(356005)(70206006)(70586007)(8676002)(41300700001)(40460700003)(40480700001)(2906002)(6666004)(26005)(1076003)(7696005)(16526019)(47076005)(186003)(36756003)(82310400005)(336012)(426003)(2616005)(83380400001)(36860700001)(316002)(86362001)(478600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:06:04.9823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc3bcc-3ab9-4035-2baa-08db2f9df3df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

VCN4.0.3 used up to 16 doorbells per partition.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 5f2270b1d7de..27f456f32f82 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -161,7 +161,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
 				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
-				0x8);
+				0x10);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
@@ -174,7 +174,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x4);
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x8);
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x10);
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
-- 
2.39.2

