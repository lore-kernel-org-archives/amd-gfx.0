Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F5EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 16:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C3310E44A;
	Tue,  4 Jan 2022 16:02:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1288F10E488
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 16:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhOhThq+kdeU9/5AznltmiE+HZtrshKwBfimG1t4FE+xUEndreBsrCcw7I1B5zaw37otjAoG0oGoJEnn8/ERI8FGPoP38E7MKE8NtAZQgMN1V6z0aqwD9scFXnu4t8Sbzvq8oD0Ki35S48Uo6zewTdbGb/qWG4NUi8H75MzpJdM388Pzb5XbLJXR3HXC2cgSdhKjEGcA/+5QTxdbrn6nAXhxrlhzc/krg7ph/3yuvDl7gfEgN0Wnpwt5xmjIZ/X4Ak3uQpiFPoFmXZjC9rvhJ0F1p4qfxLSlvpC6Nsaw+C3HHvcU3DmkGdLygFgu2B3an7/pHyLtdsNQ6Yi26/AnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWBbc2NEOmAMXOYyxZ8nu/uckVfKsUvIbRY4MCnseOE=;
 b=AJ4W2o9oQd+SePJhLbZfxqN/1ENNDCMi5LQugzSFPet+BTRGu9DWBOaHDCvcetrkAg0Z2I6wqEjUXX/5N9hssjvrMnL3zYOzkNXz5jdK+oGjxIBy4u2U5DekCSDJWuKmUrZ05iso2q1HCgIVxs9AqVgxzY1wQfO2iaINXqGlOGtgdRwF0aRNA8cOX5CyH4tCLLcMSM9JN6dek9CoVyCbDgTuhptLa4JEdsymiWFjOHin8YKJtM4AOEmq5AAy7CNxkuiXGITfqccjBegBzYxtcD9KDCIXTgMgjyYfoTsGnYaYg+xCM0yWSDO3cgWS5CGAc3ynkDSF3AeesJ7DnYxcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWBbc2NEOmAMXOYyxZ8nu/uckVfKsUvIbRY4MCnseOE=;
 b=J873DT0AOCg5+GHc+oscSKiqYl+ypUXxqeWbKnplrTsw7g2qnvjWWysw8nYM1NgZ+AvYAuiuOPTx3w76YRmVRAbY91RNN1uwV1h8rhcVEPKPanNbwBlhXylAwoHupo/pkWD+d6e/U1h5R5++GtEyZh8vzJEKsaeaOz3/nNtY5tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 16:02:51 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 16:02:51 +0000
Message-ID: <87ecea48-3f47-3525-0b8c-2e4bd76bb473@amd.com>
Date: Tue, 4 Jan 2022 11:02:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amd/display: explicitly update clocks when DC is set
 to D3
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220104153326.19408-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220104153326.19408-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0318.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 941c9475-6a3b-4eb9-4e64-08d9cf9ba8b4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB542767391179D243F7A1FBBF8C4A9@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXuF1j0gZ1OR7S6NVTHT16f1R0RHgqp3Wy0y6GeCwA8pheew90IxxupcQOnOz7dDL5OYcg4iaN6TmQW1ToaCvYWQqQSITlq6WjdDcIzTytl0m2rZURJYtylllBM4xE4KefkLWX7V4XvKyn2TFGJXZUSXKzUcseOfZmuZ+GNxC5mfh51B8nzwO1sfz7211j6EwxiQVPOd2ig70CwwCBbOhPlrHb4LCMFC6LtaGMgUV+4yeKDZbvufp/XJr62PnERGrF4611wNAnDjST3x1fQsbl1IgoAx9beJHxvTkCTM4+vvQ6UxlhRQaDM39LXCbmMkTIJal91xHGyLEKVFh17gm3YbbVljVLQXA2J0xnTuVOdztQ+ICUEvP1fESjrq9ozzGXybUdzJjsQiPIjkXoFrPHzdJ1TqbwrSz5JyvSjtnymmZQ0btJ9jj+KtyzPz1T5A6gBTTnF635nymrbBKlJDCVBgELnbeJLHFrgKamDGvgkKZKeA20v3Pfn4ANQ8cgoWXpyv7a0m61CHULi+bVMgru6EjBq3KNAVUXXtU/+OQXIofk1gat072etlSJDr3wqavH4NSabQfIuLlDU9K+43gBXuD9A1hX6bGHbD0/a8ETfo6+c5MB0bUSSLL5RnEANgVRmnEE8lwhR1bPKb7AbocnixSsNDaKDDjZQ1A34ez+qsLNad5jCY11NPPeKA8T8nkailhMA8PKUNWzLg97Cv9g4wbdfour9hz+Mfp+uk/15y046RbHgGT7EJ2YLqRAa6zeE8MGFmjDL1uHpeMJodOlXDhJINvSpzZa8VrAoerwgIhI9P7P112A0Xh0tomLmA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(38100700002)(186003)(8676002)(15650500001)(2906002)(5660300002)(966005)(66476007)(31696002)(6666004)(6512007)(2616005)(83380400001)(36756003)(26005)(86362001)(508600001)(66556008)(31686004)(8936002)(44832011)(53546011)(66946007)(6486002)(316002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JUVWtrcUIzZ3Z1NmhyYnpDczlKcG53eFoxWmw0SWhsdDJhU2VLeTRhcXRN?=
 =?utf-8?B?cHZIL1NmN2JxY1R4c0VaZkMxeVoyaWJEWG5Fb2t2RTVqSlc5cXZyN1hhWjhr?=
 =?utf-8?B?MFlxdUYvYXEvUzZBTXhxUTF6VDdscjFXOWRHZFVzODdVUDNPZzFqdlhJdm5U?=
 =?utf-8?B?bFB4Wmh5cE5xc3JzcDk4TWJoVVQyRzQrd2ZWK1dOYUVxRi9IKzg3Yk5FRjhB?=
 =?utf-8?B?Nm5vcjRCMTAyMlBjTktLQVRUT3MvaEhLNG9kU3RlREp1V3NwV2xkUUl2RFdK?=
 =?utf-8?B?cFhmSVREcktnMTAvUjlTTGZIVTZxZHdreXdGU0s5M2VUWkFCT2ZPa3JaUVRs?=
 =?utf-8?B?VlRxTUh6YThFTTRyalh3QTJVN0hsdXNMSE9hRTlTdHVVc3lya2RUTkpRWFZw?=
 =?utf-8?B?ZW9GQjMyNkVBeXJRWG9RVFIwcnJ6MHNuNmFGVDBhQjZ1V1hqcUxwdElQZWMy?=
 =?utf-8?B?Smo5R0RhRXJKU0FvUTl4UGhpbENlS1dub0NLWGlTVzF2OU9XMXV4eXN3alpm?=
 =?utf-8?B?ekNZNUNmem5tQXFsYW9uWUEwQi9YVmtrN09VM2JCcjUwcU1Zdk9URzkxZDBn?=
 =?utf-8?B?SC9qUXkzQTBRU210QWlFVkRRMDB6bWxYK1N0elFzL2hYWkgvbTR6ZlVYTEpt?=
 =?utf-8?B?aGdQb1dRZHFLZlhtL05NQ25oVWhSamd0dDFFTnQrdkF6RlRIRDllVVBtNE9N?=
 =?utf-8?B?aDJscGluZzg0UVduZzdBN3Q5RWVLdzBIcEU2SUhSUlZKaTFpWkJmM2toa0xr?=
 =?utf-8?B?YmsxUnJKbEk2Tk5CNWp3eU5wb2lvZ1pnb0FxRmRVQVpSTklYOEFUYzdUc2ND?=
 =?utf-8?B?U1JOQnlud2lJbjluQjFta1MxN3Rpd1NnOGEwazNDMkhXMUFPZC8vZ2JQajAr?=
 =?utf-8?B?QVdsU2xhK0QzdFQyaGltRm15VGdoVWgxcE1oZjg5WXRoOHBqczFTTHdQMnJn?=
 =?utf-8?B?clBBUXQwcC9XdCt5Tm9WYzRwK25NWng2b056Q0pkKzcvUG13d2xmVmVSZjh5?=
 =?utf-8?B?UmFYQWVSZnJTR2Z5Y0ZTWHN1QTErUWhFWmRFaUtKRUNCYXlBell3WWZTZFRy?=
 =?utf-8?B?YjRnOE81OFljQVFIZnRtR2ZKNDdXQWJ6cEVuTDVtVGsya1BNNDRSemlWYmpH?=
 =?utf-8?B?M1Z5b1ZjRGN6RXRrc1FLL0NCd2hoUDVDSDE4Vks4MGprUEVObWwreHd6cDhq?=
 =?utf-8?B?Y1JSQmxLSFd2UjNyODNWUG05bWNaOFkraG1JU05RV2VlbEdIYlZKLzVBREgw?=
 =?utf-8?B?SHp3SHNyZmJiM0RBenhFT1JsYWNWalNGZzBBU3dFMWRBc0dxeUEwVVhlKzRZ?=
 =?utf-8?B?Y043S1prTjJKOUtwRmtoWDJzWW5jclJrOTZ6QWUzcFdWakppeHUva1duZDd5?=
 =?utf-8?B?SUUxTlJEQjFKRDQ5VTRRLzFsNXpwOC9Gck9ZVmVPRjhHV2E5eWFIVlZ3bUxG?=
 =?utf-8?B?SjI2eUJuMVFpTjVqbVB0UzFSVnRCaksvN2dEWDRNNkVDOGpPWmhET2FXalhO?=
 =?utf-8?B?RlJsa3lQenE1VkpIclJQZ2xicTVQTlRjNjJOWlIxRmJyNWJkMDFFbzhveFZJ?=
 =?utf-8?B?bWNqRE0veUNtcUZtaUoyd1pkSHhvWDZxdCs4NnRWWFRLZ3ZUZHA0Zk44LzN6?=
 =?utf-8?B?YUVlYk0xSVVNdzR0NDh2MEo5SVordzEwZDZyWmpLMW8xanFNRnJIUFNmL25n?=
 =?utf-8?B?ckdyZlRWbW9pZDZlV0E5aUluYjdXSS9iOVRVU1FzTkFrZlpCRWFETlYzZFhO?=
 =?utf-8?B?SVhhWm1RT01PaVdjRXpUOVNOa2JxK2Z0KzhoNW9zZDRVc2l1WFphSkJ3RFc5?=
 =?utf-8?B?aFRnTXdKSjgzcmNMVVZPQUM1V1NHZmdXejlYdzBEaDR3SGMvWENMQ0ZPQUg0?=
 =?utf-8?B?SWlhODMvSGVnSldibi90VGtqYW1IbG1yQnQrTWxwN0ZGR1ZxUDdGeVQ4VE5a?=
 =?utf-8?B?MXFJVEtEMDZtbFdac0QyUHdWYVZUQkRHNW81Z210eWZrSGRUV0FPU2xqZUhK?=
 =?utf-8?B?WkRoRURMTFpuSUZxRzR6azRlY3h6VGdmdWxDZUxPaVdyRS81VXV2Qm5RaW5I?=
 =?utf-8?B?MlFXY3hqc1BnNitvQzNQZ1g3bEVOcURvV1ViaEdWd2p2NDIvVXB0M2kvbEdo?=
 =?utf-8?B?Z01UNGwydHV1QUorakt0MFZHL1FzSWVwOEIzc0k1MWNITk9CR1l0enc2ZnBF?=
 =?utf-8?Q?+reJD8W3E95NEz5WWrNDjJ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941c9475-6a3b-4eb9-4e64-08d9cf9ba8b4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 16:02:50.9092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsRyy4TR1I+fTojCcffZZdaLWyiw0TblNUWD0Z27LDRoehjTechRlDKNQHmYkwQlHchd1OndctHvkqQMGO//hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-04 10:33, Mario Limonciello wrote:
> The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
> hard hang on HPD") causes a regression in s0ix where the system will
> fail to resume properly.  This may be because an HPD was active the last
> time clocks were updated but clocks didn't get updated again during s0ix.
> 
> So add an extra call to update clocks as part of the suspend routine:
> dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state
> 
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215436
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
> Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 91c4874473d6..6968ad6c5a64 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3299,6 +3299,8 @@ void dc_set_power_state(
>  		}
>  
>  		break;
> +	case DC_ACPI_CM_POWER_STATE_D3:
> +		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);

We probably want a "fallthrough;" statement here.

Harry

>  	default:
>  		ASSERT(dc->current_state->stream_count == 0);
>  		/* Zero out the current context so that on resume we start with
