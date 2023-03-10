Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB42C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203CC10E9A0;
	Fri, 10 Mar 2023 09:31:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333C310E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf8oHEp7vLO6kQG8gQtVNrOoFErj4aEGvE/HW4a/aAtU89R42fhlWU8jeqAHEqBgS4sHYf+xNrxkyJqL0N7gw1zdDRh6r8UaI4oVcwkcHh+LoKmnGD5lq1VgQ4pRgnum/QzzRS94DhrXsJixCCs/rSEu373vL2xudbPWjFeI7QktOWbKquLtYOIrzl5aMfISPX4yWU3iwCipx+KyZ5sxK8w0743FcfJb2oVDFNz4fHdSM4r9w0YNPwtAZqSUz5DrzQS98MKdLiZSfWugQRnuZGkJEKG5O7LZWzGdW3DAc7aQs7YY61b57y2HIhl03EhLRuM/G+zVGFQAus1ngr4b2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spuyyX2OJog3XBsPpxErTtM0JetetrY4CGZKUQoMZ/A=;
 b=IVMhZt7tmWpymEaApqRKVoOY5oD7QNFdKmZR4WECV/6ZpuKvxqGyj2FWJyAprv6kXH8cvMhSMEvsQGyzUPAUwnSRLA/1xYl4pEf1NRChLwVrHpIZfOWxa1ysaO4a0/20ZuqF6NAGKgTDaB1kdhr+GECahAMLFE9RZeYCjIQcKC6/yiqOTgAWzkMyIjll6FWIuesK6hDn6PQEhBceWM10CsJ3RlARWKuDr9sWeKd94BcUXn6+IF9i8Q6val+nOWsakG6n760esGq283lEXtE6kfyjzA9knUMFqMKXfBZpvI95iHIae0WOOO456Lqwqw+SVobAQ3LiZNbklfEwmszTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spuyyX2OJog3XBsPpxErTtM0JetetrY4CGZKUQoMZ/A=;
 b=h1T6L4+tIRkVbMFlghTeIAnMKxRCQVkEwWOBApr5ZhX3FPd06ftvYnqF4kC4MPY6PbxyZzLdxuyCuwpJCEOCtL8eowmRT/VB3F+loLhRlLJz6M0aWpRwhxMdnoedaD76G235c5pK7t7tsQZ6M2eezuiM44RM3LNunkqYLI4DxDY=
Received: from CY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:930:10::34)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 09:31:53 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:10:cafe::8f) by CY5PR16CA0022.outlook.office365.com
 (2603:10b6:930:10::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:31:53 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:31:47 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: Fix HDCP failing to enable after
 suspend
Date: Fri, 10 Mar 2023 04:30:59 -0500
Message-ID: <20230310093117.3030-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: b627c8e5-161f-44a5-9252-08db214a4893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yi7iqLzuCpW4EMD/6cVCwYCivhkTK4bSRm34sApk0Ehk3aBtTnze2hslcQhsmRBK0u9m4q5eOk7Rzr4DQzbWuVta4jSw64NvyZJijVNPzMTPz0HUCRJ3a5i+xR2ZLbAlXU+yLdwVb+0RtSHiTlaQ+6Pd3SxbYQTHzTWBRwYqlwo/JqvU84w4GQlcr0vYcUgKOO5CW4xe+Ic4eJNM32NPRgnjYmlHhQYVQb2PK3SYjF5RT0RHa3AkqUnzbvs5FKweYVLzYgnRu0OHWYFWKoJL53R9eP8hdG8K0c/iPqrrexo5EcgmNcn4ig4SZA3tJ4jR8rkQ/2ke+FJ9ywQ53wubc3Vieka7ltYUgmyOFSFmehA0Es62+8L9WWC2p1EYYQ0Y5L9UX6/shMT7bq6z+0Nrt+YJyGWySLme44nPv+TnlRiQuX8fV/Y8Z5t5Da3jr/2UVH7hfNbhyFq1CfsQRHwAaHDVpWafsf+0UvZp48dH9NXwMN/aA/M+c16mhATVMOE9Gz4dbQ0EONtq7LYlt4OngsLHyL70xCZ4i5cYn/50QFJvk4ldz54ywiXDt2H+C3P1rOD2JFEgartVHXvTeK1ex+oDqDwc3UOBjHUVsRlw/pjl6ai/5tPDXV0DknT1HkU+5dQL5JjGIu+45tlbaaRQOHGkjc4PiuY9ypNSZUnjd+syxmIyQAsgQGs+RylsXZ/jhbmmKe+y6bIIHLA7H62edydo3shVSyDO9jXS59wrC1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(16526019)(186003)(82740400003)(81166007)(336012)(2906002)(15650500001)(40480700001)(44832011)(26005)(1076003)(356005)(6666004)(8676002)(2616005)(36860700001)(40460700003)(6916009)(70206006)(4326008)(5660300002)(8936002)(70586007)(478600001)(41300700001)(47076005)(82310400005)(426003)(36756003)(316002)(83380400001)(86362001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:31:53.1046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b627c8e5-161f-44a5-9252-08db214a4893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
On resume some displays are not ready for HDCP, so they will fail if we
start the hdcp authentintication too soon.

Add a delay so that the displays can be ready before we start.

NOTE: Previoulsy this delay was set to 3 seconds but it was causing
issues with compliance, 2 seconds should enough for compliance and the
s3 resume case.

[How]
Change the Delay to 2 seconds.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 125012426a92..5536d17306d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -562,7 +562,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.dp2_enabled = config->dp2_enabled;
 	link->dp.usb4_enabled = config->usb4_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
-	link->adjust.auth_delay = 0;
+	link->adjust.auth_delay = 2;
 	link->adjust.hdcp1.disable = 0;
 	conn_state = aconnector->base.state;
 
-- 
2.34.1

