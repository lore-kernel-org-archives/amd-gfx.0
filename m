Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE87C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 01:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB2210E7DD;
	Thu, 24 Jul 2025 01:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BSJ0Oz4K";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC1E10E1A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 01:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsReiZ/t61xwP0Y0qYDokVwXg3BEPtLvcSXB/XFDtyisIp3wugQdFf1sRBeBT+ccdtd/Gnf6YH2X+Kup8+bKwtnXybHpkQESI8wp+LNf45YjqW5LV5XDUO6urLsr1NIK6VYzEGeM1+j09+NQbFqY/hYgIDwfGmbLA/ArjrfZYetiVxbFBPAI8j96T3eaPsmijbBqPJ4P+DUFSaq/WZABN05MNGQAXOK4X2leosqLCjfaM57b8fV5DAa3FEGF7H3joTk5TM8eGmbBADe6rbDxozYYyIS4Rv8085uxK3usCrRZ/FCFI1ulBAR3DZVR8ddbrxmKX7v/zAjq5E/2Uj92lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4nAc3Ni5a3NZChMP1GwoB3jHNMPmbv+TQat4kyU9+M=;
 b=Hpi4vNrzxZ1i2Coum7VcFmSYdjY6j7rjXxj2Hr5Qay5MA7b+upvBqZz1z2GS2DpvH+qkX48pjG5HLuUBAFxXB5EASkyRKLs4ueuNKIo2w43FTAsh7/UUZkp5tevQuzPrzAPsYxrgP9TbrkMdnKEttkS7ujrTAP6MwxWhYnIUfWuV0fBOOB93KJT3+rN5a7OiIYC2SLGVQD3xxpv8LSSWu2MDUY4amYhDjZo5exMPA9nmZcc0LMUphgOkQ615p4EAM7LYe7agIFnW1KKu5HVyYGdjPaGxYg6NChPEcProFSqv7uIYC7vFDQVOx3S16ZikBSv2nU6rr2SOju/sdrwFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4nAc3Ni5a3NZChMP1GwoB3jHNMPmbv+TQat4kyU9+M=;
 b=BSJ0Oz4KLV7L3kNgF/GDvh341WSNjCTHQchiz1+HHYz2tPI0Gg6nX67srg17RGx3V3eAaLSgmPD/LB4/y0dt5zNgu5oKU1Cr/b1zdVV1JyOZYeWfZEZet02wcXBwKN+hNtgADBvQe2B2LKYIuF5bhuhZv5Tepdt7uFgDB/Ltua0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 01:47:44 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 01:47:44 +0000
Message-ID: <f3fa231c-053a-4164-a8a0-416880d59e97@amd.com>
Date: Wed, 23 Jul 2025 19:47:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Reduce Stack Usage in
 'dp_retrain_link_dp_test' by heap-allocating 'audio_output'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 George Shen <george.shen@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Mike Katsnelson <mike.katsnelson@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>
References: <20250721130613.1291563-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250721130613.1291563-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: eba85e87-0979-4ae0-6416-08ddca541548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0srbC9iQ1FkcHlmK3dwUXpYWVVqa1JldEZveDNLa0xYYXF6SGdvK0l2KzUx?=
 =?utf-8?B?SmozZ1Bwc3JadElSSEphVWdvQ3NWamt0c3krcHZjd0w1SVBkcnVjY2pNWDZz?=
 =?utf-8?B?SjhYTnZuS0N2bkIwV3MxR3AwK3hFQWR3NFI0NDJsNjdWb3dLcGE5S2xPd2JR?=
 =?utf-8?B?TG1TS09ac05jcGlFZG9kMWx4b2pEcUVTSDlRaTVIeE1jbWphVExReUFRR2Y3?=
 =?utf-8?B?ZUYvd1RsOTNpYk1NZGJ2NHVrVFFyb0pSTTJpNmE4MzlJS3RHanlXVjJzNHAx?=
 =?utf-8?B?RFJlbkhzS09peFRBV1d5d1p2OXpOdVVPdlpUa2t4TU5XWndDTlk4dkJJMUlT?=
 =?utf-8?B?RFpEN25IZFY4eWlUdmFFSFUwRTlMV2VDd08xOWdIOExpWTNHbVhPY294UGx3?=
 =?utf-8?B?eGxobVVaT1ppL0FGV2NPU25vUlErZnpOYk9QRWdsZXFKSVUrZ3IxN1JZRnRy?=
 =?utf-8?B?Y0RzSUJHaVVqa1hEbmt0NWFZS1J4anltUWUrVEgvUmlXSSt0NnRSUURIcjBK?=
 =?utf-8?B?N2kvYTJ3YmM5bTFsUTZEZEs5aTBEZ0QvZUo2aGVTSGR2SW1XNWZiRi8zOTAv?=
 =?utf-8?B?YzkrTERrRUMzZUlTcGdyVXNxaFB1dEwzT0pXZG5Xa0xYdk9jcnZpYzAyNXdo?=
 =?utf-8?B?U21KTFpmeE9NWjZpdDFwWmYwZ2p4ZW5lUlFnYU51TCtSSzFQaXp1eW9xT2Uz?=
 =?utf-8?B?ZUdYR1Iwa1NueUlCTklNZm5JNDRBTTdqejdqMHAxQUI4TFgzWnMrMG1semNj?=
 =?utf-8?B?NnIvOTVxNm0rOFpxM2pRNTZMY1liWmw1aUJDdHR0UUxEOHAyN1pJRkVDTkJW?=
 =?utf-8?B?UnJzejNKWmN1NlhaNEtONHNTVEtKaWlXdlpmbE9TcjhCRERqTjlLOVN5TlJM?=
 =?utf-8?B?NlJUdFNxMUp4NDNPa2ttd2s2ZU1TSnh3RmxhM2o5RkpFVThmdVgzSnVRL05o?=
 =?utf-8?B?aHlzKzJvenMxRkRwVVlrWWZLQ1o3MFo3TzF5YURqNm91V3Z1aDAwK0dQVjY0?=
 =?utf-8?B?VmtteXhYb3cxZ2g5RzlYNTFVWmwxeFhvekRZdmREbWsvWWsvNXUwWmN2REtp?=
 =?utf-8?B?MVFWa1c2SzA3RmxLbWZpTm51VXRDTzFCSE4xS3NkclJxVEFYSGRLM3pJcjlj?=
 =?utf-8?B?NUpMZzdIanRhbnNXZ0VVT1lwV1ViQnpSVnN0ODU3cWFPUVNtZUVVRUVvK3ND?=
 =?utf-8?B?cFB0ak9lSUF1ZUxKRkhQRytQay9xalVuWDJ2OEZobTU2QWFNRzBaZnR2S1dK?=
 =?utf-8?B?VGdENlVMVWlORm5DK1ArQzVZNk5JUjE1SHJvNVNOeGxHdWJHMGRZb3RnSnRr?=
 =?utf-8?B?U21jL3oyWVBMOUJ4YVBxSHNUOHQ2dG5BTzNpa0YyZy9FeS9weVNacFloK3Z5?=
 =?utf-8?B?bHlZY2J5TFNMTVlpVk9KeHU5M1ZaRjBqNkV0WXpxSENjKzIvam5jaW5mZDNX?=
 =?utf-8?B?T1JRN2NFL2NFSHBUTThFN0VhUUdPSEF1Z3gyQzUvR0JSSXpINENCeWZJcXo2?=
 =?utf-8?B?THBiSmREd0xNaVFEQnNLZnpseDBBVXFwSVNHMFBhd2NQSGJZRGFRc1NsWGZY?=
 =?utf-8?B?aXNKaFVjZGd2V2twQU44WDBvTkJkUUplc3cyamNEZUM5WitHdDdja0FvMW01?=
 =?utf-8?B?cHJkbmJYRHdvOExBOC93T1N5MkttRlByQWozUElrTStUYkNiRmUyREUycEIv?=
 =?utf-8?B?VUFCUXlJTmpGamo4blB4dHZ3aUI0dGMxNTVoSHlpL3BYMXFJK1J3Zk0zSUs2?=
 =?utf-8?B?ak9MZHlreEVDM2NEVFo4Wkd3QjZXZjRkelEwcXU1VUZ3bDNFcnphbjBGMVdr?=
 =?utf-8?B?V21EN1lPQ25zakU1cXVidGdrek5Ia21YemJVRjBjTStmZjFDYm9DVnhmbEZ2?=
 =?utf-8?B?TXUzMGpRS21ja3Vtb1h2UkVObjg5QXFyNldQdXJuL2FjRVdYbEJrNk5TdmxF?=
 =?utf-8?Q?tZ2+NVzBUEE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2tjMWFmdTdTeGRpNk5IOG4wRlhJRVQzajJNRTFOb09WVUpiUmZqRS9oUXBV?=
 =?utf-8?B?YjZwMmI2ckFTOGwxdjV0aG0wa0JJcTV0cmI4Q2lEaEVQblJIWTE0RjlDcEZL?=
 =?utf-8?B?bUxlR0x0TUFiQVlGZmdxQm1zVmRvczhXNmFTMGJ3NUhNNXFFSGtPSVVNNkd6?=
 =?utf-8?B?VC9LNnRNdVFBSDJIVVkzTy9qak0rZEJ1bWZ0eFNCdTVFNmxxRVVZZlNHTjU0?=
 =?utf-8?B?L0hmYWt2WGJ0US93SThPOGFhR0laOVhFSEl5cHh6RXpwUUROTGwvZGJmVU9t?=
 =?utf-8?B?WWxjSnVSdlhFSWkyeHY2YlNTYmMwUHNlSjk4VjVNTDNMWjB6OS9DVFd6K1pV?=
 =?utf-8?B?Nitzc2hNRHpUVVQyTzE3NTcvYW5IbXF5bmIzbWJ2N0U0ZWw3LzNNVDVsY3Vp?=
 =?utf-8?B?Q2Y3TWc4aXM0aVpXUU44RzZZSiszVzJIZitIQUZPMTQ0ZlRKN01QT1hONVRW?=
 =?utf-8?B?U2dLTngxUlpQc1dXbjVJZTZKbXJoUXorN0RaN3U5UlNKN3VvNGZxMEFoc0Fm?=
 =?utf-8?B?TGR3WVMxekZka1JRMWtsMDh5U3JUcHRnSHdvNWRUNlRjMUI5b3FDRjI1V3Rj?=
 =?utf-8?B?NGhXNmNmQUszUk52UWRUYmZ0enVCQ3pWL0VlT2RiWG9rZHdDS1lTMDRNdGwv?=
 =?utf-8?B?cHNuUHBINzE5UVFuRGY5bkN0UXpMNjYyZTRPcVQzUGtRY3hDZWRCbjgwMENt?=
 =?utf-8?B?MWorNWd0bzVRdGFkOExJZDlrTnNhUzNrbXlmWkNsdm1leExWNTB6VHQwY2x3?=
 =?utf-8?B?TG5DSms1NXpISndpbUlUUDFpUGpQUm9oak1JdmIwVldFRmdsaTlYVDlKemZU?=
 =?utf-8?B?TnFwZFZicm5MRkpqSVBoMjZpVjlTQk5haENPK0p1TVpqUTBYOXRxRE5BL1po?=
 =?utf-8?B?ekk1Qmd3K0pzMjcxVjZ4VTYwSjZLZU9qNnhoVTRoblk5dFJUN0U2Y2szQ0ow?=
 =?utf-8?B?cytFMnZQQlJpNmRncGxibDhxZEEyU2ZnSXlpMXgxSzE5VHhmbWs1ZVZVMXlG?=
 =?utf-8?B?cXVCZHRHRC81TEk5eHpXZjlpd3QvY2ptTzlhZFpCUWhtZWJDY2U1UU81c0k1?=
 =?utf-8?B?endJdG5PV1FMaGliMHQ1dkhNVExOTFhtUmdsc0xsVW5GM0hwNWllZWtCK1NU?=
 =?utf-8?B?Yit2d1g1UWdvb2FhVmowOWR6dmNmdUVZQ2ZDajFOMXcwTVBydDkveVRTeXhq?=
 =?utf-8?B?TytIZVpONFl6a1FXM1ZneTNjUThuTllLRUduMEZuSTBaWC9HS1M4ZC9GbVRI?=
 =?utf-8?B?NjN1QkNFQU1jZ0lSQXNPNEwxbkpTalZDLzFxNW5rM2l1c3NDRkw2VUl6Z3My?=
 =?utf-8?B?MGV3RjlFbE5OMHU1Z0tTQkJBbGNSOFFSOGFHTThVcjM5QjBQb056ZE9QbFpP?=
 =?utf-8?B?TlFQRzhlU3BNUmtueDhuTmNxeGtQTVNYWjdsalFVSkUrakNCREx5ZUxJVHQ5?=
 =?utf-8?B?cEIxUmlmVTBoeHRXUGovQ2pnZ0RiTFJSZzVKVFk1NGxKSFJjaThxSStvcm9L?=
 =?utf-8?B?MHVUMG1qcEdmb2UvdCtjb2k3WVVjL3ZweU9RUkVsT1l2bHYweE95UkFuRG1Q?=
 =?utf-8?B?TGtCMkFub2J5TjFKb0dtMUx6Z1hha0hCbStORFJqeW04K3RZb3Q4UUJZcGxL?=
 =?utf-8?B?M1YwWHJhMS9pWkN1anZkLzJMVWZkT2EvTDRINEMweFBwUXArcW4xaGNnazBB?=
 =?utf-8?B?WVN5dXBLWGRWMmgwMkRLU3dlcGFWcW5Mb05leVhOVGhvVHlFbExJUzdZVXhl?=
 =?utf-8?B?L0hxaFlsbHpXL2toSEF6dU91S2JqTGtteUJoN1FvTjRhQmptMGFialdOT0p2?=
 =?utf-8?B?VTI4d1kxV0pEN3RCRFJVbzR1SDJMb3dvdWlKbzROUXExQmxOTCttT01IT0hJ?=
 =?utf-8?B?UWtPTi9MbDFjUE91YnVlRnF4NVp6c1MydVJQNitmaEpCQVZIeThZUGY5cmdi?=
 =?utf-8?B?UXk5NUU4WGV1bEw1R0tyODZ2bTdjd3NLNkRwMzMrVmQzYUNFRDVSRXB0UW9S?=
 =?utf-8?B?U0thODZFc2wrZ3RxcWhSL1gxRVdPTTR4NGxBcmhOV0JNVytISi80U1RTS1k2?=
 =?utf-8?B?R1d3MkNYb3d4a1g4SFZmWFgyQnY3bGhyZWN6eERCMkpvUDFTZ3lMczMxRnkv?=
 =?utf-8?Q?pQLIK6C89SSjTK0xV4s9mhB9m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba85e87-0979-4ae0-6416-08ddca541548
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 01:47:44.1393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuXU/0mGCxJ7wYzpz1zjTsjHXZXZkEkNYzO3Ti46F5Q2sxsTN+PWo5WnorwUyXKPUapmqX4F5+J30rZNHe7D9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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



On 7/21/25 07:06, Srinivasan Shanmugam wrote:
> The function dp_retrain_link_dp_test currently allocates a large
> audio_output array on the stack, causing the stack frame size to exceed
> the compiler limit (1080 bytes > 1024 bytes).
> 
> This change prevents stack overflow issues:
> amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack frame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe-larger-than]
> static void dp_retrain_link_dp_test(struct dc_link *link,
> 
> This commit refactors the function to dynamically allocate the
> audio_output array using kmalloc/kfree, significantly reducing stack
> usage.
> 
> - Allocates audio_output on the heap instead of stack
> - Adds error handling for allocation failure
> - Frees allocated memory before function return
> 
> Fixes: 9437059b4bfb ("drm/amd/display: Fix Link Override Sequencing When Switching Between DIO/HPO")
> Switching Between DIO/HPO")
> Cc: Wayne Lin <wayne.lin@amd.com>
> Cc: George Shen <george.shen@amd.com>
> Cc: Michael Strauss <michael.strauss@amd.com>
> Cc: Mike Katsnelson <mike.katsnelson@amd.com>
> Cc: Alvin Lee <Alvin.Lee2@amd.com>
> Cc: Ray Wu <ray.wu@amd.com>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/link/accessories/link_dp_cts.c   | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> index 2956c2b3ad1a..c4db61cb5079 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> @@ -75,7 +75,16 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
>   	bool is_hpo_acquired;
>   	uint8_t count;
>   	int i;
> -	struct audio_output audio_output[MAX_PIPES];
> +
> +	/* Dynamically allocate audio_output to reduce stack usage */
> +	struct audio_output *audio_output;
> +
> +	audio_output = kmalloc(sizeof(*audio_output) * MAX_PIPES, GFP_KERNEL);

This file is shared with another OS which has no kmalloc call, and 
unfortunately this change does not pass CI.


> +	if (!audio_output) {
> +		/* Allocation failed, handle error gracefully */
> +		DC_LOG_ERROR("%s: Failed to allocate audio_output", __func__);
> +		return;
> +	}
>   
>   	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
>   	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
> @@ -144,6 +153,8 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
>   			stream_update.dpms_off = &dpms_off;
>   			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, state->streams[i], &stream_update);
>   		}
> +
> +	kfree(audio_output);
>   }
>   
>   static void dp_test_send_link_training(struct dc_link *link)

