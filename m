Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5701CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 19:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E784010E88A;
	Thu, 20 Jan 2022 19:58:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E55410E80B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 19:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQmfyuhCyQyPeNOTtwX9Y4cq/h0fBTruxE/7OlGbPAjlr2ueJ6l+xalh6FuEM76GhkYO4r3fWNil0vJHxleOIcmQAQhqb9JqyZabKqSMstKF1Jm87CRgjFDkUMLzNzg/QwH4tdOY3ITyiUUfDAO/A2VXuDPsas1l8btjmbjhIPzIGbOglSMmBC420Nbf3PoawWukVvStAvFFUhtjCWtDhsAcM9ATidgqhUVr/rE0VcEeUIFERhWQKgP7Cxc/wenax62XLLIq8MY+etIUvXIADUxYYDDLZpToxxbY24v9vvqbvn7KWThmKk+vJyXTH3H08CKgs4BQKZQ633R22DPEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz/yx7G+ZdMCwuYLJIvxcBZvIlqp7pDAHJKBUJ1gWPo=;
 b=NLdzOPYmTXxt6TvJK0WjJEEkpEvHsx/YYQW6Uoa762N2IqqrHzhd9DlQyGXLXet3V+5Eb7zH4cKcdgvJ/OQaQIfFXUVN75fvivi5ywBFkFuV7O7Y/rmFgfe8RGBnbzxwbssMaKV0YjWToveWXwpT98Eyf9n//4HLvETKbMjbVvJGvZNYWg7or7Kjak/N22gnURFh0rcjmUuCZGA+bHSvPPMwrHI3gyZJeuIbSDzaY8pXcxVyro9pCjbFW6bDfJ6WsYDx8V+ylUMx6gHg5PQ8GKNbxF7Ak+0WVdlF+qqDDVD5UDWNph1JDXZdlDQqe0n0s/F3e1tNiuHBjWEMJLvwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz/yx7G+ZdMCwuYLJIvxcBZvIlqp7pDAHJKBUJ1gWPo=;
 b=pgTDb13U6vnEqoePyq9IyAUHP/xOafkhC//ewqnzsuHB3ZWYBcLMcbDINrji+gF7BfKlIXry7k3+WAepS+AInReFfXzCcDHjn0Es291wd932A6hSvOVgDQ6rwXtkRLL/5tnUVnUqguHUsmG+ApvO4Q9Tp/WZiGBWRUgiUlUjkaw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN7PR12MB2643.namprd12.prod.outlook.com (2603:10b6:408:29::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 19:58:39 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%6]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 19:58:39 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYDOZvWjqZ4w+i3kugLoq0I8xZOqxsVlTQ
Date: Thu, 20 Jan 2022 19:58:39 +0000
Message-ID: <BL1PR12MB5157B51FADD5148BC295792CE25A9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220119034120.28807-1-mario.limonciello@amd.com>
In-Reply-To: <20220119034120.28807-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T19:58:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=97d9e7da-77bb-44ac-a394-83cf2076ec21;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-20T19:58:36Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f771a2b0-d063-4412-88a0-20cc56a86324
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6895617b-0de4-49d9-bb2a-08d9dc4f40c9
x-ms-traffictypediagnostic: BN7PR12MB2643:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2643A13CF21AF5BB65ADBD4CE25A9@BN7PR12MB2643.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zd8uYUHmTk5NSJF9AD1LE66TZ8OvMRWP0BiAMcb9W/2z5t8KV/vy58gh5d1znheee1M8l97mtKiv+8WShnkgGIX1Rw2yNO24xw3gg+0PcVk3mdojp9jCeSa5YhLgtmXTSJISBzJlVTiIbmFjDeJKDI+bxsc1jlhLYf8JnIjdpNM8knC8tesmRHaB3gO2/p/6rH64pRrbzWzEzhamz/loTwUqLA5DuihWgEUPG2RPeAyrRzfOskRLAbOccUpBpE61MhjvvijFrTO7dLQmCZ6fRFuJpj/sj8xLvTLGrlU2JJNOgEya/ztBCS3KEDQMoYR0DO9ZMoTU0u5r2aptfJjZFB/VbfFg9InIoKr/Gge76rbKur6pXhPUKKBrU2/9WiaW1KA5i7uT5nXjYUuogpLJoB90DwIWo2COxq+HYE/F60y4skJmNjHDod7IcjmcmF1L9Qiif7qtaRQT4dOhcJpvX0ex4nZtYuTQO0vxDU0BibKnbFVN2yMpozIY2fp5ay34os4mXjoyCu5nq5LtLUsvP74/XqGfhoc3bADZyPXlrd92sg2U1C9FQbZiQCY4D8p2PBo26ujnEA99WOZ5Ty67/PYGfFSbeNveo+xlZsB4iz6VL9ggO8hQh36p2jBMwcRQRkPzgouK/jpc38IpZsFxJlkfhxtTdIsDbNtwjownNA83oDgwV5rTtMS+zMnWxaPnp/FoYn5L5CNvM6PRAbgxJuFctH1diMa/QhBxtqa5ZVM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66556008)(66476007)(66946007)(122000001)(6506007)(4326008)(9686003)(53546011)(966005)(71200400001)(508600001)(76116006)(7696005)(2906002)(8936002)(55016003)(186003)(83380400001)(66446008)(5660300002)(6636002)(86362001)(52536014)(33656002)(316002)(26005)(110136005)(8676002)(38100700002)(38070700005)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Dz1228/Mfc2YjOzX1JAUNxLyx31l/qoN78LEGQ607IUpM3vEwWnFwRblva4?=
 =?us-ascii?Q?wyfaUyrlObGMEU2AYkbNr+bChP1VaoFnHnW4wyomGno0/JC/c/NKDUeL+yCL?=
 =?us-ascii?Q?oNRNehjKgBKIKmgNKYESVUHQv34jMgSWDL3IRYPVCzEUDyTe4E3BKQjbCjIM?=
 =?us-ascii?Q?ta6qWDYh+Vj/8hMrXmeEtwfKIJrBIaaaa+ugUwstYpODDryIStiElE+XZraS?=
 =?us-ascii?Q?jGmBIT4smvLwuinXEUCVYkcHVZgVgKvK/o4u+97Yq3IVbfQFOPww0IrWYIiB?=
 =?us-ascii?Q?yRPhUwz7yn/8oK2xlkDUBC5ddP5vP15xYmNDUG2bRl/15O4CNWVzeGu6yyH5?=
 =?us-ascii?Q?XiCZqZndY8oEd/TNcudTsuHX7jpatky5mhbKYHgVZlcYYyc7HYGMAwDsX0b/?=
 =?us-ascii?Q?zmgGpD3bbim/9X3Ezy/c6eMZct+Tk9okCpNFve3TJzxk8TvQQ4MLrKgP+hKs?=
 =?us-ascii?Q?NtxMyScKdkuwFVcrHfDe3CfI9YNTvIGBRYsm5ImHTQwXojqRHOOBoH7Kx60+?=
 =?us-ascii?Q?CEwd5NCQh/X+tYlMKvuO2xJUKOJm/kwpa+RrbZivW0WCpWc79HepD8k/NFsT?=
 =?us-ascii?Q?G9+IbO7gQ2/JUrDiei/O7JwzS0xfUTiW74LPsxApXD/KN7wBjb2liZ8XyQxf?=
 =?us-ascii?Q?D64fKHPHpqUMXeYgOwCDTuC4MHkljlLaTJpXcIoof8uHchaRkXgVbqg5my5w?=
 =?us-ascii?Q?WLBper/gmOZhbfyxfXdVdGWPoFf5+/Plva4YmGqDRkZrHwr0ygRLXSobV3yi?=
 =?us-ascii?Q?2+Osl7VrkfqqJmCvNaxuZssbIKKCudPYlGb0Ecwc1db6g/ZdyfYQEwqcGqqr?=
 =?us-ascii?Q?uGo7bHILPNk/6kkBkuX69zJgXGZnym5LWVF303IomsIClqhUZpgptsPPhXfJ?=
 =?us-ascii?Q?DYYPjkq/OY3qadA3Ji8kOdiNKdO/k45300Yu4lF1wD/4gnuGmNrJ1c0CZ78n?=
 =?us-ascii?Q?9UbuO5ZRx07rgpdxsdpl2bf1dLFIkYL5sK/rmDmemLaSraXOzOc6P+Mjn+Th?=
 =?us-ascii?Q?5nIdk07qEwMREwsmARXWBf0UpMoqhPE+UAq78UDbaUIiS9qj4ewcrz73DtEs?=
 =?us-ascii?Q?39HRIE1oZqlfDspwb6U4j4PGSaT+XK6esNvBEaTyma7pJzyV52N3/xcllqhD?=
 =?us-ascii?Q?m4knBycQPmGHok2S6JetIeTTExDOWbCmiCz5gE5qLrSqegMUATs7ph1j1s3g?=
 =?us-ascii?Q?iQ+UVg5aFCcBztxbIoJO08hCYOQ86lNNTwSx7erC+5PbS3lVZm/vKTvsTnEi?=
 =?us-ascii?Q?dxXSpfp6URycWiRtVjUufTKoeBdDBm1Fi3fRUFKoKsuZYqYt/QTfaGbGneJw?=
 =?us-ascii?Q?J4OmNacUcP/jOgmNgbYYqSTrycIZ/wCYYKoGBSLAiDDmosRTlnmVBVUUzBAp?=
 =?us-ascii?Q?j0sMLzITqvO4Uta32ElArqJgye/ycf0i9SVI+QKcbySx9VGKsXexhonskgj7?=
 =?us-ascii?Q?aqxmHjf0kHd4QpSKcf4ddO1wMLBBQtL7gYj8pGeYs9rsh5Uz5awrmK1bXMlb?=
 =?us-ascii?Q?KfnNP7ILkRsPJ5fIBmVAKiJoo94E+6dHIWSpTP+NtZoc8giFcGTjP0G6/mS5?=
 =?us-ascii?Q?6pVoOnyM6fqvsXXEOksAgfOpM0ZUHUsH7L1QJTrFr+hdhk+IqsAKt9h75T21?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6895617b-0de4-49d9-bb2a-08d9dc4f40c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 19:58:39.5875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjvFlzK2HVRHR6bcXlrKj+MJurau1f2XntaJ931lJiFNLwYqmyzweCp+LIPbr2sb0J872bA33UrhSRlPcIpl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2643
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Add back on Lijo and Prike, my mistake they got dropped from CC.

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, January 18, 2022 21:41
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Bjoren Dasse
> <bjoern.daase@gmail.com>
> Subject: [PATCH v4] drm/amd: Warn users about potential s0ix problems
>=20
> On some OEM setups users can configure the BIOS for S3 or S2idle.
> When configured to S3 users can still choose 's2idle' in the kernel by
> using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803 ("drm/amdgpu:
> always reset the asic in suspend (v2)"), the GPU would crash.  Now when
> configured this way, the system should resume but will use more power.
>=20
> As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> potential power consumption issues during their first attempt at
> suspending.
>=20
> Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Add back in CONFIG_SUSPEND check
> v2->v3:
>  * Better direct users how to recover in the bad cases
> v1->v2:
>  * Only show messages in s2idle cases
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4811b0faafd9..2531da6cbec3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,11 +1040,20 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>  {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -		if (adev->flags & AMD_IS_APU)
> -			return pm_suspend_target_state =3D=3D
> PM_SUSPEND_TO_IDLE;
> -	}
> -#endif
> +#if IS_ENABLED(CONFIG_SUSPEND)
> +	if (!(adev->flags & AMD_IS_APU) ||
> +	    pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> +		return false;
> +#else
>  	return false;
> +#endif
> +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +		dev_warn_once(adev->dev,
> +			      "Power consumption will be higher as BIOS has not
> been configured for suspend-to-idle.\n"
> +			      "To use suspend-to-idle change the sleep mode in
> BIOS setup.\n");
> +#if !IS_ENABLED(CONFIG_AMD_PMC)
> +	dev_warn_once(adev->dev,
> +		      "Power consumption will be higher as the kernel has not
> been compiled with CONFIG_AMD_PMC.\n");
> +#endif
> +	return true;
>  }
> --
> 2.25.1
