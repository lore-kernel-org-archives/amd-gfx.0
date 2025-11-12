Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188EFCD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF2910E79D;
	Wed, 12 Nov 2025 18:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4cXIrkaz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CEF10E79B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAyvqCHld6IVGQuD0V4Qwtd+p9+TTm6HRLPJ5/SGPoCc+1G5anqjRkkAs74j3ZWJUC1j9VieYEGMJM+xJc3y+97MiyEBzwkXDvGqmGe826v/7rKpSJuRABg3rDNkDfVXoPWFxFzUYyOULdiqevmzhstsN0vJYyoMDP+sHdltn/NDeTtTQVJBZPMatVV/XouvedCd1N9hx8f7QlCN9SulrYGSy7Yhh21S0oXxkYhVMe8YagidX+UFXdKf4GLVKuzBbKWQkKTUaaOfSyy3QL68Voa+XTypUkCZyYZY9A3sKNEluAopZNooOvVrc0CIbPKkek4hKL0Bn+6wLtMojZ/QUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGf1elFit+DleHsrwrj4q1nNK9vIeLQAUZWXwWQWqJY=;
 b=xDPwo7nYDTfgKkS+MfSXqEMd5PPfECgM/HDTYd3B6rEuPQUi12ENzLz/9EaWgi3zP+wO3219By5CXBsDb2RjpSZiBQj8/B1ZxzgMFbAdfHoBr/Jvz0PfduXFmGEzdz0en+bdCwz3PVu4IRxIawh6O88Y9j4N6IDwIA8YAhNzHzKvLjwcNg+DEBGbT5QS+C3ZS0ubJouK6w8Sqk7PfpMfESDeXe9I5lSDAHIo7dJjFdkItQuAH0cIRx5d1jygoRIxRqPRKLvS2eKLqk70VOC3WKyyizRPI1kRw0k2AP7hVv4Yy/9gmNLf6PbqYgeehVxZxfthMjfgGi2uBbWJ4WRtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGf1elFit+DleHsrwrj4q1nNK9vIeLQAUZWXwWQWqJY=;
 b=4cXIrkazWMv0C2vHla8rCN/aIp+2u1EhzLlqMaPkcW75vOy1lFE+dEefMl/C1oDW5rK4frHIhTPFqsDDYmb9qPxEc03MmxriSr4OJl13waQ9uSex12YRk5xF+H5a10q41AieykJV0DscplL/nHCUx8j0NsYKGIU45Gri/aVCOf8=
Received: from BL1PR13CA0255.namprd13.prod.outlook.com (2603:10b6:208:2ba::20)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 18:23:06 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::6f) by BL1PR13CA0255.outlook.office365.com
 (2603:10b6:208:2ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Wed,
 12 Nov 2025 18:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:23:05 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:23:05 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 15/16] drm/amd/display: Ignore Coverity false positive
Date: Wed, 12 Nov 2025 13:20:33 -0500
Message-ID: <20251112182212.559007-16-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2372c3-ff85-4bcf-6a85-08de2218867a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEf8C25Q3AOxM73+2+BKtmiaU7z8U6sWdlniNt3la8C0Xz816Qci/JcDk5sG?=
 =?us-ascii?Q?TvZsteOSg1e6fIdHb05P+M1D7lAAMYVtXqxpD+Q3X2Z2UyFTxomRXhqinNKM?=
 =?us-ascii?Q?UmGc98ww4dG4VEamlHLlW/daahsjlPPWu5Mjk1mnkK+KwlohOqcxJcxhKAk0?=
 =?us-ascii?Q?K556uKSgQWHmM9Po93nAnv7fYIIEW1RnocuAjGApr28YcEC3UidsAe6WZUIH?=
 =?us-ascii?Q?tpECjkITUXQJ+wcKq1KOsUOaGRPbBLNCfXh/ef33PbdX343Ion3LO7+rAxyp?=
 =?us-ascii?Q?ckwb41d7FWhTox42sJHf3g5l3RtdFDPffzJw2ObY0DpBlzEXFTx4723uwC1o?=
 =?us-ascii?Q?GeL3F21gquyfxqXc+GKZHrtF86ZqddOITbjPUl8kcnkJV4hLMGR4LGeeRh24?=
 =?us-ascii?Q?BGRUhqX9m26jmoTEEQ8Pdl2dvLgmgZjzc0PDZ01PmdlYrj7szMkhROq1VHL4?=
 =?us-ascii?Q?33EycO1wx8sSPILA87N0UEsLKdfgzrVbAuq9zLcD96prO+FKfNtL4z+ZQAz2?=
 =?us-ascii?Q?qPpJHFJYJdwZA01KMd8LRszHfqU7QozOyi6Who5IQE20c0kk7N1KVmsh72Qb?=
 =?us-ascii?Q?yQQuNZvsrjacoNF8rufcYzeceEthL5Rw5QRMk6EWm0qGdJDVKneoRoGrabRQ?=
 =?us-ascii?Q?+fKTAeYhbT+eQJjk+CPE+yYzWPrO7vLWNXsLR0ifV3tUmlERajJFf9pg2mF4?=
 =?us-ascii?Q?pvV88g0fF1tyQUrlwXt3FxfSo0Ae317ZCR559UGs3aTWp2+iejEEw7FwIryS?=
 =?us-ascii?Q?c2givwgzy1MB5cTdPcOYtxU4OE/r4B7JZlsFD//eMJAah0OvyG8CW6dgvmzj?=
 =?us-ascii?Q?hYu2BZF3s2Ey1kKjN/pBPTBebPaMpkiAvy4KjbA/TsZCLqLz2e3y0sH0YC37?=
 =?us-ascii?Q?o9XbAr8CEvvOuKd6pKtwXxvmrkIvLUwkntN+5fEr+YI6LDPRCbCEYH3cCRLL?=
 =?us-ascii?Q?1uLQgKybH8Ghl4XQTvwCD4fuBdxZ1AkT8+e98UUzJS1V6KyWYbhjjjEbt3iJ?=
 =?us-ascii?Q?jWn3BtrBHkOLmDaqZdgcNTHyAt5ioMnc905gfaUoBpYh91bL5U8SICkxhFkw?=
 =?us-ascii?Q?X5YfeLgfW8TvG8Xub9E4g/gqJAtfYaJeBAl0/0djFTAMLRiHglMquh5U7XGq?=
 =?us-ascii?Q?he6Kd0auZZo8TQVHT9ysm+JiYSd4+2JjgHzxY2UMMQ8ei9NsgWyXBA5JWZEy?=
 =?us-ascii?Q?Gh4pxwVn2Iujy2etC/wuKzlb5N8miYVDLxvXWfC5snCaSJS+dedRKnc+QvDy?=
 =?us-ascii?Q?GU92aK4Cwx7R6GLUfaxJjyVlcARCyCmEBeyL1jP0k4VYHMV3NwUw/grDgZxO?=
 =?us-ascii?Q?EVzLesjegS5Pn/3CkavaNd6etfT8pCbk0Nucood1lkx9U5BthE66ut5MAPwT?=
 =?us-ascii?Q?+xibRBc3rFvWx7m9Tnlgrq5va/JB2Sdu7fa2+x2IAfGF3jHhANTZqeVHqC+s?=
 =?us-ascii?Q?Wb/tSQ1qSZ9znsJE/wi6v2BBy7Ih51TwPNsWVD2/BOUYi4FdIlHk167doT1T?=
 =?us-ascii?Q?VIqK12+aIwxuRZgLJShWsp7Kzi5bz+GsSU6CzACmin6F2hh0DTUZkFPF03XI?=
 =?us-ascii?Q?Jq8n/HWwAKr+YQ0P8c0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:06.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2372c3-ff85-4bcf-6a85-08de2218867a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

[Why&How]
Ignore Coverity false positive analysis in the dmub_cmd.h

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 815b4ec82c11..173bc2bdf50f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2647,6 +2647,7 @@ struct dmub_cmd_fams2_global_config {
 
 union dmub_cmd_fams2_config {
 	struct dmub_cmd_fams2_global_config global;
+// coverity[cert_dcl37_c_violation:FALSE]  errno.h, stddef.h, stdint.h not included in atombios.h
 	struct dmub_fams2_stream_static_state stream; //v0
 	union {
 		struct dmub_fams2_cmd_stream_static_base_state base;
-- 
2.43.0

