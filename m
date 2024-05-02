Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8257FC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 14:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1593110E8DF;
	Thu,  2 May 2024 14:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWy1XbAx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E5910E8DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 14:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFH7trg/nknI9lOSXKzO5eQ0k5vmr6CgU8Rblc8zejWO+8fBdlAOfFq/h2sx2wHJ/1QS+9cxEHaYF+jUVuUopynEeBhZGQoEfXlWFxXL7K3JlyBLoCyfu4W8nSLkrLvM1lHe4BZi/MrfuL0ncx0NHlNM8GDtSuq5bHdeqmf7t5F4skJQNslqjBd9RmxHl+jh//ZzxN709n9NlaqlGRWdnx/shmKNSW3cOYL3a2jyYGMn0M0GOknuuUV1hwjkR0n4Ok/CUFQuNi2YYcUJ+Osw5E/N28yC05Q8z2/CBz08HKOcELLK3W3p1HuZA6K4FcOA1aeISO/mSLjPC7ptRxibVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmZOop/rRtQu5tvmISkBDxiGFlvUJBP1NFjEVHs5YbI=;
 b=eOrssAJuzgwUOjl84e2wxmIke0jtHeYTXJU/DTPtuEtGKR7UAexTlegSDVlW/fSxfbpunyYkzDEnFgbPg3PrKr7hkQn9+whMhjvuauFLQ3cGOo/IzypLIGV2vFiHGjsvA25ebxMTa8pJeDHGqzpiQ0R4B//5idPviYHLa4fOqOuQQMH8Yvu6EJ5/dSOmU4U0DV/FzE9S47wxhqa/VXKGuUgSRknuhK5FOPqrVkbCc+UGPFYbbbpxbWpBKX8nYvyOcK1ZdrI0mhhy+EAUo2dwgmMv2bvv00a07iN4tPmwL5RF4G8f/3mj3votFDXos2K+LYorUg/rTdOPuCPYvxdOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmZOop/rRtQu5tvmISkBDxiGFlvUJBP1NFjEVHs5YbI=;
 b=vWy1XbAxvjcCugrP27n0kjp3H8mE5NqMCQQloESxkKyfq0fECvL6BzuuiqUaVO21HLwSvYQRVJp5LGEBRxHtSSmxEaUtw1D9NpYX3T01yXZ9jZwEpAOgy29xMBHNtEGLS73C8+BQPfN1etkENqSU3fJKR4Y6B+SGckGbCIQnrMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 14:02:05 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 14:02:05 +0000
Message-ID: <7277c714-828b-d7b6-d771-6cd9bda604ee@amd.com>
Date: Thu, 2 May 2024 16:01:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 12/14] drm/amdgpu: enable SDMA usermode queues
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-13-shashank.sharma@amd.com>
 <CADnq5_OKanvT1co22rxHEjBc_4RJwN4Ss5VrZ4Btx_bDFh0F2Q@mail.gmail.com>
 <3d61136d-9fe6-4c97-63fb-024face67b93@amd.com>
 <CADnq5_NT7zspQFCTX=jJJX99Q6W_gGxMsvcjkCXM52CEyMmp4w@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_NT7zspQFCTX=jJJX99Q6W_gGxMsvcjkCXM52CEyMmp4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a5093e-02fb-4b87-dfcd-08dc6ab072d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG9aZllKMzhodkJEOFpnVjdpY0NPYlFNb3lSSmdVK0R6OEhsYWwzdWJFek1W?=
 =?utf-8?B?Y3BMTDBHTUZ5TVF4ekRBcHNhNHVYSjgxT2NrekpVeng2ZmhJRjBkTGxlTGtZ?=
 =?utf-8?B?aWVndUMrM1hBdFhZeUE3VFQ1ZVduSEY2TTc2SjRMbWZRM3picUYyUEtuQ0JI?=
 =?utf-8?B?clRsZ1FHQU5PcEtvU1RYYjhxbmJweGNaK2djUXFhcjY4aVo4MlpXbFRmQTZq?=
 =?utf-8?B?cjRFYnVBRk9TSW9ZV1h4VUVOV1h5cE80MTU5OVBpR1huaDMvYTZQVHgxNEpM?=
 =?utf-8?B?b0xzZVBDQmRoZ1NYMndCYXdxbDIrZHJCUXpYaDJoZ0ppRTlnN2ZKN21kMGpO?=
 =?utf-8?B?TFZzRVR1Y1dzYmw0ZzVQRmdRQUY4MWxqeTNGV040eFlKY2ZYQ3hLTXF2M05q?=
 =?utf-8?B?OWF0NWc2clBKU3ZsZ3YvVGM5U3VnODk1dmoxWjBrZGw1aHRQM256K3AzcWYz?=
 =?utf-8?B?cnhCZDhKREN2b2MvRmpDdkFaakk3S0ZYNWdGTDI3eGZZNXRQUHF5R2pac0p5?=
 =?utf-8?B?bTU4bHJ2Q0d6MWl4YmIvSnVtNG1DSTJCZzVGMDRJeEdPeHNYeGl1MlR1OE5j?=
 =?utf-8?B?ZnRFZUc5VFFHbVZJRzFwaGM0VUJyRWd1TjlUdXZHR092TzBoeFY2U1E2Uk9R?=
 =?utf-8?B?aGNISTB5Ui9hMnY1NHpFMUhDckVOcW1iTEZtdlFHWlUwd1k4WlVNSFJURU5O?=
 =?utf-8?B?VDVrQ0ovSmhZZkZZOGtpZ1R4dHJlM0tycklnWDRKMkV5cXY4NjR6TzFud1BE?=
 =?utf-8?B?WGZtUW1jVEY0UVZ6WUJFdXJ0emIyc2FrK0g2K3F0azRXTkVTT0plN1pRNU92?=
 =?utf-8?B?ckVsd1JOS1pIR3NQY0dxZDVKZlJVMmlrTk1MTTdoMlRlUis0bWtyRnlObXZP?=
 =?utf-8?B?a1JEdFh0T0ZHanljUkRXYXpTbUtZVERMeTBOYXRVY1hjT1cvYWhIWmE1a25H?=
 =?utf-8?B?bGFoS1ZibWlVRFVpK3dTVmJMYjlZUzh1b3pmYmxKM2Q0NmF6OGp0YnZUSURX?=
 =?utf-8?B?Q1psR1ZvRmREaFZDNXE5RGdyVC8xOGxTc283bGRnMzgvREZ3NjVnYTlWMHYr?=
 =?utf-8?B?VU1kbGczQXBrRjNSdEtMU1YrUDdxVVkxTWZvRE5leDhWdFo5a2ZCeGpqcDFr?=
 =?utf-8?B?OGRHWkpHcnoyY0N2UzFzcGUxT0ZCTGRrQWt6d2Ewb0RYZHNpZzJoZjY5RVIz?=
 =?utf-8?B?a1JRd2dzdVBqZFRxVldLOWRleGdHZDcrd3Z1bjJPZzlueUNMK0lDVjYyVGtz?=
 =?utf-8?B?NU45SDE5WkUxVUlSZFpyL1pvSE96U0UrMFFjMGIwY282WW16VGhaZUcxZ1Zy?=
 =?utf-8?B?cUxHNTdVMC80RHZ3M1oxQ1hkd1l0UlJvYmNFcmw4SzZvU1lnODlJRUZrN09M?=
 =?utf-8?B?TEIxa3NlN2NVMUQvUWVJTmNqajl4cjBuS1ZJeHlJN2ppTlJCaEJpNWlHR3lZ?=
 =?utf-8?B?UEhTN3R2NVI4S2phWHdPNThVNzJ2Um5GTmxhZHdIeEUvMHlvSU1aSEFMWlFn?=
 =?utf-8?B?TjYzdG1rbTVjL3RHL0srby9pSldwR0xwL3cxUDYybVFob1B6ekJoWk4wRkk0?=
 =?utf-8?B?blU2QTZKTTBNZlBRKzRYcFh2blJVK0xUZ3NKQktZS1EzTWNpYkJJOWJpZHFG?=
 =?utf-8?B?VHdDV1VKNnJEWHVQR2xjSDVkcUdFL1FRZU90L2ZzUzNLakRoeDZZVERWUmNj?=
 =?utf-8?B?bGk3VXlsTTI4ZHcwa0hMbm5CcnFyRzhkUFVVYjgwTWhzT2dyTHFMcUx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRKWEYrRUV5WHlySHdHNUJiQzF1UjVQeXdwa1QyREkwUVlZdUJZa3dsc3No?=
 =?utf-8?B?QzRTOGdoZDBXZmJoZTVoNEF1UFBmTWk3U25YT0tZSlVwRDVsZHQwb2taWlVP?=
 =?utf-8?B?SVFvYjh2OUZ6MHY5RlBFV2cwaGpxRkE0L3phZTBSR2IzZmtDZVhmOFhnTmlM?=
 =?utf-8?B?NDBGb3NvQmo4dWw1THlMUXVWNnM4ZDlEVHpEWWxqS3VMKzJHU053RUhFM3Zi?=
 =?utf-8?B?QVFCNHlvbTVOYkhzbmNOMXYzYVFkU0JPMWxFalQ1bEhIUjg5M0R5QWxnVGI0?=
 =?utf-8?B?TVFSdjVQM3ZFRnZEQnpOcEN3QUdVb21YdHdBS2E4RHdZZjNjY2xDOUYvV05h?=
 =?utf-8?B?UG9xM1ZwUXNsWTlVdURwUXJOSmREaE8wNndQL1VCVU1odnZsblQ4cndvRXVC?=
 =?utf-8?B?UHJyZ09xL25leTBET3ZJMHFmamNLamRqZlg5ZWViMTY2SXYxYUU2WWVCVFRm?=
 =?utf-8?B?MnRlb2xSVEtyRVl3WlVCMW9rSjFEVjg5N1dPMm9hUGpMNTkrbnJnaEcrNmVu?=
 =?utf-8?B?VEpnWDJQV3I4RlcxSjNEZXlYV3lyUDhnU0hNcGU1UnQ2QWpmRkhCSXlRMkZ6?=
 =?utf-8?B?SDYvSktjaHlFWkhtdnpjb0c5SElLcmVTN0ltU1FXUmhhY2pId1ZsSkMydzNl?=
 =?utf-8?B?YmdnVG1lMm1DdjR3d09iM3hPakZ4TUxLc1huY1NveHhLWVNadDBycm9GUDZa?=
 =?utf-8?B?OE9TU1AyWm0xcG9mTklVUjhJOTBRb2RDSWRlekozMG0zaVRBWTI4M1JxMFdC?=
 =?utf-8?B?Zm1Ra2dHUHdqVXF2L0ltbkZKWldFSFNXSExiVWh2RFdibEwydUJqdFpNNkVE?=
 =?utf-8?B?V2N3Qkt2RFBzOGM2WUEybnY1Z1FXYjhDWTRxVmdkL2UwL2pzV2c3azRFNDRL?=
 =?utf-8?B?TWRTckp6SjhDK1JIaHRZcTMzQ0ZVcG9HVlMwc1BsOHpMUVVVd1ZNYUZTZUFE?=
 =?utf-8?B?UmtuZ1h5am9rTGhKLzZYaVVmOHJaVHZFS2lTTG5WbHV6ZTNjUXR0SEFzZmpz?=
 =?utf-8?B?OElpUUtCcE5OQk9XTGZEUXM1Z21OUUJmQ0E1QU9NWmRtcVZjZ1lzeHdhKzhz?=
 =?utf-8?B?ZFRHeEJUekJvMVM4TlBvRFRoK3hMT01qQ29JNmZ1K3BVWGlsT1NQMWUwR3pv?=
 =?utf-8?B?WTF2UldYR1E4WFBSN3ZOc1JCSVZGZkVSSFhtNVV6RXRxUnk2VnE1bFV0U1Vs?=
 =?utf-8?B?bWw2RHdDSmxub1kxaG1RUE01QUg0NTJUbVpMR3VOWTJqRERvUitIMTZ2VTNv?=
 =?utf-8?B?N3dSTXhJTE4rNGtJa2Y5ZU9kMUlzcDZCU3c4WWgweDRYalJyM0dLSDFvS20w?=
 =?utf-8?B?SG1EWTlmbTYvR2FZdFRRWEJ1VER5czRhNWpBWnhFWnNBTmd6S3RKYXV4aGVO?=
 =?utf-8?B?eXhwK0VmZ1M5N09SSWYxOS8rMHdtWTJOK3ZTUjJqWmN3dzhLSTY4VUV4OGlT?=
 =?utf-8?B?UFRhdVpoVEdQWURzaTV0Z2ltVGRIOTR5b1NSdSs4OVgxVlNZVHN6Wk9RdmV4?=
 =?utf-8?B?bjh6Rm5rOU91SnlYeVNvd1NiQ0Vvc1FBZjhwOEN0bFFnVUpSekVTK3Y5dk41?=
 =?utf-8?B?c0RmclpSMjg5WGowSEV0UTJmcFBBYU5ESDBoU2ZvU3hkeE1ObU9iUGs4UWF6?=
 =?utf-8?B?SG1SdmpTbDI5a0JmZmY2bXpZWHVxWnlMQTVMOFlqV3VRNDZES1Bua0FWaUJZ?=
 =?utf-8?B?QjJtSGsxZm4zM1ZIRkZjbEtXVk03RHczSldaQ01RV0hJb0VhWWt2V1dVUGlR?=
 =?utf-8?B?UDdFWi9mSVFXNHNiK1BUejMwcDc4QVNSaW1sQXcyZ0FicmhXRHoyUWF2KzFO?=
 =?utf-8?B?S1RPeUxxcnc0SnhRWmFWTWIyTjM1b3E3b1luY1ViVjVCVFFLRGxEaVdURmpQ?=
 =?utf-8?B?d3J4dFUyL3E1RTZUSERzVGJDdEJNWEx2UXJSQXUrNWVwcVA5c0c5U3hUcTZY?=
 =?utf-8?B?Ly83ZzQ5RTNjeEJyUWxZOU0zSFI4OHMyb1A3V0toWkhTaXhNS1QvZDZEUXJv?=
 =?utf-8?B?UXlIVGJoVDdqRmxoQitPc0ZLYkpRVzBFdTREYUdZb0x3YUtRVXN1VEtienBM?=
 =?utf-8?B?VDh0ei9VRUlBQnU4R1EyajdvMFR6S3B2T1ZQUWdCSUhtMWMyNG00VWZiWnFM?=
 =?utf-8?Q?PddWyZXD8zs0RFsL5IvSZs+7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a5093e-02fb-4b87-dfcd-08dc6ab072d9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:02:05.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb8Vj0n5inex8XQ5jO0lOnAFL0YWVg56NS92QdH5U4aLpUfV+iukQUWbVPguyRVqVMmyK5Al0lxLJyKQEj4GJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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


On 02/05/2024 15:55, Alex Deucher wrote:
> On Thu, May 2, 2024 at 1:47 AM Sharma, Shashank <shashank.sharma@amd.com> wrote:
>>
>> On 01/05/2024 22:41, Alex Deucher wrote:
>>> On Fri, Apr 26, 2024 at 10:27 AM Shashank Sharma
>>> <shashank.sharma@amd.com> wrote:
>>>> This patch does necessary modifications to enable the SDMA
>>>> usermode queues using the existing userqueue infrastructure.
>>>>
>>>> V9: introduced this patch in the series
>>>>
>>>> Cc: Christian König <Christian.Koenig@amd.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 +++
>>>>    3 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index 781283753804..e516487e8db9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>           int qid, r = 0;
>>>>
>>>>           /* Usermode queues are only supported for GFX/SDMA engines as of now */
>>>> -       if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
>>>> +       if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
>>>>                   DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>>>>                   return -EINVAL;
>>>>           }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>>> index a6c3037d2d1f..a5e270eda37b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>>> @@ -182,6 +182,10 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>                   return r;
>>>>           }
>>>>
>>>> +       /* We don't need to set other FW objects for SDMA queues */
>>>> +       if (queue->queue_type == AMDGPU_HW_IP_DMA)
>>>> +               return 0;
>>>> +
>>>>           /* Shadow and GDS objects come directly from userspace */
>>>>           mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
>>>>           mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>> index 361835a61f2e..90354a70c807 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>> @@ -1225,6 +1225,8 @@ static int sdma_v6_0_early_init(void *handle)
>>>>           return 0;
>>>>    }
>>>>
>>>> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
>>> Can you include the header rather than adding an extern?
>> Noted,
>>>> +
>>>>    static int sdma_v6_0_sw_init(void *handle)
>>>>    {
>>>>           struct amdgpu_ring *ring;
>>>> @@ -1265,6 +1267,7 @@ static int sdma_v6_0_sw_init(void *handle)
>>>>                   return -EINVAL;
>>>>           }
>>>>
>>>> +       adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>>>>           return r;
>>>>    }
>>> I think we need a new mqd descriptor in amdgpu_drm.h as well since the
>>> sdma metadata is different from gfx and compute.
>> Can you please elaborate on this ? AFAIK SDMA queue doesn't need any
>> specific metadata objects (like GFX).
> Right.  I want to make it clear in the IOCTL interface what buffers
> are required for which ring types.  E.g., UMD might allocate a shadow
> buffer for SDMA, but they don't need it so there is no need to
> allocate it.  If we have separate mqd structures for every ring type,
> it makes it clear which additional buffers are needed for which ring
> types.

Agree, it makes sense.

- Shashank

> Alex
>
>> - Shashank
>>
>>> Alex
>>>
>>>> --
>>>> 2.43.2
>>>>
