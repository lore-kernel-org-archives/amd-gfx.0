Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0625C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C6E20708
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o29XHHTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C6E20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233CE6E063;
	Wed, 20 May 2020 22:52:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF166E063
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 22:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6B2xa0dz2mPXra195mAVqcIkluKpAArwgRpb++GADZHo3M/jM1zi4elEUa70dprX/LlB86m5o7UWhRPBl5Ur1jsvMNNYqthEBX5JU2xj0Jv2NbuELHDm/tChUm4BmFKqDXeFimn+m0cGSQVUWylAwc1Rw+V0RZmxnf2ReArWy1eNpYqYBwL2Qe58b+NHTY/voHkDIzIsfR/b9+4JFnFTRH0duZfgmwGX230olqEq62bEsP39QDVN7WexZXXS0UciRPNZuJ1kC9HIPX1ountqQmcwfHD4D/PLNrWcDnp4fwhYRW3Js6pSBizTIqXQmrtuvC4MIDmIvgGQsCVXOJOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/WhXpbi1/4lNVY/djLSqOo4Q4VwozdjVlzo5iDcFbU=;
 b=l45wXSWLjq0APKmo4hK7S+Sup+YP4TAuMW4kIg8t5URy1wLayYUXwb5otxGOKPyY4hqMM5woOn+QimJ34HyzUWt1pHqt6R2/ZlEl14Wb76xmi8BLfPQ3GTevkW3zsh1ZHjSiEh2GBw/nQhcjquB+9qRlYQXdbt0LLNWehBBTE+q1qU0Y6EHit5mcdtqYRaczJgXR/dayTRNTPiD0c6CE/DBAtZ/DuCZ3KJYXr49B+m9jtE1YTltpmENaybFcJzUdbdzFWZQ0B6CpV6IFExTcf8V5nVgZJ8BOCzgF8h492HkE85bFJYOm6HRQXoaB+0hX0G4wn2EUJOcAYQFIcPtycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/WhXpbi1/4lNVY/djLSqOo4Q4VwozdjVlzo5iDcFbU=;
 b=o29XHHTyJ+Q5gSJoewvuUuH+gVjW1gsiPZc/XXso6Fhp6QeDX6fJWsY/xSXEQutYJbdqF3sd0jv1WkmB7amfEC+pkI9z/hC6VKCJjKLcEyttO2snleU+qbK8Rq013XuzFiNKiHma1C87v541dqLjIepFqWMbXY/FlNpOw9+0VXY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 22:52:15 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 22:52:15 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Sync with VM root BO when switching VM to CPU
 update mode
Date: Wed, 20 May 2020 18:51:59 -0400
Message-Id: <20200520225159.977-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.54.211) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Wed, 20 May 2020 22:52:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edaf5dd1-8bf7-4532-7b00-08d7fd1070a4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24454C8BB1A6A3F5CB08BD8392B60@SN1PR12MB2445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHv60BvkUCc3JkvguRTV2jR84KFHuhdD3vVXvLi2KQ3S1UCV+o0NS2PFNWPqBdLgTC0blSVnTHiQFf99mKAQzR9G49KH+rrky25e+u9xXHic1sUVFRhMhQBpFLi631fIKs7As4fBRBBrrQ01ypKzdmUvIeYUHN4cQQHoHGnrQ0Yy5uBidQ7bH0g9l1Uwh6ckd3NgZGAtAdRADSvwd+sopFDspv0OuBR1BdBTv8OtP6HQbHGbWUYXsZj8rSmMa14RDWPZKFYaklfuE+A270/u04FOUfKg7hYsiu2Got+Vn5TkUawNL5Smt90W9zEtdSAAe2r8rXcCStB45dQ0MKadKQJTIPed7cc3ukdl59cxxzNUX3Q3cvMiHXkLBD13LusJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(316002)(8936002)(69590400007)(36756003)(1076003)(6666004)(2616005)(66556008)(66476007)(6506007)(956004)(2906002)(8676002)(86362001)(6512007)(66946007)(186003)(15650500001)(16526019)(4326008)(6916009)(6486002)(5660300002)(478600001)(26005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: l90IlfWwpMf2+OzBTrPgR1NIyOB8HpGbOAgi8JBxqPoppAVUb9kECxypjrx1VdhNrO5cbYJpX2EmcjcVjkuocBbKajf7dcv/8q/Dwh/FCFRlY+fqQHZL5ejYDZFwRIUDrzguG21UqJseL6VqHpf1Lj+UYybUmL6S89PymumJnKbj7oFJK5HnmckOhY11sTn7IFq2CX+XsPNXpWjuf69ioc7I7zgKroAV5lIIS4o+MJvfu4hj+j4N3ptCYitTtvhlsmomeW4DEqemd9XbCcNHdFqi61o3ZGiGUkKxaAbRCcTVvrVQiQ5DxNXKxnPda8QNAgoNr4vLpgc/Rtjqd1DKOJ8/SBV1i0drGVNxXnqPQVHPl+dog4jLMUQeOOm2OiJ15XZCOuNx/CTI9iE1/gErV0I4sx/w19+PZuCZJ3ytrdqOIxI9q24MCLmSqeFNfrplgSLFPKUE6Um1L5g8ZwSPj/zd5w5uDZtSylFwiPPAtIkKUlXg8yWgWnwSZ8m6jk9P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaf5dd1-8bf7-4532-7b00-08d7fd1070a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 22:52:14.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osxZbp7xNEcR2pzm0dInrJ/0RqKHuCq9+Nc2YGEayErzMsY9CVmlrmtMMIBNqyFz+9OVf6nlKFHbDvYidFmJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
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
Cc: jay.cornwall@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes an intermittent bug where a root PD clear operation still in
progress could overwrite a PDE update done by the CPU, resulting in a
VM fault.

Fixes: 108b4d928c03 ("drm/amd/amdgpu: Update VM function pointer")
Reported-by: Jay Cornwall <Jay.Cornwall@amd.com>
Tested-by: Jay Cornwall <Jay.Cornwall@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 414a0b1c2e5a..7417754e9141 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3000,10 +3000,17 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 
-	if (vm->use_cpu_for_update)
+	if (vm->use_cpu_for_update) {
+		/* Sync with last SDMA update/clear before switching to CPU */
+		r = amdgpu_bo_sync_wait(vm->root.base.bo,
+					AMDGPU_FENCE_OWNER_UNDEFINED, true);
+		if (r)
+			goto free_idr;
+
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
-	else
+	} else {
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
+	}
 	dma_fence_put(vm->last_update);
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
