Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876EAC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FFB61359
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FFB61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EA589B11;
	Tue,  6 Apr 2021 09:23:21 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5294A89B11
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 09:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNHDyffkOqOn6RyBFYicTgf5jt7UspjHYuPGgircAElMjUPmaxI6MiR8XHsb+yctFTnPKaIIw9O3UW8R+jIdmxZgXeme9qnLOASar5EbBnIeDCOs9Y/bgZDbOGsCelY1uU3a/iHns5TequYuKcvT5pLKDPX3UKLWaPak0r37yaGsLvwJYJu1OlO53k80pP3nzVaSzAwo381uLc5uKuvnv4aOAAN4pvv9tuyB0kkpEksJT64QxcInTOwW5arrwv/srwT/XLEf5UyFTeYSv3WuKspVjfCtRSryBd8Eg/t83ChzceJg83WNL6MrbcO3mndQy/s/0PtxL1UuzazFweRGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXq6w+r84jvM9UiU4QVt8lyfHUTXIPdD4DlTmE8km4o=;
 b=ENFYeV7sB9E/cslDpL3q4hIkM6qxRP5NjQoorZNFfsPqgCvEC8ziGOJE2POQG301USN9DtvZCnJ/WfGw36cLfgGjTN//CQB6KVnXNyzZ7tXQrBQw2CK99el4FSeIEvp8Mg3IeJnckK6lVcxU1XUrJ6ygYth5eQyzWGItCGBCcHlbOnvuQSVKUCIqUoA9DeFHehxAGF/RzbKzEC0Fv+PdAKBwAq5XOv75SeWjnVH7rmeX0GlDkYM2uPYVci8ven7k0v5Lo7DigbBCrm32/gMzKijia7yA46i4xXi0f8UFzOO/yfN55eZq3CLiJnR/8KjCwBabI7VgagAexZKYvZJVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXq6w+r84jvM9UiU4QVt8lyfHUTXIPdD4DlTmE8km4o=;
 b=D7oTSXXfmuIgfAWgXqZ/48yNvLBxkvrnaO4k+RfG02qQG2Y7EEYvMuhcvEVVfH+VV+RDI6JlDnJyB6qLuei3e03J4uL6luP9RqkVi76JZCxdCH0OBVfZbOrMMKNLVmomnWnz7/a38NAsgTdxftApa6yIhLSJRgk8QE4oOzdGxSc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 09:23:19 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 09:23:19 +0000
Date: Tue, 6 Apr 2021 17:23:12 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx9 rlc modprobe rlcg program timeout
 issue
Message-ID: <20210406092312.GC456630@hr-amd>
References: <20210406072948.26470-1-Changfeng.Zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210406072948.26470-1-Changfeng.Zhu@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 09:23:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2e24d3-b28b-4510-831a-08d8f8dd9dc9
X-MS-TrafficTypeDiagnostic: MW3PR12MB4362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4362811738A2AE5D071CD68AEC769@MW3PR12MB4362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grp3RBwRNlE78C9DnkQwtVwRaXaSIDk7CzUmplGCpSJleDvalVYbTEhOA5QJu9adTegbJHyAjxCOSOJwAMuAuHqUmjNFwxMbgeBzwHLZx2bo+1/ubmS2CsMcMthWIJYoWUE/j4E/zmmLzW8F24E9AyEl9ntQuYfEiFftBWwi4KjhqC9DyOhXGA0nnsIG38Sre32yu9eb9eXcL+EnQBlziCG1oyp7/Gu70EHyoF5RQY+XmGRVlj7v5Z9iM3mQSmb1Bwaawzy689sB0kUJbqrNOpLnKdVmya5tWapvQA0DIEJRwiriIvjqPhdDli6b2MRQB6vu4O1xLXIOblmRQAQ1EHzV4yP235XySRXamc/p92UAS/efkHu8F9X29VzaiFol7rhTNdQifgTvlMYnODa44llBbuPgGlYB2SZm9nuKKobcEni4YAqXWeRGLttJ9XHU1fFN+M1BFSK5cSCobCN/b9PLRF/9laJMx+plqqHAlOi7i32RSczKVwWg06IIm2AwrTSdmXGYYoxumvRzhDvoLmBgsBWBPhtxmlfc9/JfEPUjQAqQ1Xshz0WyobqmxpwV2mzzKFZxCOXY3wcOEVK8XCWnPhcD3U7KL25qMtIIaSHtTivVsX1qvREBXshADYo8CfNa9DfSU7MSvvYzh3mOz6eqT4wvgs3fqNxr81pZGJpXGY4XOr/+c+m0dcz+519E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(396003)(366004)(376002)(136003)(6862004)(316002)(38100700001)(33716001)(54906003)(33656002)(16526019)(66556008)(38350700001)(66476007)(8936002)(186003)(52116002)(1076003)(478600001)(26005)(8676002)(2906002)(86362001)(55016002)(9686003)(4326008)(6636002)(6496006)(66946007)(83380400001)(5660300002)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6v78H4wQhfPcen0F41o18Rz7OucMiOWJVnv6bzFk034cSpKMmFtWLHeE3k5a?=
 =?us-ascii?Q?F4ikDAlr7pLBkwa7mN2WXgDqpHuNMzo6r+4OadPcM5wsbLS1K9WyA3xhIH0S?=
 =?us-ascii?Q?iO2tKIhngDOG5inU2CTy1S/wUwVC/DHAhyp3a1YWyLGBZIRnFHwUOSMVnXUb?=
 =?us-ascii?Q?0vLxXzmEPLkteqtJREFE63HCkXeMjreaWUL20Zzm/6h3XhIYPfC2++THF+Zl?=
 =?us-ascii?Q?I/C3vq0U/wKn+Zausp6hFpXsAE7/KcbUSJC1bQ5ClXk4okKU7Du0x4mOg6SQ?=
 =?us-ascii?Q?E8NKn+XE/SJfiRp84aQEO54hu8+DALah/giTVUlIVg6et+6OuQFBK6ep98ku?=
 =?us-ascii?Q?vXgFJFnysi4BqkXgWKUDfbjD3+v+a0g/l3qX/NLPdjR3P4UOmUQRyTIuN04n?=
 =?us-ascii?Q?7+nLFgayqH/dx8yEogWC88GhJslFmxsB831DHW3W50KxKg4775Uy9+XbcgeS?=
 =?us-ascii?Q?yEBlfCRmuV3LsdMwjE/zLxc87HpA6Su0YYxSMba5vdRxQGnHDHdgLguiUDnS?=
 =?us-ascii?Q?avq9UHta19ZGwpImtt2ewiufGITdjzr9lrGkr/CnBj+O0CiavJ2SX1yyNKFF?=
 =?us-ascii?Q?h0/ZrSJ7RW9YOZfdjHvl+tSCS1R0Q0YINx1Kc3FQ+FRmYdRSWqrmZAHuKwTZ?=
 =?us-ascii?Q?QQm9O6fqMRvmrS2hANZJaDOfZDkG8zTWWgH3HWo7mIuPzKUVO2oTTVj0nfIH?=
 =?us-ascii?Q?zroS5aGfg15BiaF5u/16MPZZtaQH7JDclReIsG7LXO8eh8+MqFy6PspPS/qy?=
 =?us-ascii?Q?Z8cA65T1E8pcgCJfhyhv8SEm4FyARSFLRdysrHZefcuUcRqY9nF1cAR4Uvmd?=
 =?us-ascii?Q?VLZ+Aa0qI+s6K0TaTfstZfUc01fssobdsYR2g5Or4rKvHN2P27JdaAjH3JdA?=
 =?us-ascii?Q?h4BMVMiM2H9AzLZGVwzDFNV1cyNJYm1Pn7fL1Ho6/3OpxIrSq4PBlV0KvWKJ?=
 =?us-ascii?Q?0rBKREJXA7KOGKZNDwoKC6I6fYMCqv6T8xpAAT4vE60aht/W+XRxAockOQBv?=
 =?us-ascii?Q?A9+NM9Rylr3yMLYhWvS+3VVJrLfcWSdQezXsDC73Le5j6JbyNnedZ9A342nI?=
 =?us-ascii?Q?kV+gaA9iJowEyRVE5bDlNX/duwHBNOFIkYEtWrxDg7tqYjU79Saii9RFJwVZ?=
 =?us-ascii?Q?akH8GrVdq3i1apy96+2I8iyEgjbtBVw0ln8Eg4JNjagg/akpdVRektb29Bg4?=
 =?us-ascii?Q?TcqE++tR/BU7jsZU1YXzlOJR0yF/G8Oxrx7Q2Lpv8lyI1ACJSFS5ulQt00uO?=
 =?us-ascii?Q?hcam4Hhcg0cGJ3ngt4Bau8O+kaBOIv/LI0zh30D4C2vlAvVNnpw0NPjuAU3q?=
 =?us-ascii?Q?sori6BrIPR9i16WHWqLX5HnV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2e24d3-b28b-4510-831a-08d8f8dd9dc9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 09:23:19.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0SRD4E5Htc5SKhwai6E1IBZy44qrt6xgU6+t8SF6OX/GHHLZPAbIhNrtYywQudD45cQrgc2IolpD/Sjc2ueYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 06, 2021 at 03:29:48PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> It needs to add amdgpu_sriov_fullaccess judgement as gfx_v10_rlcg_wreg
> when doing gfx_v9_0_rlcg_wreg.
> Or it will cause modprobe issue as below:
> kernel: [   59.992843] amdgpu: timeout: rlcg program reg:0x02984 failed!
> 
> Fix for patch:
> drm/amdgpu: indirect register access for nv12 sriov
> 
> Change-Id: I971804e4e8dbd83e4179beefa8ae8a06bd52913b
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2111e4c46a52..06811a1f4625 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
>  	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
>  };
>  
> -void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
> +static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
>  {
>  	static void *scratch_reg0;
>  	static void *scratch_reg1;
> @@ -787,6 +787,20 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
>  
>  }
>  
> +static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
> +{
> +	if (amdgpu_sriov_fullaccess(adev)) {
> +		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
> +
> +		return;
> +	}
> +
> +	if (flag & AMDGPU_REGS_NO_KIQ)
> +		WREG32_NO_KIQ(offset, v);
> +	else
> +		WREG32(offset, v);
> +}
> +
>  #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
>  #define VEGA12_GB_ADDR_CONFIG_GOLDEN 0x24104041
>  #define RAVEN_GB_ADDR_CONFIG_GOLDEN 0x24000042
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
