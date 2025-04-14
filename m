Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C366C3601E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 06:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F9710E2EB;
	Mon, 14 Apr 2025 06:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awH5OqgM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8EE10E2EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 06:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P95UKZEPe/ykjQaam85LhklRx1mdkwcuzOgJmTPSuw2qOzxaIOS3MX4/EvTHeJXAysbvU2VmBMjViKKAJAVvp49tOizlykElm83ydb7GWeQH7+2NxxF3AW+iR0rpsRRu56U4seVEjOVc40pWslHxe0OOoi+CH34arRX4c1WxKyKHU5uMlal4krwD/5wVnvwM1TM3xV6NBP9YqRuwHH7F18ZqIW6+9INwQ63J3djz0j7O7jdy6yL0Itzatw8UBNyb3fnZtRqptzJcMfPbWic/3sN8KoMNRj7yV0LLGRlDr15knK01YZDUXQNwnPsW/lB3utshUbQGEwWF82e6Mg0lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfUZITKhgpGoOx8Z59M9b3n9img6mUsl8qojxjTWvv4=;
 b=VkL2Sq2c09yJFos5ezcXi5aZIG/KBAsKyrnZh5zefvnX0vuIz1P5nWjleyyIpP/q4LqdfQUosXu7SafKGdcY4a9D91vEbboeL/yz/bnvKW665C09k0BV47O8drCzVBcQneGwdPEi40qeLDjVCxPZkeXAFOrZYYnyIxAKx3s4emAr0l8GeiNI6VwREQYrnzcBKbydu5a7wYdtAdzdJwwMow1TaqBP0tAmt6/9Rq0zCpguYKh4lzcA+TBT9/S/hSgdY5Z2B+mUOkALqbiAfGF3iJoeNhUK1kAEy90vJUWlZq5Jt5eyLxtAwPyRThk6v4xtoPNt/SxKp5m8OdES9TCx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfUZITKhgpGoOx8Z59M9b3n9img6mUsl8qojxjTWvv4=;
 b=awH5OqgMSJ9ppTZttLvZS/xO2S5TjW9FlBCAJywBlHdmxDKGOoNeRFKDLh7xJDMZInnrj+lFPyhxIgg+2QeMme5KWa8cLlAZ7sJcYC0+FjJ6xZzZSObgjd12SedrPhiXIRJO8AqBnmhdP9BxvMMYraeitlJY/JPQ6Zl/lgdZREE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 06:30:15 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:30:15 +0000
Content-Type: multipart/alternative;
 boundary="------------OhyHLUaEj3W7CxcYCoYzOL6t"
Message-ID: <a3d86837-a4fb-473e-82b5-44abda9bc8be@amd.com>
Date: Mon, 14 Apr 2025 12:00:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] drm/amdgpu/userq: integrate with enforce isolation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
 <20250411184825.2890189-10-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411184825.2890189-10-alexander.deucher@amd.com>
X-ClientProxiedBy: PN2PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::22) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c0fe85-03a6-4ee7-1bfa-08dd7b1dd169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXVxdit6MloyKzUxL3VOYzJxazBlVDVhYjNRNzNkN0ZXOWdwYS93azVJNGxX?=
 =?utf-8?B?c3Flc08vTnlOb2JWd1JZcUEwc2tGejkvek9IR2hwNmJ0d3dKT0orWVFlMnJx?=
 =?utf-8?B?U2xVUklGMkwvUERBZmh6ZWpNQXU2RDFWYzVwczdZbXVUWHFUcE1TMWZqYnhS?=
 =?utf-8?B?YmZ2R0t2NU5yU1ZYc2N3NUlSd2hTdHZidHZqY1o1MVBmWG5CZzVCWk9PcitO?=
 =?utf-8?B?N2RvaFRZbnRiSVplUGZmZHdPTXRlVmRvR3FDY2RZbW9CWFI3eEJnOFhvU0F1?=
 =?utf-8?B?UmNoVnkyZEs2eWRYeGljbi9VMkJQMC9wdFJXNUl4a1gzWnRUdjhSVEZKSW41?=
 =?utf-8?B?TnUvWGRiNGp3MmJzeGZYaDdXVHZITGJxSVNvSHNtUGlaYTMveHZBeHpQZXpi?=
 =?utf-8?B?ZlpTbkx5MFU2czZFLzZqa25qMkxaN3lTdWtSSXlxQkV2OFZwUlA0VDJTcDNz?=
 =?utf-8?B?Ykw3M29veWVCdmV2eEZZemdJVEVpZmRhMktmUjl1RUptTDkvM2NqdVYxbjNX?=
 =?utf-8?B?NHdCN3lEMXV6WWJZT3F4cWdaL1dUeFdLa1h1WFJzNExNbVllWWFUQ1hQZjBO?=
 =?utf-8?B?VSt1YWtWd0tsQUdTaHFaSnFqL2t3MDJ3ZkZWVDUzeHVUZjNuRjNaT3cybHhz?=
 =?utf-8?B?REVZZWRWMEp0bjNROXRjOEhJZmsxOWh4dEN6NHB4K3A2YStFTXVsM3JBaVNV?=
 =?utf-8?B?UENaL0I2Z0FSK25oY3NjMTY5QUFlMEY0TVZBZXBOOXN3UWVadzliVFdHVkRa?=
 =?utf-8?B?MWNUak5samdJZTVYTi9uaUs5ejBYdk5odzV2bXVRU3MraUVybVU2Vjlqczd6?=
 =?utf-8?B?aG9DRWN0WVBqYmdPSnMvQ3l3aU1RQjZtSVlPY0h2bC9seWFuaWtNL09ydVB1?=
 =?utf-8?B?ZWdFUmJwb2JRb09EdmZGeUF4VjI5MjJmUm1YYThzcHNpTDFmSVFXZlJHT2V5?=
 =?utf-8?B?c3M5RzcwNTh1aWVJRzRrZEtUYUNBQXF3b002U2lqY1dUYVZrdzQ2QUR1M1Nm?=
 =?utf-8?B?bDJaY2hsT0FYY2liRHlSaDJYcGJFTUd4akVKdU1hckpQVmJyQnlUandZY080?=
 =?utf-8?B?cUN4RktJamZpbHFUd1hyQjZ4T013eEg0M2NCdmliNllIa09VN01pOWROYUpo?=
 =?utf-8?B?ZUFZbGpaQkJrM0FxT21KK2JacGwzZC93OWNkdDJ2eVJxZlFvRWVmTUtyQ0hI?=
 =?utf-8?B?OHQ3SEE3RFVMb2NJM1J1RnhwR09SK1hhVmhOQ0ozc3FOVFBjelZxTGpNOUtG?=
 =?utf-8?B?OGtkLy9zNU94ZEJTVmpOZTRiN3NBcjVyRDRBVE94WnYxMjlyUEtJWVQxNHEv?=
 =?utf-8?B?S1J0US9WWU5saUhZTi9OeGNaMDc5Q0t5SGkvL3FFZXlYUkNMSzZMd1FjcCtX?=
 =?utf-8?B?clRvR1NEMHVmMXdGWHgwamFDUnJZOTQ4SnJjTVNlTHdsSUd0SkRZM2ovR1Nk?=
 =?utf-8?B?dEpJUFBUNXNJUGdkK2dVZUhTS05uNXdYRXRzUmF5c0lnNGU1MTVqQlNlVjNx?=
 =?utf-8?B?eHFMcDBZNzZGemNPRlRrbVVibFNlTldBZXRqekNZMlNJSWNlcEF3ZnBTNFhU?=
 =?utf-8?B?bHducDRXQzZwQ1dIamJkSUlnTGhaOGlWN3NoK0UrKzJqZlBRM21aOUhLbzFR?=
 =?utf-8?B?MzBmMDBSYlJGZlA3Q3F4djM2QmRTRkRDdFNNdTlXM3VTZGVlUkNqeG5yWWhX?=
 =?utf-8?B?MjdPVU5ROVp1cTBMbVlKMFNzblZ0UHB5cHRDRUI2a2cwMXpMakZ1dGh0alFZ?=
 =?utf-8?B?bjkrc0dLVDJtMU95TmVpVXlqUTFTVjVwVkdSRFdGQ0U5K3hMUXBaMThhazNa?=
 =?utf-8?B?UUE3dWdYS0VLR3dhQzNXcnUyTDQ1Ujg5aU1BWituZ3JBei9MKy95TWUzMnpX?=
 =?utf-8?B?bWl0cFkwdUtkcmlCSjQ5ay93dUIxaklxYTJVWWtvd1VJaE9yMUZySHloeUY0?=
 =?utf-8?Q?5THUDa+8Ppo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRmT3lUNDc0TUY0eWQzSXMzSmZPQkNwekJLZFR2azNGeFF2NDA4Qlc4ZW1j?=
 =?utf-8?B?VUNaZHUzTkc0UUxLTVpTOFl1dzV3RHUwR1l2TTI0QWdqb2hpTEZYbzN0VWVl?=
 =?utf-8?B?RzZSUmRlQ1c1dG9JMzh2TCtNT05KY0VmRGVzKzY3ZGZxeUNMWkhBNGZtMTZv?=
 =?utf-8?B?Z1JPOXljMWh4V2g4MEIzb09FZFM4cC9JWDRxcDU0YzU4UEdoVlhUNU5qbHpN?=
 =?utf-8?B?bUQwUFhwcGpSeXQ4VGxxeDgvSUw3UXV1OXhCdmIrUGdEQ1FvRmhNcVJWc1JR?=
 =?utf-8?B?WS8zR004WE1ZYjhsYk11YTNXN1loYlRmZDY4ZHN4cnBmQmt0dDVNbVpuQmo4?=
 =?utf-8?B?NVp2QkE2SkUzUG5aK0NnQUU5WitHQU9TN0IwcWlkMGtob0U5NmxTd3dMZnNF?=
 =?utf-8?B?aS9XaTVFbEhXTGswSnJTWHRMTWh1OVhWUXJRZG9yRXdMYTNWd1lxTWw1RkR1?=
 =?utf-8?B?b3hGK0NsUURZakFSMmNkYVhvbys1dzV6QStleDRFVkNvdGhXdmZwcmc0ZERr?=
 =?utf-8?B?eUNGWnRHUE5IQjV3azQwM2h4UW9Ya0p2U0E3RE5uS1ZQVGU1cWVCL2NKYUVs?=
 =?utf-8?B?eXhNYWQ4aFRVVmw3RHlWS0VFUDYxWHhHc0JCMWVxZXdyQkxZQ0I3VWJ5TzNL?=
 =?utf-8?B?R1A2TEpIVW5Oa21TejE3WW16MnkyZVlWNWxYUFlsQ0NxelhZcHhDVTNTbjdQ?=
 =?utf-8?B?MFBoWFUzU1J2MW5NWXhITFZmcEw1MkZCbThuOTBlRFdaYUM5U3V3eUN6K25j?=
 =?utf-8?B?VWdwQ0ZYZXI1eUhnalNiSkNaeTZHano0QTkwcHdmdXJ0c2RVTEs4TDAzMFhy?=
 =?utf-8?B?VDJHMmNBUWdCYStKZHJyRTgwekFBSlJ0NEFjVDFXWVBTSmJCallPRUs1S0VS?=
 =?utf-8?B?R290eHllbnFZaGRvTHdZSlVJQXdyd2RKTzdyZjhjRG9nT0FUTHRWZUsxZFJF?=
 =?utf-8?B?NnJ5Z2E0NGwvNzV5VE9pN1JnT1NvVWUvdFhOcWFpOEFSSEtvVlU5UjRoMy9K?=
 =?utf-8?B?UFZRcWdoYTJ6cDJNTlJzTjlsbjBMTWhUcE5hdFNTd2Q2Zm5YWlA0M1YvRm1I?=
 =?utf-8?B?UmV6bGFDRmdwY290dGhRNHRUUTVJU3RFQWVGei9CMzc5RWRzYkNwUUZqZ293?=
 =?utf-8?B?VHoweW5UaldCRTlGOENTMG4xSVdWQUViNmtha2g5amYzOHk1dWROajA1b3R4?=
 =?utf-8?B?WmxYTXBMSVVXZExLQlRodnIyYTd5WGFXdTRuOFpIQ015U1AxejhwTU95ejlW?=
 =?utf-8?B?Vk1BVlVYZ2pzT0JhY2thOUs0VTMyNXFXenhCcm9YZmx1Y3ZmU2JOcWtHWjlD?=
 =?utf-8?B?OEsxU3RZeGsxZi9jNksxTkZmbSt4bm1NRW5VREh5OWIzUlRSTmhpNFptVG1k?=
 =?utf-8?B?Z2g0VVhtV3ZsWndWcmZPMnY1VGZxb3l0UnM3UXFYazQzd1pFYzNCUVRHaFRJ?=
 =?utf-8?B?dEl1ZGtCN3EyaGV6KzJsd3V0SmR0dGlHQW1NMVZ6aHBRZ0x6WnU0K29WNnV5?=
 =?utf-8?B?V0VFaVdBdU5jS0kvTUIzRk01V1d6T0FnVUZGMkQ1NHpTOVRqbitIMS9WcEdR?=
 =?utf-8?B?UUVDQ0dod0JsMXFrRVByOFFPVSt4L1YvdGhjSlJ0RDM1Sm9IWCtwOG83dzE3?=
 =?utf-8?B?OHFJblBmRHJ3cDdhbGFDdWpzMllhanJRaEV2M0xvMGhVZkMyK2VRV2pEcGhh?=
 =?utf-8?B?YlFGdEZHZ21IeFpSS01TOGw5ZGFndnpqL3FRWjZKQTRkV1BIUVNCb1lDZ1Mz?=
 =?utf-8?B?US8rNVJnU054QmNtM1l1OStXK1RFMVd0czJGejhWVnNWRW1SdXlvd3BTbTM4?=
 =?utf-8?B?cEFyM0p5bWZOcmR2cE5xTHoveXdFVm04aXk0ZXBybWdhaG5tRkFWeE45ZkFm?=
 =?utf-8?B?S0MzaFlKcjZFUGlmRVVLQi9DeXI5NUZDcWRpMUpQUHZJZGdSY080bnk0RUxq?=
 =?utf-8?B?YUtkYWNDcDJYVS8zeENNMFUxN2hBTmJZMm9vNGlXTDlXWG11UFp2WDZ6SXJE?=
 =?utf-8?B?MHZmVCtuYTVQc3RHWHgzUlVXMzhGN1VnYWVvSDU2OE1yMTNIeGdSaTdRTDRW?=
 =?utf-8?B?dUZLZS9hdlRQeU0wU2pSZzc0a2pjN2tWOU9lMmZwYWwzdDRKNE1ZSkpiWjJh?=
 =?utf-8?Q?/ejRedNW5pwbowPhVii2CEa6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c0fe85-03a6-4ee7-1bfa-08dd7b1dd169
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:30:15.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Phv3Qr2nvgKByzazRsSgy8YT1CChzupPxKAhzfO5n3hrow700wFS2pSvb5uvnDcD05CWOMJ1gH1wdBGARAeHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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

--------------OhyHLUaEj3W7CxcYCoYzOL6t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/12/2025 12:18 AM, Alex Deucher wrote:
> Enforce isolation serializes access to the GFX IP.  User
> queues are isolated in the MES scheduler, but we still
> need to serialize between kernel queues and user queues.
> For enforce isolation, group KGD user queues with KFD user
> queues.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 34 ++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
>   3 files changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e7398e70d6795..fdb7a6d4c57d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4362,7 +4362,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		amdgpu_sync_create(&adev->isolation[i].active);
>   		amdgpu_sync_create(&adev->isolation[i].prev);
>   	}
> -	mutex_init(&adev->gfx.kfd_sch_mutex);
> +	mutex_init(&adev->gfx.userq_sch_mutex);
>   	mutex_init(&adev->gfx.workload_profile_mutex);
>   	mutex_init(&adev->vcn.workload_profile_mutex);
>   	mutex_init(&adev->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7fc4e62536e10..7ccab1268e7ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1947,39 +1947,41 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>   static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>   				    bool enable)
>   {
> -	mutex_lock(&adev->gfx.kfd_sch_mutex);
> +	mutex_lock(&adev->gfx.userq_sch_mutex);
>   
>   	if (enable) {
>   		/* If the count is already 0, it means there's an imbalance bug somewhere.
>   		 * Note that the bug may be in a different caller than the one which triggers the
>   		 * WARN_ON_ONCE.
>   		 */
> -		if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] == 0)) {
> +		if (WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx] == 0)) {
>   			dev_err(adev->dev, "Attempted to enable KFD scheduler when reference count is already zero\n");
>   			goto unlock;
>   		}
>   
> -		adev->gfx.kfd_sch_req_count[idx]--;
> +		adev->gfx.userq_sch_req_count[idx]--;
>   
> -		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
> -		    adev->gfx.kfd_sch_inactive[idx]) {
> +		if (adev->gfx.userq_sch_req_count[idx] == 0 &&
> +		    adev->gfx.userq_sch_inactive[idx]) {
>   			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
>   					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
>   		}
>   	} else {
> -		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
> +		if (adev->gfx.userq_sch_req_count[idx] == 0) {
>   			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
> -			if (!adev->gfx.kfd_sch_inactive[idx]) {
> -				amdgpu_amdkfd_stop_sched(adev, idx);
> -				adev->gfx.kfd_sch_inactive[idx] = true;
> +			if (!adev->gfx.userq_sch_inactive[idx]) {
> +				amdgpu_userq_stop_sched(adev, idx);
> +				if (adev->kfd.init_complete)
> +					amdgpu_amdkfd_stop_sched(adev, idx);
> +				adev->gfx.userq_sch_inactive[idx] = true;
>   			}
>   		}
>   
> -		adev->gfx.kfd_sch_req_count[idx]++;
> +		adev->gfx.userq_sch_req_count[idx]++;
>   	}
>   
>   unlock:
> -	mutex_unlock(&adev->gfx.kfd_sch_mutex);
> +	mutex_unlock(&adev->gfx.userq_sch_mutex);
>   }
>   
>   /**
> @@ -2024,12 +2026,12 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>   				      msecs_to_jiffies(1));
>   	} else {
>   		/* Tell KFD to resume the runqueue */
> -		if (adev->kfd.init_complete) {
> -			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
> -			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
> +		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
> +		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> +		amdgpu_userq_start_sched(adev, idx);
> +		if (adev->kfd.init_complete)
>   			amdgpu_amdkfd_start_sched(adev, idx);
> -			adev->gfx.kfd_sch_inactive[idx] = false;
> -		}
> +		adev->gfx.userq_sch_inactive[idx] = false;
>   	}
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index caaddab31023f..70b64bb1847c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -475,9 +475,9 @@ struct amdgpu_gfx {
>   	bool				enable_cleaner_shader;
>   	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
>   	/* Mutex for synchronizing KFD scheduler operations */
> -	struct mutex                    kfd_sch_mutex;
> -	u64				kfd_sch_req_count[MAX_XCP];
> -	bool				kfd_sch_inactive[MAX_XCP];
> +	struct mutex                    userq_sch_mutex;
> +	u64				userq_sch_req_count[MAX_XCP];
> +	bool				userq_sch_inactive[MAX_XCP];
>   	unsigned long			enforce_isolation_jiffies[MAX_XCP];
>   	unsigned long			enforce_isolation_time[MAX_XCP];
>   
--------------OhyHLUaEj3W7CxcYCoYzOL6t
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">&nbsp;</p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Acked-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <div class="moz-cite-prefix">On 4/12/2025 12:18 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250411184825.2890189-10-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Enforce isolation serializes access to the GFX IP.  User
queues are isolated in the MES scheduler, but we still
need to serialize between kernel queues and user queues.
For enforce isolation, group KGD user queues with KFD user
queues.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 34 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e7398e70d6795..fdb7a6d4c57d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4362,7 +4362,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		amdgpu_sync_create(&amp;adev-&gt;isolation[i].active);
 		amdgpu_sync_create(&amp;adev-&gt;isolation[i].prev);
 	}
-	mutex_init(&amp;adev-&gt;gfx.kfd_sch_mutex);
+	mutex_init(&amp;adev-&gt;gfx.userq_sch_mutex);
 	mutex_init(&amp;adev-&gt;gfx.workload_profile_mutex);
 	mutex_init(&amp;adev-&gt;vcn.workload_profile_mutex);
 	mutex_init(&amp;adev-&gt;userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7fc4e62536e10..7ccab1268e7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1947,39 +1947,41 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 				    bool enable)
 {
-	mutex_lock(&amp;adev-&gt;gfx.kfd_sch_mutex);
+	mutex_lock(&amp;adev-&gt;gfx.userq_sch_mutex);
 
 	if (enable) {
 		/* If the count is already 0, it means there's an imbalance bug somewhere.
 		 * Note that the bug may be in a different caller than the one which triggers the
 		 * WARN_ON_ONCE.
 		 */
-		if (WARN_ON_ONCE(adev-&gt;gfx.kfd_sch_req_count[idx] == 0)) {
+		if (WARN_ON_ONCE(adev-&gt;gfx.userq_sch_req_count[idx] == 0)) {
 			dev_err(adev-&gt;dev, &quot;Attempted to enable KFD scheduler when reference count is already zero\n&quot;);
 			goto unlock;
 		}
 
-		adev-&gt;gfx.kfd_sch_req_count[idx]--;
+		adev-&gt;gfx.userq_sch_req_count[idx]--;
 
-		if (adev-&gt;gfx.kfd_sch_req_count[idx] == 0 &amp;&amp;
-		    adev-&gt;gfx.kfd_sch_inactive[idx]) {
+		if (adev-&gt;gfx.userq_sch_req_count[idx] == 0 &amp;&amp;
+		    adev-&gt;gfx.userq_sch_inactive[idx]) {
 			schedule_delayed_work(&amp;adev-&gt;gfx.enforce_isolation[idx].work,
 					      msecs_to_jiffies(adev-&gt;gfx.enforce_isolation_time[idx]));
 		}
 	} else {
-		if (adev-&gt;gfx.kfd_sch_req_count[idx] == 0) {
+		if (adev-&gt;gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&amp;adev-&gt;gfx.enforce_isolation[idx].work);
-			if (!adev-&gt;gfx.kfd_sch_inactive[idx]) {
-				amdgpu_amdkfd_stop_sched(adev, idx);
-				adev-&gt;gfx.kfd_sch_inactive[idx] = true;
+			if (!adev-&gt;gfx.userq_sch_inactive[idx]) {
+				amdgpu_userq_stop_sched(adev, idx);
+				if (adev-&gt;kfd.init_complete)
+					amdgpu_amdkfd_stop_sched(adev, idx);
+				adev-&gt;gfx.userq_sch_inactive[idx] = true;
 			}
 		}
 
-		adev-&gt;gfx.kfd_sch_req_count[idx]++;
+		adev-&gt;gfx.userq_sch_req_count[idx]++;
 	}
 
 unlock:
-	mutex_unlock(&amp;adev-&gt;gfx.kfd_sch_mutex);
+	mutex_unlock(&amp;adev-&gt;gfx.userq_sch_mutex);
 }
 
 /**
@@ -2024,12 +2026,12 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 				      msecs_to_jiffies(1));
 	} else {
 		/* Tell KFD to resume the runqueue */
-		if (adev-&gt;kfd.init_complete) {
-			WARN_ON_ONCE(!adev-&gt;gfx.kfd_sch_inactive[idx]);
-			WARN_ON_ONCE(adev-&gt;gfx.kfd_sch_req_count[idx]);
+		WARN_ON_ONCE(!adev-&gt;gfx.userq_sch_inactive[idx]);
+		WARN_ON_ONCE(adev-&gt;gfx.userq_sch_req_count[idx]);
+		amdgpu_userq_start_sched(adev, idx);
+		if (adev-&gt;kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
-			adev-&gt;gfx.kfd_sch_inactive[idx] = false;
-		}
+		adev-&gt;gfx.userq_sch_inactive[idx] = false;
 	}
 	mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index caaddab31023f..70b64bb1847c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -475,9 +475,9 @@ struct amdgpu_gfx {
 	bool				enable_cleaner_shader;
 	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
 	/* Mutex for synchronizing KFD scheduler operations */
-	struct mutex                    kfd_sch_mutex;
-	u64				kfd_sch_req_count[MAX_XCP];
-	bool				kfd_sch_inactive[MAX_XCP];
+	struct mutex                    userq_sch_mutex;
+	u64				userq_sch_req_count[MAX_XCP];
+	bool				userq_sch_inactive[MAX_XCP];
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
 
</pre>
    </blockquote>
  </body>
</html>

--------------OhyHLUaEj3W7CxcYCoYzOL6t--
