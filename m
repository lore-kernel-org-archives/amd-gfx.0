Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DC4C021AD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 20:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A18010E75E;
	Tue, 18 Feb 2025 20:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZSHwu/G";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA78B10E75D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 20:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw25gB0s15ekMeIYP7pgc2mZuDY8LQRNNOtDn31QTpRNvk29sWY5yCsyacIz7DcFPaqTwgf9edORClm4kp/VAo5V9ahiV2tTKGQ/RxoZwwJAww1uk8KmjIg7sEEe+oYAMCKrB1cSK34eYg/vuy0v47QSQWUCMsipZRP7PU//1Awsxvx8YY5SbeZgYgz57OaRQhFVOmK90WNB6NvzNtBsW+q/NyuEIt6CHlUF59fPwbjLwYMopbsQyAzYa760tEi+lpF/WKNNJkcLFT6VSnCRX0SqiddAZOyZDYIhXnTW34W/Jnqm3UeGUpXAIhqViUER1TSwmlLNrIsef+xLSLI3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kEezVo5MkV/9IA9N86eo4JHSlY2G10YKgs2HTBPdyU=;
 b=UPYuSri8p1j8g/gBHn42Y3N29yBF4OVwCKnZjvJzTnXVNM/wIGoo+pD57oGHuNF6K7ewrgSahvKK7LZu3gh9GfI8NzsO6RAT2gTwTA6ZLjnhrZ/Tnovf6olBD0i+gJyfi9g4Mm7C5j2uQejbAzBBw32ybOVekWTgsobFYz7dsgwDJTmpJeHyRP+r/ZW8lZ2OipoRrEoMVUpQXTM4BfEoQTQn5EM/eNO2Dy4ZAN+axWBkvLEdzSDu6TGpcvNol7Zt/CMLML/ejJfVaTyXekkDc9JEB+GnncxM7STa+sw5iiXJsmH78BN1EoOHXWajT5P8Pu1L7yWVqzCvqPeUu763Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kEezVo5MkV/9IA9N86eo4JHSlY2G10YKgs2HTBPdyU=;
 b=qZSHwu/GxZUGmuM8YxXhTyeoCDFwU8C5z2WcEUauqTJ49Gaooj8BoThCBF2seI/ATH1IncUq79F5XbSqvB4nY8OkTLrXu3tE2pqymfze1IvKjSoz7Sl7kJpdJXvawo0XqJdYwR0KDvj8NvvIm2OU1lFJUYLG3Pi+PNxoqD6iHVo=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 20:27:31 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 20:27:30 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Don't modify grace_period in helper
 function
Thread-Topic: [PATCH 3/4] drm/amdgpu: Don't modify grace_period in helper
 function
Thread-Index: AQHbfZoU6Ej45NBTG06fO4iabs2QdbNNfLvQ
Date: Tue, 18 Feb 2025 20:27:30 +0000
Message-ID: <CY8PR12MB7435040E5C09ED83C461923385FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
 <20250212220341.373072-3-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250212220341.373072-3-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=571f011b-e712-4714-9986-eea264c5ac06;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-18T20:10:08Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BN5PR12MB9485:EE_
x-ms-office365-filtering-correlation-id: 2b0a891e-8a49-418a-c083-08dd505aaaf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EJ5EY0x98TcvU3wvW5GnyrZKmvvjzCq4BpGAuUrRPkG9g9uGd6Ugb3GURgF/?=
 =?us-ascii?Q?f99oE8j2fHZbuXcKIBCNabr9Ej/FnQ9Mr1U6NpnPNwBRdf02tpwkqm68lImp?=
 =?us-ascii?Q?KJ+R8DgcDblHAR9aQuYatoqprGchojN0z7IOuF9c0TfrGCTHGSReILg8uxOB?=
 =?us-ascii?Q?akLgsSP1360LyQSuT9qEfJShck1teIlk1Oa0OGuWlD8T/agccqmq6QazI9Dc?=
 =?us-ascii?Q?ovkN3FeOEklLVSu2+zVpimHXAXGIyBcicQ9Nf0zxwBCRgIF3akK3bnXvxwat?=
 =?us-ascii?Q?3zqlfmVXzzDN7Twb47VjSuyHNv3LRZbLy2xOFcW/wI9BRFtOo7Adc22n8Gp6?=
 =?us-ascii?Q?4flCujDSwI3I+Ibo+6zWAdY5WODM6KPs0xvtfs3Nm/wbjpzUViF30YBMni1b?=
 =?us-ascii?Q?BuD7mt1tI0KmJK7Eh6ghfWYgUofDNL+vnyI4KGokOiArnHdIOLveFvY7fW6a?=
 =?us-ascii?Q?ESNNFJe7MBZSzIboliS5YbfX2B8Ahd7i0aauYs5tCteJRDdUcaf7WaCeQ5mG?=
 =?us-ascii?Q?NWyYu97bBrQAkhzGmfb0KTNNQdSUNLwIrLufubNXUotzDu8rHVUQmQaazz+0?=
 =?us-ascii?Q?4mFa2EukrjkRB/j90G4TvnpZ8dlKfKBbt3lx90pDEnbo09rw2H5UE05JBDot?=
 =?us-ascii?Q?gBUfpuysvznj4HdcerB480ybZFHqCFqtKX1C5Xbbn97AuE0AG60F/2jdRYgz?=
 =?us-ascii?Q?IhwpKMuaeM5w/iSkMM/v2qlZsqjbcLe3OxGEzHLfW3v9FEhVchxB8L8KqZIR?=
 =?us-ascii?Q?Se4kjlimBJV7rU7IRAtGA3Lew1l7LJZ8UZEX5YPjbuqPm7HMXXXFRpDvAOaG?=
 =?us-ascii?Q?UvfL/Z4EzK583ItJtyiqpPV+jwoynzlH52l8WnNITAjLPCBGYAEtNGAzdHM+?=
 =?us-ascii?Q?n33nzqr8yhTglCWP+DQ0joCAKAVtcwLj+6WSyR3vQMCnh3aXwUe4AosMxRRG?=
 =?us-ascii?Q?Sj6yxLuLXPUqYUP+hdZtJWa6Z2LGl23dsgnyfRnO6r7tUDEWvVKW0EUGVCSh?=
 =?us-ascii?Q?Lvd+JX50BL480QOarABzIqRM01Z5YgDC1lpaQmFRcWrGOfmQwzBTIOls15Co?=
 =?us-ascii?Q?m+3+CjQe4TXTjlgwizq4JXU1mF8t4rFZ8M0Ln+cuEJzMnGXLjd4kEJK7i7ef?=
 =?us-ascii?Q?Xr1NDJ39RlPSFzqkV2JY8wHbeJCZd5Wt5bzZ/qMeCPqdR8x9axCPR5GNH+T1?=
 =?us-ascii?Q?hPIPprugg+mGvl95ZNTnfls3iilbK7qVeAcK/Hw8rRUc2i+e+G3R7Owu+xfz?=
 =?us-ascii?Q?sqKUj0jjWq0uvMwnASVB+z3X1jCEl/L+s30ksqQ2krgwo4svK8sfjcE6XU/i?=
 =?us-ascii?Q?GEzzjl7LpNJpHHGDBJO0JXR2XoN5fXJY723Gn2Vandkpr8BwiIRhj003UzT5?=
 =?us-ascii?Q?QYLoRozZkodhQBH2BrG/49OYB4gqV6HlcEbx3I5DhshOduGwySfuNIYpI8e8?=
 =?us-ascii?Q?oIAsa7bImzuwRkzDCVa3XBDQmndzZeVV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1w4aWiklz+4wih6FTpyZf4q7SFovfJm7f8tK0GgayYBTntQCsyh17Nr1nLoc?=
 =?us-ascii?Q?wEpQuLWuUJKt2QpE2VQn/vxh61VXAjEJbNgVzMmw9CmJzrvxXbRZzoDnuTaS?=
 =?us-ascii?Q?ujF8VTYn5k+H62NC7mgl/gSKFOZLg6wLY9bggwtvxwbgeTo8OAQEZ1P9eQFH?=
 =?us-ascii?Q?9ExSp+KDoAFb2uxZrP49hvfIiH4JEGD4TncHdfC8wdsOGPYU9z9QxCbl4046?=
 =?us-ascii?Q?Aw9OOiBSZDgqoLnF4VnVyCqpfzPFYDUZgWaPuG2B6toawYJUNPyNRW8Bkfzu?=
 =?us-ascii?Q?q/gd/zEbh8iO7W+WhkHUx17OZQlfxsKgdHlMzcDgD81vpoaD4RH2ApR+MdGc?=
 =?us-ascii?Q?rUoIl+bEq+dJ6BVhiz+2foNHuz3aU8aCX1i8VNKdWpCh+0brY3gLQhYPsIRg?=
 =?us-ascii?Q?+vj+vt2XkEqHrXHR/6RYaLxHUbn9iequHhYKqCG2ORC3BtIR50q8X7VqXjTC?=
 =?us-ascii?Q?cJDLBZSW5dt4pobpWFYKoYPFDQktYzfns83W826o8xChoDUCPN2FfW6F0UT0?=
 =?us-ascii?Q?OKx5owwglA+Qu4XBiVtKQqTtM2H/PHrmB2sTcZUQWcqnZyOvi7HVlIqLJ+F4?=
 =?us-ascii?Q?P8mQMLmQmifyO+EnIn5GdmhPz6bFDUEwt4z3INNTXfKtzXMFclpNVdUdA4CB?=
 =?us-ascii?Q?Jgmd03R8l6kNrq65b38vr0+IlwpDYPo6YwfUxyCvtARlRueZM+HMIAhUkh5m?=
 =?us-ascii?Q?pdHa5yNJMI5inToLFauMMU0Iy4KsF40P1tB0NKdr+BoR8ll7ZIXdSCC4apco?=
 =?us-ascii?Q?sDPotP2NgRbZQtXnAyyEjCEV1YjKsQXWOMiHlS5R92ppnroCx3MzNf/uaGxE?=
 =?us-ascii?Q?qpWZBvTntApBO7NYkElbwfNbxjNgLTMKdaaVDtIeR/wClvGlaUHof4u47PVq?=
 =?us-ascii?Q?XGEM9ZsRpNGG95QVp4x5h4T9QCprqZLp0cNRGQ/UEsVLlS328u3h2M/ZBp+u?=
 =?us-ascii?Q?ZL5Ql9P1D/qC9IBzL/H9qEhjpNAyCOoFr+x9kSH1m7uV12jvn4+tL/GDyXSC?=
 =?us-ascii?Q?bc3X+tyn+lDbBgFiqesRz2XMuxkBHGwd0b/UqdW2x5LAoPbrU1GpGpaTbYIA?=
 =?us-ascii?Q?PlBnO/YkVG/+NmcdJ95G9xi2EBeaHVgT1HsKgPw99NDtLgoxnOTPgJmcOskp?=
 =?us-ascii?Q?OQ+7s+ysONgHm2Z7EkU0EGAMEtzk4mH6v226Ecvr4LXJtkwVL9tQGV0z8+DP?=
 =?us-ascii?Q?32pLohrb1N3SMxTAl9BZ6ZEmR+7YmFGLtUpyc/ei1SyUdDe9IoIoRcdIM4QD?=
 =?us-ascii?Q?gmlSpfKBIvw7b53BZOJbQeRfmkHY8tjsShmh42j8s+l0DxXo66KQSotrUGah?=
 =?us-ascii?Q?rzAGR68ZYnbdAU+jDy03ixna0zXgwyKTZxPfL9yhN+lXQ+DpzGeD0wyaNKsi?=
 =?us-ascii?Q?TOJ/jT7KG+5cnmtZF+T9Rjpdc1+XV/xZpIw6TQLrJf9ZfPMgNZccVHKDNpxo?=
 =?us-ascii?Q?uXntnQ3GTa+RoCQfTaju9r+o2edRvCwd6jOkcMsTcic/+B+EeVVoDCA4zBkA?=
 =?us-ascii?Q?Y5LvF/+SO+iyqvjHrdyooTjYe/d1/RZ+p+GRINoyQicq2ngCm9vIocHdZpPW?=
 =?us-ascii?Q?OUHkncoiazEVpPGHYnM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0a891e-8a49-418a-c083-08dd505aaaf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 20:27:30.1723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMu+0aq/T49jlafFKRghFgfr0K8qvZPtQswYSFhoQClFDcXxNiC/Tj9l/+yC54nX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 12, 2025 5:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 3/4] drm/amdgpu: Don't modify grace_period in helper func=
tion
>
> build_grace_period_packet_info is asic helper function that fetches the
> correct format. It is the responsibility of the caller to validate the
> value.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 18 +++++----------
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 17 +++++---------
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 23 +++++++++++++------
>  3 files changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 62176d607bef..8e72dcff8867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1029,18 +1029,12 @@ void
> kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannont handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> -
> +     if (grace_period) {

Should we get rid of the notion of grace_period in the function name as wel=
l as the param since you're doing it for the rest of the patch?

> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             grace_period);
> +     }
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 441568163e20..04c86a229a23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1085,17 +1085,12 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>  {
>       *reg_data =3D wait_times;
>
> -     /*
> -      * The CP cannot handle a 0 grace period input and will result in
> -      * an infinite grace period being set so set to 1 to prevent this.
> -      */
> -     if (grace_period =3D=3D 0)
> -             grace_period =3D 1;
> -
> -     *reg_data =3D REG_SET_FIELD(*reg_data,
> -                     CP_IQ_WAIT_TIME2,
> -                     SCH_WAVE,
> -                     grace_period);
> +     if (grace_period) {
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             SCH_WAVE,
> +                             grace_period);
> +     }
>
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 6a5ddadec936..ecabf95d972f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -307,13 +307,22 @@ static int pm_set_compute_queue_wait_counts_v9(stru=
ct
> packet_manager *pm,
>       uint32_t reg_data =3D 0;
>
>       if (wait_counts_config =3D=3D KFD_INIT_CP_QUEUE_WAIT_TIMES) {
> -                /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 AP=
U */
> -                if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_a=
pp_apu &&
> -                    KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))
> -                        wait_counts_config =3D 1;
> -                else
> -                        return 0;
> -        }
> +             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> +             if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_=
apu
> &&
> +                 KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))
> +                     wait_counts_config =3D 1;
> +             else
> +                     return 0;
> +     } else if (!wait_counts_config)
> +             /*
> +              * NOTE: The CP cannot handle a 0 grace period input and wi=
ll result
> in
> +              * an infinite grace period being. This is not an issue her=
e since 0
> +              * would just set it to default value.
> +              * However, grace_period needs to be explicitly set to 1 fo=
r avoiding
> +              * any breakage for existing debugger user interface. Curre=
ntly,
> +              * debugger interface expects value 1 when set to 0.
> +              */
> +             wait_counts_config =3D 1;

If you decide to follow my suggestions for patch 2, then you would only nee=
d the else-if condition.

Jon

>
>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                       pm->dqm->dev->adev,
> --
> 2.34.1

