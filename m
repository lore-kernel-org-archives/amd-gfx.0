Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC92EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 16:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110F910E07A;
	Thu,  3 Aug 2023 16:01:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AFF10E07A
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 16:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhw899k1DV/NylGk5yO4K9bKPwjrt7I5Y6aEHH5lgw8ZswSFyyPWRx6umwXkhCHZbeKJnvJKeiOBVG0cl653kXQhISGStZRfpCbliDVHcEJ06CN+HJwPnF7G/SZCmX8GqkGT27mc4dKjFzgRo7yNgEIt3Xwz0nXvVOCLFfEA/70gA+4F3JNlu7tj5/nP1FFrqKndoqk9Kcg0iXRpHJ6hevYJBXWggjJmfy8b2xyxZ+wTsV6GfZ4NnQcGaptbs+yVZ0bnbtFaDTXTYA7DWrgbgWUZKHWByN679qAf2f3iI6t2LUPct2XXBtD1PYY/fU/HzMHsl8NgIPwS0sW0Oqwd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0Z8Ipy3sp63o/Bnlpjv8fuZXGCix8kKfQmhmvjYGS8=;
 b=ZdJhRmwj/vXb3rNxkr8XwMgc4vAA+bJt+cS3VKE4qf+N2ZdCYi3thXpOgp6HSDoU4vbCVaDSiP55JX5T7d83YgXIH1eOA0IJDk1D+F9EMewJjcSYVfmCc7+wu8nOdeXItPoq5PRc9xINM5XiE0cZLUjZjAm426yejo9WzxmAuP6asYHa/XQirSX3E8l7H6+YDKCUoyH+vPJ4zU5V1VAB+Qs0zm/rwFudBiysbSxrcNygQj2p5wCEGxXgxP5SGdA92EyOX1CtEKz9anwG5qAkqX49ZgzatyD51R3rpqUq1ULB/PK0VifzPfbRBKO3i3KNDRB34ARYJ4Mx6IBzGQF1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0Z8Ipy3sp63o/Bnlpjv8fuZXGCix8kKfQmhmvjYGS8=;
 b=bDJrU3KkCEDW+Y8UqPyy8O4Mn4A57MQ4IxYezGo7zkc6NA0TdHNEgT+yeWXs1hc+UBqZCwewFSc6l8Hq7L5UnkMG/uxCrxEz4wS/8U+nAAkDl6bt9pLEz9xm1c+yQnO/2hYMIHqaNjVWWnbRqCAhwbDGHDLh45Ny3lORsu+F8Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 16:01:19 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6787:e196:b8dc:93a1]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6787:e196:b8dc:93a1%7]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 16:01:19 +0000
Content-Type: multipart/alternative;
 boundary="------------YxtWHs1wbHuJuqHAytu87sdC"
Message-ID: <b1e37050-9165-df2e-c621-f6f3b368d98e@amd.com>
Date: Thu, 3 Aug 2023 21:31:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: add support to create large TMR BO for APU
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230801073832.2133509-1-Lang.Yu@amd.com>
 <DM6PR12MB42503F416BD78E9163666A90FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <DM6PR12MB42503F416BD78E9163666A90FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9bf995-d6d3-4798-ab64-08db943adfde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrwe0WJPmVJPL/KCuaoYYjpyIRvssxW6p74FH95Vzy1hABU+etHlEUs8vhMl26/wLxvZUkntRoMQ9Z1kdybMNKM8uv8H/JFXw61I5WHepoUlz2pUKeMoTh8Aa3cUCH3E1ZcFWQFlTj8PIZhJ1/tTqoMvGU1eHvtw4eMtYCuTq2nAvTqfHNlyVyoBj2NEb+DrNai21hgvs6JmgJMFWKatPMS3udZjIn3phWcSqcqAwvPmtgu3ZUiwDHCt9124xHlUagPsJGqZqyjVc0DmoeRb2sBLJ5tEja3tsInq41Iq/EXtdJitze157wmFBknlwZhT7oCebD3/t8fIkyTpoIyd90LViHbJeXqbT+trqBbcdl7SBy5yEzL/MxYjyry8lIX2/U8YJxTMpBudKY8iVdayoTagT6CgXVAAFKKgtuW4D1qVSsiEuSHvyF8rafxGAo4Zz+6sU+/afTzbk0POO+GP1SHPenqdeyiwsBTADQ1ApWZrR675hDlgX+LJ+YZU3lklUdWZHSZgJcWeqYFvOquFD4usswPK9PREr9pNGce6ggli5TPdhpm4tgPB7p7FDcMtMmvG/BTIpi61Mf5G0alFGiiMnlwFtcRVV5SlICw5hwTOkbhq5vzl8B2A/3s8/udwSJmVF7/w7E13ZlF98t1XMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(53546011)(186003)(26005)(6506007)(2616005)(31696002)(38100700002)(86362001)(316002)(6666004)(478600001)(110136005)(6512007)(6486002)(33964004)(54906003)(36756003)(4326008)(66946007)(66556008)(66476007)(31686004)(2906002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3puZzc4dGt2VWllREhPMEplb0tKUWwrZDBtMk53NEE2TXU1UWlkMXJIdVpQ?=
 =?utf-8?B?dkNzQk82b2lRZlZtZFRSeFA0V0NRbVFzTGJadjM2UzI4NTUvczNPWXhhU0ts?=
 =?utf-8?B?SGNtYkVYL2tVd1hmNWhpa3QxY3dMVC9PV2VtTlNsemZIT3U4ZUZiWFp5UUxD?=
 =?utf-8?B?WjVOU0JTWGZQUkNJMUFNSDViRXluSHY0Q2FJRmRtMms0UjZTYllvb3V6cm1G?=
 =?utf-8?B?T281MC95NzFHODFRTi82T2NjK29VZ0haOXY3aU5YNHh2a0JpV1JidDdGRTBt?=
 =?utf-8?B?QWZUbENVMDM1RFNRWFVxdlc2QUE3KzhENUZ1SGVONndCMDZtZHV3eDRQRytY?=
 =?utf-8?B?NG5VL0wvTkRrUDJGRngvMDdkaXowSWx0YTJoSFNaZ1J3WkNyZXozRGlrVUhk?=
 =?utf-8?B?dXp6REl5aCtpeU5sZU5qK3VKQkhlV2JNaHlNbW5PaVJ0SitWbzZBajlOQTZY?=
 =?utf-8?B?Y0drK0VMbk40L2tVT2lCRlU4cDh6ZEJocDhCVW5XU1l1VnV1Z1RwM2dFWFdv?=
 =?utf-8?B?ZThPVjZRVjgrVkk0Zk5PSURneXZVRWpyelBUWFV4T3l0MjZlNUZBV2xzUzIv?=
 =?utf-8?B?UGMrOFRiSDREZmR6NDk0UFZkVlZhbG8zVHZNdVdza1Y1NG5rbXRUNkp3UUF3?=
 =?utf-8?B?TlZyelF2NFkzRG5SQzc2RmZaWFE2UTdvdmo5djdvemwvdHhjbDVpTnlwZ0tu?=
 =?utf-8?B?ODg2Yjk0WUtGbXBCSFZ1TEpSNjBkamJ4TFQ3V3hHYy85bWVMQndmRTQzYkkz?=
 =?utf-8?B?WDFobEhGSDFsZ01aaWpYUHd0YXAvSVlGM3JiMzBpeitDK0FyZ2c1ZTVRdGkw?=
 =?utf-8?B?aUduRUQ0OU45OHBtemRYellLalhxbm54YmFsUXNZU3Q3S2U0MC9FWW9pQ3gy?=
 =?utf-8?B?WTBMNUtUS2lSbUo0MGVmQWFTZVdWWmtYdGQ0QmM3UGozYTJZK3Y1UlNtRVVj?=
 =?utf-8?B?Uy9IUVV6Z0dieUNVdk5XbkdMeU5yTC83bTVBbVVLZ3FnQ2pLck9ld2JmOGZh?=
 =?utf-8?B?bGlCV0ZoM0VjcUVxeGQyalZRbGw3d3p4QWJuNFRVeEFqS1hhYXN5My8rMVVw?=
 =?utf-8?B?Tkp4c3pKY3lEc2dyeC9XcU1Hc3pSbytYTHdReCtMK0VUakRhUGZJWnVUU2hT?=
 =?utf-8?B?Um15M3pSQUVBOEY2cW1BanZFRVltdDZwTGk1WHRxQ1lhQ01rQnRJclpDZXpP?=
 =?utf-8?B?akhIVHhMWWtGSEF6WnhxSUdET0Z6S2NOV2NQM0Q3Znl3dHBmc0MvV05BdHFm?=
 =?utf-8?B?N3V2MWxkcS9pRktVWnFqOGhCcnhpbVpFK0FYd3RMZnhnYWVtNmN6ZFZoQ0Mw?=
 =?utf-8?B?S0Y0VnZHZDFEZ2p1ZTc5MDFzZmVsUnRzeTkySjJpZkhKTTVzVU44WmZWSUJ5?=
 =?utf-8?B?MEJqUFIycENGd2NST0k1MjNPTzloaFM1eUtZK0ZlaWVaSU5SaDVkcTEwY2lM?=
 =?utf-8?B?V3NBUzZwVThkVjAyTTcvQ0lsRFMyQmhNeWZRS0U4TFc5b1oyYzFwemRmZGhv?=
 =?utf-8?B?MlpneGQrWE9Sam8xeU9IcEE5Tk5lUjE3TzJJUlkrRFRDTHBCMDZGOHBKQzRs?=
 =?utf-8?B?Znd6c016MndEaUc2RStoVlJ1NHhUUjJaRTFYUmRQRkdKYTZZRHpCS1NmMVp5?=
 =?utf-8?B?NDgxZTNyQ0RSSGlVajM0VlpWb0Y3aVNhTW9aQ3ZUMVAyVlVHclNRdldpcXhE?=
 =?utf-8?B?VjdNMngrd24wU0dlRTh3SWdYSTFKcmVlZjFaZklNMUdOM2FzZVV0TTk0NWRT?=
 =?utf-8?B?d3JVa1ptZllnalJQYUg0aXA2QmdXSG9WTmkxQ3dqdTNiR0FEamE1Z3BId045?=
 =?utf-8?B?Rmt5RnpBWTN4NjR0QjVMSnRjMjBVbTNLU1BWNmQwQkhlQ0RISzdqWG5iTmZG?=
 =?utf-8?B?bXE2Q2s2cTdlVkRQSGIrZkVqRUhmaGJ1L05obDRTajNvbDNtSzBrcmJNbWc2?=
 =?utf-8?B?QkxZYkJBOFJDbm0yU3c2QTdYL280dlNSbHhzUk1XUTlLSFhDYkh2RVMwWS9H?=
 =?utf-8?B?dU9KS0kxUVdQU3dtQlpxNW0yMXlXV3NUYjdLcG9HbVd5VGU4Y2F6cGRnWjlC?=
 =?utf-8?B?YnlSRG5vQ2FmaWdhZDMwK05CZ1R0TnFHVzJhVDFmdGJoQVJHZ1JCWHhIM1Bp?=
 =?utf-8?Q?cX22z60zS0k4Ez3Qvzr9RK3sP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9bf995-d6d3-4798-ab64-08db943adfde
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:01:18.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs795EyswEvmP+I0byyttRhbBFVhUmn/fC7vbQr0opRiF+KxqCOJPRnG0SeDUrPnWMTiidzg8RcNo9yYAGZIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------YxtWHs1wbHuJuqHAytu87sdC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lang,
This is not the right method to allocate memory if you dont have a 
specific offset for TMR. I will send a patch for your testing in drm buddy
which could fix this problem.

Regards,
Arun.

On 8/3/2023 8:58 PM, Yu, Lang wrote:
>
> [Public]
>
>
> Ping
> ------------------------------------------------------------------------
> *发件人:* Yu, Lang <Lang.Yu@amd.com>
> *发送时间:* Tuesday, August 1, 2023 3:38:32 PM
> *收件人:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *抄送:* Koenig, Christian <Christian.Koenig@amd.com>; Paneer Selvam, 
> Arunpravin <Arunpravin.PaneerSelvam@amd.com>; Zhang, Yifan 
> <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> *主题:* [PATCH] drm/amdgpu: add support to create large TMR BO for APU
> TMR requires physical contiguous memory, amdgpu_bo_create_kernel()
> can't satisfy large(>128MB) physical contiguous memory allocation
> request with default 512MB VRAM on APU.
>
> When requested TMR size > 128MB, use amdgpu_bo_create_kernel_at()
> to create the BO at offset 32MB with a step 1MB in the VRAM range.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 15217e33b51d..3fadfaa63b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -783,6 +783,34 @@ static bool psp_boottime_tmr(struct psp_context *psp)
>          }
>  }
>
> +static int psp_create_large_tmr_bo_for_apu(struct psp_context *psp,
> +                                          int tmr_size,
> +                                          void **cpu_addr)
> +{
> +       struct amdgpu_vram_mgr *mgr = &psp->adev->mman.vram_mgr;
> +       uint32_t rounded_size = round_up(tmr_size, 0x100000);
> +       uint32_t start = 0x2000000;
> +       uint32_t step = 0x100000;
> +       int ret = -ENOMEM;
> +
> +       for (; start + rounded_size <= mgr->manager.size &&
> +            start + step <= mgr->manager.size; start += step) {
> +
> +               ret = amdgpu_bo_create_kernel_at(psp->adev, start, 
> tmr_size,
> + &psp->tmr_bo, cpu_addr);
> +               if (ret == -ENOMEM)
> +                       continue;
> +               if (ret)
> +                       return ret;
> +
> +               psp->tmr_mc_addr = amdgpu_bo_gpu_offset(psp->tmr_bo);
> +
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  /* Set up Trusted Memory Region */
>  static int psp_tmr_init(struct psp_context *psp)
>  {
> @@ -813,8 +841,13 @@ static int psp_tmr_init(struct psp_context *psp)
>                  }
>          }
>
> -       if (!psp->tmr_bo) {
> -               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> +       if (psp->tmr_bo)
> +               return 0;
> +
> +       pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> +       if (psp->adev->flags & AMD_IS_APU && tmr_size > 0x8000000)
> +               ret = psp_create_large_tmr_bo_for_apu(psp, tmr_size, 
> pptr);
> +       else
>                  ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
> PSP_TMR_ALIGNMENT,
> AMDGPU_HAS_VRAM(psp->adev) ?
> @@ -822,7 +855,6 @@ static int psp_tmr_init(struct psp_context *psp)
> AMDGPU_GEM_DOMAIN_GTT,
> &psp->tmr_bo, &psp->tmr_mc_addr,
>                                                pptr);
> -       }
>
>          return ret;
>  }
> -- 
> 2.25.1
>

--------------YxtWHs1wbHuJuqHAytu87sdC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Lang,<br>
    This is not the right method to allocate memory if you dont have a
    specific offset for TMR. I will send a patch for your testing in drm
    buddy<br>
    which could fix this problem.<br>
    <br>
    Regards,<br>
    Arun.<br>
    <br>
    <div class="moz-cite-prefix">On 8/3/2023 8:58 PM, Yu, Lang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB42503F416BD78E9163666A90FB08A@DM6PR12MB4250.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div dir="ltr">
          <div>
            <div>
              <div dir="ltr">Ping</div>
            </div>
          </div>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>发件人:</b> Yu,
            Lang <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a><br>
            <b>发送时间:</b> Tuesday, August 1, 2023 3:38:32 PM<br>
            <b>收件人:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>抄送:</b> Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Paneer Selvam, Arunpravin
            <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>; Zhang, Yifan
            <a class="moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com">&lt;Yifan1.Zhang@amd.com&gt;</a>; Yu, Lang
            <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a><br>
            <b>主题:</b> [PATCH] drm/amdgpu: add support to create large
            TMR BO for APU</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">TMR requires physical contiguous
                memory, amdgpu_bo_create_kernel()<br>
                can't satisfy large(&gt;128MB) physical contiguous
                memory allocation<br>
                request with default 512MB VRAM on APU.<br>
                <br>
                When requested TMR size &gt; 128MB, use
                amdgpu_bo_create_kernel_at()<br>
                to create the BO at offset 32MB with a step 1MB in the
                VRAM range.<br>
                <br>
                Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38
                +++++++++++++++++++++++--<br>
                &nbsp;1 file changed, 35 insertions(+), 3 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
                index 15217e33b51d..3fadfaa63b2e 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
                @@ -783,6 +783,34 @@ static bool psp_boottime_tmr(struct
                psp_context *psp)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;}<br>
                &nbsp;<br>
                +static int psp_create_large_tmr_bo_for_apu(struct
                psp_context *psp,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmr_size,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void
                **cpu_addr)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr *mgr =
                &amp;psp-&gt;adev-&gt;mman.vram_mgr;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rounded_size = round_up(tmr_size,
                0x100000);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start = 0x2000000;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t step = 0x100000;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret = -ENOMEM;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; start + rounded_size &lt;=
                mgr-&gt;manager.size &amp;&amp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start + step &lt;= mgr-&gt;manager.size;
                start += step) {<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
                amdgpu_bo_create_kernel_at(psp-&gt;adev, start,
                tmr_size,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &amp;psp-&gt;tmr_bo, cpu_addr);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == -ENOMEM)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;tmr_mc_addr =
                amdgpu_bo_gpu_offset(psp-&gt;tmr_bo);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                +}<br>
                +<br>
                &nbsp;/* Set up Trusted Memory Region */<br>
                &nbsp;static int psp_tmr_init(struct psp_context *psp)<br>
                &nbsp;{<br>
                @@ -813,8 +841,13 @@ static int psp_tmr_init(struct
                psp_context *psp)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;tmr_bo) {<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr = amdgpu_sriov_vf(psp-&gt;adev) ?
                &amp;tmr_buf : NULL;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;tmr_bo)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr = amdgpu_sriov_vf(psp-&gt;adev) ?
                &amp;tmr_buf : NULL;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;flags &amp; AMD_IS_APU
                &amp;&amp; tmr_size &gt; 0x8000000)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
                psp_create_large_tmr_bo_for_apu(psp, tmr_size, pptr);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
                amdgpu_bo_create_kernel(psp-&gt;adev, tmr_size,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                PSP_TMR_ALIGNMENT,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                AMDGPU_HAS_VRAM(psp-&gt;adev) ?<br>
                @@ -822,7 +855,6 @@ static int psp_tmr_init(struct
                psp_context *psp)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                AMDGPU_GEM_DOMAIN_GTT,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &amp;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                &nbsp;}<br>
                -- <br>
                2.25.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------YxtWHs1wbHuJuqHAytu87sdC--
