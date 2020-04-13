Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508FC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D0D20678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QGjEGoCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0D20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852C896E4;
	Mon, 13 Apr 2020 08:24:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4066896E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 08:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxVRlU6tEEVVqGA3ypu50ScXxE8C4YnCPITq6EicQQ1dvIArs7E5W0TKAeETz+Ew762NaS8ITtiOwebflGK+0s2HzuOXqZn9jzoyQV3vKKevGVIalCUpVP56wH3PNygoiL038ZdMgOLotcetY0cAYzs6GHDF4l5zIoCy+ILIN2AcT4NpFb0VBwFS6FNLs0ySJ7Jtq1t7R2w6yxQv7ysv/c1WklijhoeSq6psxWSQalrn7jX5liU7mrEOPqTvfNj7qfuRH0ZEH+lytgehcI1e/MyZtvFaIcnWAlTcgejn95uF+GzgBxbAZw/JH1xiykZTwem+q+8lgAuCFam1MOzKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aTb3mNE210wNUWkazwIU18DBqmXiJmd1QqkdlX1Z+s=;
 b=Mt9PsqTd+48Tac9SFrwA9zvfoeYhrMnkNTzPn098docTfZtR20i8oF9GhwO2jRyQGTnHS8V+fYsBZOIJw/52ol5CfI8zSuvk44IODMa8MHVYDBzmIevLev0mdXSSMGUO7aTVv9amh7OlM/WpeCdMMMOiWtYnsbykzDyUB+pHPLdTnGy0WYkyVrw6wDA/GW301RmBzg4pZ6KR0GXsPnZH1dGWC//B6zAX/DuzjsEKWszzrwOPFu0oPHj5TFaPGSSc0Q4kJJgMEa1yWKpPteomVrfg41SRT7cQyEQLiQeZuC7YHMsafasnhIXC7JhOFjZf6dNh+OU7Q3soldjSGT2JEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aTb3mNE210wNUWkazwIU18DBqmXiJmd1QqkdlX1Z+s=;
 b=QGjEGoCoxeyWk7fwwgg4wqjB2yz8YQQ6xwF5/6W4gXdZhvPE+7V+jxsvga7sNLYf/ZQWFf+HS0pi7Nzre+6QwAO99/4sizRez3diHnldf+uF3t/4QA4kvtHYp7CJ/UrHKUz7qhWhuek0bIcyiTb/uj0Y4IASxwrW8ApzPuVGuFA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Mon, 13 Apr 2020 08:24:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 08:24:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: correct i2c eeprom init/fini sequence
Date: Mon, 13 Apr 2020 16:24:21 +0800
Message-Id: <20200413082422.31786-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Mon, 13 Apr 2020 08:24:39 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b2322f3-9094-442f-a14f-08d7df841c40
X-MS-TrafficTypeDiagnostic: DM6PR12MB3723:|DM6PR12MB3723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB372377B6F9F3CE39E58242A3E4DD0@DM6PR12MB3723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(36756003)(2906002)(66946007)(52116002)(316002)(26005)(66556008)(66476007)(7696005)(478600001)(16526019)(44832011)(2616005)(956004)(8936002)(6486002)(4326008)(8676002)(1076003)(81156014)(86362001)(6916009)(5660300002)(186003)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbPcFjaAXuHMC3l8zQNiJY/bInHM3EJwp9Nf3ATtr+u2b3GTjRe6BNMzcLxevnSxBLUASfm1akUaLsGto2H824i3r39t1r5HFUjMVdd2NGDqT7j+ZxMnbY2vNP2m+pHuAMdMwSfglq+ZuNs89OXGgkF5RQg5dFMD3adJj+yXIw6MS0QgJ6CiNWML359RK1EbvkSdFyLXFbyG5c9NU2bsvwtDdzryU9clHdtyIhGLU66GopYW4CSaJ/QpWihFMzCYmO7UOfiFhuORjfaGb1qFdmoiYFab1W+u6WrLFXbQkLh7mWBAYaJyvO+hQ8Ic63QOOFtYuWLlEbl07TGsX9/aY7hI4ObIFiCkB6cGIjI7Ab5xUeI3XeQHhgskEwV6wHIoXh2/7CyvcSnNBoZplnYB3EOajU4fNfcglXJFRZNrgNGVlp8eHZcYpqPiIvjRqTLV
X-MS-Exchange-AntiSpam-MessageData: VSrop0P5BMDfv9S40W4p+B20FfFM89udW6+lEzt4UxLamJ5fQ1uN0zkb/LCF4yZp9T1i6VG+ZMl3MJQy47LcUgwQHfBL4jgDKTpw6RIyd42MVQm4CtuwNDC4Q6WH1Td/2YNFOgykXJRRxY4Rb0iiEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2322f3-9094-442f-a14f-08d7df841c40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 08:24:40.3896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MJyxu/tJDuxP7VzNfCS8/ASd+O8n8wCsgAIjABisDrbDNR4EFyWffYYhvpsD7wM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As data transfer may starts immediately after i2c eeprom init
completed. Thus i2c eeprom should be initialized after SMU
ready. And i2c data transfer should be prohibited when SMU
down. That is the i2c eeprom fini sequence needs to be
updated also.

Change-Id: I8444c05b51e67347841641fe5768d3126d089792
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 22 ++++++++++---------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  5 -----
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  5 +++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index e8b27fab6aa1..b69e8d6c0a96 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -932,13 +932,6 @@ static int smu_sw_init(void *handle)
 		return ret;
 	}
 
-	if (adev->smu.ppt_funcs->i2c_eeprom_init) {
-		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -948,9 +941,6 @@ static int smu_sw_fini(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret;
 
-	if (adev->smu.ppt_funcs->i2c_eeprom_fini)
-		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
 	kfree(smu->irq_source);
 	smu->irq_source = NULL;
 
@@ -1366,6 +1356,10 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		goto failed;
+
 	if (!smu->pm_enabled)
 		adev->pm.dpm_enabled = false;
 	else
@@ -1403,6 +1397,8 @@ static int smu_hw_fini(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
 	if (!amdgpu_sriov_vf(adev)){
 		ret = smu_stop_thermal_control(smu);
 		if (ret) {
@@ -1542,6 +1538,8 @@ static int smu_suspend(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
+	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
 	if(!amdgpu_sriov_vf(adev)) {
 		ret = smu_disable_dpm(smu);
 		if (ret)
@@ -1587,6 +1585,10 @@ static int smu_resume(void *handle)
 	if (ret)
 		goto failed;
 
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		goto failed;
+
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, true);
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ae2c318dd6fa..30643b9b5b3b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -580,11 +580,6 @@ int smu_check_fw_status(struct smu_context *smu);
 
 int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 
-#define smu_i2c_eeprom_init(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : -EINVAL)
-#define smu_i2c_eeprom_fini(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : -EINVAL)
-
 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);
 
 int smu_get_power_limit(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 40c35bcc5a0a..c97444841abc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -214,4 +214,9 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_set_power_source(smu, power_src) \
 	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
 
+#define smu_i2c_eeprom_init(smu, control) \
+		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)
+#define smu_i2c_eeprom_fini(smu, control) \
+		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
+
 #endif
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
