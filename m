Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184EBC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 17:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A929C10E0AA;
	Fri, 18 Aug 2023 17:01:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0351110E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 17:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe4QkdsWs/A2rV0QcmJXVcC1E8GfN5UhRhK+4VroOVU0nyfVIUR6F6hTpgaw1mqLPtTbxvDSyq79ARQk+q1lSgkPA3FWlpfqH0hjvM5nt83M4/IudbVDRRp+mIVQSSTfrIL7U9MwGzrmINqJ5RsihFqx2Yb1x0qCe40ZofXGLms4sSDXHz0MMte4rh2U2Od0S1yB7HUSwbj4XS531eSEc5FWQ8++9v1n2RX3aKwgBb6y9i+4BsJA3dtpRB4X0tk8kYRtPEVNTixnT9nBKCiPxtYsgMRlWP++FwvnoQzMyqNW3Mx87qwrD3ZteYszf0FShesCybQoqGxJFXM76ywFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cAYFkHOJN5suJD9gRmZEAR4d/6k8HPnhixkzmKZvXg=;
 b=Z2zVVqeNsM1wBqFhUa9pyK+atbLmVnCZzBsQsAAAm4GNwpLOQoIz/aHSBgJB3Fm9487NptKC0ungk5BsNGG082EZgBUTgBjvuLLv216YUuQTyU4z69TbhEgTt8o5BeKREybg0X9JnkdJ1KpykIfrtBvzBh5wW8mTveW6fn4xnT+sEe/6RY4Hhx/65xOyVGcb462zItfLrqB7Vgf0MkZ/e7MuHkIZvMCLoKc5tCqQVql39Sr+V1vSj+iPcz0Xq0RiLeNUi/eOC4Z9Jx3QrwTDOorH2aUOiHcU02eW20uVPvDrseFG3s7t+yrn6u8Fef8xi068RfqktBYxEGKA/CkAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cAYFkHOJN5suJD9gRmZEAR4d/6k8HPnhixkzmKZvXg=;
 b=QfXvzclOLtO1hxdoZGoqHP2LsXZzXP2eDVycHayL6NGh9Syu03Ll+DzWOcxpDcB3QCL8lPvaJduwY3S134vtW2SVRMbwObpY3p2qXhSsxbpaJ8qsIL8W6K+ubVfmEk0OtyDLKcPqnAQcvQokdv1QJ7R3Kg3DP/boo42y9Wuk3RI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 17:01:26 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::d2ca:d59e:71fc:309c]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::d2ca:d59e:71fc:309c%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 17:01:26 +0000
Message-ID: <d173a412-d43e-4a5d-a0f8-e2a0c3eb719b@amd.com>
Date: Fri, 18 Aug 2023 13:01:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] Revert "drm/amd/display: Implement zpos property"
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
 <20230726193155.2525270-7-aurabindo.pillai@amd.com>
 <20230818082558.y6no2dvvmzszelc7@mail.igalia.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230818082558.y6no2dvvmzszelc7@mail.igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0846.namprd03.prod.outlook.com
 (2603:10b6:408:13d::11) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DM6PR12MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f28262b-e351-4a79-58b1-08dba00cc264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6s5F0fNDzUrptJW/66FaI5vh9+lAOO+9UeNuMEzOcQWsD+8YXqUo69ahjAteHge9Mv6maB7ZFLGMpy1Y1uv8RB2te2BcR67KgW+h5Ai/73G/1wTheTmz0UjR0XIsmR24Xwl2bpjWyHbk3qvBvnpUyLLOpL/UGntt+V4g1SEf9xu8DhOCiKsVC2f72pg5LYAqiQwjmHGWRtTrbQZUqDiSItZNvI9hX1cHhNTSw5DYAnjLjqSUdiZHUfTlQdbVMiWRsmgWffj/+A+8E1oZG6uE1vBWDLdRZTi9osFnhCN7VWPdYBVcMJcZ3iYDhzRBYoRAzIeHnkraai/ECc8iV3ah8pYg/6dbYlZgDaL6Tmf+7ZjiM+Nnh8glXPidC3o7hPAIGMs/g1BPBg8vpddFto/MaWymR4nV7Zq39PGRvXRIpkfphBi4+gMmuw9gDUu6LQEVFGoBu+MwUn9WRNTPcOFazE90ZA1eqRzvmGpIUbHQGBydJ23kxizYjb4g98bDZGhNYzdNylz1mLbCAtq8pgUR+Yd22O5FWvy0WSR9EUaWJgCDFGKHVqX8vC5L7bM1C2ckGoPAjQKdA2VZFjhDJQNipJCDmlmC80g4HP3V/r3QHHOLJpUTZ4yZgMPSnyoQjX/nCSQzdOPNbraYUKpZjf78Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(36756003)(86362001)(31696002)(31686004)(316002)(66476007)(66946007)(6636002)(66556008)(54906003)(478600001)(110136005)(41300700001)(38100700002)(6486002)(6666004)(26005)(6506007)(6512007)(53546011)(2616005)(8676002)(4326008)(5660300002)(8936002)(2906002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0h1ekY3WnNLbHZZTlZQS1JlbUsxaHlHdmYrNlRqWHNGclU4WkNsU0htQitQ?=
 =?utf-8?B?ZnlFdWpRc0U1d21LYzYvMkFscnN4T1k1OUZJQ29QemJzemlscXFQbWU5eGxM?=
 =?utf-8?B?ODBNYWlFK21odysrQXlwTjg2YjdoVWZKdUZqRlI1WUJvWnlRL0tQdWwyQUxP?=
 =?utf-8?B?SUdyRVhVM0cxTkFQUEFJZnhlUWhjdmJjWkRVRGVqbThjYmFkSmsxb0syK2FR?=
 =?utf-8?B?S2dWemxWdUphUkVaTXNiZXFSajU4RWFFZTZqb0t0VGNnb01CUk1LeDVkeEdt?=
 =?utf-8?B?RWRCbUdlVFJxWlBEWDNjT203YmhBUkNsR3V2bVlsL0VMZzdRZkRtRllJbG85?=
 =?utf-8?B?TUdYOGh0OTNzbkdaakRhYXNVM2MxZXcvellSY2tyQ0VEeEw1SVVpbXlTVHIv?=
 =?utf-8?B?eVV6VUJSc2ZQdGpUd0tsOVI0ZTg1TFg0YlJ0MGlOcmxxVnl3L0NQQ21xTjVL?=
 =?utf-8?B?NDR5MmNKK25IN3h1Y2I4YSthTWt5TTlEbHZtUURyc0Z1VGlBbG1hdzFZY3Jk?=
 =?utf-8?B?K0h0R0ZYUHVuSzcrby9MU0dDenM1eWdSdCt6ZEtDaUZyRkJZY0ZiVHk5UCt1?=
 =?utf-8?B?U05rYXVOYWM5b3hKMTFGdEprK00ySEtYNzRTVWVtcFJIdWw1MUVZYlJZZEUr?=
 =?utf-8?B?OHRFTnBZVzFxVHhpWVVrQ1RjaUd6U0dKaXdpSkYvcVpCMGhrV21lSE42ZEh4?=
 =?utf-8?B?SzlBSHRod0VWQ0RGakpLa3R6TytVZDlKR25GTUp0VnFEcy9DQUdYNEJ3Rzcv?=
 =?utf-8?B?cjFsZXFWSEFiMHdORGtHbisvSnBiSjRkTFpicWJaaG1PLzQ4NWxndTN5ck1z?=
 =?utf-8?B?UWNmWHEyWDlBaUx6b0ZLaXhrc2t3aEhuM2w0M0JYNDVIUTkzcUhHVnVxVFN1?=
 =?utf-8?B?clFCeDZOOHBsM1ZHYnFvMEZ6Z3UyRktDRExRVnd1NVhpMXVzdS9JVExlaGVL?=
 =?utf-8?B?REI4ZUFjenl2WFFnS3ZEMytpd2xTTm1QNnVJZTYreEtZYlNZeHRsNmp4aFJv?=
 =?utf-8?B?TW5XNVhWaVRueEYzYzl3UGxGMk9lQjNMSERSSG1ZYXJTRXFobGJYbnpIcGx2?=
 =?utf-8?B?QWtNQ2ZiKzg3VHN3MUpnMERldWhaRVV0TGJPSVRWV1M0L0RRY3FFVDAxTG1M?=
 =?utf-8?B?bXZXcC8vTkl3bDlxcFN0RWE1MFhaaUxVemZDSElyRzlaNG9KTGZXc3hOcnFM?=
 =?utf-8?B?UDFaZVBNaTkrcjJWN1lScXRwOE4rQ2ovOVdaUFdXK0psNlJqNHVaSHlsOVhF?=
 =?utf-8?B?OC9HRDRMN3ZBUE1CM016VVQ4a3hCV056NmFra1RCQmUzcG9GeGhpcFpFTEhF?=
 =?utf-8?B?S0UrSU5SVjVrMk9CTHVYeEpXbGQrUUY2ZE01UC9talcrVWh1NjlVNzN5cnZy?=
 =?utf-8?B?cUNNZy9POUNjQVpYWHB0ckJydzZPdjE0Z1JDZTJNK3p0ZGdBUjJtNkdVM2U2?=
 =?utf-8?B?NHJEbmQyN05QdGh1WFZxVTFFVFdIWEg0b0REQkllTDFqL2ZQQTRrbXBWU3Nn?=
 =?utf-8?B?MVVGem1oSnQzZkc3WDcxMHUyaExNZ2dVaHp3d3Z5U3BaNkpTZlk2N0FmVjJh?=
 =?utf-8?B?VUV4dVVjTkd3NUJDT0t1VE0rajRXS3RsaFRiRk4vVjBpVXJTellGZTN5Y0tT?=
 =?utf-8?B?czNNSmRiUDZIQXhaOEtSZ1Y5dHEyZjhTcVp1Nnk2T2QxMlBCb2lqcmtXeFJS?=
 =?utf-8?B?b1l5WXEyYjFzSHhQQmZGM0xJVndHN0hZQi8zN0hEWldaR3p3UXJCWlRIcVA0?=
 =?utf-8?B?MEVkUHA5WVdObmJKODM2bXdxR2xldEtRQ05uN3BDSGJVd0xRV21pNXV1d3p2?=
 =?utf-8?B?eExHcEJJUWxtcldBT3dPSUhkYnNsVTZKd2tMNUNVc1hhdEQ5anBMeVozc01U?=
 =?utf-8?B?UlV4eG1DYWhNdjJZN25NOEpqZ2RTN2NJQ2M3TDVkMmUzUHBqWTRSdThJckF1?=
 =?utf-8?B?K3hYT3FzMWh4aXdzaEM1UWZQZnVHYUZ5ZktJYlFDWUJDS1huMGdDQ05EL2Ey?=
 =?utf-8?B?R0c2Q1VLVkl4MGxGMFNnVGNGTWtudysrMjBkUUsvL3dFalNEQ3pSMmpvTDlj?=
 =?utf-8?B?UzF2NTdFOUE2aVNHak4rTUsrZWpOdytaZnkzN0grSGp0NXBibGswYnJZZFQz?=
 =?utf-8?Q?5fYHOf5/154OvKjkMDXrIB2dT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f28262b-e351-4a79-58b1-08dba00cc264
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:01:26.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4szoACZNaxl/swjtFPWsFoRuoj9eUIzScHbcUaTPenUHSkQoehxnLU09cItYpKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
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
Cc: stylon.wang@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Nicholas Choi <Nicholas.Choi@amd.com>,
 agustin.gutierrez@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Joshua Ashton <joshua@froggi.es>, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-08-18 04:25, Melissa Wen wrote:
> On 07/26, Aurabindo Pillai wrote:
>> This reverts commit 6c8ff1683d30024c8cff137d30b740a405cc084e.
>>
>> This patch causes IGT test case 'kms_atomic@plane-immutable-zpos' to
>> fail on AMDGPU hardware.
>>
>> Cc: Joshua Ashton <joshua@froggi.es>
>> Signed-off-by: Nicholas Choi <Nicholas.Choi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 2198df96ed6f..8eeca160d434 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -1468,15 +1468,6 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>   		drm_plane_create_blend_mode_property(plane, blend_caps);
>>   	}
>>   
>> -	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
>> -		drm_plane_create_zpos_immutable_property(plane, 0);
>> -	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
>> -		unsigned int zpos = 1 + drm_plane_index(plane);
>> -		drm_plane_create_zpos_property(plane, zpos, 1, 254);
>> -	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
>> -		drm_plane_create_zpos_immutable_property(plane, 255);
>> -	}
> 
> Hi Jay and Nicholas,
> 
> I'm examining this regression and, looking at the test code, I consider
> this failure is caused by an incorrect assumption in the IGT test in
> which any zpos values must be in the normalized range of 0 and N planes
> per CRTC.
> 
> 	for (int k = 0; k < n_planes; k++) {
> 		int zpos;
> 		igt_plane_t *temp;
> 
> 		temp = &display->pipes[pipe->pipe].planes[k];
> 
> 		if (!igt_plane_has_prop(temp, IGT_PLANE_ZPOS))
> 			continue;
> 
> 		zpos = igt_plane_get_prop(temp, IGT_PLANE_ZPOS);
> 
> 		igt_assert_lt(zpos, n_planes);  // test case fails here
> 
> 		plane_ptr[zpos] = temp;
> 	}
> 
> 
> I didn't find anything in the DRM documentation that imposes this
> behavior. Also, the plane composition in the test is working correctly
> with this patch and without this likely-misleading assert. In addition,
> enabling zpos property increases the coverage of
> `kms_atomic@plane-immutable-zpos` test (previously this part of the test
> was just bypassed), so it's not a regression per se. Therefore, I'm
> inclined to send a fix to IGT, instead of implementing a behavior that
> fit the test but may not fit well AMD display machinery.
> 
> But first I wonder if you guys find any other test or visual check that
> fail with this feature?
> 
> I checked other IGT KMS plane tests and AMD MPO tests (in `amd_plane`)
> and results are preserved. If there are no other issues besides IGT
> plane-immutable-zpos, I'll proceed with sending the change to IGT.
> 
> Thanks,
> 
> Melissa

Hi Melissa,

Thanks for taking a look at the IGT test. Looks like the IGT failures
are the only concerns, and I agree that it doesn't make sense to require
zpos to be normalized between 0 and number of planes.

Thanks,
Leo

> 
>> -
>>   	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
>>   	    plane_cap &&
>>   	    (plane_cap->pixel_format_support.nv12 ||
>> -- 
>> 2.41.0
>>
