Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE149C47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 08:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EB610EE78;
	Fri, 22 Mar 2024 08:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IRy/rOTW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F2710EE78
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 08:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlIe2epkq0DUmDCcKsJnvdvteSVEh+VGH++UttbYJYeKUM7JfcuAzM0zi3AyIjbuRNqrP6KtxQXAD+jYSRAJsmFMKhXgdRaxOIW8YxwOfNzyhXjThtSOnVRUpTSuEdePeQ5qIdk54S1ixlrrWsNYHComW8CICOxYLqJ344sMhkfaJPhRtuR7CbUf3Q4xkC9KRtAUsu4zngVNeRlNRuRGZ4Yvq4eoaDwSBYZZWNIWK9JUuEYgk9Sl74XNR9fhS33+oeeGNA+BBsz5e7zN0bYzxrtRyYnQx65qdSjtED+98YOuqSfkX8qcx/LhBDwla1ygikyfIgvo88hq+/NRFW4wAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkAraUNuBWVDTFHdpCI3I9lM1Dmvhhj3pTJfbmBXA4I=;
 b=mFEGGvbQV7jqS/IZRrgmc84ITMP1jRY2DrImTqSAmYjT7IhFHxUfqPa7wBD+HtqtC8mBG3ejOg1AnItBoPtXfLOb1fZSbUhMH0ZRd5sPyDtokEwoSD+Ibn18rdQiIuN6MvAzMr/kpzdb6QX0pjlFMk0PFSGL9oV9SPMesak4Yakv6uUPwbaqXXyYYPomVEo3LL5gDIEdh0uZURLrHlIWofZzB14JEMzeT3eytbaZbzCIp5mJP3pALhcjSoStNs+a5hiXBjUM9V3piUVICSpauN17IpugTJuzoh7VYw96cDnH8a3E+qvO8KhL2rOCCdHUsarJb88t05G6KLnZEmoWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkAraUNuBWVDTFHdpCI3I9lM1Dmvhhj3pTJfbmBXA4I=;
 b=IRy/rOTWBhJqvMkaNoMsugEsUmoppJoaIXuiHYl4JUIDprF2WHW+5owOv0byAx9kZTOAbHvTVeV5xJUp1pizX8c4W/JhM2c0eAkP0xIC7XV6ObwsCpxo3SX16HAv7IdiUxkQARxRhAo55KM+Vujz0e5ZtJzAjCGjo0OlNPHG1g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Fri, 22 Mar 2024 08:02:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 08:02:40 +0000
Message-ID: <f046df34-163a-4b27-a45c-e5e6a16d1e4d@amd.com>
Date: Fri, 22 Mar 2024 13:32:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix truncation issues in gfx_v9_0.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240322062402.4103007-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240322062402.4103007-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c200b31-1f45-46c2-38b5-08dc4a46721d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L41Hd7cw0So4i4MiHF37tOe/FP6kp8pU/gJTNDQ7osQ2h+BD0bkq/+K5tPk43UmVKb0QJUxnhcsZ3vBtv5X/UrJpn5BTwa8PoIDgQGQKUqKcAZb2mh7wU2LYpBLXB52xtxdh5CbZDbIWQdVxXZQpJkcTA1UPx6f1FhSa6gWbcaPvdTE0IIT3GOY+tBBSdMWSmUhgaEGMuiWALhpb0xmzRRf3hxcGMILarjG3xJENn5yvmDCQ1tXzJP6Axr2aCyrBuQIxC2nJUFlTf2klvGv+aVSGpK7gLlx4aJ6Iz0/HjYDLpikQnunvwL4a4+tmz1XJxXnf8NUrpDj75QP/TX6xG1mRrbFFHVEbIe10EFzJASdLRTmD1kWkoL4RIIhReYILT4+Ybun03EP5mXXlqOCciwaXbFRTRH2m+0Uu6W6HseXy8H11JDsjZ6LgdtgSKNYUrf41BzgPuLsozODViDUThGma1BUzD2f7M8bds6xtZ4SPkuG4/6r6MIf1TrZHJJVW3rBRFbp9AnMy11F5YOU1Qspv+0i4IAmfTz8BpCFHlLjD/NZBX0GY/FrytbrXYjd5fKC8U3CbwFcKEXkeMvcb0G7r8Wz9EuE78vNx4sXNnCl+o4OGQ7g5vtx3u9gdmzXg0lLnj5rbrNZ3fHVnTvggIj0rKSmJ4t7/BwEmvX1M+6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0R5RVU3TkxRdnU5dWhYTCtydU5NUHRFV2x5UUpUR29oVHJzbUNCdHdRVkN3?=
 =?utf-8?B?c2dFditualpOWmQ1UFl1N0FqbHdnMXpsc1pBL1EwYmh2UmRBaWJKdUdBRU43?=
 =?utf-8?B?VTcrM0JXaWpXQi8wYzhGaU9RcTZwbXB4VC9aWk1DV1VKYXBZZUZhOXB3aCtB?=
 =?utf-8?B?Nm9rTUx1SXlHazY3dnZsNXFlSmtiVlE0TEVMR0V0RHlBbUxRNEVKVTNJVXFu?=
 =?utf-8?B?aXE5bi9HU3pVTWhtRHNVc0JlYndTaHNiME80MjF2YkRSYXptUW43KzhJYXh0?=
 =?utf-8?B?a2NrWGNsc1pNUlpudlppTkJPMk4xU2dTSlhuQVNxRVdKSDU3YThFS2QxWFEy?=
 =?utf-8?B?d0VxdWlpMjJGL25sZEhXYWFMc3VRK1NKZFRXOUpmM0FNWU5BZGVUQlV1UnFr?=
 =?utf-8?B?ZWxHbGtvZzdMUEsrZGhXQ0NSc1VucldkZExqRnAvdDBBT0RvaGcwbkVzNDc3?=
 =?utf-8?B?SEU3Vm1yV1dYRWZmY0dLWVBBbUMyWmlwOUlycDRNd2NxdFdMdUNydDdUR2Nl?=
 =?utf-8?B?Nmw3RjVYREtvQVRBUENaVFVmNzFDNmh2ZGpnaG1mWi9lam1FRG5lV2JQRnRm?=
 =?utf-8?B?UmpwZEowanpjNGQ5UENWT1FEVFlDUnY2UWF2cnVDcnM5aWhqenV1dGZOckNI?=
 =?utf-8?B?RnB3ckNGQjQvR1Jua2Z3MGdlM0lpWjZKTTFiTUZabWxRWDdSOVhmajlxNnZn?=
 =?utf-8?B?R21YRXJhT3NkNlNrRE1kUWdLbUZxbFk1NHhxZ2ZkWTFLdk82eURFb0VoQzMw?=
 =?utf-8?B?RTJoZ2pFdVhaOFdZc0sybU5FYndwTWI4RjZBZFNnNTRRRU5jUitKUktTY05v?=
 =?utf-8?B?YWZwdWNjdFVTQmhwNC9Fa2lsZUsvai9nQ3JnZU5XVzdOZU0zOHZ0UDNjQXdV?=
 =?utf-8?B?Zmh6c3ozOGd4ZFMyeXpTN3VrQm92ckh2Q2MxUHI0OGZjRndXbFlmYzVoWjN6?=
 =?utf-8?B?bmVvQ0JIOXZ5SkJTNzRNdThjZUd3RWpPU3NzSG50NHlDS1ErbTRwS0JqcVlZ?=
 =?utf-8?B?dXlhdEprZVVKVC83RThjRkVmTnJEeXpmR1ZKbEtnZ05keUxNd0ZRMkFqclpW?=
 =?utf-8?B?WEZXMzZPWEhRSDNHeThRbi9tOXlkaGFBWmdaR3FNamRqdWpYbU40SGNqdXVG?=
 =?utf-8?B?WnJ3SjJwa1VKZEZzODBTTC9Zcko4WUxVeVRUUkFhd0dKMERONHZkNVZxSDF1?=
 =?utf-8?B?WWc4MkV5QmlQL09tNVlwSkZlbVdtRkJjV3QyWmlTcDBkdkhySEsvVFVCRTV6?=
 =?utf-8?B?V3oySlFGdTcwL0tPdFY2WmNuTGpDT3I5Yk5IU0RUdUJFQVYyZVk5M1J5aEp0?=
 =?utf-8?B?dkNBbmMrekdpd0hLaFRDSWVFNFREakNaMi9qSjMraTBTL0prVEpuZVRzR25q?=
 =?utf-8?B?dnZzSnh4MHFpaVRjNjVwTVJTZ0loYnc2bmpzWlM0T1o5QlJxUmFZVmRudDNy?=
 =?utf-8?B?WExPOXRwQkY3azJGZFR3c0hzMjhIZHBsUU81NVdJOWlSbER0ckZIR3VDRUo4?=
 =?utf-8?B?andUbFl5RUFVYTFuSi9rLy8yV1piUDRkc2xJc3E5KzlOWHplN2NsVXNlYTJG?=
 =?utf-8?B?TFV6RGZSMGFKUFFBalRiU2pnNHMxS3YrVXFhckJPaDlvZGpaNXdPUE9VWXlU?=
 =?utf-8?B?ZUF2Rnd1Tk5vSlZYY0VzYm53OW1nbmtoV2sxeEZONHRUTGRaYVdSTlMzMnJ5?=
 =?utf-8?B?MEVEaDM1Zm9JakdzcmxPK093VTlMbGpmYitOZkFrZlorZGlScHE2bXBrOUVE?=
 =?utf-8?B?V2laVXJ4VGdnczlTcVVwdGJ0c0czNlNtWmlSSzNSUzR0SHdoNVNYRVkvdnFw?=
 =?utf-8?B?NG9maXFHbVQyRjl1NnJCaHl6RktCeVAyM3JaeHYyeUJRd2cwdk1OQ3BiYmZB?=
 =?utf-8?B?R0YwNU15cEYrYjV0c2lkSlIzSHRTM2xmcUY0cFM4RW0ybkFCYVZydUMrZWpU?=
 =?utf-8?B?S25sdlRLNjIwLzFqcjByY3I5NGVpOFhHZWEzNWFkcGFRNGU1OWo4RDQrRi9E?=
 =?utf-8?B?cnFlQjZ1RlBYWUl5NDZJSzlCYlBsMTZ0UE16bWxoUXRyTzkrRDVTRGFpMDFq?=
 =?utf-8?B?eEx1QzhiZGcxbEhxaU91MXZLd1FNN0IwQitIdmVSaldSaTBsTFVSLzdpVi9U?=
 =?utf-8?Q?SdSJ1aKPKnc28ovZ3uouJwKI4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c200b31-1f45-46c2-38b5-08dc4a46721d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:02:40.6551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0jbbl4D91aBsmaszB1Bs1kGSWFjoVnsgaCYM6b6kFe0MSILBRvNaEmQtTwyOa2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021
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



On 3/22/2024 11:54 AM, Srinivasan Shanmugam wrote:
> The size of fw_name is increased to ensure that it can accommodate
> the maximum possible size of the string being written into it.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c: In function ‘gfx_v9_0_early_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1255:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1255 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
>       |                                                    ^~
> ......
>  1393 |                 r = gfx_v9_0_init_cp_gfx_microcode(adev, ucode_prefix);
>       |                                                          ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1255:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>  1255 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1261:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1261 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
>       |                                                    ^~
> ......
>  1393 |                 r = gfx_v9_0_init_cp_gfx_microcode(adev, ucode_prefix);
>       |                                                          ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1261:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 30
>  1261 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1267:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1267 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
>       |                                                    ^~
> ......
>  1393 |                 r = gfx_v9_0_init_cp_gfx_microcode(adev, ucode_prefix);
>       |                                                          ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1267:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 30
>  1267 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1303:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1303 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
>       |                                                            ^~
> ......
>  1398 |         r = gfx_v9_0_init_rlc_microcode(adev, ucode_prefix);
>       |                                               ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1303:17: note: ‘snprintf’ output between 20 and 49 bytes into a destination of size 30
>  1303 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1309:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1309 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
>       |                                                            ^~
> ......
>  1398 |         r = gfx_v9_0_init_rlc_microcode(adev, ucode_prefix);
>       |                                               ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1309:17: note: ‘snprintf’ output between 23 and 52 bytes into a destination of size 30
>  1309 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1311:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1311 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       |                                                            ^~
> ......
>  1398 |         r = gfx_v9_0_init_rlc_microcode(adev, ucode_prefix);
>       |                                               ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1311:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>  1311 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1344:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1344 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
>       |                                                            ^~
> ......
>  1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
>       |                                                      ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1344:17: note: ‘snprintf’ output between 20 and 49 bytes into a destination of size 30
>  1344 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1346:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1346 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
>       |                                                            ^~
> ......
>  1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
>       |                                                      ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1346:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>  1346 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1356:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1356 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
>       |                                                                    ^~
> ......
>  1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
>       |                                                      ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1356:25: note: ‘snprintf’ output between 21 and 50 bytes into a destination of size 30
>  1356 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1358:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>  1358 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
>       |                                                                    ^~
> ......
>  1402 |         r = gfx_v9_0_init_cp_compute_microcode(adev, ucode_prefix);
>       |                                                      ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1358:25: note: ‘snprintf’ output between 17 and 46 bytes into a destination of size 30
>  1358 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 6f97a6d0e6d0..71b555993b7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1249,7 +1249,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
>  					  char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[50];
>  	int err;
>  
>  	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
> @@ -1282,7 +1282,7 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
>  static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
>  				       char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[53];
>  	int err;
>  	const struct rlc_firmware_header_v2_0 *rlc_hdr;
>  	uint16_t version_major;
> @@ -1337,7 +1337,7 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
>  static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>  					      char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[50];
>  	int err;
>  
>  	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
