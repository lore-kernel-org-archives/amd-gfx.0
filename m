Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955A3E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 10:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443B010E299;
	Wed,  8 Jan 2025 10:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYW8XKvp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163F010E299
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 10:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMS7NTLY+OdaVWyiuLEJjkH8RYTVfQpyfE4YDZuhzeEEh5DjiF+KKtOcVnJl0vYuNccaJDKfHwNQsVW8EU/USy6C71CGCs+nyN+iWPwpqDPr9gDg0dw20gRZlMGNDrXwaEE/K4IOUKTaKNJbaVY6oxAy8JXnXTMjsEnPgqOQd/r29Reb5I1uy60YJzrJL85p5/+RW1L4a6Ri330QOBXuRCJQlrPijqC0Al1y8q6BBdevv4P76PglZy+Mp5RgCSIsigsgWYgDtF6wM9Cq/0StoXOc5Air9DaFWBSTHt5fcLxdOdHpMdahabzAsER6mNQFGEX3V+E02zwejvAsfk0z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/OBEx+Jp4nxTS7jACpczgLFUFLyStsZ5C+7xxclue4=;
 b=dl+gIsxxOLpCiuzaTaVA+sy6UZtRBb4vaARHZ5JPbU6FmSZAoDCK93wVBbqYwVmNssIoyjsQxWAMzY3h5fXwaQOJBRz7UQIPyB9s+XR61K6QV9qA2a1PgHDzuBYStgyyd7iOsMAAM3LhWZSXVp/jWtiRbLV3ww6jj1gu6su/VBsnZeRGxTIi4fj4KP+GQ1ppXCNrYBNYT7UF+2hHqIAA/TifIUWVQNQDn8/BKTduZ9fFW13ajZXw/52HCkZoqBtSBwgJbuHJyAg+KLKYYcKBdVTiTqJ28aEYVzVBIvhEd4EKQzIywlFkmgqPrG0xwn6cE9gwq3R+6OHD82LQfGgQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/OBEx+Jp4nxTS7jACpczgLFUFLyStsZ5C+7xxclue4=;
 b=AYW8XKvpt+AH+dQkyGDnhUa+Yfel5lbJZqdaJfZzYGFVIW0vjmasmTVP/9xl9l6hZCIIzc2bJ5QYRTGAdL5apVQPPiUheR2k1fQ5vLN0u5L9Z7vJZFaf9Tx3/+wlqelE96m7BsqxjX7zycsWnEBEBBobxUP9UD/WpwkF6aMwYLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 09:58:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 09:58:12 +0000
Message-ID: <4ad59be2-c173-4a2f-8bd3-871c5b8429b1@amd.com>
Date: Wed, 8 Jan 2025 15:28:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 5/6] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <ab8e42d18be2d9555ccd3b03762d9a4b76e33a60.1736325561.git.gerry@linux.alibaba.com>
 <6cbd8f75-1b8b-40a3-960a-b2cdd6c298b9@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <6cbd8f75-1b8b-40a3-960a-b2cdd6c298b9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067F4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: da6fbb75-c31b-4d1c-397d-08dd2fcaf689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3FvaWM1a0JucmhKcGdzenF0aDhNaDhKdU9Ha3M2c1NnMDR6L1FTM2Rhbjl5?=
 =?utf-8?B?Zk1jT1poaDMxVzRMWmFUbk1ZdmZvWktvRzhXUjVUUW9DdWxWMnZnZjJqSFJW?=
 =?utf-8?B?dll4elFFNElTUUpUU0hRUDlwSi8wM0VzcGVVQzJYRU5JZ1cxOFkrWmRDS1Yy?=
 =?utf-8?B?Q0x6OE5pNDBpWTBFQTJoaVdScVloSUtRRFFIeWpLNk10aFkxOXRJVlB3K0ta?=
 =?utf-8?B?RXJuNm0wSnBPdWhQQmhNVndJY0VqUkZwcm4yWWdXTDdsbmhGTkJzK2R3Z2JX?=
 =?utf-8?B?QVRjOHByZDMzcmxpZzIzSHZpRktlYzlFRUlqd05KbVFkNS8yYnYxN2Nta056?=
 =?utf-8?B?SHNuUjdsanhMN2NWcnF5NXA0cUR4aVdwSXB3UndMbDRIVG5SN3Urc0JmVjBF?=
 =?utf-8?B?UkVpQjE0OURjeDlBdFBmdGlTTlU5UW5Xc0NWR3pvMkJKZ0VJVXlwdU9mbjNY?=
 =?utf-8?B?cXFQWHFzMTFKOElCZjQxQkt6WXBMb0dXZ2RPQmpTNENYbEI2OWZKUURVWE91?=
 =?utf-8?B?aVNEUWF6WithTnJmV0V5YktOSjByMzJwVVdONWJBQmt1SmpGTXdSU212eW93?=
 =?utf-8?B?SUVCMTZuL2xPTVl0bmg2aGZCdy9aamQxQlZpUXAwR3FEbm1taHpxcUZHZzFG?=
 =?utf-8?B?RnhTcHdMZVlESUxUQUluWkJtcFkwQ3ROZ2lqbXVkN0Rmb0tqQ0p0N0FtUlhq?=
 =?utf-8?B?Tmgvc1BLR0QrRGozZGVRZEgvWnNtMUI4aVZUZE9LZnp1RTVJdmMxblpWaGZH?=
 =?utf-8?B?UWwrelZIaWhZcmhzTFpLODJXZmU0c2VXRnU5K1hhdW9DWWgrSHlzU2pHZm5Y?=
 =?utf-8?B?TmJrV2h6U0h6czQ5YUQzdldDYy9INWRVQjBkZHFBWVNsRS9KTnBQUVVPek5l?=
 =?utf-8?B?SVhaU2orVHRIZlRxWU1PYTlCUEVBbkNweXhkWS9lRmw2RlRjR3dvSnM4N1R1?=
 =?utf-8?B?RTJ2bExqSlQ1MVJuYmtmZWRIMWcrTkxwNldFOU1FWWFId3JCUFRBTmZMMWhs?=
 =?utf-8?B?Ykt6QU1DSmkxKzJsQStBYkxtdFpYRyt2djNFZWFQT0cwSGdFSUpnRDkwS1VC?=
 =?utf-8?B?ajNZQnl3ZW1BYXAxWXVVZW94dFBySjJLbjVMWHZ2R3haTFhVODVoUEU5MDZj?=
 =?utf-8?B?U0x1MkRCd0pxUThzVEZXWmQxd3VVQ0dYeVViWHN5amcxZHRrMG5KOGlveFdH?=
 =?utf-8?B?cnAvODdYWFJxcWN1NHNvK3dPYXJHem1xWUg1TWx5YkM3TG9PdHBqTXNDWEk3?=
 =?utf-8?B?U0N5eDdISnErR1dycGgyTjQ1TGJBYWF3MVlVUTZienpQVVAxZkJLWVJtRitl?=
 =?utf-8?B?OWxSbWpGNUFqN0ZhVzhXMjVnZE9YYUV6dlU2MXJPeGpjb3JxbGtVZDE2ZHkx?=
 =?utf-8?B?Y3Y0T2F0Qnh4NTFuekZDZUlGTS9nT2NsR3puZkZJWi9HYng2MmVyUm5IZFgr?=
 =?utf-8?B?THdOQXR5N2l2MW43dGRRLzl4NWM1S0lEZDQvb1luVE5Md1lXYWF1R0Y1ZEk0?=
 =?utf-8?B?QUIyQVBMMkU4di94dXpkbE1ndzJmdkZ2cU0rY2hBekZMVUhib3d0NW5UWE8w?=
 =?utf-8?B?TzI2QThCeEV4cWs5YXNQSzRZaXg4MkovZnBGWDA1TGc5cnlDUEJZNzRxNTZ5?=
 =?utf-8?B?RVp2bm45OG4vTkJPU2VleU9jaiszeW9abmxldmwxb2tBY0QzREo5bGp5dWFn?=
 =?utf-8?B?V3A2T2p1Zy9IMVRTZ0IvanJ2Nm9rQURqbkZzamxZeXdDR3A4V2J6QUpHcFFk?=
 =?utf-8?B?RDZIaWh0M0FCRnl1dnhpaW0rYzd5SXgyT1lBQUNZaG9hMytDeURXUGhyOVI4?=
 =?utf-8?B?SzBYNDYySkgvSUhBM3Mrc1lzK2laQWdyaUFwOU5EUXovK3lZVDl5TmRiMjNN?=
 =?utf-8?B?ZkthRmdqU3Q0aFhBaXNFYzVNMmEyNGd4emJ5eDFvKy9ZMHV6aEh0UncrQ1ZI?=
 =?utf-8?Q?FT9Q1PsTfQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnZKcVFaemlBMlBDeVZOMFhXSnBnNCtNMVZWeklDQWhhQ2M2cC96cm5OcnFq?=
 =?utf-8?B?NjYrTWxWOWlQbGJCOXh0dG10TVBHZDBQWlVINlpXaHhyMUx4QUNaL3VXL3V6?=
 =?utf-8?B?NFA0djRVTTk1cnlZbU9sNUE4RTJxV0xBb0gwT0Y0SjhGYVVza1k1MzBPbCt1?=
 =?utf-8?B?SUk3aEdldEhEVkxoNlcreFk0cVJiUVJ3NFhFd0RrM2lpSEFZZEswUUw1cEIv?=
 =?utf-8?B?RWNpVjJPUXJVWHRFbisxSTkxeFhEdFo4aHlLcldJTXBmOUxtN3owTUF6blhj?=
 =?utf-8?B?RWZsSjhDdEdDbExvUGNMUVpuWGNwekdweG9TQXB6dzF4Yy9EWmZpaHc5RXJ6?=
 =?utf-8?B?WXdsRGtSMzlrQlk2SFZqS1o1RHRtQ3NEZnhmcjY1ZEIyMG5wOVFBaTNwTG9H?=
 =?utf-8?B?K3g4dmZwKzVsTFNpOU5qRnlyOFQxdHhLc1JiZllXUjlXNHVpcnB4VUxwbXVZ?=
 =?utf-8?B?WFdjcTJZM2xnVUhWKy95L0dIekFxczJrRjIvaGpxaE5lbVVhYjlaQlcyZlZF?=
 =?utf-8?B?RTZ2ZnNoeklVZDZwQmdFcWp6VEhnZjRSOU1IMWo4b1lIc3l3N1ZCSTlGSmNh?=
 =?utf-8?B?WVBoc3BLRmZ4Q3FzR0NaZU9xcGgzUTJCV2x4NWJVWHM4OWtLM2tienJ1N2p4?=
 =?utf-8?B?TE4zZTR0ODk3YUw1T3hnMGFUQnhGbUltNkQyNDJYSENHNlBSZzVWemo0YW14?=
 =?utf-8?B?aGZkV2hyWmphMW9DR3RiVndHWTNpWGpsL3BwLzRFRzc3V0Mwc1hTUjJ2aUtC?=
 =?utf-8?B?cnlmNkRqaTJxaFBwYmZtV1A4UjJXWW9mUDFrM0s4Z1NaeWM0TEdpS3JNWDk2?=
 =?utf-8?B?RW1zc0NMUUlKWXB2NUNFVnIrZFh5czNGOXh5TjFEMjlBQlBxcFNYZmNGZjRi?=
 =?utf-8?B?R2p3QUNXUXEyWnduVVhCR0FESnRrMnBnRXd0SHhYaGRzcnlJMTEyQnBxbVp6?=
 =?utf-8?B?TlEzYnRVcXR2MUVJNytWUjFyblVFQjdVZ0lTaVBQYzlMQis2SzAwSThJZUFr?=
 =?utf-8?B?b2tWQkhScU9uMzR1THNNV2YzTzJiZWI5U2VDWjVZTDc3YmlMaHkwVVk0TGFN?=
 =?utf-8?B?UFd0UjJaVVhYMDFuZVBwMVBpM21EOFVLQVZCY0R6dnRCSUJyMU5sRDc3RjNx?=
 =?utf-8?B?ZXlwclN3UGJRc3o1b0wrU3V0OFJqOVFIMW5DdXg5dXFDUzZsWnQ4UVNRZ0hC?=
 =?utf-8?B?QnRYUXdQOVBDa1ZZUlRWazNPdnZ4MG9HSnBiNkVWT211QjJzYUo5angrZ1J4?=
 =?utf-8?B?THoxeGx1SHkwR1ErM3ZXcWJQaHhuVGs0OWNMNHZFK3ZzNmZTSUx2a0hVOTRX?=
 =?utf-8?B?SUxWV2xMMnpXbnAwUXRPQ0UzcHpadlFEb0hMWlVkY3BMNjFNYmY4TEtuMTA5?=
 =?utf-8?B?VHJHVmlkQzVMRGw3M0k3YURqSVFuUkRnU00xVUltTFpHRTU0SVFteWR5NEtk?=
 =?utf-8?B?cG5CQzJ4ZFlSWnJIMVk5b3BQZ2haRTVJS0R6VHR6RWhQd3g3ci9uMkpJaWdR?=
 =?utf-8?B?Y1ZWaXRIVG5MK0ZkQTd5V2N1RGpzZ2UyTWN5bWwyRFNGcCt4cXZWWVhZdnht?=
 =?utf-8?B?eHZDL2hveDhOTnJFdXB1M08rN21pUjVzSVBxbkgrYUVzU1FncWtzZW9GN2Nt?=
 =?utf-8?B?L29Qc1Z4M2UrM09yOUU4UWM5aTI3dEU2WnV2Rlh2SkVPWUtzUE84RjBxWHYr?=
 =?utf-8?B?V21RUDRISUt5UG9VVlVCTVJWRGFHMUEwYkJURStpc25sWGdBNkJkU0htQWh6?=
 =?utf-8?B?aHF4clFzaTAzREE4UmovL25VRGdVcU5hSWZ1Z1p6RkNBSXRscktqMXlQbkI5?=
 =?utf-8?B?Z1UvcWd6Y3paanY3Q0FOcC95NlRDanExbHl2czBDU0pNSWJabHlKZ25wZElT?=
 =?utf-8?B?dzVqQWg4TFV0ajJPVi9MUEpHK0dXVFVFdmdxMGU1WThVNGlmSUEyS3owalc4?=
 =?utf-8?B?NlhqL1ZzZGdsdXFlUENYMDB4ZmQ5RmtIMzBDSFpsSUMvLy9MT2tZVWN1VTRB?=
 =?utf-8?B?bHM0MzdGcHlhMmZISUVHRXA2YXEwZFNabmNjaEJyNENmUldhQ2c0azEyS2ky?=
 =?utf-8?B?MURPU1luTkxVSjdCeEhNYWh1bFA4NHAyWVZESXlaZU9KTm14eEJOUUtlREs3?=
 =?utf-8?Q?9wC0kDKt34BpfF8H8mHL6r1vg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6fbb75-c31b-4d1c-397d-08dd2fcaf689
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:58:12.6490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UjptaxN2k8AK1hZx1WTAm2VZoumNuL1zW3R0ehZURkje6V7qXurqmrWx3q8wWVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
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



On 1/8/2025 2:46 PM, Christian König wrote:
> Am 08.01.25 um 09:56 schrieb Jiang Liu:
>> Function detects initialization status by checking sched->ops,
> 
> Where is that done? Inside the scheduler or inside amdgpu?

Down below inside amdgpu_fence_driver_sw_fini(). I think sched.ready is
repurposed within amdgpu to indicate ring being ready to accept packets.

Thanks,
Lijo

> 
> Regards,
> Christian.
> 
>>   so set
>> sched->ops to non-NULL just before return in function
>> amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
>> to avoid possible invalid memory access on error recover path.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_device.c
>> index 510074a9074e..741807a1fd2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct
>> amdgpu_device *adev)
>>           if (r) {
>>               DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>                     ring->name);
>> +            ring->sched.ops = NULL;
>>               return r;
>>           }
>>           r = amdgpu_uvd_entity_init(adev, ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_fence.c
>> index 2f24a6aa13bf..b5e87b515139 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct
>> amdgpu_device *adev)
>>            * The natural check would be sched.ready, which is
>>            * set as drm_sched_init() finishes...
>>            */
>> -        if (ring->sched.ops)
>> +        if (ring->sched.ops) {
>>               drm_sched_fini(&ring->sched);
>> +            ring->sched.ops = NULL;
>> +        }
>>             for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>>               dma_fence_put(ring->fence_drv.fences[j]);
> 

