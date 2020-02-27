Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3AC54FD8
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6177024690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lb3OcQTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6177024690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F260E6E8D8;
	Thu, 27 Feb 2020 14:11:26 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690054.outbound.protection.outlook.com [40.107.69.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849E26E8DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiYqheHFqxCsovvl/LxPfyPS8LDVERznPqjIapkSB73zjcoBNBeOu4f1VjTzDAtmyxcnyTJALdlJrbb5hp16dccAPrJUVnvV/jYCpCFntXZCSugB8rfAU64FzyIoT65IFSApPwPEoKdBg6jl7KCS6Ll1spugA0bOIvgrlsSVyFillWQx4KbZbvFSzKOlvSx/DR2EJvlLuf7JObAdzBT9BEKgu+N1FzDpey9EwR6rTCoWQOGUze9ejcKIbtoyMk/mSzlfCOPFHh+x9vD00WtmmMttbojF1ojhrjqnOZKfBkPk7O9X+IxCfLuTLQdkXLKA4mjUYb9m+Q5yueeDOYc+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2LmSzO7MM2jvjpVyw/vMLvnZASmpawp37mwkQ5uTBA=;
 b=nh+oDt/A6eu5p/GCgAecvOb/pUJBxC9b6v6mB8Y1QlSjkYjc8sjHLoI8XO+l+Nz1ofyOQNBPNLgeCXU4vanYVxEfT3V1OKQp3kc7WTgZo1xCvOhgXKfeEnm9OP4PLVUGuvHwVYdCNr8X9BuL3XTjrBesIs6sDLWqrluq3EBMPk7rhEqyfip/WOWhbimsJF0ZFMV3aPF0lrv3wMHpVSU03ukpuJYOjad2OkTpitW1pJtzdtIq5pL4nbGFXBJBWaLThK+Cyn7SyhWxvcq8HVa4zxtMpuqVNRK5Ev4ecPw+PzkEokrNAH0W8oK6WrY6Gzc4gwBp4q7Mdqe3i8WMKxSm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2LmSzO7MM2jvjpVyw/vMLvnZASmpawp37mwkQ5uTBA=;
 b=Lb3OcQTPt9SnYR6J4iLNwdmpRIZnuUnazWOXW84fRnBIijQKB2hmBU7qOsxVSBlq0bdPRtEAs/CuAk0db2nGL0ru3M9ERemVCYFOhIR4UXtDoXaf2NLmbuHUOWXXX3jeBLVo+XByhi12r2VfdDjF9uvyFHLlnEl7nRqPSoRMHR0=
Received: from CO2PR04CA0158.namprd04.prod.outlook.com (2603:10b6:104:4::12)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 14:11:23 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::50) by CO2PR04CA0158.outlook.office365.com
 (2603:10b6:104:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Thu, 27 Feb 2020 14:11:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 14:11:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 08:11:21 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 08:11:21 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 08:11:20 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: miss to remove pp_sclk file
Date: Thu, 27 Feb 2020 22:11:18 +0800
Message-ID: <20200227141118.3271-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(428003)(199004)(189003)(2616005)(26005)(70586007)(2906002)(336012)(110136005)(316002)(54906003)(7696005)(6636002)(70206006)(426003)(186003)(81156014)(4744005)(8676002)(1076003)(5660300002)(4326008)(36756003)(81166006)(8936002)(478600001)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2500; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68957027-4975-492c-43ae-08d7bb8eecab
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500D26FDBCFCA2EC5FB325FE5EB0@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gca8qCS5bkWAmqLEliRlSc7RGIXu9CsGYU5I313Dgj0RiUURpKxg+Ql7sUh1tiRLvfiq74/Y+DynlOXucaBwdi97RIvcsioa0Tw6xQZAIMfbM1EVLsFAT4gSyrfxDkW9DNXQ3PnzhHjF0in1Y+a2YOgLg0764c/QmTz1BIimaTfeLhN2PazJr4FMRZqOs+6NOQKBiSVlUsOSFsphyoMChwOca3KoOIikySG4mX+QP8WygVdYH/nZLXEiSLZykA/v9nbAsiBsWvxy+p2V/RqbpYMmHfKObPYz0aNmJC4mTe8zv3GqEoEztfeRT00vBYGmaioz7VIQYLzlWU1ymaGPhlJ4qqIlXf+cO4iAh2H5W22APS8wcpNaVBU4tE35Iar5WPLZr/GEc2+t1ZbaOBGQESqkOvAlNGAjgWecnTXoZpJ/MxlLCgQzmnnv5KOFh99M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 14:11:22.5012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68957027-4975-492c-43ae-08d7bb8eecab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Miss to remove pp_sclk file

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 9deff8cc9723..a43fc1c8ffd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3471,6 +3471,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_pp_cur_state);
 	device_remove_file(adev->dev, &dev_attr_pp_force_state);
 	device_remove_file(adev->dev, &dev_attr_pp_table);
+	device_remove_file(adev->dev, &dev_attr_pp_sclk);
 
 	device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
 	device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
