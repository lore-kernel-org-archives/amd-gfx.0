Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23363C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E10610E24A;
	Mon,  6 Jun 2022 14:08:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5343310E24A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeEPVqWxMDQYZ2ludZiZd345YhSTIeduRgifeKisz3NVap87uDL1r1wX8FIAjWx+7g8B0IpDQo5R5nIDiXN3ZstpzEAGLi8XwbOCQkE7xDMnIjfJ+eBIWguVHacKXSPaqXhM8BlpXANuwskOS1EWddQBZZV7PvuwSzn3oy6EZw/Y9GvjNtMpmybS602yNMoa0eXS0WnB+cZR+Lz00Q5QpP1Lx+FWmCU/YmOSrnNIRD1ctBkq7euxfCdxWT2RHV4GzEtvc1Cn58u+rU+RVKFzzP1S4dzniMxoEhLx4t0j2YtRvR26RWm49a0iCjVs1WO2Lgn9krPb/28raN00Qlgj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK42hI9rGzMfdBvsbBYIjDbvY2vjA2qqOncoTFzO2oM=;
 b=FkeO2THbQ3G/u8MwrWEAtrkqYwYpZUxXGXyQJISuygEZ/Y+6HeN/cZkH/ffk3IlRy8i4r3hQjPY+uOp6xwT9fLiS8t0bgzxBUHCfkKNWJvHYArg60+2c00lXscwHmJvzW6rBhX+GcB9S1OhhuEhD4Vd6XB/uiXOSx/nyjRi7ZPy2zfYnkzei8p+Fz61xkReqW3k9WxaoCvOEtiAnLtzShOmZtrd72C6nTk5dnoe8vpGI05c0zNgDc/vsMlSQvwT2pNG5Wi6kSCJ/nhHUACqRydDK6VenFKZy2ccJ1BBGjoVGa5ujYWeWSpbm3DTKYNK5r/wIkqmvsQslUZVBa2zYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK42hI9rGzMfdBvsbBYIjDbvY2vjA2qqOncoTFzO2oM=;
 b=4iwaHYAout0CHCWfhLN0UXPZ7Vi4yfGhoquhFEmbhWyWpnS0eQR6FqWW7qWX0ULIWPFwjvdXEiQ3Vxnopx8Hhru9i++i5Z9wSfGdFbCwMzHQ+fa6N4tmYF1ESvqhoU3HgkKprYebQP3oAmHFsRcqMYoHbGCq0hQaaMIKG76UPHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4031.namprd12.prod.outlook.com (2603:10b6:208:16e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 14:08:38 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:08:38 +0000
Message-ID: <a9174ce5-4c51-96ca-6436-445533f7dec7@amd.com>
Date: Mon, 6 Jun 2022 10:08:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/6] drm/amd/display: Reduce frame size in the bouding box
 for DCN301
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-4-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603185042.3408844-4-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14c77ad2-41c0-45b3-3acc-08da47c60d5d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4031:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40318E3C7323C2C792395A8F8CA29@MN2PR12MB4031.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wwn697kVl1lfxGBqz4XT+9kJ64ly0FdZEKHWuNHx+xGhg/fiZaAxjk/tu5JD0xpNotz+LCaXPZQFoeW4/9QnRZZE5+POQul+9IHo+gujXaKtL+a+4r4DQE9yjZMf9L2t03nVnqcnDrVzSMQS6HA75W3i7536NcfnlH4dOZrQ0B3Q5nLQSVP0jg1riT0zSASIDthlTA/Qwt9SbHFnkvSs8L0PGmZwu1e6HLHqt0c6EMZF6gu5h1+lp9Lpg6OIEOA4q2XrZI0C8B4wCYpMQq7asgX84lgFhQV7zzoXcFqhShdh7dh+M3KcIEOZ6Csom8WtQsBOEHt3yAb8P5BSusNWjrsbcl5kDMGrNf9QcD35LWbjeDWuB6aLenxCbBh366Pdn/vmDL9kfTsTJVbAlzVoiei+O2jsEq/ZOQWXZhe4HLGwIbg8UEeM4qgl1u/tGx026x/YYKInIxG7F8+Ol3ljOLj/QGGNjS+7SSxY0AA58zWYHUjldy07hzDYUbabX7IewVptYMkme0iw9PmtFageOeHydsRo5lDtevGw0yHPZ5WnjWBxEZpbAVdM9XOKTS250rJryspm1qUzHZr4hVadM4ou3gedExbyzQX/Kjr0W8E2OMsbCS6Mx5U3O2yx+OIcpV3PEZ+QTpSGPE69LL/WK8e3Y7sCxUr0Tqmby06dUP+52T2+REIVMe9EkWy5VBaruNV0kFzIlBwNfmMTaFfKZ1vJ8/+/PMQISb20YpDW3olRu3wmmpEu/0Edy5km8Thq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31696002)(86362001)(6666004)(508600001)(6486002)(44832011)(2906002)(38100700002)(316002)(186003)(2616005)(6512007)(54906003)(53546011)(6506007)(26005)(5660300002)(36756003)(8676002)(8936002)(4326008)(66946007)(66476007)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFxeGZudndlc3Y3YWNSMFZtRDRjMHhrYjJRcU5qL3NzTzJ2WGlzeGtlOUxD?=
 =?utf-8?B?RnM2VU5uN3I0ZVR2QjhKVFNZSjJneldTMHZjOTFDb2RUcWFIb3FrNGtCb0dC?=
 =?utf-8?B?ZDd6UWxuUlFuRFdWTDdMKzM5MWxuR2lkREdtVkM4VTArTElOU2NNQ1JWdkxa?=
 =?utf-8?B?NXFnUS9mUzBiUjFmZUJrajF5Vk5heWgyWGYyYkVkZUNaTFBHd1FrcW9OVVA4?=
 =?utf-8?B?NUlWMXUrRVlubXRhZU5RQmFqRzFQSmpsRDBpdFg5WWtHYkw3NVhTQ2FmOVZr?=
 =?utf-8?B?VlVNZDhzcUJVTlE5SVhwVTd5c3VWSkFLRmlDd1BhWS9iSHRQMHEwRGxhWi8r?=
 =?utf-8?B?SyttY3JUZVhrWXA4V01PMkF3cGwzS2w0Tk4waUZqc0paTkEvRFZaVlFYSzdD?=
 =?utf-8?B?ZnpuTmZJMHJUNE9jcUx1S2F1dlpEenhTQ1JEMWI2ODZHc2RFc1QwMmthbldD?=
 =?utf-8?B?T1NHNTUrWmJreHFvWGtaMVpoMWcwN1JYRUZYbHJxdW10Y24xblVXU2hWUG9q?=
 =?utf-8?B?dVZvUVJXbk0xejNZbUJ1KzlMM3dBMXlOdWhGR3JydElkRHVmeDR6ZzR4VHlh?=
 =?utf-8?B?RU1iMUhsWUNubTJxblZZbDh4dXA1ek5qeWJNejUwT3hVUU92SkJHb0ZpMkNO?=
 =?utf-8?B?UkpzUUpDOEVBQ3lwVGgzUm45aDIwd09YWVhMaE5rVGpHV0F5RmowUXpFdHNE?=
 =?utf-8?B?eWxWd3NUYjByMWJtWVUwZElkd05xTksycElVYnVlTnRlaXN0aG9ITWJaZ0xI?=
 =?utf-8?B?Q3lhbnhteDVGc1lXUlhPb0Zydy9tM1IwM2lYdFBpM0V0S0VGOE1Fa3hGSUhh?=
 =?utf-8?B?MUpKTE5OYjNxL3ZldURaVEptTHNOR3RpZ3JxYzBHSmM5VVV3eEoxK0wwcXZF?=
 =?utf-8?B?UGwxZ3JVUGlyZmhGdnpNU25hYWFDSkkxWE1KdVJJUitHOGF5QzQ5RU51S2dh?=
 =?utf-8?B?YTdSWkVtOWROODd3bEE0VUdGalBvNEtzMjl6Nys5bnZkaC8xVkQxWmtYcHI0?=
 =?utf-8?B?SThhamFLUnI2T1FnZDBSK2RLYTZWUVM3ajk0cmlpNk10Y2U2TlVaYytZOEV3?=
 =?utf-8?B?WWJidjVwWjBwVnp0bG1rcVR2UEZYU05hSW5Xc1M5QzNxbktXYUZCYm1FYjJr?=
 =?utf-8?B?U0pQREdSblBOZlU2c2ZFRm5sNXNFUmhEeTdhNmZlNlMwcFFuNUM3RlRsWWxN?=
 =?utf-8?B?SC9ReFpGblMrekZ2VytON3M3NjRvYVRkWnVKRXpKd1A3V0ZIbU9YRzlvc2Y5?=
 =?utf-8?B?dVI1eHI4V1NBQWtCR09QVnVrKzduVUdzMEowRFg2UVVVcG5TSXY0UmU1cFRT?=
 =?utf-8?B?Y0l3Mys0V1BQSUM3a2FlaW1LNlJPVitIeW1xdE5tZUZ1aWFVcFlrNDFRLzdW?=
 =?utf-8?B?RXRMS2VPVEh6RUx4OWFZVmZpeE9Cc1dTWExGZmNBUHZKeDVYYldIWDZqWkQr?=
 =?utf-8?B?Q21wTGVVUVhuUnF5UUhnQ3VoenRZZVJsVXBRTHNPbmJWN1lxUVR2K2pPbzZE?=
 =?utf-8?B?ZlpCYWNlS3JVQmo0MkZIWm5CQUo5aDZ4L1lLR0dDalBpQWRiRms1eEczYzFp?=
 =?utf-8?B?QTF5M0EwNytzMzNncStEMHhMV2NselF0Nk5mVTY4RFh3K3VQQjhTSVpjcmVB?=
 =?utf-8?B?UWZhRXdVUHhQVWt6a1k0dVZ6aXAyV2VvNjM5YVhiVnltRDVha200VUtibkpu?=
 =?utf-8?B?bjNkcEtVT3FZQy96bEZuOVQ2SjdkSG1zTzk4NXlPTkNaZzNiaXJBeFF0MFBS?=
 =?utf-8?B?YUd1Z0YxQWdOOVo2YVpkRlZLVGljRGVGUUFac0FZY0hWOWhLbmlKZFRvUHI4?=
 =?utf-8?B?UHltYmR1TzlubmxpdDNxWVJuNzc4b2lIT3dqWlFaby8vQXdCUlF3RjBicDhV?=
 =?utf-8?B?d2xQMHh3ZURtd2JjV1hLcW5uY281bkhRa0RTRDdWdDlkNExrbG1mYW8vWEFs?=
 =?utf-8?B?QzZMU1ZZNGc4djgvY25SWElIM3ZCTktpWTZFZ2txbDAzc2VIQ08vK09QSTNP?=
 =?utf-8?B?MnJOM3FFMC83cjZLZVlEaGRoSHhXT1JIMGhqZTNxMkNYSFFXdTZqekgrR2VS?=
 =?utf-8?B?UjJLSis2NXNPYzRWMWNVc3dzY3UrVjFrV01LNUc5RXgxUGhJdFZ4N1YvZG9H?=
 =?utf-8?B?d05xZFFwNFZkbFlWcFkyTHNqVUJseTNkZjVlVXprL0VEbTI1RnlpbGYzZWUv?=
 =?utf-8?B?d0d1ZUFMcmx0Y1N5bTY0WUlkRzNCZ3B3dzgvRWxMcmhoZTRxQjNjL21hM2pi?=
 =?utf-8?B?RmtxOWUweitOZWJNdXFDZUY1TlR5MStOTzMrdEM3MkFFTHRxdFBWSzUxdXdH?=
 =?utf-8?B?Q1dic2tLYjFqU0tMYWExOHhDUnpFdjh3akg1WkhmeXBKSjdFQWhjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c77ad2-41c0-45b3-3acc-08da47c60d5d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:08:38.1844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeiQgMfNWDW747RMh8mBXs/UtYrGqHwS9Iy/SarPtIuMoLxQHO07SrpRrBiYCOy9p/dS1IBp7Tns4nY9VsK/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4031
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> GCC throw warnings for the function dcn301_fpu_update_bw_bounding_box
> due to its frame size that looks like this:
> 
>  error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> For fixing this issue I dropped an intermadiate variable.
> 
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 30 ++++++++-----------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> index 0a7a33864973..62cf283d9f41 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> @@ -249,7 +249,6 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  {
>  	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
>  	struct clk_limit_table *clk_table = &bw_params->clk_table;
> -	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
>  	unsigned int i, closest_clk_lvl;
>  	int j;
>  
> @@ -271,24 +270,21 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  				}
>  			}
>  
> -			clock_limits[i].state = i;
> -			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> -			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
> -
> -			clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> -			clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> -			clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -			clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -			clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -			clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -			clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +			dcn3_01_soc.clock_limits[i].state = i;
> +			dcn3_01_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +			dcn3_01_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +			dcn3_01_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +			dcn3_01_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
> +
> +			dcn3_01_soc.clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> +			dcn3_01_soc.clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> +			dcn3_01_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +			dcn3_01_soc.clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +			dcn3_01_soc.clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +			dcn3_01_soc.clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +			dcn3_01_soc.clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  		}
>  
> -		for (i = 0; i < clk_table->num_entries; i++)
> -			dcn3_01_soc.clock_limits[i] = clock_limits[i];
> -
>  		if (clk_table->num_entries) {
>  			dcn3_01_soc.num_states = clk_table->num_entries;
>  			/* duplicate last level */

