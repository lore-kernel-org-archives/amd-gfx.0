Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB210C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E03C64EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E03C64EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A0C6EB8B;
	Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870B26EB84
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE3nxCyjEBSkFfr4UCggVNBj3oAKG0rK2rvVVgXxLChQtN9SigO/ZRIBMzH1vENXv7/RDDh8R25wZieGcDr+yss3cTd6LYsJESAimxe8HOYzEKnY+K5Sw+Aqd17/zzRTc/+KsSL6hK8vvq3q2PxUFz6+qv5hxyUUwwcFleT58k7Mx7B+BJ6e8tiFAJJRbNZeFRQRQEVPwiOfCKKsfyaMEgCEdVqMgmQgq3SnekHGBO/ERisuXJiWpxb215Qi6ThtqYdVFx2aD8EQxA+h8PyShsbdwjwqIju0ccsBOhNqwuFsKdxnoXwfRcaWKFAXvnH8ba0Rx0IN0zNGBys/yRKxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5DIoaU0SK/TnHIuIQuCZbdBGv4P5ykzNms71upPQKo=;
 b=ZnTnM7ovw8O+WrzF2bd/CfhaYDV5oIajjNXZhU7PkEUAtWBPH8gsn8FRoPO70OabX4bFeXHRIuaqTqShIO2C6Yrd2Urn41gLPC79vV9Xe1aH/54TozNC/8B0v835VuLRSc17lSAGH9HGvJSGKRbIwuULz43925WHzziY+MpoY2hndVU0jkvSdTCvhLxC4GhDxhjWMbMpOATKnrVR2x/i5qXdBM/NAXRmc8p1Mfe2LovJ/AABW08OxzCUFNhZzMUtPZX9ZTQkCIlLZqt9LomIBjQqchWOMZFESU6ZBg3oNprAvpUBfJ8HbFu1KJ6hnGoplMFQBsgSgMnl3DjQCTCLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5DIoaU0SK/TnHIuIQuCZbdBGv4P5ykzNms71upPQKo=;
 b=r573bgpdRlRwEmoFezFZxbef2cDSTbDWTlkGMKhieZVoTC55OiyweYaixJ5d++GqE2bIo7jTBPHo51jUpN+TP18kfJA77F5g8HMk4YuZ0/yAK6UZK70Z+U4waEnelVNpMWFEyvot2XgqDFqD2D7loDrxIOrLbmh11YBMhYL/5Ec=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:53 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 124/159] drm/amd/pm: Enable performance determinism on
 aldebaran
Date: Wed, 24 Feb 2021 17:18:24 -0500
Message-Id: <20210224221859.3068810-117-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b728e155-b68b-4d0e-2486-08d8d9126f84
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807367A8D24C373CA545E39F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CTS7AtNTS2GfrjypkcwYvhtKg3tqlP9pfs6SQPqlFUmM3wdQFEwgJH9I/w5+zcX2P4hI02OwMgesfDUJQPcTyan6SndPLQiNWj0qpL70ra7n7PqauywjHO3Qa0Zy4KCneo8xTg2IYWZdaGE+XOf4HGGbXvcnLD85JmKlFPTcUpKhm9uF7aieo4+ajJCuWZ8YyyvasZxgpKB8bGK1rf4deZ96TkQo5CKWIF7wFs378KswO6uKewoLTLJyHhP1UkCqgrC+twbKDMUiNTOpxYyFAXNiOm8LmMN+AwCUzhQaR5Lpmd28HgMUYiUXum8FFm/rAsmpawqogR/N0cRPZPsoQlXlz4SWugGm0YobyeVZ/uZnS8NxJVC22L7aLcNWAgT60sAltU1Oazungo/2nocZroDOhjKc/EM4+KGRrwAJ86YEAMkiW8arL56GDGNgTcnOoKBLx4hGQXtbjDvZzHQu4vmAML11wlMVqB8+r79XDiwLlyj7NiuaePVgeCCvHIWMlTQQwvE+uQInXzDDCT14QigVpCuJbJ2+qbVu21AkhXC5rAGjPlVQZQ20i0w+oxtO7iZPGEBRayi9/Fc6CQLRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XWNaeQvZZPSgdcn+kVeLdQeoIYF6VPZpnoJpSJKLtPgfiUoCBOjZt2L0kIMI?=
 =?us-ascii?Q?lWml4k8oVIOz5/ghCbZ5Ybffdy6x+fUV2DGK3/3dqJuZwAcLOZka5ZswgwDh?=
 =?us-ascii?Q?5JTPy054B/yqwO7CQE87Moyc5IBTxb+ChYLLwVr6Bzgl0chlqKtTHT6Gfe3T?=
 =?us-ascii?Q?HgSRgn/20hmmUcACIY9SAZ7RiE08ov3Iwqlo4/5CtN9fIWpCelrYVfG4dahu?=
 =?us-ascii?Q?tObWK5k3VK1FaiK9eU16XG3YCmw0jAEbRPffBD6iAKGJYihE/dCDjyXK3fXq?=
 =?us-ascii?Q?ha/xJXLoWPVnQthJY/Y32+w8kxoYaUJV4WO0Lnij//VHCFx1z4hXDkBZwHNX?=
 =?us-ascii?Q?IzlBzcA/VxsktVDoHfquZuP7psTclH4Ri9+bAskJWRXRfT2DTTXoL7s3ujcP?=
 =?us-ascii?Q?KXnfclMm0vfiva4kpAx0/vE+VFORgzDgehU0GZBej4O1KV7BF5oar3yzSjAA?=
 =?us-ascii?Q?su+TciyJyrDYcpUIkvOFmjt1c1THakXmAyz0oVF4BIUsl8q/cmagYzqaBtWe?=
 =?us-ascii?Q?WeEnHTwygJV6krb7WHoa3q+mAX1B65tZ24AhuVrTIyynB/NkRCfT4W+JPp2I?=
 =?us-ascii?Q?nsgRnkpJgBgW+fbykeFS+jlBOKN/6KZ/YU8AUxiuyDdWJTH5yMarHZsWv/n/?=
 =?us-ascii?Q?NKf6WhdhtppKR5s+/V0FQuDWQKIXO96412uQrATsNvDrUm79R0jZiqPnez54?=
 =?us-ascii?Q?og/fR+n+7CVfs2U9q2dapVQ32Ke4y632Qybjw3PO9wGNWi8fOlS0iR7UNG5c?=
 =?us-ascii?Q?ZFZGbjBeRHBn+ron9f8Lit5OFUEU9yvZeaqyD2AoHlBN4m/iKA/7XTetWcqT?=
 =?us-ascii?Q?c1M0ENkyGuI0KDTbMg8YdVF1/rafUPiCfRHT8ZILy4h8yWF7A7mNpK+YtvI+?=
 =?us-ascii?Q?JrHOSPy4ajxLzA24l62aWBai3v5dfTfdxfwnI9XiX5+dCN9CMt9HcAdOFXdT?=
 =?us-ascii?Q?h4APJfoLbFt1jHjoaBMc+A1yc4/fNXwFHAp6hHEsvCN/qt1urBAxcN5TQfOh?=
 =?us-ascii?Q?nYFoRad7yQKJSyUsip0s97Fbzr6K2VIJGoPiUpL/xFTl83Gz62j5Y6cag5pT?=
 =?us-ascii?Q?l21DD6lHjGXJkHNVL3oK66fdimmvDWeA+jv4IoG4RfhnDV2IcR0A5ZThFo/f?=
 =?us-ascii?Q?Dr50quOjQydBb7+FWQaQQeCtClQiDZiA5BBf4dgnxMv8Zh2LIgh0PllDtPGY?=
 =?us-ascii?Q?eDH9/FfudlKqveAnNVDnWNujNfqd7UANqHb0TiwCaZlmJlgLKRZqZTgPXWEg?=
 =?us-ascii?Q?2cBQMqG+baMxGPmwG91Gv9xmPlabKCZ6p3vn5RigQlv7cALD4JgyUv2qu23O?=
 =?us-ascii?Q?fRBHwGZcaMRtOMKJBGUM5r9V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b728e155-b68b-4d0e-2486-08d8d9126f84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:47.8416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XU4ulWsrC6FlErxYhCYxP94SmNM01yw2U/I12j11GWGL/Q6s0zaDS0AA1nCHO/QUNyQWUmGZQTP1KgI+mTVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Performance Determinism is a new mode in Aldebaran where PMFW tries to
maintain sustained performance level. It can be enabled on a per-die
basis on aldebaran. To guarantee that it remains within the power cap,
a max GFX frequency needs to be specified in this mode. A new
power_dpm_force_performance_level, "perf_determinism", is defined to enable
this mode in amdgpu. The max frequency (in MHz) can be specified through
pp_dpm_sclk. The mode will be disabled once any other performance level
is chosen.

Ex: To enable perf determinism at 900Mhz max gfx clock

echo perf_determinism > /sys/bus/pci/devices/.../power_dpm_force_performance_level
echo max 900 > /sys/bus/pci/devices/.../pp_dpm_sclk

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 88 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  6 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 59 ++++++++++++-
 4 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a41875ac5dfb..c6b5c789abf0 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -48,6 +48,7 @@ enum amd_dpm_forced_level {
 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK = 0x40,
 	AMD_DPM_FORCED_LEVEL_PROFILE_PEAK = 0x80,
 	AMD_DPM_FORCED_LEVEL_PROFILE_EXIT = 0x100,
+	AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM = 0x200,
 };
 
 enum amd_pm_state_type {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b770dd634ab6..309ee950b073 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -298,6 +298,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 			(level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) ? "profile_min_sclk" :
 			(level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) ? "profile_min_mclk" :
 			(level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) ? "profile_peak" :
+			(level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) ? "perf_determinism" :
 			"unknown");
 }
 
@@ -333,6 +334,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
 	} else if (strncmp("profile_peak", buf, strlen("profile_peak")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+	} else if (strncmp("perf_determinism", buf, strlen("perf_determinism")) == 0) {
+		level = AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM;
 	}  else {
 		return -EINVAL;
 	}
@@ -1090,6 +1093,83 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
  */
 #define AMDGPU_MASK_BUF_MAX	(32 * 13)
 
+static int amdgpu_read_clk(const char *buf,
+		size_t count,
+		uint32_t *min,
+		uint32_t *max)
+{
+	int ret;
+	char *tmp;
+	char *token = NULL;
+	char *tag;
+	char *value;
+	char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
+	const char delimiter[3] = {' ', '\n', '\0'};
+	size_t bytes;
+	int i = 0;
+
+	bytes = min(count, sizeof(buf_cpy) - 1);
+	memcpy(buf_cpy, buf, bytes);
+	buf_cpy[bytes] = '\0';
+	tmp = buf_cpy;
+
+	*min = *max = 0;
+	while (i < 2) {
+		ret = -EINVAL;
+		token = strsep(&tmp, delimiter);
+		if (!token || !*token)
+			break;
+		tag = token;
+
+		token = strsep(&tmp, delimiter);
+		if (!token || !*token)
+			break;
+		value = token;
+
+		if (!strncmp(tag, "min", strlen("min")))
+			ret = kstrtou32(value, 0, min);
+		else if (!strncmp(tag, "max", strlen("max")))
+			ret = kstrtou32(value, 0, max);
+
+		if (ret)
+			break;
+		++i;
+	}
+
+	/* should get a non-zero value for min or max */
+	if (!*min && !*max)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int amdgpu_set_clk_minmax(struct amdgpu_device *adev,
+		uint32_t clk_type,
+		uint32_t min,
+		uint32_t max)
+{
+	int ret;
+
+	if (!is_support_sw_smu(adev) || amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return ret;
+	}
+
+	ret = smu_set_soft_freq_range(&adev->smu, clk_type, min, max);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
 static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 {
 	int ret;
@@ -1128,10 +1208,18 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int ret;
 	uint32_t mask = 0;
+	uint32_t min;
+	uint32_t max;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 
+	ret = amdgpu_read_clk(buf, count, &min, &max);
+	if (!ret) {
+		ret = amdgpu_set_clk_minmax(adev, SMU_GFXCLK, min, max);
+		return ret ? ret:count;
+	}
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 474a5dd04c43..affe091587d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1618,7 +1618,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		smu_dpm_ctx->dpm_level = level;
 	}
 
-	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
+	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
+		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload = smu->workload_setting[index];
@@ -1693,7 +1694,8 @@ int smu_switch_power_profile(struct smu_context *smu,
 		workload = smu->workload_setting[index];
 	}
 
-	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
+		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_set_power_profile_mode(smu, &workload, 0, false);
 
 	mutex_unlock(&smu->mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2427681fab8a..629523858660 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1078,7 +1078,6 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
 			return -EINVAL;
 		}
-
 		power_limit = pptable->PptLimit;
 	}
 
@@ -1103,7 +1102,19 @@ static int aldebaran_system_features_control(struct  smu_context *smu, bool enab
 static int aldebaran_set_performance_level(struct smu_context *smu,
 					   enum amd_dpm_forced_level level)
 {
+	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
+
+	/* Disable determinism if switching to another mode */
+	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+			&& (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
+		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
+
+
 	switch (level) {
+
+	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
+		return 0;
+
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 	case AMD_DPM_FORCED_LEVEL_LOW:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -1117,6 +1128,50 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 	return smu_v13_0_set_performance_level(smu, level);
 }
 
+static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max)
+{
+	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
+	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t min_clk;
+	uint32_t max_clk;
+	int ret = 0;
+
+	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK)
+		return -EINVAL;
+
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		return -EINVAL;
+
+	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		if (!max || (max < dpm_context->dpm_tables.gfx_table.min) ||
+			(max > dpm_context->dpm_tables.gfx_table.max)) {
+			dev_warn(adev->dev,
+					"Invalid max frequency %d MHz specified for determinism\n", max);
+			return -EINVAL;
+		}
+
+		/* Restore default min/max clocks and enable determinism */
+		min_clk = dpm_context->dpm_tables.gfx_table.min;
+		max_clk = dpm_context->dpm_tables.gfx_table.max;
+		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);
+		if (!ret) {
+			usleep_range(500, 1000);
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+					SMU_MSG_EnableDeterminism,
+					max, NULL);
+			if (ret)
+				dev_err(adev->dev,
+						"Failed to enable determinism at GFX clock %d MHz\n", max);
+		}
+	}
+
+	return ret;
+}
+
 static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1351,7 +1406,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
 	.baco_is_support= aldebaran_is_baco_supported,
 	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
-	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
+	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.set_df_cstate = aldebaran_set_df_cstate,
 	.allow_xgmi_power_down = aldebaran_allow_xgmi_power_down,
 	.log_thermal_throttling_event = aldebaran_log_thermal_throttling_event,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
