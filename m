Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212FAC27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 14:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6889110E3CE;
	Mon, 10 Jun 2024 14:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OjTlCWH4";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1DA10E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 14:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO9y0YEOrv9zIyVLOJiGfcZpoRsRgqJS+G/bOm2bIGzZWK25EO6N6rbpwqu5FIBB/lH60Ih6sdeMoT1EWZqDSwzG7b7/kpD6sFtkL1QvClT3Tg7+aE8gUc53I/EZrhU8zykUR1exQYvIkE8rJKlxWT88e7QAqJISGyQMWLWRll2S6qXnFlVvSRdgove3j+EvSy6T/03ujIAHMp/GOv1xKu4CAo3u++Xxkxs25cZPU5wXeENmTrdn5CLZE75uIzlbo6pbd4Z3L2dVCwJSJ0Sm+gTr2ObLNTeWk2VjpSciB4LsH8YBBqO6jgR/r4CztxPheRhYSH9TN1y5Ti3j7Iif0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvp5523r6aI2q0PYjKP8cvAJ/7T7dmzDQ4rAzhnx4tA=;
 b=XPG5uKJ6ZK2cpXFCSouvd1PtnES0uswh+Zog8lGBK0Nw/kJ/rxvRfRCO+vaLI1xBIn7jBWDj2nSNZenUZzTJYJW/we1KJIbzuVmjsJrufPkkgDIeZ97nJWpXlCckeZ36S7uU/FGastiIKaoK7QecybYNqPT21qXhBTQ2qJ2n0u5VIfMYlxj5mc1VuRPyHUoDaD+wRZpbUlzTzOHacxZF6dknj89/SV0ia5ynPW6tvDnTg43yBGXLDKhu36QpqOO4huaK7G+ZIwMWuzzSkJCvb4HT7tE7Q1wUTyd5D7cmkG2Z/zMlOH8cwDrc85aBljqG/SH+pIGRWvtA8D4UTRtGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvp5523r6aI2q0PYjKP8cvAJ/7T7dmzDQ4rAzhnx4tA=;
 b=OjTlCWH4G1eEBdDYX6Ux7MZ7Q47B2GGeeC0zPjiDcRi4LgFzn5U5e+w7cJ2ojH8ChKA25NVH+0Yj8JbPG4dgkcF3SaI8FbVluRVUXKNd+CLSHbU/YeNypsMh15KFcVnTj3H1tTHmhrdmfmqFvIG4xpw04NwTGr01C06LwbwmsQI=
Received: from BY3PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:217::18)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 14:56:22 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::46) by BY3PR04CA0013.outlook.office365.com
 (2603:10b6:a03:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 14:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 14:56:22 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 09:56:21 -0500
From: <sunpeng.li@amd.com>
To: <mario.limonciello@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <alexdeucher@gmail.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Guard ACPI calls with CONFIG_ACPI
Date: Mon, 10 Jun 2024 10:55:59 -0400
Message-ID: <20240610145559.66546-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ab9df3-c7ac-485d-7f61-08dc895d7e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+33RTGUDIjR3PmvDB6lxy4tmEBgEstmqCP0a2RI7cOwBku/EZkOAHsd2N0W?=
 =?us-ascii?Q?cY727NoDtrrxWmuGtyMlDfSV0p/8Un7W/uWJB2MSXyEK5do6tOmQF0PMKP18?=
 =?us-ascii?Q?eEcB26AR0KQUG4L+cjvUiFAONCs5xc5x8WDwU1pPKBAWa8+HPkhfCMVnFeeo?=
 =?us-ascii?Q?Zwg+y6YdKoJra7WMlpz5IqrmH3LUrc23TOYL32DUztvA76fjJe1eVjKwJRwZ?=
 =?us-ascii?Q?GsFPahIiY3qydDenps43x7Y0gosRgzp+tsRcEB++Wn+L2PJAJHiTP98Q9DBr?=
 =?us-ascii?Q?IXxruAVAHllCQuJzhvgvuROUdoNqyXjG7kA8YHa90/zXZQFOo9O4zdJW9uRa?=
 =?us-ascii?Q?qZMSfnFXCuwxEa9JG4SwNKcgur2Go/XLypCq+0S075mDpXw5C6/pTGtDbuln?=
 =?us-ascii?Q?YxgdvkjiaG7rTRBe8d+m9TOCu1uLGZrkcbc6FIG6725sC6xO7ApiHATW7Mcw?=
 =?us-ascii?Q?Qy6B8t2F2fFVVz12mSywtPBHbYRdM2rNMRmdGsgFAi6ikgL7+jGFsYwX44rJ?=
 =?us-ascii?Q?zaXghDL6C0jAbp4zZ90aqEXejjRznni8XlEvOqA+epTho0W9LYGH5cMzUXB6?=
 =?us-ascii?Q?5dbv7xa4/T367nvyviUkcuR7CsNje/xQMVkhw4AwNZ1SpMKbBT/0pFSdtpFy?=
 =?us-ascii?Q?6DrUzybQhhtqdFHernW4XkTdgvSYs6pQRZu/9DY65mlMHec0l10dZxSpvvJf?=
 =?us-ascii?Q?vvInp0PKodPuqPjlVD8ifpNSuhDT70sD6Jz7zu1NHeUre1GLcKxzFUhxUxzd?=
 =?us-ascii?Q?Lx/CqbyDYdcr1N8zAUQxkAiAyt9LJsynxkjTH5nIygXYbexpAdUVutwZgLj+?=
 =?us-ascii?Q?hvJ5x1eVmJg49uVJVG1Cw+UuFNeJLSMtccr3XXlHKtTHRpptgyVD9NTM5lBR?=
 =?us-ascii?Q?SDiZcxVe5x9FQeodsfjn7UXtcdLlLAVCXBWeYm8dVXceMjme3r+IREAL+i5W?=
 =?us-ascii?Q?x8Q0bqWTPWW7eLD1IDlOGM8/R8RMcUeuh/Q1MzCE0FHhtzFaQGTEky0lRn1a?=
 =?us-ascii?Q?Ug05jQW8oqpWMaoOyVNz0BfTNOXLpBjUNL73crR5WzKAxBJi33ZXvOpVod3e?=
 =?us-ascii?Q?zfA0qnMWrEqJq/F22dwHM0j5v7lElhl/grDKYJhWhJERVLOOTVG0xf6ESQE4?=
 =?us-ascii?Q?OcYV/zZGQR8hM1tkOEN31KeCyfJNedMnYRG/cV/y3y/xBoWoCEJyMsFAmHRP?=
 =?us-ascii?Q?Lf6FI0ZAlQSzy3gbqx4KZSHtN1Rw11n8zJRj3hZd269CVxye9Dcjd8RxCVAT?=
 =?us-ascii?Q?KLbprzkOwp0jqgLeLog0h/0BknjfbWYOcYLTfA7J2xNrZ5a38RCsNgMl9Ns0?=
 =?us-ascii?Q?CM9QvTqQ5eL46IghnugceqW1tf2z2/YMw4/0gR5fW/v9XWEdnIFYs4JTFd23?=
 =?us-ascii?Q?J5KIch0eth9jVdXO8Nxn+lqAK+Lm2Lhvum19GKo/kkxcIOgLwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 14:56:22.6069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ab9df3-c7ac-485d-7f61-08dc895d7e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
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

From: Leo Li <sunpeng.li@amd.com>

To fix CONFIG_ACPI disabled build error.

Fixes: ec6f30c776ad ("drm/amd/display: Set default brightness according to ACPI")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a2c098f1b07c..6b3634db4c15 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4572,7 +4572,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *drm = aconnector->base.dev;
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
 	struct backlight_properties props = { 0 };
+#if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps = { 0 };
+#endif
 	char bl_name[16];
 
 	if (aconnector->bl_idx == -1)
@@ -4585,6 +4587,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
+#if defined(CONFIG_ACPI)
 	amdgpu_acpi_get_backlight_caps(&caps);
 	if (caps.caps_valid) {
 		if (power_supply_is_system_supplied() > 0)
@@ -4593,6 +4596,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 			props.brightness = caps.dc_level;
 	} else
 		props.brightness = AMDGPU_MAX_BL_LEVEL;
+#else
+	props.brightness = AMDGPU_MAX_BL_LEVEL;
+#endif
 
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
-- 
2.45.1

