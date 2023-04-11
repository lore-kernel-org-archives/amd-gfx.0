Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BDAC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 03:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3937910E337;
	Tue, 11 Apr 2023 03:00:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60EA10E337
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 03:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDUETWEA9ia8DW5nD6bjak19MY3oc+OIzEzT0cpG8uuY4n6JEO5SnHZwc/e9N60mkEpuu+OGn+8l04He5hd2uiDnj5qFpf/i9LNUfgqtAjnhzwIxrJMgEeixwBXPD0tcr0BbjQK4BqWnBxuTLwbheQ6HjqdnMUucW5ZjDdVrO6iXdkJFTuAdgkRyCs6TG5aYMtGKRPfLVY/zHAI+NpQYwrW0+Ojjw3YpifbhFmbyGwDw+fXaGh7gcLbCYociHodh/dsG6TGiXg8y3og2g8WLHZyRHJP/DC9sGN/SdIniXJr4N1qs+N75FrpdH2oZfvTSDIqeSdwtBcg/O/BJF+mWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiTjvvhYnlCkKo4kjdv2VARtK3YiEi+NFxLVXv+XGYo=;
 b=f+0ZSjDNEBqpWogSnj+MUR3khYy2Db3YgqINetHgAHWF6If18nss5xi0+dsmVvXu5IGo9OWybyWAabi09R1XOSlQjItAvPhUNA5rFr51fu0jZm3P9EHbHA9RCJQdT/qypP26SetqnXxi4wL9fWsL1VdblwkSi9pSYMpErYvirwqKhsa/NkZRRNCRZqAf9Kk5gX1x5jtmm6Jq/nAlIRHQIIRMmjjvBFK08tuXHz7w6vQmgI0525MmtbqzjmdnoZKo/6naOHi5JF0quWFsANUixVQ18MS7j26IhS7S0u/aQqF9CNgQezhug7bNWl9FEHTTRTD2zq5DiLI2QxUd1KwcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiTjvvhYnlCkKo4kjdv2VARtK3YiEi+NFxLVXv+XGYo=;
 b=qxRqIyHvqFKjl6SUY4rvnPIqLQxC8pZRwBbGPYlBL3lTQV3s3lXJ6JD4/ZWRzpXI0+MFkZGcl5seYbV0BqAMZ+eUu1aeJ+Of0jBNJrXpJTOMDJKgRWprddPEtgFh9M08g9q0EzXHNVEnqP6F9YyNFsmw9WASRJnaUjIR5Kh35fI=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 03:00:40 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 03:00:40 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt
Thread-Topic: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt
Thread-Index: AQHZZ9U3vCOxIEkl8UW6YnoWhLoc5K8lc+Cg
Date: Tue, 11 Apr 2023 03:00:40 +0000
Message-ID: <BL1PR12MB53348A67A67534E41EACBA559A9A9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230405154203.3899014-1-Graham.Sider@amd.com>
In-Reply-To: <20230405154203.3899014-1-Graham.Sider@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T03:00:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=23cb2eb6-181e-4900-9cac-a8438f060f00;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T03:00:38Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3a39846c-ef68-4914-8894-7323eec6aded
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SA1PR12MB7223:EE_
x-ms-office365-filtering-correlation-id: d982ac21-2cbe-4ee0-0105-08db3a38eee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0KRBaYWck0JDkaikLiWA1DM5MeXXWCVzAP4wOjqQr75RB3f7Ik4SVIuw3G1hXM16gT2EzsX4aLhjHFfEzPHBmlD9nAN0d+jF7oevccUIpl/rbQONzQJUhHvu+YFcTViPi7TIaiUUDpttiI5y8f3XExUcrNH9tOXbNu+b8itUXfzyToN+gjTYF1fLd0tJgKZ1Iunk7Z/p/NAkVnewGDmORuz41Yco1s1Q17pmZ6SFy14nhkylQeQ19Q3zUeG4jKO38r2g1YNR4atEJJ8JZyHK3z9oRXyPQRPDTzZsP/J2PvrJWn0Rj8W42hvd2tvId1bHWPZnViIMp55lc92ekXOM8gcAZq0jo2H0k/MvEcqr/s+AasfmhP+PAVyVvre9TeG3Gma3q5MBTR2Kl7qgL2kXBHBMe+ynz6C748GbVGIiGZE4vQ2yzZHjPiIpBx1F4ipdKk8xeQdgdV8TCGCQanMCveTSYWC/WRmR5wmXwIrcQ5Lbj4QCLw1eNpRS3m8LpMzrq5fzBIH6zd8wDMa4oYlUYmP+6DUBbPlyX4Dp4Z7atYwy5Eb4BA504Qi83te3qWossswLySqEbuS9Tx/OGC2L8FRW8cSWi3WOp8SwT+JsXhuRfIiUp8oAkyBOKUMC9Gd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(66446008)(76116006)(66476007)(66946007)(66556008)(64756008)(478600001)(5660300002)(38100700002)(110136005)(122000001)(41300700001)(316002)(8676002)(8936002)(55016003)(83380400001)(53546011)(186003)(9686003)(71200400001)(7696005)(6506007)(26005)(86362001)(33656002)(2906002)(38070700005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QJenAH4L4ggWsJRyA+w2htVAVW6svHVucDHLAHtwSeRZN7I+uUphFEtotSy9?=
 =?us-ascii?Q?0bD4dZDCJRO868mMXiah0hh4qQ3AU4qyTz/XpfGEe416SGcBzyRi1VKpE4JB?=
 =?us-ascii?Q?xMCEs1OPViLlVZtSOyNtu3COPyYH2cA/G6oIpogThm8mHyk5WLNOVtzf2l3L?=
 =?us-ascii?Q?LTMDosb6KwNugxHMb65/YdYflb1fB2S7egyPJDtvDB97fgLwr0f75CH7SipE?=
 =?us-ascii?Q?6M4nFoEri6Odk6ifyM3LhI1iA9XbgJzswyzfj3WvWy3KJnbT9YavSb21ivtk?=
 =?us-ascii?Q?WxFUJ0HeLO/ybax8uGMQ6smV1NsRDHinw+GYu6Liprb00ybXesg7ZP5+mSTE?=
 =?us-ascii?Q?LcQO/C/Cz0uFD1CsTaIUGGQfSd0J4wqw/a98F/uP6RYgxWET5uDu7ZugO0l9?=
 =?us-ascii?Q?IpWmNtDxWldGCnahL9EK1fiAY+FOvZAzcVP0NP6FXA9bHpOdVmx1LUoD2Moc?=
 =?us-ascii?Q?cnHcGaZR/V6zJS2Sx9xucXRUOhKvXsI0g+F5fCFEPDwGAO9eposdqOv5twkM?=
 =?us-ascii?Q?0Q0etG7vi62Ua+ZPDV5HP+bhH53AElsAS6Pv1L5B3pW3CY1/ph2peLJggz1D?=
 =?us-ascii?Q?X8lJS1Ct4FquCmZHJQHigQHjcpfuJlGebT+9ZT8/456OPfuc/cXkw2fXAPIU?=
 =?us-ascii?Q?WRfqhKBgxEzMwp6J4G5PhB+jQUEduHOxNl5WMAVzqmQZA05Nm+DWAN+r0uek?=
 =?us-ascii?Q?qp+8WNT4C1t1zbS5Hknd8AAiyUMTGs1ghxbNIFQEHM15ru9DFBiMgdBIfRhx?=
 =?us-ascii?Q?R2Kqew5ULO7/7qbsCgOBhwE+1ekL1axOFpgnH7DGeW+SAalbBj5nNhGvDLL/?=
 =?us-ascii?Q?/U5jY6EaUL1sc5b51+Z8Ctn5D/bGSUHv0tCkPLdaW1GvLAqHH5Ql0cdPdltQ?=
 =?us-ascii?Q?W8vnxiv00xyb9Pw7rSOxOKIECySXk0BnGNEO3mkQvLcWxdz2trBWhiJm+6Mf?=
 =?us-ascii?Q?FngG80ANRwh/8aVClMYybSIoNQGRsJmkTAl1sgcYuBQhRVHMmbayN1xju5uQ?=
 =?us-ascii?Q?O+NmaF2rIzmG8NaEl++Gl1vL5LdxlGV4VRkXvpE+bJ/gkb/Kuu5tAnnDNIEE?=
 =?us-ascii?Q?7pxELFzO7qkhDoKTPA1pLflGjDFk8NbyYnTCt67ZQ0vQqQwLGdYbEMVFR8Vt?=
 =?us-ascii?Q?OkmQFbQzoPmNYzcMaCdv9gIs4dSlNtzk4/kac7SyqUZpp8P6TLfKx8LQCxh9?=
 =?us-ascii?Q?Vr8UE0llwqIKI2UM09N5CkvXA6DRSN7EDc6N0H4Nps14jUy/QSQBeYZsulrX?=
 =?us-ascii?Q?T8dmNUrfpzzzEHjH15BiD2kLwqMlrp/sMxStoEouXFbmjZVJkVs4CdriIs2e?=
 =?us-ascii?Q?JEmLQq+rZ/rU/n6GFMpQTpcQTt9JPxnT6LBdp78ZY0mBVfRDCHOw3jPUr0oV?=
 =?us-ascii?Q?0EJ26W3KEl8w/edZ3RZ9hrh3VkKzhkw7+LDYKuTpsbCHfn76Mus1AqzyOGfZ?=
 =?us-ascii?Q?C8LXEbQBlJr7c+NNBrU7kDBq5SmXOm+zO+IcrmHZKxj0ZwMHIs57CM250P7C?=
 =?us-ascii?Q?RrNFBYM8J8kBL2/RmmQ8ZnDF5ieDEPK/2lIoYcT4V5PE5j+XtAMPMhgaV494?=
 =?us-ascii?Q?fanRUjK3NH86tcShdqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d982ac21-2cbe-4ee0-0105-08db3a38eee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 03:00:40.2728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAGN/d26Adiy2kXLVEUMI8i6BRzxeSB8CFsevLlOGxTb+rJNU0qV+G7tFzZnqvnjDgeOhdNU6YBcmprm7U/j7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
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

Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: Wednesday, April 5, 2023 11:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>
> Subject: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt
>=20
> Enable SDMA queue empty context switching. SDMA context switch due to
> quantum programming no longer done here (as of sdma v6), so re-name
> sdma_v6_0_ctx_switch_enable to sdma_v6_0_ctxempty_int_enable to
> reflect this.
>=20
> Also program SDMAx_QUEUEx_SCHEDULE_CNTL for context switch due to
> quantum in KFD. Set to amdgpu_sdma_phase_quantum (defaults to 32 i.e.
> 3200us).
>=20
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 28 ++++++++++++-------
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  4 +++
>  2 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 40e6b22daa22..f45f7469dd32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -403,15 +403,26 @@ static void sdma_v6_0_rlc_stop(struct
> amdgpu_device *adev)  }
>=20
>  /**
> - * sdma_v6_0_ctx_switch_enable - stop the async dma engines context
> switch
> + * sdma_v6_0_ctxempty_int_enable - enable or disable context empty
> + interrupts
>   *
>   * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs context switch.
> + * @enable: enable/disable context switching due to queue empty
> + conditions
>   *
> - * Halt or unhalt the async dma engines context switch.
> + * Enable or disable the async dma engines queue empty context switch.
>   */
> -static void sdma_v6_0_ctx_switch_enable(struct amdgpu_device *adev,
> bool enable)
> +static void sdma_v6_0_ctxempty_int_enable(struct amdgpu_device *adev,
> +bool enable)
>  {
> +	u32 f32_cntl;
> +	int i;
> +
> +	if (!amdgpu_sriov_vf(adev)) {
> +		for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +			f32_cntl =3D RREG32(sdma_v6_0_get_reg_offset(adev,
> i, regSDMA0_CNTL));
> +			f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +					CTXEMPTY_INT_ENABLE, enable ? 1 :
> 0);
> +			WREG32(sdma_v6_0_get_reg_offset(adev, i,
> regSDMA0_CNTL), f32_cntl);
> +		}
> +	}
>  }
>=20
>  /**
> @@ -579,10 +590,8 @@ static int sdma_v6_0_gfx_resume(struct
> amdgpu_device *adev)
>=20
>  		ring->sched.ready =3D true;
>=20
> -		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence
> doesn't need below to lines */
> -			sdma_v6_0_ctx_switch_enable(adev, true);
> +		if (amdgpu_sriov_vf(adev))
>  			sdma_v6_0_enable(adev, true);
> -		}
>=20
>  		r =3D amdgpu_ring_test_helper(ring);
>  		if (r) {
> @@ -778,7 +787,6 @@ static int sdma_v6_0_start(struct amdgpu_device
> *adev)
>  	int r =3D 0;
>=20
>  	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v6_0_ctx_switch_enable(adev, false);
>  		sdma_v6_0_enable(adev, false);
>=20
>  		/* set RB registers */
> @@ -799,7 +807,7 @@ static int sdma_v6_0_start(struct amdgpu_device
> *adev)
>  	/* unhalt the MEs */
>  	sdma_v6_0_enable(adev, true);
>  	/* enable sdma ring preemption */
> -	sdma_v6_0_ctx_switch_enable(adev, true);
> +	sdma_v6_0_ctxempty_int_enable(adev, true);
>=20
>  	/* start the gfx rings and rlc compute queues */
>  	r =3D sdma_v6_0_gfx_resume(adev);
> @@ -1319,7 +1327,7 @@ static int sdma_v6_0_hw_fini(void *handle)
>  		return 0;
>  	}
>=20
> -	sdma_v6_0_ctx_switch_enable(adev, false);
> +	sdma_v6_0_ctxempty_int_enable(adev, false);
>  	sdma_v6_0_enable(adev, false);
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 4a9af800b1f1..85d5782eccd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -350,6 +350,10 @@ static void update_mqd_sdma(struct mqd_manager
> *mm, void *mqd,
>  	m->sdmax_rlcx_doorbell_offset =3D
>  		q->doorbell_off <<
> SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>=20
> +	m->sdmax_rlcx_sched_cntl =3D (amdgpu_sdma_phase_quantum
> +		<<
> SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
> +		 &
> SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
> +
>  	m->sdma_engine_id =3D q->sdma_engine_id;
>  	m->sdma_queue_id =3D q->sdma_queue_id;
>  	m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
> --
> 2.25.1
