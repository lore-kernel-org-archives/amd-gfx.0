Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21636C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 18:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC7610EED1;
	Thu,  9 May 2024 18:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zDcoV5h6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223FE10EED1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 18:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrlo7z5IkA0sD/BkCAgbST2KlPDqHpWAzRJ9l09BegeNXQDmtRc6NCshNnPUNoPHPP54omyY2qECrB8gO611TcT7cmNAOPkCtxH9H4ww4N+CFdZjmAPcAvzh2xNFASsm9NWw45bisJ/Lwb8Ud1aLoC14+QhMbqbenyNZC/9O3k+eqIQW8ug+zY6Lxh98r2I0mydcUTGdoFPAucKOh6kTjJsdQ75kyE+6KG4627bjrdYIjtUNwoewAnanNtNvAb8UzzYOm6Vq7QbslAkpT4KVObWp7FinHbv7KLJFv/6WeRWzlPGG6el6a9pQFbTQOrS6O0ehzlVgyL+kGTwTG2qS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df3Ia4GjQJXwW4oFgToF3BaZMyhGw65yi9Zzan9LUZs=;
 b=lJ+8HDdhStxKuQ19lUaVT3tPs3p2iwSuOUz8gCjFklS/1xmAPIRwaZfP+nvdJXnlIbpOcFHFAd6Rs0tT2GNo34TtIIC2Vov61FZvg03OJA3CZR2EvWFHfoyON3Z8Qo8WL9aUCn1aphLZTTdS0TRTLxca8sREW8QagfxJQpYZV1jx9MJ0tmlmyHBzmOxa6RpSVudb5xTtX0I9o92jEc7fYRfTR0zMRB2eyUgYLa2TZ/T00JVXUUHkbGHHPMZJ0QN5XAqB7bNWES5ME4BQQeJat49lVLbw5YHO4ApILZuj6FiwM7IvDOKBbwFayIr93+77ycfCXH2nWUoXxyRrP94t2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df3Ia4GjQJXwW4oFgToF3BaZMyhGw65yi9Zzan9LUZs=;
 b=zDcoV5h6h6NbFiGal5ARsVWsSE87sB4o5v4yd9xG/mwZP5T+/CIZn6AmZQOTxt6bRmsXBJJRIjxySIT6YRZTvaWvyn9f+JqwNtH+/B6kKbAenNLh5Qp7L22c5HtQMKS6zbZ+2eq7dGDJaTU7CZMnlTslDlcKGH5Al9YU4glPnvg=
Received: from SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::25)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 18:40:53 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5a) by SA1P222CA0112.outlook.office365.com
 (2603:10b6:806:3c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 18:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 18:40:50 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 13:40:49 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
Date: Thu, 9 May 2024 14:40:32 -0400
Message-ID: <20240509184032.1463021-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef4ca14-1e02-491d-eb5a-08dc70578ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UOpcbFXVOHQSxKAPE23n3TzUSA9k3PjSnYMXHICImtFo4WFYVWJD5sG/K7Cy?=
 =?us-ascii?Q?TX5ZAK6DfRbbBTH3+ia1zX/SytC6vqXDMMYHKgWzKDcevY51w648lCDkxJll?=
 =?us-ascii?Q?ze81e77KDpCAyXNqtdZgqPQCAZo6IO3J2kcnKuSOovImui4ZMEBtWNmP/uf8?=
 =?us-ascii?Q?k3wuhrzmMtOOcR4tohZKtO+WjtTZDskljTYi0hwEI/RkpV8lt7d/MeFLSsgP?=
 =?us-ascii?Q?yZH4qMxQWIJoY8tyh6ouAr8PqzwMPbyhXWH2DeSd0xO+NYrRRCm+a5F4k2+5?=
 =?us-ascii?Q?pb0Zed/pGcvBytmV4/GU8+lp3nfYAYHHMCXiYWSI9uTsn3jmMHlu+2fbTg7u?=
 =?us-ascii?Q?qMd0k0Jsyo7lPU+XhsTxFQ2nDKVrLhxh/hZOU/BsfP1uUqJQfds0F6jmOs/+?=
 =?us-ascii?Q?8QvyuSXPmuyPV+z2VDEGD9bzhONhdLAd53Pxi0aWJcE8iR03WXWU3/pVhCRx?=
 =?us-ascii?Q?2D25xI0M9C2zWBE3eGUF6G2Tn15oRhgBTQYsRCDjE567e/2lgpqMtF7iRdIK?=
 =?us-ascii?Q?JlakIgPMI6zVPq/UPGlYVtTnWEBpLowth6UrR3xIhEGw+cUWnF78DW4kLj17?=
 =?us-ascii?Q?MhfjX1zxmjqAKh21+3ui3V+WEVv5y6x2OMTkzZ7hhNGjRrImnQFMv0sTpCAa?=
 =?us-ascii?Q?hueo9NaN7Eb6CZZsu38nEBhtEZVno/Z/FVAFo4YgKKq2mw4EZabemrTSjMBI?=
 =?us-ascii?Q?uGC5t7v9p4O8XDNxo0bDR0G6vtZtHQmg07niN/JrfK1TZZMUlg6iwTpdU8XW?=
 =?us-ascii?Q?KZCC5KKWZ2NIfYtue1jGigvkt6PQnNyIAf1gbi26AufBO4z6BdEFzEQ4TSrp?=
 =?us-ascii?Q?AyZPk/UeW5CuhUWOl7t0KcQQxR+82pH8mha/IBuQgwllqf4LnugH9AdNQvsz?=
 =?us-ascii?Q?UuM397/MRxBTYJOuIEdurfB3kegd9T6jsWxzTZCraAqBAc0bCjowy57mcqtD?=
 =?us-ascii?Q?fVAP3jJ4i5JL8jso0C2ERRTdGFUJW6uTXXipT9RcKwNTNUdx4o3LyYKbudJy?=
 =?us-ascii?Q?C3AjY04jJoAxC/JsLrD16GLI6wlT1636UzKfB3DTR1G1udUQVkRuCk9D2V/v?=
 =?us-ascii?Q?wpP2i/DIMbB159somTv/lKTBTmyN4RQaWMPldIgIXC2ubMjw/ewxY//9a0dW?=
 =?us-ascii?Q?n6JDT1Dw5GeIIAfmgQ1NynwjQgdyN1wUuTSER96gU7oV8h8xviLAjjPYHiH/?=
 =?us-ascii?Q?Sk3mnXyDC2gazYddoFedJqnZV56Iuqjm6XkTfY1oCuXr51360ixZwJ5U80Tl?=
 =?us-ascii?Q?3Axyn8WnOA8+tfecJJLMNm2kGOfctGWCAJsIrK3WTtZvOBFmPJm995GVliMZ?=
 =?us-ascii?Q?w1I9XJg8ua5cOTIEKVJVC49nOIx4t6soD6MmgVudA3UE8akOTk0NZCYTqV8O?=
 =?us-ascii?Q?YOmQuCI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 18:40:50.3136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef4ca14-1e02-491d-eb5a-08dc70578ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

We do not directly enable/disable VCN IRQ in vcn 5.0.0.
And we do not handle the IRQ state as well. So the calls to
disable IRQ and set state are removed. This effectively gets
rid of the warining of
      "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
in amdgpu_irq_put().

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 851975b5ce29..9b87d6a49b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-
-		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
 	}
 
 	return 0;
@@ -1226,22 +1224,6 @@ static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
 	return ret;
 }
 
-/**
- * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
- *
- * @adev: amdgpu_device pointer
- * @source: interrupt sources
- * @type: interrupt types
- * @state: interrupt states
- *
- * Set VCN block interrupt state
- */
-static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
-	unsigned type, enum amdgpu_interrupt_state state)
-{
-	return 0;
-}
-
 /**
  * vcn_v5_0_0_process_interrupt - process VCN block interrupt
  *
@@ -1287,7 +1269,6 @@ static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
 }
 
 static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
-	.set = vcn_v5_0_0_set_interrupt_state,
 	.process = vcn_v5_0_0_process_interrupt,
 };
 
-- 
2.34.1

