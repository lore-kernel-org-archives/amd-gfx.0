Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF9DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 06:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF79410E35D;
	Mon, 21 Mar 2022 06:02:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D80810E35D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 06:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OScSehRm+j9BPNaGX7K38z+Aqz369PzYclPzuzAVWbJkH1+DZk5L46GWhk27s7o7kD5JKfC4unoi/2kZCCD8iXYFmwh4NBcit57Fsxj4NXKhtA9fodk8ldtM+l8F+uWqJYdLv+pdDf2U8UxEmEzmvWizozDWl/fNmKexQKSozuLk5rg0Dspep5UWMhXJws/zAC7r6DVpP+4Z1jLS4aBocClwI9/lEp3a7EQSs24kst9+LXG0FnIcpOfnCFajD3bNZsFYNlXkvkh003WWS+U/qlrKckPzOsCN+PpgMdvMfXcYZRxC5q6Gp3jYNyHvOCGlRVV3USinoIeNirTmjIcTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvMKbMpVk2Ll6KITi5R7EEldEN7UR4jg4n/ynbIiaYM=;
 b=V54nqkoihCoS3A9coeCxAN8RsO5bWF4qFJK/AjU36UbsLRUUUMjbaHDoHR2lIsBPY/cCuycKT3v0RO9P7wozQp1WXFjZybpLw3x+O1KXkTmocF7Gca5Bat8SDlG0ORU5y1yljxixxELVeesJtbWD4MT84m+S6+Rh9nozorIw/LCEAugGkeyXOudjyzIUSmatX2nVPQtpPEdzjF4twgt5ybBkH1+ARo1G1CNxzfzpCPoVfQvKKtTF3HFx72n6bBnawCytnnEvH7xQsEG62USv5DaAx+sJYa+/TBNZ3mWCGwAJoB84B0TNZmn2D0Ds8jq8o31vzm54kAyDuRGgsXfiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvMKbMpVk2Ll6KITi5R7EEldEN7UR4jg4n/ynbIiaYM=;
 b=p/XnKLRNoM70VUyqiAhO4YY0lppee2cGyN6cg+T41WKM7AvZ+6U1BRZ8fZbIMKEhTr7eSWtbMf1wMg5Q89WlO2jFyi9DfnQlV6ECBri9UJ7H8n4G9uagF4q7YQ04hbc/W0BH0bGeSUrT4HPep7MJa93UxdAfJ05T3x3SGFYdNCA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY4PR12MB1925.namprd12.prod.outlook.com (2603:10b6:903:120::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Mon, 21 Mar 2022 06:02:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 06:02:23 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu/pm: add asic smu support check
Thread-Topic: [PATCH Review 1/1] drm/amdgpu/pm: add asic smu support check
Thread-Index: AQHYPObm14tHVhntVEyWOzqI/y5ia6zJWEEA
Date: Mon, 21 Mar 2022 06:02:23 +0000
Message-ID: <DM6PR12MB2619CF74F9FBA8AE45F27BF2E4169@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220321054533.15218-1-Stanley.Yang@amd.com>
In-Reply-To: <20220321054533.15218-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-21T06:02:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a3e21496-035a-439a-855c-b253ab2e2d05;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d92752-424b-479e-2096-08da0b005e4b
x-ms-traffictypediagnostic: CY4PR12MB1925:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1925E3BA0400E82153CE2CA3E4169@CY4PR12MB1925.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUN3nbtvJvqFgjGU7odZHjtohlZk1XN+jUDsww9rDJaNE5HBgCvBdJM/Jgw8rWPGjqlzfjmJDZ+ZsYNqu0iayL5xuXR9MnBIzB6wm+VmHqgOvMGnzuHv9HYABmsm2HR8STcC0KK7B4NKifCbxrD7J7IEAaaGaS+EkTzow3p7O/rIISPc3tbmhd7cpUKX1EVl0TfOVAYl8cHWb0w0dXda6feiNgWzVo5Wdi3Mq3JrNgTXGzXdwOQcMD72/TanDCeZTdwR135qWpGEGKf9zJgt2MGmoTovDBWZgAqrreAOcLQ/zkN0kKpNMg6ZcjKEjyffjCzo0OWyX4YZ85KSCc/TBYx7BTv5DNKMaH3JLwkWSYaZePP9tCiH8K86gUu1irQYhEPcQkz1ksSy25nF5FsnDrdYXPDv7GdsrRJrg/TG7jAsABNS/KBpu9PXjjQzeBEHESDqIic6O3oi1RWaysKpFa4h5f4OAsp4pPn8CUzTRusmRODX9yNdontLmesi3KlNqh96YccEXJdX5D8Lfbk3UBO6dNKRnpZlL67qR02MjG191Iy5FpRpACPpJidNX+wySOCnL6qz/Bd+DMeTYyOMIcbSfIhlAedsQoL6LjVi0qnF1a8cx1w7PonJ3sJ9twMMvt0X1lCQkRAniiWw0pi5ZThMvUgqCc124DmuOEQ2/0LPKBWgvQhVAp+njAJFw0TCN4gL4kyw7qHz9SE1pjsSqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(316002)(8676002)(110136005)(508600001)(6636002)(38100700002)(66476007)(186003)(66556008)(66446008)(122000001)(64756008)(76116006)(4326008)(26005)(66946007)(7696005)(38070700005)(71200400001)(5660300002)(2906002)(53546011)(6506007)(9686003)(55016003)(83380400001)(86362001)(52536014)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wER/mJYWxItGFxgdhRQeADtYoB01Gveu8rgRfYrtTLnjibtsVvFR8aeGyODC?=
 =?us-ascii?Q?CDztno24Ud1x4dGEWUkZ/hpGbhF/06NdNXG83aH/K7yJhoLv0SWxO9ICDaBM?=
 =?us-ascii?Q?LlDoUATdh7w8e3/sozKe40CttE797UACkWHSmk/6Sd0ULScjgoVuwUjvCWhr?=
 =?us-ascii?Q?VknXAPh/A1uRDnP6VEPZAuy2xpj2XMEDfvcjeiPF9yj5n6wqGP4Xlwj/icI3?=
 =?us-ascii?Q?+hB8minD0ODxdLkO76Rsl2YY7G7YzEjw1kRc6DJmXcIMCdb4EGYS46ZA7MdY?=
 =?us-ascii?Q?GBglVSjVmHvK1l9+u5wHQVm99YSkEtXOoyBgnAHQl9UfDmgIzMTa15WWGnI5?=
 =?us-ascii?Q?YHiTtM1X/IfG23+W+ysw/IGVTVrA02O2n0i+GeuhHvDzC4Ww5TFapGsmHiX4?=
 =?us-ascii?Q?cMMJ4+Meka73jzHa24QDpFV9+YuM8Hgwj+2kSJzINe41oZKlKoSaswssOx5p?=
 =?us-ascii?Q?TdSHryy7/zH88hsOcmbNvinRAVK0kBPRjYEhmmdtmpuMRppECMLOK+BLqdnS?=
 =?us-ascii?Q?rGIprBvEuA5h8h+J2xgbdd7grhyXd7VRMr30jraAcyqPNdksil0LNK5JaJif?=
 =?us-ascii?Q?Va3EvLmBy5dXmdl7j6LBjrKpttqxv9e0lSAloSjEADvdwH0dVTbxo6msj9GV?=
 =?us-ascii?Q?Ay6FrbyBRB6UhfX5oa8yC+wtavdS8QfvT+lSVpXGHLVIUgN2Fsw3cpJ1ixJu?=
 =?us-ascii?Q?Hy/2+rscZ6n72MBD/8tGLw2wkL4jnETXJSKdVxwhcQuYS7AcFmjO8JXxyE1C?=
 =?us-ascii?Q?sg2bzOqtYSHPf/bIzvSX1cbBYWHS5A/LXpWFeVf856LhxizVeqaCt8Y7yyKI?=
 =?us-ascii?Q?Rdum54y7nXk6GvgWWvfEl7R1jR4l89/YHmx1qZEpyQXWFXjfDS9TsHuC8iD2?=
 =?us-ascii?Q?nFZS7iwxzaQ+HhEKD80kQB+cgP2xF5NsOsDXM0ORbhOb1p1ADxT6tyBd3o+t?=
 =?us-ascii?Q?XaiGpL5tuIUhp7mCkqHCUhZiy4N9isj3+FqceJ/D712W6CecFUzg9eI/f5XU?=
 =?us-ascii?Q?86L3lrjK+S7P3F5tUWEpNCyfFO5ppTqejIoVTYz2WMKKCuadoGD9YB5XSsgM?=
 =?us-ascii?Q?w91gTUMGp0W2/7FxGna1UDRs0yPZYyUWAcvZK4fAWg3aymMruOfTJPjK2l5j?=
 =?us-ascii?Q?/ZttCYtp31wgNjlVC/bRKsBBSeROreUXuKJKwtNB2fTdGrgf68ya9IeTtYz/?=
 =?us-ascii?Q?/oVA8A6gp8gDz4KGfuh5WibT1mhc9ZKfM0xyu4JYOas1ICRdPEXIp1Gk7O+5?=
 =?us-ascii?Q?rNvvs7icl6H6PTfJThS983QnRSYwZSPI/7EcB44apm3hOBaJfXoUzAqp55Y7?=
 =?us-ascii?Q?ZoIEToZlV9apf7XfVtU5vEvHdt7zl8YCWaiNPeuEK5vkeYSv4wqLQMYb927d?=
 =?us-ascii?Q?X/w/JwTXACr1xNL4sBRLrZM+le/COAjuTCnk8KpoWcpc0l33//K23HjJrqeM?=
 =?us-ascii?Q?2BniuwNIroY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d92752-424b-479e-2096-08da0b005e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 06:02:23.5140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdbsHFgjre+QQVgC7rgcfi7FJCfh6yPVMo8VAUTiINaWBv0brldTItsIGlG6ye8d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1925
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, March 21, 2022 1:46 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,
> Candice <Candice.Li@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu/pm: add asic smu support check
>=20
> It must check asic whether support smu
> before call smu powerplay function, otherwise it may cause null point on =
no
> support smu asic.
>=20
> Change-Id: Ib86f3d4c88317b23eb1040b9ce1c5c8dcae42488
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 89fbee568be4..c73fb73e9628 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -500,6 +500,9 @@ int
> amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev,
> uint32_t size)
>  	struct smu_context *smu =3D adev->powerplay.pp_handle;
>  	int ret =3D 0;
>=20
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
>  	mutex_lock(&adev->pm.mutex);
>  	ret =3D smu_send_hbm_bad_pages_num(smu, size);
>  	mutex_unlock(&adev->pm.mutex);
> @@ -512,6 +515,9 @@ int
> amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev,
> uint32_t si
>  	struct smu_context *smu =3D adev->powerplay.pp_handle;
>  	int ret =3D 0;
>=20
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
>  	mutex_lock(&adev->pm.mutex);
>  	ret =3D smu_send_hbm_bad_channel_flag(smu, size);
>  	mutex_unlock(&adev->pm.mutex);
> --
> 2.17.1
