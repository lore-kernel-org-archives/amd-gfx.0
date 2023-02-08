Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEB7C05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 16:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123EF10E049;
	Wed,  8 Feb 2023 16:12:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBDFA10E049
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 16:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMS8F+CPnGGPqAagUViGbJYoF8R2golWILGg4KqyjQ4APDSmGszVfs6BYsi9oJluEUbPMQuCF3lmI3ebldu06bWSnG3AmyGzrwc79oNTqhCe5/CdeOa/oAADdOlyV7kvrscKUipGxEdM0OEP0u7gl47s44bLcTwXHADHFaFt7QLCP2CDCAn/Spp07hvNtdQULp7IIW7MgYuAkGtFgpd0Ittajc/4e3UCm/x2p8xJPQg/NdoqSsFDqLxvJ/8Ktbs3eMEuUFm8LAYJWRB4Rs4kkIeOHWuxaN7g9DIzLApdm6JezLMVSrTjM4UEydoj/rtBXVtzaOv2Bl8RaaN2UJFMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCUB4fhJ8OjXHOGNYGThyE3LXM5j3xerlNaFcutVF5Q=;
 b=i8f1Bv8oS7cjF5cRm4SF3YGPXSvGGPp8u9SFjO5LY/7BaVYto53+99zjm/bQcmnrLUE3kK/8A7tPEPZ6vvd7tZwAHW/Rx+xTwoJC3Lfy8aUJNK/Zihk8WCtoCF2li55XQeBmBboXNTzAdfrws+J+euwxD1GpEuVnSRlYnmXfD2YA5rSgiFqxxMxS65Gr7soRieNZg6yokC2vUEg5X+6gwzkjHnaCfAWjPaMD70UgRXZlv9vADZGeQAxWex4MNgoYV3ycVqPvgP6Fs+jy3NDCXDLH86U0zXwmCuQFhp4gbwxIwTp5V81iI9J94eQQqVL7zpCY+4EvW1o57VKvqzRtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCUB4fhJ8OjXHOGNYGThyE3LXM5j3xerlNaFcutVF5Q=;
 b=3lVtKCXJNhXb3zCsPb2I46IDtnIluZ7eIoRhhYX5uwSgod8Z5+HNSMdqHs4k81i9sGa+zV7fZlpAlC0kW8CdwQzMj/+as8qYXNWnthzsJSDF+VShfOaqz+x7vmCcL9VnXp23TCbGAwoQVbQNi3X28Ax3z+eaGQRxgngB/qiTxUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 16:12:08 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a%9]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 16:12:08 +0000
Message-ID: <c066b906-eef1-8b36-29f6-1adb013ea0e6@amd.com>
Date: Wed, 8 Feb 2023 11:12:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amd/display: fix dm irq error message in gpu recover
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Tianci Yin <tianci.yin@amd.com>
References: <20230208072539.4150546-1-tianci.yin@amd.com>
 <CADnq5_OERUOt8okNf+=UjL+zAMWzwsFaWaaZTbGaarSH0mv74Q@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_OERUOt8okNf+=UjL+zAMWzwsFaWaaZTbGaarSH0mv74Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0364.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbab21f-0b18-4fc9-4d29-08db09ef3a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mLYiBh7vKzYfPX6C0NyXmu9fukeRwHcZW00OLbxM0rabXx+5yL5Zi6r4bXNdwyM4BBio4RxUGn5FIiVsv83NsXyPBa/sBm7rE130WuJeqca6GHinIZATG0Z4N5GKC/eWNG2oKAq8oA88NgNqy4GLT3IvSXRpH0N1z93iBFBUhH9UqvPspp7IFqOvp3zkznK/ff8vzlylCdrYts+aZEIBhoMqz86atqdAReyh3dLkBrQ+RqC/IrB3gGdCpBkIRb4Wkkbyoim/VFq/2i6b3jKDdNAyeHvsVFhAx1lfnaXm0MOEOs+swOffUgN+0ZTgycHRZeY3scm29bT9NVYjGy//vL452SgvHIKdNgW18RYUUs86zsghGF+0imL85z7JSKamLV4Pu3X0Dw0xvWoyt1m/KIclQ30Udgcb0OEFQdtR6SJiIRYt0xz29OkQ4tTRgjXd70ER6kIlx8HieJDlUquMfPxfqRHnblnuquZqBpSsmoxYuroefSIq6FMBsE8a/kL4NvSxAJOpvyUbK9Zbn1LZh4i7EkTsI3Gvn3PwvDqT36SjTpQ+tDV+ZKHFJLt479FhNJ36/B816AtUyazEpySjRKrjmo2V/EmF5AltpNgZDpt0cofcTmJQtc+PrprIBGipHEIk5jGAu/T+DtWjcbEzlJQEKXmawO3tDKFYY9kfqT54O+CIzR3dr1t4dl0L1+oLTRuggTaNhQxt+z/MsHS5CgKsFUe4Zw3Jts+AGYq7Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(2906002)(31696002)(15650500001)(5660300002)(44832011)(38100700002)(31686004)(6666004)(478600001)(36756003)(6486002)(2616005)(86362001)(6506007)(53546011)(26005)(6512007)(8676002)(66476007)(66556008)(66946007)(186003)(8936002)(41300700001)(4326008)(83380400001)(6636002)(54906003)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndzdG5Qd2h1UWRqZDhGaGtQSDMxWnVabytBYzRBNDlaaFFaeDljZGxBQTZH?=
 =?utf-8?B?bDZWQi85SXovVzdrYVJrcU1kdlZ1NkRlakhIUElvUXZGQXBwU2xxS1FPUm5I?=
 =?utf-8?B?TDJnalBTUHl2cWZ1eVU1UmxiOXBqU1g2WkFkOXpnQ0ZFdEQvNmxaczBNa25i?=
 =?utf-8?B?cm1ISzFVMFpDOGh2WjY1ZTM0UmtoUnYxdHFtaXFEV1kzdTQ2VlN3cTdaelpm?=
 =?utf-8?B?cXNSYnJhMTB1cWMwUzdRaFR0eWpJUjFVVkV3L3FWOWxITEhLMktXSjN3UzJa?=
 =?utf-8?B?RCsvNHBzR21xd29JM3dJSmViR2RXS0R0NGdidW5zLzdQRWFFRGp2cTh6cTdr?=
 =?utf-8?B?TktOLzZWTlB2L0dPL3B2cGdvbDBYVFg4Y052OHh5b0NNQm9tZkNiK0FDSFNE?=
 =?utf-8?B?M0dtN2pvTmhJUGZqeEU4VDBvdUxwcTZLTzVQVGN1OFBZbmZQeUlFRG9zWXQr?=
 =?utf-8?B?a0RnN01iVFdFMWttM2k4SmZKOGp4UmJDODRlVHlaL1gwdENia09pUnJBVHFN?=
 =?utf-8?B?a3pOY0ErZndGVFUyYU55c2FWUGRRNGQzUGRsZ1BpKy9HZk9aU2VRbFF4MndB?=
 =?utf-8?B?WmpxaFB4QkJPMjdrakhQMDVNN1UzTXcrV1hWWmRXelhPa3dQMG5nZW9IZUg1?=
 =?utf-8?B?TEo0VHJDem1ibmRaMDRRODFmN3VHTG4wMDBjMjZ6QWcwMWZHZXpEOUxodXBZ?=
 =?utf-8?B?WU8zbHVWOVBtcjd3OTRGOFNCVjJVZlY5Q0MxQ0F4UTFxRXF1aE85dy8xVy9V?=
 =?utf-8?B?WXVvY3BVdWdjQVZYNmNzbXV6L0VPalU5YXA1VDQ4Z3lDYkd6K0R4VWpWajBE?=
 =?utf-8?B?c1lRZ05uOERkb0gyeVV6Y2RzZXFrZHBQUjhtZnlMSld2N2dsZ1crdmxQRmw2?=
 =?utf-8?B?NS9yOC8rR3JpbHZ1d1hyR3FzQ2diVmpqVGkvQVhYKzFORkJMT21lVnJSY1ZH?=
 =?utf-8?B?ZWNFZHJ1WmZ0L0xBamZNeXhzT1hJajhLNGY4SU9MR1hEcG5tMW9kN3Jtdk5u?=
 =?utf-8?B?VnV2QmVmVGViUkwrSWJHdHRWampWc0dpZWxueUNta2ZpSzl1NE9kN2FOYUhr?=
 =?utf-8?B?akprbWhad3RlMG5IUm92d0RBcGFqd0NFaWtBMkN5WlZHUFRSTEVndVVBMlEy?=
 =?utf-8?B?UlRsd3JFcDlXL3lFOVR2WHh3a0dCRlZlTTZENW9qMmJtdXh0RFdwOXE3ZTVU?=
 =?utf-8?B?ZDRrdGJQNkVVdjhiS1psb0tMQVNxSDk1UzdTVHNYSC80NlhNM2JzWmpBNVFX?=
 =?utf-8?B?NVVIVlpDc1Uva3JRWXhPU2YzQ1Y1VTBIL0xpWkIxNGs5cnJCVEYvOEhLeEZD?=
 =?utf-8?B?cnRtN29YU3hWV1NXU09WTlNseHk3SlByVXJUWURmZGduYy9rTHJkZjRNZ2Fq?=
 =?utf-8?B?Vi9PUjI4eFdrZDB4UnV3RGF6ZHRybjNlL3JrWUVxalFEVWhWWkhVL2JSSkhm?=
 =?utf-8?B?Ym5XTlY4ZitybUVJa3RueTNvNCtxaEJSYmJrdDBQRnZKWERFbDM1RUEzbEMv?=
 =?utf-8?B?bGxHcGxHajRBcEh1QmhkNi9LbkY2clI5MVhRT2FLN1RBSGgyYTZwNk5mTFps?=
 =?utf-8?B?Z21QVEFLU2d6VVpMZGNKNzNhNjlQVG5HeVdzN1U4SVFpZmh5anB2blNLUW0y?=
 =?utf-8?B?WGhpWVgrM2ZWcFRnQVdlbmdXeC8wN2F2ZCs4VndwNkxoMVQvZk9qc0pUa2Z2?=
 =?utf-8?B?VllsakJkZDIzUWU3d0IxalNBOUlKcHFnWjV0Z2F1VCt3ZHlsQ2wrbGQ3OWxS?=
 =?utf-8?B?ZGVXU0hMY3Q3Z0s4NTRpZnNqTkVuYWdWK3M2S0t4MHQ5RVNzQUxQdGROSTlB?=
 =?utf-8?B?cE5wb1VVbnRhWUNsNzdzU21ocjFNQWxZMjk0TFVPM0FlazYvdE1JdVZiZDlS?=
 =?utf-8?B?dHpidlE4MktHNGVCT2JOdThBd0l3RU5WM2N3QnJoV28zeWZQRmttNi9KVkdY?=
 =?utf-8?B?QXdXdEZvMkZZK1RkS3AwMFJtaXRQcHdkYUNtWUMvRDBma2RCb1orcnFlUWF4?=
 =?utf-8?B?ang0VlZ3S0Jmb3RhYmxNc3lXa1l4bnZaVjZpV2ZuRUd4bkZzRXJrTnN0S2hO?=
 =?utf-8?B?RnYydm1td3dyME9JVW9Zek8xcHVFWVQvZG5LTVFCZjY5L2xiZStpZkI0NWlC?=
 =?utf-8?Q?XvU6gyUV9QYVFnI899CTo/G2a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbab21f-0b18-4fc9-4d29-08db09ef3a46
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 16:12:08.6482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qdb+RMW9NIj95AfVr5ddAOIlofGRQ6ZNtaF1kp+aD1JRedhRmUP802nxfiazXk3Cp/dvA6RTKgA8B1UkSYwDWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/8/23 09:26, Alex Deucher wrote:
> On Wed, Feb 8, 2023 at 2:26 AM Tianci Yin <tianci.yin@amd.com> wrote:
>>
>> From: tiancyin <tianci.yin@amd.com>
>>
>> [Why]
>> Variable adev->crtc_irq.num_types was initialized as the value of
>> adev->mode_info.num_crtc at early_init stage, later at hw_init stage,
>> the num_crtc changed due to the display pipe harvest on some SKUs,
>> but the num_types was not updated accordingly, that cause below error
>> in gpu recover.
>>
>>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>
>> [How]
>> Defer the initialization of num_types to eliminate the error logs.
>>
>> Signed-off-by: tiancyin <tianci.yin@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

This seems to be the right thing to do.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index b31cfda30ff9..506699c0d316 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4226,6 +4226,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>          /* Update the actual used number of crtc */
>>          adev->mode_info.num_crtc = adev->dm.display_indexes_num;
>>
>> +       amdgpu_dm_set_irq_funcs(adev);
>> +
>>          link_cnt = dm->dc->caps.max_links;
>>          if (amdgpu_dm_mode_config_init(dm->adev)) {
>>                  DRM_ERROR("DM: Failed to initialize mode config\n");
>> @@ -4714,8 +4716,6 @@ static int dm_early_init(void *handle)
>>                  break;
>>          }
>>
>> -       amdgpu_dm_set_irq_funcs(adev);
>> -
>>          if (adev->mode_info.funcs == NULL)
>>                  adev->mode_info.funcs = &dm_display_funcs;
>>
>> --
>> 2.34.1
>>
