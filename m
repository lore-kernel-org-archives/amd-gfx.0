Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D4C3F2D7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326CE207FD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gUnN1x52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326CE207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D016E34E;
	Thu,  5 Mar 2020 18:51:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485B06E397
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 18:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7lezPuyUnODaJYb7yIzBSDlOOvTaUBFGGa3+MtfDkYDjmE796GgJ3JQfCs7p7OG51MOgW3FNVByn+zDWaVUK2mxyGDx7NQ4AEIUEqWZOXTZMAYn8g1owcRAapiX65+LgWEHzIsAoEU9zMRrG6WLfM4XTSGL98D2HZxo39dQZh5yY5sjeyv6x7qMRYEhf9AgQy5mD6RCkQ65bmXCtqFYkCtAx2+SCYuAHQ72GkHmIf4mXlk5jaXfN7IU4/1mVjnH1x5UrB+M3Qnj2D05qrNzB+XRwAJ2sKZxPo96fdj7+NT4GpXAXqObHr6KWNbscEmPKI2+rCEVCLowDsHei2TmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXNT4UjW+e8KDrLDo1Aj5R8senoG/rne7iWAMI9s1qc=;
 b=AiVn07b3v/QWf7+wHxAFBh7rvW/2Xa8nW+X/lIm8TgkouTqnigxm641sb8nDSTg5CTBEcNWW+4oyX/0+dms7dhlOCujJud1J2xGFl2sTFteYrVqbbA56ZW3wB/D3xgYYLrkPAvQsi8XPOyod03K0gK07Rc6na1VU+r2uXXityaalSgNQA3UJpDPSvAxTH8/TOkm+ChSGXFH6eHd0b5FLK04tBlrAN1Tmy9uA4sBPYt5zxiUa7HgOXIY0kb0xpN/flsxXq8USACdlazMJaHD+75K8JGtXjAdHjKwhtccBOb5Bg+1cn0qtsnJ1dUIpTc69SVPkaYIuOHwHe/cyueZyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXNT4UjW+e8KDrLDo1Aj5R8senoG/rne7iWAMI9s1qc=;
 b=gUnN1x52E2eejDS/wa4uTxH2GELMiyx/scOgDcxRrw0iScbPHbBHjJfWZCgOtFO6iwar1GfGMi3hA6NjkxgHlGtA3QuxM15oOUrm0K03XkIquWte52fe70cfpvrt8tigDH6w5hvkHC9Ng128km7GYUD+OdMeins5I4tihh7Aq0A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 18:51:24 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 18:51:24 +0000
Subject: Re: [PATCH v4 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-3-nirmoy.das@amd.com>
 <64d19cfe-452c-fa85-3f3c-1953e3c800b0@amd.com>
 <232beb97-85ff-0ea7-c95e-f03ff3c76f9b@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <cb3a3cbd-8ab2-2f36-a5e8-4d53542289e8@amd.com>
Date: Thu, 5 Mar 2020 13:51:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <232beb97-85ff-0ea7-c95e-f03ff3c76f9b@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 18:51:23 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 130d7468-9ea8-42a1-845e-08d7c13633fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3593:|DM6PR12MB3593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3593C1771564107AB32664A299E20@DM6PR12MB3593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(316002)(478600001)(8936002)(31696002)(81166006)(8676002)(81156014)(44832011)(86362001)(31686004)(956004)(36756003)(2616005)(16576012)(16526019)(6486002)(110136005)(66476007)(53546011)(4326008)(26005)(5660300002)(52116002)(66556008)(66946007)(2906002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3593;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0M4vLWXB9xxpGxkR2q6W7+Hd/JZB1clScqc6qWa46b86Qm7hrjEJAmlxNmbfJ+ZDIUddRSdPzZLAISZTFJg0WJZXJV6DnIb74LSdMyv+1loRxWfZQCCHCFI1IYFzfWPOKJR6yu4l2VfyePuR7nIXs7x4FaPlY8ry95LhgmiSJiNTYFhlU2xZyj7PJbFAC+14he1F327oEdJCmMP1AfJiv8QuSENqvLa7+uNaU5bcQGzFQ6ahb+w3VlWcggIdYLQyYjvNEEB5J1OGp9cbx0D9IO62iEe6Emoye0kw6NZ6nDUUhuo0f4xqdsv+fahfcvDLuop9bS5ZFStMi9yjwCcLg2qTI7CMGDDjW2ero5So9axuaOcXR7iu+SuFehWTVwbD38Ul+26PjV9OKuJCY4VOnoNMQpX2o+titkQlrstvLNnLx5VfPecVw8d/oxvGfoT
X-MS-Exchange-AntiSpam-MessageData: M0kn/4Bx2l9tsjVxNHl7fhLKdTS+QrFOrPhHWCUrbPxSlWelckfq2ffJ2uL/psEpPrUiMokah1LOcXmoTdPWPFDQ7Qlj7Q96b2EQlDOadeMfOp9Oh68HsF4yER6YnSK8lk6RFUjjaszIiVFwQmbZug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130d7468-9ea8-42a1-845e-08d7c13633fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 18:51:24.2515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUNL+k/Mn0Ybs3TwmAQsJxjUjCkZpy5VzA77YFfZxRZdaWrSwM0B0WR5LXbHVKZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-05 01:28, Nirmoy wrote:
> 
> On 3/4/20 11:25 PM, Luben Tuikov wrote:
>> On 2020-03-03 7:50 a.m., Nirmoy Das wrote:
>>> Switch to appropriate sched list for an entity on priority override.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++++----
>>>   1 file changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index 8c52152e3a6e..a0bf14ab9d33 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -522,6 +522,32 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>>   	return fence;
>>>   }
>>>
>>> +static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>> +				   struct amdgpu_ctx_entity *aentity,
>>> +				   int hw_ip, enum drm_sched_priority priority)
>>> +{
>>> +	struct amdgpu_device *adev = ctx->adev;
>>> +	enum gfx_pipe_priority hw_prio;
>>> +	struct drm_gpu_scheduler **scheds = NULL;
>>> +	unsigned num_scheds;
>>> +
>>> +	/* set sw priority */
>>> +	drm_sched_entity_set_priority(&aentity->entity, priority);
>>> +
>>> +	/* set hw priority */
>>> +	switch (hw_ip) {
>>> +	case AMDGPU_HW_IP_COMPUTE:
>>> +		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
>>> +		scheds = adev->gfx.compute_prio_sched[hw_prio];
>>> +		num_scheds = adev->gfx.num_compute_sched[hw_prio];
>>> +		break;
>>> +	default:
>>> +		return;
>>> +	}
>>> +
>>> +	drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
>>> +}
>> I'd rather this not be over-engineered (in expectations of more case labels,
>> and a simple if-else to do it. Over-engineering it "just in case" creates
>> difficult to maintain code. I believe there is a document about this somewhere
>> in Documentation/.
> 
> This switch is in expectation of extending it for VCN and GFX but I 
> guess that can wait for now,.

No, please, do not over-engineer. Don't make decisions on what the next
programmer and implementation would be.

If you search the LKML you'll see plenty of emails from Linus and
other Linux leaders about the drawbacks of over-engineering.

Just have an if statement as I wrote which you remove without
adding "[snip]". Please add "[snip]" if you're removing content
when you reply. Everyone does this. It's only common courtesy.

Here it is again, because you removed it, conveniently:

You don't need a break only to execute one statement, which you can pull
into the case: label. If you did this you'll see that you just want to do:

static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
					   struct amdgpu_ctx_entity *aentity,
					   int hw_ip, enum drm_sched_priority priority)
{

	...

	/* Set software priority.
	 */
	drm_sched_entity_set_priority(&aentity->entity, priority);

	/* Set hardware priority.
	 */
	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
		hw_prio = s2p_prio_map(priority - 2);  ## or perhaps from a static inline from a header file, so we wouldn't care for the - 2 here
		scheds = adev->gfx.compute_prio_sched[hw_prio];
		num_scheds = adev->gfx.num_compute_sched[hw_prio];
		drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
	}
}

Regards,
Luben


> 
> 
> thanks,
> 
> Nirmoy
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
