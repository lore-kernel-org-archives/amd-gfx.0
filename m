Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0E0C021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 12:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31CF10E455;
	Mon, 17 Feb 2025 12:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVxkZKXS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737CD10E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 12:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzwJ3301GhjapQ8Lw5bbL+LFA2mulGTcIz7xPHjzqGXpk2uxYQXFCGmSoOAjQ1hWyGKAOS6gmjyBtOsWOd3OqwPy09WPylG4kyfg9XZxJ7H3CyckG1aHF5Ekdf7LEvzQEv0uG6r99xtis9Zl3Aj3ae03gPuMg3Cs+e6YWoUsweWjF7XxxoFrqay+xsK9w6IV/zitiCFGi46z7pK6sN1S1aQSVe1maJbrH94ID27AHGkYoyK5JuedGfDf2L0fnObNAAYnigGG+Q4w5ClURUy+KMY98uinjp4FQzfWi2rVehnO/lMppYkX7Q62FwBOsbbH6aq9rV1MdeFOKGkE+WvDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYmhoZ9SszHe5MjhD0LLyMsFEtsYy9T7TpbPF98ScWE=;
 b=PSgoo8r3vXh/UUFoAHq9Ne+bx0KhuIFcCAHz2cWVaFTvtnENTxYz/TbauQDirurFkghGyEo6V6B0TD5+IYV1nmKFHeYGIyzXzc9JTrHLXdXDgUzVetf2pcNdRzFh6FZalAY4MWwiVOGTOiNVF/7Sj+nu36lyu8ZSXmRsd/C+cm5C61ruW/7i2mchZfcAuOSzW7a0MOkBQCug1c8uAX3DcEAmj5Cm80V3M6ldXzCCCGKc1RkScFR5yggptVPV7Vw2Mr4V8kW+d2jh/VEp4s82G+9m2pkfac8A2UvrD3Cjxca4NMcoIFN4Cg0CyyAyrwBNc4YXypZPzKOanw2vh40FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYmhoZ9SszHe5MjhD0LLyMsFEtsYy9T7TpbPF98ScWE=;
 b=NVxkZKXS+7i7IWAq6oMHiFLseHViGq7jSZz2hvsZsD+2G09RfOyZjgTrXQRy4m2FGRQYpitp/cqfibQwkGGz+DmVGPTdgxw3wwD2lwIMtZQGEV1LLIp7lAxKkZe6yVJ99/IDYu9yxw8R2HHypZKGiKfjryivtEBwna9SJaokuJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 12:27:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 12:27:40 +0000
Message-ID: <1094aeb9-e243-4fdb-97d7-ade71417790b@amd.com>
Date: Mon, 17 Feb 2025 13:27:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Replace Mutex with Spinlock for RLCG
 register access to avoid Priority Inversion in SRIOV
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lin cao <lin.cao@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>,
 Zhigang Luo <zhigang.luo@amd.com>
References: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
 <20250216024305.687247-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250216024305.687247-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 9523b922-95cb-446c-d3ec-08dd4f4e7869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0t2TzREMmJ1ZFkvVzZOSjQ3RTJValFLdnlhNnptMmdLelg0UzdVbERsVGhP?=
 =?utf-8?B?ZW9KV1g3NCt1eGllb0RKUEVJd0pvMmdmSnp6bGhUWm9hb05qd3hwTDBNZUtB?=
 =?utf-8?B?WFozQTM3MWdab2MvZXV1bkV3Ny85MTdrTkJDOGtiSHdGV0k3c2JvaHNJNzFa?=
 =?utf-8?B?UjlDV3pYUWZQWmU0M0ZzTnRWR3RrYkN3c2haNys0NnNEMFQrOEJ3L01pRzJJ?=
 =?utf-8?B?SDQ2RlpTd2tiNktESkdkeks4andTYVBod3lGMkl6bk9HaVlKdnhkUUtYOXZ4?=
 =?utf-8?B?MEZsVm53TjhVZzFEQUw5TDBGVjBmWnJxc1NyLzJZWGlvVi9rdCt3cUVENjhp?=
 =?utf-8?B?WlZsUXI0cHlEZ2NQZHZuSHFTNVdDTFZzaHA0UEdTc2NOTnFCQnF5Z2VyNThi?=
 =?utf-8?B?NkN6Q09KREdEcDJvcjRKd2pSWVVzc0NwWENmMUVpajVUWXE0V1dFVjRacC96?=
 =?utf-8?B?bEVYeVl4MGlYSncvZy9BeVpIYmlRcGt5VU9FSVk1a2NVRG8xazBaTXRZT0Nq?=
 =?utf-8?B?NFN3c0pNRTZZVGlyVEpVSU9QU0VVdEpEYVFoZE5Ga3Ztd2J1VmVQVEQremJP?=
 =?utf-8?B?Y0g3OWpETXhnaG83WGpneExCUWsrMVE3dVZpYVdGNTY2djZISVhOY2ZlUnJr?=
 =?utf-8?B?UDNHOGlYWHNkdmxOTTBSdXNPamY0cWM1YmhBRHRLcVl5Ulg5VkxJUm80Vk1h?=
 =?utf-8?B?R1FDU2sybW5OQzYvWkJVcDJXUlh2MmVNY0VOSkVzZTJwaUF0UkM2QU55eDEw?=
 =?utf-8?B?MHVTaUptUXBtUlRIOWZ4VW5NWXNOc1hCZFc0SDhtcEwvRVBvdkZYZENaclZK?=
 =?utf-8?B?aytaSDNsc3RvTHAwS0duK1V0VnkyeFY2YnFSQ3hmdHpCWDFZNFd2bEI1TlR5?=
 =?utf-8?B?OVZSeHNlejBLSm9lM2F2SDhYbXlac2xzalptQVMzUVRURzJ2UTJ6NjQxaEw5?=
 =?utf-8?B?NHdQeVVzaGsvZTdlRnZwRkx0RHlLdXlCZDZsdTljSGJ0SDZtNlpGci9FelBs?=
 =?utf-8?B?Ykdra3I4UnVEdXc1Wkh4bkxITkF5OXpTWCs5dDJxLzJZakt0Qm55bDdYRDRh?=
 =?utf-8?B?UGtrS09rOXRVUDhNMmZZTnU1bzZkUGZ0MGpxdkloa2J2ZkMwS29mdy9KUEtP?=
 =?utf-8?B?UG44d2hqeUdmQlBtcGZEd21wMWFwUjFoOEowZm5IcmNzTksrVThtUnBzeGlR?=
 =?utf-8?B?YlpJcjB1M0dIbXZnWWt3Ulpqc3pTQ1VNbVgwbCtvV09DcHB5Slo1OE44VTNP?=
 =?utf-8?B?bHJ0ZGFkNnNhL21NZGw5Q1Y1OGpQMTNwMjFoTnpUcHdRZUcyQjNMeWc0UWlW?=
 =?utf-8?B?UlY2dG93QlQ0em93Y3VTZEZRcmtLclIzU3RVTVNlNWJsRkl5WkFacmphUTlx?=
 =?utf-8?B?Y3djNDBGdnhNbStnc3VzeXF6Qk5nbTRMZEVzL2dmR3Jya0VjbGszREdzb0JZ?=
 =?utf-8?B?TFRlNTlxMThKZDdVOVYzVys5N2lxUFFNQ2hxckdZdkZHVUwxVGJ6cnVHcFRs?=
 =?utf-8?B?RkFGdGpXeDJKNm9RUnNCb1kvSVJoelBOZEs5dU1WL1c5b0hoTDlKN2s2eGxz?=
 =?utf-8?B?M1FtQW1ZMnVvdnpaVzJ4V3lsRjJoL3VGeDQwUE04ZkhFeUN1bE1MM1lsS2d3?=
 =?utf-8?B?TG01YXErbEZOMkRxMVJucVRSV1JPSDRoWTVyeS9hUlBYNkk4WnY5NHFhWkdL?=
 =?utf-8?B?ZUdHczVUc25qcE5hM1JFVDVVT1FXZXoxazRMOHJ6bmljejgraGM2OEM0Skpr?=
 =?utf-8?B?UEE3NW9pR3BETmR4WFhIQlBENWVUbkpYOFU1VzIxVHFHakpUREhFWlR4NENh?=
 =?utf-8?B?UGJGbis0T0V1WHIwdDNPRnNOR1BBUFV3Sk8rczdvT0JpdUF1RzhmRjBxQWdl?=
 =?utf-8?Q?NztPVKuvYJAo+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNUWmxmeGQzeG1PQmllOFdZU08xZUVaUzZ6MjUzVnFqTzdITmFTZ2tHUkFm?=
 =?utf-8?B?b010NVFVWURhMmIwWmJDVmo2UHlYWjRQQ2FHby9VUkY4cklOK0JaamFYVWZh?=
 =?utf-8?B?Zk02em8yWStBaHdqdGpRdlpCZTRUQVdlQXNsSFNTckhPdnh0Vno0RzJia1R4?=
 =?utf-8?B?bmJrZ1F3TDZ3WXVSWldobUlQNFZJTGtXTzk4UUQvWndYeDBpQm8wTGdQTG1V?=
 =?utf-8?B?Vi9ucjVXbzBhV2kzNlZ2WTFUMHM2b2l3WEFCKzFZOFdlSkVUUVJLTDlvU1Ew?=
 =?utf-8?B?ZFZ6UXJnaWYrZmpzM1hBSU1INTZpNDVNRGlyZ29SS3ZBYWdjaUl1VlBZT1dH?=
 =?utf-8?B?U1hiV2ZjejVZTmdOc1BISWgzak5HR0tkQkYxZlB2VG1MUnhzTzNrM2JIaVlt?=
 =?utf-8?B?cUdBWFlXRmVFa1ZNSkM1NkQwaGxUTGxwUjNyTWM2VzJEM0liWkJBbUdCQklk?=
 =?utf-8?B?MHFERTBEaUJ5UjlBaWV5cWVsT0JzbkZkakRpSkMvQ3ppSm5ORnhMRGJXWStE?=
 =?utf-8?B?MzRsMk9Gbm5JVlZaMHVLQTdBcHdPOUJKZUZkZXBpUW9VN1l0eWxXQmtqOFM2?=
 =?utf-8?B?SHRDdFRCMkI0OVZjOUsrTmVVUEtxb1dGNjRNcERNSkdpTys0dDBXdUI1TElr?=
 =?utf-8?B?WHRIelovZXZIUExTekRNcjlDWTU0NGE3ejJES2kzaE10SjZXZ0JPTXJlVytY?=
 =?utf-8?B?dHQ4MmJQSXNNUXBONE5XYUlJaThNRXFVVVdreUM1NlM1L0o4WEdUTEdDNndY?=
 =?utf-8?B?RVplOXVsVEdwL3Vtd1dMM1hrVi9DK080UEY0RWpXN1l5UUJJanIvSjR0cDRW?=
 =?utf-8?B?YlhHNERZM3dxMHNua0FSVnBFYUJBKzdzK21MZUlBSlVzbTVqMDVXU3V4aGtl?=
 =?utf-8?B?VHFJTHlhSUZleEZRZU5sWHhxaGg0enpOaFlTU09memxBN09LTnNuUDVsM2cy?=
 =?utf-8?B?MGNsWUhaVDhXZE5MTXp1cWF2cklKbGJJMlRHSFB6VGJOdWJmcjVwZDVKZEIr?=
 =?utf-8?B?eGVIWjJkQnQyQ0IyNHJOZW1HMElmWnJiWXVZeDJpRFVtTDE4TzAzWjJZYzJu?=
 =?utf-8?B?WFdPV3BlbUJuS3h4Z2pVRERZMFlYYVZPMzcwSjYyR2JEbzRiYnJQaVY4OUZV?=
 =?utf-8?B?YTdzUEdvTWhWcHRKQ3NlbWo4MjE0NUNNQUJrbzJxbk5IQXJlRkRab2Z0U3BN?=
 =?utf-8?B?bThzcGFhOVVvcGtML29mZXBKR0tzaHpReUJ2RjNER1FSN29FbG4yS3dmQ09P?=
 =?utf-8?B?YmNDLzJuNk1tSzJKUUNqdGoyV0JnUTZlbVJLdXI3a3VxV2kwYTJWWnlycjZO?=
 =?utf-8?B?a21GVDNQQ05uZTZob2hnNW05bnJXKzdwMUVNMU5vTGZDS1pwQU9aUXBjRzRT?=
 =?utf-8?B?UVBiWnhvcy9YSVZ3aUtiY1MvdWkwbEYwY0NYVUFua0lwV3pXcWFKVjIzRURR?=
 =?utf-8?B?OFUrZVlXNkNXTG9HZ0sralhrN1RjbXZQUm1sTkVQaHNJazBuQmJabCs5enhQ?=
 =?utf-8?B?VEJPRk5iWTJueFlzdTc5Y2Q0RVNPT2VRdjM4azdKQ3l4cFhoRFFPMGFWYXNm?=
 =?utf-8?B?REtvUytDSnJXQkRCbEtFMFQwV3lnb3ZsRGZ6Ujc0VUdNdFJkV3pNOFdXZWwx?=
 =?utf-8?B?cFZwSVpTaW1TakUrT2FNV1poR25BYitjQmF4c0R5d0VHRWJRNnFYajFLVXgv?=
 =?utf-8?B?ZkZOUmZsaW1aenRzNEtYb3NRVTgzNnVCN3ViREE1amM1bnRsN2x3eDJyZnRn?=
 =?utf-8?B?TVhPVkd6bHpqSGIvbkd4WTQybVlCUnMveWM2VVRQUFdDTk1xSGZpdG1mTmQv?=
 =?utf-8?B?NDUrakhvVjBjSVBVNmhWRTU2djBZUnVUQjR3cldsTTEyZVZkZ2ZJS3pJS1Y1?=
 =?utf-8?B?OTdpbk00VWF0RUVKWlhCQldpWSswM0R2Y0hrWXJaNlM4Rm9xV05YYk9hZFVG?=
 =?utf-8?B?UmptdWJoL2F0cGlHOU1idmM3dDMxRFFFcEQ5TXBIbTlVNUxTLzBYRnhVYzVz?=
 =?utf-8?B?OGxoczl4TElMb2xib0pJZDl4WjBScW9KYjh2d3JtQmxnamNlVU9veGkySFZn?=
 =?utf-8?B?VUU0S3MyaGJzY0t6cUFqdlkyQU11L0tNeWN1aUVrMVNwSWdod1E1YlJJK0Vw?=
 =?utf-8?Q?UaSm2/Iij8Z6aLjLcGGvDONPp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9523b922-95cb-446c-d3ec-08dd4f4e7869
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 12:27:40.5376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Xb9Bimk2ORJqI5iogfmEUoP00JhcIBaVMTzYrOs7wmHarianPqW+GO9Nrqcjq0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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

Am 16.02.25 um 03:43 schrieb Srinivasan Shanmugam:
> RLCG Register Access is a way for virtual functions to safely access GPU
> registers in a virtualized environment., including TLB flushes and
> register reads. When multiple threads or VFs try to access the same
> registers simultaneously, it can lead to race conditions. By using the
> RLCG interface, the driver can serialize access to the registers. This
> means that only one thread can access the registers at a time,
> preventing conflicts and ensuring that operations are performed
> correctly. Additionally, when a low-priority task holds a mutex that a
> high-priority task needs, ie., If a thread holding a spinlock tries to
> acquire a mutex, it can lead to priority inversion. register access in
> amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.
>
> The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
> called, which attempts to acquire the mutex. This function is invoked
> from amdgpu_sriov_wreg, which in turn is called from
> gmc_v11_0_flush_gpu_tlb.
>
> The [ BUG: Invalid wait context ] indicates that a thread is trying to
> acquire a mutex while it is in a context that does not allow it to sleep
> (like holding a spinlock).
>
> Fixes the below:
>
> [  253.013423] =============================
> [  253.013434] [ BUG: Invalid wait context ]
> [  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
> [  253.013464] -----------------------------
> [  253.013475] kworker/0:1/10 is trying to lock:
> [  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.013815] other info that might help us debug this:
> [  253.013827] context-{4:4}
> [  253.013835] 3 locks held by kworker/0:1/10:
> [  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
> [  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
> [  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
> [  253.014154] stack backtrace:
> [  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
> [  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
> [  253.014224] Workqueue: events work_for_cpu_fn
> [  253.014241] Call Trace:
> [  253.014250]  <TASK>
> [  253.014260]  dump_stack_lvl+0x9b/0xf0
> [  253.014275]  dump_stack+0x10/0x20
> [  253.014287]  __lock_acquire+0xa47/0x2810
> [  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.014321]  lock_acquire+0xd1/0x300
> [  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.014562]  ? __lock_acquire+0xa6b/0x2810
> [  253.014578]  __mutex_lock+0x85/0xe20
> [  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.014782]  ? sched_clock_noinstr+0x9/0x10
> [  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.014808]  ? local_clock_noinstr+0xe/0xc0
> [  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.015029]  mutex_lock_nested+0x1b/0x30
> [  253.015044]  ? mutex_lock_nested+0x1b/0x30
> [  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
> [  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
> [  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
> [  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
> [  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
> [  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
> [  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
> [  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
> [  253.017493]  local_pci_probe+0x4b/0xb0
> [  253.017746]  work_for_cpu_fn+0x1a/0x30
> [  253.017995]  process_one_work+0x21e/0x680
> [  253.018248]  worker_thread+0x190/0x330
> [  253.018500]  ? __pfx_worker_thread+0x10/0x10
> [  253.018746]  kthread+0xe7/0x120
> [  253.018988]  ? __pfx_kthread+0x10/0x10
> [  253.019231]  ret_from_fork+0x3c/0x60
> [  253.019468]  ? __pfx_kthread+0x10/0x10
> [  253.019701]  ret_from_fork_asm+0x1a/0x30
> [  253.019939]  </TASK>
>
> Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Victor Skvortsov <victor.skvortsov@amd.com>
> Cc: Zhigang Luo <zhigang.luo@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2: s/spin_trylock/spin_lock_irqsave to be safe (Christian). 
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index eab530778fbd..14125cc3a937 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->grbm_idx_mutex);
>  	mutex_init(&adev->mn_lock);
>  	mutex_init(&adev->virt.vf_errors.lock);
> -	mutex_init(&adev->virt.rlcg_reg_lock);
>  	hash_init(adev->mn_hash);
>  	mutex_init(&adev->psp.mutex);
>  	mutex_init(&adev->notifier_lock);
> @@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	spin_lock_init(&adev->se_cac_idx_lock);
>  	spin_lock_init(&adev->audio_endpt_idx_lock);
>  	spin_lock_init(&adev->mm_stats.lock);
> +	spin_lock_init(&adev->virt.rlcg_reg_lock);
>  	spin_lock_init(&adev->wb.lock);
>  
>  	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 2056efaf157d..e6f0152e5b08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1017,6 +1017,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>  	void *scratch_reg2;
>  	void *scratch_reg3;
>  	void *spare_int;
> +	unsigned long flags;
>  
>  	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
>  		dev_err(adev->dev,
> @@ -1038,7 +1039,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>  	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
>  	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
>  
> -	mutex_lock(&adev->virt.rlcg_reg_lock);
> +	spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags);
>  
>  	if (reg_access_ctrl->spare_int)
>  		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
> @@ -1097,7 +1098,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>  
>  	ret = readl(scratch_reg0);
>  
> -	mutex_unlock(&adev->virt.rlcg_reg_lock);
> +	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 270a032e2d70..0f3ccae5c1ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -279,7 +279,8 @@ struct amdgpu_virt {
>  	/* the ucode id to signal the autoload */
>  	uint32_t autoload_ucode_id;
>  
> -	struct mutex rlcg_reg_lock;
> +	/* Spinlock to protect access to the RLCG register interface */
> +	spinlock_t rlcg_reg_lock;
>  
>  	union amd_sriov_ras_caps ras_en_caps;
>  	union amd_sriov_ras_caps ras_telemetry_en_caps;

