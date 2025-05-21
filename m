Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342DCC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E2710E6F3;
	Wed, 21 May 2025 09:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F8xfmwFZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B422F10E701
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6kb4vD3DPBzqDBxWd3cYw10kwzunOCZZ+n2mfjmV8OPf++ctaCnTrZHra+5TLpJc+WI/FtwBIJoFeophBxvjfupbWhXEcASFxpdqecQUOk0DOtC4RfjhKuH251129HPPPyEYOzK7Ii/2FAAQzI84IluDGy8gnp8fdVjl+iABqsr8c+FemezWsPDvU7d1QndiHFehYxVsKC/E+aEQp6lfSb6YHRrp8blFeXsiwVQOoJOAdTx78LDkFPhCwvbMLZNPShvUXv47Scd3Oqy0Sg23ICJTbIXfyL0xRvN+mR/GYSFSY2p/Fos4TgNvBYYFDyHarffcJjp5dtlCRhmu+n39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV+5Rz2pajqi07/wANg3sYt1RDAhrL7P/XHI5bAP6TQ=;
 b=I8v1EJgh5DbCLF8ZpnQwfgx6PR4uuuDr9lnKgXMj0NpxIjkWtnzMle0OoRmXh2bvyCxylFMDKQyC3+YkF5eKjyUdFkG+77whZZmVxscqMwLIq2+Shm77gRABKVPSZ0BL3Wngy5E85hP8Jgh3G2KC/7MYlhtPg60NpwW++1Hrf9ZHUXoHY7YSeW9WLrvrKOzQZ/tU5bhGmNWN3OBTU5xFy4QmfuZt7YKlOao0PjBBkg+7lEanRJBpwsXtFbwyPhrMlCLX/vAggtoH2hjEYqyeM8aqPmfLrAyKUQxV1MM+zXSE85Pjd0wYcRY+Y5OllIJbewpXHIxlOJlSfoRoEwXQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV+5Rz2pajqi07/wANg3sYt1RDAhrL7P/XHI5bAP6TQ=;
 b=F8xfmwFZoOP2YY1kgg0YTjxpPoDKnIW6KoEaY8dvKUkkCb54xypKAkMlkKQ0GYTkJQCKsmWjM5qnERNMcf0abBNtpipGb+d1Pj+056J/y9vSecXM20o3yot0+e+ZdhTREwehxm/vwyBzNAxr3hxh2jsaWpGUzKkmwfg04X5U1/U=
Received: from BN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:ee::13)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 09:50:04 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::f5) by BN0PR04CA0008.outlook.office365.com
 (2603:10b6:408:ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 21 May 2025 09:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Wed, 21 May 2025 09:50:04 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:50:03 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 3/7] drm/amdgpu: always keep the latest coredump
Date: Wed, 21 May 2025 11:49:05 +0200
Message-ID: <20250521094912.6714-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca26632-df66-4861-ce61-08dd984cdcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t5HlmR8peHNMCEDaxDAiqCziPFWLes+J+S6X+O0pcifYMT5d4PinWT1rzDD6?=
 =?us-ascii?Q?veCyZRcu8HacMCOMcmRtAi5EjEJdLvOUMFT/JWTlB5Zfa1JRWS1/VJ4KWwEc?=
 =?us-ascii?Q?WNjt+xUatTjp2NZFq3w1ICw25VoUcJx+zw1U4Mjua2IRQkymDhoCI3fczgwA?=
 =?us-ascii?Q?8qejQHTZYuesFsRXqDu7hMutdPXXDkkhfg/riiG2ohZNArU4+YZ4BGmC5ul6?=
 =?us-ascii?Q?6ngAYW86rE4R6bjreO54OWAXAAVFikJrjRipYOHUS2kd8xAROvDZXXmvS0D6?=
 =?us-ascii?Q?OOUXVsAC/XPbtQhfK3ZGKy90nIhPVU85QQKey0eTxZYZZ7HCY0POQMK9yJLr?=
 =?us-ascii?Q?I4XeXXqtlt0HRFg5wgwjnQ45EZBFwuJ+5UkWFa+v2fMU0k9/q3pkHhX4EHUw?=
 =?us-ascii?Q?wqpkFG73jAV7s5wsPrNzNqxh+NuIdh42i1dj3OcN/YN+nObfnDxS1Gbpjq3x?=
 =?us-ascii?Q?1AxjR+OxcCLMJm7e73elWdNgaA+nGr9ecCckhuifWBDiVXV2qD8ttqFmh+Yd?=
 =?us-ascii?Q?faQVMLGDbuEpKnAyNQx80SVPbWZsUJm+TcSSwDAphBCNUDypxt6Quxj4oxu4?=
 =?us-ascii?Q?cRFh4YYP45Sq/FfuVzSh5QhMGBsCUECVUcD/z0RpQ3fotKuWvM7PV9Zc1PJ6?=
 =?us-ascii?Q?9qxry+t/5CBblDN0f9CTGoU0RMMHxvcpoMsNLvdYjHVF/+WQsgnTzm6LXpZH?=
 =?us-ascii?Q?WKs7cE+jOVjTzEIofAEAx9DTf7C3/Xqv4vM7ZZgfhLBd5io3GMSCt1r/Hro7?=
 =?us-ascii?Q?km234AmkzKl9rPU+h6Qnha+flHxQHTo7dMK1s2q32ZDZaaQ5huOaaNmep1Am?=
 =?us-ascii?Q?fjXTu74MxTwEG7vNKtqwH/4372S8sCkT7bhz+PF+AwldnejlQvZxLdc/qC0N?=
 =?us-ascii?Q?HqCb/m2lcXLVV3mnbzA1RR8FVujDJ5snQCHmgov8l2MmYrSB7h8fgX4FxlYs?=
 =?us-ascii?Q?Jk+0wDv13j6WRQ1Q/rKUEqJh27bGH/rDkbzkRUH/ZZDTv1GqlpXsiEaRLZw3?=
 =?us-ascii?Q?QyugyU4+YssiDIOc00km7yIstLJ53St7slo71wGALv4LKH20Km+EufQtX2yS?=
 =?us-ascii?Q?dMp3HJclyZAQJcEfD2TdfS7CaoE2V01yx+r3vFc6NTIzml+O4T2oSyVgkT+X?=
 =?us-ascii?Q?IntVkfnX6jr/h1Hx7iKkaldGIa1vz4qJjuOtPrLaYpiGm6uxV1KT/KwmDqwK?=
 =?us-ascii?Q?pt6RYCNq1wNAo7xE8u0Np2iMBQLIepOSDiNYrJ0HB7J7LWsJ82PAbxU7UN9b?=
 =?us-ascii?Q?w1cXuVfGv1FcjSDSc53NsGg9CFTu0zB8xORFXouQdtvUEsUKMwTPaechpnWA?=
 =?us-ascii?Q?cvDWIQSEjk47y3JD/zQGE2WF2HPUPLdYZER5ABbzkvnidkSIDA2rqwYWdKEU?=
 =?us-ascii?Q?AbrumAuQDqNwnl5ds5FOx+tHet8Xo2YEkVlrQqLdGnUnDdA+rC2RkAMtZsxz?=
 =?us-ascii?Q?WYf6OZ8y8x0rbj9VhEIkiLhSok8bRLIz1CoWdDwlYnXGPdI23qGAnuKQupsu?=
 =?us-ascii?Q?8io1U61ZQE3ohTdJVgzM/ZBNOrTQ3xh7/QVC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:50:04.5219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca26632-df66-4861-ce61-08dd984cdcc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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

Coredumps are automatically removed after 5 minutes, but if a new one
is created while one exists already, the new one is discarded silently.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 6fa53e070b50..1dfc5473d2ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -400,6 +400,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	ktime_get_ts64(&coredump->reset_time);
 
+	/* Delete the previous coredump if any, otherwise dev_coredumpm will fail silently
+	 * and the older one will be kept.
+	 */
+	dev_coredump_put(dev->dev);
+
 	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
 
-- 
2.43.0

