Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AD010F069;
	Fri, 18 Feb 2022 16:59:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B7B10EE80
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXWcPqA8gf2Ck2mWLJ5gknhWuxRHFOYW7OacIRb16mdmYxtivY5vbtkhZx0lMykkGgU9FAliT6EMBmNp39IFEFsZMNeZIPDV/0Zb3ocsPeA7kdNV5RTpJUBwpCr26eTpQXJn3C4FFL0BjaR9KncAVSoO4UdZKGX22zguQO8mVaWvOvFwsSxeOxmMqY21zEJTbwo7qNdDlcGaN6hshwsVJ4nRi0JBOA0GlFJN21AH4sirsh49wG0+MtO8szYa3sJvh+X6F3bYmDlTiojDzId2vi/kBb8t8CBHN1tj9tZnWXk3WZLQOC6xNrExzFrMVE629YnoYor6iZrNZYVYcaY1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMH12dDgArRSaLvb6EiCs9Iuwh4F1CMo4DTsMKfiHrY=;
 b=YgjvP57EvNRQuPZfQtaS8RPL0A4kvt6MIyqz1lMGqdOp6JmJUjAYCJK7hwdhGr5ViFvQwju2IonDSbKH2OCStuPRyXcgwFAFJypJJ7QE/ZKd6lYXBo9XVkMgPD23Bp/7h4gt66H9TUwZkEhUuU27M96eoLOKjMiaSenq91kt6T89YzUz+PsEG+IpWxPVQ4Ur7BTBqk6fthWoWa7MpwBLuKSx2LXYjzkGwLL7X8ycbSWCJ3nVyy/TPXWJgSJRK7UOiDq36T+Z8eIiAlXsGr+6fIplkrcNkUyjnrqPXjiPNyhcYzi2dWasa3y680Y7qikiPKNRIuQNNXeY9ciOV4x7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMH12dDgArRSaLvb6EiCs9Iuwh4F1CMo4DTsMKfiHrY=;
 b=hlABbZ9e30PUQR8U+Tjv2XivBvAZHjN4j3nXH5hNZnGrav+hSAyrG2lpjKIP5rvS8dCVD76qFLea42jPfSv7/9A9ixX5F9mVPAmJvgA3xz2dku1J1tTLKwTekHPuxhUqw2Pk5LdU3wYD0xscwpWcHyxTew2nU5FjI0seS2DE+9o=
Received: from MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 16:59:18 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::f8) by MW4PR04CA0335.outlook.office365.com
 (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amdgpu: add dm ip block for dcn 3.1.5
Date: Fri, 18 Feb 2022 11:58:54 -0500
Message-ID: <20220218165854.1417733-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e3ffbb-3d63-46e8-bbe9-08d9f3000002
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40000BD825064D4F56632A6CF7379@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zn/c4yTXIEMpvtVWUrn8mkYYRAVB1GNBpGOs1G4lUu6w4NGtEwHuPfS/vlhZ5vWkIdAMeZb+eQEnQ3O7R5VqwT4dJgacLmSh76w/QMxV2hDLeSxDssWmCvvNAgrtHC96PdUQZthL40/UH/vm7wNa4ByoWTGOjG7l5HH6XH/SmJFMAD900HWXuEChkNJbpYS6nsHlR2c6kq91+lih1nXrXj6CxgZ6gI4DIZlfTeKj6djbsSINbWHUb7nyUlj3A9Qo+z3Mbb2jeZ79rd1nWCgZQrlQF65sERFB2ypSbcDsvGLocsC6LdHcQW0SOMCy4COY4DcGBT19pFv2LyEzgJtygmLOmLg3X6iWGlW/rxcWiKmWjri6/d/uuAhWb5HeWfUmVxJeSexiGN0ZeTIW85f0T51+Mim4kXZeajoka8UFDg69nP3OrlzWUPYOkdPeB9rEL8qfGeXxC7DTjV8OEegqFfp2H5uLJTXCmf1phAZVSjQPQGKHF0wncY0o0iLA2qKZyEAtctlBBMO89pLse10HIZjeoT2xyw6AMYuWe0HEr7Z4S80qknaoc5t731QI3zW5DG9wKNadAvamXJH0Xyje0WzdPIHhSaiXCLKs/waE3vO5GipBpHpK1TbaYVEZuqlUhfxpS6ZnzOIR68Q/MuVdSoKXtUoU78pItRfhToDFp4nL0Rn6mdvQp6GUN7M5MrR4opiAkzdfVJx3wv5jpWgCVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(4326008)(54906003)(8676002)(2906002)(47076005)(82310400004)(7696005)(316002)(40460700003)(81166007)(508600001)(5660300002)(70206006)(36860700001)(70586007)(86362001)(356005)(36756003)(83380400001)(8936002)(2616005)(1076003)(4744005)(26005)(186003)(426003)(336012)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:17.3489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e3ffbb-3d63-46e8-bbe9-08d9f3000002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch adds dm ip block for dcn 3.1.5.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9ec7f723242b..86fb4a761fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1378,6 +1378,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
-- 
2.35.1

