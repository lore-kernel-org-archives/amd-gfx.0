Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718E2C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3AA6103E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3AA6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0106EE92;
	Thu, 27 May 2021 11:54:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE1C6EE8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 11:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq7dju1AkNE+VvTsY8slu2jMMqSbNJMdmNPOYvscRtBXnj9un7r7AdAO34jMGVK4ObA9YPDMbtne4OuRvUY7ytWrZFiw8+/gddonxNsIr+hxtnmA/AksjecIigHKNEuE0BTc6MTPqHssieK7XYztCEvEVzSvA/W6HJQJWlHPWzmyNVlefDyIZ/F14ofHIgRaPunRljQ4lGEIJ7BCevOzr/TiyndKFOERHBO3CnP5ZawwaQanZLKYdTsmhp+mJbpsrb3IeaxmzDt1iIZQ9pjTJ+0cOdxAy+0xBTO8wGmDTpy3n7UyD6XWljA4yAtI5YW6zbF4WisIFjFcgEkBrtY5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBDE8dTiKSLDdh0p6VKdtbN0g85q9xDA7MySL2r26vQ=;
 b=iwfL8JgHEe0xJrTXafNUPuV5epsrGz/kms2vHvDbxM3h9BYcIjBm9ZzpU+47hanCQf21y4jv19nEV94SANl5juOWRxLcSeZFasGA3mEhI8Nr1u3GDumianqZ2yStmu2FS8RH3UdFLriTOj8/+0r9HdAOas0pnhTlIuEu9cjKL6a3Dci7uC4pIcUsQAxQrd/nv6AN1jWiro9Xb5PyeofnuIU1u5YluVGo8mb0Ak1NSx9IhSvZ9B4thIWVwVX5OEN9WoWsnv/T2Iq00JEBxLvEYLq0Ia9IIobKAr743a4OnJfTj69iVemgpM8WpRfMdm0RLmqdLckks4D0CoyavxrGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBDE8dTiKSLDdh0p6VKdtbN0g85q9xDA7MySL2r26vQ=;
 b=4MdkB2I6oRgVMquNRaxktRLJakqQftKMtK3uxCW/9yEyWFktflcjTvBq8sli+vSynh7mZ9W4PwvaCNllqOfsS2ZWkgMrpxXt/AvrmaTLbIJpI6aqICTAjyoNV1XwAkt+cpXthe6Jwv6xJuxxYYLU7K32x0+Jm8JkDbMod8W4L/M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 11:54:02 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 11:54:02 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/admgpu: add two shadow BO helper functions
Date: Thu, 27 May 2021 13:53:40 +0200
Message-Id: <20210527115343.20133-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527115343.20133-1-nirmoy.das@amd.com>
References: <20210527115343.20133-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 11:54:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5854d8cf-76a3-4991-8015-08d921061ee5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53432A8403C7864CDF3898F78B239@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yo9XzWoZDOBQ9weXfNrDQ5ASeddXH65bKdmQtHvjnCzKHgIP99/OutT33bEzgmomqNoDSIdgkiORjOL4bvBWaWtaCZScCUF55vYG4RL9qgZzZnL2XgPgVTmBUM873JegKI7OTGK0w8bAUjZo9LVlac9XojaXP1eHZ21PCjsKEf9feouTPWXS0N8k55HdYHrKWsJ95M2dhAfRUn2k2r11T4PWiieb3w6JdBjtiddfuHk+CxLVvuNrTp078p3aO8m8A52boEZ+7NbKxEIQEzt+NmGl+NJHBnfG0JYf6LuzdJ8Game7rbjMT4YC3LYvZDNxnP2ruDPRNwcLmcFz8TFW/TYgZzrbURQwYTeFdAUE/+h9EhALUTgChRtf4IwlHQBKHF8zUgyNw/7sY5SSq/fRxqhIZLh87OrxCydfUkmGElqDdZ0nPdIveoA/9YYEE/poVHQWBmU/wr+zbBW86YCMfViAcud3KLvqQL5ctnreup61BMa1txaIwBABM5UYE5xkIiJsM9Rg5OS0cJe6+WlQRBzZUeDW9HS07E2Z2awbk0Oe6MSiQcMtzpooPX2F2d51aOeUiX8c0ZSJUegkhud8psunK4sgq8qlrqrzSY+S/ENP4PkPwG1E724ovodvbfPkkFMKK8xESwXk6rrMo52OcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(66946007)(66556008)(4326008)(8676002)(6916009)(66476007)(5660300002)(6666004)(38100700002)(38350700002)(86362001)(1076003)(83380400001)(316002)(478600001)(956004)(6506007)(44832011)(6486002)(6512007)(186003)(52116002)(2906002)(2616005)(26005)(16526019)(36756003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pwIGtfk1qIe3LnuOJ8Xff76O7crwiNm41EullTY+xCdUYMcDMsEPu/B+InGT?=
 =?us-ascii?Q?GTklENoMomrrdOvxQ0CJQyK7QqPbu9Iw0ES2ecw5FgVlOIu4nMjDZFS2kgsE?=
 =?us-ascii?Q?mAcze/aNQE++i/jb/NhWAaCW3W6PFy5pUEJNDPOsv6jD0lTe+eosK0wCsYpI?=
 =?us-ascii?Q?05LfnHZUx30dWRSXlPytivyj54X/4Fv/nY1TV08GbNMKUrXQYbe7iLaC0weI?=
 =?us-ascii?Q?8kqT72iOdlzmcL3jlLGu3gXmPyD8ZvaLOsw6Oy1MuzEDTGACFl1nI+n8IBCt?=
 =?us-ascii?Q?GqXK0QfheEvRB+y/Mj0ek4BuPiyIEdSwvl5uGelA/MHHwVyhsFt37ToXWxd+?=
 =?us-ascii?Q?trE1YKi2ji2+ZBLUBPq2KhoW+FG7+GdANnzvx2biKmtPrFZskwzsf6uTepl2?=
 =?us-ascii?Q?pLNUQGuXv4jFinbih9CG6mlcXwcHngOBFacV0L9uvIOTS93MSEaC4LDxXcoZ?=
 =?us-ascii?Q?lwwU30CPS9zJA5LIYsWxyo1x+dBq7+JvyMFpkE+H9y/fXaK2dBCXDDz03u1+?=
 =?us-ascii?Q?9pErmx8pbwJ+9BO1uzH1YLQri5BGHuFBw9Dz8piFdtjPpwQU6NuWCsPDCx1Y?=
 =?us-ascii?Q?JxOdUNG6aWTHPcjEUEnOX7+Lx72+uORSU/zvO6CKtibYqfNf7iivz+t8JjIe?=
 =?us-ascii?Q?bvzpQ6scO+MVg7wQTkVNnV2kGdjn88l2ddAgfd2ORicv/52IUurHd8+CGnqp?=
 =?us-ascii?Q?4+lTsTYuKhORX6BHHUegiU9ECi7kIcg5kWL8yiNECLGdBxqmEy47g9pOSqhJ?=
 =?us-ascii?Q?lbrhJNWpudqU/ZA2wNwGoeYjbqen1Igg9kdwsf+u2/CE2SVFwsRTB2Q5Osph?=
 =?us-ascii?Q?ls943/4L/vVkNVOsD/Ugu0q+5LFuKDyiFISUNq6RFSREOe9l/L0oSsqG7J+X?=
 =?us-ascii?Q?aQtFWoE4YK+3YawInG2BvBgfQCNQ/oegBZ0GliyuZlQOVPZyyCobFHbR97C8?=
 =?us-ascii?Q?Ihb3YeTZOaBcIHhP4ufHbSMxHuPcNG2dmraZpxd1kWOqpRibov99FaV/N+bD?=
 =?us-ascii?Q?20mDefczzuEcXUbV1zSeU9oi4MJROperoWqg9yu3HyTZdLlmGsqEtd+8BUX8?=
 =?us-ascii?Q?lEppnRUUGAJsPZpUR8rxdm8cYFYorAxW0GaX/jwctXjASOmHEVLsEwL0xAPv?=
 =?us-ascii?Q?uFEEPX19egdwJWLZ6qA6E8UE4nZrmZxEsFEvvDOQNvIqE9zdtb2cy227CjD1?=
 =?us-ascii?Q?WE/THCr1iC7WVd0TcpWbWyRIRZ5ik27xqYTGJBBLhR7a/Rv8SYqWjfzuJ5Wf?=
 =?us-ascii?Q?k+4iC7TDWwBT8fOlT5D5CB/D8C935iwhOMZu0aiWsovaqlDQMp1hpdY6QvC9?=
 =?us-ascii?Q?gxJ9P+QnOuZMMHkqF3ZFCjj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5854d8cf-76a3-4991-8015-08d921061ee5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:02.2319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjmF1GHOB1Cr6JXnLDbIfW4q6bgz7ZsRfuSdWc0zAroBuScGn7wGV+fjaTpRpCN0DAa+G26/jaMlPXuVMDizgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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

Add amdgpu_bo_add_to_shadow_list() to handle shadow list
additions and amdgpu_bo_shadowed() to check if a BO is shadowed.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 17 +++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6870cc297ae6..a63b450cd603 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -760,6 +760,22 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
 	return r;
 }
 
+/**
+ * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
+ *
+ * @bo: BO that will be inserted into the shadow list
+ *
+ * Insert a BO to the shadow list.
+ */
+void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+	mutex_lock(&adev->shadow_list_lock);
+	list_add_tail(&bo->shadow_list, &adev->shadow_list);
+	mutex_unlock(&adev->shadow_list_lock);
+}
+
 /**
  * amdgpu_bo_restore_shadow - restore an &amdgpu_bo shadow
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a7fbf5f7051e..9afccf6c66f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -259,6 +259,22 @@ static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
 	return bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED;
 }
 
+/**
+ * amdgpu_bo_shadowed - check if the BO is shadowed
+ *
+ * @bo: BO to be tested.
+ *
+ * Returns:
+ * NULL if not shadowed or else return a BO pointer.
+ */
+static inline struct amdgpu_bo *amdgpu_bo_shadowed(struct amdgpu_bo *bo)
+{
+	if (bo->tbo.type == ttm_bo_type_kernel)
+		return to_amdgpu_bo_vm(bo)->shadow;
+
+	return NULL;
+}
+
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
 void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
 
@@ -322,6 +338,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 int amdgpu_bo_validate(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 				uint64_t *gtt_mem, uint64_t *cpu_mem);
+void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
 uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
