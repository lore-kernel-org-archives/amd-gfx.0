Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E674FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 06:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3616910E198;
	Mon, 20 Dec 2021 06:19:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0A110E198
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 06:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dom7kxG0xP5bmBQyerdPma5MuwJ/5UsfdgZrlHThEZqdsCD+MraDVpXzjx9NyiJFu2hii82fGeMYQ5fkXMUuln29dAFCJ+S2uA7PpGiWQJzmywfBcfO+jU77XthJUZZfBCVHGqJqmBxasSuui+JPHnpJVYJpWVF+1Nn4CuG3rLARcBv+wDD4ssa5lhHQ1sTIGbBVOTnPDxwjNbx0hZ6t2gYrTLXOB/yZmvxI5965FyWY9Uwgbkdi1sHLqeaaz8hn5n2QiRsdA39q/1Kv4Gi7IcAbrAl1S0X26Lt0QoOuB2y+ekPGrWMrPqK/DSKk8g1xmycvKLcMaLlTt0eh53X2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLcqgkPObxRMvDu5BH/NfIkEih9Lm1/b6Ahi/is/NS0=;
 b=aiEaeTZcu+ZLmS1fl6aE7h/ElYrMsKcGraeO9LJuJlORvRDtSl36EFVK5V/Mbu9pV0DrfcKpi0BA98/PBDwWgd+KnE94IcBvvDSTKh6wfACe0yl0HNR9wWxJG4zpACtwQ9ALgWat9jqAjf3Jm3mt0RivJDMfVCoO9zzAEEbIMCjskYN4RA+d2PM0y3l4JVSlwh7jWG2VXVhuhRgVGOmSlLWrKEQBmfgUtpatyHQ+MQaDqiTAVAv5dgrbKj4u/Dai0ieILJiQkQpoZKrTgZnj2RDEMf9ellUmszQWFYd8pQ1LOipI3WGVaOvfX+yfZSBD+1WJdc+8l6gtPu6lrb2gdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLcqgkPObxRMvDu5BH/NfIkEih9Lm1/b6Ahi/is/NS0=;
 b=ni0qf6xbbjUmY1tq4CCRL4Yei18l/T4uYZRXdRnIpNHcO1SlhO5npPXa7pSXTtSrCxzrgr3s+M9ilR+U/kpcSBzvytlCaf0ZYefgXbfiPmh3nopS/feyWJseQ7uyus0DHDMlMxl1GqGFSpjzk66FPkYiLBDGqMbBGivVUe4d74k=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 06:19:27 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::55b1:caf1:4b5f:c634]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::55b1:caf1:4b5f:c634%3]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 06:19:27 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Index: AQHX9U73m4R3hGHRyE6adqBkcqlFa6w63m6AgAAFLnA=
Date: Mon, 20 Dec 2021 06:19:27 +0000
Message-ID: <DM6PR12MB3067D18C422AB01AE376DFE98A7B9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20211220030849.32458-1-guchun.chen@amd.com>
 <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-20T06:02:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2350a017-1461-4d73-a390-1767873df162;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-20T06:19:25Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3e0264db-22de-4c8c-8000-3db04d14292c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e12e01d1-5c3c-4d61-c0b0-08d9c380acda
x-ms-traffictypediagnostic: DM6PR12MB4185:EE_
x-microsoft-antispam-prvs: <DM6PR12MB41854CAB640DD31402DF07A28A7B9@DM6PR12MB4185.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YodvA0bGL0HQNNgQcJxKVTSiZMtzTTKqUfFgWsCbl8KO8nvgVQd/Xa4Jt+DHD6Mx2yO4l3PKhBdUMv1vrjRiWvqPz9dp/TkcG1PvebVhezvG1oSmUNveUMfwI6oqZMBJYV7HDzTBDADYf6N1yXceIC+jcNU9IuQVCuZxoiqrCsOrdstuxd6d7oOAQX59mBcfJzhmXxQ0NleEbohbDQ3lB7AKDRUmnACZyjDnEH4ZfhEqSQo7w2EpQeKGfiTCuJHnJKtLdT/L7q+713nFmw3PIT6UOZGNpfaCz4WAKqj5aUsWnS57SQa2R2HBfzPesnDCyaDQgiZkmCqDcmRBtti+A5igZihCFRK20ZOsbhDAsa1JxVeEphwARlnt7WIRIzxSABVqJg1zIc3mHlhYkj7E6AnjpiBpq4ybP12SuHtp5FhbqRCJy2aTnoF3Nvb4Qa+S5bdbV4Bb3ljvPaCwNNwc3ei2KT9zlqZkEerNa1Bvps4g4nSKVp+VBNtV2EWzcPYvvGFAgg1sCC6JRt22N4x5F+lsps5qDBaSuaRxpJj8IfaN2sLauIgWIJf7p+vEnT/JFpX/0szstSmHNkagmRTzl6KsbNgFokqOStCVSt+SSIbYRtiATcrougr0OPj5/o99Fyxca4RUdPorkwx0Adcan/4W4OfRY7o5XHZtIRguYCHztJm0swh5tURQZpwYAL/N6KpDKCaVF5ZMoFrm7yw9Lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(5660300002)(8936002)(8676002)(316002)(6636002)(9686003)(122000001)(38100700002)(71200400001)(64756008)(66556008)(52536014)(76116006)(66476007)(66946007)(66446008)(508600001)(38070700005)(2906002)(6506007)(53546011)(55016003)(110136005)(186003)(86362001)(26005)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WYPpi7E8/IQE5ugi/MkbykkH1G26JMmWL3n6D0/5gpYXLT5RkLPXjJRH+AQc?=
 =?us-ascii?Q?8Fi22feVHITO0ZP4QQfsrUePaK1veitppdlv6v0kJF8418tOkEhuRTj+mizP?=
 =?us-ascii?Q?8k0ZJdPWAwGsT/9aXRwO/wDnR7cfw4DqLnqvcbiVsV+s93Jh9irRGVv7ywIJ?=
 =?us-ascii?Q?atwabhLRbUfvTgYVDueFWnlL2HN6ShOe+XyMC13djp2isG0K9M28aadocrWK?=
 =?us-ascii?Q?hoiJB3NNE+kElvehXko7PRJOF7bX62Z3DFSWRkAcm6DSWDnSf+12GdCiW7tL?=
 =?us-ascii?Q?Z2S34LHTR/KcwDGLb2X7rBXD5pWe9vDNXPk06PTsVELD5OVLu3XuGP5MtRg2?=
 =?us-ascii?Q?9qbvKS0cDEhPHqwJg5eBbCMM7FHz05i6p8eUAKLbWsCowjFmR1WWoj+RdoYQ?=
 =?us-ascii?Q?QBKJ45UWYYLIFe9HK4PMFRKVR6c0zi7/bqTf4b17599TvtOJ/Wz7yAf8Nzgm?=
 =?us-ascii?Q?MF55vcV8vBLta8vLfiryKZ84qXJchhgzgrhYn1zeixa6rWv6VXmbq6yxsns1?=
 =?us-ascii?Q?st93aAcbkeb4tmrUlbn3uvpCVwyG/xZvcSJ4IrZIqn3nd8OZJBbxGOZ0Aclh?=
 =?us-ascii?Q?6JMv+oZsEy/OStXPtYbTBmvFG5gMioMuRnM6oLUptqDpaHGxwnYbfweB81FN?=
 =?us-ascii?Q?ot8fp8Iw253g/699S7R5MjUXMI2XlCFknm1IJZGzjhUH1LwynAx0kxA0y7mV?=
 =?us-ascii?Q?pbYjJrdJ43/XGttuV9dqd5xwtijtHB2BSkB29u2tPkty5lndz/2Zs1/EYQ1p?=
 =?us-ascii?Q?o+p3obRwZpgn+lroDAMa4tfgq8hZogIbJ96q3fhcjO3RMRWvKoJwoz8CRhCC?=
 =?us-ascii?Q?of91mze3Fj0ZvA5SaUBdALVhRUwKK4jlMhMhqKGCuDFFqKFGkKRIxIGznVp+?=
 =?us-ascii?Q?ssbwF7SkrDEUwwjdsKOsvtPRBDJFLKjIV7WlnFWo3ReNhPSb6BG3EXHvUBj5?=
 =?us-ascii?Q?duTwHsEKFQMOIZW0Ihc7XNHC3pqSOcaiv+8TmgEGw8ENEDK7JITz6PUzQYij?=
 =?us-ascii?Q?AcL/SsWhUtn8nSFxBPgSjzN536F9KBLXZ4ZjdKnLFheyCX5CUV4rELZA2q5C?=
 =?us-ascii?Q?5gDm/NOUdM3p7zjBlCvmq0c9AwkmoRFN0OKi+QutdLR2vDUdeZVuoCUWaVUi?=
 =?us-ascii?Q?0P4Q5AUkhc5VCWsQswHpGcTdoPVQ/k1zGXe9MTMwir7QmPoP6CWaj1/wShfu?=
 =?us-ascii?Q?pT/M2w98BizNYoCQU2NTNP9q8FpydKsYMUy6oDPzykwvcCHzBkRLDv6vEN7v?=
 =?us-ascii?Q?TnURXGc6l2CPQPHUy8hw7BkDWY+xngn1GPqO73AjmzrmHQcLcmoXQJCi3rOZ?=
 =?us-ascii?Q?rN5RnxvK0mkc8Jy7va6guAVGhQgTwkOWt9xF2NClCxaknu+CC2KWBob6IehL?=
 =?us-ascii?Q?CDXwPAT0CK9bOu9IXZlOZ06jk79xPmpfYG+I1iQ7FFMLW4sApjQWkPZRVhJ7?=
 =?us-ascii?Q?P57Uam6IBLohPnDhGjbMwbumYq+I1DSe0/0CGcU1H+xENmGQYwl8wNZMvyGq?=
 =?us-ascii?Q?aVENEa8vKrcmcdQZaZ7yje1repXiCAWq4pRrZT1CYd5jZ8mvt8VUMZYTCZde?=
 =?us-ascii?Q?K8qMA8NfEers71vtCQi/M6/TY49yNIKKnuBFIH6y4wymeURaIDgT1hn8x+1v?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e01d1-5c3c-4d61-c0b0-08d9c380acda
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 06:19:27.1320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KDeOZBuQjP+diyDc0oHlgYUk3g0uuxp7iAwhViJcIKi2eh4iLyxQq9mwvPCR7xTE8mSYCX+9Gq3QQp4h9oy5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

[Public]

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Monday, December 20, 2021 12:44 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device
> init (v2)
>=20
> [AMD Official Use Only]
>=20
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: December 19, 2021 10:09 PM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> > <Jonathan.Kim@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device
> > init (v2)
> >
> > sdma queue number is not correct like on vega20, this patch promises
> > the
>=20
> I think you've also fixed Vega12 and Raven (they were being set to 8 befo=
re
> rather than 2).  No need to mention this in your description, just double
> checking.
>=20

I believe it was only Vega20 that was being set incorrectly. The condition =
was:

	sdma_version >=3D IP_VERSION(4, 0, 0)  &&
	sdma_version <=3D IP_VERSION(4, 2, 0))

which encapsulates Vega12 and Raven setting sdma_queues_per_engine to 2, bu=
t also accidently encapsulates Vega20.

> > setting keeps the same after code refactor.
> > Additionally, improve code to use switch case to list IP version to
> > complete kfd device_info structure filling.
> > This keeps consistency with the IP parse code in amdgpu_discovery.c.
> >
> > v2: use dev_warn for the default switch case;
> >     set default sdma queue per engine(8) and IH handler to v9.
> > (Jonathan)
> >
> > Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>=20
> Other than the missing checks for Raven when setting the interrupt class
> (see inline comments and reference kgd2kfd_probe in kfd_device.c) and
> one nit-pick inline, this looks good to me.
>=20
> With those fixed, this patch is
> Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
>=20

Other than Jon's comments, this patch is also

Reviewed-by: Graham Sider <Graham.Sider@amd.com>=20

> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 77
> > ++++++++++++++++++++++---
> >  1 file changed, 68 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index facc28f58c1f..36406a261203 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -59,11 +59,75 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
> >
> >  static int kfd_resume(struct kfd_dev *kfd);
> >
> > +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
> {
> > +     uint32_t sdma_version =3D kfd->adev-
> > >ip_versions[SDMA0_HWIP][0];
> > +
> > +     switch (sdma_version) {
>=20
> Please pull in the indentation for all cases to line up with the switch b=
lock.
>=20
> > +             case IP_VERSION(4, 0, 0):/* VEGA10 */
> > +             case IP_VERSION(4, 0, 1):/* VEGA12 */
> > +             case IP_VERSION(4, 1, 0):/* RAVEN */
> > +             case IP_VERSION(4, 1, 1):/* RAVEN */
>=20
> As mentioned, you've also fixed Vega12 & Raven here I presume since afaik=
,
> they're based off Vega10?
>=20
> > +             case IP_VERSION(4, 1, 2):/* RENIOR */
> > +             case IP_VERSION(5, 2, 1):/* VANGOGH */
> > +             case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 2;
> > +                     break;
> > +             case IP_VERSION(4, 2, 0):/* VEGA20 */
> > +             case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> > +             case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> > +             case IP_VERSION(5, 0, 0):/* NAVI10 */
> > +             case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> > +             case IP_VERSION(5, 0, 2):/* NAVI14 */
> > +             case IP_VERSION(5, 0, 5):/* NAVI12 */
> > +             case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> > +             case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> > +             case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +                     break;
> > +             default:
> > +                     dev_warn(kfd_device,
> > +                             "Default sdma queue per engine(8) is set
> > + due
> > to "
> > +                             "mismatch of sdma ip
> > block(SDMA_HWIP:0x%x).\n",
> > +                                sdma_version);
> > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +     }
> > +}
> > +
> > +static void kfd_device_info_set_event_interrupt_class(struct kfd_dev
> > +*kfd) {
> > +     uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > +
> > +     switch (gc_version) {
> > +     case IP_VERSION(9, 0, 1): /* VEGA10 */
>=20
> Missing check for case IP_VERSION(9, 1, 0): /* RAVEN */
>=20
> > +     case IP_VERSION(9, 2, 1): /* VEGA12 */
>=20
> Missing check for case IP_VERSION(9, 2, 2): /* RAVEN */
>=20
> Thanks,
>=20
> Jon
>=20
> > +     case IP_VERSION(9, 3, 0): /* RENOIR */
> > +     case IP_VERSION(9, 4, 0): /* VEGA20 */
> > +     case IP_VERSION(9, 4, 1): /* ARCTURUS */
> > +     case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> > +     case IP_VERSION(10, 3, 1): /* VANGOGH */
> > +     case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> > +     case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> > +     case IP_VERSION(10, 1, 10): /* NAVI10 */
> > +     case IP_VERSION(10, 1, 2): /* NAVI12 */
> > +     case IP_VERSION(10, 1, 1): /* NAVI14 */
> > +     case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> > +     case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> > +     case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> > +     case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> > +             kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> > +             break;
> > +     default:
> > +             dev_warn(kfd_device, "v9 event interrupt handler is set
> > + due
> > to "
> > +                     "mismatch of gc ip block(GC_HWIP:0x%x).\n",
> > gc_version);
> > +             kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> > +     }
> > +}
> > +
> >  static void kfd_device_info_init(struct kfd_dev *kfd,
> >                                bool vf, uint32_t gfx_target_version)  {
> >       uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > -     uint32_t sdma_version =3D kfd->adev-
> > >ip_versions[SDMA0_HWIP][0];
> >       uint32_t asic_type =3D kfd->adev->asic_type;
> >
> >       kfd->device_info.max_pasid_bits =3D 16; @@ -75,16 +139,11 @@
> > static void kfd_device_info_init(struct kfd_dev *kfd,
> >       if (KFD_IS_SOC15(kfd)) {
> >               kfd->device_info.doorbell_size =3D 8;
> >               kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32=
_t);
> > -             kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> >               kfd->device_info.supports_cwsr =3D true;
> >
> > -             if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> > -                  sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> > -                  sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> > -                  sdma_version =3D=3D IP_VERSION(5, 2, 3))
> > -                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 2;
> > -             else
> > -                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +             kfd_device_info_set_sdma_queue_num(kfd);
> > +
> > +             kfd_device_info_set_event_interrupt_class(kfd);
> >
> >               /* Raven */
> >               if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> > --
> > 2.17.1
>=20
