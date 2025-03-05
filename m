Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECCBC282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E20610E143;
	Wed,  5 Mar 2025 05:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6WrB8pb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D17210E6E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iB0W5ExKBMyU6tDfupDlCHW8MgZBe5JopTwPjQ9kCLzaTpVh7EuImiHkSvWDq9QAvltXSJ831wuupQAImxe5Q+880RciYQTpluiWv0hmSXCvUFjQa/MhgoIU8Epiq86ttZe0pITHzqVXHZR4XVygLuibHpC4zvHxNNLJZT0iwXJ2ZoO53x2SUDVmiG493+F6Wum6epo9Ok4q4uQpxz16TkYml7fMv0u7G2TEHwQuRPwGqLw18ecO6DSmQmHJmHdHpIrDew69cMfSzw5+SUU2IcWG3f+c3vDjrnBvTJbWJhf6rJq222ItPJojQtvIgt9NJ3VSlL0ToZpwF+Rxdrb1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irVu+WX6tFUR0NOaiWLXsyVUdfYJ1JW6E7xNtABaKhk=;
 b=qmxlrLHwsqYYZKGOA7w2y5KzsPFi9KCBgm6Kdj1yXG+O4B5FG48vVhiJNAHOEsZXRDhV2R/JYlbnxzyCK4g7+Pzvn7udXJRBlqWo3YgA42YH8Y/VSRHALCkJn5YumAYW1vlTTgfyetBjy55Qc0Gm5Mvygd6uIGRCWNYoRqcME5xzSkuEm8aKRLR1alGDnm41Aq+5dqUFpjWxwhInNCb+QSJsPS7KFavUKXqNjKI+AL3fK7ykljC9pGdwbhREZWAuE2RaKE4ZOHIj8fzyWAwnq3kxpApQ/zKehd7IY6Ykdninr4RCEeAa1AfqDk+XHBx3DsbCDje9XYKrkNfb95Allg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irVu+WX6tFUR0NOaiWLXsyVUdfYJ1JW6E7xNtABaKhk=;
 b=f6WrB8pbu11QyVO3jDp+re6hoTFmLKkRU/cE9X5JtFx+/J+p7wjX8qrzof+cY6BNs0Q064FgJ2o5RZqU0Pcd8wRX0Kv+thKIEDx/WbWh2PAdhV1v1IoyQYH9A08nx9yQgyIefQPCOBYGJ+N9HgLvOa2aRxkSvgKiadFs+IF4qPA=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 05:15:07 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::af) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:15:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:05 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:14:57 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Restore correct backlight brightness
 after a GPU reset
Date: Wed, 5 Mar 2025 13:13:45 +0800
Message-ID: <20250305051402.1550046-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2322b7-1482-4599-3b73-08dd5ba4b132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LNjh//QzVMsftVePcxz5T2zlhjvJ0WZC4nlNerueVczbIseCiIBDEaZzY72U?=
 =?us-ascii?Q?3kqn5utyTSWoVE5qYajsEmXUKXUeW7Xswi5gtzDnRMjos1zN9qd/6uvG6+Ms?=
 =?us-ascii?Q?L9Bfb/m8FkKehtBsQDHhL5AQP/J3pYO1sUgGVvFPUGoXjH3ED7sY/bzZ6a6c?=
 =?us-ascii?Q?aiaA6MSoXyCcMqGrZ6+oOSWIb6k7o2vWrDn/XDOCGBy6PO9mz+zRVT978keU?=
 =?us-ascii?Q?UcQZ6SKBV2jxTLIFBL3DhWP5yDO375Y2bGZ0uRodHX4oOHdYi7oQIz5cg+w+?=
 =?us-ascii?Q?dYakcUNmxloCaGRq1ZDnmeSWfxq7Ou5rztz7ycrIOiocO13c4XV+6BOC8DKN?=
 =?us-ascii?Q?mhEE++R500A5mPcQOpehjxI+H2dOrjNT/elesHYAt7dxPnrVnBpKebbbUf96?=
 =?us-ascii?Q?N0gLPS91sSfCs5Ht84zDTRQscZ1bTLPJ7KgyadtPYWzP1TX+OttFL7alqdSN?=
 =?us-ascii?Q?Ud96mYMP+2rZlQPoS1ROrRRH02KXfGEtnyAfhM4Og4e+ghjactbrH7+H691Y?=
 =?us-ascii?Q?6wLcymnTr2+PDQhwZnqjKmPa5nAn7rDzs4csLEHjR1Gk7iVV7cc7gxFpxzT8?=
 =?us-ascii?Q?mwcXkDQvQOhzRlEvLdJUBBIGqMznbkUilqdQCEv/AsfeUaEFbtbrnudNbcjq?=
 =?us-ascii?Q?cpC404nFYxrIOVGkNhud2uSRIwJAig3jx+Dou7Tyceu1BZLRRaRd0RR+Yv0y?=
 =?us-ascii?Q?cOvwnr8EavLGDcBn9nAsPwb96/+IFqmoKq0XfOpTTHbzFiC8u+aGDB8Z5/2n?=
 =?us-ascii?Q?PUAvn/MK/Eox7gpXJQQWmINRbnqei1fd1mj+j7VLT2/gP4RNIyEs2yNOlOMH?=
 =?us-ascii?Q?HkfBLO9oEO5FGZQrVooHvZmeqvZpQz1BkfruG/Aq6BdntklceYyjnu389qOD?=
 =?us-ascii?Q?SYui+jUl0SD0rDgzJEfdndyto/02IlAW54YAaNdAg9H64jACKOrHKwUsJ3Dd?=
 =?us-ascii?Q?R1Cg9JpQtVBoo9NuBQ5b0KyJiZJpc9wUozyWnTAVheHVfW7gtH1edfrvbGpf?=
 =?us-ascii?Q?JRwRiKdM88xOcXRX64BmMYs/Wx/CIbmygfYLnFz8URxonLYCX0GQkSN31aAB?=
 =?us-ascii?Q?4pqQ1SRsKqJG0DZuQc1GP/tIn7BFt4bb/AAryw6MabmTOdTsoNJK1prDwfqW?=
 =?us-ascii?Q?LRZwYj+agWoYDALuRzCgJrYLN2H7Cfk4Y1dNlYdLDydwE8pw2TDmahwHl93F?=
 =?us-ascii?Q?DVxalbBDKAGQcILW6BlnxfjSV2gp0abvY5TjaHwkl4iJnCq+T/JUy5Aemxur?=
 =?us-ascii?Q?ht8zYSNTyNorquZlLPzwBeEE5wOtryC+tCygH53DvnYb6BgP6ybSdJAVSH7Q?=
 =?us-ascii?Q?N0EN2ntVGMzlll4Vo6WWPAMafcTi38OQ9PId1+u64LVklwrhrTLpI9U0Od4P?=
 =?us-ascii?Q?V6JdGpae2RAliznFKHOT3FQ9muWkBBwuHv6PHq/gOS4AwOZeoLbK/IyGN3Xd?=
 =?us-ascii?Q?B9Q7ChCbL2aaVQPGHdTE+72qVAWo4NhHx/Vzw3mrtP27re71l1etO2/F3v4A?=
 =?us-ascii?Q?RabgZavIRJRt5eM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:15:06.1633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2322b7-1482-4599-3b73-08dd5ba4b132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
GPU reset will attempt to restore cached state, but brightness doesn't
get restored. It will come back at 100% brightness, but userspace thinks
it's the previous value.

[How]
When running resume sequence if GPU is in reset restore brightness
to previous value.

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6e2dd3555165..60fbf2683880 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -249,6 +249,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
 static void handle_hpd_rx_irq(void *param);
 
+static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 int bl_idx,
+					 u32 user_brightness);
+
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -3411,6 +3415,12 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		mutex_unlock(&dm->dc_lock);
 
+		/* set the backlight after a reset */
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
+
 		return 0;
 	}
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
-- 
2.34.1

