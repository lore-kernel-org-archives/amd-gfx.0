Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE60C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 17:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A065724677
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 17:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ip3ccopN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A065724677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0325489E0C;
	Wed, 28 Oct 2020 17:12:01 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AA089E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 17:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsc/mfZFRXZCapne3PzPW6BJkSucOpznOphsTp+357ws5Xg8PWpsz0lVus+yhQOnfLPj5+YhQuF9aFh8PDnqIZpKQ9nSMcErA7l1JOk319CAPj+zbkq0OiS8nypj3kvooCcla+UXHbm+AHfCzcXFH9myrx5k16Ii1frShjFnj2M8M31bK19TMVuTcNTQ6zosLOAy9/fkGxUnf2qgbLj+S+HEW7cj5bJbD0gzBwKYi7Um/iuqxAWU5OoXK3rWGYdzU2sPi7qhhe7E4gMYmVjme6IXAuovqkj5ta6fMV6eD7yLt/hCjQvJLizo0lpgHLk2CQbZB6kaDqkhiEs9aFewaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+MOtdYPPGR5ze4HHDbCO/hPkk5K4+MDc4Ixki0jHv4=;
 b=L8QkHSGFSb7Fl62JqlL+Ioqk2CkrSXV8BOfE3f7ykwi/uPmlsQAZTB214nYwjkjSYhEPuoWmjeibBg+fGQtYQyV1nJ49WH+EOimFZNssEXfpHka1TvmUSnuRPFjcJKMr9aycHIM5Q3pJCYMmjxUcE54mnv2dAvLV/qkOJ+P3Z4Qf1sFbi995PHOo64e6y2bzWoiCzu8qPOs/qSC/ZaMEHyViQKWlC7rnZETi4vM5e37NlAbly4aRgaujgrNELEEX+Pq0wyNHrAhefHhew53s5v6C3r+FjGZzlehtEa0fuyhvC/VlHrIietlAZ3rZYO9bahhCweaGoU6QT4gPXw3dvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+MOtdYPPGR5ze4HHDbCO/hPkk5K4+MDc4Ixki0jHv4=;
 b=ip3ccopNG91Zv5/aLPCSksaBTNZm3NTOVIbXbNfYSA6L3CRWPZ0WhH0JQFRlcjj80leRuhoCvRmwt+SDLfAqyjyCeC1CLiM4ih0u2QRhinfjLRsjcmM2sAVS7Jp2Q0gcE9qGM+OZw7HV5kfxkn4tD7BKfYq7LsLtxPE3xJXkOu4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 17:11:58 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:11:58 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Fix getting unique_id in topology
Date: Wed, 28 Oct 2020 13:11:28 -0400
Message-Id: <20201028171128.22077-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 17:11:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed039a54-a7fd-4871-597b-08d87b649425
X-MS-TrafficTypeDiagnostic: DM6PR12MB4156:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4156416334F8DF7FE086724785170@DM6PR12MB4156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJdTnwHGuCuzeCBPVOsSJAFYyAYKJhVVpuQUDWJvdjoe2k4dsPxpKjRFFwMzQZ7m71SWiQpTi2jcjdkJo6BtAfl2i5jHEU3hU9MSw3bZwMIueiMtXxH3CyTLlohdu3n7bE026UCYHDJwMaSiz7L8iojZZeOEzBYhpHVIng09YDN+iKRXYfU7uatnWrxsfUjQ6xeJOPUYuFMrOcS04hMxXHNQroHzIEl74mN3oD7zPkidoLVQOWOYTYPJXhdBZ/zhjIznGT4dGE+Z3g/dXBTA3Ct1XKNRzkfLN+fIt930+EscLwlL1CQ1QPR7l6SZ/2e/Fz8h8K5i5cDVwal2O9Q1wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(8936002)(6916009)(6486002)(316002)(86362001)(5660300002)(186003)(6666004)(16526019)(7696005)(52116002)(26005)(66946007)(66476007)(66556008)(478600001)(8676002)(4326008)(36756003)(1076003)(83380400001)(2906002)(44832011)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LOjis5pEvykaxEKa+LZrdYPYlbkj0CsyNTdBvRXcPR3uYzMHIo6XcCG6cEJKNOj4YlAti7uCiPEu5TPCbJKFrpopQQ1GzRYy7dLB7jlrgrsEhTj4HYg2YKSVWBvxdHyS9j2EoBUaDrXStKPkNunVc6jIITBEOH4wgZfI4Egz423OoggsvSIhmBfoZZi1hjna+yHcKTXBi75IncJfMUiyaV3aRqSJyKV4Pdz2ouNEywL58Ea3XYMgJ9vWCzY7MjMTUIqcmPxuna9gxla1Rb7IZpL4mqIbdfOmkRLmSfaC1sNPaVvQGUHGbyNjIU2Q+4ekg4iDTpZB3CxUIzq1r/bWvZJ9oi3Uz/pJZI+DClv03x6rvvHdnzWZWQ+LhZaH+trvLqNXzUpCFAFKcMirOTMwaRpcna7QN7S7E0SH3ivnexG6VziopHfuLzvZ1AfAgAsm8nE0HTbEfB7bNH+f+c4tXRS0D+3xN2+HZa/gokMEZNXi4xxoYEDI2szEOxrnN+CZlsWzYTw+hGYU8+BEWqMe+R2KLHnxERSdSN1vjQNpYBFeL1wmfTiFMafe4A/QDWOOh8xOOGl7ayIvibzxtRFcudWVOisEvxRJMCmQo184lVzXXA+d62l2b+yA5WKny9k+NZ4+S5PYzpSTv6lSTpnlOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed039a54-a7fd-4871-597b-08d87b649425
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:11:58.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1V2/Ba9e8oYoTIhJxS5DCO+mRkCIzFUU1yOyZJ5Gfs/FKAvBc2CsLm7FaaE6A/kIaXe6rrQgTfa6M57j/1gWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the unique_id is now obtained in amdgpu in smu_late_init,
topology misses getting the value during KFD device initialization.
To work around this, we use amdgpu_amdkfd_get_unique_id to get
the unique_id at read time. Due to this, we can remove unique_id from
the kfd_dev structure, since we only need it in the KFD node properties
struct

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 14c3f148735b..50922ff2927b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -757,8 +757,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->kgd);
 
-	kfd->unique_id = amdgpu_amdkfd_get_unique_id(kfd->kgd);
-
 	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->kgd);
 
 	if (kfd_interrupt_init(kfd)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b7be5c5751b7..e2ebd5a1d4de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -292,9 +292,6 @@ struct kfd_dev {
 	/* xGMI */
 	uint64_t hive_id;
 
-	/* UUID */
-	uint64_t unique_id;
-
 	bool pci_atomic_requested;
 
 	/* Use IOMMU v2 flag */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3f2aa055c32c..a3fc23873819 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1340,7 +1340,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
-	dev->node_props.unique_id = gpu->unique_id;
+	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
