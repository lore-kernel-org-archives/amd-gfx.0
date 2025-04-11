Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03BBC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2A910EBE3;
	Fri, 11 Apr 2025 14:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tepqMw7+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B58210EBE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrh+PCoI1FYjr0mdGC3sUmnNH3lpU6YQnduazyuJso10tsVVG8ZlXXUFIDHqTe54rYYBzK8W8g8JS1VgLbfaZzjS5uuh20+ItxGlvCUM5WcJ2bN+TahZYPklbxDnZqksJF85wMCDvryCzeGrp+C3pGdp8TbPlO0R3pKu09BjAUorKebFv3wmb9Hl1drAF9pXidbWQuKlSaP4oSsdhfAO3MRuo4Alg69Kbl6f2tIwEBUlCkHYdnUfw/OJBu6uOsw+Bz1CjI4zCHGtS/eIMl3VHZYkizGdhEgJAcnhkwmIV6Wrtk/5Yjb2KxPLVN6EylXQAkPdMRUtaGMLFAnEmmwO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqnKcMzbiHEvNhYkOt5dpo5nsHm6ad8fTUWXOGLvJtQ=;
 b=Bn5fftsnbIope/4K5CeujerHGfMXriOXviIBjZSbAfeqeBwzNEW4rEC9UsVyi5AmMR1b9yckBJWo520Z16VXMGP2BYdLKKhGXk9OxXsm3X7zfMm5xBm4RJnIrNYI8h5G+cFW6YM6Z66EmPIOL0jAGdPNy88wGkrb2ukHmylfNBm2jc9ctlZx8Xju10XfZhKFB25hSxJUz81QZ3sPn7QtJHQMqftHLiqO7RVOfHLouYrVZj25oqBLJBS8DHv/a5wbI8/AkGIF2MiQL4dbELzv2yHF304Wj+8Fc700sHuJDhVn6+/1RjlGPp45dDcpvX9qU/e5xPSmA8Pb3CPIMscJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqnKcMzbiHEvNhYkOt5dpo5nsHm6ad8fTUWXOGLvJtQ=;
 b=tepqMw7++c5IaARrzIjf9Pw2a/dGiTojhGroqq27FVQmGFSM1lTjbyqhHLudwEwwjLObbTzmznjYPBr2BD6XZr/3T5pyC5zSqHH1ki4WYswVtLFa829f+csy2rtxw6xoypBj4QAcAN2h3YiKNaXrFX5V3SmtSGb/j/qMsIH/0DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 14:55:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 14:55:50 +0000
Message-ID: <3fca89c0-4279-480b-af86-85b710c9ce56@amd.com>
Date: Fri, 11 Apr 2025 16:55:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: replace a comma with a semicolon
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411142007.2742502-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250411142007.2742502-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db429af-d2de-449d-de42-08dd7908f2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hxRHN0eDRrYW45R3VrZnJHOGtLMGlKL0tzS1pFT3R2a053Mk1PV0xJMjAx?=
 =?utf-8?B?anJpUFBpZXZYUWxDRitBb0tTQVZDd3JiNXdEOHdNclZLbW1ZRnJjQWlVSWlK?=
 =?utf-8?B?Yzk2QmpoMklHTmtMNDZ5VFQ5MzZxMVo1bjlZZ0pPSHYyOXNXMFJNWWFZczJt?=
 =?utf-8?B?MkxMaitDc1cwOFovK2lvNWx1RXVxcW1XVEswRi8zaWNXQVJSYkpoUC8vYjRZ?=
 =?utf-8?B?UkRoZEw1YmJNM01rWm5Gdk1uekZ2RTNmMnBweTZqQWl1MTJGTm1xMldJNmMw?=
 =?utf-8?B?Q1kwTHBwaEs0Q3JHbHptbjZxR09FWTBnYVFMd3gzUVV6elArSmN1YTBMa3gw?=
 =?utf-8?B?OFNTMjk5SDNxR0VSOTJkcVBFMmhJUWZMQ1ZrUDBncFZnbFNnM3lYdHVtdjNx?=
 =?utf-8?B?amlhZk1kOXhNeHVzZ09sVFZIZG5tNzZaR1ZsTXpteTRrYkJIWnljVURxT3Bt?=
 =?utf-8?B?Ly9wRGNvL3RvakdUQy9mZEhuTmFwbnhSbG1EbzhEZEhkYmE2bmR4b3dCQ3Rj?=
 =?utf-8?B?TjBSR1ZCdkF6VFdKVHFmSWptcWxJaGVSckw4bEM1UnFRQ01DaVhZbCtrWUZM?=
 =?utf-8?B?N1BBSlJnek9ET0F1cFlSQVFRZnkwS0tHM2kxNTkyc1ZqL3dkNFZsQ1hHSU1V?=
 =?utf-8?B?bzdVVm4wQzVweXRmcTJZc1BaNmQxVFBGMkVENXZCTzRhTnh2MnUrVXA1NDdo?=
 =?utf-8?B?ZWwvWXRpVmRNa1U2bFEzZ3puSjg5VnFEbGJTRnNQS0NGYWR5dmpFMkkycXVU?=
 =?utf-8?B?RkdRbGVIVkJlK0dVTnF3bDJwbEY5emFQSDhLZ2IyRFZzZnR4ZmZaRWR2cHNW?=
 =?utf-8?B?NGR0YUo4byt1T0NoZ2lWSmdtN1Z0S0lSS29icnFQUnByWTFod3dLYkovY1li?=
 =?utf-8?B?NTZSZnNVZHhzNUQzbWYvUGtpOWIzaUxzNkJtZk9UNm1rM2Rwamh6UjlNUzN0?=
 =?utf-8?B?TUR2OG9Td1hMbmJyRzUwR1FOZnVWazU1U0lYSDlyRmlMZENiNW50M2YycXV2?=
 =?utf-8?B?Yk5YK2hGN05TZy9YNnN0V0RETHVraE0vYjFzcnpFbXhmMHdxMHNOVTYwcDV2?=
 =?utf-8?B?ekkwMHBtaHJUMzNJZkhhOW05UnFLaDVyVmVkMGloT01hbWozQXFYYjh3SWxX?=
 =?utf-8?B?UDU4WlFyMVpPbnlDalpvNHpBZU1mRGE5N1FxNE5zUElXL2l4OG5ra0JRQkU3?=
 =?utf-8?B?NnZpZ1lhNDJPdlFXQjB1MVNXQXZ1b05HWWFJL3BOWHkwanB6V0l4d2F2MkdB?=
 =?utf-8?B?RE9zNDhuU2U1UGZTOEJCQTF1Sk54QVUzeVBqWDUycWttemdlM25FQTRCdVM0?=
 =?utf-8?B?clpMMzMxM0ZVWVY1RWZGWmcwN0JZdngydnJiTU41ZHFySjdleDFWV2FXNVMr?=
 =?utf-8?B?VldsSkdTb25mcjA4RkQxenZaVzRFN0hsNmtuQWEvRE9VRHQrSDNQTFZLMVNa?=
 =?utf-8?B?cFBHR040eU1maFYzdk5WdXptbkc4M01laGVycnRiaE41KzNOTzNjN3FqcWdS?=
 =?utf-8?B?WklESWZxNS9Yc1BFUVJxa1FWNlhGdXdvY1haeFZvTUJjeEJxU3hFQzNVMnY4?=
 =?utf-8?B?eXJsTEVmMEd3R0Y1T2RZRG5IZnRrQWVkeVEyclBFcmNycS8rOFRmamtKbkU3?=
 =?utf-8?B?Yll4WUo4N3Z4RFhFOUFRY2tiZ2RMbnhsRVVVa0FpVzVKMDdpVjA2V3gvUmk0?=
 =?utf-8?B?Q2V6dkcxQmZsbjJOOXNIMjM1N05PSUdveGh3VGI4L2Q3bm1BWEM5aFArUjlw?=
 =?utf-8?B?emlDVHNETDVKRldXUUh6bHhSK0U5bW1Xd1pMd3N3K3NmOGJVQUhGdWc0NDdu?=
 =?utf-8?B?dlhFZlhlUEpzeFM0b3NIdEE2cjRoM21UV0J1TUcxbXE5SnJrR21hb0NiVkZJ?=
 =?utf-8?B?aFVSZFRjdVN2Zi9wZGdtcjBVeFRhTDBhZklFMWtBZjFIeTdRT09Damc5MTVQ?=
 =?utf-8?Q?5BGxi+0W8yo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhrME5zUVZtTUlKdDNBUGpnSmUybUt5NENyZ21kcGpmcStjMjkza1gxa3Q3?=
 =?utf-8?B?bEhVMS9hblA5R2UwUHM2OHRjYWJmYkVOTndOVmQ4eGJ6UlVvMGRuVGxCL1cv?=
 =?utf-8?B?TTNDVEJzYnljaUMySWFGekxnWStJOHBSNVlKeDVVTHEzSUpRQVYwV21Hb21C?=
 =?utf-8?B?MTFnVUNGQTdMc0l0Vk1vd2FhSXRTb1ExdWFyNlQ3WEpPSjlTbU42bE9sbFZ3?=
 =?utf-8?B?eUlYVTlsNkdRb2hPZkhPVjE5Y25oc25sRitoWUg0UTBJN3Z3L0FMbHoxSGFV?=
 =?utf-8?B?SVJPQ0hUYXVLNkNmaXExZmF3VDdLekxsNXZtcVIxVVVlUE9yaHNNelhuVjIv?=
 =?utf-8?B?SnplWFhXc2NwbUxTSXNRaFV3UzJ4RmdncWg5blA5bGpoK0JCZXZCNlhhSm5Q?=
 =?utf-8?B?TGlhS0R4R3FreTh1em1BT082Tjg5Zi9Wc0tZZEFWbittSHV1YkZENGwwOWtB?=
 =?utf-8?B?OTBpdHNpSE5uRkZ2UmhhdGs1SG10YzBCaVYyZ2xmZUdTQjBmTDNnbkxkWlll?=
 =?utf-8?B?dDN3MlpiSWZmU0N0bnZ2WGdOdVhadnpiR1FaNW9jTHhucDFNYUZ5a2R1NFc1?=
 =?utf-8?B?RnVXd0YvNnQ1UE1CNXg0bmVWVUJNdWxVRlNhR09ILytLVVdLTlRTdWN4MGZl?=
 =?utf-8?B?UWR3N0QwSFRCOUxOWHNCS3kxRU5wM3FOS1ZEVnl5YUhsN3dsVzZKOVNMcUxM?=
 =?utf-8?B?K2JlS05nMDcrRDJ4enZLQnc5NnpzeUZOK1hxSFF3QXAwMXpFOStMTXR0dzZz?=
 =?utf-8?B?V0ZrUU1lclJtNTRNYTd4dm9BMFRQOXllT0ZiTzVyd2pQSUxrYzJjbXN0RnVO?=
 =?utf-8?B?Qm5kYzdNT1hVS0tCMWd5SHo3bndKeU1pWUMyenBQaEp4dU5jTDZFZFV5eUJK?=
 =?utf-8?B?ckxsVnlDWWpSdVdYaHh5VExlUjNSOHRuWXI5K3U4bXNtMGVLNzZVemZUQmFI?=
 =?utf-8?B?bGkwcEJtU3YxS0tsdU0xeTNaaEMvOWpBdUJIOHRLR0tUNTZNWWhMeGQzWklC?=
 =?utf-8?B?dUdrUUZua2pKQXVNNWg4Y1JrTzd6eUdOd1VuL0NEY1IwbkRkYlRGTHgxeE1V?=
 =?utf-8?B?anJLdnYxY1NGNWJZMEtRSFEwZ0dwR2FveUNRY240SlM1VW1FYzRTS2JTNDds?=
 =?utf-8?B?NnZhdHRlK0ZqTW9EYW43d0lSQkdkVmJkaDUrVUZob2F6aW9hYU9BR0UxNksv?=
 =?utf-8?B?aGRYOGlvU2FSZ2dYU3hiUkdlcWxCZW5yL2JEK3lkMHh5TEpBdFpVQTV6dlFX?=
 =?utf-8?B?WEhScUhGVVpubFgxMFhWY3Zka1hyTFR2U0txdDB2UVJsTFN6WlZxbjNRb3Yz?=
 =?utf-8?B?aTMrRGo5V1VjODFKVXk5VjZZZ3NkdmRUNjFneGc5SkQ0MWVtdmNkZUlaa2FT?=
 =?utf-8?B?bjBXSjdnRkVYdTJwWE1wTmUySDBnM2J0SDVWTU9zY0krQVJSNzZ5b1o5WTVn?=
 =?utf-8?B?d2ZMVHZtR2s1K1h1ci9FdHNnTWpaR051WXBGQXFyZ2FQcTNLK3Y3YmRmbW5V?=
 =?utf-8?B?R0ZsSkNtQUJtNFJZMXRCWmU4SmFiN1g4SzhWejVOeW1wWmJ4eFFjOWRISnov?=
 =?utf-8?B?QU9qRUhJbzVnQ0RRV0VmbHlrQzA2cHl6MDJEbXBtTXAxcFlzMHI2UEs4N0R3?=
 =?utf-8?B?OEF0ajZML1hnUnh5MUhLUzBDSFZSS3BEd1p5ZVEybFkvWWlGT3RmWUIxam13?=
 =?utf-8?B?UmZ2aTlBWnkxKzcwYjZCN0VMbTB3MytvVmlwT2RrMkNwcG5xWVc1eThrTDVC?=
 =?utf-8?B?U1Z6RnJpMldDSjdWSlk2Vm8ya1NrZUpicnVsU3p2YnlUaHZ6TFZYRit6OUZM?=
 =?utf-8?B?aC9PcjU3YS9LQTdOL1JsUUVNWjNEQlpydjBTYzFLK0RaV1Fqd0NlR1V1dEl6?=
 =?utf-8?B?ZnloMTVQY2RGTDlQT2lvUmdKZUJOSi95WFBKQnNRbVhYVFRDNnc3cndVeVh3?=
 =?utf-8?B?WHgrNFY3d1hleXFnUWdob2EyclpxZi9JMkZ0R0JEK1NaWWlseGo2akZKQVJs?=
 =?utf-8?B?U2N3OG5hMGplNFk1R0pKeUJpaktteFNWRmhxS202QktTS0FwMktUa0xNMzRu?=
 =?utf-8?B?V0VvcW9CR2Z4ZFpMYWZhZ0FTWXdBMlA5TERueXdEcHhwVTRsbjA3NTFPQ0ZX?=
 =?utf-8?Q?hnfO2jS8zq1Tb3zrg2Mh2Hlp3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db429af-d2de-449d-de42-08dd7908f2ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:55:50.2621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/7JdOQ8q70oAY+BuZ264jM71VeeMZtSoED32l4cZmXhzwEo8MtMsLqT5w2PJ2dJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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

Am 11.04.25 um 16:20 schrieb Alex Deucher:
> Not techincally wrong, but I think a semicolon was
> intended here.
>
> Fixes: 6cc6e61788f7 ("drm/amdgpu: use a dummy owner for sysfs triggered cleaner shaders v3")
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f1b87b177f4e3..c206c3b371ad0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1460,7 +1460,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	 * the cleaner shader on each submission. The value just need to change
>  	 * for each submission and is otherwise meaningless.
>  	 */
> -	owner = (void *)(unsigned long)atomic_inc_return(&counter),
> +	owner = (void *)(unsigned long)atomic_inc_return(&counter);
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
>  				     64, 0, &job);

