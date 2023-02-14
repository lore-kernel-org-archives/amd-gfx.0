Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B93C636D4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 02:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97ADD10E09F;
	Tue, 14 Feb 2023 02:54:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B245F10E09F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 02:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edXkpTZ+wq1gTfZfwNo7NsPHMajVYsU0vz06Wu5i1dqyQz01+5qPLCzFnBUYdb1Palzz8JkDvHDtigMDfsF7Ap7mlWhI7jEu7w6DcP0RRaG8V34oKMn5v4PZSthVho6geWbODYjTdBGUmcpO6ikAL+g3SPSK7A8nRUS8+z/C4QDvrrcdQFAsxYnTNswQyVPjsdp/WXXKiEpqRfcpzRKizN6pbbHxcO7X9LWc+Busnpv05s0TH+Vg/OSzOv+uJgZtUdY2mx2+ECqkLpB0qZUL1UknBRX3Pt8NDFB8HNoyVmgjrk2uYEu48Rr/UKJPPRKiPXRaycWE6VptF16JXo9NjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KACXN6Ab7uUj6J1oK0qRWCOpuHaDkC7wC+/ww3ofjKs=;
 b=RFjluUJ23G8YgwSFnhYJipzri2+HIDjYMtOsyW3dq9Qpr7H3mM4lOCkBeJQS7/SogkK5QH/eP29DBSnAr+OQaxCqRO7dKXsVrRJhtYVzCNGhNkG5t5Z2ZCLtwD+Ya+re3Yr7U8ViQMO5dvFuZ8eYXZBnI3Y1//Aml3OYn1t26Boip5PFv0njmtzrv37/MYR4hbebIeK4Jjot0AKecyrxyVCGsuRNJdXdBxTwTdXkeWPXZCk4PSAm9ApuY1wu1IVayCYckzYgBi3v0Lk2UVtRQEr1GC24F0lFs2YwD/JncwIvN5iuj6oZZXkemvwH6ra0yrdH/ogNaMW22sOE3uPmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KACXN6Ab7uUj6J1oK0qRWCOpuHaDkC7wC+/ww3ofjKs=;
 b=1faJ7utp2hku/Q7Q3BaZzAlI++eZA5PH6Kx+9Uqqj3Nmpp9d7+803fd0jxGlC6o2g9tQhI1+8HkzfcP516c4fNmYAioTBeMw5KkMv3qnHb2FJ/tRTAG6Wpc+96oZ3CsWFnj7VsyhTq8CWMAxkbqmSA8dJaaVuagQbMrQybzlMNk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 02:54:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 02:54:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix warining during suspend
Thread-Topic: [PATCH] drm/amd/amdgpu: fix warining during suspend
Thread-Index: AQHZP5olcDDVSeHi+kCCGGLSM9BtEK7Nv9DQ
Date: Tue, 14 Feb 2023 02:54:19 +0000
Message-ID: <DM6PR12MB26197D4117372BDA567CB88BE4A29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230213105224.55662-1-Jack.Xiao@amd.com>
In-Reply-To: <20230213105224.55662-1-Jack.Xiao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T02:54:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b1e0887d-574e-4829-bf38-d97417010983;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SJ0PR12MB5408:EE_
x-ms-office365-filtering-correlation-id: 37d06be5-a4b9-4582-571c-08db0e36c4ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JriVcYCo8YW1AM9ZtLfpY8TFJ31Qdx1Zb/gQvE1yEyq0DXXMCv+IC/7zkemuUaTTFs47vIBE+qRj78fMwMXbKpRD9w8kRb3gZPktN7OriphvSimFteR50nLy9bmEO4LFdpNhB0zcmCaX18+BgUmPBqMiMQd2WpD0rTNpXgaLqOO5mYSm1Y6f33YdasSNHX3eLQtkdxn995rDEYRinZA6C3yNEKZjYD5VyHVBlCPeZoL4b8++7zHr53SGdU+0DLKN+0V1fOCBQCaOr6XdXSqybuds49LDzNZMrerwqnIRgves9AalU9pzhQs+qLcuj0gPAFCqAX6uZDFRnRkquDNLqfvtpYSKFNr17JLJHsRctnCJDzfD2KknZNcowPtgpF8wcayiKwodaJlFFPlr0gqq/De3/iViFNPLoD1seZQdKQSSc0U03/rfQrk291/4oe6p90up7rlQG7A38mprUuJ3jSbrSJhcuB2ryYxz9orBQwAH9fUOxKtqsVM4CX1YMBh8j7IDUiFarQaqCzlnSTSbY/PVSMuGqotpN7BmgnVLhILVPbYWVU6bFOEHIHcVoMqx3iJNn1yTBU8TK0VyDwyzHI0mGskRoHhFGfn1wf/AeSzlfBSRXwZalDT44+5dXuAh9G1YyjYk7YerpvRi1GiFASK6PLO9GL4ZRSbPOxiqI9pEaJxOqwWG4erw1zu2aLsb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(54906003)(41300700001)(110136005)(38100700002)(55016003)(38070700005)(186003)(52536014)(8936002)(9686003)(33656002)(478600001)(71200400001)(2906002)(66556008)(6506007)(86362001)(26005)(966005)(15650500001)(7696005)(53546011)(5660300002)(76116006)(66446008)(64756008)(66476007)(66946007)(8676002)(4326008)(83380400001)(122000001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AGgFClNQOB8hh4VwoqURpfs+b9uU2+y0ea1kl/+H7ldwwwtDhVPm8FbAgViq?=
 =?us-ascii?Q?mU0f5K+wmS/iRWG2jJ+nn9VpgOdhc/yIZweeHYfeojDjKp8hT7MnB79kbhrj?=
 =?us-ascii?Q?ndTAtvu3hjtoIMGERthSnj1TuRlvp97OLqH4jVCGVKFVYFGDJq5aG2JyPeh4?=
 =?us-ascii?Q?upy1PmFcj4AuLZ1NmsuIfSHlQX8mMhG9GbP+a3of3XlQYZDMdh6eQlNbt6jU?=
 =?us-ascii?Q?QX9TNALlZOU6BMI1oN7j/r1dH5MF2DIsDzkYanMNupV32bzjOi0a3S/5+C45?=
 =?us-ascii?Q?cUdsJpZPsPHiuAO5cyVm7DakEf3jpFg8Dz3pKZJKFWa8Sk8muM3Rgwz70ESS?=
 =?us-ascii?Q?DT+kiopqosSTaK6gssTzOzjiHPGGA9acqT4jfaD/vMQhMWaopvckGdoP/Mtp?=
 =?us-ascii?Q?IwHwABJvHhPO3yyXnwg3Q1FYl3v4QjH/vAM6NJQreCJvPKzWVSFveZZmy/lE?=
 =?us-ascii?Q?2vhpW298UZua/A+jqAqOyptYoE6joev4BtIyPojrjmo1X+hmqOeQt3qIm+Id?=
 =?us-ascii?Q?Vxt5qT44G+ip3Unv2MEp7+RAOOnZiPJrS/7qglphq1MyrccYzz+aCFeAEldo?=
 =?us-ascii?Q?85JOoMXR4HRXy+YKFVo+p876jTM7EmWLnpwkV8OJ9C2SlZDdcQIH+TJkFheC?=
 =?us-ascii?Q?WvM3MXRsyHTCsKb2juR1vqDTskqsvFgwMuCeP7DkfQEwgJ/6BnmYU/2h+Nm3?=
 =?us-ascii?Q?7GBTPzAFpVhki3nOi3aMuxfwbnK7yJEEGMHkilW2rLHsM19C6vpTGFNYXtf0?=
 =?us-ascii?Q?TlLGz3Sr0NQ04iSCDIxe2aMsiP9bWZlnajOd46thZ/80+fUVw/PbM23v3mPJ?=
 =?us-ascii?Q?mE1ADpV0Qo7M/kjJmeW5W0wZ/MGdiK/zPnX6aviEQIY/dgBdrFgs5ar41UJq?=
 =?us-ascii?Q?vpUr1JOX4PByTVXCOpaRpDVl2trxS4MCITtv/TN6CqJXnzNTKb/ATRlUl6iL?=
 =?us-ascii?Q?m9XTSI7itEwtFrDm4FXSj0IiMmRIfrzAnWtjPLQjdNlusblnU9HK5HLSYovq?=
 =?us-ascii?Q?elZjyie8UB5CVWb2JO3ZgmY/lSjYnqGaDR9JCFe1PpKweHDOU+OH6xA3GVv+?=
 =?us-ascii?Q?R7QVxDxv1HEJgPEbv9A6suhyHF+IK4Vsz8L3XBc9eTk3QDJnr3N+D6x5cvuP?=
 =?us-ascii?Q?xqwlIEdLT9VEHJCt1qbENVDLwFFc3QtQT9QzVnt4tAWhEl5+dfnh6JZdZUya?=
 =?us-ascii?Q?J5/DhbInrDdwj0DjgJm2295jbxLuQyk5esjzkDGPI69FXdH4F6iOO5+WuXWs?=
 =?us-ascii?Q?MKmtvVxQgVUDncNsnTDYGPwxL7bHo2mppiOzkhkZfwabUbUbkM5igEIFZ5Ue?=
 =?us-ascii?Q?e3ncXYxxGNDC89qnOjv5ov/roJj3qpG0qGD4sgB49nlFJPw+yvKJgyC5d+au?=
 =?us-ascii?Q?WWOCoRsD8vnZEvRXI5UFE0m4Wc+QUQxRzSUYwSQNOUe8p5e+UWUaxFzHm9Qh?=
 =?us-ascii?Q?ndTtJFsf0gumtIFB9Fzsk9g1U07WvO1wj9Axh0asoY/bpj+JLXTV+I+IMIdR?=
 =?us-ascii?Q?b2LtkJiTsKmqj8pRtysetstrUewWK4W16CUlbjbORYVIvT817Kq1l3vFruiG?=
 =?us-ascii?Q?YMhnQAlWYA0De7s3Aic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d06be5-a4b9-4582-571c-08db0e36c4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 02:54:19.5206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2KqT2T5q7i5VEKWV/NlibSHU9Q2pZu+NbmjpZ1oCOD5ZCC13IzRonsH6USykthZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>,
 "jfalempe@redhat.com" <jfalempe@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-and-tested-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack
> Xiao
> Sent: Monday, February 13, 2023 6:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xiao, Jack <Jack.Xiao@amd.com>; jfalempe@redhat.com
> Subject: [PATCH] drm/amd/amdgpu: fix warining during suspend
>=20
> Freeing memory was warned during suspend.
> Move the self test out of suspend.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2151825
> Cc: jfalempe@redhat.com
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a10b627c8357..3842e7e62eda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4270,6 +4270,9 @@ int amdgpu_device_resume(struct drm_device
> *dev, bool fbcon)
>  	}
>  	adev->in_suspend =3D false;
>=20
> +	if (adev->enable_mes)
> +		amdgpu_mes_self_test(adev);
> +
>  	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
>  		DRM_WARN("smart shift update failed\n");
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 62cdd2113135..5826eac270d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1284,7 +1284,7 @@ static int mes_v11_0_late_init(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	/* it's only intended for use in mes_self_test case, not for s0ix and
> reset */
> -	if (!amdgpu_in_reset(adev) && !adev->in_s0ix &&
> +	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev-
> >in_suspend &&
>  	    (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(11, 0, 3)))
>  		amdgpu_mes_self_test(adev);
>=20
> --
> 2.37.3
