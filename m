Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304B1C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 15:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3687B10EA4A;
	Fri,  9 May 2025 15:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hHFmCrCd";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFA710EA64
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 15:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc/PMuYuEboRlsAkFveLPe6rejRqmqBvka6nnMUoGSJK9s5j9rbfUdCjlDPJaZwOGr7FjrIf0ZUGYq6y/Eaa+9T3z0mMWjLnGhH6Rdsk6El/mTEmGHgCw2HDLuZGMXEoLl+KMqWLUPeK0csBIeahzOJAxnV59+rWozxCask0DoCV66iAL7Nx9Du4pwPNjimySiWdDM9Z3EGbRhrZbLWaUDhSkT5CN7fKbcjXEzgKWV7fUewmBKUDTrwshrnBXPiRnx1HebbWlJT7djFtoE/ztgipcRWQGd9mfp84QCmVjttJScub8WhRTASK2tYnpaofDQ10H7krMCeVRrw1ZiLI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayLsbwTgAqjB81Nkod/lOEq4SS2ML9cMg/vTmdVW47s=;
 b=O2YuKI8JwJCoknD4rtUPtnD7+FZfNCwVv5aM5TBeF9DjuN/ybs7hvA/nCRXw85/ajOHzaS7VvEoA1IoRvAGzXDHrNxhBPKZjdanMoZSYD5PVYJhhHT3k3Nh8oJFy4KnDe9u0D34Zokacxh7b2EFTZrJ8YG2QBWFjxqwZkfJVGWI/4+jU/6mRUEjlSmQsfW45LgVzcotFFYyQIlAazXXDuR+AaWDYbtBzPHql6uNAiF7pqAn2OM6Q+a86HPgy3cYI3Rb8hDhrh6rqhZma98+tCJQ02fCXKRqR9wofM1NWzm9xpK3FMLQidJ0K+S64q5F+VELqSXimXemb6XRYlQH8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayLsbwTgAqjB81Nkod/lOEq4SS2ML9cMg/vTmdVW47s=;
 b=hHFmCrCd/l6GmSTxAPwRBYFBkzSrswBzStOwL7mQDIcBi7vgFy7vnAh4Xm4IdsKs/nsT2uoyy+oYvtfdtxd0vr+T0VGmI35dkwpz4o5uv2NPXyBoB/Bi2MWsUFiL2feKIItuUZVjDXdwxb6rwD4sRsx04hXtlshz/3f3zM4RRjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Fri, 9 May 2025 15:32:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 15:32:12 +0000
Message-ID: <d289cc93-1dfb-44e6-b51f-217a4219795f@amd.com>
Date: Fri, 9 May 2025 21:02:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Log RAS errors during load
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com, 
 Tao.Zhou1@amd.com
References: <20250506111509.54645-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250506111509.54645-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d96f0ac-1d2a-45f4-6008-08dd8f0eaaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWhYaFQ5M2NGVDBVRTl3VURUM0xMdGFCK3JLL2JMbWdvZVRJWHM0ZU90d2k3?=
 =?utf-8?B?dTZTZVBhVnl3VE5qdExMQkoyREFySk0vYW0vY0tYSTZranRFTDRxZXEvR0Zh?=
 =?utf-8?B?RHdqamlYWENOMTJuSEpoS29HbmN1K2FBVUJJQW5UcTdZakxmcGEyckJPS1lL?=
 =?utf-8?B?MDlvOHBVQUJ6R2w5WHVuNkhQT1kyc0JaS3JOVVB0MUhXZEUrYU8rZnpCbVJE?=
 =?utf-8?B?K1NkVFlUY0hUdzduZDJNbzN5TWtWZ1E4ckNSOHQyTktlZk9nWkdhQTFWMHNw?=
 =?utf-8?B?Y090dy9oTk1IcDZoaGtuRVNMZncxVFBLb29YMlBJRFZHT3Ezb2pVWjg3NW96?=
 =?utf-8?B?c1F1L2FmV2dXUjNrcmF6RUlUbWE1d1VDc1pSTnNCTE1mRldGTjI0Skk3Ulk3?=
 =?utf-8?B?NFRTSU5VdDVZUkZUYm43aExSaTkrdUtvNFFOaXhiaEZseXJaZDlKNER2L2Y3?=
 =?utf-8?B?eWg5Q0FiM3FjNzlFVnJ2eGFzRi9nSm4zL2xJQkl0TnRNMVZXU0o2dHJMZElR?=
 =?utf-8?B?ZjcrZDFXVzl0T3Z4SkdlSnlYVGEvQU5zZ3VVMlg5eUF1S0sxbDE4VS80dGQ1?=
 =?utf-8?B?amtRQ1pReDZTaGFlYVRDY1F0Q1drZk9Eb1pEajhZL2dGaTNjYWc0UUxKK1ha?=
 =?utf-8?B?MjFaR3IyejBOSUFLamRKRENQMFZDSnpSaXZHRWFQUGJ2d29rSUkva1dDUGVq?=
 =?utf-8?B?YUpLVnFKOEZRTU5FRFUwWGxudEcxSW1JOFJkVEw2eEMzUFMwekxuQytySTZk?=
 =?utf-8?B?bHRlSm1OUktCL0hWcnZEN3BTSzBBTFFGSHh4ZlhPemlNUWNkNEJ2QUpUc0ZQ?=
 =?utf-8?B?emJxYlZ2dHN3RzI1R1FiSFo0RlIzdkd6NFA3MGpiYjJuZEFnRFhwdlpNRS82?=
 =?utf-8?B?ZVY2emREeW5aVW84U1JTYkhDL1JiMnhjeTdST3NmVmt3N1UySHNGdlJYbnpS?=
 =?utf-8?B?SDBOUXBEQmFXSUlWLzdOY0p2a3VqUitnb0kwQ2YxS0trbnpEVFZ4SEpqelBU?=
 =?utf-8?B?bHFoUGc5cVo4cGJPb0hrNXVJMkExcDhtVFhyd1AxWFgvSGV0Z090UWpHeVNH?=
 =?utf-8?B?emJScEdJelpncDZQVFF6aWZkK0cyZzNLeXNPZ0J2SGUrYlNJYWdwVERZZ0lL?=
 =?utf-8?B?eDJwazJURFlpeDZxWWwyVXBmeFh3UFFkNkRpUVdwU0ttMHNFQWVrM3YySi9Y?=
 =?utf-8?B?Rkg1SlZZVm42SDhCWjlCN25ibWZoclN2Y0pXK1ZBaXNKaDdiMk9rSUx3ZStV?=
 =?utf-8?B?dm1JNEZMT21rUGJuNjIwRC95TnB0N1pUM1dCRGRKUysyb3loOEFKdVViOEFQ?=
 =?utf-8?B?bkl1R3FMb0g5ajRzSXFBYTlkbG8raVcwYXdxT3pCcHFBR2FiLytTclF2Qlda?=
 =?utf-8?B?bTBlSnBSMTh3RGVFdnRhdHdrYVJTczc3bVM2R05tV0JHUEdnZlovdHFONzFK?=
 =?utf-8?B?Q0F0SUdJVENYNTQxbFNBa0N2TStuVXJMQUZKdUtoQ1p0SjRWZnEyL0xrTlhk?=
 =?utf-8?B?NGhtUFVQZVRTWEl2dEtiLzhYcTR0eFJ6bDFKUUt0YnRPc2dBSTYwcFhkbStt?=
 =?utf-8?B?cXpDL3lROUhQWUxxbDIrM2xiWlRBTjFIWmpyWkRNYkl1Mmp1WTQ3Zyt0ajFN?=
 =?utf-8?B?R2xNWGVxMmxmZVErSmI2Y29PdmFRNlorM0h2c2t0WjVhcTREOEVYNTkyUmUz?=
 =?utf-8?B?bHdzYURUK2lRUFlDeTRqSlFZdHFIUzBtR1ZXOTNmUGZwQjByR0UzWXA5V0lQ?=
 =?utf-8?B?SEVmbndvRzB6N2ZHdVVJZyszeVRDOU1JdkdZNTlBVFRIRU9YeFhZeGU0Rzdj?=
 =?utf-8?B?dTY4VUxQN0lRczZoR1QxZkV4bUpZUVAwN3AraTF0YWhycHduKytRMmd1UDMz?=
 =?utf-8?B?SHNjUDlWdGVsWUJ2cmdDUFY0bXo2YzlUZURUOS9XOW5OWjFsM3ZmNit5ajV3?=
 =?utf-8?Q?krH7ge5Q608=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllvRVA4YjF0NUlvdGhFMGxUVTJQcmkyMnNtR05wV0JaTElpQmRvTFk0UmV5?=
 =?utf-8?B?a3JjaHhrcG9aRjVtaFQwSHpPODFrMGVzOFNIYWVRWW55VzluWnpZM1lReW1E?=
 =?utf-8?B?TWFpWFN6WisyOVpsRnRhYmJwNlFqMUVKdnBMVkdVUzRwUjhZb053KzVteGp2?=
 =?utf-8?B?M2REek1Md28yQVB5MVFGMW5BbEQyTVpNR1RKUklPd2hEY1BoN284T3BuMjh6?=
 =?utf-8?B?YnIvV243SGRCZ0xpeUc0a1dUSkoyN3JJcFpxL0ZnWjJPZTk1d3dJUTRzTWdL?=
 =?utf-8?B?YktLaHBIN0tzaHJHUGJQSVB3dyszc2pmb0FNOWcxM2sxQ29FcDFGTTArNXpU?=
 =?utf-8?B?UGlNM1dGNWxJN0QrcHFPNTJjTlhuRXpzZGVySXFhaGcxbXhYNFcxVEtmSHdh?=
 =?utf-8?B?Ymk2Wk1hZUo2VTJRQ1dndkJ2MFVGT0VuSDZLcWlLRjBzUmRhT2RubmF5bmoz?=
 =?utf-8?B?bURjUE9QUzJhSnRsbndYaENycmtRU21kaFZueHdDN0owODRqQjUrMkFtWWRT?=
 =?utf-8?B?Yi9vMHQzek5wRzdNTTdhYi9XMU14RDZtNVZzbjA3ZFcvNmtpTmpjS0cxSnZm?=
 =?utf-8?B?UStwN1BQbCthbzBScEovU2lSdGNkNXRHZHI1TDJLQy9KMUdSZ0RmVkdaejVz?=
 =?utf-8?B?S3JKMUtVMXJ2K3NYL3Z0dW4zMkdyZy9CSEI1eUcwYkdCM2tSa29tRjgrajV2?=
 =?utf-8?B?WjlMT1FCRncwVlRTRjY2U2RVaGY5aWVzVjFvRHIzNzR1SEdBWHZ5dHhKRXFS?=
 =?utf-8?B?NmxKVGgvaDZjME1DcURTbHBKUUlXU0NNRWRDZGk5TVFyaXUrRStMWWdaVWhj?=
 =?utf-8?B?K3RGMktjYlhuSCswaUZOVkNSZXNiaEtaelVKUm9kNUdKdUxJVndpdG9RbXVi?=
 =?utf-8?B?NE9nOWJoVWtPS0JtZnR2ZFJlUDNCbnBNczR3QThicmJjR2VWR0UyRFhGdk9p?=
 =?utf-8?B?Uk9Gd1FYSG0rcnNVbWtpUnBYU1NRcndkWDVKTGVRMFlvK3hXVDAyQk9KRDl3?=
 =?utf-8?B?ci9hT0o3ZUp0RzM5bVB3RVF6OFFJODMwWU53QU1hOGlBdUJnelE1ekVzcXYv?=
 =?utf-8?B?TnhRanB3SnQ3NEdZM25ueTN6b0U3STJvcjZXRVpCQTRMNnhueE5zRWQ1Q3dF?=
 =?utf-8?B?OUpZZEpUT2NBaS9kaEU3MEptL3A4d0prMjczUWY0dmFuYTNTcmxMa0tscHN4?=
 =?utf-8?B?blI5SDArSTZESGZoYUFaMVF2a2E0K2FLM1UyWS9ISlljc09GSm5XbW4xbWNz?=
 =?utf-8?B?V09FVk9DSWJPWi9vaFcvcTYvQXRBV2NYNFg3T1VPYWpWUFdaMXA4ajBFdHNJ?=
 =?utf-8?B?T1VFaGQ3ckJtY1pUTXR0cXl1TFdhVGZTMUZIaGtrNHNZZ0thY3BTdTlSNWh5?=
 =?utf-8?B?VHV6LzExT3o0b1ZPTktKYWRSY1RXUVl6bnZRZTdUZm13Mk5RR2h0ZHNxN0lh?=
 =?utf-8?B?RWk3Q29tNVFYcWo0M0o4anVGZkN4VndKL1pkaUdvWmhsMU1YS2dBSmJMcUtm?=
 =?utf-8?B?ekxMZjBLRUJBRzM5a3lLOTZxOGwwNVpmRUJOQ0hTenFmNTRFOG5IeDZic3lU?=
 =?utf-8?B?UUJsNi9qN0xGOWtzcWU1cS9kc3dhZ2JoN1BQT2ZyYSt5aUZwUVlaakRFcjlh?=
 =?utf-8?B?cGJ5SnNKb2lPaEZOL3cvWGRrM3ZhK2JIWVFpL0Nhb2lVRGJLcmgwd01aNW5V?=
 =?utf-8?B?aTBaN3VCbUQwMWkwZzgwa0ZuQklCbmZVSUQ0a3QzUTVYOFJodmhwUVp1d1hx?=
 =?utf-8?B?RGRsT3lsTjdHS1VKNVl4V2dvc1RxVnJ2V1FFN0hzeWNRVGJscjFPeFJkZTBq?=
 =?utf-8?B?YkFKQVFsN2hjUUFFY0ljcDNSb00zNktNTVRTNXMwUUd4RngrYSt2dG1hQ2dV?=
 =?utf-8?B?aTlxbnJtMTdDQVYvZlArKzVEK0JZaXJza2Z5MjNGWjk1OXhsUkVnN09VR2Zk?=
 =?utf-8?B?bVhuRDBWWEMrZFNqck9IbVhYa1V2RVV6NTBMenpoRmh4VnZoNU1wWVN2YmFI?=
 =?utf-8?B?VDV0V29hUnhBQmpSVHpkSm1XSEFNWWJHODJWZEVYeVBtRFg2b1dXNDRnWjNr?=
 =?utf-8?B?UkgyYW9OelFrd2luaE01TWd2cXhObmZRbjFCVFF2ZFlJQ2xGZjY5RlorZDFt?=
 =?utf-8?Q?4RPXAWERMd2fERb8AMwLi094u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d96f0ac-1d2a-45f4-6008-08dd8f0eaaea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:32:12.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB1EvdQaqn0tobgFp/j8bNR+v3MR50OKe8+LmxZMyjaKmBMo1f9woNJQgBPtKV4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

<Ping>

On 5/6/2025 4:45 PM, Lijo Lazar wrote:
> During driver load, RAS event manager may not be initialized. This will
> cause any ATHUB event during driver load to be skipped in dmesg log. Log
> the error in dmesg log for easier diagnosis.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 82013b495436..85a70b646840 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4485,8 +4485,11 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
>  		enum ras_event_type type = RAS_EVENT_TYPE_FATAL;
>  		u64 event_id;
>  
> -		if (amdgpu_ras_mark_ras_event(adev, type))
> +		if (amdgpu_ras_mark_ras_event(adev, type)) {
> +			dev_err(adev->dev,
> +				"uncorrectable hardware error (ERREVENT_ATHUB_INTERRUPT) detected!\n");
>  			return;
> +		}
>  
>  		event_id = amdgpu_ras_acquire_event_id(adev, type);
>  

