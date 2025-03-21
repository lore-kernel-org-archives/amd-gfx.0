Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E942AC35FFF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 11:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC4210E795;
	Fri, 21 Mar 2025 11:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyCygoKQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BBB10E795
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 11:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKizPHZii+1yvj6NHf08TjS7C9r67AkeBhM2g99NiLIuIT1X+DLp8mQnB0SGGMv8z5RemsF2rQkK8fxbx2ApQ9w2X6WYvmTAs9yewUI1uSv5apWmZphRqA+fuQpvZItMQZCCLa2hJgGVIn2arsg5fMerBnoUQjtgP7ztcZbQ2uByl2HjWjNxzEFFTv10OzXUZpCIS7WQkfzF+2JZ/hSmI9JyjBYtRGKmdm6xcd67hauauI2AIJ+lj2CPWXb30RaIjBFq6T+ZspM5T+pG6SS8Krt+k+9hlc40ZVZjAn24zYgVuGuXgb4vMddKcwze/N6AAyXPkQws1gpvnwEvHwDe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aRDYJHtggYAQyh1mIhN6fZhKdbFhoeJJTp7WvcZjnA=;
 b=jA7iyvsGP1xiSLyS+iMLK1Y4Co9sAZdoyf0buxeE8FApg0ziGoHWIzAtgJPK1gCDv9FNmYztebD5wENLx7Ct2JWsj/SAI6GWYIHicT5LzsKrVWJ7RG3wxO/7jvTF2bM/HTdQ1Zj1+Rxv5mTA7s93EoSaipqbCHGgaQ/9so2Le8nqP35CvcsSbWa5N2QmQqBqmzIC5gkKCa87rli8QjKf/EEvpQukHk3g5g70WqijQyIe7l7dhMCm5WLqrarU9zlO/KdMoU/6+kOrSSEiPaYU98NE1MX0Csm/36sUGjIuRMHZXA/2zI+Z0P6R4KjLEL47FGx0knmnfDVHbyivixdC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aRDYJHtggYAQyh1mIhN6fZhKdbFhoeJJTp7WvcZjnA=;
 b=EyCygoKQB0JEQ5Ef1VW9vmoFEKVCpMAZFeqShIIvVboDIdwuuLS1BTaH9bXBkOx36Y9xPorfQvnxuLvwkt+/fFGfUPt/rzSgPGpT3IzS/86rW9p85OQ9NgZi8rgX0Q1jO3vCOTduqZzJ1fnoH1yNdXLQxfwQpVsvAf1MpVJ2lv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:06:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:06:12 +0000
Message-ID: <b27f2a75-1d42-44df-bb62-7070d93848bc@amd.com>
Date: Fri, 21 Mar 2025 16:36:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix some kfd related recover issues
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250321105200.1661803-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250321105200.1661803-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f08c45-8b14-4a64-3d2e-08dd68686442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkhlTW9aTUhSbnNLVTg0Yy9ScGU5eU5GYkpwSDV0SjhzN1FpZjdrdFdWSXpj?=
 =?utf-8?B?aHl5TmhHTUNHYXBLZXpPcHY4NENKd2xCRG1GcVBRYU9keHQ2a2lzM3FlN1VR?=
 =?utf-8?B?QWorSkhRekFDZjJsYkI3MndRdUhtUi85VTl1Q2Y1UTZlYXp0K2h6M0NPcFgz?=
 =?utf-8?B?aTM5WU9sSTM1V1V6c3Voa0xkQ0Vvb0tlNzFzemZOWXMwNDRTbGlTV1Z5VzZO?=
 =?utf-8?B?ZlYrQ0REblJWVGRIS3ZnT1k4QlpPR25ZZDRQc3FueEtRV05weUtObnhIZzU5?=
 =?utf-8?B?ODRESy9tVUZGQm1KKzNSMXZZRHAxVFZCS25DOGNVOHhJNHN0b1c0Wm1QTjMx?=
 =?utf-8?B?eHpJZ3NGc3BDT0kxOEo1VzdkUFA0dGdSWjJMK2I2K24wZGRzVVJ4YVlzTUFv?=
 =?utf-8?B?V2hqS08yWFBrQXU0ZjF3TkRRd1Z2ZFNqTTdqVndHQUVneVFNc0pNb2o0cm5p?=
 =?utf-8?B?U1pYV240ZXNHRHIyWmhDZTAxcjFVQzBpVjJuT0NEVlh2WjRabGxHNVd1S0x6?=
 =?utf-8?B?WURlaENSN1FUc2g2c1NpTzE5cWhxM29RSHo5TU01VVBwODdqSWQyaXFER1Jn?=
 =?utf-8?B?UE12aW1oYVVtSGxZYm5nZTNUY3QvZ3dqbXFOc3FBVk4zQlprVEtleFN1eXZ1?=
 =?utf-8?B?MzVCOFVpU1pGcmtOb0dLZWo1c2JIUnFySWRjMHNCeGwvMGU3OFYrQ1ZWQVRU?=
 =?utf-8?B?YU9Tck5oYkxYY1FVZEN1ODk4c0E3UVoyTlNTeStSL09UckhqUElXYnhxMHpX?=
 =?utf-8?B?c1FqQkhBYnhWbTJIU0ErWDlXeWFFZUdqczd1dGZtc3BsOVpWc243Tnp0Yjgz?=
 =?utf-8?B?RTU0YzV2S2VTL3pSSE1QQjJWeXN0bHdzZ0huckVTbnlnRy9hV25leG1xMVhi?=
 =?utf-8?B?bGREUk1uR1JuSFNwUDZwNXhYbkkvenhDMTNYVkw2N05iL0tEOHNuTnFpbTJK?=
 =?utf-8?B?ZDNrSGtJZ1pVaHY4aHpzTnFiZlBBQjdERjV5MHBxRlc4aXJ1d0Z5TGh3NDR1?=
 =?utf-8?B?c1M4UmRSQ0lsaHM5NnhyQlczNERiOGlwQmQvNVY0S1U1d3NqZW1vbEtoRmQ2?=
 =?utf-8?B?ZWJmdzJLZmVFT0ZteGYwWGpodzExQzFDQ01BejFOYXVGOVB2eXBsQk5wcjlF?=
 =?utf-8?B?bEpmN0tDYmNKYzd4RnJmdENHbUZtQWpBVlRkaTZUUFVEU2NGR0pTVDhURjJ1?=
 =?utf-8?B?S2tKWkRZd051bmEzNkYxZ2ZqakhCTy9JUWxGSUVsc01nS1g1bDRDMzF1QXRK?=
 =?utf-8?B?N211eVhYc01FQzZ3bzkxNW5DN01wcE04Yi85MXpLdlYxT05EKzRsRlU2dVps?=
 =?utf-8?B?TTc5Q3VyY3JJd1QyaklrZG81cE1BQ3dIbWkvT1ZLNWpyd0o0SWkxV2J6NUhS?=
 =?utf-8?B?WFMxb0J3N2lvY3E1VUtzd3FNTGlZR0tvazdVdU9aMnVCNmVYNHAwdlUzZ3Ny?=
 =?utf-8?B?MG9nTExZRDBqMHF3d2MzS3RZNVhYYnE2VkhUTEFZUEpZTjVmWUQ1ck0raC85?=
 =?utf-8?B?Mzh3T2RyeFhMSDdHa2lxYUVxL29yUnJHeXRyY2phOWZ6RWJqMWhOVTVvazNu?=
 =?utf-8?B?N0lJOVVPUVVyM1E0c0xweVBIN3FDKzNIMGN1Uk9GenAxYXRFb3YwN0RwbWtW?=
 =?utf-8?B?eGhsK1A2a1pla09aR2ZNNlVOVm4rb1FteXN2cUx4RmQvOFdiRDdqU2pUaUVB?=
 =?utf-8?B?T2hDTnhBaG0rRDRYVkV5THEycEdzK3AweUVtSnRqWEs1WFQ1K3I1MzliRURn?=
 =?utf-8?B?S01WUm05SXZRaE5NV0w1dW50MXRlYUc3d2ZzbC80NHdHYTE5TEprRDBGd2li?=
 =?utf-8?B?MURMSGVPS2pDSkNVSFJMWmpMRHp6T0hmNVkxenNyNnYxWjAxSDl6a2VlaWhZ?=
 =?utf-8?Q?xainvZxo3iC2H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtqaTg5Y0xWWjRZWmFRclhCQXB6cUVaMEtFVTRDYWpoU0E5dEk3UHIrZ3Ny?=
 =?utf-8?B?VzlxTHVNRlp6TndHbFFkU21KVS9YaGRWbmExWjQwTGVnREtmSHljTGJMa3Bz?=
 =?utf-8?B?aHAzOS9FYXM3OWNOVm1NdzN4V2R0bVRUZ01WWnZOclhSbStsYThMYWpzelBV?=
 =?utf-8?B?WGJDUDZZczFxbVpqYi9vMFpFZmkzb0JsMW5qemQzZHV2SzlTd2x1YjV3MG8x?=
 =?utf-8?B?TlNSbW43aXhhcjcvdXE0NzFkOEtGeno1VUdVYm4yeC9VR2JzdlJMZTUwV0ZI?=
 =?utf-8?B?NGVVbkFNTkNIRnhYcWd1WlNRUnVQQ0p4cSs0c1NXeVFaT2xYa2drREdnK0d2?=
 =?utf-8?B?NmNualBDTm1rWkYrT0FtRExBTVpRVlcwNWFEdXpWalhqd3B0ZmVKN1doeTly?=
 =?utf-8?B?bHNWd1NYeHl5eW5oc3JOZzFwdXh4TzdOSk1iVnJpOGtpQnZ5WWlhblNGRWFn?=
 =?utf-8?B?NEJnNlJtN0YwTHJnUnVVL2NJNU1DTURzbG9rUlhFcnMxNlY4d09ZVjlydFFj?=
 =?utf-8?B?Qy9uaFpzZkN6a0w5SU5JeGIwTTd2K1VnK2plTy9qelZTTk9zZlhYRmlaWVF6?=
 =?utf-8?B?NEtRdnBFNDZncTB5REw5ZHhoQnlYRkRqVGF2Znp4ZzFnMWwwYnlMVTJTejhF?=
 =?utf-8?B?Z0I4SmVvQXlJdTh2UFhXRHFjTkpYN2JyNWs5WFNJYnVOVHY4ejNmSWVNVmRC?=
 =?utf-8?B?V1UrRFRNbkhyU1RCSWJvVTRtWkVGdG5MZFFtcGMvR24wSkNPaldZYlVYT3Jw?=
 =?utf-8?B?eWFaMzhnNmJlbEp4SEEzMUdDRG0rRE5oRlJOYXphMWVsRHRFekd6UGxuSVFx?=
 =?utf-8?B?V2VKNjJBU3J4V1U3NWZYdnRRK3lIejh5eFZJN2RZWDdsQ0YrLy84MFhidjg4?=
 =?utf-8?B?aG9tSzExSmd6czdtOWNtbktxUGNBYU12Y0JLcDZNeXNBaExNY040MC9HV3Q1?=
 =?utf-8?B?YjNIK3ZuN3NRTjFjQzVNQ0xoZWwvems4dHBITVdqa09Ra0ZaUGZQTlFFNkNt?=
 =?utf-8?B?THBxU0VPUHNSejNENEEySFU5OHFRV2xOVzJERFpSVkNGRXMrRVdwWG1nZllX?=
 =?utf-8?B?MFdncmo3bWlwK01KdFF0MVdCWVRBN20yT0szSlg0UU5Dbmw5N1JYUXNTTWVD?=
 =?utf-8?B?UGsvc0V1UFZGdzAwZDdaQWhiZndvaHU2NzMxZ3V5dTU4T3RqMU13a0ZHQ014?=
 =?utf-8?B?dkpwdTNLSkNHMEdETEJSQ0ZTU2RtQ1QwK0JkOWEvTEtRc3JSMVA5VjVIVUxJ?=
 =?utf-8?B?MGpQYmo2bTRkNmpNTThwaE8rbTRKYlVCZ1R2YjJiUFFKdEg5WXRmWkZpN1d3?=
 =?utf-8?B?S1daYm9SaURZQVRmRTJlTmVrSkFCVHJvN3phVk5NaVVrWS9BYldQOHgrTmhm?=
 =?utf-8?B?Tktqc0RCMjhHVWVvcExpc1RqOEZrRC9HeUFwMWtHOENrVUZCQVVEQUc0c1FB?=
 =?utf-8?B?eFBKZGhDc0NlY0NYLzVlUG9scnZ5em54Z2xqNUQ3SUx6Rm1pSFZCWDNOVC9J?=
 =?utf-8?B?RFdLYW11QnpWejVTN29QR0pGQ0lnRzd5d1ZnaVlidzJwT01uTGdnRWNUT3pi?=
 =?utf-8?B?Tmlkb2ZLRDZqTGhBbDE3SmdkSEl3U2xtMVliSVpCUm9UenQ3eVA4d2lSdWxW?=
 =?utf-8?B?WmhYZU0vdGhmeXk4R0ZGSmxMdDRlTTl0VUw3THRFTG10dGlpWEhqZy81TDlh?=
 =?utf-8?B?aVRvK1MvSjUvZGtDcDhwcjJ4bzRWaGx6eFhubmNTaVZEZVljK2NxNVlqc2pE?=
 =?utf-8?B?RVBDa1lFaTBNekpkbHBTdGRid1BqWDhFQTFWLzI1L3YrMXBXK2pvZTVDZ0Jk?=
 =?utf-8?B?TkQ4ZnU1L2FVVitaY2VmMVFUczd0WmRTS3lQc0ZQbjBDbzNPOHNkUFZXZ2JW?=
 =?utf-8?B?VmJkZ1Q2N0gyeEdyV0JzVXhWdE1XUU4zNE00NmtwdnZwRmV1MDl3Sm43bHYw?=
 =?utf-8?B?U2FhZ0tDcXNGSFRBOEllYkVXb1NUT3JOS3VYNWRUMVlQc2ZlTVUzbHBLcjRi?=
 =?utf-8?B?d1dVMHlqL1hHVWpUejdacVZEa3BkZ2FFR3g2OUhKcW1SL1JrQWdVQy80MDBl?=
 =?utf-8?B?ZUVkYSsrN2dQYjVWNEFIRGJVS3p4TTFvOUNrOVc4UENuVk9tTG1Id0dURXhF?=
 =?utf-8?Q?4OJNSmHc38MlVa/EIZ0kOi5mA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f08c45-8b14-4a64-3d2e-08dd68686442
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:06:12.5705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtFt0R1ZF/rN0nH9lZjckmBkSlCf1yCfcOB5/OsAujmKwBbnn7Ka6cwsIEsFzo2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
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



On 3/21/2025 4:22 PM, Emily Deng wrote:
> It need to check whether kq has been initialized correctly in kq_acquire_packet_buffer.
> Or it will hit memory corruption during recover, as for recover, it will uninitialize
> kq first.
> 
> Need to flush tlb after recover successully, as it maybe has create bo and
> map bo during recover.

Is this related to any specific type of 'reset'? For mode-2/mode-1 type
of resets, expectation is GC as whole is reset which includes GPU VM block.

Thanks,
Lijo

> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 22 +++++++++++++++++++
>  4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b9c82be6ce13..eb2df5842618 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1000,6 +1000,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>  		return 0;
>  
>  	for (i = 0; i < kfd->num_nodes; i++) {
> +		kfd_flush_all_processes(kfd->nodes[i]);
>  		ret = kfd_resume(kfd->nodes[i]);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 2b0a830f5b29..5e4ae969818e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -238,6 +238,10 @@ int kq_acquire_packet_buffer(struct kernel_queue *kq,
>  	uint64_t wptr64;
>  	unsigned int *queue_address;
>  
> +	if (!kq) {
> +		pr_debug("kq has not been initialized\n");
> +		goto err_no_space;
> +	}
>  	/* When rptr == wptr, the buffer is empty.
>  	 * When rptr == wptr + 1, the buffer is full.
>  	 * It is always rptr that advances to the position of wptr, rather than
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f6aedf69c644..6c073ead2b06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1059,7 +1059,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>  int kfd_process_restore_queues(struct kfd_process *p);
>  void kfd_suspend_all_processes(void);
>  int kfd_resume_all_processes(void);
> -
> +void kfd_flush_all_processes(struct kfd_node *node);
>  struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
>  							 uint32_t gpu_id);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 7c0c24732481..4ed03359020b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2110,6 +2110,28 @@ int kfd_resume_all_processes(void)
>  	return ret;
>  }
>  
> +void kfd_flush_all_processes(struct kfd_node *node)
> +{
> +	struct kfd_process *p;
> +	struct kfd_process_device *pdd;
> +	unsigned int temp;
> +	int idx = srcu_read_lock(&kfd_processes_srcu);
> +	struct amdgpu_vm *vm;
> +
> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +		pdd = kfd_get_process_device_data(node, p);
> +		if (!pdd)
> +			continue;
> +		vm = drm_priv_to_vm(pdd->drm_priv);
> +		if (!vm)
> +			continue;
> +		atomic64_inc(&vm->tlb_seq);
> +		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
> +	}
> +	srcu_read_unlock(&kfd_processes_srcu, idx);
> +
> +}
> +
>  int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
>  			  struct vm_area_struct *vma)
>  {

