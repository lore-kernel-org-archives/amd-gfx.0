Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF987CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 13:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD2010E377;
	Thu, 11 Sep 2025 13:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sUkh/GjD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FA689322
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 13:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHkUbyGUubvvhtWTwwv17ox8wyeyoHbWhHXbU7U1ELpoBcqLxz1oqWN0Mr6oCBv1NF+C8igfYlxoen1R2fnJ/Pr3P6+S9yqa6drS3Zr7KHFaec1yKRzdjzzGnwoVQy8EowEpn40k60hzAw80SVeSg3UICaYXn1guKbQltvQ+m3DazAt2yPP1FaENZq3uF+umMKwA/WWH8tuuNAuczqbSuVGC0A4UgLA9rmwmIZr1Yc/UpKfiWU4+SXSa8oUxlVe4fjzazq+xr2yk8VRPrJV/KUOELF+a5tcaDkDEBm0WXiOzTSJIiDRFnP+qFziNrWj6FKh2gn5L1C3opCQgggEO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+NuVM3BAQqbtYCTimBDoZq8AfOkshKtpoY0PI2JqF8=;
 b=Zf7KFHfJXDg2gdkU5CkZ35xnG0i4mTq45yIcEFG5mtFuvdQtNXwsUDxuSkv71U31xA1o31kSACZoF6HTFCeeJg2E/mghvc7rCqrRGPmzyHsdxkg7GZ8qZc+WD2UnS3IHZqMBHJCi1mxBC96nH8JPxbLc1sQSLLI03Vcqk2Dyi2myegFSDrWRLaJwDqCzjVy8GmL64BXzCCV62N/HA+xszHRmlqbjmJBV0F7FpbsPJR+8MxqNMy2oU2yndE8iclYIH9iE1tRrONzyw+VwsGDNNB4xGiZkUwzafimT9kwfCqnwQ0zdldBEeCak6xDNUsZbQf6EqDiJTkyjBqa6KFLYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+NuVM3BAQqbtYCTimBDoZq8AfOkshKtpoY0PI2JqF8=;
 b=sUkh/GjDkIQDzRrvT1Rz+UgKKKi6z3ipcr6WxGwIbHVZPWKVU5ZFgdSAF9Q4Dpl8ONuq2jGU5aTPdOv+OVr+jr3x72dZZp8Vph0du0D/l4qv8wxNS2yXh15JMKlabSGu7xswSU5+N9HKMIeG8Dc17Hp94p1x54RinUKBv1exo+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:44:49 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:44:49 +0000
Message-ID: <138672f5-0868-4d88-b96b-bd55169122fe@amd.com>
Date: Thu, 11 Sep 2025 19:14:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: re-order and document VM code
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexdeucher@gmail.com, Sunil.Khatri@amd.com, Philip.Yang@amd.com,
 Prike.Liang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250911120950.3343-1-christian.koenig@amd.com>
 <20250911120950.3343-3-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250911120950.3343-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: bb59d2c7-f397-440f-aefb-08ddf13960b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHk2ck9oSzQ3VFJzUUZIalM5VU9LVVMrTlFJTE1rOU5maGlGYTI4T2VIRHlB?=
 =?utf-8?B?SFZIWXdrVDl2ZVF5QzFDTlkyWFFxWnJoTFpJUmRsQXljZmNQRDlBbUlaakFB?=
 =?utf-8?B?Y3BQb0ZITnpmaEFWZWxIVitFb0g4QkxaUjBIWVVrVjg0eUhoaE9UaEk5SlRo?=
 =?utf-8?B?N0pPZ28zUmxVWkJ3bXgwQVBkeWZEMXdjc0cwZDM4Y1p0L3lzdXYveW5TMWZK?=
 =?utf-8?B?czE0ZHk2ejVqeldOTXNieUo2OUN6UE1QM1ZPMUZFTDZZVEExZmdKSDV4UWUx?=
 =?utf-8?B?NkQ4VEFSc3Y3cXo3VDJFVTlTVlJSeTlkUWNVRExNYndUU3hsM3FpZlNGTnc1?=
 =?utf-8?B?YWF2SEhaakl5NmgyZDJQZzg0ajY2b3M1SXU0N1J5cDR6ZFNMcnJFMmlvdksy?=
 =?utf-8?B?UmxmUDByK2lDU1hpWFhFaE9KeE9JeWVUOFV1K1ZhSTZuWWxXMUVaeFFySnF3?=
 =?utf-8?B?Z3lsZThVeDJEVk1yRjJkS1ZXa2p1OGQvekJ5YVBITGxpRDNnNGJacTVOR2M5?=
 =?utf-8?B?UDNMZHFVNkNzbEVNRjdqRk42YW9zc1lkUml6Um94YlNkRlpKSWl0TkdCbVBB?=
 =?utf-8?B?bktnM2ZTcDEzeGNOdklhdWdobWJxeXpuVTNlUHNZSUROOHVTcC9SRDUySngw?=
 =?utf-8?B?NHZoaHl5WkFUL2QzMUVob2JzUWtGaHFJQUJlS1B6T1ZMV3VIMG5IZDZPQmQ3?=
 =?utf-8?B?UXhpT2JJSkloWVl1RUxtUGlOTnh4UG9xVjNpY0VzeTJ5WUdIRURsNUo5NEM5?=
 =?utf-8?B?bC8xVjFqSy9FWUxaQy9RT2FqbzhORURUeEVkQkpWVERBaHVVTW9hTTVDOWJl?=
 =?utf-8?B?MFU3ZTlXeW1iUmgvWGdyQ2xPc3ZWRUhXNGdMT09NU0xuWEo1OTd5UUNLSlBC?=
 =?utf-8?B?bHpkbDl6VS9HemtBU3dSOVpheDlRd0VZME5VZUMwUTltMWJ2S0NBNE5NaGJM?=
 =?utf-8?B?M2g5bFRYZmJDQUdRV1QramJhckJZNlJ6c0g5UU93TWVramdWOGFVODNvZk9C?=
 =?utf-8?B?bVk4MWd2MWh1RldXMVg3blN1aCs4Q3pHYVIrYndtMk5BbnFaL2VkUGYwMUhS?=
 =?utf-8?B?elJ1RkxRTkxpdHAzTjBIQVU5SUxTN0hud0NjaWhnL3U5RURDSlQxZHV4TjRJ?=
 =?utf-8?B?aklpL0RWYmZ6OWZmN1dLOGxNOHl0ZjRCaFBzYmZuelQ1blU4TDBVZThaV0JK?=
 =?utf-8?B?bWpvSVVMWWhvOWZsOWRPT2c2QWdvSis0WDM2b3Fkdzdvb3lEOUc4ek4wRm1Z?=
 =?utf-8?B?dEZVdU9zMGlLNk5Wd3RvZTh0RnRxRC9BWTFkWTVHR0ZYUDBuTU1zcHdTN1BJ?=
 =?utf-8?B?ekNHZTRQY3pFL2RaNmcrSy95THV5Q2hTWjkyV21oYThnVDVQb0hWanFUM05n?=
 =?utf-8?B?RFEva01nVnNrOUlQRlIxcXVBVDdURndnK0d0aVZaUkFVTUltWk1SRVlINjV1?=
 =?utf-8?B?ZnY4aXJKNlBQYkE2T21rVVJ6Unc1WVE2clloZTRWYkJHQkxpam1ULy9IQ0la?=
 =?utf-8?B?d3pUc2NhTk4wNjFkT2o0b0ppR040dkhoZzNhTzJRS01VbEJuRTI5SGIxdXZJ?=
 =?utf-8?B?engveWhmd21oN2tMR1FMRkFLc005OE41T29PK3JTekhFZXJmL0xxT0hGU3VV?=
 =?utf-8?B?SVlBMS95QmxMYzl6bWlJaVVtTzVlZGFaT2Eya2k0WjFsUkJ5N0pBbERzY2Rn?=
 =?utf-8?B?NWNZWUJTNlRJQUYxa0ZEbzJlZXZVRkhQeG1SdTd1S2w2My9mV3M0dEV3RXJD?=
 =?utf-8?B?RzZzVi9lb1ppaCt6ODYvQmw3QnpicW81U1pOUGhxQmJzTzRGSkZkdFVpcUVs?=
 =?utf-8?B?dGg4L2M5aG1zMElEQXhuVlozZHN0MW9udDNyVm5DbjZBZGVBZk1Ra0lWRnpj?=
 =?utf-8?B?elVmMHorWkdMbzZqR0FPYVNabjE0Mnlob2xWVU8vSWpQb0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjV3YnBmM1FKM3F2N0ZMTW1SZzdNS25NdHBVMnQ2TkxDQWpMZzFMejR4WlJ4?=
 =?utf-8?B?TXFJVVZUT1NBekhhdGU0Vm0yYzdVZDRsYkpGeFQxV3N4eVEzL0FuK04xbi8v?=
 =?utf-8?B?OEFZaGx3c2hDLzFrYTh0Y3RkVkdLWHpkS3lxMDduNjJhOVNZRThwY21jQ2V5?=
 =?utf-8?B?L1RncCtWV2MzMXM0ZVZSc2RzMmJuTzJBVEI0RGY5YVFSa0g4cHEyWWVLeFF4?=
 =?utf-8?B?cmQ0UDVURFAvRERnaUJWRm1UV1BsaEZKVnk5dEdLOHEvUFFKbGRKUUFXUThy?=
 =?utf-8?B?TUFidkpHMGlXdHdRYW9hNGpUSGZVdXJJRFczSUhGWnVVUzZPZ1FTYmFrYkJU?=
 =?utf-8?B?LzBhNjZnVXV2N0diTnlMVmpRbVVhZVBEMk9CNDFWMDdpRFBvNUh3L0U5b3Ja?=
 =?utf-8?B?QXpsdUdSTUI4REZkWFRBb2g1Z2wzbU80K0JRVGF2ZEl5ekNabDFpOTlWdGYy?=
 =?utf-8?B?dnRHK1RBTCt3a2l5d2dQckxwL0ZPczBCVUM3K1VYYzRXY3Z5N21KZFBPUzM3?=
 =?utf-8?B?N01NZGZJcWVuNW5nOHVEVUcyTWxXSXhRQWJISlNtMGI4SHAzU0Z3STA2cE83?=
 =?utf-8?B?aHgySnBjQTNTVXBERTdsblozcGo0bTBmTUFSOUZGcTFaQjBhSGpSQ3ZCenFX?=
 =?utf-8?B?UlorM0k1Z3JublpBcG0rcEhHN2xUYUlNTUJubUNGRGhvbG92d3h0dHNUeStD?=
 =?utf-8?B?RTJDTFlXQ2w2SjN3RVZGdXRBcW43VEh6TE9HUVpDRC8rTkpQK2ZUeEVZUWk3?=
 =?utf-8?B?Y2Y4ZWdwRHNVQnhJUEpBUWVMTWdqMU0zblVWZDhNOHpxVENCR0Nvd2c4VlVo?=
 =?utf-8?B?ckN6R0xHVG5uY0piRUM4cmcvR0QreUFmalBLcmtNY0lmTmJ5YVRvekFyYUVP?=
 =?utf-8?B?c3k4L3BFL0NIbHp5RmZCRVVHbVhBRGFKbjZXWm9POUZMdFE1a1BRR2RoSVV4?=
 =?utf-8?B?bk9hdjRJc3BlelNpMzlPVkt6YTNnSnU2UXVPaXRkdGl1aE03M3FUajJwTjJr?=
 =?utf-8?B?anIxcGdpb0RoSUxoZ08rS052UUZZNUJPZmYzbkNNR2ZkNmJqSS9UMzJSeGIw?=
 =?utf-8?B?M1hvYW1lUUpqL0tMRmU0ejZ5RUl2TWxacHNneTg5K1NibE5OZ0ZKTEcreDVZ?=
 =?utf-8?B?NGhIZllNcnRYL3BJRzNnRTNZaVBFTHJobWdVVHJReWNPNTV0d3BqdXNML1Nv?=
 =?utf-8?B?d2VvdFI5cjgrTTNXcVZFZGdobTlzYnBOYkhoK2dJQ1FObnh3YnZkYkRYYjFN?=
 =?utf-8?B?ZjVHeXQxUDRLVXg2UFRoWWtRclFxekdRTlA3S255MjloSjZUeGVYeDFhZEVC?=
 =?utf-8?B?UWNHWGhBayt3K3lkUCsvZWJiZ05WY0NzTmlWaERyRnFBUEliOEhvT2RwSDVu?=
 =?utf-8?B?UXFJaXJjSVFibktLMkNIdlJrWHd5ejZ2TnpQeGFYY1EyK2JwTVYwSStlN1Az?=
 =?utf-8?B?eDF4a1k2L2RvdEloZkxsUE5nTkRQOE1zUHQ4NUU5Mko4Y1JkangrdmRaa0pE?=
 =?utf-8?B?cjRkeGZCdHVXcHphYTNvNUR3UTlHS3lMNkRHdXIzcG9RTm0vUmV3SnFKdGZJ?=
 =?utf-8?B?ZC84dUU5ZWJtbklwQUhKb2xPamZZUGJERkhwaUdUNDU0VGJTTjJITXNtbXZk?=
 =?utf-8?B?S3g1cVNROE9sWW9HMWFlOWZtdW1kc2lmQXAwZnA0Q2FpY3R0aXFFMVo0R05G?=
 =?utf-8?B?eXNQS2VmODVXc3Zwc29JRld4VGQzTlpQeXRPL3FrM0xPTi8vMDBtbUdIVURM?=
 =?utf-8?B?MmRicktPVFloeExydys1bmhGMCtiK1MrQ0Q5aUgzVExWdFUrTUdDZHJ2V2lm?=
 =?utf-8?B?dVozMGhkc05VMzE1SUMxWEU5eGZ4SkhlQ2E1Q3dnNVViU3NHbHMwYkgzc0Zp?=
 =?utf-8?B?SjhsTnZVRnpPN2JzRUZuc2o3cnFXcUdOa0RxcStXNHdFM3Vwaml3b3hBT21l?=
 =?utf-8?B?dFdQSXFzblZtTi95TGFMMnNld2hSOFdMZlVaenBvTWVPNjdBWVdvdUtscTBM?=
 =?utf-8?B?VzZIcWZGWnFkTTI4ZW42M0dNZjZyK2lEWEUyL3VsYWQ1NkhJNTBiRzJSQWNG?=
 =?utf-8?B?NDQyN0xoVFMxZ1ZsR09LNDdVQnhUTlNPR0JyMS9sY25vMG5vU2sxczlOV1cy?=
 =?utf-8?Q?X0deoLnfKC3I42ncSUbBr/G9I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59d2c7-f397-440f-aefb-08ddf13960b8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:44:49.6466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4DoOhkUUhqobP2V0t5eMS4b1cufcn3RhAY5JoOhw43PneNNBnPRYqhLlr5MlbLuvcTJsk7Pqd4w6lqmPPjWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Rest later i will try to improve the definition of each list with more 
details for clarity.

On 9/11/2025 5:39 PM, Christian König wrote:
> Re-order fields in the VM structure and try to improve the
> documentation a bit.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 30 ++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3409904b5c63..74e61e45778e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -349,12 +349,16 @@ struct amdgpu_vm {
>   	/* Memory statistics for this vm, protected by status_lock */
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
> +	/*
> +	 * The following lists contain amdgpu_vm_bo_base objects for either
> +	 * PDs, PTs or per VM BOs. The state transits are:
> +	 *
> +	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> +	 */
> +
>   	/* Per-VM and PT BOs who needs a validation */
>   	struct list_head	evicted;
>   
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
>   	/* PT BOs which relocated and their parent need an update */
>   	struct list_head	relocated;
>   
> @@ -364,15 +368,29 @@ struct amdgpu_vm {
>   	/* All BOs of this VM not currently in the state machine */
>   	struct list_head	idle;
>   
> +	/*
> +	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
> +	 * have their own dma_resv object and not depend on the root PD. Their
> +	 * state transits are:
> +	 *
> +	 * evicted_user or invalidated -> done
> +	 */
> +
> +	/* BOs for user mode queues that need a validation */
> +	struct list_head	evicted_user;
> +
>   	/* regular invalidated BOs, but not yet updated in the PT */
>   	struct list_head	invalidated;
>   
> -	/* BO mappings freed, but not yet updated in the PT */
> -	struct list_head	freed;
> -
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> +	/*
> +	 * This list contains amdgpu_bo_va_mapping objects which have been freed
> +	 * but not updated in the PTs
> +	 */
> +	struct list_head	freed;
> +
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
