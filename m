Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18884C05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C44610E95D;
	Tue, 14 Feb 2023 18:22:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE37310E013
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKhYns9o7l31BOH0LgFvcgKwsbW8oecvtovZRc1byZ9GskEef9qpGwbs3AupygCewoqJC6DjnPQf7uJp3rihQUPlW9kLjSJoCl/hsG6JzR/kFz/9LlE7p9qOAV2n/w8PhbrxJC5OSh0YVzkWNI62iwv2yySWewwkvHOKC17wHq1Npf0rDu5JatYGsPTne38NmRjCeu9LY7+Ue9+sAsd3jioZXhMmeH58aSLxT/6TTPkW6SW1+QVMy6SaWZXtARizJjCQXsX/8ULh5spXpQ3cSKnJuEWpm/phtw1keseUqFU3yR6xdBLFyKu0q7wFefcJk+sg5evQA1GCpDA7Wm05nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzrEixtIqjEfklrORlsnH6rNtYGJAGLvGsARAuMLmoU=;
 b=NxCX/EdPulGfsrvyrNjsN3A8FmQqSeGamFp10nPxtv14iLZ3rq62weBuV8MLDhT0y/7MAk780F8lG89r3ys0yAjtCtBjHq075G4GlCz+dRpq1OLZ1A767VukGpVNhqKE4I8krKcYzAC/k9Wkti33o/nIN9Y/lXS4YA/1vBzSB37plIB8F2/QRYN3OgQEC7q01rILnhI5KczfrKXYbE3281MX4TlSZliXPNOV1uM24XAnM/m67XQrIL7RiEVbZMkqHZQvKropKmkqn04QWD1LPjXXX/WuVGiBY4D1IxrhSvZ8kUeu44T5zc/hWCf+uDQHt0Rb1tsCgFS/1X61HzVfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzrEixtIqjEfklrORlsnH6rNtYGJAGLvGsARAuMLmoU=;
 b=3dvcb2WqXbnB9edf1d88wfoXOdmDMOlsgLbtjq/7a/NLBGz7i5eY4GThj1+P7HeIjt64uIwu1vrHQPr7XDyeAwUKogXqjIFdEGE1XsdbtjiyybdmIM1HIx9m0B8sHzOFlUflaH5rvzTcXhSfqHsqgqC9MzYyBbLOBXTrI1gQRvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 18:22:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:22:48 +0000
Message-ID: <ea06006b-c537-2fe8-d5dc-1ed07162ccad@amd.com>
Date: Tue, 14 Feb 2023 19:22:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/8] drm/amdgpu: add UAPI for allocating doorbell memory
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5f7326-12c3-4278-1a3d-08db0eb8796b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2HjBX0j9P4f9Cj+2g/Rx9SfpkGXKZWGnJOm3NWk1AGicl3TIki6nbeS4Hw/LKNuaqQ2GV+ixKbukhhFe/S97CLnEDZu5F+nFr0Ns+qRMwyAo7gkH1SdqhU1owDLq/NaV1DIW2hjUzox1yYIjpdwdeAgd8mWJx8d79+yWYK4c87U9M6os1ut7vGD1FiIWg4oP4cBvcBxCrkvIUHP8l0x4pma0fqut/3w7KIzV0imUE7/b4nhmv2PSHXxW3wViEMgRP+rwRVP8MkjULYwRXKLNuXKDpIcxTzeCocwR5cRQOLVkr3RoeNTtAWvSLwOP+7D/mOvDtYRL7GwOQLbLhUY1/jfesRN7bJAd4zzsPVy1Evi6pfdhjRWvUQzFjep4LnLxP3QQWR+S679bwfhPq7AOkhBG0+FfAvdmceHQ09pIPEJS4zEakZ3VnplEKnbxcG3gTcffJeN2ftDj2+6hEpDHpQ50U/3GZBTw7o/YbpKqNHW413zeww3XjiMjJf5BsFLj4wklK7ofvJSinJAiKKX0rR5XH1TixRrkdYKezdLR+iJlgsh0obYz7lsJQS6OtxNInWha84by5Mce7muq9ONo387NGmMR05//7MGsBFMWil5Q5Llw6SHGj6aRf7QSMseD7mBUyF9n8Ui7/Gp8s/Iw8w+112mnM84jNuBClWqZs4ac9HdhCLdyK2tu8KFQFwm7Y9egXvYzBJ93VHVLUJlwUC2CIAYKO6XZA316OqwfTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(5660300002)(2616005)(66574015)(41300700001)(36756003)(186003)(38100700002)(6506007)(6666004)(6512007)(31696002)(8936002)(2906002)(478600001)(86362001)(316002)(83380400001)(6486002)(66556008)(66476007)(66946007)(31686004)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNsMis5YlM1SUJFZFgzWWErci9yNmhCWnlJOE9PMlozM3FEV2ZCSGR1MlNN?=
 =?utf-8?B?Y3ZhaFhXbDVWNFl2cUk3WmNna2ZPcEhUd3g0ZEIwWnpHTVNWRjNyQlJ2SDZW?=
 =?utf-8?B?dklVMG9GS2pWYWJxZWlzaWR3MkZaU3BkbXNrNDk5d1ZWRkhlMEo3d0ZBNUlK?=
 =?utf-8?B?RTZrSlUreUtIOUFtNmZXZEhFMlZOMEE1czJKR0swOWlnUWRQYmIxRkh6TGNr?=
 =?utf-8?B?VkNDcmZzYVRpQWtFOFVVVWVuWTNIME12elBzTnBqMXd3RFZKb2xMQm1uUldL?=
 =?utf-8?B?Uk9HZDFKa2EvcFpzdTk5bit5OFV5MGZoV2pRNjB4SlFtOUxnZVdBOXdiQk01?=
 =?utf-8?B?T3pyRUxmdHMyVnhVVGtlaW9kTXlqYnRpeFJDTGhWS2ZzWW8xMnMySE1WRDhV?=
 =?utf-8?B?d0YzVkE2clFjYjBYdkVwaVp1OVYxWHNhcmtOQ215T1hYWTgvcmVVOGFzZzVq?=
 =?utf-8?B?SjNBYUViWGNhaS9RSTlqSTRITEtWTWZWbHg0Y1RmQU03ZzFpNlNmaEtKOGJS?=
 =?utf-8?B?azhncWl1bXkzT1YydE5tZDg4Z09JVDIrU1crK011aDBTR3NQSU9wY0RtMVlR?=
 =?utf-8?B?UVZlQUlOdnZHNUZtZEROZVFwMUNyUTB1NFIwcERxdW9tSGkzNUNtVGhsdEVL?=
 =?utf-8?B?cWQ5bW0yUjNhUjdYdit6Smdmb2w4YzBKV3FTenNnOVA2MmxHdXg0OUREbFlm?=
 =?utf-8?B?RVZONGoxR054d0g0MGtqUFV6a04ySFpxQm1xMEp1UjRGQmhBWFhrMC9iVG16?=
 =?utf-8?B?citmUkJTa3J2dUY1ZWh3SmthSW1pYnBYU1FUMDA4SDRmR0FhM0RlS3FiLzZ1?=
 =?utf-8?B?RFM4SHNaZG5UWmNZUXVZZDk0ejNOK0JhYkhXQXlDRXIwNUFveFV3QkhOQ3RI?=
 =?utf-8?B?WDhrTlJGam1BWTVjRDFOMG8xSXRQd2JHOSt2bGgzaGtwMVpIbmJiVm1BL0wy?=
 =?utf-8?B?RHhtcXNVQ3Rybkg2RnBaVGNveUJHblM4d1hTWE1mWEFzVW10UUZyMkhjN2FF?=
 =?utf-8?B?UzlUL3Y4MERWZzJDekJtbFcrZkRhWVVtbHpuY0JkZXVpNmlYRVhxSnphUFFE?=
 =?utf-8?B?Z0h6U2lZcXlyVE01M1V2Nk1PVmdQazU0MEdJMzZPaHVSZ2twMTZLNVhHTml1?=
 =?utf-8?B?bW5aMWlldmFTa3Ryc3lzMG5oSDYybm5wdUJQdVdWN2s4eTFCbXBibmhCL0ds?=
 =?utf-8?B?eUdZcGRMZnRwZWlCdjBGWVB5ZkpCNzBJV2poUU1SZGxpMS8rcHJnM0NCZGFP?=
 =?utf-8?B?UG1KSU5QSUh0Q3phWEl3bm9EQ3I5UyswcFE1MUliN1FyR1A4aHY1N2dvdmFW?=
 =?utf-8?B?Z3lDT0MwRjh6TGdmd09IYmtCSkZpNFYrUEtLTlR6UjhmNjNiZVhhTGxnajlu?=
 =?utf-8?B?eWNMNHpRTUlLelM5Y0lvYWhNbmRmNzlmNnUxM3NVNnlJa3BXWkwxNmFibGti?=
 =?utf-8?B?dTJwREkxbUJLcGVobEpvOE1ScTJINjJ2UkxlQ3l1TktuL2lDMmpYblBhcTI3?=
 =?utf-8?B?ZHZnM3EvRkdSRUVod29TanRlUjMwWkl4aWF0VXNVREhhK3ljdnZoNXJpSEJU?=
 =?utf-8?B?Qzd0QU1lNERDb2o2cURNck5pUFFjaXQ4M01QVVN6YkJuZklUQVhVWk5hMmtF?=
 =?utf-8?B?VmN3M0pMUmZ4N2Z6TTMyYlZxUmRFbGtTMU5kM2lic2hBYzNEcWNuZVQwNS9M?=
 =?utf-8?B?RTF1OWZ1RFlIWElVMXljdEwzMjhYdXVCU2RiRFVTTklQWW5rTHFPVFF6eFhH?=
 =?utf-8?B?WlhwcXgreGo1NXF5Y1h4WTl1QTMrKy9KT1ZQVEp5YzBLa0FORE51ZndGY1BI?=
 =?utf-8?B?M1U4UzRhM2pQTmdkMGdGaEZOWUNMWTVTY3Z1R1pnS211dDlOczBLTHBXNzkw?=
 =?utf-8?B?dGF0UHJwZ2RBS0x1MWp0RVJuU2RnamRmVjdWU3dXMHZKdElrOWxGTThhV1pk?=
 =?utf-8?B?dGhGTXluVjZkbGZQWDdwV2JGOERUOFhlZ2dRVWFpM0dqbms3cHVKWmNoMWtx?=
 =?utf-8?B?M1EvWjhsMW1Pem1teVo3STZIcWtIdFpXempjOCtISldMS3REaW9sMzVjSlhO?=
 =?utf-8?B?ZlVybThPUFdpUnVOYzV1U3B4VDdSeC8zNkE0L04xQzBJaU9TRVpvdllEY2g4?=
 =?utf-8?B?ZkpBS1I5cXQ4c2U1SitDRVU4OS93VjVEVkwxczAzTTNFTmcvdGs5VlJIZVVv?=
 =?utf-8?Q?JMoXM78qMvzzN+5sNv2ozRyfSksy6AR5VpywCtYjrErm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5f7326-12c3-4278-1a3d-08db0eb8796b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:22:48.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PWT/twfj37jCDZ4R/w99Wf2VLjWOF6KsvAT5+SrSYioXtUhXdDPi9xB/FpVXAA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
> in the UAPI layer.
>
> V2: Drop 'memory' from description (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 4038abe8505a..cc5d551abda5 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -94,6 +94,9 @@ extern "C" {
>    *
>    * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
>    * for appending data.
> + *
> + * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
> + * signalling user mode queues.

Maybe write "for signaling events to the firmware, used especially for 
user mode queues.".

With or without that Reviewed-by: Christian König <christian.koenig@amd.com>

Christian.

>    */
>   #define AMDGPU_GEM_DOMAIN_CPU		0x1
>   #define AMDGPU_GEM_DOMAIN_GTT		0x2
> @@ -101,12 +104,14 @@ extern "C" {
>   #define AMDGPU_GEM_DOMAIN_GDS		0x8
>   #define AMDGPU_GEM_DOMAIN_GWS		0x10
>   #define AMDGPU_GEM_DOMAIN_OA		0x20
> +#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
>   #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
>   					 AMDGPU_GEM_DOMAIN_GTT | \
>   					 AMDGPU_GEM_DOMAIN_VRAM | \
>   					 AMDGPU_GEM_DOMAIN_GDS | \
>   					 AMDGPU_GEM_DOMAIN_GWS | \
> -					 AMDGPU_GEM_DOMAIN_OA)
> +					 AMDGPU_GEM_DOMAIN_OA | \
> +					 AMDGPU_GEM_DOMAIN_DOORBELL)
>   
>   /* Flag that CPU access will be required for the case of VRAM domain */
>   #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)

