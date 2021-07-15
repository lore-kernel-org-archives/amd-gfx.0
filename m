Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D288CC1B08C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 13:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9489C613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9489C613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445746E847;
	Thu, 15 Jul 2021 13:12:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B6F6E847
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 13:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdi9VrbmnrwWYfQ9taVAp3q+4iMKLDXsr+k1YDFVT/msgO/Qb5KnMbWQW7l8D9PdcaEI18B4haFeeUjziVha0IVsBk0jQluoYh5ph3zGyBCL21YdAEyxGSnealc56j9hMzYcCG7SCEnJNecFZ0p8+HVPUvrjO9i/7HPMwnZ/uxTpiwTnwR/hekl1kkyC05CXFlw0xzlYc+mUPcCO7PhCuGxw4uhzr1K2bmQ4uxYxJV2oc54QJrq2mkuwue9VVzmwOj2+pL4P0orgZtet3o9H6OeCOQUdy1Tr8ADbKssIMsz10nnaKh6nb1JPJ4RNH8ZwvjUHilBwaQmftEq7A8dlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8LIf7eAheAs1vdWLiLOYEiZwDV8z47PmeslQeLAb48=;
 b=TBwRj7rHUQNTsCPUxG7yLy/l1vEmIyEvZ0bbyi25DUxIMx2EGCHWV1+HWHssiNlXUecjJ91WYFsl9PvOhbIgRvsLIuWX2wyTK8cEItqiO0m+2yf0K88spinDKDvGEoStlELR216kXwAE7aYvnba/MS01+U3wjniiI1VWFIOWXw458Ydg9xuue9Jz9eE4YvABP5RTpTIJU+zFS81604xXTYK3N3j94huZTiFI8FSel1dpQX2coduCrXeP652E3wtWl9Iuf5ZoLjSY71zehAFCe/5pXcyvdkskBoa+SZycz1pPNw9uhZ7TLx+o7nD6TN2m2EiD8baFKUSTno0di20dBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8LIf7eAheAs1vdWLiLOYEiZwDV8z47PmeslQeLAb48=;
 b=Fkaa+HLaLxQaOkdwnvv5NfkFg6178bxf86V8day+siFTee6rY+aQOkubbg5YqPEZfgRWY4ZV5sbkKQtsvVxWdOIV8eS5CFd4M0O233Eq0Luqe4lltS08EPIdiDSEaawFizdg/QrynK7yIunlHiH2gG10hMZORfF89kqNRxPFvg4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 15 Jul
 2021 13:12:55 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 13:12:55 +0000
Subject: Re: [PATCH] drm/amdgpu: set noretry=1 for renoir/cezanne
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210715091443.830741-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <de1aa7ff-460f-028c-9767-5d21c33fea0a@amd.com>
Date: Thu, 15 Jul 2021 09:12:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715091443.830741-1-yifan1.zhang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 13:12:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 444e7aa7-5d2e-4f3b-78d7-08d94792423f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53655C6B3F83012F0099703392129@BN9PR12MB5365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErxVuqmif312kudYO4gHcsn+GQ2ZsB5kXclf60i9BuABHr3Yb85bWzsKJ/v3kDNCjAlZJ7eP5/rD+Egdpgp8DryXqg6VNUCBxrqda9iTTGOO2z7jJalrD7ee3sRs7iacHGlSuzZRs9kk2XmggbKUfm7pPbT/kpQpWWdz9SmFuLjR00Y0x3+PsU8/5mQ3nbDY00EQjKaQwETm1F5Mh6gUPwAkKyWrh7hmooZw/1gIUcyuXiJyUEqEMRo49R6PkwTeNazMsvuf2vzygT/YFzgXXLs3CD+SDbrFOx5v00pi8FX7cBcSo94YmlT3nBNM1lQaMgZcu90zf50lzKInLizd1gP0Vnk4Hbukpo0pLi3Kmz013KUOkTDcp340zjKJkB8fTCF6cSxgd0KmoDD9Ezc7je4l+Hv3w/jnNPRzBwcy1Hq+p2YOZaP0J1VKPtN6VtCdxaYbHG/JHxupvNNKRzUGz54Q5s6nwj7nZS7fnaODNGXnMz3aIY22LL7c+tm8kkp6SNwBLA6k3izAyEbRebTFWXUJB+d3s7yxB2QoIWo4pMdtx0pHyyX4fIApeflSYK2s3fXxmEqXVLZvSopEhcUnk330fg5gSlb5buo4qzkCLTqLX+/WAuCadRvDQ0RqT5OUorRmzPcmxndlBqul/hMgO8sTt5emGPDuwi6+ynoD54co/5I+jZEgIxPI7S2sgOIVViB38CQFYXtAGWg2wS28sJZjUAmG4yFI/tEqxVsKM1oq5zWRznOqxBNr7BEyh62x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(2906002)(16576012)(8936002)(38100700002)(186003)(4744005)(316002)(5660300002)(8676002)(31686004)(86362001)(26005)(83380400001)(66476007)(66556008)(66946007)(31696002)(36756003)(44832011)(6486002)(478600001)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxZWU82NXFPL0xJZGFDWS9yK3BEMjR0Zm83VEpKK0lZTExVeC9DdEdYaTdV?=
 =?utf-8?B?SzFBZnFKWjVNOUw1L1hDTmZVMEVjanZ6OTJ2ZUQ0MlpvK0hubkdLUVRPODVw?=
 =?utf-8?B?YjNLTld0VmRtaHd0aDZXMVpuODMxMGs4dTlKYUxLempMblRURDZYa2IwUm15?=
 =?utf-8?B?YjhLRG1scS9WZ3htVFFuMGFJU1NjYlc3T0d4VjFLMldDdWxBZTVDY3BKc3Ft?=
 =?utf-8?B?WFdUOUozR0FHKzdYdU9DS2s2UjhPSnlBN1Rwdjk3TEd6K1dvV1NKcG1VQUxm?=
 =?utf-8?B?VHRKK3hHSU5jZU1WaUl2L2hWUjFJNitzaXhabkRTUmttRGpNa2ZKZDFZNnZq?=
 =?utf-8?B?ZmFzaVR1T3JpeGxxaWhhSlVKZ21UN1AzbWpweFlvN1VMYVo4SEZyZEdETW5L?=
 =?utf-8?B?NFhOa2lnZCtSVm0xcUJVaGNuZFNuWWcyZ2lYREw0UGNyaWNMczZXUUZhKzgz?=
 =?utf-8?B?dnZENXFySjl6cFF0OFFVbnVITWROcGtBWG9wZkhySEJjZ2hJUXE1aUdOdGMx?=
 =?utf-8?B?bU04RlV5TGJodkNRWWE3aDBsR0tXTzI3OTJYNVRPeFFOQStncW1vdmRnZ1oz?=
 =?utf-8?B?MVV2SngvUGptbVJHVnNHUWl3WnZxcm5nN2V3dUZFczd6cWpNUTdGbW9NdjdB?=
 =?utf-8?B?N0RLbmdhajdHODFJMURvVmt0dUpsZklOVGZ4Kzdnbkt0RU5NZlNzMitueDI2?=
 =?utf-8?B?em1ySUJ0SmFMUjBNWnNvbitaMW9DUk4rTmVBWXJGUGh1QXVrejQ4ZHJwVzU3?=
 =?utf-8?B?U25VcXRaOE4wQ2orSGlOUmMvZGtQcHo1cTRRTU9KRHVnRlpXaHJkc21xa2Rh?=
 =?utf-8?B?R2NuWklkZ2NYT3hFY3BILzhzL2ErV1pHdUswTmpkdndJTUdDdUxlSWlVaUdU?=
 =?utf-8?B?Nmx4KzdWQjR3bERBQ1dqMGUvTi91anFjYmRrWjN3VUZRYW01TWJ1eDN6WjZr?=
 =?utf-8?B?UUtmUmJ4ZmpwTlBzTGN1bnBhYzhMNk9yTTlrSVVqb3Y0Q0xjUHNvaGNMWXBh?=
 =?utf-8?B?cmZ6Ymw5ZTJscXh3SVZxZW5LUGVsL0xrYjVuOHRjTlNtRFFIU1VhVGFlTHlW?=
 =?utf-8?B?eGcvSGJESzMvS3NGM1BmMVdQTWcrRFh0Ymo2elRFYlk1UnBBMitvVVh4YURB?=
 =?utf-8?B?aEN1OXJXYzYrQm9jdk5BYWEwdjNIb3ZtcVpIRzFGd0RjSklzQmxwN1duRXFN?=
 =?utf-8?B?alpLbldmd2w1VEQxL21zcjRsZlVEVzV0L3RKUFZiaGdVeTF2YkZIR1kwbFRO?=
 =?utf-8?B?VUsvcG4xNUtpSWoreGFTUVVtVTBPOXBGSXZ1RGgxVjJ5RDNFRjcrV3lBdHBU?=
 =?utf-8?B?YUJQM1o4YTdpQjlFSWl0eThJTUZLdy96a2ZwdGhLaTR0UlNnQWNPVURzWlFM?=
 =?utf-8?B?bWFQVTFiMkZ4Tkk5N1htTUtRR24xbDhNSytyRXl4YzhoQytkT2NNM3FrMWNE?=
 =?utf-8?B?b29vV0x3R1VDU2lxTnJ3UHNhdklYa013cit6M3oydlg1VE5tS0x3VGxCeUIv?=
 =?utf-8?B?RWFKYkRkOXN6VnltaUJFdE5QVVM4aEJ2Qjdmamo5Mk91ZnJUbGU2RzNHaG9S?=
 =?utf-8?B?K0Q4RnFoNXA5TFhERmxNakM4UlBtM3NNMk9jN21yclltZ0NTaXEzYmV6UXBa?=
 =?utf-8?B?clZyYjhKa1R6Mi9ZN0FBY0g5b0J1dmYyNmlFNTFwSlIzLy9Cd0M1MkF0K0ZV?=
 =?utf-8?B?NVBIVEJjMW1BR1hFaVpyeVBGS2hERlRRa3ZWa1VoUDBlbjdRUEdyVHFxRWRx?=
 =?utf-8?Q?Btrw4Vjlx2F9IRSjuMviYw/Z0jYepOEVAYdTP4u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444e7aa7-5d2e-4f3b-78d7-08d94792423f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 13:12:55.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngOh/wTRh9sry7RJfMQViQezyJMrDAZMd6feTi8W/j3Gj9plAm8GG+rxspVrRS1wCE3yH3P8zI2GQLaJ02JEVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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

Am 2021-07-15 um 5:14 a.m. schrieb Yifan Zhang:
> fix kfd svm test failure in renoir/cezane

This is not a fix, it's a workaround. With that fixed, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d4e9704dec62..00dc2824dcc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -592,6 +592,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  	case CHIP_ALDEBARAN:
>  	case CHIP_BEIGE_GOBY:
>  	case CHIP_YELLOW_CARP:
> +	case CHIP_RENOIR:
>  		/*
>  		 * noretry = 0 will cause kfd page fault tests fail
>  		 * for some ASICs, so set default to 1 for these ASICs.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
