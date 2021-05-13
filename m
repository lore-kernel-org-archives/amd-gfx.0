Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EBDC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 07:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AE061406
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 07:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AE061406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CF06E842;
	Thu, 13 May 2021 07:48:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582236E842
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 07:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBd24+gAOH3co0g6ThPmIssaqeS/X/dnVyKDr5iqwPF4YftZok3fQSuSMyUTw+6Ugo5x/L1xjysdySHIiUhluCeRn5JF1KYR/hUVlfYYLQlwfYFXwocMcoxQPFNof4XMRgnbS10pOHKuD7tX/IEFzAga05h/W0BiFU7I5dODTUw64/4FKLHuVf90odE0iqtaJJcdUjq/mwZpgkw+xUW9QITbRE31YnCSQN6H+i2Ru+Tt1KgnI3ssv+b9ZTAhWv/JYJtkvDkZhGAPIDJ5onuHq6SlflxSDpck528AmJskpg6XYVH/qS50YpCfONuqdyikiliLOJ3fdrN8CwwIiP0FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ZMGsCtHdnjlGlaqbPjXQ0aQMPX0xkzB9hV0S0Kxqo=;
 b=IR314zQJyr0eaAyx0+hWPCX5GrJcq77o2dBfF2YZd+eisjgqjo16AtdhPRMXtmLDgztfI/E0EDs+/oDnRMYmgnEUv1hlITTADxCMScEKlVAJZU7eSKG44Kk5oQgbpWiUCoft2yQ6YMuXCukTkObqEWnrc2r3ulkf/BVQQx/1FlzNDPHFJWlvqxim49rzec3q6/ghCcR5xAdqZTEA6dzmnH2lz7nVnzHMPgIHBm0w1NMMAFtO4UdAM6VvgH+a7+xQm4TAY0ycr4uzBquGhumC7E0+HXXkQOUjvO2ov4kRRjaDTS9uiaFtAePCVRqxh6tTbvVlkSocLerc+ZqvIsDjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ZMGsCtHdnjlGlaqbPjXQ0aQMPX0xkzB9hV0S0Kxqo=;
 b=p6fV+K8dsmgCrbnJTV1130bbKw0DHwCJBD34QyvD8P8Ch78rrDj280+F42dp3+/uPXLqCHdjUtY8pf0VLGgY365KCIZxeS0Rvqx4mDgq7yWLTDWndzQMaphL/FVgqVurA6GxYOZunOHKe1wpcI5krZwieZmNHjCLN3KXpTYxOks=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 07:48:54 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 07:48:54 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: disable kfd debugfs node of hang_hws on vf mode
Date: Thu, 13 May 2021 15:46:43 +0800
Message-Id: <20210513074643.476-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To CO6PR12MB5473.namprd12.prod.outlook.com
 (2603:10b6:303:13e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (165.204.134.251) by
 HK2PR02CA0179.apcprd02.prod.outlook.com (2603:1096:201:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 13 May 2021 07:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d17c77-b6c2-4b5b-282c-08d915e38e4b
X-MS-TrafficTypeDiagnostic: CO6PR12MB5491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54912CB59EA6B62847BE917DA2519@CO6PR12MB5491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjne6sY+t58cRmrH/lzUvIHoO9/Vv9P2p1EWJXNmQ/kFqK2DQppcnXZ2Hp40fgz4u+BMeh7zV4f0UZV+C6fTCHOel6ejzV8IYD2VnFjoqHkzMdhUVek+ehSxWnKtVlwfFCXffsXVT8qO6FecJipkBMa9hhmFFNnl+DARc4aV5HfwapjJI+hwz9DDnrT1+E8Z7p0AXLTJJvaZhjtVu8IjzKH8LrvDXRnxABaHm9zXR1dobIngYZcnUkObO/dxZx+fCsemqurhfxVFmVxUCC6T/Omx7gd1Yprw0XWxwzgSpBXIhByuFW5cHCk6wK9fyP64uBSPCZYEFcEarWf1yL8YiGMoTsAu1TxJQko1ctkvejjW66+v53SC7dFBHxtw5crIhW5YSd+rBIhtgz678QPmSnjTPvzNpEjYRXaiABVRsQkABmw6605Z6y0E1FYSJ/7+ZNtlyxDxVx9uRQKUYqOJa/SF20HWaOArado1HfBlZRgV/+9oUH/XU2EOjCqioU4pEQHDV5YYPfy2lpZxXuEZDoS95BZ2/+YmR/7J/sdUo8pL2YnqMB3aeo8FH38sXD+rmoNoxm9g+tXKSURnD2RJfPaOnkgvMcbkYPI1BU+6AgtKpMTv8nmIVWBQvs/LCEyBWUuMR3qp7RYwjzJ7k8R7PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(6666004)(86362001)(7696005)(38350700002)(38100700002)(26005)(66476007)(66946007)(4326008)(478600001)(2906002)(52116002)(83380400001)(8676002)(66556008)(16526019)(5660300002)(1076003)(6916009)(2616005)(956004)(6486002)(36756003)(8936002)(316002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+uuhDIvSDT5/N2pSV5rxgccisoZg9K55BG8OLPm+PgMQ3okClTg+GnaoNwGZ?=
 =?us-ascii?Q?/kfBhm8qoLrvacqMmUJ44USJPBj00XAWymOXR8vOqZIdkv6XGJSQODiUn6wn?=
 =?us-ascii?Q?Ustpr2TBRcZSH1WNXrv+DqvYdye4x4DLqx8BLHlNWt+L6uXTPtottvDKAeEd?=
 =?us-ascii?Q?2knLfzxtFzeUIPNL3ED/S9igJNQNRV7KABrpESNTxIQhj7iJrjWpDqYOHIVh?=
 =?us-ascii?Q?F0+mn8h7+waqDmBAygOutNxzLoU6gzCaOxcBCGVSVTvHcr969tAE/PECijc/?=
 =?us-ascii?Q?CpU9Kuox70SKB4Bk8r3imMOwFOz9m0R3q7WEWNa4xEiuwA2HatyhStrDvAdR?=
 =?us-ascii?Q?MclpvyrRG506a1FRkk26DtipM7HmXHgsmEk2ZM2o7hxPKbVasn5JcZY8nHSG?=
 =?us-ascii?Q?pGZYVb/bnsMR8XbMS8QQvSIt+NLxi+xi8gwE/hpNl9vqksRyW8RfgRd+VkP1?=
 =?us-ascii?Q?vUfNRYH0mtlSgr6BM5HUBDmyghtKELRKAzr8jq4fsNU7pRGa1vhe3MKF9znL?=
 =?us-ascii?Q?D9t05CgE1G134soXeTjWIlliL1PlJpQbuVNj9jKXXTlbIg1Gy63MqomxwamA?=
 =?us-ascii?Q?4CWS3bCim22nrPtAlSs5IPLKpCXrouCtv/QcVWUyb9g/NPgmoK/4qKrmyYAs?=
 =?us-ascii?Q?oAjJM+thbugU3FQ3GHztUOaixZvXzf1G5gW3D08FyweEMLmyzVGW30uzI+Pr?=
 =?us-ascii?Q?jOty9qtNtSQCdKmT/wrmv7BbZPE5UqG1ObMul622bxsn/AxaB5I4rlEaUs/G?=
 =?us-ascii?Q?/XRpSQNsdWi9mQYlzaWSojyZIrK/ypXN05GauVXl3bn/9W0EouPUxnKR1q8v?=
 =?us-ascii?Q?UMg4wBC72KLLGOdPKE8pG37i9HFMCWREv/sUgxzUZbCSKuZcqnlivnFYY+Zb?=
 =?us-ascii?Q?QgYvyTFurkmLqIFNgdduMHc4v72vVEIv/9B1mqV51AVUjA9UoUteuV6sCpdo?=
 =?us-ascii?Q?aDQM7+cBL7UNje4LfywmDlOXrTClSDB9COfyL6KYnS4sGwj/8Dk7O99iR7eK?=
 =?us-ascii?Q?53OGEw1uN9LGld+u5yEQlIGbtJSC5B3wCHDisogs6aMzILPFRuHcB47+ZdUy?=
 =?us-ascii?Q?rqNhzK1p7sq9r3qzP2980qx38klRbqMKXcvVHVG1jIu0SaZMenj3r8kIC/yo?=
 =?us-ascii?Q?C7kuJHZXqXY4X8HdxU4Y9SPKkPT11tOqCjUkUii9/FN7078w7X/U8HB5EzC5?=
 =?us-ascii?Q?9IhKvXuUXSC6oUK/NVBgzjms70nGI55mXZrhoIdHaU0Dwii1seOw1G/Bh0Ky?=
 =?us-ascii?Q?JZ5VhEsqgc/b5HOK/RwQ5c4DQoqoTm+mqTUX/KPF5uSr3sWQuYuABPYaaUHU?=
 =?us-ascii?Q?ywPhvkMkmdaD9oEeBzY37Nvo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d17c77-b6c2-4b5b-282c-08d915e38e4b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 07:48:54.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y0IKZfoIQb8IX42qoNrTatf+TIWxwBh+q+SHpU0fTB/WFjTt+AnjCw2QBVzIZdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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
Cc: felix.kuehling@amd.com, Kevin Wang <kevin1.wang@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the kfd debugfs node is rely on kgd2kfd probe success,
if not, the kfd_debugfs should not be created,
and the node of "hang_hws" should be disabled on vf mode.

1. move kfd_debugfs_init() function into kgd2kfd_probe() function.
2. disable "hang_hws" debugfs node on vf mode.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_module.c  | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 673d5e34f213..f9a81f34d09e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -88,7 +88,7 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
 	.release = single_release,
 };
 
-void kfd_debugfs_init(void)
+void kfd_debugfs_init(bool is_vf)
 {
 	debugfs_root = debugfs_create_dir("kfd", NULL);
 
@@ -98,8 +98,9 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
-	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
-			    kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
+	if (!is_vf)
+		debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
+				    kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
 }
 
 void kfd_debugfs_fini(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index dedb8e33b953..3b493ffaf2aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -649,6 +649,8 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 
 	ida_init(&kfd->doorbell_ida);
 
+	kfd_debugfs_init(vf);
+
 	return kfd;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 5e90fe642192..930447bd080d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -61,8 +61,6 @@ static int kfd_init(void)
 	 */
 	kfd_procfs_init();
 
-	kfd_debugfs_init();
-
 	return 0;
 
 err_create_wq:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index daa9d47514c6..f3ddd8c5b11e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1174,7 +1174,7 @@ static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
 
-void kfd_debugfs_init(void);
+void kfd_debugfs_init(bool is_vf);
 void kfd_debugfs_fini(void);
 int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data);
 int pqm_debugfs_mqds(struct seq_file *m, void *data);
@@ -1189,7 +1189,7 @@ int dqm_debugfs_execute_queues(struct device_queue_manager *dqm);
 
 #else
 
-static inline void kfd_debugfs_init(void) {}
+static inline void kfd_debugfs_init(bool is_vf) {}
 static inline void kfd_debugfs_fini(void) {}
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
