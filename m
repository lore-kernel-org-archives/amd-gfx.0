Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B7606A32E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d4K0m0ZF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2871110E253;
	Mon, 26 Oct 2026 13:26:32 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD41210E253
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 13:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVTUChaPUPcOZUXvVcQdvMM/U4BlaQpFWJiteDT95JbjrM77b0hKYo1ikC2v/ACDGbf1thBwk6xiQM7aQ9efvNLOSmKg4v55n8AdKzbd7faUWIQEs4ADvV6anFwknUpv7yrKvyR09CI/0UjH8PXcQ3kwhAhCHsS/083vkxeHA2FLH0wAS4KiatmazkAvZc7ECdYd0rH+cs8FJKzJFskXeeM0hFETk4a9xK0fa9uWXMJVGc/xbb2CKRufMk/KARFP1xWJrC4rlkb9FKttnwMmkjUYcEIzx+XC37wXXo9u+KnVDMGrZuEvWpAB/DvhJ4Ec4VybHjRtBImmsOBiQOjlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKXvkP3JO4+O5UltPH6OTT0cpWlzNWA5vtBt9Mdmujo=;
 b=cXG0SeK7HPhLK7dj/luuBjfkl+N+DuO3jvlr/X325H0QiFOt9HxEZDwWx4XCxf//ZkbJNtxxacmbkEiJlB0x9K3DGlb0+g0qQFWjzOpGoYDWfGsVi/HlaWnGO5MJXbARQRpzqD8xEie46+On86y6SFQZZso/QeUsnvOfA0Z8i3vtvU2yCWfBfoHAReOqT6lE7NUSqgK3gPsU8LZMyCgiOaMdEbtT3LAPrU3HShXZn0ohYkr8xlSx0ufxK6yuNXKnLjYRjpcv23VwZ0XBw2hstGNHZXAwjpnO7DK1Fa56yFKTFm3vxXRnK6AveMFy0fraqJBnW1S3Wuby6z+q02FQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKXvkP3JO4+O5UltPH6OTT0cpWlzNWA5vtBt9Mdmujo=;
 b=d4K0m0ZFxj3LQLd5rGFTiIny/QazmeDF3e1wFMANR7MWcPwKMIuJGfI2YlZ8sCZFytOchSM6aEji2iZKZ+KhlTIT8UyvzIRLIIO9nqOHhxoHQ5EZk+rCkWYTuT3m5zLotQiUSxtj5iXlKQ95jv6nCAAis+PfmhZY51gH+PRFUts=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4SPRMB0031.namprd12.prod.outlook.com (2603:10b6:8:349::17) by
 CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 13:25:33 +0000
Received: from DS4SPRMB0031.namprd12.prod.outlook.com
 ([fe80::5a9e:89da:d693:13a3]) by DS4SPRMB0031.namprd12.prod.outlook.com
 ([fe80::5a9e:89da:d693:13a3%7]) with mapi id 15.21.0546.012; Mon, 26 Oct 2026
 13:25:33 +0000
Message-ID: <48b0f431-2abe-4e9b-b0bb-aff6f4fbf5d8@amd.com>
Date: Mon, 26 Oct 2026 14:25:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vce1: Fix checking whether VCE1 is idle
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20261006170352.26722-1-timur.kristof@gmail.com>
 <54fd40c6-f13f-45ed-ba55-ca38052cc3ad@amd.com>
 <Yxz3zvy3ScSroj40wKVDxA@gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <Yxz3zvy3ScSroj40wKVDxA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::17) To DS4SPRMB0031.namprd12.prod.outlook.com
 (2603:10b6:8:349::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4SPRMB0031:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: c63622a5-77b1-4abc-4b67-08df33649cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006|261009223027099003|10067099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: NQxpWocjIA5jmpN58D+HCJQJAtsJYqMEumQqT1wCD8Ow4maCx+xjVl6Ztpcq9N5mC530/b8+G8cM43Izf7CKZOiJZcMU7W0bItsY89CoEe0U7b/NW+sqW1ODvesoLFguVpDEOXAkJKFs5Wj1ySLubqrt+MblgvKM4HoVjjMqDUExwSBRJpy495XjykvvdYmA9azlH3qVSt6ilkZ4KpVOQm5S5xSbCfwdRnljcGmFtcRIhdI0od4v4B4uEpNFbPTRBPWNFTll9vd7Tgz3QMjUerMK9P+XjJ0Ym+asR67KO2UF13dvUz2OT1b99fK5MQs5O8BVr17PFC/ml5NYinUH66McuCSY/ySCXXrW1h83s9rWCmTg+Ktce5lJpLOhdBXl7u0JN905mv68JmxcnyQKpxWw0RRgZkJ3cTwqohA6maQU1eHTK20dDws0ZywCjsYCKZ6jPU0saDKSu2iwBCYxYd3C14t1aIqC8mW9U4G3t/IV+ChFHw55zAmYKBBxJ5+eXNh3HG02/JklFUqOxrTl2lELbzymEkQddjSVmNWcMOXD3ru5aHgn+7FHF7/EW5VYplVei0UDBukRpYyXvJMOISTM6woZzaXQGIK3DXb2YL4NaeDX9AIkKpl+5KP0+wbfDpQgZO5QCeNEo0fUnRzoHhBTqPXIA6r50GHX+o3Qdvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4SPRMB0031.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JvRHRRMDdTUTRoLythb216Qld4clhVYWVvNGVPdUpBWE1QeStOcmVsY0Va?=
 =?utf-8?B?QTFEV2RIZ3p4ZzlTaTNiZVhKZEUrNFJtK2p6cU9nSHFZbEFHaldLT1daSGlr?=
 =?utf-8?B?UE9wSkJnaTV0NlpadTJLb3hERzdaRU5WMjFVV2RMbXMxY0tlaDFDMDM0emY5?=
 =?utf-8?B?MDBKaTEzNkhoK01URi9HSStWdjJHNWpraEd3Sngrc2tZUTZMZmZkUUp4cnI3?=
 =?utf-8?B?c2phNHM1dWMyRG11YWxzeFVTTVFNclhacnBxeWIwTzBleGlUNjNSc0xXZzln?=
 =?utf-8?B?UzlzaFNGczRxYnc1MUttd2NOM1Q3dzA3bkxJTXZpdk5ONnp2OW5zRC8wUGdv?=
 =?utf-8?B?MkE2TDhCRWhJa1poTExXYTNlZ3BQU2wyamhIRjZGeHhEMUFZRGJVb3pVVmN2?=
 =?utf-8?B?VVhOd3IvWFNMYnRyWmU1SWM0T09IbndZcVV1cjVpclArd1ZWNHB6V2U4R2Rz?=
 =?utf-8?B?WlY2QlJXOURRY2hmVkxtV1lLWHNJSlplUGRxeXlJVFlRNGROd1lmQ2N5R2sx?=
 =?utf-8?B?cGFlU1RBM3JoTCtGd2pUUzVqS2xLU1M3U0tJWVNZYStpS01UTDZlSE45L25S?=
 =?utf-8?B?Z3ZKU09pTWdaazJlMTF5M21CU3l2REkvNTMwRFF2VGpnbGpjSSszbFc3VlBu?=
 =?utf-8?B?M0dNNnNxdS9KY3hBM1M0eTR5L3FZSDNoZHd5MjRwS1YrZ2J2MExVSHQ5RGNP?=
 =?utf-8?B?QWN2ckpjNWZEVHg4MGJoZUpzdjMwK0R4TTJEM3BUZE9ZV0NHUzhQS3FsaFk1?=
 =?utf-8?B?a01wdlhNaVh2M2VkNnc2R011Rkt4dFpZdTd6ck1CQ1BQNks0QjVNVDZBSXFK?=
 =?utf-8?B?RjBZTWVpS3REc2VaRDNxY1B3bldJdU95R01CamVZRUFBZHVFc1ZCVHI1S3RU?=
 =?utf-8?B?V3F5cE94VFBzZlZHN0JxMEV2ZWZ0TkZxaFUybDdzQjIzUFhEMWtCMVA2OUdn?=
 =?utf-8?B?NU45THNCVjF6YWVKWnh4V3F4M0JvTlZJamRmRjIycEZxQW5Bd09vdnZ3UUh3?=
 =?utf-8?B?ZmZ2V0ttem90TkJDc3hObXNYRkpJVy9VNHpIZU5jNlhOa25OcE1PVi8vbzQ5?=
 =?utf-8?B?L1lwMFFOR1oxOTNnd0dIME5BdXU4dmUzTnBkV3JsdjM3ZUpWaHhtbm1FeEdP?=
 =?utf-8?B?TjYrbm81MWZwRit0VkZWZHBDaFdmOGg2bmJEdFMycmNNY3d3V3NBdEhzVlNi?=
 =?utf-8?B?UnJXdGJFYVFiR3BBTGhXN0cycDVmWjJuQlpNNDFSamtsQS9HVlpMazJuVzdp?=
 =?utf-8?B?QjZXWC9vZU1nU2svV0JacVg1WW9aQnNWeWM1a0w2b1dVSWJid29qc3EwZ2pM?=
 =?utf-8?B?YVpzUE5ucDQyc0Z1eHVQK0ZpVVJpcUxyaXgrZ3pKRHFiRmlaVUExaTBtUGxs?=
 =?utf-8?B?U0QwbmV4cjJNaS8xZHg2SWJPT2ZrYkw3S2FvYzJ2emM3RWYwdGxucFN6L2xK?=
 =?utf-8?B?ZVFFR3hDRkVISk92NVBsVjErRXltbndpazZmRFFuTVVPZUd3YzhXR080a0pI?=
 =?utf-8?B?NkRLU1k3R3BIVXNWMEt1RnpIVGxjbW4zZGtGaGhkSWJyVVpoV0VhQW5GNUt4?=
 =?utf-8?B?RWljcG9kYkhITzJhZEFuVDV6eVV3dlRya1o4UEhNUUVveHl4SUtqSDB1a0ZL?=
 =?utf-8?B?SXVTZDRxV2JpWFRNU1VXK2R0VXlESHpBYXY4d2FHUzJPVSt2SUtXM1BsWTNn?=
 =?utf-8?B?eW50U1ZjeEpKbFAxNDNleTdaZzBQMm5jaXVoUUFjdHZiT2p1YTlabzZLNlUy?=
 =?utf-8?B?T0lBWkJrcUpFNmdsbmRKK1dHTmVvYVNnZjlpVzZ6WmxjODBZZmFxbDdLSlNh?=
 =?utf-8?B?d3IyZ2pDUExxL2FmUUxGZEpGR0dyM213WlI0Z3FkTkJPR0FRb3FSb2ZjOGVh?=
 =?utf-8?B?Y0NHNERxMHpudzBwcTdwNlU0UDMxWDZ5TnEwakJKZzZPV2hSYW9XSmUxd05h?=
 =?utf-8?B?bDliWkx1dUN2QndvMkZaM2JDWXBNYmp3MFZhdGNzL3dRbzFFT2ZjekVBMzM2?=
 =?utf-8?B?T2NmUGxiNTVCKzV5SzV6RXZxdDl4WTdCUnVzdGFWMXEvcWZZTU9nMXNIb290?=
 =?utf-8?B?dEtITVlyWjV6UkZSOTNWSTlxTHpOSGY5VUhCSExJcTZkTTBObllOWDZZa01G?=
 =?utf-8?B?ZDdDNkoxSFVnMVkvTnN1UHRxMm1hb1JYSy8rTHE3QWYrQzJGSWswekZrZUFt?=
 =?utf-8?B?QmVkMnYvSTdsVjRuWldrbU56TUZMQlFWMUY2bDNwRlZYc0plbEpKeEpTdXBz?=
 =?utf-8?B?dXdXTm5jNnpkK0ZLd2ZQWVIyUG0rNUM0b2w0RFRlZTZYU1hzVzJqSXVKMGxn?=
 =?utf-8?B?b1NkZzRhU3lMUGhQTFVibkowbHliUmtRWjJBQXVKQ2J4SlV4cktDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63622a5-77b1-4abc-4b67-08df33649cfb
X-MS-Exchange-CrossTenant-AuthSource: DS4SPRMB0031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:25:33.4285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXD5725SxBCOdZF77r7h6kKJ6dWf9XUCHHPKhGJ4RdVXyImch3vThteDIZf5LzoLVuNR5ohFMSGWQGzDgu0gKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/26/26 14:00, Timur Kristóf wrote:
> On Sunday, October 25, 2026 7:22:04 PM Central European Standard Time David
> Rosca wrote:
>> On 10/6/26 19:03, Timur Kristóf wrote:
>>> It turns out that the VCE_STATUS register bits that we
>>> used to check whether VCE1 is idle are actually not useful:
>>> VCE_STATUS.JOB_BUSY doesn't exist until VCE3
>>> VCE_STATUS.UENC_BUSY seems to be stuck high on Cape Verde
>>>
>>> Instead, do the following:
>>> Check that the read and write pointer matches for each ring.
>>> Check VCE_STATUS.VCPU_REPORT bits to check busy status.
>>> Finally, also check SRBM_STATUS2.VCE_BUSY just in case,
>>> although this one seems bogus on VCE1.
>>>
>>> Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> There's still occasional warning that VCE is not idle on my cape verde,
>> but it's much better than the current state where it prints it every time.
>>
> Hi David,
>
> Can you say what the remaining warning says?
> Do you think we could fix the remaining warning by removing the check for the
> SRBM_STATUS bit entirely?
VCE busy: VCE_STATUS=0x142, SRBM_STATUS2=0x80
VCE busy: VCE_STATUS=0x152, SRBM_STATUS2=0x80

which does look like VCE is indeed busy.

David


>
> Thanks,
> Timur
>
>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 25 ++++++++++++++-----
>>>    .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  2 --
>>>    2 files changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c index b1428f5bbc81..38e21d1a3ebb
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>>> @@ -47,6 +47,9 @@
>>>
>>>    #define VCE_V1_0_STACK_SIZE	(64 * 1024)
>>>    #define VCE_V1_0_DATA_SIZE	(ALIGN(7808 * (AMDGPU_MAX_VCE_HANDLES +
> 1),
>>>    VCE_V1_0_ALIGNMENT)) #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	
> 0x02
>>> +#define VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK   0x08
>>> +#define VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK    0x10
>>> +#define VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK    0x20
>>>
>>>    static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
>>>    static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>>>
>>> @@ -349,19 +352,29 @@ static int vce_v1_0_mc_resume(struct amdgpu_device
>>> *adev)>
>>>     *
>>>     * @ip_block: amdgpu_ip_block pointer
>>>     *
>>>
>>> - * Check whether VCE is busy according to VCE_STATUS.
>>> + * Check whether VCE is busy according to VCE_STATUS
>>> + * and whether the ring pointers match.
>>> + *
>>>
>>>     * Also check whether the SRBM thinks VCE is busy, although
>>>
>>> - * SRBM_STATUS.VCE_BUSY seems to be bogus because it
>>> + * SRBM_STATUS2.VCE_BUSY seems to be bogus because it
>>>
>>>     * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
>>>     */
>>>    
>>>    static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
>>>    {
>>>    
>>>    	struct amdgpu_device *adev = ip_block->adev;
>>>
>>> -	bool busy =
>>> -		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK |
>>> VCE_STATUS__UENC_BUSY_MASK)) || -		
> (RREG32(mmSRBM_STATUS2) &
>>> SRBM_STATUS2__VCE_BUSY_MASK);
>>>
>>> -	return !busy;
>>> +	/* Check whether the rings are busy. */
>>> +	if (RREG32(mmVCE_RB_RPTR) != RREG32(mmVCE_RB_WPTR) ||
>>> +	    RREG32(mmVCE_RB_RPTR2) != RREG32(mmVCE_RB_WPTR2))
>>> +		return false;
>>> +
>>> +	/* Check whether the VCPU is busy. */
>>> +	if (RREG32(mmVCE_STATUS) & (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK
> |
>>> +				
> VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK |
>>> +				
> VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK))
>>> +		return false;
>>> +
>>> +	return !(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
>>>
>>>    }
>>>    
>>>    static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
>>> b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h index
>>> 1f82d6f5abde..13c15c2138b3 100644
>>> --- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
>>> @@ -63,8 +63,6 @@
>>>
>>>    #define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
>>>    #define VCE_SOFT_RESET__FME_SOFT_RESET_MASK 0x00000004L
>>>    #define VCE_SOFT_RESET__FME_SOFT_RESET__SHIFT 0x00000002
>>>
>>> -#define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
>>> -#define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
>>>
>>>    #define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
>>>    #define VCE_STATUS__UENC_BUSY__SHIFT 0x00000008
>>>    #define VCE_STATUS__VCPU_REPORT_MASK 0x000000feL
>
>
>
