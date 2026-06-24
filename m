Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE84CDE002
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 13:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7107210E0A1;
	Wed, 24 Jun 2026 13:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h5f5Vhma";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D58D10E0A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 13:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atk5LKUyz7/3Ud9QKek5Mgdk+5CQIdeF1PvrSoLnot+5SZslf4o7fPtEvZygA1x32yr84y/pyaUUvBbDf4dVywyQD3+WP/lkQmm7O8XpsI2at+sV7iXrAL3ekzCj3Tr8NbqF80pjUyTIJ6sQENgRaOIBLtyp42PZiYbhXtzVE61SpONnFM8It7K6Q7dcVaLFIwGRUP8Un9/gC9yf/tTrbrWQPDKnfqqShfFh2YF/C4QWxm764QVjwuYmMvocFuWr48ggeNnXKytkUm+00nsAHVNRLQBHlg6hpilKaRRyInYus18MgGbfJR+BgvVuloZWDO3K2avQOqDYGato2vY8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTwSghvH87WG3swwXcPDEoX0g55ifvJrhp2jaW5E3FQ=;
 b=uclmnEfCwNCC0dce1axLzkNOzKBfUNJf7GoY1hJmMkRnnw/4NFDfCrtMQ0vrg1C0Ke+8oM1zfB5pqa5hqTAl49WttStPZavB31x3dUe4C64xyL90vzbgEbLEwsya5SxOXhLxmhrMdcIunuwtrxvE/PmHle8r0rfXfF/2nGyZ8uZMLMcGGusTLlJrrYBuYPk2olG54UFWISHY9cqYUZbFlOMAsCd4OvaSpOY5S8z5jvxbueCoEE+oM+0lNflLuO/FBaYau1m3+5ZdEiFG5k1MesqtsuaGLLQAwJXcPODKaD7a78PNd+NV2gUdiBuBPI2bVAbKWWIS3eKtFAFu/sUj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTwSghvH87WG3swwXcPDEoX0g55ifvJrhp2jaW5E3FQ=;
 b=h5f5VhmaU5tbre26S0sGuDG2C8cs7nnjKAjkYxYm0O+V7e0d6wdiEZiaVem8l5LeOVNcowXkBV84q79RuLtlAzmI3D/ojs/pAw5zns8jnlI/lHmd335uohhjGz9nWGBrXzA07I2ubpgxxNg54RTwbMILdi6OXVoQEDXbKy1SbNM=
Received: from BN9PR03CA0923.namprd03.prod.outlook.com (2603:10b6:408:107::28)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.15; Wed, 24 Jun 2026 13:48:54 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::9f) by BN9PR03CA0923.outlook.office365.com
 (2603:10b6:408:107::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 13:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:48:53 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 08:48:40 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kent.Russell@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v3] drm/amdkfd: Check bounds on CRIU restore event id
Date: Wed, 24 Jun 2026 09:48:22 -0400
Message-ID: <20260624134822.1646363-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aab3f3b-153f-4db8-8117-08ded1f7546e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u7wrYfqjnIlpxC6vq9qTnyIztXyLsMUCMhxzQ3aC//a4gm3A+vB62ljJrvHQZNf1YcLS2o+j8F5hLXRjRjx/DwcINpgsVYXdxRclHoPMyXftI65ZJHDJ+twqNv8hSq5xHFj5YaTvwt/WFMB8uK2PTdofVTVMbw8yhL4Eo3TPInO6wUMTOcFmEkb6IK2sroPHalL9V2nA/J17tWCUvSE1LiqzLy3wysp9L4UMUL/DQuE+fHxAl+58QL4YP5OKpW+HJLk38SVDEQ9BQCkVaajJMsjmPUSW9rhE83d2i/XkkmMvKXMegj2VzwviVS9KxqOdPhPfks7TjMo2q1Nm5BqTFUUi1kS+eUc3X3YesqBQw48wsUWzU+V0vWsN9aSSMos1m7GRCcIIJaUSRYF2K98e1+OmWR/MXNYAxOLIlFbXys7U/0+jO7H+GxEnJh9dCBEnHhyrfRzEXT7sjFEOA6lm1+STR0hIbF2tBUPXr4fhBkpo+LFwBVkC1RzbaMIf5X4ceX8ZQ78KlKtKlkgp/O7yQ9URg9w2cj1GuXxaRhvCyW8vlncO1mVMJ4h3Yl0rcvoX6nftIRRFGhFjHcvg6fYwH8CImNAQvfZCoEGFS0wlsHzfyauQg6ep9cYDvpwZkrunRBPO6GtKOazML8OS8d0WUWz32kAD7AhXp5DkDL16QYXNeWk9M4oxNvS/+agHRy1wMdZca80v6fojfiTG9QGXnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z9wVo9kkotZQUCDiU2gp/aXDE4k9oagVtwxqcV3UuNtExdGMXtHl1tBH8VfEXm3fxIPVjyoGR1xLR+BWC3l5pUtLDro0jONht5TpgQGK2L+LYQQW2oagJwifj6zRev28nl33ImCc0p8NXPjfaj3ZHp0VUX6Lh7Nx15rTx5PEObyebPAwg59+gYBl072pKz/7vJlTKZC8qhqWuCrxVPN714m5MlU5+E1A2nVmrl3Uh8jwjBLF0gGdc2eU/R7ZvkSWmvATdXKrRXA9iuBwWJ4Thd8s3YGHnKQn+5Nk348uQU1f9zC5TPANKJMZenQgbtbpwPSIBsD+Lzzj+qH/+tOpe+9mc/yvGy7UXrCJYUFlX4FzxFZklbGVlBEjTWKp19XJQrYGumml/AHp3fpIoNlC57dtCnCqlcBXKDPbjIrcH9NprxdScSZX83y6zzmisMpO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:48:53.6412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aab3f3b-153f-4db8-8117-08ded1f7546e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

The valid amdkfd event ids go from 0 to KFD_SIGNAL_EVENT_LIMIT - 1.

During CRIU restore, ensure that the provided event ids are
in that range.

v2: No need for lower bound check since idr_alloc rejects negative
inputs

v3: Also change error message to reflect new error condition

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..52347726c6b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 	}
 
 	if (restore_id) {
+		if (*restore_id >= KFD_SIGNAL_EVENT_LIMIT)
+			return -EINVAL;
+
 		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
 				GFP_KERNEL);
 	} else {
@@ -204,7 +207,7 @@ static int create_signal_event(struct file *devkfd, struct kfd_process *p,
 
 	ret = allocate_event_notification_slot(p, ev, restore_id);
 	if (ret) {
-		pr_warn("Signal event wasn't created because out of kernel memory\n");
+		pr_warn("Failed to create signal event notification slot\n");
 		return ret;
 	}
 
-- 
2.34.1

