Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC1AC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C305F2463B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="178CbV6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C305F2463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596816E4AB;
	Wed, 28 Oct 2020 08:31:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4AE6E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAU70Je3/1Rmba5+XtXP6+f+G8A5GU2knGPZMkUhWC1gYytxqnBLjuu7VEkIhBjVayMPbwdVowgMVa1AAKdC1IPpHQXDB4Y3g2SqN3Ms7QnlCpjLIaw0SX8jyjg4zn03rL+BzMj9vufwh1SeHjM+qqPhI/ZEoUDi+Ajn/EESxXaWzP2Ne3ckJF6zpxc3MU4CYXkwqkQf1BMWmdcgdWBXguqgDZshrSe+zyclNLBTzgSObhHXOeQ2AT1A5+TaielCWDZ+MtJZknztlpRWrzeXocJwop9NOU5E7ssGcx4M/iAhw0Y2wo2lIXuk8ecXA4f4cXe7YZr+laGZYCO9cPVppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXauT3YfNNB0M668crc8ihc1TEx3yjLyofjHRhJFkVw=;
 b=BAZz19DrW2oFSuL57nHveBI+LyvtJ8DgFtRKuuaz7qAa2cVRkMObV8hy6KQ/b+5krxrsj/Ri+n87QRTwFux9yaVKnJ6wkSV8GkUgzLdUqTCxT2VMJMaDHfdvmrRx8q3L5IjKhGErUZ2hypv2OHlMPz8kcfHE0sQaQUW06touNYSf0WF42lCaQChZzl7JC9u0bsmL7Zzs5e5fA04fvyuqKr7s70LNofddMtJdMfbLMc8Qle5WNvtakYiCcO2mYQPP67auhQVaC8yVx2PqAnq2tedIWo/xHRaTIl8J3AfIJ6bSVWS3jWDQlcrMz2iRGQCVL5sM3vsbC5V7LZFNhf7rJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXauT3YfNNB0M668crc8ihc1TEx3yjLyofjHRhJFkVw=;
 b=178CbV6CrJlkc7bqHTNjNGJ7sCFzs2bv4x5dCj/d4lyAPE0m8p9172FqJ3vsVrQ6sYKkbILL1oRszI+CH9hOPWljaw0ZEbC3Fnl3CN2lKZzSJ3cPmnp57VDvs0cUtuVHZgie2NWGI7dhdyQGoIX330we6/UD6tm0y9WGKkRhm2k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 08:31:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:31:02 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amd/pm: perform SMC reset on suspend/hibernation
Date: Wed, 28 Oct 2020 16:30:30 +0800
Message-Id: <20201028083031.1195496-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201028083031.1195496-1-evan.quan@amd.com>
References: <20201028083031.1195496-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4 via Frontend Transport; Wed, 28 Oct 2020 08:31:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6623c89-ad4f-4a7e-c21c-08d87b1bce37
X-MS-TrafficTypeDiagnostic: DM6PR12MB4699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4699D00FFD5E50FAA48FA86DE4170@DM6PR12MB4699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/loUdUDeOwGaZdR+PDAU2oqU4xFfDek+NPbt734MgFMoW5uFvaw5epeAls6gLre01zObNz4hT2+9qhth7IdiO+A61zxLJwKfTCnqXDYbkrV8B4EHozY4AsqQRUQO810YlfA9PVU64Vw+Bl3lA//JPRC9vuTDsz0zF5V2rsddf/gQaIL2ubzWLgRXPnK9b1d2rAqeyDIPeeLoXmL+8LKlyC4N7YG9+YIu2+gQIQ5XOIAgTvzlxQ3NYf4e7pVuDDcxz0bcJq7fUbnXi7YOzUjmWUpx5I/KY88NXi6kps2Rv1davqPVUj03bZ5aTruErZlImrUebipwxgujBrrQK2UcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1076003)(86362001)(52116002)(7696005)(26005)(66946007)(316002)(36756003)(8936002)(6666004)(8676002)(6486002)(5660300002)(66556008)(6916009)(83380400001)(15650500001)(186003)(2906002)(478600001)(956004)(44832011)(66476007)(4326008)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Muu3MBAVMInml7ESXc54SpN7x0IixCBPB/oUU3dCw/54rU57UTORIV7bswmmYIA7v/OWvV/9B5CGnqzjq4Gte+qG80epBEltU9NYZMt7R4pXpmt8n4D/hNrsvr9EbTnMS/JSPezETqEwCtMg3puTsMgp4mC9e9M3c6XfnK/0YPsLrNwKP2UITAmxSHbm2aYcUgjf4YE777hkoVM4AT04UOiMUmmpXEaJjtrVFZOg673ibCG13pFiKQxyMMn82u99nYiLL88ZMFX2V1MY/ZwXsDHqMSqs3eHYXZThxAIwK5eYqMLBDP6fMT1ey/Fzj+jf9ydBdCzuDzo463x6FeGFI7DZEJmZea/O5dyCvDFkhuIHoyF+yF695uv7rgCbUiZKjysATiAsOmNB5Wk9t5YSezjOhgQ/nb8gMYkYLc2if+PyN1RPlHxxoafbWqBw3yOG6ej6c62Vhx0HjndMCtbJT0YIAtOv6uFP2hl53VNxBegsGXfX9nC70fSUml/SNfi43Iv/yPaliFRAM8ihDU0fFXUETHNTdo0kF0KuovtIL8/Xu14UGXGH6sI/9ugj7QZzxzAqVKC91PEvJZ1ca0Q7ji/Sz+qC4l3KjAjsdPCb3HNZxUECtWxGNY9d0XnyH2NE2KYYnU8Wi5JiUnuoZCLhPA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6623c89-ad4f-4a7e-c21c-08d87b1bce37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 08:31:02.8498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMHHIleDdJqk6CpWEMMW+sZZy1a0FDPaNvAquxBprO5BkhRO1BL3qEZB0S2Qf1S0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
Cc: Alexander.Deucher@amd.com, sandy.8925@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So that the succeeding resume can be performed based on
a clean state.

Change-Id: I82f16eb2d1a6e389f171784e6e56e41892e1725e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h            |  1 +
 drivers/gpu/drm/amd/pm/inc/smumgr.h           |  2 ++
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  4 ++++
 .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   | 24 +++++++++++++++++++
 .../gpu/drm/amd/pm/powerplay/smumgr/smumgr.c  |  8 +++++++
 5 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 0e4707a76f6d..7e29ec2902dc 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -229,6 +229,7 @@ struct pp_smumgr_func {
 	bool (*is_hw_avfs_present)(struct pp_hwmgr  *hwmgr);
 	int (*update_dpm_settings)(struct pp_hwmgr *hwmgr, void *profile_setting);
 	int (*smc_table_manager)(struct pp_hwmgr *hwmgr, uint8_t *table, uint16_t table_id, bool rw); /*rw: true for read, false for write */
+	int (*stop_smc)(struct pp_hwmgr *hwmgr);
 };
 
 struct pp_hwmgr_func {
diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h b/drivers/gpu/drm/amd/pm/inc/smumgr.h
index ad100b533d04..5f46f1a4f38e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smumgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/smumgr.h
@@ -113,4 +113,6 @@ extern int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void *profile_settin
 
 extern int smum_smc_table_manager(struct pp_hwmgr *hwmgr, uint8_t *table, uint16_t table_id, bool rw);
 
+extern int smum_stop_smc(struct pp_hwmgr *hwmgr);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 5937150e6b37..0879cd7df59f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1667,6 +1667,10 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE((tmp_result == 0),
 			"Failed to reset to default!", result = tmp_result);
 
+	tmp_result = smum_stop_smc(hwmgr);
+	PP_ASSERT_WITH_CODE((tmp_result == 0),
+			"Failed to stop smc!", result = tmp_result);
+
 	tmp_result = smu7_force_switch_to_arbf0(hwmgr);
 	PP_ASSERT_WITH_CODE((tmp_result == 0),
 			"Failed to force to switch arbf0!", result = tmp_result);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index e4d1f3d66ef4..09128122b493 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2939,6 +2939,29 @@ static int ci_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t type)
 	return 0;
 }
 
+static void ci_reset_smc(struct pp_hwmgr *hwmgr)
+{
+	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
+				  SMC_SYSCON_RESET_CNTL,
+				  rst_reg, 1);
+}
+
+
+static void ci_stop_smc_clock(struct pp_hwmgr *hwmgr)
+{
+	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
+				  SMC_SYSCON_CLOCK_CNTL_0,
+				  ck_disable, 1);
+}
+
+static int ci_stop_smc(struct pp_hwmgr *hwmgr)
+{
+	ci_reset_smc(hwmgr);
+	ci_stop_smc_clock(hwmgr);
+
+	return 0;
+}
+
 const struct pp_smumgr_func ci_smu_funcs = {
 	.name = "ci_smu",
 	.smu_init = ci_smu_init,
@@ -2964,4 +2987,5 @@ const struct pp_smumgr_func ci_smu_funcs = {
 	.is_dpm_running = ci_is_dpm_running,
 	.update_dpm_settings = ci_update_dpm_settings,
 	.update_smc_table = ci_update_smc_table,
+	.stop_smc = ci_stop_smc,
 };
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
index b6fb48066841..b6921db3c130 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
@@ -245,3 +245,11 @@ int smum_smc_table_manager(struct pp_hwmgr *hwmgr, uint8_t *table, uint16_t tabl
 
 	return -EINVAL;
 }
+
+int smum_stop_smc(struct pp_hwmgr *hwmgr)
+{
+	if (hwmgr->smumgr_funcs->stop_smc)
+		return hwmgr->smumgr_funcs->stop_smc(hwmgr);
+
+	return 0;
+}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
