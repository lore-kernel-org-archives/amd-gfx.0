Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029ACC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F0D2158C
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 05:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F0D2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD8789B05;
	Thu, 31 Dec 2020 05:08:52 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E2889B00
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 05:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa302eSloEjIJQuoLtRO0j68B52kmisJLN0FjzL+LiI2Bo4tpp25CIN11A0unk+aAYZZ0SlNcFgf8x9rbRiOf8iW2Cxc7BG/+W7WpoCNQG8R4SZgAHqmO0/HbUs5Rm/Nk3TGY9Q0EkfXMdOgF08eSnijsBiX1q+D9zxuMNZ3qs3LdzYiF+M9IntSp5Su7Gnsvda2YKwUnJnx8xgjgnNpxKqHIee2u9p3H3JGmKSd38C2LQ7rFsrUbGNVAjIKRnKMidPoZJOmZZQw+A97S5TVfZbz4zO7qofdp5Pp8bNN5QETqoX+X7R0TRm+n6asbTSUDTjd/wfeOHicnLHFCcBwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KigcRH8uZ48aBfIyQuRmvxmZENyk1eMZSTZaSKCYCQM=;
 b=CWFc26buKw6GTCsHuOGbP1drTesyRw8VYG5QneFltZBdUA27Ze005xqm3bSHOy6tFBg/cBSA0ceZaRpBZ+d7Irxx2fU2p2huL0NELkFuvHbaNei4WvRC13YcZ+zjyegvVg7hGpy8SH5NY985f52A0I1B0jHSY67xjgA3kUE6IkJvHkl937xjj7qLi8l81VtxW9RoNFHyMfJBmJCQwVVJTbTrDroRNhp3Ztkfa7RPiplbTH4IYK9ImvLCFdW6Mdtkmd+mBBDBh61LBjU8UvnEqmqUCAIFAdF6DezuZMUeMbgp5UrpYta9vup4rsUJKFG5XiOQR8Q1567CEOwBeDpd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KigcRH8uZ48aBfIyQuRmvxmZENyk1eMZSTZaSKCYCQM=;
 b=ItXBLmoJ2IAnu0u1Uq2/zvatdd2vks5R6DCxysROI3XBe2BRrxexVO3jA7DcUCGZXXeh4gGFUuhYXLrAe1N8AZXMDcgSTli1rUcI+eTSNHzh3Soq35iFEX/tSnDQrzujnLq7YoYTp6L9oJvEImopiQnMBrxx+fQ1FOvXUBkpPuk=
Received: from DM5PR2001CA0009.namprd20.prod.outlook.com (2603:10b6:4:16::19)
 by BN6PR1201MB0129.namprd12.prod.outlook.com (2603:10b6:405:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Thu, 31 Dec
 2020 05:08:47 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::c6) by DM5PR2001CA0009.outlook.office365.com
 (2603:10b6:4:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Thu, 31 Dec 2020 05:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Thu, 31 Dec 2020 05:08:47 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 23:08:45 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 30 Dec 2020 23:08:44 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Feifei Xu <Feifei.Xu@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: switched to cached noretry setting for vangogh
Date: Thu, 31 Dec 2020 13:08:41 +0800
Message-ID: <20201231050841.12297-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 902fb6f2-307a-41a6-ef93-08d8ad4a274b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0129:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0129226DEFDF87089E26B124FCD60@BN6PR1201MB0129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLrOXLSMSzH0HF6LgcIxXr4RN0KMtXx4SzyRFuyX3s1hjzmj3jhM8cn+RS0SW14n37obVZ9oRNpWPKetQCimbptDs+SIo5hF8A8Qoe69q0R0mF2iriVDX+GOlJm2ogQwk4FdBE9ZoihfFrj25HrmQ/H1cFczcW5B6tLf6VjdJfV6dKlrk0co9J310fkoMNfXL3itQjfPeN7nZluDhDE3QJavVruEBpgAB534mjZKObv4zGASL9jIkSV7a/QYUbT4W6O+i71ETNc3RZZ0OzqVoXVmz1oLAXkLtM0n3Pe7SNkUKXhR9xUsoRhxGYReXIttgMEJX3K1+udEGmd7vGFfDkWmH8L6EMQe9YI8BlfNUPkis80NWChbMRufYN4YnxDzWiRkF9gUDfym2ynfw7i6FViFIyy77h8IHrc0yljh8GDL8em+QHfAAXr7nPMifsgrymfUkmn/tNM5VTv9E8XvFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(186003)(47076005)(8676002)(70206006)(2906002)(316002)(356005)(26005)(82740400003)(478600001)(36756003)(8936002)(83380400001)(82310400003)(4744005)(81166007)(4326008)(1076003)(6636002)(70586007)(2616005)(86362001)(7696005)(6666004)(5660300002)(110136005)(336012)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2020 05:08:47.0338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902fb6f2-307a-41a6-ef93-08d8ad4a274b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0129
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

global noretry setting is cached to gmc.noretry

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index b72c8e4ca36b..07104a1de308 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -310,7 +310,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
