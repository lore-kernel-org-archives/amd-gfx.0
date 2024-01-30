Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079B4C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 09:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9187310F85A;
	Tue, 30 Jan 2024 09:45:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D252112E8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 09:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBTFBR6DsiXASkIxiuJGB06sBKSrIM/SZhJzKOkXmWoUzdLyBTuY8Jpm6Y0KI1LCGAGM1LfQSqQiZb08eZEDLalRi6TqaMY31OG77wVkmgIXviCYbEqkCKqiK8937v7AuTPtV/jCT92tdk5hihdMbIdRWoWgPNo52vWyXpIdol09DW7NA/RQZNytEsm9yNdMG2fFVFYViciXFbq8mhqCp3NvV7/hXdpVZmjJ4nEkW7CBoZHruUYrRL12ytuq+87MV7s0hkdcp3JyKTHfhLxwqWfANe3Dx68YEmq0zm+E/ueyXn9vHzCUXDdeYWnklDFBYt0HjfIRlsdlzanYdcDUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw25UNZEzYo0SJhTyBosmvTOHJjyptix6ckRxfwcvE0=;
 b=R+ji+i1LE93sl3hhn4JQeYOtHEwLbRZ3n0TweEISKWCuRLBtaMM9zAjRL6lj1L4DF0niS3LulpV92u0fknZ1Q/uiLqbEx64gyy/an/1MEZh530S40RK3if7lVMnQ8aSPdn988pIqcVEbA2yp1+knnTxEQvQ/y55EImGFXiw3lHLAZxLjWT6Ds7cTA2aSw7Km3DAILwrjmSr8stfe/21T04vpP0fh7jvGXP57vhMC0iGDV5VSpXH9Z3fMW1rjEpa2l7qy8L2MfbsYn7556j+a39nKxJnrq8nrg+J3tJ2OU7dFOh3fzw9NNoq9cMZDGZJSd6S8KoyGhg+T6uWGoj8skA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw25UNZEzYo0SJhTyBosmvTOHJjyptix6ckRxfwcvE0=;
 b=pkPozK+SZrQJFOfKqmCdmANb1yz7r4ofIgxpbTOVVvk+k0ouVZQ6vG+So+297IPPoCnHPpispZvT19wwclrp1JEELHtw4qk/0hTsZ2EzN066qekSa4fMcDnCqxOwZyoicRbpZbLVT2HbKP5jNQtdL6Gsh4ZPA4khD3S2badrP1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 09:45:35 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 09:45:35 +0000
Message-ID: <bc1a5ab4-a3d4-48e7-b058-f6d36ce64122@amd.com>
Date: Tue, 30 Jan 2024 15:15:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add NULL check for kzalloc in
 'amdgpu_dm_atomic_commit_tail()'
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
References: <20240130084156.404153-1-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240130084156.404153-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a31915c-b7ab-4608-204a-08dc21783515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzDYMCGu9YCCu1IcnGW7I1NnYm+T5yDotC1fD+uIUS4Uou0GCbL2YNXkv6g7VeLEDQgvG+wlBTD0NeRGP4+FXM6X6mhYFX0fcyyAljEo4w98GbDtIbHAZlM2h4BrPNRG0tmafwTjaJ4z0zItKnOpibG9SEHi7v1gy4t1DKk0dcOCVzMPelsJYeBrP9zY1dZM7XjGFNI640sEiCAy2HVQNvhiCJPONvRx6yNUxLEHLaI0LudC2Jsns0wlz2WAaG5UrVDepvUXCI28d8rRw7UOsVyYzSiHNruWRp+d5YxOr7M9rJHejz6gmjUuzCt1Gj7gGNZmd2ZRE9M++2VNELTbpmr9/orB3PE71ygwg0o6colwBcVi5BNVH5vUDsxZ8Xz+fmoIakopmBzwVleF5wzkiFF+HTUmDL5sr0BmkgV5Pjk5Dq+dN188TjF+dNZ0RDH0yZbL5nNgcfASP+IVtR0zE0uXyv11XbQGro515YoqLOyR+Rr3shlC8cyfu3T9mx6prnFhRDCuhhCLL2Dr5bVksmL6Nb2SKVq5/Z/apWgvzEBOdV+xVJ31wA0CH5w8lO/aUyEMhhedFMXNdxs4sDLCG8bPDexqdBqgAS9vSoBtfaELXQ9giD7gdSbR+JpyS7jXwb7ANeMdosn+kgkD7qd5Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6666004)(110136005)(478600001)(86362001)(6486002)(31696002)(38100700002)(4326008)(6636002)(6506007)(83380400001)(5660300002)(2616005)(53546011)(6512007)(26005)(54906003)(8936002)(66946007)(66556008)(316002)(8676002)(36756003)(2906002)(31686004)(41300700001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVseDBWYlBQNHpvQXlTSEFEZWFDRnpBOEFuNDNNZWNCbTBzK09IVnZOT2NV?=
 =?utf-8?B?UUhRY05IZitGWnZocCs5N0dlN0NRUnI3TW0vUWVrUC83ZHE4MEFZSmZ1YW13?=
 =?utf-8?B?bm9jOXM4V29PRWhWQmd4b25yS2grMSthNUJZaDF2SDJBbGZ3NXJWMXVYRG9j?=
 =?utf-8?B?ZG1KQWtTOHBVaU5VWjYvQ1l2M09DOXg0RjExNTZlTDc3YjFhS1hFR2lmbCtR?=
 =?utf-8?B?bCtFNEQ2YzkrZDd1cUt0OHdBU1M0M1dDNVRPWm1udTZxN3orTzJJc1ZJeERz?=
 =?utf-8?B?WE53UnE4SHlvS0tmdzVFNFlxOWJaTCtOVDFwZ1hrb1VKTWRLNDlxMmd6c2to?=
 =?utf-8?B?WXBtaDBrM28xVWFFVFBYa1FOVm10SlR0eVdqTW5vTEhsakFKd1NLakdtQzR4?=
 =?utf-8?B?SkxuZWRXbTVuQmsxUWpUMS9vRUg0WDRRTVRBMlRhcEZYREhrNGJxN3JCU0cv?=
 =?utf-8?B?Y0wvZ3h5aTR3R3VGOGFzVTN3MWZScVRpMUpmQ0kvQ3NjMkwzL25HaE9EazBu?=
 =?utf-8?B?TTVJNzJIY1N6YzNIRGdTWkZVV2V5VHFDNXc2Q2NKNnFUbTE3cmRNaFBGN2g5?=
 =?utf-8?B?L1lJRENTL0x5dU1WZXAybkEySnVUR2FpblUzODUzR1d2V20xc0NiWTA5OURn?=
 =?utf-8?B?WE5ZSnJUaFY2TCtWNWJwQjNqVCtJQ1F3c0dKYnowdXRMRzJoSThqUHFnTmNC?=
 =?utf-8?B?K0xSejVsWmZoWVRtcGNmUkdYNWhwV2FxSUJweThYVGZLL3RYejZUY2QzbVUx?=
 =?utf-8?B?WlVLcDJGRTI4WVk4NG5wbXRhdUUrQzBpYTl2a0dVTWFGQ1FKaGFRUWwwdGtM?=
 =?utf-8?B?MXpyKzZjQnRmczc3bDJsMTMxUWpnL1FnaWlxV0ZtMlpQd2NXam8rKzJWanJ2?=
 =?utf-8?B?eTZheGFwWVRaZEhYcWtIdzZjbmY5dTFQYTZlMTc3RlNFN1Q1VzZoa3BkQVpS?=
 =?utf-8?B?TkFkNnV2UkN6MHR4cUxKWmw3YUVSS0d4NS9tWkExTU5ReWhITHNheTkyR0Vj?=
 =?utf-8?B?ejQzOUlScUlNZmJ1OU9BV2w3Rk1lak10SDlkcGlLUmFSTW91aG1QVzFkWXdD?=
 =?utf-8?B?Q0pWRmdxdFNZYW5kU21WQXNWYVhlTU11RXJuTVZrVDZNSnhDQllrSisvRlh6?=
 =?utf-8?B?YVdZbEJlbUFGVWdmSnp5YmlPdWlPN2pXQS9ma3Vadk04SFdYcUNyWFBHWGg5?=
 =?utf-8?B?LzhGUFA3RFBES2Q4aGlpOCtsd0MyVnR0dzUrb1hIV3RoYUhHdE0yN3FNb3hX?=
 =?utf-8?B?bHNKL3RKYmRFUnQwSUFhdVpXNml3eHQvMW5JSEFLdGlEdFlTMGhpSTJLbUZN?=
 =?utf-8?B?TmFNakhNRDB2cmVOL2RSMUZiVCs3a2lOdlB3SXB0VzFJQW1GbFMwOHQyQThv?=
 =?utf-8?B?NjhRd2k2aDlUaUJUb1pHQlN0aGZmZEFGYnArek9MNWRmUEVPd21pV0traFZp?=
 =?utf-8?B?N1JMTVc1UTBVOXBOZHNLOW5DQVdSOExEVVpWZS9rS2REbnZJZlI3bUx5Ymdm?=
 =?utf-8?B?MUtFc3BpckZZWUxBRUZpM0g3UFRGaEhJeit3KzVPOVduOGtrNFlJNDZDVDZQ?=
 =?utf-8?B?MzY3ZDh6UEhRVkxoTzFWWWNKL1hBZWVFWGhuei8wZC9JUlNkd045V2M3cjRC?=
 =?utf-8?B?U1dVZDFETVRuOVVDbGdDN2ZqaTNKZjFkL1cwbGtLZVhCVWxodGgxdnNzNGw0?=
 =?utf-8?B?QnRqZ0JoaHMyNk1BODAvTFd4VHp0Y1Y2bzJRTkVFckxxRXNyUnVMcHh0UjlD?=
 =?utf-8?B?Myt5bTg0aHdFd1ZNWGdwNzZlbnlvaDFGMXh6VUlyUDgzTXhsN3prdXZxaHpm?=
 =?utf-8?B?czRrczBjUEJOSjJ5OFFhVkFpRWQyTGsrZzZscTJMNjFETUhoT3ZmWUF3U3Jj?=
 =?utf-8?B?dnNaMTVvMEx3SW9DZ1ZCbXFlay9zbDZWb2ROYW1MODhMak05Sk9SOE56UzEw?=
 =?utf-8?B?aVkvMitmWC9mekJxbDZMbnZ4dkJkTy9hMkpndGVXbkhCZTA1a2hBZk55NjZN?=
 =?utf-8?B?c1RBKytBazVvY0p2SERFTlY0SUREVHZTKzB6cDJEcU11d3RWcEp3TVc5RGFi?=
 =?utf-8?B?Qjk0Vm0vc1FWVFdpb0ZEd01iMjJxVEhrMjM1VlB4T3JETjZhamZSVnhLUGJJ?=
 =?utf-8?Q?yZ/jXEjW5+zM31o9I7Ndn2GUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a31915c-b7ab-4608-204a-08dc21783515
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:45:35.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Kcm6dQlsame2VMaW4+AxIBmLeTmjc93bvvUI4rvGphEdAgf8uW/0FirK7HRIjTpEPMOVMdrNLCmnEpIb1oFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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
Cc: Julia Lawall <julia.lawall@inria.fr>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, ",
 Tom Chung" <chiahsuan.chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Cc: Tom Chung <chiahsuan.chung@amd.com>

On 1/30/2024 2:11 PM, SHANMUGAM, SRINIVASAN wrote:
> Add a NULL check for the kzalloc call that allocates memory for
> dummy_updates in the amdgpu_dm_atomic_commit_tail function. Previously,
> if kzalloc failed to allocate memory and returned NULL, the code would
> attempt to use the NULL pointer.
>
> The fix is to check if kzalloc returns NULL, and if so, log an error
> message and skip the rest of the current loop iteration with the
> continue statement.  This prevents the code from attempting to use the
> NULL pointer.
>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0bf1bc7ced7d..8590c9f1dda6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9236,6 +9236,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		 * To fix this, DC should permit updating only stream properties.
>   		 */
>   		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
> +		if (!dummy_updates) {
> +			DRM_ERROR("Failed to allocate memory for dummy_updates.\n");
> +			continue;
> +		}
>   		for (j = 0; j < status->plane_count; j++)
>   			dummy_updates[j].surface = status->plane_states[0];
>   
