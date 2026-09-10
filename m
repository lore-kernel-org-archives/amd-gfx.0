Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C51C79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 08:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DE310F374;
	Thu, 10 Sep 2026 08:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRMVqPUZ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8169210F374
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 08:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehsdVwTkVR6M+MJcISm8CU3IM0Vfg5ljDmOVjV2XLFaLywAaKr17YuIcqexZM5NM7su544cSBdyDsodNGongeTrxce9GOWXuasZ4N+hH+LFW6BxqEwtu87Japd94ZEyX97Di2VGTW4MtCYgbJn70EmzYMgB3ZC2H6rfh5u3dQ+6Bzhi/yDX5ankyzOQ/x8RJVokfYYVOjtmmAtz5ZWgWJZDiIsdbxmEykFIlf5LHEowNikP7X3sYP2WSkgDJE1HxPVN4jQt4g/v7t/9S8mmidpTFz9V70I+6tKHMqRJSyDCZvxZ3sxMSpWC4tWosZjdHkdKN1nANWGIbSJIhmYYBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQiFAvGHU5MtaSRWL8nwwcMw7Y83xGKMeDtf/giVoR0=;
 b=sbSdkbOIvVctRpFiVMO1ZVJSnGEhRlSEOjw6Dh9OGDZWYoO4Fdmt6ojNKoJnlG0Uc0+F2+iVYYesKT30EyHPPZwi9ms0T/5RGIhEKkRS2/IYY4j6IYUnR2/v1yaqIYW0qXRtrb34eh7zPw7r7e/rAYDQE7ymmD7cQcffhiVsRCS3ffQStVlMgqUwyBm++ypuoOyHYR3JUaRwvU+QzggBh74Nb9dZ6d/xl9HvUGlPahYEnrQlZx+7pxQPIToUkwD5/8Zsxz/s1PNpVBoknNCXHngh+jDlvwDnksIJq0pSHkoBxy+Gc9fsrakHTQyQnHrKI8dZjztK457/JzqlcbYN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQiFAvGHU5MtaSRWL8nwwcMw7Y83xGKMeDtf/giVoR0=;
 b=FRMVqPUZHsVeO751jDZDHbpU9X3yt64HbPmam13JbPjpu4sbXSO1tfA9hhFLVgNjT3a0Qyn94mvOlgafvlhtu02H53rxRL1bArUtBgry3j0A94k5piwFtFGFQDCfJld+wPfbATypb3bl8sAnBkfKOV3SfO+lgxBatwpvxUiPdWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Thu, 10 Sep
 2026 08:25:21 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 08:25:21 +0000
Content-Type: multipart/alternative;
 boundary="------------GrM3bt0fVKx67BEdj4kIWob2"
Message-ID: <3aeba017-08b7-4554-9c71-e031c42e8a21@amd.com>
Date: Thu, 10 Sep 2026 13:55:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <CADnq5_PHEQzUVTqJYzO3mALs9LfK9cAUMQtgi0JEzGvFSZk7Eg@mail.gmail.com>
 <CADnq5_M+tLHSrfXQCxX2+LFq-x8OO1=BG+ou=qq2_Y0VS+b8AA@mail.gmail.com>
 <8573edf1-9af4-423d-8af8-08ac38f33ab2@amd.com>
 <61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com>
X-ClientProxiedBy: MA5PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::10) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bab9b6c-942d-449e-9b80-08df0f150d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|4143699003|3023799007|56012099006|11063799006|8096899003|10067099003;
X-Microsoft-Antispam-Message-Info: 99PuhnTkGdCnYdo+XNMQ1R2SLBgdTQCGidR+SWvU+ykBECNUPxBUiGXlU0MwYpZlUA+a6K7iu5RpRgIWkp9AAl1UgOzo768zmqRr68HFyHk+WdHyoHneNwHvF1KfQrReoNDWsMwKIJsk7Fa9yqPr7Bmuc3wLXFtXKO0pXi351IQF0TjpaiyRpn9iJE47Ktd6PAkR029A261s+T5DsnLNZpQ8sc8nubjJtammRxpQpxCwKa6TpT6v+hVI/acNkwwKl2xbVDRPgRqnxWZbY+mTBPl1fkWMBDr/Q0oFhScgknhwFBGBdWVc20Pgybj6/b5lC9s7aM5ykK7rw5e9RLtBz/VG8LniLGZLeV+930b4xwXbODeYeLrNpeBI+lD/NQOmWsdcFDzurm8dRAIhTAbZN8MquUQsl4U4cXJCkqP2WJneJrAprHDQxQr6vVSB+OdOGAS7Rxu7sWjzGwa9h4VJqKc42XYGQPPI83qxbj4p/TIklzW8puTVHexIgiT0XnhdiXeJw19pqpoS+JpyLv7DMf596nsehv5yWNt0q41BLSeVKIAlnnPEVNKOJWm2MrPNXDlgN5jlbya1t3ucsIJYT+YnjlKWcCbqn5ahJvt1bW0PyCW6nNXAnpu3wROxYoJGYD20AdjRXyqq4/JhoZlZC85084dD1fb4yd0Ofl/96NQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(3023799007)(56012099006)(11063799006)(8096899003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNJbFVYanRvSitzVlZMNlVFVUw5NDJJUTdFb3hsT0ZXVk5MTklzMEN4dHBn?=
 =?utf-8?B?eEdiUUtBenVlN0FkaFBNbGw5ckZxajN2Q1lkYmhWYlh2WlRRSlFiSE5OVTl5?=
 =?utf-8?B?VEVQTzFibS9jbDRTK1FjUm5WY0VpdGdpcFFqZzI0bXg5OHhLMHdBWjFrdkJS?=
 =?utf-8?B?c1ZIS1dQOEhGK3ozWTFzNllZVlVtdDF1Z0RZbVF1ZkUweDJDcEpnQ0IxRkNp?=
 =?utf-8?B?aVlCQXhDeDBEc1ZNRWpwNm1GdGFtbEJmYXpRWVU1NGpERUIreXErbU9qUi9z?=
 =?utf-8?B?b25QbENBU1R5dXV4ZkxzVHVGa3FaR0NrbHR1ejFOZ2xFRU9kcTducVpJbHJv?=
 =?utf-8?B?Q1cvcnVEZlBDYWxSdUFKLzFYdlNZT25RdmhHNGNVZWxobTJKTFBzUFpkOHFJ?=
 =?utf-8?B?QnJDSUpCUVgvQVNEVTNxeWJUbnF2WkxSY013MDhkYmYwM0tscnBpRnY2dGk3?=
 =?utf-8?B?bVNCbktWVUViN2hVTUF0ckw2SllxQ25SNVhkYWpEVDdWVjZYd3lmVE0xZzhp?=
 =?utf-8?B?bXVQVitZMGo3aWxsWGg4Z3FUTG9wVkc1N0lveTVLSFhzZkVKenNrNEI3THhn?=
 =?utf-8?B?RTlBQm9aWGwxbTh3UVg4bnJMQWROVGFXTkdXd04wYVI1RmJKWG9RWDlNUzVh?=
 =?utf-8?B?b0lKRjhyemt4YjkxOVBWVk91aEhHRFdkNHM1Ly9zdjBmOFo3UEdFdEJIb0Fv?=
 =?utf-8?B?YzU4blhmT2pOOFFISWdLS0dRNGczTkJlQ24xVlhVN3FaOFU0a1JmK2w3OWpL?=
 =?utf-8?B?VjlzeU15SlRDTG9qYllpLy8wNExJa0pRUHY5cFZsalhjYXozcGQ1SXdEVzVU?=
 =?utf-8?B?bHFoZnhKb1hCVUpnblNibksxbjFwWjM4SGl5R2R0empjZ2R4RDM2YjllOE16?=
 =?utf-8?B?aCt2dTZsSkVyV21SRERzaVh3c2grbHJiWm03eGVwKzRrZ2lBbWo2eG9LWlN3?=
 =?utf-8?B?Q01sOXdzajZRUndQb0FKQXpCMm16UTNIYXN1blhmTHFVTVl1dmZPd2JVNUh5?=
 =?utf-8?B?cVhtMmJvNmw4TkR4ek85ek82QjNjRC9tMU9oQVNRSHh0M3VJbS9KUVp3enEv?=
 =?utf-8?B?NGpJSG03NHc1OHZMa0hDUk1qZmlna1JsbWt6RmVyYURlbTNPaTlyNUR3VTA3?=
 =?utf-8?B?ditMNGFqY2RPYzJpenpGdzRhUmdCYjRMMUE3VCtibjlHOUEvZ293SGZWcGNk?=
 =?utf-8?B?dXZFNmtjZFRHWndFejZqZlhaY0hMbE5vWVZxVGxUdFkwMk1OL3BXRm9BbUpv?=
 =?utf-8?B?VDRacnhLMVJuaWFVdDB5Nmo0OFFESjJrSEx1T0UrY0REa0JBNFk4U2NHQUhp?=
 =?utf-8?B?MlA1UWVBS241Z1VrSVlVbVc0ci9uWjZmcmk4OXZtcmdIMGV2c0dHMFQ5di9O?=
 =?utf-8?B?cUhZNlFpQlVEbnJEbWNDNWl4MlFjSUo5OVRid01UbHAyWDVHVWxzblZERTE4?=
 =?utf-8?B?YTY3Y1U2Wkd3VDVDQ0o2Zkg2RXhrRllFMGh6RVhadXUvNythODJRaDE0NkVs?=
 =?utf-8?B?RFp0c0VqQTlaUHVnQVpRWmdWb1pIQ256UjI0VlQxMjJFWFNnWVAwM0pLY1Z5?=
 =?utf-8?B?aVU3NUdyd3NseU1KN3ljUW13UGswNzk1d0VKUUlsa0Fza3pTN1p2ZEtxQ0xM?=
 =?utf-8?B?VXhaUUZUckJVRDY0V1FwektyWjVWZXEranBJd25DUjg5RE9MaFRtb0h4REYr?=
 =?utf-8?B?OFZMYUtIOGcxME9ncmZwbHNPREJHeHFMYUh3Tm1LZDJuV3dKQ1hmMWtJTmll?=
 =?utf-8?B?ZkVVblhjdnhodkRPcXFnMWtkS3FBNVB5NHN6K1kyOTMvbWFxZjhGN3V2eW96?=
 =?utf-8?B?OVJyZkJlUytFUFFpcy81TytLN3dIcTJvWmZwc2ZlLysvb0NlVGR5OVY1QnNS?=
 =?utf-8?B?UVhrVUI2aHVJTnczYi8yWXEybzcxdXJMTGVzL3gzK2o1cDJOWkhWYmlUclBP?=
 =?utf-8?B?OEloK2k4cytWUVVQUzY4ZXJyQ1Bjc0phUjV5MmZzb1pkbUxWdURZNVg3UkZ6?=
 =?utf-8?B?anM3REM3MDZlb0FVZ1dXR0JXSmh5VVhTUW1CMDZzK2hta0I2MVNUU2lMbmhK?=
 =?utf-8?B?N3NpS2F4bXd4V1BvU0dVUVBJZE8xOHV0MzR1a0Z6Y1E3K0VOaFM2cDhESjlr?=
 =?utf-8?B?SkpTZnVoZmQrdTJNcGd1ZURaNkxaOXJ1Ky9JMmI5U3FkL2VUTEkvWUxibXdu?=
 =?utf-8?B?bThHUFd4YjBTWnUrUnlCdVptb3ZIcFA2eW1TUDFzWmZVb0EvOFgyYklYdC9z?=
 =?utf-8?B?Smw2UXYvTng1am9FWUR4M0FFSW1oVEVJUG5qOEo5QzRHVnlzYWlWdk5adTZK?=
 =?utf-8?Q?IKYucT1SiYaQ01pTmP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bab9b6c-942d-449e-9b80-08df0f150d8e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:25:21.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INXe90r9Y/1rqZdfmEIjLMN0NBxbNY+EE89p9yyzyuGDknIdw68ZW5mn2ydHY/Prc6Y5yoAfw6N5XtZWOrgvqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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

--------------GrM3bt0fVKx67BEdj4kIWob2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/10/2026 12:27 PM, Lazar, Lijo wrote:
>
>
> On 10-Sep-26 11:43 AM, SRINIVASAN SHANMUGAM wrote:
>>
>> On 9/10/2026 2:20 AM, Alex Deucher wrote:
>>> On Wed, Sep 9, 2026 at 4:42 PM Alex Deucher<alexdeucher@gmail.com> 
>>> wrote:
>>>> On Sat, Sep 5, 2026 at 4:55 AM Srinivasan Shanmugam
>>>> <srinivasan.shanmugam@amd.com> wrote:
>>>>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not 
>>>>> program
>>>>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>>>>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler 
>>>>> state.
>>>>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>>>>> registers via SRBM select for KFD queues but no equivalent exists for
>>>>> driver-managed kernel queue VMIDs.
>>>>>
>>>>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub 
>>>>> version
>>>>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>>>>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>>>>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own 
>>>>> kq_tma_bo
>>>>> there, so per-VM isolation is handled entirely by page tables without
>>>>> needing to reprogram the register per job or per submission.
>>>>>
>>>>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>>>>> (parallel to page table allocation) and mapped read-only into the 
>>>>> GPU VM
>>>>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the 
>>>>> second-level
>>>>> handler address into it via kq_tma_map when userspace calls 
>>>>> SET_L2_TRAP.
>>>>> The first-level CWSR handler reads this address to chain to the
>>>>> second-level handler when a shader exception fires.
>>>>>
>>>>> This design is:
>>>>>    - Per-VM BO (not device-level) — same model as page tables
>>>>>    - Fixed VA in each VM's address space — same VA, different 
>>>>> physical BO
>>>>>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>>>>>    - Treat allocation/free lifecycle identical to page tables
>>>>>
>>>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>>>> Suggested-by: Alexander Deucher<alexander.deucher@amd.com>
>>>>> Cc: Lijo Lazar<lijo.lazar@amd.com>
>>>>> Cc: Timur Kristóf<timur.kristof@gmail.com>
>>>>> Cc: Samuel Pitoiset<hakzsam@gmail.com>
>>>>> Cc: Natalie Vock<natalie.vock@gmx.de>
>>>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>>>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 
>>>>> ++++++++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>>>>   5 files changed, 110 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> index 3ca187f5ade8..5624a5ab5c62 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>>>>          void (*print_l2_protection_fault_status)(struct 
>>>>> amdgpu_device *adev,
>>>>>                                                   uint32_t status);
>>>>>          uint32_t (*get_invalidate_req)(unsigned int vmid, 
>>>>> uint32_t flush_type);
>>>>> +       void (*program_kernel_trap_vmids)(struct amdgpu_device 
>>>>> *adev);
>>>>>   };
>>>>>
>>>>>   struct amdgpu_vmhub {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>> index 623cac6781be..e913488ca3fa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>>>>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>>>>
>>>>>          amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>>>>          adev->trap_info = no_free_ptr(trap_info);
>>>>> +       amdgpu_trap_program_kernel_vmids(adev);
>>>>>
>>>>>          return 0;
>>>>>   }
>>>>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device 
>>>>> *adev)
>>>>>          adev->trap_info = NULL;
>>>>>   }
>>>>>
>>>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>>>>> +{
>>>>> +       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>>>> +
>>>>> +       if (!amdgpu_trap_is_enabled(adev))
>>>>> +               return;
>>>>> +       if (!hub->vmhub_funcs || 
>>>>> !hub->vmhub_funcs->program_kernel_trap_vmids)
>>>>> +               return;
>>>>> +
>>>>> + hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>>>>> +}
>>>>> +
>>>>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>>> +                               struct amdgpu_vm *vm)
>>>>> +{
>>>>> +       void *cpu_addr;
>>>>> +       uint64_t va;
>>>>> +       int r;
>>>>> +
>>>>> + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> +
>>>>> +       r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, 
>>>>> PAGE_SIZE,
>>>>> +                                   AMDGPU_GEM_DOMAIN_GTT, 
>>>>> &vm->kq_tma_bo,
>>>>> +                                   NULL, &cpu_addr);
>>>>> +       if (r)
>>>>> +               return r;
>>>>> +
>>>>> +       if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>>> + iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>>>>> +                                         (void __iomem *)cpu_addr);
>>>>> +       else
>>>>> + iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>>>>> +
>>>>> +       vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>>>>> +       if (!vm->kq_tma_va) {
>>>>> +               r = -ENOMEM;
>>>>> +               goto err_free_bo;
>>>>> +       }
>>>>> +
>>>>> +       va = AMDGPU_VA_RESERVED_TRAP_START(adev) & 
>>>>> AMDGPU_GMC_HOLE_MASK;
>>>>> +       r = amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
>>>>> +                            AMDGPU_GPU_PAGE_SIZE,
>>>>> +                            AMDGPU_VM_PAGE_READABLE);
>>>>> +       if (r)
>>>>> +               goto err_del_va;
>>>>> +
>>>>> +       r = amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
>>>>> +       if (r)
>>>>> +               goto err_del_va;
>>>>> +
>>>>> +       return 0;
>>>>> +
>>>>> +err_del_va:
>>>>> +       amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>>>> +       vm->kq_tma_va = NULL;
>>>>> +err_free_bo:
>>>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>>>> +       return r;
>>>>> +}
>>>>> +
>>>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>>>> +                               struct amdgpu_vm *vm)
>>>>> +{
>>>>> +       uint64_t va;
>>>>> +
>>>>> +       if (!vm->kq_tma_bo)
>>>>> +               return;
>>>>> +
>>>>> + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> +
>>>>> +       if (vm->kq_tma_va) {
>>>>> +               va = AMDGPU_VA_RESERVED_TRAP_START(adev) & 
>>>>> AMDGPU_GMC_HOLE_MASK;
>>>>> +               amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
>>>>> +               amdgpu_vm_bo_del(adev, vm->kq_tma_va);
>>>>> +               vm->kq_tma_va = NULL;
>>>>> +       }
>>>>> +       amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
>>>>> +}
>>>>> +
>>>>>   static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>>>>>                                    struct amdgpu_vm *vm,
>>>>>                                    struct amdgpu_trap_obj *cwsr,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>>> index 7f83174a4742..9be5035abd1c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
>>>>> @@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct 
>>>>> amdgpu_device *adev,
>>>>>                                      struct amdgpu_trap_obj 
>>>>> *cwsr_obj,
>>>>>                                      bool enabled);
>>>>>
>>>>> +/* Kernel queue trap handler — per-VM TMA and register 
>>>>> programming */
>>>>> +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
>>>>> +int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>>>>> +                                struct amdgpu_vm *vm);
>>>>> +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
>>>>> +                               struct amdgpu_vm *vm);
>>>>> +
>>>>>   #endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index de3ef9ce2234..f5e228d4bfb5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm,
>>>>>          if (r)
>>>>>                  goto error_free_root;
>>>>>
>>>>> +       if (amdgpu_trap_is_enabled(adev)) {
>>>>> +               r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
>>>>> +               if (r)
>>>>> +                       goto error_free_root;
>>>>> +       }
>>>>> +
>>>>>          r = amdgpu_vm_create_task_info(vm);
>>>>>          if (r)
>>>>>                  dev_dbg(adev->dev, "Failed to create task info 
>>>>> for VM\n");
>>>>> @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm)
>>>>>                  amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>>>>>          }
>>>>>
>>>>> +       if (vm->kq_tma_bo)
>>>>> +               amdgpu_trap_vm_kq_tma_free(adev, vm);
>>>>> +
>>>>>          amdgpu_vm_pt_free_root(adev, vm);
>>>>>          amdgpu_bo_unreserve(root);
>>>>>          amdgpu_bo_unref(&root);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index dd825e179979..064f95a83790 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -25,6 +25,7 @@
>>>>>   #define __AMDGPU_VM_H__
>>>>>
>>>>>   #include <linux/idr.h>
>>>>> +#include <linux/iosys-map.h>
>>>>>   #include <linux/kfifo.h>
>>>>>   #include <linux/rbtree.h>
>>>>>   #include <drm/gpu_scheduler.h>
>>>>> @@ -488,6 +489,18 @@ struct amdgpu_vm {
>>>>>
>>>>>          /* cached fault info */
>>>>>          struct amdgpu_vm_fault_info fault_info;
>>>>> +
>>>>> +       /*
>>>>> +        * Per-VM kernel queue first-level TMA BO.
>>>>> +        * Allocated at VM init, freed at VM fini — same lifecycle 
>>>>> as page tables.
>>>>> +        * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in 
>>>>> the GPU VM.
>>>>> +        * SQ_SHADER_TMA for all kernel VMIDs points to this fixed 
>>>>> VA; per-VM
>>>>> +        * isolation is via page tables mapping different physical 
>>>>> BOs there.
>>>>> +        * CPU kernel writes second-level handler address via 
>>>>> kq_tma_map.
>>>>> +        */
>>>>> +       struct amdgpu_bo        *kq_tma_bo;
>>>>> +       struct amdgpu_bo_va     *kq_tma_va;
>>>>> +       struct iosys_map         kq_tma_map;
>>>> These should be the same for both user and kernel queues. The only
>>>> difference is who manages the vmids (driver vs MES).  They are per
>>>> vmid so it doesn't matter whether it's a kernel queue or user queue.
>>>>
>>> I would merge these patch sets.  The trap handling is the same for
>>> both kernel queues and user queues.  The only difference for kernel
>>> queues is that the driver has to set the TBA/TMA registers while
>>> MES/KIQ handles it for user queues.  At vm_init time, allocate the
>>> memory for the trap handler, copy the trap handler to the memory and
>>> add the mapping to the GPUVM address space.  Then in gfxhub init,
>>> program the TBA/TMA registers for the kernel managed vmids. Finally,
>>> add the IOCTL to set/clear the second level trap handler and validate
>>> the user supplied GPU VA.
>>
>> Hi Alex,
>>
>> Thank you for the review. I have few questions before proceeding with 
>> the implementation.
>>
>> I looked at how KFD handles this today in |kfd_process.c|:
>>
>> /* KFD writes second-level TBA/TMA into first-level TMA */
>> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>>               uint64_t, tba_addr);
>> iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
>>               uint64_t, tma_addr);
>>
>> Where |KFD_CWSR_TMA_OFFSET = AMDGPU_GPU_PAGE_SIZE + 2048 = 0x1800|. 
>> KFD uses physical GPU addresses for TBA/TMA registers, not VM virtual 
>> addresses.
>>
>
> KFD doesn't use physical adddress, it uses the below fixed virtual 
> address.
>
> pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev)
>
> KFD mechanism is to allocate one BO which is mapped to the above 
> virtual address. That BO accounts for both TMA and TBA size. TMA is 
> located at KFD_CWSR_TMA_OFFSET within that BO.
>
> TBA region carries the first level handler code. It's not allowed to 
> be overridden by user. Hence when we moved to new design, TBA is kept 
> common for all user VMs.
>
> TMA BO is the place through where user's second level TMA/TBA 
> addresses are passed and also the place where stack is saved.
>
>                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>                              uint64_t, tba_addr);
>                 iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + 
> sizeof(uint64_t),
>                              uint64_t, tma_addr);
>
> What this code does is to write the second level handler tba/tma 
> addresses in the TMA, which is located at KFD_CWSR_TMA_OFFSET within 
> the BO.
>
>
> TMA region is the only variable thing per VM. First level handler code 
> executed is the same for all VMs. So in the new design, we have a 
> first level TBA BO that is shared by all VMs, and that carries first 
> level trap handler code. The second level TBA is allocated per VM.
>
> I see Alex is saying the same thing which I asked through a different 
> thread. There is no need to allocate separate BOs for kernel queues. 
> All you need to do is program the fixed TBA/TMA first level virtual 
> addresses for non-KFD VMs during init.
>
> Regarding kernel queue draining - my understanding is that the 
> condition is no work having that VMID is in progress during the 
> change. So, it may not be required to entirely drain kernel queue.
>
> Thanks,
> Lijo
>
I would like to take a moment to summarize what has been agreed upon and 
share my thoughts on the remaining open points, to ensure we are all 
aligned.

*What is agreed:*

 1. Fixed VA = |AMDGPU_VA_RESERVED_TRAP_START| — same as KFD
 2. TMA starts at offset |0x1800| from BO start — matching
    |KFD_CWSR_TMA_OFFSET|
 3. |SQ_SHADER_TBA/TMA| registers programmed in gfxhub init — kernel
    VMIDs only
 4. UQ and KQ series merged into one — no separate |kq_tba_bo|/|kq_tma_bo|
 5. |SET_L2_TRAP|: evict user queues, ensure no VMID work in progress,
    write TMA, flush TL

*Open Point 1 — Shared TBA or per-VM TBA copy?*

Alex said: /"copy the trap handler to the memory at vm_init"/ → sounds 
like per-VM copy.
Lijo said: /"TBA is kept common for all user VMs"/ → sounds like one 
shared BO.

IMO: The first-level handler code (ISA binary) is identical across all 
VMs for the same hardware. Based on this, one option is to keep a single 
shared device-level TBA BO (|adev->trap_info->isa_bo|) mapped into each 
VM at |AMDGPU_VA_RESERVED_TRAP_START|, and allocate only the TMA BO 
per-VM at |vm_init|. This avoids duplicating the same ISA binary N times 
in memory. Please let me know if a per-VM TBA copy is preferred instead.

*Open Point 2 — What happens to |AMDGPU_VA_RESERVED_TRAP_UQ_START|?*

After merging, |AMDGPU_VA_RESERVED_TRAP_START| covers both UQ and KQ in 
one buffer.

IMO*:* Remove |AMDGPU_VA_RESERVED_TRAP_UQ_START| from the reserved VA 
space entirely since it is no longer needed.

*Open Point 3 — When to set |TRAP_EN|?*

IMO*:* Set |TRAP_EN| at gfxhub init time. Since the per-VM TMA BO is 
always allocated at |vm_init| before any work is submitted, 
|AMDGPU_VA_RESERVED_TRAP_START| is always valid when any shader 
executes. No need to defer.

*Open Point 4 — How to ensure no VMID work is in progress?*

When |SET_L2_TRAP| is called, the TMA slots must be written only when no 
GPU work is actively executing under that VMID. One option is to use 
|amdgpu_vm_wait_idle()| before writing the TMA slots, which waits for 
all pending GPU work in the VM to complete. This is already used in the 
existing trap handler code for the same purpose. Please confirm if this 
is sufficient or if a different mechanism is needed.

Please confirm or correct any of the above

I would greatly appreciate it if anyone has a different perspective on 
any of the above or anything missing to be included or added  — so that 
the design is aligned with everyone.

Regards,

Srini

>> Question 1 — Which fixed GPU virtual address for the merged buffer?
>>
>> KFD uses physical addresses for the TBA/TMA registers. Our design 
>> maps the buffer into each VM at a fixed virtual address for page 
>> table isolation. Should the merged per-VM buffer use | 
>> AMDGPU_VA_RESERVED_TRAP_UQ_START| as the fixed VA? Or a different 
>> address?
>>
>> Question 2 — TMA offset inside the merged buffer — 0x1800 or 0x2000?
>>
>> KFD places the TMA section at offset |0x1800| from the TBA start (| 
>> KFD_CWSR_TMA_OFFSET|). The current UQ design uses offset |0x2000| (| 
>> AMDGPU_TRAP_TBA_MAX_SIZE|). After merging into one per-VM buffer, 
>> should TMA start at |0x1800| to match KFD's layout?
>>
>> Question 3 — When should TRAP_EN be set?
>>
>> When programming |SQ_SHADER_TBA_HI| for kernel VMIDs, should 
>> |TRAP_EN| be set only after the per-VM buffer is fully mapped? Or is 
>> it safe to set it at boot time since TMA slots start zeroed (meaning 
>> no second- level handler installed yet)?
>>
>> Question 4 — Drain kernel queues before writing second-level handler?
>>
>> When |SET_L2_TRAP| is called, user queues are evicted and TLB is 
>> flushed before writing. After the merge, kernel queue VMIDs also read 
>> from the same TMA. Should kernel queue work be drained as well before 
>> writing the second-level handler addresses?
>>
>> Thanks,
>> Srini
>>
>
--------------GrM3bt0fVKx67BEdj4kIWob2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/10/2026 12:27 PM, Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com">
      <br>
      <br>
      On 10-Sep-26 11:43 AM, SRINIVASAN SHANMUGAM wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 9/10/2026 2:20 AM, Alex Deucher wrote:
        <br>
        <blockquote type="cite">On Wed, Sep 9, 2026 at 4:42 PM Alex
          Deucher<a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a> wrote:
          <br>
          <blockquote type="cite">On Sat, Sep 5, 2026 at 4:55 AM
            Srinivasan Shanmugam
            <br>
            <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
            <br>
            <blockquote type="cite">MES owns kernel queue VMIDs
              (1..first_kfd_vmid-1) but does not program
              <br>
              SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps
              kernel queues
              <br>
              via ADD_QUEUE with map_legacy_kq=1 but does not set trap
              handler state.
              <br>
              On GFX10 and earlier HWS-based hardware, the driver
              programs trap
              <br>
              registers via SRBM select for KFD queues but no equivalent
              exists for
              <br>
              driver-managed kernel queue VMIDs.
              <br>
              <br>
              Add a vmhub callback program_kernel_trap_vmids() so each
              gfxhub version
              <br>
              can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA
              points to the
              <br>
              device-level CWSR ISA BO. The TMA is set to the fixed
              per-VM virtual
              <br>
              address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its
              own kq_tma_bo
              <br>
              there, so per-VM isolation is handled entirely by page
              tables without
              <br>
              needing to reprogram the register per job or per
              submission.
              <br>
              <br>
              The per-VM kq_tma_bo is a small GTT BO allocated at VM
              creation time
              <br>
              (parallel to page table allocation) and mapped read-only
              into the GPU VM
              <br>
              at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes
              the second-level
              <br>
              handler address into it via kq_tma_map when userspace
              calls SET_L2_TRAP.
              <br>
              The first-level CWSR handler reads this address to chain
              to the
              <br>
              second-level handler when a shader exception fires.
              <br>
              <br>
              This design is:
              <br>
              &nbsp;&nbsp; - Per-VM BO (not device-level) — same model as page
              tables
              <br>
              &nbsp;&nbsp; - Fixed VA in each VM's address space — same VA,
              different physical BO
              <br>
              &nbsp;&nbsp; - Read-only from GPU — kernel CPU updates it via CPU
              mapping
              <br>
              &nbsp;&nbsp; - Treat allocation/free lifecycle identical to page
              tables
              <br>
              <br>
              Suggested-by: Christian
              König<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
              <br>
              Suggested-by: Alexander
              Deucher<a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
              <br>
              Cc: Lijo Lazar<a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
              <br>
              Cc: Timur Kristóf<a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
              <br>
              Cc: Samuel Pitoiset<a class="moz-txt-link-rfc2396E" href="mailto:hakzsam@gmail.com">&lt;hakzsam@gmail.com&gt;</a>
              <br>
              Cc: Natalie Vock<a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>
              <br>
              Signed-off-by: Srinivasan
              Shanmugam<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
              <br>
              Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
              <br>
              ---
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp; |&nbsp; 1 +
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80
              ++++++++++++++++++++++++
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |&nbsp; 7 +++
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp; |&nbsp; 9 +++
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp; | 13 ++++
              <br>
              &nbsp; 5 files changed, 110 insertions(+)
              <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              index 3ca187f5ade8..5624a5ab5c62 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
              <br>
              @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*print_l2_protection_fault_status)(struct
              amdgpu_device *adev,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              status);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_invalidate_req)(unsigned int vmid,
              uint32_t flush_type);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*program_kernel_trap_vmids)(struct
              amdgpu_device *adev);
              <br>
              &nbsp; };
              <br>
              <br>
              &nbsp; struct amdgpu_vmhub {
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
              <br>
              index 623cac6781be..e913488ca3fa 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
              <br>
              @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct
              amdgpu_device *adev)
              <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_trap_cwsr_init_save_area_info(adev,
              trap_info);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;trap_info = no_free_ptr(trap_info);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_trap_program_kernel_vmids(adev);
              <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
              <br>
              &nbsp; }
              <br>
              @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct
              amdgpu_device *adev)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;trap_info = NULL;
              <br>
              &nbsp; }
              <br>
              <br>
              +void amdgpu_trap_program_kernel_vmids(struct
              amdgpu_device *adev)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =
              &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(0)];
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_trap_is_enabled(adev))
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hub-&gt;vmhub_funcs ||
              !hub-&gt;vmhub_funcs-&gt;program_kernel_trap_vmids)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              hub-&gt;vmhub_funcs-&gt;program_kernel_trap_vmids(adev);
              <br>
              +}
              <br>
              +
              <br>
              +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device
              *adev,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *cpu_addr;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t va;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_create_kernel(adev,
              AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,
              &amp;vm-&gt;kq_tma_bo,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, &amp;cpu_addr);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;kq_tma_bo-&gt;kmap.bo_kmap_type &amp;
              TTM_BO_MAP_IOMEM_MASK)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              iosys_map_set_vaddr_iomem(&amp;vm-&gt;kq_tma_map,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void __iomem
              *)cpu_addr);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              iosys_map_set_vaddr(&amp;vm-&gt;kq_tma_map, cpu_addr);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;kq_tma_va = amdgpu_vm_bo_add(adev, vm,
              vm-&gt;kq_tma_bo);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm-&gt;kq_tma_va) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_free_bo;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va = AMDGPU_VA_RESERVED_TRAP_START(adev) &amp;
              AMDGPU_GMC_HOLE_MASK;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_map(adev, vm-&gt;kq_tma_va, va,
              0,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GPU_PAGE_SIZE,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VM_PAGE_READABLE);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_del_va;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update(adev, vm-&gt;kq_tma_va,
              false);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_del_va;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
              <br>
              +
              <br>
              +err_del_va:
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_del(adev, vm-&gt;kq_tma_va);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;kq_tma_va = NULL;
              <br>
              +err_free_bo:
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;vm-&gt;kq_tma_bo, NULL,
              NULL);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
              <br>
              +}
              <br>
              +
              <br>
              +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device
              *adev,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t va;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm-&gt;kq_tma_bo)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              dma_resv_assert_held(vm-&gt;root.bo-&gt;tbo.base.resv);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;kq_tma_va) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va = AMDGPU_VA_RESERVED_TRAP_START(adev)
              &amp; AMDGPU_GMC_HOLE_MASK;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_unmap(adev, vm-&gt;kq_tma_va,
              va);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_del(adev, vm-&gt;kq_tma_va);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;kq_tma_va = NULL;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;vm-&gt;kq_tma_bo, NULL,
              NULL);
              <br>
              +}
              <br>
              +
              <br>
              &nbsp; static int amdgpu_trap_map_region(struct amdgpu_device
              *adev,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_trap_obj
              *cwsr,
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
              <br>
              index 7f83174a4742..9be5035abd1c 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
              <br>
              @@ -155,4 +155,11 @@ int
              amdgpu_trap_set_trap_debug_flag(struct amdgpu_device
              *adev,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
              amdgpu_trap_obj *cwsr_obj,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enabled);
              <br>
              <br>
              +/* Kernel queue trap handler — per-VM TMA and register
              programming */
              <br>
              +void amdgpu_trap_program_kernel_vmids(struct
              amdgpu_device *adev);
              <br>
              +int&nbsp; amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device
              *adev,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm);
              <br>
              +void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device
              *adev,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm);
              <br>
              +
              <br>
              &nbsp; #endif
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              <br>
              index de3ef9ce2234..f5e228d4bfb5 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              <br>
              @@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct
              amdgpu_device *adev, struct amdgpu_vm *vm,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_root;
              <br>
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_trap_is_enabled(adev)) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_root;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              +
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_create_task_info(vm);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Failed to create
              task info for VM\n&quot;);
              <br>
              @@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct
              amdgpu_device *adev, struct amdgpu_vm *vm)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping,
              NULL);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;kq_tma_bo)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_trap_vm_kq_tma_free(adev, vm);
              <br>
              +
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free_root(adev, vm);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(root);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;root);
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
              <br>
              index dd825e179979..064f95a83790 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
              <br>
              @@ -25,6 +25,7 @@
              <br>
              &nbsp; #define __AMDGPU_VM_H__
              <br>
              <br>
              &nbsp; #include &lt;linux/idr.h&gt;
              <br>
              +#include &lt;linux/iosys-map.h&gt;
              <br>
              &nbsp; #include &lt;linux/kfifo.h&gt;
              <br>
              &nbsp; #include &lt;linux/rbtree.h&gt;
              <br>
              &nbsp; #include &lt;drm/gpu_scheduler.h&gt;
              <br>
              @@ -488,6 +489,18 @@ struct amdgpu_vm {
              <br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cached fault info */
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_fault_info fault_info;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Per-VM kernel queue first-level TMA BO.
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Allocated at VM init, freed at VM fini — same
              lifecycle as page tables.
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Mapped read-only at
              AMDGPU_VA_RESERVED_TRAP_START in the GPU VM.
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SQ_SHADER_TMA for all kernel VMIDs points to
              this fixed VA; per-VM
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * isolation is via page tables mapping different
              physical BOs there.
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * CPU kernel writes second-level handler address
              via kq_tma_map.
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *kq_tma_bo;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va&nbsp;&nbsp;&nbsp;&nbsp; *kq_tma_va;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct iosys_map&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq_tma_map;
              <br>
            </blockquote>
            These should be the same for both user and kernel queues.&nbsp;
            The only
            <br>
            difference is who manages the vmids (driver vs MES).&nbsp; They
            are per
            <br>
            vmid so it doesn't matter whether it's a kernel queue or
            user queue.
            <br>
            <br>
          </blockquote>
          I would merge these patch sets.&nbsp; The trap handling is the same
          for
          <br>
          both kernel queues and user queues.&nbsp; The only difference for
          kernel
          <br>
          queues is that the driver has to set the TBA/TMA registers
          while
          <br>
          MES/KIQ handles it for user queues.&nbsp; At vm_init time, allocate
          the
          <br>
          memory for the trap handler, copy the trap handler to the
          memory and
          <br>
          add the mapping to the GPUVM address space.&nbsp; Then in gfxhub
          init,
          <br>
          program the TBA/TMA registers for the kernel managed vmids.&nbsp;
          Finally,
          <br>
          add the IOCTL to set/clear the second level trap handler and
          validate
          <br>
          the user supplied GPU VA.
          <br>
        </blockquote>
        <br>
        Hi Alex,
        <br>
        <br>
        Thank you for the review. I have few questions before proceeding
        with the implementation.
        <br>
        <br>
        I looked at how KFD handles this today in |kfd_process.c|:
        <br>
        <br>
        /* KFD writes second-level TBA/TMA into first-level TMA */
        <br>
        iosys_map_wr(&amp;qpd-&gt;cwsr_map, KFD_CWSR_TMA_OFFSET,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t, tba_addr);
        <br>
        iosys_map_wr(&amp;qpd-&gt;cwsr_map, KFD_CWSR_TMA_OFFSET +
        sizeof(uint64_t),
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t, tma_addr);
        <br>
        <br>
        Where |KFD_CWSR_TMA_OFFSET = AMDGPU_GPU_PAGE_SIZE + 2048 =
        0x1800|. KFD uses physical GPU addresses for TBA/TMA registers,
        not VM virtual addresses.
        <br>
        <br>
      </blockquote>
      <br>
      KFD doesn't use physical adddress, it uses the below fixed virtual
      address.
      <br>
      <br>
      pdd-&gt;qpd.cwsr_base =
      AMDGPU_VA_RESERVED_TRAP_START(pdd-&gt;dev-&gt;adev)
      <br>
      <br>
      KFD mechanism is to allocate one BO which is mapped to the above
      virtual address. That BO accounts for both TMA and TBA size. TMA
      is located at KFD_CWSR_TMA_OFFSET within that BO.
      <br>
      <br>
      TBA region carries the first level handler code. It's not allowed
      to be overridden by user. Hence when we moved to new design, TBA
      is kept common for all user VMs.
      <br>
      <br>
      TMA BO is the place through where user's second level TMA/TBA
      addresses are passed and also the place where stack is saved.
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iosys_map_wr(&amp;qpd-&gt;cwsr_map,
      KFD_CWSR_TMA_OFFSET,
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t, tba_addr);
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iosys_map_wr(&amp;qpd-&gt;cwsr_map,
      KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t, tma_addr);
      <br>
      <br>
      What this code does is to write the second level handler tba/tma
      addresses in the TMA, which is located at KFD_CWSR_TMA_OFFSET
      within the BO.
      <br>
      <br>
      <br>
      TMA region is the only variable thing per VM. First level handler
      code executed is the same for all VMs. So in the new design, we
      have a first level TBA BO that is shared by all VMs, and that
      carries first level trap handler code. The second level TBA is
      allocated per VM.
      <br>
      <br>
      I see Alex is saying the same thing which I asked through a
      different thread. There is no need to allocate separate BOs for
      kernel queues. All you need to do is program the fixed TBA/TMA
      first level virtual addresses for non-KFD VMs during init.
      <br>
      <br>
      Regarding kernel queue draining - my understanding is that the
      condition is no work having that VMID is in progress during the
      change. So, it may not be required to entirely drain kernel queue.
      <br>
      <br>
      Thanks,
      <br>
      Lijo
      <br>
      <br>
    </blockquote>
    <p>I would like to take a moment to summarize what has been agreed
      upon and share my thoughts on the remaining open points, to ensure
      we are all aligned.</p>
    <p dir="ltr"><b>What is agreed:</b></p>
    <ol dir="ltr" start="1">
      <li>Fixed VA = <code>AMDGPU_VA_RESERVED_TRAP_START</code> — same
        as KFD</li>
      <li>TMA starts at offset <code>0x1800</code> from BO start —
        matching <code>KFD_CWSR_TMA_OFFSET</code></li>
      <li><code>SQ_SHADER_TBA/TMA</code> registers programmed in gfxhub
        init — kernel VMIDs only</li>
      <li>UQ and KQ series merged into one — no separate <code>kq_tba_bo</code>/<code>kq_tma_bo</code></li>
      <li><code>SET_L2_TRAP</code>: evict user queues, ensure no VMID
        work in progress, write TMA, flush TL</li>
    </ol>
    <p dir="ltr"><strong>Open Point 1 — Shared TBA or per-VM TBA copy?</strong></p>
    <p dir="ltr">Alex said: <em>&quot;copy the trap handler to the memory at
        vm_init&quot;</em> → sounds like per-VM copy.<br>
      Lijo said: <em>&quot;TBA is kept common for all user VMs&quot;</em> →
      sounds like one shared BO.</p>
    <p dir="ltr">IMO: The first-level handler code (ISA binary) is
      identical across all VMs for the same hardware. Based on this, one
      option is to keep a single shared device-level TBA BO (<code>adev-&gt;trap_info-&gt;isa_bo</code>)
      mapped into each VM at <code>AMDGPU_VA_RESERVED_TRAP_START</code>,
      and allocate only the TMA BO per-VM at <code>vm_init</code>. This
      avoids duplicating the same ISA binary N times in memory. Please
      let me know if a per-VM TBA copy is preferred instead.</p>
    <p dir="ltr"><strong>Open Point 2 — What happens to <code>AMDGPU_VA_RESERVED_TRAP_UQ_START</code>?</strong></p>
    <p dir="ltr">After merging, <code>AMDGPU_VA_RESERVED_TRAP_START</code>
      covers both UQ and KQ in one buffer.</p>
    <p dir="ltr">IMO<strong>:</strong> Remove <code>AMDGPU_VA_RESERVED_TRAP_UQ_START</code>
      from the reserved VA space entirely since it is no longer needed.</p>
    <p dir="ltr"><strong>Open Point 3 — When to set <code>TRAP_EN</code>?</strong></p>
    <p dir="ltr">IMO<strong>:</strong> Set <code>TRAP_EN</code> at
      gfxhub init time. Since the per-VM TMA BO is always allocated at <code>vm_init</code>
      before any work is submitted, <code>AMDGPU_VA_RESERVED_TRAP_START</code>
      is always valid when any shader executes. No need to defer.</p>
    <p dir="ltr"><strong>Open Point 4 — How to ensure no VMID work is in
        progress?</strong></p>
    When <code>SET_L2_TRAP</code> is called, the TMA slots must be
    written only when no GPU work is actively executing under that VMID.
    One option is to use <code>amdgpu_vm_wait_idle()</code> before
    writing the TMA slots, which waits for all pending GPU work in the
    VM to complete. This is already used in the existing trap handler
    code for the same purpose. Please confirm if this is sufficient or
    if a different mechanism is needed.
    <p dir="ltr">Please confirm or correct any of the above</p>
    <p>I would greatly appreciate it if anyone has a different
      perspective on any of the above or anything missing to be included
      or added&nbsp; — so that the design is aligned with everyone.</p>
    <p>Regards,&nbsp;</p>
    <p>Srini</p>
    <blockquote type="cite" cite="mid:61caf661-a844-47b6-87b5-e7b71c3cd6b3@amd.com">
      <blockquote type="cite">Question 1 — Which fixed GPU virtual
        address for the merged buffer?
        <br>
        <br>
        KFD uses physical addresses for the TBA/TMA registers. Our
        design maps the buffer into each VM at a fixed virtual address
        for page table isolation. Should the merged per-VM buffer use |
        AMDGPU_VA_RESERVED_TRAP_UQ_START| as the fixed VA? Or a
        different address?
        <br>
        <br>
        Question 2 — TMA offset inside the merged buffer — 0x1800 or
        0x2000?
        <br>
        <br>
        KFD places the TMA section at offset |0x1800| from the TBA start
        (| KFD_CWSR_TMA_OFFSET|). The current UQ design uses offset
        |0x2000| (| AMDGPU_TRAP_TBA_MAX_SIZE|). After merging into one
        per-VM buffer, should TMA start at |0x1800| to match KFD's
        layout?
        <br>
        <br>
        Question 3 — When should TRAP_EN be set?
        <br>
        <br>
        When programming |SQ_SHADER_TBA_HI| for kernel VMIDs, should
        |TRAP_EN| be set only after the per-VM buffer is fully mapped?
        Or is it safe to set it at boot time since TMA slots start
        zeroed (meaning no second- level handler installed yet)?
        <br>
        <br>
        Question 4 — Drain kernel queues before writing second-level
        handler?
        <br>
        <br>
        When |SET_L2_TRAP| is called, user queues are evicted and TLB is
        flushed before writing. After the merge, kernel queue VMIDs also
        read from the same TMA. Should kernel queue work be drained as
        well before writing the second-level handler addresses?
        <br>
        <br>
        Thanks,
        <br>
        Srini
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------GrM3bt0fVKx67BEdj4kIWob2--
