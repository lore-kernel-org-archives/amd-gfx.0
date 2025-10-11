Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811AFCCD183
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C3810E2E6;
	Sat, 11 Oct 2025 07:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2JTBBxi";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ADD10E2E5
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzwBQ0jPZkuO5Faw4qYwM7t4GLkdI1KGjCc5EhgnY+0/S07ZvOICHuY1vsKxo31vrcZJrz4CgNmhfSvBBvZTHDoHUFKB3NZxylaXhiqR91aebU+Bxk+wDdeTd5/3pHbi+cIuoWf9SGOZLVMJWSLzULHPZLdn0Hhb+pPOMNLll34iQeAmNHqtv1xK8rPOhKUsrkMkxcgwu99DJ7d25vyBfjjWPILgYiWKYaibWblYt4ngtY6yaJ/KafoAAbeiVarT2zdw49hD+xjP41oNkWYvwpojf5xgtFDiRfeE7jnAw6GWtpMclMf4dBr6SgYlF4Rtqf+OY2FcePoS7vXEq7qvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ53LKoF8GmuA95MQbx5MCylI4F1MC/XRVp5ySKG3zw=;
 b=o1kQOqGNy0wNKn7QA7pqNf2n5ZZKtwsGdVgK/bYVR/R6tMHOS/Bk1LYDVsoSwvVj3AHoqNheXr2X+cSZnrYqIyXhqpnuF7FQ0YJC0CL52O1b1YWr0R7Ka/IWHTmRwiIY1TfhECrZMlsyh4XNOZLoPwM39lQTh4/SAgBlBIhUQwjtB4END/suCclrB7v4RM7Q+T02L3TVrUXpOGUYlGCP+Zg+n3GnZN+1T4i4vRKi1OEQ+RgyPBOD8Rrp6mSm5wiY3uGVYmooFSmW6WXQ8SFkUVyf+cNxLgT8CiVcbRyFYxsyfBeBweXKiTJe3TrSGEUS3wGOh5jHVJqIJ6EffzpqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ53LKoF8GmuA95MQbx5MCylI4F1MC/XRVp5ySKG3zw=;
 b=E2JTBBxiv5Xq57945hPv/53sBAtafBgcFc8JCHr1cth7ZRddMCF/ZZC9XXVcfkHF1NwPxw0Loc10ErwEQKrRzuEtkIDp0m+9CBsQiiRyryqft9plLBwvyqDU21pBS/3+yqITCeFNIOQ3IMvEyhZlhNSRdwN0l3lEChItohj1Io8=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 07:50:21 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::92) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Sat,
 11 Oct 2025 07:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:50:21 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:50:12 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: Add ras module eeprom safety watermark check
Date: Sat, 11 Oct 2025 15:48:11 +0800
Message-ID: <20251011074811.533871-9-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 864829ef-5992-4c1f-cecd-08de089ad491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bK3AaDL8I+N/s0s7wimR87dIEPxr22PB/FsmNw3z+9X9Fvh1rGFB4h5wbPzy?=
 =?us-ascii?Q?gH4DSjR5YLimt6sD91aaABcMjeo8uT8VafTyVmcVZyAZKYXHEU3auEEPWO0c?=
 =?us-ascii?Q?ePbNlmM77T8kKEmFO+uj+DIiHhM/SyB+HhM288rmcy504ADY0NdhR3McNRh1?=
 =?us-ascii?Q?u1E3N1u0y00mj08Rzu8ShvsR1chPRFmS9kNVsp8gO3l9GHO8lxbQLgeZ7R5W?=
 =?us-ascii?Q?8M1OOIhQHljG5sW8rtjJkaBBqPD1DD/AkkDCTCCumJz7grRGXkrRGVh6NhVC?=
 =?us-ascii?Q?inB6DwTmgj7tH0a3b2Z9zH0LdtkdT+VC93ld2QR4uj4ulIgupgqyg+4Uw1My?=
 =?us-ascii?Q?YCFPOjlriIGBM1eZx0LH3TpWfzvR+cTtSzyJm7XYo1sAzqcYhjJdqa1OKqMJ?=
 =?us-ascii?Q?I9GdycqWncBlLArJjK1gsbFFfeVg9YCqFRQtHrgPg/wKobbM6mpZzIGa+/I3?=
 =?us-ascii?Q?gQW+nLsF6luhQ6fiK1SrMrKbpHHKaa9VMTe8A50EJod1pSFA929j81wU75H7?=
 =?us-ascii?Q?2dWHHe2CPTiWswH3XVj6m4AgxTkHMMevQ7o/YyRrknLUiawqZZrPqgOiRjJp?=
 =?us-ascii?Q?HEakB5VOEOKiVErRVMKHEgfP/zbiNpja80z8ewDTTrWpLC1ypz1dFChuTkJr?=
 =?us-ascii?Q?+GNqVMUUQqO8R15iQMSKUMsIZWRDK5I5QX0a4f7cKRsuqs/3M1EAY9hODv0m?=
 =?us-ascii?Q?43ebDWdJBSTu6cXbZX6JKZv6OwL2vjArwZ4pnmC4mvSSZwI+At3DiKVnYi6E?=
 =?us-ascii?Q?AK7Nn0JtcmtrAZd9/+PWtFwddGP9WX+pZdP7PJH9v2OKvzGt0xRh92sNP07/?=
 =?us-ascii?Q?PYz/i+chEabCTQL6pZePx+PzlRlxnFG/jS59x5Trdvy+gi34R3BvTD6V9AUT?=
 =?us-ascii?Q?57QPR/jqh/yBLX3rKEibDEYlhAALXWC9niLs/sy8QbdkMSlMfnIhlx+uYtIK?=
 =?us-ascii?Q?0heSsMcXVmrhQ8VwJevhMaEZGa0kRyM+7SWqAsUXmMDBxKZa/GtexO2qOwn2?=
 =?us-ascii?Q?TpRAWAqTZ2BFDa+jT6T0Rykf48fy4kWYWAyaclkBrQt4Jmq5d+X9QyH70SDk?=
 =?us-ascii?Q?jzNYZuJapXjJfBfAgKBefMLeUw7QbxAxj6WecQdHkFtHFoZssZao2mAJpunC?=
 =?us-ascii?Q?1twHWgkB3BgrojhdamV5i5IvJ8/E4dP9MyWc8L/JQHApXX2xZviC7+IZ+SJw?=
 =?us-ascii?Q?eOCSraHfYMHHPuHQJGIjIo2nRUU/UeF9RxfqYL9Yf5qApZXvDe1t+Yq8YZmn?=
 =?us-ascii?Q?tWQTQJAFnlgoQf16T2/L+LSq03bt+Bv/UBNb6KnBh5b2yq5IVe68/KemO3z5?=
 =?us-ascii?Q?MhTzTUitK8XVNFW9HXvfqUdH+CcTwUMpm3U+Uvn8byUqZV4z/JoedVClhh6/?=
 =?us-ascii?Q?WnpsqE+zZ4J1GoB44/jLeA89pwU6zJH+pQYaOpnfZsWUZ2wD0i8FfQ/cJqUw?=
 =?us-ascii?Q?+fEhnR24bJ+QZXhkFUno/TZgc1HILtdpRMB7lgqFnG1yUi3KZUr/13tEsLSK?=
 =?us-ascii?Q?olWMPIDQ9eJT7mZBGz2V+xOAQMsU3XMaQUKfIqUyASKkEJ2Be0QX5q1ZyCG1?=
 =?us-ascii?Q?48qA2+XU0xCq49mIdZA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:50:21.6869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864829ef-5992-4c1f-cecd-08de089ad491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

Add ras module eeprom safety watermark check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3eb3fb55ccb0..5a7bf0661dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -32,6 +32,7 @@
 #include <linux/uaccess.h>
 
 #include "amdgpu_reset.h"
+#include "amdgpu_ras_mgr.h"
 
 /* These are memory addresses as would be seen by one or more EEPROM
  * chips strung on the I2C bus, usually by manipulating pins 1-3 of a
@@ -556,6 +557,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_uniras_enabled(adev))
+		return amdgpu_ras_mgr_check_eeprom_safety_watermark(adev);
+
 	if (!__is_ras_eeprom_supported(adev) ||
 	    !amdgpu_bad_page_threshold)
 		return false;
-- 
2.34.1

