Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120ABEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6509D10E40E;
	Thu,  6 Jul 2023 14:27:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7AE10E40E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/kZ1Itvc3AwfaeorkWIltMWHN+CBhj3oGR4+I02Q3kZuRD4BUEZKiWkx7dPWHJqnVWhxdfoKMYq3d/q5xVpCimqBH/dIw8b7j8S4tLU1x7dXZi/3fbq6KEPb+XjStZJJmnFp8ZGISYD+qtKPgFNxgB29vWISSMtmsYnfRhM3GzhM3vTHXDNtPul2GXzZtva3ZK0050Ugq3NGDmAGNNGz0D6FxvaAolUI4pLYxTaGI6p/FRZoXDT91EBP8uLClEdAYBBT2yY01GsdWSbFGZDuDNu/v2Ic05fNGN9fGpJw5yTqWFP7N36C9zF0fKLynY1QoIrBViFlF1PgdP/P2nYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsubxZN3oMzM2lIAfS6WstmhdaSClrMLfn726bzmQXc=;
 b=eJy2a79zcyswY3ffY9sH6C+OAQb7zBoOlGiAfJYAhn1/9lYC+S73MOmA/TREDI0BaahiPEMfGrRQOxusS3IhbHalp3/bYN8ZW3ZzAYb0CLaARD4eLki1df6GnxNbVS8nvVGArDqXmX1DX392CKGCaxs5f0ASCkzktEXs9uWjd6D35RLQ6DxCi/q/uE7JQh247w6FyZyj8nlrhcGdmKuTlU0eCbFbxFL2AMs+4BnZ386S54mwTROydrPcTSS7iMHmJHFoUw9GFXghWObxaUqt39C8fZQYNUb6RpgXwyYWquwTOvaavsmZ/A0701CnXj1UgGOsz+6NAxe6Z39agE7XUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsubxZN3oMzM2lIAfS6WstmhdaSClrMLfn726bzmQXc=;
 b=lP3RS2QRCDVG/FXe0vSJKMpNgzS7MI9/1OmbnRURkEw+cF1FfB3HYMBVeWvb25sWvURSwueGGUZLjYqyJPV6sZIH4S1dOP3ylzel35RTNz+j5bRspqSw7aTtV4CD1Ur4euN97oF77JkmdIM9DPYEMo5gIW5Nl509zjSvFkFLoD0=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 6 Jul
 2023 14:26:51 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:26:51 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdkfd: restore debugger additional info for gfx
 v9_4_3
Thread-Topic: [PATCH 2/5] drm/amdkfd: restore debugger additional info for gfx
 v9_4_3
Thread-Index: AQHZr5RHp0BzjU5ssk+5AsBljV7KV6+szF+A
Date: Thu, 6 Jul 2023 14:26:51 +0000
Message-ID: <CY8PR12MB7435ECFF0FB50CE231D430C3852CA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
 <20230705225655.299335-3-jinhuieric.huang@amd.com>
In-Reply-To: <20230705225655.299335-3-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9ecb24bf-402a-4536-becc-3c5b59ff9434;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-06T14:25:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ1PR12MB6171:EE_
x-ms-office365-filtering-correlation-id: 3a7e0e88-c7d7-4d12-3536-08db7e2d0a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWtPK5nrqDFwjRhvEq511EizHP7/dbCg8cUZmi7ZtkDuJHp3LOswcuQh+SGq+eTOyHpovvFMHsNGr8QQw0tcw7lBXdHaFwZogcMmKzZ6JdsnNqONRD67fGYw8JoYU1vlIuxQNZFjxzunPWczuHAE6V3CORzeQ9xMXw4A7O8N7HARjqTNLpL1vXMumD8q/Kjh1p0iXW93VmWJKF/lWnSAl+48s+t0JOjeciND4aUImNY7yqueED3bzYeuAzqb21s+37mMNXJqLuDFDRg134NjLUAYfCaBBzfNfuqsBnvu3c8qTrs1Cb0Q0zYfkWSB4nw1Wx/ad/FrJGO6RQHCMrZq8dTaUfgF/DiEuZrMaT4tDh1gjWVKMrYsHacaqwnMAN4zLDgHCCN0GcFifGUK2ibiH7+fpx5aUlJn04WVJBeUB8+TCQmetmQu0sJsqzxHJsgGu6MNa8tV0Qs/crxsBVz7dMIoLzkpv6KZ3yBnVl/9Hl0fz3LGf+fsOVTD5zLWlVFVg7OTWzgBqeBuH795x4zlzQ9BWE/3ZcbXIhi+PFrM8Bl2IFJ2nOs613AnsqFZyQIowmweTNWZeDGLPPBMXLaifKY2YgRk63QR0wbDXWY4y7J0PtPWbBz5A8SQgP4L5E5Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(83380400001)(55016003)(38070700005)(2906002)(122000001)(38100700002)(110136005)(52536014)(8936002)(8676002)(66476007)(5660300002)(54906003)(86362001)(71200400001)(4326008)(66446008)(64756008)(66946007)(66556008)(7696005)(478600001)(186003)(33656002)(76116006)(9686003)(41300700001)(6506007)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fl+frqZcWh0NAnXM18pe5PxFWw3Cwb8Q5Dm684sHL5eQtidIV74VMTk1A+wW?=
 =?us-ascii?Q?0UHgou0IC+TgWdQXPJgzyKIounnG33owtlbwhkHYPfWQ/bpUxbq8nJwVQwkC?=
 =?us-ascii?Q?kLeEXTsHKD5sTmM/msOje75iP6Fe0kwNn9LhqiAdD1+QKxjSJIYioRhrr2Dy?=
 =?us-ascii?Q?sMFI7AFVIF2V6oqF2b5loFiFGMAPr/8YoXhw+YPEg6moPqmQwTIpKPppNR9k?=
 =?us-ascii?Q?ZdR7K4kUC0Ksx/SWFXKQqQfACCOGnTdxHtFh1ukgdUHVbFSVTdplfVKXNfho?=
 =?us-ascii?Q?fmJjYAt7fPkmTGOlN67UrvGZN3F6bu4OCeoPDfk0FHx6wMJcqemjMRJuFMNb?=
 =?us-ascii?Q?XnevVGUZfQ0B0WHItYbZxhntNB9KnrLdDk8aD/0NKiZ3vfxQjQeGeAYD3YBl?=
 =?us-ascii?Q?iiRfwgHOuv9t+52bXoh5WX3YYTFbYE5TQdXy2v+AM2zxaNF5OwX6t4sodC61?=
 =?us-ascii?Q?5ijEJNmaH7rp5QT5b8sDbzGIB8o+bB7X8OTgdELTdNI7lAkm2FSTdgKvAElv?=
 =?us-ascii?Q?jWzldeh/SAqdcgJBi63w8LXAe83K369jM79z28pC9UVh14uBbfNkhGx9XAVv?=
 =?us-ascii?Q?eU9CPRbuQUf/vhtzm9YLIN6Cf7pk8FrYLm+33JmTNUv5Wxq5P1Y6GIBwx67P?=
 =?us-ascii?Q?rImClBQ4r0oSpOXL0qjPNQAQAGs9LqE2lmAo0ni02qJFlnPC4jVASPn0ExdU?=
 =?us-ascii?Q?UqIUr0U+CyvJZBnGNMYmUhhHZDolMzdflaEUVMVGjdb3zqIXdNdM25iLSS6h?=
 =?us-ascii?Q?MsCcZwLq4s3SjNE2nHw28OrEklYTxiXKHTRDSLaoYD0GcrSMTdjJpYGHtCsz?=
 =?us-ascii?Q?h00/HIwT996ZmThuJGrFWm4LoSfs6AwADPbZC7CLJOjYPSv7K9iAuoc+p59H?=
 =?us-ascii?Q?SEmSdaeoeCXV6SYF20KAcEU89yHFcLKP5DmRo3aTKGya4+2ZKmCUH+4g5rrO?=
 =?us-ascii?Q?GVqNmqbIInK1lqvTxAc9bJyoHW8R71tKwDqSXlsrYnhOMyL4qEYe33Y5GBXD?=
 =?us-ascii?Q?RIWMxNb7/YeZgQg9tlErxgApD7j3QVYC3+WCG8UU/Rg0Uf2oGpgAsV7jq2JV?=
 =?us-ascii?Q?ssatL9j3DBoB1TgUQ6BbYSsK18NWxDNoGRYhf+W8Jgp4MUc/U37uo4F5BzTl?=
 =?us-ascii?Q?TeynARWAp0VgcJr1iDS8K5JwPrdNmnTBQeLm+3672uVuHpWXIuDVx0BREzyG?=
 =?us-ascii?Q?CBkIUPkRn6J1VFEdTg0t1aA2vMpqSUvVoBeJUWC424zZqR0WnQfV1tDknRYx?=
 =?us-ascii?Q?JZxHad+vB1+/51ScGC2ekDg7KhzpEBN2tv4UAypnEZL9oHz0G7XxjP0B+gwz?=
 =?us-ascii?Q?XoBoH3l9aqOHferQqDu0zMhtoyQNl+09aiiZaadlfxClpigMY9zIceQ309DS?=
 =?us-ascii?Q?ZbyL5xxIBNWzJkeDWgbrsEt7A6e8D8Hp2T1pI6PUDs6K9C+TgyDvtFHD2K1V?=
 =?us-ascii?Q?x6YlqTKZAesjPOJhMeDCcX165knQBUDq8mN3cXUk2/LHLHNzRZfa5c2lwxp+?=
 =?us-ascii?Q?PxCRNqQVGb83/Pc88DHlOfJ5jZ7hNOtNNgn1m6+tNXmsxyRjQ6ovpw7cez+N?=
 =?us-ascii?Q?bwd1Ikp6XQYGlNw8iEZWPA4b2lm2kzoaD4EGcaCsXYHq3jAhBQ6tDShLro4z?=
 =?us-ascii?Q?F1qHMX3s43MsnGin9cqLmkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e0e88-c7d7-4d12-3536-08db7e2d0a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:26:51.5981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Twne+C8LF+szM5lFlN73Qka3171CuhtpJqyuAsYqjEiIQXVLnpP+rWHKlhZAEGt1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Wednesday, July 5, 2023 6:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Lin, Amber <Amber.Lin@amd.com>;
> Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 2/5] drm/amdkfd: restore debugger additional info for gfx
> v9_4_3
>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> The additional information that the KFD reports to the debugger was
> destroyed when the following commit was merged:
> "drm/amdkfd: convert switches to IP version checking"
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Acked-by: Amber Lin <amber.lin@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

This patch is Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  3 +++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 61fc62f3e003..1a4cdee86759 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1932,8 +1932,14 @@ static void kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>
>       HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
>
>       if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
> -             dev->node_props.debug_prop |=3D
> HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
> -
>       HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
> +             if (KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(9, 4, 3))
> +                     dev->node_props.debug_prop |=3D
> +
>       HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 |
> +
>       HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3;
> +             else
> +                     dev->node_props.debug_prop |=3D
> +                             HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9
> |
> +                             HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
>
>               if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
>                       dev->node_props.debug_prop |=3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index cba2cd5ed9d1..dea32a9e5506 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -32,9 +32,12 @@
>  #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
>
>  #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9  6
> +#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9_4_3 7
>  #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 7
>  #define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
>                       (29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
> +#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_GFX9_4_3 \
> +                     (30 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
>
>  struct kfd_node_properties {
>       uint64_t hive_id;
> --
> 2.34.1

