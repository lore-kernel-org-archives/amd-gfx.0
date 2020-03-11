Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E05DC2BAEE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 16:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51DC20735
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qw4bUO1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51DC20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9286E49B;
	Wed, 11 Mar 2020 16:58:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20DA6E49B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 16:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipx8MWmNH2EEu/38GRGCP6NSHicv12gL+RjYy6y+nmgerl21kIQhJ7A6ZZ9NYefI72j13FHmJT4+M85bOOOenI9Jg/t8tcE8aIFI65+BzZ5f4UM55kn0r289LT+mW77rM7jwBHLDTYPLYRp2pAn9ONoeC0OY4GQ+HDQha9RqPYDbzwepqZbY+KclMA92v4ctpM+HummpNzwbDkAGFnCno9iIB/fhU0UZyVmK6UwK6HsnHNFDBW1O8WSjYit8QjOc0BBA4icMTCEKgV8TmQttcmUuWrvXZCgLPJJr8moRkBxQtYewMkSHnDSRYOIgeePIT9o5ISVdgzO6x2OQq2EXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFKqq5JsEt1ND1Wl/r1mwcauR/GdIJKlRPfWjUlQmV4=;
 b=OHCHVepmxGMqvSV8Q4b0ZvT+GdOW82r9Y9Eukez/r8YJcZoZLCOlyJWPM6boRqkFKy+izObzGItMQmJkB6RmEx6S+eD/DYpc9GZVAhU1ihKcSBwP23VqeMLhtOktr7E5v1pVhJUVgdKixD7vghPkKHkEZzyAwhDzb6PEnvrZC6dJOze1ENa705YxfPw8X/EZ+7915W9mu29oBpRnXE8u4u/sZlBxIbl4lzGt4NKTw1mn7yFuZ3uKGducq1P8aRrGwkld2iQSVW5vsDN2Fv6Onp+l9q7DxQqe/8j3kqu4DiStqYs9rPRL1F5p72SkyA1WDqZpZulQiP1a/c97+kTyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFKqq5JsEt1ND1Wl/r1mwcauR/GdIJKlRPfWjUlQmV4=;
 b=Qw4bUO1NjlRRRzjhb1y67QtrLwDSr4IC6lqtiXDQRgaZHoSQJjMUWaZN8tNhh8wCbK5SE+DJkH26pTBKuttLb7IeMEz81GaefSEyfcLXp7gXVFywOUZBBZbTi9SiGOtz6m2hNj9aTQdJACvwa748LMDNM5208708Hw8JZMYifeo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 16:58:32 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 16:58:32 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200310125314.83981-1-tom.stdenis@amd.com>
 <CADnq5_PghktJ1AGT92-f6OE0FDhW8Ydqr0_wLpdcia51YAf=Uw@mail.gmail.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <27021568-3779-d9b0-8848-32deb0a161b5@amd.com>
Date: Wed, 11 Mar 2020 12:58:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CADnq5_PghktJ1AGT92-f6OE0FDhW8Ydqr0_wLpdcia51YAf=Uw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:404:e3::34) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR19CA0072.namprd19.prod.outlook.com (2603:10b6:404:e3::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Wed, 11 Mar 2020 16:58:31 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5250c6ed-46c0-49aa-ad2b-08d7c5dd6dd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39673D9C55741D9DEC0132F9F7FC0@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(45080400002)(6506007)(31696002)(5660300002)(66556008)(2616005)(316002)(86362001)(6512007)(66476007)(53546011)(66946007)(478600001)(956004)(16526019)(966005)(52116002)(6916009)(4326008)(186003)(31686004)(6486002)(26005)(8676002)(81156014)(36756003)(81166006)(8936002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3967;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tG/AcMBQBMzkSQ5vjNzseE0bS23g4Z3wPu1B1yhAibaQWQTMH3QeXCLHl4+s4Lx/NE5ZvC6smLruL9L5g55Ka93hvJZ2VPJee5wd6qZorPDSS0FCJc2u7uGyCGbP+G7o0QR7IKes1Eb+/L0XncKTgtzAdks7heNCy3qoTTwC26i5nOvwhgMrWzMgO5VobLFZsaIYvOzwCB5569WJ4wMVRLY2cggx708uHTxJc/x+cTYxM3S6phKz9o2uQk8QQ4Pr5ypnZOr2Jjr0wbZ4EFL/okDk9HWDLsE+YYhTENxaWE+nO/Cd2Gh0dZF8Bngno13sa653klD2xgBRaZrYNt0849wxiVXpx4WYF5rxMY14zjjfMm83/qqSM43eatMmJa0Hv2xWXd3q8aJSep3rOD1CXYdHK4/f35J0+KfdhSv3pSDWfkXQyvHYgwwnHxDncIjLZrsgyIiL9Ecp3lU1cn2jgEU0O+UQN3cYU2EAHL0rRyeEkt6tGigOoJbKJst5uP4bOfysOHKQm4t33G1Og17FKg==
X-MS-Exchange-AntiSpam-MessageData: uYlh7F25T19jBl8pn3RauFwKcebD95ouzXee2rKya09w+El6Q89TPtyoKKtv0v0Qez331IuuapyejbbzIlVhsBdxWZfwiEs+n4A8OKAXDDPrs9eEqL4dWaZ/ACGBaDtBFtTQdwPY7F1opnKsIHUx/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5250c6ed-46c0-49aa-ad2b-08d7c5dd6dd8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 16:58:31.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E93fqN5iJKXgyDvSoqOybkNiOcpfMlCzMPDNRdfe0We8jC1hx8HrGHVJybV2PX1a7qdodHGn4TbSr5UY4PEs4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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

Nope it's in bytes (as per the calling convention standards as well as 
later in the function we subtract 4 from it repeatedly).


Tom



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
