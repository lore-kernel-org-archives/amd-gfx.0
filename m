Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931DAC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDBD64ED9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDBD64ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDF46EC43;
	Thu, 25 Feb 2021 05:28:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D976EC40
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 05:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD8jbf9pQ+9xiyXXlmr0Clla0urfZ97tQUvGulYA3pXxnyK0erCG4qIepM2hqni3f4OOX8tbBKh/Agv5MNVdRW1sUAsXHRG9+8lmTNgmTBMUofC8rDVnAS+2tZ4NQs54qYkdbt8VzNcnPVeQqU8SWvVVEmymTQRnFwpaNjYwXO2qb0BmBHefMrSiny0ftr2WUTod6t/ieLQjw+9T0H9XxJCAx1DNcStTF/avKQ+QWiYGDX/ypCvG+5mY8TAiuJMvDuxzPO/GDJKwK6Hl8/7pTXF1Cw4FqcDZrZryYIvQRlDJHQdqR09jc3PrmnAlC7RUyCZoLFZ35jmiceyBmM8L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L7fiv4FAyBBCCR7XuOuYVDnEf2R1ASX+tM5gYPb3rc=;
 b=M0aFMl7EoW3sPYCvVqr/NZQR5kPo72ztkejn58G7sYWToLq8laNdfdGGH5LZrhDMYZcnwqER+O/hmAeIqvGbbtFe815toGrJJBpL5R08h3dkSTm6CtW1HJ62KNm4c06y9zIbJE6ufsDoT0OfFiMwkkjYDFj4/hxQd48jem+x7CoTBlgm5FB3ZbMJZ24qk8c4WyBJ7UrIzZxStoyrbHCp2H6Hh35ZQVx7ZaRC91Yk9c5Zsi0hawNZbcTcC2fdcS5MIVYVCZHXSrwpkl+XeQjZE9/KrsJbanMTD5naqYlUN/DxQPB1OM9FY1N8EYyNY82CtoMw5fgF0V37jVB45qbvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L7fiv4FAyBBCCR7XuOuYVDnEf2R1ASX+tM5gYPb3rc=;
 b=fKL/wRKmUvD+XFhcCAoNXYcaWRmPCfLSey2R4ZLHMNZdT9rkVhUNIdLEyX7ByeKRtzSP+l+07Zn4rB7uQb6JbNj6957+cQVieDWA/Hi5+j+42D5hC76wUfqKyuqhTa/q3BqItGkm5FqsEKMBG9BvLGmRZ7uEvaY4or9upUBVn4c=
Received: from DM5PR19CA0050.namprd19.prod.outlook.com (2603:10b6:3:116::12)
 by BN8PR12MB3409.namprd12.prod.outlook.com (2603:10b6:408:46::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 05:28:20 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::ca) by DM5PR19CA0050.outlook.office365.com
 (2603:10b6:3:116::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Thu, 25 Feb 2021 05:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 05:28:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 24 Feb
 2021 23:28:15 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Feb 2021 23:28:14 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
Date: Thu, 25 Feb 2021 13:27:25 +0800
Message-ID: <20210225052724.36412-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
References: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 430976ee-3991-4cce-1959-08d8d94e28b1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3409:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34099E81D76C043D48264CCFB79E9@BN8PR12MB3409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBeQYIYuk9d2z+kmD0vQwHCqw2+n2yrnTIRMkAioMg7vKjBtsVea6ylxn/uHM5Nlh+6Fcycy9LuExBUQ4qnBX901Ls3Ybmwjicc1JoZKJ255G5YcjvN6pmFi0O4kZHpeMkXXhbBjMBoHk1t84Y+QETNokZwy0a5YdXVA1f/7XaEp+lbmX3Rxm0jTVs9vAwstpRTWTLqWmlbnuzm/LBzXsOM1kfCT5BNw77Sca1QxS1oyrLKAIVSkOexgCVI53YOGpL5po94WkYDljyi4yBFRg7Vi8hK0obvjA6m9A0gCX3hYy+8lZP9CArvpv3eWIx07H8GXT/qrYd3BtYZLtM9RWcZ9CjG0Ypb9VDS+BEum3bDieFix8E/wcvKw6SeeSo6eJmUhm0iDPfPEm4bVgDrlzslTpFSx7ozd/+FV91r3YzGYFE5Er0vNVLlgsyUx6Lhm8dvuvddu1z8Zyzu1Nb0KJWrYXskwKnix41VJt3Msam4WyMrjTWQGEoAY0sp9F7KnCJClZmjRTCOEZvw9/9FXjCQjMrVrC7IAtz4wCyAO+idJOSCq3EcFHnnQT2L24wIS88UDqAfURGSDK3gnI/e9YPxTu+kB5jfPx2m3BNyDGIQFmlbXE1SPLpfzNQfvIlRyTWcOPGe+Hz9DXDF4YTMymr5oS0XM2prcp7xdjRHOmXYNDefiCqK0fpOBzmY/py1T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(2906002)(82740400003)(8936002)(6666004)(83380400001)(86362001)(186003)(6916009)(82310400003)(2616005)(26005)(54906003)(426003)(336012)(478600001)(81166007)(356005)(36860700001)(7696005)(36756003)(5660300002)(70206006)(4326008)(316002)(8676002)(47076005)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 05:28:18.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430976ee-3991-4cce-1959-08d8d94e28b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3409
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, christian.koenig@amd.com,
 monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
when a job is scheduled during TDR(after device reset count
increase and before drm_sched_stop), this job won't do vm_flush
when resubmit itself after GPU reset done. This can lead to
a page fault.

[How]
Always do vm_flush for resubmit job.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fdbe7d4e8b8b..4af2c5d15950 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1088,7 +1088,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
 
-	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
+	if (amdgpu_vmid_had_gpu_reset(adev, id)	||
+		(job->base.flags & DRM_FLAG_RESUBMIT_JOB)) {
 		gds_switch_needed = true;
 		vm_flush_needed = true;
 		pasid_mapping_needed = true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
