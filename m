Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29800C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 10:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77F010E0CB;
	Thu, 13 Apr 2023 10:48:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ADB10E0CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 10:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiV8ziA32MyIJzV3p+w1slzGlEIdGaVc6GbN2c+kvko8+qP47oaPyeUcWZ8+eoYbtH7u0ZlaRq1I0F8stv/BwqgIQ8roWC9/b3ZOzhmhOm2ZlKl3UpiLYx2r9O+FKx7DK09GcwHb2xU0p0W8dhW7G02PwMTrRRFZofct6s5hn83iDXjSm6SK36U3nxrlhRkWEG9c7luW2Y1TXdUKdJ+plSBGHslSDI9ylQoCrVYEOSLQQIzk9eIHUHeJLl33Hh4tjQovlVPxhzlr3oJTHoGruuPezFE5s306xKUA+t52VaEdxLUCo+whYK9tylk96EeE1N+TH513RG4ZXx5mn/h1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJYtnIEnIVCQd5BCO5ByWXbjjV0SOz2k3SWuQqdlyS8=;
 b=Ko+434gVtCThoD7NkbBDfcZEiJ2UYjsfBjSwAiwiRbQvImCLHZgeWZBb7/SD1eijvrg9F6luAEPHMDh0JwBPpgLJIu5e5Uuqo3BZYPDuwqvadoCh5uzOTumU14QEsSna4nOXW9nJbVVGfVHD0+sXJb6FVBOF0vLIFxSlacDjAjjxbCg1ynUCspUuBUB2fDjpVdsjJQ91++crEUkr4mKQIuWoA1zlXkn4NVYvbus+mh3UutwIbyBn+LjUPsCPkAkKi/nyspy3N9BCISBIJYZ62q+j34e5h7iK3KOpMZ5Th+M/6rRzo3v4fDExxcmk7oQZvBHPxeW3pSG3Qs/kxvTvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJYtnIEnIVCQd5BCO5ByWXbjjV0SOz2k3SWuQqdlyS8=;
 b=eeUU7F+JY2pfbq9f0HLZ888yB4L1uOeZWBJ7WtAJATtA3eQQGR+YKgrwYBYIGeJWM/qxtIDR6LKysBp1onOrciZVM8KoXD0iGZ7lU8OzU+ItAVE2nTwCpqyDCRMcoE82Yfx3Tsj7Z9jKuwenjlbH6B6M3JK5UIh2hrSzZ19qcEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 10:48:19 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e208:1fec:a14e:eadb]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e208:1fec:a14e:eadb%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 10:48:19 +0000
Message-ID: <89667a39-c514-f887-8a43-6685d954ddf4@amd.com>
Date: Thu, 13 Apr 2023 12:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/12] drm/amdgpu: create a new file for doorbell
 manager
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230412162537.1357-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: da2428eb-2567-4bee-2045-08db3c0c979f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqBUxYRfwXpfRQq7/UXLpiNuOXniGxukP1BQVHDBiEP9H5vaID06CDcKFWjglqxKszb3iwtrwfRMMAG8frFZyDMqshtU3vu0H2E/aPwaLPL5u8RbAtcSr3v8VMaUJzh7jTiTOgqpASNWtN5zLS55mBZf0NgJ/nHZdF2cUE2IGMZiu0XqoeQWoC4n0pY4iYcsRhw0DXsgK2vxQiyaKVr0ga8MsjOlDi3W7khmVU7nWirhPzgXyGBi5+TH8yuBfVVT5cZ4PDALnq12FxKTunIn2qUbTxr8hOPnOzXHtVOLYci71p5WNCbECGuzwYmTxLS4+65/9BlQ8saXHLEYF3fUlLCmfig80m+2CfgN2SqoEu3f0MUgT7Lwbd/m/ckNkvyAirbU/iR9RXPxdPVhC2TL27VSz6OS8wVhxaJ7PKXv8tKPAzyggMD5pzEh09Ttg2nkleYg3Xmlh4qhonf7p3AItNucLbtBnDFuQID7BjPsV1axQDQ+WKQLvIbY7Mu6XnjWmDgh7UI0bJvmy8bVdhgM+HGAJTAkJbqNYtf9Yqxqat644Sn2CaGtTHtV13a1ISUhnyZNV9u0G0qrQQdFjiIuF9YzhNb7L8rzj31UQmhGZbeF2/LBxw6Y7pG75OuyzOcydC+Wr+MEDbMxlE9kq8ckRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(66476007)(66556008)(66946007)(4326008)(36756003)(30864003)(2906002)(31696002)(86362001)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(6512007)(6506007)(26005)(31686004)(2616005)(186003)(66899021)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZ1VVQ4Rm5KYW5lVjVpVmxheVFhekl6WGcrMlp2MTdqRGs0SFYwb1M4Yzhs?=
 =?utf-8?B?OXpVaEFNWFFQb1pRNjU3bmNuK2xFZG8wMkNxeXJsd3RrU29waHF0cDA2OXo2?=
 =?utf-8?B?TXZJc2lnUGRWWVRlNWZYZUJGTmZtVEE0NlhucS81VFlRRUUwLzRPWmdUaDlv?=
 =?utf-8?B?NkhzL2Rzb25wZHZJSzMweUZZdlg0Z0tmVXUveVRvSzVxZXBRQ0w3SmJPdXFE?=
 =?utf-8?B?cVlFSkY5N3dvMm1iNmpzSFNKWWRPQUNvR2RjMVc1SzUrcWp0djBZRC9FS04z?=
 =?utf-8?B?Q3ZibHN4WFJVL3B3dTliOVZYZnBQYnFsYm0yQ2NMZW9abXNTV3d6MnhHWkZr?=
 =?utf-8?B?dVJJVGtqUmNHSWVadnNCYXhzcTh3ZUREYytQSk41ZEF4KzdmYk0za2piYm1n?=
 =?utf-8?B?UXhHMmpNdW1VeGphSGVYY043THJXa3ExNnlXQ3Fpc25YWU5mYmcrNWNnZnZD?=
 =?utf-8?B?NVE1NTVKQzVGYWdackVocmk3OXdqVW5hVTJFTUxab21ySVJqUmdQQ3JBcnVG?=
 =?utf-8?B?cmI2dlRwcHU2K20wSVErOTJuRnZXVm0wOXlwQTBLUzFIUFNUSGxSY3ZwMTRm?=
 =?utf-8?B?eDdNZGpzYmwrT01BYWZINkNhdFFnQ2RCOHJwSlFKTW15NnU0TUJoZjExbk9h?=
 =?utf-8?B?QmFlMmY1Z2RrN1QxKzRkSXl0QTZuYWp0U1krWmxoS3V1dE01eXkxMlo3ZVY5?=
 =?utf-8?B?STUza0NReGpDWXR4bDZnem1tMTZUYjdwWnJiV3oyNC9KeWEwYXdMQTQ3NTZP?=
 =?utf-8?B?Z1F6bDUwZ3JDU3NldmlFd1ZINDVxUEhSWUVwNDhVd2k5L1BhcFF6Sms5Tk5U?=
 =?utf-8?B?UThNeVpJbUwyZmppaTZOZnNRM1VMNis4RW4wamJXcE9GNndLbHpSWG5QL1oz?=
 =?utf-8?B?QmpjdTR0RWJ2WHg4d2VLSlpNU09mZk96WUljZzNYaTY2MGRhQnlIZ1B0TlVZ?=
 =?utf-8?B?aE5IOXhLbkU3dG9MeUJDWnd3eWI3em51QzJsbnNENkI2T0lrMDlES1FlL2Fo?=
 =?utf-8?B?Y09aamc3cXd1MjFpR091Zit1clJwbFEyM1ppQmRKaDFaYVRKQklwOG1XQ3Zl?=
 =?utf-8?B?OXVNVlM0RkgrSklDQXZQOW5UTDFCUGZxUGdGUStiZ01NSWV3RVhkSEVsUUdQ?=
 =?utf-8?B?TjBmemNxV3lzbDd6ampVRFFXWjhlZnphRGM4TjZDSmROV1FMV0ZiUTY0aXIz?=
 =?utf-8?B?U2Yyb2xvZm1tbG9oU21XenArUEtnZUh3V1E5cGNiRmJSdjc4RlNmYnh6NmVK?=
 =?utf-8?B?L05iU29wV00ySUVoNVlrOEhVMGZlWnUvTzR1VHV5cVlhVTZzM3BmQzlWb25C?=
 =?utf-8?B?cDIvTzZOc2xDZk5SclN6cXFVRWNiNEM0TmhjYld3elJ2QTZyK0I2bnBhek1K?=
 =?utf-8?B?SXFtNkRBU3g3NlpwdVhsM3Nrd0hsazNSS1pocG5OM3czclZNTHlZS2laZm1o?=
 =?utf-8?B?ejVobXljSmNNVHoyb3dNMDRIRnVRcHJ5QUhhOW5ZdFlXbGJoNG85N2tHNTNh?=
 =?utf-8?B?Wm1vejdoQkkzWkxwNkJSNXdMclJKMkJqdnFHbDFZdTMrWHNkcXpqYVVRUjFD?=
 =?utf-8?B?VXZtMldTTEFEeGNxOEV0VFprODIxMnBUN0JQWUp0QlhGeDB6Yy8rR0QzMWVa?=
 =?utf-8?B?cGthaHdONVRlRHdTVTdQeTVuWkp5b1NmTGJuNjUyRWpEZzdDbFdnRkVXRmEr?=
 =?utf-8?B?ZnBSTmRiYm5Ta3FBVFp1Ri9oQTNpZzdrZm5POU5qajNEWS9UWmJ5cUFNakFt?=
 =?utf-8?B?bXZqUTBUQzRhVU5oUXBxakpxUS9vaWJBdytydFNiV3BmTGU3WllLKzZvY2lp?=
 =?utf-8?B?MUg2NkJybmc2SS9peURWMmRTWUlLbmtPN25Ja1RuSXZPRThTVkE3UWhiMGN4?=
 =?utf-8?B?Zm1Fakh3b2dCUzB4RUo2U0l5MnJOTXB1eWMySjJiS0xvdFBZdkZvcUd0V2Iw?=
 =?utf-8?B?WVl0TGtVeUp1RGV4QzA2aWZHblNEcUViV0FGbk5XSEZHdDNNWjAwelY5a0lD?=
 =?utf-8?B?dFp6MzZEYW0xNnlLRVZiMExZWFNWallKSDJYeTllSCswVjVUMkVzTXhlbGpn?=
 =?utf-8?B?cTRoYkp1NXlHREsxZ0h5UlN0cjA1R01DK3BKNlVOU2o1dUxONjI3UklJRGdD?=
 =?utf-8?Q?KZes=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2428eb-2567-4bee-2045-08db3c0c979f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 10:48:19.3399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp/VKHHpUbgUEz8VbVVcftxHTWBo63gM2ALAvrah08dqC+SrdiC0ZdgtMzUZDLJx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 18:25 schrieb Shashank Sharma:
> This patch:
> - creates a new file for doorbell management.
> - moves doorbell code from amdgpu_device.c to this file.
>
> V2:
>   - remove doc from function declaration (Christian)
>   - remove 'device' from function names to make it consistent (Alex)
>   - add SPDX license identifier (Luben)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 174 +----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |   6 +
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 183 ++++++++++++++++++
>   4 files changed, 195 insertions(+), 170 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 798d0e9a60b7..204665f20319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -41,7 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>   amdgpu-y := amdgpu_drv.o
>   
>   # add KMS driver
> -amdgpu-y += amdgpu_device.o amdgpu_kms.o \
> +amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>   	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>   	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57ee1c4a81e9..88c75f7a8d66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   	}
>   }
>   
> -/**
> - * amdgpu_mm_rdoorbell - read a doorbell dword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - *
> - * Returns the value in the doorbell aperture at the
> - * requested doorbell index (CIK).
> - */
> -u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return 0;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		return readl(adev->doorbell.ptr + index);
> -	} else {
> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> -		return 0;
> -	}
> -}
> -
> -/**
> - * amdgpu_mm_wdoorbell - write a doorbell dword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - * @v: value to write
> - *
> - * Writes @v to the doorbell aperture at the
> - * requested doorbell index (CIK).
> - */
> -void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		writel(v, adev->doorbell.ptr + index);
> -	} else {
> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> -	}
> -}
> -
> -/**
> - * amdgpu_mm_rdoorbell64 - read a doorbell Qword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - *
> - * Returns the value in the doorbell aperture at the
> - * requested doorbell index (VEGA10+).
> - */
> -u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return 0;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> -	} else {
> -		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> -		return 0;
> -	}
> -}
> -
> -/**
> - * amdgpu_mm_wdoorbell64 - write a doorbell Qword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - * @v: value to write
> - *
> - * Writes @v to the doorbell aperture at the
> - * requested doorbell index (VEGA10+).
> - */
> -void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
> -{
> -	if (amdgpu_device_skip_hw_access(adev))
> -		return;
> -
> -	if (index < adev->doorbell.num_kernel_doorbells) {
> -		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> -	} else {
> -		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> -	}
> -}
> -
>   /**
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>   	return pci_reset_function(adev->pdev);
>   }
>   
> -/*
> - * GPU doorbell aperture helpers function.
> - */
> -/**
> - * amdgpu_device_doorbell_init - Init doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Init doorbell driver information (CIK)
> - * Returns 0 on success, error on failure.
> - */
> -static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
> -{
> -
> -	/* No doorbell on SI hardware generation */
> -	if (adev->asic_type < CHIP_BONAIRE) {
> -		adev->doorbell.base = 0;
> -		adev->doorbell.size = 0;
> -		adev->doorbell.num_kernel_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
> -		return 0;
> -	}
> -
> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> -		return -EINVAL;
> -
> -	amdgpu_asic_init_doorbell_index(adev);
> -
> -	/* doorbell bar mapping */
> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> -
> -	if (adev->enable_mes) {
> -		adev->doorbell.num_kernel_doorbells =
> -			adev->doorbell.size / sizeof(u32);
> -	} else {
> -		adev->doorbell.num_kernel_doorbells =
> -			min_t(u32, adev->doorbell.size / sizeof(u32),
> -			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_kernel_doorbells == 0)
> -			return -EINVAL;
> -
> -		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> -		 * paging queue doorbell use the second page. The
> -		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> -		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> -		 */
> -		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_kernel_doorbells += 0x400;
> -	}
> -
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_kernel_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Tear down doorbell driver information (CIK)
> - */
> -static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> -{
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> -}
> -
> -
> -
>   /*
>    * amdgpu_device_wb_*()
>    * Writeback is the method by which the GPU updates special pages in memory
> @@ -1239,7 +1075,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   			      cmd & ~PCI_COMMAND_MEMORY);
>   
>   	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
> -	amdgpu_device_doorbell_fini(adev);
> +	amdgpu_doorbell_fini(adev);
>   	if (adev->asic_type >= CHIP_BONAIRE)
>   		pci_release_resource(adev->pdev, 2);
>   
> @@ -1256,7 +1092,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	/* When the doorbell or fb BAR isn't available we have no chance of
>   	 * using the device.
>   	 */
> -	r = amdgpu_device_doorbell_init(adev);
> +	r = amdgpu_doorbell_init(adev);
>   	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
>   		return -ENODEV;
>   
> @@ -3712,7 +3548,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
>   
>   	/* doorbell bar mapping and doorbell index init*/
> -	amdgpu_device_doorbell_init(adev);
> +	amdgpu_doorbell_init(adev);
>   
>   	if (amdgpu_emu_mode == 1) {
>   		/* post the asic on emulation mode */
> @@ -3942,7 +3778,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>   
>   	/* Unmap all mapped bars - Doorbell, registers and VRAM */
> -	amdgpu_device_doorbell_fini(adev);
> +	amdgpu_doorbell_fini(adev);
>   
>   	iounmap(adev->rmmio);
>   	adev->rmmio = NULL;
> @@ -4051,7 +3887,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   
>   		iounmap(adev->rmmio);
>   		adev->rmmio = NULL;
> -		amdgpu_device_doorbell_fini(adev);
> +		amdgpu_doorbell_fini(adev);
>   		drm_dev_exit(idx);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 908433ac6cb3..3e77a6b4bd69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -306,6 +306,12 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>   
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +int amdgpu_doorbell_init(struct amdgpu_device *adev);
> +void amdgpu_doorbell_fini(struct amdgpu_device *adev);
> +
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> new file mode 100644
> index 000000000000..64fec954815d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0+

That should probably be MIT. Except if Alex thinks otherwise.

> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +
> +/**
> + * amdgpu_mm_rdoorbell - read a doorbell dword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + *
> + * Returns the value in the doorbell aperture at the
> + * requested doorbell index (CIK).
> + */
> +u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells)
> +		return readl(adev->doorbell.ptr + index);
> +
> +	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_mm_wdoorbell - write a doorbell dword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + * @v: value to write
> + *
> + * Writes @v to the doorbell aperture at the
> + * requested doorbell index (CIK).
> + */
> +void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells)
> +		writel(v, adev->doorbell.ptr + index);
> +	else
> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> +}
> +
> +/**
> + * amdgpu_mm_rdoorbell64 - read a doorbell Qword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + *
> + * Returns the value in the doorbell aperture at the
> + * requested doorbell index (VEGA10+).
> + */
> +u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells)
> +		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> +
> +	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_mm_wdoorbell64 - write a doorbell Qword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + * @v: value to write
> + *
> + * Writes @v to the doorbell aperture at the
> + * requested doorbell index (VEGA10+).
> + */
> +void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if (index < adev->doorbell.num_kernel_doorbells)
> +		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> +	else
> +		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> +}
> +
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +/**
> + * amdgpu_doorbell_init - Init doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Init doorbell driver information (CIK)
> + * Returns 0 on success, error on failure.
> + */
> +int amdgpu_doorbell_init(struct amdgpu_device *adev)
> +{
> +
> +	/* No doorbell on SI hardware generation */
> +	if (adev->asic_type < CHIP_BONAIRE) {
> +		adev->doorbell.base = 0;
> +		adev->doorbell.size = 0;
> +		adev->doorbell.num_kernel_doorbells = 0;
> +		adev->doorbell.ptr = NULL;
> +		return 0;
> +	}
> +
> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +		return -EINVAL;
> +
> +	amdgpu_asic_init_doorbell_index(adev);
> +
> +	/* doorbell bar mapping */
> +	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> +	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> +
> +	if (adev->enable_mes) {
> +		adev->doorbell.num_kernel_doorbells =
> +			adev->doorbell.size / sizeof(u32);
> +	} else {
> +		adev->doorbell.num_kernel_doorbells =
> +			min_t(u32, adev->doorbell.size / sizeof(u32),
> +			      adev->doorbell_index.max_assignment+1);
> +		if (adev->doorbell.num_kernel_doorbells == 0)
> +			return -EINVAL;
> +
> +		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> +		 * paging queue doorbell use the second page. The
> +		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> +		 * doorbells are in the first page. So with paging queue enabled,
> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
> +		 */
> +		if (adev->asic_type >= CHIP_VEGA10)
> +			adev->doorbell.num_kernel_doorbells += 0x400;
> +	}
> +
> +	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> +				     adev->doorbell.num_kernel_doorbells *
> +				     sizeof(u32));

It might be a good idea to drop this. Or do we really have any use case 
where we need to access doorbells outside of the kernel reserved ones? 
(If yes, forget what I've said this looks good then).

Christian.

> +	if (adev->doorbell.ptr == NULL)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_doorbell_fini - Tear down doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Tear down doorbell driver information (CIK)
> + */
> +void amdgpu_doorbell_fini(struct amdgpu_device *adev)
> +{
> +	iounmap(adev->doorbell.ptr);
> +	adev->doorbell.ptr = NULL;
> +}

