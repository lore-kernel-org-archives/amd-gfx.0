Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E59C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 00:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD5F10E05E;
	Thu,  2 Nov 2023 00:58:37 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4C410E05A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 00:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfzBQvZC60sNQyhcrkXc45zkBExryWNiZuku0VYVufiPgMT7jGAlExiWMGg10Si1SH4LwKJbsy+JTBidai37C5ZWEhh682U9DRgCwqVHzxHCU5sPiny9nipUGRbK2DQY1BIX2JcnyTjQ4i5tydhODrjmJKeJ0OOq/5ftXJfkSzCU5QYfJwhXPOSpTQynldSm/l9ZJkQzc0iJQ5oebX6g9/8R9MZdEZ4if2NS+lMOfJuydqMjf8qd/5F/24o6mstpDswlPFvt7zdiThr622ZLLpR388eL8XOPjBveLlLAhdImgaY0lZel/637t324B7I6MxzP1p6LCwEbzrfliU9RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEwF8MnJx/S/HdV+Sm6nK4zJww+N/TK8nCrJYISm39E=;
 b=J8BEe2BGxRb4kDu33hT4z3x6sFRhn/1uGHbS3tHfnuRiAUTJwqoagvLqgOuOLUbEOucyXCSgB9QyAbm0KYrdHouv2wBSD+uq+PkHuSNQm2Oz8b9DVf0AZuAIiueDWY+KrPCg3g4M9TmoVVu1LCjY9AR5+h0XVVNFofDJVrTYFk9WrGjtlsqOs4M+QGtMeo57db/mrbaBoy90NPZWHQh3ddolCPqjmw5NxEdiIsUXfr8eTqXkVV/ZMYeOurarg7eIksLO+NBxkWLMxVpDdwqiqoe3f7mA+1fGpo+eK/ZD4qLz9ChqWRhUKhNow6Lr1MP+u2v/rEU5ijZw1n0jcbqAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEwF8MnJx/S/HdV+Sm6nK4zJww+N/TK8nCrJYISm39E=;
 b=W45BGYmb17W9OZje+Iy0Q4lioCN9pnhtbRUOD+3uI8p/Iq4Hglza9e5GC6bvG1saYXL/UU/EhZ1huaVBzccHTXfZC9uQriTz8YMa0H7+Lo9JFpnISe+cUJt92bFkQSD+krHkr8Z9rcmK7S8zhSAGGpNNb+z3PgL0NReXJXOBDyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 00:58:32 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6933.028; Thu, 2 Nov 2023
 00:58:32 +0000
Message-ID: <b499c258-9b13-4612-810c-979ee847059e@amd.com>
Date: Thu, 2 Nov 2023 08:58:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Optimize the asic type fix code
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth.Feng@amd.com, Alexander.Deucher@amd.com
References: <20231101030442.1988771-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20231101030442.1988771-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4960ccdd-461b-4e0f-1916-08dbdb3ed55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lli4keplki62028zq0ol+Vrhlfa7GViHqqqE8xZOAW1hSczR7PV/oadMF0XvAw4ppzOwSzhxstNl31+vCIkRlNTW02JlBsQJPjGwajonEDqOw7LN/4FhVadvf+oHHr6739yYFQP44jdIgW0UURxGeI8mv13CgRmBUYoTq7fZXL323siMaW5U0Y+vY+cLAz/7Nn5RU5rWju6o0ORXpD0jUkVOMor+LXuLgtFbKKw6a1Pd1yHMfjpedX1Z5NdbvYYARpYYDYHhpyDwV6uEccK6ZyQIuCN2ijGpxLEBRZwfvhbTr6/GqC1IBwPTaotNsFbMAQzUZOazwbqq51A2Nevm3DM/N7AcsXoYsw+Ut30XwD7dBhjEJgW6WMmezRxwZzHfJerBZeS1WSpvDr8sMcoAOE8xXsndNg014YD41nQrTleCotWxDmtfNB1mpWLK6w9lDvPCDWgcXINJdw1DitHicPTVccLLtLbQkA6XgaOzaJs+CCbK4fUOOWhkg4rX4tEY0o/vX+6c5t7p5dV232kei+FfNhe9pkHiYEc8/+0f2id5BwMj/ZIdVHBgpnk5CRQKMa9HA+J/RdZVObTUsAecKHvAjvNGkdd6VQi7ec3BxOAyBr7gfTrBYAN3YBNGUw6hR47zyjwrSXWr8XtzC975EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(36756003)(2616005)(6506007)(6512007)(26005)(53546011)(31696002)(6666004)(38100700002)(83380400001)(2906002)(6486002)(478600001)(66946007)(41300700001)(31686004)(66476007)(316002)(66556008)(8936002)(8676002)(4326008)(5660300002)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJjd3RxNmhaOGdwR0pQMWcydS90dDVybmtlbjdoR0lXTWovdzNNNnRCbDkx?=
 =?utf-8?B?T0QrQ3BNQm5GOEFjTDdFR01FVFFBb3ZNN0tRWEdGb3p0Mkl3SG5hWmdjemxF?=
 =?utf-8?B?ZHFZNXZjY00vaERZeFByWjZNdDFxUjFNdFY5NlRMa2FBdEV3Nkw0akZTWjBB?=
 =?utf-8?B?VDJUWUcvRnFIWjBrWTdCZGpBOFBLdXFyU1F4eDJ5d1UvdGw4bWhkWDRDNU8z?=
 =?utf-8?B?WWRPRGZscWlPNVczZXh4YmxieWxVZG5palVCbjBpemxQZjRvM2thMllVR0k4?=
 =?utf-8?B?MmpHM1NGV2NWUlBLTFlJNmxkemlPOXRRWXZXNnBiZzVibEZvcVUxaFh5d3hJ?=
 =?utf-8?B?WHJFb1FOZ0NuZUVNZytJVmI1Z2o3TUZNamp1WWRGaU1JMHRhaDNkYWNlTGRI?=
 =?utf-8?B?d0tWdnVERDFYUU5xY1UxblpUdUx5Q2RpUkZFLzRoNks5U3ZJN2tiakVQY1Rr?=
 =?utf-8?B?b2x4SWVLTUc3aDhBTEhuVzVrazd0TTEwZzQzdHNrZjBPY3o5TkhNN3VPM204?=
 =?utf-8?B?N3F5VFV6bUFwQk5zdE1TNzhPNjVxOVhlUUY2dDcvTk9IR245dHhpOGdtQXhZ?=
 =?utf-8?B?NE9MMzRIQkFUVnI4dU1aZDJVOTUzU2RydDRlS1RtY2doZEhiS2FQd0ppUStO?=
 =?utf-8?B?bnVUazFzT3drYURpNFlpVUduR21hSU1aUFVqdUk4M0ladVQxTHNkcS9xaHRS?=
 =?utf-8?B?aHVIQTFnM1czWUVsenkzSS85QmNnQUxjNzJROE9hQmFxemZmNVZYc3o2b1NE?=
 =?utf-8?B?eThVWldEVUpyRVlPOFRpdE9HWWxHbEd6NG9hY083bmdMUkwvOSs5bHkzeVpk?=
 =?utf-8?B?ZE5zdkFFNlRObVR0TURVdXQ4MStrNFk2NkdMeEtzVjZ5VGNaMkxFd0kyMXNk?=
 =?utf-8?B?ZXhPQmxqSFFPUUdtZVdvZzVxNzJyRWlyRURxeHJXL0wvN3hSTzRBUHdQSUxT?=
 =?utf-8?B?czBjMldPNnZ4eENvTzZ2TzkrT1EyUngzblpCcEF0WGMwQkV0WFA3czdIRFI3?=
 =?utf-8?B?RWhUb1Zscnc3b2U2UloxSFlYT09nWmxTeDNuNURDdHV5ckFyOHRWUWhSVzQr?=
 =?utf-8?B?WE91R3c1MzRtLytnemNJdkZ3OEVLUmhJazRhbGR0dFM3dE56dHd5akMxTnRF?=
 =?utf-8?B?NXRlbFNjRXJXOTNMTG04dlRIRTFEYTNUdWMrZTc0cTQ4dXB3dW9UL2xRQVZZ?=
 =?utf-8?B?cXI0M0JPSWVwZzVMMXR4WWkrS1FlSmNhTWFSZGQybGc4Vi93elBYVHBpWFFx?=
 =?utf-8?B?NUZlb3huek5XOFZFRTBvNktCSkwxclJzMXdhY1B2N1p0TkYxcUpSamZVa1FG?=
 =?utf-8?B?UEJJZ21jUXFNUnVyTGFtczhuc2VUTlpZdDd5OWhOZDJTLy9xNVQ3QmpQdFdY?=
 =?utf-8?B?Vm91TWdHaUdpaUdnenpkSUh3aXZZZEFqWUZvbEM4Q0ljMXE4b3FDd09DQlNO?=
 =?utf-8?B?bzFRSVBMaTJZOVkybHZ0MHRhNkc4UWIyR3N5MUlwM3FKNjFjb0s0NWlTajJl?=
 =?utf-8?B?ZGttL0xseDhOWDdzaEk4Yys2N3ZFaDVwUTdVa0QxY0Q0M3IrSGtqL2Jaa2FM?=
 =?utf-8?B?SnEvREdjVzhCTG9CWVFOUUZBVXY0aTdhbHd2c0dkRkpJUUh6dGtCZ3pvNWRV?=
 =?utf-8?B?OXh5RkpxdFREUldQOHhDUWkzQVhCL1RyVElVekxxaUhBWk5PSVIxU1p1bW1W?=
 =?utf-8?B?VlRWd2VlNHY0d1lpYWs4eHBzSWFyZ0M0NDZCZk5ERkVyTHFGMW04V0drL3lo?=
 =?utf-8?B?SG1UQS94azI3NDJsTHV2NXVLeklSN20yQnl3SENrSWtvTkFzVlBBdVJyRVJo?=
 =?utf-8?B?M3ZVMjN4YUZiQ3VZTDVDczJ4bzhRMUsxeHpGT2puNGlTaTkrbVNSR2R2U3Rp?=
 =?utf-8?B?cXdZTE5yak5QZWpJaDRWK1l4TXRKNm9sbk4yTENuVE5BWVN1M3ZJMWNHN3l6?=
 =?utf-8?B?ZW9BUDVtaVNpdFRCVkFlR3dOQ2RhZmZxOXh5NU4wNmp2RXhpRlNmQjF1ekZn?=
 =?utf-8?B?Vit6TnNlSDVTMFM1dFJWcHkwNHZPb1ZlblQzTzVvZVZrdXUwR21nTXk2bnRD?=
 =?utf-8?B?eWZDTHl3SFJTemVTQlpNZGI3Z0tnYVF1by9BZnAxS0dsbEV3c3lyZGlCZ3V4?=
 =?utf-8?Q?AXLt4nay2GyTaF5C+pb7yph4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4960ccdd-461b-4e0f-1916-08dbdb3ed55a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 00:58:32.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7srkYjpNA8tcpTiJFp/beYx+2A8hdjXp+W7gAruZXeyZzVFmihdTZqs41dVcq2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

ping...

Regards,
Ma Jun

On 11/1/2023 11:04 AM, Ma Jun wrote:
> Use a new struct array to define the asic information which
> asic type needs to be fixed.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 35 ++++++++++++++++++-------
>  include/drm/amd_asic_type.h             |  5 ++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 84703e0a73bd..756cf49557a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2067,6 +2067,14 @@ static const struct pci_device_id pciidlist[] = {
>  
>  MODULE_DEVICE_TABLE(pci, pciidlist);
>  
> +static const struct amdgpu_asic_type_quirk asic_type_quirks[] = {
> +	/* differentiate between P10 and P11 asics with the same DID */
> +	{0x67FF, 0xE3, CHIP_POLARIS10},
> +	{0x67FF, 0xE7, CHIP_POLARIS10},
> +	{0x67FF, 0xF3, CHIP_POLARIS10},
> +	{0x67FF, 0xF7, CHIP_POLARIS10},
> +};
> +
>  static struct drm_driver amdgpu_kms_driver;
>  
>  static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
> @@ -2109,6 +2117,22 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>  	}
>  }
>  
> +static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(asic_type_quirks); i++) {
> +		if (pdev->device == asic_type_quirks[i].device &&
> +			pdev->revision == asic_type_quirks[i].revision) {
> +				flags &= ~AMD_ASIC_MASK;
> +				flags |= asic_type_quirks[i].type;
> +				break;
> +			}
> +	}
> +
> +	return flags;
> +}
> +
>  static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *ent)
>  {
> @@ -2138,15 +2162,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			 "See modparam exp_hw_support\n");
>  		return -ENODEV;
>  	}
> -	/* differentiate between P10 and P11 asics with the same DID */
> -	if (pdev->device == 0x67FF &&
> -	    (pdev->revision == 0xE3 ||
> -	     pdev->revision == 0xE7 ||
> -	     pdev->revision == 0xF3 ||
> -	     pdev->revision == 0xF7)) {
> -		flags &= ~AMD_ASIC_MASK;
> -		flags |= CHIP_POLARIS10;
> -	}
> +
> +	flags = amdgpu_fix_asic_type(pdev, flags);
>  
>  	/* Due to hardware bugs, S/G Display on raven requires a 1:1 IOMMU mapping,
>  	 * however, SME requires an indirect IOMMU mapping because the encryption
> diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
> index 90b69270f2fa..724c45e3e9a7 100644
> --- a/include/drm/amd_asic_type.h
> +++ b/include/drm/amd_asic_type.h
> @@ -68,4 +68,9 @@ enum amd_asic_type {
>  
>  extern const char *amdgpu_asic_name[];
>  
> +struct amdgpu_asic_type_quirk {
> +	unsigned short device;	/* PCI device ID */
> +	u8 revision;	/* revision ID */
> +	unsigned short type;	/* real ASIC type */
> +};
>  #endif /*__AMD_ASIC_TYPE_H__ */
