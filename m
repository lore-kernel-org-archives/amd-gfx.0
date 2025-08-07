Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FC8C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 21:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923B110E495;
	Thu,  7 Aug 2025 21:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8CnK/8a";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F341410E495
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 21:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBLZd4z516F1NtAa+N3XebEHweFCK2Z9X9BkDARfBxkUaA6ztg7WAHyPHByOWbkhcWgiV73guH/qYAY4SgPKsfnECOf4jcrYehY9+O0+6LgSoYZ3chMq8wTIfMjj0+PK4AbvQdSd/q505gi7LYtvY8jl1GteNx0BChLrUv5ZEjUCgw1GWrw9+HBoiu0GYxhagLrHpu8CeXwFBfetYw/V+90Iu+YPP8iLHgfF9bKEdN85LlMIISkUxP8YRxh/n+vTDoNYTdrgdb1YeS3Vl7xIaF1weUrHBGPlPuuZZ4EqE6yFAAiTIKfmmsmh876oiGHg1Gwg6X9XO8vbl4vyeidnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa0d7mR1UssAH+uUUGhAmnXHK5T7XgURrdT/R40rKnI=;
 b=wjLFfvmjvvmLwpjmmkuE3y08n2HJ8pURJC8bCdUOcPfjAN6L50ZUL7pIf4aQ3mCGCDyowaXVrHwt/F2V3XO3uBjHhTsAyLQMhdX9W8Y+y6pErfme3dUa7UNtDtOArsdaeLJEnSaDX8UUWez66uemHLaPXinxz9CwepQczS44ve4/AM+Q2AsFucGPuEEiOO9mhlAgBXEzctn7MpMSPyldd5E1Kop0ImzXAKHT8QLkVW4DKlKcNJHcT2XldN/L209OFaB293Z64mm7LXE9vEt3i3LcJmB17/KEeu+1/5ZkWXDh14U4AhyROTElfPodup+oerrfUmsqmZtBEGeIZbnaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa0d7mR1UssAH+uUUGhAmnXHK5T7XgURrdT/R40rKnI=;
 b=Z8CnK/8atUevpO2+kuMAmtBhxLUIAhqm82zAf9im29eNtsIicrEReAOVheQWiuy8xcFoMThVvzn/CTk8GuGPcq/8QFOj3Az2RoXfWgO6pDxj986J9Zw00y/0+kbc1zx9mGgwgMahLslzDyKGd3Nrmz5k8TV5JxbgNoht90duBAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 21:03:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Thu, 7 Aug 2025
 21:03:38 +0000
Message-ID: <408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com>
Date: Thu, 7 Aug 2025 17:03:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/13] amdkfd: remove DIQ support
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-12-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250804110550.261311-12-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 8921f5c8-2de9-4afb-2337-08ddd5f5e193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnVVRnpaN1FpR0lxVTViQUlVNTJObTFlOW9DbVVTcGtDMUI4S3NXeHAwK3di?=
 =?utf-8?B?cER3QWxyUTBlankvdjRqNHNDWVgzazdvU0FUQU9jeFEzMHBZTlhoeGRBN0VI?=
 =?utf-8?B?RTE2Mmp6ZUtOMjJHZmhUQ2NlUlE3WjFHTmh6UjFodWJxR0NUaHZzcFFodjVG?=
 =?utf-8?B?anl6YUtZQVJQZ3RLRmN2QmhacXpLUlczSFpyOHJpWDZQSjNjNXN0Vm1KVmhh?=
 =?utf-8?B?cXZLUVBlZzdiZmU0V0grWjFQRUpNeWFjeDY0aU9KZTdUTjNhcXR6ZmpvTURP?=
 =?utf-8?B?SU85VFlNMUVFdHFqVFdUZXRDMGVCdHJldEdYbU9Ic3IveXBRT0x2elRPZEMx?=
 =?utf-8?B?VFNRMmUvRzZjdnNCaEE5TGxHWVM5MjBMcXNCRm1tR2l5SXZacmdMcEIzN1h0?=
 =?utf-8?B?Vk83TkwzMTg4MU5CUlRoN3pyeHlvalVtT3p6NGk5dm5wQy8wUjB4eXJtZTR5?=
 =?utf-8?B?Mm5sWXRWUExtZjVDbElqSW8xNDY3V3BzS201SDQwYzBVcHNhaHpZN2VhVHl3?=
 =?utf-8?B?Umc0VEpWR0ZVR21jV0tTcjZ1MTFiWHlXb2hoczRXQnNJbEZpWW5tYlhrMGVU?=
 =?utf-8?B?NFY4SlhqOU5QSmx4R1NKY1FkVWo5dGZ3Ym9rRDhmdVNpb25ja2hKb25Za0JZ?=
 =?utf-8?B?KzIyRk1wZFRTMmg0THJwY3hnd3RqTEpkaFhDTmZFUXBUdGRhbTk4MmZYR3Vl?=
 =?utf-8?B?SThLdmZBay9FYTQvYUNnblJzTGVtY3dDa2VLWkZ1N3crTWs5UU9oV3pSdnJV?=
 =?utf-8?B?VjZjNVhldWxLT0xNK3FXOVZBQlZaNVN0a3ZPUlV4OFc0UGR3aWhJdm50cklx?=
 =?utf-8?B?Q3NpdjkwcGhFd2JkOEMyTW5pU3FMaWg3cDhKcHp3UjJRVjQ2RzA4Z2kvOE1r?=
 =?utf-8?B?U3VZOGYzWm96YXNUbktveE15bWhQU2dBcWVmSU15bWVmUjZncU5wT2w4M1Qw?=
 =?utf-8?B?bjZHZG92Mm5TMHlxZzVTa2NLcFJNMEpscCtSVnhMbVV0YWZPc1A4OSt3LzlX?=
 =?utf-8?B?S2JnK0FRd2kyVkxwUzJQakhxMXo2R2NCNUFzQWgzeTRKSmFLS0VUa1lxWHAx?=
 =?utf-8?B?N2NXdG53UE9mb0N5R050TkJrcXJoN2prMXVCb0ZnUW9ZUFJ3dnVoZTlMY2tM?=
 =?utf-8?B?R3RrRTArZHhqRHhSMGxxMmZhdkl3MzN5UWdsSHFjWkF3ZjFqZ3JsanI2Zm83?=
 =?utf-8?B?TDBHZ1VrU2Rrb2NBTi9PZHdJcTI4UU9hNDdnc1l1UHRQRjJWWWsvU2dhRmhE?=
 =?utf-8?B?cjB3YXBGeVlUd2RQUDBCV1NHMEQySTBWVmVkMFF2aGQ3WFZOWWU3UmhDSlBx?=
 =?utf-8?B?empSdE5YN3ptQ2dpWVZZOFY3Q2N0b3FzcllBeGY5c2tVM2Q1bGhhcmxLdWRH?=
 =?utf-8?B?ZVliWk1lMlQ1QkpJc2hHSVUrM1F3KzNqTVN2MDN1YVg5Tk9GS2gyVEs4ZEgr?=
 =?utf-8?B?ZWIxU1h3cGFINTFDaGtqMjhZamZxSlR2WDVTbS8xRVluaXY2MXN6NDIvekpN?=
 =?utf-8?B?TnQzK0NCN042TUhFOUF3YkNCT3drdzlQVFNSbHlYN3pLRkxNS0dKZHc3eXpS?=
 =?utf-8?B?R1lpd2hUZ0M3b2NtK0dFekdHZWllNHMvYlI5QUkwakt4Z0pXREtjZ3VwVU1E?=
 =?utf-8?B?bjZpR2tTS0lEOFFxeXp3amRBcHNJcjFaSDVZcDg0citqZDR2RHlPU1IrdUJH?=
 =?utf-8?B?VmlJNHFZekZnK0ZjM3A4RTZmM2xoeThUbUErL0h4WXlYTkthQXBCK0dMdmRy?=
 =?utf-8?B?YXllMHMwU1k1ZE9hWENES0J0U1RqamQwSWpwSFVPbXJjOFRzZ3EvcHBkN2Nq?=
 =?utf-8?B?cWZuc3RSREgvS2d5ZTFQNlYxS2M0d2h5NkNKT1RmQnVaYzdhdEc0cVZteHpm?=
 =?utf-8?B?N2dLN3FYUnkxZlptUzJ0TWRxcEoxUTBTSEZIdndremVOd29TbDdUYnlLMkFk?=
 =?utf-8?Q?iNxKIsW2ePo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhmVEQ4Y0xuUzN0Q0VSTlU0MDIyUVQwRldvTlJ5V0pxRnpOdHdMbUQrZkpj?=
 =?utf-8?B?d0NRaFFsNGN6d3pmSGR3TXZWMVUwS2MyRFpmYjc4NTM3cXIybG9IVFBtcXJL?=
 =?utf-8?B?ZDR5UENCV0lYRmk2K2oyYjFZSiswWVhXS0FyWWppbWdlZVM3YnJOSjBxM004?=
 =?utf-8?B?U2RFTTdTRk81SC9OcFhJS2JSTlRHc2dmOGhGdFVQZ3Y5M20wTldLZWJTUDl3?=
 =?utf-8?B?enBLYWduVXcvTWRNWHprNUt6MU50bXA4TU1Mc1VmZGVvb0h4cU9ZOW5ZTU5l?=
 =?utf-8?B?d3dOZEN3Kzcxd0E0YU1Db0xqdmpRbjJ6Skp4Y3JjNWQ0SmpoanVkSDh5UkFL?=
 =?utf-8?B?cDRZTFlmdTN1QUJXbWNjUVNZbmxsUXZBVlc3WTJvSGdmQ0pOa3Bzd0JKS21t?=
 =?utf-8?B?UlpjY1FaNlV0ZFdhaVZSY3dhcmpkWSsxQVZTU2xicHU4YkpMWVV6c0EzY3R2?=
 =?utf-8?B?WW5aejZldWcrbysvYUdXamt1eEhjeVRyN2NQcXEzczNZNXRNR0Q5ZkM2T2hO?=
 =?utf-8?B?QzJ4TlVkNjQvbG52SThZQWVEWVM3dDJpSHQvU2hrQUZvSVl5WVpVWUZsMDhH?=
 =?utf-8?B?ZCtjeDBSTTVkdGY3ZW9TbC9NL2duSFoza3BsOGVDVzdkVWFmQWNibVZXMkVy?=
 =?utf-8?B?djFkNXhPRDBUdlk0bFJ4SmxEZXFhNnB3Qi9VTkpiUE45N1FvSE5yTzRFYmg2?=
 =?utf-8?B?M3o2Q0lBWktkUk1XTnJNU05mQklQV2FhU1gveFdSWWFBUEZqbDhXemFOdmNH?=
 =?utf-8?B?MkJqVk5TelJlOTVDclNYcjgvdHlrUjhhZ1hGSW1nUjF6cjdBdFZObjRaOERj?=
 =?utf-8?B?YUtwYWFiK1JQekVlVmVtNkhDNWJubE9WSkM3dm50ZzhqeElRNTNDRDNjeHlG?=
 =?utf-8?B?cUI3Rkoya3dnVS92b0c5ZStFOElrTkk5WTZXY0F2bytMWjM3MFhURnlPWTlv?=
 =?utf-8?B?WUt3LzZrMlo5dG5YcmdKNGFKbXpZeEdlNDY1emN1WktwQm9wR0FXWHNQbk9k?=
 =?utf-8?B?cFc1UUt0RDUvQUsvNDFQMVg3V08vZC9peldjYy9aSHJZenk1TTZLQ1lQMHUr?=
 =?utf-8?B?RTlWUUJmTGFsSkM0VWZkNkJLalVLKzczUHNDejdoMzc2SHkvaHZUb1Q0Sjly?=
 =?utf-8?B?aUp3VFR5c0VxOTNNK1V4Y0VuV0ZBZWhrVHJZKzVjaFFLeG1JSnFVQWZjZjNE?=
 =?utf-8?B?bTVoMjZDRzZieWt5cytRRW5pa0pDTVZvbnNyUUEvUDdzcXlRUlBYME5YVGlD?=
 =?utf-8?B?VWtERk1NZnFYdjdlWjU3RVFqeVIrY05wdmxlRC9KRFJaayttZmVtNkdRaE5B?=
 =?utf-8?B?OTlsR1YzeUc3N2FQS0pMWWJvQ2FDWE9qaGV2dGRWQ1ZnU1RDaldqWTF2RUZL?=
 =?utf-8?B?N0ZGZWM3eHBuVjNsa3kvK0tFRFU3VDc2UCtQdEd4WUhBdlk0YXpvcGVXVFZP?=
 =?utf-8?B?K1NFTDB2SmRhWGh5aWpsakVFY0FobWp0cml2Qk9WdjRnVG1kRU5KOXpTcEZi?=
 =?utf-8?B?Zk84NVZsMGJsZFR1MGkvb3RwcjNxVEt2ZWxVNkR1bkZZSHQrTmNsWUVqUS91?=
 =?utf-8?B?TG1JR2tqSEtJeUkwK3BYOEI4c3YyYnpCcUZ4Y1A2bGJFRHMyWm9Kak9GZjF6?=
 =?utf-8?B?KzlwejNHbUQwZ3hVNnFPa1pkMCthZUdrM09lMWloYUhmMnNKMUQ3cEtoUzZq?=
 =?utf-8?B?WTU0WlNwMk8yRG1SNC9Qd3htblhsRmtQWFlJeUJKTzlvOUFTekZHQWZJYlZ4?=
 =?utf-8?B?S0kwWUVvK2hDdXhvVDlqVDgzbzh1c0s2SEFyTFh2SWlzQ3lFdmg3REZXYzFn?=
 =?utf-8?B?cTVKMGxiK0hZNkJ1Tk8wVERSamFoakJ4aURoRkhCdTdOYW9pd1NUZyt6bTJW?=
 =?utf-8?B?TDZHcVBtWWNjQlVFd0cwK0hkRXJNYTdtL0RtWmJTRUN2dXNYQ1h4bXZXaVdN?=
 =?utf-8?B?ellIUHNMeC80Tll4dmNMV0NkcVJYaXArN3ljRzU0Z0hPNDljeFlOQTFTTjlJ?=
 =?utf-8?B?TDAxR0dTSFROS2NPaVZWVUQxVzRFVzRzSWhFMGNmZmxoOHNCbktTTGxDZVdy?=
 =?utf-8?B?YVBmOVZRby9xb2dKUkJpUDJGZ1lOMmM5VFEvbEZWbFduTU5DT3BLaFBndjNZ?=
 =?utf-8?Q?LHj5DPpycOfZ55JdLNC6qb0V/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8921f5c8-2de9-4afb-2337-08ddd5f5e193
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 21:03:38.5945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPvToCCXc0BravgJjRfYYvOJMgT5tSkEDCjKbOkvkqHIMWBPYRnO4H5z6jLjfH2wk39hFeCnaWGHS8bWGlNGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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


On 2025-08-04 7:05, Zhu Lingshan wrote:
> This commit remove DIQ support because it has been
> marked as DEPRECATED since 2022 in commit 5bdd3eb2

I think you can also remove KFD_QUEUE_TYPE_DIQ from enum kfd_queue_type in kfd_priv.h.

See two more comments inline ...

>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 26 ++-----------
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
>  5 files changed, 7 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2d91027e2a74..58e47e14cf07 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
>  				  struct queue *q)
>  {
>  	dqm->active_queue_count++;
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>  		dqm->active_cp_queue_count++;
>  
>  	if (q->properties.is_gws) {
> @@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
>  				  struct queue *q)
>  {
>  	dqm->active_queue_count--;
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>  		dqm->active_cp_queue_count--;
>  
>  	if (q->properties.is_gws) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index ebee37937783..f676b7419984 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  	int retval;
>  	union PM4_MES_TYPE_3_HEADER nop;
>  
> -	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
> +	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
>  		return false;

You're returning early here for invalid queue types. That's fine, but see below ...


>  
>  	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
> @@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  
>  	kq->dev = dev;
>  	kq->nop_packet = nop.u32all;
> -	switch (type) {
> -	case KFD_QUEUE_TYPE_DIQ:
> -		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
> -		break;
> -	case KFD_QUEUE_TYPE_HIQ:
> +	if (type == KFD_QUEUE_TYPE_HIQ)
>  		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
> -		break;
> -	default:
> +	else {
>  		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
>  		return false;

I think this code is unreachable because you returned above for any invalid queue type. You can just remove both the if and the else branch. Just assign the kq->mqd_mgr unconditionally.

Regards,
  Felix


>  	}
> @@ -163,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
>  				kq->queue->pipe, kq->queue->queue,
>  				&kq->queue->properties, NULL);
> -	} else {
> -		/* allocate fence for DIQ */
> -
> -		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
> -						&kq->fence_mem_obj);
> -
> -		if (retval != 0)
> -			goto err_alloc_fence;
> -
> -		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
> -		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
>  	}
>  
>  	print_queue(kq->queue);
>  
>  	return true;
> -err_alloc_fence:
> -	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
>  err_allocate_mqd:
>  	uninit_queue(kq->queue);
>  err_init_queue:
> @@ -210,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
>  					kq->queue->queue);
>  		up_read(&kq->dev->adev->reset_domain->sem);
>  	}
> -	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
> -		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>  
>  	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
>  				kq->queue->mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 505036968a77..3d2375817c3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>  			packet->bitfields2.queue_type =
>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>  		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.queue_type =
> -			queue_type__mes_map_queues__debug_interface_queue_vi;
> -		break;
>  	case KFD_QUEUE_TYPE_SDMA:
>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>  		if (q->properties.sdma_engine_id < 2 &&
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index a1de5d7e173a..60086e7cc258 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>  			packet->bitfields2.queue_type =
>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>  		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.queue_type =
> -			queue_type__mes_map_queues__debug_interface_queue_vi;
> -		break;
>  	case KFD_QUEUE_TYPE_SDMA:
>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>  		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c643e0ccec52..e36950e7e14f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  	 * If we are just about to create DIQ, the is_debug flag is not set yet
>  	 * Hence we also check the type as well
>  	 */
> -	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
> +	if ((pdd->qpd.is_debug))
>  		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
>  
>  	if (pdd->qpd.queue_count >= max_queues)
> @@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  						    restore_mqd, restore_ctl_stack);
>  		print_queue(q);
>  		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
> -		if (!kq) {
> -			retval = -ENOMEM;
> -			goto err_create_queue;
> -		}
> -		kq->queue->properties.queue_id = *qid;
> -		pqn->kq = kq;
> -		pqn->q = NULL;
> -		retval = kfd_process_drain_interrupts(pdd);
> -		if (retval)
> -			break;
> -
> -		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
> -							kq, &pdd->qpd);
> -		break;
>  	default:
>  		WARN(1, "Invalid queue type %d", type);
>  		retval = -EINVAL;
> @@ -1121,32 +1105,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
>  				break;
>  			default:
>  				seq_printf(m,
> -				"  Bad user queue type %d on device %x\n",
> +				"  Qeueu node with bad user queue type %d on device %x\n",
>  					   q->properties.type, q->device->id);
>  				continue;
>  			}
>  			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
>  			size = mqd_mgr->mqd_stride(mqd_mgr,
>  							&q->properties);
> -		} else if (pqn->kq) {
> -			q = pqn->kq->queue;
> -			mqd_mgr = pqn->kq->mqd_mgr;
> -			switch (q->properties.type) {
> -			case KFD_QUEUE_TYPE_DIQ:
> -				seq_printf(m, "  DIQ on device %x\n",
> -					   pqn->kq->dev->id);
> -				break;
> -			default:
> -				seq_printf(m,
> -				"  Bad kernel queue type %d on device %x\n",
> -					   q->properties.type,
> -					   pqn->kq->dev->id);
> -				continue;
> -			}
> -		} else {
> -			seq_printf(m,
> -		"  Weird: Queue node with neither kernel nor user queue\n");
> -			continue;
>  		}
>  
>  		for (xcc = 0; xcc < num_xccs; xcc++) {
