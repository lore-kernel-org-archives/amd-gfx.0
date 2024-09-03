Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245EECD13CF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 12:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF44210E587;
	Tue,  3 Sep 2024 12:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PlYdCinJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83BF10E587
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 12:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJCfeDFp6AhEziKCu3tWRsP8qw+YsX8TlR1Ws6ZYXA8hIGLcoWgBWcGAS7JpA1bnsNgeWOac1Ywuqyv0z99xYr/nJI+PjIIDrEtsxY6b/YuiDicLpFJE28GS75MQdD4iPyfq/VMr/lMOJVdsr3SrCiv0IE0zPWHreONGF8a1FV37Fth0gVkm2xsz7tfHMHMxO4PzrPEUCVSlPBbd3oFjowUhraWu995VGUqsJB2ayql/utC1n5cIYQiCPsalEpQBIJkVnUhc+ZZn9N3dwFKMQpe+6gTaFY3KMF1xG9oEnVV247uMK0U12BEsJYnjX9ZJHGRehXmAkeZHjQFSVvn7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCZpKXZTLXBATvnuZe26VJbk6Bbx1pLaLu46HLUEtCU=;
 b=hBmnc6pMxoXKbYqXwq61ahZr4y0x2kZ/ccT7QA8DfmK6+JqxQ7425nY0vteQkDGqTKhcvkUoYp8/oTiKutedEcw5WIWUfLzOLHAoZ5mStC5hWqaduY8FUWnSxsNKPY02KPGzN/5wbjGedg130i1DQowmalnLOV7OKt6f0Sbp6M4Io8n/h4zIuLEZgRxYdKvEtIdJpQedkSXHwj/Nm9JJjVKwclyJHJAhkqoUeavvflE6m68nSJJWD0/4sdDr759PDPaWloh9pQI2c/NkJ6G2bu5P7ZxV689FWsQktdl9pAKA8uIBljg9pN7fcNBYi5QrMzxdXSav0Kp1va6qDsEokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCZpKXZTLXBATvnuZe26VJbk6Bbx1pLaLu46HLUEtCU=;
 b=PlYdCinJU+NmZyg1KlRMVcCYYr6pk8CC8eG9MHngEVwlfIdh0wPPxIgIgd/3AuEaLaZFtELHyO03LNJjKQgWXseIA3NxqhplUnR/lnjq6PO+UoW4malXkJjhlnud685cA+vU+JJG8r4GnCKd5TYRveTL7JAyKHsAqG8jdxJQbv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Tue, 3 Sep 2024 12:48:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 12:48:26 +0000
Message-ID: <99f9ba67-03c9-4e14-9dee-1996d635bacf@amd.com>
Date: Tue, 3 Sep 2024 18:18:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix a call trace when unload amdgpu driver
To: Asher Song <Asher.Song@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com, felix.kuehling@amd.com,
 thomas.hellstrom@linux.intel.com
Cc: bob.zhou@amd.com
References: <20240903123136.555278-1-Asher.Song@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240903123136.555278-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d92678c-830a-4c9a-ab9d-08dccc16b3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmNDZVNNcDZqd2c0UWIveXpYMVVNMlRmTnpEUjVDck52cTJDRkZpR1hLWm01?=
 =?utf-8?B?MzZQNmVWd2ZHL3FZVzdpbjBuTUxuaG5DT0N2djhCMVJ1VGJPemZCTmhhQ0NZ?=
 =?utf-8?B?WDl3VHdaKytWYTZoUVh2Z29CQjZrNHNHM0V2cXRyS3VWQ0doVkhGSjNTK01H?=
 =?utf-8?B?bHJiMjVxZHYvQnoxK0hQKytEd3g2cHprcnhCa0RSc1IrN3VMZWtTSURMMjRa?=
 =?utf-8?B?T1k5UzRrTHcrMVRYQTlPd28rS1lEcU02ZDg5TlE0MDJ4QVZ2V1ZrMEx6bW5X?=
 =?utf-8?B?cTVpYnBCQ3M4SExDRHlCcy9oN3lkekE2V3VGZWs4NmhiNmJJZ1lUZXczelRI?=
 =?utf-8?B?R0xsNmZwTDNRRW1rRFNUaVF6dk5WTVEzSG1pNmUxOHplTEw5SDZWZ0NWdHp1?=
 =?utf-8?B?cWMzaTZ1VlQ3dzYzaHBKd2dYTmpQS05rVG95K1cwUHAwZW9EbnYySnJLRkRw?=
 =?utf-8?B?QjFHSXgrMXJXWXNsNFoweEdRU1FqS2lkbGpuVTl1eFpKMng5eWJoOENTSW1r?=
 =?utf-8?B?K1dvYy9qUWFvTmpiWWtqVEhtYXdySzNCRDhGSFduNUx2d01mLzlzMDZqbFBj?=
 =?utf-8?B?TldLb3hJeFk4RzRQT2ZFNnJKMUpaZnJtUkdFUmo0L21NazdNbEFRZmU1MWJx?=
 =?utf-8?B?UENKdU1semxxVFV5M3ZWYzV0TlQ2OUM5SWw4RkZVMTdvWlNLL1N0dUQ5WG1u?=
 =?utf-8?B?eHB4Y1hBVjlCbjZOSFNrSnd3MGFuaEw5T0dEWGYxRVFYVmhwUGthMG9nUzJB?=
 =?utf-8?B?M0lUYzJ6WmZWVkRqTE9icUJScERlK3llUE90bmxhRjh0ajNJRWlERjFDR3Vx?=
 =?utf-8?B?MnJ3aGU1ZzhXS2R1bE9PdnlWWWlsekw3OXZrYUsveWxaT2FRZ0JEa2JmVC8r?=
 =?utf-8?B?RExzNFlLU1FlT2o4YU5LSVFSaGpTeWtqNTJZYW5rMUN6R3djSVAvcmNydXNj?=
 =?utf-8?B?UkJya2g0MjFmUXczNHJhY2l0U2p3NXBBajJlUGZiSml5ZjRzUkVDd3FUQzFq?=
 =?utf-8?B?MVFTNGdHWS92Q292MVczVzlKVEY3Vm1mUDJqcW5tSm9WK3U1Ty9QS0NGYk15?=
 =?utf-8?B?R0V0dklOc3U2ZG0rNjcrd2tHU1pmald1and5MHlqb1NlVEJyY01CRHFEeStw?=
 =?utf-8?B?RVVjQU5rOGlLaFpCK2JNd29aeUM3N0lyUzYwTCtUcktqYU1WOGhRWUJuOHI3?=
 =?utf-8?B?dkszTHgzcy83YUlhb1NzQjd6ZFpzOGt5Y2ZnMnRrbmlqbExWdzVaKzEzQzFN?=
 =?utf-8?B?Z2hKemNVeXFaNjVFeEpEc094OUQ3dlNtNlFaYWVlSEw3VUtManRZMFY5aTJI?=
 =?utf-8?B?K24rUjRzZHRSRHJEUW5XZXJtL1BhOW8vRmlCU2lsMnR5N1pscFVPTlJDVDhT?=
 =?utf-8?B?MDkxckpwaG5IRGVsVndBRStGSWppb0REREJHMW1nYjNGeWRhdHNQMW9OcU9u?=
 =?utf-8?B?Q0FMc3c3QTVPSWRoSkRXbnlrbXdncE16dHZHS0M5Z2tBYVNtQnIrR2doK01O?=
 =?utf-8?B?M1A0dS9KQlRySDRTZ1I2ZS9XOTV1WHBwTEIxc0d5am4rekprblh2TUowTW9T?=
 =?utf-8?B?VnpCUmVyWG5GQnljeFlibTc2Sk1TNCtaQkRGc0Uyb0k5TnBPY25pOHphZlda?=
 =?utf-8?B?UUZsOTVQcGk2TE96R21SdFhkWjVrUDhldFFyZTladVp6K2dwd2U4QWszQVI3?=
 =?utf-8?B?MGc3WkZ5cC93aEVKU2kyTVNSaXJ2a2t2VkFsS1RER3U1NkVidXJEbWFPRGNU?=
 =?utf-8?B?ZDNHUG02ZllLeUNJMFJZN2NUV09ucVpNUXp1VDRZQk16VmVXekd0Z0dXU2hD?=
 =?utf-8?B?Yng3aFdjREpIZXh2ZjhwUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JIQmJvMEQ5WUlJaVpLSWc1c0hORStwb3h1bjJxa2VoLzZPUStDRWUxVHkx?=
 =?utf-8?B?T2xSNUFINWtvYzY0ei8zN3huNEhZRmMvWEQyMjY2dXZ0emEvYkI4N0JiNUoy?=
 =?utf-8?B?bWsvYjNIaXB4aGF5d2ZpMUZueS9nY3F5OFlkWGZXVVpLdGdtSXFlMEZRSnYy?=
 =?utf-8?B?Y1JML003ZTByR0R5M3pIYXNmVE9WQnlEVnVpN0Via0FTeEZuK1c2dlZ6VGxr?=
 =?utf-8?B?YmMxZHBjU3gySUsxMWVVdFd0YnRvZ2JLVER2MUxUcm55bXVOcDlncDBCS2Ft?=
 =?utf-8?B?Y1VuTkxidENaaHZyc1ZHZ1lxL1Y0MGFDLys4UHJBMklxR1JRNzVIQnFsUzRS?=
 =?utf-8?B?L0xBQk4yZ0t6Ym45NzkxTnEzRUtBcDhYa2ZSai9ZQjNWc0g2eW05YUwwbVBn?=
 =?utf-8?B?WXdoTmlRb3BaVFJMT1RidDlQcC9ydmZ5WkM5SWhrZ01Pd2hUNDZwbWN3cWYy?=
 =?utf-8?B?a2I4RkVxSDZrNXRENk5uemZMRU1hV2hmWjI1aURnZVA1RmJLaEVjWGozNGZO?=
 =?utf-8?B?VmRlNzg0b0IrTnRMaHRLUCtHTWtiQ2NBdU9meExlcFI2WlEzSS8xbENKdkZa?=
 =?utf-8?B?UUxzeGZIT1NyKzViRjhIY2dyWFdDYUVtZDE0K0FXVVhJZnBuTWk3dEpTWDNM?=
 =?utf-8?B?b2R6cXZmWFZPNFJseXArMnEyS2pwMlpNSGJHMFBQM2MxcFpubnVKVTB6bTdh?=
 =?utf-8?B?L25INGNkYWJwWFdYVWRxb29nQ0JjWUpVeXltTHlvZTJHK2RUS0c5cHMxcm1X?=
 =?utf-8?B?ZFluMGtkaEJ6ZTJFbHBUc3lyMzMrcWQ4VjJXQW1VVGY2Nmpzc285KzFUVDY4?=
 =?utf-8?B?YXdHeVpMbGhIVnk1YVhpejZ0bms3bWdPMVVpMVRUQW5wTUJ6eklucjVIVTBO?=
 =?utf-8?B?cXh5ZjlFZ2prRXFycW1nRVNXZG0wQkYrMG5sWGVmQ3k2bjZhTzlQdjAvM3VI?=
 =?utf-8?B?S25HV1NLbzRZSVptTHJRVTFUOXpYN1JkRHNuQXNXekdWbitOSUhpTzRQZDFJ?=
 =?utf-8?B?T0pMZUV2TVl5SzV4VDZRNFJBajZleFRabmlvaFhxYlkxdlVuem8vSnhiTUlk?=
 =?utf-8?B?Ny9FMmlvc3QxM3Vuc3VESTJpWkYyeWNpWEE0UTlKWmlZMnhkQmJJRXJNUTJB?=
 =?utf-8?B?eXNraE5qV1k3emtIOUhHZFVlZEZQUURiQnA4UDdESURPUkhWSmNxTndoMHUz?=
 =?utf-8?B?SURvNFQ5TlJETG40bW1aamZ2NTJKNFIxTE11M3EyNDMzd1htVmlKdWRwMDFG?=
 =?utf-8?B?UCtreFFtaXg4Y0RVZnNOUHhiME1WSGVwRkVnUzBjUHNvelViZVRoeENEVkw2?=
 =?utf-8?B?RHA3NnpuTkNDb3hCbURkdUs3cHhzRjhQWG9pNzhqWWU3c0dDWmJqaEg3b0dK?=
 =?utf-8?B?WmJWZlM0R2drWFhSUjVwWGxiR3FUOG4zRWEvTWpYZzhtWnp5WkpPVXZndk9F?=
 =?utf-8?B?dmNxM1lEMlZ5RERlNXpMOSs1eEhrS3pYYW94TmplOW5vNzA1MlRCWGg0LzZO?=
 =?utf-8?B?QmhkazBlQlhFTS9yczgxSGZQdzU3QUhrTFo3alRzNzU1N2JYTFA1eW9hVStW?=
 =?utf-8?B?ejBqaGxQZ3prNHByeHV1SkJ2VUdJT2o4ZHdFWWY3OVZsWnZUVmFrYkdjWTll?=
 =?utf-8?B?L0NYRkJEN0d1TDIvSjA2VzdueWovV0M0aEhFWnNSRWF3OHJTSlNlS0g4ZEVK?=
 =?utf-8?B?YXFxc3JjN0NQMW1TZmZiRit5TnVXZ2psNEZLMFVHbWFLU253VUZ3aElCajZo?=
 =?utf-8?B?ZjRGaE1vQ3pyenQvbkE5SnJuRjB0NkhqSkplMllsNEJlNDdHeUdYSU9jRk0y?=
 =?utf-8?B?Q013SHRZdFZoamw5MUVhakxBR1BSUVk4NFp0N2V4T3lkaUM5UXNldkdwS1BV?=
 =?utf-8?B?WFpBbHVwa2w5RzNoY0wzbDdzeGljUjZaeWI4cjM3aXNROWVUdXg0eUZyeUxv?=
 =?utf-8?B?cS9EU3BQbG82QWdHdHZkbXZNWlBqNzFSVWtJTlZnZWlOTzR4RkJiZng2aW5F?=
 =?utf-8?B?dzB1a1l1VzBVa0RZdjRzRnJYamNlR1pUMDdtdzJEdzd5U1JscElSK29EYyty?=
 =?utf-8?B?Y29sUENnakFzYVVMQ0tpVlduWXl3Mys5cDYxdmp3ckJiWklUcmx3K3BlbHFn?=
 =?utf-8?Q?D3KcvVy6z/K+3pWBdvYbFzI5M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d92678c-830a-4c9a-ab9d-08dccc16b3f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:48:26.3668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpe7815FEriS3kHeXKP54yg0syT/avkbPl3pjcGLTtvtFbIf2WCxvdGfZAmFztb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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



On 9/3/2024 6:01 PM, Asher Song wrote:
> In some APUs, the bo type of GART page table is ttm_bo_type_sg.
> Those type BOs is released by bo->delayed_delete which is added in
> ttm_device->wq, not released immediately.
> 
> To make sure all the ttm_resource is released before ttm_resource_manager
> is finilized, drain the workqueue in ttm_device.
> 
> Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Asher Song <Asher.Song@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 0a5c8d97787a..99017e426618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2216,6 +2216,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>  	if (!adev->gmc.real_vram_size) {
>  		dev_info(adev->dev, "Put GART in system memory for APU free\n");
>  		amdgpu_gart_table_ram_free(adev);
> +		drain_workqueue(adev->mman.bdev.wq);
>  	} else {
>  		amdgpu_gart_table_vram_free(adev);
>  	}
