Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A461C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 07:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C9610E47F;
	Mon, 13 Mar 2023 07:38:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7978910E47F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 07:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiuHd1L7CzXLoqx/CF4muVSnkALe+YtTAL69CZdGNKl9AP8kXirxrIIfJ3TnKhADMml7mvPSOmXT6Ur1/bXqhIJPm3/woLJANgY1x3HVx5IscwvcpvEcg6bf3R9HuQxMf3HZ5YCF4m5j77uZZP0l67UFNXIQgGe4M0wWGLmSzTRJutaF5lxDU7EFy1PlKyAjf8COgiHBREjyVxiIT7cufAbAJtnsAhq9XhF2lJQ9gN8XnLLST9Tz0M0MEp1ebKwuu0YaU1PXELjgelpkHrBziBAVljp6gMSANs+oAFeATlZ6cu565cSOXDRjqCv6FD49i98ZilNbPXx65z2E4/NZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vgaTB85ws81HckfBUo7OOS+1/7OWLK5IaUTKPmYFHg=;
 b=lgjXBq0GSEUwrKO9VtsFVpMZwhJhQWtTQqZtjYIbd6m/WlkTk4DJKFwNJrAHIASNR4CevMUm8Cu7OjSMFosM30/xbwBmJIBTO3gbDbPmEjTJwljSyBtKyW2veC9PSdHSh70qHos8RVoI4M1HMHctfHSpvQomNLK5gknSXgYax1fSYd/SLw9rWe/c2rukdTezOsj/7DqoTf+KLiwf6DqKeJ1onf5IK/xppumuJ6hpF4bWOH08JYj7/e2pyUTkvMV4zyxdcRo7LCR3kKSIuNNgByr+0Lm/67dnLCToap1ugtGhQMokr2SeLRTtQv52wH9NWKFu+9DbeLmS6zJA1oRX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vgaTB85ws81HckfBUo7OOS+1/7OWLK5IaUTKPmYFHg=;
 b=nqQvgv8/mLc/HKnYmy+UEIKpQt3b7O6aBEdGfP1eD8FPOrh69IiLPtXxq+KIEWh4LL2X9SNUdzzktdcYb5bsXS2+g5tiOa7jaZg2vMXjbtFT8Q52pV/52QRc/lcRQpi76sbaK+pK3aPP8jq1/mUpoFJP0YczMPA3FStIHGPxapc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 07:38:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 07:38:46 +0000
Message-ID: <469424bb-76bd-4cdf-adc0-89308c8540c0@amd.com>
Date: Mon, 13 Mar 2023 08:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: Dummy CS for VM sync of compute VMs
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
 <20230310221613.1647188-2-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230310221613.1647188-2-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: d377f16d-c551-467a-9528-08db2395fab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+GrAPGxfHNoEYHLJP57KidgrvnjgMC/LtX/FCF9k4LxYxnaqAr6TeZ8R/yzr8RUwOKYz3TkBAbK+nSF+YdLpMEe5IexnxvoTSlwHxNMqoG/XLoN0kC908mSh5ZREc+Oa/nI4Z1BENna+ugCa9yt4wh76JbQnNTgoH+XDyMBJ8ibXwHCRP+WtfBm6bKpIppY6T/2Wg2XM30bU3qTfS6nQqWLe+DbliYQTvQ/TR0c3+a/HBoWQqTB/sMkGbmmqcUEoM5McokAHO6aAlrEbY/oljqrWWFvt1X8Rfxi2hWW0xxwFrJ5iRXB79oYaE3TOjDEZ2qeBa70FCxPenRnRl7iYH4yAl3mPDJXyzHtUcqPE1nJUgJ/YVONI4PSOJe5L4Go04tj3BDs81grL8trJXpg0Q5dv5drhAWk/d6wZVbwuzYsglbuud0HuY0/zIcZuaNe2GHYl92ywF2dYcefIkky0R0W81JcKSycKeWU2bl4bcvBPD9e9gpuj/3LGWcY18Gx90XxKDNBP31mCZEX5I7P5hvlwoxUR38Sa2g10C55O987w9J8KgFLD2EmSg39s3GexVSOFGHZBD3siqYjcPwpsg60rKLjRWyHpqYtxQOGIU3wdYXoy06YTzrxQ0dV10ZpFHqUohUT8w0xceC+IZR3b5S3QreayVNneWwT9PeHwDpuXWl0hbDNvmTCpzll68QNqoBDaf+wInMZGnaJI+PXB6cQ4DlQMJTuq3HHxuDFYiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(31686004)(4326008)(5660300002)(8936002)(2616005)(41300700001)(186003)(26005)(6506007)(31696002)(36756003)(86362001)(6512007)(83380400001)(2906002)(66946007)(6666004)(66556008)(66476007)(8676002)(6486002)(316002)(478600001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhDbmVSM25qcTFhVEkyUEt0bkNGRjViK3NyVGxJVjJsbHVMbm1Hd1liUVZP?=
 =?utf-8?B?NEFBWXJFQTBqc04rUE5GcHliUk03L09mSXNxajd0dlNja1gzL0pEZzZySUN6?=
 =?utf-8?B?d3l6dCs5R1JoWDFrcXMrT1huajZudGtxVXdhTjNmSTJqbmNSazF2ZGJXcnQw?=
 =?utf-8?B?M3FnUDRySDArdDlXN2lKV3BhTzVtSFZOeE9iSFozUGVjYnlVWGphSDhEdWhS?=
 =?utf-8?B?UzBRb0NLMnB5MlpGOVExc3MzSVJtM1BFNjJkc3hSTkxKVkpFMTZHckJLdEp4?=
 =?utf-8?B?bHkybkxHeXF1QXYzejhuemx5cUU2RzNjdG9lVnUxUEJiUXpWKzJya0w5SDVv?=
 =?utf-8?B?V1NyLzNHVlYzR2FuSTB6eTRWVXBVRSs3YzBnNWU4Y2RRb1BKdW5DVFZsVDVJ?=
 =?utf-8?B?QlUrVktOb3VPVm1JY0xIYVA0c09JYUtGZmRpaTM5Q3hoODVucWVYbGlLL0hk?=
 =?utf-8?B?RzY0eS82LzJzc3NCRzk2NUVrODNOd25pN2FPZUJzUm5WOHJaS3MrY0tVTE9G?=
 =?utf-8?B?U2pma1E1aVltbFcxeHpWTHY4VmVSUzJuRXdUYVhLWk1paURsdGpNTWdpMW9i?=
 =?utf-8?B?MSs4SXJmT283cVpNRDVUQXBteXZ4d0VxU1pOZzFRMnpuczMzTVo0cE5PS1hE?=
 =?utf-8?B?di95LzYwdmJ5eVAxYXVtMmkxdnlxSFZIV3VnSk4xcWxmeU9Vbis0OWpLRjBX?=
 =?utf-8?B?bVo4MTB6MWhFbUprWVZ3YVdyS1ZPa0hmZ0pOL2hrZEFpL3M2MVBNQTVwc2lU?=
 =?utf-8?B?VjMzbDE1Z3RUS0VIeXR5YkdZTS9vNXkvWmpmTXNGbFVVVDQ0ZlpSdUZMdlAw?=
 =?utf-8?B?RjIxVnBwUElOZ2NnTmgybmthNE91dkxPRXhjV3ZHY3BMRUUyeTliZVY2TkQ2?=
 =?utf-8?B?MVl4S3NhaGlPRXN6VE51MDJpam5PeVlwa0RFWlUwK1pKRzVHNHo2dHdKOXpH?=
 =?utf-8?B?R1ZzbEJ5ampnOXAzcFl2U1JWQktvVU5MY1BKTnc4elZTRzFHSUE1TUtpS0dH?=
 =?utf-8?B?VytrMExzVG1OV1pMUGFKODB0STVycDg1ZldSY0J0dUV1QWhzRWVxZ1FtK2JZ?=
 =?utf-8?B?VHJzY3pWUXBVdjdudGVwcW9vYWFDSXNycGV0MXoxRUJsMEJzaWwxNkxpNXBo?=
 =?utf-8?B?Q2xwSDdhaHFFM09UTGpKVk5xOTNFY05ER1JTc2h2c0tzZTZqZGIxQnRZb0VB?=
 =?utf-8?B?TlBnUkxHMTZMdFgwc0pjWkxpWVV4M3QwNDJGUXIrVmdpVFJHQkdFWWMyVHhv?=
 =?utf-8?B?L2R1VkU2QVFZSU9VdDVmdjRIWEpxVVc0OGlyTkIxbWduRFQycGpROFpaRFQx?=
 =?utf-8?B?UVJaTS80U3FsTmtCZVNyVkYzejB5QXJpWE9xMVF6S3FrMjUzdnNHY204Umli?=
 =?utf-8?B?YWFDR1lxaDZMdVJxRDdNaWJmblRMZ2U2dFl5bGxkR3I3Wmw4bC9nbWZWaHhh?=
 =?utf-8?B?YUdGQkdkSkVPNnB6R3RoV2NwSFVzVDhCL003MUlTMlpDS0xiVG80bWxnUGNL?=
 =?utf-8?B?T29zUGd6NGNzaXJJeFF2N0RmUnluVnVxMjc0Z0N3VWxHSlVSWnU4N0VJZXlw?=
 =?utf-8?B?TkJUK2QrY2NKNkEzWGpNMkNIVVZZZVluNHVFQXg4bDJDR3VTY3BwSWE2UWZL?=
 =?utf-8?B?K3J2bHd6Zld0M2lWTTZ1RFRXRE82YUYwOWZRQ0pqOEl1blArVS9OQlYvZHkz?=
 =?utf-8?B?L0pMMGJBL3d3QVdRUnd2dmJUd2tyNk55SDZTdS95eTY1R21wVm9oOUphWFlG?=
 =?utf-8?B?bDlFaGw0Y3pOL2Vmb2tteUIreTluSFptOWFhNVR1ZkFNODI2Nk4yOWhZV2NL?=
 =?utf-8?B?UEVlRTFIR0RQS2wyY0ozN2dVbXBLTFJSVGx6MjdoanBZZElKN3JrWm5tSnJJ?=
 =?utf-8?B?WXg4bnREMDRudGszRkg4QjdJWkhqVkhmeldNUUhIczZTUjRDMGRTcG0rUk9D?=
 =?utf-8?B?YkM3c1NSb0FXeXJLT3R0MER6UVJOUEw0RHlDVmpLeTExeGxaQUtvWUlqT3JV?=
 =?utf-8?B?cWtwM0ppa0NrTS8raU9Zd29wK0dUNzlEUEs3ckY5WTlka0k2aUdXTndIZito?=
 =?utf-8?B?bm9DVVVoOXBoVzZVb0pkNWJDYTZZUHBOcmZkNXEvak9xWHFLN3Vsdm5uMDJv?=
 =?utf-8?Q?ao5Lh94zFur5UiynKU7xKs/Vy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d377f16d-c551-467a-9528-08db2395fab8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 07:38:46.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EJeECz9i22iGCzmqUSpEe5jZwZTX4YnVI40CbJFgHQj3S5uilWkdVtrKYveCPYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.23 um 23:16 schrieb Felix Kuehling:
> Use dummy command submissions with a 0-sized IB on a compute VM to flush
> TLBs and signal the fence in SW. This allows applications with user mode
> queues to sync with asynchronous VM updates through the CS API.

Ok that is really hacky. Going to sync up with Shashank if we can 
implement the TLB flush fence a bit earlier.

Christian.

>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bcccc348dbe2..3f35d04bd4f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -171,6 +171,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		return -EINVAL;
>   	}
>   
> +	if (ib->length_dw == 0 && vm->is_compute_context) {
> +		/* Hack: Dummy CS. Just flush TLBs and signal the fence. */
> +		r = amdgpu_amdkfd_flush_tlb(adev, vm, TLB_FLUSH_LEGACY);
> +		if (r)
> +			return r;
> +		*f = &job->hw_fence;
> +		return dma_fence_signal(*f);
> +	}
> +
>   	alloc_size = ring->funcs->emit_frame_size + num_ibs *
>   		ring->funcs->emit_ib_size;
>   

