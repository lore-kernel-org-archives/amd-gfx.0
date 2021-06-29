Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5013C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EAC61DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAC61DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463616E8D5;
	Tue, 29 Jun 2021 18:02:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9B76E8D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qsp2NL39P78dtefnkf08i9WbxJzJ4uawmT12Bb7BVLSyU0LVvwldNBh5/xnDRoYueZhWlDQQIYLF4BuWyQ65C2taZRk3RurplpfLro4c6hdgaX78yxTD8HRaUemUA2R0rpIpuirce5NCRePlpotmue/wZS8S0DY12dYvwq6hYwNmDfi+QzhS4EUoya7829DOuaMiybxjuiD0a9Si2VHUF158Ij3tZ7ELTR43yuIHIEuNjNwMgR3mcKoAqsn3wOlWvNjGbNrzmN4Pef9xINa8pKw6hrJ2PtzzfHHmC57cK/e3sxd921Ksm5loUOK8Uqezaa1zlU+9DudF+jwlJnipQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn45MgRPB1nRjm8LJKV8EzxMaqae3pSQT3c1OZH8/bk=;
 b=oND/zBXXLVMW2RlXZvDFxMWphXC+D3kQimGV0sROuT5Z6zZWE/ndsX0BaA1mj5RKxuT1l16rMrbIC4kVoKga27vRNo1Uos+sOXp7V7uYqEfszd+uGbN67xMGKqB8zDcjagwoJjnQgSazE1YOccB/F4cr+kXYxhvjqRJBKLROPtE/rmjAv3Yw4BCKmA15ZAkf2HKIlIvKFLJivu7b80Pj0inkbnozNOzWODXnar5dOdyGDME0yqt2DKuDRuTZns/AhvE87OH+XOcgen7em45vTvT/qYYgIItg2zEEcD8STEe3UM2BpQB345stAWIoHzMYmU9VwQLFPKC4DBiZtS+gXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn45MgRPB1nRjm8LJKV8EzxMaqae3pSQT3c1OZH8/bk=;
 b=W4oyxiHi+bMo/s59bHMQ+fCh/UiFXvnf6qSyeqNTG4s50L7LSBw0WY05BuwRVbPHpLsguhxD2W4Spn3i3ug3Vrj3uqvrFRBcNr0WFJZRaiWG7xujbU9sni/g+im6lej7p7+YtRXW3CVSmUK3NOKLSPm4zxkpjTY3no6g5P5jLRg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 18:02:54 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:54 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/11] drm/amdgpu: get owner ref in validate and map
Date: Tue, 29 Jun 2021 13:01:59 -0500
Message-Id: <20210629180206.8002-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4565ec3d-ccc0-4b01-4fa4-08d93b281e05
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441357707CCFF018E0C5460CFD029@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1pQc3PRMcFnC9DDfSlhmL3JFsOLZ5BRXybELo3sn0Vw/QLtrpgqbmq+z5SJbaHfm4XOeAM2tDZ/2mOJg/fsXmXnXAfCTpo9iBnCNzn+dna98Tte82SBNXhjRfdFCJx+U0/PD8UNdg8critpqBAnq85lzPuJjlc0CbyPb495kzf6qUwKAktjpdXY68s8I/qpdHjYhTGtEeqWpVwVZJiwXDuA112Ilkk74DdLOj4NVeE6VXtjBDSHfMdE4p08Kz7orsXdcGXVf57poFjdVxim9deT2pFKPthzWa4FirAj59vfA4A2kMer9VV8357CmTUxWPpjPFbLAVpc/q7L/9TSstCaSy/c3JeSGS+PQiqPopLTFmUE4INTs2BJMgY6H/knCw2Igqn/fpJMXLGaeLOH5q7wZrxl5v5rssbnwhjlLQvoeR/XQf9zRaQcMt16orZJaFvgvHAczD3MYQGithNOH0/Y2m5VkJoNyGztw39KJG7gEQCtgqZqCcEIcd3MsPJlCKeUoLQn71cBYzX5DLZIh8S/z6J3UbDGaDF9Ob3ycYz/l4wiA5Y4n+pZppPpVVILMT4/+MoHlMPcVuSxEoMfnYP/S8UryIWRunL4s/ojCU89V2L9iNXoQL8rhceQvSIG9NxWwx+uvlptjd+ZNQZ6r1eqyvGv2lxkulC9Vzb4cEy+yzMHg+l7aHWH7Cu11rGXGLEiPIJePd3E/PeXCDBPmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39850400004)(396003)(376002)(44832011)(7696005)(52116002)(5660300002)(2616005)(956004)(478600001)(2906002)(66556008)(66476007)(1076003)(8676002)(36756003)(86362001)(6916009)(8936002)(66946007)(6486002)(26005)(316002)(4326008)(83380400001)(54906003)(15650500001)(38100700002)(38350700002)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PspN8eOI3RCs6/KQPDB/yxQDAZqWMBNQ7VnJ2+8px6629nzQTZeJfkHowPJV?=
 =?us-ascii?Q?kO5kv48Wd99EpZA33SLj6XhQy17jpkXtogBA9U+zDaonSxcWmYmN48NSLpAS?=
 =?us-ascii?Q?+Al3lbvekt5zg0vptF3sCyffiaPWbLZx0K7VuhCex0OEGLIbJuIEhGDTLebr?=
 =?us-ascii?Q?9jwbP4ZIKTYjLdY78xNSidWIhi1JzviTTiaggbb2mJcxoT01Z9gX6AvKMiM2?=
 =?us-ascii?Q?kB+D69aJrYkhRWXTkXpB97sZ3XPCekpYfKMCBd/6aV1yWy/J4tSmiL84XJ3k?=
 =?us-ascii?Q?eskjSXcfEBXrb+kIgkpy6X8n6sUPb0fJwoKh5fu3XRHov/3vIRwb8n+BGMJs?=
 =?us-ascii?Q?u0+BQU4QwY48BBD5NazuPzEA+j7amywnQn/qgf81CaW0HM3C7LEPmGWm1xau?=
 =?us-ascii?Q?6t+W1RUDYNMRqAoHRHtbQypGGk7eOneMD8RepNPvmTMU/812WXIJxlxbPNHw?=
 =?us-ascii?Q?K1ioYzEAjYRSs3ipB8CLjQHmgyMtbPRug8+ncCorZrLVlwyN+QDvOTjXnfMC?=
 =?us-ascii?Q?5105Iw9D00QvyyokdHkiQpVwvk5iKnFAmpvuwcfU8wjGGRoZTDOW5O7AzEeu?=
 =?us-ascii?Q?ulQIU68T2/WPPkNiLNMD17aCl2y0Ln/cNUZFMZd9oPv4uJ3TpJW+J9+4Iur3?=
 =?us-ascii?Q?h3bKZtEaNPletquMTWYVhLtd5dlzX+SzyNn+QxPBOvpVLk5BNN3smx9QbcUZ?=
 =?us-ascii?Q?uRWcexFgnu+tiUP+Au6hLlR/z9sqNYRKUitQY721UOp6Kk4eUJKZ/sCiT+Ba?=
 =?us-ascii?Q?dh5JTxIOnHdh68IdUjNnSW4oC0OEl9VuxTnMN8THDN4Iq544LKuzoGC92fHi?=
 =?us-ascii?Q?rQ9zHSmJ3mS0Ufb8M8wSv+AVA/pXGUDxMHZqrRY/BO/dmucOXdoMkHgsHnRg?=
 =?us-ascii?Q?OHhBAF6RMw1GOu+94IM5C6VuMOySuABM/5vd9jh377wD/kk3t4fRPZ8XVIuR?=
 =?us-ascii?Q?Nvli8NOaClWunkkjFmNdB/sTpRSSAdjDKy3d4zqpcsVngREdxC8r+wQwTyF3?=
 =?us-ascii?Q?rBL+BXOLVHuX1JoNW0a/FakRVA6SdBDIuHmiutJrWtsE5IKnTNQYj/HBY2Iy?=
 =?us-ascii?Q?eKOqXmDoQT3atwzjbllRgjO10SNJuTr5ANM0WeBeLFnb4KeOhjw8NTBMVht/?=
 =?us-ascii?Q?qUbDSLfPNQ/c0CsN+REKMDVxFAAV5aEgjuPaCLVYbHyQ3bmYViNYzhJ+V944?=
 =?us-ascii?Q?y93payH1+4Bge+upiqGVsgiGf06tfq6gBw0rCIEygOl4yHVNgFR+bmXSuvbQ?=
 =?us-ascii?Q?MvOKLSVq3q0EzwLlHiV5wtTzMIawQWuHcAaH0/ueSAuygJ2B+6/FjrAhpcdK?=
 =?us-ascii?Q?v8TxjH/n/zA0z2XEvFhHnOla?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4565ec3d-ccc0-4b01-4fa4-08d93b281e05
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:53.9355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPQxT/vhyqRGrGHN7xjX+Es/8nrGqgEGlcnMRM/A1EAJjE+DbCAwTA40V8gIMBmku9dkIcW/izIP7fmX6h4ITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get the proper owner reference for amdgpu_hmm_range_get_pages function.
This is useful for partial migrations. To avoid migrating back to
system memory, VRAM pages, that are accessible by all devices in the
same memory domain.
Ex. multiple devices in the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 61db2a4db917..fafc11cd274d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1337,6 +1337,17 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
 	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
 }
 
+static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
+{
+	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev;
+
+	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+	adev = (struct amdgpu_device *)pdd->dev->kgd;
+
+	return SVM_ADEV_PGMAP_OWNER(adev);
+}
+
 /*
  * Validation+GPU mapping with concurrent invalidation (MMU notifiers)
  *
@@ -1367,6 +1378,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 {
 	struct svm_validate_context ctx;
 	struct hmm_range *hmm_range;
+	struct kfd_process *p;
+	void *owner;
+	int32_t idx;
 	int r = 0;
 
 	ctx.process = container_of(prange->svms, struct kfd_process, svms);
@@ -1413,10 +1427,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_reserve_bos(&ctx);
 
 	if (!prange->actual_loc) {
+		p = container_of(prange->svms, struct kfd_process, svms);
+		owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
+							MAX_GPU_INSTANCE));
+		for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
+			if (kfd_svm_page_owner(p, idx) != owner) {
+				owner = NULL;
+				break;
+			}
+		}
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true, NULL);
+					       false, true, owner);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
