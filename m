Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A5C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 22:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1384410E8A8;
	Wed, 19 Feb 2025 22:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7gDmTOc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415B910E8AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 22:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPmQwLOJBFVVZzAVNFBwN2NJ9vh2xnCGTR2dl35sRtcojxXFcCPVvEOHuqB2xaFYDPq3ydj39s7G79FQOLxjmplervu+bVPRyIPhu+SPdRI9ibCrQXzp3Mpps2QB5ekgLEFQi4wL7keijAeKyFlADa0ofNpId/lX0/qm3BBqR/b+GZgKWnJWDXTXVOpCHUgH2pvpsm6rSMipOVOPkY3mYZgdFqOujme/FC94IxIFa+ySCF9yb3vAwZhgDo7DGzi4CtNznzkvHPmLlfO9VCCLEPTup/uvaa++8A1T7GKLUR6IlHDkuhHGTPOVHlf4gmsEtIlwGI+GEzhiYZxCVoSYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt7edGA28TnkZAAp1g/DrrgK6YbdgS149aLgJgM6PZc=;
 b=c1vtlsCXeaHiY5P4eo0Mf61FdNSG8iJv/gYvk3XbZYRc7NUro/4KV86FcKCe8fHKolfn/DhhzXkG2tfP9WrXgY3BgcxA0nweuRJGDfdvL4rkHmvCJC6VfUoQK2Ta7u6fG+DS6NBN3IJ5FuALbKd4ImssKIUkpGotUUglo6EXdikAb1bulBSNkvNO79XTijN7Jm6+NOZGexVYM+nvWTe3qoF9xWbMiPLAV64UXnVvTclwadb5ByEH3bEqoIxJ354SxvUA7OXAPXV2gzbPyJbrJp477nMz3by7tMO9sqdBnaeAwfLZPVmLuwbXyULGwS3D1Ca1xHyXjxZGdggv/aI8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt7edGA28TnkZAAp1g/DrrgK6YbdgS149aLgJgM6PZc=;
 b=W7gDmTOc1800vkG+sd1bsa4EzBCpMQl2nvSw73dDHytvKy6ns7r9o7ASPntGqx4ZYZjlO6uRzP7nr5gf4zf1cJR3RQ7Ec2HrhEsFL4gRHP8v+viCj9sX21yIvxVPRQ7/UOuONpA7hMedSH4uiQH3bqubVnblW2zurtI75dpgeIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 19 Feb
 2025 22:05:28 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 22:05:28 +0000
Message-ID: <3dd01842-cdc9-48c5-a26c-988042e1f89b@amd.com>
Date: Wed, 19 Feb 2025 17:05:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdkfd: Use asic specifc function to set CP wait
 time
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
 <20250212220341.373072-2-Harish.Kasiviswanathan@amd.com>
 <CY8PR12MB7435DC6F726EBC3E771EC69885FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
In-Reply-To: <CY8PR12MB7435DC6F726EBC3E771EC69885FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::21) To CY8PR12MB7099.namprd12.prod.outlook.com
 (2603:10b6:930:61::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7099:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f54d12f-6b6b-4cc5-6dd3-08dd513184b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG9SbFUraEt2UlhyZldKTy9paVd4TTh6dGtrNFNERmsvczBpWnNNSVFmZEpw?=
 =?utf-8?B?WElKNHBYaEdCMkNJZDBOSmFoUmFkRWJmQndEVy8xL0N4eHdYeEpPNU9LYmEr?=
 =?utf-8?B?U0h3SitDM0Z6eW9rR3BSSDBqc3pJVCtSS1hLTTdKdFdOYmVhMVlkZUFoei82?=
 =?utf-8?B?aEFta0RVaDZ3bGFOQ3lQb3VPVjJSc2YzLzB5c1BYY1lXcjhDTWNOdWdzeEV5?=
 =?utf-8?B?SWtheXFiTTJHWDhyRDBBMGsxNkJDQUdwZ2VCcnQ1bjlkVGNWU0duZ3J6S1VX?=
 =?utf-8?B?TzBoYytYMVhxMmNBSGlzRSsrcDU4S3crUGswN01JNWt6MGxhZjJOYXlYYUhl?=
 =?utf-8?B?bEVmcHRPSXV6eXp6ZjFRbXp3Riswc2FaK2E2QUhFaUd4NmR6UnZaaXlWMEJs?=
 =?utf-8?B?TTNTSVpHc2pOTGRwZU5EMS9LWUxIUjhuQWc1RnE0aXZhbTlWbTMrVDNTNFVx?=
 =?utf-8?B?eG5YQVlsZUdKbmwyMEhCZ0tHcmxWVEF2WEU5dmlWR2pwZm1MdUJrY1dRRy9S?=
 =?utf-8?B?UnNBc0dWb2pmV1FTWTFHaEIydjJ5dzBTaVArSUFiVXd4WHBSYXRXTVNXdnZK?=
 =?utf-8?B?K1JOWHd4SC9KSWl3aWlTSGV5TmdhMUl1NkpuN2puT2l6azN3UXMwSTJFUjNm?=
 =?utf-8?B?MTZTdVJwbXRlYzZDTUNkNWo3M05zS3hNeE95Njg1NzdHRXJnY2NGNEozRk12?=
 =?utf-8?B?NEptbnJwcHk3cHJxTnM5WVFra1N1cG1xdUJHSTdDaFNCaEI1eTNVV0RDWUM1?=
 =?utf-8?B?MUtocDF1Vndwb3VGQnJrZjE4NFNJa3RXZUR2NzN5cnUxV1NlcHJBNUI0MUxU?=
 =?utf-8?B?WlNlSWR3VmxSMHkvb3FGK1BuazFDRVY2bTZvMys5QXNqRkdyY0lYeGk5S1dO?=
 =?utf-8?B?dzRTSHRtbEF1Y0RVVlFoZXZicjdWbFdIRTNEd04xbHRBb0ozV2s1M1BWdkVh?=
 =?utf-8?B?dE5DVWx0MExJT3RvZHZNTHlMc1REUk5BMnJPblNVMHlnUFBOcTNhK0FaN3V5?=
 =?utf-8?B?T1ptVlJnNGlqOW8ySzBhVFV1U1lQT1l3ZkF4S2ZKNzY2TDliV1dZbExtM1Nl?=
 =?utf-8?B?eUFPYWZIOGN3WFhDNC9YenFTMm1XZW42MXZjeG5pVHgzb0dHd3JTNkRxNCtD?=
 =?utf-8?B?eEt2aEg3ajRIbTFBNUpHTS9JTUx3M045Ulp3RC8vZE8vbThJSVJ4ZmovamRF?=
 =?utf-8?B?M3JrVGRYQmpVQVpGWHUwNGx2V1JCa1Y2dHhLdXlhNm12SXUvRGNtTjBEanQ0?=
 =?utf-8?B?MWw5OFlHTk9LTWJUWmhTRDFlclBIdGhwdFBXZFdhdEZnQ0FKajVRZ3c3djh0?=
 =?utf-8?B?anVybXVYZWtEaThGSDdvOFhuVmNZQit3TmJuZGh3M2c5TlQyNC9qUCsrN3p0?=
 =?utf-8?B?Q2xaK1VIRk4vUzJISW5LdDZ1STdYbGxOUzJGMXdUY3Fmck5ISTdnVVVmbFZL?=
 =?utf-8?B?UlVNT0hrK3JaZk5ocFNDSUc4R1g1eVhscUhtdlN4ckVLY0F6bUZ6N2ZjRnRD?=
 =?utf-8?B?UnZOd09nUkF4aUtZdko4RmJqL1VpNUpPbkhXTUZ3SytNMmk0cUZsWmdTMVJj?=
 =?utf-8?B?NFJXTkVyMlVidzNzbk5vdXduVFl0Wm1mY3QvUUFxUDQ5L3VmMlhSb01XWEsv?=
 =?utf-8?B?dGc4Z0g3ZG42S3JTZ1A0RnBUcWUvVXpBeUtucEd4bG1xcUJPeUU4bWFrZnNR?=
 =?utf-8?B?L3JGTUxBdEFxKzVkcWU4WXMxbGViRmdqa2U3UEk0UlBNbm9ZOEhjc2NXZXhY?=
 =?utf-8?B?RERneUIwOFRSN3RXdzNLMFR0amVtaEs2dERCSzY4RklFTGFzeXpGRmY4YWRF?=
 =?utf-8?B?dTJ6cUt6ZytjeUdqQlJSRnNwUGpwdUFGZlFsZmQ1aXNkZ1B5YmpqOGlrTDhs?=
 =?utf-8?Q?KomwP4EDwYYDz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hRRURWZzVXTVJoVVpPWmVDN0llUHRmU1FsTGVKTnpYOVRaU0s0aUF6OER0?=
 =?utf-8?B?TFdSRXNYNHoxTytVRXk5dG1jZkdrWHV1TU9YN1A0WlIxRWQ3b2VSUHNQRHc0?=
 =?utf-8?B?SVdHT0ZrS24rbms5MTNZMWtkUzR5UkcxdFhpWkxTeCs4OWtOd0htUHZQRDB4?=
 =?utf-8?B?dFovbkdDc1cxVFRJSUZJakF2TTgvTlVFYUZrbWdmK1ExSjM2RU5uV1Q2bktJ?=
 =?utf-8?B?RHNqZmVnM1ZUMUgyRGJIVFdjdGpNS2hKYkJhSEFzOVlnWk0wczlwQUw1VVFP?=
 =?utf-8?B?RlNZc3ovc2V6WSt3MFN0SUgrRWRsMnZIcElYS3MrcmlZaWRXT1JzRkk3M0Mz?=
 =?utf-8?B?SmhFZjNYNklUeFFYWTJmRVhFd2YxelFON0MrRElGL0R0N1BqNTlVcUh3TlFG?=
 =?utf-8?B?SGJyVHRmRlhpeHpKL3hPV2dub2c4YXNzK0VpOWUyV0h5cVFWVDJVM2xpMzV2?=
 =?utf-8?B?dkdLbTRESkJHb0lHcHdOcUlqa0Irc0ZYd1kwem0rTTV0a3lTR1hrM0xsaFI1?=
 =?utf-8?B?Y1hKZ2dhNTBzR2lnMEltQVI3Y3RPb3N4ZXRrUmt1blI5U0VIUisrUjFiM2c5?=
 =?utf-8?B?eldmWk8wS0lOYmlheWVzWjI1U3IxeXlWUGxtZjVQS3B3NnNXYm01Sy9WYXJB?=
 =?utf-8?B?SjZhL1pmQTMrSDI5ckFYSFZRSmhHMXhNM3VkM3lYd2FPOFBqTGhSUGR5Zlg2?=
 =?utf-8?B?SFBzSkcwY2VzYUJkNWRjMVVsTnZobkNGcDBTYWtQNXozRmdNTmtJZ2pWdy81?=
 =?utf-8?B?KzF1RnhLMkdyUWtxNEJ6cnhCdHFQY0xVR3lPbThmMG5QSlEzVUdOelAvZzUx?=
 =?utf-8?B?RGh4dGsxRjNYcTdPVUJPWGZqM2E0WVZGT0RmQ1Q4eEY0NktSbGgzbzRCV3hn?=
 =?utf-8?B?cURqODNnd3IzdU5Zd2p1RGMyRVVTNDZpNXoyYW9kRUZSNjB4RkswV3loNDUw?=
 =?utf-8?B?UGFCZGVicGRCOWdaWWdZTWdYZGs2VTVQTnl5SDNqVGl5TU1zQUhCSTVuZGgy?=
 =?utf-8?B?Vk1INHFHdks2TW05cUtDK2RVU1dVekNnekhHVnJnN1RqV3BuWjJMNWdNdnhB?=
 =?utf-8?B?b3ZiTzRFYVg4ZjRUak56Qks1WUFFNG13ZkZ0RVFldmRabzFxWndVUlJvRm5I?=
 =?utf-8?B?dllpd0lPYWgzUXQ2eVg1T0pCZDlVVUFSNDZvcGM2OFBTTkt0KzFuM2pHVU9C?=
 =?utf-8?B?NFNFVklrZnd3a0lMSnMxaWtjYlF2ZUE5bVNEZHhJQkpYZWY5Y2IwTHlhMU1F?=
 =?utf-8?B?ZEdBSFJ6cElGODdkVTE0bGFiK1J0Z3BFVFI1RUJoM3c5QlF6bEJLemxsRUlC?=
 =?utf-8?B?OXFnc3BiaHlxVktPZDRuVVhacmJUL3lFbERLUVpCc25Pd2JPcVBqZUFpMUVa?=
 =?utf-8?B?blFnY090NU1BTzFqNXFTb2NmNnpLZ2xrRHVYeWRnSXRybzVLT1hDTXVPZUNv?=
 =?utf-8?B?dWJRVjNIa25LZk54bDFMNjNCU3VVNVRST0crK0NhMFhmQ2FuNTk1YWJGOGRr?=
 =?utf-8?B?SVJHK1haVFFUUEFyRUtJKzJUdG9lejB1R2VSSUR0ckIrR25zU1BqVVg5Nmwz?=
 =?utf-8?B?YXZESlBUZkVMT2dhK24xV1RnNjZiR3Fka0dXZW9GcWpHTkZtcDdhM0hUUXQ2?=
 =?utf-8?B?OCs3Z2oxb3NUcHc4c080d0oxUFhrcFdJU0ZXcDJPNFltc3NzUEpSc3hjcEdT?=
 =?utf-8?B?dnJmRElxYUVMeElaY2dTM1hvVEpBbnRUVGRhUmkyazgvcWZLSU5KMmZwaGFM?=
 =?utf-8?B?aTg5a0VCdi9MeHhSR0g3U1A3Vjk0OWV6QUdrcjV5N0JHc1E4N0lDOVpFUEZq?=
 =?utf-8?B?eTU4L3UyaVZQMWdGbXVXdDFpUXAyUEducEF4V2dPdTNxdlRlc3RCRmVTZjls?=
 =?utf-8?B?U0M0WHJpYlJLejlpSHFuc25YZ2dtc3lST3VZUCs3bEdpTUZweHpaMUZEVjFY?=
 =?utf-8?B?U081anRBWHlKR1NhQWh6b0pqOG5HWkYvQXRhdURFQVowUVB0cTd0d1U5ZHNl?=
 =?utf-8?B?Yjd2VmI1d1NrTXdRdmpNYXRFSDJVV1QwYVI3UXlVRTlRQm1yMkt4QXNnREg5?=
 =?utf-8?B?WVN4UHlndGFiUld5azJmdFZTUGplNXBwb1hoVDRFUGZOT2lUWXl3VHRpMlg5?=
 =?utf-8?Q?XQ7Qri1UmjnHPdhslca3KGMF8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f54d12f-6b6b-4cc5-6dd3-08dd513184b1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:05:27.9972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EPCeh2eYWYaEiEx6PV4h97B6Z5CcdX04u0bpxDxkYqGW2UNPBh4CbiEhfSUo5omCUymgfyTrkxM42Lhx2AqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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



On 2025-02-18 15:27, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
>> Kasiviswanathan
>> Sent: Wednesday, February 12, 2025 5:04 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: [PATCH 2/4] drm/amdkfd: Use asic specifc function to set CP wait time
>>
>> Currently, grace period (SCH_WAVE) is set only for gfx943 APU. This
>> could change as other wait times also needs to be set. Move ASIC
>> specific settings to ASIC specific function.
>>
>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>> ---
>>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++---------------
>>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  9 ++++++
>>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  8 ++++++
>>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 +++++++
>>  4 files changed, 32 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index b88a95b5ae0d..3eaa44d0410d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1760,10 +1760,7 @@ static int initialize_cpsch(struct device_queue_manager
>> *dqm)
>>
>>       init_sdma_bitmaps(dqm);
>>
>> -     if (dqm->dev->kfd2kgd->get_iq_wait_times)
>> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
>> -                                     &dqm->wait_times,
>> -                                     ffs(dqm->dev->xcc_mask) - 1);
>> +     update_dqm_wait_times(dqm);
>>       return 0;
>>  }
>>
>> @@ -1859,27 +1856,12 @@ static int start_cpsch(struct device_queue_manager
>> *dqm)
>>       /* clear hang status when driver try to start the hw scheduler */
>>       dqm->sched_running = true;
>>
>> -     if (!dqm->dev->kfd->shared_resources.enable_mes)
>> +     if (!dqm->dev->kfd->shared_resources.enable_mes) {
>> +             if(pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
>> +                                         KFD_INIT_CP_QUEUE_WAIT_TIMES))
>> +                     dev_err(dev, "Failed to configure CP wait times\n");
>>               execute_queues_cpsch(dqm,
>> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
>> KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES);
>> -
>> -     /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
>> -     if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
>> -         (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
>> -             uint32_t reg_offset = 0;
>> -             uint32_t grace_period = 1;
>> -
>> -             retval = pm_set_compute_queue_wait_counts(&dqm->packet_mgr,
>> -                                             grace_period);
>> -             if (retval)
>> -                     dev_err(dev, "Setting grace timeout failed\n");
>> -             else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
>> -                     /* Update dqm->wait_times maintained in software */
>> -                     dqm->dev->kfd2kgd->build_grace_period_packet_info(
>> -                                     dqm->dev->adev, dqm->wait_times,
>> -                                     grace_period, &reg_offset,
>> -                                     &dqm->wait_times);
>>       }
>> -
> 
> Btw, is_app_apu is also tied to GFX 9.4.4.  Just double checking, we only need to shorten the dequeue wait for GFX 9.4.3 right?
> Also, I'm not sure if I like the idea of another macro to define a new grace period.  It looks like we could front load this somehow.
> How about this?
> - in kfd_device_queue_manager.h, under  struct device_queue_manger, declare member uint32_t dequeue_wait_override.
> - in kfd_device_queue_manager.c under device_queue_manager_init, do the IP check there and set dequeue_wait_override either to 1 or the default macro based on check value.  This way, the override is set during KFD node init.
> - then in start_cpsh, you can do -> if (dqm->dequeue_wait_override != DEFAULT_MACRO) pm_set_etc_etc...
> That seems clearer that the default "override" is HW IP-device based rather than something packet based.
> 
> Jon

Thanks Jon. I too agree that these macros and even over-loading variable as value & macro is ugly.
I will send a new set of patches as following. Please let me know your suggestions.

- modify pm_update_grace_period() to new name but add additional parameter. Somthing like, pm_config_dequeue_wait(pm, enum dequeue_wait_command cmd, uint value)
  -- This way this API is independent unlike before where USE_DEFAULT_GRACE_PERIOD was used in multiple places.
  -- enum dequeue_wait_command will have three options now: 
   --- DEQUEUE_WAIT_INIT  , value (unused) : Initialize which will be called once. Compute asic optimized value. Set it and it will be stored in dqm->wait_times for future use.
   --- DEQUEUE_SET_SCH_WAVE, value: The value will be used to set sch_wave
   --- DEQUEUE_RESET, value (unused): Sets the value back to default dqm->wait_times

start_cpsch() --> will call with  DEQUEUE_WAIT_INIT
unmap_cpsch() --> will call with either (DEQUEUE_SET_SCH_WAVE, value) or (DEQUEUE_RESET)


For comments on other patches. grace_period will be changed to sch_wave to be consistent. 



> 
>>       /* setup per-queue reset detection buffer  */
>>       num_hw_queue_slots =  dqm->dev->kfd-
>>> shared_resources.num_queue_per_pipe *
>>                             dqm->dev->kfd->shared_resources.num_pipe_per_mec *
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> index 273c04a95568..8a7d9b2a135c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> @@ -38,6 +38,7 @@
>>  #define KFD_MES_PROCESS_QUANTUM              100000
>>  #define KFD_MES_GANG_QUANTUM         10000
>>  #define KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES 0xffffffff
>> +#define KFD_INIT_CP_QUEUE_WAIT_TIMES     0xfffffffe
>>
>>  struct device_process_node {
>>       struct qcm_process_device *qpd;
>> @@ -359,4 +360,12 @@ static inline int read_sdma_queue_counter(uint64_t __user
>> *q_rptr, uint64_t *val
>>       /* SDMA activity counter is stored at queue's RPTR + 0x8 location. */
>>       return get_user(*val, q_rptr + 1);
>>  }
>> +
>> +static inline void update_dqm_wait_times(struct device_queue_manager *dqm)
>> +{
>> +     if (dqm->dev->kfd2kgd->get_iq_wait_times)
>> +             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
>> +                                     &dqm->wait_times,
>> +                                     ffs(dqm->dev->xcc_mask) - 1);
>> +}
>>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> index 8d2f63a38724..e94ed478bf5e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
>> @@ -402,6 +402,8 @@ int pm_send_query_status(struct packet_manager *pm,
>> uint64_t fence_address,
>>   *  @wait_counts_config: Parameter overridden. Could be flag or grace_period
>>   *   Possible flag values:
>>   *     KFD_SET_DEFAULT_CP_QUEUE_WAIT_TIMES then reset to default value
>> + *     KFD_INIT_CP_QUEUE_WAIT_TIMES Initialize compute queue wait times with
>> + *      best values for each ASIC.
>>   *
>>   *   If not an above flag, Wait Count for Scheduling Wave Message (SCH_WAVE)
>>   *      is set to wait_counts_config value.
>> @@ -415,6 +417,10 @@ int pm_set_compute_queue_wait_counts(struct
>> packet_manager *pm, uint32_t wait_co
>>       int retval = 0;
>>       uint32_t *buffer, size;
>>
>> +     if (!pm->pmf->set_compute_queue_wait_counts ||
>> +         !pm->pmf->set_compute_queue_wait_counts_size)
>> +             return 0;
>> +
>>       size = pm->pmf->set_compute_queue_wait_counts_size;
>>
>>       mutex_lock(&pm->lock);
>> @@ -440,6 +446,8 @@ int pm_set_compute_queue_wait_counts(struct
>> packet_manager *pm, uint32_t wait_co
>>
>>  out:
>>       mutex_unlock(&pm->lock);
>> +     /* Update dqm->wait_times maintained in software */
>> +     update_dqm_wait_times(pm->dqm);
>>       return retval;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 8b693a9446e8..6a5ddadec936 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -302,9 +302,19 @@ static int pm_set_compute_queue_wait_counts_v9(struct
>> packet_manager *pm,
>>               uint32_t wait_counts_config)
>>  {
>>       struct pm4_mec_write_data_mmio *packet;
>> +     struct device_queue_manager *dqm = pm->dqm;
>>       uint32_t reg_offset = 0;
>>       uint32_t reg_data = 0;
>>
>> +     if (wait_counts_config == KFD_INIT_CP_QUEUE_WAIT_TIMES) {
>> +                /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
>> +                if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
>> +                    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
>> +                        wait_counts_config = 1;
>> +                else
>> +                        return 0;
>> +        }
>> +
>>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>>                       pm->dqm->dev->adev,
>>                       pm->dqm->wait_times,
>> --
>> 2.34.1
> 
