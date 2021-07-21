Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE1C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FE3611C1
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FE3611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1025A6E8E9;
	Wed, 21 Jul 2021 04:25:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76046E8E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 04:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ59KKm8O7MqXxmLfHVEyX+jAW7Hrqjyz2ZyxpHNU+hfqK0sL0gsHlFZtqOSn9HsBIkHf741LEbqQ9+S/EjnUj+gE3jg9staZC5+WtWWEmKoMtECoIuEZOLxxsStEqxJWrdRXiFX5RoDo9RbwIzmjpgWLeWjbdyYRfGHLHvd0hlW2I1B7Zb2uhdlgssYjRGHobHg8idT0TDEs6kQX7xlKtzLchQ3LCTjy1/fFD2o56v0vGZLKQIK46q1eSdEd460RJs/aWjEXAcFzR0nuvMmXL65dzzrOGodijU2PCAAAsXPFNrzOtch1Hva++XeKUoW5pXr/Um6E1kXbw54GkcxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM0hvFAtvNSCraMkYkexbMB7tRDA96h+6oAANRYDfoQ=;
 b=bWh+DRsQp2HtaXCXX6m5OUMEmwI+I6/dNWjxZ6j9x7JcfhvO1WN44v84qhK0ZkzTYU4f2gq57DZeXbA7kHJqCXHl8GVfoZoHZc8PP5wmikE8RssB9C5oekPht0qB9M13svwei6ELTqXGEfA13n2wm+Iz/v/ZDhuNcl+F4Mw/cgHzNIn4vodrCjIsNUZDl9wvLy87YmAOAoURWcCHMnv+TYDpo/1MEctaAi55e1LoqdZrmW2IO/73uWDyrkBL3mKuVblrxIGBkOE0VBlYU4/NKzVKl+e1ssoZK+s7WdATZpJ1G5ueYh9tFA1Ps+DH9GY/xg1k1g08V9IqTaApwxSBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM0hvFAtvNSCraMkYkexbMB7tRDA96h+6oAANRYDfoQ=;
 b=pIM4HmbKYVBBcLEn99tkDC8waxOb/Ktml1ugGjUANczDjCccoqE7BfphpEF99rBZDZ8qfsiDR3HRbCnf2+mdzcvN1Nhhz3THON7y0m2h7qaz+L36M5XnEAxeqKI1mGH9PXUHYs63yzSQG+TlTKqcrEWkTD3Q/bpb7C4Cqo2Tybk=
Received: from BN6PR22CA0051.namprd22.prod.outlook.com (2603:10b6:404:ca::13)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 04:25:50 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::a3) by BN6PR22CA0051.outlook.office365.com
 (2603:10b6:404:ca::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 04:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 04:25:50 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 23:25:46 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/display: Fix ASSR regression on embedded panels
Date: Wed, 21 Jul 2021 12:25:24 +0800
Message-ID: <20210721042524.754014-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721042524.754014-1-stylon.wang@amd.com>
References: <20210720033317.686726-1-stylon.wang@amd.com>
 <20210721042524.754014-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d80a5734-4368-4caf-73a6-08d94bff9eb5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-Microsoft-Antispam-PRVS: <DM6PR12MB373997D9026B0EA71F0F1B28FFE39@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 624QxUBP/xdeT5qmSYGy3MAiGcAff8zGljWdH1L2VIQyZ8oVxvxr7Ze3/djvJLScHM9CrMbqJu83XRJinvuPterBtqRBz0fA5vdD+Km7dzBocL6GQf8PTK86gXyxaKyPQSxzEcbFRMcTXtw81VQHswMIWgioUuTp52fhhDebYrbKKbIBqMyTIvVVWaR2TCtgOwpbZ02jMLDtZTtv5OT92IC9uadGX9laJzD/BHZF0Pi9lMvGiijDlmKNAZ0oZ9iXX07DTjIrXREREwUxNxo93jpVi1D9wFvB+faxRtatHVX3EvqrBjiOVlT4OOq2sHGMsVo4tQ6mvZ/sve0OM1lKRy0k18/hYpUU0ihzYlKCdO5F9/Ikg4UsceZPsLp8ZDG00xZot8zqjnwzQZM2XOG7gm9JmBZxHRb8CBaKopyV7iU4odP2vzb1bziMqe8mAhh13pqfIjj9N/Hb7SeQbVtvTMDYtstz7bz/9UGThirzOWHCblfokna1ScgqHIyOyTGkcsr+pE+pQft0iUeDZ8wODUfk2stfS/S3QGyXtWlkMubQY+uWv52Mhd3xc3mNlw3HjYKXHpZMgGAS0zqWCpqIAS8npEI3G+MtZXlgZZm70ElpP5JB+LsfY/2mdlLoUXipVtbqyOAHEdCtq2Q3fkXEB7leMZlL5K2rjkYQ3sFcU724MntOjmLr44h+7JZr6ue0ureX9ud5uJjPSIPdeTtXOMfFlRbF7Wq2mAx7iRMftBGfejuPVtfta3SzZeQseAecaWHrMwZoYrHtXWWe0QVMMJC9CCUJSBvkqgg9LBsqu3jtsgm9CdV0J1RvBogIl6PT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(426003)(966005)(7696005)(2616005)(36860700001)(1076003)(36756003)(6916009)(26005)(82740400003)(6666004)(82310400003)(47076005)(44832011)(2906002)(478600001)(336012)(5660300002)(186003)(70586007)(81166007)(86362001)(8676002)(54906003)(83380400001)(316002)(8936002)(16526019)(4326008)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 04:25:50.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80a5734-4368-4caf-73a6-08d94bff9eb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Regression found in some embedded panels traces back to the earliest
upstreamed ASSR patch. The changed code flow are causing problems
with some panels.

[How]
- Change ASSR enabling code while preserving original code flow
  as much as possible
- Simplify the code on guarding with internal display flag

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=213779
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1620
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cc62124b0b82..f56e061d35bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1811,8 +1811,7 @@ bool perform_link_training_with_retries(
 					 */
 					panel_mode = DP_PANEL_MODE_DEFAULT;
 				}
-			} else
-				panel_mode = DP_PANEL_MODE_DEFAULT;
+			}
 		}
 #endif
 
@@ -4643,7 +4642,10 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 		}
 	}
 
-	if (link->dpcd_caps.panel_mode_edp) {
+	if (link->dpcd_caps.panel_mode_edp &&
+		(link->connector_signal == SIGNAL_TYPE_EDP ||
+		 (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+		  link->is_internal_display))) {
 		return DP_PANEL_MODE_EDP;
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
