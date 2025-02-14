Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64175C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 10:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB88910EC48;
	Fri, 14 Feb 2025 10:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KNLtBh91";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C7410EC48
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 10:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDe3BU/Z6pu2KfLqr/81MNrHZHK4vdSwDp5z7a3GFFJcWsUdmAIBRedhhTneALc10ExpP2Lpxf1DdG2j7SrWMGslRD17gBQiQ6lygm0fT4jHNXRbetXZTJyuKMbWbYXaf2U5GUSxqlWqthFUjtFAly7ldqq5B2iEvh1cQwhORsGM2aN4ATIyvae/DEihGLFvVnuaxjpH5LOoW90BDb7XloGJrb3cCXBl/8ZtJ3IcaL8I+FFX7Ys4ldWa8ZOfHONKduOjbBEFo9vNox1ImxXB5ib1puAqTgoWG3PdSLTvvXVVXYmWGF2dsJWa/f/UOV4/E2+kqPXnuR4IQjKVGPXYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPxn4lFw/7q3EtR/E2VlgsuRtMiWiNdXGSkolgnnTLg=;
 b=ZvMs4EzDT/x+EvchuUrqyfONerxBN3LQCLvFhndVclffEG/xxcfIq//Q690K/5H64K+c813bk+QbHw9L2reYJwUOD7TXFOIrIOa8lvYWZZvf5ZNDsChbo1z2/C1/tb+HsAdWdi7pssm8yf7TUIeTacprJP2zWy1JrTPOM+nt9WkFkblZKt8PKc4OGqL6dGYoD5NR6Gw9FpY4swctKlYIZd6MkkFN0PLBbngY4p20JRMgyqNgYTz9Nyg3FnoMzNcb44UO34wfadPqHSMo07+dPq4oy8zm/MdLJlId/tqqQizkrfamzK3ANKM/lKSZYapm1s/4Hh1bGRZO61yNFKJt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPxn4lFw/7q3EtR/E2VlgsuRtMiWiNdXGSkolgnnTLg=;
 b=KNLtBh91XTG8HyZyZfuQY/ThzfccWKAVVk3DXWcUUhUp+EM/kZC/qmjzjVbg6ayliQCPlwQXVrdN3Mz4SHEkptSzv5QCK+hu/Blqc6dpQIptjBnHhIK1OtVM6Pxr2VX9sf+rTwzEetpsxdumLfgQQEDxlwNwks4Buoz9Yx2XkSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 10:40:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 10:40:03 +0000
Message-ID: <efaeeab8-233c-418a-bdff-f62abc7d3fbb@amd.com>
Date: Fri, 14 Feb 2025 11:39:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
 <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
 <3f6de080ac75fc0988d371e71072cba5d60e269e.camel@mailbox.org>
 <e0a3e8de-2e90-420d-86c1-844f86ebe319@amd.com>
 <19b8713f-8563-4a5b-bd05-e3d507538acd@igalia.com>
 <493a3f35-b5a6-401a-be78-de19cec6ef44@amd.com>
 <b0daae97-386c-4d79-bfed-400927b377b4@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b0daae97-386c-4d79-bfed-400927b377b4@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bf2ac9-eda3-4ff8-cc5a-08dd4ce3f0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFhVRUNlakdvTlU0Z2xqOFN1bWRXcFBxamdPcTJZZWR6eWpZNVlBQ2h6Vno3?=
 =?utf-8?B?c2VIOFV6UUY2R0ZHbnlLc0RSZzNRb1JwSVNqeU80OGwzWU1HVTdiYXQzNWc5?=
 =?utf-8?B?NTZURGI5YnNsTzZZN1NsUXVMUjR5TGM5bkdLVXlxa0NOZ2dFNlpzUllqdW1y?=
 =?utf-8?B?SjJQU29FcnVyaGpZWnZZRDdkZmNjWGJEdjNBN3VjVFVDZnNoM3BMak15dE9o?=
 =?utf-8?B?enlqUlJESXdROWN2OWlzRUJzWXlnNlM0NXVla2RlaVp0STJtSHdiMkNrOWQ1?=
 =?utf-8?B?WlNkRzQwZU5lYlZiRGljalRTdGo4ZkJ4Y08vWmd3bytjK1llZFFLK2w2SUVm?=
 =?utf-8?B?ZE50VTJLay85cThUQkppVk1Gb3ExcHgyaUlsZElLMWRaSXlKRXlUUjAvUDBN?=
 =?utf-8?B?MnZFR21BK0dQS3lGMHR3UG9xeE1jVmcyY2VzRy8rSTR5OUY1U1ZUOVZBWEt5?=
 =?utf-8?B?dkdWMUltRStoNUR0ZTBCdlBXeGlUZ2ZVZ0tMeTc4YTYxbDR1aU1OTXpITi9q?=
 =?utf-8?B?czBBYUJQS1VmeXZJVnA0dFVsejM3MjltWS9uVnJkdU9ZU1g2aFgrMklrRDA1?=
 =?utf-8?B?aFZUR3pPMTkyTVBTWHVzRG9JdTc3SUFTRjdXTldSbHgwZFVqRmZ3eEk1QytW?=
 =?utf-8?B?NGlpWHZQVWtGdTJtSUMxZGJJaEtJWlFmcG1uMEtrNXF1bUdUUkpDSC9aUnUv?=
 =?utf-8?B?TTgvOEs4cmpPNkJ5cjI2eUExaE5KTlJTOGEyT3kyMFFxOURpdFBZVGVTeW5y?=
 =?utf-8?B?cW1aWVk1Vzk0TnB6Z3ZsVkpPU01JZ0hTZ2FxbUZGL3JacFJhNlF4TjNieldY?=
 =?utf-8?B?blB2RlZJN2RmWTNBZTNmRDNhY2FERHp6OUVhRXYxK1JQMWg0ZzFDRkJDUzg4?=
 =?utf-8?B?bFFUalBGZC9MUXVkV2dDOXJ2eEc4SVZwZHlvWWt5YzNIcURqcFhSVGp0WFVq?=
 =?utf-8?B?bUVUTjZRU2dnTk1ERXJtNTAyb3BkeWROZVpqNjBBMVZVVjFQeHlCVXIzN3Rx?=
 =?utf-8?B?Zk1YN2NFUndyTDUwSk1mclJnMlpjbC9tcDBGV2ZYL21oSmg3eFJMSWtITE9l?=
 =?utf-8?B?RXlBSWJ0K01NTGlJcFdKYVBwMWM5dWh1YmVqVHlQRHpzT1JpYUFhZEs4YnRm?=
 =?utf-8?B?ZkRueW9GUjZxUVo0Rmt6Ukp5WFRMSHhxeGlVY1BySGQvNmFOOUE3dm43YmZH?=
 =?utf-8?B?TEFvalZSRGdUU0d2SVlrSmlQei9JVS9oSTcrTkZQQXFpUWk3QXU5RndtWDlZ?=
 =?utf-8?B?MHg2RnBQRTJnNWdhV0k4c0t2b2lVL2xLYW8vb0dhVUtiaUlROFFxSjhnSE01?=
 =?utf-8?B?Sk1IL3NmdU5NbXgyT0IzRUJvWDJzZzI4eDlGMkpUUEdnUE9KOHpNdXVFVmk5?=
 =?utf-8?B?azFUWWRBcVFUWkJFM2NRc2FsWFYwdlpRQkJJNytYVTF2LzMwbVE4R1BNTng2?=
 =?utf-8?B?bXZqOGJXZG9hTGdEWTA1RzdDNlFKSW5oRlVFWnFJUVZMWTJHQ3hBa3FSYnhT?=
 =?utf-8?B?Y0Ewc0tKRkZ3ckRXZ0lKejJTa3d4T3pCaWxyZlBEWTk4TlFxV0ZRSndkSUVU?=
 =?utf-8?B?QjFXdXFMYTF1N1A0RHRPQlpCb2Z5V25wb2dJYTFUOVBVamdIZXFQNWVoMGox?=
 =?utf-8?B?c3J4c3Y2SGZHdGlyY2V5eVZnckxReGpWN3luaEZKZWs0MkVycFBaT3V1WHVE?=
 =?utf-8?B?aEVEMUdFd2s1ODEvcm5yRjJzK2dKMFZKbTZ4TFd1bitIYVU5V053T1VvNW1P?=
 =?utf-8?B?b3VUcTRaRGVrUEVPVkNQTmY1QUdreDVKOVJaZ256MzNsSWZkTVFwV3ZneDM3?=
 =?utf-8?B?TXJEdnBvOTZHZkJvMGpISi9XL0RUK2ZrQ1dndkJQZmxhNGtJZmVuV2IzZ05R?=
 =?utf-8?Q?Qleerx+LDlFiW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNQNk91N0d4OXJJWVY4TVVYTHFaclIrR2V1eDM3czMrZjRLUXIyekViWjkr?=
 =?utf-8?B?L1poVHpRSDdrOWd0eUllcTR2OStPSzk5c2ZnNXZ1SENrcTJId3VnUnZUZGU4?=
 =?utf-8?B?L3A4a0F0eEVwMTNGalNwM29qeGtpVjlnQ1N3NXI1MG5aRlZkU0hUVkRlcG1N?=
 =?utf-8?B?SnptZk9xZkphN0tQRFNFQjQ4d1pZU0hsZlpXeTdLLytnU0lLSzM1RUtiemU2?=
 =?utf-8?B?dTVXNVd5OStuL20yUW1QZ2U1SDlrL0krOENCZEp4TDJhYlRwK0hNSDZSSDBm?=
 =?utf-8?B?alE3Z0lWU1kyeFVMaC9LSVZtVE5pWmE1djBVb0xpMnkxTXRyU3lVYzAxeWhn?=
 =?utf-8?B?Nkh1MFRkdGl0RjNod3hSZ3g4bzYzeko3eExoNG9HNmQ3blEyU0lmK0ZGVGVz?=
 =?utf-8?B?Q1hnejZjc2kyQjk4MkVRYVk2OC84L0ZoUE1UWTVQd21ISyt1Y3lYVXkzSGZR?=
 =?utf-8?B?T09xa2RWekhBVG1XU2E5S3dZQWpOampDbWV0NUIzK3Q3a3lFc2NLNWIzMzU5?=
 =?utf-8?B?WGFERVFoTnRvbUU3MWUxZ1JaNEcyN1lnYUFHak4wUkdUSjFQdElOa3A2WUFB?=
 =?utf-8?B?Wm1STUlLbFd5bVJ2SVd2QVVpdlU1dTNNUGp3SDlhN1VjcEF4TldrbmFaKzBP?=
 =?utf-8?B?dmo5bmk3ZitNVHF3V2xMR3lIVnNWNVFFaHVGTVdKczhJNGppUk1rZnpCWUs2?=
 =?utf-8?B?UWxMNWMzQmg0Tyt6cmFRNUQzR2w5OVJjcGZaWkJjNlBUK1YxNFFqU1FFS1dD?=
 =?utf-8?B?TEpYbmhjdVZoOXZLZ2dCbTdTVWNkK0VuQjRGaTcvMHk5NmtJZWZKSGFlT2V4?=
 =?utf-8?B?VlVNbFpZRk55SlBLSDErVUV0dExEL0E3OU9JdEhyMnlrUVh3S21rZzBnRFFl?=
 =?utf-8?B?d1JhZlRWNEN1eXR1Q1p3aFIrWlhJbmZMRG90Y1FZRllGTkVsTVBabUpxTUp0?=
 =?utf-8?B?VlIzWWttays4Qm9rbGpjTmhOYkF0WUVwZ0F1T0JhSUE1V296MUluVkxDN21k?=
 =?utf-8?B?WmhsSUpRakIxcXRQUUo1b25UMjV2QW1sVXhxbElJZjkwUWZLYWRwbUJ6aFlq?=
 =?utf-8?B?Yi8vdkp5UXVLa3orUUI3ZTRxbjIxZFZwUjYxa2J5dnB4bG1vVHk2S3Z5RjVl?=
 =?utf-8?B?dWtTZW9VcUR0Y09KN0hlQk1SL013OHJjU1cxZlQwSEYzNXdLRlcvZmdmVXRF?=
 =?utf-8?B?RE1UT2dWNU9LTk5QWXpzQ3FrQmFmcjFTeFBmS0VNY2NQR3RraFRiSy9acW5w?=
 =?utf-8?B?UjVzUWx5alRnV1E5VlpsVlc0MFNMVUVGVnllL1FhdHVrd2o0NGVrSWR2VkV4?=
 =?utf-8?B?eXNLQ0Y1bnA4MUFQK3lxaktLbkRIMVV0MWs5TzlkaE10ZnhDUi8xbThndlk1?=
 =?utf-8?B?anB4NkdvUjBqSWZVNzFoV3FsVnlNVkZzU09GdlB3UHo5ZC94TUZoTjB6TzBv?=
 =?utf-8?B?S05JSVFCQVVldXZESTlFTkx1endiVUxRcGY5Z211ck4zSytWOUFTSkgrTDFl?=
 =?utf-8?B?WG1JYnorK1FTc2toMERsV2lDdEVGdHdQTFFYTFNPREs1bXBFUVRIMm1BeCtj?=
 =?utf-8?B?d0Q1Nkx5am5qbzc4Z2xjTUJXZnYzU3B2eHpUaE5OMHhGeXV2aWE2eTlJY1hT?=
 =?utf-8?B?UHVYZkJyVG0yNTF3bUFvZ2ZhQ2gzSEpUQXhib21RZ2Z4SXJGcWp2bVhndWo0?=
 =?utf-8?B?L2V1TkxOZFFlSGVyeXVJRlZHL1B0dFUrdkpDVlgwZDcwUHo3a0FyVGpmck9m?=
 =?utf-8?B?cmRGVG1Gd2N5NksvSkZVbEVCTkt5L1FFT2RRMWtnc3oyay9ja3JMcTF0Ykwx?=
 =?utf-8?B?dzdzdHI0MXlLUWJJTHlBR1o4cmY0TngvNnRMaUtZQW0wSkQ5UWVhWElMK3Av?=
 =?utf-8?B?WHNIdVBSWGs0anJuMkxmY0VhSS9QTExUT0NkWFZaVnZrelRZVHJxcDJ3bWZu?=
 =?utf-8?B?a25mNTllMXV5cTR1a3k1bnlJZ3BlYjc2R25YU0VDeUdjL0FUMk1kZXVxMVNh?=
 =?utf-8?B?ektPRmRJVDJKWUZxaGxkVWdHUTY1cGxOcWQ1Um12aHZPcTVwdTJqYkEyYVBa?=
 =?utf-8?B?b2RzQXY1V0FRbFhEeDVDMm1TMERialJaaU9XZkdjcHg0eFFYQnJCQ1JOOFNn?=
 =?utf-8?Q?SE1Ux36gQ97O+s3++n+fBYSbe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bf2ac9-eda3-4ff8-cc5a-08dd4ce3f0b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:40:03.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lAw0whDrkcEsGYWF508A0sFzWGXGGTp0DAuzNEbCYnC+wOY5xZJG6QAh+VYkxfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

Am 14.02.25 um 11:34 schrieb Tvrtko Ursulin:
>
> On 14/02/2025 10:31, Christian König wrote:
>> Am 14.02.25 um 11:21 schrieb Tvrtko Ursulin:
>>>
>>> Hi Christian,
>>>
>>> On 11/02/2025 10:21, Christian König wrote:
>>>> Am 11.02.25 um 11:08 schrieb Philipp Stanner:
>>>>> On Tue, 2025-02-11 at 09:22 +0100, Christian König wrote:
>>>>>> Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
>>>>>>> Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a
>>>>>>> newly
>>>>>>> added __drm_sched_entity_queue_pop.
>>>>>>>
>>>>>>> This allows breaking the hidden dependency that queue_node has to
>>>>>>> be the
>>>>>>> first element in struct drm_sched_job.
>>>>>>>
>>>>>>> A comment is also added with a reference to the mailing list
>>>>>>> discussion
>>>>>>> explaining the copied helper will be removed when the whole broken
>>>>>>> amdgpu_job_stop_all_jobs_on_sched is removed.
>>>>>>>
>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>>>>> Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>> I think this v3 has been supplanted by a v4 by now.
>>>>
>>>> I've seen the larger v4 series as well, but at least that patch here looks identical on first glance. So my rb still counts.
>>>
>>> Is it okay for you to merge the whole series (including this single amdgpu patch) via drm-misc?
>>
>> I can do that, but don't want the scheduler maintainer want to pick them up?
>
> Sorry that was some bad and unclear English. :(

Don't worry, I'm not a native speaker either and had only very minimal formal education on it :)

>
> It is as you suggest - what I meant was, is it okay from your point of view that the whole series is merged via drm-misc? I assume Philipp would indeed be the one to merge it, once all patches get r-b-ed.

Ah! Yes of course it. Feel free to go ahead.

Could only be that Alex runs into merge issues, but that is extremely unlikely I think.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>>>> @Tvrtko: btw, do you create patches with
>>>>> git format-patch -v4 ?
>>>>>
>>>>> That way the v4 label will be included in all patch titles, too, not
>>>>> just the cover letter. That makes searching etc. easier in large
>>>>> inboxes
>>>>>
>>>>> P.
>>>>>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++-
>>>>>>> -- 
>>>>>>>     1 file changed, 19 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>> index 100f04475943..22cb48bab24d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>>> @@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct
>>>>>>> drm_sched_job *sched_job)
>>>>>>>         return fence;
>>>>>>>     }
>>>>>>> -#define to_drm_sched_job(sched_job)        \
>>>>>>> -        container_of((sched_job), struct drm_sched_job,
>>>>>>> queue_node)
>>>>>>> +/*
>>>>>>> + * This is a duplicate function from DRM scheduler
>>>>>>> sched_internal.h.
>>>>>>> + * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is
>>>>>>> removed, due
>>>>>>> + * latter being incorrect and racy.
>>>>>>> + *
>>>>>>> + * See
>>>>>>> https://lore.kernel.org/amd-gfx/44edde63-7181-44fb- a4f7-94e50514f539@amd.com/
>>>>>>> + */
>>>>>>> +static struct drm_sched_job *
>>>>>>> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>>>>>>> +{
>>>>>>> +    struct spsc_node *node;
>>>>>>> +
>>>>>>> +    node = spsc_queue_pop(&entity->job_queue);
>>>>>>> +    if (!node)
>>>>>>> +        return NULL;
>>>>>>> +
>>>>>>> +    return container_of(node, struct drm_sched_job,
>>>>>>> queue_node);
>>>>>>> +}
>>>>>>>     void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
>>>>>>> *sched)
>>>>>>>     {
>>>>>>> @@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct
>>>>>>> drm_gpu_scheduler *sched)
>>>>>>>             struct drm_sched_rq *rq = sched->sched_rq[i];
>>>>>>>             spin_lock(&rq->lock);
>>>>>>>             list_for_each_entry(s_entity, &rq->entities, list)
>>>>>>> {
>>>>>>> -            while ((s_job =
>>>>>>> to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
>>>>>>> +            while ((s_job =
>>>>>>> __drm_sched_entity_queue_pop(s_entity))) {
>>>>>>>                     struct drm_sched_fence *s_fence =
>>>>>>> s_job->s_fence;
>>>>>>>                     dma_fence_signal(&s_fence-
>>>>>>>> scheduled);
>>>>
>>>
>>
>

