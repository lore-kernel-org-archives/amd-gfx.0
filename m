Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B00FCA0FF2
	for <amd-gfx@archiver.kernel.org>; Sun, 31 Aug 2025 10:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE3310E2CE;
	Sun, 31 Aug 2025 10:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tFFb240f";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525AD10E2CE
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Aug 2025 10:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnQNFOJfoj9+b0dXJUttQ86AxdMa/0YE0VsqATq0+gN4jFf2Dlg+n6mXWEaaDUgPaigARpcJcVbMde/VecB7yG0jnkXRo/1x9mjORxcWdS74dQ3sIo83QFnOhmzdrw0NKxh97/YeP1l86aXcFeMJdV6E4xTKc7eV48/hptyj9e9i47CR//oix4YiOQFW0rABsapaGd6nDb/MqX0+Wf3xiVp9PHj1Fw4sMUV9EQgbugRenZPoEoZq1bMsOS0sMlxWAP+rUgZy9XurTFd8uApAiLCy8J2tm/A/EvY98YKQ6P68vRA4JMuMZI5jYsNTyKxyT4hbaNBq+6zugA8cbnfhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfbJ1qrEL1zcZxJ2OnG8+lzIi4twXszEo92VUi/H+U0=;
 b=XzGgyADrx7RyzKCySDY3AYbT7Jodd/Sz2W0skGdz2B677GirYMavl4QvWbtRJZ+fXdurJVWT/WR33Fhdp7kd63enu7NpaxmApr/Zik4CxMqIdLPLwyU3TZ7yJoHSnxvGXTY6IVXpt6qGtrFgkrtQsmFp/8wofg1wr92hGl07lko4W10keJ7zuLHNXQE0RMsGr0oXAJ4UFdFux/0tTn9AFYm9ZRH5ooVUA4/3dMwoMn3KIESyOWnIBUydM4bL09bzeZ2qf8M0gaNjFddtrd/R8PQK9NG3Jifcoa8xAbR+Z4Kfb1NbArXhOYiME8vhUDAWEFFB5mkbUHXeeNHP0YLbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfbJ1qrEL1zcZxJ2OnG8+lzIi4twXszEo92VUi/H+U0=;
 b=tFFb240fmHozdPgC2rdSreHkfdMPZUcKRmiCJwtsINITFsbCwk/XknvcValOz41ptNmiY82L7kaIZzvgcRKH/m3KnbdWQrbn9fX/5FE0x++grGPNU++6dcM+FxfSXLVXmf4lNkOoGuzjFRJmrbPsp9eCRp9K83A2XG2m608aY5g=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 10:03:01 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::25) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.25 via Frontend Transport; Sun,
 31 Aug 2025 10:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 10:03:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 31 Aug
 2025 05:03:00 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Sun, 31 Aug 2025 03:02:58 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix function header names in amdgpu_connectors.c
Date: Sun, 31 Aug 2025 15:32:45 +0530
Message-ID: <20250831100245.400199-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: bb49b3da-a53e-4d9d-d5d7-08dde8759176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Si9WeVJuYkphMDFJdW1KRlVhbzZMaGl4QkNqUWYwd3Y2NTZoQ3pJVGlmc2xZ?=
 =?utf-8?B?T0M0RVh0bjgxTVp3d29PbzczTUd6dkNycDlMbWhnMXQ1VDVTSzRkSVJXTUps?=
 =?utf-8?B?bDVQWHRONG9zTzBOS2xrOWFLYVk2ZGtpdVZDWjlNdVJuNDFOdmxKZm5Ob0VH?=
 =?utf-8?B?L0M4Wk83MGdZMHovek01dnRGRWlsSENvc0RxNVZLaFo5UndQT3YvUC9TR1pv?=
 =?utf-8?B?eTJUMld3S0U2RlZXWWllV2I5SVJmVjRWb3NqNGdhWHR3bGhPY01HVGRXeTJU?=
 =?utf-8?B?Y2FkMWhUbkZDNUV0c2lVVmM0QzZzanVRcFZydVFZVW9YWHZZKzlxSGQrenQw?=
 =?utf-8?B?cGMzWEZOSndFTjM1cEdpekZYeTgyY3Jaakc3YjFvcysxTFV6cU5oY0t2R09a?=
 =?utf-8?B?VDVYeEQvd0Jzd0pEYVJYSzNxaUhrZUtGamxlV1VNU3ZLL29Td1hYbzFZMktX?=
 =?utf-8?B?M0p1L1FOMkJDM1FjTTJtSGlVVnhtc2dxK2JHancrRXViQXlCTW5WMnpROVNs?=
 =?utf-8?B?emcyUnJOcXZTS2t2QVliTjFOVnVlUVFSVkwvOTMvdVdtWURtRllNWHg0cWh5?=
 =?utf-8?B?SXd2RWg1a1RYcGxHYWM5T0JiSFBNOGpKK0ltRmFEZGRVdnlNWVM3T2RKMnQ3?=
 =?utf-8?B?V0dLcjBEazl5RHgzU3hsSS9TZnBITFUrUEUrcnl0TGNTUVR6YkUxaytaUGlo?=
 =?utf-8?B?VGYyd3pqY3hNOHo5cVJvaGY4a3prL3YxM0oxZmpyb1lNT3EwdlFwRnVKVmM3?=
 =?utf-8?B?c25zcXRvRHFETVRqNmpqdVlIY1RsdS9aWEpoUU9BK2JEWis3dWxvZWQ0ZHBY?=
 =?utf-8?B?Z1RVc3lETE5pcTNET2M0SW8zTGlScWUrNGRMMDF2YTZuKzg0Y1h4QnZuc3dG?=
 =?utf-8?B?WGdNN0JkM2RETnZXNTJFY1pabHRtN3hHZkRudnRrUUdGV1dCNy90WW85UEtm?=
 =?utf-8?B?eE9vbXVNRkgyQ091T2Rna2dUME9IYVJSRGt2S3BKSVdRdnZFellSbHBieTE3?=
 =?utf-8?B?MlZZZmhrSWgvdDY1bmJQMGNwNjdmZ21aTmFKaVd5T1JmbTc0QWpPZ1NLZDYv?=
 =?utf-8?B?cC9peGJmSHRkNmRJNGMyQmRuYmVYVWZXcXIrY01uKzhYS0ZHaWVDcllzb3Mr?=
 =?utf-8?B?ZmEwazRaWW9uM0wzV0hhbksrR25iZy82MnNsd2wzNWJmMU40QkJxc0ZMRjIw?=
 =?utf-8?B?OHBLOFlOb2V6cWdJNk05UzJNSGZCQ2lzRllFQ1JFVmFjR3l0Tld5YkRHZHZE?=
 =?utf-8?B?SHpiUDlvYS9BZnFVNXd2ZXNNbm85Z2w4bU00VHgrVXBhZ1BaNzBZQ0ZJZE4v?=
 =?utf-8?B?VkFsVDhxMndVOVNYWXc0OThWN2tlN3FKeUFiaGNraWEwYnFvd2kvUFBBSWVt?=
 =?utf-8?B?ZFJGNDZkL2t0RXR4Q25WZm52YzQrWUJOZWxzUUVyMlhqUTJqbS9XZ0ZLNDZx?=
 =?utf-8?B?dExNRjlKeDN6djg1VUZCRFgwQkFFNUQ2VHR4aGdwZVlIaitXK1VoMUdGWTRu?=
 =?utf-8?B?R1AxKzdGQlJxYlF3bnJWYy9ENkZWUlYwUUk2dHJpelB3TUxQVExlNkw0eEFt?=
 =?utf-8?B?Z0ZOS00vTlNWVkNvdFJFTlZSN3NmWnNRenI3SFB5ajlRWTM4bnRycFlYNnN5?=
 =?utf-8?B?cVVDU1d2a3Q3UWtMazhJbGx3WElPbWU0cmdiWEtOaUhBNVhOc3hZWDNkb1B6?=
 =?utf-8?B?aENFRW1BNkxCYXZibEpSV3ZUYnR3c21HcFhPSlBpWWZkYXpDTUNGaUlMYUNw?=
 =?utf-8?B?bWQxZVI3eWpLZkk3R21NeWpkL2ZDRmplU3RzSVZ5UytYMzFUYVNjUlRqR3dG?=
 =?utf-8?B?TllLTm1Ra3RLNStIaHdDMTVhbkFGZU9YRjNCcTVBcU1jTzF5SnJtOFBWUlpV?=
 =?utf-8?B?d1B3cWN6M25HMVBuak9OcE40WlArbFlWN0hUTnoxRjJvZ1c3MmxaOGhydmlI?=
 =?utf-8?B?MG5sQU0yYVR6SG51QzFlVU50Y1lqa2NtYlg3YTI0OFFTWHRTTDN3dWRsTDRP?=
 =?utf-8?B?enBNR1FxaFAxbUpiSW5sSlVQR1N6eDVuRUZ6aGNTL0RQVkladVJtbDl6L0Ny?=
 =?utf-8?Q?TQuT6V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 10:03:00.4427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb49b3da-a53e-4d9d-d5d7-08dde8759176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

Align the function headers for `amdgpu_max_hdmi_pixel_clock` and
`amdgpu_connector_dvi_mode_valid` with the function implementations so
they match the expected kdoc style.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1199: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1212: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Validates the given display mode on DVI and HDMI connectors.

Fixes: b80998750589 ("drm/amdgpu: Respect max pixel clock for HDMI and DVI-D (v2)")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index a381de8648e5..bf38fc69c1cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1196,7 +1196,10 @@ static void amdgpu_connector_dvi_force(struct drm_connector *connector)
 }
 
 /**
- * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
+ * amdgpu_max_hdmi_pixel_clock - Return max supported HDMI (TMDS) pixel clock
+ * @adev: pointer to amdgpu_device
+ *
+ * Return: maximum supported HDMI (TMDS) pixel clock in KHz.
  */
 static int amdgpu_max_hdmi_pixel_clock(const struct amdgpu_device *adev)
 {
@@ -1209,8 +1212,14 @@ static int amdgpu_max_hdmi_pixel_clock(const struct amdgpu_device *adev)
 }
 
 /**
- * Validates the given display mode on DVI and HDMI connectors,
- * including analog signals on DVI-I.
+ * amdgpu_connector_dvi_mode_valid - Validate a mode on DVI/HDMI connectors
+ * @connector: DRM connector to validate the mode on
+ * @mode: display mode to validate
+ *
+ * Validate the given display mode on DVI and HDMI connectors, including
+ * analog signals on DVI-I.
+ *
+ * Return: drm_mode_status indicating whether the mode is valid.
  */
 static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
 					    const struct drm_display_mode *mode)
-- 
2.34.1

