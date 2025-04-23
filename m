Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C763C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 12:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC99B10E1B7;
	Wed, 23 Apr 2025 12:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vXgKZSC2";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A94810E1DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 12:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYQR5KEJPJPXtDhdMJUijEoDuwDpkdHp+tKfDtma8JADYx6NI7wrdsNPPm3GKdWLIryplxGEA5VGjxjpIqQzFLUKLiPYG+s/4q5j+fdq/dMCemowbSyaigabxKBGp5NE1jS8CRCqSbpkuYiLN12/0VpxFKqqK7i7i2drzgYYI3SRr5zjuTjc9ulJXaumu4SjaWll7BoqV10u0YAIJ1XN8cBMT8cRkYbIekFFxrpXNhNM9IVO3JwXVmCgnoFGyh3y8SC/VsQb4bpVhUKLrzoeQCYxRMeFFu1uX2Zst03BVPXjjJMVqYB+CtnbyNTGlL0ayF447KFROlPy+bnaxsJifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGBgS252Ql0fvsGHLYf2nTQV6Gitifau2Isw6rhrUAs=;
 b=rrS/+fryDF+4Lb8qdSLhYj324myeB9Oi+ouh/qNnZjkaI4UTzxbIaNes5FDHrn3HCLBFSsmjVb+pAwNz08kQjULVmZhVUCCkdc9RqaU8h9YYFvMJfveEQAZPp3TZjl0WJDNGfqfMcmofxpaWo2u5B9XWMG0aHoMA5qRRgbAEb/tEM+A2X9TqCDEw/nqRTeijO34N/35Tj5+Htpl7FAShHUshqWZprVGvdD8wbA9FcQe9ABfkMz/PWiUigwyz3uAmkTYZ98HOB5W2eEH0jTpO5/oyh/N9I3Y9xqn0GRP4gKwMqZrCsFbzfYSonKWPl3Q1U8hEBCEAxxuvBpvNLCukdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGBgS252Ql0fvsGHLYf2nTQV6Gitifau2Isw6rhrUAs=;
 b=vXgKZSC2NTZ25LTCzT1JvH8FQgOWwIPArL8lP8dwM/GcvF3ML0+JbcOqFeXR0Zyi59wjpH8bZgwuJsp4IgIScvFZNPol2/w1ZaFx+FphbwhJe0rzwWxTNWD6YZtdEo2engedMTsatiXIXDqaAyayMrQlD+Ra5L3XiwVJYSmOeJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 23 Apr
 2025 12:52:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 12:52:26 +0000
Message-ID: <8e999c55-2c06-4b6a-abd5-1af96d3923ad@amd.com>
Date: Wed, 23 Apr 2025 14:52:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add NULL check for 'bo_va' in
 update_bo_mapping v2
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
 <20250422131726.3873364-1-srinivasan.shanmugam@amd.com>
 <7c581b1b-5174-4238-8a4f-1724e8977b45@amd.com>
 <306b6484-41a2-4ce0-88f5-a009c893de5d@stanley.mountain>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <306b6484-41a2-4ce0-88f5-a009c893de5d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf4b5c6-4d18-494f-48ea-08dd8265b2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3JCdG1QM0l1bXRKSGNuLzhPejZoaWxsMDlWY0c1WEpmakNJNmdRczFvUTdz?=
 =?utf-8?B?SHpOK0orZ05HdHpwN2FWRnJGZlA4THNaV2hSSkladVlLTVoycHlNUHgreGor?=
 =?utf-8?B?Y0EyUzZpR09tMDFyNnpLTmJRMmgwQjkrSGNmbTBTN2dwYkltN3dOTGFaQWVt?=
 =?utf-8?B?djlzQW5mdEwrYjlzL2lxTWtTRkdFS0swTWhkRVpQeThybXcwbC9HUXdEMElU?=
 =?utf-8?B?eTBCZVJxcmxybE84OGcrWGpIZTNCRThXVDRIcVlPbzhqdUZ2VGpYZnEvL3pE?=
 =?utf-8?B?YVVlTTlsR2NqdnNld0w5ZTVWL0RoTm1zdkFIZjEwakJUUlFxcURYd25VMFQ3?=
 =?utf-8?B?UUgrZmRoc0sreHdabHpjd0Z0QzRKRzlJK2lOUU5YWmJVNjFHUmNrTkFjdUNa?=
 =?utf-8?B?UllEWEhpQlBtbXBMZ1RyZWFSVzBxWE5RcFVkVkVEci9rYjNlckdPNi96QWZ3?=
 =?utf-8?B?QkVoMlRxZ2w2K1drSXYyMG02S2w4c29pTzRGOE5uRU40ZlpEVGtyeXBtTUVi?=
 =?utf-8?B?ZlFqM0dCNmZ0TGd3WStjU3pjNXZTcWJEN1hwRkp6c1F1aGhTVDZlTnI4aitk?=
 =?utf-8?B?b0dJMEZmZTVwNWFVaXlTSFRWVTl3OWdWdThjSWNId0tRY3N4WU4xVzhPSkZp?=
 =?utf-8?B?WUhnd0Q2K2UwaENFOGJ1U1NQVU9RdDl3ZVgrSVUxMDVSdW9GMXBxSjFVQUg0?=
 =?utf-8?B?SStwUkNwOUxDR0l4Zkg2c2EyS3JPNHhtL0hmb1l0K2JYd3FpbldDSS82NDFp?=
 =?utf-8?B?a3FLS3Y5b0pzT0xTVk52Q3MxTW1iQ0cwam5rTDRCQ25GM1JzNjRRcnY4dHhu?=
 =?utf-8?B?cW1jMlV0VWxqZHh6N0xreEo1aGxpVi9RYWFwblJySC9UU3p5L1RiVlEvcVhG?=
 =?utf-8?B?eGRxRWdFeTZ0WXRDNXB3Zit2Zkh3b3dQUjdOWms1L2ZDS0FXRXNocGk4akpU?=
 =?utf-8?B?Q0lXOTAwOTBUNEp6Q1dTdGQ0MHRLa0dyZk9LdW9neHdCaXdoTlRmcUlUK3Fw?=
 =?utf-8?B?dXVuem96UG1sdzIreTRxV1JUTUNraE9BZmc0TFZkUXd4aUNvWkhzbTh6djJ0?=
 =?utf-8?B?a0NtYm9VZTJMS2NDVzNXOFVoK1o1VWJUb2R1U1ljbE1VdUp6Tnk0U1Q0Sndx?=
 =?utf-8?B?S05yVS9JZUNxYnNQbmt4K3VqdTVCaEZvaWxZQUQ3ajhqQnkrQ2x6ckt6NzJ5?=
 =?utf-8?B?MWs5ZkZpK1prOGFWRFQrTGdzMVBrTktQVktoelBOU3BEcEVNRkxvQzBNRFFQ?=
 =?utf-8?B?dW1vdmNJNDBFam5ZMkNaTm85bTJkQkk4amNRMEZzVG1Hd1JEb3VGaXZvdEFI?=
 =?utf-8?B?NVFLclZIZFdyQTc4dXFYZ21UcjhQUGcxbDcrMkY3TDZLV2w1RFFVWDgvMG5q?=
 =?utf-8?B?Q3Q5eVEyVjRLTng3blhaSldORHNRbTQzRlgxclhmN2ZHNEVzMkZQSlIxY1l2?=
 =?utf-8?B?VFFnUTl3VnZib0xzV1hwczI3bHd0a1F2Q3ZoUWhPWEFGaTJ0ajlPMUt4a1JV?=
 =?utf-8?B?Zk1LM3p3UTRPWFpWUTRDSmJBTU5QY0UzRUtiVDVxRHRocHpVZjlKT0o0eVpk?=
 =?utf-8?B?ZTJCOGZyaDZoeG5DeWgvd05QZ1BvM1FmOGZEeTdveXB2c1dXb0hqK05NYUtQ?=
 =?utf-8?B?YkZxQnRYVUdUckVFejJVNkxLOGR0d2graXVLdFlydVEzeVZoSmJPVFlFZGEr?=
 =?utf-8?B?QjZTU0o1TnU0bnluVUFTOUY4UjRJZUk0Mm5IWi9JUzBRSGpBQ2NLLy8xWUhw?=
 =?utf-8?B?cHZVR1B0S2NoSVhuOERkUmRKUUthTVY3d09EQXltMXROejNMMHNDTk1yVDBv?=
 =?utf-8?B?V3lLM2l3UGJvRGM0ZFgwWlh3ZkF3bVZRa3N1SDc1ZmlYbVdUMEQ3VWZnUzdV?=
 =?utf-8?B?VkZmamN2NytmdFhqbVBkNTJSUENGeHNGRHFsTktQdHJaUjEwVDVBT1NMUVJF?=
 =?utf-8?Q?PFj4Xq1AlgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJDdWkvRElyL3FqODhyY202emtkS0dXQ1pYc2dxQU0ySzNMeEYyRmpUcklH?=
 =?utf-8?B?SHFad0I0a1lqSE1kenpseUJFaExyV0doaXI1bWhPMGphTnZxWnprejYvVDVl?=
 =?utf-8?B?U0lhMkhKN1BiaG9CNnByWWF0Nk1JWERIWDdzN3M3aWg3alMyUlhMeDJ3U0E2?=
 =?utf-8?B?YnZUbmRVKy9uN0NGNUExTm5jK25QR0pleGhRamZIOHBIbHFzQUxLR2dHRUI0?=
 =?utf-8?B?a3UxTUVVV242cHN5Snd4dU9YS0ZWMytWU2toSnRpaitFZGZiN0RCYzhLZGhN?=
 =?utf-8?B?OEtYOW5KZkNYSlVxSWplOStyaDcyZWRSRWMyRTQweUVadGdKWkVEd0dEd0p6?=
 =?utf-8?B?c3V1blFTRWxmSCtDSVB6amJZR3dGV2xZRTdWdE5XZnV0bEQ3K2phRHM5NkRh?=
 =?utf-8?B?MWl2Q3lRU0Q0dGF3dnZXQytoYkFud2dLbmxCdDJJeGxoN0wrYkFQdEdVVVlN?=
 =?utf-8?B?SFNaeTJueU9CZ3VzOGlRa0R3Y2MzdmdIc1JPZHRXSlpOZVd4NXdXWDRxZFlJ?=
 =?utf-8?B?aGhoNmxuQUVTMFIvNjg3QUY4MW1SdGJXZ3ZYMFdxU0VyWXpOQXRYQ3N1aVNn?=
 =?utf-8?B?QnlNVGVUVmw2UnlORHVERXVwVHhRcUhlTzhQSm9IZFp1dE9GUlBBRS9ldERX?=
 =?utf-8?B?OGFOdWFYQW9HZWRPVU5lMGsySURTbE02RVdwMHJkdzQySk96WFgxOFB1R2RI?=
 =?utf-8?B?M0daaGYvY0ZXUFF5OUpmUVU2TG1QbDRIN0dVZktVWWFsTmtRb0xhc0h5Ym52?=
 =?utf-8?B?M0pQdldMdEJZVlVTajZqMEZDdTFtMDdnMk1BdVdpM2o1RHFiR2I1VUY4WGFY?=
 =?utf-8?B?VzE1OHVmMVphamtGZ0x0aVZCbUY3R3dpR1Vrcm9TTlNNb3hsVFdNWXVkTzZu?=
 =?utf-8?B?d1ROSENZajJpaS9COWcyaDBwWTEwMU41YmtnYTdvMGRJMkV5SURBR0pNWXRN?=
 =?utf-8?B?SjhjN2FUQlBQQVpWaVp5dHBUT2NzQS96U29XcmdQRnJKSVQ2N0NISmRrWmE3?=
 =?utf-8?B?RnpUa2xvSFdWS2FLQmoxQjAzV0FsL2podzQzUmtnS2UzdmVkZ1lLMDZGSW5J?=
 =?utf-8?B?ZWZrM2ZsbHIrZVlWQUp0ZkZjTkhXdDN1NXFHZ1EzaHJkQ09zcGF5RVZ0aWc2?=
 =?utf-8?B?NU95TklHeXh4NnpCdGhoZW90bmFMQTlEMlBwV0cza3RaWTB1Z2g5djJGTTZt?=
 =?utf-8?B?dUFCMWNtS21CMkMyM3hnZVQzcVVUYTFheVQzZE9RYjhTVFQ1aitDSi81eitE?=
 =?utf-8?B?ZEJrUm9lcXl2bWZNbFo1MEdTVmNqRmpUMm5zV2lEUGdjdGNEZmJ6TUprUC9T?=
 =?utf-8?B?U3hpVDJxNDBCdHRBdnc4VVBQcDNDcGJKdWl0NTdzdE5qcHN6eDdnODFvQVVY?=
 =?utf-8?B?dkVUT1ZaM1NKejN6ZTZoOEl3U1Q4cThJSklUcUVwRWIxRnRJeHUwK3JiVTFF?=
 =?utf-8?B?Tm4rRkl6UytaUDZaLzlVTkxNM0FsQWRWRVRpL2dUWExxWG5Nck0rVzk3RWZt?=
 =?utf-8?B?WVZhVzA1TjgwVmtpYzZPdlo1MGhwdFF5SmtadzhuN2NmL2duN2g3ZHhFMm1Z?=
 =?utf-8?B?RTBpWVg5OUFQb2Z3VVJVSlN5b0ZMZGlDcUtZVmx6aDlyTUtLVWZIVi9CNDNJ?=
 =?utf-8?B?Nkc3aWQvWWJFUm84WGthYW01WUhrMzlwTVJoWGZhRC9DV1pPb05yYUFrdVBz?=
 =?utf-8?B?UE8reitRZXpZb2NqZjNUSHlUVXF6bUFnR0w3TXNLMXQwWUtGckZPNnBOM2tp?=
 =?utf-8?B?aXl1aExxZEY0R0JIVGs2UnVBTnJ2QkYrZ2RsMDI3VHBkQTdrSTBVNnlyRFBQ?=
 =?utf-8?B?NXVFdDhQeVUxMkorTHM0NVRnQWtobXRWVis2RENORlF3OFpjdXJsOVpLUGQr?=
 =?utf-8?B?OUtLZnlETmFqbjlxL3hiTjA1dG83VENHU29xekZhS1IxNjFVcFczVFl6bERV?=
 =?utf-8?B?Q0FsYS9NR2piMWJwbEpEMDYvZ3VPSmk1N1Y1VnVYRDJoQjIxbjZMbTkyVENC?=
 =?utf-8?B?bVprL0VBK2JaWWtsOU40T09WMVRDdWpPb2tjMElwSTVqODE4M0V1NEowYzVz?=
 =?utf-8?B?eTd0czZhK2M3VXFZM1BvNmZaM2hZTEc3eGFYL0cwYnhUd3lKTEF6T2lhYmlB?=
 =?utf-8?Q?EBFU7d3r5yc2F66n8w8L5hOUa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf4b5c6-4d18-494f-48ea-08dd8265b2d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:52:26.1461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNcxikf4Y3bA5Z5YO258BTXsZBJnLLIeMubOnIWysK2HC/l6Vn/MYvNMqHXPoAHA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

On 4/22/25 16:15, Dan Carpenter wrote:
> On Tue, Apr 22, 2025 at 03:34:58PM +0200, Christian König wrote:
>> Am 22.04.25 um 15:17 schrieb Srinivasan Shanmugam:
>>> This change adds a check to ensure that 'bo_va' is not null before
>>> dereferencing it. If 'bo_va' is null, the function returns early,
>>> preventing any potential crashes or undefined behavior
>>
>> That commit message doesn't reflect the changes any more.
>>
>>>
>>> Fixes the below:
>>> 	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
>>> 	error: we previously assumed 'bo_va' could be null (see line 124)
>>>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>     115 static void
>>>     116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>>>     117                              struct amdgpu_bo_va *bo_va,
>>>     118                              uint32_t operation,
>>>     119                              uint64_t point,
>>>     120                              struct dma_fence *fence,
>>>     121                              struct drm_syncobj *syncobj,
>>>     122                              struct dma_fence_chain *chain)
>>>     123 {
>>>     124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
>>>                                   ^^^^^^^^^^ If bo_va is NULL then bo is also NULL
>>>
>>> 	...
>>>     135         case AMDGPU_VA_OP_REPLACE:
>>>     136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
>>>                             ^^
>>>
>>>     137                         last_update = vm->last_update;
>>>     138                 else
>>> --> 139                         last_update = bo_va->last_pt_update;
>>>                                               ^^^^^ This pointer is dereferenced without being checked.
>>>
>>>     140                 break;
>>
>> Please completely drop that. This conclusion is actually incorrect.
>>
>> BO might be NULL here because bo_va->base.bo is NULL and *not* because bo_va is NULL.
>>
>> @Dan your script seems to reports false positives here.
>>
> 
> I mean my analysis was only based on only looking at the function itself
> without looking at the caller.
> 
> It turns out that it's a false positve because "bo_va" is only NULL when
> the operation is AMDGPU_VA_OP_CLEAR.  You need to look at the caller and
> also where fpriv->prt_va is set in amdgpu_driver_open_kms().  It's a bit
> too complicated for Smatch to do this level of analysis.

Yeah that is true but I think that is only halve of the story, the logic in the analyzer looks flawed to me.

See what is reported here is this case:

if (A) B=A->B else B=NULL;
...
if (!B) x=A->other_member;

The analyzer concludes that since A was checked before and when B is set to NULL then A must also be NULL in the second usage, but that is incorrect.

Correct would be if B is NULL then it might be because A is NULL, but it doesn't have to be.

I would double check the Smatch logic, 

Regards,
Christian.

> 
> Anyway, yes, please don't silence static checker false positives, just
> ignore them.
> 
> regards,
> dan carpenter
> 

