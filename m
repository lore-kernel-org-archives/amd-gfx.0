Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DF4C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 04:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3D910E733;
	Wed,  5 Feb 2025 04:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RzCQiTWK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90ACF10E733
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 04:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV87VMg7ZxdEykaKUwbY9YBwQVYyWO5ZdJ034kh2ZhVmDwknviezblkt6Y0Hxxp4aq70kptXKeSP0YXnuLE5vmLLew3eXpw5rn/izOaldiyTYsW9mOb7x3ZCGl4e7Ig/8tTVfPKdblnv6fSU+u3FpPXULcvATy0nNd2Sa0SCGit7/b4xwBMYd3tD3/g8ToLi8S2WgbNEJahk1GfnoYrT+4lRgxsw7PCeprj7T5ZXsgzqrdW+k5gREMZhusbzxkXfbOkiMcIWTWdy+4fUSY8WbGxdZ7j5gdyDcUoBtosOElZyFQw2BA4C+02EZ8THJgvkdNfFrMk7WB2CTylWuRkNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieCgybn7yOySh8WWBnXILmTY1TwGLauQxlszswigbEY=;
 b=aq+C0BacuQLzq7/J5HQkzNdulXC++sFeB6QBlpfAuHgnxSsBfCSYhzYq5Vx91afn3B8WhQRzjNVC5vhELiW5rPpAMVx8mhfBkvC2jtwDRQsBcqLHwt94KHNb34HRucBagHiv9diz1hq/SxFxyaNeqAEi4qylwDSYkVbqP3fVy9O45Nch5aTzx65W8tNN8+IYigeWFvkvNGyWCroxM/027HXA5U5QqY2AL/OHeoZMWZrQH8LVtunvoqrpzw4oJb0yzQTVXxeG2J4HTAs+k2Ne/GAl0ZGnjlLdBbVtjOiM+JsM7pfojlM2ZOn5ZSM1Do8KposK+d6QZFdPqRY9w20Lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieCgybn7yOySh8WWBnXILmTY1TwGLauQxlszswigbEY=;
 b=RzCQiTWKDPiYzsVJsDXdfhSrJFSuOISXrWMNuDxCNNUVTZRYY6h+LN28xJ7zI+e/tiR7SlkfC6HdJFrbgQ6NCyYs3wyl8VByIhbQL4clJIoe28fVXxCvUCoGHX7EfraWJYJo8uJyQwvv1ZT3I92kJvp7GGI2b7uYycONwn5+uKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 04:41:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 04:41:34 +0000
Message-ID: <7ac0ffb5-d314-49d1-b960-fa6ad1c86b19@amd.com>
Date: Wed, 5 Feb 2025 10:11:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: add support for IP version 11.5.2
To: Ying Li <yingli12@amd.com>, amd-gfx@lists.freedesktop.org,
 Mario <Mario.Limonciello@amd.com>, ray.huang@amd.com
Cc: Richard <Richardqi.Liang@amd.com>
References: <20250205024837.976890-1-yingli12@amd.com>
 <20250205024837.976890-2-yingli12@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250205024837.976890-2-yingli12@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017D.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::48) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fef089-b071-4bfa-3bc5-08dd459f5e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzBTdTlsdmt1NUduTWpYVDZ6dlI3b29JL3lNZnRBT2FPWU4xcHdwbk9DUWF4?=
 =?utf-8?B?NkpkUXgvSWpSVmw3d2grYVNTQ3ZVY281ZkdMR1dyYjFRQ0xycVlQbEp6TTVE?=
 =?utf-8?B?WmI2eVZSV0pNdHJNdEtuSFRRd2RYazdZUmd0Zmd1aUF5ZHZ1TUgrRTNTWGJo?=
 =?utf-8?B?WWtjOVJxRk1WS2cwUUN6a2hWMlkvQkdWTXJUVmoxR2JjTk5Wa1pCYjA4NVpa?=
 =?utf-8?B?RVZjZ3BTQ2NIdGc1T2ZNQk1Fa1FPSU9MZFFndUs3Q1BPckcyYlYyTzBkTTZ4?=
 =?utf-8?B?ZzJQakpPdVZtUVFhSS9qdzJwUWVDM0ZiSVhhWWdKc2ZPdUtXVlRmYmJ5UW5N?=
 =?utf-8?B?NmNGdFA5ckpWTTM4aVExdlh4ZVVpeW1nc3lXaWdDdVdxRGIwN2xNL3EzMS9Y?=
 =?utf-8?B?U1pjUHN6aFVxVnJnNXZjYitoZUNCM3hHOHJ1Ukx1alcwVmtKM0J3TURWdnpO?=
 =?utf-8?B?QUc0U2V2K2hpOCs3SmhRQUQrTk12Z2NrN0dLNmk2amI5Nlp6Ny9vTjMrUXph?=
 =?utf-8?B?NU8zWUQ0R3pJbjhXNE8rdVcvbEVjcWlCZE5OT2ExenZZaEhFNEhUSlNmRnpu?=
 =?utf-8?B?d21xcG8ybklwcU1GNEpodk92bUNmbUtqK3NtZmVGRVdTMzBYaUVqVVNQbk1o?=
 =?utf-8?B?RlYyZ0FGODZvNDZ3QU94aTFZaVNpdlJUK0htQUV1bVhTV1lsQVFuT1VDSHZt?=
 =?utf-8?B?a09HcSsxeW9mOGlPbG5xOHJSM3N5bUxGblZNL1BzbkJ0WFF6VnpNdFlrRGFv?=
 =?utf-8?B?VWZLc2VjQjNCc3lBTEE4V3lkZWFYWDc1cy9DMzB0QU9laHVSZGNMVm4xZUNN?=
 =?utf-8?B?MGQwc3NoZUlWVFQrSCsyWUx0QU5xMGh0S3BFeUsrc3ZUSmdRdTc1RC9LWWJV?=
 =?utf-8?B?UWc5UFExbHErT0FBaXJFSnVNY2I4Qzl1Z0tja1RxVGhjd1dDNjFPMmhwRjg2?=
 =?utf-8?B?Z2FEWlFuWmI5WHgyUHRDYStLUDVXOVRTZ0ZETU5zWXpBNjMvaTJ0cUpvenJt?=
 =?utf-8?B?TUtqTTVFbk9GVVVLUXM5YjcwclZvUk9HT3VxVDJFeGtVZ2JrZEc2R2hLMGFV?=
 =?utf-8?B?SytvMmNWcXk2VkppR09UZTIrcnRiQUlMSU91RGkraWRxSDZrNzk3YmhxVWp2?=
 =?utf-8?B?eUJNZHhKUmdKL09RdGYrMGJOclpjOWdhUDlMazBreWRYeFFXQ00yWURwbno0?=
 =?utf-8?B?VkxORUtpL3dzZ29GQjZTaG5vcEpyQzh1Z1JXbjVmNVAybW1QQzJJOFowMGVz?=
 =?utf-8?B?cTc2QnlzN3J0c0dFWVc5all3UkFRMzlwUUhSamYrem51LzFvZXowZ0prZ1VR?=
 =?utf-8?B?b2toMFlZRFhkMHZQMUpveTZ5Y09uQTlrdE0zb0R1VW4xNURiUGxZdnRnTVpC?=
 =?utf-8?B?eEcwaFRXRXJpSnp4ZFp4ZkhEMVpJRitKTDFEeDViY2JIYVVrb1VtbzduS0Jm?=
 =?utf-8?B?Z2s4Sm12RG1VWFFTakNtME1IUHArZGphQXVNSmJxZkpkYjI0dGVUM3owZysx?=
 =?utf-8?B?LzRXNXlQVElzUFdOTFUyZW9kQXplR2JKRFF0am1lT0lSMzlYT2drNVVmWGky?=
 =?utf-8?B?YVJLcGVydVkxVDIvSm16VkozVXQ1MnJBS0tPWWhhdlRxNHFDWVdlT1BFQTAr?=
 =?utf-8?B?b2lvempQSVViVTAvVWtoUnBFK2NLWlpPbTUyU1lySXNhaWI2a1JYVEdWZUp0?=
 =?utf-8?B?MHRFbXBUV1pEWlhvZjhDOEhNeGJaL0poVDdTb0gySVE2Wm53RHFKRlVmTUVI?=
 =?utf-8?B?aHNERGNQT0pEcG1QdkQxMS95M3ppYVNtdzJzR01FdHo1NHFxNkFYcGVOdzMv?=
 =?utf-8?B?Z01weGIzZzFqNlRrQW53M21sL2xsdldKWXFxY3RDMDErZHgwenh4Rmk4aEZQ?=
 =?utf-8?Q?3No67dqlyJYWu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnExZnVpdC9TdUE0TWQzYUFwblgzeFFxVTBvVm9xVXZ3dTI4WmVGQ2hVTGQw?=
 =?utf-8?B?dUV1aTJnNkFHTm1wZkdLZGRUZFZQVmlmYmNIVzVaTllHbFRYNmlwZ3dtenQw?=
 =?utf-8?B?Qy9KTGtYaFBxc1hRY1NqRUp0cTk2ME14aTIyTWZmZC8wMEd4RzZ1aDZOcndt?=
 =?utf-8?B?R3hoaEwyVy83dDFDeTN4WlgwYXJsbjN2VEVBZHVhaXpMYU1XSXV0UnJjbERT?=
 =?utf-8?B?WFo2UGhCWE9jaDhrZENhbjlqdEFhL0VsNk5GT0ZHUW80cHE0Wml4dlkvMnVC?=
 =?utf-8?B?VXFUSU5kWm5JVGx5eDk1N3VPTlU1c2dGOHR4K3pPSWxCNUNBbGxWSmZRLzdt?=
 =?utf-8?B?RU1hdDRRdW5QMng0Q05DOTkwQmsyZFJ1OEVEa09QWEVxOERqdzIwdUFFWUxU?=
 =?utf-8?B?TXNOWlBQMUpYdkN6aHZBVFRqOU5DWi9ZUXRiN090TUh3V3puL3BCNW5yRE9H?=
 =?utf-8?B?aW14ZXVaalZwcDdoMVN1NnJwTFZvMTRUZjBYQ0U0UFUrTVluckF0MUxmaVBH?=
 =?utf-8?B?QWJ2VzVIQUZ0bUJjb1hScWp2cjRubjJKRTVnVmRrVkJFQkhXNFh6NDdCQk96?=
 =?utf-8?B?Z2UrSldTbnFyNzJYKzhoNVNFZUY5ZkFoa3lIbFRhZWlNNXNoV3o0UjJKN1A5?=
 =?utf-8?B?ekZnVjQvS29BdUpQbGZQNFBmZGVkSFlHTzU1SXd1SUk0ZFhrVzYySUFzM0VK?=
 =?utf-8?B?Q1F3MlFrNCtkK1VKQ0NwaWRkU3JjSWx3WDQrbkhJbDFOY3gyODFSaFVJK1Z3?=
 =?utf-8?B?QnlIN0E1MFl6ekVodWg4bExMaGZpUjBhRWhlR2pRR3Q4Q3Q1Y2tyWTB6MVYx?=
 =?utf-8?B?TUR0anFhUW9XSzZnL1ZiT0U1ak1wWUhhUzFBRzhHdnEwMkUvSktGWFk0T2xO?=
 =?utf-8?B?eHNWdFFnVWdxWXA2OFl1Y2EzY1ZUZ0xKakdMaFNvZno0MXdMc3dJL0xiOTJ1?=
 =?utf-8?B?UThKK0lDckRldWpiL0tpNmdFRXBsNnJ2UzBMNEh6MjhrUWYrNFRMSDcwT3R1?=
 =?utf-8?B?eG56OElXd2RNZDV1QmcxbUt3bE5TelpXeDBvanFhMTB6ZnF0ZjY4WjBSNEVP?=
 =?utf-8?B?blVWSjgva0xMMk9FL1lNRlhxT0NPYW5VcFFkZkZ1dDhLYXkrK3B1b0FPb00z?=
 =?utf-8?B?ZW91ZjNacWFpUmFmUm5sUGxpYVNRMzJGVTdOb09Nd1ErUFp3QmpraGN1MS9Z?=
 =?utf-8?B?SC9teWs5ajU4U2VRdGo3NVRjWDJ5VXdnb1RQbnByTWNGSHIzTWRETGtQbzRZ?=
 =?utf-8?B?RjRUMndPMTJFTytJOTZGK2d5cWN5Z3RaS2ZOOEF5Y1dhWkpRb2hiMzlhZlU1?=
 =?utf-8?B?TTVYMkNVMUJscktCakVDc1RqdGhLdXlNbFVOaFlTUE5EU1h4SXRxOEQxLzNv?=
 =?utf-8?B?U3p4bjQ2QVRIYlhxZTBnaGozL1pQa0cvcTcrYlIyNytyNmU3V0tkampwNWQ5?=
 =?utf-8?B?K3FVVjgxakg5YmRYQnFUb0RWMUlJOUt2M0RKekRVVzl0WlEyNmpZWStoMTVq?=
 =?utf-8?B?ZEwzZlpiWVdmaDJ2VEZiNWdTREFJbWVyQlhxR2lEMEM1NHBRTTlCSEFGUEgz?=
 =?utf-8?B?OE43YmVHeUdJSWd2QXoyNnpOc0ZWL1JFcXE5MUw5bGlTWjNseitWMU5YdmhU?=
 =?utf-8?B?WDd2aWlQejNpalFlVUVva09MYXpQTVJWcjJwWGJkNElvcGFBVEhRSU05bmFG?=
 =?utf-8?B?em8xOWNOTm5RWXAyU1M0T0NCWUpEdlJCQ1MwSHhTTzF6UHJ2SFpZQ3NvUFdG?=
 =?utf-8?B?eDk5ZnF5OVY0TmZQMU1hZmVuSXNQWG9Fcm9sSythNFJJTGFYMGMrYUZHclNX?=
 =?utf-8?B?TGMrRmtmeFdCemh1NnEvVkg2cWFQdkNPVEZVM1pNeVpNZjRTTWRnTGprN2tv?=
 =?utf-8?B?anhwUWtBZjYwMFBGaFpSeGhTVnRBOEkyMXFDZ0ZXM1dsME16cnRmSVRiV2xQ?=
 =?utf-8?B?eTlUKzdHY21VZUJzMG9mYkd3WVVVTGRFaUJ6WXRGbTRDOHMyZUNmYjZPOXRO?=
 =?utf-8?B?WjhONy9BN2k3MS9oQ0lzTHh2d0doblRVMVpNSzY2SFdXcWtMYytEK2VWR2tD?=
 =?utf-8?B?SDRXWWlMR0JPTTQwMVRZdmk1UHNxdDFKU0o2SFpxMW5BQmdMY0NRRWd5STJL?=
 =?utf-8?Q?goBzzvA+2ksl8BmGNjIFoJWwv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fef089-b071-4bfa-3bc5-08dd459f5e8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:41:34.8927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFSc9zy0Hyly39biH8tiC9j6Qewz7uUUhxwg/BrGLq/aRNQ3QplVDUdpdzJucge4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189
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



On 2/5/2025 8:18 AM, Ying Li wrote:
> This initializes drm/amd/pm version 11.5.2
> 
> Signed-off-by: YING LI <yingli12@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 51c2a7f4aba2..dd4cffd94a90 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -693,6 +693,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>  		renoir_set_ppt_funcs(smu);
>  		break;
>  	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>  		vangogh_set_ppt_funcs(smu);
>  		break;
>  	case IP_VERSION(13, 0, 1):
> @@ -1565,6 +1566,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  	case IP_VERSION(11, 0, 7):
>  	case IP_VERSION(11, 0, 11):
>  	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>  	case IP_VERSION(11, 0, 12):
>  		if (adev->in_suspend && smu_is_dpm_running(smu)) {
>  			dev_info(adev->dev, "dpm has been enabled\n");
> @@ -1918,6 +1920,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>  		case IP_VERSION(11, 0, 7):
>  		case IP_VERSION(11, 0, 11):
>  		case IP_VERSION(11, 5, 0):
> +		case IP_VERSION(11, 5, 2):
>  		case IP_VERSION(11, 0, 12):
>  		case IP_VERSION(11, 0, 13):
>  			return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 189c6a32b6bd..48912c7295ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -227,6 +227,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>  		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
>  		break;
>  	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>  		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
>  		break;
>  	case IP_VERSION(11, 0, 12):
> @@ -472,7 +473,7 @@ int smu_v11_0_init_power(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	struct smu_power_context *smu_power = &smu->smu_power;
>  	size_t size = amdgpu_ip_version(adev, MP1_HWIP, 0) ==
> -				      IP_VERSION(11, 5, 0) ?
> +				      (IP_VERSION(11, 5, 0) || IP_VERSION(11, 5, 2)) ?

I don't think this will work as you really intended.

While at it, you may rename the subject/description as add support for
MPx IP version 11.5.2

Thanks,
Lijo

>  			      sizeof(struct smu_11_5_power_context) :
>  			      sizeof(struct smu_11_0_power_context);
>  
> @@ -731,6 +732,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
>  	 */
>  	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 11) ||
>  	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> +	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2) ||
>  	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 12) ||
>  	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 13))
>  		return 0;
> @@ -1110,6 +1112,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
>  	case IP_VERSION(11, 0, 12):
>  	case IP_VERSION(11, 0, 13):
>  	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>  		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>  			return 0;
>  		if (enable)

