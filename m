Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B21EC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 03:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A8D10E1ED;
	Mon, 26 Sep 2022 03:15:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A3610E4E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 03:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2732ngQemCOgnBPvhkEzglj/OlFTlArOu4woQwEMhn4hnenKoA+pY+Y1cdpnlwOchnOCOQbSZaynIsUFgP75WNZvsq2g2OncIvXWTtcFiB2DBYTPTx62JMFx1G5SzwSnWUZzYc+wfiCwqcExj7eS45JnqxnfSIwxnafLIv+RhgGj6Z6FY80+jQHHj2zkleD/cezOn5BccNFD1ydPrOVPvh2/sXCRvpSD8wiJ5Buq6kLkbzbVs6XhRzFQ79abxxkvySHnkHm5OTyxiL06pE4tv68CNc9gR12NDgqKtzPcAB5jOTvbCWX+M4kxFv0RUb8AMnEomzkM2mzo83coNMlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzpPVGs73bnjWEkjbGROLWxdzREb2Tk472n1PbYc7Cc=;
 b=WfwiWWnga8ZFj9jKhpqWUhDVWqIUrt9A54DEoGYBfiuHnDz+LIxp3ODTl3fzQYBXnkQXunr3Sc5LMawZd/HBlNulTMp061qfj+A0ysHFg5TdRNTx1rsVgddyn3j5UPzDj2CdcTwJc0IpO4htueiDilX+L4sY9Fp4Qgp1czWjtP0fLJq1K6pJd3/bXu/zgoU3Im5W32H2wdB7omzm14m8o/Wa7cIY4Eehk/jhtyD/i0//6T98R9TDskY7cqHZWV6in1kwWaGNKMqGkJh8JpA6/hFqgb7SzbnWDi2sf+iU81MIm5iZWQSA4LcURXgyTzsyLWJsqc8945WSs2REVAn0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzpPVGs73bnjWEkjbGROLWxdzREb2Tk472n1PbYc7Cc=;
 b=BXPxNQUrcj1V9/pDdNe8kBrPLop/ZP8N4bGJGimYs9hVoIEISC62f88abS1kwYLM4oaKLSK1r8ULVcGnjGMZ8tRrsx4FDWXNesfJO8lrRA0FGAV/VaO2euRcdU4+5IGlnZ23ukUFjcUy5CFkCk5IhfHkNHWc/6Xt2wOSvlcTTWs=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 03:15:26 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::8377:b2e:e686:c85]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::8377:b2e:e686:c85%2]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 03:15:26 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: export umc error address translation
 interface
Thread-Topic: [PATCH 1/4] drm/amdgpu: export umc error address translation
 interface
Thread-Index: AQHYzy3a9PR+k1AQH0CvfpFtDoOuCa3xC0BQ
Date: Mon, 26 Sep 2022 03:15:25 +0000
Message-ID: <BL1PR12MB533452B53F1C09D704ECBA239A529@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220923092112.14141-1-tao.zhou1@amd.com>
In-Reply-To: <20220923092112.14141-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-26T03:15:20Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=40607ca5-5af3-4dcd-9893-41cb1e9dba75;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-26T03:15:20Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 13c9cbc1-e232-4b10-81e3-654ff0a1ee01
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DM6PR12MB4185:EE_
x-ms-office365-filtering-correlation-id: 9bc10696-ce5d-401f-ad35-08da9f6d5b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Csx1RIlIFfoEp8hyCTd/TKKAH6ucxcYnuhTogc1QZxmdzT2uZ9PAq2ozn528wFbVXU4mQQRZpJNWBdxrjLXSzjCiPxwNlORnl5+VP0lAFfPliWRNDZlbHiqyFRSYja/kpyBAeBR3inCc6dCxDkiAb+Y2Nippe24tXhM+bJeChuAkULUD1Fs5N+y8ePqJLW5ByHIPwnXhvRkBPLVuyyUkm0K9/eypHoDTiwWS1TaHrnLa+gcAYrHIVh2bH+ighQDK16AckBdGPI7xHjoWf/NUrR9mmWyTzm15UyhLH4KAoSFLcLmQh9s6ng4D1WvYPsXCpocaqFkgQD00VzKuXfe2s+qeMCFGUqaj3S8IQhUhOQrXrbw6sGjD9GS4bcB608BXDYbepoafeRGz9BAdVJeQb++853pNusxBBwefmU98CL0EMt+5VPL7pgQY7644G+KPVmh0VHJlTQFW7GJJDlwBommi/JX3S7c7ZVf+yGPVdWjP7ezvH/xYl3p9HruWsdzn4e1wChg2ttuAFkNjTSpyHYxbHTYOUN1N6g3K1+h0+2CBXgc5kwxQxYnXx8E5/ZoUOFCF9JquAmQte+/1FgOexDcJqGEC6lCZ2y3xCAQjh5+4DC4KM+cNJV54cFCdueNY3NrvUgt+7phHMdDN5sbDb4F/Y0cpg1pLVO9noM9okPqJm6Rcxez3fCXEd06X3pLra+EyEo1N4fT5zx/ieuF52FmDynTevcoyDhskEw3JHRUpG0c6j1EW/6q2v/Mr2+ncrXmh06JK91xOGCDpGb+pIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(33656002)(86362001)(2906002)(52536014)(8936002)(38070700005)(66556008)(66476007)(64756008)(76116006)(8676002)(66446008)(38100700002)(316002)(110136005)(66946007)(6636002)(122000001)(71200400001)(9686003)(26005)(5660300002)(83380400001)(186003)(6506007)(41300700001)(478600001)(55016003)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yu2a5yhZgIDG4iXIvfEQjAq1CQyMt8MRXGTeApj/u+wtemj7XfMLfAEBe62H?=
 =?us-ascii?Q?1o2+4oO+8U3j1xH3SYOnPestXNfIrdQXqX5s0SQE48EuHnNkKUmMGbyjloqx?=
 =?us-ascii?Q?F2zDJGb4y4y7nXW9QWusbElLjvcpsn2HnshD3IgAe44+a0Os5shzxI0kO1rn?=
 =?us-ascii?Q?G5y6i7VNsQNaioDob9sKaplpG5gvGJG0ca74rkmhr29NrMYmGc3NBIzQGArv?=
 =?us-ascii?Q?2TtRwlitFI/hyUWwqfvt4vlERh547vXpH0XFbQAtS+bck+McuOfvJ2ODVOTj?=
 =?us-ascii?Q?bV7nDnq5UV3SnRJxBdfKiFvA8+Kto056V/9xl/b2bj7XS4QEc+OJlI3SDZyQ?=
 =?us-ascii?Q?+akLG8QGnHXX56gfuIa51SCCsHFQjb8CdLXUvvHbZuSa9yRw8LKVZc3P+RFe?=
 =?us-ascii?Q?r+KTReKs3JXVPsTdY1OHNc2cUakjq5u4QLQNRFTYueb/RSIdFjhlAZKLNkBd?=
 =?us-ascii?Q?9WGDVTQZzkhYSaCKonJoW6IcUa65H+GvlSt65lWmsfxF3KgKmiaE829b041C?=
 =?us-ascii?Q?SCHHpmkVyAzxeMaKJkjHyCKFCOjG1pN92E0dvksvI73cH5RwdQApzdNXubyX?=
 =?us-ascii?Q?CyhnuR5gMNydsp06gFhOg9E9By9gGgb5EDhxh+PUcG073WdhA0XUtkFZJFMt?=
 =?us-ascii?Q?NBnxpeTiHsLwUCSozatqeBfjyCGPEGSUWXfrUiWYI5JjagoKAu7ZpUo3M/FX?=
 =?us-ascii?Q?7LaaahriUUucGjLQJTGnXqGJ5VOIAjef7TqKkGz1oa3+5rKBpd3nNwNc1Now?=
 =?us-ascii?Q?Tngk/Qk2/A8SSis5w6cLNfKXRJLsTwMg4ubmFchIGT2+upS75+SNgyWajuuc?=
 =?us-ascii?Q?EKWerSo+JfYR7sPm6XHNLnVPNKtV6zGFUNBpXu7b6iGXdqSV2zN6N55SzQsA?=
 =?us-ascii?Q?R85+OoGPykfhk22NA8TMauWYCLrtVv5YyfoCJXrcMBc3D77CF7eS7W+R2wxH?=
 =?us-ascii?Q?ICZLNd3upd2F0losd0eS25sfy5dYI6TWTLKhRelum9s15IY6tdNOD0Negtar?=
 =?us-ascii?Q?q2iOIXiN5Q/P9afteQKqgHMnGyZe963EcsysDs565FKHUZWqb1luHwDXt9Vo?=
 =?us-ascii?Q?MPVfQ/orz5sQT7mQlUVatXkFS6IfjIXvMfkwa1mjwTQJj1jeFZmV3AAQq0Kd?=
 =?us-ascii?Q?VojO7LeUtDRMKpuFMoAMiySI6OHYDUkh1Z254Xa1FmtBWSqEBQetDgfYLPMn?=
 =?us-ascii?Q?uDk/Lb1DKNPnc2iZ1uBF9AyVNPRBth7SpYp+4ZTXsqZp26OTp+sqWrkOwqve?=
 =?us-ascii?Q?8xw3cf1eIu95XtS2HrJEq7fQCxf9Xpg8kfSmXPcTekuZV7iqo0X0zFX1HtMY?=
 =?us-ascii?Q?XaCNGyK7q2nVuC5MnRTSCLDOYPWJX1rJO/lpryDTFv0mL/vvgMTqTy+oF4R4?=
 =?us-ascii?Q?Zihvo+wrLYnqjPhDiU8pgrpv1X7CUhXpgRYX9dMgx4mUqWOBNqzJ6YUxWaNp?=
 =?us-ascii?Q?vJz9iuFGbaegEYJEf9Xh/E0bQRq8/Mowexaj1r1xmglmncifMwD7nfep5xRk?=
 =?us-ascii?Q?/d/JUPOiOPi7cscHrIjK6LN8hP8E/bPgwWJB1hiAgblLfiVRhroiMCTM8c58?=
 =?us-ascii?Q?KJo9xNFUrZOmzvb3JJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc10696-ce5d-401f-ad35-08da9f6d5b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 03:15:25.9101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R2jmqevS6ISHa+v562OKjdlYBebHD2nrcmeHO90fhpRMANoqUJGBFFRxw2IvOZ9vBo1rKg6B1I6dmsFrQqd3A==
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

[AMD Official Use Only - General]

Hi Tao,

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, September 23, 2022 5:21 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: export umc error address translation
> interface
>=20
> Make it globally so we can convert specific mca address.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 11 +++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 3629d8f292ef..31fbefaaf676 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -22,6 +22,8 @@
>  #define __AMDGPU_UMC_H__
>  #include "amdgpu_ras.h"
>=20
> +#define UMC_INVALID_ADDR 0x1ULL
> +
>  /*
>   * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
>   * is the index of 4KB block
> @@ -51,6 +53,10 @@ struct amdgpu_umc_ras {
>  	struct amdgpu_ras_block_object ras_block;
>  	void (*err_cnt_init)(struct amdgpu_device *adev);
>  	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
> +	void (*query_error_address_per_channel)(struct amdgpu_device
> *adev,
> +						 struct ras_err_data
> *err_data,
> +						 uint32_t umc_reg_offset,
> uint32_t ch_inst,
> +						 uint32_t umc_inst, uint64_t
> mca_addr);
>  	void (*ecc_info_query_ras_error_count)(struct amdgpu_device
> *adev,
>  				      void *ras_error_status);
>  	void (*ecc_info_query_ras_error_address)(struct amdgpu_device
> *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index bf7524f16b66..0f1b215653f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -452,9 +452,8 @@ static void umc_v6_7_query_ras_error_count(struct
> amdgpu_device *adev,
>=20
>  static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
>  					 struct ras_err_data *err_data,
> -					 uint32_t umc_reg_offset,
> -					 uint32_t ch_inst,
> -					 uint32_t umc_inst)
> +					 uint32_t umc_reg_offset, uint32_t
> ch_inst,
> +					 uint32_t umc_inst, uint64_t
> mca_addr)
>  {
>  	uint32_t mc_umc_status_addr;
>  	uint32_t channel_index;
> @@ -540,9 +539,8 @@ static void
> umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
>  							 ch_inst);
>  		umc_v6_7_query_error_address(adev,
>  					     err_data,
> -					     umc_reg_offset,
> -					     ch_inst,
> -					     umc_inst);
> +					     umc_reg_offset, ch_inst,
> +					     umc_inst, UMC_INVALID_ADDR);
>  	}
>  }
>=20
> @@ -583,4 +581,5 @@ struct amdgpu_umc_ras umc_v6_7_ras =3D {
>  	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
>  	.ecc_info_query_ras_error_count =3D
> umc_v6_7_ecc_info_query_ras_error_count,
>  	.ecc_info_query_ras_error_address =3D
> umc_v6_7_ecc_info_query_ras_error_address,
> +	.query_error_address_per_channel =3D
> umc_v6_7_query_error_address,

Stanley: According to patch#3, it's better to rename query_error_address_pe=
r_channel to covert/query_error_address_at_specific_channel due to the chan=
nel_instance and umc_instance get form the mce structure, using per_channel=
 may cause misunderstanding.

>  };
> --
> 2.35.1
