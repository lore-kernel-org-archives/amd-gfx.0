Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB6AC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535D320714
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cq3fI0Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535D320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32536E4AA;
	Tue, 21 Jul 2020 10:29:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44996E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT8BZVP27bEwnjc4SCfxkHgSo2fMsbS71fORESGbUBHWwCsXwcKBgDOFn7tbhDe/4O7PPXXJoUGi1SOu1rq2Prw/ghHxzWfAHzWhRCMyJdza/FWcqyav4n49DNQaX9hOc+m5sktd6OjLrLB7NNGKbQRRxaEgkCzXTNqkwt1vNMMOmZxXfPQfZ4389bwdfAOsorOBq2kRfdAIbDXnon5ioz2JdCgFYtbn5VD8oSvwjAnZYDHYApv/QACQVUWixB/tsi4gkNlCkCXgcFoxvccCnXB0pq7wjGmwjrPUKvHk4CrRUxDgtBDlS9lcs77lLkhgWOIYbl1+LcwodxnPW7BUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkcvFIY8++6RjtM2GxGQhOWYFXTaaudHskxUYra+8qI=;
 b=TRpL9j9nK0bmOkSakUCMr7HoimL95OPPn9BnEvbJEEm2Qz/rAZ3gyFDLwJ2OW7geuBd8v+3OSR30lfaV+3w6UJPhYic1DPAGWTvPrPao1FtiP1yi2uYSYCGrxC7NIdujl7+l9uh65ecdWCx5KLfelGGSZVUEtZP6660aVLNw4bSv3k+UavYQV6XH+jTpaX/cbResrc2oHf3aXq7pvis79uHEDNg4w879KYHnLc6f4ni3qG9NI7llxxDWmSSknvysfxkJZxlWW8DzCg8cX4wqZkpqGjrknPqAD7Qeh8ya9P88AYBMQ+tIa6dIkZCvtj/IWZxKKsbXil+ZC5iAX/wQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkcvFIY8++6RjtM2GxGQhOWYFXTaaudHskxUYra+8qI=;
 b=Cq3fI0EwcOj8vaZvt7nmt8BWsc4dD4TZFuzW3oFV5urXAq5iKRLEeIG6czEVOnieYUn/+tPHOIAJB32+TIf6IHxM8wngTXVca9EA0FkuXYZDfW01zi8xEfKW9UKRKXFhyVhVCwxHRWdcocJKtHiWRW/+3uBvcCOhHOL+Mh+W+60=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:29:36 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 10:29:36 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add member to store vm fault interrupt masks
Date: Tue, 21 Jul 2020 18:29:15 +0800
Message-Id: <1595327359-120379-2-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:29:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 432e4afe-cce1-4531-2dd3-08d82d60f748
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41442572AAECC693CD8FFA6DEC780@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mfm2HrK0eFMiozxMlaa2+Pgs36qMTj68R2mcXaQnyRXHho9IPfGUSExKBrM4T6n1Gxgj8N8TDcU+9qRQ+8kVOfCo4z2zJKQoso+Ju7fUJMqag0cuvA1tD4AyFoFbOa+Tjd4NtobqAURy4dhCeaQM2OjmAdTEvSyCoulberD2R3BRQqMlsJa883h+vjq446tAxsbNHOXq/qzblCzDB+sFk3IfLzdLHRj+56xF8xctz3MrVwQYvff3YLIPwVIiNfUp0ZPDn5/D3E1AsTxi3f9VM9QodtrIsmds4yLQrrZjThUlN6dwqV2nBHPtFgFji+1Zhn/fQGp0bBhrhQm3XHILg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(956004)(2616005)(7696005)(26005)(478600001)(16526019)(186003)(4326008)(52116002)(6486002)(6666004)(2906002)(66476007)(66556008)(36756003)(83380400001)(5660300002)(86362001)(66946007)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PFAKJrFwKyAfjzspYzhi5apN+iHgSA5TLzSj7ka4IK6v/Yw2JkbrawEaCd84JS66AY/ux4kaayXVdoXCs9Hf597xWYMipWT4zEKN4SRQVS5y6xg1X+2fH0CpIRONFccY4lhav26wO6HiDOJsXCqHblCrhmV+D76ltjhD4SX4Eo69e0gEXiihsneeqKY6rYMo50cc4cgHl9anvT1e1FF/H7OaUKwjxNI9wS0LcbDklAFOVYUa4IkaKhAeNchFrYpn9BK+zhdoyysefaXRqOifdMMbsflqXZNko1bwa0dRbNt66Kp7N2uabGzuDolSwzc2Ddg9QqaLE2cmQZeSPhxE/HmG3bPWNpmqL7XnpKplpkz7ET0tKJQptvER7O8+oD+O5SX3sLQk8AGhWlONJHM9SwJ2eIqcqHXRjUsqAwW5msb4SUQkqVfG026nt2G+pQv45nqyy3yCNzIuvFdLJKM/nYWgTyQNGYO4Y9VYn/6szQ58qDtQE9kMg3JzzrStigZH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432e4afe-cce1-4531-2dd3-08d82d60f748
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:36.5276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuiCMHGtMUoEPJqsn+RTTlmzCKqTvGfrcjgCZnBDwTiqmNQN7nRZo1k+Y+iUv1J/m/q2UV2UGW27VBp+gmPLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds a member in vmhub structure to store the vm fault interrupt
masks for different version gfxhubs/mmhubs.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 8 ++++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index acdb61c..e11c21a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -92,6 +92,8 @@ struct amdgpu_vmhub {
 	uint32_t	ctx_addr_distance; /* include LO32/HI32 */
 	uint32_t	eng_distance;
 	uint32_t	eng_addr_distance; /* include LO32/HI32 */
+
+	uint32_t	vm_cntx_cntl_vm_fault;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 394e6f5..993185f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -390,4 +390,12 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)
 		mmGCVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmGCVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vm_cntx_cntl_vm_fault = GCVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index fa0bca3..07cae64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -389,6 +389,14 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)
 		mmGCVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmGCVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vm_cntx_cntl_vm_fault = GCVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 }
 
 int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 757fa8e..48134b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -381,6 +381,14 @@ void mmhub_v2_0_init(struct amdgpu_device *adev)
 		mmMMVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmMMVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vm_cntx_cntl_vm_fault = MMVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 }
 
 static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
