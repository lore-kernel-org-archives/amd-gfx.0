Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EC6C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 15:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23ACABEE46;
	Mon, 25 Jul 2022 15:01:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B522EBEEBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 15:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtesUci2racW4xwiy/GJt1d/0bWnbqeAswUy5eGtBC51SiOcLX6uW+44HmcC9JFguZybBQoRdl/3+V5hAKw5/uqQduN4QqaPB8OncInfam9zvAQmQrBf3nKRhPtWY8e1kkhtJVBv+Y34rCjzdZrfFUfFCIf3lS84cm0B1ArHJJoFPb8wmytsUOn79rZ44YmxwGxUkjeCEeREpwSUhkXmN1oXvxt3+3xZKovmdRaZp1NOEDB/Dke1GyfdL0uMICjKf5sZQcxSd4C6HduOH6s/bY5kIHW4lVK2OF3y6uEQra7H8j4iv/57r9fRxODXCLd6U1L08U6063ofZA2/DFw3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUZTk8WlxqAf7t+srTXbDiuIDFVzBWBu7KA8Cm8fFFE=;
 b=KSF+GiTSlRTR2uMbV/QTKm6v5t8WFfzbZIfg0vg+y58h2xIdI3/ZsCHR6OhbGko7gfxk112dN8p3N1aVVDXCykzjeYkjbWyo77HGtwLj61AJiIKVR0dKJMIHIcd0HvmqL4bLxwmB+hmMbST9KiXALxgjWoy+iuTSp0cVyDalrqvKAjRtUhssk8UtqLlHqmz7Qr37ND/SUsMNqta0SMgZ3iDQ9eCzbMPsAvF0IRvtuuwNgs6EMOulKMqOAEDqkSbeHW9xciWXo9IRD5jORV26MKCPl0/32+cqtaqMVrTMqOnCNmQ9YHxUsVMGKEWFSPPLFrTGCYmWOk4hbUFYZS5t6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUZTk8WlxqAf7t+srTXbDiuIDFVzBWBu7KA8Cm8fFFE=;
 b=mZVt2n0qC1sVMoMLjFQwzZAXN0jiUzTyUGZAJP3xEZFkFQxGpNFmaiedhYzl6B4NHoCJycvPmxtYt3D/lIBWjZFEgjbMpGT52I0ngMyu86tOKl9LRMl4r2rGTgFO3NXzKir/3pO14M9VEQvN8CA5mCkbQO7UDzUV/jefwipX2Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1565.namprd12.prod.outlook.com (2603:10b6:301:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 15:01:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 15:01:42 +0000
Message-ID: <a6063fb1-206d-1d70-e6a1-724327e868b5@amd.com>
Date: Mon, 25 Jul 2022 11:01:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Allow TTM to evict svm bo from same
 process
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725122317.24606-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725122317.24606-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 375e4bdb-efae-4ec4-af11-08da6e4e95b0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1565:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejpD78Y4bYBMomDb0FGy+zVjdDgZAqcHObR6QhzgSJeEXfcxCygDBDYhKsFWUj0t3BoB8V3z9vgilBiZjuORERd8+/MHvB6yBacPmeSICfUbfsrzVoP6GpmcAjpFEtlfjFl20SsA0oDmyebvzIZvncwe3lTFWtVPAtAwZHrEU8WaogLlvrlpvceBVDgbB2vMVAiGqPQjntz7LrwOiB/RqPwGfeOWbA4uii0TPAiYbwitXKuvR/6pHBK6g4M8I230XimmrKrOacYNhm4UusoiIVPUqOanOzjjP7NCdLWd3l5QGpt04UzoO9izUF+Wpix+m0IFOwCM66CaR31/QLgzcydOp0cW1AbnIYnFID33mTkoCkxmiEGEw+zgFh4hw60pstiln5WZDHZTOckR2ENMjxzqp7tCsU9g3AnYK+OkYKUl+TmgfZ6VRQaAOho0m+3+WlAwqxqj0zspc2ZK+2nCtHoZSoYI1vxXdWgmgG9odDP6s/ZnVujLMvEHVF7jMlCz5AiHMdHxAKb/BoJKY9RypAnh/yikaUaFljtkeKkwOOadpoUhAMSQGTug+M0psbpBGZiCRn74yXUi75NO9URhyvOEKismUDKU1D2ltxcEzYsyCCYAA+RyNDNnEyWJ/GaAANgY75Erzj4iUEdkC+UmlvHPdWHbz2Sb9/WIy3UXwL2agKtXCvGZbA9A/gWiIfijlN75fLyPhN4fBS7Cw+BRM9/4jFy8jhX4xZmDDCrTW488sOHCwXHAWnBCuOBKd5II5zJ3e10ogIBZLAFrgE5qsrB3MUsmsKUuafHUAzVXUR/47VNkMUeYAZ7ohUk9vgY0XapI0h87OzN2RhjoLRIFMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(38100700002)(31686004)(41300700001)(316002)(31696002)(66946007)(66476007)(2906002)(66556008)(36756003)(8676002)(86362001)(8936002)(5660300002)(6506007)(6486002)(26005)(478600001)(6512007)(83380400001)(44832011)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUx0bWFVRWUzZkU3bkk0Q3ViYS9qc2NCclBjcG94Nm1SQmFUQWYxQmhOcTBk?=
 =?utf-8?B?TkJHckFIL0pWb3oyMExwSHF6Z0JoYmpVbmNtMVBtbVF5R0krMTZWMUlxWmRI?=
 =?utf-8?B?MUEveFg0Slo0SFVsZ0NQbnBFWnlKQ2lzTTdWZEZUYU1DdmVRS3dUQlJuNDVO?=
 =?utf-8?B?Uzc5SGFCSGNPNFFFekhnWmVUdE5zQmxEdzg3aUJuRHZEdjBVWFN0enhHZnZZ?=
 =?utf-8?B?TVcyczJFU1h3ZktJNi9EYWpMeGZPOXdBbGROb0hwMS95YUZaaDZOK005Mm5E?=
 =?utf-8?B?ZHphR0Zad3pUL2FGSUM2M2lOeUNQVTY1djVMeXF2V05OZmx2UTJuQTh0SHRi?=
 =?utf-8?B?aEthbmc5TTJZTTduRUZPMjQwcndSeCs0aGNFQ1BncUhXSUFaT2hKSlRkeFVD?=
 =?utf-8?B?RzFQYWJUUDNRMy9lZ1hYRDluOFgzWXBNY0lQM0Y1bUpSYkp5K0RXRHhtdysr?=
 =?utf-8?B?TExwZU1NWElUaWs0K05oNzBSckRKMTBKN2hIeUdCWUpmbld6V2NUWXcxZkxQ?=
 =?utf-8?B?cVRYY25XcVdCMnRiS1VxNmxLTm1SdUEwL215aW8xK0NWaTNHRDJBcnFlV1Ba?=
 =?utf-8?B?aEd6OXVZa2wrVEtIZGxNQjBpV3A4Yy9ZalFGa05LOEozaysyd0VQWDJBOXN6?=
 =?utf-8?B?VzZ5bFJmeFRzOTRDbjRZTXBHSU9oMWVkVHJZODdhK1BrSEd0by9oUkdLaTRI?=
 =?utf-8?B?WlRFSDZYQzJYTUlZYUdUbjA5K1hvTjlLd2lJa3MyajNvZGRwcE45R21oVEFP?=
 =?utf-8?B?Rm92Y0ppTENTa0RSNHNINk9yU2VyYk1GMndVMGpYNFcvblArVGdHQ1orWkth?=
 =?utf-8?B?U0RqQVNRekZkQUhoOU5JbFJMcUVTR0lTdHBCMTRib01GU0FrN3RkejhWNzFL?=
 =?utf-8?B?L1lxOHg0Tm54N0VSSXVzYXZCc01XMzIwOG8zM1N0TUN2eG8vK09ENXZRdUtk?=
 =?utf-8?B?c0xNVXlXM3d5L3MyWXpBTkFRRDE5bkRuNW9MOTZFYjVkbHZZM0R5M1U4TGl6?=
 =?utf-8?B?Y2dOQmdQL0hHbWpNM0NYdTJxbzlKMjJPTWJLM0huVWtxN2FCbVB3RzRwZCtC?=
 =?utf-8?B?WDIxNFAvRWVuWHVPM1dDTmVJeCtaaFZIKzFBeFVJWGxxUEFlTXZtb0lMczlI?=
 =?utf-8?B?V0F1dTB5WmR5MzFPditrRVc3MUNjbXhsT3I0UytzdGdWUmxZdWJKUkh0WEtj?=
 =?utf-8?B?Wm9XZkxwNTl0dE1HWnd2S0lSRGVaTzUzUlpjWlFHajRMUkZ3M1ZMOGt5V3lL?=
 =?utf-8?B?eHZCK3BoN3pSYnkwQkp6R3RUb3FvRTlJTk1MT0REeUVMMVo3WmYxUDloTHVM?=
 =?utf-8?B?bExRdjNoQTJOL1RBUTZIQUQvVFFQU2Rrd1lxL1BFblZZT3FBN25RaGVDVmJE?=
 =?utf-8?B?bnNDTm1rc3pwMFVtcTQ1OGwxVmF4d0tKZHBSZFVEOFVEY25QR2kvWHRPUTU4?=
 =?utf-8?B?VEE2V3IwaVdIaDIvb2Z1WHVBSHVWKzBOWkcxOFFyOHhQRkhuM3N6dTVpRFRE?=
 =?utf-8?B?S0lCOVo1Yzd0SHJ2MFk1dytwQXdKTE1PUmRncTl4Tmg0SjRUWmdST1dGQTY1?=
 =?utf-8?B?QmhtaE5MaC9lZmJ4ei9YUjF4dU1FZUdQbmx1RnlWK1JWU0hacWlwbXFPZDJh?=
 =?utf-8?B?MTN6aWlGd1dlNmFHOUtPVHMvWkNWd2tLTm9ZQzhoaGdqVGQ4UVQwdXp6QTNZ?=
 =?utf-8?B?MDQweHRTTWVNWVF4UkRSNmpvWThYUnZaUjdGWjZtWjJreUN2NkVyRGYzc3Q3?=
 =?utf-8?B?bXJ1bjBHS0k3aEtGMDNLZFdpd1FjNjBuTldncFBvWVpmQ3NNSGlvWmJITXl2?=
 =?utf-8?B?VWNDVUU2Tit2c3RCWFVTSGtpZWJmNGJRSTV0UjhYdDkwL2dITTJzbU5YVzJI?=
 =?utf-8?B?UmtGY09vT2ZNMHNkQk5VUVdoRTVBZlhYcVQ2VU4xN2EyTnlvc0FoU3piZ0VQ?=
 =?utf-8?B?KzhHbUFJcGI4Ui9WZzY5d1ozeFlYM3hLL3NuaWhSamNtODFsV1VLZXY4MEpP?=
 =?utf-8?B?YndGNkRzQXF1UEkraDFSSVhqanpyck91bjQ0WGhCb0E2WjdpWUVlY2V2Wm12?=
 =?utf-8?B?SnNPUFNPcSsyZ2ZVL2w3VTduaXh0RE9XTjN4ZVBPREtoNUJTZ0xwb3JPVWVW?=
 =?utf-8?Q?yA9o3CZ4spcti7aEdsiXRmoWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e4bdb-efae-4ec4-af11-08da6e4e95b0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 15:01:42.6109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W6zfvp1jdxaYTZJts9UOffwAa4zbxTiVQBXbJwSsvDw9CXL/ltO8No8SCiGwzK8wiQytED2mlR4fRadVQ3TGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1565
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

Am 2022-07-25 um 08:23 schrieb Philip Yang:
> To support SVM range VRAM overcommitment, TTM should be able to evict
> svm bo of same process to system memory, to get space to alloc new svm
> bo.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 1d0dbff87d3f..e8bb32f4ca14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -159,11 +159,14 @@ static void amdkfd_fence_release(struct dma_fence *f)
>   }
>   
>   /**
> - * amdkfd_fence_check_mm - Check if @mm is same as that of the fence @f
> - *  if same return TRUE else return FALSE.
> + * amdkfd_fence_check_mm

I think we still need a brief description here. How about "Check whether 
to prevent eviction of @f by @mm".

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>    *
>    * @f: [IN] fence
>    * @mm: [IN] mm that needs to be verified
> + *
> + * Check if @mm is same as that of the fence @f, if same return TRUE else
> + * return FALSE.
> + * For svm bo, which support vram overcommitment, always return FALSE.
>    */
>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>   {
> @@ -171,7 +174,7 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>   
>   	if (!fence)
>   		return false;
> -	else if (fence->mm == mm)
> +	else if (fence->mm == mm  && !fence->svm_bo)
>   		return true;
>   
>   	return false;
