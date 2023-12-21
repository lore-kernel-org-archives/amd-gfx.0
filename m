Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA2AC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 18:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A147510E6EB;
	Thu, 21 Dec 2023 18:21:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAC510E6E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 18:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT02ExORvFKPp623J9ofhbDX+RDSP3pP65YoB+EPfb3ka6HktF3EB6woiLEu5Gx7/zuuJ985XrNlByj9SUdIsMoWsVhUHeS206B7ozIbSENaB7SI9rSWuXxe06tC0sFGJCEJFc2gkTSm2R3mJtx08tNTVY1nLXzJ5/kzKPcmNhMXpthy/W6kTJt66ychl5a9XWpiJ7CCxmLUsk3IlMAPSHObL3QyLbHVrEKyeLSbrvl/8SVoB1DRRljUXzO97NBP4JoSu4OhUlhnguuoUGuR3u3a4ApVv4fAjfIbzk2Oe6ErW5/Uf5CRFla1mIEcrieuMoeiseIEXpyTQ/OQpDCLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JDAV8IUSLYFI4DsoA28+ZaT5gBvR4BSjSpdxKFaMlg=;
 b=mEwDahy3kB8LZYS6bN3Tje+L1HVprHyI3vOmIUQqX4D4VBJBMOJ6kwQuZbVmTfUw8oGXmtnCEHLBL1hPHF98iZt3n/xhQ/SrX8mm+RVaSbL+xO2dDeAFK/ZJhEq9HtQi6JlEM4jN/28agmj+JqnILNPzZG67GH/T8Trk0pmpJQoY8HVKVgef91kpsdsUM7Mpn4KrvxodEznoBxdS3tIgBp1zqQHHzHVmUsHg5opxJ7dDULkgLdGpzykPa00hu6OkalalwcQVHJUdYVZC9ZP/jna0R1mwlNg6kUvTZLNUDtMRdIxL/gSuwtZ25RlK4fIUhneDRmmVtZYNujivnwqoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JDAV8IUSLYFI4DsoA28+ZaT5gBvR4BSjSpdxKFaMlg=;
 b=Oj0HkrS7z3KA06ZEOqupceWyVFEEIX7LjJKzOndI/F883HWpG8HJJBEd+6ywc3mUxjrIgW7PVaO5aRTshlJwKmiDsQv59jmZyp6uBaNyvIKoohNDbHYdo/nqos3jY0XL20rRoZojZANQrHOsUGTtieVEYWoc2qbxcMw20z0BiL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 18:21:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 18:21:02 +0000
Message-ID: <6a2fa3fe-b05d-4242-bb91-0a6a504ac1b8@amd.com>
Date: Thu, 21 Dec 2023 13:21:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Drop redundant NULL pointer check in
 kfd_topology.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231221020024.1138473-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231221020024.1138473-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cb7561-a73e-43ed-9f40-08dc025196af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8fX3rSUkNDfQRMGBecBzb4t9wTSHGgRkk0FGy5G+LXmSlB6IAbyNOMxjvfGmXq1iagG7yqVtWdurMK/glQw+WVaW45Sw6erA2PdAM3OP7TMrp1p/2pjapO++3ogLEce9/BZjpS2ZCOSP8dpLNsGx7xAILR6SodjzlnAQpPZ4ILW0znhK3mYPaKFERhTLKzFeFbPPHEtWSlXBnQisRfbZCpmhz4b3PzfBf0VkMdxytTEHNsVjZ6sHuxFFaAeQQJ5JAB/Pi5TqZmf0LJyClPLaCqNwwR6ecKFYjgeCtnwy+SIct+VIrSdu3IwBg/dOra+/D5Nir9XPVPpcnahLvoMCXdPAKPFZvuKBZ4+pW+VQskza8JIRc+lK3KN7zLHGNw+JQTdgw98F5Na2CopqW4rYZQ+cMHqsLrcFtFSVhqKwx0fK3UEQvz94+PXrRopDrcTZ98Qk+8aZCIm09lOmnEpk9kXG9/elMysF0AFONHkBcF0ySInRJpqHOScImMe3ILGGH62tvSPvidu/Rh/wDPNaJIy5Sf6fEfxMsdWvEwY/iVV2sYt+eFfnpgVF93VgrUPp6W/F+GosgPxA6R+N2MsYxK99JM2qrLXutPB4qqvhpbldESE70baGLyDn6Xtrj1K86lzNHB+1TqJYAaj45Qqrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(6506007)(6512007)(36916002)(2616005)(36756003)(86362001)(31696002)(38100700002)(83380400001)(4326008)(8936002)(8676002)(41300700001)(44832011)(53546011)(66946007)(6636002)(110136005)(5660300002)(66556008)(66476007)(6486002)(2906002)(4001150100001)(316002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNMR0x0N0FpczM2eWpBWk8wK0t3THZ4akM3cDZFcUQ0YzdaWkdmd01YWDM3?=
 =?utf-8?B?cTg2ZTBRdlhMeVlZSVJneWVteDdjb0wwNzdkRUg0V3VXWGxZWVRCNW5aUXNE?=
 =?utf-8?B?czE5b2g2RDJKVjFOYmZObHZmMmdXcEZBVUFIT2ZjTEZKT0xBVmZESGdQWTFw?=
 =?utf-8?B?SnlFblBjM3ZRcDl0bVFPMjRzaE1WSGRIbndmOUNuZWZrOGkzVVV3TjhyUlVj?=
 =?utf-8?B?amJGcXcwSEZYTmg0QWR0SDJDRHJ3NkdIMkZQLzl6SHU1VlFYVkVseTZpUGs3?=
 =?utf-8?B?Z05tc1MwWkJTUkdObjZGLzVaenJPNGdIZm1LWFh2dzVTMmxNcld4eURZUTN3?=
 =?utf-8?B?T2dKdGNxaXJhMVZEbERSMG5ETXcvUm44bG1yT3Z1c3JQbFg3bVRMYzFkc28w?=
 =?utf-8?B?ZU1SbkZGQWJrdXlBdkJ0c2U0SlN6WXA0anBYSDV4aHlJMTBrY3BnU25sM1Zl?=
 =?utf-8?B?dHc2ZEVlL2MvTDY4Y1Z0WU8vQU5nWlVtcHhlOXdSc0haQ3BqK0ExdGNKM21Z?=
 =?utf-8?B?SnpQZXZYZFl6TFB0UEExK0VYUzltY0JiSjlxM1g0a2ZhZlZ0cHdya2lNMU5L?=
 =?utf-8?B?VlVtMEMyQ1Q5TzhXdWFjdGRsSlZSNFpVV21mcXlYMTR6bWRMR1ZBTlBnS1Z6?=
 =?utf-8?B?eHJicm41V25WanNQZVFjUFdZV01EWVZSV21VeU51NW5yV1RVRVowZEN3cDU0?=
 =?utf-8?B?UlhzMWluZVpRZlVsUnZoTTRndVl1VGZvczJFT3RGS3VoL216aDM1QlR2VTZ1?=
 =?utf-8?B?dVNkRlo4YXdDdDl1R0gyUTVGSm82ejRqS2RZNWxXNGZqZ1F4UXJwK3huTW84?=
 =?utf-8?B?blROU3QyUVV0Zk5oWlJsbjhTcE04WE5BUW41b1BLL2x5OUxhN2VreU9iYkNh?=
 =?utf-8?B?dUxkS3UzTnR1YnNaZDhDWjFoSlZiRFVYdTBjenJpTzZQamE3d0w2bTZvTXRB?=
 =?utf-8?B?VUs3RW9VL2RmK29YTkpiZ2JJVGVwSUpvUmVQS01iK2t0dXZrVGRteDFaa2Fy?=
 =?utf-8?B?NmxreEcrTlcyVitFWGFXWkZMUTVJTzM4bEdmN0FPS1FOV1FLWjJBU1ZoeFlL?=
 =?utf-8?B?Vkl5amhrbUI5Z1hFSkRrU0FtdjRpNUVvM080Q1kxaDdaOGFscTF5aHU5WGEy?=
 =?utf-8?B?eXM3YTlLTlF6M3p5WGRrYnNuRWRvYkloRGZsOGlwdGpVWnY2NEFqcFlqeXRX?=
 =?utf-8?B?V0pYVkRtRmZnVUdkemZJY2VxdW9hL0RYbTk3V3pOYjdGbVJsbk5BMklMOVZl?=
 =?utf-8?B?a2ZMdEFCekQ5cGlORHZpNDQ5eGxmRHAzTkRlald3QWlFb1RnMWxNUXJ5aCs0?=
 =?utf-8?B?MVdYNjlYcDJka3NXb3d0b2FYVlpuSE4vSFNtckdpNkpZVk9xcjFaRGVpN0hT?=
 =?utf-8?B?WHBJOUtOY2tYOWRFa0RPTWRXdm9ZWlFjOHFqRkNuZEszRUdLUng5U3BOditn?=
 =?utf-8?B?NTJMcnZiSFRJU1NHZlRVMG9PcG5lOGJiTFpLV1QxYzBJM0tjMyt0VjBYU2JY?=
 =?utf-8?B?OHFPK2xSek4ycGhYSEpzakZmYldQKzBCMDZVUUVpaVoyZ0F5YUZHbDA2bXg5?=
 =?utf-8?B?eGFaRnRHNWY0V1REOVY0TmUvTS9Ka1VNc1VMZGdzZllBWnNjQklIek13UWZE?=
 =?utf-8?B?b3o1SDlSQWw0S291KzlWSWxTS1ZZS1pDVUdQbmZjaWhDUWh0dDBFdCt2QWNJ?=
 =?utf-8?B?QjhnQ3p5cmg4ODVxa3RqZ044V0JuNzRaYk91Y0wwWWJONjk3b1p4eUxOY3h0?=
 =?utf-8?B?WUlLSk8vem1xZ2JhQkR3RFNMajZhRG1XMndkSHV2L1F0QkRmeVBPUzNrRVkr?=
 =?utf-8?B?UmZDMlJXbWRJa3N3b3cvaUJDNEIzUXFqQmlHbDhnUFM3NS84WVZ4cHl0WFlW?=
 =?utf-8?B?alNuZGhvQkZ2WWZWQ2lDQ3V2RkNlWkJneG8wVU9CTmtkZVBNS3czVjVvZ1Y1?=
 =?utf-8?B?VWtnbDEySjh1di96dk1MRElWQUpCR0cwMUlXOUFvbUloSVp0aUNwNDdXY1Fq?=
 =?utf-8?B?cUFHY0dxc2xDKy9SODZrMEZRUU1heTI1Q0t5cit5cE4xdTdmS05Od2ZoZHZL?=
 =?utf-8?B?SC9JU0dNbXhaRnQ1SmtSbTYrRDhnc0ZjOFpVMDVSelh0T1cxLzFWU0xDRXhO?=
 =?utf-8?Q?YYpfTKVFRqSNH+R0qGKG2QR2U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cb7561-a73e-43ed-9f40-08dc025196af
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 18:21:02.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjUYjYjzZ3GsfYkU9QKY8VaI5lDvxRgMX/Je6Olqc5vZUKJ43JWExyzvVapG4moNxeGFHWkciQAA1jc79USbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-20 21:00, Srinivasan Shanmugam wrote:
> The list has the head node, the NULL pointer check is therefore
> superfluous, Hence removed it.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1347 kfd_create_indirect_link_prop() warn: can 'gpu_link' even be NULL?
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_add_peer_prop() warn: can 'iolink1' even be NULL?
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1433 kfd_add_peer_prop() warn: can 'iolink2' even be NULL?
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index dc7c8312e8c7..141a8b3273c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1344,8 +1344,6 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   
>   	gpu_link = list_first_entry(&kdev->io_link_props,
>   					struct kfd_iolink_properties, list);
> -	if (!gpu_link)
> -		return -ENOMEM;

I think the problem here is that list_first_entry expects the list to 
not be empty. So the correct solution would be to add a !list_empty 
check before using list_first_entry.

Regards,
   Felix


>   
>   	for (i = 0; i < num_cpu; i++) {
>   		/* CPU <--> GPU */
> @@ -1425,13 +1423,9 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   
>   	iolink1 = list_first_entry(&kdev->io_link_props,
>   							struct kfd_iolink_properties, list);
> -	if (!iolink1)
> -		return -ENOMEM;
>   
>   	iolink2 = list_first_entry(&peer->io_link_props,
>   							struct kfd_iolink_properties, list);
> -	if (!iolink2)
> -		return -ENOMEM;
>   
>   	props = kfd_alloc_struct(props);
>   	if (!props)
