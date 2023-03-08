Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10889C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 15:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDC310E642;
	Wed,  8 Mar 2023 15:53:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2198910E63A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 15:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJc86xeJ4eRxHGfZUjA09zMMnwyCbL0czUkz2ng7ZYTh45mKeP9vA/w2ZVg7+/xMo1Qax7+HTqDe+v3QwOZBUPPNOqXDKdzArW/JJd+wnYrFjs5zuQ5fuDdcDAOiZs4830RAZ0QebJx7vflrED/7sm5ggt9XAbABPGQDCO7mjODd3Og0g0+D/hzCKC/Awr40mxlfjQ9BaJh61ThvLH+x5E/twc0/5oaX2yskBSsgyADD8aLTc2Iw2+4E9+Z71b/si6YwE78JcPQriw1gElzyT9w4EUVGn3tAcBy562CjOMxTy1ttFpiGpPzfdt24JHVuhIyNUJOnrf6jVgibSmQf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIAmM2qhSK7tljemZFlbGVS8JhNhoQAbeIAT2evglc4=;
 b=hISwJuXZd/AWKroY/lzKI2UQwSYD0k1A2mdCL3ERC5HBVXp+3R6c9KOTmPHv9n92cSXGutyx0FkgEodELhF1W4rTHkkSXpGRYWAXb4dnX66RiymXy6qE0amPT22fDpeWN1QgzVYkrbG6nV6vhwGmKvpHgVVcO33zmsmezh35lwMxC3yAuQM3SiwCieWt5hlj7A959uGDG95nfsinRadxYXbSyDnxGW7ETHdif3ArrV+89tOyagWxGqvDZVeg4RowEVaXHvXfFARIEHr+v6JMtOGPG0CnVIMnOiw6ghm/JhDiUvVc4+PiB5fh8mF3/TFQDMiXOSuHVmaOr+sKiQMr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIAmM2qhSK7tljemZFlbGVS8JhNhoQAbeIAT2evglc4=;
 b=fhVJfXPbfAyFrxpUjpJwgv3F1Vo6J34KsTplc5T+sD2Y/6CRjxwmcB6GxGmrcKg6ELxUJwti5xRtrK4T8X1zYQX5E3Ux4+ZDFAAfezcLHS1vM/gkkGh3RVnsM7P+7Coab+1G9I/hC7VA0VwXD9iD8/RTDeOiLfFowjJiNSUZHD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18; Wed, 8 Mar 2023 15:53:45 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6156.023; Wed, 8 Mar 2023
 15:53:45 +0000
Message-ID: <76a93d71-2a37-5dde-08a9-5460dddb6379@amd.com>
Date: Wed, 8 Mar 2023 10:54:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] drm/amd/amdkfd: Fix build error with unmatched
 argument type
To: Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230308093408.239331-1-qingqing.zhuo@amd.com>
 <20230308093408.239331-2-qingqing.zhuo@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230308093408.239331-2-qingqing.zhuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::9) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: db1c49f8-0e4c-40db-d014-08db1fed4c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0EgoTOoFgxgmlx3wxU+PXw1IKYrmfRe88R8fcXmycZXgU7hmHzTKtjn2vrAIhpHUJ9C/esXUK/PsoXxhkmWYAzE7jCXjuRkN9kWZQ1viWkWiwRH8ScXCFzZHM8rTWpiglMAl15J3dHTKS6cevwQzrOG+/sOWps79WxbpN3lxNU44oKK2BL2j9esRgjrKEdRRDJsoC2k6yTsSh0cEJ5alMSbb3rxuXbDHdG4pFtyw+AaVkgRwoVr/qfn/F+YhRGuVPnz8uUmVdDS3tOQ/UoA+dkShhqDECkVWr1tdBRcx3g9lPHn2QGWWRMMn53xtxzkDtZTOmFRWOiGYSdwJ8a6q+3cpNNDSX/ByaeBkdi9i8Z2jQC5IjfaBLmp87DgxKiiVNrmxeot5CWr0CZmNRTv+AejIvNDgs52TaYCF7lqjvB/zKaQ9jpYADu831QKgpa/UrhVBf+3ABnbOv1eZn1z9w4BVbVOW+a/6R9PwUW0gKKey6mNGC/ZLBYLUc0dtYMWfo24QutNH/a2UXv4mo2rYmW1nFxeVr/12NsLiUyVPTk3PYO5wJAw/UzAREaVqr8ZGxOi6n7AaYz0tQVopvO2xEFEOdQ3cJnGMstyl9hUulIrfBMlSReBvdQq/2nPTR8zi4ZTVLslooB1vTqGVaBUiDEyB8a3DuJ9+Su4DwAFXdqZjLH5WiQImVEZaXKwNgw//on++BWKucMbWb2FEv+fuWJKi9Osq/UWbSOiO9fbK2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(54906003)(36756003)(5660300002)(478600001)(2616005)(186003)(44832011)(2906002)(6486002)(31696002)(6512007)(6506007)(26005)(53546011)(86362001)(6666004)(8936002)(38100700002)(66946007)(66556008)(66476007)(8676002)(83380400001)(4326008)(31686004)(316002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9JMnBsV3AvSnRmc0N4WHhTQmkzeFUxUjRmZXlWU3pzbm0vMC9Ga0ZFSFp6?=
 =?utf-8?B?dmZOSGo1ZnpSZzU3a3BjSkVERTBMcDU5cng0UVdvOTlpSnNSRUFSbENHcnMv?=
 =?utf-8?B?aU80UHF3YzVtNVFGamQ2a3poUXg1MjVkS1B2NlhOYlNHRjhyRVFVOTVvS2k5?=
 =?utf-8?B?NzY2a1RwVWVteEladHhQSldKTFY0TmxSNlBpVjJPSUFCSnRiM3VnMlVrdjNK?=
 =?utf-8?B?ODlqdy80UjAvS1BGUitGRFV4M1UxdmZieWMrY1VGeUhFWVBXS1dlUU83K01w?=
 =?utf-8?B?Z0I1K2RORWpxRVdhKzN1bmE3WWlybmlJb2h0WVJ0VS9xZjBycUVPQm02dTlq?=
 =?utf-8?B?RWFKWUZsL25teGo1MWd1bUdLM3RxcUd5UXordnBRZjA5aGZpckNDd2EyN1pF?=
 =?utf-8?B?YWhGUXNoVmJ2TTFuZnNjbXJadUFiYnVNWFYyNkJZcFRwR3htM1hRWDFUWjRP?=
 =?utf-8?B?ZHBhQ1lLZHZRRTFXR09YUlA2cS90UlNkaGtxcVErOTU1cjVvTHBZQnpzOWJD?=
 =?utf-8?B?dUlvdEI0VzBLZEZJVlo3NVVBamJmR0c5YXYxSnVDNVRlZ2paOEFnUW54dGt5?=
 =?utf-8?B?akFUclZtYVV5eXZUaXdSUkZLNk1Fc2NKMUwvVDJvZTFHcnJxdDFtL3ljQXZh?=
 =?utf-8?B?WjBSOXdHREYyYTVPVFB2bGdTS3JqMVlRTkpubUFub1ozNzJKbnhsRWN3WTJV?=
 =?utf-8?B?V0tNdjBCUHNzN2Z6andJNlhVdjNmT05sWFhpdERCZHg3a3VWZ3hIRWtEMldZ?=
 =?utf-8?B?b0VlelZ0MHI0WkcyTzgvc3RFYUxUOXFaYktTSUVmdnYrSzdrUm9QOWpCRktI?=
 =?utf-8?B?UTM4SXpEQVpBVmdydDVoUThxSUhpZ2xhc0xRNTgrRzNnT3NWbEo1UjVYOExm?=
 =?utf-8?B?WUpoSVNSQlFaMjdDQzlLWVpMQmtvMDRBdVdMaXozUlN5L3JyVENDR0JZVHNC?=
 =?utf-8?B?c0RXY1ZXRGdaUVJ1SWUxbVpGMHAxN08zM3B2VkZjVHdhMXBHZm1pM2Vid3JN?=
 =?utf-8?B?U0JqWGZIUXNVVDR0TTFUdDdtTkZmcFl5elBRS2pIL2NpcjExWlJBYUpEWnVz?=
 =?utf-8?B?aEtJRzhWNkdadnUybVl6MXMzdnFhSmhmczlMeDUwRjVOa2F6SFJ1VHE0M0lB?=
 =?utf-8?B?enlwQ3FIRlhvVHRjMUFQT3RjRk5zdjNGRDJCWlVLRW5iTlcrZExNWlVYenNV?=
 =?utf-8?B?T25vT2VTeVBRenBvZnJ0TDNabWozQjAxOWh0aG9POVk0NzRveXBUQ2x5N0ln?=
 =?utf-8?B?USsxVlRtNzJraXUxalRUait0Smx1SzBYNE0vTTRiTGtvc0JQRExKRlN6UGVp?=
 =?utf-8?B?eVVlUXAwSDhMWGRCdDhGQldqTkhteFhPbFZDREFFQ1huU0t3Z0pxMFhCVStM?=
 =?utf-8?B?bTVBelNZYXJqTjdqdEhtaTY1M1JFZmtNYWh2UmxYbzQ2dVMzSmh5YVRBRXIw?=
 =?utf-8?B?ZHNMWmRPckRWb2dJaGF2MEtvTkZFU2tMRlh0QllIQ1JrcnFFM1FqejJBazZP?=
 =?utf-8?B?VTg4U0h2OGFJQTJ5TksxbFJ6amFPNk5iSmhVUjZLNXNPM2dIM2JuRUV3R096?=
 =?utf-8?B?Z3U3ZXEyQUdIbDgzQWFtdzFVT1IwOHdFRy9YTVI3ZkMvQ0hqYVl4amE0Qm9q?=
 =?utf-8?B?cjdHTTNuVzJmZCtOMTFQaDdNZHFnQjhUVldUdVhxaHZvVjZiWVE1MWFvenA3?=
 =?utf-8?B?UWpDbFBnY2xDOG9KZEM4RG5QcHRaK2I1Z1k2ZmtyeDdKVlRqOEllSXA5RkpH?=
 =?utf-8?B?SERjNlRpSWtLV29WQWhIa3RyUTlINWNlNkVPWHBPZlpqaTdCcnhMcVVsNDJL?=
 =?utf-8?B?WWVjWkJMQkZMSjFQYW53blhDOW41RGdyNkRTQ2pyS0U4WmhKcGVLVlNsWWlt?=
 =?utf-8?B?Z1IxeDRSQkZDT1FKOC9jbC92L3dHOVgxS2JpT1JWSVFiaG5vVEtTSFpYSWdC?=
 =?utf-8?B?YUYrNUpFb251dnZoWHRYVVdpSGlpYU82NjNCeDhEM20xbUFwWHZQc0JLcDEz?=
 =?utf-8?B?d29JVUJRdzcxcFlkTHZJeHB3WXUwc0lITE5YOGFkaDJVMjNLcktqbnNKRjlL?=
 =?utf-8?B?Sy9NRTd3bjdkdVV1ZWZaeTdBQ0xScXBielh4OEtLcUwyQ1Vzbld1ZkFtMU85?=
 =?utf-8?Q?FHZi+Kf0IuCiGw2GYiEtJ/nir?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1c49f8-0e4c-40db-d014-08db1fed4c96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:53:45.7764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzMqQUOgcYN9eU/aShCVNTzizpm7hBdVwAOrGXu1Cx4c9vH18oOpiVSDBssaF0N7rXqU8dUNYOBEgTkoC6ne+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/8/23 04:34, Qingqing Zhuo wrote:
> [Why]
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c: In function ‘svm_migrate_copy_to_vram’:
> ./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:35:21:
> error: format ‘%lx’ expects argument of type ‘long unsigned int’,
> but argument 6 has type ‘uint64_t’ {aka ‘long long unsigned int’} [-Werror=format=]
>     35 | #define pr_fmt(fmt) "amdgpu: " fmt
>        |                     ^~~~~~~~~~
> 
> [How]
> use %llx instead of %lx for ttm_res_offset.
> 
> Fixes: d5db9d377c021 ("drm/amdkfd: Fix BO offset for multi-VMA page migration")
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> 
> Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> ---

I believe this has already been fixed as of commit 271acc541327
("drm/amdkfd: fix warning in SVM debug statement"), in amd-staging-drm-next.

>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 373cd7b0e1ca..fd54a00e7229 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -304,7 +304,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	uint64_t i, j;
>   	int r;
>   
> -	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
> +	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
>   		 prange->last, ttm_res_offset);
>   
>   	src = scratch;

-- 
Hamza

