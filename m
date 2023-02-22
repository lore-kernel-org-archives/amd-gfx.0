Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F87C636D7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 01:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA5B10E1A1;
	Wed, 22 Feb 2023 01:15:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D236410E1A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 01:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Atbb9cIgoI4lTtSWvsBcg9kBJUdfAnW3Ei/9QVtt3eyOjwCKHj9wRABnGsYMDRHjtrO0LbrF2VX7DjH6MY4ZhaTi8T0AuszcLdNfVyKQ7MdAYL0zyprNEHFklTiQIZiRdpkL16+1IjobfLh3iNfdGQ4iCTB5tYocx9T63KXMBhMFwZwfURV7L977e/s+i1/cvdfwiaDjGWwWk2n6Hb7FEc2aafvLgJs8OJ7kEmW4zYm0ldMMy9cgZPrV3aJF2LRf6S55vu8tUfF5gycdZ0BhZhpkKWpgiueQrEYV6aINPTPQmD4zKxMZ5f7nYb2A89QlP1k7vc7vm3TEoNRrn424+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQXsgLYhZKYTtlfoR/ObVeaY/tS6N4TFBKAtASc9NCg=;
 b=QUPO6l8uzifwEN+t0x/C8AcPODKXmCJqdRipO07Idlq8tl+9YdJBLkqRvveNN8hkZj98dh8gYRKcc5jOjn+eOMo+cP49/Jnj0Zbknf/AMCjJZm29H0ow5zf80usOqhiSp0bknE37BgTu6D0U0aCXPIUiEfmQC8gnPwBgLaw5x8g++l6MdQgnzKasg4dR3DU33NEbk8/xc6OlMsXHcUe40N63eYVu9SslSQPZvjMut3QwY5wCPx6mTfET8s8xDNsc1Bca2Att6q3G+tj16lARazwg2zhllWfBMa4IyaVqkryz65dueDxWHLOq2X/7ojrS5roWwPJh/fgzE8JMKzYsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQXsgLYhZKYTtlfoR/ObVeaY/tS6N4TFBKAtASc9NCg=;
 b=1KYmmF2dqZ5VMr5mE0onSr/0MA9z3WdhgXiQPUX0e/itJUJggEZiMFUsiiRbPh9dvg0t0D9PnQEtgjt32/28e938Py87ocAeHOGELa/mOx9KdYtOTsD83bBtKhx1rwqkthLKYiZWc+GBJ34c5a46P51sHKxUl9NbiZj3MLjneoQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Wed, 22 Feb 2023 01:15:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 01:15:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
Thread-Topic: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
Thread-Index: AQHZRWhKZtUJPPBlH0SNdWHff4jNdK7aKLoA
Date: Wed, 22 Feb 2023 01:15:07 +0000
Message-ID: <DM6PR12MB2619AD667EF8B7AF7F83AFA0E4AA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-4-mario.limonciello@amd.com>
In-Reply-To: <20230220201618.25962-4-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-22T01:15:03Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=264e057d-e0fb-4b22-9976-505fd1fc1894;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH2PR12MB4279:EE_
x-ms-office365-filtering-correlation-id: 49407890-f7e2-460c-5966-08db14723c2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVN26ZTTwu22RZNuqvf25vW7Zvuc7msF1k6FJYl23MESVHM2B7/szEebT2EEYFtuxcwXD8KFBLgaViAp+/Nug0oVYFnmoeGQnmlk+L+o/A9UPrAnJ2q+VHhEsF3SDUlSuKdSTEUouSPYqnTJV+7stg77gvbJtnJBB56rwHnZuGRHyR8jqoReTwpy6P9UkG0MWpSYYcSjaD/bleZzFYdIpvNkKC37sY6MBaTghiZaY2nt+e4iDsQI+Ck2bC9jFNNulVhbLR2QtAoUf8cIZcTMxNt4gAw9WUqiXSUqIpv795/pzwt3vtq6TkW2PBMM6K1Q3SYUEOxYF60HViCQD652b9CpnE/b4nl18KGh+kjSMdnDRjDd8oa4cH8LaWdBozvC8c/eNXw7X8e1vPukJ3seKArpbghgQ8vy94nZwqb//249mFjlUyPISFjgyp+R/aV8g6VGH35RVAoCgmvtrnGEahLfp0aZ+nNxBSdS0Q7f3KJpkJCmBFFaE6kWlPsHTILTu0RBvHwzJqYFPAzo7bbk8KwlsYNgiNwfMdu2deTnltGSsg9VxmKXmHJoNTOEtSkZ/WVfTa8jHlc5ohMNxiDOF3GGDLKdMu2ENmGsa0yzTaT541hvKaNPIWw5X+pN9WWwsL4NUzYBg+heFZF/nLauyAEYe/a+tj7uIjjKD+4QDpUThrYdnn+29H8ta0uRusBo2lSvvNp0rGPgCMjUkMpOFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199018)(8936002)(38070700005)(33656002)(86362001)(41300700001)(52536014)(5660300002)(2906002)(83380400001)(38100700002)(122000001)(71200400001)(64756008)(66476007)(478600001)(66556008)(76116006)(7696005)(66446008)(8676002)(110136005)(66946007)(54906003)(186003)(316002)(53546011)(26005)(9686003)(4326008)(55016003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P1kREOPZXK6aMjtdZlydBj2EpfNVFQIUUz7bQjz9/T/E28F5iPZSzPmq91Qt?=
 =?us-ascii?Q?q07KFC14Bls9t9yOPDEbdN90GYW8ODzNjw+s3ehRV/x1X47ft+zcabBAyf02?=
 =?us-ascii?Q?iCFOGcIjSZm5K4oE8Wy6z8N8r/rdwZlgGbyazLcRJjfueLD2PPvslrY/82n9?=
 =?us-ascii?Q?b2ghQw78osgVuCkpxnUR4cpVSe0CPzQl7Y9VlYfVyAuEzeTKpZLeirEgTN48?=
 =?us-ascii?Q?O/qWEh6/suhxbe93nAQ/nfrRskzxJCH1ISZI38+LfMwyKODFKJTTtVzDzAEi?=
 =?us-ascii?Q?KzmZ7y9r/hgmy1S2Znhd2n/gJPeCWy1PvI7wmt9iU6MDOLoSY40p5CwxKyj/?=
 =?us-ascii?Q?rx3LePzRSV4woZX/Pf+zYl0VqsGmjMLFjHteVFxeg4ZPjb+PsQpYS9yaantW?=
 =?us-ascii?Q?VRx6T4hwiyEYQYJDTgIO5pi8Vhzzd+hG6d8xX5JmDYYB1HBHJG7EgW0alYtT?=
 =?us-ascii?Q?TmRZvpDLeWDNvZVTtzmQfxLYG7xZpct30uqyTkkVKXiOTEKzFG+2a831XTqD?=
 =?us-ascii?Q?lw36RVHwXrtGBVUxnhoJcnYKbcgp28DmEPyY99fC1ZPMvube0SrJqlubyMOt?=
 =?us-ascii?Q?G2AWwhuK1En+RuCNX7F6wR5aFXnzT+nJwl25rPg3O5LgJnKH4S8iPP1KqkHj?=
 =?us-ascii?Q?ZPg+9f+a21RnVuvIWBJzLRkOeCDg2JQnZlva/nRR0OUQisxNmu9U9mzGHI1x?=
 =?us-ascii?Q?ZYl0vk6lb1tYZvnCiloDVTIyuGlEIQ4m05L79xqwTg0bUV7B+2BvxlvBgkze?=
 =?us-ascii?Q?NpwklENhnQt17iB4vf07BCp9Vc8k4yVqAy0HMQYuL5SKdzZfF+1bCdIyrjVt?=
 =?us-ascii?Q?OAvxOdiH4XwmFYVEj/ATpiVkAqIIzVJ6NTIlvRwCh0CzefaoHzoi4c/P8nWs?=
 =?us-ascii?Q?lhP1V4+lh45d4ViLTodJIdQHdyFuwfl1j2SzDzIjpjYvhiaj2BqILT/a3Zel?=
 =?us-ascii?Q?F3ToUlXgvTg3OQJBJj992JfyA+aVOp9JtPu0jUhUHZZDbi4rQbx4RgmeG8IU?=
 =?us-ascii?Q?/6maqb5SqVSH4X/NJhiiBTrqm6khhFCuUhnZqZuC5WRhJoqpIXiznD2bK4Ax?=
 =?us-ascii?Q?kgvmR+GzFfMMccjE+o6L5rFREV1L8F4sD8QX85NtsrZM5B4OQLsD2/LijuGX?=
 =?us-ascii?Q?KQYF6MNACDFFcDG9vySdAU6Sw+M4HK0tqHgn7iGqmz2OI0U9mpHAl7eJTRiK?=
 =?us-ascii?Q?pylTQhVuTHDeJ4fXSzJUlOsyCZem1zCq3sG1YLKHKL8jMAH0joFOZ3hbvGBM?=
 =?us-ascii?Q?kX4fsSNut71kMfs8Zc+w3PGh2M6DfC17/0QDEJVMXsAK7dQWFNE7bcpi8SBF?=
 =?us-ascii?Q?CuSbG5MXiuVccT87Fga3eJCnZ9y9a9XVFZ74Lm47F/HXaQrrQSclf5xfXjzM?=
 =?us-ascii?Q?nmmIsxcovqg26BYkkE+FzlHzEZd4DG4ZilNsYzKhTqj8SvglRlt9AY6fb39I?=
 =?us-ascii?Q?YiOWo5ASSv4RG7U6zTG5Qp9sDwhrgNcD4mKe/1OBelxKs1m8TFqLBvWjY6Uy?=
 =?us-ascii?Q?kp79TQ7g0bBq9CckrknriK8gaNxoJ2nFguw+3IZ961H2d7OP5XhncAGAZ73N?=
 =?us-ascii?Q?nm8RHyk5/ixq40hruSY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49407890-f7e2-460c-5966-08db14723c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 01:15:07.1136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bpw174QvqevR7tznPOQy66F+x3bQvLo/ObGUtJuxN529oneUJ1HQn9kz/ifHs4tI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: Peter Kopec <pekopec@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Tuesday, February 21, 2023 4:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Peter Kopec <pekopec@redhat.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
> modes
>=20
> dGPUs that will be using BACO or BOCO shouldn't be put into S3
> when the system is being put into s2idle.
Will this break regular suspend to ram scenario? I mean
- For s2idle scenario, amdgpu_pmops_prepare will be called. And for this sc=
enario, it is expected dgpu using BACO or BOCO to be not put into S3. Right=
?
- For regular s2ram scenario, amdgpu_pmops_prepare will also get called. Th=
en dgpu using BACO or BOCO will be not put into S3 either?

BR
Evan
>=20
> Cc: Peter Kopec <pekopec@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 25e902077caf..5c69116bc883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1038,8 +1038,13 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>  {
> -	return !(adev->flags & AMD_IS_APU) ||
> -		(pm_suspend_target_state =3D=3D PM_SUSPEND_MEM);
> +	if (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM)
> +		return true;
> +	if (adev->flags & AMD_IS_APU)
> +		return false;
> +	return !amdgpu_device_supports_baco(&adev->ddev) &&
> +		!amdgpu_device_supports_boco(&adev->ddev);
> +
>  }
>=20
>  /**
> --
> 2.34.1
