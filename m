Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5410BD25932
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 03:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E99E10E0A5;
	Tue, 27 Jan 2026 03:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzE/z69L";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A3910E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 03:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYsbJEL1IowzbheHwN/1ugS7h3BH1rusv4/Ahcbihy82JswIY5+rfnbcV08kV2NBWBpr1DzGsTW3pV/a1CzCFCVh9Fe0YkivOse7FBzPLXYnqrLbuPrjGxGrEnvAUJScuAe965cL4r43c87QMlhwx80l4UsZAe6HIq/H1VVkvhxL22cn1xl72B/bWqGe2mfMlkfZqiwemC7/5S/4eQipYuCfgSQcrAEeiA7ZN9bs4TsJwSTQIUNnloaB/fB8sVeRZ8dvj0DhHlmtR7pO1DgMmU7bCqAefdxqy6kKcuEL11hzBCnBnbyjSThrb4GJoqtP7xLTsoEQ6RA4M/4r7UALHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKvM7dVuFmv2ZEjWMbqTUNrd8/pR/yJG7nTWg1Gebqw=;
 b=Rip0S6ZOggNF69i5tJJuZnHcm7p1nVd2/qrCIJ3pc4mP82vPmLC2hCvaKqCTfNrud02bEqqFPIm1zWVwA2zew3BMPduhgpTm7jASyE5R/CJsLzxKQ3aY9w8S1C3vpq4RPLeFEkGup7XRh6np79BdvzC0RGJf64nNhZM/yglVYOrNz6MM7o/ytyGWBlNwtZbiaqZvRu0hN+09ERRKsAR26F8tmbwFa1+pQqkucH6gIUhrem4Oui2teGaeh66eDAvB2xb+4X4kZZKNApn3pHppWPwl26cie/eVCAsJD6zla8umAke2GDDubLT4v7V7zfEt9GZUbpQ+IzdjyXzzOhUjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKvM7dVuFmv2ZEjWMbqTUNrd8/pR/yJG7nTWg1Gebqw=;
 b=CzE/z69L+RVqS7nRejVGV0RsFyc6yh1Z9TSWWgPoSfgXhkx7ouNcqYx+d1aCBjmBThjFRLGtZO6VSb0QFWoOiH576M2yQ8sq4lPWiUJ5pWR5AROH6OMVAQqwQN5DOmZfGpdlSkeKHGTlAsYU6opb2p+tigOb9mPqPz4nGP2GOnQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:52:27 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:52:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
Thread-Topic: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
Thread-Index: AQHcjnesAxPyNVcSpkWF5ez9tKm/ZbVlY6fQ
Date: Tue, 27 Jan 2026 03:52:58 +0000
Message-ID: <PH7PR12MB8796BE287B5BD76B51F5B433B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-4-ganglxie@amd.com>
In-Reply-To: <20260126035527.1108488-4-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T03:52:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB7601:EE_
x-ms-office365-filtering-correlation-id: 6d3d60cd-b83d-4fb1-8baf-08de5d578fe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S6UAQOcm9vg7uuFbjLfhYcc4hlfEmgZ9kvYAQ1vEFXN29AZ+SnzYbHk7PJZb?=
 =?us-ascii?Q?TnkYONtEzP60aaGs8yhyL55sBwgyRtGDhykqmbnPN2Pws1iBzOEzdEXronPI?=
 =?us-ascii?Q?10N5IhW/mdi3qx+2W1L2N/gBhWirAs4FXz+q+ZxP4dLa9anD4Viw/xryYhKu?=
 =?us-ascii?Q?pNksMqmOhI3NvzEMwZryqOAIlnuzJvSV77RiHaLPWpg+Fg4xR254w61gSn52?=
 =?us-ascii?Q?qKKQ3/trkvVBErIPWEouYwht5tFws7pvL0djPuzu2r2+xzlg6b+yuzD3vGgx?=
 =?us-ascii?Q?1ieCCMo3c+2yCSOtt/S5bG1AOtmg3ufZ2E8wMOTzetg4RWVceL9aHXKj36H+?=
 =?us-ascii?Q?aIgnat9/pOkWLURJ6cWek5RgNqRPkcF7fpVKw0zvncS5hLe53ZUmC7mR4MSm?=
 =?us-ascii?Q?NlCp9wXDAKs0trtpiAu9sKlsLAgLPrSAt1xLdpNjq4WYfQfxUWy8jcKOSfUw?=
 =?us-ascii?Q?omy9vM72qJ5Z/fVwsAi00TbuuHUOgdepOJO+H7rxGwtJWeLZxBxpic5wBDV6?=
 =?us-ascii?Q?7HkzJw1ZzIPewSaLyAM+dcYDefxhj7PUru6EDCGxF7zr/9t9K7OnFxA9Pwan?=
 =?us-ascii?Q?bBUeentVBZyEJlp16Q0zh5g7xnnP1BHUQnvKv0yNWTvzDQgApzd4tSeV6vqE?=
 =?us-ascii?Q?z2jIJhkMbwuKUMC7zDSiydFzhAsGAIqtuiK0kt8v5YydZ69bNKaiLISh9wwZ?=
 =?us-ascii?Q?UXmdT3osIWBhS+rB0Re0jMZ9FI14As7JNzw3qYrWToXbFB/QkmtWvFeEsTdN?=
 =?us-ascii?Q?oNiujJ67u4rIfcI7eEjGuaaRiDCZdd/QdaNz+8WWEpnrnmO8hbGqGrSyCsed?=
 =?us-ascii?Q?jV2Iw2hPFgtJ2HSwP27lufQ4YxTlxLkPUrCy66xRgukuYChRCYokrMvm55z8?=
 =?us-ascii?Q?hfjRHygyXoWijwL9baJdQaFFqNnM9J2utykRhs5Q1cTO2whgCLz7fNHmHNdc?=
 =?us-ascii?Q?MZmNdtYyVa8i5xLbCjJxUIRpfwl0RQBunrj0U32xJQ35u7ySeo12mSKG8LGo?=
 =?us-ascii?Q?arNzSu/NwIRAO7Z/t6NDFqV9yFTlQo5SDoM3pwfO5RHHPhoCgaiL3BLB1dGr?=
 =?us-ascii?Q?L13qRlOYFRVME5wDyL42VSSv+XfnYW+9fEPkmghih38e9sydaV7jQBx3hkmS?=
 =?us-ascii?Q?Y1UAAz6/EKS/rQ+GBAG/ym+7TpwU6q1qPWI48MKPXWxbfHIFxTHYLxAepB9P?=
 =?us-ascii?Q?NnzSO8DVXz5inN/Y6C7lchcV1nOmZm/LBUlgzN0nNl1lpmb5fhbvU2LCKyEC?=
 =?us-ascii?Q?AYlhrJxKgoArm419SCty4PapkfzlG+6zka5HYKpxcVpa9rUhec6qBwQAHjgo?=
 =?us-ascii?Q?9QwCIRYWwuQxTSCUazxXS1G8OIYnUQhb9ANbZIcixtLoTBlvAoPOgm64eocA?=
 =?us-ascii?Q?13pnxkK1wIOaAeLuBYYKXEVgJ0vowQQng4ns6mmNB9YUq/RCLNi0GMim2BvN?=
 =?us-ascii?Q?X30lliI5/T+OA/Tlk63TUSUV+mB6nS9uIkIEmir2T/olRt4oWAjIiOjfZTNo?=
 =?us-ascii?Q?sRn7bxY9OhZ9LGJdj7MR9rIo06Tt+SWypa28sK+YkjzpOchOlyxiOAhMD2ts?=
 =?us-ascii?Q?xHiZE2+VfJqYWlAh/Q3IALKtDjy5YGVGLrDDZ/+oeePVdSYvSm1sYR2CarZl?=
 =?us-ascii?Q?81DkM/1BokzMvpaC8Lp6oj0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4ZUuBiysdPf7th6wh8cYKeT/sPv5vHzQLP5rPzRu8gItaFACX+AQCF/HOpF?=
 =?us-ascii?Q?NwvpHVSjWuvaJPp/WuGOBvtlanYm4mAa+5GcMU5bcrppx/SNmkmCJSLpIa6X?=
 =?us-ascii?Q?s0Hwle0akn7P1D1lApZI0KB17keGeQ3v4RsfC5xhykt+8J/SOSJP0dMtHeKh?=
 =?us-ascii?Q?xkPtEyksvnEgBEUD6erDQZjpjhj2xj+QrInohZjcxuMWkdD68/HLvOyobHQA?=
 =?us-ascii?Q?p9yuOgSG+nzS/61ntiMOQIOJrg02aGOumB6pSWjxs/arGsqDRWQWhz/08rzj?=
 =?us-ascii?Q?GhsLFMzUTuFvTH4y9LeVNNmdXl1d34W58VTBNUkWgZpceWDxj0iDK8IFY8va?=
 =?us-ascii?Q?KNo9ROCAZAdoYeFnVHFHwZ0k7jW0kEeUZVlKFOS+hmph/nBcAbe8+Y3mz+w1?=
 =?us-ascii?Q?FIYDh0kGd+HshvT2WyR/DzlELOB1U8Ti/XfshWIyc/8rKGhYKsAl3ygtpLwG?=
 =?us-ascii?Q?d23SLpSFGkObmtTFk7FcwoK8QPtAopYKF4cRtvc2TkMDm6PxgOzRXnqA5Nbt?=
 =?us-ascii?Q?HdT5EoajSRcCwg7g3qdAvwDdaxsxCD8lubUPmDQJx+acDGM+/HeAAEYLwMdr?=
 =?us-ascii?Q?+pG5D9JLQ/P+Gn/qT/zLbNPciOhx4cwJ2p9SprG249i4rscCY6z9vAn7QtLo?=
 =?us-ascii?Q?HdkMzidCJcGIamWTa7kTEZHk6DfcAXJ/snt56RHI49F+Qax/i9j/EJHdfBzc?=
 =?us-ascii?Q?x+XKoq2ildaOM4dDPZhvHivwTx5q0YoRKew/sfz0HsdYiXmIiLEBSLGCpCUc?=
 =?us-ascii?Q?IWMTSkvXRUCfGZx0Ins8wt0h8H27+Zatv/FtPfJo3khLTXyYTYcKrvcLpG6j?=
 =?us-ascii?Q?AMPsEpm+sH0ztP69efyj/dD8D7FShqI9+1t6kOTqiW4w3K9dyOPtUqcCfNuv?=
 =?us-ascii?Q?iwjnJrBqF2mmIfNxgzu/+JDwATa/jZ4eLDV0WSCJIAg86VTl2BdRdr0dGrTS?=
 =?us-ascii?Q?bSpyq7kXSe4AQD6CRj0V9YMqyeuh2evIccymNf2DJvhzfvYPM4Y3bQe3laaf?=
 =?us-ascii?Q?ZvrSVpK5Ei4pYG0eXQ7NjKVn/a4+0ti5nWDCnWxdujX3gO6ENWknColGMqQe?=
 =?us-ascii?Q?NNoBWFldLEPQHzOozUCMUoMcUOgfIg9Xq3IJyxC1nUhyM5fon5/xZFcN5PED?=
 =?us-ascii?Q?Si38jujeQ5hT9Njf1/O3OAVF7JnanSB8dJ46mXs7hjyIMgFhh8biA0Uk5UGo?=
 =?us-ascii?Q?VWj5KETgqJrwYBjGdN6CfD1wmeAGOgumgpfmwqLdXb9M6QvdeYN4l4xXB+Q3?=
 =?us-ascii?Q?wihRjT8vytfGVwu/QTaiBJghQgs/8l8WJ0zi9fYZjcgzWdNlpUMmZu9G98Tt?=
 =?us-ascii?Q?XVHrKFuWcIQpbf7KTjWwXmQpwVYXL5zFYisi1Gcbw+AZ+i9B2qs54OHV3pMj?=
 =?us-ascii?Q?3lhTH4nOQ69FbMIfR1LoJdIN2+f5B4QWBUXIVN61NF2MRtxQHdscnw6yHxYi?=
 =?us-ascii?Q?KtiZtr9cW1VQ3JrgiwZl+eTYgXwX/kNm4J5tAapvz+DNGYkRHHY0xIvrUoAS?=
 =?us-ascii?Q?YNufHrNUXAPyIeCaZ1lutPmxug5t8JsvtOVpxJuoekJtDVmZxA4r/aOcqrmf?=
 =?us-ascii?Q?KUnwUc26nnX6kg/vGyhBH/gYyJlBpusUmuEdJQ7BibvcWvzYB+F6qq6zHVgz?=
 =?us-ascii?Q?0RP5FhgpmMy/+2XuptnNVxui32SrhaembMe39c0/2hJhEV4whHBUyu7HL9qi?=
 =?us-ascii?Q?DaLg7C3VRR8R8H+mIB9M5Hy8maTpxs+A/SAzrbT1fS2NncKp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3d60cd-b83d-4fb1-8baf-08de5d578fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 03:52:59.0198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6x8obJFqiT+sp4zm3/KcnxHgNfrBkbtk2J4yQhYmVQlHISlcm/QZOyA1xXRZvcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, January 26, 2026 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
>
> add flag to indicate if pmfw eeprom is supported or not, and initialize i=
t
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/Makefile      |  3 +-
>  drivers/gpu/drm/amd/ras/rascore/ras.h         |  3 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  2 +
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 38 +++++++++++++++++++
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 29 ++++++++++++++
>  5 files changed, 74 insertions(+), 1 deletion(-)  create mode 100644
> drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
>  create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile
> b/drivers/gpu/drm/amd/ras/rascore/Makefile
> index e826a1f86424..06b265ec1cde 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/Makefile
> +++ b/drivers/gpu/drm/amd/ras/rascore/Makefile
> @@ -36,7 +36,8 @@ RAS_CORE_FILES =3D ras_core.o \
>                       ras_log_ring.o \
>                       ras_cper.o \
>                       ras_psp.o \
> -                     ras_psp_v13_0.o
> +                     ras_psp_v13_0.o \
> +                     ras_eeprom_fw.o
>
>
>  RAS_CORE =3D $(addprefix
> $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 2db838c444f1..6e223eff522c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -36,6 +36,7 @@
>  #include "ras_mp1.h"
>  #include "ras_psp.h"
>  #include "ras_log_ring.h"
> +#include "ras_eeprom_fw.h"
>
>  #define RAS_HW_ERR           "[Hardware Error]: "
>
> @@ -335,6 +336,8 @@ struct ras_core_context {
>       spinlock_t seqno_lock;
>
>       bool ras_core_enabled;
> +
> +     u64 ras_fw_features;
>  };
>
>  struct ras_core_context *ras_core_create(struct ras_core_config *init_co=
nfig); diff --
> git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 01122b55c98a..91c883f16ae5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -382,6 +382,8 @@ int ras_core_hw_init(struct ras_core_context *ras_cor=
e)
>       if (ret)
>               goto init_err5;
>
> +     ras_fw_init_feature_flags(ras_core);
> +
>       ret =3D ras_eeprom_hw_init(ras_core);
>       if (ret)
>               goto init_err6;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> new file mode 100644
> index 000000000000..4a65351569e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.

[Tao] 2026

> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "ras.h"
> +
> +void ras_fw_init_feature_flags(struct ras_core_context *ras_core) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint64_t flags =3D 0ULL;
> +
> +     if (!sys_func || !sys_func->mp1_get_ras_enabled_mask)
> +             return;
> +
> +     if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
> +             ras_core->ras_fw_features =3D flags;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> new file mode 100644
> index 000000000000..58472e459470
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.

[Tao] 2026

> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __RAS_EEPROM_FW_H__
> +#define __RAS_EEPROM_FW_H__
> +
> +void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
> +
> +#endif
> --
> 2.34.1

