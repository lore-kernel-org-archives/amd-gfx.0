Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0396C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 18:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4346710EA30;
	Fri, 27 Jun 2025 18:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vD8UGcrT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE78710EA30
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 18:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI3XOzq4GcT5snm73qZwC7ACXpUfxpNCUs2UfuvJwcAbaygnQ/mGR0PnFn/QcgpMNkUkvQwo4wMrcBgBBGkSjxPqWl2CkdExVN11pE8jbcdFaRNTErx9oGnrKVYl+N3POrjLrkaY3U6wI8w7QZtXH7SHNLpqUURWDF90qfanoaPMwvo22fLyrtzC6B3DeRymPcQnZXvaw8TIdC41TYni70CRIRM+OUv3A7Rc5bHLvB0TCRJfQvcPbwRvnqcV1OfToCA0uuHdeKjSdr8vFnz4VtrvROG3AAVjROFIXfkoS8IrIoIYBmQYNTq3l/L4HCLrHQeatM5zDyDo9zsGScfLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKroXePMdOT98jyB9Gi/GMnyvww7VSuVzS9t1F6FHAY=;
 b=DHtSIrPaP3I6xlq1jYA60Zp78g9l8fkF7rDh80Ml6jtK6BOpRcQsT84jxZKU5wsiErG/P7enYtGoTPPpkYvMd19Fypv5Gln+CmMigHaVBRuW3+tgrki2EHDVZeDJ7a9HqwUqZ8X9i4ORi7+r9m9/D7QxDjFAPhvvxWizvLkmPLqRRF6sUazEK+0KSmn/gIyTxwNIPxjoNJ/ZNw5xLlcaehq3074ojmBcT79ErxHEUJ70vujiNW7cKZMJdlSVXqRH/Ev3TVaeMzRB4mGClvMWjAetwAdPpTcqI+FoYNWZ/YlKkU5bTjePPYgG3Ork78zoXds4tWlfjWKVcQ5ShXzY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKroXePMdOT98jyB9Gi/GMnyvww7VSuVzS9t1F6FHAY=;
 b=vD8UGcrTtmxWcAanb3FLef2qx/J+rfI7Kl+x7WKVrcZ3StlVun76aWE3WWoIj9vbOSE7QYUrHC3LvWWPiqvr2wutJmHX6GuPjTrnPyitdJW1F/cOtJUvgoxivfjtkifcU+q3/vk2W7jfLCM7J9DyfHFyrtUNqXyutOXdZ1KQsr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 18:13:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 18:13:48 +0000
Message-ID: <6987de1f-118e-4afc-80c7-0600c44c2c94@amd.com>
Date: Fri, 27 Jun 2025 14:13:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amd/display: add more cyan skillfish devices
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250627143342.23856-1-alexander.deucher@amd.com>
 <20250627143342.23856-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250627143342.23856-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::6) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 81888b97-061a-4ad3-beb3-08ddb5a65c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3k5azQzQVd2cmxWR0srWHd5d2kwbGhMRDlLMm9SRzg4YlZRS1J0U2VWVTJM?=
 =?utf-8?B?dHVnejA3WkEyMGMyTlZEVmlSbW1UTTIwWjdsNElwOStnbEpSUDlEaWlWejFv?=
 =?utf-8?B?ZjFHdHk0bTlvb1d6NDZyK01YWmxqR0NZUFEwTGtBdEtmTVp6VnB4S1lnNmh6?=
 =?utf-8?B?QU5pcHFWQjNCYUdNcEJjQW96SDVTa2tGZXJYS1FMQ3FVUkdGdE9oeWV0SXVI?=
 =?utf-8?B?ZkVtbjVUM1ZHR2ZYUGQyM0ZCdndUYnlKSWpsaVV5L3VGdHJ3bWgxNkQwbndK?=
 =?utf-8?B?V3ZpL0prejh5UytLb3VzSDFFdjhpREMzREt5Sk9YY3hwN0pRSGh2UlVHeVJp?=
 =?utf-8?B?Umk0dFVweTBtTkJOQzlMNThEZVRWeno3ejh1UTV6NHI4U0UweTk5ZE5ZL0ZQ?=
 =?utf-8?B?L2ppTTM4ZkFCU20waXRDekhPR1NQRkliOXhiTlE0QlZqaFhlanBzOFJ4aEhs?=
 =?utf-8?B?WGZWTU1xR25HZVVlWThING9vUm9FaHJXK0lHZ0hTR2RGRVRhN3NsYURWMmJV?=
 =?utf-8?B?OWlSS0c2SXZ0bVRnc2p4bHlCbnYvK296TDg4N0ZmTnFvMExFNGt1cHI0RVhx?=
 =?utf-8?B?eGFtWlJtc0ZDT09jd1gwWURHSlBDWWpMYVFnWnp2OUNyMTRZTjd2ZUFCWllj?=
 =?utf-8?B?eHpVNkVBZ2czZGRWbkNNUUVCWHlCT0ZCNFltZmM0TkhzQ1R4K1J1WUozRERE?=
 =?utf-8?B?RzltMGFpK1ZCQTZLdC9oWklHY1gvS0drMWN6d0F5V2ZaWE5RNHJYT1VsZEhv?=
 =?utf-8?B?bFZDcVpiV1M1ZWtuV3hZNVN6dGhJb2pCWHZnNU1acllETmRKZlNNTFBPWHla?=
 =?utf-8?B?bFEzaUZQU1VvK2Nid0dwN0c3bTlMTVovWHhpZjg1bysrVkJHZXlGczluWG0w?=
 =?utf-8?B?bDBTQjhEMjg4OEZFMHVPS2xoOGdRcGtnQm9BczdoeFhxSytRUWkwMjhWZjZR?=
 =?utf-8?B?NHY2K0c0bzJTd3Y4U0ZxeEtxNUM5ZVQxSko0S0JZZEI2SDBWZHk1TTR5RGFV?=
 =?utf-8?B?cmpEeEUxRGQ2eGJOZXBKOUN2SHM1b3JISFNmdmlVcjlwWGxTbVZvdmJKZjJN?=
 =?utf-8?B?YncwQ0FXb2RhNW1CVjRoTml0YnRoTVJ4ZUx5Um14REpCalYyNTY2WHRqd3Vt?=
 =?utf-8?B?M2JIZHF3aGpFTU9veDV6bnkrSXAyeWt5cUpQOW15aEdpTDluWVJVbXBaaFZ1?=
 =?utf-8?B?UW8wZmdTN1czc3ZFc2M5QUEveVVxVFo3U2pxUW5qaUtLOXJDNUVMUU8wTFJH?=
 =?utf-8?B?QW9zOGVlRUEya2NkNjhteTdTb29Jalc5M3BQVjVNMG5DMVV5VWs3Z2d4TmRO?=
 =?utf-8?B?WGRvVHh5eGFCeHNxOG5hbXBsUmJpV2c5V2JPeEIrSzkzNFVFVDdpaXVVY0tr?=
 =?utf-8?B?dkRSK0JVTXllMEM3ZjBBMWt1Y3NQbFRGcE9EMmhIK29XcEJZcnFKSW1qL3Ay?=
 =?utf-8?B?eldwN0Z0cHltTGlIU2Y2S1ZEKzlmdEo2UC9weVdONWJnOG1DSWR4MFZ5QkRW?=
 =?utf-8?B?dWt1TFpNeGJyM2F3WjZwUE14QlNBRXE1OStvYnl4YUZFZFRjcXk4TDVSUVdD?=
 =?utf-8?B?K1NodDBuUEpPNnZOZElmajFmVlJGelZ4NVpwVTh2enZxN3FLekViN1k4MEZk?=
 =?utf-8?B?VGxTbXBKTW9HZDNTSEhOZWZoVk1NdmU4ZkpuS2pMb2RDR3JubVJjZnErQlZ3?=
 =?utf-8?B?enR5T2lWRlpqQkZYdjVxT1hERjNVeGRYYjhxVzhhbzFhUEFDelkyVTgzYXNj?=
 =?utf-8?B?Y2wxVlNQaW4wRFJmZW9FaGhsSW80THVrMGl5MzB3QnQ1QlRyVnFyMlU1MXkr?=
 =?utf-8?B?ZU0yUENZMHVNd2dmZUZXKzNBYjVJQUV0TVVXZFhhTkpwRDZNNmdiVmdVRk9Y?=
 =?utf-8?B?MEllZnA2QTdhZHVEMnBaa0hIeXhqazNTMlVDL0M2MnVuTmlJN3gwWCs3bG5y?=
 =?utf-8?Q?oFuS/vU0PJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGxDd1dEN1RqMDliYTdSMjRuYStCaFlNV25LNldvTG1QOS9xWldGdzJJV2R3?=
 =?utf-8?B?ejhWcVJ6Ky9veTBRQXJWU2l5Y0JmY2E0UDEyRDBaY0hhMWxGaC8zcXpkMkVu?=
 =?utf-8?B?QTY0TzB2bzQ5Y2R2RVZNN1I1SEZydkpyTmNPWThvVjJIMkUzNzdaNHRZN1JQ?=
 =?utf-8?B?SHBEeVBDd0NjaE1lV1pwTGltK2duRFVJczJBMXdZR0ZOVzVsVnBkOU5lcGtZ?=
 =?utf-8?B?TEdCU1N5ODcwZ1VvY2lZb1ljdmROMEMwcDNnWnd1NDQyTzRiNEhxbnBxMVFR?=
 =?utf-8?B?UXRLMXlaUWRVK0tmaDFWeHMya1VxZWl2WDhRYVpBWWxORi8raDlGc1J0Tktq?=
 =?utf-8?B?ZzUwbU9zN0RndGFwSU1sbklDTlQzZ0k4MnhKdmhuSzdVY2FqTEN2RDByMFl3?=
 =?utf-8?B?Qjh2OG95a0xVdW43ekdGTGpVNjVpMGlLY2tNREdEa05LNEV2WUtyWmh0bHdJ?=
 =?utf-8?B?a2VhNUk2L093QWd6L1MrZ29lSzlGM3VsVmxCUTMxYjRua1pmWHI4cVh5b3Y0?=
 =?utf-8?B?OTFlbDJVWmNmY2dMa2xsNG5tUER2YThrZWpDUzNJczRwdFV0TCtqcFJSL0d2?=
 =?utf-8?B?Sjc0aDB6cFVjNGgxL1FPSDE0MURmUmtkbU52SmNHcUtaNVdGcVQ3dHYrM1lG?=
 =?utf-8?B?MVNOQmFwdXIzRHVzb1NJUVJuTFNwRlFYSDRvblM4RFlDN2Mzd3RJaHR6TFJa?=
 =?utf-8?B?WmZjM0puMTVpcExsMGhGbDJkdjdEbm5mYzNFajVyV2E1NytFQ1MzSWhOaEJh?=
 =?utf-8?B?MFlvd1F0SUdpK3N6N0R6K0FMWjI5S2RSU1UwQkRwYkNKbjdsanI4OTZkb3pj?=
 =?utf-8?B?WXh3c0xibmQ4Nkg4Wlg5bVFqc2QxcllheWpsbVE0bGllMC9ndXpqUW9XOUVZ?=
 =?utf-8?B?U0IvVjM3WDJiOGhybmJ5OEl5cVczbXFPVlk3NXJFSmQrRjJYV3lhbkJtK1dV?=
 =?utf-8?B?WmNxaDlWcTlLYVkxS0dSbkpLbGhseGRnTTB0RFVUeFlSOGpKMEJYYXNwaGNK?=
 =?utf-8?B?SDA0MnR6N1FUZGJKdVlORGtLN0hDZnFGNUVwUFpGeGgxbGNzQUVNcEQwMytz?=
 =?utf-8?B?WVpkSmFqdjdjUGpKMU1EN1M4VUdrSm14MGFqb0tEN2Fzb0JnaGY0YnVucFVT?=
 =?utf-8?B?OWZmZFhDbnhsdkVBY1RGSW5qT0ZIY1Y0QzJuVVBrNFdnNEM1SG5nbXRCV09F?=
 =?utf-8?B?ZHRCTFJKaUhCTlNwT21BOUxFYTFRVjA4TDczMFJQZDNzbUNBRWJ4anhhLyt0?=
 =?utf-8?B?dXlnVzEzbjY2TUFxUUM3Qy9NMlM0SENXM1NVRDR4MHY0WVBJbFZtRE1YczB4?=
 =?utf-8?B?TE9zZEliZm9lNFhlZVpJVGttNittMldlTnJJekpWanpsTllPUnFPZERsYXRV?=
 =?utf-8?B?S0lETDY0cVZTNDJGbVVqYkZkcXNnSGVxREVYZzZMc0dMdzlzZzRyYzFMTjhM?=
 =?utf-8?B?RUdMTExBV3BqN2dFQXlZSGUyTjNvZnNDd0dtVllwSThmbktvano5S0Rtak82?=
 =?utf-8?B?Wm9xeGNYRm5aN1NHV1orZ3FuUDZOeTlGMDJRQnRSalhUMkI1SThBME4zMklv?=
 =?utf-8?B?M3N1dWN1K2J6dkJjMmM1Vng2OVpvWWZPVFY1ZnJvWlF2TERyTXFyVWNpYVJK?=
 =?utf-8?B?OGVXSC90REM1elFEQVZyMkdCZzFnLzFkUXdRNmR6NUh4TnIrOVRUbTJ3K25h?=
 =?utf-8?B?UTlmbkVyWDVORW9pbXFkdGtYVlBwRkRicjlPdHJMcWw5NDNTcXhIQWJ0S0U1?=
 =?utf-8?B?d1lDWnYydS9sZ29lT0RVcS9HK1BOQzdYYi9IRzdQVWE5N3QrMnFEWW9ZaGgy?=
 =?utf-8?B?U3NlWEtlMjViNzNITUhxZWNhMGc0SDRyTzlmZ1kzWkNiZzBTSll5Q3Y5dVJ2?=
 =?utf-8?B?MTJRdlUyRUd6aDZYZkFBNlZJYzFuYldZazhhVmR4eGx2eDduSmJhWGJxajVP?=
 =?utf-8?B?by91SEtqUUVLK2RGczRURWdzdDczUHB0c2Q0eWtIcXhsTm01MUIvQXY0ZnRi?=
 =?utf-8?B?UmVkSWZVZnJaaXlJcGdhMHl5c3V1SHk3SW9seHNiZFkyQnVlZkdTYldqZXFr?=
 =?utf-8?B?MFRTN3hrcGFmSENmTi9EK004VUFqVkxya3FpZnJZYjk3ZUF6eVIyVVB3dHQ2?=
 =?utf-8?Q?ASuD8QsEez44FgAW+6nyHuHBB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81888b97-061a-4ad3-beb3-08ddb5a65c5e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 18:13:48.3924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itXLUjxH7/s/O4bowLinvLLeEM9SQhEjg13Ue4VMMM5KC7XyPw23D77dILfTAVfUI3bctBeSi9Sk9dhTEeunug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
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

On 2025-06-27 10:33, Alex Deucher wrote:
> Add PCI IDs to support display probe for cyan skillfish
> family of SOCs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 +++++++-
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 5 +++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 854fc51f159c1..133b76bc74a9c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -165,7 +165,13 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>  
>  	case FAMILY_NV:
>  		dc_version = DCN_VERSION_2_0;
> -		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_143F) {
> +		if (asic_id.chip_id == DEVICE_ID_NV_13FE ||
> +		    asic_id.chip_id == DEVICE_ID_NV_143F ||
> +		    asic_id.chip_id == DEVICE_ID_NV_13F9 ||
> +		    asic_id.chip_id == DEVICE_ID_NV_13FA ||
> +		    asic_id.chip_id == DEVICE_ID_NV_13FB ||
> +		    asic_id.chip_id == DEVICE_ID_NV_13FC ||
> +		    asic_id.chip_id == DEVICE_ID_NV_13DB) {
>  			dc_version = DCN_VERSION_2_01;
>  			break;
>  		}
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index 5fc29164e4b45..8aea50aa95330 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -213,6 +213,11 @@ enum {
>  #endif
>  #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
>  #define DEVICE_ID_NV_143F 0x143F
> +#define DEVICE_ID_NV_13F9 0x13F9
> +#define DEVICE_ID_NV_13FA 0x13FA
> +#define DEVICE_ID_NV_13FB 0x13FB
> +#define DEVICE_ID_NV_13FC 0x13FC
> +#define DEVICE_ID_NV_13DB 0x13DB
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
>  #define DEVICE_ID_VGH_1435 0x1435

