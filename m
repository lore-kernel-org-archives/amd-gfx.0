Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10128C433EA
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9452B20760
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kmUkGkfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9452B20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466636EC60;
	Thu, 16 Jul 2020 13:14:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9596EC60
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 13:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEhJOMQWIT2PLpaZjO9LWhSYOL/M10VB+dju8ayZAB4Qv9pNNRW2h6wdQv6pNVK3OLfo2psUFi7JR4+9a0FLEcIoDP7gwmY6i8Qxl78YWtnhK/GdobIySnTtFNORKP97RQpeTR1CIO41FW9hLJahKDKTP3GvcD+2u7mMHtTs3lZahFZpCyA/fZzduRMv6pMWbmx85ghA1Qf6d+vAmrXNm48l81ZC4Pp3WajuTptMiin8pBY1w0XRnt8e4cLMcQI3a3kL2miq71jxGyVXcjt2yJ5DUmhCupLeEUFHY2RYpIw8vSeizJULM3Adz/KyoqXmNkbOleiHkDSq8Oi1UU3j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXt+FzC7HqGYlkmWResWxdTnb5Q8bWGOdUeKSrsbWmE=;
 b=NCvUZnCwJ8bPauSWTIgckMrY4171aiJOQ9u00J+ewEy0nD01zkqnI34zxVCRWOeeX7uJQ9ntwxhL2EWj+biDnu1D0y/QtCd+a/svPbrUVnBwsjUpQfxjuGiYaPObHRkjDkQPxWoN99D8BQFbH9MS8xgJImGuF1ZabmbVgolJ7J3qpHdkn3ffJngnwvRjBZSSpXPJM2BV54TEa/fTHheGE3bnfF2X/3huBvzn+SpeLakwT+wzlw8Xy6/tUJiz6Z/eFnPuw8uxHOP+X4QanjREi6Dvh+2/LqglZnUgpVZyEvB08RupN+0n51VoRpnOxmFkA/LVQXv2fL11QZISdN5/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXt+FzC7HqGYlkmWResWxdTnb5Q8bWGOdUeKSrsbWmE=;
 b=kmUkGkfTksYobakyURKIwzN7ryuJym503CVtK1OPl5yeSaE9wrQ0Ar0p4uVN0A0gUCJPB0VJQUhKVavo6SJGuJ+KjYkky/56vOHZ1ExTB2hPNOdKnOyspKz0OEtz6XTUuOvflgnF80RYAofnpLRZCv3d5hp/SegaMlEQ+5oCgPU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR1201MB0092.namprd12.prod.outlook.com (2603:10b6:4:54::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Thu, 16 Jul 2020 13:14:56 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 13:14:56 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] Revert "drm/amdgpu/vcn: add shared memory restore after
 wake up from sleep."
Date: Thu, 16 Jul 2020 09:14:46 -0400
Message-Id: <1594905287-2895-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 13:14:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d351270-29be-4505-c192-08d8298a3be6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB009218BF6B574B4BEE2D8534E47F0@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dx2yxt10xeQHYuzoBm/goAvaYIOyxNniHLEc3O3OuGsy/8CqvkiOfRgexg2m1jqgCx0EnbJIbXMY8JbIrbF4MTyRf3uYpWBfykdcxdjcK/27B8tB4Qn7Fsk8K5cHTGBj1YOD9/6vdltf0QkEA/sIJmuQsJlhYtFDgqra4TtJs0FtahPRaYtrs1D1DO0fcptPImxq+kaQJHZvMVyvYpS6EBVBSIs7n38FOlmOL4YJGj9qnFEP/SFsHL18Y+8S8lim7t5JB6OYBau6CiDiqZuQPWKEqBsESLSEi/kIhKyerzeKuD7hzbWDGG2AncX+keQR+503JhhwzZBpycEUDU2VjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(6666004)(66946007)(7696005)(66556008)(66476007)(4326008)(478600001)(8676002)(6486002)(316002)(52116002)(2616005)(2906002)(956004)(26005)(186003)(16526019)(5660300002)(83380400001)(36756003)(86362001)(8936002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: asOZ1DscDBrpzZboC61fyejtesXRgz/Sr9xGSzUoU5JJEXLOl9d3QHVJwJa347zGbH5XSkqTlpo1orATQnSwbB+XDPuocprEZvWFArRe28lKwTPK6aEknNs0AoJUz0VYj7MHcK3mYdMkdfd+514eBGdE6Ezu7a5MyimNpBasMNcwshECbZXZMu6NUPfnTuFKLCzuLNNet83cEArdBsKQ9jzmwjHsaDEObYyQU/YQJxE59gXNzgbVUimIfaE1GyIJCcKWA58/Xvg/j8qHu/ve6aanOgx6sY3ifxwNv37nHZyhRtiJRPm+AcM/+2PVnyJDfLDIfxafsKnh0ZysnVOEQ5k5eN/aI/D/qYXGFBNxKpwn13/th3DYbcfCIz/jCo6wnTBQfcbUSiug/zuS9CgzPqDYpCJqZ7S65NfdrZH8zQjhb7aRYrRCzqZ8JN4IVFusVgCd2I/1QrSuKiWFjLmMQcqn/PfKzTWoD23a6oixp4/0tck16rp5FZnAsUgHsVpE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d351270-29be-4505-c192-08d8298a3be6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 13:14:56.1608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJGHLrKFuhMlhTNH83JjRcFkIREq3hy0Z50AOhcmJxosC2OXFZFbHSjy8VTDzuxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 41fd4db3eca29d10222f164cc1d56f60e3da97b8.
To merge vcn firmware shared memory bo into vcn vcpu bo.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 +---------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 -
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 15ff30c..cbc2b30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -58,7 +58,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 {
-	unsigned long bo_size, fw_shared_bo_size;
+	unsigned long bo_size;
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
@@ -198,9 +198,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			dev_err(adev->dev, "VCN %d (%d) failed to allocate firmware shared bo\n", i, r);
 			return r;
 		}
-
-		fw_shared_bo_size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
-		adev->vcn.inst[i].saved_shm_bo = kvmalloc(fw_shared_bo_size, GFP_KERNEL);
 	}
 
 	return 0;
@@ -216,7 +213,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
-		kvfree(adev->vcn.inst[j].saved_shm_bo);
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
 					  &adev->vcn.inst[j].fw_shared_gpu_addr,
 					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
@@ -266,17 +262,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 			return -ENOMEM;
 
 		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-
-		if (adev->vcn.inst[i].fw_shared_bo == NULL)
-			return 0;
-
-		if (!adev->vcn.inst[i].saved_shm_bo)
-			return -ENOMEM;
-
-		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
-		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
-
-		memcpy_fromio(adev->vcn.inst[i].saved_shm_bo, ptr, size);
 	}
 	return 0;
 }
@@ -314,17 +299,6 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 		}
-
-		if (adev->vcn.inst[i].fw_shared_bo == NULL)
-			return -EINVAL;
-
-		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
-		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
-
-		if (adev->vcn.inst[i].saved_shm_bo != NULL)
-			memcpy_toio(ptr, adev->vcn.inst[i].saved_shm_bo, size);
-		else
-			memset_io(ptr, 0, size);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index e125e8b..b5e9088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -207,7 +207,6 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	void			*fw_shared_cpu_addr;
 	uint64_t		fw_shared_gpu_addr;
-	void			*saved_shm_bo;
 };
 
 struct amdgpu_vcn {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
