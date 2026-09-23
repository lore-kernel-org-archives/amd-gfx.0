Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB391C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684DE10E989;
	Wed, 23 Sep 2026 19:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZT5BzU5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4904110E989
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXxCoRO04rsTarNZdrA16+DpK4RB2jZ2wJNlilqtDwSN9y/ChzeOo07zEFv72I9ZcS5t6rS0KP+HgeVKGswbYrGtesRyi5vCFAg8sFpf+zPTLBndORA1HWrF5pLEXx1tBj+F/8TQCAYJz1nK+VQuyi62pN43GMPF37ETMIG5AmEoMA8dUa2dWupHunLu4rwmje77O120nnWxX3ZH41mtAfkTTyx8hjFPrcqB73KfnO//RCVXEfSo4b5w9aebbMfk1ofIWDGeqnzc1xLAfB7gYxf2Rlgsoth4EfrzV8YG3hH2sr+LIRWOhWJNClZX6PcP1s+blE4DcLgY1sYnUgtNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3a/0wF3ea7n4x04POvCxkeFPRoaUKujRjy+jzRDklY=;
 b=CfPFYuUscCf2NcXjylTIxZ9xb7nxfl4fLzWOFiCdjQf7ndIEzyI6OAyu+HQj5XpG/G3Tyu+QJTWAO85E1hgV7ZqaKGYk2CHMeYl+Cmip5p4EMPxMpkSk/zya0jzVEqo20OQ91Z8ctkVgObFQsEdSEV9NYgo1rhbDBAyoHAOTFY9HcjjgYLMf8B3V2ypKLr8Y0UY/euBvuS+5m0vy+5I7Vcta3efWtgKzO6NFLbaV/v1eKTmOfxIDp9DQc+rlbOGwXHTsBwhypa1nRhv0Wami2HYp05DS9E2Rp9w+Ig/U646oXKsigpt6tDy2nkDYWyj++7A8m9ToCWfAeQKFOzA/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3a/0wF3ea7n4x04POvCxkeFPRoaUKujRjy+jzRDklY=;
 b=kZT5BzU5eZt65+pbLVDMUiqBvEhWdYSQd9xV78Gx480e8s9dGN1cWQTgjoN91bL4aMvFbSjA9BZDKghtyZG9je2v47VIXe7to0zHpZZDcsZhbbqrgCejhpRyZChshUCg+PhcKCl8B3w8WFeyrCE6Vh1ZbKDUJdbcX828h2vDpxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:51:50 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:51:50 +0000
Message-ID: <a0714693-7a9c-4da2-91bc-9618e55773a7@amd.com>
Date: Wed, 23 Sep 2026 14:51:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: Fix fast updates on DCE 6.x
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
References: <20260923122033.1046651-1-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923122033.1046651-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:610:118::32) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f798515-ad5a-41b7-ba6a-08df19ac1baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: O2Fk2M6lXUQTgU6L5v3oTosnJC4IVYT3Cc0lFEs0bOt7z6O6Ksw/YXU9MscUwuBvddsPqaAr3U3gOJBAFJty8xnC+P1xCR+fBrl1bmxe/9tuo2NwYrCb0GxPeh5ZILzZBEv4Km4+DAYgQCAs8K70MV66mBnVVn98hIqQidyRu8/UHIn60YnUTK7J8i9HVpcGbqpzHSMs3cOP8zi5VxUFHHfqcUrMfo+K++gASeznPptlH1upQSgJIffwyMOjcNTFENtrxzmDBnFJg+xSp9iZxL6lYaCkUoRT0QZSGjiazQ6RhqhiiibdlyUD/IdAatW3Iv9525PDjk43+TbSaFzZZum+51CAMFTqk1x/270t5k3X5eLpjvgq68/5HfBQvKEHPL4iz/lZ3d2XzunmJhEIs43jyLxj9bUI8DkWEiGs1uNbEBZF1HOjFrtAmA/IlINepahKIji0axdPT7prSGhXwphEbU5d7eTW5WZB2wVaguBPiiynbPt1QGWdlNQW82rfw34g/xCBCjAQAmlfRkn1y25NFKgI25m7hVY+Mrz/LbeMRuCGM0s08S/8XIww0TscsEHvuGXW9jJDcmDAB/TVhf+YwFv01eafAKMCJv0zAlBw6uLTpk/059NA39oK4BfEkle0v4Wso2Nth4xlPwftZERadD0lTgny/T11v7vnLzWcfeZwXwGjxIaSJE1esO75sLx97gxbuNA16PQWMQIyxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkt6NUN4RmppNXRUbHB6eFNudHFRMno5MkFSN0hudDd1RDlQNjZja1FVVVBE?=
 =?utf-8?B?ejRYREsyMGdjSkZROXptVzcybVFxZnN6enEvOUpXMEllS2g2K2F6OGNQWmpI?=
 =?utf-8?B?MFB2TFRuaThzOTltUC9qelZ6Zk83TW00Y3dGZFJhaTZRWSt4eTFXQStZUXJI?=
 =?utf-8?B?d1oyYk8zclNGam14NCthdUlIeWZSYVJyd2xqS3VtallSWFBnWW81cTJvZkI4?=
 =?utf-8?B?Y1hwOUV1R0w0aWxPSCtnbnk4dHFvOHlMYy9sQUdmRXB3RmE2blB2dmVUbkll?=
 =?utf-8?B?WElLQ3dhRkE4ZWpQcUFad0REeHFvMHlrSVNOZjEvUDMyNXhwcW51SmJidXYv?=
 =?utf-8?B?Rzh0THA0RWF6QUhJQXVSSm9IMVRQTnFyQThjZmZEYWdTRkoySHduNDZLVGJ0?=
 =?utf-8?B?ZjRGdkZiVSs1NUFDZ2VOeHNUUkpsKzBkVkRWMWx6TEFSQU4zbm8yanF3dUpS?=
 =?utf-8?B?Undkdm0zNXZ2eXZwelRLUnRhRmkzNXRoNWhTZDRqN0taMDg1bjRteXZiK2xO?=
 =?utf-8?B?Yy8zZlVBa01Ib1VTMll2bGw0UjVxZjlXSVVWdHRURWdRM0JRR1FoalJXcnNq?=
 =?utf-8?B?WW5JOEo0dU9pdnpkVTRmekM3NjNWUVVXclp3cTNtcTg2RUlwK1R5MkZkMzcx?=
 =?utf-8?B?aWY5cURoVHlBYjJkbGxnUkVsRDE1K3F5bWUvdURRQ0pPVzdnL0FxL0Y3RmVU?=
 =?utf-8?B?YXNHalBQeGRWbFVCSTdCWXgwTjV2M0xxUmdQczdwTTAwVGZTd2U0NVYyUkZN?=
 =?utf-8?B?SEtMY0RpOHdXL3ppb05peUJnYzU4R21jdzBHRVpKbjZ4aTdHaGxERk43QlJ0?=
 =?utf-8?B?a3RPaW8wNXYvUjZ3WkRvL29KMkx6R0VIVmFOUFNiYWpFLzdDaS83RHFBLzUz?=
 =?utf-8?B?dndUNk45aTBDc3V4Q1lTRVR2aG1ZdTIxU1R2M0MzOFVORU92RHdLekhEdDBD?=
 =?utf-8?B?TGlRSEg4M1ZlaGVXUDZSWG1DM3RydlRpZk1Da1U2Q2FSQzhrVjVLOTJHV3Ra?=
 =?utf-8?B?ZmkrejA2cnliV1E3ZjhtWUdVVlk2dzJyMUZDMnJweXRiVEpqbVN3eHRoS2RU?=
 =?utf-8?B?TVJjeTQ5bWJxVlFPUlBudUJZcFQxRGtuRHpaMnkzUmQxNm1hcmZBWnpjQW1E?=
 =?utf-8?B?T0JMUVFSVlJ0S0x2TFA2K2JJYi9JendaV2VPSnp5Y0hsbUdzc1M3Nkp3WnZu?=
 =?utf-8?B?MktDUzZZZkI4bS8ySCsreGxPVDVwdmFNN09PMm1aZ3dVcWl0MjFZVGE0Z2xv?=
 =?utf-8?B?UnBmQ1dOamZTLzJCYmk0ejhrMklaRUtaQTh2TnB1VVp5SzBkMlhjR3FrVmk3?=
 =?utf-8?B?cDE1bGFybHhjakoxTnBDNGtKS1BmM3pBVmY2WHB0Y0ZVcjl2YkpNeHdkbjU4?=
 =?utf-8?B?UkFWZ055L3JvTWFlZTFMMEFlZ2xLWWZIL3RyRDVNZGxhbkpJZGI3S2NOdmRU?=
 =?utf-8?B?dWNOc09vRkl6RjB2L0RzNEkrUDFxS0JqOTE0WktOTm5aYWlXdmpHQy85cDM3?=
 =?utf-8?B?RldTeXpnMStsV29sOHdCTEUzc3JmRDNBdnhMZy96dlhKUUFBYUNwamozTi9p?=
 =?utf-8?B?SDRnbnNXeUJVejBVc3o4SHJ4T3ZUZmZlUUdUVUdldmp0NjdjdHNTY24wQkpa?=
 =?utf-8?B?UDVuV2hSRWVKcnNhQVM2ZUUrNXd1UzlvMVdvRWJiZy9tRUZWL3JkVUJkbUx0?=
 =?utf-8?B?NzJVUTFQUmRvUHl5bmlob3pkSzZHbzFhd09SeEMvRk5CMTJyMXZ3Sjk5ZlBI?=
 =?utf-8?B?NWVVR25QYlJyMEJjOXBRdk5yWjFXdU1kWkt0ajZ4UzlMc1B0SGx5c05CWDRL?=
 =?utf-8?B?WENLaWpORWI0MzB2M0tCeFNES0RLWHVCNlAySzNHZ0pPSDRkenJkcytoSTlC?=
 =?utf-8?B?cFB3bHJhVEpoYTh1MEIzNVEveTZNaHNmOWpESGVFM2pnLzlUK2FPV2p0d0tV?=
 =?utf-8?B?a01PVG5qVGk0NjY0N25rU1lIekQrbnZFRVNGd0JERllNTG1QRlBseXhKNE4x?=
 =?utf-8?B?ZlFsL1l4WXFCQ3VnVys1S2JYVG11TEg0M0E0OXFmVWlqK2dCUi9tWGxDbXRh?=
 =?utf-8?B?S096bUt4OXhBVW1KamFlNnE1cVNvNitQMFJ3TTNyeVM0K0lkZGk4eGM1ZWJB?=
 =?utf-8?B?d3gwK0NJazJteFdVY0lxTXFLME1ZZUdwNGVCSkpjVWNkdzdlLzZxSHpUdDhi?=
 =?utf-8?B?TkRkSjg3Nm55TU5OT2xlMTM1SjJVNEl5bVlWV3FTT3hkS3lZRWhVNXZmVVNk?=
 =?utf-8?B?SytzVW9RZ2FIRlVydUpPZzdFc0FFQkh1ZzZzVDhSTWZvK2cvVTlGV2pDVUtP?=
 =?utf-8?B?YitDd3ZIS1Y5cXdXcnNMbThvaHAvY2RIVk5EbDJKMElXY0VmVXRNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f798515-ad5a-41b7-ba6a-08df19ac1baa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:51:50.1325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hpjy33+WYecONyajVRf6LNQ3fscPEVsyx5EE66eteB+lBVfA1wu6dlCSLsoBgcbchRHaMdY4bt2Z1vcQdfc3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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



On 9/23/26 07:20, Timur Kristóf wrote:
> DCE6 should use legacy fast updates, just like all DCE8 - DCN2.
> Set that flag for DCE 6.0, 6.1 and 6.4 (all DCE6 versions).
> 
> Technically DCE6 should have been included when the fast update
> code was refactored, but it just happened to work until now.
> 
> A recent commit "Attach only plane updates that actually changed"
> has exposed this issue because with that commit, DC accidentally
> took the new fast update code path for DCE6 as well, which caused
> it to boot into a black screen with a flip done timeout.
> 
> This fix should be backported to all kernel versions that
> have "Refactor fast update to use new HWSS build sequence",
> but this patch won't apply cleanly to older kernels due to
> another refactor in "Remove dc param from check_update".
> 
> Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
> Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../amd/display/dc/resource/dce60/dce60_resource.c   | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index d2d56a1c4b8b..8612cc66a6ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask = {
>   		ABM_MASK_SH_LIST_DCE110(_MASK)
>   };
>   
> +static const struct dc_debug_options debug_defaults = { 0 };
> +
> +static const struct dc_check_config config_defaults = {
> +	.enable_legacy_fast_update = true,
> +};
> +
>   #define CTX  ctx
>   #define REG(reg) mm ## reg
>   
> @@ -937,6 +943,8 @@ static bool dce60_construct(
>   	dc->caps.max_cursor_size = 64;
>   	dc->caps.dual_link_dvi = true;
>   	dc->caps.extended_aux_timeout_support = false;
> +	dc->debug = debug_defaults;
> +	dc->check_config = config_defaults;
>   
>   	/*************************************************
>   	 *  Create resources                             *
> @@ -1134,6 +1142,8 @@ static bool dce61_construct(
>   	dc->caps.i2c_speed_in_khz = 40;
>   	dc->caps.max_cursor_size = 64;
>   	dc->caps.is_apu = true;
> +	dc->debug = debug_defaults;
> +	dc->check_config = config_defaults;
>   
>   	/*************************************************
>   	 *  Create resources                             *
> @@ -1332,6 +1342,8 @@ static bool dce64_construct(
>   	dc->caps.i2c_speed_in_khz = 40;
>   	dc->caps.max_cursor_size = 64;
>   	dc->caps.is_apu = true;
> +	dc->debug = debug_defaults;
> +	dc->check_config = config_defaults;
>   
>   	/*************************************************
>   	 *  Create resources                             *

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
I'll get this queued up, thanks.
