Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A86AC27C52
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 08:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C2010E42C;
	Tue,  4 Jun 2024 08:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYiI+X9c";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769FB10E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 08:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuVS4Mz3T6iMvcDsdTpRc98aGZxSQ8o/o0p5lKfEKmR0ylpdvkmU6prz6SC94QUd3VilkbI0GrDyoG1gmqq3WP5SDnlkfCgDadU09NzS3o/thy8QBO3KwMqtJMovnjNiGChWTfx1ua42OqGQhCwlkxMYqOO1r7bAGIkbeRIJX4Rmr36e44YgpKh4NOBQIuiWoPnmahCZOt6WYutiISG148IKakVYJZ2X6D49E/hX0rQy08tS2EopR9g6UwMkJ0YLJupO7/odKS+G3+yBQ6nBzZ8XobRvsNYRxr6XWekV+kMP2/QyfF0NOq48zG6vbsVOxpqumaNtFtC34gm6PkA9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nipisv5EdleGADvniudCaPFN/zZzzgbzWlQN+KFHK+s=;
 b=Fk7T8HqSa/Y9Q5OKT4S8Qe4u0uD3VcDYRWakNBlp/z3q5XyQBGsd6+P6yrrgb0g5P+UJFQEPOMNcoQnOTPR+Lv58iULomc7G+ocQYoBJz68iKCSOGqICCEehp62ah0ALtShKaLdb5rfhI6ed/M9UTtgQV8Tut5JGcR0nPmxm3a08+N/dhPKc43EosG+aZK3VFkqMqsmPGhnttXcmY2SSWUwwXSal/jdaw2vc/cdpuqhNBNdLoe6rLlBjHu3MZNW3DnawV4l20uWs6Yz5/5/Ft4eqCEah1/V9a9F1BE0h/pD0zmxGnr2WdeEv1Gk32J0FnHno4nFSpN+o11tlGPfqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nipisv5EdleGADvniudCaPFN/zZzzgbzWlQN+KFHK+s=;
 b=EYiI+X9chz6MomfKq//iPMQCGpfAt5fO5TeuzGpeQOgB63al+/d0hCSWpG6w5yR2ssbhYerxRCHwDdCfa5WrBisfZLImCRZ5NUwmLw+iTmGvgdHyWKr6tPGhuvlaJdLUKpbcd/hz5ynuvfMwMQHw1ulg4V8LIPT5lnUtyps4DiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 08:07:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Tue, 4 Jun 2024
 08:07:24 +0000
Message-ID: <a33dd3d0-c615-443b-8b97-bb08f176136a@amd.com>
Date: Tue, 4 Jun 2024 10:07:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Xiao, Hua" <Hua.Xiao@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
 <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <ab92ab3e-b96b-480e-8089-b3949f453bd3@gmail.com>
 <CH0PR12MB53721A7C3403982035E48639F4FC2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <380c4bd1-ab50-4f42-bb50-69dc0fbd28fe@amd.com>
 <CH0PR12MB53721EB64869BF3260CE095DF4FF2@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH0PR12MB53721EB64869BF3260CE095DF4FF2@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a045ff-859d-4158-006a-08dc846d5df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVYyK2xlMmtjWGhqcFVSSGtmVE5SK3AwaDVJeTlpb0xpa3Z3MHBVSTBCNGNK?=
 =?utf-8?B?U1l5UFVmbnZBZVFuQzVRTkxVeWJtZGhFUnVtamJTVXBiOFgxb25nTUVJVDl2?=
 =?utf-8?B?Z29VOWtsWTQydVprTllhSXRCOWFRS0FqalFGREZvR0tMMllpTE4xamdWOGc0?=
 =?utf-8?B?aFhzSi8zemFJT3JsY1RhNllSQ2ZvdlJIa3NURStaQjJzelBoalc0MVFETmRQ?=
 =?utf-8?B?VUZLSm9tZzNKUmpHT3Fyd1ZTUkpMekdqUFZDME1HK2dyZDJybEhUdjFTYkNL?=
 =?utf-8?B?OVFxZ2s5aThmVThvSGp4TG5Nc0dIa0pVc3VMTE9oa3JLTjdweUhtM2JXaWRI?=
 =?utf-8?B?b2EzejBXQi9rNERLR1U4d29oS3pyb09pQVE0TTR5YjJnNzJOWU94V1h0Nkho?=
 =?utf-8?B?b2xjTC9UZlh4YmtiWGtNQ2xWZGFOWGRIb1lFbWdHSEpZcHYreEp4bnR1RVZ5?=
 =?utf-8?B?WmJYSGdkaVFjVXVaSXh6UXMwcFdVdDlLYTZnb0k2bEpQZWJjZlZYTXlUaWkx?=
 =?utf-8?B?WjB6WWZHSjUwNmxJbDF2WkN6ZzdaeWVjSW9XN3c4ZS80ZUx3b3VzSWw4d3U4?=
 =?utf-8?B?cmpMeU85eXk1a2o0Vi9YUmV6YkREOEJSS1dzczJ6QzY3RkwwRGVWUVFGVm5z?=
 =?utf-8?B?cmhVOXJtS0krSUNHcDNBV1hVQk1YMGpZYjhsQnJmOE1Belc1R1NORmsvcHcx?=
 =?utf-8?B?WjcrM28rYzR4aC9kQnduUzVzanlWSVpHcXZjbjZDYllqc0FQMkZrVGJxWEJv?=
 =?utf-8?B?dXZxbEcyTE1UaU1wQ1p2SzZXbUp4bThvaWJuNEZBM0ZHUGhNOStWMmNUeUpi?=
 =?utf-8?B?ODRZdWc3VnRib0svRTM2ZUk3VysxWlcycWlsck1pL0RpK3dqazE0RnV3emQ5?=
 =?utf-8?B?RlhxTkprbmpjdjZpVk5mMHhvbVcwdTRMZXlUSVdLdjhmY2Z1WXFJYWpqSVdo?=
 =?utf-8?B?VllpbVBCdlR5M3BjeStOQStyWnVkOFZuRmZ0OVBDVkR0bDFWUXh3T3ljUmxO?=
 =?utf-8?B?ZURpRDdWS0NqMkdkSjRuSE8va0ZCMlB5M2pNM0paNXhCbjQ5LzMvMEhkbWpw?=
 =?utf-8?B?bDJTWWFOM2dqc0ZIMDlHWkpURmo4QkdJS3AwWUN3U0NseVhCNXZiZGhHa0w2?=
 =?utf-8?B?blNrUWRERDh0L1VVZjcwUHNFemNBcUdRV3dYZDdhMjdZaGRDb2RuKzBHVE0x?=
 =?utf-8?B?UHJZemdtRXhrZW5CZ09YRVZWQ09rUEtERHFJbHFnYzBKdC8rNC93Z2pONGVU?=
 =?utf-8?B?TGltejVxamFBNGlOSWVqbGUvc2tkdTlnN2RmVmxWSEpvcFZlRWl3TmllTzhF?=
 =?utf-8?B?bmtXNS90Q3pkZ1J4dHR2Q3VXN2NsaDhrTFNHRXpVSmZNZEwzbGVsNjJXa2xj?=
 =?utf-8?B?YVJFeHc1dDhvaG5HSnlWcDlkdkpzdklKaVZiT2ZuSmJUQ3lLRTV0cEExMEhG?=
 =?utf-8?B?UjNhQW1RNjV3OGZKditHdHVLR1lpcVB5Y1BFSHYzMEhiZ1V4VG1ZbThFSDB1?=
 =?utf-8?B?MDByR1BtVVc4dlNHL0Y4a3FzTGNJY3lCbEdhaGh3cUJqQkxTbWxGRllpUFRo?=
 =?utf-8?B?aDZLMDhueGwvZ2tVVURkSXZGWUViSWF0V0tpd2djVjZjbVNEU0pvRU0ybVBJ?=
 =?utf-8?B?RUdqdnJRQnRkMG5TYTViTjgyOWY4UFZkS3ZpamZGYUZZRVJ2WkE3KzFScGdW?=
 =?utf-8?B?bkwzelhlUmFLNkZSQmwrZEM0a2RIS1cwUTZ5SGRKbnozWWttbTZiR1dTaXBz?=
 =?utf-8?Q?g5VXchxFApPi4JUJ6vF83PCr4KADfbKHrj76NYi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmE2NmtNMHdiQ0FmeGNqaVdnMWNGNFcrUWFaamhzMUxEVnBZTTZMOCs0VjBo?=
 =?utf-8?B?MEY4MHFwVHJDalYrbkwwcXRhRmtRYXpqRDVBbFR1WCtPVXpGdE42QTgzbUlY?=
 =?utf-8?B?YzU3YTR2SGZMNzZQTDJCZVBydXBBdUR0c2lyRDd5UlVyZTNjWG1wWTJDZ0I2?=
 =?utf-8?B?VjlLSEQ3b0hWZ1JPRHRlRkZuNUx2a2RxKzJUeDFmSUF2YmxTUHNaaXQ4RWhk?=
 =?utf-8?B?MVJaQlI0YithSktnTkRsTmJzL2FVWWxtbjFhMGRINEZ2bS9PbEVFdFJKSzlK?=
 =?utf-8?B?SWZrYVpXTzJSbkpzTVZwRFNWeGNtUzVCZ2NjRXhBb1N0UWNHZFhlSEg5WWZT?=
 =?utf-8?B?RU15Mld1cjR0NFpSV1B3RUFrT2laNm5zTG5FL0NmL3RBa21mUTk0dHRjS01j?=
 =?utf-8?B?OTloY2VPVi9vVjNabG9LL1YwS3ZSU0UrMU9aV2xETVRVWlJPZ1ZuTGdzcHlG?=
 =?utf-8?B?bnJxaXFHbHdXVUdhR041Lzg3NVZiQW5YNHZjaDhQWlNIaE05VVNNU2lJdE1p?=
 =?utf-8?B?VFVNKzNFQzlIa2V5ZUp0bC9wWWtsN25jaDNjMHVWcDRyY1grM29nYUwzb1V6?=
 =?utf-8?B?bjM5cEloOTI1eW9JWm82bUNZQWRqK3ZRQzRkVXFwMHNYQkh4QlMyTjZlV0JG?=
 =?utf-8?B?OTNlZDg1MXR1aFNNVUtqT3d2N1JDWjA0ZlNkSjlObEsySjBJUFNVeTFGK2VO?=
 =?utf-8?B?L3dNeDVlZFNOZU9BaHViaDF0SmlxMnorVDZaZ3hzSWdrblA0emNDQWpMM2dQ?=
 =?utf-8?B?SVhySkdCdVhtZllDNTRmaEVXSVhpZUdmT3BPZGN0UXoyRWR1UUdUYXFZVUQy?=
 =?utf-8?B?WTBHNjNMbUJaaFMzQzhvVWp1dnNNNGJXWGJTcHFOWFF0RHpLNFlGREY5Tnd3?=
 =?utf-8?B?M3pyMGdJTXlsd1lvWk00dTZONXY4eklBdzZSTERXY0lDL21GREpVaVZHMjUr?=
 =?utf-8?B?dTdoZzZLaE51VktRMzlFTno1RnBHNm1oc3FGdmIzWlRZQjBYenAxeVBDaTRB?=
 =?utf-8?B?Q1JDNzhEcVFKMC9nMVN3Q1ozV2p1TEZDVHN6dzlwZXQvL3dxeU1vT01la3VJ?=
 =?utf-8?B?U3ZpNE1EUzdYa1JVVWpuU1hDeVJDaXVMQlVrQjhWbjliRG1Qckx0QkM0WkJF?=
 =?utf-8?B?ajRZc1RSWjZqOGZsbGp4UGplMmNmU3ZOWnUwNkEwbU8rRU1iVmMzVXFzREdr?=
 =?utf-8?B?NmJYNDdyZEwzRGtaYkFYWUJtclo3OE5wcDN6Y3ZreFF4UlFVb090Zi9YQjZ1?=
 =?utf-8?B?dTVhUDh4dTdOTUtnSWM4YjdFbzEzUnBXeEdvUG5lMlV0YUlhOHN4WVh4dXRN?=
 =?utf-8?B?ZjBiNWFWTDB4eGc5QTVGRUdsMk43SGhYdzd5L1NYMXJyYk00Y2NaamV2bDZQ?=
 =?utf-8?B?bDgySC9sL2JzVC8wTlpGMmhRdHU0OVhueTcydFM5WDZQekVZTmtQcyt2UTJx?=
 =?utf-8?B?c2t2N3ZMZTZUb1BuQ1gvWVJ5MDJYbGVwVWZRNS9vM2wzM0xzL3dGdzVwc2Mx?=
 =?utf-8?B?UzE2aXRzZS9GTEhtU3AvRUxyMVN3RG91QSs3aXVLd3pvQTFCalpXMDl6TkUy?=
 =?utf-8?B?K1ZXZVFLUGJkTEpXQUFBalVDNzJ3dktnTzREV2lTdjllanFjN3RuSnM1elBh?=
 =?utf-8?B?ZHZzOTlzRW5wVit1KzJsTElKS204Wk1Qa2dWT3BPR1RKeDgxRHUzSmwyaWdF?=
 =?utf-8?B?Ui9mNWRuZzZ3TDk2UlV0Slh3U2ZlQmxwRFlrTlhyT0xVMVU3N2w3Tk8xeEc5?=
 =?utf-8?B?NGNGOUZLUjUzellEREt4QXpQMFNnU2k5ZFBISlYyQ3FVUXNRNUxrWDJPcjBa?=
 =?utf-8?B?UWc1VWpqWFB0NkMwVVBhMDhZakhDbFZaSkh4d2YxSU5zTU1lRW5BV1ZRWDdm?=
 =?utf-8?B?T2VWRVFsbUZhWTEyMlptaVVxR0JBVVMwZXR0NE8vcjRiOG4xZHlKU3d4Znd0?=
 =?utf-8?B?OW5UT0hDSEUxUmUyK1V5V2pSNjIyWGR1MlpNRUJsckdEQUhyRWpUNXptZVJH?=
 =?utf-8?B?TkEyZHJ1a3pOZko3NHJwVTJJaEh1RjhVbWVmY1B4RHR6M1R6QkRPb2drREtr?=
 =?utf-8?B?TnNHRUtxcTFpM3F2cnVyS0psT1E2QnAxZUc3cS91Nlo0RHh1aVg3SmxIL001?=
 =?utf-8?Q?8K8AH0OTPRnNM21CVJte9WaUZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a045ff-859d-4158-006a-08dc846d5df3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:07:24.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdYsp5vtuqrgCFM+Vcd9INzZMwDkZMHjqkQGG8swkdN88tI3OnAa4EKkGOGij+pF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

Hi Shaoyun,

see inline.

Am 03.06.24 um 20:28 schrieb Liu, Shaoyun:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks Christian for the detail explanation.
> I checked your patch , you try to use query_scheduler_status package  to check the command completion . It  may not work as expected since this API query the status is for MES itself , so mes can update the fence address with  the expected seq value, but the  command  itself (ex .remove_queue for mes and  then  mes send the  unmap_queue to kiq internally)  still fails.

And that is exactly the desired behavior.

See the fence value is for ring buffer processing and getting feedback 
in the case of a reset for example if the MES has processed the commands.

If that processing is successfully or not *must* be completely 
irrelevant for writing the fence value.

> For mes , driver always poll for the command completion

No, exactly that's what we want to avoid as much as possible.

Polling means that we throw away tons of CPU cycles and especially on 
fault handling and TLB flushing that is an absolutely in-acceptable 
performance loss.

>   ,  do you think it's an acceptable solution that MES set a specific failure value(ex , -1)  in the fence address to indicate the failure of the  operation ?  But that should be similar to let driver poll the completion till timeout .  MES internally also need to wait for a timeout on some  command that it sent  to CP (ex.  2 seconds for unmap_queue command).

No, what we should really do is to separate the fence and the result 
values. And then give an input dependency on each operation.

> I'm actually a little bit confused here , has driver use the lock to ensure there is only one submission into MES at any time ?

No, exactly that's what we try to avoid. Othertwise we don't need a ring 
buffer in the first place.

>   MES can also trigger the interrupt on the failure if driver side require us to do so , the  payload will have the seq number to indicate which submission cause the failure , that might requires more code change from   driver side .Please let me what's preferred from driver side.

I can come up with a more detailed explanation of the driver 
requirements when I'm back from sick leave.

Regards,
Christian.

>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, June 3, 2024 6:59 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Hua <Hua.Xiao@amd.com>
> Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
>
> Hi Shaoyun,
>
> yes my thinking goes into the same direction. The basic problem here is that we are trying to stuff two different information into the same variable.
>
> The first information is if the commands haven been read by the MES from the ring buffer. This information is necessary for the normal ring buffer and reset handling, e.g. prevents ring buffer overflow, ordering of command, lockups during reset etc...
>
> The second information is if a certain operation was successfully or not. For example this is necessary to get signaled back if y queue map/unmap operation has been successfully or if the CP not responding or any other error has happened etc...
>
> Another issue is that while it is in general a good idea to have the firmware work in a way where errors are reported instead of completely stopping all processing, here we run into trouble because the driver usually assumes that work can be scheduled on the ring buffer and a subsequent work is processed only when everything previously submitted has completed successfully.
>
> So as initial fix for the issue we see I've send Alex a patch on Friday to partially revert his change to use an individual writeback for each submission. Instead we will submit an addition QUERY_STATUS command after the real command and let that one write fence value. This way the fence value is always written, independent of the result of the operation.
>
> Additional to that we need to insert something like a dependency between submissions, e.g. when you have commands A, B and C on the ring and C can only execute when A was successfully then we need to somehow tell that the MES. Only other alternative is to not scheduler commands behind each other on the ring and that in turn is a bad idea from the performance point of view.
>
> Regards,
> Christian.
>
> Am 31.05.24 um 16:44 schrieb Liu, Shaoyun:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi, Christian
>>
>> I think we have a discussion about this before . Alex also have a change that allow driver to use different write back address for the fence for each submission for the  original issue .
>>   From MES  point of view ,  MES will update the fence when the API can be complete successfully, so if the  API (ex . remove_queue) fails  due to  other component issue (ex , CP hang), the  MES will not update the fence In this situation , but  MES itself still works and can respond to other commands (ex ,,read_reg)  .  Alex's change allow driver to check the fence for each API without mess around them  .  If you expect MES to stop responding  to further commands  after one API fails , that will introduce combability issue since this design already exist on products for customer and MES also need to works for windows .  Also MES  always need to respond to  some commands like  RESET  etc  that might make things worse if we need to change the logic .
>>
>> One possible solution is MES can  trigger an Interrupt  to indicate which submission has failed with the seq number . In this case driver can get the  failure of the  submission to MES in time and  make its own decision for what to do next , What do you think about this ?
>>
>> Regards
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Christian König
>> Sent: Wednesday, May 29, 2024 11:19 AM
>> To: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is
>> started
>>
>> Am 29.05.24 um 16:48 schrieb Li, Yunxiang (Teddy):
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> Yeah, I know. That's one of the reason I've pointed out on the patch
>>>> adding that that this behavior is actually completely broken.
>>>>
>>>> If you run into issues with the MES because of this then please
>>>> suggest a revert of that patch.
>>> I think it just need to be improved to allow this force-signal behavior. The current behavior is slow/inconvenient, but the old behavior is wrong. Since MES will continue process submissions even when one submission failed. So with just one fence location there's no way to tell if a command failed or not.
>> No the MES behavior is broken. When a submission failed it should stop processing or signal that the operation didn't completed through some other mechanism.
>>
>> Just not writing the fence and continuing results in tons of problems, from the TLB fence all the way to the ring buffer and reset handling.
>>
>> This is a hard requirement and really can't be changed.
>>
>> Regards,
>> Christian.

