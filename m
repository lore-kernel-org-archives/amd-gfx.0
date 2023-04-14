Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F18C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D34110EDDF;
	Fri, 14 Apr 2023 15:55:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E70610EDD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7uTSASk6Tel1W2DNNHxhLMbZ/AI9PyzWUnD3xA+M2irNdtVdHyQ8KksPvJ/wwqaUTTQFMupmAZ/dJzy32mhioXfAZq3FLtYO57DiZjiMuPHb07dP+mRYM1F/ut0MlHniZnkGvZSwoD0BIPfxCt1kHxsMkNE6L4IOFPYgib8BFqp7cYiZ8syQdvb/6YgJhZQpMzFbHlRXHy0ebUW5l7jUfN1WMxw2hOtnJhzI/G79CEus2EU8L9v2XpTvu3mX5PTp/Xfs3l4m1xd7q3k0An4eJVsWbdTLq5Ma1cMi8cSO8FZG2KHQSbz9jTUxWsPSxD/3tB+WDgWHJlBGkeYEBb5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s2q02yS4CnM5LeQA7ad560Ihes4e1HU/7p959nxTmM=;
 b=blYVt04SyyxqgIxh5hjj7p2ZW4bMOUsD/n4u/PacVr8T7M4FMLOo57Dfsn+lISzcUgyTc7JLK98gcrD1CefMyF/4lTIF5b3DRQOQs3/BjbxmQL3kY2EQ6pvqVFeGHcIa5u1tkDLv9eUor4jIbdkg1EympSFdJ4k8mRPj0yk85r0Djhz8x8xvvs0FEqSAT2jV3WSFPLTbHNN1g7gMJfCocEC/Hbbw2m8ziLCiOcTuA4ABm5lElWqTV0d/j4roJd6EkIsyQfmktDZcsQsIKoNb3Bdr0N5R4pnNjlicCE2wVnYGAa6UdNgvJ0SeyoyW9MWgxt4hWoEpMxzv/YlTOVybyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s2q02yS4CnM5LeQA7ad560Ihes4e1HU/7p959nxTmM=;
 b=saFKMLlGmX3uTrxQ4G/UiGnI4pyTGZ6RV0I6a0AdmwFB2yUZztdYiGQ+NNA6FDRzaUSxl6VeX57PdOy49IHPsnaZnQHXl4cbFiVTgH9MZJnO2MKVl06WtuuZdNN2qMRHmRJCL5BufB+3GPbeRedHHZwr9ppN8MRdaTGbxf7iR6U=
Received: from BN9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::10)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 15:54:56 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::a4) by BN9P223CA0005.outlook.office365.com
 (2603:10b6:408:10b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.38 via Frontend Transport; Fri, 14 Apr 2023 15:54:56 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:54 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 45/66] drm/amd/display: Clear GPINT1 before taking DMCUB out
 of reset
Date: Fri, 14 Apr 2023 11:53:09 -0400
Message-ID: <20230414155330.5215-46-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d40dff0-9cc5-4fa2-4d10-08db3d00983a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HS+0RBbyi2NgpYTY80eZkv9Sgy4iakBVPt6fKg7VbS6xQOq9H74iAfsecjd/0ijmu7whqRXR3GuqnGolvfXmi2jlNFUm9GlCL9i0VEbbbn+dzs3GqC2pZhH4dD8RzDDJWzXCbz2onddP2scVtBpgbppNVPe4VqLp+CRYiob3e51Om5UozZOV4UZYUds0/DVVc+uati+eEred/CTSSVNzFaeF0jVDu5O3Fe4s6MVR/l30xrDEoekrEHRX89zP7JUdVXxyJW6YnJWvhxVr+RO6AwQoBg3YcEfnjPJbpg7d8Ug0r0/27ikdno+A8FEewEQ10lV+rUIj2O02A3+0qlvTBIhnu098Ox0iq3UL9QE6rUJR2AGOV1f1niv/CIk3/lmYfQ1vptWDrZBeCiqQcWLf7zaCZMRydT5hc0kxvzTAiePTV61JxsaOZAfvrdrG/uOdNi3C/RYmwb1WaqwD/QaMdvFMSwtGUPFg7XVYpsZAq6c3Alt8D7bSp1UXhivyJaD0aEd0/TMp5W9HI9VqbStaCxTdJaBm0iGNYJDbK/+SfosVCOhSWiVxb0bd4GQlxVWM4tK2ZFiGWjVNJxDPCbxDvUN3WSeFCY7av0GUULB03isO21QjjbdrpyQ5c36wXggVoltqLGWna9a9twqjUB5+cINJKVMTq4SsCWDJwGXoOH9YJkj++q8WhPR8uwXM69aoq2fthoCCEPYt64Jyjm2TL3YlaH59ocgWAmzEsyH/kmo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(36756003)(86362001)(316002)(41300700001)(70586007)(4326008)(8676002)(54906003)(70206006)(6916009)(8936002)(82310400005)(36860700001)(40480700001)(2906002)(356005)(16526019)(186003)(81166007)(5660300002)(82740400003)(6666004)(1076003)(26005)(426003)(2616005)(336012)(83380400001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:56.5840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d40dff0-9cc5-4fa2-4d10-08db3d00983a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Workaround for DMCUB front door load

[How]
Clear GPINT after reset so its consistent

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index a76da0131add..568a2702d5f7 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -116,10 +116,6 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 				break;
 		}
 
-		/* Clear the GPINT command manually so we don't reset again. */
-		cmd.all = 0;
-		dmub->hw_funcs.set_gpint(dmub, cmd);
-
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
@@ -131,6 +127,10 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
+
+	/* Clear the GPINT command manually so we don't reset again. */
+	cmd.all = 0;
+	dmub->hw_funcs.set_gpint(dmub, cmd);
 }
 
 void dmub_dcn32_reset_release(struct dmub_srv *dmub)
-- 
2.34.1

