Return-Path: <SRS0=udmR=3H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE378C33C9E
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7438621D56
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g2RZocCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7438621D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377F36F98C;
	Sat, 18 Jan 2020 01:38:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3932C6F98C
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2020 01:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/NcLk5M2eOK61klleJQXW5KKpKh2YBtJoJui5yx1axXyqPxUlDQTUHeBvTESmAh3Fjs4fDHADRzw1+BvHI+mZyA4hU+ruL46SDjM0WbVN9vQaqkLEDK/WXnIpjH6QVe1RKa2nyJ/vRS+ZEHy23gp4K51Ft7jUPtr5MntFdRoPRKx4uKQuIWevFvoRD2GAIYQp4QnKa2AxJZi9JCVm1gZnHzwPkOSfjdN3EOafACtnUgtmB/SMhYOQsTsl1Wadr3Yy6VCpdf+svGE7RQy6h7ksTrAzqmGIInXw4MgfBeHkMT4H7NN2/+Vl7QuXkfkWVpLezE8enNTBpvJbKZyxvufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnWdojzin8iv3BVKTr7boSVr/vxsZCLSA1e1WPYHgdE=;
 b=LnDOQI6Fry/A77ajieI9PRpbGscDkblMuOqtm4iYTjWrr2Z44WQSWDupyiNlcuhUGDk1LO9dSgar9h+U/gFyAMKffaeQ95uTLLmPKmPDr3uyN6FcPwpx7lP1WaxrG4JkyT26lJszxxgXICEBl5JO9XMlxxmQ+8CtTdNM/+qvP54kAKgbjouttxgiMMpusVLMrDtzJGSlpIkHzPbA5YavEFPI2fQQpcvxvAJpSZ7Mf6519QSVcU4vVBvG25fJjKkd4FEWQbYRue2DigA24ImzyuXTbVsGabjAA+Yqpg0++U1ebDmNuKdfBqc4av1Biv5kAOBkGb8DtB5yNQPHO1SMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnWdojzin8iv3BVKTr7boSVr/vxsZCLSA1e1WPYHgdE=;
 b=g2RZocCNLDVcBF+pDrQIPosLJjtJgWGqSdLtqGhSP8EGeeic3p+rj6jeDWDMXV98r54qGJlzO5PnDGKQQ7Zli/T+X8lcG3DwdQyeJP0ZqCs2NQk5VYVg+NKXLjuIZfHzSNQjzCi8kHeMplryXqPwrpAdlLcuQCpZNmvdNEPmtXo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0009.namprd12.prod.outlook.com (10.172.85.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sat, 18 Jan 2020 01:38:15 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.023; Sat, 18 Jan 2020
 01:38:15 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Use the correct flush_type in
 flush_gpu_tlb_pasid
Date: Fri, 17 Jan 2020 20:37:34 -0500
Message-Id: <20200118013735.19361-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118013735.19361-1-Felix.Kuehling@amd.com>
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Sat, 18 Jan 2020 01:38:14 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56bdc91b-082a-4633-bf2d-08d79bb7162f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009D95342CCC62A7E931BA692300@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0286D7B531
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(5660300002)(1076003)(2906002)(6666004)(316002)(6486002)(86362001)(6916009)(478600001)(36756003)(956004)(8676002)(7696005)(52116002)(2616005)(66556008)(16526019)(186003)(66946007)(66476007)(81156014)(81166006)(26005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0009;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdv9BaPmL4b5pYGoJy7tD+0OWttcWdIdESCHIZ5peQ6TnyOCfA4KgZaqe+tndSxxiTKcOyNLVOu6m7OFLu2upyHQxw6+ntliOwo4c6fN0vN3BZ5ZkyyY93IXMjE08doBNf61Iy5pvQGVibl/xz1SiT/6lTC2kqdntgyzR3AyEoUDowvmlLDX8WDZJcl+o7jCABYKcRmuXrptFzcyxgHMUQnGJZSuReAX/nVdY/pSa6ew5MXWHEeLFR4bB6dBjKWGoaZbwvTGLGlt8cbg7TbvSX+6fD2t4ff6uAKrDivqYUTajTbhaYNIbb99uSM3fcNvpQMGAclduxnevCy88L3kZpCctZy9ZuKlluN3JePbSTDKMfbWojyg9lHlSFtpVWL5YaXEEv6c4Eqzi2xMLnfXa/2R+e8oJ+oktUjkJ3hs76o0PFaKXNtRpYKjeqGjTiqj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bdc91b-082a-4633-bf2d-08d79bb7162f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2020 01:38:15.2091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGDJWAQnydbssSE2qxnhBb+zfqq9sCkjbgcAakV2/+H2Wa6eAMhf9XlFO+UJ4kxNelwBzxa/a6d5Be0FbyGTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The flush_type was incorrectly hard-coded to 0 when calling falling back
to MMIO-based invalidation in flush_gpu_tlb_pasid.

Fixes: caa5cf78387c ("drm/amdgpu: export function to flush TLB via pasid")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d914555e1212..a1f7bb42e6b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -443,10 +443,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			if (all_hub) {
 				for (i = 0; i < adev->num_vmhubs; i++)
 					gmc_v10_0_flush_gpu_tlb(adev, vmid,
-							i, 0);
+							i, flush_type);
 			} else {
 				gmc_v10_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, 0);
+						AMDGPU_GFXHUB_0, flush_type);
 			}
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6d95de1413c4..90216abf14a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -602,10 +602,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			if (all_hub) {
 				for (i = 0; i < adev->num_vmhubs; i++)
 					gmc_v9_0_flush_gpu_tlb(adev, vmid,
-							i, 0);
+							i, flush_type);
 			} else {
 				gmc_v9_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB_0, 0);
+						AMDGPU_GFXHUB_0, flush_type);
 			}
 			break;
 		}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
