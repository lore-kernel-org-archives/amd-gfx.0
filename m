Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8129C47094
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 02:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CCA611BD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 02:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CCA611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E069B6EA88;
	Tue,  8 Jun 2021 02:19:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5B96EA88
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 02:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmDB+yy3oz+gu8xc+92nnLLk/ILEKsTDoeHFlWdix0fxjIhH57paqZwTfbpiYccNPbFd4ZALPjqVzcYJWE6qNFuXmMC9nnq5/MEeas4xZIbC5PYsO6G/QH9FKCyvvbOhibO+5n4BrdosI+o1ftNKiJ71HEIyGgcTold1xNinJ3t9LXTBAEl7hZns3DcrUCj4lZ/H5EcITUo+H8BX+nQY4LlCye1X44rLrfTf/0pcIIzqRY9h9hWh2D9nyGPQSTjl8VT51EIaLnPqnYZDctCOoW1NermHz8uXszUYzcnmGQ0+YrU8l1SDX8/8IGAymNT10R83g+oHAT5IHkfm9E1FqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdguOMNuKLLFwqn5hMy7XrUv1voVXuCDZ+D5H8kNA6M=;
 b=RDfjRZe0juJKV5zw/M1fjHAqxKuTHnMn8zAq5ZxDDcbIWfZFsOtjPDEkW8jgBHBqBFIB/CQN2i/HYncPW0ICqRUeStiAVUIBd4dx3DThxrX9RLW/bvNWINVzta2yrqWCaKVWl9ZEYMDXU8olyuwTRQ9xE/Y4TitBOm1PsGbEzBdfl5aFUiZYWwT68Jye+PvE3pymaGWFN2PsOu0350I+sBV0s4MG+d+wwwIcfN5xetvHKXoJdotzUoiJ5OClt/psRa7fCkxs6f1612ck8K7ZBZKOB/UvboPCxZcOyUK1tCpQM9xCPRq7L+wyPpBpDLL1tFSkg0bPsZ7GXAQJ2QvKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdguOMNuKLLFwqn5hMy7XrUv1voVXuCDZ+D5H8kNA6M=;
 b=XeoxkCGOs6wwK/JnHONZNBBwBlCRte56EpwBw4EbiSMB5SN8+OpXXRAuSSECXCmbAKR0aP+8uY5xnvstYk/6D4TYVj/+EGGU4Kmn19v8YJsFVCCHvv1QrrTmbcdeZqJD+faskQxu+3Apm3tl3uElPfQZM4m+vC9m6avt9rrnVZU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 8 Jun 2021 02:19:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 02:19:45 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 9/9] drm/amd/pm: Add aldebaran throttler translation
Thread-Topic: [PATCH v5 9/9] drm/amd/pm: Add aldebaran throttler translation
Thread-Index: AQHXW6NhBSjOoCQspEG/Lzt9fkkfBqsJYgJw
Date: Tue, 8 Jun 2021 02:19:44 +0000
Message-ID: <DM6PR12MB2619E56750872D1CA71211EBE4379@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
 <20210607134439.28542-9-Graham.Sider@amd.com>
In-Reply-To: <20210607134439.28542-9-Graham.Sider@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-08T02:19:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a44c0bc2-41a0-4c2e-a0bc-21c48fbd4c1b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920bfc0b-c77c-4cb6-e26f-08d92a23e1e2
x-ms-traffictypediagnostic: DM5PR12MB1353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13538AC28D9B2EF0525D5C69E4379@DM5PR12MB1353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMIgMEy6U8P31HgKBCVJ6Yop6WJCmK9xUqFVCYI0HDSRWLJikUSvi7TcW4RHTWRe6hMxJ/a3Z0oIVdiqJvZJTS52LnLMQE+d2GJsO8pT0iHTy9w39vQcX+thEM7ceow3QWMlabAK8ejoEJ0YGIo+5zUaoqvdP96PlxinpJSaa9XYXem9V+yC0EVdciy/fh3/LepSJ+p8G863/09aHGEpQibpTX3c2WLtUR2i7UoDGXYTXZAKnLV1Qfh4dTvGabR3eMSKhLdPAXoUfx/wdT8OaRFtinQT5hVp7tZul8cJ3hBh0IouJ4Ctz/wFH174fWGPUUeYc+hVki+TYwAdMemQgr2Daia7kQLPtLo4FeFccGOvukXisa+WNs60FWMH/B4W1BVCu9jRZQ8J5SnqSlRO3yf7a6FD2zgRWs9YYgUEF8geyS2GIUqPmiqpyCe+IDcuVeKHmjAnkwqkF/KbKBG4HSBi2aS7bvSlp6m/EG1bnh2RPzIhyCosrrp57ORKcN0b2sWkDKbRw6SCG3V/8xeK6MVQL0ZAHLwy5dVfV/4Jug5a5HftdmCdwKEO5Ptl58dQ1QM2GZnQ2L2tm/5snyh95a99hDwb+kF4RKUfL5e1W4Q2iS2W6+kTdO4pUzRrAZQTsT2dnqBfVO9Qg1oc9cpXsbXn2LXb5v8iBffHwMqNCc3qSZNLDt++kM2gWKR0MnbVpIjGaAN83PpWH4BaznNmtlYPn+1ybsLrT+aVhSy57Hk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(4326008)(5660300002)(55016002)(110136005)(52536014)(54906003)(7696005)(316002)(2906002)(83380400001)(6506007)(71200400001)(86362001)(186003)(9686003)(26005)(122000001)(33656002)(8676002)(478600001)(8936002)(38100700002)(64756008)(76116006)(66476007)(66556008)(66446008)(53546011)(45080400002)(66946007)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A5lPVwywPmMM+rN+E4XClvqgQ18f3oLsSg4mznUrYwBlT9Oy6egsOfojjso/?=
 =?us-ascii?Q?FLKsPUV4RO6ue9tLL2h1VPUtpTcozj3qcv/jMFriZRoFNjziwthZYvg4WjyW?=
 =?us-ascii?Q?gHEmqbs9zyA9H+JczETeh1KPugYrv0b6nczvfpHNG9iFvUW+RSBqvj+AIc42?=
 =?us-ascii?Q?qS0mNlvp01RVoax3HrVLfjYSGyna2siW2aCB9C+rPOyFJwnc1CRy54w0i7l3?=
 =?us-ascii?Q?MRRGPh8wlGq1M20Fir/ZbQpBgz5bKcyIkn/YMGR5yiATxSzGebwVdvcbeXXq?=
 =?us-ascii?Q?JGsSgIwiKcGrwy3KXqQB4Cufbx/SVRqFtfa1iY10QkS5C0dy7/pY8cCuKbmi?=
 =?us-ascii?Q?59c/x8fC0dxhNWV88cRdkg6dElXlt7vjm/AUVOhth8XwFjzoukSzaN9Fv95y?=
 =?us-ascii?Q?Jn6cRBsZeiyni253gG6BMP/itIt5k9EDgA60XG+sQ4is7q3Pp/AIa4hVCk5c?=
 =?us-ascii?Q?gLMErPtOPJF6mj8GZ1HL/pDffNdD6RgK7O6OuKuEtApOqWY4qiXeeE/zXEGV?=
 =?us-ascii?Q?iwBdwXKqnl/v1I8MhjmcM/A5K7XUE8gDt630I8kzC8TV2WAfUS2sJnYuEPXc?=
 =?us-ascii?Q?XeGLv8MEE6NJjHgivHTGynxpoU0feERDy40cnF3+N3kZNyW/4Sv6dPvQix13?=
 =?us-ascii?Q?vFyPNk568tU18Hf9pyEv2AVAlr/WSp2dWbXJ1k46xODZQMvgX1B9zrPdx8Rt?=
 =?us-ascii?Q?nbRciejcwPhurEziBPQgXCIzcWUppRHOPy7RogJpP9NkAtiJsJB3K3lsNU2/?=
 =?us-ascii?Q?4c/sYpyIl/zi4SQfq3B03LP9aJWuhVvipgoKCFgzbvUCFklmRO6wa4EejiQd?=
 =?us-ascii?Q?DNocyyIxeZztPz75edywciJBogN+LRPw3YiD+TZYwARNNxoKRmTvgFwAU7gf?=
 =?us-ascii?Q?3VHaQrzwII7bpEtlKNGAQC05S+rpqvAPjU0i/OjYUvwhA+zcGPn7RxgtzhzN?=
 =?us-ascii?Q?mCLxIZAKNObuFgR1zvMbM6HAzqNhFXnPtSCleXw4kNBWi4dpqKEKjvsVsaOp?=
 =?us-ascii?Q?mR1QZvPj8O/7V+yxPSIOOBkXqKAaSejJvaav/JpRtG81R1T/lf2/fFGLSkpl?=
 =?us-ascii?Q?bRWN5oWVaOMYAQ4bHI6SquFE5A2IoVCP41Aud3zSh5u9f90A+nK6YXjk9vYy?=
 =?us-ascii?Q?f0zBg+lMvYFxUi0PHr7Kj826QdylpoLZjiOr9ALQW0E/rzZrHieCwOcRQKCw?=
 =?us-ascii?Q?IqOV1vDKbMyl180uTYMGQQ+M4W4Nc3CBYlJ1yEZmDS1AoQMf1S+REcaCer6N?=
 =?us-ascii?Q?N+oHuVFYPP9hl+rZ7/NzAYr5m6BC92RV2u8HSjSa9ni1K1/9GmX/yUzvuTFj?=
 =?us-ascii?Q?zD6FR51EvV/KYsUHok7WM/Hm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920bfc0b-c77c-4cb6-e26f-08d92a23e1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 02:19:44.9391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7y2wPxjo7VzWjXWby6gngq6B+kbG5TVLjYisk8bJL0x/8z6JjE8cFDqWAgJr3RF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series seems fine to me.
Reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Graham Sider
> Sent: Monday, June 7, 2021 9:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider,
> Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen)
> <Elena.Sakhnovitch@amd.com>
> Subject: [PATCH v5 9/9] drm/amd/pm: Add aldebaran throttler translation
> 
> Perform dependent to independent throttle status translation for aldebaran.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 27 +++++++++++++++-
> ---
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 7a1abb3d6a7a..0845d4b30a0d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -191,6 +191,20 @@ static const struct cmn2asic_mapping
> aldebaran_table_map[SMU_TABLE_COUNT] = {
>  	TAB_MAP(I2C_COMMANDS),
>  };
> 
> +static const uint8_t aldebaran_throttler_map[] = {
> +	[THROTTLER_PPT0_BIT]		=
> (SMU_THROTTLER_PPT0_BIT),
> +	[THROTTLER_PPT1_BIT]		=
> (SMU_THROTTLER_PPT1_BIT),
> +	[THROTTLER_TDC_GFX_BIT]		=
> (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_TDC_SOC_BIT]		=
> (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_TDC_HBM_BIT]		=
> (SMU_THROTTLER_TDC_MEM_BIT),
> +	[THROTTLER_TEMP_GPU_BIT]	=
> (SMU_THROTTLER_TEMP_GPU_BIT),
> +	[THROTTLER_TEMP_MEM_BIT]	=
> (SMU_THROTTLER_TEMP_MEM_BIT),
> +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> +	[THROTTLER_TEMP_VR_MEM_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM0_BIT),
> +	[THROTTLER_APCC_BIT]		=
> (SMU_THROTTLER_APCC_BIT),
> +};
> +
>  static int aldebaran_tables_init(struct smu_context *smu)  {
>  	struct smu_table_context *smu_table = &smu->smu_table; @@ -
> 213,7 +227,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
>  		return -ENOMEM;
>  	smu_table->metrics_time = 0;
> 
> -	smu_table->gpu_metrics_table_size = sizeof(struct
> gpu_metrics_v1_2);
> +	smu_table->gpu_metrics_table_size = sizeof(struct
> gpu_metrics_v1_3);
>  	smu_table->gpu_metrics_table = kzalloc(smu_table-
> >gpu_metrics_table_size, GFP_KERNEL);
>  	if (!smu_table->gpu_metrics_table) {
>  		kfree(smu_table->metrics_table);
> @@ -1713,8 +1727,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct
> smu_context *smu,
>  					 void **table)
>  {
>  	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_2 *gpu_metrics =
> -		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>  	SmuMetrics_t metrics;
>  	int i, ret = 0;
> 
> @@ -1724,7 +1738,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct
> smu_context *smu,
>  	if (ret)
>  		return ret;
> 
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> 
>  	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>  	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -1755,6 +1769,9 @@ static ssize_t aldebaran_get_gpu_metrics(struct
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
> +
> aldebaran_throttler_map);
> 
>  	gpu_metrics->current_fan_speed = 0;
> 
> @@ -1776,7 +1793,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct
> smu_context *smu,
> 
>  	*table = (void *)gpu_metrics;
> 
> -	return sizeof(struct gpu_metrics_v1_2);
> +	return sizeof(struct gpu_metrics_v1_3);
>  }
> 
>  static int aldebaran_mode2_reset(struct smu_context *smu)
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C1360514bfba14bf2f
> 7b608d929ba82be%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37586703300653696%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> xCJ5F1UI3MGbeMuKd0pXzQljcYncretn%2BcUFMGDi6yg%3D&amp;reserved
> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
