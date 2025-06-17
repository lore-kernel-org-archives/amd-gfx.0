Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC93DC7114A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 04:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB0810E5F7;
	Tue, 17 Jun 2025 04:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HKKgbP8t";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF26A10E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 04:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U86duq+bP8jvkU2DWutnYKeixxjqYOYZPnzGeDYv2oVqggmnGRhvuDxM/X9v9joHm5Ko2FLvXq/dUkMAc4en/Q2L2mGgCYKzdXlUjfbssnB92ydrgf8pQyyaXWZ2fH+JFyM/PhvHSPbv8ZL6ZBGG4CWa6KO7ZH7GrTLAbAIeMSwwTUvdUJxreO81ivLWhChbxGRnOXmXtFyYdgdAyCmYg27JMDWl3One45T4FrPQn4X6RFmmR0B9f7lOszcMiASC8JvthHUvdKI1K0Plvr0u3mrL9x9YH21T3nDtPX4G/W5a7+hvfC/MCCN0o4SoT/AUlKOkEeAyul0A65cgDCnHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnc/7BAuKqgVcH1SEK34U0zU12+zxVjefU2vaCykRSU=;
 b=kFMgP1B8BHt0GZ26xyQvjV4IUu9WzZ83kVHpBJjbFPtOyV1l9HCK2un73ZZ+YXfd8qgoA6p7pxhRrKpPSjxgPdn2YhbWy8DLFsErVCLaudCxmJrkjoUCi7oTF4VM1y5ELFhcUDRrKSNi9DeiQ8a+svItSScfBAVQXaXSCcnYaKfN5yzpnC8zfTuBenn98zQfnLUtmmhV+x1d0F4N3vJjSr18nvt+BPNTVgHUcaC3eya0RCrg78BPaZeLv52xJmJ4VgE0cRHUUoN/A0MEqXeUDVNxwbnAcdSFKzideZzC8dtnLjNsKVPpalwUo9mck8SKyT64mSVrS0bPZQOIJ7viyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnc/7BAuKqgVcH1SEK34U0zU12+zxVjefU2vaCykRSU=;
 b=HKKgbP8tXOqP69udgYv29GyWW6k5GkairiBu4e/4ELfcNf1anUyir6EcDwO+rini4vuRPxm4dSgIX81pXbT3UWIKjAyCYVBXYYvThQw/K8mvkJ0rRCZfawngwfwejlDbUweRc2gaSxaAtH2WqAGFbNGMGwtTeomgVXa6NdrUd6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 17 Jun
 2025 04:30:17 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 04:30:17 +0000
Message-ID: <351309f3-eb1e-4601-a2c4-51482bbeedda@amd.com>
Date: Tue, 17 Jun 2025 10:00:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/36] drm/amdgpu/vcn: add a helper framework for engine
 resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-34-alexander.deucher@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20250617030815.5785-34-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce38457-cb3b-40d5-93f5-08ddad57a921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NSt2YjUvZFU2QmU2SWdaRHJDSXAxMkxwYjZ3TENNeERjN0hyU3c4Qm5YRUEy?=
 =?utf-8?B?d1hMcFhTc1lNWU41OG43bHVzUFJyRGFYSXlVaHpMZXdDQVE0MnEzYWV1U1Z4?=
 =?utf-8?B?MXNFTEF5emxXc0hLUjhaYWUxQ29rQjhNVmozM2l5SE53RGZMc3pUZHhkV0N0?=
 =?utf-8?B?VEVTVHNCUTF2cGJYTHEwMXg0SFlGNG1QQm1qWEJjbXdCMEtWeXJLa0xKNFRa?=
 =?utf-8?B?OFVNeFVWd29lMHU0STMxTFM1R3d5SU40K0Z6aHg3S3lNajkyRVUzKy9ieFVm?=
 =?utf-8?B?L2ZQQUtWSURFQlVKVlB3MTJVclliY05DTytIRTNBN0VvQlY5UTZiT2MvTy9z?=
 =?utf-8?B?eUNGUkZwSWsxZU00RlFwRjhQYndNS1ZjOXpQNHpiNGg3YkdtTGxpR3pMK2Fk?=
 =?utf-8?B?QUFBNzFXdkJ6cE9ZV0F1WXN0OGk4V2JSTGRxNmtDU2w1VzZtMXJ0NjBra0tl?=
 =?utf-8?B?WDhUQW9vYVBnMXFsc1FMZmVrZGwzVmpXZ0tFakF5b1dLR3FudlQzcUljaTJZ?=
 =?utf-8?B?WmVCRDhTYlBMWms1elBtSk5yQUlUU2VleE5hRWVSU3htVW1jV1RZcDZ0bXp0?=
 =?utf-8?B?RVQxUVFCRGdQNldVc2dpS2lHQkVLWEpPbmhuem02YjhwVkp3NGxHK3NaenhC?=
 =?utf-8?B?ZUdPR1lYeUk5VHdGWXlKT00ySlNpNy9Xa0hjUUQ0Y3NHYUNxWkdMZ1hkY2tv?=
 =?utf-8?B?aDhTbWFXMGhmL0JBTnNwd0FJeExCUW5WWEU5MmFTRXpwOTFCTVpaNEUrM2oz?=
 =?utf-8?B?bTFUNDFMbjdoY0J0ME1iMEM1NVVjbG1NS3BCSVowbVJoaW1KM2xpakdmVFVp?=
 =?utf-8?B?aDZ2OEsrRDJ5TTVqYjUrMWRsczErR3ZtZTVvRFpmdlh2T2Q5Zjd1eDQyVXFY?=
 =?utf-8?B?aFphRitJQlhUYVFHTzdzbWNaam1LT3lsMWlsWTVyamg3S1ZHaHB1OGNRSjVl?=
 =?utf-8?B?L3VFQUwyZmhpZ1gwZjhHZFdJWDhxcWszN3A5RllZRTRuSnp2T0Fyd3BlQ280?=
 =?utf-8?B?L3FIVkhQbkhxTEVoOERnTUVIYnBJbUMzc1dXN3ViZmJkaVFvcnZudUhsQmZW?=
 =?utf-8?B?WURqWWpJd1FSZVZUVVJ5VFlRT2c5alMvNndMN1N3WjdhQ05iRzNhVjliWkgx?=
 =?utf-8?B?RklpUlFqRzZGUEF6UTExdzhyVVBSU0pDYmZ2UjhZS2N3K0x2N3c0VXl4bkFM?=
 =?utf-8?B?dEc2UFB5N0l4MnErSWlDSzhvWkk5UWhpajA0Q1F2RU1BdVJ5bVh6OTVoV1BI?=
 =?utf-8?B?M0tyTlVNWHZuRkc1OVRpZ2paaU1ybXcwbVc3K20xbFdVd3dTWTdBbFo5ZTBO?=
 =?utf-8?B?UUpXSWtoemJoRXpDVjZDL0MvMHZDeEhrc0poVlZ4VXBxYXcxaWpMam5icDh6?=
 =?utf-8?B?bGJtOW9JT3RaSHgwbGREUFhBN0h3bHNNa0V1SUNjZm83REJwTlRweFVMOG9B?=
 =?utf-8?B?aFZURzFaazNsRkJkYVJ3TFFhQmRwZ0JTN3lWRHJBbm40bElqRU5Ca1phUWFh?=
 =?utf-8?B?SFJiQSsxYklrdWVzVlRCOVJLNkRkSW92YmJXbTA2WGd4eXZjbzdSVXQ2SllL?=
 =?utf-8?B?aFA5ZjdOUnhGS1B4NXU0RldhVDdtM2FpR0JpN3lCRVlDME8wbG14SjR3YUNC?=
 =?utf-8?B?SXlDallNRnh3YkgyNVNZa3F2aW9URWJDVXd3YkcwcE5IdzZvOEJ5b3pYcS9u?=
 =?utf-8?B?U0VWM1llc2dUczhnNW0xZ3ArQU9pOFdEand2dWJvR2ZUblB4eDFyckdxNUZh?=
 =?utf-8?B?bkMrOG10djZHUytyQWhGOUxsWjhrMG9weDMvUDZUclhtWWRZMVJHNGFmaHN0?=
 =?utf-8?B?MTRPKy9oWFhmd01rWE9ySUUyMmVFYXd6eUM1QlFsNnF6LzJWVUVvamNPUGY1?=
 =?utf-8?B?QlJLZVJSZXJmVWRaLzc1bzNydEJhMnNUaVZVQXEzR2dEdmx0VG04amQ2V0xs?=
 =?utf-8?Q?L3fqTSnDhtU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9YbU1pS1hsc3VJVGQ1bnlZTUNQYkZ6NzVPNUl3Qm1xVmFFMU0zR3NtNzNy?=
 =?utf-8?B?bVkyN0UwdGdoUGdmak5xRHB0TlhpaUczUVRlNXBJRGt1TGNwWXZjZ1JqTnNq?=
 =?utf-8?B?UUo0T1F1ZjNVLzZwSVhuRXBQQmZnR3F1anArOUl1aFFub2xuOWdsMlJKOEd4?=
 =?utf-8?B?L0ZZbXAxb0VVRko1cE1FL1B0QWVsbkdUVTVoNHc0WFIzUVVRbUNvVU96NExX?=
 =?utf-8?B?bHQzS1lnb3BORnJnOXo4RE10QUh2T0VoMmdaekdYN2RNN0JUa0I2a2t4Q01r?=
 =?utf-8?B?MTBnVUxCV24yRkFJM3JuUEZOdXFmUXkvRXd3OWk5QmVCQ0hTbG9lYjNjaDF1?=
 =?utf-8?B?bDM5WTdzc0h6a3c0bFYzMzcxbDJDU2FERkR1a2FUMGxqM3NEMUtLVldMc2Zx?=
 =?utf-8?B?Mndac0F5UXdTZmRLYTBkenFGOEQ0a1FFMExrREVXWWlnUlRKeGw1T25Qalpn?=
 =?utf-8?B?QWtGLzFFeitaa0d1OEppSS9hTjlTMnFWN00vYkpQMHRGQXdtOEJkNFowNVd4?=
 =?utf-8?B?VGYrQVIyL0dQRTdiVVdLcGd6NVJsWFo4cCtFZzhxMFBmd1B2eHFBNEJTM051?=
 =?utf-8?B?eWRmQmNwS2FHRnVmRFMrWnZpRFA1WGVJb1pEYTJtTnI2UTNEN28vemI1d2FU?=
 =?utf-8?B?K09YeXFKbHRmbDdVQjAzMFcwWG01a2RxS2tHaVBkR3RKQ0YwWThNV3NoUjd0?=
 =?utf-8?B?UjFYeGJZaGxrVEFXaFV5NmpFSVNBc3piK3grakZiZmJmV3VMcVVXUWU2V04y?=
 =?utf-8?B?aVBwTlJPbmMzTjJlUWdzelFPMHdUa0dzUkQySXZJQzlHTTdPcTlMdlZocVRi?=
 =?utf-8?B?T3hRMVNtNGlJK1hOT1VUcENGaEtDNUMwcVdkdUVsVHlaZVgzS3BJVGVMQVlo?=
 =?utf-8?B?YklEU3crMStqK3JFTjJUVjBlNUpqM0xzbGEzb3BObnpvaHcxbDRUSUlMalNW?=
 =?utf-8?B?anIzaHZjcFZjR2JUS2UvV3ZXWmwrSTBMNXdRdWw3UlowN1RzQndLSG9OUlox?=
 =?utf-8?B?MktDMExvazNIeExXbWFySzFsbWZFYVh3eXlwZElVZDlFdkZ0Mmx1Uy9ZSFNB?=
 =?utf-8?B?VUpkRkszemF6QzZ5WHdrMFNNOE5LN1FDbFYxYUQ3Zk55RUdGRjJaN0lVOW05?=
 =?utf-8?B?dmptV0dnZ0ZVMS9leFkrVFN6c2FaMWpOdUZxZ2JGVTRmbkpJQ0FHd21pdkVS?=
 =?utf-8?B?MGZhT1dSR2pGK0p6cGZYd1lPaEk1K1NnN3FET21GU0VnZjB3Z1lFNzNnd3J6?=
 =?utf-8?B?Z25TSDlUeDdLRnlvVzRqRWl6ZFlFQ05LN09leGdIeHZkbkJlVDdXMWsyMzBB?=
 =?utf-8?B?ZmlNbWdtSk5sOURydFg5OUNiSW9OZVJ2b1JEWEQxUDlDR0FYejFTN0tsTlFW?=
 =?utf-8?B?cDRLcG1wNEs0L2tIanhPWVkwRUpDWmpKL2Y5QndUUEl2V0VJNU1mSHlqdGF4?=
 =?utf-8?B?SWtUU2xwZnJnTzVhWWM1WGVnZEtrVHA4bFJFMXBOZGhTVUdHcDQwL3o2c2FO?=
 =?utf-8?B?UldNRmlndW1DMER6VUEwSWpvZUJuZUxJTHQ5Sm1WUjhnTndlMkZhdDFGamlq?=
 =?utf-8?B?dXp4TE5oMGVpVncwbnluaTVpNGVaZkVjUUkwTjlLb2dUa1Q3L2xvUDVlQzBM?=
 =?utf-8?B?QUwrcjExTElpUm5lbk4yVEgyUnlMZEpod1E5OWJNSFM3UlJsMktBT2VsMDVO?=
 =?utf-8?B?Yk4zUTZCWDd6NHdsV1owakxka3VUcm0vN2k1RFFoa0VhV2JaNWJSY1NTNlNz?=
 =?utf-8?B?RkR5WDF5VlNIcCtFM25EeXRHODF0anY1ZkdYM01EYUx4Qk5EVERlclNEWEkv?=
 =?utf-8?B?TmdzQ0JSby9Yd1B1RmJqcU9zckhMUmhMZStjQ0E0L09ybkszL2pGeWhtR2dp?=
 =?utf-8?B?L2ZldERVNGROQnhEZEJRWllXS1VmNk9jRUhmZTdXQlNZdUxJRm5tTHZNRkx2?=
 =?utf-8?B?akhIWXQ3WCtiZ3BPMmw1Yis0S3dXOVEyVEdSb2RkRmIzRWcwRUhwYlZxNnVZ?=
 =?utf-8?B?a3k0OWw5SVJLTnR1MXQxMFFuK3ZWMjhyVXlUTjlhUmJWbzhGV1hxNm8wdUtI?=
 =?utf-8?B?UXM1bGtMbGhtTE83dXYrREdvd0JFblNWMWp0aDRhLzdWOC9mZW45c0JOUE1w?=
 =?utf-8?Q?Rx0ztBVBujGVeMfYxY8qiOZhn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce38457-cb3b-40d5-93f5-08ddad57a921
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 04:30:16.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VavodeoB59nxVx6k/tjguFL12Rt9OfxPQZQhWYJibFuecT+N3bwKwrMMsj1hN6WLUppHkKuh+JPwfAdaYTjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

Hi Alex,

Would it be good to have this logic in the reset call back itself ?

Adding common vinst->reset stops the flexibility of having separate 
reset functionality for enc rings and decode rings,
can selectively handle the drm_sched_wqueue_start/stop and re-emit of 
guilty/non-guilty for enc and dec separately.

And the usual vcn_stop() followed by vcn_start() isn't helping in reset 
of the engine for vcn3.

I tried a workaround to pause_dpg and enable static clockgate and 
powergate, and then stop()/start() the engine
which is working consistently so far.

Regards,
Sathish

On 6/17/2025 8:38 AM, Alex Deucher wrote:
> With engine resets we reset all queues on the engine rather
> than just a single queue.  Add a framework to handle this
> similar to SDMA.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 ++-
>   2 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index c8885c3d54b33..075740ed275eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
>   
>   	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>   	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> +	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
>   	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
>   	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
>   	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> @@ -1451,3 +1452,66 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   
>   	return ret;
>   }
> +
> +/**
> + * amdgpu_vcn_reset_engine - Reset a specific VCN engine
> + * @adev: Pointer to the AMDGPU device
> + * @instance_id: VCN engine instance to reset
> + *
> + * Returns: 0 on success, or a negative error code on failure.
> + */
> +static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
> +				   uint32_t instance_id)
> +{
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
> +	int r, i;
> +
> +	mutex_lock(&vinst->engine_reset_mutex);
> +	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
> +	 * This ensures that no new tasks are submitted to the queues while
> +	 * the reset is in progress.
> +	 */
> +	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
> +	for (i = 0; i < vinst->num_enc_rings; i++)
> +		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
> +
> +	/* Perform the VCN reset for the specified instance */
> +	r = vinst->reset(vinst);
> +	if (r) {
> +		dev_err(adev->dev, "Failed to reset VCN instance %u\n", instance_id);
> +	} else {
> +		/* Restart the scheduler's work queue for the dec and enc rings
> +		 * if they were stopped by this function. This allows new tasks
> +		 * to be submitted to the queues after the reset is complete.
> +		 */
> +		drm_sched_wqueue_start(&vinst->ring_dec.sched);
> +		for (i = 0; i < vinst->num_enc_rings; i++)
> +			drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
> +	}
> +	mutex_unlock(&vinst->engine_reset_mutex);
> +
> +	return r;
> +}
> +
> +/**
> + * amdgpu_vcn_ring_reset - Reset a VCN ring
> + * @ring: ring to reset
> + * @vmid: vmid of guilty job
> + * @guilty_fence: guilty fence
> + *
> + * This helper is for VCN blocks without unified queues because
> + * resetting the engine resets all queues in that case.  With
> + * unified queues we have one queue per engine.
> + * Returns: 0 on success, or a negative error code on failure.
> + */
> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
> +			  unsigned int vmid,
> +			  struct amdgpu_fence *guilty_fence)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
> +		return -EINVAL;
> +
> +	return amdgpu_vcn_reset_engine(adev, ring->me);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 83adf81defc71..0bc0a94d7cf0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
>   			      struct dpg_pause_state *new_state);
>   	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
>   			    enum amd_powergating_state state);
> +	int (*reset)(struct amdgpu_vcn_inst *vinst);
>   	bool using_unified_queue;
> +	struct mutex		engine_reset_mutex;
>   };
>   
>   struct amdgpu_vcn_ras {
> @@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
>   
>   int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   			      enum amd_powergating_state state);
> -
> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
> +			  unsigned int vmid,
> +			  struct amdgpu_fence *guilty_fence);
>   #endif

