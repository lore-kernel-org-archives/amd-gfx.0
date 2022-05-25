Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B10C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 06:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FAB10F339;
	Wed, 25 May 2022 06:52:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FC810F339
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 06:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7h9LovzM3aF4v5S5i3SJFnZdVgtZ/l6eOPUPINZVyMG6uTUeM3Xyody4j6OF3C6RPet0x6fSs+U4ssuXDS6rOo6RCB8onKlRDu/kZ+gVuVVWgg5LCCaUzCY6+d77bjsbanCuzfmJrTTRP6uvVsHT/KynWtW0Xr3ADEgeErrBFdCby+0dvXeucyolpe+kdzxGKtM/uJmdF0UHuUC0xCl4BLE0sTTLLPIa85mj9CITpaJSzrhNr1Fsj/8xm1CNwSCwdZ3pfCXc3vi8Ct+lmR2sLqyY6wBQnFHuzUatzB5+Lzby5SwDwd6qB8MJFB31ah/27lkh5r1Zp9QG2B+hSJJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PoZh8a0br9w5iVEIGH9yTjie23xWdWNZZV65dsglxE=;
 b=h6mq/OC76AMbS91wlXTgc0WxemL7GW7BeqrffokCghHH56RaLgUB2X2+GvncK5VCiMUNlbY23lJ3aRYxkTQmWoA3YmE1Ikl9ADAjH+q0KCxXudiOMpuJ74EMPq20xqKL/IjUTj6OQR0ZGI7Qd6+i78n31oVyPCezcLP2eIBjUwYIWO9W5yegeUnHEb53OSytrtYxFcJU9s/rBpM2ooKa5iSpP8DmbwuvfaziWiaKrrUEL1GVzj/2uAUaU4FxcZfuHyLNT2xIkMk69YZrMX2+D3DAH4S3kbO80UTQhEx1iMdMkpI7DvA6XrrAnWqkJNjScJZ/1BVQQpbaTTQiexUbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PoZh8a0br9w5iVEIGH9yTjie23xWdWNZZV65dsglxE=;
 b=2W30xN5pGw+Ysr3sjvsXw8YfJgxMTZBgZAVMCi+ILrdyl+B33/Tv91qH7UbnSCDTku82rmzwvHI6dL3u75JWL3sXmJiqPOQJgJpF76njXw5Me6uLzgwvsgTrlsbXtCSiNrErZr25WkTgvdh0CmX/R/IUov9LmOtCVh3oRn03/Hs=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 06:52:01 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::d914:5c84:26fe:45ed]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::d914:5c84:26fe:45ed%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 06:52:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Topic: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error
 address
Thread-Index: AQHYb/453FTJwGBaT0iDccklyxSpN60vJo2c
Date: Wed, 25 May 2022 06:52:01 +0000
Message-ID: <CO6PR12MB5473A51D94BF334E70E5353482D69@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220525061047.26529-1-Stanley.Yang@amd.com>
 <20220525061047.26529-2-Stanley.Yang@amd.com>
In-Reply-To: <20220525061047.26529-2-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-25T06:51:59.788Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56418e21-add3-46de-6ba3-08da3e1b1222
x-ms-traffictypediagnostic: MN2PR12MB4062:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4062C6C3C1D1685F0315C58F82D69@MN2PR12MB4062.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIWt45gY4IV76PqeZ87duShdIdJ9oxrxTmS4n0R9nx1bXgCnnPTkHw2XH8V9h2pR90QeSrsqyyB6N3u3szAPb8BItqrSEYFqJLaSOoLbE5ulzn2q+ceiZG6AeFws2XE3C8QbR8C1vhgmyDk7v99qvho/gBHmh9/DSn8C4zWN+KBgBvh4jAtxXYRPiHwENdqeQo0b1pO3WcyFheBbEeznrMBlV5hSFjMVByQQ6LD+mB32CNnKJHMO4LS+DZ5Hxan61smE+I/NVUDvm9mut14uBWsOsh+EerF+6GaUbWi2Bx15DcO7X81AVsF7FZ7H6D/13svC3ATCkGH5EpkxY6UeHONJPINaj43pylVvDkAJaOU0SSPsbeWycS+UngH0RwkhjA201nQVl+6O/euzihsmeL4I5uO/37W/t2VpDpfbC5c5cDXk5uEf3kyNZWExQ64YwtscjUwKGQOiJsUeQGQGjJY9P0MyR8pE/UKfbpy138npCgEsLWYOUeIkPkjpE5sflAZHhgN+xBn9NmwRN6zyE1YuXPQggk6HQ4/86QwLckTXG8MiYuwcw/SwsCNeFTWCbq1SfVzX3DNot8OWXkLLEsNpOcOljgc83eBb1Ul6B+c5n9rR6KWnDZK8riSHT2pcYDChk4wH0po9+VBjz5lD+qGhZcdcQyPM5wznWp5R3eqEhrM/QzKgMEAfxF1SpB0O41OAboO5nF+frKdaomgi83jqr2sENYWVGzIX3Ed1EE8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(921005)(6636002)(53546011)(186003)(7696005)(8676002)(38070700005)(6506007)(19627405001)(55016003)(52536014)(110136005)(8936002)(5660300002)(508600001)(33656002)(71200400001)(9686003)(26005)(316002)(83380400001)(122000001)(38100700002)(76116006)(91956017)(2906002)(66476007)(66556008)(66946007)(66446008)(64756008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TCRG76LjOPhEDHgujlr2aauKn9J1Egu+k2aHyJqHcORM9L3DGTi+SSNH96?=
 =?iso-8859-1?Q?8tYcKVw3gQKMX5JRse2lQZyIuo5q9pi7Jjucq12uBASi+IiPMF3h7zL1+A?=
 =?iso-8859-1?Q?c7KawZwQBumSY0pp0EXFi9/eWrFdFuGd7DODaeO2dWutlPjHrPvBUQQQTp?=
 =?iso-8859-1?Q?9HfD5m0eILJZ/FnipnQNV6wDcvgZXgFZ9uivHrraezLYsAs+DjrNH1LpHD?=
 =?iso-8859-1?Q?npKVqM4GMBT502xktkehyAw2CPc6kVLL6MLRFpfFbseAcMiBGDhV/IH9bR?=
 =?iso-8859-1?Q?XfbS3wL8bOqEAM8p4+Wbn7/wV7+E9EayykSiP3AbM//Z/JyoU8a4yLHT5u?=
 =?iso-8859-1?Q?jZnDuBy5dRIIM2xkWiAa8Krb/dqD1TO1xkygzn+bOE8s5Ls6swGjSw+sRp?=
 =?iso-8859-1?Q?dVZhgfBkKtbXAW2IWK8f/ma22wJ93fFMBCoDcU7/CR6v54TTeILvJC2Uvx?=
 =?iso-8859-1?Q?G4YRGi7ZRjKoDuzDdqBeWXitU1eTX4sXxsjabMhsS4FrDV+0skbd6zGqEe?=
 =?iso-8859-1?Q?ItHM2g09/4kiHJXFqf4dz8HUYKTnGlizqNi6e318vETpLd7k3fONniX5Tz?=
 =?iso-8859-1?Q?fkJ54MKZ6gsuM75QX/JYHC5Sp5oNeVh+oCuoPtF78BGZN8XSmd9/PVO9Vy?=
 =?iso-8859-1?Q?qP/JWLYZ30kRApb6rh3gzGz8oBlKP4vduK85v2fRjINJkvtpckxJuHKzsJ?=
 =?iso-8859-1?Q?97r6A0DzySZb9+BAECuSKBrwH/KeZdhqE0w3MHEwwKrpinVhB3SRy8XN+7?=
 =?iso-8859-1?Q?f7Dik3roA+8ifRmYN6fi5qv/Svx0Yl/yVtAb7jbUcK+yNa5tuevdglvehv?=
 =?iso-8859-1?Q?CVdseDlxGEsOmcVzMRV5dvG1F2XFgbhCuphTYd1xbpvN8bKfQeaJjsgT/0?=
 =?iso-8859-1?Q?wTeaQ+G2n2J+NC3FU7UWNQ8bizK63ax2guNA1ecgawdMCbTcMuClXUDNss?=
 =?iso-8859-1?Q?bvYcEqjLyrNFi/72ZWvzOEpUUVXhMY/jSpteLGuTmoukCOrK94WlE9fSTp?=
 =?iso-8859-1?Q?O1tByMuwYxxWTkVVwKjXU5VFvdsARlMK6nvZKNUT7Wwd/6+DWSidas4z2I?=
 =?iso-8859-1?Q?SDK4mZWEQqgahou6VN3tpKgXOIxlr7rWeZ5XwLQAoTLOoLfhn7OpvY7cYN?=
 =?iso-8859-1?Q?NHYnYHVpr1Khrm9svx/l2IfDbg1Y+3gfz3IMAAl9PPCGHD2LTiLsWvQ3Wu?=
 =?iso-8859-1?Q?M8sHR84VSANETsfUyDrB1QahiQL46bLdosU/jS3klgg7D/vGF+WX4nFmDN?=
 =?iso-8859-1?Q?GE/tJ/dk2DihN+XZ4ODQrAl4houBprQsrpqwnwJH4hKbWckw//vtzLMwge?=
 =?iso-8859-1?Q?SyhDS5VXBK84w1mNoAflHXgYevtSqQQGTWsyGEgOjGvt4QrNmkhekULClw?=
 =?iso-8859-1?Q?M8tpDn37zvjf6c43QKoDsqPySVmhogk6Hl3vSeQrSfBG1qR/R8dBU12Hr+?=
 =?iso-8859-1?Q?/Kwk+Jtty1r06HghCm6PkpApXQnB44Q7Ewcl7gdeINVJbJT2mrTMQgDIWH?=
 =?iso-8859-1?Q?cqJOCqeuCidPBE7mPR5S4nsEzmASX5xDMvVweEI29zYf42W87dtVKVp0ky?=
 =?iso-8859-1?Q?EsdThgmtNN5FW7CeTTGLE7ZHQtLaVo4IbadFPE/bNVQBkpTtqKTMJg8Ocx?=
 =?iso-8859-1?Q?ymfoHmHD31Un5QA7jvn4YBnIwtyYSJQAuuFNZ9vZ8tyI54hC/RjWXgKi6I?=
 =?iso-8859-1?Q?6f6kiAyAvrnAh/HVR5lz0n+E6+QyW1d12tNl70u0/OD7ucEr/mTUOeWcIc?=
 =?iso-8859-1?Q?a43/AHpscraDvHAnZ6V4j41CqoQ40Kr8vrD+ftylJqhGRX?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473A51D94BF334E70E5353482D69CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56418e21-add3-46de-6ba3-08da3e1b1222
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 06:52:01.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TX/DVepxaOrM0hUZbCiCn1UFmTG6o68K/TWwAqw8zvduDtGYsC9b9QWqBeudWnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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

--_000_CO6PR12MB5473A51D94BF334E70E5353482D69CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Stanley.=
Yang <Stanley.Yang@amd.com>
Sent: Wednesday, May 25, 2022 2:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Quan, Evan =
<Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error addr=
ess

Changed from V1:
        remove unnecessary same row physical address calculation

Changed from V2:
        move record_ce_addr_supported to umc_ecc_info struct

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 ++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 50 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 28e603243b67..bf5a95104ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -333,6 +333,11 @@ struct ecc_info_per_ch {

 struct umc_ecc_info {
         struct ecc_info_per_ch ecc[MAX_UMC_CHANNEL_NUM];
+
+       /* Determine smu ecctable whether support
+        * record correctable error address
+        */
+       int record_ce_addr_supported;
 };

[kevin]:

  1.  the new field of record_ce_addr_supported is not set on sienna_cichli=
d chip.

  1.  and this field is better to renamed to others when this ecc table(pmf=
w side) update again in the furture. .e.g: ecc_table_version

Best Regards
Kevin

 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 606892dbea1c..bf7524f16b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_error_=
count(struct amdgpu_device
                 *error_count +=3D 1;

                 umc_v6_7_query_error_status_helper(adev, mc_umc_status, um=
c_reg_offset);
+
+               if (ras->umc_ecc.record_ce_addr_supported)      {
+                       uint64_t err_addr, soc_pa;
+                       uint32_t channel_index =3D
+                               adev->umc.channel_idx_tbl[umc_inst * adev->=
umc.channel_inst_num + ch_inst];
+
+                       err_addr =3D ras->umc_ecc.ecc[eccinfo_table_idx].mc=
a_ceumc_addr;
+                       err_addr =3D REG_GET_FIELD(err_addr, MCA_UMC_UMC0_M=
CUMC_ADDRT0, ErrorAddr);
+                       /* translate umc channel address to soc pa, 3 parts=
 are included */
+                       soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
+                                       ADDR_OF_256B_BLOCK(channel_index) |
+                                       OFFSET_IN_256B_BLOCK(err_addr);
+
+                       /* The umc channel bits are not original values, th=
ey are hashed */
+                       SET_CHANNEL_HASH(channel_index, soc_pa);
+
+                       dev_info(adev->dev, "Error Address(PA): 0x%llx\n", =
soc_pa);
+               }
         }
 }

@@ -251,7 +269,9 @@ static void umc_v6_7_ecc_info_query_ras_error_address(s=
truct amdgpu_device *adev

 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *a=
dev,
                                                    uint32_t umc_reg_offset=
,
-                                                  unsigned long *error_cou=
nt)
+                                                  unsigned long *error_cou=
nt,
+                                                  uint32_t ch_inst,
+                                                  uint32_t umc_inst)
 {
         uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
         uint32_t ecc_err_cnt, ecc_err_cnt_addr;
@@ -295,6 +315,31 @@ static void umc_v6_7_query_correctable_error_count(str=
uct amdgpu_device *adev,
                 *error_count +=3D 1;

                 umc_v6_7_query_error_status_helper(adev, mc_umc_status, um=
c_reg_offset);
+
+               {
+                       uint64_t err_addr, soc_pa;
+                       uint32_t mc_umc_addrt0;
+                       uint32_t channel_index;
+
+                       mc_umc_addrt0 =3D
+                               SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MC=
UMC_ADDRT0);
+
+                       channel_index =3D
+                               adev->umc.channel_idx_tbl[umc_inst * adev->=
umc.channel_inst_num + ch_inst];
+
+                       err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_o=
ffset) * 4);
+                       err_addr =3D REG_GET_FIELD(err_addr, MCA_UMC_UMC0_M=
CUMC_ADDRT0, ErrorAddr);
+
+                       /* translate umc channel address to soc pa, 3 parts=
 are included */
+                       soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
+                                       ADDR_OF_256B_BLOCK(channel_index) |
+                                       OFFSET_IN_256B_BLOCK(err_addr);
+
+                       /* The umc channel bits are not original values, th=
ey are hashed */
+                       SET_CHANNEL_HASH(channel_index, soc_pa);
+
+                       dev_info(adev->dev, "Error Address(PA): 0x%llx\n", =
soc_pa);
+               }
         }
 }

@@ -395,7 +440,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgp=
u_device *adev,
                                                          ch_inst);
                 umc_v6_7_query_correctable_error_count(adev,
                                                        umc_reg_offset,
-                                                      &(err_data->ce_count=
));
+                                                      &(err_data->ce_count=
),
+                                                      ch_inst, umc_inst);
                 umc_v6_7_querry_uncorrectable_error_count(adev,
                                                           umc_reg_offset,
                                                           &(err_data->ue_c=
ount));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9cdfeea58085..c7e0fec614ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1883,6 +1883,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_cont=
ext *smu,
                         ecc_info_per_channel->mca_ceumc_addr =3D
                                 ecc_table->EccInfo_V2[i].mca_ceumc_addr;
                 }
+               eccinfo->record_ce_addr_supported =3D1;
         }

         return ret;
--
2.17.1


--_000_CO6PR12MB5473A51D94BF334E70E5353482D69CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
</div>
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Stanley.Yang &lt;Stanley.Yang=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 25, 2022 2:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Lazar, Lijo &lt;Lijo.La=
zar@amd.com&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH Review v3 2/2] drm/amdgpu: print umc correctable err=
or address</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment">
<div class=3D"PlainText elementToProof" style=3D"font-size: 11pt;">Changed =
from V1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove unnecessary same row phys=
ical address calculation<br>
<br>
Changed from V2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; move record_ce_addr_supported to=
 umc_ecc_info struct<br>
<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 5 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_7.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 50 ++++++++++++++++++-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
1 +<br>
&nbsp;3 files changed, 54 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index 28e603243b67..bf5a95104ec1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -333,6 +333,11 @@ struct ecc_info_per_ch {<br>
&nbsp;<br>
&nbsp;struct umc_ecc_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ecc_info_per_ch ecc=
[MAX_UMC_CHANNEL_NUM];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Determine smu ecctable whether sup=
port<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * record correctable error addr=
ess<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int record_ce_addr_supported;<br>
&nbsp;};<br>
&nbsp;</div>
<div class=3D"PlainText elementToProof" style=3D"font-size: 11pt;">[kevin]:=
</div>
<div class=3D"PlainText elementToProof" style=3D"font-size: 11pt;">
<ol>
<li><span><span style=3D"margin:0px;font-size:12pt;font-family:Calibri, Ari=
al, Helvetica, sans-serif">the new field of&nbsp;<span style=3D"margin:0px;=
font-size:14.6667px;font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (W=
est European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFon=
t, Roboto, &quot;Helvetica Neue&quot;, sans-serif;background-color:rgb(255,=
 255, 255);display:inline !important"><i>record_ce_addr_supported&nbsp;</i>=
</span>is
 not set on&nbsp;sienna_cichlid chip.</span><br>
</span></li></ol>
</div>
<ol start=3D"2">
<li class=3D"PlainText elementToProof" style=3D"font-size: 11pt;">and this =
field is better to renamed to others when this ecc table(pmfw side) update =
again in the furture. .e.g: ecc_table_version</li></ol>
<div class=3D"PlainText elementToProof" style=3D"font-size: 11pt;">
<div style=3D"margin:0px;font-size:12pt;font-family:Calibri, Arial, Helveti=
ca, sans-serif" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin:0px;font-size:12pt;font-family:Calibri, Arial, Helveti=
ca, sans-serif">
Best Regards</div>
<span style=3D"margin:0px;font-size:12pt;font-family:Calibri, Arial, Helvet=
ica, sans-serif">Kevin</span></div>
<div class=3D"PlainText elementToProof" style=3D""><font face=3D"Calibri, A=
rial, Helvetica, sans-serif"><br>
</font></div>
<div class=3D"PlainText elementToProof" style=3D""><span style=3D"font-size=
: 11pt;">&nbsp;struct amdgpu_ras {</span><br>
<span style=3D"font-size: 11pt;">diff --git a/drivers/gpu/drm/amd/amdgpu/um=
c_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c</span><br>
<span style=3D"font-size: 11pt;">index 606892dbea1c..bf7524f16b66 100644</s=
pan><br>
<span style=3D"font-size: 11pt;">--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.=
c</span><br>
<span style=3D"font-size: 11pt;">+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.=
c</span><br>
<span style=3D"font-size: 11pt;">@@ -119,6 +119,24 @@ static void umc_v6_7_=
ecc_info_query_correctable_error_count(struct amdgpu_device</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *error_count +=3D 1;=
</span><br>
<span style=3D"font-size: 11pt;">&nbsp;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_7_query_error=
_status_helper(adev, mc_umc_status, umc_reg_offset);</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras-&gt;umc_ecc.record_ce_a=
ddr_supported)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint64_t err_addr, soc_pa;</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t channel_index =3D</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;u=
mc.channel_idx_tbl[umc_inst * adev-&gt;umc.channel_inst_num + ch_inst];</sp=
an><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; err_addr =3D ras-&gt;umc_ecc.ecc[eccinfo_table_idx].mca_ce=
umc_addr;</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; err_addr =3D REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_AD=
DRT0, ErrorAddr);</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* translate umc channel address to soc pa, 3 parts are in=
cluded */</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADDR_OF_256B_BLOCK(channel_index) |</=
span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_IN_256B_BLOCK(err_addr);</span=
><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* The umc channel bits are not original values, they are =
hashed */</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channel_index, soc_pa);</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Error Address(PA): 0x%llx\n&q=
uot;, soc_pa);</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span><br>
<span style=3D"font-size: 11pt;">&nbsp;}</span><br>
<span style=3D"font-size: 11pt;">&nbsp;</span><br>
<span style=3D"font-size: 11pt;">@@ -251,7 +269,9 @@ static void umc_v6_7_e=
cc_info_query_ras_error_address(struct amdgpu_device *adev</span><br>
<span style=3D"font-size: 11pt;">&nbsp;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;static void umc_v6_7_query_correctab=
le_error_count(struct amdgpu_device *adev,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_reg_offset,</span><br>
<span style=3D"font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *error_count)</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *error_count,</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch_inst,</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst)</span><br>
<span style=3D"font-size: 11pt;">&nbsp;{</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t ecc_err_cnt, ecc_err_cnt_addr;</span><br>
<span style=3D"font-size: 11pt;">@@ -295,6 +315,31 @@ static void umc_v6_7_=
query_correctable_error_count(struct amdgpu_device *adev,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *error_count +=3D 1;=
</span><br>
<span style=3D"font-size: 11pt;">&nbsp;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_7_query_error=
_status_helper(adev, mc_umc_status, umc_reg_offset);</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint64_t err_addr, soc_pa;</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t mc_umc_addrt0;</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t channel_index;</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mc_umc_addrt0 =3D</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_=
OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; channel_index =3D</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;u=
mc.channel_idx_tbl[umc_inst * adev-&gt;umc.channel_inst_num + ch_inst];</sp=
an><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) =
* 4);</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; err_addr =3D REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_AD=
DRT0, ErrorAddr);</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* translate umc channel address to soc pa, 3 parts are in=
cluded */</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADDR_OF_256B_BLOCK(channel_index) |</=
span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_IN_256B_BLOCK(err_addr);</span=
><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* The umc channel bits are not original values, they are =
hashed */</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; SET_CHANNEL_HASH(channel_index, soc_pa);</span><br>
<span style=3D"font-size: 11pt;">+</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Error Address(PA): 0x%llx\n&q=
uot;, soc_pa);</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span><br>
<span style=3D"font-size: 11pt;">&nbsp;}</span><br>
<span style=3D"font-size: 11pt;">&nbsp;</span><br>
<span style=3D"font-size: 11pt;">@@ -395,7 +440,8 @@ static void umc_v6_7_q=
uery_ras_error_count(struct amdgpu_device *adev,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ch_inst);</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_7_query_corre=
ctable_error_count(adev,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_off=
set,</span><br>
<span style=3D"font-size: 11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(err_data-&gt;ce_=
count));</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(err_data-&gt;ce_=
count),</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst, umc_inst);</s=
pan><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_7_querry_unco=
rrectable_error_count(adev,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; umc_reg_offset,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;(err_data-&gt;ue_count));</span><br>
<span style=3D"font-size: 11pt;">diff --git a/drivers/gpu/drm/amd/pm/swsmu/=
smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<=
/span><br>
<span style=3D"font-size: 11pt;">index 9cdfeea58085..c7e0fec614ea 100644</s=
pan><br>
<span style=3D"font-size: 11pt;">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/a=
ldebaran_ppt.c</span><br>
<span style=3D"font-size: 11pt;">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/a=
ldebaran_ppt.c</span><br>
<span style=3D"font-size: 11pt;">@@ -1883,6 +1883,7 @@ static ssize_t aldeb=
aran_get_ecc_info(struct smu_context *smu,</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_info_per_channel-&gt;mca_ceumc_addr =3D</sp=
an><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ecc_table-&gt;EccInfo_V2[i].mca_ceumc_addr;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><br>
<span style=3D"font-size: 11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eccinfo-&gt;record_ce_addr_supp=
orted =3D1;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }</span><br>
<span style=3D"font-size: 11pt;">&nbsp;</span><br>
<span style=3D"font-size: 11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span><br>
<span style=3D"font-size: 11pt;">-- </span><br>
<span style=3D"font-size: 11pt;">2.17.1</span><br>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB5473A51D94BF334E70E5353482D69CO6PR12MB5473namp_--
