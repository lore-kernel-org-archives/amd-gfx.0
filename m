Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBB6C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 16:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D5C10E0BE;
	Tue, 21 Jan 2025 16:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1C2SL6AM";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9BC10E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 16:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APp7IpwEk5SQ7hibAad/T/IMfts9lLuVB2HQWk2VcVsRxCAwge0hJVOjeYbij+C6VWYQ64xj+GkDKnA93gBvDVkm0ttEKVapBiKgJwdY44miVxLKpRcmNqi4g4zSJaYkChPcqQXunC6BJDFiuYvB+8Y0y1A0lummB4IdBnio89Q0yXxMfA9YhI0cHJuDvEKQ76dDDW3ziQ3upoTK2l7efrAQqGDTPcmDjOJ/dn7amDubZ6Ikzou6KQSsmABPuXw0R7mdvJ8d1qLO++GT8fGQIfpjWGVKexNa9h/SxgCOrLtWgtEc8Misk+jNmEgqcE29SJelVQ8A19Cvf9SF5iokTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUywsGyXQ/dVXyx9lnDFhqSwnvDwOJVRXVBqMM8aFkc=;
 b=wSxWCltwU7ctU+Y15hUqAzmOU1ewEe7iWf+aJgYm8HBCVA6z1RQKYO6q3OykkYJ/CmrDIjzJjfhnExcTbHwE0x7DUHQd7VZTUdlrXh2BguWWcG0J+7Cd4nsXQ55PyZjQIdMpYtB2rQWRG6gZ39Y4d65ofyb9HytFH8aCD4+MYXxjfVjMtFsdUqDTMpzppgndv/zOGpsr1G6OeLR6Neom4krcWiIyqjIc/qlTIq+iw+qoiuMHfZhbwd5y1yH0x897/X31o273s88v5uGnCvntH8qgl4bEYrcEoOz2QZthaUrYTMQEmi+/UsSss111M6BZ0+z6VpEb8mFhape8gsHLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUywsGyXQ/dVXyx9lnDFhqSwnvDwOJVRXVBqMM8aFkc=;
 b=1C2SL6AMTZ/rhDXKn0bnLWUETOtyBmCbl0u3FMJ80N+H5UGPPC6I10493GmhM1sIqnjTlCF6m1reEuEwsGaSgb9FoqhUbJ0QT6g3MK/6wrl/iS6ZdZfR3ox/Y10ylRAFjCdjb77AbzTAsoZhhflXJrxWGTIfTvAzuoMN5stB7BE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 16:32:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 16:32:18 +0000
Message-ID: <3143e415-a792-43cd-a76c-328c2089044b@amd.com>
Date: Tue, 21 Jan 2025 11:32:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/display: Adjust plane init for off by one
 error
To: Mario Limonciello <superm1@kernel.org>, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Luke Jones <luke@ljones.dev>
References: <20250121135719.2883833-1-superm1@kernel.org>
 <20250121135719.2883833-2-superm1@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250121135719.2883833-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f23d7ad-c867-4528-6431-08dd3a392c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0ExT0NJa1hjblRDMHM1U0ZiUG1kQmxKRVExcTlycFJHM1BjN1BROEFkcGtX?=
 =?utf-8?B?N1paWDROZUJ2cmtDUmxnVXV2VUFLQTYwR2xYZGxSUmlIWmFMZUdEYktDL2p4?=
 =?utf-8?B?VGhOdm5JdW1SU2QxSlFRSVZWMG91b2p3S3plaFhaSGpEVzd4UGpVVEdQS0ps?=
 =?utf-8?B?MXg3ZW54QnhDTEVtVG0rWU1PNVhVSE9uT2JzNk5EZzZWaDVNMzN4dEhGelVW?=
 =?utf-8?B?VkxCeXJSSGlEREV4OHNlT2o3cThHWnJqWGdhVDBncVdORiswaUFPR2k4OFVr?=
 =?utf-8?B?Zzk0bTgrVldGTXE2czlERFZpNTlJWGxMR3NmV2JIWmFNVWhLQ1p2M1BsMWs4?=
 =?utf-8?B?dkRIUHBmV1grcGkvRmxLMHZyZDNMNUNzcE9GM25QZWVWWGd3dGtJZVd0azNp?=
 =?utf-8?B?SUhsdU5lc3FNdG5XK2xKaWRrQzIvYklnb1I2bERJZlB6VGJ6WjFaWEZrcDBw?=
 =?utf-8?B?K21VdWRFLzBxdm1aNmlKbXNWdnBJVlRjRE16Qndodjk5ZWkrTnhRMTFWMCtk?=
 =?utf-8?B?RWZZRGxxWDM4andmWHVnL0lhRVlhNHhqUS82MVdsdU0reGFaUy9aTXNleXMw?=
 =?utf-8?B?WUwySi9lbGF0N28yTytnODJkM1Y5bVhSSE5aZnJmK2g0K0lrQ3lPZTJoTC9h?=
 =?utf-8?B?dlkzWGpWRGE0NFZ2NDNPYkdtelY3S1VFYXZySDdjNG9CUmxJdnJjcnRhK2tY?=
 =?utf-8?B?QnNHMkVBbmFzQ20xZ3BObmFQa0NtRSszZUQ0K0VTTDJSN1lsaFYxT2xlZnRj?=
 =?utf-8?B?MzFOemZJL0ZqeWNaYzFQTHN3T09TQ2U3dUtUaTlocGJmZmJ4VmhMRVc4M25I?=
 =?utf-8?B?aGFsRGg5VDJWcFNoa1dwMGFHbDF2RzU1MjYwQlV1WEpIa2dWTHg5QlVLTE01?=
 =?utf-8?B?Qk54SHZMblJsSmcvS1BiNW1sVldrZnBRdUpDTVV4MXFZUlRSY21pSEwrcVFs?=
 =?utf-8?B?ZW9Xa2xEbStxczJ6VUV3enozbDQ2SkVxUUwybUZrYTRsOENGOTZ1VFEyQllh?=
 =?utf-8?B?UlljR1FsejdERkc1ZlFtaFlrTHo1QTdISWt4OUczZU1rcFE5SGlUMFhPTThN?=
 =?utf-8?B?WEQyQUtTL2ZKbjJTWkQ1cFExbXFtNmpHdHRza3J5V1pCSWM3QVQvWFRZTjRp?=
 =?utf-8?B?TWF0Qk1NdVlvZFhvOUlab2hiUEVnaTFyeVp3cFA4M0VIOVJ1S1dpMVhWTHRh?=
 =?utf-8?B?dzZsVXUxbSszSEVWdXRlc3dialV2V0Z0Mmk1S2haYm5hY3Rld0tIbkFKS0xD?=
 =?utf-8?B?K1NRN29tTFZlaEFwZVA1Y0NxQjVROTlHY1hHRlRxZkp2c0FDYmhlaVFJYzJw?=
 =?utf-8?B?NWRZZ1RVdjl5ekkwcWxEZnMvd2Z3UXRodUF3blhXWDVjQkY1TzUzcE95K2Vq?=
 =?utf-8?B?cEp0ZWRpT0xIcTdwbEoxU2padGRoNWJLQmRtRlFIem5kYWxBbDBiYllPa05F?=
 =?utf-8?B?SFNqQkZsd0M1YTRGZ0QxL1lTcjBYQSs2Nk55NnhkRXQvczhvczlNWVRLUC9a?=
 =?utf-8?B?akdqcDF0QlJOWlpsY2JEam9yTjBadzV4QkpaK0s2OHN4VEFVTzQxcVV5Snd1?=
 =?utf-8?B?WmFSbkRtSTk2c2s4N1JuOHAxMjJ0TzV0SFFSSWpaSjcrQU9ydndRdWNoTjVD?=
 =?utf-8?B?V0R6b2NZZ0VHZjFnR044QlM5MkpkQ1V4QTZvbTB5YmMxTUpZOHNDRngrdjZq?=
 =?utf-8?B?OENFTjVXQzlTNHZ0aXllYzJXOHExTGtaSSs3Nk1Oczd6VEE2M0FIZVFkb0wz?=
 =?utf-8?B?VVFmd2NiNXptWE9OelZWbHphNjJiUHc4cldjZThXWHJXZmE5emNkQ3NVL0NF?=
 =?utf-8?B?UzlkRUtZNVBQZ2I0bElnQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNLaUZwbDZGMUhkTTJpUHExNVZKNXpDTDJZZHVobHhWQ1hGanNYb3FzeWhS?=
 =?utf-8?B?TEtIOFpDYngySEsyMTBHakU5ZktvZVdSR25jTGdFUk83Q2MydlRzT0NDQWww?=
 =?utf-8?B?NXBRa0prcG13bzJUT3VWeE5Dd0FSTEhqMGVtV2ZYVjhYdDQ4Y2tzWC85QmJ6?=
 =?utf-8?B?RE9hWFpvVitpay9IMFNYN0lXbzNpYzVtdUVrS3g0YzJjeEJ3VmVwWFF2L3da?=
 =?utf-8?B?UFJCNDN3Z3BUUGp2bDNNdFd3dnBib3Z5Rk5uY2FKaDN0cElXcjdTZ1Jnc0pj?=
 =?utf-8?B?TXhyaTZCTzFKbldwOTNQZFpoQTI2czJscVkxN3lwZ0NoNWRlTmRyelZkZkk1?=
 =?utf-8?B?NEpDNURtYy9HaHVlYTRsM0hkYVpRenlkRHpJc2xnb3NEWk92Y3ZOcW9kRVpX?=
 =?utf-8?B?VUUrZFhqUWxoaVhnYnRPWnIzckVxdTFGZDk2UzBSdzl1UU0wS0h2Q2pmRzJM?=
 =?utf-8?B?dnQ0bHZWRjZueWVOMnZUczdwL3dILzJXeXdINzJYd21IU1grbXp4U0JmTEIz?=
 =?utf-8?B?R0QrdXR2YmtITG9IYXFWYjJNcEt2VU5yaXpJa29ZSEQveTAvaUlvWjNjcHNp?=
 =?utf-8?B?UGhaV0lBSUVJcUxXVjA1Rm8remJWMENiYmlTdmhsZEJ4MVIzZ01OVXBwMUtk?=
 =?utf-8?B?dUY0OFFNZ1ZRM0RoN0laRlFDUTdjLzE2OTlUYXBFM3kyVGtYOE9OZXR4OUdp?=
 =?utf-8?B?eW12ZHI4aHlpSXRrRE5OejJYZWd3aHhEOUJiV1RJbGM5V0krV1cydktHQlph?=
 =?utf-8?B?UlhuT1Vtdk9iL3ExQ1pZcXdIZVpkVjZpSVIxWjNtUmdXTlF2ZFk5aWdYMkox?=
 =?utf-8?B?ZTNBWGdBdGRzYy9JRHR4c3RJZDFyQTI0L2x3Ky8yRWlORlBYUUhQL256aHJl?=
 =?utf-8?B?NTlOVHRTRkVVWU5mMjRZbmRqZWJ2TEJUbndScGxYeTNXWjRCQTZWclcyS2ph?=
 =?utf-8?B?Q1p2V1FKQ1U1aVdGcHRDRFhJakF6Q0R4TDVPYTl3UU5XdHV2ZDM0QlE0YlV2?=
 =?utf-8?B?ZnhRbXdlbHVZSUVJWmR4cjNEVFBmY1kyaXcrMWxYRm1IbTgxVnBMVDI3c2RE?=
 =?utf-8?B?UG96SnlQdXR4YTRJdDF3cEZpbWJ5akRZL1o4dC9IQ1J1aDkya25lZ054TjNv?=
 =?utf-8?B?ZGVNMk5FUS82Y3kySjlzTGVpR0ZCV3g2dzVYZzZLVTdLV2kzTlp1ekJCN2l3?=
 =?utf-8?B?TENjOGx4TVl2RDduM1NFNmJsYjdFZVhiZWJaVW1NbENmRTd2MW5yd1BFNDdm?=
 =?utf-8?B?c3lIMmpIcTNJaXhSZ0xPeEIwenQxQWlPelhXeTY0eE0vOVh4NGlVUlQ5eTJx?=
 =?utf-8?B?amVtSlpzTmdVRFJFYVljMlJOcGdzQURIMjdyak9wWWhpOWhNQUFCcEpHejlZ?=
 =?utf-8?B?M1NHZ2FUdTVENEpXS1RDT1BTcVFQWklWWVROOFdpdk53UTdRY09nS0tlRWVF?=
 =?utf-8?B?SEJFZjNVUEVvSWgwOWJFcWtKQkczaElGREp1c0N0SW1tamtJT1BVK0Vzdmtz?=
 =?utf-8?B?K1VEMTBUUERoRHBLSzYzcko2cHV3N29vVzQ3TnA4cTV1NW5oRU54Slp0anU2?=
 =?utf-8?B?emtnQk9DTlVpZnJ2YVlqaDJvUFlyaWtMREVoamhuYXRLYnYxcnlLQWxLVDZQ?=
 =?utf-8?B?ZnR1TUNNZyt5NjVWUjg2cjlYRXppSDRHRXQ0Unl1dkdwRHM3V3ZuZnNCMEFj?=
 =?utf-8?B?YjRpeDdUUXFUQzVUZTF5TnhPenNEY0NvSXFwNE5mRm9UQXBBcHcrUG9RYUNr?=
 =?utf-8?B?UHZBVzh5N2VaWW5rcUIyV3hOV0RzVjBRcE4wbUlMVGw4akZBUmd6bisrWnJ2?=
 =?utf-8?B?Q3ZEUncyWEJnWjBkUE5tSUM5M1RadHBsdk81RGJjUTJ5MWZrc1I4eDdkQjJt?=
 =?utf-8?B?eGFIWVVPZWxpQVc3ZmY1N3dhUmp0UW85YzVzVjZlYTRkOVdhUEVJMVNpbEFs?=
 =?utf-8?B?bDBPNHVGTTFiVmJxU3pDRFdndEdaM3QzZmg0OVNuRnhSSDVKOHEybW9KVGVi?=
 =?utf-8?B?REVSTThMR2FkbFZwWEZ3RWlMUU5reWI4Z1pLRTBvdEtUejRFZnVlQ01hOTNs?=
 =?utf-8?B?NlYvcGRrVmYvbkRiRTIxaklXQzZ5bmUzNnpiOE1FZUVFUm1TZlp5WTdsMkVm?=
 =?utf-8?Q?M3A0V7anB9vt2HDTf/1pG1BKs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f23d7ad-c867-4528-6431-08dd3a392c41
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 16:32:18.8383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aEJ+ZFehzweZWlyeXasENB5DLJ9Awoi6lLeq8C4bCf7jmHc9ORo5tIN4Y0NLlKwOLYTgB4vZdjp4vBDkXUj9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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



On 2025-01-21 08:57, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The number of active surfaces is initialized to the number
> of active planes.  If the number of planes aren't initialized
> properly then the last plane can end up not getting initialized
> which can be a divide by zero error.
> 
> Reported-and-tested-by: Luke Jones <luke@ljones.dev>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3794
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3533
> Fixes: 7966f319c66d9 ("drm/amd/display: Introduce DML2")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> index 8dabb1ac0b684..45147b812d7d9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> @@ -6787,7 +6787,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
>  		}
>  	}
>  
> -	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
> +	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {

Shouldn't this be either
	k <= num_active_planes -1
or
	k < num_active_planes
?

Is num_active_planes wrong somehow?

Harry

>  		CalculateBytePerPixelAndBlockSizes(
>  								mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k],
>  								mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k],

