Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A048CA5535
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 10:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE8B10E496;
	Wed, 13 Sep 2023 10:24:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF57410E496
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 10:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNkNa0/bWoIHumIyWiFTR54cSmQXsSh135C2Zj041eMJNgHj4GZb3RBkHnNVPr0N3WIy01arUeIzYiHTLcoN6x+w9X0XlEJF6ExNwswCi7SItwMhX57pFmT5ZFz7Wkc3BnL5aZ32pJaWl+O82I/PFxbktJW6oSSAmMuVhihcxOYO/xMSXHQMZPdweyb+ilmyEm30eIhKGfCSm3kx+vOyXN+Y91gV089Z15nhHPb1h7GL/RAXM4OTFzU4vGo6LCtFWj8WkJDAZwnrI9OuZrmvP8Ws+jTI+HlNrtvaMl8/nn9woz6Qt6CNjk2EjU6Dm6lH+XNt3ewP5EOzhw1Ztn370w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH9dmDp7WhIs872He0s2eXTchuulN4o8/NvDhOsOkFE=;
 b=QUkR6AdG4XrI61o01GCnpNUxAoGB/Faa+3DYHJM5/0RqixM/amYydRBLkWJChL9b36Rv6TT7dX8Go/KUx3R/ndJvv/aFPVJcps1QBDdMSYRi8maznOnzrxZkrqZb3h5B9TXNcssIIeFaU07ARITiGyb6lO8VL/R55mQnKknzlTF5q0EfNSfgffFFEjcr2hGbzEQ3+WfjUK0qIwicoMeFRki+uFIaEqgfXRy4pW6XRbMJQVIOItZ7RXv6iwrvsh03/wcR3ewzk4hM5d40ARohUMRX/Y00EXbg7hixd5n5M4bSqvS9yKEt/tqPFBxrk/eruw8ePOY2u4eQoqtSd6eUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH9dmDp7WhIs872He0s2eXTchuulN4o8/NvDhOsOkFE=;
 b=A/0eoYx1/TMNQmd1WCRDSeWBfIu0RboJs99ypZg4TToB9hc/HFYWQwrDqkZU5Ief/Dp3aUG4JKmQcP9Pu0d+ZokbJayh1qn7QtJpl1rejo/GyRWz+qjRdn1q+abN7Ja4nuyNZ2RFU6PdeM5JgnH9bRksuKTtGc1mYOlXxpwEwMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 10:23:58 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 10:23:58 +0000
Date: Wed, 13 Sep 2023 18:23:48 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Message-ID: <ZQGNtOJsi4K914Oc@lang-desktop>
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
 <ZP/SdUd9am/f2WJw@lang-desktop>
 <c04dd9a3-ab81-5d5d-fafa-93877073017e@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c04dd9a3-ab81-5d5d-fafa-93877073017e@amd.com>
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|CH0PR12MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 22917ddf-d7df-4f44-2020-08dbb4438a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWQXH+eeklfxJSsg1+lZRaUdTASueKAokIgMoSTj9Jn/G6kr6vhLPH9EwzeV6h1hgMkpLLq3da/ORoxxHyvB0+LeOZv11WImDzf4qoohtgZgXJnJuNnoiv4aUtmBPmhRQA6DAvA0Eaec0Of9qeC75Dfe3P2cJC5m5MyhR118mYCO2lKM57r4Y1wxPPvlbJLP/mHOSvxzkai832B7cCeZNGGdhLHFHgOFJyIdRYpYzRlkk6enYunYV0JzS670f5IUJIylqTgqCp4IW0D7UbjJBRR+vHO91VvZLPEMYYk1sHJ7sj9K3Wa7j8HPRx67dbs5szk1JHkNOuwuH73KM2LVm/LTkblxbaprh31EW3+WA7dXKL162wlCKkDi9//pS995iLbl8/ekMYO3tIco9jR9CKN3/14eYU5AU5nZ769zS10v/tiWUSIQokfGOUTii0GZERbaPTKSsQS+g8pIULWIcwbiwt31b8nCsYKdeRgSr++R8Wk2JI6p1mFkSThHB8wmnXEWCGUe4W3VVlbgyN9EKnlDsYwxvPJtz+hSN9+8rN1KNtIU2qcoUv7SFnir/Kzu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(186009)(1800799009)(451199024)(6666004)(53546011)(6486002)(6506007)(9686003)(6512007)(83380400001)(478600001)(26005)(2906002)(33716001)(66476007)(66556008)(66946007)(316002)(5660300002)(6636002)(4326008)(6862004)(8936002)(8676002)(41300700001)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2ISOza7o03vXJ960U0KFFJLdzaKvZotKhKm3vEV9j4t4iDGGZc+xiiXSoX?=
 =?iso-8859-1?Q?nXuv/oq/t7vEfhacWT7uUHjFVRlYcTmF9zwEFGO5r9huljEN1q8Ye07dHo?=
 =?iso-8859-1?Q?DoN6JusrS4EyMc3brKRcZUTzUT+OiEDZ3cF4davaM2qz+Xa7vb0hjmKF4T?=
 =?iso-8859-1?Q?zST4r4CHHpUpcq1Vgza0S+vKjrP1du5YXbUVEYhybr2kJBsnhgUcyPk0+s?=
 =?iso-8859-1?Q?wFlT7zLR1m7HYQbw7ZpM0H8ABJHW6abfe+ld3ElghWVrEECIfgWBedVL0m?=
 =?iso-8859-1?Q?+q7Dk4J7nNex8VdSfZqco0E/ddApcm23RsjFPAmTg/58Lrmxtze5XjwekU?=
 =?iso-8859-1?Q?r+37+a7rmfn/cy157kp1+WogxDJZlFbFWEyFwQXUnliI7Xj6aUFVnV60VZ?=
 =?iso-8859-1?Q?pu0vgyjq4PH7JS+nNXcHDkkN0gXfHRKDGbO2EpM0HQmXYOBkpTJJySGA4N?=
 =?iso-8859-1?Q?OIUeDgDbqrXvt19yARbkxcHBZZ/WqqZvDZdI1BtxEnybDcxdysqe0poA1+?=
 =?iso-8859-1?Q?yydns+L8ZWevOGvUIPuvHJXa5BXH+eWucVf+XKpjojKNUpEMKznkowdtlH?=
 =?iso-8859-1?Q?AUGpJhNDR/EOquK59Ty3UYYfC7HGZtbeJqCf0rzp4mjp+sLCxylgY23ZvP?=
 =?iso-8859-1?Q?nSpt8QEkI4cgn+0MY1aLQPj/AyHZjOmnVyNJetfWflj992458beDVLEo1g?=
 =?iso-8859-1?Q?FCubtXwIDL+Kf97F60dLzGTeD/YRiiHIN7H98rNNulb/ZGMvdXvYQBh1fv?=
 =?iso-8859-1?Q?TQkqyC5MLuyKQVpziGb0dWycMr1cjOAH9FY7GxClxvvT+nkSR3Syh2vVAc?=
 =?iso-8859-1?Q?lDSU0QYiFTUygU4fURiCgZqfzGWBCkh5f61vs2vYj+1dFaQ7bKJeabWB/K?=
 =?iso-8859-1?Q?pDrVfSgi//d0fddP00RyEe6ZL1Rtt8PGHSanBQU438MXfx1ouhhcSG5Wmd?=
 =?iso-8859-1?Q?BtarUvc+HzjIcviiBBK3+X2mbQr+0TYnCi23v8ePnM9cN8reyks+e64ncL?=
 =?iso-8859-1?Q?zrdiybYcIVMcatwiHgafysyvgWBpxcsSQBhS+WhX7bBZVICjERormNQFKp?=
 =?iso-8859-1?Q?nGIRmu+wuHnhvRES3dr5qDi+R+UYaAmtNpIMEf0fe+5xKVy+3VbtTxWpj8?=
 =?iso-8859-1?Q?YsBooPuZSjWsACFwRSe/rQ2GU1Sx153Z6YfI7MJyIMRqoMl6HX5Ld+N5O3?=
 =?iso-8859-1?Q?GVjdL9s8SDhU2ZNmvCaiT89K6RqGrKIZ+9TxPQmEhPiJ6+MkCsgdf6FKHR?=
 =?iso-8859-1?Q?OKPHp96P8E1djuqpGMXHGlWS6XPP2J45iD7TMjHSOGHi0cpBnyUN8DioEM?=
 =?iso-8859-1?Q?Eq4w9MszwYtaR4Y5paijgNx7RBB0Ha9D0xPzhPA3uQpJWaIFbL4lEcu5Ye?=
 =?iso-8859-1?Q?1+YcLzwHFNiV/4vRn9P4cMvjlkAzf8UGMpwwvl+gKVZf0/bvj4ZiWcIqns?=
 =?iso-8859-1?Q?t+zBodbDXVKgrLR5xhQi7aaG2OK7zax/0JmsUz0GIOflKt7fiEezxe3zCK?=
 =?iso-8859-1?Q?mhwnvKzZZvtExMtUFJZmgqBnDKguxkzP7LZC5s1oM6lvPF64avB7KSGT3b?=
 =?iso-8859-1?Q?gOxpDDFm046GV4FtVpPEkKWEJW+qNkHe4Q6DQz/0Tj3ooVjX8JJ8zIIolS?=
 =?iso-8859-1?Q?Br7UDZicRnRJSTP7e62oMnwIECiJuQ3src?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22917ddf-d7df-4f44-2020-08dbb4438a30
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 10:23:57.9613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UN45Bf6zVecETN/qvUIUnjufH8J0XD8+oXGlyyX3JzA2puANQUm8RkOxctgIJ6ULkPUf5WjdqF5QaKeO4+idw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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

On 09/12/ , Felix Kuehling wrote:
> On 2023-09-11 22:52, Lang Yu wrote:
> > On 09/11/ , Harish Kasiviswanathan wrote:
> > > Heavy-weight TLB flush is required after unmap on all GPUs for
> > > correctness and security.
> > > 
> > > Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > index b315311dfe2a..b9950074aee0 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
> > >   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> > >   {
> > > -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> > > -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > > +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
> > >   	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
> > >   	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
> > >   }
> > 1, If TLB_FLUSH_HEAVYWEIGHT is required after unmap on all GPUs
> > as described in commmit message, why we have this whitelist
> > instead of a blacklist?
> 
> That was a bug that this patch is fixing. There were specific GPUs and
> firmware versions where the TLB flush after unmap was causing intermittent
> problems in specific tests. This should have always been a blacklist.
> 
> 
> > 
> > 2, kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is also called
> > in svm_range_unmap_from_gpus(). Why not add this whitelist there?
> 
> There was a patch that used kfd_flush_tlb_after_unmap in the SVM code. But
> you reverted that patch, probably because it caused more problems than it
> solved. SVM really must flush TLBs the way it does because it is so tightly
> integrated with Linux's virtual memory management and because with XNACK,
> memory can be unmapped while GPU work is in progress without preemting
> queues (implicitly flushing TLBs and caches):
> 
> commit 515d7cebc2e2d2b4f0a276d26f3b790a83cdfe06
> Author: Lang Yu<Lang.Yu@amd.com>
> Date:   Wed Apr 20 10:24:31 2022 +0800
> 
>     Revert "drm/amdkfd: only allow heavy-weight TLB flush on some ASICs for SVM too"
>     This reverts commit 36bf93216ecbe399c40c5e0486f0f0e3a4afa69e.
>     It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
>     at the moment.
>     ./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest
>     Signed-off-by: Lang Yu<Lang.Yu@amd.com>
>     Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>     Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> 
> Regards,
>   Felix

Yes, that's because kfd_flush_tlb_after_unmap() return false for Vega10(gfx901).
kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT) is called unconditionally in SVM
for ASICs > IP_VERSION(9, 0, 0) and works well.

So why not relax the condition to KFD_GC_VERSION(dev) > IP_VERSION(9, 0, 0) ?                                                                           

Regards,
Lang

> 
> > 
> > Regards,
> > Lang
> > 
> > > -- 
> > > 2.34.1
> > > 
