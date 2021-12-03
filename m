Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1EAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF37AA492;
	Fri,  3 Dec 2021 22:58:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8C1AA492
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iigSoeB+hZWZW4/lnNEsJu8ucjIsbx8jk5Vgag0g7BuXSIAimVShZZ5QYTAFeAs4vV5pSdC7BBytt+ZwiAJ8IuAI8SwR+eLoeU/7U73R/qYAOpp1osQH+Vcn1ksxytj5uRbgRLQ6nWk2vKHSz4m8SswlqLC7MVPS/prgM/5aGN2rxQCrBd/t69L2530lvGjhA8nFERkOOSlVa7VKUjgr6jIg/stkfJFuIG5nm8alWd/OjFtuhNFBzPWFG60WeezsBxO/OykjQ5l1SFX7ZD3S58Yz+DpZDVWvMHEQD7l8Xh1W+gppyhWMFJcvrs5ncYfhupXWrjJNnOSLEEGLeDZPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxvgokejMM1475UaEHhwNiMryzlyMPEIQ6qNQk1ecME=;
 b=A0i6yhfI10B3PEtNRpSNtqtMOKAmIxvT5Xh7ps6ca4NfT7kfCXfc+aR0dCmqWcrlH3Ag6b+drzK0CqEzaeRs6yuE8v83bJDFwcHdGV1Wd64DMvjv/a+bz3+Pxq7ni+pMIBmUxh6SWGDwXMkz+4KaGYGXUafT3EAQn+um9ALKYJ1djowCxbizJWvz4WFDMlnG6lytzT5En5WdN/VQDC2aZ+9QSGCNsE/RitpkGqKqTO6g1r+1vdOygmvDGBLn2vBbh/4Esor4BlJnmKmT7HCBiViqDUKWFlM6NLvarplv75AE3Ro7DWknZlB10v/6OgjtkvR6whRbeQiHWScteG0bXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxvgokejMM1475UaEHhwNiMryzlyMPEIQ6qNQk1ecME=;
 b=a2HwNBHceEx3npPHU91Mt7SA/irCFKcZQd1bBlnzSP/UAPsDVZCsabBiwjYT+EDrhiq7nLl7rLe/0r7MpK/4rw3e7v2CEic3E+yckPOVSK6FYmoJR+4UYbaCTKJNAPKx5gGVBt+EVArFtUYl9cic3RU6CKCVZCeTcOPRoM3E3Zo=
Received: from BN9PR03CA0565.namprd03.prod.outlook.com (2603:10b6:408:138::30)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:58:55 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::67) by BN9PR03CA0565.outlook.office365.com
 (2603:10b6:408:138::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:55 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:52 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/15] drm/amd/display: Added Check For dc->res_pool
Date: Fri, 3 Dec 2021 14:57:52 -0800
Message-ID: <20211203225802.651367-6-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb37299-7629-4951-b093-08d9b6b07b9c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:
X-Microsoft-Antispam-PRVS: <BN8PR12MB310648662CD60F62BDFB1216FC6A9@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rAaF0/2rv/HHCL93zLbyOu2lvhsu+ptFFp5a+r/jtG5oXrS+n/H4VsKSYNbFIINgH4B8fBYJpV9N3L9NsM/m0fLUDJHASlr2FEbuv7dBdm0jqk1qQ7UGAgRHx+ZoymE0x99IRCEKtzAajCwsZhY8S6t+nDhq+eyR+EB6CnI4FGIVkCymCrhqXbBI98oPr8BD39PKoI+MxVUU7mxD7fphJj/cIEvyzpSFMC3KataI3sqizvQWpsBFygDg+KF5F+y/sBNIxeJZQgGiIvDdNKFAu509DJ3An+/RwPlF1UmC3HrqU9w34FpelqtRbHXeCgIqs1RxDg5+SXqn35GUaozvO7N5mBfMo686gV65ZKcBD0dmbspyPcsvU4KhZR7cHRT3aW+x1fIVavFDOe9w5//0K0KBOmM1eGhKZ/zS6tNTY48/qn17wLXy5Ma0ohqpqLkxu9MdlNs86VeYdswvujpwK/1rxwAOMItpG6+9OsalWy/+6/VNt/QNXScjOvjMdQcRyl8VVXH5gO4ng7jF+SudtyN06sYRand+XvRpLDp5lOFFY1tLlhbPpvuHfvM6hkX4yNKex0GCdIVLaFp7QsDx2cSJ5271pA/p1SKsCEBD4ITSyxJmzYY7jP6ctfTZWd64Zhj25Ih9NCc21w8RtaEe2eUR1OwIovzQu2PJpqjPwVnOdPRxLMwv9nXuJ1O+pHVRTYBrPblETsUYCDKQcWjg1uMfwIrHnSNC/GeR7eJOlRlTDnouB8ekxN7uks3TMGexgHSxlcspeporV6wLKmitxzwWETQb0L3How5AuVame4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(316002)(4326008)(70586007)(8936002)(40460700001)(426003)(2906002)(8676002)(1076003)(16526019)(47076005)(36756003)(82310400004)(186003)(5660300002)(6916009)(36860700001)(81166007)(508600001)(336012)(2616005)(4744005)(356005)(83380400001)(7696005)(26005)(86362001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:55.3532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb37299-7629-4951-b093-08d9b6b07b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jarif Aftab <jaraftab@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jarif Aftab <jaraftab@amd.com>

[WHY]
-To ensure dc->res_pool has been initialized

[HOW]
-Check if dc->res_pool is true in
the if statement

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Jarif Aftab <jaraftab@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bd6541f1c8bb..471620a3d7ae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -809,7 +809,7 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 static void dc_destruct(struct dc *dc)
 {
 	// reset link encoder assignment table on destruct
-	if (dc->res_pool->funcs->link_encs_assign)
+	if (dc->res_pool && dc->res_pool->funcs->link_encs_assign)
 		link_enc_cfg_init(dc, dc->current_state);
 
 	if (dc->current_state) {
-- 
2.32.0

