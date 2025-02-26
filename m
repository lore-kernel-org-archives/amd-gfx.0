Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8C5C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 08:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F8210E878;
	Wed, 26 Feb 2025 08:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gETNxNdO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C610B10E878
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 08:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXjq8cY42vGKNp+tOOlA7iARTsRxesqMUNsf7NrLbIK1hplLSHfMUm8Ltr/c46/DNEVSDFflRYQv2o5UCPIRW06WQFFQs6nO5YkfFv6MMIgqG+NuTIEGPz19c4wQGb5cDCsLYx23cQ8h/vkhmaOAxqueGryHUhRjQT25Ik0R96vyeWTk9OzZPtv5WnJcGHT/v1pPkILps4eJHrtI2k+I+JAx0WwREGdxn4DYqOcPqLyHD9YUNt9n6AhxTUZrGZoQWOVNGTyAe+kEJbFwqpEQfmjkYxjqo6dNXiLKfCAm5D/5214GLzkU+90+yCiibNl6J7e9KnI5b/8f2tD6ouCUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAfa2anf/OIO77Ua45LBZZwtGFe4QI/PrSUeN9SnnH8=;
 b=zP89j5OCaLLlBiOjvCnnYpgeT0Fxh+VvQesOjS9PyayxqwCGquJCslOKifCndmvSxGV2Dl/JpvDSCkln+mk+BoBHsKZPe+e8F5/MZzifSsZiaIf8yutPiHWJWHcDnUHsJIcyo9KBQK/zO2UJyGwF4PmXeBULjWI26YW8slN5YSAqHNfyHlJBjZwh3TnYQRsy2SzUMfKvFw2WPmo/K2nv6WqqRvYkQ3ZLy/yWhiGW8bbGnB8RiNsv8S9nndw7ZJQRC9EvP3fyltF42AX+CmI8kSUMo48CoH4DJH+AZvUSBb/m9FTEZPlyf1E07PhaMTaxnPsNFDHGDmXnMD58XC63DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAfa2anf/OIO77Ua45LBZZwtGFe4QI/PrSUeN9SnnH8=;
 b=gETNxNdOK4hhqtAunwqzfUIFXZPBFldumXg+SkS5Z/6NWJJrM5RlaADsCOOudynRafn23qdJJca2nHMZjqBgmiFi6fyKLznbF7gkgje2iCBggQVdfm0E/zgkqI9zMFN0fio9Vzi7pTryMpTA1wn+jYYP2TDeFhLAqwgCymU+SUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 08:11:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:11:13 +0000
Message-ID: <8849c104-314d-4758-8d75-4326e0c9bdd9@amd.com>
Date: Wed, 26 Feb 2025 13:41:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: disable gfxoff on the specific sku
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kevinyang.wang@amd.com
References: <20250226080757.518795-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250226080757.518795-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: a1229530-ef9d-4b6c-49e2-08dd563d22a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3cvSDAzYTFmTGNzVUt0UEZQeFJDbDZKOXl2QnhKQ1QvNjQwdnlvdFdyU2Yx?=
 =?utf-8?B?dEp0YW80dEdhM2J6Z0VzNjdWNktGNEtRcTB4M2hNUEtyKzNoNGJqODZGQ2lV?=
 =?utf-8?B?TmppcEFIRnNudVVmZTRvWUgzQ2V6U2pzd0tvUDR3eno0ZzJnM2R2ZVJ1TURs?=
 =?utf-8?B?RFR4VllQR2pFZ3c1Qm03emdLcmQ5ZmFIVEM4eDloWVViczIvTjlyZWRVdEh5?=
 =?utf-8?B?QTVxdVZaOFY4MGlPamI5dURkblYxUFNCdXk1ME1kbVI0TGV4a1RBYWwzc2Ev?=
 =?utf-8?B?czZwZ1N0ejVvYkduK0QyQXBWblZway8yYkVWdXY4djE4T1YzMjRwQWp0YUcz?=
 =?utf-8?B?akRHOGlQY0FkRjRoWFcyNjRLRGtDTkpTcXpYWVdWeEpScXN6c0M4S20vSzc3?=
 =?utf-8?B?bzhGaDhCeXY0L0JzS3o5ZFNlMUNBcWJlNTZMcmdVbHdZbDN2aDNYNmo5bC9Z?=
 =?utf-8?B?MkZvSEJiVmt3eTR0TnY4TS9tdUhjN3N5OVZCTzEyT1dob3dhbTJRVm9XYVRG?=
 =?utf-8?B?bFd4dkpEd2kzakRQUTFnVW5XamhGTzJ6U1lJdzk2MldnL1hFSjFMN0YwZExY?=
 =?utf-8?B?aTZHdEdhc1NCL2xiaXlxWTJ2Szdzck0rQWpWRXJxdXVyOVdUcExFZnBTYnFE?=
 =?utf-8?B?ZUFmRzM4alVWeTBsbGVmNDBxVlE3YWlrd2Z1bmlsbzRZeUgxYWwzZWlWYzFq?=
 =?utf-8?B?OVA4NXdxemFiVnFLaEtRZlUwcXhiNGI5VmR4VW5BY084NkprdzZtcHFzM09i?=
 =?utf-8?B?b0piNzJnVDRXcDcrMW96QWFIeGhOV0JUenVUUDZaM09KUkg3OW9Ra3QrUVlC?=
 =?utf-8?B?dHBTVUJiZHNlRGVYSDJVV3F5dmdhQ0h4L0lSYmp4MERvTy9ISVV5eW81bEh6?=
 =?utf-8?B?RjhXQWkwd3dCNUxxS3pqU085VjhrdWdTVlNNUWovYWF2bytxeTAyRm1aVXFG?=
 =?utf-8?B?OUVkZnZ0QTJmSTB6STZHSzJtNVplbUJzZkdENGlEb3hmY29nTXdRdFRKTHBq?=
 =?utf-8?B?bDhvRWtwdUlXS1padFF5QkI4Yy85dkVtSDBicldsQ3Jsa0JCc3FpcGVXS1B5?=
 =?utf-8?B?VU43NjRkck1DdGhFT0tBS2NBcm9IbGpkT2J3dlZ5RWpiM211MUNoQXVCNGNq?=
 =?utf-8?B?QkcvY2JzRlZTalpOUHQ2eFN1Q29YV1FSSnNabFdUVlVNVmx6WE44MlNWdWcy?=
 =?utf-8?B?N2F5MVl5UkoyTXpZZFhiYzZVanZpekxtWEtwODBVTlkrU3E4Y2ZhdktiOXJ5?=
 =?utf-8?B?TUsvSk80blRjQTJYaTI3Nm9QUGtNVHZYVkhxckVDNWVWTDBjRUVYQ2h3TTl6?=
 =?utf-8?B?MEozZ09XbjloZWFud1ZWdmp4S0tIc3NRZGlDbTJXVUNGNk1qYUtyNlRqWGY3?=
 =?utf-8?B?QWtCa1FXN2FyUlJGVDZtWC9SQVZoTDdLNG9ESUhJTlZtcHNRTjVJVlJUYWVt?=
 =?utf-8?B?a3ExTkRzM2dHS2NWbXV1alk4N0N0ZFNIRGh4MFd3VHJYTkNsTlNXUHEvSmx2?=
 =?utf-8?B?bVRHZjVadGNGSW4rZW40bWp2U1lrdzVuMUdjczdkSG5IUHpyUFhCTzArdmly?=
 =?utf-8?B?bklnenY2SHZYNWpLRG5hdEp0Tm9Hc3pNQmVNSS9pb2NjKy8rWlUrOGtkYkx1?=
 =?utf-8?B?cUNDTEJ5UDBVNWhFZ2VmNmRHL2ZvZEk2TkVzdWZtK0JRT0lzUklEWnV5d2l4?=
 =?utf-8?B?ZlBDN294aUZMYVFEb0w1NlhLUXcyTDJ3MDFSand1WWJiN0UvZW9XeTJQckhK?=
 =?utf-8?B?OGYyQWV0RjBXWDhNdlpwZ1RjUmcyWmhZTzFhRmpxTWx0bnFmN1E1T0ozOEdk?=
 =?utf-8?B?d2FYaWROUmZTSDdWMnROUTlLZVVEaitYTUVIWFdRZ2ZGaFk3ZlpiWHZEVHVL?=
 =?utf-8?Q?GtPHsUnGaRniH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEdxK0JvUE5JZ1BKNFNZV0FqNmErYXQ1ekRwNmNJZFVrSUwvNmNHSG1kY0Ez?=
 =?utf-8?B?dlpXWGo3eXRHM3dCeVlzcGZEc0ZUWjdUemUycXk2T2tnbitPYjZzSStUd0ZP?=
 =?utf-8?B?M2FvMytoNUdCVEYrN0J4NGJqUExEV0JPWkpJR1V1dlErdWYwemRWNTFzdXZD?=
 =?utf-8?B?T2x3Q3NURGhnd2lFaUw4d0NpSHB4aXBxcTBPK2dod3lHdUtjTXpEelNMTWlh?=
 =?utf-8?B?RE5LUTZvY2xTVTVybUNTdnhBMmh6K0Z1YVZORXdIZ2cxTDcvbkNCOFBFd3Nw?=
 =?utf-8?B?Wk44ck1mV3RaSG5kMFU0bDlZVWJGa1ovdHdjSXFwV3VBZUtWS3dVZUJsYVdY?=
 =?utf-8?B?by9hZkR3R213WFVVcVF1VHU2cFlocGNqRDRmVUJST05aSXArQ0N4aEo2WHM1?=
 =?utf-8?B?LzhpSVdCOG9odlBTdUxzTkZsc0tFQno2M2NibmZPTVgvbnZHNmNyb0lSMEx2?=
 =?utf-8?B?SHdQT2VSNkFzTldxdnpuNXVSd1ZzTDI4amlTcFQvVVp3UExYdVY3alVvZFMx?=
 =?utf-8?B?UG0yVGZkWGZ1SUxCQVJscGlENExNWFZ3Lzc1NmJ6ZlNLVmVWTXJoSmp5RXJQ?=
 =?utf-8?B?N1BwaTI0Y0JCOW5rRTh0MWs4UTlQRUdDZXlaVlZZbFNWNVo2M2tjTWVPeFhm?=
 =?utf-8?B?SnZMdldvQ2tOUnhEZStkMFVIQnQ1eE5tdUI2Q2hyejF1ZXRuL1VoSGVKb0t1?=
 =?utf-8?B?dmVHdENFUkxrV3lwTUNJRVNpQ3F0NHhvZk1OTEhFRW8xYW41MUVFYmVSek1J?=
 =?utf-8?B?ZzE1M1hFZG44ckthYU9RNVB0SzlmSWsrMzdHYmJnNmpUYVd4WjBTZVl6OFI4?=
 =?utf-8?B?dU5NT1JZa2FqdzRoNHNrUDI3WDVhdUVJbjR0ZTRFN2MyNkhWK0hUVHFSRzVu?=
 =?utf-8?B?TTlBOENNdld3Ty96bDNiQUZNUzdzTlRYWWYxelIrMjduOTRKaW5wNXdhOGRk?=
 =?utf-8?B?bUNlUHBnVGVMUmhjT3hCeGFQSXpzV3Fzb3hTRU0wSUdwc0RwMW1sQm5PNFht?=
 =?utf-8?B?WC9yZC9Ib2RDekJwNlI3ODBsQkhRMTlMbURwYitBNU84Rk04YUtsd0xTQ09N?=
 =?utf-8?B?Smc2RHE5dFN1VWZ5RE9LSGtUZGlGM2pPVmV3aFVGQUc1WmJCMmJlUVlIK3Fs?=
 =?utf-8?B?ZnpmOFZSUnphdUVWQkkxcjVGbkpnY202RjZwa3RMLzJFYkFLdFJkUW1VMUxR?=
 =?utf-8?B?UWxpN0hRcENyMjkxNGc5U04zakNuS2dmeHdMcmY3UDhPNEVMZGJXa1lvUVRB?=
 =?utf-8?B?Q0NaSkVBaktqckJvRzdLWURiTkJiY3VhWlE5cVVSaENtS0hjUlh1ZWJBVHZ1?=
 =?utf-8?B?R0o3Zm5OcWpyME04MkJOUzcreHZPbmtycDlHVUh5eFIyOC81VFpzN3VxRzU3?=
 =?utf-8?B?V2FYQmZkNDk1VlBkdHE1Z2ZBWWVNYnEzakZEQXRPSExsOXgzVDF1NFFjQUNy?=
 =?utf-8?B?bElhTWthVDF4QkUvYzBhYW1wMXpBOFY5RlEwbG5jOUN2NGlhSXVwandPN0s0?=
 =?utf-8?B?azhCSXFJWTRkaG1STS9LeURJTGVUOFA1anZrREpYc3E1d3FEL0gxQUllaG5u?=
 =?utf-8?B?ZVAyZGhIcFI0Zkp3T2M4SEdzN1pjM3hja0JwTVNwQm1idHZJSjl3T3k5TmhO?=
 =?utf-8?B?SSs2aTZRc3RLcnNZTmdTSVhBc3ZVdk5aWWlPaTdScDVIUVRQSHUydllNaWhY?=
 =?utf-8?B?Wm9QOGRtdUs5bXhYODJyRXFYOGdxa3NWOENSZWllMzIvTDV0aWluUytnLzg5?=
 =?utf-8?B?cUhlS2IyY3JUV0lYT05nc1ZtV2VCVUVXMzNLNWtOWlVLUVRFcytEQUZJZG9v?=
 =?utf-8?B?MkgwNnN3eGxmb2FrbG1zSFZJemhMekQ0VzMzK0lvMERTL3J3MTZtYkxSOGVW?=
 =?utf-8?B?SU1HK2Nyd29aT1pBSDE2cU0wN0JieXBNV0RKdlF4ME10dXhsalBYc1pvWExZ?=
 =?utf-8?B?dVRnTVluQXB2d0FIdDJXcDBzb1MzTzg2Yy9tSFBOL250amxUWnBHOHZaOSt0?=
 =?utf-8?B?R2xXRCs2cW1MYmQ5NmNBM3QzSkRCK2Z3dExwSVlKblVhWWhRMnpCMVExT0Fh?=
 =?utf-8?B?cjBXUW9aTDNCZW9VcFUrSS8rdFJyQWNTaldMU1QyS21HZU1oSjFSNnQxZ3RX?=
 =?utf-8?Q?NDcoeLfJZgfpt7Y9yEpKqbmrH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1229530-ef9d-4b6c-49e2-08dd563d22a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:11:13.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY/EuW+tXf5oXZdt0bPZSpAfOySSDr0wwEV5u6+GRmCHr9mZQI2YEfL8bg8U2RB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
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



On 2/26/2025 1:37 PM, Kenneth Feng wrote:
> disable gfxoff on the specific sku based on the requirement
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 985355bf78b2..898487ad6cd2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -3234,4 +3234,9 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
>  	smu->workload_map = smu_v13_0_0_workload_map;
>  	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
>  	smu_v13_0_0_set_smu_mailbox_registers(smu);
> +
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
> +		IP_VERSION(13, 0, 10) &&
> +		!amdgpu_device_has_display_hardware(smu->adev))
> +		smu->adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  }

