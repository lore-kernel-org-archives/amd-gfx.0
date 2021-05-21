Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42BCC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF54613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF54613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4356E4DD;
	Fri, 21 May 2021 12:46:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66DF6E4C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enjcL2Dwy93d8fjojbO/81r+ubHZb1alY5OeH0nja+aTN6xHPvTDBx05I+achKajsodD1uMXXMRXs2PXwqOPdTVhW0/O9z0CjY94HG9dwrnMe2SWUhOOopMlzo4LXrNUokbsxU4nHChNh2nc1IffMtq5DtPfVmDFS6wNSx8x9ZH/BGF0SFHyZVepLj2LwsJ1BhAE66XWkPZUcYx/2mnXbmMhcXPlUSUQXIG5tKuBhZZz9er9MnCKs4V2VO5htSnn0ENZWqebsrpMlhbJzzBDnrM/AX1Y4RMPr/6kaiOoS1bxvrWDa9qqgYRwc1Hjyloxq2TMLXRIZl73X3780U1GiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4JL4n7eguQcivi3OsUIjcus6VQytyU2sTt2HM1kjuc=;
 b=IuOlG5NISx6s/165kLmZNT+cqfpnH/jDT3270sUN3yoT5IqkOVyPoV8W95/Sb+lPem4QCgccmP+6JSbtMQI6m2w4P/1IogvK7O1+yCKJtnpLduFYyCUUxh2GCAj9v4XKbX1rnHIESKY3shxlc0O7qnApcsf834Pt/i+d5QreEaBMPsbbBY0s0u9eEA7pIw0MEIZGApYcEUH1xMG/CLyaKesltIzvHXc6O0NqiOYl8XPLHD5MoakI4xxWkes2nG/f+B9knMRj9ze4FW0orPteT8PijVntvGsErWEDm7IUC2HMuAB46RDz91AX/YQ/8fvoan8j1hiP5i+1dhl6YdoGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4JL4n7eguQcivi3OsUIjcus6VQytyU2sTt2HM1kjuc=;
 b=cYacMqU7dawwSr+pldAXc39C+lbJMuzUuqcQ1D+Xf9C/rlrZjUXXEbX8GBvjNZ8RH/AAY3RKlGNEuSeoV7yFMU/esgno8LFA2X1ylxPXwbSkbWvfIye8lkFf3wztb6Q+RNu8/Kkcqz4tUBPJnA/zcAvuHfUYCHrzf/IgREangAY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:46:00 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:46:00 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: do not allocate entries separately
Date: Fri, 21 May 2021 14:45:33 +0200
Message-Id: <20210521124533.4380-7-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521124533.4380-1-nirmoy.das@amd.com>
References: <20210521124533.4380-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR3P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.105.51) by
 PR3P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24103c73-7f98-435e-964e-08d91c5662d7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5245F91F2902BF3D59FEB4518B299@DM4PR12MB5245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 035O9xeYal6clX1Zcf0QuvkjkAC+QNCmxrR05pCCrs2k4JIouiki/04Mr9FyZd8Y3oH0GKEtufhqqiXZhjx+qlgspdKhTKhKY5AMfsLvtE3E5XpaKURlor8UbWTvowjNZMzBiR03XZkpOgeWcvQBeKE3Tvp8fLnHISGyt6AtAx3fJeNydlDdp3HjZyXLaanzZ8zEHURQOCXQfsqfSO3GZONMWiS9ORO1AVOlaQUkwCIanGRCuvLsXbdHJkQEXqHMWYePfL6MTvFWBgTu444gPxPMT5rxIfbSSGv/yARHWcT+6pX2mQOkxwU8+DEtj4eRo+V63WaPH7+iUO+S2Z6Trlu/5zOwLzFYjvhLUNmmtVNZlujaG08PfJIMhExgsS6yt6oq8toxYxmSqg2PsGaNnm029vd1sM1YA9DF+y3lYIAJPRSWfciM8lgVJAMGptD10uOreB3rRZjoHsPPHuavkKpKwuoUvK9HHBMtinWpURmTuVYxPpLhr6I2pMJPSOGV/xEQKWx1TyxdVoBfqWYSTO4pl4bLgsKdOtve5yd1wLM4BOHpAt9EJOHTxMEjJbU1YhcLAtNueZN16e07j/V2Ho3NP82IGwyYsrDm+z/NPpbRvI70CWkv/AiM7+di0LjoGMvg2R9k87hlsiuooitkKPaIIisYXKjaBd8kJWT0y/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(6512007)(36756003)(83380400001)(44832011)(38350700002)(38100700002)(66476007)(66946007)(478600001)(52116002)(6506007)(6916009)(316002)(8676002)(66556008)(5660300002)(86362001)(8936002)(2906002)(1076003)(16526019)(186003)(2616005)(956004)(6666004)(26005)(6486002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l/iq7T1VrS2nQNV7o3re57acAu0cCtt1HDyP059SMs/7np48dACgt1w0jylZ?=
 =?us-ascii?Q?uXb7pYoMBcBJFV0rUYy4xZI2+9sRuwvWhO97ZPbF7YWrwn46uhMB+D97dLNV?=
 =?us-ascii?Q?B8kTgf6kg1mKOwxYGSOxaPpqa0OPAJnW1dsFRgS9WYuOly09J/VWwSKr0zJH?=
 =?us-ascii?Q?opgLYQZqPuII+JW5GbcN+Q6CmANuiZFGa5xn4pamhDSf0UTDwMWdnu9w94AW?=
 =?us-ascii?Q?JYlTfgBPHvSmwHNwsn28eJjwHkIuBI/xyE9WfFEA4Zp7JYeOYiVsb2nmwRNz?=
 =?us-ascii?Q?Rqf0Lz+gf8/4tQ+CIv8D6gGSHTe4PCEiBBwFhlHrPwMmWaMhA/rogLoZB+tg?=
 =?us-ascii?Q?/S6FU3WBY3JhrnfhWNCoN4UPbHvhHBJHkJzKZ+o/8Zia6J9EJThhLdHLk7Kd?=
 =?us-ascii?Q?IMjFwXDpI9c6lH6UPCVQHUcFJjPsTU0ZHvPlL+Ud+rvE/m4hEftJq3H1AtP8?=
 =?us-ascii?Q?vkIewm42M6UsU/8O3lNPHOUOIi3VUgaJLF0xhtzRrQXeBAIWOR5fU6hXeP0e?=
 =?us-ascii?Q?SFZJP3z2MG6f5T8aGvaFAN59UPLpB76ylDOYCA3iNp14+sSfhrP3Qx3+YkF7?=
 =?us-ascii?Q?m/Q1rToQCi372ml7m0Wd384ctzJolqEE4OEfK70J1gIu3V6L3TUXBp2dz/mo?=
 =?us-ascii?Q?v1L5+zETQ2LRRt0OCSPxtmWD20LcL358R0eIPmauWGxxziB1HLUF0i032504?=
 =?us-ascii?Q?PGJLU2oGQsEYxXsRk+1M0eRnFvdtSv1g3m5AH9sDh8nE16cm5i2nBjAF+xGV?=
 =?us-ascii?Q?49L1w12BRb2GPEvZOQrkNBxmuZ7C0NAJZKLNj0LljxFDKaY+DPrt4VJ6ENCj?=
 =?us-ascii?Q?4F7snBXvskrPsbGHQgTDW9bJuLeuezZ65Z73+vFudvz3V2YpTfE6OBykweAz?=
 =?us-ascii?Q?fA011WrxNomb9d6cAGPA7zj+tNm7vvyduS44UXBg9Ff2KcG1byOwwxobUTVc?=
 =?us-ascii?Q?NAXMUi1ZfoEQj/sFeSUsYHCm/Voig4MPd4/RmsLpyOtTxMcJn8xSTrFPAPfv?=
 =?us-ascii?Q?L9sbmIhvSw/vbyoUKFx85bFSHlUGluH947r6WgWp00mjTic/qE2jtUAwtFLs?=
 =?us-ascii?Q?3l8VjMrh+NGXCdiV33BN3DdErBtJLR1/oXjkLq5VPLqjHTyRnLgA0H1Pk56F?=
 =?us-ascii?Q?k1f74FpYHTRK7zxS7Dp92f+IWLsRC1pS1p1vDaMk9nMZ86GmklxdU+J5kaKW?=
 =?us-ascii?Q?BklyFFuXw4snNhnivGdLhQaj/cUAZRUNMJAZItH9BO5ap7v6QyNwpCZe9cJ4?=
 =?us-ascii?Q?zo56TbP+hzer2Fka6jMQx9yQQ4stwUsvPcNqqplNd5UaipJ+IziRQL1FRyFc?=
 =?us-ascii?Q?n+cxNq80SOqq73lIhTtNYXAz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24103c73-7f98-435e-964e-08d91c5662d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:46:00.1901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HljTAzedlIR/zXopXF0/i9psz6ZQWzrS/qmtTJOBPU73Pka//iWoCOlQVSsc65JERX158gprGqx8F0GvHauVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate PD/PT entries while allocating VM BOs and use that
instead of allocating those entries separately.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 ++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 120e6b7a0286..4717f075a391 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -880,7 +880,12 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
+	if (level < AMDGPU_VM_PTB)
+		bp.bo_ptr_size = struct_size((*vmbo), entries,
+					     amdgpu_vm_num_entries(adev, level));
+	else
+		bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
+
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
@@ -954,19 +959,14 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	struct amdgpu_bo_vm *pt;
 	int r;
 
-	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
-		unsigned num_entries;
-
-		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
-		entry->entries = kvmalloc_array(num_entries,
-						sizeof(*entry->entries),
-						GFP_KERNEL | __GFP_ZERO);
-		if (!entry->entries)
-			return -ENOMEM;
-	}
-
-	if (entry->base.bo)
+	if (entry->base.bo) {
+		if (cursor->level < AMDGPU_VM_PTB)
+			entry->entries =
+				to_amdgpu_bo_vm(entry->base.bo)->entries;
+		else
+			entry->entries = NULL;
 		return 0;
+	}
 
 	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
@@ -978,6 +978,10 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
 	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
+	if (cursor->level < AMDGPU_VM_PTB)
+		entry->entries = pt->entries;
+	else
+		entry->entries = NULL;
 
 	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
 	if (r)
@@ -1005,7 +1009,6 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
-	kvfree(entry->entries);
 	entry->entries = NULL;
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
