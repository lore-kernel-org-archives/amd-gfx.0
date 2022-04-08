Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB57C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 09:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D56510E0E7;
	Fri,  8 Apr 2022 09:20:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2982A10E0E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 09:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxZGaa5q+i7DoDfGGj4cRW0beJkZcUUNmPlDOrfFc5CY/uyNgvFzg9eEK+mD9Jin53wQtGGL65MqwWfxTBaA8Jh1ogkVlN3AjdZ84NpWhvIpDDcUkSnCfEQtY87hgeCg97tDVtsnor6QFS7GY4aOzOaDvxhE89ouyXt571x26Idf+TOKzGBzUEdHClvf4NyzzmAuVKykc7Vf7bd5bYOnBl4L40YPtzkfXZD6lq8JPc/XRY9sjplkKrrxsI3KQ+3Z3SjLYEvOUzuk7K7M+xSZJAI337R7xPqqMnrzCdcLDID9TI6P26AMFyrY104n+66ufJBuE9qDBB9I+CLOqTaEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRee83XQUGY6zFxoLdDu4QDwuRD7bJItqDgwAqXkmUA=;
 b=lW4so3EyQWi71JQEe6umTN8lqmKJVMfp/xS1CMGPOg1uOiw1m/Hp9CCJXQDtvTaIJSAoKBnOAYN/AYXUtrSiRurKBBpLdvz/I6D+m2cs4Mn/4gDW37aVdLpLyXhH+LIOMzW9X9FTtqqJvNYSSAyGVV0ZPo22J8XXOCi2Gg9T/yiR3Z//4sYFzppTKu3XkuZh80+9nXJSnszkJdLtvGTlYV6i11szAOQ6+206JOxbPIUoPdAL1n+sZSKLt8+VuwwiIJZC3dFkhXVpUrPp4FrLS+2VpL2zGsWbxwryQWJb8s+OucSYbojYlADa4HXclCQjsbPe5/HqcZqis/13gWeVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRee83XQUGY6zFxoLdDu4QDwuRD7bJItqDgwAqXkmUA=;
 b=rg6BFb4Qioa04OOEfcUwZ4VwAPoIOHg/EpzRNtV+n4lpMk4BdWBYisLI9VpI5qYeED5Bw0hyoMCtXxTHT8LhtsJ+wCNU3TaiAI/B2ZOuLJqoWTsK2/xLTc4V6QO8QNOCcfWP4z7KUZHodiz+cDAbmMy14ltBMGPEtZCA9/tnya0=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 09:20:01 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c74:17fc:59b9:6f57]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c74:17fc:59b9:6f57%9]) with mapi id 15.20.5144.025; Fri, 8 Apr 2022
 09:19:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: add umc query error status function
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: add umc query error status
 function
Thread-Index: AQHYSyAXaJCExYmLeUqL6o1o4aVdEazlu2Og
Date: Fri, 8 Apr 2022 09:19:58 +0000
Message-ID: <DM5PR12MB1770BED5C1093C89BB73715FB0E99@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220408081009.31319-1-Stanley.Yang@amd.com>
In-Reply-To: <20220408081009.31319-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T09:12:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=03af077b-acd8-4704-b81d-1a7b7da8c71d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-08T09:19:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: cda670f4-a7bb-49a9-8943-960dc2f8b4b3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76af19fe-712d-4db0-4743-08da1940f41d
x-ms-traffictypediagnostic: SA0PR12MB4526:EE_
x-microsoft-antispam-prvs: <SA0PR12MB45267E0280D67D5C9C99B848B0E99@SA0PR12MB4526.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P97TRi4J47Kun2rb4ZfEdkyzUAPMighCVcwRaPusw26XX56rX38tnYVpgI2YNGrAWgxSovQAum94dXRJ6h3RZwtUKrHs/8t8BLV7Rq5JgOXTUNFDYPlJTaVL5haxDJPn3kF/YSm8BZEw8OiQcPzKR8TYHEURZnpJ84yRaT5uzH+dQSWCad8WcAK8XyI6psnWBv0Mife9e2YKqgq/BAPURFJ+mTcX0N1nTTUszqgDdFOYMytQ6EcH6rPZA0oKJrJ4jh/d8x6w1ErW0xdhppLFXECYvEpZz9hr2tQnrhVHibUxandMKel7L/sy3NRSiAAsdLOJIMQ8/2J22CfNN2TCPtutWrBS6N6rz4PImTOXMFRHFwEuCKrFBIAoRHVJ9L0gOQVbiut0Wl5HBAvKvZrK66WLX9U6Q4+rKC4z7V2DD34Ccsl8n51GjiVacauaWLDhp3HFvF9zV85C8VNxiEhJjpx46N3MlxWJ8GaB50ezmnIx3k9mokhOFQITYAKacqYmgrcWMqkORzhObgErXCiDoIpuinbmXzbmwcF++DVwfwAYc3IghBoemT49i+t7cfDxWKVYZrxXM+bodWqof9Plo17rbHvtuui1hmyzqIoXFT6kXILpN5GCcjja0i/HvTsNETt/8ymCHY2ave6kPadfkjNeU6LgmYwZ6oHWjztiiTdojox8mxy6+zW485o+nUGL8CLAPWQCkr+ldojUgSfMyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(8936002)(5660300002)(83380400001)(26005)(508600001)(186003)(38100700002)(86362001)(64756008)(122000001)(6636002)(55016003)(110136005)(2906002)(33656002)(53546011)(316002)(9686003)(38070700005)(76116006)(66946007)(71200400001)(66556008)(66446008)(66476007)(4326008)(8676002)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tX7eGO3zec/Dv9LYGDNG6p3Taye5+AnWJyphCjnbIbcYZ124DkwAochZsXD8?=
 =?us-ascii?Q?yq46i3S6Va97gIMVFGIaLc0ecL/Hoq/WiuGGx5DUI5ZGU7vQN29NodBABnhl?=
 =?us-ascii?Q?qH9xq9HnAyFkjlKjMviBJyn9Pp6Sf5B+2I8K+OKffCV9N4rF0DeAG4kOsWdL?=
 =?us-ascii?Q?1QndE04KCeshYn4uBZiryTom2liJ9Mu7X4jQNfoYNS91MUo0q6mgW1AgcfZl?=
 =?us-ascii?Q?BBxfkuHynG2MhTZH6d1w6v10e7KCq7toPnHIVE1PDNj7KfkC80JVA+UL2f5A?=
 =?us-ascii?Q?luh+LtnHGZ33w5uUAR4zcDOHRw6ru45rxMqxsDZe2WApqrs5RnGXjzjNjIkf?=
 =?us-ascii?Q?uo2xIToioiezWBhEEwQ4Bprjcv/X7z+DfkXzLHCZWDFIwSZtG2OEMYA2p1Sb?=
 =?us-ascii?Q?NfXggv4LBCpCFtWARBg4UbDzVq1f3wwyVswHuEIoahepFfu1ZHMYmFjcrv/B?=
 =?us-ascii?Q?jlBwNWwvRO8uEI32qmtDAC8j1M0kYsk3f0jj/doVhl8GyAjCrTbTnT8KNn0z?=
 =?us-ascii?Q?epp+qNs8zCjt5Mqey8hyueW1QWRDm2T8g13LQUx/4VHzFzUP1YK9KnDAS5Xe?=
 =?us-ascii?Q?chF7C9c7vxA/aGgDAfwKjDo71l56XJaIgQPX+Xb5KbpGFChy5G/JE6M9Nmv9?=
 =?us-ascii?Q?KX/GpvaDzrz+JrxM8vyqKKHhwpgmA0HbTVBFxoyhg6/D6GSymTmm2CczLNyg?=
 =?us-ascii?Q?dSniBufBvKowOXdpXY7Tfv2MMALsjulxIGWD/YJK9lhbdB+oaSeo6JGZNOUz?=
 =?us-ascii?Q?PNTVUQrCM5GgMDqqNhOfFzCgZsNg0FUVRgZfFbv8UHaJ0hHeidda6xeltSPC?=
 =?us-ascii?Q?O7Fk/zUlcqTI9SVwN9V8cvl2vbYyr4nUWjTLHMMd7Aj/knFbrSnpnsTovtLa?=
 =?us-ascii?Q?0HVl+3OfmCQt2sQcS6w2J4tfrbp9oQI8bmFP2fCGvvuX3e7hUNzRI7v65urR?=
 =?us-ascii?Q?fQCiC40T44Bclp8w6hDaeYv87mdSRgSOXGteQF6h2jrJnKN0FZsp4+qiZiuL?=
 =?us-ascii?Q?KqbLlYepcYpRAg5RUzjCxH0VvrDBs0HgnQ8b3WFZlxtc0CJtkMlNZkeXtou6?=
 =?us-ascii?Q?IMf1t/eL5CJ9XQpxK58op+KqUKW/nrpXMtwPXuhyu8xbY88ZnTEjmVoyV7gi?=
 =?us-ascii?Q?0HJX4xmsjxb1e3ZmT1FfsRWX6rz3/t38vT5u5WWSpO15Cgna13Y+Wt2Tf1bj?=
 =?us-ascii?Q?JVEEFwdT5UMk0OC7+R68/u11tHn75xIOysoCyx84t/qBzW8G20/60h4pb3s5?=
 =?us-ascii?Q?pisjZBzMtYmTToYotXuaQ0GwabxvBtOixJBF++KcR9CjdFxscDf4S3v5WvZs?=
 =?us-ascii?Q?Ech2EayD88Pw6+YImlGOohUhnN9WvnOJygY/zmmuPbBantKQMOsiRWHVfPEg?=
 =?us-ascii?Q?QUhm6fmglJzb752vkS/kiiBLjI5EdRQo8eLYmEVIo2n9Bnn6dxPbcBB1lpO+?=
 =?us-ascii?Q?lYqrJXZs/sAkrMlTtROtQ275HfAAKbhno+VPCoxu1pzDb7kGAVjjRN/lNV7D?=
 =?us-ascii?Q?uKMOOuEnFm52GSoXR4HyQVGoDMvb0e4bGvhRNIfrSAbn0udZr5DMOkFsMCN0?=
 =?us-ascii?Q?8/qmcHsvU/2s/m60tYKNwqffGYDnzN+BWFvsvJiTaeqwrPlQnMz3eKaih5pk?=
 =?us-ascii?Q?tQaZYnUtoVLQ8Iq6XY4R4GgnyTxjHCDhB2U3Ttg0L16yosfdS3KKZXI9r2r8?=
 =?us-ascii?Q?Tk48FnRFdhuC6ZojT5jG7SHV1rpbQpye8+WytDFQz/bMtyGQb6CWrjIBdUec?=
 =?us-ascii?Q?t4rAUfi2RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76af19fe-712d-4db0-4743-08da1940f41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 09:19:58.8944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STlCHVSp/7vcdeayODT5t6Wq3qjP0+9fol/O7felHCC2yLhZTr6Fl+jiGB8cMVio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, April 8, 2022 4:10 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: add umc query error status functi=
on
>=20
> In order to debug ras error, driver will print IPID/SYND/MISC0 register v=
alue if
> detect correctable or uncorrectable error.
> Provide umc_query_error_status_helper function to reduce code redundancy.
>=20
> Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 106 ++++++++++++--------------
>  1 file changed, 48 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index c45d9c14ecbc..9d3b54778417 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -64,21 +64,62 @@ static inline uint32_t
> get_umc_v6_7_channel_index(struct amdgpu_device *adev,
>  	return adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];  }
>=20
> +static void umc_query_error_status_helper(struct amdgpu_device *adev,
> +						  uint64_t mc_umc_status,
> uint32_t umc_reg_offset) {
> +	uint32_t mc_umc_addr;
> +	uint64_t reg_value;
> +
> +	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1)
> +		dev_info(adev->dev, "Deferred error, no user action is
> needed.\n");
> +
> +	if (mc_umc_status)
> +		dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset
> 0x%x\n",
> +mc_umc_status, umc_reg_offset);
> +
> +	/* print IPID registers value */
> +	mc_umc_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> +	reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> +	if (reg_value)
> +		dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +	/* print SYND registers value */
> +	mc_umc_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> +	reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> +	if (reg_value)
> +		dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +	/* print MISC0 registers value */
> +	mc_umc_addr =3D
> +		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> +	reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> +	if (reg_value)
> +		dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset); }
> +
>  static void umc_v6_7_ecc_info_query_correctable_error_count(struct
> amdgpu_device *adev,
>  						   uint32_t umc_inst, uint32_t
> ch_inst,
>  						   unsigned long *error_count)
>  {
>  	uint64_t mc_umc_status;
>  	uint32_t eccinfo_table_idx;
> +	uint32_t umc_reg_offset;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
> +						umc_inst, ch_inst);
> +
>  	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	/* check for SRAM correctable error
>  	  MCUMC_STATUS is a 64 bit register */
>  	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D
> +1) {
>  		*error_count +=3D 1;
> +
> +		umc_query_error_status_helper(adev, mc_umc_status,
> umc_reg_offset);
> +	}
>  }
>=20
>  static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct
> amdgpu_device *adev, @@ -88,8 +129,6 @@ static void
> umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_dev
>  	uint64_t mc_umc_status;
>  	uint32_t eccinfo_table_idx;
>  	uint32_t umc_reg_offset;
> -	uint32_t mc_umc_addr;
> -	uint64_t reg_value;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
>  	umc_reg_offset =3D get_umc_v6_7_reg_offset(adev, @@ -106,32 +145,7
> @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct
> amdgpu_dev
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D 1)) {
>  		*error_count +=3D 1;
>=20
> -		if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1)
> -			dev_info(adev->dev, "Deferred error, no user action is
> needed.\n");
> -
> -		if (mc_umc_status)
> -			dev_info(adev->dev, "MCA STATUS 0x%llx,
> umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
> -
> -		/* print IPID registers value */
> -		mc_umc_addr =3D
> -			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> -		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print SYND registers value */
> -		mc_umc_addr =3D
> -			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> -		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA SYND 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print MISC0 registers value */
> -		mc_umc_addr =3D
> -			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> -		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA MISC0 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +		umc_query_error_status_helper(adev, mc_umc_status,
> umc_reg_offset);
>  	}
>  }
>=20
> @@ -277,8 +291,11 @@ static void
> umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>  	  MCUMC_STATUS is a 64 bit register */
>  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D
> +1) {
>  		*error_count +=3D 1;
> +
> +		umc_query_error_status_helper(adev, mc_umc_status,
> umc_reg_offset);
> +	}
>  }
>=20
>  static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_devi=
ce
> *adev, @@ -287,8 +304,6 @@ static void
> umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev  {
>  	uint64_t mc_umc_status;
>  	uint32_t mc_umc_status_addr;
> -	uint32_t mc_umc_addr;
> -	uint64_t reg_value;
>=20
>  	mc_umc_status_addr =3D
>  		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0); @@ -303,32 +318,7 @@ static
> void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D 1)) {
>  		*error_count +=3D 1;
>=20
> -		if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1)
> -			dev_info(adev->dev, "Deferred error, no user action is
> needed.\n");
> -
> -		if (mc_umc_status)
> -			dev_info(adev->dev, "MCA STATUS 0x%llx,
> umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
> -
> -		/* print IPID registers value */
> -		mc_umc_addr =3D
> -			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> -		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print SYND registers value */
> -		mc_umc_addr =3D
> -			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> -		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA SYND 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print MISC0 registers value */
> -		mc_umc_addr =3D
> -			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> -		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA MISC0 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +		umc_query_error_status_helper(adev, mc_umc_status,
> umc_reg_offset);
>  	}
>  }
>=20
> --
> 2.17.1
