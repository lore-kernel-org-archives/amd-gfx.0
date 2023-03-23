Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455DAC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 07:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08F610E463;
	Thu, 23 Mar 2023 07:44:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A676410E463
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 07:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNysvuWYEHB4SCz/7/oIsU8zfsopRqdj7cSPq9NwKZIYmQfFDaUj/cr/BL5j/JySRQBzaKXMdM9IQIaz4v+PrsB3Oj8aT/duNc/f3735jw1JyaI40W1fe8aDVPqAbldYEw2aXnpiK9wfMNx0DpTeD8D7weedQVvNjZSgoPVkZM3v4SAjJ4vG3xi+3+zP77wnRCxSQ5nvoiFjHQ9SpJkjmFKOk5IUU42tNGF9kAXy6wfj37T1gkFlbete6CrthN2+VSnzgtYbFw63Im+7cbsdW4+Ml5yx+zE/sJLGehls5sbRVe/Vw9MLGo4EQAOq6EQSUuSDDG3Hi70Pq2QA+8QxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y94HFtb8IPmN+Xj5n7DucVhBDPtEQk+yWhGFuKRfRBI=;
 b=EHW6mVD4cqqhpIacKSPzqv8zl+oYNCo12rfl0IV8c995mSypbriq2gcmJO5ddJatUX/ogILpS14iLIEaWPfpQa5UzAfS16msgccGj9V0Hg/uQYbfE65bQLnImQEtxZ9hysS5ghItutX3mwS3s7BnzH9Fb6qcNf48syWildTj/FsDFmnODAm/o/jhuZ+T1b68JOMyIceQah6c5rbdt0DUjnOs2CMSIt67QtobScsNd2Xc1mljbuVpTwWOYFqb8z+hyh/EZUmPblNYKePauD4OPdesPw/hnUgp1bTsWF1SXOn7aeNCPvrgjOHyNylPNlL9jwfw+kGpxgJgIu/l8OwXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y94HFtb8IPmN+Xj5n7DucVhBDPtEQk+yWhGFuKRfRBI=;
 b=jsQAcNdp+FAwnnkbkvA+VfF41HekWhq+9hLb7eQLahKGtGD9OElJkZrldlO0TBpnxvlMs9zfyjPzOk3lK09regusKWdlxmZeUWubTD/SWgaJjQF6d10Xa1Us7MPRUryjhUEeuI+if577yoQ78P4YjIy81KYDTmcGR51qFnbCu9s=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:43:56 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 07:43:56 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Thread-Topic: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Thread-Index: AQHZXJ7/8i8fNRCjlEmsgmjrhqS5nq8H9cGAgAAG9GA=
Date: Thu, 23 Mar 2023 07:43:56 +0000
Message-ID: <DM6PR12MB35312E40A9ECEBEA869A8DFEFD879@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-3-WenYou.Yang@amd.com>
 <DM6PR12MB2619305C4B4123F8F42BE48FE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619305C4B4123F8F42BE48FE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T07:43:54Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b5820eae-7f16-4f29-b8be-c6dfa3e4e652;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|MN2PR12MB4205:EE_
x-ms-office365-filtering-correlation-id: 3603a094-2c93-46c9-5e46-08db2b725b99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7JiCelN73POs46hSHWmxsDa1iD83TgX8xKC6eXYPBf5T/chZuLKGOWCm3LyzmgRyl9nGmiAK/2QH+Le2CDZm0sYmiHxvDRmj6pOL8Kwo8RCb+XkOZQ+o+I3NC7UoY24G6EjhXDYEOH98Swl9U0+4X1VgIDe0eB6Usyr9ICF95SWwJ4NcESyrqs/SZWFgqCN8N/li6btv+HYRNqY1HM8q28x5aO08XvL/Ln5+Ixt45kbVuPcoXuFAo7wRorECW2LQMjasXUzilU332/XmEf5TlCDy3lMP6FIL9zV+V5nVPaDoeG3Ctyj5J2p9aq4DsG+rNNOxwoxOCF5RPLQl8O7Y19d5owoy+7ExlAqLjble0oOkImK8d1xNRzeQaFbwvD5LqSk+JBy509/72ICLZBGy2u5E5npNvj5xoNyvJQSz5u1sDg2WdTmyXrq0uyeiui7UHS55mgeMgjkCJM40bf9wnYh/td/wfJ5uJo9IVzjdxYMr77T3dsGj9l8daPUrfezIMC6KdFkOV8/e7NPTNVdW9DE9NYQkduRWhYbLkoZ0FGsKwECU90iI+jxcOgQzn7IhOjF17jBhIHZqt6+/LbUf0dkV23MNmP5akjaMFVKQ6RYuhlAJ9iKNfBIJi9OsX6sWDZ4pk2ARp2E/C4U1GYI7jLmT8W5RH2/jISYTXob6ejYCMAx44rtVG5gQPsMn1Ct47UuUT0zJWNGSVlBkqteRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(66476007)(4326008)(76116006)(66446008)(8676002)(66946007)(66556008)(64756008)(316002)(110136005)(54906003)(6636002)(5660300002)(122000001)(15650500001)(41300700001)(8936002)(52536014)(53546011)(26005)(6506007)(186003)(9686003)(71200400001)(83380400001)(478600001)(7696005)(86362001)(33656002)(55016003)(38070700005)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iEVQ/AIlYplagbLlOfmqhGne8lQR34tD1tt449NtR00s1U9nIEpfouTpRfv0?=
 =?us-ascii?Q?cz4oJV3T3YC2eD23IX9mxvgJ7YiT/Mvl9HZaQWsoVFB3tZtIsWh3VlDQ1R94?=
 =?us-ascii?Q?eu73NU5Bm2JmCfWcPH1qslLAN6B03wF2WAsQaFIqQzttpKAwTB4Pb0mYw+kV?=
 =?us-ascii?Q?3k/CAetkLZadr0Tc2wKKFiS/t9Rqu2dHdTpEXVPPlvI94tEJsZ1EyTSavazo?=
 =?us-ascii?Q?iLWCVOhzfObA73FLGQYxp5zbmaTM1C7wLUQWNzA++q6w9YWuN979Fb1OJwf9?=
 =?us-ascii?Q?82Awi/tLsKuIs40RCEPyYbyxOZwS6SF0UFAv3/60+MeaoRDUd5oWl5sEX/Hm?=
 =?us-ascii?Q?N6CKG1SRrHDx9cAi8R+ZatR8t+FwDpJdC/FrcC9gJen6/1alXeZumJRS9gm5?=
 =?us-ascii?Q?SpUchaw19ILOqkuii49cC8P2o4TJeRVaC985ezeI6kgp9ekT1gZpoUu+DDaR?=
 =?us-ascii?Q?e3GySbYTdhfInzzJf7dcGv1shkPZJagi9dlC+Z70ydN6eQIL0TTqXPtxx/l5?=
 =?us-ascii?Q?jookKIQVH7vsIM7iSMyyBx15kz5dZK3ixOPLQLgSDIOeAP/tvR3bhs5G0Oia?=
 =?us-ascii?Q?qsYj6LE30JxHTQMWFXfuROmMnDZmzr3TKMBW8T7FY1LdJsGts2wlDBJ0ll2A?=
 =?us-ascii?Q?tNsdmGIJaLYxmBkHrKbiZVsOBBrVHqGDrCR3mbfPIfMmTcfhFshfTatExQgG?=
 =?us-ascii?Q?8Cs2o18MdWe+KypWfoGIP7sixYCebd+2A7PyMWx9xqEHoMEy4E9EAElgGip6?=
 =?us-ascii?Q?nw+PU8i42t8cqQTKRa62epKiktZKVgezaZH1yY0Dp4pkeYaMJmLeD9z2vLlM?=
 =?us-ascii?Q?vKGqKDHGHulgNOSmGkoiIu2S/sQn/Se1LwKEgVH9Lb9QKRfFP4/IX1U6oJvz?=
 =?us-ascii?Q?lb+jmaryfh5vV29CAIOI49fX9qUBkGyP+se1KoJrLUnQ4qxmuigeC6/rh5BV?=
 =?us-ascii?Q?yPLYYwiilztdShXechZ6GlDTNfrbFfy2plZPkizsvICY0dCbSPerFtDU1Coh?=
 =?us-ascii?Q?pl0vH3r+xgFZK2PS7sFz45P2WRI/GzVrSUlCmR5cZ2QNFc5IMiAiNEuz+twq?=
 =?us-ascii?Q?U8hTXxnurTRuEH9MZ2wvokFiRhUik9332CzzY5WMrZFajG0HSkTleu0qyG6o?=
 =?us-ascii?Q?e/iCs/VDdc9flE43T9/8NwDDWdSmA5etjP3Y6wqtc3H2IXwzV7+K39T27ct1?=
 =?us-ascii?Q?rZjDs4szIM0OdzfY+eHcXHU/sON/wjBHh6lPmDeLDm/ISg8RqhJ33iIyR/wO?=
 =?us-ascii?Q?Go5Vqb+EXh0DL7h6CS5p8aOKUDD9iqIV+xhFGEBvfpgTuW+7cU8znX1S2u+a?=
 =?us-ascii?Q?8IM9NQdxcxlJISFTvZgddyW1ByC2a7Qk4eF1PUPgpnsYiwFUqD/iRPKJSX/8?=
 =?us-ascii?Q?NMIvp47nrR4U52bGZpZYwPsvwLQx6gFLexiiD9dlcO7gfGVniZwgDQpvnP5w?=
 =?us-ascii?Q?yfE8s4GJUxZ6P0SEzSmgreBpm3fpDUHI367XemS/1HrdFpoUZqZsdfIP6k4I?=
 =?us-ascii?Q?wIhSzGU1fQ9zl1/yWxqUx2WogsbIQNfY8GksdxVodY/XFhzv+Ec+1KdV4MHE?=
 =?us-ascii?Q?1y9awEPctq/jBLC7c6U0wVsDPZ+qW9dD0apHd9dj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3603a094-2c93-46c9-5e46-08db2b725b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:43:56.5632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PitnaJ69vxTYVJgK3LHiqgqu0FE3TVuzVciRoOU0AuIsLmnTl5ZANjppHoc8FhOhOomSOCNL68Th3j1OcqBPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Thursday, March 23, 2023 3:17 PM
> To: Yang, WenYou <WenYou.Yang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Li, Ying <YING.LI@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, WenYou <WenYou.Yang@amd.com>; Liu,
> Kun <Kun.Liu2@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>
> Subject: RE: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable
> message to pmfw
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Wenyou Yang
> > Sent: Wednesday, March 22, 2023 5:16 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > Cc: Yuan, Perry <Perry.Yuan@amd.com>; Li, Ying <YING.LI@amd.com>;
> amd-
> > gfx@lists.freedesktop.org; Yang, WenYou <WenYou.Yang@amd.com>; Liu,
> > Kun <Kun.Liu2@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>
> > Subject: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable
> message
> > to pmfw
> >
> > When the CPU SMT status change in the fly, sent the SMT-enable message
> > to pmfw to notify it that the SMT status changed.
> >
> > Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41
> > +++++++++++++++++++
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index b5d64749990e..5cd85a9d149d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -22,6 +22,7 @@
> >
> >  #define SWSMU_CODE_LAYER_L1
> >
> > +#include <linux/cpu.h>
> >  #include <linux/firmware.h>
> >  #include <linux/pci.h>
> >
> > @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle,
> > uint32_t speed);  static int smu_set_gfx_cgpg(struct smu_context *smu,
> > bool enabled);  static int smu_set_mp1_state(void *handle, enum
> > pp_mp1_state mp1_state);
> >
> > +static int smt_notifier_callback(struct notifier_block *nb, unsigned
> > +long
> > action, void *data);
> > +
> > +extern struct raw_notifier_head smt_notifier_head;
> > +
> > +static struct notifier_block smt_notifier =3D {
> > +	.notifier_call =3D smt_notifier_callback, };
> By embedding smt_notifier into "struct smu_context" structure, you do not
> need this smt_notifer and current_smu below.
> You can refer to omap_dma_busy_notifier().
Accept. Thanks.

>=20
> BR
> Evan
> > +
> >  static int smu_sys_get_pp_feature_mask(void *handle,
> >  				       char *buf)
> >  {
> > @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device
> > *adev)
> >  	return 0;
> >  }
> >
> > +static struct smu_context *current_smu;
> > +
> >  static int smu_early_init(void *handle)  {
> >  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@
> > -645,6 +656,7 @@ static int smu_early_init(void *handle)
> >  	mutex_init(&smu->message_lock);
> >
> >  	adev->powerplay.pp_handle =3D smu;
> > +	current_smu =3D smu;
> >  	adev->powerplay.pp_funcs =3D &swsmu_pm_funcs;
> >
> >  	r =3D smu_set_funcs(adev);
> > @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
> >  	if (!smu->ppt_funcs->get_fan_control_mode)
> >  		smu->adev->pm.no_fan =3D true;
> >
> > +	raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
> > +
> >  	return 0;
> >  }
> >
> > @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
> >
> >  	smu_fini_microcode(smu);
> >
> > +	raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
> > +
> >  	return 0;
> >  }
> >
> > @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct
> > smu_context *smu, uint32_t size)
> >
> >  	return ret;
> >  }
> > +
> > +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool
> > +enable) {
> > +	int ret =3D -EINVAL;
> > +
> > +	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
> > +		ret =3D smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
> > +
> > +	return ret;
> > +}
> > +
> > +static int smt_notifier_callback(struct notifier_block *nb,
> > +				 unsigned long action, void *data) {
> > +	struct smu_context *smu =3D current_smu;
> > +	int ret =3D NOTIFY_OK;
> > +
> > +	ret =3D (action =3D=3D SMT_ENABLED) ?
> > +				smu_set_cpu_smt_enable(smu, true) :
> > +				smu_set_cpu_smt_enable(smu, false);
> > +	if (ret)
> > +		ret =3D NOTIFY_BAD;
> > +
> > +	return ret;
> > +}
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index 09469c750a96..7c6594bba796 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -1354,6 +1354,11 @@ struct pptable_funcs {
> >  	 * @init_pptable_microcode: Prepare the pptable microcode to
> upload
> > via PSP
> >  	 */
> >  	int (*init_pptable_microcode)(struct smu_context *smu);
> > +
> > +	/**
> > +	 * @set_cpu_smt_enable: Set the CPU SMT status
> > +	 */
> > +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
> >  };
> >
> >  typedef enum {
> > --
> > 2.39.2
