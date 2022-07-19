Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C42CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 18:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F938DA5D;
	Tue, 19 Jul 2022 18:26:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7BE14B7C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 18:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBgGDClPpSXqnyg/ucDy0wA6g/G1seBSbCavsjFXESz3PxTuqs1sw9hIEGjA/g4g+D44xskPUdbuUYnYh2HQR7cgSWYqZidJNZAYhRBHa16vYkt2d9zrjzIQxeXKk8aijOSYLmO9bvV9npCqV+xpgSiQNzkYyjd1CYf2yXDagdoPZvozPUqdNMNranbUCVvk5dQIaLfOjlBGLn6JIWRLS7BXB7HzRg3UFPPOfNGWfeYqzHi3xXwsT3nbEEIkQpU5rpUN9VboyALUtF766g6vMVkoTcolIOr/9ataxRRKtuYgHvstrEUvOFtbixOpItolM/GwoS1+pmuw1da7H2DxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOOE7J79ww1QDfU2rcBscPBmUo7XDv9MebTX4msuGYE=;
 b=FnbvEGI4kjgG+TtW7D/OokqfRJRYddcusipOePhuIefVntrOXhwXWJtrbcepXOHx4HRqKdAQzNZwWen61z2vlWYIN4hKYxz5SPm1Aoue/N7cUWA6Hwss+8k4ymO9CQyzpqL7IihwJF8k525KHuxbJlHEUxas9AgpmnjQbsQ4PT89c/Jr2VGXzTdUxKerm6Xqbo63w/qXfnWoYf6YxrAHcdcplo0EJ/7pyQ99GEmxWNrxVj67Ee62HeXTcc0Muc+I0rcnu3626lL82sdI0gnpoUJo7dYDA5phrQQw+Ccdc52GfNqEuk88DsDBMiYPObMpv0rkHJ+8yFCKxZSbkAsp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOOE7J79ww1QDfU2rcBscPBmUo7XDv9MebTX4msuGYE=;
 b=rTclloMWgdp17DCqB8UHRhsvoCBGkCsgisS8cXxAJcVXE0Es8LaxnhNgZiL99N/iGIvCmCaS27gSQzMiAVZn5bNlbTDLo9nRvvoBlkprRb0DsvF3HCBYkrnHcug65v9p3MImUEX+zTv0iC3N50joZ9luOIEEPvbVyYYo79CGIJY=
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 18:26:53 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::59) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Tue, 19 Jul 2022 18:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 19 Jul 2022 18:26:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 13:26:50 -0500
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 19 Jul 2022 13:26:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Disable dmcu fw loading for dcn314
Date: Tue, 19 Jul 2022 14:26:45 -0400
Message-ID: <20220719182646.23049-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa12d955-299c-4389-f766-08da69b4409c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eG3vU019tLsvwNtXuCrZJjg03EcMtXtELxE5sO5lUjiTPMd/J5ckyczqG10wSGrd8T4Jn5AqKG1RonhQXlB1myUOhJNhTxGD+LD1/s7S+u0jvsJhzx8RuaWT1NFWVvPJgWFAkZLgvlS+AKP+WCRNdqW2zxdLEH+x21qLPtpokwN1UHI5eb0D4GdVGZxpJt2uf5OuwqBIxsmROtzZCOZe0LsXMHm9VkmnZan4SH29xsjxJdnSri53ntPgQ2PYQsKu+JY/1GuhaOgPPJgvOG078ctxyLqRSRJP0t/pgfLFnF4vLGOfqBETuCbjK5pCCY1o/6Bb19WXsC2hAflagpvE6RThD4mWwCknSuKTt37wJfON7lZqfqRMYfzif7NCpVbukZ79SwrQZpyP9Bp/2VY8mYWmScfLRSb09JoNULCZwr8JwCfZ6TrazkqVcx1M+kFiL4aSO0Tey2NHUkm/5FaEK5PyNnqJtgDwUnDygdYQVS8KeOxGbM59s6IpSmt4BkXeNk4heN+qAILhkvIYyWpuWFUo0PPeGsC1eYu6GgGdo9LA8er+O46nlYXAYD9Ik1seB0raOK/xwmY4lZUSoldFovNewhAa4vEdyV2YFlYLMW23x153yrVfut3gOkL5ouK6ypUcK1LE+bc5nTtdu8+O9E02uWJIyGsuZzBJ2Sgsm4fJ6XC7RpJrRBhlUdjB2F7yKXQb+v4ALhLTUc6xbpT0Y31+Uf5d83ddXY9ETOOa2g1nOTVFZEzlwXlnTZvDewCOP7BnizGjvs5yGQaVz4hPWW9Y5I9jih1j6MXc5EeQ3iX7GYOmWAJBgjRSiYfalRaueeRGOEVbJ7/LaPDkEQ/u+SOFbJv2xF5kgT2r1s629XA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(40470700004)(36840700001)(46966006)(8936002)(86362001)(81166007)(8676002)(70586007)(4326008)(70206006)(2876002)(110136005)(82740400003)(36756003)(6636002)(356005)(7696005)(40460700003)(316002)(41300700001)(6666004)(26005)(1076003)(426003)(2616005)(186003)(82310400005)(478600001)(4744005)(36860700001)(336012)(5660300002)(47076005)(2906002)(40480700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 18:26:52.3530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa12d955-299c-4389-f766-08da69b4409c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3818
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
Cc: Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
DCN 3.1.4 uses dmub not dmcu. Attempt to identify
dmcu firmware for dcn314 results in dm init error:
"Unsupported ASIC type"

[How]
Add dcn314 to the list of asics that don't require dmcu

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dae998e014b0..9fff5aa86567 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1893,6 +1893,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
-- 
2.17.1

