Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 10:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E9310EF34;
	Fri,  8 Apr 2022 10:55:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C2710EF84
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 10:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTx5/FBKj/sVXaj80Ra4xx/mHTSriHDAWyjVDCqoMJ3ZbC+y1wcgoeA1O9K4A9c7GclmViyW7yDi6czYLCXcsKcrbxFg+Iwkt9lsCDkoI5OGJVdbiirspMqdNnS51rG+VXhPTwm26ti9ERnECrf93EuxOaFld1G/AP0JmzW+YF8owRLGc4fF47FRToEt+qBahOV94978UacngbVpR/kOKDm5MO0tlSuQcnK48tlfeG/UzoLYzddcvQUQwpXQ4JwbTtGh3+fvbs0yWpygv4lZ85bjZDuIAtSeLO6NKEuVvr1uNG7kfgQF0Q/vYtUiEyzudSbPbnfwukLCFe30gzlP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWE0Zq+lOaZUMtij/Pc2EciuUJSFNFDFDt2mQfwE8SQ=;
 b=AOxz8wOFNbT394DdDQA1UhFLUmVXC1HlBt7vbvlvsY0MZEr6CILc0enYo1cBnCI1WtnoTuEuoQwIMzzobk09s+k5cDWDDhyRNDARPWCtbVXdanemdWghLWbbOe2nLJSjBrigyhF7Es4am7ibaFpUo5Kq+Jy8xiJ/JjeWBOGDNz+dcp+SMJtR4yC4XH46gtsnA/ob9ZvMrFOKSwdze0FzB6b2rk+mLgDMvF8PcKAWvYqiSHaEFM0hWl/Nk7Gn0gfZfi+lY3Y6ZlulZqKlTqNqCRCWtFqGVA/JBxeMG91QMddMp0YazZ48F50aTYKl5bDjjMARIRz0AAae5rS7rc8Q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWE0Zq+lOaZUMtij/Pc2EciuUJSFNFDFDt2mQfwE8SQ=;
 b=kkvDyBy4wbEae9q1uKuzYqkO1yZ6SLKddpCE+L26qstcya8XR0CC4ul8n5J+6KswnQhF3aSns3DtZCZsd6ev0M5zd6SBD/cZY4YaROPd58KCWnVskyUnd9PiYhXNlYv7JiqOW2kxn/CGaGMYPru6HvfK9zY1iR7pR1XctHT9Jfk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3359.namprd12.prod.outlook.com (2603:10b6:208:cc::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 10:55:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d%7]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 10:55:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: add umc query error status function
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: add umc query error status
 function
Thread-Index: AQHYSyAWTo8H5j20m02gkJNfSV8aDazl14EA
Date: Fri, 8 Apr 2022 10:55:03 +0000
Message-ID: <BN9PR12MB5257DA85513D30D52910BCA0FCE99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220408081009.31319-1-Stanley.Yang@amd.com>
In-Reply-To: <20220408081009.31319-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c5c2ade7-c9b6-4eef-b156-98a98f601b5e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T10:53:28Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f4262ad-a344-406c-fb47-08da194e3c7b
x-ms-traffictypediagnostic: MN2PR12MB3359:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3359267761416AE4E882292FFCE99@MN2PR12MB3359.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/KhXZBfeA22dgfOCwQDWqClDsrgonIbCI6gvHdd560wqNfi7NRjkQqQanPzw/Unc2rEjedbJul6matuhTp38t8sNJL/4ILWx/2Vvendw3MDmxtscX1Wp0VKvuG/lT6DfpjHMqa9wxmGOjd6T7/sBnpeOvbx/dIUpowatwVOIpwGEuVCinDVrSwWS0t/OY962T9qqlCGInKtIbiFwvkx2Wl2SA+WkRK7NeiluMgjsxpSZwJBhIRYrXdAHw3BYVnzbGRhViMdWrQvRFmmiHKfhOF/CnvA4Qqfm0OR+h+czY6lIE6XbZO7Rroj5eLPcnTVJqs5xcxXl5eqwZoB3wK1FOGVQImz/L2QDkxqV2M6QOlBiQOHyypeGM7KMkhDkWyuRozAIEy5SU6vDdfUkPwYe29c255xf0St50ldWg2Sc95QuS1hpTvu7+uQazqiKlI5VYpiIkYh1MRV9iK4LpiLrEY0780g6ohIA72E+H+NvTy48evF5gqaR7l1+8rLCRAx1AD5fZd5ZTidNGN/dvEhSG8LIIGKmFfG8IxTlVLMNvEOjzMbLG642RFayttJZcb3iBnKrd0DS/OfNoXkBuKPGGicHDfux1aXprp0YHTWMPZBUW2qQcr9CmgQIz2Fp8iIE43IyM5j+CLPCOOEJ7veCwj7Zx2YXZwrsqTd++SX6nf/PW5vDJzxfIruW0GGfffN2+FlcEE/v+5jfOUsQGlG3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(316002)(2906002)(66446008)(66946007)(76116006)(8676002)(66556008)(66476007)(64756008)(5660300002)(6636002)(8936002)(86362001)(508600001)(110136005)(38100700002)(71200400001)(52536014)(33656002)(6506007)(7696005)(9686003)(53546011)(122000001)(186003)(26005)(83380400001)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OmuUpaXswZrS9sOG+ZiU/9q8wNW4MDuibSb+d6yjMTqTBbXvBDoUjEaq8D9E?=
 =?us-ascii?Q?i5lKu6FugBaBFbDUnyWPP6RoZKblsgNw5U4Et28VKJBjMxMz6V0f91ocSTPe?=
 =?us-ascii?Q?j95/6kNQcfYX32F0jywP0YraZsBZQ8N77ih3+yi1ondk7WrOP/ywgeLitH9I?=
 =?us-ascii?Q?DU9nKlxHj9ZdB/yQBD7nu1f5jb8MDOQjPIdeTlao94hTJR4EcH9JLi9A08en?=
 =?us-ascii?Q?7ZVK5ceJByYrEH/AlVlNrnq91/VEdgWqdT8VG7e6AL1o+xVNyTwqNZXwAxD3?=
 =?us-ascii?Q?vw9Jzazb/PblsLZQtRkXTA/6EUWjMpEVuLzTfIpeU9NsAsl06vKOWantLaxo?=
 =?us-ascii?Q?AtPTRffNIAuGQsvgx9Q8SsUK4nDIAdMHSBcpGp6Q5uwE8Hiw6fPPL52rMcU8?=
 =?us-ascii?Q?ju81TPUx3f84QhYW/l7kW1QtohkyqE2PL+WEFhSdQ5BFIYF1dh10Vu62iI8j?=
 =?us-ascii?Q?GGBN+1vvlH5toUzjmwkZzKBAs2M4bDYxVzdyp1dtDz3hNizZWbJM7BdEL6fM?=
 =?us-ascii?Q?o+vIa+zq3UuqXUxmhZD8XdOeQy6QdZ2OUpvVs3lnY+tAHFjHi8a/j5oL63Vz?=
 =?us-ascii?Q?6tTU/NpwOKrvnzZe+RJkYrabsCvhYF0kOxBAoCfPU+ps3txT/4qRyketJXol?=
 =?us-ascii?Q?VDIuL1hwKU5P6bw7xKAW5GGRCcuHpJo9MAs78Fh9tOwFzeGR/EhfE8aAWKP5?=
 =?us-ascii?Q?bHyru6W6q/oD0NLbcpwDGNK9wI4vU8srIkYldvZT4xrYvem/kOVcatvO+i+L?=
 =?us-ascii?Q?rcR78CW0TvKcoMX414b5a/4DxnVUeHmRdhBJVt09UjlO5F1+KtuarlIbMq0e?=
 =?us-ascii?Q?lt207cE9/wktChl9AnI5/C5Ks9Dx22LdYpF6+eTpl/Qfic8OBzTeEsjzaOca?=
 =?us-ascii?Q?Lqi0KpSGWD41F/d9LtzMMyIqMtJ3PALS3EK574djCX/RhM7vEnItuzVuLYWI?=
 =?us-ascii?Q?jyvnF0y06Xw7M0hGcvWh8L2NRC+OGB/naGyJ69hFXsifksnBE07IFJQrGE9+?=
 =?us-ascii?Q?3oZ2SznXpv+VK3Ug2UE6Zmuq464a//tKU4udLDuL0CYJ2ZxSyr/9qZV8DyyE?=
 =?us-ascii?Q?iAdIKNdiOTVqhKSU+ERbdK0YzcOhLD8mv4tS7Cy5FRyW8BEz5Muqw+Z/28yL?=
 =?us-ascii?Q?xFmqT0SlD9lHOldK2aOfPcE1aSejGHa1sXj0zGITXYrLNwprxFZEqtiHZuXm?=
 =?us-ascii?Q?zVZeKaoy1P37LpB4lUvWtZ3duQRdbH3b0NZcpM15U1DW6yuSA8fNSQh75Yn5?=
 =?us-ascii?Q?uwccC75ABtNs/Q8KHkDsuNVAmVHwbFrkTCeeD/Ykf/dlC/+8VhZi9c28JyUP?=
 =?us-ascii?Q?IfpRijCyK1C0vMy7L9sUqa2nQkT1oqu8obcBo5UdU9a5roCcSzZ8gK6o2r4N?=
 =?us-ascii?Q?uRWWAFg3g/HyuQKzR9UgHQkm0E5p34dESlZ5pZdQWfUAKDFdPofDwGYd4kj4?=
 =?us-ascii?Q?bSFPCkydw8N0BbrpmHVwFvtvkyAZavcIujlxWQA3AqdZVBE0WsBUq7G18EjQ?=
 =?us-ascii?Q?ZdsLGv88dHI/kxpnSCHb1uz88Ru2wChe+zZ0jnbD8TjEOoePFfssI+hXSVsq?=
 =?us-ascii?Q?xw2jzNJtDvXvLNXUzCguoCX7u0XNSfPKUoOrU1qzsw3wxFHxGnuj6B0dt80E?=
 =?us-ascii?Q?tp+0DL3d1lVQf1fzf3RrMbsYbdMCJh8idPS6yY7IGZs7ojWltL5h3g9b9eJq?=
 =?us-ascii?Q?FeuT84Q1FcWZ5faB2yrBKhioqOlGHLboSKzmnf5ROcx6vduaJQX7bQg/lSdP?=
 =?us-ascii?Q?6HsqKV2FKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4262ad-a344-406c-fb47-08da194e3c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 10:55:03.8310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +C+CExbJG6tCwC5yxs4MqrlaaRuq55BIo8wV2lnU1pzfNaFjg4U0VzWc+SCo7LbEJZGwPvIjEa5XU45BFXumSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
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

[AMD Official Use Only]

+static void umc_query_error_status_helper(struct amdgpu_device *adev,
+                                                 uint64_t mc_umc_status, u=
int32_t umc_reg_offset)

Might be better keep umc_v6_7 naming style. Call it umc_v6_7_query_mca_stat=
us. Apart from that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Friday, April 8, 2022 16:10
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: add umc query error status function

In order to debug ras error, driver will print IPID/SYND/MISC0 register val=
ue if detect correctable or uncorrectable error.
Provide umc_query_error_status_helper function to reduce code redundancy.

Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 106 ++++++++++++--------------
 1 file changed, 48 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index c45d9c14ecbc..9d3b54778417 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -64,21 +64,62 @@ static inline uint32_t get_umc_v6_7_channel_index(struc=
t amdgpu_device *adev,
        return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_=
num + ch_inst];  }

+static void umc_query_error_status_helper(struct amdgpu_device *adev,
+                                                 uint64_t mc_umc_status, u=
int32_t umc_reg_offset) {
+       uint32_t mc_umc_addr;
+       uint64_t reg_value;
+
+       if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Defer=
red) =3D=3D 1)
+               dev_info(adev->dev, "Deferred error, no user action is need=
ed.\n");
+
+       if (mc_umc_status)
+               dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x=
\n",
+mc_umc_status, umc_reg_offset);
+
+       /* print IPID registers value */
+       mc_umc_addr =3D
+               SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
+       reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+       if (reg_value)
+               dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n=
",
+reg_value, umc_reg_offset);
+
+       /* print SYND registers value */
+       mc_umc_addr =3D
+               SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
+       reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+       if (reg_value)
+               dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n=
",
+reg_value, umc_reg_offset);
+
+       /* print MISC0 registers value */
+       mc_umc_addr =3D
+               SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
+       reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+       if (reg_value)
+               dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\=
n",
+reg_value, umc_reg_offset); }
+
 static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_=
device *adev,
                                                   uint32_t umc_inst, uint3=
2_t ch_inst,
                                                   unsigned long *error_cou=
nt)
 {
        uint64_t mc_umc_status;
        uint32_t eccinfo_table_idx;
+       uint32_t umc_reg_offset;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

+       umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
+                                               umc_inst, ch_inst);
+
        eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_in=
st;
        /* check for SRAM correctable error
          MCUMC_STATUS is a 64 bit register */
        mc_umc_status =3D ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_statu=
s;
        if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC)=
 =3D=3D 1)
+           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC)=
 =3D=3D
+1) {
                *error_count +=3D 1;
+
+               umc_query_error_status_helper(adev, mc_umc_status, umc_reg_=
offset);
+       }
 }

 static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdg=
pu_device *adev, @@ -88,8 +129,6 @@ static void umc_v6_7_ecc_info_querry_un=
correctable_error_count(struct amdgpu_dev
        uint64_t mc_umc_status;
        uint32_t eccinfo_table_idx;
        uint32_t umc_reg_offset;
-       uint32_t mc_umc_addr;
-       uint64_t reg_value;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        umc_reg_offset =3D get_umc_v6_7_reg_offset(adev, @@ -106,32 +145,7 =
@@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct am=
dgpu_dev
            REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =
=3D=3D 1)) {
                *error_count +=3D 1;

-               if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST=
0, Deferred) =3D=3D 1)
-                       dev_info(adev->dev, "Deferred error, no user action=
 is needed.\n");
-
-               if (mc_umc_status)
-                       dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_off=
set 0x%x\n", mc_umc_status, umc_reg_offset);
-
-               /* print IPID registers value */
-               mc_umc_addr =3D
-                       SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPID=
T0);
-               reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * =
4);
-               if (reg_value)
-                       dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offse=
t 0x%x\n", reg_value, umc_reg_offset);
-
-               /* print SYND registers value */
-               mc_umc_addr =3D
-                       SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYND=
T0);
-               reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * =
4);
-               if (reg_value)
-                       dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offse=
t 0x%x\n", reg_value, umc_reg_offset);
-
-               /* print MISC0 registers value */
-               mc_umc_addr =3D
-                       SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC=
0T0);
-               reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * =
4);
-               if (reg_value)
-                       dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offs=
et 0x%x\n", reg_value, umc_reg_offset);
+               umc_query_error_status_helper(adev, mc_umc_status, umc_reg_=
offset);
        }
 }

@@ -277,8 +291,11 @@ static void umc_v6_7_query_correctable_error_count(str=
uct amdgpu_device *adev,
          MCUMC_STATUS is a 64 bit register */
        mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr + umc_reg_offset)=
 * 4);
        if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC)=
 =3D=3D 1)
+           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC)=
 =3D=3D
+1) {
                *error_count +=3D 1;
+
+               umc_query_error_status_helper(adev, mc_umc_status, umc_reg_=
offset);
+       }
 }

 static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device=
 *adev, @@ -287,8 +304,6 @@ static void umc_v6_7_querry_uncorrectable_error=
_count(struct amdgpu_device *adev  {
        uint64_t mc_umc_status;
        uint32_t mc_umc_status_addr;
-       uint32_t mc_umc_addr;
-       uint64_t reg_value;

        mc_umc_status_addr =3D
                SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0); @=
@ -303,32 +318,7 @@ static void umc_v6_7_querry_uncorrectable_error_count(s=
truct amdgpu_device *adev
            REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =
=3D=3D 1)) {
                *error_count +=3D 1;

-               if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST=
0, Deferred) =3D=3D 1)
-                       dev_info(adev->dev, "Deferred error, no user action=
 is needed.\n");
-
-               if (mc_umc_status)
-                       dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_off=
set 0x%x\n", mc_umc_status, umc_reg_offset);
-
-               /* print IPID registers value */
-               mc_umc_addr =3D
-                       SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPID=
T0);
-               reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * =
4);
-               if (reg_value)
-                       dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offse=
t 0x%x\n", reg_value, umc_reg_offset);
-
-               /* print SYND registers value */
-               mc_umc_addr =3D
-                       SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYND=
T0);
-               reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * =
4);
-               if (reg_value)
-                       dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offse=
t 0x%x\n", reg_value, umc_reg_offset);
-
-               /* print MISC0 registers value */
-               mc_umc_addr =3D
-                       SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC=
0T0);
-               reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * =
4);
-               if (reg_value)
-                       dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offs=
et 0x%x\n", reg_value, umc_reg_offset);
+               umc_query_error_status_helper(adev, mc_umc_status, umc_reg_=
offset);
        }
 }

--
2.17.1

