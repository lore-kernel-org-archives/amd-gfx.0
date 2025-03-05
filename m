Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B49C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C489610E6D4;
	Wed,  5 Mar 2025 05:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K+ixqSQH";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6B710E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccmO1tOU9hBXCy3ydo5ZPimeOiCRs6N9F16XH534uKEW3h4eosUWuJF5RB0J0AIE6FppYSM+Ww+AiSt8UHCY3VgYwwn7k8YSTxqgSeEuTMj9Iv/BCniA6ZVUOvzXzlkxuG3Pe2GLgeUfXW6fXH/DoHzEqI5LYqfhUfVTgNCdW/0Lhl9TH7fXpCLb4wNANstwLENAb9DHn++wxvJ5Hjb39S6nSaD0E6uW6t/r1nbz4VMZTXOJMTpLJCrxxcm5mvAQJK3o9qkp3v7+8xwqvVO0dzVNPGh+AiQoADfOGfmdJxM4QBDeHLaBb7FAzbeVEfxV1xsD7vidRAoHkkXDPDo6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvM2818O+sQtj0q8wlY2m00311jKEJB1uo7Q81Vvjmg=;
 b=iBjel/7M/PiWLU4wYIr/xe7U4WIw1GcBlz4CIqHRG1QI9SmrXkrIu4gM5MH6GfC0ybbSWOwyAu99X5DM6Bcgg2BKqo3+ZlPcZvDi8R1yRk/yb8krcQjrMPQ7HlyFFnOs0RclfG6o0t1ELs0F6rrCBib24hQBiqHmu4q5TWq51yeD/VnuMfjAkds/77bbcsEPtOpOqLSK59ciB1qS+V6Pvx9Cuo9TRovA1SyXTxnipDnqpZXvA5ZcCqCx16wJqP1W/WCnCSZA9YLGFe4O7GnFdlCriMq6Gw6/T/Q62FcW/AWzQSk4MQZorP0qemKHRgAVLB4HhWi/KxwzVnY2ZiyboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvM2818O+sQtj0q8wlY2m00311jKEJB1uo7Q81Vvjmg=;
 b=K+ixqSQHU2pm9ws4Zvzw/pUz8TAxxpKk5BXjh7lj5GTdrMywAvVf8D0O1O95LsblYLup4tlDlV2E+GRrXqVTMMu2Q2NzT+QHBu8M9cOOcf3hYDXRI0VcAcsSEpceBZ5hnhJmYGzR8dN3SVkUMET8UueeJ52ZC7OSAMvOylfEkxI=
Received: from BY5PR20CA0025.namprd20.prod.outlook.com (2603:10b6:a03:1f4::38)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:43:45 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::98) by BY5PR20CA0025.outlook.office365.com
 (2603:10b6:a03:1f4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:43:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:43:42 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:43:40 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Felix.Kuehling@amd.com>
CC: <haijun.chang@amd.com>, <Horace.Chen@amd.com>, <zhenguo.yin@amd.com>,
 Yifan Zha <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amd/amdkfd: Evict all queues even HWS remove queue failed
Date: Wed, 5 Mar 2025 13:42:16 +0800
Message-ID: <20250305054215.566473-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Yifan.Zha@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ee9a24-f183-4f36-59b6-08dd5ba8b0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?thfwfrXfYoz84k6IJMuvvp2Uj09GBTAxm9bkX6Y7sX17VRkvCyU+YSYEv7Q+?=
 =?us-ascii?Q?FAAfOrNI4Vu7rELCGIqyI3v2vf78VIg9wGf+pcKIeTVN+Dyd4FlgXVudWUpC?=
 =?us-ascii?Q?dHyFq+ELNfO2KnCRMQCgkvdDMG97gmPvFvaSH+JJPC8h0B82DGR9M+tZPhga?=
 =?us-ascii?Q?bYAwTck3cwwUOSesNIUieUkmZ9mignxfYbygbmTGgSAVo2Q/1CHdh7p9aZO4?=
 =?us-ascii?Q?J9/0faMeIf26GzqTSsgGfpRO2KGe0zVcssE93kIjq/g3tcSh6kL4ghsnb6Z1?=
 =?us-ascii?Q?VTOl4pybVmfyOnBX4sCh59MA5kSE3S2wntuKYhcG/dxWtJ8FBwXo5BHXct0W?=
 =?us-ascii?Q?iNSLRDYiMHs6aPNcZ0OOzlcT+hq47lcEcEtE6YkYP5uHetiRNWe2ke8Qt8zM?=
 =?us-ascii?Q?ycvuX4xE8iNTQhCBSSPpbcSK/8DImwNAeH/6nlbMVOowklCV/bIScmxaqwf9?=
 =?us-ascii?Q?YIiaViW1TD9elfTWZHNVbTJujUupgkN72negbZWrlEYcl3VuG1uuE0RAZmR/?=
 =?us-ascii?Q?1sEqqFtAYGfyNnuR318EXSGL514zfkEO/VLB1vTih3AWO7TyE/Ut2wu1u2jL?=
 =?us-ascii?Q?h+4Z+OBG4IXqm/r7znyukBjSxOvY7wb12hAvhXCt1ciD0tbDQxYvbll8+jW3?=
 =?us-ascii?Q?jS9anXFX1gUfvCuD8qNbKHjbrRdZofb6gw1UqHzkd6VTz3QqwTa19MovIMcL?=
 =?us-ascii?Q?BkoztyzESVpM6MgwHsfTbgP+XWhc4JGlopHBk5WyeSwo1xLcBkqBWZhD6zP0?=
 =?us-ascii?Q?QM/VfUNYOl8G/0wjdvdr83w11scqs/z/di+zKUW+Uf4ey/ANyrIcHFgkbrbT?=
 =?us-ascii?Q?wdIbx9c1tsI40LWsHOj0N9wpVmr3px5EWtOjNIyzTO5Hsfqlk7mGoJq4OgGm?=
 =?us-ascii?Q?OT8BhQNXNPTXR7NunXw6cscVpCDvN5rZYHLW94RXwfwM3DS+fcLZChv1JGw8?=
 =?us-ascii?Q?i41IRYvxsxcALVJLqkUHOKk4KJU/kWTKh0P1PShgLtrS7/Ffl/D2bk9SEeLx?=
 =?us-ascii?Q?VVYbEVNz3Vl671PSPLUtP0OM4aWuc3x7qIfRU2+tKA0H1ymJDd/rIg4J493d?=
 =?us-ascii?Q?BmMkvroOHpkVwnX/EHMKH/U81zseOcYch9sqhjhQRh+8humkczhL7aLavIgS?=
 =?us-ascii?Q?rkCPY8JxTEb3Ej5cE/3u2IlvHL4xEoVTEDNFui5aJPcogSCXwSL3XD9Lxj5e?=
 =?us-ascii?Q?NFF31XxCLbIgohmC0xvFKBgMXxdQQe4T29bEpH31nXPhwNNu/2b00k9qnnEg?=
 =?us-ascii?Q?ecub4nZacbM8rPG2yPZ60nT2eTb4Jku1ymcaTRqUFV4CbUxxO7jMfXMq6m2p?=
 =?us-ascii?Q?tcgc/MHj8Zdqh379rVvR6a5unkLkv7xRtiE6wldHG6GwUhgnCDvv6dPwA/ZU?=
 =?us-ascii?Q?ftoQb4i22ORBsMtmRFZW5E6nM6TF5okupsnof79l34rg+yuPRYALXZOKeZup?=
 =?us-ascii?Q?wVXtCXiP/gTcQ4JgAhu3LFundwSDXABbARHE13EIL2Rx6DHbPWWEaauaon0V?=
 =?us-ascii?Q?DjKBkIHqWndZsR0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:43:43.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ee9a24-f183-4f36-59b6-08dd5ba8b0f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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

[Why]
If reset is detected and kfd need to evict working queues, HWS moving queue will be failed.
Then remaining queues are not evicted and in active state.

After reset done, kfd uses HWS to termination remaining activated queues but HWS is resetted.
So remove queue will be failed again.

[How]
Keep removing all queues even if HWS returns failed.
It will not affect cpsch as it checks reset_domain->sem.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f3f2fd6ee65c..b213a845bd5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1223,7 +1223,6 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			if (retval) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				goto out;
 			}
 		}
 	}
-- 
2.25.1

