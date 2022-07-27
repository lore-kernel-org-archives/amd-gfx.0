Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671CAC04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 06:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18DC18B5C5;
	Wed, 27 Jul 2022 06:32:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980A48FD4E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 06:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyD3cas6JzQmSZdDfc0BdkR6dOXkYF/ymIkcdJCfAMXo+/1fP15tst6iPhNDbGq4jxLinmhZX9CybCEOKEu2Dg80Tpg4qA5IQveTm8x/YpEwdLZRimNzeDhkzBnVCMW6afsSkxWzFnIgQ335nrHpka7DwrGanluyMtB3WsgncTLx5unoE1HDRSEVcHjHX/vXqtM0NhfG9zXv43XzzO5c+AMZpa++SuycxpUxeSBK4gCZQGlE8RiaP18NelS7MRugSoNjMBfgCkV5VkGKKMBwNnPf0ooSHyo6V69mPYQGK7Z1/cISPqRLVK7cY5v0myl/txtE/L/3scB8IlcOUHydlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeJTUT/vs2KzuJ5AZ1JTz/MueMmIcTrvfJ1CVXWeOm8=;
 b=LdNPoVdFEyg2NUYiTOYJyHSCnNqVljN8qXT+XmSOQ1VIO9KmoLxNk5UJliFpFRbS/+0d3esuVykBFQBMSwaQTLI+a38UfDbPpl3XdEndjZ+gQK1vXsA0WMA+EoR3j3LudbJoEAkPFp+oRZOGdWChwg/PHo+UINQOpurEZR+2tttmyy6SCkAmflXO96gmbZja9l1WmUrd/P8fF0zZd4bGwq+7DdMZWAqHLl4OZ1Rdfr6sYlA8GnPYqTORF5mYgL6TAC3Biwj7yYSQVD3PO9kUOD+BBHPBqeUEekjHIqRpKoklJzhUzICP19ZkSOBnUriKT61gAMVv+R6Ekeug7x5TQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeJTUT/vs2KzuJ5AZ1JTz/MueMmIcTrvfJ1CVXWeOm8=;
 b=mg1qq6aYKzIoj2I4EDAD+YcGjMyW5hFXmRrVwmm3wFBErziE41WTeRs05anPadUov5BGLZR7EF1JkT+UuMMgWcE22Uhujzrf7PK/dynFiIEF1he4Q3Hbwq1jhqu8GyA3Q1Unh92Dbd34xJ2q50pqFxcV94V/VCvaIC89h0zaH0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 06:32:04 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6d50:f6c5:cea4:1d95%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 06:32:04 +0000
Message-ID: <c3be91d3-a8ee-2e3a-714c-c70229e6ffcc@amd.com>
Date: Wed, 27 Jul 2022 12:06:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report] drm/amdgpu: create I2S platform devices for Jadeite
 platform
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <YuAFgoepMHvkw3CB@kili>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <YuAFgoepMHvkw3CB@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ea05c2-d89a-4b26-db95-08da6f99b888
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5rAqa1cHLHMyaNBLbMaMgFfTydo0//Z1xrNw48aWPKpWoObALtSn4FZA592Kv7p85+YZBZc+8qUhk2dy+5J+S7ZXxapBG0OKGgTW+AvLDrve6eGPyrOgL4qXWoqBUplmshPMTZxYZOVkxzzpmaQQmFGGB9K4cq6hbHdNGdW0bz+kZLNHtbrRll9MFCmBne2wb8TAO8EKRgkaqr2HGcCkZTFLLy5X0QF6zvrRb+XWiGSYX9sjzc4oKUnMFk/UepNDg1naoFzpl1ZP2CZ3z63CKvKVUTxi7iOnCU51K0J4xts6K1ONEG3BUTGpxwv0a0S9oxhAAiQhjHMsBPXCR8/c5f/InSgrzRRXVL5KVXe7i1bMN8YBb2qgW0h3y1wXiJQ/8zkAisbM7xH23duI9kt+HIDhpqXhXT7qlUoRuD8XRuE3LKV/z4RNR2HcPjxnAnxXdcNHaDhrWWZ5T/IHYJlqzH8JdyEttOeKwGidEYRj2rOB0gZp3o2CLJdJJV5qFn9UsPP6S2SrZ9P0ClrtDQ03BItM24hHeiBW4deMZpDRzdPIKbk5/1QVVSUPaVHphSdaXhPm/MLB0m91YMXdXgQ6feyvXcF23dtk74wOqN7egPFH/C7Kcq+qz5a2SlSswISN7qCJJ0tTVqJqOaCG15wzdA1CXonHpQDmT6sh0lwYJdE/mja+6u5BKbThNUDGJ2w7+rjvkC9P6V66myTji0XN56CLqh0EkkFWyffauj7EJM06BAcRmN+FqlcS6fjxSJ8nz3hDyFCzfLLG0vSH9+2zj9GyjKwMFlNrBTR+EeVMz+ijuwhujC3xZOlej6Aw/jTwnLrD0bJNdEOW3eMtLxl0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4123.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(8676002)(4326008)(66946007)(66556008)(5660300002)(36756003)(66476007)(30864003)(8936002)(6486002)(38100700002)(2616005)(2906002)(53546011)(478600001)(31696002)(316002)(41300700001)(186003)(6666004)(6512007)(86362001)(6506007)(31686004)(6916009)(83380400001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHl5NUkyN0ZCbzlINGI5cmswbnY1dU51N0VraWJSWjBvYkIyRWdCQUtpRjdF?=
 =?utf-8?B?cHl4L0JyL25LMTRoVCsrK1loT1VqSkRnQ2J3bDlhd3dTOTZPY3RBandlTnFM?=
 =?utf-8?B?UWZTWjVDVGtMYUhQOTJGaW1aRG5YamJOT3BFYjU0QjM1d3RwMnhEeDdhV0NW?=
 =?utf-8?B?MlJKSzVxSXJjcWdWdHYweThKajdJWHlRUnFNc3VaTHdJVEpzODVqZ3ZjTjJy?=
 =?utf-8?B?eFd0bkxwbTQ2RFhzZUM1d0ZBdjFPRE1PZTNuT3p2TUVvbzY1NUN3bmFmeXBh?=
 =?utf-8?B?bUN0eU1LaUFFTUFidmpZUm1vZ3BiaGMrdmlmMXpMNGN2OCtYU1MvcG1hNmdj?=
 =?utf-8?B?S3RSbENSY09HMFlKbWhpZUpidWJPZExtT3FuazZFanJNREpkN3g5Rm5QNWw1?=
 =?utf-8?B?M1pjd2t0Z0U1RnFna3RKeVdUbHgyM1V5TndjeUZTbUNqdWNLQnUyZ3VYTzNy?=
 =?utf-8?B?Ui9jRGJzY1JIZmNLSkUwejRCdmFEd1ZGU0NKMVA1am44V1ZsTmdZRmFaOGlY?=
 =?utf-8?B?S3cxUDlveGFRcFhLMUVZVTNWUk1QRFlMU0YxME5jdVp4SGVmOVpRZGF3MHZK?=
 =?utf-8?B?d1MvU1NvdTllRnQzRTJBQm9lS2NUd083K21FM2cwUGhVWXFvWFRrd0JmS0N3?=
 =?utf-8?B?SHhob0wwZ1NDcCs0Tk5Mdm90RHMxaVB1REJGTHBOMWFacmRJb01WV0dKR3Bo?=
 =?utf-8?B?cEh1WW9Ka3lLRUVZTmxBZUhQRTBIbWRCQU5CUWVWdERObDAwdXhWMitNWlJX?=
 =?utf-8?B?OXpvUVNRTW8wTTFDSC94Um1lYXdHSnErQXpvaFMya3JXUnNaZ1pxTE1pMXdq?=
 =?utf-8?B?SjNGK2I2RDJ6QURVSFNKMUJsbWR4WXhxNE45UktSNmtsaUprTkgxVWpTa1Vn?=
 =?utf-8?B?MmVsbVBwNTduQkRMeGFVWi8wcVRrTTZJM25GWGxUTkZBRjh1Qjd1Z3pSeStl?=
 =?utf-8?B?Y2dCZGZUQjArSlBsaTdpMVhobk1pNTNDZ2Jab0dKeEF4TmVvcSthc1hWeFI5?=
 =?utf-8?B?WDZsWkVqdHhYTFRyUWpQMHk1cy9Nc05oT3UyRGJ2VGhHRDZadFgyZmMxdGUw?=
 =?utf-8?B?bHMvaThZZ0Zsb3llcFFZRzI4bWZTc3VRUFo0RWFZZnVpTUFvYTMwUmFRYzRT?=
 =?utf-8?B?c0YvUnZsTkNsR0RoRVBwczlZVjFId3E0L0toY09XVjZnZVkrSThvNE52d1dE?=
 =?utf-8?B?U2V2bW1qOTllU0k1OGEraEpvK0g5TzdWM0laQnpGNGtaYVJBMkZSME9aVjVm?=
 =?utf-8?B?V2NjNXNzS0xSV0gwMmg3b21admcrb2NsWmozSVM3Z2gxRjhXWDYzR005MXVH?=
 =?utf-8?B?SkZUR0JnRElxYWl6QXpZTFllYk1VUCtlbGhURXZqZFpEaWZCVXEwTk9Yb3JB?=
 =?utf-8?B?SFBDYWhnUUd2Y25TVmZ6UWhvUG9NanZOeXB3OUQ0R0xUM25sTnljMXZrWW85?=
 =?utf-8?B?Y2ovRzJ6R3JxTGdhVGkxcU9TM2tlOHlWWVV2Y08zdWhncFdGYVhLUmZXaDFX?=
 =?utf-8?B?NnI3MFA0VlNPTjhvYkpyS0lYT2V1MnczbDJGN1BrMlB3NU9seUgwNHhpVXdD?=
 =?utf-8?B?a2JLVkwyMkdkbzl2MWJmc0VacDFDTFo5MTdwM0M0OWFNQjd2YXRBMWJFSEJ5?=
 =?utf-8?B?azNpM3oyd0MwTkl2WXJ3UGxLRE9FWDZtbHdyWGpDOW1XM1pwNVpXRldXa1Vq?=
 =?utf-8?B?dm1McWlFM2swem9DOFVlNy9LdXprMnYwV2dSU2ZZdXQzQUFmcm1pdFM1dGYz?=
 =?utf-8?B?UzNKQjRpaThwWnBPd2g3a1dxQlVieGtsdlUwNDl2MkZuZ1QyM1A1b250a3RV?=
 =?utf-8?B?UGVYcEtGeDVnOHhxNVQydUdXZzFBdzViTUFOQWFIWXA2TCtWSjhmRy9CTm82?=
 =?utf-8?B?T0hPVWNFUDR1TWlIdHJZRkFQWnVHMmdpWTV6SEhGdndLSEgwYWs5N1RzRnpU?=
 =?utf-8?B?UWtLdlFmNGErbHJHNURvTmFLOHhNS0kyMlp5ekQvcGxWNTVoY3pkS0JBNlNm?=
 =?utf-8?B?MFh4bVpUanBselpvcjQzSUVMQ29kdU0wWlVLQjU2MkdCdXNBWnltQmlGM1ho?=
 =?utf-8?B?aXE3TFRsd2l3VElvY3BhQ2NWZWs1V3dRN3duMklMRlNvQWVFYmo5OFFLL0Jh?=
 =?utf-8?Q?EjfH2HFiT7AsQzc2jW62fL2A8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea05c2-d89a-4b26-db95-08da6f99b888
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 06:32:04.6752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrwbEN8WPtf4aN3mRp+sce9jUa0x9L09Mh1quQFr3cvgFzoKMRMGtTCTcK63BQMjPKcHcETb4BVj+BMFwfeUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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
Cc: "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/26/22 8:47 PM, Dan Carpenter wrote:
> Hello Vijendar Mukunda,
> 
> The patch 4c33e5179ff1: "drm/amdgpu: create I2S platform devices for
> Jadeite platform" from Jun 30, 2022, leads to the following Smatch
> static checker warning:
> 
>     drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:393 acp_hw_init()
>     error: buffer overflow 'i2s_pdata' 3 <= 3
>     drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:396 acp_hw_init()
>     error: buffer overflow 'i2s_pdata' 3 <= 3

will fix it and provide a patch.

--
Vijendar
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>     225 static int acp_hw_init(void *handle)
>     226 {
>     227         int r;
>     228         u64 acp_base;
>     229         u32 val = 0;
>     230         u32 count = 0;
>     231         struct i2s_platform_data *i2s_pdata = NULL;
>     232 
>     233         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>     234 
>     235         const struct amdgpu_ip_block *ip_block =
>     236                 amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ACP);
>     237 
>     238         if (!ip_block)
>     239                 return -EINVAL;
>     240 
>     241         r = amd_acp_hw_init(adev->acp.cgs_device,
>     242                             ip_block->version->major, ip_block->version->minor);
>     243         /* -ENODEV means board uses AZ rather than ACP */
>     244         if (r == -ENODEV) {
>     245                 amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
>     246                 return 0;
>     247         } else if (r) {
>     248                 return r;
>     249         }
>     250 
>     251         if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>     252                 return -EINVAL;
>     253 
>     254         acp_base = adev->rmmio_base;
>     255         adev->acp.acp_genpd = kzalloc(sizeof(struct acp_pm_domain), GFP_KERNEL);
>     256         if (!adev->acp.acp_genpd)
>     257                 return -ENOMEM;
>     258 
>     259         adev->acp.acp_genpd->gpd.name = "ACP_AUDIO";
>     260         adev->acp.acp_genpd->gpd.power_off = acp_poweroff;
>     261         adev->acp.acp_genpd->gpd.power_on = acp_poweron;
>     262         adev->acp.acp_genpd->adev = adev;
>     263 
>     264         pm_genpd_init(&adev->acp.acp_genpd->gpd, NULL, false);
>     265         dmi_check_system(acp_quirk_table);
>     266         switch (acp_machine_id) {
>     267         case ST_JADEITE:
>     268         {
>     269                 adev->acp.acp_cell = kcalloc(2, sizeof(struct mfd_cell),
>     270                                              GFP_KERNEL);
>     271                 if (!adev->acp.acp_cell) {
>     272                         r = -ENOMEM;
>     273                         goto failure;
>     274                 }
>     275 
>     276                 adev->acp.acp_res = kcalloc(3, sizeof(struct resource), GFP_KERNEL);
>     277                 if (!adev->acp.acp_res) {
>     278                         r = -ENOMEM;
>     279                         goto failure;
>     280                 }
>     281 
>     282                 i2s_pdata = kcalloc(1, sizeof(struct i2s_platform_data), GFP_KERNEL);
>     283                 if (!i2s_pdata) {
>     284                         r = -ENOMEM;
>     285                         goto failure;
>     286                 }
>     287 
>     288                 i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
>     289                                       DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>     290                 i2s_pdata[0].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
>     291                 i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
>     292                 i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
>     293                 i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
>     294 
>     295                 adev->acp.acp_res[0].name = "acp2x_dma";
>     296                 adev->acp.acp_res[0].flags = IORESOURCE_MEM;
>     297                 adev->acp.acp_res[0].start = acp_base;
>     298                 adev->acp.acp_res[0].end = acp_base + ACP_DMA_REGS_END;
>     299 
>     300                 adev->acp.acp_res[1].name = "acp2x_dw_i2s_play_cap";
>     301                 adev->acp.acp_res[1].flags = IORESOURCE_MEM;
>     302                 adev->acp.acp_res[1].start = acp_base + ACP_I2S_CAP_REGS_START;
>     303                 adev->acp.acp_res[1].end = acp_base + ACP_I2S_CAP_REGS_END;
>     304 
>     305                 adev->acp.acp_res[2].name = "acp2x_dma_irq";
>     306                 adev->acp.acp_res[2].flags = IORESOURCE_IRQ;
>     307                 adev->acp.acp_res[2].start = amdgpu_irq_create_mapping(adev, 162);
>     308                 adev->acp.acp_res[2].end = adev->acp.acp_res[2].start;
>     309 
>     310                 adev->acp.acp_cell[0].name = "acp_audio_dma";
>     311                 adev->acp.acp_cell[0].num_resources = 3;
>     312                 adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
>     313                 adev->acp.acp_cell[0].platform_data = &adev->asic_type;
>     314                 adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
>     315 
>     316                 adev->acp.acp_cell[1].name = "designware-i2s";
>     317                 adev->acp.acp_cell[1].num_resources = 1;
>     318                 adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
>     319                 adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
>     320                 adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
>     321                 r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, 2);
>     322                 if (r)
>     323                         goto failure;
>     324                 r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
>     325                                           acp_genpd_add_device);
>     326                 if (r)
>     327                         goto failure;
>     328                 break;
>     329         }
>     330         default:
>     331                 adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
>     332                                              GFP_KERNEL);
>     333 
>     334                 if (!adev->acp.acp_cell) {
>     335                         r = -ENOMEM;
>     336                         goto failure;
>     337                 }
>     338 
>     339                 adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
>     340                 if (!adev->acp.acp_res) {
>     341                         r = -ENOMEM;
>     342                         goto failure;
>     343                 }
>     344 
>     345                 i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
>                                             ^
> 3 elements
> 
>     346                 if (!i2s_pdata) {
>     347                         r = -ENOMEM;
>     348                         goto failure;
>     349                 }
>     350 
>     351                 switch (adev->asic_type) {
>     352                 case CHIP_STONEY:
>     353                         i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
>     354                                 DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>     355                         break;
>     356                 default:
>     357                         i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
>     358                 }
>     359                 i2s_pdata[0].cap = DWC_I2S_PLAY;
>     360                 i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
>     361                 i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_PLAY_REG_OFFSET;
>     362                 i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_PLAY_REG_OFFSET;
>     363                 switch (adev->asic_type) {
>     364                 case CHIP_STONEY:
>     365                         i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
>     366                                 DW_I2S_QUIRK_COMP_PARAM1 |
>     367                                 DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>     368                         break;
>     369                 default:
>     370                         i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
>     371                                 DW_I2S_QUIRK_COMP_PARAM1;
>     372                 }
>     373 
>     374                 i2s_pdata[1].cap = DWC_I2S_RECORD;
>     375                 i2s_pdata[1].snd_rates = SNDRV_PCM_RATE_8000_96000;
>     376                 i2s_pdata[1].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
>     377                 i2s_pdata[1].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
>     378 
>     379                 i2s_pdata[2].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
>     380                 switch (adev->asic_type) {
>     381                 case CHIP_STONEY:
>     382                         i2s_pdata[2].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>     383                         break;
>     384                 default:
>     385                         break;
>     386                 }
>     387 
>     388                 i2s_pdata[2].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
>     389                 i2s_pdata[2].snd_rates = SNDRV_PCM_RATE_8000_96000;
>     390                 i2s_pdata[2].i2s_reg_comp1 = ACP_BT_COMP1_REG_OFFSET;
>     391                 i2s_pdata[2].i2s_reg_comp2 = ACP_BT_COMP2_REG_OFFSET;
>     392 
> --> 393                 i2s_pdata[3].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
>                         ^^^^^^^^^^^^
> 
>     394                 switch (adev->asic_type) {
>     395                 case CHIP_STONEY:
>     396                         i2s_pdata[3].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
>                                 ^^^^^^^^^^^^
> 
> Out of boundses.
> 
>     397                         break;
>     398                 default:
>     399                         break;
>     400                 }
>     401                 adev->acp.acp_res[0].name = "acp2x_dma";
>     402                 adev->acp.acp_res[0].flags = IORESOURCE_MEM;
>     403                 adev->acp.acp_res[0].start = acp_base;
>     404                 adev->acp.acp_res[0].end = acp_base + ACP_DMA_REGS_END;
>     405 
>     406                 adev->acp.acp_res[1].name = "acp2x_dw_i2s_play";
>     407                 adev->acp.acp_res[1].flags = IORESOURCE_MEM;
>     408                 adev->acp.acp_res[1].start = acp_base + ACP_I2S_PLAY_REGS_START;
>     409                 adev->acp.acp_res[1].end = acp_base + ACP_I2S_PLAY_REGS_END;
>     410 
>     411                 adev->acp.acp_res[2].name = "acp2x_dw_i2s_cap";
>     412                 adev->acp.acp_res[2].flags = IORESOURCE_MEM;
>     413                 adev->acp.acp_res[2].start = acp_base + ACP_I2S_CAP_REGS_START;
>     414                 adev->acp.acp_res[2].end = acp_base + ACP_I2S_CAP_REGS_END;
>     415 
>     416                 adev->acp.acp_res[3].name = "acp2x_dw_bt_i2s_play_cap";
>     417                 adev->acp.acp_res[3].flags = IORESOURCE_MEM;
>     418                 adev->acp.acp_res[3].start = acp_base + ACP_BT_PLAY_REGS_START;
>     419                 adev->acp.acp_res[3].end = acp_base + ACP_BT_PLAY_REGS_END;
>     420 
>     421                 adev->acp.acp_res[4].name = "acp2x_dma_irq";
>     422                 adev->acp.acp_res[4].flags = IORESOURCE_IRQ;
>     423                 adev->acp.acp_res[4].start = amdgpu_irq_create_mapping(adev, 162);
>     424                 adev->acp.acp_res[4].end = adev->acp.acp_res[4].start;
>     425 
>     426                 adev->acp.acp_cell[0].name = "acp_audio_dma";
>     427                 adev->acp.acp_cell[0].num_resources = 5;
>     428                 adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
>     429                 adev->acp.acp_cell[0].platform_data = &adev->asic_type;
>     430                 adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
>     431 
>     432                 adev->acp.acp_cell[1].name = "designware-i2s";
>     433                 adev->acp.acp_cell[1].num_resources = 1;
>     434                 adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
>     435                 adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
>     436                 adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
>     437 
>     438                 adev->acp.acp_cell[2].name = "designware-i2s";
>     439                 adev->acp.acp_cell[2].num_resources = 1;
>     440                 adev->acp.acp_cell[2].resources = &adev->acp.acp_res[2];
>     441                 adev->acp.acp_cell[2].platform_data = &i2s_pdata[1];
>     442                 adev->acp.acp_cell[2].pdata_size = sizeof(struct i2s_platform_data);
>     443 
>     444                 adev->acp.acp_cell[3].name = "designware-i2s";
>     445                 adev->acp.acp_cell[3].num_resources = 1;
>     446                 adev->acp.acp_cell[3].resources = &adev->acp.acp_res[3];
>     447                 adev->acp.acp_cell[3].platform_data = &i2s_pdata[2];
>     448                 adev->acp.acp_cell[3].pdata_size = sizeof(struct i2s_platform_data);
>     449 
>     450                 r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, ACP_DEVS);
>     451                 if (r)
>     452                         goto failure;
>     453 
>     454                 r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
>     455                                           acp_genpd_add_device);
>     456                 if (r)
>     457                         goto failure;
>     458         }
>     459 
>     460         /* Assert Soft reset of ACP */
>     461         val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
>     462 
>     463         val |= ACP_SOFT_RESET__SoftResetAud_MASK;
>     464         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>     465 
>     466         count = ACP_SOFT_RESET_DONE_TIME_OUT_VALUE;
>     467         while (true) {
>     468                 val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
>     469                 if (ACP_SOFT_RESET__SoftResetAudDone_MASK ==
>     470                     (val & ACP_SOFT_RESET__SoftResetAudDone_MASK))
>     471                         break;
>     472                 if (--count == 0) {
>     473                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
>     474                         r = -ETIMEDOUT;
>     475                         goto failure;
>     476                 }
>     477                 udelay(100);
>     478         }
>     479         /* Enable clock to ACP and wait until the clock is enabled */
>     480         val = cgs_read_register(adev->acp.cgs_device, mmACP_CONTROL);
>     481         val = val | ACP_CONTROL__ClkEn_MASK;
>     482         cgs_write_register(adev->acp.cgs_device, mmACP_CONTROL, val);
>     483 
>     484         count = ACP_CLOCK_EN_TIME_OUT_VALUE;
>     485 
>     486         while (true) {
>     487                 val = cgs_read_register(adev->acp.cgs_device, mmACP_STATUS);
>     488                 if (val & (u32) 0x1)
>     489                         break;
>     490                 if (--count == 0) {
>     491                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
>     492                         r = -ETIMEDOUT;
>     493                         goto failure;
>     494                 }
>     495                 udelay(100);
>     496         }
>     497         /* Deassert the SOFT RESET flags */
>     498         val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
>     499         val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
>     500         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>     501         return 0;
>     502 
>     503 failure:
>     504         kfree(i2s_pdata);
>     505         kfree(adev->acp.acp_res);
>     506         kfree(adev->acp.acp_cell);
>     507         kfree(adev->acp.acp_genpd);
>     508         return r;
>     509 }
> 
> regards,
> dan carpenter

