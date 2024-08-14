Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBB5C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 21:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF74910E25E;
	Wed, 14 Aug 2024 21:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmdkenNM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AFD10E25E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 21:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfE7bRgIZt0g71uFwUXxKr3owjiDv0XaiLr+CWTF04oYCP0U1D3DFnUw75zO/0RTbN5tPhpv+xlTKBhhBma6vzPB9+0odevMpKj/7I/dKrJplkc32M8uV5e3f5bu+lrv8HyZ/+lCDewV2+NT0NX+mORrwe9PfcXu76J/1wxXD42JY/sRWoTtMFUQsvn5LY49et8AuCEoc0eCpyculmOGUFyWVUgEGHhNR46VS6EXSlagyIuU8LYLp1eAYS9CvfiMLw3/tMrv1RQNK/fvGVFFBwgsIV5dJjpFwhGevDXZfDu7j33foTqB2c6Orcw8tuUc1GOSGHnoH9NipbsxLRBRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsfwCqGNd73EwGRsJ8e+r/LK8glzPaTSXM/ZX/XQbXA=;
 b=mK2kf3vZjf1j45jsmDD+ioJ/yaf7KgCnDe3QWn/2ktjIgLAjiJtm1Zk+m/VHlxIs+AtLseVQGdqcSQ0h7JfWQGCKEPNkeDU0K/WXrAGW8q+5Q5E0Dtt25FYSFw8FcJN6289AZ5qqfOfmIRGQADzsJz3kAGm4sxlsaHLnNSZmvVe4kh5Gbv1XbaDj/T+2EH9k157gTmKJwqYLPogOjzkKMLbclWhCHhD6KVTBbD/+iJzDwZclpfaC3f3FIJSmnqYsCY8hMOSTFHYo0ovjynH6kkTDaqW681lOk9uJeo+yA5JYtqbS4C5PBjmvDc4xdTrAolqoEaPv41J8YBVl3zfslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsfwCqGNd73EwGRsJ8e+r/LK8glzPaTSXM/ZX/XQbXA=;
 b=DmdkenNMlzpafU+mPlzB2/gwi0md7ZEqgL0T5v+WK2YcKIz29M+QQ9gw2TdhOwoFg0ctoxcRo5revv1CgaqTaCZDvgJZUFh4zzbUgHUtwxPPuxsTC6XxQj3Ue+9REhfzlz/kO5BnMkYghRG/VU1DZqxjKpcveHE44Pyrv/nkJGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 21:53:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 21:53:14 +0000
Message-ID: <f9f83693-2566-4586-b969-6113570a097f@amd.com>
Date: Wed, 14 Aug 2024 17:53:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix
 KFDMemoryTest.PtraceAccessInvisibleVram fail on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240812065929.1842802-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240812065929.1842802-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6c1494-2f40-4b72-857a-08dcbcab7f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFVTVW1TaWZBUHI3UlhtVnUzVHJTQW5ZOFlNWWoxaThoR0FoTXNOWkhPTDZo?=
 =?utf-8?B?OU9lWHBvQ2NmWU9GQlJVajVERUpDUnBaQWpaRXN1eUtKOGVzTndpK3JBTEg5?=
 =?utf-8?B?YUFrOUUxeDIvYnU5OG9GWUlCZ1UyU1dIZXFBSXBPSTdxd1VXbnVmSnFmTGtk?=
 =?utf-8?B?VWExMkxkODJEV2NhMmhRdEU3SlVXSE1ISmttQ3NYbjFqd2U0OUI1STRCMzZh?=
 =?utf-8?B?WjJmRGErMHBkN2FYUllsenRPSU8yZHlHNzJNbWNTSmV5WUVhU1dWeTU2T2dm?=
 =?utf-8?B?OE5jaXFjUVh0SzRTKzBzTGMvaHd3R0JCWnpNY2hORFRkeThHREllQkNyTDlY?=
 =?utf-8?B?SzNEb1pqTnhHUmtkSGJrM0Z5cU5DaXc3TDlaUlE2cmszZWtyek1VTFVuVU9T?=
 =?utf-8?B?Vjc3d2xmYzhFSi9RbHUvV0RmdXNOS2xVU2pIK3N0aHhTZ29MMEpWUkt1U3pD?=
 =?utf-8?B?bDg1UmozZ3JZdVQwMU5JZ1dkLzgrWkhFS0R3V0lGTXlnZVJPVFRYUFBtS28x?=
 =?utf-8?B?TFFQK01sNHVWSnpMTkZQbFZaRDc1dXF4OTYrUmErTUdaREpHWE5yTC9BbDZE?=
 =?utf-8?B?bmljVU5XcW9GRS9VVGhYOG9SQmtQNHZtWXpkL2g5c3JBWVgzc1JyYTluYnRP?=
 =?utf-8?B?Qzd0WlJBZ2RrdFhkZ0V5VmFBS2p5b1ZiTGQ5bkN4c0FZaHJMQWV6YjNsNjYw?=
 =?utf-8?B?cjJZZGtNLzdUZzNlYWdaeCtuMTh0WlZSUUhoeFc4RDZ4OHl4Qk1TY0IxZ2lL?=
 =?utf-8?B?Tyt6NTNFOFhOS09tOThpT01Gay9Fa2ZVTXV1RjlTeExtcXd4a3J2NVpVT3Qr?=
 =?utf-8?B?SzVKMXFJbzE2U0syb1lza21GeVBWTXlaVStxVHg3MHp3WSswVkZWRzhJM2hV?=
 =?utf-8?B?Z08wRW50OGdxc3dFTDN5OGVrNVZGM1laZUwrbXlnWngxNk0rNHhHMFg3dnNO?=
 =?utf-8?B?WWtEM0tJdmRhbnN4RlhjbjNSZE01QWNSREFTUjFJVmd0bkJWUTFyWDNoekZP?=
 =?utf-8?B?R2tvZk53MHI3bzIvTm1OdE1HdW90Zk1JcjBBN2xFUlExdVpMdDVnaEQzSDUy?=
 =?utf-8?B?S3FOL1FPRmh1MEJ0Qm1OSVJHOHhhVnJHQS85a3pNRkgrcTZvL3Y0M0RYVlNO?=
 =?utf-8?B?RHhGQjlKdEt4a2FJSXdJUkVNdTJDUnJrYjRuczlDWCtjSFBqSnduTTBkZzFi?=
 =?utf-8?B?Vi8zQzNYWXh4bGtqeUZLODQvSFV4U25hNzhPaGxSOFNFL2lKNEhJTDRuTXRV?=
 =?utf-8?B?R2ZuT3BxWjRONnRCakZXczVVS1NLVTNVdGllSE5SVXROK2dmVk1mdlZ4bk9P?=
 =?utf-8?B?MTVQWmdOdnJ4bmtNeWtOZkhpSzlibU1rRHM1eVI0UDV6NGZ3VWY4ZkN6Wlpw?=
 =?utf-8?B?UFBJY2syQWMxeXljcVBpbXN2b2hJYURSUmFBVVlYU0VvWENFWVFmWVR0R3RJ?=
 =?utf-8?B?eG5VbndMdElrNWhVS0p5a2xxWVNlR1FHVmxJOWE1ZWVCYXlDQVJiVUJXcVFH?=
 =?utf-8?B?VFArUEY4Vkh4d0lYUENTbTJNS2g0ZzkzVHNrL1NWNlpVMktaZFd1VU1MRFpa?=
 =?utf-8?B?czlyWXRnZkR0ZFpXaWM1TDdBN3dhMDNJREs5QWV5M2JjRkg0bTVudUZSYlJD?=
 =?utf-8?B?azdneTd3MW9BVHRaMW45RSt0RzRGWTZHTlpPOVZxZ2xuNy9yditFbWVkLytP?=
 =?utf-8?B?QjM3TExUWGlSaHJkS0ZGS29lVzBHK3FxMVZnRjY2eXJnRHlXWXZmVHZGRlUw?=
 =?utf-8?B?ZXQ1QkhDbDUyMjBicUc3MFpvdit6Y1ZTZytnNi9HSHlwUGdDWkdBRUwzMWg5?=
 =?utf-8?B?MHNrWWM3MlhkOWJmTVg1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzd5bU1GYzZ2K09RMm8xc214ZkVWZXlFSit5b2RtQjZmcWE0cmJ6TUE5UG5G?=
 =?utf-8?B?aFJSMHcvS2lMelZ4RFFScnB5a2o1dGVleCt6N21JYjg5Q21xbE4wcDU1QndJ?=
 =?utf-8?B?ZDllUE1KUytid1JSRDJ5YzZZQkdmYnVVei9jMi9VYnYzdXdnR0plQmNEZzlT?=
 =?utf-8?B?ODhHSDRHSWxXcmdoRHRSWG5vY0l4RFVKWmFMYnJnWUtkdlAxVUhmZHZ2VkNs?=
 =?utf-8?B?RGpuWmw1WVY0clY0cVlpNkxyZnM2Qit5VGZtVndGMmlaZ3hwdTNKZ0VCVFJn?=
 =?utf-8?B?SFlsSi9VR1JpaTY3MVR5SmpFWm1yMEpsaVVkQzJDYk50ald5L2FkT0RKLzJl?=
 =?utf-8?B?SUJhWVhIMFFySVVudjVhSU9qSWF6S2V0dHBIUDNqQzh2Q056YVBiMUpqUEpS?=
 =?utf-8?B?WlFmVkVlbks5UHlKRjNNQWJTOVZ1L3ZYV29ORW5CZTlhM0pGUDVmR3NtMWV2?=
 =?utf-8?B?aC8wd3ZRbVlaNnNYUWdmeHNzSEgrYkxNT0pjZlVqNlJyQUlXMk5pQXdSVDBI?=
 =?utf-8?B?ZC9kNW5KMVFkMnRHZk5HMXZHWDJvRUVEVzVsSmpHSUxkSW1VaHdaaG85Wm1Z?=
 =?utf-8?B?bXp3eVR6MFZLQ3JtWWNEdXFhMUhGNU1kZWRtL1lDVVVMMUhCM0JUb0lzTzA3?=
 =?utf-8?B?emlyajNqTUF2ZzR1dCtwWnRBT1hFMTl5V1ppd2lhQWhSOEtWMXkzWkh1a0tZ?=
 =?utf-8?B?OG5ONDJaWTZHMEovYWN5UXVBVmdwazZ6bGVUaWVFMnpLbDdOTHRwbGN1VVV6?=
 =?utf-8?B?ZDU3eUM5SnFKUFBQL0kvVEVYTWZXYjJOWk5QZFBCTEY1WmtRcExQNE9pRmRF?=
 =?utf-8?B?VVpxdUp0dFRWMmhyRzhmUllQaXdKbWMwczBKaEFBWnRsbHdRa0UzUTBRLzcx?=
 =?utf-8?B?QjRXd2hCdXhzaXZSRmp0bFNvQWFiakxteEV3VGE2M0dxdDV6enFQaVlhWWtq?=
 =?utf-8?B?NlFsOUdTLzdITENOZkVnMzAyTGFDWDdESWtwcXl2SlN5aFBZVERBd0JSanRN?=
 =?utf-8?B?K1dQSVNJaFhFbGh2NHRaWms1bVI2YlE3d0IrT0h2R1RBYjR0Vmg2a08rL0gv?=
 =?utf-8?B?ck4wM1hhcHZhZEZCOEdOLzJ0aFhETDFDRjhSRTdSNWJsRjFQeTlQRm9KaUpw?=
 =?utf-8?B?eUhwdFFtV1llWTdZNGhaRlJqYXhvdGJ3NFl0RFNjNlhNL1FFZlQvSnJUTmlt?=
 =?utf-8?B?bnZwRWh3VHYwM3ZYdjVRSXJDdUVXd0ZlTFBnclVSM29HWm04V2VKK3RyOUds?=
 =?utf-8?B?Zjh6ZnJybjE3TlRTTVF1MnNnQmQzUWFaOVJ3L2I5dWlpTVlrNUtFbU50ZW1i?=
 =?utf-8?B?cHNUNUtMTHNqSGpsZklPZWk4c0FQaGVqblpHQzNtcVVtYTJXQzVDWUVpeVoz?=
 =?utf-8?B?bjdSVkpJYmpwdW9WeDd1MWtVQkNqM2NtREVuRWF1WDkyTkxjSnZUalRpMlBk?=
 =?utf-8?B?VTV5V2VDazI5WVhxYWpaS0hkdkJLS05WcmJOWHZodHRXaURnM0YyT1dBOFRB?=
 =?utf-8?B?Z1dMVGtzcEF1S1lUbC8xMzdFRUlEWkRPaEthNnRvQmtKQjFKTm1SVDV5SHBI?=
 =?utf-8?B?MUthNGo2NWRrZ3RsYll6VjE2aS9YbExuL21Sc1pncmRvQ1hZKzJuaS8wMGxh?=
 =?utf-8?B?ZG5JUVJXc0xZUXRqaHdFQmRaUzZLUi9sVFpqdzlmc3UyaE9lck5XSEhpelp1?=
 =?utf-8?B?SlZpc1pmb1MxNCt4QU55M1BxWDlzMGVoTDQyWnBHanQ2U09KZ2F5cCtZUXdz?=
 =?utf-8?B?WElkSDZoWjNvV3A0THF4cHNicDN4QXFoS3lmb05TL0R0SDFHdENGMmVYZ09o?=
 =?utf-8?B?T3ZaTzVjYTVraVJ0bTR3OU02c1pzK0lESFdpZ29CWHVLaVVhK2M4aXJQcHhr?=
 =?utf-8?B?ODhMUGpyVEg4NnZJSG4vR1NYZXJpdGRxZTZUY0FDMkhDMnVodzUwMkQwWisx?=
 =?utf-8?B?TEd4MnpvRXdOMDlGZ0J2U2hMbHk3VEVuZ3VNWSttVFgzYmpMTm9QNTZncHhJ?=
 =?utf-8?B?RHNaejg4bTlYQTAyV1puNmRTVlh1eWZXajF2QnZmRHBMMEVHZWp0TEt5Qlcy?=
 =?utf-8?B?aEhQOXBCdWZWUFhVd0ZIOE43Z293Wk1oM3VnMmJrRU5TTy9hMkJQSnN4MFlP?=
 =?utf-8?Q?ptr9OeSPsUmS5hfopcQNIn6DI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6c1494-2f40-4b72-857a-08dcbcab7f92
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 21:53:14.6613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ITufn4ZoOJPtpIXmr3LE+QRWizJgWbHJ2F0RJYJ+z3pkauG9KLKL9TsC8lt7Rg1sIhQ1rQaS5fiRU5t5Pr3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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


On 2024-08-12 02:59, Samuel Zhang wrote:
> Ptrace access VRAM bo will first try sdma access in
> amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
> access.
>
> Since ptrace only access 8 bytes at a time and
> amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
> it returns fail.
> On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
> is blocked for security reasons.
>
> The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
> that len in (0, PAGE_SIZE] are allowed. This will not only fix the ptrace
> test case on SRIOV, but also improve the access performance when the
> access length is < PAGE_SIZE.
> len > PAGE_SIZE case support is not needed as larger size will be break
> into chunks of PAGE_SIZE len max in mem_rw().
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5daa05e23ddf..a6e90eada367 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	unsigned int num_dw;
>   	int r, idx;
>   
> -	if (len != PAGE_SIZE)
> +	if (len > PAGE_SIZE)
OK, I'll spell it out explicitly. This needs an SRIOV VF-specific 
condition if you want to allow smaller accesses with SDMA on SRIOV. On 
bare metal we want to be able to fall back to the FB BAR for smaller 
accesses. On a VF it will use SDMA for everything.

	if (!amdgpu_sriov_vf(adev) && len != PAGE_SIZE)
		return -EINVAL;


Regards,
   Felix


>   		return -EINVAL;
>   
>   	if (!adev->mman.sdma_access_ptr)
> @@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   		swap(src_addr, dst_addr);
>   
>   	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> -				PAGE_SIZE, 0);
> +				len, 0);
>   
>   	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>   	WARN_ON(job->ibs[0].length_dw > num_dw);
