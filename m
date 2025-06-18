Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FABFC71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 14:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D830110E861;
	Wed, 18 Jun 2025 14:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e1cV3oob";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB5410E860
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 14:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXjsU7ugnRQxfZuvrgQqVMrmuSCfnf0kzS9cZ56/yPh0s+Sep40vcu/q1p7VMgM3Kjj39VQHK6LVbZXH0+vB2O0mdi93jXko35tNjTxhSN7eVD4LhUlCF3SD6J5nQTpq2FsVTTCxHBxsynP4/pFD/tVNCprQrDuQ17bbxPnEgJWI7U908rclXQkA/LukYDoyaah12iF3Y7jM8mtKxfM4ch1CS8z/y6CGfivLco/WMWPp4YJUUNJPQfL9/O3n/F2w3fRtc7Vqz9k7v6ByGvxx7AB5qDlb0NHRfj0u671VLggDoFL4gYuBTRlzHiP3hn3dR3jS2QMqxtcGBEdBoRme8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAdXjsj6D6uC7wxjkKysanVcoH2VgXX3xJ1KKqRqsgs=;
 b=Kr83CS2iyAuYNwGTzs296h4ChTTl5staXOHH2CZru1J9TYL/GietB38KvcnZbgFTQHC2/0JppHX/SwMk7YWxmnHlxe7R41RyxL0dve3r4lz5KU2BMh5Zee/KnXZpAVTCxNK8vInbSy3XxZfumGbRj/7bCdcJABB8eAKpH7q4CH3x1opW9yYTypwAicGwza9I3vsVc2t4WN1eIFW/iiel5ei5Xtx0Sqol6NxjMheaCTaLRPdU3BSGxj0BXIAs6i15Q2FackjZakFHsCWIKK3GJDngM0+kYvvlHtwiD7HdEJFah78rMNfjnm++IK78kOp8UiJP5IJTjs/yNQyjxwLxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAdXjsj6D6uC7wxjkKysanVcoH2VgXX3xJ1KKqRqsgs=;
 b=e1cV3oobv4fj393NNYkU5jzpheVzNjFrRoh2kFzU5Oj/0DdWb/6iVmyAeF1ptQbO710v5gqtK0ROgu8qYYuhlZQT+kvBC6elIXhVdE5EBxq6I6hlHZQscuU9E3tGKH6pVkB1LrcwOj593njMoEXqEMhUBFnI5+SCgVPmTZE2jco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 14:16:29 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:16:29 +0000
Message-ID: <661f8df2-b9bd-4294-a758-de5d1208ff7c@amd.com>
Date: Wed, 18 Jun 2025 19:46:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/36] drm/amdgpu/vcn3: implement ring reset
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-37-alexander.deucher@amd.com>
 <f8b4bf5b-17ca-442a-a515-7860037a8afd@amd.com>
 <CADnq5_OisducAyYtztD5-L+ib_j8dh6p0HhCN9a3tV63duaDWA@mail.gmail.com>
 <b0bb069a-b192-4b6d-bb2f-dd151a053148@amd.com>
Content-Language: en-US
In-Reply-To: <b0bb069a-b192-4b6d-bb2f-dd151a053148@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::14) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: c00de0fe-c8d4-4b1f-6373-08ddae72b80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWQ0dThGalF2T2F2UWwwYmNrZHA4a1Bzbk1iOFRVYjFBMkRCVGhKMnlMaC9m?=
 =?utf-8?B?c0ZyWW55VmFoekN4ZitpSDY0cXl6QXprbndhNk56czVuUW5lVXJIK0U5MDlp?=
 =?utf-8?B?bExEa2ZVcHZIaTRkaEErWHBIQUNURTFqeTZkUU5ub2o4ZEdjZVlOdE8rS2xZ?=
 =?utf-8?B?SVc3MDZ3UFh4NzdLL1pHTmk4L1dSa3NHN01TdE1SR1ZXR1h4RWhoNjd3M1di?=
 =?utf-8?B?a1RCand2S2djM2thRklGWVJ0dnY3N2RGcHQ2cUY2YzhqQ0twcHZ0NEJ0SE9y?=
 =?utf-8?B?OXp1b29GdlIwb01yUVNUU1Q3WDVzcVNrNmxlL1B0MS9yNkZGQjZtZkJjWlYr?=
 =?utf-8?B?aStySThsbTdsSU1VOHZyOEJJd3JDdFJXZkp6V2FiOFhXSkdJRGtWZ0tFZktu?=
 =?utf-8?B?Q2oxZHh5Q2ZFa1JRM0ltR1R3YlltUzFrbzFUVXA4djNCWXRha0o3Wm5MTjFR?=
 =?utf-8?B?QjVNWnpuZUdFWlhLcC94cTBVWCtyMlcrZWN0THU0TTBQekliTFdoaVhKcEZa?=
 =?utf-8?B?K1h3NzYwRUN0RGltWFk1cjJqUmh6ZUFxdGxqY29mK2pwM3pobmtjczF5d2Q4?=
 =?utf-8?B?b1E4WE9lRlhWallyZlFZQUFuWVRSWWlpVUJwQ1hueGJWa3M1c1Zya2lxWjFr?=
 =?utf-8?B?WWpZcG9vb0ZmVWNQNVJQVFYxYitaWWlSZmRFQ3JaazZpMjFnN0tlTXRvRC83?=
 =?utf-8?B?aVVwSnZxVDFiYXVMK1F3blVXeHVTQWVUckxYVHNFdFgxZm94Yll5RURwdUtL?=
 =?utf-8?B?a2xaN3dsS054dTU4OWJXb2c2a1l6NklrWEE1aXRSYWsyS3RoU2lwcHRodzFE?=
 =?utf-8?B?QzVCeFFvczhDeGxhay9hVXNIV2lWbjhQQXV0ZllWRTNxeW1ha09GN3QxajNy?=
 =?utf-8?B?a3ZoNm8rdGJqOWphNWlhcEVyRm92YkhJd0xjYkpZMkxWSW1HWWYzWjF4MDVH?=
 =?utf-8?B?bnhsM0RPdktLdzBVNlI0aWQzRWt5THFZSVYxN1dXU3k4cW9yS1Z6NHdXZVdk?=
 =?utf-8?B?NkdTQmNRSzhkOXkzTW9KdGRCMVVGamEyM29GM1NwN1FGc1MyeE9jR04zNHFW?=
 =?utf-8?B?QmtFcEV3aWhuSWpYdUljVnU5SEFXOVZackh6Z3hXcUc0ZzRTR2wyVHBUcGVm?=
 =?utf-8?B?dU5LaExGK1MzbjB4WHh6VnBXTUQwcGdrS2huemptMnJiV2c4Q2xyeENuMW00?=
 =?utf-8?B?Ukx6OUJxdUt0My9uSzNhR3U5a2I3WjhRYnNiRk9nSFN0b1JVZ3dwQ1MreVdP?=
 =?utf-8?B?b2lVUm4rS0VmTFpPbW9YbUQxUEFuTTNxdUc0Yk9aZCtNcUx2RFFTK0hzNDI2?=
 =?utf-8?B?dlJkUEdQVHkwRzNsc01yZE5CVlV0d0JFRk5GcjlPM2RUOElBeHMyRWppVGFI?=
 =?utf-8?B?K0FCVUkxMUpaN1lVRU1xTS8xV01MY3Yvbyt1WC9wak9mY0g3MWxURjVueklP?=
 =?utf-8?B?ZVVJbzBPQmVLellNRGFhakNrNHNmT1d0dmloVnlvN24vRWlUQ1d5VGVhUk9I?=
 =?utf-8?B?amYxY2JQY0NrUHdxMG1nem42dVNYNTBLb1VHemk4ZDFZV0pnS1B4TlRJdk1t?=
 =?utf-8?B?dmpzT0NwQ0lWNU9BRVdIVGRDMXJmbzNPTTB2MWhGZnNjbFl6TVIyMUE5QVFr?=
 =?utf-8?B?eGorZFFkUzg3TEx0T1FHd0pVM0NwSTVmSnRwbjdRdStkWFZqekRoNjd4bmc5?=
 =?utf-8?B?VlNJbEZEdS9MdUZpUXpwc3hUWjJwZmVqOGdBOE5mMFpkVGlwSWExN3JDckUz?=
 =?utf-8?B?VFZjKzNIV2RLVVh2U0l1SFZxUjJrTHc1cVVBTFF1M3ZmM1ZhWHE1VTRUWU91?=
 =?utf-8?B?c1VNaXp6R2hzWUFJZHhHQXM4K3I5TC83a2pQMm5xZFN3ZDlFU2p6VFp4TWVu?=
 =?utf-8?B?L09SeFo4SFJGb0lrSWh3bVo5bU11MTQ1NjZoY3NmZkZXNGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5ESlVzK3Z5ajQ3K0ZuQjFpb0dqTnk2ZFA1MTM4aWNpcGJ5ekVTUk91ankv?=
 =?utf-8?B?SGJTcTU4MXovbHp0bHA5cTBxZ0tNZTNjd3ViaWVjQ2pxbmllZFJ0VHRFeHJY?=
 =?utf-8?B?dGx2UFQrRmJPeU13dkhrRmw1OHlQUFI2SkVOeHZxQkpaUWRnUFB6MDFuRGZt?=
 =?utf-8?B?U284akpBY0paeHh4dXhicUhXWm9TZVpPSG5RSzdDUk1hTmhlY3M1Nlk0U2dB?=
 =?utf-8?B?akM1K1d2d2VEdkkxK1B4aklwWGc4RFdTVnlGTGlhQ1ZZRTVXWjZ0R1l3VzVm?=
 =?utf-8?B?aktFRFBGM01sWXF3V1RBVkR0aHQwV0dRc2lRZ2pQTS9ZUUpUb2JhY3l2ZFYv?=
 =?utf-8?B?SVZPS21MTEtVOUtuNmUwejUzaThudjZvdmszaEpqdGFJY3prb3BERDFTY1Nr?=
 =?utf-8?B?WHdzNWExdmxWaEhvZlJoc21iZ3pJdVJJY1RyNi92UkRFZndKRWNSclBJSWdq?=
 =?utf-8?B?N0ppeDU5OGw4WWtiT0U5Sm1uUC9LL2x0UGtERnVqK3ZZdWZJRUozUzBPTWFY?=
 =?utf-8?B?dUQ0bzArck5hbmxtK09BVmFMNXVjWGgyZGY2b00vRys0Z0ZmdlF3Yy9mcGxu?=
 =?utf-8?B?aS80VVB2UFV4SkF2L2JrM29LL0RrcGpUeDRQT0Q3VXVWd3c5NWZSRnc1Z2ky?=
 =?utf-8?B?MWg4cnlLTENMY0J0ZytJMEVJNm4zSkpVN3hKZVROMEFVZzdQaSsrejFidGwr?=
 =?utf-8?B?cVVyVXJYUnFLT3pHVGdzKzV0VEVPZ1c5djlKMkhSSGNkakZFdmRsc1JtUFdF?=
 =?utf-8?B?bW8wYVZ6TW5wYWRERTVZajNQRWdLdW85cXFFT2k0azZYLzZUaVJwd0lwSzJa?=
 =?utf-8?B?Q3M5THBOaXkvZWRLNWVycHBIYTlkdnltRkFjNnFDU0VtcmZGNHhtMjE5Y0tQ?=
 =?utf-8?B?SnZqVERDU015dzN3RklUWE5jMEhGVElkeDl2TjlybFlUckNkOC94L3ZGWElN?=
 =?utf-8?B?aWpmdnFzeVk2TTdBQ01IRU1VeXl2VzhIYy9xUUY3czdKbjBIa1hDa2xVNjdH?=
 =?utf-8?B?bWNUeGZkYXMreGZoNFZyVElOd2lwdlRNN01UbU9tdHFlMmhJUGpqZGgrT2RY?=
 =?utf-8?B?WnppSVh6Sldoby9SUWR0NXJsVndiRXBKQ2dqbXdtUU0wZlBwK3ZYU1lNdHFo?=
 =?utf-8?B?RzlFQU52NE1Uaml6R1dTY2pMKytFK0RzSkZ2MWJsd0FIamQyaXlhaDZPeXZu?=
 =?utf-8?B?clhBWnVrWm9IcGhWNVloQlBzK1Awb2FweW9wL3BnZ0NzbmxMeVh4cjRsY2I5?=
 =?utf-8?B?d0RsbFk3V2ZXTkxXZzJzZzlzTHBpenZqNFpNTldIRHZlOTdzcDdhRUFtRmZu?=
 =?utf-8?B?cHR5dUY1ZWFvbHdzMEJxR3RsS1MvbWdXV0ZzOUxoNC9IemZOV2xvcytNMXUw?=
 =?utf-8?B?VDdSajA0UkxGK0R3Mi85OE5FVzNjM2FBWGp2Z282aDlkK3RWT09VaC9GQ0FB?=
 =?utf-8?B?SkVJZEx4M0VJQkd1cHBtWW5kZk5zWXQrRU8yZDM0NjBsOWVwanZYKzcydU1H?=
 =?utf-8?B?OXh3V1BqQXJwWlZQSTJUYnFISitodVhHcVdLL2VPbW9RZnVoaFQ0UzlxeFNM?=
 =?utf-8?B?SDR6ZjU0dnRpRnowZXBQamt0RVppQkFsdzBJZkRON1RTMENTUlJjSVh1K2Rz?=
 =?utf-8?B?TEJISHJhNHVaZEhCblBQRnRFdFA0TUplUjA4aElNSG9NMGdGNXpVWVFtYUFM?=
 =?utf-8?B?dDFoa055YnlieldFVFZ2VEp0Qlpla0xMYi9WVmlaQ2FQRmYrWmpYdjN2anN5?=
 =?utf-8?B?cm5qZUFSS3R1aFpkUUE0ZUI3T0JVcVZrRnUxb3pkY2JLWFFJSU9JTGpEUkUw?=
 =?utf-8?B?VnZNeEEvd3lRMXY4dzUvM3lEOFdLVDMyZ09OQlN4WVdid0c1VHNDdFNRVzVt?=
 =?utf-8?B?UDk2dTIrTlBLVmE4WCs3MzVXVFFnak1BSHU0VmJwVTBycUp1V3R0MGNUVTVy?=
 =?utf-8?B?NDhOKzFzRzFiQklvQlJSUmVXVFpIQXRGRmhNRlZNYVN4MjZ3T3E4NU9zamU5?=
 =?utf-8?B?M241NE1ycy8vVUFRZTZkZy9XbWliQitDMGllQWVtQWlmVEdjRURwRXl1MWlX?=
 =?utf-8?B?SHFydFZKQ3l5OVp0ck43WmZNdDE0TUZsNGNzakV0QzRJdUN3K0R0WkJ5WUov?=
 =?utf-8?Q?1LrM5TdCPbBqMylGcA4ln5C46?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00de0fe-c8d4-4b1f-6373-08ddae72b80d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:16:29.6813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1nAF6fBJ/GlI95sZLVbOQ2DbPkwDTJguKunDqtcUBSb7HAFAzwZ5PDbLTMiPGvIgPWqCczB5akdpdLHlXxmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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



On 6/18/2025 1:05 PM, Sundararaju, Sathishkumar wrote:
>
>
> On 6/18/2025 1:44 AM, Alex Deucher wrote:
>> On Tue, Jun 17, 2025 at 4:02 PM Sundararaju, Sathishkumar
>> <sasundar@amd.com> wrote:
>>> Hi Alex,
>>>
>>> On 6/17/2025 8:38 AM, Alex Deucher wrote:
>>>> Use the new helpers to handle engine resets for VCN.
>>>>
>>>> Untested.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>> index 9fb0d53805892..ec4d2ab75fc4d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>> @@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct 
>>>> amdgpu_vcn_inst *vinst,
>>>>                                 enum amd_powergating_state state);
>>>>    static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>>>                                   struct dpg_pause_state *new_state);
>>>> +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
>>>>
>>>>    static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
>>>>    static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>>>> @@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct 
>>>> amdgpu_ip_block *ip_block)
>>>>
>>>>                if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>>                        adev->vcn.inst[i].pause_dpg_mode = 
>>>> vcn_v3_0_pause_dpg_mode;
>>>> +             adev->vcn.inst[i].reset = vcn_v3_0_reset;
>>>>        }
>>>>
>>>>        if (amdgpu_sriov_vf(adev)) {
>>>> @@ -1869,6 +1871,7 @@ static const struct amdgpu_ring_funcs 
>>>> vcn_v3_0_dec_sw_ring_vm_funcs = {
>>>>        .emit_wreg = vcn_dec_sw_ring_emit_wreg,
>>>>        .emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
>>>>        .emit_reg_write_reg_wait = 
>>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>> +     .reset = amdgpu_vcn_ring_reset,
>>> You probably wanted to add reset callback to vcn_v3_0_enc_ring_vm_funcs
>>> instead ofvcn_v3_0_dec_sw_ring_vm_funcs.
>> I'll fix that up.
>>
>>> With that, the vcn and jpeg changes in this series are :-
>>>
>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> You mentioned that the start/stop sequence didn't work for some chips.
>> What sequence should I use for those?
> It is for vcn3 and vcn2 (non unified), I am testing on vcn3.
> Your changes as it is, works for encode hang, but failed to reset 
> decode hang on vcn3.
> The workaround is (works for both dec and enc on vcn3) :-
>
> vcn_v3_0_stop(vinst);
> vcn_v3_0_enable_clock_gating(vinst);
> vcn_v3_0_enable_static_power_gating(vinst);
> vcn_v3_0_start(vinst);
>
> If you are okay to add the workaround, that would be good, until we 
> have the firmware
> also handle this properly or clarify the requirements to reset the 
> rings, even without it
> it's a good first iteration to start, leave it your decision to add 
> this or not.
>
> Have also requested for a vcn2 machine from Lab, which I think will 
> get by EOD,
> I am hoping this works on vcn2 as well, since they are similar, will 
> keep you updated of the result.

Got a vcn2 machine to test, reset isn't working even with the workaround 
on vcn2,
nothing looks consistent w.r.t vcn non unified queues reset functionality.

But having it enabled as it is in V9 will help in debug and work with 
firmware team on this.

Regards,
Sathish
>
> Regards,
> Sathish
>>
>> Alex
>>
>>> Test exceptions: VCN/JPEG 4_0_3 and VCN/JPEG 5_0_1.
>>>
>>> Regards,
>>> Sathish
>>>
>>>>    };
>>>>
>>>>    static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
>>>> @@ -2033,6 +2036,7 @@ static const struct amdgpu_ring_funcs 
>>>> vcn_v3_0_dec_ring_vm_funcs = {
>>>>        .emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
>>>>        .emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
>>>>        .emit_reg_write_reg_wait = 
>>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>>> +     .reset = amdgpu_vcn_ring_reset,
>>>>    };
>>>>
>>>>    /**
>>>> @@ -2164,6 +2168,26 @@ static void 
>>>> vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>>>>        }
>>>>    }
>>>>
>>>> +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
>>>> +{
>>>> +     int i, r;
>>>> +
>>>> +     vcn_v3_0_stop(vinst);
>>>> +     vcn_v3_0_start(vinst);
>>>> +     r = amdgpu_ring_test_ring(&vinst->ring_dec);
>>>> +     if (r)
>>>> +             return r;
>>>> +     for (i = 0; i < vinst->num_enc_rings; i++) {
>>>> +             r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
>>>> +             if (r)
>>>> +                     return r;
>>>> +     }
>>>> + amdgpu_fence_driver_force_completion(&vinst->ring_dec);
>>>> +     for (i = 0; i < vinst->num_enc_rings; i++)
>>>> + amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
>>>> +     return 0;
>>>> +}
>>>> +
>>>>    static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>>>    {
>>>>        struct amdgpu_device *adev = ip_block->adev;
>

