Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF3FC636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 06:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B08210E3C7;
	Fri, 17 Feb 2023 06:49:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEC110E3C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 06:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJo+m7vInicWoAhh1RZuUelRZXWE0DqnKzXZtSEJsJ7C5GH2Pe8cKHyJtKIz+gq59vWYBV+AtXTKuUPf0HI1edy7MqmqAp68T+8n3O13Vb6CkpIMYUBKXqc5LXoape/k3WNgqhMtCiCL38Qz4tna7VVdEz1EemVzpDOhkwBjf9bedY9GH5sSGOpPczzcUbm/UwrEivgUmOBbl4k3dCTZ8m1ogLnI9oEY0RAD8R23CWgiIpuz/VbqIKOznvAn9R2Q2EqUxauc1bkMbRPIf9bZGYhoFklvffkVDihyR+yRAzExhwXSSGPCtFJWfLrIaSnU8tmBQcZql/rJW/HXK6WOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KkVdFxPsFB2TLuj53BVR8rY4VvEb/RP0Hk9FEKs5Os=;
 b=gNGoPhP8fO4ZUHyaTRuxtovIIQU96YMMGRuPV/hPoCkk6tB+nsOyDoXpn89MO7OsjeT6J7kp8z5ObAxum8RtrGuVpvbkGT/5v53SebOJLEPNpnEQhVVfYkIsbD+mVKRIV3NYuwBH6v5YUPQGDT6F3FQhCxC/kHvacmBv6UUZQvPR9dRIWtL4dVEWNnbgmNX8HWuml73QPiaxVhllfjOY4qMo5Mh8qd5QIc0NrOqAFyE2he87SjqQ6IrDVLw9UrRrspyCPaUsXMNJb+CeylwNsiVoqyGMVpQgaxvkJ3uUbVeSilgK6sBq4XGQQhgOhxvdK2FM/zvpsY/Ys2QWbdwQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KkVdFxPsFB2TLuj53BVR8rY4VvEb/RP0Hk9FEKs5Os=;
 b=X1YUm7tSYU8udaFm5GhS9VqYdDMmQo0HEnRviaCanWC6jBBNngP2UPIU7q81wpWyUZYSJ/wuedIz5COqQ4dduCtadmPB8xojSHk3uNkeoCoqT54A1m0t4nmz1bw2SMrjjY3nT0fphMU57z4LlBRed0Jweivc8dijxRU/2QmnycI=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 06:49:18 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%5]) with mapi id 15.20.6111.012; Fri, 17 Feb 2023
 06:49:18 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Topic: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Index: AQHZQoNkTWR4jXN+vUSLYVg8GDoSMq7SrFWw
Date: Fri, 17 Feb 2023 06:49:18 +0000
Message-ID: <BL1PR12MB53343627587AF8AC1088D8FA9AA19@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230217035313.4616-1-tao.zhou1@amd.com>
 <20230217035313.4616-2-tao.zhou1@amd.com>
In-Reply-To: <20230217035313.4616-2-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-17T06:49:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=990ab9a0-7c2f-4ee6-ab85-9f32c6e72722;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-17T06:49:16Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6e34d701-97dc-48d8-89fc-ebc6d6264a4c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DM4PR12MB5280:EE_
x-ms-office365-filtering-correlation-id: fb5f745b-f366-4624-25c9-08db10b317b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzcMFdxO/nOO/NrlMPBcOF3Vk0LXeBdF5Vgghh6TKcE7BLDzl2VDxZWZrsum/KwEpU4xfGRWOusMPu7FdlJnRbqz7yBGNplW1KthDpk53kcRNjBaYDpbI5n0k0Qab/5eP5jgQhgtUq5iIixG9BhM3nH+sVmUJ2jcuOvARfbQcXXD+Yh3VGHQDQc0pmX3zXHR0YRVLiBpe8TzQQ4JpLFkRkDZYHR+7ttYRENfluehjM5Uvfwox4Px7iXfQOCYi7ztNMMWoHQaHa+jRG0VPO6ziAGIfhGG+/Pm8nXHXc9s0DU0EsApkt+X2wr1WVm3KacQINUr2tScPesLNQWh2F11lwn7vs1HJerzdglBFcRRQY5RkoOdP6KX3I1mY5ReuywCIub/UHrSMIQ8OR1nApYMvIixglFneACeQ1Rr+krRkyIvBL6GArD0/EvYhH3BMqaHMdh+HFgK9bdiabhJikKrWLfJIeOnzhuxXu4cSKkKixdQnLwyNo4223bi4AXdolIhsPTc0HTZ8rcSJ38h+rqzaBrgFkmxLFP7ICWYfShJe55W62egLpC4opIcK0lZ34HulY6QzS8OCIjjloInXjAd8GFw+IpHFrxOMaJajRgOJv/DDGakfL00eP8dDhtMN1+oGcVA46KLpnXshyat4tCoF3kYGGz270fQ0X/XaVKNfEAt+Wb/DYyuwYgZ2+nCCDjVqt3KumnxEcmoyVZt+KI3zV6PftwGwcEZAVsGmKE7iF8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(9686003)(55016003)(33656002)(122000001)(921005)(38070700005)(38100700002)(86362001)(478600001)(6506007)(186003)(83380400001)(7696005)(53546011)(26005)(71200400001)(66476007)(2906002)(64756008)(8676002)(66946007)(66556008)(76116006)(66446008)(5660300002)(8936002)(52536014)(41300700001)(6636002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hLR0HguwhsyzXPzRw7JjL9LdW3NlSIuw5nT8vSNZfo5QRtcag8RTq38RQcnd?=
 =?us-ascii?Q?NqhNrBKtrQ175InJmlRKSHn/bxN5abnf00RplOsRES7jp3A3C9J18oz/7cBI?=
 =?us-ascii?Q?xhK1TWey07OFhLD9KjOYZLPC8OMsBJOAq/bETMGPeoB0CHe51ydPkJ0aYmKG?=
 =?us-ascii?Q?26x94bXAg2dsNXGIpWxPOl+N8Sd8uLcSZkxN4ud3TF8ZJoFQsA4/tD6ZNv1q?=
 =?us-ascii?Q?D2Fj3eOLlQgFF2yHeTYYw8nm+fBUZ4MvlZs52Vv0gzwWGeIgwsBr+1W9IbXV?=
 =?us-ascii?Q?1jskq4gfUHBplNhKMJ6yo8vItns3Trvz5gBeg9d+YRuVhiHdoIN+HnDqMHT2?=
 =?us-ascii?Q?2779aYKNmBsK5SKxHcr1MohwJ1AyAXN1rJFk7QZDzOiYJdFy/9AgcCOMHms3?=
 =?us-ascii?Q?TxvNfneYkumpailWp8hUPpqlXIDCXtppA81ocS+O/+f1xRo5GQDBWxJ9NKp2?=
 =?us-ascii?Q?6k5DD6/pehkNYts76xS4mtU3IVKau//RU6XQc+U7+V2V2L7xqkODeuV5h8bN?=
 =?us-ascii?Q?l8dAqjb1RKnzalvf7/8fE1Ljm4zsk6zhIerEHFWnuux++nBdtM1ipTX0Vsth?=
 =?us-ascii?Q?70kjq6oauXfCOQmY24vuOiuwy0w5gg0Un7W5BvjB8vd7PyowIct26fFLAoY8?=
 =?us-ascii?Q?m/w44OYw02wQMFRX0w6kWog40ab8fZ2o8lTpAlgohjt9sqOAxI5k4Z/txC38?=
 =?us-ascii?Q?/4YsH0Ue4F9YcnV30BuPY3erPXMMGfD6wvhgQFktyV3xADMZQpDxvx3mHtL2?=
 =?us-ascii?Q?JKU1pK/wX0UR627RStMewCtB5sRa0OAqoPSqQ196Csq8nc9fmFVQ8sxN9R2s?=
 =?us-ascii?Q?t+DZdUQ4iRg3eZq+yQ3rsAWImClWJ9NZL6okzU/b5AtgQZniTceWL7WULrk1?=
 =?us-ascii?Q?SAcIfK+8wU+9YkitwZR9b7gtgk7z8FUp6t1z3K42ruK0kBvzoitAmAixU9/5?=
 =?us-ascii?Q?CULhvyKpyQjXBi5jj13P8l0Ycnjb7rE9EJZ5TPMT6J0T8qXUJ3BBAIx1biPb?=
 =?us-ascii?Q?GdBd+Eiym6pkVUqzl91ipZ2dK3YC0gCXpsi8Li9Tc4G6KxSjbYyQqkngcy06?=
 =?us-ascii?Q?WlSP0M/5LzxEApOHv7+P3yeRCpwK1paAHXshzyJuAwX8SJOo+v3c/44BIBGJ?=
 =?us-ascii?Q?7CB5KBifAO+zjyTfGzId5bTCloCuBfSLml3KgX/bzLtnPqf5f3aGQoxRoN5A?=
 =?us-ascii?Q?XHc7d63vc+hd/8GO8Gs1ruOz+so9NW+wWFkbi7HcMtSd8xiMjrIDdnhPorU5?=
 =?us-ascii?Q?w5KBds+ZzqseRNRmLHUx7UkaQlfvm0ExdzcET7TEqF1ilkZ4UOFdGSCJzyX2?=
 =?us-ascii?Q?O1OUw3AbPkGgVg5phEP7gfel3N94iQNq+vvA3hYnc0cwsSj/OYeC0c1ad/uN?=
 =?us-ascii?Q?yCznmV6KdSl76o7qO41JIFZMYtWapUNOaRtbfRuOthP89FUV+cwEODGxUzvI?=
 =?us-ascii?Q?gmOhERWBflqf86JnwYLmn77YoFWRXXHpjm7MfcsHqvODB80bSFIk1RjDFmBB?=
 =?us-ascii?Q?vWTWCkLdD3hXQCa4GmlqX65ia/E8j4w5+uMMWE11Mv3a/qOxYlGcK8gvUjV9?=
 =?us-ascii?Q?lFgaEOfd0h1ODMs60kR+3S98rqzp7vlNAcdsAhVC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5f745b-f366-4624-25c9-08db10b317b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 06:49:18.5722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qx1yLO3HTSOkWmYWQWoQGfqXi1wlwNLEp2jJaivDAc+UvtUM5aiAV7NmHCbW7oigI0RMJsWCzOVllPqUkrdlhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280
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
> Sent: Friday, February 17, 2023 11:53 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS
> UE count
>=20
> If a UMC bad page is reserved but not freed by an application, the applic=
ation
> may trigger uncorrectable error repeatly by accessing the page.
>=20
> v2: add specific function to do the check.
> v3: remove duplicate pages, calculate new added bad page number.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23
> +++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  2 ++
>  3 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6e543558386d..777f85f3e5eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2115,6 +2115,29 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev)
>  	return 0;
>  }
>=20
> +/* Remove duplicate pages, calculate new added bad page number.
> + * Note: the function should be called between
> amdgpu_ras_add_bad_pages
> + * and amdgpu_ras_save_bad_pages.
> + */
> +int amdgpu_ras_umc_new_ue_count(struct amdgpu_device *adev) {
> +	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +	struct ras_err_handler_data *data;
> +	struct amdgpu_ras_eeprom_control *control;
> +	int save_count;
> +
> +	if (!con || !con->eh_data)
> +		return 0;
> +
> +	mutex_lock(&con->recovery_lock);
> +	control =3D &con->eeprom_control;
> +	data =3D con->eh_data;
> +	save_count =3D data->count - control->ras_num_recs;
> +	mutex_unlock(&con->recovery_lock);
> +
> +	return (save_count / adev->umc.retire_unit); }

Stanley: It's better add comments about the return value.
Without above concern the patch is Reviewed-by: Stanley.Yang <Stanley.Yang@=
amd.com>

> +
>  /*
>   * read error record array in eeprom and reserve enough space for
>   * storing new bad pages
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index f2ad999993f6..e89c95438a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -549,6 +549,8 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>=20
>  int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
>=20
> +int amdgpu_ras_umc_new_ue_count(struct amdgpu_device *adev);
> +
>  static inline enum ta_ras_block
>  amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
>  	switch (block) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1c7fcb4f2380..45b6be7277dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -147,6 +147,8 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>  			err_data->err_addr_cnt) {
>  			amdgpu_ras_add_bad_pages(adev, err_data-
> >err_addr,
>  						err_data->err_addr_cnt);
> +			err_data->ue_count =3D
> amdgpu_ras_umc_new_ue_count(adev);
> +
>  			amdgpu_ras_save_bad_pages(adev);
>=20
>  			amdgpu_dpm_send_hbm_bad_pages_num(adev,
> con->eeprom_control.ras_num_recs);
> --
> 2.35.1
