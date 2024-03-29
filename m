Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD73C6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FF810E418;
	Fri, 29 Mar 2024 10:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dn8VsWLq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D994B11262B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO80qoYVKDHJUWR2vIlkOa9sS8h8wGr7dhR23FuECphOPX9PMZKhnmTHGYP2qsr14rxCZ3xMrm+xl2KdCjf7sHwwNA2tgldNiK1+mPWLu0uOQi0dGGgtIbzUiWL/z13+aOJxga1rivJILYJAux2apHEE88UTZLWygwHoWs6syl0BsTq1OCwjxs1LCxVVdMrXNaQocwmVbuhtuETfZ2sFYVSVffmek2I8a2HFTSL9DSvbs1pi26eaun595bG5qg5xFRUPYS6LF+n/mVAY1VmdbgBcEghLiuLOfPvG4LjgxUKEQuxhdVAX3wwopLFHlj9xlOz8MIPLnwY3g54qySDn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugmF0jQ+dltgIdy2xgXUIQNknXPSHpQphnh+2kzkYaE=;
 b=EvugMnfKq5wByJcisWXeiXWMPpIDRAkUpg+QxnyFAscv1AeUIiTouKiUTErjvIWUzrV5wY1l9vjd2l2PRhbcg+aIZs+fdptKinTTmxOMQY9x6QH5uK7cJjCiSQkltulZbPMNxeINFXLLPAdhZHoS0icQXXQ55EXftTzU9pMCpXj5h1ZSY/V2jlRYjCoVgwpFvZL3u31wdNO/ukb5/cD7Q8WszPiC9xPgx5euAUaT/78kP6tQ6BXp/XsyE7hw5X9Wk9ye/Vd0BKmwaoAk5DbCRH7cqpVTee4Z8FN2IRNa/5AV4z9l2rRqiwq8vqSV78W8mjQctEP6uZIKSFZLLM35Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugmF0jQ+dltgIdy2xgXUIQNknXPSHpQphnh+2kzkYaE=;
 b=Dn8VsWLqSIBrnhrdUMtouMWzgUCqpsjLU86M9oI8wyyYDmSwCLGFJ+Gdf0hM6EPbSDtVAKDNEgliyOWVjwCwSxjeWV7p8bj/0Z104I7s5G/pkQTaONQfE+WmkMBBIQOf4QBlQdLB9vN/YpOPFqG9JBNnHQ3Yx+ZqMJ2qy+xU0Uk=
Received: from BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 10:20:49 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::85) by BYAPR07CA0092.outlook.office365.com
 (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33 via Frontend
 Transport; Fri, 29 Mar 2024 10:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:49 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:46 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: [PATCH 4/8] HID: amd_sfh: Increase sensor command timeout
Date: Fri, 29 Mar 2024 18:17:46 +0800
Message-ID: <20240329101748.3961982-4-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329101748.3961982-1-li.ma@amd.com>
References: <20240329101748.3961982-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bf56bd-a9bd-4e43-24a0-08dc4fd9e7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfh/L0S9aTAfEYmQZyS0IBYlFmgy2hl9BkS6fUtYvCzIQBdIovUcbE3CMb+RZcpXXr2Xr14OqtcMHjsA3qoIbXL+6CtGo3I8E35Wn7K6gxEK3TZiCatyNeex6YciGbsAACFDZOhiOY36PFictIVmzRpO/U8aHblbhsvaDllor6F8a1h0/mPnNofCF3e3Z4jGNg5oJa00S/xFkT15WM5GHJLMPfUW/gxHhWt5WX8isX61AUGKyMTVHs6+dV06Huh+TQo4cDNeaLlknI6DZQO8/WcgOMLHS79K96T+66QU4N/SI5SxmcT/lLLDdSckZH7O12q5g8hDEsbjquTX8I3z/qNcliaH3gIES7MJUdSLDpF5rm83cUoc5c2hLEMWTUunPVyzEng4aO8LLFbXAOdaSujAO0/VSpF5dEWj/SSI5TfFGPF3BIFCKPTN/HUJ/1kAZLy5QrhZFWOmiG57SYmrhNf0gGj+Cx5EHpfIUXyg6s1lupYMDy2Vl7iyNz2x5H1rRfEfXSmWUVVwQ2dYayjXdscrxKGQ2VPXInuB/1Mt7b90WTQ3kjYD5548FqsVy4JEFdV49r3/PPU/86H6j328KR13qX7F2kXaPn1xPJpXlJVM50slmaFEM27lVFNAYxNb/mz6hCYg0bC26eI33n3EyNaSXh5ovg+fA2gHlPAZ93dpv2gnFIXQvVjteNg3IFc0zcN67zBy48bRb/s9RvBcDIYuPhgC0vQRGWl0nOVuUMkv0YfTvtalkIPUNdpBv9KW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:49.5675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bf56bd-a9bd-4e43-24a0-08dc4fd9e7e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

During the initialization sensors may take some time to respond. Hence,
increase the sensor command timeouts in order to obtain status responses
within a maximum timeout.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
(cherry picked from commit 7e5ce11484572aae906d6b3e098c78d3a95e5288)
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 2530fa98b568..8a4cd793d021 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -39,11 +39,11 @@ static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_
 {
 	union cmd_response cmd_resp;
 
-	/* Get response with status within a max of 1600 ms timeout */
+	/* Get response with status within a max of 10 seconds timeout */
 	if (!readl_poll_timeout(mp2->mmio + AMD_P2C_MSG(0), cmd_resp.resp,
 				(cmd_resp.response_v2.response == sensor_sts &&
 				cmd_resp.response_v2.status == 0 && (sid == 0xff ||
-				cmd_resp.response_v2.sensor_id == sid)), 500, 1600000))
+				cmd_resp.response_v2.sensor_id == sid)), 500, 10000000))
 		return cmd_resp.response_v2.response;
 
 	return SENSOR_DISABLED;
-- 
2.25.1

