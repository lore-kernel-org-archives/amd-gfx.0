Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671F9C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 09:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68D310E41B;
	Thu, 21 Mar 2024 09:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZR5ayKhq";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91F710E49F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 09:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzygzPxz+mHQETmKdLGWhkaZwk6qBmaFj8xfQCtNrNWrhU3yjvdi5SewJ+/rQbxH4iRFSQ7hyobkPoxDL1HWSLxA65PRB/hVjJs778pIzoU3fGfq8Ly4km6T+c6JbHRTZk4RCJz8OLmNRl93evupik4ZSM9JIF2havjBu3pLNKjVZ4ODEGFh5TUrO1yQCiQAIh7hZG8z8PcInwzOucOLns7/Yq5Mzr8C05pV0/14G+3MGxmCwYaG7hJBsJYebBaEkoR+Uc+02r4PaO8/xYJcCCYXWXV5kPUXdXGdfx5JbiVMSn9qzRoH0W7XZNlXYOxxztskUW9K3ye6yq/IhpmyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gml7dezM/D615KxBQLaLClbHx4aBCVmsyXcVUybUvHI=;
 b=WHQQ/rdj9owwPWUx5AJSibyoEHTEL/WvjoRdz4m1/3Q1FYXckyDs5GfbRQYFUZRH8N7BckkfgBhafxHnIVHKlmS1oaNYFL6AB+QOkjUMFll3FD3uh+49KzhEg/CC2CW7ZMKocZw5MKR3Rok6Tuw69Gk4ivD5ebwJmsznTp+AHtyvT+uoJywM77JbjH7ju1IVGvrvJB5XGkL+Xn6RzZ7nCB+lo/d0H67X7e3tE+2wRBTjgh/hQiHzEN+PAE6UrPXYks/3UUK/vqTIOvRLaVUia6ScPgsv33VXM+hShtq1+JyHYKhYwMLSg0lgH92iSr6Carj/0lSiLzCtmAN0iW0daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gml7dezM/D615KxBQLaLClbHx4aBCVmsyXcVUybUvHI=;
 b=ZR5ayKhq9+cnYdQvNrEocruZntWhIrcruHfB6DAkFZafnU3hWPe7f+1grxSyWboblHE7FsU4o0iH+eRZwrNoyW/Jw5SA6HINQ2lxyTyEBItKLZAzu83AjAOE966AaR9XUgOf6+6UZWt/PMdXS5IaDuB9DyowdWcElhYQ0mFdN5I=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 09:33:02 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4%4]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 09:33:01 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: simplify convert_error_address interface
 for UMC v12
Thread-Topic: [PATCH 2/2] drm/amdgpu: simplify convert_error_address interface
 for UMC v12
Thread-Index: AQHae0Am8EnzfXUu7UCwyr0o6MrZILFB7sOw
Date: Thu, 21 Mar 2024 09:33:01 +0000
Message-ID: <PH7PR12MB79884335DDA6F0852852219D9A322@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240321033007.358505-1-tao.zhou1@amd.com>
 <20240321033007.358505-2-tao.zhou1@amd.com>
In-Reply-To: <20240321033007.358505-2-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b82ab58c-ea66-4761-b0ee-7265e19a8978;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-21T09:32:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DM6PR12MB4251:EE_
x-ms-office365-filtering-correlation-id: bbec1288-1a03-4c45-5097-08dc4989e718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1B+HeOuxcK5aqkPRDTPkkIA8ABsqW3eVfA3pTnEgzTLJeHQ7vrB4QmmQ9rAL2Nan5GXRc6czE4O+l3kr1LDzdJqwVLbh6HZGVaFkpb4Vp8CneY/EbvPcJ2LKhKPasN0uwOV1GrZ+tqFPRkVAM0mZCChQgzwC+r9LQTx169ygJpiEu4hnv5MxmZbprUxxlnroZ6JBcv3/us3le4mUwZbAPFAsJ2zWIlcBPNpi6HvKa5R3bhLimFADLs4T2sWhCdRNDvLXEd21Lyw49vp2ZOaAP5vhwlrqo2E1mfhhHFUqLsrC8SiXGnQ219t93FVaQ5KqI+Ql4XzY/tmQ2sOw0Fv+B6rPDZBUON97w0El8qf4NjbqyS/XxBogpfCAf+nJcL2e5/8g4bOrg5OTN4IhzcTsJrAj3bOBEuoq1FQMwff5YoSzoCnaoLdXELfj2MKEX4HR/Z3VrmjCSbv7UjlNvGEwFDANZRw9btWLq1eSHNamQYUBls6yBifyXrR/KeCq3PAGxoZNQsORpGpBO6CK8Wq2GPxXDMJMxSEoJU5ahKNoMk7ts5Ln/M2Nw42CJ33nOYMeHiMbYjx83q073t2y6yrYXdP8zXJMZtfPIm/9v72qurMKagqxRA5L5Dq1IcT4inhW/mo4vYlqLArW6vpZm2UZLeyPj9lBlQX1RD2ipr7t7uz0vPZAPpxKxKvnsGfmeuJ5dvPOy+NTstlYkAc8tGvXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8IZK60Lox198eYHVgadU1W2VgX3pJxjxg87JoOQOOzc1ZTlNYpHBw6Cf63x?=
 =?us-ascii?Q?j0EKZvMhrqE0j2vnKr5S5qg6KpCkrYDVJnUtyQz3/cmKkJBPkPE1Tq7aACC2?=
 =?us-ascii?Q?8out3cJ5IRpk5s8VSpPTwL/8VPxiBmo9u7xpbjbf8SnAq814Sdya0PEnmwFV?=
 =?us-ascii?Q?LT0G2TJ10/AbQSu9Jv2cXe/5GtWxmXbwM5dnZZj9YFWu13waj0IpJ8eBEneQ?=
 =?us-ascii?Q?5ONAm0sja59Xvz/Ows80nc+uLP+nLJWTZpCx7qdTlcicKVdsgBBTHdzbZgzp?=
 =?us-ascii?Q?15la2C0cdxbsgcPMnD5DrulrbUE6ZBR7hp+eZ/Nxi4Y1bmJCJ+V1/moqh1vD?=
 =?us-ascii?Q?L7w9WTtLLO9WuGJm1MKgJ7cAERfoKiFXVtRI4vDsSNMThA6kwVBgGgt/039Q?=
 =?us-ascii?Q?OVEPw7FyIH+mzS5u1Z0b8wHGjkTCHR6pkbxuJA+S6byMcoe9ZULlYv4G7mj9?=
 =?us-ascii?Q?cGE52hubbtpi1OeIe4ghu48GDlVzslo/n1zhTLqdCL7/Y6jrIMtNQnYtc3Bt?=
 =?us-ascii?Q?TXDy5lnfiK1syg424uqhNP1tR67xgCdC8n6DLq1bow7eXI94XM/UvdRDYpPO?=
 =?us-ascii?Q?H6fYBi9uwtGdTkIc7ghV0B8KYTDEfEanDmXfDVZyjfPUCYk9ctqiOL+RqWAQ?=
 =?us-ascii?Q?M0rKZnkGKbK+3gOh4R2IgUw1hN9R2d5iTCcm08x9O3XkMPVPxbVVWuzT65Ps?=
 =?us-ascii?Q?Sec7eBQel+uognVkDbAM9cHpvDSAAjAGTwyh5t2XkY0l5rJn4OgryRAJKJsf?=
 =?us-ascii?Q?rND8qBT+PoV7Eyb651agfCenMtDsgkVd325wPASkfXOqAAqBw776IjQNNTD5?=
 =?us-ascii?Q?bMSJobN8x1acYE+lu/fLW37DUCDUppmPaiibuF2VQ7hkGEhcgtP8Eqv8nou6?=
 =?us-ascii?Q?kzV+UexC2vuWkurYSs2QMnLsqpVYqs4rSqJKvvwf5hhv0b2hi9nCZ/fyuln4?=
 =?us-ascii?Q?Un+fT8qR9cO+CBBRgOkLexQ5/VOqJWdNPRD1mE8mfOqw1O+tIqIfEQci5JO5?=
 =?us-ascii?Q?rnDyOBiRyzom+j0CL7Hu4IMOQc2BIWwoosGmy2RvfMj8KBLGlNOmcbpcDfZx?=
 =?us-ascii?Q?p+ZrUR/3/fwhfaPKGteUu9pxnNNxh2TMYV8VFtWHiZIevCRT6/C27o0apBxh?=
 =?us-ascii?Q?8pXwWlVklofPHEL3XKOIdGCO8/0EB6GBcTEJRj16DYGcZ9AF6OUVL8x6ljgd?=
 =?us-ascii?Q?HgsEIUxpT7Y+nUeWfUKUBLzATraW/ZkLIU26/JAo7iwb01ZDBI+6tzD1Axuh?=
 =?us-ascii?Q?D9caRD7nTRKIuYiRe22WzfGftXpkEfNrMmcrYTgxSqXDWgSZa/EamtaHGBrb?=
 =?us-ascii?Q?4t+Hun8UcJeJ735wine59vITvUHOcRVVedLWqkitWaigytTe571DBrK3Cz7m?=
 =?us-ascii?Q?J+xS9wWSvipiyfv/Fp2LkjTngPwGnm2SQBp3YCA/CQuA45lGSoyENRNvfwir?=
 =?us-ascii?Q?aQb6XKqRL74cYvnSoGlUEtFEFitRQqR9ohhMw2MvSQPGIpy3WxNBu7C4M3Xb?=
 =?us-ascii?Q?RrAkygzSuhOi7gxi+8w8qYF0ELgNzaufKOBqotzRyxH1NGDtc0wccPhwX+ah?=
 =?us-ascii?Q?NNrROBJGssHdMG3ML7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbec1288-1a03-4c45-5097-08dc4989e718
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 09:33:01.5917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1Mq5Dj0l1D+ZsCgxq9pLpnCPIHFj9Am8uIAcxlFNQE7gUKVEUJqIG0TBA7vAjv3ZxlmKpbeT/9bjyQ6qhhbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

The series is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Thursday, March 21, 2024 11:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: simplify convert_error_address interface
> for UMC v12
>
> Replace separate parameters with struct ta_ras_query_address_input.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57 ++++++++++++++---------
> ---
>  1 file changed, 30 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0a9cc87e98d0..d0fcfcb3404f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -266,26 +266,19 @@ static void umc_v12_0_mca_addr_to_pa(struct
> amdgpu_device *adev,  }
>
>  static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
> -                                         struct ras_err_data *err_data,
> uint64_t err_addr,
> -                                         uint32_t ch_inst, uint32_t
> umc_inst,
> -                                         uint32_t node_inst, uint32_t
> socket_id)
> +                                     struct ras_err_data *err_data,
> +                                     struct ta_ras_query_address_input
> *addr_in)
>  {
>       uint32_t col, row, row_xor, bank, channel_index;
> -     uint64_t soc_pa, retired_page, column;
> -     struct ta_ras_query_address_input addr_in;
> +     uint64_t soc_pa, retired_page, column, err_addr;
>       struct ta_ras_query_address_output addr_out;
>
> -     addr_in.addr_type =3D TA_RAS_MCA_TO_PA;
> -     addr_in.ma.err_addr =3D err_addr;
> -     addr_in.ma.ch_inst =3D ch_inst;
> -     addr_in.ma.umc_inst =3D umc_inst;
> -     addr_in.ma.node_inst =3D node_inst;
> -     addr_in.ma.socket_id =3D socket_id;
> -
> -     if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out))
> +     err_addr =3D addr_in->ma.err_addr;
> +     addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
> +     if (psp_ras_query_address(&adev->psp, addr_in, &addr_out))
>               /* fallback to old path if fail to get pa from psp */
> -             umc_v12_0_mca_addr_to_pa(adev, err_addr, ch_inst,
> umc_inst,
> -                             node_inst, &addr_out);
> +             umc_v12_0_mca_addr_to_pa(adev, err_addr, addr_in-
> >ma.ch_inst,
> +                             addr_in->ma.umc_inst, addr_in-
> >ma.node_inst, &addr_out);
>
>       soc_pa =3D addr_out.pa.pa;
>       bank =3D addr_out.pa.bank;
> @@ -310,7 +303,7 @@ static void umc_v12_0_convert_error_address(struct
> amdgpu_device *adev,
>                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
>                       retired_page, row, col, bank, channel_index);
>               amdgpu_umc_fill_error_record(err_data, err_addr,
> -                     retired_page, channel_index, umc_inst);
> +                     retired_page, channel_index, addr_in->ma.umc_inst);
>
>               /* shift R13 bit */
>               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT); @@ -
> 318,7 +311,7 @@ static void umc_v12_0_convert_error_address(struct
> amdgpu_device *adev,
>                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x
> Bank:0x%x Channel:0x%x\n",
>                       retired_page, row_xor, col, bank, channel_index);
>               amdgpu_umc_fill_error_record(err_data, err_addr,
> -                     retired_page, channel_index, umc_inst);
> +                     retired_page, channel_index, addr_in->ma.umc_inst);
>       }
>  }
>
> @@ -326,13 +319,13 @@ static int umc_v12_0_query_error_address(struct
> amdgpu_device *adev,
>                                       uint32_t node_inst, uint32_t
> umc_inst,
>                                       uint32_t ch_inst, void *data)
>  {
> +     struct ras_err_data *err_data =3D (struct ras_err_data *)data;
> +     struct ta_ras_query_address_input addr_in;
>       uint64_t mc_umc_status_addr;
>       uint64_t mc_umc_status, err_addr;
>       uint64_t mc_umc_addrt0;
> -     struct ras_err_data *err_data =3D (struct ras_err_data *)data;
>       uint64_t umc_reg_offset =3D
>               get_umc_v12_0_reg_offset(adev, node_inst, umc_inst,
> ch_inst);
> -     uint32_t socket_id =3D 0;
>
>       mc_umc_status_addr =3D
>               SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0); @@ -362,10 +355,16 @@ static
> int umc_v12_0_query_error_address(struct amdgpu_device *adev,
>               if (!adev->aid_mask &&
>                   adev->smuio.funcs &&
>                   adev->smuio.funcs->get_socket_id)
> -                     socket_id =3D adev->smuio.funcs->get_socket_id(adev=
);
> +                     addr_in.ma.socket_id =3D adev->smuio.funcs-
> >get_socket_id(adev);
> +             else
> +                     addr_in.ma.socket_id =3D 0;
> +
> +             addr_in.ma.err_addr =3D err_addr;
> +             addr_in.ma.ch_inst =3D ch_inst;
> +             addr_in.ma.umc_inst =3D umc_inst;
> +             addr_in.ma.node_inst =3D node_inst;
>
> -             umc_v12_0_convert_error_address(adev, err_data, err_addr,
> -                                     ch_inst, umc_inst, node_inst,
> socket_id);
> +             umc_v12_0_convert_error_address(adev, err_data,
> &addr_in);
>       }
>
>       /* clear umc status */
> @@ -425,12 +424,16 @@ static void
> umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
>       struct ras_err_info *err_info;
>       struct ras_err_addr *mca_err_addr, *tmp;
>       struct ras_err_data *err_data =3D (struct ras_err_data
> *)ras_error_status;
> +     struct ta_ras_query_address_input addr_in;
>
>       for_each_ras_error(err_node, err_data) {
>               err_info =3D &err_node->err_info;
>               if (list_empty(&err_info->err_addr_list))
>                       continue;
>
> +             addr_in.ma.node_inst =3D err_info->mcm_info.die_id;
> +             addr_in.ma.socket_id =3D err_info->mcm_info.socket_id;
> +
>               list_for_each_entry_safe(mca_err_addr, tmp, &err_info-
> >err_addr_list, node) {
>                       mc_umc_status =3D mca_err_addr->err_status;
>                       if (mc_umc_status &&
> @@ -446,6 +449,10 @@ static void
> umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
>
>       MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
>                               InstanceIdLo =3D REG_GET_FIELD(mca_ipid,
> MCMP1_IPIDT0, InstanceIdLo);
>
> +                             addr_in.ma.err_addr =3D err_addr;
> +                             addr_in.ma.ch_inst =3D
> MCA_IPID_LO_2_UMC_CH(InstanceIdLo);
> +                             addr_in.ma.umc_inst =3D
> MCA_IPID_LO_2_UMC_INST(InstanceIdLo);
> +
>                               dev_info(adev->dev, "UMC:IPID:0x%llx,
> aid:%d, inst:%d, ch:%d, err_addr:0x%llx\n",
>                                       mca_ipid,
>                                       err_info->mcm_info.die_id,
> @@ -454,11 +461,7 @@ static void
> umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
>                                       err_addr);
>
>                               umc_v12_0_convert_error_address(adev,
> -                                     err_data, err_addr,
> -
>       MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
> -
>       MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
> -                                     err_info->mcm_info.die_id,
> -                                     err_info->mcm_info.socket_id);
> +                                     err_data, &addr_in);
>                       }
>
>                       /* Delete error address node from list and free
> memory */
> --
> 2.34.1

