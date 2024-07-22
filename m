Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA5AC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1908410E0EB;
	Mon, 22 Jul 2024 06:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J4+MtZDu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33EF10E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1BkSU3RcmCEWZuorN4RO6tQSA+fjDpnnl8dq3F1P6kGjv1dQSnoDyNS20JnOdkeuhoV9Igay2QAGyU5KkhjPGO72T/00XFtd6601BPjEl1ZM7ajOOl7FlL1H/NOwPbSj/MgxHFU1aoh+gldPNF8NNTKJIt2E/q2nhXDtQClKQMS7tPMrMQWhkS7FAEiz/VeOJInFRBJwaR9LvgjKGocIm8vxMTAAiELoqTUWVJjqSIdV+5PhPJeR3ygWCKOjMXi7wi75UZjxVl795J0u5XB2NuRPlT8CM5VtmU9uQkxAWD5P+8PQQl7EGyFuW0/9R3YmstxVlDkddCRqRFafC43PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79Y9lpVRUCgCS4kmPDEBgQfpne7dVgzUnGB8aVGFP04=;
 b=F0Yj/FL3f2jR62cciawGr2mfzDK26AaCTTS3C0zBQV+Z9qEbsbAcJ8b9roxO4qE1+gY/HQsQRNDs4WEOtw5LuzjFqtnej1xFW8APX+7nKfKpuPrNTxGeCZhgr2giJrll8gqp8A/gtQ69l+S/XieoKc1w0orJLv+3VrjjDsJtdehLU/mAlLg2fRJdbnnrwKCkNEcJ9DhmsGZ9w+RmX3OIHJnPuf/miERoyJEVBucEhJ48XUMF/m2UDVFVdBM3oxCNH7gfsKeO2R8q7A1I9DlwkUicnmH/kRh22jOGGYZBMZhWN78QWoY1qCAAWpydT67GjMu/N6kTsE1wktKz5HpRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79Y9lpVRUCgCS4kmPDEBgQfpne7dVgzUnGB8aVGFP04=;
 b=J4+MtZDuqbQweHrVX75u7G9bOMOOf6EsShFWjzGmVbmjYRhVCwgtmOExlV6H1QnO6fGN2zQzxuXH8K2QBGWHU0KChlEWEsXaO5AYF7KOiFX4T0Uj3RzLGWBAawA1d+Dhy2eghWViu5FNSVAF5Udd3aWns/NKuBkqkBq66X2wI4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 06:40:29 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:40:29 +0000
Message-ID: <2623ca22-2ebd-49d1-840c-279a3e8aaea4@amd.com>
Date: Mon, 22 Jul 2024 14:40:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null check for set_output_gamma in
 dcn30_set_output_transfer_func
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Roman Li <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
 <20240721062216.3151119-4-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240721062216.3151119-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4607a6-7595-431b-8077-08dcaa192d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clFuRGlxMCtCV3VnUlFLMXJrbmdIc0tEU3B4SnFJTE1WeUZxRnlaK2pLT3NC?=
 =?utf-8?B?YnRPNng5SmRmVHIwekU2ckpBd0ZFcDBJdkZra1RTMUxqc3BiQXJBTzFBYytn?=
 =?utf-8?B?TlF2SDRCWUMyazltemFxajNnSzd2bGFLaVEzMjlXeHkwbmtKR080TGJ0elV4?=
 =?utf-8?B?bWxUdDZtcjRtMjVGQTNkN0RYek9DUlNmTVJUM0Z5MEwyZXNEWERvVTJsbE5a?=
 =?utf-8?B?UXFtS2V3SkxRK0R0bXNrZVY5NWlPTWV5SW4rK0Y3c3dBMm5YMTc4RC81djF0?=
 =?utf-8?B?VURTY1VkRXllLzBhTjRTWmw3R1lVS051UUtnUCtjZ1dUNTZlYVJEb2xVQVcz?=
 =?utf-8?B?bkVHQUFkKzBKa0Q0bHA0RTZFY0ZjRHlQVHgycVJ3dEJSZXRma0lYT1NOUVU4?=
 =?utf-8?B?czl5SGJ0b0JOWGptamFxSGNlclNOV2hTYWtMU3ZoOTBVUWwvYWswRzNxZHd4?=
 =?utf-8?B?czJhZ09rKzF3OXBVOUxrZnJja05zNzlzN3FJanpuS2tLbXlLMnhWQ1Q2UktY?=
 =?utf-8?B?bmRHaVZHVTN6bVZEQnZtZC9FYjNTS093M081bU5aY2t5eEdhSFhFWCtweTFh?=
 =?utf-8?B?end6czNLcjJ6QmszR1pKSkRmdWJkanBZUHdRQ1FpTjl4em9JblFHbFVaUmw4?=
 =?utf-8?B?SVlxMDJQSHVuQTVTU2c0QndCUW90SFAxNi9QK0kxNDVQaUZPNjBJRDdvc25y?=
 =?utf-8?B?VE9UL0VHZ1EvaUk1WFZ2ak9oT0JDTmNxelVmbEZmeU1GSERFeXVCTHB1c3hC?=
 =?utf-8?B?U3FmUnl0bjVsY2s5L1ZGTThFcGNqM1FVMDh2VXl0SWZxeDdMSWFOOWFUOVkw?=
 =?utf-8?B?UGNxQjVBQW9JanQ5M1Jwa2U2UkY1MDRoT0h0WHEyZWUvekZyZEt5V0VyTXBx?=
 =?utf-8?B?MENmdm1XMFBKSHJobkdGT3hTdmpzZTY5dWNWME84WDhPaDg0eW13QmtxUkRi?=
 =?utf-8?B?SVVzZXRjeHhXcVhTUXNRSGluWmZwa2lHa1hxcUU5ZlNzU0lsZHp6NHdoU0Vw?=
 =?utf-8?B?S1Z3dlYxckIvVVNtL2RKWUZTaFl1Q1J4TDFPMDBkOStHVTZnL00vNSs2djZR?=
 =?utf-8?B?NUhFRVB1M3pKNThuVUpVSDA1NFkyMTZSTlY1V0kyby9OSlZTMk9kblYwRlU1?=
 =?utf-8?B?MEJrbEkzRllhNk5iMDlUYVVXUHpnOFFYaG5HZkEzV21vVDJBclQ2MlIxY0JS?=
 =?utf-8?B?NzhnY0xJUERKdUY5VFlDV3ljcm5iVVpVQlIvOHMxYjYwOUJFeUovRUt3TjhI?=
 =?utf-8?B?Q1NVTWprYisvaWxDbzlFQ2czUjk2Snc4b01GcGlibTNxc2N3NWhDSEk3MXZW?=
 =?utf-8?B?L3ZmZkpuc3VNS3lrdTQxQzRjS3ZJa3lyZ3VFUkgxWWg4YVBPNDgxMHgxdmov?=
 =?utf-8?B?dVA4WXV2Z0dRc2Q0emlLYXBLVjNWRTRMbVdDZWFFZGY4eUpxL0xoam44amVX?=
 =?utf-8?B?bnduVmxTd2FOM1VtMnVTSWZJbTRrVFlKbWpFY05vdXErQ1krWTJQeksrclRU?=
 =?utf-8?B?bDdBNzVscHRWaUEvaEFhYUpKVTRSRGJJNks0VzA1RVM4cGY1QUFnSC9oM2pj?=
 =?utf-8?B?MGVNQ0VnTjZqWVNZVFlaZWdGOEhlcnZmL0pVZHZ4ZXNncURTUEM4V0M1YUtZ?=
 =?utf-8?B?YVdIakVMWUp2UkRYRUt4ZWQ3cFlxUHI5Z3RvRjZIVHZkQWpGZ2oxOWZDaXpD?=
 =?utf-8?B?TnV3MkxVclNwNkJ3NHZWeTdYVVVTS3haT0JRY0hOL0xZckpOWGk0cngyWFA0?=
 =?utf-8?B?SDRhajNqcEVCZkUyYkE4N09TMzcvRVRqM1lyR01HcUdRMldiM0RndVBabzlQ?=
 =?utf-8?B?b2dZcXFpbUZVVTNHckFDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZRK3dFMHVHMW5uVUwrTmtueW5HWHVjRHNQOFY2eXFJdVZtNHNhSWRaU1dU?=
 =?utf-8?B?Ykh5c2tQdTNzNW11aDBZWHlwUXdwaGhCRzhuZEZmZ0JmV0ErNnRUdXdjZ21n?=
 =?utf-8?B?byt5SEFLTFd3Nk0wN3RyUUtBZkFFWDBpNkJhVEttZmJLaFgyUUZuV3lzYWJ1?=
 =?utf-8?B?eCtsZVh5KzlUQlNpRTdKbmNLdEl5enprTkZvSVFtQzd0SWFSSUNOc2YyRmIv?=
 =?utf-8?B?QkN4SUc1TFM5L1dKNUc4VDZPbEo5QzBtYWtHWmo2a29kSzFRdXR2NTFISi8v?=
 =?utf-8?B?aXI0WUN5djNvK2EzYWxSaW9UbUVRRWpkUG9sK1h0OE1RVjRoZEtidFhNQXdC?=
 =?utf-8?B?cVhtODUzQzdyN0Z1aVhaTG92UGNVT0NFLzBsQUlsNWpTaHVBeDBsQ215ZTRs?=
 =?utf-8?B?SUd5L0pMQUFXU3hmRTBrTXMxVk5JUWVXNDZnTkZaOCtHYVp6V0ZIQys1OUJ2?=
 =?utf-8?B?bG05bEkwSGszdy9aTk8rTythU2U3dk5TVk1NZGl2ZDRVK0hrb21yN0NocHJw?=
 =?utf-8?B?ZFg4ZWRkTmlYSUJzRTVZTitnT1YyQU82RTdncTVuSnl3VGJmNVliRFJDd1gy?=
 =?utf-8?B?ckRldWpwMXVERGdJVDRSTTFManAxZlpQcVh4S1I0dHN2UG5zeTlFdGlhZ3o4?=
 =?utf-8?B?bDBKMTQzS294aEpubkx0T2hwWWtLMHlSTVFEYUtJakh5Kzg2UFNHQzI3aHdx?=
 =?utf-8?B?ejc5YWp0ejB1WlVRTU9FZ2s2ay9Zem9TUlYrVC9pQXJHeElLbVVCYlRsVjRC?=
 =?utf-8?B?VnpzM2tSeDNxV3Y1QjlVQXhiK1JQdEdPeVBBcy9zdEppN3NjaytCalhRL04v?=
 =?utf-8?B?N1JkY0NoVS9CSktCK1lQREI2bmhPSmNKMEhMN2UycmtVTGtpSGJvWmh4SVZT?=
 =?utf-8?B?V0lVOFZyL1h3cFhvd2pwUFJ0K0tqdzk2VWtvOU9OS2ZMVkROKzQyelJXbW1h?=
 =?utf-8?B?VTRxM09DeC9IRG9pbi94UlJrYkFDOFlBV1ZJbjBXQW15U3c2UlJzU2g0SHRV?=
 =?utf-8?B?RzJ1cGIrTzRFdHVKQ3o2Z2dFdVBxM09Tbm42RzAzTzFGY3VUL3hJRmY1MWlK?=
 =?utf-8?B?RnFISGk5M1pqMXY3Rmx2cUd6OUhYUHVWYm9XNVlvU3k5WndYVEFSY01PTGdJ?=
 =?utf-8?B?ZWpoVUMwSDhRcytibXhZUE1FemNwUVFVeW9UaDdhZGVkYnZmYkFwaTN4Z2d3?=
 =?utf-8?B?c2VCTXdLemJaUTBUYmNpY1V6VFhJMFQ4Zk4xSUFwRmtMRHpnWjJScldlVTVt?=
 =?utf-8?B?Z0RiakFnbjJ2WHFTSXQzOFF5bUYvWDVCdm9KVTdxWTFObjlYNjJ2d2hzTFBJ?=
 =?utf-8?B?LzJEblkxR3hHUFZaTWtIcXFWdkNDVjJpRXhKNEQ0VmY5VGh0N2xITmRjMndq?=
 =?utf-8?B?WlVXVU5hRHpRMDZsNVIvOUVRTHoyUEpwZ0xEV3dwNy90d0lWU1FzRnI5Mldx?=
 =?utf-8?B?alkwZW9ZQ2VtNHVLSElrb3RLcmxONnpCbmEzdDAyWDlzL3lEa0dHZ0dkS0FJ?=
 =?utf-8?B?VFlUb2RPYWNPeTEwN0NjZk0velVzMVZLTlZ6TFhnS2N2cFlRSGxzZm5qYnpJ?=
 =?utf-8?B?Tmo3MEJRL2hjVkdHQVQyeDR3RmNhaXpCSjVDWkhhOWVKdUoyemt5RnZqUkEz?=
 =?utf-8?B?eGU1VmhiWS91QVR0ZUl4dEVlOEJRK29mTEJXT0R4d1lUSlhjQkN3aEpzT0xO?=
 =?utf-8?B?dUs0Z0U5VmE2NmEyRkVCWkdnOGNWYUJzRkI3L2VWMW03b3VRbm4yYkEwTy9J?=
 =?utf-8?B?Y3NDMmtxczRSM0E5bVFCK0ViaHNpVUlIY3BXMERXWjdqTW9HQXYyNnR6NW5j?=
 =?utf-8?B?bTNDYUJPdzByNUs2TUJ1T0F4QzBueGpTaXhvdFVXaHFTL0szR1NMV0FQK2VP?=
 =?utf-8?B?T0dvWVJSKzdmUHNoLzI3eXBJM3BwK1RHZGZpTkpGWmp0S2x3ZHBweXdYdnpH?=
 =?utf-8?B?N3lRTGFFbFc0aXlBN0lLb0tWZkdPOFBOSHRHU2V6czJPMkw3eFJYNE9VL3pn?=
 =?utf-8?B?Z2xUd0J1cVFWUndsY1B6aG9VNkpRK3JCc1pGVFNUSm85NUtGVkp6aVAvNVBx?=
 =?utf-8?B?blpjRzV2OWJzZTlGSEprSzRxS2Urdkx1aUtOeGZnNmgvdFhJRFJoN29NWE5x?=
 =?utf-8?Q?CO+jKvADm+cy/oPKUYM7JqeRh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4607a6-7595-431b-8077-08dcaa192d2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:40:29.1192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8uACjz++JVOjS0tMM8BpC+uPNhYvuAK7coQQjG3Ex4Bz7NKu9feYYl84lM9NYltuwL5rcZUAQzSi4HfPiMBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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


On 7/21/2024 2:22 PM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the set_output_gamma function pointer
> in the  dcn30_set_output_transfer_func function. Previously,
> set_output_gamma was being checked for nullity at line 386, but then it
> was being dereferenced without any nullity check at line 401. This
> could potentially lead to a null pointer dereference error if
> set_output_gamma is indeed null.
>
> To fix this, we now ensure that set_output_gamma is not null before
> dereferencing it. We do this by adding a nullity check for
> set_output_gamma before the call to set_output_gamma at line 401. If
> set_output_gamma is null, we log an error message and do not call the
> function.
>
> This fix prevents a potential null pointer dereference error.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:401 dcn30_set_output_transfer_func()
> error: we previously assumed 'mpc->funcs->set_output_gamma' could be null (see line 386)
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c
>      373 bool dcn30_set_output_transfer_func(struct dc *dc,
>      374                                 struct pipe_ctx *pipe_ctx,
>      375                                 const struct dc_stream_state *stream)
>      376 {
>      377         int mpcc_id = pipe_ctx->plane_res.hubp->inst;
>      378         struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
>      379         const struct pwl_params *params = NULL;
>      380         bool ret = false;
>      381
>      382         /* program OGAM or 3DLUT only for the top pipe*/
>      383         if (pipe_ctx->top_pipe == NULL) {
>      384                 /*program rmu shaper and 3dlut in MPC*/
>      385                 ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
>      386                 if (ret == false && mpc->funcs->set_output_gamma) {
>                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this is NULL
>
>      387                         if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
>      388                                 params = &stream->out_transfer_func.pwl;
>      389                         else if (pipe_ctx->stream->out_transfer_func.type ==
>      390                                         TF_TYPE_DISTRIBUTED_POINTS &&
>      391                                         cm3_helper_translate_curve_to_hw_format(
>      392                                         &stream->out_transfer_func,
>      393                                         &mpc->blender_params, false))
>      394                                 params = &mpc->blender_params;
>      395                          /* there are no ROM LUTs in OUTGAM */
>      396                         if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
>      397                                 BREAK_TO_DEBUGGER();
>      398                 }
>      399         }
>      400
> --> 401         mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Then it will crash
>
>      402         return ret;
>      403 }
>
> Fixes: d99f13878d6f ("drm/amd/display: Add DCN3 HWSEQ")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index eaeeade31ed7..bd807eb79786 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -398,7 +398,11 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>   		}
>   	}
>   
> -	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	if (mpc->funcs->set_output_gamma)
> +		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	else
> +		DRM_ERROR("set_output_gamma function pointer is NULL.\n");
Maybe we should use DC_LOG_ERROR() instead of DRM_ERROR() in here.
> +
>   	return ret;
>   }
>   
