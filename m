Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD67D5B17B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 15:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A6C10E569;
	Mon, 15 Dec 2025 15:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5tWZto5x";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FB010E54E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 15:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+0siGRwKzjZAKm5xX4+JDWUM7MDWJhlWuNOjeymZ2Ylisd+HsXanp/RARYrprpXBGYYbWotXN+lZUJqKEeXVe9uYiez9Lq05tlJiQlB3N10V4mBhgqOSyaJubmqpAS4zWSJJUk4DGtQccZAI2Z7TfSk0iehDEU3NB905BJtdUhyLcIysvox7JyuqO05i3hCE72pdf3PcJGSxEFnAtaERp3PYPiszUah6OVp/7HGkqptgUp+TrjYLsf+FquLPMfGFp6SJ4WcbhjaDm5s7nz7hhaP1zvafacM+8gPHnIBtpNbrrAumz7zljF3yII5Ac6gtx6bwKnucYedmQV5U2i0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKd26S9tEut/YAkOUTDyUjW9hXnXPia5pjRj3s7Flrg=;
 b=C8wmJqN8MZ3x+4vnXp63yJTgrMiwOc2dKISD8dTHEazKUJsxAXFCK91D7ND9BfX/XrzqA6KTaagMBqdVarcmvglDX+f0d6TO9HJce+2Kgs5igB4ZKYu49YrcxsGChdD7rGOfni01+x6fGVft94lARx+GDiTaZpNn3/PTsZh4s2p/iXiypYbymzKDaSdMQUlDn+5jr7R78KUGzZuoJkXjtFqe4Z4NAgPMrMMfBSgfD0Y9FrrcE9P24tjrGAAe+jK3XoolBDubfFtMI4Eypg+vMBUVZZ4kcV1kA2qi5r26t3xXLMv5I5CvDUJx1Q2e1O4QP+8KQuZ7T8RRTPIgQzNoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKd26S9tEut/YAkOUTDyUjW9hXnXPia5pjRj3s7Flrg=;
 b=5tWZto5xz6KfWnx8zF3xaUWWhR1PolDL/65c77+ZGoCAEm9Cqf2p01gQRMAUyJ3OcOXuec51UUR8FdUR3sIh9feYSHrr0auYtY1dqbUpX8utKZyAceX25LWJlh1scW5PhOWp+8e7qxZo1F6Nf7j9GauoG8avixYYOfs/GDHAAvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Mon, 15 Dec 2025 15:20:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:20:20 +0000
Message-ID: <8c9dd8e8-35f8-493a-8457-be027581ead9@amd.com>
Date: Mon, 15 Dec 2025 16:20:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251209234328.625670-1-Philip.Yang@amd.com>
 <20251209234328.625670-7-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251209234328.625670-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 6258715e-97a6-4e1e-13ee-08de3bed7594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUtqSTNhbWlqbjQ5bTQrMWovcWxoanZFSzBnSG9RdHNlVUpkWDRkQVVtYURj?=
 =?utf-8?B?MGpwWVoweURrQTduOUhIZW83cWZpU0F4dHV3RklmUGNaTnZaQ09ZQXNlV0tC?=
 =?utf-8?B?Ri9pYyttMUdVY0VtYnhPQ1M3ekFZRWtwR3ZpOVhLdzBsOGwxZ3pLMzlvVE5j?=
 =?utf-8?B?bnlnTmoyaEM1NmNZQ3c5VVVVaVJDWi9JQnNsL29kZHJoY0VjdEVjeFk5N0FQ?=
 =?utf-8?B?RzBoSjduVVlNU1dTaGNYWnN5Vno2L2VOU3Bqc0hUd1l0MmZSRkY3L1VTY1pF?=
 =?utf-8?B?NXRZMlNjOWs1K0VBbzU3RXFFdVJRWlB6TEFDM2Z3aUFUbzlDenBlYjZZcE5k?=
 =?utf-8?B?VWtYTHkxZ0VBeWJ3NzVIY3hBaWlJVi8wQWNKOGQvL1E3eFA1QkhtaXZ3Z2g1?=
 =?utf-8?B?VlJFdm9TQ09YWDlxVS9iOHNzVGExT1hJbU9uTVJySW9yMDJTK3RQSEpNRFBW?=
 =?utf-8?B?VmV1elZId0VtVTdDWEtRWEIvTkk4MGpHTkQwbE9NTGhKdmJDZXJKSldrbnZP?=
 =?utf-8?B?OHZtQWZKVGc4aHQ1M1BrMENETVhwNEIzdFB6Q0pMZ1F4d1lYY05nRE4wdzJB?=
 =?utf-8?B?QkJTeWNoZUU5WDZEMW04NzJFcEoxUmxtR0NxMFA4NFFWS2l2bnVvSE9JYmNV?=
 =?utf-8?B?NXl2Vnd3dGVsS1JXd29JZ2R0NXh5cFV0M1IxR1RBVUcxSWpFdzFyaWwzNGs1?=
 =?utf-8?B?SXkxdGpaMWhFR1ZHMitGbFRkNmVlK3VvTWRpN1NRTGhaN2p6MXFQZEFra2J0?=
 =?utf-8?B?cWtUUU9tZ0VOWnZ3UUFWNlhzRC91Tks2anBHU2xRZWVFYnpxOTNEcmthTDFx?=
 =?utf-8?B?V1pQeWJZMTVXVnFjUW01ZGsvNUlyK3ZDcmRzSHVVWDBiQk9rOE1MZ2tLckxT?=
 =?utf-8?B?UHJkS291QTEwNmRuUXJMRWZBWmFGQWY4Z3htUlN2TW4yQmk3aCs0U1hRQkc0?=
 =?utf-8?B?b3NHK2Vyd0JibHpNaFo0SjZWZW1MdUo0YVF2bTJkbWwyWVovU1BSd3JldWNq?=
 =?utf-8?B?M3JnaVZlcGFQZjhwaEcxQmlFNzVNbDQyWFhjbjhoRTExSi9pVitNaU5IQ2Fh?=
 =?utf-8?B?RXFEWGJSYzVCYXdENnN5ZlZ5dlV0elhURnNydWNWcHdUVE45U0RRSjM3TlBx?=
 =?utf-8?B?UlhNcUc2OGhrSXFKeTMyME5DdHh4dnFGV20zT3ZEM2NlZ0t5SjNwaGROSmgx?=
 =?utf-8?B?dXZ3WmRpOFRORXJicGM5djVQcFVVZ1BpQ3dTTHAwM0VYNWRRZ0NRZlhuQ091?=
 =?utf-8?B?dDloZ0lpWWZZWUVtY3N1S0NLdzRvL3V1UHk4UHJwdGVtaE9SWmkwdTZpTnBV?=
 =?utf-8?B?TGlNYTY3cmo2ZEJkbmt2WmtKbXdiWFppRkRIQ1Vhd0ZLUTFjajMrR3dFWFQ4?=
 =?utf-8?B?bVNEYmN4ZzQ2UDNNMTA1MXQvYWIzWFQxL2xUV2hQZEZnUXBNRUtDU2pxMUlT?=
 =?utf-8?B?b044TTMrcG9ncStpd2U3bVpJNThBKzNoUmpocE82MkV2OUxnaWkxQXQvMHU4?=
 =?utf-8?B?c1IxaUdHT01QcVVlRnByN3FOakN5RytuT2o2ZWUxVjNGM0VSUHBGMmxKNUxs?=
 =?utf-8?B?L3NFbEpJWkhFUnFyd3RaakxJVmErbnF6WVRhUGdvTGw1bkZRMWl4OFFIb3da?=
 =?utf-8?B?OXE2cGgwVmw1VWJWdUlRUithQW13RE9pc0tGaWt4anFDeFhLRmRKcVBCSXRR?=
 =?utf-8?B?bm56bmxzdWNPU1VCYXdlR2dBekxpKzVqUFV3TTJKb1BGcjhZV0NUTERNWW5I?=
 =?utf-8?B?RjV6M3VxOWtPK1FTMkRacThJSmY1b3lzV1BTOFNpYjFLZ3ZWNk9QbFFWam5K?=
 =?utf-8?B?SnhMRWlUZFhhOUEzK0NmSDJJV2V1dlhyMThjSFdRMk44c0RlL0YrdkQxUUM0?=
 =?utf-8?B?UFd5bnBDemd5b1hhbW1TbExSQjBmd1lEUGcxS0RpdDZaZTRYSyt0NjBGQUlE?=
 =?utf-8?Q?EtYiaPbrRbxnmIC3Jit8Tg0OR9M6O6O4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THR2dC9hUHJTUGhmY1R3TDl6RlBqQ29xZ3NqdW53MWRRem01SnBWdkVDdEha?=
 =?utf-8?B?bHQ3NTR3dU5uVWd5UDNIQnJVWGRZK1RVZTE2Q09iUDFCR3JLQ21COWRUcFlS?=
 =?utf-8?B?cEtReTdJdXU4OXQ2T1RpWStNaWkrRVpJTW84Vk5NMHFsc2cyaVUzV1BVUmJm?=
 =?utf-8?B?VlVza1VqbndPY29FcHdhMHI0Qm5uTkdSVEpZTXcyKzFsQm9MNjZJR2w0UG5R?=
 =?utf-8?B?UG44bWs5RWkzbGlXclg4THZKMU41OW5MTkNJRXY0YXptTysyVG1lNUVuK0tt?=
 =?utf-8?B?MWgyYlNndW9OTy9sWHJtaUpHZE9wbVpaU3g1VzZCN2xlM1RqVk15b1crL2Ir?=
 =?utf-8?B?R0dSM29wbVJ2VVIwVVlMeWVDNG91SWM4aWVnVVdPM3BLOGxWTC9hOTBNd1hZ?=
 =?utf-8?B?SWhjN2NKemJTeUk2VG5uZGNxZDM1Vm1pbXF4SndqdTVrSEVEZVJLQUJ2Ymg0?=
 =?utf-8?B?RkVFMTdXT1lqMTZjUUt3Q1FaczU0cnUwZUcxSVpYaWl5ekJwd1BvNU5XdGVK?=
 =?utf-8?B?VUx4WmJvVmg3bGwweDVQeklJR3NyUENlYVNhR0wzd2ptanIvT09lMXVPK1RK?=
 =?utf-8?B?QllBRTZzU2dBRU16azF2TjIvUjZhVE5DZmVBRUI3aVRuU0NIYlV1eTFQVGRu?=
 =?utf-8?B?cmUwYVZNb0ROK3Q4VFc4M0ZMeTJLVGdRMUJaUXRTZXJJOWN5NGtYL2JWUDlJ?=
 =?utf-8?B?WUFqWnJoR1VNaDFZUEJFdU83SC9FRWJNZmZXMjlzdHQ3Ky9yWmg1enQyQnFo?=
 =?utf-8?B?aWRDWXVuanZzdmxyRldiVnVNbEgyT1c0WUF4cDJ0dzdyYjlkU2lVV0xkcE5n?=
 =?utf-8?B?RjNkUVJaazcwM1ZIQ1JxbjNwQVpuODJrRkI3Sm9lK0N3TTl6VU5XQXZCUnNo?=
 =?utf-8?B?YWcwRHFDclZHS0ZEajNGU1RCeHNhV0NLdXBmRlVzUExpWWNHNTZDY1d1Y0wy?=
 =?utf-8?B?UXdnTEg3YWRsMGcrbG11ZWVZdXkxMU1yeTVMSnNPR2lDdXpSS2lmNVNqNUFl?=
 =?utf-8?B?K2x2S0dVRUFnZHhTYnZLTkZKLzJYbk0welVnb1N6ejd5Sys5K3o1Y2w2dVU4?=
 =?utf-8?B?SHRGazJ6MjVhK3ZlUjArL1VIV0dYTit6bGxNUjlkL0ducTR5cDJGZnZOSk5N?=
 =?utf-8?B?elBjSk9TRFBtQ3grK2RHWjJIUW82cFc5bFRxRzdLN1BmZUZWeEx0N0RwZU1O?=
 =?utf-8?B?ZkFpZzJNblJSUXdEVk02d3FmSW9sbkJqTU0rSkRHVDVlQUsyTUdGU1ZMVnFD?=
 =?utf-8?B?UUFudDcyelhpNGVBQzRTVnRWaXA5eFF3U0xkMzFvZGt1NVFuTG9NY0RNOHlO?=
 =?utf-8?B?NXBQM0hPV2Y1RmtYZEtwUXJTU255TkdMQmRZMXZlQ3lrcjBaUVpZMTd3WlRH?=
 =?utf-8?B?R1QrMTNJK2pQRWFDbWlBOUt1SWFnRndYdWcwOEprVndrZWdTMDc2bzFMVWNT?=
 =?utf-8?B?eTA2VGN4TEVXSjA0aE9ON1dROE1sbDdqN3RNd1RsRTRlYkJST3ZPMkRjWVlO?=
 =?utf-8?B?eG5IYVVVVjVWcjFHSFhsWmpvcTJxVDUzamJaR0lOZEpwZDNVU1hqczRtd0Va?=
 =?utf-8?B?dFNXSmttZ0UxZmlteGI4L3F2WC9DUlgwNXFnZmU0V3NTMzBjNC92bnVxZWUz?=
 =?utf-8?B?R3Mwb25HdlFDNklUYWVWeTRHaTgvQkNKWUhBUlFWU2lRdjIraHA3bGRva3pr?=
 =?utf-8?B?Qy9xYTBxd2tLTlNmbjUwNXQ0ZFFaanZIa2NmMk81ak52ZTJGaldXRGtRL1E1?=
 =?utf-8?B?VlZvZFl3cWxwV0s0c0Q3L05JRys4aXpDdExTd1kzOHBKeVdlMktkeTlHMnJY?=
 =?utf-8?B?dzRWS0N0RXl1N3VucktabldsZ2NHejBVZWZFNWJDdXVHSk9kYm54WUdXampz?=
 =?utf-8?B?RTVsQlkrL1hyVXAxdmdodGhIQXcvaXNRd0g5emxXUnZxVmpMdmdjeUY2anpZ?=
 =?utf-8?B?WkZmRlFnVkJFMThnbWxhMm1IZUYrUnd0T0h4T2k2Y2pvWTA4eC9IdndnVmE1?=
 =?utf-8?B?SlFkWjRpdWp2SGVueEp3WElFanFnZUNmSVM4SjU5VzdnWHNEblFOVmZScWlK?=
 =?utf-8?B?V3RXSW5PVVVkZXNXNEoxK3JsaXZSaXJ6TUU4SUV4bGwxelppWnVsRDErQ1Za?=
 =?utf-8?Q?Fn9hDfuY6RDUKPePQRfwbe7Jo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6258715e-97a6-4e1e-13ee-08de3bed7594
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:20:20.0984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUfQgqklNIrmVk1qe+IlfguWMCZH/f+Rhm7izAYwGcLNRaX2tyWv31cBXU/3uhuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

On 12/10/25 00:43, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
> to GART as mtype RW caching, to reduce queue switch latency
> 
> Add GART mm_node to kfd mem obj to free the GART entries after
> MQD mem obj is freed.
> 
> Use resource cursor to handle VRAM resource which maybe on multiple
> blocks and use cursor_gart to handle GART entries.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 89 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  5 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4f8bc7f35cdc..ae4f60aeed14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -880,6 +880,62 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	}
>  }
>  
> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				struct ttm_buffer_object *tbo,
> +				struct drm_mm_node *mm_node,
> +				uint64_t flags)
> +{
> +	uint64_t total_pages;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	uint64_t page_idx, pages_per_xcc;
> +	struct amdgpu_res_cursor cursor_gart;
> +	struct amdgpu_res_cursor cursor;
> +	uint64_t ctrl_flags = flags;
> +	int i;
> +
> +	total_pages = tbo->resource->size >> PAGE_SHIFT;

Please use tbo->base.size instead.

And it would be nicer if the calculation was in bytes and not pages, but not a must have.

> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
> +	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 start_page;
> +		u64 npages, n;
> +		u64 pa;
> +
> +		start_page = cursor_gart.start;
> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
> +		n = 1;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +					   flags, NULL);
> +
> +		npages = pages_per_xcc - 1;
> +		while (npages) {
> +			amdgpu_res_next(&cursor_gart, n);
> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +
> +			start_page = cursor_gart.start;
> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
> +
> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +						   ctrl_flags, NULL);
> +
> +			npages -= n;
> +		}
> +		amdgpu_res_next(&cursor_gart, n);
> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +	}
> +}
> +
>  static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>  				 struct ttm_buffer_object *tbo,
>  				 uint64_t flags)
> @@ -1017,6 +1073,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  	return 0;
>  }
>  
> +/*
> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
> + *
> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
> + */
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	uint64_t flags;
> +	int r;
> +
> +	/* Only for valid VRAM bo resource */
> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
> +		return 0;

Please drop that check. We really shouldn't touch bo->resource->start any more.

Apart from that looks reasonable to me, but I'm wondering if GART re-creation after GPU recovery will still work or not.

@Pierre-Eric could you double check that?

Regards,
Christian.

> +
> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
> +					 amdgpu_bo_ngpu_pages(abo),
> +					 0, 0, 0);
> +	if (r)
> +		return r;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
> +	amdgpu_gart_invalidate_tlb(adev);
> +
> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
> +	return 0;
> +}
> +
>  /*
>   * amdgpu_ttm_recover_gart - Rebind GTT pages
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 28511e66d364..a8b8a541e21b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  				 struct drm_mm_node *node,
>  				 u64 num_pages, u64 alignment,
> @@ -192,6 +191,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		       u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..edb72f4ef82d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>  	      struct kfd_mem_obj *mqd_mem_obj)
>  {
>  	if (mqd_mem_obj->mem) {
> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
> +					    &mqd_mem_obj->mm_node);
>  		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>  		kfree(mqd_mem_obj);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 14123e1a9716..5828220056bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>  			kfree(mqd_mem_obj);
>  			return NULL;
>  		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
> +						       &mqd_mem_obj->mm_node,
> +						       &(mqd_mem_obj->gpu_addr));
> +		if (retval) {
> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>  	} else {
>  		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>  				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 29419b3249cf..fdde907836fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>  	uint64_t gpu_addr;
>  	uint32_t *cpu_ptr;
>  	void *mem;
> +	struct drm_mm_node mm_node;
>  };
>  
>  struct kfd_vmid_info {

