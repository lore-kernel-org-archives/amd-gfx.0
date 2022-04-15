Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 02:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9603C10E365;
	Fri, 15 Apr 2022 02:38:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2AB10E1D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 02:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxK6w/ailToL26zOGFE5dTJcs+eDD11tFOh/v8WJEJO3UTKxj6XA6/NP4KViWaapP5dO0n10yxMh2kb8gnHzYwg2nkE/1wxmsFZS4KZF3dRCGI6ydZE6nzjmLtraf2iWOa5jfHHYvsOrBRqPzYdXFwqE07Ebgi64CWfXWm1PtoStm6Yxswgo70341B4BTA0A1reBYZ3qGa5d27sg3WhFLiuQ4s1FAdPHthWM1RgysYIzBlsbztbf+GW90RzlMX6FnaK8uV0tN2zuJ27X1OBljl3su9BPwuPrPwnrWD0zD6XS0wN3GKix24vrd/cxjNzf7I+lVAxjAZ0h4B5ywLsWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9ZtPTgV9iZqg5oGETBCVeiaksPmARKsgZVDdKWmWY8=;
 b=b71nrnLg8FLCIbtkEx0Kk5AeFQalzYlxrEXYOkxqiSTyz0HwcXz1PiPsfq2n6h8IIF0D486cbgaxyYd8o35hyq1nEu8Gsha0ucjiCYaCPE8jC6VWtiqkUu4okBuXvKxwCD1rzCD8Atfak8+Bo7EeeHYLHNx/rKa7r0zO/JQGqVpItg993iw96Eo62G3ZSOqT/ifCbGRDnPC9MtF4vPWy06w9dgDULVYhVE4hnkLcZ8l7yHQjAL1Dk6cHcSrnubwmN9aJ8A2LGkUANYmXW1RVwfXyJWRf6FAe2e5jH173XvsPRI4zpVq4p2sL8Fw1mbSsPqSJYudlHECISf+gaHzp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9ZtPTgV9iZqg5oGETBCVeiaksPmARKsgZVDdKWmWY8=;
 b=ECYyQj9vgmSCnUQYVUkNsvkJ1tlUClTQxBYw8gLrYfF0n91oLeFKNkLH8NejbKQDpN1KvJxa9EoPV1AqWvacX3frRd2ryyfyBVlsDB/Pz60exLvquhX3XCBRz4Z9hJI0qilFduxda3FOEAj9omy0XHYYx5DAvKBbg/v2xITYVXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Fri, 15 Apr 2022 02:38:48 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4d1:7b99:6fa4:dc2%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 02:38:47 +0000
Date: Fri, 15 Apr 2022 10:38:38 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Eric Huang <jinhuieric.huang@amd.com>
Subject: Re: [PATCH] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Message-ID: <Yljars9+5resjVTz@lang-desktop>
References: <20220414081909.796653-1-Lang.Yu@amd.com>
 <037fabb7-01a5-1a02-ffed-5c9f54a10510@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037fabb7-01a5-1a02-ffed-5c9f54a10510@amd.com>
X-ClientProxiedBy: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7550d763-49bf-4517-ec28-08da1e89112c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB335076F0272DEF8C2FAC8D28FBEE9@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iBgdJgSFLDvDx//ZnrvYJfKiXatsL/hNrIBra7U+HLxhGBmr8yEJ6KkEIS5qaOHdb/CHxcTRsMASnR9vSufMAFpHRx9XWJz6op5LGt5JY/a3ZsCcpk0QF2kZtN3Q3EPA8VUNIhaeL18IxCBA6Wpm/6RAWFWLvA4qTG3BJdqevQN/6+u/Pk7/vbW4DC5/O8BGruOYraj+Dod6nYIb7PR/dFBGegDHM7Hmlmy8B21ujv4bgg8pgPLr7Ka4kQpDxJ717kcUREkWvUEici4wX1B4HcauC8KxG5SrlEslhZl3CqTpBUoG4HyqWPiidQHQgn3neKXerMYonhx2k29RrGvJGN6/rrLPimjDAFcJC7+OrdfyPhqfKqJSk7KDHEaVf3cyzTiAafuG6otFdKviBNobAlKdOSL8WidlZAONoFdiuwvoFYHlu+4A78Hwdf2aedDv1RZTHF9th+JoAFel1vAp1Ix9cMndLe23jjVlOkvwLsgr6pebgH8g7yoPDMzcmE3yiXlXUpdCyWkvTgiFUPNbw8Bwiy5zol0mVJxigEq/C9mFdBaJivhMZf+3UtJ2Z8tEymBHgT0OZEKB7eOIepQYgd0zV/lcdh5xTDbNJqDw1fO7Nv5mHRz3JkEbKeXPY0EvJUL9J5eRDmP4Q8TKwr+cjPYcZEyIkDzwuA+qp3yTO0xK4jIaHcpPui8zsrJpfguVsqTspCmPUo6KAGOmiQP7/Sl4yTxSDB08bxcCPXHF7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(9686003)(86362001)(6512007)(83380400001)(8676002)(6862004)(4326008)(66946007)(66556008)(66476007)(53546011)(6506007)(2906002)(33716001)(316002)(186003)(38100700002)(6666004)(54906003)(6636002)(6486002)(508600001)(8936002)(5660300002)(26005)(16393002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVaOmHK3mzkeRFxUTxU0Of+4frRa8bl3bHayBy89iA2R1K+4e/gNyqBPqISI?=
 =?us-ascii?Q?xQygmDuCvmTTF7+N70HznPTOtu3+aRS5z/BLmlvxjKuCHndjy41S2h5hUV5h?=
 =?us-ascii?Q?1xdU3f9/oqVTgUMM7/MZNjf6mAE3HOD6RaCgmyh/OT900JxQDDah+S9E60e7?=
 =?us-ascii?Q?wQQTXlZ8G1r7mO3ZqEeA51HryuS5Qj+WjUa2A/ZfAvP+PaCwJ1I5W5o8HyJG?=
 =?us-ascii?Q?EDijmyvOEg/mJ4OHaeQOmY+AArQ09Y4Q8zT5xLLgohnBjC+mQj6AKrXlgZEM?=
 =?us-ascii?Q?mIRQSDQ9X050p/sNCkVGTeD4lDVru9mMKt8ggtUKghg04GvikxGI5NkN/XWq?=
 =?us-ascii?Q?ettRBBSfI2t9TNv2J45RJh7GGaORFoqPj2NP0+dBWXEEE302HBQpIlhwwWyL?=
 =?us-ascii?Q?VNL126ZCUnPToUZmSudBpb86QfvbOz2SfBK7gs5c1a1l7r3EuQAX1FkLZaxP?=
 =?us-ascii?Q?jwC3tl8My52J8FYPQhBDGEZxy+JrYV2EgP0v1349jBvQrWJ95u6U+TznRutr?=
 =?us-ascii?Q?c/t23GybxjRvp9eCI4SLT2Z7x8Hw5Gsd0cnf1owgE8HiXfYub7Z6Y5xM8ZBq?=
 =?us-ascii?Q?u00o7pjQJbbbJmn2d6/ePbz6H30VCd8kkdYS897qgfs/1eLbYxDxr01zUB5I?=
 =?us-ascii?Q?IQIe9GJShaKdMy4/GxIM/qxkIbzvIOVS32B5H+DN5MqOaXvUD4gkmtl6E//d?=
 =?us-ascii?Q?fk/rOdW3hIdQmmWlEjaDDvREKmJAQ3JELAGDgiDDNVbWGlYv+qvMWFaVtD7r?=
 =?us-ascii?Q?3WLC5w9OCNRn2HhYAz4gOK+rua3G5+X7FJ8ONLfiCJBQcujkzm202YhAFjMn?=
 =?us-ascii?Q?PshiM0CB+ZCMFfT6zuOSWq5k97P7s/X6kHkIQ2Gu1GUeC10G6fqj7P36p+EK?=
 =?us-ascii?Q?fPU6soVKaLeVz47JztP1j64Q8czkVkTmB6EuntMchM2c+1MjBWi+6HGW7O29?=
 =?us-ascii?Q?q7IgRBG9ymo60rOFrDkb7uQxU03b6uKxMEtpuR5y7IztxCj4G9xB1jR8HPxw?=
 =?us-ascii?Q?+dgf0J2yVZpkQAfkhy+WN1LSYgU8brlTOF0SyiTwAwBBUtOUdwd3W0Xdy3d8?=
 =?us-ascii?Q?FO9Xj5QIMcV1je9mI5+Ku/t+BF/p9KL2u0jvbJjtyrB8NVZqthzr8MBOsXiF?=
 =?us-ascii?Q?ADOs5/DXlA2dJ/IwL8CcUdKFau5+40uINJGe27BLRi3+QI/MGQq9fmjFr32b?=
 =?us-ascii?Q?rvaidj5MjBNYtr7WVhzW7dCQT1YwILU+hrq3k7CrG/rURFJjlwHFFweBfFJt?=
 =?us-ascii?Q?6EY1Xpk8riyCwlE06qqDDdtbSg22XAN7Q8fD5odpDVVKgTbhPuiDIUFxqdoV?=
 =?us-ascii?Q?y+RRvWz7RPUFbWvJWmuejgif7+4DoFhynmSYENoc/eB+mNvurUO3PzwZUMKW?=
 =?us-ascii?Q?kz+yhbkgm/uVyqSEaCEvMKdODsm+TvTGLtfhSc+szqp4+ProvBdDFJ93/GWm?=
 =?us-ascii?Q?hR75oRhFfxIWG4zW2crv8G00BjqbQgdZFNjfB6u4ZDz35PfnV4kv7xN7Mxhs?=
 =?us-ascii?Q?UpSLa99Y+BUFd2hfqFmVFR8vG7jHk1Bz5p3JicIPiWf83Ut05druUKVb1E2f?=
 =?us-ascii?Q?+MfdXGaVlxvXc7fS6jqXa6ILodY5kR+xCD0QqqtCQcxOyX/A2a5FQgivccTE?=
 =?us-ascii?Q?V3JFvyU/cCAKdGaGJ9Zs/XXN3cl+t2ls7KHwn7ohDBxp5bEf7oNzlXLipDFa?=
 =?us-ascii?Q?zsImnwOb5mraQG7ouUEfIPcSY0ByTnysFKn8bEQgK3WwS6QM/n69iQ1E4MjX?=
 =?us-ascii?Q?GxVVgrvEsA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7550d763-49bf-4517-ec28-08da1e89112c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 02:38:47.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eF1GiwtNs2zFkoUc1G1QUg6l/FT/orhdU5C8urnsiSFwmG9LHc9FLXntQm24z2ZeyzkFQx63SdkEBPGosGIW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/14/ , Eric Huang wrote:
> 
> 
> On 2022-04-14 04:19, Lang Yu wrote:
> > The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
> > TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
> > heavy-weight TLB flush on Arcturus"). Otherwise, we will run into problems
> > on some ASICs when running SVM applications.
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 4 +++-
> >   3 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 91f82a9ccdaf..459f59e3d0ed 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
> >   	return ret;
> >   }
> > -static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > -{
> > -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > -		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > -		dev->adev->sdma.instance[0].fw_version >= 18) ||
> > -		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > -}
> > -
> >   static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> >   					struct kfd_process *p, void *data)
> >   {
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 8a43def1f638..aff6f598ff2c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
> >   void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> > +static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > +{
> > +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> > +	       dev->adev->sdma.instance[0].fw_version >= 18) ||
> > +	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > +}
> > +
> It is a cosmetic change for function kfd_flush_tlb_after_unmap, and not
> related to the topic. You can separate that into another patch.

Okay. Thanks.

Regards,
Lang

> Regards,
> Eric
> >   bool kfd_is_locked(void);
> >   /* Compute profile */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > index 459fa07a3bcc..5afe216cf099 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> >   			if (r)
> >   				break;
> >   		}
> > -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> > +
> > +		if (kfd_flush_tlb_after_unmap(pdd->dev))
> > +			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> >   	}
> >   	return r;
> 
