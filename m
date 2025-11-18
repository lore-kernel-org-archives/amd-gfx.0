Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7384CEDDA1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 14:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF6010E4E3;
	Tue, 18 Nov 2025 14:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XU2cHTSF";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E5E10E4EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 14:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWyVqhPHvdS3PooOCe5cgZTi51Av0ATvVcFx+mZQIbRfi+24Zlt/ECH+Ud6bdvnsdrF+LuFJkHaNmove80UaaE3V6csXOYGJUDcklXsdxunRmkNd6FjMC/DFFPkvwH4c5DplTXJmuYktZAbMPrwOwpN0pFO3JLZNAwyH614e/yNt7qg+u054psOUkMfirWW05+ojUN1V8a6g8jm5fBGqSSFuKWPC7/c+4ABW2vi6OjbFGWCZrA0ThMRwmlBWJ9iSZMWkUTPq3AUOfSqOG2U8VVj5XDbtWX3NAlPIF6bV5bd3D/buj8s88d9+qImt58J7OZmOorTx8vovLHHugwMo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBdDchHsiZDey/Lhz+K4wBN90QUp7gcOh//baULBc6E=;
 b=X2NMj1C3HOUtEtF9LbWJugxEIaG/D0cD7UEF7Vg8ErgnlyrsXsjQBvPtjyRqmiJOMiQgfT2VrCHH4b4ibP6C3Bn3mZ6NxGYefYmk/cu7Dodpt1tKrZU73MPiCmOopurnDYzVqNY2vgNukEXHpZOYwss5eO8gmqCnTKzLwA9bmBwdWtLSUh1b+Je+oM6L1s/NStcvNBE8AjExJYcWgSzxDt0XMhWNwpKI3mYdjiO/E2cHThUKTY6VUByGBcp8lzxe0ybCYpxBcx7prIZfdoyi1TdkldVBxbHLoeu9Y78Cfq2u3VpP0kwfA1E6KfVzumX97Pox0Up42WiJIB8qQ1d08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBdDchHsiZDey/Lhz+K4wBN90QUp7gcOh//baULBc6E=;
 b=XU2cHTSFDQaZxqzKp8HZ7M+BaRXZ627KzlE/m7B8ZmaAQFAd4LEcu5I2TK7Sc3VeCrwBOeyzA0IziES+YgFbr9qIU2jKtKoxzNPz0hm3avramEw6UWsFZtGkcv/YAv10dGJUD9cEBCOma0cRqHL5oSky5obMh7rebYm0RPasxqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:56:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:56:59 +0000
Message-ID: <84aa5815-4e33-43d0-91b0-c1f2bec06cc8@amd.com>
Date: Tue, 18 Nov 2025 15:56:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chen, Horace" <Horace.Chen@amd.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
 <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <0d43d145-9845-46e5-a06a-29bfe9db5991@amd.com>
 <CADnq5_PcVD-VVmx=83Mbv2+CTyJyXf5UmR2GB6OVahBK2ACAoA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PcVD-VVmx=83Mbv2+CTyJyXf5UmR2GB6OVahBK2ACAoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0512.namprd03.prod.outlook.com
 (2603:10b6:408:131::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cf4b83-4193-402c-89b1-08de26b2b9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJERTYwcnk0YXFEdVVIQmNCVnJ4Vi91bXNQVDMxN0FNZnFMaU9sVlo2cm1Y?=
 =?utf-8?B?dG9nZis1WElvaXRRbTBYdnJ0ODJ4eHMwTExiUDkwWElrWWlacjhmUjNtemY3?=
 =?utf-8?B?MUlzZHJ2a1JnYkNHampvTm1FQ256ZlRPWFE4U08vSlNORXpXWXBnRkJCK3Ro?=
 =?utf-8?B?ZVZPZTZBSnZRWHFackZEODJhdTY0OFFBd1ZUVE42a0JVMGRHTmZsOVZlTjJN?=
 =?utf-8?B?bWppVnpVbXdiTUZSQUxPOXN2TlNLN1RRbzNaaFFuR0FFOUg0Z2lSTkFHN25E?=
 =?utf-8?B?bkJVY1ZGYkZsZy8wb3J0TWl5bDhWRzcrMHZtR2h5MEI4RTl2a1hSU3YxdElR?=
 =?utf-8?B?anVmU3d6aUI4a1drUkJXL0Z5aXZDZ2hxYncxY0xERCtEZllQL0ZUSGlJMG1H?=
 =?utf-8?B?c2lVc292SlNwdHB5bkxoWEpMNFNjK2k3bW5rTnlCTkFYZGJici9ib0dxUEEr?=
 =?utf-8?B?Z3FtWEdRek9ZRG5zeGRna1JoY1hDTlIyVHJIWWdUVks1S0RObWlNeHNoWTNX?=
 =?utf-8?B?OWJwMk1sblZubFg3M0dlYlpvWlA1ZWJuM1Y4WWQ5WVZFajVzdysxM3hJV3BO?=
 =?utf-8?B?YlVkaC9RQVJlUzVsTEZHMVl1RXZ6R0JTN0RLdnFUQUt1bW94NG9MZnFnYUor?=
 =?utf-8?B?K0JzSjlqK1gyS1BWcVRCRVVjZWtONEl3djY3VVNaTExsUXl6UTlvWFJ5ZWVK?=
 =?utf-8?B?N2FOZzB1TzdHVnpWQkUxN01hRklDeGFuMDlUSzltV0lmTzlpU1orOVkzT3RD?=
 =?utf-8?B?VzZtNU5QcnRxcTkzZ0FudHEvTllqUnVqZ3luUk90dlhGOHlRcGljTDFPYzZH?=
 =?utf-8?B?UlZRT0xKczUvWTF1b0dnYS9xcWdiVVlFWWxMeUt4dStXTnI1cFpQdEdHS0N2?=
 =?utf-8?B?SDRPbUxVeTdNT1dCZkE5OTNVeVQvVWxUQ2tFT1lqRHd6OWwzcG13MDF1emZ6?=
 =?utf-8?B?cnB6Y1hZSEhnUUJ0SVNKUytVTm1TTTBzcFRTQUpCVnFiWVJWNjh0LzBWUDY5?=
 =?utf-8?B?b2tXbVJRYmxXOWxqbG8vckNad3h3b0JoR0lxWHVOOWcwbkkyQ2ZLdFZSYVgw?=
 =?utf-8?B?N29vVXNucnV0MGFLMzZDaWxoU2cvb0U3R3RBQlBpbGVrZ0VnbWp6Vmp3dFBa?=
 =?utf-8?B?K3VwZnhvRXI0OXZiamF3YkFsTVdLMDRHdm90c2VtTUVibFNvRVFKOEE5Y0RK?=
 =?utf-8?B?eHh6Skc3N3ltb2F5SWkwZGpxelFSN2o3Z3RTbFkwN3VMWmhKOCthQkEycFRX?=
 =?utf-8?B?WXlSdkZMTC9ldE1Cem5DZ0xWemVudDdDYmJGTnBTZmlJRkg3bkh6OTdZQUpK?=
 =?utf-8?B?c1A0Y0lhRWFQR2tWcUp3eVQ0RmxHQWUzRVJkbkpNOVpnOEsvdTBQa1NzMmZN?=
 =?utf-8?B?Um9mdW1POW5meHdtRG5vLzJTaTFSQW83NzZia2NzUzNUTXZXWEhMVVdvMnli?=
 =?utf-8?B?NnA4UXg3QmxJd0Q0K3RnWll5L3U4cmRqVzYxRWxESWZkaVpuVDZsKzY1SVN4?=
 =?utf-8?B?K2tKbnpXY1pYWWc4N3YyV1lzUVVzbGpUOVBuVnRSN3g3dUVlWHJHaWdIWlhi?=
 =?utf-8?B?T0RsYThrUzlrM3RITWZoS0JqNFAvcmVxZFc1YlR0YjJMam9jckVHb3ZrSmkw?=
 =?utf-8?B?Q3NpZ3JlUW5EKzRFSFAvRUlGNDVXOVhRdlhQWURzeEZNQVVjcC9lLy96dkhk?=
 =?utf-8?B?OXE2bFB6Y0ZEK0JNSEpFdEhJKzNTTG16NnpXR0NEbmZld1AxL1IrQ1FRNDUz?=
 =?utf-8?B?S0ZqaXowOVhmMDhMUk04NDhRYy9TU090UnE5RFVpUDBwNG9xSlhvT2VINFBq?=
 =?utf-8?B?Yi9waEdmVTlpSGVneGJ5SWxyU3pFSktEdDhlWDdEK0NwblZ4eEVSckV3Rk1h?=
 =?utf-8?B?dGtnVHQ2V2IzdERLRnpnR1BRZDJibGw3R2djMGM4bmFkY0gzMnE1T1IvL1lm?=
 =?utf-8?Q?6IG85K0BN/awy/8FAMofVk7ECleMsFTm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBJQUlYT2hoOWNhMnI2NnpUMmRTbExuZHArNjJtNUZIeWU5ZnYxOUt1Mm9F?=
 =?utf-8?B?bE44WnZOdDFEQ1piMWkrUW0yeWFXOGlmelZaVHI5RzhCUmtqNkFvczNUQnk2?=
 =?utf-8?B?T1BUSjZmdCtjTDRCeWc3WWpjS29DM0p6SGtUemdkbWRxMlBoMnd3R1Z0UVE3?=
 =?utf-8?B?dDBhdzRvbUZVcWhRK1IweVphUHdvZHpycmxtRStpRU5JQXpPcW1MeUl3ZG80?=
 =?utf-8?B?aHFkQW9YMU1UNFVZcU92ZlJNQTAwbVhKVlAzU1A5ZE90N21HUFdMSlZiV0RR?=
 =?utf-8?B?dWdHS1hPOXRJWVIvbG1UQ2VnR2F1WEh0a3owMDBZK0Q4MmRDQWNTeXJxTm9Z?=
 =?utf-8?B?QTlnejZtNFllRThja0pkTzg1Y2tnTkVmVmNvUk40Z2w0Vm50WFRNSEtPdGY0?=
 =?utf-8?B?RUV2NTdqVzdjNE5PbG9OYkM3elpVV1NYYkpQTkY1N2ZlanVuWFF2ZHRFbENT?=
 =?utf-8?B?eWhrNUJkeE9rUXducTZkSStmNlA3NVIyT1lRMnlSckd2ZnU2WFpncGs4cFdU?=
 =?utf-8?B?WFdoMnVjVHhOcVh2QjVXZVRJZXVhTXJHZ0gwMUsrRnBzalFhWS9rTjN2Tm1N?=
 =?utf-8?B?TlI1eFBtNUM2TWVVMGJObjVWOUR2RXp4V3ZJYzdkUms2TXpMM1l5MzZDOVQr?=
 =?utf-8?B?VFZhbkpUeG92TVBhNEpVSGlCV3FETEd1dzRMTm56T3ltUkJqTHJrZk5aNnov?=
 =?utf-8?B?eTE5SEowN1JPK1VDMTlCZE1GN21lb2NuM0dYWjJDWkx5Ny8xZk1qRjZOSFgr?=
 =?utf-8?B?LzJuYVMxSjZReU9PSWVJd1hFUVA1eTVQaGsxRW5aYndvZkg0WGtBUXBxbWN0?=
 =?utf-8?B?ZFh6OW9PVEVZdlVPQXBUU3BHRWpNU2hvRHdVQlBaUUdDYXJHa3BEdlFOQkl4?=
 =?utf-8?B?Z05aMThROFFVVld2Nm9GdFRjajEybG9KakFmTFd5bTZvTWZONDVuS2NWbWpn?=
 =?utf-8?B?b01PV2lHeExTMEtyRUxYMXNoS25JY2NMQWJzNFRUTFJWQzY3TFpPbkk1L3Rj?=
 =?utf-8?B?KzlFd01nOHg1ejBoc05ReEJtTXNhU1FXQVlseWljQWpZVVk0VFZXaUxEZisw?=
 =?utf-8?B?cFBQNUVYcy9FeUgyTzFpVGd1WTlRUG15KzYwcUo3cGhLQXZ2bnVNeFNGZDEx?=
 =?utf-8?B?Ym9rQThOMURNb2tFdVV4SUZnT3BpSmdNcmNJZDF4VS8wMU9jTGNIZ2g4U3ZO?=
 =?utf-8?B?RlJXODAwY1BwQUordDUvRDlXME5NWFRSdEkxRnNTNDNaNlBnS2FjbXhyNU5V?=
 =?utf-8?B?MHlCSk5kYlIyWHphb3g3YWQ1aFdodE1IaXYwUTVJVXJ3aTM1TDFQV3RiZ1JX?=
 =?utf-8?B?RDJ3NzhWMWJZd3N0NVV3M2ovcDVScDlaNEEwQTZORm5sVmJkUmhHT08xTmkr?=
 =?utf-8?B?d0EyTTVhNlhDYVVLTWttNHFIaVlwVDFWZUgvNGJZRFc0SE40dzBnUWhmUGgv?=
 =?utf-8?B?a0ZnQm9tcTdGekVGWmRnRDc4Y2Z0VjJpcHM0RjRMN2tzeVd6aUR4Nkx4dlVa?=
 =?utf-8?B?bnZ3VWdhVjM1N1R5OUExRUt2dm1Lc2xhRlJpVmRRMjRxaGZWSEZJKzZ0QXIy?=
 =?utf-8?B?cVlJanVpR05mdHJwTTE3Um5pUktkNUtYc2gxU1p6MUhDbkdlTTJUc3pmUlQw?=
 =?utf-8?B?TFNaSmJyV3MrOERVQjAwUVA5dnJMcmdqUG41SktFU1Y4MDFzWitrQ2p3cE1Z?=
 =?utf-8?B?K05keXpMNUpUUms1UzZ1WVk4Qk5uZkd3di9EZFg1bHpTRG1LM1ZOa3VCNVN3?=
 =?utf-8?B?QVo1eTZqOVVRbTVaeTNUVUN1ZzlWZWZUdjB0VElHS2R1dGZWaU1lY2NwS1By?=
 =?utf-8?B?a3BPOG8yRVVlM2ZwU0hzOElQSjBNWHYzQ0hYNTZVNmJ2VjUxQlppUU8xSTla?=
 =?utf-8?B?M29jd0MvUmpIOGJKRlI4eHgwVVZuSTJ1RnlZaHBIWnQxdWhqSzY1dVV2YzdF?=
 =?utf-8?B?aW9uNWVmamJaQTg5YlNLYU1xalU5Slg3Y2ZFUGdUcEkxUG5OODZaa282Z2pL?=
 =?utf-8?B?ZnZqRmtuc0YyOEpwdlk1bkluVkZVam5jTU9aRWR3a0hBd2dGTlRDMkg3aWpl?=
 =?utf-8?B?alNnOTlWNW9pOTlrTmFZdzVSbUlHVEgyVjdnMVdEdWR1a1dhczg0NWVXTlUz?=
 =?utf-8?Q?f3eTrkaLEmWovMDdzhKyKrli/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cf4b83-4193-402c-89b1-08de26b2b9b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:56:59.6136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcxofiVAU2yVRLiiKXE8MoHL0BoxbZEUbBhHGxQ9brOLpUqzPK3k8ro2o97/u3I0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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

On 11/18/25 15:43, Alex Deucher wrote:
> On Tue, Nov 18, 2025 at 5:49 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Hi Chong,
>>
>> yeah and exactly that argumentation is not correct.
>>
>> We have to guarantee a min minimum response time and that is what the timeout is all about.
>>
>> And it doesn't matter if the available HW time is split between 1,2,4 or 8 virtual functions. The minimum reponse time we need to guarantee is still the same, it's just that the available HW time is lowered.
>>
>> So as long as we don't have an explicit customer request which asks for longer default timeouts this change is rejected.
> 
> I think the change makes sense.  It needs to be longer to compensate
> for the world switch latency.  0.5 seconds of runtime is probably too
> short for many larger workloads.

The calculation that you have a 0.5 second timeout because the HW is shared among 4 VF doesn't make sense.

It's just that each VF has 1/4 of the calculation power of the PF, but we also don't increase the timeout for slower physical HW either.

The timeout is there to guarantee a certain response time and that comes from both customer requirements as well as requirements of the Linux memory management.

And at least the memory management doesn't care if you have a virtual function or physical hardware, you have to complete all operations in a certain time or otherwise the system can run into a panic during low memory situations.

What could be is that we have customers who don't care about OOM situations and want this longer timeout, but that is then on their own risk.

We certainly shouldn't increase the timeout to something unreasonable just because some CI system is failing.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>> On 11/18/25 11:08, Li, Chong(Alan) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Hi, Christian.
>>>
>>> what I mean is:
>>> in sriov mode, when customer need limit timeout value ,
>>> they should set the "lockup_timeout" according to the vf number they load.
>>>
>>>
>>> Why:
>>>
>>> The real timeout value in sriov for each vf is " lockup_timeout / vf_number",
>>>
>>> As you said they want to limit the timeout to 2s,
>>> when customer load 8vf, they should set the "lockup_timeout" to 16s,  4vf need set "lockup_timeout" to 8s.
>>>
>>>
>>> (After we test, when value "lockup_timeout" set to 2s, the 4vf mode can't work as each vf only get 0.5s)
>>>
>>>
>>>
>>>
>>>
>>> Thanks,
>>> Chong.
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, November 18, 2025 5:31 PM
>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Chen, Horace <Horace.Chen@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
>>>
>>> Hi Chong,
>>>
>>> that is not a valid justification.
>>>
>>> What customer requirement is causing this SDMA timeout?
>>>
>>> When it is just your CI system then change the CI system.
>>>
>>> As long as you can't come up with a customer requirement this change is rejected.
>>>
>>> Regards,
>>> Christian.
>>>
>>> On 11/18/25 10:29, Li, Chong(Alan) wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> Hi, Christian.
>>>>
>>>> In multiple vf mode( in our CI environment the vf number is 4), the timeout value is shared across all vfs.
>>>> After timeout value change to 2s, each vf only get 0.5s, cause sdma ring timeout and trigger gpu reset.
>>>>
>>>>
>>>> Thanks,
>>>> Chong.
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Tuesday, November 18, 2025 4:34 PM
>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
>>>>
>>>> Clear NAK to this patch.
>>>>
>>>> It is explicitely requested by customers that we only have a 2 second timeout.
>>>>
>>>> So you need a very good explanation to have that changed for SRIOV.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> On 11/17/25 07:53, chong li wrote:
>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>>>>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 69c29f47212d..4ab755eb5ec1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>>>>       int index = 0;
>>>>>       long timeout;
>>>>>       int ret = 0;
>>>>> +     long timeout_default;
>>>>>
>>>>> -     /* By default timeout for all queues is 2 sec */
>>>>> +     if (amdgpu_sriov_vf(adev))
>>>>> +             timeout_default = msecs_to_jiffies(10000);
>>>>> +     else
>>>>> +             timeout_default = msecs_to_jiffies(2000);
>>>>> +     /* By default timeout for all queues is 10 sec in sriov, 2 sec not in sriov*/
>>>>>       adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>>>>> -             adev->video_timeout = msecs_to_jiffies(2000);
>>>>> +             adev->video_timeout = timeout_default;
>>>>>
>>>>>       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>>>>>               return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index f508c1a9fa2c..43bdd6c1bec2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
>>>>>   * [GFX,Compute,SDMA,Video] to set individual timeouts.
>>>>>   * Negative values mean infinity.
>>>>>   *
>>>>> - * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
>>>>> + * By default(with no lockup_timeout settings), the timeout for all queues is 10000 in sriov, 2000 not in sriov.
>>>>>   */
>>>>>  MODULE_PARM_DESC(lockup_timeout,
>>>>> -              "GPU lockup timeout in ms (default: 2000. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>>>> +              "GPU lockup timeout in ms (default: 10000 in sriov, 2000 not in sriov. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>>>>  module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>>>>>                   sizeof(amdgpu_lockup_timeout), 0444);
>>>>>
>>>>
>>>
>>

