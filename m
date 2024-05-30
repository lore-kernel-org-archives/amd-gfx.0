Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC9C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 20:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B9710E6B1;
	Thu, 30 May 2024 20:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g87y9ZMN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6480010E6B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 20:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo/zmtmuO44TX3ev0k6SpDD3tZw1EIJIs/qX/Jtf64E6YvpifpOT5fYEu9xqW+Ecw1swzM48yym+DqQwP8ONnnJ7vZjJJ8WYn6ga3haEkS7bWpmTqUHm0rcloL/lWkboJpuveg1a7HRjQEP5jvPqqU6odE3jq8zYWpnatrdnMVoEkTAKm40soJqZRqfP2d0o2sFs52otEHjfYR99YrqAZfkboGe2y9DN16Lxn7nFozZZAx4S/97SeUSgkIkYwMYc2MUFwwVWCtWzu70QOGXg1IU+/oDUwdvdASMdwQTCj6r9Jlps/6rx3WrHBb7Jjts8qpQQ/T5BWlreeCraTwnl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxjvYWma3XkW8PC/jz6XBq0F6ZxbHAXEoX27SRyaMrE=;
 b=XyS4SFdwuQrq0CtakHwMbR6HVKDRWHqjh6EZYMfOB/mGm9OtIiC3GABPc/wuN261ZVB7llTJatX4p6/GKT8WvdPhZouuD/VRTICdlvdts6em1ZP/vltM7mtGlMZiJ+8cN7mmRqYTlLPgkUVDefRTpK0uKy9AdQHPziBwYLh8zPbokQX5pSjZxWIMVqq/0/s+oX6eeLFHYBjgnq2hPn0+BGTs5IONYZmtRWFRxtvla1a/2FGGdZE+HHlizIJwz7i9SaOIJPUo35OZqXG0hxXPjuDgc8UYnd7qL2SYVXYaYw8LcV3IRQ2+Ko02u/EcC9BKp88+/yqXaCRtpRWUCDTNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxjvYWma3XkW8PC/jz6XBq0F6ZxbHAXEoX27SRyaMrE=;
 b=g87y9ZMNwVfl8cEz2y37u6O9594nt0QgcjCu5eD/AMomu12khBr6X+rPzZu/h9xHO8szPVHmDWJ/G7fojWnIzNXtzULTYPIbbc5RYDcP/g/M0Ty17MyMM5X54fpYcDVBQyKPTO3Zh2Bwriz1PIcKlv30SkYWEbElXXF/m8KpKfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 20:37:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:37:20 +0000
Message-ID: <68258e83-6172-4755-94a2-a623cde6f8f9@amd.com>
Date: Thu, 30 May 2024 16:37:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdkfd: remove dead code in
 kfd_create_vcrat_image_gpu
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530035048.2341626-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240530035048.2341626-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::44) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7cbd4d-62cd-4e14-a1a1-08dc80e84d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmYxaS9xNHV5ZDRmMnk5MlBPV0xqQTZ3WEJJZ1dReWYydWZLVG1KOVBVRWdx?=
 =?utf-8?B?aWxkUld5OG55Q25FQXltTnpHVk1ocW5uMmxISXFNZ2RJZlZrTnpoZmx3REI0?=
 =?utf-8?B?QXVZaHVKTHRqM2R4RWl5RVNacElPMVYrbmdwNzdKZm5hVGR0bFJkUmV0QlVQ?=
 =?utf-8?B?Zjd5QmFXcUtTb1NTbDRrQlQxOTNyVGVpT2had3NGTCsyR09VWGs1bkhqbWVn?=
 =?utf-8?B?cWJseG5MbmRqQUZWem1oQ2NkZlN3SzFCa2R0czcyVVNkU2lWSkxRczB0RzRH?=
 =?utf-8?B?ajV2ZlYwWlJ2dmtDb0FENW9wYTI2ZHRINzhpY2FUOWY2WW5ncEJzS21CYjkz?=
 =?utf-8?B?T0pWL0I2bFhSQmgrM0IrSDQ0QzgvUjlYTkw4anRFZEgzdFh6WUs0VzhyNkY5?=
 =?utf-8?B?MVNiVk1va0lSTFJuSWkyYkx5UXVObWV2WmxJcmp5OEkwQXJsQy9qSG1ERENx?=
 =?utf-8?B?ZzJtRWtWUlZJSHBrS3AyMG1DM1JRL01mM2V4ZWpMR2xtZEVKTXFsZ3lBVXpX?=
 =?utf-8?B?T1Iwbk5ybndDcEFzSUZ4dDhjREFaV0FBTldsWmQ2YlEybGZtTDFXaTErQjBY?=
 =?utf-8?B?MlVaYW8yTFZhbmdOQ05NUVEyWUFUbFdFL1Q2dUNoTnZLeXdiY3puc3BPUW5x?=
 =?utf-8?B?RDY0S3hwU2ZZZCs4NFBnUjJPRXpvRFVSeWs1aHd1T2lxM1krNXpaa2QzVkYr?=
 =?utf-8?B?dE5XTjZ0NzZod0pEeUMxNzdYdkZKYjhIeGh3NElYU0UxaHJIR05DZldIT1Yv?=
 =?utf-8?B?d1htMk5WeXdXQmI5K0R0QTRUekZNQlcvS083NXV4Q1pOeTdNaGlGei9OdDBI?=
 =?utf-8?B?d0FRRjlDcTFSMjNEcm9OY1ZWeGxGVkJzQWxMeVRaMVJBSEU4MDdvYklJNkZj?=
 =?utf-8?B?T2IvZElUL0Zwakc0eUtYbUw3U0xoMDlZTE5tbERiOW80dmcvMHVXN3cxSlB4?=
 =?utf-8?B?eUZSYVFXVHVyUUJNRmFhdk1KdG40ZVlFNkVYME9scXlQTVR2RjZSYVhHRVd6?=
 =?utf-8?B?UW83Y0hjRS9xSU42cHUyQmwwUVRQRWM1N0F1bGpJNGFoVTNVaTRxYlRwbGt0?=
 =?utf-8?B?MkhJRGR0OHdyV2hUSDk2VjZiUG5rYXBnL1o3ajFLUSsrUW5mTHJTdzgwMWZH?=
 =?utf-8?B?N3FMeHFOTnIzUjZLa0xTWmtYcmJxQllyaGY5YmhKMG9vQXZCY2k1dzZISDJz?=
 =?utf-8?B?d0dLRkhXTC82ZVlsOFFmUUQxaXE3VDZwTWY1UUtLb0xsbjNndkFsN1R2ck9N?=
 =?utf-8?B?QkNuUE1OUUJkelkyNkZiYXpYaEJhUGNiM2N6bjM3eld3bW43MnhZa2hCeXpS?=
 =?utf-8?B?TWdMTC9NRjRzdm1Ma0hwMDVFOUNzOGdpb1Z0YTkwanRvQmJGZURBeTlCcTha?=
 =?utf-8?B?K1NkM3F1QUpqTjc1NW5DcW84alVjckszbzhMOFB2elhEbkJIVnV6TFoxZ2FC?=
 =?utf-8?B?cnZtM0NmNUlDc3FTV1hEV2Z6MTBzeE8wWUlabUJYbEdLaVpnOURtZk5nMm51?=
 =?utf-8?B?eEw3bW50cHl1TjdtalIzQ0MxVDEwTjdZQmhXeGJidnFaTkZ3ckVBdC9GRDcx?=
 =?utf-8?B?aE5OdVhZUnA4WnFCcE13VTkyeEZvbnYwYmpLMjExOTA5QkZOdy9EREUzSjRz?=
 =?utf-8?B?UW9QZHFNK0x5NnNONExCbGdqQXNoWXIyaUpEVUx4OTl6WlRlTldzb2JJOS9R?=
 =?utf-8?B?RVBBU1JQVXJFSDgvQ3VZTVNWamFZdFVMdkh0SENYZ25ScHBqbDRPdEJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmxmMlU0cG8xR0twNjNxck05N2xqN3JmTHB5NDI2VU9IK2lKMWVkVGg5RTYx?=
 =?utf-8?B?aFlkelV6YmFRRU5GR2V2ck9nbVZ6ZkJPbnZwNlFWRzJSVWFqbHY1RWIrY2pQ?=
 =?utf-8?B?WFJibzlwb0VyRkNSbjRCUjdNL3ZEM2RpYkFHQ25SZ28zTEZKYWZ2aG5zTmN2?=
 =?utf-8?B?WmI2eG9WNFVzYVJlYlN2OHYxYXl1ZU9FVzJDRlhBWkpwSTFXcEFIYlFsaEF6?=
 =?utf-8?B?MlJhRUZ1Z1ZVdUpIelUyd0tZVjFLL1d2UWFydzIvSnJLK0I2cDFndW02TkFL?=
 =?utf-8?B?YmNiRUxiQit0S0hEdFdUVm9ZckZDMHgxSUZZSDNScG5VSlpPWHQ4WkY2cUdO?=
 =?utf-8?B?dVlNd0JsRTNKUFhSVnowUFRmM0Z5Mk9oRjZlZjFVN25xeUg3QnVZckJIMXI3?=
 =?utf-8?B?OFJJcGtPbDMwbFlrSnVhV09WcmpOSmdrQklSd1FDZ1pDODNxS2pLTE00aDll?=
 =?utf-8?B?ZC9nRW94c28ycmYrRHJDNGFMU1QxRkJJWldLOXhKR1gra3I5VXMxMFJibUJ0?=
 =?utf-8?B?TXdtKzJkd3F5U25iWTVlY3dpVUY5QSs4czlpZ0JrTStNZWQ0dG5wMldxeFpo?=
 =?utf-8?B?WkRzeHVTQ1ZjOVcyUFQxakRWQ3I4NDNtaThrd0FZZUtSY0N6MkRBQkxNdVll?=
 =?utf-8?B?TjN4VTJSejU0SGx5Q3JkL2RaamwySVBXL2hGSS9tTk93NkpCZ2pDNWkxcFFl?=
 =?utf-8?B?T3JTeTJnbW9OSGFhd0xDVVljVUZWWE53eVF0TElNLzJCVEhmNWQvZittRk5X?=
 =?utf-8?B?T0VWZy9VL0NoUjBRN09KWjcyRUVGN2RFbkVoa29Sbk5mZnQyeVFkVGNzekFC?=
 =?utf-8?B?aTlrSmxNUDFJcEhFdENBNnNTVlhLeWFkMldRcmdCc2JUNEVDdnMwWndUeFdY?=
 =?utf-8?B?cE5sOXhUa3BPd0FTSVE2cFQwMllPOHRzS2gxZy91ZmFMM0QvSVI3MEVSTmFK?=
 =?utf-8?B?cVhSZEd5QTRvQkhISm5hUExycE1rVkQrVFd5QUFpNFRleUtSOEZ3aFR6Nldv?=
 =?utf-8?B?dU9sc3A0Z0xVNitpcVdaK2Jzd3NHUTZFbHBsMFAwa0dXM1dTTk5YWWJNaHV0?=
 =?utf-8?B?R3U4cThQWU42WldzbjNkNmRoZDNUN1NzMEE2ckxCZ2wyOC9RM3RaT0NOWHo1?=
 =?utf-8?B?OXY2d29BOHQ1bDRxRktJWlczYUxPZ2tabjhHUmF2b1RlTnJDZ1lQcDlFeGlD?=
 =?utf-8?B?anFDV3JoMzBhbXBVRWFTTFpKZDhCMTZDemx0dkVzZDVkeVFmLzEyQlNJTmJl?=
 =?utf-8?B?QXJFRDZQbEFJb3lVaVhjb0dWcitGUnVjZktxLzJ2NE13OFl1bTlqeFRQZGZt?=
 =?utf-8?B?enRvV3pDaEFiakZWYVd6WWJxNlNjcTJqRjF0Q25Ycyt2VXltZzZpRk1ZZVFr?=
 =?utf-8?B?dGtodSsrZHNJdUdjUk8xQlRtM012S2dIRDM4RHhkVWZlNWRQTjNxMmMwMTBq?=
 =?utf-8?B?ZXVnemdDNGUrVkpJM0NWeGRaVExYZTk5TzNYTU13WjcwT1Fja1NjL3JvSytG?=
 =?utf-8?B?aGNBSk1UbEhlWSs0L1ZtcUxpeWhwOWFwTXVQdWxJRmxTRkZYdWJlK1B0YXRk?=
 =?utf-8?B?VWFqR0VXbWFJUXQ0L0ZlSVRNM0d3NTFtMitmbkptU3RRVm1KSm81WmhhOEtI?=
 =?utf-8?B?SVpDS2cwMk13RFJwYkRneHlOR05tYWZBUEg1bTBJaWR0clloNGNmcGR1VzFx?=
 =?utf-8?B?SFhKQ0xQTnVVNHhPNk5IeS9EdHVaT0RiVVFUa3YxWFluOWlTUVNYUnB1Vkxx?=
 =?utf-8?B?OHd5cERpRllqc0dhei9OQWtlWVByQWxIWGc4Y0pxdGVqR3Q3M1ZuYWVvQm5X?=
 =?utf-8?B?ZDhtVHY5ejYyWGxibS9sMGZVYlFFaGNwUDMwUkpacFF0Mm9Sb1NTVlRvRk1O?=
 =?utf-8?B?TkFHQm1DTWsxS2xJRW9DaXRTSlBONkhTTzBUYnlxdTMvR3hjRUJlWHR4QTkz?=
 =?utf-8?B?aHZHY09BTWduWVVBMmUvVGxieWkxMFlUcWl1V0tucEFCcmFxY0dsR3BKRTY1?=
 =?utf-8?B?QmdWWVBTT09PQkNZY1ozUENOZGY1dkZpNlBpUVUzR09NOFhBMU9vODR3TWc0?=
 =?utf-8?B?RzcwVzh3MGlIYlRzRHNSOHhQWnNHdTBqMDF6Y2s3cnFETjQ2VHNOaS9hVVhn?=
 =?utf-8?Q?ZTEXQdBXx+qsZEiNhPs07ARG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7cbd4d-62cd-4e14-a1a1-08dc80e84d87
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:37:20.2535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHanYV8036gHemPj9FR0F0CGMITGrXslDNY6bUqZi14u7dYhX0XSXzGIt7LDlrK+B0io3xLXXh6W3/JmfIMFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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


On 2024-05-29 23:50, Jesse Zhang wrote:
> Since the value of avail_size is at least VCRAT_SIZE_FOR_GPU(16384),
> minus struct crat_header(40UL) and struct crat_subtype_compute(40UL) it cannot be less than 0.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 71150d503dc7..ead43386a7ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2213,9 +2213,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	 * Modify length and total_entries as subunits are added.
>   	 */
>   	avail_size -= sizeof(struct crat_header);
> -	if (avail_size < 0)
> -		return -ENOMEM;
> -

Avail_size is passed in from the caller through the *size parameter. 
You're making an assumption about the caller here.

Regards,
   Felix


>   	memset(crat_table, 0, sizeof(struct crat_header));
>   
>   	memcpy(&crat_table->signature, CRAT_SIGNATURE,
> @@ -2229,9 +2226,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	 * First fill in the sub type header and then sub type data
>   	 */
>   	avail_size -= sizeof(struct crat_subtype_computeunit);
> -	if (avail_size < 0)
> -		return -ENOMEM;
> -
>   	sub_type_hdr = (struct crat_subtype_generic *)(crat_table + 1);
>   	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_computeunit));
>   
