Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979A7C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0092D10E31F;
	Fri, 31 May 2024 10:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ABHaSnQc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6908D10E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvphp3JUfZmCyCdkf5baszVohsVazLJmyBBgXmlgUo8aQi0BDmPI5reEjSB7JGBohBaAT+Fx9TTV5g7gajc+DH2FXfTKFQ6Wbb9dnUa+lBiFQM5ACqUESRIBv6hFPExXpaPf7KLqMGqHFI0xyEt6O6BeQBTwEVe2PhwBoB4rse+H7tP9BYqy/mxJGuCF48hWmi9tznOoTb3fOAA2NHGP2oVdANpNUwouF9fLgtIiElu2EdnLaVrc89TPlrtUio2nEbl390zYIwtQQdhtJmKIB9YsLyJHg2E+w+WwwJ1RYrfsei1ZuEI0vqC7KfXmteIpnjQ5gmYmoqWwuoOIDJm5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnWboZPFkfMf/Lx1qUj3jUxy50Bdf+LVQHl6rXnuLq8=;
 b=kCtCfnfXilCnZE49Rxw9xAs9Fn0sBH8+fJKmvBhQRv5tz1Btr4NVkCQkxiwmG4mve2uyDU3o7ws7SOIsVsdTjmMsk8NcaGiJ4DnozdIpvGpMQZdHWRoqBCyOr4y/vKQ5Bl3I2PSSrgXaJlKcb36wjh5wrPCnblUpkuSKWTtXjSDMUmdB9N+SmUhZB7O2phQseAT/llaaaba0zm+qt4BDnEAorCCUfvvsoBahRKmwc2Xx6dMfca2eHP0WBM2V8r9uhmp6aCq4g1yUiw2sB7BrdZ505TfaLYV6o4TdQNNSscL+kZsb8QmcJNF1Nce0vBzkXJKrGqT3TUpfwOyYLbpcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnWboZPFkfMf/Lx1qUj3jUxy50Bdf+LVQHl6rXnuLq8=;
 b=ABHaSnQcaPaHvZ9WcFul6FpNDHwEYlFywp6UG2wLkWlpVUFVLaljbvYgHjQZr9Sbqu4a5Le//Q8ctOOF65kGsZ4wRyTgGzphjxQ5jupMqW0gcTzT8JnlldLMMpDm0SCPowELYZ9Y6GCS/kwhc0WR60pJ4umxa6ypVAMbCbMMI8U=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 31 May
 2024 10:49:22 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::92) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 10:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:49:21 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:49:19 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add RAS is_rma flag
Date: Fri, 31 May 2024 18:49:07 +0800
Message-ID: <20240531104911.14748-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdd6327-f3bf-413b-b0e4-08dc815f5464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rc9BvPZSSvawwsFRu/Gnons4bNR5O7+n/sPa+vOKtefwqzl3Lj+B4SgCneQq?=
 =?us-ascii?Q?d0c1s38A/oVWwXg0ioVFC6CcpAwV9oEmAWcfwuE/mEgqF3ORgubb/v+g3JyG?=
 =?us-ascii?Q?LEJeJe8S/hG6dULMW/LBNIOr7cG9wozQfihN0H0+waFXqTJR1JZXqb5aYXT1?=
 =?us-ascii?Q?Do1Av2P17YJHTYscuFMb6Zgatvfg2a6xnSKGcSImeJqoAwyXwsCKDbNDwaoC?=
 =?us-ascii?Q?ZHzbAdxjvzXCr8SvAJVUMmwbrCCwV2Xg3ZYRgxgobpdfei81DKD8z8dozbkJ?=
 =?us-ascii?Q?VHe4UVi+ePLZP4CWty1pq1yU3sSfwEPsEzbgAWE6PlFbk0dBw1COs8oQ9zHP?=
 =?us-ascii?Q?/MrXX6gdD1v9p7lbOMhn5RzZb1foH1FwgojGfKt6ITBTASyuIYtcYWrKyK49?=
 =?us-ascii?Q?Wl6mPraDhHHOD4C1CSszo+NLeNsl2+m3YjjtkWOI2p+MS1UUO661tBwd5rEf?=
 =?us-ascii?Q?wbQC8RWIIfTYecHFJR1VoSoUyhkUV+crONZat4uEyithRpiJYFw1Rqq9Cwt/?=
 =?us-ascii?Q?Ychk8WeHXY8/JP2ImYsWPy9BjeYad9nYO5LzETCNpsnhX5E74Kmux/TGykpV?=
 =?us-ascii?Q?+Bfij03YsdIMDtHDZ3MVUQbSYD6tOiVuw2CBhs5SqfNbwy0gphvOVSs3xihf?=
 =?us-ascii?Q?scfyI3IUNIMTJajegK+Y60UXccAU90xFRPGPm9c+QjH7kdhabqcpbofW16mD?=
 =?us-ascii?Q?c6CiE6Gfq0alMTo5VpL1sqcy27XdoGibXDhaUaVPTtAdt8jO750W+erVghdd?=
 =?us-ascii?Q?FuSjZ5gjXodrxhpns2fdj9DYgspKpmctqarp/RwdFMqETWm81SWyxTbiTBfh?=
 =?us-ascii?Q?lBQIJefjsGp2SeBNC6Aco42pBqS0/jh/uxtr3M6gNLkyJzo1RfpsXpaGXgiu?=
 =?us-ascii?Q?VEDrjT/S8Ka/gBhI/5oGjtRVVWmA8ANDPQYbprCXac+csH5+Gb7i96wUbiIl?=
 =?us-ascii?Q?F1v58w5PYqqZvI9TD+/lbiBXrQjU2GcxVuDKc9p7PaLiyje5jy9LriCaOUTd?=
 =?us-ascii?Q?szcq4Op4luYHV2CIGqO9ZzpxvuKi5HLGx8zGkZ98jSZZTSFCeQBIyZ/XYhHr?=
 =?us-ascii?Q?0O6hq1Mq2ol9uRSWhJwrEcJ9lNs+OdW/mXxlL7l2rDK1NdveOCAIyIiatqhj?=
 =?us-ascii?Q?u2lnJB8K3eCBvHhRUdQHPhV2JnZlH444qQIVaGi8wPtAu2kaah2THxf5YT9y?=
 =?us-ascii?Q?fU9csWBpC8Yk/cEfOcTJSfO/hwLSejhkJXR9Q0Yiwih0J+FXl9BzGnZWg0Ab?=
 =?us-ascii?Q?Cs9ix/5dAZ5yTR7QdgZn6hG5txyUSYse+6ldbl4JpO8HFc3VyutbfL1KfHZd?=
 =?us-ascii?Q?64cDwVWxQLRv8j1zL97UZ7xgu+JjlJe/7LH0y+zOLmGMY4NGW4glvFj8Ym6B?=
 =?us-ascii?Q?o3QmT84=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:49:21.6747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdd6327-f3bf-413b-b0e4-08dc815f5464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
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
index 2dc47475b8e9..616dc2387f34 100644
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

