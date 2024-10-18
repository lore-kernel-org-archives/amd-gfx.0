Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697A5D3000E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 14:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3A110E36E;
	Fri, 18 Oct 2024 14:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l2VGGnM1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCB110E93B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 14:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUzMkQHOFVGrK1qqqoNuWkyNYuW6D5jUt5q8kq3BVJFFY1JS6MI0jPwDPfdvB9Ft3Zmj4lbMWsBF5mjiXBr5niOhzz3HflcWckPxI+3EZGZqXSXUodIweWyB/AuSI3072f7fUv9+gfoXZQz8w7Jac020akVgew2SqjXy5dKLFcLLQIexLulHNLDPNIfSjASH9aqtdn17u235AxVzXN++e1JuuKyGHzkMZT+Gi9BEnxhmP8ECzUGkVEv7QUR9kHEPcxZPpDGQQFhZzfhjwddyewQAK7dumTalNeiTIGjs9nEkxRj0ilhTLzSAlqpJUnwem0eQCbFgCbWO6dTDdV2qTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIDoU3I7VSD7SgSUqAKTiNF8DhkjyhvjBMsjIwNBK74=;
 b=rPLB3V/ElTHFS1iBFCLyiIAOjMMNyou0xn2ufoaTrbiPunoy9VbDGNDc7fmMQ17YccKDFf629Ozty8iA559+SgrGbMMrbuHmqVCR2NxWSk4vFKt1ldLRi9K1kqeejZO6cZpo11O8qS5Y0GIwtYrWBpQtJOg1znwJHKrXjVnVIzbHvQtvbi4ytkWHpQnBrMeDVoR8DyGHJGw9ECBU20aoY+TVTLlUe7WmOzai2EaF63RNileLpSCVp+izVgYBsA5G9aLPJQae7br4loTHOMhkgvi5oRraO3lyuTIbaDkLhK9UeN1uUdGGKe0vgDD4Z1W7mF7vJzqF351YfWshgNA/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIDoU3I7VSD7SgSUqAKTiNF8DhkjyhvjBMsjIwNBK74=;
 b=l2VGGnM1QYTz3JcEgLfILBDjDczxboA1pk1vV0hesduSEfl5k8bc15XrD9FUGYChwD328ffVtGI8mGLPT7pfcv5pnuzejHLP/79UUgbjC2XFrepMj3vYsucqxUjzPVfVqnkgqpcQnw+NhRfOGTKWt2XDNcLbmp8zaPpLCjimlgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 18 Oct
 2024 14:07:36 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 14:07:35 +0000
Subject: Re: [PATCH v6 00/12] validate/clean the functions of ip funcs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241018132327.1638247-1-sunil.khatri@amd.com>
 <6339ba5b-70f3-47b6-8989-5fbff8edec14@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <42b66e1d-0efd-8d60-2dfe-39a7405bc7dd@amd.com>
Date: Fri, 18 Oct 2024 19:37:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6339ba5b-70f3-47b6-8989-5fbff8edec14@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: df960025-061e-4552-72cb-08dcef7e3766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTh2dUxidDJQRGszY3YwMTBjWjI0aXZyRitPMnpRNWs4bEVWaTJxd2FhUkJi?=
 =?utf-8?B?Q0EyYktLaWNOdlFocTd3SEFJZDFVWHhyYUJmb1Z2OHBaUGJZeE1ld2JSOHRL?=
 =?utf-8?B?TDgvVzBBSjFLNjlhT0FYYmNnK1BsYzc4SmR5QjB3dEtBQk1JUzhNMVBKdHJE?=
 =?utf-8?B?NHg1WUtCT1ExUUQ4MGREUXlXY0srWUxyUmR2REFsRXUxUXFpaFZNL0czZXJD?=
 =?utf-8?B?L1BBVHg3VFJFUVE1Vi9CM0hFQWgySFJ4L3psNFdLODVkdWhjRWJNNkFuNklj?=
 =?utf-8?B?ZkU2U1hHRUgxalVBdEI4K3J1K1pkK3JoRlJrbXJjU3BqOWhnc3hIZzllQXFR?=
 =?utf-8?B?L080Z1hiUERBc2NxRmp2RWdsMzA1cVZKclh4TUN6Z1dyamtWT1djYkRRd01y?=
 =?utf-8?B?Q3VxQzh5c0o1Z2xNb0tSdlUwWUxiQ3BPYk5SL1c5ZkxpQW42eHAyZzNnRXM4?=
 =?utf-8?B?OVgrZll0QjkwT2FCN0NVcWUycVo4aGMyeGs2R0dDWWc5UUJxNUZYalhCOU83?=
 =?utf-8?B?SmxGTHI1ZE5mRW1mS3ZzZGd4K29uNWR5OTJyWWswLytQM2l2bVpxRVh4OVpN?=
 =?utf-8?B?K3laajFxTWZwaXlLWWlhV1FBKzB4SjFNOGpUMFVpVHRZd0g4YU9NT205SStq?=
 =?utf-8?B?aXZhL015d3ZLbmJYMVdTeEhxR1EwYTFoWU1sRmtzeUF1UDBiZzlIc0ZtU0hC?=
 =?utf-8?B?QWVoYm82Wm1PcjEwczIrdjBQcmZwQzJKR3AvemtqOEdGOE5HMWVzUngrSU9s?=
 =?utf-8?B?RVhhTGpCWUIwZ3dNS0lrYzZXcUNEUGJnZmJEeSs5Zm5UOUw0dUdLOUptNUpR?=
 =?utf-8?B?c3hwZHJEMWRVNms4V1RGZVdSOHlhQklTd3BJOEMwMXFuamI2dHRzWXJadkFC?=
 =?utf-8?B?WG9jQ0l4MDFob0JTOWxPNXZTQnlEUDJwRFRYTDNiTUZQMGFxcXhWVmJLaGNZ?=
 =?utf-8?B?OGpjQ2JvSDduZnBWUmg0b1lKc1lUZnp6M2VhL1VsRWZ4QWFSR3FicGphcmpx?=
 =?utf-8?B?NDIzaEgwdlorUzVIUjJ5bVNXMW9KT1Jtc1pueXhZSUwyUlZSdFl6dnQyL2dX?=
 =?utf-8?B?dUdMUXM1N0JYSERQRUo5Ym1uR3AxcEd0M01BaEE4dEIyUEhwQUI1U2FPTEFP?=
 =?utf-8?B?Sm5hbDBGZUxzWmhKWnY2WTRHOVlPRC9mWVBjakxBK0dBcXZvK2MrTG8wNDlw?=
 =?utf-8?B?WFEvNzhZTHN1SGYyK2tQWG03elB4Y0lwN3NhZW1VeHAyaUE1S1pkdDczSVo5?=
 =?utf-8?B?VXhuUFdDdDgyS3dBRS9RSW4yYy9JemdEcy81ZVJsR0J2OHF5WldEdlg2ZmpZ?=
 =?utf-8?B?NnlsbURDRjU4UWdhcjc0Y2Q3bEllT3BpSU5SbnVwdVpDOUN3VWJJa1lMOHc0?=
 =?utf-8?B?aXlRSWhtTEY3d2VhZjUzcmZwT0hkbzdzS0JmdzNaK09va3FTNnRDUjlNV0xq?=
 =?utf-8?B?cEZGQTRIdUczZHhMZ0tmL0V6ZFhzTFAvei9rQWFQdGppUENtK29iQVRHRldT?=
 =?utf-8?B?YlRTMVMvUmtlRkUwQzdRWU9ERnRtcE1ZR1ByeExqdmI1QkpTcXhIbThVdGp2?=
 =?utf-8?B?aGNZY0tTYzd6NWE2Zk9pcFBSWldNblJNUnBRYmp4MTk1SFBxUSs2Q0dWSVhM?=
 =?utf-8?B?eEV0Z0Q0Wk96bFRJQnJ5U0lEMDBWZ1N2NGc2bmlLQ05LNTFPV0h0TU1qQ3l5?=
 =?utf-8?B?R2FqZFhsZnNNSFZNbVJWb0l4MFpEeDEzL1BvZmRXQm9kTzJiZGJsalp4RTlI?=
 =?utf-8?Q?b8rxTEa++uo0zRX6xTskWC5e9WPZEfGG+otfxkm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xvSHBTc3BvWWlyd2IyZFJGSjNwVnlaWUo5OWtrenE1SzIyK1B0bkcvVEdR?=
 =?utf-8?B?dEs1NEZXbUk2REJMblY0Tldtd0tjZkpHN1Azc2xFNDM4Vll5d0FRQUZnc1Zr?=
 =?utf-8?B?MzZLQlVoOE5pRnNlRjM3cnFlZ241ZlZTSE5Sb2ZaZHMvb01GR09CSFh3dnVv?=
 =?utf-8?B?UHRTbXo4VzZGVk9WSm9wU2JDT3Q4VGkveklGV1hPRlB1SnRvWmd3eDMydU1E?=
 =?utf-8?B?Tkk2aENFZ01uckpTMm9TV2lZMUUvOVRrVzFIRnVOb3pjdkVaY1AzblJtOWZZ?=
 =?utf-8?B?UkJYQ09Way9keEVxMGxCZmlGWU00OVZnZmFXRnNSdldJbWVHVDhxNUR1RnJ0?=
 =?utf-8?B?bjlLSWtaU1JUeStyaUIrakZueW1vWHJqM3VtU0YrZC9nY2FzVlVpV1dFRXJN?=
 =?utf-8?B?enNEK2ZlbkRiMVU1d0czdVgxdXl1N0x4b0o0QkNVTWxTL1MwWjJ0MTRHd1Vs?=
 =?utf-8?B?d1FCb09obWJkQnNHaHVlNU91Vk9KeGs2TENSOEJmSVVIay9rQkthclAxUXRL?=
 =?utf-8?B?OGhiZHJ1b1V5b1BhUllCZHo3Z0NNUnFzbytXTzE4RCtoYnRiVEJhUFkvYXh1?=
 =?utf-8?B?SGp6R0h2MjNITmVVU0ZiZXdoUW1sN09sZHJJazVvd3pQQ09FQ0N1SVRjTllj?=
 =?utf-8?B?SkNLMjFhTXF6bGl6WEU2Mjc4bjM5ejdXMXdYdTNwQW9uRnhtSDFiZDhSK0xn?=
 =?utf-8?B?SWRFNXl6amxMUjdzbVVQQmJmMnpCak9TMHAyZUhwaVpkbG54VVprWmw1QkN1?=
 =?utf-8?B?cGUrZjhYMmRHVE56Z0xlYzA5enBZMGI2d2M3MGNQRE5mRUVBbkh1anczcjhT?=
 =?utf-8?B?STM4NDZZWVRwcXZ6RXA1Mi9hRzRsNWVlMzYrOXRCcTNiMyt1L0pYTUc3bTFa?=
 =?utf-8?B?eXdYSXd3YlRRNE1qWmhUdmM1eGl0UXJGZWNNNmFLamphVlh3MTAzMjcyUEFD?=
 =?utf-8?B?d3BwQUc0cjJNbG5zRXR4a1FBVjl4WGNQTGpHVkxEbEU4djZhcURaZEE5TkZT?=
 =?utf-8?B?SHFhVkg5L2QrdXQrSnppTnh6NkRRaGdXTXpxaTNONm5jS2lzY2p6WmlnTVd1?=
 =?utf-8?B?N01ZNHpxd2pyRkNiaGp4aEIxd0RGakhsR0oxWGZTK0NSK1NkNnFvQXIwTHND?=
 =?utf-8?B?TTZFQlYvM2V1dVlmbzE3K1J5RjMxMEVoMUpaeUNQaTlYd1ZEN2VvZXIxUXRC?=
 =?utf-8?B?RTk0OXo0VjJDYTZ6MEcyaGZReWdPVDByVVMrajNYNGRTdHpicWZ0M1RUekJJ?=
 =?utf-8?B?Q0lGZVRmUndzbEVtOGtESU9lUHB0QkpDbXhxelNYL0gwRHlNcDVWUUFwMWp4?=
 =?utf-8?B?cUlhdVA2L1lrS2g3VzFqbkg3T0wyZWlOYWZ5cDBNNzN0L1JhYjNBVjJGZ3Zu?=
 =?utf-8?B?V2VWczY2R3kwVU5pWlVPamVZSlhnRVpDanNHTnVvOFJYeFdlOWNsVjdpd3pq?=
 =?utf-8?B?ZjRmS0dSSEcxVUdVRlJINWdlcTA3MUsxWkZRcGFncEdCaGlpV2pab3laL1FZ?=
 =?utf-8?B?TFpWVVJDZEx2THF2QkpmcTdUTFlxT2lGczhJMytvZmR0RUplMXN2TE1sNjNO?=
 =?utf-8?B?MTZiQk5vaGtDMDF5b2NCQUhtZHZhVmNwQzdmRmlzd1p6Q1c0ellUYWxnOGtN?=
 =?utf-8?B?ZFJOOVN4aGFHdVRHQlNZOVk5OXk0QVBWQk1Wd2piamY4S09DeVZyWUg5UFJT?=
 =?utf-8?B?VnBVYlVjd2p1VmVqYmI5MXZXVWZBc2hRdTRkSlRDd2JnaHI3Q2hhdGhyUlkr?=
 =?utf-8?B?VlJ3V21wd0UyUkw3Mk9ibUxjcmJoNkRkUW5ZVjM0ZUljTklJTHNMRG1QWlJT?=
 =?utf-8?B?ZjNjZm5SemM5K25qRWUxUURGT29wMEtDTWdUOXJIbWFtaUlYcy9jblQyREhT?=
 =?utf-8?B?VzZhekNvUy81cGk2Q3VXcWZtSm9OY2FCWXlqcmorU3RGM0kyVG5ZSTVSczhp?=
 =?utf-8?B?R1I2MnFUQ0h5eUMxVFUrNEVxcUdxRnNpSVN1YXJIWk5OT2s3S3V3bnN6b2xG?=
 =?utf-8?B?MUJEV2ZHdk1WVWtYaEFmK25WdHg1YlFMdzhiOW5VaHlsaGhVdVVkUi9zdWFS?=
 =?utf-8?B?OG1XK3gvbFBreU84MzhBSkdoRmxRb1hvN0dZUXR5S0tENUFGZW40enpXL3Jp?=
 =?utf-8?Q?7sL3HiEoxlpQ/cnCphnc5rb2M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df960025-061e-4552-72cb-08dcef7e3766
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:07:35.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZikfbPeeaEk2x7axzmru4zOBtHtg4U7mvuUWR7CPa73wUsAM+14wP/V4djH1hnuwrS/NgwtYBjAFTzg1ZWc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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


On 10/18/2024 7:08 PM, Christian König wrote:
> Patches #2, #3 and #12 are Acked-by: Christian König 
> <christian.koenig@amd.com>
>
> The rest are Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Maybe give others till Monday to take a look as well, could be that 
> Alex, Lijo or somebody else point out that we are ignoring the suspend 
> return code during XGMI hive reset for a good reason.
>
> If nobody objects by Monday feel free to commit the whole series.
>
Sure Christian, Thanks for review. Will wait till Monday evening and if 
no objections i will commit.
> Thanks,
> Christian.
>
> Am 18.10.24 um 15:23 schrieb Sunil Khatri:
>> v6: Fixed the missing return statement on suspend and update the code
>>      with V5 comments.
>>
>> v5: Fixed review comments. Dropped hw_fini patch and need to look
>>      further why such functions exists. hw_init/hw_fini are mandatory
>>      functions and we should have a valid definition.
>>
>> v4: hw_init/hw_fini functions are mandatory and raise error message if
>>      these functions are not defined.
>>
>> v3: Added 2 new patches to clean get_clocking_state and hw_init
>>      validation.
>>
>> Sunil Khatri (12):
>>    drm/amdgpu: validate hw_fini before function call
>>    drm/amdgpu: return error if phase2 suspend fails
>>    drm/amdgpu: return error on suspend failure
>>    drm/amdgpu: validate suspend before function call
>>    drm/amdgpu: validate resume before function call
>>    drm/amdgpu: validate wait_for_idle before function call
>>    drm/amdgpu: clean the dummy resume functions
>>    drm/amdgpu: clean the dummy suspend functions
>>    drm/amdgpu: clean the dummy wait_for_idle functions
>>    drm/amdgpu: clean the dummy soft_reset functions
>>    drm/amdgpu: Clean the functions pointer set as NULL
>>    drm/amdgpu: clean unused functions of uvd/vcn/vce
>>
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  24 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 150 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  25 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  10 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  19 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
>>   drivers/gpu/drm/amd/amdgpu/cik.c              |  15 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
>>   drivers/gpu/drm/amd/amdgpu/nv.c               |  14 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/si.c               |  21 --
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  30 +-
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  20 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
>>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  14 -
>>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  12 -
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 275 ------------------
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 274 -----------------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/vi.c               |  14 -
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
>>   78 files changed, 114 insertions(+), 1122 deletions(-)
>>
>
