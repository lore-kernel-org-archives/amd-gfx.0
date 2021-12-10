Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B138C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 03:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C672710E1D2;
	Fri, 10 Dec 2021 03:47:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F90510E1D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 03:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYYo+MbvNV3ck6vTcmun7XKecXZsoVOS654SqJqVKuu0U8aRVGocrCu6P8jDHsM4YUdY6oo9RFJvhpskuEkj1hfOYtC26i9amXLjzRKEF7daUO7tfYq1CNGwrdaNs3r14MyOC/yA/dygMpBMYjp2Wa0doZmIwz5hjUIKR4rDXYIbap31/6fs4dUeWIby6E7s/ePzgRh/aKy4pMKiQCr91Z0ucM5J2PYpfrvV45kRnx9eed8LlOUsOTykpPye/WYN0PFJwRgS30qYCmHQRXy+YOQDd2e9wWYnqVa53tvgZNWghMwDMQIToXbkjeH7kDkojkX/qV7vKYF3GPtdHDtjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUtfWwerMwdG96A9F0KJH4i36FlvYsNpTfuwfsFuHxE=;
 b=VPig7MpOUtzUT5WiAzccjvV4VrX1/MAovRLesfK0mj9APPbeFXNB3ZkCaW2qZaA92a0JFdUR6tDiSbfFLn2IvL9jzK03XG8emkLHnDaGQVpGFwzhw+NpgR3gY9/VVFEzJ2BYXzaQm4ALiEDbB7k1mNN1QaF+w/7iW3SyyEysUnubvG4OFdc1S7TefQNn39cv3oPqhtP38w7M6IcX/ekjxsw4/g7TzfqJjDstdjj5qiVmbHRYwfsxB1QoMLQ1jm4O1+muFwWzEHYuLCfGLAZq/Js30fGdej7ujJov7OV2R/1fZCknhmLVhm5b5PEiWsS0wGhUYp98DjiQvXA/Kf5mDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUtfWwerMwdG96A9F0KJH4i36FlvYsNpTfuwfsFuHxE=;
 b=nlC+GzKo/4BljhenC79lODQWq+0p3yrmhMEr+nFoqEZJhjRKKtCGxdbTlrL+zP1cmVHRpm3NinVmuDmdvMq8hS6lHY4ooumaYTvdmyqLLwswqLS7yl1h/tIwI1CpJN7L8vo/2Lsb0nX6IQi2cT4Gcyu4VXOH7/VZYNioFvjFTvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22; Fri, 10 Dec 2021 03:47:14 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 03:47:14 +0000
Date: Fri, 10 Dec 2021 11:47:00 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian KKKnig <christian.koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: introduce a kind of halt state for
 amdgpu device
Message-ID: <YbLNtFgoxa66ZV7N@lang-desktop>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <af6c19e6-fcf4-ac19-637e-1fb47f15f9e6@amd.com>
 <432a38b5-2c56-2b54-4e05-b0a3862ddb2f@amd.com>
 <983b6cd3-57ac-a797-170c-2c43b86b67fc@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <983b6cd3-57ac-a797-170c-2c43b86b67fc@amd.com>
X-ClientProxiedBy: HK0PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:203:b0::34) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b675ea8f-e5d9-4644-6579-08d9bb8fc10f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30187AD24D41C03251D3E5EDFB719@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kc6X4Roliqcpr47ePN4B7UghOLEglP3obtL6dzBfwBy/2fg+pW1lQxgJRg9ll6kPaTYTYBt39GU28wy68460h7g++7YTrXbRLypstgBrTZxG2IWgB0HXj0JG8F3b1q8NNtd1MNMmhvFlXYR4KtdZ+w+9KuSQqrJTl0wEBld+5cihwESVkJyEWuG5Fo7O791MeEq00qWkWhJ9NF7/dFJXN6xAtnnOCGUzBm1vLBVOAodFBteGy5W/ZpljdRmbc14577tgMD1/QypDZ8ut8AR7utbpC8BDJaUP4jMceBOKfd1aHSMz4xKHjmza1GxA6tPagDiO33/ecWEIALz3FAXtvYfGmrX6zJ5f1vveMFvleKk3wF8O9mQV0F1bEjDUvxAYK+f7BSb2uyTs38CGFJOxLZ5KgNCMLP6bJH9HwUzoSoaFK3oIeAlaRAyPj3I8tw+jYEl7EyZFCWZTlxaQlQZh5sK3kR/TeyxQNts2xqopzJ/f6mZEm2A8BdmAiJLsUVvJK3tGeIgfFQlC6F89KOYR1V/xKjw4CgckGidR49GeudXtNEfOYUF8BUfcHzkEhy9iPV1RaQZuTJnsXRwnAbReLsYFlNjml/rgwvGyfY5OPPl8EAMmSNbDeXlARiIthvMdwx1AU+UpbIq7VM1PhoqwGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(6506007)(6636002)(53546011)(6486002)(26005)(54906003)(83380400001)(5660300002)(86362001)(4326008)(508600001)(38100700002)(66574015)(6512007)(33716001)(186003)(2906002)(6862004)(6666004)(66946007)(66556008)(8676002)(66476007)(316002)(9686003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?APOCdwCS6jrTIcisJoXG1fqNapmIwOr0GVDm8iS0mGc3LPRTtZdMxQq7zI?=
 =?iso-8859-1?Q?t9MnSlkfBS1xGahglRcxkf2apvd2IJGl9XQOocZntaRCAhCnaZKsDOyWGQ?=
 =?iso-8859-1?Q?YHgKviidU3EI5y74+vjpU55PggDxEVqNVQnR6H+8aZqLABYx0549EXFzFR?=
 =?iso-8859-1?Q?Cet7dZxuwo8Fm02cuekJO5Gs8gAnA95292/yOm1+2ejas0PUBgS8uk5feW?=
 =?iso-8859-1?Q?RrYpiRIRZojcrVofLItkOaRPmoj2oXR9ZvdEcPy/TBIch0gxP7YQR3L7Uk?=
 =?iso-8859-1?Q?dvGh/B3HGrKJcnCRZivLzgwEIMypST9t3vqyMOMzZcM3BxhINXxJRmSbG1?=
 =?iso-8859-1?Q?6ZBvXy3mwD4vuRzcAB7RgJdiA8zETQeuyV/6ksYmkKt0qdp0jDlptOlBzB?=
 =?iso-8859-1?Q?AoaKD6bWhmXU1C3LdyeyKxj2LSdsBnqYkoVNTWu3FQvQpV/bsKAb9WBdJW?=
 =?iso-8859-1?Q?u0RGO9vWmUmVLKjH3v9gnMRS2ABZKSKoOUD2/iUo62eUprUg4F7ivQcVXX?=
 =?iso-8859-1?Q?3/+vty2gvcg71q90TL7T0togbbLWwdk2GJ+QG0RUpaKCd7uivwvTUF3D0O?=
 =?iso-8859-1?Q?DrGW2dVoj5pWTgnAvr68dwtcH9+4BUOCaQck/HxW0wsCeBVvco6x9aGdFs?=
 =?iso-8859-1?Q?GWBtknHjaHQwKFihhJX8WEeGzYBETeA4k7cjjQ4KU/SzPgTyh3pP0ZLmqf?=
 =?iso-8859-1?Q?D7W4ZnuggzE6JS3TaHRYBBZFxFVpOE4l+IoWU2tFQi2CAjYK1jUFFolFvq?=
 =?iso-8859-1?Q?qvfok+ussgAjEBbmQVAEjPjZzDuPipSW5gInsemPoBysyNUHf5TkX8Ex88?=
 =?iso-8859-1?Q?0UG/3UK5E+6MkyOn9+iOMTpzLP29phs0NAifUS2yg+0cA22QcETt8ABUCX?=
 =?iso-8859-1?Q?jfQiVWUD1/OEARPwEMsIe9FLgKqCVkS9V0vcu74CjMF5Mjs15Ub8xD5llj?=
 =?iso-8859-1?Q?yj/ydKioRr/Efa9+/TO7hT3Bucwv/A5cS5d3l3CBtv9NdRkbOcrKSu+M0S?=
 =?iso-8859-1?Q?bEeqKGcec9NHLh4p9BpPPdK6u1TctSA8rpuMR0JhfGMRs4PLQaWhgh/wpM?=
 =?iso-8859-1?Q?rBKgFTXQsajF90LlCevl2oWE2CNmfF05uJokqhi6YCf9f7w4ue6HoRfUIm?=
 =?iso-8859-1?Q?HckelFUZQ+mUo2ksfbq9EndBlTxv6ZRY09GNawBttWIaSyRzgd9QQ3wACW?=
 =?iso-8859-1?Q?RBFYKVCcrUx7fHt6Yw8gXHb80aHn/7NXXSZWlAUTbOr2J2WW5Zdj5hhphX?=
 =?iso-8859-1?Q?zrxZXZFQn6j3FKk/YqCtTdV+mTrjc70p2whg7/JKH+m4VAbz15ILQW0eSf?=
 =?iso-8859-1?Q?iTGCivFuBH2A5K5EI7u8Y+bUnIzRBkTPIgVI1kR+E4llhQajM0QVGUKyNm?=
 =?iso-8859-1?Q?2XgzbLPjFFIIZ3p9qQVfiWLFIr1GgAZpicHmXPO9kMy9GkGN1LCi89H7IU?=
 =?iso-8859-1?Q?CVoHzjPibLc5hM2IL834QYAh+/rUVcg7xPFM8N3iyqP3z5AidXgrte/Spg?=
 =?iso-8859-1?Q?SF7t7mZqs0peRdUK8h/cznE48oOk3345ka15LBun7ArAIdEF349zb5mcbM?=
 =?iso-8859-1?Q?CHB6nz/GAxBhZO4j4PW8vsjV5QrjTASUWleetzRQg2d+fXNrscKe78TGao?=
 =?iso-8859-1?Q?E6p/JNNsZI5Dml6m9iYsUA1wf+StpeKw5rYJTDORArpgvpkpZ0mzIGemSM?=
 =?iso-8859-1?Q?WCJhHOM6SyNtpdnIvco=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b675ea8f-e5d9-4644-6579-08d9bb8fc10f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 03:47:14.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNaCraR+xLCnikSqukiPTXiy4Q2G/XbbBVC0/zZCfzgE8F2tK+JAvYLUW58alGpvg/n0W5jeeMYZ3VTq4sMIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/09/ , Christian KKKnig wrote:
> Am 09.12.21 um 16:38 schrieb Andrey Grodzovsky:
> > 
> > On 2021-12-09 4:00 a.m., Christian König wrote:
> > > 
> > > 
> > > Am 09.12.21 um 09:49 schrieb Lang Yu:
> > > > It is useful to maintain error context when debugging
> > > > SW/FW issues. We introduce amdgpu_device_halt() for this
> > > > purpose. It will bring hardware to a kind of halt state,
> > > > so that no one can touch it any more.
> > > > 
> > > > Compare to a simple hang, the system will keep stable
> > > > at least for SSH access. Then it should be trivial to
> > > > inspect the hardware state and see what's going on.
> > > > 
> > > > Suggested-by: Christian Koenig <christian.koenig@amd.com>
> > > > Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > > > ---
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
> > > > ++++++++++++++++++++++
> > > >   2 files changed, 41 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > index c5cfe2926ca1..3f5f8f62aa5c 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > @@ -1317,6 +1317,8 @@ void amdgpu_device_flush_hdp(struct
> > > > amdgpu_device *adev,
> > > >   void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
> > > >           struct amdgpu_ring *ring);
> > > >   +void amdgpu_device_halt(struct amdgpu_device *adev);
> > > > +
> > > >   /* atpx handler */
> > > >   #if defined(CONFIG_VGA_SWITCHEROO)
> > > >   void amdgpu_register_atpx_handler(void);
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > index a1c14466f23d..62216627cc83 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -5634,3 +5634,42 @@ void amdgpu_device_invalidate_hdp(struct
> > > > amdgpu_device *adev,
> > > >         amdgpu_asic_invalidate_hdp(adev, ring);
> > > >   }
> > > > +
> > > > +/**
> > > > + * amdgpu_device_halt() - bring hardware to some kind of halt state
> > > > + *
> > > > + * @adev: amdgpu_device pointer
> > > > + *
> > > > + * Bring hardware to some kind of halt state so that no one can
> > > > touch it
> > > > + * any more. It will help to maintain error context when error
> > > > occurred.
> > > > + * Compare to a simple hang, the system will keep stable at
> > > > least for SSH
> > > > + * access. Then it should be trivial to inspect the hardware state and
> > > > + * see what's going on. Implemented as following:
> > > > + *
> > > > + * 1. drm_dev_unplug() makes device inaccessible to user
> > > > space(IOCTLs, etc),
> > > > + *    clears all CPU mappings to device, disallows remappings through
> > > > page faults
> > > > + * 2. amdgpu_irq_disable_all() disables all interrupts
> > > > + * 3. amdgpu_fence_driver_hw_fini() signals all HW fences
> > > > + * 4. amdgpu_device_unmap_mmio() clears all MMIO mappings
> > > > + * 5. pci_disable_device() and pci_wait_for_pending_transaction()
> > > > + *    flush any in flight DMA operations
> > > > + * 6. set adev->no_hw_access to true
> > > > + */
> > > > +void amdgpu_device_halt(struct amdgpu_device *adev)
> > > > +{
> > > > +    struct pci_dev *pdev = adev->pdev;
> > > > +    struct drm_device *ddev = &adev->ddev;
> > > > +
> > > > +    drm_dev_unplug(ddev);
> > > > +
> > > > +    amdgpu_irq_disable_all(adev);
> > > > +
> > > > +    amdgpu_fence_driver_hw_fini(adev);
> > > > +
> > > > +    amdgpu_device_unmap_mmio(adev);
> > 
> > 
> > Note that this one will cause page fault on any subsequent MMIO access
> > (trough registers or by direct VRAM access)
> > 
> > 
> > > > 
> > > > +
> > > > +    pci_disable_device(pdev);
> > > > +    pci_wait_for_pending_transaction(pdev);
> > > > +
> > > > +    adev->no_hw_access = true;
> > > 
> > > I think we need to reorder this, e.g. set adev->no_hw_access much
> > > earlier for example. Andrey what do you think?
> > 
> > 
> > Earlier can be ok but at least after the last HW configuration we
> > actaully want to do like disabling IRQs.
> 
> My thinking was to at least do this before we unmap the MMIO to avoid the
> crash.
> 
> Additionally to that we maybe don't even want to do this for this case.

So we just do "adev->no_hw_access = true;" before
"amdgpu_device_unmap_mmio(adev);".

That can avoid potential registers access page faults.
But direct VRAM access will still trigger page faults.

For example, 
"cat /sys/class/drm/card0/device/pp_od_clk_voltage"
will call smu_cmn_update_table and can still trigger 
a page fault.

smu_cmn_update_table()
{
 ...
	if (drv2smu) {
		memcpy(table->cpu_addr, table_data, table_size);
 ...
}

Regards,
Lang

> Christian.
> 
> > 
> > 
> > Andrey
> > 
> > > 
> > > Apart from that sounds like the right idea to me.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > +}
> > > 
> 
