Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA7ACD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 11:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF00A10E40E;
	Wed, 20 May 2026 11:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OKqjQbOJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5377010E40E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 11:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZ6oFs0wKALF+ONQCZPz5IldGXGN+JQYjWVzQvv7SUKK9DBUMYEoJLF3WS1EkqikTQvK8hUwOYTbPnNHArjaX5WrhliQNZWBfUBieTKUDwzn9Rldjw5S/a9n/jpSFFXPbEJAv41518YDCeSIfU1taAdpNfGfUpGdpFM9zgFDDBW30J98MCziuV3VFAw8vjYSa4xcEo1XIykGSEOFWB2JUM+tWs2PmLH6ggLxmons8NchHq6Mtrv3rFRVUDrcUvscCEqBG9Vef7sjhkwXoXbulLXHuu4SbVw4SOca/jI5TzvKIHulYL5xJy5Uwadx35Dvk6gRms/pzaSwMgIIcByW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN60NLqOG2KKXtxNBmB+QUk5QK4vDQ/mMLK6xYdxnhM=;
 b=BZm3BFmAbslh2Xa9fVGjfXG90sqspDy713ckLf7mpX+H0fMFErQzKLrSzEuYn91fg6MK9axHWgtxZxH5LJ1wwGOyVaGXQ3baA7Czc/Fp0JXM5waXxsKhr3x3YuYl1WjpZlAFsm2WERE71zfGts+aXiiq2TX+W9406y4CB7SZcJbNsebe9p66RnrMJIDH9miwRgomrSE5TxZHUlXdUgACGiYfF5/cply5UtTuSTASgZRZqNt2I4u2EsJE2WFYR+ft+n508Ox6GbeU3utltuErHtMesezjRXa1Q39vrVyP8hkHhty6MenCtPhxJ5Of6wd/Px4BI/zDBeip7PEurBQQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN60NLqOG2KKXtxNBmB+QUk5QK4vDQ/mMLK6xYdxnhM=;
 b=OKqjQbOJkWtpcSgW56IYFrbkWlCgtR+mNDnL/4ODEEhqVn0j1hHADuxHcFAJrArR/rMV1uTjC152zWe0wAanElSWjuPFcgQH9JLjQLKSexkG62QWg8MeUkYU40IGwnDYFwoUrDbeouea63jyQE+e4VlAoxUu6JuD+sd0/wvHeEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:25:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 11:25:37 +0000
Message-ID: <cff0a9b1-5e02-48ee-bd1c-bd0f31d89bae@amd.com>
Date: Wed, 20 May 2026 13:25:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260514124250.3833711-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 23340e24-d4d7-4f2b-47d2-08deb6628441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|18002099003|4143699003|56012099003;
X-Microsoft-Antispam-Message-Info: ZUdUZtA2+lRpiNTvxFBn+pJ7PLHlWLK0CvxaJV7idv/FqMYzroRVTLnpwZQLM6nsAt1ixf0mX0nzKs9Qcm4XL9NLEHAfN5jJ1ou18kLcmtO+dXeaq9uwvhZ79cjIC3pfHQDtu4okHfbPYCr0ob3B2wiyl/Y5fjGsrhVD5HkTBsfU/lrD2yF0X5pEFLSu5ALBG5W8Wl0elQUnzJoh+s4z6Qh7ZYmj+TxT4+ywbGHHtwiknzft1DPX9CUs55A9STepXl1KOmFc7lkr5OlscwSqbMU6DUf63DcDUiYrngn/GWp1dIaWdx+ZWlP4PIhRDovkPw7gNTLpRV2UO7DB3CtmrN+In2DcMDWArftOPs3UB+n3AWxOHSk07DGt9My8ZzblUGnrIE6zIRtpi0OugOFOtWvAb/Izdtw18fB3l9/AvOb09GNbhn5Wfhs7ePPEs7taJFlZQc7LK2PnboM5I+i8pshL/79NZuQSrtev94eWzGE7DNg/Izg35vAgvAwWNA1P9Df0K1+FfO11PxmP8jqX18Ht9ppLZUr136OE6QTgaHJsWsZfY12wIvmgqosZDhzdc5XCxxqbLH7FwtVZQeTAkq1tC8pnG6SA+dFZkpQTUAS6x3Mhdu1eIEgKvriZdggk7qVFWApbt4ZkEy/tRqm7YKKH5ryptc2xJYxojL3MbbpUqz3xMtBiHpc2Ei4Brod3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(18002099003)(4143699003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFV1WS9RYnhKMmxzdmcxd01QNVA0OUFHbWRTYTRyMVUvMWpzeTlDd2FvY01S?=
 =?utf-8?B?NU5PbUp1QjE5cUlWVGJyYzRiaUs1cnV2bUwzK251MnZ2OUFOdTNyaGhvMXFx?=
 =?utf-8?B?ZmFadkFkNkJPMzJBTDZma2ZndW91bldvOExUcUszK2RRVmIwVE5yY2xvV3dL?=
 =?utf-8?B?dW1TMElyMHRTd1VBUExwZWtIbzBMYlkwdUtHOCtZTG9jZVpmbmg1d0hreGtE?=
 =?utf-8?B?MzU5R2lRNXRRN2x0UkZWTUg1emtyc3AxSmV6WDJPdS9WR3o3RlBzeUZFTGVZ?=
 =?utf-8?B?WUFrQnQzeDBXRFhlWGVTbEY1SXRvajA5T3dxWlY2ZU9peE9Gb1diQ01Xa21L?=
 =?utf-8?B?NjNFTEoxZHNFWkZZSlRSL2RUVWI0cEVWSFMyWXh0VjZ1bGlHNWgrcW8xaEky?=
 =?utf-8?B?d212Nk44cWFpdVhURXZ2blNlNHFta0xQN2ZNVHU5QmJZT3NjcVgxVHlBRnpB?=
 =?utf-8?B?UVFDYjM0S05RQkZXZGwydFdML3AxSkh5STFKaS8rQ05Gb0JqcHl6NjVZbzZm?=
 =?utf-8?B?NnJKQjVWZWVkVS9iZHJjcDZVUGNTOXlZekJPRUtYYitFcVFaYkxaSjZjejk4?=
 =?utf-8?B?ZXVkL3JTSnRZNWhucUxNbzZGUW0yUk4wcmM4N0xGZTczT2hVS0F4Qjl0L3Jj?=
 =?utf-8?B?dFdxL1JsZ2VPVWcrMGFkV1Baa2FJY2lVYytRWWJHUWhVU1Z4S3ZCMklXZ2sv?=
 =?utf-8?B?UDlMQmVadDhhV251TzR3ZUduQjVCdVRwOTNSdTFtK3lvMWx4MEdOSVB3OGJr?=
 =?utf-8?B?NjA4MStNRyt0blZWZXJnQnFqL1ZQSUZHTDBBMVU3VDZvaWdqZEJkSS9ORG5h?=
 =?utf-8?B?UHhLQ3FkSW9nZm9TTFYxNGhjU010VXRnSVd1MXVlQzIycFI0UTJhcElSaFls?=
 =?utf-8?B?L084eHlJR1ByQ0YzZGZnWnd4ZDVjcDhneWg3dFhrK095cjN0YmtZblRuRTVH?=
 =?utf-8?B?WnJxVE1oSFIvRHVDaU9OOE83MGpJcTZ5dVFpNW1NTGNWVFJlYlA4UmdRamtI?=
 =?utf-8?B?QkJ4TURVV3o0aW5icER0bXpUWU51eXVTb1dacVoxQW9uZk0wVUlaaXFLSXZU?=
 =?utf-8?B?VnhwM2EwWFFvQUJiZHh5VHh2eS9IeEQ5am5LZUp6SjRaN0MwbFNjUjlBMFA2?=
 =?utf-8?B?eWp5aFFHcmdRbTFBVTQ3ODh5SUFWbTJYKzkvYlhtWjVJUXJDZHRidjZjTzBL?=
 =?utf-8?B?QTIvbURRQnBnWVQwYkF1NllvTTZyVVNmdHZZRFluVGphNDk2V0tUVTBkdkNi?=
 =?utf-8?B?SGtzaHFIK1FiN1V2WGh4ZDVMcmhhTE8ybzdlUWkvNE16Z21HL1gzTHdTeWNj?=
 =?utf-8?B?L0dXWlZUbzI2ZXo1NGtJcXJLOUtSZUhqMElUdDF2QzJ4Y2FUQzRXYTZwVDg1?=
 =?utf-8?B?amFSdVVUZUhHU1F2TDFHaFptaHNGY0VhRXFROFU3QjhpL3FsaVltUlMreThh?=
 =?utf-8?B?OTdBNGpWMm5tcGVyVVdyTWRaOU8rNm9tam5wdkJ6YU55N2Y4N0FpT3o4c3F2?=
 =?utf-8?B?K3ZYSUFUQW5ReWZyUlUrdkNGMjBYN1VkZmFSWDBzUGpSZEl3VkJOUHNaRnZ2?=
 =?utf-8?B?eFM1L0VFT2NQTjZ0QkxScG82dVd2VGg5bmNUN3VkVFlneXZQRXhrVTVzZXhy?=
 =?utf-8?B?Y2M0OUFVeUQ5U1dQOHA3QUlvaHM1MFMvdXo5Y2FRY0tacFNEaXJIdm9iYyt1?=
 =?utf-8?B?NU1ueDZNOUo3UDlaelQwWDVQenNLL1RnYTNjeW1kQzRmdExiblB2WFN4OUk4?=
 =?utf-8?B?YzBhalh0QkYzbFErd2htWlNLZ05QTUNTLzduaElGbVNYZGdJUDBzU3IwT2VW?=
 =?utf-8?B?VzlNN1FvazBVZitaL1NhRmV3Z3N1VnJDVlR4dmw0OEhsOVloM3lsN29HQVc5?=
 =?utf-8?B?dStaNzI4OE9XQ2x2TnFoR3JvSW5oWFh0SFg3V0IrRFplUlBWOWJOSFdHMlQv?=
 =?utf-8?B?amlBc0J6OVo3MWc0bFJ4ZVVJczJGbW1TcU5CK01WMnNULzQrc1ZFVEkrTERQ?=
 =?utf-8?B?aHdLUlNNMlNPSzhwWjhXYlFBWWdJZTZlQktERndtQU5tWVhFdUJiektBSS81?=
 =?utf-8?B?ZEwrQXpaQXJncWdBTUpYejU3NFgwa0dTa2hDUVBEQ092dG9TOG9JeEwwQkVU?=
 =?utf-8?B?QU9haHk4QWdDblFkeFQ3b24wTkhXRzRYRTZBTjU3aDRkbk1aZklEM0ZZendS?=
 =?utf-8?B?UHB3QURnWmpSOFpkT3M3Q3BtSEp1U0JqS3ZmNmpEM1ZwYUZ0REJZaTlMTEFi?=
 =?utf-8?B?NjI2cU8wYzBnc2tSQWZBemFtbFRxL2h2Q3pKMkRzOVYwQitNZi95NXdvcmZC?=
 =?utf-8?Q?z3p/K4Gt2vD80M/brm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23340e24-d4d7-4f2b-47d2-08deb6628441
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:25:37.7326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VlZ6wKgfwDcFz51rR8RmcvDf5chKIACauhDYix+v05ejV1yJG2VMqNpOCuoxDRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On 5/14/26 14:42, Prike Liang wrote:
> If the driver only preempts queues, there can still be inflight waves,
> pending dispatch state, or resume/redispatch possibility tied to the
> same queue. Then the VM/TTM side may proceed to move/unmap queue related
> BOs during evicting the queue while shader TCP clients still need to
> access them.
> 
> So for eviction, unmap is safer because it makes the queue nonrunnable
> before memory backing is invalidated. Meanwhile, for a idle queue it's
> more sutiable for unmapping it rather preempt and unmapping also safe more
> processing time than preempt.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

I was already wondering when we switched to preempt if that is correct or not.

This patch here pretty much confirms that it was not correct. I need to discuss with Alex what to do here, but for now the patch is clearly a bug fix:

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2e3edb6dd506..a63dfdfa4195 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1048,7 +1048,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  			continue;
>  		}
>  
> -		r = amdgpu_userq_restore_helper(queue);
> +		r = amdgpu_userq_map_helper(queue);
>  		if (r)
>  			ret = r;
>  
> @@ -1285,7 +1285,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	/* Try to unmap all the queues in this process ctx */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		r = amdgpu_userq_preempt_helper(queue);
> +		r = amdgpu_userq_unmap_helper(queue);
>  		if (r)
>  			ret = r;
>  	}

