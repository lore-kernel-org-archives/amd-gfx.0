Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D3C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 01:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF93F60EFE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 01:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF93F60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C4A6E040;
	Fri, 27 Aug 2021 01:29:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A751B6E040
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 01:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmtyU9lA08erCHCkvUCHjqOXc3O4DaCaPKEioegKa9jE0aXNK7uFPt7vtf79M4broVjoIiGMKt7J9JxRjGfZJ1a4L17iSfcQjNOTRXd9EJL9M9/SB1599DjGN9eP7LSVVHbxhqlHLMVO3WKJ91z7I/IpYiBFwso9qS+4eQy40XxzcN3faFRAtSSDX7SkErIP4RU++G4aQUM/e5dcafHvoTmEYpaPtCnRNWSPrZwhHzd3dskmQ5iIIeZijhsVZU6D3q4aFdx9WtRpUl5IA8uaezo26XMIFDHjvDM/DATf2BOEomJXn81OA0M2jOrbLeq/x+9odBhFXec/1oHSWBwKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVYSaH0vuchkSUG37kADz4lQSyQFa55iy4Zw3nTp5TI=;
 b=EFM7pMf+6UMqthd/1qGFzy2FR0s2qAOiqQA48/L8Y83Xo/gt4HUWjD5VfjMjz+ZzJuOKV1dK6x9W0Rb+wfp1wc6rKEnJKP2HC/rjpRcZ1MG4syDclruSxRkHof0FxcVX+QV5NERPv9fi9RtuEyOmm9xPYcTkxAGXC+cybY0LiRo2pSYkMSH7jsy0DBipwVwdHEM3IFcPZ8QWQQqKs7oEQSdXGKx8rEfPMrcSuukM9KxEHaRwCm0BmcQzaZ82Kdq5TFd1e7L+CjIbAmQf81usr2WY5Vyqjc16bT1ox6NPxhqHxZhrnLPVy7ndW+ri0zi535AVoc6bgQL5dwvRKraOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVYSaH0vuchkSUG37kADz4lQSyQFa55iy4Zw3nTp5TI=;
 b=bU02fuT89yuQpByQQktDMbkzK8C9+64oHbBgYTXSRnRJtnwoNlgQNf4n4sg+hlC1Bq3KNhpHuF2OJ4V00heuCSOqixJEoVLtXoP7sXUgiBBv3qmTFnEYYyAql8n0YiEYitD3qATC198twj+cDwPYftmZd/HJ6lYDOXXYrL4m+4A=
Received: from CO2PR06CA0076.namprd06.prod.outlook.com (2603:10b6:104:3::34)
 by MN2PR12MB3648.namprd12.prod.outlook.com (2603:10b6:208:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 01:29:24 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::6a) by CO2PR06CA0076.outlook.office365.com
 (2603:10b6:104:3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 01:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 01:29:23 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 20:29:20 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Ray.Huang@amd.com>,
 <nicholas.kazlauskas@amd.com>, Aaron Liu <aaron.liu@amd.com>, Huang Rui
 <ray.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable S/G for Yellow Carp
Date: Fri, 27 Aug 2021 09:29:06 +0800
Message-ID: <20210827012907.2348995-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88241b75-c106-4ef4-69f0-08d968fa1a1b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3648:
X-Microsoft-Antispam-PRVS: <MN2PR12MB364836EDE157E88D84271492F0C89@MN2PR12MB3648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CH0XLlbHyZ+gt3wUxaliWWX+RA5XQYPL0yQkb20uo5dn3sRYYDhMtSiM04dR19snrJIiRHjsU0P9UTGYIIJvrY66/rjpHu1w9mirgquEHqexsCYZIs7W8XOaTWIWwnOQy8PyyJApWBnA3gEGDnONk61c7DLZqB8y2SLZkHEmVa7pdeaulZDjspvKRcA3+oWQzPnLrtXD9ZyyqTGu7fViqBlxh1P7ErB/yybKfINQbe9k79/VtNn9aQ3z7u2QgaHj6KYaQye0uFexEz9syASg0gvxidCVi2h4BmKB+ssd8/kQj1L6nXOAYxzpKnK40CNMqC6rRA9LmuBDF8wi9ciaxWGaB9CJHT4op7G6hyWoZGX1A4DNbomjgZoi20cNHRg4fa1SLAyXQqqrtT54VR+xp0cWchYWNtn/zP+/xK2KKDm5K9G9d4uaW00e0G6F220el1nyq0L01xNhLG/2jB50zI4EtPM0hldmdngCWcqhXsRUnw4LSJARjsD9LVUtkZRfPzvTBmGCVUcIIE/OrwT2Rx5zxAvllYVskbU3CASTpo0oEdsCypQb1z41wqHrG9BNaFttZa9zEvU+DkQ/o29CKGNp8F0oAHN4mP021wUe3pAL84PORbYinlMbr0OYo5vYr16AKdc8svZkp1+ru+onjKkOW3ze3JPNLgo/5k2PzCoTaFE/8OhDO1DuvzapkeLStBHKSvTu/KGKDiaCAEmgcLwSJ6VKswrAMPSyW9UW12g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(6916009)(26005)(2906002)(6666004)(1076003)(356005)(86362001)(54906003)(70206006)(36756003)(8676002)(4744005)(70586007)(508600001)(4326008)(2616005)(47076005)(5660300002)(16526019)(44832011)(8936002)(36860700001)(336012)(81166007)(426003)(7696005)(82310400003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 01:29:23.7053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88241b75-c106-4ef4-69f0-08d968fa1a1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3648
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Missing code for Yellow Carp to enable scatter gather - follows how
DCN21 support was added.

Tested that 8k framebuffer allocation and display can now succeed after
applying the patch.

v2: Add hookup in DM

Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 8e5a7ac8c36f..7a7316731911 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -522,6 +522,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 			break;
 		case CHIP_RENOIR:
 		case CHIP_VANGOGH:
+		case CHIP_YELLOW_CARP:
 			domain |= AMDGPU_GEM_DOMAIN_GTT;
 			break;
 
-- 
2.25.1

