Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840DFC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF8410E430;
	Mon,  4 Aug 2025 11:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvtuBqOh";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4300810E430
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd7ugj66exYmcWTXsV2oXCIOHQ7NgUXGnXqUSdzIK87vpSx37HXh6FlcHkxlzBz2BzRFM6ThkxsDrvRWTB+hqGvEBlF478jqRrRpZwVuBy+5fXkfqkMrNdLGtDEbA9GYj7VcbPFV1PZBwSOIZevjTj4iY2j6F7k9G4JzBC3nUXa+SFx0vf2KCWGJgPgRazITfzHiL1uCDBfuYIdb1uC55mwXGxF3ef61236i98qqnvRm6Y/izYbBinkgWGQ80v1lvbKHVOKiEIAlbclimFaUWxxu+IScZsgdJc+0qFzE7+7EtX+T8FJ3Wg+iQGkngV+k4AvtuoXhy4rvbPieCAgZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr9QMnEO4RbrdwUjhEeNwby5icZyhHjNl/IbMPA8G+E=;
 b=TpK6A3v2TLIXPqNzjsLrGX3/8IyhSR1EOsRM0GIOVhYFwTIWY4UMctobcq7qB62ybW5LrlWhIFbyM2JSYqcqcoarg3jKXj3kSuE/kgR4nSJa4IB1v0d3aSObrTkEfzW1z9Kifde9s68K0PtARZsD9D6ounkIiaVI2C1ao7CxaK4rx12Xme6ip4BuUhslcDgz0ehjhQvQSXaDtswEbaEFjZmjE/HK4ylerkEZWAqAHMlibUe7NIpBvr/BSv6l3pSCbT7nlTn1suMoMTqL1kwgTUaMXadhF9+TUwlEiiBhcrnOFjcQDllYQwIqX0OFuvLeHdUmLXS0q6Gkv+W4+K4pRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr9QMnEO4RbrdwUjhEeNwby5icZyhHjNl/IbMPA8G+E=;
 b=ZvtuBqOhW99oyTFT+Sb/suFi3qJMyh6QzVxx3Ip2JvnKnDW8DIPKQkHYD2mYMmVVdLMGFZx1gNRSKAUnfMwNdzEqJS1+618rIPLJcXjdaq/pOCjY21LYQ0b016shIHTf72jrjV6rU01WZo4OfpSZjDqWjPyjdgYMOrz3EoaYz4I=
Received: from MW4PR03CA0359.namprd03.prod.outlook.com (2603:10b6:303:dc::34)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Mon, 4 Aug 2025 11:06:30 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::83) by MW4PR03CA0359.outlook.office365.com
 (2603:10b6:303:dc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 11:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:29 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:27 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 01/13] amdkfd: enlarge the hashtable of kfd_process
Date: Mon, 4 Aug 2025 19:05:38 +0800
Message-ID: <20250804110550.261311-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bca3afa-cef4-41c3-172f-08ddd346f6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1/6mIRk8idhmO+1lmJzIDp5eEpAYJAQrP+OlC7705R8XnsY3Qnxy/TdRA5L1?=
 =?us-ascii?Q?+apEUgG4JdIodxTsrlu2tB0ie41byneN37SByf9OOod+MCZaEoaGTPNI0vYl?=
 =?us-ascii?Q?du5USLyK8nqHqCtgSk3Kl1tIt5ucfTRTXu+btCSjfMXac+Vy2r5CdXIacsVB?=
 =?us-ascii?Q?6R4RRgFQmxiNuyuUhD0v4/zKEqtnKyhNBH1EH5xOTFpRgKb1LS5PqRmNENYG?=
 =?us-ascii?Q?xPnSmaxwlChbq0vRjD4xWOC1eM8LE++lJewXW5IKDgsIr+XiOZNmeavdAu4P?=
 =?us-ascii?Q?/zfEGjy37a2wdtGpje7vvmTYERNEOAoLAP4opfKTJF6O/YW+LOFdLPfjwSBO?=
 =?us-ascii?Q?znhUUE6nyNwCC+0V6ULdwq0E4lpR89uFV7f8btjQf0My6FMdPrJqsUBmeZ6Q?=
 =?us-ascii?Q?/sMhJa+nXTLDYIQGleOWXrkOVnn1xcgB9/HxfCsHYllBEUdIqtDZ9AAbpW+/?=
 =?us-ascii?Q?l0OYk9xoakHMgtW3+2TQ1iuxXXTS65/fVAKaBOq2enDe7Eru9fDpdON+PdcL?=
 =?us-ascii?Q?TgdVFzvpV3CSZAB5/w4ff2qgEnIC3gUqmMFlEMGmCP/q4u1kkSos6R8fC26u?=
 =?us-ascii?Q?hewNa8maNZ1WExCb0vXbg4kUORTYmpNu6MN0N+KDDuDeG9UoeSVkTvWDQFGk?=
 =?us-ascii?Q?w/pPpzwWMLJoGtyNo92sr09LJaL2xqut1FcQohIqdN7WfPnWTTidV8qBi/Up?=
 =?us-ascii?Q?IgyfiUZnkz7ODTWR8U/afiwKjrnwT7gdbUBeUDoLLejlzXUQF2LiK4UH71ti?=
 =?us-ascii?Q?JkaQ99RwfD0ph7SAGvceu2DmOTVCVds4G4bZ0FvO2+KUwLCWoQokDXhn5gEw?=
 =?us-ascii?Q?QC2yjF9qzIYyOgd4DzmI/5e/ACQAa0/LGUBzJvd7ie2ZqTJoHuHJSebrWv/r?=
 =?us-ascii?Q?x//HdvyOVI01jVWqzo4EZEYbdpzlfk5ds9i+UsnwT7intP9tT+nMbD356/tL?=
 =?us-ascii?Q?StSp2y4XPsLKjud6YgUObQIFVtztkl44wKfW0TpPMOSKvXNCYv4EVX4RSSFx?=
 =?us-ascii?Q?g0zwjU+gZMWeHr+fuQ5Jc44a5Iu9pnm3kVoU9f/CUv7EO9hufDZosraGYm95?=
 =?us-ascii?Q?wT3B9Zj+304yuStF4A5wVKOCV3llE3SwCxE0joFA0e/nGPsHwzssXFW35m+4?=
 =?us-ascii?Q?rfNoI5A0LoWOF5Q3MgOXCweVyuXA48BvEm7w/SFXD4kCt8BLokruGZU1zSev?=
 =?us-ascii?Q?d1teT3txB5POPn5aWsN5/KjUOLooSuxcVu/BccrC7Re3V2oEIo+Vs44bT05+?=
 =?us-ascii?Q?wXP1Vg2MCRJxqbMRReUEisG1nOe6pyOPyVH92f4OIULYgyl8BQ8cORZeEg9T?=
 =?us-ascii?Q?mba8L5VeiC8h6bTIae4bZNO1dp906H0djHeGwMcQv+qce+Lps1XqpSGEUux1?=
 =?us-ascii?Q?QqZAluXRmGZsXmzl0uXvzegUURRjg1w2sG9RY6ViV3zM8dcNooDFC2ay8m/B?=
 =?us-ascii?Q?U0kc54p8hpUxht9inS40AANNRclyr/KIvW9+q/YMtOyH7h5REJx/lXNzCb0K?=
 =?us-ascii?Q?fKsv+Qc7XPGUU26uNU7JGG7g8XiN4Auk7to9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:29.6682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bca3afa-cef4-41c3-172f-08ddd346f6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

This commit enlarges the hashtable size of
kfd_process to 256, because of the multiple
contexts feature allowing each application
create multiple kfd_processes

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67694bcd9464..8a33e6ee6369 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1011,7 +1011,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.47.1

