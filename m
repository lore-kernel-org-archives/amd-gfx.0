Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6560EFB7EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 04:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5053010E49F;
	Tue, 24 Feb 2026 04:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAiI0jMV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B3810E49F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 04:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJMcz0Ln8QdJiGmdRRNqeX8CVTV7uJVk8KzLIOLNrnz1swf+LolAVRvsrqhy+gkYAuvPJN73FQOglkkw2OmRKCoQ/vWSzGKRsujCtA8Y1rdFfwYexY+k+2yIKkDk0gVA7aZdchIkVWdQ2RCfH5W13sTDnpyNZPzYoJaYF4sVJMf8MNY68oAag0n+hZ6IKQ3cH07WE0NcRBVSR5ws6Ufgv+LkJybvBLb+TwkshBVikPUgEV85PV6xhlGZfXeDyZk5NZfOihnNLETkAlegaqrzIyUK8keNy1r6BTmnQnCiRjg/ov9yp81nVu9Syg+4xnPg+Gcl9wIbugLWlVSKjtVd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta5MQf70Qq44uDrgJlZA0wiqyaDr9Cl0pPd0VSHnVoE=;
 b=phbh0jijPOBk+FqbHXgxkTm4/UlIsZpLXKjmr7IA9pOa6slWOmHSqO4DNM7NbIPjxuLKgoqgHYl69rygO0cmTWGh30KJsPGILDNw/k3hs+1CIVbHEFC3JzbZWOMpy3NcdBXqt9gYECzqNvrXvDaqerBKNKpnyg3VFbVhEZ/sznnX2kcFyzDraNLUQRMdW74g7xBhBJ7G4SgsZpyb/4VUCk9COBPJcuu+Z4v8pBE6xI7bOIJq08hYsv9KJeDG7FvdFVJErmi+NumrsEnyFd5EfHY2dVMRny5mgdg6gpMHgHYyYykk0RWJ0dn8zwogZ9nk7v1p/cGDIm64Q8a75TzmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta5MQf70Qq44uDrgJlZA0wiqyaDr9Cl0pPd0VSHnVoE=;
 b=PAiI0jMV0bPbcVNfa/rJK+u191+25+tDfrJmE6jK0HmngoRF/huTDEF4skGZ8wb8klFmnqfnpcUkf0MfFmuE5ZYRCEXDUH3J4dG2BErPPakKZ4QOzboB2dHyYQIVQe5zC8w5ftNBALSAXxAdjLekfPq7TJfiLoKNVxHnPNGVHVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 04:15:49 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 04:15:48 +0000
Message-ID: <278f998d-7f8f-4442-93d8-2e24c435e07a@amd.com>
Date: Tue, 24 Feb 2026 09:45:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_signal_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
 <20260223124141.10641-5-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260223124141.10641-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bed916-ea76-4de1-2732-08de735b6398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmtXSW93ZnBwSmxQbWJWN2dXeHhGaWVnZFJ6SXJ0MXlHSDJmd1Bka0Q5QWhE?=
 =?utf-8?B?bitXdEsrOUVSQnBTWThFMC91S0M2R3VoazVXWkJxdTAwbWsyMWFrRm5XVlY1?=
 =?utf-8?B?VXVtTDV4Qm9NUzhpVFVOclVYMVhlZ3hTK09oaGtyaEVGakpBS2JZWUFaK3pl?=
 =?utf-8?B?dlZIZlNUalFUK0h6b2xDeFExdWZzRC9JbWpVSnk1TXoxQWtTWXpDejNLYmF3?=
 =?utf-8?B?Tk1wdTduYWdlMnBPVEJhOUtnaXdqa1UzT2NCQ2pYTmFrVFVVSFU0bzB2WjZs?=
 =?utf-8?B?Y29GZmR0MUtQem5YdE9abHRVdVk3b2phMWNWWm1WOG9IeWVLendaTDVrSllN?=
 =?utf-8?B?QzhmY05hSUYwdURVYjh2RC9MeUFTc2JIOHB0SUVTRVBMVXZnRWYrbUNHVE5t?=
 =?utf-8?B?eFNXQzBjZ2tXU1QySmxMNmJqbVpYSnorUnZZVXJMK2dBeTVMMWM0cHFXa21u?=
 =?utf-8?B?bllwZlI3MGNJSllpSWhFRzVBN1dwcHB3UVZ4ZWMxUnVlODcycTFETWIxSUpF?=
 =?utf-8?B?ZVg5RHAraHd0aE0rOWczVkVnczFhcytCcC9rWDdXV0FMbTJZSmhPY2ZrQlQr?=
 =?utf-8?B?TlFMZkpqMXM2MFBzZDM5TFRXL1ZNRmJ1ZlZ4di9aaUIzK3A3RHkvYVNPZFlI?=
 =?utf-8?B?dVkyQlI3ZFJheGM2V1dUYlQ5ZG9KVUFySG0rRTZ3V2s0VEtFMjVmTHpSYzZP?=
 =?utf-8?B?QU84SHdzNUI1cUl2QVJ6TTIzVnIrMG9OSUVFbDIwdDdMVG1jVi81V0plK1p4?=
 =?utf-8?B?d25wZmY4dnV0cjhPQWtqWWFheWJjWmRkbWNrWGRhOStOQnRVS3VRVkNQM2Nt?=
 =?utf-8?B?c0ZjOVlFWWdDZWswQjBPRXUzaEdFbUd3L3ZRMHM3RVdUbm80dExwTHhPaDdN?=
 =?utf-8?B?M0gzeFdES2p1ZWp4V1dTYjYxMEFjc3ZLanQ4bmJQS05oMWNVQXdIY0d5b2x5?=
 =?utf-8?B?aFhjcnB1K1BTR28xZm9DbTcwTTAvaXhzRHNlUG1rZWdYQjlGR0JNT0FNek1S?=
 =?utf-8?B?N3pkR25ZSHd5TVFzanhscVpUeG96ZS82UHU3dDIzYmxMTlVGYnNpR1ZFeXVM?=
 =?utf-8?B?bS9VSVdtNUNZSWN1UTV1T0dRblpNRHh2SWRFOCt4K3ozaHo1d0JSam9Pbm5R?=
 =?utf-8?B?V2dmY3lrajZad2R4cmNRWkJhS0NZcmF1TkozaVdVZlNpZ2xFb3U2cWQxbmdW?=
 =?utf-8?B?YUhLUVJDd2EwbmQ2WW5laVJsblYxMkFXWkMvY3ZBbzYrQUFxRTNDeEZJNHl6?=
 =?utf-8?B?T1JGV3d2MHJsbG9pVWxwUC9scTY1emI3Y040STBkZkQyaDhJNzZTOWllSDVh?=
 =?utf-8?B?NUVlT28xandIRUs0OERmc1M5SnVmcTJ2WkpDTlZTL0tvUGJDNXk2Ny9GcFhk?=
 =?utf-8?B?KzE0QnZGSktsYWdDZFREVlB3b1Y5TEJINnNEQmhrdFlPSzlZTXVNZ2JvNVZ1?=
 =?utf-8?B?ZUtLdWlOdnM5eEFvN2xEbGlIYWxwM2UyTHJGQVM3VU8vbzV4enRqNGVlbVFP?=
 =?utf-8?B?aTNzQXU0Ty9RWHlIRnR2ZEJCV2JUTFh1d1J2cW9GSjRwWHpIcEtjaWUzb2xX?=
 =?utf-8?B?VlRST2EyV0hEY1dvUXFMTS9qUHpZNFNGMHkwOUpnUTJETU1VUlhtTi9sQ2cv?=
 =?utf-8?B?NTFGWWRxcGRBeDYySDZkeEIzOFVSQnhmb2VuOEVkOFJNRmlEaFJQTjBhcXVq?=
 =?utf-8?B?K0RpWjRtYytSdjNRdlhGOGJ5ckZ4T0dZd3gzS2RZdEJweWptVDQ3YzRWS0hP?=
 =?utf-8?B?c3ZwdDJOdFkxT2FLcWRYZmdNQnZCZFJTbktSVnNPU3ZWQSt0eHR0SUlSRFRW?=
 =?utf-8?B?TTBhQlA2RkJKMlJ2NkY0NHdyRExJanlqNXBwcW1mVlVyR3VKZ0x0NE9YYTBI?=
 =?utf-8?B?K0tua1Q5QTIvNHo4TGdHYjdacW5jNDQ2NTNLYlE3Ry9zNjVHQWJ4TnVRTnBN?=
 =?utf-8?B?Y08vQy8rNmJIdzg4aVV6ZDBpWEtnNHpyczUraGN1RHQ5KzZCa1FoS3lWRk5v?=
 =?utf-8?B?dXYzenQvbHRZRkorWWdjc20veExqRlFFdExIVFc4ZDFJRVdWVGd6eGhPUTVD?=
 =?utf-8?B?Y3F6VHF5bk92bXdHL2E1YVZNYnd6RmVhekdiQTJ4Z1Ewa3BuWkI0ZmhJcDRT?=
 =?utf-8?Q?QKU8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFiUXlRNUpEZkVwbytqZHpENTFzbXV2ZEVmcWUxeENDY2JGcjF0R0pYSVE3?=
 =?utf-8?B?ZWNtcEJXOUVRMWFSYjlnSlY1WXJjUDIvT2VRQjNpQ1N3YWcvc3g1NmtpMHdy?=
 =?utf-8?B?N1BoblJJNCtFSTBraGhHM1NPS3Y5OWlVVWdxbmk0UU1mejZmZ0p6cmdpRnF4?=
 =?utf-8?B?cEVDTzdnTWwxM1ZBbTFodWFhK1BxWmZZNW8xUEl4UkpkdDBFbEJ6QjBxZXBP?=
 =?utf-8?B?L0gva1JHMFBLSnRDRFJLTUtJRUhaQ0pidTBxa1BIanhORlJOdnZWNWNEdFpR?=
 =?utf-8?B?M2hlWDF0TEZsdkNaN2xNY3h6Tm1wb3hWdS9DdFg5dW9DMTJjVlN5NnR0VnM4?=
 =?utf-8?B?NzhPb0ZZQUVmVFdmS2RTUzhpckVxWTJ5a3QwUW41ODZHZ1QrdytDSFZCRzQw?=
 =?utf-8?B?anYxOG14TkRvVWFGY0lINEFPc1U4ay9ndEtVcWJwZG9kRkU0dHU4aHJNZ3d1?=
 =?utf-8?B?TEx0Q3ZXTUFxR2dhMjhnc3dRUTBhbGZUZEhDUHl5OXRCMlpMcXROeDg0Z2dD?=
 =?utf-8?B?SlZkT3JpcXR5QzByclpTMjVYUFpIeDllbUh6OC9pSkI5cXJwbWVza3R0RWNE?=
 =?utf-8?B?Ri8wQUdxMWx6SmZtak0rVFgvVmR3VXVCcGhEME1JQ2FGVHZ6amNjVVhrd2JU?=
 =?utf-8?B?SzZQb05vOHdFVEtBa2hFNGVKQmVuenBGS1ZneXlwdGVvR2VnMzkxcjBzVTZE?=
 =?utf-8?B?elRtUE8zRmN6VVdtT3dVZlQvTm9wWWE0YlEvWU9ZMnpMbHU5ZDJ4QzFNYTlM?=
 =?utf-8?B?MytORmhyeHZFT2hVT2dlb1NXZEVEVTN5OG1VL0RLbzFMSVEzMHJjR01YMll0?=
 =?utf-8?B?RU8vZ243MFkrcVVLU0ttYWVzcWR6VjRJN1lpc0E2RW00elAxL2RQRlErTHBC?=
 =?utf-8?B?bW9zZ2JUd0Yzc055YXlwNnFadzJWQ0d6d1JZQ1h1bWk5ejdmRzRUZjdzZWdJ?=
 =?utf-8?B?RTVGUlpPVkdDVnFqemVReENvOGNTMVZuYWd3UEQyZWRQTzVBM2YvdHFadFhO?=
 =?utf-8?B?bkNZRXZKVGZKcUUyZy9TU1djSXRaSStFN0RSV0tYR1JOTWk4T0Q4c0ZpUnB5?=
 =?utf-8?B?VzBLcHRyc1Q1TkJ4WU5MSkQ3ZXpLK2tiUGhxK3pucUZlNjBxOWdhOG1lRVRD?=
 =?utf-8?B?Z00wNGdZWW5NSm9MRGtDMzZsNWIzcS9VRUQ0MUtRY2ZjVzBwVlNOMDRPdkVT?=
 =?utf-8?B?VGVoZnFmd3VIWXpUWmZnQVZXdFhGaGFtUWtUM2pWdEJLcWxUVjN6K0oxOUly?=
 =?utf-8?B?a2pLT21renVLckZ2ZGRIU0FDTUpYTk5yQWF0dy83ZExwditHZWhjU0VGdmxU?=
 =?utf-8?B?U2VadjROY2t2MVZvMzlmUS9QNFhVRG41WUcyMXZRRS9tL2tkSWFNU0V0WmN6?=
 =?utf-8?B?RTZ1T3RLYWN2dXh1VGduU3lnMjRoVUo1YnljZU93YUR2TGc1MkFBYVF5dDg3?=
 =?utf-8?B?OEJjbmVYck5tL2hsaGpuT2F4N1psZHFUWEFnNjJqMXhNQWFDaVl0cGZDV2Ux?=
 =?utf-8?B?czdjYnExaUxJcXRpTklIeUY0dUNvNUlPUndBSURwdnMzTEhHT2FlZkF5bldY?=
 =?utf-8?B?VThSRm9JVGl2c1NhbTlDU202UFJ0Z3NOL2Y4aUlGMXk1eFd4N2hWU2pMVlZM?=
 =?utf-8?B?TDQ5ZUhhU2pSZ0JsV0U3R015Q1VqWVpWb2tLTlFUeEN2ZjZMbEdhMG5manI4?=
 =?utf-8?B?eWtwc0hxUHEyeWxJR1ppZWNFbDlMbmUyQ1hrZ2daYXFLNXZ6M0VicCtBR1hN?=
 =?utf-8?B?NCt1MkVPZTJ1bHpvRmRuNldhaEExUnRPL2xLMCtMYVN0RTZxZnlNRjMxSzVt?=
 =?utf-8?B?VG5aWFlucE9iaFdEZVB4Z01nV0xEUlh1M2RSR1cvR2IwdVBzY1pYcEJDSHBN?=
 =?utf-8?B?S3pNZEw5OVp2VDZOT3I3VnJqRnNmMFY1L1hSQVk2MHRyakZERTlHcnYzVXhk?=
 =?utf-8?B?V1p2TFcxdDZWVGI0SVFBc3llU1NqQy9vcXJrTTN1UGFHU1lmQTdMSzkvNUZ2?=
 =?utf-8?B?L2QwTXU5djBnZEhveE1vek80WFo2NlFteE13QVJQbnNEeFhWQ3FQV294WDR4?=
 =?utf-8?B?d0VKM0VVY21tbWVmcGhwMDQxNWhXTFh2WkhUeXlqNkpuekl4d0NiYmNDaUw5?=
 =?utf-8?B?MlhuWWFJTXMyNitqWWtlQk1WN2tReEJzNkRYZ2Q0bHhianYydWNJeWl2MUxz?=
 =?utf-8?B?Z09WemRHeXVJOE5LdDhLa0RNWmJSK1E5aTlwVWs5VU5Xb3N3WHJON0YrRWZM?=
 =?utf-8?B?RHJxOTBhSFlCZkx1MjZHWFY0eDU2YS9uVHpqREdxdHNVL2szZU5jNVdZQ3RM?=
 =?utf-8?B?WkxUZlpRTmlWWGVpNW9adDZmNm5FTm5Qbnl1eU1nZm1OZW45QmJEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bed916-ea76-4de1-2732-08de735b6398
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 04:15:48.7202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaTGM/7BoYbBP/Fn2dKISPEApO05MBoeyqoSQeJdM7tJGofBJdCPORKLaAUHmk3WzeeGpYlyMvAcZQ9SriJp3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 23-02-2026 06:11 pm, Tvrtko Ursulin wrote:
> Use the existing helper instead of open coding it.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 81 +++++--------------
>   1 file changed, 22 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 67911e6c552f..ee6f03f75b41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -459,20 +459,19 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   			      struct drm_file *filp)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>   	struct drm_amdgpu_userq_signal *args = data;
> -	struct drm_gem_object **gobj_write = NULL;
> -	struct drm_gem_object **gobj_read = NULL;
> -	struct amdgpu_usermode_queue *queue;
> +	const unsigned int num_write_bo_handles = args->num_bo_write_handles;
> +	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_gem_object **gobj_write, **gobj_read;
> +	u32 *syncobj_handles, num_syncobj_handles;
>   	struct amdgpu_userq_fence *userq_fence;
> +	struct amdgpu_usermode_queue *queue;
>   	struct drm_syncobj **syncobj = NULL;
> -	u32 *bo_handles_write, num_write_bo_handles;
> -	u32 *syncobj_handles, num_syncobj_handles;
> -	u32 *bo_handles_read, num_read_bo_handles;
> -	int r, i, entry, rentry, wentry;
>   	struct dma_fence *fence;
>   	struct drm_exec exec;
> +	int r, i, entry;
>   	u64 wptr;
>   
>   	if (!amdgpu_userq_enabled(dev))
> @@ -499,51 +498,19 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	num_read_bo_handles = args->num_bo_read_handles;
> -	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
> -				      sizeof(u32) * num_read_bo_handles);
> -	if (IS_ERR(bo_handles_read)) {
> -		r = PTR_ERR(bo_handles_read);
> +	r = drm_gem_objects_lookup(filp,
> +				   u64_to_user_ptr(args->bo_read_handles),
> +				   num_read_bo_handles,
> +				   &gobj_read);
> +	if (r)
>   		goto free_syncobj;
> -	}
>   
> -	/* Array of pointers to the GEM read objects */
> -	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
> -	if (!gobj_read) {
> -		r = -ENOMEM;
> -		goto free_bo_handles_read;
> -	}
> -
> -	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> -		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
> -		if (!gobj_read[rentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_read;
> -		}
> -	}
> -
> -	num_write_bo_handles = args->num_bo_write_handles;
> -	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
> -				       sizeof(u32) * num_write_bo_handles);
> -	if (IS_ERR(bo_handles_write)) {
> -		r = PTR_ERR(bo_handles_write);
> +	r = drm_gem_objects_lookup(filp,
> +				   u64_to_user_ptr(args->bo_write_handles),
> +				   num_write_bo_handles,
> +				   &gobj_write);
> +	if (r)
>   		goto put_gobj_read;
> -	}
> -
> -	/* Array of pointers to the GEM write objects */
> -	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
> -	if (!gobj_write) {
> -		r = -ENOMEM;
> -		goto free_bo_handles_write;
> -	}
> -
> -	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> -		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
> -		if (!gobj_write[wentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_write;
> -		}
> -	}
>   
>   	/* Retrieve the user queue */
>   	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
> @@ -622,17 +589,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   exec_fini:
>   	drm_exec_fini(&exec);
>   put_gobj_write:
> -	while (wentry-- > 0)
> -		drm_gem_object_put(gobj_write[wentry]);
> +	for (i = 0; i < num_write_bo_handles; i++)
> +		drm_gem_object_put(gobj_write[i]);
>   	kfree(gobj_write);
> -free_bo_handles_write:
> -	kfree(bo_handles_write);
>   put_gobj_read:
> -	while (rentry-- > 0)
> -		drm_gem_object_put(gobj_read[rentry]);
> +	for (i = 0; i < num_read_bo_handles; i++)
> +		drm_gem_object_put(gobj_read[i]);
>   	kfree(gobj_read);
> -free_bo_handles_read:
> -	kfree(bo_handles_read);
>   free_syncobj:
>   	while (entry-- > 0)
>   		if (syncobj[entry])
