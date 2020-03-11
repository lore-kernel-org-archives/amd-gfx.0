Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E264C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6389F2074A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JdzuBPF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6389F2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6F06E9FF;
	Wed, 11 Mar 2020 20:34:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EB76E9FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9X8AnZheIhTo5IOC9nDCGX4NEhHB0pB1ZLGibwvNC9/tDtNrDkCDNOu+JEaTg480eNi7lOHsGOcK8iNdSYis9FbWjgD+D46p3Lau1qOkwgigg/lDQP7QHs2EC5p1MnaDxk8QUotKuDcpLlr0n+BqI5ATQyXp/aCVDDTw7FwOEBEtvg1po57CZnrClOaxO8XapSipflGiT+P9e1dQf4ZA5aDdmGvV8N7XXG8GMHfLGGh3OtTcUO03PmwgKRsNj5fmnPglH/TOModv+r3VOcf2T/secuFKnCxT/Oj56PYuv5/vBt37MochMZuFwGsu7YQcO31JwYRnnKh96o+kKCZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPTi3S5EarYfqY7sTHbL0OOPhpyDKvpA9RvGVKX4//A=;
 b=RlP9KRuzkjS7urkKO4lFcIb9sjA+BxX6m5ACgsR6Esm/jvHEQHsbH8bcOYFpaFAZVIEP/rXnzpCZtCwEt3Eir8wFR0nq+fUwIPboy7geDSP+4um1DwjJgL63AcpH4rUgBu17KiadHJZcuKNtQFMdNKm2NSq8uVGEk4EIxZ4OmPDIx3GdOmZfeQX/+86slq3SCG3YNL0+UteoXF8FxjlWedGAvaxrKSDCt1sCatvPCtctpo4UhxCn4hBZOEmsQdNSF67yOJSjWL31ulEsEPGefiRuulayNtG9jBVynumqou4kw+1GjxaJHgI+3o4dp3VgBss7lWbFUBqSB3OK4Lo1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPTi3S5EarYfqY7sTHbL0OOPhpyDKvpA9RvGVKX4//A=;
 b=JdzuBPF6218Gra7Y6CuuamRg7Mp7K4q346MJAinv9rIsK2Oms71xzyPPU51q70FARKrHZpnqEmbSqYiuGi/NxcJMWfSPipPYtvH1XV8D5nRwmjrUF/oryZcdRAD7SpMLnVWIs1IBIgTN9un7XzUSUIbSr9xCWBGUG/ZuACbVYTI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3645.namprd12.prod.outlook.com (2603:10b6:208:cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 20:34:33 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:34:33 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200310125314.83981-1-tom.stdenis@amd.com>
 <CADnq5_PghktJ1AGT92-f6OE0FDhW8Ydqr0_wLpdcia51YAf=Uw@mail.gmail.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <b4ef4987-d0a2-78d3-5782-68014b8d471b@amd.com>
Date: Wed, 11 Mar 2020 16:34:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CADnq5_PghktJ1AGT92-f6OE0FDhW8Ydqr0_wLpdcia51YAf=Uw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:404:10b::32) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:404:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Wed, 11 Mar 2020 20:34:32 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bbcd74e-4e4c-48f3-10ea-08d7c5fb9b7e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3645:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3645627709F3DD4BE26F4190F7FC0@MN2PR12MB3645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(8936002)(6916009)(81166006)(8676002)(81156014)(36756003)(5660300002)(66946007)(6486002)(2616005)(4326008)(316002)(31686004)(2906002)(53546011)(66476007)(966005)(6512007)(6506007)(956004)(16526019)(478600001)(186003)(66556008)(86362001)(26005)(45080400002)(31696002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3645;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEbeMGzkr13kZXdqtZOKK/f+JblN+Ul7EAslcXcyKTknZsTMx+kZk9n2qRVhGq15WGVC99aBcGYoM+xxuzs14ijj5x1iTiZ3RrmVekPdmo0ht3wvlf8/7KaOk8omn23NFLVGv48S2GxXj76qgnWqNdLgki6Rp4gyjaUl44FlMNEIIlpM3riwTqN0a+vVw4ltwGf7zes7lAzFaYJgp+T7E3g/Y8XjCEQUuKZcvdFvBjuTWZfmUzmDWownPya/C3SiwPCf3C/D2StvQRKe0g0V6fDO8sCRoR+BTrOEDuORQAAqnaF+BonKUKlTU45R7U4qLJiEZdWb2VpeSaSMKtCiyIqa7wPdtRc3ixL6IVk2VELr6dBELZYkvqopS5BEI0o3lPEiqnvjt6GW2zgMtD2Vfcs4sY6vP9fcAWf5xuG8oTVi037N731ignCTLqVOwb/+5UMwL+8m79W5w/2S8ud1oDQpnaMSPRWw6oRK7iqoMotTJGbD3UtfsttLlI5wstfcRoUfK9AklFY4QseQpfkM4A==
X-MS-Exchange-AntiSpam-MessageData: utXlLS/tlt6Uile4z1OvnH/kdKvZR5EdCeu/ltRBByR5bjxoBBeHS6rddMBTsGvQm9WW7Zup7umBMIYBwEFxFJpm+yH0evq4KJ2ZECQnEzdCpUQsacOmiLwwKVPPyoIgJwrVFUeTeh3h6JShcCHS7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbcd74e-4e4c-48f3-10ea-08d7c5fb9b7e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:34:33.4956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwLdX3ikNTmehYW+seoJPTAWeOCfqJl+W0KwzhaFvLavirzstQrtWxvP0ycwMm+NZ6Ooz4+ykcsIxSMwzgcBhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3645
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

Hi Alex,

I sent out a v2 of the patch to the list that also addresses the fact we 
were reading from the wrong offset from the internal buffer.

This entry was really only tested with offset==0 which is why this 
didn't come up until now that people want those trap registers :-)

Tom

On 2020-03-11 11:16 a.m., Alex Deucher wrote:
> On Tue, Mar 10, 2020 at 8:53 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>> The offset into the array was specified in bytes but should
>> be in terms of 32-bit words.  Also prevent large reads that
>> would also cause a buffer overread.
>>
>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index c573edf02afc..e0f4ccd91fd4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -783,11 +783,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>>          ssize_t result = 0;
>>          uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
>>
>> -       if (size & 3 || *pos & 3)
>> +       if (size > 4096 || size & 3 || *pos & 3)
> Is size in dwords as well?
>
> Alex
>
>>                  return -EINVAL;
>>
>>          /* decode offset */
>> -       offset = *pos & GENMASK_ULL(11, 0);
>> +       offset = (*pos & GENMASK_ULL(11, 0)) / 4;
>>          se = (*pos & GENMASK_ULL(19, 12)) >> 12;
>>          sh = (*pos & GENMASK_ULL(27, 20)) >> 20;
>>          cu = (*pos & GENMASK_ULL(35, 28)) >> 28;
>> --
>> 2.24.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Ctom.stdenis%40amd.com%7C550ca4aaaf084c3d7a9f08d7c5cf2c65%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637195365897948298&amp;sdata=YTb2YGBlAlDS%2FffaVOo2Yrej21N%2FJYVpFVIc1rQERWg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
