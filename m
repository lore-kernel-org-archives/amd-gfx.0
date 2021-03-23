Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F427C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 16:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3206C619D3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 16:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3206C619D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F086EC34;
	Tue, 23 Mar 2021 16:01:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BFD6EC41
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 16:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+RPaP6sj/vZQEDPyQrt2MDaraR48HtI5CHKtaM/IuCja1sXp4w+p9k0+MmLwDk6q1jLWLXFgASHwj7etm8/zfiuLYy2GGqULAlSiVrp2apCbmSASkyezDFjJ3PAAZ4Nafa28ihrQINCJkxhSglQEAlKamswZ8dsd+YXlpMBBJ1Azz6PbOw0HpTEDsaem/hqaRqE3qzzHwXnW678Owri7fE4dHzTXA3qY3vU9SHhJDkvUJ7ReL6JegedUusmpFLftab3u6Hk7I8OpT8Md71G+EIBdUrbTTfJeqbnwPXShJtE/H4umw1ANTwOza/AZmWxpCa15rEss7IRAjM/IAvQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugee+auZDYQnpwOsY09qEKDzgPnq/KEZAtwpBCkKxaA=;
 b=XXm+7AIiUIGfpeiUd617U1+8DB/wU4Zc5rp59VxmkcNSkmkUFESSpgtzpxQ8agyeC9yjFoLxQkftzveTjimjbeOAXy3H5E5gXTqNDniTKtOHpFsHIZ6twIpmfUE720BBI+SRyAMP4UFqUhKFVQ2M22lUw8HoHEGdf1DjM6f02j9AQFMPesX2Gx4w+GFlg6vmk6oeel2zlHBC0LKgeh0+Q5OwFR5pv4rWCMVtxlC7qqrm6yCv6EM2RYR+CPC1rkUlZqCdQCwH98+nr1ihzmhPMxWAQawfM36jJHGqZAJ4VNDQGoDTNoPdTk3ccFdHymFp05jr+YP4OKLYnPosPD8gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugee+auZDYQnpwOsY09qEKDzgPnq/KEZAtwpBCkKxaA=;
 b=rxS37M79yL8xor4jLUut0ht/cqfGjo1qdrK4JAjticpOEp3AoEUnHpOB2K0HLaMuOvUgg5xocL/qzN/784YUoFNbyTdh9tyqCwFoUckU1eA2pHO7S9m9vifSl2LX+ps6GwEpMs40Pg/tlugGFLCVhWrjmjpcQdlpSbzyYMb4JOo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1807.namprd12.prod.outlook.com (2603:10b6:300:113::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 16:01:50 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 16:01:50 +0000
Subject: Re: [PATCH] drm/amd/display: Use DRM_DEBUG_DP
To: Alex Deucher <alexdeucher@gmail.com>, Luben Tuikov <luben.tuikov@amd.com>
References: <20210323003121.7897-1-luben.tuikov@amd.com>
 <CADnq5_OrcLoBH7d1n1aL9eCQSqaajgYaU5ypXwzgm+-DPaahpw@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <9042072e-107a-eec8-2357-962698d91d0e@amd.com>
Date: Tue, 23 Mar 2021 12:01:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_OrcLoBH7d1n1aL9eCQSqaajgYaU5ypXwzgm+-DPaahpw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0516.namprd03.prod.outlook.com
 (2603:10b6:408:131::11) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.6.138] (165.204.84.11) by
 BN9PR03CA0516.namprd03.prod.outlook.com (2603:10b6:408:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 23 Mar 2021 16:01:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 384a50ce-2c54-4786-cf9e-08d8ee14f81f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB180784EB4D7DB7860AAD791E8C649@MWHPR12MB1807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD+VdFTQqvlJliX3IAnxZXl3O1Ad6zk0z+Jj7rNlBJqRwnpjgSg1p8zR7YpWpeTgj2tcAxYzI8zxkI7tXZ0mOlI7tIgF53tP3uqXyAOV/SzSpJiVfCjTNH/mkb0SHaDL505A+Wu510dQ4gyMVuHcmeiD6LNLCyuGuTSI9D3tvzLgdA2hlF5k6C00gnDx2j5SsD922JROJT2RK+4HKsyAjTNWiKgZ4p1foE7Mq8qOAJr9hbBDyG/RejGHZHUW8jBUCCKS6zfUk08i2E4oPSH+jVBNMFwNXFn5F3fvbtq+HuGBXdtG8cW2LafSdVjxNkB6ripZmqJFznvnKdRIIqoICrpUbPMYlaWWsBew4KUZmEmHM7tVaz8A6iZeN9RkHt1QwO3OoQlKTniOpGYlbCs5NRcxl609b9Op1h7huOmk7TJEWrlSlzlF8BXWj1+KXnn+r8d93Z0qpgEBMIZUxYcjBo/BKnizwUzJiVXLABe3g5P6ICTgC6TF7Z4GYkzzAkymKq1Kf0HS0SxA1HJQ8jZVzrBamIgG2LsAbpuNp8Gz1+8XZ3u1qzgbjph4wr0kx9cwRLUiJaWwR95Ck+9mvEO9C468DtOSdVy7C2liOtXChnzhfcfDF3NQ6ZV3SbFrwlvdLONURiAJWlJv2okLjB/wMN+0pyL9nEJiB1hSdc2k0f/MfWjxhh1+E55bGHj9rSdywUxHrrrf7aHHYfcwzyjiWgwBTUVH1ujye3nzfYmOHNrLiDOE0rVr2V0LZ2IkGzsi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(31696002)(956004)(8936002)(6486002)(110136005)(66946007)(2616005)(966005)(478600001)(53546011)(66476007)(66556008)(38100700001)(54906003)(4326008)(26005)(6666004)(31686004)(5660300002)(83380400001)(6636002)(186003)(2906002)(86362001)(44832011)(316002)(16526019)(16576012)(8676002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlVpRDZDR2tKeFJ0a3dsVzUwS3BvUEVWaW9sVG1GU1BLY3QvQTlqNkxad0VB?=
 =?utf-8?B?Y1Qxbm9EVnBIUytEUUpRMWUrdDhVWWZBOC9QVDNVcjhadm1KWXhCZ1RvT1BK?=
 =?utf-8?B?cnpEVjJFbkdyNGovUjRELzBjNGIvVnllRmxNNXZWaEZSY3hWV01oTWFwOG9O?=
 =?utf-8?B?TlpQV2NHWjU5RkVPU2hiOEpaODNKMVBhT0d6NFhtVmsrYWxZNHhUUWVIemk3?=
 =?utf-8?B?UU1JM0tDSzBPRXpUWmFSakZ5Y010UGFPZ2M0SHRkVW90SHZzYXdnOE80SmtH?=
 =?utf-8?B?a3dNUHNvOUVPc29hNGZON0RxT3VMeVk1QzRiREVzNUU1M1FNVnpic1VIUFhz?=
 =?utf-8?B?Wi8rVGZndHRLZWp4Z0dCd3R6WHIxMFNyQWxwc2FOYjNjZnY1RDNPQjB3aDdZ?=
 =?utf-8?B?aXRpb3VjVTZhcnk3MmxqV1VsVkIwUXl5bkRFRjhBTzUyMys4N0IxelIzTnVn?=
 =?utf-8?B?WkhNRFU5VjkvU21BMnVJQndSZEFJZzh6RFFlcjJobmtoMk81b3JsSXpOL29i?=
 =?utf-8?B?U3NKS0VBZ2hMeVlRVmdjbnVvQU4zakZBODliamlQVnYzWkErTWhlM04rOHBU?=
 =?utf-8?B?cjVPcU1VUFp6N2J6cVJWTVJEYXVEaUhjbzZHbmZoV2JTTmpoYUxlaEQ5ZFBX?=
 =?utf-8?B?YmthUTFjcFM3MWVRaW8zNFVKWWE5OWtDaW81dWtqYkZpMEVWdEJiQyszeHlU?=
 =?utf-8?B?Rk1qcHdXTkt3eUc5RTV5bTJza0dScUpENGFCdzl6dVdiU3plVSttOWlFUWhI?=
 =?utf-8?B?cU42Z1M0QUZJcDcwL1hSQnQ0blNQYUptdzFtbHpIamRHM1Zya2pZbEg2S3Ir?=
 =?utf-8?B?eUYxcWk4Zm9QeU9zTG1IM3J0eUJzRUo1c3Fhc3VPRFdka1JnUVF6VDFOS1hK?=
 =?utf-8?B?dVQraGNlNmFocGpRcnhlOGFBSytoaWp2VlBScnF5UWpTSC9Oak80Y1dlb0ZG?=
 =?utf-8?B?U2xKTUk1b3JvVnlzdCtndklMY3lzNXRMaUhxV0xXVVJIb1ViMWVwbEJVK25t?=
 =?utf-8?B?NUZiYjFzQnc4MGN3aFBXdGZyTmtWMXRWdWQ3TmpHRHJvQmJQNDJiakFCYTBI?=
 =?utf-8?B?TEZPUmo0VTV3clVNZ1pVUytwbjd6TVpqeGo3UzBCdGpNMGFCcGdYbHAwaUlk?=
 =?utf-8?B?a1VYM0hxRnlORDJHNWlKRzFua2xDK0ZTNHdNT0NsWHhMdG5EREtxSkRRdUM2?=
 =?utf-8?B?bzRjNlpGcXM5elRMbDR2aXJpWkNiTndVclA1Q24xdk8yL1I3Y3phVjh4YXIx?=
 =?utf-8?B?Y2VwZGc4S2ZmU08rV1FFR2dUU3hFY1RVS3kvQlRZSHFPVlpMYWVzNmJQVUNI?=
 =?utf-8?B?c1BSYUpVbzJ2dmd1LzlOZXcrZ2M2T3E1RUpjWWdadjN1WWpTSWtacUhLZE9V?=
 =?utf-8?B?UVlDV0w3L0tXY0lpQ0o2UnU2QldTYmk1M0hTYjBwcEowZzhWd2p5SGhNcWpo?=
 =?utf-8?B?TFdpMmhnYnU5cVl5dmFjdU1lb1MrSHFGcnNPZ3ljSCtEbkdFVFBOR1JKZnFi?=
 =?utf-8?B?M0dBcDYrdURVdXN2ZUo4RnNuTXJDTFc4M3pVNFcwbmFFV2lpbUwvanpxWjR0?=
 =?utf-8?B?Yk5mc0I1QzI0RnFoNFZDckF6UTBVdGVxNTluVlB4UGhGMFlISVFzV3lHdFFv?=
 =?utf-8?B?czNhUnBaR1J5Zmt1UDZ0dDBCQWtZbW41Ym1IbUxmcXpNY2w5dnRpOCthTWl4?=
 =?utf-8?B?U3Qra1FUY0tpamFhWGVSbmFMU3Z3ZTYxeW1haGdJQjhIaDJqUERHWnVpSmNF?=
 =?utf-8?Q?2R40LvA/LIcAdAysBL0pmluAvxzuHTE2WLLzZbI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384a50ce-2c54-4786-cf9e-08d8ee14f81f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 16:01:50.5562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHnQ8YYwuVUujOVbH1NpE1uRXrUx2FwDvNpG+64//BwQAHgaEEb6Ekn4g0mNWP54g5Hc4H/xMyEcplQLVnAAGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1807
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for converting these away from _DRIVER.

On 2021-03-23 10:26 a.m., Alex Deucher wrote:
> On Mon, Mar 22, 2021 at 8:31 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Convert IRQ-based prints from DRM_DEBUG_DRIVER to
>> DRM_DEBUG_DP, as the latter is not used in drm/amd
>> prior to this patch and since IRQ-based prints
>> drown out the rest of the driver's
>> DRM_DEBUG_DRIVER messages.
>>
>> Cc: Harry Wentland <Harry.Wentland@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 +++++++++----------
>>   1 file changed, 33 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index f455fc3aa561..aabaa652f6dc 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -449,9 +449,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
>>          amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
>>          spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>>
>> -       DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
>> -                        amdgpu_crtc->crtc_id, amdgpu_crtc,
>> -                        vrr_active, (int) !e);
>> +       DRM_DEBUG_DP("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
> 
> Should probably be _KMS or _ATOMIC since this is not displayport specific.

It looks like _ATOMIC is strictly for code dealing with atomic. KMS is a 
better bet.

_KMS

> 
>> +                    amdgpu_crtc->crtc_id, amdgpu_crtc,
>> +                    vrr_active, (int) !e);
>>   }
>>
>>   static void dm_vupdate_high_irq(void *interrupt_params)
>> @@ -993,8 +993,7 @@ static void event_mall_stutter(struct work_struct *work)
>>          dc_allow_idle_optimizations(
>>                  dm->dc, dm->active_vblank_irq_count == 0);
>>
>> -       DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
>> -
>> +       DRM_DEBUG_DP("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
> 
> Maybe _VBL or _KMS or _ATOMIC?
> 

_KMS

>>
>>          mutex_unlock(&dm->dc_lock);
>>   }
>> @@ -1810,8 +1809,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>>                  if (acrtc && state->stream_status[i].plane_count != 0) {
>>                          irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
>>                          rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
>> -                       DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
>> -                                 acrtc->crtc_id, enable ? "en" : "dis", rc);
>> +                       DRM_DEBUG_DP("crtc %d - vupdate irq %sabling: r=%d\n",
>> +                                    acrtc->crtc_id, enable ? "en" : "dis", rc);
> 
> I think this should be _VBL.
> 

_VBL

>>                          if (rc)
>>                                  DRM_WARN("Failed to %s pflip interrupts\n",
>>                                           enable ? "enable" : "disable");
>> @@ -4966,8 +4965,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
>>          stream->src = src;
>>          stream->dst = dst;
>>
>> -       DRM_DEBUG_DRIVER("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
>> -                       dst.x, dst.y, dst.width, dst.height);
>> +       DRM_DEBUG_DP("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
>> +                    dst.x, dst.y, dst.width, dst.height);
> 
> Should probably be _KMS or _ATOMIC since this is not displayport specific.
> 

_KMS

>>
>>   }
>>
>> @@ -5710,8 +5709,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>>
>>          rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
>>
>> -       DRM_DEBUG_DRIVER("crtc %d - vupdate irq %sabling: r=%d\n",
>> -                        acrtc->crtc_id, enable ? "en" : "dis", rc);
>> +       DRM_DEBUG_DP("crtc %d - vupdate irq %sabling: r=%d\n",
>> +                    acrtc->crtc_id, enable ? "en" : "dis", rc);
> 
> Should probably be _VBL.
> 

_VBL

>>          return rc;
>>   }
>>
>> @@ -6664,7 +6663,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>          int r;
>>
>>          if (!new_state->fb) {
>> -               DRM_DEBUG_DRIVER("No FB bound\n");
>> +               DRM_DEBUG_DP("No FB bound\n");
> 
> Should probably be _KMS or _ATOMIC since this is not displayport specific.
> 

_KMS

>>                  return 0;
>>          }
>>
>> @@ -7896,11 +7895,11 @@ static void handle_cursor_update(struct drm_plane *plane,
>>          if (!plane->state->fb && !old_plane_state->fb)
>>                  return;
>>
>> -       DRM_DEBUG_DRIVER("%s: crtc_id=%d with size %d to %d\n",
>> -                        __func__,
>> -                        amdgpu_crtc->crtc_id,
>> -                        plane->state->crtc_w,
>> -                        plane->state->crtc_h);
>> +       DRM_DEBUG_DP("%s: crtc_id=%d with size %d to %d\n",
>> +                    __func__,
>> +                    amdgpu_crtc->crtc_id,
>> +                    plane->state->crtc_w,
>> +                    plane->state->crtc_h);
> 
> Should probably be _KMS or _ATOMIC since this is not displayport specific.

_KMS

> 
>>
>>          ret = get_cursor_position(plane, crtc, &position);
>>          if (ret)
>> @@ -7958,8 +7957,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
>>          /* Mark this event as consumed */
>>          acrtc->base.state->event = NULL;
>>
>> -       DRM_DEBUG_DRIVER("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
>> -                                                acrtc->crtc_id);
>> +       DRM_DEBUG_DP("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
>> +                    acrtc->crtc_id);
> 
> Should probably be _KMS or _ATOMIC since this is not displayport specific.

_KMS

> 
>>   }
>>
>>   static void update_freesync_state_on_stream(
>> @@ -8265,9 +8264,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>                          &bundle->flip_addrs[planes_count].address,
>>                          afb->tmz_surface, false);
>>
>> -               DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
>> -                                new_plane_state->plane->index,
>> -                                bundle->plane_infos[planes_count].dcc.enable);
>> +               DRM_DEBUG_DP("plane: id=%d dcc_en=%d\n",
>> +                            new_plane_state->plane->index,
>> +                            bundle->plane_infos[planes_count].dcc.enable);
> 
> Should probably be _ATOMIC.

_ATOMIC here and below

Harry

> 
>>
>>                  bundle->surface_updates[planes_count].plane_info =
>>                          &bundle->plane_infos[planes_count];
>> @@ -8299,10 +8298,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>                                  dc_plane,
>>                                  bundle->flip_addrs[planes_count].flip_timestamp_in_us);
>>
>> -               DRM_DEBUG_DRIVER("%s Flipping to hi: 0x%x, low: 0x%x\n",
>> -                                __func__,
>> -                                bundle->flip_addrs[planes_count].address.grph.addr.high_part,
>> -                                bundle->flip_addrs[planes_count].address.grph.addr.low_part);
>> +               DRM_DEBUG_DP("%s Flipping to hi: 0x%x, low: 0x%x\n",
>> +                            __func__,
>> +                            bundle->flip_addrs[planes_count].address.grph.addr.high_part,
>> +                            bundle->flip_addrs[planes_count].address.grph.addr.low_part);
>>
> 
> Same here.
> 
>>                  planes_count += 1;
>>
>> @@ -8621,7 +8620,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>                  dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>                  dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>>
>> -               DRM_DEBUG_DRIVER(
>> +               DRM_DEBUG_DP(
> 
> And here.
> 
>>                          "amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
>>                          "planes_changed:%d, mode_changed:%d,active_changed:%d,"
>>                          "connectors_changed:%d\n",
>> @@ -8655,7 +8654,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>
>>                  if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
>>
>> -                       DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
>> +                       DRM_DEBUG_DP("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
>>
> 
> And here.
> 
>>                          if (!dm_new_crtc_state->stream) {
>>                                  /*
>> @@ -8688,7 +8687,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>                          crtc->hwmode = new_crtc_state->mode;
>>                          mode_set_reset_required = true;
>>                  } else if (modereset_required(new_crtc_state)) {
>> -                       DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
>> +                       DRM_DEBUG_DP("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
> 
> And here.
> 
>>                          /* i.e. reset mode */
>>                          if (dm_old_crtc_state->stream)
>>                                  remove_stream(adev, acrtc, dm_old_crtc_state->stream);
>> @@ -9298,7 +9297,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>>          if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
>>                  goto skip_modeset;
>>
>> -       DRM_DEBUG_DRIVER(
>> +       DRM_DEBUG_DP(
> 
> Should probably be _KMS or _ATOMIC since this is not displayport specific.
> 
>>                  "amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
>>                  "planes_changed:%d, mode_changed:%d,active_changed:%d,"
>>                  "connectors_changed:%d\n",
>> @@ -9382,8 +9381,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>>
>>                          dc_stream_retain(new_stream);
>>
>> -                       DRM_DEBUG_DRIVER("Enabling DRM crtc: %d\n",
>> -                                               crtc->base.id);
>> +                       DRM_DEBUG_DP("Enabling DRM crtc: %d\n",
>> +                                    crtc->base.id);
>>
> 
> Same here.
> 
>>                          if (dc_add_stream_to_ctx(
>>                                          dm->dc,
>> @@ -9728,8 +9727,8 @@ static int dm_update_plane_state(struct dc *dc,
>>                  if (!dc_new_plane_state)
>>                          return -ENOMEM;
>>
>> -               DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
>> -                               plane->base.id, new_plane_crtc->base.id);
>> +               DRM_DEBUG_DP("Enabling DRM plane: %d on DRM crtc %d\n",
>> +                            plane->base.id, new_plane_crtc->base.id);
>>
> 
> And here.
> 
>>                  ret = fill_dc_plane_attributes(
>>                          drm_to_adev(new_plane_crtc->dev),
>> --
>> 2.31.0.rc2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
