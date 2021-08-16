Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39039C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FF7632FB
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01FF7632FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFEF89E3F;
	Mon, 16 Aug 2021 14:00:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EF889E3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 13:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk+u6n5aU7tgjHWvm+MiAGoViHxyo6fPYgfbVXghZSUPA2wtf2NjjCnr3GHuxHQld1OtjyXvbiRoaf6TqpmWSDeqzcXcjFqP5LlxQChgVj/vlQTJaLcuvDka6OZogLSEQ/KX3+GW0HpDoyAjoEBUyRbXIbvbdNdXoz/uNhFFVWIQILdYzNEKk9lgbgBA4NT0TkacV2JkRXvCEruXaeyjU/TvxOT71fpp0SRptqLEatvjYTcuVZlwFEmGa9abzMUfh6Q1yjjYS14VbF25AEBwt89E1JZyG9U+4+/2zaQkaqcPgtlY7YZdUZJSDYdLbY6xhSm89GirBfGU4L+JAYvyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laKFEBuNEypF9jIySA8kzep+hF1DKkN61sPVwG9qJ70=;
 b=VWzsCG91Oo45EjcjcBG0C0tWjXlI32nKmvaxaL/nyMQAtjlBKUscVULbe6BaeHmjeCbF+Q4p98rUc30lt50UXUaZki+2hYvbmYCWQvhc/PCANbxpPqp4KiQfOmyEBd2vWSn4PcbevE4urcER5B1JuQaVc6m0Ki4t3JIwuXkLD5E5TfL9+a1BuXy+qtXXoTRLA73TMFKxoN05DKs/vOMq0e5qyAFbPQASQOr3fQdPUERNKHxMLIAwH7MIAeodXs7J3QhbjL2/ujhAx4oK0Afgu+DANFTSpBE0r2I3oDscUvlHeAqMNxn/T3oprspMYGkAidysiIC8LxYG+1zO/0CygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laKFEBuNEypF9jIySA8kzep+hF1DKkN61sPVwG9qJ70=;
 b=loXnvyTdw0JjZC4gsjxXvZptT5FkRtgQ5XNLc3wZFUASgbod79GuAhShqtz2AhY6Z8lK1VtvOR+9ASTy5KI5x5PXYWiiWQr2DtF1aN1IplX1REhVi9zNPwzqGYY+9PdBGkCe/EZ1r5a5I5otosvHgclzMOW6iP6zayt+hoBy9zw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 13:59:55 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::b906:69af:a1f0:ed2c]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::b906:69af:a1f0:ed2c%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 13:59:55 +0000
Subject: Re: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
To: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Cornij, Nikola" <Nikola.Cornij@amd.com>,
 "Logush, Oliver" <Oliver.Logush@amd.com>
References: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
From: Leo Li <sunpeng.li@amd.com>
Message-ID: <9c1f29ee-a1d4-c745-f87e-52bb4b896b90@amd.com>
Date: Mon, 16 Aug 2021 09:59:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:52::35) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.35] (174.93.46.3) by
 CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 13:59:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc8af1d5-988b-44cd-1b92-08d960be2062
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51118A689BCCB777D2BB694682FD9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:42;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wEBtiICUjFb2pFF129Q9Yv/JvF3anXuxKtKYR+0tDiufeFggPBGdQ+OH4F84xfy9s+YPTpRAbQm9Zv04J0g1vfp8wohhXxb33pfbsSRMnkBzJYQCqDdkr5G6q6TI5/pmnXFV2cOYr7xCRkuq9whm+k7Z6D7k/tmF/+SS2Nn05+pY02+bU8uO5Cq+NhassdvARS+UrarhUyFJERuhSnscR36x3BibpX4tcV4aj3nqTgAGigUqDR5bWvIjAnYsfv9k1R/Y/75Fx9npykYhoz6+F2bthyqFTbNb2ieWXCRVuzmGR0ILsXiU7N+JIwM7GR/iaX5pCjLzsCsI80XS70MR8I2Uw+aCiSWhgayPYrH6aH/i/7WM8T9G9T0LtF6iysE2WfF1EwIyh+w3glGhuw9A4t29o4ZIb0zIJsk+wj29hgMcnp9/KUb7y7AZ+8LMUVSwVMEFpQu4LgslA8aJz7ys4A7jvtct1ON66910p6jLDEJMgrpct3h7DR9fWRgcob47u6KOmZWsunwjMrTYSUBBkO1jeqxqWdtmB/pYtzBnm1MgghCDzcOQezx5ObWF/kAvGXJXCxwiEQy4KdC+H69VR/UcW8HWReUXaX6ENWUssFANbk3MtiIl77LNPtLgX/oqTHEWwj4D3fGTYjl0rDHlRvu0FS7wHx9OHynwZO+FIAKxuNjqxHfXB+mi7sBQ5o3en0vqlFUwjXCpvddImFNoGZ7s/tdAXTNH2gqKy6dnC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5304.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(45080400002)(66946007)(36756003)(8936002)(26005)(2906002)(5660300002)(6486002)(86362001)(4326008)(53546011)(16576012)(316002)(38100700002)(966005)(8676002)(2616005)(83380400001)(956004)(31686004)(508600001)(54906003)(31696002)(186003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURWTGVTcGlKNXhpWWNVbzlTMU5XVnlsei9ZS0pyYTlVeWM3ekRjQXU5dGJk?=
 =?utf-8?B?eHJJNzdHWEp4TXBSMWN1TVJjL2Y4eVNVeFZyOWcwNVMyRStXeHVxVm81M3dD?=
 =?utf-8?B?amlzTmlZekp5cHNvTUlpUkpSeFFqYjZsUHBFQ2VsOThvZGQvNkc4bGJzQXpB?=
 =?utf-8?B?YzloRzRKYU45YnF0YzlEWmNPY1dBTm5admVVYlNFTCtadHFVc1JIRmtnbnpP?=
 =?utf-8?B?UTZMcXBJOCsxbXFGcEFwcmJoTXdsa2pTYzFLRndBdHh3T0xhN0FnZ3hwOGI4?=
 =?utf-8?B?RzZBKzMwUkQwcTdKMUQ0d0UyaTVTMjlRcUtyUXdnSEhDbEczelNSVW9paits?=
 =?utf-8?B?WkFnYW84QU42QjBMdG5GdkxjN2t0Rmt0SHBiWFo5VGxoVXRJZ3BqN2RlN2No?=
 =?utf-8?B?NndKQUV1ME9Pc3NIbWNXRU9PUVdrUEdTUGRaYUVwcE9GZDlPVDdkQ1kxMG4r?=
 =?utf-8?B?bVVUOUFJQ0VuRlBabGJZUTloMDdLdk0yaDlndUtqV3pIcXVTTVNGMUhDNFkz?=
 =?utf-8?B?ZWFqbXUvUWp4TTc4NUdNemFRUGZ0V1E2dmpCQ1FxTUZtS2I5eE5UOUN0RENE?=
 =?utf-8?B?TElCYlNaODYzell1bEZ3R0ljZ2x4bEVnbkRtdTN3YTJKRHl5eU1xbGZyS0hR?=
 =?utf-8?B?VlR3SmdQc0psaXc1NVVDU3FCaFRFVTVyeFJZUit2T1ZaQVpzVWxKK0Y2L0Mr?=
 =?utf-8?B?emJJT2Y2b0gzS0JRSHJ5RUhVaWhxYVkyd1dyQ3FkMG5LYVl1T2NoZUljYkNy?=
 =?utf-8?B?RjVTYUwxVVdxNXFWa0RpMHU2eUpTYTNhYzVmaVViZzBkbDBpS2toaHYrV1Bi?=
 =?utf-8?B?WDc4VFI1WHltTjBKU3lvUld4NUt1LzR3RWQwQWc1b2t0SXVOVHB0d1picTNM?=
 =?utf-8?B?ZXVQNDBSeHlmK25IVmszd2dvOE8wNjZTQ2JidFluWHFXUTFUckh1SitnbGlU?=
 =?utf-8?B?c1E1SnZwM1k5UHZCUW10bkVjMHQ5SkFGdjNjKzQ3NGRsdGY4NDE2TWYwRjRH?=
 =?utf-8?B?aVF4bnhZVFArRUFqWWwvZGwrRVU4RitveHVrdmIwMEw2emltdXFhZytJM0VZ?=
 =?utf-8?B?WmJJOTllMmhJcE4rV1VYbG5LeUJPaklMT2dKK1hnNXBMMzQzYUx2akZ4Q2Jp?=
 =?utf-8?B?cmZIWUhiTmNtZWRhc3JDUlhmZzdMcE01TUJIRy9xTEpNeFdCNGgzeUpsc0U3?=
 =?utf-8?B?UzZ5NWhOSWZDWkVhSjA2aldXVStQT0lmYkFLVk9DT1p0R1d6V0oxa0Z6am9R?=
 =?utf-8?B?ai95dnNYWUtmTXVLaEZ2bDc3dUpRbHpBT1ExTDhhUTVVTXBsOGVXblNzN0dM?=
 =?utf-8?B?SlJzNDhGeHVzT1g2ZEF4VXNDWTRKN2I1VEhyalczaDJ3KzFPOS9ZbjFacDhx?=
 =?utf-8?B?RjdXbmovY20yWEFka1k5c0pSYXhlMHNqUVg0c3VxZHFTa3VydjkvSGYwS080?=
 =?utf-8?B?L2dPUGtIRUZWWU1GeU14bTBwbXhPaWRzNXlTMFFRL3YzS1JqVVpvR2JzcEdZ?=
 =?utf-8?B?ZTdyVVU4bVJRcG5URW81WThCV0tMMC9pQ3E1U0VPUEk5NFRxR04vZFY5clRS?=
 =?utf-8?B?dno0SkVMa204R3hOL2lnbk1ua3ZSMXRWRWF3NWhOd1FWTEhBU0R1djV2OTJW?=
 =?utf-8?B?UGJnZ3RVRW1Wd05vNnVaODUwZ0tVWHlmQ2kzVmtWYnlYeDFzTW5NM3dHazZ4?=
 =?utf-8?B?ODc4UVVLSERnTnVuOG5RbHczT01lS0lubEcxQ2UrMzJsODM1bzNqY21Lemd1?=
 =?utf-8?Q?GRybmJcfuShKZONWPaekoTZcvJ5weuBK7c3aR51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8af1d5-988b-44cd-1b92-08d960be2062
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 13:59:55.5637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyrMaO1PGbtW+lMoLpW93+bSlLpfP0Kef5m5YSvnP6K6oXqSKfRfZGybHavP368Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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




On 2021-08-13 3:21 p.m., Liu, Zhan wrote:
> [AMD Official Use Only]
> 
> [AMD Official Use Only]
> 
> [why]
> dcn301_calculate_wm_and_dl() causes flickering when external monitor is
> connected.
> 
> This issue has been fixed before by commit 0e4c0ae59d7e
> ("drm/amdgpu/display: drop dcn301_calculate_wm_and_dl for now"), however
> part of the fix was gone after commit 2cbcb78c9ee5 ("Merge tag
> 'amd-drm-next-5.13-2021-03-23' of
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=04%7C01%7Csunpeng.li%40amd.com%7C5f101c8bf2594f79890508d95e8f8f98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637644792952782170%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VDcz5SuZ0guBGRKKOlOWdWI%2FDLuIIwYAIs%2F8geu4JLU%3D&amp;reserved=0 into drm-next").
> 
> [how]
> Use dcn30_calculate_wm_and_dlg() instead as in the original fix.
> 
> Fixes: 2cbcb78c9ee5 ("Merge tag 'amd-drm-next-5.13-2021-03-23' of https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=04%7C01%7Csunpeng.li%40amd.com%7C5f101c8bf2594f79890508d95e8f8f98%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637644792952782170%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VDcz5SuZ0guBGRKKOlOWdWI%2FDLuIIwYAIs%2F8geu4JLU%3D&amp;reserved=0 into drm-next")
> Signed-off-by: Nikola Cornij mailto:nikola.cornij@amd.com
> ---
>   .../amd/display/dc/dcn301/dcn301_resource.c   | 96 +------------------
>   1 file changed, 1 insertion(+), 95 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 9776d1737818..912285fdce18 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1622,106 +1622,12 @@ static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>          dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
>   }
> 
> -static void calculate_wm_set_for_vlevel(
> -               int vlevel,
> -               struct wm_range_table_entry *table_entry,
> -               struct dcn_watermarks *wm_set,
> -               struct display_mode_lib *dml,
> -               display_e2e_pipe_params_st *pipes,
> -               int pipe_cnt)
> -{
> -       double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
> -
> -       ASSERT(vlevel < dml->soc.num_states);
> -       /* only pipe 0 is read for voltage and dcf/soc clocks */
> -       pipes[0].clks_cfg.voltage = vlevel;
> -       pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
> -       pipes[0].clks_cfg.socclk_mhz = dml->soc.clock_limits[vlevel].socclk_mhz;
> -
> -       dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
> -       dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
> -       dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;
> -
> -       wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, pipe_cnt) * 1000;
> -       dml->soc.dram_clock_change_latency_us = dram_clock_change_latency_cached;
> -
> -}
> -
> -static void dcn301_calculate_wm_and_dlg(
> -               struct dc *dc, struct dc_state *context,
> -               display_e2e_pipe_params_st *pipes,
> -               int pipe_cnt,
> -               int vlevel_req)
> -{
> -       int i, pipe_idx;
> -       int vlevel, vlevel_max;
> -       struct wm_range_table_entry *table_entry;
> -       struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
> -
> -       ASSERT(bw_params);
> -
> -       vlevel_max = bw_params->clk_table.num_entries - 1;
> -
> -       /* WM Set D */
> -       table_entry = &bw_params->wm_table.entries[WM_D];
> -       if (table_entry->wm_type == WM_TYPE_RETRAINING)
> -               vlevel = 0;
> -       else
> -               vlevel = vlevel_max;
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.d,
> -                                               &context->bw_ctx.dml, pipes, pipe_cnt);
> -       /* WM Set C */
> -       table_entry = &bw_params->wm_table.entries[WM_C];
> -       vlevel = min(max(vlevel_req, 2), vlevel_max);
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
> -                                               &context->bw_ctx.dml, pipes, pipe_cnt);
> -       /* WM Set B */
> -       table_entry = &bw_params->wm_table.entries[WM_B];
> -       vlevel = min(max(vlevel_req, 1), vlevel_max);
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
> -                                               &context->bw_ctx.dml, pipes, pipe_cnt);
> -
> -       /* WM Set A */
> -       table_entry = &bw_params->wm_table.entries[WM_A];
> -       vlevel = min(vlevel_req, vlevel_max);
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.a,
> -                                               &context->bw_ctx.dml, pipes, pipe_cnt);
> -
> -       for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
> -               if (!context->res_ctx.pipe_ctx[i].stream)
> -                       continue;
> -
> -               pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
> -               pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
> -
> -               if (dc->config.forced_clocks) {
> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
> -               }
> -               if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
> -               if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
> -
> -               pipe_idx++;
> -       }
> -
> -       dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
> -}
> -
>   static struct resource_funcs dcn301_res_pool_funcs = {
>          .destroy = dcn301_destroy_resource_pool,
>          .link_enc_create = dcn301_link_encoder_create,
>          .panel_cntl_create = dcn301_panel_cntl_create,
>          .validate_bandwidth = dcn30_validate_bandwidth,
> -       .calculate_wm_and_dlg = dcn301_calculate_wm_and_dlg,
> +       .calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,

Hi Zhan,

Using dcn30_calculate_wm_and_dlg smells fishy, IIRC watermark
calculations for DPUG and APU are very different. It's likely that
you're now picking up corrupted values form the wm_table.

Take a look at how struct wm_table is populated in vg_clk_mgr.c v.s.
dcn30_clk_mgr.c. For APU, wm_table.entries are populated, whereas for
DGPU, wm_table.nv_entries are populated. .entries and .nv_entries are
under a union, with very different struct definitions.

Have you taken a look at whether the pstate latency and sr enter/exit
latency values being used after your change are sensible? It could be
that you simply needed to raise these watermarks.

Thanks,
Leo

>          .update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
>          .populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
>          .acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
> --
> 2.31.1
> 
