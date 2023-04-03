Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1091DC76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 07:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DE210E161;
	Mon,  3 Apr 2023 07:21:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B65B10E161
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 07:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmLlpDw4wipWyEYgeOx4L19dYmKmTjzD5rhGBw9/k4M/5Lf1y5QiSUikCI7VAnFnOv0Imj8cngeLzcMKDbkuEMgRL1tHLEqUGYiY9HkTMEEehsZZg5pTCLPXXmRjtaSoRE2lwVhtJrgIOKD/JJmDC9h2YhTlyXatKBiwPgD94avo8tkslW3AbAz8DEtHQrtb/cYkMmZC/zyCNBw8Zaq0XrAsa5F5yTZSiPJd1q0dHhKR8Qa14xEiAqrqrrGsfD7VXRttGI797PxFnkkiLPSfEwjZ1z8dlBqDu7e94ikiF4iyhHBWjvx5BjTgfnLlDm5WhCH09TLCledZwWLpnp1uZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gbl8dCc/IsRTuCFlpVxRfl3cNdLelIsGpQ0OGr+3YA=;
 b=hZ/arduPvCDMcz8FCUMFZcldHFAXiXUWVofoUOwQoaomgmGbKWWKx60to+nw8QXxy2Qd/lI1HjyxhG/xDWHDPVkFguviJmYW40ODThKigM7KLYYxlU/4VZ0SAn/k4xhmYAbpOJDcasDY2ObdXEbh119Were9XBy7zwO7XXsGZb4CY5DwZGGa11gVtylcmP0uxmx836ZuOYihhpDR9CZCkCfEyHha7ZUHsVK8lC50Igq+LzigdyOGj5gzU3S7NpLLxPDPADx+eFEaMV3EVixgdyc6OqGSyJ4z+O+mNP1d7wMFYHKC1pJLnJ2uv4F2984GYsAx+7yYTAKyv/3InPSczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gbl8dCc/IsRTuCFlpVxRfl3cNdLelIsGpQ0OGr+3YA=;
 b=z4CffBvyOPobccgJdNQxS1Zmyvx+EeTzeiH5vH5De86s+k541C1rEsJzXRWkZi/CjK8Y6uK5tSL2ZHEYXqWGIcbhI3BuXRGzIwgEsWtq0jDsf1pFwSHhP47xOFsxKgX8G+TGziF15E70ehVO6uXQykdDCAcv0LOJshdGad7CSXk=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:21:06 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::e69d:78b6:152a:710c]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::e69d:78b6:152a:710c%6]) with mapi id 15.20.6254.032; Mon, 3 Apr 2023
 07:21:05 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Topic: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Thread-Index: AQHZZdBDIUgu9N2Ud0KJhtP8yMnXRq8Y8MrQgAA3ewCAAAS0kA==
Date: Mon, 3 Apr 2023 07:21:05 +0000
Message-ID: <CY4PR12MB176763A1F9B4F74D76F37008B0929@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
 <DM5PR12MB1770077FD7D17A141B9D608CB0929@DM5PR12MB1770.namprd12.prod.outlook.com>
 <CH2PR12MB42153455C15B4151D1FE6281FC929@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42153455C15B4151D1FE6281FC929@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-03T07:21:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77aa5156-25a5-4735-a093-69ee1d4e4933;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-03T07:21:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e160b795-25c9-4705-9523-7a52a065640c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR12MB1767:EE_|DM4PR12MB5149:EE_
x-ms-office365-filtering-correlation-id: a3965c32-ed05-4c39-7e22-08db3413fd00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRLDwTIFONpJY8ZZwSX0ujqz0mwo/HvZiRs6M24LUeKA7YKXxaPYdrjVm7W503XqHzkt5tajKtKDbTswf8WSvpWF6scSRadk/mcivyEjBUXtJGxEOuP5h0a/NYPTJnNQGpjeEFvvr9Kwd7QcjP2y7a8JGBV68DxP2TSpOLO5LSd2AnN9+pLLn3KQ5NtID2fF28Fyo5glsjjt49JQBN209QMeImK7uFXPJpCe6G5QUDvSC0Vg/Ifk3swbUXSLr+f47dHmrx+ulO0lNkPLJAIdQ6DS8K+viwU7Nylg/6qkhhG043FOBJAO5B92XuLkndQM3j9XRgIVNpJ6D/HqIhLyjM44cQ+lSwSYStfmFZSmCaJjpur9uHz8xfuzXiI27HZYljHAZKNzeHW2UcUeNgdMhxr96Ar4sAVEwH4eOPw7bKUZuae4JZbMoRS1eWXOso/0lgmfgfjpMUZ3WSrcz1DWNmfPm3N/esQWSoaqA3KIMIVXQX2unF0NlK6ZcJ2f03UhPE2MoCU23pN468LoEWJD9ZvL8q3Z0lVE/FfSXM/cibhDPoCZm3E1Bjj8RanDNOkbWj1f2Cq0sP95SRu9oVQcatuB4huW2vOsalXci7zxFOg8eNd2MyrzRz4vrzeB4w93
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(55016003)(186003)(26005)(53546011)(8936002)(30864003)(2906002)(5660300002)(86362001)(38070700005)(9686003)(478600001)(66556008)(66946007)(76116006)(54906003)(66476007)(4326008)(316002)(110136005)(52536014)(83380400001)(6506007)(41300700001)(38100700002)(33656002)(122000001)(71200400001)(7696005)(8676002)(64756008)(66446008)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U7zEAzo1FyUwIKK4WUlGZxy9o+GaxtSPEFY3JtzF5IkAcy3cOm4rMopXFCPW?=
 =?us-ascii?Q?IuMrCRF/xGIYAH53emX4IiaQy2I42rpbfAdt/xlKNCf8DJIbwqhBIw/DHTgi?=
 =?us-ascii?Q?/p9d2vBu8J441CEZt0JjR/XmKXsKRsiG4SzGs6mF2K+Y4zOFy2S1TnVpZyb/?=
 =?us-ascii?Q?A3wGj2hrpIut+9x+1/WRQCvFddtwQaGTJEtCy5Y4nzXvlHo5LWrKisz/2rl4?=
 =?us-ascii?Q?yYN5h/0Af/M1RNUWF3fsyxRM0pmVCF2dnegxoYIPXvaK3tOHgAlVDbwVi6fj?=
 =?us-ascii?Q?VISDfaBWtlXJ8O2jFmKQr4V8etHq27uktz3qBw4vEPRwJk3rhG5v1HmilcCw?=
 =?us-ascii?Q?Um2CLK/sITzlJDvazKNTBWKPQubcvuHxQ4MnEyM2rpaUXpJpgary+j/MzBGz?=
 =?us-ascii?Q?OYoDogGick17AhIIohx2ysiiKnjtkJvpvVHiuTcrGROqgcSrtXwDRHgAsXqj?=
 =?us-ascii?Q?jZJyGWhe7YsMV1lnoCHg8PKBbx4dqBuOzASIQ4f2UOb5otjASNOyJrFU3Qyo?=
 =?us-ascii?Q?wTGVdpf6DBcn55oFknFjTSn1qAZV9JnyF6sYh84Zm24PcQ746OiwQQ7EJXA0?=
 =?us-ascii?Q?AGF4aA4VHBnQphMutZeeX/conivPTtphNREPWkidAb4IDMjYoCTv55Q6k0QJ?=
 =?us-ascii?Q?tiSJtP0iwVMxXdg+TuXEq9PPTzWW/pWyekOLeuGIxZo4mGhCu951fyRFIQCg?=
 =?us-ascii?Q?EvYrIC8DJ9NK1700S/v9gmjlm0qY4ptuOs/qY1HIVPA/F1Q6WLY7fPpJN5qt?=
 =?us-ascii?Q?oW1SQ1mIBCBzmtKtKLf+oSAm8Oh3UDeAkpRzr6hOgU9/uRk4WScjia+dVwKo?=
 =?us-ascii?Q?BtYoEV+ZtuUMBkUB4ifTRlFBpug0TWhUTn5Kyu7RDstxGN3yOGACiYdSN+m2?=
 =?us-ascii?Q?A21u38rldeko3jCSULvLogNY46vTuMA14aA3PMAWDLHF5iXqSxU3owiD8H/s?=
 =?us-ascii?Q?6pmWReZbWoKM3Mkhq9k+nOSn6HwP7ABH3T8aAcPeRor4Qpmz7RXsJ4URcT/Z?=
 =?us-ascii?Q?NoeDuWyNIT6JcR+loeK848jqou7WZe/VV197oS2WoO362mqEW4fcgd5DPB3E?=
 =?us-ascii?Q?cNP+Gt/5Rt9CJYMOAruA7hkShgkQD6Ozxs78DQUheFdczQUbfOOj7vnbnGSF?=
 =?us-ascii?Q?ysLUOKO85S8Qpqn/SAjK0axfUOwy9g+gHDVT9OrmZYIbGhOmP4JVde5eveMn?=
 =?us-ascii?Q?tMb4YEoGhAUA1mh+VkT1mr5Nf0CngxkdCn3K058cv9fs63CGyHW+NKpJKlZx?=
 =?us-ascii?Q?9/BjEuK2/RWmzEFmAf2fff+ETaOd+ms7uysZoQkjPIY86Kf4F+IdeaN5/mlV?=
 =?us-ascii?Q?L+nu6dpknHE2HOXHC2k39mU+fcM51cT+OO4LAkjGkobYNkFDiAwLjhi/Eps0?=
 =?us-ascii?Q?0+EUjl9xu0aIwJOIRDd0pwZCSYKx4+EzY4kBEKMs7KUKBu4uqxz0vQooLPh0?=
 =?us-ascii?Q?M0iHzQBCUKXV69brzec61lp+utW9vPUZbRA3xldSJNZqRO2xOeT+kkrk66gl?=
 =?us-ascii?Q?Ym/BNgzXWTv3Y5y2Jt+egacPy09xcYqq3DWVYnM6eKLp3pU3aqI04M8UQB4c?=
 =?us-ascii?Q?nIqe9tR5Cs4c0MNIETs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3965c32-ed05-4c39-7e22-08db3413fd00
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 07:21:05.6461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8wt/4vnw0/PEcH+8n6kbYKeuxPh3on7OOyuavlXbFnD3T7OnuUNFvSh/1dbGVVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, April 3, 2023 3:00 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
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
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Monday, April 3, 2023 9:59 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Candice
> > <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> > Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
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
> >[Tao] for ASIC which doesn't support node, can we set its node_inst_num =
to 1
> and retire the macro LOOP_UMC_INST_AND_CH?
>=20
> [Thomas] I am afraid not.
>=20
> 	" #define LOOP_UMC_NODE_INST(node_inst) \
> 		for_each_set_bit((node_inst), &(adev->umc.active_mask),
> adev->umc.node_inst_num) "
>=20
> 	The node instance loop of LOOP_UMC_EACH_NODE_INST_AND_CH
> supports node harvest, so node_inst_num is not the real node instance num=
ber.

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
> >  	void (*err_cnt_init)(struct amdgpu_device *adev); @@ -104,4 +108,7
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
> > @@ -76,10 +76,13 @@ static inline uint32_t
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
> > amdgpu_device *adev, @@ -147,29 +140,29 @@ static void
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
> >  	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
> > ecc_err_cnt_sel);
> >  	/* set error count to initial value */
> >  	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
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
> > *adev) @@ -406,37 +378,35 @@ static void
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
> > void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device
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
> > 2.34.1=
