Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE76CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B6310E77C;
	Tue,  9 Sep 2025 15:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4o0jT0w";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B54610E77C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxK6rs8VOIq5/qZ8QekzUImKmX40d5ramw9FlkOrmsYMlhnM/abJCoCLkkdvwc6Gm3pmzwOgUcRdTe6IgJGOD8DgrE5WrTEzF/7VnzMzz2wuWFggPSAPg+d94bwzAsBNBlrrfAb0L3ByihqiKLyJCJ27xOzif6OyZd6BsgD5mi0uCnk9OMxvXotHWfRPoBseGAeZndzBa+MMSwwZP156ZaI5/sX4L+slG/eG6jntkNrH/nwFbWQT5A1wjpQX0Dw1xtvosRi2xcSSt9Wx6eE7dM0oIClT+RkLD4Q+e1GiBaO9cZ55lENrMdjgo7Y2ZESzh2o8IAFFQd7JuKJHNyAAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKi01OzjJDF6i6m+tmHHmWJ421Af2SJ5DtTW1is14KY=;
 b=Z/94DkN0L12IwlMLjzM6VwSG7SP7e7wPY3QiYZfrfx6pTrps7DIJWJK+ef1oqJXWLmG9D8Gr5Ufggc3WISIyK77Xo73xNp7gg5aq97yJGVeg+bqIwgouVtSMYl0OTxzd4xhZ5NVsIov+lHLwsPrdr116fHQG10UmtmajSJ8BRHd+u7C2x5RU5CNYql3k+h7VfmTPyp+aTtaBpI8Ei+cggjbpdlR4a9f1f/ACdjYVHAc1Gwhyg8mLLboeP5cm47pHksHhNUgZ3hy8tzEqtBykglPiN5lA6HTQpzOmVFtICn4ogi2hl7DbYlhRHYmhJQhoxIMwRNvIcCzNHn4TZu6ppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKi01OzjJDF6i6m+tmHHmWJ421Af2SJ5DtTW1is14KY=;
 b=Z4o0jT0wBaU89HlAiEbR2bEGvZg5LX/NLDvqxPVzX0I70Mhahz5Wrnt5oSS5UOcWZXvI2/HT3elw5yBdtIFQJlKTOSGbG70Yj3HM3MI1c2XfTPKHC8tJA2irdd4mcxUIrPuQvOIPuzwFLQSxDjE1Rh1JPyvEZ6HP8z0ZUssjx4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:21:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:21:06 +0000
Message-ID: <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
Date: Tue, 9 Sep 2025 17:21:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250909144937.22452-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe38ed-fcac-421a-64b0-08ddefb47ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW83L1dZazA3eUZyem5Iai9CcFgxYWxJWU8ySlU1OHZJQS9SbzJWRlRuQ1da?=
 =?utf-8?B?SVQxUEdzS3dLMlIwZGVENFpJNm11Z3oxNjVoTTJLOXpQY0xob3Q0UStOQzlD?=
 =?utf-8?B?RVVGU0gzd215UG5uNWswcEFGc2FiU2RXblB6aVFMWndtZWJHQytLTm9Tcndi?=
 =?utf-8?B?UEJUOXZHWGVwcHY3a3Q0UjNjSm1NZHVQQ25xZnZsRUNMVnZiUHRKWHNsK1pB?=
 =?utf-8?B?K2lCQWFLWEo2RjQ0dnQybysxZEFqT3NSQzNqd3Y5WEpuaEwyQzA0VFdoMFpy?=
 =?utf-8?B?TGN1ZDlIaFZETkVMVkFIekpkTlppcWg3N2pBb3VYeXJ3VW9TekR6T0tuMzRa?=
 =?utf-8?B?cVorTmVRRThWNElXaXoyTFQrYk5ZbXBYQmNoQ1N1Ulprc0RpY1ZYUDBodDly?=
 =?utf-8?B?dndCT2pmOW5tVDRBZDdGcGhzWnl2WmNRU2RlNllNVTFXVEtZdUI4RFJMejl3?=
 =?utf-8?B?cG55WFM2NGUxc3pqb1lPbWZYNWxoN1VyY3hLSThPUTBnOUVTdzlmc01tcTFr?=
 =?utf-8?B?eHhkZDlGN3NKeGRTTFN6Y3ZVcDJMWnRBMG9mdC93R2lMSHZaRFlOdTR2MEpP?=
 =?utf-8?B?VVh5TlNEZ3B2VzBUa1d5b1hodzIzRHJZRDRyMGFlTUZHSmlpeFVEQ2p2SE5P?=
 =?utf-8?B?citqUXAzM2RuaDRodHFLRHg5RFBYL2I3elVGVjB3T0x5OFVUV3drbC9vdDVl?=
 =?utf-8?B?TXVWTUppcEs4VHdEeUtFbzdtZzNQK0lwSS9aVUphRUR2T3RlT0YvbHpCM2oz?=
 =?utf-8?B?L2Rpd1phSWU0c3RZNlBNNjgzNzhOd1JYcExTdm9rbHcwTXNCSDllemdSbTZp?=
 =?utf-8?B?Mld2RkpvVTAvS0ZLVkRYVWpSM0pWWUxzeGQrU3BjQUVhdlY0ajdENmxOUGZD?=
 =?utf-8?B?SDhIMy90TVpra0FBYWZJbVRTK25MVk82cm5FWDF0bVUwSmJEMVQ0Q1BPenNw?=
 =?utf-8?B?bmdIN1YzaGFtbUVUcXpmZFI2OGdTMW5aaDRwUVZCdks5Z3JjT2FyYy9IV3hW?=
 =?utf-8?B?ZnprSTFtbjdGNU9tUDNsRXQxQkhxQm5ubzliUUhDZWZ6MFJlaTdtaGlmeTA2?=
 =?utf-8?B?bTNxNG9YTWpoUTFDYTdyUmZKOUc5QVV5cmRIdTY4RnNVSHlEdHBndkpKTkVC?=
 =?utf-8?B?Ny9nT3JrZXFQV0JLaU9lWHY5ZitrSUxHMVpEcnhUeVZLUFBHTWxmUzdUQ2F3?=
 =?utf-8?B?dU9aS0NOZWxmd2ZUK2ZZTkpiakZnTUZxZ3N5cFlRSFBzK3I0TnNJZ3UrZ0k3?=
 =?utf-8?B?ODZuMmNlWXgwRFprajNnWW1qQVBRaytLWDF3L2tjNEk2VURKQnMrUGFMeitu?=
 =?utf-8?B?aDZ6bllzMndnRGcyOTRxb3dGNTErSXgyOTJOVEs5Y3FoNjJYeHhqUmtzM1BM?=
 =?utf-8?B?Zk83WHBSWkZmbmZMbjV4S1BnMnpvYWR2Wk9NN3FuS0huVTJmM0VwMjFoVmpZ?=
 =?utf-8?B?Qk1KamRTVy9Wbk9uSTVXWVBrTDh4YWNSNGNHUUg4ZkE1QTg1TWZmVXBrNG1T?=
 =?utf-8?B?ampZQWN5Tmw4S1cvcm9oQm5BTjJXWW1SaDFOVDVpaDR2cDJ4SlpOUUdEM2xn?=
 =?utf-8?B?VGFCUDluWERNQWpYc1A0K0JidHRmQ0J6TUFhS0traElUdXhxTFpFNks2SGtw?=
 =?utf-8?B?NGRyMkVIREZJMkx5ZlRvd1VCakVSbGpuaTFYZkNocnp3UGNadktqVGdxa3VR?=
 =?utf-8?B?b2srM3RGSG5WTkdjTnZTU3EwbUZmczVXR0twV1J6eDVtdXNnUE41bEpKcHhD?=
 =?utf-8?B?QU91S09jZEZxNGxOTmE1RXRFZGFTT0pFL0YvdU5xWHJOWlhzdVdVbUVuMllk?=
 =?utf-8?B?YzU0N3RLc2E0dDJkMFJjclBrWW9PZHlsazhGa0xQbVJvUTQxVEszQm5rUGJN?=
 =?utf-8?B?UzRQS0lwaU90azRla3JVM3hxSmJTT1MrTUZ3RWp6NkRkNEsrRktyQ0wzU0dN?=
 =?utf-8?Q?dBBdeC3uVoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJrclI2dlR0WVduRHFjNDM2clpBQWd2NC8xekppUnVLdHR6SFQvaU1uSDNn?=
 =?utf-8?B?QnpvZTdiSXZWUUlaTjBKRWwyZmpwL05YTlMvUTJvRzNWcVBCVjgzWGFUSXRY?=
 =?utf-8?B?WXE5MWY0UEVlNjdEWlNjVjZ2bXQxTHdhZXVwbmNDbDJpRUR2V24rbDZNVXpk?=
 =?utf-8?B?UkxXQjU1cWxZUk5aR1paR0RmdHhic25FYi9JKzcvajR6SWxIWjhNNGhKZzNx?=
 =?utf-8?B?UkdCM1lYaUNzU0o2MUxBakFnOWR1SEROTnpjNHBzeTF6c0RyQmRGTmdXRnNt?=
 =?utf-8?B?Nm1KejlNbjNWSjRWK1VjYUdCSTZoWTFZVjdFeThKc3hzdlRHelc2NnVmRGhZ?=
 =?utf-8?B?NmlaY2tTak13UGF2NFlDcTRuZTFjRW1WWWM3azVINWNybW9KY0N6aWV3amMx?=
 =?utf-8?B?Zjc0VVdaSDhTTTF4bUlKRWFsZDY2L0ZjNmZCRng3WGtXdjFFVUlDbWdEQmRM?=
 =?utf-8?B?ajBvSnNVUlUvOG1PUXdGVkRuK3RNYm5PRUFjUThWMWNVREtpTlRieWhUdmRh?=
 =?utf-8?B?dlkxNm1NK0pIbmtpeDFHR1pJVjdoK3o5YXhKYzVRQ05rUFVFU2lEOWRqUGFm?=
 =?utf-8?B?VmVmRmRIUmtQbVhKQ045OFR3WHdXOFdpclZwQTNINVdZNHprSEJyWWFMMkxW?=
 =?utf-8?B?WWY0Y1FYcEZwSlJWNTNrWklUN3VHaWEwSlJhSERodEtHdE1vdTcrVGF3bEgr?=
 =?utf-8?B?R2VKdkJpNDJxZERwVllCaVJJTDRHbEx0NXJPbHlPZXpsdmFJSTJnWXdKamtX?=
 =?utf-8?B?SXhlWTl3TTlVWFlDSnEwekdSZkF5TExHcmoxYlgrbVRhTitwRFVSSVhoWThY?=
 =?utf-8?B?UzBBUWhrQU56UHpGeTZJdHVaNllUdVNSSWZtcmNhQThnSThINDVROG9NSFA1?=
 =?utf-8?B?OGIvdXJRTWVqNkJSUWFnTnorcGRBU2tNVDNCbWlHK2lXeHc4WVNnbzhJWHNz?=
 =?utf-8?B?OUx4TXpVMVVQSzFqQktHeFI3UFcyY1NwNUp2bTJxSTNGYW9EaW1sNUFrSnNo?=
 =?utf-8?B?eE5rdXdNTmtFQW1CSlhFN0ZQd2g2ZU5UVU5NSHduV2lhODhocm51WmVpUnJy?=
 =?utf-8?B?SjIxVldHSXIvVTBVTEJ4MnpzQVAxelpPQzd2SGlCblV4OWpxT0grUFlPSTVx?=
 =?utf-8?B?VVByZGFHK2FNOEF6djRTVU4rcnZEdjFQdWtLL2Q2NmdhNHNlRU5rVEkzaUl2?=
 =?utf-8?B?bWNaZ1NjSWw3MjV6RTBjNWg1MWhEVzNNejZMK0trOE5WNGN5bGF3N2lBM3BJ?=
 =?utf-8?B?VEJCU3hVN1lZQ08yUHBESkVEZVByamFyTlZCU2tEcEt4b2FFc0lHRzE2dFlj?=
 =?utf-8?B?VGRuUGNnVTVFSkpzcGgzNmlXc1dYT1RWMzdRbzdSdGdkQW51TjdPRUZyTFVG?=
 =?utf-8?B?cFYvOHB5Z3ErUDZNOHVyZHYrNUpiOG1wL1A2KzlMRGFxYmVGcC8rQ1pGNk9L?=
 =?utf-8?B?Qlk1N29zSGVWZ01Qd2VtNWpyakhsQjR4NC9sWEVLcTRBbzZSQ1BHN2daV1JD?=
 =?utf-8?B?eTk2c0xVb2xYZS9nRS82L2RDVUEzQjIvVUdMMUFQa3F4SHdQNGtrM05STHl4?=
 =?utf-8?B?S29FSmtiYTF2V3hlVTZPMTZ2enREQWlFcHYrRkt6U0JVbkkyallXSHVEWXVw?=
 =?utf-8?B?QW4rSTV3ODVQTk5oaTVFSGtKblI2cWNTM1ZRWEIwT3Z1a1FWa0JsQXNXZ0RX?=
 =?utf-8?B?cFpibHdzYkMrYTEvb2VMZldMUFJwWFI5VlNMZmZtbzl3Y24rVkJKdjBzSk9P?=
 =?utf-8?B?cUk5QnJYSmtJZHE3U3BlNmZHWm05alo5ZEVseGdvcXFxVUZ0eXBjWUg4Z2k3?=
 =?utf-8?B?cEdjREF5NzRiZTFJZ082V0MvQ2tYSy8yOW92aG9rc0lJd1Z2Y05HbkgycjVo?=
 =?utf-8?B?UzNpMmQybmswQWlGWmVYYmhkV1ZHaFpuaEk5eDIxT0pMV3Y1QVhRMDhDb2ZG?=
 =?utf-8?B?eVRFNUZMRklXRnpKbklsTzhPTkh1Z2VOR1QwbFdlNG1pck9tbCtSSWZQa2k1?=
 =?utf-8?B?dVRJZStnZVoxdXpLTHdwaVpaVk56aGY0OUNvWExyODJjbTJpak0yZDBBVjlu?=
 =?utf-8?B?V25XT2kySDdEOGNqaXUwZjkwZzZDb2JXbVNnSTJyNnl3eUZhZGh6bUFNbDJr?=
 =?utf-8?Q?HE1b80Xjy3TC2kpFIs9p+Cchp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe38ed-fcac-421a-64b0-08ddefb47ed9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:21:06.0874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN2H1G/XLfd9gYJItGXa3HPYfqP++Rvn+wNLen33vkOllN7jOQeDgLpCCyAB6n/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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

On 09.09.25 16:49, Timur Kristóf wrote:
> SDMA v3-v5 can copy almost 4 MiB in a single copy operation.
> Use the	same value as PAL and Mesa for copy_max_bytes.
> 
> For reference, see oss2DmaCmdBuffer.cpp	in PAL:
> "Due to HW limitation, the maximum count may not be 2^n-1,
> can only be 2^n - 1 - start_addr[4:2]"

Ah! In this case the value the kernel uses is actually correct.

The difference is that the kernel never has start_addr[4:2] != 0 for anything larger than PAGE_SIZE while for PAL and Mesa that can happen.

> See also sid.h in Mesa:
> "There is apparently an undocumented HW limitation that
> prevents the HW from copying the last 255 bytes of (1 << 22) - 1"

That is actually pretty well documented and makes perfect sense. For unaligned start or dst addresses the SDMA needs to use an internal bounce buffer. That's where the limit comes from.

Not sure if we should apply that patch or not, it probably doesn't make any difference in practice.

> Fixes: dfe5c2b76b2a ("drm/amdgpu: Correct bytes limit for SDMA 3.0 copy and fill")

Even when we apply it I think we should drop that, the value the kernel uses is correct.

Regards,
Christian.

> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 1c076bd1cf73..9302cf0b5e4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1659,11 +1659,11 @@ static void sdma_v3_0_emit_fill_buffer(struct amdgpu_ib *ib,
>  }
>  
>  static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
> -	.copy_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
> +	.copy_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
>  	.copy_num_dw = 7,
>  	.emit_copy_buffer = sdma_v3_0_emit_copy_buffer,
>  
> -	.fill_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
> +	.fill_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
>  	.fill_num_dw = 5,
>  	.emit_fill_buffer = sdma_v3_0_emit_fill_buffer,
>  };

