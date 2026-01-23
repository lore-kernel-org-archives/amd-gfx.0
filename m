Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AAAD72369
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9AFB10EA8E;
	Fri, 23 Jan 2026 10:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ozXKAxyE";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD58110EA8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE4UERiO1clTmP686zKJuDV+Oktld8FyUKX7RhMurf96xqQloJRwwgcFt5UmtATozhglJJMWF/bpirjXaEc7IKs6ZGGXWRLfBpsGqZ6mi3Xuk3YuTzylEMGu0h6d0l+cDWquapshf1aOv1tlONjyHKXexfb+J6SPq9MMUwCAkSd7uGQF8GwjzneQPWAOferLwy1nlh3DtMsqSZL/voyppDmVpQR4VC3+37KHk9eeHa2hGSkkqMbHrlxUGYBsPZQFAcuWFWo+1R+kT0ncqfpZRw7IYmALtymXhfkb4U1zrl2+OLaERXHS6Q0QOEhUFE6MqOe1iX/MLLxXD5JMug1atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YY93lTwfx4SpH8elFxYDHyh3MzjQESaDyD4RLtBeM1Q=;
 b=vKvphDTNW2iXepuH2xKS+3Dlphl6HIsM0tlR0zdW/8WGwDKHwzNjtq1UIfb5GeZ/DWZnfgMqIFV+bKQolkTcpEx5zGvDNwwXueW4TvnNe7n/FW2ReDVbyoF8lIxOq3b5nOzaF98E8OOwFYs1H1uw0kzITzDm7xqLoIh3LdN195k2GcZhdxrzDREtkVQDmkzPgzJ7JW+VAomf2rx3HVAov58FvKI4eKWmsF07XBcbaZOhBBfG/V5yQZocw3+boBdzTcAOu5asKhmE3xBBAesP1x8cUi6JUwpe1YK7KQXGyP7ptdBCQGy8nGAus4Xa5V82hnwmy0J6rC4tWitVXPdWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY93lTwfx4SpH8elFxYDHyh3MzjQESaDyD4RLtBeM1Q=;
 b=ozXKAxyESaFpi0RnIQJ5+mXys2tN4kPsYpBXFlTCvEGyNnwqSct6SIuV3TO1C0fde8wrjgvZwKtLhGUGvlPcUg48Dn6NwFLL7w1nwIDStgSEU4wGec3QvTzphDm29Dj+2U9KO3Ti3ZEjiGXsOigi1RphiFhL775z0+15rz0ptVI=
Received: from MN2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:208:23e::22)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:11:06 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::7f) by MN2PR14CA0017.outlook.office365.com
 (2603:10b6:208:23e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:11:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:10:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 02:02:26 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:02:20 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add mqd_update callback to AMDGPU user queue
 interface
Date: Fri, 23 Jan 2026 18:01:19 +0800
Message-ID: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ccc0c4-ffd3-4635-be9f-08de5a67b860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W45szgDt3KtaLtp6PHie1FmVlYuCo6BHt0BEgpWRx2ekGejl2kt3lXACiimq?=
 =?us-ascii?Q?G9we4mqKbfno8FQ+okpVSOaAVKc7dmzha6ObHtuIZ2sDWMVNu7PsNM4MJETQ?=
 =?us-ascii?Q?tSu7WcBFA2tHWaaIzSTQFoiAsh18S8uwINHm3kVo29Tlov/rV/G7KJg4MUuz?=
 =?us-ascii?Q?TZABeSHe4HHTtaIV8zL96oPckjTpu6j7KwcEIl9SUPUgco8Y1lCLxwYgiR/k?=
 =?us-ascii?Q?znZFeljzju6zgP6FuEyZyS2LtTe+ZYcYRdTaw39h6frF4tUpKQKizMBGzy/M?=
 =?us-ascii?Q?qXX6gMW6HrjDMOLW7OTZg3xHI1W8v8ocpzXoVnMnuB7fdf3I6g+zzOFrDzzY?=
 =?us-ascii?Q?iSc71obFiRvaX0lcVbliw+SSk4i2AYTMURhBrP17WF+AWUg7zW3EwyIzFLdk?=
 =?us-ascii?Q?yXuDDe1DiPcfIakH7gg+Hhicj5qZZzx+pTZ2eI+473Lh96eyFRR/gU5ani6a?=
 =?us-ascii?Q?CklAOgENKQ5TRMeO5ahaRJBL06FUZrK6Biw/L3H2piqqPhv6+/3+60ChKf1Q?=
 =?us-ascii?Q?qm4bXRXCDrkFnC0Dm4dsbzJnhw0elln57eYC1Y9XVcr410j+TTxeim8HZOig?=
 =?us-ascii?Q?IUQ+ipXHaSlNoMKhAIRpcOVOO+uUOk3W7C9pKr3cnR+NbVCXvmd0NMJtUAqc?=
 =?us-ascii?Q?xaL/jN9rfDOAjvK0GKnP6iJodhrhCeGM0bsOlY/o/dP2UObOvx9h0CT5i76z?=
 =?us-ascii?Q?pPJh1OJ2X9nkP+Lp2SANkgr90U2JAQ78gMDNFieeB1RETvSEZIjV4DhQQmdk?=
 =?us-ascii?Q?PMvfSXjM7EuioIuW7YzHtDS0tqUusUGctMK8N5H+BARoLm6raGvdc/qNXYhp?=
 =?us-ascii?Q?T5y3ZXBsCy6Aw8sTFHG4dTjJHw3sixc7la2vKBXciXOAl8GPjD5toKGyREUF?=
 =?us-ascii?Q?1lnRUC3ZU9sI41EDypalldU/0xA6TjrWUcaN2ISpSr0o3AtKPR/WWbiZY1T0?=
 =?us-ascii?Q?NRASfibCVnmu8NZnG8W7ggGoFNTkLMbA0AktRu2mZrH34PRXsRIRU5hz5JLv?=
 =?us-ascii?Q?/epSBVUhfQ4ffwcJBuaELY4lTz26L7K1Tt+ihnCOOoqUUfKLmwGrVmwYxr1g?=
 =?us-ascii?Q?xP78eT/32bip2STEoFYTlv+XKxSbTb6pmoG/p/S2CJwXHL7jtaCVtkg1vNxo?=
 =?us-ascii?Q?0jKv1pkvTtSFl07HxSG5stikvK/wKDTcoU4TQPmusydbeFsFvHVhYll+03Xg?=
 =?us-ascii?Q?DkGHTamGuQ/9/v+kodgb5Hh/gZBzNu1dhkOVUHiNxcC2/FEnFKm3xEyZR/Xu?=
 =?us-ascii?Q?k0Z7o0M8Gdeqqe1IUsmZ06Rajo4stcoiGT/9EDVdp6DvbZv0v10m4IYd8Re3?=
 =?us-ascii?Q?Vz9aYndt5TDnjunlBKVvlcSJqBYMUoAjRWLbUyBaDCvLT3arV6nsVp5jUfUE?=
 =?us-ascii?Q?bTLxh4Y/Y7/A5/TFkSICzhtzRr7Shgk8jAi+px2MLnpm9nmHqERAmkKkPo9M?=
 =?us-ascii?Q?az9H0iRl19yckerWeCEDEAe1ny5pWGxYAA5G0BZ3J7q006YuNvj141h593Nm?=
 =?us-ascii?Q?dY8gzwi6yOPneTfJK6IloguYwKq7YnBEAKYuFLVnjuPb3ETd+yi1iMy87j17?=
 =?us-ascii?Q?aMSQDGYPCYePD3YbIjICZIY8Mm3Ikw52L2J7E59ZYn6SSom6ve+rkW3q1MKy?=
 =?us-ascii?Q?JYVwhvl7iZWNBlSi/wzyHtSR61pAvizvSBS7D086ukDRHj+JGfIQHXx3kS9H?=
 =?us-ascii?Q?WTlUKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:05.4306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ccc0c4-ffd3-4635-be9f-08de5a67b860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

Extend the AMDGPU user queue function interface to support MQD
updates by adding an mqd_update callback.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 95ace14e458c..c80d69368196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -79,6 +79,7 @@ struct amdgpu_usermode_queue {
 struct amdgpu_userq_funcs {
 	int (*mqd_create)(struct amdgpu_usermode_queue *queue,
 			  struct drm_amdgpu_userq_in *args);
+	int (*mqd_update)(struct amdgpu_usermode_queue *queue);
 	void (*mqd_destroy)(struct amdgpu_usermode_queue *uq);
 	int (*unmap)(struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_usermode_queue *queue);
-- 
2.49.0

