Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CE2CCD19A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 08:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D68510E433;
	Tue, 18 Nov 2025 08:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gR8HAnIT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CE110E433
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 08:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKYQTYD/OGHKc9OK6vVLyrp9TnmZQ4zJA5Mf3UaBI+J05n4v3O1KPvoVGFV/bop+ApXcDaHvfSzaCWGtkl1xH+/Z42McNfLT35n+lMPzCMrQYaLNm8vuneHGXTRff0zmNoI1VzzYVD52fBiCb8I0b4joMmNtAXG59p7m3+TNSqFitvq2mqhHDIZBUfYrvqPTf48bIeBCJgawaGY9ri7flyEaDigXe5t8YpEBBhBi7BQqW3wTCXTNIH6yR0xgHm4UXB+YIGdhsaJ9efViiIGrPNjdWaDoEvJeMLHxncekNfaupfza3HOaSXAhqjmcs5ut5p74EDhc5NSQRHi85vWDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ9L9W6w83xlX3kFFMWW49oMGf+pYD31rKRQ8rU6qOo=;
 b=sOUWdegZaE0dhcqpupmy0Urmg2Cf095FlZRVoPpSx8bnG+hGVnaM5hVIbO/S1bvqB0ZfYjX2whlnXL/tQ0OJJo13UNIlP6NESodut8o5XKEyodMOr7C3lTneLkLxJxrRmS9fj+MTMUUT0pHtEvuLr863ZO1jx3uykToV3LWTnwWGErryL+Y64MCvb9ZMrGhB7qARn8PzWPmcw4kvkzbs9qV1N2x8oNhXv32OYC/gncTt4A8p1GcgTzJtg9Laeke0Hz0ieFDJ+qeUAfzZwSGZ7siadaTyzI2Wapa5jNQZOf0Z/xaoixbQnZYVyWeNq1wwyq2WGEQ1Xo5d6UK7AXXluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ9L9W6w83xlX3kFFMWW49oMGf+pYD31rKRQ8rU6qOo=;
 b=gR8HAnITxPkKMKbiZxZm82WzyTwJrHxY/Ptkl2KMhtuhwYR61MuRJ7EhaAkrSVdb4MIOWBt294S4teqCDQFFNkE3iYicSo1E/cj03VdjUM9XPy61qd1kYw2MRuAy7fFXaHxLmnrdxt17FqkHu7NWIWbyxrrU9El2PdVOBSWDQyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 08:31:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:31:44 +0000
Message-ID: <5c462392-490b-452e-bf47-1e317a391a11@amd.com>
Date: Tue, 18 Nov 2025 09:31:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in PDE
 flags
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
 <DM4PR12MB51527574A2766466AF6706DDE3D6A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51527574A2766466AF6706DDE3D6A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 554360c7-06bb-4a55-bcc1-08de267ce7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blhuNEZsQmVSVW96ZmFlU2JLejZLODZWRGZQRzJaYVdrWUJYYnZ5U2ZaYkwv?=
 =?utf-8?B?cytMdjZTSHBIeG8zdzAzd2p5bU9iNkdJZnV2M3I5ME9tMWE0UmdjQzNFNFFI?=
 =?utf-8?B?LzFPN3NoQldsblVQa0grSDg2NlcyU05YVTZ0TlQ3T2RqVEVkZGVYMHkzYVVt?=
 =?utf-8?B?dTAwbkxmRGM1V09xc0dkTlF3S2VvUFhobHEvUGFKU1JOQnBuOXVJS2dPNVQx?=
 =?utf-8?B?UUs3U3lpaVVZV0Q3TDdFWGRJWUxwRzFQdkhxZGN5OTJYdmJMVTg1Si91NHVK?=
 =?utf-8?B?Y0NoQnBra0daYy8rUXNIUFhKMUZ0ZzFSR1NRQkRxcTdHUlNiTFErNDBUYlZl?=
 =?utf-8?B?dDJOSyswNmMyZW9XbVR3WkpLRDVUdjczZGViV1h3elZSMHRiQmp5a2tzcGZa?=
 =?utf-8?B?Rnc4cDJuaVQzcVhGZ0FiQTF2T2c0Zzc0R2V1TlBjcWF1VlpRZjRFZXd3TGZu?=
 =?utf-8?B?WUE2K2ZXbXJ1QVBkUGhlSXZPNWpFMkpnRFVxMnRWOFNTNGlLNExVWHNKTkgr?=
 =?utf-8?B?eFZQM3VVdU15TDdPa21FeVMvaG04TVVWZkxsV2tMRXFham44V0NLR2Z0L2pR?=
 =?utf-8?B?VWJVbElNdkQzOU1CYzJUTlRYemd6YnE3a2gvNkRaOTZrM2JBaXoxbktoMmRu?=
 =?utf-8?B?eEM0TjJJNVkyZjV6R01iQnVOaXFDVXV4T2ZQOVN0MTRxcUhiSC8ydFFBb1dW?=
 =?utf-8?B?MFZCUnNkYXI3K0JBU04zYnhpd2VaaDBnNng0NlhwWGE1Q01mcE50UjZ0WUJ6?=
 =?utf-8?B?V3NSNGo4dVMvNjJ0Q3ZBS2duRkxNRm9IU3BBeFRkYzF1S3RydFdwcjc4ZnFT?=
 =?utf-8?B?NkEydVdjZ1ZUR2FBeXNnaUp3alFkMVorZDVpamxjaFdmTXE5RW5abU9kMnIw?=
 =?utf-8?B?ZEJBTWQwWUtJT0hwRC9IK2JYaDg1eExFUE9iNWNiQU1EeVFib2tNU3hpcThF?=
 =?utf-8?B?Mk04R0s0b3VxZThSZURqUTgvVktNNGFpNEZQN0dBOHY2R1dUUTN1bU1VL0Vr?=
 =?utf-8?B?NXRMYW5tVDI1VnZ4SDI0S0VXcGxGcnV2SElaaU02Qkl6Ym1yOGZyOWEwb0pF?=
 =?utf-8?B?N2lHVHJBajJGcmMrZTZKYjFyU2FzWkdISHhZNkpLZ2d0ZE5yWHpYai9mV010?=
 =?utf-8?B?QkFnN3NHVG1oM24zcjFhMHNNejV2ZjQ2UUw5bTdKS1Vtei9LNVhIWmJGQUQx?=
 =?utf-8?B?SHd4S1gvN1o4L24rZUs5S09MeHBWZkVveGpjbElCSlBCL2dwdEdlUTBFN2Y2?=
 =?utf-8?B?V1ZRZ3NtQ09Bbk02UkEyRUxrY2xIdFFXNzlMcUZFOTZ0V2dIeVl4TStSdVFL?=
 =?utf-8?B?aEt6V1pQaURBV3dyaXdiRi9hWmxEMUoxRmRwa3NmU2hMRERtWm1vMUxKU28x?=
 =?utf-8?B?ekIyT3RuNjBXdERlMEdJWWplZ3IwQ0ZwZVV6ZDFudGhIYWNET2oxMzA4bVBj?=
 =?utf-8?B?VG5ueU9mZnJXN3AwZW14aFFSUGEycDI4VXJHYVRzL3VJMVplVFMvQU00N2Z4?=
 =?utf-8?B?WU9oWlIyZ25aY3g1NlRtdy96b2FPWWlNelpBRDFMellHeklORUdCeldyQkhL?=
 =?utf-8?B?ekExSjAxNmthR0JFa004MDdOdFV1c0xHeFcvUGtVbTdkbk9say93TEZQWTRH?=
 =?utf-8?B?NTZrU081Q0taWDJiZytrd1ExM0pnUWNOOUlwZ3VVRVZpWVRkM1JsMTI0WXJk?=
 =?utf-8?B?ZTI4RHErVlBTTFhpaFFvZVJoQm9KbXNzTTZDREFGKzA5NVNzMWI2a2ZTanY4?=
 =?utf-8?B?Q0lYOHoxT2IwK0VIT0NmZ2g1SUpKeUgvVmh5WVorR3Z2dVpFRzRPTTR4ektG?=
 =?utf-8?B?OHhGUzBxdzNqV3BybmFKcmlmbEU3dnUvT0R6MUZ1VTM4UXJsRG9rS3VvMnBw?=
 =?utf-8?B?dmI4Y1UvOXp4Y2FsclRPR1FQWnJ3NDdUdTFDNXhMRTNVMVdyL1NPMndNbGlL?=
 =?utf-8?Q?JuUXP4Ein0RqPWBYvKcm/+wbjavjWTgY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1dKMHB3ZE16T0FqR1FBSDlENGZHc1FvczFGVDFBRlZMdHEzMFBoZjdIMzY0?=
 =?utf-8?B?dnF3SmhIajRNRCt6SFF4d0k5WTdISmExRnNSZEdsWTAvM1VOMG84THZObVFr?=
 =?utf-8?B?OTl6RWtzUEZRU21hL1kxY0M3MTN6Sjc3YkNPd0swcVVZS29WQWRVT1lweEth?=
 =?utf-8?B?MUd6dUlvYlYyUkFkeE0vTnhLdGNXNXV2bEc3VmI0TlR4MTE2em14Vk4vdjZx?=
 =?utf-8?B?Y2RhSnJLalhudWY2Zkoxa3JBdXV2OWpxenpoaTh5UUQvM2NaK0RFeVk1bnJl?=
 =?utf-8?B?VStTYWNRMzA5MDFNbW5rRmJlbUd3MXJGMXc4c3h1ZFUxaDRNNzNzZTNqYWE0?=
 =?utf-8?B?NTFSdEw3Sm55NjZsWkJVZVVsQ0RmSEhvbnR4Qm5PL2dqYndJOVlET05QMXlp?=
 =?utf-8?B?MWptNGJTMytJL3RzaEMxWFpTMWp6b2JWbEhqa1FIYnMzaEoxdE1ud3NLcWtP?=
 =?utf-8?B?SFk2a0RpeXBCSzhscEdtU3lRdFdEK2phVjZ1bDRuU2RiaEpjQVhOcXAzbWN5?=
 =?utf-8?B?Tm1rKy9PeFJRSFBrZGxQUFVZWm4zNjh2VmFiVGVXdXJpdGoxQUJuZnFRVWQw?=
 =?utf-8?B?OVhOM05jOVFjcE9ZOU4xc0VyclZJcm1PUE4vK2gzRHl4cEM5L3h5RU9aT1lZ?=
 =?utf-8?B?L09vZy9GVTJ6RGRIYUVFY1poN09rdU5xcG13cHFKSnlmRHRoeWhrMmp5REpm?=
 =?utf-8?B?VWVTaStDSkYxcjJMVzVrL2VFZExwMHdrWVhYNjR5MkFmeHNKOFpCd2Q4VmFn?=
 =?utf-8?B?Z3M2TnFFeFlKM3hSVFEyb2cyR29Zcks0dGdUaGxaMnBYbkEyRFpYWEtyUW02?=
 =?utf-8?B?V3RSRXN5TkdmSnlMS1NxNytUQms1bHdHVWZ5dGhIcGFlV0x3b0pPS0o0bGd3?=
 =?utf-8?B?dUh3U0NDbkIvcWVZTE1odGNPU25HZEVVc2hzbjF5TFlCYmZlS05LMmNpN3RJ?=
 =?utf-8?B?Ujh4T2l0d1E4bk9nVDlGOU9XbmliZW5ZWmVTVkJ4NnZxWkVqZTZnOUxURWR2?=
 =?utf-8?B?Q3NYVWliS1lTVFlCT1NHVnJqbnJTbEJHRzVPaE5mUkFvaGs5by9GWEFBL21q?=
 =?utf-8?B?Yzluc1RpclBySytha3ZObDlKcUxtUVd0WTh6SENOYXFxNDdJNGNNZU85aHlC?=
 =?utf-8?B?Ym53TUFQU09LMnUvRVV2OUlsbFUyb0J6QTZzQ29PdFlIckY1WE5uREJoU05F?=
 =?utf-8?B?UmN4Q0RDczhSOHd6aU5xNU9CSUNTOHF6Y1pNSlJ0bHQ5SVpQUXRZK2JWYjZP?=
 =?utf-8?B?Sjc3eVEydXlRaStpRW1wZ2d2R2hZVnc4d1dLdDMwLzFKdk1ZTm1OTVNIbjh5?=
 =?utf-8?B?L0wxTGJ4dGk0NkRyU29KemlyYXJKb3ozWlF6ZlFRdUIxL3d6c0ppY3plYU0z?=
 =?utf-8?B?citzQUNEK3lmcjdoelhjSktaOE5iV210VEloMlpQQ3F4d0EvSGUycXc0S2tZ?=
 =?utf-8?B?VTZFZGhrWEdldytaSzcxdnhvQlpJbkxxcEp4MmswcFFYRlhyYnVaTXdwelhm?=
 =?utf-8?B?NDB5dGZ0ZUxSc1hDQVdzYk00dS9hd0FIOUhlS1JOK3pNMTl2aU51UmtHQ3VX?=
 =?utf-8?B?VzlJQko5QVVjUzJCM2pRNlRzWVEvVlhZNFFuVmtKUVgxL2RKVjB5Z1VqK1Y5?=
 =?utf-8?B?SlorUW5aOUdwY3U5eVBTL2JGcE5rV2k1OXZZVlp4Vkl0S3A3c3ZyNU82Ti84?=
 =?utf-8?B?WUtLWnc3RUZsa0RBQkQvaE5Cc0JjNlh6aEhTRU9IcDEyRDB3NVViRGJlb2pT?=
 =?utf-8?B?U2FGWGlVd1VrcSswSzFQL3VsY2FiOFQrU2o1dk14SFlFK3lKekxYekNVUkp6?=
 =?utf-8?B?NlhoNjJOQU8wNTZLL05hU1hodGd2cXp6b2VlSFErRkNmN2dQdVh5YTc4dUs1?=
 =?utf-8?B?WEJlSzkxUlVhekZZLzJSM292ODI1WU1SRURLQksvZkZFU2hESnAybmlSWmxK?=
 =?utf-8?B?V3ZyZWNBcUpwaWttRjhZZFNpVmRPUUVNc3phN1dseDRMT1p1SmhkSEdUL01I?=
 =?utf-8?B?QjhtMm5UZVpjd3ZhVEFjQ0U3UGtRNHJ4ZGp0aSs0YnY0aThvUEZXcHFRVDRX?=
 =?utf-8?B?WGllbnlDb1pDekRmSXMrd2hhMWxJdG1yUllTUWpmeGV5MHk1WUN3VC9OWThV?=
 =?utf-8?Q?ZJJ/zDugkugdY3iA64NfonaYo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554360c7-06bb-4a55-bcc1-08de267ce7c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:31:44.1082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWhUtoQb4qofgByW6Eodehur03klbgbG+eN1WUwDdECHK4wa3j+yrDQRfszZKUsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

I think checking if the ttm object is allocated like Jesse suggested is a bit more defensive

Regards,
Christian.

On 11/18/25 03:53, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Thanks Srini, With this patch, it can fix the rash.  Alternatively, we can simplify this patch like this:
> 
> Please feel free to add test-by: "Jesse.zhang@amd.com"  and Reviewed-by "Jesse.zhang@amd.com"
> 
> -- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1336,7 +1336,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>                     mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
>                 flags |= AMDGPU_PTE_SYSTEM;
> 
> -               if (ttm->caching == ttm_cached)
> +               if (ttm && ttm->caching == ttm_cached)
>                         flags |= AMDGPU_PTE_SNOOPED;
>         }
> 
>> -----Original Message-----
>> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>> Sent: Monday, November 17, 2025 9:31 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
>> <SRINIVASAN.SHANMUGAM@amd.com>; Zhang, Jesse(Jie)
>> <Jesse.Zhang@amd.com>
>> Subject: [PATCH] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in
>> PDE flags
>>
>> MMIO_REMAP is a special IO page backed by the device's remap BAR
>> (adev->rmmio_remap.bus_addr) rather than regular TT-backed system memory.
>> There is no meaningful ttm_tt/sg behind the MMIO_REMAP singleton BO.
>>
>> amdgpu_ttm_tt_pde_flags() was treating AMDGPU_PL_MMIO_REMAP like
>> TT/doorbell/ preempt memory and would eventually rely on ttm/ttm->sg being valid.
>> For the MMIO_REMAP BO this assumption does not hold and can lead to a NULL
>> pointer dereference when computing PDE flags for that placement.
>>
>> For AMDGPU_PL_MMIO_REMAP we now set both AMDGPU_PTE_VALID and
>> AMDGPU_PTE_SYSTEM and return early. PTE_VALID is needed so the GPU
>> treats the remap page as a real, usable mapping, and PTE_SYSTEM marks it as
>> system/IO memory instead of VRAM. Returning early makes sure we do not touch
>> ttm or ttm->sg, which are not valid for this special BO and previously caused a
>> NULL pointer crash.
>>
>> Fixes: d716b3a2df1b ("drm/amdgpu: Implement TTM handling for MMIO_REMAP
>> placement")
>> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 84f9d5a57d03..0e7a631a9081 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1319,13 +1319,23 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm,
>> struct ttm_resource *mem)  {
>>       uint64_t flags = 0;
>>
>> +     /*
>> +      * MMIO_REMAP is a special IO page backed by the device's remap BAR
>> +      * (adev->rmmio_remap.bus_addr). There is no meaningful ttm_tt/sg
>> +      * behind it, so do NOT touch ttm->sg here. Just treat it as
>> +      * SYSTEM / IO memory and bail out.
>> +      */
>> +     if (mem && mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
>> +             flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM;
>> +             return flags;
>> +     }
>> +
>>       if (mem && mem->mem_type != TTM_PL_SYSTEM)
>>               flags |= AMDGPU_PTE_VALID;
>>
>>       if (mem && (mem->mem_type == TTM_PL_TT ||
>>                   mem->mem_type == AMDGPU_PL_DOORBELL ||
>> -                 mem->mem_type == AMDGPU_PL_PREEMPT ||
>> -                 mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
>> +                 mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>               flags |= AMDGPU_PTE_SYSTEM;
>>
>>               if (ttm->caching == ttm_cached)
>> --
>> 2.34.1
> 

