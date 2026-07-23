Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43618C531CA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 12:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B4010E58C;
	Thu, 23 Jul 2026 12:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pu9SkIWu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6844910E58C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 12:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAuCmJ/szrEF+BcWkwfsuvdjaQNSu57TdIFQehU+zCOyURZ4zJ8aOPrbAzDoj0TH2by3c/FofsFLWnKYJyMRIP1DYRbWD3R7swajIfNgZsSNn/khvg2p1nwLq8SKvfbgP7wLXsA0Gi6LGTpPzeaZwmJ2uCxBGvCQUd1g+dI48e+zoyyWth1KdyZQ4UhhkSx9y0diZuA3PutX7iX7inO0MxcXoAZ+b/sUPSKg9zKRVn/Tip335UPjNpw8yhQU2lLKYjmcFP1cYCEmUGyWmNeWxH/9euEikKNk1tQzmEhnWAm7lww1bAsxxU4n++NEccgZu69entcP1/KR+EJsq5hbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBK1ZEf9NSiDOKJeDbW/1CWjm3edkCu/3hKlH4/jlkA=;
 b=abTJ8QtkDg0CS9qb6p0aCai9iUIPXPwAYWSU4v3IhlqUeuTEoTQJ1QaZlVhu4mCBDmLQS68IMo/0RBvrTj94MWYxbyy1T9jxHDK04bVXxoM/ZvshbxC6/8sUD+tInLB9gNhoHUjkAT08r8oCy1CnW33QaX/GP73Xjq9Kb+Wi2pUv3sFUgP6hzFLQi4+tP/e5wBDUFP7WUWdH6f2KcBmbSxpgflJSY9bLstNaI9KIPN3/vcwvc0VwsNVsfMFnUTIjFfWKyWfcRHApdOjAqo/HRoJxW/jGHT8L1uuJ88Y01EADtvV23+VUHGLeyYTz8A3htsnAWHPfiCO4VNxZxmj+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBK1ZEf9NSiDOKJeDbW/1CWjm3edkCu/3hKlH4/jlkA=;
 b=pu9SkIWuh39qCGk5CubJhIMzGcHPyxp+Wxz+say+i3qlt6qzD7jcH7/UAmIVqpk82vO6DbB0ue99Vl7oz+hUyBmSgJp2rqAHjoT5OhXAhU/zGQNLzP7WkEHT4G8Z71KcGZd+3DiT+9DCJgx6S648YmXmVYHWz8q0L+xt2Eb3leA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:09:32 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 12:09:32 +0000
Message-ID: <18c2c72a-4e6d-48ad-910f-924e57ab8a39@amd.com>
Date: Thu, 23 Jul 2026 08:09:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drm/amdgpu/vce: Prevent partial address patches
To: Dan Carpenter <error27@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org,
 Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20260330195757.901509-1-benjamin.cheng@amd.com>
 <20260330195757.901509-2-benjamin.cheng@amd.com>
 <amHzHa_2Cjcu5_7G@stanley.mountain>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <amHzHa_2Cjcu5_7G@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::22) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 863db48b-1ae2-470b-d5f6-08dee8b34128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j5bPKmHaRimBtGZEmhmrZTecMxEOqskVdmKftVlil3H/y2n4ewSgBxjpxpVYN2aLCHiZZ7Ch9Lkefngd7vEAw0FlesAiFXrmpaNVwE+/3vuCnEI5Ep0Qf95f0gJxuGFgfn1+sT2jED6R+4TMtZGH4h0ko5te9JUEMqc6XZ+sygOtgS5+8OdzRhlJpPn5RrE8biKrvTL4qFmqSYJRHOdVVuWz+7nhKFvKyGlA9yARy0OBcJKNPrtWMadMb9GaL+hLdxD2WpADsbtGINKhy505ErPY9Hi8NjQi1l5miMZzGvQdaNziBcbDEmHWKHknPdId+/clfGBluyo1q8powKrJE2VDDzyCGqJjL0vKIxMZQ2UB3JPKZ0Inx3LdH2TcIfTV/UDQomDM68xAEHn3PTHB+4F7O30ohsUC9b+RII5KVcxAYxI0fK66GWrQr/tsVJ1lwB5GVJ+x7GqC1cGdd7NZ5W+Z/MLNyZ9G/P3mGGCnlh9biDbBLFVJOR7lbNfQzO6uT6FHjLhM4EFwLVxth/1li2DIJvoY7NkqixwaLWNDuA3CXx/V3e2DbPvWbTCAcdW/Ef0Tt3QUEXHqLh3OxaJ4yXxwlLzT/COlJ9d7heRhf4tKsD7b29amQ0SOCqtaZO1QnmvFhG2Q6qdXdpk3RkgrYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RoUllUbGpWT2VXaVc2U3M0dTBCdkVhdWJTQ3lIbEdLajRkYXB5ZTdreGpD?=
 =?utf-8?B?UDVIZ2ROK0I3SGhGR0h6cEx6S2JpQjFZMWxLQ2JvUWFzaUVHbEVwNzd3RU04?=
 =?utf-8?B?VEpzMFhwdmp2UzQ3Tk85ZlpFdFpZTTdpVStqdW1sZ2FqWmRyNitieDdEYldh?=
 =?utf-8?B?ekJiMEREODhzbGVwMXFNQXNLeFlKZVFiS2lhOFpRRzhhUW1oMzFPSkxFUVAx?=
 =?utf-8?B?Ym5Mb0I0SDBINGk1RzQwWkRmMHpOaW9mVVAwNXpFcTZVbk10SFhwa2xVN1ha?=
 =?utf-8?B?SkZEbUtpR0t1OHZoUEFVMWtwekplS0Q3QXNrTDkwdmNLYzBBWjNwRCtuZ0s4?=
 =?utf-8?B?eUhrR1dxekdWOWtBZVZ0eGNVek9kam9lT2I3L0hRZFVDRzQvQnRDQnZzaVI1?=
 =?utf-8?B?NlhJNTdkUnlXc2xXT0doeXFyVEhiYzFkbEM2Z2ZJRUdqL1JoRXVkZ1Fqc0ZM?=
 =?utf-8?B?MVh2eEx0TjA4NmRvRXpFQVlRVk9kWlkvSDAxaHI4bjhhRGdscHFLOGNLNCto?=
 =?utf-8?B?K3lZOTlmemdpM3VuMFhGNnZvazlxRlE0ZVYzazl1Qmg5eEcwZ2JLYjhqSmgz?=
 =?utf-8?B?cUJYQm9hMEhYbjlVVmNralFGdTlpSkFsVDkvUkttRGhpNlF1K3RDSjJTSWxH?=
 =?utf-8?B?cjRCS1dRKzZpUE5aL3doaVlNc2dFczZadmRxS2RxeFBCRFh4S0VleU5zcGNZ?=
 =?utf-8?B?NjRkTkpGeXh6UHFWMDJndHdnV0QrK21EblFFNE5VZ1JQd2Mzc2lZZHFnS3o0?=
 =?utf-8?B?enlqZFBqWjRxN0xrdHJ2dDFmU3UzZWVHeTRaazRJMkNGMDgyUmxMbnFyYmZT?=
 =?utf-8?B?Y09ISFpnc2lnYXlhWHZtWHR0MTkzN0h2clFGdThYeWF1Sk5rQmhnbzYzZnYx?=
 =?utf-8?B?d1hSZ3A3QmIrdFZKNnRNRnkza1lSZWpDVklmRUdYOElpSmRBNTZZOFNKVlNv?=
 =?utf-8?B?TmNRc0Q2RkJ4U0RvMldXZ2VSbmcyN1Z0L2JDWmU5N0ZYWS9rVlJVcnBicHY0?=
 =?utf-8?B?TVdhTW9vUW1VUXZ2MHNGeW4yQldHWGJiVUptTjJabjM5YlRDK2ZKUnAvVVIr?=
 =?utf-8?B?SE1PbWtTYnF2dm1HNkR5a0VnOUM1RmJuaytiUy9QZFJkQ0hYQ0RKTGNCQk1m?=
 =?utf-8?B?UzRzaUpLWXdiT1hxdW5sLzkzRk82Q05peU5nak43S2tSWStLMHl1Z0tHeXBJ?=
 =?utf-8?B?ZUMrc0ptQlc5Wm9lUldJRFVpTExNOExHNVB3K2VnbWxNVGQ1Mzl1SE1MQ3lm?=
 =?utf-8?B?QmVCVnZCUU1RSUp2TXZZOXBpK3pxb0tIUHVRS0s3bW9UZjFBakFyWEg4aGxD?=
 =?utf-8?B?bTZlbjltSVhLY3BkVjFKQ3BzS2NqSFdsMjY3SzN0SjJmWm5UaGlkeUNUankx?=
 =?utf-8?B?MGZVQmVyNXZ3UTkxOGRhV2p0cHdLK2lxTmhCME0vcUIzNjVCa2RoNVJiQlVw?=
 =?utf-8?B?KzZYM1pGTjFLTm5yTzJLb3JoVDdsQXBtcmFsemlieE8rQ3BXMldsRkxVbzda?=
 =?utf-8?B?ZDdjQmV4SGFFWEhkbVBzUWRzbVE3UnhuL0RYUElPeldjd0ZJREtMakdxOEdB?=
 =?utf-8?B?R0VZMVdEaFc2a3g1b1NPQVVvU05NNloyRkcvWVJ0Ym1WOGlaUWVYT0VUSGd6?=
 =?utf-8?B?bVU2NjIrTlcyWVZnbmczUUh0Z0Zwb1VBcnRWcDJpNjM1YTViTE5NY3NPNVhn?=
 =?utf-8?B?ZlR0a0RaK3dVRmxPbjFMbWY3Q01PaWFic0p3YWpXUm0zZ1pWcVBjRHMzbU5K?=
 =?utf-8?B?YXc1VHg5TXVuSUJ6NWswQ3JyTGJDTUJXNDFzTEFWcndhNXhITDBrQVJ2RytO?=
 =?utf-8?B?L3RndEFva29aaFJxblJqN2w4RUJCRitidEk5R21WQ0JlbFlhbHhoc056TUVM?=
 =?utf-8?B?UUFlS1l4Vm5pbU5LSEUwWjZvQXloU1pPcDFtaklIMWY0Q3R0Q1BjYnFIWjZU?=
 =?utf-8?B?YU1YQ3kvMHdXYm5YTVovYTE5dmR3eFRsVWNJcjIzelZ4S2I1MTFzNHkrSDZs?=
 =?utf-8?B?SzZGSGtkaGNmS2FoN0tKS2gwdkFSNEZuQkcyZDh4Vi9Mb2YzeG1IVzd3NHVG?=
 =?utf-8?B?akUyOEIzSENGL01OODlGMHc1Q0NXQkNmdnFmL0FPV2NuTUQ3eFpxSFZpMUYv?=
 =?utf-8?B?UEFWbUEza3lFQTF2SEpLM3I1dU9kaEYzekgrM2kva0ErK2ZBNHA5MEtISUIy?=
 =?utf-8?B?NUV5UTFlV1JLWVhuS2lYWjdzWnpMZzZmUk85NFFDaGdvWWxoVFpXaGdUdlV3?=
 =?utf-8?B?ZVpoZ3pVYUVpWjBjUVFnQStDRXpqYkdaWWNJeTB5eFhxSDNLZklUWXhXM09y?=
 =?utf-8?B?N0xpTDVZUU5XZnFvWEtyb3lPMUtxVnR4ckVsSHlyNW43Y2Z5QnFpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863db48b-1ae2-470b-d5f6-08dee8b34128
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:09:32.5926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESSyLG/u8ems3BtoBbqM2QStcwh5hcZf9bzZ45359xxEhD+NZwioeO8FosmynfC8O+4nUMRYcMYW3s1/mzGuYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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


On 2026-07-23 06:55, Dan Carpenter wrote:
> [You don't often get email from error27@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, Mar 30, 2026 at 03:57:54PM -0400, Benjamin Cheng wrote:
>> In the case that only one of lo/hi is valid, the patching could result
>> in a bad address written to in FW.
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index eb4a15db2ef2..efdebd9c0a1f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -680,6 +680,9 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
>>       uint64_t addr;
>>       int r;
>>
>> +     if (lo >= ib->length_dw || hi >= ib->length_dw)
>> +             return -EINVAL;
>> +
> I feel like the better fix would be to change the amdgpu_ib_get_value()
> function to return negative for invalid indexes instead of returning 0.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>    562  static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
>    563  {
>    564          if (idx < ib->length_dw)
>    565                  return ib->ptr[idx];
>    566          return 0;
>
> s/return 0/return -EINVAL/
>
>    567  }
>
> amdgpu_vce_validate_bo() has the same issue where invalid lo hi are
> treated as success.
That catches the issue earlier which can save some CPU cycles but amdgpu_vce_validate_bo() is supposed to be resilient to bad addresses since the user could just put bogus addresses into the IB. In this case we just need to prevent a partial address patch, i.e. the hi part of the address got patched with the physical address but the lo part did not (because it's outside the IB).
>
> regards,
> dan carpenter
>
