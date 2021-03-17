Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1175C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705A864F97
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705A864F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F3B6E104;
	Wed, 17 Mar 2021 07:47:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097DE6E104
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 07:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIoEgE/dNjyBhG/uCuCM2Jd7HG8r8Nfbi1bSznYv7KP5tvNXQaPwmZululEafzvLoHdtjmgWZ96FpadiFAtqGqA3kH2V/N5XwTglEG2pZ0rkyzZKUwAhiNLKblyIvgJFioLU2iL3lUYwrWzjf9AIz1nknNA33fj4x38X5n2QpS7J+1ta0b4TWSb8vmXd2PoEegzXxKB4tWjFN9b9Nm21mqQbxfopo4neWBWYVhM9ZrLuFV8xXbYDPFq6r+tFvfx7cso32Mmxr3WCNqjPD4+b9VHOFOx7jv3KxfTmtMW8X3DRNXB0ueRDYNNrS5ShQo7fYbAAeLKx+SyU/pdu50+saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UEgcVdJoYR5wIvOBbu2rafLKNIIYX8q3LxlcSUgxA0=;
 b=P74G2/c3kcQL1+vCrXdi4l0IMpOR8vwFCsXfs0Q8R5QfY7ZXyulsja1oIW192S1+hGR5l7f5QGboKyzq75hHUo7xTdwrjPP9OvJNFokeQsmfFmhWY2JMjkdvePrNxDe4+V4Ywa0ZGtogBjQLgSZKMxcGsWWOTgF9YVe9A5SbtO9qemNNgM6N0P+4Tdi1y3Bu82P+id3ctcd++RTue5iaSDF6Y5IQXDhwo5vr6fgHpfVAznDAffO5ZY8lVrY4Q7lckmT+bzBpI4qIhgWIFPBjT+Wt/QV6wmr3qFKJGaIIE84FqFdY9IfH/vZZ/oDrsUSpe6A/T8Q6XAra1DMWnZCLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UEgcVdJoYR5wIvOBbu2rafLKNIIYX8q3LxlcSUgxA0=;
 b=hJ/3d50CmDAY17NtQ9CDnst39BX+kirrpTLVeN7BFpXwnQjCLL1o0OA26chaByB9cOTsFinhH5Ny/eKwnb9zTG/OkpVjjZq8vxm9HDB2QkhSfF3OAcb+EU3lYoaikCtlXfmiwW3c3fiWrhGVm49Tz7dn3Rju65Ck8WkurMXLjcM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1847.namprd12.prod.outlook.com (2603:10b6:903:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 07:47:29 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 07:47:29 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/4] drm/amdgpu: introduce struct amdgpu_bo_dmabuf
Date: Wed, 17 Mar 2021 08:47:13 +0100
Message-Id: <20210317074716.5547-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.96.184) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.10 via Frontend Transport; Wed, 17 Mar 2021 07:47:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60889107-ce8f-4703-bc6e-08d8e918e9fc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18472D63977D83A2558CC1998B6A9@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOC0Zj8/d/9sEC1Y+n4gygk8K8ykloWpYA6JgmZOA+3aoljmofsHzflKZ+kVpGwgDLPoJBeA3CmDbTe7kGTabJUMSoX6r40piyyXWF5EFiCAc0HUkSxDBjMegs9kj4qsAbCMwji6tZfXn9r8BJU6MuMYP5iH8l8hs3khKYM3FtqAsfkqaJPSKW4dncU7Pvr5JgaZw2IXC+H92/siFVXqpDCzWSRPhmckM8TFohB0OThxiWS4OIS+Ko8Rz0wNpfKT1OuP2dFuueC6qTAkGRPvP2JViNCW/vp8y5D/ywCrhv8Wl7Ljj/t9naeUAvVnCIk1y4W1UTCK7PMp+Qg9AgyfWdHKlz1OBX4+BWUg/mbMpNqAJxzaB1xDst2W7a6Ye0dHeMfe0VDrjdd9CVGU9jGCAr5g/TM7hEDr3IisYisMm9sMRb/VopvlLLK2jS1AfaOYRi4ItJx0rFgUJ4zjKzlfPMBhPTW8yFeOW/OebD+mfFexDwnIfsE44z3MMvKIZHqiMMgijhyT5aYiYXRPl82I18DVZzK2GvK3YxILcuq9Sj0ZqISiNbTUpkMlsUOsjrvb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(37006003)(316002)(1076003)(8936002)(66556008)(52116002)(478600001)(6506007)(34206002)(36756003)(4326008)(6636002)(6512007)(5660300002)(2616005)(6486002)(86362001)(66946007)(6666004)(186003)(16526019)(8676002)(26005)(2906002)(44832011)(956004)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o9xTt2rv34nSZPWWfK5qsHWgtRIp4Qf5v4pUqP3HRj5qO/M12BhSS0V5QDLB?=
 =?us-ascii?Q?zE7pgg82ygQB92qZS3K/tFa2D6dMbQCjeKTXT75DdQcm4jtHBOZ2l+iloaiG?=
 =?us-ascii?Q?tySktCMb4+ds+nYiZiW6oWdvaDcSXN0UYIAww77VwVPn3eeLC5wvEG8O84LR?=
 =?us-ascii?Q?TKR61x/2xX96CVZcpOK/9Av+8GtTRF7L0F49jwL4iFyELPI3lIGIWoTs2Tzy?=
 =?us-ascii?Q?IjpM/DHskYpXzVlxt+91wIPnED2jHD4LjiGvBRLzQ88GOD8kOqfWJI8UNw+o?=
 =?us-ascii?Q?4nu2U4xeEwvRzamzHB9Sp8BqJYdHC2CmoSeCJC495Osv2rtoAE43iurhMxcn?=
 =?us-ascii?Q?u7/eRG6iM4Wmb4No63+MKz/1tvBB3nKnPPP2lUDFe9vfe8kew3GTGYEocAMS?=
 =?us-ascii?Q?WG/23IdM2FcNa8Jwke7cpCVIZWQpYyNWYtMg8/W84YjTiB19IhI2ycNQEOQy?=
 =?us-ascii?Q?S7g4m68y4mNTlINNTBWCjZuITCzG5AkwPLIKYnN/FyOCcsxBltIDiVRM1qqO?=
 =?us-ascii?Q?/nA9NKMjeLnXUWfJ/4QzNskNVzsg0eaDk9UfxznkHfFDThBKMOU+sIn8kG2e?=
 =?us-ascii?Q?6yJvF3Uc/Ad4n0GlME31dFKwtI809t+wfoI9xazaYFsfrL2C2EACzJrzSQpA?=
 =?us-ascii?Q?gJhZjtM2KWMBxmJv9M4WXbNH1H8xyR0WB5kavp0quj1yWFEr13bTMf1euPyY?=
 =?us-ascii?Q?daWF+bT11ZCfCPAHCXIaX7CFoOV0/ZLXaIsrCoTCgxkVTU7uEqADnGV4RmAJ?=
 =?us-ascii?Q?Cp/xlQjwjMiatEUIPQFk9GYKLGNZTeVcHsJDty6pG8b/WZRza71n8udrP8HZ?=
 =?us-ascii?Q?wUkhFd2eMO+yUsZGKiWBXnWicKHjVp29zDpkmSf9e055LRPLuVHAyQ2edrPt?=
 =?us-ascii?Q?Osy3dRcvRkdkgaGH8Qc2ZzWWjYjXZS54XXJ9/Zv+6fA8+bCk4USpBEBNQyxo?=
 =?us-ascii?Q?1c/nkLU+noYJqKHUKc7f6kcvb0ThWSsk9Ml/CXE/6x1hku1HeQVrzrQ30yla?=
 =?us-ascii?Q?qmfZqfvfqRFUoPpF1UoW3NduwVAFQz+LHM+wS+TspO+OzeM5rLEWgLg2r9FT?=
 =?us-ascii?Q?H3hZQ/rOA01zVybQAUX50mEh12ieo3J3HTWmKGwcrKd++wBi23kqP7syPqO2?=
 =?us-ascii?Q?XFynyMBqkZOfgLva+axkpJoirrXE8DqNqduydPJH+w6ec1hT5eQa3VwzLHI2?=
 =?us-ascii?Q?8PVuogxAq51g8krzgsSP+gKhPOVtUopgHiryefgq2pDgrWcu/rgNZNgywWC+?=
 =?us-ascii?Q?l/ArFp50v0XuN8hf41/mYhJBuZrWXGbN7VNZCTlkS2LDRAWGn/e8FfONvyLo?=
 =?us-ascii?Q?Y3AHIABnAJjVFpnFmmw5joLg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60889107-ce8f-4703-bc6e-08d8e918e9fc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 07:47:28.9195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3Yi/Tp6Se+7LxWo8OhNHLdc4tS3qd3/TKIAykjCc1DaURM8KmrvNJqtOlEw83vGJ/AQPjB3Uyme+nMw4SB5Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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

Implement a new struct amdgpu_bo_dmabuf as subclass of
struct amdgpu_bo and a function to create amdgpu_bo_dmabuf
bo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  9 +++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fdf23e439b42..fa4686fe95c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -727,6 +727,36 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	*ubo_ptr = to_amdgpu_bo_user(bo_ptr);
 	return r;
 }
+
+/**
+ * amdgpu_bo_create_dmabuf - create an &amdgpu_bo_dmabuf buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @ubo_ptr: pointer to the buffer object pointer
+ *
+ * Create a BO to be used by prime BO export;
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+
+int amdgpu_bo_create_dmabuf(struct amdgpu_device *adev,
+			    struct amdgpu_bo_param *bp,
+			    struct amdgpu_bo_dmabuf **dbo_ptr)
+{
+	struct amdgpu_bo *bo_ptr;
+	int r;
+
+	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+	bp->bo_ptr_size = sizeof(struct amdgpu_bo_dmabuf);
+	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
+	if (r)
+		return r;
+
+	*dbo_ptr = to_amdgpu_bo_dmabuf(bo_ptr);
+	return r;
+}
+
 /**
  * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
  * @bo: pointer to the buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 25411b2c4dd9..4b9339c3f3eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -38,6 +38,7 @@
 #define AMDGPU_BO_MAX_PLACEMENTS	3
 
 #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
+#define to_amdgpu_bo_dmabuf(abo) container_of((abo), struct amdgpu_bo_dmabuf, bo)
 
 struct amdgpu_bo_param {
 	unsigned long			size;
@@ -119,6 +120,11 @@ struct amdgpu_bo_user {
 
 };
 
+struct amdgpu_bo_dmabuf {
+	struct amdgpu_bo		bo;
+	unsigned int			prime_shared_count;
+};
+
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
@@ -265,6 +271,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
 			  struct amdgpu_bo_user **ubo_ptr);
+int amdgpu_bo_create_dmabuf(struct amdgpu_device *adev,
+			    struct amdgpu_bo_param *bp,
+			    struct amdgpu_bo_dmabuf **dbo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
