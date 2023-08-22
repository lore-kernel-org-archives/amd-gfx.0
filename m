Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B8EEE4996
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 11:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1436110E012;
	Tue, 22 Aug 2023 11:51:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E46C10E012
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 11:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXUY2ER9pigIgs7VXw/7HzdSqzd/xMyraitnXNV78bvnpkfXfTGJm0CXcyeX0BVoWz9XvX30djJDIbNDmNqBKncDApg3LCGPBDobWqHeIkFtfHl1O52AadOqyhawUKgpEGbqSqAsu4v6p47k8s6F/tU3Rs/Hy6cKJg7f3iLmEsE90QQtCOYUZslwj2nNWcyEIQKXJ25Fs5hKQKD2LGROqBHD6y6Xt9LIWaHtUlvVzUvpC8jaCWQQGTU4ycwNWORogHpbYi+bUPUPIsg9Kt+TeRu+B+aoCgT87kaYJY5XJyo3cfkznb9xuU8EPq7uGbeI/CLNK0oGlLJVVYsXOFKS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJnUTrYCQR/Ob+ToRXztLuoTugvO0vGIDWX2R+k8EZw=;
 b=EG29RrDhPSxyC4jy6IOkvDC7xZkuDDvIepRqQ05iIoLuROK+a2+FaOslwIGQwc3b0kZR4uoPzdO6v5xFig6TBozDr0tY4kj1rRajFu/Z6VbMe+1Qvj2z3TBDt2IfdzOMMQAa0wqZalWfTjp5yoTEHPNOlGnHPVg+xv38yusqXK8H1jJofnd6UJs0eLg4jmIZWYW5/A9Do4GHpY7QWXmxm8JFvd6xXgJQSl1XGdnhBmbKtv/N4RufbaNc2bXgkP2q9iiaK7el3zc1WRj/0DkML/IQgg83TMUZ7/jppn6w5o+ZtmS/WMdwp+uj8MOSm3n+wSp6REzWudAhEa21PLONzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJnUTrYCQR/Ob+ToRXztLuoTugvO0vGIDWX2R+k8EZw=;
 b=dPm47M222tBKRA+du9CzIrIaI6qgxYZEosqt0vHrqNAo4j0/4dJzvIB1/3HsukB2oPvMnkiMGoxlrno3i1W3pq2+kFyfAdJwsE3bq7lwchxj5v6aKAD2sv2zH6N3J6zXBZjqbU1SNfTlSCos7X2QUzS4cBp7/0kxodpIdQQM2uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 11:51:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 11:51:04 +0000
Message-ID: <2f0ac951-0825-6298-604d-90a5454b6e6e@amd.com>
Date: Tue, 22 Aug 2023 13:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] drm/amdgpu: Put page tables to GTT memory for APUs.
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230822061724.3917603-1-yifan1.zhang@amd.com>
 <20230822061724.3917603-2-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230822061724.3917603-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: f16882e8-53de-4d74-e744-08dba3060ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeZgennqWEUcTCNf4/nURy8elh19pLlWH3VNOs3hh2wpD2oCNgWIZt5A9FGqBQBTNlmM6L//v6tdZQerPgB18jLezPQjufpvZzoL4/s6OlQ2NzZpfDtlygnK+qDddAFWPfJNEAKpokktfY2kBdU2KuhnmXE9SZgahQeN7kL7TnSMEBhmodVXKsqTgE96DJ83zXL6+iBbfpBXBfNJDTHJbSIe+Xfk0Yo4DyC/GuiLty3ur8iZjnNJL72PBV/XODw3RjeQ1ZoMc5S/8djJfIdK1QFhMgDIfNbnEIZKInsOe16QrR0bZBIVS9mFQSou00/i7puubrY9WqgBOR9Sj+zD3D+naRyyuNYujqNPo7ZykWC03c7n+jCbUG38Tqwlg4guBo/yfq8lfHvJmlvQ+ldZaYznGQswnNM9prm+DGMPi9M5oKEPdqV/v+1r+qaochUPLIV/p39XAmJVgCRK5x48iD3O0MZkWzqu7Ya0sLGtgn/KDZOG7AtZ1C87owdZKmtjBG3PnCbzOojguhCtlAMVe710a5YYgvHZ9pOvUwP3PUXatXBkun25Fk26LoDQewUtoOKG4WyJDt/JzRJQSz++rtTE6D8Xi8FkIIGKDT/IKsvxSEq5uV5UukvvywRtwFbhJcnL6j+6covTK1i+qGAVqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdkakEwKzhCUHIvQVQvTDM3c2ZKcTVST0JULy90eTIwTUcwVUhob3BpZ3Mr?=
 =?utf-8?B?eHlYQkdLZzFxdzA3N3VLdHdPVm5GbnFySlNWSnN3eGRzNW1TZHgxWlQ5R2gy?=
 =?utf-8?B?QVFJQVB6cWo2UmJWMEk3TVVPQnRMY1JnVnRYRWxTSnc4NW5EL2VFV21ONmln?=
 =?utf-8?B?UTJrOFpvNkR6TGYzSCtETzExTkJjNXhxa3RETUVnY3o5Nk5BSDJ2N2JKZVN0?=
 =?utf-8?B?REdyam53amFobmdTemlTMFoxSnVhSkNVbmdWZ1pGa1M0WHVESFFKbFpiK0FB?=
 =?utf-8?B?S0t2YzhBc0U2UkZmN3ptTkpXWlVqYzdiekxxT1R5ZHp2SjdZclFKK3JBV0hm?=
 =?utf-8?B?dHU0Q1VOVEJ5ZVh4U2tBRzdpYzNhWVNUSHMvMDlRYUloaDl4YnZjY3BaUmRa?=
 =?utf-8?B?c25zMk5TRmRFTTNNNzhlVjQ3RlBYbFZ2dGc4Q1k2UWFFb1R5UFBUei9WbHZ0?=
 =?utf-8?B?ZGVLdGorMU03TmtXamd4MjlKMzZPNzRGSjVSemloaE45bENZUmxSV24vRVhK?=
 =?utf-8?B?cElvdHIrSmU2NFJNRzVwalQ1bGx5TFN0MHNuMVhaQzF4SW1Zckw2bU9uUC83?=
 =?utf-8?B?RkwxUDJEN2xjdmFZV2Z0bSs1ek0zVEg2WG0vRUlSWTN4MWR5MVhISDZVRDJ6?=
 =?utf-8?B?SWF6V21FWmJXSE5tYUNmMnVIVEJIK096aU1UVDd5RHJTbUJzdmx2dFVUczhw?=
 =?utf-8?B?akdCSXlLVUtrNWJlQXphUGRUdzUzL2p1aklDNHEyU0wwTEdJT1RRMHJoMldk?=
 =?utf-8?B?Rmh1bCthWDJuUnJPbWs2NmU0WTUzSjFkN3Q3WlNadldGSytLU2FsY2NLTXBH?=
 =?utf-8?B?M3RTK3VuV0E4QzhJS21hdEdQNDB6N29MT0RLZXRrZnJTdWdXK256SXU3TC9H?=
 =?utf-8?B?aC9IL2NxaTNzcktncDhlSlJDSHgrTzBZWDJVdXBheC9ZWk9UaEd1dWo0V0Vo?=
 =?utf-8?B?RVFTbUlBWWx6MGJHVWtkTERiRW9OQitSeTM5V25YQmdrZVhzWG5sK1FsWm9J?=
 =?utf-8?B?b2FFOW5BMktZcG15UzNSVWxYWTlsc3VqeExGQVQ2c3ZuMlIzTVNTTjhBMzRE?=
 =?utf-8?B?UVhsK09XaUxPMkZneTdtYTRiQXEzdzduTE1lUm0vbFdXeVlOa0RVM0ovMDNk?=
 =?utf-8?B?UGtXL01RYXNueGZDb1JrS0NFanVFTGZhdnVGTWFOdlY2cUZybzZENSt1OGlZ?=
 =?utf-8?B?aWIxSVVmdUN4empsajFoc0d0dkROandKT0V1Y0p1NE9vVW94dzhKV1huVEg4?=
 =?utf-8?B?VEdQaW1sRHM1NFd2SWRqRkI1bnNMRDIrRTZtWXN1M2h6VGNmTHRreDM4RWVt?=
 =?utf-8?B?NU9qK2VUekozRTNuRjAydGRwWUN5aGpxUSt3Y0pNRmdwc1VhUS80bW1uYWtr?=
 =?utf-8?B?ZlBGU01VMzRPQk5LbC9udXBNd1hMRGlDOEF4NHNPRk14QksvWnNpV3EzMCtB?=
 =?utf-8?B?ZTRCdzNnckZtU3BXVi9LVnF1TDZHS2VzZUI5SXNScVZsamt6dWpiL1pETWhT?=
 =?utf-8?B?U1FoVXhDczVOVHhEY0duYXFJQTBSeW5YREs1SENpUzF3QkxCTjVEZnEwdFhZ?=
 =?utf-8?B?WTRmdTV1OUdSVzdBQW5jdEwrMGNPTDBucC9VanpmY2JjK1N6ZVd0eTNsMzlZ?=
 =?utf-8?B?TVFmK3BhK3dnM3Ayc3hXbW8zdlpic0ZsZFFvNVB6ZGhYQmsxdVFGY3NQZ1JY?=
 =?utf-8?B?UFlyWkNwZzV0Mmx4R01xZENhTnlhSng1WExOeUhXYjZqZWpMeHJsSmdVcHY0?=
 =?utf-8?B?bk5WRHM4K0tWMTcyeHF6WVU1UEFHdzBISmZpMUx1ZDdmZGRKU1IyS2V1N2VQ?=
 =?utf-8?B?dnhvWjFwZGM1SlFCUDVDMUNGU1U5S2FBVmtSbnl6Mm41ZGV4RWdZQUhtZG1j?=
 =?utf-8?B?bVV3TkRUbExETlhURGs5cnRkNXVZMmI4bXBQRFg1L1NWVDdmRWtUcTUyQkRl?=
 =?utf-8?B?ZFlsTFJUOGJSTjBxaCs1RjFvUWMvNklCa2t1Y3dXMXd4NmNocXNISnp1aWZJ?=
 =?utf-8?B?b09wNnA3Q0YvRlV6aWFEYnhrdXZUU3JmUHgzRXZiZXRDcy9jUHlHWHk0Y0NZ?=
 =?utf-8?B?MTViV3hNYzA4Y3hxbUt5ZTl3WTlRRmhIdGtpdmtDcE5FM01xS3dNZkVPZWlM?=
 =?utf-8?Q?Uy6ysxSWnzXVxst1BIweVzZXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16882e8-53de-4d74-e744-08dba3060ffe
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 11:51:03.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YCH1g8hd1xYQvQepF5etJtBN3UIZS4MQljDJqlL1PPtfJkS8hJzkloh6NZuuwdO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.08.23 um 08:17 schrieb Yifan Zhang:
> To decrease VRAM pressure for APUs, put page tables to
> GTT domain.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..26063e611c49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -515,7 +515,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bp.size = amdgpu_vm_pt_size(adev, level);
>   	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>   
> -	if (!adev->gmc.is_app_apu)
> +	if (!(adev->gmc.is_app_apu || (adev->flags & AMD_IS_APU)))

I've tried this before and it doesn't work in quite a bunch of 
configurations. Especially IOMMU has big problems with that.

Alex do you know which hw generation finally supported that without 
problems?

Regards,
Christian.

>   		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	else
>   		bp.domain = AMDGPU_GEM_DOMAIN_GTT;

