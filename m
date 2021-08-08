Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F981C4338F
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510FA60F42
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 510FA60F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542BE89C86;
	Sun,  8 Aug 2021 05:30:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6AC89C86
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrElEkaEAG6zxGQz0IJ+aRAQMEK5Wz+HK3+geS2HabHA+hu3YYtlrnzUC8dqASJaNTszVzoIKR0RB14NGhCorMfPPIEYIRMSpRCG2emb6xPJODDXRqUUbS3Jnw9qsloFGzeCfY6xIpJoE8fHM7xRjfYCGFbhvfqj+Vjkn5veGy/66dExJlfVO7q+FeFL9LRil/7NRrW+tgOOAxYR8wYWbOSMt9SBb3tHIR/2sMrLjeqnQzwiaFHmMeLocO9lmXzw6EEBoN0spgQxx5AwemfTYwS8m3z4DcQ+YXpYTTOrcGeuYcMR1Rcwdj7vJELCgNYgAORQeh0/9pgpkR3zyLXXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ3h6nC2VGwW9ycltPu3/AmIOeNmzNiSPoQRC1QK3KE=;
 b=Dpgoa15u5IJAnq6QQB5NSaTyvozJ6Cay4VhM2LLKdZGk9PKI8SEZCwuikNKBkgw9Fgjq31xsFp+yaCquEGq3ak3+bj6NogR4uT3yRTWuxSOwIu22fJi7lJGy2JaJv10Q3vl+tqzJjr8J3TfTjwFcRZGMl5TPU9BRUMZJlbQPEgbCSvqev96mBe3uZeKSzBpSz1uYq2VB+uThEOU/nsIbTH8ESpFCAML6oYXmWByWDc20Id/2sxnwSPYEnBB9M4a28AUJblNHaVjsDRZ6dr9sE4DuiCaDezJrldXHFDrULMimI1T3uXnr7//yx0tH6BH9kZsDT729yoaeh17qO73vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ3h6nC2VGwW9ycltPu3/AmIOeNmzNiSPoQRC1QK3KE=;
 b=XEWHPActACto/OolKVLG49kA086V5tW728r0YggtuRQRc1tWjMfjiHoenk756IY8DoAQ3EHJkpFxx2RC98EkZvYONT7t+qTTRyZrxXmQaPHDdlZSnxsQGFx4H0MNZ7+FC24g8od893noKmRxvrceZJaHsIonKMNH46zAgEF9zAM=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by SN6PR12MB2848.namprd12.prod.outlook.com (2603:10b6:805:77::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Sun, 8 Aug
 2021 05:30:36 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::bb) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:30:36 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:30:35 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 2/3] amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
Date: Sun, 8 Aug 2021 01:30:18 -0400
Message-ID: <20210808053019.3310-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210808053019.3310-1-darren.powell@amd.com>
References: <20210808053019.3310-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c972ec36-4458-4f96-8488-08d95a2da6a3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2848:
X-Microsoft-Antispam-PRVS: <SN6PR12MB284838EE247A032A55102C46F0F59@SN6PR12MB2848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXgGtiZ0LR98wd6bDrXjU7Y0pWLidBUzVi1ufyoTJp9pAF0OnGpDEghHchz5wZREioz7K8rxMuUblR6TGgzd9kXns5XKlj0pEQls2sJJ1lggEc23yV8vJNgG2+EtHM4iX+xVdPq856Kvlx8pQ/wfPtyKugPFhsUoaS8geBOkIu5YPCsAHwnkr6kuSEvQBjsaMGMPpBTOqr9Orz4VfQzJKE5/89ifnNnBg5Y2uyi+s7dUUfRoWiKv3w5QglJWIoIB1i/2ZmSDr1RTjT4476jwABIxnyd93hgGZKuEqjxRLJXP9rLDqQjua5FPWYjU6uscuWIwXgDhtN3DUZ5+XZpK+QRIpIioG8+a7BbxdWeyug0dEyfmwXgbd/BLeRLuggsYksI5JQdl7GKa2O7/x7RvH20bUhTBni6MJXuiHngvlkMqC5SZi85jk0QPJ/c8scNVnXihPdx1LDqKXsyOoo8vyvme9fTc7MyPG16jFg2D9wwyGkKWylV2+o4SQt0EVuh9Q49Y6EutphdOGpfZQrOB46F5fw5KdshMyREX4mKASocpMSC3WR1NJRIRxFbprRLsKf3A2ZpSrrrF9qXVEvw5+LwckVLAkP5vVvv7f1ZFwQMcw0sgNQ78W6nsnUBG402GUG2kebd0RidId650vT8lV6+ZiJV/hN1WFuxSg4Q+ObKYm7m2igUTkNipAj+LmjSJ3tTUqDMXnIoC1THrDTHsybiLzMLnzi+J1SDI/lF8Cd11M9xZ4WLzqgGlua+1/Kq4h+47WAOt8SZRvV1ef5369Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(70586007)(5660300002)(8676002)(2616005)(70206006)(44832011)(478600001)(426003)(47076005)(336012)(34070700002)(36860700001)(356005)(82310400003)(6666004)(2906002)(81166007)(1076003)(4326008)(86362001)(7696005)(83380400001)(82740400003)(8936002)(36756003)(26005)(186003)(30864003)(316002)(16526019)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:30:36.4958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c972ec36-4458-4f96-8488-08d95a2da6a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
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

 modification of smu11 files
  arcturus_ppt.c
  sienna_cichlid_ppt.c
  vangogh_ppt.c

=== Test ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 +++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 46 +++++++++----------
 3 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6ec8492f71f5..8ab58781ae13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -756,7 +756,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	uint32_t gen_speed, lane_width;
 
 	if (amdgpu_ras_intr_triggered())
-		return snprintf(buf, PAGE_SIZE, "unavailable\n");
+		return sysfs_emit(buf, "unavailable\n");
 
 	dpm_context = smu_dpm->dpm_context;
 
@@ -780,7 +780,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		 * And it's safe to assume that is always the current clock.
 		 */
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
 					clocks.data[i].clocks_in_khz / 1000,
 					(clocks.num_levels == 1) ? "*" :
 					(arcturus_freqs_in_same_level(
@@ -803,7 +803,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -826,7 +826,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -849,7 +849,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -872,7 +872,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -895,7 +895,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < single_dpm_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 				i, single_dpm_table->dpm_levels[i].value,
 				(clocks.num_levels == 1) ? "*" :
 				(arcturus_freqs_in_same_level(
@@ -906,7 +906,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		size += sprintf(buf + size, "0: %s %s %dMhz *\n",
+		size += sysfs_emit_at(buf, size, "0: %s %s %dMhz *\n",
 				(gen_speed == 0) ? "2.5GT/s," :
 				(gen_speed == 1) ? "5.0GT/s," :
 				(gen_speed == 2) ? "8.0GT/s," :
@@ -1272,11 +1272,11 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		return result;
 
 	if (smu_version >= 0x360d00)
-		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+		size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
 	else
-		size += sprintf(buf + size, "%16s\n",
+		size += sysfs_emit_at(buf, size, "%16s\n",
 			title[0]);
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
@@ -1302,11 +1302,11 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 			}
 		}
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
 		if (smu_version >= 0x360d00) {
-			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+			size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				0,
 				"GFXCLK",
@@ -1320,7 +1320,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 				activity_monitor.Gfx_PD_Data_error_coeff,
 				activity_monitor.Gfx_PD_Data_error_rate_coeff);
 
-			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+			size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				1,
 				"UCLK",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 90e40aacb8f6..cc8bc500ea0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1089,7 +1089,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 				if (ret)
 					goto print_clk_out;
 
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
 			}
 		} else {
@@ -1111,7 +1111,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			}
 
 			for (i = 0; i < count; i++) {
-				size += sprintf(buf + size, "%d: %uMhz %s\n", i, freq_values[i],
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
 						cur_value  == freq_values[i] ? "*" : "");
 			}
 
@@ -1122,7 +1122,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		GET_PPTABLE_MEMBER(LclkFreq, &table_member);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
-			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
+			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
@@ -1145,8 +1145,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS))
 			break;
 
-		size += sprintf(buf + size, "OD_SCLK:\n");
-		size += sprintf(buf + size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
+		size += sysfs_emit_at(buf, size, "OD_SCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n", od_table->GfxclkFmin, od_table->GfxclkFmax);
 		break;
 
 	case SMU_OD_MCLK:
@@ -1156,8 +1156,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS))
 			break;
 
-		size += sprintf(buf + size, "OD_MCLK:\n");
-		size += sprintf(buf + size, "0: %uMhz\n1: %uMHz\n", od_table->UclkFmin, od_table->UclkFmax);
+		size += sysfs_emit_at(buf, size, "OD_MCLK:\n");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMHz\n", od_table->UclkFmin, od_table->UclkFmax);
 		break;
 
 	case SMU_OD_VDDGFX_OFFSET:
@@ -1173,22 +1173,22 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		     (smu_version < 0x003a2900))
 			break;
 
-		size += sprintf(buf + size, "OD_VDDGFX_OFFSET:\n");
-		size += sprintf(buf + size, "%dmV\n", od_table->VddGfxOffset);
+		size += sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
+		size += sysfs_emit_at(buf, size, "%dmV\n", od_table->VddGfxOffset);
 		break;
 
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
 
-		size = sprintf(buf, "%s:\n", "OD_RANGE");
+		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
 
 		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMIN,
 							    &min_value, NULL);
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMAX,
 							    NULL, &max_value);
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 
@@ -1197,7 +1197,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 							    &min_value, NULL);
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_UCLKFMAX,
 							    NULL, &max_value);
-			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
 					min_value, max_value);
 		}
 		break;
@@ -1420,7 +1420,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
 
@@ -1440,10 +1440,10 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 			return result;
 		}
 
-		size += sprintf(buf + size, "%2d %14s%s:\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			0,
 			"GFXCLK",
@@ -1457,7 +1457,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 			activity_monitor->Gfx_PD_Data_error_coeff,
 			activity_monitor->Gfx_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			1,
 			"SOCCLK",
@@ -1471,7 +1471,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 			activity_monitor->Fclk_PD_Data_error_coeff,
 			activity_monitor->Fclk_PD_Data_error_rate_coeff);
 
-		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
 			"MEMLK",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 18681dc458da..b3f2390696cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -592,28 +592,28 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
-			size += sprintf(buf + size, "CCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
 				smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 		}
 		break;
@@ -656,14 +656,14 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 				return ret;
 			if (!value)
 				continue;
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
 			if (cur_value == value)
 				cur_value_match_level = true;
 		}
 
 		if (!cur_value_match_level)
-			size += sprintf(buf + size, "   %uMhz *\n", cur_value);
+			size += sysfs_emit_at(buf, size, "   %uMhz *\n", cur_value);
 		break;
 	default:
 		break;
@@ -691,28 +691,28 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_SCLK");
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
-			size += sprintf(buf + size, "0: %10uMhz\n",
+			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
-			size += sprintf(buf + size, "1: %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
 		}
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sprintf(buf, "%s:\n", "OD_RANGE");
-			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
+			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
-			size += sprintf(buf + size, "CCLK: %7uMhz %10uMhz\n",
+			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
 				smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 		}
 		break;
@@ -755,14 +755,14 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 				return ret;
 			if (!value)
 				continue;
-			size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
 			if (cur_value == value)
 				cur_value_match_level = true;
 		}
 
 		if (!cur_value_match_level)
-			size += sprintf(buf + size, "   %uMhz *\n", cur_value);
+			size += sysfs_emit_at(buf, size, "   %uMhz *\n", cur_value);
 		break;
 	default:
 		break;
@@ -1035,7 +1035,7 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		size += sprintf(buf + size, "%2d %14s%s\n",
+		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 	}
 
-- 
2.32.0

