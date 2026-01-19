Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A74DD29C36
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 14:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D921110E478;
	Mon, 19 Jan 2026 14:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4WUFb8nF";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF60410E478
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 14:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+7Wg1intYfTSLHMEqod+eFebtPaP7Ns0dmI/sKZwpnkmM57ZVZCz2aCyjQrMNNMar4XdJrpNyMBwm3RzYd3avhcGWAgV1miFYn7NuUEhs+9ck4yiYt+o7BWypF2S8JDT/+FSUAxMDeHgfGtsapA7jNW2ZANZpqUEmDHwqNE3VBREVkzlkqjLDprLMJNt8EaWUaP9GWPI7f19L2woIfIHWpduJVf44nPr7so23Adh2+XhL19mNh3O4Cgj67zdYtdbGQZLimD9vRPzV76trdzSfVx/6SXJ+khF5tydXZnXmfQloClXFiFjwhSVP0zCq7WhuZ1COvvomw1t60VKN2zPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmZwqeb7PNbiao2L9CVDu5vYdNvzdcVbX++/CFPInrU=;
 b=MuNdrSWitV9TkpXHYZ7sz/pW3Fxob9iWUShSVFZE8ueddHtuz4tV9q6YiZ3tAkP8SqUlEwW4Xau4Kzu9O2c79wWjMETjsDPf/IhIutH+68BAlQ9fDMh1hWbiFxyXQO4lJNjF3l1Xhm4CGJltoC8an+hcV+HiXoQpVCPIl1xvK6LenxnEnWYwIGYYiLd66GtVM9F2ogAGopc3WEOKjnAfhtkRWM7fvcP4d2SByXwYK6ySJxySjrNZgSzhIW8iAaYyuY0WuDljCtKuMvil9dMHbtSwBs/l0FjwRiEwHV5Mgzm/bACc+J9pPruipNMXoEsK6bVx474u7SbixeCVbpDA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmZwqeb7PNbiao2L9CVDu5vYdNvzdcVbX++/CFPInrU=;
 b=4WUFb8nFZzO/AlVHxh6OgrnGK63RT9VlrDNvt1503CxFg84TW3Vmtl1j4LOF4lyoFIzAI6vygOj2lCfaDt3R9TS+pbfTuiBTCuvoOYQEDJCpIU8Y8g586thB0xIEpjBgeTRnP1xZbj4Jr0u2KD79EO82NQMYaj6LZ+MyWa9D6IU=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 14:50:45 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::2a) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 14:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 14:50:44 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 08:50:43 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <James.Zhu@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: add extended capabilities to device snapshot
Date: Mon, 19 Jan 2026 09:50:36 -0500
Message-ID: <20260119145036.3019453-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 962db2a9-1089-4acf-2576-08de576a1fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EtIecWkrx46eQ5FxtPC+ruNfMfAnkCGx8vTthbIEZr/8J6XeMpYYJspwwZRv?=
 =?us-ascii?Q?6dU6BpD4Lsu3iNZzDT21IRKhQFA5qrQkZ2PSJhJQU4ZxD/bhmKe1DeJ/SEHn?=
 =?us-ascii?Q?Lmh/nwqwG3zqhMv0tFRlt+2e9UQvGycNF/loK9YuvV60EfuzQyRhmQQ44gtg?=
 =?us-ascii?Q?LaxMu8ecXIHkEV20d2IAu8LbRqXjbXKTDl1GAxEjD2qUeWeMq3ak4FmIEC4n?=
 =?us-ascii?Q?RfSTqZWfKCh/T9LGOW0aLn7TgbmTTEXhzV+6bNjOyzqR3yL8dwnqGDO/Ik0k?=
 =?us-ascii?Q?pZMa/OH/Ai8BIOuc89CNFh3m463ymRIsyDtCKVGCasoNcspyvVH7LxABmsvB?=
 =?us-ascii?Q?tW3oYn5bhK69tGE+hRRWp0PfzRAOAR/3DrVbaMGmoAKPhNe3hEFfUv5eBd9z?=
 =?us-ascii?Q?t1FiDPYFZhgsC/lOF+G13InX30BHpgohqfuwCFPpiVgqh4gPZWfKZxEaj6JO?=
 =?us-ascii?Q?AXKoE748+bhd88DM14/TodECTrKl7euj7HiZXwKNVRyd2iK2LDawXu7JuuHO?=
 =?us-ascii?Q?gUNFwQ3XHsMmhZeOd/OVLJNT/LIqk6T8qaw/v5VhL3QyXS5eZKdM4IuulVRn?=
 =?us-ascii?Q?8EpNeFj60XIi5imlzXm6mc5DaMfGWPMPxRRbth05o2HzhXtNmHOJcK81jiih?=
 =?us-ascii?Q?aG+gTaivOEqL/4Nt3vUpqp+lDHFMg7LLzxpsGrL2L5OSIn1fPbyudvrY5OLZ?=
 =?us-ascii?Q?55ioNftMOXQ5mJApbEM7txpeyHNp4mB2+P1EUhlVuwq9CW8NNt1Sw+EJMr3w?=
 =?us-ascii?Q?9C6cl6GrmJTs47EahFn8N6PIxDCOUxD7NXY8EOwGqrAcfonzEFpjoqUECOSY?=
 =?us-ascii?Q?ehEP1jCKeyIB5zwDi5S13qWfVS2NzAW8AFz+FG6JIkyw6I5KDmCYqZZoVnY0?=
 =?us-ascii?Q?fHdejohoiNA0ZUNYGtKqgCN7GXuWT3Xl+N3GwS+x9UFx39GsC0QNKNTbiO1y?=
 =?us-ascii?Q?GuIjtQpRmh7DfoL4bqB9YWBDW5XRMSBg5s95IvTR9v09HIo0XIqyoU4yZgs1?=
 =?us-ascii?Q?epJTomSywkMkxna1A/4DYMtXGekuiX5WvPmlBi7WH6FU/Gj9V6nxldTagYt6?=
 =?us-ascii?Q?G4IPoUUkAdxlINUCaMnai0Z1WQC6rZILeySJkAiwKJVzbAdB9nbz4BOMKIph?=
 =?us-ascii?Q?nY3w0sJ1ozGWUVKCHDkCyiTeerXTW7kGXtIt/nYjBWxdJC3L4oo8CREidui1?=
 =?us-ascii?Q?ZayQHuUWyMedgIXjif3eOdwmPLG6hw0ECpUlsHV3FkVJNDCYftcSlpVz7cs7?=
 =?us-ascii?Q?G2ZElVztWmtVnHsq8+adUQRmJ8LZpbXuWMR7bNuSHiS19idhN0jl3e7lLAAf?=
 =?us-ascii?Q?kdB2MkutyAivY4P3DAiohBExDloeR7kKFeYnwJ0RnZGC/B0h/p4YyVfxcOUJ?=
 =?us-ascii?Q?4BbttbwNTDPyDbADpuJL8PMLRUZn+crejSGGB/pjCvJguBGKBozybGNb6GOq?=
 =?us-ascii?Q?iY7L0nTuB2mpqgCPS1Ee59Gi+cBJYO8CpCo7g0dtiAvquLKqxO7vaYmT3QYr?=
 =?us-ascii?Q?LIe++kAeQO86G5Z01Oggqv1Do801KRJt6lP1xszeo2kK658nL88gnJ8eFoX9?=
 =?us-ascii?Q?T3kpvoQEBtT0XevYaVm6iHQcSGeQu74RUpKR7g6tQ8gA7+cb9lQ7FLsAPP7K?=
 =?us-ascii?Q?Nkfcze5WPQRm4vfQ2MkoZHRPnGLyWi/AhdhH2nvZETP1FbQC23uxyZK3v4Ti?=
 =?us-ascii?Q?Fh/4EQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:50:44.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962db2a9-1089-4acf-2576-08de576a1fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

Add additional capabilities reporting.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
 include/uapi/linux/kfd_ioctl.h         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 27176b2dc714..8f8a0975f1a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1108,6 +1108,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 		device_info.num_xcc = NUM_XCC(pdd->dev->xcc_mask);
 		device_info.capability = topo_dev->node_props.capability;
 		device_info.debug_prop = topo_dev->node_props.debug_prop;
+		device_info.capability2 = topo_dev->node_props.capability2;
 
 		if (exception_clear_mask)
 			pdd->exception_status &= ~exception_clear_mask;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 047bcb1cc078..e72359370857 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -149,6 +149,8 @@ struct kfd_dbg_device_info_entry {
 	__u32 num_xcc;
 	__u32 capability;
 	__u32 debug_prop;
+	__u32 capability2;
+	__u32 pad;
 };
 
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
-- 
2.34.1

