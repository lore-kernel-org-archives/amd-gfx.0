Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE83C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 13:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE0D10F2D1;
	Thu, 28 Apr 2022 13:51:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C5C10F2D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 13:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrN36QLXha7MIOc2LI78wOvCD1kCnSzn7yMzrRVt5BoLZEI+D2roQtWADlayofZpxn7MRpLYr0X5xjWIvjTGErUVwKDeGfYBU6wflBsdCwpJWDSD2LfIcn2vMkDz+Jk6woraDA9e2eCOCm2/9dBUGfvnUjEuVFeZiV408cp0BXFxUonNQNtvywN8EQu3p3zllKR1YSKgs5AmmGWEZwIdUR5awFZPkzcxZOVDgpQSOMGKcPTIVvMUObzR+u8pIcl1sAw9OBXBKvspQoMNbKribkBjEf5+DNMT/HwiPOu58eEVkeS06k1WUfhRfu/hDX67bn5Wv1R/tI5FC521E+USgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0XOfuEBvzRsycKv47TN46MfywirmUkBs+NN+rdayks=;
 b=S0SQlivZVRv7gKvRqE21lCuxPvnkEP+BusL6tXgOx/5b1REB2SAsKuzpbBjZyFRMuRXbFoVleNBYPTaBeHgpqmxdeSffYSlAPHe/KL0tPf70FOqCxsPLd+/XwSLbGI8+0x+IG5VTopvRCeYM6Mt1WZPaJoxVIDZBXJxM8hITLT5Nslcnz/f4hdKwv9XaPeOqBCaXY3oT0FHPm++7bbQly5CuSo1DvK67o+Ol7g3xzN1x8xn7OVhbCKJd/CFERdNrEae6S1FSnlpWAeIbLtIa+FmZ50PmrAFna/N07OF1MJUl+Zi8RRRlIEGRc6NDCAAliWE/+mMunuxKNKf9tzhQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0XOfuEBvzRsycKv47TN46MfywirmUkBs+NN+rdayks=;
 b=k7WE0mS4LKmoFAaMTGjseli/kIsZLZdbr1mMIwA7VimOa6c2iioj1O/OTjIWOLaz4VxWsYm5euPfHkw8Ev0k1Mxs/d9FAxW07op99/MOqqhpaZe/nIouHgttdDHBKXzYvnIzSJ0GHlkHq6H/Bng5xirEBMf7/+rKL1VCQeTKjfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3727.namprd12.prod.outlook.com (2603:10b6:208:15a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 13:51:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 13:51:20 +0000
Message-ID: <a214a2f2-c790-a76d-5b67-0712341ce69a@amd.com>
Date: Thu, 28 Apr 2022 09:51:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Free user pages if amdgpu_cs_parser_bos
 failed
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <CAP145piim21dDoS7fsv9WQ-Toc3xr-xG7ayP7_T+F4SeS8AUmQ@mail.gmail.com>
 <20220427230700.11891-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220427230700.11891-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbfb7d6-cbfe-46d0-420a-08da291e2c7a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3727:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37272B49B153573376938C1F92FD9@MN2PR12MB3727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oivBKbyTfIaoO4qOerK0zr74litEOH58VZsVkP9+S0AgeTBCX3DaswF0Kuv5d2+qzVWpZxe9GRlhYNAw8sr74djHkjgI43uXhlDUPJdgU0YJgE3HJABYwFW4SmY987EGQ9/r1sRJ5B1muy5+18XT2l8r+3zcKEl+0jk9Tx7rzoxZr5DxBsS2B496MwHbJ/u+lmUE/UEAZbkPpj5v8TbJSR9OrVQ7SMwQ2QwO8jwb403qUy8EZxD56Ehl39Hz6nXVneOpc/hybXiLdZfz8dwJwuStJzFYBD3FtuiYMHCNe79RQkPS+LZeh9zWpnfnmYqT1OTVBYFSJmjW1sr4R8XbPn65v9HI3cx8U0+QZpGR9hegYqe5oV7jYx+D2Gb0KEdM0/tjPHW9k3apZfCMgstz0wXWWQh+s043n+j/uvRG8BN2ikSUy1F2koUveGXafakzQcTSVwM7KxcLABMiFWafuglUrGGv1vm40k4wDi7jZvyrnzfuyfk5bsDQSs2tNWjzysFgUWZfO8kCmZrgg96JTXTpr4rCKdD0mIebMCSdK0x4i8KAtAS7Zh+8bioohZuT7/9J6By/43MJl2FRt0zbeCSe/cxOmjPAO2r2n7+247ARR6q0gMJhqGUEVEJkqZre7euajJqbbDBSKqHv1kxsxp/DxvaPJF5/DZa0mDZP6BfB2HlNEM4HSJ1+pHrHsuhhHHSfemUT6frW5XiD6NOxKa2VaEJBaU+oELBuiIu6djd6Sd3ywJtfyCgH0rr/WbtI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6512007)(6506007)(26005)(86362001)(83380400001)(31696002)(186003)(2616005)(44832011)(8936002)(66476007)(66556008)(8676002)(38100700002)(2906002)(5660300002)(66946007)(36756003)(6486002)(508600001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdidEtXZk93MWRVSk9uTXhiVlcvVVZTOC9qNEppMkJseXRJSFpCdVBrWEE0?=
 =?utf-8?B?L3U3dVREYnZaRXRHWHV4VTFPd2pMbS9FSERkQmI1ZmY2eCtCYjZSM3JSVit2?=
 =?utf-8?B?Qyt1dy9OZ0pZYTVJU256RWdWbitvd1o2NDcyeWUxeDFYWExjZ3lBQkErMFl3?=
 =?utf-8?B?Qy9nNlovK01OdHpsdVZ5QmkyWkp6QWNCZ28yYzdxSEE3ZSt1SEVCNW9neUZa?=
 =?utf-8?B?WkUwcGVhbEY3c3AyVEJBbEgxZm9CajVSZUhmRzBtR09HNDhSR2J2aGE2RGh1?=
 =?utf-8?B?cVdCNjFDNHA3VzdGTnNkRlhjZFdmSWh4MnZJN21YYUFhcHVzbFQyOUpsV2ov?=
 =?utf-8?B?alZwcUNrM1U4S25MUGFSalFod0lTLzVzTDAwYUg0MjRIMFh1OFkzbGlqZ241?=
 =?utf-8?B?cWppNTNUZnhWWWluMWNpaWxwTG5vWS9lM21Rb0thTzZtVjJOVVpydGVWMUcr?=
 =?utf-8?B?OWsvSDN6NmZ4NnNkNC9MM09TWVZLUlA3WWluZWo4WmN2eTJRbVNCOWQ2UURx?=
 =?utf-8?B?MUc5amVlYnQzV1ZSaEJaSFR6OTZTbUtKV1V0NElRaXM3WDVRdTl5WXg4RlA5?=
 =?utf-8?B?TmN5UC80QTRhVEVYSGxyUzVreGVOMmY0cW8zNEJ6eUdRQUpxVkVBSzlndjM1?=
 =?utf-8?B?aUY5Q2h0RmI2bm5oOExpak9YdmlodHUvTVlIU2hlNTZFR2RIVTY5L3pPRlhV?=
 =?utf-8?B?Yzh1RzRyMTgxcFZ6U1MwSThwUGlSRHFFR0RYeWxqNk1nQ0VnSmYzcVowOEky?=
 =?utf-8?B?cGdDTjhCZGpMdGVUVDQ5VmZWTDRnc2crVTJ0ek8rcHAvenNlWkpqWTVXRFdl?=
 =?utf-8?B?aVJURmVWOEJIVENUNEt5Zmc0cmRVNUFSZnVPTTBXdkxqelhIRnNNSlYzbXdD?=
 =?utf-8?B?dzBNS0t4UE4rVy9kZzNPTC9DZ2NNZkRnUm5mQUFhTE8wcXoxMFdkVkNzWHBh?=
 =?utf-8?B?U1lGU0JZd21STlJzYXVvWFYzbERSeld2VkhMV3Z0THhrcFdtUTQ5ZDAyekJi?=
 =?utf-8?B?TWJsdzR1dWhvNmd3ZEhuUnhadTQ4Yld0STVLc1hSdkNOTkREZHg3WnZTQ200?=
 =?utf-8?B?cHpseU5tdGt3a1FEak5jZTN0RUo0WFM5MkhSNCszR3VUUVFhYytXL0hSVXhO?=
 =?utf-8?B?YXltUXk2WHgxT01zdlBSR3JIUkhDZ2VndnlIbzRCYlpEN09qdnpkem9jdzVj?=
 =?utf-8?B?eGxJZVc1cUZIVmMwdlBnRTdwN2l0REUyWVJ2aEdCYjlZbE94N3lLUnNyY1FJ?=
 =?utf-8?B?UXVjYnhIcXhPb21LVkFNR08yRmJXV1dOblYrWGdGVENiNjkvRGtMV1l2VEJK?=
 =?utf-8?B?dXdlUE9oQ2F1Z2hpQkpyTkxZdXlxREpGSWJYL0lGSkhRV0VTK2p3UlJQUXhD?=
 =?utf-8?B?VTAyRHpPbGF0MlpOZllHeEpNakpxYTJOaTZabDZlWkFIYzNmRnJvdGFtaDVO?=
 =?utf-8?B?S0JwOE43dHhvWXpLSVNDQkgyY295NUt3aWpHY0w1OE55K0ZveVRPTDRnZmVS?=
 =?utf-8?B?MjZDWGlZNlNSaG8vbC9SdzVYQkhDZ05hQi90blhWN3I0Ukk2ZlRjdTJkdVBq?=
 =?utf-8?B?K1gwU2Y1UUVnaGs5VmNRcndYaExteExKUWtXRXRJWHl6WDk3M2ZXRWhlVnVJ?=
 =?utf-8?B?b01YbjdWc2VPeHFRTk84UGc5OTZ6Z2taeUR3bFVxRmhmMmZpY2FkS2VoaEZQ?=
 =?utf-8?B?UUJEZU5ObThsM3ViRTFVbXExcUcrcDJRc1hmL2VpeFkwWm9haHd3SU5LblBn?=
 =?utf-8?B?TDZzUlVGVnNuRnZWQzF3S3E3bzZTWUdqNXRhYS9jZ3ZaUHVtR1ZkbkRZaDkr?=
 =?utf-8?B?VXZaTGZmUWJoT3ZrTit5a0EwMllzWEM3Z3JmQ2cwemlzWThnSlhZOGVKaEpN?=
 =?utf-8?B?M0ZKTCswTlA5YXl0bnBlb1RiMGZOSWZOd1RPWWs4cTNaWGFTdTRlZ0V5eW9S?=
 =?utf-8?B?c29zdTdxakI0eXhyQVpTM2xYeHJxVG5zWFh5Y2hHWGl6QkREaVNvbXMzT3pz?=
 =?utf-8?B?QjM4VERkODVWS3AwN0JFTVBieTE2d1ZNWDdZWFRqbXJMbGI5bE04RVA1b3Yv?=
 =?utf-8?B?cGw0Q1NmMlYvRGRMMUJQMTIxL2VYUXhCZDRJKzNWM0RwV28rNmJHdzI4aWsz?=
 =?utf-8?B?S2ptb3FFVElkQlVtNEtuaTlKbFIwTmJSY0hsa0M5eGI3L24vZmx3cG5hUWVM?=
 =?utf-8?B?RXVJRE5PbytHcXQ0MXYxL0swK3JqaW9jWkpIeDNKSU1IWlVCdVZBUVJ3VkF6?=
 =?utf-8?B?TjBnbDcxWjVKSEFzUWxuR1l1K0pmeW1SblJVTWJBVVlXQlY0eWx6a1lRaUxW?=
 =?utf-8?B?c0N5alRMN1U1V0R6MTU3UVNqWlhwTGU3ZGxHVEdFU0llRkU0NWpvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbfb7d6-cbfe-46d0-420a-08da291e2c7a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 13:51:20.4887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA3j5enujRDn3hF7K8wv3fDQiXc1Rh8kktIaPNoWm6oEBW0h+vwoIbxuS14FvP50lZSi3qLUAzCozdZXuzxRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3727
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

Am 2022-04-27 um 19:07 schrieb Philip Yang:
> Otherwise userspace resubmit the BOs again will trigger kernel WARNING
> and fail the command submission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ea28942b0ede..44dcbef80229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -550,7 +550,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,

There is another error case a few lines up, if kvmalloc_array fails. I 
think that needs to be handled with a goto out_free_user_pages as well.


>   		if (r) {
>   			kvfree(e->user_pages);
>   			e->user_pages = NULL;

The above two lines can be removed. The loop under out_free_user_pages 
should handle this.

Regards,
   Felix


> -			return r;
> +			goto out_free_user_pages;
>   		}
>   
>   		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
> @@ -567,7 +567,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
>   			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
> -		goto out;
> +		goto out_free_user_pages;
>   	}
>   
>   	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> @@ -649,7 +649,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		}
>   		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
>   	}
> -out:
> +
> +out_free_user_pages:
> +	if (r) {
> +		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
> +
> +			if (!e->user_pages)
> +				continue;
> +			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +			kvfree(e->user_pages);
> +			e->user_pages = NULL;
> +		}
> +	}
>   	return r;
>   }
>   
