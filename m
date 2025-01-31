Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92438C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 21:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C34E10E1E5;
	Fri, 31 Jan 2025 21:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYU+LTiA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD7D10E1E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 21:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZGC/JVHMQCoqw4IbEOMFXg92iwkPalsTLsJs/Wxo2KUUd3xVhuDdvt7yn49CKghBBfxLADD0gpTDcRY8NKOmv18O5GUtQsGatijiJfYGwyip2W45oe8EzR7a6bulKVqKchVuv1A6+B6bi6QTUCLC5WmPiYMEZu9QT0k4Arj0SeWDbawDDODObKkGeW2v76S+fITGMKqXkGIoD9L/u/WIjobTkPCYMjTf9RdKy/gh9fHfRI2qOieyNz/oczh9+i+jkJqJMyIG9uTkHXtoNBkAKLsWLilXvlY43hXsm2vYC0/mvFb6VhnaGePxxIyoEep5XK1z/zbZn3+nTMgvNvdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNBqI2dE5qf6EpaHhwDEvOPHBxKpWWRVV3Vh70gCT54=;
 b=yueJQA8KBkL4r7ykRpbZaoy3VLQEFgAxbg1bSkCm8NsCRVOe6x7TXqsfm/Epwaq2wPj1qQ+wEI8yY8V1ndvmv4JbCcCIbJNEqw4jHsnyQYlcvs0QN8r6OR1BF4YKHlj1ZcALPuWqfQoI/2gNybQL8p3hfd8ffrvU865TlY0t+6y5ci+XE/nOcIoRtz+7ur/L2Et2pIdyHytUPDEHjU0/Vw1P+MDcTm3ZKNSJljmU9xLCH6T58MGzdEGXNEDrd7dfQYyYhvmn0pGoHnAFgR9Dhgy7gSs7oYWiKKy8CAydyf00/OBlOUiNW0+PLY61mCsY91fy3mEQrp7z07Wi2n6MoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNBqI2dE5qf6EpaHhwDEvOPHBxKpWWRVV3Vh70gCT54=;
 b=ZYU+LTiACjpXDTj6vFCAov4/9STHm1E/mKfK+iSZACC7sT3eR/t2lQf1A+Km/F4keUedGIPWyF7eUQpoogUbiH6sgTFdYisJGe9XMZ2b2EfRGav39UryCC6WDpLMZgrK0pv8549G+UHxQc67Xy/9ywg5/fRv+svkhMx3eBgRl3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 21:12:54 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 21:12:54 +0000
Message-ID: <d38efa06-7383-419e-9d46-a2e7aa2e9322@amd.com>
Date: Sat, 1 Feb 2025 02:42:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Leo Liu <Leo.Liu@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <CADnq5_OTt63z4unFJAcKCwztJYAMYrPgvp1hOWVRZfhg3=1S+A@mail.gmail.com>
 <c47138b6-5b15-4596-8022-2d63deba0326@amd.com>
Content-Language: en-US
In-Reply-To: <c47138b6-5b15-4596-8022-2d63deba0326@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::33) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4d0025-dfc7-49af-01ba-08dd423c06cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amNqdTBhSkZsVmR0U0pRT1krZy9vUTFCSWpRMHdUZWdGVEJueVlSeFF0Y2lX?=
 =?utf-8?B?Smkyakk0aDRWaUpEY2pxM3VFRUF0MzJoNy9yMDk5cURhQVQ2NXhWd1dzemMy?=
 =?utf-8?B?YnNYRHZZWFhzYUhYNzIvUytadTJmNG9tWDdYRFNDZGFzczJZeW9iWXBYN1RN?=
 =?utf-8?B?OE92UFdYVGJJY3p0TXpiSmdaS2xITUZ1NnhlenQyZEd6ZnVucC9iZmlYb2pu?=
 =?utf-8?B?aXhsZVhHa1F1aUJaTDVyangrVFZCbEhvZFB6WGRHZnp2ZG5QZkRHbGF5eEJG?=
 =?utf-8?B?d3NpSFpiVGZOVytMSjhqdTRIZldOY1hrZlRQK1hVMENBdm52VmVUaXpZVUda?=
 =?utf-8?B?ZzFyQXZBdWgzZEdYdjQ3RE1sYjBSNTVKdmFQZlNzNmVCbldYMUdydDY3dGl0?=
 =?utf-8?B?MmZFZGxYTDN2SWxpQ24zUllJOXI5ZmtldjMyRWVLRUswOEJMbk1ROFhXdjNi?=
 =?utf-8?B?TGxXVEFqK0xFOW1EbEpsMms0NzFsUlNwWllzVEJnWCsrVDlmbjkvRjM4U0Vo?=
 =?utf-8?B?TU5lYWRyemp5S1UxdHBXSU9PU2I0SllqdjBMSzlZeDNXaFR4UGtvL2VCZ3Ru?=
 =?utf-8?B?SWVUeDRZZm1lZENtUFczb094UHk5WHVieFJVUTN5UXV1NW5GTklROG1obU5k?=
 =?utf-8?B?WklxazhkYUpmYjJWTU8rdFhyeE1FTnk2ZlIzTzNMYVh5N3MrZnpic3VmNDc5?=
 =?utf-8?B?NU1lZ1JwNzVsS3RtYmZhMmliYy80bm93TlBheXJ1b2NaZ0tURElZNC9oUHFO?=
 =?utf-8?B?Y0lLNHA3OTNYK2FsZnd1ZFh1cGMvdHd6d0JxRm5NdmxvQ1hTdlV0YkxCZ09B?=
 =?utf-8?B?TUJCdWhOQ05jWFZBN0o5alM1WWZrdVV0ZlI4YVN3ZTA3Ui9ta3puZXp3eXp4?=
 =?utf-8?B?SnpWTTBDTmJnS1RnRXFYeG5FKzMyZlN6cEQxY2JyY1ZOUmVCQm1xdjMxeUpu?=
 =?utf-8?B?MVpIdWJuUEZUUVk1REZZOTZ0cHZMaHFMVHpNSjhRZEtrVWZPaG9Nc0xVOGoz?=
 =?utf-8?B?Zm5kTDROSEJTd0RZUmxOdjVsUmxtaGphS2Q1YjR4ZXF3aEljSEcyaXR1MHRJ?=
 =?utf-8?B?M1BlOGh5aHNqbjdpZ2N4VjVHSFUrQUxjdEo1SWROVU5LTjB6SmZDT2RXQlM5?=
 =?utf-8?B?SllFV1ZmaVpSckNoeTh6WVc4R0Y1enJrdEV2bjRmV01KdjZTY1FNMEEvK0x6?=
 =?utf-8?B?RmNYWmZnQnVkNmtEcmVtdHdSS1d3VTgwWXZJM0NNWmFJWGZZRjlFZktBaE16?=
 =?utf-8?B?R2ViYVArN1dobXJQY3J1NExubjd1UGpFUzM5RDEySlpXVzNhYXh2ZVk0VFhw?=
 =?utf-8?B?OGxINEFMbGJqaWkxOGVVZmx4MkhoOTZUeHR4WjhBREZNSGZVdDlpUDhMcU4y?=
 =?utf-8?B?OCt5akRBZTNhaXJHa3ZhSzU4MkxrM3BUYzF4Z2RYVStwejR3VDZCMC9EYWUz?=
 =?utf-8?B?TGZtb3UxblVZaTNQQnczMGoxaDdhMk45N3VQRnd1ZU9jUEZGL04zVUxucTBv?=
 =?utf-8?B?OVNEMDZRS2JwUjJXa3gvRjNlMjg2RFdVanpEUk1PYnVta3FESk43Q3dwNGRo?=
 =?utf-8?B?U0hYVC80MVlyYWkwZHV6YnN5U1ZGMW81U0Z2RGRIUG9Gei93YWFFZ2ZseFN6?=
 =?utf-8?B?QVR4ZkdrM3ZWWFl2UnJwWDNSNFlQWmlFRVdrUTNSdm1tbTZzWkxWaUhNM0hJ?=
 =?utf-8?B?QVNRTHN2NEVOcUFpM0V6eDdRVlpSTkQrb0U0Ny9RSzhwZDM1N1JtdldCWWxR?=
 =?utf-8?B?V0Y1WkV6MW1DUFFkWlM2OVVJSURMNndVOGtGeXBvcnRtbUtzSGNTNGtoVkxp?=
 =?utf-8?B?Qm5tamkrM1ZobmpmY1J6cW1zQUNMbk9YTWFhSzM1UHhJZnNNWVlmWGVMTUdG?=
 =?utf-8?Q?vlsOHu/hWOFdP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmQyRUpzSWEzSDhkVEtNSU9RcW5ocml1dUxsK21zb3ZRdzhBQ1N0YnFQWUNX?=
 =?utf-8?B?QW9KMmdKbXI3L0tYVXl0T0xrNm9LeHJsKzdtdm5lNmhTQ0xQQ09zTjcyZ2dP?=
 =?utf-8?B?L0FPVjdLdUg2aE55QWc5YnZvYytIdUMvUnBJZ2paMDYxT2lQM2haakNBYlY3?=
 =?utf-8?B?VDU2WmdCaWFrekpEeTA3dy9VRVgwVVNkbThVNXhqNjF3cjU3TTJTczFsYVZR?=
 =?utf-8?B?NFRGRFhqSmlXUXduRWswYjk5Q3o4OTYvRVRjNjZNS1FDWDNHMkMyd2Q2TG9I?=
 =?utf-8?B?dUVSOEN4c1QveGVEOUxISHB6V0FmWlAvT3RQZzNOWGxCYS9Xc1A0ekRKb2tm?=
 =?utf-8?B?NTU1MlJmLzRqMXdJdmpxRHlTVTFkU1c5eC9FMFJzeGNpZTB5b1l2Rk5Tb2FS?=
 =?utf-8?B?OTlFcDUreFI5alRzVWJ3endjby9NYmJmRGhaQ2NYQ3FkL0JjVXVVMk83Sldy?=
 =?utf-8?B?MndDczdnNmZsYVkyN3o5OWpQZ0tZcER0ai9yMUxkamFOS1BFUWxRMkRYK0No?=
 =?utf-8?B?MUlKc1NoRG43TlgzOERpRjB2Zjh5bXE3a29GVk9VTUdIMW95MFBQUDBCU0Y1?=
 =?utf-8?B?alp1aDNLdzY4MjBWWTczdGc1dlVnRk1FYXg3VjE1UWJBc1RTLzJkVHRjeGUz?=
 =?utf-8?B?cGZFN2kyeFRRbHJ3K2loMjE5Skd4V2w0TVRUdFNYYVNUQWM5dlZwSzc2bmdQ?=
 =?utf-8?B?dXNkUGRTSUJvREMvdERkelNYY2hQeDNuSk9OTlNlc0IzMDJndGEvQXhmUUN6?=
 =?utf-8?B?alloLzdwdGEzQzArRFY1MzdQa1YzWTdKNlFVV0lFR0dXeDBCdDE2cFhJaC9X?=
 =?utf-8?B?ZlZwTksvSy9PM2JldDR4UTJWL24zOHZEb1JIY2c4QS9RL2RZcmhnSWQrWHhn?=
 =?utf-8?B?WHBzOEJQK252Y0RFbXJIQUZaNEcySnVqR2g4WDR3U05tUjNkYkJ3aUlwWUJt?=
 =?utf-8?B?eHZDUXd0T2o0NXJTSTJHWENlUUVFcTR4VUg5Sko5cHhPQ3FFdGZLeXNzT3Iv?=
 =?utf-8?B?TGhlZ2lUeENPNENvRGIvenczS042bUVoSDZ2OTNzeHMzR1R4ZUowTDY3eUhj?=
 =?utf-8?B?MVowV3AyTmJ5dmtZV2dRNHVJZU40c3I5MjVBdVU2R1ZVRi90ci96VWFENDNS?=
 =?utf-8?B?SFlKamZxZzRxNnF0aCs2b0g5ZTByQjVPaysrTE9yakV0bDJrcU93RDFIVFpi?=
 =?utf-8?B?Q1ZNUHkzQnp6enEvY2VqVkhSc0c0cUY4WkRrWWJBaG9lTXpCL0NhUVpyNUwv?=
 =?utf-8?B?UXNmVHE5RDhuLzRZVEVhWFkrZDgxdGI0Y0oyRmpPZ2xvL2JlWmdxMHlQSjBP?=
 =?utf-8?B?WWpmTW55Z3k3aWFhNXIxbzhlYUZNYk9RaGhIN2djdE1SRFdKODNjdXlmdmpo?=
 =?utf-8?B?dThrcTN2MCtXRFlVUXhTT21HZFByaUhrYTZXTnUzRk9uT3dkRkI5eUw0QmJF?=
 =?utf-8?B?VkxUemZtaHRxV28vM0ZsRGxaRUl2emUvU1RJMkVHMmdFTXJYbXFHVVNFTHZG?=
 =?utf-8?B?bjhaYTJQYWQvck9NWDhTNmFKZHJyNGpKMHk3WGxOTlhpU0xJYXkvaHVDQzBk?=
 =?utf-8?B?S0NzMFRPdEQybmVXN2c1VEVnZnVha0d5emp0c3M0cHFmUkwvTHpFM04xblhT?=
 =?utf-8?B?Tm5iajNsZmM0ZEcvRk9oRXZoVm1hc2kyOURtSFlZOGhRelVNdUNSRjlWa1VX?=
 =?utf-8?B?a1VJR0E3eGpjVkZBZ2tZaEV1bEZXVW56VHZoYTF2d2dZTmtFM0htWVN4aFJQ?=
 =?utf-8?B?YzVJU2d6UHNKODdBZG5FdGhqOHdXbXVlK3ZDN0IyRk11S1NyVE1VUmkvc2w3?=
 =?utf-8?B?SjBKQkFEMUorRFNrYzFLREVuS01BOTdIOWx4U21aRk83ZWRzMmVCSXlBRDZN?=
 =?utf-8?B?amFzZFpNaTVFNVZ1V1BGWWhndTg4czQwWVZhczNGcTNSeWwvajVrVE1KN3Br?=
 =?utf-8?B?aGNFeU5PRGNaL3dBTHErOFhWRy9FSWxyZDBhbSsvNk5zS01ZT1hDdjNPSEp1?=
 =?utf-8?B?K3N5L1UrVS9OV2Z0VkRPdTMrSjZWMWM5ZFByaTJtZnl3R2xFVDYzS0UxL211?=
 =?utf-8?B?RWlmOU9BdVFnY0h1T3h3V2NxZ3QyMm1SK2MyczhqaWdBU005MDhoQkVvQzVZ?=
 =?utf-8?Q?1Sjdg/7KPWa2hwpwrwwXgtC/E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d0025-dfc7-49af-01ba-08dd423c06cc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 21:12:53.9548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDOvfpD99O39FHr42kR37v7Z6hs8dAzcKM17mA1TQfX3u6gcCrkxi1zGzmAxWcatdnjNSj2CcmqpWiMGmMkCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

Hi Alex, I missed to see your other comment below, answered it inline.

On 1/31/2025 11:11 PM, Sundararaju, Sathishkumar wrote:
> Hi Alex,
>
>
> On 1/31/2025 10:42 PM, Alex Deucher wrote:
>> On Fri, Jan 31, 2025 at 11:32 AM Sathishkumar S
>> <sathishkumar.sundararaju@amd.com> wrote:
>>> Add ring reset function callback for JPEG4_0_3 to
>>> recover from job timeouts without a full gpu reset.
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 
>>> ++++++++++++++++++++++--
>>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index be0b3b4c8690..62d8628dccc5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct 
>>> amdgpu_ip_block *ip_block)
>>>          if (r)
>>>                  return r;
>>>
>>> -       /* TODO: Add queue reset mask when FW fully supports it */
>>> -       adev->jpeg.supported_reset =
>>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>>> +       adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>>          r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>>          if (r)
>>>                  return r;
>>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>>> amdgpu_ip_block *ip_block)
>>>                  return r;
>>>
>>>          amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>> +
>>>          r = amdgpu_jpeg_sw_fini(adev);
>>>
>>>          return r;
>>> @@ -1099,6 +1098,60 @@ static int 
>>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>>          return 0;
>>>   }
>>>
>>> +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
>>> +{
>>> +       struct amdgpu_device *adev = ring->adev;
>>> +       struct amdgpu_ring *r;
>>> +       int ret, j;
>>> +
>>> +       for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> +               r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>> +               r->sched.ready = false;
>> I think you want to call drm_sched_wqueue_stop(&r->sched); here
>> instead to stop further submissions to the other rings.  Note that
>> drm_sched_wqueue_stop() is already called from amdgpu_job_timedout()
>> for the queue that kicked this off.  You'll need to start them again
>> after the reset.
> Thank you Alex for the suggestion, I will use this to stop the 
> submissions and start them after reset. This will help save other good 
> jpeg contexts.
>
> Regards,
> Sathish
>>
>>
>>> +       }
>>> +       /* publish update */
>>> +       smp_rmb();
>>> +       for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> +               r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>> +               if (r->pipe == j)
>>> +                       continue;
>>> +               ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, 
>>> ring->me),
>>> + regUVD_JRBC0_UVD_JRBC_STATUS,
>>> + jpeg_v4_0_3_core_reg_offset(j),
>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, 
>>> unsigned int vmid)
>>> +{
>>> +       struct amdgpu_device *adev = ring->adev;
>>> +       struct amdgpu_ring *r;
>>> +       int ret, j;
>>> +
>>> +       if (amdgpu_sriov_vf(adev))
>>> +               return -EINVAL;
>>> +
>>> +       jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>>> +       jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>>> +       jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>> Is JPEG pipelined or can each engine only process one packet from one
>> queue at a time?  If it's the latter, then when you reset the engine,
>> you'll need to save the current rptrs and wptrs from all of the queues
>> on that engine before you reset it so that you can restore those after
>> you reset and kick them off again where they left off.  That way we
>> don't lose any jobs running on other queues.  SDMA has similar
>> limitations for chips where we can only reset the entire engine.
I fall short to understand your question fully. On every instance, each 
core consumes from its corresponding ring.
And , since I first stop scheduling and wait for idle on the instance on 
all unaffected cores which essentially checks
for rptr=wptr confirming no outstanding jobs before the reset begins, so 
didn't think of save/store, in-fact I realize the
possibility of save/restore after you mention it, thanks for pointing it 
out. I tried per-core reset possibility first, wasn't
able to get it to work, and then resorted to this approach, I am also 
rechecking the per core reset sequence to see if I
can get that to work.

Regards,
Sathish
>>
>> Alex
>>
>>> +       for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> +               r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>> +               jpeg_v4_0_3_start_jrbc(r);
>>> +               ret = amdgpu_ring_test_helper(r);
>>> +               if (ret)
>>> +                       return ret;
>>> +               r->sched.ready = true;
>>> +       }
>>> +       /* publish update */
>>> +       smp_rmb();
>>> +       dev_info(adev->dev, "Reset on %s succeeded\n", 
>>> ring->sched.name);
>>> +       return 0;
>>> +}
>>> +
>>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>>          .name = "jpeg_v4_0_3",
>>>          .early_init = jpeg_v4_0_3_early_init,
>>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs 
>>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>>          .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>>          .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>>          .emit_reg_write_reg_wait = 
>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>> +       .reset = jpeg_v4_0_3_ring_reset,
>>>   };
>>>
>>>   static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device 
>>> *adev)
>>> -- 
>>> 2.25.1
>>>
>

