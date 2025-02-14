Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64550C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B5610E49B;
	Fri, 14 Feb 2025 15:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CP/khFXl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF6610E49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PimVvP0TXALqgQFIKfHHKfTRlq1EHcSqaxzwO3L8ZLnOGblHwJ6jhoGTLhxnAa3fjoOet96IojJqffWse1C07+AP8/7O6OxUZ1UQUGjSnLp6I8JLqrWU1DqKwzO+0bPCLfiJn1ge0wCT8XOgfFgHC37IqAH3U2I5Rt/jCwQeAAA3GcAMbhimdXAKa9OTwf2WVOcoztL7hS0QuiC5mhXEEsZf7UUGe2m35feSq/swWda05na5PFtSSuEcpzvEqn56QGUNbQ6waO4wEOUDseB6FP7L6lxn6rgtJQyzSJ3VtB8ITIyma63b+dzqY9vbo6pXR8SEGDofu+ToGZlAVmBhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smjtEsS2E/8S8upj8PWfDxDlgi2wUocq17YAvw3rwYc=;
 b=mWtNN35S28Bf1ysHIBK8wLMNsPGRsiBKRbAoIkZpPK/W5gBjve5iT2NlNdUtqmfmRD48m0M7Ad2EVmyjIfaUeuLrR2zIlDHXcwZ8DIJhB01bVUT2JRwe1ysrX2z9laro9NtqZMFaL5+tDLHTAa8j8ll9jjong+Q3vqTBmtpyZzKOLQK4TjYjQYe87CQ/J1Sbb5amk8Mfx6ypsruj0leu8yd5SDqaotg1PV4ZX1Lngunrt6YHmH/OsbjmSeREP3ghob/YDSCJBTqZ2afjIgTC3ZK1+29sE9mlOaTvAfVTG4gtpuSXwY5pCR4OwXUYfjW0+3UZST2sVy9FIR4IL55iWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smjtEsS2E/8S8upj8PWfDxDlgi2wUocq17YAvw3rwYc=;
 b=CP/khFXlZtM7J+o9Qn/XXP/DGCBtqSFf4+pU2voOINcsUPp0L0dQIAzhEijaYneTkba4d3Qqu6ayVmGX/sYBd5vVjZ4NLXvBgrdBZme3X+InzCwqq3/fgsczQSNjmsy/JWfQFytlQY03K45xTKLyaVKIaLMWIezoZh7/sPM0BXw=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 15:38:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 15:38:44 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
Thread-Topic: [PATCH] drm/amdgpu: simplify xgmi peer info calls
Thread-Index: AQHbfWbb/R1taonYI0C84RGAf+2gZLNEx+4AgACbMACAAOz1AIAAlqYAgAAKkhM=
Date: Fri, 14 Feb 2025 15:38:44 +0000
Message-ID: <DS0PR12MB780445C81DE6CB10E083174397FE2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250212155734.2213096-1-jonathan.kim@amd.com>
 <63230f85-c3de-43aa-b23a-d7cec00d23ab@amd.com>
 <CY8PR12MB743521D96B986FABB06327D285FF2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <3536548b-9e4f-4223-92a3-d616c4843f90@amd.com>
 <CY8PR12MB74355B8D95866E74CE18ADE685FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB74355B8D95866E74CE18ADE685FE2@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-14T14:57:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|IA1PR12MB8285:EE_
x-ms-office365-filtering-correlation-id: 8a71bdd9-12d0-4de4-ba64-08dd4d0daa57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?H0aw8jVIRztp4Wg8HTyiVWdbfpt6vq4859iTL3wEHA8aBnNEjXWEkKWHslKJ?=
 =?us-ascii?Q?SZXt93Mcvrcw7kV8MgbKUiGvEzJrsLJq8uoGmXvQHwdenGClf+UgYM07v4im?=
 =?us-ascii?Q?jCKcmObtNRDP7Xx9sVABw3zPW5BhKV9ROxOs+etDuprnn4uV7nMbDN6ggbp4?=
 =?us-ascii?Q?A7S1IOZZON+LZQ+SdfEjhmbFM+vKcRW6MSV/OLM+Govzi9F1UXPUGsHawvp2?=
 =?us-ascii?Q?Y17p5eCUntcIrsMmpdAIUlKecRAqlGM055mEmuqQp6NoOHsrf2huti1/JZL5?=
 =?us-ascii?Q?nLPH5HKaF5C3+SJRiarEGPgz94SCvSg4fQs+BS87qdLX8y2zdir3zZWVcNPO?=
 =?us-ascii?Q?HCuN9vsH7fa5PZ3HnspiHc2bD0q2QFblcq1J2dN+MIrbozpwUowGCuC097JY?=
 =?us-ascii?Q?hJYPCohZsn9ceMHqFMUypwFZTGUs+5EwmxkhYxjO4OQk/w7l0frQ8eN4jBgB?=
 =?us-ascii?Q?ZR43zSSaFbH6cWQMl+FhtwKVk7KVtqqeqp4O1SXEqr/wW3P2pN5AHG0cNxQP?=
 =?us-ascii?Q?ql5KGCFR3nnkpBN3NbNPCDvygNgJ8tHwyyd+SOLLD2UKS2eE9xRORPFDLh45?=
 =?us-ascii?Q?Wiw63MsrATbAIY+kZWab2TRylC6k7sPUU6iiIuq9FLzNc//HSZB47fuMSWEY?=
 =?us-ascii?Q?F9bZHdkkyX7/MgxVEmWiJeo22hzErEJOUWfu2xq2WbkvYD9lhGPn2u76ntZN?=
 =?us-ascii?Q?eD/kW/6yx+iBu89qM5oJ4jrvla7O6bDmgrH75k+Fh/V5iWTviWvLQrfhQ28i?=
 =?us-ascii?Q?7Why4hREgbTTovEhFJPeOjXdEt8ID+XpB9+dRYjPnKDsz8aEixEgJvikk5vh?=
 =?us-ascii?Q?AudGFgy1833Bz/juhRsAqfy3L6iRmwwX/XTMzTCx/IcHNwmLkB3CUy/JyTbQ?=
 =?us-ascii?Q?rmkMg8nB071g9W4/fvSchQk3AAVK/omGY3TOgmvESffKgoETWhAOgUyM4oXf?=
 =?us-ascii?Q?hwnevsgnlSaqIUz6q+xLg6P0lglfqVDRtw650SfW4N0klGV1XdUReadNTBEB?=
 =?us-ascii?Q?s70dwW9YlPr3N5o8qHQqo9Q/Iz5k/5lwTWyE9xGdDyUNHFYJBvLYv3kgBHwo?=
 =?us-ascii?Q?1sRDZjB0K3PPmmt+62wzPIqoSCgc/Nly2yQnDfnVsAq9TJgguHjZHhtukcHP?=
 =?us-ascii?Q?QRuWfPXJ8hlJ8DJ5gxmZrBGJrX8K1OpYFFuHY8EAhtsKpt+uaIKFsIkNkqMv?=
 =?us-ascii?Q?Wu8OExymMdwarITvD/4zjcWt5ET6tcOL6a8Wzj5/RcmJJNpPJRhSe4Nkei4K?=
 =?us-ascii?Q?PSwAr+UoVUdUHAauHYiB3Kw4RujG3fMgsIZXAbi6oQw6azqVCvZ86MMgEn2n?=
 =?us-ascii?Q?I2cnhqj9uwpcsZyApqYL05kM9zgYtdeWRfmKkr18AZr5P2W6jaczXEfFGff+?=
 =?us-ascii?Q?qP7C7Xz5JGgQeIzQQKQomekMZR4B2D/AvineaGu+mjJ2EplQfVKWCFM8EsXZ?=
 =?us-ascii?Q?J8kGaUWHXeSI+IABIzGztFsH86ejdet8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eVZE36rYZUzt20NnS7WIoT8YITlFPyN9pSWvEk6ctxmJParbIuAcZ4nHpJGe?=
 =?us-ascii?Q?8E6T/9gDu1mW+9+4FWQzev0JpSIo7CYeAMVN9mE+8NxVT+bbLkdMM6Q8hoLh?=
 =?us-ascii?Q?PNduIymih3ORHX70Gor/bMkMC51brDmi6Zrnb8LStDKdmsSXVoyiUBUjUznO?=
 =?us-ascii?Q?Be5A6AiXK/0PrN5WDJEwmC3bwDuEfVVGiH2WccKj7GWs2W/ABln5B6Gy3VB5?=
 =?us-ascii?Q?FMZ0BnWTJjzTVjLmux6IulHhS73gX+fNCAo9pdozwlrCW2m3yU6zKxut4p1U?=
 =?us-ascii?Q?xFbJO6x9sIWixJrPNk0Bni18RrNnbS70nipLgm5UJuRxKglWUWdpJjNoSeJ1?=
 =?us-ascii?Q?gDQeQs/LRb0aIxqZkOGVw8g7W1rAwwkwncK6JjTDC0jNGKbrMgl43zR5CQUr?=
 =?us-ascii?Q?kmPmurt5rD7V2Q/wRojgXG5YKWzHNSoeYX8QVxCwmrTNbezQ+kH8yvrNuNhG?=
 =?us-ascii?Q?wuZBIEpRg2ZkpAAHhMIY+1Us2rr3n4jGRyYg+lVRT4Edt39w7kiXRJ9nwqXm?=
 =?us-ascii?Q?3AVe0G7jemxQelw5PrX+drF30kKAzmcIlt9hEVDAmTjvt94uSMuO48wNxSNW?=
 =?us-ascii?Q?4DyKxvUAa9KfCPblwmKRxN+nbKpXMoVwwF332uML2xO5ZE6ipBL36vyk1i9d?=
 =?us-ascii?Q?x1wp1y+xEi4D0BSYGRwJrD3vQyxEUU2waW9ioU/2sg8dEZ5DUKrsxsNQp2GN?=
 =?us-ascii?Q?QZI6tjugvkwRA9HxY2MaCYwyn3X/sk9hrE/0PJdv0LUk0uGk/WnedU0sh5y5?=
 =?us-ascii?Q?tXsttjqNHK9vrNK3lu16mCSLFOB+Bw/B3UugHcAf/BdorZvwaYv5S3pLwIlQ?=
 =?us-ascii?Q?pvcagT8JuGfOHjuKLqlUcPR6CVa/lzjkyVQZJi2fczwgESHDaH3HsW3YP89b?=
 =?us-ascii?Q?J64aVBmMiqMqAA2lFmUJz43K3kCjKzrS4d5c7akdjnzRM1tzR/gNQ/t8DXfj?=
 =?us-ascii?Q?5ZXlX/R4Zl9MLq8DoD6moFnDwcT5ApXzdHT499mp2oNJfVEFs7jOiZr8Iuld?=
 =?us-ascii?Q?sc/YWRij+VnrN1oIaZLF0zpCQosoUO4PMNIMKbLWEoFDC59p+7y2eEL+YQBL?=
 =?us-ascii?Q?3htO4+lXTg4hxZmE78uK4efbEEoeaKrIziUJfQpW95KFVC7gSWpkMPtwFDWe?=
 =?us-ascii?Q?kORwkskpNil7qnIi67T1IzHPsA6ayGuI3bhcIJrWAsZoLeqCnG7ZnIVREDsM?=
 =?us-ascii?Q?pKH/dh2x0g3AxnqWVWsXsjMaCWjtrpJqg+6aMcpnCko7jalohClXJ7vuUStb?=
 =?us-ascii?Q?xpu2nabxF6Nou//jzCsJa8p4mjg5Iw8sH58I29rdXZK9ioj0k/30BBEFr8yn?=
 =?us-ascii?Q?idqqxBTpH9dZwjBzok7he+jkx0gNg5qZocCg9GSLY4aU6w5r1MakQl08SdUy?=
 =?us-ascii?Q?1RF9PrtRlZKtRuQnvXg6bacq1BG9dMQgbqTl/f352qdzAyA3r5nO3Q4ZbMtY?=
 =?us-ascii?Q?bCwgE/X2VJJ2yzGpJdEM6yqj1PxBuW9Lv6jwQjqakW9zoGuZtK35TJ1k/UlZ?=
 =?us-ascii?Q?UsffmPctXyrNND6yFSXxOy59bJX9/FhlLOqIP77MDjs2obQUURsLfWwJ4iTc?=
 =?us-ascii?Q?4ib/zNMKR8YBN379drCf1exKYUhDL6xJh2mzX28e?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB780445C81DE6CB10E083174397FE2DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71bdd9-12d0-4de4-ba64-08dd4d0daa57
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 15:38:44.4152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxDCp1i+mhI8CqGG4lum9xSi+A2Arj+Ib6lwAbd267krsydVVh+MsXUtGj2oPEzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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

--_000_DS0PR12MB780445C81DE6CB10E083174397FE2DS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

For minimum bandwidth, we should keep the possibility of going to FW to get=
 the data when XGMI DPM is in place. So it is all wrapped inside the API wh=
en the devices passed are connected. The caller doesn't need to know.

BTW, what is the real requirement of bandwidth data without any peer device=
? In what way that is useful?

Thanks,
Lijo
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Friday, February 14, 2025 8:27:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify xgmi peer info calls

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 14, 2025 12:58 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
>
>
>
> On 2/13/2025 9:20 PM, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Thursday, February 13, 2025 1:35 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.or=
g
> >> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
> >>
> >>
> >>
> >> On 2/12/2025 9:27 PM, Jonathan Kim wrote:
> >>> Deprecate KFD XGMI peer info calls in favour of calling directly from
> >>> simplified XGMI peer info functions.
> >>>
> >>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ------------------
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 51 +++++++++++++++++---=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  6 +--
> >>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++--
> >>>  5 files changed, 48 insertions(+), 67 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> index 0312231b703e..4cec3a873995 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>> @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
> >> amdgpu_device *adev, int dma_buf_fd,
> >>>     return r;
> >>>  }
> >>>
> >>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> >>> -                                     struct amdgpu_device *src)
> >>> -{
> >>> -   struct amdgpu_device *peer_adev =3D src;
> >>> -   struct amdgpu_device *adev =3D dst;
> >>> -   int ret =3D amdgpu_xgmi_get_hops_count(adev, peer_adev);
> >>> -
> >>> -   if (ret < 0) {
> >>> -           DRM_ERROR("amdgpu: failed to get  xgmi hops count between
> >> node %d and %d. ret =3D %d\n",
> >>> -                   adev->gmc.xgmi.physical_node_id,
> >>> -                   peer_adev->gmc.xgmi.physical_node_id, ret);
> >>> -           ret =3D 0;
> >>> -   }
> >>> -   return  (uint8_t)ret;
> >>> -}
> >>> -
> >>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *ds=
t,
> >>> -                                       struct amdgpu_device *src,
> >>> -                                       bool is_min)
> >>> -{
> >>> -   struct amdgpu_device *adev =3D dst, *peer_adev;
> >>> -   int num_links;
> >>> -
> >>> -   if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
> >>> -           return 0;
> >>> -
> >>> -   if (src)
> >>> -           peer_adev =3D src;
> >>> -
> >>> -   /* num links returns 0 for indirect peers since indirect route is=
 unknown. */
> >>> -   num_links =3D is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_a=
dev);
> >>> -   if (num_links < 0) {
> >>> -           DRM_ERROR("amdgpu: failed to get xgmi num links between
> >> node %d and %d. ret =3D %d\n",
> >>> -                   adev->gmc.xgmi.physical_node_id,
> >>> -                   peer_adev->gmc.xgmi.physical_node_id, num_links);
> >>> -           num_links =3D 0;
> >>> -   }
> >>> -
> >>> -   /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
> >> bandwidth. */
> >>> -   return (num_links * 16 * 25000)/BITS_PER_BYTE;
> >>> -}
> >>> -
> >>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *ad=
ev,
> >> bool is_min)
> >>>  {
> >>>     int num_lanes_shift =3D (is_min ? ffs(adev->pm.pcie_mlw_mask) :
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> index 092dbd8bec97..28eb1cd0eb5a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> >>> @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
> >> amdgpu_device *adev, int dma_buf_fd,
> >>>                               uint64_t *bo_size, void *metadata_buffe=
r,
> >>>                               size_t buffer_size, uint32_t *metadata_=
size,
> >>>                               uint32_t *flags, int8_t *xcp_id);
> >>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> >>> -                                     struct amdgpu_device *src);
> >>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *ds=
t,
> >>> -                                       struct amdgpu_device *src,
> >>> -                                       bool is_min);
> >>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *ad=
ev,
> >> bool is_min);
> >>>  int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *a=
dev,
> >>>                                     uint32_t *payload);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >>> index 74b4349e345a..d18d2a26cc91 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >>> @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(struct
> >> amdgpu_hive_info *hive, struct amdgpu_dev
> >>>   * num_hops[2:0] =3D number of hops
> >>>   */
> >>>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev)
> >>> +                          struct amdgpu_device *peer_adev)
> >>>  {
> >>>     struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> >>>     uint8_t num_hops_mask =3D 0x7;
> >>>     int i;
> >>>
> >>> +   if (!adev->gmc.xgmi.supported)
> >>> +           return 0;
> >>> +
> >>>     for (i =3D 0 ; i < top->num_nodes; ++i)
> >>>             if (top->nodes[i].node_id =3D=3D peer_adev->gmc.xgmi.node=
_id)
> >>>                     return top->nodes[i].num_hops & num_hops_mask;
> >>> -   return  -EINVAL;
> >>> +
> >>> +   DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d
> >> and %d.\n",
> >>
> >> Suggest to use dev_ function to identify the device pci number. Since
> >> the function still passes, maybe info level is good enough.
> >
> > Ack'd.  Will change.
> >
> >>
> >>> +             adev->gmc.xgmi.physical_node_id,
> >>> +             peer_adev->gmc.xgmi.physical_node_id);
> >>> +
> >>> +   return 0;
> >>>  }
> >>>
> >>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev)
> >>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev,
> >>> +                                struct amdgpu_device *peer_adev)
> >>>  {
> >>> -   struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.to=
p_info;
> >>> -   int i;
> >>> +   int num_links =3D !peer_adev ? 1 : 0;
> >>>
> >>> -   for (i =3D 0 ; i < top->num_nodes; ++i)
> >>> -           if (top->nodes[i].node_id =3D=3D peer_adev->gmc.xgmi.node=
_id)
> >>> -                   return top->nodes[i].num_links;
> >>> -   return  -EINVAL;
> >>> +   if (!adev->gmc.xgmi.supported)
> >>> +           return 0;
> >>> +
> >>> +   if (peer_adev) {
> >>> +           struct psp_xgmi_topology_info *top =3D &adev-
> >>> psp.xgmi_context.top_info;
> >>> +           int i;
> >>> +
> >>> +           for (i =3D 0 ; i < top->num_nodes; ++i) {
> >>> +                   if (top->nodes[i].node_id !=3D peer_adev->gmc.xgm=
i.node_id)
> >>> +                           continue;
> >>> +
> >>> +                   num_links =3D  top->nodes[i].num_links;
> >>> +                   break;
> >>> +           }
> >>> +   }
> >>> +
> >>> +   /* num links returns 0 for indirect peers since indirect route is=
 unknown. */
> >>> +   if (!num_links) {
> >>
> >> This looks problematic. I guess, it is better to keep the old way of
> >> passing min/max. Otherwise, there is a chance that min reports some
> >> value and max could report this error.
> >
> > I don't think this is a problem.  The old way of passing is_min =3D=3D =
 true is tied to
> peer_dev =3D=3D NULL, which made it a redundant argument.
> > is_min =3D=3D  false doesn't prevent the issue you've mentioned from ha=
ppening
> because the old code effective sets num_link =3D 0 if the peer_dev search=
 fails
> anyways.
>
> The problem I was thinking about was with respect to usage in KFD
> properties. With this way, min_bandwidth will report some value even if
> no link is present between the devices. Max bandwidth will report 0.
> Ideally, we should report both min/max =3D 0 when there is no link presen=
t
> between the devices. I haven't checked if KFD does some other check to
> ensure that there are links between devices before calling the API.

The KFD only queries for links within a hive.
Checking for max first implies link on non-zero return.
We could change the KFD to set zero on if max is zero then.

>
>
> > With the line at the top of the proposed function:
> >>> +   int num_links =3D !peer_adev ? 1 : 0;
> > The sematics are as follows:
> > - NULL peer_dev indicates that caller doesn't want peer-to-peer data to=
 factor
> num_links into bandwidth reporting so assume a single XGMI link in bandwi=
dth
> calculation.
>
> I think this semantics doesn't provide enough clarity. XGMI is
> interconnect between devices and ideally we expect two devices to be
> passed to the API. If any one is NULL, then it's better to reject.
>
> > - If a failed peer_dev search ends up with num_links =3D=3D 0, that mea=
ns the caller
> passed in an invalid node (i.e. it's not one of the nodes that's been reg=
istered to the
> hive).
> > Currently, get_hops_count (old and proposed) operates in the same fashi=
on too.
> > So the functionality between the proposed changes and old changes shoul=
d have
> remained the same.
> >
>
> The API is usage is clear and general expectation is two devices are not
> NULL. That is clear in the case of get_hops_count.

I don't see where that expectation is set in the proposal.
peer_dev =3D=3D NULL is asking for a peerless check of potential bandwidth.
If you're saying we need a redundant is_min bool to ignore peer_dev num_lin=
ks checks, I'd say then both are a waste of time for clarity's sake.

In that case, if we want to be strict with both peers being non-NULL, chang=
e the following:
- expose amdgpu_xgmi_get_num_links to KFD to mirror get_num_hops
- KFD calls amdgpu_xgmi_get_num_links to do some handling and later pass re=
turn into a new bandwidth call if return is non-zero
- change amdgpu_xgmi_get_bandwidth_mbytes(peer1, peer2) to amdgpu_xgmi_get_=
bandwidth(adev, const int num_links, enum unit_type)
        - adev -> used for future IP checks as a dynamic internal speed con=
stant setter
        - const int num_links -> caller passes in constant link multiplier.=
  So in this case KFD can pass back the num_links it finds from previous am=
dgpu_xgmi_get_num_links
        - enum unit_type -> some enum we can define in amdgpu_xgmi.h to giv=
e the back the caller whatever units it's looking for (GTs, Mbytes/sec, Mbp=
s etc ...)

Then this way:
- KFD enforces min/max bandwidth to be consistent i.e. both are 0 or both a=
re non-zero
- bandwidth call is now more general purpose and flexible and provides vari=
ous bandwidth return types by caller needs.

Jon

>
> > I'm open to adjusting get_num_hops & get_bandwidth_mbytes to return eit=
her -
> ENODEV (device not found in hive) or -EINVAL (bad peer_dev request) on a =
failed
> search.
>
> On a failed search, does returning 0 work - zero hop/bandwidth
> considered as no link found between the provided devices?
>
> Thanks,
> Lijo
>
> > That would require a change to KFD CRAT logic to error return itself on=
 an error.
> > However, this would change the behaviour of a bandwidth reporting error=
 where
> ROCm could still function, to the KFD not loading at all.
> > Currently, the consequence of passing an incorrect peer_dev to the band=
width call
> would result in the ROCm Runtime not issuing an SDMA ganged copy i.e. pot=
ential
> peer-to-peer performance drop.
> >
> > Jon
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> +           DRM_ERROR("amdgpu: failed to get xgmi num links between
> >> node %d and %d.\n",
> >>> +                     adev->gmc.xgmi.physical_node_id,
> >>> +                     peer_adev->gmc.xgmi.physical_node_id);
> >>> +   }
> >>> +
> >>> +   /*
> >>> +    * TBD - will update IP based bandwidth later.
> >>> +    * Bandwidth currently assumed to be x16 lanes x 25Gbps.
> >>> +    */
> >>> +   return (num_links * 16 * 25000)/BITS_PER_BYTE;
> >>>  }
> >>>
> >>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >>> index d1282b4c6348..325e7972469d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> >>> @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct
> >> amdgpu_hive_info *hive, struct amdgpu_dev
> >>>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
> >>>  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
> >>>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> >>> -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev);
> >>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> >>> -           struct amdgpu_device *peer_adev);
> >>> +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct
> >> amdgpu_device *peer_adev);
> >>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev, str=
uct
> >> amdgpu_device *peer_adev);
> >>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> >>>                                     struct amdgpu_device *peer_adev);
> >>>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *ade=
v,
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> index 70b3ae0b74fe..a787d192390c 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(i=
nt
> >> *avail_size,
> >>>             bool ext_cpu =3D KFD_GC_VERSION(kdev) !=3D IP_VERSION(9, =
4, 3);
> >>>             int mem_bw =3D 819200, weight =3D ext_cpu ?
> >> KFD_CRAT_XGMI_WEIGHT :
> >>>
> >>       KFD_CRAT_INTRA_SOCKET_WEIGHT;
> >>> -           uint32_t bandwidth =3D ext_cpu ?
> >> amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> >>> -                                                   kdev->adev, NULL,=
 true) :
> >> mem_bw;
> >>> +           uint32_t bandwidth =3D ext_cpu ?
> >> amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
> >>> +                                          mem_bw;
> >>>
> >>>             /*
> >>>              * with host gpu xgmi link, host can access gpu memory wh=
ether
> >>> @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int
> >> *avail_size,
> >>>
> >>>     if (use_ta_info) {
> >>>             sub_type_hdr->weight_xgmi =3D KFD_CRAT_XGMI_WEIGHT *
> >>> -                   amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev,
> >> peer_kdev->adev);
> >>> +                   amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev-
> >>> adev);
> >>>             sub_type_hdr->maximum_bandwidth_mbs =3D
> >>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->ade=
v,
> >>> -                                                   peer_kdev->adev, =
false);
> >>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev,
> >> peer_kdev->adev);
> >>>             sub_type_hdr->minimum_bandwidth_mbs =3D sub_type_hdr-
> >>> maximum_bandwidth_mbs ?
> >>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->ade=
v,
> >> NULL, true) : 0;
> >>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL=
) :
> >> 0;
> >>>     } else {
> >>>             bool is_single_hop =3D kdev->kfd =3D=3D peer_kdev->kfd;
> >>>             int weight =3D is_single_hop ?
> >> KFD_CRAT_INTRA_SOCKET_WEIGHT :
> >


--_000_DS0PR12MB780445C81DE6CB10E083174397FE2DS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto">For minimum bandwidth, we should keep the possibility of =
going&nbsp;to FW to get the data when XGMI DPM is in place. So it is all wr=
apped inside the API when the devices passed are connected. The caller does=
n't need to know.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">BTW, what is the real requirement of bandwidth data witho=
ut any peer device? In what way that is useful?</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kim, Jonathan &lt;Jon=
athan.Kim@amd.com&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 8:27:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: simplify xgmi peer info calls</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; Sent: Friday, February 14, 2025 12:58 AM<br>
&gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2/13/2025 9:20 PM, Kim, Jonathan wrote:<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt; Sent: Thursday, February 13, 2025 1:35 AM<br>
&gt; &gt;&gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists=
.freedesktop.org<br>
&gt; &gt;&gt; Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info call=
s<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/12/2025 9:27 PM, Jonathan Kim wrote:<br>
&gt; &gt;&gt;&gt; Deprecate KFD XGMI peer info calls in favour of calling d=
irectly from<br>
&gt; &gt;&gt;&gt; simplified XGMI peer info functions.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Jonathan Kim &lt;jonathan.kim@amd.com&gt;<=
br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ---=
---------------<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; =
5 ---<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp=
; | 51 +++++++++++++++++-----<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp=
; |&nbsp; 6 +--<br>
&gt; &gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 11 +++--<br>
&gt; &gt;&gt;&gt;&nbsp; 5 files changed, 48 insertions(+), 67 deletions(-)<=
br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<b=
r>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt;&gt;&gt; index 0312231b703e..4cec3a873995 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt;&gt;&gt; @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(st=
ruct<br>
&gt; &gt;&gt; amdgpu_device *adev, int dma_buf_fd,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_=
device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_device *src)<br>
&gt; &gt;&gt;&gt; -{<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct amdgpu_device *peer_adev =3D src;<br=
>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct amdgpu_device *adev =3D dst;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; int ret =3D amdgpu_xgmi_get_hops_count(adev=
, peer_adev);<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;amdgpu: failed to get&nbsp; xgmi hops count between<br=
>
&gt; &gt;&gt; node %d and %d. ret =3D %d\n&quot;,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.phys=
ical_node_id,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_adev-&gt;gmc.xgmi=
.physical_node_id, ret);<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D 0;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return&nbsp; (uint8_t)ret;<br>
&gt; &gt;&gt;&gt; -}<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgp=
u_device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *src,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool is_min)<br>
&gt; &gt;&gt;&gt; -{<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct amdgpu_device *adev =3D dst, *peer_a=
dev;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; int num_links;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &lt=
; IP_VERSION(9, 4, 2))<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (src)<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; peer_adev =3D src;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; /* num links returns 0 for indirect peers s=
ince indirect route is unknown. */<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; num_links =3D is_min ? 1 : amdgpu_xgmi_get_=
num_links(adev, peer_adev);<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; if (num_links &lt; 0) {<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;amdgpu: failed to get xgmi num links between<br>
&gt; &gt;&gt; node %d and %d. ret =3D %d\n&quot;,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.phys=
ical_node_id,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_adev-&gt;gmc.xgmi=
.physical_node_id, num_links);<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; num_links =3D 0;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; /* Aldebaran xGMI DPM is defeatured so assu=
me x16 x 25Gbps for<br>
&gt; &gt;&gt; bandwidth. */<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return (num_links * 16 * 25000)/BITS_PER_BY=
TE;<br>
&gt; &gt;&gt;&gt; -}<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct =
amdgpu_device *adev,<br>
&gt; &gt;&gt; bool is_min)<br>
&gt; &gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int num_lanes_shift =3D (is_min ?=
 ffs(adev-&gt;pm.pcie_mlw_mask) :<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<b=
r>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt;&gt;&gt; index 092dbd8bec97..28eb1cd0eb5a 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &gt;&gt;&gt; @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(st=
ruct<br>
&gt; &gt;&gt; amdgpu_device *adev, int dma_buf_fd,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *bo_size, void *me=
tadata_buffer,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t buffer_size, uint32_=
t *metadata_size,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *flags, int8_t *xc=
p_id);<br>
&gt; &gt;&gt;&gt; -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_=
device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_device *src);<br>
&gt; &gt;&gt;&gt; -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgp=
u_device *dst,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *src,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bool is_min);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct =
amdgpu_device *adev,<br>
&gt; &gt;&gt; bool is_min);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_amdkfd_send_close_event_drain_irq(struct=
 amdgpu_device *adev,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t *payload);<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt;&gt; index 74b4349e345a..d18d2a26cc91 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; &gt;&gt;&gt; @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(str=
uct<br>
&gt; &gt;&gt; amdgpu_hive_info *hive, struct amdgpu_dev<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp; * num_hops[2:0] =3D number of hops<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_get_hops_count(struct amdgpu_device=
 *adev,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_device *peer_adev)<br>
&gt; &gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_topology_info *to=
p =3D &amp;adev-&gt;psp.xgmi_context.top_info;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t num_hops_mask =3D 0x7;<br=
>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.supported)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; top-&gt;num=
_nodes; ++i)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (top-&gt;nodes[i].node_id =3D=3D peer_adev-&gt;gmc.xgmi.n=
ode_id)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return top-&=
gt;nodes[i].num_hops &amp; num_hops_mask;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return&nbsp; -EINVAL;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu: failed to get&nbsp;=
 xgmi hops count between node %d<br>
&gt; &gt;&gt; and %d.\n&quot;,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Suggest to use dev_ function to identify the device pci numbe=
r. Since<br>
&gt; &gt;&gt; the function still passes, maybe info level is good enough.<b=
r>
&gt; &gt;<br>
&gt; &gt; Ack'd.&nbsp; Will change.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_node_id,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; peer_adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; return 0;<br>
&gt; &gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev=
,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev)<br>
&gt; &gt;&gt;&gt; +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_devic=
e *adev,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_devic=
e *peer_adev)<br>
&gt; &gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; struct psp_xgmi_topology_info *top =3D &amp=
;adev-&gt;psp.xgmi_context.top_info;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; int i;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; int num_links =3D !peer_adev ? 1 : 0;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; for (i =3D 0 ; i &lt; top-&gt;num_nodes; ++=
i)<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (top-&gt;nodes[i].node_id =3D=3D peer_adev-&gt;gmc.xgmi.node_id)<br=
>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return top-&gt;nodes[i=
].num_links;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp; return&nbsp; -EINVAL;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.supported)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (peer_adev) {<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct psp_xgmi_topology_info *top =3D &amp;adev-<br>
&gt; &gt;&gt;&gt; psp.xgmi_context.top_info;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; int i;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; for (i =3D 0 ; i &lt; top-&gt;num_nodes; ++i) {<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (top-&gt;nodes[i].n=
ode_id !=3D peer_adev-&gt;gmc.xgmi.node_id)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_links =3D&nbsp; to=
p-&gt;nodes[i].num_links;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; /* num links returns 0 for indirect peers s=
ince indirect route is unknown. */<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (!num_links) {<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This looks problematic. I guess, it is better to keep the old=
 way of<br>
&gt; &gt;&gt; passing min/max. Otherwise, there is a chance that min report=
s some<br>
&gt; &gt;&gt; value and max could report this error.<br>
&gt; &gt;<br>
&gt; &gt; I don't think this is a problem.&nbsp; The old way of passing is_=
min =3D=3D&nbsp; true is tied to<br>
&gt; peer_dev =3D=3D NULL, which made it a redundant argument.<br>
&gt; &gt; is_min =3D=3D&nbsp; false doesn't prevent the issue you've mentio=
ned from happening<br>
&gt; because the old code effective sets num_link =3D 0 if the peer_dev sea=
rch fails<br>
&gt; anyways.<br>
&gt;<br>
&gt; The problem I was thinking about was with respect to usage in KFD<br>
&gt; properties. With this way, min_bandwidth will report some value even i=
f<br>
&gt; no link is present between the devices. Max bandwidth will report 0.<b=
r>
&gt; Ideally, we should report both min/max =3D 0 when there is no link pre=
sent<br>
&gt; between the devices. I haven't checked if KFD does some other check to=
<br>
&gt; ensure that there are links between devices before calling the API.<br=
>
<br>
The KFD only queries for links within a hive.<br>
Checking for max first implies link on non-zero return.<br>
We could change the KFD to set zero on if max is zero then.<br>
<br>
&gt;<br>
&gt;<br>
&gt; &gt; With the line at the top of the proposed function:<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; int num_links =3D !peer_adev ? 1 : 0;<br>
&gt; &gt; The sematics are as follows:<br>
&gt; &gt; - NULL peer_dev indicates that caller doesn't want peer-to-peer d=
ata to factor<br>
&gt; num_links into bandwidth reporting so assume a single XGMI link in ban=
dwidth<br>
&gt; calculation.<br>
&gt;<br>
&gt; I think this semantics doesn't provide enough clarity. XGMI is<br>
&gt; interconnect between devices and ideally we expect two devices to be<b=
r>
&gt; passed to the API. If any one is NULL, then it's better to reject.<br>
&gt;<br>
&gt; &gt; - If a failed peer_dev search ends up with num_links =3D=3D 0, th=
at means the caller<br>
&gt; passed in an invalid node (i.e. it's not one of the nodes that's been =
registered to the<br>
&gt; hive).<br>
&gt; &gt; Currently, get_hops_count (old and proposed) operates in the same=
 fashion too.<br>
&gt; &gt; So the functionality between the proposed changes and old changes=
 should have<br>
&gt; remained the same.<br>
&gt; &gt;<br>
&gt;<br>
&gt; The API is usage is clear and general expectation is two devices are n=
ot<br>
&gt; NULL. That is clear in the case of get_hops_count.<br>
<br>
I don't see where that expectation is set in the proposal.<br>
peer_dev =3D=3D NULL is asking for a peerless check of potential bandwidth.=
<br>
If you're saying we need a redundant is_min bool to ignore peer_dev num_lin=
ks checks, I'd say then both are a waste of time for clarity's sake.<br>
<br>
In that case, if we want to be strict with both peers being non-NULL, chang=
e the following:<br>
- expose amdgpu_xgmi_get_num_links to KFD to mirror get_num_hops<br>
- KFD calls amdgpu_xgmi_get_num_links to do some handling and later pass re=
turn into a new bandwidth call if return is non-zero<br>
- change amdgpu_xgmi_get_bandwidth_mbytes(peer1, peer2) to amdgpu_xgmi_get_=
bandwidth(adev, const int num_links, enum unit_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - adev -&gt; used for future IP =
checks as a dynamic internal speed constant setter<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - const int num_links -&gt; call=
er passes in constant link multiplier.&nbsp; So in this case KFD can pass b=
ack the num_links it finds from previous amdgpu_xgmi_get_num_links<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - enum unit_type -&gt; some enum=
 we can define in amdgpu_xgmi.h to give the back the caller whatever units =
it's looking for (GTs, Mbytes/sec, Mbps etc ...)<br>
<br>
Then this way:<br>
- KFD enforces min/max bandwidth to be consistent i.e. both are 0 or both a=
re non-zero<br>
- bandwidth call is now more general purpose and flexible and provides vari=
ous bandwidth return types by caller needs.<br>
<br>
Jon<br>
<br>
&gt;<br>
&gt; &gt; I'm open to adjusting get_num_hops &amp; get_bandwidth_mbytes to =
return either -<br>
&gt; ENODEV (device not found in hive) or -EINVAL (bad peer_dev request) on=
 a failed<br>
&gt; search.<br>
&gt;<br>
&gt; On a failed search, does returning 0 work - zero hop/bandwidth<br>
&gt; considered as no link found between the provided devices?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt; That would require a change to KFD CRAT logic to error return its=
elf on an error.<br>
&gt; &gt; However, this would change the behaviour of a bandwidth reporting=
 error where<br>
&gt; ROCm could still function, to the KFD not loading at all.<br>
&gt; &gt; Currently, the consequence of passing an incorrect peer_dev to th=
e bandwidth call<br>
&gt; would result in the ROCm Runtime not issuing an SDMA ganged copy i.e. =
potential<br>
&gt; peer-to-peer performance drop.<br>
&gt; &gt;<br>
&gt; &gt; Jon<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DRM_ERROR(&quot;amdgpu: failed to get xgmi num links between<br>
&gt; &gt;&gt; node %d and %d.\n&quot;,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;g=
mc.xgmi.physical_node_id,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_adev-=
&gt;gmc.xgmi.physical_node_id);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; /*<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; * TBD - will update IP based bandwidt=
h later.<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; * Bandwidth currently assumed to be x=
16 lanes x 25Gbps.<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; return (num_links * 16 * 25000)/BITS_PER_BY=
TE;<br>
&gt; &gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp; bool amdgpu_xgmi_get_is_sharing_enabled(struct amdg=
pu_device *adev,<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt;&gt; index d1282b4c6348..325e7972469d 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt; &gt;&gt;&gt; @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct=
<br>
&gt; &gt;&gt; amdgpu_hive_info *hive, struct amdgpu_dev<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_add_device(struct amdgpu_device *ad=
ev);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_remove_device(struct amdgpu_device =
*adev);<br>
&gt; &gt;&gt;&gt;&nbsp; int amdgpu_xgmi_set_pstate(struct amdgpu_device *ad=
ev, int pstate);<br>
&gt; &gt;&gt;&gt; -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *ade=
v,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt; -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev=
,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt; +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *ade=
v, struct<br>
&gt; &gt;&gt; amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt; +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_devic=
e *adev, struct<br>
&gt; &gt;&gt; amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt;&nbsp; bool amdgpu_xgmi_get_is_sharing_enabled(struct amdg=
pu_device *adev,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct amdgpu_device *peer_adev);<br>
&gt; &gt;&gt;&gt;&nbsp; uint64_t amdgpu_xgmi_get_relative_phy_addr(struct a=
mdgpu_device *adev,<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt;&gt; index 70b3ae0b74fe..a787d192390c 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&gt; &gt;&gt;&gt; @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_l=
ink_to_cpu(int<br>
&gt; &gt;&gt; *avail_size,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bool ext_cpu =3D KFD_GC_VERSION(kdev) !=3D IP_VERSION(9, 4, =
3);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; int mem_bw =3D 819200, weight =3D ext_cpu ?<br>
&gt; &gt;&gt; KFD_CRAT_XGMI_WEIGHT :<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_CRAT_INTRA_SOCKET_WEI=
GHT;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t bandwidth =3D ext_cpu ?<br>
&gt; &gt;&gt; amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kdev-&gt;adev, NULL, true) :<br>
&gt; &gt;&gt; mem_bw;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t bandwidth =3D ext_cpu ?<br>
&gt; &gt;&gt; amdgpu_xgmi_get_bandwidth_mbytes(kdev-&gt;adev, NULL) :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_bw;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * with host gpu xgmi link, host can access gpu memory =
whether<br>
&gt; &gt;&gt;&gt; @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link=
_to_gpu(int<br>
&gt; &gt;&gt; *avail_size,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (use_ta_info) {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sub_type_hdr-&gt;weight_xgmi =3D KFD_CRAT_XGMI_WEIGHT *<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi=
_hops_count(kdev-&gt;adev,<br>
&gt; &gt;&gt; peer_kdev-&gt;adev);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_get_hops_c=
ount(kdev-&gt;adev, peer_kdev-<br>
&gt; &gt;&gt;&gt; adev);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sub_type_hdr-&gt;maximum_bandwidth_mbs =3D<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi=
_bandwidth_mbytes(kdev-&gt;adev,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; peer_kdev-&gt;adev, false);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_get_bandwi=
dth_mbytes(kdev-&gt;adev,<br>
&gt; &gt;&gt; peer_kdev-&gt;adev);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sub_type_hdr-&gt;minimum_bandwidth_mbs =3D sub_type_hdr-<br>
&gt; &gt;&gt;&gt; maximum_bandwidth_mbs ?<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi=
_bandwidth_mbytes(kdev-&gt;adev,<br>
&gt; &gt;&gt; NULL, true) : 0;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_get_bandwi=
dth_mbytes(kdev-&gt;adev, NULL) :<br>
&gt; &gt;&gt; 0;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bool is_single_hop =3D kdev-&gt;kfd =3D=3D peer_kdev-&gt;kfd=
;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; int weight =3D is_single_hop ?<br>
&gt; &gt;&gt; KFD_CRAT_INTRA_SOCKET_WEIGHT :<br>
&gt; &gt;<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB780445C81DE6CB10E083174397FE2DS0PR12MB7804namp_--
