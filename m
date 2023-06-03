Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC2C7EE24
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jun 2023 14:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C3D10E04F;
	Sat,  3 Jun 2023 14:54:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F96610E04F
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Jun 2023 14:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbTYJ/FGaa0vP+QKaWSADcEWODk7o9g1X9fHgLKGeEvn2QIKdeAFRHtDmPa6mUu2atmimOEuzokVvss59KOB4aK3aCXHWk0+BEus9YaQdUWE5BangzdJj2wBk4/gIznsK7yOAY2kAkM3TjiEMQWT6sFoVNWAynF0EKd85EtI6RZ+BwD2YD4yGDaZPSnhPYTbX2nwQlCNYTPatI7idHuKDcM0UNX0N/tWGqR5DR6WKIKr0ylRCqIYsedL6kkds5TviD+AI5bAcQQANTyudMCsH7p66uDYtce/zHmXDX/p/skdfxUty/IHc9wyq3afjylGIff2Z/e5BfdO28o6KCt4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMqHW4LZHHR71HT/sie+3HMa/6uQ04yx1HFZzTU543Q=;
 b=B2dqNVqsiX0DrAEhMlRRIw7+84MgbfWS+YbCWEEBHRKwivcEyLzPadRJ441OTZtVWExOMhzCmdOY+o/wqeJs0LWqUFRxr8XhEgOo9DBQ5s0WXX5RRRoszTW2YkVmud1vxE5vy94yaPojCcz4FftmpyIgoPLg1iVFnLielKbBvCyUBCTHEa3LTH6r+xrU/msK2H8PJnUxLNs5ykyMuTShgq1L/PsU6EVVuVcGyAoteGO3G19F7stZnKnxFt1j4uY5qwMjRmoMq6/yQ8hqYqW+xZHIZEDLWCrtirthbdgWy63TEfncwoQf7lPNzyLAxY6QikLFm21Wx5/d8gG79WpKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMqHW4LZHHR71HT/sie+3HMa/6uQ04yx1HFZzTU543Q=;
 b=lIogPakToygy+JzcY6rBPwGLLQutrH0w91hjCyiekkMv5npBzH7Hu9TF2WLW47FJmIjWQJQCZe6IVw8dJRUhmWW+yH6igw+xufbzZQesq7C8QKZnUpadGwO/BrcJBHVeL10MT8Dqsojnm2Vb16WG6K+LpfmChhS3KbxWFj1MRvI=
Received: from DS7PR03CA0119.namprd03.prod.outlook.com (2603:10b6:5:3b7::34)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Sat, 3 Jun
 2023 14:54:06 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3d) by DS7PR03CA0119.outlook.office365.com
 (2603:10b6:5:3b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28 via Frontend
 Transport; Sat, 3 Jun 2023 14:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Sat, 3 Jun 2023 14:54:05 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 3 Jun
 2023 09:54:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing function parameter 'optc' & 'enable'
 to kdoc in optc3_set_timing_double_buffer()
Date: Sat, 3 Jun 2023 20:23:47 +0530
Message-ID: <20230603145347.1940243-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: ab322c9b-daa1-4dc7-a637-08db644260b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJplGUACxUyCT9eWD1V9lgeP3bajQkKk4403TssPOma7+HuahRC4hFAAAwIIaajKOLioDDntU6LOwnAxwuqDlcfkzR55BW0V4tdOdOI2fWpQJxvgmaZ/FmW55I4guQL6ys/JP6vc7TRAPVReBvZxdCou+6H2mu8pjoCZYU4K4goyqI5DVIcAY+5OjvV4NTvDWvA0NKUtYfw+IIoXlTV6L0xO5a1zrxJi++pTt/U54E/ftJlsGpK8wQW8BJLgJjZrfoQGfF7ia2szTP7fzAnDMbL2IXTirsziLs3DuLXKtPHKLC53cGs7mfVfZlUq6DRQiXfYTH6hThU+POSXu6jx5HmUnpZxlkC69EAfylOFDrq4wmArAk1jHwTdiALpqduzkQDEzmQ4Z7iZfymxYqXaiPJfiIV/QQJyFLVW7D5uP8hYwS766f79a4oo7v9QJV/1J5wP80CeKjuYqzx011zISwSe0/NZzZTJhRvt+rVf5bW0xjDRVfTc8yOO8IOYWRlXb68nW2ZhjfIvFCa/7DfDUVM8RCwOv2ZDcZh5B6SY7zeFoTO8WOarvnNwF4Tsrztnm46rlV47eWQAnq32l73Fb0pd9/TVFOe3WbE0/SY712cBPuRufrU/aN4MTVD8Az5BYFra21tKLVVBGCFih61tMSYWMD5GxUpdsdWtypvhivqaOay8EOsJbMumED/FBdHJQhBq7bfkI/OHJCEdCcouiL21jE2jrn0wFhLsOljGKaG66CYa9QfaUnGQROqoILdnPi1el/VuVbCSIOothWKn1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(336012)(40480700001)(83380400001)(47076005)(426003)(82740400003)(81166007)(356005)(6636002)(36756003)(41300700001)(4326008)(316002)(6666004)(26005)(1076003)(70586007)(70206006)(8676002)(478600001)(110136005)(8936002)(44832011)(5660300002)(7696005)(54906003)(86362001)(2616005)(2906002)(16526019)(40460700003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 14:54:05.4303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab322c9b-daa1-4dc7-a637-08db644260b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:285: warning: Function parameter or member 'optc' not described in 'optc3_set_timing_double_buffer'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:285: warning: Function parameter or member 'enable' not described in 'optc3_set_timing_double_buffer'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index c6f5f3df8061..dfb8f62765f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -279,6 +279,9 @@ static void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, in
  * Sets double buffer point for V_TOTAL, H_TOTAL, VTOTAL_MIN,
  * VTOTAL_MAX, VTOTAL_MIN_SEL and VTOTAL_MAX_SEL registers.
  *
+ * @optc: timing_generator instance.
+ * @enable: Enable DRR double buffering control if true, disable otherwise.
+ *
  * Options: any time,  start of frame, dp start of frame (range timing)
  */
 static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool enable)
-- 
2.25.1

