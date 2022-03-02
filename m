Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B314C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 07:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1D310EFAF;
	Wed,  2 Mar 2022 07:44:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6990E10EFAE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 07:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKn/vrJS3pk0bet1nUcpmYQAe1A2ZimzBvVFvV3MczjkOVfgY2yuQXQ6TTAuvgY189oJr3HS85VcAmnS7XgWIAyDFNU518Z98+id6lzN1YoBe1upJ6exTUxug7Na3uZlwTXQJKvsP6t3YyssXlxr9Ig/4vdqg2PI3qnQc6Z7cfdGWOyv7ayO8gpg3Z0DrmdhLOGKlSeFm4xPoAf3prwiEvV8RCyrk6+ZhobtHCq8aZm+ORJybYwTrLZNZ/zMCBkOrRQcHEsr9JeOgYOBZNObtKcp2WRiqxD316zwaz4vG7fAkHHQXXRes+3r7JG8GNLETREzp8K6v8RHotfW0wTYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUyP+ENY24leMAHrPE/HCoDMnDiCfMTn8VWd2AumqJA=;
 b=h2k2dCFRtwBQwgttZXJaPjdCwh3EC2oTaM8UwE9f6CjCU0HXOYhiW93OhHMOuBs8i+Vp+HLfRIgEjaqezD89zzibVu8CqklvH8+aUlohNQF/uREEZ9+s4/7n/i+fIk4JP2Ba34NfcSVmxFOCLg0G5pJOe3twEXrIlm4n6iHpU/GR7fgHdfbf+1JpVTcNE1REsVqq1XyZv8SgTL1HfatlRPj9FbKawdr4agXw2RoGIlFD6ZtKBZvPjQGnELa1JeBK+43x7bwjB9hkq4BW+0aomZOpao0uVA/st+IkMQixgHkJeuSaZxIlfdMCo9VE/iEYjpdeLBRCKYzy28ddM0VyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUyP+ENY24leMAHrPE/HCoDMnDiCfMTn8VWd2AumqJA=;
 b=GA9OucOCM+LgStrn/Z6aS1HH5tJ79KakHvNglrwGoMF97pjce7p5LEfFV9/apoJdgXLBHYFbndzy+W4wIHtYdE1V76/w53s05qNGgd0e8/KWx7osAC/eklUL3EmLPddZJhqSqNNXM/cXQMfkUpD1mtojfpAcIZwfRIsZK7Kppro=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 07:44:49 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 07:44:49 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Joo, Maria" <Maria.Joo@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: support send bad channel info to
 smu
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: support send bad channel info to
 smu
Thread-Index: AQHYLXCFzIQ4uWVKHUyZsqf28ZeF4KyrtWGw
Date: Wed, 2 Mar 2022 07:44:49 +0000
Message-ID: <DM5PR12MB177034C3444BB1CDB304ED0FB0039@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220301133022.17602-1-Stanley.Yang@amd.com>
In-Reply-To: <20220301133022.17602-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-02T07:35:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0a847742-6747-4e61-ac8c-042c8e5fa9bf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-02T07:44:46Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8f61a505-6555-4212-b6c3-2f0f72368b4c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9dfaf5d-4b2c-49ea-d02c-08d9fc208782
x-ms-traffictypediagnostic: MW2PR12MB2555:EE_
x-microsoft-antispam-prvs: <MW2PR12MB2555A068B24638E94D7FBB46B0039@MW2PR12MB2555.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlcRO/CIwSXERUu5aBIZ7gnXn4fDhquNBUlCNXbw0oB59sLx1BpYk0FjyhOQzPJRqusZxkStLxRIUHrtzfyi7JqnVRLW6EQrinUSlEmfMoRfOEeH1sAEatFo0lwIa4ewyJvEz7MnOwjFGvTT3p2QkmVHhrBbEPznUrzpCATJHKB2yOU7NZCNQOgUJ4x8nckrK0Ca+2CLxuq24kShC9DiQdntRdUHEP74yEIajcStHQXJZW8URpHlSMFvjXMzHROyuhv74kQaKU+b8OFPYC5N/6Wdujbesnjp55AzsVWaOWHHgHFHN7c4gChimIgQa0FXa9O+Qj7h5RCTIfmp3l6nOdi412yGdsRoWY1pqkE3++rA+oG/5sDqcGTZwa4DX6Hm92hRcmg/E8szAIOIaEKWfGIm9lv0luknhspMX1QYc/FVfVUaffFKYwaaOowSU0Bb+zkmZnnJEq2/T7oxiX4MOjdrJdYxf3899DGbPmvo14d4oE/jSgfxyfpdvJDFqRijki+bATBL4+2FZO4xZTM/6KJAdmu2y0Fj+YEl1CAvNYXc1eSp5XWjGlbJlbevly4NGFGPYVMMHmZHNfJOR4dOTzqIAtWbe5WyvcEn6V4tUGiM15AyByxqh0+wyexfaNscRTO/eYuvVTPZyRFS9qrCX63JdnaDurlucj+0nK/RFyo3Jh9IpRxKDO1DBFJWImWpygxXReK6SvOh1afbZEqR1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(6636002)(76116006)(66946007)(30864003)(186003)(86362001)(5660300002)(316002)(26005)(508600001)(64756008)(8676002)(66446008)(66556008)(66476007)(52536014)(8936002)(53546011)(110136005)(4326008)(83380400001)(122000001)(38070700005)(55016003)(71200400001)(9686003)(33656002)(2906002)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RYuBLbvERuN7lQtHr3cIXkWbJ5W6aeiGTo12Jqv3WhgtcODltXoySQN5l70Q?=
 =?us-ascii?Q?H2juLo78VvVYWX6XJawMcvpUZsrHrc0xWcTiHwdoGILCqxMW3xM+3pYqx7UC?=
 =?us-ascii?Q?uxU3j+D19y3Ia+en2xtkYedMR8T9Jei2wkkz+dgiHm8w+ldnowg3pv6Vfz15?=
 =?us-ascii?Q?UGeObgOkrohDcz8+Ll/3YtJtra7PP4EZulHPmgbOplLo3ENZ2yMx7aha/Jp1?=
 =?us-ascii?Q?Ypuxi3x9KhOGOEiDz0O1/xXTQUoRo0sUNpW3YxGor4PMemWVOXJ2GO8RCLvw?=
 =?us-ascii?Q?1NuzoJPZ3JhBdOTDvcs7bgJwGI5Ji4YNfi4xX/cAm+/a4qKSngCtsFMlf9UQ?=
 =?us-ascii?Q?0IH0EWOO/Yp03xoG7dqj1EEkIhyQ3JwSd5EYbJ/oYoE3q4m3PvOCculMhbNH?=
 =?us-ascii?Q?pFxtyqBDi/tfeju/l+tmFk+yZUCCKcDn8JfFnMnKBdtxhPltivjrt6IxacWV?=
 =?us-ascii?Q?bbJM6pvSO/5pvAWCFGEeckXlTv5oTwjfDPL8savXpBRBfyshDAyELbTciL0Q?=
 =?us-ascii?Q?di9yUmOU5ZDZElgNexb4SZM3LeW4S7EG3S7BqH8dmcaLJjjvku5lbN4EfQQ0?=
 =?us-ascii?Q?SCC7MOgGBYA7GFhdlBRuB4h3SDz5Hxbqr5MBP+WKJMU9DUpAjWhMZOL5+vXL?=
 =?us-ascii?Q?x57uGB5J5OlPpRGwrae0efE4hYriGKpivOlpQOQ9GiKQWUi5timOBvPK1fUd?=
 =?us-ascii?Q?5CO/6zRtkuHrUd/bVdG5LfCn7Po9sdoaFKzxxlk70t4KdSxrmb25DAYwpfBs?=
 =?us-ascii?Q?iqY2JBCeClGcBhy+eEz8VN6yWT6iddYZtoYyowduB/zouGiL79O247VUXgFA?=
 =?us-ascii?Q?rHI4Z+qavAaPCNEJZRlCfYWxskJlINp1/wPioG799+N9tNCdMalKRmoV7UY+?=
 =?us-ascii?Q?WhcrZqe7l3bSpYnGsVv+EFB7d6r+XG4P6+NP6zzhmFP1ki6iIqVQRBjsWxXB?=
 =?us-ascii?Q?qiBDZcMvT/AgzjhyqPyqKASFvSMgMUBAvvTvEg3KA+cIcd/W4P5WAd8WLGbH?=
 =?us-ascii?Q?iqTASMA7TALGljY3e4WEpipIhCNYrNlhl8pPy12XDRYD/CqFcXhfe8hYFPqo?=
 =?us-ascii?Q?2KVETUsH0t5VdN5g819um6bKh9EIVoyD8TWYOcRdrxsk/EWNP/Jqy8qSYAsZ?=
 =?us-ascii?Q?j9qodIxgAiUg7uC2peAOmLNYhyab0veqQahiuxcRQGBnO1XftIK6bXW7i5nR?=
 =?us-ascii?Q?x0gwPrOifBzc4HnvwV7jphpqB7Rb71Z3Vq9tDAM2bU8qKAsnawItF5rYxkXh?=
 =?us-ascii?Q?1sboqgvL5x5wm6T0KVX8GzFc9IszfONW70n5C5euM9Vc50vRKTN6gfnfNGDT?=
 =?us-ascii?Q?EXtNGQqJ2IHsalpjdPbORtr0ZheaLaYw3v0ENf7fACPCeqIT2nxAfFweGPb8?=
 =?us-ascii?Q?iXoQl8wYWwkX0Z5hhVKcY3sZ7iwGMJvyeQ3zXMpwogGt3Ku5gubmLBz96DIz?=
 =?us-ascii?Q?K6gA6xhURVrmyIxV58tBZMNOtejTM2szTwSmIvsfn1K8LEwZ19XQvRuBNocj?=
 =?us-ascii?Q?VlOCMwt6OkjxxibWO+ZZanqWDYsgxYdogkdu5Ad/bzuM3VSdPLFVSxprM1RC?=
 =?us-ascii?Q?sSvNDtYNmxw/NNTtbfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dfaf5d-4b2c-49ea-d02c-08d9fc208782
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 07:44:49.0567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfTqNPExa0jt7Ce/zk3Ikqyzbwx3oFuhDJiH2kD2/crLDOZN5MJY4HGZM+xoYSdl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Tuesday, March 1, 2022 9:30 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Joo, Maria
> <Maria.Joo@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: support send bad channel info to
> smu
>=20
> Message SMU bad channel information bitmap to update OOB table
>=20
> Change-Id: I49a79af64d5263c28db059ecb8b8405a471431b4
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 ++++++++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 12 ++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
>  .../pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h    |  3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 43 +++++++++++++++++++
>  12 files changed, 119 insertions(+), 4 deletions(-)

[Tao] It's better to split the patch into two parts, one for amdgpu and one=
 for pm.

>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d3875618ebf5..f9104f99eb9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2068,6 +2068,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)
>  	mutex_init(&con->recovery_lock);
>  	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
>  	atomic_set(&con->in_recovery, 0);
> +	con->eeprom_control.bad_channel_bitmap =3D 0;
>=20
>  	max_eeprom_records_count =3D
> amdgpu_ras_eeprom_max_record_count();
>  	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
> @@ -2092,6 +2093,11 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)
>  			goto free;
>=20
>  		amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> >eeprom_control.ras_num_recs);
> +
> +		if (con->update_channel_flag =3D=3D true) {
[Tao] It can be simplified to "if (con->update_channel_flag)"

> +			amdgpu_dpm_send_hbm_bad_channel_flag(adev, con-
> >eeprom_control.bad_channel_bitmap);

[Tao] do we need to check status of the function and stop recovery_init if =
it fails?

> +			con->update_channel_flag =3D false;
> +		}
>  	}
>=20
>  #ifdef CONFIG_X86_MCE_AMD
> @@ -2285,6 +2291,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  		goto release_con;
>  	}
>=20
> +	con->update_channel_flag =3D false;
>  	con->features =3D 0;
>  	INIT_LIST_HEAD(&con->head);
>  	/* Might need get this flag from vbios. */ diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7cddaad90d6d..9314fde81e68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -374,6 +374,9 @@ struct amdgpu_ras {
>=20
>  	/* record umc error info queried from smu */
>  	struct umc_ecc_info umc_ecc;
> +
> +	/* Indicates smu whether need update bad channel info */
> +	bool update_channel_flag;
>  };
>=20
>  struct ras_fs_data {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2b844a5aafdb..ad5d8667756d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -265,6 +265,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)  {
>  	struct amdgpu_device *adev =3D to_amdgpu_device(control);
>  	struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
> +	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	u8 csum;
>  	int res;
>=20
> @@ -285,6 +286,10 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>=20
>  	amdgpu_dpm_send_hbm_bad_pages_num(adev, control-
> >ras_num_recs);
>=20
> +	control->bad_channel_bitmap =3D 0;
> +	amdgpu_dpm_send_hbm_bad_channel_flag(adev, control-
> >bad_channel_bitmap);
> +	con->update_channel_flag =3D false;
> +
>  	amdgpu_ras_debugfs_set_ret_size(control);
>=20
>  	mutex_unlock(&control->ras_tbl_mutex);
> @@ -418,6 +423,7 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>  			       struct eeprom_table_record *record,
>  			       const u32 num)
>  {
> +	struct amdgpu_ras *con =3D
> +amdgpu_ras_get_context(to_amdgpu_device(control));
>  	u32 a, b, i;
>  	u8 *buf, *pp;
>  	int res;
> @@ -429,9 +435,16 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>  	/* Encode all of them in one go.
>  	 */
>  	pp =3D buf;
> -	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE)
> +	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE) {
>  		__encode_table_record_to_buf(control, &record[i], pp);
>=20
> +		/* update bad channel bitmap */
> +		if (!(control->bad_channel_bitmap & (1 <<
> record[i].mem_channel))) {
> +			control->bad_channel_bitmap |=3D 1 <<
> record[i].mem_channel;
> +			con->update_channel_flag =3D true;
> +		}
> +	}
> +
>  	/* a, first record index to write into.
>  	 * b, last record index to write into.
>  	 * a =3D first index to read (fri) + number of records in the table, @@=
 -
> 684,6 +697,7 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>  			   const u32 num)
>  {
>  	struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	int i, res;
>  	u8 *buf, *pp;
>  	u32 g0, g1;
> @@ -751,8 +765,15 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>  	/* Read up everything? Then transform.
>  	 */
>  	pp =3D buf;
> -	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE)
> +	for (i =3D 0; i < num; i++, pp +=3D RAS_TABLE_RECORD_SIZE) {
>  		__decode_table_record_from_buf(control, &record[i], pp);
> +
> +		/* update bad channel bitmap */
> +		if (!(control->bad_channel_bitmap & (1 <<
> record[i].mem_channel))) {
> +			control->bad_channel_bitmap |=3D 1 <<
> record[i].mem_channel;
> +			con->update_channel_flag =3D true;
> +		}
> +	}
>  Out:
>  	kfree(buf);
>  	mutex_unlock(&control->ras_tbl_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 6bb00578bfbb..54d9bfe0881d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -80,6 +80,10 @@ struct amdgpu_ras_eeprom_control {
>  	/* Protect table access via this mutex.
>  	 */
>  	struct mutex ras_tbl_mutex;
> +
> +	/* Record channel info which occurred bad pages
> +	 */
> +	u32 bad_channel_bitmap;
>  };
>=20
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 85da6cbaf3b7..aad3c8b4c810 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -97,6 +97,11 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>  			amdgpu_ras_save_bad_pages(adev);
>=20
>  			amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> >eeprom_control.ras_num_recs);
> +
> +			if (con->update_channel_flag =3D=3D true) {
> +
> 	amdgpu_dpm_send_hbm_bad_channel_flag(adev, con-
> >eeprom_control.bad_channel_bitmap);
> +				con->update_channel_flag =3D false;
> +			}
>  		}
>=20
>  		if (reset)
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 1d63f1e8884c..9a892d6d1d7a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -507,6 +507,18 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct
> amdgpu_device *adev, uint32_t size)
>  	return ret;
>  }
>=20
> +int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev,
> +uint32_t size) {
> +	struct smu_context *smu =3D adev->powerplay.pp_handle;
> +	int ret =3D 0;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret =3D smu_send_hbm_bad_channel_flag(smu, size);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>  				  enum pp_clock_type type,
>  				  uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index ddfa55b59d02..3e78b3057277 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -412,6 +412,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device
> *adev, bool enable);  int amdgpu_pm_load_smu_firmware(struct
> amdgpu_device *adev, uint32_t *smu_version);  int
> amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool
> enable);  int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device
> *adev, uint32_t size);
> +int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev,
> +uint32_t size);
>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>  				       enum pp_clock_type type,
>  				       uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 7e79a67bb8ef..f1544755d8b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3052,3 +3052,13 @@ int smu_send_hbm_bad_pages_num(struct
> smu_context *smu, uint32_t size)
>=20
>  	return ret;
>  }
> +
> +int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t
> +size) {
> +	int ret =3D 0;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->send_hbm_bad_channel_flag)
> +		ret =3D smu->ppt_funcs->send_hbm_bad_channel_flag(smu, size);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fbef3ab8d487..ef57b6089c69 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1292,6 +1292,12 @@ struct pptable_funcs {
>  	 * @set_config_table: Apply the input DriverSmuConfig table settings.
>  	 */
>  	int (*set_config_table)(struct smu_context *smu, struct
> config_table_setting *table);
> +
> +	/**
> +	 * @sned_hbm_bad_channel_flag:  message SMU to update bad
> channel info
> +	 *
> 		of SMUBUS table.
> +	 */
> +	int (*send_hbm_bad_channel_flag)(struct smu_context *smu, uint32_t
> +size);
>  };
>=20
>  typedef enum {
> @@ -1428,5 +1434,6 @@ int smu_get_ecc_info(struct smu_context *smu, void
> *umc_ecc);  int smu_stb_collect_info(struct smu_context *smu, void *buff,
> uint32_t size);  void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device
> *adev);  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t
> size);
> +int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t
> +size);
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
> index ab66a4b9e438..0f498baf6838 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/aldebaran_ppsmc.h
> @@ -103,7 +103,8 @@
>  #define PPSMC_MSG_GfxDriverResetRecovery	0x42
>  #define PPSMC_MSG_BoardPowerCalibration 	0x43
>  #define PPSMC_MSG_HeavySBR                      0x45
> -#define PPSMC_Message_Count			0x46
> +#define PPSMC_MSG_SetBadHBMPagesRetiredFlagsPerChannel	0x46
> +#define PPSMC_Message_Count			0x47
>=20
>=20
>  //PPSMC Reset Types
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index d787c3b9fc52..9f6f306eeca0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -232,7 +232,8 @@
>  	__SMU_DUMMY_MAP(ForceGfxVid),             \
>  	__SMU_DUMMY_MAP(Spare0),                  \
>  	__SMU_DUMMY_MAP(UnforceGfxVid),           \
> -	__SMU_DUMMY_MAP(HeavySBR),
> +	__SMU_DUMMY_MAP(HeavySBR),			\
> +	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel),
>=20
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 890acc4e2cb8..e5e249968244 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -82,6 +82,12 @@
>   */
>  #define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
>=20
> +/*
> + * SMU support BAD CHENNEL info MSG since version 68.51.00,
> + * use this to check ECCTALE feature whether support  */ #define
> +SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION 0x00443300
> +
>  static const struct smu_temperature_range smu13_thermal_policy[] =3D  {
>  	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000,
> 99000}, @@ -140,6 +146,7 @@ static const struct cmn2asic_msg_mapping
> aldebaran_message_map[SMU_MSG_MAX_COUNT
>  	MSG_MAP(GfxDriverResetRecovery,
> PPSMC_MSG_GfxDriverResetRecovery,		0),
>  	MSG_MAP(BoardPowerCalibration,
> PPSMC_MSG_BoardPowerCalibration,		0),
>  	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,
> 0),
> +	MSG_MAP(SetBadHBMPagesRetiredFlagsPerChannel,
> 	PPSMC_MSG_SetBadHBMPagesRetiredFlagsPerChannel,	0),
>  };
>=20
>  static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =
=3D
> { @@ -1997,6 +2004,41 @@ static int
> aldebaran_smu_send_hbm_bad_page_num(struct smu_context *smu,
>  	return ret;
>  }
>=20
> +static int aldebaran_check_bad_channel_info_support(struct smu_context
> +*smu) {
> +	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
> +	int ret =3D 0;
> +
> +	ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
> +	if (ret) {
> +		/* return not support if failed get smu_version */
> +		ret =3D -EOPNOTSUPP;
> +	}
> +
> +	if (smu_version < SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION)
> +		ret =3D -EOPNOTSUPP;
> +
> +	return ret;
> +}
> +
> +static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
> +		uint32_t size)
> +{
> +	int ret =3D 0;
> +
> +	ret =3D aldebaran_check_bad_channel_info_support(smu);
> +	if (ret)
> +		return ret;
> +
> +	/* message SMU to update the bad channel info on SMUBUS */
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetBadHBMPagesRetiredFlagsPerChannel, size, NULL);
> +	if (ret)
> +		dev_err(smu->adev->dev, "[%s] failed to message SMU to
> update HBM bad channel info\n",
> +				__func__);
> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs aldebaran_ppt_funcs =3D {
>  	/* init dpm */
>  	.get_allowed_feature_mask =3D aldebaran_get_allowed_feature_mask,
> @@ -2062,6 +2104,7 @@ static const struct pptable_funcs
> aldebaran_ppt_funcs =3D {
>  	.i2c_fini =3D aldebaran_i2c_control_fini,
>  	.send_hbm_bad_pages_num =3D
> aldebaran_smu_send_hbm_bad_page_num,
>  	.get_ecc_info =3D aldebaran_get_ecc_info,
> +	.send_hbm_bad_channel_flag =3D
> aldebaran_send_hbm_bad_channel_flag,
>  };
>=20
>  void aldebaran_set_ppt_funcs(struct smu_context *smu)
> --
> 2.17.1
