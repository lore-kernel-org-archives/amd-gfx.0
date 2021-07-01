Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27893C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 16:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BC26100A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 16:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BC26100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7746E048;
	Thu,  1 Jul 2021 16:37:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABD46E048
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 16:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7DYYShR/rK9LQrUH6qUmNY8MbbeKmNxIbKXfupISm3IWQQNKJvc9hlsFhzebmD0GAi6LmDLi5od7qM3EtD9Xz458BsZgaNuooKkl8yjFbUML0eLAHQO21DRqxwpQQfSnymPnQa2/I7qMBf4OnyvU+VTrYjBbuSqy2yfVhm9apbtVAMhoK2cDaCbosfTtjhRdtttgOZG8NX8A19EcPC+6OZSVvmmmaTof1+X0qYe39U+tIS3EfK67WCtC7sqWi5p2HzjyIY5rME9VJLatLqjqU3jwnNgeR8eW5b3YozcdIUAHb4Is3OFhKgEvbUlLlA3eFQYa9AVakiqCk1fu2Eb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDNvoVn0wubzB7jSIkfGuFeX5OXxUu0vgTXBhqLD9tc=;
 b=jrMzu5zjpTAu7cOWvRPajuUt0xLh7RqjB2jZlIB82oUkYnDG54Y5Ry3BPgMKHzf3MvqzyW3A4HaQ436Yyd7wfgQIOuxbEeb2P5taHcCJ9y7p2VMWbcwv3+v4YNKUmMXuEi30zJGNWppvDSt14TLC+xceIYkQxSsXKGt6OgZrqauX5NUlCXc6JZy2pUNN2AOzAN1Di8FOjxfyKcBEOOE4/1EuwkSK9OkeUrm2AScz2xfS4hoAsJYdiLE/W/Ey0+SXwgS5mN2QnXeNWfkcf4hfuxCPJwsKrfo3Iapky8O9LYlcjSXf0Un96eMre/EGUg+wYuzvIJNtIrjBpWfUx4q5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDNvoVn0wubzB7jSIkfGuFeX5OXxUu0vgTXBhqLD9tc=;
 b=xMoE3hIgpoZHmZV8WiHp8XdXjrs9+DHNNdYSbLSeNSBqEG1f/G0fYjvbm2ai2ZKBFjnnU1lrTGlCFlWK5AcVpQVJyW7qbCdbTQpvMIkTmO5VfwKhAJFnrky8vKGiOQlysTl8BzlxEw7zB2OeFTBo+iAPmsooehH2vIrp0PQabO0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 16:37:45 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 16:37:45 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Only apply TLB flush optimization on
 ALdebaran
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210630232617.107492-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2cba4709-55d5-5687-3aec-f4211afdbaaa@amd.com>
Date: Thu, 1 Jul 2021 12:37:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630232617.107492-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Thu, 1 Jul 2021 16:37:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dbd6561-aee8-4179-c5a9-08d93cae8de4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53664A6D98296771DFDDA1D492009@BN9PR12MB5366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7enByxu9g4ilj6MivHxcP7I/UTBrOgKCehyWu3EVsPNVYDERgjt76NA//qyzKxrHqk40TKuLpON3vM7PHUUAzAOrUs5dDyeNAY06d3KK1vV9hKMCx+QlhsOyJVizJl4/gvTcAfvkzbT7gREyOF6ozVX+NLd5DP69HUheWJ504Zh23xVxTC5ncnLf6Zv7GGohJk3mcbdtTpQXcx9pvkX0vRBGlAgSXtgElH777NLaXWXFJoRdwG4nNX0lV8Q2leD+MWXw+dbDDed6oNeOv/wMhJl5iEU4ozuLw0XkQ0bkdhptsrnSbF76AftzN9WM5GSKuDbp7WKNBjBCBKhY/6cInMSgT1qRXXVgKlXhmOWGofw+a9gnnTritl2eNhncrc/858khQ/uQjnTvj75YcZ/fuDyruCT9xnVFZOggDqTYorwzcMdjw37IIt3Ye71UJ3+gOuimOFDzXTB+QXMdbaZE4AKMCYGwTaQ8Bh0C+7hFkrTSNKx1Yxdp6vdrgOjlD1yURBuXOyrchjw29aqZeGOeWFE7lYdXIwDG0w8DKUaDwztNtddRrD4rkkd+r4ZN261fk4guo2WHDOPnfP/YYUvPPTjN1A2VDCmlGULYGHRPqaPZz4FI/U8l/db3k7mnX5V+WjBi+vMsGG56exm2XehsNsQfwC13UQSSCp5PYOL2aUjtKt9cGj3JnxydolxjfBULZZVKgig6K3M/hUWm6Sz5o1gg+Z2rKLwRDvqpLzZ1E96RvTE0/XZyPBN376YZXh6g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(2616005)(956004)(6486002)(2906002)(44832011)(66946007)(5660300002)(26005)(16526019)(316002)(83380400001)(6666004)(8676002)(8936002)(16576012)(66556008)(38100700002)(31686004)(478600001)(186003)(36756003)(66476007)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEV3azY3ZkZGcHV2dkNKNkxKblRzUm8zTmpmUkV1M2w4WFN5VGlMRHYzV3g0?=
 =?utf-8?B?TjJmd2NLKzNJL3FFQ3Y1eENkejdxQlAwNEwyVDF1R243N01FM0ZtWDZSMWtT?=
 =?utf-8?B?RTZuVTcxS2VMeTAzc05qWDVlcDUvUXhXVkJyekx4SUFyN1pRRnRyMnZNUmp0?=
 =?utf-8?B?azVNbzVQQUxNOGNRM0tOeWFHRU5BSjNaVzU4eTBqcGxaWjVTQ0E5OUxnZU9W?=
 =?utf-8?B?K1ZBcG1BNWZPMEcxamhmV214Z1A3a2ovcUxoNzQ2dlJ5c3VLK2hMTkVDU0hx?=
 =?utf-8?B?Vm9VYXJteVlBcnlEY20xSE0zNGllU1ZrRkQwTDVETzU2bWJGamRvNGVHOGpy?=
 =?utf-8?B?ZlNhYkZaRWFyWkNaSzAxTmxSZ0N3ZksxSTFKLzh3QkVwQzZLWjZiUUtaanBo?=
 =?utf-8?B?emdGZEU0b1JFSzRGWTRJMnY0eFRSQlhick9DbVFXWTUwbDJzQkZ2RmhHVTNQ?=
 =?utf-8?B?ZEU5RWJoMkFydVZOZDV1ak9DcFhTVVRBbDlLVzBZTEFKKzRaNGh1alNDNnVP?=
 =?utf-8?B?dU5tQWZOOTZVaG14dWtkb3NlODRMUkhkelNvZmxlRnVUZXdKdldtN1hudDV6?=
 =?utf-8?B?d3dJZXJVVytFZXBrZ3F4ZEZaU1pPYVBrbjZSWGMxYW8zaDRLL2tCeHVvM0l1?=
 =?utf-8?B?NlVUZDRUeDYyQmpqNzU4dkg0bVZvZTRkekVsVEVGUk1mWTJMeDhTL01PNWla?=
 =?utf-8?B?UUVMM2YrblluSUdFb0ZIQ3BNdHFVQnA5YXhKYUZrYW9RSmJSektHam55b1Fm?=
 =?utf-8?B?bTFYUW1uMk5weGJvQStQT3VEaXpYMllXTG1OazVkanVGTlFKOWFpWnVsTjAw?=
 =?utf-8?B?dHM3ZWM3OUc3VjFkTXJ0ZG1ka3dyazBUYm41QmJOQTI3TDF3dGlLMXYvZEI3?=
 =?utf-8?B?LzJ1enlmNWt1bTE0R3Jsa0FCWG5wcEM0aldYcXpnT2tkL2RmVC9lNmhZZDRz?=
 =?utf-8?B?U09sdlV4enlCY1RkcWNwWUVUeEkxZ3VxMU11ZDJTbGZqbHNFMHJtUUkxU2VK?=
 =?utf-8?B?TFA5N2xzVUZmN3VFM2lWV21uOHJISExQWFliYWFDOXZEVlVzazJBek03VEwz?=
 =?utf-8?B?WXN5eXU4YjFYYUhoeU8rUGZmUVZsa3YybThkbUMydjgzTHAxZjNsVDY1dzVW?=
 =?utf-8?B?Wmo3NUNiZFIzT2tPZzhwVDNadUx3eDkrS3RDSnViWWVzT0lDVTVBSitzRk0v?=
 =?utf-8?B?VUdkM25GcS9DL0sxbUYzbDhiK3JOVzluSEhkbU9YRnFISHN6UnhCVVFIdVUx?=
 =?utf-8?B?WTZ0WGdhZ0xOMEFVTHFvSEZGNFVIN2J2cXcyZUo3a2w3VU52V1hhUFNwemp2?=
 =?utf-8?B?RSs3Yk1na2IyNlN5UE5MSEp3WmhINDYxS0xqejNPTGhPS3A4TWZ1aDZpaUMz?=
 =?utf-8?B?a0NPNTNyd0RFUEVlZXBpYWFaZ3dZNk5KTHFyVnlyU3MyaDM2MnZtV21idE81?=
 =?utf-8?B?elBTWjBVbnU0VXMvRThJc2hJWGFIbm4zWHNYRTM4eXdMWHgxdjA4cmI1bE43?=
 =?utf-8?B?Zkd2UXUva1M4QTEvT0lyejg2M1FURjZFMFR0dytJYTNLaTR4WHpabWRUcHQ1?=
 =?utf-8?B?bVkyZVBmaWgzZVBsc2EySTU2TVAreXZVVXVDMzQyZjVSc3NYSGdMaWk0OFVX?=
 =?utf-8?B?d05RWFRvSDFCTFl4bTRHU0RUeUhBSkpQTUN3ek81SWRPcmI1MXJaTVB5bEdP?=
 =?utf-8?B?K0RIb0lUcytFRXREVTZFSVFiM2NhMW15YS9oeElhK0ZUaWZJSm83RHpCKzNx?=
 =?utf-8?Q?TbXpUw4MjhkrGrzGBaYgaujmZiENkByAprjMpfE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbd6561-aee8-4179-c5a9-08d93cae8de4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 16:37:45.3416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH5WbaXKDEXrAISCCQw+2gIfuWAiI6nUArIHuge+MOfMoDJdXp7Jvd+p3DDsQIpGI1S3MvSG8tsNhtyN42N78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-06-30 um 7:26 p.m. schrieb Eric Huang:
> It is based on reverting two patches back.
>   drm/amdkfd: Make TLB flush conditional on mapping
>   drm/amdgpu: Add table_freed parameter to amdgpu_vm_bo_update
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

I hope we'll be able to change this condition if firmware fixes become
available. I think eventually this should only be needed for Vega20
XGMI. For now, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a6c01d624246..13fcef6836d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1845,6 +1845,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>  				true);
>  	ret = unreserve_bo_and_vms(&ctx, false, false);
>  
> +	/* Only apply no TLB flush on Aldebaran to
> +	 * workaround regressions on other Asics.
> +	 */
> +	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> +		*table_freed = true;
> +
>  	goto out;
>  
>  out_unreserve:
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
