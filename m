Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3583EC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AD06108F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1AD06108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05A86E5CE;
	Thu, 26 Aug 2021 10:37:46 +0000 (UTC)
X-Greylist: delayed 80224 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 10:37:45 UTC
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557136E5D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 10:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF5mdhZ8Aq/YUo0dwWZ36/PHtUdcVJmV/nFPxWr0iuvDXPFD9LBdWt8HyWppz+vMwu+udNF9l0quNusbV1pvbraqSiLMRaACYwsbfyvv/LPLzLMFvW848hTr4zNi6kEEIPu2qDIpx2CH2rI//ezHAfc6NZDr2JNfDKtVBjb2jKiJeH4+Xtpvmofve+6BAGkD3cs2X1fOqC7Fr03lr3op62tAwjo5uYW7IVUr4s0MnodqFbnG/vB+XlMmgabqBZcpkXLsEo4RC7oTDzzOb9WulKh6GrGD5Gz2zA6nQP2PKp4Fl+RudU/B5EkT0m1LARA2I0YRC2w8KEVOrF7mWgPvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+8/CKV0UD3A0EI7FTOVJPyLmspCJH4PLJfuYrQMagM=;
 b=TVlPK0vU9uETLWfkQvH2gSmLYMjpNwyTXJi+u64Ga1AcqpydhlYX3vXibTy87rMF5Up2pnpEDzKLdoBWS91bz3Z7nTMJd25aAcjSH79J4ywPLFIsfqV1stArzZT3L/ZB2FnaIqr7pR6XbIZS8kBkGPnpt5ztZxpE0pv8f0UWyFXUnilqAXUJU61Ju1AGm0Bii+PMNyyCV2y8iqaqnggog+EXWYN4fsP4fbcfVyFN83vmh0bbp/4XzdQ5leVvPxvhN6pm5maZ1wqfX59hz17ZubOWnkZ3/o+RwwTIPohzTmIUZHOlOdsFiXcMZalo/HDXvw078x8G/7ZJsItjVM8G3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+8/CKV0UD3A0EI7FTOVJPyLmspCJH4PLJfuYrQMagM=;
 b=QPksjdJAcwalkQxStGECK2nsAAVr/yZGTcgA1viuYBs4ILJspE3WnlJOonPnqxyHawHR+BG5KeCawuc3OjVp7j4A5x60hNJIBqGB4mQ/TfEeV377zH4L/5qTpFa9/17toS9DJnbx7VJrhSukn2XWCNdLTaXbP5x/nQr+DmA/D/I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 10:04:02 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 10:04:02 +0000
Subject: Re: [PATCH V2 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
To: Koba Ko <koba.ko@canonical.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210826013523.394705-1-koba.ko@canonical.com>
 <20210826013523.394705-2-koba.ko@canonical.com>
 <b95b0e84-8fbc-bdd9-2079-a2dd84dff70f@amd.com>
 <CAJB-X+UBwqYSgm57B+1hhWJYNYoqwPPQrOP+i+cih+qZ8pn4Gg@mail.gmail.com>
 <CAJB-X+VR_au36vPyrph8jEWrkF9zk0Z3kuW-PONTWox=CqTfRQ@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <7e5acf6e-7298-0ed0-5a45-3aa187193241@amd.com>
Date: Thu, 26 Aug 2021 15:33:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAJB-X+VR_au36vPyrph8jEWrkF9zk0Z3kuW-PONTWox=CqTfRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::23) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19 via Frontend Transport; Thu, 26 Aug 2021 10:04:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34686790-05de-4946-96f8-08d96878d44f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB533580A5A8102D10252179B297C79@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b28a1ARaA3C2AQXdnHqOq4lyQgwMlobtxrs0Z1aKbl1jQSVIxpfmINXyOaj9oC5XcfgIUVrpvdSHVRFjAmz9anQbYh8zgwIXwMPuZ9staYU6YF9wmKXrq9Oej0N7e7Dvr0LyxBOB5MDf5UlvnB0vAMwF2x1vF7FR/MwNb263XHUYW8Y6h6rVQlYkA1mN6Yo3ZuMbq7tb3u4Om66yEPl1SYIJ02XOCGwDWne4Qo9oHMGSV5YPanVF4ZKPPN5klr0FREPCoQLVD+MMqY1Xw1dplNNyjWivUVojIXgCg8Efca/IgF8xwWtbsSJQuzMVkI+gm9xS/LlgB87eHJmIkyQILAlGPvL6VPVoAKl+WNHRs4Nj2/zVpcGiSDtHLn8ZQt7W6DPHucSmpNr/UtsdyKr4pfugnVXhV36663Vq5M4aEUslaTGBhPZUmAq9AtVvq50ar2fIty0Ar5llOPwW0qIgFEq5Q/ehj6BeIuU1KUeMlHH96iMKJsOsMKmRfzIdvJjM7WK2jlU+vuMxUmMoadNTaM9pAoVWPBSpfKKRONRdqo2E1AR3YVNIRLCn7eJPkoqkmjYgF6rMdFoKSkqQRqaaiw4/gkqE4qSl9oDdSf/zu+aVGabvGqDl5Tgi/57xs3Em++RwLFT62va73/Kz8bgkBP7UMNiNzitVTrrAjW105MRc4qo0AxvU/+8qzsBYQEIuguld3Uh+D+LgggEMDt4c60Bu9zNPP0SSOsTZvGgg+Xg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(966005)(2616005)(956004)(6916009)(2906002)(31686004)(16576012)(8936002)(316002)(31696002)(8676002)(4326008)(53546011)(5660300002)(26005)(186003)(66556008)(66946007)(478600001)(66476007)(45080400002)(6486002)(38100700002)(83380400001)(6666004)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9PNjNjQTdpRkhta1AxR01nSS9naXRaVUNHWmlQK2QwTGRLd3Q3VWJvQzJC?=
 =?utf-8?B?WVNEanpvNmh2MFJab2lXbFBSY3NIR29BSU92ZjhheXBNNll6Z0VqR21TYTBL?=
 =?utf-8?B?Mm5rM1ZPejREVndCTWNFV2Vlb3c5c0s2ZGdxRjFUVkpmcE1GUENjMXlMdno1?=
 =?utf-8?B?UzcvZjNqV0llNWd5UTViVjVrU0FhUFFzM25uVVByeGlWa0J3WUdRRmUxR0xX?=
 =?utf-8?B?UnlEQjM1Rlk5bTJ4MTE1Q3lFOXRzWkp1b01BbGI5azh2REhzcFRHV0h6Ni9L?=
 =?utf-8?B?MzBYcDl6N0tsZnpxSWE1a29KV0xuRzFtdHR4T2NDNTUvbHAwNFp0WUV4ZTFP?=
 =?utf-8?B?T3IxMEhaOTgvSmRpV0hNdGMxZmRuNkQyMllzc3c1MXZiNlJNWThhNlVxakt1?=
 =?utf-8?B?NUU3VmZCczJzYkRvaE5Fem1wNDlkR2hnR2NncGFSODNNRmd0V3JZbzRIVTdM?=
 =?utf-8?B?UWpQMXRXd1VUTUlCNEExTHZWSk14OW40RHk1K2RCR2NYWHJJMjQ3Y1BsV1FM?=
 =?utf-8?B?MURxT2xjNWIwMUdZMGtaM3lQUlJoSXZQTDgrQm9mKytrdFIvUzhNL0tvOWRl?=
 =?utf-8?B?UlVINTB3Mi9tcEgwdTNmalFIaW83L3JXNXhZUVBpbzU5dm9IZ0hia1p1NC9x?=
 =?utf-8?B?UWRLUzRBTmVOVll1d1RSOWpWcm5kSmt5ZE1tQXVjSzQvbnQ4dWkxUHBicXZx?=
 =?utf-8?B?WnFxbHFhcktUTlRkMlR3UWxza2pJQVpaUGRWL2FyM3p4am10U0s1ZURNeUZ6?=
 =?utf-8?B?anVRTklCSkxBQWI5TDNnaEtFYnlMT1BtclBNMWJ0N2Y0MEE3WTgzOVJVdlo5?=
 =?utf-8?B?YzhkZ2J6SlNRZWZMUlVMQ0V1Z1dNSXQ1ZEo4ZXZvZ3dmQ1hKeFNYVVRSTWlr?=
 =?utf-8?B?bFljd3ZnZThTSm5WSWZ5QWNZY29IVDRqR1FIei9uZENTNmtVS0orNkVSbExh?=
 =?utf-8?B?RkVpcEYvZXNUeTFPVjhseU4xU05hT3dNUy9zRVEzamZ3M2R4amw4QmhXYjRs?=
 =?utf-8?B?UWNlVFJodzhKbFZ3Wmx5ek1XZk1BTkNoK0ZEcXBWR0ZoZ2JyUU1IMGQ1Zmha?=
 =?utf-8?B?dTdyTGcrSkdFMTNzUEI2RGVlRU5hS2xaNWZOU1VBTTg4QStLZkUxYUk3dTNW?=
 =?utf-8?B?ZEhBZnRmWE12U0ZyZkU1b3gvMTB5NjJ2Z1JIUVpYQ3N1MGNzK1ExaUNQZ2kr?=
 =?utf-8?B?cGhpSE1FREpxRlBoY0Z4QXNrMGFnUUtzODYzSWJJeE4xS2hxWTFueXFIbHhs?=
 =?utf-8?B?ZEM1TytVZVROMmJSVmxiTGNhMWFwcmZpZmdudEtPSXdrVVhFRHg2dEVxVFRn?=
 =?utf-8?B?TDBIQlZ1VGh5WXRoSE8vZVpVV0Q1L1VlcUZPd29XTDlkaEh3N0VnUGJyNEZ0?=
 =?utf-8?B?TVdSeE1mTEtGcXhhemRjenRGbW40S2w4ZWo2cHZvdkRrU3ZJTHg2N0tvTDlm?=
 =?utf-8?B?bVBCRmVxWUFqNjQrTmMzd2E2RytXV0dDQWxPZk5kZHRZd1VZQWRMR0JCZTNp?=
 =?utf-8?B?dEtxaXE0cHIyd0FTYTZncFZ0aGk1VXk5SFI4ZTBLWGxqbFF5VXVlTUJKaXBV?=
 =?utf-8?B?Nmh0UFF6eFNuenhGVVcwZHlkVHpTemJJS3pSMytXbTlJTlNQdVdRS0FTT1ND?=
 =?utf-8?B?SzVrbG9KZnMxc0g2QXFJTVA3dGRhNDBlMFd4Z0dEZ2dXa0lHZnVaaXpnQ0dX?=
 =?utf-8?B?NmVqRTJxZmMxRUJnbUQwSmQwQ3dtVzlPc1EzaEJnSVo1M001U1dEKzBPajJU?=
 =?utf-8?Q?RA5RUG8yfboxCe+RCQSuIYkhnaHFc7fLcJfbm/k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34686790-05de-4946-96f8-08d96878d44f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 10:04:01.8310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igvJVnKNues7hjJE3XCNyhTrr4GqbvmVeAT0qNwNXTKyYRjPDsELNGJCsjeitNDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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



On 8/26/2021 3:24 PM, Koba Ko wrote:
> On Thu, Aug 26, 2021 at 5:34 PM Koba Ko <koba.ko@canonical.com> wrote:
>>
>> On Thu, Aug 26, 2021 at 5:07 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>>
>>> On 8/26/2021 7:05 AM, Koba Ko wrote:
>>>> AMD polaris GPUs have an issue about audio noise on RKL platform,
>>>> they provide a commit to fix but for SMU7-based GPU still
>>>> need another module parameter,
>>>>
>>>> modprobe amdgpu ppfeaturemask=0xfff7bffb
>>>>
>>>> to avoid the module parameter, switch PCI_DPM by determining
>>>> intel platform in amd drm driver is a better way.
>>>>
>>>> Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
>>>> Ref: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Famd-gfx%2F2021-August%2F067413.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C86f18ece04774ed787e408d9687784a3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637655684803425194%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6dRblodTvF5XDlRDFtYwVDv6Go2eAd9R9q%2B8hfy6lsY%3D&amp;reserved=0
>>>> Signed-off-by: Koba Ko <koba.ko@canonical.com>
>>>> ---
>>>>    .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>>> index 0541bfc81c1b..6ce2a2046457 100644
>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>>> @@ -27,6 +27,7 @@
>>>>    #include <linux/pci.h>
>>>>    #include <linux/slab.h>
>>>>    #include <asm/div64.h> > +#include <asm/intel-family.h>
>>>
>>> Maybe, include conditionally for X86_64.
>>>
>>>>    #include <drm/amdgpu_drm.h>
>>>>    #include "ppatomctrl.h"
>>>>    #include "atombios.h"
>>>> @@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
>>>>        return result;
>>>>    }
>>>>
>>>> +static bool intel_core_rkl_chk(void)
>>>> +{
>>>> +#ifdef CONFIG_X86_64
>>>
>>> Better to use IS_ENABLED() here.
>>>
>>> Apart from that, looks fine to me.
>>>
>>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Thanks for the comments.
>> I will send v3.
> 
> Should I nack v2 after sending v3?
> Thanks

v3 supersedes v2.

My comments are not major that I want to see the patch again after fixing :)

You may fix it before submitting or send a v3 so that others take a look 
as well.

Thanks,
Lijo

>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +     struct cpuinfo_x86 *c = &cpu_data(0);
>>>> +
>>>> +     return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
>>>> +#else
>>>> +     return false;
>>>> +#endif
>>>> +}
>>>> +
>>>>    static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>>>>    {
>>>>        struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
>>>> @@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>>>>
>>>>        data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
>>>>        data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
>>>> -     data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
>>>> +     data->pcie_dpm_key_disabled =
>>>> +             intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
>>>>        /* need to set voltage control types before EVV patching */
>>>>        data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
>>>>        data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
>>>>
