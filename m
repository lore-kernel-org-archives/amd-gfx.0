Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A465FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 02:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F240C10E187;
	Fri, 10 Dec 2021 02:07:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD0610E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 02:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj9HGY/1ON63+4H7eAI6pof0006XEoc6oQNkHkPCH6kEkC93K1FqR+Va5u0MziNlwcbr3BaY2nrY6gYI3Q39BAdLtLBIKkLyakg46mq1nEiBmiRO4Q1HY8VU4dWoEzswoNaQShJLugpmtUz5/e5rBEPIsXWx/MOPomDDVS031Qmq4nlkgZXNTuWG0Z3wf59GLHctcNBBlsw4a3DuLk4jtf/8zRjlmFWkYNiCm+5ANkjuSpTQg0HpJS1TConR+/xvhE9IdNzhX3Wwi8GxXrAAeukgBRGSLnQk4dc6nKb8T3g8x8HC6OZLC2b4/IxuZ1P/yqayUtVWw3EVqKo1rJmQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnxLAxTKQJBicon+xcoHGQq4KwBJiT4ghw35Z6sf5zY=;
 b=aQhs9mAczZtu3U64Z1zNUsc+JyQmv/xTujzPGmdXZbo+TgZuCjQ4BAZafO+l+IM/MdhB8VpTNEHZ8llMHVS44hVlsfqzLyy1Fu6ZfoXBpiDE1bYyupSI7iHClHOxBZepTZk1Kzd9pGilJfty80MZrBXsEk7PhPEB1SjxMZ861/uTKXp9qE9ZKOTEhZ2gvAM+CdWBBsOWo9CdCmvrDz8IwszIvj8dmj6Whvlbrq2dBJKMHTTGOeYTojb5QZTuWJWQvE6bNgnS7tBH6+NV7Uwts4JUhLmZUHhWz/ggJZORTbOlWTHOfjEiGH/qkyc/t2ZPTWHWtj9XTgIUn1I5pEbv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnxLAxTKQJBicon+xcoHGQq4KwBJiT4ghw35Z6sf5zY=;
 b=mnsccHPOT2QUlD+/6GRH3FtSGpTiVjysdwH+SRyQn7Zu72Qbs3kkFxoG//JRFCg9HfSEKwIDeSkhKU5DJCptJJeEUqPHK4VVP4y14JwhWMCR/QvCW++LEw2apMRtbEYDytoJ6PqY38sEcS+ngmQoocQAYnvkcUE9yVfeKamuE40=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Fri, 10 Dec 2021 02:07:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 02:07:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Thread-Topic: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Thread-Index: AQHX7R3v1iwa+CVypkGTJSNpw3lfa6wq+MPA
Date: Fri, 10 Dec 2021 02:07:02 +0000
Message-ID: <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <20211209084914.261889-2-lang.yu@amd.com>
In-Reply-To: <20211209084914.261889-2-lang.yu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T02:06:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=57cb7265-e41b-412d-9e5d-0f96c23dfc0a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34a8f06f-d9e4-4155-0e79-08d9bb81c1a6
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3468878F38BC6CCCED6DE69CE4719@DM6PR12MB3468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wmp4lKHzhGtqMKX3Rqt+qR4g9BynJmSUiVOB2+UuNFT7MI+/9MUG2jKjxZgUZ7GPchAx8LaP29SLySbTTY86khZEuaeeXAQf4c+XklFcTZ6p6UjhrnoB+ouH/McABIuMfGU/fnugj01Wer6bcN0FsehCHZEWVNOYB0tAimLxU4CmXzM9Y9ZjLp4a3t71/76Q9SeVLeXspGbn2Lb1+HuiKPT/WZdAdKrwb/V0rJKxfEgSzj72u3NEIXJzZtyLJfjK3+qaOYNf75MaLbOXE3+UsbSRAImztrpDcpCKb4NcXr+9q8vfumBCdIl8Aoa6D1/cb++XGRxv6ianyBSGaqDTdFbQ/Vxm0YFF3HUyrWLFxTWayZIXD28qtOvB9mh6VPsnOLvD7MyM3Ww9f//X1mNYtyp9eKLpNwLk3PVpqwuJMDEvebZgqiUo4kWJqDL3XChRyKpcM1xWsnv138FgP4e6RaXi65XU2HwsoLbNUpKoavD6aMLxchPsZ5ZvbrEdFGgxJuucuW8C5Ldfhi11PWP2O1qUYKRI+MMvFRHuzdtT7hE1hFO7Bf8dK8r5kRVcS+gCeu+XAINb2bJn9jG4vX4jF8ZuRKuwnahitpoFuZyjgXNzBRL6NpjnVgYGGBm5/n0x9+rvXScTRoCsdmgNjWykO2Y83yDazNSfts8V+qzM+2mvFnGTw+/s/sVFg1xB0efSkxHH8DYfBn8m+mfV+6gL+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6506007)(5660300002)(55016003)(83380400001)(26005)(86362001)(66946007)(7696005)(186003)(9686003)(122000001)(53546011)(66476007)(4326008)(66556008)(38100700002)(64756008)(66446008)(76116006)(54906003)(71200400001)(38070700005)(110136005)(8676002)(8936002)(52536014)(316002)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zjLVfYeItYHHqKOj84u2bY/t8t/ezaVlj2XhK3aRQ3qwmdzLUwX/msRGfO2E?=
 =?us-ascii?Q?XeJoaFn5QokHGRuLrVuINufDoGRgCJASDuFJd5AzSov9sLZtkPJUCrOSXuVp?=
 =?us-ascii?Q?ZYw0zI0Cob80dbLm8AqBMabbobDhjCZXfgnsTqVNX2GWbDB56wBOrdxTySKY?=
 =?us-ascii?Q?eVy5g6nzKYkiIAxgQFJGMpOa8z1+b+pyoncgL9NGjXdpqOw0L17S7hse9TAS?=
 =?us-ascii?Q?/3+8+ZqTDNPp9bYL/iijxA+ONNMgknfU81MOwSbXxdfOKJUsK+XO7vjwUK96?=
 =?us-ascii?Q?8SPXV/tt3I33OGKFouw3eMihcKoIj69sZaEL33xjmkJdIwIA7xbs3+8X4dMH?=
 =?us-ascii?Q?q1cfcjh2+JS4OHpwl98MZkmVfEqHm7y3jiKaH397Lgn4Pote5+fIPOMQ3G7F?=
 =?us-ascii?Q?gJSDmAZMl8ujuICVcqRdWtRj83vU8b/+jpGmgeN2ojeHoa9KAEvnHCxeZOwz?=
 =?us-ascii?Q?7g7gQ8wC2EJG6tU240nRdTWbWv34mJs7uODEBodkS/P4Tgun+e/yoBKqZ7qj?=
 =?us-ascii?Q?eI5k98DWuf5r4CNMz9L55MU7DCu/MLmvTOJxDM7bWW05rx+WU7uB1irXn3YV?=
 =?us-ascii?Q?NFvaPd3kr6d+hTL+scHjGT1y2jzC8stUix2AMvBzCxeFAWBBl+ULqAw56xoQ?=
 =?us-ascii?Q?1E1RmvFmZTbWect493P4q9Kx9whFctoaAclbq4iPmfPgKsm5V2Anl2qNUZ58?=
 =?us-ascii?Q?i2VCVUsKf4juY+lkh5PYn3kIC3bPBprkiZh02s+x/Gq6zV9i+YZW4xpJ3Ov/?=
 =?us-ascii?Q?FEzWyy4nPnMiFuG7dA/9aakxer9IhTfGITMeY9NTqxCj3aS10N66ESGGEwxL?=
 =?us-ascii?Q?mw/RNAjdA9dIV6Q4nejpiBQGuggIJZmyYzxGcT3BgFWX4kxazI+/MwHf5oLw?=
 =?us-ascii?Q?iPt9KggcxVJeBoUmWylueMeCHv2OjThOVlw/0GhhaxvOY4c/7DeSMWCTgl7/?=
 =?us-ascii?Q?S9r3TZH83uUD+XLh3COn7wOKsRSJqrQyQu954WQiC0egNzQpue+YZWccO/pu?=
 =?us-ascii?Q?s6dpWXrslhmfg5uYKBKbPIGehx8BlwQJdBTp/X2Ql/020mw2KICFCQAasB7E?=
 =?us-ascii?Q?bb95O//eOSlz/7rOuZuqFOXzNpedec07grGNISpUpN4BQ47+wmVrAhugKPgx?=
 =?us-ascii?Q?5k9rugSZ5AJP+pWixN+/Oib2xTamEOjXLLTqUWHJu9MoXmvGfPSyGf34e/Ru?=
 =?us-ascii?Q?HIICtmvTses6tqwrnvwdnp0ShLtejOKP5xBpSBFdcBY3YPzbZ0BBz3Yrtvfv?=
 =?us-ascii?Q?GGI4EMbB3kKwbgl+4untFFnl2PngTvrBXOnSP/NP8OV22baUqRN8uf1cRQDC?=
 =?us-ascii?Q?wamhnUaqqrQwJypDcu/XK03xxW7upOcP3ev1N1j+yojEqVcFLIaXMBZLZM+8?=
 =?us-ascii?Q?EEAXmL/mF1D82gshVUDJYBdDuLsDu8gNOGEX8q7bC6Gfs8KLwsnH85rvzNKj?=
 =?us-ascii?Q?Jdkr7LDvDi02sv8snStqnOuiU3IdLgVh/64vWAQSTDrggKPDAZo96Y2is/Yz?=
 =?us-ascii?Q?8Lr3ywSafpE9Ltjn6B/Y5t6NvLO2+EHdqfMsV1r0mgvoAnvtyV9qt3rCbMSR?=
 =?us-ascii?Q?NicsRJaf3OSghspkWMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a8f06f-d9e4-4155-0e79-08d9bb81c1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:07:02.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmftsHTlgzFMTujpZyspmn+jr3VDiPzPGpB1OjFS5lTauumnCpTy1KyWJYmtI/xz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang
> Yu
> Sent: Thursday, December 9, 2021 4:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
>=20
> SMU firmware guys expect the driver maintains error context
> and doesn't interact with SMU any more when SMU errors occurred.
> That will aid in debugging SMU firmware issues.
>=20
> Add SMU debug option support for this request, it can be
> enabled or disabled via amdgpu_smu_debug debugfs file.
> When enabled, it brings hardware to a kind of halt state
> so that no one can touch it any more in the envent of SMU
> errors.
>=20
> Currently, dirver interacts with SMU via sending messages.
> And threre are three ways to sending messages to SMU.
> Handle them respectively as following:
>=20
> 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
>=20
>   Halt on any error.
>=20
> 2, smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
> for longer timeout cases
>=20
>   Halt on errors apart from ETIME. Otherwise this way won't work.
>=20
> 3, smu_cmn_send_msg_without_waiting() for no waiting cases
>=20
>   Halt on errors apart from ETIME. Otherwise second way won't work.
>=20
> After halting, use BUG() to explicitly notify users.
>=20
> =3D=3D Command Guide =3D=3D
>=20
> 1, enable SMU debug option
>=20
>  # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>=20
> 2, disable SMU debug option
>=20
>  # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>=20
> v4:
>  - Set to halt state instead of a simple hang.(Christian)
>=20
> v3:
>  - Use debugfs_create_bool().(Christian)
>  - Put variable into smu_context struct.
>  - Don't resend command when timeout.
>=20
> v2:
>  - Resend command when timeout.(Lijo)
>  - Use debugfs file instead of module parameter.
>=20
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20
> +++++++++++++++++++-
>  3 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..86cd888c7822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device
> *adev)
>  	if (!debugfs_initialized())
>  		return 0;
>=20
> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> +				  &adev->smu.smu_debug_mode);
> +
>  	ent =3D debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>  				  &fops_ib_preempt);
>  	if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..50dbf5594a9d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -569,6 +569,11 @@ struct smu_context
>  	struct smu_user_dpm_profile user_dpm_profile;
>=20
>  	struct stb_context stb_context;
> +	/*
> +	 * When enabled, it makes SMU errors fatal.
> +	 * (0 =3D disabled (default), 1 =3D enabled)
> +	 */
> +	bool smu_debug_mode;
[Quan, Evan] Can you expand this to bit mask(as ppfeaturemask)? So that in =
future we can add support for other debug features.
>  };
>=20
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..84016d22c075 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>  	__smu_cmn_send_msg(smu, msg_index, param);
>  	res =3D 0;
>  Out:
> +	if (unlikely(smu->smu_debug_mode) && res && (res !=3D -ETIME)) {
> +		amdgpu_device_halt(smu->adev);
> +		BUG();
[Quan, Evan] I agree amdgpu_device_halt() is a good idea. Christian and And=
rey can share you more insights about that.
Do we still need the "BUG()" then?=20

BR
Evan
> +	}
> +
>  	return res;
>  }
>=20
> @@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>  int smu_cmn_wait_for_response(struct smu_context *smu)
>  {
>  	u32 reg;
> +	int res;
>=20
>  	reg =3D __smu_cmn_poll_stat(smu);
> -	return __smu_cmn_reg2errno(smu, reg);
> +	res =3D __smu_cmn_reg2errno(smu, reg);
> +
> +	if (unlikely(smu->smu_debug_mode) && res && (res !=3D -ETIME)) {
> +		amdgpu_device_halt(smu->adev);
> +		BUG();
> +	}
> +
> +	return res;
>  }
>=20
>  /**
> @@ -357,6 +370,11 @@ int smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  	if (read_arg)
>  		smu_cmn_read_arg(smu, read_arg);
>  Out:
> +	if (unlikely(smu->smu_debug_mode) && res) {
> +		amdgpu_device_halt(smu->adev);
> +		BUG();
> +	}
> +
>  	mutex_unlock(&smu->message_lock);
>  	return res;
>  }
> --
> 2.25.1
