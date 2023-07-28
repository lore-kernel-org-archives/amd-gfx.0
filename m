Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7090EC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083C610E038;
	Fri, 28 Jul 2023 16:01:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63E910E038
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkHzrNscJbPqHs2BQUTzOpe+SpXPF2UyDCdwGMYgWGxMb+wlOzrCliPhY7QvIOUpCP1xCYQ/cG4/YpGsvs4qJYQLomnJ75WRifpPb0+gvLZ0aBaLAmF3QA51d0MybQgORVAwjEbi4J+fcT0gaxo683OcxMXanEUmSDgl+p4zWtpgU5zWVpTcb9Q/Fm8J3NUGfaWD2o+/+Oo3arUffj1/kbnRU4lhMnxm7uEC/MEPhL4RaAMD8zk2jGteFbceLJpKqdJ/g8Lf4jgjrZBU0Q5rK2cMWhoyuVLtbyC/yay323stpk8LaV9kHU8vSwxyKOd3RmbH5btubPvda0BLl31l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8JXFmNWU3QX4oMwaxhWeq0T91NOOkjQkNjeaB+3wZk=;
 b=SrNcANkE8aLMeGlCKFU5M55itaKtErR8TiP71pZLyQ82Ng16klKLwxdncQMSUggbTLma7rS9bTU7U13KrCSzecONLCrkYtJZBobX6tcVAsVeKAuaqHqzcHvnz8X5YuxZ97O3PYjkaDtoLZwR+rY5UbNNe4Iq75W4ps8gDGBBZWSoKkl9DPvuH3t3AZsQr9g+DZ/mN1D5WPonpMU0NVt+VsjoGrBU8djpueo7jCEPharg92ft3kf+tAMyXYV6Ikew8uDCRqomTAVWtxJEyThHaz7jGmbEKmiQhiFpx08qaoruTeThqvdSftv02oNgI7PsGxchD0bMHbvPHNvQuPYh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8JXFmNWU3QX4oMwaxhWeq0T91NOOkjQkNjeaB+3wZk=;
 b=T1We7QJbIcz2rnRDQqUAo5Wf1uEqUPo2RaOZ8o07txjLVsVNoeRo1O1Y87pk2LCP3E29eKR2OK8AGHWOe1LUgYmEFtVuDkYEz/OX1eOj94wKF8LTNSb/Jzt5hJHNi4gtK3zNZI/bqxlnKuOx79bw/X5O5i3b2cJ6yszJGiVB2os=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:01:44 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::8d) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:01:44 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:01:42 -0500
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with Sysfs
Date: Fri, 28 Jul 2023 12:00:29 -0400
Message-ID: <20230728160029.863681-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: fde64bdf-0fa9-4134-3583-08db8f83f082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 438sSLFJdvIdH3lgbEKeAVzCPdSh0o6ouW+hVOGeVTp5RSsgAQZQTK1db5+ehrgm5NYpcuVata7xiif/APPBpPgC6VMa1ymr7n837o1w86BceHjk6SzKCWLj2zTSwRHmdDvPNjLfwp7E9fUbh4hg8WxW08F4fcF9CY+9PuL3OZCgS/0V4jOBb/82Gp0z8fl59G5vNwReSWNW08BScmvPP7bAhMPfjyfb2dDUhCw1Stvl/ZkbuaC15IXFvvG2koGvxrMg/Xp2Ks/En9Rx/vj11ebWpITec4d63WzQER7rfIs++YlDGeAk9tSRdzEKPjaN7I0BLhyMjEfPd5QDdGwW3JJQ3Zwsyi0kBZdFAMzcndyjrwXrlqoAZgth+mpyM4cLiDYEqS3mAFxj9PDOoj5mx6ZVUlJOLnomIjCFu5KIls87E/LYt10d7eiuY0+e8tv1q1g74+VZ0aDux0V4d7bcB8TjKI2rnM4trActodeklIkUlEIdKSpEnURCTikbbNyh46fNIoT3MfSq4X4AOBqDOf6UOiyjoL9jEqAlqAZRkQDT0JLte/PScyRles4VA0BnjTUGQjQqc2c/BK+jW14jJFh1tQ37pXwKrXrOT35kt8rGUV/dMMEoFtr38xr0+2eoK3S+TLOtLx6Lcol1bQch1nHgdF8t9IFzLGRih92thmAExYDkbx41Tmr61XIQXWoLwn6tgWvsWdRIVYa0wrht+MEH/EjzXnyQu2yTWUuCfQbONbBwkJ3vieGdFUgRV0hKAa4suInfvEmvXH6PkagfGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(16526019)(6666004)(7696005)(82740400003)(478600001)(356005)(83380400001)(47076005)(36860700001)(1076003)(26005)(70586007)(70206006)(54906003)(81166007)(186003)(336012)(426003)(2616005)(6916009)(4326008)(5660300002)(40460700003)(41300700001)(316002)(2906002)(8676002)(8936002)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:01:44.0047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde64bdf-0fa9-4134-3583-08db8f83f082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
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

Added missing MES firmware versions to the 'fw_version' sysfs directory,
they should now exist as a files named "mes_fw_version" and "mes_kiq_fw_version"
found at:

/sys/class/drm/cardX/device/fw_version/mes_fw_version
/sys/class/drm/cardX/device/fw_version/mes_kiq_fw_version
Where X is the card number, and the version is displayed in hexadecimal.

Signed-off-by: Ori Messinger <ori.messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 16807ff96dc9..6a15a84ecfcd 100644
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
@@ -711,11 +713,12 @@ static struct attribute *fw_attrs[] = {
 	&dev_attr_rlc_fw_version.attr, &dev_attr_rlc_srlc_fw_version.attr,
 	&dev_attr_rlc_srlg_fw_version.attr, &dev_attr_rlc_srls_fw_version.attr,
 	&dev_attr_mec_fw_version.attr, &dev_attr_mec2_fw_version.attr,
-	&dev_attr_sos_fw_version.attr, &dev_attr_asd_fw_version.attr,
-	&dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr,
-	&dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
-	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
-	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
+	&dev_attr_imu_fw_version.attr, &dev_attr_sos_fw_version.attr,
+	&dev_attr_asd_fw_version.attr, &dev_attr_ta_ras_fw_version.attr,
+	&dev_attr_ta_xgmi_fw_version.attr, &dev_attr_smc_fw_version.attr,
+	&dev_attr_sdma_fw_version.attr, &dev_attr_sdma2_fw_version.attr,
+	&dev_attr_vcn_fw_version.attr, &dev_attr_dmcu_fw_version.attr,
+	&dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
 	NULL
 };
 
-- 
2.25.1

