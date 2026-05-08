Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C071CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 05:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34E610E5B3;
	Fri,  8 May 2026 05:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UUraZHZ/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD7A10E5B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 05:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZMclkI7cN675BesV1Uy/0Mk1eaxoV8NjEXy4gDL3hyjnw9EvmV+HfOi/BVXPTeO0vJqAN2NIaCkeMbYpNxlBkLENReVhSl7KxXG2jAmavognlFv2ERSYr4/GALSFDoLB1z/9XejuIlTiseykPwDVOWEfjbKm9fKI4cyFZAdwznY1nDFCSbOGTC8H5bg9d5kSRZbvFjDwEzSwvoCxXPXEa0JRIMTaSMu82AWy3i89L+MNKbuPkoj89LaxGB2Xemm9a877ahKh8c6+PG/MHh8lVWmA6D8g07FvtgDjarDNOV7XtUxI+1OIpCS0oZgeW1k4VmVjxY8sGFtGP5E9wh5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZdmmmfd//CZn0CpElDP6sE3dF+xo/g7SBp+pTb4B+Q=;
 b=Qhrg6WJGYZzNfzlvXL4QzK15y4cQcw1XbkLaNsx8cCLbuuSSLkI9ZcI0gPSNat5BjvQA1CN2Qh+g5y3d275rznDJK6F/caPm2sdSYY0iymIxRznuO9W/gks1T57m85X97m5Ie5UEhKn7lm6kraaKomVp6DciPMLSpp3OMzEKASdyCmigGbDe4l6KcbJb+BZ9RngkqtzswOgyf8Ky2md+H9BNzPZVgkfmq4CSrH6eXNFmC5H+IduQEJ0kcj+q2kUZ933Dp2EfU7UE3Kbk5iy3wE5GF8ubp5KCHYBjq6AXRaY9J7YpzJme1LaXjozMV9jlzXIBZSIG4PfK6N5FMgNnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZdmmmfd//CZn0CpElDP6sE3dF+xo/g7SBp+pTb4B+Q=;
 b=UUraZHZ/U6cnJGPkm3Fj5IfEaiWgXUFn0FRSU0wvQDNJJKVgBH7KWyE99KRu1IcVz+WMCIALmKkIm8hYofjqZlbZepfkvif3gdrxImcAjscgaviQN96/lM7tiCJFsnvvm320UpE15V/sXMmncfWrkYacYW31MT3ei3FNTTMVyCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:33:08 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 05:33:08 +0000
Message-ID: <1c6ae354-1490-47ca-8b96-079660dff210@amd.com>
Date: Fri, 8 May 2026 11:03:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260508032019.1617320-1-kevinyang.wang@amd.com>
 <dcfc25a2-5aaa-4c62-b684-a70f97f82516@amd.com>
 <DM6PR12MB2972C70BEDCA9C6D968AB851823D2@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972C70BEDCA9C6D968AB851823D2@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ef3248-3e4e-43c7-ba51-08deacc3490e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: iOds4pqCpNK9YM/f2FZhaBtm+15Wt32aMkZJ+GtWGcAn7rtxHFvtBVkDUkOyVXBKNcHcweIC8Y8q0m/lHRd43XHhAFBF3Yz71Md1cMii9RF4aA+3ZzkcIOuxW8gW8KV0NAyh1akeP8mzcoAao63yh4wE1jY+L/2mTCAx14RoKjS0xeNM2Z/Tcne9sdVATwFmqUcqW6OwsqCLUZjZkuqRueXf5nXI8XRi+ybyKKxkVIgNQkd6vEl4xulKfTHTfWAN+Y8FLgXbcejujqhW0VCL/hYcAaGWUusjZSQCNzOfoXbPvOD1onnExZ6xd7Yjz8c/u7aqigmtBVG/fUZADMy9VGiVIH04nnkcs4vNgUWE+IkkEKSeWc/Icw8AQdlGbNpgGC5AQt9FVqxagQ364cclcOdVM07J7p8ddfa5Y1RSGSjD/gkJ+dt6KLnauEupOWi5I1wr44tj8UTf7tAjtg5LR6o/WqltvgP3t0rAkbFvVt3nL94t2hAEM1XxVxyQt5w7+PhudMQCuAaqQK8r2NtXA+wpIJAphrTII/WXVaPkNWXPKwS3r7bAA/OLEAe4pVzkFfLQOvwTZBC/qYaurq6DrZyy9Qy8GwqPZIkyDdqZq40uUwHFuqPVwRJeXlq8FssvD3Usj2zTgoyyWxMFGcJAiw+7p4iYQtxAyxBeae1+DUbFeqG8N6Y6mBM8M51TEilW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRHNjNjTmdUQ0pNdW40d1hnRHlPSTdaMUIvWGhzcDZHVjBXUlVSakxUbitG?=
 =?utf-8?B?Ym8wNk1KSGlLbEY3aTJTOHJlL2dyWkp0dUtTWWFBcklWMnRPTWpWNHNnTy9s?=
 =?utf-8?B?clRXK1E5Vk1kelJXNkpROUpETE1HblZ0NXFZSkNuQmxxVnBUakowaGRSaWU2?=
 =?utf-8?B?aE41TmJ4SURVWWFRNTMzeE45d1V0VjdlRGFHYTFwbE5KbndnR3pIZ05HY05E?=
 =?utf-8?B?TWtyeGxOSHJBSlBuUW0zdGpmTDRUalg0VU5IVldJZm5vaGUrNEoybHMyMnhO?=
 =?utf-8?B?WlNYNzB4RW44VDM4ZEdqb2VLNGlLNmZQa0s1V0k5TzV0eHdHWnRsM3pGcnZ0?=
 =?utf-8?B?YjN5bGJaRk5ZSlh6ZVcwMWhaSzdGQk4zNWZSYjNjTk5oRkpDTnQvUE40eGFP?=
 =?utf-8?B?SDJRcHEwYjJxODl2L01VWHcwMFhTZU01djh4VW1yTFVxL000RGplNXMrZzd2?=
 =?utf-8?B?QmRRT2NUSFFwM3RyQlZHUGZZREp6cEZzSFRYNmJaSUJabG5qWmpTSDdFdzJI?=
 =?utf-8?B?djdHUm9veVhxWkhmbys2cGtQS3BaeFBWRnZvYmpsNFljci83bXovNmNmUlJk?=
 =?utf-8?B?VUJubkRsb1k1VG9KQlFYWmtqVmNCOXp6MHV1dlBhKzl0cjM3aGJ2cmhMWlE3?=
 =?utf-8?B?RlNBaERxcU5iUzkxYTJkREJNbS9EcEdsQW1sOUdrMGZOajVZajZFUXcxNzZI?=
 =?utf-8?B?dm52em5VYTZMVVlqenBKajk0L1pBZ1BMbnpTOS9WV21ISE4wZXdFV3ZZY0sy?=
 =?utf-8?B?c0E0YUZPRzhtM21neGNqbGgzd1Z6c1RuclRsVGUweGRKak80VFpFRnFrWEp5?=
 =?utf-8?B?aUZPbk9FQW9leWxxNVBMSXJmMW5VaktuR1pPTEdyTUdycWZDQjZqcjNodGNF?=
 =?utf-8?B?QUp0MjdPTnZTeVFIUk02RTVmOVViVmttWEh2WHR4L3FESGdqUExhWTRiMDRZ?=
 =?utf-8?B?S3kxY0RidUt1bmxYUS9Ba0RaS2ViZldXZFh1Q0xnYnI3NmowTUVqa0VwM3JP?=
 =?utf-8?B?ZnRWL1Q2eE9DSVA4UGx2NnBUQW1qSWp4QXJCZGw3MEt6REZyc2pFUGpNV2xZ?=
 =?utf-8?B?cXBTemZ0UHQrNG44aVBQNDFCUG1XMk9TNmpCbzBVcXpVbzdqQnFqeXd3TUFE?=
 =?utf-8?B?VzZ2OEduc1Q1MEVRNVVWRVdlZFY0VWttZ01wTXhtZkM1Zm00SXduOEdNbjZ4?=
 =?utf-8?B?NGExcTc1cFlpaDhIaDJzOTZvQ3kvdFp1aEd5eGtJNFp2S0srbmlROUtrUzhl?=
 =?utf-8?B?RlZVRFRtK0YrazdIcldtbHA2MU92NEpFaHJWVnEzNFVoWVB6dmVvMmowNkR0?=
 =?utf-8?B?a25ONER0UFFGeXp5MzFEeEZCMURzNjZSSmNSTnZiL3Jsc2YvVHFoYThqd0VW?=
 =?utf-8?B?cVVYNW0xR2pXQ2Voc3pmdVpQWFJlRXpURWR3T05ubmNNL0N2Mml2R3NKKzRV?=
 =?utf-8?B?U1dWTzJ1aU55RzU1QXBoSXlaRTV4ekpiUkNEM0RGaTNiV1dGM1lsVlNsQStJ?=
 =?utf-8?B?NldtdnEzUmJ2UmdiYVZvK3hzc3NVdGVvSnY4LzhkNHNLcklxWWRiYnpEeG5F?=
 =?utf-8?B?dkcwL0FGSEd3WmxlQ3hQeE54cGxGTDhDZXJNL0d2bEtqOHNWb0IrSjhZeStQ?=
 =?utf-8?B?ckNZbmxxRjN6d0c3dXVVVGdpM1F2OFZqcjdVeldtUytueDdoakhuQk1kVU1m?=
 =?utf-8?B?c3VOYVliQXA0YzRwa3VjZlIrNllna01lUGJ5ZGZub3U4S2xIc1VCanZHNXho?=
 =?utf-8?B?Z1pDWnhTMmpsMzY2TG5NMGU0SVFMbzFVdHIwVzVRZXZvamF2TWVUZ2VxRVJT?=
 =?utf-8?B?VWY4S1JjSWJYT3hKZVlNWmU2Y3QrVmVjNjBIc1gvQVJOUFFQaEZkdkg0WjI3?=
 =?utf-8?B?RTFvOEtVN1FLNzB0Nm96d294cXVNWko4ZDRrSGJyTHNkRVpBYlI0MjM4cmh4?=
 =?utf-8?B?alQrdFVjMCt6UzJUZzZXUEF4WWNFNjMyL1ptNnl4bXNzNjkxME1iSTE4cVlt?=
 =?utf-8?B?ZXlodnppWjNnTHRYQWVnMGlKOHRBY09qdGE1YlZYUmxGcW0xb1dDNEQrU21p?=
 =?utf-8?B?MWo5dHF0ZGgwVGpsWExWUm1IM0ZSZmhOZ0c1UXRNWXVwUXk1aUdrWFoweUZL?=
 =?utf-8?B?dVdNdzdMZDdybkZaeXdiZ1RpZkExTVN2TzVaRmcwWFVQLy91NzlZY0doMEJa?=
 =?utf-8?B?RUc5U3lSdVR1YXRRR2pUeGprUlpMaEs4ektTTStCZm9uOHBTY2FNWnpvMEht?=
 =?utf-8?B?Q2J4dktoSGVMcGFQNEZ0MFBmYVVLM3hEdFFja2pJQjR6RXJmRUJUTmVRd3Aw?=
 =?utf-8?B?NHY3QXFoeXZxTC9UTlhERVQ3eVFXeVhLaUg0emtrV0NyMHdXSnAvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ef3248-3e4e-43c7-ba51-08deacc3490e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:33:07.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpF9yT02oCcYu6J8lamXRbtpxYiebjaiipcYzv2x+WJlqmnz9wCpJOiAPm8OjWoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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



On 08-May-26 10:21 AM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> 
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Friday, May 8, 2026 12:35 PM
> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd- 
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> *Subject:* Re: [PATCH] drm/amd/pm: update dpm clock pm attributes for 
> aldebaran (gc 9.4.2)
> 
> 
> On 08-May-26 8:50 AM, Yang Wang wrote:
>  > Split and correct DPM clock attribute constraints for GFX 9.4.1 
> (Arcturus)
>  > and 9.4.2 (Aldebaran) ASICs:
>  >
>  > - Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update 
> comment
>  > - Aldebaran (9.4.2): Add dedicated per-clock constraints:
>  >    * mclk/socclk: Only support voltage control, disable level setting
>  >    * fclk: Mark as fully unsupported
>  >    * pcie: Move multi-AID check into 9.4.2 case, disable level setting
>  >
>  > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>  > ---
>  >   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------
>  >   1 file changed, 20 insertions(+), 6 deletions(-)
>  >
>  > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/ 
> amd/pm/amdgpu_pm.c
>  > index fd2e63530e8c..9ee3053973cf 100644
>  > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>  > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>  > @@ -2033,16 +2033,11 @@ static int 
> pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>  >                       gc_ver == IP_VERSION(11, 0, 2) ||
>  >                       gc_ver == IP_VERSION(11, 0, 3)) && adev- 
>  >vcn.num_vcn_inst >= 2))
>  >                        *states = ATTR_STATE_UNSUPPORTED;
>  > -     } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
>  > -             if (gc_ver == IP_VERSION(9, 4, 2) ||
>  > -                 amdgpu_is_multi_aid(adev))
>  > -                     *states = ATTR_STATE_UNSUPPORTED;
>  >        }
>  >
>  >        switch (gc_ver) {
>  >        case IP_VERSION(9, 4, 1):
>  > -     case IP_VERSION(9, 4, 2):
>  > -             /* the Mi series card does not support standalone mclk/ 
> socclk/fclk level setting */
>  > +             /* Arcturus does not support standalone mclk/socclk/ 
> fclk level setting */
>  >                if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>  >                    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>  >                    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>  > @@ -2050,6 +2045,25 @@ static int 
> pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>  >                        dev_attr->store = NULL;
>  >                }
>  >                break;
>  > +     case IP_VERSION(9, 4, 2):
>  > +             if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>  > +                 DEVICE_ATTR_IS(pp_dpm_socclk)) {
>  > +                     /* Aldebaran mclk/socclk DPM only supports 
> voltage control,
>  > +                      * not allow to set dpm level directly */
>  > +                     dev_attr->attr.mode &= ~S_IWUGO;
>  > +                     dev_attr->store = NULL;
>  > +             } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
>  > +                     if (amdgpu_is_multi_aid(adev)) {
>  > +                             *states = ATTR_STATE_UNSUPPORTED;
>  > +                     } else {
>  > +                             dev_attr->attr.mode &= ~S_IWUGO;
>  > +                             dev_attr->store = NULL;
>  > +                     }
>  > +             } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>  > +                     /* Aldebaran does not support fclk dpm */
>  > +                     *states = ATTR_STATE_UNSUPPORTED;
> 
> I see FCLK reporting is supported in aldebaran -
> aldebaran_get_current_clk_freq_by_table.
> 
> That may also be kept as read-only then.
> [kevin]
> No, it should be disabled, because the fclk is always return 0 by 
> metrics table if fclk dpm feature is disabled.
> 

In that case, aldebaran_emit_clk_levels etc. be modified as well to 
reflect this since FCLK DPM is always disabled?

Thanks,
Lijo
> Best Regards,
> Kevin
> 
> Thanks,
> Lijo> +         }
>  > +             break;
>  >        default:
>  >                break;
>  >        }
> 

