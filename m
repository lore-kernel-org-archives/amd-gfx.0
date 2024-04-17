Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10C2C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 11:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB8710EAF9;
	Wed, 17 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OntTUEMv";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5F1113431
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 11:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InnmvOYjop624JB86IN1gqAMaRV8JmTvCmHSYrrD2fozAEmb14h4dnzbiBpA+IP2DUm6IT5cc2LzTGXpyBiZ91JPOXJ2NOb5h1l6LkOBPlWqmjlDc20DjUVqefuWIIZ/EiPVsGHEoQoUcNHFQ3zcMVNYNDN0S5wqGJZPZOJyfWEPSt9t/ct4L3B70pYLmd2I9p48pjs8mxfXC6SF85dp70O8erbXnDh6X+EP9gGA4EV37KR4alU1ncsaGdfUPRvlrKpsEs63w0u0INtned06oQZNi+ddmtP//J+tGv4f9Dh1dCq92PDA0OJlGAPuIkzi0lkh9V4tycmZMN9ANrstfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QDa1Fr8llZdKOalURAjwTIpCNnSY703gg3YTXObJCA=;
 b=V0w+pQwNOdLbv4YajLFm8wOhunmoQdAlCYp5AD7V1SiI34e3cg+gubCjdv4ELipEeSH3hxSHWQhu7nxWKu44tqnzQjwJdJBy8FSqIjjSBXgkC01N02eRgHyW7zWyh561TeoNc3zDFC/RQqMb6/RSrJY462dMA+DAw5DDa7bCqTtFn0kgo/B70AoT9PHwokBPBK9tYIYu24YTGD8TebOK4aAa5RHR5lDlm6olwErmIY84Jei0O9CAivDeQTdUGtUmlWg0KLhcUjiRegfetx3IpVDtmCAQMlnJWYMzg+ng3zCo3LQsD/fpFNFs0mgTkWCl0nzAco54xm5JXSZxGzgFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QDa1Fr8llZdKOalURAjwTIpCNnSY703gg3YTXObJCA=;
 b=OntTUEMv4EgVIeXJsA65efysjsL8KmV8YLyok5w63OHWWzjM7j3EQ+vN1rmPA5B82mprzfQr2yzf8Cy6whbaVD+RmWYl6pFlkrNaKah0tHmBrf1UzrnVSIgMtiP1ujnqoC1O4OLHRGAn05gJJKWA4qp7yiltpj6NK3yLaPN/8u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.52; Wed, 17 Apr
 2024 11:52:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:52:55 +0000
Message-ID: <add8419f-a691-4b4f-af93-4d6b47ffc375@amd.com>
Date: Wed, 17 Apr 2024 17:22:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Remove gpu_od if it's an empty directory
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240417055335.118441-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240417055335.118441-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: d43d975a-62ea-4931-7c00-08dc5ed4eb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5nzfuKKeNUbo2d+KLYxqQl5F9JkT6wfE6e4TdHaYKdYm5WzXg6f2PtdKdPfnTeR27F1nx0WpCRk23f/EcB2zKM+3DLEmW0Sd8/5w+X6wqflC8Hh3sNqMrj6GOLkMlxsO7Wx+FzaEy9AsZ/1hoMS9AG7FTPzIseaOVIz9Pi4TeDA4RWnkdVQG/BoeC6kc1bn962/1WYAGCGnZpdgI56gYCU1NjkxIuRXLHBZ3P+H6armjhW+U0nK4Agxg7OR5cm99Nb3CerzlTYK7E85wpyjXpnnAaj4TG785WI0HQb+yR6VO017uH0cMrhd8MoeUr4AgUuEzqui0cWc/KxcZXjPu3o+h/b9xLJtbSXlRQE1JFJHYBT2ztr3xA1K3NI6SZA8eHb0RConeblz2fqM2Id2EKm9Mlnq1lNcrsVC9Td53L51bToHQ8XAFweNIcNz+U6IF3EaWI8ZVQtJF00azdTSttqMeN9jspkIFL4yEbGm0AAXsgBI5tLnzLrLRQUoLVStxAj3ds33itDFon07yxRrnuU8xu9/LLRFD6g0yQJBqDxY1twOINg9HKUI65GaXpTACqeYFoBVmckHqNtrjcgOYigEl8CWVqugiu4ugVJCg5zgjsPyvcA2QiUE0L3MbxmKxeLXj+jlFgdpySzxm4z5p582HDsCHGwn4OKpDZsqrto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWdKK3dwRjd0RFpHREFzckpTbEREL0xMemczV3RrdStrdVZlWHdibFhKOHZO?=
 =?utf-8?B?c2tna3cwUE5IUFlwWC8xU0ZNYlFHZFZ3NExvS0Z1a1hPMWd2L2lvcExEWXNj?=
 =?utf-8?B?K281Q2JMSzVpYWwwSWExKytJc2Frck1IYnkyYzg1eEpwK2Z4Ykd2RVZUN055?=
 =?utf-8?B?ZkFJdWRWV29mdGtoL0MyR0VRTi9UdzlTQU5zVzRtdi94emhUSlFNaDF6OTdo?=
 =?utf-8?B?T1NMcmk3M3FjUzdWcWhlQ3Z0c2RLZWZPQjA4ajduakdTQnhtdC9XTHR0cVB2?=
 =?utf-8?B?alVKNTNBMEdXY2tpelVheVNKV05UMlNKNDNOc0J4WkNnZkkrZnFmWFROM0p5?=
 =?utf-8?B?Tkd5eER0Zk50YUpYclAxUHh3eVVSWmpJb24xTTNZa2F1ZWhxVnNsNHZWa29w?=
 =?utf-8?B?WkJXM2hEWUhDVDlJNWRkU1MyTVcraExnMnFDbXlDUEt1dFhlYVFhY0hXV1F2?=
 =?utf-8?B?cE1EdzJ6WXl0YWpvUW9vWE1Db3FIM3krWHRUV2s0VThNVlAydEtGZElRZi9s?=
 =?utf-8?B?MmFxNjd6MU96Qk9wVjIrclhDTmh2ZlZBSEVxeHNXb2xWakJFSGNhSHU2VXNL?=
 =?utf-8?B?R1VGU0ZxMDRjRDFTM3M1VmJPOWNzcXU3YWZXa1lBdjdrMHViNjhjSjZMT0hI?=
 =?utf-8?B?LzZTMTh2ZmhnMGk5QmVVR25TTURlT2RtTUpYMEsvMmlNdXM4bld0cEt5dG9m?=
 =?utf-8?B?WFRaWmFFUUgycFBWNEpSeGxkcU1rcWNMcXRobkN1RzV0eXpRM1NCaUdnRTds?=
 =?utf-8?B?VENuQktNRXlpNUgveWEyTExYaDZjNzJqWVpjSDRjRUhXSitpMlFtM0tNblcx?=
 =?utf-8?B?NnZoc3RiS21NN0FLcm10Ymo0YnJhbnpjQ3pPd3R0QmtNTUVNakFLd0hJVkg4?=
 =?utf-8?B?a3FJOUdwVUd2VFo5MXB3WTErMmtKNU8xUm1kZHNjMjJySXVUSnVOVzJSTGFQ?=
 =?utf-8?B?T29ES01CNUFvQUNIemJrdER2ZzczR2VrR0NUcmdUZkZLL1BGS1NWckdnRHJL?=
 =?utf-8?B?UTFRdUVPNnNsaktXR0o0T3Y3S0EvVWx5MnZ2bkJXbHdaQktjbjVRVE9TU2Jm?=
 =?utf-8?B?MUl2Q0NWMlE3ZDl3QWRjd0k3SGY5TjNJTkNwdDlCeWZXMWZTcDQ5eitDbmdi?=
 =?utf-8?B?RURRK2lWaDFBY01Jc0E4aitpZkJaa1h3cHd2dkp1WGgxQmxNdms4Y0pEZ09y?=
 =?utf-8?B?eHNvKytIWlc4bFVIc2k0eUxZVVBjVm5pRnJzRjlRN1c5cFc0MFdteVpoYzJw?=
 =?utf-8?B?SjlGZVlmUUROK1VRb1lCQUFKM0hLZHJrazNlZUJTM0ttQlAxYSt3azkrSG1I?=
 =?utf-8?B?NTJMVDFTVUJ4MHZDODFjWDJKbHNsZkhUOEJNSG9wU3MxaitnTGxnOGUvNGR4?=
 =?utf-8?B?TktLamxjQXR1WFlmNCtkMmkwdEpPakcybzhYeENNejA1RlV4ZmNPNzVjV011?=
 =?utf-8?B?UUNtVWRkK2lCMFhVa1RwRUVDek5Hc3V5WXE0U1hRa29PcGtadDNGRFJYZ3d5?=
 =?utf-8?B?UldpQTlJYk54bGdPRU5OK1VKK0IwbkVPcnd6cGNiVjF0KzIveHI0Sjh1UTUw?=
 =?utf-8?B?b1FTUU1pNi90RWkvbzlNWWhuaXlvTDYydEJwK3N0ZkxmODFXY0dzVEVIb3NK?=
 =?utf-8?B?Vk5Ld2ZqOGR5TU1ldk5oZW1XNVVyaDVXMnR2RTA5OWZMVndnTVVmWmlhbjNq?=
 =?utf-8?B?LysrWlZEQjNsRkdWdW9Mamhtalg2WXQzUDlqOTZsZFF0UXNpcnNzNWZmbXdh?=
 =?utf-8?B?L0NrTkFrM3VkNllITm1pV0RPNnpWMFZab2xLQzArZEoyck1wbTV1Y2UvNklY?=
 =?utf-8?B?SE9Ua2w5SnpHWEhuOVZxUktZWFFsQ2Iyc0FtNDNES2huMjlDMG5DNEVuMHlx?=
 =?utf-8?B?eXN1NllzUkRNK2dtNUN6N2djMzlZcFpzU1RDKzFMQ0NXTzNCZzlvVzVLcGpJ?=
 =?utf-8?B?Y1JGYzV6aWVzN3RkbnZHVEtTekxOUVpkMWE3cXI4SXV3MFpCQ3BzTkFLdHh3?=
 =?utf-8?B?T2w5MURBSnJmNnlmK2ZLTncrK1dOV1c3a1hGTHppRktLR1FDUVl6Z3F2NGVa?=
 =?utf-8?B?cUE3OXVHUTFnVTZTMkQ3dXJXRnRscVplc3FlTGg3bVh0K2NVVW1iMWZPUFg5?=
 =?utf-8?Q?W06WmvgZao/+1PRlp191Y4WPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43d975a-62ea-4931-7c00-08dc5ed4eb2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:52:55.2766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ0M/Ej9/OBVjvR8Okvjk+DbfFDYqvRQoAUTm7wvX/Q5ttbB5XbFHq42BAvXtH6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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



On 4/17/2024 11:23 AM, Ma Jun wrote:
> gpu_od should be removed if it's an empty directory
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reported-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index a20e03e69d38..0c13e5520e77 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -4338,6 +4338,13 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
>  		}
>  	}
>  
> +	/*
> +	 * If gpu_od is the first member in the list, that means gpu_od is an
> +	 * empty directory, so remove it.
> +	 */
> +	if (list_is_first(&top_set->entry, &adev->pm.od_kobj_list))

Instead of assuming any order, what about using "list_is_singular" - if
this is the only entry in the list?

Thanks,
Lijo
> +		goto err_out;
> +
>  	return 0;
>  
>  err_out:
