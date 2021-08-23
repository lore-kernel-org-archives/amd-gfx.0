Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDBAC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 09:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E3561245
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 09:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15E3561245
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5A389A5D;
	Mon, 23 Aug 2021 09:01:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F14589A5D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 09:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDoW5oNva/eB7FIVHcJ5EJ/UTrSV8F21Pl32WnHRmUPBrTRr1clsPn1BjtCKtmK1pP82UzsfLuQFWbJaGekI7OxChW9zGCgSqM6V7jOPiIW2rSwTbp9GPql/bjWoTMYVSeKuAnuE0OAahgED9pfmkv+dSTVPNl82r7Mjt6kIJUlBCp0mddX9b+gX347NZLWbsZcUywk+K7ig3epoRJa3RSW3L+FUWeUEk2iENoI7Jokhjz63KqKKV8uEEw0xSXOZmsXrZODhJefiRZeEE48Kjb3omHkp1zAos2iM3vO5SRHIFXKrW78BenhRAFAvHIcgLJhcXhg+SqRUecyvDguSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyu51DFAEnLQWqM+G4HmADE1GszpX5LtsPFzVBLKOE0=;
 b=SbaB6C1Ok9nI+JiunwoVZeVOuOU9UdnZt1FhDkmbsNTaQq0sncfbLRXFyhyMQZp6WmRqvzJjoG0s/pfIvKFmORc4rxA1Ujkzw0KXfjdVBftjILmZ+m8h58kWszOup491jX7Ob0OB/WbFInNPd2ttzHU9wjIuSpH1+azqiczXxMvGeEhxIXuPHn0/0qjP7xr78BNWfEEBhaSm5XkzzcHE+BZGjkzI2htgyGnxgxcn7eP514SpKarIJormZw45ZYOPzfHQ9dSryb10hIHUT4eXghvUBU87iZisJG6a324U7t5m32Vgs04lOjKyZAnmEacvrWTvtDDzmV0WZtBoT87vTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyu51DFAEnLQWqM+G4HmADE1GszpX5LtsPFzVBLKOE0=;
 b=2UZlAMhuryexw8NROpBu68CT2qgopjQcKfzMNjGw72y9IN+eJ+DpEJdwofKIkQ8dkQ16g7a2qoLYlfHqeql2YMuUT99tft+/BQ4nPt5KLCt9jiCDXu8kTlH5rNINBITD/u9yk4fW66Z+hnOGnOv1x9fejHjd24QzZeV+OzE0wyE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.22; Mon, 23 Aug 2021 09:01:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.024; Mon, 23 Aug 2021
 09:01:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend
Thread-Topic: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend
Thread-Index: AQHXl/nTfsAdsbwRaUSsfrMuyaYSTquAxh2AgAAErbA=
Date: Mon, 23 Aug 2021 09:01:40 +0000
Message-ID: <DM6PR12MB26198F730029B19237536CBAE4C49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210823083505.53711-1-evan.quan@amd.com>
 <DM5PR12MB2469DB6BAEB76ACFBE93EB91F1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469DB6BAEB76ACFBE93EB91F1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-23T09:01:38Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=82ef90e7-b8c6-440f-92a5-45fe5a54629d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f99342-c879-437a-4ca8-08d966149f61
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2892A236E214B6685894CFB1E4C49@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zU7N1+ctqXrp6HFPAtG8h2MXCk9VS54GPsQ9K+CoboPTSquA8urdcESU7WlbdqJrkvUtW8Bvj09fsL0UT4yFRwUWw/0sHTb2ST/6eGsbB1nvH6zYXeDshhY9unLvkWwn0ooS6rbIAJ6jgH62WBgjmYD1aYlQXWA5qLr+YsOG/ZEgBKRHkwwWuJrTi9CwHDcVf4PfGtQRiuUT1lPGcCm4xdeSg6AFXVdgeXUlcLlvWLVZsRHt8ojXe2J9fbwENUyvk9EIwYJK2f1saAaNxTBZpeGv6AUlFoFFmaDM5Xec9ELoaV2FY8RBFrnifqQTtpxclOnxMOVB3eYS+etsxQDLpzkF1/LENUfnaAUsvezuKMsYAtVGfa/OldlnqJMvwNX9xJBvlss8MYQi7nwW5vHop4YSYncHlN7+ZvkqGhn8sLrYaIS6CbMJzdoqCzZcLZUhp/fsj8s0ODRL44ATQZwajfJcd3shxLn3m2wqSt2IwNQZYF36vKNIbHW5gBzKfokrLY6bmyxWkyHR+616B1u9UuPlmGPUH/2T/LIIkJEyrjFWSRppUtgQLE/J+ZuHNldL4IL8j7rNytUuDWLa+kJetXTNyS2uhuSjMrlD/zhkxYmPGdEqCh1kqQ8qV5gIbrn9PVaYZvUwwExc8AvnLkNuIrpMEdT0PyxTvu5hnovQ1vxNmurbExrfo2LXYm5dERtezckEzX/ewbIvEwYrceKPoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66476007)(71200400001)(8676002)(76116006)(110136005)(38070700005)(316002)(54906003)(2906002)(66556008)(66946007)(15650500001)(9686003)(5660300002)(83380400001)(33656002)(4326008)(122000001)(26005)(186003)(38100700002)(55016002)(7696005)(86362001)(53546011)(8936002)(508600001)(6506007)(52536014)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gK7nDq2FiBAV9JjmNeLkLIrLcUTX2w3bENyujJ9HhBUDYaudeOccwykrfqxh?=
 =?us-ascii?Q?mIamqpyyfNAm6Q6Y8buaSWGiR67K1cQw4aHCnLEaD3n1V5Z7mjCg1p+Bzz0J?=
 =?us-ascii?Q?J/esVXQOcc8ahIbi8Pm9RALfgIAGrzQ7yBk/6lMRjJ4bQVYppxwpLN7pUXk1?=
 =?us-ascii?Q?4S6Z5XLP2EE133xN7g5i+fnXjlvzUbzHICysXrjb0KR0CkxEDNpT0ckgQ2T/?=
 =?us-ascii?Q?4HjsnFULvcaJ+qjXYG7RaItlGudPf6UE2DQrMojs+ROpRXzyHKWTy+m+m2GL?=
 =?us-ascii?Q?cueVgIAi9xXzxglhI+tfWXr/yNu1zo4IRngYC4krcVjpQxdF5YUm+QLMXInA?=
 =?us-ascii?Q?0fof21ZGg+4qICHcl+rRp3bMsGHjlMJJrfgyqY/P5BQ4bB210qAu4wQvgD8X?=
 =?us-ascii?Q?D2FCIbSzhFh1+A9UiJftKxU1j1t1iW7gqshGWjD/LNBC6gySmjSApv78jS1J?=
 =?us-ascii?Q?DhXG3rNZfIfgNr+Hhe7x+puHOpj+5IIfz3otChalLvrfd+lfj8KLfruSN/ci?=
 =?us-ascii?Q?BBKgwK+jNMMBKs4vQi6QuznXhHOnBRwnbSRI1dMmb4xBqzb2jfbufU3rK4sH?=
 =?us-ascii?Q?h11F5FsV7md61jzYTQIzpRJVrPBfi/8vmtbeTuNgdbGm25oZT6p5GkhbxCkI?=
 =?us-ascii?Q?ZoYo2BeZXcGgM1ZrPDBb0siDCGODZl56sLjJbCD7kvgOvgZPi/vA9ljnxrGW?=
 =?us-ascii?Q?kL2Zg67Asgk/cjRBlQiDNm4A3c3QWxZmMWaXoRUWoGe8drk+ssF8ulHBUNZv?=
 =?us-ascii?Q?b7xP8yQch2Pd+vr1TR1HXstNJE8moLDZMx2VhIAwrOT1tTv2i/3ZnpsJ99Lj?=
 =?us-ascii?Q?TtP3PDPdbr3yZj0/qQWExQya2UtvQTu5G+21YeX/VfwQwdosaJE4KRCYITKK?=
 =?us-ascii?Q?uFznbMMqUom2S1KbCihw5uiE/aEXjCkOpUZxptNM7AbiLD++YwFc1fFW5b5M?=
 =?us-ascii?Q?mKGsuV8gNdRwZrwOaPwa/Lq9lIokQMpqazmevycrdD4AAd404F1BfhJs78xI?=
 =?us-ascii?Q?r7Qvy2PYI5EPtmvc0kFdJS0hlm56ifrpBy8QQUYB5uo0y5z7Lj68rUcjZJwT?=
 =?us-ascii?Q?wm2XHZxCfX29+OmPssABIS5HkdgwKX6/oZeN2ruhUbaxmlBgChCijhV96M50?=
 =?us-ascii?Q?jXYLRQUtQ2rqLISa2D2aXo0V8uGDBA55ChYJ0F414XJmygZePhjFBfOJPm9x?=
 =?us-ascii?Q?ydW4tuCLq3w9WCeso1JXEefabueS3FP0eM8K7FiLpfTluwxdNziFkDHER8VJ?=
 =?us-ascii?Q?zyrltkyIn1K2gaCPz7we1skJdsXxo4qY0blSn1UYONniXKjG0X0f4RjpMP95?=
 =?us-ascii?Q?4+DwZfrJhSl3OLTF4ENfSQ7l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f99342-c879-437a-4ca8-08d966149f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 09:01:40.6900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SINpiIaS+5PRpnVj/scUIG6wiUB4JDehFm+ANk1LYltXcqkOmtFdQtZs/q8QTSGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, August 23, 2021 4:44 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Zhu, James <James.Zhu@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Subject: RE: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend
>=20
> [Public]
>=20
> Series is:
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>=20
> As we have rooted cause this issue, shall we revert former patch
> "drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU temporarily"?
[Quan, Evan] Yes, I will do that after those patches landed.

Thanks,
Evan
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, August 23, 2021 4:35 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, James
> <James.Zhu@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Subject: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12
> UVD/VCE on suspend
>=20
> Perform proper cleanups on UVD/VCE suspend: powergate enablement,
> clockgating enablement and dpm disablement. This can fix some hangs
> observed on suspending when UVD/VCE still using(e.g. issue "pm-suspend"
> when video is still playing).
>=20
> Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> --
> v1->v2:
>   - move the changes to ->hw_fini() (James Zhu)
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24
> ++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> | 23 +++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 4eebf973a065..c238aa2014fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -543,6 +543,30 @@ static int uvd_v6_0_hw_fini(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> +	/*
> +	 * Proper cleanups before halting the HW engine:
> +	 *   - cancel the delayed idle work
> +	 *   - enable powergating
> +	 *   - enable clockgating
> +	 *   - disable dpm
> +	 *
> +	 * TODO: to align with the VCN implementation, move the
> +	 * jobs for clockgating/powergating/dpm setting to
> +	 * ->set_powergating_state().
> +	 */
> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +	if (adev->pm.dpm_enabled) {
> +		amdgpu_dpm_enable_uvd(adev, false);
> +	} else {
> +		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +		/* shutdown the UVD block */
> +		amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> +						       AMD_PG_STATE_GATE);
> +		amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> +						       AMD_CG_STATE_GATE);
> +	}
> +
>  	if (RREG32(mmUVD_STATUS) !=3D 0)
>  		uvd_v6_0_stop(adev);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 6d9108fa22e0..e99877c13d5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -490,6 +490,29 @@ static int vce_v3_0_hw_fini(void *handle)
>  	int r;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> +	/*
> +	 * Proper cleanups before halting the HW engine:
> +	 *   - cancel the delayed idle work
> +	 *   - enable powergating
> +	 *   - enable clockgating
> +	 *   - disable dpm
> +	 *
> +	 * TODO: to align with the VCN implementation, move the
> +	 * jobs for clockgating/powergating/dpm setting to
> +	 * ->set_powergating_state().
> +	 */
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +	if (adev->pm.dpm_enabled) {
> +		amdgpu_dpm_enable_vce(adev, false);
> +	} else {
> +		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +		amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_PG_STATE_GATE);
> +		amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_CG_STATE_GATE);
> +	}
> +
>  	r =3D vce_v3_0_wait_for_idle(handle);
>  	if (r)
>  		return r;
> --
> 2.29.0
