Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88CC4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 21:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C489160F02
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 21:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C489160F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6122C6EB5C;
	Thu,  5 Aug 2021 21:13:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395EC6EB5C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 21:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqnNTspeDu1tPzm2ngO25Mrs8zGF7Bc4xCpXsDRn8k6HlGCfs8+5CdLn+WgyVR1GPwIy0uRTDHHUvnPgmPbZOoNI5EJZit28TmQYP06W04Q0TFNKhxvUvFmlSedET9J/jprNsO5wKm5smgJv1XkeQ8cciAz13S1lVud+dDqhVdZh6GAD05nS14FmT2GpmvVtWdmNw4jaSqMGT4MyGe6mpmn/Ba78aPjqF5IrLMKCcAHFi9EoRD9AyqBgsrMMEoNGb+tshLbyNenHJSmmyjlLrLOBOWigsrQkabJydT/5NR4xoquJuSSeTe7GMeTBmJlliH3YrhrPcdjwBE0yWGj69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO8DSqajtHEGKkEn4+tcmhUkLveHzwQCH6BUNJ2mAnI=;
 b=bcuKOEfGdRMyrN22QT67rW0akWM1kwhQ7u0lNvOwLQFS6ZT02k/FH3DUlScXWsdd+xNw96H/iQsoiEPXwjbOKQWkHkBKBzCu9OB7UfcamhhfsZ2mDL3fCIg/c4WPHs0hKEfy24Dk4d5O+PIEXSe2TPzZZgKe+TlZrZ31fHd9wegmcIMxrU+28tII/EQ97cuVIOYAFC8DBbZZps353upnqF7Jm8pfB84WSHgJ7oMmsK6OFGEX584Fgc+NbUWryLwoR0Lc1krEUoUFvAWHCnAKoSHiMgN2X4owh1n/J0bWj2Z7XdjOklt7RIhOxk0fX67OujWTwINZXdVU3u/EJh/l1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO8DSqajtHEGKkEn4+tcmhUkLveHzwQCH6BUNJ2mAnI=;
 b=gnapJa7xbs0cS7PKnkIeJCng3Tg5noIBg1WnRmXwR+k/NE6Z6IDFWeQGGugY2hHRY9SUXgFsZmiOg6ClkM0nJDP6btHHmwUEAVvRV5WJ0mdlm1xBGelHvzc2nF73j3o1lleOfZx4ME0C14o6u+ZrausnaoVMwvAuGXfuXzlAzYM=
Authentication-Results: hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 21:13:24 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 21:13:24 +0000
Subject: Re: [PATCHv2 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, christian.koenig@amd.com,
 Jack Zhang <Jack.Zhang1@amd.com>, Jack Zhang <Jack.Zhang7@hotmail.com>
References: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f3ddf3e1-bbc5-f42f-d9f3-7306ed4b9f69@amd.com>
Date: Thu, 5 Aug 2021 17:13:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:e014:e627:6bd1:e20e]
 (2607:fea8:3edf:49b0:e014:e627:6bd1:e20e) by
 YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 21:13:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4cc2bad-5b53-4705-d6f5-08d95855dc99
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44169EE4B85B7B022651DA0CEAF29@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:343;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lt8Sm5cVvw8ij3+57jnIWY/x9sk2p5jFpPbLd2VNMiXFJC5N0YI2Mng0RDVs8OMXTr/Uieinr0+oP5raUI0zlxCWqhd5GIRPX5bAy9Wkkt328BzI3UwJ8oCoKzUDvYEioTzejemmyHnHQ6le6Bw85lApQyD20ahf28wlXzetuqEXs2Sv7CEkbrdNZZ4cCfaN/XjZYjtiHCW3ehWcf2jIJiA1upigtCAzD5KVIzYxbFzwztlhj7NAseBiQyxRDDqI+UwlxaoTAgS++wOSsGogKDN+af2BP7bGnHGxM40efCm+tbZCjkL/u/HQ8MQzn+qbn2+gaV+8+f/siPxEopOl/UIrysHnWAkcyZkXaqGfwAl1A4YDmdaz8Z8RVH6PI0FaCjCXXk7sz21IuevoIFKWToZu5IG58LkZfYpWYxn+4beb40dCyA6xreTw86nMwyNTYin5pLJj17Qvm+U+vkICVT0qux7rAu9kPxPbKX06vvZttCy89QJhAekHZqe9UIP3Z5GZrYI/5DvAVA4vAvv71HBWmnfLOEcF5JTHyPQ6vrDB3GlmPU3R3ea4zFGqhy2SHeHfxbm0GeQMHtR0XdA0UNZkdt8x/lHool6gQLxV8qhaaqF22zhgiQYfODnqcQs0S8mt8NF2dB0tjXucbsjKRYKJ4Ix29gF80BI5eg8gGud77Lnldhh31/1DbX4uDopZP6/wja7QEfmLlnTCAILLYGHoIE4BEgdY2sgywHDQUmi9AQ9If/U2x/6dKN/GyaqR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(53546011)(2906002)(316002)(38100700002)(2616005)(44832011)(6486002)(54906003)(4326008)(45080400002)(5660300002)(30864003)(31686004)(478600001)(66556008)(66946007)(66476007)(86362001)(186003)(31696002)(36756003)(8936002)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm9PRUdzVFRyWlNTSTBFZUJVZ1ZQbWxkbGdWQjJxVkNISHpPWFY1L01pYXFm?=
 =?utf-8?B?anJUcXZRQVZOR2JmUzdwRktwK2JtYkd4VEZ0QmhLOCtoUWMxZS9hVVNsSWJN?=
 =?utf-8?B?UkpyRFFML2ZMaXh0SDA1ZFRIU2RwRng5eDU5UUN0V2p3R0ptVEVlZUNVNFJS?=
 =?utf-8?B?dHJyVEVjRWE1YXE0Z2pONjhpMHdmZ0JSOU4xTlAvbXdzMFZOWWphalRVMklD?=
 =?utf-8?B?QTR5OWNpeHd3NkRnZTFSeFBmZHlrZTFiWWc3dlhVZk03enZXK0xUaG5vcU8z?=
 =?utf-8?B?U1AvU3FldXdzYjdDd3Z3RVlQZG8rYjEwOWNUaERHMkZweGQ4WXBJK1BkaTJn?=
 =?utf-8?B?ajBhY3hUUXNBc2doQnp2RXBybVhrQTh6ODN1ZkprdGdzWWFaZXN0ZjJRQTls?=
 =?utf-8?B?WG14WERrN3BETk5UdkxTbnpGbUNpbGVBdGlDL3hWN2xTZWdOZHlTS2JLK01p?=
 =?utf-8?B?VDZsYm5nU0Y5NER0emZQUytMSDU1K1Mvd0srUGtUcGhlUVIvaVlkakQ0YjRn?=
 =?utf-8?B?M3hkb2JKeXNlYXVHbmtGTmxiWTVUMkVZOHlraXdKVUxCZXVwc3loRFRnckF3?=
 =?utf-8?B?eGVENHdsWldPT1BTZzVoUk9aL05iWEJWMXdnQW1FZHg3WWtzbXRuVkRvODZw?=
 =?utf-8?B?cHJUYXJaeSt6YUM4OFJDZFJGRU1mRThMcEFmUGprM04vUmdpSTd0RFluVW92?=
 =?utf-8?B?aWRjSlhRa21UNmhuZ3psUTduV3Vsb2IxT2I3RDZPUFVQTDJ6Zml6V0NTbnhY?=
 =?utf-8?B?Wml3MzV6dmNmeXB1VVZBUStCMjhoeXZlcU1PVTFvZUZOcXAxckNlU21Mcjdq?=
 =?utf-8?B?TzJoeitTTWtLYnN0Q3VYYTI0SHFOWkRWVmFhamJSYThwWERONTRlUFlWb0xU?=
 =?utf-8?B?S1k0UTlTVlJNNGorNU5DUGh4emNNMlJRYmFkc1haWVh0NlkwVVREb3F1aDRM?=
 =?utf-8?B?MDkzWkM2THBOVXcyd0VONjlJYmVmWjY0cVQxbjBCQVFkZnYrNXJ5WVVSMmha?=
 =?utf-8?B?NExIOTNCS0RIaGx3ME5wRUdxTTBXT0l0UUFkaHY2aUNNY0gwZWRDYWM2TGVi?=
 =?utf-8?B?Nmt6a2FhVng4TnlBakFuM2tWZ3RaNHUrdUpWMm84TXNPTU5EVHNoVHFGY0tr?=
 =?utf-8?B?UFFlU0tXQ0VkaVpxazU1Tm5kOS9kTHZQdGtHb0ZwN1YvVHRhMk4ydXJaSlVt?=
 =?utf-8?B?TVYwZ3ZlbDRHb25BTVRMRklERjFycXBJMDkrdHpVZiswQkVmYnNueHNrNDNY?=
 =?utf-8?B?YjI3VTRCTUdkMS9uZUxtQ09wSnNFV01Yb00wTHZVUGxDQUpxVVhVUExWUWNH?=
 =?utf-8?B?dEJGTUdJZkE4RktHTzEyOXZPQ3Y0MXh2Yll4TytpVGlSdzdYMlp4RVNGbXdn?=
 =?utf-8?B?Ry8vTVh2aWN3MmQ4SERnTlU0bnIzVVI5U2oya21ldmFXSGZ0NzJwYzd5eDdK?=
 =?utf-8?B?UGxWbGNVMTBycnhFbzVna0UrTU5ma3NlbDBjdHprVE1iLzdUL1I1eDJmVnJL?=
 =?utf-8?B?ZWh5enhjR0UzMk9LM3pKUmI1d01rd1JKclljZVcyQ0wvVDlYUFh6dHFCV0E3?=
 =?utf-8?B?MkEwOHFscU1FaVRhNjkxZytrWm1nckVyTE56bnMxMFBjWEZ2S2FVT1ZNa0N1?=
 =?utf-8?B?VHRDMnh5dHQ0Q0swMHd1Q3dZd0VTZE83clpEMWRPbTNiSjdJcitSRWg1anNj?=
 =?utf-8?B?QXlyNm5GZnErYWZLTHpVbXBDSHJCbnNzcm1oTE9QYWVwMEUzUDVKNHRYY1M2?=
 =?utf-8?B?TjBtVnpnWGQ3cXN5cC9sTzZFUVd3ZWZIbzJZNFJvTERDZkhXMS8xbk5aSHFk?=
 =?utf-8?B?QzA4RFQwbGVTNXd3eDQwU3kwQjJSN05ZUmg3b01KcCtZdXNhS3RBeUxKQ3JL?=
 =?utf-8?Q?3Mn5KmLyZN7R6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cc2bad-5b53-4705-d6f5-08d95855dc99
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 21:13:24.7389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJvB/2b0TTaoT0bo9M04QP6EHiQ1Vq5CFLcYVQ8bFp0SZQ2pVdklCilk97DWBoYEgHILryTzC+1BiHEQCmUIag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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


On 2021-08-05 4:31 a.m., Jingwen Chen wrote:
> From: Jack Zhang <Jack.Zhang1@amd.com>
>
> Why: Previously hw fence is alloced separately with job.
> It caused historical lifetime issues and corner cases.
> The ideal situation is to take fence to manage both job
> and fence's lifetime, and simplify the design of gpu-scheduler.
>
> How:
> We propose to embed hw_fence into amdgpu_job.
> 1. We cover the normal job submission by this method.
> 2. For ib_test, and submit without a parent job keep the
> legacy way to create a hw fence separately.
> v2:
> use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is
> embeded in a job.
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 63 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 35 ++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>   8 files changed, 84 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7b46ba551cb2..3003ee1c9487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>   	ret = dma_fence_wait(f, false);
>   
>   err_ib_sched:
> -	dma_fence_put(f);
>   	amdgpu_job_free(job);
>   err:
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 536005bff24a..277128846dd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>   			continue;
>   		}
>   		job = to_amdgpu_job(s_job);
> -		if (preempted && job->fence == fence)
> +		if (preempted && (&job->hw_fence) == fence)
>   			/* mark the job as preempted */
>   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 7495911516c2..5e29d797a265 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -129,30 +129,46 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    *
>    * @ring: ring the fence is associated with
>    * @f: resulting fence object
> + * @job: job the fence is embeded in
>    * @flags: flags to pass into the subordinate .emit_fence() call
>    *
>    * Emits a fence command on the requested ring (all asics).
>    * Returns 0 on success, -ENOMEM on failure.
>    */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
>   		      unsigned flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_fence *fence;
> +	struct dma_fence *fence;
> +	struct amdgpu_fence *am_fence;
>   	struct dma_fence __rcu **ptr;
>   	uint32_t seq;
>   	int r;
>   
> -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> -	if (fence == NULL)
> -		return -ENOMEM;
> +	if (job == NULL) {
> +		/* create a sperate hw fence */
> +		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> +		if (am_fence == NULL)
> +			return -ENOMEM;
> +		fence = &am_fence->base;
> +		am_fence->ring = ring;
> +	} else {
> +		/* take use of job-embedded fence */
> +		fence = &job->hw_fence;
> +		job->ring = ring;


If you would make hw_fence of type amdgpu_fence
you could probably avoid the special job->ring = ring
See more in related comment at the bottom


> +	}
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	fence->ring = ring;
> -	dma_fence_init(&fence->base, &amdgpu_fence_ops,
> +	dma_fence_init(fence, &amdgpu_fence_ops,
>   		       &ring->fence_drv.lock,
>   		       adev->fence_context + ring->idx,
>   		       seq);
> +
> +	if (job != NULL) {
> +		/* mark this fence has a parent job */
> +		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
> +	}
> +
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
>   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> @@ -175,9 +191,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   	/* This function can't be called concurrently anyway, otherwise
>   	 * emitting the fence would mess up the hardware ring buffer.
>   	 */
> -	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
> +	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>   
> -	*f = &fence->base;
> +	*f = fence;
>   
>   	return 0;
>   }
> @@ -621,8 +637,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
>   
>   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>   {
> -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> -	return (const char *)fence->ring->name;
> +	struct amdgpu_ring *ring;
> +
> +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> +		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +
> +		ring = job->ring;
> +	} else {
> +		ring = to_amdgpu_fence(f)->ring;
> +	}


Same as above


> +	return (const char *)ring->name;
>   }
>   
>   /**
> @@ -656,8 +680,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   static void amdgpu_fence_free(struct rcu_head *rcu)
>   {
>   	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> -	kmem_cache_free(amdgpu_fence_slab, fence);
> +
> +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> +	/* free job if fence has a parent job */
> +		struct amdgpu_job *job;
> +
> +		job = container_of(f, struct amdgpu_job, hw_fence);
> +		kfree(job);
> +	} else {
> +	/* free fence_slab if it's separated fence*/
> +		struct amdgpu_fence *fence;
> +
> +		fence = to_amdgpu_fence(f);
> +		kmem_cache_free(amdgpu_fence_slab, fence);
> +	}
>   }
>   
>   /**
> @@ -680,6 +716,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.release = amdgpu_fence_release,
>   };
>   
> +
>   /*
>    * Fence debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index ec65ab0ddf89..c076a6b9a5a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
>   	}
>   
> -	r = amdgpu_fence_emit(ring, f, fence_flags);
> +	r = amdgpu_fence_emit(ring, f, job, fence_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>   		if (job && job->vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d33e6d97cc89..65a395060de2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -127,11 +127,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	struct dma_fence *f;
> +	struct dma_fence *hw_fence;
>   	unsigned i;
>   
> -	/* use sched fence if available */
> -	f = job->base.s_fence ? &job->base.s_fence->finished : job->fence;
> +	if (job->hw_fence.ops == NULL)
> +		hw_fence = job->external_hw_fence;
> +	else
> +		hw_fence = &job->hw_fence;
>   
> +	/* use sched fence if available */
> +	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
>   	for (i = 0; i < job->num_ibs; ++i)
>   		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>   }
> @@ -142,20 +147,27 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   
>   	drm_sched_job_cleanup(s_job);
>   
> -	dma_fence_put(job->fence);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> -	kfree(job);
> +
> +    /* only put the hw fence if has embedded fence */
> +	if (job->hw_fence.ops != NULL)
> +		dma_fence_put(&job->hw_fence);
> +	else
> +		kfree(job);
>   }
>   
>   void amdgpu_job_free(struct amdgpu_job *job)
>   {
>   	amdgpu_job_free_resources(job);
> -
> -	dma_fence_put(job->fence);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> -	kfree(job);
> +
> +	/* only put the hw fence if has embedded fence */
> +	if (job->hw_fence.ops != NULL)
> +		dma_fence_put(&job->hw_fence);
> +	else
> +		kfree(job);
>   }
>   
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
> @@ -184,11 +196,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>   
>   	job->base.sched = &ring->sched;
>   	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
> -	job->fence = dma_fence_get(*fence);
> +	/* record external_hw_fence for direct submit */
> +	job->external_hw_fence = dma_fence_get(*fence);
>   	if (r)
>   		return r;
>   
>   	amdgpu_job_free(job);
> +	dma_fence_put(*fence);
> +
>   	return 0;
>   }
>   
> @@ -246,10 +261,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		if (r)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
> -	/* if gpu reset, hw fence will be replaced here */
> -	dma_fence_put(job->fence);
> -	job->fence = dma_fence_get(fence);
>   
> +	dma_fence_get(fence);
>   	amdgpu_job_free_resources(job);
>   
>   	fence = r ? ERR_PTR(r) : fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 81caac9b958a..92324c978534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -46,7 +46,9 @@ struct amdgpu_job {
>   	struct amdgpu_sync	sync;
>   	struct amdgpu_sync	sched_sync;
>   	struct amdgpu_ib	*ibs;
> -	struct dma_fence	*fence; /* the hw fence */
> +	struct dma_fence	hw_fence;
> +	struct amdgpu_ring *ring;

Why not instead of 2 fields above just embed   struct amdgpu_fence as
hw_fence  and by this save the extra 'ring' field handling ?

Andrey


> +	struct dma_fence	*external_hw_fence;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
>   	uint32_t		num_ibs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 9c11ced4312c..03d4b29a76d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -48,6 +48,9 @@
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
>   
> +/* fence flag bit to indicate the face is embeded in job*/
> +#define AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT		(DMA_FENCE_FLAG_USER_BITS + 1)
> +
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
>   #define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
> @@ -118,7 +121,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
>   		      unsigned flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>   			      uint32_t timeout);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2a88ed5d983b..2af8860d74cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1218,7 +1218,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
>   	if (vm_flush_needed || pasid_mapping_needed) {
> -		r = amdgpu_fence_emit(ring, &fence, 0);
> +		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
>   	}
