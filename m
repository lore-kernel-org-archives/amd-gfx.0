Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AE8C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 12:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3C56521D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 12:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3C56521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF146E28B;
	Mon,  8 Mar 2021 12:43:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B266E329
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 12:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUBudx6ZrCtU5XWFk2g01HFWllaNkaQ5vSockhD1/+A9jEjibyCwoBUOrQxjByrpKT0/Wq7soFe4MdWgsjKLU5bfq4kEnK6fSfNNnRBLh+ayUws8TlIhCIGMbo+vG18TCBWwe8EbuN11DFTgNX4yFtwgvmGQfTp0TQPRDQqLg+1OIhIoCN6OA7SqrTGXEZNYBB0Lp9Q75uVQPt9aVG5Y6yF3hH90Kh2f/3W/E7NUAsDvd3Paw81PEJi5zFN8daZ6YmWVrhes4M5JYSdeqPe3l53ue2aOfAH6q2qAeNPcjF6BmBiqCUQmgckHKpk0pu/A7/m54uEAUFayQxSW1wrO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72yd75Csf/Ac2wwzo1T3daTl5EJ+N/Bb8UIH+KFonnk=;
 b=cv8yyudcJUhmAsVY5ssVBW/3yolHCQDAIP9W8psWo/pYqGQoVJOftBQP3uM75YunBZLbcxR2vHaxH5GPTTQvSoNVCK/H360M/aB9/3mTf8z1iSqLQHNwoPDgfGIKO/d6OEDIbm71Wp3ZPPW56WLuh2ppYUPPuKLRkiSPTtLyGAW4lVXFoo3y7wYgef2qM2oRiQ1AzRM5SA/A8BOGR4kwWiuV7Ei1df7eSI4RWxh+KyAV1apkowY/Q2pXw3qgQJPx7aAQqEhYigdQTENcMHlSwNf7I05OcJhKSX8an1cjTC7KPK2xs39qIJUyoTO1y3UH7pGQAWLDkVca2ZBsr09Eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72yd75Csf/Ac2wwzo1T3daTl5EJ+N/Bb8UIH+KFonnk=;
 b=yzCeF0fC/ie8dRScKqQCktjbRGEc4oNfdGFNMrOL6xSs/DEvj8J/IW/jpWM6EbbIMXz6C0xVhsQl5N/quXZ0KLXP2P7Mh78vE4D1RF/JIdU6JMNYTLsCIJyqMh1tspUD7U+QTu/XWOBDjEFthhapEC+CORx1oZxk+mQn6vBtZIU=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 12:43:33 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 12:43:33 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXEq260lsF0zvj+Uq4iNPnJeT2C6p3UWSAgAIp9QCAAD99AIAAUAIw
Date: Mon, 8 Mar 2021 12:43:33 +0000
Message-ID: <DM5PR1201MB0204425FF53AA785A2232F14BB939@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210306172507.202243-1-Jack.Zhang1@amd.com>
 <9cea258e-1220-635e-1133-7dc1eae397b0@amd.com>
 <DM5PR12MB1708DCEC60FE2059CEE1DE5684939@DM5PR12MB1708.namprd12.prod.outlook.com>
 <ffd292c3-3101-76dd-2ea6-4373caf9171a@amd.com>
In-Reply-To: <ffd292c3-3101-76dd-2ea6-4373caf9171a@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-08T12:43:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9e7cee81-a1d8-4792-8b7f-358aeb070a9b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 429da603-d9d1-4d92-9031-08d8e22fc8db
x-ms-traffictypediagnostic: DM6PR12MB4619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4619576BE23C9ED7D848BD1FBB939@DM6PR12MB4619.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2aNKIc943+I4Quv7oRDSCDrVGufvEOrGFXRHSKKvmJwASLt+qx8UoFP+N2Xr356EQRhj0IlAfAiIVsylA22HVotNBP2sMYJW0Bg6assOkw41wvfXAcghhs2v9CE+FMtracCmsPIWLvfgie9wdqwYbSnchM86FutpHQ2bz6/h7JDdWpBB8WzJD++kF2zzwuDkUPJbmehmP6XP+tovEUxEVEU7mVawS4SIWVp3G7FHPmjh3icKeTs/irus9AY4Ed+gcp9gkVXdbRVZYLJYiiIaMV23xJ9W912qTJJP6Pex7fOpJn9suRHiYj4biIY13d2J7v39vQ9zqrGUl6YFxjWSZbxvWKi+vXNfsS/LsYyVhnG2lvfyCvs9xzxxCAu0OURptd6/9D0MPBFb9gKJIBqNnHLfaUf1Czj8IxBsHa93shpFNjrQgEktbKJkPWoexSq2xrQanlWVSeYugw0lZftqSouIf84suCHtZCI4c4Tje0KXSyckbTPma4017NrMJtxhevhqoyJAEjQykjMlkpPV7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(2906002)(83380400001)(316002)(9686003)(8936002)(71200400001)(110136005)(86362001)(55016002)(8676002)(33656002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(26005)(52536014)(6636002)(6506007)(186003)(53546011)(478600001)(7696005)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aDdLYlRJMm5xazIyanRYMlAzdVFRaWMxU0MvbTArMHFmSDFlVkpoV3IwbXpC?=
 =?utf-8?B?ZzhLRkZZUWFXcUhaNTZNZTJJYlAwNEVOdi9FUlRncTFpOGxEMVphM0pOSmNL?=
 =?utf-8?B?aFVRK3FyOFNGVExsQXNIcjVMemh3QjVIUityWkRWS1djYXdrWGRsRmhHbm9l?=
 =?utf-8?B?Y1JUNmxRRFUzdEZiY3BvQk9NK2F1SHI0MWxuUWxNeGtDVnZzVWROTXN1bUtq?=
 =?utf-8?B?SGxycUIvOU9GTEZrQmI1V0Z2N25mRExIT29Ndi9sZmZEYW56WDFGQkRMOWtW?=
 =?utf-8?B?OXh2Q00xeTNiS0pGMmhWYnNWRHdSMkYvc0l1T2dPb0FJa2F6eXNZeTlaUVVm?=
 =?utf-8?B?S1kzdTdvdGN0UVlaWTYyYU1vRjRObGRBck9IN0p1b2xwWEtpTDZhZGRRbkRy?=
 =?utf-8?B?OWdjN051Mk51a0Z1OHpGc3dVRG9icDRpOWFuTUpDRU5ucHBMcDNNY3hHbmpN?=
 =?utf-8?B?dXk0YXE3RWNPaFZ4RUpxamNFMUpkWlNPeU5JWW9mWUs5MGxNa3dxbjZseHVT?=
 =?utf-8?B?Sm5xek4zT0ltVVd0aE9rNGkyN3NKYkxSUjVIOUZtZ01xUGVFU3NpTDNpU0pj?=
 =?utf-8?B?VExvK1VxeXBuY0JWVGI1QzhldDBGbjNaYTZNMTBESzA0QlMwSGdjRkxNVTBB?=
 =?utf-8?B?bnNZUXJDM2l5Y3NyTG1RTlY4QVZhdHBvc3pRTVVkSjJueStlT2MxUng1a1li?=
 =?utf-8?B?REIySzFjN1hObE5YeXNEZ0lENlE3dk5NTDJmTlZRRFpPcmM0NlU3NGw4U251?=
 =?utf-8?B?SlhCUVU2RWlPa3VJZW4vUlRSb1o1S3ozY0hUd1pqVEZxNHpzQ3IyZjRMNWgz?=
 =?utf-8?B?ZGlPZGQzSUpiN2FMN2FaWmdaTWRpd3N3bGFvY2srSGhJMXNza3RCSHlqOEFU?=
 =?utf-8?B?clBrNzgzWXcyQTlqaTRFS0g4bGUrcklENlp3ZFEyQjRITzZOVjRHSGhSRytl?=
 =?utf-8?B?aFRZMzg5MEtJQUk5SERONURxL0Y1L2c2ZVJCOVBjTTN0eDBodEU1ajZMRTM5?=
 =?utf-8?B?TmxJT1VqYWxONElxWmdOVXJzZnhhelloVytSNERWQ3RCYW04a2tBVW0vaElK?=
 =?utf-8?B?UXpQUzRrNkN5WFIvU0VjQTZXREhkTGV1NTZDaFZuWi85VFdrMnpuZGVhM3NF?=
 =?utf-8?B?Z0h3QnhMZTN5N0EweGJxNFpWYUk1dERNeXBPMG9rUVpQZHpLZnlDS0lTSlpl?=
 =?utf-8?B?VDNVcUZncFF0bURnNG9VSG5qUGRXRXhqeENFd1ZxVVo0ejBIZU83aU1WQjRp?=
 =?utf-8?B?aXFQN3BPcnhVd3JIQVlBUng2MVlRT0IxY2hleDZPUXZJSFFOK05YSStrZWw2?=
 =?utf-8?B?N29IdUV0M2g5UGMwL0pveklYM0dzUmczT0t1eEFSMHFaSEdicWFqWlRzWXYv?=
 =?utf-8?B?MjFVVWExdXhsNkVwWUR5b2NHeTRNNjIyVis2U2VyZEVYRkRBTGVUOHgxMTBz?=
 =?utf-8?B?OVNHQ2lUbWsweUFtMWhYK3I4M1lCSWRCUXhuVGJBRjR1UnpZSjVHU2R6TUp6?=
 =?utf-8?B?Y2k0VDFIZXFKWERMb1hUY1Z3T3RlNEtYVUVZZ2NWOGZTc2dRWFlZblJ3Rktl?=
 =?utf-8?B?TUE1WTkrN1RGeUxrTE5iTFB1VTNlTTY3eVZ4Nm5zbmMzSklUODI3T0cvM01D?=
 =?utf-8?B?MFNPWnNCZE9oeTdwc0tBbDJ1citMZGNMcUFpRDVsbWt6T3hHdGRpOUhQUFBk?=
 =?utf-8?B?bTdnbFBZbzd6UW4zcDdzTlR6L2hqWVZlZEkwV0k3azNGQXdpRHh5aVYzTFRG?=
 =?utf-8?Q?3me/wCzK9epQ/tGPAiCetlF84hcCutTMLEvHM0G?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429da603-d9d1-4d92-9031-08d8e22fc8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 12:43:33.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jTqTcTMlLfI9TFjJ5XxPIrBbMSFAdcK4wa/CcF3J3KPp/9WTS9/aKcIj812Up0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi, Christian,

I made some change on V3 patch that insert a dma_fence_wait for the first jobs after resubmit jobs.
It seems simpler than the V2 patch. Is this what you first thinks of in your mind?

Thanks,
Jack

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Monday, March 8, 2021 3:53 PM
To: Liu, Monk <Monk.Liu@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode



Am 08.03.21 um 05:06 schrieb Liu, Monk:
> [AMD Official Use Only - Internal Distribution Only]
>
>>> well first of all please completely drop the affinity group stuff from this patch. We should concentrate on one feature at at time.
> We need it to expedite the process, we can introduce this change in 
> another patch
>
>
>>> Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.
> No that's not true, during the " drm_sched_resubmit_jobs" it will put 
> all jobs in mirror list into the hw ring, but we can only allow the 
> first job to the ring To catch the real guilty one (otherwise it is possible that the later job in the ring also has bug and affect our judgement) So we need to implement a new " drm_sched_resubmit_jobs2()", like this way:

Something like this. But since waiting for the guilty job is AMD specific we should rather rework the stuff from the beginning.

What I have in mind is the following:
1. Add a reference from the scheduler fence back to the job which is cleared only when the scheduler fence finishes.
2. Completely drop the ring_mirror_list and replace it with a kfifo of pointers to the active scheduler fences.
3. Replace drm_sched_resubmit_jobs with a drm_sched_for_each_active() macro which allows drivers to iterate over all the active jobs and resubmit/wait/mark them as guilty etc etc..
4. Remove the guilty/karma handling from the scheduler. This is something AMD specific and shouldn't leak into common code.

Regards,
Christian.

>
> drm_sched_resubmit_jobs2()
> ~ 499 void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max)
>    500 {
>    501     struct drm_sched_job *s_job, *tmp;
>    502     uint64_t guilty_context;
>    503     bool found_guilty = false;
>    504     struct dma_fence *fence;
> + 505     int i = 0;
>    506
>    507     list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
>    508         struct drm_sched_fence *s_fence = s_job->s_fence;
>    509
> + 510         if (i >= max)
> + 511             break;
> + 512
>    513         if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
>    514             found_guilty = true;
>    515             guilty_context = s_job->s_fence->scheduled.context;
>    516         }
>    517
>    518         if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
>    519             dma_fence_set_error(&s_fence->finished, -ECANCELED);
>    520
>    521         dma_fence_put(s_job->s_fence->parent);
>    522         fence = sched->ops->run_job(s_job);
> + 523         i++;
>    524
>    525         if (IS_ERR_OR_NULL(fence)) {
>    526             if (IS_ERR(fence))
>    527                 dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
>    528
>    529             s_job->s_fence->parent = NULL;
>    530         } else {
>    531             s_job->s_fence->parent = fence;
>    532         }
>    533
>    534
>    535     }
>    536 }
>    537 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>    538
>
>
>
> Thanks
>
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Sunday, March 7, 2021 3:03 AM
> To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; 
> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey 
> <Andrey.Grodzovsky@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily 
> <Emily.Deng@amd.com>
> Subject: Re: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
>
> Hi Jack,
>
> well first of all please completely drop the affinity group stuff from this patch. We should concentrate on one feature at at time.
>
> Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.
>
> Additional to that this feature is completely AMD specific and shouldn't affect the common scheduler in any way.
>
> Regards,
> Christian.
>
> Am 06.03.21 um 18:25 schrieb Jack Zhang:
>> [Why]
>> Previous tdr design treats the first job in job_timeout as the bad job.
>> But sometimes a later bad compute job can block a good gfx job and 
>> cause an unexpected gfx job timeout because gfx and compute ring 
>> share internal GC HW mutually.
>>
>> [How]
>> This patch implements an advanced tdr mode.It involves an additinal 
>> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit 
>> step in order to find the real bad job.
>>
>> 1. For Bailing TDR job, re-insert it to mirror_list, don't set it to 
>> guilty and leave it to be handled by the main reset thread.
>>
>> 2. Don't set the job to guilty in pre_asic_reset, and leave it to be 
>> handled by Step0 Resubmit Stage.
>>
>> 3. At Step0 Resubmit stage, it first resubmit jobs asynchronously, 
>> then it iterate each ring mirror_list, synchronously pend for each hw 
>> fence being signaled. If the a job's hw fence get timeout, we 
>> identify it as guilty and do hw reset to recover hw. After that, we 
>> would do the normal resubmit step to resubmit left jobs.
>>
>> 4. For whole gpu reset(vram lost), skip Step0 Resubmit as each job 
>> after vram lost was considered as bad job.
>>
>> 5. Involve the concept "Affinity Group".
>> Doing two hw resets is not necessary when there's only one ring that 
>> has jobs among some hw-related rings.Thus, we involve "affinity group".
>> Hw-related rings could be added into a common affinity group, such as 
>> gfx and compute ring. When tdr happens, we iterate all rings in 
>> affinity group, skip Step0 Resubmit stage if there's only one ring's 
>> mirror_list that has valid sched jobs.
>>
>> V2:
>>       -fix a cherry-pick mistake for bailing TDR handling.
>>
>>       -do affinity_group check according to the bad job's sched rather
>>        than the default "1" so that there could be multiple affinity
>>        groups being pre-defined in future.
>>
>> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  47 ++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  27 ++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>>    include/drm/gpu_scheduler.h                |   1 +
>>    7 files changed, 173 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e247c3a2ec08..8632d7071292 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4188,6 +4188,37 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>>    	return false;
>>    }
>>    
>> +bool amdgpu_affinity_group_has_only_or_null_working_ring(struct
>> +amdgpu_device *adev, struct drm_sched_job *s_job) {
>> +       int i;
>> +       int working_ring_num = 0;
>> +
>> +	/*
>> +	 * The job is considered as the real bad one
>> +	 * if job's sched is not in affinity group
>> +	 */
>> +	if (s_job->sched.affinity_group == 0)
>> +			return true;
>> +
>> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +               struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +               if (!ring || !ring->sched.thread)
>> +                       continue;
>> +
>> +               /* for non-empty affinity ring, increase working_ring_num */
>> +               if (ring->sched.affinity_group == s_job->sched.affinity_group) {
>> +                       if (!list_empty(&ring->sched.ring_mirror_list))
>> +                               working_ring_num++;
>> +               }
>> +       }
>> +
>> +       if (working_ring_num > 1) {
>> +               return false;
>> +       }
>> +       return true;
>> +}
>> +
>>    /**
>>     * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>>     *
>> @@ -4310,8 +4341,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    		amdgpu_fence_driver_force_completion(ring);
>>    	}
>>    
>> -	if(job)
>> -		drm_sched_increase_karma(&job->base);
>> +	if (amdgpu_gpu_recovery != 2) {
>> +		if (job)
>> +			drm_sched_increase_karma(&job->base);
>> +	}
>>    
>>    	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
>>    	if (!amdgpu_sriov_vf(adev)) {
>> @@ -4639,7 +4672,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    	int i, r = 0;
>>    	bool need_emergency_restart = false;
>>    	bool audio_suspended = false;
>> -
>> +	int	tmp_vram_lost_counter;
>>    	/*
>>    	 * Special case: RAS triggered and full reset isn't supported
>>    	 */
>> @@ -4690,8 +4723,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    					job ? job->base.id : -1);
>>    
>>    		/* even we skipped this reset, still need to set the job to guilty */
>> -		if (job)
>> -			drm_sched_increase_karma(&job->base);
>> +		if (job) {
>> +			if (amdgpu_gpu_recovery == 2) {
>> +				if (&job->base) {
>> +					spin_lock(&job->base.sched->job_list_lock);
>> +					list_add(&job->base.node, &job->base.sched->ring_mirror_list);
>> +					spin_unlock(&job->base.sched->job_list_lock);
>> +				}
>> +			} else
>> +				drm_sched_increase_karma(&job->base);
>> +		}
>>    		goto skip_recovery;
>>    	}
>>    
>> @@ -4788,6 +4829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		}
>>    	}
>>    
>> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>>    	/* Actual ASIC resets if needed.*/
>>    	/* TODO Implement XGMI hive reset logic for SRIOV */
>>    	if (amdgpu_sriov_vf(adev)) {
>> @@ -4804,18 +4846,64 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>    
>>    	/* Post ASIC reset for all devs .*/
>>    	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) 
>> {
>> +		int step = 1;
>>    
>> +		if (amdgpu_gpu_recovery == 2) {
>> +			if (amdgpu_affinity_group_has_only_or_null_working_ring(adev,&job->base)
>> +				|| tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)) {
>> +				DRM_INFO("Skip Stage0 Resubmit Stage\n");
>> +				/* set guilty */
>> +				drm_sched_increase_karma(&job->base);
>> +				step = 1;
>> +			} else {
>> +				DRM_INFO("Do Stage0 Resubmit Stage\n");
>> +				step = 0;
>> +			}
>> +		}
>> +
>> +retry_resubmit:
>>    		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    			struct amdgpu_ring *ring = tmp_adev->rings[i];
>> +			int ret = 0;
>> +			struct drm_sched_job *s_bad_job = NULL;
>>    
>>    			if (!ring || !ring->sched.thread)
>>    				continue;
>>    
>>    			/* No point to resubmit jobs if we didn't HW reset*/
>> -			if (!tmp_adev->asic_reset_res && !job_signaled)
>> +			if (!tmp_adev->asic_reset_res && !job_signaled) {
>> +
>>    				drm_sched_resubmit_jobs(&ring->sched);
>>    
>> -			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>> +				if (amdgpu_gpu_recovery == 2 && step == 0) {
>> +					ret = amdgpu_wait_resubmitted_jobs_completion(&ring->sched, ring->sched.timeout, &s_bad_job);
>> +					if (ret == -1) {
>> +						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_bad_job->id);
>> +						/* set guilty */
>> +						drm_sched_increase_karma(s_bad_job);
>> +
>> +						/* do hw reset */
>> +						if (amdgpu_sriov_vf(adev)) {
>> +							amdgpu_virt_fini_data_exchange(adev);
>> +							r = amdgpu_device_reset_sriov(adev, false);
>> +							if (r)
>> +								adev->asic_reset_res = r;
>> +						} else {
>> +							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
>> +							if (r && r == -EAGAIN)
>> +								goto retry;
>> +						}
>> +
>> +						/* add reset counter so that the following resubmitted job could flush vmid */
>> +						atomic_inc(&tmp_adev->gpu_reset_counter);
>> +						step = 1;
>> +						goto retry_resubmit;
>> +					}
>> +				}
>> +			}
>> +
>> +			if (step == 1)
>> +				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>>    		}
>>    
>>    		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) { 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 865f924772b0..9c3f4edb7532 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>>     * DOC: gpu_recovery (int)
>>     * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>>     */
>> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = 
>> enable, 0 = disable, -1 = auto)");
>> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = 
>> +advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>>    module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>>    
>>    /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 759b34799221..28cda321157a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -281,6 +281,53 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>>    	}
>>    }
>>    
>> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler 
>> +*sched, long timeout, struct drm_sched_job **s_bad_job) {
>> +	struct drm_sched_job *s_job, *tmp;
>> +	int ret = 0;
>> +
>> +	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
>> +		struct drm_sched_fence *s_fence = s_job->s_fence;
>> +
>> +			if (s_fence->parent == NULL) { /* fail to get a hw fence */
>> +				/* process a job */
>> +				atomic_dec(&sched->num_jobs);
>> +				dma_fence_get(&s_fence->finished);
>> +				dma_fence_signal(&s_fence->finished);
>> +				dma_fence_put(&s_fence->finished);
>> +
>> +				/* remove node from mirror_list and free the job */
>> +				spin_lock(&sched->job_list_lock);
>> +				list_del_init(&s_job->node);
>> +				spin_unlock(&sched->job_list_lock);
>> +				sched->ops->free_job(s_job);
>> +				continue;
>> +			}
>> +
>> +			ret = dma_fence_wait_timeout(s_fence->parent, false, timeout);
>> +
>> +			if (ret > 0) { /* succeed */
>> +				/* process a job */
>> +				atomic_dec(&sched->num_jobs);
>> +				dma_fence_get(&s_fence->finished);
>> +				dma_fence_signal(&s_fence->finished);
>> +				dma_fence_put(&s_fence->finished);
>> +
>> +				/* remove node from mirror_list and free the job */
>> +				spin_lock(&sched->job_list_lock);
>> +				list_del_init(&s_job->node);
>> +				spin_unlock(&sched->job_list_lock);
>> +				sched->ops->free_job(s_job);
>> +				continue;
>> +			} else if (ret == 0) {
>> +				*s_bad_job = s_job;
>> +				return -1; /* timeout */
>> +			}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>    const struct drm_sched_backend_ops amdgpu_sched_ops = {
>>    	.dependency = amdgpu_job_dependency,
>>    	.run_job = amdgpu_job_run,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index 81caac9b958a..25292f4699fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -76,5 +76,5 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>>    			     struct dma_fence **fence);
>>    
>>    void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler 
>> *sched);
>> -
>> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler 
>> +*sched, long timeout, struct drm_sched_job **s_bad_job);
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index b644c78475fd..cb50bfc80bc9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -35,6 +35,11 @@
>>    #include "amdgpu.h"
>>    #include "atom.h"
>>    
>> +static char *amdgpu_affinity_group[] = { "gfx", "comp"
>> +};
>> +
>>    /*
>>     * Rings
>>     * Most engines on the GPU are fed via ring buffers.  Ring @@ 
>> -189,6
>> +194,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct 
>> +amdgpu_ring *ring,
>>    		ring->adev = adev;
>>    		ring->idx = adev->num_rings++;
>>    		adev->rings[ring->idx] = ring;
>> +		amdgpu_ring_set_affinity_group(ring);
>>    		r = amdgpu_fence_driver_init_ring(ring, sched_hw_submission);
>>    		if (r)
>>    			return r;
>> @@ -459,3 +465,24 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>>    	ring->sched.ready = !r;
>>    	return r;
>>    }
>> +
>> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring) {
>> +       struct amdgpu_device *adev = ring->adev;
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(amdgpu_affinity_group); i++) {
>> +               char *temp_name = amdgpu_affinity_group[i];
>> +
>> +               /* set ring's affinity_group bit if find it in affinity_group list */
>> +               if (strncmp(ring->name, temp_name, strlen(temp_name)) == 0) {
>> +                       DRM_DEV_INFO(adev->dev, "set ring:%s in affinity_group\n",
>> +                             ring->name);
>> +                       ring->sched.affinity_group = 1;
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       ring->sched.affinity_group = 0;
>> +       return 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 56acec1075ac..6b0d217e6f5a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -350,4 +350,5 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>    			     struct amdgpu_ring *ring);
>>    void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>    
>> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring);
>>    #endif
>> diff --git a/include/drm/gpu_scheduler.h 
>> b/include/drm/gpu_scheduler.h index 1c815e0a14ed..589cbaea35dc 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -301,6 +301,7 @@ struct drm_gpu_scheduler {
>>    	atomic_t                        _score;
>>    	bool				ready;
>>    	bool				free_guilty;
>> +	int				affinity_group;
>>    };
>>    
>>    int drm_sched_init(struct drm_gpu_scheduler *sched,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
