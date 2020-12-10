Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26457C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 13:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE0123D57
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 13:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE0123D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6784289DA6;
	Thu, 10 Dec 2020 13:00:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6340D89DA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc9QX/tK+RjYW6+uuumqDTv6eZJ76I8Xk0lfzTq+5aNZ816/ivbKqJ5NBqZo2GwoEMmKlsiibK/PoKByl2L5i0aogMRKcnGo1LXsCvXuZIcmRy5X4E+RhGjxKiiIBafhMI8scsFknqRRbIG2FTV6rTDC3FR56PJR4r6c+7sJJgQSt5kGQ0bWWn33rH3n3baHkLwuxKP2Bhyumt84SSFVH8QzpjJwcCMc5m95eeAqX7tL3zG9FiWqGyjic6kHp3vV2m7wLxtEQM4sF4XIIcYtNAr6miqE5l6gX1cVDuckXQFMxqqoeQ0+xUjSusWTAgBW3FzmmPerzRbSnoUILDECpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEq9TmdrXHhi7v4DvQcWO32eqnjzNqkYI0wrr9rBIKo=;
 b=GDQsLWUvtZU0gl1Q7aCn+0mIgSwOb/dOBXHaIU1EiSbPOnAo9sSc3LfI1MnuuzrtGyrf3M3TLumbUj9x0WAgv2PVi5Or1o7Bb9NJH/LsjiLdEA6se6DgtNhBgvQH502EyFxniHp4gYPAmr6oSxkT5Hey+HpD0IFw7BeXDi6TNHzVEdAEyTlQ0n+UBxullSp4KQpk3/8wEIBrrRWitwtg43HW+ovzI98xbB3uTPM225JR++QhBrDgwQ04i/tYKxroWYYXZd2u4Oe0qILCGHVaMuZt02KhluPi/nD8YLA8zgR7ohRUnDLy7q56hjZC9gD8taevwnqiXVCSlpBPM2tImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEq9TmdrXHhi7v4DvQcWO32eqnjzNqkYI0wrr9rBIKo=;
 b=Ud+cljh5J6t8b/MiW89bv88x3bH0gQwvI4hqTS9WzgKbsVrfflXv3tIbz7KSdQuKkQLtJdpyHdb/5RnCVQDp6sfW00ddrHnH+bQ1P+Ps3eX2VpOWzEcjSJBpijzuN8llxw7LB78oSik567E+ywFaAOXJXkOVeDbZmKwgPcQ/8d4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Thu, 10 Dec
 2020 13:00:39 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.026; Thu, 10 Dec 2020
 13:00:39 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup and
 start sdma
Date: Thu, 10 Dec 2020 20:59:52 +0800
Message-Id: <20201210125952.10245-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 13:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed91c74d-eeaa-4cbb-1dca-08d89d0b9841
X-MS-TrafficTypeDiagnostic: MN2PR12MB4271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB427107C84D003ADF259519239FCB0@MN2PR12MB4271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5y6voLHpNuPwVSPXMJmJ+C/wV1BBDdQidiLPzXRf+q3oATU3bJbuzt9waKSK49P/2XLUi7+CONVMigQnMHEvEKxjm+ZA3Yy9uSqoxWGVICnbqnFNmKlGiejr9DNa1KrjjOQvjFSPTLl8xfQP4jQDPBrz2BdChfl1rvVT5OINHYusWrGPvzEcQH+Hdym1ZnmKyXgfBC1yY+2zC/7+ZvirmXO2B7s5uE3VJewdGEA6PavkZ6Kbo01hHiCrMEn9QjjovnndMqRXauZQh7eIQbV8LTRmDIJ7oKALLfttD3XZ+WpEoBdzrRstcH6SHn1YBT6urjJ9IUDLo/AYMKSmAcAcUGS0WLU/C4mL5Zr3I/g0HBSk7eQnveiEJWwVhwNvbtj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(16526019)(83380400001)(66556008)(8936002)(956004)(26005)(4326008)(86362001)(2616005)(6916009)(7696005)(1076003)(66946007)(2906002)(5660300002)(36756003)(6486002)(66476007)(186003)(6666004)(8676002)(52116002)(34490700003)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xGRRnT3B0i5UeOagz8FyLNIFeMwccup6h+m3vn18Nq6+qzxDyYa3agdiqN2e?=
 =?us-ascii?Q?paOmI0tzUnXbrpbXUwxewR+eNdWy5z3d1WXAc+9lOu+zHBbFN3ufC3DpaAFJ?=
 =?us-ascii?Q?668etxgCLwJufZk8iOiSFLk1q6pC+hyDh0eXSI6YQp85Q/mTm1BiNgCGyclJ?=
 =?us-ascii?Q?9LTw1hY0m6BmpanRhR5mUPAeot0pIKVJokEt4+29dSwwtPYZUdiU76aLITWk?=
 =?us-ascii?Q?x5HT8ZkwVCrhO1IurSxvYvafTfQxjyZ1DXF9tzex4r6q8oXs5oUXv1lq+fMe?=
 =?us-ascii?Q?lUyPqVwb3XSg+0T+tFiffg+FH2VN6s2z/7DDXvUvPuGj16Z9LGiv3g/EqFzx?=
 =?us-ascii?Q?/vRGCXro1vCAemCre0l6FuJf3Wcg7q1+/VE5KGoZLOslaojVSO7/YB/SPFrL?=
 =?us-ascii?Q?cK9Dacty3K37n9wyXI1/guSa5uqHgphBHcOG7RG2YrCUb5sXyR9XagTVa0nt?=
 =?us-ascii?Q?FzAlxvSFhXESMKIBd7hu/y+6kJD/AxzCXMONF2DBGm41n4qeIPPamtIC/54K?=
 =?us-ascii?Q?Wdy5+mWrRV5HlyZa4g8eFJyt8TEtNltXHBilmtYTTZGuScJVi1GX9deaQFvl?=
 =?us-ascii?Q?I1XIP0BA1nF4keyNf0vvCz6kDqYiWuyCR47cGJqXi5W8KuPsn1rmukVMuqtm?=
 =?us-ascii?Q?2GaIQLMhySG9MzrJ9Cf+407S8WqabU56vs+6GkdvjkPatOpYG3wS3vETG3p6?=
 =?us-ascii?Q?V8IdeWV0rxh0vowo7nxqwN9WT754PSCAlgLWguQ4jnQWkLYu8l5qf/8q0cz7?=
 =?us-ascii?Q?tfSQ5ijPlf3wibNXXcCpxSBLqziCOUeUA2d5HhZowXU8XjdizWM05K7QY/rw?=
 =?us-ascii?Q?M/hhLJ5Mt6cR7NZllbA+UDB/+K2tcJ2c6SBzHHAMVjChNGkRmrNWCXb3RJ73?=
 =?us-ascii?Q?gettVcGdMyRDoK2p0uMJqIhDPaGkGagfkqg144Jst7kaFVMlRK96j4lJv2Za?=
 =?us-ascii?Q?jZ9BVO3YYJK5ZyzGNxeBx6KeXHGj318i9bVZRGwn9TCYuZCeRYkmBDh65PiB?=
 =?us-ascii?Q?hoL2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 13:00:39.6361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ed91c74d-eeaa-4cbb-1dca-08d89d0b9841
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsr1V1L3Su1nhP2GB5FjHC6rWu+QdF7kg2k/butKdQw4+nfMhPQu+cooqW+Y6/MRXRgbNhzbMYMLfN/a/jn71Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
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
Cc: Likun.Gao@amd.com, Ray.Huang@amd.com, Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without doing the soft reset, register mmSDMA0_GFX_RB_WPTR's value could not be
reset to 0 when sdma block resumes. That would cause the ring buffer's read and
write pointers not equal and ring test fail. So add the soft reset step.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 39 +++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 39e17aae655f..5acc1e589672 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -807,6 +807,37 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int sdma_v5_2_soft_reset(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	u32 grbm_soft_reset = 0;
+	u32 tmp;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
+						GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
+						1);
+		grbm_soft_reset <<= i;
+
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~grbm_soft_reset;
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+		udelay(50);
+	}
+
+	return 0;
+}
+
 /**
  * sdma_v5_2_start - setup and start the async dma engines
  *
@@ -838,6 +869,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 			msleep(1000);
 	}
 
+	sdma_v5_2_soft_reset(adev);
 	/* unhalt the MEs */
 	sdma_v5_2_enable(adev, true);
 	/* enable sdma ring preemption */
@@ -1366,13 +1398,6 @@ static int sdma_v5_2_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_soft_reset(void *handle)
-{
-	/* todo */
-
-	return 0;
-}
-
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
