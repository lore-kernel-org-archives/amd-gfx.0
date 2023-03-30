Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996A9C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB4D10E317;
	Thu, 30 Mar 2023 13:01:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BB610E317
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOSQA24lIJXiLt8l43sTzrM9ZFXlRVnv3QcsxX/lGbva2NlIteSPZkmeMU5l+qLAwDbL3rReuIAvcq9j52eI6RHBlsW1LL/bn7HvlfYptSEk8JT/nVhJFte3FVDnrJKJq8Vs7MlgDn15IeYylQ/domvkfkgYBduiBtDhvFmERTmI1n3eCaBhErflHANzeor0aixjvakKF5NMoapyLhDfQWyKUCdQ7EDudpvawNduDL9puR1pekdTxSgo50/Ll8mic+frYBP3XC/FPVIMrRQ6WscJSCKI1f8VtIkh2xWdQ2Z4z5jbKgplbHA/adb8pHeSf14TGSZaZWld4YSg7JSItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us8XVPU5rrw3gHVk/4BE1RQiR18KAZCPG+wS3iifJF0=;
 b=IhiRjkLXAqDUcrIqMXoL0xVE6kwJ/9+Axhc439Q11aCkATDH6exBaLFekDrZCDq+WPLf+4OnK4bk+r/mYPKWoJ/5G3Bw1FM128/HFet/ZjuFYr2y4fZW7flCzAB7dAG3OIHMONY2Bk6rNRtgp6jRSyoDSxU52hI9OnDEtKkpaKwaPC6PNi0tOYWHes6uK0x4H39UsPEVuWTRVS5u/B8Dz6aIJs0SEOlVkNxRG/NMkYf5Hgj7s4oT5JcvkDbvAs8/ZeVug89httMr/e4rVY7Wqz+zbnxBF94rVTzC/b71fTfYTgpzVcrpwLkt8lG5lO41usj65pjqi19Z9ivHj9v9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us8XVPU5rrw3gHVk/4BE1RQiR18KAZCPG+wS3iifJF0=;
 b=WM8PWtdDox0E+0NBrBHO+sZfNl5SwhDhyEVY2D4/BomY/TL11Vfhz7RySorXffLd2Sm1zIlWocJ9Pdx3YmzKB0k+qkMCdxguVHMt4knK+17lmYlz6JTgDIH6Lt6XJbHwXxIt65rU2aTIiTcm28tRcafQDa0wDE022KSgUvMS2O0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Thu, 30 Mar 2023 13:01:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:01:34 +0000
Message-ID: <8dc3e40f-c881-9626-85ae-8d41d0ec0343@amd.com>
Date: Thu, 30 Mar 2023 09:01:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
 <SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
 <842f5527-6992-f579-8749-c49d4f9f6e28@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
In-Reply-To: <842f5527-6992-f579-8749-c49d4f9f6e28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::19) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1e14c3-8f73-46f8-0c60-08db311ee3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeaDjz2Q/i6OYI4qTfpRV1FwjJ2hJdO4+xpN5SrmS3Qox6kDLrUNmMyL0A74+mARuz2xA1HL4No6hZeVFgwk43zbgyvKua85lbmwn8VoAriAG9nzoMO7UlVQsYm2/HTXnQBsnKWzDxBMYFAi+Unn6b3wLVJZVYWqff5aG8102u77hXqvG2l3KcLIX5s6JALRoJsD/kIDMTsd2PqxFNZ6K+9BfIn53e+3EiPfPbpKLwp8/KuurBM/qztHmITyO6krD+9xFf9XhFSNH8UGvveGRJJBAAAePliCXptxpJm1qsBn87eGpBaECFRECXDLFUEjPbhmbWRBYt860Ae+oUWSIV4G7pxanM08dxEo8BJMBoTkxB7ch2hvt1QaOt7b36hUMoSRs/NQJ95I5SrGkHhNGOZXcDx6zKJNyG8uj0Zbm9g+7C+bSienpF4wVCy2w4tipFIV6fAHtmAlNtAxV/fQenDZgro6D1EEM6hSUwD9tF7VQnsM/Wuh8bz5N48K4wJEjlxCchDMEYd5JzQqoe6ZLEP/Bar+J+ZEThyJU+KS7g2INrwp3jJROzFBeNXn2kHdEIEWIMoDMVQ3h6mMbCoF9X2VcGzVTHqyf70mhwrMGLvyCjJjb/EuGp0EpIt93jnGfS+BZZvxkFAWnz8MXNMBTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(31686004)(83380400001)(6666004)(53546011)(26005)(110136005)(316002)(36756003)(66556008)(66946007)(66476007)(31696002)(38100700002)(8676002)(41300700001)(86362001)(6512007)(4326008)(478600001)(6506007)(6486002)(44832011)(2616005)(8936002)(66574015)(5660300002)(2906002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJYZEl4QXBIekVnYVRkZE01am11QnZ5QStqRXdBSlltSHhpeFAycUpuWkRL?=
 =?utf-8?B?ZklrS2ZIK1lLUko0TEEzVFgrSTFGYjJURHFtbE1IVU82SWRRdE4reEJWS1p1?=
 =?utf-8?B?UDRZSWU1YTlCOFVOSDkyUlBsY0NDM3pySGNET0VlL3ZEeklrQlZuVVdrVXNK?=
 =?utf-8?B?TVdnbDljSm81Q3h0Vm8wbjIyQzhTNzA4a0p3MXlXU3FtR3pSN1F4ZDBHN3Vo?=
 =?utf-8?B?NWdoTlhoQnBDTWpOR0c3TmpsdkdSKzc1Qm4vWFd0Z25UbGlYRzJ6U2FCVWpO?=
 =?utf-8?B?VExTT1owZWVQVGNBNStndXF5cHF4OW00T1Ezb0IzT2ZWZlRqRkw0ZHpyRVdw?=
 =?utf-8?B?TSt4d2VYSkJhN1FHSVhURzlMcHJtU1Rid0ZDOThTR1ZyZ1hSQUlVdlRUa28x?=
 =?utf-8?B?cDNyZUZMcTRhM1QxTHhLWGhjQkJMditsNVNmZUIvOWc0NDRCWjk3bWZGdGZz?=
 =?utf-8?B?UDd4Y3k2c01KcjJhMjIzNVRGOExvaVB6NHZhdzVNeVhjaktkcTNnVXZIODlo?=
 =?utf-8?B?MkEvbkJiNkRQRkVFRUNGRElZczViTHMwekl1SnhqeTUrT1VhZ0F6Vm1rQ2xP?=
 =?utf-8?B?aXcwc1B3Wm1lSGkwMWJaNm01eGpYOGhxcnhLandRdzI0VW83NjdYN3dieVpT?=
 =?utf-8?B?YTB4WkE3TEEyb2pRVkpTcVI3ZFJOdTdTZGQwZDk5VTFaTWs3Smgya2UrTWdE?=
 =?utf-8?B?VnpYNWZQeldlRkxDZ1NZVnZqdUlBdHdnR3NiZ2RQMlZoSlU2ZHFPTU9PUUFS?=
 =?utf-8?B?QU85Q0F5NXA1U000a1ZsWlN4NnhXWmwvZjFlRGtyclZxRys0N0kvNDQvdXEr?=
 =?utf-8?B?YTVndVJrdHoxVGswbFpvcGJidkoydWY1Q2x5MDN0Sk1TSHExR2dVVDh1Y2kz?=
 =?utf-8?B?aGdST3lYQkNuMVVVQmhGb2tLeFlkVHB5b0wzQzBweGxBdTZPM3dPVU5maHdZ?=
 =?utf-8?B?d0Q5T1pmeUU3aytWaTdFL3lwTk9vbGhoaks0c3JnNGNqSWp1N3lVUTNwN0Ja?=
 =?utf-8?B?b0h5NE1YQWY3Uk5hbWpQUnJyS0I2YlozUW1BaW15d0ZUaUNYVGplbXZFZVlj?=
 =?utf-8?B?R0w3ejY1T3VaS3MrOVRacHBvRlRPQWh2VEIxa2dRVjhnZThhMjlPek9aVTc2?=
 =?utf-8?B?RGxrV2EyaVhKZjVxcnRNZ1lSUmU4Tkd0YlJFNFlIV3VJYlBqaEZpVzRvb0lB?=
 =?utf-8?B?NU1QNEV0VFFNcUxMcTFCL09ONTRiemtJU0tnZm44UWVaNW1GZ2pxZ3VXdTR6?=
 =?utf-8?B?d2ROL01FczkxUXJuQ1pHdEkwVVBIMVUrUFNjL2I1SFFoeVpSOVFXUnRraDcz?=
 =?utf-8?B?TVFBc1VKbi93RFBYdUlwUUxnZ202YWxIN2ljMnVWWUdxUTUwdlVxSVhQSFZR?=
 =?utf-8?B?MUdZeE1GcTFFK09KUVBueEpRSHZLMldYcS8zRjBCb05CaHh2NXltdnBzNjg5?=
 =?utf-8?B?YjVVUkdobC9rdDVCdGk0QWNMRm5Tc0NreTdaSFg2bktwUFdodW1iekhVNlJu?=
 =?utf-8?B?dzIyWUlRM0Z6ZnFzL0lXSzhaNHdXS2ZtbzJ4Q1pDNktBWFNVUEpFWUtIOW1V?=
 =?utf-8?B?RWhLUWFJUllTdWFYQXB3d1dGeUlNbjBxeWJXd1QvcmE1OGR3YTR0N0tsclFG?=
 =?utf-8?B?dzNRTktuQUIwNk1MUmp3cW4zTjlXSXpTZmd5aStGOE50c0lJVVc0c1J3bEZw?=
 =?utf-8?B?RUU4L1VzK2ozZmFuQWhEVEgrR01aaTdhY29kK0tJV3JtQTU1SUs3ckNicDJT?=
 =?utf-8?B?enAyaEpyUFpyZXZNS2tPaGJER2xmeFF2SEVxQ210bUE2enF3QnZYT0ZCYk9G?=
 =?utf-8?B?SjdkckdTaWw2QksvME15ZFRNUy8wNURoWnJCOEJyTlZVaklQMEtHUVJxWm9M?=
 =?utf-8?B?MGRiTEZSWC9sWlJsbTJQYk1DcmNXQkVjTlpuNGRQRXJESFhLSE9oRFVub0s3?=
 =?utf-8?B?bmFwQWtaQ0F0NnFnbURjbUtMSE8zUzdtU1hDRDAyODUzN3Vxa1JZdjBZTDRU?=
 =?utf-8?B?ZlhLekQrbGFhQ1NpMDJZeXRYLzk5TGp3RmxxUEROOUh6WFlnS2FWVjdzaXpM?=
 =?utf-8?B?aU5WNDlOcStvcVlxWFFJYVBGOWlEYXdqUGE0U2U0Mnp1YWJIc3c2bmZvZjB1?=
 =?utf-8?Q?OM+N7Mj2qb5ej1eRW4QlZlthB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1e14c3-8f73-46f8-0c60-08db311ee3ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:01:34.4335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8FP3raDxc32j7qSt1H9/Lyg35Bq+MJYvK+IRwZL+Yhh1jOSF28/+cQSsy55pSN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alan,

Inline:

On 2023-03-30 06:48, Christian König wrote:
> Am 30.03.23 um 11:15 schrieb Liu, HaoPing (Alan):
>>
>> [AMD Official Use Only - General]
>>
>>  
>>
>> Hi Christian,
>>
>>  
>>
>> Thanks for the review. Please see inline.
>>
>>  
>>
>> Best Regards,
>>
>> Alan
>>
>>  
>>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, March 28, 2023 7:16 PM
>> To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
>>
>>  
>>
>> Am 27.03.23 um 17:20 schrieb Alan Liu:
>>
>> > [Why]
>>
>> > After gpu-reset, sometimes the driver would fail to enable vblank irq,
>>
>> > causing flip_done timed out and the desktop freezed.
>>
>> > 
>>
>> > During gpu-reset, we will disable and enable vblank irq in
>>
>> > dm_suspend() and dm_resume(). Later on in
>>
>> > amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and decide to enable or disable the irqs again.
>>
>> > 
>>
>> > However, we have 2 sets of API for controling vblank irq, one is
>>
>> > dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
>>
>> > its own refcount and flag to store the state of vblank irq, and they
>>
>> > are not synchronized.
>>
>>  
>>
>> This is the source of the problem and you should address this instead.
>>
>> The change you suggested below would break in some use cases.
>>
>>  
>>
>> In struct drm_vblank_crtc we have a vblank irq refcount controlled by drm layer, and in struct amdgpu_irq_src we have enabled_types as refcount for each irq controlled by the dm.
>>
>> I think the best solution will be to get rid of the refcount in drm and only maintain the dm one, and add a crtc function for the drm layer to get the refcount/state of vblank.
>>
>> But this may be dangerous since it’s a change in drm layer. Do you have any comments?
>>
> 
> You don't necessarily need to remove it completely, what you can do as well is properly chaining of them.
> 
> E.g. when the DRM counter goes from 0->1 or 1->0 it calls some function to enable/disable the hw irq. In this situation you call amdgpu_irq_get()/amdgpu_irq_put() as appropriate.
> 
> The the code in this patch already looks like it goes into the right direction regarding that. It just seems to be that you have some race issues when you need to add checks that the IRQ counter doesn't goes below 0.

Changing the DRM layer is generally not a good idea, unless
there is a compelling reason to do so, like fixing a bug, or adding
a new feature benefiting all drivers. As there are many drivers using
DRM, any changes in DRM are vetted thoroughly and need a good reason to
take place.

I suggest you follow Christian's advice.

Note that there's already a callback from drm_vblank_get() down
to amdgpu_enable_vblank_kms() which calls amdgpu_irq_get(). Perhaps,
you can leverage that. Similarly for the drm_vblank_put() to
the amdgpu_vblank_put() path.

> 
>>  
>>
>> > 
>>
>> > In drm we use the first API to control vblank irq but in
>>
>> > amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>>
>> > 
>>
>> > The failure happens when vblank irq was enabled by dm_vblank_get()
>>
>> > before gpu-reset, we have vblank->enabled true. However, during
>>
>> > gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
>>
>> > checked from
>>
>> > amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
>>
>> > again. After gpu-reset, if there is a cursor plane commit, the driver
>>
>> > will try to enable vblank irq by calling drm_vblank_enable(), but the
>>
>> > vblank->enabled is still true, so it fails to turn on vblank irq and
>>
>> > causes flip_done can't be completed in vblank irq handler and desktop
>>
>> > become freezed.
>>
>> > 
>>
>> > [How]
>>
>> > Combining the 2 vblank control APIs by letting drm's API finally calls
>>
>> > amdgpu_irq's API, so the irq's refcount and state of both APIs can be
>>
>> > synchronized. Also add a check to prevent refcount from being less
>>
>> > then
>>
>> > 0 in amdgpu_irq_put().
>>
>> > 
>>
>> > Signed-off-by: Alan Liu <HaoPing.Liu@amd.com <mailto:HaoPing.Liu@amd.com>>
>>
>> > ---
>>
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>>
>> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
>>
>> >   2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> > 
>>
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>
>> > index a6aef488a822..1b66003657e2 100644
>>
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>
>> > @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>>
>> >            if (!src->enabled_types || !src->funcs->set)
>>
>> >                           return -EINVAL;
>>
>> >  
>>
>> > +         if (!amdgpu_irq_enabled(adev, src, type))
>>
>> > +                       return 0;
>>
>> > +
>>
>>  
>>
>> That is racy and won't work. The intention of amdgpu_irq_update() is to always update the irq state, no matter what the status is.
>>
>>  
>>
>> This is a change to amdgpu_irq_put() to prevent the refcount from being cut to less than 0. Does it break the intention of amdgpu_irq_update()?
>>
> 
> Yes, exactly that. The reference count can *never* be below 0 or you have a bug in the caller.
> 
> What you could do is to add a WARN_ON(!amdgpu_irq_enabled(adev, src, type)), but just ignoring the call is an absolute no-go.
> 

In addition to adding the WARN_ON() as Christian suggested, and noting that
you cannot ignore the amdgpu_irq_put() call, perhaps investigate if you can
allow the decrement to take place and then check for negative--atomic_t is
an "int". If it is negative, then complain, dump the stack, set to 0 and return.
-- 
Regards,
Luben


> Regards,
> Christian.
> 
> PS: Please don't use HTML formating when discussing on public mailing lists.
> 
>>  
>>
>> Regards,
>>
>> Christian.
>>
>>  
>>
>> >            if (atomic_dec_and_test(&src->enabled_types[type]))
>>
>> >                           return amdgpu_irq_update(adev, src, type);
>>
>> >  
>>
>> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>
>> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>
>> > index dc4f37240beb..e04f846b0b19 100644
>>
>> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>
>> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>
>> > @@ -146,7 +146,7 @@ static void vblank_control_worker(struct
>>
>> > work_struct *work)
>>
>> >  
>>
>> >   static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>
>> >   {
>>
>> > -          enum dc_irq_source irq_source;
>>
>> > +         int irq_type;
>>
>> >            struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>>
>> >            struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>>
>> >            struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
>>
>> > @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>
>> >            if (rc)
>>
>> >                           return rc;
>>
>> >  
>>
>> > -          irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
>>
>> > +         irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>>
>> > +acrtc->crtc_id);
>>
>> > +
>>
>> > +         if (enable)
>>
>> > +                       rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
>>
>> > +
>>
>> > +         else
>>
>> > +                       rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
>>
>> >  
>>
>> > -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>>
>> > -                        return -EBUSY;
>>
>> > +         if (rc)
>>
>> > +                       return rc;
>>
>> >  
>>
>> >   skip:
>>
>> >            if (amdgpu_in_reset(adev))
>>
>>  
>>
> 

