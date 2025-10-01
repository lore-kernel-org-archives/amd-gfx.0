Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B18CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 21:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF7210E743;
	Wed,  1 Oct 2025 21:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dOM/rJCt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5544B10E743
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 21:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIWsfBHMqfbQBj8IRxVPlK/BvDcH6FYWFYvdqWj4F5sIDELGXfc2agcqry3jmSr/1veBS0mNGzlmB57v+5Iw+hs9GFKpMWdhW8HPTThdEVDvz8LIT4m45tkgT5lLnQgVpmXntDmSJCZ6jnLz1WE14U+FKeBP0OFcOWs8i++j8t9UsMJos3QrPaovrRxzSB0IzEoRy5nPOQNGlEjjRGiuZ8Hc02vRXrCa7C1g4MvtknGCtG27ZMKhSJdJ76M4Et4T319N0QMy0ChYIQlBA92/BZYOudYM8uvdEi0vOy3YTFcOgXXvurbcKIwxlVrNxC3XHZMkaXLtRxD2sXBhI+MMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSKnrwaBTTNDfrnuPHQQ3m/qYezhF0826MTDoy7uWJI=;
 b=qyL/uRWwBBByq4eu/9rAfAjJVPXA+X1x7MGP5R84LB7HfQ53rfNgQLxrfdVYZA14Dfg3WOn8uIOLioq7qu7oZqslae/xRjuFUuJWZwiXjSJgt/tkp32bJyUZ46OL39efBDbF5DBL7nVUjgS3DDGcNf6fxdx/d+npiSktQKsL0CtjVhTSwmbz2Yzr+Hehi40QMgRtdP+PEnlSmWLgrC4dCUl1Va7iTJdu6+BKl95MejgpNA440kec8aK+Nks++yktFHOoYKy9MDDW8LKF2p//8qxnXg1oEPLAjRLV+R5/jIgHPHYSwB2BQmBwdys9l7VtOKTUJs4fSKrpMDAPYXy98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSKnrwaBTTNDfrnuPHQQ3m/qYezhF0826MTDoy7uWJI=;
 b=dOM/rJCtIPxUqQ7PRuczEzAEFO2tx2SiWgbf12L5yay42IcFrm348rRvsWlJw2dOWMVry4gEKhGEem7cNXJLNGkp0zAPjSi2aOL167Gm7n9idXv7HWLd6Eltwpb/V2zg9l4uB3jZqw32DMQWQx9DYy2mdCrgEB0VF+TJjpmKMp8=
Received: from SA9PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:6e::27)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 21:28:56 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::9d) by SA9PR11CA0022.outlook.office365.com
 (2603:10b6:806:6e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 21:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:28:56 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:28:54 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 7/7] drm/amd/display: Promote DC to 3.2.353
Date: Wed, 1 Oct 2025 15:24:12 -0600
Message-ID: <20251001212700.1458245-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 773ef734-07d6-4829-8b0a-08de013186f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FIfmw7UmZBAR37w5zF48v4Ox0u2rbcdao6y+puHxuZ/M0pIYlt9i2u3S5I1F?=
 =?us-ascii?Q?u5zLNv/2/4ZI4+K60Z32ZTYfbPCWOgc1TWMk07sP9LQCyeHdEMTvOKMDDnCe?=
 =?us-ascii?Q?2+yWWPU2VVy0bY1gqYkqBhCCPByeHdJH8ZaPhlw5MKWPkK/ICAjF+PNuyIHt?=
 =?us-ascii?Q?Gjwpmyh8NTESWA+/qj5MXNU/KgCHunOrOzV64YkAr+jKXE1bN01/CBVozwI3?=
 =?us-ascii?Q?D5XeyNmoFRxS2PqDzWC33B27jIfNJsnvAjBixAGZp8LWcqP5QoteV5+oSfj6?=
 =?us-ascii?Q?MQPfb07WjJJGtcpl7cbmWKsjsnmgto6TOB40CK7cwjo4mlIgZyAgtjA7OCy5?=
 =?us-ascii?Q?O4vuPgGGmHR4vm42hSGfBIhrWQ3bwG+/JO5wF1L9zD84ZGN+7G3g7s5THL3m?=
 =?us-ascii?Q?VBuC8ZExrJMNaErUBotSuaHjWEXrXzCMm1V/3S5hfYRsOYyaP9564cbJIsBz?=
 =?us-ascii?Q?o5lTP8xmMg9rYj9QXBSiWCq4HwzJ3tJUZLaFD1p+UAb4+zHnyN9zEYwPkgmZ?=
 =?us-ascii?Q?DYa2o0Kyh1c600v4Iba/dToIZWcBmwdilfHe6vNrkBUEkFefRAnIX9N70Mq6?=
 =?us-ascii?Q?1p2r4rXftoSTAqtjwcVMKrYKqLKjA74/KzApXvbquSxhc+d5ID+d8+ronZ7c?=
 =?us-ascii?Q?fXdKa/+M4MRnYB8qU9oK2ypeFWH0g5lgRFYMUNVyrvGyJBJDX/Sb+phlmFP7?=
 =?us-ascii?Q?Xs89Ys1OoUIwG8O1V7gFJQhRZ3eTbyXsUHgdQer3g/YH8uOxhCjNN3Ht0Nma?=
 =?us-ascii?Q?Qx6DDOxZ+ahpQ3KBAz5KwJpV9GmNZBdZifZjCa2P/EKIczWOR6inzCsjHoG0?=
 =?us-ascii?Q?U1ux2DdCk8bongSX38sKLlz6uTMmm/u+8Y2/XAKerr92SrQ8eJ5+xLcVfYY/?=
 =?us-ascii?Q?VKQ0n5zM3kK1letuIyxu/yoO25I8/iOhnfjxE5CE9+wWT+5rxYgDwBRuNoq0?=
 =?us-ascii?Q?KOcAg7CFa3F+HgYTg/Ygy8+b+ARrjJmSHpDOciZPe0ydvYdnGpku0XSiegQF?=
 =?us-ascii?Q?EDfWuvikk0OK38NOlbzUq53xfD2kL81Sfnl7f7ApttOzhHZOb+HXdCAxHqQY?=
 =?us-ascii?Q?fL3TnHYUTrxpVH55gDQhD9Eg2bJlMPUMVlZYD+qNCarSbLHsoZ/VNsnn2H5v?=
 =?us-ascii?Q?rhoH8OhBDic0EDIp/lcd/jqP0XkdIpJF9PI3dJBwVVCVrjOmJTXZG7S5WdXc?=
 =?us-ascii?Q?uSb0NcU5bHEmdUHJF1wv6YdmbiMSpz32mtLNB8rYIoU6b8B4izbk6Gn5e944?=
 =?us-ascii?Q?LtFBXN7AzPk3bFSOb97W70qw3MkLHjFl3hSwWsKU7gzmjKIv+wEkd5Vokm98?=
 =?us-ascii?Q?8fqUCyu0takTMq1xPFB47pdKxu8LT3CIIFvaErAz3zDQG/0E9oxFslMVEsZw?=
 =?us-ascii?Q?8UEm+oPJ1MIEBvrgI+Kzkg5YUxPul5dPH6CTMHiLDOLu8TCRpJwvkoeLh+V8?=
 =?us-ascii?Q?Rn3ZMjgMAPvE+4eQrbKi8ZuvWnyHCYFxq+rFWQ15uPMSk2Sms9yL0nP3Bcy0?=
 =?us-ascii?Q?RXQ7FUuqFZU4OYAD4PHu2Ql0UUMv3OeZf0ApDiTi4sSnGoUr3xAE6bu01odD?=
 =?us-ascii?Q?MHbuuC6WBO3UghmYUgE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:28:56.1804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773ef734-07d6-4829-8b0a-08de013186f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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

From: Taimur Hassan <Syed.Hassan@amd.com>

- [FW Promotion] Release 0.1.30.0
- Driver implementation for cursor offloading to DMU
- Incorrect Mirror Cositing
- Enable Dynamic DTBCLK Switch
- Remove comparing uint32_t to zero
- Remove inaccessible URL

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 945f541eb303..0db01e0ec8db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.352"
+#define DC_VER "3.2.353"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

