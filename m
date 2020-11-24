Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C3BC56201
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 07:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20806206B2
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 07:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FqnVaViJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20806206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0B26E1FB;
	Tue, 24 Nov 2020 07:56:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C016E1FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 07:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLwu8Wlzf+4bVCn3juGc+tjwkmA6gpH3+p1NInF2/GJfEzaz4Q0D8dMETMEYbp+cY6qXdxupyvBsTZlaJJJuuqcD6uy5V7Cu45k/jgXSb8KqpRLHoBoy5VHzv35uRLMmIUDt6wIUotYZ8zCI3UEg3SOTTGXOJNy28bQy+oQI4NDRrETWa4N0x/6DkRgKBV1iKCtknWlonXoKzsAxxw+/gwFihREDMWX/ZHjOS21C3N66F1RWdg8Eu/a+elR9gn3nLhgrn2x7IyBtzaqmuQC+q0ZEdzECIP/2yLmbA9T4MdlnWWmIN7clPJ8Nkc3BuOS0Ct40WG2rZpgLX+hOEbfMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nWfTx9NKCAXhOjNDZKpHLlXTFk0WZHfImUEdu1uQr4=;
 b=LxJ5afwWj1qsi7dsOKwsPt+CUg13sa9uMS3pKf++EdScJVQf8vNvOPOdwNGHWe0ez+BatuYQYq8b1kU5SIqD4kBq9nBUvmgW79uRw43VeraiM3e0coJgiut8qfuKtUURWgGa6OZG4P5tWDeMVgbpYD4bvu5y+pTieoGgGbQdZXj/3PIplK5oW6GCmgl3FdbI4iobIaKUE29H27xXGSCJJ5qVguiBEScZqgnKRtJcDp7FvWlrDiLEc81rzVO5rN+34onOEX/y/4Yp1YlLrcHrhPUghrbyfBif9Gbk+6DhBipzZh9PBKAD4Gb42YyB20d9hdcjWNcJyd2CxUwB3h2+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nWfTx9NKCAXhOjNDZKpHLlXTFk0WZHfImUEdu1uQr4=;
 b=FqnVaViJv1H4JxY32MU1Y7Uk2y8yLRstdKVabiwgtrthO7v4OSHAFCf9REj6K87vI5z+Phq+V4yTlqslNDCvLGGMW93sbWUndxzEz0kaUw55tMpAiG2VZaRLrH5fiDNsVXh+Rf/Y15L/c5iGcyEusApIHv5uUtPhvKfn8pEVHo8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Tue, 24 Nov
 2020 07:56:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 07:56:38 +0000
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20201118132039.2336-1-christian.koenig@amd.com>
 <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
 <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
 <53b5d31f-e533-0fb3-0907-76d2f3730af3@gmail.com>
 <CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=HqinJAOupSw@mail.gmail.com>
 <8c9a2e5d-fbfc-45b9-f0de-92e292fcb7e7@valvesoftware.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <575332de-fb65-7122-f68a-1ab2e89c1adc@amd.com>
Date: Tue, 24 Nov 2020 08:56:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8c9a2e5d-fbfc-45b9-f0de-92e292fcb7e7@valvesoftware.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.21 via Frontend Transport; Tue, 24 Nov 2020 07:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f29e290-75c7-4a20-6bac-08d8904e791a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2545FC3946D6625AB445886F83FB0@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFhhe8QIichJcKebeHopcsbR7YUVuEPgtUhb1gGfoBOMKW5Bcus+YsQFN6fA0nt0EAt4bfCfDyM8A67KHA7jaRa3+bKqhLEMfHLi8DVbC7gA8j38aDetmFXYvLQMSSBM7+/2dp29G4AT9Rx1SACkZGJT4PcYutDkkVlUCa34KymdS+3hBOoofY6L97dpHcxSU1XY9C/beKgcqsrYoTUlHUMfjtf7K/ZZai2UbdJ+NMLJkMu2V3icWq3ZnVt0fcVqv2d8ZyvGWLnmVKLSyL1kQSJqPpHB7440VACb3HBxMgo4+vro8Cr+GRLd4JWvQaBmjXwg8LN/ID5zryrJ8uCIu5moflEcUgUfy/oWBGBW/KQzPlv/jFri9FROuqBzX99LEmPM3J/4JSSFIQuunqTjQzqCGKk824Qfrm8SHbD+JTlKJUgu4YuBaK30PaaHGYHWIOPyzYOq0AdIOeQM46hOnuJww90VP3F5GhPVo3iD1WN8PvYEdupPDWu2Hsmaam+bI2NR4mvVgWMeqKToQ5xZ68+p969M3MsAtOLbFsf4thJHqw0oIKeSM+D7Ox65cayN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(86362001)(6666004)(8936002)(2616005)(54906003)(36756003)(33964004)(83380400001)(31686004)(966005)(110136005)(45080400002)(66574015)(4001150100001)(6486002)(66946007)(316002)(31696002)(66476007)(16526019)(186003)(2906002)(52116002)(5660300002)(166002)(478600001)(66556008)(53546011)(4326008)(8676002)(43740500002)(15519875007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXZjVTh5SXRVK05nWmZPbFZ5YmhpVVFxUDR2aUVGeWFhOFB5RE40ZllDWUZU?=
 =?utf-8?B?eWVxdjIxblNjWVdMSEV0NVJDOXc3SkpPZThCMXZKN1BkZmNabGtTVUJwMmRr?=
 =?utf-8?B?RENlbmdBYkRFMlUxWlJtRjFxckU0U0pRRUFwVEE1QmJnd2tGdy9kZkJub2ND?=
 =?utf-8?B?NDBSb3NCMGVET01WVTJ2bk5JdHZOKzFtVmlpL2I4NGpzRlZsRUhTcS9kVmNs?=
 =?utf-8?B?eGtFcTNNWElMZy9HcSszK0FDL3laQVJUa0RyNFpKVVRMWDF0aGNmSGxMNlRU?=
 =?utf-8?B?MlV6YWRqaGlhNjRuTnRKZmM4UCtxTUhPd1krQjNIaW9ueDhTU01JR3dVd0FN?=
 =?utf-8?B?TTFQYjY1YjRBSFRMWGpHQVVnUGdwRENWZi9yMWpmOWhlUDlBMmxwN1BLOXZE?=
 =?utf-8?B?U00rTnllUjk3Rm1McDFCaVhYTTJYU3JXekJIeDFoRCtpMDU2QXBmdU51TGty?=
 =?utf-8?B?MW85WDRhSXFyK0JEbjBscXdIOWdYOTc0NmZ2NCsyTG92eWVLQkdNSE9KNkY3?=
 =?utf-8?B?SUpHclYvU0p1ZXJBa2JtTFMyTmdwQ0tyQzN6cFdaYUdWcENzMVE3blZ0bXhz?=
 =?utf-8?B?SjRScDFKZ2RaMUhMaVJRT2FnNGhxN0RXRVFIbjdBK2tWQklINE1NZ1BWNXE4?=
 =?utf-8?B?K3pWSGhwaW9YeDJkSm50NW1ZQWxoWnRHbTBnek0vdjdKSWI3bTc5alFMNmZi?=
 =?utf-8?B?anBkdGZBTDhEa3BwRUc2NEZ5eWE4R1pCWEU0ZUJtRytFS2YzS2dKdTgwM3l0?=
 =?utf-8?B?S0FscEF3NFhMOS8yOUNrUzVQTE8yOWg0L3pXa3RqR3VWbmNJL0kzRXArQ0pS?=
 =?utf-8?B?UUhDMnQwaGpBc21QTEtocEhmbE9DZ3ZxbkczU2RRVEJYb1pWbktuZnpYRFVP?=
 =?utf-8?B?UEU5dFZFS05Da3dWbUIrdFgrM28yUHRmY3crRXdPdlgyY1A0ZVdKOVROQTA5?=
 =?utf-8?B?eG1JcnlCcTJnTXIxNldzbkovb2V6UnVIWXZGU1BYVThXTHhFMnhyeXp1ZFNN?=
 =?utf-8?B?OVNTT3pmalVmcXhaRnZLNVorVDhQWGJMbUFRL2VZTTRBcUZDMTMwTGZqZHIx?=
 =?utf-8?B?TEgxdUw1dDBlTmtGZnV2TDBmem03WWZ4V1hNa0MyMjF4c1pPcGtpMjdBVlZJ?=
 =?utf-8?B?enUxSWZmaXlUZjh0ME1sVXpEZ1VBN1hNek5XcisxcXlNVjYrQ3UvNG5VMmxp?=
 =?utf-8?B?eTNpS0xiZ3V5My9ySzRQclZZYzFLZFRRTlVXdk1lOXNkbksxYXU0WTdwYUpX?=
 =?utf-8?B?b2locnF3Zk8rTG1DVFJlNDhocjlqNnF3eFBPakVJUnBaNVA2b3h6QXI5bWJN?=
 =?utf-8?B?L1htakVMVi9RNkcxNGU4YmhKUWs3OElHZWs5Q29GbWJ2am4xcktQeXF5d0c0?=
 =?utf-8?B?OXg3MG04UG1mbXYxQSs1bFIyb1B4dkN5a2JBRURCZzU2NVRZNFRoZDNGMDBp?=
 =?utf-8?Q?s7/X1mfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f29e290-75c7-4a20-6bac-08d8904e791a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 07:56:38.8887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPnE/QzFiiGF3+fQzAm76ZYO6L41rOvIAN5JVxETf0z+/OBlkOhYWodxQhEgF9a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
Cc: Pierre-Eric Pelloux-Prayer <Pierre-eric.Pelloux-prayer@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1289596499=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1289596499==
Content-Type: multipart/alternative;
 boundary="------------6E3132DD74CCD8A9F8CE212B"
Content-Language: en-US

--------------6E3132DD74CCD8A9F8CE212B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Mhm, then I don't know what's going wrong here.

Could be that the fence somehow ends up in a BO dependency.

Pierre do you have some time for testing today? Or could you provide me 
some way to test this?

Christian.

Am 24.11.20 um 03:48 schrieb Pierre-Loup A. Griffais:
>
> I just built my kernel with it and tested Horizon Zero Dawn on stock 
> Proton 5.13, and it doesn't seem to change things there.
>
> This pattern looks identical as with before the kernel patch, as far 
> as I can tell:
>
> https://imgur.com/a/1fZWgNG
>
> The last purple block is a piece of GPU work on the gfx ring. It's 
> been queued by software 0.7ms ago, but doesn't get put on the HW ring 
> until right after the previous piece of GPU work completes. The orange 
> chunk below is the 'gfx' kernel task executing, to queue it.
>
> Thanks,
>
>  - Pierre-Loup
>
> On 2020-11-23 18:09, Marek Olšák wrote:
>> Pierre-Loup, does this do what you requested?
>>
>> Thanks,
>> Marek
>>
>> On Mon, Nov 23, 2020 at 3:17 PM Christian König 
>> <ckoenig.leichtzumerken@gmail.com 
>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>     That the CPU round trip is gone now.
>>
>>     Christian.
>>
>>     Am 23.11.20 um 20:49 schrieb Marek Olšák:
>>>     What is the behavior we should expect?
>>>
>>>     Marek
>>>
>>>     On Mon, Nov 23, 2020 at 7:31 AM Christian König
>>>     <ckoenig.leichtzumerken@gmail.com
>>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>
>>>         Ping, Pierre/Marek does this change works as expected?
>>>
>>>         Regards,
>>>         Christian.
>>>
>>>         Am 18.11.20 um 14:20 schrieb Christian König:
>>>         > This allows for optimizing the CPU round trip away.
>>>         >
>>>         > Signed-off-by: Christian König <christian.koenig@amd.com
>>>         <mailto:christian.koenig@amd.com>>
>>>         > ---
>>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
>>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
>>>         ++++++++++++++++++++++++
>>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>>>         >   3 files changed, 29 insertions(+), 1 deletion(-)
>>>         >
>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>         > index 79342976fa76..68f9a4adf5d2 100644
>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>         > @@ -1014,7 +1014,7 @@ static int
>>>         amdgpu_syncobj_lookup_and_add_to_sync(struct
>>>         amdgpu_cs_parser *p,
>>>         >               return r;
>>>         >       }
>>>         >
>>>         > -     r = amdgpu_sync_fence(&p->job->sync, fence);
>>>         > +     r = amdgpu_sync_fence_chain(&p->job->sync, fence);
>>>         >       dma_fence_put(fence);
>>>         >
>>>         >       return r;
>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>         > index 8ea6c49529e7..d0d64af06f54 100644
>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>         > @@ -28,6 +28,8 @@
>>>         >    *    Christian König <christian.koenig@amd.com
>>>         <mailto:christian.koenig@amd.com>>
>>>         >    */
>>>         >
>>>         > +#include <linux/dma-fence-chain.h>
>>>         > +
>>>         >   #include "amdgpu.h"
>>>         >   #include "amdgpu_trace.h"
>>>         >   #include "amdgpu_amdkfd.h"
>>>         > @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct
>>>         amdgpu_sync *sync, struct dma_fence *f)
>>>         >       return 0;
>>>         >   }
>>>         >
>>>         > +/**
>>>         > + * amdgpu_sync_fence_chain - unpack dma_fence_chain and sync
>>>         > + *
>>>         > + * @sync: sync object to add fence to
>>>         > + * @f: potential dma_fence_chain to sync to.
>>>         > + *
>>>         > + * Add the fences inside the chain to the sync object.
>>>         > + */
>>>         > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
>>>         struct dma_fence *f)
>>>         > +{
>>>         > +     int r;
>>>         > +
>>>         > +     dma_fence_chain_for_each(f, f) {
>>>         > +             if (dma_fence_is_signaled(f))
>>>         > +                     continue;
>>>         > +
>>>         > +             r = amdgpu_sync_fence(sync, f);
>>>         > +             if (r) {
>>>         > +                     dma_fence_put(f);
>>>         > +                     return r;
>>>         > +             }
>>>         > +     }
>>>         > +     return 0;
>>>         > +}
>>>         > +
>>>         >   /**
>>>         >    * amdgpu_sync_vm_fence - remember to sync to this VM fence
>>>         >    *
>>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>         > index 7c0fe20c470d..b142175b65b6 100644
>>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>         > @@ -48,6 +48,7 @@ struct amdgpu_sync {
>>>         >
>>>         >   void amdgpu_sync_create(struct amdgpu_sync *sync);
>>>         >   int amdgpu_sync_fence(struct amdgpu_sync *sync, struct
>>>         dma_fence *f);
>>>         > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
>>>         struct dma_fence *f);
>>>         >   int amdgpu_sync_vm_fence(struct amdgpu_sync *sync,
>>>         struct dma_fence *fence);
>>>         >   int amdgpu_sync_resv(struct amdgpu_device *adev, struct
>>>         amdgpu_sync *sync,
>>>         >                    struct dma_resv *resv, enum
>>>         amdgpu_sync_mode mode,
>>>
>>>         _______________________________________________
>>>         amd-gfx mailing list
>>>         amd-gfx@lists.freedesktop.org
>>>         <mailto:amd-gfx@lists.freedesktop.org>
>>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>         <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C4b90eb41edd04592bd4f08d89023653b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417828990103282%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=wHx40e8opSOOIndSVMBaPuMarMpA%2FnDRxl%2BI5BV210s%3D&reserved=0>
>>>
>>


--------------6E3132DD74CCD8A9F8CE212B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Mhm, then I don't know what's going
      wrong here.<br>
      <br>
      Could be that the fence somehow ends up in a BO dependency.<br>
      <br>
      Pierre do you have some time for testing today? Or could you
      provide me some way to test this?<br>
      <br>
      Christian.<br>
      <br>
      Am 24.11.20 um 03:48 schrieb Pierre-Loup A. Griffais:<br>
    </div>
    <blockquote type="cite" cite="mid:8c9a2e5d-fbfc-45b9-f0de-92e292fcb7e7@valvesoftware.com">
      
      <p>I just built my kernel with it and tested Horizon Zero Dawn on
        stock Proton 5.13, and it doesn't seem to change things there.</p>
      <p>This pattern looks identical as with before the kernel patch,
        as far as I can tell:</p>
      <p><a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fimgur.com%2Fa%2F1fZWgNG&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4b90eb41edd04592bd4f08d89023653b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417828990103282%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9GgRTJGEvsilDAKk%2BAmMsOYtkaV6KDQvW%2B%2ByZ%2BjNoVk%3D&amp;reserved=0" originalsrc="https://imgur.com/a/1fZWgNG" shash="fjxcl2lQPlDhPxkxjqbnhCKpKxeIFE3SWb6jZu+GyS6Z+iqx9FCHR+axtP4fvW+QSKrpK4+sLhPZs1HlyV/sudPTOi4vS9KRgbJLorAgWuRBD78Mp1mDD0M9SKn9d2UVTrNFjJfJJP0VYVd24KKYUmqbuCf2Aoeao9jVwx+Es3I=" moz-do-not-send="true">https://imgur.com/a/1fZWgNG</a></p>
      <p>The last purple block is a piece of GPU work on the gfx ring.
        It's been queued by software 0.7ms ago, but doesn't get put on
        the HW ring until right after the previous piece of GPU work
        completes. The orange chunk below is the 'gfx' kernel task
        executing, to queue it.</p>
      <p>Thanks,</p>
      <p>&nbsp;- Pierre-Loup<br>
      </p>
      On 2020-11-23 18:09, Marek Olšák wrote:<br>
      <blockquote type="cite" cite="mid:CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=HqinJAOupSw@mail.gmail.com">
        <div dir="ltr">
          <div>Pierre-Loup, does this do what you requested?</div>
          <div><br>
          </div>
          <div>Thanks,</div>
          <div>Marek<br>
          </div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Nov 23, 2020 at 3:17
            PM Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div>
              <div>That the CPU round trip is gone now.<br>
                <br>
                Christian.<br>
                <br>
                Am 23.11.20 um 20:49 schrieb Marek Olšák:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <div>What is the behavior we should expect?</div>
                  <div><br>
                  </div>
                  <div>Marek<br>
                  </div>
                </div>
                <br>
                <div class="gmail_quote">
                  <div dir="ltr" class="gmail_attr">On Mon, Nov 23, 2020
                    at 7:31 AM Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                    wrote:<br>
                  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">Ping,
                    Pierre/Marek does this change works as expected?<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 18.11.20 um 14:20 schrieb Christian König:<br>
                    &gt; This allows for optimizing the CPU round trip
                    away.<br>
                    &gt;<br>
                    &gt; Signed-off-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                    &gt; ---<br>
                    &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; &nbsp;|&nbsp; 2
                    +-<br>
                    &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
                    ++++++++++++++++++++++++<br>
                    &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |&nbsp; 1
                    +<br>
                    &gt;&nbsp; &nbsp;3 files changed, 29 insertions(+), 1
                    deletion(-)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; index 79342976fa76..68f9a4adf5d2 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; @@ -1014,7 +1014,7 @@ static int
                    amdgpu_syncobj_lookup_and_add_to_sync(struct
                    amdgpu_cs_parser *p,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return r;<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt; -&nbsp; &nbsp; &nbsp;r =
                    amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, fence);<br>
                    &gt; +&nbsp; &nbsp; &nbsp;r =
                    amdgpu_sync_fence_chain(&amp;p-&gt;job-&gt;sync,
                    fence);<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;dma_fence_put(fence);<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;return r;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                    &gt; index 8ea6c49529e7..d0d64af06f54 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
                    &gt; @@ -28,6 +28,8 @@<br>
                    &gt;&nbsp; &nbsp; *&nbsp; &nbsp; Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                    &gt;&nbsp; &nbsp; */<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
                    &gt; +<br>
                    &gt;&nbsp; &nbsp;#include &quot;amdgpu.h&quot;<br>
                    &gt;&nbsp; &nbsp;#include &quot;amdgpu_trace.h&quot;<br>
                    &gt;&nbsp; &nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
                    &gt; @@ -169,6 +171,31 @@ int
                    amdgpu_sync_fence(struct amdgpu_sync *sync, struct
                    dma_fence *f)<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
                    &gt;&nbsp; &nbsp;}<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt; +/**<br>
                    &gt; + * amdgpu_sync_fence_chain - unpack
                    dma_fence_chain and sync<br>
                    &gt; + *<br>
                    &gt; + * @sync: sync object to add fence to<br>
                    &gt; + * @f: potential dma_fence_chain to sync to.<br>
                    &gt; + *<br>
                    &gt; + * Add the fences inside the chain to the sync
                    object.<br>
                    &gt; + */<br>
                    &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync
                    *sync, struct dma_fence *f)<br>
                    &gt; +{<br>
                    &gt; +&nbsp; &nbsp; &nbsp;int r;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp;dma_fence_chain_for_each(f, f) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (dma_fence_is_signaled(f))<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;continue;<br>
                    &gt; +<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r = amdgpu_sync_fence(sync, f);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (r) {<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dma_fence_put(f);<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return r;<br>
                    &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
                    &gt; +&nbsp; &nbsp; &nbsp;}<br>
                    &gt; +&nbsp; &nbsp; &nbsp;return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt;&nbsp; &nbsp;/**<br>
                    &gt;&nbsp; &nbsp; * amdgpu_sync_vm_fence - remember to sync to
                    this VM fence<br>
                    &gt;&nbsp; &nbsp; *<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                    &gt; index 7c0fe20c470d..b142175b65b6 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
                    &gt; @@ -48,6 +48,7 @@ struct amdgpu_sync {<br>
                    &gt;&nbsp; &nbsp;<br>
                    &gt;&nbsp; &nbsp;void amdgpu_sync_create(struct amdgpu_sync
                    *sync);<br>
                    &gt;&nbsp; &nbsp;int amdgpu_sync_fence(struct amdgpu_sync
                    *sync, struct dma_fence *f);<br>
                    &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync
                    *sync, struct dma_fence *f);<br>
                    &gt;&nbsp; &nbsp;int amdgpu_sync_vm_fence(struct amdgpu_sync
                    *sync, struct dma_fence *fence);<br>
                    &gt;&nbsp; &nbsp;int amdgpu_sync_resv(struct amdgpu_device
                    *adev, struct amdgpu_sync *sync,<br>
                    &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct dma_resv *resv, enum
                    amdgpu_sync_mode mode,<br>
                    <br>
                    _______________________________________________<br>
                    amd-gfx mailing list<br>
                    <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                    <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4b90eb41edd04592bd4f08d89023653b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417828990103282%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=wHx40e8opSOOIndSVMBaPuMarMpA%2FnDRxl%2BI5BV210s%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="xpxE/e8BBF2CgWMJeAAYsTY9C3Bcx9TWRUNAY3Z4mTv0R+mpp82lp4dQIV/2GroekfXfwgCURj1mOZjgd3L19S7ND6Fz0kkN33+W1ieirsReq158EC4Jmwcy4/s0M8OdBrZt0S6eiwgGFgTgqvQomTfdz+ZV6Q2G9izPVnSsZzk=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                  </blockquote>
                </div>
              </blockquote>
              <br>
            </div>
          </blockquote>
        </div>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------6E3132DD74CCD8A9F8CE212B--

--===============1289596499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1289596499==--
