Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12247C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 17:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6018010E9C9;
	Fri,  3 May 2024 17:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8lVc5qS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EB410E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 17:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFPCdz+Bz/wq0yYOi09lP5cdeM+oKPxh81XwNz2IGLlv4FJ6kQ8GJ80MilUr4Z/g/9BmTgVSmQV+4uN260lwS/NvyVGNfhKn8tKFy/aWrACs6dG4/wz+PmZV4m2QMIZTEWn9JhYEStdrLI9XTXFQ2Uf4Jkr2h9EOauMB8n5gaHl4yYcWZ1dnVXcD/RtbQK6K62ngOaIDH/QI9eXOS7s10GfiuQer6W8Gwozf3bmiVMFj9m8Fgq8n4mqQbFw4INlKBk/8cuQpBlBVK1Mv3rfsouFJe+0K93rg7oBQwa+iw3OGVBFE8hdGziDWX5uHIux3mrXwDOzxhfa+1Lyduj9wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wx3GljM6STs4WnXvI2fRPxP1UWrnmLQi8Ra3Oxshus=;
 b=MOwdFSJFJ+ffRHZpbXxfZXer1xrn6AZlDtv+as6hE69/ErKbJ4XSCdFWEK7PloFdDpJQY5GWLjpNAULZWY0/SwatuNT1T4jDQ8NhuYaMwQy2fi0/y6UnWFXAR9oRtias3TL7GRW+AorEJ+oOdz7LuS7XRJcAmoKRU7m8AdBETbAQhwn5m5DgKKMZMmsznRj2HWUzca/FIF3WDnICgcwUYG/+l8vbv5WabkcrxJUPaK5dYFrdirzYz4uDsIxtl2nEYUyxOetbpAIW7FND5i6YzTy/bRC3GRfO9uiZkRONGpXtbHY2VC87KO1cP4nqF0SSa/0EG2yIlc51cqCndIm9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wx3GljM6STs4WnXvI2fRPxP1UWrnmLQi8Ra3Oxshus=;
 b=U8lVc5qSmXPXcUOKMSdBMPzvpFGCIoL77XfapV0yX/pRhGcoE1WKRf1isPkpD12ejzKCJX49tUP4VUDrKVRcjLUETcDaL5dlbrBUBoCUTCbQf9LqkV4+spVaAsNmbHc+PTY+t37/GPcApaVI7fD+17HZrm1NXnHF1iX1Eon5D4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 17:29:30 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 17:29:28 +0000
Message-ID: <af13b7a3-69ba-41b9-8e43-f29d314a6f43@amd.com>
Date: Fri, 3 May 2024 22:59:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu: add compute registers in ip dump for
 gfx10
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240503084447.2451529-1-sunil.khatri@amd.com>
 <20240503084447.2451529-4-sunil.khatri@amd.com>
 <CADnq5_OYxPY6_qUwkbEqMQmDLaiDwopFKdeREn=WabnKjbBA8A@mail.gmail.com>
 <5681bd76-f01e-491d-982d-2448aaf4f9af@amd.com>
 <76aca882-f1f7-4edf-8dcb-2098dc1a52a3@amd.com>
 <CADnq5_MwcLfBNv+y2fEA3Xx+-cKrFc+tevYEGzPQAVzcSA01HA@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_MwcLfBNv+y2fEA3Xx+-cKrFc+tevYEGzPQAVzcSA01HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 007d23a3-743c-4388-abe7-08dc6b96957b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmRjNXhVdTdPL0FRSzRMR0NIMHRtb0ZYcDB5cnFybXhqdi9vTm5RYzdYNjNB?=
 =?utf-8?B?d1lEMTRLWkZYVlF5S09vVXJTaFdTSFJpamJQSXc3L1p3QUU0YXEyTVZTSDh5?=
 =?utf-8?B?MkgvelZTU1grZHphVzlqNDlLVnlhZkp3cWl1S3NGL005Zk85MnZSNkNGR0Y1?=
 =?utf-8?B?RnFieGk0RWllc3NNYnBSMG95b25Oc2djekJESFk3U0JLZmxRWll4NlBmc2x6?=
 =?utf-8?B?ZyswQ2wyVEZBb0M3VkduL0pJZUhqVFIveWRzWnNodE56endPZnptL3JpZ0VC?=
 =?utf-8?B?ZURDTURqSTdMRndVN0hzaEgrQU04cWhuNllqSVpENnhhNmpsTm5xeFJ1Wmo4?=
 =?utf-8?B?eUxHam9rbmZya2hQQXUyRVA1MDBjQnVoc0tkSitFNmhpbW1mNWR3V29Lb204?=
 =?utf-8?B?SmRjdzRnNDR2V1g0VlJ0Sm5FZFFmM0xDblFVWkNKTFUxOEVlUjgvK0NvM1RY?=
 =?utf-8?B?dXY0TXBGaVJqcmZHZVFpbDlNQXl5c2g1NE9ubHVWbHBUYlRKa1gvUE5xdlc1?=
 =?utf-8?B?Z3lZOGt3L21IR0xoc3BoZE8vbnhFMWlUM1VDejlYYXRLSGgyeXh5c3o1N1Vx?=
 =?utf-8?B?eGc3Ry93eGNseC8yeEpwQkhGY0xHdzh0Yy84TDJrb05HalRKWVl4alo0N2ox?=
 =?utf-8?B?THZqY1V1T1pLamtRLzNCZGJ0UkJ1U3FSRk9IUGF1WDRIVW80alRST3pnSjVr?=
 =?utf-8?B?S2hMdDhBVXFISENLdDRIWmlaUEhOT0x2NnBRZFBYS01wejF1a1ZMa2QybmIr?=
 =?utf-8?B?cnJ4Z0lPVk50TjlNZlVvVmx1SWdKU0k2ZmZlOWluNU1DOWk0VVJubmwvSGoz?=
 =?utf-8?B?NituN2s2L2dTQmtaUEdDcTFCaU5UOXRUZUUzSUhkTCtlWjgrdmY5MlV0ZTVi?=
 =?utf-8?B?Nk5tUERVWnMrUHNNTGRUaFM1eGN2ZzdXa3YvckdWYUlHT2xiZHFZclloUllp?=
 =?utf-8?B?VXlkV0Q5OStBandET1h4Zk91R1VhcGpuSW1lQjBuMFV6aXZ0MGhEVEk5UVlj?=
 =?utf-8?B?aldrcFVMOTFaSUE1RG9GSjdpZDlhTEx1Y0ladGxGaVRaL1FHdFN2NkVvRmNn?=
 =?utf-8?B?eDEySXl4c2k3RHlyaXM3Q3pLYWhhdEExcFdIeFVrVXdDdHNDMTJSN1lUTkhJ?=
 =?utf-8?B?T3ZpQzMwbk5kNHhGRlVDR3FYU0NnY083UFpyRnZtRlhFdHZqSWs2aFl6UnBF?=
 =?utf-8?B?UUYxTkNoSnN6Z0lkVXpHUVZ6YVNhc0ZpZ3RhcVg5UnJlK2tubmNjNUY0ZkNr?=
 =?utf-8?B?Qmdib29pWFdpTWJpOGdWbmZZcDVSdmZ3a0JZd200MWowTGJyait4dTd2cFNI?=
 =?utf-8?B?VEdEU0lvRnNJSzJhOXFQenhUaXB0bWQ5cnN0T1FlK1M0enRSUHVjZzNxNlE1?=
 =?utf-8?B?K2dtVi9ZbVVFVkVGVUFWZjA1Ni9JQzJFQWkyMzZpbDFNNTJCMGpTck9oOVBF?=
 =?utf-8?B?QlZrWi84ZHlLcHN4aHd5SVk4UHYweGJ5blpBdWQzY0lzR1B0SmtKSEhYdU0z?=
 =?utf-8?B?dGxEWlBUT1AxSSs3b2FPaTdvU0pmcGVWcmpXdDVMZjFTZ0lCQXozRnNERlhl?=
 =?utf-8?B?TXByYUhSWDVhc1NJSlJIazk2bjlDMFVFdGg5TENiTG56bHl0bjFNaVJHUzE0?=
 =?utf-8?B?Nm41N2JHSnVnZFNTZ2ZLaFJFRjczZjZVL0ZENnhmVGZheCtEU1FwcVozTU0y?=
 =?utf-8?B?TWdSQjdPRkpkdmRXL3hYYXh5bCtBRVBZdmZWY0tINHBPWVVteFJIbHFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCs2MUd2eEthRWpMSHNWT3JUM050QUtsMVhlNVo3TjBicFRxN0xqeU53QlI5?=
 =?utf-8?B?QWM1SmVtNEovcU0rbEVzb1hTMkw1V1FQMVdMVnRLZjBOZHBSNVRBUTNQeXdI?=
 =?utf-8?B?K1VCOVk1WDBZNHdFTGdrL0RtWHk5YTFvSWJqNmpqUEpya3NCR282ODNQblhX?=
 =?utf-8?B?Ni9kWWlFQyswZmVHQWRWN2pNaVpYQzZva05wUjFDaUZlZ0taOTFndy8wbXhv?=
 =?utf-8?B?SlZuM3QydUllQW54NUI2RndnSy9WamtDdUxuR1lJMkpFdXRDQ0JhaCtMOHl3?=
 =?utf-8?B?NTVuVUxkV2dyeXpLRklCa2QzSzU2SlFxNXJsRDgxSktuRkpqV294ZlVXVnkr?=
 =?utf-8?B?RzdPTnZKTUVuMUtoQUhqSWIveU9ObzdMNnVGc0NOMWNMc3NUZDdIdnNkRjlq?=
 =?utf-8?B?MTV1bmxTQzdCcDNETXNJUmZkS2J4WnZTKzhhNmtyQjNEbjhrelcrcUtlSjFB?=
 =?utf-8?B?KzhqYm9YbEtxT0tML0lRQ2UwMzJDS2xpNG9XbndSRnh0blY2VFdTNzU3QUlC?=
 =?utf-8?B?ODhMNzRtc3M1N2RvcWR0VmR0UnVVUUw5bmJGSDhrUDhXOCtCcnhOWVJ1VXlP?=
 =?utf-8?B?NTAraUd4L0RtQklsMVcvN1hyei8vdlJzWmcxcndpSk53empHMmoxZ2xJRUwz?=
 =?utf-8?B?Z3pYY0NvM0FMcWZ6YlZjczk1SWZaN3hkODVtcGM3ckFCYjdNb3Q4MkQzVjdO?=
 =?utf-8?B?ZDlpdGFPN21vQkh5d2pPNXNVbkNkK1FUSWR6MmZ5SjAyU1Y5QzROZ1VIUXFG?=
 =?utf-8?B?NWxIWDk1K09FNklsdkpZc09xYWRWRDVBK2E5WVZ5VXZ4b0RVZnpIR20xZ2tE?=
 =?utf-8?B?MFpVbG9rMkhjTnMvY2ZZR1hZTC91Yk52cTdqaHNmZXE3b3Jsc3ljZXR6aTMy?=
 =?utf-8?B?RW0wS2FidnhtN3JTdzV6dlluK2NvM3gyK2dVdTBTaWgrdjlOZ1BVLzlLVHFU?=
 =?utf-8?B?N0ZUV0tCUXJwQU5BQ2M4UUJNR2xKNG92WW1yRmh0RTlNRTJYTjlRa2diU0VB?=
 =?utf-8?B?SG5aSkErb0I5VmROQSttYmE1N0xJWFZ6MmQyN1NFN2hVUHRCMU9YNkpVR0FZ?=
 =?utf-8?B?eDJlVUJXUEEwQzJ5ZkNabXI2Y05ZMThWcXIxS2NnbllWQVNNUTlGWjFDb0Rw?=
 =?utf-8?B?Z2lNcjVkLy84Zmd4NGh3RzFsY2N2SUU5Z3BnQjNFZUlCNjBqS29xZUxPbWE1?=
 =?utf-8?B?Z01TWnFMWURxeis4bkI3blVUVjVQanV4Z04rWFh0TkY4NmVhVytnb3MrazJs?=
 =?utf-8?B?ditXYThEM2FieHEvUWRqLzdoTnJuT1ZaY0VoS2oveHFGc2Nqd2UyYkp1QVYw?=
 =?utf-8?B?dVN2QktycDUxYzNDNTNLS0UyeUE4bHNsdUIyczBwSjdLRTE2TEpEbWRhQlk5?=
 =?utf-8?B?THRGcFp5MlZLcVFCT0RHOXJLWXkrektlbFlqV2Q5UzFKTGxiRVExdFZyZXRh?=
 =?utf-8?B?VkZzWWorQ0NaYjB0ZjZET1Noay9qQnhGbkl5QjJEVXg1MFY0Vllnb1h3d1hp?=
 =?utf-8?B?WHYvdFIrTitBaE9WaTdYQ3pGTmNBWFFERHkvOUIzdjZNUmNCckIvV3lGOEVS?=
 =?utf-8?B?VUFuclJXTDA4ZkczQ0FweENoSkxuZDhkNUdZTlRWSk5pSE5Mb2tOMlBIdHNo?=
 =?utf-8?B?N21HWHBvYlBKOStSREVkb1BmRkxUT3g2L1BncVNyQTFNcUNtYVNsQlBQaEM4?=
 =?utf-8?B?K1lvTnp6ck1pTU41T0hXZ3hEcnZydDA1NVYyc2FYbzNhQXRBNzJQRHNYT2xL?=
 =?utf-8?B?VmVRMVVBQWcvQU9pbUZNUVl3Ui9vSlBOMFIvVXErZDJyaVB5NXJhM1NPR1Fq?=
 =?utf-8?B?QjlpNG1qQUlNMlpzOUp0Q09MS2dSVmFQVEhxMXhBZUkyV3BYc3BiOU9PNHhJ?=
 =?utf-8?B?bTBkNkhuNXBtTG1EU3lXZXdROEg4dzl4M045c0szWEw0b2NrbzA3eURVK1VR?=
 =?utf-8?B?VS81NW9VMkkva2RqZm9Ndkg2Q0VPemJQQ2Z3c050SHBtUno2UkhrZ2RpdGpF?=
 =?utf-8?B?bGppVU9nM1YveW9WVFhuRzcwaXJ0QUpjUms2VUxscU5hZzV0aUdsT0hScXlp?=
 =?utf-8?B?blNBVHV6Mm91c0pVUDlZdGgrUEhRcWVvRFArSlJRVTlKUnZmdHUzYXVISVdO?=
 =?utf-8?Q?pbseGoCN3ZZldizStmfpc137G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007d23a3-743c-4388-abe7-08dc6b96957b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 17:29:28.0159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l84eLAvOuyyxxrEIfQaSsDdXpTDSdWQZo1BgVIom5BcbHCj0/JFRsFg41TQ9NSXpRa8BhvNIJREVo/ofdhsuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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


On 5/3/2024 9:52 PM, Alex Deucher wrote:
> On Fri, May 3, 2024 at 12:09 PM Khatri, Sunil <sukhatri@amd.com> wrote:
>>
>> On 5/3/2024 9:18 PM, Khatri, Sunil wrote:
>>> On 5/3/2024 8:52 PM, Alex Deucher wrote:
>>>> On Fri, May 3, 2024 at 4:45 AM Sunil Khatri <sunil.khatri@amd.com>
>>>> wrote:
>>>>> add compute registers in set of registers to dump
>>>>> during ip dump for gfx10.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42
>>>>> +++++++++++++++++++++++++-
>>>>>    1 file changed, 41 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> index 953df202953a..00c7a842ea3b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> @@ -378,7 +378,47 @@ static const struct amdgpu_hwip_reg_entry
>>>>> gc_reg_list_10_1[] = {
>>>>>           SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>>>>           SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>>>>           SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>>>>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>>>>> +       /* compute registers */
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)
>>>> The registers in patches 3 and 4 are multi-instance, so we should
>>>> ideally print every instance of them rather than just one.  Use
>>>> nv_grbm_select() to select the pipes and queues.  Make sure to protect
>>>> access using the adev->srbm_mutex mutex.
>>>>
>>>> E.g., for the compute registers (patch 3):
>>>>       mutex_lock(&adev->srbm_mutex);
>>>>           for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>>>>                   for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>>>>                          for (k = 0; k <
>>>> adev->gfx.mec.num_queue_per_pipe; k++) {
>>>>                    drm_printf("mec %d, pipe %d, queue %d\n", i, j, k);
>>>>                   nv_grbm_select(adev, i, j, k, 0);
>>>>                          for (reg = 0; reg < ARRAY_SIZE(compute_regs);
>>>> reg++)
>>>>                          drm_printf(...RREG(compute_regs[reg]));
>>>>                       }
>>>>                   }
>>>>       }
>>>>       nv_grbm_select(adev, 0, 0, 0, 0);
>>>>       mutex_unlock(&adev->srbm_mutex);
>>>>
>>>> For gfx registers (patch 4):
>>>>
>>>>       mutex_lock(&adev->srbm_mutex);
>>>>           for (i = 0; i < adev->gfx.me.num_me; ++i) {
>>>>                   for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
>>>>                       for (k = 0; k < adev->gfx.me.num_queue_per_pipe;
>>>> k++) {
>>>>                                 drm_printf("me %d, pipe %d, queue
>>>> %d\n", i, j, k);
>>>>                                   nv_grbm_select(adev, i, j, k, 0);
>>>>                          for (reg = 0; reg < ARRAY_SIZE(gfx_regs); reg++)
>>>>                          drm_printf(...RREG(gfx_regs[reg]));
>> I see one problem here, we dump the registers in memory allocated first
>> and read before and store and then dump later when user read the
>> devcoredump file. Here we do not know how many registers are there
>> considering multiple me and then pipe per me and queue per pipe.
>>
>> Should we run this loop in advance to count no of elements while
>> allocating memory or (count = gfx.me.num_me *
>> adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_queue_per_pipe. No
>> matter what we do we need to save these registers in advance.
> Keep the multi-instanced registers in separate arrays and then add
> them all up to get the total size.
>
> adev->gfx.ip_dump_core[regs]
> adev->gfx.ip_dump_cp_compute_instanced[mec][pipe][queue]
> adev->gfx.ip_dump_cp_gfx_instanced[me][pipe][queue]
>
>> Also another problem in printing drm_printf("me %d, pipe %d, queue
>> %d\n", i, j, k); Need to think how we can do that ...
> Use multiple arrays to store the data. and just print that between
> them in the ip_print callback.

Ok, Sure

Thanks Sunil

>
> Alex
>
>>>>               }
>>>>                   }
>>>>           }
>>>>       nv_grbm_select(adev, 0, 0, 0, 0);
>>>>       mutex_unlock(&adev->srbm_mutex);
>>> Thanks for pointing that out and suggesting the sample code of how it
>>> should be. Will take care of this in next patch set.
>>>
>>> Regards
>>>
>>> Sunil
>>>
>>>> Alex
>>>>
>>>>>    };
>>>>>
>>>>>    static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>>>> --
>>>>> 2.34.1
>>>>>
