Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DC110FC456
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 01:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA1610E70A;
	Thu,  9 Apr 2026 01:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nP9/tUqo";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B2010E70A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 01:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkFU26DyxJCZ/HZ9sB6AdpEK/fBKGjWs67bUXL2pJ0TzSZScbPfNFOq2w3ahPBO0PEA5HHVMrPXR8KyW920BIO124HPwX7MnwyNrI66++dDAL/CWBJ9GCmfnQAV2Rool8rJAKeuhfrLJWaOPK4sgj9xWabJ0HXWgcb7zigv6I81AWCjQeMETetIf3Gez5djx2a1zyIZRsoiOtFZm9yTNDu3wRS+cL+KTla9MiKHs4qlgDL9QOwGGl08J2PRdiZw8OlLU5iJnOEEX0bsEC9gvGaN29cqV8Yrn1zJyKQCZjoOWxBaZbGwHQaEgDxQJDD4yHrHjqGiIfiXjIzYDdTAIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuYo8kubDY5EwptbVuOL1WgYpN2hKCN6TzAEPEmlK5w=;
 b=abyjwWHrou+I3BQfbCozBU2h4duVD+0uAD68laPKdxdUA1Ov4tB9rchPsphazuv5AavfNOdofsd5eRlsUWKA36GEdrl5fnI0IzogVdiCkHf8R0u6TWqEpeyer3fWKe4A5b0YvYrdLHUnPV2hM89u32L3i+h5X2IqlLHTsbJ3EAjcAPqano70nk7CSaxI9Prm7h6Fji0223Wtyf2Ay7kZ85DTlsyFVU7o2M3Y1mozLBbUlzM8X5gI3nMwa1EU+ARsXjAxR77d4VDRb7KefT91EmN9YdqhJPcbKOC+dAKmS2kZJYQvXns0lNPleugHYy9PMbm7yrjPTlQN+2jC2oO68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuYo8kubDY5EwptbVuOL1WgYpN2hKCN6TzAEPEmlK5w=;
 b=nP9/tUqoyJTep23UKiQ/wCtpr2HU96JDUVmVxmZ+JZlNGRAJoxA1XWgjV1FZYvaQ9EPbxn8fgIX4XNxe01EezKPzzKcR3hdAVn/7H6niWoHcEwyZx96WVtntQ9VMzTAtfrdQsozVlEyME2L+yJUXmFyO052iSNjWGz+PXZ87c3Y=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 01:42:05 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::40) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 01:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 01:42:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 20:42:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH v2] drm/amd/display: Add missing do_mccs parameter description
Date: Thu, 9 Apr 2026 07:11:48 +0530
Message-ID: <20260409014148.2282920-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 89baae1c-25ca-494e-5e58-08de95d9345d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Fm6bDvivJd+tuLQVSQDPw49JKCRSJDaAzr2QQWrSYPIcgstIcpa6wI3b+2RrqGiNJAEeTgkxV733gsaZWqliL8CU043ZmUFD7vp8IFACDASn3leZAU5OvfnAJZ4FUov3/g+4+TbNy52troIeNxg4x9AWlDWccMAP8uZiJA6p3CETJts/0aCrQksLaljb7GZkXFtfq57IHHeAh8zyJT5LvJnNqiJoEPyckEKSHrVV7LHS3tQSDSR/sYrTrGQW/KJBhgZMKYVZ6753vwcxbaN11jmmuP995epFgSn0FVtGrxU8wIgNyyzNcka2nGFC532CqMNwHVYmKecOKN6Wp19ApGrj7qCGorbbhaSa39lwDxt395quLMHtDorL3kwe/MPZT/bUqm/j3GY7jSpxDMJLq1NlZNxG6O9MHLRUOVwPoWv9fXUIBYtHqHo/ngbyDtXHfUUUfmnw22oWwrXpCa6/JvZkrE916D0Ea+nftRrpayjiwvemZW31FOJ96AqaMtCSV/+2oy07iuoBd0hTYMJ3Y0XKixBqLeH8nrHwmZ7zS777WxOWu2f2M0SdC2/RclXNvsR2MfPpXt97N5AGPM6r5E0zmBz2P0edgrQpfpKL5y68PJSZ2ssMQKC67Z5y/zbDsRyt+QdMubHlScODyCgpXvnrfjZx3TNU/KQftSAngm1vnffpsSgr5/IVpTuv78BpWnSwBWCw9W31iORdqJpkIjgvztPjvahZx0BuuJvKOV0opbDac0Ynv/zx2ZfRzSBZEgahPyv7FGRDWmj6nB931A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Ekyn7nR/D++LKBfax9UrayObQcYTVrBH17KfDzt+jzAno53HZQ7MiCBeQtgmBVWqbBpFupMLBsGY4+by8fGKpkDjjydify9f/fBbBpCWwZcSzigcqhHa6X32/I6ie1XY8zV1+5QqdcvgP9NKcnGQ1gV8bKR/W0pzfVqOzrHz550UN4aZ5RTqI3Wi09K96OxJDjQVycKXCP84D5zNKA3oM8dArOaWO+8k8FgONz7eSP0yU8mAniRM9uKh/B58+7bVo9gc/lm//QoMdvRIU7cPzk95/czqM8MGgnWULk2EoTbNqIjhjgzDxvI+RnbTV2EtLWhbEtgSo13aCO1NvnftYIgRKFoKKRXuyD8qfvISpOvUgBc7VFQRgUvIS8qochrizr61Wz16yA9ukggw2QxeXEcXKe7/YfREjY81LgxPt9EJGQDSuqWmwDjfCsJz8jo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 01:42:05.0834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89baae1c-25ca-494e-5e58-08de95d9345d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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

Add missing description for do_mccs parameter in
amdgpu_dm_update_freesync_caps.

Fixes the below with gcc W=1:
../display/amdgpu_dm/amdgpu_dm.c:13269 function parameter 'do_mccs' not described in 'amdgpu_dm_update_freesync_caps'

Fixes: 980a8981351a ("drm/amd/display: Avoid to do MCCS transaction if unnecessary")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bac02ea15b8a..77ef24ca8b26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13259,6 +13259,10 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
  *
  * @connector: Connector to query.
  * @drm_edid: DRM EDID from monitor
+ * @do_mccs: Controls whether MCCS (Monitor Control Command Set) over
+ *	      DDC (Display Data Channel) transactions are performed. When true,
+ *	      the driver queries the monitor to get or update additional FreeSync
+ *	      capability information. When false, these transactions are skipped.
  *
  * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
  * track of some of the display information in the internal data struct used by
-- 
2.34.1

