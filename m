Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A44C47DDB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 02:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD71113886;
	Wed, 31 Jan 2024 02:35:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20335113886
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 02:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLLTg08bsgvKZbEmY8ecsGu7B7gEOzOi+8bW4VjPKZxapmNLwbEZj+RhQ9mSev9gEpuHXBAl6/nHVX1z6htvk6h9hbgdv9XiLi9M1prYOGVlg4J5ya4EvN41EB0SUn1dmKcRsaOqqbRfYCYwPijAIEDHT9Ye05eLg9fRugC3y8dv1Jf2X3vNRZlh2jQTzzHx0zjA5fXwNdASZwTdDix/4ILOKMz+8p+rSNq7zb8lQDzn/wQcCTVaf6YBVeXSWSIUFBV6L2ZSaqlIEQgLCL0GcopjyWWquYOvXzWCCXUxUu4Qwgnnw8+U+HuvAIdZI7Z07jrntV5PkC24YNQae+JDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LtCa1PYlh6Yf+gQTAye0VYhCf0Gn6b+fkpRtyrNn00=;
 b=INKUmwT47P2TZyWNtY5Wac4M2IFCP3yCxdUJZ+tMdqkGKWaAqKy0DaulUHRKyGi/SZt93wuYbjYee3la1NAnrOx09DDTW3gCllIyN7M5jowfRYEKgwxx8EzNajlph2DDwSeeXs4pIQkK4mHOucC/edgk4gfx4hNB9AoPidCA3uWnFE7y8ooRmEvMQujxAy3WiX1KiWn+giuGo1ZRxhorB3GgqPFC3axooHJ4u9gR9mWZ8ciUDi7KKUwxZNCcOvi31M4rTFjUMd0nkY49Q96h1PbP3KAi9IhbYRjk+ZLP6puNTRGF4LAekb2EvR4ke9G3FlWU4viQ7wcMdTLBWVHdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LtCa1PYlh6Yf+gQTAye0VYhCf0Gn6b+fkpRtyrNn00=;
 b=SmbWrhd6nAuBO0IOGWHSsz13jQTrq0+ceRdjy8fthWg7QFw8OKhlZLkPBEIC+g91JeyXJoDndp5TPX4/My/wtpSU2RhGZt83zr5uh+dP+MsONBVC5fW9C4G3iP9LindZHjqiXVX+TTphGeMZ+po6F07pS5CAlEzTRn33+igChnQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 02:35:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 02:35:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] use PSP address query command
Thread-Topic: [PATCH 2/2] use PSP address query command
Thread-Index: AQHaU2zRxzlx43i/Nk2SCSqYW5Yk1rDzNWfw
Date: Wed, 31 Jan 2024 02:35:38 +0000
Message-ID: <BN9PR12MB52572B032C796BC2A2917099FC7C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240130110914.295366-1-tao.zhou1@amd.com>
 <20240130110914.295366-2-tao.zhou1@amd.com>
In-Reply-To: <20240130110914.295366-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7d1a50f-92ce-49eb-a676-e6dee187c0e1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-31T02:35:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6722:EE_
x-ms-office365-filtering-correlation-id: d40b0668-c3b7-4f41-580d-08dc22054f54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlmXnjmPIHj6l2ekIzIzC3dveOp4u7XAo8F1mRAWvwIzaCWns/qHIsgcFRJ2FEkDHf7/Ptd5iHvOgPD0X6AwkKONagCtWvHNkUA4ajzj+NYuapCHdoC3zUP3qXfDsTd0lgS+rey7KE5IYVlnrAsZMdaeE6BERIY8bBGD8E5U6IU6PsUG903DDgNG69Elda2Aou9pes/M+sRRf7npi9UYO9N6BR1bVAl39pzVTeGVBbTvmDfIJgQs2Lni/MYM0uuiuVO6niIe9ykH2ZhGNB9lbBvkBjo/Ivl2tVtr9oSOWAlCuBJr7cBdNRStkpLUiRE9xJZ63xQhJveVMCfQuykp62bgjfN/SMantOgDx0qsTLDMqO1BzvWpl+suU8VTXSpgoPPIlSnONFTaUTDbWnmrmv3S/QXfx2BWZ/9RSKI9XNh0lJGjuT2T8C2KWlttfPjw2Du2hyeeJ6fG6OdbfN6QuAebUd+/1fgsY7l7pHTrfLD58hEoOzlYU5csjlkIItyhIxVv1ANSfnk+SHBA3kVDmVOJxzQoRC2T3pAJrkWNx062zQme/Mrufb6LANPORxiVd6aVbhYWsl3OHF2tQg2jtZQ0HiRS3Mpkzwduz3H3roRgzpZDS+93cR5b2EiQ1Rlr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(9686003)(7696005)(5660300002)(55016003)(53546011)(478600001)(6506007)(26005)(71200400001)(38100700002)(4326008)(52536014)(8676002)(8936002)(41300700001)(33656002)(38070700009)(2906002)(86362001)(64756008)(76116006)(316002)(66476007)(66556008)(110136005)(122000001)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sh0MJyVWqXfrEvTEyCcT4JNj3r8NZyfXg01Ems3LnFNwitlmsZoR4kg6FFnr?=
 =?us-ascii?Q?Gkms46RfWp71zlYPNRN3BXCYqUUNEGbCTBMv4wQU8bQVMDOEeNgLGWwyCh06?=
 =?us-ascii?Q?e0WVdn+QUWsVQa3e7BuGM3+qBdMRNvsGNpx9aU/7TFGWLmOVegYXYRzJr5fM?=
 =?us-ascii?Q?obJ/lwMQ2P51jmAoZK5lnRlsKCmqswwb9U3lhNJm6OacdgQAxO4TninGbAhx?=
 =?us-ascii?Q?LDtnqsZSmQql8w2W4ZjAIg9Wa+JdbsRY0lQPVkvBp0l2HueV0yAr45KDIdyI?=
 =?us-ascii?Q?ElVhzkY9heq7Md7XK7Prc+3FEkkzA5ubU0A5hvV+SFL04353eQRtAT1kYZG5?=
 =?us-ascii?Q?l5JuGgasIk4U12XM6bY95DnrEgWLM2CP1ZFpx1ntclDg9dM9mxLsf0ptBxBo?=
 =?us-ascii?Q?fsw5GLQwmkjjyo3c7YEQOpo12PEX6+uqPHyD+3RGEhiTwxy9EX4xgMbS0HOQ?=
 =?us-ascii?Q?YFHtseWrG2/VvsfxmRReqgILsed85+hfZh6a+DaXKLdnH2WKm46gRHNRhQ+S?=
 =?us-ascii?Q?A6q5cubXZ5w7ttCtYFGBGH6x0tYobrTtYgPWpXmvOanbl3yyzOeAl5X30n3+?=
 =?us-ascii?Q?c8HQtLSlI3sQ0eajmtjgoa15toBOshM71D6cHaM0ltAS8GgSvphIWuln4wJC?=
 =?us-ascii?Q?KtGOCuogIpXYx4jMZaUvs7JpCDljtpN523m2ypeauOKnMlx8n4jfUxuGVYUI?=
 =?us-ascii?Q?qfPTDdItGnCh0OQCjVdzCYh9Hn2jVm+1YmjvSawWUnLPyk6pV4w1wArpw1Dq?=
 =?us-ascii?Q?WZmBNl+jUqy9gVVsIe0QRf91zJaKkIjAJ7gRaaBOmjUwBmUF8PVrFoDMXXqI?=
 =?us-ascii?Q?fQsMgy3J+rqCFxHi49uxcOY6dmYeHhxpd/2+h6cy8XnnEVqB16ysr4rYKON3?=
 =?us-ascii?Q?d5pWJnDJ2QtHz909PLruJbYx0IZqwc/uFC6bqoh2K7OgF+FHY1jUenRYz+Et?=
 =?us-ascii?Q?JhbCKtRdCmGJTkp54t5ZuefudnWzOiaYDN+7OInRrWuXXvYQSPj4DQsrT+XH?=
 =?us-ascii?Q?6iBimlrFZDeKhoqyPPwWTu0fwS3JqLsAD1j9mVgWiKc4Ezup29jiGxFYdaxn?=
 =?us-ascii?Q?Gm4LOEJ5Xqr8mNYWrc9YRi3DAMhV8QxMDc9V+5vUy70lHoVfTCZ5cfRbhgkn?=
 =?us-ascii?Q?SOfRkEq57ymBUCyKdHgtGGGmaSMsqzwcNXv6FCbyU0eC1YqGuPMU8xXuIDhr?=
 =?us-ascii?Q?22FPREwntyIxKBzLpEmEMoSdFHtnWO+lyxtxdXjoXUbir0/9tfDLTEHAF32B?=
 =?us-ascii?Q?YnQkghrl5mH5FxXi9Nau7eTnqBTbMQNAFnXs0BIfR1krR0IXawuh50rC4H06?=
 =?us-ascii?Q?ppsonqNKZogvqBoWhwEfyxBgX0+zYLMtUN/EpjDqdJ7gHKL6VwH0v8xuv79h?=
 =?us-ascii?Q?miEzzPzOJn/ZNW7GBHykRrD7Yc9i7MXU53/klR7lKgSM3EY83JbrTO6UrUla?=
 =?us-ascii?Q?U+yBByr8K5qV2tXus75o47VO2LIbEXBrEgl2RXu+30voBE8HIrE6a4iQolog?=
 =?us-ascii?Q?GVXfuZsYLXyEu6cGJytG2FAcNENCuGah1M2KyfUY9ouM+XbbEab4Lq+yzmyD?=
 =?us-ascii?Q?9D/Q4ZNsJ98AdTPhayQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40b0668-c3b7-4f41-580d-08dc22054f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 02:35:38.0727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPNTAqKm+23WqAlwXZe00/MW9qNouAvc0SaeLvKTN8hMD8zhGt1D5uraUVVj3EuN7ks+SyHmGTPyn0ran0di/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, January 30, 2024 19:09
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] use PSP address query command

Get UMC physical address from PSP in RAS error address coversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 46 ++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 836a4cc1134e..14ef7a24be7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -203,14 +203,14 @@ static bool umc_v12_0_bit_wise_xor(uint32_t val)
        return result;
 }

-static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
-                                           struct ras_err_data *err_data, =
uint64_t err_addr,
-                                           uint32_t ch_inst, uint32_t umc_=
inst,
-                                           uint32_t node_inst)
+static void umc_v12_0_mca_addr_to_pa(struct amdgpu_device *adev,
+                                       uint64_t err_addr, uint32_t ch_inst=
, uint32_t umc_inst,
+                                       uint32_t node_inst,
+                                       struct ta_ras_query_address_output =
*addr_out)
 {
        uint32_t channel_index, i;
-       uint64_t soc_pa, na, retired_page, column;
-       uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row, =
row_xor;
+       uint64_t na, soc_pa;
+       uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
        uint32_t bank0, bank1, bank2, bank3, bank;

        bank_hash0 =3D (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL; @@ -260=
,12 +260,44 @@ static void umc_v12_0_convert_error_address(struct amdgpu_de=
vice *adev,
        /* the umc channel bits are not original values, they are hashed */
        UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);

+       addr_out->pa.pa =3D soc_pa;
+       addr_out->pa.bank =3D bank;
+       addr_out->pa.channel_idx =3D channel_index; }
+
+static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
+                                           struct ras_err_data *err_data, =
uint64_t err_addr,
+                                           uint32_t ch_inst, uint32_t umc_=
inst,
+                                           uint32_t node_inst)
+{
+       uint32_t col, row, row_xor, bank, channel_index;
+       uint64_t soc_pa, retired_page, column;
+       struct ta_ras_query_address_input addr_in;
+       struct ta_ras_query_address_output addr_out;
+
+       addr_in.addr_type =3D TA_RAS_MCA_TO_PA;
+       addr_in.ma.err_addr =3D err_addr;
+       addr_in.ma.ch_inst =3D ch_inst;
+       addr_in.ma.umc_inst =3D umc_inst;
+       addr_in.ma.node_inst =3D node_inst;
+
+       if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out))
+               /* fallback to old path if fail to get pa from psp */
+               umc_v12_0_mca_addr_to_pa(adev, err_addr, ch_inst, umc_inst,
+                               node_inst, &addr_out);
+
+       soc_pa =3D addr_out.pa.pa;
+       bank =3D addr_out.pa.bank;
+       channel_index =3D addr_out.pa.channel_idx;
+
+       col =3D (err_addr >> 1) & 0x1fULL;
+       row =3D (err_addr >> 10) & 0x3fffULL;
+       row_xor =3D row ^ (0x1ULL << 13);
        /* clear [C3 C2] in soc physical address */
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);

-       row_xor =3D row ^ (0x1ULL << 13);
        /* loop for all possibilities of [C4 C3 C2] */
        for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
--
2.34.1

