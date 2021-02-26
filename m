Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E9C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 06:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E8B64EE1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 06:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E8B64EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACEA6E8F8;
	Fri, 26 Feb 2021 06:42:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D87A6E8F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 06:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZpfLZoSCkHOXsuZGQGENCUb2+e1wntgDY49OMLKQeldRrPSz6NevwyaS4UOxhyV0XKJHFUMBM6E3G2qzNMVMsqvRDBxopcjmICslvOfb5bjeP+uIU0RVihDrZXKxZom3ONMuABUWO/KpcpkZJmvaeqj4hZoYHp7Uulmu0A2WI3kXKb1g6Qkfpotr1WrLEuBIM33W3pTcV8dvl5yF44TuBNzBQJ7m4ipVVVbj9d8xsefIxyU1VWCmYACIz+lJ2WfoC+1gtRFXBOms/R8k0puEA+1Iq5lVfDTN1nJCA6K21yJECx22+64JVWaJLpkHrl2U0onJeSKjyCVLwsN35B8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b6Gd3T7M5UgKIYRkhss15PqQWewnfC1ENz+Z6pmfWk=;
 b=j/P0zEufbiQyDGz2qvIACEFrLU1ghacQko5blHbwMIC2FRZMksJ6Tw3PhxhMNFBzPKXVzmyJQG1Ng+6bp2yreYCf/+wkYDOvIV7zq70yuavsyOJrrY5JZAV6ugOdRd2Gr1hnryquPl/eVmTalQJASUBAu1NYGcC0Kl//LwuBX0rbSbfP690HyTldUy18B1hhbWSuXRD12ZrW7aAqSae/P9Jr5ZdvMrPUsrpmKOpv4E1TqnP5YeWky+lIuxnGOt4KIa6oOX8qAQcITiqVrn3aFZhRtNx+1UYmxtsTGvNhGTVJ4fyn4JRC5Gfn60udpEpMiijuo5U3FHk+m80iXuqwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b6Gd3T7M5UgKIYRkhss15PqQWewnfC1ENz+Z6pmfWk=;
 b=KBU9YmfLF+dNhr0h/aGY6ZaAC/gKo83w8iB4EO33IFn+lmyqlDyxMArZPMT2CRigx9d5IdCj48pVUjqYgF5gwYybTH7P+EtQb2XK3kehwA22/0LQcwHdt5kPuVZQdqLaRDqU6D54pBbBuglJmeSlmgy4II1rqq3zffxpkqPK9N8=
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 06:42:40 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9f) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 06:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 06:42:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 26 Feb
 2021 00:42:38 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 26 Feb
 2021 00:42:38 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 26 Feb 2021 00:42:37 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: remove unnecessary reading for epprom header
Date: Fri, 26 Feb 2021 14:42:28 +0800
Message-ID: <20210226064228.30488-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0ccf6f0-cbce-45b5-6be3-08d8da21b635
X-MS-TrafficTypeDiagnostic: DM6PR12MB4420:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44204855B0696DD771616199ED9D9@DM6PR12MB4420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37LFPnKN/rmTjGOjmgnj3k4vlpxsJSbJx8Sj7u8c1gGADg0xjyPWx64SwcB6Jye9ZlgLlZBjFSnqQlPJ3yx8+58AvBppggiLprCC3gnuGYsqWefRVl5hr8rAXjhXjHP45dpep4D3ECK3GY572yBbv95Y42+9hmj39/yMs4jkq1TJhRHOZUxmcq4SmUDk/7BKtod7dIBwVdKj6BU2FMD7yUXvjIpimsc2slP2bYeDk7CBBw/PR+DvmUDE70lKb+ebyu0auKf84U1uJ+5ypw3Kg3EEIrQkWBhW5M7aEgMOck+EPY8i3girWQ3I2tIRAyD5ovMHeKKkOw9f4pW2gEJ/u4Wxav61R21NpWIWXagBKy9L9Gy8kiLLZ92i8KgFnnSnZDsauGIilzutW0K+MF46teibbyHQsuE5Jb+yZi0QABXNo2TEpwbCnkVCTPYAC5s/pYJ9JJc+L0XmvxaXzoqHonlXtcpKVARtxUrJ00HyGz47fOWIVxJIjU47tBAhJIt8QAM/rQ1PGYewm38amUcdPKa08SwzcRtAEDbRYDZwF2RCq2Sybq7nmQzcwBgrk22sRNCdhulVFcYgUjWozi3Qi4UHyKFrE5ANsh/zmiiXb/w5EpnQsrzzvgLcKl8ON8nBQUE4pDf9jieU1ZbzLNJfecZqoQ5yyItxtcn+7VYhNiyP+DhTcVS59K8XU1m1qwfk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(6636002)(8936002)(70206006)(4326008)(70586007)(2906002)(47076005)(478600001)(83380400001)(82310400003)(36860700001)(1076003)(356005)(316002)(82740400003)(110136005)(8676002)(2616005)(26005)(86362001)(186003)(426003)(81166007)(7696005)(6666004)(36756003)(5660300002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 06:42:39.7036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ccf6f0-cbce-45b5-6be3-08d8da21b635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the number of badpage records exceed the threshold, driver has
updated both epprom header and control->tbl_hdr.header before gpu reset,
therefore GPU recovery thread no need to read epprom header directly.

v2: merge amdgpu_ras_check_err_threshold into amdgpu_ras_eeprom_check_err_threshold

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..f2ff10403d93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4397,7 +4397,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				 * bad_page_threshold value to fix this once
 				 * probing driver again.
 				 */
-				if (!amdgpu_ras_check_err_threshold(tmp_adev)) {
+				if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev)) {
 					/* must succeed. */
 					amdgpu_ras_resume(tmp_adev);
 				} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 09546dec40ff..c669435ccc74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2189,19 +2189,3 @@ bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
 
 	return false;
 }
-
-bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	bool exc_err_limit = false;
-
-	if (con && (amdgpu_bad_page_threshold != 0))
-		amdgpu_ras_eeprom_check_err_threshold(&con->eeprom_control,
-						&exc_err_limit);
-
-	/*
-	 * We are only interested in variable exc_err_limit,
-	 * as it says if GPU is in bad state or not.
-	 */
-	return exc_err_limit;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index aed0716efa5a..42aab9adc263 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -491,8 +491,6 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev);
 unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		bool is_ce);
 
-bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev);
-
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 19d9aa76cfbf..7f527f8bbdb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -434,47 +434,21 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 	return curr_address;
 }
 
-int amdgpu_ras_eeprom_check_err_threshold(
-				struct amdgpu_ras_eeprom_control *control,
-				bool *exceed_err_limit)
+bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	unsigned char buff[EEPROM_ADDRESS_SIZE +
-			EEPROM_TABLE_HEADER_SIZE] = { 0 };
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct i2c_msg msg = {
-			.addr = control->i2c_address,
-			.flags = I2C_M_RD,
-			.len = EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
-			.buf = buff,
-	};
-	int ret;
-
-	*exceed_err_limit = false;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-
-	/* read EEPROM table header */
-	mutex_lock(&control->tbl_mutex);
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
-	if (ret < 1) {
-		dev_err(adev->dev, "Failed to read EEPROM table header.\n");
-		goto err;
-	}
-
-	__decode_table_header_from_buff(hdr, &buff[2]);
+		return false;
 
-	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+	if (con->eeprom_control.tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
 				"threshold value when reloading driver.\n");
-		*exceed_err_limit = true;
+		return true;
 	}
 
-err:
-	mutex_unlock(&control->tbl_mutex);
-	return 0;
+	return false;
 }
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index c7a5e5c7c61e..178721170974 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -80,9 +80,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
-int amdgpu_ras_eeprom_check_err_threshold(
-				struct amdgpu_ras_eeprom_control *control,
-				bool *exceed_err_limit);
+bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 					    struct eeprom_table_record *records,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
