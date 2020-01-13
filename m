Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5871C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 07:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891EC207FF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 07:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GGyGQuTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891EC207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8236E2E2;
	Tue, 14 Jan 2020 07:57:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39B66E2E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 07:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScxdphAYqU/thhdizkRnzQc5n2zc7gA6vlefgA5/gHM7SFPxs7HzSGBVqUPkutn1tslEsl9ZpXm+C64VN9B81tYZQV9piOLZk6WuSmZ76i8Dp122hCRHfVKnRPnf0p4/8dfoBX/urllhG+kC76fIjxrV1CwloQndmPCxC0Y9HfAcsnhA2wF8BBX0Bq0yi6mvtxPOlv2unKhTf1S4DYzTXwTEm5/ZaJHW/saJM53fWf7PiSBVoAsVAZCyHm5JSM7rMu2ovfr8nCuVX2MXD/lKGw4/lbw1DqL2I+FTUfRPMlk6wZZ5f5NW1MbtqaBVteoNa745bAH4Upk+/DzTdyFigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVKrbcG1CHVcrNux9X+V4nXsYaZydLVmCr+It+v0WA8=;
 b=lEGb223ylBaKmna6ZI9s4zX3x/0iYwfzUNwHLbL1bLKC01eJTDpzTcY1uDun0l0O8GvMbAlS84U2qH6fxLxvrGXJPPJKegKDpE1hDc5NYhqH0pkBotxqMSF+5GZ6TBAMr8bda+9aI/1r+LxzVZMrwPtjEOzNjUPXfuW7pKpKcZHd8QaGYCjt46I/0G6mBjzAR88JfGcpwLgXO4pZ6dcJ/ht0NCtahyhK3t9G40GEsbidzNlz6znoJRkPDKmBJD9gZJFiK3JjuUc43yVrhwWkVGTG8li8FBlsPiDe848YpECxUP6TfjK3mIGvhzDWiKKEzNMV+8K2ac+AiH/enfyEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVKrbcG1CHVcrNux9X+V4nXsYaZydLVmCr+It+v0WA8=;
 b=GGyGQuTuYmt8dvO/kpi+jeLuHocjrS56SZeWkJvJGRpyjFx1phro86s9hZYQWnAaUQrAZ7OZKXGnE/GtKxyA5wrbZOZ3mRDPP36Gw6ZokRP0O8LwPW3NR/503kYAvYOdoJp8iFGUUasFjTYs70iQsXSt51B3lhQ1uW709Eb3Q+c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1322.namprd12.prod.outlook.com (10.168.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 07:57:37 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:57:37 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: add kiq version interface for RREG32
To: Huang Rui <ray.huang@amd.com>, chen gong <curry.gong@amd.com>
References: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
 <20200113155636.GC4021@jenkins-Celadon-RN>
 <20200114042005.GA13044@jenkins-Celadon-RN>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1eaed3a3-a4eb-8903-e4ee-6b89c70208a4@amd.com>
Date: Mon, 13 Jan 2020 22:07:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200114042005.GA13044@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::26) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend
 Transport; Tue, 14 Jan 2020 07:57:36 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bed3e100-293a-4718-e085-08d798c76bd1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1322:|DM5PR12MB1322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1322C36DDBF0C5F6276C3AD483340@DM5PR12MB1322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(110136005)(54906003)(66946007)(66476007)(66556008)(4326008)(478600001)(45080400002)(966005)(2906002)(31696002)(6666004)(6636002)(6486002)(36756003)(8936002)(8676002)(81166006)(81156014)(86362001)(5660300002)(16526019)(186003)(316002)(2616005)(52116002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1322;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UO5jgOdStJrrONhXUWPxrlcEKZzaGZ8SPA2oSdXGcU4DQhQcaSEmZe+9iU8iU+Soe5BvQfgwvj5cy5kjeP/ZIPDm43t08i2VydWiCcNhOj8HnGe4hPvB77fXMSQCB39Pg4MqTsd0mNBgP4CSvZnN51ZkF9VF+2cAwcfrhKaDOroUp9lo5280MlZUsxe8VlJke56n075JJvwirGJDS0fk23xuBWqON1jl80hfN07hbM5ySgIdISD23+9yA6OSQAg484gd154mxU5pqlFKJXRnSowxkFlxm/gfHGLZ5UVyrAfroMqe9MWg2dgYIC7NnE1PUcEtu9KVwM2GAuni7cEwf8nM09VXvVfobAWs22lE4Saq+/+D8MKATCQzwQUJumLNDBcvwfTmVbupflLVyj2YD9MCT56JcYwTOXO5FHlkbOr4CEay58Hh+dL8IJhgegwx/+MvZpny2owZrC1xFqwOukRA5nUEePLmSQxIaVa4ROc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed3e100-293a-4718-e085-08d798c76bd1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 07:57:37.3254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Pz57QRq2Re5CB4MVUYtdL9ysE0WfDpNklWAIVLY6Rm1nR/876gfiYE8WrQJlbPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
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
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.01.20 um 05:20 schrieb Huang Rui:
> On Mon, Jan 13, 2020 at 11:56:46PM +0800, Huang Rui wrote:
>> On Mon, Jan 13, 2020 at 06:16:21PM +0800, chen gong wrote:
>>> Reading some registers by mmio will result in hang when GPU is in
>>> "gfxoff" state.
>>>
>>> This problem can be solved by GPU in "ring command packages" way.
>>>
>>> Signed-off-by: chen gong <curry.gong@amd.com>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 63eab0c..92c5ee4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1016,10 +1016,13 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>>>   
>>>   #define AMDGPU_REGS_IDX       (1<<0)
>>>   #define AMDGPU_REGS_NO_KIQ    (1<<1)
>>> +#define AMDGPU_REGS_KIQ       (1<<2)
>>>   
>>>   #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
>>>   #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
>>>   
>>> +#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
>>> +
>>>   #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>>>   #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 2c64d2a..4045b56 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>>   {
>>>   	uint32_t ret;
>>>   
>>> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>> +	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
>>>   		return amdgpu_virt_kiq_rreg(adev, reg);
> Hi Curry,
>
> I read this patch again, we would better move the
> amdgpu_virt_kiq_rreg/amdgpu_virt_kiq_wreg out of amdgpu_virt to amdgpu.h.
>
> Because these functions are not only used for virtualization but also for
> the case while gfxoff enabled. We will continue using this interface
> instead of MMIO access in KFD driver as well.

Yes, that is a really good idea.

We should probably start a amdgpu_kiq.c file and move quite a bunch of 
stuff over there.

Regards,
Christian.

>
> Thanks,
> Ray
>
>>>   
>>>   	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
>>> -- 
>>> 2.7.4
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C30ace3a1329f439cb69508d79811d5aa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145074676514100&amp;sdata=t6rAUcThU9cmcu5Rwh%2BuHFDtj7Yie4tRN%2FgF2OSBZ00%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
