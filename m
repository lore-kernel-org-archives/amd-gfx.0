Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B5C43461
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB62122CBE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aAOh6lzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB62122CBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0839E6E1CE;
	Tue,  8 Sep 2020 13:06:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6480A6E029
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 13:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf42FnKrN2tcDjom8+MckVDj+WtV9//5ZfSYsp3THV9blxp87a7sdPbqpA5utFtRRShczWuAnXzh4NqjMeVK3HQRRgLVRp8US9I8f2VVlKT7H2eov26WAnqo4GCSbqxlWMUhl+T+7/jmUmd5KuwNJclkpF3fTIgiur7dEyVIjdNbO/OeREswg76OlnlvEpqs4u0WnuhHF1SCMPisf7ZIaZG/j5qzaqehQYs8MnePgrjnPkk0qrxjqKFDsmLubeQI2z2TZlptJ5doL9Mxz/rkDpzpT8JS5LxC0GD2jx9Y/xJqg0nOpKCCnxyagAKeKkL5sFWvdt3njjoFrk3V6voesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMzSFHSXv+BWk0jRijO5ddStd0dgN+OP6xAXkt2Lguk=;
 b=U1ARfB0A84//0jF8Bn9KbLTIZ2ocPnqf/ChknU5ddXrOIYHjnvOST807pBz1Qkp0IHkoV4sTsIfaeIA6EPULNV8gkU/xNrVVdyXRirvsEPvPVPctbbdWPQfqE3VUajFY37fM40BU+gQEzXcNwH9UEoJrcUeDZlwGwbWFShXfyCVikki5TxH/WDnKHibrTRyRvCP6ZmabQq8m1161MvU4nRUCxOCTZjSnwR6l7wBhhM/FbUq+8TjWAF/IauwU7p3B0VsPcVWno4skcnnXL1RTp8Nb4hV2B/BILKF5dTneX3riaFPvhfCDdLRDrNralUXzG0x6nZFLHDbMaWmHApkJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMzSFHSXv+BWk0jRijO5ddStd0dgN+OP6xAXkt2Lguk=;
 b=aAOh6lzUrXQyggVS0kskN1NGpsQvH2JRSqxzrxKA8EheYCwfo5zfxcsm9dQjorUgcb06nIyyP2aref0rS9nrRPxZSnCFkXHJvxV5CQyGzg8ej4vGvjWc5WEqCfKjTcLDsgg0BaQjD+P0dwvjr9j2XIb9YN8GJTedxHuKGyj+qm0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 13:06:46 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 13:06:46 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: stop resetting xgmi perfmons on disable
Date: Tue,  8 Sep 2020 09:06:00 -0400
Message-Id: <20200908130603.10344-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 13:06:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df03f703-e506-4e85-8c05-08d853f809fe
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB36043EE4778797C463D6A79C85290@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73zbrPJpgvhx6Mug2J2YcTK8MSna4bdKcnYtHY0ng59eMKQq445tHC1Ye1IHtdDt57s+vz8LCeL8TvvEf6Q0K5FhCuYLN/urncSDW9+cpne2KuhKNEkNKgTZ5gpCKyrJ5dn1r9cAj1h/eld0qlokQXFcizoNFI+W+yzNSXSUwctrnFeTmQJLGv52vtPgYXeD/iFcL9IEowqNBxyZRQNfUDNbc/tLOn0Vc/+roFVIrb38Km0/Q/QfMfPY2gFADKCZE/KHBj/NmjSpHxgoxRJvQ9cjWCfut3QLXAo/lsijf1BvhWocWg5LEwG2e5Jc6gQ/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(36756003)(26005)(956004)(16526019)(2906002)(83380400001)(6916009)(2616005)(186003)(44832011)(7696005)(6486002)(66946007)(8676002)(6666004)(5660300002)(52116002)(54906003)(66476007)(66556008)(316002)(4326008)(478600001)(8936002)(86362001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MrjvuPQPisywfKETQjITr2oZrxlzysORjEnOf52ZlxaAJnbz5JsyAz/FRO59Y5JowETZwWbLhbz41MCSGq0X9bz32FB0Y4tUnuo7Qcy7PfXkktNCuYOAvPjsvJCncjRcP5xLTeNGFZFEREGLEb+a1HEJVLUvA4KZDCmt2MZCJLs7UYYoIxX9PWPAjqwcw3S7Q7siANL8FlfDD5v892DLPQx8I38mIxpXBeKJYJeRSHE5xq3mQTWvzk5Kw2wWZJLeOK1XOUcVsVVgOCmVhT1UxZ7FmcWDMSZwl/qv/GoXZ61tyMQ4tFjdEZ1Sk9SLq1gDm7OXjEcYhhkTAoZPv94DikenGp8goqph0cID3YVyyxVHYekaF74z/TolyN0kgqrkBYoVSGDT21cr6am9L3glw7aRyjSvouv3pkItznyKxh/3vwhw3cP6b7d2ZEnp/qIJP8s8OpjdeRGPKreKczmNb0kzyGxFiZc+t63Fc6VLDYXEOrHIrti1/A+6zXnjBCt7qKrztKd7CssH8qLTpLeLy2+QiQG3mqHcPrSmizqtk969grkJfllY0dvK8gKes4l7EbLWAPNs08yds24PTmKi16ll7gCI0rNs0dYFVoe8sRIwqc/A0wq7zWQIcsKKcHjGpbb4OQj2wkCt4d2VbOEAuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df03f703-e506-4e85-8c05-08d853f809fe
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 13:06:46.1045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV4snG1erOWuX3NLlBMz5i7gPGy2IN4wA35MUw7eLUc6smv1BuGYF+i16R1DgKU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disabling perf events does not specify reset in ABI so stop doing it in
hardware.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c   | 23 ++++++++++++++---------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 61a26c15c8dd..373cdebe0e2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -44,9 +44,9 @@ struct amdgpu_df_funcs {
 	void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device *adev,
 					    bool enable);
 	int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
-					 int is_enable);
+					 int is_add);
 	int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
-					 int is_disable);
+					 int is_remove);
 	void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
 					 uint64_t *count);
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 2eab808fffeb..7b89fd2aa44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -455,7 +455,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
 					  uint32_t *lo_val,
-					  uint32_t *hi_val)
+					  uint32_t *hi_val,
+					  bool is_enable)
 {
 
 	uint32_t eventsel, instance, unitmask;
@@ -477,7 +478,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	instance_5432 = (instance >> 2) & 0xf;
 	instance_76 = (instance >> 6) & 0x3;
 
-	*lo_val = (unitmask << 8) | (instance_10 << 6) | eventsel | (1 << 22);
+	*lo_val = (unitmask << 8) | (instance_10 << 6) | eventsel;
+	*lo_val = is_enable ? *lo_val | (1 << 22) : *lo_val & ~(1 << 22);
 	*hi_val = (instance_76 << 29) | instance_5432;
 
 	DRM_DEBUG_DRIVER("config=%llx addr=%08x:%08x val=%08x:%08x",
@@ -572,14 +574,14 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 }
 
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
-			     int is_enable)
+			     int is_add)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int err = 0, ret = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		if (is_enable)
+		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
 		df_v3_6_reset_perfmon_cntr(adev, config);
@@ -589,7 +591,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
-					&hi_val);
+					&hi_val,
+					true);
 
 		if (ret)
 			return ret;
@@ -612,7 +615,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 }
 
 static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
-			    int is_disable)
+			    int is_remove)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
 	int ret = 0;
@@ -624,15 +627,17 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
-			&hi_val);
+			&hi_val,
+			false);
 
 		if (ret)
 			return ret;
 
-		df_v3_6_reset_perfmon_cntr(adev, config);
 
-		if (is_disable)
+		if (is_remove) {
+			df_v3_6_reset_perfmon_cntr(adev, config);
 			df_v3_6_pmc_release_cntr(adev, config);
+		}
 
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
