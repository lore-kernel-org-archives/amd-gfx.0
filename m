Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7B8C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 17:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEDA10E20B;
	Tue, 13 May 2025 17:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJXbnGOr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FF210E20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 17:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWB1Rcjy1eW0S8FuT5RvkV/XJDjySrqiKyitlnFtby7R6LmvcDyvW3l+PrxmyQBGh0hSXSldWJfkNC1j8944zMON7UcQ5t3sRcrCV2zpEhiMFEt7JdY5uJEsg3OQDD5cuD7tobqgO23HCle+r1I1op9VGC7SKj/EawfKXQQCAZcMrnIRMYJ2wrfufU0i/m+vT+px1xAt7s0bD3r397pOfSNxjNKzwONDuUQd3V5XkELGslsrxQ440kljjr15lLl+rKP0mWf4jXXRb/d/C3brkwSKQ1BUFvoiaMSPK/1vA66xiDRW2XWgCj2qN5iDf35Dac4CbXYKTd5te5bCEIXeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhyDZvEKepGBDE7ndwJFVZgP4si93qULK2t4JiP7Tew=;
 b=asxDfXHhiPqfnpPZDJqJSBRuCBzqBlAf8n3N1wpcmfShAu3985Z1CxNbnVrSccj3yo4bQpdTcz00f6j1duHvdlEp/g0utOS69+qGbAJKbOi5LV10eYJFnbSjR7e3xfQqydUEmuWGn58x8h0Ga9IaJe2wmSwesBN+c0gmuLH1mAGyIDo/hY26vM8Smz11RygGGKnVwhLPqSP/pm9DrCkzbcan9jEOk8PM8zmji0v54pGCnr8Y5/R6Vf2tXDiFfBZgcT5wjHqAL8Uw/3AwAsNUw8qgeZRXaPZ9s0ggmfX6IpPKSzyODl4jZ+EIUaOt5tGNA1PvfC5/IZ6BUfp5WH8PHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhyDZvEKepGBDE7ndwJFVZgP4si93qULK2t4JiP7Tew=;
 b=RJXbnGOrCAOx9YPlGst8tiJy7nGo98K1g1aohQR5wrsuU235L17663erW66F+ToVfTmaMzOXEGcXcRLQeOU+0yZO/sCX8QzXmNnM//jlLzrxw6aCDEA6IUyh2Z47cIgLaAJ8xyhlS1c4gJbYPRrHcUawmJlUKK+PTEGafGl5OTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 13 May
 2025 17:18:12 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 17:18:12 +0000
Message-ID: <b203df0a-6409-4b01-9fde-d842a6eb51f9@amd.com>
Date: Tue, 13 May 2025 22:48:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix TTM validation warnings in user queue
 doorbell handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250509101015.3678143-1-Jesse.Zhang@amd.com>
 <446d9189-65ad-4a9b-a042-dbd2405055dd@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <446d9189-65ad-4a9b-a042-dbd2405055dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::16) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 385d75f4-ff9b-4471-8b8d-08dd9242236a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STdSU3VWV2xzcUFOTHEyL0sxVGc0c1VFSFM0T2NlM1BYbUJ6L2NkZExxM1BO?=
 =?utf-8?B?SjZqZmF2ZnIyUGVEa0pKamtTUFlJNzdtRkFmd2E3L2FUQ0VDMWlzVExhSldn?=
 =?utf-8?B?c0o5enVkSlVwd1lDbllYc0RiSmtkZjd4RmtuWUZZWnZJZDFQWi9VdzREZ0hW?=
 =?utf-8?B?VXRHUHU0N295VmlYSlR5V011MU13WVBxOUlGYTNEUjVRWk1qYXcxd2hPeGhS?=
 =?utf-8?B?V052MU9CWE0wdWxQc0Z5V1JkamQzeFZNVVpEVzFwenF2WnhFelRiWUtMNEs0?=
 =?utf-8?B?VTdlNVNlaWVlblBCMWMvTXlKdXcycFdqdTFSaG03ZGt0RG9QRFcxRGo5K283?=
 =?utf-8?B?aC9jcDdsbmszcDhIUFpMNkdjK0lYWE9VUG16YS9GQlpqZzUrM3FmNC9ldTQv?=
 =?utf-8?B?OTVtWGg1YjQ3ZUhObDNvOHM0U2VQMUFQcWRvYkQvUVVCZXlTYUo5NGo3Q1dW?=
 =?utf-8?B?dmZQaUl0ZHphUVpkOThQSys3dVFnZWlIem5EOGhvT3FqOUFoaC90Ty92NFV3?=
 =?utf-8?B?WFhQclZIbmRycFViK0pnRUNqaE9sY2JiRGtxOEx5Yk9XTElYcHBBZExjOWpB?=
 =?utf-8?B?U3l1dkZ0bVFISFo3R1B3elBUZlNlYit4VHcxS2R4SENVMFJmZHg2dTl3UWFS?=
 =?utf-8?B?VGdqNkRma3A5b0ZGeXNYelBtMkNYSmRqSDh4NTRONkxmNThPTG1aSWszeU40?=
 =?utf-8?B?K01hS1kvNkhtZmpkcEg1QWdqbzZqWk9JWjRaSk12SlJrNmpQV0hZc1RHbmdx?=
 =?utf-8?B?SUlQaEhkaWVlcDVNcUFPbmRicVJycDg0aHZuOTdFaGtheXg1N1ZWTDNibkZh?=
 =?utf-8?B?WDJhWFcwdEhmYkpTY2R0U2lyMmxiTnlPQ213bnd5clp1UWdlQWZMdzBtRUs2?=
 =?utf-8?B?UnBEWlhNVEVIS1pGcDhyQUYzQ3U4MTNaQ2FMYkhUMTl1cnVYRVdUazIvVGRo?=
 =?utf-8?B?NmUwek0yaVNORitUcnI2aGRRTGJNK0xEZkZXdnMraDVSNGZ0aGRVektZQVlM?=
 =?utf-8?B?WktLZWdVc3hDYXhPcFRCalVnc0ErbVoxTVh5SzVheDVHLzc3Qk4wSjk2N09M?=
 =?utf-8?B?cmhkc2JQVEdRWFQ5UWZLSk91aDhtQVFKZ0J0eUxLa1dDMmtYOHpLdk5DbHAw?=
 =?utf-8?B?UW1xRW95djNBOGVpWitHY28xSzUvaDJrQldPSURMM1BNTUFhRjBUeUdkZi9l?=
 =?utf-8?B?aXM0YkVlWDNvL1ozTEt2UmZKYXQwL0JwZ3Y5THN5cTFMN3dnTm5HSUZhQTlq?=
 =?utf-8?B?YVJqWDY1a3BBNGhhOVVNRHJpV20wZ1VwOVR4czhvOXBKWDh4M2VLVjBqZFI1?=
 =?utf-8?B?OEt3OUpZWDkrZ0RJbENrdENhM1BNVG1EVkZpRzZDOGdkR1hreDZpTHpHSElF?=
 =?utf-8?B?SjVQQXFlRnZOSUJDeHpGV3ovMkNLL1N4WGwzQ2pDcU5BajFCOXdhMVJBU0Fq?=
 =?utf-8?B?dWNaOVVUYWgxNWpQanRkUTU2MUxOaFFmQU5URmNtUEJSZDFBRW5OQ28yNXRs?=
 =?utf-8?B?UzBXY3QrSzN3aHJkNDd0YnBnNXJJYVc0d1JWaDBiODc0dXAzbFRqd0EwZ0lv?=
 =?utf-8?B?eGcvejRZNVkrU1ZmVnltUUtkMmVkUmY1N3ZvMkRDVUM5QkdGTmNZcnh3ZTdy?=
 =?utf-8?B?eCsxaWVDMEJwaE4wekc2L0tpOGEvOW5HUDJkaENoTTUvVmhMdU0xR3B3YzdV?=
 =?utf-8?B?VkVVNE52OUtTdEpTQ2grOE5YV0c5czV2ZE9kOE96QmV6MlV3U0dVazNjRWsx?=
 =?utf-8?B?WXRxZlNQdTJZcVRiQlVyTGI2bUZtNXB6L1B6V2FhOVJ0R2o2YWgxWkpSR1Fp?=
 =?utf-8?B?OTlVRWV0OHJKTGs4akhFSmZ0TVBFT0I5STVvWmVPWGpBbngzd1Y1SkgxUDRU?=
 =?utf-8?B?L044Z3JhdkZROVVCOWJ1ZmZIa2liek9lOE1YK1VwOEs4SGQzZ29HcVplcjJq?=
 =?utf-8?Q?0QOYaIyuoZk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdRby8rZW5BQTExWllTUitDU1JzVDA5dEludVVJMUJnaGpoKzhzdVhzclpI?=
 =?utf-8?B?SFNFL2kxQmdwaEVsODhjZ0QyMnlVY3lJd2FtQ0tHRTF0Z2kveGxQMlQzZ0wz?=
 =?utf-8?B?bUFZN2pjYUZuRGFtSXhWRGxYRkxxWGRZWk5wc3M0K0MwY3h2a0JWdjZKZ0E3?=
 =?utf-8?B?T0JJZ0NnTXJHdDFnYU9DS2NMRjRrbWlYQ2VtMFRJQ2YzTmVxNmxYZnRVdjZ6?=
 =?utf-8?B?TXNCTzBuRzA1ZDVVYW5TazNzNUxoU2VCcENXTWFGYUltQnJ5RXJuZDVGcTZJ?=
 =?utf-8?B?QzRSMWc1WTNrK1c5MzM0b1NRdWZGb0dxVnh5Q3hsbVFCL2lkeUJFczBmbXZ0?=
 =?utf-8?B?bmIyK2lkdWRFdlVjdkFKeTgxVHZScjFHRExMOU93NmlHVEdZbnc1VzV3VnVF?=
 =?utf-8?B?Mml0WWRUWDJNbmRwRGRsWWpSV2RIMG1hbXhEV0FEdmM3WTBMUEYzOUxHdUlr?=
 =?utf-8?B?dFZYN0hzaEh1ZVpuME4wQ3pOQlJDWWVVbXRXc2lhUCt2VS80OUxSQm9OZTQx?=
 =?utf-8?B?Z3AvK3JYNEx5N1JaVDJPOU5qcTdOZVFsQnk0cVRJYUZxWjFqdzlJZ3l2elJC?=
 =?utf-8?B?Y1poSkJma2hkSEl3RFRRZFcrYStDZ2g1NjZXVy9LaVhoUWl0dEdGcVdSbzlI?=
 =?utf-8?B?dGU2eHQ1WGZldXZHdnJnTENDek52RktCeVFmcUNJWm5pRXdSYjArUTl4eUxQ?=
 =?utf-8?B?WHBhUkNkSEpGZlQ1dnAwZEUycGxiS3ArVXFacVh3WnZvSzZJWFh2VW5nT2t5?=
 =?utf-8?B?VGkrVlBFSUxXdjRSQzg0R2srNndKSFM2NGxPSWpWdnBQOVplaEFDNUZUK0ti?=
 =?utf-8?B?N2hGL04rYXZTZ0g1c1RGdXZEajlzUk40V2JRTjNjSy8vOHFxZzRjK0VpcHg3?=
 =?utf-8?B?bHEraTVmUm84K240NGFrMjZpTC9OakxuYWxxUHpBYmtQOTRmNVpKaGpzNFlT?=
 =?utf-8?B?bWZ2blJWakVGbXNSYjMwdFlidzQwb1pQaVYxMzh5eDg5L3E5UHBFWitYU01Z?=
 =?utf-8?B?N3dGeGZmSWo5TWowZGkrcGNqRWp5RkNNejBuZlRVM2dGdC9FUzcyWmQrSHZt?=
 =?utf-8?B?dnRlZVBxY2FHN2l2WStuQUFvMmNHRmVTTzk4NlhIWE5HNzlqMkdXS2kzU3dQ?=
 =?utf-8?B?RHZuUVdyMHErV0QrS1dSL0RwY3NTUEFHM0hycXRxSUoyd3graC9QaG5yMUhx?=
 =?utf-8?B?Qi9tWlZSbDBDQ2trV1Noc0VnR0daTER5Z0U0c3puc3hmY3dZczd5OTFGRit2?=
 =?utf-8?B?Y29zcWNnNk5FWGt6OURlMGdyeWliUjR3ZVdMeVgwMEh0Y1NGem1mWTZ2UG5o?=
 =?utf-8?B?SWYweG5VYmRPbzZFL1VPSVF3dFgyYlNuaTN4aUhWbTlxNVlUTG1LTkM5djZ4?=
 =?utf-8?B?SEJBbldSZWF5RC9ER05XZTRBREtnUzBGbE9ISFo0clIzSE1tRUJkWFNPMTNp?=
 =?utf-8?B?R0JwZVdJVUZMS2lzQ1M0bXBlVndmSUw3VWo4eFh4SHpuSzdCVmFIVTBIenVR?=
 =?utf-8?B?UlVmQ2tjcFJBWTlPdm9SdnhPTzR4UEJ0dmFlakZjbVkwTGNlenNUYTBVaUpz?=
 =?utf-8?B?ZDAvRjJ0TlkveE5wUEJIbHlpbTg5OHEzb216SXRndmV3b1pBVEg4RVRIdU9a?=
 =?utf-8?B?OVR3T1pYN2pCM1dZVS80RjcrRnNCTWQ5dFNEbTQzV05qODZPUWZEbG9leEF3?=
 =?utf-8?B?WVk3M3lMVVZ4TzAwWU9odDRENklmV25OYXoyTGdsdjRQNFFGYzF1Nk1TTXRH?=
 =?utf-8?B?U1VaYUxXbys0YWtYUmJVaFVqZkZTVnRNQUpWUkNJc1BOT2lZSG5mY0FFZ2dW?=
 =?utf-8?B?WTBhcm1Id2pZTHMzVjhEa2xnUnJ5U2ZPT1RKaWN5am1Qd0Vtc0p2ek9pbWJ5?=
 =?utf-8?B?ZUhtWEs5ZGxRQVhabHdkVHFuNWN5ZFR6QTlnTjU0M3BiRDZwcjdSSmIzUDk5?=
 =?utf-8?B?d3BuMnk5cGZpNkd6L3ZJM3BqV1RlM1ZDUkE4UEVEanZFKzkyTmpsc2kwbEFF?=
 =?utf-8?B?c2ZuZFpPd2VIa0Y1VC8wQ3pQeWx0R21SN2grdkpFMnhFSHBpSFVlelNZbWRP?=
 =?utf-8?B?Ull6cFZYZ2xWYjR1TkFzYWpXSFV6ZGIrT0twcHdqa2NBNVB2TGRwRGJsNm80?=
 =?utf-8?Q?Omnd00kQGGJALKZstEBv5MywQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385d75f4-ff9b-4471-8b8d-08dd9242236a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 17:18:12.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI6dvmQdaMYIys3fiilTYGPW4mJW/eE59lRgDELSpdgHHErCdBZ9h8LUbIh2MQo5hlfBCt/lnmb+97cB40xiRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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



On 5/9/2025 4:51 PM, Christian König wrote:
> On 5/9/25 12:10, Jesse.Zhang wrote:
>> This patch resolves a kernel warning that occurs during user queue initialization:
>>
>> [  428.714241] WARNING: CPU: 23 PID: 1965 at drivers/gpu/drm/ttm/ttm_bo.c:823 ttm_bo_validate+0x15c/0x1a0 [ttm]
>> [  428.714758] Call Trace:
>> [  428.714758]  amdgpu_bo_pin+0x1b5/0x310 [amdgpu]
>> [  428.714915]  amdgpu_userq_get_doorbell_index+0x71/0x270 [amdgpu]
>>
>> The warning occurs due to improper buffer object state management when
>> setting up doorbells for user queues. The key issues addressed are:
>>
>> 1. Incorrect locking sequence - pinning before reservation
>> 2. Inadequate error handling paths
>> 3. Race conditions during BO validation
>>
>> Changes made:
>> 1. Reordered operations to reserve BO before pinning
>> 2. Added proper cleanup path for reservation failures
>> 3. Improved error handling with separate unpin/unreserve paths
> Looks correct to me, but IIRC I've already seen the same patch from Arun.
>
> It's just that Arun probably hasn't committed it yet because he's on vacation this week.
I committed my patch into amd-staging-drm-next.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++++----------
>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 0f1cb6bc63db..444a0f5d98ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -283,28 +283,31 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>   	uint64_t index;
>>   	struct drm_gem_object *gobj;
>>   	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
>> +	struct amdgpu_bo *bo;
>>   	int r, db_size;
>>   
>>   	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
>> -	if (gobj == NULL) {
>> +	if (!gobj) {
>>   		drm_file_err(uq_mgr->file, "Can't find GEM object for doorbell\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>> +	bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>>   	drm_gem_object_put(gobj);
>> +	db_obj->obj = bo;
>>   
>> -	/* Pin the BO before generating the index, unpin in queue destroy */
>> -	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
>> +	/* First reserve the BO to ensure proper state */
>> +	r = amdgpu_bo_reserve(bo, true);
>>   	if (r) {
>> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell object\n");
>> +		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to reserve doorbell BO\n");
>>   		goto unref_bo;
>>   	}
>>   
>> -	r = amdgpu_bo_reserve(db_obj->obj, true);
>> +	/* Validate and pin the BO */
>> +	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_DOORBELL);
>>   	if (r) {
>> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell object\n");
>> -		goto unpin_bo;
>> +		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell BO\n");
>> +		goto unreserve_bo;
>>   	}
>>   
>>   	switch (db_info->queue_type) {
>> @@ -325,24 +328,26 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>   		break;
>>   
>>   	default:
>> -		drm_file_err(uq_mgr->file, "[Usermode queues] IP %d not support\n",
>> +		drm_file_err(uq_mgr->file, "IP %d not supported\n",
>>   			     db_info->queue_type);
>>   		r = -EINVAL;
>>   		goto unpin_bo;
>>   	}
>>   
>> -	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>> +	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, bo,
>>   					     db_info->doorbell_offset, db_size);
>>   	drm_dbg_driver(adev_to_drm(uq_mgr->adev),
>>   		       "[Usermode queues] doorbell index=%lld\n", index);
>> -	amdgpu_bo_unreserve(db_obj->obj);
>> +
>> +	amdgpu_bo_unreserve(bo);
>>   	return index;
>>   
>>   unpin_bo:
>> -	amdgpu_bo_unpin(db_obj->obj);
>> -
>> +	amdgpu_bo_unpin(bo);
>> +unreserve_bo:
>> +	amdgpu_bo_unreserve(bo);
>>   unref_bo:
>> -	amdgpu_bo_unref(&db_obj->obj);
>> +	amdgpu_bo_unref(&bo);
>>   	return r;
>>   }
>>   

