Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78766C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 07:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAD210E70D;
	Fri, 25 Nov 2022 07:45:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFBA10E70B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 07:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGz7MdHfJ1tFxumIZ8A+zoNbef6oE8HbsJ2oShJ24tZ7Nih3mFas8YzPsPx+6dYocn/dOcB11wi//ae/CDngtk3atKEJlJPiRnQsrYv0ApqvUtQQ6AIX+mZjar+2r+3xL+8O691dE58u6Vc4YDS4MYH2tvErPmJB3NCV5X/GLS8v7PDQwuR5jSg/c4H6DJx8liRNX2cgLbrPFIN40acWC/Vq1JqyUJRMU8aqjc6ZOzyR/4O3lUoN7yha6kdfkw0AG1QG7dmXQOHO8ympx78u1x5mMjhbbJ5UaPXRfzqcluuiAv4bw4/12a1XfTLwPN1maATsDGQP/MOEWoUSczPVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uMhS5bPEs4fF0P//CCPwp1gygiBwpNixcNu//B60lw=;
 b=cS5WzPapSXKJqypmk52jsfbYzvLfgj5WOZW32SSIoA7PCwCLdGcuIwKgXk+bXUnsaW0fBMYonYQV5NF3jtXCTReeUBwH9lBj8j2ykrf8D/0olGy6OSxT+CbQIN5y1HoSI4d22Gi0REjszn4+LaFjshaqkAk19DbfnGIIAA/rWX2FdtoRhf4BUcTEeOk4StH2Fxkj8EX76VMbAGxp8WKLboT33ZBVoUvWWRIv1L23UdRgq6fHAuNVWCfu8QmHxK8CbKTfjfZP0Hs9kH4w1ZqQ9tSRV++AhCOjkaGotPSE+76uxxpUmjlAPH8NF/CGlXVrEvGXqdFPquJHRAIEMV1o9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uMhS5bPEs4fF0P//CCPwp1gygiBwpNixcNu//B60lw=;
 b=NHM/rLIY5PO+fA9BTXzAJsp2QaR3qg96OO2ilVV66Cl9r3s/mayFKCArJA4oIKmR0Fvme/Zue0mVcDaltVthIFvC4ewMe7lCPFoACB/827Z7oNRFc9fCB7XCnmYhW6ShmU19wZ2cXkbJQCthamdNw1WM8qlzizShIEMoHuydh6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 07:45:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 07:45:11 +0000
Message-ID: <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
Date: Fri, 25 Nov 2022 08:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221124211956.264282-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b5f5e2-c5b7-4bea-640e-08daceb8fb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQ/jjjrnJFJt1qIghiau5bGhc2UsXgIFzW+Capphvk9HjjAxtukHClvyhtHp6aY+17zez4JG5E1V4spVRznpr/sfh896Kp8I6LdP+qB0w1VstCqO8K25ZedOY4EZp0w+gZfPvdYA8ZUnX2UCT2ZBiUogGlee9nXeYe+8CKvtwVbnRUaEs6SxTZR07HGP+ZDrJBJKGQLIUDEoXbeurRf8gKgRVRLQhyxAFnQwD8d2weE40zi+U0GGyDY4PiQE70dkRmR07h6KDy2XKIVcshjp2BAYd6L4G5W+aC+at1c7LKks5B8T3vgSa3snL/Dpx1YA922CRY55+WJPClzpz9zM+0lJiWwI8SHOQE27bcE/ZbcXjxu9uSMC47wQdNTsPeoUVZoS5F/EJZzRULyp3auynVjQLJS7mNZcF053GY+KT96yRicwGG+MolofNnvvGQHp7DUlsNq7vEnWOUrX4gRSmGIAycdnX/mUeds5qB0Qj6CCq6hwdhUhMP/YyeJwaQnFeDodBCyMi9gR+FMViH6XXNlgnCWOxdm+GYDWeg21dgKdP1ZeZivP7VzYeixeyN4vLAwAAYdVOmuJvSv41aE83/zBU8W9Mb37VIrqQOoVSu+Z+mx/O4aNnYSThtjMVWlsRPHLtaucKK0LUqmNaHzuV7Hfn7NhPY9XTfT+fMKx1AEQu+onVeODqg/KXeHcVZBwoeSh8pOtp25/38Fq02U5FWm+rpwe+pMUwnQLjZaR3tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(86362001)(31696002)(478600001)(6486002)(2906002)(31686004)(6666004)(110136005)(8936002)(2616005)(41300700001)(6506007)(5660300002)(54906003)(83380400001)(66556008)(8676002)(316002)(66946007)(66476007)(38100700002)(186003)(6512007)(4326008)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGlLVlZWZjV0QzdyTTM3Vk5hTXlrNVAyVlRtUzB3c1VOSW1vSXBMK21PdS9v?=
 =?utf-8?B?S0V5Z2RySTNOdEIxalZ0dHphMUloNGRhVzhCSkxoRUY3SG91Q25LWnFNa2Zj?=
 =?utf-8?B?b2Q1bXJLN1pqNi8waDFhZDgzcFFMbjFWOTdZU1pnTy96WW9Qb0RVYXJBRUg0?=
 =?utf-8?B?L1pReVRhUFpHTmZXbDc1T3JpNFVGUzZuWDVJQWxBaFAyQXJUblQzdUhZTE5y?=
 =?utf-8?B?d3J6YlZ4UDhPQy9xZEpFRkNRMmU1dXYxdXYzaS9vWDFjc1k1UDZjNGRrTERH?=
 =?utf-8?B?dXMzc1ZBbFhPOW1nMmV3WTV0RVZ1OTQrN1Bsa1I1bHpLNXVCdm9xb1Q5bFJo?=
 =?utf-8?B?NGJsTkN5bjRET1Q3a2FoQk15ZmNCQkFDb05iOE5WUksxcjNOM3d2SjcwSkFZ?=
 =?utf-8?B?RWhWM2FvQ1IrUTRNc3hGYmxscDZUeUtrcENVTkZ1KzNVRTRyYjBFQlpMekRP?=
 =?utf-8?B?NFFMT2tia1J3NWx4YnZtNEMwV1NGamRiM3RYY1R4eUl1R2Z3KzB3cWNUYTEz?=
 =?utf-8?B?M1BiaUwxOEtwVEFpYVVPSGdGU1JnLzdMR2c2WTFLMGlORGtFYlEraStiZ0lC?=
 =?utf-8?B?OVlOMERiUnFzVytGZFdhN2FFREtZUEtRNE43NVl1NHY0cFV0NTQzNmdLVE9y?=
 =?utf-8?B?azYrYzY2T1BtOVErRFpEVlNGc1JjeENVTkFJcVRVZ2pCcjhuSVpyeUM3WEY4?=
 =?utf-8?B?SE5wZUlxWlNtVzNtQXdYN2MwSlg3cngrNm5oOC9BeU4xSGtMT3l4VEpjOGpm?=
 =?utf-8?B?eFdHUGpYQWUvbGkvTStLZmNoUFgzTGdDS3JqcEJIVWxDUGxDUG5sdDhmVGNR?=
 =?utf-8?B?YWZlbng4THA0NnVJb3oyblVOQW5DbmJDTjRnTGdDTWRLTjlwWTBHZjg5RlpN?=
 =?utf-8?B?eklNYzJvL2dqWUpkbitiQ2YrR3dxYlIvMEJUUzR6T0RuUmlmc1RDTHg4bTlu?=
 =?utf-8?B?V1ZUZDBacDVrZzkyeitRZTRHR2NvQXcyZGM5UjRWRUExWUllSENwR1dGQVM0?=
 =?utf-8?B?SW0xbzVOcHJ0VlBoKy96UG5QSjdVbHVucUhCMVFMWnRFc0gxbGdXVTZVM2ZM?=
 =?utf-8?B?eVc0MEZjMDZRTHFKTDRhNGV5R2RFUTJIR25iYVhHRFhxVjNIbGdmNUhsMmxS?=
 =?utf-8?B?TkNHaHZNbDBZcUJhMkh2dzRXSTFXdk90RkxEdGlPZ2llaGJUNUVvU3RTT2tP?=
 =?utf-8?B?dnllUjFLMFQvS0tHV3ZFY3ZOUDJoeFU4SitiMDc1VHF4dW5zZFBTQzhiZU93?=
 =?utf-8?B?am5xd1JXcXRvS091aDE1TEh2c3FEQ0JpalpjOENTbHh3dUN5TUcvdGtLaVUz?=
 =?utf-8?B?VWQzZUZVUk5hbXk2UkN2MVJtN2hHOFZGVkZvbmI1RTl2aDVlR2pFTHhBaWlM?=
 =?utf-8?B?c2QrcWFIUmY5dVVlb3FWRVBETnJHSXBRM0dweWpqZXlxTU1PSGwrQUdHeU1S?=
 =?utf-8?B?enBpU3ZIUHVRUS9EaldNS3BUR296LzdXRnc0bUlWWkt0ODNobHQzbTdRMHRn?=
 =?utf-8?B?UzRBbVcweENTeWJnUElxWUwyL3NEVjlMRGNEcVEzT1ptVXdLU2JTaTlIVDRK?=
 =?utf-8?B?V1k3UWsvSU53Y3dreHlmK3hId3pva1FBNnNsTzhJakFrZ0RJZXRkTDBBdCsv?=
 =?utf-8?B?NXZEOVJrYXpOaDdtY0JuK1ErcGt6cU8wVk9PQVNtWm4vZ29kL1hHdXEzbUJh?=
 =?utf-8?B?eVltR2JraE43c3RQUzEwMHJKUTdZbEhHNmYzQTlWYmExRlJzN1lYdVJhWExN?=
 =?utf-8?B?a0Z6SXNLNVRXZ1FsUjRST1N5bzVEWkFzZ2MzZDhNK2pONjVkM0RCcTU3RWRy?=
 =?utf-8?B?RWF3d0RDa1d1aDlXSnMzT2IzUnczQkxJLzMvN1ZmdXFXeWNRWHFybGc2Y1VY?=
 =?utf-8?B?dTB0aC8yc1B1aUt1NG9RZWhMUFhwSCtXQ2I0OHhtdTc2LzA2WTRBY0dNTDNV?=
 =?utf-8?B?cS9uSkxFdkNXeThzRXl6dkI2Y0pMWmp5WWRnOEtUMDM5OEZwZGxaMVpZZGJ6?=
 =?utf-8?B?eDU2RkpWVVAvTFN0ZlJsQStweCtJQnhMMW13Nm9iRXkrV3dNWXdlRFpuWTJR?=
 =?utf-8?B?Ti9kUkRWWnFtSFRlWkVrYkphRjkrQ3BDY3RWaFFvZVBxZCs0eE5FTEhZZE1X?=
 =?utf-8?B?NndZR0pqSDRUeHg5REI5aHQzVmdUeHdrS0thMm53cERCaG5zcXBKekZ6MXRD?=
 =?utf-8?Q?OV/4vpY48ud+f2+VZTT23NTvN23JIicyXzk9zhiYD59B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b5f5e2-c5b7-4bea-640e-08daceb8fb6e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 07:45:11.7560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d64HaanwXefbHYc8J/0N+hBOJx2olwhdcDlrKa1osr+oy5y/BLjh3N9KjwPvysIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.11.22 um 22:19 schrieb Luben Tuikov:
> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>
> Cc: James Zhu <James.Zhu@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   	hmm_range->dev_private_owner = owner;
>   
>   	do {
> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
> +		hmm_range->end = min_t(typeof(hmm_range->end),
> +				       hmm_range->start + MAX_WALK_BYTE,
> +				       end);

Since end is a local variable I would strongly prefer to just have it 
use the correct type for it.

Otherwise we might end up using something which doesn't work on all 
architectures.

Regards,
Christian.

>   
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
>   		/* Assuming 512MB takes maxmium 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
> -			HMM_RANGE_DEFAULT_TIMEOUT;
> +		timeout = max_t(typeof(timeout),
> +				(hmm_range->end - hmm_range->start) >> 29,
> +				1ULL);
> +		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>   		timeout = jiffies + msecs_to_jiffies(timeout);
>   
>   retry:
>
> base-commit: d5e8f4912061ad2e577b4909556e1364e2c2018e
> prerequisite-patch-id: 6024d0c36cae3e4a995a8fcf787b91f511a37486

