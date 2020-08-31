Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52969C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2490B206C0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vn5Y9c3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2490B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A8389BF8;
	Mon, 31 Aug 2020 14:55:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78A889BF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axjWS93rSBOverGnUkI6jlNuLCdUaEJRDt7+Kj7No6hjYIGSBeJJ1LUL9xKd1wbeGpwL1jZ4KirEwxK/Ih5MWlX+cYpsUb/TojY4NVPO8LOFLRb26TTfLu3kAyJ8mJ2XveDMgSyEoNDxYJmSPqnHG84EPfFX1s040L5L79poSwswyeeY+rL0Kc9YjimHi5SDzENGNhswFJlrVIbRZ5s8WSgtSi31HNu9/ufY3k8nqGpum85DEv91pyW7py6nSI2HMYZlOmQWizGgVcCkqJPbLfYVZKLs157yAjyle0lX0pOYK+hD+wU0dgkPU3eakNz/eTB7wCvjXBdUPchXpotTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKWRBMBBjFSKd5SgQXbITw3KaSBDiIMvzbCxNmyoHRI=;
 b=WvYmXQvA8OmZw32GAvNz41a7WYRvdwJlJoptDIiHFMFNmFQ3nFPwU6XL9T/dxfYkPCQMEaHqOlDYBT1XQbVqvSIjvFxDD7d5PmkEGffM9y5f3qw7gRL2EOqZzvpl63EKogXtvqHWywZiujFq2ZJm6bbxOK1Ew7Vl8eGNoeqTYKpGvdg8v0wQiiWgKSzarEM/guckKajTFu50Yk6tnGRPh8DCjtxuwF45+HoNm0Gy0aNGACqAolBXUL7+jSR2HdiqN6O2ElIK+VnIvwV39YJAGZNmy0BTxrsFt1NSpob1vz29qituoG/3UUO6Lo2imUNGP1RZ6EPs41GK1Dm62gERRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKWRBMBBjFSKd5SgQXbITw3KaSBDiIMvzbCxNmyoHRI=;
 b=Vn5Y9c3wDzgL2sZ8uqdKT6EKculzupb6/j9ArovAfH4dtoRfE2BXmBu098WiV8MOgL6BU5CNlmHoLHOFc/M/iR0SZl/lwPI++VVmAHLs+1Sxu18J+y1av4DLsC/yW/3WExQcCXGkaf3oYb3i8jc1nLIh844uP5wFMRJThCTslQs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3641.namprd12.prod.outlook.com (2603:10b6:5:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 14:55:48 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:55:48 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20200831104553.10207-1-nirmoy.das@amd.com>
 <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0162c712-a0cd-78ee-0e87-6a612a1e81cb@amd.com>
Date: Mon, 31 Aug 2020 16:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0107.eurprd07.prod.outlook.com
 (2603:10a6:207:7::17) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM3PR07CA0107.eurprd07.prod.outlook.com (2603:10a6:207:7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.5 via Frontend Transport; Mon, 31 Aug 2020 14:55:46 +0000
X-Originating-IP: [217.86.113.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a17e74c2-873c-4ef7-5072-08d84dbdf1fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3641D1F4F33D471B57A674668B510@DM6PR12MB3641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWyppUK/u3ZD9jUX4hRdjVL5W9fRP4pE1vYPHlal2Gsf5p/4PbT1oVHPi2g1WD/A+gpitGd/E1OzdhxtboWTPuU3VR7wJwbx788WjNJiuTzuhigc8rQ6LFYX08jNBK4D5y5Ukhjbn0abkihrIXop4Lw/U097lByXpsFjNj8WaBD79In+voXgp6xvKJy4nEz4hxK7LQzehgmVeZL9LfeN2iP0TObGdUMx/kUYXlnDVSvxu6MdJkDRkekqBeknZ2FxJQ6iLU9BMh6RnOm+n9EN8i6ECzfrfdcu3bEbliNM2rsK4pd3Zrju8mPOaNxDnQ3LWgG9dp16HRm89KlnAi3zvZuxUAeDuJlrWJLIUq4Xh5/ck0V/4oLANEbBi4BqbrvoyWB3USyuk7fzeRHRcWkq3itAKhfzyJ8uTno6nKedtS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(186003)(2906002)(4326008)(8936002)(6666004)(966005)(8676002)(478600001)(36756003)(16576012)(52116002)(83380400001)(5660300002)(110136005)(26005)(2616005)(956004)(6636002)(66556008)(66476007)(54906003)(66946007)(316002)(31686004)(53546011)(45080400002)(31696002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bLUn+9m+fU6KZ2edhnUHYJXYolxFt/kud/uEUZIA/fzcJPJf2dUM74p6/FAy5O5j6PTVUTJocU3FG/LIjN4leL6k4b15dTE6LbYX4y3JEyfyOi3Z5NybN5Z1xdVAGJmz2uB7CVqsciPDgl+f8iLClkP+tRokjToRN/OQllMolTMdZngKqvEL2YTnMuW4UGfRY/O9LhgTRHQXpUYiYOVv96My7ekwrtrfQlA/p84p70r4PaoMJfxYS6zR7mc8yVVOnJhDUJmjbjlIHtJ2KyYynnBk5vX3/B+VBzs3lo5rLR7acOjXb4yagIJNoYrfXAf9kzVuvj2taMBgteEN1vQgNkwhXkeJcdeYNCOWBEL3hmXOpPwnU5hkF42IiQV3BVAAaaIUZwQ+Rb0XEahEubvqf86aqTGn/x6X1R8aqLzBaU4KeFPU7BOn2stayJJlASYNOBNApwm5hKoPIWJMbAKKM+MDmj/qGyYnOf42LAFmGd5BZn235LqnMrA2dGh//ImbF5BfWVBOrR7i+ic+R5hAmrGKBIA5juV+NNp/PHkPr2jEv33NtJIldNMWPLXakDrIGN8fE+fRWdK4YYJurbNaxJ9LBlguH19onGI5C73ZLpIhRRZtbevqqsoMAX1gZuZSVUIPW9/z1kjwAd4QU5J02A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17e74c2-873c-4ef7-5072-08d84dbdf1fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:55:47.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo6pOA27t9A5skGDopE09NGzYO3edEQ0EQI/ExkZr3dXHkZaHhbqXCEwidpYy8f7GVXee7bul4c7cqQLqMntCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3641
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 tiancyin <Tianci.Yin@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 8/31/20 4:17 PM, Alex Deucher wrote:
> On Mon, Aug 31, 2020 at 6:41 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> UVD dependent jobs should run on the same udv instance.
>> This patch disables gpu scheduler's load balancer for
>> a context which binds jobs from same the context to a udv
>> instance.
> typos: udv -> uvd
> With that fixed:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Does VCE need a similar fix?  What about UVD_ENC?


I am not sure, can you please confirm this.


Nirmoy



>
> Alex
>
>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 59032c26fc82..7cd398d25498 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -114,7 +114,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>          scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>          num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>
>> -       if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
>> +       if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
>> +           hw_ip == AMDGPU_HW_IP_VCN_DEC ||
>> +           hw_ip == AMDGPU_HW_IP_UVD) {
>>                  sched = drm_sched_pick_best(scheds, num_scheds);
>>                  scheds = &sched;
>>                  num_scheds = 1;
>> --
>> 2.28.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C6a3e9061d2f043783ea408d84db8a04e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637344802648079859&amp;sdata=C7lkg97j7F6Kq1Vz7L79TbEDvfQm8QS3PUhdHfQ3Rcs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
