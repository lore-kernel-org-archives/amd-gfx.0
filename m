Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FC606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QUG249+T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262E810F96B;
	Wed, 21 Oct 2026 06:28:53 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A62D10F972
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRuIazLXEE9fvFZSYikt/nsDteyaO8nB0j4raKfkpFFRyyBo3gxEatuwzX+GTylE71hLcWZZnHUXPnEnjYot3J4Fydl5NySwOy7kp/KBqaFjMJlld55r2wnPHuT+kvahAc8l8QF0RFGOMoxVqPlommXDT+knIkllPB/8uM/ZHDOjOHZUgyNlXa7sn6ilkA8pfpCJUpalGlFuuQiIono7MHVGThcjHp/qNxpKsgJ+dQ9Yy/4vuVVnUMrAbkLBZDbj7yVDXrz4mLnSG4fneBKX+cLVtn9YbdtyEQE47KA8XysoYPYd4nAIlOXEbiwDfgwHU5Kbk4nRo8qaId7ZqaP4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkrt3s4nrECUAwcaBsXIop/ZgCp1wBiFbNtEIw8V7eo=;
 b=XPWIGpWXcPXqfAsbhJyEaa/+S/1wmdqJ6oL9atbDOXN9/8g5kmgb1iybgxeeaeGw0pU7wYAFiQcevVUbIddZwtGcume65QEYi6FhMIG0m7VjggltPsU7ezswKo4aHsffcQZwTbagEhh7RFvcdIEBcq9UxBfjeXpF3W7DUYkxNKqogRpwMLkzTV8Y2/SfXqEyUU4pYDtetcH42dNbnrnXZNwq/st33Teb9ggttNQx1drUFLnWQh8g5HSYItl3dDKahupSrpwX7xCUgX7Mf+Cd6X3GxjeB3+0qwQ5V0sSh2/xW9Zw2CCA7hy+JS+IRnf/gTS+bq7+8wwv63ko+rIdrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkrt3s4nrECUAwcaBsXIop/ZgCp1wBiFbNtEIw8V7eo=;
 b=QUG249+THv15PuWy+GwAYUaJ6TZXumDLa+fNVVmbwYm6VFiqtY48wxnv/NNlqEDXaDKx4WAnoYDY8X4PvpUNAeEoZftmAzMiNB/KEqFwlR4UXemeMmu2+eyrN1E8OyP9TaUTyC4EjQn+E/bGeQpdWxnAEEyWPHaTlj7IFZMf0Ig=
Received: from BN9PR03CA0973.namprd03.prod.outlook.com (2603:10b6:408:109::18)
 by CH9PR12MB416419.namprd12.prod.outlook.com (2603:10b6:610:354::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 06:26:43 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::71) by BN9PR03CA0973.outlook.office365.com
 (2603:10b6:408:109::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Wed,
 21 Oct 2026 06:26:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:42 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:39 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 22/49] drm/amd/display: Re-init cursor offload to dmub after
 resume
Date: Wed, 21 Oct 2026 14:22:28 +0800
Message-ID: <20261021062519.674697-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|CH9PR12MB416419:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8d5cde-2c7a-438e-3cfb-08df2f3c4653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Rh56gspxRIZ2kSBKcuBTz5YlEMMOW3HI36TohgnvxZ9UMitzlTTVd4uAZSP29Rhz5hBfa3sErqPV9rcdMreVj3/jEzPDDTdD5oHErQsWOGMbzwy/AM1yjWFSvMHQRDb0tf/twsl0PLc7R55uzqRAtv8mIZCVn2UJ27MXIfY58cCDiLoVCKgD7f2ObpNrXx1gOTtboku9e1aJsT8sIQ+gJjmN/hfbDTFO9KaRwXbsbzDx4wKSyVblrLLTqzFmI8ZsMpmBZiaKWauiBswack7CqWW8C2WEubjXidCEFfGyJL25XNINU854QR6d0q63UoXJK9R8UNKvKVcDexFy7OkEROE2d1rr9wPfGHcdcXq94eZuLDXO6bSFGBaUnnlL1Ngh8ZqCofj/ciMzGBgAHU1zo7IelvdKaLZHye3PEEpGAzOw2wBuNqObcmdQTQDpxOXozGx6EYwCCO82YAyhvuIw5u+5FhVb76vpFhSX1gZi5YSnTwqHM4cod0j4zRlDE8LwtFa8aE5hP9utqIrNFIgxeCivv+ceQm3MVBkPv2vyhuVU+B6low8QiLijvyqfCrZlB6Egz9cxoDgJBkuSTjfuDi0YizeibG0Bf3qIiXN3OOGUxaZsccdZyBGTcOo0tmayNZwRhAZaMQo0LE9CsMukJQtEJDoAeGZw3hOHMmPXebG5BLLAslqXE4eEiuFmIcaBW3LuyU32dKBYqlpWdKOI5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qy7u7y0+w7NEVbhY9/moNGHOCl7Dmx2Egyv7lc48qZ5HaKosPguk+A6AnjjZI+YyM7IkTCZiq/Hoja1A9Jo7myPueF0OgtNmdV320fgjvCFjbRcVTySmokXoI9DRPEVSgoEw8KdLn2ZqRVaU7RHszx0aeEl/OJl1Y2bnYVy8IdZ64GRHjyX7domfjBSRZ2FUoPcEzzNHbut3Q5xvFDRRxrmJ2iJ8MNXJZ2vziHMeQNJNzLPrNQ3HUXx1Bvw8lmnqqRyuP3oiff5e0QfkxEorOdlvuYO7oD1C16kmUU+HF30QwX1pfyBZhWTm9CWrB3xcM2gzPO/NtROPIEEtdDAHP/VuOAy1MxGklV76Xr5i+VcjjcjO6qAuu+nKSOwdupyy2tZN6HB/+qGxqV4g8rc26xhbui5Kd6MR8fEgXN5NDkJ3HFy87f7qDx4MUfMXWgbX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:43.3880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d5cde-2c7a-438e-3cfb-08df2f3c4653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB416419
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
On ASICs with DMUB cursor offload support (DCN60), the cursor is not
visible after suspend/resume due to re-loaded DMUB.

Re-initialize cursor offload on every dmub_hw_init.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 3 ---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b016f737f3e5..a01ae1f1838e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -718,9 +718,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	/* Enable cursor offload if the ASIC supports it. */
-	dc_dmub_srv_cursor_offload_init(adev->dm.dc);
-
 	/* GOP/vBIOS may leave an OPTC enabled for a display present at power-on
 	 * but no longer driven (e.g. an external DP unplugged at boot). Such a
 	 * dangling pipe keeps DCN out of idle and blocks s0i3. Power it down
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index f4b0ced7d391..b0325d686b28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -319,6 +319,11 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
+	/* Cursor offload has to be enabled; prime it on every DMUB init,
+	 * including post-suspend and GPU-reset.
+	 */
+	dc_dmub_srv_cursor_offload_init(adev->dm.dc);
+
 	drm_info(adev_to_drm(adev), "DMUB hardware initialized: version=0x%08X\n",
 		 adev->dm.dmcub_fw_version);
 
-- 
2.43.0

