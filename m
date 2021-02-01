Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F89C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D441B64E06
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D441B64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7E26E427;
	Mon,  1 Feb 2021 09:02:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292636E427
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 09:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzu9SBCWs3cu5sABjKsvOT5aRzRvQVzNUx948SPrXoFELHPwNuUouVJuOzRmAtTHZdL7PZaY63ay9pV4Nnl9s4DWUkzaqhimJ3hBrv8xfjbo3Zilth/c5vrIT3yLiJDkiF2ub2LB1Bw1ZWCD/cS4TPIOAygQntq9N0mfIat0kFci/PmHmsztob8cX8tE1/mSI20Eir0PtDot3foT5wLtVhZPgJVy2qpwrKUjiSnMU/3fcGHZQGUwPkneovqIiBmmRRgMMVdVaE9emrNbl55gLGmbaMPb6lpitVrHM2MIyDcFurA9VITMyMqz9V4hMegxmRE6mMjrWF8O/yQbyAaH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+G50357lxWNRYWNK+FMJM1UERSr2yjgQLcaAq4dv+Y=;
 b=kLzmc87lVmZ2hyq290LAcjp0SucIUTi/X99G4qqNdBmU3eK63nPXmOt/af/hxS3zEphrL+pAZEpf2lczl8l8ZbEF9z6eXrVejuD1NHD7G+asc5+ITysElWmq9sbeD4lxeFfqWTUAr5Ov9ngBdAw3bMLwnSWGM6bwAswvJxNQdAF0i1g6VRYvoJZhC1CtZHXHLtO0jGS1TijyYb+FjGB2yt2llZALBdXwDGpDzLizWMVn1X+0qhFuuhMvIabzK1aJ21iEfQmvHlhugpkZp2tlf2cKHfxyEiInrkbU56WPvr8gKoh0LSf6VMUtBmG2GUx/5CGHDXYP96rKIDSaka9KGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+G50357lxWNRYWNK+FMJM1UERSr2yjgQLcaAq4dv+Y=;
 b=waHRtDGhu+k32ZPj7M0y9/qplysv1zvcL7i9r/laWaTkMf1O5FvL1UXON/V69bk2Ra0PAuXhhwLUJJCWuAFna9LJ+QhE668FNr6Jh/SruCZTmAaFecy1UGf/ySkDvvJUtfhhHeK7+UG0X8sEfevSLTlrWKsErozabOqT41wMKzI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 09:02:55 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 09:02:55 +0000
Date: Mon, 1 Feb 2021 17:02:45 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fill in the data member of v2 gpu metrics
 table for vangogh
Message-ID: <20210201090245.GB3140926@hr-amd>
References: <20210201083340.28680-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210201083340.28680-1-Xiaojian.Du@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Mon, 1 Feb 2021 09:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c294cc7-d183-4cdb-85e0-08d8c6902987
X-MS-TrafficTypeDiagnostic: MW3PR12MB4377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB43777D48B9705DD05D2C2972ECB69@MW3PR12MB4377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PELhdUMMpPf4fOzq6fdpXcjJCyhly2/nflgaGN8ZiyZ/ylVct8Is2ZN7pszevJIDw7AqCxKMTRTgil/x5NGbWnrRlO19mJT8NBqqTzBKEHhgjQhl5IZP41MBLn6dOAnrmnBlhOG4wSLmyDVAdtWkVUofkpTiv/fACgGKlin6DKe2G44q4k8OY20fOpcPDBS/ZyJmjBAa77Tjlj2LBB1HB4i1rHRAnwfMrnTFBjPwZ9ODf6TDjA5WMW1gARaHttoew2wvYVUpIxhf39oLG6wnLH0IbmJf2pVbrsGfg6Db/dlU0eJFGhoYQtSSzMGvQEEvoNaucx7UHG0S2q7oe7zm10Msof/xclrqHCGRvM2zFopdgXU2+oA+5yMyOmRaEZ2ybVBTu1CWIvIaCqv+qdt6SYfnXeqCfE47nt2vA6aqM+c1CVicBf2X0+HFd/lMQckxvleSPwgckt+D1u95rDMqsRTE4vx6vcXbT/zL81AT5l+dreXGEMOT4C1o6tAi/jR5RLfYTgrrW5ZETjC/6dTs2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(478600001)(6636002)(956004)(26005)(16526019)(186003)(33656002)(8936002)(4326008)(6862004)(9686003)(33716001)(52116002)(6496006)(66556008)(66476007)(66946007)(8676002)(2906002)(55016002)(86362001)(1076003)(54906003)(5660300002)(6666004)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mkS0ia2I5BJmGEYval5R+KXsEB0MzvAmxn17VsdHdmoQxUPwNth+pFbfNBJO?=
 =?us-ascii?Q?O0f1rB/ZHhI9aVO30Wpx1sIMJRqpl0PBLqit0MpwcR7yYe1YDtZFkg3LpUJS?=
 =?us-ascii?Q?5FmuBiTDujr/yTMBsQ8u7ChOADcos+Olb/RuJmgdjYfsoJWbf6CcviEUgkU8?=
 =?us-ascii?Q?XG1LO25pKt/ky2AnANVSY4XFSkmme8WcqOJNgEdKaB+ThwiXBf6q0LMcU+h1?=
 =?us-ascii?Q?AyWEpzHv70+eqrxLRDy99EISqibqygIP5VuHJdEXpP5S0JlJIZ6VW5+Vd+r+?=
 =?us-ascii?Q?0bMNM3JTtHuG7/D2z2b1J4PrDSJovDkhrcrUN/RiWoruKk89ANeqQ/6PTyed?=
 =?us-ascii?Q?7hzf6um5VKaeZOOoG49/xv/hQfQYFSlsWemyD4sNVz8GcmGacTzd3sjfatu8?=
 =?us-ascii?Q?mohyYTFdJZOSPKaz4oWNSk4GIE5xSCMsLlnnD+Loh43WwLHpvsfiQ14f8DFe?=
 =?us-ascii?Q?zmrlB4JEQ6+/cuLACunaANb4df1E7py/uY2b9OOw2+0ASzUPkXylJ5dgEtfN?=
 =?us-ascii?Q?cCQh7/qqubS8Ir4fPq7ZM5VFBBkESWlm+LcYKtX7WkrPHTuZcQ+izDGpW6L8?=
 =?us-ascii?Q?qKSsj2PnJ1DTOkHL3KoN30BjdizSJ9L0yzmfdGT04CnvPBAbruTvOD9SD7bH?=
 =?us-ascii?Q?o5Q8XuAudyZfTEoQ95BB1CitlJOqCv2KbhefEPEwbS7pmHmLhdnrBLzcDu4M?=
 =?us-ascii?Q?/0wbIGe5/V67+nc11BQ7WQqCPWiogrA4yZpcqEju0ebsxg8VHoCazFYb3RRF?=
 =?us-ascii?Q?Py3AKcA8HZ9nUKJH0GKzxgnovBeT/uYglNd8l/IbWjOZC+VyXPfCtfveaCPl?=
 =?us-ascii?Q?uOkGl4tesnM8GzlVh+OiN8FsZIe0Mqt8TUZbeUGzAIWeQ8s5HrgCY0zp/wRf?=
 =?us-ascii?Q?n8xu2F74ko9lilr6RRVoy1BTU2O3phB1a6KxqZNR3Y56F+Rk3HO7iNRZx98J?=
 =?us-ascii?Q?G0adbKLtbaF2bA+9ZFifOuD14zXWsfgKQ4HNRtm1S/nMG6IN9HTKWB0R601D?=
 =?us-ascii?Q?Y/+YPIwMysePE2x1vOnCv1rDtDEwcpbsqbHEXjTrmwD+rZmdII8uRaYwJOC/?=
 =?us-ascii?Q?D4NAgdjJII9t80fp/KbhaI0prfVi1w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c294cc7-d183-4cdb-85e0-08d8c6902987
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 09:02:55.1860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk3BMq7eMb/qwGY/3Ph9scNCBnTffsLL7igkKgkUXIYdZt5WCXJmtxRewV6IoEcaQgmAHCMlm9oTkW1GIkcDeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 01, 2021 at 04:33:40PM +0800, Du, Xiaojian wrote:
> This patch is to fill in the data member of v2 gpu metrics
> table for vangogh.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---

Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 6d3c556dbe6b..4726cac8d824 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1422,14 +1422,17 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
>  	gpu_metrics->average_cpu_power = metrics.Power[0];
>  	gpu_metrics->average_soc_power = metrics.Power[1];
> +	gpu_metrics->average_gfx_power = metrics.Power[2];
>  	memcpy(&gpu_metrics->average_core_power[0],
>  		&metrics.CorePower[0],
>  		sizeof(uint16_t) * 8);
>  
>  	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
>  	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
> +	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
>  	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
>  	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
> +	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
>  
>  	memcpy(&gpu_metrics->current_coreclk[0],
>  		&metrics.CoreFrequency[0],
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
