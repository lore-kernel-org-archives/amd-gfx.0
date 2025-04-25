Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC706C369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D8D10E88C;
	Fri, 25 Apr 2025 06:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axAWR+VY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217F710E88C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 06:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBW2pvB1h5uNwj3UCPhdO0gIGP0Jabq7Noyk6+acK9Ym2udAN9F//BY3ayv422BKDsQBjGq1j5/aAlTBZxvZVXdLwYuosH2crBv3a59E51bhQblVjCLyC9Qwx6w3HbT4yFMP1jkePe89Kj94rDy5kegOfpv5gu4r300srWgRel+wNyPgYB5Vl7GFIDzReUMfpmhr5Hql1pHM6vExNKRkUe5yvwhpdiOMOWv9LR4Gws6aAFaw+u/4MpwAnO8yCadtWW05SAT+6fDG9gPoHt8K3P5LsjgumM5dm6f64gVok2qYjTspRmQuKM/OVlwHx9tYPnbhvBhfnwhLSxzlUEQrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASdvCw02/CiUbyATMt0B86OAZIMwPBZntyE/tT0OlA4=;
 b=ndx3iUMslUTYDmFHi5fjvyDFG5He0cWTjUtyfWePimeZ6lJdK68Tkig0rDRlchFY9gzigSPXKFHfJ1WcZeikZPfzgKmpxmYz0nbzwy7ZrTnTiwsC1Fg+pnmp+Hp54HvVrzHSBRWambJU2ayIKFgtwiM5gHTDkwWk0busgs25h290t5Ybb5K2tJnIBdiDMipcCm+NzjgsBwsmC+S6rqkchOAitAuoCMj3K2b5HdJo4CaxJ+GOtQSL6SAg60z67uY8RkEL4+BSX7+jZvAMLtDuOSoxIAzAzZHCc6dEsgQcxp0ecYOCMQrHZL34JYRY2rpGOeXKBfhMYH/Dv2H+QQ0fzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASdvCw02/CiUbyATMt0B86OAZIMwPBZntyE/tT0OlA4=;
 b=axAWR+VYG6vvHs/Mpu8iPZP2fDks+N35mLnCQjG8ZOA6lMxSrsVnHIBW0xhEumUwA9/8AvpTAFbwoxeALK/b0RKITnNdkrkbYYZ3jfD88Xjfu5RcJEFTSqru7SRkGLwFnLsS/hE33eaBZxqcsNRJ0p4/VQAN1y53EQZnVxkNR4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 06:07:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 06:07:25 +0000
Message-ID: <0203271e-8cde-4522-a7ae-a8025e80f1fc@amd.com>
Date: Fri, 25 Apr 2025 11:37:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add DPG pause for VCN v5.0.1
To: Sonny Jiang <sonny.jiang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250424171300.668773-1-sonny.jiang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250424171300.668773-1-sonny.jiang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 804cab8f-a01a-4318-e496-08dd83bf7338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vll4ODl0UnVtejVQSHgyLzg2MXp3akVxMVIzdmhXUks0VVAwOWlRWUtMWlF0?=
 =?utf-8?B?cFlWMGFjSjVlNkJHTmp4djVHOGVMYlBudmhrV3h1L2ZZYjdTOThRS3MyMW03?=
 =?utf-8?B?RjdaeUpjbUt1Nkd5Y1JiVlp3SStaVlNUWGZma2haMUJKaGI2YTdjZ0NOdGdn?=
 =?utf-8?B?WFhRUjdxWEpjTEF3UEd0OTcyRjZVekVxb1g4aWtJZEFnQmtFaUc0cml0YVpz?=
 =?utf-8?B?WHBvUGdyais0WTJHTTZMTjFsNERFWmpYYWVMancwaktHdXAvQVF4KzZ3L2RG?=
 =?utf-8?B?OHEvWTZDVjIyVlpUZnNLRXZaOUpEKzM3d1lCSFhmUDh0V2oxaW55QXhEaHNx?=
 =?utf-8?B?MEF3T0NpYlZjd0xHZ0xOMjRMYjJxL0VuMFB0MksvbThwUlZEbU1wQXE4RHdw?=
 =?utf-8?B?WXF5K2dFSVVaaWY1ZjRSSUNhcVB0L0ozcTJEMmJVRnVDL2d1d0NFbFhoTkNs?=
 =?utf-8?B?TlhGd2dUNE14clQ2cmV4UHBQSjZYQmcySmpNZVRsUTdmaitnY3h2a0NXc1Vy?=
 =?utf-8?B?ODlieE9ZU3pDMFhOcjZnckorQk1STVRvbVRWZ2c3Z3FsNlJtSVd5dzRkWnMx?=
 =?utf-8?B?OGhLaDc2VTFhSHA0Z0JzS2dFRWtmVlFHMmJqb1JKb0Q4OWxGMlU5ZnRrZTJu?=
 =?utf-8?B?MFFKYWRrSktJYVVSNDlIRU5jdXNvTC9MZDlKQXJrUE9tVkFueTBkeU8waTlk?=
 =?utf-8?B?ZmFyQU85LzdtbUNWRDFuK0djdXZDQ3VqTVpBOWs1N3RCUGRFNlA3OC9idEVp?=
 =?utf-8?B?djNuKy9WYi83RlVCcy9VN05Tanh1NXgvM2cxRDRrOFo2aEZWMUVKWEQ2QzFI?=
 =?utf-8?B?aFRaNm16WGs4RXVweDFDRDVYWURud0JYYVo1VEpBblcyWmF0L2Z6cVZjbnV3?=
 =?utf-8?B?NXNvRk9FREZWd0krdFl1eXZrMDlaZnJ2OGJEWGMrTHg1TzhpSUNlemdTMm9s?=
 =?utf-8?B?UnBuUDJJaDk5VkJoWHBUS0RjVnQxUGpvVEJPUzJSWm40T2R0Z0RLQld2MUpN?=
 =?utf-8?B?dHU3NkRYNk9aTzFZREpveHRjWktTclNHU1BFeDNka1VVVDJWdFpyUVdEdzlt?=
 =?utf-8?B?R3BYQmczY1hCQTBHWHd5RFYrelBGY04wa0Rkd3YwV2hEQ0UvVktHUUJNS3pK?=
 =?utf-8?B?QmFuTklGOFFhaU9veGxSMmNZVDZQenhEdVFwZ1JORjlpYWxZaWErWmRUVFF1?=
 =?utf-8?B?Y1JqemZNTEVrY2VyNE16QWxVOWcyRjd6ay81QnptZ1pkZEZZN0ptZU1MUVFm?=
 =?utf-8?B?anp4S3RVenZkUUdDaiswYitsVzg5NFNQZzgzS1ZrckttemJBWGNpbS9BQjln?=
 =?utf-8?B?VEVFQ1pTdzRwM0ZFR2pQdTJXZU05YitvTHJWYnlPbDRKektaVlYzUFFlTnl6?=
 =?utf-8?B?WU9YNDltY1h5MEZhV3VpNXBhL2syV0dOM3RPcGNuSWxrU2N4OGY1dWlJUWli?=
 =?utf-8?B?dVBSMk1LcHg0aE4rc2oxRDdJSDNub1BhUnpaSHY3UU0xeGxibGc5SnptLzIw?=
 =?utf-8?B?S25tKzlNTmlsaWtrRHF3LzRXWEIzYkZjZlJKRERVTkNBejh4ZUNkNC9LWXgr?=
 =?utf-8?B?Z3J4UUdGZXBOZkp5N2dTWUJjR1cwa29EYXVzclhQQlhCM1pWU3hlRHZ1YWN4?=
 =?utf-8?B?Z3poZHdCb3NqZkxhbVVBMFZGb01seXVKaVVRQ3FCeGpTVExveDlxdWZIZFFi?=
 =?utf-8?B?ZUVhOTk1RXE4dk5hWERPSVB1U1IwenczVFhIRitGTkZZdWM2a0lKdDV2OXd0?=
 =?utf-8?B?NnVVOGovVGV1aktaUGxKR05TeHBxZDZuZk9NVHBoNEVESjhoeVEwYTcybjJM?=
 =?utf-8?B?dTB1VDRzKzV4K3h1dUFKbmhObm0zQlhXZ2pBQzg3blpPTWRYbW1MaUFNTjJF?=
 =?utf-8?B?bncyTmlBcTRiWGZlcVI2cHhhUnJuallacG8wZGs3M3lkOHF2aTVWY0ZleFRD?=
 =?utf-8?Q?bbNJInn7OUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1J4MHRYU3htLy9DM3JpYW8yUzJ4TzVjUkxLZTgrUDBOUmU5cWg0QWczUzBH?=
 =?utf-8?B?RE1tK2RibnNpUmtiSGpXckdPY3EwVVhGOVFIOThuSS9DU2Z2M2doTDdIdjk3?=
 =?utf-8?B?OUVyVUNjbmdTYlhFaGN2VjBpdnlJcUtMUXltbXJYTnAyV1IyVGRsNW10WDY2?=
 =?utf-8?B?M2JRekJIWjVpNGY5Wi9YR0JZbkpkVzZHTzdlTUlaOEp2Tnp3dU1EbmxzaXh1?=
 =?utf-8?B?Y0UzOEVSa0t2RXR0aUJQOWpLdkMvYUJMZnorTGFZWGhNL1hxOTJ2azYzci9Y?=
 =?utf-8?B?RDBmTzNrL1ZCUjR6K1crd0hQMTRTdVc4TXdJN2ZJajlVTkJjeUx5SEpuYVRz?=
 =?utf-8?B?K0Z1NWhOUmd3VkFJSUJIa01TOGduaUJhcTJkd3c4RXJpNy9lUXVoTVdCK1I4?=
 =?utf-8?B?OXF5U1p0M2dJckt0R2JzSStpMlh1K01iWUl5WGRiVE11cjA4K3FUMXduSmY2?=
 =?utf-8?B?NEF5TWd6TkluSTYxb3ZtbUR0SFAycUw4aTVRNjJCVjNDNFlWTURUNHZYV0sw?=
 =?utf-8?B?N0ZDQktTMVJ2L21PUmgvbWRQZVlTZjh4MkY3alNvT29JTUFGSW81eTkya1FC?=
 =?utf-8?B?RDYwNWFjV2QxSTdyR0s0b1ptMjlsREJCVnRTTnZ1aUNwcGxzV3pCZkFDRC8x?=
 =?utf-8?B?d04yVEU3TWo2cjFjUzZiZVZ1QUhTank3dHpDMGxOa25MVlVNUitUQ2krNzI1?=
 =?utf-8?B?S3JEYkJjaUQ1VUZXQm5teVNaQm5DQVVQS3BtaFZXeGkyanc2NUppNUhxK0JF?=
 =?utf-8?B?eGYrV0JDQmJubXpUN1hPT2RLQitjb29rUnJZNjdKZ1dIUnJaaFd1L0FUTnJl?=
 =?utf-8?B?bTMwSUt4Tjlxbk9UK2p4ZlNoN3Y0WFNxWUJuVmdYUEJpcnVLQjN2UE5maGRE?=
 =?utf-8?B?cTIzWktGQnp0UjlzYit1dnI5UEdjdkJKeDY2SlJmR0xOem1xSStXc0o5aXBD?=
 =?utf-8?B?QncxUzdydHkxZ1BUUytrdURhcnJWVEFqQi9ZQ2NZMGhuODRZbFVlVXJpbFRV?=
 =?utf-8?B?UkhxQ056bFR5dGZIQlpUdkNsK0NQUEtXMjlzQUd3ZEhOSHVHM1QzVEMyWFIv?=
 =?utf-8?B?Zm0vb01xYk9GdllTNTlOSFROWmU5cEV6T25OZDZzbGRjQlZKZGtRbjg4b1p0?=
 =?utf-8?B?QzAvNWNHRWtIclljazFpcUp0YnMrZ0VyejNpWkpnL3A4M1FYbXZ6VmJ4djVy?=
 =?utf-8?B?UkpUR3FmL1haOWR6M1ZSallVVWNHUTFhQ3dLcHZ4TDI3dTl4SnV2TTREWm44?=
 =?utf-8?B?ZENUR01tcHJEcTlBMlMwTXE0RDRUSVhXZ21WUVJvazVxNjFHbGNGSndNeWcy?=
 =?utf-8?B?aC9yV1NWZjFsQ2hJMmJlWEhNMmF5elMxZGRHUUtyRXNyMktFQVEwUzhjcmNL?=
 =?utf-8?B?MHE4ckZIakNFMXNzK0hzNnh2aUxVZDZnSUZRd0Ira1lLeE5raFFONWYzb3lT?=
 =?utf-8?B?a24yVDYvZVM5Rzk3SnpHQTMzN0VtOTByaHZBVXpqbUl4MkdreUcwc283dTRa?=
 =?utf-8?B?ZTBJK1Yyemp4Q0pkWmRjcXA1bFVmTG4yT2dDUUxsRHlhZ0lRdXZqSERoUGxa?=
 =?utf-8?B?bmgzK1RNdVpnblYzSGh1TUlEVFUzUHloMlZMRnNuc0VrVklKdkZEWTBhcVFZ?=
 =?utf-8?B?Mi9TdmRYOUFwdnppYzFzMFVYdDRXWEFrRjRWRkxxUGVGSjU4dWY4R1c5LzFk?=
 =?utf-8?B?Q1BhYSt5SkpGSlhrMGRiRWdWMGtDNXlrUG5tclZqZ3lNYUl1SjhuNWg4alV3?=
 =?utf-8?B?MTg3OGlnL1Y0M2d2MklWV1cxNndZeHJwNEI4bDlYOTVBSkVVamF3NDdjcE0x?=
 =?utf-8?B?NjllSktncm1FU3FaTzVSdUtGWDZ2cFMvMU12c0tyRkxMcUIzNmNUc3FIMjN5?=
 =?utf-8?B?VzZySmxnRWc3MjRNZmdlbS9Da09lRjU1cFNvL3NhMDc3bVd5bkhTQWlLSGJx?=
 =?utf-8?B?cUJWbkQ1YkU4SzEvd3ArUWRVMDcxQ1pkbE85Nk5RRk9uNHlsTUg1blRXcXVE?=
 =?utf-8?B?anU3Yy9xUDNOajZlUkovY0JrUG5jdzdCdkVhbXZpdHAyaWV4SVJJS3RLblVY?=
 =?utf-8?B?bzZ6OGRhVHJqSWxDaVZscWJnQWY2bkFqNzErZzJYd0F4OHViN1d6djNJT2hn?=
 =?utf-8?Q?DWHQSzR3OyWscCXS9iFrZdq8h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804cab8f-a01a-4318-e496-08dd83bf7338
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 06:07:25.5289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW6mBS3HQenOlhvVZ9BfvWcJ4P36LWBPYcYYHHV3JXNi3Hq1LKLRHRmozw9fXMtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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



On 4/24/2025 10:43 PM, Sonny Jiang wrote:
> For vcn5.0.1 only, enable DPG PAUSE to avoid DPG resets.
> 
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 55 +++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 4b2e6a033831..a115dd2c1d82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -502,6 +502,53 @@ static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>  {
>  }
>  
> +/**
> + * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
> + *
> + * @vinst: VCN instance
> + * @new_state: pause state
> + *
> + * Pause dpg mode for VCN block
> + */
> +static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state)
> +{
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
> +	uint32_t reg_data = 0;
> +	int vcn_inst;
> +
> +	vcn_inst = GET_INST(VCN, inst_idx);
> +
> +	/* pause/unpause if state is changed */
> +	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {

adev->vcn.inst[inst_idx] => Please replace all with vinst.

Thanks,
Lijo

> +		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d %s\n",
> +			adev->vcn.inst[inst_idx].pause_state.fw_based, new_state->fw_based,
> +			new_state->fw_based ? "VCN_DPG_STATE__PAUSE" : "VCN_DPG_STATE__UNPAUSE");
> +		reg_data = RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) &
> +			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
> +
> +		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
> +			/* pause DPG */
> +			reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
> +			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
> +
> +			/* wait for ACK */
> +			SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_DPG_PAUSE,
> +					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
> +					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
> +		} else {
> +			/* unpause DPG, no need to wait */
> +			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
> +			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
> +		}
> +		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  /**
>   * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
>   *
> @@ -518,6 +565,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>  	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
>  		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>  	struct amdgpu_ring *ring;
> +	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
>  	int vcn_inst;
>  	uint32_t tmp;
>  
> @@ -582,6 +630,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>  	if (indirect)
>  		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
>  
> +	/* Pause dpg */
> +	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
> +
>  	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>  
>  	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
> @@ -775,9 +826,13 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>  	int inst_idx = vinst->inst;
>  	uint32_t tmp;
>  	int vcn_inst;
> +	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>  
>  	vcn_inst = GET_INST(VCN, inst_idx);
>  
> +	/* Unpause dpg */
> +	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
> +
>  	/* Wait for power status to be 1 */
>  	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
>  		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

