Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D0CC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5241120740
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xG/F/IuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5241120740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6739D6EAAF;
	Fri, 20 Mar 2020 00:23:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDE96EAAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 00:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovw5b6X1GUsbDv8uYg5Gjq2v71h70fU6u1joOOdumBQy2bnpm352EJqyUaWiFY0Yja9nV1poyMFuveM4g3RntllJtDehacsmou0CN1PQ3mjgGFwXnWJfmQPfS3cCLUK3JGuyGlox4gfOoGzvXmCKrE3gsUrBbOCE619GghR56Lz+JLbhVTM/SY/6GhbKNDHo7kYbLJeCh9xmQT2mRIlQuP9/RP+V3Zkns8FsuHhlFFQCW5ddwK8rTX6XroWpjnZQ8wEp8cL+jYiiq5n1Jjya2sZdzlA4hRuskSEY3fcsUZRoUgFvopb+hyaaFxIGxn2H3S5+bG3iQljcLQZRtx2RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWqIGfdS1061Hn8qeEM3i2mdSM8qK8bhzQlPNKp3de4=;
 b=OxG04GvenGsH6mUGsTYFQg7MwRtwwVToPGqXd4r2jDCFvQj2ZU8yIO+TbJZDQ11wJsL+/I/5Mz+Kfkjfj1B9kY/qqnnsy17QVQnF/T4kO+zrKESa44DuS/DiOFdCM73Jgs9ctSYkIAJTi0p9tWfsOr2qbDG9PDU3betXU+Qr5D3Rhh+FfhV1cZLC3jo6HElUDcVptxTejbaU7ZDVg/CPr7uIAXCDmOTTkR2h5ULYG9B6OwSXZWUWEGEAqlzAjNzC5712WaCHrNfFs8ro+iDKtDzu9FVh6rbAxftI1SrVchUUvam2EKDw5YgjW6377uaDzI11n42J4VvI9lkyuQHPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWqIGfdS1061Hn8qeEM3i2mdSM8qK8bhzQlPNKp3de4=;
 b=xG/F/IuXwlQ/e8wo5kjDfdL+bXokA2ugoP4ya9CVSMiGLhbjTuBZ3Qdd++itZggk2YIOmOhFgcJPBaN0KnKHozIh+pxJ5FGtsBIUvnZZlj8UEv4qUgWTYNwhi8KyDxRYRIvMIL5e2GN2geZHMu0xRY2vcPiSCngbqlCUWcmdHcQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 00:23:31 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 00:23:31 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
Date: Thu, 19 Mar 2020 19:22:42 -0500
Message-Id: <20200320002245.14932-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM3PR12CA0130.namprd12.prod.outlook.com
 (2603:10b6:0:51::26) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM3PR12CA0130.namprd12.prod.outlook.com (2603:10b6:0:51::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Fri, 20 Mar 2020 00:23:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c868ff7-c41e-415d-d87b-08d7cc64eb12
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:|SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43651722CFA30CAD5B6C2E6CFDF50@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(6916009)(66556008)(86362001)(36756003)(6666004)(81156014)(7696005)(66476007)(6486002)(1076003)(478600001)(52116002)(44832011)(5660300002)(66946007)(8676002)(4326008)(956004)(8936002)(186003)(16526019)(2616005)(81166006)(316002)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4365;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DllaamH+hDPA+B9ri2+VJs68t57kPGsiLChWGpG6B/kVUvRFA/21rP7Gf0+VstVEEDO1RJ5it3mBRzvqRIMiUcEGRQhwfJfV5K95vYRPOUszS5N4ilHSCHkaWjQlSbnLmPF7qPbgjexOQOIXKRtmc+XziUywKAKuIMTtYFbUt26fbQ6btbMDYSz4iixOKLGGRZwIymByCylE8Hr277fKueED/wp14u99I3CRF8SWHoSnR7ThuVmQaQ0CGJXgFiBP4BfKofoXC68yDCUHEbNwaZ/ScwIO3BLTEw4cP+yaA7B7iLBewzqbHm6DJmBlcXVpPB8S65OiDt5p0gonkbTT39FoOU8UfIOlsOkKqHWL1qTM8cruD8tfZZhaIKB5imHGyPzcjkoIkhTqUCxWjgjYAhmETsJ/T6OIxI2zTQCUPhfcLLqUlQT5l3SkdmP8Ot8
X-MS-Exchange-AntiSpam-MessageData: Qe/YxkbhB+KaGCKExUgPjSnLSMr6+mPWblpz55BiuXw8xAgBA1AFT3gTDJEq4Jme4AVwl6c/5uZ9kKE6tRKZlaYN3tO76ZGRh+He5I4gFqM34usuk2jHRz11pxmP/sB4wXKAupt7aytwQb9YTGcggA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c868ff7-c41e-415d-d87b-08d7cc64eb12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 00:23:31.1131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVQnUoHndgqkoF3mR8TQxvwU7Kh376U+naYlBp3kYMgbHLKBXsqCMsVo8oJtMqTJmtMcSmbT5FoktyY0N4lgWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arcturus and vega10 share the same vega10_ih, however both
have different register offsets at the ih ring section.
This variable is used to help calculate ih ring register addresses
from the osssys, that corresponds to the current asic type.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5ed4227f304b..fa384ae9a9bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -279,6 +279,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 				amdgpu_hotplug_work_func);
 	}
 
+	if (adev->asic_type == CHIP_ARCTURUS)
+		adev->irq.ring_stride = 1;
+	else
+		adev->irq.ring_stride = 0;
 	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
 	INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index c718e94a55c9..1ec5b735cd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -97,6 +97,7 @@ struct amdgpu_irq {
 	struct irq_domain		*domain; /* GPU irq controller domain */
 	unsigned			virq[AMDGPU_MAX_IRQ_SRC_ID];
 	uint32_t                        srbm_soft_reset;
+	unsigned			ring_stride;
 };
 
 void amdgpu_irq_disable_all(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
