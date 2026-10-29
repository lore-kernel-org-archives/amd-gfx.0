Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F83606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QAEo9mF6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6851310E739;
	Thu, 29 Oct 2026 03:13:29 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CF310E752
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 03:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtCWumsu4LVw5edslI/vIbaSkEpaGrM8zz9yAXcuQacZ76A5ezUyQRGqCnLhq8D0SBNRYliZUE/fKk9Myw+bV8wGcNiX1MHammYbg2QEjRAkxXUjbfrfKiB4WuCELO6x/D9PACmkrBAi18db3QydTm1IAYV6SI8rOXKR4pUSK20C4y0Hwe/sL6dl0t0Mno3JzH32ndXkjdGL8yO58Y2gaGKN6fpw5YNknJC781U50BUZtJ3/+Y9gww30QM1Tu51pABriyWQSHLOXmRFb8Ym2qXIYx1zHsoZUqo3o/APkd7amiOug02/BhDouoxb9frKBNWYOVSEC54Xdq043tr3w7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsT6Yed/giQg8ZzoYWzZyq/UG7+DsmWv/3RVGAjMkjs=;
 b=Pp9v9oZgQOzPvsN4nB4S8JRscO9/NhvTFIAM5kAE/d9itusXUSp9Ewn8CT+Z5PMVWtKNmn69py7Alw2b/OCZIxyEK1OrOxvj41dCK+aBwdnLawoKcT6n4EUMeYDifDxjUlIXF2RzfMgV8G2ySJQFAAE59rmOYND3LK5HCZP8lpSg01/e9TvRwaH7S8jgPS+uJxPX1YM7OgWFT8H18670p9FCHMbe9Z/OSrp5uBHFXTu4KFrtJs898Zlkbq4wVmlzD4dlDFOrRqxLVE0wrYyuzEXc/dlt8y3k9TRJgx99PM5nVG/AG+CCLvogSnIjvQ2i8aSTy1yOtx/itnointtHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsT6Yed/giQg8ZzoYWzZyq/UG7+DsmWv/3RVGAjMkjs=;
 b=QAEo9mF6HcfYUij60kNyNE2QLqSa1VErt0Lr2hqgh4HpjsMCuzpE6kT25QictYS1HsUwpqgJwa46xashyDi2y2/bUhtNUTwEWEN5TgByDJbY+dWPOCIgDZFjhhjtHrpxVT9Ilxtb624nqOFtHbBmHbFjYN6hbcfgccVxQujV7pc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) by
 DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.8; Thu, 29 Oct 2026 03:13:20 +0000
Received: from DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587]) by DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587%6]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 03:13:20 +0000
Content-Type: multipart/alternative;
 boundary="------------T1lpGNAzkSNKj0LOsKchjGaG"
Message-ID: <f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com>
Date: Thu, 29 Oct 2026 11:13:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: "Zhu, James" <James.Zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
 <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
 <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
 <c96bc906-c6aa-479b-84d6-75ec1816e853@amd.com>
 <DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com>
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DS7PR12MB9475.namprd12.prod.outlook.com
 (2603:10b6:8:251::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9475:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d0db78-46e7-4b8b-e37e-08df356a9585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|261021121427099003|261026140227099003|10067099003|261026121527099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: V0/fS9JT5IK0JtTI5dYvzep/jMemIT0T/RaDbxrI5CKL1Zah0iPjI7KydL5LJO0fip+dVKfxnWyfW2fuktGhXbfiKo90xvMeX58OMRHTdRYaQ0S7JFClO4m9ZdfG6WlJrvrBJvRDP8SdkCLQXu2MCKBuKHdHoYF/jnPSZAwYdCuUhUd42nmTbK8mSPS8zAZ5dSoXmW+lgHZXUgtPA0GxRc7wpSV4YLKqCThnWXCt3I5uUnDUxx5QyEZn8mIgUCguk6fvQ0xDKOt+Frcl5bSlMz981rj4hN/74/y2p6uwrZDwwvPjx0dcsZ66MmEInK3nQUlA+TZvwXnVwKYLPyXO8zJuzsLkFio6eN7qY9qa8OZAAOPtyI4FptvnwM9MQ7/ehkaXvaOp7Skj+weVxN4LFeIxMl/SVN4+O7SW9zXS/2vKe98XnfOgLQCNm8uw4YQCPfe3e/GlpdCOvMBd4/XlSxl8hqTx4GtnZm8n4zR/PJxDIMJMzqnKgD6Oc44mCUgc7k8EFBF5DPZfidA9pJacT7lidk7xQZ8nYUVlffsxZ560oskIfZtphd0KdpHBUwu1PfZAufrcXY1vcp8ejo/dT2kBnEC4ogXkAVtTZc+XljHbownr8ypRA3MurCRRRya4z2j4gWmJGkm1zqxNByH93iWK8Jb5CLhZzlq49mAPcAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9475.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1wRnIyNUg3eTUyb1dNK2RLNkR4eTJVSXBoeEZ1ZVlLczhOWThNbmlSZjU4?=
 =?utf-8?B?V2E5WUZKUlVKaHYrKzZCR0RseU04WTVtU2RrVGV2ejdqMTJnd0h6YWNBanhm?=
 =?utf-8?B?SlZ3QnppcDgxZjRKWGRnUFh6WUt5MVF4b0IxLy9LdTY4UkpMWHk3aVRSS2ZN?=
 =?utf-8?B?cU9wdi9mc0VnVFJTL0V1cEJjMDd6bFFWblRIODJPYW5aY0Zvbm5Qc2Nvb1Bm?=
 =?utf-8?B?blpuQW0zd0ZGNkFBazZHQk5Kd2xoekh1VWgvNHExWXRMRWVMTm55Q2NPcFk1?=
 =?utf-8?B?VUg3b0lJa0VQemxKMUkwcFNJaGtoUmZKVDJmOCtDN242bXEvOVg2WnFHUm01?=
 =?utf-8?B?VU5JejEvRWg4akRwUDh0QXEzK2RjNStabTBKQ29naU84M3NoN2o1WTdlWFkv?=
 =?utf-8?B?bElpUE9MS01NRVNVOGxtR2FlajhOYjJOMkFJV0MvRkJ2ajBoVEV6Z0R6aFQ0?=
 =?utf-8?B?SEN6OHJ3SjlhWEpLNTIzUEhuYkFjMUZMZ2NIOThOVjdoaTNlbGFKRm80TE9l?=
 =?utf-8?B?bDhvMXhHaVhFQ0RXNlV5aWdtOFp2a2d1MUUvSGVrT3VjMFpNc0pyb3R0S1B0?=
 =?utf-8?B?ZGx6UzNjTjhENEtlNjVQQUkxbVArNVlNSDVyLzFuWFkzUTE3bUxZdUVSTzRS?=
 =?utf-8?B?Y1hrNzVxYWkzQjJpL3ptc082SldKMFNHdG0rK0xpQUhvdzRXdjczUnA3WjVk?=
 =?utf-8?B?WkFmd2twYWtOeFRISHlGVzdhOEdNcy9ZL1BtRnRVQjZKZm5ydmJnL2prNXFN?=
 =?utf-8?B?WU85Q01tK1BEMEpCWlEwY2VCSmk2NTZYRW1tL1g5OUxnUFBWZEJTc1VmL1BO?=
 =?utf-8?B?RzZPQmN1SjI0aGNyZGRXQkxmbEc3R3VpZ2dtejhUbFphN3lWcTJDWFpUNzlK?=
 =?utf-8?B?aDF6NmxJcUY1eEZHNnE5a0xwUkF0SFRnN0UxQ0pHRERielUzZ3JySW9LWUNR?=
 =?utf-8?B?ZmhuY3NSbWpQRWEwUERUMVNuUEhIN1FuTXRBemdWUWpaazVNTERIWWZrS2Fk?=
 =?utf-8?B?VGpJZjNVSzJNV0JWUjZyeUpkdUhjZ25zWUQ4Zkl0N0xWcloyekdyYzhzSjRa?=
 =?utf-8?B?VHpwazB5UkZlRkU1UGdiOHBGVW9JQUUxQTlpTzNpOGxiRW95Mkw4OW5TUldC?=
 =?utf-8?B?d0tIZ2xhQ3h4R2M0Vmg5RzZVUldIbS9CQi9qdTVWK2FBY0pDZWZUeTB2Z1hU?=
 =?utf-8?B?MExyNnoySjZjWTZnRVA0N1A2THdtQVB6em9NTnpIV2dHT2NnZlRSM3QwemxF?=
 =?utf-8?B?cW5rZWN3eGlwMjhEU1FWYWgvaHNxNGlwRFNVbDhaQ21UeGxGVWxIRUpVODhJ?=
 =?utf-8?B?bHZUZCtiQ2JHSEQxSDBwY1ZjMHkzUzJFTkxtR0diQjFOWU1KOW1Qa0ZiN2tK?=
 =?utf-8?B?UkhqaHZNV2dITTB6WWNTNUNOUUpONjRlWWJnVkpoS215eTZ1dVlWWGxiQjYy?=
 =?utf-8?B?K0xvcmhtNHNsSXhiOGdEbGVLSUVoLzdHcExYanhIQU51M2NsY1Z3ajlxWlFM?=
 =?utf-8?B?RUladHFtb25wc0paa2tYbjhneHgrYlJZK29jNEpMRTR5L1ZRd3FqNkwyb3lk?=
 =?utf-8?B?UzQ3RTl2NHJ3VUl4WWUyMUZ4N01TZDcyOGhYUDgrRzZmSHpGMlBNUXNoL1Np?=
 =?utf-8?B?eFlXOThUa1c5MlhOUzNpdDJkWG1nNmVKZnNnUGozVmx5UHJDWlhKVVYwcFNj?=
 =?utf-8?B?SFpGeUg5VzFmWVlpZEFQTlpsUENVMHRqdzhLNlF2cWUwUW5ZaGExZ1VpdjZP?=
 =?utf-8?B?R04vVklDVXI4UzYzZW8yNVZmSzlrOWg2YmYzNFlDSHNPRjdHU2syZVVzYVJI?=
 =?utf-8?B?UlFZUmRCc0VLN0QzeG8wbXRicENMSTZaekhaelFKcVltZFZ4Q3VtRk90YjJv?=
 =?utf-8?B?OWE0MlVZY1crdHNmTWN0K1FPWUQrS2kxL3VhcndZRHE0bmgydDNRa2V6OFN1?=
 =?utf-8?B?b3c4VHBWaWdtSUdrd2RjVGdBMGR4RTdUZ0VaN2Fxa3dUdmlzOUFvVmd3RnF4?=
 =?utf-8?B?QmdZTVZMSkVHN1JHZnFwaUdvUU9LMWpYckptRFh4TnpPem5veCtxUUZWTXAv?=
 =?utf-8?B?T01SYk5ld1FTV1l1SXJVeVBZd1ZVbzNUYkx0TDVJaEJlSWRoN0Y1UXEveHMz?=
 =?utf-8?B?Q1JJdmxmbzNtZzJLQlNmSUppQVdQOEIxOTcxR1BSK0xOOUlpRHh0OFlOaHRJ?=
 =?utf-8?B?WVpqdkEyanc3dkErWHFjVHBzUjZCRnVrRk94QitqdDQrLzRqNWdwZWlxd3J2?=
 =?utf-8?B?SllxaFNhRXFMSVVadWJsdVhGaG9YNkc2L3RRMUhwaFRjV3RvcEs2YjRIbVNz?=
 =?utf-8?B?ZGVaQlZ4Z3dJZ253UDJtMlk0YnpGeUk2aXNCYWRCS3U2bVllRGV4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0db78-46e7-4b8b-e37e-08df356a9585
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:13:20.4269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmChU+ZbBRm5nUCprnN5MAGpZ3QwnNWd7WniIqWX/4kUYn6CmpIWXwhAi9HJHLvpBjesu2h/X6U7NuGYTVaC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------T1lpGNAzkSNKj0LOsKchjGaG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/2026 8:53 PM, Zhu, James wrote:

> AMD General
>
> Hi, Lingshan,
>
> Sorry to reply later! Just be back from vacation.
>
> Yes, there is only one set of PMC registers on the device.
> But the minimum control scope is XCC. So, I think we should design PMC based on
> Node instead of device. We need not enable the PMC on XCCs which have no PMC 
> data collection request.
> Since the request is based on render node.

They are per-device registers, so the scope should be the device, not XCC.

Another reason is, I assume we don't want one user to sniff another through PMC.

Thanks
Lingshan

>
> Thanks & Best Regards!
>
> James Zhu
>
> --------------------------------------------------------------------------------
> *From:* Zhu, Lingshan <Lingshan.Zhu@amd.com>
> *Sent:* Thursday, October 8, 2026 3:50 AM
> *To:* Zhu, James <James.Zhu@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> *Cc:* Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd- gfx@lists.freedesktop.org>
> *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
>
> On 9/24/2026 11:40 PM, James Zhu wrote:
>
>> On 2026-09-23 23:23, Zhu, Lingshan wrote:
>>> On 9/23/2026 10:13 PM, James Zhu wrote:
>>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>>> This commit implements a device-wide PMC config
>>>>> for amdgpu, which including the profiling owner,
>>>>> and the profiling enablement indicator.
>>>> [JZ] I think it should be render-node wide, not device-wide
>>> Hi James,
>>>
>>> It could be, but we don't have a requirement document defines the scope.
>>>
>>> But normally a profiler is a device scope,
>>> I see KFD profiler operates on all queues under the device queue manager
>> [JZ] One device could be split into multiple nodes with different processes 
>> running.
>>
>> I am wondering if this is really we want.  Ben may comment on it.
> Hello James,
>
> Sorry for the late reply, it was mid-autumn festival and national holidays.
>
> In my understanding, there is only one set of PMC registers on the device, so it should
> be device scope.
>
> Thanks
> Lingshan
>
>>> Thanks
>>> Lingshan
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com> 
>>>>> <mailto:lingshan.zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>   2 files changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/ 
>>>>> amdgpu/amdgpu.h
>>>>> index 8eff6b9ebe81..45897dca802f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>>>       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>>>   };
>>>>>   +struct amdgpu_pmc_profiler {
>>>>> +    struct mutex        lock;
>>>>> +    struct drm_file        *owner;
>>>>> +    bool            enable;
>>>>> +};
>>>>> +
>>>>>   struct amdgpu_device {
>>>>>       struct device            *dev;
>>>>>       struct pci_dev            *pdev;
>>>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>>>        */
>>>>>       struct xarray userq_doorbell_xa;
>>>>>   +    struct amdgpu_pmc_profiler    pmc_profiler;
>>>>> +
>>>>>       /* df */
>>>>>       struct amdgpu_df                df;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>> index c924a55fd16f..74ed42e53264 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>       mutex_init(&adev->gfx.reset_sem_mutex);
>>>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>>>         /* Associate locks with lockdep classes for ordering validation */
>>>>>       amdgpu_lockdep_set_class(adev);
>>>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>       kfree(adev->pci_state);
>>>>>       kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>>>       kfree(adev->pcie_reset_ctx.swus_pcistate);
>>>>> +
>>>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>>>   }
>>>>>     /**
--------------T1lpGNAzkSNKj0LOsKchjGaG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 10/28/2026 8:53 PM, Zhu, James wrote:</pre>
    <blockquote type="cite" cite="mid:DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">AMD General

Hi, Lingshan,

Sorry to reply later! Just be back from vacation.

Yes, there is only one set of PMC registers on the device.
But the minimum control scope is XCC. So, I think we should design PMC based on
Node instead of device. We need not enable the PMC on XCCs which have no PMC 
data collection request.
Since the request is based on render node.</pre>
    </blockquote>
    <pre>They are per-device registers, so the scope should be the device, not XCC.

Another reason is, I assume we don't want one user to sniff another through PMC.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

Thanks &amp; Best Regards!

James Zhu

--------------------------------------------------------------------------------
*From:* Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
*Sent:* Thursday, October 8, 2026 3:50 AM
*To:* Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Deucher, Alexander 
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
*Cc:* Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd- 
gfx@lists.freedesktop.org&gt;</a>
*Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config

On 9/24/2026 11:40 PM, James Zhu wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 2026-09-23 23:23, Zhu, Lingshan wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 9/23/2026 10:13 PM, James Zhu wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
On 2026-09-22 05:34, Zhu Lingshan wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">[JZ] I think it should be render-node wide, not device-wide
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Hi James,

It could be, but we don't have a requirement document defines the scope.

But normally a profiler is a device scope,
I see KFD profiler operates on all queues under the device queue manager
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
[JZ] One device could be split into multiple nodes with different processes 
running.

I am wondering if this is really we want.  Ben may comment on it.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Hello James,

Sorry for the late reply, it was mid-autumn festival and national holidays.

In my understanding, there is only one set of PMC registers on the device, so it should
be device scope.

Thanks
Lingshan

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Thanks
Lingshan
</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a> 
<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;mailto:lingshan.zhu@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
  2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/ 
amdgpu/amdgpu.h
index 8eff6b9ebe81..45897dca802f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
      AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
  };
  +struct amdgpu_pmc_profiler {
+    struct mutex        lock;
+    struct drm_file        *owner;
+    bool            enable;
+};
+
  struct amdgpu_device {
      struct device            *dev;
      struct pci_dev            *pdev;
@@ -818,6 +824,8 @@ struct amdgpu_device {
       */
      struct xarray userq_doorbell_xa;
  +    struct amdgpu_pmc_profiler    pmc_profiler;
+
      /* df */
      struct amdgpu_df                df;
  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
drm/amd/amdgpu/amdgpu_device.c
index c924a55fd16f..74ed42e53264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
      mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock);
      mutex_init(&amp;adev-&gt;benchmark_mutex);
      mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex);
+    mutex_init(&amp;adev-&gt;pmc_profiler.lock);
        /* Associate locks with lockdep classes for ordering validation */
      amdgpu_lockdep_set_class(adev);
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
      kfree(adev-&gt;pci_state);
      kfree(adev-&gt;pcie_reset_ctx.swds_pcistate);
      kfree(adev-&gt;pcie_reset_ctx.swus_pcistate);
+
+    mutex_destroy(&amp;adev-&gt;pmc_profiler.lock);
  }
    /**
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------T1lpGNAzkSNKj0LOsKchjGaG--
