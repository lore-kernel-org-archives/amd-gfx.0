Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A33110EB8E;
	Mon, 24 Jan 2022 07:18:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4890010EB8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt9y69OCVUM76q9vrXQPdKYfUom81GovaAFAUH2XH0+5r/ySXvYKe5+3gOZJ7z+VIItReVQWYcQy7iyJvgiccWENZb6Tqjj7HNxBGyHYLCSlBL0/JTHb6IoIqQqPUroOlXdmoP3qggEJpnrCtfX0q3Sa41UsXx3uT+Js09nzxxyO3a4H1SeUDWbjRWoZo4IlG9w0kq5eBGQmkcwlmDkGmvPITw7nGmM+0xINLLdlD+tpqtTmYyQn/SevCLDi7FnKEkMLL4+AbiDJEeelTmxZzIPVvvSBti+v3rIsYHq8QY4bzfiss/CKFNypnCMhvMuLUgHeAN+4a2cBxdOmhNfHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZNjKqzASqg7FQ8H3BphTgH7sjTDL0GnALK+y4e0Kq4=;
 b=JbktlcaiJ7iZT/Wg/cQ+SKGZmmmfmsjnl7WrIrxO74HFUesfkvdNnmHWC72kKIURxo+q19wz3gesalzEFMeeKiAFysxixSuIp9LKQgJWSX2ycFY/SxTAaNI9pyeNb9O00SVE0cPocjsBNeaLVVUJQy3K3gnVokavVA6UXUtZu4cpXXxJN2WXL1JeiTRbuVbho41h7lDLgLLyzO2bP+ggVF1aM7G11jt9eRumElllin0bsMQsm/fcz4vjp/pFXOT/kumJKoSJenuoBCsSHJCk10Mv9g8T/0/AHmiue6qTKeaHEvdp0n/Rq2zMhCu1rOc1PFJTYh+Wm/q8dOz749pTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZNjKqzASqg7FQ8H3BphTgH7sjTDL0GnALK+y4e0Kq4=;
 b=jswuhysCHRMfOHiWTrfVK9v9TZXJLyBpWM56ENGorkVQK+ZeqjZZBAYPc+ZOCcOeuVh+lMEV1Yi69EKiukyuheLG8v8mJ+AMXjfCWZ411Sxgq5xBMNadxOm4mTZ1biuJPClXlzHQkMmFyhjcSK9I6v+mne3yi3Q/ohDt/rNo398=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 07:18:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:18:39 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <99e76deb-9f86-6158-9edf-5dd55c77a709@amd.com>
Date: Mon, 24 Jan 2022 08:18:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de244383-37f9-4c99-30b2-08d9df09be3e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0234:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02344027DBD62CD0CF78AA89835E9@DM5PR1201MB0234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EECZmnErI1/1rz5N8EkO5YgqaBF3fA8qWUTc9WvWoJHdKCWnuXEAMC2FCfV6fH42nesska4ycHvCC9NQ0OR+djv3JBhcE2HcGyNbodfQKSsUS8H/SC97xzQPJ3R84CdTFx0xZbiL587bQMAplsRzGQz/uKvpZEXqXA5p6ofPGdXX8YCr5j4LddjqAB4IKI9sAkhsQnajmrqJ8ifrdkfh6n/FL4eqwm7AUH41X2BfrGt1U3ORz84+D0S0yn3kH5Cck3hEXWqq3+R9SMTJnuXszMSGhft8CkeydmBTBsPIFJ/y7rjHuNpd0YhouZ8GOMTndIF3dFDa0mVKW8d+jt6dWn4hjEYIIZWB/BN/OY5IytCrsqo+ne0XIiNT0AEQC9WZWKbdcAExbpfbA/JkDvCUt22fNDUkdgk3/ozhXj2hrr9aMQKFTvJNMxzbq0xSethSytmsY91OSVrgbXBgF2c215IMAbw273fqX2bP2wiJQREO7yrfcblhRZQvws5HnPt8fVWqaDAjG0S+nKjZKaw9P5L3FZW+/LfB7+1YcOAOjvbbXNTBSUb7h/bJxRY95jh/oy2BRNhPb76xRca053v2/dhyuFn/y8nhE+t29rPU9pOt3rCr1Mjv0PfOV0dYsvsMdegX0X8FNpS84+9szRAPTgULJ+gQEkR/mzqayzrUnAlwWlszbNdwd79YD5SbT97dGTY5Ch9kq2AQoydzEOGZO4jOhx9MkLuco+5o3paTU2tNXbycKz0rELE0qsPHRfAh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(6512007)(36756003)(8936002)(86362001)(38100700002)(8676002)(186003)(26005)(110136005)(54906003)(2906002)(6506007)(5660300002)(2616005)(31686004)(6486002)(6666004)(83380400001)(66476007)(4326008)(31696002)(66556008)(66946007)(508600001)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTYxdFlJS0sxSE92QVhrcnVLV0xoRm9ZL3BzTnFvTkIvS1dnejFZcUlOQnBr?=
 =?utf-8?B?UWlBaHRBZWdoSWVWYjd2VDIwaEM1VGwzYzUvRGRFaEFzRHR0ZEEwTy9ML1hQ?=
 =?utf-8?B?TG1hcGg1SjYvSEl4YUNvUnN5NldUS2hhUFRjNEl0cUZCYmU4WkVnYWIwSWdD?=
 =?utf-8?B?QXUrS0FFaWhFTisxYVJQTlVSVlhRVlhFVjZOSWxQUXRpVDhYeTlSOUNIK2Vo?=
 =?utf-8?B?U1k0OUpKcUxVbTFQVXlQQ1YyOWl1WlA5cHV3djNLMm5wcmxKZ1VpQmlXNHJH?=
 =?utf-8?B?R3ZUeVpJaWhMZXBlMitjN1U5alZRbEg4TFk4SFFYWFdHZDdoMFpwYi92MldL?=
 =?utf-8?B?VnRQaUlLa1pWUXRrclIwblhoMFpLaDJ0YmtqLzc2MVd3NndScFljU3Iybzls?=
 =?utf-8?B?b25RSXN6YjcveFM4ek1SL0FkeXE2aGhVYU5XNzI0TkZhL3dVOC9zbkduMmFW?=
 =?utf-8?B?WkNUQ0pvdGZ6U2pGakoybC9LZEczZUhHSXhnc2xmRzRjMkovblpUQVJxU09v?=
 =?utf-8?B?TXY1b0dqSldvMHljN1dwRlJwN2gwL3QyZmltWGdvMHpabVpWa0hVUHhLdm0r?=
 =?utf-8?B?aVJsSjFpYUEzYTZxd29EN3hoUUIyWkVxaU1UUnQvNE9wZ2IwT0ZRRU9YWTBn?=
 =?utf-8?B?MitNUVlpNk9LSnhMQTZpZzMzTlRpVGhVcmhQNWFFUFZHOTlXTmMrbkZ2L05W?=
 =?utf-8?B?NG43MEtvNUw0RDB5bGMxa0NvQUJKVVF2K0JIUGhncEc2Mjh5NERRaHZIZTVZ?=
 =?utf-8?B?SXdWbkUralZwL3VwRU40dnErMTc4QmZNYmp0S2Fhb3ZnMisyaG5XOTlqQWFh?=
 =?utf-8?B?TVh2WkdicEdMeFN2aWNqZXJHNDdoR0lwVjRlRVZxcEdGWmF1TWJ5dzJEU0lp?=
 =?utf-8?B?WHFpMVd0TGZqN3lqeEpXM3BmK01kb0xVWjlNUkJ5M2pWVE1Uc3U4ZnRHU2VU?=
 =?utf-8?B?RVJCbVhkcXBOdkVZbEpiV2F6c2t0NGhNd3VQN3BuWWtPQUplSVd6OUs0ZjVG?=
 =?utf-8?B?RUpMcU1jM01IS0NCZGhXVE5LcXAzcWlNMnN0dnFFZU5mL2JMWDl5NVRkS3Rp?=
 =?utf-8?B?TFQzT1o4ZkxoWVc1MjhEaEhodm9Bd3BaYU9WRjhBVFhlZmNkZWxTUGd5ZGFP?=
 =?utf-8?B?WnNWNnBOcVlDVlFVTFFwZ05wVXkvMWhyZnl6L0ZaRkZheDk3UXljMXZaWTh5?=
 =?utf-8?B?dnlYanROZ0JzbVdTMjZpb1JhQnBDcTFRNDZhN1U5Z0hPQ20wOUN5UVJFTm40?=
 =?utf-8?B?Z0RqV1d5WlVYa1pZa0gvZ3g4djdIc3N6VmgvOWgyQVpiWVJCNjJLT3BLNUpV?=
 =?utf-8?B?T01RZXIvaS9JVFpTMDJHMnUvdnJxYzJXSzRtK01Wb3VoMW9DYnY4NHVSMXlp?=
 =?utf-8?B?aVRaN0JRUHRKRW1QT0drWkZPQUNHaGl0U0NuVFVmT2x2UEpRZzlYc1o4cUlj?=
 =?utf-8?B?MlNmaEJTY0piTHlrY3JMNFVOaEJIUXJ6R0VPUjl2SHJWUHg2c0NvZnY4VTlt?=
 =?utf-8?B?anhjYUc3c0pUOVlpYmdEdlpYbHR5Znl1OTA0Q3VIMnhBeTZuejA4OVlXZGFD?=
 =?utf-8?B?S0hiZklaV0RJcjdWbitQbFpXbGk4ZitnUDRoR2lLdzRUK20yMFhVWEtSMzdz?=
 =?utf-8?B?ZVhhaXk5MXlMcHEzTEpOUThqYUpBVmxBOUYvZjR6WkZpeGdCQ0E0SmVuWE43?=
 =?utf-8?B?VmlRcXJsZXkwajlYTDlpeWo3MjFxM29rb2lTQlZ1cnpqdXZkWVNldGZTcy84?=
 =?utf-8?B?MGNjajBvM0JsYXk2L0FWWFlCS1hTVU9pYnNOc2VGNm9TYlFxMEZjRVgzdStZ?=
 =?utf-8?B?Z2RzSlUzRXRhRkE0amlidy9KOUtUZWlCYkRUeStmV0Vtakt4blNNNkREWUJi?=
 =?utf-8?B?UjFMVDdQRmpySDlYd0VlZ3YvNXM1NGtlVFc4cXNXVXVZbU8wYkF6WkRURXhq?=
 =?utf-8?B?VEljUzN5aFc3dk9sUG93dnRwTGd2LzcwVG5WQWdBdThtSzlNUndzQXFEK3pi?=
 =?utf-8?B?c1JTZ0xOaUhlNmJwQjlrbXU2ZU9LNEtLWU9RNk1lOE1EYThJbGZEVEE0OTJ6?=
 =?utf-8?B?a1NscXJ1MDFwUHk5Nk1TaDRORUdVWnpWekNmWWtjS2JpaWZTM2YxN3pwTjVm?=
 =?utf-8?Q?/YPQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de244383-37f9-4c99-30b2-08d9df09be3e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:18:39.2050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLabdHdN51MYHlECuCfzertEBVLS+vdvrpKBau4woPQ8Xq/HXrpnH5xOTujrH8ql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0234
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
> From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Date: Fri, 21 Jan 2022 14:19:42 +0530
> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>
> This patch adds a GPU reset handler for Navi ASIC family, which
> typically dumps some of the registersand sends a trace event.
>
> V2: Accomodated call to work function to send uevent
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 01efda4398e5..ada35d4c5245 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>      }
>  }
>
> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
> +{
> +    int r = 0, i;

Please don't initialize variables if it isn't absolutely necessary.

> +
> +    /* original raven doesn't have full asic reset */
> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +        return;
> +    for (i = 0; i < adev->num_ip_blocks; i++) {
> +        if (!adev->ip_blocks[i].status.valid)
> +            continue;
> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
> +            continue;
> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
> +
> +        if (r)
> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
> + adev->ip_blocks[i].version->funcs->name, r);
> +    }
> +
> +    /* Schedule work to send uevent */
> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
> +        DRM_ERROR("failed to add GPU reset work\n");
> +
> +    dump_stack();
> +}
> +

I'm pretty sure that should be inside common code and not here.

In other words that is absolutely not ASIC specific at all.

Regards,
Christian.

>  static int nv_asic_reset(struct amdgpu_device *adev)
>  {
>      int ret = 0;
>
> +    amdgpu_reset_dumps(adev);
>      switch (nv_asic_reset_method(adev)) {
>      case AMD_RESET_METHOD_PCI:
>          dev_info(adev->dev, "PCI reset\n");

