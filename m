Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBFBEB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 20:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2EE10E17A;
	Tue, 25 Jul 2023 20:03:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF3110E17A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 20:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsRaAkP2FqTeAcjOS7s6YyDyc2IRPdxoOrYEuHgsL85XqQIQx3dfxAHJfbRTDDrVmlp08FWEpK2kTv8NXBGr+ij/vg+A5AtH4HhI8EZDvulDaMVIJdIKQizuligMjsPbiPjWAPU4Q/NK8Dc1NH6HKj2SxAs7jY5/7qYfh8VFgqyntjPZ+1h5wfOwqf9m5Cne1qBqF3eyexDO6kP86q8UIztd1MJEocTGXb+J//iJRoYQua/aN7/WGdREoETOUKwc1+FCXp9zvHfEFLE+cbdSnejKgyG3VE9glN8Q1T9DxQ7E1iyZAUOP5fAAuqJvv2NLW88zoLCG9Awr9dUUEr0zXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN53tThPwnMcJ4cm3COOaOPnDlKOIEcY1CCQnKpfhR8=;
 b=EBzVuXVi38SNYWWt5Rai6eVWxQ2lUlxwDvHGKbnrAKNEI+c/wjofXsxHM8+2KmLPQKgpCV2DfyKkNF9YbIn7F0K8QyLosEPnUq5mlvwomDKFgX8RuQM1dVyPSxBNB6fmPyU2X0zQBUiRDp3TGEFUIj+lQkhBg6VepVT9fDxOMhZ9lEbQf4LvfnvCUEDu4X4poq1CqPWli59rtMlDvh7W/Tevms/gdP0+FC8Rt6IOoV4GWfu6CqztgU20KILO6Og5r/hLAG4o8YokUo7x9N4qXXNlRhq3q2jD4S7I1FO9cftT41bAmxs/Dr7dJUFMUdPv0/sCHj0TUJcCAx12TmyvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN53tThPwnMcJ4cm3COOaOPnDlKOIEcY1CCQnKpfhR8=;
 b=thbBj1KInyxgPLIrBNI4oXl+Dd2V422fhoF9zIPytQ0y+SQO5WLfpgYB+t8NJShqiBLfVi19xbNuixAkms8wLH54kxGFUo2O/iIVpsNcFGU0tRS+izHfQkv/RZzNYdIH5WUx2g2uWRqK8JOyUeAxLK6VT74KHTdi4JzlDZ44nKM=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 20:03:32 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:03:32 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable trap of each kfd vmid for gfx v9.4.3
Thread-Topic: [PATCH] drm/amdgpu: enable trap of each kfd vmid for gfx v9.4.3
Thread-Index: AQHZvyQeuznPjAvZA0+Uf8YG8bU0z6/K57ZQ
Date: Tue, 25 Jul 2023 20:03:32 +0000
Message-ID: <CY8PR12MB743532F29087073936BAFA868503A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230725181550.254371-1-jinhuieric.huang@amd.com>
In-Reply-To: <20230725181550.254371-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e6a53611-79c3-46db-8615-a4e09cf15e9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-25T20:03:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN0PR12MB5787:EE_
x-ms-office365-filtering-correlation-id: 1e7ed6d1-ab47-4251-f8e0-08db8d4a38e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLvY3HEgDyDhPMEGl9rKS3v2j268xACLmUb53zX/QBq/mYeTwmhZAC5Xuslym/hrFhHXDdla/tL6vV5auQadbDj5QCcQvvzPPfQRVWANtW/+QT6Z320xXGqDv3zffOpnLqB0/CNea9zS4VXaDZ+r7TXvDOWenyTXCqIl9cQejh2QeNJH89AUWLdsPGvqgRNP6SlID83Z2UCTKxh4yeQVSNVS6vVLGxFaswreGdr874WawaPbolN8ZwUEkj+D7SPavHIs4m8EFd+aRf9dyc7shwa1y4RpFlXG/p3WimhOlOS887UdcaCSdMS5kQkHy2ZKBkFI7h2kaWEJJvcOeHS4E6KSylrNTyk5FYukz1xqXuqh4w7d5xTq8ZuX5jbJq3E8aGc/3AfUUU6tO8VD6/lY4r91qv9SvThFdWU0uqnXLNf612xrlLyoRsSOjlbZ5HwZSJmtxUPxXWX9q8YJXisafF8bzKdgdhZEy+x9g9/tqE5F9jGWwZE5GpQTvDQyDu30FA0/p+7qADtqXzSmybNFR6jl1VJ7+G47fsPY4K/aEQe6Hnugg/+oaZeWu7fpN9YS5Yyml/MuculmOZVTZIZ0gWKgIzQUyelg3dzgh8QjLXyFls1Ev+ZQpYqr7Nxx2U/9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(2906002)(41300700001)(5660300002)(38070700005)(316002)(52536014)(8936002)(33656002)(55016003)(86362001)(8676002)(26005)(53546011)(6506007)(9686003)(478600001)(7696005)(71200400001)(83380400001)(186003)(38100700002)(66946007)(122000001)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bMCAIEayTRAihfQnUMm/c8aPhLj+2pMN+Y40SRfrcGkhscfzZ32z6NycFYPa?=
 =?us-ascii?Q?yFLHa95iPD1PnyCpDunxSxIazNJLTvwycnrsDJogxD8seofMsxxv7ljnzoUw?=
 =?us-ascii?Q?MyeQ/c4Z+CZGi7xHhyxYqCWGyczC7p55L+R96V9O3Uz5GE3CUCnYUvm0nCkg?=
 =?us-ascii?Q?byt9O4U4v3O/2qln2yN8Q8kwdKBUnSykjCxfUMYjGV4357XOggdoU2ooZxet?=
 =?us-ascii?Q?lQuAbxBDY1Q6lgUjXEhMzDuh/jsMnvHMagzWGRUP2aTc1C82DZKfVAKQRoAI?=
 =?us-ascii?Q?995J6jjN8g3GtiII2yAmlOkXw8RliYPTaO/DoTf3yMfaCXLOY5NOYEch/Nzh?=
 =?us-ascii?Q?a/0iqwjk0GWTL17Tw3glwrkoj02IfPWSXKD13sEkNQJeWrhZQEHi1/omAhYg?=
 =?us-ascii?Q?iOkXJ5l0/AhUjD2A8Bvu0BBRUXMjTMsS1o+0n1Br2qd937EiYOLZaqzzPnBQ?=
 =?us-ascii?Q?4QFJQWqbXSu1J+6Gj432Ht8x25VocrPRmnFSRBO5uTEJ8c+tVLyiSGhs78RX?=
 =?us-ascii?Q?F6pCVzszE05BwaxWOPb4z6KYrYlzTa1oM/f/jrudktH+TCm2SjDMxjMCYrNS?=
 =?us-ascii?Q?57oPWUN6bdtcPOqHmAtinew7uGVD6h8kSZVaOA0h8dOHgLGHwXq8Y2HAB5yd?=
 =?us-ascii?Q?ZL/XTXmSglb0Ik/S/iAgNpID/Fv/jcsfl7MC4vS8JP0Pl4JrIvGgilHYLb8m?=
 =?us-ascii?Q?7NDh52d3QjmgJ7ItpwrcIlE29UZ7uwqX7ISKF4akZOsAlj6OW7IOUUp6cd+p?=
 =?us-ascii?Q?e+kZHEs2FEAxArPS559Idtglr6vYRvNAcR3HQUlR6tfG776U/+OnL6zMhIVi?=
 =?us-ascii?Q?mROaqrsEC8XDpBkozn9UTxu8xEO/DWhfW8urRWRBNbqTIBTatJXRDLZIEAdB?=
 =?us-ascii?Q?2+wcfOoYRMPv9+PUuADisIcvhfNjQEpXqUg+fLy8D1RNDVA3UJzNdQis/wz0?=
 =?us-ascii?Q?yB168o1aLeAv9aJquMBfjJr4LPNtPvwUKvMEzCW5E+A0Mu5ceF2O2RMhKKeR?=
 =?us-ascii?Q?mMNVO8ORu5EDm7w4JENXEkGSgyEGXvL7NOe7/7N9VTJF/qhvWE2P/GuC0a8I?=
 =?us-ascii?Q?YalbLiHe5IuJxY+apjqbpjFvA+yVbG5sGKDhjZc+31qhLUraJWnrDfe6v8OH?=
 =?us-ascii?Q?pYEQ+6VmyE8F19G+tVzzTy4sBGKyyk9XmwpkS8qV58jHBRmPuv7tNypbMAfW?=
 =?us-ascii?Q?UQe59UIz/uUqGxNh4GkvmHbHxVZtM8tsUdnNkUuEGLoqkv90sRHxnFfUaa3l?=
 =?us-ascii?Q?zIbuZKMyYptpmKNjhxyO+kdqPL7A4PMdrNpms18nB8Nu1BbQ9pn4UOBlZitz?=
 =?us-ascii?Q?kDl6q50a7FgP6tI7Vzyqj4UQxo/UL7UP2rySDJFzyISTkdpKkbtH1D7gbbUN?=
 =?us-ascii?Q?kr+gvcZ/KukKaFZ/GK4Lj1NMcXCkU2R2QxRmx4pOZN4AGiU5yY9tLlvozaKF?=
 =?us-ascii?Q?8s6dDWi4yHEl415HtlywsCaBQiTV0aOZNI+tk2iRaHZVdMDD5KzMygxeMVip?=
 =?us-ascii?Q?cqXC6tVhrekx9VSgN/FH08UEo1o+v1QJlqCMr74nqijulSrAm5uCjwvDdz3N?=
 =?us-ascii?Q?SqEOnw6+CxQkj3aZemE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7ed6d1-ab47-4251-f8e0-08db8d4a38e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 20:03:32.4409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fndWySyq1Z4/nJNUD+SWt4Qm7T+NnwUszFnZVXLN1J0H6hSvwipMANitFf+hx3pk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

[Public]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Tuesday, July 25, 2023 2:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: enable trap of each kfd vmid for gfx v9.4.3
>
> To setup ttmp on as default for gfx v9.4.3 in IP hw init.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 86a84a0970f0..9a90fd187909 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -898,6 +898,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct
> amdgpu_device *adev,
>       int i;
>       uint32_t sh_mem_config;
>       uint32_t sh_mem_bases;
> +     uint32_t data;
>
>       /*
>        * Configure apertures:
> @@ -917,6 +918,11 @@ static void
> gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>               /* CP and shaders */
>               WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> regSH_MEM_CONFIG, sh_mem_config);
>               WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> regSH_MEM_BASES, sh_mem_bases);
> +
> +             /* Enable trap for each kfd vmid. */
> +             data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regSPI_GDBG_PER_VMID_CNTL);
> +             data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
> TRAP_EN, 1);
> +             WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> regSPI_GDBG_PER_VMID_CNTL, data);
>       }
>       soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
>       mutex_unlock(&adev->srbm_mutex);
> --
> 2.34.1

