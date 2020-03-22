Return-Path: <SRS0=k9Mm=5H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DCC43332
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 08:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49CF206F8
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 08:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="foI4byh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49CF206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4A36E060;
	Sun, 22 Mar 2020 08:33:15 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F936E060
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2020 08:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+LUaZkfS+AeIpsCF8aNk0VsOSOKI7FBAcBmEP5ml9riceGtgcuqt8QP/0EHGV2eatODWPLYfr0ILjWVzXJ7vRcyAr/6NMfCzPzpRGM3o0Mk/ttiKt17aZ0U5fh5qyrwEB47AuLsWzfI3IIJQ799XFDjKhb/uSdg8BkIsk1/xN4ju3Y8uHYqIpUHVlKtLkiFVpSpjkX4Xk/KBr2lJFqYOI4YfNvE+m3ZIJPGhydyIuXwW/QfUQGKZq+NZsl6vOLdN1btsZNJrcXARDWcVQpMdd+1WMm6h1+dIxMNE5JIELoMeLTmaxbLkxMK3puCx06d1rAMmQauQfhNEf8z+jEe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82EZUbPPkgqCGNO4lUipW42Xdngn98mk8utBGot1fuQ=;
 b=j0KNvIk0DoHtZUuBmI2d8tjlVNRctoY9fnzP5ok2QnjTi3GMnndCj6uK3+FlaQbWtEEbjMXLo1yf1H19Hq64g0S17RbHDGtB/gvVphQyBHtpMrRoPyDPaJHy4GbXnPQBnAZ5yXj7CAhfLEaGSvIdDTZn9ejbQqTpz4go9EM22+NaX5FFVj1ddBbGGkQ3jiaGgFzfWB4axF03k/2dCcpKg8kspN8FZP9qDE0w79AbaTg0CpGfo4u2pWwBSbtiBtCAMwEG9hmzDrjJoxpRPwdlcqrgTQGO7zO3Oh+j91kgboV7eqBgbVFQiBFIEW1Tf7qypwnU98p+ZBq1qef62ON0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82EZUbPPkgqCGNO4lUipW42Xdngn98mk8utBGot1fuQ=;
 b=foI4byh/TF/wmXawtWQ1ISl7BzxSMeAn3D3/d2M7j1Dj0u5qzIb98+IwNG1+p9sFmsSwaog5EdMYm3Jy6sgPrNJx0ufV2uySLnRxh17SUoJqQ34i4uwfRBwtJQvldbCnkrJGl2qBopd9neZKlRIYUb6VUK8G+D0rrTDXhHMa/EY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1653.namprd12.prod.outlook.com (2603:10b6:910:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Sun, 22 Mar
 2020 08:33:11 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901%11]) with mapi id 15.20.2835.021; Sun, 22 Mar
 2020 08:33:11 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: record correct sram correctable error count on
 arcturus
Date: Sun, 22 Mar 2020 16:32:49 +0800
Message-Id: <20200322083249.25573-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Sun, 22 Mar 2020 08:33:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fff77a5-d7ef-4602-1340-08d7ce3ba79b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:|CY4PR12MB1653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1653277128576535785755AEF1F30@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0350D7A55D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(478600001)(6636002)(6486002)(66946007)(44832011)(316002)(26005)(36756003)(86362001)(1076003)(66556008)(66476007)(4326008)(956004)(16526019)(7696005)(52116002)(186003)(6666004)(81156014)(8936002)(5660300002)(2616005)(2906002)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1653;
 H:CY4PR12MB1287.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfjgswFjS9FlOuZNqFmPvnqJKrTWB2pl1+5k2Whs++lRJgfKEmWNKqfN/oCSGs5ahtBpv/6G/Sgj26Q1i2pztKHU7jvwGPlJiSe97pihGkWo6uh4Ti8udFMpUjOaTv9UqzUf7PHZ/lHnRelQc1F7kGEJf5YClCUB0aYGhxoZ+qj//THt2me9ZyHNHAgwDGqYRKRX5IE7xmlhy13xHYbByLtBfwCl0lNJCYF1/UnzNdKuxYQNfw1osIGL3w3WKlf0NFsSb52cJq0HepGuiBT1srb3ND4l9iKvswyp3naEkjOB5J2fmUgyQagePaEsrWY89YbO8oH/HAfKUcdVV6R5wGg5HBZbN5RRpFnQRosAE6V58ugr8r2R/JnuH2ZDwPDhZfIbFC/EU1DP7tyiPT41zwzGGYJE9KbCxpw3aA/9Joshsegy+P6pZhjtFDq3QJQG
X-MS-Exchange-AntiSpam-MessageData: TyUvTHLoJeB276kMmJHstiZ87fjObqwrL+6fKQmm6PkmFz1Dw6bNvwNIFF2XPUnVvdkq6VZ1PGY50T+8zMoFqGbKnbiiX8IYFGCNVM+73nH7euvvI7PGQ0wXF3ssVciXuqhIB/ebwmbI4EY8MjYu3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff77a5-d7ef-4602-1340-08d7ce3ba79b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2020 08:33:10.9373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c74C4bQbj/fo/eTNAoc+1bcJZ2tTGbceKB/2oGQ+T2HultrqY4RW5m0uwWQAsdC6x1+TODGeygZDExYIf7OpRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
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
Cc: Candice.Li@amd.com, Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On arcturus, only sram correctable error is stable after correctable
error injection, so reduce check conditions to record hardware status.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 77122a7282e7..57e8f72cc96d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -138,10 +138,21 @@ static void umc_v6_1_query_correctable_error_count(struct amdgpu_device *adev,
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 6 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
-		*error_count += 1;
+	if (REG_GET_FIELD(mc_umc_status,
+		MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+		REG_GET_FIELD(mc_umc_status,
+		MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
+		/*
+		 * On arcturus, only sram correctable error is stable after
+		 * error injection, so bypass the check of ErrorCodeExt bit
+		 * field in MCUMC_STATUS register to record correct status.
+		 */
+		if (adev->asic_type == CHIP_ARCTURUS)
+			*error_count += 1;
+		else if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,
+				ErrorCodeExt) == 6)
+			*error_count += 1;
+	}
 }
 
 static void umc_v6_1_querry_uncorrectable_error_count(struct amdgpu_device *adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
