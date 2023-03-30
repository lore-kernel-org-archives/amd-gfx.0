Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AABC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3421810E120;
	Thu, 30 Mar 2023 06:42:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E0E10E10D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU2upU9hQ9FFfR6gxzOEJ3wG5Gj95GI7wZ29fRb28dEXGkGiI6dbki5CxntWxEYROG3eEkSWx1OnM22G3qrc3tWHY9xqsKEWibC47h1mgdD6OYPbqq4Nj0hHBVuCrg3yOgbOWXSxTKGTPHIuiNQRIXtuDZqnlJMuDAgJYlTZE6SicJki28Aduf3IMKjljnD4uIXxlg2bhm1zkVD109JhHQTW+eUrN0hZMtsYAE/79WgiYi9DM+M5OjEVY0mz/OOrE3sPDtA+ghj/3wOJDzfgOrHgsrIstWQZoTVBx8a0jandLgzHLGqIYNxzyMYOZvcGGqonTs6TSj9nifF0dePB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBXZn6b/h3IppoPlzlmSXUmKjtqn9vNZVt2T7S+FRyM=;
 b=Y6h/GFPW1KFBJEIYV7kaGIigWml8wr6Odqyec9MjDbokpaLo8ZIuK9k/Iba5MKgoqiz1jkLTb1LieOlyfiAFCsp3Mc6FBUNC56OMp7KKl/8un+OV5r9gQ7cTFttGvniFPd7332FRkaj9AOggFyVXqDIYS4lYqGgwxRER8hDlJDOxbSqg0jRSaftEResFjQ1L3dXrCZH12mcaQAtmpk21d5wKgyqkTCmH+rqyWq9eD0vnjdeCh5n70Xb05I1HUnnJDe+2mGb5qNCbJyfTF2bbpA+eKBwQmKwz6yYBx5pXwjwt4sUZ8CNBOisF3n7pzxHeo6ls9Gt23CRqoDfYEBeheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBXZn6b/h3IppoPlzlmSXUmKjtqn9vNZVt2T7S+FRyM=;
 b=CHyfH8Ni8BzIZwg2x9mfce3VYJS+ejPc+5BxmIFKznMnITt6v+92CuSWCXf5XJJF30VU8TreO62JK/8+MbYVWz7y/OPOLHNNENaZhXM28gx+MXI3vCql6fumHWGxIRci6NtMOyTra8dHQI2uS3uExxY7FM28gPn9/ABn7ebYUYA=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 06:42:05 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::3508:ef9c:2430:e499]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::3508:ef9c:2430:e499%9]) with mapi id 15.20.6178.041; Thu, 30 Mar 2023
 06:42:05 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Topic: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Index: AQHZYrANiD2+uJG4hkGxPGfXwlTcMK8S39qw
Date: Thu, 30 Mar 2023 06:42:04 +0000
Message-ID: <CH3PR12MB86572DA5A7D1A9E1F388DB8A9C8E9@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20230330023302.2466048-1-tim.huang@amd.com>
In-Reply-To: <20230330023302.2466048-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T06:42:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d848d6ef-cd71-48ed-b921-5ae844c867f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-30T06:42:02Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f4b33fd9-41c8-4c1d-8793-6ddf72f1fe9a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|MW3PR12MB4425:EE_
x-ms-office365-filtering-correlation-id: 379c8bb0-ab37-426f-cbe7-08db30e9e01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKOF8z9tRGBiP12yCysFIB8liQxVKTir6CzAQZyrkc28X20K0GPAtxvTsvOnvDahZcBwT7qo7z0Fnux4JnDjCo0DJHgO5twuwEuNjLRCZnaO/EWDJwldKy3WXA403Fl/4Pfe3DLIqreZLHv8YR0BV58OEVqtlbN4pWrg9InfhSbU9YBgraLrQaR/oUpPp818z/q9PGrZQkdwzIKWcfF2UhdtZBMViFzWO60UnHdjOKkmmq3oebpDggCWeENTrmWkC/YPSlUsoda4qILRhG5dVdbLWoKIioIvz6F7Zohqy8XxWgna1HtsbKsLY+zXqrTU/h0uLNWieSWHJOx40we11Lf5b3AbO5vfQtZGXnfDewT3PM6qk+tIKP1P3bJrGCimh88/TH8TsLj2hTTa/BYP1LL5fF+ZDQ7Vb7GjKzrwrNCoBd+CshiBcK4nHYl4sygsMk5ANqlMDT3ccHjJkMyFw5S9AWn4YCCL+XH1adil9B4fSpN5xa94HUYZC2UKxpYOwzSZ8zqeKlAfbGxu3f8AWWqz0Yec8/G36ByRHj2B+kceEybCXkOMQkJEXe6vz936
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(86362001)(38070700005)(122000001)(53546011)(33656002)(9686003)(83380400001)(5660300002)(6506007)(52536014)(8936002)(41300700001)(186003)(966005)(55016003)(71200400001)(76116006)(4326008)(7696005)(66556008)(8676002)(110136005)(2906002)(38100700002)(66446008)(66946007)(54906003)(316002)(66476007)(64756008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bWG6GYWJGtNAdV5OqJrKruTXVGxTjdFdbBfgEAWeb+ABvRZuV9EItihkWrQL?=
 =?us-ascii?Q?8ELTaMF9P3sK5A0/PLI/oO1kB3TJwSiFSm2lTHi5ps22DRGh521OCSnD4S4x?=
 =?us-ascii?Q?owAkybpyRWq9Hu4oL4JWW7LW6QwRqCVwX39MQksn0WI38eHdm2WZoqAoBd5c?=
 =?us-ascii?Q?wwJv8CqRAoW2wtGCbshruluvCYnjFO2w75ApZR4s+LtAYEcsFlSiUZF5KEaN?=
 =?us-ascii?Q?gZPlcutBbyv6qFKZxQdz/33AE31HAS1N3Zdna37yDKzfizFqTnbAkfe1NZHb?=
 =?us-ascii?Q?9dyMkQ8i92opxvyGAncuM72k0DXQy24WRcxgdF6U7Crl/RYNuMWGNx/c2CS/?=
 =?us-ascii?Q?FFKm7t1AOhuS0Hcl3HuTnx2CLvftagBI2KeeiqNZdRMQ1SN8rTrFackdTm1F?=
 =?us-ascii?Q?8lh8Z9urg4hu9LyySQTLXl673bLut1gyKvEFcI61Xf3FqdmFiRcRzsYp/qUl?=
 =?us-ascii?Q?0ePBtd6Zn8txYmQS0DEo1xWUkYGN07N/h1F4Cp/iPaSdcRGuxCU/xioNYK18?=
 =?us-ascii?Q?B5sacbZ+YZGP4rJRgR7Frbw68aoguV39NRFCq3O7pJQVsTzN2/ej5X3LLiju?=
 =?us-ascii?Q?Z5EvN9tApkVdW+o1w8chtUZaVyfOcFLuWkiuuaxYewT/JP1ZuuAJnFlLGDlR?=
 =?us-ascii?Q?s4OgOZlgKWAhaCgrOUMObHHR0x7dRYFS68pffAtp9RcJ9XlHPstHLtM/hn4c?=
 =?us-ascii?Q?AAafafgb0vnmwxTYGSi3T4ifBKHxInCO1EKUGmi4gq6LMyVT9xGsLOwaGNls?=
 =?us-ascii?Q?7edaGoq8UKW1VfHgRH3cZ2aA+HRS9zoJHw7gYi/XybU9ovC3dru2EfA1mVQG?=
 =?us-ascii?Q?gW777RebL2CsuxRGA0jm09NBHAt8PRr0LGhqrVtOg23R+PzybrtOS6TrurJU?=
 =?us-ascii?Q?FLKT33clhCWj7pjh+RALKwahXYagg+eOJfaUy4xHsBU9MCZlvGm5oGENpIwR?=
 =?us-ascii?Q?MKT3SaVRkp5+XJFEpk0C7Tw1KXAfGUxpJXLz7Re+j/96dXBHhsQm7ZjuhRsf?=
 =?us-ascii?Q?G/KX2hzRkYO1WsSirbr5Zom2oRTOk/O0zEhxJLFYSCVlY6rqjVbnQHtN687J?=
 =?us-ascii?Q?9YY7bpop88AnRnCJrCCjK9oONUedeb5iNBD3vcgWibp3LCiRscK3yCrf+PgU?=
 =?us-ascii?Q?KxJ/n7H1GKhrNBnrCH7AgB8P8eb65aLXrLgzJkcsQ5bCe+8+uosf9l+UKw0m?=
 =?us-ascii?Q?uABJ7Rj8iUs4Flc1p/G/ggAIPdyXl0+jIE7wHMEPj6UZ6rbqoTbTdVMTHmc7?=
 =?us-ascii?Q?E/1dwO/Cjo2CqYeYpJnz7fA1NAJL0FNbieM5smfb03wVjdo7+Gicz+ZUikQw?=
 =?us-ascii?Q?E30+ynsHFP0XHbzxFOyY2/xh4/9YRlJeEAYojy9Mc0mULMeoYapFfuahHEXU?=
 =?us-ascii?Q?uwmcnObM8Jgir1eLFdnwqLtVVJujndMr4kkF6kGYzSTuJqbrhGVZIvvA5Vio?=
 =?us-ascii?Q?P813KGJ1KyDDI8VwzzwNzw7oFzY4hJKdSRcjbMIONIyd7Icktgda+zK88FaC?=
 =?us-ascii?Q?E5JnCI63jC6K2XXPemPIsym+ju3v5v8eI3YqL3O13UT/PmDWgbIeCrHGEg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379c8bb0-ab37-426f-cbe7-08db30e9e01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 06:42:04.8372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZP/aAuzvxUqUT36Ad3VXvM5hubT1Z/myBUoWBpLYINBrRbUZKMocq969fpTa5oW0NO7aW5UJYvn09uYGoHIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Tim.

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Thursday, March 30, 2023 10:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Ma, Li <Li.Ma@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when
> go to S4
>=20
> Skip mode2 reset only for IMU enabled APUs when do S4.
>=20
> This patch is to fix the regression issue
> https://gitlab.freedesktop.org/drm/amd/-/issues/2483
> It is generated by patch "2bedd3f21b30 drm/amdgpu: skip ASIC reset for
> APUs when go to S4".
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 0f7cd3e8e00b..edaf3ded4a04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct
> pci_dev *pdev)
>   */
>  bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)  {
> -	if (adev->flags & AMD_IS_APU)
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU
> enabled APUs */
> +		return false;
> +
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    amdgpu_acpi_is_s3_active(adev))
>  		return false;
>=20
>  	if (amdgpu_sriov_vf(adev))
> --
> 2.25.1

Thanks for the quick fix.=20

Tested-by:  Yuan  Perry <Perry.Yuan@amd.com>
