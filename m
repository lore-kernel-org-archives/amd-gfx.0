Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ADAC47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1089810FC2E;
	Wed, 31 Jan 2024 20:14:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D06E10FC19
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMzPTl8G1i1JhVFEAZPunT6ct0y53xjMVgyafSOq2xdCc3R6FRcMyKUIeFFwD0SS4hzE44IBvSL+qExCz0nGuL9Uu7qh+h8jiNQBQ3VrjZwx7TaATp01LOHzbqlsDp2uCMNW1u+EMbigKm8uLbJKUDINabt9zlz+R5qifSXJirUjqZgUZkQuDfpmoQGrjcwBKsoxlsnuJmfi4iBOYPxdPrK80Z+ciLPcsM+hMJxg8vMx7KoSuC27e/nxUNguOQYNrAIl3TYJzhxUCZUSBr0VaMCpMUPkuqvxnFVEDWcUIID0lbKAENL8L5upRCLJNDJhLbqUDU9Ow9cd3NFRdLY6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDdGA+8Z7epkSKYBppxmLTK89f6OJBNtXsRSslnq/vI=;
 b=ROsxIhiiVGcxlCE0KAoJMVhyNBDmRjfPvl2CoppC1yfGCt9bDmXwWq8OSaVK54kzBOSYtlCCvefC5dAPaitq+knr7qpqk+fdpcvgtfH3uyzEJwV2A/jRa//fsqGwvngXYkwTeaEmj3XD1WVLSgkRTs68lkGKnF34cQLU4q0Ft2qJjrNPhFgOpcd5+hhV8k88rR/C34yIeknimzId4eJIzxE9+Bp2KZqdHkVOaAze/ULJ3Ev/+TOfRVClhF4XsvFidm/Vt3q6TI4//G985DtpkwmusU3hBc3K0ojjCOxTZog0EJSpjpZw4O/2Rd29smb+486oOdwDOdIdL0e0kpLTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDdGA+8Z7epkSKYBppxmLTK89f6OJBNtXsRSslnq/vI=;
 b=EjdAawtc6sYFj+h7+zUTT0dOiBLOqZxXPd+daCxi/vY9dasNazz/PBRsEWz1FtLQZ7TtFt0jy+CoQa5FW91hnIVfEN6bGb5sB9913PQM/SjZphPiEXpCRqUNu1NzGAIBqxxwp1iq+9opmQOtVPPqKq5LHjpHgGbhAujhvM9r53g=
Received: from SN7PR18CA0009.namprd18.prod.outlook.com (2603:10b6:806:f3::17)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:14:47 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::20) by SN7PR18CA0009.outlook.office365.com
 (2603:10b6:806:f3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:09 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: Increase eval/entry delay for DCN35
Date: Wed, 31 Jan 2024 15:11:13 -0500
Message-ID: <20240131201220.19106-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a537614-cf6d-4e63-f8ba-08dc2299459c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIMBiFRdw9O0vsj+Fvc4rN1BDCwy9ozjyvVmRRJoawo6U2aUwsUV4W8NyvQFhis4kJie0CfbjdznixEn8TlQOnZb9M4m/9qqD2/O52k3BZWbZMnC+nLb0TCNme4wS0zR2p4Bb+bBu0gEbosSZz0vnfszC7wfjIty8kPaimnQh8vUGMaI1QseCgkTv7MeU7AY1TszvvVpYSkdFIv+QJdElhDkaRYVdNXTpcJ3K/P3vUhOWzLhKMrdxssApFQVx/wNHjyF9MFg17uc9+8stv95bEW4d4UHIb6EEPrVdLKR5iVm8kNbWAarlZE2/pmEIEa0zt5tAKDYBlHJlNzMVgYdaQQoVY0zZENAxqGjs6wietpPC+CQuTw8xMyKHTsodOWMf8fGyT/CxmLZlYWwUCkDwMjWbq+t+w0cRtxyQSXLeYF7utx73mSDNL9moImY7lOB2J5NGUEMXPd5aElilzLlmWXzYihxkv5Duj38O9D2fmMIQ53nAfn7PiNuFI27qptDMOIgZ36xjV3stFa84o9FpoILaRqKPshW1cEOdLH2YUjByAGVXpn/EJU6gnZhY0cb+I4gIs481xH3/UEVB4zxnm6q1UNWRTYTuH5BVUwnj3wtdXQYIes3AFRZeq8ukMEjenn31QHOi4yBXsdMXj/XfH8H4H/S3gcoHwumq1DER/pWBuCcOqQ79PziPcp/VYsWoUf1p7pMgJy2/PZ/lpGxIA1LQCDh1yqRd2koJyx3i+KCkDNtvqyKOxrgqZCZ52XTUUI5vsslipPCLVk3EmnGeAQ8tVtPboc3nYE0mfbYUIZB38yerz+9+5Y+dw/N7uXH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(83380400001)(41300700001)(82740400003)(36756003)(86362001)(70206006)(356005)(81166007)(36860700001)(1076003)(2616005)(26005)(47076005)(336012)(16526019)(426003)(316002)(6916009)(2906002)(70586007)(54906003)(6666004)(478600001)(44832011)(4326008)(8676002)(8936002)(5660300002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:47.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a537614-cf6d-4e63-f8ba-08dc2299459c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To match firmware measurements and avoid hanging when accessing HW
that's in idle.

[How]
Increase the delays to what we've measured.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5f7cf01abef9..d74e5c9e00ae 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -781,8 +781,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
-	.ips2_eval_delay_us = 200,
-	.ips2_entry_delay_us = 400,
+	.ips2_eval_delay_us = 1650,
+	.ips2_entry_delay_us = 800,
 	.static_screen_wait_frames = 2,
 };
 
-- 
2.43.0

