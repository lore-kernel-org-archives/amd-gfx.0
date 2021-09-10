Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3886AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043B4611C1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 043B4611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A966E9AA;
	Fri, 10 Sep 2021 09:10:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC4F6E9AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 09:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5RTHnm/9E90JrvYe0obXRaVIhcypKFiZOw/eHNtZj2EnICQY0rcRzBhTNRTN7NessX8FEtXRABX75+PbrouteObO5rsR9YCpbUOiyPWc00NYQnA7NpEujyRdlBsYz5tvQazqjsuQIokku3MR91kUTavZ3/p5yMr84SyKcdK/koTHZx9eaNgNaz0g6bOLXz2PQVHPi/hB21n0zPH1QhUJaWUAFhAq5Lm7fBRebfGfvqClbDfiOzU9DcnxNapiU9awZeJ+rdoJEpJtfYeuDVbzZG+x8hjJXALynmeVTpsT2dHgZR9kfbQ7e0znsblC5Pp86qOHaOyOn/+bwTuLq6pjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=XK9Y4grlWH6goiF1YMoJlx950WxkJ+hp5ioNu+EDvcA=;
 b=iweqluQddpqbGUZL9BRKuABppSfZ6MqZMbSkMCxn9f4IDb1KUwEO29hZ+w4d4wcUoH+LHjYwuGypMsgqZ7FCUEqQqgDC6TzYcek710PNRudwqjKEmIAzS7fJ0D77XwUtIE3XVe3GW5JDC4wfh0uXgEconNJVcmviSK+2+TSX9pmoSs9VpPfkX1raF4hhEdjjgJAvR31EtdEsxP/yXd3Y6I/wSRi9FkBVAER5LwTCIfCLx6tqplztkbaQqpaVVOOJkhUadS2Gf0QOmOxcQ1luQYskpVZDSYSyqGT8lcRgO3R7VX1sxohYgc9P8vy0bqLiZfgf8xA5/as4FGfU2as2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK9Y4grlWH6goiF1YMoJlx950WxkJ+hp5ioNu+EDvcA=;
 b=Xjg1wlnwcIdh4s5p0yqVnhweamoNYkaLvcmTm4Nfp9aM+S8/ChGQW3YQEi+VpOD1U3sQ/HDk8ZeAmSjT7mtRUAyv7c5ekRQcu6vEEy0axpFIQZKTYkeOClU7r1cOR44YnqIu17z99hvmnCMhuqD4zkvSONiZ/jAVJhhsb5L9Xnw=
Received: from MWHPR02CA0009.namprd02.prod.outlook.com (2603:10b6:300:4b::19)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 09:10:42 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::a6) by MWHPR02CA0009.outlook.office365.com
 (2603:10b6:300:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 09:10:41 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 04:10:38 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v3] drm/amdgpu: add manual sclk/vddc setting support for cyan
 skilfish(v3)
Date: Fri, 10 Sep 2021 17:10:22 +0800
Message-ID: <20210910091022.970005-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 865aef8c-db9c-47ce-ebef-08d9743add1b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4158:
X-Microsoft-Antispam-PRVS: <MN2PR12MB415857339CB0A638DA0D34D8FBD69@MN2PR12MB4158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fNk7CS/5z/OpKxf+qrsGzyB8IK0i+HJGtcefAGFw5ndHrmM1JuOYC2pfPSxtssHUYJ9IxQLCYRV/xPNlCDIZQUSYHPPSxN2JnSJ8LrqqBjahYNwKNv2r/fqLKaz8Y/q9PGk5CmOtLsJgAFp8Ty/U/IRPkiwRhBdKu2VM68ZW08RjbgTru5LH+RpV/nC+59kkCNy4HORU7kexCYGvIbZ0MTG2vC4qOEZRYxw+WyclBaELnO3epPeYRpF/UglzN1cWHzLUem1pDFBigSMebrQaa94Y9OD9ehmpiUo2t2unIGLFNvWmzBZ5KAxA9jdv80sdH+o8yei5HDwD99i7LJB5Qe3QLQGOoXea1p5zMuvUYwnLNB+h0wf+eC0lU6Yu49Fbuq5bcuisOWSC5pSO8b1pyNti7ZboL2v1hXGB2z/njf6+hBZ0lCfARByBE6+2kxpy3zjhAe9VM7QS3QDuSMX0jiZb6zEQC3mdVxjBVHA8YkC4O4lPlDkJlLbKYLTa5JR/h0xNS+ifPHMU3o3vQZaIjhMP7Y4PrVVTiQ8RfwFKoXX0ryyErPK4wryjgQ9s2odQdTEvSNn18gIioQeGpY+XYeJPY5T01bAPQEB6LriQxYxKkmGAziIE2/f4OJ4FRF0nVwTCRhiVFDnRoURUeM8AOgxbZ/40nRxKygTKGof89XrX3lOlOcXT5+hAN5bh0PaYn/QRGVdbYJrZiam9j5COEzTH2bFB7XaPLzG7mxVXAI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(5660300002)(83380400001)(1076003)(26005)(82310400003)(356005)(6916009)(4326008)(336012)(478600001)(2906002)(7696005)(70586007)(186003)(6666004)(82740400003)(44832011)(316002)(16526019)(2616005)(36756003)(36860700001)(81166007)(8676002)(426003)(54906003)(47076005)(86362001)(8936002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 09:10:41.4576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865aef8c-db9c-47ce-ebef-08d9743add1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add manual sclk/vddc setting supoort via pp_od_clk_voltage sysfs
to maintain consistency with other asics. As cyan skillfish doesn't
support DPM, there is only a single frequency and voltage to adjust.

v2: maintain consistency and add command guide.
v3: adjust user settings storage and coding style.

Command guide:
echo vc point sclk vddc > pp_od_clk_voltage
	"vc"    - sclk voltage curve
	"point" - must be 0
	"sclk"  - target value of sclk(MHz), should be in safe range
	"vddc"  - target value of vddc(mV), a 6.25(mV) stepping is
		  recommended and should be in safe range (the real
		  vddc is an approximation of target value)
echo c > pp_od_clk_voltage
	"c"	- commit the changes of sclk and vddc, only after
		  the commit command, the target values set by "vc"
		  command will take effect
echo r > pp_od_clk_voltage
	"r" 	- reset sclk and vddc to default value, a subsequent
		  commit command is needed to take effect

Example:
1) Check default sclk and vddc
	$ cat pp_od_clk_voltage
	OD_SCLK:
	0: 1800Mhz *
	OD_VDDC:
	0: 862mV *
	OD_RANGE:
	SCLK:    1000Mhz       2000Mhz
	VDDC:     700mV        1129mV
2) Set sclk to 1500MHz and vddc to 700mV
	$ echo vc 0 1500 700 > pp_od_clk_voltage
	$ echo c > pp_od_clk_voltage
	$ cat pp_od_clk_voltage
	OD_SCLK:
	0: 1500Mhz *
	OD_VDDC:
	0: 693mV *
	OD_RANGE:
	SCLK:    1000Mhz       2000Mhz
	VDDC:     700mV        1129mV
3) Reset sclk and vddc to default
	$ echo r > pp_od_clk_voltage
	$ echo c > pp_od_clk_voltage
	$ cat pp_od_clk_voltage
	OD_SCLK:
	0: 1800Mhz *
	OD_VDDC:
	0: 874mV *
	OD_RANGE:
	SCLK:    1000Mhz       2000Mhz
	VDDC:     700mV        1129mV
NOTE:
We don't specify an explicit safe range, you can set any values
between min and max at your own risk. Enjoy!

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |   5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 134 ++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 6f1b1b50d527..18b862a90fbe 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -226,7 +226,10 @@
 	__SMU_DUMMY_MAP(SetUclkDpmMode),		\
 	__SMU_DUMMY_MAP(LightSBR),			\
 	__SMU_DUMMY_MAP(GfxDriverResetRecovery),	\
-	__SMU_DUMMY_MAP(BoardPowerCalibration),
+	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
+	__SMU_DUMMY_MAP(RequestGfxclk),           \
+	__SMU_DUMMY_MAP(ForceGfxVid),             \
+	__SMU_DUMMY_MAP(UnforceGfxVid),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index e1fab030cfc5..3d4c65bc29dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -44,6 +44,21 @@
 #undef pr_info
 #undef pr_debug
 
+/* unit: MHz */
+#define CYAN_SKILLFISH_SCLK_MIN			1000
+#define CYAN_SKILLFISH_SCLK_MAX			2000
+#define CYAN_SKILLFISH_SCLK_DEFAULT			1800
+
+/* unit: mV */
+#define CYAN_SKILLFISH_VDDC_MIN			700
+#define CYAN_SKILLFISH_VDDC_MAX			1129
+#define CYAN_SKILLFISH_VDDC_MAGIC			5118 // 0x13fe
+
+static struct gfx_user_settings {
+	uint32_t sclk;
+	uint32_t vddc;
+} cyan_skillfish_user_settings;
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	|	\
@@ -297,6 +312,27 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
 	switch (clk_type) {
+	case SMU_OD_SCLK:
+		ret  = cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK, &cur_value);
+		if (ret)
+			return ret;
+		size += sysfs_emit_at(buf, size,"%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz *\n", cur_value);
+		break;
+	case SMU_OD_VDDC_CURVE:
+		ret  = cyan_skillfish_get_smu_metrics_data(smu, METRICS_VOLTAGE_VDDGFX, &cur_value);
+		if (ret)
+			return ret;
+		size += sysfs_emit_at(buf, size,"%s:\n", "OD_VDDC");
+		size += sysfs_emit_at(buf, size, "0: %umV *\n", cur_value);
+		break;
+	case SMU_OD_RANGE:
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+						CYAN_SKILLFISH_SCLK_MIN, CYAN_SKILLFISH_SCLK_MAX);
+		size += sysfs_emit_at(buf, size, "VDDC: %7umV  %10umV\n",
+						CYAN_SKILLFISH_VDDC_MIN, CYAN_SKILLFISH_VDDC_MAX);
+		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
 	case SMU_FCLK:
@@ -394,6 +430,103 @@ static ssize_t cyan_skillfish_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_2);
 }
 
+static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
+					enum PP_OD_DPM_TABLE_COMMAND type,
+					long input[], uint32_t size)
+{
+	int ret = 0;
+	uint32_t vid;
+
+	switch (type) {
+	case PP_OD_EDIT_VDDC_CURVE:
+		if (size != 3 || input[0] != 0) {
+			dev_err(smu->adev->dev, "Invalid parameter!\n");
+			return -EINVAL;
+		}
+
+		if (input[1] <= CYAN_SKILLFISH_SCLK_MIN ||
+			input[1] > CYAN_SKILLFISH_SCLK_MAX) {
+			dev_err(smu->adev->dev, "Invalid sclk! Valid sclk range: %uMHz - %uMhz\n",
+					CYAN_SKILLFISH_SCLK_MIN, CYAN_SKILLFISH_SCLK_MAX);
+			return -EINVAL;
+		}
+
+		if (input[2] <= CYAN_SKILLFISH_VDDC_MIN ||
+			input[2] > CYAN_SKILLFISH_VDDC_MAX) {
+			dev_err(smu->adev->dev, "Invalid vddc! Valid vddc range: %umV - %umV\n",
+					CYAN_SKILLFISH_VDDC_MIN, CYAN_SKILLFISH_VDDC_MAX);
+			return -EINVAL;
+		}
+
+		cyan_skillfish_user_settings.sclk = input[1];
+		cyan_skillfish_user_settings.vddc = input[2];
+
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Invalid parameter!\n");
+			return -EINVAL;
+		}
+
+		cyan_skillfish_user_settings.sclk = CYAN_SKILLFISH_SCLK_DEFAULT;
+		cyan_skillfish_user_settings.vddc = CYAN_SKILLFISH_VDDC_MAGIC;
+
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev, "Invalid parameter!\n");
+			return -EINVAL;
+		}
+
+		if (cyan_skillfish_user_settings.sclk < CYAN_SKILLFISH_SCLK_MIN ||
+		    cyan_skillfish_user_settings.sclk > CYAN_SKILLFISH_SCLK_MAX) {
+			dev_err(smu->adev->dev, "Invalid sclk! Valid sclk range: %uMHz - %uMhz\n",
+					CYAN_SKILLFISH_SCLK_MIN, CYAN_SKILLFISH_SCLK_MAX);
+			return -EINVAL;
+		}
+
+		if ((cyan_skillfish_user_settings.vddc != CYAN_SKILLFISH_VDDC_MAGIC) &&
+			(cyan_skillfish_user_settings.vddc < CYAN_SKILLFISH_VDDC_MIN ||
+			cyan_skillfish_user_settings.vddc > CYAN_SKILLFISH_VDDC_MAX)) {
+			dev_err(smu->adev->dev, "Invalid vddc! Valid vddc range: %umV - %umV\n",
+					CYAN_SKILLFISH_VDDC_MIN, CYAN_SKILLFISH_VDDC_MAX);
+			return -EINVAL;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RequestGfxclk,
+					cyan_skillfish_user_settings.sclk, NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Set sclk failed!\n");
+			return ret;
+		}
+
+		if (cyan_skillfish_user_settings.vddc == CYAN_SKILLFISH_VDDC_MAGIC) {
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_UnforceGfxVid, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Unforce vddc failed!\n");
+				return ret;
+			}
+		} else {
+			/*
+			 * PMFW accepts SVI2 VID code, convert voltage to VID:
+			 * vid = (uint32_t)((1.55 - voltage) * 160.0 + 0.00001)
+			 */
+			vid = (1550 - cyan_skillfish_user_settings.vddc) * 160 / 1000;
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ForceGfxVid, vid, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Force vddc failed!\n");
+				return ret;
+			}
+		}
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -406,6 +539,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.print_clk_levels = cyan_skillfish_print_clk_levels,
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
+	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-- 
2.25.1

