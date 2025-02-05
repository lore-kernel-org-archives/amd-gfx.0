Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EAAC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C111F10E731;
	Wed,  5 Feb 2025 03:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6YotCkk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D608C10E722
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB3HFuz6dSCIGji9M42guvSWCoVPbE9f6ZoINOT2DpEFtmDWjHhUIoPg70+HFgeHWPbA0j5lkRsxbEMXrfDnFfOmQ0EEv79GpC332j64DYDJGae8niR1HliVBm1UEenzN2qoqeXJkTEZbtI2n/J3LoNB8FrIb+OVICbGaFa674YW7/ifCb5cZxNZCpd5051VmKyX0FtlrbNIGS1fB/tq1vAneBImVfnqZ9qOC5fup6JJaZcGdwfkEA0fdNjhgza0QsWDo73nnOXs2G1h9P8qUeTmRDXHKqr/Ay2YP+vABRP78p5sHk8eXeodA6oolFrC1O5Fz8weU7QB/LFOA4aN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf9LpX//Ikg4IA5rVG2xIf9hRfB5SPD+9e3ZXtJvt8E=;
 b=DPY6B9aYOrCHt1WywQLfyMsqr1qolZ88oz8cNSAzxwHpwcFkA7nDzQL4OH4Fap8tXRs7b+auRaurph18YoRs6NG4a6Y3qLmPmWpL3CRGCXElbWfaIIMP9BrbdRdvrkVeWPssU8C+cBCaAk9Wf95V5CK5QoJ1j0W1/URqZ1Xt7DrogHtlSlqkWbQwWaNFcLoOBw/uIzBFO/ZXU/FLUxFfl0VZzvkt8P28ft9YQXGj+oiuCFyEvOlIjVc++stnn0p9SQCZQmhjD7wV61jwdIhbQHn+o5znurfqK4QxNLDMh0gYfNGTvUI6w3OUemcpSIB2EESAUVPug4ZPm0OqXImnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf9LpX//Ikg4IA5rVG2xIf9hRfB5SPD+9e3ZXtJvt8E=;
 b=C6YotCkk4cGBE4fjh6yoyU5g6O6k0532muBEVNGhbpaEluiCpTOY3sH7wEuDishbsC3BwZnQxSMwppJPYiDKUqgbci5LTAdst7g4P4vtUkgOJF9CCNjdfoAnsOevAXSj8ED9PhPVneLNrANaE0C3Lg0Z+Q4Jd9FL+kTR9jaxaJg=
Received: from CH0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:610:75::18)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:11:48 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::e) by CH0PR04CA0103.outlook.office365.com
 (2603:10b6:610:75::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 03:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:11:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:10:51 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:10:46 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem
 Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Wayne
 Lin <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, "Taimur Hassan"
 <Syed.Hassan@amd.com>
Subject: [PATCH 06/12] drm/amd/display: Add DCN36 GPIO
Date: Wed, 5 Feb 2025 11:08:51 +0800
Message-ID: <20250205030857.2608094-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c35f58e-bd75-44f5-f6d4-08dd4592d3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3peUcbvWfXLpMS9CW3nUx/EflpcWWcUMiI8twm3cx9ryc+P92fu0IQxmxnuq?=
 =?us-ascii?Q?+TMCTv1hu+VE5ATfKayESvjeD1BwmGjQqQWQ45JcJUcm+9/2+Xy/sx2gIRJZ?=
 =?us-ascii?Q?yI0ej70DPsO0XEoxzbboz/5i/V7XBQ4BXzZG/PulzWWxjZZvLmXT8HlwNekp?=
 =?us-ascii?Q?IUr5nkp/U0qQ6GF+mUS0/PcZvlxrJL48R1Yb/tKApK6d8n7abgKidPZj72Vg?=
 =?us-ascii?Q?/LFBkNR/Mg7T1GgcKQ1ZZVRMG1sNcS6uT47zMdSNFLR1pI88fXX4+3bX0M+g?=
 =?us-ascii?Q?q+aIrlty1SDurPlRj2Lq2Z83lYvGtVEJcG9TFZnF96esu3If4UV7zdPbgQnD?=
 =?us-ascii?Q?JvrRVl6ovluN2uv0bEqGeeGCc5HT4Z/5l9gfg8IWDxstvNipLfVEPY1qK7ki?=
 =?us-ascii?Q?/SKJh/qSUdqvVfZcEhFmgMPwwGXkDpBF8503gW4yChxYWUIvS6fVt4/nIWYo?=
 =?us-ascii?Q?FXDOT2COx/9P6qECdlHGCkVbc5iyf6mD73NqBPxY85T4mo0MCwYKseyPsx11?=
 =?us-ascii?Q?MsbmcaLEgcXZ3z3c0Jn0ZMKUBv2SnbyZdkY+raZdCyrffISaA0FrCr6SrywP?=
 =?us-ascii?Q?NilmW5TSgOKahJE1JvecjIYKVdXcxNYPdAzvUXdGEgmPXP4up5D3MnFcDFyt?=
 =?us-ascii?Q?6I6vj/tjn3noHqmYRCXMLIt7BKYdP4pz6cBgHguKvD/l7XjL9GKYCcaYfC2O?=
 =?us-ascii?Q?8TJ29WICGBhmF8JoGLcnHB49R/HUp7X9aDQn5b2ECu9b6txltWIc2KiD2GPa?=
 =?us-ascii?Q?33x3nl7VqNP3B5z9rw9xGKvBgHtW/xdG+Y9qiYA2oxW8u2UxoIYPh2flXrbP?=
 =?us-ascii?Q?IATUOY9lIrBePj31iL8Bw/EJDnHEUgqGRHde3foPVwwh2jB+f0Ur1D51ZBkw?=
 =?us-ascii?Q?E7B7yliMbsCiwZY8Ph2r6n/J6MDEzrbbi8gaUSMfr1xEAZnX0/nxaLEX3cA+?=
 =?us-ascii?Q?0NU8txP1s9eMKJqJ5ytAtiwuSgbIwB91dz0W+3vngk4iE0wd9jf6lucffqso?=
 =?us-ascii?Q?FgMwB4ZE1lOU+t65iu/sbbAxc5l1N837irSdR+6/2/3XGyfgbMBGc/Mzayon?=
 =?us-ascii?Q?hCP/3aqKmHirgKMPWMAuJzFPzlq9qzjSfoUUSg6PGL8y9iXhY0MtU1vvetcT?=
 =?us-ascii?Q?pdtID+jfsw7i1tvIzvG5Jw7yP4SUo8CC5A6/p5yDu2nY+7tWxK7nU0oZTfwn?=
 =?us-ascii?Q?AWUEKZkHQcPzCenK31c9kt38zNkzFR1XJqmqS9ogkSFB+KWLE46GQQzJGYMq?=
 =?us-ascii?Q?59TeY/rdRKYFfP4M5kDguT1QubmCb5OcEqZj6hwZRODMjNNkHmTf3/fT1GMB?=
 =?us-ascii?Q?vFfkaeXmxI16YQNx0uw7O4y7GuoLvb32kLZr1T43rOkgEOz9YR3WdIVlbx2r?=
 =?us-ascii?Q?DzSNqcfJW+UtiEo/+UXllfh6hfr3UCsc8fnGOXsW/aJTM/PZxR8u4RZFT6a/?=
 =?us-ascii?Q?ZR3CynyAPqeCGn9wcc4+KEjWLZ76IfME/lNez3fOw313Pn++plFFRhaVdOdN?=
 =?us-ascii?Q?b76fA47Uo9ixKrw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:11:47.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c35f58e-bd75-44f5-f6d4-08dd4592d3a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
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

Add DCN36 support in GPIO.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   | 1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 9a0952f9004f..8bc67ca42197 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -112,6 +112,7 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_21:
 	case DCN_VERSION_3_5:
 	case DCN_VERSION_3_51:
+	case DCN_VERSION_3_6:
 		dal_hw_factory_dcn32_init(factory);
 		return true;
 	case DCN_VERSION_4_01:
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 9832247ee739..cb79a2832287 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -113,6 +113,7 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_21:
 	case DCN_VERSION_3_5:
 	case DCN_VERSION_3_51:
+	case DCN_VERSION_3_6:
 		dal_hw_translate_dcn32_init(translate);
 		return true;
 	case DCN_VERSION_4_01:
-- 
2.37.3

