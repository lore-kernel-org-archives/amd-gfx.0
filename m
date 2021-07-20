Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51014C6379A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173D3601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173D3601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637A56E44A;
	Tue, 20 Jul 2021 15:44:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621CD6E44A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leKe22KaSo6ux4OyumkgBx7kUUdobeKW1yb0duKdglOR1tyxbjG6mn6RbF38ZJuJwJP+j9Fc4TcFomb0ZR9Bo2/Qf6Vt1cUCMapGAaZz9sFshIWZMkpPP6VdBZ+IQeXEmRLC5qPs11BxZ2WubfZHsdyTAjbkAyMqHj6/NVfvyQnAPXrFHNAZ1VHnHRXrnY1IQd4Kq4sxn/n2MCwCx1ety3Upz3CX0vMQs2KsK55USI2SMeRVzhYwa6n+4/QdOmRyaZtcUud/k/hspW0yqyeq4TrkyQMl2ywqyuEy7unHOQR6tM4vxWHciJC9ggFghNXrzYgTtvGWvomPWO56luBIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dd8sKz4HFBlzM/rSYo3f02il03f25G+gh946kBEJdE=;
 b=PDr5eWwMScIfbok+xkwfRoWyQYo5we41ScSfy0lLguKThroRknFTe/MA6P0OnHjwqUwslOr0/phe7RSV/b4/xPNq/h702Gu7MpBYTieZ3RqhGNyiyzkQGBP/cEGQGF6yYKL8WKwUHm9jgtg+0jDvk3K9SLbVU+LVlG9r0edISlKsNpIfTDFUvbYCs6cQALj3ioufplQIPHDx+t/gSgIvcD1iR6rZAbbDaklNorJ37KWOZaRqEh2JjlI+S0YHyXmrKSL3e6rGmEHOL/2UBPVI6HNZmUsHQaupuMtyNJDRMiMSbnWzvr998Dbtt4evKZG6rUtRTlkfe9HgOg5TSCbyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dd8sKz4HFBlzM/rSYo3f02il03f25G+gh946kBEJdE=;
 b=oEsfmZlu6pFRmo9t+5+THtU0XNL8FiAV/yfmCzliKZ4EFVATnAVPrsEkj7wsGMiAZnTYKaTF6u7xLEugedqadPnrhZhkjWx10QgFKxp5nB30zEQ+0Wu2vkSJe8WG8zEy248ShDoEq7cY2wcAFsp1xy5LTP8Sbujan+RHSoJ3er0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/29] drm/amdgpu: enable SMU for cyan_skilfish
Date: Tue, 20 Jul 2021 11:43:47 -0400
Message-Id: <20210720154349.1599827-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa14275d-098d-4a57-f6f2-08d94b95425b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55384E29F84D9217ADECC948F7E29@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsGo8wKIJgEdEYpeCTHQqKmghI55n/QiiDBQJYjOuMQFBTkzZ68xNLEuC6rEkLZOpZorRVVEtPUkWWtXpCfB4A+N0BK09vOPL/2SEhxvBOEWyzdWBVJ7kz+AXsT2u60iFhojY7YpwEpvniwmBQCaQr0Y5eVnLH/Q8+LM85MXpVA6M600qS3GWPMmEEhywiev55ECc75HHi1+8eZgwym9E43BPTRXSu0RoGafZ6BMzxEdm5flXWu0aPUzy2N+cx5fYQU90jojMYZP7BId4JR1cSaBay2NTBZH2pEjjRlnXdqZx92SbgSZEVAtuyHzvzWLL6U4Elnkml0j1esPH8+TD7Ymf3Q6weUKnV0tfk2Q+SEDCk8phNmu2OHCQQJ9AegrbAvmyQwYEhxwqfWaraVLJLE8rNoEO5LbSq+N30MEJ7dXwmbNzPa9t77QE2wMQFmuBa1Mv4yAmK6dxqmZQDGv/Ow6R6K9S5O6mZUVkWj1bNQnIerx6EwMng9Nxr1QjOnTuYEOIKDPKqJElXdQnj7w13N3LhPZWCxQ0v943T9uljpHhIAJ1o1XErbUFX3crWcAaRVP5IOAhj40xj9l0+lgh/eRkfDOinzOkknak0nmXo9ke8bdU+5Fe7BW363KIJgiLyvoo1n5cPW4RWK/6t5bYJlLxYEjbAjHYfy4BHjEWxjaPoWFT8V6WrCi4+JSkIsg5GXbrH0nih1NO3jCt25d0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3H6SjI3PURO9mZpsUq2z5zwMILUPIZS0NNb0LOXU3B07oQQTCQHuElpp5S0k?=
 =?us-ascii?Q?oU7TQwWPwANgez2MHWF886QUhYz5c5HEKv8Y/Qb7OKb+B51Ka0WKFRVbaoh+?=
 =?us-ascii?Q?yw8M6lNrZA2w/dFoyGAcL8KYFOy3D9rH49kdSGXLhZRTez7xUTAMYPAmchKd?=
 =?us-ascii?Q?RW0qIVwmygjqdmr5ZMiSodMxdUElA5kB1euyOo5vDyKeTdGmY3tqYZvtbHJQ?=
 =?us-ascii?Q?RlSordoXGaDZzwqKMv8rFt6ELrB2rrEXT/jVZ5tQRybHVdZDMEaDZskR1Xeh?=
 =?us-ascii?Q?4l7u+ZzQ2WHSv5Vysy3vkyTG3sO1WqXmwBiKyBXdvzcr/EQER0SjzNB7tJ6b?=
 =?us-ascii?Q?VOL52pNlaTJzFPWwVkfIrs5o5pNQB/KkD6PUfRjVfOnSh7NfgjzszHwfFHQQ?=
 =?us-ascii?Q?hmDbJsznvpTj1yO1cxU48CFxlgezmNfxcN9YT//9TP8x/vPuN9rZpXb01DzC?=
 =?us-ascii?Q?iJRkhOvQIlkMyXItAUfNksDNIX5CoIcHaiFJa6qrOZXLoNznLjMrvANSm1yD?=
 =?us-ascii?Q?Yuw2k31mdGeXsfbDBVIycHwuiwmLk5QxxJRPSCgBmtCqf4Hc0/M5HAZnS45T?=
 =?us-ascii?Q?FmJ0/OusSuPdmZYZFg88pP2OlkbUk/6p9cqZy0WCEH3BR4HDDh14umEWp1ZW?=
 =?us-ascii?Q?wf+fot+gOfSqH94jkXysbg1NwjycOvB12a40F2SJ1tKN+Jka/erN/6oRcnBG?=
 =?us-ascii?Q?f+Uw2lGuVZlPTlJbo2g0J65a9Pa7Ann6Psico9HqJ0u8jvPvOKzYpAtG1dF4?=
 =?us-ascii?Q?+dvgKshCrj6A43ZaGSu5os22JzZ00qFmRCdeNcNnl02fPcFiK/2WH3U9fhyx?=
 =?us-ascii?Q?/GM90/7+sja4I0ThsYC5GvpTmwBjUpBhk7zF2UfdjFYc9EJ/Gckk+DDBKxM1?=
 =?us-ascii?Q?HbthzJFcwp/w2jB76bqDmY0f2P/gc1/nu4SHWqwhj85TRTi/FNCn8mnyWG7l?=
 =?us-ascii?Q?/dXzIyQS7TkwW5pt//31p66HpmjE5mLcrDLaIHseqg4Iht2NQIVZf0uFQioB?=
 =?us-ascii?Q?/pQmPSM0vsmP35lEtW+JGnEl44MfJA6gkvil59sFXD0lMgaJkERUeSW8N0MX?=
 =?us-ascii?Q?HNncw0OriJBROKn4/tnhwgAJuAoT+Om70oiGdeKU36Lk/jUKQZ7hjdHMOysX?=
 =?us-ascii?Q?NYISh46XZ4a7zg0LraaVfQJigRr51kwWoobmm7kYp0B7RuBg/5Jfitm/mBxC?=
 =?us-ascii?Q?mtRUd9LfK9AW8ZuQaflw/MfnG/a1Z+AzMzKH4tHUkUDTChD4D47DT8vbjF4y?=
 =?us-ascii?Q?wdr6nFyN/fHbUPWYy0a0+y65WndhWcRBg33XqynFLTU3Xg26Mrm1Wlom3D6d?=
 =?us-ascii?Q?z64ztMeIHF14OpFAEJntxJ6r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa14275d-098d-4a57-f6f2-08d94b95425b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:28.7379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGZWvZKxhIclMKHF5RzajoUPYR8TAs42q4D67mZnckIzhme1qA17MCQ1pQ1VYLNWFtuYl0xYwX5b9oL4XHbTSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

Enable SMU support for cyan_skilfish.

v2: Squash in fix (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 17 +++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  4 ++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 894b55d1e10a..a0ebe36ce85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1048,16 +1048,17 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_CYAN_SKILLFISH:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
-                amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-                amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-			if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		}
-                if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
-                        amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
-                amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-                amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ebe672142808..d68c78be9e98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -36,6 +36,7 @@
 #include "vangogh_ppt.h"
 #include "aldebaran_ppt.h"
 #include "yellow_carp_ppt.h"
+#include "cyan_skillfish_ppt.h"
 #include "amd_pcie.h"
 
 /*
@@ -588,6 +589,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case CHIP_YELLOW_CARP:
 		yellow_carp_set_ppt_funcs(smu);
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		cyan_skillfish_set_ppt_funcs(smu);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
