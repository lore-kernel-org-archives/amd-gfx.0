Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58A8C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A53F10E63B;
	Wed, 28 Feb 2024 18:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGSMnthN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F417A10E63B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEa1KhX1qOVtPIdBRLQFm5NsO4siomVR9B7M984veJZ+VU8VGpcmqDpzTkNzfQ39mDOF1479Sojbn6mCuFO75cMOE1gjkrgZjsEs2qtXUSe6pBZCTvWUa2CkzV/cKBS9izOIyPSx9x9UJzuf2eAR8rbgA3RGjWIpvnhLigQ2IBE0VeXgWwZlBaAVMSJpIvln7W7cZLMDjjY2fzdC5orq0gckVQk7W1NPxvthkJObqYRcU18ES1yZ02r7qE46UcO7NWVUrWQoRplIYxYgD+PJZ6p+SjoT32Mv+lDCtCO4ptvPBq5A5PYNNCNzQeicQbsW3oAu+ZLjA/ONaNxZaf1B3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6817TsJkLnxpIzyMUqXP8IlNaUCBcWfC1ntIIgy4RA=;
 b=ZJFnQTxzEcPFK1FOkPz69m0wB58RQYLBDfiTw8bO5XxfzpnZeU1bRc8GCyKtUCxZxDoCWxFJvzkx2q9d0V1GIl3Ex172GlIg+M9ur5jIE9sqSYl3dJ7uegI83Dg7l7Xy9SNxyzw+KTdrdk19/UTNo8J7bn2ueD+LYpgCGC7zmHrzocJ+JM8I0LkM9/ov8fLEA3q/ZU5cVbYcHdPjNtLTH7H4eEvY/EEhpoovTkf8/4jghL4eRMC1EcCWDneiUIbMzLhc4NbrComJIKGhQRR1B4SxZqsdhqdIlkqEJnIskHJkyZLkh5LDLk3VFhq7zceqh13BlpGcbRARvm9OgZy38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6817TsJkLnxpIzyMUqXP8IlNaUCBcWfC1ntIIgy4RA=;
 b=YGSMnthNjLA7ylbxKYbQ4/tCJx2dXfhf0jFkowjBLSgMyBfwU20S/0L+rHDOugpNaDs4HHOMhAZREwIBoajqc+ZMpRdCf1mRzbzZldnKMwzLheI+p2rU4Wt1VtftoFSUUxCWtHWr1vqsN6iTfju+i9wO8M9MMMya5J08pyukziY=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 28 Feb
 2024 18:47:25 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::3c) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:47:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:47:17 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Allen Pan <allen.pan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Charlene Liu
 <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 29/34] drm/amd/display: Add a dc_state NULL check in
 dc_state_release
Date: Wed, 28 Feb 2024 11:39:35 -0700
Message-ID: <20240228183940.1883742-30-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 41322116-9209-45da-17c9-08dc388db1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWdyOPDG/FYFn+rsT7OVafeC4pu11Lz+GeqJUR44e/uA8N7mAnPRu5pTTz+u4CBsi/4gdONDf8YtTaQ79O9dDnUHrXkOEXCriGV5h24zkCgP4x/Oks+TApxyX+B5+UxYkBS6e6cbXiL7TZa/48JQRtWaK5QwtacR1TuFSxSdH3IOxowF2YvLM2pTpRVsoXNmat083RSOXgbUxKj9uj3vno/UkbQBbe2rMzaKky+8LWfOPcQXu9xTZMnuxBuf0IGBgZO+zBZfV/t7+0ev7VMZhXL0hcxSzawSTxGSuc3+n7viWeyrhaEXd2xCaK/yQPQ8v37O+aR7nFoR5BnPd3F75RbbcxUbrOByziSnLBGB35rQHCzZMlK7+CwRGaorQS8L2y+iMg6kKepxvkH7BJBoRhoJPCZqmMF82sFW3+3kpPDuaKJ4HRwMqPnl/hAR2VH1oCRnJJVHCl+Il+hi1Cmf/YR9Jfe6AgTLEHV2aojIIuJIIrQo5eYrVNvuDY9wH12j1eYI+n1CcAdBZZvosuTfZWlQUMjCduH71exeLzt0BKNcbXwQQiuzzIkIKeie9qZIkUE8bH+oBkYYBJAPmsodiQH5cCRuwQwQ9uaoXnYGPo/9SzoG3T9Oac2tBzBDxM+d/2gR2HkXVfSpUZQWA+uX7EQvyMsGnzFrOMxLH5spaT6oAUpPKhqwv7L+fc0MVyko+dHY27DWMUJqHTLgllOhNCDYurxlV7PNtsLyneHA263SIo86LqMAIuakmemRwJeK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:47:20.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41322116-9209-45da-17c9-08dc388db1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

From: Allen Pan <allen.pan@amd.com>

[How]
Check wheather state is NULL before releasing it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 180ac47868c2..5cc7f8da209c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -334,7 +334,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_state_release(struct dc_state *state)
 {
-	kref_put(&state->refcount, dc_state_free);
+	if (state != NULL)
+		kref_put(&state->refcount, dc_state_free);
 }
 /*
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
-- 
2.34.1

