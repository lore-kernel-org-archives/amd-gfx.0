Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED8AC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CD310E19E;
	Wed, 17 May 2023 16:13:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A0210E44E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rrm6+BrG0TlFHnwufpeZ/CM+U6t6Grt4dZw9RdFbNrNbnjg1mdzBiEDBfuH+PkjsMsv4TTUmXtD8K8s1AlYW2w6RBdohVbPJSTvPHQ7PtlYTnnGzpKKIWh1SR0aReL2SmEJg3j97NOTCnS7fDwaIbNimWIyq2GHHdq2TqTaCr7koP5WdFKAMgKp8uFhFWoG4sz1hucvk48t2igDd37WLJUhCW+SIvqd4sXir2+bDTaX7vF1G22F93LRi7EKRuP1/o6OhzYVpkIvtBLKyjaWgsrMiAaTFrwONt9uPB/RdbjkCff4IIzkO7XJaGOz41p5PDyRvvi+A0QN12IcY3Rt+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSfq1NI1nI//XXjaSv8W5xJ9Rd9okz8ZFQcFJHglIh8=;
 b=N5zCapDpG3QgeWmzBp+cLfnVACTik64ijm2jh4jGZZU7xqYImj+9rUM4pvf6lquWYIiKqM/Ro6oCvGEbJrkI+XzRpp2Scm4z++hIP2oAVZhSHN5GX3xtEhZ2rmzC04+e4Zki7Lxr8RtfNyOyNYGQf443/P8nvGHMIHk89t1a435iNqtGCT+sJOil8QcAWNUF0z+gavX4yXBhtUkzWU4Q+HCq02JohzPudztirZrFmjl91XuYzKwo9yaTtDHt9o7FjBrijI12d5dA171SvUtocslusItqm0biIWsEaH56fU0T+NSW9dL29Dbh7Iimm/x7PZx0+Ft4woWRHA0Ya+yVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSfq1NI1nI//XXjaSv8W5xJ9Rd9okz8ZFQcFJHglIh8=;
 b=BOj/3hWr54F5X+fzRDthQmOAPTdLK/QNwL8b5mMosttYgaWrhmYbxY7zxp32aLhHDgYGtPSxKhDDcewY3I+KcL9YPetJ/fMVHoVnY3ch4onCSuYjC1S0a0uEhEhotI5FXOllKkqBIDPwLqND6/Lo8UUFpbFIxdQfff/ZmYoS32Q=
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:13:47 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f1) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 16:13:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:13:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/4] drm/amd: Validate gfxoff state for smu10
Date: Wed, 17 May 2023 01:08:18 -0500
Message-ID: <20230517060820.5499-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517060820.5499-1-mario.limonciello@amd.com>
References: <20230517060820.5499-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee04fe8-ae08-4bef-bc02-08db56f1b1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKeO5qGIXJffmxV4ETz7DJ1xyVX+AWTvR49/Ra1RCYaTNtQpKT/WAA3UYi/RWOCax4EeYTfeZq0HjHqYr5MpXD4l+WEPSoWOefg14HPB6dJGu0FJViCKflcV1FvNI1C5rHyStUKzP48yeI60/YXk0A8JaZ0i9ihh8y1BFYWSQqyWucQNOHCaODvhWXJBLVGStIZf9r1Z98rFodeQODlPEpZK8J25vYDPq1e+p2gn4EqoUWgrRxWPkJlkUfiDbskcqTcCPL0NfPfcTqGcZSDDLZUE/1pGZl8I+jDsBuPGciPu3Hn9ZeTYVTWTHpzRD0LK9hDQQAwunRhQ/j1dltgpd18WRJzEl0I8yFhwAzig3rkTIRQXSl+skwmxfk5f8eBTlCDDIbpAiBiZsxoaX1ri3Y5pIA38pEQyC7DvYb6u1oEJXRTRN6vbQXqClsuYWV/B7YmrIdiRw/M7KTvklrntpTOjnkG8HDWPnbGJ4Gi4dspCcWf4Ddoh0zozC8N56xpi8pGh0ryAdDndg2hlNks5gzAvwEpWD7RFYvpt19agGYkJglAncCIrAgsAK3BL4yFen8z/5dppTvwDUIwwd3qEc8jIbEiNBUCPdNEQfMQmpOgDmBUs2F1EXO05YSKIMzw0YC1glu2AYR7qSdM+VGFj+TovetipJp4jI+cQ+90gh7NaxkQexYgYEt7iKefM7w6zJ40hCRG1OHE5tm3ebJSr8lgoJm+wwFwg0EY6jdmD1ujw+UjWA83kO6JT7lgnQZfWY7WAhzSC5bB3zYsHYJiUkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(4326008)(70206006)(316002)(478600001)(54906003)(36756003)(86362001)(47076005)(83380400001)(16526019)(1076003)(426003)(2616005)(36860700001)(26005)(186003)(70586007)(7696005)(336012)(41300700001)(15650500001)(44832011)(5660300002)(8676002)(2906002)(8936002)(6666004)(82310400005)(40480700001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:13:47.3290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee04fe8-ae08-4bef-bc02-08db56f1b1e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF may be flushed at suspend entry and it may be important
to ensure it reaches desired target state.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 86d6e88c7386..bd5bf9182e06 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -345,36 +345,11 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)
 	return false;
 }
 
-static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
-{
-	struct amdgpu_device *adev = hwmgr->adev;
-
-	if (adev->pm.pp_feature & PP_GFXOFF_MASK) {
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_DisableGfxOff, NULL);
-
-		/* confirm gfx is back to "on" state */
-		while (!smu10_is_gfx_on(hwmgr))
-			msleep(1);
-	}
-
-	return 0;
-}
-
 static int smu10_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	return 0;
 }
 
-static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
-{
-	struct amdgpu_device *adev = hwmgr->adev;
-
-	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_EnableGfxOff, NULL);
-
-	return 0;
-}
-
 static void smu10_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 {
 	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK;
@@ -416,10 +391,34 @@ static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 static int smu10_gfx_off_control(struct pp_hwmgr *hwmgr, bool enable)
 {
-	if (enable)
-		return smu10_enable_gfx_off(hwmgr);
-	else
-		return smu10_disable_gfx_off(hwmgr);
+	struct amdgpu_device *adev = hwmgr->adev;
+	int r, timeout = 500;
+	bool target;
+
+	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+		return 0;
+
+	if (enable) {
+		r = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_EnableGfxOff, NULL);
+		target = false;
+	} else {
+		r = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_DisableGfxOff, NULL);
+		target = true;
+	}
+	if (r)
+		return r;
+
+	/* confirm gfx is back to intended state, timeout is 0.5 second */
+	while (smu10_is_gfx_on(hwmgr) != target) {
+		msleep(1);
+		timeout--;
+		if (timeout == 0) {
+			DRM_ERROR("%s gfxoff timeout and failed!\n", enable ? "enable" : "disable");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
 }
 
 static int smu10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
-- 
2.34.1

