Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B74C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C899B613CE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C899B613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438386E045;
	Fri,  7 May 2021 03:37:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE226E045
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKsldl5664sZT/F08Hi4OCsz0J1L9rzgvLbR1cQL2X8pGHjG0R5YVPUV6eHn3H0cikg5bgfGkmVXcEUNUK/K0U0DYqRatFP+OmFNTzUvOy6Ne0EpKGKwRMgXk69qgMMypegE6cVVesmk+ocW7k6v5zX+c5rlM/vNdAj15vSYD0A2bKxW1hnkbVBP7/QzmTn5NMfRbBZsUdjeKeZlSDFywe4ZtZMmTdgtvxICXYt6j4y3Mmqnjbp0xqG4P4P53Io3voTX83McpLi1Xnh5bwPuoJzpGmdJteZEOjY+M/vZcBQfT1DgVA/Kw3bpnAmFzeem6unpm6Ss2SFyAtc5+yR++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIFcTeZ7KvP2VEETmCcEG48w6IYBz9zaX881Js3BkZk=;
 b=ZL2ywLaF5tFN/Urr7p6G3s+5y4XtJ5FrWKAHx9vGvNiI+JWdPAMPB/bLbR0pE4AuOnvlfGJqI3Mne7aUAGUwBmyuCnXrhIC/WS6TKdP1LxCyb0pFk4NUCp8+YkJAT2GofwSfajrjSvN5urFwDHIvisTil6qtfeFNU5jNz58tFNu+kSkJTkQV1Kx87Cxqfdi3C2ZSxIQpF5EQs8tjppKszd0jd3i+ysHtvA4CvAWQsVmQRC49OEd3hETRU3ZLQ+MGEIbgddfFXK1He5WlvrHiwk1U9WxBZPErIJ8D52tzJA67qbXL51ZSkc1SaHT3QTxsuNYFY7VFv3XQLFYclkc+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIFcTeZ7KvP2VEETmCcEG48w6IYBz9zaX881Js3BkZk=;
 b=FjzSlHmlRxKYz0F9ZcPlMYiQa7dfayVmi4Y6G4HKQARWnOFLjITgowIIpZaDBwAAZ4yVUD8t/oJ3tJ1Bq/I7IHmKcPCkKJl2RFeU7YVjsgtSAwCmGuXKunD91jTzrkj/ztr0fo1XFBv0jyA3Ul0SKhkZmy4oJV08Y2A31pca5Xg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 03:37:18 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 03:37:18 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: get owner ref in validate and map
Date: Thu,  6 May 2021 22:36:36 -0500
Message-Id: <20210507033637.29622-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507033637.29622-1-alex.sierra@amd.com>
References: <20210507033637.29622-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Fri, 7 May 2021 03:37:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c75506-2e20-4ef9-ba7a-08d911096a02
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23653DBD02896D74CB1A0BBDFD579@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI4H1KuuLRdcceDTDIByh2o3haTjODdjzz2NyKGw5lIr/PT12MsW0wg8R+I3KhgBQQ1nLzuVJ2Pmc5M2mTzSBxpyh7fw//cJ2RJwK38wdrwOfhnsB3WMZ9AsYWsojjUMa9bYAEt7ZbgA9o+EsVBqvsm9DHYriH99u79hR4xmmVLXRBmyLgMcksLS+xVLnfA3PmOZ8bgWU/GPwNCqjrjYQJnAJClD+HCD2TJK/YaOYHRc9u9LJ5bHwfpU3IV1AI4EySdeXMZJ+knFveC6PTrP3ThlsPh6KGRTiPZMuOWpbLO2tk9OGnwRPY9V/8Et5/JhABULK/+xK8fkWq0R2dgonAzymKRcYLpRXXvooW+6fQWm/5ybx96CAvcp2jdGpHG7M3TpsIkaRhE1fRUiJrnppaYzxH6sbDx92p08KVbrFa2DiQ4lKR179yrctSdMogavXa5fXHUMswTlIh51Pwz8SEMTq3/g84DORywC3m2BN4W0O3xIkkekm90c45e/LRfBngV7dNd3LimVuU+DDV28VOlg9IK8ioNf4xnt0wOG7P9OHyrEwgXHnQC0DAVBx9oDM+kdOCW39O/d0gKf7tfsbIZX/eV6Jw1KW4cktkC1ws9m0MLdITVa8HAA+zu85h/7/srXiW9/ForAAmhkuivtsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(26005)(8936002)(66556008)(4326008)(52116002)(2616005)(66946007)(15650500001)(16526019)(186003)(7696005)(38350700002)(478600001)(66476007)(38100700002)(6486002)(44832011)(956004)(36756003)(86362001)(316002)(6666004)(6916009)(2906002)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J00lOnjFRiwSEYUDArPrS73/L+gGx4zsDnqlUSwBfDR/MePBtZa2sFM0DEjk?=
 =?us-ascii?Q?7GlhGDtUHcaZsW71aLHKB4zR0QdMVYihEJ+2VxIYCpqhpH7aPSaYamlw+LYg?=
 =?us-ascii?Q?0r6OUsA6sMGCxwWMJFvM9hn9ug+3YmCUpL3+0jJFXFrgXrG7ayUjNBloN1U+?=
 =?us-ascii?Q?DfhxaG8Z1J2TGYfTBZDNpwcCX5wXBo56fGZVILobvU1CMoXvRg4OYgsM6PT2?=
 =?us-ascii?Q?/5xOZq5n/AhnwO9EuCa+eas24KXhhTiIdgkhiMYcj0rqZv1PmkFLuSyaZJLn?=
 =?us-ascii?Q?1g23AQIVfrUfuAr7W/rvgxIeNsDT8+OaTJzCP09MKT6+5gwruDL+Y9Uzrjvf?=
 =?us-ascii?Q?CLBNHxu6kqZA50KtdGgW5I3h9rt4kP92jEKX99w1joSYrhFZYVmocAj7Lxj+?=
 =?us-ascii?Q?GdfFNCaBrmc06nVeigV4I3d3CPSy0/mjB2qRxMTVbB0M7DKyWcwzoAzSnbhv?=
 =?us-ascii?Q?CTq14oTLWU2S6RqhxlwmJM73i+saHFC0XjPT1X5a2LcSzNoQ1mAYKjPwt4de?=
 =?us-ascii?Q?FcrpzGmj86IQU6eCKjzU8FnG/FWSSEFNTBBBmJ+8ew15FpaGgBiVDxpWqv/d?=
 =?us-ascii?Q?FquQe6qTplX6AKM/u2EyOErsh32PRH/Uts/zK0STlv8/o6jw6OU3KhePgHuM?=
 =?us-ascii?Q?/SC0JmTraHoYd3KUEpwEKUMjzTL41GLHmSgLqsWclvfQzponuifFeBrevsY1?=
 =?us-ascii?Q?t2wmhjHPo9HC5ikKZPDS9WuwlBPfEDnmqZAsS0QEt3ekOzSxNJGR8xiB5kfb?=
 =?us-ascii?Q?mDEw5jcmwkvOyE+eBvCpuqaS0VNka2HmRNS04rv3RQxJy7gYVK+8LUqlVYGk?=
 =?us-ascii?Q?Np8Xp4jVqa+ojfXgcKkU1L/ApvxVSWGP8PLtMUrSde7ULXyZ9rXJqP/P1KE5?=
 =?us-ascii?Q?DjqU/HjGCeWcvacG8N7k/+tOaeW7zZcbgscBGOaB5rVfBgkI0Js3LDaN2U5s?=
 =?us-ascii?Q?dBBeQyjTaM8v+S80B9mUWhgUuxwy0/r7R7v2PpMiOCwO+YnEqCaZEuj7PDQc?=
 =?us-ascii?Q?Iglcpqd1VDtC4EUjEYmluCatuJ5ln4ca6fdfGhlvM9SMvptwy9ZCY+AxoOPP?=
 =?us-ascii?Q?TYtu/TikbOFApqOJsFp7CvmPK5wAgcH0CCzdMvbOr/CyEySU6/NqjtCGh2Q2?=
 =?us-ascii?Q?GVVcCrsKDtREgEgiwaLdtV/l8YJ7qaq6OSK9DGCINNsTc3xoSYjkV1v5Z/wF?=
 =?us-ascii?Q?xuUZlf1kHjvLWWfLVz3k1QrWRsf6WnyJ99jH3HhWi5BcTAv+kSE4ckeoeZJr?=
 =?us-ascii?Q?XO8gwghrFi3j9fpuhktpng47gKeJY3ig/wnjyyAXf5+SPrfRBT05AA05qAkP?=
 =?us-ascii?Q?jm8iakjBDgwYtcOpedzLiHll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c75506-2e20-4ef9-ba7a-08d911096a02
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 03:37:18.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb0QUZ/kI/4fd0PpGbVAu+nlCs5WhICkfQafClyty7/Fj/Zfwca/LD41cBNPGlXQK4Ns7HkRL2j9ZCcxw97riQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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

Get the proper owner reference for amdgpu_hmm_range_get_pages function.
This is useful for partial migrations. To avoid migrating back to
system memory, VRAM pages, that are accessible by all devices in the
same memory domain.
Ex. multiple devices in the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f8537940ab22..940165f4437d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1307,6 +1307,17 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
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
@@ -1337,6 +1348,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 {
 	struct svm_validate_context ctx;
 	struct hmm_range *hmm_range;
+	struct kfd_process *p;
+	void *owner;
+	int32_t idx;
 	int r = 0;
 
 	ctx.process = container_of(prange->svms, struct kfd_process, svms);
@@ -1383,10 +1397,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
