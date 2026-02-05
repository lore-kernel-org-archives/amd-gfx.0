Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49050EC1E8F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 10:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E21A10E874;
	Thu,  5 Feb 2026 10:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvKaHr66";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A577F10E874
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 10:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFAUL9iicfJK+i1q2oFIp1A1lZTHqSqAKuSEIK/2tsNtqRkgbAOpfqsG+9GAo+Ae2VVaelOrjA0riGUDOfNGwENUS8ElGV6xK7sHLfDo6fCTY6Y5VvNuuEx51euxcUtnftENcKXO8tm7tBUzxI68WYklYDDlq8sS0gH3t1oGJarHhxo2zr2Y37oPLyTIxS2mKDetH5k87ZxeJp5RH4aqQ1uc1mArNj6Wwoc1FrlPbSUcaBGLvmbc2Dan/kNcy5sUtQmMDRo6gigwiTlDubHcZo5f+rzsCM0j/Trjr21ObAooz3W54j3yHMGsQ5v+wrkctSj6PCHhILu1vYIyBoETdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNJ1/z+4TiQdLxfyguQAixbohdh0S7eFTBPLkQ+yaec=;
 b=bEJyt/M+yp3zqxIfbjPpkeIvJxxAjF5ZV96LVVWLBi5J/XhYXKvyk49r3LxbLnXD18Py5LA707xAwm2wjAqEu1EdbDlyQ0Sxd8qrSLywJ5Tm1KLp4mVvXZ+GaufyqpHanRxftacOrAk+ntkh2wRQ+r9gnNqm2ZO6/pAsFXLBkhdwrPvVnZrXa0bW7PnFhYMKn3oQzUNYd2CHu7HaNucJaLpvnJ3NdTgdhiaGhps/z7LC/I8Ih76t2MNKCS4q0uLcgsDwARbCbwmNRxVijGXJcYUzhfEIFd3ahKmnbomPHMjeKJh+bYyTUAIRV0fSEbklRCrs0t5+0ApAd5I7um5eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ursulin.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNJ1/z+4TiQdLxfyguQAixbohdh0S7eFTBPLkQ+yaec=;
 b=nvKaHr66aLK+dckK1UspEtXZqYLxyy0khsk/57KnuJPTU6NWImWuctLA0C1UpvsRZWLZlFEYgVP9AOuBc2i3RfLzfyX1SNGP0DJ1OmhnEtpnBNf7uAJXojtQKxyQUUP1Hin0EzoZyMnFYQPAu85lZnzhmCCYwkaULr51DUZN1xM=
Received: from MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) by
 BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 10:00:25 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::14) by MN2PR01CA0043.outlook.office365.com
 (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 10:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 10:00:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 04:00:22 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: Tvrtko Ursulin <tursulin@ursulin.net>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/2] drm/gem: add drm_gem_objects_lookup_safe() helper
Date: Thu, 5 Feb 2026 15:29:57 +0530
Message-ID: <20260205095957.278704-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
References: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e75439-9b2b-4d22-d42f-08de649d61ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmJjZGRYV2FjTkVVbWhDT3FDV1NGSEFlZnBDU2syS3F2bEZxdFQ4dVE4cTZX?=
 =?utf-8?B?NVpCMDZENU5hS3NIL1NZcGhrUTlRejhTbHlndUtOazVSMm9lTmhQMnZIM0g0?=
 =?utf-8?B?NkRXd0NZNmFieFBVZStZZEhsRVJKY1h3bE8yT1BjWFBpbk84Wk1nQVhBRFNv?=
 =?utf-8?B?Rnh4a05XV1k3dVhYaUhadFloTlNQa2JmUXV3bkR5clArZ2p4U1VtSWkzZjVt?=
 =?utf-8?B?QktvK25Nb0FPVEFXczBnSWZVMUd1UFQxVWlXdWpTWmc1ZEQxT1FSUEtwMmFC?=
 =?utf-8?B?cDNmcnFkbnE2RVVBSlVPdUtKbU5JZHFkQ1lpRUVTc3JtR1NnU0tWOS84dGhB?=
 =?utf-8?B?eXg4blZJN05BM0xlcEdxRS9zMGV5WXJiY0dwV1VpMEpCbmZuK0JESS93UUJw?=
 =?utf-8?B?TG83WVFXWXJTai9tQzJzeE15LzJ4YmxaZkFzeFdsVWRvZTU3YWJ4bktmU0FV?=
 =?utf-8?B?YVpMSE1zdUMrYTFTb1dIVVlRV2xxNDU3VStoOU5Ea0hJbExHTlZqYTJpUkVE?=
 =?utf-8?B?UkRaSmNFaUZTZVJzeEIwdFA2aFFFbVpDbmJRQ3NsV3A4eUZtamkzUzRJTUFz?=
 =?utf-8?B?SHl2b0N1Ukp3Y3RkdUFGa0tqZTU3VzRLTXhMYUEwVkZGZTdxNWJsdEhkQnVD?=
 =?utf-8?B?TEIrb0lES2JQZlozTkFHUnBFUEorNHAwWGNBZ0lVbmxpUm5QVTUxRUJ3R0pN?=
 =?utf-8?B?S1p6RjNSNSswZmRuV3krS1RMV2t1dHpnaE4xU29SVlk2Nk5JckJwd0pDTXBy?=
 =?utf-8?B?UVdkTlpXTGc3Y3FHR3JnWWxwWldFdzhicTJaY1JyYTJYU0U3djJCZnozUWRK?=
 =?utf-8?B?b2ZsTlFRbHFJNHIvQ1JreUNBYVpSVkRRcFFFdE1EOGJPZDRqWFZjODRCUjRU?=
 =?utf-8?B?dFMzdU53TmxnY1c1aTE1REhISTA5eUMyNk9ubVNicllKSytEZ3R2WnA0S2RY?=
 =?utf-8?B?cTVKdjhPY2piWkJHZU1MTmV1OVZuak5Ccm9Sb0lTSVJPMEtxb2lsbVdnSWVq?=
 =?utf-8?B?aXJ3WnVXTWMySzQ2MUJpcUFqR2xobFFORDRBZWZvVTl4Q2I1RUxWNjRxb09P?=
 =?utf-8?B?Z0Rlay9rOFRHVS9qeTEwY09jWWI1cjhVRCt1anVOUlhRQzdEOGMvWjNSTkVq?=
 =?utf-8?B?VHFDL045UHU2aTVPQ2lKVUNLTWdvNTNHczRuaFR1VFM1cjZGaVNxK0hmRXpY?=
 =?utf-8?B?LzYwV2FmSUY0Vm1tOUkybUU5SjIwU3RsT2EwZlk3RlBFbldsV2hON0lxK1RU?=
 =?utf-8?B?L1UrWndaNE9GVjQyWCt3dC8yMkxOcVF5OGorMVh0MEJqazdOMzRlODcyOVVF?=
 =?utf-8?B?M1JCOUJIWUZjWENpamg0eEZubmNkc3pVNlZBM3V3R1ZVZmkreGxLVDZjRTJp?=
 =?utf-8?B?MDVTdXFVOHFPejl6NUZ2Q08yRVFPOXNzTnNua3R0NDJYUU8rNVBxLzI5ZzJD?=
 =?utf-8?B?NE1NZnlUckxZeElSSVpwRE00elVyazhWd05sVlZZZG1TOWU0QmxVRWNocTJ4?=
 =?utf-8?B?b1Y4Q2hob0ZnREdvS3piajRXN3pCeXpYaGlYVDFuTGpGL0ZFUWxGaWczNTFT?=
 =?utf-8?B?R0ZMVVpqeHdudGlqQndTVWlVeUlHeTV3SlkzWjgxTHZxRmlWT3lrdm9PTnpK?=
 =?utf-8?B?WEN0M1hrZWw4MUNJOGdscys5c0pyLzFoM0FRQWdvRFRibENuOWxqeTB1N0s4?=
 =?utf-8?B?cW90cUdOcjhVM1N3TTZBRU1BaWhGOGtZYXZ5Z3B3YjU2Q0lPenN4czM0aFNR?=
 =?utf-8?B?TDlRSUF1OUlKR3RHbm1PekpNdVliTU5LOXJGbk1CSTRaSkxEaVp6MFVxVi94?=
 =?utf-8?B?Ym9Ic2FrWlhseWJ1U2N1VEhkNDVFTVdrQmg3emJDQWVLbTRmQzNvQUt2UDd3?=
 =?utf-8?B?N2NHd01tVlNkLzdjR1VEZFJUSWpRT1FuVEgzZHB2WlBjOTdvb0lFelBtbnRW?=
 =?utf-8?B?TkY5V1dKektoOUtqTnNNVHFFWExOWVhBOWhIT0t1TXVEaEFseFg0dlJnRnZr?=
 =?utf-8?B?RDg5MVppd2JxUG4wZ3IwMjdNYnhUQjMySkQyQ2tWVE1Kd0ZWT2dDSTFMUzU4?=
 =?utf-8?B?NkpIZGlwd2RXUlI0S1BsdEZqakJKRld5NmgvMWUreDJEMGpPeTdycnRMT01O?=
 =?utf-8?B?ZnVuZVRoWUxxSGNXaUs0clVNR3Jibi9CWG9MK0tQZmFyRFhad0FGN3pMMXdi?=
 =?utf-8?B?R3h1TENDTGczZFJBM3lOc1NuK2JnSXBKY2N6bE4vSURXczVqT1JHeXhsZ0dl?=
 =?utf-8?B?c1QzYlRlbHNPT3FvVkd0M09wUHpRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XLiHFW7881FNnxRo8zf+KIqM9ant7E/iosl3GJ3TOnIvRDG86NqLuZbavr13FxBeoUbOMf1cxLxjoAUFmNsljjfIRrRr9B+nUbGHzoi3h52/M6soesynFWgCOLxV5D6h/1kK1Fels/IaOwGKxgw7HQ9l8doVKq7h4gvRFLaHIEd/zU94fiqlItJJq+N50+vKVo0V/bTyU5kEhM0CI9KDvWJqBRL5R9BW3/RAeIP8qUSX38kqQkk0C9Tzo7NLLbL8LjiUfXiF7xwE9okTtgR/o6jY7fEqrDOPkH0MHoKiP1wc+9/0QRehVTFLfdCO5X41kKTy4HGOm70nzNEDikxDWQujpEJNJ7ysCmB4IZ+lPxnhKrRKCQimbZjGmi6VMQm/e39VdC1FmlUzSTmERgmBb3I0j9T7EPRoEclBRB/yO3YQRqgK380yS6FhhtoqqGXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:00:24.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e75439-9b2b-4d22-d42f-08de649d61ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

drm_gem_objects_lookup() may allocate the output array and acquire
references on GEM objects before returning an error. This requires
callers to handle partial cleanup correctly, which is not obvious and
easy to get wrong.

Introduce drm_gem_objects_lookup_safe(), a wrapper helper that
guarantees cleanup on failure. If lookup fails, the helper drops any
acquired object references, frees the array, and sets the output pointer
to NULL.

This provides a safer alternative for new and fragile call sites without
changing the behavior of drm_gem_objects_lookup() or affecting existing
callers.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I553551dd1e7aadf1b2a477eaf19ce9c80b2ce2ea
---
 drivers/gpu/drm/drm_gem.c | 48 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 0f8013b9377e..f1d13700a62c 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -830,6 +830,54 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 }
 EXPORT_SYMBOL(drm_gem_objects_lookup);
 
+/**
+ * drm_gem_objects_lookup_safe - look up GEM objects from an array of handles with failure cleanup
+ * @filp: DRM file private data
+ * @bo_handles: user pointer to array of userspace handles
+ * @count: size of handle array
+ * @objs_out: returned pointer to array of drm_gem_object pointers
+ *
+ * Wrapper around drm_gem_objects_lookup() that guarantees cleanup on failure.
+ *
+ * On success, *@objs_out is set to an allocated array of @count pointers
+ * containing GEM objects. The caller must drop references with
+ * drm_gem_object_put() and free the array with kvfree().
+ *
+ * On failure, this helper will drm_gem_object_put() any successfully looked up
+ * objects, free the array, and set *@objs_out to NULL.
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_objects_lookup_safe(struct drm_file *filp, void __user *bo_handles,
+				int count, struct drm_gem_object ***objs_out)
+{
+	struct drm_gem_object **objs;
+	int ret, i;
+
+	/* Ensure callers never see stale pointers on failure. */
+	*objs_out = NULL;
+
+	ret = drm_gem_objects_lookup(filp, bo_handles, count, objs_out);
+	if (!ret)
+		return 0;
+
+	objs = *objs_out;
+	if (!objs)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		if (objs[i])
+			drm_gem_object_put(objs[i]);
+	}
+
+	kvfree(objs);
+	*objs_out = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_gem_objects_lookup_safe);
+
 /**
  * drm_gem_object_lookup - look up a GEM object from its handle
  * @filp: DRM file private date
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 8d48d2af2649..7decce2fdef7 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -561,6 +561,8 @@ void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 
 int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 			   int count, struct drm_gem_object ***objs_out);
+int drm_gem_objects_lookup_safe(struct drm_file *filp, void __user *bo_handles,
+				int count, struct drm_gem_object ***objs_out);
 struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
 long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout);
-- 
2.34.1

