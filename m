Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329AAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 01:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B67E64EE4
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 01:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B67E64EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CEE6E80B;
	Fri, 26 Feb 2021 01:26:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0C76E80B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 01:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNFBySuLE/VkM04FrsMWw9UkpFOkg/aF9DcC4eDEE9rDjtmBK7QuL+O2g1GtpJOi69955QwH49KClnMwe77RRUSlSCdU3phlto4CXvdEWxqj6SZjGNGJ4ysb+tIZoM/ojeDoyVoWKZP1tFbW9vP55EQ+Q48Z2VxijIa2QhGjzeQf/Aa+FwV1/cjX6zFZ9e3VpvuFFD62esR92q6L0cClpKU5ovFD7XKzU8zCtTPJlr4E/y9Z1F6yYJCbbN6/LVveb2EIs3f9zmccsglEFNi5zNvsH0Nv/dTQxLMEkbchApp+RbfwIH+W2WY7eEbDwQtsYTD+ruAeS0HU2XANvpKKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObVmgoWt8Zeq9ScwtcvZUHQeKxWrolUhZdLMz29R6kU=;
 b=ON8z39dzqcwSrkcws1VsY0D9KQDyVoba/V0Gq9/ubwr5ghIjecS5j1KTnn+gTH7z6vZfQEhK16Kq+awMPFP43MJ5ZWKoMWRHZq9Y75ZoRKxQPlBsSfXJoQ3ez1W9sluhv60kmJCZ+taLWUvvK4hCwT/2ZmrQdf+2Tms5OGypcf6mJ2CBRTJSVDwedE/wE9hO6o/iPqSH5dohwExDlcrgVdhujKGsPTaI+9DJpjKfnt5PoF+IKpSFkn810/sRKiyMRbg+1iNeoe5VOVYSx+amw7P0HQ1nADZh7Mtfhih+DLuylqNYCZDXfwauV0hfDmS6gRC9y56gbCRinzXh9g0C6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObVmgoWt8Zeq9ScwtcvZUHQeKxWrolUhZdLMz29R6kU=;
 b=kprvxn49Iy6m3qdw8NExNEWH9/vTe8h22D8hScDGDGfEOAGhF8DtFQYT5XWEzmyWwaVOl6sAtG6QvH3cuCqrEbG9MBOutDQRRaTeoReE4LVbHV81XfpUrKGDZVZXUmQb2E/YOjysXcCeaXB14FvjJDf+jdW2Aeo9VNS7oi/53Qg=
Received: from MWHPR21CA0025.namprd21.prod.outlook.com (2603:10b6:300:129::11)
 by CH2PR12MB3847.namprd12.prod.outlook.com (2603:10b6:610:2f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 01:26:11 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::6f) by MWHPR21CA0025.outlook.office365.com
 (2603:10b6:300:129::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4 via Frontend
 Transport; Fri, 26 Feb 2021 01:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 01:26:09 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 25 Feb
 2021 19:26:06 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 25 Feb 2021 19:26:05 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary reading for epprom header
Date: Fri, 26 Feb 2021 09:25:56 +0800
Message-ID: <20210226012556.10811-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b177634-69a1-45f9-e9e5-08d8d9f57f36
X-MS-TrafficTypeDiagnostic: CH2PR12MB3847:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3847BC0E8D9318AFEA92230EED9D9@CH2PR12MB3847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQ4Euo1KSdpPvcwDfLMMI72BCqE/GaTpBd5TX0oYTk7f6qIikTopgUNZq1BTi/bKJmFTE8CuIKoDINKcCidycdG+zSJxYtOMcSGv0VkivJZTuE3o7We+TC8Efb2LUoX1MCrEm+AtmlHw91IcMX0Bx+ZHhMRmyE6LSXL4tYVvjoWxZCbaB4cIKXsUSStzKqXxk8xXz8C/IjmvzT40Z7u2ZlRX/aBO8WKwOEwhXmOa3F4ZkH48xMSIo8sda+TAh2jxG+CHd4xeJAXitEnZ4UTMSJqLqEYfPAAoRE9tB07QaX3vZOoaOek2il/6hgihdjpduQHDZjYUw3ODm7AI2JyKEEYvBoI0kreiwfESX1GGzUSuHLDVWQSBNslpVvzkrkQzOqinCAYWd0O2rCLu/V2QJtlMFe0UsnE4gyT45xbTNtKuh1L5S5nSo0sQ7JDHy43/c3juMU+K2Kcvg4+DANoIxme6MkRrW/jwhtaFsu5hA6JXbQLy5cxxAcMDfc/hl/GSXeMvasGD7bTmoJSi5ICUdzv/V3g95YcBiht6//Rp29B3/r41OcM/vTwFuIIqANrvfIV0o3E557baLrIPThsfQ/s3VqFYutRD4TUOikLrd2m+qkabJ/LwtG+XGITNnMP0c+JtfO9zOZKcSS1d8XdvBS7cwinyPUS2OfxGTPaLPv0zuAnT4ZGHRjzol2ikaTUg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(336012)(81166007)(82310400003)(82740400003)(86362001)(83380400001)(316002)(1076003)(426003)(2906002)(356005)(26005)(2616005)(186003)(6666004)(5660300002)(4326008)(6636002)(478600001)(47076005)(8676002)(70586007)(36860700001)(8936002)(36756003)(7696005)(70206006)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 01:26:09.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b177634-69a1-45f9-e9e5-08d8d9f57f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3847
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

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 19d9aa76cfbf..4310ad63890c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -439,41 +439,19 @@ int amdgpu_ras_eeprom_check_err_threshold(
 				bool *exceed_err_limit)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
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
 
 	*exceed_err_limit = false;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	/* read EEPROM table header */
-	mutex_lock(&control->tbl_mutex);
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
-	if (ret < 1) {
-		dev_err(adev->dev, "Failed to read EEPROM table header.\n");
-		goto err;
-	}
-
-	__decode_table_header_from_buff(hdr, &buff[2]);
-
-	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+	if (control->tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
 				"threshold value when reloading driver.\n");
 		*exceed_err_limit = true;
 	}
 
-err:
-	mutex_unlock(&control->tbl_mutex);
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
