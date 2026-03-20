Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC9A1099B37
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1592510EBC3;
	Fri, 20 Mar 2026 20:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tNf03dQU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C324610EBC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV9ICJQdYxIkqwPoZelseC61nLMaYN+XfDbgcc2+qqHjCM8OGxPOjxJEmJuy19XyoLdnapvTwN5YYacKi9yk7K+spnlcbQokfdoolUHseLqTdChT1odyCmbIflNX6OLjiUkalKi5b5V74WfkAdAx0qDQDojGuz0r5EMYjpnHP1WjiGmHag8nYbQeuUcFulx7rfikNjl4jT/TB2Cg1OmgZDFaLKM3t91BHlCLkUEj9EWcXV+TjCnJib/XXrSwPegxgl6ay6+SGflxuT2L0wVwjsNNUae1GTOao2XLc4ra3LgflnPbophP7uYqclBwH45i0SWvALYo/9oOxWV1QfMsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc+YmaowsMePPZBs+FOX48IvEqjv/cHhFHM2I3/n9JY=;
 b=a0QYCibyhiMrjaQrbx5FwlVVHcO8VwEqF6Vy+sO/hqUrnAOJFgWok3qyerDWLVo9km6u6OTqzkc+TzOBlYWwrdR0ks3wy86KAGZNOAbuPBRJiPpOqShGGNyXOZQrM98KRjGv8cDHQsylCIXoUHQ4BzhyPMVjtwmL2tB3J6077P63Fi+KA1boDkOga2J/EuS9PjWDnAly4C4UvjPqCRiO0/v4VJ54iVuJB7sDn2Priq/suzLiqNdXQqW+kfSmxoo89tUVMqeLJ86KDQV5s6w+f2I9zeAufQ3jE0X0LkOjLdz2W3saWHEfoXROrXZOHClPOwyBJO6FauYBhJJ7j7xMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc+YmaowsMePPZBs+FOX48IvEqjv/cHhFHM2I3/n9JY=;
 b=tNf03dQUYN61cClqC6afOTrI0Ln3ksW+bNa+XlPgAqePs35lEQVFuoKI9pIR8kuJkbUAcpEgQw7/0MaoqfWOoZRPtMpQ+44H0+a/MDlF9JpFA75NvCM9MtD79mREiS093IP7Z4Bu+sDsP86js4GoaA940DoaGUVyfFNj9onWLKE=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:01:43 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1%3]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:01:42 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Li, Sun peng
 (Leo)" <Sunpeng.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer assumptions in
 dcn42_init_hw()
Thread-Topic: [PATCH] drm/amd/display: Fix NULL pointer assumptions in
 dcn42_init_hw()
Thread-Index: AQHctbtnXN2wyhtlGEWVnOja7roeSbW3pUWAgAA3wrY=
Date: Fri, 20 Mar 2026 20:01:42 +0000
Message-ID: <CH0PR12MB5284705AB614A4578FDA222B8B4CA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20260317030838.1943783-1-srinivasan.shanmugam@amd.com>
 <92dae9b7-2549-4341-a01c-98a5c6c937d4@amd.com>
In-Reply-To: <92dae9b7-2549-4341-a01c-98a5c6c937d4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-20T20:01:42.077Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY8PR12MB7657:EE_
x-ms-office365-filtering-correlation-id: f6043c54-a994-44a6-419a-08de86bb81a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|8096899003|22082099003|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: h+qDGOGoaV3B5QrMGidBqDql9ey07zO8m+xvlrlhkTZGIHY70utgUpVUpnr4xDZ5ZNJIFG5jmcMNtufZdfe2yUfojFXs974VEuVmZnNjfrh1mgXsfRpsPsL+17fRXUsq148+6vYWGNawG3uvtTq+hoCUe/OHqkbXKPv4+5p9b31LUp5wl+6HVEfvWMw9sV+Otwgomr5PeRDLS1G5ScIdFMtpmh91fsNkKO2eoghN0lZlzlHKdqpziutdJkMNuwT5QHlzoqu5vKJPrVYurtU3+rXjl7ruEzRyvquMkeWl7Uet4PkCFDILdozWCvpWFrDfMCtJi9xIBQ5q0dK7LYr6GUdUjqnew4dvWsE8s5P+BOgNizyQ1WwdUHO6CipIJ/AstEJZdxozGDDJStjH7bXuN1ORWsmCGb5insmSDGLBZRkxDs9g0sYjRARVTUW8zamPgGQClJMNZwcoUK+X5kaNHp3xm40InAAQUF6h7KbaFbcgvXb9ErkTjGHh3HE6SB9tUqFqprLF2b1w3TudS5HIfUoceF7VSD1bYRMoBYvX6TzojB2IXRLa4/2GDAWu64G31tFi/9siiK66Bej7LBG9leaNR/7MUKUr4tIvZYHzdJRweA14ebzA7cxDBmVojRXmrivQz8GuSJsJ4XqeV2gxKBfRTSP1Y4X9W3eCwkuR8ziDNDhGRMdgfA4qnvqHMqYpsKQ1VY5ejFObidMg33caOBIW37CdStnuYdALnnX/scEyJ7YU6X+v35nf1uqsvVK4pv/5PjgTatDOKN9GIZjHgMyY+O+VSQwCe8nAVoZNzMY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(8096899003)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L35BV57Lm+OMTZVa3kbe/QhLCy5Unq/N+QvVsKv+W5a7KM9oxwoOTfL0fwEW?=
 =?us-ascii?Q?mGR96XKJiCl5lNPKfPD5P2XgWsw4//YFCoGtvalu0GS/KRRq7OQzMQkIlOp1?=
 =?us-ascii?Q?pw9SiE6VdutN1RpVvJWaAT8/9MVmIAh0OcuJQCO0nY04h6VAsXlxbF+7OY19?=
 =?us-ascii?Q?gdAAWW9LdZGX9AkjN4zcZhTMW+gS4U36HfOWc3bvqBUzAJbmqZsrj7C3oKzK?=
 =?us-ascii?Q?36aZN+Ot98haam7crYaKpuiE6D2jsKA/6/W3AigGa7iOz6l+WgDUuVH/c4DG?=
 =?us-ascii?Q?7abj/fyDYRBkN2A8keokmBuUSoXfZ1HJyOEYEDKiu2zuK44EJv8zoPXY7GOu?=
 =?us-ascii?Q?Bqm0VBZPi9Gnvt+asuDisBCyFy9PHPbdFbx/lz4X1fvclH8tm1wySyxyfvg1?=
 =?us-ascii?Q?s9n0huQM9TF3KFwoWUS10QNwvgtB+eGeKjl9YTwDUDloABFUWekh9QrsOaFE?=
 =?us-ascii?Q?PCkaH+AJ2cxwdOyVOqXxWhD0yiGn4O+sjuRU+uvpF6xLGtjqlIr1wlQLmiR0?=
 =?us-ascii?Q?xYhKFAuSJL254dvlWeb1+K5WAqehhz1w8hzyl7WiOUcQao64+VAgSvbkqEFw?=
 =?us-ascii?Q?qGFc7UKQs136iRFWs5lsAEyKOpUcd1KegJDh8m8RD3lkTUZFzFaOG1NBwuaP?=
 =?us-ascii?Q?oUx9K1RmZmIaCB9r+XAKQm4ulk5diOZX480viUukwxNlHPIFq5re+Xlwq1iV?=
 =?us-ascii?Q?Ik983KYpYMzbPzly4Wg2ttosE2HQla8Mc5vjNgKvoZJgVEeLDalr+3gc22DX?=
 =?us-ascii?Q?z4n1BQ0hI3qvci+UvT9JTkwmj+euwMlD2Ye82COZOBf6ZDYtt3ft8U5DjDP+?=
 =?us-ascii?Q?ikUgCZyGXOtAiwstu2S9RiE7YSEl8RZn31j9X1LjQmzb/s94NOHmhQYAFpsc?=
 =?us-ascii?Q?Nk1ZYBS0MgYzP5lr7WewtyG05WdrlCN49SRO+KBOjWwgbm5X0Y0DLZAJCfW8?=
 =?us-ascii?Q?gQl8VBPUTtBiKA8bLnI2CNtBk2jkUzeQ073sl6MjOtCYYhawBEfStha3YQWi?=
 =?us-ascii?Q?NrL9CyzLujN2wEVCvdueSjMx5da3pGuwgjryi08RNBp0dBkQ0HSwz6kHPa9Q?=
 =?us-ascii?Q?TOPkltmquomOvAXaLewQ1h78sgg2Qiy2/64rGd9UtKPF0uKzwnhPf+yEX3kk?=
 =?us-ascii?Q?j17EDdTA+IVc1b1Mdvv+AkfiX1IcV0pV7/88sdbb9bNvr5ek1LmPZuxwlndw?=
 =?us-ascii?Q?hpisuoCrfd8N0lEdQhhZ8OHpPLkRLZ4JtzjbBtQanPiHzBMA3wsT3/x6vJMc?=
 =?us-ascii?Q?b8+G9R0M8clBoWV55Cr4BWojLxObe9esmMbPXXLXe+5QCzcKLEX8hbjJzRts?=
 =?us-ascii?Q?zyMFyCQCEo+gI0+kxlLKuplRTtYBy+3B4g2f4W6xvdEExJMjVkDDUoArbDNE?=
 =?us-ascii?Q?kpIVmay//ZWALmfvLVYagFGoJGhvUOd9rMQqFAT2TdUaOe3P1faedzR6JLyf?=
 =?us-ascii?Q?sypLXMHHqr4M84d3P7k/MtnOL4uEUaNWREZdQUh+0mJPJ3IiKyhVerOtUaXn?=
 =?us-ascii?Q?gkk4OT9pNxyDPqOYhHpq7vboCtTdG1qt65BnU+muwvkRKq1qUyQU/NYj1EES?=
 =?us-ascii?Q?/xU144rlol01BqqK+5FC/+l6MZrhk5+nqPw1tKvFWGx1EzQzxev/ssjbb+Dp?=
 =?us-ascii?Q?K/jQ0bGZnBJ/ef0CKJvoG0YUh6GbQVLuUnWlQmvbC6SeKPCYEH3EzSjrnp5k?=
 =?us-ascii?Q?6AEBJwj33hR06uekzF05LdAYDqZi4ccRKOzMO/MmkQQtKfho?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284705AB614A4578FDA222B8B4CACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6043c54-a994-44a6-419a-08de86bb81a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 20:01:42.5032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTisD9d9iWib7QhuMgFlHwsGiIeIP/X6Kgvqs2pNhJg4IZyY7e6+PZGfKxhreDF8O/jblrgQ8UjsSH7K2NYOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

--_000_CH0PR12MB5284705AB614A4578FDA222B8B4CACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Srini,

Please remember to add Fixes tag, so this gets picked up by stable kernels =
if the original patch ends up in stable.

--

Regards,
Jay
________________________________
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Friday, March 20, 2026 12:41 PM
To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Li, Roma=
n <Roman.Li@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Li, Sun peng (Leo) <S=
unpeng.Li@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Dan C=
arpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer assumptions in dcn42=
_init_hw()

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/16/26 21:08, Srinivasan Shanmugam wrote:
> dcn42_init_hw() calls update_bw_bounding_box() when FAMS2 is disabled or
> when the dchub reference clock changes. However the existing condition
> mixes the callback pointer check with only one side of the || expression:
>
>    ((!fams2_enable && update_bw_bounding_box) || freq_changed)
>
> This allows the block to be entered through the freq_changed path even
> when update_bw_bounding_box() is NULL. The function is then called
> unconditionally inside the block, which can lead to a NULL pointer
> dereference.
>
> Additionally, the code dereferences dc->clk_mgr->bw_params without
> verifying that dc->clk_mgr and bw_params are valid.
>
> Restructure the condition so that the update trigger remains the same
> (FAMS2 disabled or dchub ref clock changed), but guard the call with
> explicit checks for:
>
>    - update_bw_bounding_box callback
>    - dc->clk_mgr
>    - dc->clk_mgr->bw_params
>
> Also introduce a helper boolean (dchub_ref_freq_changed) to improve
> readability of the clock-change condition.
>
> This fixes Smatch warnings about inconsistent NULL assumptions in
> dcn42_init_hw().
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:264 dcn=
42_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see =
line 253)
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:278 dcn=
42_init_hw() error: we previously assumed 'dc->res_pool->funcs->update_bw_b=
ounding_box' could be null (see line 274)
>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: Sun peng Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index 8e12dc1297c4..e307cc6363dd 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -69,6 +69,7 @@ void dcn42_init_hw(struct dc *dc)
>        int edp_num;
>        uint32_t backlight =3D MAX_BACKLIGHT_LEVEL;
>        uint32_t user_level =3D MAX_BACKLIGHT_LEVEL;
> +     bool dchub_ref_freq_changed;
>        int current_dchub_ref_freq =3D 0;
>
>        if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_=
clocks) {
> @@ -260,8 +261,12 @@ void dcn42_init_hw(struct dc *dc)
>        if (dc->res_pool->hubbub->funcs->init_crb)
>                dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub=
);
>
> -     if (dc->res_pool->hubbub->funcs->set_request_limit && dc->config.sd=
pif_request_limit_words_per_umc > 0)
> -             dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool=
->hubbub, dc->clk_mgr->bw_params->num_channels, dc->config.sdpif_request_li=
mit_words_per_umc);
> +     if (dc->res_pool->hubbub->funcs->set_request_limit &&
> +         dc->clk_mgr && dc->clk_mgr->bw_params &&
> +         dc->config.sdpif_request_limit_words_per_umc > 0)
> +             dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool=
->hubbub,
> +                                                            dc->clk_mgr-=
>bw_params->num_channels,
> +                                                            dc->config.s=
dpif_request_limit_words_per_umc);
>
>        // Get DMCUB capabilities
>        if (dc->ctx->dmub_srv) {
> @@ -269,13 +274,18 @@ void dcn42_init_hw(struct dc *dc)
>                dc->caps.dmub_caps.psr =3D dc->ctx->dmub_srv->dmub->featur=
e_caps.psr;
>                dc->caps.dmub_caps.mclk_sw =3D dc->ctx->dmub_srv->dmub->fe=
ature_caps.fw_assisted_mclk_switch_ver > 0;
>                dc->caps.dmub_caps.fams_ver =3D dc->ctx->dmub_srv->dmub->f=
eature_caps.fw_assisted_mclk_switch_ver;
> +
> +             /* sw and fw FAMS versions must match for support */
>                dc->debug.fams2_config.bits.enable &=3D
> -                             dc->caps.dmub_caps.fams_ver =3D=3D dc->debu=
g.fams_version.ver; // sw & fw fams versions must match for support
> -             if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->f=
uncs->update_bw_bounding_box)
> -                     || res_pool->ref_clocks.dchub_ref_clock_inKhz / 100=
0 !=3D current_dchub_ref_freq) {
> +                     dc->caps.dmub_caps.fams_ver =3D=3D dc->debug.fams_v=
ersion.ver;
> +             dchub_ref_freq_changed =3D
> +                     res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 !=
=3D current_dchub_ref_freq;
> +
> +             if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_=
changed) &&
> +                 dc->res_pool->funcs->update_bw_bounding_box &&
> +                 dc->clk_mgr && dc->clk_mgr->bw_params) {
>                        /* update bounding box if FAMS2 disabled, or if dc=
hub clk has changed */
> -                     if (dc->clk_mgr)
> -                             dc->res_pool->funcs->update_bw_bounding_box=
(dc, dc->clk_mgr->bw_params);
> +                     dc->res_pool->funcs->update_bw_bounding_box(dc, dc-=
>clk_mgr->bw_params);
>                }
>        }
>        if (dc->res_pool->pg_cntl) {


--_000_CH0PR12MB5284705AB614A4578FDA222B8B4CACH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
Hi Srini,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Please remember to add Fixes tag, so this gets picked up by stable kernels =
if the original patch ends up in stable.</div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hung, Alex &lt;Alex.H=
ung@amd.com&gt;<br>
<b>Sent:</b> Friday, March 20, 2026 12:41 PM<br>
<b>To:</b> SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Pill=
ai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Zuo, Jerry &lt;Jerry.Zuo@amd.com&g=
t;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Chung, ChiaHsuan (Tom) &=
lt;ChiaHsuan.Chung@amd.com&gt;; Dan Carpenter &lt;dan.carpenter@linaro.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix NULL pointer assumptions i=
n dcn42_init_hw()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Alex Hung &lt;alex.hung@amd.com&gt;<b=
r>
<br>
On 3/16/26 21:08, Srinivasan Shanmugam wrote:<br>
&gt; dcn42_init_hw() calls update_bw_bounding_box() when FAMS2 is disabled =
or<br>
&gt; when the dchub reference clock changes. However the existing condition=
<br>
&gt; mixes the callback pointer check with only one side of the || expressi=
on:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; ((!fams2_enable &amp;&amp; update_bw_bounding_box) |=
| freq_changed)<br>
&gt; <br>
&gt; This allows the block to be entered through the freq_changed path even=
<br>
&gt; when update_bw_bounding_box() is NULL. The function is then called<br>
&gt; unconditionally inside the block, which can lead to a NULL pointer<br>
&gt; dereference.<br>
&gt; <br>
&gt; Additionally, the code dereferences dc-&gt;clk_mgr-&gt;bw_params witho=
ut<br>
&gt; verifying that dc-&gt;clk_mgr and bw_params are valid.<br>
&gt; <br>
&gt; Restructure the condition so that the update trigger remains the same<=
br>
&gt; (FAMS2 disabled or dchub ref clock changed), but guard the call with<b=
r>
&gt; explicit checks for:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; - update_bw_bounding_box callback<br>
&gt;&nbsp;&nbsp;&nbsp; - dc-&gt;clk_mgr<br>
&gt;&nbsp;&nbsp;&nbsp; - dc-&gt;clk_mgr-&gt;bw_params<br>
&gt; <br>
&gt; Also introduce a helper boolean (dchub_ref_freq_changed) to improve<br=
>
&gt; readability of the clock-change condition.<br>
&gt; <br>
&gt; This fixes Smatch warnings about inconsistent NULL assumptions in<br>
&gt; dcn42_init_hw().<br>
&gt; <br>
&gt; drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:264 =
dcn42_init_hw() error: we previously assumed 'dc-&gt;clk_mgr' could be null=
 (see line 253)<br>
&gt; drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:278 =
dcn42_init_hw() error: we previously assumed 'dc-&gt;res_pool-&gt;funcs-&gt=
;update_bw_bounding_box' could be null (see line 274)<br>
&gt; <br>
&gt; Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
&gt; Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
&gt; Cc: Jerry Zuo &lt;jerry.zuo@amd.com&gt;<br>
&gt; Cc: Sun peng Li &lt;sunpeng.li@amd.com&gt;<br>
&gt; Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
&gt; Cc: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
&gt; Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&g=
t;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c&nbsp;&nbsp; | =
24 +++++++++++++------<br>
&gt;&nbsp;&nbsp; 1 file changed, 17 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b=
/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c<br>
&gt; index 8e12dc1297c4..e307cc6363dd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c<br>
&gt; @@ -69,6 +69,7 @@ void dcn42_init_hw(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int edp_num;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t backlight =3D MAX_B=
ACKLIGHT_LEVEL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t user_level =3D MAX_=
BACKLIGHT_LEVEL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool dchub_ref_freq_changed;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int current_dchub_ref_freq =
=3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;clk_mgr &amp;&amp=
; dc-&gt;clk_mgr-&gt;funcs &amp;&amp; dc-&gt;clk_mgr-&gt;funcs-&gt;init_clo=
cks) {<br>
&gt; @@ -260,8 +261,12 @@ void dcn42_init_hw(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;res_pool-&gt;hubb=
ub-&gt;funcs-&gt;init_crb)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;hubbub-&gt;funcs-&gt;init_crb(dc-&g=
t;res_pool-&gt;hubbub);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;res_pool-&gt;hubbub-&gt;funcs-&gt=
;set_request_limit &amp;&amp; dc-&gt;config.sdpif_request_limit_words_per_u=
mc &gt; 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dc-&gt;res_pool-&gt;hubbub-&gt;funcs-&gt;set_request_limit(dc-&gt;res_p=
ool-&gt;hubbub, dc-&gt;clk_mgr-&gt;bw_params-&gt;num_channels, dc-&gt;confi=
g.sdpif_request_limit_words_per_umc);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;res_pool-&gt;hubbub-&gt;funcs-&gt=
;set_request_limit &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr &amp;=
&amp; dc-&gt;clk_mgr-&gt;bw_params &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;config.sdpif_=
request_limit_words_per_umc &gt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dc-&gt;res_pool-&gt;hubbub-&gt;funcs-&gt;set_request_limit(dc-&gt;res_p=
ool-&gt;hubbub,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr=
-&gt;bw_params-&gt;num_channels,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;config.=
sdpif_request_limit_words_per_umc);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Get DMCUB capabilities<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dmub_srv)=
 {<br>
&gt; @@ -269,13 +274,18 @@ void dcn42_init_hw(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.psr =3D dc-&gt;ctx-&gt;dmub_srv-&=
gt;dmub-&gt;feature_caps.psr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.mclk_sw =3D dc-&gt;ctx-&gt;dmub_s=
rv-&gt;dmub-&gt;feature_caps.fw_assisted_mclk_switch_ver &gt; 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.fams_ver =3D dc-&gt;ctx-&gt;dmub_=
srv-&gt;dmub-&gt;feature_caps.fw_assisted_mclk_switch_ver;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* sw and fw FAMS versions must match for support */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;debug.fams2_config.bits.enable &amp;=3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.fams_ver =3D=3D dc-&gt;debug=
.fams_version.ver; // sw &amp; fw fams versions must match for support<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((!dc-&gt;debug.fams2_config.bits.enable &amp;&amp; dc-&gt;res_pool-=
&gt;funcs-&gt;update_bw_bounding_box)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || res_pool-&gt;ref_clo=
cks.dchub_ref_clock_inKhz / 1000 !=3D current_dchub_ref_freq) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.f=
ams_ver =3D=3D dc-&gt;debug.fams_version.ver;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dchub_ref_freq_changed =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res_pool-&gt;ref_clocks=
.dchub_ref_clock_inKhz / 1000 !=3D current_dchub_ref_freq;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((!dc-&gt;debug.fams2_config.bits.enable || dchub_ref_freq_changed) =
&amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;funcs-&gt;update_bw_boundin=
g_box &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr &amp;&amp; dc-&gt;clk_mgr-&gt;bw=
_params) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* upda=
te bounding box if FAMS2 disabled, or if dchub clk has changed */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;clk_mgr)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;funcs-&gt;update_bw_bounding_b=
ox(dc, dc-&gt;clk_mgr-&gt;bw_params);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;fun=
cs-&gt;update_bw_bounding_box(dc, dc-&gt;clk_mgr-&gt;bw_params);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;res_pool-&gt;pg_c=
ntl) {<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB5284705AB614A4578FDA222B8B4CACH0PR12MB5284namp_--
