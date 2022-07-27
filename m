Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB3AC00144
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 01:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16B7B8668;
	Wed, 27 Jul 2022 01:04:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC7EB8659
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 01:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaFMC0gA5gCa0UwQgVNJ/6zy0ybGWu1tn9Ka3unheC03FeOMyy0GeMpfzAHf8yByg0cKx1hz0zpXcMRXt1uulWnPvejlXW9l1WsPxSoe/8fg7eKOgoHlELaNZrCK0RhijNhJlwIB2EBwsub/Z08c9bFXfHAJTOJCxj2l/U9unXMeCuXXivIk1P464p+zyFiFjRE3ow/MS4CruD/9hN2fHj4ezBHti1lwPO44FnUzkQb1YTFCSGrC0AXOB7uk1pe+T173sxnj2BSf8+OlnfG05b3qYHnhozL3jb2LFaf3wuj+AJcJv7aCeQQK9cUKE7iYhIQ4b0mrjYDQn/JUIA/H1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xz/XnfOmWLQ58PIgfh09UF0STZSapIlxlPpWI3YW+M=;
 b=hAWlNub8V+aF1cyUOJDcV+FHo2lCtMKIq+yWY76GLMrxJ9ikfZF7w1hKXk0t5JPTm9uxI+J5lP/AWYHwbrmmNpuYYLNprhD+rggUXHeR2wVfRXcLQf+F0++i06akmYRbr6r4aBbZqV3jHHHSo7Bcqu6GanrN7I5U2fJD/6/+5O78KgJ/TFJruGzBOv645MgyBg7ry1wS2rLUqhomHnZfaDs1KqAqU8X2cXQJcWRFhRA6wDTJJcLlbzkwHvN7tcabmCxuUVNNp6zsVTT69gX9Rk0+WmStU4zsJU1uZwXXyxoVjY7a4XnRA8QeyWpTyXZwQhJdffAF/a/mcP/5sCSsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xz/XnfOmWLQ58PIgfh09UF0STZSapIlxlPpWI3YW+M=;
 b=zhlJqSApAYT9Dw+vEP3ducdFpHcNhAuvYQ0SmoKBSLGrLPIznRxR5JJj3dzBA4StHghEaB7qHSvvBweaIInIZdt5t0mPXWlhUpeE7SvGP1veN2XT5XPtY0OQj5YzkXa7GDcRIc+mSsY+16gfOoCgudXRyt1x/j8GoMD0bQQxMuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.23; Wed, 27 Jul 2022 01:04:49 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09%7]) with mapi id 15.20.5458.019; Wed, 27 Jul 2022
 01:04:49 +0000
Date: Wed, 27 Jul 2022 09:04:38 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: fix kgd_mem memory leak when importing dmabuf
Message-ID: <YuCPJoVZadAh/a09@lang-desktop>
References: <20220726111513.2215655-1-Lang.Yu@amd.com>
 <007650e0-30e2-88c1-66fe-a942a481515f@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007650e0-30e2-88c1-66fe-a942a481515f@amd.com>
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b462109-37ff-46c4-d7cb-08da6f6c010d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtDij+7Mlr82yjvkeM7ENe+CNCmIooVwTTXl+vgv3mTp/+JsaSEPnaSEvFJvU5DYRQqiyhz/lzT84I5K51qEypU/2Nuuuy9jGAaDNIX5Szxtip4SpmdSahi8Tta9Ws1EdbSU9zicD/rtBpSERmVv+BziPPwicZuQ4Xg9Xq3sQ/2DWQOXOpnxa+G2iWeW9u9ROOwscQCIilv7qWc5xhoQibY/HKWQMi1RUNovRnHfuzOibGfmxMp8mshqBQjiPRBsMg79oyE5dP+ankzBeB/l9+HwOD6XPNGs2xSE2CaqMBG7vXcqaovotyoN193X06/0E/8nMDmNphDIRwZOVC3nzC7XdjndlLDQQXuQgo2V9TvXsI01r3HMb92nxk7u+FdSdQaebxM6Hq5P3EyUJdn0bE/2Z9NMpGRU/qBy28OdZ0yudaUG3EHeYBFLR3DxJPvk1ks8Jt9mUT1jr+bjSM4ttThTRFLKfapJmoSWrELK5zA4cpZJVmn/E26ny3OeuTAFt2xuQemtCPIqO9lIaTfN28FuWpWNq7+j//uK6Wh0Rz0NKbLRFYx7F/n3veusdWi7smNI6y5xeq+R2+qDO0TqGonbOfCt84h0eouDGEfLz9Go0aHeN/tvjlZmY8tJ0Zx8OsR2oBkYwVFtqJxhpcRna72imQSVIkNGZ5yxUUve7Alna7zQG4cfrZn3UkwMD8yPUmlAZCcBA7Y5mEg+orF6MHJF/CwGwySqZ3mIYmTk8q9Ey+7M8DJgJ3CKAWiei7oq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(38100700002)(6636002)(83380400001)(41300700001)(316002)(6506007)(6666004)(66556008)(5660300002)(66946007)(8936002)(6486002)(478600001)(8676002)(86362001)(2906002)(4326008)(186003)(6862004)(26005)(66476007)(9686003)(6512007)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sLZg6vmbYTwvgOwQABpTzC3TiOUrkNafjJrhPYDe7iCKN5b5R/ofL2BWEk?=
 =?iso-8859-1?Q?2O3clFH8YC6inxBCcN6TlMqdv7DfNNrenz3QaNBNBhEUXZ+bEROAooO2HI?=
 =?iso-8859-1?Q?QL6NMU0FLRLQTmCLiWJvlABN6raM0jCD+CvudnVhJOrda/xBWqdW+xfeKX?=
 =?iso-8859-1?Q?ZInTMBS36os4+rQplFjR80Wz0Igtdrhhquih8z99E8EKsk+xKGoXB6mPUw?=
 =?iso-8859-1?Q?SPpBVZzRngYSFcILn1+D2iUe1wxBUjWGGE9TEM8QOsKmOpyaUiFer6cUyj?=
 =?iso-8859-1?Q?FDwGaJMezW35juYcDZsTOU6uCICpibp4RcfFa5MktJEgirVyJ04p3xUBP9?=
 =?iso-8859-1?Q?QpZZtjv3TioqQA+bNgyMC8ND8LtuuhIcjQ9jgaZwA/xddRJ7a55oRsUykX?=
 =?iso-8859-1?Q?RjLngF1x9f1aJyNudM+ihKJfTI/OeJZgqIQAZjG49ZwuDQsd5Ggpv4JZ33?=
 =?iso-8859-1?Q?UB8/efBz146KVAaeRo7ENbpiB+o+sav7p/MkNRy7lo7vElr55lsT/O4vBO?=
 =?iso-8859-1?Q?ZeVcaobw2H8X37iz8eOk086FYjvH7Ml8SV0JEJENwsAFv9+yHRsja8GOeO?=
 =?iso-8859-1?Q?/Rc336N2CM+bvJF14Vf3XpW979cgTBDxxatk0Nnpgp5THtukmjFsnQ7apU?=
 =?iso-8859-1?Q?nzXXsd8nPJRxYL8vaDn8rhdMsuf8/mnLZfs/bwjohTHKv8Vux/Zu3sO438?=
 =?iso-8859-1?Q?WwQQeHZvRwHS6NkQ9CK2yikHdKD2RNk6yS40Vwz/0DfY3TSmFrKxgBUbbM?=
 =?iso-8859-1?Q?ujIWPt7bNSesOayUiRoYpXnpnsPvPeV0IatLyZDFp7VYVhcFzlIS+NdFUM?=
 =?iso-8859-1?Q?wIGcOS6dv/r0u/dlcI3VBz6sOKSKjSrrTlr/dtkza444b93EsMvUL91daa?=
 =?iso-8859-1?Q?8+nkjfGIJD3CJ42Bk2tLfAj0X4sQOAZqk314wsZ3sthZrXFut9CqYtJjqO?=
 =?iso-8859-1?Q?gma0eGUiLTti2wE18FeDcWFIHXSBuA9DGWrlXb/Rs+wNaeTeeNuXhV2wr7?=
 =?iso-8859-1?Q?vNgVqoQBZ6WzTptworzKxitOjFPj3Otb1f6R/IKrr9zW3E7kkg/ATfVCFl?=
 =?iso-8859-1?Q?BPJ1frLrfwDMyKBrVTxnv0fAee+VkvnspQ93WfoUjQLXiOdNefNHsumBAL?=
 =?iso-8859-1?Q?ykuHvA0+PzvFIzKbUhf/imYanWVF5D9MR3tCEMzgdBzpjT2cwTYw5T1LG5?=
 =?iso-8859-1?Q?MT5X6LcR3w3JwrR2pigkeCNiMY426x2TBFCzyQJAC4YYXUtmCqJMXQ/eX/?=
 =?iso-8859-1?Q?OA+mJxHx3PGtx4rayHgG0aaBEaty1qCCjPxZjTUz5j+21GPPhqPwLmWZpb?=
 =?iso-8859-1?Q?SVBBD1P80L5rSH4wAsiECSR7eDqNAApnfbnpB37IuKedzsrrMBg5HHBGJz?=
 =?iso-8859-1?Q?nhxQIOrRoVMDXJt0X/wZrVFxkdo+s7x85B3xtmcC7u+J3C4qsgQx0VRMcf?=
 =?iso-8859-1?Q?8ILHxLptZAH9h70V/vSopKBmyntEgVU1a5Xxn5GDH1oOxZJI3NX19hnkNP?=
 =?iso-8859-1?Q?m20I0qbPjjLoLr+LeFvQ0YJ9Iqrgt3s9itpKeFamtFMt2Vmo/W1of0qkol?=
 =?iso-8859-1?Q?wPCdbe3TrjnLOlvzaSB3IbOYjSwHjZJELsnpGC8he5dDDUb4MlI6n1onHP?=
 =?iso-8859-1?Q?0YqQK0cH+KOpipXMQJkojiUAHFm6ecvRZP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b462109-37ff-46c4-d7cb-08da6f6c010d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 01:04:49.3212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCX4szZJqgmFr+5Ya5n/qzKnNRvcHUrhN272J9APjUlGWBCxSY1JcUA75xUuEFXeRKvQzfnFJY/I/wFZ+zJ5Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/26/ , Felix Kuehling wrote:
> Am 2022-07-26 um 07:15 schrieb Lang Yu:
> > The kgd_mem memory allocated in amdgpu_amdkfd_gpuvm_import_dmabuf()
> > is not freed properly.
> > 
> > Explicitly free it in amdgpu_amdkfd_gpuvm_free_memory_of_gpu()
> > under condition "mem->bo->kfd_bo != mem".
> > 
> > Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> 
> Some suggestions inline to make the code more readable. Other than that, the
> patch is
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> 
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 6bba6961eee7..086bed40cf34 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1803,6 +1803,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >   		uint64_t *size)
> >   {
> >   	struct amdkfd_process_info *process_info = mem->process_info;
> > +	struct kgd_mem *tmp_mem = mem->bo->kfd_bo;
> 
> Right, you need this because using mem after drm_gem_object_put would be a
> potential use-after-free. Instead of saving this pointer with some obscure
> variable name, you could just save a bool with a more meaningful name. E.g.:
> 
> 	bool use_release_notifier = (mem->bo->kfd_bo == mem);
> 
> This way you have the entire condition in one place, and the variable name
> explains the meaning.

Got it. Thanks!

Regards,
Lang

> 
> >   	unsigned long bo_size = mem->bo->tbo.base.size;
> >   	struct kfd_mem_attachment *entry, *tmp;
> >   	struct bo_vm_reservation_context ctx;
> > @@ -1895,6 +1896,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >   	 */
> >   	drm_gem_object_put(&mem->bo->tbo.base);
> > +	/*
> > +	 * For kgd_mem allocated in amdgpu_amdkfd_gpuvm_import_dmabuf(),
> > +	 * explicitly free it here.
> > +	 */
> > +	if (mem != tmp_mem)
> 
> 	if (!use_release_notifier)
> 		kfree(mem);
> 
> Regards,
>   Felix
> 
> 
> > +		kfree(mem);
> > +
> >   	return ret;
> >   }
