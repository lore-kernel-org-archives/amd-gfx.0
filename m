Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC3ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 11:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0BE10E03C;
	Fri,  9 Sep 2022 11:46:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0911310E02E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 11:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEwu7BUc9SuIQyi+MN2uXQkLEywvzGIivvtdyxA9kU1WJ+HF32pJQRzup5KC/DPwQDYs8r1faF8d03dfSX1vgkQETnUxye/D+2Qs5d3uO4aOPjyIhq9BL3zUNcvqXR7IgG+ejSQVh8+BzSqQ6Z+gMoTfBDUm1NWszvGs0YniIvk7ghJkCOwaJm2zzxweXaCuvZIh1/iOyeRtP3BlWC+sn1MdkTu1FInPkMfzUYgj50BkgFGv4qDkmWJaxRBf4yrGusN9XA0Dk0CW72vaImm4nAUp0Qbt1n7Ox4zuk8vZkhbVNI3Delh29hpVMMHf+g3dQSdHTpr5MPCv7562vItCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUSGb8I7Im9TlQHhpjlqOtMTYosG7OfLzbqduova/No=;
 b=DXieTIZcsuTFVkS5wY4oerRF6szDVqD/wsypjaI2FPvFUrAXYkvgrNzlSC+B/VvT+b+GZzMDFW80VfTQrk7vMyLKYebbhM/M6nIiyI/+gksCgsNwFrqZtb90koocKy2FC+dDkdmV5Pg2nIz24ZkmnUIRrGy5FyA8toz6smmC179e97cjABF7GzPL2NP76TL7VoxmbyF2QW3P+ueMFaXhNErV7WUcPhJ81zG5zHlUiCwAKjFI4CAV++aC9/PjzdNwfnUHbocPoPN6G4lo3j/dyCxiTxtwvD8i09xIazZXdXWM6gxHPxqYQYKOWRpD94IOJ1pIsQ4JNFM4obJtYgswSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUSGb8I7Im9TlQHhpjlqOtMTYosG7OfLzbqduova/No=;
 b=xs8mGQYg9V6rFpucN1JZ1uQyD3cmxcvaKF0Ppv5z5kk9MQ6gRqX6NhYh4Z3vW4yedOS2dOw/1lFjM2Dd9WcE/K0scefcsBe5Se5TmA/Jx9F6IEyM6b7vfnzND1UF2DB+ykduXu++gmIeRriO3/gvHVoZqDvwDh1BGdGd9DZA334=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 11:45:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 11:45:47 +0000
Content-Type: multipart/alternative;
 boundary="------------YepHfq00MakVcAR3DDFN5yUI"
Message-ID: <95d848b8-45a3-468c-6e08-47466e62a584@amd.com>
Date: Fri, 9 Sep 2022 13:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/amdgpu: change the alignment size of TMR BO to 1M
Content-Language: en-US
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220909034948.3647700-1-KevinYang.Wang@amd.com>
 <BN9PR12MB52579A7D564E0DA5CE50184CFC439@BN9PR12MB5257.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <BN9PR12MB52579A7D564E0DA5CE50184CFC439@BN9PR12MB5257.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4fb550-71d9-4657-290a-08da9258d63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqYNsSBunYi+7qswHANbBQi7GqR2wkEOYtVMg2NE+NZVQ7AF2uJGcsjAIQsfqW7Z9aQrLOLe5ZDVLxtjM7nCnZIZziHIMpTq1crRQn5yInWyer/eXBsWXQNCSTdLp5CUgEe1mjbeazJMgid94pkAk1bScuhNFRzOROTGOkvp5xp4u54vH9FA5k/se3oiXzP26c/7owAcrh0xiKVCNp8vF8XlkaHw4CZv9JKuD6EmKL6Q+MPBaH34fEXnVvB7AMBJfaV5aZ1b2OttgmFv/+dpuNlqv6XMjPRkMvlyk/yWCvYLH0yP+itVJQ8ilyeWHlPA3nLK+0LMWb5sJ+ssuaEoNV9Kxzvgvl8eel+6gZgpU8AjCM8HXW/sKtLN4Ubio3lBDsyIlq5iLYGq7NSaNkZOqp23uFYaESeNHTrDPkb8NV9iEKQaxAgAoz4oQQvq6bEewj+KcdrchQPILBDlQ8QTQPZbF3S0nBb3/ZfSXRb6s6f+TJ8O3Z2uQ4fObOaTIlVHLA/hzlac7X9lfQpV7tKTcj3SRgg2JLSQbUghuQZKPp+69bADXlw0GAV4Egp1HCWlFKlhDm+mplV9N5dXN9iM9CSFFSx8ducH8XTYJ/bfbUFcQWHPLx7XZ8uupL2lgCGNEaemn/CInatUiQG7qzEXUDPzl0wpyQD4crg3UkE6QaY3Lf4MHEdPFgudGnVPkdKDiSG4ptRe3p0zrFIjUoMbNp4LWjTtVblb58oM/JAPQXG2cyMnjZLnxRlvzNccwN2XenS0wqtOl21393fxuoSIBp51fiomsVyLzmlMZBcIDvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(38100700002)(186003)(66556008)(66476007)(66946007)(31686004)(8676002)(83380400001)(2616005)(5660300002)(2906002)(86362001)(8936002)(31696002)(110136005)(316002)(41300700001)(6666004)(53546011)(6506007)(33964004)(6512007)(478600001)(6486002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3l6V1FaL0FFQ1RyczYzSUJpVGhMeWVKSTIxb1JQQ1NWNjB1UWlqcTJzcFRB?=
 =?utf-8?B?VTBvUXRCeUVCV0ViT21RakNqeHBJYk1Ja29QSUkwRlp1cnVGcGZCcXNLckZk?=
 =?utf-8?B?Uml2M2dLTEFnZ2M2enNweTRvdGZURzhhYnBSYWhOQ0c1NEJWSVFHdkc1d2VH?=
 =?utf-8?B?Vzdob0x1Y2tYNkMvMk1nbURZWUsrekhHSElHenVQekJBZUR3QWhTSjJueTlm?=
 =?utf-8?B?MTNhR3dIUCtRUkJEZVNHdEQ3anQ2c29PWG8rQVZKVHVPdjNWcmJnNUFIbWVT?=
 =?utf-8?B?cFBhU1dhTDl6UjlEblFsZG9lNTVyNVVIbTFHc2paMVRzczBzb0IxR2cvQmNG?=
 =?utf-8?B?aFliRjFpZG9ETGQ2aDZqdGtuNFEyOU1weTZVc0JWaEQ1V2hsU1NQZXNWRmhS?=
 =?utf-8?B?eCtkZkxMbkUyNnZZdFhLK08xUndLT2VvYnlmbXpLaFRPVGc3dDd1VDlXS3pu?=
 =?utf-8?B?TFBFdnJzRzhHSlczcld4ODQydEFyVVlnOFZFN3NVVk9FNk5XQVhwZzl0andr?=
 =?utf-8?B?SnpOSCtOZlpjMnRRNTJKVmdUS3pDa0dCQ3dVakRsKy9aUDFVQmcrM2FYRGo1?=
 =?utf-8?B?THF3RnRoNG5jNjc2d1BBYyt0dTh5M1Bxb0dpMzNtamdyZWZsWFlUUTFrS0tL?=
 =?utf-8?B?eGN3TGhIOTJNejBUWWxQOUZqRzIvTVZrOGhLelVHVlNmRkZpV3AxN2ZSYmkw?=
 =?utf-8?B?UG4wTEo3N21uTjdLa2pMZDdFbE9EVWlRanZUT1puSDVJNkUzVnRXOGkvbC9J?=
 =?utf-8?B?ajRSdHpvRzJDM0tON3JQUDFJWndoaWxvQ1Nrb1MrWjZZUWc0d0pocUpsYWFO?=
 =?utf-8?B?Rk8yWTQwVWF0RUlsT0pOUS9rMmthZEc5Nk03M3hTblNlcXNEV1lRMHpQZk1Z?=
 =?utf-8?B?TmVSc1pwblg4aVQ4MW1XMFl6bW5KNXRUMUJPRTFZMFR1SEpRRGVueDMrWE5I?=
 =?utf-8?B?dmtsckt0N2NkNGpNWnVGeDVCQ0JWZEMweWNOSHhIdzF1NXo2YjdieXRTMGpx?=
 =?utf-8?B?T0ZBR1REZ1haR1MzMFVHRC9oVEtWTGxGSStFbmlNVTdhbUpFbDdIczZmTThB?=
 =?utf-8?B?bG5JUFlBbVF2QWRrVWVJby9FNm9PSzAvdVJuR0RtNEJoKzc5T2ZmbHlQd0lZ?=
 =?utf-8?B?WFdUY2czNWRJUmwyUWs3ODU2QkdVeENJUVNyKzV2TGpoc09NZDJqbTJIczBu?=
 =?utf-8?B?SzJVcWRmbDYwaDNnMmV0THFWL3pSLzFSaGhaVWF4dnNNSEpLSFYwWTB4NVFW?=
 =?utf-8?B?Z3dGcGVtcXB5elZxa3NSMkw4L3J1ejV0UnBNbzBDU2c0YWZBU0xtUHZTU1lN?=
 =?utf-8?B?b2lUVHI3aTZCKzBoSWFxczZmRkhKaEI3VGZkT3B4ZFNLUll0OHFkOHY4Z1Ns?=
 =?utf-8?B?a0xUa2RKY0YwaHJwUXYwVy9GSEdIVm5rRFFyd0ZaUndPdXRMY2xXVUJwTUd3?=
 =?utf-8?B?bXQxY3dWN0ZJMmVvZytPRUc4TWNoTXhyeER5YUJKQVR1R1ZIeTB4UTU0Nks1?=
 =?utf-8?B?SzdKVXY1MjhzZmZJR2g1T0VvaThZaTBBOEhlekVWanNjeTU5dmRNbmlGMldz?=
 =?utf-8?B?TXllbERIRjhFU2lJWDUwdmEwK0N1ZmpaTFFvcW5JTEJMOTcySUdRb1dNdmZo?=
 =?utf-8?B?ZStEUmVyUjRHRTROSnR5aUxXdzJsTGhZY2t3Nk5lSWpDc1R1R09FYnEvdzhx?=
 =?utf-8?B?Q1NPdUpuKzQyQWZXbEhLYW9PSEFSNEljRVV4NzgrSVp5ZHlhVUJuR2dsT1ZC?=
 =?utf-8?B?eVQzemJWTmVzQXhrNndpMmNmdXRGSkJjMURlV1BTY0R5QnFydHBVOTg2Y0JO?=
 =?utf-8?B?ZEhkeFZWY2dVSkdqaG1DOFRzRUVTYi90SnF3c3d0T3hWRTY5S1p6eVo4Q01x?=
 =?utf-8?B?MGNqWERMSHY0cEp0eUNKb2lYdkFCbUttWWgyVEt6ckZNdENSN1BiZy9hUVpq?=
 =?utf-8?B?VjlGY1NMelZlbWxGY1crNDBwZUNzS0k1MWV0MmIxUHc3MUxtbklBWWszeGM1?=
 =?utf-8?B?Q1JtV3R1NlR3MGx3MmNlUWhRVGFJYW5ySG8xdXlNam02UXNLSGFFRnc2aktt?=
 =?utf-8?B?T3JlWnlod3NRVFloc3hDeCtkSEptdk9TUTRsYk9nSUJLcEZNelNSVWxRdDRJ?=
 =?utf-8?B?b0Qxa2h1Y2pmVStoelhOWWtEN2tYbXU4Q05OKzFabnRVbi9qUysxMHBwTTFN?=
 =?utf-8?Q?VufQlHVKM9mMJzwVHKcW7cF7SsIuCA089uu3z2ww2l9T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4fb550-71d9-4657-290a-08da9258d63f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 11:45:47.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zP7VNHWpMDzNlTpu/dbP1JhtvwtV2+8C4gicTtEh35Av3kuLvVqZoITT6w6MvKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

--------------YepHfq00MakVcAR3DDFN5yUI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

1MiB still sounds like quite a lot. Is that really the hardware requirement?

On the other hand feel free to add my acked-by since it is certainly an 
improvement.

Christian.

Am 09.09.22 um 05:51 schrieb Zhang, Hawking:
>
> [AMD Official Use Only - General]
>
>
> Thanks Kevin!
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
>
> *From: *Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> *Date: *Friday, September 9, 2022 at 11:50
> *To: *amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhang, Hawking <Hawking.Zhang@amd.com>, Wang, Yang(Kevin) 
> <KevinYang.Wang@amd.com>
> *Subject: *[PATCH v3] drm/amdgpu: change the alignment size of TMR BO 
> to 1M
>
> align TMR BO size TO tmr size is not necessary,
> modify the size to 1M to avoid re-create BO fail
> when serious VRAM fragmentation.
>
> v2:
> add new macro PSP_TMR_ALIGNMENT for TMR BO alignment size
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index cfcaf890a6a1..e430a3142310 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
>          }
>
>          pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> -       ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, 
> PSP_TMR_SIZE(psp->adev),
> +       ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, 
> PSP_TMR_ALIGNMENT,
> AMDGPU_GEM_DOMAIN_VRAM,
> &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index c32b74bd970f..e593e8c2a54d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -36,6 +36,7 @@
>  #define PSP_CMD_BUFFER_SIZE     0x1000
>  #define PSP_1_MEG               0x100000
>  #define PSP_TMR_SIZE(adev)      ((adev)->asic_type == CHIP_ALDEBARAN 
> ? 0x800000 : 0x400000)
> +#define PSP_TMR_ALIGNMENT      0x100000
>  #define PSP_FW_NAME_LEN         0x24
>
>  enum psp_shared_mem_size {
> -- 
> 2.25.1
>

--------------YepHfq00MakVcAR3DDFN5yUI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    1MiB still sounds like quite a lot. Is that really the hardware
    requirement?<br>
    <br>
    On the other hand feel free to add my acked-by since it is certainly
    an improvement.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 09.09.22 um 05:51 schrieb Zhang,
      Hawking:<br>
    </div>
    <blockquote type="cite" cite="mid:BN9PR12MB52579A7D564E0DA5CE50184CFC439@BN9PR12MB5257.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt">Thanks
              Kevin!<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt">Reviewed-by:
              Hawking Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt">Regards,<br>
              Hawking<o:p></o:p></span></p>
          <div style="border:none;border-top:solid #B5C4DF
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal" style="margin-bottom:12.0pt"><b><span style="font-size:12.0pt;color:black">From:
                </span></b><span style="font-size:12.0pt;color:black">Wang,
                Yang(Kevin) <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a><br>
                <b>Date: </b>Friday, September 9, 2022 at 11:50<br>
                <b>To: </b><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                <b>Cc: </b>Zhang, Hawking
                <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>, Wang, Yang(Kevin)
                <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a><br>
                <b>Subject: </b>[PATCH v3] drm/amdgpu: change the
                alignment size of TMR BO to 1M<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span style="font-size:11.0pt">align TMR BO size TO tmr size
                is not necessary,<br>
                modify the size to 1M to avoid re-create BO fail<br>
                when serious VRAM fragmentation.<br>
                <br>
                v2:<br>
                add new macro PSP_TMR_ALIGNMENT for TMR BO alignment
                size<br>
                <br>
                Signed-off-by: Yang Wang <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +<br>
                &nbsp;2 files changed, 2 insertions(+), 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
                index cfcaf890a6a1..e430a3142310 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
                @@ -766,7 +766,7 @@ static int psp_tmr_init(struct
                psp_context *psp)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr = amdgpu_sriov_vf(psp-&gt;adev) ?
                &amp;tmr_buf : NULL;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_create_kernel(psp-&gt;adev,
                tmr_size, PSP_TMR_SIZE(psp-&gt;adev),<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_create_kernel(psp-&gt;adev,
                tmr_size, PSP_TMR_ALIGNMENT,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &amp;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
                &nbsp;<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
                index c32b74bd970f..e593e8c2a54d 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
                @@ -36,6 +36,7 @@<br>
                &nbsp;#define PSP_CMD_BUFFER_SIZE&nbsp;&nbsp;&nbsp;&nbsp; 0x1000<br>
                &nbsp;#define PSP_1_MEG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x100000<br>
                &nbsp;#define PSP_TMR_SIZE(adev)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;asic_type
                == CHIP_ALDEBARAN ? 0x800000 : 0x400000)<br>
                +#define PSP_TMR_ALIGNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x100000<br>
                &nbsp;#define PSP_FW_NAME_LEN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x24<br>
                &nbsp;<br>
                &nbsp;enum psp_shared_mem_size {<br>
                -- <br>
                2.25.1<o:p></o:p></span></p>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------YepHfq00MakVcAR3DDFN5yUI--
