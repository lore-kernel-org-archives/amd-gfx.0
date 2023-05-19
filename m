Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DE6C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 04:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6736710E5B9;
	Fri, 19 May 2023 04:24:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF9810E5B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 04:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG969NgY3YOml8EgKA4bvlgZ3d8+K2Z1SfjDXgFgI/8Cjk6HtvhIhxH+9Zl2vM/AFYuv+XEGWmxVfkCVJGfNVFys/K7KhORO+8lNfaxMrQeoQTbSNTw3CSswNFo6eyI8ByyGUYLpdUd7QtLBblZ3Q2F72uQdanOgdgf7ftdEE3fVOuFpEMTTtIJenO14tPjImnv2vUJJOaa6xxseXhgNramVjp+qpgMj/etJLYKK04ldd7GLS/hD35iiCW2xQMfEzaHpR6UvLWEJDluMKVTDy+Lq71jPhusJIj7RhRTsLqZKwAruCbghCFKlK9geFefKVGmpL9wzvdSXOosqhvyuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y9Y5srKq3VuuRjWb53jY7irfeAlvfkinSDdNNbKdUk=;
 b=dSR96VczeaqpjoUKpEcE4LjlpZChRtcQ/cgXOVSd15O3lYkqROzNpZLG2NnyYhqHuDkhojFx70HroSRfyDhb6btJeTxtpxevxKqSgCxpS9Gfflh7vOVWCZX4Z/6qS3EF065DgQiHtmEjWbHT5UMvNFDn1Xm5+aI39P80OIHUHtZVZDzvHI/49sdLqQ7I6A3gbgH+SUZHalGWnuCYoYy/lZGwJeI5bQ6s+jKkVjTUyld4RV9IeFDjxkEpiUURgcVqfZ4piOk5RnNwjSAY0Lz7Ob3pck5DMhX8B6CjCTKhjoZ3pS6hQTciy8f0OivmAtrvToQmpMZ1lSFEG2Nuxfnjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y9Y5srKq3VuuRjWb53jY7irfeAlvfkinSDdNNbKdUk=;
 b=fYPFv3NJAdhtA7o3+8xRZb1wWD9WDR38UhX4whaxJFwkctXNvY+1rot7FU4+6Ntl9lqtX85BoqUUmkOuLXehWMUFQeOv/TK1/uQDvbgadcfHG21uFPAs+VuckD69hSsDkxEGLQKQ3erF2bHYrayrKVHDdkGO6wIgn19g43ef/9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 04:24:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 04:24:53 +0000
Message-ID: <4c10cb13-de77-50c0-83c1-b31f6bb333be@amd.com>
Date: Thu, 18 May 2023 23:24:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230518165251.93229-1-mario.limonciello@amd.com>
 <BYAPR12MB26154082582165C41391BF9AE47C9@BYAPR12MB2615.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BYAPR12MB26154082582165C41391BF9AE47C9@BYAPR12MB2615.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:806:28::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfc5495-1ce2-4ce1-01b5-08db5820fe42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhQG17vOUCQIMSdmy/zx2nDVKB4n9EAEnz1ZZOh/Kuu69GLS9dZSMvclWV5irO4BcTFWMc3hQo0KgRAyF4ObQWy+QQUKK32StdpFXH/YqIM/hoPH/+zV24uc4WyU9ltRjpWcUcPUIwWmdqELgeJqD7EjDPVhuwVrNd0N8YVyozBBWtbRltVO4PC3POpjcbd+pHtXqqqDPbKhYgQZF59znDTqgZQDK9hKNAIYIUf5kEXZlRZZ1K9g11pIvit95jasRY1hFVL2cKrDMsW5Y8hcyckJQtNIpbdGYoydR4Pxwynqu7Ie7rLpy1JoMUUXQPF0Mlo+A9laJS6vm43WgwWQ1JSZvgShcnuwvMu8Pja1jA6SFu9BlSVrrAtoh+y+d8nUKZEitd2MvE4Som8YyrUjC0tIMIMoWj+kt3XU4k5W+xSKn1Ql8FumkOlYldugRYwyGxOzvpshHvXc6Y2yKsBI+zfvY9ttXpWwn14rcxvOmDpaCeKn/1Qq7EZSHs7jyOd9kjTg5V3egxh9TzPb30Za5tf8JfVnyhfKatyvzBcRVLLOPeSMHQPJ3//x4908tL6OOXy14BOh3WnY/JUpdf+sYkm00h+hXFh6Tae7jXbpZ8LsIQk0+IuINNyhclCMptloLICkcBSMPX2XmMyTK8mGbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(5660300002)(66476007)(478600001)(66556008)(66946007)(2906002)(31686004)(15650500001)(8676002)(8936002)(316002)(110136005)(54906003)(6486002)(41300700001)(4326008)(6666004)(44832011)(6512007)(53546011)(6506007)(186003)(36756003)(83380400001)(86362001)(31696002)(2616005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVTUG5qaE5iTW5QYkJIU2lGNXVPNmlMSzJYQ0lsRVpQSWtWZFAyMTB5NXlQ?=
 =?utf-8?B?TTF3ZngyUXdrQjFwekx4VndHSmFwc1BueVVhMkljM3dQLzJsVCt0enBMeXpC?=
 =?utf-8?B?anNUVnRMRXpYbU5ZR3dkd3hlMWN3K2xjZlYxMFAvS2hqRW1UU3lOdnZrUTdR?=
 =?utf-8?B?dVNqUU5tc3l5bmQwMFBFVkxaV1lTSmlvLy9tZDdQMUhLbG1GT0dWWmhsU2tU?=
 =?utf-8?B?QXEzbUxuVTIvUUkwRFFBN0huYkJaTGE5eGtQeHVJb1JXM0pRTzVUWVFBZGdS?=
 =?utf-8?B?NHhGKzh5bWVIQW90UStSODBQSHJUQ0IrVzN1YS9SL3g5U1Q2TXVyMUV3OGxP?=
 =?utf-8?B?WFowcUFTTy8wNCtPK0ZnVkRkeGs5TUlZYTk5YWNGZndMZE1lVjFyMTh0bFRV?=
 =?utf-8?B?S2YrbXQzMjhJV2Q1UDA1Z283VXYrZ25hdzBYYVRtREFZNWE0RWp0NjdoNjd5?=
 =?utf-8?B?TmFhaVNmMVREbE5ueE1XK0ZpNnQwQUZuQUpqOXc3Yjl1Z0R3QzBXa29HV1Br?=
 =?utf-8?B?dDgyUndObWIzMWFLVTdlUzZoU1VSODB2NHlvY1kzSmhLSkRWUUo5eVNyNWtZ?=
 =?utf-8?B?KzlNNUZrY1F2dWY4N1BxR2h5MDM3WElQMCs5VVZqMm1SZkNBT2pVeW9pa2pJ?=
 =?utf-8?B?dWlpaDZTd0pZdEs3RUo3RlNrTmRtYmFIamFvRk9KckVCbkJKbnM4aGdYV2dl?=
 =?utf-8?B?L0JMZWlxck9lRFZSeWxNUWRqSFh2T0RFeFRTMG9haHNjYWNyamFFcTNheTJL?=
 =?utf-8?B?a2RvNjJqU2dFM0dsck1EVFYwY2dvTDlpWnlBVHdlMDdaMmJkVkNubTVjVUd4?=
 =?utf-8?B?eXNpZzNxRmdQanpPNkYvaWxwenVrMFF5dTFCNHFCN2xQa3ZENjdjMUt6djg5?=
 =?utf-8?B?OWtRZktrQ3NIUmJVUmxIRitEOXczVkdhb2NrVGFsckFXNTZraHY5eHN6S0ht?=
 =?utf-8?B?OENaMVpKTDJSSnZwU3ZVbjNUVkR4Z3ZrdjE4WDIwSnFQNm93RUI0Tm9BOWth?=
 =?utf-8?B?MGhyY3pSN0RwUTlEUlRuNVQ1dGFZRG85dmVScVJEZzRZd2dLS1Jrbm1HbVFI?=
 =?utf-8?B?R3RXR1NXOFN0dkdKNXVYZ0VnOUw5Z2JMc21WN3ZuLzVuSlhvRmNZbDQwU3ZO?=
 =?utf-8?B?RlN2WWNtWFlNeXVIYmFIb0Z6Qi9kaG5BREc1Zkhwd01vMXFGUllpRU5mVGVU?=
 =?utf-8?B?WmhpcURwOGRRcjkyclRuemhESExKNjMrSmc5VUczQlBzZU4vMkVQcTdRaUdz?=
 =?utf-8?B?bjdOZjlxakYxUFJxL1lPN0w3ZFI1RUYzOHR4OGU3UmhtWHhmNjFqdjUya3Jo?=
 =?utf-8?B?SlU3dFRkb0xkMkt6cTA5clRpODFDVitHdWE0L1pTSjRsMVl5alMvSEtFbzJK?=
 =?utf-8?B?MXVoeGwreUdOWEZ3RDllaVRLRWtCOXhtREkrcmpUa3pBemdBSkUyR2VGelF3?=
 =?utf-8?B?bUcva0JwN0JsUHNHZURESTNNQk5hWHd4RXh2ZGRCNnZBaXdDSGFVQjR1NUpC?=
 =?utf-8?B?MmlBa2lDanNFWmZQSHgrUkpsYUZUSS9PcmthVjFqZXRWUGtKVm95VGNvOFpE?=
 =?utf-8?B?dFFZbndPV2RGRlZoUUdQZ3hNS0crNnhZL1FXZlFrL3BlTkkvaEVMa0ltUjMw?=
 =?utf-8?B?K0diK3FSMlptMUJjMHVBWlFNdFFLNm1OM2d6YXMrZmJ5Z09rTE5TY3UzOG81?=
 =?utf-8?B?Y1RuTzVFNm92OWwvQVhVUGtqQmNYMEE3LzFJcUlSOGVjZFZLcjJlbkIyWnpj?=
 =?utf-8?B?b2ZodG45NWRWRHNnQ2ZkTjYyQlFxOWtESHA2RE1sQVI1eHJ3a3ZKcEhEOUxC?=
 =?utf-8?B?QU1iSjJrYmlTYzl6dkUyTGVqZWtrR1l5RDhRaThRMm1GWm5MODNYRzhzQjRm?=
 =?utf-8?B?OUpKNzFYd0Fla1Y4ZTBET2tPRkFzcjdnMzJRYVVobmJJMGlrNlI0RllwT3kx?=
 =?utf-8?B?Y254WFJjTkNtVTBFT0d5SFNNMHNIb3VRM1BSa0wwaUNXbTA0NUxrU3RjRXlY?=
 =?utf-8?B?a3o3UXljQkJZMWZnSHk0eVFCWkNXdzJmaGpsYVh0YUNuQmJ3K28yY2p4dmdt?=
 =?utf-8?B?WkhTODNUL2RXelJHK0ZJNzM2VHZOT0NyU1Z5UHJjZ0tTZHVpcDNqMEF1T3pv?=
 =?utf-8?B?SGdFWm5HUTRvTlNsMU5yQ0NsMjF1TGlmVGk3RUdJdnY0ejhvTDFaWVJjN1pM?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfc5495-1ce2-4ce1-01b5-08db5820fe42
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 04:24:53.2509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXwMcmCEwM+J5rCy0WGdakNkkcE6+LLJ1K2icJ9bn79gsrvn1qJxDqMIAteIiNS/SOhH5vofOfA3dLejileX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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
Cc: "Tsao, Anson" <anson.tsao@amd.com>, "Martinez,
 Juan" <Juan.Martinez@amd.com>, "Gong, Richard" <Richard.Gong@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah; that seems like a reasonable way to accomplish the same result.
I'll experiment with this.

On 5/18/23 22:33, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> If I understand correctly, similar job is already performed in "amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);"
> Maybe you just need to undo the "skip PG for GFX on S0ix"?
> 
>                  /* skip PG for GFX, SDMA on S0ix */
>                  if (adev->in_s0ix &&
>                      (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
>                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
>                          continue;
> 
> Evan
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Friday, May 19, 2023 12:53 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Tsao, Anson <anson.tsao@amd.com>; Huang, Tim
>> <Tim.Huang@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>;
>> Limonciello, Mario <Mario.Limonciello@amd.com>; Gong, Richard
>> <Richard.Gong@amd.com>
>> Subject: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
>>
>> DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
>> is happening during entry.  This is because GFXOFF was scheduled as
>> delayed but RLC gets disabled in s2idle entry sequence which will
>> hang GFX IP if not already in GFXOFF.
>>
>> To help this problem, flush any delayed work for GFXOFF early in
>> s2idle entry sequence to ensure that it's off when RLC is changed.
>>
>> commit 3964b0c2e843 ("drm/amdgpu: complete gfxoff allow signal during
>> suspend without delay") modified power gating flow so that if called
>> in s0ix that it ensured that GFXOFF wasn't put in work queue but
>> instead processed immediately.
>>
>> This is dead code due to commit 5d70a549d00d ("drm/amdgpu: skip
>> CG/PG for gfx during S0ix") because GFXOFF will now not be explicitly
>> called as part of the suspend entry code.  Remove that dead code.
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Suggested-by: Tim Huang <tim.huang@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3->v4:
>>   * Drop patches 2-4
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 +--------
>>   2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a9d9bbe8586b..059139f1f973 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool fbcon)
>>                drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
>>> fb_helper, true);
>>
>>        cancel_delayed_work_sync(&adev->delayed_init_work);
>> +     flush_delayed_work(&adev->gfx.gfx_off_delay_work);
>>
>>        amdgpu_ras_suspend(adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index f2d0b1d55d77..b1190eb0e9c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -692,15 +692,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device
>> *adev, bool enable)
>>
>>                if (adev->gfx.gfx_off_req_count == 0 &&
>>                    !adev->gfx.gfx_off_state) {
>> -                     /* If going to s2idle, no need to wait */
>> -                     if (adev->in_s0ix) {
>> -                             if
>> (!amdgpu_dpm_set_powergating_by_smu(adev,
>> -                                             AMD_IP_BLOCK_TYPE_GFX,
>> true))
>> -                                     adev->gfx.gfx_off_state = true;
>> -                     } else {
>> -                             schedule_delayed_work(&adev-
>>> gfx.gfx_off_delay_work,
>> +                     schedule_delayed_work(&adev-
>>> gfx.gfx_off_delay_work,
>>                                              delay);
>> -                     }
>>                }
>>        } else {
>>                if (adev->gfx.gfx_off_req_count == 0) {
>> --
>> 2.34.1
> 

