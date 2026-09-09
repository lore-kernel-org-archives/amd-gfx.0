Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD64C79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 21:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A7A10F297;
	Wed,  9 Sep 2026 21:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MttsN2/g";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF1110F297
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 21:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9k3lS4w7moBMyx95Sb/pWtIs9ocqujTgXuxJGBwBxMi0Cvviu06geiIG/yfE3TtCR0M9bYUz4k+AeUAbjtjMy2wHVGL23lUrJQ9WL+D94kpQAfM1/uIzUwR54jmJRH2O/cy0y6gA/4bMQoiEQNzWuKmz8xB3fqY7aCTiMrAK37/meH3o+65EtnT4TwwskA0PUhXDyF8AgVq1QwesJFgkRqzT1Hwyq4kz3nAI8VxZn8wq0aTC1ldnpCZkmyr7/256wijuw1qHhUzlVWXrQ+TDgso+yz4HFCOirm7dyIW8w4bqOdD7CJUtmcfC9hpia1EkS9Hu2TISvrdi80A1/nAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5+d4sJjEur+Av6vfvPUrMqUvqobPqzDXh0nnIc7JH0=;
 b=f0mYdKOa1WpRHv4JyP/Q6NEvve5rAIYxGhAOFEXiHpWb/eSZeorDKc7NdXsHnPS4Cmo2eKVNq5uF7OQ6aOm8Hkg7Pheww3JZ5ambh5VT8HflGWeBV6BIK6+mLNbZxLHrb5BNhlt/Vu2ar7uNDLiiqaGdvg2hLmfZZP/odPConT2d5i39yiEVMff9w+3Bq4e97aLiSiLwGRKIMMKM4O0SyxunoM0An2MjKLiMIieLTrkai2PKyu05adAEeE7NuaM3AXcYb80iAjFClE8WKpqfauv7smGO1Z26NdmltkrB9OuaPYiNUm4C0LKX4np+YHFTm83lDMM0DMsKLKg5MDsDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5+d4sJjEur+Av6vfvPUrMqUvqobPqzDXh0nnIc7JH0=;
 b=MttsN2/g3t+ZvL0A2BCsq7ClIP+g3uWPwMU/LkwivMttIf+3DnTstIeiCheev3FuqLa2aSQz8SfflRy18Sfm92ZqZJaf/64vykgpnDec1u2AjJsw5q0AOTDVbv6ee10PETyLjxmrWKhRb7bK+pHn0ODeGrO97ZMP5/KeA4Dgbh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 21:13:41 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%4]) with mapi id 15.21.0382.014; Wed, 9 Sep 2026
 21:13:41 +0000
Message-ID: <d1690b3b-3f91-4f1e-9035-c4508bc3ef7c@amd.com>
Date: Wed, 9 Sep 2026 16:13:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix TCP XNACK scoreboard reset race
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent.Russell@amd.com
References: <20260909201536.942624-1-Gang.Ba@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20260909201536.942624-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::17) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 80837f06-26f5-4680-ea40-08df0eb73964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: L4fysAsDuRf7izPUPSqL6ODadwnYWmha7toHS5lPVeLvVMnbjyA1pK+sV2BlUei4n67YlCbVueEVNYFzaf9M2v0jtFBo1typ8QAEKTCcLWWzTg2Mjgildda3ZPj8u0EhqLbz7kuBbkPPPTlNl4DkIMwR/oGebtTLvGH+d04wQEAsKuzowyBeYw13f071jNVXXzdyr1or8HwkO40CRui9e3MTL/qdQO7kkcvXwAS1W/vvwUpVKf1qy+PiPxpcJw/F7jY6j8ob9PKHmkra8IBIOiWzrEgZ7iIoConXRtV3XJXOVr9vXUXtI6dLXdtslx9HHl92gDqFaIGePHFsfEWwUdto0Y1ECO/FtxGtErRNPN8FBF4i5J/JarMjSYJB5AjcM2667UD90wiPf4xz9xJUcu+k5W4eNcz3maAPUXOGim5P0Hb2iDzOc2IJnGaqHfJXT9UA0IkKlcz4PwHvsmV2g/49m0h6HkEblWYa1Uw/sLS68rzvO0yUmESz4El0csERdb/hqIEji9btWgNtxLpyz+FPxdDhR+3Ki6chLiheO9HMXSCFYYi1qTcNayOo/XJZuM8fheWh7EDRxR/TT21vGlIwz+ixH+jZwGt5hy0mNg6wpdkT2WvHxuLPJWnyTVduxWvR4jiWmlt0L7jPqOmvBedNmI8faQ9KylaQsn3bykk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzlzc2RLSWxLb0NKZmE2YjdtTG1LNUlNb3I0b3ZLc2J0TEliWlRiRTl4TXhP?=
 =?utf-8?B?dzZLdk8yc0dORTluQ21iUTBIYy9aQXlZVld4eEpMRTZ5WER3d1VNY0F3YmNO?=
 =?utf-8?B?Z2pZR1ZSN2ZnWWs0ZmlPYVZRR1FsdG9jcWUzVUl2K1lUY0wvUFNMdVVxODVY?=
 =?utf-8?B?SVovVmtoZkZxYXNmRUx6SzdFcE9RMmlOd0xNSk9nNmJ2bisxTzdqN2xUdUZu?=
 =?utf-8?B?bUhoUit2dWdLRXFrQTl1OUtWd2V0aE4rRk1MUUdvSU9vaEF4alNzaExHcmtu?=
 =?utf-8?B?ZEJpTnF6d2QzTHlCNFR2TVZ6bWY4WGNyWTlqM1FCVEM0WjNhT1haRm91K1ZM?=
 =?utf-8?B?ZXkxYTdTYUVmT1BMSFlSSlBQMXZFYi9BV0FtMVpmQWRUQnNHVHdJVmZ4UGVW?=
 =?utf-8?B?S2RoelFqTmxwbHFPN1NsblZlVktiTjFJcXJGc21BMlhmb2QwaytCMEJxREkv?=
 =?utf-8?B?c3hjT3FQMnl1K2VjZHk3djZYenFnd1ovRUV2V05MVFNhZlo5OVJoNE5ucWFR?=
 =?utf-8?B?M2xKNGVWRDBwTFRZaWJwZ0pMa3ZzK3d0KzlaZFpmdDB4cWNxc2lyT0dONEU4?=
 =?utf-8?B?RGd2ZndPQlRTeUZxbU9iT1A1MDJQcUtwVVJPZ25POGNIcXNKOEozRk82VWgx?=
 =?utf-8?B?YzQ3clIrK1JhV01EVmcxSzNTeEJ5Qm8vREsvdFMrVnc1WHBLQU1sWklNZm9v?=
 =?utf-8?B?NWNHb2k0MThKYWxHUzI0RkxJV1lndS90Z2VnWG5WRWt2Q3ZVL21xVkdnWWhH?=
 =?utf-8?B?bSsxVnoxOFlKeFMxdmdsczd5VFQ0YXJmK1JLam1uUmFsT2UwR2tuWHloNHRs?=
 =?utf-8?B?ekNJRGk4VHBmemxvYmh5cE9hR3VxSzJ5SzA1NFMrTkFzMHJSaHZHUzRmVkNh?=
 =?utf-8?B?dVBlNnpMWTk1dFdxYkhJZzN3YjBnN3NSWEZZSVVqbk1SMmc0QjlneDFFcHEr?=
 =?utf-8?B?dEFWMnAzSUlMeHVJZmE1Mzl4QzMrQzQvS2E4Y21NYU1HU3VVc0ZPRTAyTzU0?=
 =?utf-8?B?Z2tGNmRudXcyRXZIYk5DcWRNMWRlUkdPUVZQampmSUMvSGU4emY5TmRZb3V5?=
 =?utf-8?B?aWk4dHVTanlXN0lUMzM3SUlsQk5BWTZTanRIVElMNWwwMG40c1dtemRzWS9F?=
 =?utf-8?B?M3U3NjRTZVdxeSsvaTJXWUF3eWEyK3IrbEpvcUl2SDVqOHZJMkJjUkpqb3p5?=
 =?utf-8?B?MXczVzBQc0VjMXU5ZExHZGdwTzArbGVIK0xjMUFDRTBPVElTZmJ0UWdoOUVF?=
 =?utf-8?B?eEk4SGFCY1F0TWd4WGFIQkQrQ0tDbjNybnBReEJHQnhLZG12WjhMTTBTYzlU?=
 =?utf-8?B?T2Y4MU80TzVKMjduK1RGR2kvb2VJUnBYYkllWVVtK1dVQnpRWkFJb1JsWXZv?=
 =?utf-8?B?Z1hlSnoxSk1QaWt4Y1BZTlpRZ0lmeHdDa2trVWlESFcvcVlFK01DSFVWeER1?=
 =?utf-8?B?eDVjL2RuZ0Exdkt0eHJycVlKTkNacmJTY1diM25EazBxaGNtR0U1RytReDll?=
 =?utf-8?B?Q0tZYlBWZ1FOdCthNUtTa3FsSlVUZGxwUGhDbjFSK0pkTzZvcnBGVGpxYjJx?=
 =?utf-8?B?VEh5TjJneC9VSEUzaUZrTlF6M3VJRVZFaGdiVDlsZTFydVJtMWhubG1wK2lj?=
 =?utf-8?B?RVVzVFE4ZUZHSmRkckt6ektPTEM4VDRYNTluTTQ1akFZTWdzMTIrUVhiTnNK?=
 =?utf-8?B?eG05TEVpZEhVa2dZMU0zSFgwN2hRUTFHdXhmSUJVYURrRGR2aFU1RkNMb1kr?=
 =?utf-8?B?a3M2WG04Y0tTSUhPdjM0UUtJMWpEL1ZONndCNWRWcnJyZTVRSVBodUp5RVlQ?=
 =?utf-8?B?U2tpSDFnZEMxTFd0VzV3bGFmRUFLeldjZVF5eURlUHBBdkRSOEN1T2psUDZE?=
 =?utf-8?B?Njc1dEo1b1FET2JNSEdwcDNEV2djS1I0R2MvL1FWZHpNT2dkdzg0aGt4Vzk5?=
 =?utf-8?B?ZzhuNWFYOVZSdU8wbGgxUm9tck5RcUgwT0VGMjN2b05hUEFSdzJBaHY1RjBw?=
 =?utf-8?B?dkkxY0hwNldkUElWNkxwdFZSVDZTc2swaHVBVXJpNE9oOTlYck5aaVNUem9I?=
 =?utf-8?B?TTQxVThGdHBlOE4zQ2Mxb2lzb0tSWk93MEdTVm51aWduMHBMN0NYdTZ0NElx?=
 =?utf-8?B?MmZ2c2NHZGpKZTZ1THhQRXBsSVBDa3JpMkhFc1RSb21zc0YvUjZjOHZCRE9o?=
 =?utf-8?B?NEFrL2tPNFI5OHpqaVhXYkhhQWVqcnUwVHJTRVhJUUwzUVpYUmxXYTlaQ1Ax?=
 =?utf-8?B?MGZoTkU4M1F6N2JyallyN3habCt3R0U4cFpNSVpJV3VYYW1OVVRPaGJwTXJ1?=
 =?utf-8?Q?+sgsRgTlJgtG9dYRL+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80837f06-26f5-4680-ea40-08df0eb73964
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 21:13:41.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1toyRO4XRpIPfHWtsDj7g543cf/b4s8EJ1tCKG5aHY5lxeO7aTV93hA/gCV6LP71Rzc6LJRT507vbnqcJ3bQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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

On 9/9/2026 15:15, Gang Ba wrote:

> Fix a hardware RTL bug in the TCP XNACK scoreboard reset path where a wave
> receiving a no-retry FAULT from UTC and subsequently terminating may leave
> its scoreboard entry uncleared when reset events arrive back-to-back.
> 
> This can cause a later, unrelated wave using the same slot to incorrectly
> inherit the XNACK error state, resulting in its VMEM operations being
> dropped even though the wave never faulted.
> 
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

