Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60D2C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A8810E2B5;
	Thu, 27 Apr 2023 15:12:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E00D10EB8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8Z2/fXFPEswQ4+lFVZ1vNkhS3oePtosx5oUTV9kYYGkOkv7jOKIVS1Tjr2fPHS0IIISfC4hMqkgjoSHJ8iWI0eUIjYgLYK3QdlJuTOJXiGtk9eOl2jgBHMjdvKqlvzLEOVg4mNXMYx3yvROPkzJtq2Nv8RZUkpPESKmKOJjJAYOg6uyZnx4nATNhXe5AVXrCMmC+N7K4tZlGiVvJjioXIcy6qdUivm3uR98mDeJH419HuDBp4c3IOXdb7jVFyZsJe+9HEEa6xg5bI+B7Dr8fpHc6CbtG0ZgEOsBB0YIq4wScB9b1+Vl2/jpCBQy1AMO+qWPQcWIc1qsGLaTvjRuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCtLOyiwEtRWeAgabR/vcZoXg85Nc/JVoRCn130e9mQ=;
 b=aEZKlrZombos5nvvocHrMCVCYL5q7TMKiZQteIVIkGuYLg2hhJnbJ+MKg91XeB8LP/Wh08u0xrFtGb0x4nTesXt1+CC9/n3OmiUZvozqrIRbj76q5AlUeUuzxcNNtMTl+N0tz5iDHb7dOqATMJTKhtn5DpxhGO8XKxRrpCun8+qH9Q0xd/mDzyzoEvOiws0MGucUl9TTJFbBxbBXEIBv7wRk0cCjNzDcQZs45e8h77rwFT0lQUZbMz5ELbrqhr09/m6jOo60kUK1FxI/q/7f9cpGI/JObk1/IjbqL2rtQlwdvnCBf+9j5QnAkrlRqoEqQRdftbmPZMhj8HVhgU0lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCtLOyiwEtRWeAgabR/vcZoXg85Nc/JVoRCn130e9mQ=;
 b=GK4VIEN3pySmCeR16nmEjieAFhJ5bEnAjz/XEF/qaG1OIbhIvclNgzkQMI4F5ErkuQYVsPq/f+VKACbOqlc8Jq6KHfCWr8rBN0mpGord7NIIN42w9EchzFAZPC/dlgMWKpMsjxknY/n/0PMb5D5q44JW7GLf+WvJRpifW2jsBBA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 27 Apr
 2023 15:12:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 15:12:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Add SDMA_UTCL1_WR_FIFO_SED field
 for sdma_v4_4_ras_field
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Add SDMA_UTCL1_WR_FIFO_SED field
 for sdma_v4_4_ras_field
Thread-Index: AQHZeQrVjA1irPcKPEm77jBhwUXLGq8/QxpQ
Date: Thu, 27 Apr 2023 15:12:37 +0000
Message-ID: <BN9PR12MB525755952BFF6DC32EA3C008FC6A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230427131855.18902-1-Stanley.Yang@amd.com>
In-Reply-To: <20230427131855.18902-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=82fe10df-a3cb-4cd8-b07f-144b014c0fc4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-27T15:11:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6447:EE_
x-ms-office365-filtering-correlation-id: 756a483d-0b28-4837-2cd1-08db4731d626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTds7NPEbElJRT2RT1YEG49xw17D3trc2Tu8EmeqDyJK7Uc0+JsOER6XjJSSdYjTN5vX74dnxrzSuv0ecHD2gzWz6RALOfH1Gm/0vBMTog1CBKDa0BGsnpxl64Bazdb62rl5nntn0XIlakb7891nkyI1C7Woj3NpDNH4QoQbOlaiBrBfjWc1yBufyj3gvY45iAxuTi0dBcarlRVfYBW94TBDVo1RCPybZdaCO0Q0NOJT9/Cdd8uJ8ojSZzwsjR9UheYiqtNqsWcitekDneWvniSYGcLr+cCMZiNKAU6a0dYSVzcYWPHISBpddObMX1QFp8bHLZZHu6hkmcIZOlbPgzBAq90h7aF1Dbek/PMSYnG3sYSrBdCjYfSlXqjHv1ZqZ62sf6lIWo1D7JuQLRK8OjhQgwrPreGsfurxrDMO1WTQKwJX8ZYk9AyIQaz4WBei7Ju/NEyWGh8mNDbrJo9WcmnD4bK7bIsNTpx/MR+L/lUSm4CAYmxJhKVJcRxHy/otTUoDXC1Q0d46bW/weDXrXiJHAVEHKzd5i8mromgIGqCNARpxQUg7ecCImaI02bM0jMm5scw/v7SaM4E1iBrLIB7MU2GZFxWkpXfQegR3BNG1sGHHGSkWS/FkNWamVzUG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(478600001)(76116006)(110136005)(66446008)(66946007)(64756008)(66556008)(66476007)(6636002)(8936002)(316002)(122000001)(6506007)(26005)(38100700002)(53546011)(9686003)(4326008)(83380400001)(7696005)(8676002)(186003)(71200400001)(41300700001)(33656002)(2906002)(38070700005)(52536014)(5660300002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zVYQNsO5l8DSmB936ix9YmaeiBenKy1jf5zVi1/suamBU/nXYU2cemhbvAQ7?=
 =?us-ascii?Q?3Wol7vM8z0xFC4oMr2huwS8YnuGdxS+PTplYomfRVkTN89O2bDBI0E4UnZhc?=
 =?us-ascii?Q?Gi0WN8/G1MkAwIphvshZ8YECWV6F6AKFWG/uIdAoCK+phmHMV1P7A8Gc22Es?=
 =?us-ascii?Q?p/mHdqGLAwXvUUza0nVlLWJ8aqc/aloXCuaR0WmpJ8/tFibC+wOlKbsMQHaa?=
 =?us-ascii?Q?qEU3aWLoZsW/aMCxk0A/CWrBUqxNsLoLkVcXNbd6JrNc9DCfJPW18Zju8SGV?=
 =?us-ascii?Q?KlBx4j4/SK1G7nKpbgeKvUMOW+9r+k09wmO/Aycon7UHl1e2dLNcvK8xK7MM?=
 =?us-ascii?Q?swrKa1H2tY8pjHhRGAQdT6JqvRWNBoSKR/wEtUZxWLSMLuiKGGTFEyHEQCzb?=
 =?us-ascii?Q?p1na0gxaWMHFSdA4bECUv7ZoPEoTfjjN/B9moBvMH68hz3ssnVV6PTbulXPa?=
 =?us-ascii?Q?uGRI5cL0jHCa4b3KalPZBnNA1RS+cdRmpQ+bZmoUVSvbw6+oTUihw2r+XLFE?=
 =?us-ascii?Q?PRIH967h8u4PM62ciPU+Vzn/GYY+EtIaKmQ/l7B0MhfbbOF5jV9yETueBjCv?=
 =?us-ascii?Q?EC/UeownYc+1/7SLDVZdqGBq+hCIOB17HjDiO+yFZBI0eS5fWnXx8fxwsHn+?=
 =?us-ascii?Q?P03WypJQKfO2pmAgRrMso/aGxvv3A5rYeuSF8hS4ncH5v9hnmpKHGtpw4M+f?=
 =?us-ascii?Q?axKqcYyk1mMbJOLjD2PJazhOWK7rsHRzfFmXyb7vwaFfgcsP208H3SQUsoX+?=
 =?us-ascii?Q?GHgOKW6izeEGPOuD99oX3GnHDyBhxRGjLmsuWGmfwWt1rtSSCpjq5/qMRGAO?=
 =?us-ascii?Q?0mnIDQn8u9kQ0/oGSLIfGerVHfbiSTaqOtinB7U87qzAQe6x3hL+MsIzFbPb?=
 =?us-ascii?Q?7OA6rnDdQkvxSrHpQx8P4+P1D/klbLq5ovUPGR5aDTZ5FV6VtOfeoNXSY8fW?=
 =?us-ascii?Q?1nj2+/nezYpnkihp9YAH8vzhaG8ft/67wbFByZeyVNGE6QRWs2t3ZO7wmIcZ?=
 =?us-ascii?Q?+sZlw8QAxE0aItpRVOzqkQkXIQtnQXKDzW2qq9zMKs1qGFDfjkEWEjkuxW62?=
 =?us-ascii?Q?DS+9rVGf9AOujpPcT/VwdA7eHV728A8JCs9oeElbu2VSBtpxATdV/+nGQbqW?=
 =?us-ascii?Q?3HIbKzO8bFCAEWvkZFyOO0sTVZOub+3bY81aCKq+ynt6299jlmSCasAhFILJ?=
 =?us-ascii?Q?hIv0tQNa6Z5R3PX7ZmwkSjPl5aTBzlcMcwo4P6ZngeiYlofNzhxrrhlV+OVv?=
 =?us-ascii?Q?vuiQ1zdLL1MaS+w+f0GoY21er+njn64dTLU8OnHykSSKgl5hp4yVVAgSql8q?=
 =?us-ascii?Q?lGA/PEJMzNKX/SahPQwu2QkP9OHnAsSfhmvJpOZpQDSiW4GnuYrFgHkVtOOP?=
 =?us-ascii?Q?QwiSppUAxiEnp/KMl/8Scor869UdMAxjy32dKFdnYdYi8YLbSm9x/B6KMfuO?=
 =?us-ascii?Q?MgDTHnVd9iafmX8LPxzXm0XdX4BKDmJVxNkPMPrquOaALB7JNFDVQcPo6lp1?=
 =?us-ascii?Q?nfz41pHe6CrWtMSRS7CyZiBTclkCDLJB/E6BzVAuxtt+TI8vBqrLOsajmzEj?=
 =?us-ascii?Q?jgTyFY1hbrMiDL9t7Jc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756a483d-0b28-4837-2cd1-08db4731d626
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 15:12:37.4473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WI53Ych9uG8uWzEpIYswx0eEgSzlhjCX7ax2T4GI4ArkyXAqEBvwe8W3eb7ct/1AOjyJ/QBJo1TZeda0zylyow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please add commit description. Apart from that, the change is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Thursday, April 27, 2023 21:19
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Add SDMA_UTCL1_WR_FIFO_SED field fo=
r sdma_v4_4_ras_field

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_4.c
index 6f9895cdddb1..0ddb6955a6d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -141,6 +141,10 @@ static const struct soc15_ras_field_entry sdma_v4_4_ra=
s_fields[] =3D {
        SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UTCL1_RDBST_FIFO_SED),
        0, 0,
        },
+       { "SDMA_UTCL1_WR_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_=
COUNTER2),
+       SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UTCL1_WR_FIFO_SED),
+       0, 0,
+       },
        { "SDMA_DATA_LUT_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_=
COUNTER2),
        SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_DATA_LUT_FIFO_SED),
        0, 0,
--
2.17.1

