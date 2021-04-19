Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E33C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 17:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3571561029
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 17:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3571561029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E966E426;
	Mon, 19 Apr 2021 17:24:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05176E431
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 17:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSJ9uZrWtAanh/wYDaNbHGR6rg8cCEhylITN5lzXw0npwiAeis/bBCYMRuX3TfREswKZrBQYY6aA/QeCWVRXeinxnTvCloU7oA1a10AfYKTBk3FPzXldmZxy3O8pRDnoTIRfLCvNO+YbtNqcsMYG1B1hPpk5xX6w9qeGfcUK+nnZ1XY2uzpgk4it9eRiDmLOwZ7Xg+PpJd2sUZv59Sq00JkUxqAhngPGWe27Ps6Pm74RkYDne5ZsNgzZPzlGti0xu+XPPoinBpk/Do1+t302iMfubH4ekyRewpRby67tqr0o7cXXN3ON7lqunSm3QAF8Ru44DWkdJEvI649vvEBHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FqvGVrDVYacAo7W3APsA2qzYNWU0vHfjr+VItF81lc=;
 b=AFpBIOiAbP3Tg8WQelD+Q7OEfO5ooGNxyBs0g3/jxn8Fc8EN/LklpCxKgtCQD6J4HJJCd4shp+E6SLcyF4z74dbGxW0G4tDYkcEZJZzxfm4/C6/mKIor90uABoI/LXBWwoUCaCXfOXo4bMWvs4aEYiwtfteWh8E2nMqMnCXJzkWr5usZYSrg7dTkbTKPY8FpJGjU1VNs/QPOkqYkcyUnh6eW7ulfcJcLvADkEf2sD3nhp2EMp6O/xjUtcMEtA2j1GBVIbOYQwpEKz7wRXIKGGpgcjrgkQA6WmiN1kCKEY+9BwYE9Speg41b0tDiNJkjY586fMl0lgfUdLMuaun+DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FqvGVrDVYacAo7W3APsA2qzYNWU0vHfjr+VItF81lc=;
 b=UemCS0O8lyjg54hmv/zX4Yx2L+v70gpSDd6J27TD6SIGiMmij2m1A/t8042er43uqzRqbQEta19vZs4aBnLV2ZvaC7JFOPhYL8PdsNUuqJjqqi3Bo8AYByeIExA0CPbw6x79/eRZLgpcBvyFp/Pmu5MmezyjFe9jUxRaLuXPvPg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 17:24:49 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Mon, 19 Apr 2021
 17:24:49 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
Date: Mon, 19 Apr 2021 12:24:32 -0500
Message-Id: <20210419172432.17147-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:806:120::18) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0043.namprd04.prod.outlook.com (2603:10b6:806:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Mon, 19 Apr 2021 17:24:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d706e9-55bc-487b-35b0-08d9035808e1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2637C9C89316772DA281C9F7FD499@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFJMF11OARkiL86Ix5bhAG6b56d9DeIK5yVQpJkoOlDXqzp0THpySeao8My3nWmVDtvCYVFjoboKesavy/17w+VrUyxIWNycDmy/0ODeqffkKoAZzaIr7AaT04PbQU6luwYTaCoyj0FMLF5UQP5nC27vZ8h1V5eWjmt16k9E5kUw/TR5G4dWEh3zFIER9ha1MZjNjcA792XvsYVzdXcBF26CQkRfF2zTdgP+JWxOsJSoG+sjw7a/7Y/DO7Xd/tZS9ZEClwZGeo4V5u9yOhUO3VK766El/zgM5neIR4NhAcaN/47mjtl4g4zR6LsdQjWRJtGcWyfV3N65F0T7su28sTcoc0eosCRy1wRJapTFdcR89hAUyrHyDXTVLCY0Yd75WSwQWCNBlnSNZf2sbHdroHo3COKx+ZNgrpf33pDfDQULX3Q5kv4ET9ho4qMAcWK3L0FytdyXHlZubgu6oZb1bdpsAlKi4NWu43N4JX2wJ51u61GgVsgPQhm/9+es+F2EU9Cbve3jMybXe5eR+5r/pWxGv5Of2KI9hEOJbbP2d2AYMNEvozHufCycQgX9VnLHJ/G6t5vSpy2/OkEDNAHC0JF4HwCVdHkkZUxNQCMZc5KrepYuzLrFqKp47LyTgiQ+YLiMzRCjSWJXzD5/nb1ETG8X5TKgqC2pze5Ln6Qq+Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(83380400001)(86362001)(478600001)(16526019)(36756003)(38100700002)(38350700002)(6486002)(7696005)(316002)(2616005)(52116002)(6666004)(5660300002)(66476007)(66946007)(2906002)(4326008)(66556008)(8936002)(8676002)(6916009)(26005)(186003)(44832011)(1076003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KuqMaEzfE73+lylBURZ6uNeM6LZmOIKCQCHhdiwgvYqeRpgWeWGYBu7kA7zX?=
 =?us-ascii?Q?ZyOleWiV1N2OV2xGV6MX5b21dacau+PGS7Y3DfnXVmSOFHNCyVw9xpaSWaDD?=
 =?us-ascii?Q?THtdU+RtGwy+AoLu7y6VFIu1ivOq9s5OllDyCxkQWkB2puwvdCDJme2vdW6x?=
 =?us-ascii?Q?BmcLP5qf2cNbTv8vecc+/X9ek+YH5xrodCj54RMTzj6i4daxpXm1iprT5exx?=
 =?us-ascii?Q?+ViMfL1oDnRLWqCgmezeNlVTmFkFGN+hJXFc6t6zIYJQuCToQD/YJVgdXGjo?=
 =?us-ascii?Q?HgI/wYtiUU1Goz65Vy+vfCvFJFad2G5ub5iRWkQkcx7zRJaTOORlaLguGBY+?=
 =?us-ascii?Q?PCLijbTG17DOx361YqgAhyiYfrM1wj9y0sTFOJ+nC5fB4AFlFpx3c0pIUk2f?=
 =?us-ascii?Q?DdKZz8ycP/Wl9Y2FUg9O6/tUoEGqbAwlZEIp10lnuB9GXsKXOKLd4zl6Iul4?=
 =?us-ascii?Q?TnwMYuNEe+/B4mazuoObNN3KXO48wZmsOSGvAYgtlKB/ZBfs3aeDT82aufmm?=
 =?us-ascii?Q?iAYwnzOcbQJyU8aF9yXMzQod0s2FLiw12Iz3cUjENSV/c4x9qCC10pDb3l7s?=
 =?us-ascii?Q?QNewYg5ZqdJoSMnDIqlluA9iAftZ13MOn+3LGOteyDyWH9tCVytLjQbwJ3Gu?=
 =?us-ascii?Q?GBa4DxrizfDVukWifFnfsCET8c7TZbtcyAzj/LagAvYhJ7+7812g4Buz19m5?=
 =?us-ascii?Q?uah65Ea6Zv3GvHuGE5C/Ta2DiiajZhK6t8VKrpT/N6A5M3FP7J1Su+k7k1T2?=
 =?us-ascii?Q?7Uvlc5nflxaqVDWr3dk9FB0A4/aNnnkSBL2bwKjxKivCUbI4LaUEcjVvNzmz?=
 =?us-ascii?Q?ioZbdQJAcxsdjeZG8BYZ8yT8ks9l+PK1Coo/9YgqliEwxVHx7XLIKTDbPYEe?=
 =?us-ascii?Q?SzuKvYJSnuWqkYvYlfFu9ub2G4YZBehjYVx865yTcHaSMQ5HJ30tz+BMl0kI?=
 =?us-ascii?Q?W5nX/rpiGnVoObtS3b7b2lJdTYhYt8fZVGNhMaTFbgL8rZQBUMyfjAdOggmh?=
 =?us-ascii?Q?RkZZsaqO2FC/wS0pzvdLmT3QEBxqNMc+XLnAh7n/ZZHAlrTNMCwivsfR+xZR?=
 =?us-ascii?Q?ymq153NOjMewe0//9VsqWhI5U5OL2id1yfqOzf+gPYEO7V92d0K6QEa2NOrb?=
 =?us-ascii?Q?FXRJwgxDpZodSdFhRGfvAOeSddSYrjMZAusVr5b0Uy65cbX/o5KeBjJ7gwAz?=
 =?us-ascii?Q?eMoRs9GepNdPqyVfuUbZ8StroAisindtH/ChRrSKWPmYrquRCEi6cB6PiAYw?=
 =?us-ascii?Q?mbLIFU7dE6Jl/pBRV1el2sxnpLD0VA1ukTZ3yYOFtu1yRrvHMqLseHTnttoR?=
 =?us-ascii?Q?S3iE3fOt9RfM3P47WQK7S0bt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d706e9-55bc-487b-35b0-08d9035808e1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 17:24:49.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrTeom68GxYNW9Gh6JBTzWetLnoO3aF80pRSkjnfT6n8ubnxiL8/Guo+B7XJtj90WkK2G8ySKnvJc5JabszFWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SVM ranges are created for unregistered memory, triggered
by page faults. These ranges are migrated/mapped to
GPU VRAM memory.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 85 +++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..4cbbfba01cae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2179,6 +2179,79 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	return -1;
 }
+static int
+svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
+				unsigned long *start, unsigned long *end)
+{
+	struct vm_area_struct *vma;
+	unsigned long start_limit, end_limit;
+
+	vma = find_vma(p->mm, addr);
+	if (!vma) {
+		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
+		return -1;
+	}
+	start_limit = max(vma->vm_start,
+			(unsigned long)ALIGN_DOWN(addr, 2UL << 20)) >> PAGE_SHIFT;
+	addr >>= PAGE_SHIFT;
+	*start = addr;
+
+	while (*start > start_limit &&
+		!interval_tree_iter_first(&p->svms.objects, *start - 1, *start - 1))
+		*start -= 1;
+
+	end_limit = min(vma->vm_end >> PAGE_SHIFT,
+			(*start + 0x200)) - 1;
+
+	*end = addr;
+
+	while (*end < end_limit &&
+		!interval_tree_iter_first(&p->svms.objects, *end + 1, *end + 1))
+		*end += 1;
+	pr_debug("vma start: %lx start: %lx vma end: %lx end: %lx\n",
+		  vma->vm_start >> PAGE_SHIFT, *start,
+		  vma->vm_end >> PAGE_SHIFT, *end);
+
+	return 0;
+
+}
+static struct
+svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
+						struct kfd_process *p,
+						struct mm_struct *mm,
+						int64_t addr)
+{
+	struct svm_range *prange = NULL;
+	struct svm_range_list *svms;
+	unsigned long start, end;
+	uint32_t gpuid, gpuidx;
+
+	if (svm_range_get_range_boundaries(p, addr << PAGE_SHIFT,
+					   &start, &end))
+		return NULL;
+
+	svms = &p->svms;
+	prange = svm_range_new(&p->svms, start, end);
+	if (!prange) {
+		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
+		goto out;
+	}
+	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
+		pr_debug("failed to get gpuid from kgd\n");
+		svm_range_free(prange);
+		prange = NULL;
+		goto out;
+	}
+	prange->preferred_loc = gpuid;
+	prange->actual_loc = 0;
+	/* Gurantee prange is migrate it */
+	prange->validate_timestamp -= AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING;
+	svm_range_add_to_svms(prange);
+	svm_range_add_notifier_locked(mm, prange);
+
+out:
+	return prange;
+}
 
 /* svm_range_skip_recover - decide if prange can be recovered
  * @prange: svm range structure
@@ -2250,15 +2323,21 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	mmap_read_lock(mm);
+	mmap_write_lock(mm);
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
 			 svms, addr);
-		r = -EFAULT;
-		goto out_unlock_svms;
+		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		if (!prange) {
+			pr_debug("failed to create unregisterd range svms 0x%p address [0x%llx]\n",
+			svms, addr);
+			mmap_write_downgrade(mm);
+			goto out_unlock_svms;
+		}
 	}
+	mmap_write_downgrade(mm);
 
 	mutex_lock(&prange->migrate_mutex);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
