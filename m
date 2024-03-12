Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6AAC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9206112C10;
	Tue, 12 Mar 2024 09:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJmC+HQT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D56112C10
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhjSew0cpX0h2KDElgQLw91SXU5T46sPkE1cF+4MAO7DLh5Czjf/HM05aqZa65hnTFVPShUG4K+9Wa4YrU2jZvu6PGGvZxkE7qWCMmyXnkLkhU/BK9VdqKHWzgsFqfkDJGDTXFBeHjGe2nWQFwfuTpQ01KZLPU8vNHfyNfAngo8vGBNeszEWZeIyhuTHr1L+FffI3peIy9zznt+7WfKstcoQYuIUxvoXaZTasgjnpWcEA9qeE9FJ9qtSFV6+7dVmYJGsxWlysrfN+4Lu55vyrZ4zePFivv1NYp5s1z2tzqzrlQw6V8HTCkiR+GDCpi3IIDskrQDq8ONDKBtSyiQQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hnqFcV7t4j6KtnS46BZgF/umq6dVfmVHBdeDdUKnKs=;
 b=dU+riAO9DmqgAKwlhEwEp2q87FkqiC7DpSqSjOwaddeZwxL1e6wrpdxUtmIjfISDYXH771SxGVGg0Qe1RrrtvQvYCp0cAvNQZQP2cUrhTLZ9Lg3VkClGPNuPx3mjTb06N0xEJAB7Uowq2sl2V3n73ur87aDy8vk91y6ksYPGG4rnKEh1TDyKH/0vjWXYm8VN8RcDZM/nk1E9ZTs1Q931pDsZH4Ky8z8AUiAMsJnDuITFKwsl7us0d0K8fomMBW8Lag0OX31JZdVEpK89HFtoZv4r+tN/SOSMneXVVNDUZUYFHu82Fo5b47LH0ulMNml34rZEJwMdHRbAsMXtDER2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hnqFcV7t4j6KtnS46BZgF/umq6dVfmVHBdeDdUKnKs=;
 b=uJmC+HQTJ7tE0g3h1BmQT/Oti2LjTkYy4vck4MVboiomg8A/2S0eocAR7TZPrxKIF6S1vhGLW4g/jERWryz7VDgJf0EU4x/ho3CMNP1W4j24NCak3lzZl+2Kob/f7DS6OJlyeO7yh/+9GrVvIs1wZEDP4PVWTi3spdg2GOx7opk=
Received: from DM6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:40::32) by
 DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 09:23:25 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::81) by DM6PR03CA0019.outlook.office365.com
 (2603:10b6:5:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:23:24 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 24/43] drm/amd/display: [FW Promotion] Release 0.0.208.0
Date: Tue, 12 Mar 2024 17:20:17 +0800
Message-ID: <20240312092036.3283319-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: ff31ae5b-f597-4f44-8d40-08dc42761235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xllqjtg/ZTz3PxiWBfJ2TrjSXxVYKYSq16SvXZRVkwlo5NH2yDAaEdQmgl4DZqQQwdTKkL3E6dDDrklYnxOI6LhQArSb6MlrywN81wxcttFiRPzsbuspo7+P2+P1TlYf7jtI5BEGMKRADuT2Cbs7r/J+0us06r/IAZuCHwLF4H+nCs0C940YB+2mvSroeMyesml+lDwMluoHzs2ownbNtnve3UivjXuZ2uFnhfWpGPGi51DwgcibZKgk8FK+cv5EuVTO+iqY0YyQXgcAWf2tMJhMSBEBc5W2Wi3UJjeuh7Jx786rNEM3qkUMKcttbtTdAr0QbCkKNKXKDdz3SZOkKk6QAG91GeeWP8Hlm8d5eDU/XQOUzUbw/Qu1No54GXOtf0k0ddlqzBHk87yLKrV14SgLqwxpNBfnIVktXUMkeciQ6HL/EuPYwL/Snf06R2s3CkaM8gt5t+RJ9fhnc5Y5OcXsMn+Yi2KlaMEQxA6acbwQk2w2qKVXB3tlX0FxfnEk3pLFN1llu8rAmR1PRS0a4Kdag23ask6oGLH6gum2KBxBqjCQ3nz/yRoaKSprKAkjDKvkMUy15mL3++xW16Wg8ezjqrshM0UgM3MO09+AQ468quXzh/szhtLqMp4+YELGapLZMGlbvz38LVVkavZBQZoPLMejzMHiU6K492Aes4aMj0Q8WjX9j9Id4QKMvsQZHioirVJbSicrPH/zc4XlEBKW7L5ujxrY8N/NyVvAdsRbNahKYj+eDIxxqbQNPZ21
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:25.8060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff31ae5b-f597-4f44-8d40-08dc42761235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328
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

From: Anthony Koo <anthony.koo@amd.com>

 - Add a Replay residency mode which only calcuates the
   entry time based on replay state 0/1 switch.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b81cd2649db3..7b807aea8aa7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2957,6 +2957,7 @@ enum pr_residency_mode {
 	PR_RESIDENCY_MODE_ALPM,
 	PR_RESIDENCY_MODE_IPS2,
 	PR_RESIDENCY_MODE_FRAME_CNT,
+	PR_RESIDENCY_MODE_ENABLEMENT_PERIOD,
 };
 
 #define REPLAY_RESIDENCY_MODE_SHIFT            (0)
@@ -2971,6 +2972,7 @@ enum pr_residency_mode {
 #define REPLAY_RESIDENCY_MODE2_MASK            (0xF << REPLAY_RESIDENCY_MODE2_SHIFT)
 # define REPLAY_RESIDENCY_FIELD_MODE2_IPS      (0x1 << REPLAY_RESIDENCY_MODE2_SHIFT)
 # define REPLAY_RESIDENCY_FIELD_MODE2_FRAME_CNT    (0x2 << REPLAY_RESIDENCY_MODE2_SHIFT)
+# define REPLAY_RESIDENCY_FIELD_MODE2_EN_PERIOD	(0x3 << REPLAY_RESIDENCY_MODE2_SHIFT)
 
 #define REPLAY_RESIDENCY_ENABLE_MASK           (0x1 << REPLAY_RESIDENCY_ENABLE_SHIFT)
 # define REPLAY_RESIDENCY_DISABLE              (0x0 << REPLAY_RESIDENCY_ENABLE_SHIFT)
-- 
2.37.3

