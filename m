Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33661C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 21:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F7C10E6EF;
	Wed, 21 Aug 2024 21:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hD978eEp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331BA10E6EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 21:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1wBL25udhOOs9WdSgj9LIrMtbiVAm/5jZSYkAqhib3ehHVqtLr9JEmvZaOoHksYqFy4ifDKArzTrWBcIcSIDYKklqx3N6yADizSNaytTrQzTB8WfM+/lP05G+luBmTkkLaBZ7m3RA1Ek/7ojTSwYG5iqrDcDLXr3aZVV35rWiqadnGBHxDh9pXaEkSgC6cjRv8hBer5n3y8X0R9XB4bO1AS/C7Wgt1u9DZLzq3Ejtc1E/muMSUp8mgbntde4aNDI24oIH5jnH23jEAvRv52B1WHq+eeRCUX3AEXlHUbeMGuSuTy/SE1RaHH7hGqDHTUySV98ZbU6suKXlRMwDT11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEZHw0nGJNGVjHgV1+m561Uajjzkmp/3RtFd5fkYBE4=;
 b=CLfUn3hnKvTn+dnSIO42OpOGqOgzYKCF2wzqogY60KuevSzYV4hGjoQKUE1B8ljB9Rp8P0do4j1Za3kqpgr21M+Vsph1QFyac14cBq7KmAxPGxxNtxwMK8MwbaOgg9S3t6SGRozBYLLc26Uhjxep2MavICbMUF0WI71RuINn7kY+PLaDw5fu+GsUXNtrWQ71L3Lg5+JUyw8fJXXoHEqUML7MKe4Mv84SbUJ4k0cI83KsGbLxTAIU8EqrAlTwzG14w1B2O8n4Dx1mPUz4qeqT+sKxJV6C5ekcKMOXS6SDuhoJlxw3sQwMGSyrOu69H7O34FSn8E/OGmh6YzLgLqKTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEZHw0nGJNGVjHgV1+m561Uajjzkmp/3RtFd5fkYBE4=;
 b=hD978eEpZ5tu5Z4+Rf5/fyrm+YuHI5K1MR56GdZ1Pc0TZG2Y1CoUPtbVUAseU0ioTBKfYLwYxOX5RoYx6xczGY8Q8MV6Rkcrlm7UuzwPbPQv2btXmUG8xJZGIqnPSGIXtZUR9K8JluMaxaLpbShwOFwgMh9tWqBWWemSZ1c5Kog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 21:50:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 21:50:43 +0000
Message-ID: <c69f3e14-696a-4b77-a490-76f6dfcf4be2@amd.com>
Date: Wed, 21 Aug 2024 17:50:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missed queue reset on queue destroy
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, Alexander.Deucher@amd.com
References: <20240821211737.4154269-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240821211737.4154269-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbe8a36-5478-43ed-13fc-08dcc22b4e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGxhTXV1VHYwMGtrSWsyUEl6UlhPZjN6WnZFdDdvdUtacXZpSDR2eGtwZUNH?=
 =?utf-8?B?TytsYWlpcXNkWC8xenUxOUJHdGlnbWFIa3cxa01jV1k4b2tES21yUmtzeFJW?=
 =?utf-8?B?amV0d202L0d2NzJKSjZXVzZ3a2kzREVYQmZ6RzZQSHdJbVZWTWtTSUgyNWNH?=
 =?utf-8?B?dzU5anFrcnhEVTZmMFRsZGRuQmZXTEJYZFNCQnd1RlIvSE9SbjEveVc0cUhG?=
 =?utf-8?B?a2tvNE9jZVVUcG9WenpVM28xTTJsUHY4S2UxcFNtVW1VUHJvVk45bENZRTJi?=
 =?utf-8?B?TXNoN1hjTExNVlVuOXl0STlMVVlITWpJWmd4ZVlnZDkxRmROZlJZWGlaRUp3?=
 =?utf-8?B?QnhvNklhb3IyMEl5UlNyZUpXSlN3bktKMXJ5TUhmWDVRS3BtM1BwWTZUUXdt?=
 =?utf-8?B?cEFyR0o5Q1Zuc1lYdWF1eEpZOEdZMUN0SDFSL2MvWWx0Z2tTSHRlbkJBWjh2?=
 =?utf-8?B?aEsvNG9lbHhiUy9jYW5rMjkzcDlWd3Z4QmxJWUhYOHV2c05va0Y1bG9CeDZ2?=
 =?utf-8?B?RzgvdGtjWFBkb0JRRm02RFNzUnJES3hqakdNQlFOY3FyOWlqTnpCL2RPWnlW?=
 =?utf-8?B?TnpXQWQzcXk3eDBROUdTN2Q0NExsTTdta3RxL3llZnIxcGY3Y1o5U2JUUjl4?=
 =?utf-8?B?V1JmY3hzdUlzVDVMVlRkQWNieG1pYlVCQnZYaGxtOGRlamZTR0RZYW1LNE8v?=
 =?utf-8?B?blpJSWdHSmZqQ2M2YTJMZWtQeWNUMzdWa3dublFaRmhWd1RWU0t2MmRTSXBJ?=
 =?utf-8?B?QWlnZjZSNlJxUHdhYnRoMmx0dEsxekxrVlBvc1R2Rm1ZK1BqNXZuVjMySXRO?=
 =?utf-8?B?bHZReGM0eFB0d09HOXhLYnB3cHc5NnJ5ZXljWndlYXpCK2pteDJCM1RKdnY2?=
 =?utf-8?B?MVgzeW9pZXhXWFdqbWRnYXo4NEtlRkpTVXREcUxIaFhNbHN4WmZWamswNWly?=
 =?utf-8?B?WXhkR2toOS9GTTJHV1JMOUVacVU3NlRablBMMklsc2lVdTVwTGt2ZEFOUlRl?=
 =?utf-8?B?WitVNTRhZjlEcjBHTjJ4S01rZHF6Z0lCb25QRS8wVHB0eUwyVUFFT0Z5TnZ6?=
 =?utf-8?B?SVlUVk1PTkJQRXZsRVl3ZGdCL3cyWndsSmRVZGpDaEhySVhtWTE2YW8vdVZl?=
 =?utf-8?B?eEpqSDJObC9ySGJIM3hNb3AxSzVvRW9yazZNdHJjOFc3Y1diSWQ3ckVGSlgv?=
 =?utf-8?B?c3lYU1hhUkwxRnNvQnlwY2NaTkNzTkJyUmFUa2N2SUxMeGRhTWtINENKRXRF?=
 =?utf-8?B?RXlxMER3VjRIY3V0YngwbVQxQUxEd2d4L3JOWGJIeFFTNVVndGtWZnFVT2lO?=
 =?utf-8?B?UVc5WHVuRkplS1NVUkVRSFRsQVp1bGtRNVNNSTlqaWRzbjR3b0FoazExTDQx?=
 =?utf-8?B?YmpNVTl5eDE5SFY4WDdHalBsMjZPOWV6a1hLUmh2MDZwR1lFaEdBNEJCMGQ0?=
 =?utf-8?B?K0xuM1A3Q1BsS0dQM3drTUtldWgzWUZHbWluV09ITUJyTko4VU92dWQ3TTZ1?=
 =?utf-8?B?cFczZFE5cWRXSWtXRW5KRFlZam1UK2pVRzVRZkprY3RzQXI4NU15QXRROHIw?=
 =?utf-8?B?eWJSMFpyWXRqTjd3VEhWSWN1VktPUmRqWkkrYlFNVjdTUExvVThnZFhHODN6?=
 =?utf-8?B?cWpBblVnYnJEYlNqMURYRHVUeXJob3NFRzFtQWE3K0JHZnRIclZBekpqSzJV?=
 =?utf-8?B?UVlKMXFNbTZUc2JSaERkSkljZUs2UUF6eDNkVzdxcUtQUHg1aVpmKzd4SE5S?=
 =?utf-8?B?OVJ1OWJjaENtbjVIaDRIOGNvRkViN3hIT1JoV244WHd1RllaT3BrRGYweWxk?=
 =?utf-8?B?V1NkNysvMXFqMFp0V01lQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTZWanowK3ZjNXlYMU40aE1tMWUvTVdSeGNsMWdPMThiR1V2aThEMk9lVndk?=
 =?utf-8?B?NDVKdlI4WnBYVHpOaWlSL0tlTmlQSG5KeStIY2x0WlJqWkV3VjMweWk3NzFo?=
 =?utf-8?B?b0pGcVd1Nk5pak54c2FIUUoxUEZxbTI4TXpvbStXTlJwN3g5RTlNWWdLTk5Q?=
 =?utf-8?B?ckdEckFNMk02ZC9kbURxekxMTEFFL29DaXVyZERaQUxiSjdHTzNKdzhGNlVk?=
 =?utf-8?B?bjI5RkVXa0FjSEwzRjB6b1d6bFUycUJyMEYrbXVLSXdITFg0Zm1FWXFBQ3lI?=
 =?utf-8?B?QlorbklQSnJRTGtGVFpKUG03MnpyeldtWGZWMEh6RHQ5Q3Q3UHlLNXloaEMw?=
 =?utf-8?B?U2RYY3l6WUovZTdxbzI4dHFxdDdpZVlhUFhNeHNQZ0ZzSDZsais3OWtpczVR?=
 =?utf-8?B?KzZKUEVrQTlWUXpSK1BkZ2ZBK0NxL0MrVmF3Qk8zRUoyU2hVaitWaTBERzRB?=
 =?utf-8?B?Um5NN2h6QU1MeCsyMVpUaGlGZFJzV0xYUU1xZnNpR1RWS0ZUME5DWjl5RWg2?=
 =?utf-8?B?ODFFelVDWWVyUW9GbVJ4RE5QZjNkeEwzaGt6d0NhbzdRSllPbEJoTVVrb09p?=
 =?utf-8?B?ay9abTVINjRqekRDWCthQy96dDhIRGJFbFZjNFZiSVZ4cm1zL2p6U3QvcWFh?=
 =?utf-8?B?QnNsNVBqN2FQejU2WEZaVC9Dd0xuMzZGWCtaWHVIZEloa2dQTFRYcWVQYlly?=
 =?utf-8?B?cG1pU1A2czh4dDAvbzNOSFZyRzZxa3Y1VzZuSEp2NGZhT0xjMUVhWDhqZC9i?=
 =?utf-8?B?UWZWMlAvcEVEMzhreFRhRWxtaFZ1TkV5cWtuQ0lTTHByVFlVbSt6a1dkVk85?=
 =?utf-8?B?S2tJWk50c3BUNTByTXpIUGdxbmN2cjhXbC9UTXlMZVQvQU54b0xVbEU1TWk2?=
 =?utf-8?B?d3ROWnpSVytseEFDdEVWRTltS0pCS0l6VjhHanZMSU1Jc291UDFqd09wbDFT?=
 =?utf-8?B?UkZxcURLUTVFNTAxQ3FWRm80dGZOUktrYU5hZkNVWU5JcVFRZnEyZm1EYVpM?=
 =?utf-8?B?ektwNFltMkJSeEpqa3Z5aTBiSHJRZ0VYa1lBMW54YkhralNjcmkwY2VaYmtP?=
 =?utf-8?B?Y3pJUWRiUElOMkUrc1I2cE12VEwwcnE4R003NUlCcmJKUlVRbDUyRUk0VHlX?=
 =?utf-8?B?eWF2alhBbjdOczZPWkE1dlJHY25hcm5QdWlHQVJnQWFxVHpQRFJTdnhFdjlj?=
 =?utf-8?B?UGc5bWJ4L0x1citnUUhSSDJNUTlxejZMZkpHZHJidEQ3THgwRjhSVGtnTGpE?=
 =?utf-8?B?U21jR2ViWllWQUxMR3laVFBrZStGdzBwY09lZjkyM09vZDBFOThORS81TjB5?=
 =?utf-8?B?aENPditkNElRZ3pRYVZBV1FZT2tKd2RIazZlWDZMR21BK3pMUmpJT0hrK3Ry?=
 =?utf-8?B?UUdkaWQwWVQ1RzB5dzNxYmk5ZEppY0tNSXEyakV0RUFxTEdqMjRiMDNWcHdx?=
 =?utf-8?B?VmVna0Ftc2E3eGRVYTg0dkxmeTVIc2NtRlNPYkwwcXZyRUUwd2F4Tm55NXpn?=
 =?utf-8?B?dDZ6VTZBeE8yTXNrd0R4a1dWVHZkTlFHdnkyRk1uWTRCMWdPTEE4L1hYL1pp?=
 =?utf-8?B?K0Q0cWFCSjJvY01BR2NqempQOUZYMkdKNjVlbFRWZENQS2ZsdHhMamEvWks1?=
 =?utf-8?B?ODZrdUxLcnZiOFIwbytkLzg0Z2IwWHYzZXVsMGF3bmprbzQrRjI1S2Q5Ui93?=
 =?utf-8?B?dFpjdmNwWWFIUnNBZmNObGUzTDFjemhTcHZxNVNhNFN0dzNFWlp5SW5nc0U4?=
 =?utf-8?B?UXUybHdjbWFwd1g0dzBSZjRabE9hVFRDSDd0eDFPU0E4Uy9INkRZaldRRXIy?=
 =?utf-8?B?cGhxWFlpNzg5TWtxR2tiRUd1TXpZYmZiUUp1MnhsdGpXMDRwMnk0bkg0VEVT?=
 =?utf-8?B?WXdYb1BOWW5ieTJoWWVjMEQxaGRLZEtTRy8xUzNxNk1UMHZrdWN1OWxRUi9u?=
 =?utf-8?B?T1ZXNE03OW5OME5vMHZGeWp1NDczYUs5QjBiK2VCSkRnRDVQWjluYmlrUHcz?=
 =?utf-8?B?T0JEd2FESmJnZlJwVGFTVk1JbWt1c0YzU2hUTkhCNXNNZEhkWUFBWVJocXVM?=
 =?utf-8?B?Mk42MXNaTTZlU3kwNmVtbzJLOFRLcEkyV0hZUjVKUkF0dHR2ZWlveWFjTFhh?=
 =?utf-8?Q?JCdmxNXDNykh4UuS61RX2jG+V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbe8a36-5478-43ed-13fc-08dcc22b4e9b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:50:43.8723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFbg2slMT1n5A9MyYzvsGma4kc1f1KebNT0QmB2Dc50lPR7Qf8PcxzPr3U6rRAaRrIpmbdwYiBwxY4OAXXHIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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


On 2024-08-21 17:17, Jonathan Kim wrote:
> If a queue is being destroyed but causes a HWS hang on removal, the KFD
> may issue an unnecessary gpu reset if the destroyed queue can be fixed
> by a queue reset.
>
> This is because the queue has been removed from the KFD's queue list
> prior to the preemption action on destroy so the reset call will fail to
> match the HQD PQ reset information against the KFD's queue record to do
> the actual reset.
>
> Since a queue destroy request is under the same device lock as any other
> preemption request (which subsumes queue reset calls), transiently
> store the destroyed queue's reference so that a potential subsequent queue
> reset call can check against this queue as well.

Maybe this could be simplified by disabling the queues before destroying 
it. That way the queue would still exist when it's being unmapped and 
you don't need to hack the special case "cur_destroyed_queue" into the 
queue reset code.

Regards,
   Felix


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 +++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 577d121cc6d1..09e39a72ca31 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1842,6 +1842,8 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   		goto fail_detect_hang_buffer;
>   	}
>   
> +	dqm->cur_destroyed_queue = NULL;
> +
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -2105,7 +2107,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>   		q->properties.queue_id, q->process->pasid);
>   
>   	pdd->has_reset_queue = true;
> -	if (q->properties.is_active) {
> +	if (q->properties.is_active && dqm->cur_destroyed_queue != q) {
>   		q->properties.is_active = false;
>   		decrement_queue_count(dqm, qpd, q);
>   	}
> @@ -2160,6 +2162,10 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
>   	struct qcm_process_device *qpd;
>   	struct queue *q;
>   
> +	if (dqm->cur_destroyed_queue &&
> +	    dqm->cur_destroyed_queue->properties.queue_address == queue_address)
> +		return dqm->cur_destroyed_queue;
> +
>   	list_for_each_entry(cur, &dqm->queues, list) {
>   		qpd = cur->qpd;
>   		list_for_each_entry(q, &qpd->queues_list, list) {
> @@ -2409,6 +2415,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   
>   	list_del(&q->list);
>   	qpd->queue_count--;
> +	dqm->cur_destroyed_queue = q;
>   	if (q->properties.is_active) {
>   		decrement_queue_count(dqm, qpd, q);
>   		if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -2421,6 +2428,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   			retval = remove_queue_mes(dqm, q, qpd);
>   		}
>   	}
> +	dqm->cur_destroyed_queue = NULL;
>   
>   	/*
>   	 * Unconditionally decrement this counter, regardless of the queue's
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 08b40826ad1e..5425c1dd7924 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -285,6 +285,7 @@ struct device_queue_manager {
>   	struct dqm_detect_hang_info *detect_hang_info;
>   	size_t detect_hang_info_size;
>   	int detect_hang_count;
> +	struct queue *cur_destroyed_queue;
>   };
>   
>   void device_queue_manager_init_cik(
