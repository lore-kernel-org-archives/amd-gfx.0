Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B644C3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 20:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC3B10EB67;
	Fri, 16 May 2025 20:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0cU4D8hI";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3B510EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 20:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJJfeIWA0fQ3LyDMlwugjSxOnqXbXlh99iCIYQFhQnkRAQ2HWUZeswsHnAyNybX5aC8STrNYE0c+knbDTz/R05NUJ1KBhxMtb7eOsh9fJ/nc7XilhldVrgzOkNbbilYNqlqe4tCuzWi1zao+st3vTyvWcTYNs4DrPD9XDmO3nsdgpkyicPEOeRgBvIjqDZhwfut7xYJxgHKrKjf4qEW6SRT0Fot1WBgdimXn3LsTI5aUJ2K6p0adcBaXwKbZPpp8gVzX+q7t1rl8FHPsXQIe4jzGla1p08gJXaw2x3E3YJtbKLQe7NKo2cqEiGc9VMqjv/l5Xe6uCOgw93Tzf+cqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnZq5OkKqcWQaprK8X2DOqVTglY8tBdQEvRLUn1dta8=;
 b=gHBEHdszvmZRn9em/Z1+s+UoAXcMzKmdfOCUNrC0YcfeCd9lMTCfMBIDjX3fxrZg9WKumh36qYWMxiXQjLv+6tYrSEDWD4X+TsZ/uZ6JfzzAJ8waFLefHf/lI5nVAN4QHKo6f3rThYDMro+ADBZ2k4tlPNa8B3NqB/ISW2WyAr9ZL5iY8t53aS9fBGtZHzxRYUyj5sIp3t5NlX1vfB/eH3eIIp5rLMXedyglJNMsFRsi3otH/z0TNemQ3irdgveda4ja8tz3MRD2736i489n2mEnJjrA7V7XiXJf8nn97MApfGUMtaJbyQCBaZZ7FbxhaLZCiq/cTxu7SvmheLDzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnZq5OkKqcWQaprK8X2DOqVTglY8tBdQEvRLUn1dta8=;
 b=0cU4D8hIlQLoer/UxGVdLxetM3ft/55jSrictSkQQxvEo6kNZfPGABcZQSSQysy7CyDxTPbMKLSBCZXzdCc2ikfcFCu65JweV4/jsRXU7WscbKsktZoaah1BZ+QO8nGTI1DfHvyU8MhyGAa9o+zhC4aLR4ueOq67EtlsSNfVLC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 20:46:11 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Fri, 16 May 2025
 20:46:11 +0000
Content-Type: multipart/alternative;
 boundary="------------SrcaUtCx3XRdh91FL9DaCyXI"
Message-ID: <f30b6320-eb6a-42c2-a8ef-77d856604f70@amd.com>
Date: Fri, 16 May 2025 16:46:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: read back register after written
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-9-David.Wu3@amd.com>
 <b52390dc-05a3-463b-9bee-001c6cafb303@amd.com>
 <73dd9680-1aca-4e73-b43f-495fede147cb@amd.com>
 <0242ae98-0d56-42b2-a58c-2a5bfa3697ed@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <0242ae98-0d56-42b2-a58c-2a5bfa3697ed@amd.com>
X-ClientProxiedBy: YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::29) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 562f1af1-0bc7-4244-6eaa-08dd94bab0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWt3VFN4L3JJUGRYZFhCR1hUS1QvL0VFc1EvdVpQanNYRW0vbE9FQ1VSeHcy?=
 =?utf-8?B?TUtLWUJ0SmhlRzVXbldkR0Q3dTJONzFQTVBpa1pPalZWM2RpQi9VaTU4a01R?=
 =?utf-8?B?eUMrRndqSlVWcE5kejgvYVIrTk5Jb1NHRzlVYll0WXVUV016MGxqTEcrSDY4?=
 =?utf-8?B?d09RUDVXcEhaSnBFM1BoWVRUbU53c0JQdnBXVjA2emdibkk1VFZHdVQ5aGhY?=
 =?utf-8?B?R3lEZkNyRmpVWUtnMkUyUjNCMkRXZVl3NG40d2VOTGZIQldiU0dDaW9HRzlQ?=
 =?utf-8?B?U1BDdmlrd2dWMHcwZjFYV2I5SFU2djJLdWRsQVgycWk0bng1dHovK2dhUFRR?=
 =?utf-8?B?amNBWGk4dGY4UG5Wd2VJQ3p1ZURtR3N6ZlFOdmtFcjV2NCtjVW9aaldlVVRF?=
 =?utf-8?B?UEI5bnc4dGRZOU5pNHVqWGdMa0dBbk5QNnJyQ1lQd3NCeEFFQi9Bd2tZekhi?=
 =?utf-8?B?NzgwUjlSTDYwNG1DSGJnNzg2bjd4M3N4MEJlalhGcG5pMGlxN0F0bmdiOUFF?=
 =?utf-8?B?V0UrRXpreWRVdWZYT0Rsd09KTjk4cFhhdk1QSkhiWHgzeU1pTWRLeW9vU21B?=
 =?utf-8?B?RlloUWQ4cEtaY1cyUUFPSWhmTWFGbmt2R0VGakxiU1JmSFdXWGhkQmlZRnVG?=
 =?utf-8?B?aFNjZmZieTlXV2x4cXY1NmRjdW1yV2ZjMlhFdmsyZ3V6Wklta1ZKdTZjWXU5?=
 =?utf-8?B?ZHR1dWp0Wm91K0pTM1JIWHpreUhZODdCeXlZcFZleWUxVEhBdDEzMzV0N2lx?=
 =?utf-8?B?MGhFTzRSTHl0L25kTjh3OFNkNW5SNWpKZzFhc2RpL3A5anFpK1U0VWVLSlFW?=
 =?utf-8?B?Q1VEcmpTQ2VTQitraFIxU2t1cHJoMXJ6NW1LbGdwVFN3SXhhK1J0NzhJOTdt?=
 =?utf-8?B?d0JMamVNK1BiczR1czBhM3lmTWhCYjhESElLeUdjZ0dpMXNRZ25pMk95SUV1?=
 =?utf-8?B?V1FQWEFvV1RzQWcwRDRmTU9NQzJyZitWaVY3dm5vck9qVERoblB5NVJyKzlY?=
 =?utf-8?B?enV3ZUJrYjVkVEd1L2ZaRmo2ckxXZWk3SG4zZmxCbU8xd1p0c1p3MmRybTkr?=
 =?utf-8?B?TzhpaHhRYkJ1elBEcERBOWFlbGUrQ0RYZUdRcFVXbTlQQ1UwNGxPQW44TThx?=
 =?utf-8?B?cXk0WWp1QmhRTU1lUVM3RWpJazFyRDR0OHUwVU1yQVlUb2cvMnpTeHB2dlpH?=
 =?utf-8?B?RG5qL1MvVkNoWGZsY0FQVFlNSkZGUW9CTmZueFlmM1Jva0tqdHl5N243MUJN?=
 =?utf-8?B?a3RkWHFiTHdLdEFucGxYOURyMyt5YU14V3ZHVHdVMGd1dWtZbGFQUEU2bnl4?=
 =?utf-8?B?QzNtVVpZOURQYzY0UjhFYlZCdGVwdU8yMFpiaEUvYlhtS0RKQUo0clpTK3pE?=
 =?utf-8?B?aU1UVjU4Vk1GQ0hFcnRaaHVYTnU3Ni8wZ2pkcXQ3VGlDQURrcmpiTUZ6UGFz?=
 =?utf-8?B?QkR5TjJvanJDV0tIc2lTbmpaeEFuMU9RR055QW1ONGdDMEEzRzF0TUhYUHZp?=
 =?utf-8?B?M3FwN1dBQ3ZJYzVXaDY3SG4xWnBXaitHMS8wczlxbmxYTDhSaEZOVW9JQ2py?=
 =?utf-8?B?NTIyeXI2NktFdFhOb2FoYVhoODJOTzA3VkFPeG8xZkRsc0dMT3NBWkNaeXdx?=
 =?utf-8?B?LzZLUWllbzk4WklBYzZ3ZlhJVjlYUkxJZ0E1N05oN0Q1TkNRdG94U01tc3BU?=
 =?utf-8?B?L2p1eHBVTk5FRXhuRTNtbnJqamlRTHU1UVIzUGlabWc3VlZBSTNwaVRCYkE1?=
 =?utf-8?B?aEtWb1FGTWNzNTF3dXhSSnQ1eEp5ZDBPYWFBMHd6bVFTUVpNc3d6RnB0U3cr?=
 =?utf-8?B?eFBPZEVRR1NtMmIzWWJZbTBycGM0ZldMaGwyZmh1RURPSzlJTkE0cWtBZWJ3?=
 =?utf-8?B?TjlqamtqYXNmZVVTUlpoS1YxbTNqQjNUbjBlQ1dIc3d1WlFhc0R1UGtYVWFM?=
 =?utf-8?Q?EvOjveJuPcI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDd6aVJnLzlmaWRjc0xORGY1dHlXdDVvRWNDdEQzNjNWMnpqTG4raHJSQy9B?=
 =?utf-8?B?NlFXdnZTY0ZpV1pLNkVDMlgyWVV3bVFIZG81cFNUUzFaNVFWR3d5T21iaG0z?=
 =?utf-8?B?cU84MytOS2tiZnVPVlpVSEw4bFJjaUhIa3dMTGZVc1BuYXhvbnNDRnI0azds?=
 =?utf-8?B?RTYwazhiYS84NWZtMWl5Mk5ZTlBKR2xkVzFIa2pocmJOaDdDWm9rZ1BuTDhS?=
 =?utf-8?B?OFVyTHVWTys3N1RJMGJOd1l5aEdlMjB4cXlrTkdYNUducnQzalBFa3lQbDFU?=
 =?utf-8?B?K2F1aWdic0JRbGRvZ3ljZ0VqWmRpamVXeUlWMXIzQ0lvUU1WTmYvcGVNSEI2?=
 =?utf-8?B?bG85TWdOYUZjUEw4S3dGajJrcWNjM1R3c2xyUkJUOHBwV0lFemY5cG1wV1g4?=
 =?utf-8?B?dVBIV1lPcWZ1dnBjeWpvdWxwcnVCby9rb1Ayb0FUVEJGeEF4N3RpeGFkdHo0?=
 =?utf-8?B?Y3JUejZtVXNOZ0hlbWFScDlRRjhkbzZ6bnVYSWMxVy9LUnV4MUUyY3pUaThs?=
 =?utf-8?B?S08rSnpsTWlnS2dXUnhOVUI4cVUzYUFUd3cvNU1EVEFqYzZqWHYvZzFrNTFV?=
 =?utf-8?B?eDZDU2RXRnhzUkJud3JvRVRjYnczSE5TRC80NHZESzNYRVlmWDdwYlM5UC9C?=
 =?utf-8?B?a1pnQmFDYXE0djVCR0RyUDlVRnVqSGlOR0R6WmpMdkkwTUNVRDRTSXNsWm0z?=
 =?utf-8?B?YjNoSklmWDU5L0g1cXpWQVBqOS9PbGlhWm5lL0NVcE1nVUJMNUpEWjJNWnA4?=
 =?utf-8?B?cC9hUmNMQXlneS9qd2xCNWJZRGthRk85cThGREEwZldONURzK0ludFNTWU5I?=
 =?utf-8?B?aFdKckNmWnNZNm5HL0FlbVhyZEgrVmlEQ2IzWmdsb20xeTZwbVZhblZmaXNH?=
 =?utf-8?B?RDhQSG5PbGFlcWc1SGlLRDRoTzkzaCtIME5PZ1NsZ1NnelJBS214UXR4WXM2?=
 =?utf-8?B?dUhiMEJYTTdNR0pieW9uNXZNall1d09yM3ArbmhsajRiQ2FzdXRHcm1kRTkx?=
 =?utf-8?B?Ty9KUGJ4WVR1RzUvaUVRZ01lRVRreld0ZHU1Z3cxUlp4NnJpa1VZVlI4QmhV?=
 =?utf-8?B?WTdWbURzVkNxdDdUVDJ2bEpUMjUyRHVYbzJsZ3N1SldsMGhCTjJqR0pOai92?=
 =?utf-8?B?TDkyM0FtbkQ1Wm1TUGx0TlViTTJYMDhIdEMvc2JRanBiUzNRanhCU0VOaCtu?=
 =?utf-8?B?RWo0dGNhWmUzbmhmeUlwWUxUSmZ1Tm9oME9hT1dxZ1pCMEMwTFhtdUJINFFI?=
 =?utf-8?B?dWx3dE9JSnpCWTAwZ0w0a1ZsVGlkdmJXaEFRZ3FYWFEvRDVIWXRLTUwxNEY0?=
 =?utf-8?B?THBVOXNCeVFCdU92cXdORmdYd0NXTjFaUitFbXpiWTlUVTVWOEQwdkFEL2Vh?=
 =?utf-8?B?R0NYcDBGVGlTczZJZzFOQzQ3RXVISjdWOXBubHRjaTRkSE52N3o0ek0zTmp5?=
 =?utf-8?B?MzVrV0NBcjdOaGxrTUxtNWl4VXl3ZnhIa1FrQzJRbSswMXFwaVFpOHFnV0xk?=
 =?utf-8?B?eGJnc2tMU1hMM0V5aEtJeDEyUmpRMTZmMmZZNUVpQnhrUUVzbUFBS2lrcy9K?=
 =?utf-8?B?NVdOdzRYa1BVdzdpTFFKV0xqa2VDeUphaWZoeUFFajEyWVBRZXVLOGF4OWtn?=
 =?utf-8?B?bSsxTkJHRVh2N05XdCt3TVc5bVI0NkFLNDNrWTdocFlxc054SlljM05EZFI5?=
 =?utf-8?B?N0JwRGtaQW9wSmVva1I0T1ordHQzUWZqZmZlU1Y1RERlcWpKUGtmN2gwbUtz?=
 =?utf-8?B?ZHBlNXFGY1RXUngwc1pxbVQ5WWRvbHhPbCtvcVNMb0xVQnFsbXBCdWtMK2dT?=
 =?utf-8?B?OUJHRzBaOVUzY1daZ0Q0cW5tNHRFektCQnB3MzA3S3kwajRLSU82a0ZVRHhN?=
 =?utf-8?B?UFlrUWs5NWtJdiszTzFZL3NoQnppN1RIcXJBVEdILzA5V1RNd01HVzEvaEIw?=
 =?utf-8?B?d1dtd2lCQ01aWVpYdlBWUjR4bUZGTUlrclArK1A0YTJzb2lRZ3h0eVBjbVQv?=
 =?utf-8?B?Kzg2ZHhiTC9BeUNqMEd5QnhTUXNSQklhVi8rYWsrMWtsa1h5VzlDR3hteUxB?=
 =?utf-8?B?K1ZPenkvaVBRbHNyVTlmdWtQYi92VUlxckpxYjM5aWN5U3hqaHZKcWFXRi9n?=
 =?utf-8?Q?shoPwMQLOIZLGAX9j7ECqVk0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562f1af1-0bc7-4244-6eaa-08dd94bab0dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:46:11.0867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L8AaKQpi+Ei6UxsyFXKJh4KjlwJ8tHEZBm+yM1NSOfYkpSzLnjj3PsdrWCfn27dRnURfH0ASsEbR46RjwM+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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

--------------SrcaUtCx3XRdh91FL9DaCyXI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hahaha! ok - I can drop this one (as no need but rather make it clear 
that any register read should do)
I kind of disagree about guarantee  - as long as the theory(read post 
write on PCIe will allow writes hit hardware) hold it is guaranteed. Why 
I ask for testing is to prove it works as expected which I am confident 
about.

Thanks for input. I will drop this change regardless.
David

On 5/16/2025 1:45 PM, Christian König wrote:
> Well testing only falsifies things.
>
> I agree that it should server the same purpose, but we don't have a guarantee for that and as far as I can see there is not need to switch to a different register.
>
> So this change seems superfluous if not dangerous to me.
>
> Regards,
> Christian.
>
> On 5/16/25 18:23, Wu, David wrote:
>> Hi Christian,
>> For this change on VCN5.0.1 I will leave it to Sonny for a test. Since the readback is for each VCN instance it should work for that clock domain. As Alex has pointed out that readback post all writes will let the writes hit hardware, using UVD_STATUS instead of VCN_RB1_DB_CTRL should serve the same purpose. I also tested it on STRIX VCN4.0.5 and it works ( using UVD_STATUS  instead of VCN_RB1_DB_CTRL ).
>>
>> Sonny - Would you be able to test this simple change?
>>
>> Thanks,
>> David
>> On 5/16/2025 3:07 AM, Christian König wrote:
>>> On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
>>>> The addition of register read-back in VCN v5.0.1 is intended to prevent
>>>> potential race conditions.
>>>>
>>>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
>>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>>> index 60ee6e02e6ac..79d36d48a6b6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>>> @@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>>>   	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
>>>>   		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>>>   		VCN_RB1_DB_CTRL__EN_MASK);
>>>> -	/* Read DB_CTRL to flush the write DB_CTRL command. */
>>>> -	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
>>>> +
>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>> +	 * otherwise it may introduce race conditions.
>>>> +	 */
>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>> I'm not sure that this is a good idea.
>>>
>>> The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.
>>>
>>> Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>>   
>>>>   	return 0;
>>>>   }
>>>> @@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>>>>   	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>>>>   	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>>>>   
>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>> +	 * otherwise it may introduce race conditions.
>>>> +	 */
>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>> +
>>>>   	return 0;
>>>>   }
>>>>   
>>>> @@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>>>>   	/* disable dynamic power gating mode */
>>>>   	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
>>>>   		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
>>>> +
>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>> +	 * otherwise it may introduce race conditions.
>>>> +	 */
>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>>   }
>>>>   
>>>>   /**
>>>> @@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>>>>   	/* clear status */
>>>>   	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>>>>   
>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>> +	 * otherwise it may introduce race conditions.
>>>> +	 */
>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>> +
>>>>   	return 0;
>>>>   }
>>>>   

--------------SrcaUtCx3XRdh91FL9DaCyXI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <font face="Helvetica, Arial, sans-serif">hahaha! ok - I can drop
      this one (as no need but rather make it clear that any register
      read should do)<br>
      I kind of disagree about guarantee&nbsp; - as long as the theory(read
      post write on PCIe will allow writes hit hardware) hold it is
      guaranteed. Why I ask for testing is to prove it works as expected
      which I am confident about.<br>
      <br>
      Thanks for input. I will drop this change regardless.<br>
      David<br>
    </font><br>
    <div class="moz-cite-prefix">On 5/16/2025 1:45 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0242ae98-0d56-42b2-a58c-2a5bfa3697ed@amd.com">
      <pre wrap="" class="moz-quote-pre">Well testing only falsifies things.

I agree that it should server the same purpose, but we don't have a guarantee for that and as far as I can see there is not need to switch to a different register.

So this change seems superfluous if not dangerous to me.

Regards,
Christian.

On 5/16/25 18:23, Wu, David wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi Christian,
For this change on VCN5.0.1 I will leave it to Sonny for a test. Since the readback is for each VCN instance it should work for that clock domain. As Alex has pointed out that readback post all writes will let the writes hit hardware, using UVD_STATUS instead of VCN_RB1_DB_CTRL should serve the same purpose. I also tested it on STRIX VCN4.0.5 and it works ( using UVD_STATUS&nbsp; instead of VCN_RB1_DB_CTRL ).

Sonny - Would you be able to test this simple change?

Thanks,
David
On 5/16/2025 3:07 AM, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">The addition of register read-back in VCN v5.0.1 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60ee6e02e6ac..79d36d48a6b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
 		ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
-	/* Read DB_CTRL to flush the write DB_CTRL command. */
-	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I'm not sure that this is a good idea.

The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.

Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.

Regards,
Christian.


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre"> 
 	return 0;
 }
@@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 	fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
 }
 
 /**
@@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 	/* clear status */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------SrcaUtCx3XRdh91FL9DaCyXI--
