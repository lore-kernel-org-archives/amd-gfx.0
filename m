Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E6C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 22:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A8720719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 22:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LS//ci8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A8720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2B06E358;
	Mon, 31 Aug 2020 22:04:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FF76E358
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 22:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiYfu1RCjcCXtIQOq2KlrIMFG3OvvSOv2WVIwO9FRrGvY5Mur8vEJtMFVWmpp9v90i3J7ihC4clxJGPj0iR0vp6rnglbN5o/kO+/jS7pu+61rkq0LbL8s32Qs+YbgGd8FJ9W1cLAYIk/1SHQpBkmGtOkDv6BNhEV6uLaipxiCIdqDtq01lbFV4giKCOk1aXHJDb8SJyY38xOANvLxIKBk3O4s9JP+iiMnhI+cKpEdfTBr52EHS5ZX1xTQx2tGCVW7MAM8yuhvAR4Gq/7KonGDjCwzjlZIglBXi5N1hiZTe3n3OdNYWQ8jHOkMxGEchgcxTRxlZNq+Vn3RYIlWRZYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkZsdKkTtXJT5GuQU+3tnJLltBp+sndbjRHTSjhAuKQ=;
 b=iTaTy0sZWHz3bCGfhvKQXGKyVSLo0biXE9KyiXYvxrkbEJ/JLZY4sK8F4Bor7zjjeFgf3pKbZKJDOitmx44u1TdWRM935kRYZq4HIM5zWqaBOO7/Fwi/Nryszjb0uBH37v2xj2iwxJWJHsXCBuNcCF6i2iery/Kk1HrF+Nkv2Qxdu2ZC/5S/hSQ0kOkmlzn34d4IhG4Sya8xMRrjMmVkTzVB/mBl70nKtwxyH8e2MCSjtb73JYrMnD49lMHBgaoxu2e86VAIjtKF9aiSSQsm/HNpUWbE+GqeLdX5yq1CqCveQxFC9s8LFrrhr+bDXzCeuvMTDhCg8Pilmyn1d7xuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkZsdKkTtXJT5GuQU+3tnJLltBp+sndbjRHTSjhAuKQ=;
 b=LS//ci8kQpBY06nFFrxDxERk4aziKBlqkH6MKWj88ukGjt4R7PPDT0CxWPKk+lSqSY84KkSnGRVYjpINfMHRRRD9dZe5/p0q1qGQWiKNftGdr4sZFtIEd1dQi/fFqoxKmFwE0ynFzs0BQz1t0ASj7jg8QNuasVDO7g2DAJM8Eyg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Mon, 31 Aug 2020 22:04:35 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 22:04:35 +0000
Subject: Re: [PATCH v3 3/8] drm/amdgpu: Block all job scheduling activity
 during DPC recovery
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598889049-28321-4-git-send-email-andrey.grodzovsky@amd.com>
 <3f9efceb-cb2c-70a8-43aa-0039bf28c64a@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <f3f420f6-bbdd-6a0b-b185-1de224b7760d@amd.com>
Date: Mon, 31 Aug 2020 18:04:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <3f9efceb-cb2c-70a8-43aa-0039bf28c64a@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 22:04:35 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:1802:46a:68a:71ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99886ab3-90d0-4e4b-332b-08d84df9d8ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2584D54AD7B62344D5FCFF93EA510@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTxhhl5wiC0F3O4J+fQzlcAAWlLIEEDXb8CRN934QB42Me+lcN6T5PbshdWhgpq8jW2dK3SSEoW8eIRsFzwrnz2SBTZY2b7pgNfW94+XNw/tGdXRQniKQvQEVnILYwtyKFqMjsm3ekKSc5dOhyoY5uaYRAKyJBfZQiAujTje0FwDjF2Tl7VFKcr84y9OnbuvUzpQ6DUv+kdkv5X/KTDMj4xtEUO68GM0PybXB2M2T2fbVwN5ZKlvjhDNfbdsKasXb55yWevT+GkczqQ4jF1r0S3nIIn98xbMhjdtowzX1D1teiq+oV5LdlEkuTz3P9slFA8FUqjhZpiNA9BA1BKBCj3ny/2IRc5XyIYnrHMGpXYzpCaPu6FYTU/hxJKdPz1F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(31686004)(6486002)(16576012)(2906002)(2616005)(6666004)(4326008)(956004)(8936002)(53546011)(5660300002)(8676002)(66946007)(478600001)(66556008)(316002)(31696002)(86362001)(83380400001)(66476007)(36756003)(186003)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RwbltH7B4ut2yjsyARsuYSnK5/j6ODkFrls8cEHYlngjxv64KSw6g1g2pbslH2e1wxXX2EBkt5jiGbc4Ygx2rbyDp9kkluJe+h9fJEIGwsvPxJeoOACKqaxXRQJ0aLo6YaTBEngxvEjJ2yUUBmpQ2QEtCkMGYqzALiWepGY6O7FwvOEbyINWTF/W6ngqVAYUDj4KSglhcFmQ1Tyzj/gbU4eQLbDm+V0NMOnZWlpxs4CIUwHgySvUfdfqdNn7cKLBG45ulMoDMUs+Lg/XmD/luhzF9SX6Z1loUT31y+vlWyePKvyAOFMooKyut5Zy+l0AMcBmoABcnfyyTrm6oO6oWGUogH85JBbQLhqP6CgE9VS1YRvFVQU4hs1hCSpMlZX8D+wb1HCjutyBcce/ngNNV7WnF/oot7syjDQsYyhXyjzpS19qFIWgs1MJW1Qt3X0Cq+t+cQ0PgrLIaPs4N4f8MxmsqhMeuxNRk4F379c0kdYoLRK3iC1e3jGig5SIR6+OYqKadRZq9C1aK6riQKTVgKxMug48xtkR8CHrF40Ckdx8GipuZHTmofiaL4bJtjPctb1NbpYaYH6psQkpwbdJBORZTOzC6Z42LJsIKaKs5op/Yai5quVVQL6bBwEhAWw18A8MGjLFKy6L8YYT2y796AGeHmbbn+8kJdMNeVSIbDY2MmwAiKfJAM5luzesIcG4rP/FXwoegEUSxkSleTRy/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99886ab3-90d0-4e4b-332b-08d84df9d8ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 22:04:35.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D50YQFVjDUhl55O7F5VsyEhxN3RBT2+JtdShlQmSDONSaxqIGzetHUlLY6OKufd0Fv7S3oJuUtDk13TQaRD5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/31/20 5:00 PM, Luben Tuikov wrote:
> On 2020-08-31 11:50 a.m., Andrey Grodzovsky wrote:
>> DPC recovery involves ASIC reset just as normal GPU recovery so blosk
> Again, typo: "blosk" --> "blocks".
>
>> SW GPU schedulers and wait on all concurrent GPU resets.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
>>   1 file changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 43ce473..c569523 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4743,6 +4743,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>   	return 0;
>>   }
>>   
>> +static void amdgpu_cancel_all_tdr(struct amdgpu_device *adev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +		struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +		if (!ring || !ring->sched.thread)
>> +			continue;
>> +
>> +		cancel_delayed_work_sync(&ring->sched.work_tdr);
>> +	}
>> +}
>> +
>>   /**
>>    * amdgpu_pci_error_detected - Called when a PCI error is detected.
>>    * @pdev: PCI device struct
>> @@ -4756,15 +4770,37 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>   {
>>   	struct drm_device *dev = pci_get_drvdata(pdev);
>>   	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	int i;
>>   
>>   	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>>   
>>   	switch (state) {
>>   	case pci_channel_io_normal:
>>   		return PCI_ERS_RESULT_CAN_RECOVER;
>> -	case pci_channel_io_frozen:
>> -		/* Fatal error, prepare for slot reset */
>> -		amdgpu_device_lock_adev(adev);
>> +	/* Fatal error, prepare f
>> +	case pci_channel_io_frozen:		
>> +		/*		
>> +		 * Cancel and wait for all TDRs in progress if failing to
>> +		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev
>> +		 *
>> +		 * Locking adev->reset_sem will prevent any external access
>> +		 * to GPU during PCI error recovery
>> +		 */
>> +		while (!amdgpu_device_lock_adev(adev, NULL))
>> +			amdgpu_cancel_all_tdr(adev);
> As in v1, I don't see how this is protected from
> polling forever. "amdgpu_cancel_all_tdr()" defined above,
> doesn't actively cancel anything--it just waits.
>
> "amdgpu_device_lock_adev()" similarly only modifies
> a few variables.
>
> Neither of those two functions seem to escalate or otherwise
> reset the hardware. If the reset/hw blocks for whatever
> reason, this loop will hang forever.
>
> Regards,
> Luben


But the fact that reset blocks for ever for some reason is not acceptable anyway 
- it's a bug
we must handle and so I don't think our code here should be robust for this bug 
case because if we
are in this scenario already we will have a lot of other issues anyway and the 
driver will stop being usable.
Your comment made me see there is a question of possible starvation when trying 
to amdgpu_device_lock_adev
because we could say that if the HW is dead and jobs keep coming you will have 
new job timeouts
all the time and they could sneak in and hijack adev->in_gpu_reset so that PCIe 
error recovery never
has a chance to run but, I looked into the code and that is not the case since 
drm_sched_select_entity->drm_sched_ready
will return NULL for any scheduler that already has his HW ring full of 
unfinished jobs and so no new timeouts will be
triggered so PCIe recovery code will have eventually his opportunity to lock the 
device and run.

Andrey


>
>> +
>> +		/*
>> +		 * Block any work scheduling as we do for regular GPU reset
>> +		 * for the duration of the recovery
>> +		 */
>> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +			struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +			if (!ring || !ring->sched.thread)
>> +				continue;
>> +
>> +			drm_sched_stop(&ring->sched, NULL);
>> +		}
>>   		return PCI_ERS_RESULT_NEED_RESET;
>>   	case pci_channel_io_perm_failure:
>>   		/* Permanent error, prepare for device removal */
>> @@ -4897,8 +4933,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>>   {
>>   	struct drm_device *dev = pci_get_drvdata(pdev);
>>   	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	int i;
>>   
>> -	amdgpu_device_unlock_adev(adev);
>>   
>>   	DRM_INFO("PCI error: resume callback!!\n");
>> +
>> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +		struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +		if (!ring || !ring->sched.thread)
>> +			continue;
>> +
>> +
>> +		drm_sched_resubmit_jobs(&ring->sched);
>> +		drm_sched_start(&ring->sched, true);
>> +	}
>> +
>> +	amdgpu_device_unlock_adev(adev);
>>   }
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
