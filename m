Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD93C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 15:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D281610E19F;
	Fri, 21 Apr 2023 15:40:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044E010E19F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 15:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp9g9pwptNNejv7JMLR6pB0paGF51QOBbI5khWEeOQkXK3ObNMSCc1XxoxJe0qzh2jQFWLgd5iGnR7Smj2RUxOOqkki50YiLJ8zpSGQowtR1PeVi4+S+sgA1MXoPO/eY7PLYbqcBebo+Um/kNxVWDqyrEX/46qgFi9c+oTV9gNgPLtE6Ctc9cobtsOEtVh9mXb7AlyWFd6hQJkBBmXQW9ZUFSUXYJFfaP9Q3froHfbAhG1Ed8s6oBNiUX7NY5yvazMhZw7Xruqt9hutKBXM2x85cctYcMERKwZI/VKVckT8JTzRHOprOzs26Izs1OvUNJjI8UP8aLLe+3AyySSXGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUPAhJRwFBLDhEYsOrOL/qFe75COEBTbSM+ObuiJmro=;
 b=DoES8CiMJ6MOWzw+xVuN5EG/3bt+jTBr9KW6VhmttmTYucZqQtI4HSFaaSFDaZSKOKYq5gPxB8l44m3oPeqPef3KougTl2iHrqf/tHdhELd6Wu5Ofg06AQNX/8JSTIfnM5sM/WBXdAN+i60v4xwNunS/75R5Tu5oduJoqnz56dVIU4KySfZ967uQtmcNlLDe9IFb0yjbjJt1Geb2JE3HNXtiUO5axjYkBM2tLLeEwoT0cTfWGZatE8vA9ImW9iskdLyrfSUKsY9l4DiaiZt07MG013KQBecm2fAlhT4rBhpNETYVaETGKvwAJmymsVNiz7W/+Wv8qQkv2qtVdaYdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUPAhJRwFBLDhEYsOrOL/qFe75COEBTbSM+ObuiJmro=;
 b=lzUSlWHocYiZ0xIkPPD+wTBe33UqFvAua/isfIN0rhmlFqIOKVJkgZB+QWVvuOgIoFfEHqak78/32anZCw4sEFZ/eShLIjIHknyjp+cttwYG9sPgdZMq+Rj597sRc3sXU8yfbaLnzlZDK0PVlvXduzjyKVv51VfmkKC5IvDsUjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 15:40:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:40:19 +0000
Message-ID: <53ad10b7-8a38-dfb6-2cb7-5961e6dac224@amd.com>
Date: Fri, 21 Apr 2023 11:40:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdkfd: Fix an issue at userptr buffer validation
 process.
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230420222531.470189-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230420222531.470189-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 30959cfc-fb5b-4a5e-8d97-08db427eb5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxqTC8Vfih4YSWwljWXryzfciAtNqhKD50gtlGOtFL/YY/YDOrZ0bVdHIhxNZHDqPqzyI7CYahsqNF+cgZGthEqpMsG79vduPYBDyIsR4HAFAEZk4gVPIb4hx9Gx0SsSUYs1u7mBopnygD5pkUqDWIgqQfFqwZakIhaGHS9iXcvl27w4Bvq5laemcB+u/U05wEKb5kd80pa4v6zLIHb2ML+co+ddz1x69nZwIHP5/xkJUgrMZsHhPDZNQgN2rOLtDQpwleOtCZvWCsCF0WzRFmJLZyN+yDkJSz9PYnfxAcCu8HCaBnbx0yC56PFEAQ+M2q6ub+sLZMxFcc81oWu5/WtVVfa4JmVDNfrYkbYa9ydQ40fc608rd/bMVYUS77y3KESJ/Z/LSi6DTeSn+4RtVR938DueB1Dky9P3IiwMDW2TnNkDOCzXvU6bNCWcOXNBfyd7cyaogp5axXAB8V2XKW+ttsLG6Kq+RfVOI6UDXuMZ/FGI/Rlb/GpFsofWtFKtKpHDpIQ1DdudW7LQf7QwHs9Ktr5A5hpJ8DaM2/+LcNJW2dNubt6P60UFQh1ytPhLAvcjnOQ/YbG6EPULB1eHnHORZRfafsHajvjF7CbY7QqfQhmsOFga2PiUa7H7HFdCFiBmRKIRBsmAJhlwz0U/fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(2906002)(36756003)(5660300002)(8676002)(8936002)(38100700002)(31696002)(86362001)(44832011)(41300700001)(478600001)(31686004)(2616005)(186003)(6512007)(6506007)(53546011)(6666004)(6486002)(36916002)(66946007)(66556008)(83380400001)(316002)(66476007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZLZDIySExmNCtIejVNVWl2WGdWQ1A5dldrWnpHOVV0MktoakJqeUVhc1U2?=
 =?utf-8?B?dnJaRGJtcFFhRFhodGlReWJHRGlqeGEwdWFpU2hidys1V1NCMHZZRU96VjN0?=
 =?utf-8?B?SHFMRGk5WnBlZW1wbktiaEFTcmVwQlZVRnZCNWJNcHdzblpFODVDa3QyaWhn?=
 =?utf-8?B?TmJaVTR0b1JTVU00eEJtSkVkUk5ybnlGSHorWEljVExGN2JKNVliVFpad3dt?=
 =?utf-8?B?dFk3TnNHaDlUVE05T3hVNzJzVTRDTVFBSDNSWWxHUS9rTis2MDRObDc1a3J1?=
 =?utf-8?B?Z1VwbklJWmU2NEpjQ0xFeU1NQlkyYTRnNzRjV05tSFZUMmFYRVJOUlBTVnZa?=
 =?utf-8?B?S0xkWU51N0kvMW0zUUJhQjZWRXhIQWVZNTM0RDd3Q05qRjFQSloxVkRHYlV6?=
 =?utf-8?B?ZHpsQkxGZG4rZEtzYXRQTm40SFNzTE9RV21yQ29rcjNWTUtxa0lxUURrdFFW?=
 =?utf-8?B?RlZ5VlNPY3ZnN2dsNGRkcmlPc2VTakdBZjFlcGxBcHpIMkwrOUhzY3ArODli?=
 =?utf-8?B?TVpxZExGRzhGakJCRjhrREJpK0I0YjczQ1YwSXRJUXpWY05IZ01MZDJCK3Z2?=
 =?utf-8?B?SnpLaGgrZzhxQ0FCVVZzT3gzaFQvb09wL0d5THIrd1drQ1ZEdk9XVTEvanFx?=
 =?utf-8?B?Z1M5K3VWV2t2cmhmOWwxUFNOZGI5OUdxNENYcjJFOXlNZk94cmVWSk9XR3Q3?=
 =?utf-8?B?cTVuSFRUMW5QaWdwRXMweW1CYk56VVR5R3Z2YTVJaFhnTjVCVE9kcE1lbU1w?=
 =?utf-8?B?WkdmSC9uZnZDTFdHdngzR084VnJFY2hUeEEyS21UN3VUUzVIV28rd05OMHl1?=
 =?utf-8?B?dWttSzNkOUpObTVMR1B2bE0zenYxNjBCbnVZczlqdCswaEdLaVVXdVlQZmMr?=
 =?utf-8?B?dnpEK2VsRWIyU3NBRXdlWjdxT0xlZmE5emtqWmQ5VEV0Q2gwWGJGbjFYR1oz?=
 =?utf-8?B?ZDJuOUFNWGdSV2NFeFpFZXhCdVZVNERPY1RxbnJscjdrTXIxYUhPVUs2NTNP?=
 =?utf-8?B?UVdjZ04xbFJ3Vzc0SU1GME51Wk9wN1p3MHcwdWdmQ3FyQStmQkM3dkpKdzFW?=
 =?utf-8?B?bHUyK2ltdEdCcUlBNHQzajhBSUNUdzhyaTVubDlwaUJTYXZORnhWbmkxNG85?=
 =?utf-8?B?eUdqdnM3U1RoUGpMVkdRRytvNHJRZUtjL3JOaTBRR0VOcHhnbDNOMXJxbkZp?=
 =?utf-8?B?K0I3L3IyWC8wUEhPV2piZ2ZPbXJKSDBpbnhhVkFrWGdFMjhmR0VCeFpTbG9S?=
 =?utf-8?B?MVZzTmw5U0d2V0pFMi95UWIwbjVNYTZrTkdZRTdQb09oSXoyWGx3RC92UXIy?=
 =?utf-8?B?eHY0YUxadklQSGF3Q2ZXRDF3b0hobWR2TVkzdW5FZGU3cHBSekNRU3Y0cWJp?=
 =?utf-8?B?N21OdnVYaDZiMWtWZnoxakFlRUhwVFFrNnZ3dkJPSklUc20zazJSbFZMNXYr?=
 =?utf-8?B?RVpvTS82S0tYcldXOTVWVThVRWRBMytQcG52am5sM1lTT3dreXg1NStpSm90?=
 =?utf-8?B?a1JJVDJWY291R1pzUWtBNHFnSGhsdVFQS0pqRzZraENUdUZTaDd0Z3lsV0JB?=
 =?utf-8?B?VE5nUnhGS3krL2FMR0JnemxKRU5qSU1Ud2ErQkgvcG55Y3BWQnBaNE50WDhy?=
 =?utf-8?B?aDVWLzhGSWFKWHNiaFg5T2thTWlWV3hFWnpJTjN6eTA5WHJiZk8vczU2eW5i?=
 =?utf-8?B?WlRhMTBpa3ZzTWRoNDdDaFpiaU1JaTAzRG5GQ0o1UUs2U1QvVmJXZkt2MDJU?=
 =?utf-8?B?ZFVVSmlNZTFCSzd1WWJqTC9PVWxsYU16ZkVhNzk4MHpHcXFhQnpsVFBIWk5j?=
 =?utf-8?B?YUJMWnFydzgyWTY1MVFuMFZwdEV5Umdaa2lLNzZHckQray8yMDB4dXpjNFRp?=
 =?utf-8?B?VTQyNVN2M0VWankzRjgvRXN5clJXQkJrUVZLRHhLeVpzUFRIWHM0T0xLOGFh?=
 =?utf-8?B?K25aMWl2bFRVSjcyZzBNQ2t1OEpNNnZWT1lBaEJqUFdoZktaa3VtemtLdFhr?=
 =?utf-8?B?cXhOTkpScHdLOFhicVYzL2doRTAzT3RrMG9qRVhBdFBjUzY3MUJQODhJSXNn?=
 =?utf-8?B?b2hma2FPOWkvNExTdkNsTkhvYXUvelhNRUxZdXliL25hTllIcGdUTEQrZnBq?=
 =?utf-8?Q?67tM8UVWsMZXmkJFhMwWfIvcb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30959cfc-fb5b-4a5e-8d97-08db427eb5f5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:40:19.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4C4+P3eEJ4deXOKW+DyLab9B5ydQjGb7Cfg2ZR/m0Gt4MuHCNY9GAXPTC1EA+Ledgotjik5LLPAjwaeqIqeLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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

On 2023-04-20 18:25, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed mem has no associated
> hmm range or user_pages associated. Keep it at process_info->userptr_inval_list and
> mark mem->invalid until following scheduled attempts can valid it.

Thank you! This patch looks good to me. One more nit-pick inline.


>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28 ++++++++++++++-----
>   1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7b1f5933ebaa..fad5183baf80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			ret = -EAGAIN;
>   			goto unlock_out;
>   		}
> -		mem->invalid = 0;
> +		 /* set mem valid if mem has hmm range associated */
> +		if (mem->range)
> +			mem->invalid = 0;
>   	}
>   
>   unlock_out:
> @@ -2576,16 +2578,28 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>   	list_for_each_entry_safe(mem, tmp_mem,
>   				 &process_info->userptr_inval_list,
>   				 validate_list.head) {
> -		bool valid = amdgpu_ttm_tt_get_user_pages_done(
> -				mem->bo->tbo.ttm, mem->range);
> +		/* Only check mem with hmm range associated */
> +		bool valid;
>   
> -		mem->range = NULL;
> -		if (!valid) {
> -			WARN(!mem->invalid, "Invalid BO not marked invalid");
> +		if (mem->range) {

You can avoid unnecessary nesting and make this more readable by 
inverting the condition:

		if (!mem->range)
			continue;

		valid = amdgpu_ttm_tt_get_user_pages_done(
				mem->bo->tbo.ttm, mem->range);
		...

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +			valid = amdgpu_ttm_tt_get_user_pages_done(
> +					mem->bo->tbo.ttm, mem->range);
> +
> +			mem->range = NULL;
> +			if (!valid) {
> +				WARN(!mem->invalid, "Invalid BO not marked invalid");
> +				ret = -EAGAIN;
> +				continue;
> +			}
> +		} else
> +			/* keep mem without hmm range at userptr_inval_list */
> +			continue;
> +
> +		if (mem->invalid) {
> +			WARN(1, "Valid BO is marked invalid");
>   			ret = -EAGAIN;
>   			continue;
>   		}
> -		WARN(mem->invalid, "Valid BO is marked invalid");
>   
>   		list_move_tail(&mem->validate_list.head,
>   			       &process_info->userptr_valid_list);
