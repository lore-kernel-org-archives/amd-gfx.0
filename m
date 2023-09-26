Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F26CE7A91
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 03:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DEC10E2A8;
	Tue, 26 Sep 2023 03:37:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2862410E2A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 03:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC2UPSz1CNW90TUzzKmpCeqLbYfl3P9AyEJeqmszDxYJIpZL9cG7y5uOUXIRbPRismWGRTz/T1C8jWAhUCdCiXN4Z7p4Rd/IqLjcZj6QMj+t16a1QBx4VO82evWESoo5HOB/u1UGq0xD5AruMzm2QxH8DUhNqh5hUYRj5RvF1prJpNQLsrmHaEq2qY3mPJxePct4/7re5thkqh96SrSOhpl/l0nnyhi3S8uaUXSVUKuN+gwgimie3x8/74bABqOKBWwyKpKu8uJwHBVDcTXRQnELBwoh31BqwLvmpxslUU057lVEN/vZhFg5YvDB4vcnwBb12bGg/s63eGFZkPxtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjOeJEi+5UPvC34rQhxyclYgSzlRH/rXeyczc0NftAk=;
 b=KiBp2lZIA++7xxO7yGkQx8srMXE8VouCaOPxECtbPkWwDQsOLa8jUoCInOsL88IgrG/hsqJqOvGWB2o8fPcLNLXxgaHmgIdJoNjqJOWwBUuWqiLZkO6ahKlqu1vLAq+04sSI1oBrkqHw4zRS1flqL0A6Ga16BkOg2va48daw33m9ysCLI4cDWaM21hR6mv75uTW+K+EF5CdRft6v/i06gJlLqVqPCrBN1d+BhLuOf/MFHBOfRG/6xgtCIwvFHtxKkNWGXJHefV9fs8ktpDRTTeas7wMgaAQRuUPLXCFcGx+twvt4GquHhBL/AMbD6JD9j7SoLb9OkMOYawbzxDRjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjOeJEi+5UPvC34rQhxyclYgSzlRH/rXeyczc0NftAk=;
 b=rePPZZk4rImOhYsr/1XDaypEa5ApNqmYHv/kCnOUiyZ1CMuWIhLRkmx/4WxvzribCkf0QZC5FM7wyamdmBZE1Lr7vdIsIYpkHC4+2cOdWmjQ5SqTSMuD5oAGm286qRSmITDIOznCHpngwqsiAfkjWIbz+U4d37ivqj7O5b3E/cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Tue, 26 Sep
 2023 03:37:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 03:37:45 +0000
Message-ID: <85b427f6-11ec-4249-bf6f-eadf9c375f88@amd.com>
Date: Mon, 25 Sep 2023 22:37:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer
 ASICs
To: "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230913171455.153412-1-mario.limonciello@amd.com>
 <20230913171455.153412-5-mario.limonciello@amd.com>
 <CH2PR12MB415257CDB87ED7EB3568F763FEC3A@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CH2PR12MB415257CDB87ED7EB3568F763FEC3A@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4994a698-bfc2-4332-2b10-08dbbe41f29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QU7StQTksm4Q791QY7ygfCqDoj3XbJWQZA7BwrN7ToqwZ7D9ZBT+08QnIToFX5IOXuGWmkxeo+yvvJmXNoHXtTCjc6ptZMa+lRDCkLrT1oJ6N/UZ4h2ut7ZyKZ6FPeClKoBOaEkNCCuWcFBGdOx/E6xwt86VdNPP4VG9GEeEmmaNwSUDkNraILVP4MoIqz6NUXRaTS6uND+nSY0laOPdkL+mL+n66gjGDSrs5Y5oQAHqKsPxpykNiOwm11UDqBJ8s5AGGTNBSViraLjStbz0/PrHNaXnXWKQ2zxNSYQ5eOqWBbdPTEIdxC5m0xLC5iL6Tqe0xyD15muQwK+0MfsTn5/SU3Eguwj94c6kxvLWUkGK4v8J9TMC2vW274zpcugEs2bJMeQ19N71z4p60aTlEE559GJttj0CcuyWFtDtbw5x2NbDUccCS9ENzwIR6P3FZ0iUJPP5esm3bM5NRj9WHNzP+hlKCJa+gsJlZQnODek+MNOakZRtDFEua8pHV9Qf2avVwogjBsvkIjGoxFtaxYNhGjLWTjtEwvd57eUvda8Bwi0OODyhdPOBam4r0E3pL7BlY/23ExAOXdM1pstTTjoIqt3b3g5LtB0Y+cVutfJ4fr+gzB8Ehpp0OAg1gbuEuZTAkAU4N8wwBWelrNK8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(2906002)(83380400001)(38100700002)(6512007)(53546011)(110136005)(66946007)(66556008)(66476007)(478600001)(6486002)(6506007)(54906003)(4326008)(5660300002)(44832011)(8676002)(8936002)(41300700001)(2616005)(316002)(26005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGg5OWs4Y1hwVzhZdDdkUitKdTZ6UzViVlJjM3pJT2loRG91VWNZY3RaMm1y?=
 =?utf-8?B?NkhJNGJVU25Yc3REUkFDemVydHhhQjl3TjhoMEp2Q092RWpHMmVaQ2NPRDQ3?=
 =?utf-8?B?ZUdzd2RsUFBnUzg0NVhLOVBiUlZSYUtLWE9yWWlEdkQvZ3B2OFI5dSs2NnFo?=
 =?utf-8?B?ZTZPdElEUENIWnpUcEJFRzZMR0dMM0NSd2hGZ2gzQXJiUWdOVmMyOTJvVUZm?=
 =?utf-8?B?ZCt2LzRUVCswMFBScldBV0NXcmhDRldTVEpNT2VnVHFpRzJ3NEVlYlJtTklz?=
 =?utf-8?B?Smk3SjJtSVdVL0JiRVVwNHFKaUJKbWdvZWRiMzlIbGd6TkZrR0RGNkhsMVBO?=
 =?utf-8?B?OGNWVThldi9hWlAvaExTZll1VDlxMnZaNFhrMGtFWVhQQ0xXbkEvdWZkUzhX?=
 =?utf-8?B?QVh2UVo3MytiWkhMTENVc3dzeG5sL1lDWTNGNlJYYzNXcGFUbUJlR0NKeTNu?=
 =?utf-8?B?SGEvSWlqcXlrOHcxZDkrNGNYbTVubkM1bStlcEE1aDIxWmcxanF4dmQ5RENl?=
 =?utf-8?B?M2UyMmZWZUtkUFpoaHVSY1YyMStsaDd0ZkdYRG5Vb2VGbmV3b08vcUdUa20r?=
 =?utf-8?B?ZzRDblV0NzQyUEk0Mmgzcys2SUhzWHU4SmQrOS9PUFc3MkpCc29HL21QYXc5?=
 =?utf-8?B?b0VVb25RSEJ2K2pXVnE1NXNvdnhvUm8vTDc4UFNmOXdJL3lVSFJpSVR1SkZW?=
 =?utf-8?B?YU81NVRHaHg2RnNQZHA0cDgwcVM5cG83aC9NS2hGY2hjSHFCcVB5Y3NqblRu?=
 =?utf-8?B?R016TE5nQ25SQVZrOFMycldkRjZvam5yUE1QOXpteHlxaUNBL1hldGp6OWtM?=
 =?utf-8?B?aGNrbER4V05ZcHRTTGxmT1BmM2k2cWRXWXpMVnRMVGhxc1NTZVJpVlJnb3BK?=
 =?utf-8?B?MnpBU1ZmbTZOR0ZBTkFJUysxNTh1SkpBTktBRVE4a0JWVnFHZ2pUL1NTVG1Y?=
 =?utf-8?B?UUIvTjBpY0tCN3k1b0Fqd0ltbzJGb0xIWHZIVDdhZHFVczRIblpsbFNscWZn?=
 =?utf-8?B?LzVnTEc3dHVxS3A0UEZqWlpSa1JkRVVsTXpjQWRucXNEaFFjZU9uMlp2dDZz?=
 =?utf-8?B?Q05KWGd0TERoKzF2MUprOHFvY1k1RURtWWhZMFh4NGdERTY1cGpiYkNNMVdj?=
 =?utf-8?B?c1NJdDl5bDRZNXVNZ0lxVDZqcWhPV2dveG0rK1pSQnBTRXZKaFVFMWRkNnFm?=
 =?utf-8?B?cUR6emRyS0JxUG9xNE5QbW9rUlNUS1NsSERtN201ZzF6eWtCZlp1c1d5djNi?=
 =?utf-8?B?U0dQWklpazJiOWZNMUtDeFAybllteE43OUtETkRDdWtnNW5BL0hJUElKTTNh?=
 =?utf-8?B?M0QzQm9xbUFLZkMzcWZCQzBZcWhHM0JZamt5TDhWdDVtNkZybFFkWXdHL3o1?=
 =?utf-8?B?NTdnWjVaVFhlOWVIME1VamgrNUNPNkNDbXBMd2tQR0MvcmRDV2FSVlNvYnpw?=
 =?utf-8?B?N0RKRVRQOFMyckFqQVI0MTg2SHE2d0RObFVDcFhHMWhGSkticE91aDlTaUJX?=
 =?utf-8?B?enR3YTRCOEtZMVhxMlN2WUkzWFFMKzk3N3ZnNU5JRDRJdXFsWXhobUFQOUxL?=
 =?utf-8?B?aEhNUG1hUU9IOUtjS2VEbjBIVUdxRFJndHBqU3VxdnY5RCtHeFJhTWNrSkxH?=
 =?utf-8?B?MXhsS2VLTGt2TXprc2ZaSS9WT2w1QXFGcm5YQ0dBVU9ycGJkK1ZWWDlQdWdy?=
 =?utf-8?B?VWk0bnY4b2RheFBPT3BMa1JhZEF6SHZOWThrYnlEQzlieEtkc2QrTEY0MVNx?=
 =?utf-8?B?eU54KzNGZVRXYWdaaXdtdUxKVnhEemUyNVQzUFRkY1U5K1ZwVmVkejNRYVZS?=
 =?utf-8?B?QjJxdWUzSFBrZmlNZ3dOOU02SUE1YmpZNktYVE5ITWZXVXJvdkJrZnY4MHJV?=
 =?utf-8?B?QzhJQlkwMjloaUpxL3FBRjNFUEdtbVNPN003NEcyTndzKzlHVHQ5MkFSb3JH?=
 =?utf-8?B?dXp6SVBtSFdPdnppWWs1cWhqZlNkdWw2MkliWGZnK01KTkUyN3JaRWwyU2FV?=
 =?utf-8?B?OExDMUVDSE5iYWpHSG9DN1hTbmp6Z1RZb0ZES09hK0NHSHJRdGd5c1lEZjVJ?=
 =?utf-8?B?MEFvS1o2dGFnSHN1bzR3SWJSdU94TXBaK1Z1amY4dGFHN0FDQzZiQUY0LzZJ?=
 =?utf-8?Q?yBoXxzuxWCMdrUKIJtXmDTIQK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994a698-bfc2-4332-2b10-08dbbe41f29d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:37:45.6831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzEfPKY8X03dWvCm4NNckoiEjFnydWrQIwokBbJM9Bru1OCqmc02YThxQe3qmVJNpNQqOOkXNxIIGOIxLGg1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Feifei,

On 9/25/2023 22:20, Xu, Feifei wrote:
> [AMD Official Use Only - General]
> 
> Hi Mario,
> 
> Navi32 which DCE3.2.0 not support this. This patch will cause modprobe fail on NV32.
> 
> [  +0.000126] [drm] DSC precompute is not needed.
> [ +19.026503] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000002D SMN_C2PMSG_82:0x00000000
> [  +0.000002] amdgpu 0000:03:00.0: amdgpu: Failed to power gate JPEG!
> [  +0.000001] [drm:amdgpu_dpm_enable_jpeg [amdgpu]] *ERROR* Dpm disable jpeg failed, ret = -62.
> [9月26 11:00] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000002D SMN_C2PMSG_82:0x00000000
> [  +0.000001] amdgpu 0000:03:00.0: amdgpu: Failed to power gate VCN!
> [  +0.000000] [drm:amdgpu_dpm_enable_uvd [amdgpu]] *ERROR* Dpm disable uvd failed, ret = -62.
> [  +3.557018] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000002D SMN_C2PMSG_82:0x00000000
> [ +16.269817] watchdog: BUG: soft lockup - CPU#7 stuck for 26s! [modprobe:28704]
> 
> 
> Either change to:
> return adev->ip_versions[DCE_HWIP][0] == IP_VERSION(3, 2, 0);

You mean to add an exclusion for Navi32 for this case to return 'false' 
for amdgpu_device_seamless_boot_supported()?

> 
> Or revert [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer ASICs both ok.
> 

What kind of connector do you have connected to display?  Is it eDP?

Are you sure it's this patch causing it?  With latest ASDN hash can you 
reproduce it and then try the module parameter (amdgpu.seamless=0) to 
disable it and confirm things are fixed?

Can I see more complete dmesg?

> Thanks,
> Feifei
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Limonciello
> Sent: Thursday, September 14, 2023 1:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer ASICs
> 
> Seamless boot can technically be supported as far back as DCN1 but to avoid regressions on older hardware, enable it for DCN3 and later.
> 
> If users report using the module parameter that it works on older ASICs as well, this can be adjusted.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2116e016178a..38fafed31a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1361,9 +1361,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   /*
>    * Check whether seamless boot is supported.
>    *
> - * So far we only support seamless boot on select ASICs.
> - * If everything goes well, we may consider expanding
> - * seamless boot to other ASICs.
> + * So far we only support seamless boot on DCE 3.0 or later.
> + * If users report that it works on older ASICS as well, we may
> + * loosen this.
>    */
>   bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)  { @@ -1383,14 +1383,7 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>          if (adev->mman.keep_stolen_vga_memory)
>                  return false;
> 
> -       switch (adev->ip_versions[DCE_HWIP][0]) {
> -       case IP_VERSION(3, 0, 1):
> -               return true;
> -       default:
> -               break;
> -       }
> -
> -       return false;
> +       return adev->ip_versions[DCE_HWIP][0] > IP_VERSION(3, 0, 0);
>   }
> 
>   /*
> --
> 2.34.1
> 

