Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CA1CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2E610E771;
	Wed, 24 Sep 2025 16:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1BUwsRt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF3410E771
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsXdbSNtV5LT1v1oT1SNum+lLuE/akZU7VPvJPGWbdYEdjhy5xkCEXkvLR0e/bhGHTwyB5fRYO2Tvm2Yw6lfX7DaHfPaNV3KbNIkEeJnCeYpGLPY51aXxagUUQNH3UdesDQRRgg8+88JfyBCWlUAO0SmLh9uexrDPxWrH99/qWkrESMsUcJb6Yv9By34w0cqzDWPc981D9cmiQFta/dqtmSmbBEM6ZXg9GTOZVom6btCxqrrttAar1gYLumk3rKaPKbvLWOmpbEYmhGOwndi9uZ9/479EXw6JOj4aooBbyun08iWLwsEmk6mLygcg7vuDyG6RGKT0e/XR2jBb5ZFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uDWLcWfgiKJivJqSZSmnf+sosLg2iHJvf3bO68fhEM=;
 b=yq7hJLGJmEtgmccJCFNJkCh+0dKHDq8unXmAf9UU8TmUZJUMC/XuB0ggryAIvKIAqVBK0tzZpVXAaUB6e7YtBV/m4hv5LDbJbtC6gh787lb/RHjibAIlnlVHgg8GToh9r6v3uQK4z8nlvEDkA0eI7QtLFbbjAGb1fA+5MCM4JizsGjAaSS+FeVmFzJJyb5Jc0LzYksM6kkyUPy9Keb0dApwODySvTl2P4MfowCPD7OpulWgrpXYNhY3LXBWJcC9Fk2G8AU/KrDkvIs0a6LASpR//FmiAdZy94aTphZ2GcAXJINcdzC3i/Cs7X3kFEQSqd0exGwreViHGeLSehSFTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uDWLcWfgiKJivJqSZSmnf+sosLg2iHJvf3bO68fhEM=;
 b=g1BUwsRtNHMV4JHnxAyRvTeR3bB2WTtBRpVgeOxWK2JVaUwqiwYeYk0niLZU0gQxnPk2uy82tfbIbQN+OP1evX2zaYypetDk983gXIUVWPbyUt9Q65cgBeEzYvCjy4/FhSUa+DLKhAnxGDIccZmNlMSzDW3TTyeBbDSSRZwF7tg=
Received: from CYZPR11CA0017.namprd11.prod.outlook.com (2603:10b6:930:8d::11)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 16:16:49 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::9) by CYZPR11CA0017.outlook.office365.com
 (2603:10b6:930:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 16:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 16:16:49 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:44 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd: Add name to modes from
 amdgpu_connector_add_common_modes()
Date: Wed, 24 Sep 2025 11:16:24 -0500
Message-ID: <20250924161624.1975819-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924161624.1975819-1-mario.limonciello@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 85933cb1-79ce-4ecc-31a4-08ddfb85c44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2Nha0tjYnFhOHRTL0VGY3QxeEpJNlErSWFJNUE2bFVub1RsSHIwdm5PMDVi?=
 =?utf-8?B?YUpaRkgrZHFzK3M2UHVhTGh1cjFkSTR3QTdVeGMvbFFFRE12MFU5MkNUT2FC?=
 =?utf-8?B?SGx4eFREVktFdHpuem56cDBuMFdkY1NKTFVkUytCTzJLKzFPMit3T3ZuSHF5?=
 =?utf-8?B?UWFCdkxlcnVqU2IwSWxHN05aa29xaWpvQy9NUE1BQUorWjNPWlhST3F3U3ov?=
 =?utf-8?B?ZjA5RGNGaFRiM2RIOGFVdzZVN0VnVW5ZcHJjUXBJbkt1RE1WeENFQkU5My9H?=
 =?utf-8?B?cU1OWExFaDZTTVkxVnBRWFQvVys4S3dQcC93RTgxRWNsM0xKcXBJWC9tSFFm?=
 =?utf-8?B?WTZFdll3eFpsUjFiNUIwQWwxdDg3eHRFOTZiM3RocjN0TU82TU5DSHR4SWht?=
 =?utf-8?B?U3k5cUVZbC9OT3RDNERpd3NDaE44VDNjN0JaK0ZYemJCSkxwcjcwcm5ZV0JW?=
 =?utf-8?B?dVV1cGt4QnQvaTl0RnpsL2tiSUJiSll4Y25NbXg2Z1dSVDNYN3ZnY2h1aSt5?=
 =?utf-8?B?d0R5dWFaZ2pvY2Q2dTdDa08xZlNtbkJYNFJ5aGpqaitrR0NKcmlqQjg2L0ZJ?=
 =?utf-8?B?azFEV1dSSXhpakk5VWJuK0VseXEwRTVxamJWVmZGRFQ2NkVldHFnYXBPS21u?=
 =?utf-8?B?UjUvOUJFMEZRSHAxUnNPMTJWdzBuajJvOHlIVm4zMnBlckV0dkNYMDFIRTBy?=
 =?utf-8?B?RFIzZ0JLQy95U3pHK0diWjZYRGpFRVU2bzN2MUdWcCtFREhQZE45K05DUjdW?=
 =?utf-8?B?ckN4TFlCZHJqQXIzRld2UmlvdGhsNFlYRHJUbG1NTmVuQXMvMXBGaUZtejIv?=
 =?utf-8?B?ZytIbjA1OFoyNzVrRnA1VzFQbkFFL0t0Wmk0ekNDb2VzcjU1WFgySHhkMWpi?=
 =?utf-8?B?QzNpb0JlMlBoV0Z3U3lzR0tSQTdFaXg5emFpS2JHZVZOSHdlRWRzbjNkK0dM?=
 =?utf-8?B?Y201bG83VUY5M2pXVzllT2duQWR3TEpqM1d5WnkrZHVEN2ZHV3hpaGIyYzQ4?=
 =?utf-8?B?akxwZFVPeE9DdnBNNzRwbXU1V2xaSzdtMG9YTDBjb3czNGpoV1hDdVRZWDlw?=
 =?utf-8?B?SHFyY1I1YUZHblFLL2tqRmhsZUZaZ0ZmSWpjdWlDMnR3cCtVZTdwa2l2VjdD?=
 =?utf-8?B?NUtSc3RjQWRWS2pXWnFVVWsyTlZhSlJHNG4rdFM3OGR5Ly9WVlFiOVNzZERP?=
 =?utf-8?B?UjRKRXpEdHRIdTRjODBpUngyNTgrOE90bXNUK2wwN0YyRWJIK3JhZXhNaFZL?=
 =?utf-8?B?WDArVVF0RTNDUjJialIwMWZiVlljb2ZXbkhxSFR1VFhHeEJEUHdpYlljdmdG?=
 =?utf-8?B?QTI0eGVwR3hpa2IzdTFsZmV6c2JPREVlVlkyUWY3b2phOW9pU0Z5UnNMaEdR?=
 =?utf-8?B?eDhTL2d5RlM4S3Y0MkVHYWs5MXZGOUFBU2NtQ25YUHJsdDNTajZlV1hoSnhV?=
 =?utf-8?B?dVJjZFRUL3NQOFZJeFV2dHhJckpoWng1azhMNEhZdW5Gakp1bjU1bkJLQUpV?=
 =?utf-8?B?eEQ1S1laZ3lqQ0RNN1A0bHdZbWpTbmlERDR3dWRaWWhDWFR4YmJCbFBTT0xS?=
 =?utf-8?B?N3h3bTZBSkN0UlNFSzlrTXh4OG8xRW10N05IN2dtOGJIdHhKaFZwbHpybDdr?=
 =?utf-8?B?UVFlTkY1ZjdJMXYvcUt5NGhRcDlkVnpHcGFvWjBnc2N4OVJMSzJkM2RYM3d0?=
 =?utf-8?B?dGFTQXp2dzJ4R0NDZ3N1QTN6NWN0OUNiNEhqNzhNMkVoZEFtUFRvTUtPY3BO?=
 =?utf-8?B?QXQ0ZjJNNUg4U3pxdStTdXpMVVlpcDN4NldWVGtNY3JCSjFIa0twNEN4K0J6?=
 =?utf-8?B?eEtrSXdwcUQ4WXNnRDJQallHTFdMY3RQVml6NGF1WlVqcnVtSkl5dnc3L1Bn?=
 =?utf-8?B?eWh5U3plS0lvVjZLWkxka0VaTVVvMXdWSkRzTlVnVnhkRkVBbEZpZHVzUlVy?=
 =?utf-8?B?a3FaeG1nQ3pzVEFUbGExamQ0Q3VLRjdnbDQ1RFhDaDZlMUs0VTdJWkUyQTBm?=
 =?utf-8?B?eGw5ak83bDUvcVRlUEVtZjhMUDg4ekxKakQ3cHNweHRtVzVXZENqamthdmoz?=
 =?utf-8?Q?HbStu1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:49.8158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85933cb1-79ce-4ecc-31a4-08ddfb85c44c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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

[Why]
When DC adds common modes it adds modes with a string to match what
they are. Non-DC doesn't. This can be inconsistent when turning on/off
DC support.

[How]
Add a name member to common_modes[] and copy it into the drm display
mode.

Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 8c085ed703dd..120d8017b6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -399,21 +399,22 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 	struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
 	int i;
 	int n;
-	static const struct mode_size {
+	struct mode_size {
+		char name[DRM_DISPLAY_MODE_LEN];
 		int w;
 		int h;
 	} common_modes[] = {
-		{ 640,  480},
-		{ 800,  600},
-		{1024,  768},
-		{1280,  720},
-		{1280,  800},
-		{1280, 1024},
-		{1440,  900},
-		{1680, 1050},
-		{1600, 1200},
-		{1920, 1080},
-		{1920, 1200}
+		{  "640x480",  640,  480},
+		{  "800x600",  800,  600},
+		{ "1024x768", 1024,  768},
+		{ "1280x720", 1280,  720},
+		{ "1280x800", 1280,  800},
+		{"1280x1024", 1280, 1024},
+		{ "1440x900", 1440,  900},
+		{"1680x1050", 1680, 1050},
+		{"1600x1200", 1600, 1200},
+		{"1920x1080", 1920, 1080},
+		{"1920x1200", 1920, 1200}
 	};
 
 	n = ARRAY_SIZE(common_modes);
@@ -435,6 +436,7 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		if (!mode)
 			return;
+		strscpy(mode->name, common_modes[i].name, DRM_DISPLAY_MODE_LEN);
 
 		drm_mode_probed_add(connector, mode);
 	}
-- 
2.51.0

