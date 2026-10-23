Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F603606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VuvJEEyt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA09810E5B3;
	Fri, 23 Oct 2026 06:42:35 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF3810E5B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 06:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQE+HkuB8SQNBdhQLkK5RGFzgNYu8vCCD4FJBx2AxhZl+6btqB4vwFiQtlHRW5MaYZfnIzrw/LWvAti9Y8kyZUdT8mzozccpwgbS2GVkt5Z3JoJvXJWzaK9a/6pTn6sjUXkdG0TuriUe3qCzzajjLwzXWuxGA7DiRY7/5o8jcvwexDKsvj8EfcoHUiueUjQwThDbxn5gWxBm/DqwrvODintllT6V2SclpLHkLClm1tPVzE+9+1QAKKGhW3dgg/3DKR4WxGqdqKQVvDmSbUa+Y6cS8xt6DmqTuQzCyBfWLy2v/EBZbsy9oVUAxb/coHgUaM9cGus0LRu6heet/nAehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8DP+wQkjmy39HzEwd3vJJ/qRRepxYlU2OLpNfOut7U=;
 b=mS1NfnfnSDYe10LlBmL/9AuA/kFVbpc8Okwp4zFiwgO9rKr3juu0HdL2OtkjxRNtk1WPfh0Gi18bkOZ1AC9QFJyd7u1fziTDCg436M2THPxScOx2mA1/RRuKQc3HktbPenlkioV5RB98dKEVJssoZmaM4VhUhw14v5NTyaNjsVjkolindKL82xNtaNkhchPK5YIe0DOy0BgCIKke4uouWwQoWMECxkDEL4uJ1bd/sG8mP/W5h48d9T++BjoIF7xInpeJOGu90sQMAYIIgjEVI09raFeqUCgUadWQRumj+tcdCOTdeqShtFD2JdwG0iDQlcTRq+fmTdwOUIoIg1XgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8DP+wQkjmy39HzEwd3vJJ/qRRepxYlU2OLpNfOut7U=;
 b=VuvJEEytVebemD8tvANWjElCY2xkbJmWrSA4xqn8poL3CGJM3G4KTntENsurgDDAAxCqSbQyCpLqFqCgDitXfb2ERtuA4TwPb33doq6aVYmF3t1vyIBEuQ1bQNIG4UXB/OSN5OnfxJ9fehyy205q9OsjC26ISof7jeVk2CBhEBg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 06:42:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 06:42:26 +0000
Message-ID: <70d30f48-709f-4664-93e8-438bb1cbadfd@amd.com>
Date: Fri, 23 Oct 2026 12:12:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx12: flush the scratch register write in the
 ring test
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Mario.Novales@amd.com, Igor.Caike@amd.com
References: <20261023063031.849579-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261023063031.849579-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6340ba-768a-47ed-ff22-08df30d0cd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003|6133799003;
X-Microsoft-Antispam-Message-Info: QXamfK26S8zs7UKUvb1EcXE/BhYD244TQw/Sy6yCnf4sxeIWahYkuqhyWWhdQTwCMyBSvj0SmwgSF1xuJ/+bKMPTDvG4sxIC0A9ocjjXMoG2acXz9Z763YchNG6d8gnrm6w/dpLDh807KDRGEcIb2oyxNgYfVSlEXS/5F0Btv97P3MZnwIlrfwJfx0W5GTgBjfp2EZQHRfjR55cVMq8gKFtGKpTPE01jCjuxrtm9i+zWik61z4tVnBQ30OIeUMEtk8xk7mkSz9CKl2QgIF2Gv7XdOkzAnDTcOcCuXRTgNej8JPQ4pGYBJMwPpcMc+HLOHAdgDgZ5LvhyCtOGdusKYjVuUniFR+TbFgIMVqn3RF5p9euAHO+ar+UpBFbAaL01j7yBmRP2TBfrjqGNiBMIIRYTQ+ONmD9FajVblU8gHUoQCvS67Gs5/tRrZkXizR/JkvbMQrsXkombGBp+8C+fCrW0jq3CBhqkoz1Eh4ecsyYTGQ4qQQ6j8bLU1Vybqq7wPkFSm8G0qxg4qPNwOE/YdohEBwNfUgGPD5Nglc3Mk2BwNXWvdlu0JvopBDTOSqfWwNT0MfMkjNiDzpR/884hQ1DyR7m2xb7Uq9IO7J5cNMC2ZlCeAjVrB4P7iZPt8vTzpf89DusPgo/MmyG1eT27WOF+G/CFaoCgsDveKIs5eXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck0vTThsR3dBeGR1cTBkdkpNQWhBN0NPNjZTNFpaZVBobTlWajYrTzJZalB2?=
 =?utf-8?B?QmFmU0k3NlVBdDlZNWZOL3A4SFpEdkdoaHBTNEdjbmxLZXkwQThzUTk4WjdQ?=
 =?utf-8?B?VTR0Vk5PVmIzTEZhV015ZkduOUh2N08rSmdON05aVlhZQUZiV0EyUDRna2xO?=
 =?utf-8?B?M05ZV1BOZE9PYjIxT1BObGwweERHcDdWRFZ2RUZ3aFpQZUlTaHAyMXl2QW84?=
 =?utf-8?B?TVJuQ1pRT1F5VVNwamVkSUMzdG9KRTN3dEwzdWRSaDZ4S2xHYWEzQTVqaUtY?=
 =?utf-8?B?SW9lYzd6RnJCcUxjZG5sclpvNWlURmJDMk9XYTRUUXdjM0VsdGNyNGlQM3pi?=
 =?utf-8?B?Z0ZVbXNLMmFUcEhmOE1weVVycllvV2kzcDFOc2NjSXVVNk4yYkNnK05VczdM?=
 =?utf-8?B?UDlsdWZSQ3pKN1g1ZWxLYkV4Z2w2eGJLRW9Fdks2UlUxWXh6OVYwZnVNUmY3?=
 =?utf-8?B?WnVFWjExR0l3SXNSMEhOVUorcDQ0cFA1eTlTTzJFcW1nZCtndU1CbDhhc0RL?=
 =?utf-8?B?YlZwWTBkUlpqRi93c2pFVzZ4ajBHeDJaa1N2RUJZOFhmY2lZb3lKV1NSYUJi?=
 =?utf-8?B?OGl6bXl3OXJqY1F2Z2FFZkxCL1Y3M3VWNkVVOEw2Q0MxTWtlUlFENS90a24v?=
 =?utf-8?B?L3VaMWllbkg1MFYwaFRVYzNtNDc3ZUVMT2FsYWpYWXBmdkVKRWJsbWYwamJq?=
 =?utf-8?B?d0NxNWgrWDdRMEtoVjhPdzlqVFVYem5RWFlHVWNtNUY2aW85MnMyV0xaQVFC?=
 =?utf-8?B?NHVwVGpMY3hwZ3d6RDY5YmRhazJiQ1VYdE43Mmtnb0Q2UGVxL0FWdEF0OEdR?=
 =?utf-8?B?MGRuTHY3Q3AvL3UrZk84cU02UEZ1bXM5OEVoZWhqenF6RTRUc3QzL1dxY2tX?=
 =?utf-8?B?czVqMTNQUU1MdWt3QU1qUmRYRGlZZDN5Ky9uUzIvUXUxNCtycFd5MHBJWGM0?=
 =?utf-8?B?VVpxVUhlSlVsaVBrWHU1RnViYUNobXRVcFVSVEphTGhvWnVuLzZpaDdnbXkr?=
 =?utf-8?B?VWxweGx0d1J0Y1A4aFBlY1I2S09NVlNpeis5bmRnSmJMSGpxWjJpRlA3RU5o?=
 =?utf-8?B?VTE2U1doU3dZalJOa0VIbjZ6Ym9pNVJTUko5b01ZNUdEQU5HWFNQYXhqa01J?=
 =?utf-8?B?aEVuaUp6Zk13ck9TT1ExYXNNUlppVVVhQXZKSGJtQlpOaEJ3NnQ0VUkrTnBz?=
 =?utf-8?B?NFRBdm8rcW1uWW1LalJYaWV4Wm1JOWFRK3ptU0FiSzVTNWY2a2RxRnhDZytz?=
 =?utf-8?B?RHp3TWRWSUxhZ09JbENGZ09vSjArb1duU2ZBV3lXcEJHY3FYMlFuNWxLOGNF?=
 =?utf-8?B?YzhrS3NzMG1JUnRXdFppbnBoWDNNc3VEVGptYi8zU1l3eEZiRGVaWkN6ZTRI?=
 =?utf-8?B?TGZQQW9mck5ISm1UZ0gzVmRkM2JFd3VRbFpYQUVNaVMzNWxZWVRUOTgvK1lu?=
 =?utf-8?B?aWg5THJvNUFHdDEvNHJ4eHFaQmxsYjZCOXd6ZXo4cStRd0MvY3R5UEUxNDZ6?=
 =?utf-8?B?STdRTngyMG52cFgzc0pkMHEreVlHZEh6VFgxc285b3cva1VuNjNxTFI0cVBm?=
 =?utf-8?B?UTZONlV5UUJaNldZRTZBNURPMXB1NDM2L2dML1hoUEhFejYzR1dHdjRVRlAv?=
 =?utf-8?B?bmM3TVh3Q0pGc3NFR1h3VlhCbEFNdU05Q3pjb2V6NWdKVHhsVmVkVDdYYzNV?=
 =?utf-8?B?bWQ2KzVqdUVMSVprdGR1WUxLTkNkcnVScndPVDZndXRjOFlINmtMOVJSSEZl?=
 =?utf-8?B?QkN6UDlwbkpvbTRlVXg3WlJ6Qkk4Z2tHd1Rac1diZ1JPZmJpVWdSMEYrMGdp?=
 =?utf-8?B?bUtwTGszazJ6OHpzK2Z0NTJueGE4MnRNQW9TbkQwUUlJbWJaVlQxeUxXVWl3?=
 =?utf-8?B?Z3hOWnZBUE1kamg0K09ZNm9CcFhRMWN5TkdqczRSNTlZcmY5d2VJenZrOWZj?=
 =?utf-8?B?RzBaUEtKVURkbVhDTmdQbGt2dm5odlIxS21mUjhEcWlJd3IzZkk5anRRdUI3?=
 =?utf-8?B?QjVSVHkvZmRkcVBIa201TUxOTlA3ZFdPMTdvRllZd1I1RXhYUHZvUU5vcjdO?=
 =?utf-8?B?RzRUYzY3TE9TWHo5dWUyTzRTdVl3dHhqR3BnVXJWdEJ4VXpsSnNMVEk1RzBC?=
 =?utf-8?B?bFdkSHNvRDNrVkd1ckV4bFc3SGFLTTVCakViWDBDd3V4bUV2eFEyTHpWZ0Nt?=
 =?utf-8?B?MkdaeG9oV3FKMFQxQkQrQ0hQQlNvTFM2dFNXbG5jL1Jjb3d0L0ltaDljVCtw?=
 =?utf-8?B?TlJRL2wvM04xYVVxQnFKUmU0cXhkUGx2RXVJbFZ5cStYdmx5bTJMeS8yUE9Z?=
 =?utf-8?Q?9SuE+ZuJn6EuSp3HbW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6340ba-768a-47ed-ff22-08df30d0cd1d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:42:26.6304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHF4S0okKocR1TJhfvmouK7LTao06M9eDIBZzjyjZKOwq+6ICCjuZfdVeJXEmsyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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



On 23-Oct-26 12:00 PM, Jesse Zhang wrote:
> The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, rings the
> doorbell for the CP to write 0xDEADBEEF with SET_UCONFIG_REG, and polls
> for the new value.
> 
> Nothing orders the posted MMIO write against the CP's write: the
> doorbell reaches the CP on another path. With coarse grain clock gating,
> a GC register access from the host takes about 2 us, and an awake CP can
> execute the packet before the 0xCAFEDEAD write lands. The test then
> reads 0xCAFEDEAD forever and fails, although the ring consumed the
> packet (rptr == wptr).
> 
> On Navi48, 39 of 10000 back-to-back compute ring tests failed this way.
> None failed when a GC register was read back after the write, or with
> CGCG disabled.
> 
> Ring tests run on every queue, pipe and IP reset, and a false failure
> there escalates the recovery to a full GPU reset.
> 
> Read the scratch register back before ringing the doorbell, as
> commit 3f69d5860f5b ("drm/amdgpu: Add a read to GFX v9.4.3 ring test")
> does for a similar race on gfx 9.4.3 with multiple XCCs.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index d334fb805020..184e009c8e50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -458,6 +458,11 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
>   	int r;
>   
>   	WREG32(scratch, 0xCAFEDEAD);
> +	/*
> +	 * Read the value back so the posted write reaches the register before
> +	 * the CP writes the test value; otherwise it can overwrite the result.
> +	 */
> +	RREG32(scratch);
>   	r = amdgpu_ring_alloc(ring, 5);
>   	if (r) {
>   		drm_err(adev_to_drm(adev),

