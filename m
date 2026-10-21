Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5E606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qqeCaXxp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D7110F967;
	Wed, 21 Oct 2026 06:28:06 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE71D10F967
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUV++h0meiTuChyhqSH53gBQJ6VRQvgjcW1d9JrWctCacE5A8PTh7J5hOqNen/Q240rVCb5CFLXtTMvf/xHQSZeKyQiTrnJq8QlthZtvPPRiNGwMgGFcc9Lj1LRODGQHJsAILHH6Niixub2j/vqWrwmJ9dLimYgf4TANybEv/oClHg0bQvX206GELiFO/ChvGIEs+aFzpFko0clKSB5dxdQqFzFNsXWGSfLo7d+3jEyKjlrnN8XrFV3zKPYL8IPpfs33AXRwcsrG+ASEP0pc2vYeYYBp4rVyaK28BZadS+exzrbZfCKZjA96gEsqWDC19U0B4uCvxUnXRdMeP11L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2g05eup3HFxn68v7r76tv5QMqKSdBzTy46XnGbARQA=;
 b=ZyVfEC9AeGdq39hi/tpKXPjqU7QePE+KcAqMtNgWa7aCb6m8ax3Fshk9aH1wWoHeAD8ujDnT5Bg3uj31UgRfJVf2NVr6P6RjN+JesJAG/Ng38tSy7cNV4gsdMXPjRK5nnx2kyaUdagSUF8qbLRo3DwmW1+RM4XC0w5PsEjdsWC+GMEwb09/vEoH+Rmg7TDGQ0CT3JAX8cqVpYj7MhAVVzGcQ7SUaBczrvJAA/DdHiVcQ9jTuoumX9BDYhvu/rReItUIPkQxv49oUwszobZQmo4xVl3KrD9lhJAxkt1LQLer4iQFtcXLZK4Q3J80/Wov+sGUACzZOEs2DmkhZFxaqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2g05eup3HFxn68v7r76tv5QMqKSdBzTy46XnGbARQA=;
 b=qqeCaXxpws//AYG76eAG+ZhvWX6UdH8YJlF7u8xiNQb2QM0FcSmXlJkgoyBB3ezAmSHIc5eEvCceVtqDSS/UnuqLspvij5vJCFrn1ptSbhpvNtWRBtDC99WwKANW0rJY8Xjt+VG7P8XxaiBQ3XLFjOfW6cs+qkTsMwVb9nOhDgY=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:27:53 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::f) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:27:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:52 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:49 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 40/49] drm/amd/display: Fix KUnit connector leaks
Date: Wed, 21 Oct 2026 14:22:46 +0800
Message-ID: <20261021062519.674697-41-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dc76d8-03be-42d1-3aaa-08df2f3c7011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Wfd0u3W29ROlaUAYpZFgZQ5HAiY4pzEe0b60S/CZkMNbiLcsv6DSzuE1Wan9NS+VlX/yTku2bkX+Whrjg32EoZd0pTChCnnFY9gswb/Agb9X2scn4kDQJcsV06o9/1O57dPtor48Zr6DEYjN4/rKqDBbXZsZSluYNlSNXEPpIh3AFWLPv8fWGrUsAtdG7XzRtgpxjZpoYWbW7OFeJ1t9+savbEQoQOCDeB0rX4i941RVHPXRERdXMc1v/bxMY3eDP3RTrSxdRCPGQ9ceZ68pDw8BSuCYKOzdS67snAdMve9uS3Jp+jaS0c3jKa86lVQtIUnU/ltnvEtL0KWmJkHdqsRlKIS1mKo1sedt5NkH4xo/HTbZZk0TCDfInKFWw+V86wSBEGpohZwMiuCxhdCs2dB7+Psfc4mvUvbpcv1t4S8PzDepMJCEBiRmsLQlY51dS2CZf7gV3FdzLvfxVlUfK24mAkht7v/MTPYKob9nPs1jQF030o2IQcQQ2MFHUh7yFEf9EaXRU1WzEeIQBHczjEkIhogIatSQwsirGGBlXEBAxHKSr2hMyfH9PM4lh43Ul/AytL2C4YNbNBjRbciSy93vyHkBQozoseKL2HiPjcxfmfX0tbna96pEbrhqhlsl4NiVeDuFQAa7gc50c9p3G9KlEjzdYx2TiLOtjG8v4S6TXgVfiwvin9KkhJwJD/RGm5CJdm8qiNIO201mSt9SZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XgpWAshAOsadA3m9xipL6JVEOHI6fviGV0uPBF/eDSZJ94F6RT8AYp+Disd8YRBQQfRSVa3/M2UgJq49O5BiWXEGwfMkcwTNSRII22BeH4pqYGkGErsV8CfLewawySqHFvUKNri4poKYVCCGUP4njdmiCItK38d4bpmbfh+FB52S8HIQkjBbRyJkH3MyI/v/Nwy9uq6JcJj4eh57pkQP7iJ98dhhyGG3eIGDSD3Gpd7d+6xOlgCsnDQemQFGtcYXKjCGUBbDBiLQ5Ypw9D+jDPrW8IfdtClcr2NnPYVpoFTv832bgRn7Y01Y38piyIx1qI97v5MRGhrMH8ZtXBECQL8pYaWCPqwC+yAX+38dDyYjFK3HWXZqxfI3O7gpNq9p9/gU37JSXjHphnxwXtZy/9qDSQCY4l+yXyG1gIuE/m9X8sw0LPK84wJVtlz1WiGG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:53.3345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc76d8-03be-42d1-3aaa-08df2f3c7011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Two amdgpu_dm_update_connector_after_detect() tests leak memory the
function allocates when it adopts a new sink: connect_edid never
frees aconnector->drm_edid, and replace_no_edid never frees
aconnector->timing_requested.

[HOW]
Free drm_edid and timing_requested at the end of the two tests.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index d291ae40ca1d..242a18f9fcbb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7710,6 +7710,8 @@ static void dm_test_update_after_detect_connect_edid(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, sink);
 	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->timing_requested);
 
+	drm_edid_free(ctx->aconnector->drm_edid);
+	ctx->aconnector->drm_edid = NULL;
 	kfree(ctx->aconnector->timing_requested);
 	ctx->aconnector->timing_requested = NULL;
 }
@@ -7744,6 +7746,9 @@ static void dm_test_update_after_detect_replace_no_edid(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, new_sink);
 	KUNIT_EXPECT_EQ(test, (int)new_sink->sink_signal,
 			(int)SIGNAL_TYPE_HDMI_FRL);
+
+	kfree(ctx->aconnector->timing_requested);
+	ctx->aconnector->timing_requested = NULL;
 }
 
 /**
-- 
2.43.0

