Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA15C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 12:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD77573F2C;
	Fri,  3 Dec 2021 12:07:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F85873F2E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 12:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg4d4xd7oKDfDsau+dmjZ2kPDFaT+3g2TckNyXZr213wxIflDI/qkT2en5VvOq975YXrzEB5ze1PQbeelHObVnLMM+4u/SPAYkm1Q0Ocg0VtOwBkntDo8yVj5Dot5vIz8L10nHqtXMv+k88Mqy5GKXLFSJnqamwO+DCylhPJML3++Rwa2N0aSzIGsqCxBJBmTNWyZsW7j8PpGG70n3LgxwjbS1scWyizMX/QQylkaMxKi1gShy266TanvzTWicLxE3GHtrl4YD4JppsjA5fMdgE+ne00fP/Hm0Uq00pHnfPeCybuDGbPQqZookQqvQ9p1fLZq/HrKSuYpz0tHG7e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW/txiwn520i1V9J6Hs4gO+dExVurDzdemtfckkXRuY=;
 b=P3VTapABu002ElAgaItVABzt2OJRTsehwceE9RlOXeMS+wsEONDOrF/RSRKEyFGnoOLpEFhuLAN3wFGccp0kUhAumwfCNYVYKemXraWj4vVc2gZ3p0tS+8fblav+gOmcwpJUU/1ai+CDpW+Eow+TrqWdxjnZQ9vcWWEUB/n6zxuRqTVyJwkRjLbcchBozHCPQyGalObRrNz73AaQvQ4UsUVN+w858B+Y+114GBx7noh9/cFI17R+7takGpMdHGBoKNPilA4jvyzvrWulq7qZFVZwNIYlN+k4BP22EA6g8zD5sa25heputhNnXdHScLV3KtYZGUyCzCdL7UcNltIh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW/txiwn520i1V9J6Hs4gO+dExVurDzdemtfckkXRuY=;
 b=hgUK4izjg1q3W+6V/PVvA++bts96XlsFlIsVGQIdj5QAarlxn0WCAnmtUmVEOg+r+Cj9h9sgE3Q4TX5dhOdsdbvBVB+xshcPNjVKFLA1MhAibFS1fvDHIfDXkjqlBFJTI5JEBMAnRFOJzHFzmcLuS1iqjHtuKdMaEwnRbkOjuwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 12:07:40 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 12:07:40 +0000
Message-ID: <14cb3f8e-7e73-f596-ca3e-d8af7c053d5a@amd.com>
Date: Fri, 3 Dec 2021 17:37:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202191912.6148-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211202191912.6148-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 12:07:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3804b54d-c815-4e75-6d9a-08d9b65580ba
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1242661796F22DB2619D3193976A9@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9wjmxPayoHOUtVupT1VlqHsyd25Uoo0e7dioyiTgvfYGDjDv8vvIHxNmto5urvxSHp8b3kroh2eotTOjRgLIBW1CzUDFzcy+lRbLWtkynMlYI1VkE2+oK9yQtY6oHmqUbPC7hJm6L1kyVzLIuVU+G5zPazT/OFnf+hBXfpY4Jb0Fm7Ka4YTEfJuPwYM2aWJgrFXFBe1xYBCgx3IWur2mvlxxk7IjFAMubGqsXq+HkZv444MiKDKdcnQ1JU/LMLWMisuaOHzWGa0Im3X1qVLW5nP3HKZ0lhI6a1Xvg5M9pQfKNSKaCL238zJqy+Zh4LrPH8fa0GRfG2uE0tTBMEh0uXFMYAt5YES6pHllv+6sLapYmWptMOCrAnzFKyrC1wxYQuafgqg2ED5VrO+WjjC6TQT3fUzMAEfO3NfmXfUCgfW6lWfxFyz27b5CYH6jty0sU8uIOxObI0D4Td+m9nOAy+l7IN3U+Xm7M84ch1LOU4+2EzK1dBcprEIZNl3IiT0w5FXB292hoNJ399YTj/grESgzaMtSM/T1jEfjr0iC8D+YK7aU17tqdFYCIzN8JTmKHp/KY2pax92BjZRoqvQqLHSl+4Le7BMvdth4vinT4lJxDM8E27/NJDkY8KFeMKFq795ryWpdwbhXlq35hrNWQMAayf5xEnsXlGDXOF6bxx7PkRwe6jWRUkeiH9xkgyJOby62Sr61MaZKU0vsLU7u76piHfLRn1sris0tuCJHgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(26005)(2906002)(186003)(66946007)(6666004)(956004)(36756003)(66556008)(31696002)(5660300002)(316002)(2616005)(38100700002)(86362001)(31686004)(16576012)(8676002)(83380400001)(66476007)(8936002)(53546011)(30864003)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUlDTHRsV3VwNVlXbHI2QS9Qb0dZWDZNZDE4d1hLZWY3a3BIa0V5QmI1R1JD?=
 =?utf-8?B?MGUyWElWRi9aSEZBYy96b1ZJSHg0d09nMFo0YngxVTZISTZkcUtFTkUrYUhI?=
 =?utf-8?B?U0tXblRBcW5uYnFHMy9aeU9kcERMdDdPQmg1MjB1T1B1UENJT1pRZExiQ0VK?=
 =?utf-8?B?dXJtNTNaL0d1aTh0eDVjRmR2a3NHWTNzQklFejQyVzFBTU5aUk9ERHhodnd3?=
 =?utf-8?B?WVgvaTRxdS9CbjJLY08rY3oxNSs4TmlPYkdta2xucWs4Rml2WXBEUllXUUpk?=
 =?utf-8?B?V0oxUEoyeHdiNDJmNENwb0ZjYkhRV1g2VUlKNEQzMDVxL0pCbUJvcGQrMlB1?=
 =?utf-8?B?VW5sSWtVcHhUT2EzdlY4cnk5MU1IQ0YwdTRCTnB6L3UyeHFzR00rYmdtYyty?=
 =?utf-8?B?alFtbzFQcGZTQWQybFB4ZDZOV3JoTFJGUWFiZFhXZDYyVVVlaUZ6cHlxSENU?=
 =?utf-8?B?SlVzcHJjM2w0QngzdmZXbGx0RGF6TGl6ZUI4VmhMcVp4OXcxUThKcUZDU3Nt?=
 =?utf-8?B?eWtKalN5TXprd2F4SUNnVXBMWEIvQlJTeVEzYnAwVmtLK1JjZGovWEs2TjF2?=
 =?utf-8?B?UUtrTEVrRWJGYSt6Z0dOM3doMFNPOGlEYXdSZjBvZ0daaWJKcms4Y3RkYnpt?=
 =?utf-8?B?TytBcGtBWlVxczVNYm5rSkRlNUFnTFROYXVlSXJubjNoMW51NEh4U3E4REkr?=
 =?utf-8?B?bi9HbGNpSG42aWlOa20xV2svSzhJcGZvSk03Vzl2b0V1OUpkcVI1dmJBS1hp?=
 =?utf-8?B?SWdQclM3TW9LMjFNVWhNN3FQRzlEZVpjU3p0bVM3SjgrdzB0RUNKaGNFY2Jn?=
 =?utf-8?B?SW1oL3dVbDR3YTFJV3diS1pWdy9jWHFqbW0vNk1qbHh6Q2NKVjFiOUdHR3pz?=
 =?utf-8?B?QVk3aXJGN25KMnRXNDRROUMwRHFiQWRZbmliNDR1ZXQ0eC9ndkdiTVpOcVFE?=
 =?utf-8?B?aUpuM1ROVDAxcndhRXFUNEZCeG5HWFZYMjhremdDL05zYWEyVVBCMXJsUFg1?=
 =?utf-8?B?MUxhT0I2Z1ZjNEVhM2ZnM3FScXd3MVdNZWd5MGVuU3FSNTNlZW4rK3NhaEc4?=
 =?utf-8?B?d09vZHZmZmFUZW1KS3g5bEVyK3l2b3Boekp4ZmcrNXdaR3d0YzZKUW9vdFhl?=
 =?utf-8?B?enMwTEpNWngvZVAvYUhnN0IzUlNpWGdZL3M2NEdiOWdoNlBBT29HMFhOL1c1?=
 =?utf-8?B?VG9zQzZMVU43UW9RdEg0ZVZCVnowT2E0UkQ4Tk5wZndtNmcvT2FMR2MzV0RI?=
 =?utf-8?B?bGNobm96ME92Ny9WUDI2RlVzenkzR01mc3Q5NUNiL0lNSkxUbGJaNzU0K1Vy?=
 =?utf-8?B?bjJBUmUzTmRGN2pIdkZnMkl5Q3pKNThhZTJ5REV3SXJ5d0ZGNVRoOVBPUXNE?=
 =?utf-8?B?RzJlQ29iUlJkQWlwVVEveG9BMTFaS3I0WDB5NVJUK1I0OE1qaDVqMFJPVkwv?=
 =?utf-8?B?Mk9paUNYbjVGaWFLalBRUTIxUWdzbkVuN0JDZXQ3ckhubUp3MS91a2w5UE5z?=
 =?utf-8?B?bVJoRGpzR2hyM29sQ05EZysxd2RLRitwT3ZpaHE3bDBFRGhXRVFKRFlOaHhx?=
 =?utf-8?B?TDBCRHFJeUNIN3lTZWxXeE4zeHVpNWtJVVNkV1V5c09DWm9DbHR6aHM5Wksy?=
 =?utf-8?B?R0xWa1VPcStsWWRxeVY0WTlFYlJuS1NkVGdDVThqdDR4Z1drT2xlb2c4QW82?=
 =?utf-8?B?bmU3Y3ZWN0pzbTBNMVM1MS9pcHVqV0xMV3hoWmNHUDhsSDJBWGJ1VjhxNURw?=
 =?utf-8?B?V1pwTEJoUmN6VitTZjEydEt2QXl1OG5ZekNMcFlVMVp0KzFFMm9vaTh4RTdT?=
 =?utf-8?B?N1lhekxBcjNJeGxPZ2NaNmlrVjBRL1NxbWQ1cFRhRkdOaitvdkR5MktnV3Rw?=
 =?utf-8?B?VU1xQWVHSTlsK2lSSXp5S2tjV2xHQUUxMWJRUUo2M0lzVkVzYXN3NSt4d0Jk?=
 =?utf-8?B?UDRjNzZaL0Z6K3ZyenU2YTJxREgyV293dnlyS0dJaTZOSGp4UlBBT1ZyNUw5?=
 =?utf-8?B?d093ODlDNTJ3RVdyM25Yd1g1aXNMOStCT2V0ZXBmampJazhXanVCaFU3cmtR?=
 =?utf-8?B?dWRzaGhpS3pTSlAvWEI2VGJHRGNiZSt4WXVLMTNCTjVTWUpUSzMwR0NxSml6?=
 =?utf-8?Q?zE9E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804b54d-c815-4e75-6d9a-08d9b65580ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 12:07:40.2040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtQF9PS57lZg/v1ZQphIAMi0mwR6x/BPSY5BEec5IA/VvBlF4SuGPu4BoatqpxH3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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



On 12/3/2021 12:49 AM, Alex Deucher wrote:
> This adds a new IOCTL currently used to implement querying
> and setting the stable power state for GPU profiling.  The
> stable pstates use fixed clocks and disable certain power
> features in order to get accurate pipeline profiling.
> 
> Currently this is handled via sysfs, and that is still
> available, but this makes it easier for applications
> to utilize.  Note that the power state is global so
> setting it will affect all applications.  There are currently
> no checks in place to prevent multiple applications from
> using this interface, but it doesn't make sense to do
> profiling while you have multiple applications running in the
> first place, so it's up to the user to ensure this in order
> to get good results.
> 
> This patch add an interface to query what profiling mode is
> currently active and to set enable a profiling mode.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>   include/uapi/drm/amdgpu_drm.h               |  28 +++++
>   5 files changed, 173 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7fedbb725e17..4cf5bf637a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> -	amdgpu_eeprom.o amdgpu_mca.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bc1355c6248d..0e27f9673f8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -46,6 +46,7 @@
>   #include "amdgpu_sched.h"
>   #include "amdgpu_fdinfo.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_profile.h"
>   
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xgmi.h"
> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> new file mode 100644
> index 000000000000..94fe408e810f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> @@ -0,0 +1,112 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
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
> +#include <drm/amdgpu_drm.h>
> +#include "amdgpu.h"
> +
> +/**
> + * amdgpu_profile_ioctl - Manages settings for profiling.
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_vm
> + * @filp: drm file pointer
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp)
> +{
> +	union drm_amdgpu_profile *args = data;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum amd_dpm_forced_level current_level, requested_level;
> +	int r;
> +
> +	if (pp_funcs->get_performance_level)
> +		current_level = amdgpu_dpm_get_performance_level(adev);
> +	else
> +		current_level = adev->pm.dpm.forced_level;
> +
> +	switch (args->in.op) {
> +	case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
> +		if (args->in.flags)
> +			return -EINVAL;
> +		switch (current_level) {
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
> +			break;
> +		default:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
> +			break;
> +		}
> +		break;
> +	case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
> +		if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
> +			return -EINVAL;
> +		switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
> +			requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +

Not sure if the below code covers everything, but in general it's better 
for the sysfs handling in amdgpu_pm (after parsing the options) and this 
one to call a common API to handle this.

Thanks,
Lijo

> +		if ((current_level != requested_level) && pp_funcs->force_performance_level) {
> +			mutex_lock(&adev->pm.mutex);
> +			r = amdgpu_dpm_force_performance_level(adev, requested_level);
> +			if (!r)
> +				adev->pm.dpm.forced_level = requested_level;
> +			mutex_unlock(&adev->pm.mutex);
> +			if (r)
> +				return r;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> new file mode 100644
> index 000000000000..cd1c597bae11
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
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
> +#ifndef __AMDGPU_PROFILE_H__
> +#define __AMDGPU_PROFILE_H__
> +
> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp);
> +
> +#endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 26e45fc5eb1a..b6edf4a826f9 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>   #define DRM_AMDGPU_VM			0x13
>   #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>   #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_PROFILE		0x16
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>   #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_PROFILE	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
>   
>   /**
>    * DOC: memory domains
> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>   	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>   };
>   
> +/* profile ioctl */
> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE	1
> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE	2
> +
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK	0xf
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE	0
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD	1
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK	2
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK	3
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK	4
> +
> +struct drm_amdgpu_profile_in {
> +	/** AMDGPU_PROFILE_OP_* */
> +	__u32	op;
> +	__u32	flags;
> +};
> +
> +struct drm_amdgpu_profile_out {
> +	__u64	flags;
> +};
> +
> +union drm_amdgpu_profile {
> +	struct drm_amdgpu_profile_in in;
> +	struct drm_amdgpu_profile_out out;
> +};
> +
>   /*
>    * Supported GPU families
>    */
> 
