Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C146C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 21:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E846510E1FF;
	Tue, 18 Jan 2022 21:50:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C299910E19F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 21:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPOnKguJ+luWAL9qt0uUV0pQM8XX2yT9vpUvfK2NRifONNBstPeHqAO5SPeyDe0IjAuUZvOpfL4RiUXNLsSvS4XYSszsyv8Yv4Ttz4V5dt+9rpnpGv3UbXRTYsfUGn6ZvwpZeoIf4o3rH71n6Q8nd4HGU/8TcWxEtsPji71wPvt0qmBAUtY6fH8lNbIcOHKkYdS6+cwHBLDHFP7dftbqjW3p4L8IH2R1557PtXL1YtbbzWUmgOMeLKJpniAZjAlhwpr9axwnSHRCi3A8QdIEctYerbPTDM0r86M32qg1hggxcEYUJYNGFiGp6IWVbh5IeocT4LzOp/S6V1Sf3OhQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5cyHuCelEUvWA4UzLhv++G1GZ/7xOuh42LmOG52zJk=;
 b=al6YhrpKhhDihVKBkOyyTe+OTSzpArualXDtZnKv7LC6Mr+/tesjfCq/g5hRdaNrbiOiL/xpQvk9Af6lbItLcNbtAuzLkGqGsyl/0rh9TH17FxpzA9U5pUESOAPrk5VPQqzDPiwLCIOjBJHlDAya0r2NdeCeh1lokZ1nJOcz55Z0aQdaUn2l+S+3ZWWjncniXit/PZ2fZhOG5c0hZ+X3CZvdqlHxrTt+v5Ym5sTfO74qRRI7QXwePcA4oKh3k+/xr14mUZ5Zaowwzy66VMMO88Vek6WXe3RyNnA7wUW5msMRw89LsMgf+jg3HoensGZDf3bYupTxwYjMCqA6ef3qkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5cyHuCelEUvWA4UzLhv++G1GZ/7xOuh42LmOG52zJk=;
 b=TsbjFm/74Ntp4XEMowSAV4BWYDFDSNijB0+TlIHz4r4QLS7RZEJXdEKXA/PDMMO+aiB6Cs86Ju3CDAh3TU+DCD/PyFe+zodgjGYR2wbtVllqnVpooUoDJAkyeFPDd6aKIEBkUI1Yx6bTe266GPlfplvPZzL1RlG6VPobiPyVMqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Tue, 18 Jan
 2022 21:50:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 21:50:35 +0000
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220118212808.23392-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ca5d88fd-c7a1-cc0f-b011-c31a59ef7ca8@amd.com>
Date: Tue, 18 Jan 2022 16:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220118212808.23392-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2246982b-b219-4da1-a3f1-08d9dacc8e44
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB17545231791A52E5876EC6D392589@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IClqzFg6LCpTXPEADAbPRsfCShc/fWvDkGwH/LRnJTL9TsZ3/x2enDilxEzkSAhHFWxb7QnyQ9iGVk7xKLo64gBMnbUmaJRvSeYHuQFpavvK0Qy25WSgijBd11PhGQcJcMTTXZruccH3H62pRttriCxnwmc/kZ+BTg1nd1tEC1jCuZ2CnItBKn1qCbBY1Ds8FwI6JoUhiSPlGZiHTTVP41IdtAUFJY78b0ZHh7r1PdHca505hGhed3i3KditnKUXpViAuKquk4ZqiAVHtFPsBcI+o0mhq1BY4OOzFnR9p1Ak3Rx9BoD719tV1vlKVjitKz2SunmDJQ/Gbkf1MRRONhIE+yl6cAs7ST1lxMwJaTMxo5zK6JjsTcTEBhXBYGfNU+STrnP6nD9UW2k0ziEbJV68ds4bWvkOvwckO+84Mt5ScPFi2FS0AOOm0sJ0/9uK4OUzTXVGzLdHLwsYiYsJZp8X10TOJPTJ9fBsw0DvTNKLJAd9yg1tlO3sTi6IMN6eQrVEbwqVv3aEFZ1Zmbk3bU/TJhdh/8xlGkxUj1/Yy/HZCLgQOjd6emrpDswYQt+QlNeJ2ZN+/FkVtfnSCfVrzvW+CjasxPozwyozpXGjJDRBmDelBrmfTLPqEiwpzea0U0eHpCQBqzg9zwRE4ZrPuACS37t+xfGdUQPvA7h7IH8Qr4nxD6n13bYLuVns7PdD2Rt3JgaUDBZwCsXKqO0cVWHHzBTvzDwBrX1JArAGlhDC7CZchH6q4CGpC96mDf8d5r2zTkNThEc3dPFtfjCdRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(31696002)(5660300002)(66946007)(66476007)(6512007)(6486002)(186003)(8936002)(44832011)(316002)(2906002)(66556008)(38100700002)(6666004)(83380400001)(2616005)(86362001)(6506007)(31686004)(508600001)(36756003)(26005)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVacnlyVzZlOVNNTXFFYlhBbk9aRmNZQi8yY3FQcE1PbmYvTzl3SUdtNEwv?=
 =?utf-8?B?UEY0TTltL3huU2ZCMWozSC91V2hscDNNL2pybXBiaHdzcXhmUXp4QTlNdy9u?=
 =?utf-8?B?dFUzMzF0bGpDNHV4TXdoZ0VhYXFDQUsyVGNsMm5JOVltNTlKTEo4R1FWdkJP?=
 =?utf-8?B?UGY5QjhhdWdGV24zZmZYajJBUStFVlVPRGxXTWQ3WE5kV1FPMHQxWlp3VHFt?=
 =?utf-8?B?dDJUSXk2UytRZnljcWxMSkhLRHpSVEpLOEU5TFA1YkxhTDRPM1lEMklvWGtI?=
 =?utf-8?B?Q3JPaE9oRzMwTkpLL1JUUDkvZ21Pc2pCSVhtU1JoK1o3V051ZmhwK2ZtQ21I?=
 =?utf-8?B?RnBINFUydks1b1ZaNGZaa0txcjZTT1g2VDUrckhGc1QydThWUlFlLzFNNGN2?=
 =?utf-8?B?T08wWFErbWZFcHE0L0FYNkwzMU04VHlVZGNER1JPOThwK3FWR3RsTzVxanVm?=
 =?utf-8?B?aTZSVFR3VmFtSXljOS85TCs0aVhXNFBJUUJEaXNicDhVUFNqdVZOa3phYUl5?=
 =?utf-8?B?OFRVY3pPYXZKam9tUGZ5MURYUEhtcGNRSkNzN2RXdFZySElNeWwxc3dJV0NS?=
 =?utf-8?B?a1lmbG55eEFkMTBGbmplZHVERVVMQWQ5aGd2NStaOFJmY3NUNUtPNWh3cDJj?=
 =?utf-8?B?VThJekR4Nlo4TUxZRWswc0dRQnVVclUxVXZlb0VGSEdkcXV2T0ZiWUEya1Fk?=
 =?utf-8?B?VEh1YlFNRnFqajVZQ1pVMytvQllYb0hFRWFIWlpTby95eTBOUm1zd0gvV0Jq?=
 =?utf-8?B?MUs5dytzQXpPUThxSjdtclNzdHNWck1DMi8wTFBsMUl5MlZnZTRVWk1jTGRN?=
 =?utf-8?B?RDR0aUI1UE9FaDhaY3pSZ2VHWk5uY09kWWhKekdmak1oYWxGcE5GbHhoUXNN?=
 =?utf-8?B?aWF0aGdwRWlOS05JdmY4QmZDb1FiSU1jNElQQ1dkMnZhY3VpejBzMkd3ck1P?=
 =?utf-8?B?YkRKYkRBaTVqMzhjdm11TE5CYWwwcjFFbUFGR2dITFpDTDNtSGVUUENmdURx?=
 =?utf-8?B?QTNQNUZubW9BVkxmZnM3N2xaNkJjSWljV3NsRGU4bkIxbkZZaW9IOXR5Q2dP?=
 =?utf-8?B?R0svdm9vaHFocTFOczhQRWxRbDZHL2t6NWYvWEErbXRmNys4VHUyOXI5VEgz?=
 =?utf-8?B?RlVrVW9uZ3RhbUgzVmMxcHB6N0JTclUvSTBvY1ozK3BlS0lPZWc5RTY2ck9Z?=
 =?utf-8?B?U2tnT3BHME1XVXFXMVZ5M2VQZHF3NjVWSjcvUEJ5ZmZsRTlscm9naHhmNjJa?=
 =?utf-8?B?ZW14L1NHMUdrM1MrK3p2TGtlTU9aUy90NVRscXNoMndoM1hiRW9lRUFDL2hx?=
 =?utf-8?B?WTNWbkFXeWFCNVRFWS9Za0Z1Tm9OM2hDYVlGdVFsVGdVUlkvT05KMkZrV3Q1?=
 =?utf-8?B?ckpUODY4RW9VdVNrK2xXeEk1VHBnUlVZb2JPYS9lVmkrZ1JkZ0MxZzV5c3N3?=
 =?utf-8?B?L2pTbUVPSFFyNVNqUkE1SXhGNk9YcVRMS1dHTld3aXhQQXk0a0RyWTZhVkNy?=
 =?utf-8?B?UHY5dnNSd2ZnanFyc2VDUzFPcC93eGx4SkxhL3VlR2d3QkJxM0ZuV2RtRWhJ?=
 =?utf-8?B?cEtKQ0hsMWhzRjdCTENJV0p0ZjhWMW9FVW9tOUpJZ3BGNmNpZXYvTThFc2JD?=
 =?utf-8?B?bC84SGxsODM5RDRzbVFPYkgzVUYzakE0bVpqZ2UwZ2VIQWlNbWRMU3BUWG81?=
 =?utf-8?B?VjNxbHV5bVRzS1hOazREVERwMWZMN1p2WHZjOUJ3cGcyQnpWQ1EwZUxtSFVU?=
 =?utf-8?B?b3RPVlFSS0IvcW14V25wL2VXak8wb21lZEYzbWxQVGxBZG0vOXZIWWkveEw0?=
 =?utf-8?B?TWxwUktiaUZUclAwcFczUWFXUk5Ed0JwRmc0S0RzSHZLRVNHZkFCc1QyRG5L?=
 =?utf-8?B?Q1lTT1FIczdvOGdweitSekNzUkZmbWRlWFpRTmFRbnJYR3VqbnZ4WThhc0Zv?=
 =?utf-8?B?MUJYTUZybHBzRFlVVzBjR2lOU3BoVUVRYTAvVFZORTRmMW1ydmFBZVpqZWNt?=
 =?utf-8?B?bzQweldMcDdRU3ZZZmN4RlNhRXR2S1VlT0gyd01LeFNrdkx2SDRVa2RubllQ?=
 =?utf-8?B?dXIxWDI3c0cvVVV0YTRrVXFmY1VBSkRBcklVbGtidHVkY0RkNTJ4SFE1ZnJy?=
 =?utf-8?B?T0xkaWVISDdDQ3dvaFFKTC93RFNCb3pia3ZlSjdJeWVkbHpSU0g2d2M3RW93?=
 =?utf-8?Q?EYIMFEamn1FWrmPDmoP0Yv8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2246982b-b219-4da1-a3f1-08d9dacc8e44
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:50:34.8119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4m098InZuwqeiVEoMCs+o97jAAiNsIicU7Rp3ipQVIl2486raNI/lg9W6gK5YND+Rmlh6bzwzwiCJUvpeKiqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-01-18 um 4:28 p.m. schrieb Eric Huang:
> SDMA FW fixes the hang issue for adding heavy-weight TLB
> flush on Arcturus, so we can enable it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 4 +++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a64cbbd943ba..f1fed0fc31d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1892,10 +1892,13 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>  				true);
>  	ret = unreserve_bo_and_vms(&ctx, false, false);
>  
> -	/* Only apply no TLB flush on Aldebaran to
> -	 * workaround regressions on other Asics.
> +	/* Only apply no TLB flush on Aldebaran and Arcturus
> +	 * to workaround regressions on other Asics.
>  	 */
> -	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> +	if (table_freed &&
> +	    (adev->asic_type != CHIP_ALDEBARAN) &&
> +	    (adev->asic_type != CHIP_ARCTURUS ||
> +	     adev->sdma.instance[0].fw_version < 18))
>  		*table_freed = true;

Can we move this check into the caller in kfd_chardev.c? That avoids
spreading around these conditions in several places.


>  
>  	goto out;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b570c0454ce9..0e4a76dca809 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1806,7 +1806,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  	}
>  	mutex_unlock(&p->mutex);
>  
> -	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> +	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	    (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> +	     dev->adev->sdma.instance[0].fw_version >= 18)) {

Maybe put this into a helper function that can be used here and in
kfd_ioctl_map_memory_to_gpu. I also saw this being duplicated in the
upcoming CRIU patches. And we may want to adopt this in the SVM code as
well. Having one common helper makes sure we'll keep the TLB flushing
strategy consistent everywhere. Something like:

    bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
    	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
    	      (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
    	       dev->adev->sdma.instance[0].fw_version >= 18);
    }

Regards,
  Felix


>  		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>  				(struct kgd_mem *) mem, true);
>  		if (err) {
