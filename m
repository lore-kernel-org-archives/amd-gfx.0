Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8E7C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 08:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF2F207A1
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 08:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF2F207A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917DA89B20;
	Thu, 31 Dec 2020 08:48:24 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A94989B20
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 08:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYU2HFdLmVUeCZKZMM/1WGcT87tgpk5uWIodWhoBTrrmwejhV//mOpRzs5VnvTLrTmDwiVC6mG3rJ3hMqdlU8xw/+l9NKoDZrjaxjjJ1gdHNv7kTbqX47BmB6ClATuLeJYJOpZq0MDgHNVTZLWVffH58KGXHdIa/Ntb2iN32joXPAFfTtdqGqLN73cyAx8cmLS8DRooc3SDCok+XkLZgi5Xp9IZgJi0Kes8D8ov998Mj3RImwO9+dhfPavi8F6JJZ8/zxQjDXTpYW6cna4BTT8LqyHiY/K6z9t6pbN40s/NGQgwwketymS1hrIkl9YrK7qwe7rj8tROj6Y21/FqDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1Hjgzk8F+4VpGny1FvOJdLDqEovzCGOlSO79jRWAUw=;
 b=dUWKImb0j4LnLG34dHa/kD1/Af+f9mooWz9KjE1E6PvGZK4xI77QwyLvCsQtFHnkPh8BeqMgR+7X+ozjG24BKuuHEgzUvJBKk771KMv16pQaeVz3SPFjizOazsSWIqL/hY6X2G/yxfKfJAgXUv2Efzu1Mg3Hcryd4GTBPxfbM3ig3EN8P7RZ5tImEkg+RaV2c85mgyek601afu7DbcUzlWyxuhYHMozZxpPBqoWPMpynfU3mQEhdCALOQXGFE4QBKje2i12atIJ3OfDuShiG9Q9GR2PKSlJeNSOj8re0V+7eiWWlefUDWuAjma+F19kb3AQ+ikFezAfkWlJzYrXqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1Hjgzk8F+4VpGny1FvOJdLDqEovzCGOlSO79jRWAUw=;
 b=Y1Gad08Pi1LM0jlAa1oBMFMbICmdevgQlK96CfkWXi7mOZCsZImxDxN4Pdia7Sd6A6tpnvYla2nCLhIEanmwYu+1Np8zcsZBi6ANVpFAkYs2vTKv2LwfSze+//WMgHkURu/2EyLG+7yi9uhPVj3GLjQalVghIwgBE+kgvvIDWfg=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by MWHPR1201MB0208.namprd12.prod.outlook.com (2603:10b6:301:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Thu, 31 Dec
 2020 08:48:17 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Thu, 31 Dec 2020 08:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Thu, 31 Dec 2020 08:48:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 31 Dec
 2020 02:48:09 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 31 Dec
 2020 02:48:09 -0600
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 31 Dec 2020 02:48:08 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix potential NULL pointer when check_atom_bios()
 fails
Date: Thu, 31 Dec 2020 16:47:41 +0800
Message-ID: <20201231084741.11865-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4b6831-9d78-4dc5-ecb6-08d8ad68cf88
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0208:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02087376350173584484628EF8D60@MWHPR1201MB0208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeFK/022ch5R6yzcf1AGNGdRsvFunp5jjTZNj9BsWTBU8zhBGI29DydZ1+wNopr37DjaG/tHBjhfZd1r2FSVzRDrBIm9JA8G9+ZVOUGW63PuKtUeYBslqXE41CjYCHpPbSpM0FRYY6wog/EnvjCHYgqHxnONzuYhKtYg0rRdrGOZ/4YHI2QnUS0gxXwMMBGtTeWpU/BAs74huUHz4N+nEEZUKxaqLvUZINPKbsnlkt6AiI/iKwVSu/qjAgQOqF6VkgTC7yktfzzuy+L65lgVcIqaqiURpxZvoGiqWa9xOIYCcVIpKYgETR7tIxWlLvXUg/Eh2SdnAyDEyZTmpjRRhZcA1fyp0q0YxNdLTojkyBtXBHubYpa7BeGS70FKZxMGTO6r04qcq3RWMKK2KaiwJkJYCr5SGDpH8hF+edhDOhVPua9ZN1Ku1bemG6oK400+6DvFfriGEfTXaRw/6x5EFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(70206006)(82740400003)(47076005)(336012)(83380400001)(6916009)(186003)(81166007)(6666004)(70586007)(356005)(5660300002)(26005)(2906002)(478600001)(7696005)(4326008)(1076003)(8936002)(82310400003)(2616005)(426003)(86362001)(36756003)(8676002)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2020 08:48:14.1307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4b6831-9d78-4dc5-ecb6-08d8ad68cf88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0208
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
Cc: emily.deng@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Asic funcs pointer needs being checked whether is NULL. Because when
check_atom_bios() fails in req_init_data handshake, asic funcs pointer
is not initialized yet.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 6333cada1e09..efdf639f6593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -155,7 +155,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	u8 header[AMD_VBIOS_SIGNATURE_END+1] = {0};
 	int len;
 
-	if (!adev->asic_funcs->read_bios_from_rom)
+	if (!adev->asic_funcs || !adev->asic_funcs->read_bios_from_rom)
 		return false;
 
 	/* validate VBIOS signature */
@@ -348,7 +348,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return igp_read_bios_from_vram(adev);
 	else
-		return amdgpu_asic_read_disabled_bios(adev);
+		return (!adev->asic_funcs || !adev->asic_funcs->read_disabled_bios) ?
+			false : amdgpu_asic_read_disabled_bios(adev);
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
