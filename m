Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D6C27C55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 15:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C596289FF7;
	Mon, 10 Jun 2024 15:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVtVfx4x";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B95489FF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 15:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj6nP0oue5o2ysvaFPYhAwAKwp2jtwACCDqkPdd9axBl2t2ch3izUpqli4yPVG1g8UUxijggGP8XRZcXx5jwpYihuWKVQsorCSmOKSCqLM0SUuLRdWUFhsCUVIF/xm1LOhTjVNoqC7oPAzGwrwcHGHapeqTD/gR5JopjWFz2vawtG1oWPIVQQwAty6j6ZXu/1dFLJRnHOcLbaQq04++trMxUGatzGm6uDeoXMQjEoYtQOghKpM3Vyo5eT8HEhrwcA8eI1zf+wJ++utoRchkp4a1BR9ZWqw66uAwJytPWQeIVEGEpknDZkbF1W3dSWJdsijjKuCgRML7baatw7oT5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXRby2OH/Eswge9R1FQk6WQQE59oBX/WfBSl4ysugII=;
 b=H0dG75SUsdp5Sv/Uj34gR91YRpn00pLRE24uiiN6tAEa1l1W9ohlF5C6TCYJ62VpH7+itDJRJDjs1D6tlkN1Htyv9LEq/dWjSieTYrwho+dQcnLtSQnwMKxk6PvCFspQcaxRp4l0sbaLLr6A0WmBCL283PZnFLwUSMc8Vga4f+cl3jdVgWSfutYq5ZgErUBsBZYadkTbc1R2bT49QY+SZDiL/XSXRl3UWxypkb0QIbnwGPp1YBeVyKYl8iGj5KqBCheynGxMkoSdzdFgMCbQiE+6NXoh3VNUp5FZXPLjsX1G2aLIKyAVGmbKigsg7M4TVDWMyrkgi4CRsu8N/EPyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXRby2OH/Eswge9R1FQk6WQQE59oBX/WfBSl4ysugII=;
 b=oVtVfx4xTRC66b8u4J/KnqvYmDg1yCTJXGO9Mh3DadCBeE0BxMJYmpMQQV9GxO/qwFEL4Q3jnGeC45zEf4ZaIA3uxj6WOf2LUY7m+pYrCwH8L4IqxVd5EfknG09AG0X58+wd5V9lP/YOitLxXq/qQUlfElrVUCjVP2Nx5l+Peyc=
Received: from SA1P222CA0084.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::25)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Mon, 10 Jun
 2024 15:58:28 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::3e) by SA1P222CA0084.outlook.office365.com
 (2603:10b6:806:35e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 15:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 15:58:28 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 10:58:27 -0500
From: <sunpeng.li@amd.com>
To: <mario.limonciello@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <Alexander.Deucher@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2] drm/amd/display: Guard ACPI calls with CONFIG_ACPI
Date: Mon, 10 Jun 2024 11:58:12 -0400
Message-ID: <20240610155812.133865-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f57c6e9-546f-4b4c-c4eb-08dc89662b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/Y03hwF2kLaHWVZBKLm7ew0YPJLL+1+VM/CWjpyJPIOwMGBZWz0ixFEpeRe?=
 =?us-ascii?Q?CHyUpBG0ZnTiJphQ5Lo+lS8v0VkYPb2qzllYI67VCcBtwrvRyp9mJqRhi0iZ?=
 =?us-ascii?Q?pk8xmLOrOIf+991dD/O1FxaDdRMkMD8F6a5jvYsVMGFsOprT0+zryitdxv+n?=
 =?us-ascii?Q?ksdRQbvt5UOLiWAxwgI5KWf5Xl3QSKND8RHPIfBofaS1y9rRi4CNHvfejnbH?=
 =?us-ascii?Q?aV2SdFu+McRnHEaSzfo33jODCbyZ5HKbVdnuR1jLGevmskMnDWaUQnoauMmy?=
 =?us-ascii?Q?scsoPzJAPNOhSNqoAoA+z5fvA8ZQYXNpX7djfFCaitTX1wUB9RAQse9vJp5H?=
 =?us-ascii?Q?j1XNXN1c4OqfVrFEpdxUEZLQH+Y7rPgzEHAbp7DLc2+yntDtbVpY/8B+xu9K?=
 =?us-ascii?Q?eB4myj+0WP43xFaorMEyLfE6TUdGz3KaVpMJhQYY5kVA2ocfmR4vKipvsMJ1?=
 =?us-ascii?Q?jYrp5JMLSy2jL+osA3CSj2XA1hbdtFKzWXdMCSWdp25oUtqLL62tAFIgn/1t?=
 =?us-ascii?Q?zXUXCGHL4FA9t50jZyV87CDtWUkQavTp82man3yVIVS4F2PbSs3opYdRX3cQ?=
 =?us-ascii?Q?QvBoTkoDWVmuaNTJwkt7tsw+fil1S3vA7ReDvAakv8ygIo7gSjBlrJT8Grnp?=
 =?us-ascii?Q?WLNCYWb0+t/bSFJAPepMbjuXdPUo76PAlNH1q1s+eN/+gDfUs30kqLYtY5Sf?=
 =?us-ascii?Q?qY3WuJ90zQTZ4Wy0lLjoYji7o6W59MnK/NoHe9R3OtVzEbPa8UJvbHzyslWO?=
 =?us-ascii?Q?sKILkOEI2f3jOy1WsSjwSv6J7kx/iKQLLFyfDEriCUet7Y+YJxMK/JGYQN5+?=
 =?us-ascii?Q?0rtfglxBoMuANpzMrzhXsjt089OJqWCsLqNTGbKF23y09fafupq8SOlsPqwB?=
 =?us-ascii?Q?x7FzWQyP0xsPtzSNOLPWgXncrh844DYHhBv1gfWEr9rEcfG6jaI/wemBxV3G?=
 =?us-ascii?Q?Rhk1T4PaxLSwhzHre0k9gbY6/1IlEs+aL5OwHtbU2q071p7yUr5DL3b/oirT?=
 =?us-ascii?Q?7yjiI/bZne4zCn+JNbQiAdT8CUYhbQ76KAihUo0cguj4YiDoaIojHjdSb0Ye?=
 =?us-ascii?Q?B6XizdUqqdyhU6bI8WnYvKhYZLcjlsGYD4TZpUZ/K4L8Cl+Ks5g+TwQiguzw?=
 =?us-ascii?Q?G2rrRjKeURfRofT+pASflfnOFDomlExh1ajsfeZA+mFle+RyZO2AvAPgnqP9?=
 =?us-ascii?Q?F3RGNQDZeMjPHhH9CXqUwGA2KUxAMeXzRq6aSNhRDQclggHH9F6t5SCOgrUR?=
 =?us-ascii?Q?s0SYbgJ5oDPfsFMHkwxQu+7xyT75eof16Pqc/QTUnV+ebrOG48m3dSKSFhGT?=
 =?us-ascii?Q?W7iaZMGJW+GLhw750NMw52i1SGP9QJnZZEZgzvj+/kkZFOdS6HW5EW3OmeJR?=
 =?us-ascii?Q?88CBo27CwtrezKPavLzKdgnlZ7kHYOiTg6QTC6XKt95vwD1Yzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 15:58:28.1281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f57c6e9-546f-4b4c-c4eb-08dc89662b14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
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

v2: Instead of ifdef-ing inside function, define a no-op stub for
amdgpu_acpi_get_backlight_caps when CONFIG_ACPI=n

Fixes: ec6f30c776ad ("drm/amd/display: Set default brightness according to ACPI")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f71c7b98d77..083f353cff6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1576,6 +1576,7 @@ static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 						  u8 dev_state, bool drv_state) { return 0; }
 static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 						 enum amdgpu_ss ss_state) { return 0; }
+static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
-- 
2.45.1

