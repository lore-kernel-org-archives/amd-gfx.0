Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A672C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDDE210E244;
	Thu, 30 Mar 2023 11:11:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4700710E232
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkzcn2RUmlpWhcNpYwDlaCERA8WkjTIShSwkZN+bjwtsubfY7UTncvNQVR23MlMPJ18iDHAYQwamsTHcMMuIEhyg95ZUhIiaEG+Gi5PCTFme8KSvdowmS4NOcVnuWtixMsZCk8OcV/BOUqaheX0UASPaXs14Rqu7jKWOOpMS+W63Nn9W2rPF9ad4g1bGWHJvQtnEoJWPVYjVAcVlFUPLRT7KS8I2/AY9WWBDeLvdVdjdp8uMS0EwUPQkv4lC84SAokDJo6F+mjQS9shF04TQMfmYEU5HapKp3X5qyYqTDG4tCHAopXDccN1hAMSZ5nb7BJfxmdwngIW2x4ftBrC/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bmVpj7ff4+B2nufLA6N4PQLvuWbINJdn5+c8jheiXI=;
 b=UJKB7MgVW9Ax29U26+gxe3kyk6Q8OYVYd3oVxnEbpT8m8N5tun06lv8uGQNkjV8WqlBooI1w5RodPL5KVDTkf0qej2sFHiKAXFoV1hPaUJPL8073489JQkNhOkO7vLGD7daX4h7Vu2h6RTUhiOkohr3AIIOo7jZFzckQYDP9BAA0IwNqO+AUhaidoB9/hspnf1sQt3FBj+s16lBotiGka4E2t3DvfeRLFz0g18Q5bU79164JQ2FMGnZNEKp7Q8T8FEz37MiCmirJjzYIx6G8ls58t1Kavk7LQhmvUGBqpDYGprLqFrLEeMUx6bHYEjzsvgS+nmMHsIogj8RbVQegFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bmVpj7ff4+B2nufLA6N4PQLvuWbINJdn5+c8jheiXI=;
 b=hIfdX22SY1LDzGqUDfIGR4+2V+IepS0t8FBaFaSzuYcrF9YdAqQNi5m+HfSF11WoJ9xKh4Kmry93vfMcHuBx18KW4H/ez0nd8O9SpxKQhgIXOvCpsZERVbJ1/jWEYN+Y0CgVYlJiNQCmNPRoZtm9etN6pYZJPJl2Im2vnmFgraM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 11:11:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 11:11:31 +0000
Message-ID: <2c0ed1c8-f589-8413-b3d8-904203788425@amd.com>
Date: Thu, 30 Mar 2023 13:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/16] drm/amdgpu: add UAPI for allocating doorbell memory
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-6-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329154753.1261-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c0aaba-7c11-4ea6-d408-08db310f843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtVkFwxnd+bKoByvQlpE3P/fmxyRZ9W9YKJmPHDEufukJlZ1Zq+DF4oMdeAdN7caIDLG749jaiP/O+agmz7wJIkdIVi5U6CImosZsC705iYw98k9OoOmphfa/ZAMuNMRh6fzOSLYhYdDU4wNSotsvQKS+Y4xQJkVLUTVumGllKF+wBnrs06lRIxd2lVYAYIBXYUWmITAzolTZXBtHb3zrl8MeUDKOh0CnguhjbSY8+zM1K1ZLAo7YQHTw80Z3LfezoYJFRLRflRy2ziZIvs9NxmM+t2qnDaK1gGft6RjLJ//guEJy/sMsb3hEgb38tl8f1gw8VEq0Cny2Z46rtRGRncpoTjBSz7ggStwB+DEOQd3g5NrY47xRK978I8mzTbMxSpgJqJreyP/pJZhIeFvJmy4SXTGbCh2qPzhS89nmBB/NTRkO0/QiMJXCU059xR3lbaXwE15Ix11QVgeQ9O5iI6si/CDTn7OgBRqVuzW1cGNwUpPgxJ5tC+L53vIRQFBqa8olo2rQjHQzmO5XGicpvShVzCj4d6RmH5UO09ByNNqUB/xOw01IBSfjtPBU2w+5cL1kzS9NnXu1dTnABZk8gJeoNRKJxRr7BBrnADqOLhC8gmkMVn8zQUyJQl6t69PsF4ZRb80iUsWe1NHyyi5RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(186003)(316002)(4326008)(66946007)(54906003)(31686004)(26005)(66556008)(8676002)(6512007)(66476007)(6506007)(41300700001)(478600001)(8936002)(6666004)(2616005)(83380400001)(66574015)(5660300002)(2906002)(6486002)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldydEhQRWJMaXFGbHdyVmpPL0EyQkEwbHVQWCtpQnBBYVY0L05FWGc2aUF2?=
 =?utf-8?B?SVBlNEZLSlF4cXB5RjBvYjVGaURXVGhCRTJHeWxDQmtud3RybXg4cXlaT3ZT?=
 =?utf-8?B?TXdDK3gxWjlCMWp2enBUaFBLcXU4SnNZVVk1YzFRVXU0cHVHQUIrMVBaMW5W?=
 =?utf-8?B?VVNuL2pUQWRrUEpLc0FTenlzQm5tV0tJUmkwMEpGWXROMm4xbVFrdksyR3pW?=
 =?utf-8?B?eEJoWG5zSlFPenh0NmdFalNIWTJpR2IzN3NLNnpveEZPTGVBdVltN3dTYjMr?=
 =?utf-8?B?UEFzbWo2N3JwL0hOMXAxb3JNQ1YvYkhUdHpSKy9LWk4wbGlUWUFXN09PbXVG?=
 =?utf-8?B?cDhKdlZDa0JoZGpZekJlWGdJMURUSnBpaGRWRklDNmU2QVpIbnlyVFVZWTZ1?=
 =?utf-8?B?QnFzY3k0V2FBd21QQWJSaCtGMVZsU2V3MXNveEJScTRzeXBlaFhZSGNuNWZy?=
 =?utf-8?B?bjkxeXlmUllHUXZ5SEdvR1VnbkpycUhjU2VTNHJDVzI1RXNUNlhhNWcvSXJH?=
 =?utf-8?B?TWV3enpSSThGbFdOS25ob1hOaGhyczFzY1ZsTXNFYzR3clpSZHc4MlJNenZK?=
 =?utf-8?B?cVF4Y3E3NDlGcTgweHJuZTF0dGF0L3dzSDQ2VzJEalpHY2YxTGhBVTNPZHFL?=
 =?utf-8?B?dHJ1bDB4MmZkQUhmbWJTcWpBWnluRmtYTDYrdUpVcTBrWnNDZWFXWG0yVk8w?=
 =?utf-8?B?eEZpYTFZZHR2RGN4WHF5cndQWXAybHRKbGNrQVJyMFpIb3BNSUZIYjZlWm9K?=
 =?utf-8?B?RUo1Tnkvd0FQcTF4Q2wxeVZaWHBsaGc2MEpKTDVMSXhGQko3NUZHWHRBaEhJ?=
 =?utf-8?B?ZDVhdEc2RkF0b0h3VEtReUJ0TUhVbENNWDRJZmdvbzdCeThNR0tPRnlkcHBG?=
 =?utf-8?B?dndEVEwzMUk1Ri9YVUoxWDNIZ0pCWGo0dXkxeEVoWjdGQ3FDYzdOMVBHNE05?=
 =?utf-8?B?dmwvdHBNSXR0c1NmdmpPbkdxc3hWWlFaaTRFMjNQeTlLM0JtK2FPU0NIMXpp?=
 =?utf-8?B?dGlxRWJiWm02RjlBb05WNGxLam9nUUFLL2VseEZHbTRNb2NWVWNSTFNmQVNj?=
 =?utf-8?B?a01TQ1ZPSW0vcDZ1b3IzNXZFQlJ1TkhlWXRseE1va1VFUHRpN0pxVENZeVVu?=
 =?utf-8?B?YWxjeFc0bm90NW9Kc2NCQnJ1bmV2RmtBMmw4aGt0SGFLRk1nb0V4NmJ5bEZM?=
 =?utf-8?B?dVIyYUpQME5oSEtkUldFdkVyR3dIWUNtY1FyVCsrdHU2Ry9uYmRDMmxQTzlj?=
 =?utf-8?B?KzhhVlU1T054Sm11c3psbVVWVW5iKytOWkl4T25ub0Jsa1l5b2xvL3FHVFR1?=
 =?utf-8?B?OUM2N0VHVm53Tk5PQWx1WkRjOVdBODhCc2o1cVdhakdWY2ZaOXorZmJqc20z?=
 =?utf-8?B?VTZCNGtXZlJWRE5ta0Ntak9LcWhHNHNxNUUyTWNGQmtEWDl5a2ZzRGRsMk5l?=
 =?utf-8?B?RDEwYzJkQVYrODRQK1J6MlU0UEduYlZ5cVprQkwwU0I1eXltdk14TVptbGQz?=
 =?utf-8?B?Rm1pTUhFTy9CTzg4NWNoTlpFV202UllYRGo3QWhSVktIdS9sdmZmSE5saHFT?=
 =?utf-8?B?T0F5WVRJSlAxdFFQb2t6K2gxZTFZNVVETExpc1lBY2llaXUrOUh1amIxdE14?=
 =?utf-8?B?Skt0VHVWakJIaWVpWXU3RStDSlV1L3FjejRPbFN0czgrUzVhNlhMOEovWXRL?=
 =?utf-8?B?cFlkMUJxdWpremdkbUwzY1IrREc4TkxJUEVMUUc1OHhvc3E4cEN4cDl3Ky9W?=
 =?utf-8?B?eWFIZE5PWEFzU1V4RGNORE44Zm52VTd5Wm1mVWtnUGkzMVBRbWhzM0NwMC9o?=
 =?utf-8?B?MmxGT0U2S2VsNjU5R2xwNDdkK1FQV20xVEJVZGlnQzltRGhPTi8ybWhCMEd2?=
 =?utf-8?B?ME1KQ1VlM1JQMHUvV3RsRk1KMWQ4V25ycFVvNEhObVNQOGxPVWFucDF1UUFD?=
 =?utf-8?B?eWxZYzNmZnBhRHFKU0dyd2pqVFFWbnBwWUpjVDB1ZXVEbFdnNU81WHNENGNa?=
 =?utf-8?B?UjIrd3BqcldRdVBlV2FwdEtoazFzK2xobFZvWXBXT1NIaG94UzJBbDJvSGR1?=
 =?utf-8?B?Z0hqR0hEZnh3RC90TGNJbFV0dnNHT2FVVVVkc0U2bE5qMDhZRkdlTmlYYVI1?=
 =?utf-8?Q?P/HA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c0aaba-7c11-4ea6-d408-08db310f843c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:11:31.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7XVMWFi8l4Ia2SKRa1aWJCCon9frj6f/caOnmQxCEB7/75ue5wrxcJyZI9/+SrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
> in the UAPI layer.
>
> V2: Drop 'memory' from description (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 4038abe8505a..cc5d551abda5 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -94,6 +94,9 @@ extern "C" {
>    *
>    * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
>    * for appending data.
> + *
> + * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
> + * signalling user mode queues.
>    */
>   #define AMDGPU_GEM_DOMAIN_CPU		0x1
>   #define AMDGPU_GEM_DOMAIN_GTT		0x2
> @@ -101,12 +104,14 @@ extern "C" {
>   #define AMDGPU_GEM_DOMAIN_GDS		0x8
>   #define AMDGPU_GEM_DOMAIN_GWS		0x10
>   #define AMDGPU_GEM_DOMAIN_OA		0x20
> +#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
>   #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
>   					 AMDGPU_GEM_DOMAIN_GTT | \
>   					 AMDGPU_GEM_DOMAIN_VRAM | \
>   					 AMDGPU_GEM_DOMAIN_GDS | \
>   					 AMDGPU_GEM_DOMAIN_GWS | \
> -					 AMDGPU_GEM_DOMAIN_OA)
> +					 AMDGPU_GEM_DOMAIN_OA | \
> +					 AMDGPU_GEM_DOMAIN_DOORBELL)
>   
>   /* Flag that CPU access will be required for the case of VRAM domain */
>   #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)

