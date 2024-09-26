Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549B7CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F139210EB7A;
	Thu, 26 Sep 2024 09:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/mKhqjO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312FB10EB7A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y//OK8EFYVP71NluRMn4meI+70qybvC3hfMc6ZerqEgrubJL08/cdI/A/11Q1Sou8nUm/cRI6kjGhyW+FwMDc/eW1FrtzzO9+IQMsdyL/mwotcvrfTWu1WP/Fhq6bb3sqsoLWtc75o89K9MwLg/3FceRuHVQV6aAM9XRzISvkdb9maMGQYiPEec0WZx6OY0wxYDmJrF4qOJPL1MIO1qWGCfAzv5g7fb5AiugW3EjOAXMupyVQYnhf6bYVdpFFgFlskd+/yVnF+BnvpmlchP+uNKfQ0lNw9M3/B+aEaxnGhbHgTzMyYEG8eady5pppOlF1YXxN2IMUw9WVhayNYtmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c908KyvI41G0dnxLBKQcEs7ucSLS/a9p9au03LBoj2k=;
 b=PYr+mbCAW8GuLgjkWQ/ViF/z5AhWymtr3GPqRD/WvjL8BeiMDptfBgBROUct7dKxyQxt1tw3U2X2Bq8QINQBxlKJuHWGfWvOAEi7PCzHvkggqvDTqwGW46g8ibqw+qtIspZDKEMPboMzFkK7qHUzFLMiYPWWj6JdRwixJ4fmW3GOqgQ0fh1xBUOHfVxUHpegevYNA1Nc+v83iQJ3LimUj+IgYZmo/59nbHzK6Ok+04ndjaujXsIwx0FiXHHhW1f/0ylP63g5rk7cAKNiqr+H7bKFjQ9z1/qoUU8H7vEp+iJHcaxX71q7L9eaiu0P/iC4lbdfvsi1eyp228ehAbMazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c908KyvI41G0dnxLBKQcEs7ucSLS/a9p9au03LBoj2k=;
 b=u/mKhqjOXQyGzRqZ72gHNMXZV67RjjPUQ0kiMUrsa8aO3I2X6zSzndwQfwcuLFBy8ULNgldrfFv065Hm+rCwzHdpOZMh3vorPc7eZux6waRkHtpwLjs1kHeoGGbKrbByQm0+M0dx9xQ7i7e8sFeSgXLuwCKndVK/3T2ryxtLwT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:32:02 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:32:01 +0000
Message-ID: <04440164-8566-4ec0-98ce-c40f718a7575@amd.com>
Date: Thu, 26 Sep 2024 15:01:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/08] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <3fe2c80e-565f-448c-9b7c-9e69fe175ab8@gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <3fe2c80e-565f-448c-9b7c-9e69fe175ab8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9cf6fa-8ba2-4533-2f55-08dcde0e1345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NC9ZWUZFNHJZdFB1SGdSc3RnaWhGSkVrdnE1d1diMENCOGg4RHNTV0V3U3pn?=
 =?utf-8?B?OWNXM2pzRTJPRTBKOThhWXBqYUx5UEwrai9HaTZFSkltdDdUWkExQ1QxQWJF?=
 =?utf-8?B?OHFnbTBueE55aDZ6bVVrMzBIZUFSRW5uVlBycG8yQmtDc2RMODc4WTZnTE9N?=
 =?utf-8?B?aGZSdmw5UHRsNFdKQllYdnY0a2dsbEc2NWFFcXRYQ2hZZUNsWHI4bmlWMmkr?=
 =?utf-8?B?RTZLbkVOR1QyWHNhdFE0WTNmYkZWdGJ0SlRLWGdGMjFMN1p6ZURzZ2kwOUc5?=
 =?utf-8?B?bU5QaG9sbmFOTTFFRnl3RGpDcTFLTEFiTk1pTjR0b1l0S1dSbzlNVldVN2VV?=
 =?utf-8?B?a0VqbTBXWHpUNmFuY3JGeHc0NzhVRjArbGVvREdVVkVyMFhqdTJOVHZ4MUhn?=
 =?utf-8?B?NVhCcHZJUDJLNi96OWkzQURrL0EvY3M1ZHBTTU10bjBTbTJFVi85clpwQWUy?=
 =?utf-8?B?aWEwSzgvTUZmSTJDMzF4Z0xFSmtWdWVuakFYVSttN2UvZlVzZStMNjdwNFV3?=
 =?utf-8?B?K2FoQlRZV0VaMkJaSkd0OHJCU1Y4d2Y1QXJDRmNscnNVK0k4Y2l3bEc2QVkx?=
 =?utf-8?B?L3VTSWdaOTFwc29QUGJUVm5GWis4Y0p4SzRkUjN3NFlCMmo5UHBlT09oTkRt?=
 =?utf-8?B?MEZsZm82dGc0SldLMUgzUVRzSW9QZHpPQzJ2V3pWMjJZMlh5dGVabEZGQkFy?=
 =?utf-8?B?VWxxVGZ6QURxeTJrb2UzbDI5TW9WWWM4dUR6T01KTU1ieExVR2lEd1FMQko4?=
 =?utf-8?B?MXZlMHZ3bldRUHRVNEJUVG50OFVpcG11TmRURlQ2UnljS2I1RHJQZGF5ZGpT?=
 =?utf-8?B?dUpWMlArSlMwNGZFNkFGUko0SzF5RjBhbDA5cGxGK1ZxY0FzZEpTa3ZzWTJR?=
 =?utf-8?B?K3JGZ3F6SERyZnBJa0V4V0g1WW5pZGorWFpsbXNpMlRzbEQ1TDZ1VVJvTUQ4?=
 =?utf-8?B?bDQ1SHpjWjFJZGdZa0RsSDU1dTYzWS9BMmlmZEQxUXhnTUZMSkhhZ3NwVFRV?=
 =?utf-8?B?NFowZGVUSEw5WXN0SFdSYXlaSUtLYnN3UnRCaE0zbGY4WkRmc2JPTGR6bzM0?=
 =?utf-8?B?a1hJQnZRN1dldVRLV2liR0ZRcnhyYU5YSWQ2Y3VHNk8wN3BCTVY5Q0pkaGNX?=
 =?utf-8?B?ckpvYi9IV3hoazVJeEdyZU9rRmU1bHdJZlRLVWdFOTg3ZllKdE1rT2tFMzMy?=
 =?utf-8?B?Y3dQaWVOOTVuZkpDRzRxWWhHZGJCUHNsR2ZlNFplVlNGRzEyWVZUTDFieWNM?=
 =?utf-8?B?QTk4N2RSR2RaVU9NbGFEWGdLYXZEUWRiNHphRjNzb1h3WUJOR3NOU1RGZ2xP?=
 =?utf-8?B?MnEyYVZhWWwvUHlObmo3R1JKbHRKZ1l3cjdHUEdab0k1aUsyNTFNUi8rWmIv?=
 =?utf-8?B?V3d1dk1rRXZ2ZlFCWlNJZHZxQzlaMGZkLzlFOXg4dFV2SHlUMEJaR1NrK0Mw?=
 =?utf-8?B?T3h4Wjd1ZW9sK0QyVnhCbHV3RWhHTyt6Qk91Rk1aRS81QktENTJ5VWd5YzJv?=
 =?utf-8?B?N0FvMDVJaVphRTVsenA2bEw0T1VTbmhHZE4xS0t3L29XRkxvTzAvbFhrWWNa?=
 =?utf-8?B?Y0Z3emNSZ1krd25ldFpDR1BSUW1NYXI5NUlIZVpYSFVqZzVUOW9Cd0tFcC9y?=
 =?utf-8?B?eHhMVzZWaXFPSEZ2anVNRjNrZHZDL1hXdlBicGF2cUFteHZqa3JTTHkyN3Nn?=
 =?utf-8?B?STN6WTVhMTQvV0JheG9lM2duU3RKNUlzdHl4WkNQUWxWYjZBTnpLNTlHNHEw?=
 =?utf-8?B?TWFRNVpXelVRV2hqTHZXZEdWUVk5Yk5mdktTZFdoL1NUNjZ2bk5XdDJzSmFp?=
 =?utf-8?B?bnhyOGVtcDVYVG5Qend5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFkMGN4MlJwZmRGT1h1STREeWxUMThBbFFwVkJLdFdXN01NbWJYam9lcUpP?=
 =?utf-8?B?OFR1bkJWdUg3ZFpPV2hKa29NN3JlY00rdzBRVCtQczdQQ2x4VHE4VGxuay9l?=
 =?utf-8?B?Qzc5ZmwrV3pxSnVoc296dmlROERHYm9QS1dKTnYrUGlzQVg1QXp3VFo1eTFU?=
 =?utf-8?B?bjkwVWYrbDFlb0xxVmhXd0VSdStrUmFyTkoxSjVTc0t4bnQwenlKUUM2TDJy?=
 =?utf-8?B?ZkVkU0Q4aHhDWGo4Sm9XeHROaXJSVEU3R25xeTJRSnp6QkVmdDNxZXZralRC?=
 =?utf-8?B?dk10aU5TbEQxeGNnUDVwVUJFTTBSMmlPMjg2b1hiNXRJZ1dOVEwzRmVKNWla?=
 =?utf-8?B?UVhic1VTbEI5U25mWjE1RG5TWnQxOG9Lc1I4OFgwSkg3bm9GQnliL1NUblpn?=
 =?utf-8?B?VGZHUU9pODUvTE12RDVoMzM4bG80dDVyVHZXMVhxOWtVcEkzTVZFd1RXMldR?=
 =?utf-8?B?YWdZTUExaHlKeTcvanNXSjM3Z2p4SjlDRVVMWEV1dEJNTWt1WG1xaXppc0Q1?=
 =?utf-8?B?ZVo4NE9QTm9BVVpwVVE4a1c1U3ltL0haQTZLaG1uTG42WTdPS3AvWHMwQjZT?=
 =?utf-8?B?RU9aenV6M0xLV281Nm5zNE5ZdnFDT2hKZWZ1RUpubE9hR3p4R3MzWGw4Rkxn?=
 =?utf-8?B?dEFtbUh6SThBaVg1eVQ2NHZWZkU1KzkyWWQ2ZUVYbUdmeHhhcE1YdUp6MnRV?=
 =?utf-8?B?U3p4MFhIU284NGVNRU5kbjNxUkdvREJXZFNRdnhYV3F5UVlFVHZ1a244dVlB?=
 =?utf-8?B?WGwxSitqeEpYMk05N2tYMkRaRUZhU1kwSk9NZXNpSEowL3NoZkxXWEx0dVNE?=
 =?utf-8?B?S3p6QWpXUGZOazVCYXVMTWtmUWNkU05uenlmc0pmQW5seUh4bXZtY0ZROWdZ?=
 =?utf-8?B?M0ljY3BMSVMxdXpGSVJDdkhFaXpQMVNxeUZ5RTZxNlRtWHRlN05scXdpYTVa?=
 =?utf-8?B?Y2JTOTc2VE9NdDRIVlhUVlNrWm9LcU1seTdBUXE5cG9PMDMvS1NuTkM2UEdo?=
 =?utf-8?B?Wjh2Wk9mL0pGWUtMYmNpaUttb0M4b0xFRGhVbHdFazJ2SXJwVzduN29Ba3pl?=
 =?utf-8?B?d3plWGd6ZU9JUTV2aWxiTUIvVlJaQVliNE53TEhwMEozeVFUSC9ITWF6ODQy?=
 =?utf-8?B?OWFBc1d6YXd2bHVxTzZZNW1yRWpscDE3SDFaOHhieEowdHRoYXBBdGFuLzBa?=
 =?utf-8?B?VThPMGtqTWUwMDVXQVJqOHpuTFJCSWtGQjlob1pCTEVyODFETnkySThIMGx2?=
 =?utf-8?B?N1VMOUhOam5pbytBMExXUFNMdXBtMHhUazRlV205NFUxNi9YZTl3bXlnT1hF?=
 =?utf-8?B?dXVPT1BhaEZQYzc5d0RSRXRraFJGVWt6bngxbFVMMk1VZU11TzdERzd5cDVm?=
 =?utf-8?B?aGREaWN1V3d2K1NZY3FheFdsQWdpNHdJSlZxc2NNbmpsRjhnVUdpZm5Fb2cy?=
 =?utf-8?B?SFdWZWlGSWswdUp4QVpQdGNIZVR0YkpWa3NtLzN5NTVMWG1oeTMwcitGc1My?=
 =?utf-8?B?NEplM0Q0d25JUm5ZQmltWDM3VFZaVzJBM0RBeEZFMUZCazdhRElEcEc0NVly?=
 =?utf-8?B?QUZNays4c0tTeDZzTjNFTitGZVhRMFU2bUwxaWNwVlJ1b2VOYXBiRjBDMmEz?=
 =?utf-8?B?RVpxZENrU2psVmVtd3k2NFU4RE9Xb3ZyQk51MUUxNlVybUc0Ym9wbjVZV0kv?=
 =?utf-8?B?Yzh5ZzlKcTEzSUtTOG5zQXB4Q1l3V3dsVnhVNk1iNm1NVG5Wd0ZlUG5ucElM?=
 =?utf-8?B?c2FUeUFFVXdjQmI1Yk1mUlJYN3ZUN1F0MVZSWDJxMHpsKzZvYld1V2hpS1JO?=
 =?utf-8?B?TXBoQmFPc0oyYlFFaEJoZmczVWYrdjNKRXpZTEh0eFhYZ1hSMW5SaGQrSjZj?=
 =?utf-8?B?Ly8ycVlsQzgzWk5PN2xubDJWMFpybUFpNTBIblU1TUpObHEzSllrWXRLV3d3?=
 =?utf-8?B?QzhNZzRJVkM1MVNiMC9MZE56TGgvL3JkTE9ETG5SSTBmWXN5SkJyWGhUSUZh?=
 =?utf-8?B?ZmYzeUl1VFlXNkN1YzVldUtZUkx1Z3JRc0lUL0lvOU0reWJRUi9EKy9iOGFX?=
 =?utf-8?B?cEdLQ2tGSHIzU2FvZXlFeUJRelNiMXF3STZOUTlWMWsxOHgwdTRTWFFra20v?=
 =?utf-8?Q?QO6EKo17L+bYUgMEzYKEHkfXC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9cf6fa-8ba2-4533-2f55-08dcde0e1345
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:32:01.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0oBc2Zl6VG4j0SEKzSGlXaP1VeRTF1dpbjnXv/HKyefMeWA0Cd1U718W9pxNSvfEAwboIo3aVdNLongFy1LvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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

Hi Christian,

On 9/26/2024 2:57 PM, Christian König wrote:
> Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
>> [SNIP]
>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> +                struct drm_file *filp)
>> +{
>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>> +    struct drm_amdgpu_userq_wait *wait_info = data;
>> +    u32 *syncobj_handles, *bo_handles;
>> +    struct dma_fence **fences = NULL;
>> +    u32 num_syncobj, num_bo_handles;
>> +    struct drm_gem_object **gobj;
>> +    struct drm_exec exec;
>> +    int r, i, entry, cnt;
>> +    u64 num_fences = 0;
>> +
>> +    num_bo_handles = wait_info->num_bo_handles;
>> +    bo_handles = 
>> memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
>> +                 sizeof(u32) * num_bo_handles);
>> +    if (IS_ERR(bo_handles))
>> +        return PTR_ERR(bo_handles);
>> +
>> +    num_syncobj = wait_info->num_syncobj_handles;
>> +    syncobj_handles = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>> +                      sizeof(u32) * num_syncobj);
>> +    if (IS_ERR(syncobj_handles)) {
>> +        r = PTR_ERR(syncobj_handles);
>> +        goto free_bo_handles;
>> +    }
>> +
>> +    /* Array of GEM object handles */
>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> +    if (!gobj) {
>> +        r = -ENOMEM;
>> +        goto free_syncobj_handles;
>> +    }
>> +
>> +    for (entry = 0; entry < num_bo_handles; entry++) {
>> +        gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
>> +        if (!gobj[entry]) {
>> +            r = -ENOENT;
>> +            goto put_gobj;
>> +        }
>> +    }
>> +
>> +    drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (r) {
>> +            drm_exec_fini(&exec);
>> +            goto put_gobj;
>> +        }
>> +    }
>> +
>> +    if (!wait_info->num_fences) {
>> +        /* Count syncobj's fence */
>> +        for (i = 0; i < num_syncobj; i++) {
>> +            struct dma_fence *fence;
>> +
>> +            r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>> +                           0, 0, &fence);
>> +            dma_fence_put(fence);
>> +
>> +            if (r || !fence)
>> +                continue;
>> +
>> +            num_fences++;
>> +        }
>> +
>> +        /* Count GEM objects fence */
>> +        for (i = 0; i < num_bo_handles; i++) {
>> +            struct dma_resv_iter resv_cursor;
>> +            struct dma_fence *fence;
>> +
>> +            dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>> + dma_resv_usage_rw(wait_info->bo_wait_flags &
>> +                        AMDGPU_USERQ_BO_WRITE), fence)
>> +                num_fences++;
>
> We should probably adjust the UAPI here once more.
>
> The problem is that we only provide the AMDGPU_USERQ_BO_WRITE for the 
> whole IOCTL instead of per BO.
>
> So the best approach would probably be to drop the 
> AMDGPU_USERQ_BO_WRITE flag and split up the array of BOs into readers 
> and writers.
>
> Can you work on that Arun? Shouldn't be more than a bit typing exercise.
Sure, I will modify and send the next version of this file.

Thanks,
Arun.
>
> Thanks,
> Christian.
>

