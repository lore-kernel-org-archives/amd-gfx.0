Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08035C4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CAA2467F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w3vmIk9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CAA2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6F26EC7F;
	Thu, 27 Feb 2020 09:55:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261346EC7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 09:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2UEG5pBibzejwDxsQg77+z64H9a2ZNU9s9PrRZ4lVAjAi8BQ6VCZ7fnFUM+Yd9HQD/ARRSSYD87fuICIpUtcuajvfL6JnpLTDPU8xLi/fskZxiE/6SEnpPGTNsAsJQ8A4tCDJR4TjwnqX9zNjSZm7+1PJopml/lkYK9jXLDWQFeK6shciCy/G7GgnXOKRdY5gQ3VN/WTPKy1lHSS9qp7PFTYbRL84x/ktGBVWN0Hb6nYDPloAreW3oihD2CLbtH9pM0+4+wr+lQNDcPDvVN9H10xfypIL+vnEoF1Rm1y/U+rqO4d//7dAEi+UOJd0lgJWrzofnEMdEgL1wePd0Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kNXwPnpkCel7ZPzwxvslm+yKfjVCUZ1RBrLG0jGZjk=;
 b=Wd5Z8nSKS/tmHA3ytkaXhq04XGHip2BTsBsPFqTWB1+8IhUyyg75Dno20oNf5JaLNPDzIhlQhGBOViI8Y5UsO4MUxhF7uYwfHJ84v9XWzsgp1MWqs1VhPnNhewUqffhMUS5MNrHZmRWULrpjdyWMXq50dl3mv9tEorF3tdktEplG7e+2HlGoVadVV4/g0wU9ci/Hmh7yfvn9i4DPVIutXa3HtRnzGAeiMGezbkqIPyizVpmdCEEXTY2bmiGt7iKiETBiHWgtAOtCJ3mGxHTtSUJN3YftC6JfNkpC8yS6REEjrNVno1lYtQV/xr4txHs6pe+ja3YxIH4aWp1md0taiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kNXwPnpkCel7ZPzwxvslm+yKfjVCUZ1RBrLG0jGZjk=;
 b=w3vmIk9Byvr1fcpjaxZCuu8Iv4I0HFePHzxgVoQDC+iAMxXHVfDP2DN3KOE1Jq+EBFsjxlDrdlI55ERBgcVFB4h4EHDfEi5g9SpGQCUShbfUMxq42gmCbGYr6POELmZkJE1/H7qDdwC6f3gr4FElerB/NTZZv+Z6FuLDu2/khEM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 09:54:58 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 09:54:58 +0000
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: implement ring init_priority for
 compute ring
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-2-nirmoy.das@amd.com>
 <CADnq5_M2w2W5eSX9m5x0hjY3TB7CxJa9YJfyUemk+mfgMVMMPA@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <65374d06-4bbb-defe-8d5d-9964d1e3ab79@amd.com>
Date: Thu, 27 Feb 2020 10:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CADnq5_M2w2W5eSX9m5x0hjY3TB7CxJa9YJfyUemk+mfgMVMMPA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 09:54:56 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b3fe0e7-b80c-49dc-b649-08d7bb6b1ac8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:|DM5PR12MB1721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721DF014EA6DF97C1D914D08BEB0@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(2616005)(66946007)(52116002)(66476007)(54906003)(110136005)(66556008)(316002)(31696002)(4326008)(31686004)(45080400002)(8936002)(36756003)(8676002)(53546011)(16526019)(186003)(81156014)(81166006)(5660300002)(478600001)(966005)(6486002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1721;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XYFNZVHdX6mMHXaTna2cas9px6A4kSafjQRuhV5Rm2tg0FJVI+r3QMzpWa82SnmUx6l8Oc1WSW3uH+cxhG4BkUtIVJIXVqid/cJDyMe0UxS3doTj8u2W+KfdKwqc/K5VY0KKaktAITeiz33A5nNtTa6T/YWxkZ4QhyElqQhQTBv9FPpTQsLdDTX/bNUYwNpGm3sQrryudRny1V3yXARPNmlzJe/QBWpkwDJUwenIIKglqWE3zwrCNjLrAyn9junlTHDPnQuKGGQ+bBgF8pl3cXLxqPIPYe3sRQs1S5sSShbbg+LMEbC7ULQdorHCbUi9CJjMfO6RqNthZW0o7IV/L2+x0rzHFYX2yyvn33PWFlCuExGwzu3ZpTeo9Efc652Jhcv9eF4kiYhm1XTjJEJJ99IEKfcwkj8J8Py9R+HSxZuLGIW70Q20qOraV3dkCMqBKL+5PHz1WQJGk8TB57mHJW8uShvpLLG2gDivefXuXM=
X-MS-Exchange-AntiSpam-MessageData: W5t52AjsxT00DsSHx6lc7Kbxspe0jZ8wMpBZLJspuZb+tJ/VGSVi1+laEcUcIA0+sv86rNAJN2Wx+GPH2ePg80MR7wVRmaFBHcQlWgOpLUOXvikw9SvBjOXLpmk3EKI4aT5BC71fCtNHxBASuNyChH+kCbzyR0NHWad7k6ebR4DBKDoCkjMdpbq7lqFnNleQv0Dptj8lS1T0hyrgvm+/gQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3fe0e7-b80c-49dc-b649-08d7bb6b1ac8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 09:54:58.4898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlWHHj6uk8lBSZ6lACnFxskDpE4IZXVoh/rIyIz8fN2h98ngHa2OLqJJOX4sh5Wqb+2XKFTWtdHs3YJYDyzM5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
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
 Huang Rui <Ray.Huang@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/27/20 5:44 AM, Alex Deucher wrote:
> On Wed, Feb 26, 2020 at 3:34 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>> init_priority will set second compute queue(gfx8 and gfx9) of a pipe to high priority
>> and 1st queue to normal priority.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 14 ++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 24caff085d00..a109373b9fe8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -170,6 +170,7 @@ struct amdgpu_ring_funcs {
>>          /* priority functions */
>>          void (*set_priority) (struct amdgpu_ring *ring,
>>                                enum drm_sched_priority priority);
>> +       void (*init_priority) (struct amdgpu_ring *ring);
>>          /* Try to soft recover the ring to make the fence signal */
>>          void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>>          int (*preempt_ib)(struct amdgpu_ring *ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index fa245973de12..14bab6e08bd6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -6334,6 +6334,19 @@ static void gfx_v8_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>>          gfx_v8_0_pipe_reserve_resources(adev, ring, acquire);
>>   }
>>
>> +static void gfx_v8_0_ring_init_priority_compute(struct amdgpu_ring *ring)
>> +{
>> +       /* set pipe 0 to normal priority and pipe 1 to high priority*/
>> +       if (ring->queue == 1) {
>> +               gfx_v8_0_hqd_set_priority(ring->adev, ring, true);
>> +               gfx_v8_0_ring_set_pipe_percent(ring, true);
>> +       } else {
>> +               gfx_v8_0_hqd_set_priority(ring->adev, ring, false);
>> +               gfx_v8_0_ring_set_pipe_percent(ring, false);
>> +       }
>> +
>> +}
> We should drop gfx_v8_0_hqd_set_priority() and set the priorities in
> the mqd instead.  In gfx_v8_0_mqd_init(), set
> mqd->cp_hqd_pipe_priority and mqd->cp_hqd_queue_priority as
> appropriate for each queue.  I'm not sure we want to mess with
> gfx_v8_0_ring_set_pipe_percent ultimately at all once this lands.
> That stuff statically adjusts the priorities between gfx and compute.
Thanks Alex. I will send a updated patch for this.
>
>> +
>>   static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
>>                                               u64 addr, u64 seq,
>>                                               unsigned flags)
>> @@ -6967,6 +6980,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>>          .insert_nop = amdgpu_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .set_priority = gfx_v8_0_ring_set_priority_compute,
>> +       .init_priority = gfx_v8_0_ring_init_priority_compute,
>>          .emit_wreg = gfx_v8_0_ring_emit_wreg,
>>   };
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1c7a16b91686..0c66743fb6f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -5143,6 +5143,18 @@ static void gfx_v9_0_ring_set_priority_compute(struct amdgpu_ring *ring,
>>          gfx_v9_0_pipe_reserve_resources(adev, ring, acquire);
>>   }
>>
>> +static void gfx_v9_0_ring_init_priority_compute(struct amdgpu_ring *ring)
>> +{
>> +       /* set pipe 0 to normal priority and pipe 1 to high priority*/
>> +       if (ring->queue == 1) {
>> +               gfx_v9_0_hqd_set_priority(ring->adev, ring, true);
>> +               gfx_v9_0_ring_set_pipe_percent(ring, true);
>> +       } else {
>> +               gfx_v9_0_hqd_set_priority(ring->adev, ring, false);
>> +               gfx_v9_0_ring_set_pipe_percent(ring, true);
>> +       }
>> +}
> Same comment as above.
>
> Alex
>
>> +
>>   static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>   {
>>          struct amdgpu_device *adev = ring->adev;
>> @@ -6514,6 +6526,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>>          .insert_nop = amdgpu_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .set_priority = gfx_v9_0_ring_set_priority_compute,
>> +       .init_priority = gfx_v9_0_ring_init_priority_compute,
>>          .emit_wreg = gfx_v9_0_ring_emit_wreg,
>>          .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>>          .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>> --
>> 2.25.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7Cdfeeaa22459548bb7b9808d7bb3fcb60%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183754987155471&amp;sdata=CUR%2BxoLBO%2FPSG7B1lyKAgQVcMLr%2BqQRYlHHs3OGFZPA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
