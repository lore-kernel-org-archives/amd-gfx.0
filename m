Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 08:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C328B10E183;
	Tue,  4 Jan 2022 08:24:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBACE10E182
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 08:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqsC1qOTmBVU5hEU5aD0oUM0pPZtNklTBk7R5yYUmm4RpGM5pLeDWu/+crmjuBpZa83k5CfvNIJlR8zIA8tUFXo0hKUvECD/DScQyuu1Qu6Q52ntq6nWAwWPz1TpDt4opjPQM3qh3hNF/oVPUF/T9uE0Px2sEw0QVaKZclGofKd2GswvsZCGyf8KZL8qmkBpFeAe4fp/AWBKOz7epyXWDJlyMWNNX1R9MbEZvPx4IwkF0V72x1vVZLQG1hQkKN+cCPeIpLKcEDqpP/99mBRlnONRtJjU3x+vIm5NGP81zTfHyPC+8VsvPCLIg/aAZpedO+nCR16UWEkh2OVaoymp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnxKDPpi5lSb1C4+1qcasZzBTnIFCtfEecGMM9AWEWE=;
 b=ZxJhZoMHTG/80+AESW5VdZJ3Rmi9y78TwIC4VbiD9i++qPvcTLC6E2gcTh1iLBqfQScJgAri+zanljjhxGCwFojkg4vkmNpqg2yGGFa1lNJVur1tq2pPPAeW700+HXTrbff9ZbtO8bYHpt95RNRcZwUhBgfbYsnr93Z7XMbR7f8D3GOtW/KAB7BSL3JbgJoKraQLIWJeIgTBpovehi4m+4rlJkCQAIMJ8W71p7OR7Xujo7yxMRD4+4smEhH+tqGpvTk2Q3STVnGxCxK+c2a+n/dQRzAMk/dJB/e03BWGXO2b9HksUSfFjjVemCBPhGEozo14RY8HoK9tzg3qf/kmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnxKDPpi5lSb1C4+1qcasZzBTnIFCtfEecGMM9AWEWE=;
 b=ENy8yl6CjL3jDlJ1sRaLucwEgASxpxbaK5/oppdboDkBEH6/JIVAe6mTxKytgdviiSyBurwx2rwHWKCHxSZQ69a95cHbq3jFA9WZjqdxrAFq7JUSYLPf5SfoV1BxUnoUUf0k/Ps2n7kALaapt1Y5kRzLX+IsXLOglkfdRIRIlfg=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 08:24:43 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 08:24:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 01/12] drm/amdgpu: Unify ras block interface for each
 ras block
Thread-Topic: [PATCH V3 01/12] drm/amdgpu: Unify ras block interface for each
 ras block
Thread-Index: AQHX/H3piuhfz9DYb0iE0hHD68Dk+axSjunA
Date: Tue, 4 Jan 2022 08:24:43 +0000
Message-ID: <DM6PR12MB46504082B6258EE688AA8FD5B04A9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-04T08:20:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=41390b6d-2953-45f9-8206-76036f2e1dbb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-04T08:24:39Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 43598d4e-b2f0-4d91-9424-dd19de5286bc
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e300adc1-b779-4713-8fc9-08d9cf5ba91b
x-ms-traffictypediagnostic: DM5PR1201MB0249:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB024986C8F8753AFC8BF3C780B04A9@DM5PR1201MB0249.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3jdpq7a+ZzExVBMqbzS9HmmQfSzDj3GRNEz8c++cCqWcddRp/sgSx7BDa3mAp7U6Lboop+I4og17LIixsobh2eeXdgwpZCujvxMH+dsnFVY/eZL7xUvShKboqGTMgfiCqEip5QV/3JTIaOlwRqweLHOUKCL3lpdkYdA2Z0xqI6Xdq1/AURaR4UMahkl9t2Phwm3fcnbize+Iu8MATL2N6KgDq1BIMQDcgT3JPS5hyXOlwishMSlkH7J2d8VOCdMsFOQRb3OMmyWMEJNFKZG0Ok+CIM6eSbLSFHCubwB1KQ187x2Jt33poNOfOIUJ0v6vrKH9MfM05JAgQAT7X27TRH7Kfv0pel+3idcQZnkUhI8ZI3NmOb+EZ0kiT66ndzkTB1aqZZzua/+j9FDj8ookl/sO0n6vBewIdxBR5RZwG0zlO5j1RSSj4gatJs3Dk/M+raUUtLctkZ+YlabnJKVctbclTeg4UuzRtxia1DVK06B7uSvU2HV5o/Ny4rXtFfuEhT0V31kSDbp8vOjEExFV3nija6HWkX1pvLxScWwdlLIvh6mj4a4g0cq71qQwF7OR+MVq5s5dqS8N4JJr4jW+zURh1X5ZLker/NhbOB2FOfcfSXNRjwinDo0r8L55HXZmY/y8Rja6mHVzNcmpYcoBcPl5OQyLoFZZ/WMRMT5Sx0MqbCCz73TbS8awsWJBbGEzgnlHrzQeKD8mo+25BjXuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(55016003)(4326008)(66446008)(66476007)(86362001)(6506007)(110136005)(122000001)(83380400001)(54906003)(52536014)(508600001)(7696005)(53546011)(38100700002)(66556008)(64756008)(8936002)(38070700005)(8676002)(33656002)(9686003)(5660300002)(71200400001)(76116006)(186003)(26005)(316002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qjEC+cCDNiL43PbUbAN+vqh0iHjIrF/oudRLg1Ey7B3nCL6mS6dChSVSykoJ?=
 =?us-ascii?Q?/H+EDYhLT/fAQUV5aH5afL+Oh478p9+f3368rIeiBPAR8SAoGFrWDiJIsEOx?=
 =?us-ascii?Q?ghPni2pXSPsDFhdS6GxUBEpLyhdhvXooSt68WLv4yVsV+9L7nlqMe5RQhxxj?=
 =?us-ascii?Q?/oq8sLi4K7w8AdQqRLoD/D+Et5x2FxRWuB1jhPKnhhDZP510MGjnd7UJZuAX?=
 =?us-ascii?Q?0SREdsAL1KND0jgJlixOTM7UIKfBhB9ksz1J7mkbVzsVHwnxwUIvdY60zObd?=
 =?us-ascii?Q?T6ZOvP6psJWdUlgWS02Ft8HLeqP6s3OGYEjE1Jc5i5msV+nAQEBg089I3mmS?=
 =?us-ascii?Q?X9d1nWm15tac23U4yi3fqvV3ss1zUhz7veAfZVEqFsCtb+UauNKXrVR7yofH?=
 =?us-ascii?Q?tcbYzPDXQhh8fgw4cVf88zCn5g+s/MfQ4jGi5LUPcx1SesO1Wgrx2YWORJMq?=
 =?us-ascii?Q?1gxbcwWAduTUotr7wg6N7KANnG+4MvFHe1+oX/Demw5oCQvEJC/fghMeAsb+?=
 =?us-ascii?Q?Dep9Sl1aCIHhXzLVwh21qV4I8CusjizM0yFolmgB/WeKC/wE+JD0gGGcvxcP?=
 =?us-ascii?Q?RbPMCQOQidX64/I+5+5uZvVpps2h3BzxPAuR1Y6cUGHhh3xpE/SDRRRK/Jmi?=
 =?us-ascii?Q?PnSvp1Ip4F50NdsvuZBWJkaKN3b0TBzY8sFG58qVj6CKee6VVwnNVWQ+PJUm?=
 =?us-ascii?Q?tDpJCswOwLrYMGHDciVpagxMIfMUdBgR0OBf/O3Hnp8R/LIjY2H4taC/qMAj?=
 =?us-ascii?Q?4fZ3KmLfLdgTPQqpoYjpze6W+of/OCfqCgSLAIErnYyDpsvwejibKcep++Hb?=
 =?us-ascii?Q?rY2ycqUGtibO4Ywr4neu4E8iR7QX1gx7GfoQSwQkscVHTwk/RcXhXRctBjeS?=
 =?us-ascii?Q?+LwxqikbVxO3QkVfmGTbHnN0NLgxeINpXu7k4G+5RBTISzFHSTrICNwc0iik?=
 =?us-ascii?Q?aUCHPr7b6g8hunePe9xYSuLG6tHt6vQM/rFpcoMBaBuxP0rHVTPJEdjkg56d?=
 =?us-ascii?Q?oqofN9+J6E8MQ1zra+p4uKrLYBCYWF7c+HPjOeUrDgntJS3w/uu9xi5IVFt8?=
 =?us-ascii?Q?MUtbV3N0pxyeZaxuotdhnESrm45zG9gnMI/RSsHCjxrXggsAmlKlB7tEuHSe?=
 =?us-ascii?Q?xaXXmHJUuA1/ibS44lFKu0M+px4CQ2zOltPhTr/lTOEVJueGfVLnPItM3hm8?=
 =?us-ascii?Q?bEGmwMD8suWmghTW9wTHLKIjt4Oqtb1twSF55go19xWZahsqy3Kct2Lxsud6?=
 =?us-ascii?Q?TIDlcOoclV8WTGFFLA6y0n7DphJAUpzpSYKU3oZt1yP+dLf8z5ETfwHrebmN?=
 =?us-ascii?Q?2wED9Ebx3v9Z9ekWMlBRfaO6SavYbD1xhbeo/x7FRquKgCQe1VUGufX4L6p4?=
 =?us-ascii?Q?VoGVTsmxI+/TBNKFPRn6fW2xS96/vvNLyutk9OqcA0+dL/OMFzHLZ7RBE1+V?=
 =?us-ascii?Q?2bhJ27/BwRFwitvYDgEhazf+6BeMwKaqz4CTPn7y9qUrgF+yMizNvC9P+NHc?=
 =?us-ascii?Q?oVCE/xMIJaJAyh+wWle7eKnJ5a/uKDPEbi7xrmbexXY417d2ZcNYdAN02A/U?=
 =?us-ascii?Q?o2gdWX0lUl2bi1rMc88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e300adc1-b779-4713-8fc9-08d9cf5ba91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 08:24:43.4955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kbCn/QqT/4vDuIpRW9fQ/nmOrcoazqitx/siXHOnUna4p9+RRcoBZ39VGO0k3A8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0249
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Please make sure basic RAS tests are successful before submit the series.

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 29, 2021 2:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V3 01/12] drm/amdgpu: Unify ras block interface for each =
ras
> block
>=20
> 1. Define unified ops interface for each block.
> 2. Add ras_block_match function pointer in ops interface, each ras block =
can
> customize specail match function to identify itself.
> 3. Add amdgpu_ras_block_match_default new function. If a ras block doesn'=
t
> define .ras_block_match, default execute amdgpu_ras_block_match_default t=
o
> identify this ras block.
> 4. Define unified basic ras block data for each ras block.
> 5. Create dedicated amdgpu device ras block link list to manage all of th=
e ras
> blocks.
> 6. Add amdgpu_ras_register_ras_block new function interface for each ras =
block
> to register itself to ras controlling block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 46 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    | 28 +++++++++++++
>  4 files changed, 78 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index db1505455761..eddf230856e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1151,6 +1151,8 @@ struct amdgpu_device {
>  	bool				barrier_has_auto_waitcnt;
>=20
>  	struct amdgpu_reset_control     *reset_cntl;
> +
> +	struct list_head		ras_list;
>  };
>=20
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)=
 diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 73ec46140d68..0980396ee709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3578,6 +3578,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>=20
>  	INIT_LIST_HEAD(&adev->reset_list);
>=20
> +	INIT_LIST_HEAD(&adev->ras_list);
> +
>  	INIT_DELAYED_WORK(&adev->delayed_init_work,
>  			  amdgpu_device_delayed_init_work_handler);
>  	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 90f0db3b4f65..9dd698354e04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -862,6 +862,40 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,  }
>  /* feature ctl end */
>=20
> +int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object*
> +block_obj, enum amdgpu_ras_block block) {
> +	if(!block_obj)
> +		return -EINVAL;
> +
> +	if (block_obj->block =3D=3D block)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct
> amdgpu_device *adev,
> +					enum amdgpu_ras_block block,
> uint32_t sub_block_index) {
> +	struct amdgpu_ras_block_object *obj, *tmp;
> +
> +	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
> +		return NULL;
> +
> +	if (!amdgpu_ras_is_supported(adev, block))
> +		return NULL;
> +
> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if (obj->ras_block_match) {
> +			if (obj->ras_block_match(obj, block, sub_block_index)
> =3D=3D 0)
> +				return obj;
> +		} else {
> +			if (amdgpu_ras_block_match_default(obj, block) =3D=3D 0)
> +				return obj;
> +		}
> +	}
> +
> +	return NULL;
> +}
>=20
>  void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
>  				       struct ras_common_if *ras_block, @@ -
> 2739,3 +2773,15 @@ static void
> amdgpu_register_bad_pages_mca_notifier(void)
>          }
>  }
>  #endif
> +/* Register each ip ras block into amdgpu ras */ int
> +amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> +		struct amdgpu_ras_block_object* ras_block_obj) {
> +	if (!adev || !ras_block_obj)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&ras_block_obj->node);
> +	list_add_tail(&ras_block_obj->node, &adev->ras_list);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index cdd0010a5389..9dbe8d49b891 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -469,6 +469,33 @@ struct ras_debug_if {
>  	};
>  	int op;
>  };
> +
> +struct amdgpu_ras_block_object {
> +	/* block name */
> +	char name[32];
> +
> +	enum amdgpu_ras_block block;
> +
> +	uint32_t sub_block_index;
> +
> +	/* ras block link */
> +	struct list_head node;
> +
> +	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
> enum amdgpu_ras_block block, uint32_t sub_block_index);
> +	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
> +	void (*ras_fini)(struct amdgpu_device *adev);
> +	const struct amdgpu_ras_block_hw_ops *hw_ops; };
> +
> +struct amdgpu_ras_block_hw_ops {
> +	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
> +	void (*query_ras_error_count)(struct amdgpu_device *adev,void
> *ras_error_status);
> +	void (*query_ras_error_status)(struct amdgpu_device *adev);
> +	void (*query_ras_error_address)(struct amdgpu_device *adev, void
> *ras_error_status);
> +	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> +	void (*reset_ras_error_status)(struct amdgpu_device *adev); };
> +
>  /* work flow
>   * vbios
>   * 1: ras feature enable (enabled by default) @@ -652,4 +679,5 @@ const =
char
> *get_ras_block_str(struct ras_common_if *ras_block);
>=20
>  bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
>=20
> +int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
> +amdgpu_ras_block_object* ras_block_obj);
>  #endif
> --
> 2.25.1
