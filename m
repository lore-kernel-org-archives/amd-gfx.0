Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372F8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 15:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD11733B4;
	Wed,  8 Dec 2021 15:10:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C16733B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 15:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLhDCoc7SF+u/GEScPKZrnNVHhz89rSUvau6XOsAOiavE5wu++6V3D2H4pYFM5eRUQU0MafrZxkWabEhjkax010UVfeOVj6duHKhXl3tPjqY9Gu6E2Imz7zlfrGdeBnLJzU+81uFbsDZ1OX+1LX73pmiXztxuB1hTLUDoGLlBLtgdKS6QoUTMIFnzMI8wL7oDAvrcdXyaYyrRtm4heQSnp13FyYybNfSOu82yKyTTEKSgOHYF94aaHaZJ8HXUj688pW6AQ7LkYUhKt3Zf3xDbnTrZGQaPL8W8wJQ7aQM05T3pPpjaJVaXIYGGqsfUw1fPDUKjNy4Fa44fmIvbVuRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beaAYISYlNddiGTcSteuwOzJRqZzqADMRvkZfAflVZA=;
 b=e3FtEwPmTFI1u14nFqhyBgx10lclOKKhK9Wv9Iy9KNi50RIjTowMLqzt9X6GEdYhOWdoHSB0outOGdZ44ZiUlqmVwf6WXZiAu9gb3xOpxzJIHZALF/YLQ0N/BaCT0+aKfir/SRqJ7UGEKOLbp6pd5sFweB2c39uVm11COdLwmU8X14WHQZ1C1p6Q8cW6uctWKHgeApuZv1DaZ8g1qFkTaRnpSgzrnoIrLyko3Whg6NU0eL7Z77MVQOFFbwx11X3x8p0TZ9wKutFl3Tplf/hfu4D9Weg/mUoORq0ldG3AUTlPVFD78hQ556DpaHSLMKy7ZvGakFlQuXxLHgl6avkSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beaAYISYlNddiGTcSteuwOzJRqZzqADMRvkZfAflVZA=;
 b=pWk9k+QHpNzDQQ0FwQq4pS3/DxjTLO0+WG4QYDIcd1YVG+cbCaEJ8bOU1mvU5OVXl0UpsQLjf/72amZY3ZqpEyNpOkaRWAILjuzR1NKMBk+evI7wE/PS015cWceI5utGqd0fBvsavGTx1OSp78xS6GdkiSSo6Yr3bQUGY9hsPxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3405.namprd12.prod.outlook.com (2603:10b6:208:cb::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Wed, 8 Dec
 2021 15:10:53 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4778.011; Wed, 8 Dec 2021
 15:10:53 +0000
Subject: Re: [PATCH 07/10] drm/amd: append missing includes
To: Isabella Basso <isabbasso@riseup.net>, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-8-isabbasso@riseup.net>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <3e643175-3d25-d48d-8930-47b398d65b76@amd.com>
Date: Wed, 8 Dec 2021 10:10:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211208012529.372478-8-isabbasso@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:610:77::22) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c7d14b-f05a-4f6e-1f72-08d9ba5ced63
X-MS-TrafficTypeDiagnostic: MN2PR12MB3405:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3405F2D19043E3DE114133B5986F9@MN2PR12MB3405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rT43xfAWlR5ra7u724FgU4CPTxgeN8wmBSq0lwEo5TXYjGLzl1J6i47qr6eyfWloddCDM3uybZ+m8p4ojeUy87B4X23aljOK+YGPFly6/FwKyvls3nmyRyZL1CWydwygPH9FHm2AYenGzaPPnK1dwY9bVBHGpQbf4/7vvMxOYEnp0uGHiuu9qk5HCMeWCu23hBhK/A1UNZE1LTVQEt2HNq2uEsj/0/hssXYgGHLYF4zzckpPI7nAGSRL4z1V7gxz5H2U1edgA+vxmsVxYcNFrCEnnrWAU6w4K2PrtMzDCDRTK2ZtCHdNt9H1dDa0BInqKf57gdth8EKPlfN/iJpkduJCfiPjtL6EIcnA4ddOZeZbOFK3byt9SkiKpPOKVpVm4NI4NADNypcsHlway3rsQ7QhXd4OK4CEue9JE+8x95hKscOhQaagm5pg0tOgK63RxUkEYveQRWioJ/gownwxtPdY4+zgZjqUeoYtMuUyJ2kqgk38dgfK25papd1BfPGy0zhOTJoSY0T7WFmXojGIhLBCAcBumV2v81NbG7UUeBsrZTG24FntIJUitAOqvfcvaXMkdXI9j2zqw191kfei7ptboEFWO6xDlwwVc/P/VOXeAGgyxQudR4ovRaxoarJJWIyhYNUBtSxd1lWCe4PYen7KAw6MpIqZ/cWycjt8j909yam1Yc4kwh4ymoVY5On157YKuwLqk90jtuTgBiVsjg4e5fuN8Q7mhtK16+BHHXRfNLejw1N/iC2MO1BRsRya
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(66946007)(66476007)(6512007)(6486002)(66556008)(38100700002)(316002)(2906002)(186003)(31696002)(508600001)(4326008)(83380400001)(6636002)(5660300002)(31686004)(8936002)(53546011)(6506007)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZrbWNjV1QwTFZWb2dqSmtMNExGZW9xQ1hmT00xRG9qbk5KM0RsZWI3OURz?=
 =?utf-8?B?b2xIZ1NIZ0tqQjA1bWsyQlp4TzIwSEZZZjlPV0NXM2hpK2FiNXJhaUFCb1RE?=
 =?utf-8?B?V09nT25CeUpzYnpHdVFQSGFJTjVSWU0wenEvMnd5QlF0ckpwVmR1VDZSaWhU?=
 =?utf-8?B?bnpLdTFsWGhDNEN2WTEvVkh5cUNTeVZFcWVkbVpDelpXU1hVNHdRMHdCWWw1?=
 =?utf-8?B?cllYR3Q1YkNDYWxrUVdYQlAxUWgrNTdmTDROczZZSlF6RTlScGY2OFBUYVdu?=
 =?utf-8?B?eWpuc3hIYlkyS1J5T0d3TGtBcjFpTFlOTko3UmZSTnBMM1A2VDVYQzJXZnhU?=
 =?utf-8?B?ek1oRk1Ld3FqcUN1eDhoUmIwL20ra3V0Z3hlNW9pU3ZiWkU0MGdsM2hvTTRh?=
 =?utf-8?B?YnlTSmhUOEUyUEhheWpWa2RVSTNEWEFjRElTTko2ajErY3BEa01YTmVodXpu?=
 =?utf-8?B?bFUzV25oa1B6ajVBRUI1MTNSNnlndmxZd3Q5WlhOZzg2cjcvVlBZdStBTnFF?=
 =?utf-8?B?RGdMRzUyYnJIV3RsYVBxaDdtSDBBUGt3dEFWY0pBb2ZRaDB5UGFmcCt3Nzgx?=
 =?utf-8?B?eFdXVTFhSFhRdWRYK051MDJERmMwL0llVTVUOFZrOXZWVkpHdEY5YUlwTFph?=
 =?utf-8?B?U202SDBrMWNLdEVOQ2w1SmtNRjFEb0FwZ0Q0b3VhOFNUam5sdmtDcWVjblUx?=
 =?utf-8?B?VXkzUFBLYVlYVWM4V0Eybmo2T0ZrSVVvMWJST0ZHWkZ5ektaR1hlSHl2WndF?=
 =?utf-8?B?K3M2SVgwbTRCbDNGeDB0OVhjUS9Tck1HQnNkbXBSdlJCeXg0VmJzVjhqTUxm?=
 =?utf-8?B?anMvSXRsVExibFpOVGtFYjE0MFJBS1k2bUtpR01mb3BMcnJSejdrZjhBQkcz?=
 =?utf-8?B?TjVBUmd6Tys0bEI5eGZkOUdDMGh1bmU1Nm9hVVdZTzBPMzFLVGtETUJpZDNM?=
 =?utf-8?B?ZGhkZWwvK0gwTnc2Q3VyREhSMk1mb0VRU2RGaEliYjRvR0VGNmNjb3hweWJD?=
 =?utf-8?B?c0lyNmpBbGE2MWJnQVZRWlpmRGtWYjZKS0RqN0luYUliYmN3MGxKZmlMbXBj?=
 =?utf-8?B?RzVHRldIazUrSG12bWExTU5yQmdBb1pIbzFLODZxdkdFbGI4TzJkV1JnMWRR?=
 =?utf-8?B?akRwbEx0L3EzSk5FOThNWWxZZmNJdWUwZzkrUE96ZWJuZ2ZoVHRCN0tqNEVJ?=
 =?utf-8?B?WGZ5K2cwV3hQUkZ1L3FFak92bGJLRUlMd2p0Z3RFMmpoZWxZY2hpUXdoUlVJ?=
 =?utf-8?B?MU9hWXBGdUpvOFRFNU5oUy8vWk1MVnJjcGE4bFl1R3FPdHRuOUtLZGJZMk5J?=
 =?utf-8?B?QXpHK2JxUDFBZVhFOGtuVEg0TmFZYitwUXFlWTNUWmxEYjBYOFFHTXYvUGJw?=
 =?utf-8?B?UWlmeFUzTmhkczJ1QnB0aFVRaDBrVHErWnpWc2oxYlNZNlozV040bC8yZzhs?=
 =?utf-8?B?ZjkyTnE4cmdydHFINmhUb3JSVUpQZDdHWXB2akl0dTdhWEN0M0I1S2NWTEEx?=
 =?utf-8?B?M2dGa1lsMi85MEhiMGdmaFp4eGw1ZXlQZ0E5Z2k5dmkxS1FxZ0pwcStiU1gx?=
 =?utf-8?B?S2dXYXZoNW1Zdm1JcjhIbXRhRjVlckR1aXhYaWZRWmdDbVBub0pvOFhZZjhZ?=
 =?utf-8?B?N1FtMm5raDJ1K3ZOcTRRd0JaTG1EUmVYRVRhTDYzczQyYW9NZ1dqTXNBRHBt?=
 =?utf-8?B?WWZBNXFRWit4Q1I2K0tzRDZ4SnQ4YWNycGZyd2tDWi95UjhmV3R4ZmE0WEk2?=
 =?utf-8?B?VktyM0RSeDd0TFlPTjBoV1Jadm1yelJsbS9LczRsTDAyNlUxc21STGdnMG4y?=
 =?utf-8?B?QWd3REZJRVRxL2tJVGlnZnM1VWhwT2wxYlZ1SXc2WUozdlVnc0MyUHZjbWEz?=
 =?utf-8?B?OFV2RmtNamlya3grYjVoL3Q3VmZ2YjNYak9XQ2J1VkdlZW5GalM5bGRuRnI0?=
 =?utf-8?B?TmJjcFY4TUc3YXl0c3d0VzFNOGtjVG5OejVibjErakRlamd3bmJSajVMdEg1?=
 =?utf-8?B?UDdzbVZDN0VGQTk5Q0hNZzB0Q0hjOHVHSmpwcjNrUWxwVnpQL0I2TjZqWUZ5?=
 =?utf-8?B?YUhrS2xoMFNmWitLY2lCczdhTDFLWUszd2Myd3pSQ1IzNHUyUFBxNGUrdi8v?=
 =?utf-8?B?bXhrRjVyZ2s4UUZsUnlnUFJ2N0xPbk9EYThwdnBGcDRuUTZqVDVqcTBxckp4?=
 =?utf-8?B?Yk1XY2E4c2NvVU5wckVWek9IZGZkL0Zrc1NBNjg3ZUYvclFQS2E0NGJva3BX?=
 =?utf-8?Q?YTj/EeywxDl38EklE/aCFgeItY3iKJTyYJPSPDZuRE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c7d14b-f05a-4f6e-1f72-08d9ba5ced63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:10:53.3638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bC20CahNSlwZeLb+2NwcbWWY47trSRFP4T80btE8e5/wrt9KVWjXKWc97TgQaDFQr6qWJ5GdvNdn2EbLHPs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3405
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
Cc: ~lkcamp/patches@lists.sr.ht, Felix.Kuehling@amd.com, daniel@ffwll.ch,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-07 8:25 p.m., Isabella Basso wrote:
> This fixes warnings caused by global functions lacking prototypes:, such as:
> 
>   warning: no previous prototype for 'dcn303_hw_sequencer_construct'
>   [-Wmissing-prototypes]
>   12 | void dcn303_hw_sequencer_construct(struct dc *dc)
>      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   warning: no previous prototype for ‘amdgpu_has_atpx’
>   [-Wmissing-prototypes]
>   76 | bool amdgpu_has_atpx(void) {
>      |      ^~~~~~~~~~~~~~~
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c                | 1 +
>   .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c    | 2 ++
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c | 2 ++
>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c     | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c               | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c               | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c               | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c             | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c             | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c             | 2 ++
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c               | 2 ++
>   11 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index c2be6ad62308..d6d986be906a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -11,6 +11,7 @@
>   #include <linux/pci.h>
>   #include <linux/delay.h>
>   
> +#include "amdgpu.h"
>   #include "amd_acpi.h"
>   
>   #define AMDGPU_PX_QUIRK_FORCE_ATPX  (1 << 0)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> index fe18bb9e19aa..06bab24d8e27 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> @@ -28,6 +28,8 @@
>   #include "reg_helper.h"
>   #include <linux/delay.h>
>   
> +#include "rv1_clk_mgr_vbios_smu.h"
> +
>   #define MAX_INSTANCE	5
>   #define MAX_SEGMENT		5
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> index 0c963fc0523f..8161a6ae410d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> @@ -33,6 +33,8 @@
>   #include "mp/mp_12_0_0_offset.h"
>   #include "mp/mp_12_0_0_sh_mask.h"
>   
> +#include "rn_clk_mgr_vbios_smu.h"
> +
>   #define REG(reg_name) \
>   	(MP0_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm ## reg_name)
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index a6bc3c7673ba..abef132fa016 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -69,6 +69,8 @@
>   
>   #include "dcn10/dcn10_hw_sequencer.h"
>   
> +#include "dce110_hw_sequencer.h"
> +
>   #define GAMMA_HW_POINTS_NUM 256
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> index 5cfd4b0afea5..91e4885b743e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> @@ -27,6 +27,8 @@
>   #include "dcn10/dcn10_hw_sequencer.h"
>   #include "dcn20_hwseq.h"
>   
> +#include "dcn20_init.h"
> +
>   static const struct hw_sequencer_funcs dcn20_funcs = {
>   	.program_gamut_remap = dcn10_program_gamut_remap,
>   	.init_hw = dcn10_init_hw,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> index 54c11ba550ae..b270f0b194dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> @@ -28,6 +28,8 @@
>   #include "dcn20/dcn20_hwseq.h"
>   #include "dcn21_hwseq.h"
>   
> +#include "dcn21_init.h"
> +
>   static const struct hw_sequencer_funcs dcn21_funcs = {
>   	.program_gamut_remap = dcn10_program_gamut_remap,
>   	.init_hw = dcn10_init_hw,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> index 93f32a312fee..4926771ddeee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> @@ -29,6 +29,8 @@
>   #include "dcn21/dcn21_hwseq.h"
>   #include "dcn30_hwseq.h"
>   
> +#include "dcn30_init.h"
> +
>   static const struct hw_sequencer_funcs dcn30_funcs = {
>   	.program_gamut_remap = dcn10_program_gamut_remap,
>   	.init_hw = dcn30_init_hw,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> index e85b695f2351..3d42a1a337ec 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> @@ -30,6 +30,8 @@
>   #include "dcn30/dcn30_hwseq.h"
>   #include "dcn301_hwseq.h"
>   
> +#include "dcn301_init.h"
> +
>   static const struct hw_sequencer_funcs dcn301_funcs = {
>   	.program_gamut_remap = dcn10_program_gamut_remap,
>   	.init_hw = dcn10_init_hw,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
> index d88b9011c502..eb375f30f5bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
> @@ -29,6 +29,8 @@
>   
>   #include "dc.h"
>   
> +#include "dcn302_init.h"
> +
>   void dcn302_hw_sequencer_construct(struct dc *dc)
>   {
>   	dcn30_hw_sequencer_construct(dc);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> index aa5dbbade2bd..f499f8ab5e47 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> @@ -9,6 +9,8 @@
>   #include "dcn30/dcn30_init.h"
>   #include "dc.h"
>   
> +#include "dcn303_init.h"
> +
>   void dcn303_hw_sequencer_construct(struct dc *dc)
>   {
>   	dcn30_hw_sequencer_construct(dc);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> index e175b6cc0125..e5885f62a764 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
> @@ -31,6 +31,8 @@
>   #include "dcn301/dcn301_hwseq.h"
>   #include "dcn31/dcn31_hwseq.h"
>   
> +#include "dcn31_init.h"
> +
>   static const struct hw_sequencer_funcs dcn31_funcs = {
>   	.program_gamut_remap = dcn10_program_gamut_remap,
>   	.init_hw = dcn31_init_hw,
> 

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
