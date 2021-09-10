Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CBEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 10:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EE061026
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 10:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0EE061026
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686906E9B0;
	Fri, 10 Sep 2021 10:03:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2686E9B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 10:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYL6ORnRfZjPlCQM4PXLiqeet7zfhOM3JmYy/1h3x8ltnAkPrJRPsGDtN9oLuG0DUBwISQT6F69EjwhPKNqAQ3Z5TQLxQs3/d67oUNKM4phBPxlCxYbgmopcsZHV81IEHcKVNJxCHKcwOOVNNg9eZmtqZLpJPWVZaspTzJZZzmxjoJs3qtCxwG7aRIwJdvaCIVpM3470xmUNGrEkh+PUPchLJ38zUW7GdpoT/zHafpIn+4r9cmoWIlIOrLbmFvj8ng9qjj0RZPTNohMcQG7vx3ci/uJ8Z4DQScW5c+WM9lmhEc+8lv3+zKGnIBKy6N3yUY/jNzBy5RB9AjJb/ty6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WA075rcIJr1OkBjVSTZNymforOMQyCijbqecNmw8ovA=;
 b=RUEUw3Q9pJPVPl59oBEDJ7GbEzsqWhb9AtMH9dV6bvc0RkeI9HgN1H7OcNa3Yvz5Bcpp137b5f7g+oarMgS0+0gc8w9t9faiFkxiydMoWM8lNwLHSx9JsRmvy4zfBummcrvfBjvaJ3pW1SjVZAW1gBgVujH8ngX2GJsm06ZUN3jflwLcW5YJ7YEe1hAj94odeQepnWWKCdJTWEPkeeRgk+48c5DuPBiPHPmgbyiTi+PKEs1SAOw9zAKEjxUB8LS7usr+dwPqfko8RLMJ4oQCTK98Ycf/orgNMTzn/gssdhbtb+Vh8ilDgWCkMGpe7eyTYnTp1vGPQRWKOpWH1o1aJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA075rcIJr1OkBjVSTZNymforOMQyCijbqecNmw8ovA=;
 b=JfX0WLRQJsTpvmM09Q/UMUq/aOgY8zpv2L6FAQka2ev5Bi8NR9pvhf4Aza2AG3jJgI1tX7OkMDj7DHoWq3DVujzegWWlPb1iXYy/DxR5baJMzMYb1kixPM3oMy+tTLlGAqyqBMdEhylOe1X3LLbs66UTZgvzJQCkFfyceKCvQ44=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 10:03:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 10:03:01 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggMi80XSBkcm0vYW1kZ3B1?=
 =?UTF-8?Q?=3a_UVD_avoid_memory_allocation_during_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-2-xinhui.pan@amd.com>
 <005bbb06-034d-6cdf-7c61-1d0339b2e54d@amd.com>
 <DM4PR12MB5165533F0F3EB7FE1F14CD6D87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
 <9393c355-0d63-d4f5-1ecb-1ec9fa392a85@amd.com>
 <DM4PR12MB516591BAA84BA6798E40601E87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <56bbddc3-2971-4f82-fce4-24cd773a8efc@amd.com>
Date: Fri, 10 Sep 2021 12:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB516591BAA84BA6798E40601E87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::7) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 PR3P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 10:03:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f5f8a2-45c9-429e-d185-08d974422ca0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42050061B25A18D792EBFE0B83D69@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcwIOCo9sj6xRUvH+ot9zXhIjCjJpdakPHdJROz/kkqUu476pxED7CIz4kvyxYuJidXdQafiQsvPiC2lINafsgqZs55ccYtevKa2zGhN/LFWIpq2jnNGIngVMwtmvC5YP7DsmDGTfua8GElmLaLDv19N6sAtkJgdUxYxgh/50IUEFwiwjIcE9dyesQXkA1+4f/51G0/Bek4VzAIyS89+egYxBdNJGevEoi0tfo1QyDFADwjUabRG4jxa/D9XgqgdLJqdn2IS3QMfsMKptcTaW1b4w5dtyYUAgnXbGYHwx2g4jq8NpDTaQMQbgCwJXC9xKWatwpfSbFrLVlR6T5vl2f1yFLFEfVs0Mri515Hi+DGxDB/fVeSNPObtJVhdOFt/ajtpq8MjJTH9ivPvBAmc6FdmhH6oORl3cNOVbm0WVTjqNy7yDttNCrABn9SMX5KRE9qRMYtmZu56h6t61bYGFpkpKaEuzDkKWuRV6NHYN2fTzhlCBQeYqkH8gdTXzdnXaMmrOGrO6g7yHuLyzN0Pobb2CBhgPZyEImmfjtg8dZ6r5InrGS6/Y+BpXgOBN3Y3ohSSMlJ3XuzZ9FoDrtdNXYrjB2bz9ISuWc/7MqfqPBKoI2unlc8QxiAfDoUkxYFuhqpj/mninjtItk+ahdYcB2NXOtUFB67D7pGLV8a2XP5pE8gXDjZwctiwsWLSx6DqLcv063NG+dvFQG2Fo3UWYjQWcBxHlMNRLwopodvQJBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(2616005)(186003)(31696002)(86362001)(2906002)(478600001)(956004)(4326008)(110136005)(8936002)(83380400001)(5660300002)(6486002)(16576012)(224303003)(66946007)(31686004)(38100700002)(30864003)(36756003)(6666004)(66556008)(26005)(66476007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?SERzM0FoS1ltUHl5TkVtdmxHT3ZYc0tNK1h5bDdlWlpnSUpGS0ZrMUxldjJy?=
 =?gb2312?B?RXl4eVlBY3k3YlR3dE15YTJDa244NHRKbTlaWXFFZnpicXNlSUJkNGxZRjlt?=
 =?gb2312?B?dWtpZTNKRmNFLzNzOUNqaVJ3em9OWmFsWFNLOUs1UzFOQzRlOGg1a3Fyd0FC?=
 =?gb2312?B?VkFLZk1sRXlnRGw5dnlENzZDdFVhS3JyeXIzbjhmc3dJVjZ1S2lXaW92Nm1a?=
 =?gb2312?B?NWtyNG5zVGJXNmxxa21kRy9SZHhkSm8xdFpGelNZL0hMZ283TFJSZ3BuaDJZ?=
 =?gb2312?B?QmdWWDdVYnd3bjFicGRYcFZ6Um1ST09idkNvZjlWVU0zdkFaYUsyMHhjQXJW?=
 =?gb2312?B?WERPVE9JSUZVNmZhbWZYWEdQOGdSMk1KbDVZNzBUOHRJR1oxQnhXbCtndzl4?=
 =?gb2312?B?RVMyUmNGdm85VkZmRXd1Y3FMS1JhZHdyMGNBUzMvNUJnVzRwRU1acmMwdkZk?=
 =?gb2312?B?blpiR3pxNTZOeFhMUE5IZUlGOWtwb244aTlpbWVQVEpyTGZ4VjNwMjlPRXV1?=
 =?gb2312?B?WWdJdzd3YUlqL0dNTVZBVHFqREkrZUlxKytQNnlXRWdUTVl4K0x4LzBocW00?=
 =?gb2312?B?SjFSWDE2eXhCaUF2V2laek9mWnBCUzl5VE1OdXpZdGFNazV3NDdReEcvUGow?=
 =?gb2312?B?d1dTWExDMlc1YlF3RkFlY2FoYlY1Y2xwb1NLSUxnSmduQnlSdFFCYmdoa01I?=
 =?gb2312?B?SzYzZys3S2dpdlBMZlZYeGF6NkJWMmNNQmtHeFVzbXJaRXVSMkQxelQyT0l0?=
 =?gb2312?B?STEzVzFlSFFWU2tKYjZPbUVTMDNKanRMRDlKSlErMkdqTWZHOWNYWjhNcjJE?=
 =?gb2312?B?eVJHa0VrcWZ0dVoxbG5vNmR1VGhOM1J4eTlNWGgwTU4za0ZNaUhHRGd1NnNh?=
 =?gb2312?B?Ujh1WWFJcU1OcGsyV1NvVFJlaWYzVGRPRXNiV3JveTlTZ2JvTVR5K09LaTB6?=
 =?gb2312?B?eGx0ZDJRZ01KakJtWXNBT1JuV2dsbm5NeFpqcURmbmt4TEg1WDZvdUtRNWgr?=
 =?gb2312?B?ajBJU1Zsa0VDSlJ3ZDI0NEh4N3krMnlyLyt2ZUlDbnlha1A5b2NiTC9DMmRF?=
 =?gb2312?B?d3NJRnByQjJlNnJwTEFkTExPZXpscFFnbjdBK1N1K3Y4VklmZGdBdm5TRDVz?=
 =?gb2312?B?Sk9XZjU4SjdIQis4aFVhU0Z1N3hnWmtBQUhCT1VTTGxRSVN5aXV6L24veEJF?=
 =?gb2312?B?OHcxSHU1MUc5K2hNUnVWRGovaUwzSXZBRVRBLzViUjYweUZGYWU5MFRvbGpG?=
 =?gb2312?B?RGFoNm55emsvL3Ztek5uaUdGUHdZeUh5azZNQWY3NE5OUkNBZG1POTlwSTdp?=
 =?gb2312?B?dXhpU0hDZlF6NGl2Y3lwcVFmUFJXeUMyaVBSeTZiZ3k5czdxYUVhbml6Nmpu?=
 =?gb2312?B?NCt3ZTJzYllFQStQZDRiMjdFa3FubmdaSGwralY4YmFkcVBaRzdNR1lmT2sz?=
 =?gb2312?B?WG13VmgvQTR5OCtRK1Q5WDRjaExOdlN3VjQrY1Q3MGdKN3NZWU5qY2VwNDds?=
 =?gb2312?B?TUdqMFh2ZnQzYldrM1dLVjk2TFNoSHBWYnArZ0JQbmxPRTJZWmNlUjdBYytm?=
 =?gb2312?B?Z1JlREZOdXgvcjA1ankvb3BubEoxdkIwdVR5cnhjakZIQ2huMDNMWkp5THpI?=
 =?gb2312?B?UDhTbEgzNkJJQytLN2hwMWlucVlVQ1NHcTlWdnoxZUxjZ3h2a3BVZ01YMU5t?=
 =?gb2312?B?bjA2QVJ0ZVRZekdnbTNRWjFOVzlTeE1FYm9iMVFuYjNjdG5NMmN6OUllMzY5?=
 =?gb2312?Q?nRHbXVHz5BA4cu/xoSCH/MXscN5QjNm2Dh2cglD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f5f8a2-45c9-429e-d185-08d974422ca0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 10:03:01.7235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U7w0llYlNQrHQfQ66T1rph8BptfdyFBd+23QwbuOaDwYMOo2GbCgFd45DipGp6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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

*sigh* yeah, you are probably right. Wouldn't be to simple if this would 
be easy, doesn't it?

In this case you can also skip taking the reservation lock for the 
pre-allocated BO, since there should absolutely be only one user at a time.

Christian.

Am 10.09.21 um 11:42 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> oh, god. uvd free handler submit delayed msg which depends on scheduler with reservation lock hold.
> This is not allowed as commit c8e42d57859d "drm/amdgpu: implement more ib pools (v2)" says
> Any jobs which schedule IBs without dependence on gpu scheduler should use DIRECT pool.
>
> Looks like we should only use reserved BO for direct IB submission.
> As for delayed IB submission, we could alloc a new one dynamicly.
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月10日 16:53
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: 回复: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>
> It should not unless we are OOM which should not happen during driver
> initialization.
>
> But there is another problem I'm thinking about: Do we still use UVD IB
> submissions to forcefully tear down UVD sessions when a process crashes?
>
> If yes that stuff could easily deadlock with an IB test executed during
> GPU reset.
>
> Christian.
>
> Am 10.09.21 um 10:18 schrieb Pan, Xinhui:
>> [AMD Official Use Only]
>>
>> I am wondering if amdgpu_bo_pin would change BO's placement in the futrue.
>> For now, the new placement is calculated by new = old ∩ new.
>>
>> ________________________________________
>> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
>> 发送时间: 2021年9月10日 14:24
>> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
>> 抄送: Deucher, Alexander
>> 主题: Re: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>>
>> Am 10.09.21 um 02:38 schrieb xinhui pan:
>>> move BO allocation in sw_init.
>>>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 75 +++++++++++++++----------
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>>>     drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 +--
>>>     drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 +--
>>>     4 files changed, 49 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> index d451c359606a..e2eaac941d37 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> @@ -141,6 +141,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>         const char *fw_name;
>>>         const struct common_firmware_header *hdr;
>>>         unsigned family_id;
>>> +     struct amdgpu_bo *bo = NULL;
>>> +     void *addr;
>>>         int i, j, r;
>>>
>>>         INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
>>> @@ -298,9 +300,34 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>                 adev->uvd.filp[i] = NULL;
>>>         }
>>>
>>> +     r = amdgpu_bo_create_reserved(adev, 128 << 10, PAGE_SIZE,
>>> +                     AMDGPU_GEM_DOMAIN_GTT,
>>> +                     &bo, NULL, &addr);
>>> +     if (r)
>>> +             return r;
>>> +
>>>         /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>>> -     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>> +     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>>>                 adev->uvd.address_64_bit = true;
>>> +             amdgpu_bo_kunmap(bo);
>>> +             amdgpu_bo_unpin(bo);
>>> +             r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
>>> +                             0, 256 << 20);
>> Please keep using amdgpu_uvd_force_into_uvd_segment() and validate here,
>> cause I want to remove amdgpu_bo_pin_restricted() sooner or later.
>>
>>> +             if (r) {
>>> +                     amdgpu_bo_unreserve(bo);
>>> +                     amdgpu_bo_unref(&bo);
>>> +                     return r;
>>> +             }
>>> +             r = amdgpu_bo_kmap(bo, &addr);
>>> +             if (r) {
>>> +                     amdgpu_bo_unpin(bo);
>>> +                     amdgpu_bo_unreserve(bo);
>>> +                     amdgpu_bo_unref(&bo);
>>> +                     return r;
>>> +             }
>>> +     }
>>> +     adev->uvd.ib_bo = bo;
>>> +     amdgpu_bo_unreserve(bo);
>>>
>>>         switch (adev->asic_type) {
>>>         case CHIP_TONGA:
>>> @@ -342,6 +369,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>>                 for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>>>                         amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>>>         }
>>> +     amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
>>>         release_firmware(adev->uvd.fw);
>>>
>>>         return 0;
>>> @@ -1080,23 +1108,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>         unsigned offset_idx = 0;
>>>         unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>>>
>>> -     amdgpu_bo_kunmap(bo);
>>> -     amdgpu_bo_unpin(bo);
>>> -
>>> -     if (!ring->adev->uvd.address_64_bit) {
>>> -             struct ttm_operation_ctx ctx = { true, false };
>>> -
>>> -             amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>> -             amdgpu_uvd_force_into_uvd_segment(bo);
>>> -             r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>> -             if (r)
>>> -                     goto err;
>>> -     }
>>> -
>>>         r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>>>                                      AMDGPU_IB_POOL_DELAYED, &job);
>>>         if (r)
>>> -             goto err;
>>> +             return r;
>>>
>>>         if (adev->asic_type >= CHIP_VEGA10) {
>>>                 offset_idx = 1 + ring->me;
>>> @@ -1148,8 +1163,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>         }
>>>
>>>         amdgpu_bo_fence(bo, f, false);
>>> -     amdgpu_bo_unreserve(bo);
>>> -     amdgpu_bo_unref(&bo);
>>>
>>>         if (fence)
>>>                 *fence = dma_fence_get(f);
>>> @@ -1159,10 +1172,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>
>>>     err_free:
>>>         amdgpu_job_free(job);
>>> -
>>> -err:
>>> -     amdgpu_bo_unreserve(bo);
>>> -     amdgpu_bo_unref(&bo);
>>>         return r;
>>>     }
>>>
>>> @@ -1173,16 +1182,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>                               struct dma_fence **fence)
>>>     {
>>>         struct amdgpu_device *adev = ring->adev;
>>> -     struct amdgpu_bo *bo = NULL;
>>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>>         uint32_t *msg;
>>>         int r, i;
>>>
>>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>>> -                                   &bo, NULL, (void **)&msg);
>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>         if (r)
>>>                 return r;
>>>
>>> +     msg = amdgpu_bo_kptr(bo);
>>>         /* stitch together an UVD create msg */
>>>         msg[0] = cpu_to_le32(0x00000de4);
>>>         msg[1] = cpu_to_le32(0x00000000);
>>> @@ -1198,23 +1206,25 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>         for (i = 11; i < 1024; ++i)
>>>                 msg[i] = cpu_to_le32(0x0);
>>>
>>> -     return amdgpu_uvd_send_msg(ring, bo, true, fence);
>>> +     r = amdgpu_uvd_send_msg(ring, bo, true, fence);
>>> +
>>> +     amdgpu_bo_unreserve(bo);
>>> +     return r;
>>>     }
>>>
>>>     int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>                                bool direct, struct dma_fence **fence)
>>>     {
>>>         struct amdgpu_device *adev = ring->adev;
>>> -     struct amdgpu_bo *bo = NULL;
>>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>>         uint32_t *msg;
>>>         int r, i;
>>>
>>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>>> -                                   &bo, NULL, (void **)&msg);
>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>> Please use amdgpu_bo_reserve() here and elsewhere as well just to be on
>> the clean side.
>>
>> Lockdep will sooner or later complain that we reserve a BO in the reset
>> path, but that is mostly a theoretical problem and existed before. So
>> I'm fine with sticking with that for now cause the problem was there
>> before as well.
>>
>> It's just that trylock might not work because the BO is busy with
>> indirect submission.
>>
>> Apart from those two minor issues the patch looks good to me.
>>
>> Thanks,
>> Christian.
>>
>>>         if (r)
>>>                 return r;
>>>
>>> +     msg = amdgpu_bo_kptr(bo);
>>>         /* stitch together an UVD destroy msg */
>>>         msg[0] = cpu_to_le32(0x00000de4);
>>>         msg[1] = cpu_to_le32(0x00000002);
>>> @@ -1223,7 +1233,10 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>         for (i = 4; i < 1024; ++i)
>>>                 msg[i] = cpu_to_le32(0x0);
>>>
>>> -     return amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>> +     r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>> +
>>> +     amdgpu_bo_unreserve(bo);
>>> +     return r;
>>>     }
>>>
>>>     static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>> index edbb8194ee81..76ac9699885d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>>>         /* store image width to adjust nb memory state */
>>>         unsigned                decode_image_width;
>>>         uint32_t                keyselect;
>>> +     struct amdgpu_bo        *ib_bo;
>>>     };
>>>
>>>     int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> index bc571833632e..301c0cea7164 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>>>     static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>     {
>>>         struct dma_fence *fence = NULL;
>>> -     struct amdgpu_bo *bo = NULL;
>>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>>         long r;
>>>
>>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>>> -                                   &bo, NULL, NULL);
>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>         if (r)
>>>                 return r;
>>>
>>> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>
>>>     error:
>>>         dma_fence_put(fence);
>>> -     amdgpu_bo_unpin(bo);
>>>         amdgpu_bo_unreserve(bo);
>>> -     amdgpu_bo_unref(&bo);
>>>         return r;
>>>     }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> index b6e82d75561f..efa270288029 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>>>     static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>     {
>>>         struct dma_fence *fence = NULL;
>>> -     struct amdgpu_bo *bo = NULL;
>>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>>         long r;
>>>
>>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>>> -                                   &bo, NULL, NULL);
>>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>>         if (r)
>>>                 return r;
>>>
>>> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>>
>>>     error:
>>>         dma_fence_put(fence);
>>> -     amdgpu_bo_unpin(bo);
>>>         amdgpu_bo_unreserve(bo);
>>> -     amdgpu_bo_unref(&bo);
>>>         return r;
>>>     }
>>>

