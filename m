Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E8FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 13:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E3810ED03;
	Fri, 29 Apr 2022 13:18:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C351910ED03
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 13:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIJCfBVgmNf9el+IKpurbh9ts93+7Vs62baXks+lXUjKF1nieaOzB8UeO23/5c7uiFEj4gj4hxxdWg7u09gWU4f3CkOstLoeinq08w5uPQMgRdn6o4KpqZxBBzxJFjzexvIx2P9glzNmHef+MPd4tez+3Qzq8XUIGyR2R9VZm04N6R2tQKasCJcbmb1KX+z1zEymEM5YN2BGhqn415IM+s6AvX2bZDxm6ZVOiRtSJKzct+lVW6sF/R76b2wY9vFI8OmK8cNb/VYEUTVfCVZ34qiFR76DutKOzTMD8OHc8naCjogd1ie+PjhYU1o/5Ey/rhhEOtqi4HYrEQ+7DjGQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2ZuEk5g0SdJlt7XfIbbKPtS6+taPvsEAyufuQkcq3U=;
 b=UY7zPYVoc9xdnbZ2j3PEj5Y8+mQzYIIDZQDjYtn70tP+3vMw6DqcBAbNHY130GvYXlGGNb1wai3AbncJ5+EobOhTGbi4fRXyeNSSXPKtLlpJu39wuTz7tH1hD5pNX7FUcGp0rhASbbatvq9EsZASm5fjZO10U2shR/U2rArYOsPXVbLawBisbEVXaUwRvI076Vj3xxbg437kIzM0Sf4n2Pgvd/mkbOBhvqeLuhrvqFDHT/IQ1gORAm2F6Wtzj0S8tr6defXvmB0XeuO1uzIjz3YNeJFUW02OsdWNnDbv3OPokSguzd3vc44TvTuubAV6SEs+pGtpwolZU/g9mlZDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2ZuEk5g0SdJlt7XfIbbKPtS6+taPvsEAyufuQkcq3U=;
 b=kmXV4d456TDDdzUas+Z5eolfGRY301LC3FP9Doh04oKpxO4Pv018X8eE+VIT5LGQGujWtNde9/mCGMOV3hvWhFwjPxoNzVpuCng+p57bhrYQ7RdtFOZcZmxvrNsfeop5Erhd9G7MG1+Qkr9taVoOGVN2nqN7OrAQfMGfmZrzAuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 13:18:41 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::cdb7:3025:c623:7e5%3]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 13:18:41 +0000
Date: Fri, 29 Apr 2022 21:18:32 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Haohui Mai <ricetons@gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Message-ID: <YmvlqJ1Jp+wukdwA@lang-desktop>
References: <20220428095327.10513-1-ricetons@gmail.com>
 <YmpsF4F109J3+zzH@lang-desktop>
 <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
 <YmqfNbHqsuE/erWL@lang-desktop>
 <CAHpOOhEA-GEgLU9B8RrYo9VnATj62sqnRm+6e3NsHo2H02pD7g@mail.gmail.com>
 <Ymuin6/LGeiz4SE9@lang-desktop>
 <CAHpOOhEKWgi93gZy0517Lxgm0W3piiiXd4c5Bzb3_a_91x2Rjw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHpOOhEKWgi93gZy0517Lxgm0W3piiiXd4c5Bzb3_a_91x2Rjw@mail.gmail.com>
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452fbfcf-f0c4-41e3-065b-08da29e2c742
X-MS-TrafficTypeDiagnostic: BN6PR12MB1218:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB121877ACEF7AEFDBE0446284FBFC9@BN6PR12MB1218.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3mEQ33UYI5DHQnpXt0NJAvl1lOsRgqoL2NCO+BGN7wUfN2Nt9fEwTCaIdqU+/zuMnX6d4Xsarif0xz0hapZKT+2dV3AdbXdwMiBZO4nDdXbyFZaet/bVKQ26xCSf1l3AbCKvdzKnaFnrvd82D0WvWt4HPUzd3FmGNW+ry4Hehb1GtpiM/w07+PA+mMhijvLMnLU1ImCeJMhLVCLFm5rUtKHXF+QUqmyGS5yVtgl5PKlAvfuCd6nqBi+fh/GKe8FIIffKedb2a6z1XTbhNJZ/DbxeuWZdlE1tTdV/rW926ToAiGM2/589usdpz/yj1E4sqmkInbcbhukwvp1Mw+vSRK3uuiLH1RG8y19/exDTQREnUQywgvnLvYupMw+BPhUUsi0aZz0IeRseMKMulM0HoX8dRTpyj4DfjDvzLF7IOKV2gB6KmzvW3a7CZBoy9PZ0Y+TStNhHeNEvUGPEBIsuO+18B15YKGLNE92T3jmuq+d+TqFoVoewG+CJlXnHAHp9MGKlx23ymjYVgL8hBtYVyAg1+Fn2ZI4CcKUb6UntwQuUk4pXobDPQn2Ad26zm6W44bqiWYywX3KMPmq6eGEwmX8WFfmoVYtcP5oRT/4l+/pBaDqCpc8NZFk+egajSmrQ3+IjaSitNZGvq7JAO9RyHTKI5deJII+Eaue5lQxNxjk2To4m4svnOpiJzCLsSju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(30864003)(5660300002)(6486002)(8936002)(45080400002)(6506007)(6512007)(26005)(2906002)(53546011)(6666004)(508600001)(9686003)(86362001)(38100700002)(83380400001)(186003)(33716001)(4326008)(54906003)(66946007)(8676002)(6916009)(66476007)(66556008)(316002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PImtFPTY6saa+PXjCVhJflW0fv6v6K2kkVKeU5GUW0Uykx7+yPqFw/34f447?=
 =?us-ascii?Q?+0LEMtP1HucHWqkRWe8m0tfkWMR0fTtTPBk5E78UnSG7x16b8toAyU/rNHZ1?=
 =?us-ascii?Q?xKq2AfyjGDUJBd7SgU1Km7kvaaVYiTPCXC/7HJWmwkb2UuwyaQ+si3xDKK74?=
 =?us-ascii?Q?bC86zZOW6fqCGHeIARRn1c96FVNBmAywCFUmP8GulWyj+uv5dPvQTtA28oXa?=
 =?us-ascii?Q?U9GmyeDbKrx4Mx2Rl24XJ/YqiG9Ub+fQjfD7UHTRRAoA0bu4F2k+KqntM9Ta?=
 =?us-ascii?Q?N7SKEzTLpnOwzB80fZRSx3BYBVNqsJZKSH/ROTtXCpZFnOudGVqTwRklE/C8?=
 =?us-ascii?Q?tykUhjbcua3WBpnEAEEhEAHdvYrzU1W6TumoELx9X9wKoU5f0nJJnmGEePgJ?=
 =?us-ascii?Q?nD7faEGj1sMxankpE3OpP9m+Fkjxv04dPfBWvQBrlgkjQcrz5ZLG7d4aFHao?=
 =?us-ascii?Q?2o56srb5TD5YTCxR8dkhnxYKl20JsxREZo6DiQHmjeC6AQYHIxceVt10fB/M?=
 =?us-ascii?Q?Wrw0rIFUU7xcNs7/1GAchZKf0d0VxjfAEGoMPLMh8b/cQjsFebiuPweFRkLc?=
 =?us-ascii?Q?8LtjhI1AcJT0NyvMCrOA/e85u/XznbiOmoyPzQ83lJUGcPOjJJ8mfyCsUKDY?=
 =?us-ascii?Q?UMe7VFHRM5XZP83vZiF5qZcglYLwrbjd3VubaGit+Llc73Zf2ktg8eVVpcfx?=
 =?us-ascii?Q?ddbmi4zcBotNN0CiFZp/uyW1I/PspxXyy1zZV/2j+GPTXnTXGxdwKJjyUW1Q?=
 =?us-ascii?Q?XfEpglPnpPtSZFhfnLPDalDUACYopmzLGbsvZGb1yZJIcSq1YyvEpZTO0+Dk?=
 =?us-ascii?Q?/Wxe0bU6tGC2899Rbzl5lCp3QWU/31uOeBQmX5nmMiEyCoAfOHg10C2kSsf5?=
 =?us-ascii?Q?fqYJZMRqybhCE4TMzScHeBydrwbtSxvA2JWWt5jimuMDHecmj30vSN0GmBId?=
 =?us-ascii?Q?e7bQP4NNhgxmwqmaFaH0RplrhSTlgU0TU+H1QABZ14rd8aTCQZuDUz+aB2Bx?=
 =?us-ascii?Q?cwDcjeQJZWDh2tkty/wO+d/UwAH1YZvZ/s3WEM/s9TbZsAv34O0GZJ/SfvGQ?=
 =?us-ascii?Q?Ry9NPSJRE4vW3VswfySFWC8F9hl/6Vq7BAQZGFe3MWgp1objP/uMquzzSzG3?=
 =?us-ascii?Q?xW4lcKlrmQaT60XU7qF1WtNSNO/ueozeU6RacoIhQtDJn68klw9i50DJ55mq?=
 =?us-ascii?Q?0CR6VRTSpRTjE68tSwl8BjUVOJVLU9Ii3mDwJ8dlAPANk/9Cz5wj7xyJfQ1x?=
 =?us-ascii?Q?TTSUXf1w9aGT121DgHtjcr3n1X2/x++c11llX/kdn57smJUzxBdpOcLri33Y?=
 =?us-ascii?Q?qS6F2aawPlxqIDSUi/v8aGPAIFzOsLrGYauUdMeIGkxWv7uXgSpfYr0Ab3A8?=
 =?us-ascii?Q?jwhv2Xu4y1dAzXHJz3kmKTF8aUHDMbXtRsLvRRm42L7rRMFf/hF2w612io1s?=
 =?us-ascii?Q?u3s8hNpeHlYS1+YOD2sX7X1ESGgSRgwY6dr912pV6AFBYl1ECEjm71Pdwt0Q?=
 =?us-ascii?Q?mwE2HaX8ge5T9en+jDTDyyMOj9cPcDlD7Pax4jB/M2E/qZQ78rRSxzTIVte+?=
 =?us-ascii?Q?nxENBjgHEGX+VVn1P8+GGvmQ4ZGAz0NZ1d1LoSMC008ckm0DLPYw7gbUBJQI?=
 =?us-ascii?Q?D69EHgqT9Dk4RIMZITOud3sBWG2exsOioY2uKQPaxpliI5PfpGryvc6Dqf2w?=
 =?us-ascii?Q?E5nRIITdqAt9rnzch4ThZ35OGQxXsfAtqBOMHTfqEXJuT+91yQd0tp4tr7pp?=
 =?us-ascii?Q?lQsEcbh4ew=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452fbfcf-f0c4-41e3-065b-08da29e2c742
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 13:18:41.1826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS/U7K3BBN1UF25+cwkLOjeoh34cwjuvjPeyjrF5+dl/t54ag1I4fHVZHDfF9pJFirXETExUQgEhTc4ADD3P8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1218
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/29/ , Haohui Mai wrote:
> Sorry about that. But can you please confirm that the call of
> sdma_v5_2_ctx_switch_disable_all() is still required to fully disable
> the engine?

For sdma_v5_2_load_microcode(), I think sdma_v5_2_halt() will suffice.  

Regards,
Lang

> Thanks,
> Haohui
> 
> On Fri, Apr 29, 2022 at 4:32 PM Lang Yu <Lang.Yu@amd.com> wrote:
> >
> > On 04/29/ , Haohui Mai wrote:
> > > Thanks for pointing it out. The v5 patch added the code back.
> > >
> > > ~Haohui
> >
> > But you didn't remove the following codes added in v4.
> >
> >         if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> > +               sdma_v5_2_ctx_switch_disable_all(adev);
> > +               sdma_v5_2_halt(adev);
> > +
> >
> > sdma_v5_2_halt() has been called in sdma_v5_2_load_microcode().
> >
> > No need to call these two functions here.
> >
> > Regards,
> > Lang
> >
> > > On Thu, Apr 28, 2022 at 10:05 PM Lang Yu <Lang.Yu@amd.com> wrote:
> > > >
> > > > On 04/28/ , Haohui Mai wrote:
> > > > > If I understand correctly, the original code will disable the HALT bit
> > > > > of the register mmSDMA0_F32_CNTL twice on other code paths -- one in
> > > > > the sdma_v5_2_ctx_switch_enable() and the other one in
> > > > > sdma_v5_2_enable().
> > > > >
> > > > > The change ensures that the bit is only disabled once. Just wondering,
> > > > > which one is the expected behavior?
> > > > >
> > > > > ~Haohui
> > > >
> > > > The HALT bit of the register mmSDMA0_F32_CNTL is not set/reset in original sdma_v5_2_ctx_switch_enable()
> > > > (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Fsdma_v5_2.c%23L523&amp;data=05%7C01%7CLang.Yu%40amd.com%7Cd3ebe4ce65f844567b0708da29bf15f2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637868197938534483%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=rHBvnV49RBwwYqFp8DmaN8lNBLgw4osg2wRFlxgYKSk%3D&amp;reserved=0)
> > > >
> > > > Regards,
> > > > Lang
> > > >
> > > > > On Thu, Apr 28, 2022 at 6:27 PM Lang Yu <Lang.Yu@amd.com> wrote:
> > > > > >
> > > > > > On 04/28/ , ricetons@gmail.com wrote:
> > > > > > > From: Haohui Mai <ricetons@gmail.com>
> > > > > > >
> > > > > > > The patch fully deactivates the DMA engine before setting up the ring
> > > > > > > buffer to avoid potential data races and crashes.
> > > > > > >
> > > > > > > The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.
> > > > > > >
> > > > > > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
> > > > > > >  1 file changed, 62 insertions(+), 51 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > index 013d2dec81d0..b000117b77d0 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> > > > > > >       }
> > > > > > >  }
> > > > > > >
> > > > > > > -
> > > > > > >  /**
> > > > > > >   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > > > > > >   *
> > > > > > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > > > > > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > > > > > > + * context switch for an instance
> > > > > > >   *
> > > > > > >   * @adev: amdgpu_device pointer
> > > > > > > - * @enable: enable/disable the DMA MEs context switch.
> > > > > > > + * @instance_idx: the index of the SDMA instance
> > > > > > >   *
> > > > > > > - * Halt or unhalt the async dma engines context switch.
> > > > > > > + * Unhalt the async dma engines context switch.
> > > > > > >   */
> > > > > > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > > > > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> > > > > > >  {
> > > > > > >       u32 f32_cntl, phase_quantum = 0;
> > > > > > > -     int i;
> > > > > > > +
> > > > > > > +     if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > > > > > > +             return;
> > > > > > > +     }
> > > > > > >
> > > > > > >       if (amdgpu_sdma_phase_quantum) {
> > > > > > >               unsigned value = amdgpu_sdma_phase_quantum;
> > > > > > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > > > > >               phase_quantum =
> > > > > > >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> > > > > > >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > > > > > > -     }
> > > > > > > -
> > > > > > > -     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > > > -             if (enable && amdgpu_sdma_phase_quantum) {
> > > > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > > > > > > -                            phase_quantum);
> > > > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > > > > > > -                            phase_quantum);
> > > > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > > > > > > -                            phase_quantum);
> > > > > > > -             }
> > > > > > >
> > > > > > > -             if (!amdgpu_sriov_vf(adev)) {
> > > > > > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > > > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > > > -                                     AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > > > > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > > > > > -             }
> > > > > > > +             WREG32_SOC15_IP(GC,
> > > > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > > > > > > +                     phase_quantum);
> > > > > > > +             WREG32_SOC15_IP(GC,
> > > > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > > > > > > +                 phase_quantum);
> > > > > > > +             WREG32_SOC15_IP(GC,
> > > > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > > > > > > +                 phase_quantum);
> > > > > > >       }
> > > > > > >
> > > > > > > +     if (!amdgpu_sriov_vf(adev)) {
> > > > > > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > > > > > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > > > +                             AUTO_CTXSW_ENABLE, 1);
> > > > > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > > > > > > +     }
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > - * sdma_v5_2_enable - stop the async dma engines
> > > > > > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> > > > > > >   *
> > > > > > >   * @adev: amdgpu_device pointer
> > > > > > > - * @enable: enable/disable the DMA MEs.
> > > > > > >   *
> > > > > > > - * Halt or unhalt the async dma engines.
> > > > > > > + * Halt the async dma engines context switch.
> > > > > > >   */
> > > > > > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > > > > > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> > > > > > >  {
> > > > > > >       u32 f32_cntl;
> > > > > > >       int i;
> > > > > > >
> > > > > > > -     if (!enable) {
> > > > > > > -             sdma_v5_2_gfx_stop(adev);
> > > > > > > -             sdma_v5_2_rlc_stop(adev);
> > > > > > > -     }
> > > > > > > +     if (amdgpu_sriov_vf(adev))
> > > > > > > +             return;
> > > > > > >
> > > > > > > -     if (!amdgpu_sriov_vf(adev)) {
> > > > > > > -             for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > > > > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > > > > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > > > > > -             }
> > > > > > > +     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > > > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > > > +                             AUTO_CTXSW_ENABLE, 0);
> > > > > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > > > > >       }
> > > > > > >  }
> > > > > > >
> > > > > > > +/**
> > > > > > > + * sdma_v5_2_halt - stop the async dma engines
> > > > > > > + *
> > > > > > > + * @adev: amdgpu_device pointer
> > > > > > > + *
> > > > > > > + * Halt the async dma engines.
> > > > > > > + */
> > > > > > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > > > > > +{
> > > > > > > +     sdma_v5_2_gfx_stop(adev);
> > > > > > > +     sdma_v5_2_rlc_stop(adev);
> > > > > > > +}
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * sdma_v5_2_gfx_resume - setup and start the async dma engines
> > > > > > >   *
> > > > > > >   * @adev: amdgpu_device pointer
> > > > > > >   *
> > > > > > >   * Set up the gfx DMA ring buffers and enable them.
> > > > > > > + * It assumes that the dma engine is stopped for each instance.
> > > > > > > + * The function enables the engine and preemptions sequentially for each instance.
> > > > > > > + *
> > > > > > >   * Returns 0 for success, error for failure.
> > > > > > >   */
> > > > > > >  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > > > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > > > >
> > > > > > >               ring->sched.ready = true;
> > > > > > >
> > > > > > > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > > > > > > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > > > > -                     sdma_v5_2_enable(adev, true);
> > > > > > > -             }
> > > > > > > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> > > > > > >
> > > > > > >               r = amdgpu_ring_test_ring(ring);
> > > > > > >               if (r) {
> > > > > > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> > > > > > >       int i, j;
> > > > > > >
> > > > > > >       /* halt the MEs */
> > > > > > > -     sdma_v5_2_enable(adev, false);
> > > > > > > +     sdma_v5_2_halt(adev);
> > > > > > >
> > > > > > >       for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > > >               if (!adev->sdma.instance[i].fw)
> > > > > > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > > > > >       int r = 0;
> > > > > > >
> > > > > > >       if (amdgpu_sriov_vf(adev)) {
> > > > > > > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > > > > > > -             sdma_v5_2_enable(adev, false);
> > > > > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > > > +             sdma_v5_2_halt(adev);
> > > > > > >
> > > > > > >               /* set RB registers */
> > > > > > >               r = sdma_v5_2_gfx_resume(adev);
> > > > > > > @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > > > > >       }
> > > > > > >
> > > > > > >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> > > > > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > > > +             sdma_v5_2_halt(adev);
> > > > > >
> > > > > > You don't need call these functions here.
> > > > > >
> > > > > > In original code, you can see sdma_v5_2_load_microcode() calls
> > > > > > sdma_v5_2_enable(adev, false) to halt the engine before load ucode.
> > > > > >
> > > > > > What I mean is sdma_v5_2_halt(adev) should have no functional change with
> > > > > > original sdma_v5_2_enable(adev, false), like this,
> > > > > >
> > > > > > static void sdma_v5_2_halt(struct amdgpu_device *adev) {
> > > > > >         u32 f32_cntl;
> > > > > >         int i;
> > > > > >
> > > > > >         sdma_v5_2_gfx_stop(adev);
> > > > > >         sdma_v5_2_rlc_stop(adev);
> > > > > >
> > > > > >         if (!amdgpu_sriov_vf(adev)) {
> > > > > >                 for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > > >                         f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > > > >                         f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> > > > > >                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > > > >                 }
> > > > > >         }
> > > > > > }
> > > > > >
> > > > > > But you remove the codes to set the HLAT bit of register mmSDMA0_F32_CNTL.
> > > > > >
> > > > > > Regards,
> > > > > > Lang
> > > > > >
> > > > > > >               r = sdma_v5_2_load_microcode(adev);
> > > > > > >               if (r)
> > > > > > >                       return r;
> > > > > > > @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > > > > >               amdgpu_gfx_off_ctrl(adev, false);
> > > > > > >
> > > > > > >       sdma_v5_2_soft_reset(adev);
> > > > > > > -     /* unhalt the MEs */
> > > > > > > -     sdma_v5_2_enable(adev, true);
> > > > > > > -     /* enable sdma ring preemption */
> > > > > > > -     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > > > >
> > > > > > > -     /* start the gfx rings and rlc compute queues */
> > > > > > > +     /* Soft reset supposes to disable the dma engine and preemption.
> > > > > > > +      * Now start the gfx rings and rlc compute queues.
> > > > > > > +      */
> > > > > > >       r = sdma_v5_2_gfx_resume(adev);
> > > > > > >       if (adev->in_s0ix)
> > > > > > >               amdgpu_gfx_off_ctrl(adev, true);
> > > > > > > @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> > > > > > >       if (amdgpu_sriov_vf(adev))
> > > > > > >               return 0;
> > > > > > >
> > > > > > > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > > > > > > -     sdma_v5_2_enable(adev, false);
> > > > > > > +     sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > > > +     sdma_v5_2_halt(adev);
> > > > > > >
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
