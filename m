Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ED0C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 12:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AD010ED4E;
	Thu, 16 Feb 2023 12:20:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B3210ED4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 12:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDKqYwxM79th6b5j6lE3Sq5qNtvUkUR4/Uyt9jwz/yeASHUqgFfM0ZyVHkww9Jc6JmWgVzsDgeap7mJqorTwT00FS65Hcg7g13sCl0lm3i4L8FZIrrGP1g0G7rzuC3Hj2p4gh+ufROK0vlqXPv8q7VFgVK/ZiYWGFgJdq+JI2a2omsFx/qHhwy47745KrY8mF0lHyPnYqNxoEcYBc8Dm/IjlJKH4Q5IPDXL+bVrlXaXPd2zc8zJe3W8W4DKg8zOThe4dbmxkZRu/+vUu6cVcvNwtM5wBAAO31LFodCC9Ss0vgualw7P77vgewNnwkmMVw3nmslpbqonEgJ1zci3C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V9GE4+XVYEaU2kh+HaVClUVWJzuFTgcrKIcgAVkijU=;
 b=Z/nFkkBImHlKXpirJdlPTRHLpk4LYsVQwsWTDBp6q6nA/wBcmjgEDM8G5yCxDOLRn82+uEtJ4JU7Q72gunyr1dCozmx0pwF1H8qI+QG0rxqxjDdDXhIW3qYOnHcRjJtNhEOqZVHJ+LM0Jc7dKiy1dB3duclqTl9WPm2dr5TlVmI4VBui/ddZ2BTvoyzki1nSuH5LSrlA416fKwNW6udzYjJr8VEzqHTWCHGrb8nepzRYyGGaue8Mv0cDFoL4ENm1G95aX6JFY2qN4s4QDm9qwYSYfTsErBcTqxFCDawzwZFnZOVQl3BaYGG5jRZfKdhNd7t8B8YIbK5bsQar6s7Hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V9GE4+XVYEaU2kh+HaVClUVWJzuFTgcrKIcgAVkijU=;
 b=ROb2c6rduB5jpUaoZ0K9fQXUo8yk4q1USbb9hrQ6P0XyCt7gSnPEQtsAh1oYJZMeiBp1RktMhlMOEgjeplKAyabfO0FOVsB5PL0/PpULuIFHNDUsT1Lx14iDzy9oN957JiRHE/Hpab2CeARbIGVOhUCOdtH4U0duXqr5A8Oh4SQ=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 12:20:06 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%5]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 12:20:05 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZQdxbqcqoHj5usEqem0vlUKyxWq7Re8Lg
Date: Thu, 16 Feb 2023 12:20:05 +0000
Message-ID: <BL1PR12MB53346266C3977FE135BE99549AA09@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230216075731.21355-1-tao.zhou1@amd.com>
In-Reply-To: <20230216075731.21355-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-16T12:20:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6e2d84ba-14f9-45ff-a7d3-c5f5b75b0d1f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-16T12:20:02Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c973d9b9-c346-4d4d-b050-405e03a711a9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SA3PR12MB7975:EE_
x-ms-office365-filtering-correlation-id: 844d5ce5-fcbd-4152-c4be-08db10182312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Dh3gqHMXxeQj3QozUaW3Ag3IKMcE9gBP9faO/z9CMHGXcL/NDlAGbuRTklQ+vasUzpi8Ex0PQ348qQ33VQXkMQn069wgH2ibC3vC0DRwmJr7jArqNn6CznRAW0y/OKg6U3QQPY2EnWp0eXgcWxgXCfMKVj3GO+iteXJ1cPUUHHqvcvk78PXg/tinlOZbHECOtvmqvrLC5pse9zlE+bd4ekPZLnseayNzS29wg4iBPv6TOFr2sXxD8T7bmdk98HWO/O4jCOGFjkgR428+PnE28lZ567Zv7GGG8RjQxmVQev+6KoLwbj+d2Hz6rO/M8P0fZuH0GG3UwDICNNKMwCwwhRrKviCcZLtLwwbRxtJaQdGdNQpumMEN3kUkjNNCQ5G/Vo4mKIBICod/O43ZyfUXPtziHV8ReW1bC0Ir/G8eMYK/g+Fwft3kUbl+BbNLK7Z/lV2oHZmnzGqtyjN+Zk8CwCUHES5Fbrnn5ToPh58zpnPGwzvUIgDGbPAa2RCx6VMdM5mzudrpJalLJfuZawQJKM9Qyc23XqF+a90cVgG55nE7mlK4LBVNn7kSe0XxWcmec1T9sWweqCfuZa+YAVDykPqUTOcZCxTu8L0iVSewQI5riG/ex0JUJk1qTkY7LVfXQLIiz0K6G415glAApFu+zX0qotTO/D6Tng2eYhevELnqQU1SOmxIPAIJgAPkrUVegrawjk1jMj9iR9ynIcO0C040b5cnhTPXp4FNqjyKBg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(71200400001)(7696005)(6506007)(186003)(53546011)(26005)(110136005)(9686003)(2906002)(6636002)(41300700001)(52536014)(8936002)(478600001)(5660300002)(76116006)(66556008)(66946007)(66476007)(38070700005)(38100700002)(64756008)(86362001)(122000001)(8676002)(66446008)(55016003)(33656002)(921005)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fzKLeAidSQnAb2MwcaQI0ArFyrAwBgo6yMu3/7DPO4pkBr4N2xcU6ArgqWRB?=
 =?us-ascii?Q?F2od8xT+VsFdohQreoC2kF+AUh1/gt5i7pbzvYK+eu1dPdYiT6LKkquBaeeD?=
 =?us-ascii?Q?bxUe2sXm6EuYbh1lu7hUkySJo+/hhCGXU//WZrSsVauPd0ogyNaA6I1wOYYH?=
 =?us-ascii?Q?w+JMVH96c7OqvFeVoI8WXRNNZ+woCafBNF9ByPA6LB04k5N/vh1Lhm2jS3Fa?=
 =?us-ascii?Q?KrqYnACLlc/Mts6HwJoG+p3WV1WdPeTOLULMDJOhx/gHHUSLw8k0pDADcmBZ?=
 =?us-ascii?Q?5+CDlPp6dGK3+ZdrMEBC4vdaUEaXXsjm0w99kz6q11rIRk8CZ7GR4yK5wktm?=
 =?us-ascii?Q?FfrW6R+9II5QZtm6KAzg2unnxR9msoFOU0vd8VRCah3T7CUa204jwQv49bRm?=
 =?us-ascii?Q?o3jjYUTyeJxXzFftdIbB1y37Z90JzsxN1wCFOOvbsyVsS7PlWqVIImni5L9w?=
 =?us-ascii?Q?qi+INXp2ZB+PGieWI499b+oq3JRgKbIEyeQFtjRBokl5+/kXVF5kuUOqNhwH?=
 =?us-ascii?Q?kFBc4Hn88Daa50gRAj/9r7PJ+2upZLXmf2p8SALS7ULx9pe1bU8E9rOD0MJ+?=
 =?us-ascii?Q?m30FrQKOoVSJ7eI8GXqn8IpkfX+nu3+eof+kc86xyTsyrIFfx+6hsJZ0QNdD?=
 =?us-ascii?Q?tFTQpVlshUjhbSjju7ioLc7gujKHM3B7F4TTJiiZDix8XoiotBU8cV3vGznk?=
 =?us-ascii?Q?qwJfAW4OpXqNNcDuRurhRyZmRj7B1J4U2BJ2Mgu75WJZx2/gDyTZiZNzHjpA?=
 =?us-ascii?Q?MfT0ZwQikwLIfEPR7C5e8YmN894TyG4qIV5jvZ/IPsxgYNw6LE/s1zfhnGJU?=
 =?us-ascii?Q?D9jJFhW6PC8FDD79cEbQXefJX0Iy7NUDX6VZCh0uhcgq8GZAKxo3FyzFQ1Cj?=
 =?us-ascii?Q?QVqnH7Qi12o5SLD3psKcm08AYrBeXLxn24G0VeqPdMRpStjrHWShEXxHpW+b?=
 =?us-ascii?Q?e/Oyz2PjRMkec1Jt6j5gByGdT1WNHYI1fRcI2rxxDkoLAfoMepPnxMOvOXy+?=
 =?us-ascii?Q?B94QiUkZxmRU+erooiPz9UEUrnOY9XdtoFVRMla9FeOhDbuW0HAU5LCp26u0?=
 =?us-ascii?Q?89U8cqoPHnh67muJcoTBwKlnTDlUkdlnwiqCRnnLn0QWhHAHWf8Gma+af+Q2?=
 =?us-ascii?Q?m3LT1uG3zQGnhYN8SsZZ1lD7M9QzW374KAbgISC/HL20pr43WoSwrhAe+U6g?=
 =?us-ascii?Q?vshkajNZBogw7fjJI481CZ/nYY2umkyuZ5Wf/00iOykvtkGE6fS83UMMNe9H?=
 =?us-ascii?Q?D0+xhDyEK0c3ZnUyqYq1JIi2NT4D18bedy87ADmboq/4M2oSpe/bcl5QYDE5?=
 =?us-ascii?Q?c/iVpWRBMmsgy1xVKexY9tJLncLRbTb1AKwLXIqlb4FUmeWYjwEM+uo0EPNH?=
 =?us-ascii?Q?gDDClDlJaDDSK0qKYoJmW8MXJoCuhuDNxwwUZiA/YRXJYWc3AFmAuj95Z9dQ?=
 =?us-ascii?Q?bd2Z1W5bPn/kc9X+B7MdSnTvYR1xvoyuY7dAwJAwlt/6nZF9Hi4VGUlJZ3qb?=
 =?us-ascii?Q?63L/TpxB+L+gSlk0OrM7Uzv6nSkJ610u4GeF2AK2gRUpQL6S2A/KeFtcbXxs?=
 =?us-ascii?Q?0JaAGr9tALgo53tNTuEVKs3m/kkNaFhLzhSnrd4/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d5ce5-fcbd-4152-c4be-08db10182312
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 12:20:05.6593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+nd+IYMMFQE4OSHWmdvGMPkgiGEw1Kr2Vi0tQfiODjIRmjsw7gWCt/6OpUT386g6TZIZ5hvvdn4WRHe2r//UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
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

[AMD Official Use Only - General]



> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, February 16, 2023 3:58 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
> bad page
>=20
> If a UMC bad page is reserved but not freed by an application, the applic=
ation
> may trigger uncorrectable error repeatly by accessing the page.
>=20
> v2: add specific function to do the check.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24
> ++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  4 ++++
>  3 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6e543558386d..5214034e1b16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2115,6 +2115,30 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev)
>  	return 0;
>  }
>=20
> +/* Return false if all pages have been reserved before, no new bad page
> + * is found, otherwise return true.
> + * Note: the function should be called between
> amdgpu_ras_add_bad_pages
> + * and amdgpu_ras_save_bad_pages.
> + */
> +bool amdgpu_ras_new_bad_page_is_added(struct amdgpu_device *adev)
> {
> +	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +	struct ras_err_handler_data *data;
> +	struct amdgpu_ras_eeprom_control *control;
> +	int save_count;
> +
> +	if (!con || !con->eh_data)
> +		return false;
> +
> +	mutex_lock(&con->recovery_lock);
> +	control =3D &con->eeprom_control;
> +	data =3D con->eh_data;
> +	save_count =3D data->count - control->ras_num_recs;
> +	mutex_unlock(&con->recovery_lock);
> +
> +	return (save_count ? true : false);
> +}
> +
>  /*
>   * read error record array in eeprom and reserve enough space for
>   * storing new bad pages
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index f2ad999993f6..606b75c36848 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -549,6 +549,8 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>=20
>  int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
>=20
> +bool amdgpu_ras_new_bad_page_is_added(struct amdgpu_device *adev);
> +
>  static inline enum ta_ras_block
>  amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
>  	switch (block) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1c7fcb4f2380..1146e65c22be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -147,6 +147,10 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>  			err_data->err_addr_cnt) {
>  			amdgpu_ras_add_bad_pages(adev, err_data-
> >err_addr,
>  						err_data->err_addr_cnt);
> +			/* if no new bad page is found, no need to increase
> ue count */
> +			if (!amdgpu_ras_new_bad_page_is_added(adev))
> +				err_data->ue_count =3D 0;

[Stanley]: There is a scenario, a UMC bad page is reserved but not freed by=
 an application, the application accesses the above reserved page and it al=
so
accesses a new bad page, driver read 2 ue count but save one new bad page, =
the err_data->ue_count should be set to 1.

> +
>  			amdgpu_ras_save_bad_pages(adev);
>=20
>  			amdgpu_dpm_send_hbm_bad_pages_num(adev,
> con->eeprom_control.ras_num_recs);
> --
> 2.35.1
