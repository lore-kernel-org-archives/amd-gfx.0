Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD03CF044D
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 10:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFCE10E6D6;
	Wed,  9 Oct 2024 10:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KGxhSHk2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CAE10E6D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 10:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBOrPuP3paILgW5tiOHPumIQYi/1GpN/vAnfZ4vQWaqqGdOO/Ja7Py8/MP/pLg+WClH12JxtzJutO8CLO1O2zfXoVatUukAUBhyRa2UVuoRyCgDq0LPdBdxDN4Zotk8EZtpWfcUr5ykq9rZumbQer68DIBwxdOmKJ3IFdBvBiZ1bpEcfK7VB1KghF1eMMQ8kOTtQBvO6zvNzHhSRaFZw6k9Pfs6JYc9rAaka2s/CvXq0d7XIGK8iL3zlbieNyiLOlHFosgYLsxVxLapiH+CSDJdptK0KJo2B0F4kTGRPQStbkD6jp8KIUnHMIadXrixXOoetHgXW6vRm9WUPSQlExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6Wg0nk/s+6sEWPrKa6IYUfwYGQN1Gok2ikbIpY+lxM=;
 b=F09zAL4sxbTwHAAIcj2ZzE0b9MyX0K9uxrLE4ZW5XBHiYfj5w94/2o/JWr+WphMdl9MCXogZMcdHUs8mo73BZ0ZlbfgCtF6sfNBsImso1DMCHB11vZr6TiSRT0/yGnI27BvTzuByrTGxXMzfJqGRCI2+rFCf4yt+nZcM/X450KPpSE6TyGd6do4stdykuxRwM8y2WjRT36iRXhNnuIEy7VufNKqrWTlJLQ0x3XH9nH4vuJjHhL/5x8R5HRsT0lY7jC3Z++RNEGKVRtWnVYq9O8tz01KYenpSfWmAMsJDb2EesgrYbaruTLSSy9pYYIRPdxYJv+5vsyv0JHuOJNxVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Wg0nk/s+6sEWPrKa6IYUfwYGQN1Gok2ikbIpY+lxM=;
 b=KGxhSHk2jXy+3Go2JFhVQ6WLBACDagwaDsqfRKeD1ug00DBg3UP0RdqdpblGyn0/rIgBL8DGbli1oT4ZsmIVrViuncbWymwouVvurWVghgYErB6gxsF1VdoOvL32hEOdRIPgIeuP1PCM8oIGX1fZjIrdqNzVq0tnLW525yDbjRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:51:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:41 +0000
Message-ID: <0b9ad760-6996-4178-a974-d0b391d00a62@amd.com>
Date: Wed, 9 Oct 2024 12:51:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/admgpu: clean the dummy sw_init functions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009084823.828235-1-sunil.khatri@amd.com>
 <20241009084823.828235-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241009084823.828235-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: acd400f4-7f5d-4499-bb63-08dce8505bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tlp5MFZVNU5Hd001YlZCb09aY1MvVlNOWjJVSWhPejdPRFJpc1NzRHlVZkk0?=
 =?utf-8?B?OC9iZnBTTDA5Z0xNYVJmMWZ6T2pGMHNzV0gxVVpqcUQxOE9pZkJKZDRvaTlv?=
 =?utf-8?B?UncrSVBFclRZakFxKzlsMUt5WERueTJrbkdCaXE5am0xYXJ3a0RFcjVoQ212?=
 =?utf-8?B?Wnp0VE11NVN1eDQ3c1U2MUdrZU5jMmgyWVp4MGxPZ3I2TC9TZ09lbjQ4T2FC?=
 =?utf-8?B?UElYRTllcmFBMnMxK3FaTWhmczIxV0RCRkZYSklVK1ZVL0JPQ0RVUFRIVzdP?=
 =?utf-8?B?SHNuV3BYNFpsZUVyMzdSOTcwbHVGNkQ0UXcxN0tjdlZ3Z3gxb0k3cFNhL1Fk?=
 =?utf-8?B?d2RZQnV2clk3QVRHVTNrc3dZb0dXK3ZFd2JRSGU5MFBiNnIzajQwZklXeUdh?=
 =?utf-8?B?T01zL0kxNmkySEVzOXVuVG9kanA3TC9ldVRYM283Ym5TNy9vcUgrVUt4OVQx?=
 =?utf-8?B?QVNoUThtZnRRSm5CaVExdHVIUlMxTWdSTWpPb2RuTUtvek5Kd05oeEl2UytZ?=
 =?utf-8?B?dlcyR2NnL2REblJSWnpxSytVVDJpdW44NGhWR0kzR3RuREw1eEhGVjZFNkla?=
 =?utf-8?B?c0hJRGJvZjBBcGVwRkxqM2U5c2wyK29XUURLaXpZT1ZZM2Q0cFFmUGQ5aEtv?=
 =?utf-8?B?ekFHdHZuM0U4am9oMkpYbklMeUt3VFhaR1JBZVFYMy85RlRBV2Jva1dubVdy?=
 =?utf-8?B?MnZ3RTJ2VGVTcXRvd1ZRdU9qMEFXdzFxbk5nRm1CUThaRkZpNGx6RFE2NUFu?=
 =?utf-8?B?QnFVaXlUUllqVnVBK2d2RE9WdTIyR0pmeVJNZCs3ZFgzSkVCSmVLVXV1MWhx?=
 =?utf-8?B?Y3lsa0FPaHJEZmV5Z3R3UTZ6b0o3SHErcjRQQzNjRlorSGNYOWlEYnVJSEhu?=
 =?utf-8?B?M3hqMVFwSjI3VUhlWmpCczNCMXZHRnhTRyt0V3RDZEZJa2JXeWxKZW5venFq?=
 =?utf-8?B?Z1JSTDE1dVJFMktycmxTTTlIYlhrdUp5MU9WVGh3VFdYWjJ3MGtwQWVJbEVa?=
 =?utf-8?B?cG5IQURlSmRNNElGcHk3UWQwcnJrWUoyYlJoazZxMXlHM0pzVmRKZ2xwTVZa?=
 =?utf-8?B?UzBwRHd2a0xhcXdLSCsxNjF0cm40Qm50bHdmb0VIN0ZGMnpFQXhDNkhQdjIv?=
 =?utf-8?B?RVprWDZvTnNLV08weUJ6UGlWdUlCaEFRZ242MEtybWc2MnFlbzRpeC81eGJm?=
 =?utf-8?B?b0swbnVpdWl4VXZIVEMvSCtNdjJlQVl1ejZBclpsSlFWRCtROWM2SVJ0WkJx?=
 =?utf-8?B?bWM2cnM4YlE2U3F4WklpNVJJcExlYkdvbEVaZWkzMVE0UVZOV1VzbFdqa1Rr?=
 =?utf-8?B?YTl6M3NZTXpNakZkSCt5TGhleFRzemVac3M1Q0taSjlGMTdtSkhjTE9SYzNF?=
 =?utf-8?B?enJzdVc0aERCOENGczFoRE0xL0NadGVYb2UzMnJuU0NvcWM2MWhibHFkMzdX?=
 =?utf-8?B?bm5zMXhGNGhEV3loQ05tWThtRld4UDNPQ29uWHZqZnhWNkkwd2xGMEd6TWtj?=
 =?utf-8?B?N0p1djFkbW1SeTducUhwNHlDN3FLRW9jVmdURTViajBOTmhJQVFGQ2NzcmVE?=
 =?utf-8?B?Y2hWd0RPb2tVQURlU3ZuSVplZ1RjNThUVHhzbDJXUmRNOCttTFNIN1h6T1JN?=
 =?utf-8?B?MGlFaklBemZGdFZwZnk1cXhmV2FNR3ZhbjBEVERTR3pNYTZ5dEhmWVptYkp5?=
 =?utf-8?B?MmtQcU1UR3pWcytHMlBUVno3OXQzRUhTQUVrcWtOaUNEalNjZEFRWjRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Und1TVkzdTl3eTNYazdGNk5KUHpXdm56WkhMNXJkL21HaHluY0NBTFI4TGR5?=
 =?utf-8?B?MXZrcVlHNFh4cnNqYkxVa2Q0UytuU3g2VWYvOE5PaDd1bHp3dHdiWWZKOFZS?=
 =?utf-8?B?ZHNNNXo1a0JJT3c5Qjd4RlI0bW1BTTlwc2s1aVhWUGV2WmFoQUhmREVlVldN?=
 =?utf-8?B?K2czUzdRUlAyamUzWEx1a3pqTTRlbGVtWFFNSVJaajNGSk9uUTRXRWl0WVBs?=
 =?utf-8?B?ZEJIWFBkR3VwdVlPUTFMQTBTMWtlR01UaVpMVkVXZHI4ZDJ5ejkySi94aUFJ?=
 =?utf-8?B?NkhFZnhiK091cnNPNWJVSnFFSCtobXN6ZlQwTHZsR0hSMklHQllNMlBJY2sx?=
 =?utf-8?B?WC90cWNsc0hWRTdwNlpjTzBhdC96ZXEyYVZBQ0wzRzdlbHVseTZTMlBxcmFn?=
 =?utf-8?B?S0JGZGNFSzJXUnQvZlZrKzZ1Z1FyNVNVeVcwUXZTcHNwU2tTRk1qWmZTM3Vo?=
 =?utf-8?B?ZkYyQUZCdkEwUFB2TTRYbzhWb0tLbE03Z3FaQjF2QUx5WW9lM1pBVExnbnAz?=
 =?utf-8?B?VEhkSnB6NC8rQk1JVDNsc0oxMCs4NVppNzRKRWdZdFJGYjFSN0dLM1JNZjB4?=
 =?utf-8?B?VEJGTFRkdTNCWHRUVlZiK0FpT2ZOOXkyNUphWkZQUlIweHJCbFRGcS9LQVNN?=
 =?utf-8?B?MXN2cEJJeTdSdm9VVFJNYlRPQTRNd3FPSWQ1T2tFNEw5SkQ3VzBMKzlYbmtT?=
 =?utf-8?B?SUkvRkhJWHFKcndkSnNmdnl5eWN4T2oxVGRpK3hZR0RGU0UxTC9pN0Fyd3pW?=
 =?utf-8?B?NEpOTnlDempKbWY3WEhBWmhuenAzQ25mTDM2eXRyRDJGRG9JbkJzNWFNc1A5?=
 =?utf-8?B?U1M0TTlTUUhhQXlSM0E3ZzVaTjE5YSsvUi9wUVFuY3o1WUdGTFV1NWd6OU5a?=
 =?utf-8?B?WkxZVmJtZE5GVlNpd2JEOWRYVFBkcXM1b2lxTmNqWFRsMHJQeGExM29WOTR2?=
 =?utf-8?B?Vk5QWGxVM2FmOTd1RDQvaHNpUnAwQXQrS3dReVRBbmV2cUE1cUhwYmdUTXRD?=
 =?utf-8?B?ckIxcFlrcUFKL1loYzFteWMvcitKNjdQaGRNelJYMDN4aWdFYm9PRWdUS2FL?=
 =?utf-8?B?Nno4Y1hsR2diSTQva0cvS3JLL2JMaWJMN2EvQ2J0UHg0WEE3L1pSRjNKVE1t?=
 =?utf-8?B?VHBVSUl4NWVNY0lHVHNMUFQ4YnZiQjJNNkFRMW5QdnlSVHYzd3ZiT1ZXTUtk?=
 =?utf-8?B?QmloZGR2Z2lQcDZjRDBDZkIvTXNVWjN4RHVMbzN3UUxIcVZJWjkxSFBIWnN3?=
 =?utf-8?B?djJuQ0RWWjIxN3pmdzYyM0Evcnc0aXMvdElucXdkSm1TVGJvaTRZYXd6YTkw?=
 =?utf-8?B?THl2b3JIRkI1dGp0S0pzaDJyL2ZsUytJNmhCWmE1MEg3NERBQkNoY2NwN2JM?=
 =?utf-8?B?dUsyOWdZZEoyOVJzMUVFRDI2ZG5WTXRoWWx6UmRINCthbTRoR1UyZ3JBNEtX?=
 =?utf-8?B?WGNQMzlzWUZVM0FETVVNVzBCVDhoU1ptL0VoZ3ZJUnFVNnJiTXN1SlY0akdM?=
 =?utf-8?B?dklzbmZaenlJa2JsUS9xRjc4d1ZDMnFNZ1RhWWNObGR4L2RLYnlXYzY0NE1D?=
 =?utf-8?B?VFZMTzQ4ZlpMZlVNc1lRY01NcS84bUQ1cnpaZ0xaMjRKcUlZelJ6SVFpZDlq?=
 =?utf-8?B?S3dXNW5SMDFZK1FsWk5BdDNiUWVxejJKMktVUTVmbnNCVGRqcVVMRVlRNlJ6?=
 =?utf-8?B?Q0hLQW5WZ21NWDdZMU9MSmdiOENOdkZlMW5LaXU3VHREQUxnd1IvZHBwNmJ0?=
 =?utf-8?B?UE5EV3dGZDNmZ1ZhTEN0RDdCTEU5Rm42TFMzSW1iRHRHaDhWaUJ2TTI3Vk9i?=
 =?utf-8?B?a0hLMWlaVEhNRDlOQU1kU0YyU0p6cUZwQ1VQZ1NqRjI5eHY1ZWtDVUVrb0tl?=
 =?utf-8?B?VXdZRW1RNDNrVlBZUTBhMWVlT1J3MzFuTVJHSVoyRHZndDl3T1czaWhFYmRS?=
 =?utf-8?B?aEl6b1Y0N0M2VFl4dVg1cUJ6VUZ5bW1oWU00UUdWb1JnaThXekdnRWFmc2k1?=
 =?utf-8?B?T0R1Z2ZBRkx2MDBrdEhEdzZuemZBK3FNSWpHNEgwOVdENkxSRGlaZUNhQUF3?=
 =?utf-8?B?TVhwZ0kwcEgxakpqc0JVcFF4ek10NlNHTHV2OS9OTDZWQTE3ZldyOFhSRTlN?=
 =?utf-8?Q?jDv8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd400f4-7f5d-4499-bb63-08dce8505bb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:41.4179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWCb7bIWOW8n0R7JIDHJi+NOI2sA3XEd0NqcJv6GPSn+t8KExVjk00nIWgrHK5J4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

Am 09.10.24 um 10:48 schrieb Sunil Khatri:
> Remove the dummy sw_init functions and set the
> corresponding functions to NULL.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 5 -----
>   drivers/gpu/drm/amd/amdgpu/cik.c        | 7 +------
>   drivers/gpu/drm/amd/amdgpu/si.c         | 7 +------
>   3 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index adc0b80ca5db..4add6c412779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -33,11 +33,6 @@
>   #include "isp_v4_1_0.h"
>   #include "isp_v4_1_1.h"
>   
> -static int isp_sw_init(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int isp_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 6c18ab35cf69..bb961b274487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -2124,11 +2124,6 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int cik_common_sw_init(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int cik_common_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	return 0;
> @@ -2195,7 +2190,7 @@ static const struct amd_ip_funcs cik_common_ip_funcs = {
>   	.name = "cik_common",
>   	.early_init = cik_common_early_init,
>   	.late_init = NULL,
> -	.sw_init = cik_common_sw_init,
> +	.sw_init = NULL,
>   	.sw_fini = cik_common_sw_fini,
>   	.hw_init = cik_common_hw_init,
>   	.hw_fini = cik_common_hw_fini,
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index b9934661a92e..0578c7ce4dc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -2148,11 +2148,6 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int si_common_sw_init(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static int si_common_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	return 0;
> @@ -2691,7 +2686,7 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
>   	.name = "si_common",
>   	.early_init = si_common_early_init,
>   	.late_init = NULL,
> -	.sw_init = si_common_sw_init,
> +	.sw_init = NULL,

BTW don't do that, just don't initialize the field at all.

Uninitialized fields in global variables are NULL or 0 in C by standard 
definition and Greg usually complains if we do stuff like that.

Regards,
Christian.

>   	.sw_fini = si_common_sw_fini,
>   	.hw_init = si_common_hw_init,
>   	.hw_fini = si_common_hw_fini,

