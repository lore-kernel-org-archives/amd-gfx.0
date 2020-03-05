Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30279C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 06:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6666207FD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 06:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lQA8VgBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6666207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CDC89A9F;
	Thu,  5 Mar 2020 06:25:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A1B89A9A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 06:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/7hn8Ir+5s+A+W3u7hGAmkul1P+e20sRDYplb7jmeBMxa39zF8Sd9GGo5K3Bgl4CsNWaryLUQSD8NXJolrHnP8j2NFe9THjFLGgGMgjxT10oI0tXZ2pNoBUMLQNt4CXN2HI0bjS3+mGkDP/w/NpWCARvCXGvYicPaEm0zORUw4yrhoOZxdXmqZWGju7oe6r2HZQ0J7195WTJ6acozFl+9str/W6WYvcWIYCOAYOhLjiGFh95C4z449/Cxv+l9xKUyVMV6a8V0j0fJ6FErV+4ql/V8nHAChl6RcpliLVA/FXEDNCMd9USiEvHcW4iTG6JclLYHhNX/uFhnRUhePx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+olmOa+UmdwyPf9wdV+WITLKMkGUtf6fSC3/O8z4cYw=;
 b=X1wGHKW3B72OAjfHmFpzUcAtMrNnGKAkOSQqlHJPSfQmFD9xbF66G4QKIvx8NAS4cUVzuqPHwVQnmA+NxzDr3+rF2FgwxUy28YFHUw8qb5szBeTAhg0qzZP2QhFYpIowiHPVai93WSQDgRKaVF6zwCoTdiFZhjUh5BMYTg2ZtBpBzfHSiiDt2D+O0z9RBUnZ7cYjzIf8BMVi9BvNYHTzzAsubTQ/dQhhRd8ekYrx2+xrPtnyEpXnA+zrOaIR+CyiqLAVeeJpFrcnBoDjfxSaeM+m+RjDjUK4t+oYjuy2jKsMr/UowVmFZS7PclvQEloEwwJsec/0aQJfdEGiIb7XGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+olmOa+UmdwyPf9wdV+WITLKMkGUtf6fSC3/O8z4cYw=;
 b=lQA8VgBhlHQKMSmwdZRyHhuZBnjon1ZnYRn72ZsAGClJDwqyBEB4sX5JbR9g2pKFGZUJ1SXqO5D1x3L2t0fsN5pCCIoVQNUPkitT3TBM96eGoxP9UWXOCTsXv3hixXsvvkLodAQ4Ayr9nNnhGA3nQfEUOZi7W0y6x0b0wYhGoW4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 06:24:59 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 06:24:59 +0000
Subject: Re: [PATCH v4 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-3-nirmoy.das@amd.com>
 <64d19cfe-452c-fa85-3f3c-1953e3c800b0@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <232beb97-85ff-0ea7-c95e-f03ff3c76f9b@amd.com>
Date: Thu, 5 Mar 2020 07:28:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <64d19cfe-452c-fa85-3f3c-1953e3c800b0@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0086.eurprd07.prod.outlook.com
 (2603:10a6:207:6::20) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
 (2003:c5:8f2e:a500:1f22:cf19:9085:11a1) by
 AM3PR07CA0086.eurprd07.prod.outlook.com (2603:10a6:207:6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.6 via Frontend Transport; Thu, 5 Mar 2020 06:24:58 +0000
X-Originating-IP: [2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16e0fe56-33c1-4aba-a589-08d7c0cdee22
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:|DM5PR12MB1708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1708A4D2FC172D3E80C733AA8BE20@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(110136005)(478600001)(31686004)(316002)(5660300002)(36756003)(8676002)(81156014)(4326008)(8936002)(81166006)(6486002)(2906002)(66946007)(6666004)(66556008)(2616005)(66476007)(53546011)(16526019)(186003)(52116002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1708;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3pLoclpWUHrRK6bR4fFqGJDSxYnABR/q5xnL+MNpJnC/p7vAvTlS0ssqR6Re4hvyjFUbXMq+956W4f1ZOheRQnw4XSYWOeCrRvmtYvC8CB4RRja6TjN8iDtNz7q0PgxZ5EdcFo3MGs57MzpsM2QxvWKvpo8fxamak0xdoiz2QIOwtRda0RbdpX4NUEaHrmjBBKniR6wxOpe6Nu3ySjlP2gAHK8p1o+74ZlM1ZFEfVH+V06Kkjv6NmJH1ZjUA4+1WHUOOMfheuCoAQaTGaihfA8AsPPB7Aulh1jSOQcPq8csKyBSLRYQpCu7xPnjEEGyulyFRFWlSLtqVjhpVosp1bvYtAI3a3wTs8qid48Vqcdwz+X3V6I7jCJClPfO3M15twqvkbiSYAjFzPyksUP661OiHkacQSLGKgNg8jGuLBChw2uw7YPiqryvIkp3Pq7n
X-MS-Exchange-AntiSpam-MessageData: z9Aec3JSc8J/Ysqr85AigSj0tACwHmrmn6JOV6FdQNEm6K+WRTSjgRBg4ftoIDKa2Poe40bHOnlLhl0/Ilb9AqRftrA4NVsYLJWIdaq2laYiUe3G38NUWHls3HTCAvshQL4kyOgKR3NcORk2CVqZxADGxJ1ZMno6tkQz7VuxF/7Tp+QHCvLTIm3jDOnqsoCSw9FpKQd1+ql1Xt8FqTZcsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e0fe56-33c1-4aba-a589-08d7c0cdee22
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 06:24:59.6258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7C1kvank4nXMkMxjls9pbIbfpooon4vsM7B4N4JWBw4lEKKed2NWnCEjLGpEBClfF2SIkLgS5ABDoVlTW5MjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/4/20 11:25 PM, Luben Tuikov wrote:
> On 2020-03-03 7:50 a.m., Nirmoy Das wrote:
>> Switch to appropriate sched list for an entity on priority override.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++++----
>>   1 file changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 8c52152e3a6e..a0bf14ab9d33 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -522,6 +522,32 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>   	return fence;
>>   }
>>
>> +static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>> +				   struct amdgpu_ctx_entity *aentity,
>> +				   int hw_ip, enum drm_sched_priority priority)
>> +{
>> +	struct amdgpu_device *adev = ctx->adev;
>> +	enum gfx_pipe_priority hw_prio;
>> +	struct drm_gpu_scheduler **scheds = NULL;
>> +	unsigned num_scheds;
>> +
>> +	/* set sw priority */
>> +	drm_sched_entity_set_priority(&aentity->entity, priority);
>> +
>> +	/* set hw priority */
>> +	switch (hw_ip) {
>> +	case AMDGPU_HW_IP_COMPUTE:
>> +		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
>> +		scheds = adev->gfx.compute_prio_sched[hw_prio];
>> +		num_scheds = adev->gfx.num_compute_sched[hw_prio];
>> +		break;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
>> +}
> I'd rather this not be over-engineered (in expectations of more case labels,
> and a simple if-else to do it. Over-engineering it "just in case" creates
> difficult to maintain code. I believe there is a document about this somewhere
> in Documentation/.

This switch is in expectation of extending it for VCN and GFX but I 
guess that can wait for now,.


thanks,

Nirmoy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
