Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4EAC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 04:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A109910E105;
	Fri, 10 Jul 2026 04:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pY1Y1iq2";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFC410E105
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 04:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4l2tYtmmCobZtxAFC1CuDPiuKt0b2qO77TbozEFDZ9lPb542BNqlhdZ9a3+ifVsWuRQzZA6dkdB2zJRv3pQ4b0eB/3Nacnsr6ZkRL5xFqcw51FXm+z2VhNRaox2alDp1SNG4BmHJ6y1uXzNwVhKqmAuryzWN6XnQrqt+7WaLtiZuJchXRIWaJWHzfwq8fVi+kT1ttUwHwdUwOscuiAu8QctUJ2JWF2/0HNo2HzrjOPrc1odnwdbW3ubLU/p7L7tgft3UyMlBhvTqHXNDmW6vQFyNKhDeRlhRc5dMB3DmONwg17pKHN5L71v2IfkpQSF92DQuPWkAmTLmIYVLf1Duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTDOcWh3dXo+sDUl32wO+vAHuRKsDzlVmeWdBhcC4hQ=;
 b=quHNt1I73WMk+J0Shj1/Eo875SGF3hgBlCN55EqH0fB5ISNyD3v5RR9KQjcjErtLJRiHEtDoZDZzRiZPq7Mev8TYCCXhK5v3UrGe8JRPY0RzdqzM5COVMbv1+macW/0fcco2v73T5y8IMO4OK8J19lb+f9H1ij4nbjwY68D4fdALmyGMALIIyGpW0IM6wclORF5Y8VRl53BU4kYVpUZ0QWhhj6iptKw+dwumDV7fLBYqwFFvhy47shy7doRQlayQyhBEmQlv6Tzvm62ZrQV8w35NP6rrOPzPi4vE8d7pSXtmV0VCMA1QLnT7aWhQmdlCf77KHw+6L8kyLadKUYdZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTDOcWh3dXo+sDUl32wO+vAHuRKsDzlVmeWdBhcC4hQ=;
 b=pY1Y1iq2rHXUi2M5fUuyIOOsmhmu/wsPUalLIIJ2W3ywYlKx2VzOcxfrPQu3zGDI1YaTgcQSWCez3YPu5frYXgUhR8gGBxYXsdtcknGldKPy3iR4DOsFn/2doBY2WR3R3l9m10P4M1glqnYWNjDtS9Q1thSwef7wwiy5NhXlZjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 04:28:14 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 04:28:14 +0000
Message-ID: <79d0086a-8aba-41bd-8d76-db3b809d6745@amd.com>
Date: Thu, 9 Jul 2026 23:28:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Content-Language: en-US
To: "Liang, Richard qi" <Richardqi.Liang@amd.com>,
 "Soliman, Fares" <Fares.Soliman@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260706204711.4022513-1-Fares.Soliman@amd.com>
 <IA1PR12MB6138FC719502EE171F4D6D53E1FF2@IA1PR12MB6138.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <IA1PR12MB6138FC719502EE171F4D6D53E1FF2@IA1PR12MB6138.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:806:126::27) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: c1644aff-146a-4882-538f-08dede3ba831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: mLXI1MZJvw4sdFUVqoOeAsS7Pw31+otx3YGLlSSqvsQKC7eVDMHZ4iGuQxZ013lcZazjS4IMdmV9SCaTtDSD8ZXBmJVYFqOG8Pplqhejp0DdzAFKUoMnQv/XjZWCR4AkxBp0aSFrpH8rSqSy+EGlragpEZn6NYzxmbxhhOjyD5FMtdRDXlfh/oLPFxosVEBdgOIdjbr+F1bsd8bNdrhnl48BM9It/Tl3oroJDm3WueKtdT+mRGLcrGDt4usygNh8BtsQoHJgNjicHTVoLsNdQjqXg/ja2qlq2zac22uf1B2gDOh4Gm34TX2YkfkNoeIDTer16teZk8MAWigIn/JDywkqZaYrMN73wJq0C3EYnukq6PsZrZYBFvI6FQaz+Xg6f8c7aXNE0SblAPK4g4pMDLUZAVt7rnh2sa6gMY4nkrBdiX5hQo1G09MtH1UV65VLyZmb4zFIF/fKYT0AdSTCeKn75Bn/lDqBvaBP1ZnX8hVQr5np07RN1KAtwsJCg7ehgaBHR/dVRZ2hCOAIfNFPsvKNs2a34kEThwVshgR8Zuci0mOSnQ+uJcrJy/y63mgZ2QxosJZ4IK6NvsbAoLjRWqp92Dr9jrdMPs1I8A+reiqmkFGB5bBHUuFDqGoN1ENa8WbTlJTCyuybLe5eiym40baIpl8/BDGK2PpOi/b/+WY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTkra2haTHBnTE1lUUozbjZQb3lDTnNvNW5HcUIzR0c1VExETFJMKzNNT0tm?=
 =?utf-8?B?NnlCTHFUN0hGb0R6UWRzZ1VsZnNqcDNQQkIzRTRpNGxDejVZbmJjbTRndUtJ?=
 =?utf-8?B?ZEV1cmJXZEpIK1h3NVNHcStrWDNHYWFyd0Q0c2U4QXhNUi9DR1paVVpXYkdM?=
 =?utf-8?B?Nll2SW1rYzFFcFlCSTlNQTNlUmV4Njl1eWRiQk0zaGZHRDc1em9WN2RKaFlM?=
 =?utf-8?B?Q3RqYmRzRHE2T3h3Y0FUTVh4SjlCZVB1SE50NFZoZFhaNDJkdjZQNnpiZWxS?=
 =?utf-8?B?dytPdEM4SW5mNDJQZzdldFV6UzhOSmhNVWo5THRaVXk1L3paVVlicmFTYmhq?=
 =?utf-8?B?T0hVczRZY3BTUHZvV1VqallpUHVGT2NYY2srNnFyTUw1STMzSHNPOUFDTkIw?=
 =?utf-8?B?cW1lOUJ4MmVOYk9yUGNvdFM4WXlvd0JIUHdTaHRjaGhEV3EvZWh5cnBzeHI4?=
 =?utf-8?B?QXluWVhUZjFCYXpTNFl5SHEvblFDQ2J1MEpWL1pHaFdlczM1Z3VBWngzN2c2?=
 =?utf-8?B?cDNoL3NNU2U1UHBDNmREUFRCMTV3VldDTmlWQklvSnNvSzZzNm9ScVVRaFJ6?=
 =?utf-8?B?c3UyeXdCOEJMUURKdVk5MkxyQjl5UnFZZWNxbkt3UXBWRXRVams0RUxNNFVt?=
 =?utf-8?B?M2V1SnI3U2FVTXdzbG54a0xKKzFhYjhQVE50eXUvSHh3cVJKVnZkbjRvS3R4?=
 =?utf-8?B?YkNQdkZZRGNsMkNwWVVSQmNEM1N6WTBtK3RlOVJKVHd0ekxLTEF4UXBaa0xj?=
 =?utf-8?B?UnZnSDZ1RnhuZnV3VEN1T1FySDQzclpxNS9mRzd6MUtVNXI5Y3ppY1VtM0Vt?=
 =?utf-8?B?cmtsT21DbXhOTU1adTJhNXpQRG1MZTE0Z3QwZE5BRlpYemJEZDBPYThNZEsr?=
 =?utf-8?B?UlBzREdGa3lKbzVKRmswTEhaS1BXWS9COGZqcWZnTE0xdkVyRTVBUmdXblNq?=
 =?utf-8?B?bjY3RFdpd2U5S0hlTWQ1SWNmU05xS1NwSms5RGtMUmJLcS9GdExNcnpTRmlR?=
 =?utf-8?B?RGRnMGIvRHNSdmNBcWdwckVRc1hvQ3BEWlRQWDJzdHgraVRTemRqM2hOMU5t?=
 =?utf-8?B?TU56Q3owaDBtY01GR2lzeHRkNWw0eWhPeUJGMzFBREQ1VGxzVS9wOUdPOW9h?=
 =?utf-8?B?RG42VlB6VGJOK0NBSjk4a2o1QjZ4dTFoMUZhZ3pramRTcHdKVzlkWGg3OUpU?=
 =?utf-8?B?OWUvNEJzNmZMQUNwa2pLRkV4Vm1oK0wzdTkrL2JlMENyV1ovOXY2VnN3Y01h?=
 =?utf-8?B?eWxPRVRwRE05YW5NTDlxck9OMkZuMjYxWjdWTzY0L25hUDF1MEpvY2h4ZGw2?=
 =?utf-8?B?UzdZU3JHL2J4dmtLbkhaZk9kSkl1dWJqWXVvdE1qYTQ1QVB4NThqL0NxRnI0?=
 =?utf-8?B?cGJteUVSdCsxSi91ZUM4ZmdoUjRGU1JMa2toWUtiZi9OWGhXQ1BySXlCbzVU?=
 =?utf-8?B?L1NPSllSNjRJSm1MZVA1YnlFVW93VkVuNlFWUzFYLzQ5NkVCS1RKb0lHWU95?=
 =?utf-8?B?bFNwSWQ2RjRaNysyU09zQWRsNVVLNkJkcjlJMHU0M3NsV0RnREFGZDA1QUpX?=
 =?utf-8?B?MlN0cGIxK1VzVmV1Vk1RWVh5YjMvenNBZzJkSTBxelpYclhMZ2JLSWhTNXJN?=
 =?utf-8?B?cVMzL1Z2bDJTMWZPMTJuMlZPOTNPQ3FROVdKakVVbmQySEJZclBmQ3J6dVlP?=
 =?utf-8?B?T1I5KzV2Y05MZUxINmJDT3lvRlVzL0F1UkFXbXpsUkhkUXlBaWVsSlFGUUh5?=
 =?utf-8?B?bzFBZFZCUWxONFBZYTd0aUF0Q0lBT3UvdDFaRnFQc0YvNkxwdElSbTY5QjMz?=
 =?utf-8?B?Y3FDeW9ucU5jZVdtNWFVWFNkOVpHTXI5YlJDdHd4Z1BkanFYK2doK051eWRR?=
 =?utf-8?B?THVMaWpHN0ZBeXhaUXpla2JzbnY0L2RBenFaS0hpb0RDWDR3QW1kcUE1cVVh?=
 =?utf-8?B?dVlHb0F3TjRXSlBqR0RvVlBUbitMWWhJZFRQZER5ZWpqNnJ6MCtjQnJqb2hE?=
 =?utf-8?B?WlMydkFZVjNjcjFBN1ovbm9manA1YnYwcVNxZEFGdGUxVnJHaTNvdUdxQWpl?=
 =?utf-8?B?dllMTVpGRUlhREVHcVBWZERsR1h1bzgzenpId3Y1aDAyajhBbWt1ckZkSW1l?=
 =?utf-8?B?S1JHZ1praEJSNEdYVFIrcjNwcENDUHZMVjVLdlE2YTVkWUZGVXJJbmJsSTUy?=
 =?utf-8?B?azZBcWxGcGF3Z0pJdy9vQzRNNy9zTWZ4NHdJZTdHc0FaNVBvMk9IMEdZYlUz?=
 =?utf-8?B?NXJFejZIYkREVmREemJTbTZLSUZHWVdtR1FtOHRXTmlQR1FCOEErc3c0b1Av?=
 =?utf-8?Q?RuRbVnkGoULiKlOkSw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1644aff-146a-4882-538f-08dede3ba831
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:28:14.0661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhZ8ZOUWOEab2/wcmOfZEYxWcahDjpSzkGgn2/w9qeeSOK9f6ma8FtzZP8jTjK98IXs4zM5dnZ8J/pwi0LvnZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
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



On 7/8/26 17:57, Liang, Richard qi wrote:
> AMD General
> 
> @Limonciello, Mario for code review.
> 
> Thanks,
> Richard
> 
> -----Original Message-----
> From: Soliman, Fares <Fares.Soliman@amd.com>
> Sent: Monday, July 6, 2026 4:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Soliman, Fares <Fares.Soliman@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>; Soliman, Fares <Fares.Soliman@amd.com>
> Subject: [PATCH] drm/amdgpu: Update message IDs to PMFW to correctly gather GFXOFF residency logs
> 
> Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on Van Gogh. Logs are now gathered live rather than starting then stopping logging and reading an average value afterwards. This is in accordance to changes made in PMFW.
> 
> Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 -
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>   .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++--
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 ++-  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 30 ++++++++++++-------
>   7 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5c4d4ff001ea..46514a1faf1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>    * @size: Number of bytes to read
>    * @pos:  Offset to seek to
>    *
> - * Read the last residency value logged. It doesn't auto update, one needs to
> - * stop logging before getting the current value.
> + * Read a live GFXOFF residency sample from firmware. One needs to
> + start logging
> + * before getting the current value.
>    */
>   static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char __user *buf,
>                                                      size_t size, loff_t *pos)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62b5ad4d10b0..1bde0645c6f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3725,7 +3725,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          amdgpu_coredump_init(adev);
> 
>          adev->gfx.gfx_off_req_count = 1;
> -       adev->gfx.gfx_off_residency = 0;
>          adev->gfx.gfx_off_entrycount = 0;
>          adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index aefd4f03b443..4c1f8504ee1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -493,7 +493,6 @@ struct amdgpu_gfx {
>          struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
>          uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
>          struct delayed_work             gfx_off_delay_work; /* async work to set gfx block off */
> -       uint32_t                        gfx_off_residency;  /* last logged residency */
>          uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
> 
>          /* pipe reservation */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f8fd93999617..d94e3dcf7f9a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1333,7 +1333,7 @@ struct pptable_funcs {
>          u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);
> 
>          /**
> -        * @get_gfx_off_residency: Average GFXOFF residency % during the logging interval
> +        * @get_gfx_off_residency: Live GFXOFF residency percentage
>           */
>          u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t *residency);
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..4206514765cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -110,8 +110,10 @@
>   #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
>   #define PPSMC_MSG_GetGfxOffStatus                     0x50
>   #define PPSMC_MSG_GetGfxOffEntryCount                 0x51
> -#define PPSMC_MSG_LogGfxOffResidency                  0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_GfxOffResidencyLogReadSample        0x52
> +#define PPSMC_MSG_StopGfxOffResidencyLogging            0x53
> +#define PPSMC_MSG_StartGfxOffResidencyLogging           0x56
> +#define PPSMC_Message_Count                            0x57
> 

So the definition of 0x52 changed rather than additive?  That will be a 
bit painful in the code.  You'll need to have a PMFW version lookup and 
decide how to treat it based on the version.

>   //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 636ff90923d9..acf03838d49d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -252,7 +252,9 @@
>          __SMU_DUMMY_MAP(DriverMode2Reset), \
>          __SMU_DUMMY_MAP(GetGfxOffStatus),                \
>          __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
> -       __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
> +       __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
> +       __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),          \
> +       __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
>          __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),           \
>          __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
>          __SMU_DUMMY_MAP(AllowGpo),      \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 717ba46c8933..4212abfdbe53 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -142,7 +142,9 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>          MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLimit,                                          0),
>          MSG_MAP(GetGfxOffStatus,                    PPSMC_MSG_GetGfxOffStatus,                                          0),
>          MSG_MAP(GetGfxOffEntryCount,                PPSMC_MSG_GetGfxOffEntryCount,                                      0),
> -       MSG_MAP(LogGfxOffResidency,                 PPSMC_MSG_LogGfxOffResidency,                                       0),
> +       MSG_MAP(StartGfxOffResidencyLogging,  PPSMC_MSG_StartGfxOffResidencyLogging,    0),
> +       MSG_MAP(GfxOffResidencyLogReadSample, PPSMC_MSG_GfxOffResidencyLogReadSample,   0),
> +       MSG_MAP(StopGfxOffResidencyLogging,   PPSMC_MSG_StopGfxOffResidencyLogging,             0),
>   };
> 
>   static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = { @@ -2450,19 +2452,20 @@ static int vangogh_set_power_limit(struct smu_context *smu,  static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)  {
>          int ret = 0;
> -       u32 residency;
>          struct amdgpu_device *adev = smu->adev;
> 
>          if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                  return 0;
> 
> -       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResidency,
> -                                             start, &residency);
> -       if (ret)
> -               return ret;
> -
> -       if (!start)
> -               adev->gfx.gfx_off_residency = residency;
> +       if (start) {
> +               ret = smu_cmn_send_smc_msg(smu, SMU_MSG_StartGfxOffResidencyLogging, NULL);

This needs a FW version guard.  Old FW won't have this command, newer will.

> +               if (ret)
> +                       return ret;
> +       } else {
> +               ret = smu_cmn_send_smc_msg(smu, SMU_MSG_StopGfxOffResidencyLogging, NULL);
> +               if (ret)
> +                       return ret;
> +       }
> 
>          return ret;
>   }
> @@ -2479,11 +2482,16 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
>    */
>   static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_t *residency)  {
> +       int ret = 0;
>          struct amdgpu_device *adev = smu->adev;
> 
> -       *residency = adev->gfx.gfx_off_residency;
> +       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> +               return 0;
> 
> -       return 0;
> +       ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxOffResidencyLogReadSample,
> +                                   residency);

Same here.

> +
> +       return ret;
>   }
> 
>   /**
> --
> 2.43.0
> 

