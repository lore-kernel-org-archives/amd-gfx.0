Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 15:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A179B631;
	Wed, 13 Jul 2022 15:15:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AF39B62E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 15:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjAWYZEr3sasNTX6pAExamVDjEKCwy29vJg82oZj2K0wA4ybWRR+dimMPLVm24Z1kxmaHOiBQ9KBry/FLKTlxLfgWCu0GWEsmEej+m/B8H7XbcBW0bNojid5+jxBfePrZcsFZfnEP/AC6tpQ2iR3eHj7BtXQ6NEBPW8gpUI9pB8ARsTG0jfwmdeme49EvkCp+gzQtasEJGdp6s7cAxFy71mTQe8HfuiHDFnJU9yeXb6l29CFdYxHV8Ih1b2t4fPL3W7ZOIxuC9eH337nJs2puHo4zXCoFxGE6q6+sctTn7vhPf8jhdYjVxU86ccFbVNNLJ1yhvG5sn5/n7T7cGxVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB9p9RYaCdujIUCi2bt1xv5cU3KrkDBHAno0+tstHvY=;
 b=NEkRlE5NYFz7KvuD/KDx5gcuoCyNvuWZYRQORWtv0ruHLJHLAW/ISQXnY5PKX2DbygpHPwRLKRFCM3mVN3zGqTcvTHmiGCSbsM9PMi4kR4jFd8TTwsN1zmZ+xWSal5SIOa1AMyg5rMxoizLXXrtCQ3/SIoqGl+ZC347Uqge290G9SJgPQna247ZtUESXEh8GRPFSEA8zQUKSosjnpfPOGtCgsGi6Twy/7E9VrFN2/+9M5uWe+pENZgfTxSMYLnmOUtCXj/GBtFxso4zuGsr7zjQ5+mBf96A6CRoHwE7re7ebli+PqKjdICt360YBF/kEQg2mReS0yuHBTNYiixaP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB9p9RYaCdujIUCi2bt1xv5cU3KrkDBHAno0+tstHvY=;
 b=lG9VwIdN7HrPJZU68e4XEKR05iL/liLWJx2KutdFD4fZjVe+tmrEm8WS+3eoD6CBi10QocbTazKDVytGbNSvoxCoreWB2l7bXdNOOcXr5kfUz1rI8YLKbQskLhrzJ8Eg7b1JOoScYyFzTk01mXEYasXEi7W+3Jh5xSL+nt1UysM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3565.namprd12.prod.outlook.com (2603:10b6:208:c2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 15:15:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:15:03 +0000
Message-ID: <8472a175-c2ba-66cc-936e-e5b0996de859@amd.com>
Date: Wed, 13 Jul 2022 11:15:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/configs: Update defconfig with peer-to-peer configs
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220708231701.1522008-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220708231701.1522008-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0055.namprd20.prod.outlook.com
 (2603:10b6:208:235::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03d0b592-cc3d-40d3-1fa0-08da64e275da
X-MS-TrafficTypeDiagnostic: MN2PR12MB3565:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg6UUsA9TF8tGDPeVCTIDgclEvclPKnQstGNod/mCO1/Ju93UmkbIJWP4kkAODNIosgma72CB6NlZaRV3tvSF0NbTMquVhFfLUkdFhld45k3VM17gnBv1YLmDqjD2ZaAczfrT5+qiFuAJXjcgABikNjQ9h66S2ovOWoQP7n2c3YSBWIyx4nLzqEyFlYATqux8Gn/cQVrIv/mMBWPCvkqqQPcfxvGfYPAGBVD59Vq/niHv18tR183H6EHTNI+AoPKE+9/nvOhXW4UKr/4tvIPl9NLIq+LPMmqqdWF2CAJYQkTEorYbd/lgpt0QtiITLrqGXbmici+bmhkgB244qh7hoke1g3aQiffgtgkknZvHcQNZdUHp/rZn2DEB/U1ouqqcQeh+6gSGoEYFo2BCs5+0TDYBcKxdLpv/R04yCope25MIOwlBBf4/pD4O98TtvZH91k3VpMq8prAnSbgkalgdfsFRegTj4QaWO6G3n4qyPZGJdQpApeQWG2dr7Fs53Ukr/mQg1xH+YusgbdhCLLxsnXRqia26atsO58S2F4wB0+IKqp+HroGLUa8U0vi9laKu1lqQkrQX3h3MBZ/2y09OqgaT82AIC5yCbeA5TZ7YwB5VUPuKdn9n27YreTdIJx/RsrU5XM1bvq/Z3LrTLvc99ztjF7roTjX9DD3y2oFpmPwZESOQpd19vwLOg9GXGIzdKagJZ1IPvrmVgfbnbvmsMqyFI71tS5hGGo2NhABz5okgNF+zLSiIyPV7q8nOFPt4ZiKD+x0Ez8njtilZcVSwBIzPVX9KEUAIK6M/oFxQ63KkeNVwfNZYYvRLlXeldm40FKYFH+FM8Q6ZxYuM6TWtm1RNVMbJrsgwGvE/KbGmp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(478600001)(6486002)(38100700002)(6506007)(36916002)(26005)(31686004)(53546011)(186003)(36756003)(8676002)(66556008)(66946007)(66476007)(2616005)(316002)(6512007)(8936002)(41300700001)(2906002)(15650500001)(44832011)(5660300002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVWQUI4bG5WNDVtd2pDVUJhNU9VK2ZGdFJRR0hTRzlZREdIbms5OTJrcldV?=
 =?utf-8?B?Q0w5WmpzMisyemlCNHNyM0lhbHB0SW1SRHVqYkM2YkZnc1BNVmxjeTNRVmNR?=
 =?utf-8?B?aWR6ZG5oWm56N2pWV0dOVlJoeTU2eWJrOHAwMjZrR2Z3MDZJUzFQbDVqRlZL?=
 =?utf-8?B?ZTBReWd2cFJjcnB0cWF6RTBpbmk2d2RaZFpzc2xzdjljWGZRR01xb0R2L3Z5?=
 =?utf-8?B?ZUhLN29ESmZUQXc0OTQ4Y2Y0SXVrWVNyaE1SRXlGdGNkbWVBQlZldVl4UTVS?=
 =?utf-8?B?NWR0ejdqOCtPcFYzSEZoSjVyb1FXcnZpSVEyaG1iK0c4NTlrbEl5Q2NuQXJ1?=
 =?utf-8?B?K0U1UU9hK0o1R2h2b3RENG03SzhCVG96cEptcXY3d00vYXMvTU01RElIbUxN?=
 =?utf-8?B?aG1xYkwveVhtWElzemJjR09ESTM2SnZDZWNjY1pocUc5YmFOdnlwU1I3SCtX?=
 =?utf-8?B?eWx1QXp0WG5JNjhyc1J0VThxajNBM2F3dVpCQTVTWnlKTTExWDhIaE1DQlVF?=
 =?utf-8?B?djJ2TU4rQUd1QkZldUtPV0dJYzZ2TE1PaHMvaTJ1V1BwallxUkh0MkI0c0Q2?=
 =?utf-8?B?WGZ5c1k5elh5QXVWbXM2dlE5U0lTajdJdVNXem1WVmV6a3FoeWxyblp5czl1?=
 =?utf-8?B?VXcwcWpUZmtiTERqLzdGclQ1QkxaL3dFUE4waVN0YXVtS1BPcDMzWmJTYWI1?=
 =?utf-8?B?dGpmeDhJSld1NWYvVVdWVjFDUDRnTit1RlZoaFZ1Vy9paHZiR0NBMEgxUjdm?=
 =?utf-8?B?c3NobHBXTU1vV3VkQ1A0ZXYvMndTaW0yRWFYYk1VMTQxQVdENVBwQmtFQkdB?=
 =?utf-8?B?NjNncW1ibGlqY09KMFlBaDRDUFF0QmQzSyt6NDlnOERVRDFDczI4WFM5cGh6?=
 =?utf-8?B?WC80UXV0RHJlREJXSktLTlV6dENwYXF6dFE4THNHRFdJajBDdXRYaHAxNHA5?=
 =?utf-8?B?clN6RVNhNG5hc1BuNGZPRkhCc3hQSzk4ZVdsU29jUTVQV21hUDFQYVZjUDBW?=
 =?utf-8?B?dk1Ka21hTS9xdlNLNlBCT0FJVk1xZ0hVSWNYOEpnM2xtb3FPNzZoQWhFLzBu?=
 =?utf-8?B?UmVTY1NwdzdGb1l1L05LaHFqZ1ZacDB1ZzkwaWRVVG9seHNqazBxWDF4Q0E2?=
 =?utf-8?B?bzFCSURhZkVQRzRTdEp6VjlVTWM1NGM0emtDWHFWaEhqRndvNi9VWnZ0WkhR?=
 =?utf-8?B?QkVZVkNCcURtemt0M0VoTVZlc0FYaVVaVEMvVUsraXhpNmhGcmpDcjdpNkow?=
 =?utf-8?B?bUljMS93U3VUVWJOSmh4NWpTRytwbHlyajBXM0ZGbVlwSWs2QjAzdzRId29x?=
 =?utf-8?B?Yi9vU05BWHJtV2d6eFlxRUdFOUwwWVFMU3JRMmZ6MFJtREo5TXVLcStoT2ZT?=
 =?utf-8?B?Nk9DWm1jNGFjQTBwbkZOTVBDNi9RNXNBZWszUWlFOUd0ajVia0cwNUdxNWo1?=
 =?utf-8?B?OENzSW02RTBKNDlQdFIrYm1HUzJvNTVFOGMxKzFOSS9DMllRcXBlYXQrQ29j?=
 =?utf-8?B?bHZidTBLaTdNUHNYelUvaUZSZzAybjg1QWlpTkt6WGpZVW5jc0xnRGsrZjA2?=
 =?utf-8?B?NGhBbkh2bXZHUlNlZ3BMd2V2SWRqRnd3ZlhGd0E4SnhqTjQ3SUVkVVp4TGly?=
 =?utf-8?B?QzIzOEZsVUltTWJGMlNpQTFmbDE2WUhNdEJPTU8zSVl1TDQvU3Z4TUFSaG9m?=
 =?utf-8?B?cWtJVCs5cjVLRkVnRzBXd2U5anZSamtKejNocmN4SmRSOXY1MTNyZWRhK2NY?=
 =?utf-8?B?SWtITWlaQk5hMUxvbDJWMjMzTzl4ZVdLalVLYVBEeUJIUWdsOCtvUW8rdW9I?=
 =?utf-8?B?ZG0vQ25mZmFTcjR3NGZCaGdNU0VTblZIeW1zWUNhVG1HOC8yeExnZmNYNnpj?=
 =?utf-8?B?eEpxdGQ3V2hIV1lKUjBmamRDa0NtZE1BOHBvakFvakQ1dWVVMHVWUVhlRitw?=
 =?utf-8?B?c2ZHY3o4elZEZkRqa3lDT1hqcDlOQ1QveGRWU3RpTDEwK3VrZG04QmhtMzRS?=
 =?utf-8?B?NVhqdXhjVFJ5QXRrVWZzdTdDRlF4TlZhOU03bnI0RVNSUnUvNGp6OVI5SzNq?=
 =?utf-8?B?WGgyYUdrOEw4YW1ibVE5emRVOTNodHdzM3VHaldERENZOTBQZ205WFlueHVo?=
 =?utf-8?Q?zRVf+uQ8uZB1vC/xQQdl3G8Oo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d0b592-cc3d-40d3-1fa0-08da64e275da
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 15:15:03.0212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeD61mTjwflOvLJDaVVELDTxopT1N/ispntt5UevVkVGeYWGjbgX3Fc//+V+jYkdHwVVLfeO7d9aRtnSHwnNQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3565
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

On 2022-07-08 19:17, Ramesh Errabolu wrote:
>      - Update defconfig for PCI_P2PDMA
>      - Update defconfig for DMABUF_MOVE_NOTIFY
>      - Update defconfig for HSA_AMD_P2P
> ---

The patch is missing a Signed-off-by. With that fixed

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Notes:
>      Following procedure was applied:
>          make rock-dbg_defconfig
>          make menuconfig
>              Enable PCI_P2PDMA
>              Enable DMABUF_MOVE_NOTIFY
>              Enable HSA_AMD_P2P
>          make savedefconfig
>          cp defconfig rock-dbg_defconfig
>          commit changes
>
>   arch/x86/configs/rock-dbg_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-dbg_defconfig
> index 406fdfaceb55..0ad80a8c8eab 100644
> --- a/arch/x86/configs/rock-dbg_defconfig
> +++ b/arch/x86/configs/rock-dbg_defconfig
> @@ -303,6 +303,7 @@ CONFIG_PCIEAER=y
>   CONFIG_PCI_REALLOC_ENABLE_AUTO=y
>   CONFIG_PCI_STUB=y
>   CONFIG_PCI_IOV=y
> +CONFIG_PCI_P2PDMA=y
>   CONFIG_HOTPLUG_PCI=y
>   CONFIG_RAPIDIO=y
>   CONFIG_RAPIDIO_DMA_ENGINE=y
> @@ -417,6 +418,7 @@ CONFIG_DRM_AMDGPU=m
>   CONFIG_DRM_AMDGPU_SI=y
>   CONFIG_DRM_AMDGPU_CIK=y
>   CONFIG_HSA_AMD=y
> +CONFIG_HSA_AMD_P2P=y
>   CONFIG_DRM_AST=m
>   CONFIG_FB=y
>   CONFIG_BACKLIGHT_CLASS_DEVICE=y
> @@ -453,6 +455,7 @@ CONFIG_LEDS_TRIGGERS=y
>   CONFIG_RTC_CLASS=y
>   # CONFIG_RTC_HCTOSYS is not set
>   CONFIG_DMADEVICES=y
> +CONFIG_DMABUF_MOVE_NOTIFY=y
>   # CONFIG_X86_PLATFORM_DEVICES is not set
>   CONFIG_AMD_IOMMU=y
>   CONFIG_INTEL_IOMMU=y
