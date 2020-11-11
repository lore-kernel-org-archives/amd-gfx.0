Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D63C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 23:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F4D20870
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 23:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZHRh3/7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F4D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323166E0CE;
	Wed, 11 Nov 2020 23:05:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1156E0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 23:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcU02ej8iFa05xbHJMy03dAuUDSjfZNsXoWsZGCgzBIzZyMux2nA9QNyD0+UI8BPKqWwhY5F+aO4J7XrKPwFelfH1HknuuV3uqXFXmaF1tlUZgwWBDofriSseqUkNXzCcySy5tnZ39VuaDFK39M8q9AP163n9HiuxaOUVCLR+bqnhljDN7YqFgKzW9KhDp62+pnPr63zYn8GhE2Zjod+EpT+kw+ShhApMKGJhH6kGj/0i9BWnP4yKxGz9WN3dYxdebDiWGt8M0BaBfnAMWAnaW/BWjdokii4MgTMM2YghQUxlwktoErMUKYl/yOpx7ggkhuiQUwPeIt+v8VKX9IX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti6VUgFLgCO7TY0vZjx73OYSjYoM0SO393xqI+Esw9k=;
 b=biZsApJrTdQzasOn+V9jrwNv1d4czkkQwV7SzvBlOlFc12ju+7zigcWdaPIZZP/q2LSiC5lajYimPkZc1Zase26xpWnBKOWxdBmKwd2RiQe4HC2EAggh2sm6uMhByCmXkRJ8X8X8+S4aDEz79gpzKaIqDeNU/Qa3yNFVnvU+mfv8CwbcJrT2v7Z7t9CsJtBDBQhvaOnsI5a4Ane2FmL+IVWAFKQX9pMD5ZTNt25/iMo4ZIjS+rCLKTwxqBQyhbKs0dsVqzbsdy7sKn32tpwUb86etV6nONLF4PlJMEh1xJvXZJJR87l/liPY4si4OG669rZA+xBQ2xeoNfUqVJ22pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti6VUgFLgCO7TY0vZjx73OYSjYoM0SO393xqI+Esw9k=;
 b=ZHRh3/7RRb00b0e08EoaVSCztqbj6kBKs7rc+r1k/6RRjNZrd1WDGZnZ3OQhwcHo54/1VDzb7XZ4uhkKXDtkLrkr6NcXcCr50anmNcPTIbB9+DaaylJebVet+vRMkIw6jwmUWqW/CAvXWtkjCkQ3SMyOwqnMnKq3o6Ti1XlqINM=
Received: from BN4PR11CA0018.namprd11.prod.outlook.com (2603:10b6:403:1::28)
 by CY4PR12MB1221.namprd12.prod.outlook.com (2603:10b6:903:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Wed, 11 Nov
 2020 23:05:24 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::e7) by BN4PR11CA0018.outlook.office365.com
 (2603:10b6:403:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 23:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Wed, 11 Nov 2020 23:05:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 11 Nov
 2020 17:05:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 11 Nov
 2020 17:05:21 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 11 Nov 2020 17:05:21 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <john.clements@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable TA firmware loading for
 dimgrey_cavefish
Date: Wed, 11 Nov 2020 18:04:44 -0500
Message-ID: <20201111230444.180991-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111230444.180991-1-Bhawanpreet.Lakha@amd.com>
References: <20201111230444.180991-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd29ce73-4672-4622-7383-08d88696454f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1221:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12213A6DC6BB827497A432E0F9E80@CY4PR12MB1221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ax5guhZOFuHZPkvJhv/BGM3jSA1Rsgb3pBMNfQQl7i65xAY8LGzTKcDsz2Tj6oQpRTUdD5cDNPIOHpHPd1nuS8dK3ijhXAmmaa8U9gkxBKRb+D9r6zTCt+q6RbzA6JfH/cD1Yj00+3/DmvMwhZOmGPXqhykPTcfcq9/2zSAc3BLtR2te6T8/PE8czcBMi52PgF8GLBksCUY/2MnE7Yxdow+ktb8I1f5XiKVwwHYoBwvVgOikD88PkQH2Cz7dSqheU5Qa3Fq4rg14Os7tz4fJaIfggFggIFR22JI7PiNrAMATEr9gUwkzeAWgWzGEVV6orelejZ3h00MfE8viit4RFaI4qCK8wPeUj5lDs2+MTt+oCV8cpmHVDTLI9LI1B3L3VkuojnUiQ/iwb1sF59L/Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966005)(47076004)(82740400003)(82310400003)(2906002)(81166007)(6666004)(4326008)(26005)(186003)(86362001)(2616005)(70206006)(83380400001)(7696005)(426003)(8936002)(336012)(478600001)(6636002)(36756003)(356005)(316002)(5660300002)(8676002)(70586007)(110136005)(54906003)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 23:05:23.8546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29ce73-4672-4622-7383-08d88696454f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1221
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 03e88dbf92be..edd2d6bd1d86 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -62,7 +62,7 @@ MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_asd.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_toc.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sos.bin");
-MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_asd.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_ta.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -192,15 +192,11 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		break;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
-		err = psp_init_ta_microcode(&adev->psp, chip_name);
-		if (err)
-			return err;
-		break;
-	case CHIP_DIMGREY_CAVEFISH:
-		err = psp_init_sos_microcode(psp, chip_name);
+		err = psp_init_ta_microcode(psp, chip_name);
 		if (err)
 			return err;
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
