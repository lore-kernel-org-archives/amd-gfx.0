Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD71BC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 09:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E6B61A2D
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 09:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E6B61A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CA16F393;
	Fri, 26 Mar 2021 09:12:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D326F39B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 09:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKjyqKS2yxEDx4ogIhoeTfK/GotF0DfW++oikw5SLaIisOehlG15bOCRNOdh8eFvrE+vIZR5v94TxkipqH9gHmjTB+v3QvaRi0cL5FMZQQKkignS0iu0C32bJhJNB6ySn9jYXySbbXGAuXf0+8qQ1u6nNGGrh3UE5U0AvMpn+FXdlVaH81MMm3UXeh3mjq6bbOv9+ItitVj722hqxjvvPjPLRwZUcvJKxTuywSQhGJ6XJd5Jj+ZXNN5QeptZtleSkhIZudZnXhs13/h1if0Qg3OFRgtE1ynoR3DYfq9+9rJ336PRhALlWoVfrS2Wru77vQ91AE3DnBbTAVmCHo9VMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQKWoB2g5AKZmGBqezcA3y0yONBUuYvgzA6UR8BRlD0=;
 b=AqKIM7bUM6i8NVg37Tnepe/ENcekxN8/10lez/XJhD5gZMALB+H4u5U/JyNZdiNUDuxtiUMh85E9Jn2354EhM1MzUSgm4Ixr1BHZZNP7bXgw07Bcy4rwsLXvmDBiXlEL5rfu955U/3MvVjXo8AcnKS3M5jZLNE40KmBkIkCz2zZJpDlKl37QqbGa0bOsX5n6a9Gb7QveeTTmc3HPSYt0c7rusxDkkgM3I2fMQwePPJqVI1acwxE08GgM5N++pjpc1XuosCzEXtkx6WV0xOLMCUgAtLYXN5/YwTqH36LskeiGthryH4nGIEw/NtLp3oHBPCjplllTDyUXIe6Cs8LphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQKWoB2g5AKZmGBqezcA3y0yONBUuYvgzA6UR8BRlD0=;
 b=o6xfcjMhCT6zA+tS0jqqVmFlucvQ7TRxRTTMIRyTx2W5W8UTu7Ye/bnOismiCpj2Hnn2PAgrc7fmh7B8OZ66bi0zPpPD4NJrp0DWC4JN/u51fQesJpwHRE6lny2aP5XxrPdAg+cxhBetSLguc0TuOWfnj2I1/aLWptVOL1oYiDE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Fri, 26 Mar
 2021 09:12:47 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 09:12:47 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a041c719-b864-7d1b-8eec-177cdcc2588f@amd.com>
Date: Fri, 26 Mar 2021 10:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:f5e9:4efc:3566:86b9]
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f5e9:4efc:3566:86b9]
 (2a02:908:1252:fb60:f5e9:4efc:3566:86b9) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.16 via Frontend Transport; Fri, 26 Mar 2021 09:12:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06cdb64b-deef-4c44-1247-08d8f03752a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB455236ACA2981BD2FC1D137C83619@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6USneVObxNl8YJeMSnfu5x5KOYgu6WFVrGyw2thJk5oNnvl0jZ+7MtclrE7Fs9IwV1mFOOqjSxVjSao1stlRQZ/5+9mu8n0ZluOZPxwgE3ohzb8XsWP3Yae2WOG3BCG2n/sDe0AKEhmLauplUYSy4MadCFxkPvgt7/AjhWN7B/8BWdOXmgu67VfutKSA3mbkufWpkIaZz7Qe8Re+oDX3zNNWSaFZs2Fww1SYNH1daaAXoML3/7Dmr+hC4IUXWKmn7oiiujqSmsl3wdLJO3aC81Avi9KgNOJSKcl4yMyr52NqxZ3mQuJKjKYbkfB4Wdrht7hL0o4C+NG/kbPqXC1uKZEG4k7Gkgqu6iXl8mo44rkx1sTuV6hnbchfJ0ArNLeBUnbvQunuI8zIS5LYxV5wkPkrW/x7VjE7sakReZ/03Xr9bqxmt3AP+JfFOMpbwyt1TbWKb7iQQV2zhyVjYhejOiiV+2rrsC5115OQ1/4xuuq0Hky1BciUWczBk8usGSOTM8CUVB9CaWFBQc//YA/cZLgZwgsNhbJX6rrtVdM1b+Jz4y5ectxL2dYMX8F1AzlxnsfiuUhBolePOnlbxMHcGn5TH64WvH9IKv3NydCEu3H+f1o77A/qpU7tF4WnUWFGXyyF1TFUaziT1+9g7e0X0XOT1Lfwx8JopkggQk+oXyzFWxwzV369Vdm3h+Eeb9dl3hkLny2iAnQlIxSpKZexcJ6ZG674mspmHmCA6iNJG2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(478600001)(2616005)(6666004)(186003)(16526019)(36756003)(8676002)(52116002)(6486002)(66556008)(4326008)(66476007)(66946007)(8936002)(316002)(31686004)(38100700001)(31696002)(86362001)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWVvRG9sNzBRR0o1b0IvM3pTRElKUnlaYUk1RG5qMGgrOXRkaGV6SExtMGdW?=
 =?utf-8?B?MEdiOEhYOExraDhWTFRoOXJGd1k3RXVlYy9xM2QrSHBQRGJqUmtZVk96QWdp?=
 =?utf-8?B?eCtPVHQvWXZvZXZmRVUzNytHMTJjaWNDUUJld1hzSW1YcWk5aUlWdndoSmdz?=
 =?utf-8?B?Rk0zQkMyTVlTOGdoV3M3eldKWlJxV1lGM1dENUQyQXZWRXBhWWpvRE53TC9q?=
 =?utf-8?B?WWY3LzBkTDc2UEJ0THFnZkJBZWtBODJpeEhVb0ZJN3haNE9hSExaTnNyNHc2?=
 =?utf-8?B?R3ByTDVXTTdEeUZCN1E2bHRMSytiYlVFQTAwamh5cVh4KzQ3TlI2SDNQTjBv?=
 =?utf-8?B?U0UxVTBZQTVKYUZXMEpZdGVlcFJheThvRElGZVE5Tm80VWRJR1BMREZuOFpa?=
 =?utf-8?B?OTc3UldkUkxrMGF2YTJZbUcxeDFwL1FUMlQ2YzFHZmtuYmVLcVNLcjlwVzRO?=
 =?utf-8?B?dUc1TEx4bUkzMHR3VlorZ3djd2htRDN3L0F6MUNiR25CRDNuRnpqWEU0a1NC?=
 =?utf-8?B?TlU2QzFQVE9zNWlHcFZGbTFsY3p0T2ZERWd2M2dUZnRzNm1GS3ZIU0lmVkZH?=
 =?utf-8?B?R1ZnVlU5dHBYSjgyeUJqeXNWUXpNTmROdWV3dW9pcC82N0hFYld6S2twMk9o?=
 =?utf-8?B?amxIU05lRGRvNlBTMElKNjJyYldvQVdsaUJVQmJBU005ajR1Q1dNL2g2RktV?=
 =?utf-8?B?K1E4Y1NzTWlEMVJZSEhDRENxYlZPbHdsR3VXZ1VDb3FnNGZ2VFZ5akJNbWds?=
 =?utf-8?B?dGdlRUt4UWJueG15UHorOTd2ZDB1bVZWcTdNM3FGM21WbFRReGJOQ2c3OThj?=
 =?utf-8?B?TnM5SVg3cVdqVHBCdUlRL3o0WEdUQ3B0bXJaZ1hSV0lJMzRSWHdka3Q3N0li?=
 =?utf-8?B?VkEzZkJRTjlHTjhFZUE4NlJaTUNIVytWYXRuUC9idzNYSUlrUmtDMmJFUFJh?=
 =?utf-8?B?Mk1aajJ1NW5sUXNsanVqaUU5TTYyTjExQTlydE94UFpOSDExK1dYT3pwRjEy?=
 =?utf-8?B?aDlRZVpkdDRqY1JFVjVmUXdBU1M2VWFEZUlmT3FCMStkZlMvRjlnOGpyQ3l2?=
 =?utf-8?B?Tk9ZTVhFanltTUU4RHFVZXZ3UDhvdjlDeCtEbFBDaGxKd3g3dFZDbXdjNnJG?=
 =?utf-8?B?YlRvKzlmRnJIYVVMejBIK2JHMUVXc2wzYitSOHZubUtSalBEZFRZVTNqeFBr?=
 =?utf-8?B?K1FBaDRTSFN2a1M5UlMvRXdhWGZEcXpQbTBPVTNkRkNSd3V1aHNnNmNYaXFI?=
 =?utf-8?B?ZlFYeEkwa0RtTTIyMzJBYnlJMEgzc1VKQk1SZkxRTytZVWxhWEN1NXQ1UVl6?=
 =?utf-8?B?SEVwdU5GZWozdnhKdjRIOWxLQjNPSlp5dHdGUjBTa1h4WFZMTEliS1pnbzZy?=
 =?utf-8?B?UUZUOGw4ajhUOXAzc3ZsRzIwTjhRYm5TNDFMOC9wYW16OVFNZFQxOG5HU2du?=
 =?utf-8?B?QXQ2OVd4clRUajE3QURQN3k4RXdRTHhreTlscUpWdkxUaXltczgwNWNMMXAx?=
 =?utf-8?B?TTUvOUZCQ3l2ZFNhY3M0UmdhZ3UzdmMyakxmQ2ZDZDJMRXNBZ1FnUzIxc08w?=
 =?utf-8?B?V2RXZXFWUVRkZlFlWFBEWGpZREUzc2FBT2pxMTdmMnZNR3dFZkgyQXZYcEtS?=
 =?utf-8?B?MmJzcVlyY3hTc05sRXhxUTNsL1p0TU9KZjBmMzZxUlFYcGhDRm41RG91Y2w2?=
 =?utf-8?B?YWVPYUYwMFFLOWh4SlVlQ3VHWXdIaGpYN0dQSTRESlNCYWRBbTloVGRialRP?=
 =?utf-8?B?dUc2RHZjUnROamd5V0QzNnJBZmF1U0QvcEcyQXRLRERNUHduL0VFeCsvOS8r?=
 =?utf-8?B?QWErMEpOeUxDNStYVlkwSWYxbmkza1lod2pESDlXSGVmdmxuTWlKbWJoOUlQ?=
 =?utf-8?Q?lvni4ZRbr9EvZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cdb64b-deef-4c44-1247-08d8f03752a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 09:12:47.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS3RUrB7Q9KsAdLZKQ5Yoy2UQZa/fHk/DgBjwlvX5ODSVYYQ8GsLOg+esT0LxVP2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.03.21 um 17:38 schrieb Oak Zeng:
> Add one macro to calculate BO's GPU physical address.
> And another one to calculate BO's CPU physical address.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

Yeah, I though about doing that as well for a while.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 2ee8d1b..7cd9d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -283,6 +283,9 @@ struct amdgpu_gmc {
>   #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
>   #define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
>   #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
> +#define amdgpu_gmc_gpu_va2pa(adev, va) (va - (adev)->gmc.vram_start + (adev)->vm_manager.vram_base_offset)
> +#define amdgpu_gmc_gpu_pa(adev, bo) amdgpu_gmc_gpu_va2pa(adev, amdgpu_bo_gpu_offset(bo))
> +#define amdgpu_gmc_cpu_pa(adev, bo) (amdgpu_bo_gpu_offset(bo) - (adev)->gmc.vram_start + (adev)->gmc.aper_base)

Well multiple problems here. First of all I suggest to use inline 
functions instead, there shouldn't really be a need for macros.

Then the term va is used misleading here. A va (virtual address) is 
usually together with the VM code as virtual address on an userspace 
application. But here the virtual address in VMID0 is meant which is 
usually called mc address or just gpu address.

Then we should somehow make it clear that this is about VRAM and doesn't 
work for GTT or the AGP window.

So I rather suggest to name those amdgpu_gmc_vram_mc2pa(), 
amdgpu_gmc_vram_pa() and amdgpu_gmc_vram_cpu_addr().

Regards,
Christian.

>   
>   /**
>    * amdgpu_gmc_vram_full_visible - Check if full VRAM is visible through the BAR

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
