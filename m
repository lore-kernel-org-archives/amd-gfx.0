Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152F0C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95D810E15E;
	Wed, 15 Jul 2026 09:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuGvmNt2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433A010E15E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJqgzRp0BrYb7d+oP41auQv83Do4xI0iYS6li2lsfdso2E6vVogU6FgjHIVDHIM4nVroHWfSv+WgiOEagwlKkmsCmvpZe/gsRvLaJRFVaTSd1ZXaOhBJlUAZuDlwpXsMpPDBtwn4mC/1ZSm4PuHpcHumIZFRsiWEGqxESeaY1P0vBabHfLvlKDlEYKO0uJY2qdWghjsU7fdAJwoeVAi+f8GL/MubizOKxEzMKBV1vs+esnS4EfPnDtE/hiVGYNXUmSY+hr8M0n+JkfzAlrGo2gZBdUwWbR2mzCSOzAzeKUuwF3R0EllP5Gt0vtUc4GeYAJ+YL9DbPBQd2hgdRz9QVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiIFPFKyeM/wb1ZSPUBUqeOrERIuXylNI/feYeW4URE=;
 b=SKNcpFPiY4oHz2EzePTPkcdPT48QDG8E7jcPRTGNZcoLSHhR56ByCGWxx6Qqq3KwUCmzqtrFei5bZ6V/8GobqycOC9yKtaw0xIxjXLh4Drp77g1mn2H6mh0yKN92giiaMtaLQ1lkoXUIyFn2yq5ZWALJ8eDETUvtqnRV8URUqVHeAqD77HlzM3coAOClNRADtKQ3UGBYOPCyx7oCPS5VhE0Go4UVmGkyclPv8zVGvvs2ygJLbiSD2inSYd91xnNYMlrM/uEubnPSF3RfLVykjcqmNaVWSsIdvTcTe16S6nH1wBI1Rp6PdRSOzlxq3O1wWM03e25aWkjY3bPWGwYTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiIFPFKyeM/wb1ZSPUBUqeOrERIuXylNI/feYeW4URE=;
 b=cuGvmNt2/i2zmPG3pdsfpHE6sLDmB/MnYSE0RZTONqMVlL47nqHom69JjTCPB4SdJftG0ij9NhPQhMYcAUokaEdyq0wLSvRy1cuF8spNy9K8jh8XAQtGWjp30g24CqMrZHaaMsWYbESq8F3lejD552a+SSDv/gR82cp0N6BH7Oc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:28:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 09:28:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Thread-Topic: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Thread-Index: AQHdFC5DLBD0ZAAlOESFR4HXL2XtnLZuTosQ
Date: Wed, 15 Jul 2026 09:28:54 +0000
Message-ID: <BN9PR12MB525757867B3C2EB0FED0CE73FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-4-tao.zhou1@amd.com>
In-Reply-To: <20260715074734.2668631-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T09:22:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8705:EE_
x-ms-office365-filtering-correlation-id: 95ba066a-5879-474b-01f1-08dee2537d6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: m7xp3ctKZ9y3gZjeqQCV3MBlOVXynrATNZUgvFmmqn0/vWZy4aHCyoepMRfHw78yqoEBpcVlbTS0KIJHZ4f5FRBa7qdWkkTRq/J7RgOhHf01AZXbGtjMXhtLqrrG7GBHTCSP6yZ46XDQeRRt/bvHh/TG55oMuyWMTLl5MkPI9Pe9CbLuc3wNNZNySblnws3LpvdXyj3G486GlFnYsOhF7uSX8efDjHAO8+R88kYFJJ6p7OhxC/A9cLXLT6VkzjIkSbE7NzOKika+XkoR62du7tEunkunxSK3diCjOx5GQpVZEsXZozMqvsCsCDQyFJbySUihWBOGLUS49Zc4hXEWLPnduFyOZR28zRl4cmHuqS9Ly9Zhq7a2nqLtQKLCgMdxhvG6Ez/BabaMrdltDrS7RFQ2eFFv6qg5Jc3sO1cfonPdQuzK8jE+0iO9MLnpCoCUOVKE9SYyyJHbuEElb3/kBdL+b7k/983xxe2ppjeJfuCDcxryQ9suwNK32qeZn/qLQuGrxnYWDGmKA3+WQaLBleChd2t2I+2VJOWtiW+dIoHx0NH+ktEK8Kcr1ns/QE1kW/YwZTdhAHuYEHCXCrGRZDPHj2BjASei0mM0wjP6QfWvc2Jc331LLZhYRojdvHZPxBHsW4+xMMwdEZRDRkw5GcZWjnCo+sZq5S2CGq5BsCSGS/ZntIMQ/ZjFUPjz5qFNAy6I5adn7h7D3AvlKtmRVXZiY5weQ8SEXm8Q+wQf0Dk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiTkhjcfKF1KzmC/jTuu2BUm5ymOLK1QcR8U/kRJAkd915ZFK2SbGtY3wxOV?=
 =?us-ascii?Q?mnpDfmvhr5YOx4EZ65bE7GWbkek0IIkF8pUjYnJSaskfQh8zP+4rV2WBGXxI?=
 =?us-ascii?Q?OaMoD6jEoFRFCm1MIrEcVhhZdkEGSs4LlTKz25YwbtYc+x0c+KEtT+JOpvXN?=
 =?us-ascii?Q?NmxQXJD/hWNwUR/EnZ7P4EBBgT4XEA4PzLvRRGaxdNTETw2LzfO4WSTyseV4?=
 =?us-ascii?Q?e5n3uPJU0yECWWguejfg/xpoknVD/2IKfDs+awg4yA26KcKC9pipBohLZ+EM?=
 =?us-ascii?Q?K0cukQ+Or8qSnsMmKB4fGJiY+GZ+1+oPyc3ADZHLfzfzTqbmPKfjRbf6m2g3?=
 =?us-ascii?Q?3lXZA4CZh15hOaenvmoWRPeDuiy3AveDTxrLVF6QQa8ro5q5U4mbQpOA6Xvg?=
 =?us-ascii?Q?BOK08R4aoOFuGz91rme1KWMzdGwDltBg9p1xv5RX3wtrUrm7Xca8DxSW65hU?=
 =?us-ascii?Q?1XPKfHvDV7lMVPkrs4z+bOEro3545DhAntih0XjjHC/ZADr+0CIefTq4EGIT?=
 =?us-ascii?Q?Tzimg/rNG/eph3ZdcW8+10GFuccYPNyg96OiNv2MTno3wt6CXKeE/8mlMssZ?=
 =?us-ascii?Q?4HoA8lz84PHWPUAzUBDsKLh/7I8p9Nmb076p/2nas/v4dp4Q+4GWGQuEViPn?=
 =?us-ascii?Q?BtQ5A2n7z0yaPZ0fdNfNtTf5p2JuKj0y3yaEl9C9ir0VHxakTFsQXiTeWGyo?=
 =?us-ascii?Q?yAglmRbIwzEo2ogwCBabprI7Uxji8mMdTovR78856h9dlCU8KMS/L74D23A4?=
 =?us-ascii?Q?7jMLdujqjNX3keFwP/lgRO4oDiUcY7zjsMHH9WXDdFWdAD/aBXXcKFjUjDnf?=
 =?us-ascii?Q?Wy9YnEnlR11TnetrKk4rMPUHBkMkEv0Oii6dN7FEVgGpyTAk+C5lcPHn7BxY?=
 =?us-ascii?Q?FyyuNV3oeDoVlkDAdhxUzcy2OKzdp18rSgz7Q4S68NF+5qqvWnGgQMVGu5O6?=
 =?us-ascii?Q?U97+EVudjY2P0SlHVJ2+UX74VrewVnZJbbS7ja61IfNYVoU1K5FUagBY8ReH?=
 =?us-ascii?Q?lOZQcTKnzqo3b8WEmvOtDrCrm5evCSVzcbcD0dJu4a4iYeYL2W96NQOAUWcC?=
 =?us-ascii?Q?3lQQA9PfaMMUdyQ62u4w2r0EqpaspaAosg07OCg1OSOQ/u9783TbtLMF5eNo?=
 =?us-ascii?Q?vLGTHJdTo80N+cjTPirkAONmQ7bMjZ79oEgYZb+nD37M0TY+xGqwwYOgmpHz?=
 =?us-ascii?Q?bLVMm+I2S5cArP7Ahww8f0GNtMeKon+OhYNdrMEsq6/ykN8HN8VXd1nQ+YTd?=
 =?us-ascii?Q?muaMWQJreWezP4U1sRJS43W9J+aqvHavq0dcO1qtjh5XJkeCbRS2zmK7mejA?=
 =?us-ascii?Q?AASjcqADIZxEecaMqXeHcNwbcPpHHF9oj1GeKNrTK9B0JqPlR10UPb/h0mn1?=
 =?us-ascii?Q?L0R8XGLfL8EWU2G9p5ZIVcbM0xZzbRXfAyyb4E31buPWp9ANfXHFLuQpOBy2?=
 =?us-ascii?Q?jVqSoWuhP1FEyc2LS/j2z0b0woBmMI1GxLphrAhjJaF4P19dOVGU0zDd4uHx?=
 =?us-ascii?Q?TZtI+p3yHZlLHVbou7aMinSr/KND8X1+Tan7IFRo2jgt4uvg52iF8AsCpUsV?=
 =?us-ascii?Q?Tsd0aqN2o9g75PY98v622XCJxLrVyci3dxl4cnx6y1RJyUROyaV0I5+0OaVm?=
 =?us-ascii?Q?Xdkyl95cI5b0eC1F49ue67qSQPeZVsbsZ3GmtOtw/XIlvW8euTmXaxVnRIkq?=
 =?us-ascii?Q?HlVjvPgboqAONmpM2STcAuo8t2gJHOBcRDtlOlXCmyWNzG0D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ba066a-5879-474b-01f1-08dee2537d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 09:28:54.6996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXnF8LkmZ6VDs6gtUgZGJWIdK4ZvCukrXVgK6G16EJwchQP0rRcOdfPzQCPxCcOAHvdlkyZDuNFrfxbyDMOWUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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

AMD General

Can we just use ACA_REG__MISC0__ERRCNT instead? Was trying to understand th=
e use of real_de_count

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, July 15, 2026 3:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/5] drm/amd/ras: add real ras deferred error count

It only depends on the status of ras bank register, and can be used in comm=
on aca layer.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca.h      |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h b/drivers/gpu/drm/am=
d/ras/rascore/ras_aca.h
index f61b02a5f0fc..0bde803f7472 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
@@ -83,6 +83,8 @@ struct aca_bank_ecc {
        u32 ce_count;
        u32 ue_count;
        u32 de_count;
+       /* only depends on bank reg status */
+       u32 real_de_count;
 };

 struct aca_ecc_count {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/d=
rm/amd/ras/rascore/ras_aca_v1_0.c
index 840610538c1f..41df331587a0 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -207,6 +207,13 @@ static bool aca_check_umc_ce(struct ras_core_context *=
ras_core, uint64_t mc_umc_
                     !(aca_check_umc_ue(ras_core, mc_umc_status)))));  }

+static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
+                               uint64_t status)
+{
+       return (ACA_REG_STATUS_POISON(status) ||
+                               ACA_REG_STATUS_DEFERRED(status));
+}
+
 static int aca_parse_umc_bank(struct ras_core_context *ras_core,
                        struct aca_block *ras_blk, void *data, void *buf)  =
{ @@ -230,6 +237,9 @@ static int aca_parse_umc_bank(struct ras_core_context=
 *ras_core,
        ext_error_code =3D ACA_REG_STATUS_ERRORCODEEXT(status0);
        misc0_errcnt =3D ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0=
]);

+       if (aca_check_bank_is_de(ras_core, status0))
+               ecc->real_de_count =3D misc0_errcnt ? misc0_errcnt : 1;
+
        if (aca_check_umc_de(ras_core, status0))
                ecc->de_count =3D misc0_errcnt ? misc0_errcnt : 1;
        else if (aca_check_umc_ue(ras_core, status0)) @@ -240,13 +250,6 @@ =
static int aca_parse_umc_bank(struct ras_core_context *ras_core,
        return 0;
 }

-static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
-                               uint64_t status)
-{
-       return (ACA_REG_STATUS_POISON(status) ||
-                               ACA_REG_STATUS_DEFERRED(status));
-}
-
 static int aca_parse_bank_default(struct ras_core_context *ras_core,
                                  struct aca_block *ras_blk,
                                  void *data, void *buf)
@@ -266,6 +269,7 @@ static int aca_parse_bank_default(struct ras_core_conte=
xt *ras_core,

        if (aca_check_bank_is_de(ras_core, status)) {
                ecc->de_count =3D 0;
+               ecc->real_de_count =3D 1;
        } else {
                if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE)
                        ecc->ue_count =3D 1;
--
2.34.1

