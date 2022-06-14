Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87F5C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 14:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4548C112366;
	Tue, 14 Jun 2022 14:45:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D29B112388
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 14:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkMHG0GbYDCVPixiXhxixzMk1BWNNjvoBPO/LcZ+0W4gB2WEb/3UknvpKQ33xmNLwxe3wFde7Fpq+rwRhPNfnOTEHT/7OeZN1CQcQFR3dpS0pqd0v2+lhJexAsBXHAUjYNw4JGs4DJrtM+tZP0IvvWgP/92umyzBjoS10Wda1ncP37tMI0MXV4nZ6M6qiis+l8GCHS6KykbCothCbWHpUxwknVaalWhpLmn7S61kvFruwVWvSRYlo1hlg5pT3UAlzq6xjI+uxbct6DAmF8Y8IJD410otpIWjzh+0BLgDOZAlMcHjeWvalxH8GVavfymYTpi0URi8nw1Ylm4+dNBUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HV9zLMUCVJMbVZ5+kKJBR63VQP/0+DZv0xNBqcW2+Y=;
 b=O7u6JE/aXyNq/8/PB9VvdsQSheSpefWIUyAEkY249locZb51OjbUgEOmsXaLbCNaJpDNwc6UrGbY/gh5rGKByblGHakyqLxMpuQpcNw8JCCW3WVBPvcFDI0YmO1LMxDPXHF3zzo8ic3SLkOGu1ayNdIP+fp6YRxeo2NV8royFXixdnf+xM8RGdmC5Fp06HfoiU0SC9+G+a+xP8IeijeggshJJYTKQl+MgYmjcfNu5B/XTaMPamnk5Bz/3U3OZyImzzycIjLhJSg+zcA+85pAoYDb5n9kgfKtGC4VyT4ZKaosC2Q7yb5i2PQw8ntFPX+/8AWNJTEbGiQJoYH0KgGpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HV9zLMUCVJMbVZ5+kKJBR63VQP/0+DZv0xNBqcW2+Y=;
 b=X/6r1An18hIB4MmSR+ejOjQRBcnQ9PnmVUXpPk4YQTMEPzS4NOdxnwN+FwSsXah/JyGIaafX4Bl06E3/tAmbVyTHLst5YSiFptiuWvLPjJLAhdmWeEs8UJzUyotqIGUb6SW+DM4xGeRc26kN9DF/96TJstmiB7R1ml+nJ1FL+0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB1481.namprd12.prod.outlook.com (2603:10b6:4:e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Tue, 14 Jun 2022 14:45:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 14:45:54 +0000
Message-ID: <e7b3288e-296f-898e-76e1-f36c2cd0baa3@amd.com>
Date: Tue, 14 Jun 2022 10:45:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] drm/amdgpu/display: make FP handling in Makefiles
 consistent
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220614140524.2677317-1-alexander.deucher@amd.com>
 <20220614140524.2677317-3-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220614140524.2677317-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64489ed2-873c-4510-caad-08da4e149586
X-MS-TrafficTypeDiagnostic: DM5PR12MB1481:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB148192B21DAFE3B6F266DDFB8CAA9@DM5PR12MB1481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GndXSQR6kPfeAMNoBrBOD5nDKGvZPclMw0FAMUnqgse6p+tYECiCeBKgOKRk15cly0kf3fnnL3AGQceZZeCUFjRqnxKES08Zl1lAZ+0Umx+Wk+2yEZIVivoGphp8ybNW/4uJp/+83xocc4Q3U6UR06PVV+jkyVHtToueWET3AkyqU3blnbx8sv09zKPU7dLKQQBbQhiiUl5SXUX7Fo5XD6vbSK5xO554w3GKLMPY78kSKBJPzAPKuH7l87I5y57WZqj0HDUBv2R/lKBEQJ6hFnUrzmrqYyQwxfBLkaIi8TF1VKn/5nMBYJyLIi+pJEZdYyzcZ9q1aCIn5HTYvSiBMbPB/69zsuFssvCMRstpslqchwhECN3MCVCYfWwrRkPGiDJngCV6dciCY/0Jl1OCSeIksj9oTB8opqZBmGfQPFMVzK1Vcc+ySkvvacbZMKiZy4LQr8aK6zs3iyC6dKHeHfiy/GTrFfIFb7nFg5DQ1xlMn1R5Z87+P+N+IQLQ4IoZDshPduw7mliQQQUVcI5kQ9XZl2TBK2OYI1o0z0x8cEcXxFcnBcOS8L83aPkrAk8uL9hnXzDxzdw4P7QbAF66WKQnqhexIAuXC8iD/zH53N1Mgo1LrRn3O34Z0chPoT+VpcaBFo2MoPX2gHwhovqYYmLDWJLlfXnHdMCDOGQsC09j54T2jxbJJrPkh6YfDypaqO3/hNStaeeOQVUYJ+hcDm7O3I7qEOtt0I+P6qAhf7mHESoD2ju1PSjZnjGG3Dh4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(508600001)(44832011)(6666004)(6486002)(5660300002)(8936002)(2906002)(316002)(66946007)(66556008)(66476007)(8676002)(31686004)(31696002)(86362001)(36756003)(38100700002)(186003)(2616005)(53546011)(26005)(6512007)(6506007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnpQcEhKVnNOT25sOE9VcHVZU3JIbXMwcTVMNU8yQ2RnRWNOQ3BURUhTZFRo?=
 =?utf-8?B?NThSRHF0NFByTXI1MU02S0pac1dCc2VRTUNaZDdDQkI4RityZFVkWk5xOW5j?=
 =?utf-8?B?RjRDOGdBS0RUZXBjbnp1RHNobzAwZ01CRzNDdXphVEV2MFYzR1B5citlYXpF?=
 =?utf-8?B?em0yR1hXdlNNUzd1RzJ4dzQ3blRLT3luUFJxc3Y2Mjh3cFd5K1NmVDE5Y3Yx?=
 =?utf-8?B?bThRVFdKYVZaWDVYbSsyWEVJcDRnWTUrY0ZsWkpNMjRaMitUeGN5S2FNZUJL?=
 =?utf-8?B?Q0VlMThhQ1lXZWRKWDBvY2ZFK0dBMWlqbzNyeEtnb1VYQ1FaNHpsVGtEajN6?=
 =?utf-8?B?bHY2ZEZJOE5Dc3kzeTlySFhyS2lsV0IvNVJCRFh5eEFBbWw4S003cGZ2Q3Ns?=
 =?utf-8?B?czZ3RjhpWE5QM3pZNHVWU0htYW8ybkNhTkw3YTlVK3ZjK1hrSjNVOWVMeVZ3?=
 =?utf-8?B?Uyt6ZCsvcjA1MU05YnZiQ1dXNzZuS3N2WHdUU21BS2lOMGthY3RLdHNzV2FM?=
 =?utf-8?B?dCtGZEl2bDAzOHFuZFBBYkR3Q1hSUndhSEJBQThoYnl3WGpFeEtKMnJmSEZl?=
 =?utf-8?B?Ui9WbXQxdmI2SmpZYVZKOXRBa1BHcnZmWmxsSFFsZFpKekdmSmVXazVOeXo0?=
 =?utf-8?B?aFpkMzYzYmptb1JQeWV1bi9jcm9xekxDTXNTeXhQdUwyNmsxMXU4YUQyY2U5?=
 =?utf-8?B?MkxFOCtzU0kzUytscUN3RlpORzlyQmRtNGtENElIU1hGTWxYb3Nna3pIQUZC?=
 =?utf-8?B?TlBOWmozM1krRmpWUjZMU2RIajZlSlpBcEkyUXdZQWhDOGdaS1p2a0ExQ0RY?=
 =?utf-8?B?Z1Y5a0pLdG5ULzc2R3UzeENySXhyb3lmdTF2SHRBTWg0bTd5c1pJWk1HcWJK?=
 =?utf-8?B?MzdnRHQ0dmEwblpLVVFPeG1zT3NiaEhSdTRHSVlrRkhOQTBlMGtyKzJSKytt?=
 =?utf-8?B?VElwQys0NGEvUEVOT1V1SHhNVG52SGtYaU92VjRBUmgyQWVLMkk4SXdMYkVW?=
 =?utf-8?B?T2RtSjJSbUZvekcxdlBjNEU5K3lrWXFpb3dmRWtGOVhvRVVTQ0pTcVg3WmhI?=
 =?utf-8?B?RlRLNUxtdmwyOVpLNHlCVXRHbDNWU2FKS1lHR3J3c2lkSEluUkczZXRNNEt3?=
 =?utf-8?B?TEplcnp4SktZd0VhNmNkcjdXZTJFUjQrK2ZJSG9LdzJGaXF3RE1nWjFZMkI4?=
 =?utf-8?B?UnFteHM3Z1hkenc0c1ZNVlpSejN0WWI1QUkzRW9Md0VoRHRMNG9zY1VGYWlu?=
 =?utf-8?B?eFUxZ3pJTnQ4L3k3RTV2MlNkd3dObHhVWlZ3QjFISUlVYnhMRHREMklqNHdY?=
 =?utf-8?B?K3FYZjFYWkRQaHl1YjdSQlV5a2tTZFlYRFhXMjRNSFZULzFUSzZKdm0xYS9Z?=
 =?utf-8?B?Y1g2MkYyZWdSUXVuZVViZDBHU0JIYzIzWnhtMnM5cmJvZ1psbVk0OWhtaU41?=
 =?utf-8?B?clR5ako4WldKNlFFZ2gybVB2ZWoyYkJvK2dLekFHcjF3R28xbkw3L3lTRGRU?=
 =?utf-8?B?Z0VVaVdoSnpmN2JqamRETGFvRjExSDRLNkZ1TEcyeXBXcjJ0dlA5T0hDWnpu?=
 =?utf-8?B?ekQ5WEFqcGFTUUladG9EQThiaHhsZWlKWHczV3ZJeklXOC9LMzZDVlNoLzNU?=
 =?utf-8?B?OFBaS29KVmdVRWI3NDhyNi94d2hoSnJlSExKbXR1RGVSa052SE1JRmVLWjNC?=
 =?utf-8?B?Z3JwRFZMbmVubGNYdWs2VjMyemd1K082aDFKZys1L1h3c3F1eEFCMks2TzZ4?=
 =?utf-8?B?d2VrYi9EVzZoMGxMeHo3dEdrb1VrZXltaUpnN294V1N4QnM2Ym96NDY3UlZy?=
 =?utf-8?B?T242aW1qd3RFdUdoS3JjcHl3WHYyb0p4S0tLTFhZRytsdVcxNjhjeFdhbjQr?=
 =?utf-8?B?UzNOYU85bHlRUEV2bit3aE1nNjlCWWtuY3FvMEllZmQ5K0ZJQ2FVbGxBSUti?=
 =?utf-8?B?Skl3bHpDTTUrbDYxQkx1bHQvUno3WmU4ZzB0NTgzbVFlUVZNdFRyMVdIVTNj?=
 =?utf-8?B?ZXVIeEdYZHZxcmlwaDRoa1M3YkpjRXNqekcvMStaREcvQ2pHMXdYcG9UeExQ?=
 =?utf-8?B?Zzh0NitBMHMxTXZsdkwzai9sdk9wUHpTdEMxb0NHZW11N2FmZzNyT04zTDQ0?=
 =?utf-8?B?OG1FMkovZ1dsNU9IRzVmaHNnRXQrc2xPUS9mYTl4VTZSaExvREN1L3BGOEJN?=
 =?utf-8?B?Q1NGZXBiVmJuaXNSTlhpQW1wUzZhSGc1cldlMncxY0FoaTNaQXZZTFN6VmRX?=
 =?utf-8?B?MTFoc3pKTDNTa2s3c2NvclJxY3NSWlRlM29rU2FPRk5Ua0Y0OWVoYzJPYU1j?=
 =?utf-8?B?SHRJTGE3YzdLQjE3dm9GOGR3cm9BcVpPejEwdUkxdUZ3RXcvdm9RQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64489ed2-873c-4510-caad-08da4e149586
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:45:54.3016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuuRehA88gg8XCrvvFt7Xes1+enlLbDXKD5HEUx9nIxgR9HQ/1a/SCQSKotnPoP1xlY/LYv0jiigWM9m5jShwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1481
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

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2022-06-14 10:05, Alex Deucher wrote:
> Use the same pattern as the DML Makefile and while we are here
> add a missing x86 guard around the msse flags for DCN3.2.x.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
>  drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
>  drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
>  drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
>  drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
>  drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
>  6 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index c935c10b5f4f..7b505e1e9308 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -180,7 +180,7 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
>  AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
>  
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> @@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float
>  endif
>  
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> index f68038ceb1b1..96cbd4ccd344 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
>  endif
>  
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index dfd77b3cc84d..c20331eb62e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>  
>  
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> @@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
>  endif
>  
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> index f9561d7f97a1..e4b69ad0dde5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> @@ -8,7 +8,7 @@
>  DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
>  
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> @@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
>  endif
>  
>  ifdef CONFIG_X86
> +ifdef CONFIG_CC_IS_GCC
> +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +IS_OLD_GCC = 1
> +endif
> +endif
> +
>  ifdef IS_OLD_GCC
>  # Stack alignment mismatch, proceed with caution.
>  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> index 3d09db3070f4..34f2e37b6704 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> @@ -16,7 +16,7 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
>  		dcn32_mpc.o
>  
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> @@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
>  endif
>  
> +ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
>  # Stack alignment mismatch, proceed with caution.
>  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> @@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mpreferred-stack-boundary=4
>  else
>  CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -msse2
>  endif
> +endif
>  
>  AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> index 5896ca303e39..e554fd6c16f2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> @@ -13,7 +13,7 @@
>  DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
>  
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> @@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
>  endif
>  
> +ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
>  # Stack alignment mismatch, proceed with caution.
>  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> @@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
>  else
>  CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
>  endif
> +endif
>  
>  AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
>  

