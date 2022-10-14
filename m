Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBF2C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5431110EA8C;
	Fri, 14 Oct 2022 06:35:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D0B10EA8C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZVLawcoIdov+aN8nrzZFLhV57O5C7p4VwDA+H76kO6mxtcUPHsYepu+HPtDAoXJz3heUOkf/GrPfo3FQpfun/Brf2L4u5wnOJHU4VUG6YBcfTqKz7KpmqTkG6VNp/sLWdiJutK0zKZPFaslswIgQUmmH6TWQgyseU6So/xNyUXNUwjJwMnRt6wNl807fkaZ4h1i/WD4WIGsD/EjniCQ1Mdg6oDGZ444Lw3eL1+AtU6CV8fxPCQpla2B6VpH/p1tBZ0MRNNhpatfUZrUdQHgJLieepqqrPLFf9JS7X6LL+1i+6f6FOiIrlcqMitlY6B8aF8j0uiqgvcMxlOj6gJ3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9jd2P4kPeV6uV6kcolVL8iDVJqUiS2jPWkpsW4eQe0=;
 b=eLTVve3Tcyexe5x++XlWMFQ/YupKno6jPRxGdshk1G/g6Pep++ZvIXlWzVQpr6XncZxeH85LMIGtYL+aGQJgzca91iJlb9noGTqzdaPnbz3CEh4rsa+4v9DQBYHHl3u459nW9RUusPRe5mED8HQeFodc7gMZmr1D6Xxr+C2H1tZDcWM6MFK6Y4RJdyJhBFPC3kWOpPFaoh3tR3iMth+RfHMQOpknQMAtoyKdmged8n+O+Q/IvrWh97fbyytrtgGgFK/l5BautPls5ZyVHLnD6XTDs4XNyI6UsS0BjeFlgGoesDPIPtx+dyLDUDHkCNo3UFfpoehACergdeqBeex7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9jd2P4kPeV6uV6kcolVL8iDVJqUiS2jPWkpsW4eQe0=;
 b=U/KahOWI8OAArSWaHKGDOsklQfyCm3akPqGpi4klyF2Zg0AG9zdIOUfWoZ8WTXdb/vkGJD026PRtTzpO3bNnAES34CqP7PYgZLJEnP3YlVb50PU7aQVc9ZunG4s2KzsxwmOwsqi3z2QiczHUNbj+oSUpHDYZytnCRJAOBaX7MJg=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 06:35:42 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::8377:b2e:e686:c85]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::8377:b2e:e686:c85%2]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 06:35:43 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
Thread-Topic: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
Thread-Index: AQHY35TsOxjxEb9js06GMhZmkVawe64NbyRQ
Date: Fri, 14 Oct 2022 06:35:43 +0000
Message-ID: <BL1PR12MB5334E4B9CCE12DB5DD0EE1579A249@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20221014061918.21494-1-Hawking.Zhang@amd.com>
In-Reply-To: <20221014061918.21494-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:35:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f930b50a-2b29-4f11-b710-f76a5e327403;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:35:40Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 04686d53-6a4c-4732-bb41-5251c4c7d063
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SJ0PR12MB6688:EE_
x-ms-office365-filtering-correlation-id: f2a1d269-37ed-48d1-29b4-08daadae51ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q09fyj2ULc+6HDpkwJAGKN7aAxT9vv5a1qM+7HM0CVy7tuIcKOIoAZkjTqcTdQ5ZC6ox7Kh5k7a0px7QosG708YtPzNzAPAsUMXjTlWljusNLTP0pTYQm7Jl3CRIOWI9mT8hxz6mdbZua9o22cUh2NI0vMpYmIAYyBDK/xCrAfWP1Uj7Iz/qG6gjxRXWmUlHWmVl4o/1k5f/NvtHpMv5QpXHl8DBTXCFUpL4EC6S9suzUlcKY9NPol8QIZxzRXxji/hoKbYT4ZfSq6lalaGVJ7Z4GOyr3ge6WvdS2arYYUIXbkV6RzEaoYHLPXIcdUtMQwsQNKmo+4KpEQ8+q8fc3Vn3uOZoxKsNGKx49lvZs+ZtSwaSoWkpDhqCgfnFeBAbUWkN12o/YmQqrjX+C1lLYvZLeQB9NszZp6M22jpkWBYBq4yMC3S1C7LfSUEU03w24oJHGF/3xhkOBD1WVEusgdK0zQdB6VmAR8izC6Mh+4UXIFbDAFb+fOjWBHd+zHlU5d3WWYAJQOWcKYz5p7rGpjB8zMOwgHKSdBhtZLIAD7gPaQ6FXAbmxkPuVMlLE71XMVrdART3SaxhrqV9dR2s4bRO2osO8mSsj457N2Dzd61iCT5sp5dBxJdtj/L8hwHDp/0rpAo+WrOytAaBR2xA1t0st+SyU8TFAVw40PkZyVMy5dI7RhjR3N165H/2deSTnxGRexImcZRO7Dp1bLS5J/dm9dJGK0xT38UXDISUreoH6L7y7lLOlttE4oXFvIJqDg7PU9p2oRHaNjFHICMBLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(66556008)(8676002)(76116006)(2906002)(54906003)(316002)(66946007)(4326008)(41300700001)(66446008)(64756008)(6636002)(66476007)(110136005)(8936002)(38100700002)(26005)(55016003)(122000001)(53546011)(9686003)(7696005)(478600001)(5660300002)(71200400001)(38070700005)(52536014)(6506007)(86362001)(33656002)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yVX9/s0wMGTwqfD7DqbKix0FyWr6KfYOlofXM9EpDj6i4yDQQIzXgZxCVtN8?=
 =?us-ascii?Q?v3BEKYEDRR+mA3kgdenoPbeVOo4mkEDkFMSuxe32lXEpgdHqEWfY93JiZEzn?=
 =?us-ascii?Q?B/IBkeWgzYH3dcJaR7eRj/lKbTMT2noxqo6c/TyrTgXJidAHvW42nfftoRs7?=
 =?us-ascii?Q?yZlHHkOSz3R2mUg13bMrN+gm7B4WR7UmEG0CnGortPZsfySxl2vnQykAHloe?=
 =?us-ascii?Q?w7IDHmBdZ/ubPBlDvx+5/VL+kX2a4jTooagcF3wMylmag/zj5KLamOVxZ8c8?=
 =?us-ascii?Q?FA2AfqE+IkOW1ebTMjijiAXUIMfLLltspV5O+dTrQe8IiHzqTmA2DSc15TkY?=
 =?us-ascii?Q?e9WB4aQJGwsjzLbUFxt2C3a2R1KzVWvoNktXFrFuYPBaH/bztZLunPqKEWFr?=
 =?us-ascii?Q?QV0lkHODzkkgSR54pc125bxQ0oD6jNJmuDTq6goQpPSao/fdhjE1hyY+zBMN?=
 =?us-ascii?Q?u63wDDcgfaNDb0wcXbH4FyKViNHehRLOm3QrwKXS6abMYATG82CzBS35mu1y?=
 =?us-ascii?Q?5DH8g4eazmq3TrDQHDOBVzAgWf7ljEFwBEXPTAav1L0Ew/V6gwp+ddozl3Jj?=
 =?us-ascii?Q?jBU4Oh8A1oxVTwsaA1BMKRcy21H0K9aRCqk7YJMIJzaX3EZN4Wq/5AGE6ay+?=
 =?us-ascii?Q?JTm6l22i5L4b7Rt91fZvhWPSieXOUbdGjszSUN2FsTJcnN4JxnWUcyeO6hAo?=
 =?us-ascii?Q?eVxYaL9XeouY3LEF5nvruBse7sTf7lGaivw8+Z24aT4R4MVzmOQ4KAcPMCHY?=
 =?us-ascii?Q?2Al+I+W1y6yImb8y0q450Lv54qK2Ufmqe884Gt6eck5f/9bEo77QvITvHZMY?=
 =?us-ascii?Q?pzSaOzbSWt2pFYPbGN0r1vE1LNUrp/s/tsZo+3ShHILDMUWV9CmMI8LSqM2k?=
 =?us-ascii?Q?+X/Ccv5Ga2O9mEuA4Bd9SCyiyWR6KqNeT6yIMECuf5dUMemr8kifYH99Fp1P?=
 =?us-ascii?Q?QFp9h+5C+JBgpKHqrvTiKAHTmonFJgHDFe7WT9ia1rcdRar484v1KQo/quUU?=
 =?us-ascii?Q?pGq5mzZixkWlOtWhPOnUFdGyHAV/tTmibUX1r8I2weEg5ISoJkQORrQ/Mk8n?=
 =?us-ascii?Q?GYs/1af65DczrexpytqmT0EV9ScNH1l/2fQI32m8Vf33GqkfZXdSk89jMckW?=
 =?us-ascii?Q?KP9DHS6qwflc2DgptNKveKLQO4ccX658GZDZvfvyOJ/T6thzBpHTo41zWjxp?=
 =?us-ascii?Q?IJLck23dWoaj4Z/Y7d6gYukXVihVXKnvAKCmQGQ80CQV3OiXv2Rwhiwxa2OE?=
 =?us-ascii?Q?0olaI0Nisr622FOu14rGQOSTPprL2vLRMexQzG8TErD5XcA2mGbz5RDcOWzn?=
 =?us-ascii?Q?GZBX9bifDRxrRNsRYyw/eNlidW9J7wGSpAu9/862lgrU9m9MmFPU4eFbgt0w?=
 =?us-ascii?Q?Y0K5hAmzGgpqs6lJsH081agcAsrz5B80+Ybmr/kWnC8ncFVhgks1eXBSttCN?=
 =?us-ascii?Q?+vE6rneJmwFT6wPtauLE/54S5KtT2alaN3nDk7IH5QGAYPtECgrSnEpvo9Qp?=
 =?us-ascii?Q?ZE/QNEdXRBvrV3mjJ35vYFzEPYmNrFM0dgcMxpctfIhG1ec2+gzuynfrXmvl?=
 =?us-ascii?Q?KC9iRgV4/shEACel2H8JMAM/LenOckjx/MSRuKE6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a1d269-37ed-48d1-29b4-08daadae51ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:35:43.1939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMMuYAQ3IPNLXA4vMs7ZzIhY8DGpmD5kaY5WA/oMQQAblYHPaoI1arSOM8F2Zs47ty9tqsmMZH78tlCHGLkyfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Hawking Zhang
> Sent: Friday, October 14, 2022 2:19 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Cc: Russell, Kent <Kent.Russell@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
>=20
> RAS error address translation algorithm is common across dGPU and A + A
> platform as along as the SOC integrates the same generation of UMC IP.
>=20
> UMC RAS is managed by x86 MCA on A + A platform, umc_ras in GPU driver
> is not initialized at all on A + A platform. In such case, any umc_ras ca=
llback
> implemented for dGPU config shouldn't be invoked from A + A specific
> callback.
>=20
> The change moves convert_error_address out of dGPU umc_ras structure
> and makes it share between A + A and dGPU config.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++----
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  3 ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  4 +++-
>  4 files changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 75f1402101f4..ff92ea99d513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -36,6 +36,7 @@
>  #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>  #include "atom.h"
>  #include "amdgpu_reset.h"
> +#include "umc_v6_7.h"
>=20
>  #ifdef CONFIG_X86_MCE_AMD
>  #include <asm/mce.h>
> @@ -2885,10 +2886,16 @@ static int amdgpu_bad_page_notifier(struct
> notifier_block *nb,
>  	/*
>  	 * Translate UMC channel address to Physical address
>  	 */
> -	if (adev->umc.ras &&
> -	    adev->umc.ras->convert_ras_error_address)
> -		adev->umc.ras->convert_ras_error_address(adev,
> -			&err_data, m->addr, ch_inst, umc_inst);
> +	switch (adev->ip_versions[UMC_HWIP][0]) {
> +	case IP_VERSION(6, 7, 0):
> +		umc_v6_7_convert_error_address(adev,
> +				&err_data, m->addr, ch_inst, umc_inst);
> +		break;
> +	default:
> +		dev_warn(adev->dev,
> +			 "UMC address to Physical address translation is not
> supported\n");
> +		return NOTIFY_DONE;
> +	}
>=20
>  	if (amdgpu_bad_page_threshold !=3D 0) {
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr, diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index e46439274f3a..3629d8f292ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -51,9 +51,6 @@ struct amdgpu_umc_ras {
>  	struct amdgpu_ras_block_object ras_block;
>  	void (*err_cnt_init)(struct amdgpu_device *adev);
>  	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
> -	void (*convert_ras_error_address)(struct amdgpu_device *adev,
> -				struct ras_err_data *err_data, uint64_t
> err_addr,
> -				uint32_t ch_inst, uint32_t umc_inst);
>  	void (*ecc_info_query_ras_error_count)(struct amdgpu_device
> *adev,
>  				      void *ras_error_status);
>  	void (*ecc_info_query_ras_error_address)(struct amdgpu_device
> *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 5d5d031c9e7d..72fd963f178b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -187,9 +187,9 @@ static void
> umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>  	}
>  }
>=20
> -static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
> -					struct ras_err_data *err_data,
> uint64_t err_addr,
> -					uint32_t ch_inst, uint32_t umc_inst)
> +void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
> +				    struct ras_err_data *err_data, uint64_t
> err_addr,
> +				    uint32_t ch_inst, uint32_t umc_inst)
>  {
>  	uint32_t channel_index;
>  	uint64_t soc_pa, retired_page, column; @@ -553,5 +553,4 @@ struct
> amdgpu_umc_ras umc_v6_7_ras =3D {
>  	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
>  	.ecc_info_query_ras_error_count =3D
> umc_v6_7_ecc_info_query_ras_error_count,
>  	.ecc_info_query_ras_error_address =3D
> umc_v6_7_ecc_info_query_ras_error_address,
> -	.convert_ras_error_address =3D umc_v6_7_convert_error_address,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> index fe41ed2f5945..105245d5b6e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> @@ -71,5 +71,7 @@ extern const uint32_t
>=20
> 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NU
> M][UMC_V6_7_CHANNEL_INSTANCE_NUM];
>  extern const uint32_t
>=20
> 	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM]
> [UMC_V6_7_CHANNEL_INSTANCE_NUM];
> -
> +void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
> +                                    struct ras_err_data *err_data, uint6=
4_t err_addr,
> +                                    uint32_t ch_inst, uint32_t
> +umc_inst);
>  #endif
> --
> 2.17.1
