Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722DDCCFA15
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 11:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7F810E30F;
	Thu, 26 Sep 2024 11:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="knwGFs7m";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C1510E30D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 11:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt2V3WqKSXBrj7qFH8cCRaBc95X8nEkAJI/Wx1DrqSo2sBjfR2RBOvDbhC2+ASuVZQRhlidiFTwxS5sJhd9Gllm9fSN5JBepIK9KoaThlsCi2InqHM2+MEXxMYEbsK+WgcqLJEXP5rQJfk5CDgN8VBM9vpqhG26eY401GN/DfOWV/XcvID24W3UtsTH1lQoUuNNNY+lISqUL0Ct+JFWiRGrdNCX98vZ3CjlUrtlx74KIro97VD7qybShJsi47j1hQBWBFruTA0IPVe2K7pYPR8VU17vQ/u8lDoQ1HRrKi5JbOhVmMPyPfcpbUQ1EDQpgv5vZoQrANsH0ZcBkhuyaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiL527TLZjgrlP2TDtuV6uSOLcGb6nY7Xh8M8uFXPNw=;
 b=Qf66TBAykX7nJ2dLlj7ngTxdwXlMu6ptBf4CSC4RJFVKh3/+8ksvY+xYufECLDDyLAOTC17YOJ1ukKmLwC+lZlv6w4F46ITTlPIr5n7QsQDYbhgqOEVEYlKtvFOsiYaCv0uRSGBUcn3YlAila/G1H9RNfRckoxrZRS3BEI/C8I9C7vjj8z+DQ09KGq+HTvaZ9pQ1aAP1D4Z4GUsGUpkcVQ9lorbdj1IImUmiZJiSnme57bUsVNOoYryWoPNvMCGGCgtjxX3QEMC8bpbxBVAVKNvpSu/3I13j8BpEuSBMSJ0iwKWjiUem9VS3zeJvtwV5OxmV4pwXZPzLmalwwSjqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiL527TLZjgrlP2TDtuV6uSOLcGb6nY7Xh8M8uFXPNw=;
 b=knwGFs7mnflIwZ3evTND7/qJIvjMpT8TDEdF/2SqFhCBVHk15e2bzHDckUOUC4VjQ3kjWmJ8rAJMe+cct+EwlMgJbOEKC3VzY7dcJlj3OJPRHi4jS1XdEnkdjTsURkVDNpDptrBVlX+L8Gi3iVHe9ceDAI0W5eNqETDH38mcTrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 11:16:50 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%6]) with mapi id 15.20.7982.018; Thu, 26 Sep 2024
 11:16:50 +0000
Message-ID: <7e28bb62-a72e-4e5b-a035-fcecc94033e9@amd.com>
Date: Thu, 26 Sep 2024 13:16:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/08] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <3fe2c80e-565f-448c-9b7c-9e69fe175ab8@gmail.com>
 <04440164-8566-4ec0-98ce-c40f718a7575@amd.com>
 <ad931726-cfa8-4c60-83ef-ae164a8c3f66@amd.com>
 <e37ec78b-2d1d-4cc6-8b3f-4e9e391275b8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e37ec78b-2d1d-4cc6-8b3f-4e9e391275b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2edc66-cea4-4acd-9bbf-08dcde1cb7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3gyU05JVHk5dHZOaGVGdll3c2FwN3BTUmtpME9TRitZZTVrb0RwR2VVeXlQ?=
 =?utf-8?B?UVgwNXhKSGJqTkNibCtoS3I3NWxKeExaUHVFbTVnUWdSTWkweHNUbmNsRjBT?=
 =?utf-8?B?NnQ3eEg4OFJrdHBTcmk1RWNwdUxCUE5zY1hOaWFwUG9PUDBIb1l3VWZwQWUx?=
 =?utf-8?B?TjQ1cEJOUmxVRHU4WDEyVXMwV2RVTzNGWTJyN1F1a09oRFlvRDdKVGdIUTBC?=
 =?utf-8?B?bVNSbHVMaDgrZjZaOS8rMGJxcFF4MTRFMDlEMTAxZ3ZTT2VkZ2RQakxIUzFa?=
 =?utf-8?B?dndPaGphU0RWcC9zYmJoVGI4SFBrZzJ0U2tHZWlqK3JNN3NHNkxCY0RWbkxF?=
 =?utf-8?B?RG9QMEp4RGlwMTRFdFNOMHlqeUF1Z2JoTithNW5MclNlSGY0bUR6YUFmOEV3?=
 =?utf-8?B?OTFCUFRzN2QwUEplU1dEVlNnckFDM0ZoMFNlTVh5amNRbnpwaXNuNlhLbWNZ?=
 =?utf-8?B?WC91YmRmQkN2V2trZFI3aUswTHA0eFUydUZCYUorNlNRalRpb0g5eGJTTG9s?=
 =?utf-8?B?ZW8wbnErY3J6ZTk1ajhMU3U0Mzd5UWhTWklxUGYvRXhTSjJobTY5emx1aGVL?=
 =?utf-8?B?d0JSZmM3SjY3ZFJ0QUp0T2FaSGRzK2RXRU84aWVGM0VORFZxTW5DYkFQVVd3?=
 =?utf-8?B?TkJiRVVCUUtpOTQyZmlmSkloa1h6a0pGSjRJdS9kYUF4L0pieWNXTkFMSDlr?=
 =?utf-8?B?Ynh5TXhIYW11RlhUODN0VFI3S3d2NmM3RFVHQTFzbXB2VzRJTHhkUlFteHpB?=
 =?utf-8?B?bXYxVEFFR3AwUWRFaElZWjlYdGI3eWVjbXlaRmxIemQ5TnpIanVNanhNMzdi?=
 =?utf-8?B?cmxEWHNDZGpkUEt0ZE1Jcm5JeUpuZnZUdytPdHdHaldRRGt5Y2pqV2U2TTN3?=
 =?utf-8?B?MWQxWDRTYm5uMEJEYVNiaGV4L3VxN2NzYlBvN1FqWFl2dU5FcS95all1bEVu?=
 =?utf-8?B?eVVJV0VMazFpSUd4S21IejJhYnNDU3piSS90cDFkWlZqbHhpa21uTUR1aTFi?=
 =?utf-8?B?WlIzS05FTHEwWHJreitVM1MvSXFBcGs0bEdYZ2FqV01Cc1dVREFCZXJSN0ZV?=
 =?utf-8?B?M1A5YWNOWWdPT1FYUWhjMW95Q1NSa1JhcjVHaFIrSG1KTFdTaXlBcVVkS0h6?=
 =?utf-8?B?dHRUM1NFV2N5TXlrS1p2OW0zaEFMUlF0WmcrY1NaWmlBU0tHR3dlNElTWE9u?=
 =?utf-8?B?R0d2KzBOQUpvRDd5MG9oN1JsdDBFbVd0OHdlQk1ydE85MTRLTXR6aVRSUTV6?=
 =?utf-8?B?MHVFSDVnY1lXM3NJYk1ZUmVhSGYwQjBtdFYzajlsb2VPa05QUys3ZkRSNHRD?=
 =?utf-8?B?R1Jua3BKTFU0R2paV095UVMrTFM1MDR0Q0xjYmdDNEJ2U000TFA4R3BoSTVm?=
 =?utf-8?B?UWx6OC8zeHhKNWRiZzdkUFlDeEFiMldvWFdud2tLbExWVENRdjlkcXZNYnZK?=
 =?utf-8?B?cm50TjNFekFzTk04aUY1VktRR2tQRXk1Yi9vb1VJTjk3QnF6WXNRWWVGV2Q4?=
 =?utf-8?B?Wm9EOXFPSU1ISEFNS2tRNXNUWU5XVzZFTzZ3RXlwUkgreWhjS2JORVgvWSsy?=
 =?utf-8?B?cksyZE8zMXltbjh6R3lsdWNjOXBLZGxiUXhsdk95cXhkM2xmNXhrbE40NSt2?=
 =?utf-8?B?b25Sd3RWSnZVWVRZSk9GLzZscldUQ2ZscjU5S0VhdEVnSzA4Qk91ZWkwTUZU?=
 =?utf-8?B?WjBVUzdqVEhPeVA2NVA1eFJ1SHdHSkwxWGpSMTNSQ2JwYSs3M3I3VE9oa3BH?=
 =?utf-8?B?dDFOZ0VKdXJ5OEFHV0o4bC9PZG5RdjYyRlBkRkxmTStJc2pxT0wyNDFSTTd2?=
 =?utf-8?B?ZVhBMUk3ZVRoa1h5dDRWdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFB3UENxUE5aSzg3TzRCOHJNdzZ4alRNMnYrL3FYUVpLZnU2RzVMZlR2VmNE?=
 =?utf-8?B?cC83dmpDQ2NjMWpsSmY5Y2xpcEgrMHRYcENtM3lrM2N4VUhRbHJLTmUzcEx6?=
 =?utf-8?B?eGpGTklzTU4xeXQwYVN0alhmaThmTTh4RjFBSk9SZTB6Skg3eDl5cGhSYTlW?=
 =?utf-8?B?RERYOFRrMGVxZDlGaXNKaDhUbG81MHNQcENPanRHZTNTcXJBeElFVHRZbGl1?=
 =?utf-8?B?c0FiYmZSNEJPQzlSTDQxck1OZER6d2MzaWg0VlM1cUN1TCtDdGl4MnRlSFpq?=
 =?utf-8?B?MVNjdzhCZlo3QXo2REYwUDdweHNEZTRWa3NIUWI4LzRVeC9YL0t5Vml0ZEhw?=
 =?utf-8?B?OWpNUWdtWjg4UDVnaVZGVWdRU0k2Vjc3aUpDWWNMbmF4T3NjQ0pJYnFIOVc3?=
 =?utf-8?B?MGhqbm9BTkhpSURBR1BKOWZLTy93OWkwMkxKTlpPaFBrUU1hQ1VhdVBVSXN6?=
 =?utf-8?B?d3cxdHI4dVBCOThZUlZ2aGUrTUZIajlkUXNFZzdxNEh1R29PUTFkOXJUd0w3?=
 =?utf-8?B?YkpVOWYrQUhGSWFyRnAzN2NXUjBDMDZUajcyc1B3TVNiUUZSLy90R3VNNmJB?=
 =?utf-8?B?Z1ZvMWtTVHB0MTlydWE4R2tpY1ZhdWVzMjVrb0xjcXhjYUg2NXdob0VqcUFY?=
 =?utf-8?B?ekhWcmIyZ2J2QTBsUXVseVFZRnJ1MjVMV3JNSXgyVS9DZlNLdy9LYkVSWWF3?=
 =?utf-8?B?NFNEYnNya0V4WkswQ1NnNnBhU3daTnVWU1FNUFNRQ0RMRDBwQTlNTEY5MWhW?=
 =?utf-8?B?NHIyYVErODMrajZwYlRkcXdhMnlWYTYvdFNLellVUG5SZmk5dWJQRDNrQldX?=
 =?utf-8?B?cVV0cEtsVzBId2N4Mk00MGg1TEVhNlFKNmxPNk5BTlJ2TkxoMFRBRmRKUVVp?=
 =?utf-8?B?SXd1VDB6SmRYb253NnhXeVQ2VWxHU25tcHQ1MWlEZitNdVI4N3VhR3VzbVFz?=
 =?utf-8?B?SDM0V1RJYUZFS2I1VmJsb2dzUm9NOTc4OGpkOVZHWURyREJqaU1EMDRmaUU3?=
 =?utf-8?B?Nm9QUTN1bTljVWUwVlE0S2ViUGJzOWYxcnhHYUd5RGJoMHhpL2dmZStRa2tN?=
 =?utf-8?B?aGxCRVA3UFZCT1JGQ0Y5dVdqc29XUzlVK0ozR3kyWEhJUXdEQk9McWszRTcw?=
 =?utf-8?B?ckpHT1RTVWMxZy9pSy9xR0J3b2MxeW81WHBLa3RnbjNIWFRGM0Zra3dCc1FR?=
 =?utf-8?B?SnNaTU54RFJrMUJXM3lITjN2V0pFUGRESS9sWUZrTElJZmt1UDB5amlCTmN2?=
 =?utf-8?B?WXdWRmJyUFpKNW80TW9lT25PRnZXdGoyUHUxSzlWZlJndVZXUXBTdlJmeE1X?=
 =?utf-8?B?cHVQdmRqRlRrY2daMEFsVW5MdFpXZ01CMXUvaUgwbVdlSGVXMGVqQU8rQ1J4?=
 =?utf-8?B?UUZ2SWNGVFBHRWl6WjFJRThTcGFVVWIwdFJMWDZhWFVHbTlqSmc2RkhWOHNY?=
 =?utf-8?B?VXY0b2duUWppS0FwSVVnNEhPL1hMbFJ1cGhsNHhYeW80QXJTd3VFbk40clJx?=
 =?utf-8?B?eDN0QnFYcDhBN0NmK0lmeUpCR3k0SGZQSHlkZTYwNG9pV2VFOFlaQUVaK3Fo?=
 =?utf-8?B?NEkzelVJWjcyN2I0RFhGYVlBWmpaSWhNMzE4YWV2Yzk4YWo4Y2lkVHdRZDNv?=
 =?utf-8?B?VDJ6QjlHQTlneTVRN1NLd3A0UlMzVjF0dWlRdjRiMjFMbm5wRXU3dWxnZkJx?=
 =?utf-8?B?bEhwY2J3b2N4b2FiUWVBUmtJazlwb2E4RXN6MzRJaC9pL2dPQURSejRGbHpM?=
 =?utf-8?B?RC83RnpqY1NkS2NLOHE1RUllVFljZGR1bzZuTHhud3hkRjBNblZxbDJ4YjRW?=
 =?utf-8?B?OUZZVGxzUlF1ZkRHZGo4QUxQTkFIZnVCV0ZLT0o3ZjFZVDUxdG1qcHBwR1ZL?=
 =?utf-8?B?TUxENW9EakxNbmxzbDRhK3FOUE9SeEo0MW9nWDNQaUM3V2xQOElxTFhsMDZE?=
 =?utf-8?B?RkFFbHp6a1FsaEZvY05UTnhLNFZFQjdIUkNZZkhtK1RoenZ1ZEtwR2YxNUR3?=
 =?utf-8?B?VWNDZm1qNHN3Y3VGeVVyVzdDcFRobjZKVFcwRVYzbWpybVdramt6dHluVU9r?=
 =?utf-8?B?QnFISEV6VWkyNlZSaE5DM3M5a0RuRmhMZGJCVUlMYnBEc0lwUGlmbHVpeWEy?=
 =?utf-8?Q?6YSw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2edc66-cea4-4acd-9bbf-08dcde1cb7b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 11:16:50.3490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDL3g4cKgNtuVaoIfjLlWpL/dUmTOTdveuPPcVAu0I4ABo9GgTIqiqa9lcjEgIpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Am 26.09.24 um 12:26 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
> On 9/26/2024 3:04 PM, Christian König wrote:
>> Am 26.09.24 um 11:31 schrieb Paneer Selvam, Arunpravin:
>>> Hi Christian,
>>>
>>> On 9/26/2024 2:57 PM, Christian König wrote:
>>>> Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
>>>>> [SNIP]
>>>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>> +                struct drm_file *filp)
>>>>> +{
>>>>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>>>> +    struct drm_amdgpu_userq_wait *wait_info = data;
>>>>> +    u32 *syncobj_handles, *bo_handles;
>>>>> +    struct dma_fence **fences = NULL;
>>>>> +    u32 num_syncobj, num_bo_handles;
>>>>> +    struct drm_gem_object **gobj;
>>>>> +    struct drm_exec exec;
>>>>> +    int r, i, entry, cnt;
>>>>> +    u64 num_fences = 0;
>>>>> +
>>>>> +    num_bo_handles = wait_info->num_bo_handles;
>>>>> +    bo_handles = 
>>>>> memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
>>>>> +                 sizeof(u32) * num_bo_handles);
>>>>> +    if (IS_ERR(bo_handles))
>>>>> +        return PTR_ERR(bo_handles);
>>>>> +
>>>>> +    num_syncobj = wait_info->num_syncobj_handles;
>>>>> +    syncobj_handles = 
>>>>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>>>>> +                      sizeof(u32) * num_syncobj);
>>>>> +    if (IS_ERR(syncobj_handles)) {
>>>>> +        r = PTR_ERR(syncobj_handles);
>>>>> +        goto free_bo_handles;
>>>>> +    }
>>>>> +
>>>>> +    /* Array of GEM object handles */
>>>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>>>> +    if (!gobj) {
>>>>> +        r = -ENOMEM;
>>>>> +        goto free_syncobj_handles;
>>>>> +    }
>>>>> +
>>>>> +    for (entry = 0; entry < num_bo_handles; entry++) {
>>>>> +        gobj[entry] = drm_gem_object_lookup(filp, 
>>>>> bo_handles[entry]);
>>>>> +        if (!gobj[entry]) {
>>>>> +            r = -ENOENT;
>>>>> +            goto put_gobj;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>>>>> +    drm_exec_until_all_locked(&exec) {
>>>>> +        r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>>>>> +        drm_exec_retry_on_contention(&exec);
>>>>> +        if (r) {
>>>>> +            drm_exec_fini(&exec);
>>>>> +            goto put_gobj;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (!wait_info->num_fences) {
>>>>> +        /* Count syncobj's fence */
>>>>> +        for (i = 0; i < num_syncobj; i++) {
>>>>> +            struct dma_fence *fence;
>>>>> +
>>>>> +            r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>>>>> +                           0, 0, &fence);
>>>>> +            dma_fence_put(fence);
>>>>> +
>>>>> +            if (r || !fence)
>>>>> +                continue;
>>>>> +
>>>>> +            num_fences++;
>>>>> +        }
>>>>> +
>>>>> +        /* Count GEM objects fence */
>>>>> +        for (i = 0; i < num_bo_handles; i++) {
>>>>> +            struct dma_resv_iter resv_cursor;
>>>>> +            struct dma_fence *fence;
>>>>> +
>>>>> +            dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>>>>> + dma_resv_usage_rw(wait_info->bo_wait_flags &
>>>>> +                        AMDGPU_USERQ_BO_WRITE), fence)
>>>>> +                num_fences++;
>>>>
>>>> We should probably adjust the UAPI here once more.
>>>>
>>>> The problem is that we only provide the AMDGPU_USERQ_BO_WRITE for 
>>>> the whole IOCTL instead of per BO.
>>>>
>>>> So the best approach would probably be to drop the 
>>>> AMDGPU_USERQ_BO_WRITE flag and split up the array of BOs into 
>>>> readers and writers.
>>>>
>>>> Can you work on that Arun? Shouldn't be more than a bit typing 
>>>> exercise.
>>> Sure, I will modify and send the next version of this file.
>>
>> Thanks.
>>
>> In the meantime I'm going to review the rest of the series, so there 
>> could be more comments. But please update the UAPI first.
>
> Can we have the bo_handles_read_array, num_read_bo_handles, 
> bo_handles_write_array, num_write_bo_handles in both
> signal IOCTL and wait IOCTL?

I think so, yes.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Arun.
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>
>>
>

