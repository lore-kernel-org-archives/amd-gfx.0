Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F281EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A951129F1;
	Mon, 22 Apr 2024 11:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oYHUnRvK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E9B1129F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eamg+dYh2xeLKwPwjqLTAqxJWDQji1lZDWDXHyVzY0TfsMMiqtJsfIYEP7jPqKVs5+NLgbZeeZt98WMP8ki16NmX4ny8xGbJyzH/juYwmOs9LLYP+NEkjeuUBbI30ogmiaYcyuyVX4JXyJgu2jQEBu3dqDIsJ5W5JzgIjCe6JdXEVlfNvVWLhe4tvR2sFwFLd2Yxrk/ZXm5AwSBDTPdAYXCAn3Pp4KXQG0QKS2mmIuSAeCccVAiYz4Ykd+kf/2UqPpu33EYB8x94S2kWSPgCzf/Li8EkDonQBXe6BifEjp56Ds9+Mu+O3OcdCVigtwWOXb7BjbVblboNJFRlFPNtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzvghLhZyTU3YrVDGmQQKMOLP0RzPAYJt6y4gOJsSZ0=;
 b=DbB4jqJ5/W0DpLNxabqkhhdl56OFJMdyfbdmCrVbI3XyLs1IlriKl+9101JYz1sRXBHRng1KjcCr1EyZDuBy1RhuoRI3eA6ndYJsFb6pAnq/0acyGyuO5ctN+P+aw0T3gAsrDTYtlbUWirOT7OHnlGYdQtgiL8xy0aTfOkit3cSp6ZeCnGGRb5zWKQD5bsRw9MF3fm/Sox2c56U8YtGIWJpJi+8O6uvQZevNNnF3+kKktJ57hQDGSrBxHGsBFd2oOetBTj/gO3BMzW9XRFkuEcv6Fa2JhwCtWzyUs4dIQoYTQkk1cHhrf2CsTe9x+5xoNpZqQxjZh+bZVbpxpyVZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzvghLhZyTU3YrVDGmQQKMOLP0RzPAYJt6y4gOJsSZ0=;
 b=oYHUnRvK2dMx0TyoXeVwzt6J9LpXpuI1AWL9s+d7GwXi47ydgY36G4QlGWcwnpZ1G/jne2wPXtPnGvmJwVH+HgHP+93bqqcjhEP4/ttAKofLOYvIBpPjJiG5HCUioXcdCJ6EwQZ/bFiAywM7tQulcx8+kW7xdz7PntCXpAZ+95I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 11:29:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:29:28 +0000
Message-ID: <b577f411-88cf-434f-939e-f5b0e6dd6876@amd.com>
Date: Mon, 22 Apr 2024 16:59:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free issue
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
References: <20240422084707.3803306-1-Jack.Xiao@amd.com>
 <cd234b95-5ab9-4c39-a815-503161d4bad2@amd.com>
 <6a3ff35f-09a2-429c-b8d2-d061dd3c92a7@amd.com>
 <7437f8dc-3199-45a2-9279-f64a5e49e130@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7437f8dc-3199-45a2-9279-f64a5e49e130@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 95111d2a-26e0-438f-39fc-08dc62bf789f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wkdmb2tFM3M1STRYR09hZWxJck9KU0hmRmZlS1ByMmorRGJETnlNSWhJY1NB?=
 =?utf-8?B?YWxBK3U3T0pQV0g2T3dwNktNMklULzdwM0NJeU1MNlByOEgwSnRUejZwMDNw?=
 =?utf-8?B?cy9Hbjh6K0x5SXdBOVgyb3BWckFGdmlkSHFYOWZzbGdIY0NDUHVrTmtrN21Z?=
 =?utf-8?B?NmhUcHBUZGF2bS9TemZvR3J4c09nRm1DZlNiRVZjdE0rbk1TQkplMUFQNjBk?=
 =?utf-8?B?K0JCOG9qVEYzNmdhclBxdGcrRkRxaFpwc284N29hei9CYTdFaitEckJHUlVL?=
 =?utf-8?B?RFBVa0diR2RWaGU4VVBkSHlQM0ZITEpjUGwyc0JraWpyQ256bytGTHZ6ejdl?=
 =?utf-8?B?ZzNublpOOTRvTjc2eGg1RTVhakRubU9PVUZyMitSb3c1N3NuUjBSQ1RqT2t0?=
 =?utf-8?B?c29zazRER1hCWnd6UmlZQ3hDay95YWUzbi9pb0xvSjdIeVR2ZjBqdkJ3VU5n?=
 =?utf-8?B?T1J5NU9aYVB2SUJ5dXhReHpIL0hQOGd6MVluTThnVzM1ckdmakNWeHIvWG9T?=
 =?utf-8?B?NXVGa3F3UDBrZTFQbGNSRDRxVDJJOTNNTk91UkprcDdYbmUrdFYrbDhLOTBV?=
 =?utf-8?B?UkZGVDRzUmNSaWpkQ2V2RFpDRytTbk9kM3I3bGtYbHRrOFNJUjFDNFdRTkdr?=
 =?utf-8?B?TVhnd3NaTFVWRGIwUzBRa25IMWRydHhjSW40anhQNlkwVEVGMWpMTnk1MDh6?=
 =?utf-8?B?eFJRRitBL0x0MnJmL3JPM0JvSG5FMVZ0aDBHTUh0eGZBR2JRUE5vMjlOSzNJ?=
 =?utf-8?B?c3o0azZCcnQwSXJwY215cWdzaSs1UkFKUllnNzdBdWs1UktqeThlSjJDeHhq?=
 =?utf-8?B?RTJkZ1NmZ0Q5ZXJTWnNraDRVZFlIbTlwQmNWZ2czZHhmOGkyTC9CS2d2dXZl?=
 =?utf-8?B?aGdMenV5TjByWDl5V0dSdEVCRHJXdkVWZExqemxNL0w4LzVRdExudnBEK0xE?=
 =?utf-8?B?bzE2S2lpTlloK1JtbzZjOUFVTVlLRWtsVkNkSmR5MXNGMXpqWlFTNTBhQWF4?=
 =?utf-8?B?eGVIMGVuR1NRQWZsOUV0WmdzZFF1TE90SjhtcUo3VlZNdjFLcmkxaXF6bGNF?=
 =?utf-8?B?SHVZYzA4dUs3ekJSSVVFTmQrQlNrWG9lQTZ4RkhvUU1UcWxDN0haZkhSWm9F?=
 =?utf-8?B?VVZBRm1kR1Y3OEZDTURkZkowYklHL25qTGhTSEJVQ1B5c00yU1lDbEF6TVUw?=
 =?utf-8?B?NzRTRXdIR2doaTFueEVjaWZxTGtmSUkrR001L0JaaXM2aXlrNE8rbGc3cFor?=
 =?utf-8?B?eXVtNHplekpMUWpHSDFxYmN6N3pEQWphaWpLSmFNZjZOY05pbm9obUVPVHd4?=
 =?utf-8?B?SWpqWVdCWm83K2lKRW92TGU1eUJEU0NvMVpTQVZSK0t0bDd6bVpMd1R2VEZ4?=
 =?utf-8?B?ZkUrU01UZm5vWFlmMlk5OER0OEFPSmxYSzkyMitkQlNJOGpPYmNNNk44aEty?=
 =?utf-8?B?SnRjSEpOdnpReG0wVEM4bDRpRFlqaHJpaTVGQVhBVUVQalJvQW5mMEgrSGRP?=
 =?utf-8?B?V1gwemFCS0liRkpZbm9nWGZUaGRjRW0weHlXMDlNbnd0TGNuVExheWFoTGpk?=
 =?utf-8?B?eTRYeWVBaG5ka1FqMUZHNFZRamJCKzlId1JKL0pSSVlmSmNrVE1JRFpQMFpv?=
 =?utf-8?B?R0Q3VzcwTnRLRGNhTHhIa2hqdGZYVzZ3cGRjOXJneU1Fc0pUSnp5MlNNcDB3?=
 =?utf-8?B?QlVnVVNhaG9yTytmKzYvdE1qdGNoeUh4UFd1MVZ4M1B4Y3RqQ1lqZjdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRCb0kvU1c5L0MySmJsemJyUzcrTVlDK2JaekFVR3VOL3g2MG9rdlBvYnVo?=
 =?utf-8?B?TkpqelNEOThBR2k0Yko2a01QTzUzWDVnWjh4MGk0K1NZSzRXeGZTZFk1bko3?=
 =?utf-8?B?Qmc1QUExclY1WitEN3oxZ2lZUXR3UVNJVEdNd3RvMGwvMTlHL0dMaUNma3NM?=
 =?utf-8?B?TzhEejNBcHgrdXhtRGxyKzlpbGRSOTJwU1pWQllXZmJEVWRQanAvN3FYYlJr?=
 =?utf-8?B?NU0yRjV0NUhIQkgrbTBaaFVPZkdhL29oOUswK1hEbFVjbnFkZkhVdVM5M093?=
 =?utf-8?B?d0RoMkhTZnNzcHd0aU5CL09tSWtRWk1Eb081dWJMY3A2NjdOamkwMFovRFZG?=
 =?utf-8?B?R1FKR2FXZjRlbHdWWG1ObFNkK0FwMDY5dzNFV1EwUU1DbElFSmFjeHVwVWVj?=
 =?utf-8?B?WW5mSTlyMVpGSExMeVEwZnNmZ0VZaUZhVGtkRDM0RUZxWCtJY2JGRmhHTy9H?=
 =?utf-8?B?ZXRZMFE2dlBnajd3amtnQU8yQzZLUUJVbTFKL2M1Z1djUXROaXF4Y1hmdnI3?=
 =?utf-8?B?OUJjNllBQ2xrSVhYSzUvV1N6bFMrMWtDcHpRRTQ3QnM5TEFWN3JzTFVKUGhu?=
 =?utf-8?B?RVBzcXQxd0E5eEFHQ0t5OWZmVzl0WFNEY2RlcGZMUnJVb1FPdzdDYW9obXVJ?=
 =?utf-8?B?ZDdEeE9oVWI5RzFTYWdXRzIzQmFKbFcxQU43ODQ4RWJEMUhpbzNIeUFUdWFw?=
 =?utf-8?B?OHo1VVJTWUVkSXhjQlJTTjJmMExNNUY1OTI3aElRR2hyMmlBZ2xEamYwZjQz?=
 =?utf-8?B?UWZEWjRsSlkrTlc3UjZSdTgzVTY4SDJCR0crRTBya0N1T3BCdTcxaEE3V1hU?=
 =?utf-8?B?cUE0TEdnRUR5dmhUQXBEUTZveHZidG9GSmpXZ0ppSytubVdnbW93TG5CTFlx?=
 =?utf-8?B?aldncDdEVUtjRFBOVFNYNXU0TDZjRGZlcERMUUlKY2VvUDhYVHZ1VjVBNnZ4?=
 =?utf-8?B?VGN1VGJqR0F1NFpwc1NXa0dGYk1vT3JUTGlFYkJ5NWhPeHRwSUZrRCtDZUx4?=
 =?utf-8?B?ejUzalExRUNyZWJmSTZVYUdrY3V4STNSY3BZY0gvRXByZjhHeGxjWDBWQWJL?=
 =?utf-8?B?WncwdHFkWlNrcGVzN0FUNXV5bWlzRGlPekl4WWU4OGdNWmRRWTNicXB3OWdG?=
 =?utf-8?B?ZklJMGxWQVIxZHYzN2Qrdm5kdXBXTnFja0gwNnB0YjRWNHdoTWJ6WTgwcEtu?=
 =?utf-8?B?SEZGZndYbnlYZy9lTm5scmRENEFFN21iS0w3TUYwU2Z6NFlaeHBFeURCR09F?=
 =?utf-8?B?dzNWWHBDUEZSU2pvclUwdUp3bUxNZzhsQjQ3MkM3UmpkUEtGN3U2RjVnK3lE?=
 =?utf-8?B?WUlaOHM1OFRpV0pUQXU1Yjd1UVNMQTJYZlRrQU1KYVA4VlA4TVFrS3orWktN?=
 =?utf-8?B?T3Y1bDN2N2VWTUgzU0pHeHhFR3JoQ2hUSXBsNjBycG5CM0g0Q0pjYURUSyt5?=
 =?utf-8?B?dU95UzFvNUlZRXJIdFJBbGRVQTgzajh6eG1nSlpNRzdIUElVYkZWSzkrZDJh?=
 =?utf-8?B?Vi91Znh6RlRWOHNJYUgyQi82YjBJZ1BLUnZWNnc4VzVjSk5kbi93cWdjY0cw?=
 =?utf-8?B?Ky8wTElrcTYrZHRuUDlQZ0NLTjFLZHV2WGhDQlRTMTczWGdEcGhaMDh6QUtO?=
 =?utf-8?B?SDVuTTlSMTdmTlowYUdqZXhoakhwbkJiaHM2ZnlpYy9OeThtcFJaSFQrUjV2?=
 =?utf-8?B?TmgyQzRZQldXck1rWUxTRlI5bFFXdXd3WUtxdWRIYTRvTnc0ZVArSkJiTzR6?=
 =?utf-8?B?QWNkSjhHaFJGeGx0aVBiMW5aeEg3L0JUUmFJakIvMGZOSXZCUUJRNFRlU2tF?=
 =?utf-8?B?NWV2TUovNlJGckVubFo4RlByRDFZK3ZZRlRKd3BFZEVCVEEwSG1nL01uL1Qz?=
 =?utf-8?B?TGQwWk9vR0hXLzdHS0VKcU11QjVCVTI5SlVQMldnMlpQdFpFUy9UdTFXV0dm?=
 =?utf-8?B?UjFTazViRXAwU2o1UTMyY0ZVVGYydFlrNG83eDJ5VW8vTkFYZEoxUExnczFt?=
 =?utf-8?B?cmJPUkFZN0lpYWZTSzhyelA0WTBYR1JmSWEzOFp1dWFFaDNxb2RBdEw5c0I4?=
 =?utf-8?B?U25RbkhGYUUzUm0rZFArMWpCNGN5c0pwcG5EdzZ3QW9KMEs2cTgrVHUzK1dI?=
 =?utf-8?Q?3wU87tXAH4oFAuPUI3OV1ehIj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95111d2a-26e0-438f-39fc-08dc62bf789f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:29:28.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7iNkCIAMk8mwZazBkxpygGLg8Uxh0XpV1qPZSx7KLGhs6Z+7Fc8UuFATt2sJpeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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



On 4/22/2024 4:52 PM, Christian König wrote:
> Am 22.04.24 um 11:37 schrieb Lazar, Lijo:
>>
>> On 4/22/2024 2:59 PM, Christian König wrote:
>>> Am 22.04.24 um 10:47 schrieb Jack Xiao:
>>>> Delete fence fallback timer to fix the ramdom
>>>> use-after-free issue.
>>> That's already done in amdgpu_fence_driver_hw_fini() and absolutely
>>> shouldn't be in amdgpu_ring_fini().
>>>
>>> And the kfree(ring->fence_drv.fences); shouldn't be there either since
>>> that is done in amdgpu_fence_driver_sw_fini().
>>>
>> In the present logic, these are part of special rings dynamically
>> created for mes self tests with
>> amdgpu_mes_add_ring/amdgpu_mes_remove_ring.
> 
> Ok, we should probably stop doing that altogether.
> 
> Shashanks work of utilizing the MES in userspace is nearly finished and
> we don't really need the MES test in the kernel any more.
> 

A v2 of the patch is posted. Can we use it temporarily till Shashank's
work is in place? Assuming Shashank's work will also include removing
MES self test in kernel.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 06f0a6534a94..93ab9faa2d72 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -390,6 +390,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>>>                          &ring->gpu_addr,
>>>>                          (void **)&ring->ring);
>>>>        } else {
>>>> +        del_timer_sync(&ring->fence_drv.fallback_timer);
>>>>            kfree(ring->fence_drv.fences);
>>>>        }
>>>>    
> 
