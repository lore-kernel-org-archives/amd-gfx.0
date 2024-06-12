Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92072C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 05:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA25810E679;
	Wed, 12 Jun 2024 05:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vahk3nQm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAD110E679
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 05:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuiFKndfUtOG3AAwDH5MZuc4RTIBLN+ncHlAgkj/tsjjJF/06oeKGjwILgFzLIiVlC0SRRDymclNpXQ53+EL6OCnJlUPTIgghLtOIDvBqtE6bKyGti5fgSfXaDBY+d4Q4cN7T0ernwiR/0N0hvRKNO7eWQbOlqFoUp5Yiq/a6RXLu4J+a+5gabPNRcmhJ3gNvPoVL6tjJcvPO27Zz0+Tq4httDQgjHbM+xki2YuKdovIQ1xJ/Z7LtwUBlcEEfgaHIzF3GYtcdb9kXoV4ywOzA18shSiVb1DM3OgnxT1jWjfLsQe+VuHwxj758XqbZGkZmvp98azi5QCOPjSV/iqEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luVcHgs/QcZrK+z2xfaaz0wv+hx16FFx1/rfV4YxQyw=;
 b=bQvezmtSgD8+Sj9lUKiH9drTgH0PSlpeyWoaS53ByY65Sk7AzHwabsbBZ6EPZJxUcW3A8lp/SheMOot0GjJW38Q36DwgYy5Qg/e6WxGd5JcispGxcAevESLXu0jh+Z9xeSVUtCh3eUu3TIiqyVnMaSVYGj4eyc6n4LqVNwlXeU0L3xUBtBiTLOGjJJfkM63olDq6KGd8K2RFobmgyybsOtM4RI4F4ZYhgE6IFqMe+T9HDbb+V1vJMOKOLpf4+ifxdrFLkmszup4GO/VyF0PMIpsyQ/h7/zr8bqX9emZEax81OwSryExD4NZl1E/SDgGPScp3ctNAkfXUqGjmlunPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luVcHgs/QcZrK+z2xfaaz0wv+hx16FFx1/rfV4YxQyw=;
 b=vahk3nQmlNtG+ky59RWFBOqXbBfZYztRcBGnIeyXRw2aEtKdbBWp8EkUuMH1QGWqO94eji2E/HJGprboz4mxQ8vuheNJ/KmZFDTIvF8+dCcmwBHYDihhBSyuiuduyuq+8GjRG22YrgAS7lKzB2957PCiHzexgTLk2q6tnJzIInM=
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 05:57:58 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::58) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.28 via Frontend
 Transport; Wed, 12 Jun 2024 05:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 05:57:57 +0000
Received: from [10.65.150.118] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 00:57:55 -0500
Message-ID: <fafef1cd-f6a8-43e5-98b4-0631571bb13d@amd.com>
Date: Wed, 12 Jun 2024 13:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: port mmsch ctx table size fix from jpeg v4
To: Jane Jian <Jane.Jian@amd.com>, <JingWen.Chen2@amd.com>
CC: <amd-gfx@lists.freedesktop.org>
References: <20240612034153.229075-1-Jane.Jian@amd.com>
From: JingWen Chen <jingwech@amd.com>
In-Reply-To: <20240612034153.229075-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6c9962-f17a-4a36-8966-08dc8aa49c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|376006|36860700005|82310400018|1800799016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjdqaEh0RWNkT3ZQMzhOd0d1MGhTSDdPbGJyaFNqNGNoM29XUkJhb0gwZG1z?=
 =?utf-8?B?UzFlbWRSNWVXTjA4dGlwM1o2ME9hZ3lpb0ZhSGVJaTg1c2k1U2IyRkk4K3JE?=
 =?utf-8?B?MlZjYUZXcUhDcWVaNjJxN1ZEeFN1M1Y4NGZRUUFWcDdVUnVRWmN5SFFWMjQr?=
 =?utf-8?B?SENhQW01V1BtNkJ3UkRSa2JoVkpOQTZFdXVSMHlFaURzbXN1eUJFVkVyNnhL?=
 =?utf-8?B?K2RPR1RoYTZQTFNPcFkrcmYzL1ptOWRaOUZyUmZ1V1d3MGhOL0NSUkdLQlg0?=
 =?utf-8?B?aCtid3hWWlZOazZwODY3dDdHWmZoaEFqR0p0VUxFVXNDcmhjbHBzUWF4Umdk?=
 =?utf-8?B?MW5Kb0F4ZWU3SEtlOWNNaklLKy90NSt5aGNDWFZpWXBlN1k4cUpwZFFGeHQx?=
 =?utf-8?B?KzdPZnFhOGVNMVN2cDVVU2U3NDlmdWhKemxoVzUrWjZ4TWd5UjZoTFlWN2dN?=
 =?utf-8?B?TEhrdEpLVlV2VW5paHFVWW1TYWQ1NVJZcVdWNHdPdkptdDIzRjNNNTZvaDJq?=
 =?utf-8?B?QUVDNVhGcXZ0YUkwcSt4TlRCdUhwSDVYRG5zYWxFcHdBOVV6Ri9PKzRhejhW?=
 =?utf-8?B?Unh5M0l3TFZPeTZ6YlVqdkdZbVpKZEo0YUZRS3dJaHRNTDZ2aVY2MTJlVDhU?=
 =?utf-8?B?S1NwMWh2QWQ5cXkzbVUyYW43bk9IZXJhUE9rUmlqd2N5SURvMDJ6QkFzMDFh?=
 =?utf-8?B?S0tEbzRxcE9UNEJsOUhNU2RXRlFvWEtqaldXNmF5S3pVSy9ldUFYZ2JIeXBE?=
 =?utf-8?B?NVhDOTdkOTJPZ3hra3BWSVdreTgyanJwbE85Y3I1ZXE0QkdpcDZlRmw5ZGZy?=
 =?utf-8?B?V1Nhd0RXQVVMVVZ1Nk5pekVqV25RaXQya2FyM3daWTNYZ292QWJubzdUUUlM?=
 =?utf-8?B?NGY2Z2FKVjZCc1BBQmJaUkgrMGQxZVJwNzRXVUVOVWQxTkNNMTJSdmxtcUts?=
 =?utf-8?B?cnRZZHo4UUtOZ2xZUTJBcVR4SW1SRlhPUS92c3prUzlRYjdmQmJGYWxmV2Yw?=
 =?utf-8?B?a0Q5VHo0VGtyTXc1NXVNNHBnMXVOZnZpbFRIQmcyWVVGY1Y1YWdLcWt1YnNZ?=
 =?utf-8?B?ZGt3a1NpMHEwZllEN1hraGs3MHRYMFFIYU5RUDE0NkRUWDAya2ZHMzJ5WGR2?=
 =?utf-8?B?SVUxRFRvNHAxSUFvUVZzNjR4cVR6WEN6QnhSRjB4dFZpTzJMcmFua0puMHp5?=
 =?utf-8?B?YWQyQ2o2N2JueExwMk5HVjZQdzMxYkJFYmpEUkdSOHJ3cmJrZWNMNDhCN1lJ?=
 =?utf-8?B?STVYVUFoZ2piS0dZYXF1S1E1UUZSZTg1aVlMbStFY1RNTnZ3a2NyNXdEWHg4?=
 =?utf-8?B?ZWtWMmVEQWt0MnhGQUM3ZEtSNTU3d3NwUi8rUlBpeXBFaXJrTHVUS0FYU1dN?=
 =?utf-8?B?Z3BQOHFQZVBiRjVvZlFNbitFTUd5bWdqRjhwV0h4TmxxbHo0RnROdUpkZXYz?=
 =?utf-8?B?UTR6WWN6TUxPNGRnTHdhQ3B0MVczbFVZUG5mTkdoOHIwSml0RzJoa1Q2aWg3?=
 =?utf-8?B?TzBMU0xMRGNOSlNGTmFFQWR4YVZDYllPY2VkaTAwZm52TnNXb2tXc1Z3MnNW?=
 =?utf-8?B?N0xyMUw2b0NoWXo3QTkyRmVla3lDWFEvSVpiOWExMWVOdGV5empyVTArVzBu?=
 =?utf-8?B?bXB6RE9tQTNCMzdvMTI0c2R6Ti9LMkVCNkd3ZE9lWlRVYkhoaUhGbG4zVis2?=
 =?utf-8?B?ZkRCUTlicTQybnhIeFhLS2x2Q0h6R3g4TGlpcWhESTBVK3R4anNRYy9iMUov?=
 =?utf-8?B?eS9NR1liUFl3dTRNeXJPZlo3Y0J2bVhjck04QVJuYkhpcEd2RTZvdmhhZHZo?=
 =?utf-8?B?T2U1S0RXTmYxSXhEUWZrbGtxZWdXTDUzWnpOT3JEUlM0Z0VSVGxaUE1KZHF6?=
 =?utf-8?B?WW1LSXhobzBKRjBMV2J4Wk9BWEVjYjVSZEpQOVVjYWQyeGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(376006)(36860700005)(82310400018)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 05:57:57.8204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6c9962-f17a-4a36-8966-08dc8aa49c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

feel free to add

Reviewed-by: Jingwen Chen <Jingwen.Chen2@amd.com>

On 2024/6/12 11:41, Jane Jian wrote:
> add jpeg table size to ctx table size rather than override it
>
> v2:
> save jpeg header info otherwise it will lose debug info
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 04d8966423de..ba052b104668 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -200,9 +200,12 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>  		jpeg_inst = GET_INST(JPEG, i);
>  
> -		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
> +		size = sizeof(struct mmsch_v4_0_3_init_header);
> +		table_loc = (uint32_t *)table->cpu_addr;
> +		memcpy(&header, (void *)table_loc, size);
> +
>  		header.version = MMSCH_VERSION;
> -		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
> +		header.total_size = RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE);
>  
>  		table_loc = (uint32_t *)table->cpu_addr;
>  		table_loc += header.total_size;

-- 
Best Regards,
JingWen Chen

