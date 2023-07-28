Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE92C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 18:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4C810E151;
	Fri, 28 Jul 2023 18:04:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9A410E151
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 18:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1O+v1ZQTSmkdUuf/MQoCLPKsH9Hn9khix2fSPCGyJDeLhZS3AZLxIyfN1j/0Kp3wTMpOc2B/qtFqzEf+4Qfu/e7sWDS4TK54ELZ4EnqZ8pMYFLN+EHugFMdWkjRO3I6Q7hNAGc7E8Sf0K1hEOx6oJwFu72gxJt3524/7Z7rApstdhLSODn/itZnoMgriOCxO0OF/rWNwYHHPcwn0dD6ycfd+OjVQct9inTHazS7bao0FIyZVDl3mE39GjqpXVWGsCFiSokjYEC0DHOZFV62rjBFDd9QYJ7ucPfVayThOyt5F/ilVljoM4wTBHdknZku7YAdX5FoFHYKPpx7Ui98gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQGgjxOrq5vcArbxZ//Tqj41ONhrI2Tfb40aSHEH4sk=;
 b=J/w98Tic5PS6IWpgjpxkYwhTcEXPmID8vwfL+6f19Vsr+HIrB7Yvpqqyt5RV1ZiydkSJhwDc7gz/UBcxskXhbAp8gZomtRRyBxCoAT3Yao17k/QYECXbIFBfphQPKxToJLVedDwYUvtwz/FfiQVbU94SHsuvHrsLfr8Mu6l0xiVtMz91LcumfKP09GCznCDT1DEwuX+lyobGGBE15v9gWXgDDpQdoroExBMxNM3eGS/DKfPcwRjXRenSVXUj3BZRY+vFtUG4s95WxXU1vBT77I+JghXVhFwI0S58QI2aUwpWQZL2CZ+n6UBJ4ZTtW/h3u9x6EsxvBFPABsgJqtzPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQGgjxOrq5vcArbxZ//Tqj41ONhrI2Tfb40aSHEH4sk=;
 b=OnXXQmTP7fFKVfXqoBepB0Hj7SFDxdGKePInHzeDup04ov+02AOw1wlZhUj1+9pShRYtHTHr7kl/GYlAvugMwHdTaTl1iSYoocZxSIOBt9Im3CkA+bUk9sZDE1EAzMoo7vcazMm2BDMHVYi89Q1De1I7sHvHWfuDZYECMsBUfaQ=
Received: from SN7PR18CA0016.namprd18.prod.outlook.com (2603:10b6:806:f3::20)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:04:47 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::d) by SN7PR18CA0016.outlook.office365.com
 (2603:10b6:806:f3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 18:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 18:04:46 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 13:04:45 -0500
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with Sysfs
Date: Fri, 28 Jul 2023 14:04:23 -0400
Message-ID: <20230728180423.864002-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bc060a-f04b-4394-393c-08db8f95210e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj/IalYpsAi+uEmAod3BO00uFcRdlLUjHNQ0uSOhcVMrZ5PGiJCl8EGxXRQ+JeGQ2uogXEp5nBbBW8kPReKWHMr1Bu8gBmgICXhG2zhzMeOEi556blgd0j2gVKPbsBHwrtro9kDBMXPgegRguPwZOb9jsxfpjTWCMVlxLRDh1xijGU2l/IYZti0gjYkg3uY3MIsc25gq8qj5c2kIT5iFre06pkvX1+lw8FovdDUDI3Xph28g5fuIi3us4fgD6N/FG2bLkRRWbt+05S6hpWNJ6m3cRgiiMEpj86GHP3adjjWsozfDkKyVbDQKYLkO8rK1fn0WFiC2558IV6eSfZUUdYDnJdu/7Y2EybljRgYdVNHj9GB1k8t98Ad+e9Gh0TgqMjmZtlvkWEj3nlglI+atfJ1pbos04XKImeBV6HRYXM30qxZoADIfEWNB3E4CvZsCFpAUPc9yD1bQXxcBEKs/bwo5x6V6WcwUfZjy9VqLEpPq/I6VwOOGxNbZS/WgkwLK9ByemUB8Dkc2AzcN/bleTwz8efwEbTW1P+Ihbn4F74qhI7mlJQ1Tuz9/r5okgtrrptqUcP07FM1/bh/wHmQTIcZG+Peo4DZwuRF/GMdtmUcjDRspze2whqWdPXIdw8N/eYjpYecHpAttwaRqsZG973R71X2Xsjxfqlp00RGwgQzM+W0yM8ODx3yORyXRsJR88Cke+dUkRkaYfonSFVpx2CQXbqkvlP+gmVkukmmatPmAR/WZFEKF08f54epR/QDSwyqdVIN3UVHyALvzLcfLrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(47076005)(356005)(54906003)(478600001)(86362001)(6916009)(70586007)(316002)(4326008)(1076003)(81166007)(16526019)(70206006)(40480700001)(186003)(40460700003)(6666004)(82740400003)(336012)(26005)(7696005)(5660300002)(8676002)(8936002)(2616005)(426003)(41300700001)(2906002)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:04:46.9911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bc060a-f04b-4394-393c-08db8f95210e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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
Cc: Ori Messinger <ori.messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added missing MES firmware versions to the 'fw_version' sysfs
directory, they should now exist as a files named "mes_fw_version"
and "mes_kiq_fw_version" found at:

/sys/class/drm/cardX/device/fw_version/mes_fw_version
/sys/class/drm/cardX/device/fw_version/mes_kiq_fw_version
Where X is the card number, and the version is displayed in hexadecimal.

Signed-off-by: Ori Messinger <ori.messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 16807ff96dc9..8beefc045e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -703,6 +703,8 @@ FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
 FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
 FW_VERSION_ATTR(dmcu_fw_version, 0444, dm.dmcu_fw_version);
+FW_VERSION_ATTR(mes_fw_version, 0444, mes.sched_version & AMDGPU_MES_VERSION_MASK);
+FW_VERSION_ATTR(mes_kiq_fw_version, 0444, mes.kiq_version & AMDGPU_MES_VERSION_MASK);
 
 static struct attribute *fw_attrs[] = {
 	&dev_attr_vce_fw_version.attr, &dev_attr_uvd_fw_version.attr,
@@ -716,6 +718,7 @@ static struct attribute *fw_attrs[] = {
 	&dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
 	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
 	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
+	&dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
 	NULL
 };
 
-- 
2.25.1

