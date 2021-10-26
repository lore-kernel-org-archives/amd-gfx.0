Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9DBC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D1B603E9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 16:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9D1B603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4A06E462;
	Tue, 26 Oct 2021 16:03:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E57B6E462
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 16:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+tOzQy6LYgz4GCrzRHXWwawL0bz/TUr/pp7eMBs2n4el6xk0oDgISlXxeg82ZDUUluvPFLH9NU0+YYTeu4oXps8BSIeSNkhZEVXIRodV3CpmjGTZJ172/pbOncJZkmpI2ljwunj9EOH5r8LTExqNAMTAtJ/AjZjbK6BRGzxxcG6pB85A7nqPUD0y4nkpiOkXS1I+AtJM9mWVu93GYmjh+u4Lr5jbDWQoM0hrJDNSHjZdaq9ohBvrI5nCHdCnmEF3SVtU/Iuv8Fg/HjVSX++siXHA5cZkBnOyOZ76wQygQhFBakpKYgURjeUGsU1EoVqVXarcSwhM0WdhqSoNTwRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dxzkceq+m4APyiGkSKNjP3GKF2pzaauFVUpbo3YYjk=;
 b=Rw9BVrGPrGPbhbtx2glW7MHV4a2IwDi420xzCyXiTaer4ZdTRuU/HP9FUvd9/tvB275CPOkbqLM+LvCeBVoGAeCgPOJaFysEOWhq1uFq9JHQ+u8mz/+JrpBYKyM8wyRxYZ4qmfUw4BfTkpg/YKg6A8dD+LJVdR+CzzJb516z00gXTl95b5A1TlJHTUkKApOoNAvY/PiR8HdGM3XrVFfK3baz5XToHx8EPxjAYXMzuZXVper1QEDe6E5Lowzv8bAUpSXiT7AoKEuzlR0kCOiYS7d7d055QjnpMlypAM1qc+LkKJw8SDaGftTAkypXY8TOGu9trVYekdV3KJ9qssatWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dxzkceq+m4APyiGkSKNjP3GKF2pzaauFVUpbo3YYjk=;
 b=LyGv4svkhmQpfsXNg9xnAxBarVNw5nbiALNaFqNGSRqerIqrXocZ1dyCN9Ij4WEDVlFNqYMBMpTCCeDVdeWMCy1J4+ur6F6hMUvMvrF+cz5ULF2foM//EsWPhYAjyDmDI/5Eq5iHeTVDRw+uqr09rLLGHyWD4v7RnDQBlBIs8Vw=
Authentication-Results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 16:03:41 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%9]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 16:03:41 +0000
Message-ID: <b29f5d0e-a0d4-2a2c-d9ee-6e16541b9906@amd.com>
Date: Tue, 26 Oct 2021 12:03:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, contact@emersion.fr
References: <20211026110740.152936-1-stylon.wang@amd.com>
 <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::9) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 LO4P123CA0022.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:151::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 16:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d134a7d-1854-47b6-0b33-08d9989a2dea
X-MS-TrafficTypeDiagnostic: DM6PR12MB5551:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55513AB3EB45F54B299B40C0EC849@DM6PR12MB5551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NP13/1Hdg23S4vxF/CilUWeC2nw9fREBTj3YtlvHCLpEh/toLqvpIGgNPNBJeAKalVqpai6JOMfKvSSZh4XETHcCgfIuKzNpUEafuJlFkNHwg+e11JXk9vGy5Z4muCsWfk+gZ0wqa0JL91Kc7lXQYBJK4AeGzV8uQVDcQ7s4uAiu2CnkZ16AQ6+4AfCfUVXBLdrcaT1cCymh8mhZcA07N6HQ83+p7VGznsibtl9cq49kwb1GV52vrgkU19nk2T+bbTHed46k4gEOPaXrQNteP6rBvj6i5dYw0fsms9EWqsxjuL8EFH8kEyQRr+O8jke7vYo58DPKnLgjS4KHhgDUBTmzwcKdTnfrY2nVjZGcX1QSZfkSWB6dJpPRCypRXMa3tvmoSnahN6UaT5fsE4v7rnoPJLbtBQbpFYDvjeueT8p/CoqB204SLQcuZI9r+vdAImFI4J1cIitt8ERGKmimdcKvl+iiHRbaiQo/+0z/AFFiLpJ8tUOVRb3C83NPvu25uG9qWBpi2+iyaLAA0tuxWdhsKJUohAiEUANqtIrH/UB0soYZNM7YGXzU/8Wm/o3QTlAbK38EXEZBTwcAxYgXlDJUz9/iTPpfBPdRxxezzA4BJx6fNAzOxvRGcST4GO5mh3BjXNFmr7poe/DVkSkj4lOVaFNZOCG2NaOb4Q+4PeXdyqco0u6+0X3VY44A3vBsda4rW6C5ka1qmSCaIFH/o9vOMgMOAx9r2xCjMLGqkVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(26005)(8676002)(66946007)(6486002)(38100700002)(66476007)(66556008)(6666004)(508600001)(36756003)(956004)(110136005)(31696002)(53546011)(2616005)(186003)(31686004)(4001150100001)(16576012)(316002)(4326008)(66574015)(5660300002)(2906002)(86362001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si95dGIvbEY0U3BHbXFkS3RxRVFkNDJuTkxHN2RJTWpzYk16eVgrdHFmUTc3?=
 =?utf-8?B?WjgrYkdSWGxoOFl6ZG5ua3RnUGY2dDd5ZzhJNkh0WnRVZkl6T3lxR1A2SDFw?=
 =?utf-8?B?TkVSSHVKUEg3TzljcjRob0g5ZjlqSUNBVXhBdkJTSFc4M2lWbEk1azA0MUpZ?=
 =?utf-8?B?S2FBZU5VaUNOaENma2liODBXbURFZ3cyVUQwZ2ZtZ1VYTVIzeDBETkVOM2R0?=
 =?utf-8?B?QVQzTzgyRXJSVVV6WnFjVnYvUDkyNzJVTHEyZjNiOW1lRFl6d0gwbkk0YzlN?=
 =?utf-8?B?QitlN0dnNkhpNVZSMnhqRHlWYkNSczg1YTIzdmVYbXArSGR5THNOQ2F3Y1dF?=
 =?utf-8?B?b1NnMDUzeDY2NnYvTStNTEd1T3RtYStxMzNRdlZoWkFCYkNNWVV3cUd6M1lx?=
 =?utf-8?B?N1dNNDM3U3JPdTJLZTRSYVlxcnlrWjlheno4SndMT1hCbGV5VjdGQUpYTnVv?=
 =?utf-8?B?eUpJK2xHOTJHNkdHMzVFMjdGSEJKYzJwemR6aW4zMkhKYUlGdlZ4M0ZlUUFW?=
 =?utf-8?B?MG0yNnhjWEhXa01kM0pVa0k3MDNQdWlHeUVyTGRkYndnbm5KRXhna1hYZFla?=
 =?utf-8?B?VHZyS3loelArWCtxNXRnVFA4aUd1WGdDaHh6WnNhUGI0QzBLcEV1cWR6anNQ?=
 =?utf-8?B?Z0RBQW96NlpFUW5QcFcwYzdYT28wZnNmWXcwRmlFVHVXcnZHbDMxbEZ1dGxO?=
 =?utf-8?B?Vk51NjdLWE1scEVOYVdnVXBtZnEvaUdnWmdZNDZyZDZoOUpWQ3RjTXpxR0ZT?=
 =?utf-8?B?cmVMdE5uSGdyNXNYVGxJYVo2bDhhekZlOXI2MG8wN0p4WFNjWmdHS2lTRS9n?=
 =?utf-8?B?UjJNNmF0dFhDQW5CWTRQdkJXNEVxYk1QZ0pzUldWbi81OXRwc0ozTFVqUEhB?=
 =?utf-8?B?T0wyOWVEQXVWT2dmODhIcGFybXNFdUtsRlkreUFXRjRNbjdOUGczY1UzWnBX?=
 =?utf-8?B?ZklVTi9RMHVMeHNuclRWa3F6WEQwK0pPVkhzVnNlaitjVGhDTjZJdDVlNHlX?=
 =?utf-8?B?bGttMzhmRGJOZ3RGUVEwUE8yS09aL2QyMTlUL1NKOEdaQWttWFp1czNEOEVZ?=
 =?utf-8?B?Lzh4ZTVHNlNNV1FzOTlrTHdhN29oREE0U0xKdzI0KzJPRHJPNEpvejlCWWpK?=
 =?utf-8?B?K1FnWVV6WFFZa004MklIRXpoS3YwWlZaSXVOQjVHZzcya2xXbEU1R2FNNzk1?=
 =?utf-8?B?M0p3UjNrRlZyZzBPcU9rVktXdlNaZU9PdVQxa0NTZGdMMnBWMVVFNHg5MVZx?=
 =?utf-8?B?NHJaeDNWSVpLMWhDd0VJeHdXSVh6VjJPRXRIMDFDZnpNRkhERnZMbnd4QlF3?=
 =?utf-8?B?LzVjeDUwK2FMbk5mdVpNRmwxTElNL2ZGMGMrd24xN3hRckM5UEhFcUdhREkr?=
 =?utf-8?B?ZlQrMkphaXdCUitQdmhRZG1mWDN4VitMS2VhV01Hay9IMnRJM3JhZmRyOEVK?=
 =?utf-8?B?RDJXOWcwMXRIMmY4dHZWcmJIVkRmMGVwQnhhdHNFb1kxQlF5b1k5TUg5eWZ3?=
 =?utf-8?B?SEx3UXB2RjA2VDdzZ2VUeGF0S0h0QVMxZFJlM0Z3YkNRSTVrUkhqR0x0cVA0?=
 =?utf-8?B?M1FmOTZGQWhwbGZZZlV0KzMrV3VGb1NIMGFuQWR4ZDFLMlFtRkNWZmxJL2hH?=
 =?utf-8?B?WGcvS2hGSkNYampGYVJvVXAxRGl2TGhHcG94UjJzRHgxbVFPOGxkUkNwSUhk?=
 =?utf-8?B?UjFGaVpRam1lV0UrY2RFZlhudWpMQTlIU3JPWGFrSFA0UGFodWxBNzliaFov?=
 =?utf-8?B?NlBhVTVSamFDeTdwc3N3Qk9Id0pSWjBYWjlvTmo2bjJOQ0NVbDhUQUdlS2lp?=
 =?utf-8?B?ZTVhZlc0M29ab2QyQStwU0JUOUlNZWl4WFNjdUN6bm0zWll4MFVyaUFxekU2?=
 =?utf-8?B?SXA5cjdZR0l4WndoME9VZU91d0dUNGRTaEFXMUNKUEl6c2s0NC9HVHVyd3Fp?=
 =?utf-8?B?ckY2bVhZQ0NXSmNicitKR2RCZ2pPWEY2WmFMT3E4dGs3QWhvY1VsNzRDbzIy?=
 =?utf-8?B?YzdWcU0vUXF0YWlRVTZQOEJyTGovaXY2WStnWFp0K04ycEN5dEdseTdqVC9x?=
 =?utf-8?B?c2dINzdRYnhlTytRNVFzMUROTlVySExLeHNZT0tmRTBPR3gzclBuV1pVYVR3?=
 =?utf-8?B?NklvTjh5WnFCZ3NVci8xSERMb1hDaWltSXYvMXh4c1pYYVJpNzM3a2FkREcy?=
 =?utf-8?Q?HQmsTYYXYiMknNoP9KopFLs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d134a7d-1854-47b6-0b33-08d9989a2dea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 16:03:41.5331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9vlpRktRE1Wh3XPU3v+Si75WTQCPS4JLG6/XsoLY63PwZhPfGCv8zcn7/dXiGv/CnQJ5eDUd+UlbyyYp51R5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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

On 2021-10-26 11:51 a.m., Michel Dänzer wrote:
> On 2021-10-26 13:07, Stylon Wang wrote:
>> [Why]
>> In GNOME Settings->Display the switching from mirror mode to single display
>> occasionally causes wait_for_completion_interruptible_timeout() to return
>> -ERESTARTSYS and fails atomic check.
>>
>> [How]
>> Replace the call with wait_for_completion_timeout() since the waiting for
>> hw_done and flip_done completion doesn't need to worry about interruption
>> from signal.
>>
>> Signed-off-by: Stylon Wang <stylon.wang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 4cd64529b180..b8f4ff323de1 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct drm_device *dev,
>>   		 * Make sure all pending HW programming completed and
>>   		 * page flips done
>>   		 */
>> -		ret = wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
>> +		ret = wait_for_completion_timeout(&commit->hw_done, 10*HZ);
>>   
>>   		if (ret > 0)
>> -			ret = wait_for_completion_interruptible_timeout(
>> +			ret = wait_for_completion_timeout(
>>   					&commit->flip_done, 10*HZ);
>>   
>>   		if (ret == 0)
>>
> 
> The *_interruptible_* variant is needed so that the display manager process can be killed while it's waiting here, which could take up to 10 seconds (per the timeout).
> 
> What's the problem with -ERESTARTSYS? Either the ioctl should be restarted automatically, or if it bounces back to user space, that needs to be able to retry the ioctl while it returns -1 and errno == EINTR. drmIoctl handles this transparently.
> 
> 

Thanks for the insight Michel!

If it's just an error in the log without a functional issue then maybe 
we should downgrade it to a debug statement in the case where it returns 
-ERESTARTSYS.

If this is a functional issue (DRM not automatically retrying the 
commit?) then maybe we should take a deeper look into the IOCTL itself.

Regards,
Nicholas Kazlauskas

