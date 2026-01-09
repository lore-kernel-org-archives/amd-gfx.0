Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8A1D26D6A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 15:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AA110E012;
	Fri,  9 Jan 2026 15:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/vIZoXF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5155A10E26D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 15:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNTV4fRoWpglrXR8OBySwh7ihJLI+HMp3fNQfOnfIZGUBqBdZypP8rSTLZ6BwF3olepYxij9QbUJ99+8cnHO4MTWmlrEL2xI5lKfrJr72hJSxrbE6NTiZMavK0SiBiz96N3/sgrcaDZJKDloSJrmLvTYoaXM4A3NJwUg45orq0gAule023PNggP3XKuLAAt/vawDX3ktsbeSS+Z6cQtvLjtzWzb89ubIPjAV5a6DL6I4RF5I2PmZDgoeDUJUC/U6d9gkYc0TkPWthTdY+zjua7JEuCSXL3H8PVGgf7r2fiz46dsEt7LlJambYrtMbb8wkJrQXA2bwS4Bb6syX391sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG2h6Mbe7R463BObgNrIxB72XuF8s97a4BPht/ZEKpI=;
 b=RF4fVh2eOLzewGTLFMFVKezQOWhuYTzEBJ1lN0p32Ft4EtVojWII3OOzO24Y78NCyPLtKHoMfn2ox3QV2iFur52Gji8vfgTJLXon9P7svyvBaPgqO7IQf0eim3IbYHfQjS39yASQsoa6oOmHNXgAww7EnAPeVlGQqEAaSrpPL+dy3PxPmg+J9sWhPbFACNzCALZLe15x507jvr/8egZvaKVD2vpie7HHl/TZJMfO7MqODiF5OY+kH4V36N3OwAEAeKyu/tmyDAueiJiQzTMY+V08cZs4k2IkHU8I8qbDjtJKw8zDEGzDh8ZCuC1EIexLhet04JeJPthGafFtItl1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG2h6Mbe7R463BObgNrIxB72XuF8s97a4BPht/ZEKpI=;
 b=P/vIZoXF/oU3qhKK8/E4a0wqBhkI+JQU/9v7jeNhTBOLPtHXMXrZH+3cyNm6QQLZzeVEA9ruSCBej+nVlap6JkM5Uo99PE5KwPoBZqEucECUXkUvzl9cQLuSakwBfX84wduZXeGKVzuY4L6MCVK6WRAKiqK5FTrycWkZT1VLzKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 15:40:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:40:23 +0000
Message-ID: <93e3af4f-a323-4d4d-ad13-1512105beb9e@amd.com>
Date: Fri, 9 Jan 2026 16:40:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
 Last Fence Update and Timeline Management v6
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260109144141.103695-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109144141.103695-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0713.namprd03.prod.outlook.com
 (2603:10b6:408:ef::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 170e92c9-5161-4597-0332-08de4f9566cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFVwVEdkbFJsdWszU2FKRUIzN0Z5MWhFcnBWeVJOQTVRbEFEekp0T2pET0dm?=
 =?utf-8?B?N2VGeE1HUTVPUTBTSGk1RnhOSXZDeUw4TzJCT202U2VPbzFCVGovTklaMnYr?=
 =?utf-8?B?NS9aZk1rU3VLOHhHZmVGeWY4Rk5oUEhTZVRKQXJiZkVWT3FGem5HeGp1cVAr?=
 =?utf-8?B?Rmk3M0MzcmFYNFFkc0V1aTBLU1RjNzZQUThEQ1MzdFZFNVBZMHN1bEJRVHBB?=
 =?utf-8?B?WTBxWTRScmYzekx5R0g2clAxWnQ3T1M4SUxsdnl3S0FjTXcvWUF1NTd0SnhL?=
 =?utf-8?B?VWR3YjJYZnNDWVUzaHNPOW5DNTczMEE0bUsvclkySkNUN2NrTmdBSU9pTDhB?=
 =?utf-8?B?WjRCbDY3d3BSWHhqTUZTUjRtZmk4b0xoa0Y4WU8yLzdjSHVyR2ZoZUNUUGp3?=
 =?utf-8?B?enNtM1ZiaUxST0xTcFRrQ05kTXJQMHE0SW5TSFhyT21FSll1L3VzaDBsS3hL?=
 =?utf-8?B?S2lOUjZPNUNveTQ0dk1Nek5NWWtnVFd0UDVUK2IxN3dSM09lSzB2djAvQVVx?=
 =?utf-8?B?YjROZ253Z2tnU01PYlBnMmJ2RWVpNUovd3dUakIvQyt1VTQ4NUprUFhIeUZh?=
 =?utf-8?B?Vk5QTUxpY3BzOWVrdlE0ejJleFFOUG1OZDVnVVc4Zk5IcTRnRW9oWURwak95?=
 =?utf-8?B?K1EvMzJNWDNJQTdha2pwemZXaUFqaEVRWlVRam1aWldMZU1xSWxwbC9Wb25x?=
 =?utf-8?B?ckV1L3o1ZWUwWDQwTlc0aSt2NDhKcFVqblk2WWUyN2hNLytjcGFDc1BXZVlB?=
 =?utf-8?B?akFiTDR2b0t3T2lwRSs1N2VyYjBVNWRVbGlJNVYvSitjbEdBNzhYYUtmWXYz?=
 =?utf-8?B?STlWbjcwR2JNaXV6THFZY3VuRDd5eHE0WWh3L2EvQ3k0T0pzNDY2MkR3TVFV?=
 =?utf-8?B?WmlvTDVxMW0wejArWUQwSnJKbzYydjNsTmZPVmRPSmQwZFJmMnBSMFNIYXNH?=
 =?utf-8?B?SE04RjRjR2dxQjZpSFhaT2grV1ZFdWFLMDUxZFg4VllpN0VhQ1ZFWkxrck51?=
 =?utf-8?B?ZlNRUkgzMmlhOCtWM056M1ZIZDk2QWhRZVZNdkNtZVhxVWJUK2tEV01YU3Nj?=
 =?utf-8?B?a04vK1FhNXVnaTA1NEZjeG1uZVR5M2lOdzBGeXNvSmpVaDIyTXRtZDF0OWFK?=
 =?utf-8?B?QjVoRXBvNFN6LzNUQXNzMjJ4bnpLU0cybnBNQmdzNDNuRHZSMmdpSzR5NmNQ?=
 =?utf-8?B?VE1FNTJpQWFCMzhiNDZaSlJiZllyN3VxK1BtWlFQeDBtT0ZkbzZ6a1Z6VXEz?=
 =?utf-8?B?SnVFa1FXUkRQR1BpSmlxUUwrWGhrQjFTbFdNQlkra3pZMWRWazJ3WERVLzNn?=
 =?utf-8?B?RjNOT2FRMGFtUzNDZUxYQ2dBZDBTQUhBSnNJOWgwYkNUbHo0Y0V3cUw5eVRx?=
 =?utf-8?B?N0JyTHBodmwvQlVWait4SXBUeEM3R1J5UFNkN0U2VlVKZlI3djUrUXZXSzF4?=
 =?utf-8?B?YjBPbXZMb01MZm11ckZtUWhYV0JmZmZCQ01pNEhuaGJiYTQyaDNyTzdJUVkv?=
 =?utf-8?B?ZFB3SUhsMTR4bWl2UjlVbzAzTURreTNpdzkxVXRFci9jVTN3R1l6b2lSMjhp?=
 =?utf-8?B?WEs2amtGN29ML1JlTG5SMEh3KzV0cTE3a0JpUDhJOTZhOVpxS05Md1hjUGIz?=
 =?utf-8?B?clA0Y3FpT0hpS3V2TzE3MXgyS1NIQ0daZzVIZHQ3UTF4VWtuRDNBalM1NzVy?=
 =?utf-8?B?bmtjRjlCNFR4Z0c4VS9EN29ENkhSVDNMdzF0RVlPQVo1WmRUVE5rREtLZWw1?=
 =?utf-8?B?YlUwZUIyWjZsODRkQmQvTUloV0tidUtHV1ZXYk5xYklaQTJ0bzZzYVU3NGRv?=
 =?utf-8?B?VjJURXJodC9TSStLcnBWU0g0eE1rRnYyWFZuNE9rZk5TbzdnSGVEOTFXWEVm?=
 =?utf-8?B?eEdCQWk3RU1Da2dpYkVwY2VLdzJEL1dhby9nT2VSd3RhK29NV1ZUekhadHEr?=
 =?utf-8?Q?E3hAiE8tfpnAh5pZCbZnRjFRgyWy1fGz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVGZ3pvMGhtSFVtMjVWZ1FudDlSOFJPNy81elZZL3lqNFRwSUFNbkpJMXlq?=
 =?utf-8?B?b2JBL2RMTFA5UHFlaTViUWZPYUM1WEpZS3B3QVd1YmZxWWU2djBFL1FySm01?=
 =?utf-8?B?Z0dPa1dGTXBxL2NtM2NyTmNqNFNZeVlCWi9WQWNrZzlFMVJMcDkrTGgxK1lU?=
 =?utf-8?B?VzVNNlM2aHZGdGlud1hnNTQ2THZ6V1p2NWFESDBiR2VXeTNKZFlhRFZNZ0Q5?=
 =?utf-8?B?RlR1TlBXcnBPQStEU2UyRzBhQnBFZEUwa09oWGRIT0tjdTRocVFieXZZTGdJ?=
 =?utf-8?B?M0o5VGIzUHZNZU5MRUVTdEsrTnpnNGNKUmhudTc2bDJWYzV0YzdlcG5GR0k5?=
 =?utf-8?B?a1hQeHhZWndKeTNZd3J2akM5alB0SUo3ZEowMXh5RzdYR1p5ZHRYZU5TZy95?=
 =?utf-8?B?Z1ZTSnF3TGtCeit5ajBxVWFMNS84QjJxMzZuS0xpdE5WOTdXV053UUV2NmNp?=
 =?utf-8?B?aFQ0UGR4bWl2MjQyN0lNK2VtN1dOOUZCeDZZTU4yU09BazhhUGNoWnp2WkVT?=
 =?utf-8?B?Uk4wSmJ3RUJlZFltWEFHcldMelplMmlOblhvc09zdXRTbXI4ak8xd2dlQTZu?=
 =?utf-8?B?QStvL0pXZVJSaTNwQUI2emhsVVcrTVRnd1JVVlJYWnNDYXlEaUt3dXJkYjU5?=
 =?utf-8?B?S0M1dEZCWmM1MmxGbFhOV2Vsdk4wQXNseU5ndGIzeXdlUk1RNTZhWjhKeGM5?=
 =?utf-8?B?aWxLWmxaZ2JaWHNYMm83QjVvejhXM05BY0hxQm9SQVBFUGJMTWltTHJNRnM0?=
 =?utf-8?B?VzJ4TWZUVFBCdGc0YWt5VjRoRnBLTmlRL1pTQzh3aFRQc0RCOElkRHBoUmZ0?=
 =?utf-8?B?L3F3VlBZM1c1MkZQMTZ6YnNodG1MRWZHZ2VzQkVxalo4aG5rcUlWYXRVN1hp?=
 =?utf-8?B?S1BSbzdaUGEydVZGQ3poSkhVME5BSWxERTF2bUc5c0pEN1J3N0ZFaGtyNStv?=
 =?utf-8?B?bTRoOWhVdmZhWHNaNGYzUFlFKzFoOHFhYkhqNlU4ZGRVTEM3c1h4VlphdTA0?=
 =?utf-8?B?RVNNZVNzb0EvSHdsRDVoSWdMOXh5UTQvSjRpNzY4Z0VEN0pNcU1qSlF3WVA4?=
 =?utf-8?B?YW5hZTIrWmpYdW1YZExmQWxYMi9FZFU4Ni9NZ3VUOHQ5TFQ0NHlhczFlTFo0?=
 =?utf-8?B?YnlpUk10TjhUWEpNTkZBajRmZ1V5MmgvckJNU3ZBL1hvMHJ6L2ZpSkxJa0Nq?=
 =?utf-8?B?alFuVGJ6SDl4MHRPa0dweVlDbGdZclRKbzhaN0N4cThkdEJIMHFXQTEyZ2NK?=
 =?utf-8?B?d3ZkL2VpQjAwRXNvbnN2VWdTcDl3YVd3ZW1oWStrYzllU0x0VkI1OUwxWVFm?=
 =?utf-8?B?WlR2SGIyc05Dc3R0aFBHSlh0bEJTSWlJNHZTNkxzaWJCWWtxaVhBbFBaak15?=
 =?utf-8?B?NDBDSnpNTytGRnBydEVLaWZZNDBodmpUOHcwa2x3R1JxUzVXbXFJZEY5b1U1?=
 =?utf-8?B?OVhJRTB4dVVmMUdCbWlrREg4UVBrci9xLy9Gdjdid0RHVWtZVmxTWkNyRzlZ?=
 =?utf-8?B?UzhlSjJPWGFsN002bWluV1kwcktGWlUxanJubjdLZUNYWEd4QUxQL3Fzc3o5?=
 =?utf-8?B?NE1TNHNHYkpvTTJJMnRhdHZ3Vm96WXNTdU9rZUJhSHBMWHhuTTY4UE9tOXMx?=
 =?utf-8?B?SW8rL2F0a1FaelNqSVJCRmxsOHhRQnNpczJrT3hiRXFtbzF5OFpvOWV1a0hV?=
 =?utf-8?B?YlU1MWVlazQreEsxaHJrdklpVXI3VHVpWnUyeGVkelBycUtHUEE0ZUxSa0RU?=
 =?utf-8?B?RVA2eTFDVXhvSVkwK1JIb05zUGJJK21ZOVlpcXVPTWxEalJwMmE4VzIrS3Z6?=
 =?utf-8?B?T0xud0pXVG1YV2tPcWRhR2hvZGM4TUQ4aUY2T0p0Uyt4TFUxdnozbDcxUWMy?=
 =?utf-8?B?aGNvNm5PRUlCaHpPRFpVWmRSbHVTZFE2V1RlS1gzbFpXcnJvUDhVdXRUTHFu?=
 =?utf-8?B?ciswbGE4WFQ3WTdnVmdON0hOTUh2UVROOUkydUxPc0xmTkQ5bllacERKRHdJ?=
 =?utf-8?B?NzFKeVFISWlpRjNrdVc2MG1vV2h4L1FHdVF3Y2c0dlJ1QXpHSFhjR3MrbzRR?=
 =?utf-8?B?VXNoMGJ2QnFEWndOSytTdGttaVRKcWtRU3h1M0xhYUFlSUlYd0VTTFNBcGM4?=
 =?utf-8?B?RlhYWXZRK3RyVncvSld4T2Y5NGVNY25KMTFwamFtd1Q0NEEwSm9iNGxoN2hz?=
 =?utf-8?B?blBhcnl4ckIraWtMMXRqZEU5cmV2QmxwRVdjOENvMWtKTTVpVlVJMlhkOEFY?=
 =?utf-8?B?YnBpcHc5MlJxMmZ5VHlCa1ZJeXNVNUVsNSttSVJHS1h1TlgyYzZvR3N0R2pj?=
 =?utf-8?Q?6tGQ/Hi2xYKHcnm6PC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170e92c9-5161-4597-0332-08de4f9566cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:40:22.8079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHUbYCPV8D3sXq4IX8eM9VlzBpXL582F29pjwaFnAX/u7zJkat7SnWUFMo7ElUHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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



On 1/9/26 15:41, Srinivasan Shanmugam wrote:
> When GPU memory mappings are updated, the driver returns a fence so
> userspace knows when the update is finished.
> 
> The previous refactor could pick the wrong fence or rely on checks that
> are not safe for GPU mappings that stay valid even when memory is
> missing. In some cases this could return an invalid fence or cause fence
> reference counting problems.
> 
> Fix this by (v6, per Christian):
> - Starting from the VM’s existing last update fence, so a valid and
>   meaningful fence is always returned even when no new work is required.
> - Selecting the VM-level fence only for always-valid / PRT mappings using
>   the required combined bo_va + bo guard.
> - Using the per-BO page table update fence for normal MAP and REPLACE
>   operations.
> - For UNMAP and CLEAR, returning the fence provided by
>   amdgpu_vm_clear_freed(), which may remain unchanged when nothing needs
>   clearing.
> - Keeping fence reference counting balanced.
> 
> This makes VM timeline fences correct and prevents crashes caused by
> incorrect fence handling.
> 
> Fixes: 463b33e780ae ("drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 75 +++++++++++++------------
>  1 file changed, 39 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e5fb8f5346b6..c1dc0cae0cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -732,15 +732,23 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			struct amdgpu_bo_va *bo_va,
>  			uint32_t operation)
>  {
> -	struct dma_fence *clear_fence = dma_fence_get_stub();
> -	struct dma_fence *last_update = NULL;
> -	int r;
> +	struct dma_fence *fence;
> +	int r = 0;
> +
> +	/* Always start from the VM's existing last update fence. */
> +	fence = dma_fence_get(vm->last_update);
>  
>  	if (!amdgpu_vm_ready(vm))
> -		return clear_fence;
> +		return fence;
>  
> -	/* First clear freed BOs and get a fence for that work, if any. */
> -	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
> +	/*
> +	 * First clean up any freed mappings in the VM.
> +	 *
> +	 * amdgpu_vm_clear_freed() may replace @fence with a new fence if it
> +	 * schedules GPU work. If nothing needs clearing, @fence can remain as
> +	 * the original vm->last_update.
> +	 */
> +	r = amdgpu_vm_clear_freed(adev, vm, &fence);
>  	if (r)
>  		goto error;
>  
> @@ -758,35 +766,40 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  		goto error;
>  
>  	/*
> -	 * Decide which fence represents the "last update" for this VM/BO:
> +	 * Decide which fence best represents the last update:
> +	 *
> +	 * MAP/REPLACE:
> +	 *   - For always-valid / PRT mappings, export vm->last_update.
> +	 *   - Otherwise, export bo_va->last_pt_update.

Not correct, PRT mappings also use bo_va->last_pt_update (but I had to double check that as well :)

Mhm, that might be the reason why we had problems with PRT mapping in the past.

Please just change like this:
- For always-valid use vm->last_update.
- Otherwise, export bo_va->last_pt_update.

>  	 *
> -	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
> -	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
> -	 *   (for per-BO updates).
> +	 * UNMAP/CLEAR:
> +	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
> +	 *   needed, it can remain as vm->last_pt_update.
>  	 *
> -	 * - For UNMAP/CLEAR we rely on the fence returned by
> -	 *   amdgpu_vm_clear_freed(), which already covers the page table work
> -	 *   for the removed mappings.
> +	 * The VM and BO update fences are always initialized to a valid value.
> +	 * vm->last_update and bo_va->last_pt_update always start as valid fences.
> +	 * and are never expected to be NULL.
>  	 */
>  	switch (operation) {
>  	case AMDGPU_VA_OP_MAP:
>  	case AMDGPU_VA_OP_REPLACE:
> -		if (bo_va && bo_va->base.bo) {
> -			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
> -				if (vm->last_update)
> -					last_update = dma_fence_get(vm->last_update);
> -			} else {
> -				if (bo_va->last_pt_update)
> -					last_update = dma_fence_get(bo_va->last_pt_update);
> -			}
> -		}
> +		/*
> +		 * For MAP/REPLACE, return the page table update fence for the
> +		 * mapping we just modified. bo_va is expected to be valid here.
> +		 */
> +		dma_fence_put(fence);
> +
> +		/* Combined guard required for always-valid / PRT correctness */
> +		if (bo_va && bo_va->base.bo &&
> +		    amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))

I've just double checked and amdgpu_vm_is_bo_always_valid() can take NULL as BO and does the right thing for PRT mappings.

So I think we can just change this to "if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))".

Apart from that looks good to me.

Regards,
Christian.

> +			fence = dma_fence_get(vm->last_update);
> +		else
> +			fence = dma_fence_get(bo_va->last_pt_update);
>  		break;
>  	case AMDGPU_VA_OP_UNMAP:
>  	case AMDGPU_VA_OP_CLEAR:
> -		if (clear_fence)
> -			last_update = dma_fence_get(clear_fence);
> -		break;
>  	default:
> +		/* keep @fence as returned by amdgpu_vm_clear_freed() */
>  		break;
>  	}
>  
> @@ -794,17 +807,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r && r != -ERESTARTSYS)
>  		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>  
> -	/*
> -	 * If we managed to pick a more specific last-update fence, prefer it
> -	 * over the generic clear_fence and drop the extra reference to the
> -	 * latter.
> -	 */
> -	if (last_update) {
> -		dma_fence_put(clear_fence);
> -		return last_update;
> -	}
> -
> -	return clear_fence;
> +	return fence;
>  }
>  
>  int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,

