Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC6C282D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3301E10E345;
	Fri, 28 Feb 2025 18:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U5yqXzzS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E5D10E334
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol0AYTmCM4WWKWqe9OzuYUGX4wpxVDUEz581C8+J4AOWVYN8aeZK6wvJrISGsCLJKE6Ca7IBY3xqwzwUzSVEVK3vbxOPGbk2kydxpPESPzvVJYQlOAnMitIh5Woa3uXqKuorEgwCqqpe0v6hPp9qFMVP/O1jURxBKzCQyrD0jxaLdIR84c14x/IEQo34ZPpHqwRas/YFOVXuj23pP62KDOoAWyZ4ChvdugnXWAkjlIu1YcGA5vdNOkSMUQfhbgowvlQoEFfkWVXtgkMGXya0tyAZuWuL/hwAb1/5xgY1hyC7QCEh5MO99yujId4bIpvDJ9jYQ+ovZ75PUrYw9EvmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeVR3RIV7u+Tmez1ZWV1cXtkepUB0YpxX5lMwosjOm4=;
 b=r+eGNiGwY65+LPP/yopbLLuVunY8UzZ8ksgdPH4Dh8uQK5LxNQC++rRGx/RhqMjBDC/DX04ge4ns/Upvm8F1WH2wBh/e77STcoEt/gZe9HJ1CtYiabI6xuOPV9XyT3VJ1Zp1NGSSdDGYqvnHfe/ZX+4GkL6YpMzn5d3TZ02Vxk2knamxV+Htw6ZAv+9FRBTSvlB5jeOp94aSJONUK+1DKhx8ournCbRLtIhS7i21LPcNPaQkiDjW6ia00pV6V8vEB8zg+9/Xp2DVkv2Y3R4NdbhMf/+I3ZT5bzkxjrWYfsVju1hBBBtTWwT4JxcNzrUcF5qPGU7oVV/ewbDo+ulUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeVR3RIV7u+Tmez1ZWV1cXtkepUB0YpxX5lMwosjOm4=;
 b=U5yqXzzSf4mGSRi2wXsNylmWr3OlQpfXkA/k8cgnIDMk/jzz0xdoyleNA0ahwrBqckSG+32rYwvISw0nrsWSXOWPDZfLB24Yljmyeegirzg1j28x9gh5lEPYQ5N1+O0S3vbYilijNNY0J2Bk18v+UAnivu1YqMxVvfl176lbjFQ=
Received: from BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::28)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 18:52:02 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::4d) by BN9P222CA0023.outlook.office365.com
 (2603:10b6:408:10c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 18:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:52:02 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:52:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/5] drm/amd/display: Add support for custom brightness
 curve
Date: Fri, 28 Feb 2025 12:51:44 -0600
Message-ID: <20250228185145.186319-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228185145.186319-1-mario.limonciello@amd.com>
References: <20250228185145.186319-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fc599f-4b6e-4ad7-c67f-08dd5828fd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aOwzdrbxTZtgBhwugNCKA2l3E9ba29i7UVFRTKP9RawxnLh9MCaOpUcqhQT4?=
 =?us-ascii?Q?NH/gO/7WlvVc6HBunRYpgsQk1zn6ed7/m1NDwKRxhnKwVsnj5hlMZrZrd3HG?=
 =?us-ascii?Q?YP8iZISOOREtrdulFfej/oe0sEFSjO1XggWTQYPSzuLa34fU8TlQAU59Cv2u?=
 =?us-ascii?Q?FjOzvnrLf45YTWW4QRLNAHmaUwk0hJNieIa/xt5BMWPNWxWWIRxMqrbQVZP4?=
 =?us-ascii?Q?oyhxKswvZUZbIJs13fPR+9rSUa50bR7zAnE5UbHRnEafeYE5dq857LJJESph?=
 =?us-ascii?Q?IQOYcfiQutcyFBA/vNqVP3CXcq/O+RSmn171gaTX6uNP1qZoKB9ru5EoBstF?=
 =?us-ascii?Q?Id6V83pdfsqxkGV+2sO9Rd/TTNWsdoTl/QeMh5kwARzhTZdT0iKqIX3cWrQy?=
 =?us-ascii?Q?IMWwlgqWE4FFroF4gcinwfuJ0kcBFDNtH+m8NUPjb/zXbn20pPhW8exh5j9Y?=
 =?us-ascii?Q?wKpLCW3TFB66mok7OC7ojstUDQmsAunHXI4hzrKnvZZwRhAdax2+OnCpUJra?=
 =?us-ascii?Q?rU70FeYdzZ+E+jsD09BGzmCgC7qwaV63poRw5Z0FtMKiBTRx2swEYXAD7obA?=
 =?us-ascii?Q?GQh6DF0fosRbcFZnZ5dEQoYDF3OoytVIinoRvgk3mBt4y51gNblZjmvmyS1v?=
 =?us-ascii?Q?MFrVDIuNUCzHVpgRjXI9UFUpOHgo+3wKeMiHqLiM9QUWFm+UStCTQqeoTHTC?=
 =?us-ascii?Q?o7HYBZXy204LUARFc95M21NBf+0Bz2hURnhvmVjrWTTzE/SjrMdUE9Id+w8n?=
 =?us-ascii?Q?/uReWIl5rhmg6HWpj8tu67pmw7mqCRyJ9t8eEcZM6UR6ZSGQbSTHhbPmuFWY?=
 =?us-ascii?Q?dDECw8YrVoZtQuuuKUW89+CuSchN5+GItpJ85jzRX1s2n5xrTDgKTG2Ddse7?=
 =?us-ascii?Q?Ea15T1d0xu24Xz2zT4T3CYl436fsu5Ex62JAM2UfRGRUj6rhMFTfnEJD9VHp?=
 =?us-ascii?Q?tOTmnyfw72CU/qiKeSHenuvANcDnprJQAaZnOHw0rRq8rzcJ//c0bZHQUIWU?=
 =?us-ascii?Q?N1VdmkO8LHGbAFG/n8KbKmTMDBtDk6vv/VUfRO8vouW3N+VKn8EwCJF/fb0F?=
 =?us-ascii?Q?8tkm/MLu3Q8O5E+P5AcxJTe5qS+DPYjhPI9ZJ5AheB3M91xiQEW6GgDb9R2x?=
 =?us-ascii?Q?T4BwMhr0AdzW0hZchJrxQ67mAPnO8a9WFb1NeoZg1rC/Zamwmx5RaqfU/0lV?=
 =?us-ascii?Q?d4f395qrCMsz40O91ZFdmAosz8k8gv/x9GdCKnXXkmckdadmwAwEeqcbq8z+?=
 =?us-ascii?Q?8QaKfWj7v7jIcg/UGQw/tUazd+FOWQ88fgvUmL4phwbKkCnNLYltd/LaZ/91?=
 =?us-ascii?Q?4bc65Cucsp8mToYn2FSwfdXBqfXZQxaKFXtbqD6f3vQ5HJicynS04q9pT8Hp?=
 =?us-ascii?Q?Jnj1nlaW8Dzc9/ECv1VTQ0qxs5y/FAEYkL9Bwy9eX6zjDEVutzExRQ2bgPKs?=
 =?us-ascii?Q?7tm4nvvMIKTUJerM066BWQnQXyJc8r6Fnn3/xMAXZWXLrRgyS0FePsYedU3h?=
 =?us-ascii?Q?vRvSyasz88MlQOY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:52:02.6761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fc599f-4b6e-4ad7-c67f-08dd5828fd3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

Some systems specify in the firmware a brightness curve that better
reflects the characteristics of the panel used. This is done in the
form of data points and matching luminance percentage.

When converting a userspace requested brightness value use that curve
to convert to a firmware intended brightness value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 61d626914590..b252c67f2bc4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4759,10 +4759,35 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 					uint32_t brightness)
 {
 	unsigned int min, max;
+	u8 prev_signal = 0, prev_lum = 0;
 
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
 
+	for (int i = 0; i < caps->data_points; i++) {
+		u8 signal, lum;
+
+		signal = caps->luminance_data[i].input_signal;
+		lum = caps->luminance_data[i].luminance;
+
+		/*
+		 * brightness == signal: luminance is percent numerator
+		 * brightness < signal: interpolate between previous and current luminance numerator
+		 * brightness > signal: find next data point
+		 */
+		if (brightness < signal)
+			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
+							   (brightness - prev_signal),
+							   signal - prev_signal);
+		else if (brightness > signal) {
+			prev_signal = signal;
+			prev_lum = lum;
+			continue;
+		}
+		brightness = DIV_ROUND_CLOSEST(lum * brightness, 101);
+		break;
+	}
+
 	// Rescale 0..255 to min..max
 	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
 				       AMDGPU_MAX_BL_LEVEL);
-- 
2.48.1

