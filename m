Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A5610EC75;
	Mon, 24 Jan 2022 07:53:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E8310EC75
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEx2ycVAWjBIuPypUDdaHHGEu7T7tKWcqwXgpdZVBhNq298Uq3HqY6LmZJtdCPF2AdrDlQIBTcyasdgqgjzfedWCVcutR1ECkiPa7uXM5vIt1wfR0MUAjAS1MLQwhsozL4BAfsuQR8k+EFdl8lFLsJwilhsYeFpCTg3IYayWLdKYiMpufQNzGdy37sYBZSyvcoixCm76cdxsJtTnT/NYXT+WqmN9K+6clSb5IbY7RECm8lzjohneDedgI1oWO/WZUj5HtZ+FsKBkD8xa4h3JsoCrtMHBKYlQpdljzPV8o3ujhvh1Njj10Ox6XxQOt9rW10/60lABSIBiPiO6jpMmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSyPBsdJiUQgtDUZKaj9XZJxgEccmFvnM40uu8R3XzM=;
 b=hx3nrMViO5nRlcDhvhhROonEW96+Curq7HpXBpnjc3XNG3gj5TrMhM1RBYk1x/3yM6UjPcjCuzAQu5XZzJ9WYjat5Isjqs092HMOnyT7A+c2GC8xQBfdUVUyHuqC0OkQjBuaijTNj2ODaERjpWLc+umhshkIm61I7kHvl0g4OQORLBmn5QpS+ghe7FHG0RDQApGETqYz7DeoW9QRnuzBiHg7JzBrvSLGOV3xYoI5NwHGvM2+N0G3r7UBfkHfOq3yM0OW6cBLVFmoEK0SQ1KtPZwVvZvBITrwM8OyQ2ize9ZLGN1FnUNg4x7jaNMM0PATkARpuOqRRlIehGFXP83QAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSyPBsdJiUQgtDUZKaj9XZJxgEccmFvnM40uu8R3XzM=;
 b=XBwf5+WgldNQ+eSNbmCHK5HpyYxRweM47KZ6ThNFh1ysAFk407XR1cVpS0zYtQS8s5ZDxFkY7q65yt9O4sWW32M/qWPZn0VLx+3XszPuQB3uNv4/sDTbeGFnDW6agmAQoIsEsaCEqt64fGbY41N5poIilfEuI10ceV3GrNu/4HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 07:53:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:53:23 +0000
Date: Mon, 24 Jan 2022 15:52:59 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Message-ID: <Ye5a21G/9yMIcHiM@amd.com>
References: <20220124064342.273055-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124064342.273055-1-Lang.Yu@amd.com>
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3f92a1f-5b16-430f-09b8-08d9df0e98a5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0019FDB56CC6A1288DE78D50EC5E9@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyOoEnSJccxeoTH+gKDabo67KKHQsFWg1ghM0PozC4fAoF9LQRX6NhtDoJSTeIYn+mTQ1xiHE8LekJfT1kTsbx9X2mSfc5rSnugsLKDOM/i4yT30rhjZi2kU65wA1zcN4R44FMfZAK4tTP13WsIb6IzdIeWBBGGsoKtISw0rOQqfNcesA0Z25qeYkgki8iXKPumK4awabUVJtCRgaKVRzkCDDvxwFLuUIdUlBJ/ODMc8vVAWsvfKviDjUyHgiaPbYgUn4+v+boXfH77nLzHYi2zP1fdE97L4lNweq5tZ9KOFDVwMUfnnCfa0eHGgIyHgypHPg+A7F6sVX4Ymjkm0VM9TeM5+/FRDConjZ+g9mOaNs/eQgAsHs6Sqrn+u/PX6QEmQpExYXubcVlzwSmi0ACO7HgK6G+VQ/hgZUfa6cG7q67U6Ntw9wh2JiS1GCNqMoo8hefouRW5U9jKTh12RQsjg/6jhNrT0xv2tOr/FSp08it8kU/YPXXRvNci/2VBz/0J2A81I9GrHPnlvt+xc0ScKExdpSMsg4j+lH7pfDZKR7TWmqP3MDtdWx81Ls8BPc0W8bgOBx9xUMc9hDvg9kCwGPq4KWJmReO8rCFUGd4RffvGapNaRqcgtfv+pq9I5oEk2U/EW+hq9qAZQWcTxRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66476007)(8676002)(6862004)(66556008)(508600001)(66946007)(2616005)(86362001)(38100700002)(6512007)(186003)(5660300002)(6636002)(316002)(2906002)(4326008)(6506007)(6666004)(36756003)(6486002)(8936002)(37006003)(54906003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f43V+zfVFvUqRCAqPHW3hCb2BtCZlELCdOjE9RfAHxqSvx4i4Jeae6O0wioy?=
 =?us-ascii?Q?knDJz53YqozQsrLjXrqM08ktWxzYwXEiUCj2euFrarSwmNkijjkOdIkkKmvX?=
 =?us-ascii?Q?B/FRLIvVAg81CcFN8zUNtVj4lqAXxOVFjzGLxywHM/p37NMeIdds4SPWJRJO?=
 =?us-ascii?Q?yVBu5NRpZ9DDBXQ/R/qhm4haA885lU6hPZaM9vmQdFgYAhiPOF1vE9RHXUmK?=
 =?us-ascii?Q?VxFKPny0QBpwH4Ro1CIHDWblz0Ut8rvGUWaScrEIVHdd2aPw60TSZSBZ3S8+?=
 =?us-ascii?Q?iMWflMa8ji/p3ko0ln89Z2FBlD7oMaoOTlok7ziKt8zdfiCeCMA3WR8at186?=
 =?us-ascii?Q?3oXgWkPEzs8dPDG3tSIH8HryucH7gD/hxhIuQgko2SMvFL6gKghEw0AUV6Rj?=
 =?us-ascii?Q?O9pyUwwJCZ5XDkolHvCx9nZUzfiJx9vXzA1OjiVZs+q1whNo3RgmsBrmpxoa?=
 =?us-ascii?Q?HVM+biw+DxGx4PNU8j+UDAirta5sZNfRXC8wWbFJVQnJf6VxOjBYFwmpsD0V?=
 =?us-ascii?Q?qcQhoUUHCR2AUQ9uRkFn3nFY/3hmDqx99VxU2F0jSgVW23KrntwLhGno6R45?=
 =?us-ascii?Q?ia/IoTLdVlVHq1z7g5TrBYqejj8+ILd4mtL9B74twBMmKbtJRx4LRePqDWgy?=
 =?us-ascii?Q?VEMY3qVXn1JoImVlt9qjGacWqCV8QGu9riAqmqb8xm7LObrgGqh6dd/HSoy2?=
 =?us-ascii?Q?4gGsNNpdQcZP36ypsLyBd253BZu4KNeDi6pdvzL8ZA+PtgilIEAy2OKIQj3r?=
 =?us-ascii?Q?gdRfmBYXlH7xxa8pxyW1+KitDHlOWjdPvkLSzCCrLQQNlj8Q04FPbfumWRtD?=
 =?us-ascii?Q?T+tgiQpgdb7WVDc3v0OgJFSQAZQh8T/AiquxB+v0kEBg9Lodk/vqQy/7L7FC?=
 =?us-ascii?Q?jiIQcBawSldmeth9BhxLRlhec6ZpAah4UPy1bDTwOgQI6YJArFWPtqVFJFaX?=
 =?us-ascii?Q?VzA7fh0yhZsx/Siqa5iZsPIKk9eo652KaS+lBmhFjOvlHsk8T3WFRNgDMAEj?=
 =?us-ascii?Q?8hwahuLMLAAlepfifN0jk3omrtU4llljabgQD/R9ZdGP7wdNIP0lTugf4kqX?=
 =?us-ascii?Q?rncFW5vqp+4GX9JMqUrkC9ae9eg51UYiGjOWpjMQKVppdCFnahIEjk3UkSLZ?=
 =?us-ascii?Q?figwGiKCU+YVZx5pVLh+NSCNq10CEdvLaDFV7Q+j4Re2On2QsZu87vqlrQ6Z?=
 =?us-ascii?Q?83v7kKaXp6iFWDY+4lm3M+KAkGY+4qSSYO5VKlvx1k3Xze34gM5ChLXM1Kf6?=
 =?us-ascii?Q?tyEFww5Dldln5Y8SiejW5xkwkNCHbpqz5uikMS2hSDomq62QYKSXF6ZUwruy?=
 =?us-ascii?Q?FyD7s9evmXWiV2pRoN8+FZuPjn7ljahqDqWxt9wFRITjfehGLT/GsHJvVzeh?=
 =?us-ascii?Q?hn9mX+fuQlikqULOMCHRll98/pDUEuYprP4N8I5j4zU0nEUuVw842CWuaqCu?=
 =?us-ascii?Q?YYEqwWVTRY5CeEXTXyuAN85MokhXplW6nNwMG09SNbCekGYHihHuvfM8u32A?=
 =?us-ascii?Q?w9KqVuYClXgggMNZ2+T/heGr8n8sERhGYHAIreQNRgy+pu3Nrx0D6xEdPIPI?=
 =?us-ascii?Q?i6Cth1ur8ir/R4mf78ay4vHzmKWNdfjNa5l0R5s9htNFvYFGAK8vyZWYlIFJ?=
 =?us-ascii?Q?dfScdTgdQqQPw5WAFmOlYLI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f92a1f-5b16-430f-09b8-08d9df0e98a5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:53:23.4374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dp1vap4jfxAHGI8Og44J/OMQ4NPdQCwfh4D1CEXO2/qEBIxiJmIyn/TMUSGpQ3AGlP29ZFK0hGw5tgndpLPeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 02:43:41PM +0800, Yu, Lang wrote:
> Some clients(e.g., kfd) query sclk/mclk through this function.
> 
> Before this patch:
>  # /opt/rocm/opencl/bin/clinfo
> 
>  Max clock frequency:                           0Mhz
> 
> After this patch:
>  # /opt/rocm/opencl/bin/clinfo
> 
>  Max clock frequency:                           1500Mhz
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2238ee19c222..665905a568eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -552,6 +552,14 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
>  	return ret;
>  }
>  
> +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
> +						enum smu_clk_type clk_type,
> +						uint32_t *min,
> +						uint32_t *max)
> +{

We need to add comment here to explain in Cyan Skillfish, the clock is
constant and not changed. So here, min = max = current clock.

With that updated, patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

> +	return cyan_skillfish_get_current_clk_freq(smu, clk_type, min ? min : max);
> +}
> +
>  static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>  
>  	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -565,6 +573,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>  	.is_dpm_running = cyan_skillfish_is_dpm_running,
>  	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
>  	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
>  	.register_irq_handler = smu_v11_0_register_irq_handler,
>  	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>  	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
> -- 
> 2.25.1
> 
