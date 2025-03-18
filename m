Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A0BC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D87710E484;
	Tue, 18 Mar 2025 13:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5V+56LrZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6221410E484
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlTTB0XClgwP3XyX0QHUo8bxiPC9/6FjLatqPW5uVml5bvpV3LbD2YmTHnPoh1/EjOwd1r/vVd2GXpIgceTNe0xLWWh0E9Fl8QdaJBzDQEy2Edq2aoFzJAqGFX9GlodpQpW14KjE82kDkNTGV0YTfe6FbKwBbDFwD1OZis96yfgQK4wkiCJCUWsgQ4uIE1/ybtD3+5eMXOsYrAskTlKRQKaSpfQhDPYVQXwwwOmpgTTbv2cuoZpsL3OVqVymQm3+Ppi6BM3csxOLFtdzis+CXlAPUKEUaVMsbpVpU6gBYrS1QXNMjnp1OqB8/fJo+KY7/AN0D8aZRvWgjW1weuIGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9pG5SlWsViugjBmDY9bJUhiRVgaQ1utzZnfkgGlc50=;
 b=WWbrS+YR50DD3QXDp8KAwEqUYMSMHfyHzfw1kS4SZPz2XF5I/DvF1GYCCCT9ugCxiYXOUFMv21MNHms5OjIbi1R6ua2R8O/U6KAwGbrM7lAYULzOf6wlzZ6vY0fJf/mr58JiRIH8EQJyFwknlZUfjzH9Izws2RU8xtNr3bLa21uPV44Lr/yePF6QvPCGORybyY6oVZFXNj9YfSG6a3ELBGz9aMsjforKAZEqOvZeZ0wKWRN1WTePqeeb+asM5sY2GXJxzJX1243WSbxc7WDnnLNELzzfIDJOI27SG4VVH/UvFHFWncIZPTtz5paPevL1PQ57ZbHYvdMHt2WrvEAmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9pG5SlWsViugjBmDY9bJUhiRVgaQ1utzZnfkgGlc50=;
 b=5V+56LrZ3OubMcux3UuXw+vEZvlUhEt5khpsg0Z6ouuj8spdruyBgc/sVzszvb7lzXXlNVWbTmeB9F4OpGYYt+ocCegzcTRvsPbqCBuTIrX9lKRHmyRAD41WOwKBP/Jws0QdGAg3DoLyrYF/cNX1cT2TBpfPJEFin/ISbMvTRmk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Tue, 18 Mar 2025 13:06:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:06:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Olsak, Marek" <Marek.Olsak@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
Thread-Topic: [PATCH] drm/amdgpu: add UAPI to query if user queues are
 supported
Thread-Index: AQHbl4OvhHJCOGCvVk6hZsSGxMfinrN4200w
Date: Tue, 18 Mar 2025 13:06:45 +0000
Message-ID: <DS7PR12MB600535BFFCEBF5CF5DE68B80FBDE2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250317212919.1018717-1-alexander.deucher@amd.com>
In-Reply-To: <20250317212919.1018717-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=aa1245ab-a551-4576-abaf-a02e1399afde;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-18T12:56:40Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL4PR12MB9481:EE_
x-ms-office365-filtering-correlation-id: 38b39a8a-ddbb-4956-5207-08dd661dbc01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AVgKcIFpyrJVN7FtHMBiS2I4cBjsAXF539EpAua2rFDhq5WK8je6fnlsi1eH?=
 =?us-ascii?Q?QsWVinEYbyrXsZGXFes2uK755VEv/z5bXJnyX4kweUtRYw4g8j5AoF9vlR0T?=
 =?us-ascii?Q?aSLXBSdNw9H75Ulh8pbVGhAvLbvFAu744GOnAHt+QDWCBSbsgdNEvEuqYR4y?=
 =?us-ascii?Q?RJ21T+rAn+ANMA/6AKdNthHeqTKDqKBt4sqm2fkZl0b7HS3PM1QxkuE6hfv2?=
 =?us-ascii?Q?M4Wz/YEAFsVxm0GIVKE9FzsGo6GluWMa8ksZ3U2c+YDTWRJWNrVciPklVgy8?=
 =?us-ascii?Q?wJmH4gXdAUViBvvrYduhNV71YClanmrp6VYwU6yXs6utnAHPpahTpVCWEdl3?=
 =?us-ascii?Q?4kQp+a6FPkIioQBx2sRK1HxMg4yoNnW9dqUxgix0ZMIPYkdrH6ebJQvB9Qru?=
 =?us-ascii?Q?76uE7BkRcKz79aXGZX0rQyFoEv5w565MEFpzXgU49tqwlpEh4hGGm7F4RN3O?=
 =?us-ascii?Q?T+2ADBbudIoVxWAd+JVdv5Up3aZvoiVvuSISmsWxRaYRLfqp8xHYzjYG4h/M?=
 =?us-ascii?Q?R/fjL/F4tkMq2rM6qg7iD7Kb0xuliVktZBf6m3KRzrHpwAOtty3eGDt0F4Vj?=
 =?us-ascii?Q?W6HJC65dkgysaPB/5RAbOH4rJhgL88UwGu/Vi53QP7EazKwZSiejcfrLlDw0?=
 =?us-ascii?Q?IzUhWObaJnjoDutDhBVFt3OuQGKXKfjz+lPbYFQ4dOHn/lsHH/oDXl2eeXmK?=
 =?us-ascii?Q?7tMbA/8F6l2HAtcgJzAh6111eyhHOe/zMl6BT3d+DhVN5p0RrtxL2GJj5J2P?=
 =?us-ascii?Q?goNuFPogg0HmRnkU28L52V0HXcX2viR2iFDweIbBvjGTwF1UnEFzkm50AwrK?=
 =?us-ascii?Q?S56dy4sdnyOzZRNt9ih9qmegRlx9zOG0PZgbWZ/rx8y/ia7lN/AP9WHkAbUv?=
 =?us-ascii?Q?OyZ7zo1R+zvtZNJO1EmPd7GUjTG3P27IA04wzI+Lu85hGUhHOdKDdAiYfLqH?=
 =?us-ascii?Q?MoTxnha2LAys7Jf1XKSjfzJzle+Adq8q41xF/DjrQJHA8foSnHyyI8nnqTrV?=
 =?us-ascii?Q?/WYONARS/BuSah0nrhDuL89EsYmnGngB/4728AC6rzWmPYjSRbc5oem95OO7?=
 =?us-ascii?Q?7LGnTytWSEEem1y8tvD8e8bcTDqcM7uAU9Wx2+YICt15B2R1JP+fwir7gwAf?=
 =?us-ascii?Q?tYJ8sbifX7i2XXnnTQSKNZXhGFNbW+/MnsZtrcQOX+RwixT4mDHLbvcfD7fU?=
 =?us-ascii?Q?tW1yVni9LD67A2Nf0neybw9HsbfCl+TuXcwLKfXZxqLbGFpjSLNLjna60CY8?=
 =?us-ascii?Q?8Y+ScTmMNRP1a7B14TMZ8bd+Dl95pvdVCVfJ4N3Ry1tnfd1A5WtJhVCcqgfW?=
 =?us-ascii?Q?DYKHT/yL9jFbXJDly8LZjs4wFATYhxG/0TcK7sFjkMaAFUlPyhe/joqkGmHp?=
 =?us-ascii?Q?nZ7a8aKcHJPsxXhHs8lHS5kbX/2N5EaioAFo3X2iD8A7P1/Z1OqtgIEB9fC6?=
 =?us-ascii?Q?BYIDOBomkZ8nJJp2fowSaoLM4nBOPT90?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ToEvCKUO9/c1mdM5MmmZwj2R6XBmM2E/cn47s8R6d2bzmwwA54No650ol2Cd?=
 =?us-ascii?Q?dpVy6joAWg5mJPG+zrnANIdNaOWpQYycK9XNnwSV5AmHsfLclr6updSBjD7S?=
 =?us-ascii?Q?rrkM3IjtC27Mn8+xdC74r90QeEBnifbHzVY2DX/QOvCSNdUcTMtlmRQYv6Ss?=
 =?us-ascii?Q?rXAEyjlZkauhsPtF2E91kjyyOnyg6PGp2Jqk4xCq4yei6XhsZVy4tN2Zz7Ym?=
 =?us-ascii?Q?yRAPtUZyENs4bf/qXUEioLxDSw2wsDzn01UHUNXAQf5waskOtSjaRWLiWS9J?=
 =?us-ascii?Q?ftpa5TUvGQGTLWkYjJ3MpFI6Ew55H7uEt6bhuMr9fYkYndQIX0+arYCvIX1A?=
 =?us-ascii?Q?JshYlI0l5j0kPxrMykpbcpQgZcwRWUfai85dL80bn90ahhL/7eQpU0H1hYP4?=
 =?us-ascii?Q?C4PMLdrgM99QqHmFhkHft1sRB12rtJ/XwQNHEhm/XhOt3MmWGwO8P0TVUHSB?=
 =?us-ascii?Q?j4HB4Bv5nMriOUd/xZ42ySjuqW6YP+q/su6dAh6UrH3OBCW9X9WNp3kGNIVH?=
 =?us-ascii?Q?036cRdKvmYE8RE8vkYH57fo//bpmpo3IVLZcbbxWUXgd2DzgCbEgBw2H7EZ+?=
 =?us-ascii?Q?HqOTaDOIA9J9kQcp8PljFqbRQCI5bpRCZC1iUs/A8uW/9osrWpAUUBuO592o?=
 =?us-ascii?Q?NBb0gHt0P+A3gNpqxZiXvRK5mIgU07/4EfGhWUKhOV2zf2oZd8I1HVmv8L7F?=
 =?us-ascii?Q?vwzxvltl1wLRuHLUP8RELHF4lvoqSk6pluvY5ZlNbpMoDIrR3D6bLacHBJU7?=
 =?us-ascii?Q?n01D6I0JnSybjvn7+wpGqlOuwnpUohp4Etc+iAcNIYJxUPG+Hi0WEuhP1MR7?=
 =?us-ascii?Q?TNgqOnyllNNLdrvdxdHdupU8ss9p0UsjgDUxmHk8uZ7eAAoTNpLc34qikc5w?=
 =?us-ascii?Q?QFJoDwuadh1wKb/1VBoX+pWIrxYfQRbgHTstvq9xkXHkRK4lzTvFHoQDArGs?=
 =?us-ascii?Q?KUwbL1KLr2SO1TJHfPLYD3c6FhEuy6bYB/GPcQ+MqxEorNx6wJUs6jBok8aW?=
 =?us-ascii?Q?rN4lwSj1CAiTKJI16OHhgP7h/wTMCFpgpsjjh3ejTfmTykfNRBvV5AcafH8j?=
 =?us-ascii?Q?nLfnoUcpCZ1A/KJm4QSEKkxr8qSdIEjl/mR0FqQesiKAN2WYY6TzWav8qF30?=
 =?us-ascii?Q?/U5ypt1LyEGA1EC5RD26sMADeagxg8aqZocupdTrdU6hWdErddwc1FDMs8Sw?=
 =?us-ascii?Q?kOLoNcd/ZaYTCpMl4zsKbi05ppZ0rSSn6wZ+JsCQMTYfA/aVbURuwD8mUMxT?=
 =?us-ascii?Q?1kwd9H/vJz0oyPS/DXKImqj1B6LVZTRmOm32jE8qlw6Gymtich7ijAULZ9El?=
 =?us-ascii?Q?o2RAecNibu5KP90FqcSCuVVc6qa1xnNK+OA2rzpQPSM5kp67xmu2XcTcnvxb?=
 =?us-ascii?Q?cq7TAkV4BIzhtikxF/N/QT67/fNj5N1OaPBuJlouYy89rdy4ie7XZ+zC2ywy?=
 =?us-ascii?Q?+f9JBG/RP7q7R9CqSszpblOyd3oyP6b85GcXV6yULDMUJDqvVHXwWZSieJS5?=
 =?us-ascii?Q?BSoe5W84YlFBXjlrHKPoPMAxo+ENF7XFXHWZbIakZ9myBn1d93BluTIkIBjQ?=
 =?us-ascii?Q?7ng4g63qnurTID92MT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b39a8a-ddbb-4956-5207-08dd661dbc01
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 13:06:45.0223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGxpRpMnsjq+JLGt1CiaMUfb4O41ytbmc8XWeUsixzOVncTkDRw0hu0rIfEmhj1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

May I know when the counterpart part of Libdrm and Mesa can support this UA=
PI?

Regards,
      Prike

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, March 18, 2025 5:29 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Olsak, Marek
> <Marek.Olsak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: [PATCH] drm/amdgpu: add UAPI to query if user queues are support=
ed
>
> Add an INFO query to check if user queues are supported.
>
> v2: switch to a mask of IPs (Marek)
>
> Cc: marek.olsak@amd.com
> Cc: prike.liang@amd.com
> Cc: sunil.khatri@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3b7dfd56ccd0e..1d683c0487697 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>                       return -EINVAL;
>               }
>       }
> +     case AMDGPU_INFO_UQ_SUPPORTED: {
> +             struct drm_amdgpu_info_uq_supported uq_supported =3D {};
> +
> +             if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
> +                     uq_supported.supported |=3D (1 << AMDGPU_HW_IP_GFX)=
;
> +             if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
> +                     uq_supported.supported |=3D (1 <<
> AMDGPU_HW_IP_COMPUTE);
> +             if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
> +                     uq_supported.supported |=3D (1 << AMDGPU_HW_IP_DMA)=
;
> +             ret =3D copy_to_user(out, &uq_supported,
> +                                min((size_t)size, sizeof(uq_supported)))=
 ? -
> EFAULT : 0;
> +             return 0;
> +     }
>       default:
>               DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>               return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 5dbd9037afe75..4b64e91002c05 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT                      0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS                      0x24
> +/* query if user queues are supported */
> +#define AMDGPU_INFO_UQ_SUPPORTED             0x25
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT       0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK        0xff
> @@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
>       };
>  };
>
> +struct drm_amdgpu_info_uq_supported {
> +     /** returns a mask for each IP type (1 << AMDGPU_HW_IP_*) */
> +     __u32   supported;
> +     __u32   pad;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.48.1

