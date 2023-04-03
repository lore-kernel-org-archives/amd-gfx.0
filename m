Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB5DC76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 07:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989FC10E15E;
	Mon,  3 Apr 2023 07:25:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997BC10E15E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 07:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZEDLVAvKdOjhjFn8M+9dtuVZHT6gEkUsck1ESPLbeH2Wlzh390mRiwbNzpyuGvwLHB8B/hm6XYnpcucnR7ZNAybZfCKvtSShZdTP8HQlX7OgO0fRb4goq9DVXCwEI2ykj4ZemS78a2AnnKwzls+3E1DZTIV6YuelvvzDEj9gNC37Rbs0rkSeEyk81qSI4maBG99wUOtnVq2O2IVmMrLT/DWYodFMBIU/UqwkPSXwDzbfWhYwVMhi3QDvdown+p2kXA5YjGOMAGKtmWszsGuJMrTf+8uYIcWV09DZE4DNwRQGMLpeGO+/xdTSgrQ8IuQkrhGR4b3ML/xUpPnO5yO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY7xleI4SE2wl6785MyC5d5Br8lGii5KK1MR8qsiwe8=;
 b=ItOF9XZEVarDVbeMgbNzl3RnLo2QWXOPOcafkLE5SYzMDiObpzHnj80cN2yvSbNtjUCBlGmi/wx6Le2OdDRpWwBdtV+Gl8dxNpdYP2HQWCbUUa54Bv4V0j05cD9Si0fIsh2s/K2mtk5PEctkyRKb24q8Lcuq1so4I6hui0j3hwFAICmHJa2ktyWv+zkSAXKUquNWt2Xt8Kvh84dyG39l4Exemv87sRaq+1kd+P6w98VuPyf4mwceN6kPbG2a3u5rMkWmFP7saGidtpdh/Bmstv1Fl1VFjgypjWTGNz93fuFHJyb4kup6WKOzaLwqs8j/dEbXT7OcqrINWRu5Do9bVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY7xleI4SE2wl6785MyC5d5Br8lGii5KK1MR8qsiwe8=;
 b=QcYSjw0YsizycHnHegsNKf9isMKMgdu+qSt+CzQtqX9RjeJVqzIl+eHHbM7wHMmEJZIQhPzBaPg563MB9UxkzbumVsfekmD7iYG4WOxUbcMRxt2vSIbTwpugo5vHf/OIKyzwDF4V5J3oL08yorjq2tggIw6lZdAeNa3tB6hG56Q=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 07:25:49 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::bb38:d4e0:f6b4:a63f]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::bb38:d4e0:f6b4:a63f%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:25:48 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Topic: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Index: AQHZZdBDO0k9cJG1UUCgKiC41iaIJ68Y8aoAgAAxdTCAAAr0gIAAAS+Q
Date: Mon, 3 Apr 2023 07:25:48 +0000
Message-ID: <CH2PR12MB4215C412E3F83126F2CF0B79FC929@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
 <DM5PR12MB1770077FD7D17A141B9D608CB0929@DM5PR12MB1770.namprd12.prod.outlook.com>
 <CH2PR12MB42153455C15B4151D1FE6281FC929@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CY4PR12MB176763A1F9B4F74D76F37008B0929@CY4PR12MB1767.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB176763A1F9B4F74D76F37008B0929@CY4PR12MB1767.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-03T07:25:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77aa5156-25a5-4735-a093-69ee1d4e4933;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-03T07:25:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 16139f03-00e2-4584-8272-eae55e9e42a3
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DM4PR12MB6061:EE_
x-ms-office365-filtering-correlation-id: 408d0116-be3a-4240-1141-08db3414a54f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rdqIp1DqQyQeLYjf4Bhie4GF600g4k2B6OA5DVr0Msn6jSvh7V1XQ+zrndCToQkWfEPhKd0G8ykxvVboMKRpc8sIbALxNbioptTlT16Gpnvna0fPdPtE7yg785aw+b8O6jHJYPbIYnHGBMfsYUS/b0zhBwF4hZE+qx9nW1gdPlPJFSNN+zFZ/AuCkMJOuOzpzV0cKZM/i5/wgv37EuOVrJ4DLw/D0N/xXZFF6E1w+w1QpZdVb5+ZqoFQIkDhdT6Qi6mRRNnAcx+aCODgaCNNcOLOG3cPYE8aQzdOxR3Eis7b84Jsdur5T9uG49xcLwBDxOjForE98FDFu6ozU60+uNzUzC3QQwZChqCl2lnwcvSs0dzi8MZjOOGqC65ENJKWB4oUKctzlMPr6iu1Poqf+wky1p1M4bjTMrgtPPq2p7Y3xJJC/MG8hLGKga+EyYEMhjeZLKQPZz0LL3CABbM+xDmS3duYxSBSrB2SiunXbhrhgsJzKZmuoQ8wR+DEdaxHvXV/m1hmwS19H90RXp6yp23wd4JYUlH1IXNVwFJgvQ5IwDq9KPEC32bb61RuY2HyxuRcwuLCEP8dIzoED2c+buY3HALIzRRnOU98A6PEC2CRkYusHrEAmG/WafQE4Ym
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(4326008)(2906002)(30864003)(316002)(8676002)(52536014)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(478600001)(54906003)(8936002)(110136005)(71200400001)(7696005)(41300700001)(86362001)(33656002)(38070700005)(9686003)(6506007)(26005)(83380400001)(55016003)(122000001)(186003)(38100700002)(53546011)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O6+ZZcL5EfkHjCJnORRhXH9LmghS+whHflb4mncd20burOLVlqntlDS6g/8X?=
 =?us-ascii?Q?PNGcweCBGoAK/nFpOXKMwJQlVylxkxtRyDUfuR+T9nCzWvao2uYRigLffSVV?=
 =?us-ascii?Q?6zcRH9x8uyLDQ5VzBy1L8kePaILLAeAtNxSlIpOLwTj1m74/3BizGKbCt8Mr?=
 =?us-ascii?Q?NiMvLcm0nVDJP4xYssz1xN8Acg9nAHV80Dy/5HwYlPDle0YZn3Afnso27/J/?=
 =?us-ascii?Q?tf8O/PJi8+AY2wP6/kNpSEX9Dwb4uw9AEuRybQ8P55XYti3t3nsWwgE5oZW3?=
 =?us-ascii?Q?dZsMxHm3SOMYdR9Fn6u4h3SOq0I55oaUaj5o49YSXUkn9+1S8zxyseySqXsA?=
 =?us-ascii?Q?JpblX5G4n3TtZh+eMaTr29JQ0Xct0L95Cb6oMJljYBSVK3EclZXo2a1VSOW0?=
 =?us-ascii?Q?dM2bPxPOvBydRy36TWJQ1KbkWP0rhlK4nXzUi8UmSA2H1briYkmHo5GPunp9?=
 =?us-ascii?Q?8sTKfGA9tn9MukZnHaMRU+NOsEKU5ZJ9rG1NONohXgP+iRAK+LguMlioMUz3?=
 =?us-ascii?Q?31xAJNJy6Sv2H4z2TN9+Ch5X6i5RIiaeehclXehW2imhRJm9sNQUzFWZRigE?=
 =?us-ascii?Q?8l3NaApuu4dxhD2wt/XOvpug7TVmwdmx7bKMBDgcVHnzj/SFVu3sXDtD4xhC?=
 =?us-ascii?Q?vlB2LqSfTLOGqGZb8os8Pa8LR+kQuyoP8Uxrm3VQr3jz4QJUxkrUxFFBX6ce?=
 =?us-ascii?Q?IGgZ9GSS+ofz7he3sjP+qMINFzI6U9e+4XMcVLMmMlA0hlGwXmpnXe3bNE35?=
 =?us-ascii?Q?CK9Kvh+knFb2r3HrY39ozDZn7svJVjNnyBM2ApdSS2O5zn/c4ef+uDv5IjKR?=
 =?us-ascii?Q?is8sl2087xt/wMSpNiHg9yy5eDjlHKayOKEZlxZyYQWNEhbxhLgE5wNdPwqP?=
 =?us-ascii?Q?sj/Zrn/yIHenMGWC5xzSDP1iuLCpNyUN3CK4uiPZEAVqbLevVxGu88zYPOJw?=
 =?us-ascii?Q?l3k443+dM3Z2B6WmxU8H7sKMKWdi6gG5brw7mhL4jSu+Hf1wXo6QTrD0YjuO?=
 =?us-ascii?Q?ziEZAtdJLuSq5p1+xw7X0cjQpck2zjb05qA0E4T4RcxCWUmQ5FUIL4+Sqf6g?=
 =?us-ascii?Q?yOO3i/IL2hIdaR+DGXzmhmHlhiAStpMAZEpGT3djalhw0TRqpRmhezEtLfaE?=
 =?us-ascii?Q?xFuKGTsegOUGcL9ZeAKWhWFFSHGsmx30Cutz4qDFqFabgmRV5+0I4srfzW4u?=
 =?us-ascii?Q?poHe47Vv/zSuv6CAPPf4ca+ITNht6g7MDYooSf+D6bfiMS7C5tq4+z8uQ5Yg?=
 =?us-ascii?Q?rjprN63HibxcqliM1GdWameCmtGFW1fv/lJ4LNsjcnmRxba28M5yqUX+9o5v?=
 =?us-ascii?Q?imBZSNSuoDw8UQvKZ8FOCYIDROl/GXEEuN2opeVtrjwbBwmbCKHLhlFGwFNq?=
 =?us-ascii?Q?A/k6Jkf2240OhADLZqsy9/ZG80aE2yRrmCLJkGFTDPrO53xtclH+15cjR0gN?=
 =?us-ascii?Q?BQhe/aCSKpZ/mXvGqcGp1/AThoheSQGsuWskI3QwPuwAOKH+dz8ulqrfBzUM?=
 =?us-ascii?Q?8XKC/luc3hu8nTFQuUEP8gIB6eGEznnI9orXPpqHBkr8NW8TZ4FPWwx033lT?=
 =?us-ascii?Q?PSGT5Q3m6bJRTbY6fW0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408d0116-be3a-4240-1141-08db3414a54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 07:25:48.0305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OtCXatx3uQMTuVk+Oo9dCvkHDGA8jw8zbQmMhh2YZtx+u+dDZG3EQn57/jVxsMfS3ttli3lJqyJhVDrm0nquA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

OK, Will do.


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, April 3, 2023 3:21 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10

[AMD Official Use Only - General]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, April 3, 2023 3:00 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice=20
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in=20
> umc_v8_10
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
>=20
> -----------------
> Best Regards,
> Thomas
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, April 3, 2023 11:45 AM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice=20
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in=20
> umc_v8_10
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Monday, April 3, 2023 9:59 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Candice
> > <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,=20
> > Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: optimize redundant code in=20
> > umc_v8_10
> >
> > Optimize redundant code in umc_v8_10
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  31 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   7 +
> >  drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 197
> > +++++++++---------------
> >  3 files changed, 115 insertions(+), 120 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 9e2e97207e53..734442315cf6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -302,3 +302,34 @@ void amdgpu_umc_fill_error_record(struct
> > ras_err_data *err_data,
> >
> >  	err_data->err_addr_cnt++;
> >  }
> > +
> > +int amdgpu_umc_scan_all_umc_channels(struct amdgpu_device *adev,
> > +			umc_func func, void *data)
> > +{
> > +	uint32_t node_inst       =3D 0;
> > +	uint32_t umc_inst        =3D 0;
> > +	uint32_t ch_inst         =3D 0;
> > +	int ret =3D 0;
> > +
> > +	if (adev->umc.node_inst_num) {
> > +		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> > ch_inst) {
> > +			ret =3D func(adev, node_inst, umc_inst, ch_inst, data);
> > +			if (ret) {
> > +				dev_err(adev->dev, "Node %d umc %d ch %d
> > func returns %d\n",
> > +					node_inst, umc_inst, ch_inst, ret);
> > +				return ret;
> > +			}
> > +		}
> > +	} else {
> > +		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
>=20
> >[Tao] for ASIC which doesn't support node, can we set its=20
> >node_inst_num to 1
> and retire the macro LOOP_UMC_INST_AND_CH?
>=20
> [Thomas] I am afraid not.
>=20
> 	" #define LOOP_UMC_NODE_INST(node_inst) \
> 		for_each_set_bit((node_inst), &(adev->umc.active_mask),
> adev->umc.node_inst_num) "
>=20
> 	The node instance loop of LOOP_UMC_EACH_NODE_INST_AND_CH supports=20
> node harvest, so node_inst_num is not the real node instance number.

[Tao] we can set both node_inst_num and active_mask to 1, but either way is=
 fine for me.
BTW, I think amdgpu_umc_loop_channels  is simple than amdgpu_umc_scan_all_u=
mc_channels, with this fixed, the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>=20
>=20
> > +			ret =3D func(adev, 0, umc_inst, ch_inst, data);
> > +			if (ret) {
> > +				dev_err(adev->dev, "Umc %d ch %d func
> > returns %d\n",
> > +					umc_inst, ch_inst, ret);
> > +				return ret;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > index d7f1229ff11f..f279c8057f96 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> > @@ -47,6 +47,10 @@
> >  #define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst,
> ch_inst)
> > \
> >  		LOOP_UMC_NODE_INST((node_inst))
> > LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
> >
> > +
> > +typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst=
,
> > +			uint32_t umc_inst, uint32_t ch_inst, void *data);
> > +
> >  struct amdgpu_umc_ras {
> >  	struct amdgpu_ras_block_object ras_block;
> >  	void (*err_cnt_init)(struct amdgpu_device *adev); @@ -104,4 +108,7=20
> > @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
> >  		struct amdgpu_iv_entry *entry);
> >  int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> >  			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
> > +
> > +int amdgpu_umc_scan_all_umc_channels(struct amdgpu_device *adev,
> > +			umc_func func, void *data);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> > b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> > index fb55e8cb9967..6dff313ac04c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> > @@ -76,10 +76,13 @@ static inline uint32_t=20
> > get_umc_v8_10_reg_offset(struct amdgpu_device *adev,
> >  		UMC_8_NODE_DIST * node_inst;
> >  }
> >
> > -static void umc_v8_10_clear_error_count_per_channel(struct
> > amdgpu_device *adev,
> > -					uint32_t umc_reg_offset)
> > +static int umc_v8_10_clear_error_count_per_channel(struct
> > +amdgpu_device
> > *adev,
> > +					uint32_t node_inst, uint32_t umc_inst,
> > +					uint32_t ch_inst, void *data)
> >  {
> >  	uint32_t ecc_err_cnt_addr;
> > +	uint32_t umc_reg_offset =3D
> > +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
> >
> >  	ecc_err_cnt_addr =3D
> >  		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt); @@
> > -87,24 +90,14 @@ static void
> > umc_v8_10_clear_error_count_per_channel(struct amdgpu_device *adev,
> >  	/* clear error count */
> >  	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
> >  			UMC_V8_10_CE_CNT_INIT);
> > +
> > +	return 0;
> >  }
> >
> >  static void umc_v8_10_clear_error_count(struct amdgpu_device *adev)  {
> > -	uint32_t node_inst       =3D 0;
> > -	uint32_t umc_inst        =3D 0;
> > -	uint32_t ch_inst         =3D 0;
> > -	uint32_t umc_reg_offset  =3D 0;
> > -
> > -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> > {
> > -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> > -						node_inst,
> > -						umc_inst,
> > -						ch_inst);
> > -
> > -		umc_v8_10_clear_error_count_per_channel(adev,
> > -						umc_reg_offset);
> > -	}
> > +	amdgpu_umc_scan_all_umc_channels(adev,
> > +		umc_v8_10_clear_error_count_per_channel, NULL);
> >  }
> >
> >  static void umc_v8_10_query_correctable_error_count(struct
> > amdgpu_device *adev, @@ -147,29 +140,29 @@ static void=20
> > umc_v8_10_query_uncorrectable_error_count(struct amdgpu_device *adev
> >  		*error_count +=3D 1;
> >  }
> >
> > +static int umc_v8_10_query_ecc_error_count(struct amdgpu_device *adev,
> > +					uint32_t node_inst, uint32_t umc_inst,
> > +					uint32_t ch_inst, void *data)
> > +{
> > +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> > +	uint32_t umc_reg_offset =3D
> > +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
> > +
> > +	umc_v8_10_query_correctable_error_count(adev,
> > +					umc_reg_offset,
> > +					&(err_data->ce_count));
> > +	umc_v8_10_query_uncorrectable_error_count(adev,
> > +					umc_reg_offset,
> > +					&(err_data->ue_count));
> > +
> > +	return 0;
> > +}
> > +
> >  static void umc_v8_10_query_ras_error_count(struct amdgpu_device *adev=
,
> >  					   void *ras_error_status)
> >  {
> > -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_st=
atus;
> > -
> > -	uint32_t node_inst       =3D 0;
> > -	uint32_t umc_inst        =3D 0;
> > -	uint32_t ch_inst         =3D 0;
> > -	uint32_t umc_reg_offset  =3D 0;
> > -
> > -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> > {
> > -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> > -						node_inst,
> > -						umc_inst,
> > -						ch_inst);
> > -
> > -		umc_v8_10_query_correctable_error_count(adev,
> > -						umc_reg_offset,
> > -						&(err_data->ce_count));
> > -		umc_v8_10_query_uncorrectable_error_count(adev,
> > -						umc_reg_offset,
> > -						&(err_data->ue_count));
> > -	}
> > +	amdgpu_umc_scan_all_umc_channels(adev,
> > +		umc_v8_10_query_ecc_error_count, ras_error_status);
> >
> >  	umc_v8_10_clear_error_count(adev);
> >  }
> > @@ -248,28 +241,28 @@ static void
> > umc_v8_10_convert_error_address(struct
> > amdgpu_device *adev,
> >  	}
> >  }
> >
> > -static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
> > -					 struct ras_err_data *err_data,
> > -					 uint32_t umc_reg_offset,
> > -					 uint32_t node_inst,
> > -					 uint32_t ch_inst,
> > -					 uint32_t umc_inst)
> > +static int umc_v8_10_query_error_address(struct amdgpu_device *adev,
> > +					uint32_t node_inst, uint32_t umc_inst,
> > +					uint32_t ch_inst, void *data)
> >  {
> >  	uint64_t mc_umc_status_addr;
> >  	uint64_t mc_umc_status, err_addr;
> >  	uint64_t mc_umc_addrt0;
> > +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> > +	uint32_t umc_reg_offset =3D
> > +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
> >
> >  	mc_umc_status_addr =3D
> >  		SOC15_REG_OFFSET(UMC, 0,
> > regMCA_UMC_UMC0_MCUMC_STATUST0);
> >  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> > umc_reg_offset) * 4);
> >
> >  	if (mc_umc_status =3D=3D 0)
> > -		return;
> > +		return 0;
> >
> >  	if (!err_data->err_addr) {
> >  		/* clear umc status */
> >  		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL);
> > -		return;
> > +		return 0;
> >  	}
> >
> >  	/* calculate error address if ue error is detected */ @@ -287,37
> > +280,25 @@ static void umc_v8_10_query_error_address(struct
> > amdgpu_device *adev,
> >
> >  	/* clear umc status */
> >  	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
> > +
> > +	return 0;
> >  }
> >
> >  static void umc_v8_10_query_ras_error_address(struct amdgpu_device *ad=
ev,
> >  					     void *ras_error_status)
> >  {
> > -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_st=
atus;
> > -	uint32_t node_inst       =3D 0;
> > -	uint32_t umc_inst        =3D 0;
> > -	uint32_t ch_inst         =3D 0;
> > -	uint32_t umc_reg_offset  =3D 0;
> > -
> > -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> > {
> > -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> > -						node_inst,
> > -						umc_inst,
> > -						ch_inst);
> > -
> > -		umc_v8_10_query_error_address(adev,
> > -					err_data,
> > -					umc_reg_offset,
> > -					node_inst,
> > -					ch_inst,
> > -					umc_inst);
> > -	}
> > +	amdgpu_umc_scan_all_umc_channels(adev,
> > +		umc_v8_10_query_error_address, ras_error_status);
> >  }
> >
> > -static void umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device
> *adev,
> > -					      uint32_t umc_reg_offset)
> > +static int umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *ad=
ev,
> > +					uint32_t node_inst, uint32_t umc_inst,
> > +					uint32_t ch_inst, void *data)
> >  {
> >  	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
> >  	uint32_t ecc_err_cnt_addr;
> > +	uint32_t umc_reg_offset =3D
> > +		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
> >
> >  	ecc_err_cnt_sel_addr =3D
> >  		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCntSel);
> @@ -332,23
> > +313,14 @@ static void umc_v8_10_err_cnt_init_per_channel(struct
> > amdgpu_device *adev,
> >  	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,=20
> > ecc_err_cnt_sel);
> >  	/* set error count to initial value */
> >  	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,=20
> > UMC_V8_10_CE_CNT_INIT);
> > +
> > +	return 0;
> >  }
> >
> >  static void umc_v8_10_err_cnt_init(struct amdgpu_device *adev)  {
> > -	uint32_t node_inst       =3D 0;
> > -	uint32_t umc_inst        =3D 0;
> > -	uint32_t ch_inst         =3D 0;
> > -	uint32_t umc_reg_offset  =3D 0;
> > -
> > -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> > {
> > -		umc_reg_offset =3D get_umc_v8_10_reg_offset(adev,
> > -						node_inst,
> > -						umc_inst,
> > -						ch_inst);
> > -
> > -		umc_v8_10_err_cnt_init_per_channel(adev, umc_reg_offset);
> > -	}
> > +	amdgpu_umc_scan_all_umc_channels(adev,
> > +		umc_v8_10_err_cnt_init_per_channel, NULL);
> >  }
> >
> >  static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device
> > *adev) @@ -406,37 +378,35 @@ static void=20
> > umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdgpu_dev
> >  	}
> >  }
> >
> > +static int umc_v8_10_ecc_info_query_ecc_error_count(struct
> > +amdgpu_device
> > *adev,
> > +					uint32_t node_inst, uint32_t umc_inst,
> > +					uint32_t ch_inst, void *data)
> > +{
> > +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> > +
> > +	umc_v8_10_ecc_info_query_correctable_error_count(adev,
> > +					node_inst, umc_inst, ch_inst,
> > +					&(err_data->ce_count));
> > +	umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
> > +					node_inst, umc_inst, ch_inst,
> > +					&(err_data->ue_count));
> > +	return 0;
> > +}
> > +
> >  static void umc_v8_10_ecc_info_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  					void *ras_error_status)
> >  {
> > -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_st=
atus;
> > -
> > -	uint32_t node_inst       =3D 0;
> > -	uint32_t umc_inst        =3D 0;
> > -	uint32_t ch_inst         =3D 0;
> > -
> > -	/* TODO: driver needs to toggle DF Cstate to ensure
> > -	 * safe access of UMC registers. Will add the protection
> > -	 */
> > -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> > {
> > -		umc_v8_10_ecc_info_query_correctable_error_count(adev,
> > -							node_inst, umc_inst,
> > ch_inst,
> > -							&(err_data-
> > >ce_count));
> > -		umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
> > -							node_inst, umc_inst,
> > ch_inst,
> > -							&(err_data-
> > >ue_count));
> > -	}
> > +	amdgpu_umc_scan_all_umc_channels(adev,
> > +		umc_v8_10_ecc_info_query_ecc_error_count,
> > ras_error_status);
> >  }
> >
> > -static void umc_v8_10_ecc_info_query_error_address(struct
> > amdgpu_device *adev,
> > -					struct ras_err_data *err_data,
> > -					uint32_t ch_inst,
> > -					uint32_t umc_inst,
> > -					uint32_t node_inst)
> > +static int umc_v8_10_ecc_info_query_error_address(struct
> > +amdgpu_device
> > *adev,
> > +					uint32_t node_inst, uint32_t umc_inst,
> > +					uint32_t ch_inst, void *data)
> >  {
> >  	uint32_t eccinfo_table_idx;
> >  	uint64_t mc_umc_status, err_addr;
> > -
> > +	struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> >  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> >
> >  	eccinfo_table_idx =3D node_inst * adev->umc.umc_inst_num * @@ -
> > 447,10 +417,10 @@ static void
> > umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
> >  	mc_umc_status =3D ras-
> > >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> >
> >  	if (mc_umc_status =3D=3D 0)
> > -		return;
> > +		return 0;
> >
> >  	if (!err_data->err_addr)
> > -		return;
> > +		return 0;
> >
> >  	/* calculate error address if ue error is detected */
> >  	if (REG_GET_FIELD(mc_umc_status,
> > MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 && @@ -463,28 +433,15
> @@ static
> > void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device=20
> > *adev,
> >  		umc_v8_10_convert_error_address(adev, err_data, err_addr,
> >  					ch_inst, umc_inst, node_inst,
> > mc_umc_status);
> >  	}
> > +
> > +	return 0;
> >  }
> >
> >  static void umc_v8_10_ecc_info_query_ras_error_address(struct
> > amdgpu_device *adev,
> >  					void *ras_error_status)
> >  {
> > -	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_st=
atus;
> > -
> > -	uint32_t node_inst       =3D 0;
> > -	uint32_t umc_inst        =3D 0;
> > -	uint32_t ch_inst         =3D 0;
> > -
> > -	/* TODO: driver needs to toggle DF Cstate to ensure
> > -	 * safe access of UMC resgisters. Will add the protection
> > -	 * when firmware interface is ready
> > -	 */
> > -	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst)
> > {
> > -		umc_v8_10_ecc_info_query_error_address(adev,
> > -						err_data,
> > -						ch_inst,
> > -						umc_inst,
> > -						node_inst);
> > -	}
> > +	amdgpu_umc_scan_all_umc_channels(adev,
> > +		umc_v8_10_ecc_info_query_error_address, ras_error_status);
> >  }
> >
> >  const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops =3D {
> > --
> > 2.34.1
