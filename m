Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1607FC0218F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 14:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24F510E356;
	Thu, 30 Jan 2025 14:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAYY02Ji";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB63810E356
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 14:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5iicQfuhgi01zJOoXXEPUF22JAtdsddkz9yK/iHfwqze8bYgwcVmK3l2vq0UH+SMP50KOUjuI9TSNNC5NiHOuAWPZGsw+9WR5QvuJyoXK7qqEXf5wUVOFKATbwxjoCV5p75CDU/KdJ4BTyEBo2FjKM+Lvjg5NP6vVJNQLzwu28pBKSizvdwjER5zsi7VxHmypasnFMvxnwKCv+WCwSM3G5qEbhuIHg/Fd0Wgnftkd0Eto/v/Z8Dr4y0y9hGbAHvlcKHzCEJ9okAHuDgqyRj3dmvSa23k4tIpqx3A0ir7bngOtSF7vnWYdG1/PLjA7F/Vzm+bFytlPHwD8cRUsbuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FabobLcy7Y/Y2L+pnzYvXbCI1vjJSTeGrqi9WOLkis8=;
 b=LDTPdTDvhh/vk9QAN1m0Dfnv0582qdL3JiJhFlUo2XVlQhGooRQArJ3angDi+XY8LuruS/NPoBsjeJDks9Aj6PXaRqNU/rOODjZdBORDspKZKLwEYwKy5SDoDZS3vgEtjSqjoxqj5R98iW7nqX7LnqftsM0/0yOhzeJ2TddMzpfc9K62w138hyLt7DBWe5eeHosWrwjuaFjA08WyJ1sk9zs8kf4e3oFt6zKihaFJGE2lPMMsGH4dkR/Hj0Z7taWsGM8sS7JoW5oiPCeSGCqvFKvUXwhz+Qc8QoNCsEf3vJXmS9N4Ts5BVWij9gXh52p/+p5Kvcg8H0wEA9Sgk8Z1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FabobLcy7Y/Y2L+pnzYvXbCI1vjJSTeGrqi9WOLkis8=;
 b=uAYY02Ji4dThEVr+rRZN9dKdClO3SNyglLlR01ha7Xpo66JgT5QDzYTXzWIOf6ofVUB/mfXdxHbu2FebbaX/SuSggGXTBhLjgYGeIx721sTezExpGyRzoP2RT2ikzZkdwCao/8W9Po4cTcCcDcxjUTAMrCsRgWn5M5CXCtXULr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 14:19:43 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 14:19:43 +0000
Message-ID: <e5be5082-91e0-4ef1-bdc2-cce796d7aac1@amd.com>
Date: Thu, 30 Jan 2025 19:49:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] drm/amdgpu: Enable devcoredump for JPEG5_0_0
To: "Liu, Leo" <Leo.Liu@amd.com>,
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
 <20250130095113.534630-11-sathishkumar.sundararaju@amd.com>
 <DM8PR12MB5399804C93DC3748567CB38DE5E92@DM8PR12MB5399.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <DM8PR12MB5399804C93DC3748567CB38DE5E92@DM8PR12MB5399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::21) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4cc8c4-3bd9-402f-f2a1-08dd41392411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTc0MmhtQS9kM1JpcTFib1VkTUVZNmsvNlg2bmY4emZ3S3VJZHBva0JVS01i?=
 =?utf-8?B?d24za25ONDRYbFRjZlJnR0JqZ0gzSnp0RHZ4K2RxWkQ1STFQVStRRTVKT2ZH?=
 =?utf-8?B?UEdUMWozbEZSekR1dVdvdkEzYkkwOFFNZXhzT09WY2hsWXBaOU1BVmd6QUpY?=
 =?utf-8?B?cjdMUE5jbmtBS1MxZDdtaWszVjJobFhtazJRVloyek1OOXduSzhLNGErb25E?=
 =?utf-8?B?cXg5TEpYYklldERIdzF5MW9EN25SYytXOEphQXFQVDAxV2t3bjVQQmYzbTBI?=
 =?utf-8?B?TVN3Z3ZiUHMyR1NSTTdUU0tJbHhkc2FLY0JGcEwvZHYvS1pmZjhQK2I2SlZh?=
 =?utf-8?B?VTFUVVhvblF0OXJ0U3RqNGVFdWdVZ2Z6eHBVOE95RDQrb2ZOcDZvRHdIS01p?=
 =?utf-8?B?aVJ4UDlnaTczYkNPUzNFZlNBZ1YxaDlBQlhuZFpFSVpHQ2ZUTlhtNFRIUjl4?=
 =?utf-8?B?dUh1a3gvSC83c0xrdGFuRWYyZ2lNUzNxUDFaSG5qcG5rTEdwKzgrN2VPWHFL?=
 =?utf-8?B?ZXBlbCtaQ3VVTHZ3UVFrdnlRVzVOVE1Nd3NqRzVyN3g1YUpIdXFleG9zR3cy?=
 =?utf-8?B?N0xFWWx1NWhFeXBKL2xvQmpoaDgxeUhGamJmWFdJelNtYU85ODdmQ1NwR1My?=
 =?utf-8?B?bEtIY3NOQ2lhZ0FnVWtZM0lGbWIrb3V5SjNyNHpyelAxbjRQUEtkaENJMFBC?=
 =?utf-8?B?WWFuMll0S29iY01nWnlHdUowTjJuakJqbng5YVZKUVFRS1FSdXlFN3J2M2Rw?=
 =?utf-8?B?bFBERkZhV2ppNkFrbzBPV1RKSlgxeTRRUXdPSnllWVBZMDFhZ0lHZ1dORDdS?=
 =?utf-8?B?OVpZanRQWUk5cnFrcUkrNHZ6MVJTMTN1RnBycHR3S0JKQ3hxSDhIVTEyTmhO?=
 =?utf-8?B?YlVEUGJlYmFjbWdWREZHclFsRUVOMzRmb2dRTytqRkpiU2VLUlI3OWdCUkRU?=
 =?utf-8?B?VFpQY1BuZXJDU3RsK2JpMDIwNW1GeHAyUHdmcE1YTmJDb2pwVGhiVFV3Z0dR?=
 =?utf-8?B?dlk3NFNUbUdTMFA1QXNnVWpIWDBXK1prdW05STFacFBGckIzVGVweC9FVmti?=
 =?utf-8?B?MHpZYkJxbmZXOXZQT0tVSXJGdkJYT0k1Z1VCYmJ1akxqUmxUTW4vdnNtZzJx?=
 =?utf-8?B?b21Zdjdjb0F3cWh4Y21MS2VQS0krZGJJczl1c2FpWW9HU3NoaTNPSHVDaGZy?=
 =?utf-8?B?WnlHUFprQjBIcXNwaEVYZzh3b2FoVHMyZmZrcUtSenQ1WU5Fd1Q0bDY3ZGpQ?=
 =?utf-8?B?c2I4SE50aC9LV3g1NmJ5L3NyTGkzR3JrcXFWa1ZUbmpqMDFIdG5TL3Yyd3lj?=
 =?utf-8?B?SlNWTEJCWWQyVHpjRkNOWnZlNFdPa1dEWHVxMXo5Z3hFU2JVMDNnODhnU0wx?=
 =?utf-8?B?UXNxSWtPTXg0SDZYZ25UWUVUVUVEQ2VUeEhzbnBIS05wMzVjYlpKcDBCNGov?=
 =?utf-8?B?RndSZU92R0N4KzlsNUpVU05wcWtqTmVLWitUMWtQMWFXK1B5QXRVazNLMVNa?=
 =?utf-8?B?bk1qVDVJWmhuV0lrNG9hemxOT25NbjdnQWNVSzRURm5pUVlrNHNnbFBvR0xv?=
 =?utf-8?B?bzZnS1Z6OGo4SCtpY0ZrM1BtOVppL2lJOW5jNFdXSjlBaGY3QmpqcTQ1QXpO?=
 =?utf-8?B?VlVHS3pJQXhydWc5UGNTUkNVZGRhT3lES1hLODNlcTdtSUVudHJkTDAxZCsw?=
 =?utf-8?B?MkM3RHQ0d2RsMmxBK0NWUVZaUHRSMkZJSXZWWlFPaExGcEN0dVgycTJZQUpV?=
 =?utf-8?B?Y1VEWTdSblFabDhYYmU4b0JaQ1diMlN2Tit4TmJjTzFFT2JTN0xHWkx1aW9E?=
 =?utf-8?B?VVZUWmRsUHR4NDFydEkxRFA0bGhtODJHUTV6K0hqTkRnVUh6TVBQb05SWUhH?=
 =?utf-8?Q?3eOjBObCVMt28?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9oNlhlYXc3TFFPUkRUM0VBbTF2ZE0wazdxV1hVU0NaUmc3TnBDR1hrclh5?=
 =?utf-8?B?ZU5zMUZrZFRJOXRpWnRGd0lEV1ZvdkxRMG8zU2FWYzBKTTNGMmppc3NFZWdV?=
 =?utf-8?B?YThvbkNZTWRsaEJDR2FKYVJHc2RrdDFKREdzd2ozSU5STmc5WHVNdzRHYmJS?=
 =?utf-8?B?Y3pLVDZ4Tlp2cmFyQmlOMGJZdTgxQVRTUWxmQmF4SmZ6ZVVZUzdkckR5K1FG?=
 =?utf-8?B?Y2s4bFU1UmVSS1lNSDJJZ1NKUTVtZk5OczVNeVdkaVltWm5LenBUYkZhMmFk?=
 =?utf-8?B?Um9EN2JVWGZhUHR6ZHZPWDhHdkJ6eGpHS055bHdzS0o0ak5tdmQybllJbVdI?=
 =?utf-8?B?S0ZKWU0vQXZKZkFqRWdiSlhYMUh2VnV0RUhmaEV2Vm13UnBBd21qNFRDeWdM?=
 =?utf-8?B?L1FucHlGNytmWXF1b2VIbTdDUWpJVkFVRFhqY0lrQ2RYL0VLRTBmTHlyN2Fm?=
 =?utf-8?B?TmFvVllKc1pBWVVtcXRsMkJGeHlZN24yV0NjWG9RbFVZeE9RZ3lTUWZTeGdJ?=
 =?utf-8?B?UDZDaWptUlVuaXd5MkpPRXJOZzdCdjU4ak9wemJQYmFsemNaOS82L2hnZlFp?=
 =?utf-8?B?SHVpbWRYamJ5MFhRcnpFMFkzd2JFQW56UDBFUXJPcHB4bzE2YVBRVVJ2WXpv?=
 =?utf-8?B?OHJiTmlSRm9EajhVb2U2QUoybXZxeldCSzR0UTVUS05TVTNRKzJtL3ZRWG1p?=
 =?utf-8?B?T1kvSGx2dFl0M2dDTWY1V3ozc204eWNHVUZ6UkIrallCWUp2eStyK1Z2aStr?=
 =?utf-8?B?M0p2dHRUMVNOYjVwdGROS0VPQnhGNTBPd3hKMHc3ckxzQWlHYlV0R0FEVk12?=
 =?utf-8?B?WlhwbkZKckZoS3E1M3pJN0JXTnhBUXBhdVFBMVNmQzRzUkNqZ2FZYTBESVkz?=
 =?utf-8?B?bDVKQU41bUdGYjJXRGdOeEpEM0hrOFZZWW1RSHdWUVU0MS83RVp0TGEvVDNC?=
 =?utf-8?B?bFExRVNwZ09nZ05KOGt0bGdDUFQvNXl1NTgvUXNZZ2xtc1F2ZG4xdHJraHJm?=
 =?utf-8?B?TzFIckozSjlPMjNYQkpEdlpJTkw2NW1PNlRwZkQ5NEN6cVhxVWNyZ1NVVnh4?=
 =?utf-8?B?RnNQNzVOajUydTNMb0xmdUFLK3dlRk5qZlhtSGF6eDUvL2svWnVUdStYZko1?=
 =?utf-8?B?d2ZUTVNjV3ZQb00zODlmOURKaUtZMFlKTnVUU3YycEFtK0t5bWVlWGx0ZTlh?=
 =?utf-8?B?YS9xY2VKUGt1MTZBSWxOejRwS091S2UxWVlxYXFEcHJpVHAwYkk4ZExLWTdU?=
 =?utf-8?B?YW1UcThleFEvcDBRdVQxRjlWbE1sYzFUUVZiQXh1c0xyUWMxam9WNlVtQmNH?=
 =?utf-8?B?bU5KZTVIQWFObG5xVDhxcHBzUlNHYWdNZmhFMmtqcVJkMjFoUEdPQTlQN0Jw?=
 =?utf-8?B?bGo2WkN5U1BEcXBBcTErSm0yMENldEpVckN0Ui9NS1hqUDBOZjRQN01PSVds?=
 =?utf-8?B?UHRvb25LQUVqdGhHWnNMajY5amVHUU9RYU5tc2lyYkd0cHVlRHdmdGVHVEV2?=
 =?utf-8?B?VDhWWjZXdTFFZldCbmIvczdlays0b0ROdEpEYk5VaVVoUERhTTVhc0J6aFJC?=
 =?utf-8?B?UXdwckFZT0Q1ZzA3cmNUeE5DNXQvSEpFL2dSZW5GZ0JvV25RbzFlSEt4SHp4?=
 =?utf-8?B?UjBFT3ZpSVBnWXZPNnFxN0R2VGttNjFsRDBWQ0g1eVF4TndweGJjdjk4dUhQ?=
 =?utf-8?B?TDZ0ejFvWjhxc1NLUnN4Wk9RMWg2bEM2RFV5UzBXcTl1N3h4eEdHODZUdWhM?=
 =?utf-8?B?SFpVek5ja0tMOEQ0djhrcVhZcFkxbFRtT3EvSk1CZWRid3crTHk2RkpENEJi?=
 =?utf-8?B?bk1GdXF0MFBSaExMK2NIN0tsaklpQW41dFVncTNPWnZhb3drOU5XSGN0Nmxu?=
 =?utf-8?B?SW1SRWJ5dDMxcEl0OHlETzZpUlhSMklaZEFhc0RrOENwVXdNeFdyRlRYZTNk?=
 =?utf-8?B?MEZCUlNlbXI2S0RnK0tSQ0NLM2hRRVBiUU8xOVNjR3ZxM1F4MVZaU2FkaGNI?=
 =?utf-8?B?cGFEa0tsWGdFZDFjMzF4cStsMEs4RGc3UU1pak5BZ1BmUG41Ym9uWmZza3pD?=
 =?utf-8?B?RENzUG5RbEJjMVlUanpPWExmZXpySGppeWpkcjB3NUgzVWtuNFYxNzdpdmlv?=
 =?utf-8?Q?/BHuB9/OoSQ/kOCi/J7v65aRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4cc8c4-3bd9-402f-f2a1-08dd41392411
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 14:19:43.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhZrVbbMtq3NCdV4h4L7TLq8gnvx6ufoxwVSDC9C0eRfI1glb7cSj06rgcx5NTEsceR2YnjMuqyF5zgiVBvbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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

Hi Leo, Thank you.

Regards,
Sathish

On 1/30/2025 7:18 PM, Liu, Leo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
>
>> -----Original Message-----
>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> Sent: January 30, 2025 4:51 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Liu, Leo <Leo.Liu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
>> Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> Subject: [PATCH v3 10/10] drm/amdgpu: Enable devcoredump for JPEG5_0_0
>>
>> Add register list and enable devcoredump for JPEG5_0_0
>>
>> V2: (Lijo)
>>   - remove version specific callbacks and use simplified helper functions
>>
>> V3: (Lijo)
>>   - move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 22
>> ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> index d5cf0f2799d4..4a55e0cf39e4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> @@ -34,6 +34,22 @@
>>   #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>>   #include "jpeg_v5_0_0.h"
>>
>> +static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0[] = {
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_RPTR),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_WPTR),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_CNTL),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_SIZE),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_STATUS),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0,
>> regJPEG_DEC_GFX10_ADDR_CONFIG),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0,
>> regJPEG_DEC_Y_GFX10_TILING_SURFACE),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0,
>> regJPEG_DEC_UV_GFX10_TILING_SURFACE),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
>> +     SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH), };
>> +
>>   static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>> static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);  static
>> int jpeg_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>> @@ -100,6 +116,10 @@ static int jpeg_v5_0_0_sw_init(struct
>> amdgpu_ip_block *ip_block)
>>        adev->jpeg.internal.jpeg_pitch[0] =
>> regUVD_JPEG_PITCH_INTERNAL_OFFSET;
>>        adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG,
>> 0, regUVD_JPEG_PITCH);
>>
>> +     r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0,
>> ARRAY_SIZE(jpeg_reg_list_5_0));
>> +     if (r)
>> +             return r;
>> +
>>        /* TODO: Add queue reset mask when FW fully supports it */
>>        adev->jpeg.supported_reset =
>>                amdgpu_get_soft_full_reset_mask(&adev-
>>> jpeg.inst[0].ring_dec[0]);
>> @@ -637,6 +657,8 @@ static const struct amd_ip_funcs
>> jpeg_v5_0_0_ip_funcs = {
>>        .wait_for_idle = jpeg_v5_0_0_wait_for_idle,
>>        .set_clockgating_state = jpeg_v5_0_0_set_clockgating_state,
>>        .set_powergating_state = jpeg_v5_0_0_set_powergating_state,
>> +     .dump_ip_state = amdgpu_jpeg_dump_ip_state,
>> +     .print_ip_state = amdgpu_jpeg_print_ip_state,
>>   };
>>
>>   static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
>> --
>> 2.25.1

