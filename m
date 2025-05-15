Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E03C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 17:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A6710E92B;
	Thu, 15 May 2025 17:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3V5fna5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06C710E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 17:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRsj/1Adt6egoORaolzwy/Vtj8oM2QNnLahyUj2eVjfbgPG/bcG54Ff24/C4W2UClbrV1cW0+X1ZT3uub0716qQXt3jEqxdgoCC1jCqrb8rK9Ae3vM8SOgPQ9s6LK9JwPSuoTGvoKUEx2IDHKfmmDphNJBCII5DMwho6hC1dRCJpamHzDXkXMh0Q4ZndGlXDyeOn+9Us4UmjIc9PHQfIh0d+EvKeyRh+WxmtzenbhEB+9H4xQu17nLxhFP4ZF1cPj+AE1FA4m6FYlJqbwuCqjr0J0lj6y9HMmBKYNjbSzyjyEsBFGvod1yE+wMNfQ2jMR/rIMBHeERqmumbRQfiuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOilxxkMKuqpwNKYQ4RZWhTuYmb4TCsa+2InuItbOfA=;
 b=JpKSFwGBIyfdU8skDy2RiX/n2TEgw4DGl18/oy9niOTnHOcR54y9266lf/IgHwqZhZ0mudTYilZCrXldocIEYtbkmLw8YqvPjLACDdT5UShkiDUAj5UqB12fcB2tJNVftRJwomFzOITV2xOsIIQIVzEEbI/QFasdVFmN8LA9HdC146EwxhLEHpYhuUuY1rO4Y9oesIkk3ygqWIXr7vcHdA2IV7u7Cj3jENWs1GktXhqqwZMgdHeSjiD9WWq2pZhiTqGNnhI7bB7NEw/YRQdnTsOuJNUu2yJTYEUHM553h3spiiaVWEaH7m2KMSxtBKKjnBsTsAKhVTZQLA93RgDlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOilxxkMKuqpwNKYQ4RZWhTuYmb4TCsa+2InuItbOfA=;
 b=u3V5fna5N7tiTf2rDIOWcPhABjfwS4SxK49qEabhmIj+DphzR+lhQPWlNV7niaeK6JmAlPI9GzPe3UTbo24JDDEf6PbyZGPH12eYmbLuSP3/0gzDDwusuJjgo+0T4LHGCQ2gd/LhnSO9rAKgzqH6J9M4LALj9WASWis3laL6MjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Thu, 15 May 2025 17:47:06 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 17:47:05 +0000
Message-ID: <6088b764-cf5b-4c21-be95-4695730456e3@amd.com>
Date: Thu, 15 May 2025 13:47:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250514213721.519943-1-pratap.nirujogi@amd.com>
 <f2d33475-53e8-43ec-9095-95081e480989@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <f2d33475-53e8-43ec-9095-95081e480989@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::8) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3da9f1-aa6f-44e0-b7e7-08dd93d881bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWd1V2phNXAxSDd3NUh3L3lJY2hIZEthZ2QxdEFaVldNNnJNNFJ6bVdLdGI2?=
 =?utf-8?B?bWtmQkFJZGJlRkVTWnFUUzNhcXUzYTRGOHlCRFYwcGVtZ2JHaTUxUkhTdkkr?=
 =?utf-8?B?RXhFKzNuZ2VuSXpXUHVkZkRoNjAySWQwWFNlUVBJNDhoSjlMMGJiVTVxMWVk?=
 =?utf-8?B?cHZSYXE4Sk0zK3JHd2pRVTJFUTdMMlYxeGI4WEJoRzZnWlY1Sjg3RFE5SklC?=
 =?utf-8?B?S3RKaEIvczVjU05ua2VwTUVKUUlRemt4Y0VHYTliVzJFeXo3c1ZRWGVYSVFB?=
 =?utf-8?B?bVYxeGJHd0w5UDBwZCtBY3VXWEZ5eDZLbTdTQUY4alBRMWFSZm0vS3B5cGd4?=
 =?utf-8?B?Mmpsa3hpZkorTnU2TU5tQnpqYm9yTHNvbTVZalZiaXV5cFpkSE1sdWlCbjRy?=
 =?utf-8?B?YmcvT0tJL1phc0JjeGhHWFNSNG5sYWh1VW1oR3EzZjdRaWxjZVI1NDJ4YXor?=
 =?utf-8?B?MW1CQWwwcDZESlVNMmMxZ1hhYXE2bkRIMVJsampIVHkyamVZc012RzIvM2lO?=
 =?utf-8?B?OGxuNHV5ZTg4SWM5VkdDYnBDeUQ0ODRzc3EzbjZySDYxbmhZelJmckFIRDVR?=
 =?utf-8?B?U1pjT3VpdGFDVldlbWNOMWkxcTlyQWcrUWNzZFQ5eHV3QVJBSFZ3TkxoQlRh?=
 =?utf-8?B?MnordHJiVzkrUWt1V0o5L1pwL3JDZTl3WDZGSWM2bndIRTVDZUJvL0VlRkRT?=
 =?utf-8?B?Y3dXS2QzMUlraGwvcUFZMGg1Z1Bram85b1kxVFJRcWRFNVhpTlBJdTFpQmZ5?=
 =?utf-8?B?Vm4vdFFrY1ZzcGczb2VqTCtMaTlmcGVqTWhyWEQzY3MyalVvNG5uWE5PdU5Z?=
 =?utf-8?B?QmRUSWlaWlhDWlpBK0cxc2JrZVE4RHZGbkdsaVc3eGpLSm9iOExSRERQNDZR?=
 =?utf-8?B?ekI0T1l5VXIrZ254cFhYVmJsL2doVjcvVjNHMndIZ2orNXZFZVJXcWkvZWg0?=
 =?utf-8?B?bFJCcDNIU3g5UlNDcW4wZytkaktnVmgyTk1jS3o2M3pKR0Z0RFVDcUFPcWNS?=
 =?utf-8?B?L210YWN2cmxRQVFaUW8vdk1USGNJR2pNTUpqMVJjSjVPWjVmRVcreHBtcWxL?=
 =?utf-8?B?MFpEbTREOVEwbmV6cEprZXplc3FvWGx4b0xaTVIxWnQ1SkpuYS8rK3hVUGVQ?=
 =?utf-8?B?V2taMVcrK3grY1J6YXBNZVVUbEVQN25YUU5CS3B1V0FwK1c0T1Y1UFk2S0Jq?=
 =?utf-8?B?a1cydHZqQVN1OVJHYnJsQ1lxZDhSb09NUWpSMkE0UTNNTjdUT0loRmhCYjJ2?=
 =?utf-8?B?UExUdXMrZGxHUEJZUnpFbkRId2ZoYVJOMmdjUnJFb0ZrQTloczdIUzlTc3pU?=
 =?utf-8?B?dVhOTXdTSGFUR0pyT0FHOElJME5FVEFTcWlwUy9tTWdxa29YdHJneTRJaVBI?=
 =?utf-8?B?Rm1hdmFxbUlrUzVCK0tRa0lMWVM5SjVQcXNnTnBGRVYrNjVSQVNubGp4QXpj?=
 =?utf-8?B?ejRrdXM4Q1IyL3phQU9ocm5SZjY4Y29HdUJaMjdRNWpiWEVwenl6RUNnYStZ?=
 =?utf-8?B?VkRFTWVBWUZoa1BtU1hFZTJsWVlEVVJRRTlqYmoyRnVkWEVZVEhOak1HT0E5?=
 =?utf-8?B?UGQxOHdsRHNmVk5aUFZhU2Z2L0xPRnBlbWRDcEdLOTlkR1Q0NmEwVmpiSlRQ?=
 =?utf-8?B?UjEyWTYySHV5TTNLWmFMdUx0Vm5qU3lpcjdneVNleXZxQlJuS3NNNXRZM2Vn?=
 =?utf-8?B?czNMWmpNbEpaTXkwd0VXRWZhazZrWTVpc2N6MkJTU0phZFc4aHBCVDdIM0Iv?=
 =?utf-8?B?TlBLWWlqOEhRTWF4a1NnbWRZeE56S3IzT3dSUEdVSFdUYXpyM3RBaEtiamhS?=
 =?utf-8?B?dkp3bVhVckNrYUtjNzYvOVRpbWExMHcxdG9hRSsxb050OWNBK0IyZ1V0c1JH?=
 =?utf-8?B?cXo4SFNVd3VnODlvdnQwR3NTeHhETEFoM3AzV2dKbThDVHAwNExQdlhMdTNO?=
 =?utf-8?Q?oU+TkpQ03VA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBvL2JKeFZmR2Z1aTZ0KzJUNWlvcXF6OW5pdzUrZW1XaCthVi9vQUxOenUv?=
 =?utf-8?B?VnFJcWh5Z0R2U04xZ0ZCdDhGZUFnVkt6UjkvNG9ZdnB3ZEFWcVJsYkhya2cv?=
 =?utf-8?B?ak11YzhUcVByS1NKT2V1b3hJV3gzTUdUblQzbVpZV2FKTW1vbWpmOUR1eUxr?=
 =?utf-8?B?ODFuWW9wdUh3cm5pMkZQa2Z6UngySXM3Yk1QZGQxUGoyeG54MzZTRG05VFZj?=
 =?utf-8?B?cHExYXF3WS9HZUFCZGdnSHZndDhxMGJhZGRBeTNFQVpvQzEzZzVUQjhCdTNW?=
 =?utf-8?B?L1BWMjc4aTBndnh4SmViRDBndlBKeCsweUtJR1phOEg4eEorb0dTVzhtcllu?=
 =?utf-8?B?NE1WNEUzeklaMitCSUIzRUdLcmJQWVk3QWVVV1BnWTV2WEVOcHZrNEp2MTk3?=
 =?utf-8?B?YmUvdDllTTUyMHlKTGhMNHR3T2FsaVJUSDZScXlCV1Y5TWR2dHZvc2NHVmk4?=
 =?utf-8?B?ZklrekFZelhMOUkvaVM4MVQ1dWE3K0Nzb29JNE5lQWhxRVlqT3VlTFZiNFVs?=
 =?utf-8?B?YWlTVUlSNFlxRlFIMitaWTc0VFhWeUVGNmdpY3ZYclAyeEMzMXg2a1p6WUN5?=
 =?utf-8?B?cXh4aEg2eklsYnJWWWhRa0ZwY1k4RmVYaDY4cHR2SnkzQmpoeUxpd3Bzb0du?=
 =?utf-8?B?R3N1Ymp5cnErQmljSDR5NVdhNm9qbVpwNU1VbWZIMm0rRUJFdjJKczQvQWxY?=
 =?utf-8?B?eGF2TkJUQXEybGpHdXBMaTh5amtDRFZmbDlSRVNYWHF6UjV2NGxndUFkNnRx?=
 =?utf-8?B?V1NuQUpQeTd1ZzNaME52elppZ2p0U2dscTY1aFJaKy8wUEdrNG10dXcrOTdm?=
 =?utf-8?B?R1RJVmNTUVZTRis5azBvNVdPQUJYbTdlSjVvdk9uMUlWc1ZYaFB5anNEcXFF?=
 =?utf-8?B?Sjcrdy80a3ZUUnpqNFhMTDNrMDRQOHpFeWJKTUxKeTJURWhtZ0RVeG0vVjVW?=
 =?utf-8?B?TnkvZHozQjFCUTFOTk5ZdldGZ1VsSzU2VlFHQzNxa1dhV1N4TjlVanpyWHdS?=
 =?utf-8?B?bHNQRmtCZVduWlNWcDJ2eFhQaHVNVSs3SURLRHRaUVFRSFVWb0JranAwS1do?=
 =?utf-8?B?ZDY2VDRaWFJ3MGZlLzlzMTA3RW1uU1RscnNnRDN6cVFsUWVCdXhwZ1dNRnpV?=
 =?utf-8?B?bWdRbmhzakp0akFnRFpCRWREVjVoU2xqSkdZY0poOUFwWUFxZ3N4WTRrVGRV?=
 =?utf-8?B?WERoSFRndVZMRU5UNmduRlB3SE5Rc2Fsemk2RUV0Q25Hb0RpYnFZZXBrY3Qy?=
 =?utf-8?B?M09vQ0FralNDQU40M1pVVVUwNnljQTRxbWR1bENoUk9nSUZ5dmZxUW9DU1Fa?=
 =?utf-8?B?MDF3Q3d1czY4NWV5TEszdDBkTHh1bDZQUDNNT3ZENHRkUnQ3NDV4QlJ4UGRT?=
 =?utf-8?B?MFZLRndCTUdES3RGN3B0SkRxTEp4MWFoNUY5U2JQcUtkcENFSHpGV2F3eWpJ?=
 =?utf-8?B?ZElCZ1lPSWZDaEdVNjN5RXFTbVo0SThSOEVwVkdvVDZ6U3ZkcWd2Zm9jNlhE?=
 =?utf-8?B?TEtOdmdXMG1NY2RZLzdCQWpGQ3JVQ1ZpTEkrZ3dYQWUvRXBVTjFrNy9VdExj?=
 =?utf-8?B?S0tmN0FHWjc4Z09nV0x0Y3l3K3o1Zk04NGxTWCsrYVZuKzRuSXRqaWppRmlG?=
 =?utf-8?B?V3BaS04rNjdPUWNYVXBONnVzV0RkZUxyYlMrdXJWZmZsUXhock9QNDJiOHYr?=
 =?utf-8?B?QXd1dFlwMzlJME1wend1QXpDU21VRTJGNWgxK093bk10bm54cnphUmluMFdQ?=
 =?utf-8?B?UGp5Nml1TnI0TEM0bDRWeCtzMGpXQ3dxa0lMU0k1U3ZGdDl1RXVmLy9kY0FG?=
 =?utf-8?B?cVpYTk15QlVCam1GanI4M2pCbjlXMkkzZDZ2enJzanlmb3ExcGNEaTZwMEQ5?=
 =?utf-8?B?SWNqYldKUWdoSXFpbjh3Y2ovRzBaNFEyYllXeWJDUXo4QXhJUHVuVGViRVpr?=
 =?utf-8?B?VUxaSFNubXlKb3BYTnhUcHpobUY4eVhMZVVJY0NEMXdEcUdsTEg3R1d0bnF5?=
 =?utf-8?B?L09OcnRVQkJ2N0ZmN09VVVFpYXlDYkF6dnBrYlFvd0Zad0dadE5qcCtRMFRm?=
 =?utf-8?B?Vlp6K2dzU0FtY1A5Qk1DRUp6bGVIQklPTitwam5yK3krdnJiYWtySHFHZXNB?=
 =?utf-8?Q?zDbwKFuBX1pF6rkFpjeL/DnqC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3da9f1-aa6f-44e0-b7e7-08dd93d881bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:47:05.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYQpRqBNw45y6af8UTAb+RhS5yDlPpF5JmglXUazjCo3L3Wpx7g/Ge8foLu46to/S7lWs3zfFyM9Stpn9OBnAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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

Hi Mario,

On 5/14/2025 6:05 PM, Mario Limonciello wrote:
> On 5/14/2025 4:35 PM, Pratap Nirujogi wrote:
>> ISP is a child device to GFX, and its device specific information
>> is not available in ACPI. Adding the 2 GPIO resources required for
>> ISP_v4_1_1 in amdgpu_isp driver.
>>
>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>> mode.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 46 +++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index 69dd92f6e86d..c488af6c8013 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -25,6 +25,7 @@
>>    *
>>    */
>> +#include <linux/gpio/machine.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>> @@ -39,15 +40,60 @@ static const unsigned int 
>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>   };
>> +static struct gpiod_lookup_table isp_gpio_table = {
>> +    .dev_id = "amd_isp_capture",
>> +    .table = {
>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>> +    .dev_id = "i2c-ov05c10",
>> +    .table = {
>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static const struct acpi_device_id isp_sensor_ids[] = {
>> +    { "OMNI5C10" },
>> +    { }
>> +};
>> +
>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>> *data)
>> +{
>> +    return acpi_match_device(data, dev) ? 1 : 0;
>> +}
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       struct amdgpu_device *adev = isp->adev;
>> +    struct acpi_device *acpi_pdev;
>>       int idx, int_idx, num_res, r;
>> +    struct device *pdev;
>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>> +                   isp_match_acpi_device_ids);
>> +    if (!pdev) {
>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected:%ld",
>> +            PTR_ERR(pdev));
>> +        /* allow GPU init to progress */
>> +        return 0;
>> +    }
>> +    acpi_pdev = ACPI_COMPANION(pdev);
>> +
>> +    /* add GPIO resources required for OMNI5C10 sensor */
>> +    if (!strcmp("OMNI5C10", acpi_device_hid(acpi_pdev))) {
>> +        gpiod_add_lookup_table(&isp_gpio_table);
>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>> +    }
>> +    put_device(pdev);
>> +
> 
> Can you please move this into a helper in amdgpu_acpi.c?  We try not to 
> have ACPI code outside of there in case someone compiles without 
> CONFIG_ACPI.
> 
> Sorry I should have mentioned this sooner.
> 
sure, I will add "int amdgpu_acpi_get_isp4_dev_hid(char **hid)", which 
takes care of:

1. finding the matching isp4 platform device(pdev) using bus_find_device()
2. gets acpi device handle(acpi_pdev) for the matching pdev and returns 
valid hid incase of no failures.

Is this approach okay? hope this function signature makes sense. Please 
let me know if any comments or suggestions on this approach.

Thanks,
Pratap

>>       isp_base = adev->rmmio_base;
>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
> 

