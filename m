Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E87CD98C7
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 08:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9E810ED73;
	Thu, 11 Jun 2026 08:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a4yVMzNi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD93410ED73
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 08:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj13whqne4N1AaTykp2KxscasHTZXBOeHA5XooL+BDUIMdlQXtvy9NOQNTNeSjtXKmeVH4L8IGQ2lMS0tSuMS9BSD5e/c0sXA8+Og6n8Sw8EZXIq/hiInSdTgibzLQeS9oUdXM9b+QnGepczblDj6aqqLJPI5i07v1mrZ3p2o4Jr3cBfm9naeBTUMbL4AxjYtEcYOJ77p+aRJX4D/MZgPzRlrOuznIY31X+2aq2rQKozMIkvUqbHZgYMLQB+sCpjj44cXBOTBI8KyYmt2XZt1BJhA7Pr0UvkhpAGbkXo4GJ0HDQyZTv4sPNY529UQg7vOpWNY1sa4RcoPdoFQomGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1q1uJBhAEoDRNNis6izYJxu8vggAIqUuNou/ZsNH9c=;
 b=jwbgcfcFGdedILhEvv4FSj1GhBSLCQq43wG2egWKrUXp4D7vjGFLAqI+86i3lHG7WuUmqwFEOeFurNgAMWGAbKJsgS3FfvmNGwmTHuEa0oQ220uucyCqxLWeDFpMEZd7dNjKzxnOFWrsFACRVTKpXGiFDRXtptYllH177GvPzfuANSZDEAfJ3ieTtuFovziErLMExfl8TqOctHW2293zGUnxXABCCsdoUceY8LHyRH2fduElPFAFi2aCP92Qz2tueSI6Gzxmp0efmtBEpJiUo+mcGqBxlpojZugd0TZa4qCSZsD7tkwvK91S6uK5hj+YtZal5SOdW2GOTLNpARWyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1q1uJBhAEoDRNNis6izYJxu8vggAIqUuNou/ZsNH9c=;
 b=a4yVMzNiX6IffzBFTG7ANQxVlnFPOn6T533259O+HQFtdV0uEkZ56OrcImOrhfbprLi1arAporhXDOiSw0XyyJCmzLX3WG/C641RJ8Y9q6k1ra2YJ0G73pwK85KGAth2HeBqpelNvwMPd0aXw4Pgu1QiTiPMUtyQiF2yJEnKjxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 08:02:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 08:02:34 +0000
Message-ID: <cfcd11a4-a6d3-4d46-9e43-c5dd1f2b488f@amd.com>
Date: Thu, 11 Jun 2026 10:02:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: correct reservation fence slots for userq
 per-vm BOs eviction
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260611070030.186604-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611070030.186604-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:52d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 802c4238-d853-401a-d9a9-08dec78fcb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sl1lxfyvjuJXdi8jyT9FkJf4oMruFBr/GZ2g2kT4vck/EYz07kC9FkCh/nJecAnJBARIdSLRmEQcssqHeyFtRgSovi9MmBqqdVGjW/B9gIJebtFPosdFIonoHffvFHUbgb5cAIz+gSHDB1dvq/vlx8ruaYrxLTVqlCm/1KgivOjoPyLTlhYMAVXi1Uy0aX53TCVyyZitEJXQQepk0RFCo9DmGNi2R7EPyMpirgJu2LOGVmr8dRdj21sJl/XjrSAyxTk8tkuQ459OBmSF+CsOVy6E5xNNWMiQrPmov5L7e6utWSm0GS/O9i8Bi8MwhX9MIM+TgF7za9MOQUi+mvrk9hwGhze6C0eRfeeQvLYj/wOjSJlR0czIU+DGTE1OZTruaejV1PuT5LbPuNCJ6OqDzQmISmBq4yxN52z6z+LjMFNIvwoGd19+iSJjVZnmi4vpDvbzrBGfh1A5eL0IFnq6RE0OJcZmExEa0VJjgTEmGTytQ8fErPBo5bepmAXZ/HiCA7uoYhSx3y2AE0Wqp7y8zQyzH/6mMoPbFgcV7R+FY0YDVRxZ6PVkByLe7nmZTXz2ZX6hX4a4Wt9zEmE6uxxhNpIv8oeqcLfjYAJDK5fuYkBb3AlztNup5UDdf2Dzp6h/HAyk6aUEHtPnc5O37R7A7lWSdyW+pfP0LTpEtgxJz2g+39Rjx2byEvUZP24qhwNT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERsWmVqM1ZDQjQ1ZVFFOWR5U2x2Y3V1L0I2S0lkc3lzMU1wQVNQa1YzV1hL?=
 =?utf-8?B?czFYQTdLcXVaY2kxOXlMVmVGeWk3WVFwU1dGbHpucUZ3MGlVa1JpSXlQcDky?=
 =?utf-8?B?TmJZb3VodUtEUnJ0ZExmQlVKK2o5L3VNSmN4cUVNWmo4djgxSzExeXVUSzdx?=
 =?utf-8?B?aXhma2JHS20zc1dPaWdZN05pY242WTVhVFN0WG9OT2hUU0NJNnJGY3RXOWRq?=
 =?utf-8?B?enptWU9oeHVSdm9rY1FQM21MU280emE1b284VHNvZlBHQ2ZzRlJkZ3RscGV2?=
 =?utf-8?B?TmtoeEF4TW1MMERaUVQ0WWxWVGlodjR2QVZ3NTVndXpJUWNQejlMYmZSUmlJ?=
 =?utf-8?B?NjM0V0l2aDM1UCtjTUhnTGJkaDQ2MEFrUnQ1bVVXTzdKRG80QWl6ZmlaMW1i?=
 =?utf-8?B?YzhNRjB3cEFrd3BGazQvTW5EYTcvN0I5QlBLZklVQlBQdVV4M3U0aTJxc3Q0?=
 =?utf-8?B?N0cvbmxYZ1dhdTM5YWpEOW9tR3ZaYUxSNUlFL1dac0czWU5rZk95KytVNGtz?=
 =?utf-8?B?Tjg3cGlNZTNVdUZwdlhydFNBMmthZnRLRFVEQnVJU3J5SHl6N1N4R3AxUnhZ?=
 =?utf-8?B?eHFFL3Zra1J1N3pvbHpFVEJhcVYwcUpRNVNBZ1dvVWcxY1Uzd2UxQU5sTVJw?=
 =?utf-8?B?aXpUalpmKzUwRmJMc1ZPeHc0cDVqZElPOEdhQkUxLzBjNGJnNDNzb3FndzUz?=
 =?utf-8?B?VUk1V2Q2a3dSaHFSamtLWDY0NWhjQXptOGhHRVFSYkRlbk1yeVpaUWhwY1Vm?=
 =?utf-8?B?SVlmVVhKeC9sMHRMa1JOcUJ4QnpTQUxXZ1hNalVVbnBHTCsrb3k2dzdmS3hr?=
 =?utf-8?B?WFdDY1loUXVOcW43dzZoTHVoS2l6elc4WjR1YzhlSTN6cGVMN2pPRkoyT0xw?=
 =?utf-8?B?RU44bm03akxXN1ZVT0FHYWR5Mm9uMmpLem9MMWtvanFJSWh3OG9TaTUweHJO?=
 =?utf-8?B?aTVhWjF2djVGOTMvSzAwS2JSTjE5dU13QnBxVnVMbVJZM1NJR01KM0hqMWVN?=
 =?utf-8?B?bUxtZGhkamYxZnBZSllSL0xQeEp3aVV4M0tsV2plajgwR3M1T1BySFNzQzl2?=
 =?utf-8?B?Z0V2dk9ySldBV3FzWFp0aTlpUEV3elVsWGs2bk1lU1hvY1Z3ZTJjUE9aekR4?=
 =?utf-8?B?OGNlVEI5bDE4LzVYOFlPVDFzekYyWUJBVExINXJ4bmI4YlhUYlYwbXVHeW9t?=
 =?utf-8?B?VGNCNkUxSUdHT1lEVGpMMkxSRGJuS1JiYmdGREJoTVZJZ1JtV0QrbXI3andU?=
 =?utf-8?B?U25BbU9RNUREc2NreHVCc1JuSHlabGZGZmZMaDFYMHY2R0dkZHk1bGFDWDJy?=
 =?utf-8?B?QnNmSW1GY1ZacVV5NjlUL0ZKOEFZc2F0U282NjNMeUFodHBSMmpKSkdmdXFz?=
 =?utf-8?B?SDNiUk9kS3pIN09VTFNCS21GN2lTSFl3SzlYKzBCRGJGaXovOC9EMTJpN05x?=
 =?utf-8?B?K21BS2gxblRiZEhPendYMFJPVXdIam1LZURVS0F2N29WaWU4Mjl6V0Z6QnB0?=
 =?utf-8?B?MDlGbzVVdzRzUG10azRYcjJRSFE4WEhiTTh6VktmUTBBRUZVeW1XNnV0VkNw?=
 =?utf-8?B?QWF0N09lYXgzcE1IZGNZT3BjZm5TRWRIYWF0dUdEQThsTDV0d1RTMVNiSzBG?=
 =?utf-8?B?M2wrL01tZ0QwdHI5V3cvNHJleUdPTDVFR3d0MTkzVHBCdE01KzFxSTUzUW1C?=
 =?utf-8?B?b25tS0lyV3hmM2VtSWx0MzJFZ1FSYUt6MlV5SGFxbnpWckFqYUtzaDBhL05G?=
 =?utf-8?B?RDJqS0Q3S2ZqeUVEMTE0L1hXaENzV2swNmFwa08yb3dsT0ozOEF1bGtIckxs?=
 =?utf-8?B?V3ZUdGdCZ2N3U3VocmJUeXRmWXpUamN3c21vL1lXMWRrZzR3dkVYTFBzRGJK?=
 =?utf-8?B?OTNrS1Nrb1JFUWZpaGN0WkY4L1p3SDVaYVZlU2w0cmxpWXlCeUJ1K0ZEWFhz?=
 =?utf-8?B?M3R4OVZEV2xxUFllQmNyL1JoYnNEREMxajdHVTlIbEc1YmJXQWkxYm5qRnVp?=
 =?utf-8?B?Y0JFUml0emtpVjVxekd5T3pnS2NjS3dkeVptWTN3Y1J5eVRlNnlGdUMvNzNw?=
 =?utf-8?B?TENQelFuWERyYm01bFFxdmNkZXZpT3I5ck5PNDRxY2YzemZpOHg1TU5YS2lT?=
 =?utf-8?B?N2QwY092UWxXSHZ6NmxGYkd6WnBnMFh3NG0vMENNUUZzbGVVb0VGK1BjZkE3?=
 =?utf-8?B?MVRobzdadWZnTy9UamhLaGk3bVNkLzZ4VkRqSU1aaVdYTUFXZ1h3Tlk0NFpB?=
 =?utf-8?B?L29acmdoQmgrYW9mbkc3UEtzR29ZVVFEZk1SWGFkeC9MQXVrOW9tN3VWQW5F?=
 =?utf-8?Q?c03s4HiGmw6SLrAePR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802c4238-d853-401a-d9a9-08dec78fcb45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:02:33.9812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wUd6451kKhDYRD82t8v9J00Qb2K1zFSgLgUF5VYEHRPFLbC1hngJ3jJfKypWazF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
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

On 6/11/26 09:00, Prike Liang wrote:
> It fixes both the move overflow and the eviction fence add for
> evicting these per-vm BOs,
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cd0ae8a77c37..c1175cb6d242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -935,7 +935,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>  		spin_unlock(&vm->individual_lock);
>  
>  		bo = bo_va->base.bo;
> -		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> +		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
> +					   TTM_NUM_MOVE_FENCES + 1);
>  		if (unlikely(ret))
>  			return ret;
>  

