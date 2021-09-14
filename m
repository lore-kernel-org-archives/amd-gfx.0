Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBB96112D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BBB96112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA616E4DD;
	Tue, 14 Sep 2021 15:52:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140106E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 15:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft0lPg777JLX6M851ROG7fzKXfbcz/2w4uTGcLODrLxgd8pkCbHgB7FXKrgv5oXiWy3KvPM/EloBXxn970GdiaS5epZ9lRHwgsBaQXzgBaOHEszUpp7UL7XEfshpT0/pMEN+pWsaVTD4CWfFcJws07EWzGIGdnJstYo+DdZjRpHPA1gQGYTAUcP3JZUaipbZ9WhOHMkKNYbUdnzrOGSIInSCTMzmvyfmgNgtVgLZrbK6DKD9tyiBDeJJwqfMUkQZR4vNGGHInKMgbhOFDe877oghrteAqqOwTuemQTUZ1wWcyl6zisXOQPAHzlTqb0xKzglepfBNk4gDObx9XyXCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LhTLfZQnHMbAbw35/BZt3uyz2pmNt8v4Tq2XLfsz4rc=;
 b=UQvi0ZUHh+5hhVux7uGMGnmyuXBGg2H7Mcz0FHUb3hHyVyqvgvskbuWHF7T2giBXyREWCxz4C3jgGiHHEov8hNl3vA4GhdcblrN4in3/ddnLB5nZOruOsGKHIPiYppS9Cd8Q6014DpsVwPM4mcPABWsx6Q2rwZbDwO5j34Par4xr3BbeyTysxs5Nx7/h2NvL1SBCRLYGAqFtmPNRSO0+9JjKIJuqlK78p2NpDuwpSi3ZD7c7+MbvyiKV1zIIRau5PvHGjtTFWQrmcK/SmmZ/NHaL4TnBhSP5/ss+xqTVJup+OoKdxuXQuFOWtd4BFS376QHtemvXG9UH1kYrq8R1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhTLfZQnHMbAbw35/BZt3uyz2pmNt8v4Tq2XLfsz4rc=;
 b=UC2QV+iS+P6p5cXQggn4T1euHE5uihl4COPA4v7k1tfmYGPpxQMlw71TFRlfBOKzBNlGYrRKgb6Q/LcHdNZ1wzjqhIMlxOEgKFGMe3VSHkp9OklfCH3pxSFJgL3LmLR+pYdJeNklCz7NbXzLXluHv0r5qRezMRuVR9AL6CbFz98=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 15:52:40 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9%5]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 15:52:40 +0000
Subject: Re: drm/amd/display: move FPU associated DSC code to DML folder
To: Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20210907143235.4309-1-qingqing.zhuo@amd.com>
From: Anson Jacob <Anson.Jacob@amd.com>
Message-ID: <875fd5fd-e1b6-436c-c98b-666e08f78c48@amd.com>
Date: Tue, 14 Sep 2021 11:52:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907143235.4309-1-qingqing.zhuo@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To DM4PR12MB5072.namprd12.prod.outlook.com
 (2603:10b6:5:38b::22)
MIME-Version: 1.0
Received: from [10.254.68.61] (165.204.54.211) by
 YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 15:52:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a54e88a5-435e-4673-024e-08d97797aea6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB510235F6CA73E8F3B07E8AECEBDA9@DM4PR12MB5102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OigLKSnaYLwLGBLiSUvakg3VCkUcV2XxrXCFMH+9HX5dTnASWniE2wGbjOCWs9FuLJc/PmepJ6ZmqwmWiafBepuZGoJR4ruULONiQSYJKjHfxxKz/Lbd29yA8x1lc+6kuFuxJ/0p6msd1gSpb/Rop5bhllxqWMiz6tQyWPs4lyt7Ch7bvXFq2DA4PJFI0WxV+YvfkH+p6HB6btin9hIyH2ATRxZV3mydLvNxAaMYVZlmbpKbI4uj7+hp5cciUGaGme1CL2i05D5XxOAEHgVhcMRdsl62syjODPEKkvzFCUdlQbp4GM6H8CQm9rSU/gZjsXsRYdHXeD3FWQt1OuD23Y3RyoqS9ng3yPe8RCArwANKKj4r23gTwz+32lOV5twRlwkFrfVAVpcREe2p4gjxi4U1Jpw94LIRlRbT9feltW4U6VWxZpig6PKy5IPrQI/MXts67ozbb+p4xjdVL+t/a33JeLXQm8W9zk7QJsrGoQA8qJPjFPUjx8fsilucGpBSs5k4UPLi0uiX9XNEN+lIohXyy98XLhReyZqGaKKQiAJtNXGx7t+EjOjVlEjOiTq3emwjZTqw8Bk6XOSxVjZz8YT5ghf5m7Es5gYuX9JD3gcPB2UQLG0CbnzPQHn31mmju6cpUV7rGRm3lLwPItnVhxtSFk6fL5egi4L6yQ2GkgGKfR+tZkWh1TDDkFVuBEacDFTtXZFqdNLLnWv01xvDqnxAve0JGjpAKeXggwLuBqktwYLZCaZkeGkExTL3yXRmTNoOr8MRtP/gwMdLh0xKyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(5660300002)(966005)(956004)(2616005)(53546011)(66476007)(66556008)(54906003)(4326008)(16576012)(316002)(38100700002)(66946007)(26005)(186003)(30864003)(83380400001)(66574015)(31696002)(508600001)(31686004)(36756003)(86362001)(2906002)(8676002)(8936002)(461764006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFd3R1V4SDlMZkR3dHk0R2dkTTRVNDNwTGdFWGFJd2ZYRytvT0VKenV1WTRV?=
 =?utf-8?B?K2hwRzY2RGlsd2dLRklNaklid2VxNmFmaTRDWFk2OHpTblRkenA2R1c5dFR0?=
 =?utf-8?B?MFB6SSt3Nkl3YzRNSk5VSmpvOXBrVGRKUE1YYS9ydzRxTE5Ga3prUWl0MFRt?=
 =?utf-8?B?QzlNQXhlZnU4VExyQ25uR0RaMmxxVnV3QVJhUzM4bnBnbkJiR3ozUmtuSjg4?=
 =?utf-8?B?Y3RVZVE3ZzBzeUF4R1NSaVFXelFvaFQyQVNua0hXSytVSENBbzgrUXZtcnJE?=
 =?utf-8?B?b1FFZXJlUVhOYmk4SEZYZlBwR2dMMXNNRXdoRUwwRU80YzRuRFZNR3BNOU1R?=
 =?utf-8?B?OUdma2NieVo1OXo1aFhWY1VmOFJ3ZW1US3JRTWcyQ1FhN0o4cjZJZVgzQXFk?=
 =?utf-8?B?VzB6WUVUQkp3REtXVEFNc3RFUkV0QmJ5SWR2cGdmOTB3YXk2UER2dEhHakVp?=
 =?utf-8?B?dGZaSGZucGxJdmI5QnBqV1BYVXBqY3c4ZE1hTThkM1JLN200cFdXL095bE5E?=
 =?utf-8?B?ZDRDRCsyV0taS25MYkRkcTRFT0V2ZVN4K0F1RGRFRFMwK3ZrbXN5R2VacytI?=
 =?utf-8?B?SGlESU1ZVWR1V3FNSXE2eXJZSmZBczNJY21ZT1FQOFNsVHY2ZlRLZE9pNjhZ?=
 =?utf-8?B?NDNQdExUR3BBNHQwWWpBOVBES3YzRDIxVTF3aGpjdTUvWmVPNzVKWW9QVHA1?=
 =?utf-8?B?ZE1XVU15NDhLWDRjenVhT3pZaWZ1b1htRGhUclZURTNIZFBQTHZpRkl1cWNs?=
 =?utf-8?B?ZE50eHdLOUQ3ZXFzRk1QYmtYNVBwWWEyK3FGbWN0YWhZZ01mZG9rYVdJWC9Y?=
 =?utf-8?B?K3JOcE01QkR3Y1dBbEMyVmtBbmRvckdQL3NqSTNYMTU3YzBxQkE1ay9GMHVC?=
 =?utf-8?B?L0g4YzNYa1VDYkNKNlpqeDNsZkhUTkZOdUQraTJCc0lKeTVoU3dDQzhBUEFa?=
 =?utf-8?B?NGZVd3RBNXpyT2JiQUs3dXQ2MnJxTXZSNGxpOTI2WmxQTmN5MHlWb1B5cTRS?=
 =?utf-8?B?TmtHQi9GMGZJYytWajl3SERKMnIrQVBKN2ZaZ3JOKzZwUjFMMDd6cXRDb2pY?=
 =?utf-8?B?SFFrdy9qb2J0cFRqNkJrRlV3ckRhUHFyN2lpUitwdGhmWlZ0eTNYdFgvZGUz?=
 =?utf-8?B?OTRiaXNOTlR3T05kYW8wdTZCRHM1dmI3VnppVFgwdEs2ZGRiU2xRMk5UM1Bo?=
 =?utf-8?B?NHFTWnJHSWlSQ1llVlJwZ2t1QXRXOC80OEdKSDZQNDRqZ3UraGVESHN2SUNS?=
 =?utf-8?B?UVBjbE5TYWxjWlFPK3k1UTlmdzhHZXcyMkU1NG1tOUxzSnZLV0s4bzBQMytG?=
 =?utf-8?B?aHY3c1dwZkF5SG1XSmhPbWZHN2xCNSs0NUNvR1VzN2RWWTlsUEtmNW8vS0M5?=
 =?utf-8?B?ajE3VCtMblBkbW5ndHZmU2ZMMmNZeXV1L09PTTNITE1Sd0hJNTZVRnpsU0V5?=
 =?utf-8?B?VjBjLzluSzFsV3UrRnhtU1RxSDJWTi92ZGo4YkozbWtEUi9RdEFHVFF0Rm5E?=
 =?utf-8?B?NGx5RXlwclpZTjRmWE5FdVlJL1pIMWt5RWI1R3NuOTVPclpCanp3L3hDVlVM?=
 =?utf-8?B?QlNsUGo5QUJpY0pqUHAvdHdySVRwczRGOE1xd2FCQk8yTk1XaGVyOXZIZTEw?=
 =?utf-8?B?S0c5bm1EMzA4SzE1TzdkLzM1d1BXUFJhSmlrUWlabUxWN0FoMm5UM1Foak1z?=
 =?utf-8?B?WlBpM014dU9VS1VIanFtcE5YcE85ZXRQalU2V3FhajJTejJhSFlwWWVpZkE4?=
 =?utf-8?Q?GJp5RUthWEawsHB1EhQA1S0EyMHP5sRyqwmUsQj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54e88a5-435e-4673-024e-08d97797aea6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:52:40.7704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nqn90IRT2nOV2kT6mUcM7eA2O0BvRNaqgGC6fy0wOWcbqh59l7ezI5A7xZUvRLXZA9zzlEFkZzApdluqmxfUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
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

Tested on nixeus 4k144hz DSC capable display on

RX5700XT (NAVI10 0x1002:0x731F 0x1DA2:0xE410 0xC1)

on ubuntu 20.04. Display lightsup at 4k144hz with DSC engine on.

Tested-by: Anson Jacob <Anson.Jacob@amd.com>

On 2021-09-07 10:32 a.m., Qingqing Zhuo wrote:
> As part of the FPU isolation work documented in
> https://patchwork.freedesktop.org/series/93042/, isolate
> code that uses FPU in DSC to DML, where all FPU code
> should locate.
>
> This change does not refactor any fuctions but move code
> around.
>
> Cc: Anson Jacob <Anson.Jacob@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
>   .../amd/display/dc/{ => dml}/dsc/qp_tables.h  |   0
>   .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 287 ++++++++++++++++++
>   .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  89 ++++++
>   drivers/gpu/drm/amd/display/dc/dsc/Makefile   |   8 -
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 257 ----------------
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  50 +--
>   .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   1 -
>   8 files changed, 380 insertions(+), 315 deletions(-)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/dsc/qp_tables.h (100%)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 56055df2e8d2..9009b92490f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
> @@ -84,6 +85,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcfla
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
>   endif
>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
> @@ -99,6 +101,7 @@ DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
>   DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
>   DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
>   DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
> +DML += dsc/rc_calc_fpu.o
>   endif
>   
>   AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h
> rename to drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> new file mode 100644
> index 000000000000..0436fc64948f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -0,0 +1,287 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "rc_calc_fpu.h"
> +
> +#include "qp_tables.h"
> +#include "amdgpu_dm/dc_fpu.h"
> +
> +#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
> +
> +#define MODE_SELECT(val444, val422, val420) \
> +	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
> +
> +
> +#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
> +	table = qp_table_##mode##_##bpc##bpc_##max; \
> +	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
> +	break
> +
> +static int median3(int a, int b, int c)
> +{
> +	if (a > b)
> +		swap(a, b);
> +	if (b > c)
> +		swap(b, c);
> +	if (a > b)
> +		swap(b, c);
> +
> +	return b;
> +}
> +
> +static double dsc_roundf(double num)
> +{
> +	if (num < 0.0)
> +		num = num - 0.5;
> +	else
> +		num = num + 0.5;
> +
> +	return (int)(num);
> +}
> +
> +static double dsc_ceil(double num)
> +{
> +	double retval = (int)num;
> +
> +	if (retval != num && num > 0)
> +		retval = num + 1;
> +
> +	return (int)retval;
> +}
> +
> +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
> +		       enum max_min max_min, float bpp)
> +{
> +	int mode = MODE_SELECT(444, 422, 420);
> +	int sel = table_hash(mode, bpc, max_min);
> +	int table_size = 0;
> +	int index;
> +	const struct qp_entry *table = 0L;
> +
> +	// alias enum
> +	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> +	switch (sel) {
> +		TABLE_CASE(444,  8, max);
> +		TABLE_CASE(444,  8, min);
> +		TABLE_CASE(444, 10, max);
> +		TABLE_CASE(444, 10, min);
> +		TABLE_CASE(444, 12, max);
> +		TABLE_CASE(444, 12, min);
> +		TABLE_CASE(422,  8, max);
> +		TABLE_CASE(422,  8, min);
> +		TABLE_CASE(422, 10, max);
> +		TABLE_CASE(422, 10, min);
> +		TABLE_CASE(422, 12, max);
> +		TABLE_CASE(422, 12, min);
> +		TABLE_CASE(420,  8, max);
> +		TABLE_CASE(420,  8, min);
> +		TABLE_CASE(420, 10, max);
> +		TABLE_CASE(420, 10, min);
> +		TABLE_CASE(420, 12, max);
> +		TABLE_CASE(420, 12, min);
> +	}
> +
> +	if (table == 0)
> +		return;
> +
> +	index = (bpp - table[0].bpp) * 2;
> +
> +	/* requested size is bigger than the table */
> +	if (index >= table_size) {
> +		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
> +		return;
> +	}
> +
> +	memcpy(qps, table[index].qps, sizeof(qp_set));
> +}
> +
> +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> +{
> +	int   *p = ofs;
> +
> +	if (mode == CM_444 || mode == CM_RGB) {
> +		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	} else if (mode == CM_422) {
> +		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> +		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> +		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	} else {
> +		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> +		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> +		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	}
> +}
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +			       enum bits_per_comp bpc, u16 drm_bpp,
> +			       bool is_navite_422_or_420,
> +			       int slice_width, int slice_height,
> +			       int minor_version)
> +{
> +	float bpp;
> +	float bpp_group;
> +	float initial_xmit_delay_factor;
> +	int padding_pixels;
> +	int i;
> +
> +	dc_assert_fp_enabled();
> +
> +	bpp = ((float)drm_bpp / 16.0);
> +	/* in native_422 or native_420 modes, the bits_per_pixel is double the
> +	 * target bpp (the latter is what calc_rc_params expects)
> +	 */
> +	if (is_navite_422_or_420)
> +		bpp /= 2.0;
> +
> +	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +
> +	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> +
> +	switch (cm) {
> +	case CM_420:
> +		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
> +		break;
> +	case CM_422:
> +		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = 0;
> +		break;
> +	case CM_444:
> +	case CM_RGB:
> +		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = 0;
> +		break;
> +	}
> +
> +	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
> +	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
> +
> +	if (cm == CM_422 || cm == CM_420)
> +		slice_width /= 2;
> +
> +	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> +	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
> +		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
> +			rc->initial_xmit_delay++;
> +	}
> +
> +	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->flatness_det_thresh = 2 << (bpc - 8);
> +
> +	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> +	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> +	if (cm == CM_444 && minor_version == 1) {
> +		for (i = 0; i < QP_SET_SIZE; ++i) {
> +			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
> +			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
> +		}
> +	}
> +	get_ofs_set(rc->ofs, cm, bpp);
> +
> +	/* fixed parameters */
> +	rc->rc_model_size    = 8192;
> +	rc->rc_edge_factor   = 6;
> +	rc->rc_tgt_offset_hi = 3;
> +	rc->rc_tgt_offset_lo = 3;
> +
> +	rc->rc_buf_thresh[0] = 896;
> +	rc->rc_buf_thresh[1] = 1792;
> +	rc->rc_buf_thresh[2] = 2688;
> +	rc->rc_buf_thresh[3] = 3584;
> +	rc->rc_buf_thresh[4] = 4480;
> +	rc->rc_buf_thresh[5] = 5376;
> +	rc->rc_buf_thresh[6] = 6272;
> +	rc->rc_buf_thresh[7] = 6720;
> +	rc->rc_buf_thresh[8] = 7168;
> +	rc->rc_buf_thresh[9] = 7616;
> +	rc->rc_buf_thresh[10] = 7744;
> +	rc->rc_buf_thresh[11] = 7872;
> +	rc->rc_buf_thresh[12] = 8000;
> +	rc->rc_buf_thresh[13] = 8064;
> +}
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +				    bool is_navite_422_or_420)
> +{
> +	float bpp;
> +	u32 bytes_per_pixel;
> +	double d_bytes_per_pixel;
> +
> +	dc_assert_fp_enabled();
> +
> +	bpp = ((float)drm_bpp / 16.0);
> +	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
> +	// TODO: Make sure the formula for calculating this is precise (ceiling
> +	// vs. floor, and at what point they should be applied)
> +	if (is_navite_422_or_420)
> +		d_bytes_per_pixel /= 2;
> +
> +	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> +
> +	return bytes_per_pixel;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> new file mode 100644
> index 000000000000..d3900ff7fa89
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __RC_CALC_FPU_H__
> +#define __RC_CALC_FPU_H__
> +
> +#include "os_types.h"
> +
> +#define QP_SET_SIZE 15
> +
> +typedef int qp_set[QP_SET_SIZE];
> +
> +struct rc_params {
> +	int      rc_quant_incr_limit0;
> +	int      rc_quant_incr_limit1;
> +	int      initial_fullness_offset;
> +	int      initial_xmit_delay;
> +	int      first_line_bpg_offset;
> +	int      second_line_bpg_offset;
> +	int      flatness_min_qp;
> +	int      flatness_max_qp;
> +	int      flatness_det_thresh;
> +	qp_set   qp_min;
> +	qp_set   qp_max;
> +	qp_set   ofs;
> +	int      rc_model_size;
> +	int      rc_edge_factor;
> +	int      rc_tgt_offset_hi;
> +	int      rc_tgt_offset_lo;
> +	int      rc_buf_thresh[QP_SET_SIZE - 1];
> +};
> +
> +enum colour_mode {
> +	CM_RGB,   /* 444 RGB */
> +	CM_444,   /* 444 YUV or simple 422 */
> +	CM_422,   /* native 422 */
> +	CM_420    /* native 420 */
> +};
> +
> +enum bits_per_comp {
> +	BPC_8  =  8,
> +	BPC_10 = 10,
> +	BPC_12 = 12
> +};
> +
> +enum max_min {
> +	DAL_MM_MIN = 0,
> +	DAL_MM_MAX = 1
> +};
> +
> +struct qp_entry {
> +	float         bpp;
> +	const qp_set  qps;
> +};
> +
> +typedef struct qp_entry qp_table[];
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +				    bool is_navite_422_or_420);
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +			       enum bits_per_comp bpc, u16 drm_bpp,
> +			       bool is_navite_422_or_420,
> +			       int slice_width, int slice_height,
> +			       int minor_version);
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index 8d31eb75c6a6..8d01b8a9fc6a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -2,14 +2,6 @@
>   #
>   # Makefile for the 'dsc' sub-component of DAL.
>   
> -ifdef CONFIG_X86
> -dsc_ccflags := -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dsc_ccflags := -mhard-float -maltivec
> -endif
> -
>   ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> index 7b294f637881..87acec33b8d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> @@ -25,264 +25,7 @@
>    */
>   #include <drm/drm_dsc.h>
>   
> -#include "os_types.h"
>   #include "rc_calc.h"
> -#include "qp_tables.h"
> -
> -#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
> -
> -#define MODE_SELECT(val444, val422, val420) \
> -	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
> -
> -
> -#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
> -	table = qp_table_##mode##_##bpc##bpc_##max; \
> -	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
> -	break
> -
> -
> -static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
> -		       enum max_min max_min, float bpp)
> -{
> -	int mode = MODE_SELECT(444, 422, 420);
> -	int sel = table_hash(mode, bpc, max_min);
> -	int table_size = 0;
> -	int index;
> -	const struct qp_entry *table = 0L;
> -
> -	// alias enum
> -	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> -	switch (sel) {
> -		TABLE_CASE(444,  8, max);
> -		TABLE_CASE(444,  8, min);
> -		TABLE_CASE(444, 10, max);
> -		TABLE_CASE(444, 10, min);
> -		TABLE_CASE(444, 12, max);
> -		TABLE_CASE(444, 12, min);
> -		TABLE_CASE(422,  8, max);
> -		TABLE_CASE(422,  8, min);
> -		TABLE_CASE(422, 10, max);
> -		TABLE_CASE(422, 10, min);
> -		TABLE_CASE(422, 12, max);
> -		TABLE_CASE(422, 12, min);
> -		TABLE_CASE(420,  8, max);
> -		TABLE_CASE(420,  8, min);
> -		TABLE_CASE(420, 10, max);
> -		TABLE_CASE(420, 10, min);
> -		TABLE_CASE(420, 12, max);
> -		TABLE_CASE(420, 12, min);
> -	}
> -
> -	if (table == 0)
> -		return;
> -
> -	index = (bpp - table[0].bpp) * 2;
> -
> -	/* requested size is bigger than the table */
> -	if (index >= table_size) {
> -		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
> -		return;
> -	}
> -
> -	memcpy(qps, table[index].qps, sizeof(qp_set));
> -}
> -
> -static double dsc_roundf(double num)
> -{
> -	if (num < 0.0)
> -		num = num - 0.5;
> -	else
> -		num = num + 0.5;
> -
> -	return (int)(num);
> -}
> -
> -static double dsc_ceil(double num)
> -{
> -	double retval = (int)num;
> -
> -	if (retval != num && num > 0)
> -		retval = num + 1;
> -
> -	return (int)retval;
> -}
> -
> -static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> -{
> -	int   *p = ofs;
> -
> -	if (mode == CM_444 || mode == CM_RGB) {
> -		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	} else if (mode == CM_422) {
> -		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> -		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> -		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	} else {
> -		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> -		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> -		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	}
> -}
> -
> -static int median3(int a, int b, int c)
> -{
> -	if (a > b)
> -		swap(a, b);
> -	if (b > c)
> -		swap(b, c);
> -	if (a > b)
> -		swap(b, c);
> -
> -	return b;
> -}
> -
> -static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> -			       enum bits_per_comp bpc, u16 drm_bpp,
> -			       bool is_navite_422_or_420,
> -			       int slice_width, int slice_height,
> -			       int minor_version)
> -{
> -	float bpp;
> -	float bpp_group;
> -	float initial_xmit_delay_factor;
> -	int padding_pixels;
> -	int i;
> -
> -	bpp = ((float)drm_bpp / 16.0);
> -	/* in native_422 or native_420 modes, the bits_per_pixel is double the
> -	 * target bpp (the latter is what calc_rc_params expects)
> -	 */
> -	if (is_navite_422_or_420)
> -		bpp /= 2.0;
> -
> -	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -
> -	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> -
> -	switch (cm) {
> -	case CM_420:
> -		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
> -		break;
> -	case CM_422:
> -		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = 0;
> -		break;
> -	case CM_444:
> -	case CM_RGB:
> -		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = 0;
> -		break;
> -	}
> -
> -	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
> -	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
> -
> -	if (cm == CM_422 || cm == CM_420)
> -		slice_width /= 2;
> -
> -	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> -	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
> -		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
> -			rc->initial_xmit_delay++;
> -	}
> -
> -	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->flatness_det_thresh = 2 << (bpc - 8);
> -
> -	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> -	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> -	if (cm == CM_444 && minor_version == 1) {
> -		for (i = 0; i < QP_SET_SIZE; ++i) {
> -			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
> -			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
> -		}
> -	}
> -	get_ofs_set(rc->ofs, cm, bpp);
> -
> -	/* fixed parameters */
> -	rc->rc_model_size    = 8192;
> -	rc->rc_edge_factor   = 6;
> -	rc->rc_tgt_offset_hi = 3;
> -	rc->rc_tgt_offset_lo = 3;
> -
> -	rc->rc_buf_thresh[0] = 896;
> -	rc->rc_buf_thresh[1] = 1792;
> -	rc->rc_buf_thresh[2] = 2688;
> -	rc->rc_buf_thresh[3] = 3584;
> -	rc->rc_buf_thresh[4] = 4480;
> -	rc->rc_buf_thresh[5] = 5376;
> -	rc->rc_buf_thresh[6] = 6272;
> -	rc->rc_buf_thresh[7] = 6720;
> -	rc->rc_buf_thresh[8] = 7168;
> -	rc->rc_buf_thresh[9] = 7616;
> -	rc->rc_buf_thresh[10] = 7744;
> -	rc->rc_buf_thresh[11] = 7872;
> -	rc->rc_buf_thresh[12] = 8000;
> -	rc->rc_buf_thresh[13] = 8064;
> -}
> -
> -static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> -				    bool is_navite_422_or_420)
> -{
> -	float bpp;
> -	u32 bytes_per_pixel;
> -	double d_bytes_per_pixel;
> -
> -	bpp = ((float)drm_bpp / 16.0);
> -	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
> -	// TODO: Make sure the formula for calculating this is precise (ceiling
> -	// vs. floor, and at what point they should be applied)
> -	if (is_navite_422_or_420)
> -		d_bytes_per_pixel /= 2;
> -
> -	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> -
> -	return bytes_per_pixel;
> -}
>   
>   /**
>    * calc_rc_params - reads the user's cmdline mode
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> index 262f06afcbf9..c2340e001b57 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> @@ -27,55 +27,7 @@
>   #ifndef __RC_CALC_H__
>   #define __RC_CALC_H__
>   
> -
> -#define QP_SET_SIZE 15
> -
> -typedef int qp_set[QP_SET_SIZE];
> -
> -struct rc_params {
> -	int      rc_quant_incr_limit0;
> -	int      rc_quant_incr_limit1;
> -	int      initial_fullness_offset;
> -	int      initial_xmit_delay;
> -	int      first_line_bpg_offset;
> -	int      second_line_bpg_offset;
> -	int      flatness_min_qp;
> -	int      flatness_max_qp;
> -	int      flatness_det_thresh;
> -	qp_set   qp_min;
> -	qp_set   qp_max;
> -	qp_set   ofs;
> -	int      rc_model_size;
> -	int      rc_edge_factor;
> -	int      rc_tgt_offset_hi;
> -	int      rc_tgt_offset_lo;
> -	int      rc_buf_thresh[QP_SET_SIZE - 1];
> -};
> -
> -enum colour_mode {
> -	CM_RGB,   /* 444 RGB */
> -	CM_444,   /* 444 YUV or simple 422 */
> -	CM_422,   /* native 422 */
> -	CM_420    /* native 420 */
> -};
> -
> -enum bits_per_comp {
> -	BPC_8  =  8,
> -	BPC_10 = 10,
> -	BPC_12 = 12
> -};
> -
> -enum max_min {
> -	DAL_MM_MIN = 0,
> -	DAL_MM_MAX = 1
> -};
> -
> -struct qp_entry {
> -	float         bpp;
> -	const qp_set  qps;
> -};
> -
> -typedef struct qp_entry qp_table[];
> +#include "dml/dsc/rc_calc_fpu.h"
>   
>   void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps);
>   u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> index ef830aded5b1..1e19dd674e5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> @@ -22,7 +22,6 @@
>    * Authors: AMD
>    *
>    */
> -#include "os_types.h"
>   #include <drm/drm_dsc.h>
>   #include "dscc_types.h"
>   #include "rc_calc.h"
