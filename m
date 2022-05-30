Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7B1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB9310E162;
	Mon, 30 May 2022 07:49:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572B410E162
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXzIeKptIxRVD2nLqSYsjvWBl15kAZhapnubL6t0+Bq4Z5+9y7vTWskCA9p21vCzDiPBHEI35e2UR8JhjAeGXsaDoSXa1QR2F/MfXJfxnhTeLDnWt5U5N4Q39LJgvKnzFDMIyeJT/h60NfAaxX+gu8uK+Ntmr+NzXooeOm/h4NzXtMObknHs8Al1X3sT+Pa7oz3VTvV/899wzg4sPLv/TwkQSSw/EY3NMlfgv9paIMbaHbtS/hfYyMfNJtLn2iDDW2g/IJUp+N5VQm0k1PjmyXj41I+ekAqOYh9J8IrSbkIxBbHs9Vxmo1CVEu4RBcvkaAKu/l2W8Db8vzAjl46w4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcTUbZe70TI/K/18i1kZpk2WzGpe0S65WH8TtqcIyJ0=;
 b=D+o1NweIYpEjm2MVZbNBpRfRbc2IdS8mCDTduuyCFXGVZpwSSWCRSozFntMkrfOJt+SSTIUIuIoyW+UHK+pJUwpxIbqGnimEqgW85OfFhvtVzGcddQByCMwZZPqEE6E6BJ0t0PgDUuzrV+iZany+d0lbQnTH5vB5RW0HJHaiY0TUYtjVbh7dbqhqnJY5nFicP7VbyfiAP2rvRnkB4uGNCeeQFbnBrvujOx6ShstVDYglI/NgQuegngywL8CVZSKiURtDfjJCJRZX/WDiG/cagJWVjM++DZ76rsCPdF+mdUMRfcIcLScSIE5NU1ctexfoPMqwf0SYyismoJ/SFE5m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcTUbZe70TI/K/18i1kZpk2WzGpe0S65WH8TtqcIyJ0=;
 b=mZEesPwwQ69AytioQxek0/qwkkDoyHgnxAVv5UDsC8a6cC4/kGAdimpDHVKoy/asPUzO0cmKnkWDr+3gZD5fuly5Oy+VyiVRcOuYr1fxsLOr9Z6sUeZO1mlyPFeoIFEQ7L+4qi2BHPhzL72GPnMNeVx2yYmYtb2mRnci7fCgR5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:49:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:49:07 +0000
Message-ID: <4b4ffe49-e7e2-880f-392a-98959ee63d49@amd.com>
Date: Mon, 30 May 2022 09:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/7] drm/admgpu: Serialize RAS recovery work directly
 into reset domain queue.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-4-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220525190447.239867-4-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::32) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97fce8b5-83df-479f-008a-08da4210dfe8
X-MS-TrafficTypeDiagnostic: IA1PR12MB6139:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6139C62356F712E4FD8CC2C983DD9@IA1PR12MB6139.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AgfT0S4G+djF+J9bz1hk5s0yeNyhNHFOA8oLs/KJecz0UDYIjzG+H8xzvo8Zo/8p79N+PuzVPbYwa839qGsHay3ixJhjyz7nqJlaBVHM2Ujk8iwKz6SjrnOnrsszTLXxf8Pt3UqRFgjFZG+9GrBGUYrrMY/KjLAGDEkY00ddF3pF1sy/oOStMPuQNpzTv7Q+nvTYD77WGqcaFYwPVPghaS6844BYV4MH0tAdkPQXO0bMIqauP5Sc4fX+B9USrTUiLCN9IdwA0Tlg/UL4O9w+OycBvkGya/XQ/g+33bF07yHKD1uZulBFdDNYf5C1mcKA042kwvIAVBGLWoC24Lt4wKVlPSpo+NhFnjxC24BLqc7zal/GzNGEEHjxcaKSEO/VmdMyVWo3qqIu6Ejp39QLNOp8f6dZ1946zViuV83yQZpmjGynxaA63Mf2DU75Fu4qMHyFHCil2BRPv/n2XxZNrEuw+/TdrxP77p78K/bSH8/iQrfuhjZL/EX5MWgHBvH1vltM+xCHf5ovJl+FAIpqoI9lQ2jXKB6OzSByWmSADS6l6UwuFYZtxXDZstf+q1xi4KPJndm9IvaIGedDMT82nIyFVR88bu3oCwc5w9fTqdrYKCZadt0gCQ3qHhZRlBa322/dFmzJxCVC+Y7FaGJc9Say0O27qi32OaxYaNEv4s7V/XDYs8+25bMo4bxq+tIAFIZ2d0qTpcvD3P9KSZmtM/rE/4vDfyQzjLH69PTN4X9Qoatt+ScGu9EYh46blPp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(6666004)(8936002)(31696002)(31686004)(6486002)(508600001)(83380400001)(2906002)(316002)(6506007)(66946007)(4326008)(38100700002)(2616005)(186003)(6512007)(26005)(8676002)(66476007)(66556008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2syMG9pdEZPRE9TZVlrWSsyM1BFUlVQTmRBWXA2d2Z1akdkdzFpMTBNYWFh?=
 =?utf-8?B?ejZLK29rejljMEd2MElZckRkR293bWo1amdkRHpCdTdUbzc1Qnh4bk80Sld0?=
 =?utf-8?B?aWJiU3hVUXhrKzk1d3FZa1hTNzExL2xmZ2ttY0s4K2NOdVlNdVdMWUVhVS9x?=
 =?utf-8?B?ZEs2V3lNUWQzaFdxMTJCRWJzeWRZcUZreXJsY2l0N3FLdS9UTUtweHo2NEtm?=
 =?utf-8?B?MWdQbzQxTnFPK1VaazdIQTE0aWpRRnNZWVRnMWhxRUcva2p4RWhScnNJT3NW?=
 =?utf-8?B?OGFMZXRIMGJ0bGRoMGlrUHV5eEpKM1h1blk0RTNJak9BYUU2RWRBLzNNK1ha?=
 =?utf-8?B?SmF3enZkcTQrM3ptZUtQb0xvZlpKTWQ1eUtiTG4rMTYxeXNWbFVYMkxTQkhB?=
 =?utf-8?B?cUtqMk5DeUJVOStDbFM3MXFWYktpTUQyZE9JVFhNeGlMekNPZ0NGZTlZQVB6?=
 =?utf-8?B?QnhLaGF3a3FXcVh5V2JTZ1ZYNHVMUkJXbTZheDg0aGlkb1hzU2Z4ampOSGNr?=
 =?utf-8?B?S2VUWXZ4YU1uNThyWnRIaTFOMGp1eUFlNm9DRkFyTWg3elFSb3orUXRJbjAv?=
 =?utf-8?B?bE15dHlWZjRRNm1jbGN6RG9EZmxVV0Z3VGhYalorSm5VZDNJNFkyeWtKRitE?=
 =?utf-8?B?bkRtLzZqbElKWFFyTERqR0lCcTh0cVFSN3FUYTlndkdYUC9hRTlXeXhyZExI?=
 =?utf-8?B?TmM4MlcvRWpDYW1Wa2U2L29ZLzJ2bjVkWmVSM29Ic1lwdERTcXZnazhFU2R5?=
 =?utf-8?B?Z1ZIbzVyV2I4aGlSZTBVUks1UzVqaXQ1cWtVY2lFMG1xV0xxc0dFNitRZGRh?=
 =?utf-8?B?cTZBOVorSWVqcTFoZmF4MjdwRDJhOU1UTnlwQklzYXl1c3NUU1dVdkVTcjhx?=
 =?utf-8?B?c2N4THFpTDVtUURYN1ZoWkxoeXc2Rk9wNmMweWkzME02cFNuWTI2M0FhalNk?=
 =?utf-8?B?OE9CNG1nWjNCemxnVlhlSExWOEdpRzlJVG13Syt4MDJkSFpicjhabU5qSUtj?=
 =?utf-8?B?T3hMU3hGQksvRnBjd2JOanovSGxvMjk3MmpSR2E5WnlzRzhjdFBhbk9qa2pB?=
 =?utf-8?B?eFc5VVk4M3lWSTJxRHVMSTk0UXl1V1RQck45c3k1Tk80U2NXR09SYlhTc2xN?=
 =?utf-8?B?QTlhcTdCZnkrTVc2QWQ0SjV1anZlWk03NzZXOUwrN08xbWlQbE1IeURVTUlj?=
 =?utf-8?B?Ym10NlRxTElrYXVETm5Wd3N3alN1d2VTTitVNkpLb2F5QUZVK2pvNXNxL0F0?=
 =?utf-8?B?c2dIb21RUS9pRXB1SkxoT3ZhUWVoOWNZVXkrLzhnV3dqb09wVWdhRXFCdmho?=
 =?utf-8?B?UXZqOUlLU2IyM1R4ME1BTmJSYjg0ZTVJSGxEQXRub29ld3E4K0tKdmNMV1R4?=
 =?utf-8?B?dWtwYnh6MStVZm1Hb2s5bEtkWFJUVDB4NVA4cmpXdml0WHpXQUttUGI3QUpD?=
 =?utf-8?B?d2dYR1BxSlo2aHlVVk05QjJpV2VGbG8vbGNiemJxNHFYUllmalJNeVRUcDlY?=
 =?utf-8?B?VFRNK3hUaVVBcG9iL3Z5NTV1emRzaVprSjBWSHppc2J5cGdmMnhMaWptVW0r?=
 =?utf-8?B?aVZrMzJSd3NBNXhSSWtHRHJBQUxIWktzNnhMNkNOWFV6bXZ0cVJBcElQUkNH?=
 =?utf-8?B?azl6SG9aTmhyU0k5dmhDU2ZCZG9BQjZOR0hZbWVPTDRQVkkyWm1ia1NZUVNX?=
 =?utf-8?B?NkZqUmZXdWYxTkVJZkdxU2ZVZkM5V1JPM3NEaXM4V203VGx2Z0wyZUNReXR4?=
 =?utf-8?B?cG9jMnpTdEE0V2ZDZXEwMGw5dzIxdDFsVVBTMDNML2NBNmYwdjlwdGhRbkEy?=
 =?utf-8?B?NjZRM0hEcjRlZy9QWWxPWnBERUZWcm12eHpEeWdCR3dQdDkzTFlySW5tOGRP?=
 =?utf-8?B?M0ZDT0k1M2xSRDhWRHlsQzQ3MmMvZGtyNjBTcTdTZnhMbkZEVUZ0TzhERWhp?=
 =?utf-8?B?VjJtTFBlaiszU0tJK25WOXRid3RsODdVSW9MT0haMmRmTDIzR0d5ODhOb0ts?=
 =?utf-8?B?WTVZREZpMjYvZ1BOSnN6WmI4cFhWNmJaTVV3b1pqY1JxeHVjZ04wRjVJRXB0?=
 =?utf-8?B?R1FUcjNSZklRUWEyOGVEVXF5dG1tZENKOER4S3MwRlNpMm85ODE4MHFESnhZ?=
 =?utf-8?B?UmtsOFlmN1BrUmo4blBWQ0I4OFhjSGw3NDY0TjJ5Mk1YclpmK3JLUDFpc2hH?=
 =?utf-8?B?RE01VWQvZkhuRHNiL080dWlOMkdoZmxTOEJGQUhiekpETzJOVVFnclVnTVNt?=
 =?utf-8?B?K0tqd3JJS2JXbzVDWDVCZ0dRd3huV3N5dFNoZk9scWtNUXEzTUtFQ203b2JR?=
 =?utf-8?B?a2pmeDZMVERCelJqMmxoTU1TeHpuWHY4ODljTGh0a2s0ck5aUGdsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fce8b5-83df-479f-008a-08da4210dfe8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:49:07.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5FsY+z9RBHSDAs+vSvuvHGrg+9ERw3XsXpMPbm3zq3+hbqK9qlO2IjAy37Q7eEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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
Cc: Zoy.Bai@amd.com, "Tuikov, Luben" <Luben.Tuikov@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
> Save the extra usless work schedule.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

Maybe Luben want to take a look as well, he has done some RAS review in 
the past.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 31207f7eec02..a439c04223b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -35,6 +35,8 @@
>   #include "amdgpu_xgmi.h"
>   #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>   #include "atom.h"
> +#include "amdgpu_reset.h"
> +
>   #ifdef CONFIG_X86_MCE_AMD
>   #include <asm/mce.h>
>   
> @@ -1920,7 +1922,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   	}
>   
>   	if (amdgpu_device_should_recover_gpu(ras->adev))
> -		amdgpu_device_gpu_recover(ras->adev, NULL);
> +		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
>   	atomic_set(&ras->in_recovery, 0);
>   }
>   
> @@ -2928,7 +2930,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
>   	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
> -		schedule_work(&ras->recovery_work);
> +		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
>   	return 0;
>   }
>   

