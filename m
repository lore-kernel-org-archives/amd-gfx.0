Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0CEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C9710E06F;
	Fri, 10 Nov 2023 14:20:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2899D10E06F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5L7PFO1HZWD34MoPd6FNHPXBl6HNmXZuq9gtBrFuyyLO4kJ4NCu9BOT2PHa1hTqHb9dINk5s+x8N1PtOE4hlZmd88ACwWyUZwbXOsInlHaatSEpn8A9lCsIuMiH9mLpKwkV08VfUCPIjX9Rzjer4oWGfgPZfEvMUdd0N/+7hEO8jTC49cUFolwFvFtPhzcZOPmwRl79Pn5hCbSjiKKi0MWRYOHp3mnftu3ssbZ5SD6P++ZJ60sj4WSrnqgXE99mxH7QLQYtNnErIGARnM8V4Ax34wToGNh637yclE8xuFey/fXRrEHeYocdZRt4Sx41ZPxfss5LFUS/Dkv6EL5gHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNojNaqAsdhBR2AzLS4ue6GEaLUldscIeBd+RbWE9pU=;
 b=MgyqUWLvSza6m/PPRjDR6NR60oUqMWlR1AS6zTZuK/nAEGXBbSWZitIVg3XM5tfNQHtYLwWdvE3lOFMFpZ2JRVCIoOPmgIfy394uz86vJoGrre1ZQWGjWWWAu1xMZvpGaiDiMv39TUug6hOPo7DaS52x5Adm6J0rD0UwIK4V91O74Kw5rUnmIaFGJOWroFV3OFMdEinPsj1rH/G/ciTm+ENY0gT1I8avJbTLPtPaOINiADmuz13D+tiTm9sGpnQyUiLqskPaMxDkohQ4VEMASK3C6lA9bfLfQJ56vx6zW8In2PtXjfFBv3F5lNfdqvDkPu9i+9wi/Rrr5J5S7a4pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNojNaqAsdhBR2AzLS4ue6GEaLUldscIeBd+RbWE9pU=;
 b=HWAG4+bFKX05haawv24v2R9gie3nvRa1pZBJaoSPcPh28MdcA+rB+khHmTJeaOmbL9vXW0PazlBwh6ipvEBrLfLWSTDET/3Uc4jhnp++2eR7XZKxd+hN7sVI8K0h9bDILg6hNBGsDUd6B90YcPsJfihqCj3mLsadyRHFadyBI70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 14:20:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:20:54 +0000
Content-Type: multipart/alternative;
 boundary="------------WGbGHKxgb4P0UniPp9pu3d2J"
Message-ID: <64d13d64-d745-47da-99c8-3f941fe52d72@amd.com>
Date: Fri, 10 Nov 2023 15:20:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231110125225.2512174-1-yifan1.zhang@amd.com>
 <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
 <BL1PR12MB51448085CD4ECFAD5D00779DF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB51447D133B187D557131B8B7F7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB51447D133B187D557131B8B7F7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dabb268-3a14-49f9-aac4-08dbe1f83fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odInU9TfaoD/7hrb/LvjSwZwbGtlxdBIbnXyEFiuh/lTm5BzVfpdMAegzcwKilftBuSvdOpb4nb1f7o6Oqwdc0VbMiG1n14spOtTMiqK3qdKVowacfx8BTubVp/szuZfH1QWPduIdLvm3QZOGZgVaYeqiNYu7a+6O1nLSQr7QlVbubk0HSllppUyRm4IG67SVg8LsOd84RF+1jMROPouZJrn9EitLxPEYz4etXOdOh+2WgP9jvmVsQtTE0gddjOoNx5QxKOoeHVzHmSAdMPdyS/dejVxLIR0Q6Gz1LaoPMS+wTC/c0CebQta6quGYo+GFnH4XAenXXIXXbWrsxrj48ZlJRraM1DIfUUBC//QdGI294Do+aLVNyk47ry8SZBhvwVUJQj5glUXzlu2uoqgnaWoM2ip56740dzlFdiZtLk5HuX1gj6uf1te3fRgqIUGbe0K+N4xxSAbmYSJNFvPZXiw2C2/nUKKOhhOPBYkCUqKRxR8sOdwwd/J0zNnK8xBYcaRjN/HqgnCO1iZUAkQjm2eCTYNwQsNtHUXQu8MoSwkvOkm6Y+ZyB/YFVDYSOfbi+6CJH1PNRB/xNuVfTX+r1ylYpAXyfKDNGPeAgxCKQqgdQl+7tPMYOQflXSzKmvMu8tYth8mvxXFU4vU/nUNyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(31686004)(66476007)(110136005)(19627405001)(83380400001)(4326008)(41300700001)(8676002)(8936002)(31696002)(66556008)(66946007)(38100700002)(86362001)(316002)(5660300002)(478600001)(6666004)(6486002)(33964004)(53546011)(6506007)(6512007)(36756003)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk9GRWNKcDBKdTdjTzRGdzBxOG1sbFNBeXNGWFJQaVR1eXFMQ1JDbTd5bDdR?=
 =?utf-8?B?SUwrVWgvd1NqV1dtZldseTJIdG4wWHhPVlV3ZzZ5bGZYYnVmR3ZWY0QvYnZz?=
 =?utf-8?B?azlacHlRa0Q3SngwMlM4SHlmSkxqMkpOYWhINm9kTXZYSUs4VDY3OTJWSTRt?=
 =?utf-8?B?eTZwNThnY21BQ3kvam41d1lXOGV1QVFjRHlCZlIzYzhSVnBIQWhBQjduWW8v?=
 =?utf-8?B?TThNRkp2ZVFYSVQxL3Z5OUZFVkNvRlZVZklPcWRIcHhFY2lhTGJHSGVhaEh3?=
 =?utf-8?B?a01DWUdmSjMwZyt5KzNzaTFabUNLaEpIUVkya2RVQ2RYdklyYzdoZDgwbVdr?=
 =?utf-8?B?QnpmWjE0dGk4RXNMY1JjSk9jRDAvSzQ5OUhsYnJjbkhCZ0RXYXJtSUlVaUFa?=
 =?utf-8?B?QTdITHNZV2lMRjlLakRrQWxVN0dLZEl2VHp0TEJHcXkxd0kyNHRIdVBabmpE?=
 =?utf-8?B?NmhwTDR3NHFQTitQUHlEb3AwcjY1alkxTmZoVFpXU0dIZzdUOG4zb0ZkVjF6?=
 =?utf-8?B?Z1NXbmtoRnJtQlNTSWU3R2pEa1JqMkxZZEM2R055U01IbkVQTmxSS25KYnlX?=
 =?utf-8?B?bXoxM09HV2QyV1JDMytVMjhuWG1YUzQxVFdUaDVMVWJ3Y1pqekY1RmtONWJj?=
 =?utf-8?B?KzMyc3I1N3gxcHRpSEdFR1JoM1JNVGVxSEg0bVNSMTI3SE5YOFBjRUNoUFor?=
 =?utf-8?B?OHFzcXE4RkxjUkN4UUVZTTlrWnlPK1JUWlJBMkxqc08zdGFSbmFjQURRSTQ4?=
 =?utf-8?B?d3RCVUtEWStZOG9RN3pybTlhaGo4eE5zQUdHQXNHblE5dHBwc01qSWptcTBs?=
 =?utf-8?B?TUNFRDNTNzkyU1BQUGRweW9PMUNJZVoxTWRqcndOQ3VsQXM0dHd6aVFuSUF5?=
 =?utf-8?B?clFaMkkyU0swUTJ5YzNDRDlyTW5iSXN6U0dNZjRmUHpGaEJUbGcrbDBkUzBU?=
 =?utf-8?B?OEhWYVlacUJJeHQ2c210QmxZQlJCTEFQS1ptTUJBa2UxNkcvMCtKamxoTXk3?=
 =?utf-8?B?M1BHV2ZiTXAwdmc5blRTN1UxbndhS0l5QURhaE9yNXN1cXlmUDcxY1B6b09K?=
 =?utf-8?B?Q2xQOXkrTTlLZC9NTEpwOUZFSFZCeVhPeGNFWllxYTlaZE00eDRYREF1cjVL?=
 =?utf-8?B?SG5rQys5WWZkb3NOSkE2eFZ2eTlOV3ZOUEt0eG1RVWdwVmRua1kwemtHMTcy?=
 =?utf-8?B?SUdJWHRDSW9pYkR4ekpUS0RndUprOWVjelExZW5kZW5CWW81bTR6aTBoUVZw?=
 =?utf-8?B?TlF6ZUVGTUxkbW9wczBRcjZWUDZGdzlFSmNpb002aTU2MW9VR1pnTExpQkZK?=
 =?utf-8?B?N0hsOHVueUVYS0NMVEtFVWFOS2tlUW1hc3dYaFowTDJXM0U0WlcyR1ZWWmV0?=
 =?utf-8?B?cDV3bEdtVWw4U1hMQkR0bURtNm1ET0hZbUVLOVhJcnd4UE9EcmtMR3AycHVD?=
 =?utf-8?B?aXAvUFFSZ0NwR08zRUdqQkdNY0pKaVhnMTlFbmFXYWNPRFFuZmNZeVBzcVlM?=
 =?utf-8?B?aXBpUUtJN2NyRldTc2RnZ3p4UnZJQ1U4UVliVjdJS3ZsbWdoNTNmbm9RS2lq?=
 =?utf-8?B?V2czbytsZnIxdVBkOWZURnkrWWc5K0RkZUVnYXR1U0svOFp6c2dOeDJhYnFN?=
 =?utf-8?B?NUdRSnZtTlJuZ2RYZFVHYlRmTGsvcjN4ZVgrYTJ1TlJlMFIrWW5wOGRNVzIr?=
 =?utf-8?B?blJCRGlMRHZXZEVaSEhKTGZibisra1d0cmJTTFJVU1FBTHl1WkIyNFVRdWJv?=
 =?utf-8?B?TUVjTENZR0F5VzFQNWd3aU5tRjRydGsxZjRxaWtaS0d2c3g5aTYxOHgxQStT?=
 =?utf-8?B?a2Qrdjh3TVJxTWI4bTFiNlVSOFN4NmRSSDhQYXk3TVkyMzVoSnRnQVYyVVdp?=
 =?utf-8?B?WDdWUk03bWRKSGZpWHE1UHdUOXhabzBHVUNmZlBhK0N4SWtMQ3hldXJ6RHhY?=
 =?utf-8?B?YnFSUGRFMGNDckZ3TjVPN2hUVGlTTmJSYlU3Y0ZQWVlYbjUxa29tZ3FCczdL?=
 =?utf-8?B?VjFPZUNXRTB6NVZBd0h5NHdEd09CK3hnUVJEblZpSFYyWGRlVlBwWUtvbnl2?=
 =?utf-8?B?NHVzVE1lQUxwUXRQNENyeGt3L05tYmN0MkM2TVg2d2VwNE5QN293alRWcFdh?=
 =?utf-8?Q?zCjpa/4OfPSppLjFjemAkF481?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dabb268-3a14-49f9-aac4-08dbe1f83fa2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:20:54.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TTmQDUjFRxM3H7F4+Dv+wHnhaLIpLJ4ujsRUqNYMzNyI1JsQl54kZQJUWuJvbpZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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
Cc: "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------WGbGHKxgb4P0UniPp9pu3d2J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

No, that's broken as well.

The problem is in amdgpu_ttm_alloc_gart():

         if (addr != AMDGPU_BO_INVALID_OFFSET) {
                 bo->resource->start = addr >> PAGE_SHIFT;
                 return 0;
         }

bo->resource->start is relative to the GART address, so we can't assign 
the AGP address here in the first place.

What we need to do is to drop this and call amdgpu_gmc_agp_addr() 
fromamdgpu_bo_gpu_offset_no_check().

Regards,
Christian.

Am 10.11.23 um 15:17 schrieb Deucher, Alexander:
>
> [Public]
>
>
> I think the proper fix is probably to just drop the addition of 
> agp_start in amdgpu_gmc_agp_addr().
>
> Alex
> ------------------------------------------------------------------------
> *From:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Friday, November 10, 2023 9:16 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan 
> <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: exclude domain start when calucales 
> offset for AGP aperture BOs
> It happens in amdgpu_gmc_agp_addr() which is called from 
> amdgpu_ttm_alloc_gart().
>
> Alex
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, November 10, 2023 9:14 AM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, 
> Jesse(Jie) <Jesse.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: exclude domain start when calucales 
> offset for AGP aperture BOs
> Am 10.11.23 um 13:52 schrieb Yifan Zhang:
> > For BOs in AGP aperture, tbo.resource->start includes AGP aperture 
> start.
>
>
> Well big NAK to that. tbo.resource->start should never ever include the
> AGP aperture start in the first place.
>
> How did that happen?
>
> Regards,
> Christian.
>
> > Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated 
> due to
> > GART aperture start was 0 until this patch ("a013c94d5aca 
> drm/amdgpu/gmc11:
> > set gart placement GC11") changes GART start to a non-zero value.
> >
> > Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--
> >   3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 5f71414190e9..00e940eb69ab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
> *adev, void *cpu_pt_addr,
> >        return 0;
> >   }
> >
> > +bool bo_in_agp_aperture(struct amdgpu_bo *bo)
> > +{
> > +     struct ttm_buffer_object *tbo = &(bo->tbo);
> > +     struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> > +
> > +     return (tbo->resource->start << PAGE_SHIFT) > adev->gmc.agp_start;
> > +}
> >   /**
> >    * amdgpu_gmc_agp_addr - return the address in the AGP address space
> >    *
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > index e699d1ca8deb..448dc08e83de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
> *adev, void *cpu_pt_addr,
> >                                uint64_t flags);
> >   uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
> >   uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
> > +bool bo_in_agp_aperture(struct amdgpu_bo *bo);
> >   void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct 
> amdgpu_gmc *mc);
> >   void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct 
> amdgpu_gmc *mc,
> >                              u64 base);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index cef920a93924..91a011d63ab4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -39,6 +39,7 @@
> >   #include "amdgpu.h"
> >   #include "amdgpu_trace.h"
> >   #include "amdgpu_amdkfd.h"
> > +#include "amdgpu_gmc.h"
> >
> >   /**
> >    * DOC: amdgpu_object
> > @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct 
> amdgpu_bo *bo)
> >        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> >        uint64_t offset;
> >
> > -     offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> > -              amdgpu_ttm_domain_start(adev, 
> bo->tbo.resource->mem_type);
> > +     /* tbo.resource->start includes agp_start for AGP BOs */
> > +     if (bo_in_agp_aperture(bo)) {
> > +             offset = (bo->tbo.resource->start << PAGE_SHIFT);
> > +     } else {
> > +             offset = (bo->tbo.resource->start << PAGE_SHIFT) +
> > + amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> > +     }
> >
> >        return amdgpu_gmc_sign_extend(offset);
> >   }
>

--------------WGbGHKxgb4P0UniPp9pu3d2J
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    No, that's broken as well.<br>
    <br>
    The problem is in amdgpu_ttm_alloc_gart<span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">():<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr != AMDGPU_BO_INVALID_OFFSET) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;resource-&gt;start = addr &gt;&gt;
      PAGE_SHIFT;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
      <br>
      bo-&gt;resource-&gt;start is relative to the GART address, so we
      can't assign the AGP address here in the first place.<br>
      <br>
      What we need to do is to drop this and call&nbsp;</span><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">amdgpu_gmc_agp_addr()
      from</span><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">
      amdgpu_bo_gpu_offset_no_check().<br>
      <br>
      Regards,<br>
      Christian.<br>
    </span><br>
    <div class="moz-cite-prefix">Am 10.11.23 um 15:17 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB51447D133B187D557131B8B7F7AEA@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">I
            think the proper fix is probably to just drop the addition
            of agp_start in amdgpu_gmc_agp_addr().</span></div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);"><br>
          </span></div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Alex</span></div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, November 10, 2023 9:16 AM<br>
            <b>To:</b> Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Yifan
            <a class="moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com">&lt;Yifan1.Zhang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Zhang, Jesse(Jie) <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start
            when calucales offset for AGP aperture BOs</font>
          <div>&nbsp;</div>
        </div>
        <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
        <div dir="ltr">
          <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
            It happens in amdgpu_gmc_agp_addr() which is called from
            amdgpu_ttm_alloc_gart().</div>
          <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
            <br>
          </div>
          <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
            Alex</div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
              <b>Sent:</b> Friday, November 10, 2023 9:14 AM<br>
              <b>To:</b> Zhang, Yifan <a class="moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com">&lt;Yifan1.Zhang@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Cc:</b> Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhang, Jesse(Jie)
              <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain
              start when calucales offset for AGP aperture BOs</font>
            <div>&nbsp;</div>
          </div>
          <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                <div class="x_PlainText">Am 10.11.23 um 13:52 schrieb
                  Yifan Zhang:<br>
                  &gt; For BOs in AGP aperture, tbo.resource-&gt;start
                  includes AGP aperture start.<br>
                  <br>
                  <br>
                  Well big NAK to that. tbo.resource-&gt;start should
                  never ever include the <br>
                  AGP aperture start in the first place.<br>
                  <br>
                  How did that happen?<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  &gt; Don't add it again in amdgpu_bo_gpu_offset. This
                  issue was mitigated due to<br>
                  &gt; GART aperture start was 0 until this patch
                  (&quot;a013c94d5aca drm/amdgpu/gmc11:<br>
                  &gt; set gart placement GC11&quot;) changes GART start to a
                  non-zero value.<br>
                  &gt;<br>
                  &gt; Reported-by: Jesse Zhang
                  <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a><br>
                  &gt; Signed-off-by: Yifan Zhang
                  <a class="moz-txt-link-rfc2396E" href="mailto:yifan1.zhang@amd.com">&lt;yifan1.zhang@amd.com&gt;</a><br>
                  &gt; ---<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; |&nbsp; 7
                  +++++++<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp; 1
                  +<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10
                  ++++++++--<br>
                  &gt;&nbsp;&nbsp; 3 files changed, 16 insertions(+), 2
                  deletions(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
                  &gt; index 5f71414190e9..00e940eb69ab 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
                  &gt; @@ -169,6 +169,13 @@ int
                  amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev,
                  void *cpu_pt_addr,<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                  &gt;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt; +bool bo_in_agp_aperture(struct amdgpu_bo *bo)<br>
                  &gt; +{<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo =
                  &amp;(bo-&gt;tbo);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                  amdgpu_ttm_adev(tbo-&gt;bdev);<br>
                  &gt; +<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (tbo-&gt;resource-&gt;start &lt;&lt;
                  PAGE_SHIFT) &gt; adev-&gt;gmc.agp_start;<br>
                  &gt; +}<br>
                  &gt;&nbsp;&nbsp; /**<br>
                  &gt;&nbsp;&nbsp;&nbsp; * amdgpu_gmc_agp_addr - return the address in
                  the AGP address space<br>
                  &gt;&nbsp;&nbsp;&nbsp; *<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                  &gt; index e699d1ca8deb..448dc08e83de 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                  &gt; @@ -393,6 +393,7 @@ int
                  amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev,
                  void *cpu_pt_addr,<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags);<br>
                  &gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo
                  *bo);<br>
                  &gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_agp_addr(struct
                  ttm_buffer_object *bo);<br>
                  &gt; +bool bo_in_agp_aperture(struct amdgpu_bo *bo);<br>
                  &gt;&nbsp;&nbsp; void amdgpu_gmc_sysvm_location(struct
                  amdgpu_device *adev, struct amdgpu_gmc *mc);<br>
                  &gt;&nbsp;&nbsp; void amdgpu_gmc_vram_location(struct
                  amdgpu_device *adev, struct amdgpu_gmc *mc,<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base);<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                  &gt; index cef920a93924..91a011d63ab4 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                  &gt; @@ -39,6 +39,7 @@<br>
                  &gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
                  &gt;&nbsp;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
                  &gt;&nbsp;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
                  &gt; +#include &quot;amdgpu_gmc.h&quot;<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt;&nbsp;&nbsp; /**<br>
                  &gt;&nbsp;&nbsp;&nbsp; * DOC: amdgpu_object<br>
                  &gt; @@ -1529,8 +1530,13 @@ u64
                  amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                  amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp; offset = (bo-&gt;tbo.resource-&gt;start
                  &lt;&lt; PAGE_SHIFT) +<br>
                  &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_domain_start(adev,
                  bo-&gt;tbo.resource-&gt;mem_type);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* tbo.resource-&gt;start includes
                  agp_start for AGP BOs */<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bo_in_agp_aperture(bo)) {<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =
                  (bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =
                  (bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT) +<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  amdgpu_ttm_domain_start(adev,
                  bo-&gt;tbo.resource-&gt;mem_type);<br>
                  &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                  &gt;&nbsp;&nbsp; <br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_gmc_sign_extend(offset);<br>
                  &gt;&nbsp;&nbsp; }<br>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------WGbGHKxgb4P0UniPp9pu3d2J--
