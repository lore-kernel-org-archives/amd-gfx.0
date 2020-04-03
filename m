Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B6C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A7620757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Oekv/ltp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A7620757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51916EB6A;
	Fri,  3 Apr 2020 10:56:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E346A6EB6A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiLey2vdTTovfmehYvC+peAK3L4NXa7bMQac1HDAo7cFzIV2fh4gzrwwQN56+Hix9UaYd8WsXp62OqdmeygL1QpUMxKWWKEW0bv46OvppJfgKow/4xqexXwieb3Xflf2alxKvhbjVMawLGYFnjoDXN75gH8LPITx2uqSU2/2SdqenzEF7lVht3Zng4CXCRCfvN9Zc/3BvjKsI0Mkpuo5zN+GoiuHlKp63Ecqc2W7QTeZ/cpm30Uf13jcywi2Z0HEqUFGKe2N3NOJXTsDNJM94efkQgfb5QBU/YkA5JtqwcDQmo8qhmwDHwCHatnM1s/MxXifmITqJwyrcRSf/tZhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kpQ+rlOiEykMbBjmMdZqqVgw5AKbtCX2CrtKNMwWn8=;
 b=LW2KT62OojoJIlea0fyLnWgbjcfO8Nf6OC9SvyXPVVmxPGgNM+HZKM+fQQk+L7VGh86sMVNeYBedxTMkHLvX6y8R+i2RzJe2rWNvQgzhwg6DZf9Syew5ZFuBQn/Wgnpgf9pHDVNhZU9EnONY5YaIWZ62gTdLpogOkdmhmT2ewWcGYjVa+4V/O0ohL4vL7jhIsOMTQYgateaTU3UJGCFFRqJddJWqFMly5fWWoTuPlgh+bID8w0gLpO2LBOGri22h54+dCXvtWoIDesYItq9lgahwU/ps3J+xtm0Pr7xN/4kPMkniWg1Ma2C8uw+fvhIzyloQ+K4/e9NUuStiqiiPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kpQ+rlOiEykMbBjmMdZqqVgw5AKbtCX2CrtKNMwWn8=;
 b=Oekv/ltpO8RA2dOXMEB+X/3Jdr71IZRxR9LcO1J1GQolbWQr+a1worD3QGUYuJk9wtv40A3tjvdFiEJ/LOMUIptQQv1VZArhFXCEK+Oku4gBFj2j9ZUqa3BdCK29Ucjwq5AwzYfWIMfLUDdZPMnTv6SFqH4xQzfAJYm0AkW5pFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:56:01 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:56:01 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu: retire RREG32_IDX/WREG32_IDX
Date: Fri,  3 Apr 2020 18:55:28 +0800
Message-Id: <1585911330-27664-5-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:56:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0af5beb4-465a-4e9e-c3f4-08d7d7bd9909
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833A90F97478D1A9764A738FCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(8936002)(36756003)(7696005)(66556008)(66946007)(5660300002)(81156014)(66476007)(52116002)(8676002)(81166006)(186003)(4326008)(2616005)(956004)(26005)(16526019)(86362001)(6666004)(478600001)(6916009)(6486002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCiT5iKx2JC3zNbSU7MvrYFCpqtxaEeCMChhBjsnlH1y5pUKcghiE2WbmFZuXpyth+4LwvX71Qby+WnoFnErOAxG7NsKbIyyOQmnlqqE0mHZ+kjw3gNXS5wgACvJAchjnrSpDA6Yp2caCCzto5BqqlzNie3DpW9rMyej9e7NIE0CePddeJFI+OCCpnhq9oOWK40Qm+Xymzembc2jcfohgZmaUGpBOzlPCd8/jSKlYH6hYmJeuU7CMpGNJxYOfj4YoxE4n9rugt62GuVN+pJF5VXOWVQb58/Liku6gHrEwFvYvH38P1YHnugR0WYehfgzkzR8xTQgewu9NHy6/0s2dQh96ykzSVDEi6hTRibPpZk85Z+OHO1zit6gf2DzTmGromJKDfJRxwqb9VMoZAM2Wjt7zSGRjxc8FXLDA0AUUlSJCnCdAjuECMlikt+YENkF
X-MS-Exchange-AntiSpam-MessageData: O1nlehkJBIHXN4fm2fYsilOjS7M8gXOXKYbr+gVvjzEQWC2Ml41F6+3bkf3KuFDAVnPeoV2kGQPZd81zNjyevW0JPpnFikg19TIpWLMTddovlRYx0wSGhGt9H53UHE9QobMrNjtJ5TOrLZ9+klt8iA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af5beb4-465a-4e9e-c3f4-08d7d7bd9909
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:56:01.4779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4314IAJUZsoh+0KHh42n4E0W4t48qodhKor9cInvE3+ThylqOJtABp47fSIvBkjSJ5tnaYDMUZzcYtrkpHJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

those are not needed anymore

Change-Id: I2c2696eaa82ef6777ad518d9333cda9deced0f94
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 59bd507..e1647625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1027,8 +1027,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 /*
  * Registers read & write functions.
  */
-
-#define AMDGPU_REGS_IDX       (1<<0)
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
 #define AMDGPU_REGS_KIQ       (1<<2)
 
@@ -1042,10 +1040,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
 #define RREG32(reg) amdgpu_mm_rreg(adev, (reg), 0)
-#define RREG32_IDX(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_IDX)
 #define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_mm_rreg(adev, (reg), 0))
 #define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
-#define WREG32_IDX(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_IDX)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1849653..1b4d338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -317,7 +317,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_rreg(adev, reg);
 
-	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
+	if ((reg * 4) < adev->rmmio_size)
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
 	else {
 		unsigned long flags;
@@ -377,7 +377,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
 {
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
-	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
+	if ((reg * 4) < adev->rmmio_size)
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	else {
 		unsigned long flags;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
