Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F349EC61DB6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 08:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E49010E169;
	Tue, 25 Aug 2026 08:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a3L21cNr";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013042.outbound.protection.outlook.com
 [40.107.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F5610E969
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 08:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er9mC1EjTikDPmCgJZJXDaofWHS97L/fG1pyAOHJ2bTtXkxnBGf9s+dksV1aEjm746bBtH/1bX8Z+OKg4ejMEDrpc8P45cCvbictLgf9vDTv/iUud+BdqV+6cv460577JKjWFlrbgJp8wmSDPFKAeFOi5SV1/At3jy2BKdU1Rq583tp93lM+GTYgHPZcoeiAxDE05/k0oPqQkENHKpRTdl88+Ycf+l6TkNkMCqSymTvT7kzvO+pDlONiUVAqqKOXCsRjeis6HZV3F9UzvAcNh12HGj0kUeslDjh1u7VH4tBhMqSSjVT8IKRbAj5TkJWo391CWSXOFCl3M7MaOJsp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhmyELKzbbUOVHWI/qX1BDOrwzSW2y+HOU/bM/wApgk=;
 b=HRFjHGakEXuzn0kCZ3cPW2LiJDKjhZtQCQtlv+RfFMZVD66oNCkW9tdWMt1nwcO3+2aaLz/8mORx9JBQ2+ynPeM3c5Qzb4Vh4hpAc9r1NkZeW/r8kR185YwrycRhr196FLstwDrbyB33CfpsfNaChHbv4OWF3fwpQ03T6c6rGVG/5Ht4lTZE30/BYbcIsE6Iiu0+Kylulj5DKEPwybMQZaTeFVA70z2s1TdYk5zhNm6glA4ENLnsaMrpgV9kQwosSQtO7P0E0atgt+u8YImm4w1HDDn7/GLZxt62FmS5Wll2SwYruJUbc3daoMz4lcFuCX0gwpEbwmsqST2tg/LHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhmyELKzbbUOVHWI/qX1BDOrwzSW2y+HOU/bM/wApgk=;
 b=a3L21cNraL1ZoxgilVl+qH5j/7i+pVI7OQL9mr1n3pJACoMkPjyghfMT6JZe9q3XMtqcq1ZuikxUejlddEAZraf2n0h/tTJFdoI/E3hqGDHiCAHpZchQZON3o51h6HktL8o56v3gvwNVB5Zo/r7sERyM/esyk/Fqx8Mw24GsMII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:17:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 08:17:46 +0000
Message-ID: <66dffb9e-559c-406e-8d09-b3165020efed@amd.com>
Date: Tue, 25 Aug 2026 10:17:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device
 padding for 32bit compile
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
 <CADnq5_MNFZfbvkgQ6JYjBZOb5+E+kezXDphFHshaaw7h7yVk0w@mail.gmail.com>
 <CH0PR12MB52689AE98C9044860F3FB914FFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
 <CADnq5_NL1vec9Xp=6EjUupmJb8DkkUu2dz44URLL5gf+f9bKxg@mail.gmail.com>
 <CH0PR12MB5268E3922230EB424FAEB36DFFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
 <CADnq5_On3OffA8-eqe7wmuhxmqafw_hd-uWN_DTttefyt8ATVg@mail.gmail.com>
 <CH0PR12MB52681EA03CE63F6935D08047FFA32@CH0PR12MB5268.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH0PR12MB52681EA03CE63F6935D08047FFA32@CH0PR12MB5268.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e147ee3-987c-4c87-2417-08df028157f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9Wh6DDUuad1bxsdvqo8A8gh4TjhBV1KQuU5lChUDXtu7dmp56/gSRjcfNv6rgBoWvkk4tZoJppskeaF5DzXD65mg3zMZDQPiv3mHkB00M+ZWb5lwA1aXqsUqw3GVUPJjuIlZk4IXnh0YplX4cgabY76yadTI6bOSwkBN0BOCrozqv/L7fNQ2lZ/RwXp8Ncn92xvCUiHJh0jyUEM/6pFzzelmV3KsNsklmmor8gkbY/Dth2M2yeoIIoQnLhXr2Dg5QWkw8JpGYzETwDT3fvocFS+kQVV2ft4GzD0hhWX9vdStpAFotEmVgPZSojfo3qIT7elpsp3JEUbD+jyfHT8wsehynOu5I9j9g4J3grWGH44q9xFxfhkiAYoFnkRbOH1pTEf36k3sUbPavqCBEwOOA3JMSCM2LNPNDY7pYmvWLU0CjnqLm19DI02xcqVMnYvWL48GvFTdssa0MvaXL+GYEspVFJu+yc/pLnfYghU9n4mka8Z8Xnsk0y2pVqnd/5TcmMGAE8Ncjm9qhP6WiJ5X77MDNDuB3Vvc5fBP5ouYVWLJcr1Hjvn74Q3+HlKOT8PJskNqfMY0EroBxlH1muhiLKadeiLDcvQBqRLQx7EhcqLQ3scze0e5lnPVTO0rJJfksYj5fPA40iX4i1qJ2nphgXHzV3uCMGf9YyetbDDbJPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRKY242bm50ekpVcGVnT1d0L1BwMGpHUlVBY2ZjWmlTeVl1QlJZUHBjQzl3?=
 =?utf-8?B?OEVLQktzNFg5RzRMU0lUelo0S0dTdGdUT3BLdlhTWVdEUG56M1E4U1hYZzVG?=
 =?utf-8?B?YmN4bENpNERucHk2aHhVdEs4L09QSWI4T3ZTM0hva3ZaYkpWa0N6d0NoV2FD?=
 =?utf-8?B?M2pLZEplRUZGRlR4UUhHNFZZQU5WNmtRYkZpNnNXTVFHQ081K1V0MnE2STh1?=
 =?utf-8?B?dkNvYVlJditLY3c3ZFRMUWw3LzBPMERmMk9halhVaUN6SHhpY2ZFazRTcDBV?=
 =?utf-8?B?MkJvdzlXRmxtVmhYMzFpVERlM0Z6YmRYMnd4eUdJOGh5RlZqcFhsUmVBWlIr?=
 =?utf-8?B?SW14UDN2WXRINGt5NEV4WUZZWHZvMFpHQWRaL2V4d2Y1eVZuRkVTYTRqOWhY?=
 =?utf-8?B?V0xNbjRtUmNrWlFvZVlWdXFrU2tOZVdDK0VjcW1ocFpBZUt6OWVWYXZPQjFl?=
 =?utf-8?B?SDZieHJ5MVdvdW5FVVhGQ1pWM1dodTR4a1phRXNlUjdOelh4WjdHME5KZmFs?=
 =?utf-8?B?dXJtWUc0S0VjYWkrVXppNXkxU25vZEM2ZTF2T3p6REs5eE4rTFk1SGV4VDY3?=
 =?utf-8?B?RnFCSWpTU1pSTGZ2VUJxSmVvYXljRG16cFF6ZkdNY3d3bWFpMmo1ZlFoUGVw?=
 =?utf-8?B?NzBIN0xVUFA1bzQrbTRYTklnZTNvRmk5aFNJVWdoMnJ3cUN0WkVQeGd3WFdX?=
 =?utf-8?B?SE10SklVeGo2RkVkNlpUQW1xRWNjYTJJQWxQRGRLczRocjFpTkI5czJtMEhZ?=
 =?utf-8?B?bmUrcitGcko3Rnd6VmttK1dUTmlEWkhTWkQ3RjdNcFJGWHNuc3VEM21uVlRJ?=
 =?utf-8?B?b3dPbTI3L28walhSQksvNXN2MlJHc1NYbXNHcGxNd3h5emFaSEZzVnpGd2Jw?=
 =?utf-8?B?UkFCckxOOG95WmNxY1dsdTlsT1hLSy8yejZjdkJLaHgvZkdObHQybjlzdG5D?=
 =?utf-8?B?WHh3TldmNG9XQmJlcVhKMjNGOE93T3VhMi9SRjhONGNMZFFqbGYxR3g5Qm43?=
 =?utf-8?B?VEx4d21sTVliYjJaa1MrQndhYklvc1U2TDc0UzJHQyszOE5LMzcxdFVPbWFu?=
 =?utf-8?B?K2dUUFN0VkN6RFgvSjNpWlRoRmFzS0piT2wzVTI1bWxXeTYyRlBiRXNPZ2dF?=
 =?utf-8?B?WUZBMm8rc1VqcER6MkgzcTc1MitFS2ZSOUd6MUVSRjdrbTZlQ0JjRDQvTjFn?=
 =?utf-8?B?WlZtSE4xZFJCL080M1FhSW1DNzhnQ1N1c1FBTTJRM1dOMHJPWEcyazF6OGc5?=
 =?utf-8?B?YjBEMDRHOHNUWEJZSmpERVlxRUFOSzduMElya2hEZVorTnA2dFl4RjBhQnpo?=
 =?utf-8?B?R2gvN3BNaVNaQmRHUUsxNkU4Y0xqZ3JMMmFTOS8xRVY1UFRYWWJpM1ovaUdt?=
 =?utf-8?B?VlhWWWZPRml5QWthcFZuZUFHSFdWR0ZJR3dTQ1Y3cEJMN0hOc3RkS0hvcGpI?=
 =?utf-8?B?Nm1OZ1QvSzV3NzNwR2VyS1pabE8wL1dDalBNbHNabGRhS3BWYWxwV25qTVJp?=
 =?utf-8?B?N3FmTFB2SUN4TTR1VTRPMmpnWWdBVEdIVnVUdktxS1Zkanh4cXVOa2xiZjg4?=
 =?utf-8?B?ZkRCL0g5R1Q2eldiZGdoT0NkcDllZ0ROTnFqcHpZUXBOcE9NbmFYdXJrV29Y?=
 =?utf-8?B?QndiakJkdmVMSVhzeDFhaGRmR1dFNE0zQ3Y2aDlLQVVKSFZYMnJ4dmR1OUl6?=
 =?utf-8?B?ek5TMzFrNHk0Rm56R2ZpMEVBL0N6d1U5VDBQSHRWcHRGd01YZ0o1QUlCbkNy?=
 =?utf-8?B?amZWcWhsa3RoU3BlV1NsM25ZQUpxTUhPblNOTHBSajJSS1JzZDlEWXpqS2x5?=
 =?utf-8?B?V09kcDg1VnRDanM1VVpmemh6a2xHdUhFczVRUTBlUmpHa0Z0VjdVQXVLdURJ?=
 =?utf-8?B?OFFzUDM1K3hrN09weTRYelFjWXpOK2pvWjJNRisxQjNHL2x3OXVQYzlCY0Zw?=
 =?utf-8?B?a2hTQThoMW9lU0FDdnBKc1pFK3V5K2gvM3BTeFJIekFuQkpxektUcWk1aUtw?=
 =?utf-8?B?bkNmWnNKQy8yMlMwK1JjZmlnd3lHWGVIRXVad0FuU2h0MUNxUEdOa0krUGMv?=
 =?utf-8?B?cE0raWh3OUcrR2UzeUZ2aXhueUZtQU1meDBnUUErNFBoSnluSTZIRjUvNkdU?=
 =?utf-8?B?SmRPNU5KQUt2eVZUa2o4V1JNK0lwVmtTdC8vOEtmcDBLS0VtVmVYZ2FKYkNm?=
 =?utf-8?B?YTY1K0RrQmR0ck4xUFprR3ptMkFsOXkzNmNocllwR1JNTkl0aWxWb2pWVXdx?=
 =?utf-8?B?VkpueWZIaEhDMTB2OGl3U3VaNFczb1g3OGRWd3VSdjdiNkhDYXpsU1FSWWNu?=
 =?utf-8?Q?pfSjM4YuDIsohp4yQT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e147ee3-987c-4c87-2417-08df028157f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:17:46.2675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gom2Uv+iI5JwDsJjN+smhQPb2S35bL72uVgz0DsAyOyd2yBiUqKVedMzugBfhHqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

Hi guys,

if it looks like this means that the UAPI is broken since:

commit cf21e76a6005016474623a375ae2e90364a02168
Author: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
Date:   Tue Sep 24 17:53:25 2019 -0400

    drm/amdgpu: return tcc_disabled_mask to userspace
   =20
    UMDs need this for correct programming of harvested chips.
   =20
    Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

It's just that nobody really noticed.

*sigh* this is exactly one of the reasons why I don't wanted to extend the =
drm_amdgpu_info_device structure. If I'm not completely mistaken we have me=
ssed things up massively now.

This currently works with 32bit kernels / 32bit userspace and 64bit kernel =
/ 64bit userspace, but breaks as soon as you have 64bit kernel / 32bit user=
space combination.

We have now the choice to apply this patch and essentially break 32bit kern=
el and 32bit userspace combination or use some other hacky workaround.

Alex and Yogesh let's discuss that on my Thursday meeting.

Regards,
Christian.

On 8/21/26 05:51, Mohan Marimuthu, Yogesh wrote:
> AMD General
>=20
> Hi Alex,
>=20
> With 32bit Kernel + patch and older userspace will be broken. It will nee=
d userspace to be recompiled.
> The current situation is "64bit Kernel + 32bit userspace" already broken.=
 It can be said that the current Kernel "struct drm_amdgpu_info_device" is =
broken.
>=20
> Though "64bit Kernel + 32bit userspace" is already broken but it has not =
been noticed until now, it was noticed with userq_ip_mask variable retuning=
 zero.
>=20
> I think we have only two options,
>=20
>  1.
>     Probably "32bit Kernel + 32bit UMD" combination is not used and hence=
 picking this patch might not trigger any compatibility issue.
>  2.
>     Create AMDGPU_INFO_DEV_INFO_2 version 2 for DRM_AMDGPU_INFO ioctl to =
pass the fixed data structure, but this would keep the older structure that=
 is already broken still broken.
>=20
>=20
> Thank you,
> Yogesh
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *From:* Alex Deucher <alexdeucher@gmail.com>
> *Sent:* Thursday, August 20, 2026 11:00 PM
> *To:* Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_devic=
e padding for 32bit compile
>=20
> On Thu, Aug 20, 2026 at 11:28=E2=80=AFAM Mohan Marimuthu, Yogesh
> <Yogesh.Mohanmarimuthu@amd.com> wrote:
>>
>> AMD General
>>
>> Hi Alex,
>>
>> I am not changing the layout.
>>
>> For 64 bit gcc, default alignment for __u64 is 8bytes.
>> For 32 bit gcc, default alignment for __u64 is 4bytes.
>>
>> For 32 bit gcc, I have manually padded 4bytes so that it is 8bytes align=
ed for __u64. This will make 64bit kernel compatible with 32bit mesa compil=
ed using gcc.
>>
>=20
> Won't this break 32 bit kernels?
>=20
> Alex
>=20
>> Thank you,
>> Yogesh
>>
>> ________________________________
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Thursday, August 20, 2026 8:51 PM
>> To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuch=
er, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koe=
nig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device=
 padding for 32bit compile
>>
>> On Thu, Aug 20, 2026 at 11:18=E2=80=AFAM Mohan Marimuthu, Yogesh
>> <Yogesh.Mohanmarimuthu@amd.com> wrote:
>> >
>> > AMD General
>> >
>> > Hi Alex,
>> >
>> > In 32bit mesa, I did not get the correct userq_ip_mask value.
>> > I checked for variable alignment and tcc_disabled_mask was not on 8 by=
te alignment. This patch fixes it.
>> >
>> > Can you please tell how it would break UAPI. What did I miss.
>>
>> You are changing the layout of the structure that existing apps expect.
>>
>> Alex
>>
>> >
>> > Thank you,
>> > Yogesh
>> >
>> > ________________________________
>> > From: Alex Deucher <alexdeucher@gmail.com>
>> > Sent: Thursday, August 20, 2026 7:23 PM
>> > To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
>> > Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.K=
oenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> > Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_devi=
ce padding for 32bit compile
>> >
>> > On Thu, Aug 20, 2026 at 12:55=E2=80=AFAM Yogesh Mohan Marimuthu
>> > <yogesh.mohanmarimuthu@amd.com> wrote:
>> > >
>> > > need to pad before __u64 tcc_disabled_mask variable.
>> > >
>> > > Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com=
>
>> >
>> > This will break UAPI.
>> >
>> > Alex
>> >
>> > > ---
>> > >=C2=A0 include/uapi/drm/amdgpu_drm.h | 2 +-
>> > >=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu=
_drm.h
>> > > index 0a113529b..5beef3eaa 100644
>> > > --- a/include/uapi/drm/amdgpu_drm.h
>> > > +++ b/include/uapi/drm/amdgpu_drm.h
>> > > @@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 high_va_max;
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* gfx10 pa_sc_tile_=
steering_override */
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 pa_sc_tile_ste=
ering_override;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 pad;
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* disabled TCCs */
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 tcc_disabled_m=
ask;
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 min_engine_clo=
ck;
>> > > @@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 csa_alignment;
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Userq IP mask (1 =
<< AMDGPU_HW_IP_*) */
>> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 userq_ip_mask;
>> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 pad;
>> > >=C2=A0 };
>> > >
>> > >=C2=A0 struct drm_amdgpu_info_hw_ip {
>> > > --
>> > > 2.43.0
>> > >

