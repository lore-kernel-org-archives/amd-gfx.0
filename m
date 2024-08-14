Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518E0C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 01:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84FF10E3CD;
	Wed, 14 Aug 2024 01:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gqsVvA3T";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD0510E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 01:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ9r+iP1a4pceFLM48RisnxD2YPfgg/cxuSlPZDjE2ZyTBkz5xqkgdXvcldKFYBHEx/VIMQ20JPruER8bKbqEqGU2VzY3dsa0aBvXAKzm9bBjrK2/v0itZ05T9pG2bPbCMrp6vo19nkagIvwqeNN1u/pS8R3BrUEcDMdPzigfCs1g0Rm0h/IuMG0t0WdXxYC86DuFKzXu1QVwSuDYVR41x6vChXKi1wbzrnYcn2gjZOEmrTg/+WU3sH9OJflPB+sBPuAifrzW/CZ1lLPrNq0CKo4jYdWrcXbdquJBcpN2h3LBOAomn5NhmyClK6GPqqq8A1ECk7McLBDhJH+FOeY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KXcB1+7sc0soEQyfn/B/AZkhhOlGqO229dqORbHzRA=;
 b=N0c5uNlBu6Lhw5zzscqJruUlhbxV+c1vJS/JaS51d2Z4RRy8nnXm50Ko4gox+GqjppNW2OozzLFCtPpx75lnRhdjBgzyhVVm29WHZSFJe/q6oemozi1WeDt42rkbsCLTVBSEkmoyNilU/dZ3h9QutaL1ERxjO5FQupBSx3v2rQhy0MCmd3LhDoH2xF8k9c8alknyrLSq1fjNuNefONliCqbUEjonbJBotQH3nJdeLWt+1xu/DuMLOFoNyQDMTjmybRBZE+aU/Y49N0Ac+VYZB7i1BeLp5B1H50FwMStOsp+kJy5utaxzWtaIDACVI8by9Ux8VqVsrDQufVYY2ayHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KXcB1+7sc0soEQyfn/B/AZkhhOlGqO229dqORbHzRA=;
 b=gqsVvA3TGHOJM2+ZZ38e52wOqXNkJY9ZPxJbCIiwlSAOcWAeQg8cQIO9C4NEitIsxJu0kX2mawKvVDib2cMi6CWGBYZilrcXfeSrbV/ORwh6vwJ5A4CWNOJVLYYM08i+ADUEk8TmAVSCEI6g7VFTsZQ9j3tYNk4T+HjK0tlEAzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 14 Aug
 2024 01:52:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 01:52:38 +0000
Message-ID: <7e40e8c2-d6a7-4e10-b71c-c4f869e825ab@amd.com>
Date: Tue, 13 Aug 2024 21:52:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>
References: <20240808084421.2755417-1-yifan1.zhang@amd.com>
 <CY8PR12MB7099066850F032CF0AF32A038CB92@CY8PR12MB7099.namprd12.prod.outlook.com>
 <CY5PR12MB63696ECC884783C0812DF219C1BA2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <bd4a1e0f-6ce2-449c-bb49-2378d0778dc9@amd.com>
 <CY5PR12MB636906514896C3B015D04623C1852@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CY5PR12MB636906514896C3B015D04623C1852@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0314.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c25ea6f-9bef-4f1b-2f92-08dcbc03c681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akRQeXFaaTU4UkwxdTRzOTdITzFBdXNQdEJsTTRZM0toVDVHdlN0WVNuSWNQ?=
 =?utf-8?B?dVRSbld5a05MNTM4dzYxMGlLZEo2NTBmaGNJTlpnMGdqY21nYk5FWm5pK2g3?=
 =?utf-8?B?OXk1SXZROHgrbWZpOHNLd1UwVU0vZm9jNTV4NUFXUkV0Z09nR2lRSDR5emI2?=
 =?utf-8?B?bm1DalpPdlZlR016NXIxRWFtZUVaZmJYUnVNdWVRS1ZVLzgwSEVIQmtvQnBm?=
 =?utf-8?B?VG1GdHluZ2pIeEFrSHRtU0l2NDhMQVVNNWRSbDB3eU1RWHM2Z3hQdk9BalRw?=
 =?utf-8?B?cFNQd0dNWkY1cHRDWG9iS25nYXQ4NDEweEZmMGpaditWSWhBS0t1UXJhLzZF?=
 =?utf-8?B?U1VvMS9LbVBRV01SZ2dHMEdDUkFrdm9idDRmeHE1aTc5ZGloSmRiZlhZMFdI?=
 =?utf-8?B?Um0rK2QyTld0bVRodWdNYTJZdGNrNXJwWTlFOUp3alVDT1FTOHRScnhxWFE0?=
 =?utf-8?B?Z08waVhlRTQzUm5TRGFoQVNETW5JTWJlRmNtU2RQdUJTemo5cm5iVjFNWk13?=
 =?utf-8?B?RE1xSGZ3Wm50UkdOSnNvcWJoZmd4ODRLdTRnOXdyaUZGeGpEM0JEdWQ3TjJr?=
 =?utf-8?B?V1dyVVRmdHZubUd1R0RMVE9yT2lqVm1laHJiVit0eTNTeXVtLzVtOU14SjVy?=
 =?utf-8?B?dnFNSWVLZWJ3U3NndEJsUEY4WjRJUGlucXFrYnhkeDdPOG00V1JZVUtrWEZC?=
 =?utf-8?B?SkcxT2d3Mlpobk5KMkYwaWJuaE8xaVRxa3dSSDVkRnVTMGNCTm9hMEMydXRa?=
 =?utf-8?B?VEt6VG1Oam1tUTFia243NTBHenNHbmRmMFpFTEFhaU52Zm85UjhDdEdJZTRn?=
 =?utf-8?B?djk5eENnd3JaMGtGTXA4Vm1qZENHUjA0R0x3bzM2WUdEYmhxYjljT2lmbDZZ?=
 =?utf-8?B?VUQ0bDZIMW5oMjJxV2o3bXJRN01taWpnMFJHMit3TXhVMEcxNkNwcGhpdUZL?=
 =?utf-8?B?bVQyTUFsN0RNUW0rTDQxNVdpYVNVa0NneG5IUm1mbjFKTWsyeEI3ZkpOcCt2?=
 =?utf-8?B?QXRMSld4NXNaV2h6ek1RR2QyU3FYRmdraTVESFFIamxVRGs0R2ljVjJ3ektS?=
 =?utf-8?B?QzlicVduYWtLOXRFN3puWjJpZ1FjMER5N1g3elRZaU9aMThJQmxSRWpueVg2?=
 =?utf-8?B?N2YwckpoQUY3c2g3TlR2K3ArR29zWWJVblpFZUZuTFFMSURPMUR5UFhmam9u?=
 =?utf-8?B?MDZKS2FudloyVW5LYkErMzFBK0JMTFc0bnlVelEyaFVQV05wMjIvdGRQTWJT?=
 =?utf-8?B?U0c0ekVWZE9pUnpzT0RTTjJ2aitqRzRla3NsaFk2Ny9xSGp5MHBTelh4Nlc5?=
 =?utf-8?B?VUJnQ3BUeXV3Nk1UMWRMQjVYZWN6bW5CNUJrcG9ma0JrRDM5enBQdHpoTTd0?=
 =?utf-8?B?TWM1WCtDVWxhbEpIcWVKcUNFcTlWQmZwZGYzTkhCT09haythaW00MXk0Z0FO?=
 =?utf-8?B?MWNYRzA4aUNXUi9uWXNTVkRqV0lkemFKeGNRb0JETTdyT3dFbWNoM2RjVVps?=
 =?utf-8?B?SkFJK3M1MjdUZjRmYVVwSmk2VzBnYy9kOVhvc1lHSzNmOTQzOFAvaVhwaXF3?=
 =?utf-8?B?cDVaNjluMFBSME1heGNvRldUdzNGK0tmM0NmS2ZhSHBoaXFLYUxBZ3BJTkVD?=
 =?utf-8?B?Q2JIQUUvWjZST3pHdEVxWFY2VjZHNnNpZlVMZjI3UGxsOG9aRUZUM3RrbXJH?=
 =?utf-8?B?M1dqeU5WZ25jaXlKRUd2N2xOYnliKzliMUZGNERkcWJRQ202SHpTckNVUjRL?=
 =?utf-8?B?RnJsWE1EaEY4eUFXRHVyY1p6Mm1NeDhHcmhuYndXRTV3VHdsZnZhVElwNW1D?=
 =?utf-8?B?bS9pQy9raUxTMjJZdzNGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhURjJNN2tMN25tQUtaK1FMZU5oV09pYkVIMU9ra2IwUGlDMjJYdm1odHFQ?=
 =?utf-8?B?ZDdhRktJVU8rREI3NFNtb04rTzE2cDZQbXNsKzAwWnN3WGdKWUxnbi80dkRZ?=
 =?utf-8?B?dzBYNDdrZjlMNVIwWUdHQVBkQksySUprN0ZyNTUvVU11SXBjZUUzbjdTaWRu?=
 =?utf-8?B?ekN4Z2dLaTlhRFAwY2FhV3gxaEVTWHZIdDhXdm55SStTTno0Zk5TNzAzWGcv?=
 =?utf-8?B?SXJtVk9wTTBwSnFUQkVWMnhjZ1EvbXBnUHNSUkxYSXVHb05xNVplbHVNV08x?=
 =?utf-8?B?b0VmMG9zREZ5THltWEQzQ2dTY0QxWHliMFRjZWtZWGdMd0xvSzcybnI0ZXFT?=
 =?utf-8?B?Ky9rZVk5V2JGQTBIZm5QZ3J2Q1A5SDNIU1JJNWk3c3pDbE5mUFZlUEZabDRJ?=
 =?utf-8?B?L3RXdFhFMHJTNDdUS05wLzc5M0xvUTBFRkQya1NGZjZnaDk2VTNhdUxrRFdY?=
 =?utf-8?B?YjJYOWtuMDVPbjlLK3ZqVG5kN0N3b2lBbkJXZGdRY21UbFdiRk5SNU5pemg1?=
 =?utf-8?B?dDFlMStFVC9JbVlocWVla1lFd210S3g5NGdhOUtkTHpCeVZlYWJsczdJc2Zk?=
 =?utf-8?B?R0R3Qm5uOTR4MVk5UFY3TnZzNmlnNXYyUDZsTG9zM0Y2TGtNbmpQUnlUUUp1?=
 =?utf-8?B?K2RrRDhNOFl6Vk14TmZrUlJhZ0E3ajhDVlFta2krclk1ZlNkOG5McXFhMmZ6?=
 =?utf-8?B?YU5GOTlPVmptZTFvZ1FSTFkyQnRhVEVPVjcxWmRoTGl6WFBMekIwYlhqb0p5?=
 =?utf-8?B?UjRlaGwyZGo2WVF4alVDbXVGL1BvQlB4dEtPdkQ3K0dBdlNrL3dmeU1IOCtW?=
 =?utf-8?B?TUtQMHc1cENhY0ZDRmRDY29aMTRyZEtGQlpJaFJwbHVxR0RFeDdTcU96RHR2?=
 =?utf-8?B?RVNhQnEwR0Era2JodXhaaCtGYWMrS3JXTWE2WUJ1d2kyR2ZkdTNBd0s0R3pP?=
 =?utf-8?B?dnYvWVp1SExJZGNXZWhlQklUMjRjQnVURnVLVk1Fd3ZvR0xOcUllcUhlUTF2?=
 =?utf-8?B?SkFhSStoNit2N01CUG4wTHJQY1BhQUlnV0dEYWpJcW00QkwvRzE0bWJjNE92?=
 =?utf-8?B?VEhBWUt1NlRnVFk1RzFnWG1aL2U4S2xtQy9uMTdsd05pRk5PNU5WaUZhaUdo?=
 =?utf-8?B?Q2JVdm1NTGtDTmsrQnU5c0R4THgyOUJPWmlyaDRpZTVGeGpYSy9UajBHek5s?=
 =?utf-8?B?SDFBa3owMnpkemZDK2FiSHJOMVg1MTFZYUxza1hFS3ErUHZhOFZZOVdyRzhm?=
 =?utf-8?B?N1h3YnVyQklmTXE2MUdnQWFGZG9pa1J6K2t2L0hJWS9HcnB2a3dpbnBaK2hG?=
 =?utf-8?B?cGYya0x1WGNzd3FyVGdaOWhEN05La25lSEpiL095UnNhRTJJbTBVU2pLcDJP?=
 =?utf-8?B?cDhNUWdCNENFeVRtSVNvY2JVeTQ1YTZHTG00M1FEVVNvQmpiNmE3MjN4b0kz?=
 =?utf-8?B?T01wT2hmblAycW1uZ0psYnNySW9ZNFZKUE9BajdKVm81TmlPZW1HQ0JtWXUv?=
 =?utf-8?B?ZUJqNGVYSlo0QzRrNCtHMnRXdWE0UUxLUVZMcXhQZ2VBcER1a3NDbWVmaDl6?=
 =?utf-8?B?Nmx6b1U3eEtTbWpJNitzYmFPWnNBWVlZTyt1Mm9LR3Y0NXVDYUxVSWFTZFZF?=
 =?utf-8?B?MnN2RkQzcmplSlMxL2daZmxMcmlaMEtvR1pUWUlkZC9RSXgzbFhqSU1hS0tB?=
 =?utf-8?B?SGxrS0g5QW5oTUJRb2FlUzJINnlqMkZLdGkrRVVIRjhtM1RLUU9sMzJHdTQw?=
 =?utf-8?B?VnA2SEZ6QTBIQTR5UEVvVjhraUVOaG9QS2J0bGpyUk1uRWZEcG1idVRkRkdu?=
 =?utf-8?B?QVpCRW1xVVNWanNBaXVaR3lYNENNT3IxVmpPa0ZxNTVKSFQxWUlDRFg3WHk5?=
 =?utf-8?B?c2d5Z3psZlBNL3JaVGJMZlJGWlRRbFM5dUNpNHpFNFhWZDQ2RnVSWGdRS3VZ?=
 =?utf-8?B?WVZMWUpVb1JHQjZoaUhJaXluSzFTTk1yV2gzMzJhTFNla2Q2U1F3bm5kcmd0?=
 =?utf-8?B?cjFPY2FPeTV2VzNUTnhqME5vK3lFTVFNd2diOU9kYXhBV2tvSFBVMHI0Zk1L?=
 =?utf-8?B?dVo4eXRWbDZvb1RaQ3RoTVlnWFFMbDJDenRMbTBNL0Y3cUxYTjRUQkJpTkFQ?=
 =?utf-8?Q?s29evuqaT9IOZuXiXI53ya9YQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c25ea6f-9bef-4f1b-2f92-08dcbc03c681
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 01:52:38.6762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsoCI8xWCVmMY3Ktb8W+xPsKjpNOBholLSPMou0rGALkBQEXxhq3ZS5iNFdJc67cQrazKo07xRAbtZAjIjIlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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

Hang on a second. If there are production GPUs that only work with HSA_OVERRIDE_GFX_VERSION right now, then we should make those GPUs properly supported. I thought this was only used internally for bring-up or maybe externally as a short-term solution before we upstream proper support for new GPUs.

Regards,
  Felix


On 2024-08-11 22:10, Zhang, Yifan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> I agree that adding exp_hw_support is a safer approach. My concern is that HSA_OVERRIDE_GFX_VERSION has been used for a while and has become a status quo for running ROCm on unsupported APUs. I'm not sure if this approach will be a burden for APU end users. Adding driver load parameters is more complicated than simply adding an environment variable on consumer PCs.
> 
> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Saturday, August 10, 2024 7:37 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Philip <Philip.Yang@amd.com>
> Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save area doesn't match
> 
> Maybe we can turn this check into a warnings if, and only if the exp_hw_support module param is set. That way we don't water down the checks on the production code path but allow experimental setups to run without a seat belt.
> 
> Regards,
>    Felix
> 
> 
> On 2024-08-09 01:39, Zhang, Yifan wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Yes, I think we need that change for a normal code path, but this case is introduced only with the HSA_OVERRIDE_GFX_VERSION environment setting, which implies that "the override ASIC is compatible with the real ASIC." It is intended for experimental purposes. When a user is using HSA_OVERRIDE_GFX_VERSION, they should be aware of the potential risks it may bring. Usually, HSA_OVERRIDE_GFX_VERSION is used to force an unsupported APU to be recognized as a ROCm-supported high-end dGPU, which has a large cwsr save area, making the operation safe. This check was added to KFD two weeks ago, the HSA_OVERRIDE_GFX_VERSION environment had been working fine before that.
>>
>> Best Regards,
>> Yifan
>>
>> -----Original Message-----
>> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Sent: Thursday, August 8, 2024 10:46 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
>> <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr
>> save area doesn't match
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> In this case, shouldn't larger of two sizes be used. Also, we should have an upper bound check.
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Yifan Zhang
>> Sent: Thursday, August 8, 2024 4:44 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
>> <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save
>> area doesn't match
>>
>> If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space and kernel use different spec to calculate cwsr save area, current check may fail create queue ioctl. Change error to warn to make create queue succeed in that case.
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> index e0a073ae4a49..9f283aff057a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>>          }
>>
>>          if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
>> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
>> +               pr_warn("queue cwsr size 0x%x not equal to node cwsr
>> + size 0x%x\n",
>>                          properties->ctx_save_restore_area_size,
>>                          topo_dev->node_props.cwsr_size);
>> -               err = -EINVAL;
>> -               goto out_err_unreserve;
>>          }
>>
>>          total_cwsr_size = (topo_dev->node_props.cwsr_size +
>> topo_dev->node_props.debug_memory_size)
>> --
>> 2.37.3
>>
>>
