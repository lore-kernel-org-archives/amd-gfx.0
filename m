Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0A3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 04:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354B710E913;
	Thu, 17 Feb 2022 04:51:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4452110E90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 04:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPdj2gckABar0POrHl9WS6YN1EMpGDc5g4gjobXbuuL68ePTwXpxiTL68bT0pIKaDxmzKxFNKEdMPefXRtQYt5XUbvUQVTLWkViDh8l74Dpfruqi6EsI42jFfOqQnW4jD7mGB5DcaPlVnGZBLjrtP23mb0DaYV51RJVlC+PgHvGZwPx207eU3EGQcDhRQIwy0sN8j0XJWnWcF30bCKClQSaPgo2/4fg0znM1U8g68eV7KbyeMVVLpMX0dzL9y2GvM/9fdtKNLbOMzAcPFL11xfVreI03JjTCtDOaaGyigAUwoPGdAbYEUUVCpfjLyKOJSBSRs6B3tDE+/TuOg+IpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+IwEYNxfleBWBCtjCUok7qUwDApB395hUmvry5q9Kk=;
 b=efSYJ5QayVRfmP4KyBEj5Xt4MdOwb4gYCQcVcSHr1S9kM9evaPoi6Imf2W+b1rC4aJHD0p2TMIigP7Cc/t1CbFu7nTbi6OCMdtNOXa2UdRelSg8Rc55oRpGDrzV8rkizOBbrIk6/vK1EX5lKJC63QFZQWXX5T6xiZ4Bb+yWB9ZnlxJ/QrDDfVFzgEPr/8lSfos/RvRVNVq099AGslpCAx94yd0h75ISIS46Sh5NzTrYVK48w1366Fi/KEHnwVkrwkoqeuYy8sL/uOTWzpmsFwc1/UD2nYsGBwoKIhtkcXuZlvtSjl65y7uue7poCA52zKgrMa5jTJz1GZf2/SIm20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+IwEYNxfleBWBCtjCUok7qUwDApB395hUmvry5q9Kk=;
 b=dB+MDpYZhSZNYrcISrdluADps+2AWU4hl9NO+4j5+DY5tvS9DD6vnyhqJfduCgYnQpXavLnwOdU1UpzkUkjYigArxurS5bfx1vbzmYxUlBMA75VJpxw+NuNfMhabP6YcyjtKYfipSe21JTUVCzW1MFoY+KD7DlSy3Ylh5ljE0xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR1201MB2533.namprd12.prod.outlook.com (2603:10b6:903:d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 04:51:17 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 04:51:17 +0000
Message-ID: <cec9eb28-a5ff-52e4-8753-5d8ef0a669b2@amd.com>
Date: Thu, 17 Feb 2022 10:21:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd: Check if ASPM is enabled from PCIe subsystem
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220217034608.14733-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220217034608.14733-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4313fed6-56fd-45a3-3fc1-08d9f1d121e8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2533:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2533DF93B1594D43C40F50A897369@CY4PR1201MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ut1cfqVxG4zZJiHsb4oEgrwEmuilCvhs4KoJAIZEBrXTwtiJso9VUZZEEpZd+BANFDg34O0Bj8qsrAlBitqLjWu2nsBPCU1AozZMUvqmk5gFyUdCmcp4k3ONGMNFCG9VtQ81GliAFgwKevIqCnACLZo9pUCmQU5PaRPUp3n9XDe38Ad3Jb+/EN9RrHnEZDjR+bfy04qn5mIk3W9rsYL2h3VgWQfBLosyQpg3Cn2WLweYUL4A4mXrKnSMdnFmf+u/t+svXRtAX9EBRb/csh2bwW/LL2p14tE6ihJZHNPPtxJxKOEumClMP1ByFRl8f98a6rlntOnQ2SHk3p39CN4jbX0tf2q0MwBLpePRWpVHOLjv00CWIZ5Jm3AVZrY5UQAtZqBr8LQamY2s90K5Bz36PyaZ2Z89irbxWX0iKWZDH17QNy9bk/Y5j+NtagjBvKgFJxKr5QLSaBP4ULqf5JInNTYba6JUsr0/BBfHhgrq9S3btsVm0B66sMb/e16k/L/v7h9OqhYtCXF39tUBOSCmvVmI4kJSoxunuMaEp8SHHjfOh8GmOAEWF14r3OwbhCs7C60VkXNzDH1Jc/2N+lQXdIcL45MjqvyZnv8Wu2QWRkwmBYPTnhgYa1AX745rhA75BcihTO9eAGkzd0EX/NO7C5uBxj4ktwA+9ZwwLyq9B/Vvz2K+iXUtcbQ0iXGWBAZurglDz+IlgJ0+cQdTlum1lo6cbKBUAj7i6svxIkIL/bJs/7wBsqWhJ72nPDY9kiUKd8ZJP3IpdT41ok7SmtWW4f8SNq+6AujCshN7ke4JZdNb+aBnRueYCUT92oNXyIRC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(508600001)(5660300002)(2616005)(6506007)(31696002)(83380400001)(186003)(26005)(53546011)(66556008)(4326008)(8936002)(66476007)(8676002)(66946007)(38100700002)(316002)(6666004)(6512007)(966005)(31686004)(6486002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmovdlpJeUxVbDVjUmIzVFdsR3Z6SE9jeGFta3lsVDdMTHAyWDlDVCtoM2tM?=
 =?utf-8?B?cFo4Um03Z214WjJFangyNnJrTDlWSmR1TldYTkQzZzF2RksyN3JPeE82bFZN?=
 =?utf-8?B?N0doUFl1NWRzdFdzY1JBZ0FHenRWZmNYRnYyYkdWc3RLMC96VDhnRTRKTTE4?=
 =?utf-8?B?WVJzL290VGZaT2hYYTVqSVJJcEpsTGVqNWtieDNpVHNiZDlDWVNrMDFqUkMr?=
 =?utf-8?B?Y25ybnBHWkdEWm5qa0JVa3JVckhwWktNVmdCTEJJMEVNODF2ekJMby9FZWJi?=
 =?utf-8?B?Wm55Qk5ZY1BoZENjeWNsY0hTRjZublJTRCtrclQrZ2pKL0RqWGNSWHV3Sytp?=
 =?utf-8?B?bkE3TUJ5R3VVdHNtVWxmclJ3RUJpWnBRZXNLM25MZnZnaFF5NlUzT3JOdXdJ?=
 =?utf-8?B?cDJSK2MySEUrbk1Mb0I4bm9yeEdxTUVwcmNRTXI4VE9Vc3FrUGJkOGZqbmhW?=
 =?utf-8?B?NUpmKzVObXJ4RjRJTGxKUTNmTHZtVUluMmozUTdZVHNIMXFRSXU4ZjNtYmdt?=
 =?utf-8?B?SVpVRHRsZUNnUkE5OFMvditVVmtOaHM4cXhXQ1FDR0VmanI5MUtyVXB6cG9U?=
 =?utf-8?B?RWJtR3ZqaXQ2dnhJZXY4ejhlY21QOHdVRjk5eS9XcXhpQm00dUt6NEJmVWhK?=
 =?utf-8?B?RCtFd3NVamJ2Zys1OXVGSFVnVHdkWWQvQ2pXWG1oYVJlS1VKWHZGNHNZbElY?=
 =?utf-8?B?KzdNU3UyWm1KV3prTFpFRm1mYzdJZ1k0V0M1d2srRVhQUStNYkR1SHVZWGlZ?=
 =?utf-8?B?cDd4ZDExOW9pQ0o2K20rV2FqRVpHZWp5UzYxbU50bEcxbzhHZUFhOWdGRHp5?=
 =?utf-8?B?VUZMSlY5ZElRc2d2bng4VnVEYkJNOVBieDZTT2RhUVkyc21SS0dRWm44eUJY?=
 =?utf-8?B?V1QvMitDME9JbUwraVpWaFNqaFJKTk10cWN0N2hTQjFUaWdjejhSRUZIcHJw?=
 =?utf-8?B?WEJOKzdqU2dHYWNaT3J6a0R0UFFFVU1HREpQUVZhZ3JNbTBEZFpkQ2NueTlk?=
 =?utf-8?B?YjdBMEpZMDB6Vlo5U0JyM0RLM3VMSTZTekRFU1JMUnJPdXY5MjF3Y0JJTm5z?=
 =?utf-8?B?ZnNZRU1CdEJ1NFV5OWo2VzcvSE8rQ0NnSlkrV3UvdU5vOUVMVnpLNmZ6WWVo?=
 =?utf-8?B?WjlSL2JTM0tNaHVqWXptNHg0aG14KzJpSmFzTzNuNGVhZm53a0cvOGFuQmdE?=
 =?utf-8?B?aTVUaHpNRS9sTm9YdGZKKytzcnIzWHlBRHBZaDJoZDZEQTg2NmZGcjNBek9h?=
 =?utf-8?B?eFE5eG1IT3M2ZFNTTW1IVG5Qbml0TTU4L2ZEcHFiMFQ1NWVKN0Y1WjVWMjlq?=
 =?utf-8?B?eXdtb2IyQzNDckVSNTZndTRuYWxQa3cvbGZ6alZ2VFdZRktwbGFNUldvejVn?=
 =?utf-8?B?WHBDeWx4TkZ0ZnVsVW9kWkdYamEycTA1NTNDcC9VR0xkbDFVaEhJcFRYckx0?=
 =?utf-8?B?SVR3RHgxbzYrcnRrQ2twSUhzZThiZ1poMXdMMDNFdUx3L25SU3J0Rjh3dUwr?=
 =?utf-8?B?YlYrWEN5ZmpVYkZRdzIxSDI2TzdNYU5ibDBMbEpxOFNid0hnZHJENjdSdk0v?=
 =?utf-8?B?Y2d1ek41bnUyQU4zeXNLK040MytxN0FFVk5GUjgvNEViMEg5VmpRNXR0c1dl?=
 =?utf-8?B?VElxempzYllyS2pLbm5Tdk1SdUVFcW5idmN3bnptb0Q2M3FQMDc4SnU0TkZR?=
 =?utf-8?B?ZE54WVl6Y3FubDdpazZTMTg4K2dWaWVwMEdocWwyRExpZkZUY2IrVFFkRHBC?=
 =?utf-8?B?dUpMWHRzeENhaEIyRGNPUk9HejJSbkxBUlFLNmx6RU9VVUlVK1dtN2NRU1ov?=
 =?utf-8?B?UFVMMG1nNmJzdkhKVDVSUW1vYTd2dkQ5MFg3NFdMRnQ1VnZZUGxoWkdTaXpN?=
 =?utf-8?B?d1MxQ3NXNWdQZ3pRZ09KZDRYUStYR0cwanhmK2JQb0N2SnBhdjBHZzVHWStF?=
 =?utf-8?B?UHVTRFEwMXJKMEwrU0t5RFlkUVpYVko3RlJMSXEyL3REbGMyZmdEZGwwdGpE?=
 =?utf-8?B?Wk1OM1NSLzJVZ09pOWk5anRLaDhyOXo0SU9nUzZoNnBQcHVaV1hDa2NpZ2Mr?=
 =?utf-8?B?TzR6VHZiZWtPZW1lTk5HMzRXeFd4VzdkTWFSeG9Qay9vQ0ZIZGtnNTU1YlVT?=
 =?utf-8?Q?xtkE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4313fed6-56fd-45a3-3fc1-08d9f1d121e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 04:51:17.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fMv2MMoHvBdixlYLHZMAvt7Jit2pstBC3tqpQ4ddZeGyYtPzFpVYX7O2BbWBmfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2533
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
Cc: koba.ko@canonical.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/17/2022 9:16 AM, Mario Limonciello wrote:
> commit 0064b0ce85bb ("drm/amd/pm: enable ASPM by default") enabled ASPM
> by default but a variety of hardware configurations it turns out that this
> caused a regression.
> 
> * PPC64LE hardware does not support ASPM at a hardware level.
>    CONFIG_PCIEASPM is often disabled on these architectures.
> * Some dGPUs on ALD platforms don't work with ASPM enabled and PCIe
>    subsystem disables it
> 
> Check with the PCIe subsystem to see that ASPM has been enabled
> or not.
> 
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://wiki.raptorcs.com/w/images/a/ad/P9_PHB_version1.0_27July2018_pub.pdf
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1723
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1739
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1907
> Tested-by: koba.ko@canonical.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5acd0473ed01..d2548fab51c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2008,6 +2008,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   			return -ENODEV;
>   	}
>   
> +	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> +		amdgpu_aspm = 0;
> +

Doesn't this disable aspm for all devices even though only one of the 
bridges doesn't have support?

Thanks,
Lijo

>   	if (amdgpu_virtual_display ||
>   	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>   		supports_atomic = true;
> 
