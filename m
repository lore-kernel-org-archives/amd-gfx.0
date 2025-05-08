Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D48C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 11:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B00210E8DD;
	Thu,  8 May 2025 11:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9zEu44h";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC0310E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 11:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcvH8ufvLUxKr4MfTWu/4LWBA5noJbfa6OBrzOOns2U9XRhWP2QieGaI+EvTZH2RvAnJfwaeowPnozJHW3ZzpIxr2J5v6BaprsTV181AHFLzmVInbfzVHMFIJCJkZcIhZzwudZLSwwJCQJ3vbLKKMwETLbCECoto+pxze7Mavv8ZLW59NsgjNDwh6FL2m6NzZVZYy1JYbI2SScV4j2PjNDf5Bh3zMbJSe0W5uUAdyz0vpnw3koCy2gUswuh4cpK3bAc2Roook9lGxjHDeOAt6qUKnTNdZQoPhetyYj1tD/rgmUbI93xmSS2C3qGu6VFUV3mEE3Ct4w1RdwKOc7FCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8XKwzftLwgOKaQCQbOwXam1fpu+vQSreUf02k+N01s=;
 b=lm8BH5Vr6PC70EZXdWdxUNAH7BRNKSx/hSQU5VKT9bYau0NtgestwZxHKU09Jtd8lMX+iwUe4Np0hsVPR9rBHmV5h3NESMcD6v6Jsl5xhC1xotEwhgyscW1NutZHaJYp6FFw/TWyeEyeqDRwdZDyh8brYK4sHhiMeQP03rJ3XiJCcwl0CKYw9IW2/B/A9f4nnkW6xzvBR6hf/BhqWwW7ov/co9Pe1+nPZESwCsVCvbKzSCXwmZbxzBnalfOM0ZfsNPeC3AqVZmMt1oWRY7/vOJ7PPJlxpPQyvLL/ry1ypjgqyZnVCRtUpaJoBdliKQAYhVWWk3FnxeUVyeeve6ijQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8XKwzftLwgOKaQCQbOwXam1fpu+vQSreUf02k+N01s=;
 b=O9zEu44hFCPbUCVYMT9Gx8/8X57N73qXgOdSshwpk5cuY2Ms/SHcZSvYehPi8iDwEzGVGrrwq1Q0+OMClXU6k42OjR1/L0AMFyrBs4Ju4sc2cLxi0xMq196Cnq/n3UsO8MN3IOP6nEdEDXB3rLcYLcGtSCDMG/GqvOK3DMk+IoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 11:36:29 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 11:36:29 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Arvind Yadav <Arvind.Yadav@amd.com>
Cc: alexander.deucher@amd.com, sunil.khatri@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250507183722.76789-1-Arvind.Yadav@amd.com>
 <CADnq5_N0m738JXJDzRkdZum=KteV_jTYixXQ4SCYGs-43NdhLg@mail.gmail.com>
 <b5486ff8-171a-b02a-357f-04da917299b2@amd.com>
 <560b466b-bfc0-40cc-9af9-6b8830b712ce@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <fc111591-fbf8-87c3-f39b-e1f840308913@amd.com>
Date: Thu, 8 May 2025 17:06:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <560b466b-bfc0-40cc-9af9-6b8830b712ce@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0110.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::11) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: f707de98-6a61-410c-15fb-08dd8e2492ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0FhSWVxakZ2eVlRZ0VabnR0Tm1zdS93MEJFT09rRjR5VUtEaXlvOWhCY0Qy?=
 =?utf-8?B?TmJoMmtmWFR0TnNadC93MG40M28rU1B0VExJZjRmVUVKMm1kengwMFlqWXdT?=
 =?utf-8?B?UnlIMDZDeU5ZT0hQQzRyek82Qy9yaUlzOHhtN3JUZGtOZ2Q5MTNoeDMyL0lC?=
 =?utf-8?B?VkdIN2h2NThnQ3dIbWRtejhPaWhsVVRPRUl4dEFwNWhDWDIyQUtWTURxbk5l?=
 =?utf-8?B?dWxESUlzOXN6NHBOOWNuQ2VYNm44QjVqdUNLN0s5bGhScHdjamMxNnJWeStR?=
 =?utf-8?B?ZDc5TlJuTUdvTllDaFc2V1dqZmpQYjRLYklDZEV3ZEw3TWIySHd3Y3Rja3hD?=
 =?utf-8?B?dXFObGRsUUxGM2lqTHBFTmFpemhiU2I0ejZySzE2V2czMVV0THFOMFV3dE1H?=
 =?utf-8?B?S01MRXFadDR0ZFBwcVlQdUpFeU5CS2tJa1BleUdxVnlwazgvS2NEUmNJRVBP?=
 =?utf-8?B?NnJPcE5KdkF1ckFLSGM5V3g5a0dYaUZ6bE9WMkNYaHQ1ck0vMnRrbWZCdmN0?=
 =?utf-8?B?OTV0NnhFM2NuNlJ4cmlzYnh2K2lMckZUYTV2eTNFSWx3aDJVbGQwdUlGVWpY?=
 =?utf-8?B?ZlNJYWJtS2tCNWo4SU82N3lOejAyM3g4N2pmTFd2eXp3RlkxQmtEdHdUcGlD?=
 =?utf-8?B?bjFPNU9RNjJQa25VeEFUQUtrVW4rbWdJRk5wQXRLNUE4Z0djVCtBbzZaZmNL?=
 =?utf-8?B?aVFON2U0L0Y1aXVweTdUT3FRdDJ2ejg0OGhQTHFKSzBqRkEzYmVqaUQ0bUR5?=
 =?utf-8?B?SnRYYzV1S3VoT2dSMmJuY25IbjVFTS9LYkpybzNJYjJObDhuUGxrbml2TVkv?=
 =?utf-8?B?MTB6TG56Zzd0RmpEV1NZSTRwNkRTR28vdzBZQ3psOEMyc0tsWDZjVXNXNWlM?=
 =?utf-8?B?dVFhTGRGdE1RNXBGNlpzblpGS0RUUlp5MStYSHMyMVhtWkNCdnFuR1NkQ01Z?=
 =?utf-8?B?VElTZ2hLNzBzMUNtQzVjdWQzUUpLZ0Izdlh1VWUzMVdYQXRndGpMcGxzN2dS?=
 =?utf-8?B?bFJNRUxheDZhQ2lWYUw4aFdiYUd6UEVjZ0h6cG8vREJObXhUOURhd2xHenBG?=
 =?utf-8?B?aGF1MmR0ZUU2YVVmQTZRZmVQZTZhaThwYzJMTTdSN0JGK2dGNjQvdGtlaDRJ?=
 =?utf-8?B?RFJUSTRRQ2NIUDlWRVhZcXRFa3RHQmdKTDRFMlp0L2paV1NhRFdSUzBQNDY1?=
 =?utf-8?B?MitnMnNBamdKM2p6QTNZUml5VGNQS3JVeWlzY2x3SnpPeGtoM01nTTB2aWlq?=
 =?utf-8?B?UzJ2NmdpT2JJcWlNNVdFeUFoZlNuOTlFNmdTazc1ek1pdE9keU4yeUd2dDJy?=
 =?utf-8?B?enVGeDVIUDhWcmYrOVZKSGxHWEZyQkdLUGJmT2ZiQ1B4eHpQeFY1eFpCVlo2?=
 =?utf-8?B?M2RpMGE5a0ZHd3NUZWdrNkpXaUVBV3BFdUt6QWZwZkNoeG9JS0V1NGpIcElo?=
 =?utf-8?B?RHN4aXFkc291Z3hQTTVwV0RHUXJRZzZjV2VYbDczaVB1dGtENVhKdldXV0NO?=
 =?utf-8?B?cGVWVUZzWW5MazFTT3F5UlZ5N0w2VWpTUFRkN0tnQmFWbGtON3VTcDl0Z0Jm?=
 =?utf-8?B?S3IwekJwQWc5d1NJc2VScUF4N2xVVXNyVHpSV3R0aGFTSWFoS1FIakR3eFRy?=
 =?utf-8?B?SXVhVGswZVQrNFIxc3FqZm9Eb2J2eUZMclFlaGY4RWtXTk9mTVpQSzRWTDhK?=
 =?utf-8?B?eTYrbERza29BZEpWZWVmVjh2SFo4SlZPbHA0T3BHZnpRUk1vNWZxRmVSY2Ez?=
 =?utf-8?B?N2lTWWh4eng1aTZ4VkM4cnB1Ukt6S3VaSzU5cklHQkpIajRTWjJNcEdGSWFX?=
 =?utf-8?B?VUxzVy90djdVWmZ1TWVlbDhncDlsSlBUWERWenpOTkM5ZGFsbmJ3SkRGUlFK?=
 =?utf-8?B?VFh5NWVWSE5PQVhCSEZUMWdmS3ZLTk56SDdJU1k1d21DSUpOT042dStwMS9m?=
 =?utf-8?Q?t2UR3zpgw2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdIdzRSMk9mQU9wemxXNzVGbEgwZnhaWnhOcTFrZHBneUk5ZnpQQmc4QTIz?=
 =?utf-8?B?cWlCeWNlWXJpTEdjUVRqZEF4NFNtMEc0N2RtRmJ2MnYrcGoraWR1VHRHTDhJ?=
 =?utf-8?B?LzlTWFBZSThPZkFibXBYWVFJczN0NnlHekF4V2NacHdaS1dlNlpucjBKT0pa?=
 =?utf-8?B?OW9ZMnlPRnYreldpM00zSnoyWEFHUDlJVEtuajhhTHFjWjlnMS9KWTR3UDlo?=
 =?utf-8?B?ZG9LdklYUzZkdmZ5NTJSckI5UVRSeFNUNWVSam5DY0lqVDcrQjMxQU9oTGNN?=
 =?utf-8?B?L3Z2NkRvR0VGYTFjQ2dqR0VoaXJqc3lpOXBiWktNSjF1Y1E4dXVyMStpODJH?=
 =?utf-8?B?bG8rbG1YeGUzQ25MU0Fqekl3NzBMdDd3dUNLS3pRVDFFRWJQVHlTRFhQeFBY?=
 =?utf-8?B?WmM0aGw4RDlQOTZQUm14TVoybmpTWjk4NE02YkFLOFl2RGFSdjVGMCtCYVN3?=
 =?utf-8?B?ZU5CdSttUW03cUg0RWVMbTRibGZ3RzlQSEoxTit5VXNkc2NsaFFxblhiODJx?=
 =?utf-8?B?SmJnTWhncVVFak9IcWh5cDVDNC94cy93STdaeTQ5dlFnUjl6WDRXOEkvWFE4?=
 =?utf-8?B?dXFLUmhrRUQ0Vk5wdGk4aUR5cEs0eThkcDg3TUlRQ2EwZDhQeWR3N1ovUVFG?=
 =?utf-8?B?YWlCbmRxcU9sZ2F4ejVWMnFQSFRGRkRTSFJzMzkzaW9QQStmQlB1UWtldlJ2?=
 =?utf-8?B?VktwcTZhNWhFc1h5UjlXL3UrVFVpT2JpN2N5bjY5Z3IxNDNITDFxTDNNRWJS?=
 =?utf-8?B?MWZWK0ppUWlFbU1DVXFYdTZWWU0zdnZpQWtZUE81ci9MSlNkc2gwM21zTlVZ?=
 =?utf-8?B?K2FnUm5xcmlFWnpmRGI4czQ5cFFOY2V1TGYydnVnMzNMeTZlbHZmWUVhQ21S?=
 =?utf-8?B?bHErM2xMQU1sdEs0aG9wRC85MkZHUGdJQlVpTTNQM25mdnhDSERnaTIvYytB?=
 =?utf-8?B?bjRMRWJsTTlFTWZlMkQyb1p6N0NQN3oxMlBzbWxCNnBtKzd5NkpEYjdRY3Vz?=
 =?utf-8?B?MWtVMmQ4RDZ6dTc5ZjY1YW1mNlllb1FnNms2RVg3TzJyaEVFZTkvcC9wR0VV?=
 =?utf-8?B?bmFJT0E5ZEpGY0dWd0J6TkdqOU5meTFuL1VTd3M4ZDlwSUdLckVTWE0xUlpq?=
 =?utf-8?B?MVkyRWF5SDRDR3pHY2o1eUNaSUIxcVdvMG91ZnNHYjVkVGRqenRpbmo1cGVo?=
 =?utf-8?B?YytnZWJqVnhxdlUrSDZLcTkva2FkMTFDTUEvUUZLcGo5dXJtNFZkWDJNaENj?=
 =?utf-8?B?QXhWY0R5RzErS0l5OGIzRnBOaEdSeGpPb1VPeCtNMDJBQlpFRENORDhUT29W?=
 =?utf-8?B?RFdpQUd5U0xzcEtpcmlxakIyMjJ0UG9PTkZmYml6MFpVZ1NrVjEyZXpRWlM4?=
 =?utf-8?B?d0pKdDg1VzE3TEY5M01lWW11azVLTjd6VjQ2SFlFKytNeWZacHBHUGxka2pK?=
 =?utf-8?B?ZEJ0Ym1SRUtPNU0xWUx6VWFOdXhOY3E5bHA3bWZGam5ad1NseUhyT2FWRUlG?=
 =?utf-8?B?ZitSUGt3VHVWNytKYkY1OEJiN1VWUThTcmtaZWZRNmlWMDhkajQrc2M0QnlO?=
 =?utf-8?B?WWR2ZTFGcjJOaEt3QW9rZUZtNG5QVEE2VW44TklaNUozNVlzVmo5eGk5NG5B?=
 =?utf-8?B?WURzbi8vQmlFSEZEQlB6aFhQTkxMaDIyVDZYNWt5SVdtVVh6emFQMmhna24w?=
 =?utf-8?B?RjRsVStXcFNrdFpvcXU3ak5OQkdCSlg0N05ycTBDOXh3bEVDMDNjNDRic3Nx?=
 =?utf-8?B?ZUZpNTUxRkFFZ1o4aUNaWVBwRUVLbmgxVVdSRHNWV20xSHJnU3crMEhTL1Nn?=
 =?utf-8?B?QlAxQkdpS3cvT0FDNVkzTmtYSWZpRVNsR1VIVTkvQWdzaCszdWlidlZ0SkRS?=
 =?utf-8?B?NkxwcWNvZU5NLzNxYnVpRFgvNHFZM0hDQnN5TENXWGY4eWVnUlZiVGpwNDlt?=
 =?utf-8?B?ZE1sRmRMN2lWWXV4OE8raHFucVNLcFdVdzg1UllJdVBrQmRwVkR5eHUvazZk?=
 =?utf-8?B?OGp5b2hodlZsUEIySkMxZ2ZEY0RUa3ZXcWFKV0NOVVd2OHY3ZVhVR3hyQUpi?=
 =?utf-8?B?VkNiWE5UbVA4SmhiRml0R3pLRE05eUk1SDdkeDFHL3FIZklQbW4rZHJxcmJH?=
 =?utf-8?Q?pC0Zoxi77brTno4c24Y9a6JSX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f707de98-6a61-410c-15fb-08dd8e2492ae
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:36:29.0488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gj84yIkrMN1O58ugS5YmEFQCEfmU6yLeYOfZI3ZjG/wJkOrtfSV3+OcecxHesKk7DbTQze0WOri1NltpfeB2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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


On 5/8/2025 2:52 PM, Christian König wrote:
> On 5/8/25 07:04, Yadav, Arvind wrote:
>> On 5/8/2025 12:36 AM, Alex Deucher wrote:
>>> On Wed, May 7, 2025 at 2:38 PM Arvind Yadav <Arvind.Yadav@amd.com> wrote:
>>>> Switch cancel_delayed_work() to cancel_delayed_work_sync() to ensure
>>>> the delayed work has finished executing before proceeding with
>>>> resource cleanup. This prevents a potential use-after-free or
>>>> NULL dereference if the resume_work is still running during finalization.
>>> There are several other places with similar patterns that look
>>> suspect.  E.g., amdgpu_userq_destroy() and amdgpu_userq_evict().
>> Noted, I will do the changes.
> Also keep an eye open for lockdep error, e.g. compile the kernel with lockdep enabled and make sure that the code flow is executed at least once.
>
> Apart from that good catch,
> Christian.
Sure, I will take care of this.
~arvind
>> ~arvind
>>> Alex
>>>
>>>> BUG: kernel NULL pointer dereference, address: 0000000000000140
>>>> [  +0.000050] #PF: supervisor read access in kernel mode
>>>> [  +0.000019] #PF: error_code(0x0000) - not-present page
>>>> [  +0.000021] PGD 0 P4D 0
>>>> [  +0.000015] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>> [  +0.000021] CPU: 17 UID: 0 PID: 196299 Comm: kworker/17:0 Tainted: G     U             6.14.0-org-staging #1
>>>> [  +0.000032] Tainted: [U]=USER
>>>> [  +0.000015] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F39 03/22/2024
>>>> [  +0.000029] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>>>> [  +0.000426] RIP: 0010:drm_exec_lock_obj+0x32/0x210 [drm_exec]
>>>> [  +0.000025] Code: e5 41 57 41 56 41 55 49 89 f5 41 54 49 89 fc 48 83 ec 08 4c 8b 77 30 4d 85 f6 0f 85 c0 00 00 00 4c 8d 7f 08 48 39 77 38 74 54 <49> 8b bd f8 00 00 00 4c 89 fe 41 f6 04 24 01 75 3c e8 08 50 bc e0
>>>> [  +0.000046] RSP: 0018:ffffab1b04da3ce8 EFLAGS: 00010297
>>>> [  +0.000020] RAX: 0000000000000001 RBX: ffff930cc60e4bc0 RCX: 0000000000000000
>>>> [  +0.000025] RDX: 0000000000000004 RSI: 0000000000000048 RDI: ffffab1b04da3d88
>>>> [  +0.000028] RBP: ffffab1b04da3d10 R08: ffff930cc60e4000 R09: 0000000000000000
>>>> [  +0.000022] R10: ffffab1b04da3d18 R11: 0000000000000001 R12: ffffab1b04da3d88
>>>> [  +0.000023] R13: 0000000000000048 R14: 0000000000000000 R15: ffffab1b04da3d90
>>>> [  +0.000023] FS:  0000000000000000(0000) GS:ffff9313dea80000(0000) knlGS:0000000000000000
>>>> [  +0.000024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  +0.000021] CR2: 0000000000000140 CR3: 000000018351a000 CR4: 0000000000350ef0
>>>> [  +0.000025] Call Trace:
>>>> [  +0.000018]  <TASK>
>>>> [  +0.000015]  ? show_regs+0x69/0x80
>>>> [  +0.000022]  ? __die+0x25/0x70
>>>> [  +0.000019]  ? page_fault_oops+0x15d/0x510
>>>> [  +0.000024]  ? do_user_addr_fault+0x312/0x690
>>>> [  +0.000024]  ? sched_clock_cpu+0x10/0x1a0
>>>> [  +0.000028]  ? exc_page_fault+0x78/0x1b0
>>>> [  +0.000025]  ? asm_exc_page_fault+0x27/0x30
>>>> [  +0.000024]  ? drm_exec_lock_obj+0x32/0x210 [drm_exec]
>>>> [  +0.000024]  drm_exec_prepare_obj+0x21/0x60 [drm_exec]
>>>> [  +0.000021]  amdgpu_vm_lock_pd+0x22/0x30 [amdgpu]
>>>> [  +0.000266]  amdgpu_userq_validate_bos+0x6c/0x320 [amdgpu]
>>>> [  +0.000333]  amdgpu_userq_restore_worker+0x4a/0x120 [amdgpu]
>>>> [  +0.000316]  process_one_work+0x189/0x3c0
>>>> [  +0.000021]  worker_thread+0x2a4/0x3b0
>>>> [  +0.000022]  kthread+0x109/0x220
>>>> [  +0.000018]  ? __pfx_worker_thread+0x10/0x10
>>>> [  +0.000779]  ? _raw_spin_unlock_irq+0x1f/0x40
>>>> [  +0.000560]  ? __pfx_kthread+0x10/0x10
>>>> [  +0.000543]  ret_from_fork+0x3c/0x60
>>>> [  +0.000507]  ? __pfx_kthread+0x10/0x10
>>>> [  +0.000515]  ret_from_fork_asm+0x1a/0x30
>>>> [  +0.000515]  </TASK>
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index afbe01149ed3..711e190a6a82 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>>           struct amdgpu_userq_mgr *uqm, *tmp;
>>>>           uint32_t queue_id;
>>>>
>>>> -       cancel_delayed_work(&userq_mgr->resume_work);
>>>> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
>>>>
>>>>           mutex_lock(&userq_mgr->userq_mutex);
>>>>           idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>>>> -- 
>>>> 2.34.1
>>>>
