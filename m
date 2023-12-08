Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A58C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A9F10EB4A;
	Fri,  8 Dec 2023 22:25:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67B210EB4A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmHmZ3uGLHxQDFZ4KohTKC084kwkHQKYFHQXnrpahgAOGNfEneawdSqqNAL8D66DDzrFNlSSL8qC892Vu3iiYYbBbyj8MqXj7hkgTKfv2tL2LgPo13+Q/Gd5x8AOVAEkr50C+GDO4LKMa22OIVqqObP7NbMutL3hNok8bhvNDgaDHnl9A23wAlULej8xn4QgiKgALeCSL2+zLGtGuTcMTwcHls5XHWLrD8cIMeojfCYtYW4dW5e039dKK82ss0T6q5wbxIAB9rkPqUcWsM6T1/C1VUASy9nfh41HmtfckpiDAicNdY5l+Zpk4Y9ktcLNa/jfFUPMokI9Vn0zAAQcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDVKtY09bblEQ2ZJlGAkZkN2zmfs+OrF5IBhhBV8B+Y=;
 b=ORqSTVBa0iEVobo6wA7+UsjPPhGcB4oq4WVr5c33CWlFJT1Od7sjggTlP9nCIZ1WT9c0RhIOX8OjWTwM4lv2cgtODHNgAadT7eLCMaG8Dc+STqYRvENGDsJymqcaPR9Hzd4A2XztzkSxph7v/VAto0qX8IMXXWRWqnQhThjMjQZJLOktSsB956Na85G7YzC9G/hDallZz4L6iDFMV/8fpfXHIWBpAawrJ2mcmHuCPcvj377C/Bp0vyjPkrkeEG4r2pkWkvzg9FTTYyga7YwszHJ6AhT9wJvOS06Nad7331vBX6qvwsycVpFQ/LQw7TVmuSeq3hSaDG2iO6ixFWqefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDVKtY09bblEQ2ZJlGAkZkN2zmfs+OrF5IBhhBV8B+Y=;
 b=WeHMDQPlOdkB8hHxVvbzoHVffju1E5WT65hHaXL29q2bMdEoN0OL7Miqzj/Q2Sd54w7wuANqcFCVpICiplx8xSsuaGIc4Xt5N1b1oMD9lUDWuUcYx2thFCorAyUOVl5tHQwhjWr+Sc3CwSQjF3sfxvtJbWFvRKxSdiKtqfKEOjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 8 Dec
 2023 22:25:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:25:25 +0000
Message-ID: <b1cda1f5-e0f0-400f-820a-e757cc3b15bd@amd.com>
Date: Fri, 8 Dec 2023 16:25:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/sdma: add begin_use/end_use helpers
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208221928.5679-1-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231208221928.5679-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 9873ec66-c29f-4b2f-737c-08dbf83c92ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLyr1VnWzwNs/QaXhqMwL468iSxBWYkpAJDtx7oHDt2vKdQ8gKjV45fpSAcoVIlLOcpbZ0IRKMfr7Uog6ozqUfUj+I4VaOuQZ88OH03axN5mnXAJGjZhWalG+LnlhfiE65HZXTtzjAfXi8cPkp8d9PzoibrDUEpO6a5SlNplygaIaFbC4v79IhcRVWxcC6r6Tv1cOl+8vKkTreTxWgAFJRnx2KmF/YRzz2B5vBb8DwllcZTbK2q31/CwCEJB6dWkzCjDZfhGmJ2zh1JrKOAOjZeSvN6jpK31EfDaLYj10G55Eo0C1fRWe0U5DE4auPHtqAKiZUhdAEMqT0zAHMcWua2QzMgNvLQdBZmxjyBaSUz0UjYLFZP9ECg0IoP/Nfuv8B/7fyGCbhxEMz5wh6xPAXPkesT4bEcOrv8YzVOren0gCxTLGJqUKBuR9u8yf9adNNudR/ruSXxyL1bk433obCqsVDBlnOEjAdi7WJoBpBS79CuAZSOt/VSKVW/KOat/t3ywpNWt0RCGwzA794lROKXsIHvkHfOu84qZ1VRSVSbrw7NMwHBE/v2uPkY8wi7SxiL6s00dmYu2JmXS9pkD7Jawjen8LPQeSD1SlZS8BIck3ggGJW5LMJSUPwyfdGT5LM22tzufOqMdaNnPp4VyGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(41300700001)(2906002)(478600001)(966005)(31686004)(44832011)(6486002)(6506007)(6512007)(26005)(66556008)(2616005)(66946007)(53546011)(66476007)(8936002)(8676002)(316002)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJueWZzZHpyMEp4MU1kclhmUVdBRUFDSFZsaHl1b3dWVHFCN0N2SzVPTkZT?=
 =?utf-8?B?NjhoOHpjY2c5Yk1nTk40cmt5OS82UThqVnhxMzBvOVBLTkVLVkR3YmI4ZXMz?=
 =?utf-8?B?aEk1Y3lTTklIb2wxTnNJaG90WHJ6dVVZRnlJaDlHOWptWDJFQkIzZmpUOTVs?=
 =?utf-8?B?MGd1UHN2dzI1Uk1xMGwyRXI4NmVjZ05UUHM4UlZWSlphRjNYVWtnbTZpd2I2?=
 =?utf-8?B?OEdKckhUM2wrRC9rY3MyN244SXcvU3FsVWUvOHp1UnM2VjkrTEc3cGhJWW5T?=
 =?utf-8?B?ZTNETU9VQ0I5N2JTUWdCZThHZU9LaW9rVkJJSXdVV0s0NHBoM2ZDMno1bGRt?=
 =?utf-8?B?c0x3ZXlKb2RqUFhoN3lIRTY0dXVJSnFOK3lWZEtCeTBEUHF4bWlRSlo4ODdx?=
 =?utf-8?B?TG5LV2FDYjR0MUhQNW9ydEZtZWticlZjaHlsN1lDRmZ1cTd3SXd5WUlNbHQz?=
 =?utf-8?B?Z01sdWt1bE9EOVhPRmNyZDNIMVNrZVdwU3p1NXhmeEloN25SVVZkUEJmYzlr?=
 =?utf-8?B?NU15elh4UENScjI1MzhweWMyd1kzN28wWENlWFZ4M3dKajY1TU1JMzE4aVZC?=
 =?utf-8?B?TVlJUEIvdUl1dmtNYWRXZEw4aUtzWjBCZS8yUzdFZ2FNa1pxMVNXUXRuQ0Iy?=
 =?utf-8?B?OFBSWGhHaDJXa3AyMUtXNXF5c3lVV2tSc0tPN1FoaWlYKzZXeVRxZ21oNWlC?=
 =?utf-8?B?RGpIbkVtM29qM3BZWDJ1dVNWb1RvcEF6NXFpUWpLVjR3NkhEUzJwSS9sZk9H?=
 =?utf-8?B?Vk5Td1EzNkdYU2U2ck1kcTJqL2RQVlFCVms2NCtYZTJFZXRONUZyZGRlZUFv?=
 =?utf-8?B?ZzA3bWtpVU9yOUsyTVVSbG9nSjE4RlZVTExKeHVjTHFYWi9nVjNkMHpoMUVv?=
 =?utf-8?B?ZllZU21tcU05enVhbU5HVnZmMUhaYU5LYWRzdllUQ2pBVDhEMmEzQTJYdEFS?=
 =?utf-8?B?d2Q5Z081WjhkZlBjZkZSbVV5ZHR5d093Q1JCRVFUdHpCaFFzT3hsVlNsc1VE?=
 =?utf-8?B?bDBjT0xpaGI2SXFRTnlzSForeElIUHh4TGdzRnZua3VlVHZFNEJiSjhVd21V?=
 =?utf-8?B?UFU3U3F0ZnVaL201RC9EeCtqSGkyNGJrZTlDVHRXejRiWUhOTUgzbWsydnhu?=
 =?utf-8?B?VG9ZTnVHRnpTWHJIT0tqaDBKR2ZrNnpUOGNDNWpXOTFyNmJ1cDYvVEJSVEg2?=
 =?utf-8?B?UGY5MGpnYnAwcTJxSE15MGIvNDlJZ0tSZkMzSmRrdEhlaVhjL1U1ZHRqU21Y?=
 =?utf-8?B?SnVsQ2QwWnNVUTlsYjNzalpyRS9VVmJMZ3V2eHZTTDlnZWVPUGJSL1Vtb3R4?=
 =?utf-8?B?SmQ3dmZScDB6aE1vZWlBNHdEY3BnYjV3azB5UEVCdjNKS2RQVnBtNE1EODNq?=
 =?utf-8?B?WmFrQ3hRMHIwSDZhMkd0UzZwZWxXS3Z0UmNCczQyUXJPUlg3NXFjMTZGZWJG?=
 =?utf-8?B?VGlkRE5GRHZCRkx3MTNzOFNCdVdXSHp1cHdBM24wd0tOUG94RGhScDZhQWdq?=
 =?utf-8?B?Ny9nQ0ZpQmFJejVqeWlBMWFsR1BPSVc2aWdNVEx2QXJjY2xpRldkZGxMNnd6?=
 =?utf-8?B?cDJ2bkFSZHJZSEx5WjVxQk9Hb1R3YncyM0x5NlV5Vi9mRkM5cXJ3Tk42bEw3?=
 =?utf-8?B?MVRiV0swbkd0SXZaRUM2QWxoeFc4Z1lDNmpqVHFSTFJuaUFkNG9uVnpMa2N1?=
 =?utf-8?B?ekR3SGNONmVQTFF3UUkxdFB0QnVMQzF3eFg1S2MyaFB3T2RCc01UVEJ2Tkls?=
 =?utf-8?B?N0JMOGllNmxKanVlNi9JSytpVjFBSDNQZm0yRk92OWgyZGhsYmRpSXFIcDAv?=
 =?utf-8?B?MGt5TUNLa0pKT1lsdDk3Ym9ZWmczc1BMVzJGaXBHTklQbUNnVzFGTjFmSEpt?=
 =?utf-8?B?RlJJWTczbEdwdWdMZ1RGdVc1K1dUV0VONzdmVncwVVRJYm9GZE1WaWlVUzk4?=
 =?utf-8?B?bkk4Yk9OblhMdnhlWWFKUDVEOGlOV016M3RwVW1WWWF4ZTdUK0ovSEgvYzVL?=
 =?utf-8?B?TkpOMnVGRWJ2NTdiczR2aStXVzVxck5nTk84U1R5OG5ZZ0JqNUpKMFhKdUxP?=
 =?utf-8?B?Z2JOM2k3blRoY0VHR3lJUDQ5cjR0RUd2QlRTWkx3V0hUMGJKWHlYeCtGcmpv?=
 =?utf-8?Q?GN4rTZ+t59EyRAu6KOpIa2LYc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9873ec66-c29f-4b2f-737c-08dbf83c92ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:25:25.1225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBuUZunEbkoisWLtW/2tZTyfp0/Dj/561kj1tbSNN5JwfZZ7K83DZn88K+0CLF7EFYcQeIoq2/Xl3Dfgl7mLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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

On 12/8/2023 16:19, Alex Deucher wrote:
> Add helper functions to disallow GFXOFF while SDMA has work.
> This should avoid corner cases where GFXOFF is erroneously
> entered when SDMA is still active.  For now just allow/disallow
> GFXOFF in the begin and end helpers until we root cause the
> issue.  This should not impact power as SDMA usage is pretty
> minimal and GFXOSS should not be active when SDMA is active
> anyway, this just makes it explicit.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

For the series:

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2220
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 1d9d187de6ee..d4b08d03970c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -326,3 +326,17 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +void amdgpu_sdma_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +}
> +
> +void amdgpu_sdma_ring_end_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 173a2a308078..b52d16829204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -171,4 +171,7 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>           bool duplicate);
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>   
> +void amdgpu_sdma_ring_begin_use(struct amdgpu_ring *ring);
> +void amdgpu_sdma_ring_end_use(struct amdgpu_ring *ring);
> +
>   #endif

