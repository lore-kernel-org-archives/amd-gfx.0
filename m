Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FDEEE0219
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 08:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF1110E6FB;
	Wed, 11 Sep 2024 08:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Ru4ka9V";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D52510E366
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 08:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF2y3BTDa9lEiVV6l5oIaX15SK1tiJ9WVHjq5rOX/piJg/pkvVnM++6QU4FkLtuFktq7q4OB63iThR7rh+mMfseJ9/jPw2Ldpk7sYCWzHa4HrPShAtoxNHNwvMIBycETz8ZIRBgetprtfflSe7p6UU2/TQ4hm1ol50QAATB21tsdkZzY0WESoq8xKi6cLhzZfRObAK2OUbzO3CM/B3m5h//nZEfrl/0mB2bnzGGwX2SSETiAommQofHfMF873XqVDkwWHcc/kraqMiwQSet3TB5laet75qc9LBe7zUZG+Hw/XuhWTFIAmCRZAYppdp03LW/H8m8Iv+bkjKVVte8PYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxqs4N9PVTR8j61TJvhZrIgOOGYwwH+OZXVEFEpYr0s=;
 b=FOxcbBHnYcKCMRhv8LrjoE5L21UlkiMkxecY8OWv4S7GHXMUrC8IM2RGPV10prHdMWJssMUWkUjpkGZXftDHDtip/r97902rXOA5XMaDNmEIY1djPxD1A441+eUQ1rocaa7hLvTZsn3FVvEne4tGFfhGc5h82Hy3AiacjJZHu87mpguLtE4v3gmLibx8liMQF/6MU2hXJOqaTbx1wZNy6PQ+g3pIasqPyQxu4zxpRm1cPzUBnmJxugJc4vTyCJG8yRaC22OlU3iB66sESD+HyKIcOh2faDY2sNSUS3DGd5wHzUeuk/NO+kL+XakgoK3rKo5Z8llT42YBr9Ixs5cszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxqs4N9PVTR8j61TJvhZrIgOOGYwwH+OZXVEFEpYr0s=;
 b=4Ru4ka9VL8s2SVtdVhvKvEsQmBLQMoj0PuFJokur2akSAxU1/J8Phg6mxKhiWpXkJpk67fxD/h0+mCKXa9RwXgzyXJej1QMr30js8ydQ/A3jYqLgA4SAFJy1MzdFUBDS1689N/rbegAdvK17q4YU/YW8zbCGh9kGZOAptuakYe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 08:38:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 08:38:26 +0000
Message-ID: <6669b170-e9ec-4faf-8704-38f26852312a@amd.com>
Date: Wed, 11 Sep 2024 10:38:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: screen freeze and userq driver crash
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <20240830184322.1238767-3-Arunpravin.PaneerSelvam@amd.com>
 <d79341ab-84f0-4d5c-914a-ff27f4097078@amd.com>
 <cbf97cdb-3a96-476c-b044-0bad0d8273ad@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cbf97cdb-3a96-476c-b044-0bad0d8273ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: b97f6c85-c046-4be6-53b9-08dcd23d1aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFlwUHgzeUh1QUppc3J3SUcrT2RQK3RvR2pXTmlDeXgzNzVlcWhBUVQrNmhC?=
 =?utf-8?B?OEU3eUNxYjBlVjk0QlZMZ3VLdGwvNi9RcC9aMy9zZXJhOTZUMXk1a1BUMnpo?=
 =?utf-8?B?VkVkZUtxR0FXclV0bzc3aUcyRkdPcXJ6Tk9XSGpTYTNjSUtwdG1oWlZ0ZlF3?=
 =?utf-8?B?cHJxdE8rMXNabndlL0kreDAzeWpHdlhDNDBIdjNoQnB3cGtEcWVCTnd4N1dT?=
 =?utf-8?B?c3FOSTJZdUkvdmFzc2FqK0lJdmt5YUc4U3RXZUh6RlpNRXdLM1k4Wk1tR0RB?=
 =?utf-8?B?WkNuSnlneTh4M2FQQmZuUFduQ0FlK0JzeFJrc0dsOElBWnozSUtOMDVobzBk?=
 =?utf-8?B?WkxKcG91QlhRMFhZQ0xuNU9Xc0dxWjB3SDlJOUVWa1RnSzE3aE1RVWY0U0FY?=
 =?utf-8?B?Zi9LdHJRTVBITk1KanV2TVBKTXNWajZ3dDFYQzdOSEtLUXhvN2owZ2Rwa0Vh?=
 =?utf-8?B?amo4ZEJtU0RyV0ZwelBmK3dPQnVQREh4SVYrYlJOekpiUGlVbHBHYzJlbkJN?=
 =?utf-8?B?eW1xeDZNS3FXSkV6SXlmb3l6YjRvczFLV2orV0dHSm94ZUFzR2w4RE4xYjZD?=
 =?utf-8?B?SSszT0NzVmVnSzcxQW9wQ0tVbjNpZlp6MkFhbDlQMUtNcDVuRllPcFVMd1Bx?=
 =?utf-8?B?OTF5UW16U3g5ZTZFSG1jdW81U0hjR0VlaHUwbUZ4WEZnRDB5RUM4NVg2VnUw?=
 =?utf-8?B?WGV4RDMvVk5YQmM1NmJ0amxyaTIrU2dMTE9yajlxV1p4czNnZTcrU1BudGkw?=
 =?utf-8?B?djNrR0pGTGlXWUJvMmpPSXgyMGR6dEZQd3VtRDB0LzQ0L3VZbkUxRG8xelJo?=
 =?utf-8?B?c2pEUVZXNnpSaHl4T1lFQXJnaWtiUHNlbllUbWw5TFR6N2FEN1d3b2ZZb1lY?=
 =?utf-8?B?MGZrcXdWa2Rmd0QwalUyU0c5eWErd2ZjOFpTd1hncnNzd3diRWE4VldkWTA2?=
 =?utf-8?B?OXpRelVjaDY3ZytKVkRweXhXcWdsdlRmOWRzcER4YURTTzU2M29rd0NNcVJp?=
 =?utf-8?B?MFBGZGZxMjZuS1JtZ0JlbS9rVVF2OUJGWWlrdVFOS2hHdVVQOEFFdGlyQ2Fs?=
 =?utf-8?B?aE5hU2cydVZlZXJpTXR2WjhUZ09TajVRS0U2TEluQkdGcDRGSjdBRkU3TXcz?=
 =?utf-8?B?YjVibllscTdFV1UvMklFUjNoVVZsYy9yMk1QYlExK1FMcjJxSG9nZ1ppNSt1?=
 =?utf-8?B?OUptM2lpRjVqRFJldlBOQnhUaTNqbTdVYWhXZ3M1bkZ6QUVFcEczckVjKzZh?=
 =?utf-8?B?MUZOWUdMN0FwUzlUTENLT053WGdMdGdyNzJJTklkVlF1NU5iVkhnbjRORVVB?=
 =?utf-8?B?cld3WnU3eUFRbWFWSzJJUC9JM09iZzRGVVVFTkZJc0MyUlM0eVgrbGlOTWVT?=
 =?utf-8?B?K0k1eWVOMzFiSEp6SDUxV1AycGd1cXVXMk10YTFyem1sN29TcHpRT24zV1B5?=
 =?utf-8?B?djM0U1NUcGtZWWFKemxPd0dLbjJpZ1I2L0NsM2NwZm82dHU3V1ZhcDhoQ3Bw?=
 =?utf-8?B?bDdwbmJSdW1weGN6K0R1NEJDcUJLVEZtT3JwVmJPWEQya0RSeWo0dkpBNDZJ?=
 =?utf-8?B?bGZ4M3JJcHpXb1o1Mnh0ZHBKL0FOenM3NmhBbU8wNUhWbVM4eW4yUjMwd2VS?=
 =?utf-8?B?UGxqRDd2elJQRDlNUmJiTUsrVmJoUnVSSGw3bHpkTDUrY2EvUWhUQ051N2Y0?=
 =?utf-8?B?VzFLK1NXMDFqZHM2THcvWkFzR2V2bkt6MXU4SjJ1aTcwQTViYzVrQTNsK3FP?=
 =?utf-8?B?WXBSSTVSV3NySk4vdzJlSlNXNThESXJlZmVteHlEVHJqZFFUWEZzeUdydnJ3?=
 =?utf-8?B?UEVZUFFxY2pINXhpMjJ4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVR3cGJzOHBnRkRZbzhBb0F0ZnpGM1NnVGU2WEphTXhRL2NPVlNiZE5qazRM?=
 =?utf-8?B?SlZycTR6cjBQZFVYQTV3R09FdzAvWDlJdVptL0lXdzF5eFFBbW42VFB0TnY2?=
 =?utf-8?B?aFZrMVBVQkRyR2Zna2xaY2JSVXo5TTdxZ2ZSTU00ekRjbFVNVXY3Y3VSd0xn?=
 =?utf-8?B?c2xlcE00L2dCNDd1aVcwbzlST0JNbWYva0hMNXVrMmtvZGgwWjBQODF5QlN0?=
 =?utf-8?B?MmNTWHdyWHF4Z1hmZStrQ3JTUXcyaFQvbkthSXU3L0w0VnZoWkloQUFpb0hn?=
 =?utf-8?B?bWt0UjVNOUdKdmJjRUFPbzRXMXBmQ0RXRkxiYmkyTEo5b1Uyd2FJOWZPZC9D?=
 =?utf-8?B?TTJoZFhYUWNjb2owMzlrLzlXaXB4ZEd3cG55WG9FNThiOXZESU1FZXF4b1BX?=
 =?utf-8?B?d1E1K1l0ZmdtZHhaQ3pyT0pZYjJqOGYyY3Z0SVdSWEhkdm5qM1hHWXQyZFNn?=
 =?utf-8?B?VjJ1ZnJxYW1DY2JkWEsrN24vQ091TzJPOVVhc25ubkxmelRTdlRMQXZLbkoy?=
 =?utf-8?B?N2NsR05oam5jeFo1MlM4WWlzeERMZ2xRVFBZME5MbDBBR0lRcW9iMC9LM3B1?=
 =?utf-8?B?MmdISmdUeHJrekhTb3NOZHEraFk0dEpmeC9Wb25HT3lIcDdwTExNeGMrY3FN?=
 =?utf-8?B?S0ViZXdESDNpTyt4TVdvTGZCaHNiMXF1bUtIUWN4dWZreDd1NkdyamFiNHFk?=
 =?utf-8?B?My80dmo1Qy9rS2c5UUFValdkaW4xQ2tOVFFKWWRwelVTOGJwMVI2M3NsMWF6?=
 =?utf-8?B?WUNhWFhpMU9uRHNMOEs0cU5oUUZCSDErYTZubHJjb055KzA0MUE2dVVBWXhk?=
 =?utf-8?B?clhHSmFlUVhKSWFRYlRWMmJtODdJRVh3bktaVytFcXhCWVZpK2Q4Q1J2Yy93?=
 =?utf-8?B?N3RDWlRrcUJFd2Z4Q1BYaGNpdmJ2c2h3ODJUVS92QTNGdElubm5Qb3hYemdJ?=
 =?utf-8?B?cTMyK1JiUjZsRkhveWxxdGk3N2V0Szg2K3E5bWNSdmVFSjJzSWRQVDNZeGZM?=
 =?utf-8?B?Z2k3WllqSk04NXNIQ3lRbTJBRk56SkFkdWRjaHlZc3FwVEwrd3ZtbUh5akpC?=
 =?utf-8?B?dzVMZW0zZGxPQWJEWElZbmlnYmE3WEZGUDlPUm84czV1TEtyTjV4aEMwOStT?=
 =?utf-8?B?ZW0vVjN1b1NyWFFlcGEvY2F3WEhrUHA1K2ZsN0U1NVB5UUZFcDl2eUl6OXVs?=
 =?utf-8?B?K2NveHBUZUlYUytSNXpCYjhZRWt1UCs3ZzJCb3BsbVJJbVNLbjFoREE5aGd3?=
 =?utf-8?B?TGplWmxDQWZvUlp3TG5TMGxlenFyM1lRc3dTU2Q1ejhBNmYxTGJPS0hHZGRD?=
 =?utf-8?B?N1Y4c3VaWlhLdjBpTHNkVlJncVJONER4a0VkNGZtV2pJS0FiTnhoRUF0bzZy?=
 =?utf-8?B?OTBPakxqSlhQMW91SEY2ejRrcVRtaWtIK1crUlNjeTg2UW9XT3ZLM0xNMGl5?=
 =?utf-8?B?MmF3NWhsais2MHJ2eGQrSDJ1aFRBMm1MWUZOOUo1dHBQMHVicUxvWXFuNkFz?=
 =?utf-8?B?Q3NVcUY1K2dTN1V2VjZvenZCOThTbzN6TmtQelNUYjMrVDN3M3NvdkFvUXcz?=
 =?utf-8?B?NlYvMCszSm9CVjNBdjBGZmpiWWI1SUY1T0FNdXVyOXUwYkpWSC9BQ0oxc21K?=
 =?utf-8?B?SElzcVdvWVQvS1BoVjNDclFyUFFMa0dZOWZNQzUxSnFCVjU4V1RUZTV0bEx2?=
 =?utf-8?B?RHhmMWhrMjlBL1ZJNTdPdSs2T1ZvT3BYbUQzdDR4NXdKeFJtNUY3V1NyQTdQ?=
 =?utf-8?B?RjJwMTdueXRKcnlPdXg2YVlVeUhvVml0YURYTG0xSUc1MmY3ZGZrYzFnYlNl?=
 =?utf-8?B?dVQ1TURvbTU3eEdUaTRBZjFsdFRvN25KdXBkWWRWaUNqdUlIL2wwVkJYVGlt?=
 =?utf-8?B?dzRwK2lTQm0yYUREZElSeWNLWHN5alJaYkx6aHpBMjdXR1FjRG1TUkZqcHRu?=
 =?utf-8?B?QW9MRDQwcHRhRjhCbGt2VlFwRkk3TXp0d3JQOG14U3NZN29Vd3BhL0h1T0ZP?=
 =?utf-8?B?eWNYdEZwVWxPTFFMcW9PRkNJbUsrWTFZb2x2ODRNUE16OXY1YjF6WVhyWW1O?=
 =?utf-8?B?Rk9zNU1yN0tBbXIyMXhreU9pQ2hvOTRURmRwaS95S1VqNXUvazRieEx3dDhO?=
 =?utf-8?Q?24RiXAowiDwfk59QF4Mb6gh9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f6c85-c046-4be6-53b9-08dcd23d1aa7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:38:26.3234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEdRSBpTqx+FwpLuJm4y3/5ycOy4YMTQdH88diK2+915gpG/sebw+fAWMQ2to4ZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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

Am 11.09.24 um 07:00 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
> On 9/5/2024 4:50 PM, Christian König wrote:
>> Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
>>> Screen freeze and userq fence driver crash while playing Xonotic
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index d2e1d0d0f29f..8a3b5374cc1a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -187,6 +187,7 @@ int amdgpu_userq_fence_create(struct 
>>> amdgpu_usermode_queue *userq,
>>>       struct amdgpu_userq_fence_driver *fence_drv;
>>>       struct amdgpu_userq_fence *userq_fence;
>>>       struct dma_fence *fence;
>>> +    unsigned long flags;
>>>         fence_drv = userq->fence_drv;
>>>       if (!fence_drv)
>>> @@ -230,14 +231,15 @@ int amdgpu_userq_fence_create(struct 
>>> amdgpu_usermode_queue *userq,
>>>           }
>>>       }
>>>   -    spin_lock(&fence_drv->fence_list_lock);
>>>       /* Check if hardware has already processed the job */
>>> -    if (!dma_fence_is_signaled(fence))
>>> +    if (!dma_fence_is_signaled(fence)) {
>>> +        spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>>
>> As far as I can see that still won't work correctly since you can't 
>> guarantee that the fence doesn't signal in between testing and 
>> grabbing the lock.
> Can I move the spin lock little up before the if .. else check.

Maybe, I need to see the full code to judge.

But keep in mind that you need to use dma_fence_is_signaled_locked() then.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Christian.
>>
>>
>>
>>> list_add_tail(&userq_fence->link, &fence_drv->fences);
>>> -    else
>>> -        dma_fence_put(fence);
>>>   -    spin_unlock(&fence_drv->fence_list_lock);
>>> + spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>> +    } else {
>>> +        dma_fence_put(fence);
>>> +    }
>>>         *f = fence;
>>
>

