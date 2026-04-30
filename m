Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA805CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 20:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A49F10E181;
	Thu, 30 Apr 2026 20:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jp8l6JzG";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0D810E181
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 20:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGr1CKRvXeWMWabIdcI8PoGfea/ARgL34PEYDiMDbKPDNKLa5ByJrJQ1G3LEcJ+90S9hbhrbpMAo3KQ9uPzllVrl0Of9tuaBtjiLaI99B7wfIUWnUO7RxwbzkcKRajwtq3O2E822d0CGw2PFFAB8lwGRb0r/qzISk3gtAxK9EqW7+23/L6gy6l46riXOBqac76Rb6tIKrlfWwRa0BnS9CmdmUfo2d7pnmfIvSaDhwZ/iOxNYwR8Rvuzd63rH4LlZYyjSg0WCgdpy9Rd3fCq9srYk4lNEu3r3EpRzDY4MtRblE8NWO6lVUT8+hTGxx7cSAtxHM34iQbvt9UCXHX8f1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDY7DUjgRqq8LMaPYUSyJJ6PKEQnLXJZzwp59YxBspA=;
 b=dQEqOb1mcqjyYmUZlHkLMJCLLH3yV9XqMt2z1tft81YlkJwKgyhi5t4qEuDhVs6cHKGnyeimQLQ2tGcDvLfDSA1CZmJBX7qmCxOHW3uCSf4B/faJRO41/x5lo80RAkSLd1dRKJgdcHMlPubRLjkeqCNSvITQ46SeRzYlSwi0pCOz/r/N1JpuoUyDRdGYYgbGjsrsgyM4lUDZvYKCEPSgjkOtS6w1IOtHMhUAMmKLGx6R3Nhlj9FlHh5ovQhSxmlUMIHGfuq/45UUF4LYrPEP6St3yVlTQGHXMcJDYJ0ZS8CjOwIZoX8GKuwRWN+h67JfddCziaq4NB0jqrDPDVB0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDY7DUjgRqq8LMaPYUSyJJ6PKEQnLXJZzwp59YxBspA=;
 b=jp8l6JzGDpLCLvfMvjpGiMZjcstH2mKBL8N1ggLGysjl3iWBllgVFlO16Lvj6BCSP017zI1LUlySkSG9tBU5ykS9Efxm5NNHaxCLrawUfwGKFsLi284u27BgURbCa9+ODJW5ipN7JMW4CiYJfjpOKzUsArs8oKauliD/s8rppN4=
Received: from BLAPR03CA0048.namprd03.prod.outlook.com (2603:10b6:208:32d::23)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 20:18:08 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::1f) by BLAPR03CA0048.outlook.office365.com
 (2603:10b6:208:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.27 via Frontend Transport; Thu,
 30 Apr 2026 20:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 20:18:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:18:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:18:06 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 15:18:06 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Reject negative values in
 thermal_throttling_logging
Date: Thu, 30 Apr 2026 16:14:25 -0400
Message-ID: <20260430201803.90458-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430201803.90458-1-vitaly.prosyak@amd.com>
References: <20260430201803.90458-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 54680459-ae1e-4748-05ac-08dea6f59822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pLx3X0UKSaysnMVjkdRrw7VFNOuYFRRbuuNngv6yKA8xNTuS6HWPES+TIQjSC8QKul+dnJl08Hz+6qd8EP9zd9XbdjwD62WIcbTZCzz90DAkjoKrwBuCz/v+oPEIFkDFGkjuhpaPC5gn5ZMik3j5ONYJwJhbBNs0vDjcMw6yskk6/5WgXzx2AnocUL2ijMNbGdjomnwI8Sa4afyW7TwOmqY5uZQFMn9xDgcy3/V4X/4R43S+bhOHimwgKJNvluBfKJiTMLB1u9C2faa2VUk03qApBTlW2LG2XT7sH/t2JxSI9Fz1a9Z6qgiA7V8J0/LoRDetQ8KraRqXDV4F+6Cd2XVhqoCmYE2mLnk2T8Ky5OZcnHdwgkqDKLYUw+FOpcS63iDxPivcXSkwTuC6+QaDLoD7EQv0C8d4aatz1H5B7509Sns+e7hNAvGoaN0Dfn7UUHgWckIgalXmJJ8pHZXxvyv0Lk3xxA70qZ7WpDdQHqYJ9/qgLIdoi9eetDt6+MIZQJVhipAVdGF9Ytmwt3GSMSvYpTTrEtiSfqSKXXlOfPsoTUZqKWHava8UHsW2DwNT2fcfQrkkq4zhjeKk/rRBgZC+LGwPaMtbPAb54hVMbNB2xkd7RoemLFMCpYig+3wwy92a3SXVrMlcPnPYEPETsURBHKe2TQ0TH1yPph29FrZJ+fI3WGXkws2czSxonb7O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jmFVAQLvpGrWP/dOtRGaGsFxfqcaY728MpK8v/m0v9zAjb1ElQTakBsVTJHCUFyoIzkNJS713Y/hZsC0nXlj8dpqUSb76wKKP3CytHwvTL7EHqyZ5MoOpy8G2vYIXBzH5RjPnTdm0/7cDR6m+9LYRieOjFazKkxZM7NdFq8nxufCazRBn5qDKIQ6jQpLljM5fB7UgzSSw0QVds8AdIpp6ze+wIRyxjPnAirfQj9fLcSVNeHkRUbeHJ+I6B2DnmOorHqJMohhCpuAA/QLPzLJPu1Jy70lPXmybs3nlLCI4kPOr6cMxqItlTRsCvjCtRNEmSYc8YBLUbps2EPM37Zg0pk5BcKGM1k037H1ztAxIEFpld5tro4DmGppdKRPAVnldmI9PM5NRmahNkbAyiujhkH1UmdJ26X4DpSTdaVO60xWB/e/CinF0g4yv5y6Woh6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:18:08.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54680459-ae1e-4748-05ac-08dea6f59822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Discovery: Fuzzing for secure supply chain requirements
Tool: amd_fuzzing_sysfs (IGT test)

The thermal_throttling_logging sysfs store function accepts negative
values like -1 and -9999999, which are nonsensical for a logging interval.

Current behavior:
- Values <= 0 disable logging (intended for 0 only)
- Values 1-3600 enable logging with interval in seconds
- Negative values are accepted and treated as disable

Issue:
Large negative values like -9999999 make no semantic sense and could
indicate input validation bypass attempts. While they functionally
disable logging (same as 0), accepting arbitrary negative values
suggests inadequate input validation.

Fix:
Add explicit check to reject values < 0 before processing.
Only accept:
- 0: disable thermal throttling logging
- 1-3600: enable with interval in seconds (existing validation)

This improves input validation and makes the interface more robust.

Test Results Before Fix:
  thermal_throttling_logging: 6 failures
  - Accepted: 0, -1, -9999999, -2147483648, empty string, 0777

Test Results After Fix:
  thermal_throttling_logging: 3 failures
  - Rejected: -1, -9999999, -2147483648 (now return -EINVAL)
  - Remaining: empty string (VFS behavior), 0 (valid), 0777 (octal)

Tested: amd_fuzzing_sysfs IGT test

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 66d8466b166a..1ef741f4c43f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1634,6 +1634,10 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 	if (ret)
 		return ret;
 
+	/* Reject negative values - only 0 (disable) or 1-3600 (seconds) are valid */
+	if (throttling_logging_interval < 0)
+		return -EINVAL;
+
 	if (throttling_logging_interval > 3600)
 		return -EINVAL;
 
-- 
2.43.0

