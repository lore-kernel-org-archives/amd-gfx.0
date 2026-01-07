Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDC4CF6C0F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 08:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3178F10E083;
	Wed,  7 Jan 2026 08:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGmgN6g1";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1753410E083
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 08:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8DxsqfCI4CsnE128Z42bhpbQnSG/hpK+sFlGhvOPMayvxhNB+ZvD/f7vwmWSczBRGu8U8ltWPdAoK3o7+UhZWkLM7T9A+/vaZqM9MmPKisoY11sPe/k5g5lSm0HPrM0RPGnXercKkMgryDcHGetfu6bC6AMPgAcvV9UAC3D72D3Ety8QH40dv+X29pOsoEGxph4wudwJhxO9As4qQqgMeli+k/tttYzM7JwOIdhdYtNIObpVkJq3W0ZVBjTaDJMjB+Phkoijhw3q+4iIOHB0s/5GPj3V3s/w81toUC50oB9lq7sH2CfXU+sGMUqnFMGPGx/zyQcu3xJfMtr/MDVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j6doLNerswBtC62zTNR1LaOet904B14ZqhY8bWrV3I=;
 b=IYKc1cR0gb9ULoaHpZ5whQsUXFDexlphD9+Ib2GTyEzRjnAYCjk07684jy5ozSsi4VUlFt3bSHy1FU/dXKQb7i0/OnY4UrYGbTXLLLJNjLbKy50nknCiIM44IbudEURfTv/uaoAC0IEIbYyeTcj4RUO2cjh0wNwbW1y3LZyQP939lqBIdIbimVpkf/x78lWMthDoqMIbUwqn1VmOq8qhWyj/ZTWDJeMuBQKFpEMT1B7PKGSRRVDMLpRGub5cOcgi86Iu30q5PAhuLdEQAEctLOTlOaOBrdkUHY8illXl5gYLVO4KQk9G3jjmKMkZotYtnuNKGiNRkczzKk9qrHUj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j6doLNerswBtC62zTNR1LaOet904B14ZqhY8bWrV3I=;
 b=ZGmgN6g1LmrX/SJhVvrhYa/CpMYzFbY9k4b8nF6MW/qpntiDcQsQK1J3Dt/RHvYu19DV/5l84roX6Hn4lTSQR6F2jO2+0w0pzi3wD06l/GW+R8EYdNk1XpqocSLCHs2EIKofUoASZXjdkq1/2gwzgNRmg1VQfBn89MEwhK85jCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 08:55:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 08:55:15 +0000
Message-ID: <084d3c4e-1ac9-4ccf-9f35-5bb4ddd90fcd@amd.com>
Date: Wed, 7 Jan 2026 09:55:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] drm/amdgpu: Remove the bo list mutex
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-5-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0431.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: c680f138-c961-44a9-80de-08de4dca795e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkNUMDNKSGViRmovWHNyV01pcDF0ZUp1a2dYY0RYUCsyTnlxSXZKOE0ySEho?=
 =?utf-8?B?U2QyZER4ZTBtTFl3cjhJNHRqWnlXbHFqK0lUZ0xMZUt4TjFKYjdDMmg5d25z?=
 =?utf-8?B?a0ljZnRhUkQ4aFhlSGNvOGZERzRRMWdmVzV3R0NNdUNHMVJvMlB2eHd0ZDJP?=
 =?utf-8?B?VWZCeXFTWFF5V0huV1ovNXBOT2R0SEYvRStWMjZybG91TXpvTm1jZm1CV0Iz?=
 =?utf-8?B?MUhkZW9qVWdMeTFYN29icEJ3RHdWK29tTkZaL29kUkxNTXlEUDRtK1Z2WXFj?=
 =?utf-8?B?QS9aSERsL3ppaWpueWZNTWdVU0xZZTNtYUIwT3FkSVUxK3dPbHBEY0IvZUlX?=
 =?utf-8?B?TXdYZGdxbDF3MFU4dmNMUXdUS3dnbllRbTB6NUY5cDczM1Jzay9KRVVoeGZ5?=
 =?utf-8?B?bkpmVjFLSWNsZnJIa0NGeGxzRWcyTXdMMElKM05xNG1zanNlTDNtTDRXc094?=
 =?utf-8?B?R1J2Y25PVnRZZngxUHcrcDBBcVR1aFdIQjRSTWhTWWN5dmpVVGRYZkIxMEl2?=
 =?utf-8?B?ckZXREFNWnhqUGk1ZFhTMzFQMnhZS2djRnZub1NIZU9KWFZvYlpSbHFQSSto?=
 =?utf-8?B?VFF2V2lYbm9KbnZlVmFhUlloZWFWM2I0Mzdaek1zdXZNY050T1FRa05kd0tr?=
 =?utf-8?B?V09nTERWYmJjeloyU0VTNDAxUUFQL1RkdVRWbkN6eVZJMlZ1eEh1ZUQ0SWFQ?=
 =?utf-8?B?L3RIdVc2WjBCRUhrM0gra3cvS0pac3l3d1dhRmRqR0JtbXZsWHlUcnVPOHlJ?=
 =?utf-8?B?eGF1UmtQajAxMTNHYjVnVEpoa1NPSVlBdWFUV3JVSHQ1eGN6MUczOHNGczVH?=
 =?utf-8?B?Uk5MR0FnbGR4OUM0TjZ0RWt6QWpyMTRiK2luRm1oSnp4RXltVXFQZUlpT3lS?=
 =?utf-8?B?V3RiRjFmMzFqL0dUdyt2d28wTUdIYjg3QzZ3S0I0eTNxVm1OdW1hM0lZYjc2?=
 =?utf-8?B?eG5WNmRXbDl4UWdhOUdFZUhMbFYwUHlMQ0c5NFUyeHdpblZJaHltZ21EUmM4?=
 =?utf-8?B?MHdiMnZXaEhZUzJac2lRWG5DNC94blNnbXg5ZE5wcHpqeHRnUUZMa1hrYzFn?=
 =?utf-8?B?UVdKb2lqVDgzODZxaEhlMytSWDIveldteVNYOUo3SnV4eUtiRy9SS2ZLUVRy?=
 =?utf-8?B?MEpBQ25sM3Zic3VnYSt5U3BYc2tFMXFSbVpKOFJnaERCRDljbTl5N1RKU0pn?=
 =?utf-8?B?WEEvYlNFYTRuMjR4M05mSENsOXhCZ21yNk5SczBHS05OZENwOW9SamxTZEYx?=
 =?utf-8?B?ZjNOZ0lQY1ZGMEkyZ2duZE12UFJnemo1clVQd1U1WVNZWWdFUEdYaUs0SzZD?=
 =?utf-8?B?VHFaQ20xQTlZbDViR2dvVVBoMEZ5MmRXWVZKNGpUMXVGVklkRWtralJnOVp0?=
 =?utf-8?B?R09tb0J2b1ZvWlJzckJCMzFTbFpjTWEyTHVDaEg5WUZUWldIejhZYUJHWU5y?=
 =?utf-8?B?UlJEd3VpaFZqTGVJSGl1UDJTZDlpQmlVcWJSMEZySkF6MldYbFY1R1dYL0sv?=
 =?utf-8?B?cVVvUzBWbm9Cci9JVmRjMHRKUnRmRkVyYnFIMDNjMWNRdFBrU0pDaFdUcHVI?=
 =?utf-8?B?NlRjN0J1cDdkbHNLcHNUdVhabE1MZk10Y2VNU1JHaTlmaDRRdTVBeElkNSt5?=
 =?utf-8?B?UjBSLy9mditxT2Yyb2tLWUlESHgwdnByVm5UYWlLd0JodEFOVmNUSWYyMmZi?=
 =?utf-8?B?R1JiMjd6TTRmQjdQenBGSEt0TG5jK3FYU2dNbXpOeUN5MVc4QVNmNmljODFj?=
 =?utf-8?B?TFcrbXM2VlBuL3ZRUUg2cDVVdE9CejYyaTNLTVBSbkxEaHRyNXRCa2Q2YWti?=
 =?utf-8?B?cHRtR3c3bFdQUnFHeFc0d1QvdjZETnFsRm5KYkJkZjdEQ1kzOXo3TWNucTdL?=
 =?utf-8?B?cUN2UGMxYjM2dllDRGxMcFIzSzFGZktGbUZ3MFZqb245N0oweUFBaXZEQ1N4?=
 =?utf-8?Q?/7empNNH7AY6TJ2S7hpf2NkKZhEg0H5j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1V3bS9nb01PcTVzcklCNHFnaGZhZ1JpREpzdGpFdEZYcFFHNjFCaTBjbnJs?=
 =?utf-8?B?V0hqbzlidFFJbHZRZ3kxUU5OVGNqYmtQRlJ0R09zNUZsUlQ2YTIxQlIrcXFn?=
 =?utf-8?B?eEtaWEVGb3ByS3JkbnhLendtSHluZDBHMXdwSnl6amR6bWdBMWFlUFBBSWc5?=
 =?utf-8?B?eUYzTUx2aEM4VnZUbXJGWlo4am9QK1VjQUVwMlk5WDVhZ1M0OFV6RXd5aEdl?=
 =?utf-8?B?UksvMmpsalgzR2hEbkdEMHVMQmN2VjBjOGZHd1JxUDA3SnBIczJLRVljc21x?=
 =?utf-8?B?ZTN4REprdHkzVUc5ZjAvbVBzVHBGdUdRZ3hVVkc1dGtjdU5uUWtJOVNiWVp5?=
 =?utf-8?B?blpDWFR1MTFWTURqemZyWkJLSDdsNmtEdDk4UDZEeGFIWlQ1NmZDS2F2akJL?=
 =?utf-8?B?QjdUT3hKcUo5MENuVGd1MnFra2lxY0VUUzVoenRXNWg4YXZFQWowS05RTTNS?=
 =?utf-8?B?NlhHOEhGYXppWTJyR3hkT1hUUG1ZWlpBbHZWYU1kU2owNmVHblFlcFZneFdD?=
 =?utf-8?B?TFlyZlYxR3lSQnRTSXVSVlB1YU44dXpEclZNN1Q2Z1ZJamZlRW5BK001aEFJ?=
 =?utf-8?B?azErWG1PV1ZzVlRuU292TEswUlF3UXV0QnRWRTVmeWNkRlJBMEpsSlFRT1hy?=
 =?utf-8?B?VncrRE13MUNXR1dKYUY3bG9NdVMzSzZCMmVIdlhnMWdiRmFVeTk4U2hhZVNn?=
 =?utf-8?B?OFg0WTcrVWJzbG1IUnIzcGVRMzBtZ0pTM0EzdXNFM1l0UGFKcVY4YmJqZUhw?=
 =?utf-8?B?V1B6OHhCNFAzVUNJTm1iUWp5VEhaS1RGV2JOQ09KbFdnZEkvdnVYd1JkbGxR?=
 =?utf-8?B?WGJhZ2tvNjRBOFcwbzduSU1RUkowVmNZSC95RnlDVmpLT2ZwbldVZlkvRTly?=
 =?utf-8?B?NU9tcGFLNDJGTnFyNUprNy9NOHVINkZIUkE3V01EcFNVOWJRaDBybGMyV1Ru?=
 =?utf-8?B?cjJNVldPOXZtNVFFQUNKaXlzRURtQ0xEZk9DMjNpRktRT041Q1RGd3VUVTBu?=
 =?utf-8?B?OWUyYlhza1BjUU50WXB4UU1Tc3JIOEMrMEVBa2QxeGhLU2EyZm9jaDJGQWxy?=
 =?utf-8?B?eCtaVFNaRFZkRFJOSzlyd2hCTTh1VlpoS1ozdzVmZXpKVENWdkk4Qm5EK0xX?=
 =?utf-8?B?RWl6SGNsU05lSXl1VUIvdUphWWgweXFyNUFWQ2NMcjdpcTZtYTAwZDRLQmdz?=
 =?utf-8?B?MFJaMHFWWjVxOWwvU09WWXZnLzZYbGdjd2tWcEtVdktTMXo4c0ZvVmljVFlU?=
 =?utf-8?B?VTBLazNpVkRNMFF2elNQMUplemE3c3VWcFhuU0M3L01RSFFkNjFuYnlIa3NR?=
 =?utf-8?B?NjViYldoS1Rhakxrdit5Rk1YVW4xaW5kc0ordGltU3ZxQ09YczhERFpFU3Rl?=
 =?utf-8?B?dllsVXd5N1p2MWFJb1poUnBiTmdTMnFKSjhrdVIxRGFMWUt1UDVQeHlleURr?=
 =?utf-8?B?eGVDRlRMTHJZR24rQjIxZDhybkRzbGFDVk5KNG5CK2NkZjdwcGJVb2JUbDBB?=
 =?utf-8?B?TXcrYm45TzNSVkdtbEpXR3JQakptbkM3RDI4MExKaE4vVUt2MzJ4bEVIaGN1?=
 =?utf-8?B?d1lwWUR0dmM2ZkYyVzFhSVZKa05EOWNKN1pTQlh2YXV5VFovdUFtZ3dJdXJr?=
 =?utf-8?B?ZnFycFNhWVV2VUduYWVHWjBTN0EvZ1VRZk1WMlBmTjJkQ3ZvMWkxb1NiMGF4?=
 =?utf-8?B?ZnlTMnR0dFdQaytHVlFXMDFkclNDSFFLbm9jdUxINzZ1SkF6RFpQdE42dVBN?=
 =?utf-8?B?Y3VQTXFPTEd4WFpSOWJNc0E0UDVZS2ExblFOQmhBREZ3SlZIdlY4dWUvY2dF?=
 =?utf-8?B?TU9nVm1iTzBzVElDTm1QNEpTbWJBRFhpZmFoTWw0ckdidThjK1FMMzFEL3ZQ?=
 =?utf-8?B?c1JBN1NnMVJjTXVjSUIrOXdQRDRHSVpsS1ZONngxT04xRld3c2RHUWU5emtK?=
 =?utf-8?B?Yll6a2s0MWNybEg4WGtJNjRySUJHNG1qNTQ2RUsrUnlSVFBsQzF4Um9nWWlT?=
 =?utf-8?B?cm91RlpxWTFSYWpuWnJnZHdLSTdmK2NOSUs1akRyOWkwZGVhS2lNblVLMDNk?=
 =?utf-8?B?cGc4MXBBNDlVUThOejVFMEx4UTUwd3BZdzhLNUNHTFlwcS9WSkZYL3dwV1V5?=
 =?utf-8?B?eVA4L3c4NnVPMFU0Y2hFaWhJTFBsRFphSlI4SWhXaHVHbDh3cElwN0ZKTkdB?=
 =?utf-8?B?eDcwdWF5RTdjaDhuOWd6NkZxL2c5NXI4TU0rN0s3ZVQzQWxaY05KN1RmcWl2?=
 =?utf-8?B?WUpqUkpSa2JhYlRWMDMrMEU0S0xXM25BdXBsVE5KeHVycWlPSEliaVpIZWpX?=
 =?utf-8?B?azVoa3BtZ2NRVkJsQ00vUFdUdzNXUHRDR1hnb2R3ZjZCYnNBaHMrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c680f138-c961-44a9-80de-08de4dca795e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 08:55:14.9588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXoLJ0VtBra2jkC8GvRLRl4diNd1ig/ilr6fWCFbzWGIuUFPCzwqlt82IzkhoNe5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

On 12/19/25 14:41, Tvrtko Ursulin wrote:
> The bo list is immutable during command submission since the drm_exec
> conversion so we can remove the mutex.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 15 ++++-----------
>  3 files changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 72c5096c3b18..fbac929f711c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -41,7 +41,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>  {
>  	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
>  						   rhead);
> -	mutex_destroy(&list->bo_list_mutex);
> +
>  	kvfree(list);
>  }
>  
> @@ -133,7 +133,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>  
> -	mutex_init(&list->bo_list_mutex);
>  	*result = list;
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 2b5e7c46a39d..1acf53f8b2f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -51,10 +51,6 @@ struct amdgpu_bo_list {
>  	unsigned first_userptr;
>  	unsigned num_entries;
>  
> -	/* Protect access during command submission.
> -	 */
> -	struct mutex bo_list_mutex;
> -
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 203223fd0b54..bc9cee3fdf27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -881,8 +881,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  			return r;
>  	}
>  
> -	mutex_lock(&p->bo_list->bo_list_mutex);
> -
>  	/* Get userptr backing pages. If pages are updated after registered
>  	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
>  	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
> @@ -998,7 +996,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}
> -	mutex_unlock(&p->bo_list->bo_list_mutex);
>  	return r;
>  }
>  
> @@ -1381,7 +1378,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>  
>  	mutex_unlock(&p->adev->notifier_lock);
> -	mutex_unlock(&p->bo_list->bo_list_mutex);
>  	return 0;
>  }
>  
> @@ -1453,28 +1449,25 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  	r = amdgpu_cs_patch_jobs(&parser);
>  	if (r)
> -		goto error_backoff;
> +		goto error_fini;
>  
>  	r = amdgpu_cs_vm_handling(&parser);
>  	if (r)
> -		goto error_backoff;
> +		goto error_fini;
>  
>  	r = amdgpu_cs_sync_rings(&parser);
>  	if (r)
> -		goto error_backoff;
> +		goto error_fini;
>  
>  	trace_amdgpu_cs_ibs(&parser);
>  
>  	r = amdgpu_cs_submit(&parser, data);
>  	if (r)
> -		goto error_backoff;
> +		goto error_fini;
>  
>  	amdgpu_cs_parser_fini(&parser);
>  	return 0;
>  
> -error_backoff:
> -	mutex_unlock(&parser.bo_list->bo_list_mutex);
> -
>  error_fini:
>  	amdgpu_cs_parser_fini(&parser);
>  	return r;

