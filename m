Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4575FC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 12:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C767620659
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 12:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K+L8aZ+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C767620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891C26E118;
	Fri,  3 Apr 2020 12:52:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03B16E118
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 12:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjnmiro6zLvx/BfivZ0cpXJwDa8i8lZxr1z9Oz57Yn9x9HzTSdfscSx3EFhPqdYoWBNWGz0NcJW0GeeAZKBWodWbHAaEB6vYrX95oz6VFFRJAmy7iMDPO6oG5KSQ/eXl3Ee/pVH05ydPmZZ1zgEGYfqUJo3gQbBIT8AV2QMSwI1iWeYtDIljzvpIsLDh0I+0lzpl/ZMzFWzd3udKPgS6LP+fO05nSwTGg4EsnthVD5Y9PpBkrgG+dYW4c7ECwIqCIPrWZ9/ZiEunRRd0kbKBzIPNQtmAWlkyzvyM88klquyIJ90SZeSGaDnGsvj8nLbqar9Td3ngzg5Taru++cxj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni320L/wC02S1hvgQ0RLooe2pOLV4rV5QhjhkqBryOE=;
 b=BBJlDWxngpDT2aZNRjo8t1mwdyu+GycmoCxuhVDX/ne7afvYD3U1oU15yKlmWxd3luWvQMqKs7GeHUCWwJcQ8BRz3gxLHpTvbMxMjVOnO0tGigjRkFiUTvI5QaYkKCCO10nSvT6k7oqPiokrWGosHb2abPd7Yvj4MZzl71BLO3dUGQZ7QXqrWgEE38VMXaTsv+MI157B4P+xTg5zgv2TZUBptjt1ag2ZP0HeIGbN3aARqXXmKJ/T5PFMG3kx56HO3++aVIJXc8ns+cGBuJHndXJ46rzWCRhcyQJyujq8ZLLRPtXLIy4AMR5xjSKWjLDITddiPwlwfuLNPzMURCDr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni320L/wC02S1hvgQ0RLooe2pOLV4rV5QhjhkqBryOE=;
 b=K+L8aZ+Xj80y37PONFI49IAksdj8IKuKDeE++9guaxAM+glO9j5ZeaVRoIzpg0qS1OPQFZP/2Bl5ddp0cQUZbF+LhewID894Wu46AP2bT7pltbYmwY1K+ku5v4AVHiqdhl3oP2t5lTytH3aKAU2dK4Sac7zOOnS/2MMguMdCUEk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 12:52:12 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 12:52:12 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: add shared menory restore after wake up from
 sleep.
Date: Fri,  3 Apr 2020 08:52:04 -0400
Message-Id: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2878.16 via Frontend
 Transport; Fri, 3 Apr 2020 12:52:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 129e371c-62d5-4b2f-2e68-08d7d7cdd407
X-MS-TrafficTypeDiagnostic: DM5PR12MB2375:|DM5PR12MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237584A385D90F35F4951B15E4C70@DM5PR12MB2375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(186003)(52116002)(2906002)(16526019)(4326008)(66476007)(5660300002)(7696005)(8676002)(8936002)(956004)(26005)(66556008)(81166006)(81156014)(2616005)(36756003)(66946007)(86362001)(6486002)(316002)(478600001)(6666004)(6916009);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yU0tUo0No24hZtYGV4jiJqNnLa4g+w4IqH1Hz9kDe2tEoRZgew7I1VO2W9pKmCjm8pGtXOsRjjEhznsDxywuDiTRqWY5CjEO51t8B/39NFt0D6bWr8cgOdCvepVJLH89+VDSHLtOrYdSeZDDQmdHUxWPZOxDsRy1gL7WbHDMzz9tbH8SEfr/rxMTVS7UNkd5ou9vwwv4zmOylglH2A+ghdQJUWaunwdDIycn27gBLpJ20x7Vh76IxKZYese2TMd47ZjODadln9nbRMn2hHAz3+cTDaxKET+8rE3F8ng5FFozwN2uEE5WXrRfR8iCvrI/YJDgHzq10UHsfGRPtsW6ra6oSN6W39S6WKZ0JIFxHxHrVAdRPT2YecZgHsZwuOJarjv0G2XyjVjCrKEevG5EGm9AXx8TydTOedgjaemX4v5FBXybXHRBQoDF0euuZi/g
X-MS-Exchange-AntiSpam-MessageData: Es19MOj7Hqxu8stpzFcfC5PnY1bHpmjO72KuJNzjTRDzovfNRNOBYP0iIzD6iDXDKED5QAe+Xi12EwsF33YnCl/qvR5NFq0fgVccH1z3q6ewQrVMtjWM39mWDFFHDh3cAOwfOWZe2YP1/5hETgs3lg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129e371c-62d5-4b2f-2e68-08d7d7cdd407
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 12:52:12.3661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvAcub2cOKZZ4EJuTzO/Nmv/qUU+3TW31dzOILfy90djsb6DWF1Fl6kDcwO295oO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
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
Cc: Pauline.Li@amd.com, jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN shared memory needs restore after wake up during S3 test.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d653a18..5891390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -205,6 +205,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
+		kvfree(adev->vcn.inst[j].saved_shm_bo);
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
 					  &adev->vcn.inst[j].fw_shared_gpu_addr,
 					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
@@ -254,6 +255,18 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 			return -ENOMEM;
 
 		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
+
+		if (adev->vcn.inst[i].fw_shared_bo == NULL)
+			return 0;
+
+		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
+		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
+
+		adev->vcn.inst[i].saved_shm_bo = kvmalloc(size, GFP_KERNEL);
+		if (!adev->vcn.inst[i].saved_shm_bo)
+			return -ENOMEM;
+
+		memcpy_fromio(adev->vcn.inst[i].saved_shm_bo, ptr, size);
 	}
 	return 0;
 }
@@ -291,6 +304,19 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 		}
+
+		if (adev->vcn.inst[i].fw_shared_bo == NULL)
+			return -EINVAL;
+
+		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
+		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
+
+		if (adev->vcn.inst[i].saved_shm_bo != NULL) {
+			memcpy_toio(ptr, adev->vcn.inst[i].saved_shm_bo, size);
+			kvfree(adev->vcn.inst[i].saved_shm_bo);
+			adev->vcn.inst[i].saved_shm_bo = NULL;
+		} else
+			memset_io(ptr, 0, size);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f739e1a..bd77dae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -194,6 +194,7 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	void			*fw_shared_cpu_addr;
 	uint64_t		fw_shared_gpu_addr;
+	void			*saved_shm_bo;
 };
 
 struct amdgpu_vcn {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
