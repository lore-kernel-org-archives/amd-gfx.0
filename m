Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14E1C4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0BC10E122;
	Thu, 18 Jan 2024 03:27:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C6D10E122
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/6cRNLgp3+wpYb9l6HRLDlu2Fhub5bA+bzr4mh3oGUF+NXNWiykNRK3wTjgWaWBd/MhSJEkGHQAZ/u9oaAdpLTHgZe4QM9RTCOMH3NDRMgwuOhz9Na54kNCT95ON73OlRwoG+grn26DjKZGRXMzelEtaH6YSbMSXp2+Wwc7oZDGRZWlACmM+Yx9fVlUCHBn6+gYJ+SXAFf+tXBf7piM8yd7CPP/VEZaLj/zz8qLctd9A7OuUJ3lWkwixxCW0YaBPWM7ISk1PUY0prI5Rg5vJ3stpONjNSW0B/EmOqk/BeWoZZ4VS5U4793ItQJ/AndBAWL6dshimDUTwX8Xj0ivKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs6pQCvgEtpFsctm6nCMKTpcsY24mF344wnmQjDbn2I=;
 b=l4Hes0P8XfFxX37yHNh/EbawIWyAmOPrQDpfl7UtOtM/ArItI6oiEXMe7GkFw8gEPoQ8iPqFzv+l7GUDFtb6LSNeFbjNiiBGIx/ZZqmQhpO9ZyHk21c4ib4Ksm7zWE6eiGW3I5e5kw5VNmPItP4wCZFcaWZMa6t306tAkZ6DMXBlNJsasavlrpMm/8/I3b61w69Y+vFZJb5Ju2lB4Ixi5JAB9VPk9HYe2yEpEUZb1jdV4LxHG4nd4gYgs7nHCZH3oEA6uXPkwjcckv1M1gd31sriiGp07dtUjxLxGvT3VO9NvW3JptL8b5/fqK8tBvTUo5IK12V2gKRTsBX9s5mLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs6pQCvgEtpFsctm6nCMKTpcsY24mF344wnmQjDbn2I=;
 b=Qr+fXELA5b86km1sAz0euwe/hmCvYta5eTOVml/p5gzW2SuZy2tCd7RK6OgMXtSP/N69rM88MFbREUSe5/+WRIbhILKkg3j/KjOB89z/x2ojHqstXYe9vm7w8WNE1N80OICGOd9Vq8AYS4ysduzY9mgjVMnWui9Na0PLpOvWwhA=
Received: from BYAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:c0::39)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 03:27:10 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::cc) by BYAPR05CA0026.outlook.office365.com
 (2603:10b6:a03:c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 03:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 03:27:09 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 21:27:06 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable amdgpu smu send message log
Date: Thu, 18 Jan 2024 11:26:54 +0800
Message-ID: <20240118032654.1950540-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf570fc-385c-443b-371a-08dc17d55a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrAp5y/GoCC2xvfZ3EaTacHEi5Rjava46luiGFc/oeMjxTElOHpVPinR3iLMT8aGNdPFIL+9ENZ5RniIQOOxqRkjWM6Ukftl8TV8CMWO+KqVlAteINpsdLj2mCtn7AlMdH7Cb4DQXnNhO1wDUP4AhV9hTn8V2SaASuS6VALFUPFblp5G9SsxxbhlrxpCZUpjYHRUweaZATvHe+CcmnJq4ZU9E0q1ww/+F+CJrjDROeHF8iIe4P/swjWpW7mt4SuQ1OvCXDzdX4cOh7DjPU8taE/tWni87UTdYUUx1utSVT/v/DVsPKsdvtS3VoomHAH9glW5MdoLluR+YKtX187HDU6vuSxvu6rvI769sFxDvSdLL6Yl7/PmyQFgoD1JFwYPcRNA49hMoWtCfZao3Q7kL4FezKDaNy5dKemX7c/Bcleafmn3DGS+yIxaQg6WSIvITa4e9whJrmw+EIIg8S6Y4Y4PDuJAbscVT8SrJqHzlh2I9voUHLstE1yOVqPD+IwpzBvGGg/PloMDu1/XspBg9ecQ3ypegujuCuefXTCAFgB2Fmb2H7CicLi1JEjbWDuBzqwjXmyRDBYsF0MtpSI02y74v8QGG4RhgASBHu5v2wDnafq4kUEd3hkMNo8KSG1vSJgL+s2ytk53e6IR5AbR+HCPOEAZ8hSDeYg00I1jkHYVWtYBUtPJlgyBJIwZoGDj9cbzK/USPiMFAqHCEeaJ4gBRO+J46wl0mFYuvzZ1Pwe+kDp7NFVvxm9dCJYE3I8G3/pJobNOioztyC7zD6yFVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(5660300002)(15650500001)(2906002)(8676002)(4326008)(8936002)(316002)(70586007)(6916009)(70206006)(54906003)(40460700003)(40480700001)(478600001)(2616005)(7696005)(6666004)(1076003)(83380400001)(336012)(426003)(16526019)(47076005)(26005)(41300700001)(36860700001)(81166007)(82740400003)(356005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 03:27:09.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf570fc-385c-443b-371a-08dc17d55a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: Kenneth.Feng@amd.com, Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

enable amdgpu smu driver message log.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 00cd615bbcdc..b9a24ff02a12 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -378,8 +378,14 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	res = __smu_cmn_reg2errno(smu, reg);
 	if (res != 0)
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-	if (read_arg)
+	if (read_arg) {
 		smu_cmn_read_arg(smu, read_arg);
+		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, readval: 0x%08x\n",
+			smu_get_message_name(smu, msg), index, param, *read_arg);
+	} else {
+		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x\n",
+			smu_get_message_name(smu, msg), index, param);
+	}
 Out:
 	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
 		amdgpu_device_halt(adev);
-- 
2.34.1

