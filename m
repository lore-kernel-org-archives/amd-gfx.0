Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 14:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DBB6EE49;
	Thu,  2 Dec 2021 14:16:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59BCE6EE49
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 14:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt8sWGeFs2mjcCKpyFR8/9v9rJwj7m6ziTqc0EJxfqHYcHu/OQWslXS5yd9hHHxAmK+t7abrBn45WOjpl8zbhvGiCOidgJo+WgelCmlIF/sqWNoZdl5C3zbBLDBrP3hrHsHB2oxbpmqCNm1r6hJR3LikVA0TVSIm3aDKhsrPrVVBR7QMPJl+Y3yMZpRP+olw/XY2FyHWx6hqkV/Sd1g0nEzM9XV8hHmW03bqvLch8wCD2fUCbU0Nmm5WHD24oYZ3yPzltU5LcUQfre8euiCAOVxkhUxPtcd14Y/NLHNOvgtgGpMZR0vF5ic76zzmsEG3D3Gq9WLPcEPPUklfKGP+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a43cbFTHqU4P19dIj5gKB+SC0gp3ZOjAcvZxB4HhO78=;
 b=IEW4pKKwo9hlSpihwvztn+8ZHob2jjuIZR1MuZ3eZvw21nYQvGQv8wNMzQiO0eMF6Jl1nol9iM3fEcjHvUxkUbsso1Ils+ZfktTnwzpUPFUSWbe+1uX6swJP92vV8AaeQvLlZppr3hYGJveyKXRb5l3Y3W8JzwkmuGk166xN51YnqBSWCJXhxxtoG6Nj85bABYKMRMfdx++ME6OWFqpFvJQrhrfG9effVp8U2RmdYkSmnl604EkkreOeG2/wIeKEDwtFCcEFX+9JjVaYHobkbQsQDa0dZLlCZko/OoG5owCR1cwmfwBNNLNllxhOJW2sOzsneu06BbZUvxnbBr3SVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a43cbFTHqU4P19dIj5gKB+SC0gp3ZOjAcvZxB4HhO78=;
 b=JxJbKS6PBr2OSXPbc9Nh3d79ggGveMYRAwAjdtwn2Ot96QwemdzrNfSlseudt1BhVvixbTtjfCDBI9vsP+Uaf+o+5SoGRU9wLOh0U2H3IqBsTt+d2vgOy9Rd22QOtntTDyQOlZWJbZ2S5GLmwG3Zm/PbKbu4W6ZDhuZf2nLoWSg=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:16:20 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::cc36:3d1a:7e4f:154b]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::cc36:3d1a:7e4f:154b%7]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 14:16:20 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Correct the value of the no_atomic_fw_version
 variable
Thread-Topic: [PATCH] drm/amdkfd: Correct the value of the
 no_atomic_fw_version variable
Thread-Index: AQHX51p4meA6POIaP0G2JGVEO96cMawfPylQ
Date: Thu, 2 Dec 2021 14:16:19 +0000
Message-ID: <DM6PR12MB3067F460291C1BB66587A1788A699@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <1638435371-30851-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1638435371-30851-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-02T14:16:18Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b089b829-5eb6-4eb4-b918-efcaa0d7df2c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-02T14:16:18Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 5e406a67-9b55-4672-95da-38a4fca7a202
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cf25f91-ef12-4a65-a120-08d9b59e4ffb
x-ms-traffictypediagnostic: DM5PR1201MB0009:
x-microsoft-antispam-prvs: <DM5PR1201MB000913980000649948450FF58A699@DM5PR1201MB0009.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umLyyLPzr6mwAC5gllGuF4CLA+JOc3f0vMJfi5C1ksjU6W8hzHue2e7QmpECxBQJ0ykI/SedUQCKmlFrMVxVZxrhh7VxfJ+Urs6slam4ExjR8fjvphb5zIijSMfZniiGd2SbIGPnPnPV3qUDOo0uPiciqU2sCyFN3pyY8yPPIoh0GWhmTYbMuZ2FpN2ctEIaz6t4Qa7O7x3b15adoyqs1ZrJc8ZhNs3Wm1wAZj9RRaF1hnNR6nVvXa67OtBsSWYaJrO+MCSNYg+SNXPKDgXM51vuMjvPTB635XBxvMAGPBW+vt72R7GRNaBVXjGOlB00SrGrodAjK0GztjeKhJfZLzmbqvVBE57F+RRttV8k1zVyZM+aqdPrN+G7Pj220pncmVzdM3w7oUa3lHxkbua2Mx+ACCaE0eXysdPIK6p0wDhkMvAL3QPI1QI0JvIrLusLL18J3kS8oYjRPyT+j+VTyZWqIfAHdxPXQK9mVoebrFPXT+YNsTtBjCUsugcCMKEXwzzJCOT15rL2Msy26GiU+AopFr02nElsGO5QbqR+FoN+AVFth75VGD1cZ1+lgLR0HCKfQlIdfBL7kGLS8hbrjBMzifUC6c4OtiSKV1NZGnOrAo2KEO31BtZ3Nn9wZBLLDMUo6tsutXNL8yj7S+xEGM1ZK8tKaqkWX3ZlVW2yQQUKl3Ily6qcNBti0jpjzd86iMOtoclNaXUD4w+hAW2QsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(38100700002)(122000001)(110136005)(66556008)(66446008)(66476007)(53546011)(4326008)(64756008)(55016003)(83380400001)(9686003)(2906002)(316002)(66946007)(52536014)(8936002)(8676002)(26005)(6506007)(508600001)(33656002)(186003)(76116006)(71200400001)(38070700005)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BpeInyELxhWWGF1W6M1Iwm64rE6ja7sHouw0FUbK4AeIu8FulRynGiO1BmIB?=
 =?us-ascii?Q?0tdTDB5I7T9N309yqjMeTo7Ex9312KduWy3n4G+ilHEByDOvdDXukJWTfhL1?=
 =?us-ascii?Q?xHsw9SZS4qAblVucnSAWRz2FxCnRxFUwF8nFiSLd8RrziPwPIwhNltZUDBa/?=
 =?us-ascii?Q?wmmNpIYzWDED0b5tvY/RjXaTvk2W1eob8UcmX4NdrVMI+ZRmI5ZRlVh4AJTp?=
 =?us-ascii?Q?LoFGsgznXU41ga0/f9V4+KUYCaqB29BJUFPzYn0FXHO1Dr+b01pKK7lQg0ah?=
 =?us-ascii?Q?pt0e61V/dHqOHbKSwTzqujumu1efnHAOu4hahb7R+kKMoHGNWogf2PWWQ33y?=
 =?us-ascii?Q?0eKvcjcbsj++OA8yZekY5mIgBkO1kVPMcmbutXKOxmAvNy4gEqvmxHRHJn0q?=
 =?us-ascii?Q?1MZ8Xv64eLtjO2p8f3EiwQjR2Z6lnhvdXF+oqYrIbEy6OJpmNqSI64gA7wRb?=
 =?us-ascii?Q?QD3mCDXclZ/dy4IwwnFwFyEaeiQ7EoHEenV6+Zq/ACa1ZoITHXknE4I7utOb?=
 =?us-ascii?Q?omFlaEGHveyM7JQiSHHaDriRIjbkazgGo0A08+TaDpaSaQmejRvPjEX4zTYo?=
 =?us-ascii?Q?AdIN6gOUuGPovGiA7spatenqHz661cpYLVjd+Qa+yC5/K/DfRpnfgXv3M77E?=
 =?us-ascii?Q?hykXIbzYsXZcE3vrlJBNYTSMBeKElf6ni0/O+DJh/rOF3wNAWiQtsoQWDtIE?=
 =?us-ascii?Q?Bvam1H/MlbmU4tpcFksng8DaPbe5uYcYwea+sE+wFYTpPj18jdi7Tywen05i?=
 =?us-ascii?Q?4FNXPu1rehUasURPNtJoCI1knENp0kIMhTohBtkgPNHbHqDQMUQU7O/S3tUD?=
 =?us-ascii?Q?C5n3A/20DtN1Tm2ePVkJTHv5/TgrfdT91EMOuzJLJBbGYgjPpLDcK1W0uecL?=
 =?us-ascii?Q?gYSdeUhXFclNkceRYwjWVRJhyvnXvflMwAUMlfIaixx0efBGYwHIfoZ964gH?=
 =?us-ascii?Q?EA0gcsMkUjz7IDH2sMH8PvbtjAoPKV5T3wpjWHIz0Avbrmd4yVuIL5EGwGA2?=
 =?us-ascii?Q?8vabzl8p9ibmXELmYeZGwG3Qbb0KWTuDlLF3LOOVE25HHwAVNGgzWqT1kKvR?=
 =?us-ascii?Q?4C2P6jwu1Q6tItpJYUgQh2jvZwOot22VWvsB8JHfQ1MMyUKnBCTSibB4LWTm?=
 =?us-ascii?Q?vZopKtx14/BiUvDd0g32yLJ9+urY3h2P11Vdp122OQ4LQLywQChGE8wKo71/?=
 =?us-ascii?Q?UgsJ4i6u1sVZP3hfU/t11DMt0e4UOKGgQC4te/yiVult+9m/u5nVcBLGKeZg?=
 =?us-ascii?Q?yEQfTewh1U6D8+GV4d5ZprY1WMTAA/hyu0KjbcLKrDLkdPHx6tPcyyaHXWD4?=
 =?us-ascii?Q?C4jmoA/hxPzwUde3bEXjCgA/ZbM7Tq7CYrCjD7ub+Q/cn2qvaCvhmiA47ZSm?=
 =?us-ascii?Q?rUvZ9e7Ca1kG1jQsLgDozrOtavrd9dS86LQsVM92f+JeIUM73loq7/jOyD5N?=
 =?us-ascii?Q?KRkA5XVuGWKXy8exidcwIr3w+E/kTvvSmOlLxaQPcf19NyhSgHfjLbwVJGeC?=
 =?us-ascii?Q?dat9IsuucO7FvlZrdAMjr4RPMNG5F6xG7f+ZT6HB8iH2rE0Ct8Qh+2jIjFmK?=
 =?us-ascii?Q?pgiJpSgV0zKl7Neq8DdhIqRp9C78gHBYVkMQISiEciV8H/tIKOEkBOz6H30X?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf25f91-ef12-4a65-a120-08d9b59e4ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 14:16:19.8748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDa8Yuoai40g0kn36pPI6Wp5r0kJ1KrbRMAVUAPareLzkXol3A+LafwcJxKVld/OZ1uDCo/nrfeFcMpzg6O65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> From: chen gong <curry.gong@amd.com>
> Sent: Thursday, December 2, 2021 3:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sider, Graham <Graham.Sider@amd.com>; Gong, Curry
> <Curry.Gong@amd.com>
> Subject: [PATCH] drm/amdkfd: Correct the value of the
> no_atomic_fw_version variable
>=20
> 145:
> navi10            IP_VERSION(10, 1, 10)
> navi12            IP_VERSION(10, 1, 2)
> navi14            IP_VERSION(10, 1, 1)
>=20
> 92:
> sienna_cichlid    IP_VERSION(10, 3, 0)
> navy_flounder     IP_VERSION(10, 3, 2)
> vangogh           IP_VERSION(10, 3, 1)
> dimgrey_cavefish  IP_VERSION(10, 3, 4)
> beige_goby        IP_VERSION(10, 3, 5)
> yellow_carp       IP_VERSION(10, 3, 3)
>=20
> Signed-off-by: chen gong <curry.gong@amd.com>

Good catch, these were mistakenly reversed. Thanks!

Reviewed-by: Graham Sider <Graham.Sider@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e6fded7..267668b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -94,9 +94,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
>  		if (gc_version < IP_VERSION(11, 0, 0)) {
>  			/* Navi2x+, Navi1x+ */
>  			if (gc_version >=3D IP_VERSION(10, 3, 0))
> -				kfd->device_info.no_atomic_fw_version =3D
> 145;
> -			else if (gc_version >=3D IP_VERSION(10, 1, 1))
>  				kfd->device_info.no_atomic_fw_version =3D
> 92;
> +			else if (gc_version >=3D IP_VERSION(10, 1, 1))
> +				kfd->device_info.no_atomic_fw_version =3D
> 145;
>=20
>  			/* Navi1x+ */
>  			if (gc_version >=3D IP_VERSION(10, 1, 1))
> --
> 2.7.4
