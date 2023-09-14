Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FE6EDE983
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 05:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64EA10E501;
	Thu, 14 Sep 2023 05:59:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5D210E4FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 05:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCOJlSkDv4kHZstE/EPA9qPxZpd18LkbAYKs4U3kT3EUNkTRMEwsqn1vRn1sSBnBFDcy0mq/8ozn8YjolhCP6z/AI33RHwl+Nj+LLkBl4QR8/Hc5iXDoZXUiUH+Gm+tilMSn7q+tHjCXla7+nXHGGHHgZO0KCdkrO7VqUlFxiCteykP5P0Jx0LX/7oNa7wzHDHgb1UCMXlptKnVNwYRkiN+GXJQg+Q8fuUqjDpXKwN7TpaIfuoMZnYl/RttpNVm5V0AFxqohAbsBQsKGdOosc8SpHX55y2CaxOiVjhcPcyZwYceOmSIjlK+Sax9NRcf8sKqgRGDaxMQqUdZXs/KVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbqYa1+9UhTBYy6A8cXCd4ZkjXAVPlKOtDhiIL0+7/M=;
 b=avWwHJiRv1y7EvTH5W5sG7jlgOaElFKKV0iuEGw0hc4jXSrVE9zLSDU+hK79l8XObmTr8nkVIYqIgr/K/mdgOHTPBhZRG0cFnOqQZzslGTLa65biWSkWCKQYuKt3MzgUCEIFMECWJoA76CDStAmc+v5saT9pv0uyw3xd8LpY6OicLNF5ZnuvJPj9JRgJqz0JttuRAoklF0V9sw5Bk3ztZRzfFb7CYfnun9OR/XPlzrokD6lhbX8CSlx5lctmEqdwUkGZp9lLlEu0Z1imKjK2P/vnphzM/5r0x33xf6ptmFFR9qlUVCeYhAkOIVycCYg7Y2SHGzlBTWCyu5x9YPYl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbqYa1+9UhTBYy6A8cXCd4ZkjXAVPlKOtDhiIL0+7/M=;
 b=XKU+ygEL0GTZNMNSCD620ZeIzwE7qPNlrqaCEpyc21GoAEpmf6qwPBXs6jxNBQSv5oxA945I9El3uPPt64PKATBLV1FJX42XxGw55dv2P4/7AKJl1EMv1CkHpJTNkEBpF0/hOE0RbDyeDrWjVYO6qbElbOxZXuXSnGpmsfIpumY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 05:59:01 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 05:59:01 +0000
Date: Thu, 14 Sep 2023 13:58:53 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Message-ID: <ZQKhHeHjIEYP0qrH@lang-desktop>
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
 <ZP/SdUd9am/f2WJw@lang-desktop>
 <c04dd9a3-ab81-5d5d-fafa-93877073017e@amd.com>
 <ZQGNtOJsi4K914Oc@lang-desktop>
 <5300374c-3f89-b80a-622c-afca07eb0e16@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5300374c-3f89-b80a-622c-afca07eb0e16@amd.com>
X-ClientProxiedBy: PSBPR02CA0009.apcprd02.prod.outlook.com (2603:1096:301::19)
 To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: f796b476-500c-4e46-e51b-08dbb4e7b150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsY2A31MTwiVfH8oeSla3bwpKFimmPnma3fHG35NdqFn87emV+YD+1o4LFMHd7PFBVAtf6VfUXzGLUsn5X2VCd4CZtpRZFDJ45Op2k5DKeSJimB84lMnAfoc6vWYW+6bcDgkp9RDryPivvT6NfOHiuryAl5Ugr8+wUmARY5eoYabrWp6Ghhn9gqAhyEHQGEboHl7QwPn0qq2Hr0NZ2j0rpKQTnZSGG4611mB6qy/FfaEhEEEdwOe4+jgUISpk3HTHAxV3Z7A/hihaPpeGkLSwkvBnA+5xCOObABOiBEvtJYuRFu5+69mzxHnVGBgyDIvBI5rgkg/+qSh9IKFzd4pOX3Fbgr1hXGNuFbRh4fn4lnOhiStADmrUlNrve2YuOEObaMHjKng9C4cHnjHqlF9N9UuMls8jUmpYQX+tcGUo2U4Ijfb70TnKNInfI5jzx3KMK8K0DY2jxhwbB7TaKFV+tUTtiqV1bEAiqScsUtJh8cazUM0a7hFGCLCXI94eW3pAWuKaWbPByTpwTEtOZep2cIIF4x0Z6hlqBSmETWKjLpBoab+KBlm6QYJUXfGL0fS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(186009)(6486002)(6666004)(53546011)(6506007)(9686003)(6636002)(478600001)(26005)(83380400001)(2906002)(66556008)(33716001)(66476007)(316002)(66946007)(6862004)(5660300002)(4326008)(41300700001)(8936002)(8676002)(86362001)(6512007)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eKiDlGxCNBgLwMQyynGpVe/q6ZShxr+SCIovVoMLNOVGT0Q4x4Ib/JNr6t?=
 =?iso-8859-1?Q?JJD3fgpoW4wvbIJ8rLtsuQdFKPqrzLrZsX7duHwq6VzvEQ8EeMn9W/Pqgh?=
 =?iso-8859-1?Q?E8qPH/lIAl2a1o4+5f5CBcVgiN6VqSP8H3KoDipt17JnR2woC17vyK1T86?=
 =?iso-8859-1?Q?+5osQ8W7q1SHctAzDJZ34thyMKovvsblJTURJ2TzzkI/22BM5qcBqOtKsM?=
 =?iso-8859-1?Q?5lV9aX8MrrKZ1arpQhXq80nfatN0maOojB2gZ6s0aRbzowjna/DhbnV8a5?=
 =?iso-8859-1?Q?7TaZ1PXISVc3nN/sQzU2YYZ5Vobjd4X9Jp3qtdTONO7RFBsIN9hrOi2yJz?=
 =?iso-8859-1?Q?isQE2jylNuOTszjMWVBi4YkHUtGgg6NnECiIOyK71LrpWMOlFndXsR/Kh9?=
 =?iso-8859-1?Q?IvCyKfJI84WGSPRKbkJ4osaJLMOUVHB0jG0camnHirJCqvTtCICkp8ou/9?=
 =?iso-8859-1?Q?+5P+g9a/jq0arqak2uXVGjAjEVvYjlkrJXOJWdh7BnDJ95rrwLqR7zSs09?=
 =?iso-8859-1?Q?+XAdWL/5gOWBfK4We3Ay9AvmggHJr6mcCwSuBAVs5uWl0njZplZmGYHEPP?=
 =?iso-8859-1?Q?9/mSkyrkin3aH2dBF1Njw4R7dH2w4qbT4XPeYm/Jfg3lHIn0h4FMj81ro0?=
 =?iso-8859-1?Q?f2nycyRAoe52VUq8l/Tr3XNnZzrZVL8IbH3SrkZkftZhdLuP5AC2SIInA+?=
 =?iso-8859-1?Q?CEhOOaTb6rg2r/svzxo4fYwLKjp1zRDVpUlsiW9FuCy8hYadfyvDSxU9lA?=
 =?iso-8859-1?Q?9zJz0GnBCsXYt5T7YT3GAZwD0k4QNtYqFzhUYcNsJwnH5FysnBkEHo4EzG?=
 =?iso-8859-1?Q?Wxb29W5+uFQq/Rolqwrgm7NLh4RttB1SJr8+kX05kvjrOUlDFfnI2I0V4H?=
 =?iso-8859-1?Q?jR6zrY6HfRVJstZvhRyEpG003LVwOyNFh34yGa2mpvG5Ky69Kq0bP2SQpt?=
 =?iso-8859-1?Q?U16S2HTRGk3wJ9SBDXux8ebuTLMWofzmcfyOGzBE195bIBACW82/1twS5v?=
 =?iso-8859-1?Q?IFuRNKuAJQDlyJWYi4MuFzJb1repfxiQc97PDumkeLBpTyRRXlhLdxAAg5?=
 =?iso-8859-1?Q?xN3b08KVAWWDXD8xVOfJ+74Kk92RHe2ffTk9IqMEHrEwh7xcZlno74SVCV?=
 =?iso-8859-1?Q?RzWDrrjSiwSIWIfKytRPBaLZl98udWsu2lYIpL1ooXZu8JPBWU8JOfFS/a?=
 =?iso-8859-1?Q?MkBqlMaD8QYw+wPDyZZnLxI9qPUZ6CqIKmFYhZxnOKyxtiHmjlEgsGp6wk?=
 =?iso-8859-1?Q?RzpN5GYQ63KL1t6u4VqRJmOa/ZN21Rc6KqWvYijnqXFZrpkOtHtksksQfx?=
 =?iso-8859-1?Q?YNLWg//4iTNf15kXRfpMUiujbQFae8chwxIP6qUVarQE+2QZxHCWCjCl3q?=
 =?iso-8859-1?Q?lYlS17IMHdwTMDIabIktIsreMKFa28IDwkZ2lcPOl3Iv/1matw9q0BnDgh?=
 =?iso-8859-1?Q?1HdYhlGr/NWjMTAojfQe4fERTgV3hnalquTj4xCQjgCn5P/004zUeG7vUp?=
 =?iso-8859-1?Q?3jK+epfFF00ckdfIYB1HcfQvVJQmY6UATNN8mBfZlQhOsBuwS3nGOTlvtw?=
 =?iso-8859-1?Q?bMZ/hMMcrtUp2WS2RJLwwlB2ZWp178Iy5VzMPkm69Ijv5hyUl16HlESe9N?=
 =?iso-8859-1?Q?2iR6BZzQZ31K7tZaTnbBCycQHcVCCar39I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f796b476-500c-4e46-e51b-08dbb4e7b150
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 05:59:01.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdbIPunpcCA/eunaukzZ3OieLzhd9R0Qoj+cZJKG5X/p66Ri9SW1FyRUBKFtNabH2MKe1UFGRiFYF7iDB+2hmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/13/ , Felix Kuehling wrote:
> On 2023-09-13 6:23, Lang Yu wrote:
> > On 09/12/ , Felix Kuehling wrote:
> > > On 2023-09-11 22:52, Lang Yu wrote:
> > > > On 09/11/ , Harish Kasiviswanathan wrote:
> > > > > Heavy-weight TLB flush is required after unmap on all GPUs for
> > > > > correctness and security.
> > > > > 
> > > > > Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> > > > > ---
> > > > >    drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
> > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > > > index b315311dfe2a..b9950074aee0 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > > > @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> > > > >    static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > > > >    {
> > > > > -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> > > > > -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > > > > +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
> > > > >    	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
> > > > >    	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > > > >    }
> > > > 1, If TLB_FLUSH_HEAVYWEIGHT is required after unmap on all GPUs
> > > > as described in commmit message, why we have this whitelist
> > > > instead of a blacklist?
> > > That was a bug that this patch is fixing. There were specific GPUs and
> > > firmware versions where the TLB flush after unmap was causing intermittent
> > > problems in specific tests. This should have always been a blacklist.
> > > 
> > > 
> > > > 2, kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is also called
> > > > in svm_range_unmap_from_gpus(). Why not add this whitelist there?
> > > There was a patch that used kfd_flush_tlb_after_unmap in the SVM code. But
> > > you reverted that patch, probably because it caused more problems than it
> > > solved. SVM really must flush TLBs the way it does because it is so tightly
> > > integrated with Linux's virtual memory management and because with XNACK,
> > > memory can be unmapped while GPU work is in progress without preemting
> > > queues (implicitly flushing TLBs and caches):
> > > 
> > > commit 515d7cebc2e2d2b4f0a276d26f3b790a83cdfe06
> > > Author: Lang Yu<Lang.Yu@amd.com>
> > > Date:   Wed Apr 20 10:24:31 2022 +0800
> > > 
> > >      Revert "drm/amdkfd: only allow heavy-weight TLB flush on some ASICs for SVM too"
> > >      This reverts commit 36bf93216ecbe399c40c5e0486f0f0e3a4afa69e.
> > >      It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
> > >      at the moment.
> > >      ./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest
> > >      Signed-off-by: Lang Yu<Lang.Yu@amd.com>
> > >      Reviewed-by: Philip Yang<Philip.Yang@amd.com>
> > >      Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> > > 
> > > Regards,
> > >    Felix
> > Yes, that's because kfd_flush_tlb_after_unmap() return false for Vega10(gfx901).
> > kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is called unconditionally in SVM
> > for ASICs > IP_VERSION(9, 0, 0) and works well.
> > 
> > So why not relax the condition to KFD_GC_VERSION(dev) > IP_VERSION(9, 0, 0) ?
> 
> That would reintroduce the same problem that this workaround was meant to
> fix. I don't remember all the details of this, as it was years ago. I
> believe it was an intermittent hang or VM fault that was somewhat difficult
> to reproduce and investigate. Maybe Eric remembers the details as he was
> working on this bug back then. However, it was a real issue, and we got an
> SDMA firmware fix for it on GFX IP 9.4.1 as you can see from the FW version
> check in kfd_flush_tlb_after_unmap.
> 
> I would not recommend reverting this workaround at the risk of reintroducing
> a known intermittent bug that affects stability.

Got it. Thank you!

Regards,
Lang

> Regards,
>   Felix
> 
> 
> 
> > 
> > Regards,
> > Lang
> > 
> > > > Regards,
> > > > Lang
> > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
