Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2DBC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 13:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9561134F1;
	Wed, 17 Apr 2024 13:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UhGrdETu";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2EC1134F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 13:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN2b5C8T/YuA7gUyxKPkPu24Fxwh0uDiyjfqmJI0Uvv94J7L418Av+xduBsXwAL0ZEevOV9E8Q3lJKAZ1ZEsXv2IxbTk0U24dmyi0cnOo/mHLJrMZvvFgWRONBfVJH2fObA+0hh/zmyLewppOCsqAk6hhaJ7IH72o+upNB0mj/vzWy/9+Pm7IyBrhFWRr6C7oDQvV17/ZGt5KSOyo/ng7IZTBR6kN94StUpJxJTGeUZ3ATY8+vmsdVC19hT3XoZNujWw5m2UmJooel+DqiBKHXW4qkTH8Nxd6FzrP2IBymJhXSxoRUzuvvUIGP21I1IZo6CSApFiJFSqLXISxZ5WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N8R6jRZvW463gmKc+XuZ8697rv+P/PKWKzHWJFVTLk=;
 b=XjRBNYynhMC1pY/DUlFgHzdSw0SJ57pWaVqz9o4+2m5cYvFe6jJDscgUKFBU+hgesFgPeagx+n8ETjIcTUYvXOTXKsrIQd+iwfzQMicG4Qh0fdtaEpQ/KFT1Tgl3HZVZ1IaopKfSt2OlQqlh2utOYerl5EBis/BVaMBO2HqEEuWZKanyamFNSU4J0hMo8gfnzFfyw8EczOCAArJL13RVJCWklGBpjpRTss2pIugCzQnqydsJrPLaHZAHVWNxj9CPde1Skkfdqz5F16IJFrNEMLEkBJhgTD4u0jUsUfQSJD+nNZRT9G4+35rpef6JgfuNu8n+Zpz/QioaVy0scstl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3N8R6jRZvW463gmKc+XuZ8697rv+P/PKWKzHWJFVTLk=;
 b=UhGrdETuoVXP7faFAm6vZjMFrvxL502iD0X+10TOtqvn536zpDA9Fj0ruBU89TRmhDpjDsCWfmyZNGFdpEAuRyGCkOy1ndkMrCACTeGP/PKw9aHD96llb3DtQQBV3lbZSlUrc0TpLrbpnD9u603iqVPoW+03sJF/xB+t3w+T2Nk=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 13:17:14 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 13:17:14 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: IB size alignment on VCN5
Thread-Topic: [PATCH 1/2] drm/amdgpu: IB size alignment on VCN5
Thread-Index: AQHaj3twfVhPrGppO0GWCFbpfiTEkbFsc83w
Date: Wed, 17 Apr 2024 13:17:14 +0000
Message-ID: <DM8PR12MB53993F632376D6AF79B77F81E50F2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240415212500.1097164-1-sonny.jiang@amd.com>
In-Reply-To: <20240415212500.1097164-1-sonny.jiang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=430a63ef-7483-4923-b15c-7281e16655da;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-17T13:15:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|CH3PR12MB8187:EE_
x-ms-office365-filtering-correlation-id: eca77bb7-09f1-463b-5a6c-08dc5ee0b292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opMO+2kJ9HPI7inpor1fcCfCE1eP7PTSZme4AsbfsEsyw3hfa8diVOHKfjGENgUMQv7qlmgp1fiEWeN6UsSJLqpvasaTTJxdLPB31p8cP0Dd1AIe/zlVkzoVzEXod4CDCB3htHu3Uwp5AMT+Kqi+EaRT7Z7J63T4iWu2LMxuU0UwIMlsLlb0bFEZ4z3q46XYwf1E+xUc03t90GNhhX2wO5Cuk/YYruIGcScx0eK1iC2w31vwHbq6+6knI23CZ8zXIdA2lmNZzDZGQjLydwiBzvOYUdz1x4TuWNszbWl8JRZAaMDotgFR+KZRlS8BB5bbWS11OLVbKiZ7mo96ELhW3ROBTGtz3aE1kk/7hKLztmST2F6rPnBV/ac0ZJ/vAwLizPmmRlrngUxuhqS3aquYcYQVXdBCxdEusyy0AT+Pw98c1RlDx/Onx9dz39lyzNwyh+EjHO3IRLH4HCoYCenzeODdBwDSWqWJo3NdlHytgK/LzzpF2d4dX0hjBw3U1t+QA5uaNyTnOVBr6utghoH39K/4othCm82eA3jAR7NMgbLPD4cz5xCzZtU9XXmvUzEBDDUFCfSkuJu535cn4ENPCZ70uwnNcEDKGDgf6DXrsdaZEaGm0DicjD0jhzYN/QJaMD+ISS4O5YGeOxDaW0eRunEO/zilExG1WM12TIYskGkPp5RM5tI3Fzi+L7UV9N/08HPY5WgtejGvkU38PZSDwK3zM1e04TuhNyTtP3RG9ac=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ic3BeVH+BKrYiKTIqs1gMb7xZcIy5kB02edPMIKwiFnyhEWwSAb4P2WAq9H4?=
 =?us-ascii?Q?HzZ2KXRfdV9NTzvQVE8p2T2yOfHvIfWXmplpcrW+PW/rx8SW3Gu7A3guE4n1?=
 =?us-ascii?Q?Dv73nRuA1j2nbPN6Sx1RdNTwdOV7gWXOAUMpdu6rgQQgUNpedICjg44H60sU?=
 =?us-ascii?Q?m2aECI5+eOd02XCRx6+39NSZ3KM/ErPivFp2uTESfb52jtoATnrOPUyTsoxi?=
 =?us-ascii?Q?RYk8jPAweaecRsxR8JdT+eoyEA/r+TyxJplgGZ8Tumv4xZJFo6+KxgRqTk74?=
 =?us-ascii?Q?9PntAAX3YMowbdtpEKA0QfL5NGKdtph+VTpE4Bz2OsQsYj0BSfYBxoj7w465?=
 =?us-ascii?Q?D/3KSu4BLVOwwmLWIdmJQ1QWlUHkDGaTO1pmPcaaoR9pqj8NyHTLk2t/lHB5?=
 =?us-ascii?Q?ab411Z+4i5/mJFRWMBFF+BER3de7eqAPfjeygqrb+TVh6j5iu8aPKEWaksE6?=
 =?us-ascii?Q?CZMpbjRX7K1z92DYgfwjlLaiq9yh2dPQ//9bqx+oV+P71M5YdTPWK05iVCG3?=
 =?us-ascii?Q?K1DjQ0l0s+Ir5dSaoJaotNth84+/xDCcRQAoaxFHGJr9mRJU3fEDth/eogNT?=
 =?us-ascii?Q?qNSnazpR4tAHdNmHi7QuuPyMWAUZlzs2cpDEwCkBFqGK3dv5OMGLbDpPFMci?=
 =?us-ascii?Q?ya3ZI1hqtZYTOTE1J1KXsup9QItQhBqu7PMPAj9yF5YJWruky9IeZswMWdWh?=
 =?us-ascii?Q?azSd1kKkTtJDOkpQB2122WwytkROsP6arNEhBc6dFNpcejJyoyZq7r7nCBZY?=
 =?us-ascii?Q?qQS/xNgSWdbMUGdZkQP5J89uavaRKHYM51XQX/DC+NCI5Gn/dchPdBeFEKV9?=
 =?us-ascii?Q?sehNcZE9Ri7UBMajh6YuuyLr19RfvqpudMcvjuIxsrV26CWj8kO6AAvyXTg/?=
 =?us-ascii?Q?jblwi2to0RBjsSL004wlaN9DVog6wGYXp8HSiBFdMS1rnK88bs/6t0EvSZ+X?=
 =?us-ascii?Q?tQ+9hqEvhzYg2dpMPnW7ubVPf2fw/5UMYc3nb/aP0u8YvskhPMAtcoZ7uTbV?=
 =?us-ascii?Q?qN9jtJwqRlJKz1A3YysKMsSFqjNwG/to8Bd27gYfW4ZOsHP6ZPpgvkyRJReF?=
 =?us-ascii?Q?X2sHNTc/XWd9uV6BXmHCMfV5GkgUJ7VMGD/CQu614dor12olEQCyG+tVnlhX?=
 =?us-ascii?Q?1VhI+e0wii4lBxspMRdR/rsstXqPCdvkiIj9AAqfxbmVAFFkvLhHRTHLYMlb?=
 =?us-ascii?Q?XgOEEVFQImphPkhV89R+V8zMLA1eoHx5dF4o0pTYWorFS/5wyyxzqF3f2J7T?=
 =?us-ascii?Q?UTOgoC+RunJhSwFZPV5G6ukZCO/P91x3aiVoVblVr7Q6h57QTfRGUeoIOO79?=
 =?us-ascii?Q?GGTeo8RNsLTN9jDTLyIweNsLCgaL8KPruLRj/fHpvyoJtqDHCPjqRGLbPkVC?=
 =?us-ascii?Q?alPSFVZI2DshR1AcwwVEGZQ/DCXlT+BmGymmcWnYsWy9KDEoco9jc1v25MTh?=
 =?us-ascii?Q?w7wyyBoY8cuZpfZEGmMuokmGG8zKTRMcbqXBq6VeGfBXGVeh2I8wLBdHehum?=
 =?us-ascii?Q?Te8Ih0VucUCXo4ix3OYBO3VzL8jl6scMd1XYU4KQM0if5phyj+CGbQw3LrBm?=
 =?us-ascii?Q?h4BRAAbZHlHjQ7p53Aw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca77bb7-09f1-463b-5a6c-08dc5ee0b292
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 13:17:14.0938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzdJQcom6ofXoAmgkn1oOGJMJwZVP7OjQa9RXEVlAXAyOh+Og76U8WXl5aVBFf6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Sonny Jiang
> Sent: Monday, April 15, 2024 5:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Jiang, Sonny <Sonny.Jiang@amd.com>; Jiang, Sonny
> <Sonny.Jiang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: IB size alignment on VCN5
>
> From: Sonny Jiang <sonjiang@amd.com>
>
> VCN5 IB size alignment adjusted.
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 5d1b084eb631..94ae14e0989c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -509,7 +509,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> -             ib_size_alignment =3D 4;
> +             ib_size_alignment =3D 64;
We don't want these impact on previous HW if that is really required.

Regards,
Leo


>               break;
>       case AMDGPU_HW_IP_VCN_JPEG:
>               type =3D (amdgpu_device_ip_get_ip_block(adev,
> AMD_IP_BLOCK_TYPE_JPEG)) ?
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index bb85772b1374..7d176046498f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -731,7 +731,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct
> amdgpu_ring *ring,
>       int i, r;
>
>       if (sq)
> -             ib_size_dw +=3D 8;
> +             ib_size_dw +=3D 16;
>
>       r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                    ib_size_dw * 4,
> AMDGPU_IB_POOL_DIRECT, @@ -861,7 +861,7 @@ static int
> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>       int i, r;
>
>       if (sq)
> -             ib_size_dw +=3D 8;
> +             ib_size_dw +=3D 16;
>
>       r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                    ib_size_dw * 4,
> AMDGPU_IB_POOL_DIRECT, @@ -928,7 +928,7 @@ static int
> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>       int i, r;
>
>       if (sq)
> -             ib_size_dw +=3D 8;
> +             ib_size_dw +=3D 16;
>
>       r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                    ib_size_dw * 4,
> AMDGPU_IB_POOL_DIRECT,
> --
> 2.43.2

