Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E22C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 17:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C44E10E254;
	Wed, 16 Feb 2022 17:08:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C114310E314
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 17:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po0c02/SZx5OeeLYJxOIGQHtE5AwOIsmD8sDy/0/OkLHKRyKhEnlveal7svFa/cpausdCXkr+F+Am9fuBBcVT+lIvZYVP/euPiMSAJ6g04KKEo1mvUR+geLDKrguvs6DofCfQtLkgM/R4C5ZM1uKKbPUPUvYTmu65gt76NOQV9d1W/TLkGtyIl5uZ0edsrkFpeF6eYOd+l+3KYdVBZsnwDFJSHVsimDBjZ/BX2hTpOO+S4mZddrw+ogZxbPpQOsabkXBpKcreOonLFMzOE6vQUekDOQvdY18bIw3f4R1W1mh2Jkg68GbvGz7PAENLl6K7Vmded0pQQw++WZyj8ArYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AstCnkMO1cV/H7xB0c/lI0HJyUZT6IeFzlztYR/Scmc=;
 b=P4qj41YUiVuKbNMa6gzJ6mLLKpEMwtHcfzOZsAYUOu67wnWRF4EbVWLVsxInnfS8VddqbHF7bD8B9DMKq4FcZMmgmvDjN72dnFkZpF4d4SrwMGbDGKUcqs2jnyGFO8uMHwamDfI0LxCVwbJbYTleE4ZSKLdkqPjxbkRC3+cliDH2Kbz672Ae7shOuGSAknjR0pqOIxJvmr1QOLaXLKRVZz+HksLE4VLrgxl2umnTIFy+Q2gBjW68gdb/aOxyN3nsn/1xZdb7QRwcNgNnj4Z9VGyqMofpCyr9E8eiarhLGi2K4ZRvpKdEXAVAF8x69HUFpnjq/6/0nR9Ah1Mu+RmAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AstCnkMO1cV/H7xB0c/lI0HJyUZT6IeFzlztYR/Scmc=;
 b=iQH0MLcwKz/3CKeQW2f8eTyM15IXInW4XiGx2tqMVLfGfleltaXaO514VVAAZ9NFF4EFkL0mu4kfjbS9sLy3lq0kd2ebp15LbqcvogSGJS9EdH/62EmS6HfIjUr2fca5uaaLX/z25jSuwXcDZiU9RyOEitCvDeNWsOHWZMgvmSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Wed, 16 Feb
 2022 17:08:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 17:08:27 +0000
Message-ID: <d7422e30-a926-a723-f30c-b414f42075be@amd.com>
Date: Wed, 16 Feb 2022 12:08:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Print node id in peer map failure message
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20220216014252.182719-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220216014252.182719-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0639c0a1-fa04-4735-93ac-08d9f16ef310
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0224:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0224A6E3EF8E32F9DA16E09B92359@MWHPR1201MB0224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPtgKt5JtCgq5fIzdt8xz/b9v2DtACUDzUdw8bLSd9WxBHDK+7gRtyAn9gzLDr4ea4Xf69nY4anqHQn1PsoNLVdJhf7kBUDa4/LBbAeA4RPpf7pfpeG3r+FA5auYzjRXlWo4iG02JdsR6qG88Pa6DbtLTVclKshCWhJWHEUDdk0lN7/gy6je/2vGb8gHicS81ZFhUYnSpFhghClUcaf9l1+zCzW3BOrIs+KXAclSmJSgt6ENw0OHA5iM9+nrR9EDAcfyTYILczc5j0pXa/aBX8alHxLHLkGdO++AQN2kdoyvR1F4pcP3j8rWxsHpP4aXtzhfHEh5RGUtLJ5n9Tjt40HrNno89Pc8m40IGn3WXem6aVFiEhN+SLVLEhkLg8yuy2W852jhaLYtqdUuuijyXjPDyRF1TEtatb/Ryy/KvJl95qEfNxwx2UnSJVOErxOepBGK4zp6IUX218Gd1ziL2f8R3J8y4mgZP81KvP5r+E1KhtsMsi3n3vXck4vGRhxWxaDvl5ORglKg6mJDnbj0zmpmPJw2OTev4xoK7CK7rGzGT4O8TdRkAzWjGBXOzqWW8mymeTJzY+4JAflprcipvDevJOc9IjviGFXpdqtIJOGrh4JnoWWkkFQ2TKrr/wT4u4ug1/tCsQW4w585gvmtTeYAh7h16LRkHz76LG8sgM9O48lWORBtCUuyqFDa7Z3VwWOezgHnf0AgJ7XoO6B2cYXDzYgRepBZhqP8YKoatO7/zxE4iUB/2EVGyir1oYBr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(508600001)(186003)(31696002)(26005)(2906002)(31686004)(6512007)(6486002)(5660300002)(37006003)(8676002)(6862004)(8936002)(6506007)(86362001)(36756003)(316002)(83380400001)(38100700002)(66476007)(6636002)(66556008)(44832011)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VISFMxYS94TGFrMGdieCttU3JhcnlGZG4zbGxqbmhycWZ6Um1aZ3dNS0xM?=
 =?utf-8?B?KzhKMEFnMStVd25oQWRJMHhreHdBQTRRUGFoSVFTbUJRWkpzY2dQMHBrMTBa?=
 =?utf-8?B?QnVRUklsT2crWmh0d3diK3p4M3VSWFJoT2kwUk0zeG43Y0c5dDNBM20rNXFs?=
 =?utf-8?B?b05nclpuZVVVYkFwQ3dOYUFqNGhrK0cwSFFnQTlwNy9jMjNKaWI2Mkdwbi9W?=
 =?utf-8?B?c0cvdEhNN0QxbjdWY1p5Z1pydGk4VWpUK0YwVGlmY1ZhT0pwV3I5Z0VRREpw?=
 =?utf-8?B?aENrTHNjWjNnQXRnMDNOVkwzM0RQaVBWZUQxVmRSOVpxdmtNOXIwbW53N29i?=
 =?utf-8?B?V3VpMC9vdy9UdXl6dFVSd2tqdi9UN0ljaWpESXFwTHNWRWxKeFZoM3BJS05V?=
 =?utf-8?B?bWhtK0g5ZDdLcHdyeHkwcVpPdjJwb1RsVWtXUEw0dlQ5REJVakMzczI2OXd2?=
 =?utf-8?B?MWJZRHB2ZklEZFhGbGxWanpOeXZTamJOOENmb21BU2Q2YkljMG04M2pwSEkw?=
 =?utf-8?B?YWtmMkhvb2ptVjc2NzQ1UEh6dndDcTZqRktIVFQ2VEVUWXRJMFFxMGZGUDgw?=
 =?utf-8?B?WlZGaTVxZlN0eHJZTnJzSTJYUVNRVlJ1RjI0cGdZRGNZWENEWWlBY3BPUU1Z?=
 =?utf-8?B?cUFRUWhWYmZ5U1VmZG9UZldiOTdlWUtPc1JTRzl3enl0WEE3V2s2a2FRNUJ3?=
 =?utf-8?B?b3ViVHU2aG1Wd0lhc0JRV3psZUg1RHBZTkd0bGlWSVFzeEQ3Z3BjYm54K3ll?=
 =?utf-8?B?T0hsd01XQlA2ekZSeW1PbGt2ei9PSVcxeVhPMm9sd25KQ3M1b0puRTVVSW5z?=
 =?utf-8?B?RlJZcWhVbVVDd2VsVGlhbkptcXZZcXNKOFNndlBWSDR2NHNBUlBYbXJmZ1pU?=
 =?utf-8?B?NWRzMEZnRHB0SE9JdHJJLytTVzFoRjVaYWxOd0JBVFlTUSs2K3lZTWRON2hp?=
 =?utf-8?B?V3ZYMk55bWtieXJpY3pKL01TS1A2UjBrdjVGU0FkNVl6Q2xNS2NVZ0hkSXIy?=
 =?utf-8?B?SkhEQVdxbXdacjM5TlYwcFFqK0loUDdNaG1DNFFVSUVrL2x2dC9XeWY1U3VQ?=
 =?utf-8?B?bHZxTnp3THJUb0I3UEdCSmhxeFhIQmpHMnBxa2M1dGhhYlluK3lKb1RDOEMv?=
 =?utf-8?B?TncyWSs5ODlnYWYrQy9HMG9kc1c4Zkw0MmNqMWRidnl2YXZtUm8weHJJOEhU?=
 =?utf-8?B?WDhvNTNTQnljYUxqTFlCc0tXY3I5MU84WmxEYWt5V1NhUTljcFNxM3pDMDdT?=
 =?utf-8?B?cUVpUEY1bDNnWk5jb0MrcktsUkNXb3pFck9iUGdoVlZzc2ZKVjF4M1VvQys4?=
 =?utf-8?B?TWZLVnNleVV5TDBxbFdjVnp4TS9ES2RPZ0tWYTRxYnlOdkx5UTU2S3NGTjBE?=
 =?utf-8?B?UER1aUJTRURZbjJiR3lkRHF2T1lFQWd4eUI2c2RjSFFuQTJjNEdwTUtXRC93?=
 =?utf-8?B?aG41a0JKR1ZORHJodEc5bjB1dWZ2SGpMZHBlazljVHB3NHU3TVZzRm1TeXF5?=
 =?utf-8?B?YUlqYWttb3lXSGMvaWs5SHlmazU5Qi8rM0ZaWHFjeVNLeVZIbnZLMTFoQkdn?=
 =?utf-8?B?MWxXalZvVjZ3VEpHaDB2OWhDUGFIc0I4QSthTmh5MkQzKzE2akU3UG9RemFr?=
 =?utf-8?B?ZDZpejkxcTQyUjJkek52QUZqV2hNL2h0NTJKVmc4ZEtmTklqK044SGZsYm9K?=
 =?utf-8?B?QS8xWFgxODRBODZJNWFGYWxEZ3BHMVgzN0JmeGZvVnRoNEpkd05aSlRBaHoz?=
 =?utf-8?B?ckZJdlBRYWEwOGNiNm8xQlVPTS9lNmhlZEM3elV1dWhOUnovTUZ1b25ucjVR?=
 =?utf-8?B?VlZlK2pKUVR3TTZ3RVpEZ1ZwVkVHRFBLdGpmWGNVYWhkelJTaUY0OTJ4SkNm?=
 =?utf-8?B?UVIwN0ZuM3hGeHRWY2xpRmZNRnBMckh0T3RCRlFJclJuNWd4U0VjQkpveTVt?=
 =?utf-8?B?NlZkaWc4WWlZcmlrVFF2UDZwaDhORzB4SDl5dTFpbG1jSzM0Y3A4RlVaVGp2?=
 =?utf-8?B?aytnSVhEYUZ1VzB1RXlsaGltcnN6WnQ2U1k1bXZyTDRPemJPNDRlbDNlZDMw?=
 =?utf-8?B?NU5ObERkV0o0SVIrbU1mZnM4bThqNkoxYklNUU13Mjl3ZkZvK2tUOWE3OGhq?=
 =?utf-8?B?ZldSMkQ4dytaT1dYSW5yQnJ0VDZEYUhCUjgwQis0MWZEcDU5RjRvYUFqUTlv?=
 =?utf-8?Q?Q+LfZvyCrDYZLMtYFnhuzkY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0639c0a1-fa04-4735-93ac-08d9f16ef310
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 17:08:27.7532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AXaylMKW90d8DQi71bvoPbD89Q7+PuMRLw14wsnb0UAw6KlwTIL++bc+97CBeefOXhIc05IFX5JsUSmA/LVmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
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

Am 2022-02-15 um 20:42 schrieb Harish Kasiviswanathan:
> Print alloc node, peer node and memory domain when peer map fails. This
> is more useful
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 965af2a08bc0..4d62784c7cc3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1215,8 +1215,9 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   			peer_pdd->dev->adev, (struct kgd_mem *)mem,
>   			peer_pdd->drm_priv, &table_freed);
>   		if (err) {
> -			pr_err("Failed to map to gpu %d/%d\n",
> -			       i, args->n_devices);
> +			pr_err("Failed to map peer:%d alloc:%d domain:%d\n",
> +			       peer_pdd->dev->id, dev->id,

Not sure if the dev->id is the most descriptive way to name the GPU 
because none of our user mode tools really expose that number. If you 
use dev_err instead of pr_err, you get a nicer way of printing one of 
the devices for free (probably the dev->adev->dev). For the peer you 
could manually print the PCI B:D.F.

Regards,
   Felix


> +			       ((struct kgd_mem *)mem)->domain);
>   			goto map_memory_to_gpu_failed;
>   		}
>   		args->n_success = i+1;
