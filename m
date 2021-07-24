Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E207C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96AC60E95
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D96AC60E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71206FE63;
	Sat, 24 Jul 2021 04:11:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149126FE63
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXBth3iypKmMU9sLHEY4YsUvAWps+e9RCEKryjsAk4f+g2ybnLLoZ8605l04OaP+Wi2/hTc8mKupw5UKcWVWG9PpeIxxjD3u9sp+7kMt96pAMbEOPYBcZCogQyF3/BX5J7uPZqSCIrJKXKB0Xk60SeF0pAVkqOWz5G+5AZ4dSIiFRr7EpSFbwTcattTE2b5Y4Jc4E4pg4bJ7oiHiiXZ68oo86CWVJtdnBuBcrlxaUx/yNRXOJoaMGm+Ncwv1lbhKcz5doX5YwGn5xIFfgDP3qWNm27v32EtAd68wNuAXZc5FD7cAb3WUD2HMNgOviGFcQGQtt6TtYm8yvjNMP49xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbYguN9HwWI3XPsN/v9oCDFU8JVuQXNuv2/isNAkSNk=;
 b=HisBwvZF2nOKXKDbEYbA4L15TQ1LHFbopJ2PxuzyKBBhkuXVOfF8J4PKG5yRbNXSicZJUlwpGV1O39/42sEXc/2ZkFaLP5F92QZEttxDUvwgxcMvg6CnlyY4sLS4w8kdkDqm6xV7AqN2aVvipKCRd/EqWdOKnzN1HWNLJMEqj7KiNEePwLx1P3lTkOyKjLVnen8cGJFwr2dS1ibrqH4HKjmfksEq5CZqQTOxwhM5Ea7RnZNuqByTHyyAnSy2C2cODPnCFdZwW6WXKJZN42gCdxa444IMrau8V5gEIUqEhsV0G+rKAo634ILU1zzY1XsNqJ6yLdX/hzoRpFg//a0wQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbYguN9HwWI3XPsN/v9oCDFU8JVuQXNuv2/isNAkSNk=;
 b=xvY3Vl34DLPDj67ziKxuxK8PdA2kROZNPNNBAWlhGrHzC0NwP3YVd0eIJ7fDfmmNychmREtV33NnmGwIGmY7YqrE9Te0+66qKmVQRND6eZgoDiEQUA2+cbXet6pbqlVrrKaMti1JJm7gsi2F46Es3t8nvF0kjdorvYI2r6eF/cw=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Sat, 24 Jul
 2021 04:11:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::71) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:51 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:47 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: [FW Promotion] Release 0.0.76
Date: Sat, 24 Jul 2021 12:10:00 +0800
Message-ID: <20210724041001.3875757-14-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03b2994-e9ad-49f5-ddbe-08d94e5929e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4185:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4185B74AB1024DF4377CD78B97E69@DM6PR12MB4185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QDuC9ykf180AVmjSV2qSIkRfg65i3DNJPNt+4X/jR3Pi9sGMcNCZ8TNOJCZA31dse5OIgL4E2DIiS4OP+RS9LzJ808EtdeXd37yvLPgRjDLmPt/dWh8Ll7zNKmGovUBVg+SQS1gv1W0FR/Fe5fUM68eWf8hP4Ea1Z4xgHQ2p7b9V/3u8cI8MJGoFnub9WHsYAt1p+EpeNEmJB6QiZuEbMWgby+8mRzhlJOFdNIQPO44BsDQElcrJN3ZYueOubJ2ahXUEn+mFTL2sD9e5w85Nro9skI5b1K9bemuK9ONt66lwk+21z1IpcOMvzL/peO81zsljfKUgRz+wowewSnW8gYXhW4xMToDlGQjzRiadKS5CqEpUiFhIQRolSO8GfrzbNu2lDLTaub+HWh6ih9r3/PVMwEurgShg133J95L8YKZIyJ3Tw+T01wtzVBGQfZGpiHcnNgrXNA+UACznsclOpKM/P2L06D//Ye826/skeAbmyYKGsCLGaoSayqFoGOMXEDpiXFzzGm2PF58s9AFgrmyKHhJZTD89tVC9mChgAgIlISE7hFaBCMBiFKRx9ymmiidTGK8aG09MHzZBMXl++WrOhfMScdJvu2eBWK5+gErs1VfgaluTStsNLgIbgvhpxAWNLv4mbVEUsJuBrhEMBcKYcVbR0jSfOVFcghTlBCnctGr3ZCxkBToKMOAXFAuopt/Ec+yL8uMKTeBVRMKdbc4GyCN1CYLNET4Moeyx+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(7696005)(2616005)(1076003)(16526019)(316002)(4744005)(26005)(6916009)(186003)(54906003)(70586007)(426003)(70206006)(5660300002)(6666004)(478600001)(36860700001)(82740400003)(2906002)(8936002)(4326008)(8676002)(336012)(44832011)(47076005)(82310400003)(86362001)(36756003)(356005)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:51.0764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03b2994-e9ad-49f5-ddbe-08d94e5929e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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
Cc: Cyr Aric <aric.cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Cyr Aric <aric.cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8b0b4d86986c..02921ad22310 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x2d2f6f51e
+#define DMUB_FW_VERSION_GIT_HASH 0xe599e0896
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 75
+#define DMUB_FW_VERSION_REVISION 76
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
