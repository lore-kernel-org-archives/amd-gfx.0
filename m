Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D4BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3970F60EB2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3970F60EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37C76E2E3;
	Wed, 20 Oct 2021 13:57:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25CC6E303
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 13:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPb8OE+pHifENTh1xBiv49J/1zekkUuJ6+dxPFDUGXp8Vvjm4hFpTbqcuvOWKKqYp5Pbb6U//dJ6q9+JUJV7wl20LL5KzFpCtPPocZ0rCEnKXf+RIFbiF85igKEzFf49Klg0B4aE5gn/Rxa2A/Qd9qRCorK2Q1A77PfOAxjeMpvRox92ZHn+E/NW9rq49w+sgZ8d5+qM9OMsA7DW2bdHXFK+ynLbywSfSgZHA4lzhx9arcZ6uWB/JKqG6UN50eI9PHdEGt6IYI02eRMQOwiPXBg5EE0OTb4H53+SscURFOCpzHqamJBvEPCneGlDu6+tHHuuVrp89N5i2hWg8KcX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeVBQeAT06kMctTH5qAq9AFp+yU8IEkxqXwzUcvFk3o=;
 b=CAOjT2G662i+vM7WzhnRzJOmEoysBBXb7tXzLvAC7325XuxnnLW0get/Do2Yi7lMHUOhjoZoXwuo9Nf1tp9TKBc7YXjEUh6yPhS+zg5HHi/HnKnRHztT/U8/QrYUtAV3G9pDb8cVixyaC7UViGeTwZcH4CHm/9yps/ZoOQvHPvmNccTR3Pynm6uB6pV2zFzuZx3wlH9axGJ9uFYWaB8PiUlGWkhSag1p5VpKbNQxuXU2oOry3i8jsJ/3tWLcBxQu8Dmt2KlskQ8tFTWzMcT/EkAQ+1S3V1QcVr6oC+kuHwzOqKXjsYrdnyyWGWvJnHCB1SMGYaUHiLqWvDx9K1D0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeVBQeAT06kMctTH5qAq9AFp+yU8IEkxqXwzUcvFk3o=;
 b=iKUJshWldB+P5Gxa+jsljER2AMZa+Q7fMBnZERedJkMfR8bRn9FPBAl4C7zuxIGlTPRHYfZHWh/xsf7u4lrQvRT3nQEu+bUeTBxQqf59muSWkLQXNjS0nxetxvIuRkB8ZUIFtVnD0dN1Tk0jF7T6KddviDwnY9ss28o6l7TjPDU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 13:57:49 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 13:57:49 +0000
Message-ID: <a9c6ccd8-1fdf-5f7f-f69d-008b056d1b2c@amd.com>
Date: Wed, 20 Oct 2021 09:57:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amd/amdgpu: move dpcs headers to dpcs directory
Content-Language: en-US
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211020135452.423205-1-tom.stdenis@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211020135452.423205-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 13:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae36996d-806e-459b-d0bc-08d993d199b5
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5410DE8EB1DD779526DD076A8CBE9@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHt15I77+nbxsz/q0HL7uBQ8ocNBjwgHBjnv7zpIlcdAOI6ziUjOk9kF1AkjZd3gNOqg3KdWA8CMY8XXC0nEpFbTATlFvOUKp+Modeyx3gWiHmFysF3OznM1Xa39IDtYE/PskI0jyXcAtFS1bCpdSlX2o1rdlceqQ7KkBGN4boOikXiXP9fRdnbL0shZCMhD9puUvcsf/Jz5aAS6Te5SUWvPz9uBrOuMKBiAlLsGoSsz2tZj12E6gOXRvKqHNBpY4bctxX+ovLMPu6mWATvICR8KTGN7lbw+d9lOpZYW6I/DF4xTFXWR1DkBE1uTmA9Pd4jHeLDxMqBjS/LYvNjhBZ5G+2ufAPU1xe6nXqR4I/r51lUnTXC/ac5JGs4SSvO4Zm7VEoRHZ7N2rZ+Wsc+8SDlbKoKUpcMG0PZxt5vA+cfkFvTmCtYJtecTlF4kZu4/2KAqRBpRISR+nZqXrIsQCU0ZXsQOQYfI/ma85hv99lmWoyGAHy5XRBqxkVhXHPN2gCZ4/DF8AJMWWePnlaEw9+8OwSqgYxFN+IV42odfPu8Y0qDCBV7+IwTWUYnQtsmJ7JmL7ZTIWUMYURsP698k0dMSoSAdcmwrzvPyXv24hwr0+nvZkFF+QULq6p5PnhlRgjVQ4A11XtOs/jcGCa1wLQt4mwSd4nSHrUO86wviTnXnkF/WSiwsu1KTA6F9uJTTE7wuSZRxe94erpz5gsljcmE8Qf+n4b/Vcu8wBn8IBUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(44832011)(4001150100001)(6666004)(956004)(2616005)(31686004)(83380400001)(8936002)(26005)(36756003)(8676002)(53546011)(508600001)(316002)(38100700002)(66476007)(66946007)(5660300002)(2906002)(86362001)(16576012)(6486002)(31696002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdtTVYwM1pGN3BHV1o3TzhJMkNKdEtqdHhpR2hRaGdEQXl1UkV2dVptdzNJ?=
 =?utf-8?B?cnRSSTN3ZWxXbDBGY3hiNlI5Wi9TVHpzbnBEQURpMzA0em91OWNaWGUzUzhl?=
 =?utf-8?B?L2VxTkE0RzNZT3krZTZEeGVjbFU4ZStZckV5cks3eENrZ1doVWthN3lvU1Jn?=
 =?utf-8?B?dDZsUXNaT2NDMGQ5SDJsTHdYbnRqYXlPaURJQjBmUmVDdDFhcDJmTUU4MnhO?=
 =?utf-8?B?bUcyNDdMdWxnajZQU2NFaWtpbFFubWcwRld3RDVWOHFwbWIvSk1Ddm5MQmh3?=
 =?utf-8?B?dmFPV2FsaWYyTmhXelhRM1NmS3NUTlYzWlhIWHhtT010QWR4cmxuUlRoRWx3?=
 =?utf-8?B?QmlaMUd1NXZXalVGaEFUb096TmdxQks0R29Vd2loMmQ4Z2RlZWpjakptNWtR?=
 =?utf-8?B?UExWaUFmUUhwa2pyTG1VZmdYZzhMajN0ajRDb1IrOVdjakFRU0xCNCtKNm04?=
 =?utf-8?B?ZUViMFBreFZJOGxraE1KQkl3OFYyNTZtcTRQUVBXY2x5OGw4UjU5SkxIRVVk?=
 =?utf-8?B?RkFUUGtLdTRsM1VQeFhvQURRa254QlhTTjUyZWxhdUVVcnJqOFA5dVJyK3p6?=
 =?utf-8?B?R3crVzFHMXBuSTltbWdPNTNNdXZueTNTN0FQQkpIN1NOc1ozWkUrdTg1V3Bv?=
 =?utf-8?B?Qk16OE9iN2FMSDNqT2FDU3JqZWpuSXpUV3V2WFhKNGs4WlEvVjArQjZkLy8w?=
 =?utf-8?B?cTM2VkNKZ2xZL1orMS9tM2F5eTQ2Wm8vOWhCWVhLWGs1Tm93UzU4ckVRVldB?=
 =?utf-8?B?MjBpQUlKcm5wOTlFbGFablhibXNaSFoydFk4RmlOZm5oa2tGem96WjVrUDVV?=
 =?utf-8?B?V3BTOG0vbVdZMUpmdHhGMThQdFA5cnNaRjRldXJBbzkxb1hvNEpuS21KajZ5?=
 =?utf-8?B?MWtGcWV1RDVHNkJqUElrSlBvRjd3bFpCZmNRT1BNNUM2TCtPd2lVZGhTR3Nt?=
 =?utf-8?B?NlpBQ0d2emdIMkRENDNLbCszM0RMSURUVkpXc2ZUSk5rTGgvUGJzVjBQT0cx?=
 =?utf-8?B?ZlFiR1ZYa0REcDNpcThKU2JiSEZVOXdGbUZCOW1YVDVXSllLdTJScUJhNDll?=
 =?utf-8?B?WVNPRGFHeEhZOFM3NmxxVDd6bmR3ejZ5WlhiQ0kxeWJ3Qy9DWUxMejFZajVW?=
 =?utf-8?B?NDIrbmVXYTUyeXIxcmZwSFRtY0xhZHVnekRRcUlQL1NiTk1ob2swNlZBVmpX?=
 =?utf-8?B?eGFGTUU2bzRQdUdOemxxaWVFS1B2OUJDK0E0cFV2a2VDMTJKRnRYbUkzMDFv?=
 =?utf-8?B?WjRFVkIwQWs4K0RGR01iNVNseDFxYU0vN3o0K1ZKd3gzTzE5UCthQXlDeEV1?=
 =?utf-8?B?WmlvSERQS3RTZG5TSXNxWG4xOGRlNTZJMDBNVGxIUXRwdkJmWVdESmtaSFlu?=
 =?utf-8?B?cm9YUmlqSlB5eXVSbFVuc1NjYzExeDYzaHpOMWloaWlENE9YWnMzNE82TXZL?=
 =?utf-8?B?MnJENE8zcENuYnM0M0cwSXYvUFhUYWxFS2JBcDcvQ1owdnZsWUFLUFpmZ2Ru?=
 =?utf-8?B?OU05em9SQUN1QUg4WDNkVWlzWVBJZWwrLzRxWXFkTUw2cFo3N21URk9yUmVV?=
 =?utf-8?B?NEk3YU9XNTJLQlR1WkVmRm1HWUtld2sxU0RLSWpsVGxSL0pFZ2UvRUdPZFdQ?=
 =?utf-8?B?eGxuclcrdStPcFFMOTBobWVBTUwvUU9PbUNqcE9acGpEU3NGNU5GOFp3UXI0?=
 =?utf-8?B?TWpLZkY4Z3RLc0NyNEI1NnZ3VzM0V2RhdHN4dlNvMFRnZ0JOQU9EVHl0SkU4?=
 =?utf-8?B?RTNaLzV1SHBNcUJPSVo4MTRpMlBjbDdXMWxzTEhHUG1xd0hsVWVXSGJTSXI2?=
 =?utf-8?B?RE1oNUk1MlJiMWZuWXBoZml0L3ZUK1F2aTBUKzYzSVhKMU5kWDE0OWNMNDF3?=
 =?utf-8?B?YWFQSVBIUW9UV3h3VGpjQ3lOZXBWQlNFbDZVQ2dhbzFqdnFWalc4dmhKTnZh?=
 =?utf-8?B?TVd3elVTczZUZk1QMWFJbzEyNWRMMUVSY0JwR3ZQWFhxT1Z0ekhBZUg4cmta?=
 =?utf-8?B?Q1pvaGx3emVDSUhnS2VyR2lmcFZnR3h6YTAzUGFvOG1PL002Qms0QjFOMXpj?=
 =?utf-8?B?ZmtGVFNzcHRic21jMGROUWV0bU51Ylg1a1RtVVllVVI1L2UrT2IxdUVveHNE?=
 =?utf-8?B?dEJGWUdhY09wWE9sUm1MNlJuZVJFTDVUZFE4VW1RaURyZDlKMUlGUk5adkNV?=
 =?utf-8?Q?iZsAIsmEysYghWfL/07ZWLQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae36996d-806e-459b-d0bc-08d993d199b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:57:49.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXNifm+O4rohR3zZFf5rcnXg32+mk8HOmB0U9DSaH4hfVjHkI7k0F+RyxRD9V6cEQ12w8jfa2/gWabhDG+A0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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

On 2021-10-20 09:54, Tom St Denis wrote:
> Move dpcs headers from asic_reg/dcn to asic_reg/dpcs.
> 
> Update various .c files to include new path.
> 
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c         | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c       | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c       | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c       | 4 ++--
>  drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c  | 4 ++--
>  .../gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c    | 4 ++--
>  drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 4 ++--
>  .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_offset.h    | 0
>  .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_sh_mask.h   | 0
>  .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h    | 0
>  .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h   | 0
>  12 files changed, 16 insertions(+), 16 deletions(-)
>  rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_offset.h (100%)
>  rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_0_sh_mask.h (100%)
>  rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h (100%)
>  rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h (100%)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> index 1861a147a7fa..7d4be9d727a7 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> @@ -42,8 +42,8 @@
>  
>  #include "nbio/nbio_7_4_offset.h"
>  
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  
>  #include "mmhub/mmhub_2_0_0_offset.h"
>  #include "mmhub/mmhub_2_0_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 3a8a3214f770..aa5ea6656a8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -72,8 +72,8 @@
>  
>  #include "nbio/nbio_7_4_offset.h"
>  
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  
>  #include "mmhub/mmhub_2_0_0_offset.h"
>  #include "mmhub/mmhub_2_0_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 5350c93d7772..8a312e0d9c1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -73,8 +73,8 @@
>  
>  #include "nbio/nbio_7_2_0_offset.h"
>  
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  
>  #include "reg_helper.h"
>  #include "dce/dmub_abm.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index fcf96cf08c76..38f43f9cab5c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -64,8 +64,8 @@
>  #include "dimgrey_cavefish_ip_offset.h"
>  #include "dcn/dcn_3_0_2_offset.h"
>  #include "dcn/dcn_3_0_2_sh_mask.h"
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  #include "nbio/nbio_7_4_offset.h"
>  #include "amdgpu_socbb.h"
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> index 2ce6eae7535d..e29220b3c67f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> @@ -48,8 +48,8 @@
>  #include "sienna_cichlid_ip_offset.h"
>  #include "dcn/dcn_3_0_3_offset.h"
>  #include "dcn/dcn_3_0_3_sh_mask.h"
> -#include "dcn/dpcs_3_0_3_offset.h"
> -#include "dcn/dpcs_3_0_3_sh_mask.h"
> +#include "dpcs/dpcs_3_0_3_offset.h"
> +#include "dpcs/dpcs_3_0_3_sh_mask.h"
>  #include "nbio/nbio_2_3_offset.h"
>  
>  #define DC_LOGGER_INIT(logger)
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> index 5f6ae3edb755..3b7df1ac26be 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> @@ -42,8 +42,8 @@
>  
>  #include "nbio/nbio_7_4_offset.h"
>  
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  
>  #include "mmhub/mmhub_2_0_0_offset.h"
>  #include "mmhub/mmhub_2_0_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
> index 0046219a1cc7..6b6b7c7bd12f 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
> @@ -40,8 +40,8 @@
>  
>  #include "nbio/nbio_7_4_offset.h"
>  
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  
>  #include "mmhub/mmhub_2_0_0_offset.h"
>  #include "mmhub/mmhub_2_0_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> index 914ce2ce1c2f..0b68c08fac3f 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> @@ -37,8 +37,8 @@
>  
>  #include "nbio/nbio_7_4_offset.h"
>  
> -#include "dcn/dpcs_3_0_0_offset.h"
> -#include "dcn/dpcs_3_0_0_sh_mask.h"
> +#include "dpcs/dpcs_3_0_0_offset.h"
> +#include "dpcs/dpcs_3_0_0_sh_mask.h"
>  
>  #include "mmhub/mmhub_2_0_0_offset.h"
>  #include "mmhub/mmhub_2_0_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_offset.h
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_0_sh_mask.h
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
> 

