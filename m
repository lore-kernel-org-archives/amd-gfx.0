Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA0C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFE964EE7
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFE964EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1061689F1B;
	Wed,  3 Mar 2021 09:26:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4627289F1B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 09:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaZgOVjOXyOmw3PXXPGr2f0d2oCHu9rLWp6ue/fJVZi4+CxcGMCLUSzI2tYUGyPciIfSfqP1LhKVxfaFn4wgep8uCbDTJPqaVWUAwv87K8ZkHGila/ozQtzJJoDan2yc51dhMdyHJEo61vx2rVD/UspqbXJXpQJZhT2p0BslX650wHlVShhrKPiVA/zg2S69GtWPv73z8Z1mlucYnNqr2rD4grICQ4IzxH3GyUiVrxpbrHJXxA2BWH4xXB/wIIgdOsFFprO2kyAjGJuI7xGAv1URrCqtifMrVVN7OKcglyrmcsdtglQPtg8ofy1hqfwlimrMPYynBT18qLYaagxvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR287VyeTYTgDNUMpxqowU2KfRRpDhFuQ81f6u6+AoM=;
 b=auxXzrdf0NBM67zqnpnU6/vUI1L4x02BqBgV8n3XCDIANQpDGoPMn9Qd3CSXJhEI9kr0NspgajB7RRLcyHGF44iPd1/mYm7+SS0nGO5xGyXEjDh6MdHqr+aglSx7E2Ome87VdbJD83zUDdbhgk1iAWhzIJx0+XxotV7vdoT/DfKnvJ8Sbzvs0ALQ1b+ABN7KjV04J/I3A6WVj/I/rkRuHQ8LYtUkc6u/kmKqNfP4fvMrJ1Wm7z5R7X4Up5ss/AD029F8YC0gUIgWM5/SYeaVPcL3+bFBxf48pvB4edxqTg8Oc7rflmlZqobe74lpxwWazjTdiOyxTdjGjNT02ePp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR287VyeTYTgDNUMpxqowU2KfRRpDhFuQ81f6u6+AoM=;
 b=Q4mS4Ohnw+L9Syx4r4ZQo8ys+QY13dZ3VOX9VkbQMKLqzxvE82vwkLMXV2E+cNVM8Iy1kgZPV7e5lD3LZfTTlwNbSheNm+T/BBpdD3WxOMZxWkpDak73GGwrEH6NL9sNHHN8fW9wUfzTBey5ZGZ7c516d/UWHQRN92RBlRLc4sQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 09:26:03 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 09:26:03 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com
Subject: [PATCH 1/3] drm/amdgpu: drm/amdkfd: split amdgpu_mn_register
Date: Wed,  3 Mar 2021 10:25:48 +0100
Message-Id: <20210303092550.110816-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [93.229.59.224]
X-ClientProxiedBy: AM0PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:208:be::46) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.59.224) by
 AM0PR04CA0105.eurprd04.prod.outlook.com (2603:10a6:208:be::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:26:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 573e5f57-8118-4fcd-cd6d-08d8de265d87
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2468A84759B9F655519F64138B989@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/9OER4+5Dlm12U/Hs/HmkUV0/4YQrlXB6MhevKmUyy9h/dIhlF4oPmKeJDPcNCA/iO25CpIARu0ZYulSDUuHFfsJhTqRsGPQxi68aoWjR+OUWM+NUHjMRmkrGbcASTGz9uW4PVm9P2Ljv84aCD8mxB00MmTwC0wWbj64SeyxNUUujSgmBmlmFsAN8nDh9sIGOuqZhXnEMjQOgqZBME3bDV6HE3Q7hBsKg5cR2EWN91MuxtjBYzfMcqMR0vjt25vHWyWk0x82HA7OyZrPVor8BAY+F4P1aNwYThMPBf5sEzEEKSqm7IMs9cvv4J4v3Sq8oQEIlOwyhqSLkPF1YxAIeHFObajGcFD/DX4pxXAIjULNISADpN/8MWfq0WLZ5BTZTColffoSsRXnGSxDjB2fsvlGprY2vtiPnRSfrqEWjkZmILIvGSoVHAzdkOQSUyi+w5SDSwo7uc+A6d/tVmlR9N3fAkh1XCW/z7KsXCbi55f36TNbtehNUH71p0YHYf6W7vN7TE2qfFKlxhQxWJwWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(52116002)(478600001)(5660300002)(66946007)(6666004)(36756003)(956004)(66476007)(316002)(8676002)(1076003)(6506007)(44832011)(66556008)(16526019)(86362001)(2906002)(26005)(186003)(6636002)(4326008)(6486002)(6512007)(83380400001)(8936002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JbOGxkf6ppp9r2inDtQZbn2lH6t/hFcs9gyGV9yd1fZTJcg8hfFNA0Gzok+K?=
 =?us-ascii?Q?rfRMsXlrSa9IA+Nn0sleK0uUKQkxQFsnEThp5xIAoX8llnayMAtiz7kx6zIb?=
 =?us-ascii?Q?7Z25usMepsAwP0UEoQPeSf+hMgUvyXVMbh8r5pVSiXD8jBuY00XOsf86+LRy?=
 =?us-ascii?Q?ChIlLA6TZIY340otMkjQX6CAYM78wvXgKYbVqjK9rGCrnzI3xC1TkqFxkKV5?=
 =?us-ascii?Q?Cc9A5fWbRBt0oYcRJJz9B7DLR+0MaOpGsFfyF5k95udiq4LoWlVs6p4OrJeE?=
 =?us-ascii?Q?/kcyJwgAtN7Rm0OmTN7YkDDRxNpGnzDdOYrw5WbuT0RQwd7coLsQ2VtbQe8L?=
 =?us-ascii?Q?WbZt2F7PwLb4idwpsUu2OiO376urBxOECoi9N76LOv70JNYzZF4of9nO2bYm?=
 =?us-ascii?Q?VMdE5Awb8UKdEVYWLDLd4PbCPDSp4T3mN3aaxH3AF8vjjZw6SzUlz2fuxm3v?=
 =?us-ascii?Q?pdaRK5M/oxddzS7cU1lh4Ykn7frGr0SjefoNQ3frrv2QugM9CKBA+CxeI+yT?=
 =?us-ascii?Q?9YAmjd1BW/hGVn8sEiHYmWqr9AHYIXPLLAivEjapmFrjuBpUgwiSPWZIfMD3?=
 =?us-ascii?Q?x2yT42ABj7cru1VnG10YCRfOLlW5hHT10/k55LewxKTWMv/pK46eSits7WNU?=
 =?us-ascii?Q?aUTTmFCT0LcmJYm4nWgNWzA4ditFVOa4CPuED+OLh7MFYxhjHvKiRJ0MwyLV?=
 =?us-ascii?Q?zz3V6FbQm27cjXvkba7Kylvwc49/TxoNy1HdXswqvhDKbSJIV9gSnx0JL4KK?=
 =?us-ascii?Q?NGsnxiVwUjqiXqCvC4ziz6DoHmjkPRrBApSBXkRd6Y429iLqfzga3KvqpRvW?=
 =?us-ascii?Q?bZpAG89agkztpNu6NoWJuuqwn8SUDeG3dpfOE6qkx1Q5Nfqw22YBa9mIlSkZ?=
 =?us-ascii?Q?SAQJkDj2bbUVGpYKqdf2ngh/4UwapihZVtTvWcz8uwWhX6dFp7bjwUK1tKz9?=
 =?us-ascii?Q?JtW8SZNgQ+XtYzq0dg35XF+rpwgy20GRTXPGhLuxQd8itgtDXjban0htQXD0?=
 =?us-ascii?Q?DhoVSOR/JEyxrBmTkjDixuUbO1ZOOTeiynSilmWTcW46zS/gM15dHkXy1AYh?=
 =?us-ascii?Q?IPOWcaRyUzhU+pX1Bwf98Pfmc4ft4H2OFVejHJ1yo7GQYOJNhtmrDrZlqz5q?=
 =?us-ascii?Q?W2AKRh3qWX5peOhQwNtFcp8stBu58q4Nfbi9a9WBRS3JmYh1tFGL6QGDqoQX?=
 =?us-ascii?Q?mt4wXe1/bMy/TEOo7AI9vkUZBtT8aP3SwplnIh7fGCQftfBSf0YmmxGo1wXN?=
 =?us-ascii?Q?lxGIC0JMTz0a0TIk0VRF0Jn2bBykWXnXOJepMzDNRNc1b6yMoT3INqKxRLk8?=
 =?us-ascii?Q?eP8fJi9dUNxsc09zPNtBdp+F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e5f57-8118-4fcd-cd6d-08d8de265d87
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:26:03.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1QOtJPvlUuGwOEViHjorm+16yKl7uE6JJYjF52jVTZyYE6gwYGZJCkAhPea80T8lYibmjfPAAMw8AT1T9R/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Split amdgpu_mn_register() into two functions to avoid unnecessary
bo->kfd_bo check.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 21 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  8 +++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 99ad4e1d0896..89d0e4f7c6a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -571,7 +571,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr)
 		goto out;
 	}
 
-	ret = amdgpu_mn_register(bo, user_addr);
+	ret = amdgpu_mn_register_hsa(bo, user_addr);
 	if (ret) {
 		pr_err("%s: Failed to register MMU notifier: %d\n",
 		       __func__, ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 828b5167ff12..1da67cf812b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -132,15 +132,28 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
  */
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
-	if (bo->kfd_bo)
-		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
-						    addr, amdgpu_bo_size(bo),
-						    &amdgpu_mn_hsa_ops);
 	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
 					    amdgpu_bo_size(bo),
 					    &amdgpu_mn_gfx_ops);
 }
 
+/**
+ * amdgpu_mn_register_hsa - register a BO for notifier updates
+ *
+ * @bo: amdgpu buffer object
+ * @addr: userptr addr we should monitor
+ *
+ * Registers a mmu_notifier for the given kfd BO at the specified address.
+ * Returns 0 on success, -ERRNO if anything goes wrong.
+ */
+
+int amdgpu_mn_register_hsa(struct amdgpu_bo *bo, unsigned long addr)
+{
+	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
+					    amdgpu_bo_size(bo),
+					    &amdgpu_mn_hsa_ops);
+}
+
 /**
  * amdgpu_mn_unregister - unregister a BO for notifier updates
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index a292238f75eb..565ee5a0a3ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -32,6 +32,7 @@
 
 #if defined(CONFIG_HMM_MIRROR)
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
+int amdgpu_mn_register_hsa(struct amdgpu_bo *bo, unsigned long addr);
 void amdgpu_mn_unregister(struct amdgpu_bo *bo);
 #else
 static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
@@ -40,6 +41,13 @@ static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 		      "add CONFIG_ZONE_DEVICE=y in config file to fix this\n");
 	return -ENODEV;
 }
+
+static inline int amdgpu_mn_register_hsa(struct amdgpu_bo *bo, unsigned long addr)
+{
+	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
+		      "add CONFIG_ZONE_DEVICE=y in config file to fix this\n");
+	return -ENODEV;
+}
 static inline void amdgpu_mn_unregister(struct amdgpu_bo *bo) {}
 #endif
 
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
