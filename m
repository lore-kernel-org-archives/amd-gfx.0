Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E11C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 05:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94038214D8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 05:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hn/UFYLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94038214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063246EAAA;
	Wed,  4 Mar 2020 05:39:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFD76EAAA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 05:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+um9X+EW+TS6Vmrf1YJmN1coDVO9DShqwLtAhxuasjXDhvZPbyMnsi/mhigq2DfqXBpsWSX0jCHTiIMJlC4404ZH8vn4BPRFbyzQIBRof8bLKDYFAN9Qo9in2s6PtjJ2diU7GdRo/thx5wQnVbAglMCw3lg+XCBylPz4bVbor5OCChUCk1Rq0HZ/gCEZvYVr331ZVIlpJkY/yUFrUgFE5SLdP6QF4f4sPpTJF3SfYVPGvGT8/iZHve0s6/qqMTAbeteijcVl+P205rRahnsCOtKaKzxCVOgveRDYk4LfH2TADJoFnfyAZlBoEX7N7xjTuWrDaPiaNBPw7wcVpu41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87R1rvXM7CHyXIzMUPo6OEWuOdzzurSRXsCZe0TIJEE=;
 b=nbbL6148R+kr9ootzuaYeq3oer45pGIUdGFD5WGVs+LjSvWjbcHrO2X80iVmSTHeTsxw0gxmn/XKr+I+DzqIuTWURiWpKTZemHmmd1l09kumqtUZJtxETgWS/6YhR9rP0phCvmxvrd8aidc/U0M101oei5SEM3Jnw9ddnFMELyrq1BGeWBAVpRSpiSExdlT2Gttpfa+b7g+FBiTM71jP/UVT5zvtAckjNpBIhdz2OKMrUMYYDbKI5DpgPH7LB5aJxNAHLFmo6LCcrJL9XamSdZ3sQyxkEpiJhbipKLEjrgXX+6FNSceCMbP3z0QEHZXg2Dnjt8VcS+lAwvNJon/3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87R1rvXM7CHyXIzMUPo6OEWuOdzzurSRXsCZe0TIJEE=;
 b=Hn/UFYLmbx4Ii2uzpmRsPdFbPG4Mio40ctiiPQWQRSLbJBftcX0oojkYwfxeR0BQ3sjkeV6TgcjdlSKcs7llZT/pQqxV7Ds6PUcb0Acm6lmwTvNqvGgT6VcXPvuoBSNNeqJRHhcjZZcfjpcxp0rUyDBAO+9nzIEjzTnBjcz1nxM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
Received: from MN2PR12MB3056.namprd12.prod.outlook.com (2603:10b6:208:ca::15)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 05:39:28 +0000
Received: from MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::10cb:fc6c:98ff:d995]) by MN2PR12MB3056.namprd12.prod.outlook.com
 ([fe80::10cb:fc6c:98ff:d995%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 05:39:28 +0000
From: jianzh <Jiange.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/sriov: Use VF-accessible register for
 gpu_clock_count
Date: Wed,  4 Mar 2020 13:39:11 +0800
Message-Id: <1583300351-3896-1-git-send-email-Jiange.Zhao@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To MN2PR12MB3056.namprd12.prod.outlook.com
 (2603:10b6:208:ca::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from navi12-sriov.amd.com (180.167.199.188) by
 HK2PR04CA0080.apcprd04.prod.outlook.com (2603:1096:202:15::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2772.14 via Frontend Transport; Wed, 4 Mar 2020 05:39:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3bfbd4e-bf05-4297-8491-08d7bffe67fb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3981:|MN2PR12MB3981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39810B251F3FF735EFF36C98E1E50@MN2PR12MB3981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(66556008)(66476007)(2906002)(478600001)(26005)(16526019)(6486002)(66946007)(81166006)(8676002)(52116002)(186003)(86362001)(81156014)(6666004)(8936002)(4326008)(7696005)(36756003)(6916009)(316002)(2616005)(956004)(5660300002)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3981;
 H:MN2PR12MB3056.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDVV40uGAdIQSmBB0zkG6qIiHHkvLUcbrtpW241aHWUIHf/bzVMRY/zff/tc67/5xZ0/038GgBxpAWzf40vWcDH3jVPVotESEZUrptDvZsX2PIM0Pl3DKRxUrPmWRvChAzBTDHdvg0UHdplANV0HTg78BMPBcvFdSHIlpGqA+faj9YG1eWQ0iaezZQ1M3sOqkYu7k8wjn+/ACDtCvU8hA4gbDUqjG+GELBEPDjT619XNc/5mr8vVldWsmOh5va/+WxO/M6ht/LEr9d7lC9ldzmpVEM+d9XltUm95rUZ1atWdzUPqkSCqHvu/YS2JTOdEWN4DbPjBGRrskVrFyyLoS77tuB18dhDTG/iseVKYFGHBBQ1TExzsenmj56HEp+myT90dNtIQv6QUh5wULHZfzU+6/btHH4+SnfAlBnM+IwB/035upO7A2JfdyCYH828IpXGld3/iG6KeZwdgCq9gXH8U3VzD+G+OswoPv61ajEB0QMnxjb2Al69JnDh6rZv+
X-MS-Exchange-AntiSpam-MessageData: jTAyW25BaCTqcXt/2HCshd6gqhy1Ur6zLCQuH5ODNnhhj826i21bu8IcckvmhGBNfmrFQxXf6TXzS0itq7d0E3qToDd/4t83VaaNtyXp59EZYRmFR0ElvH+u1wcKDialtPYFuj87k0yxXpfjgZhCOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bfbd4e-bf05-4297-8491-08d7bffe67fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 05:39:28.8476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: garSUdOA8j2zz7bpW6Y+0qt80bs561Lbuj/MIqZm86U2bQYhkiQeCBJ2XHnCRzCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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
Cc: alexander.deucher@amd.com, Emily.Deng@amd.com, jianzh <Jiange.Zhao@amd.com>,
 Monk.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Navi12 VK CTS subtest timestamp.calibrated.dev_domain_test failed
because mmRLC_CAPTURE_GPU_CLOCK_COUNT register cannot be
written in VF due to security policy.

Solution: use a VF-accessible timestamp register pair
mmGOLDEN_TSC_COUNT_LOWER/UPPER for SRIOV case.

v2: according to Deucher Alexander's advice, switch to
mmGOLDEN_TSC_COUNT_LOWER/UPPER for both bare metal and SRIOV.

Signed-off-by: jianzh <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 03655c3..22a07ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -35,6 +35,8 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
+#include "smuio/smuio_11_0_0_offset.h"
+#include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
 #include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
@@ -3925,9 +3927,8 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-	clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-		((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
+		((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
