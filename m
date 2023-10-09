Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0586CD612E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 19:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5336F10E1A5;
	Mon,  9 Oct 2023 19:36:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B21310E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 19:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb/rerdf7/P4MBGpA+dRPXWXCz6knwnRom1YLfUZ2axRRPvAEE8HD85b61yP1uE1pj7DYWidoMb4DKH9n37I/kF7Btlg4bTQfK+FHBjP/MRbuTXdbiCWoGfWWcG9sS71vupuXUO/NQ9+hLvq4WLVBNqMe6h1XD7XV3pIHdvjKB+dRQHlpVSRe4XF6vj7J4CKaB/czXWnvjSqpnnnKDCgicuR/52m6a248Ne3v1PFJmzZw5MGVTv0r9V7l9gqyFK447ZFIkiLXcEksyR/IRTsn4i6zTMNBuTCuRuAHinlzvVM4EyFZqKvurZHuVdi5++YrTVPgushk2FFOeOg5YpcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf1CUagM+C+0Zd79l7OHFJRz72SwRIMQez44h6SZVjY=;
 b=EUa2rqfIAjrgCuntEj4fyzJWFVHvfzOKu9grdiUN7NXqhwnd8E6OPvFb/DQXJyP6BHM9uSoZRpyD93WaeaL93pDSuQt08qVLqBrl42h3zkkMdCatVVPBU3ZDziUqPqaW3VadXsrNz21Mr+4rSOlzq5CtryZP3Lqt+Mk9beJHusHLt2J6m5VQTt2sPq5M9SrKVXKvuJSl97hH6yEbG37TFT2MBB4vwUfDBwjT9SoWgS5En/WTx5Z8yyQpO21nT5PfVLrDJ6Q7I5wtTZHqUr5qjJNQ82Ch6YYBB3DAHqqyc5rZ+S7AFV8/yXnliume03r1fiJ+QstrQCvIK7n7hvdIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf1CUagM+C+0Zd79l7OHFJRz72SwRIMQez44h6SZVjY=;
 b=v5lN6+Xbb8KPjGp03xHM0MNWGkO7sabXX+Dh63IvkFI0ELZztq71u6FhA176t3td4j1MLYXtmL3fJnqkWs2xVi4wf+rRLBFkr6jdEVVPR039iIVyjeHjL36XYlwdHxkw/sqnvoZqqBYcNAVAFwA9sqlIDtrANmlq8bkG1L6jIyI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Mon, 9 Oct
 2023 19:36:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:36:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Thread-Topic: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Thread-Index: AQHZ+PveQhpG0vW6AkCyE4KdKecuvbBB3Pew
Date: Mon, 9 Oct 2023 19:36:00 +0000
Message-ID: <BL1PR12MB5144D16BDCD4C881F3534C3DF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
In-Reply-To: <20231007085402.67350-2-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2e6cd3d1-85c5-4c93-8a32-ef701f2f3c4a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-09T19:33:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB7098:EE_
x-ms-office365-filtering-correlation-id: 4f39879f-45e0-4f82-a04a-08dbc8fef773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mx5D9cNnG7iUAfnCi8GUPkEP/RhzvuNbcMdP6f0Y90eHMqx+m4X4JjGnOHf3CRJAaXjqPDIrYQLLs1Lo0TcuhvoA68V3YrMo1hlEZ8Q6leFWDjjGlhaK61G9kBj1SbdxyQx+C5Q3tYO915WCTt4hWVoLKxySZa9plWx9QkOiikQfzpkxQjDSCLWf0kdqVVfZdUE4pFDwBAmErv+tmq62A7esK1h0asr3XZi127xVQXEjgbvnuTeP0xeecpDx19sCNpjTivv8zdBWyklCW7oi+LU9whiPMsQyFlFO5dhF40Q0VJFqt1lWFB95xo2lLTkIMo8J3tBQCEoIXtatAqBCEIQkjXFCkcMwSYZxscpejd/R8PD6KTxr4O8hh+Q5PkLI6v7zRfTzgTY0U+8F4OtZ8qvX00JqBJiMSyCOqdCWKl9SFAd5zNVSej0eK9q5C6o64kxaPoxsOqfNMSy5n+Ru7gf368yIP4Nw8tzi+L2QVYG/5hOy9vB/8VeAZPLGOidVS4yTwX6xbRgzRf/KlSkrkOnk0ofSRnW75PaAcWyHg7irN9w9TWFQvDAKNPOOKnNRRPcVmQ94bN6gFUy2jyZqMEdHbzYiGxHI7OUTLS+EeeHXBdAuT0vG+gKK0cg3STor
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(71200400001)(33656002)(41300700001)(64756008)(83380400001)(86362001)(54906003)(66476007)(66446008)(478600001)(76116006)(110136005)(2906002)(66946007)(8936002)(6506007)(4326008)(8676002)(7696005)(316002)(53546011)(26005)(66556008)(52536014)(5660300002)(122000001)(9686003)(38100700002)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+TZbCCyxeoGYvviiP1rkGWRBj4Kg6731cnbQ5MUxuwVMURiOzPUIsbjeghi?=
 =?us-ascii?Q?uC+XYyO81yZOxS8nEff9yMSt82AgVP2rmbL6hJGO4HQS7jrDgPIPdrxad4+K?=
 =?us-ascii?Q?9o3QVFLrXNLJQVXCtH9wB6lsjM5MZpjK6QQMlDo/A9tIdyWvrSixZSOXen2r?=
 =?us-ascii?Q?/tjDdV1VAPP4Lx0Q5nuraOl8TatatT3PugGu9dBhYhFSSLliaxTBDUMuR75A?=
 =?us-ascii?Q?u/d/P3ClxWi1bC4g3nDnqze0SS4120otmXsBRZntoKoK4yDVSaInh5nlkOdU?=
 =?us-ascii?Q?iuSKTEYg4ziZpYbyxce5MVesjodGmM8BoOfrfqeoBn8MxV/OwKo43WjyWBaU?=
 =?us-ascii?Q?/8buHUC6f80MNDpW+iHIcCJdHS2YagbPZfuaqlJmtgq3mHM7RRDx06DVsEpB?=
 =?us-ascii?Q?DqvaYfpP4T0wT3U4XiYnL9RxlSPMHiFVpHgLuM+ZFRhDXwH36nt5dYwU5Xza?=
 =?us-ascii?Q?oYVSO0MWtnb9c/hNv8iDcamFCPCjv4idkEiFzOTC4ZcnmuRPMJ85u7aw2SUv?=
 =?us-ascii?Q?15cPX+PFfi9MKxTx2dS2Znc6hHYJdivZ5p6rWKBYH0TQ+N52mCL1Zlod/1Kx?=
 =?us-ascii?Q?tA32bJWda8b/xqYJGvdEN5roucinqMiYPKOKprIPe/eFWTwMVGj7RN+ZFOl8?=
 =?us-ascii?Q?7gCCW2rISuI7ixJlGyR0yqu25YzV1FiwVOf86ntARY8slq1m2uhPYl9TYTVo?=
 =?us-ascii?Q?+Lln1kSINbDmyJUBMVreChPCgx35N/rao1N7BqybX1CEb/nrC1fy/JLlxmew?=
 =?us-ascii?Q?kBmH4Nt7cUTGlF9g5Bunf3m4zGLJh0VayUsdrm6JeG4WU/9aqPaE+G8fX1dh?=
 =?us-ascii?Q?9Mt95j/I8fOFKgbsJye5uO99PE0pLt+v5Q82fkKDm5uVvq+U+BTWe7vCx+87?=
 =?us-ascii?Q?rgO4HSwvTJNL+PUXsWYPForgh4Q4bUf9TezNYtueJjCao+6yms600R9JrKw7?=
 =?us-ascii?Q?9fZ1AdmQ0VSAu+4TF2gV08b9iORRVqVW2w8TpJIKYM3aNwsSg032nAqnsD81?=
 =?us-ascii?Q?1sJYG2IPvsEgZIzS6Fv28sbNjofbRzIqucQf97dp/tHh1Eor32d4qEYVvwlt?=
 =?us-ascii?Q?+qrQHNr0c+lvVJBQl++cB7V5U2OHkhkD7bnKB/MkCRNq9Di3AjM9uz28Cqp8?=
 =?us-ascii?Q?14uRpL4ZVb+OfGIImwW9aItzEMXvLXkl3wxoqg0B0A/3BXRdqJUIQQewLPAH?=
 =?us-ascii?Q?WqVJ15gBrlF+t46MDXYSfe9WERw1fy87mPkN0j4sZk6oKNarvaaQqjXwlZf3?=
 =?us-ascii?Q?rFLF79+xjU1w1UCOwgin6B3rUiSozFt+2siqSYp71NyEWSsTz8ME2rd6o4Mm?=
 =?us-ascii?Q?3rhX0vjvVTmvRhNbN0Y6XcWF9Dp7VmPcNvYKNO1iMwpP8UpMlEq3YR2O6adY?=
 =?us-ascii?Q?nAK99MhXmI6LS+aFPZToMcGGSArYiQqdZH5PYG5+rjqZ7EEjRD6vYnEH7N9l?=
 =?us-ascii?Q?cIIdldzqP9zf/JOrtiuyv8xB+tPY447l+aTEVaAwoZcgRPXtaqUEEvPvxJcR?=
 =?us-ascii?Q?xWeJW0dG+wHciHWjCFe5e/BJLiSsk5OhHy9zD6eV2h79cmgNRB1DqG/ApBW4?=
 =?us-ascii?Q?skcsdzLrOp8OS2ZvtPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f39879f-45e0-4f82-a04a-08dbc8fef773
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 19:36:00.1649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jos3iT+k8alu0x8w8zUPS5IlK9usarXjNKEA/YnbUuw6yP5CTiajHn+7dyc5XKs/FoDrdwRX2Rn0FnZ0FkCnCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Gopalakrishnan, Veerabadhran
 \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Saturday, October 7, 2023 4:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
>
> VCN 4.0.5 uses DLDO.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26
> ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> index a60178156c77..7e79954c833b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> @@ -34,6 +34,16 @@
>  #include "umsch_mm_4_0_api_def.h"
>  #include "umsch_mm_v4_0.h"
>
> +#define regUVD_IPX_DLDO_CONFIG                             0x0064
> +#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
> +#define regUVD_IPX_DLDO_STATUS                             0x0065
> +#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
> +
> +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT
> 0x00000002
> +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK
> 0x0000000cUL
> +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT
> 0x00000001
> +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK
> 0x00000002UL
> +
>  static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> *umsch)  {
>       struct amdgpu_device *adev =3D umsch->ring.adev; @@ -50,6 +60,14
> @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> *umsch)
>
>       umsch->cmd_buf_curr_ptr =3D umsch->cmd_buf_ptr;
>
> +     if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) {

This switched to a function call.  Amdgpu_ip_version().

> +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> +                     1 <<
> UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> +                     0 <<
> UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> +
>       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> +     }
> +
>       data =3D RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
>       data =3D REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL,
> MES_CORE_SOFT_RESET, 0);
>       WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data); @@ -
> 229,6 +247,14 @@ static int umsch_mm_v4_0_ring_stop(struct
> amdgpu_umsch_mm *umsch)
>       data =3D REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
>       WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
>
> +     if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) {

Same here.

Alex

> +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> +                     2 <<
> UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> +                     1 <<
> UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> +
>       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> +     }
> +
>       return 0;
>  }
>
> --
> 2.25.1

