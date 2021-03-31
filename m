Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338BBC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 06:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE376619C2
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 06:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE376619C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C646E9DC;
	Wed, 31 Mar 2021 06:39:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8036E9DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 06:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbSfHJESuzJGhEA3IOxFdqTApMlFGno8LIRhrSleMV7WeC7BG+b8Q+TqZN4tDL6lBytTMDMRuPTyurmeDp0o0lhGy/aKUaLga6ukIFV0Qd4DxvjdyZEwS0qpEvGS/30uPvnIbU/ZMG4496owmRQ5vWtHUP35Wkt0o4K5emwV4PFGkXSp9trAK1M/k5+IP++pVymuAD9tNhOYCvsn2HTTNm18NNTG+9oAQBfrFfxGEcAGAKHFaDr89o7uL0vwjW/pD8N8QMKDcWbm/ZJtxd6hp99gmHJ6vj9K7ebCiVvMCmZMv8B3/VdIzI3EIOAULB8AfDENFnsWH7DZNXxyqMTN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPVngrzBHNAJtuiqv3ELeB0gI+pfp+auMZ7e2Uz5ZEw=;
 b=co202OFvu0dewT2W2LdA8rzxwdSIV0m9eJq1/8CiuaowiuDCWws6RUIRBe60UefnBC04o7VEeeRxKq4beoWfACToEQwSKH0AezxSfNJay20RuG5am2LxnFBB0djAzPt3Ga1cClHgxpVqc/FvV+dcE1yzSLj020IfJiyHGj4yzsXZ8mlaI6K7JBksb1Ex+WLIUcRLjMsFqcfaWnke3O86uSuMbQeffUgpAJSpeve+n6Mn8wadYdEc1OGxIJqqXPWGj3p7/TGOzfayQk6FURq9AtA2Pxob5Ii57psNwfoQ76eTthUEQCw4PKUkO5SxbpLuExRS0NkibNNrGIt4NB1yAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPVngrzBHNAJtuiqv3ELeB0gI+pfp+auMZ7e2Uz5ZEw=;
 b=O36YjoxYdITfmMjv37hZlSYZsh/XyIWcnMKFQhCEmcXPzVCFRh/2gFavb5rGA5mqS1CneijEz7sVGkHnZF9ywKOzZkMiHspyAk9QHLmP8LvHZwP01ppudR85BAsc8fOgRJOG36tivxJMyJMPTUDBzhMZOgYbOqvt9QXPPmhyiQQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3728.namprd12.prod.outlook.com (2603:10b6:208:167::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 06:39:31 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 06:39:31 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2f67c616-427b-9724-0c33-bc41ff0cee70@amd.com>
Date: Wed, 31 Mar 2021 08:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:46d6:1b43:479c:c70b]
X-ClientProxiedBy: AM4PR0302CA0011.eurprd03.prod.outlook.com
 (2603:10a6:205:2::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b]
 (2a02:908:1252:fb60:46d6:1b43:479c:c70b) by
 AM4PR0302CA0011.eurprd03.prod.outlook.com (2603:10a6:205:2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Wed, 31 Mar 2021 06:39:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ac3295b-4420-4334-2005-08d8f40fbd2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3728A21077176E82DD7E95BC837C9@MN2PR12MB3728.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEr8hu/unGE0kgPOS1yUWZkX8Cnc2ggS2Oc2lidr3ducKibaLoQDF2ZNvdHvdIwrqWV4jLVR4fTWPJuZvPSMo1SBEsUZ4V5yf41TxGa+9Xdh7LmYaimdUjg5COMLPt8Jh0Ohhivu+1yZj3PJwVWEy4kl1KMcMlnZs+iJISR56CmCjWozd2VbgGfbPoblod5jISG1sHE/ln18HFmH2E//w9+6B+cAaLAVX+K00NIm15MTsCjhMID5+JYMFloLLrV8y16kjM4VaafIbjXAkHXzLNw7idQscnrML26SGsBE9nz9yfkZNhGNw7p8L40etFoRbVa2nNqsTazjKli5g5i6zV9AFSWaw1WAnNMxNKO668H6uaWitQXJw7wwx5rjcEX6hc8n91tAi4lLsLYFnjqKx8hm4sZFsv7CCBimT06uOY4PPg7QmI+bIyl1Nu1ory43tS9gg8ZcFn8wnzUt2csqpKBffXbbbC0Jp5EFI6qfv8p6aVRk55x/KTbpY+ujr/2O23CIv/TLCLm0xRyubfW1VlrOmjdfL9mSdl7BI3dJQYjeGDdYrranvmFLi1JOeJIxXv2ao93e5+/O1cAD5CXYqzByy6Uxr0Zd/wziHlBM8eDWWr5T9Cj7u0/16obajd7oD3/m0IOSXTMTLYqg1LCiNbBeYXpLrsTB+VXIB5DCWhnhTisQCxZAf1jmOfy9Thlf7GeFzj4+FsRygMfsh5XZ78llHKomIHDksuDt3WCjvy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66946007)(478600001)(2616005)(66556008)(4326008)(6486002)(186003)(52116002)(16526019)(38100700001)(31686004)(8936002)(86362001)(316002)(31696002)(8676002)(36756003)(66476007)(6666004)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXN3Z1pXQytuVmpnM2Y4ZGdLZEhIb1JobDF1ckZNZjhLb3NlL0hlT3hzMnRT?=
 =?utf-8?B?b24rZDlMUlZ3Vk1veU1wSjlKaEc1MDNvOCtsVTJVQktNK0FFdWQ1WmxkYnBj?=
 =?utf-8?B?OVNWSnZLWjVBTFlJbWJRalpacGtiZ3dUbHlxVW1VSnB0OHdLWGk4blNnYk5l?=
 =?utf-8?B?L0FPZzNyaWQvM3liQWRaQkF0TnRPTVd3UnFoR2VpOVFpaHEwWXlwN0xEQ3Mv?=
 =?utf-8?B?Z29Rb1hHNThoOVZWSG9tcFFvT0IvL3JRd3FYZUJMampaT281OWVjWVRQWGFS?=
 =?utf-8?B?ZlhNS25FNFpLVkRrVUp6ZkhMWG5neEdRWENHeSttbWF0elZOQzVHK0ljeUFJ?=
 =?utf-8?B?SUZ4bnk5VjJFc2gvcXJ0VDNWRFpFK1FmaTVubzN6Umk0NjZIVHkwdXZ1OExi?=
 =?utf-8?B?Mm1WQ3BkemVwZ05sVnRCc3cxYTZUL1lMOWM3Sm5PZ21WeEpydFZtK1AyajNl?=
 =?utf-8?B?WnNFbFBUd2FYeHBtNldma2FjUWpDaWQ4eExueEVVeXdRQVdLb1JYcU94V0J5?=
 =?utf-8?B?eVZwdlI0Uzk2TWVicFNoNWQra1N2WDZtTTRhME8vS1EvWnluRTJDVncxQjRl?=
 =?utf-8?B?QWl3MUJxb1kyeWpWMTRGalJoYVJoT0YyTldKMDRJdi82Z3JWc3B4eGMrSkF3?=
 =?utf-8?B?VTRWNHQva0hCbVNSWVk3MzhOc1pQNUVwVzkvdmxOUWlJaGx2L1hyeEFWYXk5?=
 =?utf-8?B?dTkzemlTazhTZ2NvbEJlRWNEZERWREZ0ejQ3MXZLempoZTV6TGpUUTBJMWlu?=
 =?utf-8?B?VnBncjJrK1FuR0JyUDM1NXlQbzZkOXV6K1E0TDBNZE1oUWwxR212Y0dnMXEx?=
 =?utf-8?B?S0N0Ri9KNUJsZENnbmIzWDZ6YW9rVW5MRGQ5VW9UQk5KMmpZbGdYenNTR0VF?=
 =?utf-8?B?VDllWGVKamNvUlY0Zy9XbEwrTkJ2ZDJpYXFabVhTVU5Db3ptcDNUVUEwOE4w?=
 =?utf-8?B?dENxazdHR3NVbUxmZ0JqaDRLSFdSd1BtcHNUSFF0VXltRVptRlpBSk91cE52?=
 =?utf-8?B?UlJaRWw2ZlJMekE1ZEtGSzdZeU9nZkhrQlVQa2RTMDhxVmtkaU9DR3RiTmZn?=
 =?utf-8?B?cE5jc0lZNitING9RbGhYRTJiMWIxWDhuV0NidEJnRWc2MUpld3pFZWk0aWp2?=
 =?utf-8?B?SWdDNDFMbVVwSFQzQ0lMZThCdWNoanRnUVNUZG9YTXh0VG5OQU96MlNkeFBP?=
 =?utf-8?B?TVAvYTNMWldVSzA2SjkxNE1rZjFWWmRYM2w0SWdtRkEvNktWcnphK0VxWXdp?=
 =?utf-8?B?dEFjY2x6SjVuTTlTbkdoK3NxdjRTbGNpTkRSWkFsY2FzZFVqelBlVGs1dGZw?=
 =?utf-8?B?aTgxajQvRjFJYTdqL1BlT2hONm9vQit0ZjJ1OTZkTGRiUVM4MzZsblhSeFdR?=
 =?utf-8?B?V1hTNG5lWmt4RE1qSGRvMzhNVXZGMGJwZjhlNDFOYndaYXgrVWlrSkcyYmVY?=
 =?utf-8?B?VTQzNHEwMGZvdkpJei9wRURhQUdpdUdKcWNMRmF3bGFKZ0xqNWRwRzQvS0dG?=
 =?utf-8?B?dWhJdUVaWUN1djMzN0ZFNnR1TnRBSEZSV0VDbG5Vb2NzZmIyaEFMVHJkN1VB?=
 =?utf-8?B?dHBpQmJFeUFjbHhIMHRmelBETENEcnBobDZOei9KeWFvK3M3WjJZMmtSSThp?=
 =?utf-8?B?Wm5rMjZGZmRkWnh3YkZXcFhDNTBnMGw0MDVLVGFmTVlaT0M5YWJNU0FNSFA4?=
 =?utf-8?B?V1QvcDZuT2orcE1PRXZ0TzdIME1wR3FTa3piRWhPS3UyOUZpSzRSU05mOWJR?=
 =?utf-8?B?bGtyb2s4ZkpVakJFSGlzdEdpdFJtYWJGUDdibDFVci92ZzREbVlzVllxRWdo?=
 =?utf-8?B?QlBKaS9RM1EvSlFkVVc3OHloV1gwOWk0NmtBV2x3bUdFa2dLMTdMSEE1NjN0?=
 =?utf-8?Q?fHuXrrq9mhNX6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac3295b-4420-4334-2005-08d8f40fbd2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 06:39:31.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eXHoTWZxw8NzzDr7xK7kJKlcTzeVYBfwYdNMagg5KQPDRhx5b/KknYdmOk3SatM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3728
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

Hi Oak,

have you seen my review comments on the patches?

Regards,
Christian.

Am 30.03.21 um 21:35 schrieb Oak Zeng:
> Add one macro to calculate BO's GPU physical address.
> And another one to calculate BO's CPU physical address.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 7e248a4..b244298 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -272,6 +272,9 @@ struct amdgpu_gmc {
>   #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
>   #define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
>   #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
> +#define amdgpu_gmc_gpu_va2pa(adev, va) (va - (adev)->gmc.vram_start + (adev)->vm_manager.vram_base_offset)
> +#define amdgpu_gmc_gpu_pa(adev, bo) amdgpu_gmc_gpu_va2pa(adev, amdgpu_bo_gpu_offset(bo))
> +#define amdgpu_gmc_cpu_pa(adev, bo) (amdgpu_bo_gpu_offset(bo) - (adev)->gmc.vram_start + (adev)->gmc.aper_base)
>   
>   /**
>    * amdgpu_gmc_vram_full_visible - Check if full VRAM is visible through the BAR

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
