Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A425AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 15:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F24110E041;
	Thu, 31 Mar 2022 15:42:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3376610E041
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 15:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWA2R9nXg7qNTaXdPnqFkLHe6OV+5Axprz9OSn0KtmLfjC1itJvij/uodjkgDUtJXg7o3Bkh3shg/BXuRVA8GdN+qAzRBzd3kx1NsiGcANYxKkg5/VSgptH/+xZ6Xevex+8XG6L6beCOwZh4i/HgPgcnvSdXWJlbYPweTXwFlU/qXsude26zURN2jhhlCNdfjDj+Ck5N+IKxCyCmLdyiRMFyXx5tSxTYX7C6AHOHiu0B5WZ2s+W06J1KMv5Pi12VT5YGi4L/Q/uFvf0YVFT4fosyOVvEn4t0Q5g6/H/APVu0YndiYV2RiZEkk6ojOv8zxbDxt8wYjYeAA7Fey1IbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQGP5yxaEBpPsfuXlhe/zGnmWH+3h9WEOYzJwhDC+Rw=;
 b=CQukKpubaKeHobHumMYJSc4mELzystRNjsuorPk5j9Yu2bCEtPIfLwBOixZQfszWNb4yyA5EW4OELpL+VDs6qLJL3mJyVsDdfDaRuYYPxEb2rbGSTQnTa+VkLimUpcOPM1YdoS8xjO5qju9GqaOIOt7RWR15m/Kt9Ad/IwFAmUSR1tXTOsj0n7HexKHkDJctwI5kJP5/bE2joaGFW9YFrn0ot7qA9hW42CUArAcR6dgdsoxzpDol7EahsEP2OeCrWEnkzG1S/u8ACXkC6LFfCRU+kOqbkSQsEXfhNGvOBe/5z1Gmk6iZWeWLS4OtIGZCO48zUZzJjgKLoTieFhr+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQGP5yxaEBpPsfuXlhe/zGnmWH+3h9WEOYzJwhDC+Rw=;
 b=hacC7eVomu8r4zXYN0h19ssNUVgN4R6kCxbVDmX1woY8yTucjYzXbedb0d4UPaXGbsUdH6ddMmI47uNie8KcTEUzvg23J7CL5t9n7DfYPzsnFg7a4o3/slAbWg4xx3eTM2q/CmhfHKYEi4QTNEh2Ii9oLv5xDkTF185yR2SNDvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN1PR12MB2399.namprd12.prod.outlook.com (2603:10b6:802:2b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 15:42:09 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%8]) with mapi id 15.20.5123.023; Thu, 31 Mar 2022
 15:42:09 +0000
Message-ID: <32569507-b83d-da1b-5599-f8e316a25f35@amd.com>
Date: Thu, 31 Mar 2022 11:42:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
 <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
 <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
 <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0353.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd5dad5-ecd9-4e30-ba61-08da132d03d5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2399:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB23996C827F97EC8BB7CA2225E6E19@SN1PR12MB2399.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTQvNYYfLBuQi0VD8wjSVuCuTSmG6ncTYdt6ylMmMZBEYIX3yHIPMiglvn7e9cDF3PTUAtSDMXmLdfxWczjg+nqXBmlSfALIRTora4BT931afK0eSwfcZRnA50+tAhfSAJhBkSnvDSYtJ8yVHxO1rmCwN5St7+bong4Ww6t+rDWJbZhG6horHonbYgWyXgdlv5SMKtumv1LvuB6G7TaUrjWhotJVLUBhreOvRAGpQuszV3zBaD3iVOOren3HMf7TwKTlf+EGvAs6eALoO0mYa/atiHI5sXkG65bnZ6pLDOMIENi/5Yc/sOfhjMTDQryrd31Kl2NSoOmzHmcggYleO8i638cBKaHVb5rpWozrywAVhGq8oCk/N4mJ4tDY2ypE7IA5zjcxv7bGf07YHz9I6GXPvY81dbeFewwPuDBYz99mpspxMr1WpCLNVgGP50mVRCguAtH1THzXLnbi+5BcQi8xDKlKtBkMKj8NFMJeIt4QI/eVs2PFErJI34FRgvcaIe/EUuDhFuUggq1sYW3gYPEwSaiKlGlJLa790ZmWErB8oflFnrQQsf/qCkU/rPueNr3E3kRm6VnNZTtL6/HzYCLwiLgU9/tX2tTFh/xhuXPJ2LDG1iOOrt3xrRIMEumUsICfrBZSeGIWI5t56i/zEUCe1zdJ1Tj4DDSjRig5ZPm3C5VOhrgkW+hFfgHAob1nqGeYCwlri0Uull0ok+hN5Un80tKetov+kZLqUBT8d5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(30864003)(66574015)(66946007)(66556008)(66476007)(8676002)(36756003)(5660300002)(8936002)(83380400001)(38100700002)(4326008)(6636002)(2906002)(186003)(6512007)(316002)(110136005)(6486002)(508600001)(31686004)(26005)(53546011)(31696002)(6506007)(6666004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdrck1ZWlNCSmIya1ZxeHdNbzFmK2tnbmZ3VFcwVjlCZGdEdUgrNU1HTUFZ?=
 =?utf-8?B?Q0tUdDFVL1ljZmZqYzluYkthZU9BN1VZaXRzZm5idXo2K0ttL3BqQWpETDN5?=
 =?utf-8?B?ZWNBVDk4L1pMN3FzNS9LL3JzcUpaUElQSnZsMFczZit6MFd3NXRGbFl5Z1NB?=
 =?utf-8?B?Vi9tREphdFM1WXFDQ2lHbDJzMFpnMnhWMFhMOWhUSmVIdzNaSWNQYVR0VTh2?=
 =?utf-8?B?RVRlVU9waTd6UTBQa1hXYkpKZXV0T1dtZlZpMFdGblo0Z2ZpUzNGMld0c2Vj?=
 =?utf-8?B?djV3WEtBNnMwRWFZZysyM3Q2cGVKbWFoVVhQTWpnR010Y1ZXSUhRVXhmLzNo?=
 =?utf-8?B?R2dyUWdSdWFpZW5ZRnpBNVlXMURJU0grc2ZSblcxeHpNUjBIb2s3c2FxTE1D?=
 =?utf-8?B?VEZoa3NXaXZFZUcwbjZZZDBGZCtHa0hKQlY1a0RyMlY5UDg2ekhtYnVCdkhD?=
 =?utf-8?B?UEZWVnBTdG5yam1zNXdHZGpWcU5XaGlIeUhXZTJaMG43UUdhUWtJYnpldzhQ?=
 =?utf-8?B?WkZUVHlBTkp3aStYL01UNXZDSDRVS1FRQmt1c0ZQQnBFOExyaDVnN3gzU2lY?=
 =?utf-8?B?QWJjaGMxZ2h0Zk5raXZLY2ZuSHFmNkVsYUU2OWJFeTNWOWR5Mm1Pc3Y1Yy9t?=
 =?utf-8?B?R0p6M3ZNSEgvWVZRK2Zvd0tzeVp4OTBlbGxNRzNFSTd4QVlwNSsrS29UODRO?=
 =?utf-8?B?bFByZEZjVllQWDBoRWRpbGNGek1tOWxpdXcya0ZMWFQ0d3dBQlFnY3NUOEw2?=
 =?utf-8?B?TXhGZEE2QzZISVJ3cnRTSkJnQ1RXdjMzN3VLWHMrQzZPTjRTb0k5dER5ODN6?=
 =?utf-8?B?MHRMdzBWV3JZcnNwZ1RoVVZRSE9GNzlTLzhoeUxmKzcybGpIQk9Db29OUjZO?=
 =?utf-8?B?MXFMVTFHZmczNXppV1l2Z09vWHBxWWxHVXB2cG1BaGRjSUxqNzdUOTJVQjA4?=
 =?utf-8?B?SFZjc3BWNlU4ekJ3UWVuS2I3TVVUQVZUZXIwSFJqNTlDN0pOMm1DVkNYeHIy?=
 =?utf-8?B?eU13RCtpTTZvUEFCWkY0QXNSRTd0R3hqSDhQOXBWY1ZVbnRpMnR0NVV6LzBX?=
 =?utf-8?B?a2tiUm53NVVCbmNOOXJIQnBEN25hN3B5Szc0NUY0L3pPN2tRV0QrRWdyU1FF?=
 =?utf-8?B?cWhTNmxnVmFtQTVBcFlmdVJnREFNTTdSNG5jdnRPeTZGVkUzTUpQNW5Xbk1x?=
 =?utf-8?B?Sk05K0d3R3VaaWtRZUFKSTRybkVxSFpTN1Q2M3FlSTlCcnQxeEY3SFZOMGt2?=
 =?utf-8?B?Nlg2c0VJdk84UG1BaXVPK29xZmM2UDVrQTBhL1Z2eVltdldNZmQ3TEhXQzBJ?=
 =?utf-8?B?WmtIb2p2MnRKSmx1K3J5UTd0SlhVenU0RldMaFJQRnc0MlRKa3A1SmNiUDR2?=
 =?utf-8?B?dVVLVENHMVgrdkh1Z1c4Vk81b3c3M0VaYXdFVzg0ZTBOWDhjN2d2MzVwVDAw?=
 =?utf-8?B?OWZCNHBURkoyNjhPOFpGRFlzUG43VnhWalhaZFpnWFo3NTVqQkZBTExxVm0w?=
 =?utf-8?B?TVFqTmdOeWJ5YVNTekJ1aGliS0EvZU9BeGE3SGVYN2UzM242SklZNG5Bakc3?=
 =?utf-8?B?NnhjKzRMbEpHMVM2bFF2aWV4OW5uVjNSUENlMTFFRnc1Sk54WCtDaU96ZXp2?=
 =?utf-8?B?OUtxNEJSVnEvWk5idE52UXhKaU53b3ltaVd0emRyS01sNThRVWdFMWd3QXRP?=
 =?utf-8?B?bGVXV1hGa3dYWWpSSkxhRnprcGVxbkJiNmVobjdxS202RTJXODJSQlE0VEZD?=
 =?utf-8?B?ZmYzZEVPcVB5M2I5RHBwcFJhdE9FazhkS0ZjRDd0MUI0MUdCbnoySTl4Z1pk?=
 =?utf-8?B?R1BWb0J4WTFlbHZrT0IveGdCMVljblU4TkhEa0UzSEFoQVdlbmh2WnRjcGRH?=
 =?utf-8?B?bVhSQW5zekd6L3ovMzcrY2o2RCtHd0h5WkRPTmgxalZrbjV3Q0hsZlVoTUQy?=
 =?utf-8?B?MURiODFMQkhITXo1SXhUU2hsbTN3MVV0cC80Sk1FVHZmMFp1RTZxcUN1WVBZ?=
 =?utf-8?B?a1BROTdDVC9wZHRGYWttZ1F6MUl3d1RianZqTE4zMkFISm84TzM0RDVBNW1I?=
 =?utf-8?B?ZElXMEp0amNuUUVCa2xjSFZRQjV3aUxLTmdRYW5WRVMrUnBFZ2xMcmV5OUpy?=
 =?utf-8?B?T2JGZldmbG9RVEpFZFVBdFBLMGtwZmtTR0kwVnc0Yy9iNFZ3VVNqYnhOTjVl?=
 =?utf-8?B?VkNYN2V4TDlKdXN5QjhNRmlhMDJ3M2tSKytIenNpQ0JsRk9xejNNeTNRR2h6?=
 =?utf-8?B?cXlQdTd1cVFGZWExdGNZY1J1dk9xZjc1TTNRMjdTTHM4cEg5NG01a2Y0TGhP?=
 =?utf-8?B?aFVOMW1NWFl5Y0oxQ1RkYTdPd2UzcHhtR2lDWWtIMXFGY25DRjlyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd5dad5-ecd9-4e30-ba61-08da132d03d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:42:09.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDob7ZHf3isAqRSH3UQW6lwjqmpy49aSBfPbpOY0PmKkarp/nrIY5XXc3PXwOHdZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2399
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-31 10:37, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com">Am
      2022-03-31 um 02:27 schrieb Christian König:
      <br>
      <blockquote type="cite">Am 30.03.22 um 22:51 schrieb philip yang:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 2022-03-30 05:00, Christian König wrote:
          <br>
          <blockquote type="cite">Testing the valid bit is not enough to
            figure out if we
            <br>
            need to invalidate the TLB or not.
            <br>
            <br>
            During eviction it is quite likely that we move a BO from
            VRAM to GTT and
            <br>
            update the page tables immediately to the new GTT address.
            <br>
            <br>
            Rework the whole function to get all the necessary
            parameters directly as
            <br>
            value.
            <br>
            <br>
            Signed-off-by: Christian
            König<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63
            ++++++++++++++------------
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp; | 18 ++++----
            <br>
            &nbsp; 3 files changed, 48 insertions(+), 48 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index 9992a7311387..1cac90ee3318 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -793,18 +793,19 @@ static void
            amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            - * amdgpu_vm_bo_update_mapping - update a mapping in the vm
            page table
            <br>
            + * amdgpu_vm_update_range - update a range in the vm page
            table
            <br>
            &nbsp;&nbsp; *
            <br>
            - * @adev: amdgpu_device pointer of the VM
            <br>
            - * @bo_adev: amdgpu_device pointer of the mapped BO
            <br>
            - * @vm: requested vm
            <br>
            + * @adev: amdgpu_device pointer to use for commands
            <br>
            + * @vm: the VM to update the range
            <br>
            &nbsp;&nbsp; * @immediate: immediate submission in a page fault
            <br>
            &nbsp;&nbsp; * @unlocked: unlocked invalidation during MM callback
            <br>
            + * @flush_tlb: trigger tlb invalidation after update
            completed
            <br>
            &nbsp;&nbsp; * @resv: fences we need to sync to
            <br>
            &nbsp;&nbsp; * @start: start of mapped range
            <br>
            &nbsp;&nbsp; * @last: last mapped entry
            <br>
            &nbsp;&nbsp; * @flags: flags for the entries
            <br>
            &nbsp;&nbsp; * @offset: offset into nodes and pages_addr
            <br>
            + * @vram_base: base for vram mappings
            <br>
            &nbsp;&nbsp; * @res: ttm_resource to map
            <br>
            &nbsp;&nbsp; * @pages_addr: DMA addresses to use for mapping
            <br>
            &nbsp;&nbsp; * @fence: optional resulting fence
            <br>
            @@ -812,17 +813,14 @@ static void
            amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
            <br>
            &nbsp;&nbsp; * Fill in the page table entries between @start and
            @last.
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * Returns:
            <br>
            - * 0 for success, -EINVAL for failure.
            <br>
            + * 0 for success, negative erro code for failure.
            <br>
            &nbsp;&nbsp; */
            <br>
            -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, bool immediate,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked, struct dma_resv *resv,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
            <br>
            +int amdgpu_vm_update_range(struct amdgpu_device *adev,
            struct amdgpu_vm *vm,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool immediate, bool unlocked, bool
            flush_tlb,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start,
            uint64_t last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
            vram_base,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
            *pages_addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params params;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_tlb_seq_cb *tlb_cb;
            <br>
            @@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; (AMDGPU_PTE_VALID |
            AMDGPU_PTE_PRT)) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = bo_adev-&gt;vm_manager.vram_base_offset
            +
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.start;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = vram_base + cursor.start;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = 0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            @@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct
            amdgpu_device *adev,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = vm-&gt;update_funcs-&gt;commit(&amp;params,
            fence);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (!(flags &amp; AMDGPU_PTE_VALID) ||
            params.table_freed) {
            <br>
            +&nbsp;&nbsp;&nbsp; if (flush_tlb || params.table_freed) {
            <br>
          </blockquote>
          <br>
          All change look good to me, but when I look at previous
          changes again, kfd_ioctl_map_memory_to_gpu is not correct now,
          as this should flush TLB if (!kfd_flush_tlb_after_unmap(dev)).
          <br>
          <br>
        </blockquote>
        <br>
        That was intentionally dropped as Felix said it wouldn't be
        necessary any more with the TLB flush rework.
        <br>
        <br>
        Is that really causing any trouble?
        <br>
      </blockquote>
      <br>
      I discussed it with Philip offline. The TLB flushing in
      kfd_ioctl_map_memory_to_gpu is still there, but it is no longer
      conditional on !kfd_flush_tlb_after_unmap. Instead kfd_flush_tlb
      checks the sequence number to find out if the flush is needed
      (presumably because we didn't flush after unmap).
      <br>
      <br>
      There is one case on Vega20+XGMI where PTEs get inadvertently
      cached in L2 texture cache. In that case, we probably need to
      flush more frequently because a cache line in L2 may contain stale
      invalid PTEs. So kfd_flush_tlb would need to ignore the sequence
      number and heavy-weight flush TLB unconditionally in this case.
      <br>
    </blockquote>
    Thanks for the explanation.<br>
    <br>
    One nitpick below, this patch is<br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Christian.
        <br>
        <br>
        <blockquote type="cite">To fix it, seems we need beow change,
          then pass flush_tlb flag via kfd_ioctl_map_memory_to_gpu -&gt;
          map_bo_to_gpuvm -&gt; update_gpuvm_pte -&gt;
          amdgpu_vm_bo_update
          <br>
          <br>
          -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
          amdgpu_bo_va *bo_va,
          <br>
          &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bool clear)
          <br>
          <br>
          -&nbsp;&nbsp;&nbsp; bool flush_tlb = clear;
          <br>
          <br>
          +int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
          amdgpu_bo_va *bo_va,
          <br>
          &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bool clear, bool flush_tlb)
          <br>
          <br>
          + flush_tlb |= clear;
          <br>
          <br>
          Regards,
          <br>
          <br>
          Philip
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb-&gt;vm = vm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fence || !*fence ||
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_add_callback(*fence,
            &amp;tlb_cb-&gt;cb,
            <br>
            @@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr = NULL;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *mem;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **last_update;
            <br>
            +&nbsp;&nbsp;&nbsp; bool flush_tlb = clear;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv;
            <br>
            +&nbsp;&nbsp;&nbsp; uint64_t vram_base;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev = adev;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || !bo) {
            <br>
            @@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev = adev;
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>bo_adev is changed below, init is not needed.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">+
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags = amdgpu_ttm_tt_pte_flags(adev,
            bo-&gt;tbo.ttm, mem);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_bo_encrypted(bo))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |= AMDGPU_PTE_TMZ;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base =
            bo_adev-&gt;vm_manager.vram_base_offset;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags = 0x0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base = 0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || (bo &amp;&amp; bo-&gt;tbo.base.resv ==
            <br>
            @@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update = &amp;bo_va-&gt;last_pt_update;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clear &amp;&amp; bo_va-&gt;base.moved) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va-&gt;base.moved = false;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = true;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;bo_va-&gt;valids,
            &amp;bo_va-&gt;invalids);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (bo_va-&gt;cleared != clear) {
            <br>
            @@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_update(mapping);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, bo_adev,
            vm, false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last, update_flags,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;offset, mem,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_addr, last_update);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            flush_tlb,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            mapping-&gt;last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_flags, mapping-&gt;offset,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base, mem, pages_addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            @@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;bo_va-&gt;invalids,
            &amp;bo_va-&gt;valids);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va-&gt;cleared = clear;
            <br>
            +&nbsp;&nbsp;&nbsp; bo_va-&gt;base.moved = false;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (trace_amdgpu_vm_bo_mapping_enabled()) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(mapping,
            &amp;bo_va-&gt;valids, list)
            <br>
            @@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;start &lt; AMDGPU_GMC_HOLE_START)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, adev, vm,
            false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last, init_pte_value,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, NULL, NULL, &amp;f);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            true, resv,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;start, mapping-&gt;last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value, 0, 0, NULL, NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;f);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);
            <br>
            @@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct
            amdgpu_device *adev, u32 pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true,
            false, NULL, addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, flags, value, NULL, NULL, NULL);
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, true, false,
            false, NULL, addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, flags, value, 0, NULL, NULL,
            NULL);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            index 6b7682fe84f8..1a814fbffff8 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm);
            <br>
            &nbsp; void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base
            *base,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, struct amdgpu_bo
            *bo);
            <br>
            -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, bool immediate,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked, struct dma_resv *resv,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
            <br>
            +int amdgpu_vm_update_range(struct amdgpu_device *adev,
            struct amdgpu_vm *vm,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool immediate, bool unlocked, bool
            flush_tlb,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start,
            uint64_t last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
            vram_base,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
            *pages_addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
            <br>
            &nbsp; int amdgpu_vm_bo_update(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool clear);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            index 27533f6057e0..907b02045824 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            @@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start, last);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; return amdgpu_vm_bo_update_mapping(adev, adev, vm,
            false, true, NULL,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, init_pte_value, 0,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, fence);
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_vm_update_range(adev, vm, false, true,
            true, NULL, start,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last, init_pte_value, 0, 0, NULL,
            NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; static int
            <br>
            @@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct
            kfd_process_device *pdd, struct svm_range *prange,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 :
            0,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, bo_adev,
            vm, false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, last_start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start + i, pte_flags,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start - prange-&gt;start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vm-&gt;last_update);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            false, NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start, prange-&gt;start + i,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start - prange-&gt;start,
            <br>
            + bo_adev-&gt;vm_manager.vram_base_offset,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
            &amp;vm-&gt;last_update);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = last_start - prange-&gt;start; j &lt;=
            i; j++)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[j] |= last_domain;
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
