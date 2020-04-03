Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A469C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA3D20757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tq6qYIry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA3D20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3506E0CA;
	Fri,  3 Apr 2020 10:55:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE8B6E0CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:55:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evRWxzcdtwgybX0CGj9vNOkGZkgu2xhFWNjxU8fNICS3MXg+9qI4WzoJVKygmRI6LHJLjoy+lZ65XHGa71hFwb7uoYv9rdvYSLamL4VTHV5xs3/fjI+fGickP+8I43sc0Yy7xPRwQ9u7kJm7d33RMu3R1BbXwqtK0HedNQKc/ccFGWJZupjISKjdSsMLZX/ldPr6Ur+sMvpfT13ieHLp9t7ToZbL+qmKSFtM0KTcgkSEUgk8OdaZB1k7iqRrlI5oM7kN4S648bR39/EX4avtXJi/MaV8SZSV2+DWwSzJwgkrD7qUVafiS16CTE26dbg8wVCJB+Wbu+EMGDMg0TsLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMKTX3aL7v3cX8J6nMPdRBUqBonqubbXQPS/AqfDuh4=;
 b=ZEXm1mX47DU5yFlMzy0/Bv2SmcjjeOgRKrrsGYeMDtqJscTFzBnvCMlwStMaV+dU/At9JkgMAvgLuU16kIz48+vHKGv4xX4wNhadxaltlB4fjLsYATZ5uWRmV2sqEMdNA3Oqb83Y6H2YM8+0WxSLu40VvfnZGk7SMJGR/rkgIg/XqJ4SWGQUMkDVFWJ49vJoYyCMJxLaUjqAcwB+09zx0rePxY4J8NSSwWaQxAnYCvl+myXAHIPuFsUJ1OItJjmQbZSe+y3fyhyaFTrexOxd7C6aesMBLQRCi6cjnxz/oco8ncv+SHTxeM7ApoS3JVYsdHlAjkMu/PXXQtFQ2jTUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMKTX3aL7v3cX8J6nMPdRBUqBonqubbXQPS/AqfDuh4=;
 b=Tq6qYIryKcS2rudPAbLq6VRdz//C1Tpcsrnm1MM7lM18yAX79+bWG0UQEiIV109N4We7Xak1PNQ0ueI3Q56j66lRtnSN9qBVYbTTct6O6DUH1QbVxWV6w0E0VJhWqBCAc+TuIV6ALGVI8C4EtPvaObXDCx0p+zcKhG3HRjqogKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:55:50 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:55:49 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: remove inproper workaround for vega10
Date: Fri,  3 Apr 2020 18:55:25 +0800
Message-Id: <1585911330-27664-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:55:48 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02882fa6-8339-4e03-52d4-08d7d7bd921d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB383358CF57D0EC3728E82895FCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(956004)(2616005)(16526019)(26005)(186003)(4326008)(6486002)(6916009)(2906002)(316002)(86362001)(6666004)(478600001)(7696005)(66556008)(66946007)(5660300002)(36756003)(8936002)(52116002)(8676002)(81166006)(81156014)(66476007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ei/dLqOyueGuRzMMS5z9z8BcmaeCE/H0vQu33eq5BqXAtOkv4Gl2Uk5zZEgUTod8gXRBNVW9foquI+42SQW1j41qnWwOdpWrhu3XonCMpTdDuWqNfexKQr8yJsBZSg8sCzCMZkZar8ASK14eAw8+E0dUhTrqQ1gKfppy5I771X9XjFHQwJYEhnE7VTNMB5qr+Qg7jnE4Jb7ylyL5rMRi5fDJim8Mx8fQXygsbIH/QjsuCtcLHGN1BidXTOTiPatBW6LRN2W0396DY80tLvZThB7UWL8VVACrORRAWNTq5BRifHsQYm1fNsdXyJHkFOFEtCnNsNkqG8Q81/Wmm5m76smITyuZoaOzF0582StbzmJVBcXxOTRiDFbDi43mHxfYhZvqlAQl+Dr+6yXPTFCo7SoDO2u1PTtIPciRqpLNVd9yvtD7kQ3Zq/yIZE8lLuGq
X-MS-Exchange-AntiSpam-MessageData: a5YXM4AwviiT4q8GzoGyTBSYT8zkIbrVAZr9D6wFsFfaAsM9GPy8j/qd7maQ5zMHUUedt4LepH1cHpNBkvf0MOxFT1aYc0Nl/Icc0Gba3QIKxq/Qbs8wX4t43fDe+J3s8M9riYXnxjD4RXhw9rsfFg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02882fa6-8339-4e03-52d4-08d7d7bd921d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:55:49.8451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1qInpskqFXKfxoA1xg3ftVvzytJCCTOW6y2IM/5IZZ4KrJtKH/ntAdg8Uiab0pnnaVm8bM24Zp4sqbMuDEa+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the workaround is not needed for soc15 ASICs except
for vega10. it is even not needed with latest vega10
vbios.

Change-Id: Ibcf6f32f756f62004944d5543ff475e508b98a09
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 29f0a41..59bd507 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -960,8 +960,6 @@ struct amdgpu_device {
 	/* s3/s4 mask */
 	bool                            in_suspend;
 
-	/* record last mm index being written through WREG32*/
-	unsigned long last_mm_index;
 	bool                            in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct mutex  lock_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8faaa17..1849653 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -387,10 +387,6 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
 		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
 	}
-
-	if (adev->asic_type >= CHIP_VEGA10 && reg == 1 && adev->last_mm_index == 0x5702C) {
-		udelay(500);
-	}
 }
 
 /**
@@ -406,10 +402,6 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
-	if (adev->asic_type >= CHIP_VEGA10 && reg == 0) {
-		adev->last_mm_index = v;
-	}
-
 	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -464,20 +456,12 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
-	if (adev->asic_type >= CHIP_VEGA10 && reg == 0) {
-		adev->last_mm_index = v;
-	}
-
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
 		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
 		iowrite32(v, adev->rio_mem + (mmMM_DATA * 4));
 	}
-
-	if (adev->asic_type >= CHIP_VEGA10 && reg == 1 && adev->last_mm_index == 0x5702C) {
-		udelay(500);
-	}
 }
 
 /**
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
