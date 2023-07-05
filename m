Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83BDEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 05:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B5510E1BB;
	Wed,  5 Jul 2023 05:53:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3096D10E1BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 05:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrn564h5BwbdEDI7mfCZkHDq1Ftdv1+bko8KpCicyyV4R2oCBJ9KidVbyHx19exeQbKJqzdQMJWnIYLJRobuEvdz5kLzPHWU1tVnfRXaZSBIh+BupYmfoziSFeh1+Zuu5N5uV0whu7CGoihYfRFY6O2sxT8zmgr3zW7usa0FTJYZVfFJJ53bpQS7mtITZp4CPcW4bhRPWDlF+Qc1vYK8zolmRHNnDWPtZvsLHrjMnPScmSGX2eDDypBw3C71qCSDor9ItQzQkVqRB24Jzrl52wzvHDr3yZhDezLbPNVnMFAwsfTpsWh47lAQ59jVQQhGvVQBu+dmR4EPiUQp+E9gOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC26V/RX6meHB0raNy97jXISPVQzkM8fZH2GZFUZsNo=;
 b=kP6bwWZeqklBooSw0KSTbFKucTWqlIClEmB+WLOnyJCp4OHWyPcei/pFUH8EevYhVCitPZUbL6rxj4SK32Ja0pD9fvFcSHL0X2vFnM6LW51WCSCsLNaZv/tQtG7FRzcm0+cANO999cXpsRzC0dRxbQmI7+b3X+sSW9JwKgmox+ltHlDsl3XpjslDLAlnMnvc0NFB+jkzPvDtyxrHFXKJMkgn+9NRYpI6WRMNpYcSpAd6Y1uaYRGJPhOhGHr7c3Rw8uDP4QGomLJx4Esk1MjQ2ITG3VyJg+h5SeVsBN+GVqO7bddMaRuVlqpeS6RI4W3r1+qHoAQLTvwW6Xfne8esBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC26V/RX6meHB0raNy97jXISPVQzkM8fZH2GZFUZsNo=;
 b=H53To9hQn3PFXMgmY5FuNWQbp6sIIRa8I2FmWNX8n4aVd72+6q1QMsjAEmOe/4yHvpa8UNKuWZGg+wzzpSCiIMvTrMscTZrdLxDW8b1l8fGfVVm6CkQIbiyxmjCJkhTi6UMvjTYYW9TjWLNBq8hIUk5DE0+wXDNJrZ1iXP4QMiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:53:33 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6544.031; Wed, 5 Jul 2023
 05:53:32 +0000
Message-ID: <48b4c013-15ef-2f39-937c-7bab3fc91bd2@amd.com>
Date: Wed, 5 Jul 2023 11:23:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: disbale dcefclk device sysnode on GFX
 v9.4.3 chip
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230705054618.3674372-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230705054618.3674372-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: bb77a095-6212-4708-4788-08db7d1c2a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OI2U/OW2xCilxWBOt9U06MCe/4Fos0x9gzUqHxnn+6vMSHii1Kl94v0K7chq6mMiHlhVvNxp6+Zs3inwcab1uHwLyRvkfFZQOrkjawX266RsIxWL1TNk7w0Qdc9V6Z7BvfUVaJ52HGhwvyHlp9PeFQHRgKr3E1zYwVZBDzbmuMTnduS6cJPTXW4UDjbd/wix/TeS1qV3nyPQugMIzR6Eks1EIstHZOY9dtkbANiJd3crIUSq2et5W01iD2f+fhozbXRhz8qfrjF1ClKZ+YmZHAMhRBtkfLlw+dh3ciJZGvfFoBcBBA6zgab02Qup8zWkWXWAfzdBDB18yUY77Z7aUywI69t0mk6Hr5ZmaC2Xc7VdSHv5jZFy1sKQQaNim1X7Sb+afE1CC4+uH62H47dnUvle0LQ0FhkVYq4OfiuBcHQr2Zf5pPwLFZ+BnKkCThSgUH7k8ycaFDScGtt7J+GSgPLKFcjKXA1OdQkgiQ4aAD+zBE+WW8Unx1S/6r7fN35X/34MEHjK/PkdY9zvF+4dK8AgmBeb/NhPhdPfuvAupaOsK8RUx2MRoogkEtyZAGjTn1Uaa1BDUdgo2z+iQSdbXhSRUD9LCmpwRbYxNcTaomqHMIXp5zQwZ4RiS//1JC4NeLPXk0gNFyuLIPtYQ2RRnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(2906002)(41300700001)(8936002)(5660300002)(8676002)(36756003)(31696002)(86362001)(186003)(2616005)(478600001)(31686004)(26005)(6512007)(6506007)(6666004)(6486002)(316002)(66556008)(4326008)(66476007)(66946007)(38100700002)(53546011)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V29qSTlnOGczU3BVM2svVVdSSkErOGxLVUhLQzY2VXlKbXdFMDFvdCtqZDE5?=
 =?utf-8?B?TlgzTk9mM3hqZlFOZnhjYXRYejQwSzQ5cGFMckZsQUJpMml3YUJudGFkRnJR?=
 =?utf-8?B?dmJUbTF3NityQ3V3WGNHVExZaVpVNVp1VGRiZG05N2l6RlY4V3cxR3RlQ3M1?=
 =?utf-8?B?bklxemxyOEV2VytWak5WdHZlVU5PYkJwQzdkVXd4ajV4QVVsYVhPNVE5OUlw?=
 =?utf-8?B?RU9BTG83U1NURGoyWXlmc0dtUDBJZEVyWVhGbmZMaUdPRldMbGFiSVFGM2t2?=
 =?utf-8?B?QUJBVkNRcS9pOWRZb3RBejV3akVCcEpXUDBSbGNvQ2h5SXdkaU4rZDFsRmxN?=
 =?utf-8?B?ZUhNOHpvaVlXQm5IVmR0dm5uUzgvQVdNU3JzMU5PSzBPdDcyZjVQbit3Q3Q1?=
 =?utf-8?B?cFBjRTc3OURONnNRRU04eWdNcDZoTk0yZ0RKSElhdkZ3dDBPbENPSXlhWTc4?=
 =?utf-8?B?SldxbVpGdERUTWNGOHNDamplWTJ6b3V3QnZjbllIazFyaHdtdmdmSlA5WUYy?=
 =?utf-8?B?cVFTTmR1SWtTbFhmUDhxZlE5aDUxendXOHNhN2dWVENBQnVwbFppaFpvejNh?=
 =?utf-8?B?eCtyWnZZUnMxNElQbnMvNGkwcDlGdUlnenltbXlRT0ZMV21sVUdEdlo2WVg1?=
 =?utf-8?B?U0ptQ0U5YmVaZUZwdWk5UEpXM2FIUnl1TTZaLzkwMVZRMzBkY3IzOGE3RjZH?=
 =?utf-8?B?dmZSRnZBMzFYYVNVZFFrK3pvYXVRdVNnOEw4UDRmYWhibURRNC8vVUtZT05Q?=
 =?utf-8?B?RWxQNGZKTHdLNDVLOGpXT3FYdjhRT1ZYNCtnSkU2b2trZ3lFWHhzQkg4STlp?=
 =?utf-8?B?MExZOElLYUk2UVVTWjRxK084U25lLzZ5eTRreVNKbWx5MFVxUWtXWFVtNTJt?=
 =?utf-8?B?QnJ2V3U4ZGx0cGVaWkNpTEVvd01lMHl4d3k2ZXdLNVNzVjYvQkhWZEx6T2lU?=
 =?utf-8?B?cE5na2JlWFd1cUpLTnRSYytITnhpcnpDNEFYeU5HSEdxY0pQQ2YzZUFBMnRk?=
 =?utf-8?B?akRhMkFIajVVKzc4blBoMHlyalo1aWhaaFlGcGt1SUNwVDJ5Z0hjYTRUN044?=
 =?utf-8?B?ay9kcVpVajFSYkxPWmpFV1BiSmVxSWpoY2JMSUtNb0srMmFjVnZUcDk3Y0p0?=
 =?utf-8?B?QWxPcEwwZW41am83em5EeDV0SkhNdWdzRU10NmhJTThpVmZVQkFiYy9lTkxR?=
 =?utf-8?B?T29mVHU2MzFMSzRvUGc0eTRpK0tHV2ljYjZDdzdyMXhQeVhJdkY1QnV3NkJS?=
 =?utf-8?B?U3lVbnBkMFQwUk9mcDkyaXRVU0FDY2JkVERvVmIzMFVaZzVibEpmNWpqaE9q?=
 =?utf-8?B?L0JWbHFvRjdabkgwdjJOYUhlNEV6N2hUK2QyV2JzWU1wRlVBeDdaeTlIcVAx?=
 =?utf-8?B?VVJVVmxWeGx0Y0tLZjFVdXdSL1NxZEhwbXN0aStQOTE4U0NCVlcwMmRTZlhl?=
 =?utf-8?B?TWIrQk5aVy9tUTUzQitvZnVQWDg1aVZHUXdBcXBCUEdjY0xrK3c1TG9qNGxr?=
 =?utf-8?B?QWlXNG1WTXZvYVpPSnZlYnU1eU1kWWhFSGh4MTJjK1hBR2RINExITFYyWThR?=
 =?utf-8?B?VVlScFRxTHVxajZGamNCSEpCbjMzaU1xdFFyUDNRYUw0VmMxMzN1K3JKWHlD?=
 =?utf-8?B?b0c3NEhQM2cvQkVBUVpyMGN1ZmRoS2w3MFZ1RDV0OC90VEE1V1pZTm9MV1lC?=
 =?utf-8?B?NlNRVjh6djZtSmZLdzhnTzh5OGJZcTYzTnNqU1IyMFFLZ2ExZDliblhOSTdD?=
 =?utf-8?B?QlRZYUdKM25lcjNyVTRwWTR5T2NwZlZrV2RQZFE2WlA3R2d1ZWNwOUFCMmxV?=
 =?utf-8?B?RlRKeUdOd3ZlRWhwQXFEaXNUQW5zcHFTVFFoYktpak9MM2JNczdrSmdSekpz?=
 =?utf-8?B?M2FSQUswakIrd2kzeG1nbW81YUV0OFFOQ0ZXblQ0UjdWZnEvNFpSa2MxVm81?=
 =?utf-8?B?aXFtelF6Q2EvMXFENjF0VnBOUGdUcDBOZXNiRUF1eXloeVVXNGhWUlhaem1y?=
 =?utf-8?B?YjMvd214TEljdktrSHNjY0lCRElBMUdTQkt0NDVsYk9OVXdVQSt4WUtzUXlR?=
 =?utf-8?B?dnJVNEViVzB3YXBRYXJLVGlqV3VhSEpkMTBmdm9BSW1ObDdPVE4vblVmREJT?=
 =?utf-8?Q?LDLIYO8P8+QWNvgSjyRafwBHC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb77a095-6212-4708-4788-08db7d1c2a03
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:53:32.5329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwL6mz1OgkYqAkhIEyfo8gl+n+PqT1IDrxlaaxeQV+VThiqZEwFqeybaxYdyMvcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/5/2023 11:16 AM, Yang Wang wrote:
> v1:
> the dceflck sysnode is not aviable on GFX v9.4.3 chip.
> 
> v2:
> simplify code logic using helper function: amdgpu_device_has_display_hardware().
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9ef88a0b1b57..f6724d633e45 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2048,9 +2048,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		if (gc_ver < IP_VERSION(9, 0, 0))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
> -		if (gc_ver < IP_VERSION(9, 0, 0) ||

Missed this - this remains (no DCEF for old HW) and rest may be replaced 
with presence of display controller.

Thanks,
Lijo

> -		    gc_ver == IP_VERSION(9, 4, 1) ||
> -		    gc_ver == IP_VERSION(9, 4, 2))
> +		if (!amdgpu_device_has_display_hardware(adev))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>   		if (mp1_ver < IP_VERSION(10, 0, 0))
