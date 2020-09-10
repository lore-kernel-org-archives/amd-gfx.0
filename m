Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56AC2BB84
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B735821D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RElQf5TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B735821D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584F6892E2;
	Thu, 10 Sep 2020 08:32:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4185892E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 08:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9lS2dlImr3WfwZ+XOCxD5QwMnDTkul6qGWNEQK524lWYHUjEkMX8w+VCFAN7FudM9mqJ/XGOZQf3fr6GiIL3I6rulN0CNEKQk6VCj3aLKmzmOCbDsUaqYJq+jMhsQu7i5nkpr5tGkOb05jFJsemFs/Xymlg3cO6QUFtt89eesy1ZS7SOwWC98QuNZTPMu+BIw56K+xwi0jecwkNJU5IvYzl4lqQR0De945JiPBHEkQzS2ZLEGJbKwWwerRZSydmQ9Z9rohLGgxtSGXJEz37KMPfyzQCLUl19NXvG/TSwarJ2EGuFfar2IOuvcRUA8UsDsUJEAuOCAIMP0zopQmEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCGFE0OQ8KOND4f/kZWU+KZo/6qQvxqoo7JrKku+Qd8=;
 b=XxZAZE1yvQ8feFN4p09dNoJ2tC87PLOQeLNAtQ0DBiz0//FxRRtimibU2KLUtKBBsyFYfsxLaTuHZpMgWRDkjJY7WmWaEWLhKminYU+KWV+EV6r/Q/Gljinvgi5Orthlo8rdJoNMbTvgH4WRe05QlHI48VzYjk/nXjzuYgz3N44dKEQ7afhMqrJj4f4t4rrff2dT3HCq1SveknwYCOgjYTDiJG6T0QYmtJh86zWpuhvhQL/j3sQWtSY0VisJPIld5DX0TgW7UtHSR6KyrGcOaCdKTqsWI9TfV9JkntADftn9gYTBQbMiFL7nnZnsUVA05qBwnWuzRIgRMUJ36O96mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCGFE0OQ8KOND4f/kZWU+KZo/6qQvxqoo7JrKku+Qd8=;
 b=RElQf5THvB+c23ydBzhOu1Qbs+RazC11y0DMJMHeLGOGuvaVPbVEgJbCjG/xZ7i3U/hL4QPkYntRwg9qsH1T0hGfh7t9GnnNmKVGHtjiBWy22GZZ77Ft1fX6oghmcXkR9+ySymzc2f1sshRHO+rd7dZ6HD2JD50TnR9WuPQGP90=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 08:32:13 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7%3]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 08:32:13 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Index: AQHWh0w39tFZRR1n6E6XYv8N8SXSt6lhit4g
Date: Thu, 10 Sep 2020 08:32:13 +0000
Message-ID: <CH2PR12MB43263B82B92A63D6844230E8EA270@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200910082705.2207442-1-likun.gao@amd.com>
In-Reply-To: <20200910082705.2207442-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7ea6cd22-1b2c-4eaf-aab2-76fc397d1ef4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-10T08:31:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13625e8c-1dcf-4418-d5c7-08d8556404d1
x-ms-traffictypediagnostic: CH2PR12MB4280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4280B0072CA6C0856B502443EA270@CH2PR12MB4280.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inBWGbTDGZiceJRgwzfv22aFa4EM5+sN9DnhAEvn4BL9TG/1pQydzldMAWh8NIwkG1/38bkJ3O/7HULcxbKf0T2I2rrr1CUdegmQl0ZcH/fjM4qYW0IQBRxSFzxqSiAUs2zQrdeztv7JHqGwhno5GRDMNRG4ZYI9rrzv2LqhuvjwTB3PJqtS/iXQL9cRs7UC0MBiQBduuoWsEalGTp18jYFQAw3uLYY1kWEsSbZcwxOFevhAn+bdSp/Ol4K8t5RJsFlpejf4kwHzZV6scK38gOepGhJ6j/dTSDRato5Vlg7vsUlMH1GjphZaVo11i6pl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(86362001)(7696005)(316002)(52536014)(5660300002)(55016002)(26005)(478600001)(33656002)(8676002)(53546011)(9686003)(83380400001)(6506007)(186003)(2906002)(110136005)(8936002)(66446008)(64756008)(66574015)(66946007)(66476007)(66556008)(15650500001)(4326008)(54906003)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Jfm2Oen6e1Y27+0wY+LIRfOKQFduTNMwgnak2pJR8/WkzW5o2RE2XQdpaoc5JX+nxJOjiWe2NMVI/PvpehOXwD33LwOVeR58810F2nEY/wYzes6JjIT2otyKntxphJ08B0WSvNWiZ35v4wFLk09AlZOyiNJJVkBmbn3ldLyGQAZWk672R2U421Q8ECcJwY0+kXnuywoS0WphkP//d++uOgo62NAc+yuf4ZVEYWwQfgJp0Keju4attPkQeU5yP0Kq8KVFnx08O/GOQgpjGoDrOSGO6lLMUcogt08OfkCEeKCkjstETDMnCm+Dpbt1AS6GvsaPd9tNQxosrNt+rQJsPVQ3KezSqekM9VIDazbEfmmdB5APPH0VEr38GF9T5GAlfXinT9Ymwm4v5iCYlseEVwstwS0TVvbvDEyRynHLy1XmSK+M5YuY0S2264I00wSgAYxi9A02jzMeJqWOkgoQJqXotad6VPbgU7OLvyqOUGimVPhCMwJpp5zKXBxWAYX8NI3nJdoE8N3SE5DuVZzD5gtbO4aHJ3QyZSSIKD1K7Fui+y9j4znO+l/J3EU095/ApIRWUjsQf5LC4KnIBL/BR0JYEWx07/ylaBXTtU+bWZJbIq4TZOUCXUeuVN7WTyfmBPovA1LBU8VlhkGPjOaTSw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13625e8c-1dcf-4418-d5c7-08d8556404d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 08:32:13.8119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+enW0aPPQPfEiNuWWoSF6Z1pJVIPBIXsSfxwtpfb6/374c33Cvf5esoiIO7Qbq0Wm91yNDa/hbattIedx+16A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Thursday, September 10, 2020 4:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update drive if file for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I53e5210acb760901622cd50aaf81193e9699feba
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 20 ++++++++++++++-----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 -----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 5ef9c92f57c4..11a6cf96fe0c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,9 +27,9 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x35
+#define SMU11_DRIVER_IF_VERSION 0x37

-#define PPTABLE_Sienna_Cichlid_SMU_VERSION 5
+#define PPTABLE_Sienna_Cichlid_SMU_VERSION 6

 #define NUM_GFXCLK_DPM_LEVELS  16
 #define NUM_SMNCLK_DPM_LEVELS  2
@@ -169,7 +169,7 @@ typedef enum {
 #define DPM_OVERRIDE_DISABLE_DFLL_PLL_SHUTDOWN       0x00000200
 #define DPM_OVERRIDE_DISABLE_MEMORY_TEMPERATURE_READ 0x00000400
 #define DPM_OVERRIDE_DISABLE_VOLT_LINK_VCN_DCEFCLK   0x00000800
-#define DPM_OVERRIDE_ENABLE_FAST_FCLK_TIMER          0x00001000
+#define DPM_OVERRIDE_DISABLE_FAST_FCLK_TIMER         0x00001000
 #define DPM_OVERRIDE_DISABLE_VCN_PG                  0x00002000
 #define DPM_OVERRIDE_DISABLE_FMAX_VMAX               0x00004000

@@ -793,8 +793,18 @@ typedef struct {

   // SECTION: Sku Reserved
   uint8_t          CustomerVariant;
-  uint8_t          Spare[3];
-  uint32_t         SkuReserved[14];
+
+  //VC BTC parameters are only applicable to VDD_GFX domain
+  uint8_t          VcBtcEnabled;
+  uint16_t         VcBtcVminT0;                 // T0_VMIN
+  uint16_t         VcBtcFixedVminAgingOffset;   // FIXED_VMIN_AGING_OFFSET
+  uint16_t         VcBtcVmin2PsmDegrationGb;    // VMIN_TO_PSM_DEGRADATION_GB
+  uint32_t         VcBtcPsmA;                   // A_PSM
+  uint32_t         VcBtcPsmB;                   // B_PSM
+  uint32_t         VcBtcVminA;                  // A_VMIN
+  uint32_t         VcBtcVminB;                  // B_VMIN
+
+  uint32_t         SkuReserved[9];


   // MAJOR SECTION: BOARD PARAMETERS
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 2a3f1ee4a50b..9dfc1c87b6dd 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x37
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4

 /* MP Apertures */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b67931fd64b4..194abaca6948 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2295,11 +2295,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 dev_info(smu->adev->dev, "SkuReserved[6] = 0x%x\n", pptable->SkuReserved[6]);
 dev_info(smu->adev->dev, "SkuReserved[7] = 0x%x\n", pptable->SkuReserved[7]);
 dev_info(smu->adev->dev, "SkuReserved[8] = 0x%x\n", pptable->SkuReserved[8]);
-dev_info(smu->adev->dev, "SkuReserved[9] = 0x%x\n", pptable->SkuReserved[9]);
-dev_info(smu->adev->dev, "SkuReserved[10] = 0x%x\n", pptable->SkuReserved[10]);
-dev_info(smu->adev->dev, "SkuReserved[11] = 0x%x\n", pptable->SkuReserved[11]);
-dev_info(smu->adev->dev, "SkuReserved[12] = 0x%x\n", pptable->SkuReserved[12]);
-dev_info(smu->adev->dev, "SkuReserved[13] = 0x%x\n", pptable->SkuReserved[13]);

 dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
 dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
