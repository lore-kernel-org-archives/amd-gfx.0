Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60630CD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 09:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB1C10E0A9;
	Thu, 11 Jun 2026 09:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLo1QjuP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94C510EDF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 09:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYmglgV1rlqabXxj75g6Om1baxH4Y3UGC51DX3Tbh8TbaDS1eLvFjTcUAE3sdfwEVM4kK9MB9V0PcdLBSW0m+dduR6m/nORcyg2kds/1AQlYWrLBnYx5AA1zkR5ZUWm+mmTji7mc1gnkxFKxjlAedyVU3Miez8DKKj5SN2sLrsIGthQbjBDGKpdC4E1fA7RGwVHGLxmq8BIFSx8dSfYBxDzUkiIKiA4ALrapOjWPw+WYl6mqEKEKJTF739rdatWRWZtsJL/lVrVMVvY5mzYlvL6a6mJHnR1X4giP5gMpatya2xjL4o+e19NSTecKBUuEgCP/K4Z9WL61hraB+HpHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqP/u+o4HB3EgNkD3xmmkri2Seh+sAULJYitcbLGM0A=;
 b=ZUlN8cx9QGZKSMV9ZsGBlLkiXWfkxKL2vC/o+cfRtiAN9DWzSSgcuJO+fysnrz2Cbn8X3Ny3MN3itDSAFhv2uPy5Qyzf/fAy18DJQG9wXEnH2wONpvbxR2CQuehjcLCR90HZo39RSBF43lCB3ouTzL2BMDWAMfHKN9JZKsgutNSxsGrF51nwnExnJKlQbCO68d3de6SVzjbECiUxQK3+jMq98KbBc1waV71kY4F9/Dnc1hH7h1jN0NbRmHnIhrjdvpXW6aVzmF2fmGI1oahP6/SwfeqfTz78USvP/kWn/Vafx3ZQ6OycxxBUyARsXBsDTEt54SpocVyiIvgEI2fO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqP/u+o4HB3EgNkD3xmmkri2Seh+sAULJYitcbLGM0A=;
 b=kLo1QjuPRI4SlAuK2zo65ntPTSWv1hlavr5wFhPM7w+2l5ARujGlWypa7aXgmGd2LHvPQsT3L1KXC0HJPZEz2JNjm+Dl5zTWGaWX0HpHSEBKGQXY4FPHKY8daWIYYk7FkFxQRSmbHn04gPwnuGWnA7aoNYn0aLvLBtMpnEoGDH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 11 Jun
 2026 09:24:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 09:24:42 +0000
Message-ID: <08c056a2-c425-45c8-8442-978ce0f9357f@amd.com>
Date: Thu, 11 Jun 2026 11:24:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: set the userq xcp_id
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260611083311.191012-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611083311.191012-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:208:2be::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 07500fe1-96dd-4a6d-0fb9-08dec79b4526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /eIsSQjx1z8NiKYf6eAOL9KJcTZfu9ihQkmqB9HTR5+VnrtSN3ABGaOAUlkhhcMmEF8MM7I8XHeVHPknP00OeUdKULmPYO5JrMTIJ/PfxZDGz4qc/kFuJPGSFIFZmO7X0kJxyYgTAhwgUSKy5oY9ihN+obZhd8ji7q6XQxcLVbtxezX72Bd/fbZxVPi/TwGq+c2NohsAAuxli82MTV7lX8J1QjVNKvH7gaDCWMl3/tDGLqQqS2CkLDdRVe5LTPt4cLFdkReF2XRZrKrogY12JLuuvonpzEE54pAVwuVOET6JLzgownAP2gJdkWlEt0O4wwOI41tRCYMuOH9Ifv0JW4RiyoouZ8JgzmUOgHsOTq4RwE3IUtDpUHPFMrKK2kGeTuJY/GQIRpfJvX6LkoX5/WBjshxOl+0XFxa1/z3B7XZvvIEV+X6mEc41BeWSqxD8JMgDdosaayQrrC9MFs5wizDuzpbUfWYOuvc8lJSnjybZ9FtCSOJfMOax6fyGolOct5oid0Es14+IOKNcAOuWts7G1reb6UA4MAXIKFrhg6KEyUULq+LSm5zh9txbBpp/CYFfF0ACH44qOYsUooaj8czgNxtotUIohGtUyTj8LaDn3rqWdlXBg/JYRNhPzemtooaajm54g4EYEWVCPYqrpebltiFyi5RFQf+ery6QVezoXIAEo8GURmB6UM32C696
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkM5WFoyMzNiWk1JbGNDUDdpYjJnWWI1Y1VQL0V0Yzhnc1pYQkhidzZMTG1S?=
 =?utf-8?B?ZzdydHJJb3JwSzV1SllLRVFaZ1JudEFrOHl5MldqamN6SDc0YXRCVWJzZkZ5?=
 =?utf-8?B?cGRzK01EZlJkbGpSenU1L3hDZkU5TXMwRC9DMmhmbVVUOXVjK2pmb1lRN1Y5?=
 =?utf-8?B?VTdpaFR0em94MVY3T3VBYlVmQ3NVN0k5K3V5MUoySW1VMWtOcC9ha0JGbUF2?=
 =?utf-8?B?NUkzc0cweFNiWS9wNkJFOWtmcUhMTmZYV05DTGZUWkd2OUpXVmgyS3A3NXFx?=
 =?utf-8?B?a1NqdjlFK09vTXlhRjhPZDM0NWRrQ3Q0bFAwNU1QSjdIVytkU1ZOVFNjZjdR?=
 =?utf-8?B?NU11NVNnMFJMRS9aRzFkMTV2UUdoMm52YTluejJBK0ZxQkI0Qk1qTU5xcWNr?=
 =?utf-8?B?VzJZOE5mWUVBMm05QVNicnpQY3VRNk1XcTFRS3p0dW9ScDl0bVl2WWZYRlJk?=
 =?utf-8?B?NzhIUkgxV0tGdTI3NVRodG5CRnFwOUVoZEFianBuT2JhRHZmM25BejdLYjdw?=
 =?utf-8?B?QUtMYUlZMG13SXpKSFVvb1dYUDhxb1R0eWd3MWtZVjRITGZEQ0c5Ry9jVWdi?=
 =?utf-8?B?SDRXOHVrd284c1FUV09TemZML0V1MG1nOHBaMzNLTERNaTlKYnF5V2o1Qmxk?=
 =?utf-8?B?R2xSaHVCVkF0MzlXR01NcnFpK2U2enhjdVI5b3ZTaW1JWmpMdWVxR0kvb2hE?=
 =?utf-8?B?cjFjZnFXVUoxMEVpSS82MWY1WFMxNWxTNjNsU25pVk9qN3g4QXpUUlVnQkFM?=
 =?utf-8?B?S3ExMzg2RWUwS29zNVdvb0FBLzNLL0tpNEgvVXA5N0V1Ly9rdlh1cGY4dFVF?=
 =?utf-8?B?a1JITWFMUzNwQ1JzVlhRMFpzUS81UEZtNHVZOEpUZVl6V2d2MVc5QnlDZUJ0?=
 =?utf-8?B?cVgySXduRkRzazRMM1l5dGdOelJFSDdLQnl1WGZBOCt5SW9ud1BxT2RnNjZj?=
 =?utf-8?B?OGJERk9xSXR5dGVlVlAveXhDUnV3aUx3VjMwQnAzbTBOYXF0ZDdtN2hYdisy?=
 =?utf-8?B?RnRqVWk4ZWRwb2RSbHp4WTVVSkxKQzAyNmx0ZzBHTFFjSHcwS2hBRmFmalkw?=
 =?utf-8?B?R3FLYUFNQktkSWpwQTVkb3c3cTB4aVVSRE9maDZJOVAvQmk3bVYwWkxsZWtQ?=
 =?utf-8?B?ZGhpNkZTcmlIemxMc09JblhBaHZEZDhBNDdidFg3SlYyV2FlejJiaUpWVjFr?=
 =?utf-8?B?YlFML2tWcy8rTG4xMHFjekFQZXpGUG1SV1pXaDFHb1N5bHpRNEpIVDNDbEE3?=
 =?utf-8?B?ejFvVytYNWZQZGR0REdqcVQ1WmMxMjRxZE0zaGR6bGJtUWY0eVk0d29iZWJ4?=
 =?utf-8?B?RUtKenNGWDV4SmdjeVNiMzZGZXZpMVdYWWhVcWJ4UnpEdmlHT21sTjhVVWl3?=
 =?utf-8?B?d0s5dVlFZFd0R0hlWGc4VmVLalJyS0tvNFNTTDNDNkFWWXYxcXRjSlU2STla?=
 =?utf-8?B?VzhnVUVHMHdjbkZLSWtQa21CR2s4cE1ZQkhyMmlZME1sczhHM3VnekNDaUdr?=
 =?utf-8?B?eDV2Y0lxVHlwK2UzTytHZHRueDErT1B0b2ZQR1oyM21NT25sWG9FNGJMQVhJ?=
 =?utf-8?B?WnhEMWo3V2pyUU5UZFptR3hHYmJDOTBoeWJmVVpBb0dNMzM3T211WWxPU0xp?=
 =?utf-8?B?NFRuQWl6U0I2SmlTTVpjN2F6alovckNGUnArVFdIR0RhYzlwMVl2K0RrR3ov?=
 =?utf-8?B?YVBFQ2thc0g4dytBb0Y1N2VYTVBab2NKczRGNG9LdXZQTnUrMzRQYmdMRzZu?=
 =?utf-8?B?bndVSnh0czhGQzZPaHBwbGVBUHRqQUhQQlROaUZkM2V3U2J0bEJ5Z1d0SDRX?=
 =?utf-8?B?N1Vkc0x5Ujl5OFBKWHRUMHlYdytBdUxDcWZqNGFVN3VqSTQyVnB5blg2RXRv?=
 =?utf-8?B?bkJlbVMwZGxUdTk4NExvclNNNFpiZDFnSXc1aDBJMTQ1R1lxcHNLcnRDb3hy?=
 =?utf-8?B?SDVjUm53M2kzSXlzV1ptdEk1NDJDWXFtTlNrVG5HbmVtd09uS2lHYndYM0xQ?=
 =?utf-8?B?dWFWZGFDZUJUOC9MYTJFaEdHTGJIRm9RbEppUUdYVEhIZGgrV1RRYmthbi9T?=
 =?utf-8?B?ZW5Zdnh2dlcwajRHRkxJNXkzQjNaMzFJRFlpRVdhSGZGY2M3bzl4TUlWL0dJ?=
 =?utf-8?B?OVQ3TWJ5SmlycmJnRFhiR0N4VmkxOURpc1pxRW9BK1pMdTg2SUJIT2Z2NDky?=
 =?utf-8?B?a29JWUZLMUt1NU51akJ2UHJ4Y2llRFFOaitCVzB6eDJla3dhOW5GajVjNTN4?=
 =?utf-8?B?c1BkZlF1ZVh5V05pbEFFTzY4NmF2YThwamlQck4zZGV4aFQxK0czaCtqOUJO?=
 =?utf-8?Q?1tk5uQLgaHHlRSgg04?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07500fe1-96dd-4a6d-0fb9-08dec79b4526
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:24:42.8304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwUbyms4LX+lSLKE1Y9wVzzeSrkiCfenl5ISUxo/kdtQbzy1hmn4GfcMfxpmgvp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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



On 6/11/26 10:33, Prike Liang wrote:
> Initialize the userq xcp_id.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3d6b1cfeca24..c1175cb6d242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -585,6 +585,17 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
>  	return -EACCES;
>  }
>  
> +
> +static u32 amdgpu_userq_get_xcp_id(struct amdgpu_fpriv *fpriv)

I don't think we need a separate function for this, just inline it below.

> +{
> +	/*
> +	 * The enforce-isolation userq path uses idx 0 for non-partitioned
> +	 * devices, matching the gfx ring isolation handling.
> +	 */
> +	return fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? 0 :
> +						       fpriv->xcp_id;

That can be shortened into fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION ?: 0;

> +}
> +
>  static int
>  amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  {
> @@ -629,6 +640,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
>  	queue->priority = priority;
> +	queue->xcp_id = amdgpu_userq_get_xcp_id(fpriv);
>  	queue->userq_mgr = uq_mgr;
>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>  			  amdgpu_userq_hang_detect_work);

