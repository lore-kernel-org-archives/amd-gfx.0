Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 16:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54DC10E930;
	Fri,  4 Feb 2022 16:27:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A81910E930
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 16:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N05iD0QgHWqw4LisA9QaC00PWhcAftNl9s0C1MtepPD7O40xwbrP2A5BesDKBkasxXy6f//fJU6WBo5iIM46Yk8GjP4WLGCAFMVj82t6oRQ1AS7Ge42lN+QNFliQQ7natOQ52sPm2t/Qa2Lu6tLNnT0q5AshgpCIKh1MkwTjVSP3A6tE2Gda83DAa7+bWIwL1S/STr4sC2iSpv0eNZCmjVjGAw6DzDNEDxJOwTf0m/StmmIX8AhSFdcWpiAJOZ+AbkmBO5118X8euepxDGagnBvHnjF7LWptw1y47WgcOkflJqbXPzhrLj9LVBWp6B0p/mmbGzben4sDOHKktI/oYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGba/DYmiKg61gZzIPymU48cM8xr5DwjtBa6fsJv2+Q=;
 b=iY8gdjXRb5dt2VaWy9NLFsQTc9srOhdC6jWz5/cNpx4qmsAuhMtF7+ZQatkIog4QdRdpmQhKuWTAsx7qV26s27S+qwckGQqdlkYTat1nmlNemJGZembx7Zs5Ag6egcOA5CvW1TGD/gYIenTkLHPAYUqFtuOTJSSgPfgyMbMsL1Sfla2NOvZYvK0PaHvWvSM5XfTB1wg6zpxDemeMUUb3qh5DESBjLPIN5C+xc9wOy+p0NbC8CJ7Q0s+G0RurMIFonWy6Ki8tGGrGIzTtfWS0RYlADdvAYXtNg/MnNrXgJDGNdTmcgToQuVNd695JM1NDD91og34pFW1qvpCX72GGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGba/DYmiKg61gZzIPymU48cM8xr5DwjtBa6fsJv2+Q=;
 b=TUZk+4LwYAtThKdPLC1vSN2jpxdo2InmNQ6qhR2GOUd7mIqbLUBjSQSwjemKxO9gi2OebJnDM2r0ciXg7LY5fo0p1STj8YzVyi/zudpwYgKDVR2tYrVHPwjUqCHnAiV4wVvxWNhsoYcYEqIUmcMYh1IbcYdOdGhM4lxjfVLTpaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY4PR12MB1655.namprd12.prod.outlook.com (2603:10b6:910:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 16:27:37 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 16:27:37 +0000
Message-ID: <f71ee97f-7f40-13ab-5796-4aa85f53dae4@amd.com>
Date: Fri, 4 Feb 2022 11:27:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/3] drm/amdgpu: move dpcs_3_0_3 headers from dcn to dpcs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220203185847.1473998-1-alexander.deucher@amd.com>
 <20220203185847.1473998-3-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220203185847.1473998-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c38b3bf2-8b2b-4c38-f718-08d9e7fb41a6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1655:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1655B106011892EC41D0D9D88C299@CY4PR12MB1655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AI7es7sr7jsfzqe3WGhKlqRLFI6Va1k6d6VJM+7OwqQH4igJYJEndn5LZs13rTR/eVbf1DCecrBlsw18jqKkRd8mBAX18ZBtrvYsTjSyoJbFTdJOYf4nstwTQR7QzKlwiANDxSIGNoQoc9DbhGT3JzKt/ho00D1nSYQkyhJFgcVj/oOUzHG0QP5aosKeepb07yS0eMlTWqP0ezOKd7+UyKztFGsNMXRDleDhe0MaLlUW6TUk+I6PNc0r/qWIHQMnic/cA55o6QVYpRTuYNaIW8XVRJrgHFUoe+F3KqGDKgN3nDEEFhP2OIV/3MqsYXB9zK5BsQAZ9PFpHmUwh1FmspngwAARgUOE0zn8xzajyxZjvWMG9fG0WmCLBhyiFZuiWJBlgvs336W/wResnKg+cWB6buOh3CunVtXRNQdrlGtlKOCp6M8EE/vTyVkR+jcXcpCgz2jDvT1K7NrV9b9iUmWSgAOt96unOf75cqGTHxfcz7JcYbcEnfSufvqt41ULZ9eiByTyCOyVQbhfGqjIFEsbSFnjoH+UDC6bQJJYMiuFdAkm0PKWetEEnnlo0rWq04IKUyEhcvK5emyRQD5kJfI9fXxgooN5VbYrMb6NnKhOZlKv78f5F+PNaOWoReg9Hzr8/R9nKclYcudIPGv1hZQnDNamQwH/GfavR74l1/9ZUy7892z5/azzhJij31ejgor5X90H7djhaPLJzjXWmNuZxGfyWdPvwvp6cIGeqwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(508600001)(83380400001)(8936002)(66476007)(6512007)(2906002)(36756003)(8676002)(31696002)(66556008)(86362001)(5660300002)(6486002)(44832011)(31686004)(316002)(6506007)(53546011)(6666004)(2616005)(38100700002)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZsZXh0eGpIcFQ2OWF2MExKQndBTDRZNCt2ZmNmUWswMjBKKzNwd3B1dkV3?=
 =?utf-8?B?YjAweURITlJOTlFCN09LU0NST0czK0NTeEdNVTlqQy9iSHBJSjdDR3JTMWZZ?=
 =?utf-8?B?S3Z3RTBWdEZJMzdROWREUGFOaXhsWlovQks1c0I5RUJxYURCTk1YN3M5TjVn?=
 =?utf-8?B?U0k4WkVJdFJhS2ovRm5NeVN2ZUVmeCt3Zk9ndC9WbDNkajdVbU9MU3hwYWJ5?=
 =?utf-8?B?UHlXTEdUWmpONjRvR2x2dDZkcUpuazU3S0x4dU5pWFR3Yy9UVmhFUDBEZUM5?=
 =?utf-8?B?Z1gvTG5zSFd2NUtkSThQekNSd0g1c3VlOXg3QWRMenUwOWhDMjhOMFNJSDdl?=
 =?utf-8?B?S3VhczU0cGMzcmozdHNvSVJ1RGFJcDFkL3p0eWN2YXMrQ1BPVVdxeTBQUFd2?=
 =?utf-8?B?UEZ4S2NKdmp1U0I2T2RTTmFHdFFKYVl5bjRrNndQU3I5M3hmMDJNekwwRjlu?=
 =?utf-8?B?enJDTzNONlo2RERwYnk2cHhpekJPWmRMSW5hSm5ZQ0ttU3BwS2xrbC9NQ0pt?=
 =?utf-8?B?WksxaDRVcE1DeUYzdGIwK09PWG04S1dBbkF4RHA5TDFwUmo2YzNsZkxXSDZw?=
 =?utf-8?B?TmN6MkluVC9peHgwZkNuZFA5ZllZbFFHTnpGVTFKR1BzMUlTWnI4VzU4UkZS?=
 =?utf-8?B?ZXVrK25GSTArU2lRVTdwdU50dlNXZnpjSjNQdFZiTVQ5MVRKTHJWaFA1KzlT?=
 =?utf-8?B?czYxMHgvd2ZkQTUxYkp4WFE2dEdFOU9qbW1XRHBrNVVvTDZvVkRYbGIwMFFF?=
 =?utf-8?B?T0VQZSs5Z2FMZkxITytZbTl2d09xR214MmdyYzRIaGRmN0EvZzU2MlFaUVRh?=
 =?utf-8?B?cDk2MDdyU1lZaGFNNDQ2RXRyMUlzSDV5YVI3QWRkN1J0SGw1QVIrTGtGZFVl?=
 =?utf-8?B?MlU5YVl5YTk0TjdUUVM3YnN6R0syaElsUGlyb1A4VExhL1plaUdwUHl3V2pX?=
 =?utf-8?B?MHdQNDYyZ3RiRkZMNUpUQkljTm1oMUtOK3ZzeGxrd2lTditEZzFodERGL1lv?=
 =?utf-8?B?NVJGbWc4NG9GS2pyZlFMek95a0N0MjhVVlY4NzRWNHUwMGUwMlF1Wjd1ellL?=
 =?utf-8?B?dG9Yd2NUMUNvUHZLV2pyQk9yb1lMOVBMLzlqRVpJZHNsem5nUitZcVdkdktD?=
 =?utf-8?B?WlU3c2hQcFd4bkw0d2J5dWN2SWpzM2VzWGlrNEorL3VhRnFlSjFtSkFvblI4?=
 =?utf-8?B?ckpJL29MVUlkZ1ZVYkYvcWJxMnZqZkdWV3M5RUJXYmU4SWxYbWFEa2RkelRN?=
 =?utf-8?B?UlRUUnBFbEJVN29tYkVWWlpMK0JFRWlueXJ1Rlc1VURsbEphdXVkUXdTa3l6?=
 =?utf-8?B?MVd3M2JYWnVBaS9FaklBTjZUUEFQOXB1dkU1NTZUN083c2tsbWUrTDdSRmFM?=
 =?utf-8?B?UkJoVTd3VzdxSm1HTTBYRXR5cU1SdFNTcmhnMVBHdnBrWFlxc0VMSXpRK05J?=
 =?utf-8?B?Y0pIMDBSS0ZmT3FmblY1RzMxNlZSaktSdGdGcTlRK3ZOYzc2SGFYemRKazV6?=
 =?utf-8?B?eFFRMTF6K0hFQ3MyM3dKaXlFK3ordFpWcmFyVUJXOGlLQnhzdkNDYWwxV1A4?=
 =?utf-8?B?UWwrRFhLVkFSb3NySm5hRERXVTEyT081bGtVU0phNWhBdEsvRllXd2xrWkJG?=
 =?utf-8?B?UW9scU8vSnpWTW0xZkQvTVdiNE5RSUlSQ21nSU84eUsxV1FOR0ppYXYxSUMr?=
 =?utf-8?B?OElmOGRaNFU1M3hxRFZoOXFDVHhLVGR2VmhGVW9RK3VVaEUxRHp1UmxrZEp3?=
 =?utf-8?B?ZTREbU5DKzNQcDVpVzdkNndsdndoMkVON0Z3T2puYnNQaEY2VENxbTNiY2VY?=
 =?utf-8?B?UldNcUhrcjA1SERwNks5M1N6djA5SUZrL1JIZm1PQzBrZStRWTFwcXpUa3pH?=
 =?utf-8?B?T0M3bGtLbkppbEhKYXF2NzFUdlhBaEpDNHhzdzI2U3Y4aWU3VjFscFRxNFRM?=
 =?utf-8?B?UVdTYlNSZmxGS2dDeUM3OUVXdldrQUdXbHQwcDU3SUVVcEg0KzQ4NDF0QkZa?=
 =?utf-8?B?ZmxRTkZYaW9QTTVqVkozNjRiZnBodW92c0NOVXkxN2FEV1Z3K1ZNNVVJeEtz?=
 =?utf-8?B?TFFCd2ZFbXhCMDlNbjNZaTNHR2lhU29pbytTOTlGcUs2OERhTnVWOTQ2ZCtB?=
 =?utf-8?B?dllKQ0ZBQnluZENVY2VjNFA0Q012L3c0MFcrbnQwZnVmSUdJOER3M1VZM3pF?=
 =?utf-8?Q?2OgdYYPoMpFNrv2QgLJelk4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38b3bf2-8b2b-4c38-f718-08d9e7fb41a6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:27:37.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1J80uzzin2ygSBooslzSI10Z1C6eyMBxOiwGqGzxraefxGSY5B/d4enZlqYlcUavpETf7TITDKk00PJ9Vb1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1655
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

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2022-02-03 13:58, Alex Deucher wrote:
> To align with other headers.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c       | 4 ++--
>  .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h    | 0
>  .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h   | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h (100%)
>  rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h (100%)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> index 2de687f64cf6..36649716e991 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> @@ -48,8 +48,8 @@
>  #include "sienna_cichlid_ip_offset.h"
>  #include "dcn/dcn_3_0_3_offset.h"
>  #include "dcn/dcn_3_0_3_sh_mask.h"
> -#include "dcn/dpcs_3_0_3_offset.h"
> -#include "dcn/dpcs_3_0_3_sh_mask.h"
> +#include "dpcs/dpcs_3_0_3_offset.h"
> +#include "dpcs/dpcs_3_0_3_sh_mask.h"
>  #include "nbio/nbio_2_3_offset.h"
>  
>  #define DC_LOGGER_INIT(logger)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
> rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h

