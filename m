Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13984E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 19:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C26710E51C;
	Fri, 10 Jan 2025 19:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g0ILOQIK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E0A10E51C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 19:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcQpR4Cg2iLJigjlNs5MgCe322oAM1Z2yX9p/cfZURcWSVOxfpt6xo7P+NfBRZYR2J5cNZ8nU9AteOGUiDEmujqbqaWBFM3zSOcUCeWp3XPit+Ebb0vGSE2sbUKvsdyPJXUbNnaHSKQ04F87Y1vWCG3wXKQIwA81/x7XC0B3ovObKb3WiFR2VZzTMijnwPlDjsuChNjfJz4dU5cL9chHCqNYblbuAlfrFIsT1ACeUnW1XsSC0pnrm82336FaC+k+nyBEYbhigU/HOB8wDV6b3T0fuOnFmZjNOmByGip7Hh4myCLbm431E/RyIoBUESz21KzFR5dG8etnzhkZL13sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDb55DkdaTGtX6hwe3f1aQs/DiOFmig/2+xj73jHy9U=;
 b=IrKtTmp7Xw8ITtAZ+kCjnjJ6VJZDkc/SOFKVxKzvqXdnfA+tKoOtwRSA+BjYHomwr4AkI5nDHMMczmthVRHu+qhcejr2nMB+AL3aRupE9bPTgNV8DKLzL8gOO+UjLqhWziauI+3qPDwPwmkKE5ynAlZofORzWUROa+QokDFxIY+E0htt1Vn0txcoCcfH9wUaUIWMK2teyNJXi7/g2p00s43Qy3HQfAiZpdaMVOBM1IW4nYFLnjIoWLdPBT2C+XpuEsdyB3VpMs42dmkllfFCLu3VxUsrA+rbFo0J9zpWe4s15NvA3VPwb825RLqqHAHzBpRbTu2hIypoHEIqYpAoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDb55DkdaTGtX6hwe3f1aQs/DiOFmig/2+xj73jHy9U=;
 b=g0ILOQIKUtbpTRzIoEmXFlan1eUTres503VWVLQ5DRwF6hJrQdfTLP5Sh0ZxyPUXTcB+9rrbVcDV13nHLf4vkGYAPX84rV12y0bYXV7rvienz4dZfudNNAPkEzF4+qPPUarndBAkXcOVrOb2I/4uALB66JN5AJy4ulQa2kf4E1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:37:16 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 19:37:16 +0000
Message-ID: <d72b85bc-9fd3-472e-b5cf-e5f83d4aa6c3@amd.com>
Date: Fri, 10 Jan 2025 13:37:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Clear MODE.VSKIP in gfx9 trap handler
To: "Six, Lancelot" <Lancelot.Six@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250109175613.6265-1-jay.cornwall@amd.com>
 <20250109175613.6265-2-jay.cornwall@amd.com>
 <CH3PR12MB907922CB4C7C932825882BFD831C2@CH3PR12MB9079.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <CH3PR12MB907922CB4C7C932825882BFD831C2@CH3PR12MB9079.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::8) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: fd32d059-8b19-4deb-846d-08dd31ae3088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3dHUzVBSzBBcC9Dc2YzWm9Bb3l4V2YvOHJ5U2RXOXBZaDFjeFB4c1VadEFI?=
 =?utf-8?B?M2ZVeE53b3Jiejc4cit0Q1RZWnZGYkdVQU12MUpCWER2RHFmRmFObWp2MU94?=
 =?utf-8?B?bTZKU05TUVpzT0NkT2pNS0phSUIrS1lpNDlKL3VvUWZPRlM0OWdFelNna09F?=
 =?utf-8?B?di9JdmE2U2trNHRjM1p6eXdocGhyQ1NON2tjRHY2aUxRa1lzOUpWbmJ3WkpX?=
 =?utf-8?B?bEQzL0UyaDFNWUl3d3hMaldDOFBMWVM3cDRQY2EvUE5idEozamJnTVB1ZzlV?=
 =?utf-8?B?OTdwd1NJR3Q5M3ZQdi9TZjlUelZZRXJ2TVIxR0hnVjEvR1paa1RQYkhGbGVC?=
 =?utf-8?B?V3hsMzQvODFiUGRyK2V3L3N1b2JYRUJHWFcwanYycXk0NmxjMjBSMFpSSytJ?=
 =?utf-8?B?T2kzMmZvNEZJMFVzRDRYbStpSStjRzcwQTkvOEhCYWFqUzJXR3JHWDhzanpH?=
 =?utf-8?B?aUhzenkza2R0dW9ZdE82Z1I4dDcvMGErUVMrK0pqajRsMUpaYkJPTWJyM1pB?=
 =?utf-8?B?aThhNjRwS204K3FWTkFnNXBNQytraFZzaHM1SUdEdllEM2NzekFOcUpKak82?=
 =?utf-8?B?dmdsd1NmTFpqZEtvTDUwdGJOUHNrZFpZQ0lXdk9WQkQ1a2lJbm1ieVlrM1Yv?=
 =?utf-8?B?ZHBzaXJ6UDNobmZzdkZibnRaUWNkM3pvTkNIcEhMQ0phaW8yMDZkcndhbXZq?=
 =?utf-8?B?NmlaMFBrZzdyNGJCN3NBaGxqaFRINzhDQmNPbnpQTEMyNTJyakhwT2lZUnpx?=
 =?utf-8?B?QXZBYmQ4NnUzL0NESzJOMXdMSS9MMXdpWWFvQkp3OVhOVjNJTXpNYWtLaW9r?=
 =?utf-8?B?SlM2WXVySWRMSU1Zc3BRQURLcEwwMEZyaEhJUmduQmJkdDkwaHpPeDZVTWI2?=
 =?utf-8?B?Y2NVNFF2Y1NsR2JSaE9SbE8zVENBNnpwRkFDWkdSWVRGRHVVeC9qQUp4Wjli?=
 =?utf-8?B?d1R2ZXR1NHM0RkVSNnZJc2Q1OUFLYXFEb3BZNnZLSEVlWlZpaXNocWwrOERy?=
 =?utf-8?B?UVlMY1QzSjl4SmVSbWVhSTVmdjMwRkM4NlE3Y2JtSUcvYmZLNFoyYkRyVjg3?=
 =?utf-8?B?MXhvd0NxTTJTN2x2b0lGMEhTK3hQc09JTzRkY1M2c3A5SGFmMDMwZWVLT3Vh?=
 =?utf-8?B?WFYvMUNYaUZSaXNDZkRncHpGY2QyTzNkaTZVeVFsNnJwNEl0Q0c4cGhHeHlN?=
 =?utf-8?B?R2hLT1RsYmluVmhJZnJxc2NTSmRUMWp6RDJLa0RUT1NqMnI5Y2hjalc0YVB4?=
 =?utf-8?B?c05nU2t5VGgzeGZDb1hCK2NYNFErTXRiWFBzbC85RGUvd01wN2NpNkNDS2ts?=
 =?utf-8?B?T216TVFtZDQ1MU1QUVRYeFNUclRPSXBhWkNvS3pZZGtmUEk2cnpjOHJRMXZv?=
 =?utf-8?B?cS80K0JEMjN5dHgzZXFqUmJ0aVg1Y0hBYjVsNm1PdXFVNWp2aUozb2RRdHpq?=
 =?utf-8?B?VDRFb0NDQXM5VGM0WlZrOUYvcDVGVHdDdTZvbWJueEYxS1FZQWJpRnd3dmhO?=
 =?utf-8?B?cGt0aHpkVE5ERnZRckFKN2ZNWTB4NHhZYTFkN3ZpanNuQkRRSHVicnYyZloz?=
 =?utf-8?B?U3IrQ05aL3VWeEJPR2ZLVmZTa255SlkxSHowOEE1YkZWeVBadnB6bkY5S0VY?=
 =?utf-8?B?dHM1Q2hPSFBPWjJLcitWQldqR2o5U3AxMWxtbE5rWG9jUFVUcGRER2NLMURU?=
 =?utf-8?B?OXp1Vm5ldlZORHlNVlVCdlNTT20vYmVHeWYySmRzOHgrQzVTQ1NzV2xFcGJl?=
 =?utf-8?B?MTgzQ3RIaFJYMXdyaCtBTVRmRFI2cGJwNEhWeXpXWUtKdlJsOU11VE5PZ3kr?=
 =?utf-8?B?K091eWxoSW9NWHo4TGVjV2ZSeTNRWGppUjkwVisrQWNFc1doVGFWd1lWQy9Q?=
 =?utf-8?Q?/Ge6tIkiTgszI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NHMFVRTG5nMEpsblQwRzF1Rko0dUM5N3FwV3ZRTVQxR29IWklHWnpuNmQ5?=
 =?utf-8?B?VHdxYUhLcTloTHR1Z3ViMEdXWWVCUDhVNFN6ZXZlb080YVRRUWNTM0ZSUjNw?=
 =?utf-8?B?STNiZi9zOWRpcDl6N0FTZW1BRXpwYlJaWmJERkZvNVlLb3dXYnEwOUZqVDBM?=
 =?utf-8?B?Q2lvcVQrbFUvVjkyVVoyTVN1Mi80RE5kcCs2WHV4Q2YreUU4Q2tFdDBOK2NN?=
 =?utf-8?B?d1NaNUxKWng3TEZCc2k5ZjFSN1ZRem9hcDNia3pqeU1xQ2ppTTNraE9pd3U3?=
 =?utf-8?B?aHVHYWNZL2lrcGxNRUVvcnpYVUdGK0F4KzhnVm1yRDlOd044T1pTT0t2YzZU?=
 =?utf-8?B?ekNmSGwwM1FTV2hRZS9XMDNBQS9EVFVrYVJBaGZCOEpiVndXUWx5VVdFdW9o?=
 =?utf-8?B?OFpSdjM1Tms2Yld0UzkvbGhmMUdrS25rbzRMU1RtbVJsK240d21oamFRMnlK?=
 =?utf-8?B?c3YwdXExRzRRYlVrcjBvbnVTYmZES3dzWWw5VEZUWnZxTzdXNWJ2RHMvUlZM?=
 =?utf-8?B?blRUOFVTa2t3eXRISVk0eU9FUTl3ZTF2TUgvN0dJd2lTZFErNUo0cisreGFS?=
 =?utf-8?B?SDErM1oyTUxBWDNoL2VMbCtTU2o1NGFKengrWGYwM1BSWTdZUnNPRklud0c4?=
 =?utf-8?B?R0czYjNtYWRMSXc3Q3BERE1QY3luWmhFc3YrWlphemZqdC9iQ2svN1V6ZnMz?=
 =?utf-8?B?K09kcWlHa3R6cVdGS1R6dVd6Q0dmNDZLdVpCWmVlcFVLdi9KR2VLai9ha3Q2?=
 =?utf-8?B?Y0tmN2Z6ckdVK3d6M1gzMHdtMHM0R3U3dmsraTQ5bXFZdm90NEZ5THRBc213?=
 =?utf-8?B?N3NTUGlrS1dyc0gwQkFkRlhxbVFpTUFRMmhjSEZ5MWY0czViTTBtTW93c3Nk?=
 =?utf-8?B?TWFyd294WU5VY0htVGtlNzRIZzNleFFGSEU4UEY4UW90b0dsZ1cwbGlZR1ow?=
 =?utf-8?B?V29HTHljYTROaUkxMndHWkZGWTBnUHlDOGgxWVNndXBvdmNLeXdGb0Uvd0lu?=
 =?utf-8?B?eHNMTU9MZHVhcEg3dzI4cUdETjFFQXlubmFFQmN4RFFRNUJ2UmF0ekIzT1Bp?=
 =?utf-8?B?Syt4QW11RGRZenJPMVFQTmpPcHN1TEN5cjAwaUx2Rk9pSDJ2eDRzTnErcXdT?=
 =?utf-8?B?Y00zQ1NwUzJuZ3krY2YrZWVDL1NLNXI2bG04VFVwdThnUllHTnBFd0FlajBu?=
 =?utf-8?B?NDRUc09DaUgwQlNwSzBOL0hhbnh1Qk5ZRlR3cjlKRXlkMWhOZDNueStxaHhS?=
 =?utf-8?B?YUo4ekZybWluVFV6RnU0YWhxTklTekUvRXdWSWZFUlU5S05jdTBGL3B3eWU5?=
 =?utf-8?B?M0xsQlBFcmJjUDF2S2hOK2xDMWxMUFQrTXY1VTFzR0lDSjhrMmEvdytRcm1B?=
 =?utf-8?B?N2xjOFZwYmxFaWR3NUVVaWswZzRnRDBsZTVhN1E4NS9uU0tPYmc2Q3JjVkR4?=
 =?utf-8?B?eklCN2xJd1NtekJBOU9ZNCt2NXVGRGtYRUZQUXdlOTNhSUtWN2t3OEtjRHlG?=
 =?utf-8?B?M0p2S1FhM2FVTEVNZVlOYk9aT1ZRRFlSYjgrSGxnSG1Ncjh1UUNnYUg3QjZG?=
 =?utf-8?B?cldwZHdkRllnVFdKYmE3NWdPTWNKYkVURUJZYzdOWVh3MkdjclAvTjZOOVo3?=
 =?utf-8?B?WDY3b29uQWQ3M3ZiQVM1ZnBFQmowcVZiYVFsdmo3aWlSSUlvVnRSY2VyK0Y5?=
 =?utf-8?B?aFFtWTUrV2RQUVZHN2hCTGxLNVBJb3ExaWVlWjZBOWRNcXJFSkxEWHZvZk1m?=
 =?utf-8?B?eFNkazhMN3JPWlQ1TDRPWTl5NVJkc0R6UVA0b2xNT0g5RGJuS3JFUTVkN0hx?=
 =?utf-8?B?aE4yZy8yU1hweWcrQWtEQVpHQnJNbWl2eG1ldFJkaFM1SWZhcnp3bDFXNUpC?=
 =?utf-8?B?aWNDWFU4VjJ2WEg4MFlZcks1OCtidkRRSlZnQmhzVHFFYUloUll5SW5MVnBh?=
 =?utf-8?B?U2VzWGhIWUsybGhubkgxZi9oUFJkU2FhcG9ZdEx4d2lWYUt1bmYzU2VhK0lV?=
 =?utf-8?B?K2g0SGFrcStzVllQWmNJLzJ6bTd4UlpxWHBsNkVPYm1Zb0haUlN1SVBEUVdy?=
 =?utf-8?B?ckdhSzRBUGdUR0FZMUZwOXplYTdRZmNNZTYwYktOK1FQZGJPMStybmN6cUtH?=
 =?utf-8?Q?cm4lRzH5/Osz5eExeMBNxfLoG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd32d059-8b19-4deb-846d-08dd31ae3088
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:37:16.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xf46apORbV289cWd0CoUDXNo+QvGM3gXcY3ELjNbSBgEHY9DZJg4k4QIU1qYAMux033w/CpKBoBZoHSWBeiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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

On 1/10/2025 12:14, Six, Lancelot wrote:

>> If user shader issues S_SETVSKIP then this state will persist when
>> executing the trap handler, causing vector instructions to be
>> skipped.
>>
>> Restore VSKIP state before resuming the user shader.
> 
> Hi,
> 
> I agree with the patch, I just find the text above confusing.
> 
> Reading this, I'd expect to see vskip to be resumed before s_rfe in the "non-save"
> path.  However, that patch touches the save path (disable vskip as soon as MODE
> has been saved) so the rest of the save procedure can work as expected.  VSKIP
> will eventually be restored in the restore path when restoring MODE (no change
> needed), which is done after any instruction that could have been impacted by
> VSKIP has already been executed.

How about:

VSKIP state is already saved/restored through the MODE register.
