Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC86C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 10:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6C710E1AE;
	Thu, 23 May 2024 10:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eHiHixG5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3009810E1AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 10:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx+S8qp4rAXCPd14AF2Cey78G1ldp0hisQZirqLyj26Oht0mRXHG+qU9gtfqKTMAOaHwwSOTRM8HXBMpwnO5yl+i1Z4AoAeoMIBcwhuYIOrTmmycdjvl3ikC3TrTbsTcYgjhHzJDx9hIM4YOpGrtJM42QS6uJ/K8AmAhICLDrLupqQBjed44AagdUPzWEY9xc7dnzjsTJn51pMYJ5rCnsrZdud/jLJQJ97Wxl/Wvow3gwaCSB/CPmm7Zu5bgGrQoDHQSEU53VP+RxSLR1ue6ntzC1uT3LbTuUssizJuiU1btJ/kVK3eoeEZPMfR5MnqKE+gPerevXO2tgE2jp5IEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP1Rdn3IFhvc61QT9AU4G8l+L92Q9JXucg1trksTE1A=;
 b=jjPVN8F7z26mPqYxVh11rl6b4z0zVFFOpzGJdcTOrG4aG9eZGEjHhM9XTCAR+0fWUW4R9a1GAg/HqDrmKdY1Hl8EHS9BJMm1tNncxw1VdRfAgPHQN1EBTM3v7SaL70OAhkTVa/yJXQF+39lKWmW9PJ/k9blRp5Ha9zciIo/p4xbATanygyPYX6Oy+cYFpDOwqCdlL9j3sEPjqAhy44im1cCE+Z1D9dwF2RGgSsn2ojM5a/Ebcq37vHg/8rZt0gl3Or0eo8GnDW8UIzlIskwMnIFx19DpcS6ljPdjh5FN5gA90r019/ijL+Cg1CcuouSr9ZdpOnwB0cQ1Q/0Jj5EiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP1Rdn3IFhvc61QT9AU4G8l+L92Q9JXucg1trksTE1A=;
 b=eHiHixG5gnVx2EnP6HzSMuSyBTmyT2XvCbptCUntsd3v3oPVSw7cFP0mZMYtWffliuzibl/vxjh5hhndif/sISWL1aSvpVENP/eDuWYRGBWLjZYIRMwzPTYEhbQexoOnYQHoQ+x3g9pEwL8JYqtt01puhrRh9euHuuomBvEUTT4=
Received: from BN9PR03CA0458.namprd03.prod.outlook.com (2603:10b6:408:139::13)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 10:02:03 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::71) by BN9PR03CA0458.outlook.office365.com
 (2603:10b6:408:139::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 10:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 10:02:02 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 05:02:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
Date: Thu, 23 May 2024 18:01:47 +0800
Message-ID: <20240523100148.2457-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: c9165ca0-ba12-41a8-c287-08dc7b0f6513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SZSJthpolzVJn+stjvN/fAmk0feqzXsF+V5NUr0DWSxxlyn7GpItHCe1Dmr/?=
 =?us-ascii?Q?DLv7s3Mjk4pJIdCRDuweawRipeUGLRi6lHOtPta9yJzGnqdgIqeE/yIiUUuH?=
 =?us-ascii?Q?c5EWxvQSDeKptzxKVThDaJzM6geyJ5zuN5raALHB3HBVzSDFOKQxvKCXrxNV?=
 =?us-ascii?Q?x6jbn/LSCPSqJegG0ji6YjmsBe9suwMqONDoViJjvTbrU83ddwQT/S2hpy1S?=
 =?us-ascii?Q?oamuEl2bxmzB1SviYCOc5RYEvXa1VE9wqyTHGstVoymyNeesLDqAuL0c51EE?=
 =?us-ascii?Q?+g0/uYe61NMhN79tXoNVnkMxzbZag0zOFipOi6tmJLXzWyAUaw6UwPb6TI97?=
 =?us-ascii?Q?IDJl/+yCwIwzo5pJe7uE4TXoCNj3IcxxZ1OkguYyITVLcCCpf/vct1+0Zkkx?=
 =?us-ascii?Q?bAZFdl2N2WFYEK4Lb487eXciouvruTG5BGAmq7iVeQouUdB+nQFHChFe4s28?=
 =?us-ascii?Q?+5JtE8/djDxUlS7f/p9f7HbKYujOkkOahusbx09WJ1Xa3Gch1/TP1gDithXO?=
 =?us-ascii?Q?EDzgvYBSu1VK6fLQLGODapIoBxPhRwAwYGianGzfOIrLQQ/YcYC2tr85t/Mf?=
 =?us-ascii?Q?1LrGOYPgnlZowxzxFLcoi6tx+K1JrJRjywqL9V5nKJvpyQ6sy9pXKJ4rS6BU?=
 =?us-ascii?Q?n11E4+cA+6nyvMJ9/4A6fT5C5TCjBO57mM04Qn19gGA5WGG68qMCxC57Kl7Z?=
 =?us-ascii?Q?/xPEIGFjMj8CYHPJb3Z7imov8EgEmjbHd/YE5lLvKD1ZHPOOYTioq3B8kK66?=
 =?us-ascii?Q?JScTEZOP5eywv/jRLbnH3tv8eFVSGu2M6cWoZber0vgXWfNXNUpzN7oOeZdA?=
 =?us-ascii?Q?36pkpv0FfhQyoatgy0LXmCMwLS3jtx5GGJtCipk/Vz0xXkT6Ry5IxaeLW9FH?=
 =?us-ascii?Q?SE8ZwGAyLAaNuBZx9zO+/9BMqKs0a3GU/V6p/PYM8zxgP0HYBAk8T/PUrGQF?=
 =?us-ascii?Q?3X4JmonKp8mWx9QQaCK1f9G2CVEDOr+idRCGBAX6Dv9YEm1LH0V/CbwEBur7?=
 =?us-ascii?Q?DLlDEqqjkTkh0+MbMSs6OO4iitNyJIevaM8+nCDeGVhKR64VZOxgGg9gkvGj?=
 =?us-ascii?Q?/wjxkT97mEu92SHHGl+YsEPpepm69Gr/II22W37ACPZyS0itGmQbKJe5S7Uo?=
 =?us-ascii?Q?P55rAZkT2TXY70jOOd2O/3LXxOflWhjTZRw0TtkXSSDiQZKB9JJDZZkJf9k5?=
 =?us-ascii?Q?ITFyl05JKk5djQ0OGlUz3v3VX/sG+lpNQ65we7gubn4AWqhgl7lDdIwhbf7/?=
 =?us-ascii?Q?rVuZ4AutcjQV6/7NPoTEupspWwP8xEOrI3O8rjkXQFQPK4NErF93T00VzFmM?=
 =?us-ascii?Q?RCkSC/cKml1+koFvCbD/Rv1CmthaPaSzyzbEFNQWQ61dNEoSTRy81uncyEW+?=
 =?us-ascii?Q?V0SzNjE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:02:02.9974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9165ca0-ba12-41a8-c287-08dc7b0f6513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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

Set the flag to true if bad page number reaches threshold.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 +--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ecce022c657b..934dfb2bf9e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2940,7 +2940,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
 	u32  max_eeprom_records_count = 0;
-	bool exc_err_limit = false;
 	int ret;
 
 	if (!con || amdgpu_sriov_vf(adev))
@@ -2977,12 +2976,12 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 */
 	if (adev->gmc.xgmi.pending_reset)
 		return 0;
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
 	/*
 	 * This calling fails when exc_err_limit is true or
 	 * ret != 0.
 	 */
-	if (exc_err_limit || ret)
+	if (con->is_rma || ret)
 		goto free;
 
 	if (con->eeprom_control.ras_num_recs) {
@@ -3033,7 +3032,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 * Except error threshold exceeding case, other failure cases in this
 	 * function would not fail amdgpu driver init.
 	 */
-	if (!exc_err_limit)
+	if (!con->is_rma)
 		ret = 0;
 	else
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index d06c01b978cd..437c58c85639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -521,6 +521,7 @@ struct amdgpu_ras {
 	bool update_channel_flag;
 	/* Record status of smu mca debug mode */
 	bool is_aca_debug_mode;
+	bool is_rma;
 
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9b789dcc2bd1..eae0a555df3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -750,6 +750,9 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			control->tbl_rai.health_percent = 0;
 		}
 
+		if (amdgpu_bad_page_threshold != -1)
+			ras->is_rma = true;
+
 		/* ignore the -ENOTSUPP return value */
 		amdgpu_dpm_send_rma_reason(adev);
 	}
@@ -1321,8 +1324,7 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	return res == RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;
 }
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
-			   bool *exceed_err_limit)
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
@@ -1330,7 +1332,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res;
 
-	*exceed_err_limit = false;
+	ras->is_rma = false;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
@@ -1422,7 +1424,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -1.");
 				res = 0;
 			} else {
-				*exceed_err_limit = true;
+				ras->is_rma = true;
 				dev_err(adev->dev,
 					"RAS records:%d exceed threshold:%d, "
 					"GPU will not be initialized. Replace this GPU or increase the threshold",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 6dfd667f3013..b9ebda577797 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -129,8 +129,7 @@ struct eeprom_table_record {
 	unsigned char mcumc_id;
 } __packed;
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
-			   bool *exceed_err_limit);
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
-- 
2.34.1

