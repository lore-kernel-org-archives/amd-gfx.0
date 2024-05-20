Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D886C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 02:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36E010E078;
	Mon, 20 May 2024 02:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTh9VIsK";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C807610E078
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 02:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWIzmBfG2UWe3EGJ5V6KVAwEYS6JGmIScXIjeNyC/g6d1E2zRanAqV3nxcSDgz7/C8tCNxfeWGJjSB6mXiacInsbRynzcsnagvp9m7vjVcAUwjsCFIeElgm1UCzxfBs5F7/53saM1zGG3JIeKIF+8xdLew6WNupHpa1sotYEHvMlgQsln4r8GnkQbadKfQiIojBREg6o68Nd/fY4AMR2sW6C0O01QyhNR5gmbR05NHGS+um8EE7aXmWXcobx+sGMX+LXnBK4BkMnQMT9uT4oKSfj2PDe3nGBad50YRYHi3H3sjvZk6y3wi7mh4VWsshyq3m3QLDhLJGO/gG32kKKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPPoZxLs8Mp+nUfJ9hRhEZKq4GuuboAht9bcfqtoK7I=;
 b=E6s7loIr6ol1LPG1VlqZJn4FuCQiht45G4O1kVyDcZohES6R47Sy+x4L0iugcZtL1B7sUrtYZiVdZnQAUF/elmXXsbXzzXVBH6UaLNgR1TMIM/WdtekLJDc3DgQXSOUuZiPXNEM6kZaKM8nJuBDuACML3zLTlAUc63xwNLRiqV7+XE9EtXkQNN+ab8JnKrvrOJzuCAy1zGq1+B4Pb4WPyqJajnKkUJZK+9bDs8Tc4lgjQYrKv5qFTPr0EQyTvQWrKjwqwuYrPhtWRTLrnYNGy2Twxa8sl67HJoJ5VbXnhRhvwjtc0VcUXy+a9esorxgC9UU1k2RewEFeGz1CvlbQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPPoZxLs8Mp+nUfJ9hRhEZKq4GuuboAht9bcfqtoK7I=;
 b=oTh9VIsKSb2OYKiNx43tSmiKPkVfXw6YS6Y7M7TK4kvNBY5jvPSLkHX6SO+5rwKP9GaGNriWUK8rC0j0ZbfG4hCfvbndLKtCXtyWCkB7P/fmEO99KZU043hJ4ErWe04xkO9vscORIjKCG6PCamuCAajd5xi/FvHa1FLWCh2Fpeo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 02:55:43 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 02:55:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Thread-Topic: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Thread-Index: AQHaql/k0pWCllncdUGyvAqj++dbu7GfbYcg
Date: Mon, 20 May 2024 02:55:42 +0000
Message-ID: <PH7PR12MB599773C1210FF981B93839A782E92@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240520024546.23403-1-tao.zhou1@amd.com>
In-Reply-To: <20240520024546.23403-1-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=addd08db-40b0-429c-8d77-478ec1e0a417;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-20T02:55:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB7858:EE_
x-ms-office365-filtering-correlation-id: faa0920d-5e4e-4ace-b899-08dc787856cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HW4SKT/N1Ff94+YW+itisXKbWG+pmD62ZsY24VVAC11IwmaKsAYd5Zssp9gx?=
 =?us-ascii?Q?qFA5dp+Cy5eoLPpd/fE5LokWQCCKI+VzsbV9vfcTNvFtFUtY0xZ8+5Btp8J2?=
 =?us-ascii?Q?CGe3Zf3rT2HDEyE1tyScp46GBpbb8+UnJUy95NSbLh2URPfgQ0f37VdUW1b8?=
 =?us-ascii?Q?oaXqbOs1r7kC3kSai5pJOEC/QeXJhrw4hNXwyI1CXAc+YMjphMrEV/cZnvHK?=
 =?us-ascii?Q?QCObf8ABJgn7YRrDUobn11xgmQhjFQ+o/+OKyebQgUngB74Sk7HW4OCvtg3D?=
 =?us-ascii?Q?ufiT+HVKFNgxBN9FB/W3cs4SR0cPpgEuBSbleafv4AokIdnqIm7qdXVtjHoh?=
 =?us-ascii?Q?PkJDFi3cHnFF3jsLp2L1Uzkw5tnMQtl7fGgM1p0+Ihs35rHl0fTFAalqN/gF?=
 =?us-ascii?Q?tmqW3JmQGx57X4sbXgeWzsVBofwHPkoAm2V3Th5cX2cyIyhYfJkUSsnKZAvh?=
 =?us-ascii?Q?/JDNGlohGMjkGPK+LHHYGB5iS3Vi6muT+X6ZrQ3/MLSrSeir34ULiTOA3sWI?=
 =?us-ascii?Q?LYeJK0eozR16/YUa8Q+fLsAQYdaQ4kdMZjpTjdgzsHs51t026nh4kQtc/Elq?=
 =?us-ascii?Q?OT2kZ/0CTibZH3Meh3VQxtwoFGpMYVLRf1l8LhwB+hWJiECbBG223zsPDXXs?=
 =?us-ascii?Q?ZuBx/Y1DibHG0j0/qQlmdv3Gpl9Zgd9nmfY473sl1qHGYFi1KjY9xQHmrT1Z?=
 =?us-ascii?Q?ybgInjHNw2xIbMpybW8yyf2s+jyV/P8xiDwn+UCS7u1ZczFekZKJRZgJDxrs?=
 =?us-ascii?Q?tGmbjiS21ljpmjJRHiF4ygd+ri+AuhSi11mrnWb9eNgVl3KLwhSDTv8NENmK?=
 =?us-ascii?Q?+V465DhY9oTa8sLIbrOJA9C3pdEedXMiVKRTGdgzZPoj0la+pUZytmjD2FVV?=
 =?us-ascii?Q?iZ896F4ZuRLlqinX1APkIWr9k+s7LczX+5xoOXeiPRb4IfzpKN1JA+N0ufjm?=
 =?us-ascii?Q?ZGNVLUCH23iIGeO/GasYBATgdpCoT0YdV48LL8KJkJa1F7sepTPMcvMSZBo6?=
 =?us-ascii?Q?6nu4u7aRFOhgsYh9B92pwCWuToDDzfAhgn3NADsJaxQrk7R23jrZvD0jCQ5H?=
 =?us-ascii?Q?yHhFe7O2y2g+JC86P3fHsa8VTbFJW97PFqPfYz9aDH8XOL8oGotzGYN2TaeI?=
 =?us-ascii?Q?B6CKuIDg1h9dNj4FKXWvmbVRSGEGdub0SbhnXTTxy5p3C026Lt0YjF5c1Ope?=
 =?us-ascii?Q?Ulw8rWSGDkSiWhxiUmkJJN9FuHzzCPVoXQYBRQejmsnMtEk3Rlo/pjpAkaKI?=
 =?us-ascii?Q?wbN9IOsvgK42DsM8GFaMy7LdXy68vvOPkhCgEiePT4i/CiB7hu7HLFc3aMUT?=
 =?us-ascii?Q?93yfKabIa3P/NotXYxhlX5VADKKermwvJpRsIzVxoNLUBw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?shjugKbkSoXqzbK+QOP+1pX7G8Xp8hocjtmx3y1miyXR90WC9T7l2EwB7JHG?=
 =?us-ascii?Q?OaOxEWMwJujoRStjIBiZojwiUgcgvvmbSXViCLaXmvvabwKtZF2ae4FeGwPn?=
 =?us-ascii?Q?DyyxAtGHOHOiOzAsiHm+1QarZVsAKDhN1c1g9yoJTczEC84pFRQhYB7W0Elt?=
 =?us-ascii?Q?xozY7xhPFkJahiSpPO4t4aZe0mpbeXEssdUvu+RoHxTstA9Qo7EPBFtRLvx/?=
 =?us-ascii?Q?3diCElr3hMKqATEEWRajepOMwPx5TOCkGz7GsN1Mh9ppnypmVAhX2kxZagDY?=
 =?us-ascii?Q?deUBAtTcqob3EjiVDcbQPLFUuT0FAJqmAb8LA1kqrCkasK7sp+uARLl8AmJK?=
 =?us-ascii?Q?0JQXkqptq6SziEK3rd3GBwKYfhX8zvqoEpIMiEP7x5knk+3ZpnxliYLD94gQ?=
 =?us-ascii?Q?fkKhBCVOwqU0QTensskj4ZbID9lAuJmxOEoL30H5BbLfrRuLkX9NTEtTskpo?=
 =?us-ascii?Q?vQ4nj9lCxJE8PD8pnC+9kqRSz5d5lrABb4FjpZ7gNIYSkl9OoJ1vv+qcw4Jy?=
 =?us-ascii?Q?9vX82JkXJN3XYjc4oIjctMRQvxYS3vGL0L31vfX7EE7CV/LQvCjX7s4nRtAJ?=
 =?us-ascii?Q?6KCEXt9bIi/oqJTlJnGq1FuitZYFR/fdsT5U08tMWGag9DgSNSrgdIs8EOc/?=
 =?us-ascii?Q?AGoqY+Tw+TTb/Cin/RwOi7XducSfESfU8kHn5dW5/PK+aTS2e1Zy6fenu54c?=
 =?us-ascii?Q?q2SPcSZmjtBlgLRWST4SYapVnEUJuIB1e00atll9+z89//niukfAIfYHbhGS?=
 =?us-ascii?Q?RoDfwQ/Xnj1gV02G8wxRvx9tmGXvcPpGngeeah3FBMp12lwDpUC1og/Nc92+?=
 =?us-ascii?Q?OOE3cUWXNBiq/z2HBr9y35EdvZnLn0aHdZp0OEvWMZYB79RI6QCm+Tj+CTsb?=
 =?us-ascii?Q?wxDSioV6L7l23N7b5aGe2eDxok/en53OTwIBN914+mF7rEdjz39Zl0tKl6ji?=
 =?us-ascii?Q?j7frKl6RYIgAFkAj+nHBK1IU2GDdHH63k4+WmwGkgnCaiBbLfq9HoXIrebot?=
 =?us-ascii?Q?VAg7w/FSq6hNPd4I8IgHj3UZThJigNPL6jLFccGfGINuXLiLs0ODgxg2NLnz?=
 =?us-ascii?Q?MGyyM0/7D7cfwuF1zmZlvSSxGWrnPK12KptQY2I95aTM+WXu1NCMtvduqhxs?=
 =?us-ascii?Q?8AHCSZwx4Ivn22Tj3T3n8Py4oVli3kdmsQ4m+AviMwWV8TtZo7ByTVubwN9S?=
 =?us-ascii?Q?ZqQ1pyeShk3eVAXqb+d3njsgXvoPz9C4YS4mBbJD2E0eJjrTrUdYXmcAsrPg?=
 =?us-ascii?Q?tJ7T645QZZUolfK0H+Eqo+J9dTKLRzpev7g95MEvWpPL5TdNbqPOGf208FIK?=
 =?us-ascii?Q?bLXHHI1fILFmq2nsFmzb0NS+2GP8cD7Qechv+pGryBZ5ukZCmujhN2JcuKE3?=
 =?us-ascii?Q?TMx5D5FC/2NRn5cpC5bu1IJij+dApIhforFkMDFGBXUphUFaQsCh7uKA3XnX?=
 =?us-ascii?Q?w5+QOX6o+qRrBq56t9XCU6Ts4i1vw3rnkPiNzK3MWi0CiXAqVn7fKvVFWjOC?=
 =?us-ascii?Q?wP12hiGTq3efJ9rWKgevxyhUoFRjOS+rZ0YEx8DGpqJPVOgvbnicZViRwTxd?=
 =?us-ascii?Q?T3roaeIoxltxl66yQxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa0920d-5e4e-4ace-b899-08dc787856cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 02:55:42.7230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FE4xaD/jPPCHVGqCeHQ76gxls/pP4swP3Gp/8p1Jg7du8wiBAmpiXjY8qk39pHMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, May 20, 2024 10:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom func=
tions

Avoid overflow issue.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 +++---  drivers/gpu/drm/amd=
/amdgpu/amdgpu_eeprom.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.c
index e71768661ca8..09a34c7258e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c=
_adap, u32 eeprom_addr,
  * Returns the number of bytes read/written; -errno on error.
  */
 static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_add=
r,
-                             u8 *eeprom_buf, u16 buf_size, bool read)
+                             u8 *eeprom_buf, u32 buf_size, bool read)
 {
        const struct i2c_adapter_quirks *quirks =3D i2c_adap->quirks;
        u16 limit;
@@ -225,7 +225,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_a=
dap, u32 eeprom_addr,

 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
-                      u16 bytes)
+                      u32 bytes)
 {
        return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
                                  true);
@@ -233,7 +233,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,

 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
                        u32 eeprom_addr, u8 *eeprom_buf,
-                       u16 bytes)
+                       u32 bytes)
 {
        return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
                                  false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.h
index 6935adb2be1f..8083b8253ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -28,10 +28,10 @@

 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
-                      u16 bytes);
+                      u32 bytes);

 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
                        u32 eeprom_addr, u8 *eeprom_buf,
-                       u16 bytes);
+                       u32 bytes);

 #endif
--
2.34.1

