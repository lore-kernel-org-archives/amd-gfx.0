Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B7C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC5D21744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MH+NyhFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC5D21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0E06E900;
	Tue, 25 Feb 2020 20:20:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F71E6E900
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 20:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw421E2mm6790z/3EZ+U6/nn0DDCtKZZzYa4a8dmhta9onVLjrN8W0j4nyh4FUuJbvYiD+taUHeJDinUGwNIRfCk4eUMqj0q6Lctgdu8aBN8Xi55je5eAKkkqxeSlcGpN2IxYaDM5kWTI2xAObJ0g6myQHGpU4bpMEXQcw6775bGReP8VbjLdl0tav7qEYD0n2CBnH0Nw4sZ/X3dcX89xeQTj8M4Y9QJCygk02aeUfxTRriuKuX9lMLdmiuiOCABbKSBgs/P24N27OFj+5hJwcktbJCDgQ5iWNqYR9ErWMwg2Jex7lu/iokuZWNCqhKI+BX28DuLnyd+G+WXp7UQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odBK3W73FkOIAIZGu4eNrMHQ98rg/qPPT15v0NG5Z6k=;
 b=QdeEyaya0gMcUyp4iVjgLgBA15+fduz1CCiDgYSmw9Nr0nZKva3omkFVVnE7QbFVFGmn6E89HLVOOsVWkzMV1mltpGE0TCMUF2fiLL1EyFL4dnoQgoyitJan7eCN7D7XORuy0v/empq2wRS/6BakaoJVZDtgBJpwMPaLt5SaAEgGGVnL/VZfzgUaihdGkOR2Z3cpgkjkB9OoxIsxj7OAGhWsXNw2+DtR3fPItmct2aTgOVuPtbmBeeOFOt4QbH3xB01JED30oWlV/qLxt5jtJX4Httg6KwQqUH/hfSpr9YXTdtzT6I0oqTWRmi/GQJVjvFecmLDfU69HJkSCd34Vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odBK3W73FkOIAIZGu4eNrMHQ98rg/qPPT15v0NG5Z6k=;
 b=MH+NyhFipxNWdWKVPLbUnGWgrEIpeYFQq7hAtKhYhz/s9ABIx7sUI45/47e1fa2Y2IjjK53575UrHzgauy0L98sW0lvmYAYFiP3rCvR/lxQUWgYlPrzGBV/LZJbERg9W9YJH+HJFWvqFNZOaljoHGrBp+GBe7C7Qa5coWpD/Alw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 20:19:58 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::50d0:b7ac:446a:d55b]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::50d0:b7ac:446a:d55b%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 20:19:58 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix check for DPM when returning max clock
Date: Tue, 25 Feb 2020 15:19:45 -0500
Message-Id: <20200225201945.27720-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 20:19:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d1c1443-0b77-4a4e-3c82-08d7ba3015ee
X-MS-TrafficTypeDiagnostic: DM6PR12MB4315:|DM6PR12MB4315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4315E6E77D132274A6ACAD5E85ED0@DM6PR12MB4315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(478600001)(66476007)(66556008)(4326008)(66946007)(5660300002)(1076003)(86362001)(44832011)(81156014)(81166006)(6486002)(7696005)(186003)(6916009)(2906002)(36756003)(2616005)(8936002)(316002)(8676002)(956004)(52116002)(16526019)(26005)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4315;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwY6NiiIcIjYroHfGqxlDaoJzuZOCjWXXuJ8OCzxfpjP1fs0PLleCp6ZaS6CSUwxpA7Kp39uMwqNTX6Wkjg6L42EkQHCJOt/DBr+fvnOl4zwOVKjLZDLjGx8oxeSqmjGYc7+ObMcrXxyxFLnRhcBcq+Hwh4J/KXVOzMv47yk+h5ZYmrddKjRPMQy66x9pUeyGrW4yJS0hMz5so5ST9gDKhWM0OTt8ATwlRCzoJM0V7B5EP7Aji6D9pbk6CkFNoLpu6kMrRftK10w+vjogGdFJcr0tzZv7vtOokz/eCFyZnISuafqh3V04cXTg/eWhQLUoHwgG9z1MN/O1cUv06k52VwiaqY0b2u0P6BYR41mUz7DIzo7PhBF7NVWvQIqNit3so5WtzbwbsqG3xfTBytXYtz1n6hSn/9i/E8W9rwHwOGNOPNLdFz83BwnI29SQTao
X-MS-Exchange-AntiSpam-MessageData: v0D6v1OYNTZoj68KTjO1PnlgBVQar3lKKr/WsimZYwed4m4q+KYTixG4Hq9MXhbShTTiTGiBAkI6uwfeqrbuw1Npmq7RWoT14qHlF547PuQbkpOFEvJw9YXKCBD1e/eV0GVTwQv6vv7uOVnKenB8uw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1c1443-0b77-4a4e-3c82-08d7ba3015ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 20:19:58.7324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ2ySOv+Aw5SBUApPvgvbCjAdn9KyL/EP068UwaHkXt+MfFklNpf3cT7JdRfxh9DsqXOK57cjTJ3OAhI7jBlhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pp_funcs may not exist, while dpm may be enabled. This change ensures
that KFD topology will report the same as pp_dpm_sclk, as the conditions
for reporting them will be the same.

Otherwise, we may see the issue where KFD reports "100MHz" in topology
as the max speed, while DPM is working correctly.

Change-Id: I967988e936de5371c22bf92895bda22324d9631b
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e1c2c182898f..7e8276651865 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -402,7 +402,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
 
 	if (amdgpu_sriov_vf(adev))
 		mem_info->mem_clk_max = adev->clock.default_mclk / 100;
-	else if (adev->powerplay.pp_funcs) {
+	else if (adev->pm.dpm_enabled) {
 		if (amdgpu_emu_mode == 1)
 			mem_info->mem_clk_max = 0;
 		else
@@ -427,7 +427,7 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
 	/* the sclk is in quantas of 10kHz */
 	if (amdgpu_sriov_vf(adev))
 		return adev->clock.default_sclk / 100;
-	else if (adev->powerplay.pp_funcs)
+	else if (adev->pm.dpm_enabled)
 		return amdgpu_dpm_get_sclk(adev, false) / 100;
 	else
 		return 100;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
