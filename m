Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F2664E76
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F2664E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC48C8959D;
	Mon, 15 Mar 2021 10:52:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD478959D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 10:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYD+gEI0PELivDcwpZV8ldR6+EK3Gxg7OSs4JMX73wkW9PxGs3ov/6C12kKXo3U/0mHXfPBFKB9lEFusEzwQna/rPIYliqHCUbCHb0ntzO0GE61vowsaG8B1OwKbr5d0rFKTMtisVMRDRIn26t2Wf0jXDFznslIJC3zsI0sVzBYtHeGZZBwj9aV3sdhWrz1eaJ/VbsCYMXvlXph3rF6cUdg6iM2/FDyqGbBIQw0ANXdnU/fNI3Xn0KxG/+qya5kggxRnK/Cx1U5RdSj97d13YkKTSuH19ig6/iioqsTeg4baT99ggPvvkfbDMXcCCi8UqJ8td0RoUvMUrn6TatGhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTRTZO0+MV0DzTh6dbcbklMCrtP8VRMv3fJqGyYadRM=;
 b=XoUtJidlm0sai70S0MNngQScWvLtpnTuPcyoIWC16HvICA/WtSPqEbfhsgHDDaJN7kZr2/ZHW7RNHd7y3aAmr8ryTOLZkHdq2Lu+UQJbO+b4uBba5i3SnsGkfb2L7RJJE6hmX9eTBFY1SAjNZqnO5OMjnTh2MqeCHJtvACv2qZaO3fd8wMsdKGuuo1b94pdfHtgMBSnXcibmo+zhUYpJMhNzgbWbM25zCixa2zgVc6KOc4WfqVsynpLJnl39LArOfhyR98a4BuAWNnnI6d5hQr2a4RCM2udn4UROln4x0IctXtyKfA5gFEZrwzKT8FVGm+aUTJJ92NefLq1YauwqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTRTZO0+MV0DzTh6dbcbklMCrtP8VRMv3fJqGyYadRM=;
 b=0cRLxSZp2w9BvqDCKVKsiWFEl/oXXNb8l7kADAuL+8jG7sXDKrK90gMDh08eX12UIsyZGx3AlQnMNtb8XGfP/0OjhKpTVSICRB0iYoHe2GqhhKxGKUmj14qkVAMd8MChj4Kwxf6Vp5XfVrCc+s3lrTplXgBBIYAY6atkXXMskUw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1240.namprd12.prod.outlook.com (2603:10b6:903:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 10:52:24 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 10:52:24 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20210312170810.10934-1-nirmoy.das@amd.com>
 <DM6PR12MB3018F5411F3181EA5616B106A26C9@DM6PR12MB3018.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <318efeb6-eb1e-474d-0fb6-8752698b3230@amd.com>
Date: Mon, 15 Mar 2021 11:52:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <DM6PR12MB3018F5411F3181EA5616B106A26C9@DM6PR12MB3018.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.190]
X-ClientProxiedBy: AM0PR01CA0180.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::49) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.190) by
 AM0PR01CA0180.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Mon, 15 Mar 2021 10:52:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 227e77cc-3677-4e57-4e6d-08d8e7a06a4c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1240E75AD63B58980CFF20958B6C9@CY4PR12MB1240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lszKyJMdElfGZt4A162v3Av/IwPFVv5dTUbVY++USVHf96cbhgBQuiicZfMapREawxJ6lbPet29b39u6TEXJEwxzyU06jfHLXlNXAJMGygxOsXqHYGZotd0W1OTDUOS86LYwPn7j6vTH/BQBYaqFcXo5t78xnhmrWscvUYbFtyMx2j7hwatWr8kQcJgEGKKdVIee+TGEfTHBQn4DNaL55h/1Vnm/cBQhjznsl7fEb7fze05wY5dFOu53NN2rnIkCZv7LWW9V8ANrfj3Bp4tYbV8HPi0C9abDcDUontL9c+K2ZHabpC1XA4t+pElOPU740u09G/PiDlRbA/cPFJrk4auYA4mO1yKFFOAAk5P5fND3dyEtNTORTAmWuJzbinqIs9QRrLQ+4Z/fg0FUAz+9RHyRBNdG09z1WeMdBccQotr1jdQ9TCyL/iZG7/OPXxQM/rzfN56N4N1ZuBo3iQD5VcJ0NW6tFZQQEPbc5y5BUXdQhsLlUsf72L3hTYMWc8Xu8pUZ8eUyN/X5gCAPtjyhssm3QWogT0F+Go0f+r6kuV+9YDR9A3cuY8kOs534qFqaVMTuclBQg3XxXSOiKM1eMtVG+xRPFKKnZkE38DtEIpb73Dj64L0vZT2jDEN/YvBZ1Hk1YfKXZtbBNhTpHdjzEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(31696002)(45080400002)(16576012)(186003)(26005)(478600001)(8676002)(966005)(2906002)(66946007)(956004)(16526019)(66476007)(2616005)(31686004)(4326008)(19627405001)(83380400001)(8936002)(316002)(36756003)(6636002)(6486002)(53546011)(33964004)(66556008)(52116002)(110136005)(6666004)(5660300002)(166002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXBpU0lDbWFlT280L3JiYnpHQU1uWkVjck80aTE0WU9ldUpFdDZJYXI2SHFv?=
 =?utf-8?B?aERDL05OWEJTVmdram5LWktEMGJrQndkSy9HNlR3Y0JvWGR4a0ZiZXp0c3hO?=
 =?utf-8?B?SXk2NWkxb2w4UFdWemVzZXVqM1djd05wWmtTY1hsb2N2OUx5aU9OSTQ0SEQ0?=
 =?utf-8?B?MmN0cHpmOEtNcnc4VWlJQzFtVXhBSmtERlRjM1lIMTg0dW9hS3dITVNNa2p2?=
 =?utf-8?B?cUtGb0pKS0s2TkJ0Sm9WbFlwLy8xUHBpbFR6Z3ZQMm9UR3k2QVhkT3N6M0sr?=
 =?utf-8?B?SEdBQW5rUVdET0RWRk1Sb0VsWkxyQ3lnVFd5eEdWS1UxYloyNzRZZkdUNzdQ?=
 =?utf-8?B?Sm5sQ0MyNHhnRGYwd2taWkphM2VDV2dUczNibmo2cU40aXd0REs1UGJoMld0?=
 =?utf-8?B?S0JheUZXcDF6WEhsMVdKR2NiekpxRmRQaXBycGJER1hxVDk3Ykk5NUFDcHcw?=
 =?utf-8?B?YzF5UmJtU2dhaG1DaDVKWExzVHc5cVczWStnNkw1bEV5bWhJQzFBV0grc2Ey?=
 =?utf-8?B?YlJ6SnBVdkc5UWVzMXAwTkgxWmFRcG05aUVjdDQ4UHJYcjFqRHpCT2VSWUFU?=
 =?utf-8?B?QXIrTTdITmYrZGJORTJldWkrS0R0d0t6SVNRZ1dFV2tvNEFYS0IvWWZORmgx?=
 =?utf-8?B?a2tvaGt2cGxvV0tHdllpdFNrcy9md241eTR6WVlGT3pSdjV3SnI3dFdKcjZk?=
 =?utf-8?B?U0ZpMnhwZm05QWNzRVp6b1pXaEdYTE1hVTdNOHl0LzJLQ3VWSlVvVk5VTkFk?=
 =?utf-8?B?NGNoaDAzR3N4bGtqcytUcHhrc3NVVEkzUk0yeVQ5bWswTnI2eVNYNW5VWlZs?=
 =?utf-8?B?eFE5MGJ1QVlmL3dVclFIM2pTT1JVd0tlSVhXc1JXRGJmM1pPR1BpbGJzOWpm?=
 =?utf-8?B?dlZ5SmdVdGluMlpjSXpkK0ptMmo2L01TR1A0VlVaVTUxU0tpTFcvRzJNVXB4?=
 =?utf-8?B?SWVYbm13YmxZK250dyttck9uK1hoVEh2Y2YzVTY3aDRGWWR5SEkxNnY4Q0V4?=
 =?utf-8?B?SE0rTjh3ZHhCNnJlYTE4VitNMml5M1dERERlNHNvcnZTeU9jaUJjUlRVQmZq?=
 =?utf-8?B?Tkt3WWtHV1liVzdHZUl3QXJFaktLekRxRUtTcnAzZGFhcDdldTFUWkMvemNj?=
 =?utf-8?B?cXNBWjcrZW1ycElycGpzcUM5bytPOVQ4Q0doK2VnU3VCM2twMFRMclREQ2Ru?=
 =?utf-8?B?Tm1FdURTU2dCU090WTc3bk9ERitoKytJcjJPS252amNDalp1TWp0UmxybTRV?=
 =?utf-8?B?SUFLUk45N0trNmVhZkJuVzBPdWtZbHVtKzA2QWtJbVR3a1RCL2hHZWRDUisv?=
 =?utf-8?B?cWprUWwzeFNuanRkTzRINHBwWXJsYnJZNHRad3daWlExcTNVUmtzNWRhUkpq?=
 =?utf-8?B?NldBTllZaUF0MUhjS3M3TDhsaUREOHZrdVdtQmQyT29wWHNjYXppZXU4Qjlo?=
 =?utf-8?B?UTFqMXpIUVp6ckNmU3dydm1MREwrc0I4WW5xc1lxQWFiVndBZTVseFNXZ0VQ?=
 =?utf-8?B?ZGRtR1JWZFVINXZjVk5vZFRXUzhQVERncFF6M2dkVkM4bHJrUWMzazhLeUpn?=
 =?utf-8?B?TDJnQnh2TCtFUFJQUWxlcUh0OUEvOTlaTFpxeU1vS2VhYUIzRGZyMCtESjNk?=
 =?utf-8?B?aSs1SDgyOVQxUkhBeHppNE1vUW5yaHZtOG45L0VtY1Z0WmZuMFgwRS8zcVcw?=
 =?utf-8?B?OWROalpFNTQyeW4xV2ZHamZ1eGdsUDZ0T2MxU1pOU3pDUk44MEdKY2F4Wmtu?=
 =?utf-8?Q?V6aB8amXUlth40fcDlvc7++X6MH1EgMu2gMvbDU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227e77cc-3677-4e57-4e6d-08d8e7a06a4c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 10:52:24.1802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7JSbmxgdE0wqzysHd57/BHOTjyLUMiIU0tAIXFK3NBXIjQxIqEdmOQVe1d7b62cmLYO13eElYJgllyD5JhMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1240
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0338556719=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0338556719==
Content-Type: multipart/alternative;
 boundary="------------88A56DC84ADC679D2EF0988D"
Content-Language: en-US

--------------88A56DC84ADC679D2EF0988D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/15/21 11:32 AM, Wang, Kevin(Yang) wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Das,
>
> It seems more reasonable to put spin lock in ring structure, so that 
> KIQ ring can be treated like other normal ring.



We don't use locks for other rings though.


> and do we have other paths to call kiq ring except for kernel 
> initialization? it seems the kfd and kgd will use kiq in one thread..



This patch is for consistency. It is not fixing any issue/bug.



Nirmoy

>
> thanks.
>
> Best Regards,
> Kevin
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Nirmoy Das <nirmoy.das@amd.com>
> *Sent:* Saturday, March 13, 2021 1:08 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>
> *Cc:* Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Subject:* [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
> KIQ ring is being operated by kfd as well as amdgpu.
> KFD is using kiq lock, we should the same from amdgpu side
> as well.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1915b9b95106..892dc6b269fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -462,20 +462,25 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device 
> *adev)
>  {
>          struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>          struct amdgpu_ring *kiq_ring = &kiq->ring;
> -       int i;
> +       int i, r;
>
>          if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                  return -EINVAL;
>
> +       spin_lock(&adev->gfx.kiq.ring_lock);
>          if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
> - adev->gfx.num_compute_rings))
> + adev->gfx.num_compute_rings)) {
> + spin_unlock(&adev->gfx.kiq.ring_lock);
>                  return -ENOMEM;
> +       }
>
>          for (i = 0; i < adev->gfx.num_compute_rings; i++)
> kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
> RESET_QUEUES, 0, 0);
> +       r = amdgpu_ring_test_helper(kiq_ring);
> +       spin_unlock(&adev->gfx.kiq.ring_lock);
>
> -       return amdgpu_ring_test_helper(kiq_ring);
> +       return r;
>  }
>
>  int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
> @@ -518,12 +523,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device 
> *adev)
>
>          DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, 
> kiq_ring->pipe,
> kiq_ring->queue);
> -
> +       spin_lock(&adev->gfx.kiq.ring_lock);
>          r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
> adev->gfx.num_compute_rings +
> kiq->pmf->set_resources_size);
>          if (r) {
>                  DRM_ERROR("Failed to lock KIQ (%d).\n", r);
> + spin_unlock(&adev->gfx.kiq.ring_lock);
>                  return r;
>          }
>
> @@ -532,6 +538,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
> kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
>
>          r = amdgpu_ring_test_helper(kiq_ring);
> +       spin_unlock(&adev->gfx.kiq.ring_lock);
>          if (r)
>                  DRM_ERROR("KCQ enable failed\n");
>
> -- 
> 2.30.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=sfa27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=sfa27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;reserved=0>

--------------88A56DC84ADC679D2EF0988D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/15/21 11:32 AM, Wang, Kevin(Yang)
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB3018F5411F3181EA5616B106A26C9@DM6PR12MB3018.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">Hi Das,</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);"><br>
          </span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">It seems more
            reasonable to put spin lock in ring structure, so that KIQ
            ring can be treated like other normal ring.</span></div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p><br>
    </p>
    <p>We don't use locks for other rings though.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:DM6PR12MB3018F5411F3181EA5616B106A26C9@DM6PR12MB3018.namprd12.prod.outlook.com">
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
        </div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">and do we have
            other paths to call kiq ring except for kernel
            initialization? it seems the kfd and kgd will use kiq in one
            thread..</span></div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p><br>
    </p>
    <p>This patch is for consistency. It is not fixing any issue/bug.<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p>Nirmoy<br>
    </p>
    <blockquote type="cite" cite="mid:DM6PR12MB3018F5411F3181EA5616B106A26C9@DM6PR12MB3018.namprd12.prod.outlook.com">
      <div>
        <div><br>
        </div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">thanks.</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">Best Regards,</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">Kevin</span></div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com">&lt;nirmoy.das@amd.com&gt;</a><br>
            <b>Sent:</b> Saturday, March 13, 2021 1:08 AM<br>
            <b>To:</b> Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Cc:</b> Das, Nirmoy <a class="moz-txt-link-rfc2396E" href="mailto:Nirmoy.Das@amd.com">&lt;Nirmoy.Das@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> [PATCH 1/1] drm/amdgpu: wrap kiq ring ops
            with kiq spinlock</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText">KIQ ring is being operated by kfd
                as well as amdgpu.<br>
                KFD is using kiq lock, we should the same from amdgpu
                side<br>
                as well.<br>
                <br>
                Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com">&lt;nirmoy.das@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15
                +++++++++++----<br>
                &nbsp;1 file changed, 11 insertions(+), 4 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
                index 1915b9b95106..892dc6b269fb 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
                @@ -462,20 +462,25 @@ int amdgpu_gfx_disable_kcq(struct
                amdgpu_device *adev)<br>
                &nbsp;{<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =
                &amp;kiq-&gt;ring;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kiq-&gt;pmf ||
                !kiq-&gt;pmf-&gt;kiq_unmap_queues)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                &nbsp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ring_alloc(kiq_ring,
                kiq-&gt;pmf-&gt;unmap_queues_size *<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.num_compute_rings))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.num_compute_rings)) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i++)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                kiq-&gt;pmf-&gt;kiq_unmap_queues(kiq_ring,
                &amp;adev-&gt;gfx.compute_ring[i],<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                RESET_QUEUES, 0, 0);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ring_test_helper(kiq_ring);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ring_test_helper(kiq_ring);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                &nbsp;}<br>
                &nbsp;<br>
                &nbsp;int amdgpu_queue_mask_bit_to_set_resource_bit(struct
                amdgpu_device *adev,<br>
                @@ -518,12 +523,13 @@ int amdgpu_gfx_enable_kcq(struct
                amdgpu_device *adev)<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;kiq ring mec %d pipe %d q %d\n&quot;,
                kiq_ring-&gt;me, kiq_ring-&gt;pipe,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                kiq_ring-&gt;queue);<br>
                -<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ring_alloc(kiq_ring,
                kiq-&gt;pmf-&gt;map_queues_size *<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.num_compute_rings +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                kiq-&gt;pmf-&gt;set_resources_size);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to lock KIQ (%d).\n&quot;,
                r);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                @@ -532,6 +538,7 @@ int amdgpu_gfx_enable_kcq(struct
                amdgpu_device *adev)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                kiq-&gt;pmf-&gt;kiq_map_queues(kiq_ring,
                &amp;adev-&gt;gfx.compute_ring[i]);<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ring_test_helper(kiq_ring);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;KCQ enable failed\n&quot;);<br>
                &nbsp;<br>
                -- <br>
                2.30.1<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=sfa27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=sfa27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;amp;reserved=0</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------88A56DC84ADC679D2EF0988D--

--===============0338556719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0338556719==--
