Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8935C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E71320715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S38QmzMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E71320715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4226D6E2F8;
	Mon,  6 Jul 2020 05:06:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCCF6E2F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRfs7bhv/qZO3YYPMxvRY2qUn5BIptg8qSOvNxnOZI/cHXt5P/pPpmqRM0Kkxpghg2B8PCvUi+MAMpmY0HgBMQyRbphQA5mHsJCgeAa85N94I9vdTeORmA1EMGowHx9kga8pQYWmSSXHBmWgwM4r94QmUs3QTmDdcBnvOdTAWFy9AkJRkME2uEkkeJdqrNzYX+qRaMKy1xJninX5yZ1WgUlT/md7LeTJ9Rv4ua8o9Y5byi0gwFgrZ7df/cwmW9UTPSOM9TYi2+FmP0wNyGVcTgu4RTNLEO1kOFmvwGai4wSEEBfvuU3MevmV4J59KAo5jkeFHaWHCNse90FmI6ZRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXd2ZereVtUHpMUr7XFS7sc8EIGwJQlndqOvnKypTQI=;
 b=YTy7NtOAJaDvA37BKdtRXqtCbGtPPjLieY3CdM8BwCi6WLb/P9Vs2NJynzn7SJTl0C5KLvYTjCr3nf3dXUP25q3ahQNRi3x6z2Ltxt8gDQaJM4hfG66CZH7Gz3+OkKkdY7N+DE18p/pnZ+rrhMcp0um9oGWJWB3MfV1Hm3BRIHrMgmNUWUQa1Lhi50BiYERDnEXBkxDEo5BIsF1ElRYIzdajEeMETTvefJUBeN4t9CYld++sVxq5W36C7cEgQbcg2da+WWohfoTSCXZyaS5dwI4obujzIFZ9QS/wZngGICGsCL6jgBW9YdtM7y7rB+bzO5zZThJ1KlX9Nw+vfWlhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXd2ZereVtUHpMUr7XFS7sc8EIGwJQlndqOvnKypTQI=;
 b=S38QmzMjQK+lu4v04gEPD4k+RiGe8wR420bkSJMF2JYC71SGIleZkwwALpGqaTuwPIo1XkwBiRC9weaUsujmS9KOO6HHZLbHjRQolPzgzzGsay6N9NO+o51o+Q5GQvOsnZP/8NvNQzUagQRyJtvsPmn7rjc8cWXV3jjzkQoFrlg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:06:00 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:06:00 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/12] drm/amdgpu: use register distance member instead of
 hardcode in gfxhub v2
Date: Mon,  6 Jul 2020 13:05:05 +0800
Message-Id: <20200706050509.714975-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d1826d9-9319-49d0-23ff-08d8216a462e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB447043407D38994D4BDDD713EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxmRjnMav9jcbKyLesvNaJI1MZst2fIdB/HAYPqaX/ZMKTxZEDxko3BM9fdVd1xmhXPBBROrZyeL1YcQACjt1PD06dJjDiqhkxuD97XXmih1DRhV8Xlz4Jd+zo1c0TxyO5sVknEwNcXj4jlUtn1Hg1R2TwjBPAEiwBiypwyERwLCN3+VROlYIqYkxKAX6dfVomAQ8FCidUPJo15w+3OFH6FBZDycXs3KFKFEH5IrU/+NnYcfWcnQdI9yT5o2SuZ/6jcID8/+BZGDAM4n7zEksPQt8C+Zu0y7rutpYN3n+m9+dnJjXwmHaJT55V8+OuKK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QKiHwIlmVAt3WzlpFaArAf6h9vjmRFYWVhX23o1ZpdosDkFW0Eeo4mTgwGFHngiueX112byRgrXMhiKVkqrNJmi/Pfq+tjeVQg/fojv25IZWkXB591ta2nrTQ8G6U7GiTdayLZB2F68Lr5Ug8w2b3EwyYSLO0uTUhIo9smVbxPO3I8cLHWQLrcz2KqS2brD9ChDteq9MmFqPaZQxcJDBLQ6hu7SszDeGChAYoyhGnQKqtgNZy0o4zLOhBGltwTUQ/FwtpdkY6pAxqqpeGsuEarqHrU3ytbJ4BEFlD6NcreNwndP/bEKMUh3WCqSMEjquZozk+QgKdHMGQf/E7TpBctyupHGPFeFdVjPleqd3LdbOizClp9i9UpckykU6DnuGTy1Ca8/JV/wzZ6T4w3mDhBy16xSx8cVgCWMD+uv2w/+SIx1sKkYsvtJEV1xXG/CenOH0Rnz/eT4pQ+0xZzVXNy6pUT7Nt2PegPZlI3ahV1GOVOAc2xLF0YrIg4iSphOm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1826d9-9319-49d0-23ff-08d8216a462e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:06:00.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54cPDSC9/LKbPUEfNMTopUmUTieuy8/YXyUlHpYiLBALefW5xVfsBbsYcjxrKLszt/n42qWySOHiDbtNpQd74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates to use register distance member instead of hardcode
in gfxhub v2.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 39 +++++++++++++++---------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index e4340b27d204..394e6f56948a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -49,15 +49,15 @@ u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	/* two registers distance between mmGCVM_CONTEXT0_* to mmGCVM_CONTEXT1_* */
-	int offset = mmGCVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
-			- mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 
 	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-				offset * vmid, lower_32_bits(page_table_base));
+			    hub->ctx_addr_distance * vmid,
+			    lower_32_bits(page_table_base));
 
 	WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-				offset * vmid, upper_32_bits(page_table_base));
+			    hub->ctx_addr_distance * vmid,
+			    upper_32_bits(page_table_base));
 }
 
 static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
@@ -218,6 +218,7 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	int i;
 	uint32_t tmp;
 
@@ -247,25 +248,31 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !amdgpu_noretry);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i, tmp);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32, i*2, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32, i*2, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,  i*2,
-			lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32, i*2,
-			upper_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				    2 * i, 0xffffffff);
+				    i * hub->eng_addr_distance, 0xffffffff);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				    2 * i, 0x1f);
+				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
 
@@ -287,12 +294,14 @@ int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)
 
 void gfxhub_v2_0_gart_disable(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	u32 tmp;
 	u32 i;
 
 	/* Disable all tables */
 	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL, i, 0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
 	tmp = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
