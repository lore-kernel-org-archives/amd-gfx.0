Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBA8C47DA9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 21:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7D9112B3D;
	Mon, 29 Jan 2024 21:15:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611DE112B3D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 21:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZCdzRL3wSrBgqBFACSXdYSQ+HMRLO+dMzFJZPSt7CnSSsek7/ecqCiVsbnpemyrtenvQErvTw9XTi6kOiO6SM99SHlnI7qBrQJBsrqiKneV0YHxPuj8JMgcZ2rpnQ7PxcXKjaE3cVKiQz0tVe/1QknFNz106PoO1nI+szAg7E+nfJitSCaIF6/v8NYFAVs8CvLVCGs5UjZea7YFar/CCfL1yGq4MpK8QkDd/HdLuTyoihF9jrDMEHYdprgHPjD1d3dbVd6Gj9TNsiSikIu80prHMLiHGw4a8TccR27T5+Gqlo2cIPLkUAqorOA7SoZ3VqXx619lcKT3Jq1u+knnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU6eyaaNYysF/5+O23Av8FkviBKkKlNjKOwudECNv68=;
 b=V+gkbFZXYeUEb1IcY5ld9gd19d8r5zpTdRrp0onIP9CvZ8HxbgcFBUFUNwmXvOcwN5KdrpJPYO/wmWtf94Uv6Ak6mxHVLB/UT02pqvIicXnVDVg7ueyRvFc3St6Dv6gDFdIIFqGdhFFDmF/waH7hAiKSUNl5iBPGAIa6Zdoh14bML8nIJ1RSVNju5HX9KEkJGW940DJfRhi+rw9BMjkeHcNHPLo1SWcOIKF76Xm4PalhE/lLzwtSQ5ScUasb4rxAPCmVkJhZXrXtKjotuJ3fgCT9S3F0P8vgnSV5R9aVfsZk4jyxjchVb6/l4cLr3CB4FMW+IbNvogWAty43jwx18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU6eyaaNYysF/5+O23Av8FkviBKkKlNjKOwudECNv68=;
 b=E7xxfEpUXiVpAUyFLQNBuG7EN45QZg4h+TayGDI7pl6OXE+66YDbTFb8bPsQqm2ZsGFnvCOA+1Sp8Of9jCQqQBEI2VvVA2dj+hLvydeaiBECRmiO4QKInPB/OJHrNS3zzQ5imNVd16QZ/lWPbhFy8HHyCOrwik7bpyP0iAv3ojc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 21:15:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:15:21 +0000
Message-ID: <8bda643f-314d-4947-83a4-8ad536dfdc41@amd.com>
Date: Mon, 29 Jan 2024 15:15:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd: Don't init MEC2 firmware when it fails to
 load
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: David McFarland <corngood@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20240128161803.1224103-1-corngood@gmail.com>
 <20240128161803.1224103-2-corngood@gmail.com>
 <bd7b16fb-987f-416c-a454-c424b95ed07a@amd.com>
In-Reply-To: <bd7b16fb-987f-416c-a454-c424b95ed07a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: c0550307-3e8a-43c9-c3c3-08dc210f66ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEH2rCrzKPqj5v074hZfaJybawoH/xB3n2rDQ5CjnnVYLO4qtkzMQdcmBGWXH/jcTYafMvrpzyDwzzZm12xpPPTr0pQETg0EL3C0UYumnZZEq8Judb8lI7XAazM6GYhwWJUG0CZNGxeTyYUU53sRhMV9JbrZrE71EzyCIGljqNRmQH1N82nEqZGoIHE7CtodABNNJA5tVVeikn+bdq5DFeq9N+ryyPTb0No3nLJu58/CIYJyvYLXnTsQ65HX6ytmvnM1WJs8F/+HkymorFCzbzGzIY/aBRpm2QC7zfs2mkmF9Nyeqc+wbcxQBJ+FDxsiCAj5UdfelmrT901uO3cLZHToXR6AzJwC6Iq9DOnc89Q3VBW7xQnrhj31r0R4Hni/Wwvq6dSRbJBQUO4zbjClA94GOKif3T8icQki9PHxKDxR+BbxVqo+6T3gajimIbKEDuDxiwrdYXWNgBArgp8zKbYnamLoZlJLK6R1sycNB/DZHWu5BoSyRqxybjUjqDG4DClNm8iZzKzXQpX6lFXG31DYNMVQWjuN3F5//N3xRPqZhJ16NC2NGpDTXVoDO4iJpssUXZ/OYOO8b/YRThF/EtJDZCWa3F5fQ8hnRRTzEKElJsjEU8plmd18Rc//ASaRqGLSgXGTv0ceSuwDe1kEQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(38100700002)(66556008)(66476007)(66946007)(316002)(31696002)(86362001)(36756003)(41300700001)(2906002)(44832011)(5660300002)(83380400001)(31686004)(6512007)(6506007)(53546011)(26005)(6486002)(478600001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZDZVFMamJWbHJWR05hV3IwWEY5ZjI0U2N6cDNONytXcXFQSkNEYmZ4L0M1?=
 =?utf-8?B?UTM4S1JlUGRPbFdXeWJPK0pvNmpJQWdHbEYzVmtwN2k4ZUQ0VXpFV202WGU3?=
 =?utf-8?B?dkJ3L1dTdThJVDdaQVRleXNIV0pGZ3VEdlI5NE5nUWNIRGhXbkwzUGYrQTdm?=
 =?utf-8?B?T1ZxQVFaL25qUWhXQmVYdUIwWkNKaDdNV2RhREQ1Ukhmak15eDB1ZFlsLzJ2?=
 =?utf-8?B?ZEFqVW5nY1RYUGVhMmo4RTJxWlZCL2IwYjcycXdVVlhjMERKWi9GWmxOc3lq?=
 =?utf-8?B?WXBFQS9yamp3cVpXeDc3ZU82SmZaUWszYVplaGxkbWhxR2xPbWdDaFRndUxu?=
 =?utf-8?B?R3FjVjYzWlQ0MHRWTmRHU2NHZG9wa1grYjU5bWNLbUpkYVkxOVJhMHdldWlm?=
 =?utf-8?B?b1NYVUFhNy9RSnZSdWRYM2tUOU5vR2F5NlBaVzl0QWxCdnFlQXNnS0lWd2R1?=
 =?utf-8?B?dW5BZ1Y4Ung1OTJjc25yNnpmcEs2MVNsOUZpdE40elFIWnJibFE5T0k1UmNH?=
 =?utf-8?B?NmtyVG1qYzZPN05ITHNidDRxMWxLK3k4MUo2cWh4SkljdnFqVzd1Z1FFTU5E?=
 =?utf-8?B?eFVpcTBPd3FjMnh0ZklqdjdNd2djWHZsN2FzZ0R6R3JrcTM0US9IVlpyMnZw?=
 =?utf-8?B?a050dVp2Y0FvUWdncnRCRmg2SGJ2TDc3Ry9yMFRnaEhWbkdaWndkaXpXTVNP?=
 =?utf-8?B?dWh5R2txYXdYdWtIUnc2VmltK3kxSGFwazBpOWVqYnJ6RXMrSjJpaFdOOFhp?=
 =?utf-8?B?aUhQMjdWZ0RwdmgrMVdTdmVEbmpvZjdEMCtLKzhDcXdDMXNYQm5jaGZMWlBY?=
 =?utf-8?B?YXVoR0FpVUtpbURDZk9JTU1KVVcxUGJNajFCWXBCdWVuQ2dlQnZ1RXI3a1o3?=
 =?utf-8?B?L2VtUE1UUHdQdUlsall3QzliNFhIa3FaTXVwMkNSZVpaMWp2bE1RaFEzZi9T?=
 =?utf-8?B?WmhyOHEwRmc1T0h1UEhnZ01XbkRmM1FrSG8zZHg1ZGRpUzZ5YllYVjd1Zzh5?=
 =?utf-8?B?UkJGZGxMY01TK084YTFmMEIwK0YvSHBBZWY2eHVsUTV4Q2tpS2pMRGZrWjBV?=
 =?utf-8?B?TS9jL0d2VkJaQTIzRXV5ZXM0ZVlTc1RwdFlwNlZjVWliZ282cUVER3FyKzli?=
 =?utf-8?B?bFNmbC91dTkzVXdwNWxNcFdoVWFGODFmUHlDMEk1OXZIM2hNbzljUkZKRC95?=
 =?utf-8?B?S0NCSno2UHlDdVBXYkI5d0RqT0ZRTEI3VXpMc2U5SzM3SGxybGozcEExbTN5?=
 =?utf-8?B?OThPUGN4b0h3NkFNTG1NbXZTbE8vMnIrV3BrSi9NNU1pY05Ybi85cURNNkI0?=
 =?utf-8?B?VDdWc0NFdjN4NGIxREtLbDR3ZUZhVmdLOHdGN1lYL3R6bkQyclo3K2REcmZS?=
 =?utf-8?B?ckhieDJLQmZzaWhDcFBGU3NHUnNMTVYrMzg1S2piY3Z6NGV5TEhvR0c2UDNv?=
 =?utf-8?B?VEo4RnJwaWJyRnlHTWFrS2NlUXRCVWZodTB4Nmh3aGhkTjZxS2RLNEF4TjAx?=
 =?utf-8?B?S2hSYmJIODQ0VTU0Z09BVmRCTDdGbXpIVlMyOS9qWG1nL2lkV3ZvNVlDdE4r?=
 =?utf-8?B?bUl0bTFuK1BFelFqZlpxc0dDUUp4UHNkYzdDYkFCWmUyWHhhcjR0RHJNRnNa?=
 =?utf-8?B?N3hjYUt0aFIrTnpGZXV1d0tZYWx3N0hBaEVObmNFdXJRaEY5UkZPN1QrNmU2?=
 =?utf-8?B?Uld5MUkxTmhKeFVhVUFjMXRMWmt4c1k0N1BtOXVLRDFrdlNvdFJ3RFo3Mldo?=
 =?utf-8?B?YUIzN2RpYjcwbkg1UmRFK0liUzI3ZG9JVklVZDEwMHVlZ3V2eDZMeVZ6ZVA5?=
 =?utf-8?B?TmNVeXM3ZHM1bGtDV0ZUc3FjSXFyMEZzUnhocnBHNTFEdmxjSnRhcmFRUjEx?=
 =?utf-8?B?MjYyME9lN3FIQW5GeUw4NWRkMHU1Wk5DdjZSaE9HLzNsN0RJK3NZSklsT29O?=
 =?utf-8?B?VDMvRjlGQUlucGFjRVZBejhOanJQYTF4VWMyVHZIQkxRbHJUd3loOUVJOVNQ?=
 =?utf-8?B?b3BUWnNCTEdiRWdVdHkwTTZPbHBrc0VBVVZDU0U5US9QeWRrU0dLNThMSnhT?=
 =?utf-8?B?aHB0SVZNbWpMMDRLVHJGQW93MlV2WVRSeFlTelYzS215WE5SdGUvdm5OV3cw?=
 =?utf-8?Q?FSdAc6JYsqQfxybUqFtm02T55?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0550307-3e8a-43c9-c3c3-08dc210f66ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:15:21.6632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBf8cWIAAn9YI4oVBq/Ni98rKRU1Dim6U4Hp2E3O9Jyda4VGItNI/UcUe9g8cCZhrhAN/2noh/5beso69wiXPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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

On 1/29/2024 14:46, Mario Limonciello wrote:
> On 1/28/2024 10:18, David McFarland wrote:
>> The same calls are made directly above, but conditional on the firmware
>> loading and validating successfully.
>>
>> Fixes: 9931b67690cf ("drm/amd: Load GFX10 microcode during early_init")
> 
> This is a great find, thank you for the fix.  I'll apply it to our tree 
> and Alex should send it in a future fixes PR.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Sorry to be pedantic; but I realized after I tried to apply this is 
missing a S-o-b.  Can you please add one?

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index d63cab294883..b0ba68016a02 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4022,18 +4022,16 @@ static int gfx_v10_0_init_microcode(struct 
>> amdgpu_device *adev)
>>       err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
>>       if (!err) {
>>           amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
>>           amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
>>       } else {
>>           err = 0;
>>           adev->gfx.mec2_fw = NULL;
>>       }
>> -    amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
>> -    amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
>>       gfx_v10_0_check_fw_write_wait(adev);
>>   out:
>>       if (err) {
>>           amdgpu_ucode_release(&adev->gfx.pfp_fw);
>>           amdgpu_ucode_release(&adev->gfx.me_fw);
>>           amdgpu_ucode_release(&adev->gfx.ce_fw);
>>           amdgpu_ucode_release(&adev->gfx.rlc_fw);
> 

