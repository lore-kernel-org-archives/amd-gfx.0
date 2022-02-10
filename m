Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A1AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 06:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441CB89E15;
	Thu, 10 Feb 2022 06:27:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD96089E15
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 06:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJDJbfdBNd0qEgcE2J2VgnTzRIMUBxumjf0gPyWY4qHDIMfxS2zugUtjmAsbG3vubr2HLg927aEvwreV93yAXo1Ft34OGpHYku2H57ys3AhgFVlK3TKnkMOglLEY8Tne6b8NxUMKSoJ9ixlDdtb6izV8Xh3UVMe9lFDWUVC4IYe/2Rj5GPLZ8e5hbH7iPMo97+/Ol7G+W4Q4PNz5qJaYnbJxG6jF+k4yH8R15rItyEhDS5YEgM6UQxHKSrx6Dww0hG6thul1uUhoN02EfK04+/AR6jEzNXdTIVSYUdQpIEjjoYF00QmAgB3TG3Qm9XMmLtBCnFUivKbbAW4F8SedAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcXwTOMCInlH3no1wYFyom6eIjsstQMZpVGmBHy0zrE=;
 b=KVsYNUwdbShLS2oo1twmU05+Eub3baEbgDnNj3Wq/1LKR2Bt6rF0fiCXpBc2I1+ufm7kY6OOxqcVScW8ydrtc3G7srS6/KyLT5riqCRGSP4ENPwR+BpNb7XwIEkdNNVRv4dE2LHJvMjBW+5qeM7vyzmNnf+/b6F6p66zFUerzWw8+NFCr5+97wER8qC5nIu2v8MFEUq5MycBl/zzqGKsiCAAMnxV3Vb1SdiLYLhc8FhzoPs8ZkTOJbo1liBxCeaRizqgbsdXtH6howNmAKgxRPePh3/PqrbwpZ8moXlz2aXq/j2TKb+vo9is2OVnUansr8Kf0MabfpIVqpU7zp5uMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcXwTOMCInlH3no1wYFyom6eIjsstQMZpVGmBHy0zrE=;
 b=MqZaZW2A/E9DRIx1sb9y7fHSKZlnASjcZyxlIV2pn+T2M70stxbRZt2QlJ1QiVvwd2uA3gHSvxIMZu+T09Z8EdHZItLP60pRg0D4lseodMzsvmCzHiQBnK+tZYEyoLbDAf4IhhE+Y7I/thWgoBbt+N07OyGz5NzuXvy1EbCJc5M=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 06:27:24 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 06:27:24 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Thread-Topic: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Thread-Index: AQHYHXoBCChifOVpoEe3cZvNUkmvCqyK6XxggAEvvACAADneQA==
Date: Thu, 10 Feb 2022 06:27:24 +0000
Message-ID: <DM5PR12MB1770798D362D16A2C05EED4BB02F9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
 <20220209055644.1873011-3-YiPeng.Chai@amd.com>
 <DM5PR12MB177097DBFDF292BAA390B8C3B02E9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <CH2PR12MB421531EBE2D44382D2E712AAFC2F9@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB421531EBE2D44382D2E712AAFC2F9@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-09T08:54:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f99db08d-6001-4c76-961d-99fb74e09471;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-10T06:27:20Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 307474e9-3dc4-4174-a578-db0a1ee14eee
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bd2a03c-17bf-4e83-11f6-08d9ec5e6701
x-ms-traffictypediagnostic: CH2PR12MB4070:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4070EDDCF34D39CB2B4A7528B02F9@CH2PR12MB4070.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:352;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sx1Vz5csCnfo+F5Zgi/WWQ7LSUVpry7nM3MJqqlmnJoHQ7AcYz4qPzMXyaMimGEvnon+zJrcQPHNKWIUL8YlEdupkbCfr7p3YE0/yfCMYasGMGhMEHF4V1WE/OzbwuGxIBMIgycHpXEAS7aXCj+19EGEB/jARAAFNYF1Nku2izAhlmU7rXUzY62BdBg4frYiQz9pKtr8aYjQ4FFdzig8lYZ5SCh/CL3GgtGkexJmk7bjzBW4pOJzWMKYpT5brkvMUwrQt1IsqT0CLKRigdaFUc+fRwhvohg5jyoTDeCLG6BdsSm1M85UROvjmIY1PiOqPJ4T6ggOvBcxmKb9DQ5b9pSlubTPJO90bU2K4sssJ9sqcS5e/1S5HD8eH4Em8Ni55/WEP9p9zzewQH7kOFZ39RHvzZM2ZkOJ0hj0m6pJUqCRBzqSxEDrvKznB1kBdDx7WqmgmaGZnLs+kUKR6LVLa+Rkzul2UjpogFIh+HRq3UMQn+rFujG2oINAoJorEhDgJQeISO78XHujLZ8Qi4DWICytK3HiKWBpLOZ2Hn9m5b3FuceM3buc+r+S+wia/63dkRLxcH7HazrBK1X6eYviV14j+568IkDwKagHNVthmW6V0RHBw08ipqPwT37yYpOOYnVDHY7E0oQZ1+sTvP4rc1FbdQZ2VVxPiiMD+Sdfx852dg5+MgauQcOMsF3VJUevc6WEs4FKulP0UunWfCxtOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(52536014)(66946007)(76116006)(66446008)(66556008)(66476007)(8936002)(4326008)(54906003)(110136005)(86362001)(33656002)(186003)(26005)(8676002)(64756008)(38070700005)(38100700002)(5660300002)(55016003)(6506007)(7696005)(122000001)(9686003)(2906002)(508600001)(83380400001)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pj2ViK+yNX53VZBUx3+91CIQ6gBPg8wPvqIy9CQeparOh8vOU0ENZQwpfXbn?=
 =?us-ascii?Q?pinsmubGOlTuTd32wgsCuemePWnyZIQGroj0KJh6QbZmJZy96m2MElnzntLU?=
 =?us-ascii?Q?JuAohH6OtB7Mp8MEFaDUxATMlDru6/bqNisILgQ/WMLCheZFNIgtAWyu/eZ+?=
 =?us-ascii?Q?dDtAaoX4oCAvNYsXlHiChO6AL0KBkU7EIBHFGjczxj36kluxrfUuFW4n/mVV?=
 =?us-ascii?Q?ZEXV9jAGtaoxXUufwucDW3NBYAyrWvuwjVbfI+oDyxfk8D7cJbbm4oJF0l1W?=
 =?us-ascii?Q?vCdGMKHz7QEHnedXBFMPMV69Qe0QylsdoY8xbca9m1P4uN5z/V9ncrIgGI4L?=
 =?us-ascii?Q?7IfidLpkfDIu0E4pX4I0/l61+TqMa3symBbvPOkg7kIUknZeHcEq7Sf6T2Vr?=
 =?us-ascii?Q?TWVLgtAQgqtdYPdZb10QEo1BxJCqcl1JZUqWmiLuGIytuwUZOI/KqjrDhBsu?=
 =?us-ascii?Q?8rxBB5ApaOHnVm6/vjfWOo4eKFD18AzeN6vuYcd1rzbgKyoALhiwWdok/4xc?=
 =?us-ascii?Q?1L3/r+M7dFqnIbUVuOwn0E/fbNNSMXKgfIH1gUmIt62mFAyK9qL8XB7AzLxw?=
 =?us-ascii?Q?3dVcLCmqS0ncsloS0vODrQRWclbM2IPoU4V2Y+uCI8i4Zp73jcfYxsB5wB0w?=
 =?us-ascii?Q?zdwbykzKNkz6bNo1aJGC+TCPWJG4CMiA9uh6Y1tvYhKGnE7X0omkPXie54S8?=
 =?us-ascii?Q?YY65HDDngl6OWjHRoFY3G86hRnpB5acXrBEwMMzKuR+2yvg72hgQcrTwGcL1?=
 =?us-ascii?Q?6DY4nQb0AF43ysM+HTu8FRvtkRXczzF0b8fsrhQRwesGi9dGT3dKZ/gNZJLs?=
 =?us-ascii?Q?rpgN4dNYzHU0zf+TgcbWjUKzL3fVyOtUN/2joElO0qQXbJJaYHRI7uUmMzTD?=
 =?us-ascii?Q?YccB2tbXN74r5W0/UQ3Fo943pz++Vifh7b5SElR7twpN5bTSq4OHdNJFQhaU?=
 =?us-ascii?Q?PCcWEYSxBpQKOC7+1z3rmP6XTtrXKrnCmMuXP0l7gLQBK3I2ZWPPP4GtfvfD?=
 =?us-ascii?Q?zTQqQK88tEarwP87qg1wwGtfY28NlVAMGwc/Fx0l69bgcUXjC0X5tOABRu0N?=
 =?us-ascii?Q?fUAmZKuW4KaZp+kEbo1XIqXcutOEtli0IcYoxWobJFZIFiBMwzERKia5h77N?=
 =?us-ascii?Q?ZuozW/6IRCcSpWhuxOU4L8WljFDIFx8Xn+FJeEisUxopRSvAU0sw0NBEWxI5?=
 =?us-ascii?Q?+T57JDwvJxBBmEqqFcFGLtzp4VoqVsa49FNNjROYQXbaiB4eIyCibuEbEXwd?=
 =?us-ascii?Q?ex7Sg4trsWWVHiALcT1mnDTx+5l2JmvyI7lf9HnmjunYkFg4W+dhx6ScSpwf?=
 =?us-ascii?Q?YC/HFgqpOYiNAC1yxNyMNI3UqWOFhKBLGPvml4xwaZA3v6M6BX5q9vNMksxl?=
 =?us-ascii?Q?ej95CBVNIz4H+qUJurAfNee5kcif55hksASXbMPR/1THo3u0Ic8vLX+hX73M?=
 =?us-ascii?Q?IzkG1AnDHOcp8SITQ82awjPu3DCRF6AmxC4LPEwCUrONzvISa19LaoCKMMN6?=
 =?us-ascii?Q?okW86r0sZgl++PZiADSG0tlBLyhw46xQG5b+CCDQuAAtByyCZKBtt9cQaiL0?=
 =?us-ascii?Q?HKx+Aw7PkMuBLDulU2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd2a03c-17bf-4e83-11f6-08d9ec5e6701
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 06:27:24.7434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBv3yxd3dCbCxL1n5rrqWoMs5gaOdC5Tx5eOo5/1xYCL73fmBy4+SMpg1aX4sZC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

OK, if there is further refinement, the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, February 10, 2022 10:59 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John
> <John.Clements@amd.com>
> Subject: RE: [PATCH 03/11] drm/amdgpu: Optimize
> amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
>=20
> [AMD Official Use Only]
>=20
>=20
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, February 9, 2022 4:54 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John
> <John.Clements@amd.com>
> Subject: RE: [PATCH 03/11] drm/amdgpu: Optimize
> amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
>=20
> [AMD Official Use Only]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, February 9, 2022 1:57 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> > John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 03/11] drm/amdgpu: Optimize
> > amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
> >
> > Optimize amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code.
> >
> > Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 37 ++-----------------------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  1 +
> >  3 files changed, 5 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > index 518966a26130..21a5f884dd2a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > @@ -26,43 +26,12 @@
> >
> >  int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_inf=
o)  {
> > -	int r;
> > -	struct ras_ih_if ih_info =3D {
> > -		.cb =3D NULL,
> > -	};
> > -	struct ras_fs_if fs_info =3D {
> > -		.sysfs_name =3D "hdp_err_count",
> > -	};
> > -
> > -	if (!adev->hdp.ras_if) {
> > -		adev->hdp.ras_if =3D kmalloc(sizeof(struct ras_common_if),
> > GFP_KERNEL);
> > -		if (!adev->hdp.ras_if)
> > -			return -ENOMEM;
> > -		adev->hdp.ras_if->block =3D AMDGPU_RAS_BLOCK__HDP;
> > -		adev->hdp.ras_if->type =3D
> > AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> > -		adev->hdp.ras_if->sub_block_index =3D 0;
> > -	}
> > -	ih_info.head =3D fs_info.head =3D *adev->hdp.ras_if;
> > -	r =3D amdgpu_ras_late_init(adev, adev->hdp.ras_if,
> > -				 &fs_info, &ih_info);
> > -	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
> > -		kfree(adev->hdp.ras_if);
> > -		adev->hdp.ras_if =3D NULL;
> > -	}
> > -
> > -	return r;
> > +	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
> >  }
> >
> >  void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)  {
> >  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
> > -	    adev->hdp.ras_if) {
> > -		struct ras_common_if *ras_if =3D adev->hdp.ras_if;
> > -		struct ras_ih_if ih_info =3D {
> > -			.cb =3D NULL,
> > -		};
> > -
> > -		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
> > -		kfree(ras_if);
> > -	}
> > +	    adev->hdp.ras_if)
> > +		amdgpu_ras_block_late_fini(adev, adev->hdp.ras_if);
> >  }
> >[Tao]: Since hdp_ras_late_init/fini are simple wrapper, can we remove th=
em
> and call amdgpu_ras_block_late_init/fini directly?
> >The same comment to other blocks.
>=20
> [Thomas] Compared with amdgpu_ras_block_late_init/fin,
> hdp_ras_late_init/fini have different function interface parameters.
>                  But can do it as a new ticket later.
>=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index af873c99d5e4..b12fe6703f02 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1302,6 +1302,7 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct
> > amdgpu_device *adev)  {
> >  	adev->hdp.ras =3D &hdp_v4_0_ras;
> >  	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
> > +	adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
> >  }
> >
> >  static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev) diff
> > --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > index 503c292b321e..a9ed4232cdeb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> > @@ -160,6 +160,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
> >  		.ras_comm =3D {
> >  			.name =3D "hdp",
> >  			.block =3D AMDGPU_RAS_BLOCK__HDP,
> > +			.type =3D
> > AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> >  		},
> >  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
> >  		.ras_late_init =3D amdgpu_hdp_ras_late_init,
> > --
> > 2.25.1
