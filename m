Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C1C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 17:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55AB206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 17:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BhFkV+eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55AB206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E72089DD2;
	Mon,  8 Jun 2020 17:12:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B19389DD2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 17:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql8TfCFW/hDbQK+vX+pqUOpBoEuRE/ABtPpNl5jOFodaNGSJGnP1/fxge83OaSme5Lw4HW4USo9OxK+Pfhu1VbVfbQpkUPSPabqW42vMtKqG50WU7iUfLO6P4v//Qftf9Aq2BkH/upj2cNiPWuMhqMV3As4kyDVmmFhdbfldJpQjwzExYTqLV5+PXX7/eTzYBoX7fjcJ5Xi+i0s7l24/X88AulFHd+WF6B8OK3M+Wj9KeHJxpwyYSPJgSzVi9C6nsHiIOZQds+S3F9rC8ujG0DBzVnvyxwiXlP0WZWbwpdG6L2OG12EI2HVcYuDOXMUMPVRFofO+wyS/GA/uyGuYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBdFILdA9hgC9ITGf6pmmP+vK9X+ln29km/teunpL6Q=;
 b=SEl6b6t0qVJwMnbm0E767ekSCzX+vwrrGV+c1rkUgfgOjsStnSaarWsCjv5iCh4qlVceM3VEy1eyCn1SiUiQT1MsSZbInDgpmi5rn93JJbt3QS6SrN1OPt4XDbCldQsXFFCxhJ2wANJ+HN7KByzWAGnltLmQMHSeSBCgl6DQaMuF13hfsMok+umcawApnJAsc0a9Ch3aVU+anyq8x0eyBbhgXRwaOf/w+wPoOJple2yHBAJFSe+c4Nphw/buBvPdS/i3uxzws0gNSiqG3mjFA8MKMnxhHXmOOTNro1zWQXsO9eCHdtnhCxZZPl/7oF/XtkMCVRK3qZDcdx82eJoOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBdFILdA9hgC9ITGf6pmmP+vK9X+ln29km/teunpL6Q=;
 b=BhFkV+eGmRjXJyE5/3RIRsQVGVjvSiWNLh9yREexa5ruRbPCTUIvfe2ACD3zzVgIJrVVcUNFAE5aG8NlSTCoddFODW6idY2fD24FPAbdMlMwBZtQ03g8dfybTS13vE6nEr3Qli/pQemhdfafUd4VOTNK79CbzCeSClhekCSC4r8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 17:12:46 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 17:12:46 +0000
Subject: Re: [PATCH] drm/amdgpu: stop disable the scheduler during HW fini
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200225130736.2929-1-christian.koenig@amd.com>
 <87b1face-f3c9-ca0e-5ce6-9b96088ab4e7@amd.com>
 <26bd0e25-2549-8d1c-f246-d1101355bb5e@gmail.com>
 <CH2PR12MB39122B04EB9B658D520DB662F7EB0@CH2PR12MB3912.namprd12.prod.outlook.com>
 <MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80@MN2PR12MB3167.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <32b5b33a-668c-15c9-4aa9-934f5b6b7123@amd.com>
Date: Mon, 8 Jun 2020 19:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80@MN2PR12MB3167.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::40) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2003:c5:8f20:5d00:7fc6:50c7:b826:f4e) by
 AM0PR06CA0135.eurprd06.prod.outlook.com (2603:10a6:208:ab::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 17:12:45 +0000
X-Originating-IP: [2003:c5:8f20:5d00:7fc6:50c7:b826:f4e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa7ae8f4-6b54-4c2d-7e6b-08d80bcf2974
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2909482F2A7ECB41F238813C8B850@MN2PR12MB2909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjokaBCUlIDLh661Rkk7K4BplpBxM8dO9iV5/BkQIlWrag0O0xdbeB0HhvvcLWsdpwV/MT/pzl4d6CYEgBau2BX31XSil+52os7eanDEYywNRzQM3gIOKl3h/YPFXHlJlsb6N/Jx4sdVZprAgrR/sEvcQGW4Ff5plQzlgnn588rkbuHaRQofaa4RKkxc1/+544DBsPeMWPfcfJMpdH5Og5MvTSd3591SBts3FjDvG2ESuex+ZdxW6ZxMboaAHZ2t+xHf3OPjdQJtQpj0jVfwnMQGUnJWWidycSg39qpGgM6OwOkC2uKNGow4qts2RhItk106jxnDsdkgA5vusFC/zhI2jB5iDIgiaeAtB8KAkV5onSR6ikf3PR6ojKNQNABfvxawOpIFE+xXm0gDTc7dm+jmNBldnYAS/qPEUzKPuE9LJLC8fstB2QY56WYx1kZlpqpkwYhz/lkosEb6qSI+vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(16526019)(186003)(6506007)(66556008)(66476007)(53546011)(66946007)(36756003)(6486002)(6666004)(33964004)(45080400002)(66574014)(6512007)(31696002)(478600001)(966005)(166002)(83380400001)(52116002)(2906002)(316002)(5660300002)(69590400007)(31686004)(8676002)(30864003)(8936002)(110136005)(2616005)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZaAQYs2av4mHdzYdLsBiwSADZTzIrZgwlS/EVtZlP/j0IUaGqGc2otdiG9QRc+mjVEqu5X/wrt56nvIGXO/laPmwKOa0ZIFvWsHdD+be2JmJ91s8cFlj8atEOC3sxM2xMPMyPgdEvdcotLyiO0aRxZYq8WWo409Z/dz+BbrbBVNatXbDgYSp7nrC3hpkj9K0u7UfkXki+PSFh6618IxP/WZJkU08jYDuvTJROvyOp7eQNTivWiUItu3rx9lxDmSoOXZAmJTX4mp01DV4Nsb57qxPbtzcwRCsUUU6NoV1I8T6vme6OIlxKIeEBJH13PEJfHpOMug2S1tbUDeIY9KoTt5OBfgkOPkEgvsqNDDycVYFRtydZdYipGe2ClvQxqERIDYf85UwNcKTgQsF5BvUIzABG//kR9Jtfxnbe0V6ll8ikO2xuuPAKiavsHdyUVTSlwmgQlbFKAaslmy1d0athC43vsR7753Ni/foZ99cPb2lnx2hHryrkkNaqjPf//vlqYrvM39QZKEBP3dPVa2LjA1lK9PIsT12ry5z776wIoQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7ae8f4-6b54-4c2d-7e6b-08d80bcf2974
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 17:12:46.1407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBcjmgCIRnC6AUt7qXqbuc5axUZvpkAjkGtZSENRZDXrwtH2QAv7vsN2c5Qa9Rev1QF/QcyiQaAe+1Bk/Sr5+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
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
Content-Type: multipart/mixed; boundary="===============1060830243=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1060830243==
Content-Type: multipart/alternative;
 boundary="------------24F3708F751452DD45AAE92E"
Content-Language: en-US

--------------24F3708F751452DD45AAE92E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,


I realized we are still missing this patch while reading dmesg of 
https://gitlab.freedesktop.org/drm/amd/-/issues/1158


Regards,

Nirmoy

On 2/28/20 4:24 PM, Li, Dennis wrote:
>
> [AMD Public Use]
>
> Looks good to me
>
> Test-by: Dennis Li <dennis.li@amd.com <mailto:dennis.li@amd.com>>
>
> Best Regards
>
> Dennis Li
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Deucher, Alexander
> *Sent:* Thursday, February 27, 2020 11:18 PM
> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>; Das, Nirmoy 
> <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: stop disable the scheduler during 
> HW fini
>
> [AMD Public Use]
>
> Looks good to me.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com 
> <mailto:alexander.deucher@amd.com>>
>
> ------------------------------------------------------------------------
>
> *From:*Christian König <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>>
> *Sent:* Thursday, February 27, 2020 9:50 AM
> *To:* Das, Nirmoy <Nirmoy.Das@amd.com <mailto:Nirmoy.Das@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
> *Subject:* Re: [PATCH] drm/amdgpu: stop disable the scheduler during 
> HW fini
>
> Alex any comment on this?
>
> Am 25.02.20 um 14:16 schrieb Nirmoy:
> > Acked-by: Nirmoy Das <nirmoy.das@amd.com <mailto:nirmoy.das@amd.com>>
> >
> > On 2/25/20 2:07 PM, Christian König wrote:
> >> When we stop the HW for example for GPU reset we should not stop the
> >> front-end scheduler. Otherwise we run into intermediate failures during
> >> command submission.
> >>
> >> The scheduler should only be stopped in very few cases:
> >> 1. We can't get the hardware working in ring or IB test after a GPU
> >> reset.
> >> 2. The KIQ scheduler is not used in the front-end and should be
> >> disabled during GPU reset.
> >> 3. In amdgpu_ring_fini() when the driver unloads.
> >>
> >> Signed-off-by: Christian König <christian.koenig@amd.com 
> <mailto:christian.koenig@amd.com>>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |  2 --
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  8 --------
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  |  5 -----
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 25 +++++++++----------------
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  |  7 -------
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  9 ---------
> >>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  3 ---
> >>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |  2 --
> >>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |  2 --
> >>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  4 ----
> >>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |  3 ---
> >>   drivers/gpu/drm/amd/amdgpu/si_dma.c    |  1 -
> >>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c  |  3 ---
> >>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c  |  3 ---
> >>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c  |  3 ---
> >>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  |  7 -------
> >>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c  |  4 ----
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c  |  3 ---
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  |  9 ---------
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  | 11 +----------
> >>   20 files changed, 10 insertions(+), 104 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >> index 4274ccf765de..cb3b3a0a1348 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> >> @@ -320,8 +320,6 @@ static void cik_sdma_gfx_stop(struct
> >> amdgpu_device *adev)
> >>           WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
> >>           WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], 0);
> >>       }
> >> -    sdma0->sched.ready = false;
> >> -    sdma1->sched.ready = false;
> >>   }
> >>     /**
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> index 7b6158320400..36ce67ce4800 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >> @@ -2391,10 +2391,6 @@ static int gfx_v10_0_cp_gfx_enable(struct
> >> amdgpu_device *adev, bool enable)
> >>       tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
> >>       tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
> >>       tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
> >> -    if (!enable) {
> >> -        for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> >> - adev->gfx.gfx_ring[i].sched.ready = false;
> >> -    }
> >>       WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
> >>         for (i = 0; i < adev->usec_timeout; i++) {
> >> @@ -2869,16 +2865,12 @@ static int gfx_v10_0_cp_gfx_resume(struct
> >> amdgpu_device *adev)
> >>     static void gfx_v10_0_cp_compute_enable(struct amdgpu_device
> >> *adev, bool enable)
> >>   {
> >> -    int i;
> >> -
> >>       if (enable) {
> >>           WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
> >>       } else {
> >>           WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
> >> (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> >> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> >> -        for (i = 0; i < adev->gfx.num_compute_rings; i++)
> >> - adev->gfx.compute_ring[i].sched.ready = false;
> >>           adev->gfx.kiq.ring.sched.ready = false;
> >>       }
> >>       udelay(50);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >> index 31f44d05e606..e462a099dbda 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >> @@ -1950,7 +1950,6 @@ static int gfx_v6_0_ring_test_ib(struct
> >> amdgpu_ring *ring, long timeout)
> >>     static void gfx_v6_0_cp_gfx_enable(struct amdgpu_device *adev,
> >> bool enable)
> >>   {
> >> -    int i;
> >>       if (enable) {
> >>           WREG32(mmCP_ME_CNTL, 0);
> >>       } else {
> >> @@ -1958,10 +1957,6 @@ static void gfx_v6_0_cp_gfx_enable(struct
> >> amdgpu_device *adev, bool enable)
> >> CP_ME_CNTL__PFP_HALT_MASK |
> >> CP_ME_CNTL__CE_HALT_MASK));
> >>           WREG32(mmSCRATCH_UMSK, 0);
> >> -        for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> >> - adev->gfx.gfx_ring[i].sched.ready = false;
> >> -        for (i = 0; i < adev->gfx.num_compute_rings; i++)
> >> - adev->gfx.compute_ring[i].sched.ready = false;
> >>       }
> >>       udelay(50);
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> >> index 8f20a5dd44fe..9bc8673c83ac 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> >> @@ -2431,15 +2431,12 @@ static int gfx_v7_0_ring_test_ib(struct
> >> amdgpu_ring *ring, long timeout)
> >>    */
> >>   static void gfx_v7_0_cp_gfx_enable(struct amdgpu_device *adev, bool
> >> enable)
> >>   {
> >> -    int i;
> >> -
> >> -    if (enable) {
> >> +    if (enable)
> >>           WREG32(mmCP_ME_CNTL, 0);
> >> -    } else {
> >> -        WREG32(mmCP_ME_CNTL, (CP_ME_CNTL__ME_HALT_MASK |
> >> CP_ME_CNTL__PFP_HALT_MASK | CP_ME_CNTL__CE_HALT_MASK));
> >> -        for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> >> - adev->gfx.gfx_ring[i].sched.ready = false;
> >> -    }
> >> +    else
> >> +        WREG32(mmCP_ME_CNTL, (CP_ME_CNTL__ME_HALT_MASK |
> >> + CP_ME_CNTL__PFP_HALT_MASK |
> >> + CP_ME_CNTL__CE_HALT_MASK));
> >>       udelay(50);
> >>   }
> >>   @@ -2700,15 +2697,11 @@ static void
> >> gfx_v7_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> >>    */
> >>   static void gfx_v7_0_cp_compute_enable(struct amdgpu_device *adev,
> >> bool enable)
> >>   {
> >> -    int i;
> >> -
> >> -    if (enable) {
> >> +    if (enable)
> >>           WREG32(mmCP_MEC_CNTL, 0);
> >> -    } else {
> >> -        WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> >> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> >> -        for (i = 0; i < adev->gfx.num_compute_rings; i++)
> >> - adev->gfx.compute_ring[i].sched.ready = false;
> >> -    }
> >> +    else
> >> +        WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> >> + CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> >>       udelay(50);
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> >> index fa245973de12..7b6b03c02754 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> >> @@ -4111,7 +4111,6 @@ static int gfx_v8_0_rlc_resume(struct
> >> amdgpu_device *adev)
> >>     static void gfx_v8_0_cp_gfx_enable(struct amdgpu_device *adev,
> >> bool enable)
> >>   {
> >> -    int i;
> >>       u32 tmp = RREG32(mmCP_ME_CNTL);
> >>         if (enable) {
> >> @@ -4122,8 +4121,6 @@ static void gfx_v8_0_cp_gfx_enable(struct
> >> amdgpu_device *adev, bool enable)
> >>           tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 1);
> >>           tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
> >>           tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, 1);
> >> -        for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> >> - adev->gfx.gfx_ring[i].sched.ready = false;
> >>       }
> >>       WREG32(mmCP_ME_CNTL, tmp);
> >>       udelay(50);
> >> @@ -4311,14 +4308,10 @@ static int gfx_v8_0_cp_gfx_resume(struct
> >> amdgpu_device *adev)
> >>     static void gfx_v8_0_cp_compute_enable(struct amdgpu_device
> >> *adev, bool enable)
> >>   {
> >> -    int i;
> >> -
> >>       if (enable) {
> >>           WREG32(mmCP_MEC_CNTL, 0);
> >>       } else {
> >>           WREG32(mmCP_MEC_CNTL, (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> >> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> >> -        for (i = 0; i < adev->gfx.num_compute_rings; i++)
> >> - adev->gfx.compute_ring[i].sched.ready = false;
> >>           adev->gfx.kiq.ring.sched.ready = false;
> >>       }
> >>       udelay(50);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >> index 1c7a16b91686..a2f9882bd9b4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >> @@ -3034,16 +3034,11 @@ static int gfx_v9_0_rlc_resume(struct
> >> amdgpu_device *adev)
> >>     static void gfx_v9_0_cp_gfx_enable(struct amdgpu_device *adev,
> >> bool enable)
> >>   {
> >> -    int i;
> >>       u32 tmp = RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
> >>         tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
> >>       tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
> >>       tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
> >> -    if (!enable) {
> >> -        for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> >> - adev->gfx.gfx_ring[i].sched.ready = false;
> >> -    }
> >>       WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
> >>       udelay(50);
> >>   }
> >> @@ -3239,15 +3234,11 @@ static int gfx_v9_0_cp_gfx_resume(struct
> >> amdgpu_device *adev)
> >>     static void gfx_v9_0_cp_compute_enable(struct amdgpu_device
> >> *adev, bool enable)
> >>   {
> >> -    int i;
> >> -
> >>       if (enable) {
> >>           WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
> >>       } else {
> >>           WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
> >>               (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> >> CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> >> -        for (i = 0; i < adev->gfx.num_compute_rings; i++)
> >> - adev->gfx.compute_ring[i].sched.ready = false;
> >>           adev->gfx.kiq.ring.sched.ready = false;
> >>       }
> >>       udelay(50);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> >> index ff2e6e1ccde7..471710a42a0c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> >> @@ -169,14 +169,11 @@ static int jpeg_v2_0_hw_init(void *handle)
> >>   static int jpeg_v2_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
> >>         if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
> >>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> >>           jpeg_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> >>   -    ring->sched.ready = false;
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >> index fd7fa6082563..05b79aced6e8 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> >> @@ -355,8 +355,6 @@ static void sdma_v2_4_gfx_stop(struct
> >> amdgpu_device *adev)
> >>           ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
> >> IB_ENABLE, 0);
> >>           WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
> >>       }
> >> -    sdma0->sched.ready = false;
> >> -    sdma1->sched.ready = false;
> >>   }
> >>     /**
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >> index 4a8a7f0f3a9c..1448d9beb7a8 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> >> @@ -529,8 +529,6 @@ static void sdma_v3_0_gfx_stop(struct
> >> amdgpu_device *adev)
> >>           ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
> >> IB_ENABLE, 0);
> >>           WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
> >>       }
> >> -    sdma0->sched.ready = false;
> >> -    sdma1->sched.ready = false;
> >>   }
> >>     /**
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> >> index 7cea4513c303..0c6eb65f96f3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> >> @@ -923,8 +923,6 @@ static void sdma_v4_0_gfx_stop(struct
> >> amdgpu_device *adev)
> >>           ib_cntl = RREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL);
> >>           ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
> >> IB_ENABLE, 0);
> >>           WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
> >> -
> >> -        sdma[i]->sched.ready = false;
> >>       }
> >>   }
> >>   @@ -971,8 +969,6 @@ static void sdma_v4_0_page_stop(struct
> >> amdgpu_device *adev)
> >>           ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,
> >>                       IB_ENABLE, 0);
> >>           WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
> >> -
> >> -        sdma[i]->sched.ready = false;
> >>       }
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >> index 7ee603db8c57..5af66a24b0a2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >> @@ -502,9 +502,6 @@ static void sdma_v5_0_gfx_stop(struct
> >> amdgpu_device *adev)
> >>           ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL,
> >> IB_ENABLE, 0);
> >>           WREG32(sdma_v5_0_get_reg_offset(adev, i,
> >> mmSDMA0_GFX_IB_CNTL), ib_cntl);
> >>       }
> >> -
> >> -    sdma0->sched.ready = false;
> >> -    sdma1->sched.ready = false;
> >>   }
> >>     /**
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> >> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> >> index 7f64d73043cf..a8548678c37d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> >> @@ -124,7 +124,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
> >>             if (adev->mman.buffer_funcs_ring == ring)
> >> amdgpu_ttm_set_buffer_funcs_status(adev, false);
> >> -        ring->sched.ready = false;
> >>       }
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> >> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> >> index 82abd8e728ab..957e14e2c155 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> >> @@ -210,13 +210,10 @@ static int uvd_v4_2_hw_init(void *handle)
> >>   static int uvd_v4_2_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring = &adev->uvd.inst->ring;
> >>         if (RREG32(mmUVD_STATUS) != 0)
> >>           uvd_v4_2_stop(adev);
> >>   -    ring->sched.ready = false;
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> >> index 0fa8aae2d78e..2aad6689823b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> >> @@ -208,13 +208,10 @@ static int uvd_v5_0_hw_init(void *handle)
> >>   static int uvd_v5_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring = &adev->uvd.inst->ring;
> >>         if (RREG32(mmUVD_STATUS) != 0)
> >>           uvd_v5_0_stop(adev);
> >>   -    ring->sched.ready = false;
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> index e0aadcaf6c8b..a9d06ec5d09a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> @@ -535,13 +535,10 @@ static int uvd_v6_0_hw_init(void *handle)
> >>   static int uvd_v6_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring = &adev->uvd.inst->ring;
> >>         if (RREG32(mmUVD_STATUS) != 0)
> >>           uvd_v6_0_stop(adev);
> >>   -    ring->sched.ready = false;
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> >> index 0995378d8263..af3b1c9d3377 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> >> @@ -598,7 +598,6 @@ static int uvd_v7_0_hw_init(void *handle)
> >>   static int uvd_v7_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    int i;
> >>         if (!amdgpu_sriov_vf(adev))
> >>           uvd_v7_0_stop(adev);
> >> @@ -607,12 +606,6 @@ static int uvd_v7_0_hw_fini(void *handle)
> >>           DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
> >>       }
> >>   -    for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {
> >> -        if (adev->uvd.harvest_config & (1 << i))
> >> -            continue;
> >> -        adev->uvd.inst[i].ring.sched.ready = false;
> >> -    }
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >> index 3fd102efb7af..5e986dea4645 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >> @@ -539,7 +539,6 @@ static int vce_v4_0_hw_init(void *handle)
> >>   static int vce_v4_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    int i;
> >>         if (!amdgpu_sriov_vf(adev)) {
> >>           /* vce_v4_0_wait_for_idle(handle); */
> >> @@ -549,9 +548,6 @@ static int vce_v4_0_hw_fini(void *handle)
> >>           DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
> >>       }
> >>   -    for (i = 0; i < adev->vce.num_rings; i++)
> >> -        adev->vce.ring[i].sched.ready = false;
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> >> index 71f61afdc655..df92c4e1efaa 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> >> @@ -227,14 +227,11 @@ static int vcn_v1_0_hw_init(void *handle)
> >>   static int vcn_v1_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
> >>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> >>           RREG32_SOC15(VCN, 0, mmUVD_STATUS))
> >>           vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> >>   -    ring->sched.ready = false;
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> >> index c387c81f8695..37508277cbdf 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> >> @@ -232,21 +232,12 @@ static int vcn_v2_0_hw_init(void *handle)
> >>   static int vcn_v2_0_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
> >> -    int i;
> >>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> >>           (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> >>             RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
> >>           vcn_v2_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> >>   -    ring->sched.ready = false;
> >> -
> >> -    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> >> -        ring = &adev->vcn.inst->ring_enc[i];
> >> -        ring->sched.ready = false;
> >> -    }
> >> -
> >>       return 0;
> >>   }
> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >> index 2d64ba1adf99..90a1994857db 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >> @@ -307,25 +307,16 @@ static int vcn_v2_5_hw_init(void *handle)
> >>   static int vcn_v2_5_hw_fini(void *handle)
> >>   {
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >> -    struct amdgpu_ring *ring;
> >> -    int i, j;
> >> +    int i;
> >>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>           if (adev->vcn.harvest_config & (1 << i))
> >>               continue;
> >> -        ring = &adev->vcn.inst[i].ring_dec;
> >>             if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> >>               (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> >>                RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> >> vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
> >> -
> >> -        ring->sched.ready = false;
> >> -
> >> -        for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> >> -            ring = &adev->vcn.inst[i].ring_enc[j];
> >> -            ring->sched.ready = false;
> >> -        }
> >>       }
> >>         return 0;
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> > 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ca040605cb0574b3fc93608d7bb945b4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637184118188416898&amp;sdata=hzQLxdX8COuG2nB0mn6YWO4%2Btd402tIfRiOTh%2BCK58M%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CDennis.Li%40amd.com%7C77c39c3849844479687908d7bb984adf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637184135103921328&sdata=96plDq8wfssj%2Br4aKoTkDVXyTT7fGNjnr59FySOlH3k%3D&reserved=0>
>

--------------24F3708F751452DD45AAE92E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Christian, <br>
    </p>
    <p><br>
    </p>
    <p>I realized we are still missing this patch while reading dmesg of
      <a href="https://gitlab.freedesktop.org/drm/amd/-/issues/1158">https://gitlab.freedesktop.org/drm/amd/-/issues/1158</a></p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Nirmoy<br>
    </p>
    <div class="moz-cite-prefix">On 2/28/20 4:24 PM, Li, Dennis wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB3167D3C9AB617B2B7DF3F016EDE80@MN2PR12MB3167.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheader87abd423" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
            Public Use]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Looks good to me<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Test-by: Dennis Li &lt;<a href="mailto:dennis.li@amd.com" moz-do-not-send="true">dennis.li@amd.com</a>&gt;<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Best Regards<o:p></o:p></p>
        <p class="MsoNormal">Dennis Li<o:p></o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> amd-gfx
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              <b>On Behalf Of </b>Deucher, Alexander<br>
              <b>Sent:</b> Thursday, February 27, 2020 11:18 PM<br>
              <b>To:</b> Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>; Das, Nirmoy
              <a class="moz-txt-link-rfc2396E" href="mailto:Nirmoy.Das@amd.com">&lt;Nirmoy.Das@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: stop disable the
              scheduler during HW fini<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD
            Public Use]<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Looks good to me.<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Reviewed-by: Alex
                Deucher &lt;<a href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">alexander.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
          </div>
          <div class="MsoNormal" style="text-align:center" align="center">
            <hr width="98%" size="2" align="center">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                <b>Sent:</b> Thursday, February 27, 2020 9:50 AM<br>
                <b>To:</b> Das, Nirmoy &lt;<a href="mailto:Nirmoy.Das@amd.com" moz-do-not-send="true">Nirmoy.Das@amd.com</a>&gt;;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: stop disable the
                scheduler during HW fini</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            </div>
          </div>
          <div>
            <div>
              <p class="MsoNormal" style="margin-bottom:12.0pt">Alex any
                comment on this?<br>
                <br>
                Am 25.02.20 um 14:16 schrieb Nirmoy:<br>
                &gt; Acked-by: Nirmoy Das &lt;<a href="mailto:nirmoy.das@amd.com" moz-do-not-send="true">nirmoy.das@amd.com</a>&gt;<br>
                &gt;<br>
                &gt; On 2/25/20 2:07 PM, Christian König wrote:<br>
                &gt;&gt; When we stop the HW for example for GPU reset
                we should not stop the<br>
                &gt;&gt; front-end scheduler. Otherwise we run into
                intermediate failures during<br>
                &gt;&gt; command submission.<br>
                &gt;&gt;<br>
                &gt;&gt; The scheduler should only be stopped in very
                few cases:<br>
                &gt;&gt; 1. We can't get the hardware working in ring or
                IB test after a GPU <br>
                &gt;&gt; reset.<br>
                &gt;&gt; 2. The KIQ scheduler is not used in the
                front-end and should be <br>
                &gt;&gt; disabled during GPU reset.<br>
                &gt;&gt; 3. In amdgpu_ring_fini() when the driver
                unloads.<br>
                &gt;&gt;<br>
                &gt;&gt; Signed-off-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
                &gt;&gt; ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp; |&nbsp; 2
                --<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |&nbsp; 8
                --------<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp; |&nbsp; 5
                -----<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp; | 25
                &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------------<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp; |&nbsp; 7
                -------<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp; |&nbsp; 9
                ---------<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |&nbsp; 3
                ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |&nbsp; 2
                --<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |&nbsp; 2
                --<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |&nbsp; 4
                ----<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c |&nbsp; 3
                ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c&nbsp; |&nbsp; 3
                ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp; |&nbsp; 3
                ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp; |&nbsp; 3
                ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c&nbsp; |&nbsp; 7
                -------<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vce_v4_0.c&nbsp; |&nbsp; 4
                ----<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp; |&nbsp; 3
                ---<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c&nbsp; |&nbsp; 9
                ---------<br>
                &gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c&nbsp; | 11
                &#43;----------<br>
                &gt;&gt; &nbsp; 20 files changed, 10 insertions(&#43;), 104
                deletions(-)<br>
                &gt;&gt;<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
                &gt;&gt; index 4274ccf765de..cb3b3a0a1348 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
                &gt;&gt; @@ -320,8 &#43;320,6 @@ static void
                cik_sdma_gfx_stop(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSDMA0_GFX_RB_CNTL &#43;
                sdma_offsets[i], rb_cntl);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSDMA0_GFX_IB_CNTL &#43;
                sdma_offsets[i], 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; &nbsp; /**<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                &gt;&gt; index 7b6158320400..36ce67ce4800 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
                &gt;&gt; @@ -2391,10 &#43;2391,6 @@ static int
                gfx_v10_0_cp_gfx_enable(struct <br>
                &gt;&gt; amdgpu_device *adev, bool enable)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                ME_HALT, enable ? 0 : 1);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                PFP_HALT, enable ? 0 : 1);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                CE_HALT, enable ? 0 : 1);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; if (!enable) {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.gfx_ring[i].sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;usec_timeout; i&#43;&#43;) {<br>
                &gt;&gt; @@ -2869,16 &#43;2865,12 @@ static int
                gfx_v10_0_cp_gfx_resume(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp; &nbsp; static void
                gfx_v10_0_cp_compute_enable(struct amdgpu_device <br>
                &gt;&gt; *adev, bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
                0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                (CP_MEC_CNTL__MEC_ME1_HALT_MASK |<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.compute_ring[i].sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq.ring.sched.ready =
                false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
                &gt;&gt; index 31f44d05e606..e462a099dbda 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
                &gt;&gt; @@ -1950,7 &#43;1950,6 @@ static int
                gfx_v6_0_ring_test_ib(struct <br>
                &gt;&gt; amdgpu_ring *ring, long timeout)<br>
                &gt;&gt; &nbsp; &nbsp; static void gfx_v6_0_cp_gfx_enable(struct
                amdgpu_device *adev, <br>
                &gt;&gt; bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                &gt;&gt; @@ -1958,10 &#43;1957,6 @@ static void
                gfx_v6_0_cp_gfx_enable(struct <br>
                &gt;&gt; amdgpu_device *adev, bool enable)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                CP_ME_CNTL__PFP_HALT_MASK |<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                CP_ME_CNTL__CE_HALT_MASK));<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSCRATCH_UMSK, 0);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.gfx_ring[i].sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.compute_ring[i].sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
                &gt;&gt; index 8f20a5dd44fe..9bc8673c83ac 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
                &gt;&gt; @@ -2431,15 &#43;2431,12 @@ static int
                gfx_v7_0_ring_test_ib(struct <br>
                &gt;&gt; amdgpu_ring *ring, long timeout)<br>
                &gt;&gt; &nbsp;&nbsp; */<br>
                &gt;&gt; &nbsp; static void gfx_v7_0_cp_gfx_enable(struct
                amdgpu_device *adev, bool <br>
                &gt;&gt; enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (enable)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL, 0);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL,
                (CP_ME_CNTL__ME_HALT_MASK | <br>
                &gt;&gt; CP_ME_CNTL__PFP_HALT_MASK |
                CP_ME_CNTL__CE_HALT_MASK));<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.gfx_ring[i].sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; else<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL,
                (CP_ME_CNTL__ME_HALT_MASK |<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                CP_ME_CNTL__PFP_HALT_MASK |<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                CP_ME_CNTL__CE_HALT_MASK));<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; @@ -2700,15 &#43;2697,11 @@ static void <br>
                &gt;&gt; gfx_v7_0_ring_set_wptr_compute(struct
                amdgpu_ring *ring)<br>
                &gt;&gt; &nbsp;&nbsp; */<br>
                &gt;&gt; &nbsp; static void gfx_v7_0_cp_compute_enable(struct
                amdgpu_device *adev, <br>
                &gt;&gt; bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (enable)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CNTL, 0);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CNTL,
                (CP_MEC_CNTL__MEC_ME1_HALT_MASK | <br>
                &gt;&gt; CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.compute_ring[i].sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; else<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CNTL,
                (CP_MEC_CNTL__MEC_ME1_HALT_MASK |<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                &gt;&gt; index fa245973de12..7b6b03c02754 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                &gt;&gt; @@ -4111,7 &#43;4111,6 @@ static int
                gfx_v8_0_rlc_resume(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp; &nbsp; static void gfx_v8_0_cp_gfx_enable(struct
                amdgpu_device *adev, <br>
                &gt;&gt; bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp = RREG32(mmCP_ME_CNTL);<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; @@ -4122,8 &#43;4121,6 @@ static void
                gfx_v8_0_cp_gfx_enable(struct <br>
                &gt;&gt; amdgpu_device *adev, bool enable)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                ME_HALT, 1);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                PFP_HALT, 1);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                CE_HALT, 1);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.gfx_ring[i].sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_ME_CNTL, tmp);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; @@ -4311,14 &#43;4308,10 @@ static int
                gfx_v8_0_cp_gfx_resume(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp; &nbsp; static void
                gfx_v8_0_cp_compute_enable(struct amdgpu_device <br>
                &gt;&gt; *adev, bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CNTL, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_CNTL,
                (CP_MEC_CNTL__MEC_ME1_HALT_MASK | <br>
                &gt;&gt; CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.compute_ring[i].sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq.ring.sched.ready =
                false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &gt;&gt; index 1c7a16b91686..a2f9882bd9b4 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                &gt;&gt; @@ -3034,16 &#43;3034,11 @@ static int
                gfx_v9_0_rlc_resume(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp; &nbsp; static void gfx_v9_0_cp_gfx_enable(struct
                amdgpu_device *adev, <br>
                &gt;&gt; bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp = RREG32_SOC15(GC, 0,
                mmCP_ME_CNTL);<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                ME_HALT, enable ? 0 : 1);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                PFP_HALT, enable ? 0 : 1);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
                CE_HALT, enable ? 0 : 1);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; if (!enable) {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_gfx_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.gfx_ring[i].sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL,
                tmp);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; @@ -3239,15 &#43;3234,11 @@ static int
                gfx_v9_0_cp_gfx_resume(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp; &nbsp; static void
                gfx_v9_0_cp_compute_enable(struct amdgpu_device <br>
                &gt;&gt; *adev, bool enable)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0,
                mmCP_MEC_CNTL, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0,
                mmCP_MEC_CNTL,<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
                <br>
                &gt;&gt; CP_MEC_CNTL__MEC_ME2_HALT_MASK));<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;gfx.compute_ring[i].sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq.ring.sched.ready =
                false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c<br>
                &gt;&gt; index ff2e6e1ccde7..471710a42a0c 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c<br>
                &gt;&gt; @@ -169,14 &#43;169,11 @@ static int
                jpeg_v2_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int jpeg_v2_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;jpeg.inst-&gt;ring_dec;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;jpeg.cur_state !=
                AMD_PG_STATE_GATE &amp;&amp;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(JPEG, 0,
                mmUVD_JRBC_STATUS))<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jpeg_v2_0_set_powergating_state(adev,
                AMD_PG_STATE_GATE);<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
                &gt;&gt; index fd7fa6082563..05b79aced6e8 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
                &gt;&gt; @@ -355,8 &#43;355,6 @@ static void
                sdma_v2_4_gfx_stop(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl = REG_SET_FIELD(ib_cntl,
                SDMA0_GFX_IB_CNTL, <br>
                &gt;&gt; IB_ENABLE, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSDMA0_GFX_IB_CNTL &#43;
                sdma_offsets[i], ib_cntl);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; &nbsp; /**<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
                &gt;&gt; index 4a8a7f0f3a9c..1448d9beb7a8 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
                &gt;&gt; @@ -529,8 &#43;529,6 @@ static void
                sdma_v3_0_gfx_stop(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl = REG_SET_FIELD(ib_cntl,
                SDMA0_GFX_IB_CNTL, <br>
                &gt;&gt; IB_ENABLE, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSDMA0_GFX_IB_CNTL &#43;
                sdma_offsets[i], ib_cntl);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; &nbsp; /**<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
                &gt;&gt; index 7cea4513c303..0c6eb65f96f3 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
                &gt;&gt; @@ -923,8 &#43;923,6 @@ static void
                sdma_v4_0_gfx_stop(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl = RREG32_SDMA(i,
                mmSDMA0_GFX_IB_CNTL);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl = REG_SET_FIELD(ib_cntl,
                SDMA0_GFX_IB_CNTL, <br>
                &gt;&gt; IB_ENABLE, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL,
                ib_cntl);<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma[i]-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; @@ -971,8 &#43;969,6 @@ static void
                sdma_v4_0_page_stop(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl = REG_SET_FIELD(ib_cntl,
                SDMA0_PAGE_IB_CNTL,<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IB_ENABLE, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL,
                ib_cntl);<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma[i]-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
                &gt;&gt; index 7ee603db8c57..5af66a24b0a2 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
                &gt;&gt; @@ -502,9 &#43;502,6 @@ static void
                sdma_v5_0_gfx_stop(struct <br>
                &gt;&gt; amdgpu_device *adev)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cntl = REG_SET_FIELD(ib_cntl,
                SDMA0_GFX_IB_CNTL, <br>
                &gt;&gt; IB_ENABLE, 0);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_v5_0_get_reg_offset(adev,
                i, <br>
                &gt;&gt; mmSDMA0_GFX_IB_CNTL), ib_cntl);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma0-&gt;sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; sdma1-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; &nbsp; /**<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/si_dma.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
                &gt;&gt; index 7f64d73043cf..a8548678c37d 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
                &gt;&gt; @@ -124,7 &#43;124,6 @@ static void
                si_dma_stop(struct amdgpu_device *adev)<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mman.buffer_funcs_ring
                == ring)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_ttm_set_buffer_funcs_status(adev, false);<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
                &gt;&gt; index 82abd8e728ab..957e14e2c155 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
                &gt;&gt; @@ -210,13 &#43;210,10 @@ static int
                uvd_v4_2_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int uvd_v4_2_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;uvd.inst-&gt;ring;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) != 0)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v4_2_stop(adev);<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
                &gt;&gt; index 0fa8aae2d78e..2aad6689823b 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
                &gt;&gt; @@ -208,13 &#43;208,10 @@ static int
                uvd_v5_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int uvd_v5_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;uvd.inst-&gt;ring;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) != 0)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v5_0_stop(adev);<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt;&gt; index e0aadcaf6c8b..a9d06ec5d09a 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt;&gt; @@ -535,13 &#43;535,10 @@ static int
                uvd_v6_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int uvd_v6_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;uvd.inst-&gt;ring;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) != 0)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v6_0_stop(adev);<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
                &gt;&gt; index 0995378d8263..af3b1c9d3377 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
                &gt;&gt; @@ -598,7 &#43;598,6 @@ static int
                uvd_v7_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int uvd_v7_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v7_0_stop(adev);<br>
                &gt;&gt; @@ -607,12 &#43;606,6 @@ static int
                uvd_v7_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;For SRIOV client,
                shouldn't do anything.\n&quot;);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;uvd.num_uvd_inst; &#43;&#43;i) {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;uvd.harvest_config &amp;
                (1 &lt;&lt; i))<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;uvd.inst[i].ring.sched.ready
                = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
                &gt;&gt; index 3fd102efb7af..5e986dea4645 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
                &gt;&gt; @@ -539,7 &#43;539,6 @@ static int
                vce_v4_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int vce_v4_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vce_v4_0_wait_for_idle(handle); */<br>
                &gt;&gt; @@ -549,9 &#43;548,6 @@ static int
                vce_v4_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;For SRIOV client,
                shouldn't do anything.\n&quot;);<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;vce.num_rings; i&#43;&#43;)<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vce.ring[i].sched.ready =
                false;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
                &gt;&gt; index 71f61afdc655..df92c4e1efaa 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
                &gt;&gt; @@ -227,14 &#43;227,11 @@ static int
                vcn_v1_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int vcn_v1_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;vcn.inst-&gt;ring_dec;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pg_flags &amp;
                AMD_PG_SUPPORT_VCN_DPG) ||<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(VCN, 0, mmUVD_STATUS))<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v1_0_set_powergating_state(adev,
                AMD_PG_STATE_GATE);<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
                &gt;&gt; index c387c81f8695..37508277cbdf 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
                &gt;&gt; @@ -232,21 &#43;232,12 @@ static int
                vcn_v2_0_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int vcn_v2_0_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;vcn.inst-&gt;ring_dec;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pg_flags &amp;
                AMD_PG_SUPPORT_VCN_DPG) ||<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;vcn.cur_state !=
                AMD_PG_STATE_GATE &amp;&amp;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(VCN, 0,
                mmUVD_STATUS)))<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v2_0_set_powergating_state(adev,
                AMD_PG_STATE_GATE);<br>
                &gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;vcn.num_enc_rings; &#43;&#43;i) {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
                &amp;adev-&gt;vcn.inst-&gt;ring_enc[i];<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; -<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt;&gt; &nbsp; }<br>
                &gt;&gt; &nbsp; diff --git
                a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c <br>
                &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
                &gt;&gt; index 2d64ba1adf99..90a1994857db 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
                &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
                &gt;&gt; @@ -307,25 &#43;307,16 @@ static int
                vcn_v2_5_hw_init(void *handle)<br>
                &gt;&gt; &nbsp; static int vcn_v2_5_hw_fini(void *handle)<br>
                &gt;&gt; &nbsp; {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; int i, j;<br>
                &gt;&gt; &#43;&nbsp;&nbsp;&nbsp; int i;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;vcn.num_vcn_inst; &#43;&#43;i) {<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp;
                (1 &lt;&lt; i))<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
                &amp;adev-&gt;vcn.inst[i].ring_dec;<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pg_flags &amp;
                AMD_PG_SUPPORT_VCN_DPG) ||<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;vcn.cur_state !=
                AMD_PG_STATE_GATE &amp;&amp;<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(VCN, i,
                mmUVD_STATUS)))<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt;
                adev-&gt;vcn.num_enc_rings; &#43;&#43;j) {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
                &amp;adev-&gt;vcn.inst[i].ring_enc[j];<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &gt; _______________________________________________<br>
                &gt; amd-gfx mailing list<br>
                &gt; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                &gt; <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7C77c39c3849844479687908d7bb984adf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637184135103921328&amp;sdata=96plDq8wfssj%2Br4aKoTkDVXyTT7fGNjnr59FySOlH3k%3D&amp;reserved=0" moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ca040605cb0574b3fc93608d7bb945b4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637184118188416898&amp;amp;sdata=hzQLxdX8COuG2nB0mn6YWO4%2Btd402tIfRiOTh%2BCK58M%3D&amp;amp;reserved=0</a><o:p></o:p></p>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------24F3708F751452DD45AAE92E--

--===============1060830243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1060830243==--
