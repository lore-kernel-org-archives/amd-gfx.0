Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE5C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 13:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4C423AA7
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 13:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4C423AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76F96E03F;
	Tue,  8 Dec 2020 13:08:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C15E6E03F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 13:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJzQelZI7dSAjHArTgycsz3ya8H4XMeiWVmRHao/OJxntvw9+fM6fg87sfcIIJMOZnQShY52/VqDBTNW+8aI1t3Ai0cth0YV2yUdxUt+tztLbErFuHY7GgXQFtNk3QNGhXY0DiutfpOw1Fp1j885HSGY9G+g0Y7urWXD0NWmudBen23br445iiTht2ejJDCybj+rX3evT9fhq+/TTlowqmcru1OJF4DTdGJBWDoRcJZToUvYF1Z2N4XH2T3VJfJja6iwDE/Pe+2qUhgh5BxFVq1e7/aIs1qZYJFTRbricIC7NK2olVG8LQs0chPZ58XoWHnjKbunVzoJGXmz9L8izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lbs112MDBKdD4y3ZgDoyZ3v6nHZh+9fMZmiGz7LfQA=;
 b=eWknYUem4iL8PDWf7YaAaUXb+oLOyo27wSmFi8bJro7uQ7Dme4vB9FD9HDwE65C3WEE7acrJg68MI6DKeBvC7hgkp20gcSeOszWUkXf6m5QoElP03pAmgbCfqvgdkvbiOiNpOLYxgDQtjbTDdSGKs4642VpvYq1srzDAqDgcOnbB/IHa1bX26md7+dOUsODqOWpg7pMfSMOu1ywqE4m6NbyXulDu3HkEs+d0hn0f5C9qlbhDLzSOXoMv+497580PaMEU0pcjWuvFsmvTwRHwwhQ0CWRKuXoS3VE1p51Xr0Ql8S2yQZfj9OOHoF6WdrvAwadd3yyaw/g7UXFZYh/P0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lbs112MDBKdD4y3ZgDoyZ3v6nHZh+9fMZmiGz7LfQA=;
 b=Ma0Kf8keFFPqOVrfrt/dbeV3lQZMteFxnfy7lbdvwL7kd9IPGXZRo/WDIZZAS98Vual6+DXSCHY3z5Qy+1h5nctEiM5Xjt5/1HPVG6iuaN3S0MCD3wNXONtlnheCYlcqvF8OymJsm/JWgVfLlUU9XqZsA8DskWaHfGxlHGRT4vA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Tue, 8 Dec
 2020 13:08:52 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 13:08:52 +0000
Date: Tue, 8 Dec 2020 21:08:47 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before
 start/stop rlc for vangogh
Message-ID: <20201208130847.GD661395@hr-amd>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
 <20201208111942.6292-3-Xiaomeng.Hou@amd.com>
Content-Disposition: inline
In-Reply-To: <20201208111942.6292-3-Xiaomeng.Hou@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 13:08:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7d75337-fbca-4621-2ef2-08d89b7a6940
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB43649BC95F6E45870F0BC88FECCD0@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptIo9xcNmb/syDo50IHs4w1pgHspAnwjVpW+8jBN4Izl0KFBmmBYRGU4Oz3TXyTy5DmSrXfB5KlbTFgJs0ZHnKT23sRMPHhSRVpuwWvu7B1vbLQbUDqY0Lhx93JwtHbM7IJso8r+Z/zHWZQL5bli72ah+Q/JAEy0mNRvsGoMn0OaHRDn1lILHUQAmvZdhmXdH3YM/fcvrb9xHr7C8DnS5eqdfGBSddAh+Pn4Kbx8KF9TNzwVShoJGDjQteUlOtEZ1tl57CPx3eWHkLfU8qFuHLhPfhrsnhGf/NOhqCQlspK3owKkFpq0SqL7MXB/AccokLc60JgJPePeARv1Ugr+/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(186003)(66556008)(1076003)(26005)(66476007)(66946007)(16526019)(316002)(478600001)(54906003)(8676002)(33656002)(6636002)(956004)(5660300002)(83380400001)(55016002)(6862004)(6666004)(2906002)(9686003)(6496006)(33716001)(8936002)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4HPbFfl6k5wZ+tINYEtoBnbfa1SYH32sd82+5KA70F0W44CjeofOHy+PJdCf?=
 =?us-ascii?Q?0uDAH+Z0j+mharndkT+XjcBKnpERSZKAcSAfssqflcC0K6FZ5QGmPu+203wI?=
 =?us-ascii?Q?uNC9ykSqJhgNCXF3rXWFG0rKOEc+nJTDRwPxW5mdjX4oUa7d2BX4rBqa49Hw?=
 =?us-ascii?Q?dtb9I1N98qDRXH6N+0tbMviexBaFogG/KSPwdTVI8/IfrbRYYX55XbuC4qQm?=
 =?us-ascii?Q?w95zdP7c1w8QiPd9Ci0DlNzOoH7YDBTYpDVYKpBQiTx23zq3TLVint4EJB8h?=
 =?us-ascii?Q?+aLWf4C+CbTmYhRcfvVXH7Hai3JBz7MU9RdMIype22jQr7x4czCWOLFOLrXk?=
 =?us-ascii?Q?MCZF3SnIbZRDUTQNTnxFb/n9w1PhhBokz9LiKx9FE7OheB4WTqalnUeHocQw?=
 =?us-ascii?Q?SefB7yDGP+TMJVJoPp7s180iQjLhkRy9L0tJy4RvVR/rrP6NJ/rAeOcODIhC?=
 =?us-ascii?Q?D78NKUjJC+jcUl4DEWEFUxnN8HFimTc8Tk8R7CcVnIGgd60FpfPHHLIoIopn?=
 =?us-ascii?Q?l4XgkFde+mhkFSgQYoynvK4fHSCUILvH1wlHTcy6NoQEqddfoKjlRTYiq/w4?=
 =?us-ascii?Q?NX7HxDKA9nSxtxOSlW5KmhcgdOd1uk6+a9LB+K6O/SihlIdfSYfnRm8kejZ2?=
 =?us-ascii?Q?UyUdo445PoyhMI3Gd84eSXPFHvdksWQ/bjN3oel3ZI7S1VaYVwZBBglpfYnp?=
 =?us-ascii?Q?PGqYAbTdY2j2g21Eka0ayC0KHL/VfGcHM0nntM+t5Rnh1wMojVDZsT0zBQNR?=
 =?us-ascii?Q?BAxvxq91C4iLjo1SWSoxAmenBbjrFDcoAFapqoliqQD1sY5jhAE1vA595VSL?=
 =?us-ascii?Q?R/l9aG/jutTf7G3Gxklktp8ytpV7GuzMdvuKP5t4oMRIZtcg1kYCpT6GfCWD?=
 =?us-ascii?Q?kvZ6qKztVspmwqtUwKEV4gZiUhnDI+dFJW0WEJGIwvcm5XRX8rewkSRz/CfD?=
 =?us-ascii?Q?p0lTIQ1cuX8JvntduvUizgjA5VuTn00YgvoH0/KkW352pW2t7OLyGOmSMDBR?=
 =?us-ascii?Q?cJwD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 13:08:52.5535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d75337-fbca-4621-2ef2-08d89b7a6940
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM1cHCAIbjlSkybAe5Wa+u5RAd+8FM1ca0PkiJwnNonncoHZfKEDvyIFE4SI7webHs9cd5neLf7LtjX4x2Q43w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 08, 2020 at 07:19:42PM +0800, Hou, Xiaomeng (Matthew) wrote:
> RLC is halted when system suspend/shutdown. However, due to DPM enabled, PMFM is
> unaware of RLC being halted and will continue sending messages, which would
> eventually caused ACPI related hang. So send message to inform PMFM the rlc
> status before start/stop rlc.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> Change-Id: I7b1a04f6e249ac6753109079ecb3019c99161d9f
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index cf999b7a2164..42a32c0e5bab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -920,6 +920,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  	uint32_t pcie_gen = 0, pcie_width = 0;
>  	int ret = 0;
>  
> +	if (adev->in_suspend && smu->is_apu) {
> +		ret = smu_notify_rlc_status(smu, 1);

You can create two new callbacks in ppt_funcs->inform_rlc(smu, on), and set
on as bool type.

Then you can use below macros to implement this callback with RLC notify
SMC message.

/* RLC Power Status */
#define RLC_STATUS_OFF          0
#define RLC_STATUS_NORMAL       1

Others look good for me.

Thanks,
Ray

> +		if (ret) {
> +			dev_info(adev->dev, "Failed to notify rlc status!\n");
> +			return ret;
> +		}
> +	}
> +
>  	if (adev->in_suspend && smu_is_dpm_running(smu)) {
>  		dev_info(adev->dev, "dpm has been enabled\n");
>  		/* this is needed specifically */
> @@ -1213,6 +1221,14 @@ static int smu_disable_dpms(struct smu_context *smu)
>  			dev_err(adev->dev, "Failed to disable smu features.\n");
>  	}
>  
> +	if (smu->is_apu) {
> +		ret = smu_notify_rlc_status(smu, 0);
> +		if (ret) {
> +			dev_info(adev->dev, "Failed to notify rlc status!\n");
> +			return ret;
> +		}
> +	}
> +
>  	if (adev->asic_type >= CHIP_NAVI10 &&
>  	    adev->gfx.rlc.funcs->stop)
>  		adev->gfx.rlc.funcs->stop(adev);
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
