Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F6CCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206F510E00D;
	Thu,  9 Oct 2025 18:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TGccA2IT";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AFC10E00D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqWrHamfUmceyBBil43o0oxchV8DTz8cThPjiaEwRKs2z39oU9mER4hNowFZvAY5TcUblX4FRrOFtHJ7ijaGuQOXEsT6AGoYwwFoStNbNutnSFYmT2C6CeZck1nCo7HkjLbaTjpC+lmWxHYzuEAtOKBiNPpO3EqwQZNew8eV1Lv7jUhRNv5boK9D7kH7AhwQnMrWaDKH1i4R3DoY8rWfPjRb92E3tz/wm+k9V1dps6MXK5mA6HEUy4b/7CMuzXKMndtTHfC+JWo45HbL02CDSOtlSrkkaa93kRs/aMTcrwvgWjrsjKbcjgXDA2ZAvAxmDo3zAn9x3lVpdwnTjYlkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwruw+KdvEjqRT6OMsbfeV9QXECaesYwsZPNItegDqk=;
 b=V+kUPT23mQSCZiBT3QvP8zZXqPCz1Q8rQUgsHFTjmY3YMZgGc9d+ERO+d1/rbiYDzNSRXCbxtJ3vTyBjgeI4uzk0vZT3E9N99PWoG6nPsgFoRrr3nDnfXLWo8/n6IZu8v7dJMSE3UVYxOPq9KFVEIzdbHLty2R3xbS/6CDSKb72D3hT8tnqIRdfSgfFtqGgH0Mb3nALDYXCaTH1070JiuvJdbPyHNWWWkWUz2EL0OQ3A2WiZd+TLf1s78PwlGjtYbIwwvPHGY1L7U4HXywaFRTdotwvGLARxA+yDo9bfl/HPlK0jYTq+fV782qU+1z/Un4mB5sVUQ9FwIQVohRVwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwruw+KdvEjqRT6OMsbfeV9QXECaesYwsZPNItegDqk=;
 b=TGccA2ITOgdZXBtgoZKT1bede23fbY/BjMPzYpqsWqiFMDg9ATFW00zV9ggowwZ0irOPA0/L11jC6qTmgPuM/UuuHCqgmNTa6weoDX9+iEFpuBJC38rV3FEusZHLFYhD7f6Xq+eq7PXV9SH3fidbGUXSRFEZ1wMdTnpqplRxCzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 18:28:00 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 18:28:00 +0000
Message-ID: <f2672baf-1f02-480d-a8c3-54f7f7863695@amd.com>
Date: Thu, 9 Oct 2025 14:27:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "siqueira@igalia.com"
 <siqueira@igalia.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
 <f7bb25e7-0a64-4057-b068-5fb63d5d287e@amd.com>
 <DS0PR12MB6534854A0932A7E3E0D05D939CEEA@DS0PR12MB6534.namprd12.prod.outlook.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <DS0PR12MB6534854A0932A7E3E0D05D939CEEA@DS0PR12MB6534.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:52d::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eef2691-00fc-4d06-c455-08de07619320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eERQM0Rpb1hWd0g0YUJPZ3FYdUgyZXhRdUVFTUgrTFdtb0o3UHNRUzMxcjJN?=
 =?utf-8?B?VDdPUFRScmFXRElER1lpZkd4MGsrN3VtZ2lRZXZRcVhJMU8xbEVTTXVZUzF4?=
 =?utf-8?B?YzFMd2pmbVRNdUNMMytOUDROWFhOWnNTemJMTEdwS2NiOVAyY1Arb2lQSHFo?=
 =?utf-8?B?M0VnNk84T1RHTjZ0MXhxUjFpK3B2eU9hLzdTbGI0NWdMTDJaVVUyUXlSaXc5?=
 =?utf-8?B?bWdnTW5lT21jY0l6ME1ONy9QM2N5bVdEMkhBYmpZOXBiUW1adHo4Zkk0RjlK?=
 =?utf-8?B?ekluSVBYTmRCMnFMQys2QWdlRFNFNVRTd2p2c0FwYVI4ZHc1djlpenVtUkcz?=
 =?utf-8?B?dXpFYXRWTXN1enNUcWYvei9IYXFkNVJOQ0o3dW5pVXVkWGpDKzI4R1hid0xS?=
 =?utf-8?B?NzU5OG4xTUlncHdkdTFoaDI3ZUhWZU9RZlEvd25ad2VXVFlnV1UzN3JyakVa?=
 =?utf-8?B?eGVTeERGak45cHE4VEl6NUdyUEpXeGUyRzJvZWhubkh6cTJSZzZYbzMrOTZE?=
 =?utf-8?B?MFp3MWFOM1BqSld4cEVEZGZycXZBL3M2bzFyUTRhb2paeU1HNGdHc0JWamFQ?=
 =?utf-8?B?SktoSURyOGtVQUxaNTViN2Y1ell5NWk1OSt0aHRwNVpEc3FRMWxrOE1PTnAr?=
 =?utf-8?B?dXYxWDZkVzYzaGUzdk9OSXV1TWNEeFlUMVZvWTk2QnVZTE1KQyt5aGRCd1Nt?=
 =?utf-8?B?ZENMeW9HdHJxSmZsdUxUUTV3TE80SStoUmVVcjBMZ3AxS0M0b2dpaWJoalhs?=
 =?utf-8?B?eW91akk0ZWNIcklMcFlvdTFoeEZuazc1S3pQRUR2b2lMOVRiR1ZGcVdENW11?=
 =?utf-8?B?ZnNZbEZwdjdXR0N0eFRlUzFTQ052MEUwM3l6UUwxZlhCVTd6bVZxZUJlbWhZ?=
 =?utf-8?B?NlNNbENobHlLOW82VHUrSkpDZU9keDlKbjdTN3hVUkdiNnZMK2lBeGRyMHI5?=
 =?utf-8?B?NE16SGw3RHdwZWM1S3lpeStpdlA0Z01pQzlNaEhIc3BwamtsL1JRQVN1dmxK?=
 =?utf-8?B?c0cwekZ0am54emZLb3ZLOGhOZ1F6QXlaY2tsUzFwbEhnMTdvV3p5ekF6Mlps?=
 =?utf-8?B?bGlNTU9LRnRiWmZoamljWnpPaXJaenVmaitkN0hjeXV2TU9xYmFRZ3htbTly?=
 =?utf-8?B?YmlhK0NHNVFpSkRYZkJjaDVUSDFaRllaMFZhakVpcnNlN3ZHM2FrdE5yeHYv?=
 =?utf-8?B?Z2o3cTNsN1R3VjRJVDB3bThHT3RzVzRhMlJQcC8yQmF2U2tVclRpUktlclBE?=
 =?utf-8?B?ZnBhLzFVTHdtTGliMjBxSGFNakxGUHZsM1JRT1VQdE8wSVpRVHBlOFBTZzR1?=
 =?utf-8?B?OXVjK3RiemRIamFHMkhXaU5nUWhHNXNxcTlnR1lDbk53dzFabE1VamVtQTMz?=
 =?utf-8?B?QWVBOTJxbGQyQ3NxVmZsVmlCd0ZvNFZnRUtQMmZBV0FJMUNPS1hxS2I4Rmh1?=
 =?utf-8?B?NUFWbll3Rlk4Si8vZUY1eCtqdFNHaXdRM3BDU1AvMXpWQUM4NFZ5VGZGS0xK?=
 =?utf-8?B?QS8zemc1M2s3SGtYNFd1K2ZzaDRBdkkrcU5HSUIybVN2U3c4bUhPak1pMFdX?=
 =?utf-8?B?NGRrdkRYSDJiTUMxL1NzS3czcjZvbWM1dWgyTTJXRVkvUm9kaWtNcndyczh4?=
 =?utf-8?B?SVdITTlxV1ZaclVQeE9Bd1VtbHpSQllqejR5N1BzZ0ZSTnlZQVhBaTBxWTZV?=
 =?utf-8?B?bUh6bHkrUUhJcmxOc0FLeUtsQlhnTklUc2RyNzNraEp6cmRwSFNRNWlXSjdV?=
 =?utf-8?B?RC9NclRCU0ZGY2RDWlZpVDh5Q0tyT1ZuOVdlTkpkVmlpL2g5V2QxeWwxNVln?=
 =?utf-8?B?ZEVCMlhmTlZBdG8zdjh2bWp0SkUrclBEUnMzY2h5citpczhJdjlGWHZ5ODJQ?=
 =?utf-8?B?bER5RUo3am9mcVc0MlJkL1FsWVpEOXVOVzhZRzB3NEtrQWNFaWVhdThoZFox?=
 =?utf-8?Q?vvV7/PerNeeofA3Ggam/5GweR7DxKaMo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhFNGx6ZEdkSnpMSHB4MlNKRGIyNys0elJCOVZzODNwWnZTd3VWQzVmRUhl?=
 =?utf-8?B?aWg3S1N1YnFvbzVheGh2MmcvaUQ3VGNSRnpnZ1Jma3FrQytuYm9VcUhpTC9s?=
 =?utf-8?B?bnBBek1DVTc5OXBxVkJJRDhzSFluaERCUzNhRlpveGxMRDh2eEtTMGpPbnR4?=
 =?utf-8?B?ejNrODNOMldVM3R5MGtZUGhlUlB4YnUxQytBV3FBVkV1NHZKM3JGUGVFdGZX?=
 =?utf-8?B?YmJhQnBZWTJDRFVBLzJ3RVNsV0laNnR5YTRGZ21Id0VoelJqSS94bG9ZZDd2?=
 =?utf-8?B?ZDgwYWU4UFFYZlhFbTJ2WGVRRnVoclJhbm5ldzdhQy91UElJdWpYTC9oY3JY?=
 =?utf-8?B?VmhFRDFWdHhPM0xQWjJIWmdpSXNHRysyR2pnUEZiSkFWOVh0Z1NWdHgyc2Z6?=
 =?utf-8?B?U1FHdmZLWnliUkxEa0h4SWt2S0FTd2FUSnNUSzh5OExxbTFuRkhPZU8zMWNq?=
 =?utf-8?B?RUtKVk9KcktuMUNQSE9Oajk0VEJwMk4reUZDL3NDVlZXcGtlUG1SdWkrUnl3?=
 =?utf-8?B?T2t3bUEvZWh1cFExeFZpUkpuYnFBRnRiY0MyTVQ3VDk5djdiQlNrWExOUloy?=
 =?utf-8?B?TjROdVhKbnVabzVTa2FYaTV3SjVNVjh3cXRIT3MrdnA5UEI2Y01OcDJydFhS?=
 =?utf-8?B?MmhXUEZlYVVtWFN1VC9rQkhPaWszV1Y1c1kzS0IyK0lNT2RzTC84VHY2Tjcr?=
 =?utf-8?B?RVlqZUVMb3BLdmUzelFLeWRoTzAxMDFsbUk1czFQeXZwSDUvNU9nYml5QVNS?=
 =?utf-8?B?MjFzTmMwelk5aGlWZldPQzZGRTh0dUoyR2Uva2N6MFZNVE5rVHlqc1NmUVZI?=
 =?utf-8?B?MFdvZ1NEWG4xMnV5ZnlpSzA5dkw0Z1Y5QmU4dzRGNzBrRHAxUVZOdGltKzBV?=
 =?utf-8?B?bkdNVUhHd2tDZVBWR1hXUG5oNHNQT2tDTi9HTHFtdFNTMUF2NkVKTENtUnZD?=
 =?utf-8?B?anZVWVV3TWFFaTdJSFNCNEVuR3hwZmJLZHVSZjNMa2xsdFQwVk1kRURIdzNV?=
 =?utf-8?B?RVNFN3lnS29GRStkVEEvcTk0Ri9LaktGbFY2YUh1SiszR21PSHpPNEwwVnQz?=
 =?utf-8?B?ZVlUazVPNmhGblhQVmpMZ2hvVUR0a1lkc1RlZEhFbDRwRU1QSEVuY1JHNjN3?=
 =?utf-8?B?SWhVUjZIL2xPY3V1Q1F4eElhY2FqMk1IVDZZam5kWW9hcTUzbzRmWDY4ZlRs?=
 =?utf-8?B?cUxGZ0N5TGU3MDA2V2lZZ2xlZUVocmkvVHRmVHdUcUdhellFVndoT0p2MWlD?=
 =?utf-8?B?Y3VaRjU0UG54V3RXZHZNZEd5UXZGUk9YdjdQL0QzbWtzb2ViVGlKalRlS1Bu?=
 =?utf-8?B?b2JsRzBuREhXOEgyazduVVNmWWZEdTAvYXhsY0pUTHdqSWMwNnZ0SkxlZmxz?=
 =?utf-8?B?THJWMWVyYWFIeWJ4c3hSN1ZoR1gzQ0FOZWVTSjRtVzRjaHZxeHpYQjBqSnBl?=
 =?utf-8?B?d3hFcU00UzJ5MVF2R29hSTA0ank4ckVzMVl5V092ZHlIUk1lNGxBVDdMMmVC?=
 =?utf-8?B?Y3NrdEZVNVdBS292cUZBN014Ynh1U1VHQTV6TzVSYUdMSkpldVBlVDIwYTRU?=
 =?utf-8?B?d1Z2akVhZnNYRkI1M1czdVNFMjk5aU5mbW00aklsTTZETmNVcUVnNml4TjRW?=
 =?utf-8?B?dGFQWVRpdnczVXNiNXV6d0VGQXJ3cUZVMGJVTTZ3dmdkU1RTL21RRVJBRU1G?=
 =?utf-8?B?MzMvYWE5Wk1DVU0zMHBhY0xNa29CSEs0czloZnpTNGZXSGZlMkdabGZVekx2?=
 =?utf-8?B?dVlEMUxEOVRiYkVlRWFVR0V5V3BVa3YzY3NMSWY1YWEwNHd6UlQ5WHpibFNu?=
 =?utf-8?B?eWpnckJQelNiOTZBekhFcHI5ajZKNjlFaVpvcU5sM2czRjRSRUQ5RFp2M3JH?=
 =?utf-8?B?M2wrVVd6alNnbU9NSVFSQlpZN2FhbUxEdCtBdkhwYU9hanYweXMzbXdLdTMv?=
 =?utf-8?B?Z0hMTy9IQzA5MTRWaGdITy9BVnJFN3ZPS3JDUTlTM3NDVWxtVFFvYm0vUGd1?=
 =?utf-8?B?Q01BRjlHN2tPTURUL24vUno5RFhSVTJQOFFSb01TM0N3WGN6TnAzcFhOZXZt?=
 =?utf-8?B?VjBQNjRrd3BESFZzeVFTR21UN3lyK3V0QzRtaFROemcvMzRYU09VMEN1TjZx?=
 =?utf-8?Q?QQ3aLnJHm9S1dp0ol6nrnyxXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eef2691-00fc-4d06-c455-08de07619320
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:27:59.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3zecZ8m7dB8kipzCFzDsMROgi/y1+npJRDvc79B9TrDvLzgGjbVNM072833l0nu0KYDexobmgbTs0CinLNV9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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



On 2025-10-09 13:49, Wheeler, Daniel wrote:
> [Public]
> 
> Sure, we can add it to next week's promotion, I'm almost through this week's candidate. Tom is scheduled to prepare next week's candidate, so I'll tag him in.
> 

Great. Thanks.

Harry

> Thank you,
> 
> Dan Wheeler
> Sr. Technologist | AMD
> SW Display
> ------------------------------------------------------------------------------------------------------------------
> 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
> amd.com
> 
> 
> -----Original Message-----
> From: Wentland, Harry <Harry.Wentland@amd.com>
> Sent: Thursday, October 9, 2025 1:27 PM
> To: Timur Kristóf <timur.kristof@gmail.com>; amd-gfx@lists.freedesktop.org; Wheeler, Daniel <Daniel.Wheeler@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
> 
> 
> 
> On 2025-10-08 17:11, Harry Wentland wrote:
>> On 2025-09-26 14:01, Timur Kristóf wrote:
>>> This series adds support for analog connectors to DC for DCE6-10.
>>> There are two reasons to add this support:
>>>
>>> 1. GPUs that already use DC by default and have analog connectors.
>>> Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
>>> and their analog part doesn't work with DC. This functionality
>>> regressed when switching from the amdgpu legacy display code to DC.
>>>
>>> 2. GPUs that don't use amdgpu by default yet.
>>> Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default yet,
>>> and missing analog connector support in DC is cited as one of the
>>> main reasons why not.
>>>
>>> Before starting this work, I asked Harry and Alex about how best to
>>> do it and we agreed that we'd like to use the VBIOS to set up the
>>> DAC. So I used the amdgpu legacy display code as a reference.
>>> The first few commits add some minor changes to DC to prepare for
>>> supporting analog stream and link encoders, then analog link
>>> detection is added along with polling, and finally DAC load detection
>>> support, which is useful for old displays and adapters.
>>>
>>> With this analog support added to DC, we could already fully switch
>>> CIK discrete GPUs to use DC and switch them to the amdgpu driver by
>>> default. This series switches Bonaire to DC by default, we can do the
>>> switch to amdgpu in a later series.
>>>
>>> For SI dGPUs, there are other pending patches to make DC work well,
>>> afterwards we could switch to DC by default, but missing
>>> VCE1 support is the blocker from using amdgpu by default.
>>>
>>> For GFX7 APUs, further work is needed before enabling DC by default,
>>> specifically with regards to the TRAVIS and NUTMEG external encoders
>>> which are not supported by DC at all.
>>>
>>> Changes in v2 of the series:
>>> Fixed regression on RDNA2 and newer APUs.
>>> Fixed flickering caused by polling analog connectors.
>>> Fixed crash on Kaveri.
>>> Fixed bug when HPD was high without a connected display.
>>> Reduced code churn by reusing same link encoder.
>>> Addressed other feedback from the review of v1.
>>
>> Thanks for the series.
>>
>> Patches 1-13 are
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> I'll hope to find time for the rest tomorrow or Friday.
>>
> 
> The rest looks good to me as well.
> 
> The whole series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Dan, can we give this a spin in our weekly promotion tests before I merge it?
> 
> Harry
> 
>> Harry
>>
>>>
>>> Timur Kristóf (23):
>>>   drm/amd/display: Determine DVI-I connector type (v2)
>>>   drm/amd/display: Add analog bit to edid_caps (v2)
>>>   drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
>>>   drm/amd/display: Hook up DAC to bios_parser_encoder_control
>>>   drm/amd/display: Add SelectCRTC_Source to BIOS parser
>>>   drm/amd/display: Get maximum pixel clock from VBIOS
>>>   drm/amd/display: Don't use stereo sync and audio on RGB signals (v2)
>>>   drm/amd/display: Don't try to enable/disable HPD when unavailable
>>>   drm/amd/display: Determine early if a link has supported encoders (v2)
>>>   drm/amd/display: Add concept of analog encoders (v2)
>>>   drm/amd/display: Implement DCE analog stream encoders
>>>   drm/amd/display: Implement DCE analog link encoders (v2)
>>>   drm/amd/display: Support DAC in dce110_hwseq
>>>   drm/amd/display: Add analog link detection (v2)
>>>   drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
>>>   drm/amd/display: Poll analog connectors (v2)
>>>   drm/amd/display: Add DCE BIOS_SCRATCH_0 register
>>>   drm/amd/display: Make get_support_mask_for_device_id reusable
>>>   drm/amd/display: Add DAC_LoadDetection to BIOS parser (v2)
>>>   drm/amd/display: Use DAC load detection on analog connectors (v2)
>>>   drm/amd/display: Add common modes to analog displays without EDID
>>>   drm/amd/display: Don't add freesync modes to analog displays (v2)
>>>   drm/amdgpu: Use DC by default for Bonaire
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173 ++++++++---
>>>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
>>>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
>>>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  20 ++
>>> .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
>>>  .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
>>>  .../drm/amd/display/dc/bios/command_table.h   |   6 +
>>>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
>>>  .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
>>>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
>>>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
>>>  .../drm/amd/display/dc/dce/dce_link_encoder.c |  85 ++++++
>>> .../drm/amd/display/dc/dce/dce_link_encoder.h |  16 +-
>>>  .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
>>>  .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
>>>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
>>>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
>>>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
>>>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
>>>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>>>  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
>>> .../drm/amd/display/dc/link/link_detection.c  | 147 ++++++++-
>>>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
>>>  .../drm/amd/display/dc/link/link_factory.c    |  60 +++-
>>>  .../dc/resource/dce100/dce100_resource.c      |  31 +-
>>>  .../dc/resource/dce110/dce110_resource.c      |   2 +
>>>  .../dc/resource/dce112/dce112_resource.c      |   2 +
>>>  .../dc/resource/dce120/dce120_resource.c      |   1 +
>>>  .../dc/resource/dce60/dce60_resource.c        |  29 +-
>>>  .../dc/resource/dce80/dce80_resource.c        |  26 +-
>>>  .../amd/display/include/bios_parser_types.h   |  11 +-
>>>  .../display/include/grph_object_ctrl_defs.h   |   1 +
>>>  .../drm/amd/display/include/grph_object_id.h  |   7 +
>>>  .../drm/amd/display/include/signal_types.h    |  12 +
>>>  35 files changed, 1117 insertions(+), 86 deletions(-)
>>>
>>
> 

