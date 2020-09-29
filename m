Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7959C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599D12076B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oRpM2OEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599D12076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B1B6E1E8;
	Tue, 29 Sep 2020 15:09:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648196E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9BHWxZxU1dM7O19n8PtIc/UJCSOtgsVUsdxByeuKqpDViGXRkWRjZv42axPk0dLcopAcC3jGHER/C2sBPZjUbrOYWJm9V5juGLERSZvdoXJTUAVPWS5OC0zQmyr9YJsB8oNN3df9/L1kl6pkyA85uWk0X1XJHbIvSQWPT9JrHjKnSgy6XIdxM+Kp0wfbOCrIkGsgd/wNCogQeM5GaDcxDFkI1ove1xtDYVjNZXhyWXTwgfyLnHaO70uLPC/F8WSAJnUfW/4+wjct+aLh9xbZU6aI72Oxa5Wyx8cJ+pE7bIgWzfdiHyBpu3rhJXRAHagNrdsKsV2fNkfZv7k3/vBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZJ5Ul3VythANbscjRBZ05kEdgTlqEFBpuZxpyv3jpA=;
 b=M07C1A/oCGZoG+v7fajI1vjmZTeU+Um3JkPo1OJJq+b7UJ4EKlResoKnaF7XIGf/oI1RX5QsKkFM1o9sgw0GHBwok/VFoHG6n2gzVf0pL4Oy0aA2+AdxTiDPsTK4X+5a0+HPHSrcFdfYVVdz9KjavN/SUIL2kG2qeAKhQXpJ5dtdVOBBhlK+sa5Hp4UarKx5TaU4yszSt9D6QhqRkVy8Rf4npkwXGM1enav8g0I88s6A2AT/SdHQABk2XtdSqp4rr+6cn/2jEroNruiO3qByiQE0srY7l7LE5PjE9Q6KybCYF165uguEtkwVo2GrICAfxDPvNJXUtjGb9qiFwBLXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZJ5Ul3VythANbscjRBZ05kEdgTlqEFBpuZxpyv3jpA=;
 b=oRpM2OELNm+BF22B3AbsaiIVGjkOVffCUjhiu9yJusC0t2dI6A6I00c0Z13dUTt9tiVfhhTKhPnW7WFkHr0w1fIu723EIhePumhyKKRYjD5hd/M3gDGalMBbyLgBNQF4ViNdSBObd6OKsMZx2eJHmfUGN+Bim8onoiek0vNMquE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR12MB1804.namprd12.prod.outlook.com (2603:10b6:3:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Tue, 29 Sep
 2020 15:09:05 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:09:05 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check v2
Date: Tue, 29 Sep 2020 11:08:54 -0400
Message-Id: <20200929150854.26710-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 15:09:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 556f24cf-9be5-4a4a-831f-08d864899b2e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1804DC05ACD99E45AFD361C285320@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOdw2gZ/OjjRo4Y44pERFZgpNKtEPgWr6UkMBrJ5YM4Ee51jBo8tpCEB1cGRoD2FmPl7f+vwTxvNuQFjY7ETVGOjDPsAxd1G1nSqSfrxvnZZRzrexT6MN4nPqT4UWfS9AqLMeMO+08w2mI2RxItmD+ExyPlqcvV6XHEY00E/+UUACxl3awRjUy1lcEYeGRbQkLKQERqJM0DimFrT4Q5S1/jfNsWQnr+A4r+fEZOMJYN416cTV6ZFMunsm2EuSbXnceDLAEY+t+umipyjGDFmKeR4hpwKMLyeQKy3FF9JO0vZmBICgzt/w/ZjxBdSxN4wtBuDFndfQBbDtwRa4kXATbZ+CmqCVez3p8+ABO8Q1PaicjnVSI0+WiqiS2W/ApUa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(66946007)(83380400001)(44832011)(478600001)(26005)(7696005)(52116002)(86362001)(956004)(66556008)(66476007)(186003)(2616005)(1076003)(16526019)(5660300002)(316002)(8936002)(4326008)(6916009)(6666004)(6486002)(2906002)(8676002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FYkGLQP4Wx7fPiuOQdNk3UgT7RrmCc2r+yO/tQFNoH/BGaAigkWqsmmXCCIhNis4sZhygeGTTMc2ogIlubiOzQxUl0U22eF1DAeN97GLrM0aPB29OflOlNekjMhnMKqGau2fXXqbzbjcDNWhUqUWu1FJfjk0Nt13KOdLsp0tedsvDwUlOYZ2FMHcCWnmhdvXKgZbOp0+xTqfudW/kQYtCiheGzvY74WZ6KW6JwJ8OFazLvcKuEO2IJd1MdNpdM8k9jjor4XORBnThafguCfg05ipRyPu+M8sifo8WPseAnxc1lPO11u/fewasNbFkC2/cgr9i+X966BVcRFW1w8/dnHspNAOLYnaRP+9Zp+qDLSXgPkNXHyH0ibJL/v9lsnLgl7QSHzc50DCgbEnMp9tWceO6twGjETmQJA7nOj1fO9MLUv7wex2jqd71IF5FjPohBsuhiQC9Yqtc3SDc6WIj3OCbvf3ouE88cwD+TcCU5cQHLADuPSI4DgAzWDrNiNqoieMr2m6o5ak2WPY3QJiSW2JYsKd+pS2Wl8rQCtEVPfcP4sb+lTo+1DKsenw4jWqy0C0BqSukvvHuV4pdThCB7zq48TCKucDOBMgI1MYYovuYi2jfioRRzvQ2pEwe4VomvAYdasDOGXZAXtQj6vWRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556f24cf-9be5-4a4a-831f-08d864899b2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:09:05.2157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uB9OwRpwDLSba4sTXAsUAves/1aUEfyHncfrMnrxWefl3w0GggbgriWEM4yUD0yC3ufU+sNw+d/6bAIKh7flRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VG20 DIDs 66a0, 66a1 and 66a4 are used for various SKUs that may or may
not have the FRU EEPROM on it. Parse the VBIOS to check for server SKU
variants (D131 or D134) until a more general solution can be determined.

v2: Remove string-based logic, correct the VBIOS string comment

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index e811fecc540f..01208519f9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -34,18 +34,30 @@
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Gaming SKUs don't have the FRU EEPROM.
-	 * Use this hack to address hangs on modprobe on gaming SKUs
-	 * until a proper solution can be implemented by only supporting
-	 * the explicit chip IDs for VG20 Server cards
-	 *
-	 * TODO: Add list of supported Arcturus DIDs once confirmed
+	/* TODO: See if we can figure this out dynamically instead of
+	 * having to parse VBIOS versions.
 	 */
-	if ((adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
-		return true;
-	return false;
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
+
+	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
+	 * we can use just the "DXXX" portion. If there were more models, we
+	 * could convert the 3 characters to a hex integer and use a switch
+	 * for ease/speed/readability. For now, 2 string comparisons are
+	 * reasonable and not too expensive
+	 */
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		/* D161 and D163 are the VG20 server SKUs */
+		if (strnstr(atom_ctx->vbios_version, "D161",
+			    sizeof(atom_ctx->vbios_version)) ||
+		    strnstr(atom_ctx->vbios_version, "D163",
+			    sizeof(atom_ctx->vbios_version)))
+			return true;
+		else
+			return false;
+	default:
+		return false;
+	}
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
