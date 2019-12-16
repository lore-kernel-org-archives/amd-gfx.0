Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5665BC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 16:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262CB206E0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s95CAgtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262CB206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E471B89B46;
	Mon, 16 Dec 2019 16:50:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 597AC89B46
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 16:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2sMSPx5RgpJEhm/H/2KIKkt3+AO2NPG+upk+QojPT4qnNFJv7BFGGhXadGMSOQYt5CLcZalrntEqaLlJnZ8BYU71xprf+aUvskWFAA6PRSIKaog3Ny9O+MMJQUcnnV4bySN4W6G5WA2X7xjVK8Nbu6lltlaf90xkReeZcKZYi3W5OuIZH2ymRemxFBIygwrP2aistuejNyWwRkuTfnGgZbunP33HCMP1dxMFinwUpYvT+VDUovqcLnQ1bY5m9Af2G1QSSJ3j6NZdcYoJ12HGrbM/CrnoE4RDovLoK+6MG7EObd6Y0pl82qrkx5CxYO2NMVlNOhWg7j32jSnN1LIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sZvZ1J/33BGeoNJXo6+ALBfrFB89LGnUw2XRkbtQeY=;
 b=AJ/RnL+5+9NuJTbrkQDXVfDUfqQLwdVMGcXjDuZFIIKtbnlZgY0Rn0A7nYSINvFHmYLP/dJUD5WqeiMCrOkm4GhX1hDge8De+ktUQZLHNmHO16+rKXraAjraOh1Mm1gImhbuYFJ/bdtLOeDY4uu2qrxxQw/TdKB1EDSNX/QI88jdHbtJJNx2uuORtA7LQGm6lfllFAkveignAoLno9aJPPDiD5EVTL7vPUycoNBtbV6XDGYhvIwdqgIVwZ6IZX5z/JE/WLTN7yQw/baNNc5Ercs//MjIJfBkZDVIYou8P5uz6wEB5P6Bsrugo7E59o859Qjm03laGzJhywqQYmju6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sZvZ1J/33BGeoNJXo6+ALBfrFB89LGnUw2XRkbtQeY=;
 b=s95CAgtWa2tPHO8C/+mvfYJcav0cFygTutizxDtpzVnA0BBbfj4isS4HzYxv2iLAVMBqDa3O0OnuUotQNaGr40wZVeDtS4LDai9CsASrjolbVfwwxGzzHFwOAI2IKW7cQwSTA73Unvhk9HNf3SwJdCQabbYX2tckkWjpQLrKQCw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2454.namprd12.prod.outlook.com (52.132.208.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Mon, 16 Dec 2019 16:50:50 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.021; Mon, 16 Dec 2019
 16:50:49 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: remove unnecessary included headers
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191216160543.13054-1-leo.liu@amd.com>
 <CADnq5_NyFmejzHKHztPmXU8achHWqxPVMzwv2=t-8McwroQcVA@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <e03c9ebc-4b0d-c6ce-e946-d5a7d2327219@amd.com>
Date: Mon, 16 Dec 2019 11:50:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CADnq5_NyFmejzHKHztPmXU8achHWqxPVMzwv2=t-8McwroQcVA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 511a3697-7cc9-4275-0cfb-08d782481af3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2454F85085F79040B6593BC3E5510@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(6916009)(2906002)(4001150100001)(31686004)(316002)(81166006)(81156014)(5660300002)(8676002)(478600001)(26005)(186003)(66556008)(966005)(36756003)(6486002)(86362001)(31696002)(6506007)(45080400002)(6512007)(66946007)(36916002)(52116002)(66476007)(8936002)(53546011)(2616005)(4326008)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2454;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6zWfbJ4M53t8jLq3TfD9nFDDxjcytv0nRUZNVnIY9jdwKw5PDmLqpdyb5Nwa31q/YOA2am2tFW1zJluoresGZiwYGmkxMGT1byx28s1aM4ozZFOcb97hFRQeJNPAeE6gtZaZ9RbtzCjbLrYT1020gMCpMUeOT4CyPFFBq4e2DKS5Fxpd7yY1NDptH8RN0MjmYPe5o1DVL2RYMjS94M5vHuHdRlkgzqfqPe6I+RuVRhDOf3Ga34U2VdXH+5PwKJkVb/PcbLOaOsFeHcgcq113oRQ7eoQ7NsV9yRc5UuU+W+w+T1JZbzXKspGbazL1g9xLigi4V7SqgRVGCOsvy8S2HmYKcQFIuUj7ztrDK+aIGY9hDsSAWxAd5Q3fkFYJTx4jdy5Dt6aIMbc1taI5Muzk+tgNH7DPouQzeslknLCOhRn/VQAJPmIGPk5w8ci+lYJIoIDkOuHL++NeVgf/nyBoANP72Yn14KNS3gwT+kxFwQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511a3697-7cc9-4275-0cfb-08d782481af3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 16:50:49.9355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDmZWrvXTFMqVwJjW9IaoVwXTvy4qIe3TBCKRyLBUV/+uroC4IZ5DFcMVHjbK+DN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2019-12-16 11:36 a.m., Alex Deucher wrote:
> On Mon, Dec 16, 2019 at 11:06 AM Leo Liu <leo.liu@amd.com> wrote:
>> Esp. VCN1.0 headers should not be here
>>
>> Signed-off-by: Leo Liu <leo.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index e522025430c7..371f55de42dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -25,19 +25,12 @@
>>    */
>>
>>   #include <linux/firmware.h>
>> -#include <linux/module.h>
> Don't we still need module.h for MODULE_FIRMWARE()?

It's got built okay by removing it. I will keep it anyway.

Regards,
Leo



>
> Alex
>
>>   #include <linux/pci.h>
>>
>> -#include <drm/drm.h>
>> -
>>   #include "amdgpu.h"
>>   #include "amdgpu_pm.h"
>>   #include "amdgpu_vcn.h"
>>   #include "soc15d.h"
>> -#include "soc15_common.h"
>> -
>> -#include "vcn/vcn_1_0_offset.h"
>> -#include "vcn/vcn_1_0_sh_mask.h"
>>
>>   /* Firmware Names */
>>   #define FIRMWARE_RAVEN         "amdgpu/raven_vcn.bin"
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7C471b86fd37a94fdefe8008d7824612b5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637121109780682361&amp;sdata=7rC8gPrHsi5xa8Zsis%2B%2FXH0URESxBb6AQaMgppVGDJs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
