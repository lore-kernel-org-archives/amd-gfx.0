Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F2DEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 03:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEDC10E3D8;
	Thu,  6 Jul 2023 03:49:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C0D10E3D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 03:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glbXL08EY7+5CcbK64O4oXMpMCaDP5T3e7Nk2wqDPypkSwIXfvwcJgQ6MoDcUmq5+zl/74pEp9CIvwELz5yU+VbSoawFBK7ZbViV7olqEFCeHSkiyHKdn3fslZunKqb6axok/9JyaM8oG12VO0xG8cW/JQpGPUmEMuE7wgOTM0S47581fk4A/MP1nuHP68Ab07kjZ48fuDi/AX5HV18y5vnjtDr72RqGxhFZLPvGhH/ouA9srlSo9JQE9ub2hd+WH3gytKsLVETd3JBbROJm0G8QxOog46l8JLW+vturSrnrZBHdkZGHv3xEhhXY9DCObPFLJzgel0wWyjIyqp2tuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/o17u9gkNs6xJJW+tAaFrBLu2NIMZNT1+dsL0/E9jo=;
 b=dTWziLQpnsqwWy4Jh16iIhsWaT1HV2LUlEGCOorbrxBqO2DFQPPHd3RQ+Qj+4Z39H1QUQVYcA7yNOjoGKpPi1jG8k7k8A7Nxe+9BMETgUYRCuri97WDJMKc4imWSOeTjTZtJ7LC4Gmlhbk/AFCXcyh0J/pwswwgL8oErHNaopxGP+3vOtYTfL9E/z+pcbP7GYjX7DE893btoO0HmqxeSod0MfV02NhIrk+NpkH8yltOS1xEpVdTLSBD7ICHtGca+XH1LWLw/GrPAwToi2bfj7ZWuCte2QXpYdTW5jjGgoZ3DCK9Y3v5bY4CLDT1i5nmFuVXUYVhWWPWyBrVbgTZAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/o17u9gkNs6xJJW+tAaFrBLu2NIMZNT1+dsL0/E9jo=;
 b=g2tTp082lJWXcl5i3GGD6r/wJcMIN7RtaSaYytHzD1u3yujY0qILdTq/D4Ktlos608SMITviVAbR+YqHbFtLanzAUTxCxBD5ZRfX9x1xMXaaK0TGc2uiA72xTjRvQXa88MGoL5AjKDy3Wzrl76NCKnyJEnaENk4f/EhfVOk2OGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:49:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:49:48 +0000
Message-ID: <6880b81e-22bc-597b-5d01-ff6f84dde9ad@amd.com>
Date: Wed, 5 Jul 2023 22:49:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd: Avoid running psp_ras_initialize() on HW without
 RAS
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230705165249.2058-1-mario.limonciello@amd.com>
 <BN9PR12MB525760145F1812231E109A72FC2CA@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BN9PR12MB525760145F1812231E109A72FC2CA@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0084.namprd12.prod.outlook.com
 (2603:10b6:802:21::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: acc87b57-ab15-49a7-a9bb-08db7dd40b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9ebl2BXbDD7gDTburLlJY/1ENji/O4fShLGZ0qHolQiwUo0vwrr/9zZ8LumXvDqWv80J5A/OOuTH6jOFLBRolm4mAFH3aYQbz568BygBhx8sFbtDXF9ws5AaP8VOaUGJo4XSwW2oFp7CEYD/Rh/9G0O/PZVMf+zg7bEtIHh22UWRBUoMCZFE4OE1q2fKnwHxhLNvVWO4qLfy8GL35X5/tgviOYg60qjCT7jBWbnc7kbPoj2Rjt0Jtk9Ay4pTAnynpkCiqwUiTqnGPkJ0Qy9S8+vH77ECYUid5nPGVSdQ1kVG5HqrwNmdDy8B4ISHJJOVm04OtvH13xRa+X7Zzdxu7I7+xjYJHmWZPgGcywoX0SFvmA7IYqH7BKzESThM3ih4Nv5qwFp8Ja0CmL/fep26KdFWEjkaSUcT5BITSxgaZdKnA7ZYQDD4fU0VYyYKfERIgLjQOKN1GHldonBVdb3vPtN+iF4eB2WAD0f44Eyt091MqucWdoz4YRJxzzWNrbscttB7jMI12INUpp1yJ5IcnvV/sM9WoazACBeluahireYMa7C4gP324I7V84kNExFmq8mgNTJ1rXlyS2psqXcecZlqf39BMbiMLNY/ZuRR/osZ9LdQDAWj5e5KUKXr+mHKit8hkCqVQBxxbUxYRYpfV/o+V47vXpTgbyYaTStOdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(31686004)(6486002)(6666004)(478600001)(110136005)(2616005)(83380400001)(36756003)(31696002)(86362001)(2906002)(66946007)(186003)(53546011)(6506007)(966005)(6512007)(38100700002)(66556008)(316002)(41300700001)(66476007)(8676002)(8936002)(5660300002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emJyeXlzYWlGL1p1Q0ZJR05aZUwvdjVDcDBhaXgxZFRBenVNUSt3aFFJRVdO?=
 =?utf-8?B?bW91anlvUlhKQUZaYUhmTXBkdmlQU3BzNVNxRnFSbmgyd1pQVW83REdKb3JD?=
 =?utf-8?B?aU1iNmNwL1BVVUp6STl1QmliVitPaHluKyttaVErL09oamVxMi8xSU9uWngy?=
 =?utf-8?B?cWIvUWhFYm15aXJibkE3ZXhySHNzQlVPS0phQlY3STJTeHN5b2RQT0pDQXFo?=
 =?utf-8?B?M0taNk5YT2VqQnkyRmRwQ095QXR6TXlhb1dhMnJCeGlUNmJPLzQ2U2VrS3ho?=
 =?utf-8?B?ajdKN3VYc3BDSTJweU9qQjA2WWc4Q0lsVmdaY014Mm9aRTdRVG5ScEVlLzNQ?=
 =?utf-8?B?dUQrdWQ4Y2M5WFN6Nm1qWUpJUk9UYUJNZFlkekJaRk5NTWJoaVZoZGRicFZM?=
 =?utf-8?B?TFdGVzBoeW55SWZaYkVBT3EraTlpMHlpU3dMVWZPdzIvVWRSbGlORlVqZHZs?=
 =?utf-8?B?b1FIeHhkcVNyOTlCeTNpeSt4L001T3dJalBaRkExdmRZdVhZeWZQQnlFOENu?=
 =?utf-8?B?cThER2x2SE13ZjV4ckNYK215YnZSQVdVYkZjb0QyQkJRQy9VQ2FySjl1Q3pn?=
 =?utf-8?B?ZUg2ZDhscjhpSUxjTUVBWHpoRUxSa09WUmhpWFRGeUw0eVN0TlAwNm56N1lK?=
 =?utf-8?B?aGM1M3QrUEc0cVFHdkJXbGE1OGlGclBuSVJPeFZDSTd5M0VPS3MvRVNheGtL?=
 =?utf-8?B?azdqWjViTkZDUDVWWXBjcnVtNkZRak9VMFU2QkEvM3BGQ0FXNU9rRllsWUFL?=
 =?utf-8?B?Tjh4WXpEVE9BODc2Z292SHVqYTU0Vm03aFhNZk5LNUJMbWlqZjdEZXBsM0Uz?=
 =?utf-8?B?TWROVTIyNVJGSmJ0emNudHNpTUtReXZmRXdSdXlLeFJOaHpPYXRhUVNDaE1a?=
 =?utf-8?B?Nmt5VUZjTHlpSkxrN1hTQXNOOFdwNUQzZFAyOWdmWVFhTVpSNFd6UG9IdUtJ?=
 =?utf-8?B?N01FbTF2endFQWRvbGV5enBJOU9GdUVBRjdEYUswVmRoVDM3TDIxSExwUVhF?=
 =?utf-8?B?N3g1cTlXb2M0b3paQ1NUWVNFRXZsa2t1WGUrdk9qWlBudldGT1hKTkJjN2ZV?=
 =?utf-8?B?RW9OUnRTVmdQa2E2SHJ2cDlVbGVtUlBPc2EzNmRQS1hENS9qRjhxeHQ5TEkw?=
 =?utf-8?B?S2w2bE1Zdlc0SWNWNEtxOHlGd3ZKeFZhcVM0N3dtU2ViajZRSWZWKzVGY1BT?=
 =?utf-8?B?ZVVBeFdzNmFJc3ZRUEQxOXowVklGTXA5UFd6QnFHeC9NZmo4RXRQT2ZwNEFI?=
 =?utf-8?B?UC9NdEdWdDVobTV1dGxsVVQwcll5angvME0xTHg3SHkyWVNsZGJNZ29sdy8y?=
 =?utf-8?B?WWJNVG5OQnQvblcxQ1YvN0owb2xFZEJvOHBYNEQzazhVYVgwL3liRjRITm9t?=
 =?utf-8?B?Y2d6WjkrZnF4UXhLdDhuTE15SVEvVzFORExDTUpBQmFSb0dKNDI5NVUrc29G?=
 =?utf-8?B?TXZMVmlERFp5eFc2bGF2QUZKK09nOTF0dGNyY2lrdy9kMnpsUWpGZHRiM2ZT?=
 =?utf-8?B?S2JUdyt2dXNHNlY2VW5wY24yYW40OG5XdjB6QXNtRCtLNlUza0hCNXVDK2o0?=
 =?utf-8?B?R1IyOTYycEl0cHFUcW1qL09ubmlHeEpMak8xaitiNGxkTUh2WStrcUZvbjZp?=
 =?utf-8?B?MEFUUklTbEZiZ1I0TkZmVEVabGQxdTBrVFdtbm8yQXlBSGsxbVRWWmRvRk1t?=
 =?utf-8?B?T3MzUXM0ZGNVYnZMK1h5YmptakxXZjhEUk56c3Aya0tCaUVjNU5weGpwcllv?=
 =?utf-8?B?WDFDRXFiUE9QUk96R3ptMktsa0gzUEt2L2hJNEU5REN0ZnRuRXlSSjhYclVP?=
 =?utf-8?B?L2ZhUDVzL0hYQUxWdnJ6M1BzbEVDQzZ0NmFPeCtNc2p0b2drdlRTUk9oWWlk?=
 =?utf-8?B?aU5BUU8reFZicytnZ2ZFL1RjT3pkVkh2TFFDV0NtTm1xSzd3ZjZYZklGekE4?=
 =?utf-8?B?YjVWZGR3aGlIRVBFWjhhaFBRK3RsaWpDcExXS3FXa0JUYW1ybWhCSVA3QWpB?=
 =?utf-8?B?aU9yeFlGRjRrM2pEYzk1NEt0QXpqdDBBRk42SEIxWXkvQktmL21yWnlNUXVI?=
 =?utf-8?B?Y1dhS05QSklMalNybE5sOENFTkdPOHJyRzBTZFF3R1hzWVRSMkdGMXJuMUVt?=
 =?utf-8?B?YVNXWUM1WmNIUElCVThPNitORi9HNE1LV2hYb3FKL2xJRVBqdFJiSkQvK3NI?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc87b57-ab15-49a7-a9bb-08db7dd40b20
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:49:47.8386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PedEjcc+BN3Uw4zy9tP15dr5530yOpSGY8rZFmHM2ofBb9GzRBq9xCfDe3f0JJVX4hhedXnB4L6dSuLIkGPCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

On 7/5/23 19:28, Zhang, Hawking wrote:
> [AMD Official Use Only - General]
> 
> The change doesn't make sense at all, especially for some ASIC where it is allowed enable/disable RAS config through RAS TA. i.e. set ras_enable==0 and the issue commands to RAS TA to change the RAS config.
> 
> It doesn't matter whether ras code path is enabled or not, but ras firmware, as long as it is built-in for the asic, it needs to be loaded.
> 

OK - how about instead to use adev->ras_hw_enabled?

> Regards,
> Hawking
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Limonciello
> Sent: Thursday, July 6, 2023 00:53
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amd: Avoid running psp_ras_initialize() on HW without RAS
> 
> On hardware known not to have RAS or in cases that a user has disabled RAS via kernel module parameter, it makes no sense to try to run code from psp_ras_initialize().  Furthermore trying to run it shows the following message on every boot:
> 
> `RAS: optional ras ta ucode is not available`
> 
> Avoid running the rest of the function is RAS is not available.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2673
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c2508462e02f..a87b6c761e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1603,6 +1603,9 @@ int psp_ras_initialize(struct psp_context *psp)
>          if (amdgpu_sriov_vf(adev))
>                  return 0;
> 
> +       if (!adev->ras_enabled)
> +               return 0;
> +
>          if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
>              !adev->psp.ras_context.context.bin_desc.start_addr) {
>                  dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
> --
> 2.34.1
> 

