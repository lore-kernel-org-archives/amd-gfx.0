Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7532EC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C67E10E500;
	Fri, 24 Mar 2023 06:53:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869B610E500
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0sMUOYQOMBrWIp1iLFSwg6al9KODViPPJajKbsWe09j7alill7uDhRRe+SyQnqQ6ml+G8lM1CY6m/t1PccappvlDAFWOER7KGBheskgGPTTtV2bcILy3Fo5aXD0z2psisB81D9zkNSq2qnqc0gPzTnteL/LfovqscD+xcIjl3ERkbbA1MgUBSifJcrpwHCZhDkQiyLiWzLXBRaE4CV+fYhueBs4NHCLldXzY016LaBDwm/Jum356ZyBnv8Imfqr2McsE6nE4m8yrOYVTBb6UJXuci3PNdg2xPWKoHaKjWqJZXx7Fc6OYcjAqmWmftzgB3o+EJ7IW9BPbCrwcxPgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgILBrydx+A0rek3KULjBVt/RCUm0hB9TnA/wC75RTk=;
 b=kjDWMBvyD9HjGo6Bx3pqfbsoMEfdEbMoCIGqcMTgMb7SnpC3OcUdg1Zpi8XZo27wf0W9/BhzXpa6hAYIhJcyqPSG44QCGr7w1kMpMXK/caYETMaPm/8ldsPxw0/bCHjLEq/NLb7w1uMfCF8ZiATG8CV3xVyIa6c3CDyrANBBGX4TthGGcOAQp7JE+z4pRCyf0s7wjsPAV2SDraFe2u9YApr5rrsZ6XZpkqWKXl2rbrJ+epDIyZbL7qSPL+s2K2v3pecaGtnzn/IY9B1ou/KLVxhapqyJn9sZAqiE0PPgrxy19JlkfFp72k+4hKAkuYGASQlxtfVx3kvHoYnzd+l1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgILBrydx+A0rek3KULjBVt/RCUm0hB9TnA/wC75RTk=;
 b=vBido2q94EGo7wJaqnu7bPUqF+D07y3Ga1NjARWyeTcH83ubSQKC0DlBe9a1ujsorUzhwO4pLGTyYgqeGXTeBszzKAFPnvpv2vhDq3e3400RWB5isbwlwGsicSYjNX71thy9zUehtgrlxflA4XgExS44QGCfHE1L0AtDNwC4b3E=
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:53:51 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::46) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:53:50 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:53:42 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: Promote DAL to 3.2.229
Date: Fri, 24 Mar 2023 02:51:11 -0400
Message-ID: <20230324065111.2782-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b89623-b518-44c2-eef1-08db2c348655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fM0+DPenSJ+3uugo2g3qSJh2w6zm9ORYctlm+jmfUrUtYUhlrIiu8yVL05Y9vOrl9AGbrm2W93L8kcb3QEzfZv1c0JTaFJ+6oN3f3tjytx1mdeyUPEcG1Y/GJyP8felMVlreDRlteAXsLOtNDWTUfFL7vlZgCrdb/AL1ftLHtDjChY6O8CukoiNmGrkm73fVJ0gYqMLuD1wMyJnOZWslOY8H75c4mGfbE6hOaWn2MDe3KFg9wb2DsSt5z39PSqaz8zq/ZyqIkQImCtyokP16/Rplst1IsuPPUbFb/ss7I8a3L70iJqdU7zT1odVrsukUxVR3qAUYtjfurKVB8Lfz6tZH8GLYPMMEAVSoOQZVzrgCDj3YjxEzVQPICMg2PZ4goWNxIlf1xT/rYChW5SbkDM7nMqLe0W5/h94WVhFguQ/Cb76buO8jijPZTdMvjZPJiwlv0Qup049VL2FXRXpbGYaUj0bfwNCap/d5R+rW03CkI2kyFfB8O4tkKQcNU73vJ7E70lF9M+gn4RHU1clnruKcF+H24MUuuD2UBKc7Snb2osWdmnMNMOkGL79A0aO9zxMuaOtN20oRO6285hjzIf8OsLeMmrmorIUF6mOoLszhL/nGvM4rhppLiTZk1vxhHuZo4clAHxqQptRsPtYbb8KPKyRjg7IB+h8VXfJbllBYytoM4Wp4gPJdllF9gqkAN+qecGahqR9GwHXyFKain/VKzjiRJyYqTtAqsr/T85w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(8936002)(70586007)(41300700001)(70206006)(6916009)(4326008)(8676002)(86362001)(40460700003)(36756003)(81166007)(1076003)(16526019)(356005)(6666004)(40480700001)(26005)(336012)(47076005)(186003)(83380400001)(426003)(82310400005)(2616005)(36860700001)(316002)(54906003)(478600001)(82740400003)(2906002)(5660300002)(44832011)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:50.5038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b89623-b518-44c2-eef1-08db2c348655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC version brings along:
- Enable FPO optimization
- Support for 6.75 GBps link rate
- Fixes to underflow, black screen and more

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1b77d50cfd89..e363a3c88250 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.228"
+#define DC_VER "3.2.229"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

