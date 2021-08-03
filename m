Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3BAC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 16:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B42160F70
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 16:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B42160F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F57089DFA;
	Tue,  3 Aug 2021 16:11:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786F689DFA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 16:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZT2d7pyy762xbPGMPAMwfXM0C2ozOWgqHdIQiYzS7KL/uJDgwOPkqhxzRWrYcqLxL29jx9eoGXgc3u4mgnE47rlJYPWFy+RX5Y2KVbXkNgERjDQ4z/hxJ50xq6L/2nyPIOdq0bfvZOCxT4URJRLDIUDGKKdsfNOrjwp5/Tv5rxU5C8kmsEXqeHzkGKh+PFt/Ylr9lNUWoHHDqTCGFt0fms7TlNh03GmfKSCEu6HpIhR2DbF0E4Qc99rr0nUdAO22R1OtB5DPGFN6sUaq1iadaWYGNRrilGOGxg/pVCiZcxaGvSODGVTkg5us+cT6eMe834IerHj+9wB0I4rianIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/7NP6B4qjA4KZan7+FN9FH+y1dzjlllbvZFbSwMnCo=;
 b=Jl34PFcz9pl0OL8h+O6ygV7Vd0t6xI6pKdD4QM9AhAs/3rs5xz52pKRI1vK9edL8RcqHpdjbsM9p65QWO9NSoQnOpqOh06MZOz9dXLk4TVupd4WbIvo77TefmHTOXCUbpoCasmH4v613/EvLLBh3wqjK5tnjG+3gbRjAAX2qdELwGT/kjM0YgEzKXHR/ZSfD+6zk2v2vyhtdADCRg7fFZTa35MV0mudWiBV9w2o+nCddBGfzjuIYipGV23GQBZl/Vmb0dTnIdNdNukMzADePYr9OWcTBdvxpRYzzNXKJHo9PFZsXyASm7/E0XEnEkiJkKP8ZQyTg6smMuGIkcd+v/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/7NP6B4qjA4KZan7+FN9FH+y1dzjlllbvZFbSwMnCo=;
 b=4ZNRnk1A2BGIBtPPBoKwndxirAPzHQWPS2gVz/le1AjX38MbVRjTyVLfGzkS6AxHLkBEmWKdrHS27OKyw3L8Nj4V52fvLdukWZ0qZnuyR9uM2XWjIJHBRoad4spm9VyJkjlGefaZIY5ja/qVwN1ZdzfC2y5R/aA09dpO975EMFY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 16:11:11 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Tue, 3 Aug 2021
 16:11:10 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix fdinfo race with process exit
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210730021321.7953-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <62ce2ca5-7ef5-e334-a7e3-d715336cd37d@amd.com>
Date: Tue, 3 Aug 2021 12:11:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210730021321.7953-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend
 Transport; Tue, 3 Aug 2021 16:11:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9c81a2a-39cb-41fb-d4d5-08d956994f0b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5353D08CD756BD4B394B327592F09@BN9PR12MB5353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CaGiCEusZARtMnRTlpr3Pt+N5O5k8bfaMshw7lhOCR9MXtxQlFHD5WE2msZkBs2wk/eAhXvT9CQzHSFDm/ssXkkENXDR8umrNFbcB5TOuDs5CSBe+nKRdwFFnahSuc968fUlDCMDc33Q12n6FbUaBIHmJoQ3dd3zJUpfwX/1FAWBAfSOQFJIHfGMgJeVzt1T+kVjIBDQQXJCx0twa2MVZraBLHiUVZfFZ84RKJqzCkiMsSdoT4tKmj3Gk8iJqHSdHJEtaTD0QHeLx9vJfUtQvIge1601ZlSO4GFgFM8NNU3DYw5A12OaLWgJQFlyHFP5nkRSn5nQ/0snraLNNo39EeXma7NRAXKIv3PnHxLcPOvf4LiI7wk/woV2XPbukBAZJqGoZuj4pauWXFue0HfrrAzqPdxVr0aarAc38K9cqXRv/64Oova1H2f1y0cs7iksu4QkTICdyqTf8x1nwMMhb66e2RDt5p1+1NXS0jXwwIR84iWKu0vqtO8dacwc3+/N04EUExPR1JoanjmC1E6WgvjzyMAp4IN2d2ojaUUhAQX6arX3kTcl2EtB5R8tec0XQ9C/0GwBhkGPCvwh0vr5xCyJUffohOgdXlB2/LIV3LYxUmJoAmoW7RT9PnGLn4R36H79bPif8pHtjZk7vLvlMpx69BSbfCKaN2mz3RTNDSuE4PIwhQ7OFna7tuQu/U0xRMl30SjHOUdaEccPH+JlMku51C7PFDFi144jjFkFhwQkXQzFth92/6DoYZlZKfL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(956004)(2906002)(8676002)(6486002)(38100700002)(186003)(5660300002)(31686004)(26005)(83380400001)(66946007)(66476007)(66556008)(86362001)(36756003)(316002)(44832011)(508600001)(16576012)(8936002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhhOHBCYkwxNkp2L0U2d2I1SW50OUlLWTBHMkEzN3BXQm8rVzNCRVhIY1dm?=
 =?utf-8?B?NURRNUJjVm5PQTkrNDNHTjJDL3BFMWZUbjZ1YnU4NmE3MnNhc0ZDVFVHaEw4?=
 =?utf-8?B?endSeXdZWEthWGowNlVLdmpTWWsvYmlBRFFHSWxIU2FyczdEUUZkdkExa280?=
 =?utf-8?B?ZDlMTExLYzlqL0ZjTnQxY0JhOHFkZEwxYmNYMGczQnZWd2gwdGFsMjBycDhE?=
 =?utf-8?B?SFVSd0xMN2xzVzRDVUpTaDRRRXF0eTVNUkpnQnEzQWl1emlvNVRhTisxR25D?=
 =?utf-8?B?Zzd6cVZ2SmZvYkplWHRZdTdSRytGQVNmS2NqL0JIMElwMzN1NE16SjJ4T1JX?=
 =?utf-8?B?aGxGTTJjV3JRZVEwZlBXdUpRODBpUGRFWWh0UlM0ZkpZMzFST09zNWw5Ukxv?=
 =?utf-8?B?OXZmOGZXVERCUmVzOE4xSTBrODh2YnY5ZEx2cWtZM0VoOCtCK25WRDFkeUsx?=
 =?utf-8?B?OHVXNS9RN2w2Uk03aXRIdDRiMzlxdlFjWVF5OEYvTXdtdjRyT2JjYzVjR1Q5?=
 =?utf-8?B?b1p3VDRJaWk1cUR5TnJiY3drcFlyL1N5SkRsZlk4Mk1OUW1XZE4wTHZVVVFM?=
 =?utf-8?B?ZUZIcjlSUDU0M2RieWhqZXFjMDU0dkFWeXlGSWs1TnVUY1FRc1V2TG1mQVdM?=
 =?utf-8?B?VkhPM1VWVGI2OGpjSFI4RWh3LzdjeWNnUUJaKzJhMlpjeitmTG9aWTRiS25X?=
 =?utf-8?B?ZGdsanRlQW00VUlDTkcyQVdOWTQ0MnZHU2d3bWgzdGxjVlVYMWloRWRBcWpL?=
 =?utf-8?B?Q2pySWJmTXUwejR6SkpvSHRUSVd3UnoxWlIyUmtOc3M3cllnRmE1UXd1OU1U?=
 =?utf-8?B?UmJBY084dTErV1ZyQzdNOG15VVZYOXN2eUt0Wktid29CNjV3eTFOL1lEakp0?=
 =?utf-8?B?aGI5Q1VmMzd5VVl3a09VRlh1MnVieTk3VGd5T2NuNExUTUxucFI5V3ZrMTVG?=
 =?utf-8?B?ZG9CMDNkRG5HbktEbk9sUWczdUN6QWs1RnZIOWJUZEZHZkVkL1dtbW13ZWhz?=
 =?utf-8?B?cVEvK3Z5OFNSNVNsMUs3ckJJR1ZWa1Q0MWFKMUNsWU5tZGxJQXdCWkpqWVEz?=
 =?utf-8?B?TVl5NGs3Nk1vVXhFTENrdi9JRXpmSUI4ZHZuajhHcFJGckFpOVVRYVRPSVlG?=
 =?utf-8?B?T2FwV0IwMkMzNzhUZ2JNdjRjTk11c0JJV1VXZTBYTzJOaTB0ZUtKQzR5UmY2?=
 =?utf-8?B?R21HSE9Oc3pOQmhUN0ltdkNsUkd0Z29wdG4yaVM4M1VjL0dHRC9QR1VQeVVJ?=
 =?utf-8?B?OU9VeXRZV3JDM05XZndQeGZGTzgwUEJFN0tsWFVhSzRnazBHL3hWUTNkeXdO?=
 =?utf-8?B?djZ5R09WeFMyR0JNbFhLckQ3V1VYOTBwbTdhUDNqSW5NbnJhanBhbWZnbVJ3?=
 =?utf-8?B?bnQzVmxrSnBpeGJBRjZDcW9xVnYrZDBzKyszeWVJVmJVN3pyVU9RWitWM3ky?=
 =?utf-8?B?Ylk2M2luVkszT0QrNmUrMEsxUHU3NjJSWjIzWTJaendzN3grbVE5ak43UlIy?=
 =?utf-8?B?M2llQTZRcXgvZWhSWlR4ajJOVkx4anMzc1FqSk5pNDJpUDVtYW1wNTM2eW9s?=
 =?utf-8?B?R2hLcTFwMGlpOSthNU5YeEgwdzQ0Q3l2YmpFSGJ6SGQ2K3pwelZtZEd5Yk5F?=
 =?utf-8?B?clRjbGJMdm5LRTN3UWpxeU9Kcks1MlRrVExPZzRUeS92VmxpOTJoNmg3Nndq?=
 =?utf-8?B?bXZvSFljZXZTZzNWVW14cHBmem1nRndaaWkyY0VBT1lmT2JXNGREQ0hSNVQv?=
 =?utf-8?Q?vpep37o6rHMEn1ycRMdJ3L6xV0OHIbr7Ih5OvWI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c81a2a-39cb-41fb-d4d5-08d956994f0b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 16:11:10.7220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFSgrDt8Vm9X/dh2eaKfPGxDoZwYBrH6N6n+fCC6ySZsA1ylEuI6H3kOfhU/8JxKwCgr2JHaozRWBRxd42Bvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
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

Am 2021-07-29 um 10:13 p.m. schrieb Philip Yang:
> Get process vm root BO ref in case process is exiting and root BO is
> freed, to avoid NULL pointer dereference backtrace:
>
> BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000000
> Call Trace:
> amdgpu_show_fdinfo+0xfe/0x2a0 [amdgpu]
> seq_show+0x12c/0x180
> seq_read+0x153/0x410
> vfs_read+0x91/0x140[ 3427.206183]  ksys_read+0x4f/0xb0
> do_syscall_64+0x5b/0x1a0
> entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> v2: rebase to staging
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index d94c5419ec25..5a6857c44bb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -59,6 +59,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>  	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>  	struct drm_file *file = f->private_data;
>  	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +	struct amdgpu_bo *root;
>  	int ret;
>  
>  	ret = amdgpu_file_to_fpriv(f, &fpriv);
> @@ -69,13 +70,19 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>  	dev = PCI_SLOT(adev->pdev->devfn);
>  	fn = PCI_FUNC(adev->pdev->devfn);
>  
> -	ret = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
> +	root = amdgpu_bo_ref(fpriv->vm.root.bo);
> +	if (!root)
> +		return;
> +
> +	ret = amdgpu_bo_reserve(root, false);
>  	if (ret) {
>  		DRM_ERROR("Fail to reserve bo\n");
>  		return;
>  	}
>  	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
> -	amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +
>  	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
>  			dev, fn, fpriv->vm.pasid);
>  	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
