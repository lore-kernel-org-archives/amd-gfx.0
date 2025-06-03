Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666BBC5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 08:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008C910E657;
	Tue,  3 Jun 2025 08:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLFH6FGl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928E010E65F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 08:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ8owuc3sFIFqqUMgp1c3TzJW34KLad5yvNHK8ZjsTq5Oc9JCFt3uNHnIHORSgf/8H6PLpfrUsSvF/FO3/geDDEdtVw+rJPJCnX1HzAEXEkba9GPGvZLVYb3+jVvVxzylzVd7Wq7n9yTGYNurKIqZN6KIz57jx8+dNAoUbNTGJr3c9Ms9Z44IEbzjA816xP1xXJ0JCndJ0+INafgefHz+9SOVhwZ5Abnpk4Gsd+7whltSxJrHYxmq71jzhy/NIORa1EXUAEDTF7joWzvQsI1Aorz8wW7qZfWPUsVHeT68ObIgUqLbHy2/eIE1YX7RZ5RZTTkv/SOu2pXuuXSZkzOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+/FG45Q+QM3TRwEo6m0V5owq7G9RLeXNgPRvhHJ2XM=;
 b=vmRHcMzQVojVpFlipuJX0QgUJKTcXd9Edp6XTY1Z52ym0IlKkD130QuJ8sIcJLqnWiOnALaMJwdm8gwTwU4/b178tvcSqYzsZhBFnIwX9K6fyDA8sP1FQsO3UoOSpg9RU7QoUyBUckNKikz0mIvX+wBoC5H+FTRQNQA+xWHsAiLlyB4eFOZlGMOdj+qy/qLMIz3/jSayw+r+V2gauMiE7cHi8se3A3iqG2eH0uBtPIopkklhYWX1ocOhf4qZW+DbO4HJDZumtzk6il2askbSaks0awqj9FTapxCAZ5CUlvzMcEztgrsxlBReWyoPgW0aJuWYRstv3lYrRPYs+KbjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+/FG45Q+QM3TRwEo6m0V5owq7G9RLeXNgPRvhHJ2XM=;
 b=nLFH6FGlDm7u12Q7FwAQ4vHgSkhI3bcEXezWh/dWVC4SXcSsGr44vAKbSRyznvL13dUDfyEwFo6uI8OzVfB+DnLV6wlc3FLJ8hyy7gPjsH+WhKujcbi6xvU4DHYk80VhtHM1b9KHfdmxHX6XEtM7loQGP4D1GpQ+hE49vkAiWxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 08:03:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 08:03:39 +0000
Message-ID: <d44d1df2-bd9d-46c5-96a5-6694ae4ad0ea@amd.com>
Date: Tue, 3 Jun 2025 10:03:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] drm/amdgpu: track ring state associated with a job
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-8-alexander.deucher@amd.com>
 <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
 <CADnq5_N_0Wzjm8vCoboqe-8EuMcpkBVwg_=BVy-V3XbM=rHqVQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N_0Wzjm8vCoboqe-8EuMcpkBVwg_=BVy-V3XbM=rHqVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: d52a1fc7-54ac-4cac-1b3b-08dda2752605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXJjYjQzUFRtRDAvUFFSZ01CbG5aWG1UL05XQk0yTXkwMzhBbmtaV0R4Rkgr?=
 =?utf-8?B?MGw5MFZyZStoZmt5NW9wQ2N0TFhEdGE0SzNmR25mMm0wMEpNR0N0SUpkcmZV?=
 =?utf-8?B?VmdEeWJ6Z0duVWRtdHJHWnlma2xLdUkvemF1dmVJR3ljSndhemlkdWtvNjJq?=
 =?utf-8?B?WTlsMU8xeXJtdE5wem1BVTduUlJOeER6Z252Y2xzN3p1aGNhcmhXMlFmQUdj?=
 =?utf-8?B?Ni9WODJMV2EyK0UrSEJPaVNlR0JsWTNLU0VtTGc4NU9CNW5zbzJaVmRRQmFX?=
 =?utf-8?B?RnFJNzN1ZCsvMURuSTE2N25Ha3lGY29PbG1rSTdOWS8zemltSDEvTTBLamZo?=
 =?utf-8?B?WGdzOStUS0ZZbkhQWTRsKzNlRTBQUWVpSHZ3TkJQckRVOEFmUE9wTEZ5UE9N?=
 =?utf-8?B?cFBDV2V4b2Vmc3RWdVpScTBtU0RRSGZEWlFqODdZMXZCVHdpQndQSDY4cS8x?=
 =?utf-8?B?cEdEYm1ZZzRCZDNhc2V5WXhRbW9LY21HRkRURFRWbWZNMm1BYWlJNVJ6R1Fo?=
 =?utf-8?B?SDhDZXdNdzA4YVBLQ3BJd0FWSE5HMnZsWnlUbnRKUzZRSmpFZmp2MXFkTFJS?=
 =?utf-8?B?c1Q0YWZ5VG03MVM2Slg2c2tPN2l3cDRYd0t6ZkU1ZENsQjRISGwyZXorSjVR?=
 =?utf-8?B?dzRHU2VTcjg3VXBUcXhTbktjYThWbFNXS0xXQ284bXo3RVJnUmJTSlFTVmhD?=
 =?utf-8?B?V2tzRFJmaGs4dEQ2ODFFZUFOOGtzSlhMTWRsZXRxMHNoaCtnMUp1MVhjZnZ0?=
 =?utf-8?B?ZkpTS3M2UmFja3JjMWxJZXlrM042c2VMcEowZjIydnhjQjhERUl4UWF2UXVq?=
 =?utf-8?B?bDBrbkdCM1VncFg1ZDdZVkZpWXVNQmdoMWpsY3ZCdC9naDN2MzlyTVlZRXN6?=
 =?utf-8?B?N2JrL0NFaXo3NVQxUzliNkNBZzZGK2UzVENQeFlxSnFwa2FldEd5dXN5Z2NX?=
 =?utf-8?B?b1FlbVd5TVJIY25yUEQxbzJuUEdybkMrbVVySUNyb1VFc3FwbFZUcEpGeHBa?=
 =?utf-8?B?UUp4NGJlVHhIKzZrdUZOczNqWnlBSWQ3K2pBV3Y2dlR2OEZHZ1MzRERGTWJD?=
 =?utf-8?B?enVJT093Y0QzNkFPcnJSTTB5VkdITjMvY3dMQXVHZzRTTHhHSWpwUTlBblo1?=
 =?utf-8?B?bnl1QkR3UnBCVVdFVndTakpod2FGblVZWktyVWl5ekw2YlUwWnhFaXpubWJH?=
 =?utf-8?B?cTdqWnVaWG43d2kvRER2MUlycFkxMTJxZ1lOMEI3R0xkRkFyL3VscSs2OFJx?=
 =?utf-8?B?N09ad2xBdGdPU3dnL0FsMm1vb3BYa1g5MGZlUmpwdlBOQ0l1NFp5dzZDZUEw?=
 =?utf-8?B?Y3UyLzYvZHJqU1FMTWVSSW9tbnphMnQyZm85K1JYd2xqcXhXNWhsczBIOW45?=
 =?utf-8?B?NEtQUjhmU0VnaW1FeHRZa2VOa1d2WXh2MXBWeWlvUmFaMStlc2NLQ1JhUVkr?=
 =?utf-8?B?eW85d1pyMHhLMnpOT1lzVmNoL3lyK2JpcU8rNmxhNUZnN1NMN3k1bTJ3SldQ?=
 =?utf-8?B?emx4QmlEMkJUWmk1cTdodGZVMGEvS2xxbDI5eVRQTmFoc3JSR0l3NEt4VFhO?=
 =?utf-8?B?K0Z5ZWRqTVNtekRMM0RnNVZEclhYMEZTaFdGL01WZmZSaHVtK1hHVFVYNktw?=
 =?utf-8?B?bnlqUHdzU2M2a2FjWm50Tnh6MzY0MHdkQzJ3QUZxNFNQSEZzczZpUFhvZ2lu?=
 =?utf-8?B?eDdqakdKWVljaUpNcjlKWWFzL0gvUVlXKys5eDVtd2owMk9tWkR0bSttNVFM?=
 =?utf-8?B?RGFkdTFmY3dJOVNOTG5ZUE1QWnkvUW8yWkI0bU1GR04wUHB6ZmZkRWd5NEVw?=
 =?utf-8?Q?Yl4TyMCAnEpqfPKTX1QxsVcamw3+LK/KkZSsQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUs0UHdoUklKT2pYVi9SbVp0cTVrTkVjdlExUWRtL0ppeG01eEJxR0JPS3cv?=
 =?utf-8?B?eWFzSUE3L0dSZDFzWFNpMTR5NVdaME0yeWp1WThuZ0VRelhUZ0JWSDB5UU80?=
 =?utf-8?B?eUREVS9yYkRxMVlJbWgwbURoZVc1NHVSNzJCN3NCNVVBM1VCL0RqU284WXll?=
 =?utf-8?B?VWxEUTBScEtYaWk4eTdWYVRBQWxtSFFVK1BIa3NHQVpEcnhoMG40cDZlWmEx?=
 =?utf-8?B?NU0wL2xDNXc5eXpsbGNITGNQd2hyVXZiN2RVUjlVdHVRTmxTSEVUaG80WnY1?=
 =?utf-8?B?QWdPTWNCSG1iY2Z3b1FXbzdUa3E2NFJJVzVCN01HQ3YzOTU5SGtra0JQTU8y?=
 =?utf-8?B?am1YYWIrUUpPU2QzMSt4Zm9ZbUYyL2cyaDZHQ3I4YkdyaG5OUDl6aFY5K0dU?=
 =?utf-8?B?MlVLMDlGKzZIWVF3ajY3SUduRnhHQmZmZldoTisyQzRZL25xekQ1THBGYlRH?=
 =?utf-8?B?NkVoM3BmZERnK0l6bTFaamNyS1RvdHJuR0YwS1ZVRzdsRERBVnY0YzNiTEQ3?=
 =?utf-8?B?ZVhXTFExZzJSWTZpMzZDVDRrUEVRc3hnaW1UWmNQeGRhdVFTSXlCNncxMmJp?=
 =?utf-8?B?aWhHRHJHRWRwZnN0V2xrNzNaa2JMNGxoeDM1eXhVSGQxWVJ4L0dXZk9iQklx?=
 =?utf-8?B?MTNUc05SN2RFQ1RhSzg1ZW5ZM1dqWkhJWXFBNllmS3NVcWJleVFEdEcvNkZz?=
 =?utf-8?B?aUh2eTdTWWhLY29ZUG9QRXZsRXg4QlhmU2hNT1B3UUJHcitSeExabEJaQjgr?=
 =?utf-8?B?T0ZoUk41NkNsc3dpTGlTRHM5NmJyVE9TczM3S1gwOFVSK3lYUEpVVi9SWHlx?=
 =?utf-8?B?Q1A1WHA1cGs4MjFBR2RVL0duWloxbk1hQ0ZVSER2eHRORnZMcENWdDNmSWdw?=
 =?utf-8?B?ZWFCckFGMDF1YVZkQ0VPTnc0K2VqZGNwQ2ZhVjVlKytKNW5lbGZ4YmlKVVh6?=
 =?utf-8?B?aWIwVnBTTkdyYjdaV2drSkZYaGw3Y3NSNlkzN0RrL3Z1ckNsaGdsUlNwenRq?=
 =?utf-8?B?eWU3ZXViMTlQNWU4WU8zM3FhZ05URnZYdEs5TXdRQ0VySjY2ZjdRcmp0bCtr?=
 =?utf-8?B?REloN0Z4WlV3UWRGKzB6elF5c0hjYjFnOVV0ZUJ3b0FhZFcwRTJXUFhjRFFO?=
 =?utf-8?B?eXBHa01UM2p4R2d0b2Y5dVBTOS9GdFNkRDRZV0tyMituTjdRWjRzVWRrdVEv?=
 =?utf-8?B?QmY5ZlJwRnpYZk92TlhJKyt2MmJXU2szV2p3aGtydVZTdnNsSDFYdkZxblFs?=
 =?utf-8?B?Q3AwSDM4Y2pYNzNKODdHVWY1dGF3MlZJQmk3MXBlWWdENlB5Y1VmdGkxVXZW?=
 =?utf-8?B?S1pGYS9YaW5UamxoajQ0UkNNSXAweTJ4aDREanZ0RjhmMkRtZHVrRlZ1M0lP?=
 =?utf-8?B?T1FIaFRJRmpFdzZxWE1ZQW80ejd3ZXArTEwzRHBwSEZ1emhLcEhmVWE1YWVi?=
 =?utf-8?B?OWNmOHQwd2FhL2xYUXNFSUd6bmQxL1gwdWVJOXJKSDQ0ZTFkbEN3QklGakhq?=
 =?utf-8?B?YnJPQUR3bGdpUHVZRFo4emZhc2dONkNYYldyYVNWRGNnSm9sMWxRZkpQZlp6?=
 =?utf-8?B?UmMzRlFYMmt3bVJzRmQ5QXM1aVRWY1hrZFAya1gvcDhXc0QvcmgvWEZTeHl6?=
 =?utf-8?B?SzdDS1NlU3czaTk4T3ZWb2d4T0FnRnZPSWJxVndHQ1JmTkxybFlwWG1yS3Iv?=
 =?utf-8?B?VzlkVDcydzAwRVo5TGNsSDJBdEh0aTZaYTBINWgyb25RNWhnOUw3OHpOcTZC?=
 =?utf-8?B?ZnhxaEdIa25hNXVpQVJZN3M0SnowQ0I1RERTbm01ZXc4MDhtWndqUzBpbE11?=
 =?utf-8?B?dU10cllBVkdET1UwSVVMdGRoeldzeHlwSEdqZ2VsWml4YURYT2NCN2ZyeXp4?=
 =?utf-8?B?Snl0OUpJcG4yQlRlNHZTU1VZaG9LNXU1YXQ4a1hRZ2szTml1NEw0MHQxcDBk?=
 =?utf-8?B?MzUrSDMxRHZ6b1owWmZxUjE2aW1TRytUT2RqQUhlQWIvaUVmZ3hYUnJ1NUtp?=
 =?utf-8?B?VlNqNFczNWFTUFBkWUVwVjdSUmlucHNzeTdaWk1BQWpPUG1Mc09nYk1GcGFL?=
 =?utf-8?B?R1JrUnlQU1ovNmh4U1htblFZT2pTQzZhYUZ5ZTBhdjJXMVJ5VUpGbmxlakdr?=
 =?utf-8?Q?wn46arbFgD0m06Xvj5664hMyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52a1fc7-54ac-4cac-1b3b-08dda2752605
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:03:39.3979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W8FQgras1bTpZWIot0vKx2m+ORasC1oQ4M65xJwKkNkY0MscSI0N2e7QedZhV5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

On 6/3/25 00:42, Alex Deucher wrote:
> On Mon, Jun 2, 2025 at 10:36 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/29/25 22:07, Alex Deucher wrote:
>>> We need to know the wptr and sequence number associated
>>> with a job so that we can re-emit the unprocessed state
>>> after a ring reset.  Pre-allocate storage space for
>>> the ring buffer contents and add a helper to save off
>>> the unprocessed state so that it can be re-emitted
>>> after the queue is reset.
>>>
>>> Add a helper that ring reset callbacks can use to verify
>>> that the ring has reset successfully and to reemit any
>>> unprocessed ring contents from subsequent jobs.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 12 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  6 +++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  5 ++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  2 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++
>>>  6 files changed, 78 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 2f24a6aa13bf6..319548ac58820 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -764,6 +764,18 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>>>       amdgpu_fence_process(ring);
>>>  }
>>>
>>> +/**
>>> + * amdgpu_fence_driver_seq_force_completion - force signal of specified sequence
>>> + *
>>> + * @ring: fence of the ring to signal
>>> + *
>>> + */
>>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring, u32 seq)
>>> +{
>>> +     amdgpu_fence_write(ring, seq);
>>> +     amdgpu_fence_process(ring);
>>> +}
>>> +
>>>  /*
>>>   * Common fence implementation
>>>   */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 802743efa3b39..67df82d50a74a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -306,6 +306,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>
>>>       amdgpu_ring_ib_end(ring);
>>>       amdgpu_ring_commit(ring);
>>> +     /* This must be last for resets to work properly
>>> +      * as we need to save the wptr associated with this
>>> +      * job.
>>> +      */
>>> +     if (job)
>>> +             job->ring_wptr = ring->wptr;
>>
>> First of all such state should *absolutely* not be made part of the job. That belongs into the HW fence.
> 
> Done.  Updated patches pushed here:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=heads
> 
>>
>> Then we need to handle the case that one application submitted multiple jobs which potentially depend on each other.
>>
>> I think we should rather put this logic into amdgpu_device_enforce_isolation().
> 
> I'm not quite sure I understand what you are proposing.  Is the idea
> to track all of the jobs associated with a particular process and then
> when we reset a queue, skip all of the ring contents associated with
> those jobs and signal and set the error on all of their job fences?

More or less yes, I think that is what is needed here.

A simple example: Unigine Heaven in window mode on an X server. Each frame usually results in 3 job submissions from unigine, plus one submission from X to copy the result it into the displayed frame.

When we now assume that we can schedule 4 jobs at a time on the ring we get: U1, U2, U3, X1 | U4, U5, U6, X2 | U7, U8, U9, X3....

Let's assume U4 hangs and we initiate a queue reset, in this case we definately need to skip U5 and U6 as well because they belonged to the same context and depend on each other. Only skipping U4 would certainly crash the GPU again.

X2 also dependet on U6, but that submission is from X and totally innocent and rendering garbage for the window content is probably ok considering that the application just crashed.

> What about cross ring dependencies?

For gang submission we would need to do a queue reset for both the gfx and compute queue to get out of this again. But that is probably ok since each queue can timeout on its own.

We also don't need to track the jobs per process, just looking if job->base.sched_fence->finished.context changes should be sufficient.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>
>>>       return 0;
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index a0fab947143b5..f0f752284b925 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>       struct amdgpu_task_info *ti;
>>>       struct amdgpu_device *adev = ring->adev;
>>> +     struct dma_fence *fence = &job->hw_fence;
>>>       int idx;
>>>       int r;
>>>
>>> @@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>               else
>>>                       is_guilty = true;
>>>
>>> -             if (is_guilty)
>>> +             if (is_guilty) {
>>> +                     amdgpu_ring_backup_unprocessed_jobs(ring, job->ring_wptr, fence->seqno);
>>>                       dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>> +             }
>>>
>>>               r = amdgpu_ring_reset(ring, job->vmid);
>>>               if (!r) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index f2c049129661f..c2ed0edb5179d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -79,6 +79,8 @@ struct amdgpu_job {
>>>       /* enforce isolation */
>>>       bool                    enforce_isolation;
>>>       bool                    run_cleaner_shader;
>>> +     /* wptr for the job for resets */
>>> +     uint32_t                ring_wptr;
>>>
>>>       uint32_t                num_ibs;
>>>       struct amdgpu_ib        ibs[];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 426834806fbf2..909b121d432cb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>       /*  Initialize cached_rptr to 0 */
>>>       ring->cached_rptr = 0;
>>>
>>> +     if (!ring->ring_backup) {
>>> +             ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
>>> +             if (!ring->ring_backup)
>>> +                     return -ENOMEM;
>>> +     }
>>> +
>>>       /* Allocate ring buffer */
>>>       if (ring->ring_obj == NULL) {
>>>               r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
>>> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>                                           (void **)&ring->ring);
>>>               if (r) {
>>>                       dev_err(adev->dev, "(%d) ring create failed\n", r);
>>> +                     kvfree(ring->ring_backup);
>>>                       return r;
>>>               }
>>>               amdgpu_ring_clear_ring(ring);
>>> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>>       amdgpu_bo_free_kernel(&ring->ring_obj,
>>>                             &ring->gpu_addr,
>>>                             (void **)&ring->ring);
>>> +     kvfree(ring->ring_backup);
>>> +     ring->ring_backup = NULL;
>>>
>>>       dma_fence_put(ring->vmid_wait);
>>>       ring->vmid_wait = NULL;
>>> @@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>>>
>>>       return true;
>>>  }
>>> +
>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
>>> +                                      u64 bad_wptr, u32 bad_seq)
>>> +{
>>> +     unsigned int entries_to_copy = ring->wptr - bad_wptr;
>>> +     unsigned int idx, i;
>>> +
>>> +     for (i = 0; i < entries_to_copy; i++) {
>>> +             idx = (bad_wptr + i) & ring->buf_mask;
>>> +             ring->ring_backup[i] = ring->ring[idx];
>>> +     }
>>> +     ring->ring_backup_entries_to_copy = entries_to_copy;
>>> +     ring->ring_backup_seq = bad_seq;
>>> +}
>>> +
>>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
>>> +{
>>> +     unsigned int i;
>>> +     int r;
>>> +
>>> +     /* signal the fence of the bad job */
>>> +     amdgpu_fence_driver_seq_force_completion(ring, ring->ring_backup_seq);
>>> +     /* verify that the ring is functional */
>>> +     r = amdgpu_ring_test_ring(ring);
>>> +     if (r)
>>> +             return r;
>>> +     /* re-emit the unprocessed ring contents */
>>> +     if (ring->ring_backup_entries_to_copy) {
>>> +             if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
>>> +                     return -ENOMEM;
>>> +             for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
>>> +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
>>> +             amdgpu_ring_commit(ring);
>>> +     }
>>> +
>>> +     return r;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index b95b471107692..fd08449eee33f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring,
>>> +                                           u32 seq);
>>>
>>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>> @@ -268,6 +270,9 @@ struct amdgpu_ring {
>>>
>>>       struct amdgpu_bo        *ring_obj;
>>>       uint32_t                *ring;
>>> +     uint32_t                *ring_backup;
>>> +     uint32_t                ring_backup_seq;
>>> +     unsigned int            ring_backup_entries_to_copy;
>>>       unsigned                rptr_offs;
>>>       u64                     rptr_gpu_addr;
>>>       volatile u32            *rptr_cpu_addr;
>>> @@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>>>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>>>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>>>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
>>> +                                      u64 bad_wptr, u32 bad_seq);
>>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
>>>  #endif
>>

