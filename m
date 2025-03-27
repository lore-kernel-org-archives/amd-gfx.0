Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4AAC36010
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 13:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B204F10E0C4;
	Thu, 27 Mar 2025 13:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwOGhXY+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488F910E0A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 13:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t20qE2Zv1vJVxa+EmPLOu94Qpsj+YaM4CvVTG6atMOUrx8V3l9UgI1YnW3gMu5kHaHAZJemTPMq7vp4vlpC2/lY5Db0slAQlqt2fqhcykXHLzK9TxVA6Q5aVRYegmVNrWaVc/LvxVNg+cclzlYAhiMh+1s8LMPIgxnTDP5vato3q55NVYkqORBRxknIhmWAW36y0UYK2EsGEb4YLhb08CCIJvr1fW3eoKKksu5VaC75IlCBPdWMf0I4Kll+cgNnt9wrx9YIf2j3Qt+BVF5NLjHI0IrPxj9GN/tNeTQIbcTka+t5pplSHtIE8xNsPOCYKQgLSLhqhAnx5BRkIdsrTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNFSSufwOautc94gRLCxDeJ8OaNn6h/NBF0qXUU1pJo=;
 b=k8h/aDF0F0F9Cb64encUzI4y+gWjz+D9iQtxCsYsdncd2m2wo7F3h6VE2HxAg9/ShKu3sZRE/QAOcS1UNRyEbscfzhP8GuK6DCwfsKjK0rKjLZUc5QxQjl61lJyfJdzZHELPrn5bjgnYSpw69L0B7eGvCOYfXpnRQuUe8pP2exvzIdtFDyFxMbA5SxZ5ccjWofG/1Lf294xhTQXvCl9FYBHQCjShBWU2Gnt3nQbxUz4sGVE8MU6w1Wrtr0p4icO9+VYo1aoayCfz7CG0nuDaPACNlzs04STYJifvhsRdGkRDxrdYdEEuKQvZSZiKUZ4iJ2Dd1dev77J842s/I7L3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNFSSufwOautc94gRLCxDeJ8OaNn6h/NBF0qXUU1pJo=;
 b=SwOGhXY+EKrSlu/XQj8kNjyq4mw/yQKFYK6P9Ri8tplu92VsYmr9q20OpvrAS4Lg9Xmy1Jbb0azr8MVs+yk/jXi1m8Gecqj+sNj7a6ymP12oUt18dAczRUMadQsDZg9Wnl36HXIP5F+4r/EGDk3zgejSEh1DX0RIfZq+JRIR2Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:50:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:50:20 +0000
Content-Type: multipart/alternative;
 boundary="------------qOUw86amTnol8uv8Dl5FJpIj"
Message-ID: <6e0ab036-59fd-4f1c-8b3b-386ef450dadb@amd.com>
Date: Thu, 27 Mar 2025 14:50:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
 <740940f4-055b-483b-88b7-072907539167@amd.com>
 <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
 <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 330cd7a7-d209-4bc4-78d0-08dd6d3650a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHJLZ1EzeTJTelYzZWpSbXBTWU1BZG14c2I4Q05vS1Z6V3QvK0tnNFN5N3VN?=
 =?utf-8?B?empTYkxCb1JnMEh0eGxvSWdpdmpkZnZVdGVVSVBiV28yV0ZFUmpuNXVJbEd1?=
 =?utf-8?B?QngwU1JGaWNQdHZHaUVvRHB4T1VLU0QrS3BYeHdqQ1ZROWV2SWd3Uk40d2Nn?=
 =?utf-8?B?d1pCV1VjOHZhUVN0ekxlR05rNjRIMytlRjVKTmE5eFFKUTJVSUYzVG5zSHlw?=
 =?utf-8?B?eEVkYTJLVzFVTGdTZVdJcVVWNlFlckxldmp5RjVOQjlQNjR4Vk9vcjhzczdF?=
 =?utf-8?B?OTlvdjkvVUN2OFFuWGlCZ1FJejIzM0w2bkdpMXZ5QXRsQWJhR2NxYkJIczhX?=
 =?utf-8?B?TXZqS2RHSHdnZzJ5NnRHRVBwNXlQcmNSTVRMNUtDQVFNeS81U3dVMDhxQzB6?=
 =?utf-8?B?Z2N0TmhRYkR6eFYyb1dsNVNxL1FhRUhkNFRLWXlKbUVDdDN5eVpjdVhFUzNF?=
 =?utf-8?B?T0pIbVQ0TWNPQjJiVzhZM3d5R3NUTEpuVHI2eGRjQXRkVnN5THB3K1kvOGFG?=
 =?utf-8?B?V3lVaGJKanBWRENIN05FQnNEeHpudnFmcmhJWXZmZVJJalNvaWg5bDBpajFM?=
 =?utf-8?B?VGFjQUhYR0RuYmNlalJmNUIxaEZsNjNpZjE2eGZ1YkZrSTdJZlVncmZmRmF5?=
 =?utf-8?B?bCtaYitGOTdxdkRRd3hDNDdJRVBFVHpDRmQwZGp5WjlONndvTFN0cTlBcG9w?=
 =?utf-8?B?ZjdxUWVZaWlLdm9RTDVqTTR2UlFpTEZ5MUJlQkhBRTh4Wmc5NEhyRkw0RTBO?=
 =?utf-8?B?MG9jZHgxcEYzeUM2bXpRR2kwNUYvU3d2VFg4aDlQbGg2aityYy80TU80RnNl?=
 =?utf-8?B?R0hodGQ1Q1d1OHowUjlEYlo3dUZTWWtoenltSXQ3eXV4M2pGM3NlUjVOOEhF?=
 =?utf-8?B?R1BBakxZMlFhaGNvZFNEM0J0ZmJFRFE0M1hsSjl6UmpuYm8zM2gxdytJa2lm?=
 =?utf-8?B?d1RjbUppbEwra005RmRnR2dZMjFOTEpaTWJRbHVXSkxQMUpmczZja09pd0lL?=
 =?utf-8?B?d2NGMlpHNkxhSVBhNlBjaCtMYSthS2pCKzNJbjVCM0VhSVJ4a3FwUi91ME1F?=
 =?utf-8?B?MDdhVTVSeTd0bHRkbDZhLzJBdFluN2tyZGQzYkZCV3g2ZDByOXZFT3N3UXBP?=
 =?utf-8?B?WTNjejRwSmlvcm9JOTNrNGJ0LzBqOVlhZEZpVjZlc1RTa0pJcDhWZFF5RFBp?=
 =?utf-8?B?WDE2akdOOUdBdGgxUWJLSldMcVNzb25odS9SSkdubHFHbUpZSEZxOC83TEh2?=
 =?utf-8?B?dE1hZUxuSTRMekM4a3ZURElCdFRnbTN2TFBkVm85NCs2bWRydklieFVvNVdC?=
 =?utf-8?B?T00yVHRFWlNqUS9QTVE4QVh5eDZERkkyanFCd1BtWGRZMGFPR25Xa2V1a3hk?=
 =?utf-8?B?c1dydVJRMlJ0WUVRdTMxcjVpZzFMREhYc3o5d1ZEQk5TOTNFTTRYcVo4cDhx?=
 =?utf-8?B?ZGJldTVZdnlBY2oyS2h1NGJHbDB3WFBiQmlPQmlqR3hHNFhFWDZ5dWxpRGV0?=
 =?utf-8?B?MlFTdHBQMFFWR25IZWFpZ2lmUC9Va3dmTU96YlhwUCtDTlcvQUJVVGVHN0NQ?=
 =?utf-8?B?ZzBIODlJbkFlR2hKcGJBMHl5MENGQ0NrWXpuMFA4OVlPRlVMV3JQaDVGL010?=
 =?utf-8?B?cWM2Mm5FczhFV3djQklkRXEzZm5nMjJiRWp4d1d6UDNvTHBiZWJ1RjAxMmtp?=
 =?utf-8?B?MnRXN2g0Ry9TUHluVWJRbHBmZFhSQWtUcFFENG9hSXUyZUZjMDdTNzhqaExH?=
 =?utf-8?B?bDdMZVF5dEtJREpjL2VuSGU1MlZEZEE1U0tEL3A5N216a1J4TWhtOGFjUnV3?=
 =?utf-8?B?dFMreHlNc1BWR2xnM1dORnY2Y25zMlZHcTlEazhjSDBmb3Y5dDZ4bnZHTno2?=
 =?utf-8?Q?Oirx7UDRiK15X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTRxWkhCcDJ5LzFKTVlkZityRk1IZWR6d1RDbWtmS3VCaGdWb0R6aEQ0N3l2?=
 =?utf-8?B?eWNQYndIT3kzeXVBd0dUc3NKWlBxTGR0S1N3WGc1L1VORGh5N1dZd0NqZFBM?=
 =?utf-8?B?aGc3RFlTMWo5K0JWN1VrUElSSURWbTYzRUh3bTlLRkUxRmErSUJHNmZSMmkx?=
 =?utf-8?B?bXZ4WUZkUENqRHlETnBxSnFvNyswZ2lkVmdIQmN0Q3FhU3duaGVhZmk4b2E4?=
 =?utf-8?B?K05Ea2RRVm1GNGxWSDM0UDRLWmFtR0pLWThQU0lXdmVKc0dja20zQkZsMmZv?=
 =?utf-8?B?b1VBYURWZ2p6eVdsNnp4bHJ4Q3Rvb3FsV1l1dU9NcWtwemFjOUxCNFZmZHBV?=
 =?utf-8?B?cmdQSXBMVklZL2pVS05NMGFQUktRWG9nNEZTWkl0R0g3dU1mTldSMVpFZGZV?=
 =?utf-8?B?dFA2ZGVUVm5XdmN0OHNMVVNXMjUvWFJTV3lwaWM0YndvTDJPRWNiSE81ai9t?=
 =?utf-8?B?NDRhMW1jMWYzLzE1UXZtR2hJeThuY2FqL0pPKzdEeHlhb09ZNjdKTE5Nby81?=
 =?utf-8?B?TXVwRDZCZnRJUEdyOUtjbUorRXByTUpvMDFackRsQVVnL3RYWWFEb3RpaWxa?=
 =?utf-8?B?ZHA1UkJoUWVWZUxScERuekg2K1BOK0cxQ1Z0c0FvMktndGF1RzNWZ01QTnhs?=
 =?utf-8?B?QVJHemVHYVF6amgvcy8vUHFwQTZsbklzVUdnYzBlclRpcmRZWUJWQVFWMnVR?=
 =?utf-8?B?UkFTOGwvVW40WFJnK0I3Tkg4SlRxZGNPZVhvNThWczdIdmhNanRTY3pvaUFt?=
 =?utf-8?B?SXJHRHlLWk9rOWNVVS9CWWQ3ZTRnenI3UXdZS0NrK3YyVzc4OTJadGpjN1Ju?=
 =?utf-8?B?WDNpSmlXbTZlR1JodkczbjRIUTJ5MGRLSkNmNmVKRzZqQU5LOVAzNkthc2hT?=
 =?utf-8?B?a0VyN1V4TWVXYnZlZWEyeHpSZkZJeThiUTRiekhBY1pSaUFMSERERHdCMjZ2?=
 =?utf-8?B?UDA0cnN5R21QVkIxeWFLSFBDUjFWaXNVWkNtZFNXSVF0eGZkUGVSNVpybFJa?=
 =?utf-8?B?YTJMOHBBZGZ2TTkrZHhOWXVaaFUxV3NLL1FDdDNwZ3lVSmt6Qk96ZFZkUGs4?=
 =?utf-8?B?SVRQRkRtSll2aEF0SmJYMkhMRVZoUGEwWG5IQ1hHNkhPWnVhb3BHSmwxMW5Z?=
 =?utf-8?B?eW1pNm1oanhBelVJV2w5ZElyeXZhVG9Jd3RBRFE3QjJVTEREa0NiZjBLYmNP?=
 =?utf-8?B?VHJ0OWVYQWxMU1VlUVNrMDc0VTd2RW9yMEdxbzl4U1pERFlCQmhzVHNHY0ov?=
 =?utf-8?B?UU5BWVVIWW1DZmdnNitrMWdZU29lK0xjTm9MTkhsU1lHYWZIQjFFUVRocVhs?=
 =?utf-8?B?c1JzRGV5cDZIRldjVkc0Yi9VcGRkeU9HL3NsaUNudUh2cjZqTFJ1VDZkS2ll?=
 =?utf-8?B?NjNCWWxDbmRGVFRSMm1BMWRwMGlaZjNlUEhURG9hMDNPWG0yV09OQm12N1Fo?=
 =?utf-8?B?NE41R1Vtcmt1QlNKdjJJWG1LRHBaZWk1RDMwNmlGdXRrL29aN2huWnVHeXFO?=
 =?utf-8?B?U2pScDFjRFdLM0MybmNrcThLKzRGcWtnMm9TQWU2R2hieXEvakFDYjdUdkFD?=
 =?utf-8?B?ZDVTaUxtQ0lyVnR6MUY2WUpaVzZmZ3UzUDZ0S1BiaFNpa1FtdjU5SWNYMEda?=
 =?utf-8?B?a0x5MmxqbVlkbUFEMGdyRUcrTGJmdzN1OU10RFJzb0RtZXJwbTR5SW5yQUpE?=
 =?utf-8?B?M2lKeVdwM1J6dldWUm52UDdDdm0rai9kYWY3c1VMQ2ttRDB6d0dsMlprbmpM?=
 =?utf-8?B?R0VKcmpNaVpMQWlMbUVDemdxSFBRMFkxVTNENFQvTGw1c1ozNmNoZkN1UHlr?=
 =?utf-8?B?cVl5bEhqT2J1cXJTcEtGUERIL0VsK3hRU2RsR2hKWWVkQUYzeWh2R0FJQTJs?=
 =?utf-8?B?ZCsreDl6SXZlcmR6ZXUrSlBjK2taSXQxcVExZzVVVisrejJoRk1maFVtRE1C?=
 =?utf-8?B?cHBXMUNLOWJLUURjS0RpWjkvQjJOWWI2N3hmMnJPcWpaUXF3REdKZzFjcXR2?=
 =?utf-8?B?L1lva01rMk1pWjRKelAxRWlELzA1KzllcjZtSDFjYzY4OGNjRVFWTHVFMmgw?=
 =?utf-8?B?MlBDVU1rbGZJZmxlZnMrV01lMHpyWDI4K3lWdjM2b3hMY3YwdXFqaFViZGpq?=
 =?utf-8?Q?PkSA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330cd7a7-d209-4bc4-78d0-08dd6d3650a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:50:20.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP/FBzI2wOE3LPEV/0TBbBL9YaStifGZXTVg4tOAGQ02d/iey7zd8cTxgeaW29BR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
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

--------------qOUw86amTnol8uv8Dl5FJpIj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 27.03.25 um 10:37 schrieb SRINIVASAN SHANMUGAM:
> On 3/27/2025 2:54 PM, Christian König wrote:
>>>>> Over all this change doesn't seem to make much sense to me.
>>>>> Why exactly is isolation->spearhead not pointing to the dummy kernel job we submit?
>>>> Does the owner check or gang_submit check in
>>>> amdgpu_device_enforce_isolation() fail to set up the spearhead?
>>> I'm currently debugging exactly that.
>>>
>>> Good news is that I can reproduce the problem.
>>
>> I have to take that back. I've tested the cleaner shader functionality a bit this morning and as far as I can see this works exactly as intended.
>>
>> Srini, what exactly is your use case which doesn't work?
>
> Hi Christian, Good Morning!
>
> The usecase is to trigger the cleaner shader, using sysfs "run_cleaner_shader" independent of  enabling "enforce_isolation", so that cleaner shader packet gets submitted to COMP_1.0.0 ring by default, without prior enabling any enforce_isolation via sysfs,
>

I've tested exactly that and it seems to work perfectly fine:
   kworker/u96:1-209     [020] .....    86.655999: amdgpu_isolation: prev=0000000000000000, next=ffffffffffffffff
   kworker/u96:1-209     [020] .....    86.656190: amdgpu_cleaner_shader: ring=gfx_0.0.0, seqno=2
           <...>-11      [022] .....   150.607688: amdgpu_isolation: prev=ffffffffffffffff, next=0000000000000000
   kworker/u96:0-11      [022] .....   150.608228: amdgpu_cleaner_shader: ring=comp_1.0.0, seqno=2
   kworker/u96:0-11      [022] .....   150.620597: amdgpu_isolation: prev=0000000000000000, next=ffffffffffffffff
   kworker/u96:0-11      [022] .....   150.620624: amdgpu_cleaner_shader: ring=gfx_0.0.0, seqno=1527


The only thing which might be confusing is that when you issue the cleaner shader multiple times when the GPU is idle it would only run once.

But that should be easy to change if necessary.

Regards,
Christian.

> AFAIK, this "isolation->spearhead" initialization is not being takencare in this *path **"amdgpu_gfx_run_cleaner_shader -> amdgpu_gfx_run_cleaner_shader_job" (ie., when we trigger *cleaner shader, using sysfs "run_cleaner_shader"), and this check "*&job->base.s_fence->scheduled == isolation->spearhead;" * is having the problem ie., "*&job->base.s_fence->scheduled" address are is not matching with**"**isolation->spearhead" address, which results into zero & thus fails to emit cleaner shader, when running using "run_cleaner_shader" sysfs entry, **in "amdgpu_vm_flush()" function
> *
>
> Best regards,
>
> Srini
>
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Christian.

--------------qOUw86amTnol8uv8Dl5FJpIj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 27.03.25 um 10:37 schrieb SRINIVASAN SHANMUGAM:<br>
    <blockquote type="cite" cite="mid:5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com">
      
      On 3/27/2025 2:54 PM, Christian König wrote:
      <blockquote type="cite" cite="mid:fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com">
        <blockquote type="cite" cite="mid:740940f4-055b-483b-88b7-072907539167@amd.com">
          <blockquote type="cite">
            <blockquote type="cite"> <span style="white-space: pre-wrap">Over all this change doesn't seem to make much sense to me.</span>
              <pre class="moz-quote-pre" wrap="">Why exactly is isolation-&gt;spearhead not pointing to the dummy kernel job we submit?
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Does the owner check or gang_submit check in
amdgpu_device_enforce_isolation() fail to set up the spearhead?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I'm currently debugging exactly that.

Good news is that I can reproduce the problem.</pre>
        </blockquote>
        <br>
        I have to take that back. I've tested the cleaner shader
        functionality a bit this morning and as far as I can see this
        works exactly as intended.<br>
        <br>
        Srini, what exactly is your use case which doesn't work?<br>
      </blockquote>
      <p>Hi Christian, Good Morning!</p>
      <p>The usecase is to trigger the cleaner shader, using sysfs
        &quot;run_cleaner_shader&quot; independent of&nbsp; enabling
        &quot;enforce_isolation&quot;, so that cleaner shader packet gets
        submitted to COMP_1.0.0 ring by default, without prior enabling
        any enforce_isolation via sysfs, <br>
      </p>
    </blockquote>
    <br>
    I've tested exactly that and it seems to work perfectly fine:<br>
    &nbsp;&nbsp; kworker/u96:1-209&nbsp;&nbsp;&nbsp;&nbsp; [020] .....&nbsp;&nbsp;&nbsp; 86.655999: amdgpu_isolation:
    prev=0000000000000000, next=ffffffffffffffff<br>
    &nbsp;&nbsp; kworker/u96:1-209&nbsp;&nbsp;&nbsp;&nbsp; [020] .....&nbsp;&nbsp;&nbsp; 86.656190:
    amdgpu_cleaner_shader: ring=gfx_0.0.0, seqno=2<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;...&gt;-11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [022] .....&nbsp;&nbsp; 150.607688:
    amdgpu_isolation: prev=ffffffffffffffff, next=0000000000000000<br>
    &nbsp;&nbsp; kworker/u96:0-11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [022] .....&nbsp;&nbsp; 150.608228:
    amdgpu_cleaner_shader: ring=comp_1.0.0, seqno=2<br>
    &nbsp;&nbsp; kworker/u96:0-11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [022] .....&nbsp;&nbsp; 150.620597: amdgpu_isolation:
    prev=0000000000000000, next=ffffffffffffffff<br>
    &nbsp;&nbsp; kworker/u96:0-11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [022] .....&nbsp;&nbsp; 150.620624:
    amdgpu_cleaner_shader: ring=gfx_0.0.0, seqno=1527<br>
    <br>
    <br>
    The only thing which might be confusing is that when you issue the
    cleaner shader multiple times when the GPU is idle it would only run
    once.<br>
    <br>
    But that should be easy to change if necessary.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com">
      <p>AFAIK, this &quot;isolation-&gt;spearhead&quot; initialization is not
        being takencare in this <strong>path </strong><span data-teams="true"><strong>&quot;amdgpu_gfx_run_cleaner_shader -&gt;
            amdgpu_gfx_run_cleaner_shader_job&quot; (ie., when we trigger </strong></span>cleaner
        shader, using sysfs &quot;run_cleaner_shader&quot;), and this check &quot;<span data-teams="true"><strong>&amp;job-&gt;base.s_fence-&gt;scheduled
            == isolation-&gt;spearhead;&quot;&nbsp;</strong></span> is having the
        problem ie., &quot;<span data-teams="true"><strong>&amp;job-&gt;base.s_fence-&gt;scheduled&quot;
            address are is not matching with</strong></span><span data-teams="true"><strong> &quot;</strong></span><span data-teams="true"><strong>isolation-&gt;spearhead&quot; address,
            which results into zero &amp; thus fails to emit cleaner
            shader, when running using &quot;run_cleaner_shader&quot; sysfs entry,
          </strong></span><span data-teams="true"><strong>in
            &quot;amdgpu_vm_flush()&quot; function<br>
          </strong></span></p>
      <p>Best regards,</p>
      <p>Srini<br>
      </p>
      <blockquote type="cite" cite="mid:fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com"> <br>
        Regards,<br>
        Christian.<br>
        <br>
        <blockquote type="cite" cite="mid:740940f4-055b-483b-88b7-072907539167@amd.com">
          <pre class="moz-quote-pre" wrap="">Regards,
Christian.
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------qOUw86amTnol8uv8Dl5FJpIj--
