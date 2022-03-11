Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F187C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 15:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D93910E0CE;
	Fri, 11 Mar 2022 15:27:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C4E10E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 15:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvwXetGaINyGabV0sfBp1HO6GlHRBZO9JhDx4GYcVRp8zlcJUB/RA/rQOsyZijJT/5Q7LtpG5rikIpyIYQEBce0QjI/zulfiloVst6+ezqPikXXr87QReIlJjRW8D6o62rWPn1UWFYHuHW72ghPJL0+eIOSlruohRIf8ZbjvbFuGD8sIHBxto0el3l944NJJQaDr1j2cKOSNSHEDoIS5uyFaAU0oyCIPToSELF1DAGfq7FvPLDt/GD0YDAXand2UtUW3uQZ1ftNzG42fYOhQlmw9yVwP03f1yfiFyd5db45ZdvuOhwrWICyJDIKT7a6iT55tMoJPP2ewt63u9Bzdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHNNDOtBOK1TUwW4b/HayiVCWNWSBRcjKGYZGbCBir0=;
 b=lRw+fvVt6Ky5ilmnd1G5KcVA2VomfUV6i+GtMqruataisLQv1pFkP509hl7wW1/BgdqEy9rLHRyqjJK2JgqMbKQGinLFOM8CTerr29yIXJsL8deKMAm1911bc+BNR5YlrObRR07UBrGzQly324lNgR++2TKmY1h9LOInIB8LGfk9mjd07dEyZBt8l04Pfett4JiALpfTsn8T8X1+CUxufb8W29gZkinIXCCC9dZzYPIPeYjwpvBrEKL5qcNH9/29zSyaTiLKdgNbuKC2GCU3U66g2bBI8tVYtrjWsWAqPVdDF8Sban8ereMW05M8GcWLnLMDSgmvh8jwlJGnQqmoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHNNDOtBOK1TUwW4b/HayiVCWNWSBRcjKGYZGbCBir0=;
 b=U0Lk/8ep6PvU8D0X+6XmfprL7gpLi+YuJlLw2l9geHoT1R/oJwYT981Av01dRKw4hwwZccshcKd/irA7NyeHRS2PYy/R+IRXX7K+109oR8sfOAcLZBbWiLyq/MKTa6e3izJEa3uIm4zIoatTyk2hIHLd04vDTSP+6J1D+GGl77o=
Received: from MWHPR22CA0064.namprd22.prod.outlook.com (2603:10b6:300:12a::26)
 by SN6PR12MB2799.namprd12.prod.outlook.com (2603:10b6:805:77::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 15:27:15 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::23) by MWHPR22CA0064.outlook.office365.com
 (2603:10b6:300:12a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Fri, 11 Mar 2022 15:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 15:27:14 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 09:27:11 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] amd/display: set backlight only if required
Date: Fri, 11 Mar 2022 20:56:51 +0530
Message-ID: <20220311152651.101210-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2495fa-a93b-4dd6-4c23-08da03739ec6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2799:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2799713F545FB0DA1E240ABAF20C9@SN6PR12MB2799.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmhXJXh7cE5YXLDEcDPZEpRPs4sI6D2VXlhZZP50nqsVnxw7jDw5F22x1A+lAwBkmDgTYMzFIwoIvMVL1uKJR/G6uF/zJ/ylzr77SgmOgI9Q/OXtl0GIrjdA1q3xytnNx3Zwliv2sTOWCHBeJNrCd4M/ZnVcr6M2s6Y/UTsB0+BeFqYCxWjjBVE55+HgM7Tt9fl31kv1lYoOk3E0vNhPa+ED+PdyGvmYT6aMejvXERdJ6oqEph6+/LWY4ElFxQcFUq3Rae4pREGc89hMOyYXjKRoyA8CRvqU/r2A8lJ0ATz3fXcfo1K+e2pmuvuoHpZ2VIbwYHwB67qouEri6DNcR80jUFgQCd13fKWLCy/e7ZrGpyObdybGCo9BmymcYt8Dy1yBmZVxG99D6JsfmgnqJhtXSyrv34NPGOYl2mwqfkpeYNsnkoQVYvrqdSS5efvohUqmvGnNmxgJ7N8W5tQsA4a4nXAGssi9sdLmOEG5e1ByY9FQXqafdifYn65t9kDZkdgfUBnujGMIXYKoL5w+YaDLwrW+kvNESniuwOhUF4LtNSEaQplPMZzuhQRDyla8RNGnzkxqVU5zmzKMnedeEdFV5rfpl9exDxYKZVfBYmVvvxjfPdZM7OQPXjSzhXVBtwE8se1+yKUAihW9VPNJNseZmLQ0F01PrUB/Maf/vsIl4OyFn0iVZvOJkE2enHVgFsseRJqWOJ4LAQUa6+1ydw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(1076003)(2906002)(7696005)(6636002)(54906003)(110136005)(5660300002)(82310400004)(8936002)(356005)(316002)(81166007)(508600001)(186003)(16526019)(26005)(426003)(336012)(47076005)(83380400001)(36756003)(36860700001)(86362001)(8676002)(70206006)(70586007)(4326008)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 15:27:14.4389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2495fa-a93b-4dd6-4c23-08da03739ec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
comparing pwm bl values (coverted) with user brightness(converted)
levels in commit_tail leads to continuous setting of backlight via dmub
as they don't to match.
This leads overdrive in queuing of commands to DMCU that sometimes lead
to depending on load on DMCU fw:

"[drm:dc_dmub_srv_wait_idle] *ERROR* Error waiting for DMUB idle: status=3"

Here status 3 => DMUB_STATUS_QUEUE_FULL

[How]
Store last successfully set backlight value and compare with it instead
of pwm reads which is not what we should compare with.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df0980ff9a63..2b8337e47861 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3972,7 +3972,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 				 max - min);
 }
 
-static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					 int bl_idx,
 					 u32 user_brightness)
 {
@@ -4003,7 +4003,8 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
 	}
 
-	return rc ? 0 : 1;
+	if (rc)
+		dm->actual_brightness[bl_idx] = user_brightness;
 }
 
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
@@ -9944,7 +9945,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* restore the backlight level */
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (dm->backlight_dev[i] &&
-		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
+		    (dm->actual_brightness[i] != dm->brightness[i]))
 			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 372f9adf091a..321279bc877b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -540,6 +540,12 @@ struct amdgpu_display_manager {
 	 * cached backlight values.
 	 */
 	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
+	/**
+	 * @actual_brightness:
+	 *
+	 * last successfully applied backlight values.
+	 */
+	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
 };
 
 enum dsc_clock_force_state {
-- 
2.17.1

