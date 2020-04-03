Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CAEC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 04:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1412078B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 04:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MvhNVXie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1412078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD2189FC0;
	Fri,  3 Apr 2020 04:08:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC7C89FC0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 04:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jyyu9kF8lpEH1wAAONPjaYJ8/3EFohMqhd+v4T4fjLV6697Nr3u40IuVotxet0r4g1eut4gim5uwZXHFvXbiTvBvIByo2U2H4zVZGsAtLUsa0EiSDYHtwn7rvv13FI03av5/yRIqZyUGlRYi5W6hEySfBVE1yyfNhrriMdNbAQloVMiFsK/Hd3Cj6ZseZyWXjLWzbjBLkwj8VklEAy6GUMtGTigA28+Gtwhb8PfR9dyIL6ghn+tuNEG1cDVswLTz9iI2YwAqaJG0m/ieLRgBf72fU2Fn452OJb/Nrq1mQEWknmNYvm0gsd6tTl2+4hbPdHX7R57au2D4DSVPux/T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPs1fdRbgaKD7KjPNByw27nxs0JFkqHbeMjHk8xhxmw=;
 b=IA7Uj9vQgS3pGr30mJm20c1hkAqcEX8TVZRAwHBbT9k7LEgODk/FJWaOINjakURA64NWPthqfK+jl0MqvNt68P93Gz+TiJjahCuCSs+SAbD/J7raA1Y/fSIa/qIn3UBav927U4O8fy/ce17cmtGTC3lDojwB4wL3KnAHU8OYoDhG1Ed5Uo6MoPWwPbZefUKAyWiDUcq+c5X7IiE56rtaDAA7xP2IR5qOQTk5PfQUSZSb+sJp2YQ03tasbtMEv3Wqg+qei0qktnHhGjh69uM0Tnzx4HhydhLfPRkY4XQvlMM84yLRKuaz0tp4atxn27o/HnN/NgfdU3UcpTEEfbsDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPs1fdRbgaKD7KjPNByw27nxs0JFkqHbeMjHk8xhxmw=;
 b=MvhNVXieW2lfWiWUfvXpF9EV4xkUIIcpMMe0x9RtJbI/fV4yZ76TvC7S/Bhno9+GEJDww4lDH35SoaKXhXsZ2qU7qLGdV4vNN4hUTiZ05Uz6L8Bh0DVgynKvKcAcFowb3AERxMRie9+zE/bTccTetuZb0LNWXnZfnXqD806j8Gc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 04:08:12 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 04:08:12 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix gfx hang during suspend with video playback
Date: Fri,  3 Apr 2020 12:07:53 +0800
Message-Id: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MN2PR12MB3536.namprd12.prod.outlook.com
 (2603:10b6:208:104::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 04:08:10 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41984ed4-2a31-4001-85fb-08d7d784a08c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:|MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109E1B861BAD5A404C26FF5FBC70@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(81156014)(6916009)(26005)(7696005)(186003)(66556008)(4326008)(66476007)(478600001)(5660300002)(316002)(52116002)(66946007)(86362001)(2616005)(16526019)(6486002)(6666004)(81166006)(8676002)(956004)(2906002)(8936002)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/SB/aw4jGqq7OO1sXXIUI3PRpfxFu7uO+1b5DVugaTsojpjvO/EU0lcivKau23OBgHfSKcswZB/BQsMeTgaIhw5Z6odT2zuiflAsv0gET/G0Pp8J50goKVVduyUN50Mur06CvuWceLJ58/Leu07Mqet1zgN6+8ZQd8kl23ijLhWccXqr8oRcA9MwC1EMYSYQXMNkHoc4ik2rIMXZ3sg2MdFfUI0fsvXZcAmEqU9ydquB00jtYEAncaosNYOS3y3H4ZK04ocqjOmBjKVCgLJv+rG+WblTQrbcM3+wmcxMpOCmf84ZuMv4mHRqWjQAroTjiNf1cvCx2mZRc1eBiFLD7Y76T1khT/bK+mKWrqeMFQOFXVLAHGNdck1RE0DPO0x++/q0ot0AMotZoeMVdelb3e5UZSUWpJ2GklC2IUKId1eOccXXvMnl/cDi/LeYbA9
X-MS-Exchange-AntiSpam-MessageData: V3VKJvbXgX+R5ONNVQEb160I431Rbzobb9P4daOoSBprAGHccMUbGklsZ+HwDJ/5/D+wPnq4S2JFLEssABiqmbpX/XcHWoQ7KgXoqZdXphTKbZuPD4BhZs1aCcttQgei221xKRZrxNmfnInhPxoKDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41984ed4-2a31-4001-85fb-08d7d784a08c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 04:08:12.7002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIsG+rNncOl6jdn2TBXCk6wRCsS2KvMkvNbh2/JHGIfmTf1n6Ca4WwOWKBd76Hi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: alexander.deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The system will be hang up during S3 as SMU is pending at GC not
respose the register CP_HQD_ACTIVE access request and this issue
can be fixed by adding RLC safe mode guard before each HQD
map/unmap retrive opt.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2..e265063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	uint32_t *mqd_hqd;
 	uint32_t reg, hqd_base, data;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
 	m = get_mqd(mqd);
 
 	acquire_queue(kgd, pipe_id, queue_id);
@@ -299,6 +300,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	release_queue(kgd);
 
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
 	return 0;
 }
 
@@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	bool retval = false;
 	uint32_t low, high;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
 	acquire_queue(kgd, pipe_id, queue_id);
 	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
 	if (act) {
@@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 			retval = true;
 	}
 	release_queue(kgd);
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
 	return retval;
 }
 
@@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
 	if (adev->in_gpu_reset)
 		return -EIO;
 
@@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	}
 
 	release_queue(kgd);
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1fea077..ee107d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3533,6 +3533,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int j;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
 	/* disable wptr polling */
 	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
@@ -3629,6 +3630,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell)
 		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
 
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
 	return 0;
 }
 
@@ -3637,6 +3639,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	int j;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
 	/* disable the queue if it's active */
 	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
 
@@ -3668,6 +3671,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdgpu_ring *ring)
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
 
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
 	return 0;
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
