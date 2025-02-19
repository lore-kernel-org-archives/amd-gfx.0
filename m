Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE7C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 06:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5AC10E0A1;
	Wed, 19 Feb 2025 06:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eB5lPm4R";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9093810E46F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh1/Vyk8+DtnPUHgOQsSFmjOHd5eheErVL+dNUEJ8EpNU21/ZmMXzNeJznM0sNcqDjZlJRAxJ55o6C8qnUXDpgtrUKASd0P7sFDAzmm77PlEWmuOrU86Yy1xjNndTdICXVzdR7qxqQJSKVvpNCW1qtoaiWABSTBU43K7L8MH3U/uHrzCznEfGIlLfXJ/mGtthgiZcgcT0QrYYWzB3Lyc0NoI3w34u6YAr2G6IQ029IOZPJLz/lGaeYoLluIC0vh8Vp9EZfR4AVsy1rT4wPQXV6/xUgBPqpGmZHuogzf2/KvX9XnXbkUThdigTuKEA7/JfT66NeuU0PXFwttMo5iMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7yBd8JQpY7UX3nMqjljxxeMgO7rI9Dns2JJqdl2N1Y=;
 b=Dh8y2/Vmw0ZSqdTwogqVMJITvbyVeYas7nOa+uCACD5Om3vdDUvW34p2S7etUj8EXLc5v3Xm3Vkx0mq07f/s9YAOL5NFultxusjuJiqDLbDW9cwPDiuDi9/4bby5u4Jv3ZVs7RmtbmvRZhtJgZs51ZjJHHK650lP6rpyZFXgGNXri4Ey9GnzUstHmG2OOGqNhHnqQdJK0tQf0lyxc0Chi49prZM4RRnYc7qoUAI2ocbnGCEx6ZTWdeKxxIsUdHyi/5UOKOxFqHgVIZJjJ+WlJNgkIH8D2ObyYA7FJEL1SdSB4mqnftKv/7LkfuzA6tHlEYcujgTGBo13J+Fyst/SZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7yBd8JQpY7UX3nMqjljxxeMgO7rI9Dns2JJqdl2N1Y=;
 b=eB5lPm4R5s1J6RbeXaTATWL94wUafwniS7Dn/XBv9KR8SnufaR55BMfN3xYMgQtqrA2MiOiG21vyxH99d4TjRuic19G3kly07FhV8La9V/HCDdskY8+bnG5KiTvZzfMiV5M/i7MSbPIdOu32gmtFu8IUGGIn0hngbTZrBDR2ss4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Wed, 19 Feb 2025 06:53:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:53:51 +0000
Message-ID: <77b5d16c-8aa0-4fdf-aba3-b3aec26d9e48@amd.com>
Date: Wed, 19 Feb 2025 12:23:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250219062046.3530422-1-jesse.zhang@amd.com>
 <20250219062046.3530422-2-jesse.zhang@amd.com>
 <e72d2d7e-5854-4977-a94e-e5782b1d2cd3@amd.com>
Content-Language: en-US
In-Reply-To: <e72d2d7e-5854-4977-a94e-e5782b1d2cd3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::46) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 036b5ca9-5c14-4d6c-c7fa-08dd50b22b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alQveVJzVHBqV0JOVGZpVU52QmR0c2F6MFEydzdrOEF6aEN2OG1RSkVnVWxL?=
 =?utf-8?B?OGV3ZnV4ZTlTM1ZGZUVvV3o4N2x0Yyt5VHZTS2x2TjFwSEYxOTgzQ0dwTFRn?=
 =?utf-8?B?STV2MTRSS2I5R1liME11WDZrVU4zYVZIN2pzdmR5eExPeEhkZWlKVE9aUHNm?=
 =?utf-8?B?bCs2Z0JFWFY0UDZWVDhQTW81YnhXV3FmTXpac0lkQlhMaTNZTUM3M2NMNVBY?=
 =?utf-8?B?Qm9YYlFqYUFIdUZycEFQN2sxZzJwRWhVNEw2N1NoOFNnMU9yNVgxS3gzRWhY?=
 =?utf-8?B?UXQyRC9QKzlhWE5Yc3JqNnpRTDY5bysxUGxsRVhQQmU5dlBxcVU4VWxaQW9l?=
 =?utf-8?B?SHMyZ24yVGp6WU12RnlGOHNvVTNsaDdpMytrWW1aLzlSemxzRHpjeFNkUmRC?=
 =?utf-8?B?VjBDUFNMc0JoL1YwMVpnakNZcFJCU2huUlpaWEFlY3VZd2thNjRoQ0dmYWcx?=
 =?utf-8?B?MU0yVzFXS20ybE5UOGRpajVOKzVQTnlFRVFtUHJkWGxDOFFwMHd4Y2o0Tlp6?=
 =?utf-8?B?S1k5ZjNoWDY0VjB3NllZNHNzdGloN3lnM3lBUy9neEtKLzYvOEVrdUpOVHZy?=
 =?utf-8?B?ZGpBWkRkMGhXM240YUZIMFNKdWJ1RjAzUkQ1VWlFcGhjKzkyemFuc2NhQTJw?=
 =?utf-8?B?amlxMkNOMGt2NmloYjY4TjUrT2VMTUJxTWVLL25XTHZTMGF5T04rWElCM3Q3?=
 =?utf-8?B?VVJ6OWRtZTdKOU1jdHdlS2JJbzBwM3pVcG4yYk5QT0daajVxazgzdnJEUlhj?=
 =?utf-8?B?S0I4akhDcGZXZ3NOcjUwZy80d0o0azA1WnpoQmJCbGQwM2c3R0NibW9XUFlN?=
 =?utf-8?B?OXIzcWw5VGlVaWRnZHdUMUgydXY1cWNKTzRTSVhrM0VQeW9wZGxSTkhra2k4?=
 =?utf-8?B?U3ZXNjI3UXMwc3BzR1FFbWVuT3lVRjNOa0pLTDgrNHFsYlMzc2l2dWhaNi93?=
 =?utf-8?B?QWpkb0o1U3ErclY2SHdwblhrajJMZFU0Ym9zMEltL2UwVi9VZng0YUFIdjIw?=
 =?utf-8?B?WkN4bURwYmczdXQzUVFXVlhHeXNBOXpvS0ZnV3BVS3ZPUXVDWlIzWnNCTFMx?=
 =?utf-8?B?bjNrVTI4dTZvbzdwOGtidnYyczRIcVlhWlYwY3lQZGNPT2thRTVEUGloYkk3?=
 =?utf-8?B?NjYvRGtNWFl4SytkYSs1VStrNWZnQ0twZDZEeW4weWd2NWd1b2pGUjJiY1lm?=
 =?utf-8?B?UWt1eVNjSCtoQ3hudmJHTzNzWUF2bXdHNkNQcW8xNUpJMUJSdlBRMU5RS1dI?=
 =?utf-8?B?QVpWc0QzQ2JPQTBKbHVuU1dnYmVycTFBa3NpZmhqUG9hNXkzQnN2RG5NM0pS?=
 =?utf-8?B?VStvUEFDMDlzOGdYa2tVUFNNcHRENXlxR0Vsd29HZmFVM25ueDNCb2tWTmMx?=
 =?utf-8?B?YnIwZmlkVmoxYnljOXpnQlNiaGNISDRoWDBYZmY1K3BLTCtZZ1h6c1QrY2ps?=
 =?utf-8?B?cTJXN1BCVFFoelp5TTZQMjJmcGdEekdPOWJPVHBtZnRDcTZjTVhUVG41eWJy?=
 =?utf-8?B?dWM0eEJETU1zTndpTzNTOGtGUVZacHZ5MkJsU1JUMzhpKzQzcUdIRDEybU80?=
 =?utf-8?B?RGxNRktNeWZsNENUdVZhbm1UQWxXaFYxdHNpalJ4NjdjUmd1bmRzQ2xzOURT?=
 =?utf-8?B?VHk2YytLRE5TcWZPeUlEUVc5NHZXNXhCVHRzM3RxaFF2T0I4cHF3MzhweStD?=
 =?utf-8?B?V3NVTjdkLzRQLzJydkNybi94Y3Q3ZStWNUp1VU9KVDAwZ2x2bzgwOW1Remg3?=
 =?utf-8?B?NDJMODFNMml0Y3NLek91WEIxWk9qYjFvTW1JR1pDYmNaS0hUZHF1YU0ydnlk?=
 =?utf-8?B?L0NwdHRFRjJiNGt3Tkh5SllzU3FTKzM0eG8vVVZvQkdGZEJuaDZ1empPTDN3?=
 =?utf-8?Q?R8gmbHVZHVrpe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MisyaktBSUFLbmhVcjV2Rkx4Y1MvRkRNN0k5dUJsZ09Xd2NFY0Z6S2o3dUIx?=
 =?utf-8?B?QlIzSHllcUhDRXUrdStwcnpaRjdtREMyckh4OUF4SUZxYzBPWEZJRlpqVGxh?=
 =?utf-8?B?bjUrbGVPMjdycnJVbUxKNWhLY2RTODdibU1meExDSVNUdUxlREdwSVY5aDFS?=
 =?utf-8?B?MEJMMVR0UmxPeDhWVFU5ZkVkTEhyYjBVUCtXR05vblF1QTl3WVcrMmYyR29C?=
 =?utf-8?B?YzEySVhRSEhIYzBQRitOYVdVam4weGdtZHZmblJyaGNSMXMycVUrNmVpRjRH?=
 =?utf-8?B?VmlRcU5XTjBhRWhsbXJ2bUpsdFpFa1JScnFGR0dMTUkxZVc0TmI2N3R5VE1x?=
 =?utf-8?B?WEgwVUhIYU5DclZkR1BZK2VKNnhoRzVrMzVzQzhnK1FLdksrU09JaitzdGNK?=
 =?utf-8?B?L2ExWUl4ZThURldZOW94bW9haU1WQ05VSFZndTM2UW9kWGFyd0hockc4NEZs?=
 =?utf-8?B?dGJnaVFDOWxMVVRQVmp1eUN4WUJOUXpaQ1F5YkxQMlFDU0g2SHhIZmJFSTBt?=
 =?utf-8?B?eWNBdVVMNG5CekhJOTJuZnNSbXRnV0JETzZpMkIwallzdGFScHlBTStCZU5n?=
 =?utf-8?B?bFJ0RmdSa0g1T1JBMGg2ampGUEtRUDkzOWxEcUdJcEdqb0puNjhVUkNUd0wz?=
 =?utf-8?B?bnQ5cXFkWmZiOE1QSGNhT0tyb2E5SmlLdHJCZGVCQkhjV2VIME5GRG0rQ2pT?=
 =?utf-8?B?VHRPampYQ0x3TDlBbGM5TnVGcURSQW01UGJTdHc1UU9MK0JoaWtYSUZBQVFI?=
 =?utf-8?B?U3kzZDVJWlhZQU00aENYU0FCV2dLSEJvOWhKRFVsR1BPUjdOK2xpLzdaanJ1?=
 =?utf-8?B?NFpDM3hSd0NWMDhRUFJjMzhIbkVNMFRnbnVtUFA3NXhiUU1rTUl6RTJGNDRL?=
 =?utf-8?B?dW1XSjYya2IrZmFqTGQyKzdYUVVGb0kvbHRvdjJSZzFGT3Vibk1UbTBvaTQy?=
 =?utf-8?B?ejFBdlFyUko5TXlXZi85VXkxUDZCZ2o3RzFtUnBybjFqelAzRDJ4R3Jmeksr?=
 =?utf-8?B?dnRSMFpaQ0ZZTWd0K3JpbEQzcGdZOVgzdXlGRUtJOTNxNURFdEJHVDFSMldV?=
 =?utf-8?B?OHo0Y2w4QkZZbEUwc1JKNUpyWVBlTkUxNlpheUlYcW1Rd3ppaVIvcXVyeVpU?=
 =?utf-8?B?QUVpcDRHcmM5TWRJOVF1MXpwa2h0SGNGOGo5QVBGcUxZbjdsTnJlcXNQRGRv?=
 =?utf-8?B?TEUrVVVqY0x6VTJnUUJzTHJOd0FGbWNWaDVrY3htM08wZ1E3ZVJOQkprNWRj?=
 =?utf-8?B?a0NiZUIvaTlrMGV3eUh5blFWK0FJc2VkZUJ2Y1JNaDBsTlVMREpwMlJDWnZy?=
 =?utf-8?B?ekJSeFJKVnJDRkxHK0pFMHQ4RG5vNk9LVVNYVGZaL2ZRYlJBQVpJZDFqZU5y?=
 =?utf-8?B?aFFaUk9zNGdJdFlCWGhVSWlWZlNMK2FLNHBqUUlKSm1iMGkvNThDcDV6ZUhB?=
 =?utf-8?B?M0dieXl6a0JsNkFSS3ROTXQ4d2xHVVRlM1QwQVV0cDNsQ2xyb01xenIyUkF1?=
 =?utf-8?B?MlVaMUd5OWRYU1phR1pmdXk4dU5sMDlUWmlYWVNYcFBvWG04cFRoc09rdFA4?=
 =?utf-8?B?NTEyOGJTdXdhTlpRRzRhVERUcTF4cjlCRGZZQnkzejBqS0lKdUx4eURGRGRE?=
 =?utf-8?B?OUh5bHlJVVZjNXlKL3VjeGl5L1Mxdml1Q3dWV1lOQW5iRTdsL1I1YmM2ZlUw?=
 =?utf-8?B?bFBnbFVKc2JjQ1VEWmxTWXRERmU5aDZ0d0Z6UENzV2NsT3o5enpiLzhYdzdK?=
 =?utf-8?B?VjdhWVVtcFl3cHh1VTljWTZDckV2WU40aVZvOTVLdysyTW84bjFmQmY5REFz?=
 =?utf-8?B?SUY1SjJQNDhpVW12UVQ4R2doYzM5SkcxU0xXY2xWQWFUT3p3a2Q0ZFBTZlRZ?=
 =?utf-8?B?TlVrU1ZGa0NLUFM2MEM4dXZEbkkzVnVXemZ3ekJsUWpPSkR4UUNoMkVKa1JE?=
 =?utf-8?B?bVU1K2lsMWdBY2lGTHpWZGo2SlRLZW5ubU12dE83YzJ3UWVyZlAxWFpMd05o?=
 =?utf-8?B?V0xkTVhJclFQaGdaVHgwcXJXTjYzWUw4UGR4Sm01QjBnVmRQRi9qZndySDhU?=
 =?utf-8?B?WE1KRUVxa1Bjd0JKeFR3UGxXcWo2NnBoRXVCZUxvUnhqejBaTmRaV1NiZldi?=
 =?utf-8?Q?T6Wjoh4+6BRTbaiNvxAI/ZAGU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036b5ca9-5c14-4d6c-c7fa-08dd50b22b02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:53:51.5818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D3qBQ5SEeISOsy+JDo+FNtJBKjkOHUijbd3YKm2AGu/M4Z1owcwzPFDuRVhj15t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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



On 2/19/2025 12:21 PM, Lazar, Lijo wrote:
> 
> 
> On 2/19/2025 11:50 AM, jesse.zhang@amd.com wrote:
>> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
>>
>> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>>   allocating a separate engine. This change ensures efficient resource management and
>>   avoids the issue of insufficient VM invalidation engines.
>>
>> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>>   during TLB flush operations. This improves the stability and reliability of the driver,
>>   especially in multi-threaded environments.
>>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 ++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index cb914ce82eb5..013d31f2794b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -601,8 +601,17 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>>  			return -EINVAL;
>>  		}
>>  
>> +	if (ring->funcs->type == AMDGPU_RING_TYPE_SDMA &&
> 
> I think better would be to combine ring type with something like this
> 
> bool amdgpu_sdma_is_page_queue(struct amdgpu_device *adev, struct
> amdgpu_ring* ring)
> {
>         int i = ring->me;
> 
>         if (!adev->sdma.has_page_queue || i > adev->sdma.num_instances)

Correction -
	(i >= adev->sdma.num_instances)

Thanks,
Lijo

>                 return false;
> 
>         return (ring == &adev->sdma.instance[i].page);
> }
> 
> Thanks,
> Lijo
> 
>> +	    adev->sdma.has_page_queue &&
>> +	    (strncmp(ring->name, "sdma", 4) == 0)) {
>> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
>> +		 * Shared VM invalid engine with sdma gfx ring.
>> +		 */
>> +		ring->vm_inv_eng = inv_eng - 1;
>> +	} else {
>>  		ring->vm_inv_eng = inv_eng - 1;
>>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
>> +	}
>>  
>>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 2aa87fdf715f..2599da8677da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>  	 * to WA the Issue
>>  	 */
>>  
>> +	spin_lock(&adev->gmc.invalidate_lock);
>>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>>  	if (use_semaphore)
>>  		/* a read return value of 1 means semaphore acuqire */
>> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>  		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
>>  				      hub->eng_distance * eng, 0);
>>  
>> +	spin_unlock(&adev->gmc.invalidate_lock);
>>  	return pd_addr;
>>  }
>>  
> 

