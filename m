Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAC6C369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 03:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E9010E035;
	Wed, 30 Apr 2025 03:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYBqHOKE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD9010E035
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 03:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAiP1B0Bop0gjLyvqf7Ej9E5u3BEjpcrybnUCKgPKgLuDvtE9orAGrkBpJ8V5s8R9gnNDxKW28YkDqzxMmRUPhaEAWImngQw2jitm60kmtV8lJrAuwB0E1OILJhts8ZJvj+DIz7k9z1NVC+6vLta4e/1fB3Iou6YNlI0McMx9ZRW3O5gSD62/0v880Q3eBu2zWfF2xG+pWXSztT9S2+AzcJd3nY3KAz0+JaYErUE0jGicGEwtNyHTS1foR+DmNlHhnKAPqntcn/+9m1aIJDeT1Ad9GqX7SjGfcicbS6bc3LatDOl2w5br9Gud+VpxHUZiYr+EhfCuI9TjsOY9YWLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqfPhb0q4A5dMhGJznjIqGYf3xrJaECuLFl14iXk0cg=;
 b=W1S6ONl/dCdPN6+iujp8zwIPGTXWUVtZaIB57T6FLjinkaD97Te05VBprDbjTnsNy9ABR57a+gw8K/aUlV4MTMTf4WLdflP1JLftNgdJc3ysDZc4BhFRBknBuTnbXVfuJVcFCPPq+VzF07HeI4kSmTy0l+dSPReKo2Od5AStug6khUD7HGZQ0RtSNGqP+ssPlfYazlCU0F0lJOA4ujLbY/kXYaTayZB7L+U6FFIasBK5Vn4ctbL4xhPgfowG2zS8Y4hCQeFTana3FRHgBnP1yBPnpWvBwd2AbYNRmHXGzYI380hqpnDvfC+oPX+ByrgivDzkexIJyuakC2wtgJEYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqfPhb0q4A5dMhGJznjIqGYf3xrJaECuLFl14iXk0cg=;
 b=AYBqHOKEYX2LWZA32cAXA/NXua4MLynRVezEFP+9Z21QQcigEhvZabvzncfnRXrvUa9ZElgYI6kWNRPYWTSHBXW86SzKJXsakn+kI+l2DFT7gLBVB4WaylkDlNyAQAQQtMKnFjoyKdWIau+sVWi8V3UkWRu5cbxU5F1u/o8TWJQ=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 03:03:54 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 03:03:54 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Topic: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Index: AQHbuNSUANFmmHij/Ui8QLmjMrpo87O6VoAAgAABLtCAABPYgIABGc3w
Date: Wed, 30 Apr 2025 03:03:54 +0000
Message-ID: <MW5PR12MB56844DEA086BDFEF16EDEF77E5832@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20250429070121.299873-1-ganglxie@amd.com>
 <PH7PR12MB8796DF080D6D991A7CC37ABBB0802@PH7PR12MB8796.namprd12.prod.outlook.com>
 <MW5PR12MB5684B2000B58EB14048AC397E5802@MW5PR12MB5684.namprd12.prod.outlook.com>
 <PH7PR12MB8796271082C5FDFCE2982FC5B0802@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796271082C5FDFCE2982FC5B0802@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=277a55aa-6944-400b-8930-8ac0888aa38b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T08:51:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|MN2PR12MB4454:EE_
x-ms-office365-filtering-correlation-id: 4610a4dd-186a-4ced-cea3-08dd8793a45a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uws/mhdkUbH5loFqp3Qn2CjGLkpFtfjkrAKARtelRORp/wKk366GjpaT7f72?=
 =?us-ascii?Q?GYpJskfS6xqSYzmfFN6tZwI/iiC7rqA3L7J3JmvXTodCzgmQF2q8GFhHgYuJ?=
 =?us-ascii?Q?etQnjLWOLWXSmuq75/MJDCwMFEUZ3ZVSAttsil8RnZwPF+49N6idljwaQ5x5?=
 =?us-ascii?Q?iuEWol0juZS96SdfAvoWk1btRfEoOg1ApFSU5TEG2Q45BHJpZ5u0APSJuUBJ?=
 =?us-ascii?Q?Z3owlwU5+Jab1SW2+pulMaPTv0dRIRboJ6oEIZGCUmyH4gQDFrRcXTgGWNZU?=
 =?us-ascii?Q?JpbAHHxEixC4ZuTlEfRngFq1y3x7CO6koT3eFAqIN6/e0DlOONNjkAWR2QCG?=
 =?us-ascii?Q?Tmd9NhmWAwtmlAiermDWcH53UOOWBOgXSPG9ta5X3xQwfa52ZhmROFqkWQV9?=
 =?us-ascii?Q?hgQCHwgYPxhSBiu+FUxCy2Nd8KaAU0D5YnrGWU/aQoaelhPC6cGQANJAbfQ6?=
 =?us-ascii?Q?4LcGnrNh/DJ05GayUW8Cui/QopDzO4i8R0RLJ9cU5LoGI60XNjYlQ0J32mlv?=
 =?us-ascii?Q?m16Lxhwb1rlbNd8Kyt6o13iWicyoOhIPHh9LN7MmX37A0p+G853ZQAVIJiTj?=
 =?us-ascii?Q?fhInu25hH3go6WTUia8GtveIeKruesYF2My4nhX+ofyOTfW871YwK3s4Dgc7?=
 =?us-ascii?Q?q3F2N3AoybtMd1EQUMo+F8DYOE6qkGO8h3bSwisnVdPJ5Te+YVsirOt0Eszv?=
 =?us-ascii?Q?CK67Ef2GDaPGoM4L2wqObMwE2ytW5e2lguPwUU1iRhXqowYJ8ljAOcv3qmhF?=
 =?us-ascii?Q?FzA/LwUWpecTRgMaxGXddcs4tbCFsV89wJ+9ZfumdvXYe8+h7o5vwSwrP6Ob?=
 =?us-ascii?Q?XZvNsJk3J/dF2bPohPQPARA236hwufNjfwOKULtO+hZbYmDzKtXSnaHLy+se?=
 =?us-ascii?Q?oBDpsuHn7f/zuVGRX/auJKwdcF9aonBPdc/O2hA12js925VA48pXkZay36Nb?=
 =?us-ascii?Q?4XmX9rCu0qiJplXGFZFaik3d9qsbbOzOssRmLQi3nIKRB7wIBDWHrPSik9HX?=
 =?us-ascii?Q?4LL2qworuXINyNiz23eHs6/OHjnNp7zjAj8sGdVoBUuveFHNy2XbHO2YXuDk?=
 =?us-ascii?Q?bJESev9x9cRGlPkNO1LWK3gYXZtTB2l7J9Rodd+V9PWpI0ZIO0dJeCKKP97m?=
 =?us-ascii?Q?O7slfj9CNbb7Kwu4rXTCjznexJ3FjC35V8cs+w+r3vTDzHqe7ExxJmqTh06M?=
 =?us-ascii?Q?08U6g8Gk2A0C7PUMpB6wwBkEJO9zJhgYOm+BQxtF8QFN0JN1q6lUggXfdYZP?=
 =?us-ascii?Q?WjW3Bb+TP0GPkbz13SWO2eTTR+3pzLx9zGmwtrxlc1VWZsXb9Y7AsWkSsfuW?=
 =?us-ascii?Q?gUz/hSnLKFNpVGh2udLSSjgMa2pzaivl/82B8yAfd0lAvshTP/f6F8m1DBjN?=
 =?us-ascii?Q?9jqDJsbtIfW8bBgViElJGhs1n0ZuIRbjyIsg/7XcTvf2mknki/ciaFcsm4Gm?=
 =?us-ascii?Q?G1N/zLlgIQVYbCT+vniWcbuj9YZsfP9ebZC5gfZUdL1iWCgA/oAo9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqj/XNNVyw0NjpVUAi1giKlnXRipGBVaoZ+al7TzDRinkrQBuMNXYraAz94J?=
 =?us-ascii?Q?8kfihhDu3BBtcuis3ff4vrjmaUUGQem2Zz2XzAwC6HctwZIx+z/e4XbPPz0Y?=
 =?us-ascii?Q?ii01dOtJkQxiqoehrZPouOT3RAs80H1NXqik6mQ9JjjPDPiGj09PrSArWEGr?=
 =?us-ascii?Q?eT/dkOdOOu8+aviEo5TiSTjHubXAYcnYENwRLP6nKvnFPz36h1cuy2LRDzqQ?=
 =?us-ascii?Q?2JJliT7+p5XElK9ozJRRmT6fTFpVdLkfu8rMUzDn+9/UyowHpv/V0HxrPvzN?=
 =?us-ascii?Q?GI4pBaV1+25K3AZh+jcjHjfJQPWcTHuAVAqLJAjt3l6PmuEtSEA0RVi7Tnnk?=
 =?us-ascii?Q?+HzExI7K9tGP4aTFWg7/loVZRXB1eeibAA0Ld1jOKTKNtEP/o9fS/DVTzcJ5?=
 =?us-ascii?Q?gGQdmJOBJi74ZuHZ7ENDRpZgbFvlANZcEv2YOMfSLpsqMEiLK/fjoXI7LoPG?=
 =?us-ascii?Q?cPoy8J5DQwHnDrSNMlkUv+A3gPNGxlzSedB/LUJOqcFG+s34/Gccn+9hkYhx?=
 =?us-ascii?Q?x//Rd+uoRlF3M2z5ag/eP5aOpG9k7+yUSQnWMQXg0tr6URc9RNM6c12SdDZ+?=
 =?us-ascii?Q?QZw5MaF7KOyfB3NdtBGcuMZ1wZh/vIPNJmeJtyJVJFVITTm6VLJ65MQZkcqM?=
 =?us-ascii?Q?8tscVH/P+o2yhbNe5c6iwG5HCq7MYI4Sg5Z2xpQFHJ3igGe+hMOyJLo9vBsl?=
 =?us-ascii?Q?kCLFvhxjyNarai4R5mBXDNlRGJXNM303cEgwaViKn/ZKm/+Q63/4Va1bqB0c?=
 =?us-ascii?Q?Baa6yaTF7BHJRY6CXvQAApoPL/2g7+qDKNdG+6UqcjojzO1nslDgjCXZ1HBT?=
 =?us-ascii?Q?q4OxUxZs4CPfZMi76CjrLRL1iqn/57geri6mOnLGxxmqa6RBuF85r6buD5z4?=
 =?us-ascii?Q?VTJWFMJrpT7+Z5YTfIU/TVv9eUmGMRnYY1YC1CD7A4cadJ++P26v7VLKlt98?=
 =?us-ascii?Q?jOXFTAOz6pzUio+GaLmjV1mAc9qx6meIuxXaMqBuPBBLDrFcb09RG2wpAeWz?=
 =?us-ascii?Q?/8K50477PQl5fiahs9Dt9IAGKe02CToIlAHtBjPtLRfyMFEPAezxFjK1p5kU?=
 =?us-ascii?Q?4gpLH6aenbHu2KmsZOtDumK6pWG0+lm9FZK1Qwfkgknqy4YP5+yWdUr3PqJ9?=
 =?us-ascii?Q?JtMc5xFNLxZgtW9ob356L9IDPd681VK0sa/NTKjxxV+VDoppw4pacr+4bfD9?=
 =?us-ascii?Q?ytcb6xbYDkkWJyKc7zA9XZ7L1Xf2JlSnaFy8asfv6rDNxoizZaCSeXr+D+kh?=
 =?us-ascii?Q?/EkOO9G7bhuBidmXVO5WC4pgHUebn5T4DWbwQHYFTblyLMn+lM4rqhXsdUqO?=
 =?us-ascii?Q?vgIvYGaD13sY+KKP/o8pYeP1er0l3sbrGAr+LHXsu5PAuC+30MkA1zyKW10/?=
 =?us-ascii?Q?9ia1aPest+8FicjOd5hn2AcdEZvFGQC+7ZYqor0U441TBk7Zi5fZbfSo7OtB?=
 =?us-ascii?Q?KO2d0dPJSEBkmk7I7SwS2cDr3yXUi8E4kCatpiIXoo4ZxcN6ocSSfBNTrPUd?=
 =?us-ascii?Q?m4Z8J+JssMnOyQSRgwmtmYBp2Ftct3nSuS9PlkOFVjxe9xqRKkkpRzIZq9ub?=
 =?us-ascii?Q?vlbSZp5o9c3DAC0Atoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4610a4dd-186a-4ced-cea3-08dd8793a45a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 03:03:54.3331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi+qfSLdxjdX6s3NRC+7wH3PMb1Sck5R96yUe+aJAItwpGeiTehufu/ZQTKZXo1vSo1wZiyS0Q8RpmXz02HXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, April 29, 2025 6:08 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, April 29, 2025 5:04 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] Add support for leagcy records in eeprom format
> V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, April 29, 2025 4:53 PM
> To: Xie, Patrick <Gangliang.Xie@amd.com>;
> amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] Add support for leagcy records in eeprom format
> V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Xie, Patrick <Gangliang.Xie@amd.com>
> > Sent: Tuesday, April 29, 2025 3:01 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> > <Gangliang.Xie@amd.com>
> > Subject: [PATCH] Add support for leagcy records in eeprom format V3
> >
> > After eeprom records format upgrades to V3, records that have
> > 'address =3D=3D 0' should be supported in NPS1
> >
> > Signed-off-by: ganglxie <ganglxie@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73
> > ++++++++++++++++---------
> >  1 file changed, 48 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index e85143acf3a2..4f4e12452ecc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2881,6 +2881,17 @@ static int
> > __amdgpu_ras_convert_rec_from_rom(struct
> > amdgpu_device *adev,
> >       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
> >       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> >
> > +     /* if address=3D=3D 0, the rec must be a PA rec under NPS1 */
> > +     if (bps->address =3D=3D 0) {
> > +             if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE) {
> > +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> > +                             bps->retired_page <<
> > AMDGPU_GPU_PAGE_SHIFT))
> > +                             return -EINVAL;
> > +                     goto out;
> > +             } else {
> > +                     return -EOPNOTSUPP;
> > +             }
> > +     }
>
> [Tao] better to add an empty line here.
> [Patrick] will add this empty line
>
> >       if (save_nps =3D=3D nps) {
>
> [Tao] is possible that both "bps->address =3D=3D 0" and "(save_nps =3D=3D=
 nps " are true?
> [Patrick]Yes, all of the "address=3D=3D0" records have save_nps=3DNPS1, s=
o
> when loading the records in NPS1, save_nps=3D=3Dnps. But it does not matt=
er, I check "address=3D=3D0"
> ahead of "save_nps=3D=3Dnps" , the code won't go to "save_nps=3D=3Dnps"'s
> checking at any case.

[Tao] so how about this if structure:

If (save_nps =3D=3D nps) {
    ...
} else {
    if (bps->address) {
        ...
    } else {
       ...
    }
}
[Patrick] Yes, it a better logic. Based on this logic, I think we can even =
abort checking "address=3D=3D0",   keep this function as before. "address=
=3D=3D0" records can be already parsed correctly in "if (save_nps=3D=3Dnps)=
" branch, and we do not have to avoid "failed to query address 0x0" warning=
, it does no harm to code logic. After this, can I change the commit messag=
e to "Refine records counting and parsing in eeprom V3"?
> >               if (amdgpu_umc_pages_in_a_row(adev, err_data,
> >                               bps->retired_page <<
> > AMDGPU_GPU_PAGE_SHIFT)) @@ -2889,6 +2900,8 @@ static int
> > __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
> >               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
> >                       return -EINVAL;
> >       }
> > +
> > +out:
> >       return __amdgpu_ras_restore_bad_pages(adev,
> > err_data->err_addr,
> >
> > adev-
> > >umc.retire_unit);
> >  }
> > @@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,
> >                       &adev->psp.ras_context.ras->eeprom_control;
> >       enum amdgpu_memory_partition nps =3D AMDGPU_NPS1_PARTITION_MODE;
> >       int ret =3D 0;
> > -     uint32_t i;
> > +     uint32_t i =3D 0;
> >
> >       if (!con || !con->eh_data || !bps || pages <=3D 0)
> >               return 0;
> > @@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,
> >       mutex_lock(&con->recovery_lock);
> >
> >       if (from_rom) {
> > -             for (i =3D 0; i < pages; i++) {
> > -                     if (control->ras_num_recs - i >=3D adev->umc.reti=
re_unit) {
> > -                             if ((bps[i].address =3D=3D bps[i + 1].add=
ress) &&
> > -                                 (bps[i].mem_channel =3D=3D bps[i + 1]=
.mem_channel)) {
> > -                                     //deal with retire_unit records a=
 time
> > -                                     ret =3D
> > __amdgpu_ras_convert_rec_array_from_rom(adev,
> > -                                                                     &=
bps[i],
> > &err_data, nps);
> > -                                     if (ret)
> > -                                             goto free;
> > -                                     i +=3D (adev->umc.retire_unit - 1=
);
> > +             /* there is no pa recs in V3, so skip pa recs processing =
*/
> > +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> > +                     for (i =3D 0; i < pages; i++) {
> > +                             if (control->ras_num_recs - i >=3D
> > + adev->umc.retire_unit)
> > {
> > +                                     if ((bps[i].address =3D=3D bps[i =
+ 1].address) &&
> > +                                             (bps[i].mem_channel =3D=
=3D
> > + bps[i +
> > 1].mem_channel)) {
> > +                                             /* deal with retire_unit =
records a time */
> > +                                             ret =3D
> > __amdgpu_ras_convert_rec_array_from_rom(adev,
> > +
> > + &bps[i],
> > &err_data, nps);
> > +                                             if (ret)
> > +
> > + control->ras_num_bad_pages -
> > =3D adev->umc.retire_unit;
> > +                                             i +=3D (adev->umc.retire_=
unit - 1);
> > +                                     } else {
> > +                                             break;
> > +                                     }
> >                               } else {
> >                                       break;
> >                               }
> > -                     } else {
> > -                             break;
> >                       }
> >               }
> >               for (; i < pages; i++) {
> >                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
> >                               &bps[i], &err_data, nps);
> >                       if (ret)
> > -                             goto free;
> > +                             control->ras_num_bad_pages -=3D adev-
> > >umc.retire_unit;
> >               }
> >       } else {
> >               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps,
> > pages); @@ -
> > 3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct
> > amdgpu_device *adev)
> >               dev_err(adev->dev, "Failed to load EEPROM table records!"=
);
> >       } else {
> >               if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)=
 {
> > -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> > -                             if ((control->ras_num_recs - i) >=3D adev=
-
> > >umc.retire_unit) {
> > -                                     if ((bps[i].address =3D=3D bps[i =
+ 1].address) &&
> > -                                             (bps[i].mem_channel =3D=
=3D bps[i +
> > 1].mem_channel)) {
> > -                                             control->ras_num_pa_recs =
+=3D adev-
> > >umc.retire_unit;
> > -                                             i +=3D (adev->umc.retire_=
unit - 1);
> > +                     /*In V3, there is no pa recs, and some
> > + cases(when
> > address=3D=3D0) may be parsed
> > +                     as pa recs, so add verion check to avoid it.
> > +                     */
> > +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3) =
{
> > +                             for (i =3D 0; i < control->ras_num_recs; =
i++) {
> > +                                     if ((control->ras_num_recs -
> > + i)
> > + >=3D adev-
> > >umc.retire_unit) {
> > +                                             if ((bps[i].address =3D=
=3D
> > + bps[i +
> > 1].address) &&
> > +
> > + (bps[i].mem_channel =3D=3D bps[i +
> > 1].mem_channel)) {
> > +
> > + control->ras_num_pa_recs +=3D
> > adev->umc.retire_unit;
> > +                                                     i +=3D (adev->umc=
.retire_unit - 1);
> > +                                             } else {
> > +
> > + control->ras_num_mca_recs +=3D
> > +
> > + (control-
> > >ras_num_recs - i);
> > +                                                     break;
> > +                                             }
> >                                       } else {
> > -                                             control->ras_num_mca_recs=
 +=3D
> > -                                                                     (=
control-
> > >ras_num_recs - i);
> > +
> > + control->ras_num_mca_recs +=3D
> > (control->ras_num_recs - i);
> >                                               break;
> >                                       }
> > -                             } else {
> > -                                     control->ras_num_mca_recs +=3D (c=
ontrol-
> > >ras_num_recs - i);
> > -                                     break;
> >                               }
> > +                     } else {
> > +                             control->ras_num_mca_recs =3D control-
> > >ras_num_recs;
> >                       }
> >               }
> >
> > --
> > 2.34.1
>
>


