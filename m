Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD3BD0C5F9
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 10:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AD910EA63;
	Fri, 25 Oct 2024 10:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EKjmmq6d";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3886710EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 10:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtGmKfC1u1P6BF7UMRHrbe07VrZB2Yp6fZ8gv9yoUJt8Q8CssEV+GcvZ5OSymHuiNpPB1vNy72RwU7bW0kRrWWz6y8s3hwEgYEf53vGcd6qi4uO17DrhAm2KUeC7RjHVVOTbs2rkbkvwR1eNVuCc8SEyHizidX24kJszZQcans6aTjlBHMEQosS1LVCVERwxFL0uRg0TyrH/c8+82iwY8XWmRu4QYk2Z6iSWPYNinCqXckr0zazRNbJpKtzX0S318t8/14hazjbaBc6OPxzM+8olo5ybp4r4igiNWfc6NJYZyoIsuJu+3fdvEmNkkQnc9oIUzGcbu4dV1da7xduDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0Z/F4nRhRjxVOMUjz33hdolvdPnyXQhheRv9EZEol0=;
 b=De/nSVOxHcmQyvXYkdBnl/fz4tqf08VKIGo/lXsCClbCaV/IkjdgtsRCQmn8kE/hIUsoIWLssWAH6mn7XLKonOTX9XFpkin33m7X4XNjDe5ZJ7cA8N2rNsiMiMJO3jxmVVOSTmEGIpmH0b7dAxlB5T+YNY1aA8w2UlZGPnMOZaRa2pHteSxQhomKTomECCtl10GkYCerIBmuAMO4Ax/UxTyllXMXvmwQXIfhqqb88e0VXzK03aRULfiB1ECE3+fO2DcmlEh6/JDvSu8uqPDBDTFfQo9XL9G+k0Iz4ZpnFsjYg9sBkxTHNfObo7xTDHYxcHGayo493tedv8fYhAqRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Z/F4nRhRjxVOMUjz33hdolvdPnyXQhheRv9EZEol0=;
 b=EKjmmq6djd+5rL3+r0PMUOUoYiVSKkAF6h/KMrh+JyNAgDMnytmi6w8HJzvEyl3Wt2NZZI+ZjYZeQGsarPJOBMD4/kzv761kVqxJif4l8T9wGEwBDwlGO6O0OvmG6twmCvpRoDdQQ8Iy8e2JFFst+core8WGy/HWIe1mdKD09wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 10:05:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 10:05:26 +0000
Message-ID: <b41d8ad9-7407-419f-b6e9-2833d03e0872@amd.com>
Date: Fri, 25 Oct 2024 15:35:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: correct the S3 abort check condition
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241025094519.55723-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241025094519.55723-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1078bee7-d5bf-48ab-1e73-08dcf4dc8c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVFZRFFISHVzcitsbXN1TnRLNXJlMTVhSXNwYzlyVXc1RGZLaVliLzYwV2JB?=
 =?utf-8?B?R2RIeWlRaUFLbFVYcFVlejBGamREMERxRVlaZGRpaEFOTktKMFFJS1pMWmRO?=
 =?utf-8?B?MVZsaUZTNnBoYmxLSWpxVHhMWDJRVlF5RVpvMzN5NnZPd3VjSjJMQ1czOHVN?=
 =?utf-8?B?eDFJMG1ZU0tVNW12VlZubzdrcTBPV0RPMFpHdTlydytnKytzQWxsWG1za3R6?=
 =?utf-8?B?Z1A5Um1ia2VrWTJNV0RsWGQ5SDh6MHB3MnJZeDZ3R2twZ29JV0pPOTNCVmMy?=
 =?utf-8?B?eWt0aWYyUTNrK0ZVY05WWEIrVVpQWmxVclBMOGtrNGdaeDY0c3dDdGxKSUZN?=
 =?utf-8?B?RHdKTUhxNFhjZE52QUdGbFE0dWtwbllmUWs5aTBXQm9GM0FvOVRRaU9ZWlNm?=
 =?utf-8?B?dTdubnlLM01BRDcyR242akpmaHVTdmc1eks2L1BtbFovVnFDdFZiR1lXUFcr?=
 =?utf-8?B?NDFaUUtJRXp0OERRek5KRlhRT0FkUTZZZTVpampKMXg3S2ZvNU81Y2Uyc2gx?=
 =?utf-8?B?R0d5amU2NnUrN3Fhb2N3WllHdkR6bzVNcnJzOTcvNVUzSHVkYmQ4ejdhd3NQ?=
 =?utf-8?B?QnQxZkFvaCtFUTF2alFKRTZwVHJ3NlNzLzY3WnZNenNrZlRrajgwak5rR3VX?=
 =?utf-8?B?WnR5YzZIZlgzcElRWlE2R0NMZDNkbG5ZL1hmSTl3dVdaalMwOHluYkVXTEZw?=
 =?utf-8?B?WWlROXN2Z1ZNVUVEcjVacWRCQTUrNHlRKzZRZ3NrS2xZa2pUUVlTdjdaWk9D?=
 =?utf-8?B?ZXRnNldoY20xZkJwbEd6OFM5MHdkWS9YMU5NbG9VcDNRT2NMbWtHT0xMWnFT?=
 =?utf-8?B?b3pTREZVM2lkdWYwSVFNMnU4OHV5VytxVzRUZ0VVajlyQTdTckpGYkNCTVRZ?=
 =?utf-8?B?V1packZqRi8zb1ZKRXNPMlYxdnpsZGlnMFBLZksva1VtNXlDTnhKZ2xzemh2?=
 =?utf-8?B?ZENlQVlnZkphRExsYUxYT3EzSzM2SUpBK00yVWIrQjRUeHhQUndJTlJIWUlG?=
 =?utf-8?B?NUd6b0cvU1UySHdoYk9tY0tSL2p2U1IyVCtUVGZJWXYyZ3VzUHV1U3Z4SGNR?=
 =?utf-8?B?Z1lwSm5YY1NJRURJY1l4MGdLdGhkWkF0L0Jib01JWnhHbFUyTUJGYkx4RWtO?=
 =?utf-8?B?bUlHcXZocE9HQzFaM0tnZXh0Z05WMHp5cDRiTGlFcVZLSXlQeDgvaWEwQkJS?=
 =?utf-8?B?R0pINU85MzVoZXVocWxGT3p2UUM0MHIrSFZESkJFbC9VbVYva0I4OFBGdXRR?=
 =?utf-8?B?M3pLTXFNcWE0U0IrSWhVVG1jWC9meEx2dHRFcWpNR3pVVlY0M3VKRnJvZzVT?=
 =?utf-8?B?S3RUWmVKUCtnWVl2cjYyVlc3OHNOMHQ3N3J4c2ZiRGd3eWZOMEtvOFlyQjMz?=
 =?utf-8?B?Q2U5NkhIZmtXRUFFWXVzeU56RW1oeVRIbEpYK2t1QjR0SUNaT1NMdXk4enBz?=
 =?utf-8?B?VnFOamlYZ05vOU04eUE0WjBRYlU3UTdJeC9mS1M2Ym1zRUJTUlI4aXlxYW9l?=
 =?utf-8?B?STZtK0xVMzhLYVppMXBIUmsxYTJRQ0FSOEZqRGoyZVdIcVdvWGkyMXFQQTJl?=
 =?utf-8?B?eUdXT09uWXhYaCt2cjQxNURKNG1lVFNEVVJ4VnFYZGhRRGowcFd6Q3FCMUYr?=
 =?utf-8?B?eFZSaEExUkVvUU15bGtZcVlmZExmbm5hMEdaQ0Z1WlYzZzN6YlU3NTNxbTJp?=
 =?utf-8?B?R1VmZkw1dUtxZmRoRWRnNVFKV3lSaWlhbDZ6VVNoWmxUeWVLYmIwaUl0a2wy?=
 =?utf-8?Q?axIg5ibNd04KRtDWoo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0pRYWpvUUJCcDg4VENvRnMwM0N4YUxHOXdqYm9ETGdaQVBTUHpkMGIrSFZI?=
 =?utf-8?B?dk9xa0VZN2QwV2VZYWx2bHJxRjl4ZmhTYnpuQ0UvcnhKbHdNNG1VeHFiVWZK?=
 =?utf-8?B?YVM0djBIK0FCZFp0NGRVbDNqMnlWaWhXb2RTLzZaMXlEdmZLaEl3eTdWVEsz?=
 =?utf-8?B?bXlJQmFodUJWVnpkUlptZ0drSEdtanpTSDV3QlNsY0pXNmNzK2RYTW10Vzh3?=
 =?utf-8?B?Tm9mdC90N2hxN0crOUdkd0tJa0pNc0JIdFl3aFVaYW15aTA0YUxRTit0N2p3?=
 =?utf-8?B?WEZ2V3p1Uk1KamRPdmFDUmF1ZmVUelFRVW5ENlBHWkFZakNQT0pSUXd6M2t6?=
 =?utf-8?B?K1JsSGIrcWZybDl4RVF5SWZkNVFOR2p3QnJWOVBYU2xBZmxUeDVNeEx2YkJ6?=
 =?utf-8?B?aVJJbnVlbFhHdGRzUGtqVnBTaHlMKzFtK1BQTkFzS2JLZ0JmcUxweXRMbDdh?=
 =?utf-8?B?elkwTCtwK0tQUXZpUkR0ZlcvOEpVN1FUanNQRHpTNml3VVFEM0JVemYrQWIw?=
 =?utf-8?B?cStQaEI2bkxtQTFoUEE0R1FJbUxaZnEzb0NyN3I0U1M2dXlSd0J0eVA4WHJw?=
 =?utf-8?B?YmZKRmJQZ01SZlJweGMzeGdad0V0Y1YwUUV1MmNJRjFOczB5dFZSdnJWeGpm?=
 =?utf-8?B?WnZ2OGs0b1FYWmY1eGcwSFhMMFdFek14VlR0a0RTdE94ZnV6RVdKU1Z2NmQw?=
 =?utf-8?B?S2wvd3UvbFJjcjNVQXY4dVRlNkx2Y0ZJSjI1eUxRS3NmNEY2TWJ3cW9hUU53?=
 =?utf-8?B?RUNTZHUwSW1ZOHU3NVh3dzFxQnBUK08wRTVYNFFqeStEK2hkNU5mSHRJK29Z?=
 =?utf-8?B?VUFYSUVwc0ZUK1ZCRlJMb2hRb0lYS3FNZm1DY0NKcisveGhLYjdWcXpmN25Z?=
 =?utf-8?B?Zm5XZmlzZlVMd0pmd3d5U3pOdXQ4bnUyUktHYVZrMUZhcUVoVlFPUnNRb0Nw?=
 =?utf-8?B?QnVOQmVLWjZsRmZab1llTUZCNVNaQXNUMlZvQWl4d0Y0eWF3MGhoY1hIVFpy?=
 =?utf-8?B?bEI0M0NTMUhsOEhPc3Q4aW9NYkZpR3d2SWNBaU9zSEtGS2VoV2N2MkFMelhn?=
 =?utf-8?B?VThCRm0zdFFxWmlGaHZwazBRQi9UdU9RMU9lMWlDSWxBdFRFa0FiTjhGdlN4?=
 =?utf-8?B?ZHNLVTRka2c3dU9YRzlYeDQyeDFhR0x5WDB3SDdocldaRTU0YXg3b3U5STNU?=
 =?utf-8?B?OE1VUnRTZnRYVkQ4K1FGUTN2K09hYTgwVmpyNnAzNmtHVEphWTRFbmJKZUQ1?=
 =?utf-8?B?UlFXMXVyT0drOVBFRXcwUEhJeng3VFU5dldTZWVHTUlNM1M1eEQxTTV3R1Q3?=
 =?utf-8?B?OWtROHVjZ1dTajF4Sjdyc3JHVnl6TGM2UFB4MjUwdndBeTVPOGVXUnBWeFhw?=
 =?utf-8?B?MUpFNFJ5VWtUN3ZEdzlxUDlBL3hBcTJvaTlqSytlV2k2UEptM3I5alVWckhK?=
 =?utf-8?B?MGFGYmo1NU1vVGJiMGRMSVNCSHdjei82a2tvS08rd1RaekY1S1ljNkRpUHZw?=
 =?utf-8?B?ek1VUCs0N3hzQk4za1ZJM0tNU25FdHVaVDRReXpRcWZrUWsyelFEanRSeDV0?=
 =?utf-8?B?VDNPV2ZBZ0JWck1rTXlxUGt6UGwyVzN2WFN1aUpWbmdJOGoxQ2lNRXM5dUhC?=
 =?utf-8?B?RCtUUjVLVzBhNU90K2R4VENIaWIyeHNGVkdzNm4yZlFFaXhsMHVwenZNT1VG?=
 =?utf-8?B?L2Z1VTEwTUJTQWdiMGt2eVNDZGwrK3g2QWZYdWlNeHZJUzg1R1ZBbXlKRWVw?=
 =?utf-8?B?U050Yk9qc1ZRcnZFMXAyU2ZzY2lSUGJCelNjU3AvQmlOL0Q1K0pCOXVpSXpa?=
 =?utf-8?B?SjdnbkRGdmhkZC9Gdyttd3FkZWo0OTl5SlZ0NVBBRXFVRkJBY1RSdHd2NTNa?=
 =?utf-8?B?M3NwNC9JNUFNL3ZPRjNtUnJwd1c4eGcxME45aVQ1NUZkK2FNKzdOL0oyY21z?=
 =?utf-8?B?UkNLaTN1TnhuSTltN3pIaC9LRXdWemQ0aHUyZk00emF0ZmxTVnZLQUZpWFJl?=
 =?utf-8?B?NDZHYTdZdXlCUmVjUEw2dWFMTlMvOFk1ejJrT1MxU01UWkZXMmtaaXo2SGFo?=
 =?utf-8?B?TmJQNWMzU2pCTGFoVEtNc08rZEtkOEh6eXNUai9DOFBnVVI3SUxBSUUxTFBF?=
 =?utf-8?Q?3IpFXmU85llm/rR3bWBZg+c/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078bee7-d5bf-48ab-1e73-08dcf4dc8c5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:05:26.8041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0slS45xteGb3i9/4mxbRaIC0IM8p/zno2G13ANrJOIpp7PmrY8gDsQN3DNkADJfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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



On 10/25/2024 3:15 PM, Prike Liang wrote:
> In the normal S3 entry, the TOS cycle counter is not
> reset during BIOS execution the _S3 method, so it doesn't
> determine whether the _S3 method is executed exactly.
> Howerver, the PM core performs the S3 suspend will set the
> PM_SUSPEND_FLAG_FW_RESUME bit if all the devices suspend
> successfully. Therefore, drivers can check the
> pm_suspend_global_flags bit(1) to detect the S3 suspend
> abort event.
> 
> Fixes: 4d58c599df75 ("drm/amdgpu: update suspend status
> for aborting from deeper suspend")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index dd1c1aacdd8e..12ff6cf568dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -578,16 +578,13 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>  
>  static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>  {
> -	u32 sol_reg;
> -
> -	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> -
>  	/* Will reset for the following suspend abort cases.
> -	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> -	 * 2) S3 suspend abort and TOS already launched.
> +	 * 1) Only reset on APU side, dGPU hasn't checked yet.
> +	 * 2) S3 suspend aborted in the normal S3 suspend or
> +	 *    performing pm core test.
>  	 */
>  	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -			sol_reg) {
> +			!pm_resume_via_firmware()) {
>  		adev->suspend_complete = false;
>  		return true;
>  	} else {
> @@ -603,11 +600,17 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>  	 * successfully. So now, temporarily enable it for the
>  	 * S3 suspend abort case.
>  	 */
> -	if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> -	    (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
> -		!soc15_need_reset_on_resume(adev))
> +
> +	if ((adev->apu_flags & AMD_APU_IS_PICASSO ||
> +			!(adev->apu_flags & AMD_APU_IS_RAVEN)) &&
> +			soc15_need_reset_on_resume(adev))
> +		goto asic_reset;
> +
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> +			(adev->apu_flags & AMD_APU_IS_RAVEN2))
>  		return 0;
>  
> +asic_reset:
>  	switch (soc15_asic_reset_method(adev)) {
>  	case AMD_RESET_METHOD_PCI:
>  		dev_info(adev->dev, "PCI reset\n");
