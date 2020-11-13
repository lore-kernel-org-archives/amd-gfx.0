Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D8AC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFEE221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KNGyA7tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFEE221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177986E7DC;
	Fri, 13 Nov 2020 17:34:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE216E7DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eja9/Af2KTU72Hi+QsUFSbwOidxSIjoXR6ZWZaSrClgNdikRmBPGaktuINlEGLLtk7B3I2Pvb3F936Qw7ndHXntCkN+IfK39R/G41jfovv+MCEy2ihNBomysEkLnvEQbDTt/5TJX9/97Ab0DHZfdlUqT+AXvv4jt9DIGlmrmEZh7eqEDvNLzHxl8CB1bcAmpUI+7l6deuf5ynhni/IFVnHoljAu+ZyRudpUA300+M+c6VFBLjXMeOgNvn2serAKWVn83aykrsL7Ewk5isHB/Tdils2gcRKY7/tuAYScodmtmOc+XKx32gVvQ56TuwEHXFqCgvBd8CuDU3EFNKIvf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xURwi22sGmpdileHtiEnV4zDYTtCGI8kldntALaOmo=;
 b=GSZ5BdbpvjFvjUHpAE9DuUErtLda4AGxUmiSI+6YeYPb7Iq0+3gPlsbk4Yo01ikqofjpRix01XabNKyABOxI9XFidFL4S60VUiFqlBqGna6WZWzktv4lKkhXoZKpc1CpYtFuZSQOFeyRZgkqC3DoqsB2c0953XUtgPWrPKdDIyXyouVIY8dDBcCxDxfybfk+9MRJVHmF4DOjAXCB98WfGULUkIAp1MvuLrJ8g5sqRLeofmMkJe418DUvWRf6DIr0K5oziCilNYRbpd227/RLACIwHWhFlm0qc6+MM+ZrfV7tGNhjn9JlBlaNWyIFIQs2cTN/XfHWS9VYVbkxJnA40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xURwi22sGmpdileHtiEnV4zDYTtCGI8kldntALaOmo=;
 b=KNGyA7tkPVWrbZH43kOkAKUEc99+d3Ns1RDlTlB9FWBoVKxa0BmB91RkL2l9i0eSKM+jar0LIh+ohPaRCXy5WV8LBDVjMYwbvg73/GWE3Z7jlYrmP1RRXt7AqL+5S2Fq71ioOFLSYwSMkp34kpPYRwuEs2QJkyUmYWFlaqmnHeE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 17:33:57 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 17:33:57 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix usable gart size calculation
Date: Fri, 13 Nov 2020 18:33:46 +0100
Message-Id: <20201113173346.38622-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR12CA0037.namprd12.prod.outlook.com
 (2603:10b6:405:70::23) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR12CA0037.namprd12.prod.outlook.com (2603:10b6:405:70::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 17:33:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9bbc278-3e52-46d7-fb9b-08d887fa4c9e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0187FA88C3A29DEB569C2AFF8BE60@DM5PR1201MB0187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj9kE/apT2EyVP86Z8LbDAG2qABEWNhOQkiReymXLs2L/6r9EbOMTrkddFcrrOO6uMDvbB/rvJLjBYRW7e2GiPVhkeAuup3IG/8GQci5k7SVvyYzmiPgQ4kPYENijefReUS88rR+AV5i4XPj5E7fEjvbkLJX30NHQD0YOEOZ1LZly1ux59T2qT1It2NCqSXjsNVYwp5BQnHEZvSGfThhiaKYD2c/87F34Osk6X4N950VfGZSDqXMYTzdlTaCjgmHHYJ+QsqriugBM0T/NsK3WAT+6ukFLYY2Wkl9N7CsrNGrdrdBdh9ZcQdjaMY5umODecabanuXaQLwGGSb7g/4jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(8936002)(316002)(26005)(956004)(8676002)(66556008)(66476007)(6486002)(66946007)(6916009)(36756003)(7696005)(44832011)(186003)(83380400001)(52116002)(16526019)(1076003)(4326008)(478600001)(2616005)(5660300002)(86362001)(6666004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Eo/hHnDTEKXY5ef+9swtsxMrFO/V4BEufdiTpADGoIijPg7Ytw5N8iA16OpK+RZLnuNQJVicRBaMPxSaGM+0wTHDj3KsgQB1+VwFJqmIuLacCOFIJVMX8kZyCkSlEtZvvneNc0fi4Sd3bFtF+izEKitwaz4zfvMKJ/KJ4rjJm1e4wreP3W/to3bD9xjFKGLGj9gf3FCxta5LL36cZG48VUZNi7D5CSdH5HMVVS7cKNfGqLXP4kZopn8RYZpEWv09nhaRRs2uqEEepXzTBgN3ZpXkvX7NXP1MLjOPih9cNpJkNWNSBDpOa4hTkBA876R4irPrkuahdRPj5MJtmi+MoqaFFst6N6sMIW+xmIoEsRJXZIISHB8F8uxGiYGx0/Hfj1otAxnKgkSIBWFpzAZrpIGAclc9Cm8nHnc5RFuA3yMl9kPU+eq2GFi5bxWFIOFWjX8+57eOkHBOoNcUOIG82pubAqaZPoPjsFKxkfp3n4X18P9GQUwBkHo4WYf3LUWQVi+SgiGUsjjq/YuZ7W7HyFVQrhPrrDxzY49sHT5PReHRdYXIb7H2LB40WLfwXN9N5v9SEWED6DZW67tsn1cUkgIg5K6dDG5c3fjqUXJtRCxWfOAk58iLHG9+cf0NiWJoLzThc5z5SR+ns9vpe3133/QVT+s+dvS9Y5uyniLnhOL7CLkiAkX3IgIIdtKhFdFKvOv2LLpUkBs3CFlqAZ/YBuJEmcjPM8OaF/ySLbZJown6eAI1h74VMMFe1YPWZKiGN7UOqRNvUYCHaxsUQQc1CP3UbrjK26jUjqN69WDrBSynXpmlQuai1DaCl4cB4tMc0Jx+KpWHo1eWzlGB5rZrRqAgI/0tAUWryK1XGHpmucg8lxuojlbMAYZbfh0haCZaMTu213gilXFFFFFevCUoGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bbc278-3e52-46d7-fb9b-08d887fa4c9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 17:33:57.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuVLlEZxpAOt8H6DyIIMQCXK2BREVHUkdMd16sg81heNxFYlAIK/9gaT0tLASZSqisdDqoGZMrCdpI48Hi+Gmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0187
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

amdgpu_do_test_moves() is failing because of wrong
usable gart size calculation and throwing:

[drm:amdgpu_do_test_moves [amdgpu]] *ERROR* 0000000020bdc9f3 bind failed

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 6042b3b81a4c..7b230bcbf2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -42,16 +42,11 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 	size = 1024 * 1024;
 
 	/* Number of tests =
-	 * (Total GTT - IB pool - writeback page - ring buffers) / test size
+	 * (Total GTT - gart_pin_size - (2 transfer windows for buffer moves)) / test size
 	 */
-	n = adev->gmc.gart_size - AMDGPU_IB_POOL_SIZE;
-	for (i = 0; i < AMDGPU_MAX_RINGS; ++i)
-		if (adev->rings[i])
-			n -= adev->rings[i]->ring_size;
-	if (adev->wb.wb_obj)
-		n -= AMDGPU_GPU_PAGE_SIZE;
-	if (adev->irq.ih.ring_obj)
-		n -= adev->irq.ih.ring_size;
+	n = adev->gmc.gart_size - atomic64_read(&adev->gart_pin_size);
+	n -= AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS *
+		AMDGPU_GPU_PAGE_SIZE;
 	n /= size;
 
 	gtt_obj = kcalloc(n, sizeof(*gtt_obj), GFP_KERNEL);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
