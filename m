Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79FD606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vZCVcqQw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479AC10ED5E;
	Mon, 26 Oct 2026 09:56:22 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD06D10ED5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 09:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqiALuatm2V59f7cOSePWBrljGLTCr0J4myMrO8d7FACnNEppvNz6zB1j3sZnekf96YCAjhcpDvjmbyWTnTRYRI9BqY9L4WEQtBiITHDW5KqmpnoS+gesud8xhe0HLkhSF7gdKmBikjJWWQieo01AZhWUMsLcDwZdjom40FoRBe67R8WH0XNjUrAyyEOKPeoFYddk8UKZyPsOHDEubQwLZwaBCQQpNdbU9eLor+ZpHEWV5jtnl6Kn7nLKLG3CkM2vHU5Fp2L9idaOV5k1XG/uPf9ob2bU5Rzi6+al+EIP7TpNoYqkRyjmIAfPrte71XAOoI+i48AGitj+h8TcrDYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyVitntjhyQ2e5unAlJCefKu1+DrfUKa3R88DQrcKUQ=;
 b=Z/B7I1Zywpa+q+RsqvGff1uTBav1Gzq93xpPyTxG4soNExQj63EbuZLjy+cuzsdD8TSlLpMa68juMYdDy/ium8h0ZaK4qOZf5olSkRfBoRte0IzPWEeb1GmB7TvsmJtcFWjbZ8tMMIEGlDQ3hevcFUiR1umPZnz0Cu5JVJSHA2cL2NN/Jiwz3U42pcFQB8vdPRnsiLzBiK6X24FYA/NEJESywm7NltDI9B+Azu81Sihr4/daWwj//gmSFn0dUKliADw7ZGMzhL++S6zDC13v3idmbG69EnnJCZOCmGae0iT0rYPdP8egC/ZUou4WstvN6Wqa7YMcT+3HfqDqmBzH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyVitntjhyQ2e5unAlJCefKu1+DrfUKa3R88DQrcKUQ=;
 b=vZCVcqQwFZ4DX+m0Nt6aloxn4lkGfOq1frkqpuo6vXS1GGvr9SYDsVuLw0lMjnFoV60doBc9YcJA4tpypU4vFGwIhEn1vE0V67JSJKw2VK8h6VW6fHBNAlqIp+LEnK6dCWw3eEZetL3zOHRh1D2/hmjz4gJSPRhvsK170NIVdxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:56:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:56:11 +0000
Message-ID: <5f3de76d-502f-41b3-be90-5679db5fcaed@amd.com>
Date: Mon, 26 Oct 2026 10:56:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in the
 ring test
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Mario Sopena-Novales <Mario.Novales@amd.com>,
 "Caike, Igor" <Igor.Caike@amd.com>
References: <20261023063031.849579-1-Jesse.Zhang@amd.com>
 <BN9PR12MB51464073C275F66E988745E0F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BN9PR12MB51464073C275F66E988745E0F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 67704505-40fe-4a8c-d726-08df33475d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004|261021121427099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: AX2qXtVhqdIUAnEQlC66Y5cfNG3pPSEe7bOHkHWpzfCuL0/WITZeNdhjvZY8I1C+Fx2aOxrvmPa5oZYZ8CLbNj+SDwWrPlgaWCIuKQsjgX3vKnb1V3+Nb0rFn2XP1hVmsvDLcJGoWuC8MNIHVGYS/ZrGk2t/2r9pcfthyuKvS49DNNqIrxyX44sOKV1nDtO4uYdCk222RMy/zYePBkW/3UywbicIwt5Dv/tWXveDUHkfp7TVXcRcF6t+RwUAfjG6grmMLkxWOwC+1/aJJaCA3WDO6kHA2b1VrjA9sOjglIYcIoDHNGaABjK+0LqXB4cX9mUcePURsQQsKT8r97dNauOPFM/7jknFsI77MNODpBMoA5+gRyg8qV/htK9OvW/PgHoXecZlC2Jhlpk9Nzyl9eIwTkISvS/KtIMxkKrg3zxSqSWIkDu4HiMlIUc4rDBKYEZ//QVQUhhUiZIAOyFPFiL7Lwk3vgohiSMdENr06//OgLa4wKUbkOtWCko7G8g5alUmBBkMN7/K/x5uqaFnq+X6D1Q4oS0QxKRnizBX42lzsXud6fzh1V9MA1RtD5yD0ewYRu4vxBqwusQqHs1CC+q6IPUU+RvUk07IYZARkoXqstyb15w/3Fu687fJNxea2PvMl7KbdUu7qU77hdIZyxeaceDl7ew9MMyYzD3wHyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004)(261021121427099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXh3ZlcvTWwyTXJpcnVQZkNBRGowOWs2TzhlZ1NEUTJYZHJnblRaUTRRK3p2?=
 =?utf-8?B?R3FFL1ZlVWVGSXpVQ3N4dHRBSnpWNkdpUzVGQ0JUS1Zsa05YK3d0cURXU0xB?=
 =?utf-8?B?Y2w4Zy92RXRUdU5pK21vUjZ1RWJxaGptclJaSXpIUStNTEJMbFR6QzhQL2JO?=
 =?utf-8?B?VzdGK1IxbjFBaFQxZTVPMTZuWFF2SFJGb3c1WUNndVBhSmp1NUlLdE92ZzU3?=
 =?utf-8?B?TXJ6WlZ3K3dBdm5meTRSa3V1Y1FydU5YbjViQ0FaQmhaMkQ2b1Fxb1NEZVMx?=
 =?utf-8?B?emlGdFFqUXlPVElxYU9YN2JZSFRrbUJRTUhXTVJJb3JIMUl6ZkU3ZE4vZEsy?=
 =?utf-8?B?bGFVeDVMdE5zYkl2VmtLQm4rOHQxaUUwRkZna1AvcUJkVFVMU25vclR5a2ps?=
 =?utf-8?B?WjJaUFF3TWdwQnJiTkdvak0xNDhzU3VlMDIwSmNkZjBTQXRqYjU0VHlMWnhX?=
 =?utf-8?B?REZPc05wOW9WRzZ5RmhEeDh6ZlBMZC9jK3IzRnltRStwZXB0NWJyb3d2V1pO?=
 =?utf-8?B?NVNYZ2E1QzBhNi9rU3p6YW5MT01iY2NVMXFKMnp3Z2xmMi95OFpIL05YYmlm?=
 =?utf-8?B?THp2bXIybXh2WTZ6ZlRDTmRvVU55OFoxY05OYytMUUJMenkxeS9WNWJvdSt0?=
 =?utf-8?B?UGVhRnBWZlVtbjJRVHdZT3ppeDUrQ0FrTlRVNlJEb254VFhWTzhOeHc3Sksr?=
 =?utf-8?B?cE9aeWpCcTRVemlXYjdDRm1YTVFkYUFwclhWcmtrME1xVUhFMVFyVUJCQzRn?=
 =?utf-8?B?cGZVa29RWG95MTJEZUNiTW4rMU5OeEVPbGE1eGdIaXdCTHIxcVZUbmliYUJl?=
 =?utf-8?B?UkpPdENlYWpKa01XMDhxRkFiTU5FVGc5TjErOEV2ZThUYXN6NzhjTm9OL2Jz?=
 =?utf-8?B?VTVkKzA5cnZWUVgwdXEzbGg3UDFTeUc0ZjV3T1ZyTWIyeDc0QUJRYTV5am5T?=
 =?utf-8?B?U1NEM2p6dFB6L2hBTzlEVlhzaVlLRmk1L3U3eDVjcVk1N2drL2o4RGpJUFRZ?=
 =?utf-8?B?Z0hWY1VwYUFNTmpWY3MrOEFldWttejFLSTUvbkRkdlNLZzdweHIvc2FlVVN1?=
 =?utf-8?B?SVl1K2Q1ZVhVSlpGSGlIaWhwNXBJYVhmUDllU21EQ0xPSjY2dmVjNng2RzFN?=
 =?utf-8?B?WWJOMk9DQTlJOUcrNjIwSXlVTE1kRktEcitWc0ZUUFFIT1M5TjMxc1dETmpY?=
 =?utf-8?B?dUpNSnpRdmVsVTRKRnYzOVRPbjV1eVNEUTdMUjZTclNsTWxsaHprTnlIWHcr?=
 =?utf-8?B?WFUwSTF4MXhVcnFNTFc4UG9NZW0rMS9URW1CSE5BQlZjSVl3Rk50bzBkZjVH?=
 =?utf-8?B?bVBlTStoV3c2V0hjNTd4N1VXSzVSb21lYjFvQk5GVE5sSG1sLzliRUYzdDc5?=
 =?utf-8?B?SlRpV3MxdGhRZ1JjUG9wbTY0NnlQUnYwMERkU0ZxRTNlelZFNTVXUjR3OFJ6?=
 =?utf-8?B?b0Z4TWE4QWZ4NEt0SnVid1JuMXIvNnZnNDdWOHhSNmdqNVdIK0ZQeGtoS2FO?=
 =?utf-8?B?a2dISElTTEIyQWw1MlpRbjVLRWJua0tJSkdkTTlxNEgybmZCd29wT1hHK3FZ?=
 =?utf-8?B?V0VNdWJ6ZENibGRxajRkUFpuazJ5azBBVzlyekFXbjhXUlg5dWVvSlhaVTRz?=
 =?utf-8?B?b0JaUmZERmNrZC9oaGpBME13MjhlYzJzUXVoQjVVWkRHYWlXQXRvRjVFOGVX?=
 =?utf-8?B?aWhZSjQyWGNBSEY2azJlYUdUU1pTYm43SU9yaGZDbW1NREJhWjdZUVhmQU1G?=
 =?utf-8?B?d3Fxc2VEaTBUZVZLZlhib0lyaitzVUh0TExQbEl2Ylo5bEFuelQvaGkxY3RY?=
 =?utf-8?B?Qkp3VVdzbmQzM240d1B3VjRHYlpvK05hS2pjbGtreHVqQ1ZhWld2alZzY09W?=
 =?utf-8?B?T0Jja3JCcnA0bG8yclRIL2hYZ2V0cFk2dGZsSTlLa1NFZk5lcmJUWWpNTi9I?=
 =?utf-8?B?d1k3eHlPanE4ZlVjWDZGZ0lLNFByU0NnZXBwZFA5dDdUSXdiSU91ckhpYlh3?=
 =?utf-8?B?bDh6NE9JNURxL0xpYStzbi9WNVg2ZE52c2EvODI5eTJGYnJJblB1dmljTHNq?=
 =?utf-8?B?dmgvZ1B1Y2hRR3hqRmFVa25GRTdZOUxycGh6T2dCVVRyUUJZM015MEhWNjFx?=
 =?utf-8?B?L0NGNFFCODdxRFVGZGFIWExNTUFhVStRNm85eDYxUWJRUjRFdUk3d2p3Rmo1?=
 =?utf-8?B?WGQ3d3Y2STNxSHRrZnBuWkNvS2xHaG0yUkJEL3d1L1Q5YzVsWlZwUmYwTERD?=
 =?utf-8?B?MllQZFpIQ2tBemRhcDZBZVNGWVV4amcxYXZvT3FCL2JIckd4bWNuSWpwTFgv?=
 =?utf-8?Q?NJak8HOkY1yOLIGvBk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67704505-40fe-4a8c-d726-08df33475d69
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:56:11.5146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FO3XdjzyDoxUbkHoJe0hAKCV9pGdXPFiFvhN+MQP1wC2Vv56lJD9KvaUBJ3+0Qd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

On 10/23/26 16:32, Deucher, Alexander wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Jesse Zhang <Jesse.Zhang@amd.com>
>> Sent: Friday, October 23, 2026 2:30 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Mario Sopena-Novales
>> <Mario.Novales@amd.com>; Caike, Igor <Igor.Caike@amd.com>; Zhang,
>> Jesse(Jie) <Jesse.Zhang@amd.com>
>> Subject: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in the ring
>> test
>>
>> The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, rings the
>> doorbell for the CP to write 0xDEADBEEF with SET_UCONFIG_REG, and polls for
>> the new value.
>>
>> Nothing orders the posted MMIO write against the CP's write: the doorbell
>> reaches the CP on another path. With coarse grain clock gating, a GC register
>> access from the host takes about 2 us, and an awake CP can execute the packet
>> before the 0xCAFEDEAD write lands. The test then reads 0xCAFEDEAD forever
>> and fails, although the ring consumed the packet (rptr == wptr).
>>
>> On Navi48, 39 of 10000 back-to-back compute ring tests failed this way.
>> None failed when a GC register was read back after the write, or with CGCG
>> disabled.
>>
>> Ring tests run on every queue, pipe and IP reset, and a false failure there
>> escalates the recovery to a full GPU reset.
>>
>> Read the scratch register back before ringing the doorbell, as commit
>> 3f69d5860f5b ("drm/amdgpu: Add a read to GFX v9.4.3 ring test") does for a
>> similar race on gfx 9.4.3 with multiple XCCs.
> 
> Seems like we should do this for all gfx versions.  Can you check the others and fix them up as well?

IIRC we removed exactly that ages ago because we have the dependency that WREG32 writes are ordered with doorbell writes on many other places as well.

If that isn't the case we have a much larger problem here at hand and potentially need to fix the doorbell write functions instead.

Regards,
Christian.

> 
> Alex
> 
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index d334fb805020..184e009c8e50 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -458,6 +458,11 @@ static int gfx_v12_0_ring_test_ring(struct
>> amdgpu_ring *ring)
>>       int r;
>>
>>       WREG32(scratch, 0xCAFEDEAD);
>> +     /*
>> +      * Read the value back so the posted write reaches the register before
>> +      * the CP writes the test value; otherwise it can overwrite the result.
>> +      */
>> +     RREG32(scratch);
>>       r = amdgpu_ring_alloc(ring, 5);
>>       if (r) {
>>               drm_err(adev_to_drm(adev),
>> --
>> 2.50.1
> 

