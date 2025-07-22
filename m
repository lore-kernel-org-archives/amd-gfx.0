Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1426C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA6610E737;
	Tue, 22 Jul 2025 22:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrXVp2nc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A2510E737
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxS69P3gsFFEqtKXF1Jz1dhQhaTifmy5muw+Gc2Tz0hDGm9C4V0JcLUChaAUjN502egPXV/WVc8sVyqKJFHSvpr7XsCJt6tc1b2XiPUJUsbfR4ryi/c6PuaevCwmGM0JXmhH2U/2oDNQLWp4Zvb4Do2IxELRgqap5CXNHmfse/Up2bc7DoJmKM1kWP+/w1HCmI9E9Io3hVXENPMk9vqjwMRXXBG352m0mE7GeSfMrBBZO/6mVBOcig+VN1V1PuY9sOBl8dqVHzJWyfkKNtORaS3Ko4loyOym4APmKvXixSjbnirLL96iJr8IDrmR77Bpm33mJvlyTSXgAY+lCVRjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Gang9CSgQJNSyu+jVlCEGh7Nl5CEK4KWQJnlsOI4U=;
 b=m99ed2KD/XBDVW/plFAMNI9/yf7tQHMRDNL0J11md+pkvFQr3jm8R5enqL0S3hyKkVFfpsMkbNNIRBgeKjvKlKnODgfDAPkPqgDTxruMkBriNSIKcEbmAKULwsfQFyrIrGbCbqSorp3s+4Ld9DwC8XALlF5mwlJQ4zjA2cWNoAXy/Bg7GmE3fDCh+O31D6ppQ5cNAVenu79ObYNOTj8qxbAYa8M6X8IHLI5dPzwvFalkwCv1yLetOB5Ug40383IyxnGdmpfA5lLXnwoMtIGOiiiJ7VTO1P+11cVn0ZEBMg3oZTPiAWAc7WlwErBv2VWa2mgi0mMU40KZ1hTrRW+0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Gang9CSgQJNSyu+jVlCEGh7Nl5CEK4KWQJnlsOI4U=;
 b=zrXVp2ncjqIKbdEi1fdQ5H5s2XA8iXQMA8AxrR0o3C0eAb6W8/CroVpxxE2ZVkma78Km7sSD0Mp1RIdvsNx6isHnuKLh9iH4+iQFP/i7AoEBxj7fZNcxVjwG0xcoQlET6jyLQ7I8EQ+wnLWPVd+Wqbwgc2QTFWw2+srzDpEHDBw=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:46:12 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::40) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 22:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:46:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:09 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:46:09 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 22/25] drm/amd/display: Fix dmub_cmd header alignment
Date: Tue, 22 Jul 2025 18:44:31 -0400
Message-ID: <20250722224514.2655899-22-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 81209f7a-9e08-4e56-92b3-08ddc9718f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4euGUF7bwCQxDLke9+rlS5Vcb1ihGSD+c6yb5TJm2WTsVgG3A+/cwVZtQhXR?=
 =?us-ascii?Q?jmyQSFqxYBcaGNGDOW9pvBsK0FhaCFScoowRnWvxlFVFDzfLune3PKpURexy?=
 =?us-ascii?Q?12aBaBOm5CLAaw/HbSXiEgfv4v02tzJc0S8+OKmctP/7D3QhZO4HaVuY1wR6?=
 =?us-ascii?Q?l2/EjAuTqpFd6QwH+biHfgXGuIdAe096pShCyYdNHjdSGpN6YbZbc3QElbwz?=
 =?us-ascii?Q?F//7UBoD7q5c88zI9X9Z9TNwdeLuJ0u+JsUOmkW/Sq5eHoa9i6OO4oJ0odkF?=
 =?us-ascii?Q?hmqHIHM56feLHBwUaDEh2U9fuolEewfR95ahsmmnc9wM2tpRtc3Jl9vFnHhs?=
 =?us-ascii?Q?sV1ZeZxtUHOmN/NQUuGm+82wb9UqCFUXvwwwAKj5Q7EyWT30I0iA2t+SNNsP?=
 =?us-ascii?Q?pHv9HuZ0/SIW4T6icQulQR2j1d+j9wM9p3zO2awHv3F3wd6JIgUbMHcQ0eJs?=
 =?us-ascii?Q?qG2rbOvkKUYk5XrxWAK7bkQPI4ECT/bIWzG785yQhy0otjmRs6BzgNxtYkv1?=
 =?us-ascii?Q?99n/dwyaWTb0nFn+pTEPRQCNBtPcfYULlWViofiHIg2ygcLu9L3wY8mOvXFg?=
 =?us-ascii?Q?D0UzSNaJ2vMk/hkh7fuEApJs5V7uoGm/9zzLs6/7vLXxzVKu9w9uqSz5RHWQ?=
 =?us-ascii?Q?gc7TdJrKvR0KqwUPkwXx4+SFEOSy98zX/F2CmpUtYGdxVKSRaIihr7aGMxhQ?=
 =?us-ascii?Q?jz1ARKUAWAiUCzA5d+AMGUmGt9K1sBWEacwRF3CW3y20b2vqrusSaDfyJTly?=
 =?us-ascii?Q?UkNbOQYBXImpXylrTBftdmXAzJDrJlbza0V7unEtzZM9rTxTTnKXwew1nlTC?=
 =?us-ascii?Q?+l7SlGNuBY9d+qf+6/JIxjCwpXGoMgs0fUoYeIZxIyURPGBFxrlj0QfevesC?=
 =?us-ascii?Q?LfOkHXkffAdyraUYn/+Nw4XkVc1cU3ZCoxCKQ4+MPd5bz1/HOX0Ua/AuWxWP?=
 =?us-ascii?Q?D7OC2N5N7xSMkyARMhKG/Qgjhj4NrdX4/t6wZ1wjdgjEmd6mOgwLUoNoA3PP?=
 =?us-ascii?Q?mXg9AnvtMfZCddDXRTd+urysoemD8dB3gs/fyCcs6JkKE7SArF7sBkhmoj+o?=
 =?us-ascii?Q?s74KWAHn1dTeXoO+iTztKlon5nHQ74afhqEecdk01WaP3pwvvaO5qHbTr69M?=
 =?us-ascii?Q?N0riRI8sgoLeykllcX9QcbD7sBHNRF0un8ZyChLd5vXUR4XFu+lWI4BNxH0I?=
 =?us-ascii?Q?FP5dE4hXC+6t3yvI1OshuYqpc4uUg0ubEud5VjvmD6TEbJ2/xBsJBXr1+oWx?=
 =?us-ascii?Q?aIJGQqTp1Z+lBh6UpyHbDLYQf99G1Ak7sT/1S++zui143OBDCXcc3fb9IjTk?=
 =?us-ascii?Q?u3YfZGdjfzDFH61cIWg4VvTLUjL6FHPR4SZBHdRGrvgCU2VwuKa2NouYYuGC?=
 =?us-ascii?Q?M4/mMgakW8u1mRM8oRamrbm7xhhgRRwulENmnGwntlajJJX2EU29xAB8c83C?=
 =?us-ascii?Q?vcUQ5DxKrm+gx51wCrInl5+LkULssRGPlF2JroE2PM6PVZRPid5M1mphfN5x?=
 =?us-ascii?Q?pJY3+6gMzEj7/gW9FtKbbsRjPwOsXp+0s7dy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:46:12.3132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81209f7a-9e08-4e56-92b3-08ddc9718f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Header misalignment in struct dmub_cmd_replay_copy_settings_data and
struct dmub_alpm_auxless_data causes incorrect data read between driver
and dmub.
Fix the misalignment and ensure that everything is aligned to 4-byte
boundaries.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a89bf08ffd37..dcae768c2cf4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4048,6 +4048,10 @@ struct dmub_alpm_auxless_data {
 	uint16_t lfps_t1_t2_override_us;
 	short lfps_t1_t2_offset_us;
 	uint8_t lttpr_count;
+	/*
+	 * Padding to align structure to 4 byte boundary.
+	 */
+	uint8_t pad[1];
 };
 
 /**
@@ -4080,14 +4084,6 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * DIG BE HW instance.
 	 */
 	uint8_t digbe_inst;
-	/**
-	 * @hpo_stream_enc_inst: HPO stream encoder instance
-	 */
-	uint8_t hpo_stream_enc_inst;
-	/**
-	 * @hpo_link_enc_inst: HPO link encoder instance
-	 */
-	uint8_t hpo_link_enc_inst;
 	/**
 	 * AUX HW instance.
 	 */
@@ -4132,6 +4128,14 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * Use for AUX-less ALPM LFPS wake operation
 	 */
 	struct dmub_alpm_auxless_data auxless_alpm_data;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
 	/**
 	 * @pad: Align structure to 4 byte boundary.
 	 */
-- 
2.43.0

