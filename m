Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 18:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAB810E0F8;
	Mon, 14 Mar 2022 18:25:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E954E10E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 18:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4PtigQOz48LDGM99lhS78IMuSUpsq4XX/GgN+lK1g7j4Rox1egrK7STut5ufK1WrLd9DD/9b939K/tkop+TX2rG6fTwyMHGNboPdpkDSw1hR7tWumH7WnxrmIXwb5uC5jHci+eFd76dIqy69tdWwfNbYKgqSc50zpGMknCQ+AIU3koK5JCIXCeCzE86MrHphH36wzLXKElx/ioD6lyxKtLEZ+vUNpreJ7CpNjz2s56DO4sJx5t1lFFfy0qalRVahD/4TacBLY3uMHwtDlWl9M93FG7UTjtvrjsYD9Ka/cZrjD19oCCuoEq/01R+u7Um49VAviiILCHtTbUeSu4Faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1yML7G+ZDaZkV2q3XEiSUDwcpGoHCK/U0qd/QotGiI=;
 b=HRDS68O/SENGloinzOXFIqX/GSmNqu3o+KaGPNk8zWPg3JDqfgTgXVbjyiJr1/x9T6U/bemZdR+Yg0kKUXC8CLsZGEWySJwUnjAsoOSdXUyy9Tu/r5sfMNMcvtZqVxgxy9adYgoo17NpZtuDcTGNW6/mzPMuiBL6Ii/A35EX4qXhMvaiEb7rHE2QadjNRuUtJ3TLK14HwxGl179XAQu96Y/gN9+R9kjYtmFKKgFwcZMDiJt4AhAjzknI7x1iB5T2cp6VRXM67w7B0bvY6Vn7zVrjU4Jx6Z63xJUzJIa9YYcBkqwMC88fXWnl1lciV4K08gjzMNXlCt58sJvuYjttUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1yML7G+ZDaZkV2q3XEiSUDwcpGoHCK/U0qd/QotGiI=;
 b=OgsUh4g7BAP4X6zHvilxR2wuDqu1kkS61EVK7UUuxDjPi/I2mY/EQ/+VO7qJdBPe6bVKifHHmuq75ssiwD3xTG4Kjah+5cXEqyeL3VDvpAgqPJgSgw4PW5/JlABYRJT55xaN51GAwa0nI2oXyNB3Bmuvd9P6vvl/Z9wlWgT9MPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1742.namprd12.prod.outlook.com (2603:10b6:300:112::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 18:25:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 18:25:04 +0000
Message-ID: <564e2d26-fbf1-64e6-aa29-e17aad6cb5b8@amd.com>
Date: Mon, 14 Mar 2022 14:25:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] drm/amdkfd: update parameter for
 event_interrupt_poison_consumption
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com
References: <20220314070326.21828-1-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220314070326.21828-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea9a241-d9d5-4c07-d63a-08da05e7f5c2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17420C21BBFCB28C07EFEACC920F9@MWHPR12MB1742.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDZnJQVoFjZzbBcB5T9T9u6g4A8kRpxm9sYuipfjZDJjZnRi5DM52x+D2KrKVUeUZ3G5MC8EoKSyung1P1WNMFERFrSfRb7lOk3X0kQ+mjEiD9GBeS8TxeDDoHhBGBClWHtMAgychG2npoL2Ah22Xzv3gnlOFbIsBgzsQ3SXfOkYrdxbXxlzOqFaErNnS9QtX6oRO3WlKlPYgUbOXKlBA47kzrWJXvbeZaSwLUinltDzjfBVVS6YsWyoi1iRxA2emNmEKzQcl3fEs5qKP4WqGUqzbyqdgxMCamSjp/Dzp3SsxyRbhCNfM0pMiHQIzU/aO6nPMgfarq9sBGrEea1SrRnRK5+erNKHpnoX2AGaLqfXVfKA3PSkC1bA7DG0jasaEi9o08A1w4HFudlQ0WsfQ1XZrLV2EzM191Youy9Cj22MxAHet+VkNphrLC9vtyC9WiFfb0Hnjrwtn7HDtrmxDWqVDfPzQkhqclGdiJ1kIglJU9W3QZoMS93qM9gVq0dhyffTpMrX1WYhE/FuBb8ZTNxSNoL44Fc2u0llanzLYMgO1+A0XCzAQkWy+CcIfNRiPDPymkcoF6KsK4MjBHoJf2LycJa35YJF7XaNKNsZxuRWIyUNoqBD7UYoHaQjZsj7Rgx+oVCP769xVeJgzS6CQf1pwE9Q25lMlF+yVxACa9cCydgeo/Yzw0nLtMv8wLTiET+kxwdw8i7b1w8QJHcn5FkqpMWbpHoqP22sC22KW8RWCe9ka6CUNGsuYUfSRI9w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66556008)(31696002)(38100700002)(186003)(83380400001)(86362001)(2616005)(6506007)(6512007)(31686004)(26005)(36756003)(66946007)(508600001)(316002)(6636002)(66476007)(44832011)(8936002)(6486002)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzY3TDltalRNNUQvNDd4QW1RR2w5VWI3QUpiM3QyMnhJdi9RMFdhNjJSb1M3?=
 =?utf-8?B?RmNjT1JWYjhDTW9ZaW5DWWs3TWNVKzVEZzlNUjFSSU9Rb01rN3huRkVFYjVG?=
 =?utf-8?B?dndJbG12NXZiRy9SajVjQzNZQXExMEdWWHM0WXE3RURYL1o3YkdLb2FFblVG?=
 =?utf-8?B?NE1MUHhOWFdkUVN5S3BFbmxvR0VLNFBYU051OWttdXZKRDE3ZTAwcFRRUWYv?=
 =?utf-8?B?eThnZzR2RXMvS3FsWHFsQjZYTHE1TXJ6dFY4QVdlWWN2Tk9VZ3JuMUQ1ZytB?=
 =?utf-8?B?Qmh3Y2Q3Q3Y2Ump4VFVlUXY4RXRXcjJ5enJSbHVzZU9nS1VPYVdZY05LSGgw?=
 =?utf-8?B?UXpXSDRtRE13cUIxcHhHWjFMVm1nbjcxSHFpUjBoVjlWa1NJMXRzN2hHNjFu?=
 =?utf-8?B?bTFuUGtJTkhvdlJvVFErbTl1cHhWT3RWTFZPamgyMm5BajltampIYyt0K0Rv?=
 =?utf-8?B?QjhEVWNGVGNONTFZUjdjV0hJQk41OU5IRjZmbVgvYXlaZTFpcGJBbWdhY0sv?=
 =?utf-8?B?a1Fva0J6MTFNRjZEMWNla2Y1bDVQMFgrWTkzTFJaUEJWZ3pZdzVjQUs0d3kr?=
 =?utf-8?B?dTlMK1k3bTI2VndGOEk0RG1YQUJRaU8wTW9uc3kyOFFGS3kxYUxQdXQ2SUVG?=
 =?utf-8?B?aDRvam1CWVZmTWVTdFhSczBBQzBKcVVROVdTcXpUVGVtZGJJSjRNWUl3bXEr?=
 =?utf-8?B?b2tTbGZ1aklUdXJzSmRnRE91MFFHNk91NGZhWG9LeXcvZGs2THRiRHB5NWZs?=
 =?utf-8?B?dmtDbHY2WU1henJrOUJEYzRSSTdQQlRXNk9OOTFOYnF3dkg0R2JNb2VjVVlu?=
 =?utf-8?B?MGlWbC9YdU9PU25wTnNIR0ZMZWI5dzZBVkI0WmxvYUFXNnlmcldDdDJXWkR0?=
 =?utf-8?B?U1NLRTl4OCt2UzVneDRDYnNGcFRuY0dRNlpJQmh2RGNlRXdIb2R0aXJ1bnhy?=
 =?utf-8?B?U3M1Qks4YVE2dThvUDJablVwejhQYm1GTTdwR0hJaHFEV0RhRVhxUng2amJz?=
 =?utf-8?B?MTRDRGRTeVkrMG53ZEZLOExnck9CVEtGSVNvemI4WkRITDYvN1dkUzQ5STNJ?=
 =?utf-8?B?dXJ1RkhJS2NxekV5Y0V6QXllSjBCTkU3N3Zabjl1Y25NTWRpUk56UEVaM0tV?=
 =?utf-8?B?UTFFNFl3R00rREZuZ1lmZXFpUTgyRVdaN2tlWldRU1F6elZGT2NTUm5CRmdF?=
 =?utf-8?B?aE1CQmlLSTNIQWtkYzNGZ2FVZVJ2NDYwcW9zNjhhYVAya0l0YnFLN3ZFVTJp?=
 =?utf-8?B?cTNkY1AweUlwZkJWbnVVVHI0ejVDS2FGS2VWbzhjOHU0cGpmZUNnbzNmODZI?=
 =?utf-8?B?S0pYQ29qc09qTE1xYkVESEZrcVFyVmVSbGk4ZStoMjNIS3pkcnBoYWlHU09Q?=
 =?utf-8?B?QU84cE1HV1c4SGc3bjRPRnRFOGFCKzNqK0Mxc21lcUxQVlJySEp4S1dnZkFr?=
 =?utf-8?B?UFNZbitqMFZ4ZHVDN1F1RW8xdGwwZndpVXFmWEtFVWNqeEUvbmRvUWVXVng0?=
 =?utf-8?B?T2R2YUZUS3c5Nkt3dmZsc2I2MlViSzdsWnRERjlGVHV5VzFRYzNxNUJOUUg2?=
 =?utf-8?B?QVdPZDNxaXlBVU5Od29XWkJwVVd2R1NHMzVabVRWSWZmdytQWStDVVpjNzMy?=
 =?utf-8?B?UXNhY0VjMlBzVVptZ2ZxNEo5TE9QMGZLSm5vZHFyVDl0ZllsVlM1dEs5MFdM?=
 =?utf-8?B?STVaSEVzWm5lZXozL3NDazdsVjFwaEgyUGhWTXZyL3U3RmU3SzlqTW5IWWg2?=
 =?utf-8?B?SHB1VXJlRzZlaHhJWHVoY0wwbTkyd201RmFMeGJaenFSYnBxUythRDYvWGV5?=
 =?utf-8?B?U29mR21FZTkwU0FINWJXOWZpN1V4SVZWN3RVencxa2ZGUHhLVWxlK29BeWU4?=
 =?utf-8?B?VCtsRmRodElmREhPSHo2M2JMdlV4RXRXeSsvUGZtaUxZWW1PNkhtUkRjTDg1?=
 =?utf-8?Q?9749QGzZmbCQn8VTSiGJ0hVRrpNOQKGz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea9a241-d9d5-4c07-d63a-08da05e7f5c2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 18:25:04.6211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUY6Cy72QQXEseItgE6/s36F1OYgHOSjv5xSOWjFDB1iYt7f/GlBfr0utOzwxbj5MuFtZxkVTmG6AFcBpWWsAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
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

Am 2022-03-14 um 03:03 schrieb Tao Zhou:
> Other parameters can be gotten from ih_ring_entry, so only inputting
> ih_ring_entry is enough.

I'm not sure what's the reason for this change. You remove one 
parameter, but end up duplicating the SOC15_..._FROM_IH_RING_ENTRY 
translations. It doesn't look like a net improvement to me.

Looking at this function a bit more, this code looks problematic:

         if (atomic_read(&p->poison)) {
                 kfd_unref_process(p);
                 return;
         }

         atomic_set(&p->poison, 1);
         kfd_unref_process(p);

Doing the read and set as two separate operations is not atomic. You 
should use atomic_cmpxchg here to make sure the poison-consumption is 
handled only once:

	old_poison = atomic_cmpxchg(&p->poison, 0, 1);
	kfd_unref_process(p);
	if (old_poison)
		return;
	/* handle poison consumption */

Alternatively you could use atomic_inc_return and do the poison handling 
only if that returns exactly 1.

Regards,
   Felix


>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 7eedbcd14828..f7def0bf0730 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -91,11 +91,16 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>   #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
>   
>   static void event_interrupt_poison_consumption(struct kfd_dev *dev,
> -				uint16_t pasid, uint16_t source_id)
> +				const uint32_t *ih_ring_entry)
>   {
> +	uint16_t source_id, pasid;
>   	int ret = -EINVAL;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p;
>   
> +	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
> +
> +	p = kfd_lookup_process_by_pasid(pasid);
>   	if (!p)
>   		return;
>   
> @@ -270,7 +275,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   					sq_intr_err);
>   				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
>   					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> -					event_interrupt_poison_consumption(dev, pasid, source_id);
> +					event_interrupt_poison_consumption(dev, ih_ring_entry);
>   					return;
>   				}
>   				break;
> @@ -291,7 +296,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
>   			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
>   		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
> -			event_interrupt_poison_consumption(dev, pasid, source_id);
> +			event_interrupt_poison_consumption(dev, ih_ring_entry);
>   			return;
>   		}
>   	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
