Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E72C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 13:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32181130F2;
	Tue, 30 Jan 2024 13:11:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D691130C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 13:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/mEox5Oc4AOa/JD47tdAXTyUdm3TfBne8Eka933GIrutI7fxtxfvaroybdz/oVgg6jOG3nx/JrY0QYtKBUR5gwuFlKIoLeuOQFYac0TFBBEdq3Plp0MLYwdx2SAXOAO/ilO/01y/lznZTqaLK1ZBTF3rLay/yN1GRDmzM0dSB6y2QILjHL7ZulUmmexRVlXqzr4/6SMoHYuC/aLLEnNhRzVi+iX+ceLdlB3kFLtFlTEEu2UaZ9Y4ZfWVlovo+nLCN/zHNNX+hy3AsM1oi6flh5ftiYIYfL1VItxFAXOkaADSKbYRH8dq3fTj2U2F08IXpl4jk1eHYZwYQskorFZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFPDMEkBvY2M4GZPluOeMLMQ0JT5L8SQJo54GdSgr9s=;
 b=QKodWxsAm4fK4B0L2fa+WdyjwasySnxqazsmU4/EB3yPKXcP3rxEaWM8BFOERqA/0GkQZlRAiggWoOWwT9CvAU527Kr/9wgjNgjRU81q9h9TtskuykF6eWk6LK3lRAqifNkEVSdvxlR0Y7xHvp7AVBCnKmlIY4IdeyskI+trUiIrkypvPTYjrOPiQZTD0IqkliUD/Gz7Vxsgtj/FzUth8FxvUl+FqN5uX8saxfP9q0G+RWhb9kAd8xk0mXYWQqBhMWtZsJnDlEWCa5Gb7kz+ZZae2Xe+yvbsheOce/3dA6+71UPnf2Snyloo2F/owYSfzdYmwgvw6rD3PDlRQ5W5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFPDMEkBvY2M4GZPluOeMLMQ0JT5L8SQJo54GdSgr9s=;
 b=Dd9cScQbtxhPXdgzBWya2Je4N+RqqSjA8KvXySUxmmENAC/+9dMRL1m6/VU/Iy33hWenZACp65JzNZDTSLDPIOxGvBZey0PPAN9mxU2VhzqOr6sb1pm7rkVdw/OSKYLaxp3wu8Ar+nKCgQg0lvn/KQGTT2nDNJ2nL809NUbut8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 13:10:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 13:10:49 +0000
Message-ID: <2deefb88-5045-4f08-ae16-a474ab64c629@amd.com>
Date: Tue, 30 Jan 2024 14:10:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix missing error code in
 'gmc_v6/7/8/9_0_hw_init()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240130082727.399314-1-srinivasan.shanmugam@amd.com>
 <20240130101908.429223-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240130101908.429223-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0383.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f94d6b-b3b7-4d0c-6ab3-08dc2194e09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ansfG5k3YG2ElwMs/vxu3JDNj+RizQ+JsYyUz0uuDL5IgqgzvIlD8kl7s3QdOn794akVGYG9VhOw1lsK4cVvfSkxmj8eY5L5EkPKgRRQ5Pso4KAOAOLmrlnK4CsUtSK+Y8hXdk/Y/+GQOTWkXiKqJbWcPR6/5wccRNbeSA4e17hO9HNP4vYDagZGATzsZ65AninykgcuCJI/PiSOVi3yBBLrLanZjlFLbNdpBUqi6U8YKsXfbDKQsm3tPKKgKbHAbbj0D5Mz79Vz0SK/35+3AxsNktojtGKo2NbDq8U9xyIUGC2Y3LFJJS1BfDz0fBAEAigvC9i+hvV79duo9mWCDn7dH72g9XuU6eX/ndHsGE8vXMRCgiB8sYSMK5ZjKNuBHFAsD542JzBaH+/FzrqQ+/8d1g1ppFujXEZvyJvvGQStyCe6W+3cmBVF5L87C3GJt8j4JW0NhhN0zcg2foaY2/vhiCIuRwo80iFtdZm8dA8MD3mNyxZ+baS9z/dqWdfArmT3cEZASVVtNZx49UXtUBsUJHsrhm6ICLfSguF099k//Guuek9LW6BIFpGNT9iuL7g8uAjCLFfBCrLuKXMzGGXFuUpUdFtw/MFZTana2PGkSLWbNSdvJ53XW8YwKk87Faa0aCb3M/frh9o68WIQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(2906002)(5660300002)(36756003)(66556008)(86362001)(66946007)(6636002)(66476007)(316002)(31696002)(83380400001)(110136005)(478600001)(6486002)(26005)(2616005)(8936002)(6512007)(8676002)(6506007)(4326008)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNaVFNNU3QyUVk1cUdLT1pORzREdExIeXcrM2xwb3QrbW5INXNRVVM4YmJJ?=
 =?utf-8?B?QlpEdzZJYjVpc1pjQjQ1RWtIdWJUSTlSeVFSb0x3ZHpibHBocVBBbFNvc3Bo?=
 =?utf-8?B?L1MrS09aNS82ZmdJV0NDcFZsK0pUZUp5ZWJvUVhFSGhQQS9DSFNXU0tZaHdE?=
 =?utf-8?B?QW8xMUJOYkZWcWdEKzVXVEFycWlpem5aajM1dU8vYTluMS9TYXhaWXQrMHd6?=
 =?utf-8?B?eWs2NE92M0cvUjVvM24yVWZLQitDUzU2a3A0UHBTdVc4R0J0aXN1K1dicFRU?=
 =?utf-8?B?RXZ1bkxibkl0azdvQlpzRVJhcWY5cW4vWGNHaHVDQ3Z5R2FsVFFkbzRYUitD?=
 =?utf-8?B?ZWFyc1VzcGlkZjJFM3Q5aFV1ZGFzTVVlajJDbDFMQWNWcVV2YmRmc2NrMmhm?=
 =?utf-8?B?TjRicWZMaHhzZkdvRFZhZmEzVms3TFQxdndTazBIelU1ZlRSd0NQR0laYjVz?=
 =?utf-8?B?US9CdXhWM2o0Nk1YZ0RBVzE1bEtPREg1eFFBbmtGcWxEamo5UXNMK0JKTFM0?=
 =?utf-8?B?ZU9BMDFpRVJpRnZocXNvQVJxNEE3VnFUbGgwYklqTEZwaHNqbnJoeWoxeGVR?=
 =?utf-8?B?RjM0UHFReFMrNElHdmd1QmJ4aW1vN2hFd0l4NTJ4UE5lU3dnTjNSa1Y1MWs0?=
 =?utf-8?B?aTdmZmoyNTFyZkticmhJTk1uc2RDSTdlWU5RRHBqajVWYzVaWmRtdFlGRGk5?=
 =?utf-8?B?c0pXT3NkWGlubzZJWHROLyt2QnF2MDBGRGRzaUI2MDlFVEQ0bXNvZ1hpNzU5?=
 =?utf-8?B?Q2F3c3JKWGhqdit1aXVTdEprOU5PV0dpSGlIR3FzNmN5OC9MYmpuc2FPQlQ1?=
 =?utf-8?B?bnhZVUVjUU1SQ3BxZVBpeGdDaWNNMXpSY3hEMmtBQXZtL1RoZDN6ajNXMGdx?=
 =?utf-8?B?bTd2N0xtT3d5cGYwdFJ0UnhpdGJ3cjNNaHkzSmdCV3Q2OUlRcmFreFh5UEVR?=
 =?utf-8?B?WjdXUENoc3o5d3V5cStoQ2ZyRXlmMVJEdDhrNWlUeU5PMzNXY2s4WTZBQjU1?=
 =?utf-8?B?eGhjVEwyaEFSTWU5MVo1S3JzOVRZd2FjbWpxRXlmR2V2d1NRWjdOc1ZSYmhi?=
 =?utf-8?B?SlExQ3RGSmlsT0poVGlsdFlVN1MzN1BHblM5WUZNRE5uQTY3a3dDZFJMUTJN?=
 =?utf-8?B?RlYxY1ViL1FSTlJ6eXdmdzdtNElFYVRRWW9GWmpvMTM0K25vdVhscmFZYkYy?=
 =?utf-8?B?MDNieG9kK005OGY2b09wTDdIQm9TQUkyeklnZjBxZXoxeWNJcFFwRS82RjZv?=
 =?utf-8?B?cEJRNytVdFRYeEhGNmJhWHRwNkJVV2ZOUTVMemlsWEJkbktLaC9SZkpOTGxu?=
 =?utf-8?B?RkR1cnBvMjdHalN3cFo1SlBzdlRWMmlXU041TGlnbWFidWxjTVBYblNlMk1Q?=
 =?utf-8?B?ZUlndzgyaFRxQ2grQTVybTFWaVp6TkQyTGd2UllvUVdDcWdqMXB6bHpCWGlQ?=
 =?utf-8?B?ck52bEw2YXdhcmJ2T3BNVjVjZEVxU0hSZTAxZERCQnIrcmVzSFRNWXFYVmRJ?=
 =?utf-8?B?S1M5OWt4dC95OGJkR3hCakViNjE1MnVRODdFRTlFTks1QitMQkdWV0c5Q1FG?=
 =?utf-8?B?Qzgrb2YrQk9MWHBaVXhLNTA3TmRRc08vc2MyWEVyT25HR25oMElWL2pIU1NZ?=
 =?utf-8?B?YW1Ma21VYVBvRUNoWFRMR2dmZ1lmRVV2L25yaXh1QWliR1FMUW5lZ2hCNkdQ?=
 =?utf-8?B?dWZYdkpZYTVmdzVUUGQzMG4xYjBkUmgrellrcllWU045K1R3TGdYZng0d2xs?=
 =?utf-8?B?SHVkL0lGQUZLQUlUNktOU2NwV2JDdXJvREdlMTNCQ3NJcGJabXA2SkhSTE5C?=
 =?utf-8?B?ajRJL2ZZeTNpMitZaHhHYkFYempOcG9qTXdkZWYzMDRBUTJUMzBoeGJrZlMx?=
 =?utf-8?B?QnN1UmhVZjVIcWhXL3ppNUJJOWZFMmRtbHhJRnI0dU11VGRkcFRvN2hGbi82?=
 =?utf-8?B?MS9OYzBxMWIwWXdXOEZpMWRWV2dRSGRiS3ZsMlEwYjVKK2FsTmFqS0taTzFJ?=
 =?utf-8?B?MFZKZm80aE5CMEowLytIdTFJUklxc05lN245eDhQUmZqbW5ja2pNbDlULy9B?=
 =?utf-8?B?NVk4WGk2eWIxRnRlcDg3b3llb1JSR2g3eDM3L2lVbWdINzlhd2hsNzkvK3Nx?=
 =?utf-8?Q?VWX/GhxOrLviKhPKZrUBzpMfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f94d6b-b3b7-4d0c-6ab3-08dc2194e09d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 13:10:48.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exKpXF84qnoUxefmTG1WvR0QVRe133QkCuZbiE/56eYMyg1Mkc5q1zke1gLhioix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

Am 30.01.24 um 11:19 schrieb Srinivasan Shanmugam:
> Return 0 for success scenairos in 'gmc_v6/7/8/9_0_hw_init()'
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:920 gmc_v6_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1104 gmc_v7_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1224 gmc_v8_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2347 gmc_v9_0_hw_init() warn: missing error code? 'r'
>
> Fixes: 8301de8fcadc ("drm/amdgpu: Fix with right return code '-EIO' in 'amdgpu_gmc_vram_checking()'")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v3:
>    - Changed from 'return r;' to 'return 0' (Christian)
>
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 229263e407e0..23b478639921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -916,8 +916,8 @@ static int gmc_v6_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return 0;
>   }
>   
>   static int gmc_v6_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index d95f719eec55..3da7b6a2b00d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1100,8 +1100,8 @@ static int gmc_v7_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return 0;
>   }
>   
>   static int gmc_v7_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 4eb0cccdb413..969a9e867170 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1220,8 +1220,8 @@ static int gmc_v8_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return 0;
>   }
>   
>   static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index a3a11538207b..4a50537252ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2343,8 +2343,8 @@ static int gmc_v9_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return 0;
>   }
>   
>   /**

