Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB077C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E5661165
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59E5661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2896E425;
	Tue,  5 Oct 2021 15:46:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1408D6E425
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 15:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHC8n9JrkHSXvRWUdL9vYJ6Z/C4HtGgVJE7Qdp6G0kf8BCLUBcFaQ04Xi9UzFakBMcgtMd/YHDzwjmlyjs67vBJmnnIzz6bI1W1SJjcCHJO1ccPxetCQ2zsUcdSK4BaBQHFz7EY+ULTH7XDNIKpFdJ8d5L8sQFnFhddK7mMP/iYBeCUM7/ao2rsnNBASMRHZqI+Vxd346X8wnj/7c2t3TVyJNyQDDh4mHq56VWfQWw68VMz4JKkQ5DK/HVo/0cOueteuCeEfL5zmmKD7yhzpNJ/bMWpyFUSxST11YD4A3JBIVuGXZhsIOgzbiysxkAvGNdH3GhwCKKuX1a/nfoy0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUumlLcXmcakXBX8MMMkVQgTm+x1/O4NMgEnvmNC6gA=;
 b=TtJJn07DJX0AGATSWcTnGJz72gJSSNVe3xnR0mgex/UDNMWrXi3DuKnc8ryNYfFhJW8KzzFeexExpihDIgPiDkcwEgirFqzTLkvfy73XBsKZLpD93e6VZEn6MMfqchfjPR06Sj6UPmTS+jnONVf8UfrMmhJsHvGiZ8K3hmyfZ+HisY9gy+uFtw5dJNuP53XlrdBR0aQUrdcRIW7fBpjQUJ9XNsmc4VbNvzIT72b6KZBIDKOK2oVaNgXGRUmB1u9a8Zbf6v5A/IsKDhOjXUdw+ZTzVOMYf6ahLwTSoi439rjdS4kONWi8SGoxeJGHbjbjV8bSBpEKnWKbO5XyLO1ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUumlLcXmcakXBX8MMMkVQgTm+x1/O4NMgEnvmNC6gA=;
 b=MqGJcktdhCd47Cv/KxDintvMdIiNmD8XKK398Q4uCaxhhY8wR5fUbY6Kwt3LIAfikUzqUKHFtnAsd8VRqzCTOS66Q94ET70TJ8I2SgV291dtPqTKUn+XVKXQLv3myGGy5ZsDUs4MNlR0qh1xL3g1kuErsnQeQ+KMJm+yZisnPa0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 15:46:17 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 15:46:17 +0000
Message-ID: <a51aec02-bf3b-d034-b926-c4920749769d@amd.com>
Date: Tue, 5 Oct 2021 11:46:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 04/23] drm/amd/display: Support USB4 dynamic link
 encoder selection.
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-5-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-5-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:408:ee::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 15:46:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0635bdf5-fd49-4235-6265-08d9881744b3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5412B4ECD50D3C722BD3CE478CAF9@CO6PR12MB5412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yy7NRhqa4nHfceU+vrnt1BuUmFhvjVPjU3r8CKsgUgRf1Q9NLW+/8dlBeGlz8WraaGZedrAXselqYP/7HQQVeLZ9ejk9/YjfBWlYePx3WqdZHKkmvHaMNZ68jR8dZ8P84IH6SKuDC8NwjWjsR8+q0r2S53vAF8hB9ZKwOMKJsd/6yEmCtApte57ZRALfbOG6r0DJW1zw1dDh0lSo6+dXzskNyZwITh9xxay2LPGi7ZSI3DLGidDTiyL91Rmu+WohzLsodT++fumwHf301ZijjO+GeFaTwdrwb6/B2INbqE5fPHCnSRMeKR1ndpW/mH0yz+V/7WuLKT3crzQHm3MFA04Ix1mDAH5sNoIhi4RIJ2k8XMXA5uhqX762izDjmB0hAoIxUelDbVYJuwD7ADTOhPD/RLfDNujVEE6K6adNldY4vXxZt7O95odwZR3iL2PT5MEsp7V4At/5o9J5nJtIuIcRYsB/Vy7MC/gXp3BQjrWWOocLtnuWgqmAdw/1x8yfmrcFxByVezLsKnN4MmLQd3lW/shQ1YFdj4uCZ9yT2t5JAWfTdm/qQ6O3/7QcE3NzXbVi7SEVDFRmsq41lWn6ksBJj2kzZD7+Zl28Jc0FFyodNJHvvMytlkOEoDqxGCnsLX8BdwPvSM7gptEgxUoW1oCeIaIYh1/Yl5SZG1dISa4oazOchTV64nC4ewplwuyIBM/hu1P8PJhEkKvUvJ0pMGQ9BjuQInEVb5bA8snEQto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(53546011)(8936002)(4326008)(26005)(31696002)(38100700002)(44832011)(31686004)(6666004)(508600001)(2906002)(66476007)(316002)(16576012)(86362001)(66946007)(36756003)(2616005)(5660300002)(6486002)(956004)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdHbHViRUoyRHkra1I1cmpKSVpiSk42eVVxbkJvT091L3RiR0xremRuMm9D?=
 =?utf-8?B?V2pmOGNKSHJPSW5ZR0hWVmJUWWRCT2s2cEZ0TlRGUk9EbndqTFU1YWhBbTUz?=
 =?utf-8?B?TDNXVVJ1aWROdGMrTWhnNU1jQytNNHJ2S0ZhRUg4ZXYwRFpRS0xkQXBjQ21s?=
 =?utf-8?B?NGNZdk5panE5YWx5Y2RsVytGT2tySVJ2S2REVlZyUDhZODA5elFFOXBUcHUy?=
 =?utf-8?B?TUIwL0g2d29oRmhVbk0xc095WDhDUFNLTWtqZmN5N2pyY3Y1WFhFblM1TXBr?=
 =?utf-8?B?K0RSZHhqZUE4Q1pqb25FY3E2RksremczaVBjdDl1Wi9xUVJYdUpydXBDRFFN?=
 =?utf-8?B?RWdKSUJDODhvOGZJaU9wcUptN2FDdFlXcGM5NVlsTXJSanRBUWdoVyt5T1l3?=
 =?utf-8?B?ZVJlQ2oxY1ovM1VBU0Y1ZWNsY0RDZnZMQjkzY1JjMjRabkx3K3FxZUE5VSt0?=
 =?utf-8?B?MUxocUlTa1lEMCtDT3NVdjZ6SDJCeHNDMWg0bEJ6Ym5ZWXNreFZWS3IyOFRW?=
 =?utf-8?B?MzBHY3Jlbjc5WElidDRKYzRNTVFDdkd0ZlZ0Yng3a0R2eDJYOUNuaUxrcnFl?=
 =?utf-8?B?MGdWa1JYaFZnL1ZUaytzWGdhWWpsQnRON0V6NStxTWlxY0J3WUlGSkdkeUpU?=
 =?utf-8?B?UTU3a0c1UDJtYnNTbkVSSXZBSXpsSEl1WURmNFFvRVRXVHR5Q011elVzdnRq?=
 =?utf-8?B?Y2JxTDkwRytyeXRiUlcxQVlQRHV0V0lsaEYvVFV6RExNejZBVFRaaHI2VW9a?=
 =?utf-8?B?MU83N0lGekgxbm85ZW1EZnlpcDlORzBkam9wVnR4UmV4S1R6UWRqL2s5RDkz?=
 =?utf-8?B?RGRwMXZEUkJYOVd2SHRnS3hoMm9ZTVQrUnZNRHdMc1M2MXg1UWp2eXRwMk9O?=
 =?utf-8?B?d1BBQVBVQ0JCUHhMaDFJdnNlQ3pXVVVTTUZabjNSQWxtcUViZW1STzZ5VXRL?=
 =?utf-8?B?VmJoZXl0ZlpLQUhYdVRDOEdCWVdCOG0xVjhRVHB4R0xiZDJ0a2UvT1pFOVd4?=
 =?utf-8?B?ZFEzcVFIQjdwVnhGNnFwVVFIeStYdzlHRzkxNUxHWTN6UDBEaTFwZy8zMTdQ?=
 =?utf-8?B?dzlCTDVnb2xKU0lZZEVWUGVvRENSaVR2WWx6R2xZcXJWTDhMMEdRWHFjSkVM?=
 =?utf-8?B?T1l2d1FsMkVNcVNXZDlzMENVV21UN2dLUSsvTGdYby93Z1Z2VlJ2NHBvWXBU?=
 =?utf-8?B?VENZbnptaERLNGV0ei9iR25ZUytjQ0VUUy9Lc2FsdzZNR1orOGNLVGw5WCs5?=
 =?utf-8?B?WVJxZUJYRHNYZkNTbXMyMUM1bHhUSGlsQjBpZjA5dTN4eDlMN1FiRnBhMGNX?=
 =?utf-8?B?aFNyYXdMZFIzZHhvczZOU3ZQb0J5bDQxdVRuWDRnOEV2ZldpUGl6U3U0YXov?=
 =?utf-8?B?WTVjQ3hMZkV3bjQvZXYyOW9oWFIrZmpQVUZKL3lBUDE0ZjlMU01WL3k0WDNR?=
 =?utf-8?B?MDhzUUxmYlBoMVB4cUI4UWdZWHlJaXh6Zi9CRkJsZXlBdFpQcGRSd2wyQ0tD?=
 =?utf-8?B?a0lxSmd3ZlE3ZnEyOVdKbG5BOS9BakpTYUNuY2xGVlBWNGtETWJuQWpXQnZy?=
 =?utf-8?B?Q2hMcExXL0VwdXVtUldHNHI3S292eVJnNVA0YTJLdmZhRjM4UXlLM0tOZ2ZT?=
 =?utf-8?B?RUE2R3h3dWVRbkpPczJ6UEt5SGhsaUwrV04xTnZNbEhwYUFnNElCVUE4cGN3?=
 =?utf-8?B?cnpDKy8rR0dSR0szaHprSWRvZWhJeGVuMHN6enRyZGVJck5KbmRrbHJLSGw1?=
 =?utf-8?Q?yC2lIw2vllhJol7pdVSNl5M6C6R7CHu00WU+9ey?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0635bdf5-fd49-4235-6265-08d9881744b3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:46:17.0466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhhErhscAMlvMyWLb5e8f/8VTiwGXupmXiVxCtpwAfvSZ2lDuatHfnKcIIruXS4RUruIyICpd3Q/uXt/NIPjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412
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



On 2021-10-05 03:51, Wayne Lin wrote:
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
> 
> [why & how]
> Add codes for commit "f42ef862fb1f drm/amd/display: Add dynamic
> link encoder selection" to support USB4 DP tunneling feature.
> 

Title should be:
"Set DPIA link endpoint type"

Description:
"We will need a way to distinguish physically connected
links and DPIA endpoints."

Harry

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
>  drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 20b4819b73e4..66182b8c217b 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1732,6 +1732,8 @@ static bool dc_link_construct_dpia(struct dc_link *link,
>  		  init_params->connector_index,
>  		  link->connector_signal);
>  
> +	link->ep_type = DISPLAY_ENDPOINT_USB4_DPIA;
> +
>  	/* TODO: Initialize link : funcs->link_init */
>  
>  	ddc_service_init_data.ctx = link->ctx;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index 3c109c805447..15c353c389d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -955,6 +955,7 @@ enum dc_psr_version {
>  /* Possible values of display_endpoint_id.endpoint */
>  enum display_endpoint_type {
>  	DISPLAY_ENDPOINT_PHY = 0, /* Physical connector. */
> +	DISPLAY_ENDPOINT_USB4_DPIA, /* USB4 DisplayPort tunnel. */
>  	DISPLAY_ENDPOINT_UNKNOWN = -1
>  };
>  
> 

