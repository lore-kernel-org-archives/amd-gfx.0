Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A460E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 17:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FC510E0D1;
	Fri,  3 Jan 2025 17:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+K3vrIJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3545A10E07F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 17:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwVbG+e41q/3svvEOlQNSZYjNsSXpkoBtToOye5sFjhOMp3V7B1bV69Nxrefn0E6TC6ysPDln++PWiDe5FxRFN/Jlfn/3b9HslBuoJvS7NM+tLM4dfAFKP6zIVI8xTrUdH86+EnZ4tIesyC8r86a3T2STuIsHlvGWFJ9+ugHH7E/9GwlEq5DoY96ua8X7KctGDo7DtkZy/x3FXXUJpa7HjnwB5/qdZZ1PjW+nNmyePD23iWKoK/EpWc2ORzUKKdjZtmGjPflqh3vqbVdTE8gADSlUjNRWhn3UDSzypB/sK7vm1v+o9rjBsO1pD0+2cbIywS6RL61Z2gCRv7GvlH9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5PqysU11AHP8aVao+nIIichOU0RLTVbklfJsbktVYw=;
 b=STBgH4Wp46dkDYdQHkIryyLDZ+h1cSyAzc2H6BuKxoedTH+NazW1TzO1yfsviSfsxwD4e10JFvFYXdo7dg+TM07Vl5VtE826Z0WX71r5GmW0mXTqdKlPJuncTFxMLpJwa1okMEQW4PLAo6CLk0a7WMO2f5L0PhObY4o+qBDFz/2hB+4wGVoG5N7cSLtudO41SF6SvsYues+cXTEUbVcAMe9uYPuTVxYIiGjeOsnuJ230ksdZnXZfurEqXzP6tPvw4qVhHxLe1q1wVlTcBRoAQZcODfuxKu+7tLbiG2dmIIXMWyp9kqo98LqB/aadodvp2YB/xqSNnfD3kgk/HJYF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5PqysU11AHP8aVao+nIIichOU0RLTVbklfJsbktVYw=;
 b=E+K3vrIJ2/JpzE67xTSao67bxCJMergRE+ogdSFjV30BiFoY1MoNOE87Ncbav+3s04wD+I61Rln/EjPcPVvqPZz9ai4lCBJE4r1v/E1zLkTjLjDPX9kEVBYSAD0j1JvOy5Q1y47zHs72YUCnY7HTFMZtnLrEF+2t4xyWd2/kVFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.13; Fri, 3 Jan 2025 17:33:46 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 17:33:46 +0000
Content-Type: multipart/alternative;
 boundary="------------w90a0Xd15hqzLsG7zli0krK3"
Message-ID: <dee6125c-8c9f-4872-a57f-036f88f091c3@amd.com>
Date: Fri, 3 Jan 2025 11:33:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] amdgpu: fix invalid memory access in
 kfd_cleanup_nodes()
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com>
 <b835ec1b-f40b-4abb-8267-934a0e497415@amd.com>
 <3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com>
 <c7a76b1e-fabb-47be-8408-4505ddc1296f@amd.com>
 <DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com>
 <cf334b81-87eb-4d19-bf03-e11ab06d8ec1@amd.com>
 <F7876602-343C-44AE-AE5A-A0D69BE8B8A8@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <F7876602-343C-44AE-AE5A-A0D69BE8B8A8@linux.alibaba.com>
X-ClientProxiedBy: SA0PR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:806:d2::22) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef7a181-77bc-4e30-f536-08dd2c1cc68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVVrU0RvNE1DZVlaQ1ZPZXdrZHFiRnpNTERDYjNrejMrRDExWTdtYk1NRFZa?=
 =?utf-8?B?ZmNjYnZlSm90NU9BTEgramJGTUEyVDlwdlNmMHNJampnaEZFS0FSbkpMOENO?=
 =?utf-8?B?dWFIN0FBeUlSYzNuUmdZcUFubXNlb2NLTjNjc3RicHJNZ2JYaE1SNUJxaEZy?=
 =?utf-8?B?YTFJU2ZuTTEzb1owN3lGWmJtVU4vY3dPTUczczRQZTA1eldVb3ZlL0NoL2Ft?=
 =?utf-8?B?UHFoelh0eEl3TFc1WkluWStyU2tzd01IMGFPSW5ZMVB1TnNEWkdodWhYWXRk?=
 =?utf-8?B?L1ZKU1dsMnA1TERpSE94V0l5alZlRGNSellGdXlJNUk0d1NwOW1qWnJzelpT?=
 =?utf-8?B?OGhSZEdhQlVhbENSRUcyOVU2OU1iYXhHSEgzUmpIRHZJcmJRaEJ3VXNNSlJ5?=
 =?utf-8?B?cnVnZnA2MCtlcnQycXhhOXJ2UWc3SnM1Y2lqM04zc3BBWWV1K2VSb2RsR0dC?=
 =?utf-8?B?dU9kL2oybFRudXdsL1kvSlFsa1F5Y0tkV3N3c3VKQzBYQlVUWE1Lei9MNTVy?=
 =?utf-8?B?N3dUb20rcVdza1VoQWVvRjNhY1paaTczL21UYzMya0oxejFqa05MbTB4NmtQ?=
 =?utf-8?B?NXM5MU5US3JKL1JVU3FoVytXelFXV2g5SjN3NUtXVVBJb2JVM1FYbWhFOTFz?=
 =?utf-8?B?d0VDRVJSamtaellkd2pPbWRaL1VGa0tzU1dJSW1hZkRZTkxDK3FvV2wwZUUw?=
 =?utf-8?B?SzNFZ1pXS2Y1aVd6SkpDaXhMQTdiVFB3SkI1b29lQms1MTkvSzQ4cWFNeHdr?=
 =?utf-8?B?MzNucEJqNERiUndrRGlESE5qdVF2NTh2UFVhVVFHL2lqUG1iZ1ZIM0RBN1Yr?=
 =?utf-8?B?cEJZSnFYWGhyeFZkVElCMWp5bXBYT0pUdm9rVXF2OVhBQ3gzZDFLTmptc0py?=
 =?utf-8?B?YUhCNUNWMWd5OVpreWxSYm5uTFJYTHNzWVR2ZkFvQ3gzZml4SmlONnY5T24v?=
 =?utf-8?B?ZHBoNG90T2g4YkViWXJ6K2V3TCtFaG8rLzJ6cEtQbS94MkJKeDU4OCtuZThR?=
 =?utf-8?B?d3dHc1lUenhNSTBRTktFbjdFcm84Tmg1U3FCRkRkcjlmc09NVy9FcEdJTTBC?=
 =?utf-8?B?bTQ3NWJCd3lWUUNzNUtkYm9wWGMvaWMzOHFjVWFBc0lNeEw3TTN0QTExR1JC?=
 =?utf-8?B?Qk94eVZzQk1PTis5dkdmNTNybGxDeFlXcWtlYjVRblhTYTk2YjdnRmZ2WGxi?=
 =?utf-8?B?VXltYzhzb1IzK0dFSktXbnNkL0RFSm12cVk1NWpsWmcreExtMWRwRDRObXg1?=
 =?utf-8?B?WmhOci9UOU1JV1MwcjNheG01WG54Njg2N2FBaXFRZHhHbzJ3MnYwbENMR0VG?=
 =?utf-8?B?ekJ5R3ZxWEdsTkc0V0NiSWV0WkU5UGd6cDBNV1NveTBteEhqVldqdkRjTXRC?=
 =?utf-8?B?VUU3OG41Q2RESUtYOXZwcUN1eHNlNkhrTFN6cXN1L1lKSWRyQWZ3VUtCb0J2?=
 =?utf-8?B?M0kxbnFZRWpEdk9EdEhnU3VBT0VzUkxycTJUTmpXQW1PakxDS0ExRFUyTm5k?=
 =?utf-8?B?SEJUY2o3STdzd0ozaUZrWkh2cWdZcG9ZYVpFYjJrdDZYRFpETDhOSDZITlYy?=
 =?utf-8?B?Y3VLV3pOUG5rM1NCamJiSFQySWRtTVp5YllxVWxmTk1ta0sxNVZUQUtIYlRX?=
 =?utf-8?B?YUs3RjJ0UEl3ZGo1dHhrNTZZNkV2NUZLTXVSTU83WFUzR2tGUkd2Z0R4dENr?=
 =?utf-8?B?VmhDWXFXUlkwQnRtWEJkaVJtZkR6UUc4dGI1NjhqbE13aHpGRXBWdGtEVHdD?=
 =?utf-8?B?eGNJTCtacmNPcXFPTnFSMnBLLytvT0c4S3ZUSzZhc3h0MUh3V0hCaEN5Q0RP?=
 =?utf-8?B?djVqZmVVeXJsNjVvbjF4U2UvS29xM2RvN1R2a25NWHZXVFRnR2s5VXltZjVX?=
 =?utf-8?Q?tKcOGcpcItO/y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEl2djVjSUxQZkJKdk50NnEwWUpKUTJuQlU2Tm0zcXRydVBmQUs3YUYxTHo2?=
 =?utf-8?B?OEIvOHJuZ3Fia1ZRSjhBWDZQL1VNa0NRNkhWREhHd3UreGJJQ3NxMmNhTlNn?=
 =?utf-8?B?Y2lZc0VaZUN5dml2TGpZMGhEc1BuOUNXTStJUUdTYkJ5aU5neXFlcVZiVjgw?=
 =?utf-8?B?dENjVlJDQkwwVjNWWWx1b1IrenRRc29wK0oxaGtlaHFyYUtuYk9yYWhQcjN3?=
 =?utf-8?B?c1JKU3dSc1FqdTFtZFRFK1FpZTR2bkl2TGtkWDBiRlRXQXNFdEZLN1NFZWZV?=
 =?utf-8?B?eTlReHRtbFdFV0MxcDdrYW51UTlBVWlKZHUwb3FQZVRwK1J5S0lTQ0RaQ3VX?=
 =?utf-8?B?ajVnc2FsVmNsdSt4VWZRejJrcXM2ZlJJM1lLQVJQV0k4N2loS1R4V3hUVm8v?=
 =?utf-8?B?VEJvR21SR0FtdTd5UUVYMzg0Z3BRRE5lNHB4b2dpZmEwM1ZDaVZEbktMR0k0?=
 =?utf-8?B?c3VWZW5mcEx4Q1NWcFBiLzZYTGtxM3ZlTFdpaGJONVp6L3Q2MC9Vd2ZBNmc0?=
 =?utf-8?B?Y0Z1V21MS3hPMnY2UnJBOHV3RDNqdVRaOWNUZXh3MTR6MUo1Yy80Y1lyVlo2?=
 =?utf-8?B?RmFCdlVvdmRTNzJZWEFxandWcE5CbTZlVXpyWDcwWHNhWGQ5R1NscGFTU0xM?=
 =?utf-8?B?QURHSDhlVDlPTDRRdGpHc0tJSVB1WHBiTjJBN1h5UVNRZ0Njc1ZscG9Jbmo0?=
 =?utf-8?B?ZG9BS3BSWUZ1a1BaQWRpZjZsbUxCaEpoYXZta1IzZEJTZ1ZOL0FZT3BuNnRw?=
 =?utf-8?B?Ulo0eDJaL2lkclhXdlVvVDZ0MHU1dUFocmJGTHVlMldBRjRlYmVnRWUyMjlT?=
 =?utf-8?B?dUU1MkwwQkhUaWZZaXZVRzdhTlF2OUIyZWRWWjNXbTh1OGNFYjBqQUhUQkxK?=
 =?utf-8?B?NlZCNmJCNHExNGp0Mk03YjFEMllVeWhUTnNDaTY5NDNqd3pFb3J0UlRuTTFP?=
 =?utf-8?B?TWkrN0x2T1FmTXBtM3pCeUlITVBZL2x2U205b1BYWktiUmV5MTg4a2NSK0U5?=
 =?utf-8?B?d29Idi81OU9GNkdHOCthR1MrY1VTQzZCYzVSdTZ3S3pCWEdhVnU2WituajNE?=
 =?utf-8?B?Y1ZGL2NseHdPZWZWYlIwV1JldGZXcWVhcGhpQ3pYQUZBZEdzeTE3SXVoTUIx?=
 =?utf-8?B?SU41cUlMaC84bmg2cGpSUXQ3dlYyaFdLT20vN1hVbVE2T1dNeGN4MzJMa0VL?=
 =?utf-8?B?VFZjUzhlS1JDWldXNGM2emVIMXIrdVNubWQxZGY1eFlEWUFycXJNSytUWjUz?=
 =?utf-8?B?VGVPSTM1bTNnN1EwSDlFMFFIemRBcHJRYnJsODI5TTZwaGxjNE5mL3dOanMw?=
 =?utf-8?B?Q2NUY2pqdEE0ZnJhMUtaclhIc3ZKSHZGTUJId3Q0STN0UjR2M2kvUzJFL2tr?=
 =?utf-8?B?RVdsY01RcTcyVjBnQWRFdmQ0UXZmQ0NBUzhqUWplRXNSbDl5UWNEOTJQSGoz?=
 =?utf-8?B?dmoxTWsxZjBhdlZ2dVBGbDFlLzNrREtpN2N2S0lxTXAzU3lQWGxEbEUxaGM0?=
 =?utf-8?B?Y3pFU0pmZFpPV09XYnBwejk5NkhjanlmOVdaeWgybkUyYjlhbzVwM1VQbkRF?=
 =?utf-8?B?cjQ2Z3krVlhkUFhOU1JRV1VlZzIvYStYQy9VcHlzWGg5N293dTRTeDVuRStk?=
 =?utf-8?B?ZjB6WUp1SktlSURmWHI3Q0Y2WGlVMmIyS1JIY0M2MGk3eDZkcEt2MFBxSFVZ?=
 =?utf-8?B?WUtRT2ErWEVtRVJqdmRrWlJ3VndldStURDNVdFkrZDFkTEYrakpMT3RnNjB6?=
 =?utf-8?B?QTJ2UHBrMlZmRElCZThUbExIVVlRWDcxTUt6b3JNSTdoYThnVmRKMHowbGJq?=
 =?utf-8?B?OFNTbFFuSiszUEo0dncyOGZJRUNmNHpNN1hFazVJanlFd1JCenNIVVBuV0xy?=
 =?utf-8?B?VFZoL1pmQlp0U241VGhkeGdSb2RKMVRPRFpWTXpHcE1YdzQ4MTl4Q2lKN2tj?=
 =?utf-8?B?U3RWYmVEelZ4QkYyZ0czc2VLZXY4VW9KM1h5L2VOVHpGd1dMY3p0dmZoby9l?=
 =?utf-8?B?MU1VOXU0SGxCNTZZbjRRdGM4MGY5V0lVRDIyUFZ0alVEWEdURlhHZ0d4byt6?=
 =?utf-8?B?cUdOQXhGbUtFaWVHeW81ZFI1dkVFbFBHemczWFl0Tndjdyt4Z3RoNzJDaXBj?=
 =?utf-8?Q?el9c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef7a181-77bc-4e30-f536-08dd2c1cc68b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 17:33:46.0301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4QiiGK5/euNLgsVnccB+5FKDone6Oe0JlbZI9PaMW3Gdv6WOpHAdkgAIBqCm/fO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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

--------------w90a0Xd15hqzLsG7zli0krK3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/3/2025 1:05 AM, Gerry Liu wrote:
>
>
>> 2025年1月3日 14:19，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>
>>
>> On 1/2/2025 11:55 PM, Gerry Liu wrote:
>>>
>>>
>>>> 2025年1月3日 13:44，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>>>
>>>>
>>>> On 1/2/2025 8:22 PM, Gerry Liu wrote:
>>>>>
>>>>>
>>>>>> 2025年1月3日 07:08，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>>>>>
>>>>>>
>>>>>> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>>>>>>> On error recover path during device probe, it may trigger invalid
>>>>>>> memory access as below:
>>>>>>> 024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
>>>>>>> 2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
>>>>>>> 2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>>>>>>> 2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
>>>>>>> 2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
>>>>>>> 1f 44 00 00 55 <80> bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
>>>>>>> 2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
>>>>>>> 2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
>>>>>>> 2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
>>>>>>> 2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
>>>>>>> 2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
>>>>>>> 2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
>>>>>>> 2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
>>>>>>> 2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> 2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
>>>>>>> 2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>> 2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>>>>>> 2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
>>>>>>> 2024-12-25 12:00:54 [ 2703.935444] Call Trace:
>>>>>>> 2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
>>>>>>> 2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
>>>>>>> 2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
>>>>>>> 2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>>>>>> 2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
>>>>>>> 2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
>>>>>>> 2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
>>>>>>> 2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
>>>>>>> 2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
>>>>>>> 2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
>>>>>>> 2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
>>>>>>> 2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
>>>>>>> 2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
>>>>>>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>>>>>>>
>>>>>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> index b6c5ffd4630b..58c1b5fcf785 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> @@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
>>>>>>>   
>>>>>>>   	for (i = 0; i < num_nodes; i++) {
>>>>>>>   		knode = kfd->nodes[i];
>>>>>>> +		if (!knode)
>>>>>>> +			continue;
>>>>>>
>>>>>> I wonder how knode can be null here? kfd_cleanup_nodes is called 
>>>>>> by kgd2kfd_device_exit under condition if (kfd->init_complete). 
>>>>>> kfd->init_complete is true only after all kfd node got 
>>>>>> initialized at kgd2kfd_device_init. If kfd driver init fail 
>>>>>> kfd->init_complete would be false, then kfd_cleanup_node would 
>>>>>> not get called.
>>>>>>
>>>>> Hi Xiaogang,
>>>>> It may get triggered on error handling path of 
>>>>> ‘kid2kfd_device_init()`, when it jump to label `node_alloc_error` and
>>>>> then call `kfd_cleanup_nodes()`.
>>>>>
>>>> If it was the case kzalloc failed. That means there is no memory 
>>>> available even to allocate struct kfd_node. From the backtrace the 
>>>> general protection fault happened at
>>>>
>>>> RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
>>>>
>>>> It happened during driver module got released, not init time. I do not see how the patch is related to the issue you talked.
>>> Aha, it’s caused by another bug which got fixed by "[PATCH 4/6] 
>>> amdgpu: fix use after free bug related to amdgpu_driver_release_kms()”.
>>> Without the fix in "[PATCH 4/6] amdgpu: fix use after free bug 
>>> related to amdgpu_driver_release_kms()”, kgd2kfd_device_exit() will 
>>> got called
>>> twice in case of device probe failure. I caused me some time to 
>>> figure out the double free issue.
>>> Actually we should reset kfd->init_completed to false in function 
>>> kgd2kfd_device_exit().
>>
>> We can set kfd->init_completed = false at end of kgd2kfd_device_exit, 
>> but how kgd2kfd_device_exit was called two times? is there another 
>> bug caused that?
>>
> I guess it caused by another bug related to the way amdgpu cooperates 
> with the amdgpu_xcp driver. It would be better to enhance amdgpu_xcp 
> driver either.

kfd driver has considered which kfd nodes got initialized and release 
them accordingly. From what saw here seems you may mix different issues 
or not target the real issue. Let's have backtrace match the changes.

Regards

Xiaogang

>
>> Regards
>>
>> Xiaogang
>>
>>
>>>
>>>> Regards
>>>> Xiaogang
>>>>
>>>>
>>>>
>>>>> Thanks,
>>>>> Gerry
>>>>>
>>>>>>
>>>>>> Regards
>>>>>>
>>>>>> Xiaogang
>>>>>>
>>>>>>>   		device_queue_manager_uninit(knode->dqm);
>>>>>>>   		kfd_interrupt_exit(knode);
>>>>>>>   		kfd_topology_remove_device(knode);
>>>>>>> @@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>>>>   		kfd_doorbell_fini(kfd);
>>>>>>>   		ida_destroy(&kfd->doorbell_ida);
>>>>>>>   		kfd_gtt_sa_fini(kfd);
>>>>>>> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>>>> +		if (kfd->gtt_mem) {
>>>>>>> +			amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>>>> +			kfd->gtt_mem = NULL;
>>>>>>> +		}
>>>>>>>   	}
>>>>>>>   
>>>>>>>   	kfree(kfd);
>>>>>
>>>
>
--------------w90a0Xd15hqzLsG7zli0krK3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/3/2025 1:05 AM, Gerry Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:F7876602-343C-44AE-AE5A-A0D69BE8B8A8@linux.alibaba.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">2025年1月3日 14:19，Chen, Xiaogang &lt;<a href="mailto:xiaogang.chen@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">xiaogang.chen@amd.com</a>&gt;
            写道：</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <div class="moz-cite-prefix">On 1/2/2025 11:55 PM, Gerry
                Liu wrote:<br class="">
              </div>
              <blockquote type="cite" cite="mid:DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com" class=""> <br class="">
                <div class=""><br class="">
                  <blockquote type="cite" class="">
                    <div class="">2025年1月3日 13:44，Chen, Xiaogang &lt;<a href="mailto:xiaogang.chen@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">xiaogang.chen@amd.com</a>&gt;
                      写道：</div>
                    <br class="Apple-interchange-newline">
                    <div class="">
                      <div class="">
                        <p class=""><br class="">
                        </p>
                        <div class="moz-cite-prefix">On 1/2/2025 8:22
                          PM, Gerry Liu wrote:<br class="">
                        </div>
                        <blockquote type="cite" cite="mid:3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com" class=""> <br class="">
                          <div class=""><br class="">
                            <blockquote type="cite" class="">
                              <div class="">2025年1月3日 07:08，Chen,
                                Xiaogang &lt;<a href="mailto:xiaogang.chen@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">xiaogang.chen@amd.com</a>&gt;
                                写道：</div>
                              <br class="Apple-interchange-newline">
                              <div class="">
                                <div class="">
                                  <p class=""><br class="">
                                  </p>
                                  <div class="moz-cite-prefix">On
                                    1/1/2025 11:36 PM, Jiang Liu wrote:<br class="">
                                  </div>
                                  <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com" class="">
                                    <pre wrap="" class="moz-quote-pre">On error recover path during device probe, it may trigger invalid
memory access as below:
024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
1f 44 00 00 55 &lt;80&gt; bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
2024-12-25 12:00:54 [ 2703.935444] Call Trace:
2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com" moz-do-not-send="true">&lt;gerry@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b6c5ffd4630b..58c1b5fcf785 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 
 	for (i = 0; i &lt; num_nodes; i++) {
 		knode = kfd-&gt;nodes[i];
+		if (!knode)
+			continue;</pre>
                                  </blockquote>
                                  <p class="">I wonder how knode can be
                                    null here? <span style="white-space: pre-wrap" class="">kfd_cleanup_nodes</span> is
                                    called by kgd2kfd_device_exit under
                                    condition if
                                    (kfd-&gt;init_complete).
                                    kfd-&gt;init_complete is true only
                                    after all kfd node got initialized
                                    at kgd2kfd_device_init. If kfd
                                    driver init fail&nbsp;
                                    kfd-&gt;init_complete would be
                                    false, then <span style="white-space: pre-wrap" class="">kfd_cleanup_node would not get called.</span></p>
                                </div>
                              </div>
                            </blockquote>
                            <div class="">Hi Xiaogang,</div>
                            <div class=""><span class="Apple-tab-span" style="white-space:pre">	</span>It may get
                              triggered on error handling path of
                              ‘kid2kfd_device_init()`, when it jump to
                              label `node_alloc_error` and&nbsp;</div>
                            <div class="">then call
                              `kfd_cleanup_nodes()`.</div>
                            <div class=""><br class="">
                            </div>
                          </div>
                        </blockquote>
                        <p class="">If it was the case kzalloc failed.
                          That means there is no memory available even
                          to allocate struct kfd_node. From the
                          backtrace the <span style="white-space: pre-wrap" class="">general protection fault happened at </span></p>
                        <pre wrap="" class="moz-quote-pre">RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]

It happened during driver module got released, not init time. I do not see how the patch is related to the issue you talked.
</pre>
                      </div>
                    </div>
                  </blockquote>
                  <div class="">Aha, it’s caused by another bug which
                    got fixed by &quot;<font face="PingFang SC" class=""><span style="" class="">[PATCH 4/6] amdgpu: fix use
                        after free bug related to
                        amdgpu_driver_release_kms()</span><span style="caret-color: rgba(0, 0, 0, 0.85);" class="">”</span><span style="" class="">.</span></font></div>
                  <div class=""><span style="font-family: &quot;PingFang SC&quot;;" class="">Without the fix in &quot;[PATCH 4/6] amdgpu:
                      fix use after free bug related to
                      amdgpu_driver_release_kms()</span><span style="font-family: &quot;PingFang SC&quot;; caret-color: rgba(0, 0, 0, 0.85);" class="">”</span><span style="" class=""><font face="PingFang SC" class="">,
                        kgd2kfd_device_exit() will got called</font></span></div>
                  <div class=""><font face="PingFang SC" class=""><span style="caret-color: rgba(0, 0, 0, 0.85);" class="">twice</span><span style="" class="">&nbsp;in
                        case of device probe failure. I caused me some
                        time to figure out the double free issue.</span></font></div>
                  <div class=""><span style="" class=""><font face="PingFang SC" class="">Actually we should
                        reset kfd-&gt;init_completed to false in
                        function kgd2kfd_device_exit().</font></span></div>
                </div>
              </blockquote>
              <p class=""><font face="PingFang SC" class="">We can set </font><span style="" class=""><font face="PingFang SC" class="">
                    kfd-&gt;init_completed = false at end of </font></span><span style="" class=""><font face="PingFang SC" class="">kgd2kfd_device_exit,
                    but how </font></span><span style="" class=""><font face="PingFang SC" class="">kgd2kfd_device_exit was
                    called two times? is there another bug caused that?</font></span></p>
            </div>
          </div>
        </blockquote>
        <div>I guess it caused by another bug related to the way amdgpu
          cooperates with the amdgpu_xcp driver. It would be better to
          enhance amdgpu_xcp driver either.</div>
      </div>
    </blockquote>
    <p>kfd driver has considered which kfd nodes got initialized and
      release them accordingly. From what saw here seems you may mix
      different issues or not target the real issue. Let's have
      backtrace match the changes.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:F7876602-343C-44AE-AE5A-A0D69BE8B8A8@linux.alibaba.com">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><span style="" class=""><font face="PingFang SC" class="">Regards</font></span></p>
              <p class=""><span style="" class=""><font face="PingFang SC" class="">Xiaogang<br class="">
                  </font></span></p>
              <div class=""><span style="" class=""></span><br class="webkit-block-placeholder">
              </div>
              <blockquote type="cite" cite="mid:DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com" class="">
                <div class="">
                  <div class=""><br class="">
                  </div>
                  <blockquote type="cite" class="">
                    <div class="">
                      <div class="">
                        <pre wrap="" class="moz-quote-pre">Regards
Xiaogang


</pre>
                        <div class=""><br class="webkit-block-placeholder">
                        </div>
                        <blockquote type="cite" cite="mid:3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com" class="">
                          <div class="">
                            <div class="">Thanks,</div>
                            <div class="">Gerry</div>
                            <br class="">
                            <blockquote type="cite" class="">
                              <div class="">
                                <div class="">
                                  <div class=""><br class="webkit-block-placeholder">
                                  </div>
                                  <p class=""><span style="white-space: pre-wrap" class="">Regards</span></p>
                                  <p class=""><span style="white-space: pre-wrap" class="">Xiaogang
</span></p>
                                  <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com" class="">
                                    <pre wrap="" class="moz-quote-pre"> 		device_queue_manager_uninit(knode-&gt;dqm);
 		kfd_interrupt_exit(knode);
 		kfd_topology_remove_device(knode);
@@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&amp;kfd-&gt;doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+		if (kfd-&gt;gtt_mem) {
+			amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+			kfd-&gt;gtt_mem = NULL;
+		}
 	}
 
 	kfree(kfd);
</pre>
                                  </blockquote>
                                </div>
                              </div>
                            </blockquote>
                          </div>
                          <br class="">
                        </blockquote>
                      </div>
                    </div>
                  </blockquote>
                </div>
                <br class="">
              </blockquote>
            </div>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------w90a0Xd15hqzLsG7zli0krK3--
