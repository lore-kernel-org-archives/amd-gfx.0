Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F00DC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 04:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1EA23C44
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 04:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1EA23C44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3164B6E364;
	Thu, 10 Dec 2020 04:49:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5266E364
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 04:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvef3fGPZ70KBZKlL9F07ccFAsuOIPTQjXt1CerHX91E1g3mMdLCHNH7pVgkB6N4Oq4i7S4NkUMkxqb5Qr8zUxJKUdaKpsAwfOv2WcvCiQQtFYeK+3ZoNY0XZcG2JwEnzSJinSZ+8qgYy33cgnPcnBwwIb2mxipocjaVMj/UpEUtlQscXqpzfzK1w9B3mik9U3BM9dD5F/JEUmTX0ZjQIWqNdoC2rBybYxqfLaaXQoBtIEgNhTLPJyzkHRRD3gARDTKNzId1EecCKkPbZl68BtdhhzLUd+o823fzXATUJ+jR4N8LSPWWbF9/BVd5xPPA6pPD5tpCmWwFxe/QAJbtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/PUoxBn32PWd7n75kWZDqLMLe9lxS2H1x6P5awc86s=;
 b=eTpI9NWjVKa2iqzcvmEpI5vvMohHFn52wA9okwfggXMyunhQ1cFc2Px77lmZvqLTGHln12DeJjjoJcQPU4gASHqnzNt62XfZAnmr0/FCaHEfocfWv/mMw0XmEzIsNlwTQv6LqNvhuEn7iqxoSotSnNhigR5KyCR+7EgHJC00qPq8Cj9vsQQcEcWK/S4tt9TCDpVgrjLcmPP0NNgfr0vUpTj36sIAgEwDjHymJLkXA/MpWdWF2xZObeu45fIgnb2ujk6tlX20fJ5bEhftC5J9yDsBAPl0TRdFFzOCqm7WrAIPC2bCu+BLrwEtJt88aeEXDngTffBeh8HY4vDioZlpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/PUoxBn32PWd7n75kWZDqLMLe9lxS2H1x6P5awc86s=;
 b=rLOTQIjJr6etkEBxDwiVnZv17TcJ/jsCve5csCtYNBZvht20/nanTbJiwTw7fGcnmQpIQTCpFHG+UyCkNByzB0KYRKRG4w/NpOcU1y4scxvElQCAcXJdak1SPZlWgQVjC9J56YAtOL2O1rq5cP6YDHYqM+fzN5Q0cUIJXQaEeSI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 04:49:40 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 04:49:40 +0000
Subject: Re: [PATCH] drm/amdgpu: take runtime pm reference when we attach a
 buffer
To: amd-gfx@lists.freedesktop.org
References: <20201204204130.3697-1-alexander.deucher@amd.com>
 <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
Date: Thu, 10 Dec 2020 10:19:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MAXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::19) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MAXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 04:49:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e29e30da-d24f-4f48-4fd2-08d89cc7012e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR12MB314449E9A5F260D4D7A40593F2CB0@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1PKc9kAfVpdlFYvTkOVBFFFCQIgbdPOqjAGiGHhnPU7vauJ18GNu5ymKTLxssONKf1exeoXPD/L30AGG8jOjBn96inh29VZItEf40pX4t2abwlNWO4IEvUN7xZomfGJadyK1S5aaOLtquwyvtDQbjA9srR/JxfeaphBf28EAVyMfJKPR3SC6VlBLxy5o2GWV5X6mQXZs3KOsx/aPqVdqYIeC7IG3HXbi7ekYShuvgfcYlsj3IkAD7gj48EEaDTSZc791hxu1HS8lwU1S/uYHZ0FB9CCTI5ap/wAa5iwNYSLMDrYfj39XLV3mIy4tz/fs4+hfDYD7e0TzB0MyEPRFQp4bOdr0S63rrcjp9+jh4WCVaPyUWFwWG4S5ht7WVQ42XppV6M6OFsNikxTBF2Io4dqhAbiNO2YaaMSLAbsotWFJD5fsfnkG1lvjsbVxVDMx5+GtrjUFX4CKktcVB13IwaFenEyC2Pbp7cWnIWC1Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(55236004)(66476007)(66556008)(66946007)(508600001)(52116002)(186003)(44832011)(16526019)(26005)(83380400001)(1006002)(8676002)(6916009)(16576012)(45080400002)(31696002)(966005)(8936002)(956004)(53546011)(6666004)(86362001)(31686004)(2906002)(34490700003)(2616005)(36756003)(5660300002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0pRWXloKzRSTThDWXdtR3JiNkpDZjhIczU5cnA1NThNaDJLNVFHWFJoa2Fm?=
 =?utf-8?B?OXFGdGlNdG5WUzN2WmZSQWJJMlZGYWk5Q29aYk9GSXdlNlNUWlZGU3A1NUkz?=
 =?utf-8?B?OFZDL0FEZ1prelBUMi94cEJIT0lkM1A2eHBUUWN0Z1M5ZXdJVDIyTk5MU0pz?=
 =?utf-8?B?SnhMTUR0L2pZMnduM01icGJ2M2diWGFnckljR05SUHU0VGRRNmViYm9vaGhZ?=
 =?utf-8?B?NXhId2xFV3VFTnQzVGE4NzUwZ0F1NzZCa2RpSUxuYjUyWVBhZmttcE1lTW9B?=
 =?utf-8?B?VnFScjVQV1gvNUszMVNTMXNSMExreE9oeS9LbzNybHZZVFIya2xNZHFqV0Fa?=
 =?utf-8?B?Z2x1NEhGRTJZY3hnSjNFcmhNczI5TFVJS2tIWWRkRkdtVG56WU91ZytRcXE3?=
 =?utf-8?B?STN4dTZZV2xRVU50NFh1ck15bEdEUGdTajl6ajB0eXUyclo1OFlscVM1N3Mx?=
 =?utf-8?B?RHdWSjZ2TUZLcktuejZ0NWVjeFNKaW15ek1hZFpCZlVWQjcwMEo2aVFrR3Rl?=
 =?utf-8?B?RDgvQ25IU3JxWmtiY0RSQkthM0hnSTJ0NGNOODFsRnphc3NqSjhYSE1JWVdX?=
 =?utf-8?B?OUZudFpsMGg4SUtsT3p5bk41UGRNUGlNcS94SVEybDJmUG0vQ0tsSzRPcGxY?=
 =?utf-8?B?d3ZhVDdtWGl5UWJNRlJWUFcwZVFhQnRrVmVCUVBnVHViZ0xJV2JVRnZkUFVw?=
 =?utf-8?B?em9qcit0dmVsWGJQa20rRkMxUEwxQkk2RjBlNm1QZ3FJS3ljbzNQcEszWk1M?=
 =?utf-8?B?eUcyZ2pOdGVWYnJlRnF3N0t2SEZ0Qmdsd0ozaGF1SWlwNG15NWpaMHcvMUJa?=
 =?utf-8?B?eTJSTXJoK1pGdHYyV2tEbnNZdTltQXg5ZFpCdW1ISUUvNWtsMG8vcmRmNWFG?=
 =?utf-8?B?S2owdUw3b2ZJdk5QUHRDendGM0N2ZTIzWDBXSUNjdnpXaG9DWkxsMEJ6RzA3?=
 =?utf-8?B?VW1pM1JlUjVpaXRxSm9qUXl1UHQzRDloVW1UN1hoZnBpRVJSbTNGaDBhR1R3?=
 =?utf-8?B?cXBBaXdPamtTcnpLYzFEVFdiOXo2ZXErbUNjaktkc0swbTZWa3hSVHJKM1ZS?=
 =?utf-8?B?dG83ZFN4V0NHMHBLS1g5LzRTM0lFM2x0cytyNUhaMys5bUQ3ekh3UERTRFVq?=
 =?utf-8?B?b2JZa3d3VDVXa2dLSTB6RmxtcC9Pa2lreHcrc3NSalFieWZZQVpCSzFHVE5h?=
 =?utf-8?B?N2piV2JUUzFqc2pCVUk0eGU0Y3V6c0lFL0kyV3phUGRSYWJRZzdURzRKZmg0?=
 =?utf-8?B?YVdpdXRkVS96VktZU1ZNWGFmMWNheFlibER2dnE0d0RFL0pYYStjNFZYSFBu?=
 =?utf-8?Q?wM3CruVNdf4+jWGHLqj25fi4IsI+rNnwYd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 04:49:40.3373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e29e30da-d24f-4f48-4fd2-08d89cc7012e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzT/rJtmaYRSbrnxVY/JQD2l1BxxUYQ+C6JxjCKWLRm7hHbG4QegN8V+Jd+R5LrrEj/CS0dZSdyf4TVvzpUu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 09/12/20 11:00 pm, Alex Deucher wrote:
> On Fri, Dec 4, 2020 at 3:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> And drop it when we detach.  If the shared buffer is in vram,
>> we need to make sure we don't put the device into runtime
>> suspend.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Ping?  Any thoughts on this?  We really only need this for p2p since
> device memory in involved, but I'm not sure of the best way to handle
> that.
>
> Alex
>
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 5b465ab774d1..f63f182f37f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -40,6 +40,7 @@
>>  #include <linux/dma-buf.h>
>>  #include <linux/dma-fence-array.h>
>>  #include <linux/pci-p2pdma.h>
>> +#include <linux/pm_runtime.h>
>>
>>  /**
>>   * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
>> @@ -187,9 +188,13 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>>         if (attach->dev->driver == adev->dev->driver)
>>                 return 0;
>>
>> +       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> +       if (r < 0)
>> +               goto out;
>> +
I am a bit skeptical if we should fail the BO reserve if we don't get the sync ? I was hoping to continue with it, with a warning maybe, so that it doesn't block the existing functionality ?
>>         r = amdgpu_bo_reserve(bo, false);
>>         if (unlikely(r != 0))
>> -               return r;
>> +               goto out;
>>
>>         /*
>>          * We only create shared fences for internal use, but importers
>> @@ -201,11 +206,15 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>>          */
>>         r = __dma_resv_make_exclusive(bo->tbo.base.resv);
>>         if (r)
>> -               return r;
>> +               goto out;
>>
>>         bo->prime_shared_count++;
>>         amdgpu_bo_unreserve(bo);
>>         return 0;
>> +
>> +out:
>> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

Why not just pm_runtime_put_sync ? Why autosuspend ?

- Shashank

>> +       return r;
>>  }
>>
>>  /**
>> @@ -225,6 +234,9 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
>>
>>         if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
>>                 bo->prime_shared_count--;
>> +
>> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>  }
>>
>>  /**
>> --
>> 2.25.4
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cshashank.sharma%40amd.com%7Cd5fccf427c34414ff4e708d89c682898%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637431318483043257%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NpCTY%2FVKd%2FBDi1wsFC79qSUTmNHx3nBp0HUj3m0cFeM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
