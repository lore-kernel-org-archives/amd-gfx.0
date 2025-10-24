Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDA0CCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 11:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E329710EA77;
	Fri, 24 Oct 2025 11:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1mskbU87";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83F210EA77
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 11:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/1nrzuR//SLKK8WmuJ0AeTv246MK+6ijxRHR5SbllM56W+/EJBqQOnJQdkiNP3gNWtvp8cAZhFj+chnpibbhEMSiIKtcZN5PKV6XUfoBXsBoTLL6Go3bKvLkUJ5uGoFJ0HZFbSuagQ+fujDkCuRzQbf5Tm+8K5VyEsR3VE3XepXUeGRG1HW7E1eb0/22fhKtTI8zMMHcWR7y5t8Tsqg4GT4aOWLXlWur6oKtQTq+CsI6zt40Owc5rkd4JhX61bImeY5FiyUWrgzpahpKH3JrnjxHCbP5+zUeZmg5gG40puMbAisiudCD8kOA/9YK/nGZe7em6g4z2O4jjj9JyG3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExJagZwoMJsq/5sCkMnLIy9RbXZcdlCNJpBhbYZG29E=;
 b=G5405zkvCnHD5c5qSoQqn587hZo7AMJ0wvKfmnEwTPYxjgOXlBo6hxWo2jU/Xq9NP8etZqVM2jw+6ZK7peRgUKFhXMFio3bSjfAIDfikaFZJLvc4f9n4pLxyUx413IaxMygsy+nTg13KXSIK2LIoaVjZpBxiU88lVfHpVJkrSgA4TX0THuhfeQfo+9fNtAUBPfEP4cALvSNoGdxnUyyrk4s+umphikaSi+a+bwG8c+vDi31KLnOlkEaFwsOT+YsR9L1eRvjuccq120H02Bt7HPVUy9gHJPWcblG86abYBQl5RGHWFqynguwdAohhH1o5GMTH4pI/2cqtonqTxC+xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExJagZwoMJsq/5sCkMnLIy9RbXZcdlCNJpBhbYZG29E=;
 b=1mskbU871Ps/VAyZ21E8d3INLPjcYAsYf/9hiOZsI9bhplmuQTIX6DrRpYK+h8KFrd4kl46u/mhC74EjFUzlPM7sMYEask5Xy2n+YDSS50DPu6XktK7fvmdDH0lt0tGAbhaejJGiYL3Fb5w5ZUQyDUxRo4rxDYUGiKat+nJcnf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 11:45:08 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:45:08 +0000
Message-ID: <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
Date: Fri, 24 Oct 2025 17:15:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: add missing return value check for range
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Shirish.S@amd.com
References: <20251024111602.2128436-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20251024111602.2128436-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: b153308f-28e8-46db-1c05-08de12f2c83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUppa2Z2TkRlSzJmcG5hL0dTTmZEV2xBanF1YXJmTk42QTdZL2NlOGVMbnRn?=
 =?utf-8?B?SGtacm8wNERRd3NPMzlMT1ZYTEYvVDlqZURyakhtQUQyNmV6anh2YVRnR0JI?=
 =?utf-8?B?ZS9pV0cvVk15SDFGR0FTdXJrWW9GWjNKTklCNW1LWUlhSVp0cEM1Uk9GMDdp?=
 =?utf-8?B?alhrUVE5cFV1ZklmdDR1L0FRZ2xuMnFkTzIyaFMvWkVZT2pZMDVSbjlVNmJU?=
 =?utf-8?B?WWRGTjRCdXBXaENVYkxqUHMyOTJadG5aWUc2dmsvM0QxaVBwZU95OGdrbk8v?=
 =?utf-8?B?cVV1QkNORzhPZ0JSQkU2WFJmYm1COSsyS203N3Z2eE1TTWhPRmhqd1J6cTBn?=
 =?utf-8?B?djZKeWdreUs1NkpPWWhGS1NTeUxvcVd0SmNwZG1KajFJd3AycXFVdVNsdFNQ?=
 =?utf-8?B?MFRxTWd2WkZKZzFxMkdRdEp3QXF0cXNiNmM2NlR6RGo0VVBhTS93Wk5lb0ZP?=
 =?utf-8?B?T0JpSzJSYmtkU0NmQlY2aHZ4UmRKN3lHL3BLTWF1ZXhXMW1WUWxwUXR5ZlVB?=
 =?utf-8?B?S0JoS0ZQYjRlOUo4ZC9BR0dJbzdFQm41eVhSVlVvN0g1TUFYdysvK0VvbVd2?=
 =?utf-8?B?MEJYTEtVaDVTMElWR1pOQUlhREk5SmZuUDExTGxSeU9uYVpvMlhhQXFVNU9U?=
 =?utf-8?B?Tnc3NVNNNHRhNVl6YnRRWlR6K2pqckYwTHNwKytXSi9TUmI1YWM1eGpsQnJL?=
 =?utf-8?B?dklJVnc5N3NscFpJblh1Q0hVV0V3YmhJWXBHMGFUOHlVdG82ZVJhMCt2b0V3?=
 =?utf-8?B?TlJvT0s5SXdLN012Ync0Wi9mYzZBNWZ2d1FUdERWSUVyeXZUaU5LYlV4SUQw?=
 =?utf-8?B?S3RmRHBJYnNJVDh5UmNma0pZck53c00wU2hNV215N0w2MWFEdDRKNlVzbmZO?=
 =?utf-8?B?STRqQzRzYzZaM3RVR1lFVDdiL1JiMzRXUkpTUWR1RGlwbGtPN0YxQVN4YnRH?=
 =?utf-8?B?UGVCTDF6bXVWdVRvTzlLS0Zpck90TFAzdE1nSS9nODJPWk50TXNWaXc0NTVu?=
 =?utf-8?B?VENvOTYxd2lNK0I0VDU3YUd3RmJpWWRVY0N1NlRySjdBaGphV2dKS3ArMko3?=
 =?utf-8?B?N1RxR1daVnYxTm9WQlNNUHM4TzR4SHFwRHpEVHBQN2FncW1QclZTSmdXZDdI?=
 =?utf-8?B?Z0RyWlJCdy94aHA0M2N1NFdPREhoWWZlQi9pMzIwWDA5cGtUL3ZzUHNRS2h2?=
 =?utf-8?B?cVlaZTdZSU1VR0JCMng2YkNHZTQ2ZDJRZlYySS8xYm9OWTJydUlKa1hFY1RB?=
 =?utf-8?B?MXc0ZHZ5bWUvYkRxajhVallkYWdBK1dhRHFDOHRHNU9DYkhBNlVoODM2elIy?=
 =?utf-8?B?VzJLWW01OXJGM0lDaWFTUVBNV2lmQXpHOExrbmZocUtSUFI4ZWFaZ2tQdGp1?=
 =?utf-8?B?aG5YcTIwbDg3L1pqbmdPU1NwSFBGK1FWK1BWL0FCUENLWVZuRW9vUlVneHdk?=
 =?utf-8?B?Rlp2ZmZuWkhzSkp1a0JacWJLRHErSU5Jdlh2VGNNVkk3ajJ4R1BGT2x5ZDQ4?=
 =?utf-8?B?ZnNhbi9xcU9SUkZkRkpIUFdGcE9Bd3orRnBUd01TZWhCY29zc05wWmMxUlZm?=
 =?utf-8?B?cmFyU1Z0RDZOVjJVbFNhZ0QrbFJxd3MxMDAvenlaNHpDODNZVXUxb1dpdEJu?=
 =?utf-8?B?d01jaUtCUXhGdlIwREJudVpucjZCNGpnTUtleWhPQmt5VUU3dGJRRTRBWnNK?=
 =?utf-8?B?b0lPcW11d2hBd1JlY1NjT2dsa3Z1MGNWUjQrL1p4MGQrdkh4NStjVFBlL2I0?=
 =?utf-8?B?RkFOS2ZaVEtIalBiTjJNMFhZTldNWGdlWG5Sb0ozTW1qSDliT2V2LytBTi9k?=
 =?utf-8?B?Z3dDbXNIaFRHaHJvWFlPYVVQRE5XS0xTc0xKaVdCMmNZcStKS0Nta1hYNld6?=
 =?utf-8?B?ODJ6Smc2TlF4RkJjTlkxcG1yaHUwVUt5N0R5N2N5SnVuOWNqUktwd29pZ2Fz?=
 =?utf-8?Q?0Ig6gwoxmie6V2vj0o0EOV4oydNPfjN3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU4xQTZiT1k5eEZJRXJ4ODVNWHZKRTdqeHpjdndvUGR4SG5vUmtMaDY1RDda?=
 =?utf-8?B?NlRZQVo1czZ3cTNNVEsxZHhUTmxJWXhheXlzZHVwWWFVRGxQNEFNN2IwZ2V6?=
 =?utf-8?B?ajl0ZFUxcE5YMlR2d2lqYURIZFVaN3VVMWVlalpBMmJWQlRFZVo2Nml3aGFQ?=
 =?utf-8?B?NkVPVHVRa3pnbVN6K0paUDlYeUg3QURJeE0wWGN1QUtGc3VYN0V3SFNrNEZJ?=
 =?utf-8?B?UzJtVGVQMEkwWnd0bklQZlZEeG9pbTB2dXRXdGNsWnRWT3pEOERKL0RxdTg2?=
 =?utf-8?B?T1RZWERVS2g4TGpTdFJsbEZTbzhyRktIY2RaeWJuTm5UL2RYV1VDRlBJQmhB?=
 =?utf-8?B?WFJET3l5YnBSY1Q4Ykl4NWpNeUp2eU1mbHg0UGJzRHFrUEc1SGp2czRMKysx?=
 =?utf-8?B?NjI2RXZlRDdOUTBzQjVITWhrZVNKUkx5cVdTbUtibzRTOWRlWjVKOThkTENa?=
 =?utf-8?B?RFJmeE92WFh0OUZVd2xFRHFUMmw4Ykw1Z0hyZW8xYlYxMEZJMStUTnNwS3RD?=
 =?utf-8?B?QVZValN5REdIZVJxY0prWjh1TTJEU3hIR0E1ZHBSR0JPRUxKZmRQNGNVd2Ra?=
 =?utf-8?B?N0tXdFIrb2tsL0FLVC9QZUY0ZUdUa092OUlFVklnMnJrQmtTOE5jM1cvRjhq?=
 =?utf-8?B?eWREWmJLOFppVHF2SkhHVFJtaElBZzFZaFRHem1iTGtpQi9sUlpOdjVLcDhT?=
 =?utf-8?B?MnEra1lJa1daRUI2U2tUbUlCTndndTRCNFY4SjdsOWo0TmxGdGl3TzUyNEsw?=
 =?utf-8?B?cC9oNnBZbGxybEZoUm5NWEJwcGJ3MkNCMlp0NHlHdkZGRkdkZWlBdnlpY0FP?=
 =?utf-8?B?bkdQVEMrSXJqT0tleDllRzl6Rjl4N3ZneWF5WisvVW1jWGluZG4vRXRzaVVt?=
 =?utf-8?B?TkdYSUdSVmQwbjRVWHFCWXo1Nm1GdXI0WmRBckdNT3R6dnR2UEk3QmJYeFdh?=
 =?utf-8?B?QkVQVVhnV3pscjVaeFg4dkk4d21WTXRHckt6b2ZTS0hxTXFTQ0szNUxacFA2?=
 =?utf-8?B?ZXVrM2k3cGFpYWZzNDB5cjNEU2hrblhlMjVDVHJyRlJtenVCdVpMK1lyQTBz?=
 =?utf-8?B?WFFvZWhHZmcvU1VJdzhhZGdSWTRkNEZXVVBnbHpMOWZFaVRMbkN6VDlsNGpi?=
 =?utf-8?B?bFI1WGo1TUsycm1yeGMxWkZiYmVWdzYxUDVNWVpMM3VMRTFMK2VQOTc2bGN0?=
 =?utf-8?B?ZG9PQis3a2MxQmtGTzRvSllWZWZQbTdVakV2SUJmSU1iamEzSkt6UzVEcTRY?=
 =?utf-8?B?OHZ0NmZ2L09hYkwvc0dXUCtuUFBTUDlxWFl5dnpVV0VFNGsyckxDOC84bWdE?=
 =?utf-8?B?RG44SlpyOTJpM3ljUWxTcm9lTjdPQ29LbjNwZUNEelloeVp4ZE5lcVFiekhz?=
 =?utf-8?B?WW42U0YwcjRYd2R6QkxIUXlaTzY0dGJyaHNKVk96TFBZc0daSVJtNlorZGVB?=
 =?utf-8?B?RndHU1FMcEU1dkhDOHdSMjhNTGJaLzJLM2lJdU03cmh5OFFQcEMwNVBmSlBn?=
 =?utf-8?B?djBQYVVGYXdlZ3hQMkphUGRBV09YcC9WZGtWNjBGQW1YcGM3djBMSUcyWEY5?=
 =?utf-8?B?V1liRWowc0EyZ3dzZlo4YXlZcFZuRlRmR0xWcCtPejl5cGtVVS9mWWY1U0VM?=
 =?utf-8?B?NDNlbkpnWkFZZjZJT055VFhEQlZXT2F1d0FXZ3RXYXBtZ29vQUl1UEg0eExK?=
 =?utf-8?B?VmJ1RSs0T3I2NlQ4TjMxSWxvWTdOMFRkTHFTU3dBSVVwMVNrREpZdEFQZGRP?=
 =?utf-8?B?L0NIeVk1T3UzQWpJNEZyaEJhSWo5eitiUXdFSlRjalQ2K3prVWNTRVpEREhY?=
 =?utf-8?B?OEJ2RVgxMElCMGQ5N3ZSNU03ZGE2NDlsZmVWVFd5Q1c2OVlUeHk5TFlIVjUz?=
 =?utf-8?B?aEhrKysxQW54cll5M2xlajd0Y1MzOUZjME1NY3VQZUlWOTkwY0pGTjltWU9w?=
 =?utf-8?B?eDE3cko5RVphbkgrWjFCT3VBYUk1Qk14YUQzMHFHaXpIbTgvNnpKbkRHTUZm?=
 =?utf-8?B?UjlidkptNkVhYldEYUhuRmdUbXBtbHplcHNXYWdyQjgzYU9WOXQ5bVVIeE5B?=
 =?utf-8?B?RzFRTng4NXdaeHdGQWNSZS9MalJMb09pMSs5eVB5Zm82eU44aE5zeWFERmYw?=
 =?utf-8?Q?nOjeBRrngBAJnfIAIr5n4OVHi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b153308f-28e8-46db-1c05-08de12f2c83b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 11:45:08.7447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcEGMebUudVSY10gBKbf2RQ6/o4IC1LZ9f18Q7GXp36Zn3/FK3FvYGxWClsbe9Z7rMr1EbCeUvg018ITuFYDcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

+shirish

On 24-10-2025 04:46 pm, Sunil Khatri wrote:
> amdgpu_hmm_range_alloc could fails in case of low
> memory condition and hence we should have a check
> for the return value.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f041643308ca..7f0ab73e2396 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1738,6 +1738,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			range = amdgpu_hmm_range_alloc(NULL);
> +			if (unlikely(!range)) {
> +				r = -ENOMEM;
> +				goto free_ctx;
> +			}
> +
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner,
>   						       range);
