Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF79C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 20:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 398926E51A;
	Wed, 24 Nov 2021 20:20:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874086E51A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 20:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkfsGb5VaRx4DMAKPg/XCnghIgni9ilfVTk8/ZDWUenVIeS9PJ4SFAFgjZe/LBy42JR8PffwNaHWcdcyZnU3AvsmAfI25WzxKHDjlacKIsSVypw21rSRQu1I6dx3NmmP71AgtDUURLkKcv4mYBPPfVcyQzdEXS9EV/tRQ2Ta9QTWMVXBQ/ys5v5zCxplpAqn5q4dGYLanKBXMK2gx5Ptq8KcfEWnXxi/yJHfzr8OnQ5W3IaI+LgjhtV8XXX40iif47ZsRWehvR7VQnbbeEH9Kmd1yiNuFEyIn7MK/vq3Fpp9Q0U9LhPIuIVIpGZ3NLGHKmSKYsC5skxmW1gib8rxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoDPxutUbeJ+S2UEpci8H3nJ6CCyheHX8ZoeGlxHZhc=;
 b=VV0jG0WRg6HWEYDdn31YCwESvsmmowbzS6+t0O/9OVgUPmy7qnQwj69SutCp2rBlfijzy5mNeLhIMyMz2uUuFrzGqP9I8B+tp79LQgkkVyV0SbOPIp88zh/mOGpbKp8XPhxMynJGCZvvDedr6bhZJ6ue/ftwC4MCroWIN3kGjzJvHmmzM0TPmiNabRiK/NEetWCYIkRTGaromaIM5RLWj+3y44pT28Crs5lgW1V/Jyw5jrOp/8LoK1XXdt4xCGO/PYLpUIBmoQPOrkf6D/Yui012mjfMD4Oas3etPa+BztWgBHE/WiSUlrx5TQyS9FIPePL44tlQ69eNif55tlgd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoDPxutUbeJ+S2UEpci8H3nJ6CCyheHX8ZoeGlxHZhc=;
 b=SnLaP3/o9vQPq+7r0BZuWij4ukx5XC3YLf+fyR9ADe4bTjVyAD0E/JevkiS8rz+kx2BFZfaRs9C1NEYE75ZKBWBOQ7EFjD0Q5YLbjKs+V++VcZewg6b0W1qCh0ZlekfiB6KvjoSSDmbki5+n4lR1Wk048/gAeQeUM3BamWAf2E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 20:20:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 20:20:47 +0000
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: philip yang <yangp@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
 <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1d31f11a-9ba5-4973-5875-11ef6e1bcf89@amd.com>
Date: Wed, 24 Nov 2021 15:20:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 20:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 265b6ef1-9225-4af7-6d4d-08d9af87e657
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5177BA9913EF50CD46A6ED3292619@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4OcTBYkyfvuaue5JwojBDQH6Eff6BX6PrFsFH0Xs6DFybsvuFf6YwFJbm+9PpeFDhNomuIqOVvNZtL6Tk5OjQbCeHyTrMH0pdAxV+/FiOMgdXLefRWOvkSPVluPjeZUd5IlpVPqdDW8j9VRLnMhebp6jFajO/nH6V0cl582Rqmbjdw+owkZPBJy15qav90BNHZYHVWdGIkDV44rsiRjuky5DCFnhA7DTNhcw0/Oc4nrxzQVPOgNd0voAI/TYW9pbLSvExBkT1zKpGug24ZA0Jo65Pg+J0rlDEFMOw+Xgmwn2bHfuRP2ZYrmPTkaygHkaNfm4L53Be26DE/YSmZWIUznDk5kV2AMOO3EDqpO04OY+W5zAY9eznG8UPfWygTX7pbjPxhWfHyspL+G4hs1RzCabbdTBhv+NdMHD5YOtGc+lhZxpxNDiVU+5HDG4y/N9uKaaNANgll16q9ZaAbOFT0pLHl9hx1z//f2FCCrNE6IuVtH1oXLEno5wClMOjoMB1Utvlv3mhxjTs7OqHeQtLSBWWvwKTp3EjfWlkkliyuImpD+QWjpUZkmEL2b0ao0/ExEYb2yhF1PO3naCE0d8J+wtJaoht5kjlbsuQN3YvtKyIqkJfIEpW3Mk/MlvjR1y444qWLlI/ZvQZa3PWrtziER4EacB2Y88cC05bcaFsTMNYQGzgBHz0waIAGiNI6rH1aqkSu5qk72pP56/SQ5l2QqSbgavFrXRx92iJXSwl4my5f5EIcIfgZGDlnPy2sQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(2616005)(4326008)(38100700002)(186003)(66476007)(5660300002)(86362001)(6486002)(4744005)(31686004)(956004)(8936002)(44832011)(16576012)(316002)(508600001)(83380400001)(31696002)(8676002)(66946007)(36756003)(66556008)(2906002)(26005)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlTM2lFdEFySjB3cTREdWZVSGw5S1pBNFcvYk1EZ2tWMUg2MTF2Q2dGS3Vm?=
 =?utf-8?B?dk9wVDA3ZmJ4NDB1MGhHTnJKam5tSFFlVyt3UjFLMHFKeTgxRGFuYXV4aFB4?=
 =?utf-8?B?UnJnYzJ1eUtROWsrOHE5eGNzWjZFV0paRjVtdHNWTzJGZ2YzTHpWZVpHN25l?=
 =?utf-8?B?N1FWNzVhZlA4Y1QxRlJ3dHN0cTBHNnk3aUpWclVtcEQ1eVVtNWltTGkzQnlu?=
 =?utf-8?B?Q295QzRNRlhoSWxOaTQrcEtKb0Jsck5RY00xRnlnREMwVEF4bFVIY0hLVGYr?=
 =?utf-8?B?NE0yNzUweFFSSkxwTG8rMWdVYTJ6Y2xrQUw4TlRjWVBMbHpjWGRxRzI4eXZt?=
 =?utf-8?B?UHFmWE4wSkQrckVMbnVIOURrRThwbFZ5R0R4b2t3WkdEaWpWQXgvbXZ6cmhz?=
 =?utf-8?B?cGhBOFVSaS9MeERBOTJrRHV4dkY2REJpczJTWnV6azhxZkd5dE9ZUVEvdytX?=
 =?utf-8?B?TEhVNUhYNG5tcXdBZkV1MjBZWWFBNks4Z1pubUc2QmJRU3E2ZUtZRWdVRUZ3?=
 =?utf-8?B?cUMrZlVBZnBxYmNKZ01ZUnpPbVEyTGx6VkxFVjNCV3V5OHB1T2xHOG5QeVMx?=
 =?utf-8?B?dC9ORmNSb3ZFa3p6TVNrb3pkTzZxeFVFNVBoL2gya0NCT1BiQ2Nwck9xRE9K?=
 =?utf-8?B?YmNXUVkyQldEZnB0aUVVNHpTdXc4eVZVdm9rQ2V3cTF4UTdhS01vbnZTRFJ3?=
 =?utf-8?B?dnRoUFNudEwwMGF3NWJGemV0VXMxRlpaajI3R3JCT1pTczNpVkhmVklQWGRN?=
 =?utf-8?B?dFp4TVVaN1NLeUQzVURxL0NCa2w4WFRZOGUrTUNkQlpvNHFjOWZQcWhmQ1JF?=
 =?utf-8?B?d1ViQ1h4U0xLQ1QwcmpkVnNaWFNDQ3F0WTJuV3VJR3FDdSt5SkR0aFJKSkVo?=
 =?utf-8?B?R3RMR0FzWFc1aC9HbjRJM0JCNittTWNYYWxDSFdiTjVkVVdJQ0gzWEpnTG1r?=
 =?utf-8?B?b0lrbTJsZTdxc2IzUkhvWlFVYmF1TDg4eS9kQlRzZERnV1FSbnZjWXZuR1RG?=
 =?utf-8?B?SXA5RGpUS3VWVU9MUUwxN3JXL0pGOFB3QjFvaFBCL2lmWnZxcTliU0Q2aWNn?=
 =?utf-8?B?Y1MrTWJsQUtQbUdGUndiK1h2UkhWN3NROXUwaHI0MThHV2RWSGxqcktBcVJn?=
 =?utf-8?B?MTBqK3Q3SGZ5WmNVem5uTnJzK1FRV1c1SXJ1UEhUejY5WjZOSFI4b0tZMjhF?=
 =?utf-8?B?NU9DdGlpOGpJV2QrQW5QcjhUc0lQR0V4dHUrdnN2WEViSDZOVXlmTklPUWNs?=
 =?utf-8?B?U0NaeXJTYzFkM1NqT1hxOGtHd21kRTFpT2dOK284NEFnMGR6ZDFEdHloRW1m?=
 =?utf-8?B?a1kzVmpPRk80RXovTGlLcjl1UytlOVJBcEs2UytHMjF5ZG5TY2JjcVpGczVR?=
 =?utf-8?B?R2pOVWRaWlpUdVZlWEY5SGxOeE14ZUhNTWpKVWpMK1BmazIweHN3eTdYY1FF?=
 =?utf-8?B?Y3dKU1I0Zk96aG5XSTBEYW0vQndOZkJYMGgyNURDVUFJZHFuSUlDL29PbVk3?=
 =?utf-8?B?N05ybWtFQmM2SUZMMXNyck0yMDd0L256NGdITWxldXIzSXZGVzhkdjRoUEZ3?=
 =?utf-8?B?R2YramRJTnpLb3grZ1BNUHpqTFVQRlBKVE9xWkJQdUo0K1lKd2JJVExNbkVR?=
 =?utf-8?B?MTJvejgrOUsxd2gxV0Q1RTF2RDk0bERRdHVxeWw0a3R4TnU1dWlNaUJteEVQ?=
 =?utf-8?B?OGxkT3pMRElWNkFMODRBQ1o2V2FRMG5keVdmbTNnQ2QrVGRpWmlBaUhXNEhF?=
 =?utf-8?B?ODlwUkdoZjExazVRTnI5elVVSVY0Z2Q5ZVV5d1haOXUzbFJLMW1XRit0TUpM?=
 =?utf-8?B?aU9ZNytpUGdROUhxMURFLzBFMXorTWxrbXlsNjV5bVk2a21WQ2RsWFdIWm04?=
 =?utf-8?B?bWpYVW9wNE8rcHNrMTRaRmdSbUNyeWQ2cHYvdEorT09mWGdxalZBdWJ4Vnd6?=
 =?utf-8?B?Z3Y0bFFDVS9yTGZQb0hNZ09XT3FRdXRueWxFNjRNRjBWYjk5NE93S2kzcUtZ?=
 =?utf-8?B?YWYrM1VHMFNJQ3YzOTljempET1RBcGxUWGpoTzdiNjhGeHNWYStzUGdrcDh0?=
 =?utf-8?B?eHpxcWsxeElGVWlLcTJEL005MExSZG1pK2FYRGt3NzFIWk1SOGFoVG1BRmJJ?=
 =?utf-8?B?RzVFaFlyayszU2YvMzZTbU5HTVBTdHJ5QzlOczkzZXZUYmh5ZVJEa1RsT3V4?=
 =?utf-8?Q?YhNOXVM3PA7KTe1BE6IF7Qs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265b6ef1-9225-4af7-6d4d-08d9af87e657
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 20:20:47.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Wuk2QBM8C91rMhsGZInmwEpOD8miMYZcOLNPailWr523jgoxojsRF7+Q5HnX+XA6nLnGRA5VsZkm7HtN5jF4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-11-24 um 10:23 a.m. schrieb philip yang:
>>>     #define amdgpu_ih_get_wptr(adev, ih)
>>> (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>>>   #define amdgpu_ih_decode_iv(adev, iv) \
>>>       (adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
>>> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
>>> +    (WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
>>
>> Please drop that WARN_ON_ONCE here.
>>
> Agree, will drop it.
>
I suggested this. We're assuming that this function will never be called
on hardware that doesn't support time stamps, and that all hardware with
time stamps will implement the decode_iv_ts function. But it's good to
get a log message if that assumption is ever broken, rather than just
silently getting wrong results.

Regards,
  Felix


> Regards,
>
> Philip
>
