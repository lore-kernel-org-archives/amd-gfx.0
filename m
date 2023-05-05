Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2624C77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 12:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A85B10E04C;
	Fri,  5 May 2023 12:42:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B721C10E04C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 12:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVS8jf1JMeR681Q6lNlePr0mnBRwGra/8mfHgYa3kj9ZKv+cpGj6B9lm30cM2FDsEdJxQuQGMntUL6CvSXldAaBN+UsTT0QifNVU1iuXqbNYeQ/RR/q6L+2bTYLlJBp0rZjQDzXSPWlwvw7Ywz8sQPrKdzLtBgDeUsgDfDVHqR59X3xe75uD3Hn+tlYzkXYJqONKAH9S6ZnURcIrfGbqRwiY4lnJmoG4H4SMe+lKkda+PbBcI8/OgQfNPzzqrHURZJCxA3n8AfBCYK9ifteUrYuY/LL/l2OFIJ1UGLZNDKoiN6SxwD1XqKejV98d2a/c9rg+Ij0bJjwtHOA0PMxTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfLh7pBc+X/JL4JLN339miGGjNG1HXRFw69Ld89KLhQ=;
 b=KvpnXrBPooI6Lluiehdteesne25ZUsv4qZ7Ygm4/Y0O1zrsLXvgJ4AGS5TvgIUWl8EnINqyQP/Xl33odq//ZoCPRx+qg0VY5f6Gcr5rsKnoMuEDZUzgBm31I8+HW2jWAYB3Q1GwKx/EGUevwpRHT7rBtL91MSlKL6t9p51Yf5mdCWrnpvkuj70BxWPJlT2E4WYhAcLGA+ZlghTK4hklSuWorofY56O+QWK647Ol1yemPMqt1JCiE57geiRTNjbqYh2CW9ClQ/Jezdeb1yVgggAoJESu8J4TN1SiWRYn91/rQZFQDtGIwTkbPQigPmBf3SMqdiQUDXqVT0FMU2svRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfLh7pBc+X/JL4JLN339miGGjNG1HXRFw69Ld89KLhQ=;
 b=Hovrb6JMF9uHkOOdlKDjkkyiLzLBReCZy2f/iqqlJaxbS8mUV9y0pCSWzQ+HK2QXvbRVVF6C/Hkpz6llVGkoiQpV1utJ2rVfbajO5IMunt0ig51EyrD0UKHSw6SF4WEDEdsDE1dgGgbfYoetBbHfo0UAol52ogVy3JW86yqnJZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 12:42:50 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4591:d518:6545:8304]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::4591:d518:6545:8304%6]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 12:42:50 +0000
Date: Fri, 5 May 2023 20:42:24 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid null dereference of fence when using
 cpu to update page tables
Message-ID: <ZFT5sEfCcOPOVLP9@lang-desktop>
References: <20230505091020.1383923-1-Lang.Yu@amd.com>
 <412dddbe-67a1-48c4-1eb5-9cb7d672d79e@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <412dddbe-67a1-48c4-1eb5-9cb7d672d79e@gmail.com>
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 892fd2b3-860b-41ae-4fe2-08db4d663c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/ovkIQy89SGiwjSWANG2m71O/I/xgDJVVNoKmxRH0KLWGbxgabA2C0x9O3/Fx5obchsG+0QmxtQKkk3AOmec/Ep4TlZmP5uYnWvySoJCk3Q4DC0Y71TTeldXGKZzZpupEb36+3n44UeOhC0X30A0Pu6RgjjJa9Y813UNeT9ebND4BMYno0fNPu4W6QFXcOHZsd5BnaDxIcKKARxQXWFp/Xr94e/mO1LNyyV2WuqZn6XcKina6UzC0bEqUwb16t+3lnG6Oa6Ia1mHxG2EFC0d//9qaeH5fYb9+ZUjYBBSeb1LDFWaxJhHPOv1PnZHO/kCcyOm6Wg/BQjEcudsGXUp6vnVdmqUjj0kKa1r0sSMeR2RAyglp2CXSAp4wig6FWxRNnWhRE7SrUEddjdusjIP+MrgghQlY1eCU/07DGMoh7nfFEMCmtPfGwo/4+ADfBk3gAmPKSnBxXG4MPZF98ZOhpmlDU712ASlr1+/GwbgHHh5QRyD91rafo7+f6rGzWRM4sDNXNUtSHg5aUsBdZJ35uu9lo3y4CYYnekmVCkexqq0MTWcOkxxXXBcNywOm2Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(5660300002)(6666004)(6486002)(6512007)(83380400001)(66574015)(186003)(38100700002)(86362001)(33716001)(26005)(6506007)(9686003)(54906003)(2906002)(6916009)(4326008)(66556008)(66946007)(15650500001)(66476007)(8676002)(316002)(8936002)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9uoGkIWaW0zzAt1B5Qi3I1LhYJFrfdOJqdQXlTBkTt+whvEhUHoYGex3Ny?=
 =?iso-8859-1?Q?TklFaSRB4qXEpiBog2/r7RIXt7RYUxVmqfyjk8Y7Cmk3xnk5OHIeDnmPDQ?=
 =?iso-8859-1?Q?60jphOP0Ta1Ig661k+IvfneAGooHWDKonQ5En3CwWzLiYHN11IrrAAe7cp?=
 =?iso-8859-1?Q?aQEISor7AvcO4GSI85gmXwRxM4qFQvTMf04MFERijpr63pz8PBKOGi3uOo?=
 =?iso-8859-1?Q?mnsnr7G49+cqUJAK+famkaUt+2S7Qc1MK2N30BIm5IM+UVB+ntm4Xozu/0?=
 =?iso-8859-1?Q?3G+LHSBXEJTBPvEKEc+3LlyL/15iHcNjreX+MM4pJz4vGdLJojfi2p3CfR?=
 =?iso-8859-1?Q?VpHQLVL9Wc4xnoG4/pxG+tlMEmE0pVCajPOhzIJ9qUdzsZ2Cq07xtfLtDR?=
 =?iso-8859-1?Q?sqGpc7X29htniayL/X0m2FthWFK3g8dhyuGFRuTX9HgVLngq98pd8jiEDc?=
 =?iso-8859-1?Q?p/A8a99vKaKnPldHKXeD49YGGp+u1KBfWyhcPWpSHRA0PPSoFLxtPzNrZ4?=
 =?iso-8859-1?Q?2hXWAp5s5PaQpgw4xWnCnwUTDyRbMeOyE9HbPY+2qFFe/hy4FallTxlRkH?=
 =?iso-8859-1?Q?j3Mi4myslvexyrdGwHWcJgcfFJA2D+SUGVFAb8bKp0QoKi1Xh8oSE76FUd?=
 =?iso-8859-1?Q?l/8jYxa/D/0O2RqolcT2YB4Xr+q/5T3WGDnjzIlc43nEX33KHIv0mnhdON?=
 =?iso-8859-1?Q?l6u3V85MhXHb2hpamLodL8/rcZrAa4YcvRikvr6OXjpYFYr/eb8TDPegyt?=
 =?iso-8859-1?Q?Smq84d5ZpRyQcqOyUGm+zUTriuow1xYiRuQKQ1WA//piaZC9VIYM6UAcgf?=
 =?iso-8859-1?Q?5bzMYov5BBi6X/4lLe1BQtdTssMDZL/C7TMJ24gEhlMJ6JG+KVkmg1r1lt?=
 =?iso-8859-1?Q?X9Qk+57Q8pX9Rk6C6uQ81q/sEVV6G2JnH1Shswrk+Td1orFPSTvxDB6VHC?=
 =?iso-8859-1?Q?c/3EDUDTtolnyIWyil9V0SDbH/wbNylV1oUy6B/Hr7kIPMw5kCT2nt5KIR?=
 =?iso-8859-1?Q?wf/Wxj9YdgCRGbs0AoEPi5OGtH3N7FUSD1XgS+2dDdBriLh88e7ZrRLSYr?=
 =?iso-8859-1?Q?p8VnbWmucgbm8BIlDzY6Rngk4J8sBdYNnqM77kD1WTFEN01pqVFt50Fg5l?=
 =?iso-8859-1?Q?CjUSsJ5tQ5bbYHV6/cc+MxnkRliVSADVkkWH1j66xwfSlwwf+zJwpNhS2a?=
 =?iso-8859-1?Q?L7Q/u+qh/LdM8yjkLSrQsvuQArDYRR95mxW/P+Da7Rvk2vmFcRwed8Lndz?=
 =?iso-8859-1?Q?H60xiY2xpkaOKXsezR+8+QTLSKGm8IrUgVbPBVXFog9mP6FAYbkyc0y704?=
 =?iso-8859-1?Q?dNnQAZo64Vx8lOS6jGWGyKksN+rvrQ9MyHGX7/cQf7C61Oww3SKi1F/34M?=
 =?iso-8859-1?Q?JGkl0W+sLLH7cGTFleBwY4rV2XYoEkOSabhhhr7Xqc3VCwhZi0yuEobzJf?=
 =?iso-8859-1?Q?2gz2hZj1mr3xMz45HHoQnZYTrF4WMEL5ZRQKsQZ40k91OE4JNbbRQVwEug?=
 =?iso-8859-1?Q?RikNnO8trQAr9pRYjftrFyL0mYNnWDR44LYEVhd/u3ZlSdlIJOsJ5ZlIP2?=
 =?iso-8859-1?Q?aimAeGHQ04qJBwXQznuXp0TcnAV+mWTnXkN/jLa0738TBFPlOL46rCjeHB?=
 =?iso-8859-1?Q?w88sDCiA2kRKYVGVnM360Ga2CalUf6Eqw/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892fd2b3-860b-41ae-4fe2-08db4d663c7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 12:42:50.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTp28CFjO1yPqIWrk5TQszC4ZAl+UHOS/4mxvX+Z7zSsQGKisnofdQulFjGmFOYlS4BKzLCffyKgizjDr9wYdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 05/05/ , Christian König wrote:
> Am 05.05.23 um 11:10 schrieb Lang Yu:
> > Using cpu to update page tables is sychronous, no need to wait fence
> > and it is NULL in such a case.
> 
> Good catch, be we usually install the stub into fence pointers when they are
> unused. See dma_fence_get_stub().

Got it. Thanks for your suggestions.

Regards,
Lang

> Christian.
> 
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index f0f00466b59f..197981c4ac7d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -1043,8 +1043,11 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
> >   	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
> > -	dma_fence_wait(gang->process->vm->last_update, false);
> > -	dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
> > +	if (gang->process->vm->last_update)
> > +		dma_fence_wait(gang->process->vm->last_update, false);
> > +	if (ctx_data->meta_data_va->last_pt_update)
> > +		dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
> > +
> >   	amdgpu_mes_unlock(&adev->mes);
> >   	r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
> 
