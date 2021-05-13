Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BCC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FA361355
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FA361355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701846E857;
	Thu, 13 May 2021 08:10:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB7996E857
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 08:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDPiROCxkuSLhpCoVERAK8ToqLKS+3L7YH/XsjMFPiubFbOMw4Pnzv2B1kt13jh6Mh6O/9qtVFVNtgR8MQcwX0g/MxKcQFwAGS5jh3BILVVsfKTy7dSTBRYiiTrUhi+OsqPYR4T3hwySPGQhSCaalFDzZvBJBszaAnoCXyDRLmpKLg8+myQpoIVn4rjs5afPLusnxz1iFIqD60Bkx/FkFhKjhaotAoef3ChZ7GLOMOKYBCYAWQQ8oNl9uqrnDqa2i8fIdKUvaZfvluOdq2k2nbGXpkYY6+HnHGV3+fzN+vG9vAqnZyE3To/qJ6Y7q6ePty4qRx7MFvu7uVH84mBIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37emlBd7k23EMSpRNSAQnJbsg0nX1PuoGfStEjDrHZ4=;
 b=NDcVJhZNsMnsoZtEwgjFm/9KHMsFcAA6gdksq0RkfqGYCqqt6iYUgMkiHA1ZuFjl/n4ID6oANxJ8wi8PdFwODUpHUfqE2PxDG2/NrHNgHklZicdXh6rLKb3CixGQMi3jF+6Y1RHUwUcWCTe2/Hu7J7sztcq/uAB30bIpeRNnPEIU6hB97wvRk30L4dOEHyz5vqi3HbPh2uiE/MgMHOuFPXKhx2gQVpHCk5KPBV+zU8iIEB+JHw6DFPXtGt8HXuNAFGhBwyAkvhawOiIGV2ZSJdw0CldCEGQgix6NbbD31S4/8YZ83mWhWLXGNRseNjx66HQleFuNrJNo+Gdn87IuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37emlBd7k23EMSpRNSAQnJbsg0nX1PuoGfStEjDrHZ4=;
 b=kBRs7voiK2024eEeXDS9a/lbL84mxm6iYQSVBbNKbK8CxAn/1o5jKs4RbGbv20sj1m2tBMBkQTrEoghJEzivb/u3btv2y4+yA1P6r8sVHd6L7TRen4IjlhC+nbPFh9ARLpZBlK1gQ5b2iyAdjSNLttset/rv2ZXrFn9ztLK/1p4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Thu, 13 May
 2021 08:10:49 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 08:10:49 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: disable kfd debugfs node of hang_hws on vf mode
Date: Thu, 13 May 2021 16:08:39 +0800
Message-Id: <20210513080839.35077-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To CO6PR12MB5473.namprd12.prod.outlook.com
 (2603:10b6:303:13e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (165.204.134.251) by
 HK2PR0401CA0014.apcprd04.prod.outlook.com (2603:1096:202:2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 08:10:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 327ba781-eb49-4eeb-9686-08d915e69e51
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5443247A151A58D1C9C6534AA2519@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZa9bRmUcZyJheEDAXt2hmuCDg/Ta0xvXLi64XQPGu0HsAic2po0pYRBrOFGgVmWiBvZMk5ftPUMYZqenQvKNlCJP8lwonO3TjBTrmmsJULxFJp06m2zR93ZAet8pmZf47uTx0yuUQxbmfd7GGnMN2RLBzYeg0G+jJFmMRFyb1bZVg5z93yxtDldMSjfvJrDsrsWx5vz4dJJLmd0r9B5PA0g2mPT3u37k6W4bKowtV7cixCZSkgs+7IlrNQJ7fgXB9z/Z+BqWl5kYB6mb3JRHxpzYaqsumrAGDIHdSQErhBx2nLq1Ckl7dvu58AIRekBPwA7ZtZCaOVzwLChgRie9WXWLFaDWM9QDuJ4n44aUJW+0SkSgXBnDXjC9JBhjM2klwY7MspI8sgja9kV2+tnwb6kg5J6qQHbeqIFJYT0iWyJYKeAoV341yKFn9P5TuIRM0T1la23SMWAFzvjIoRzQeEoUynXRV6DwOtzWO92MVfiBpQBO5d/rIx4NVzjEVZ5qstNA9oUICg7pB/NilN/aXOmqQcftaBgSDqf6qSSW4yQT/S0GDDcWjdOnLFL1OmELWSu+mdS2oE+rQu6vPQTrPdSHJjmlwsyf8x26GxXZKCylfhXiY5koZxv91aIYpZWAKOj0lx2vO9/N2Z27SUDrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(6916009)(26005)(4326008)(16526019)(186003)(52116002)(7696005)(36756003)(38350700002)(2906002)(38100700002)(6486002)(2616005)(956004)(86362001)(316002)(83380400001)(5660300002)(66556008)(66476007)(1076003)(66946007)(478600001)(8936002)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NJ1lJ5e3ud+EtkJptP5dM773YomkO96WSWpzYMqZpSdpeFQYXGrrETwKNvaJ?=
 =?us-ascii?Q?L6YsPZh38I4jozhhQOKu7Fb+czFQRupaGqbEmLgVNKs9+i3+qvWiawElgrWS?=
 =?us-ascii?Q?RBZFTTGwcYvOVXDTcO2Kii7Ww/pnmVWQo0Fv2Lll+5xt8H/sQF8qP/HQ0Hzq?=
 =?us-ascii?Q?MtLWlOxdWR00Bc1UkrDsV3KbtOMFO8Xw2nFg89IH40DGlwgqqXu1XFCbk0Kh?=
 =?us-ascii?Q?N4wlKlFC/B9DItbwcy+vV0DjP85A1X08ux0Y3qdO/ccqH4CkBHXXEypfkUih?=
 =?us-ascii?Q?ReXAoQ4JaMAl3Qt/lvVzf+BpBMAGGzjXuoBFdBH1PpfsqfbbKZdYBIeTR7TL?=
 =?us-ascii?Q?uY7nXt4C3mmJ2XF/ibahIJnAB6JBkMN/47SDPgunwEF0VEh3h9gHomhZywQ7?=
 =?us-ascii?Q?KOrRkF9DlmWa7+k7V0cvtM7BLAerIzBvdEYncMGA7tHyEQ88qTXKFJ08H8Jk?=
 =?us-ascii?Q?kzDQiEC3SKrjZeuyA4X1a9yZwnA9FNPGLaMkJapVHiuvekl2/62vNlyyS1Aw?=
 =?us-ascii?Q?gaGeCZiH6y/UUBRplPFenfZPSXZd/Ff1oRS41PEsn2prh1IRi9uLsrlIvf+L?=
 =?us-ascii?Q?39k9r6KHutOBQwxTVwr6yiCozTXxrZ3+eL1vGZmvPSxQnLT1+mdaWsQlJ4Lw?=
 =?us-ascii?Q?CwnPq39zukLoAPqykVz5m9uD27eJy0Ab3wOuiRqCyypvC0bAfNU0jrX0qddq?=
 =?us-ascii?Q?qgggz1zGo8ElXASHJ1HcFC8gvDCXOWcFeRiee4Xt3jIR2lp1lpP8o6OEDR8N?=
 =?us-ascii?Q?nYr7ShoGsZVflpF0IU5qn1j00VlwLRWky393Ngh0eb0jtcFcMLcHIAN9eC8d?=
 =?us-ascii?Q?Eye1vXsTMwT/XpDlojdiofk4suwUUXejATXe5DQtWvv1pCvlr3AorQ85aNI1?=
 =?us-ascii?Q?gftsFarmq7WG11TjnWZbmR/n3dwyNT0+G5T9VZ9X5iisqOPikZai7J8muDnt?=
 =?us-ascii?Q?9cr/P7xA/t9/cFSSf9onY81CsnwFXuq5z/dUkQ+QbvN22hdda/vQAuyVAAjU?=
 =?us-ascii?Q?PWjM+AuYbmwT9UI/zS62UXbirgwGorpONQ2RXc5wVHfje+ILFc+AutFKIsIE?=
 =?us-ascii?Q?CqCA+nyudsJqZIY068uiEq1R1W8oud9/qBpDzzqWiwfKf6IVf0Kr03LlaxmS?=
 =?us-ascii?Q?8muzW9k/WEwzpSkXbTYeLjCz0NKIgEMPGSHqIDA9LPbT57XcgNwko04FQEXf?=
 =?us-ascii?Q?zSNXIRxi6TlQ417SMOSZVTFWSglEB6zgCtMFoFg6eHUYHug6nTRr8COzumNQ?=
 =?us-ascii?Q?0l5lfA4D90wVfsZGXxAXPolqwxDAaAYq01LTufiz7otgZZqTjn0GRQ00hF6e?=
 =?us-ascii?Q?C2bOC7hzCB3dTbFUTjOb4kBj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327ba781-eb49-4eeb-9686-08d915e69e51
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 08:10:49.5162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V0pXcYuTu3wATeurmbqpBPsRW97FX7f+sFYuHBxxPxIUTB4j1dkymn83ZSWJb0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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

v1:
the kfd debugfs node is rely on kgd2kfd probe success,
if not, the kfd_debugfs should not be created,
and the node of "hang_hws" should be disabled on vf mode.

v2:
also move kfd_debugfs_fini() into kgd2kfd_device_exit() function.

1. move kfd_debugfs_init() function into kgd2kfd_probe() function.
2. disable "hang_hws" debugfs node on vf mode.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_module.c  | 3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

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
index dedb8e33b953..aa9154a8410f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -649,6 +649,8 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 
 	ida_init(&kfd->doorbell_ida);
 
+	kfd_debugfs_init(vf);
+
 	return kfd;
 }
 
@@ -884,6 +886,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 			amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
 	}
 
+	kfd_debugfs_fini();
 	kfree(kfd);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 5e90fe642192..6b9f735c55ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -61,8 +61,6 @@ static int kfd_init(void)
 	 */
 	kfd_procfs_init();
 
-	kfd_debugfs_init();
-
 	return 0;
 
 err_create_wq:
@@ -76,7 +74,6 @@ static int kfd_init(void)
 
 static void kfd_exit(void)
 {
-	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
 	kfd_procfs_shutdown();
 	kfd_topology_shutdown();
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
