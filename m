Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C09C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 16:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7ED10E525;
	Mon, 28 Jul 2025 16:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3Cdz9jN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA1210E525
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 16:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzdMLEbueLFk4tyX3wzUHnSa+/DehQY9hE7GPldYN9Y1zFP4lFwB4Y9sOr3pfwKruQmK4pWynv3fzhAV/LBBxfp7ryOFvs1eDJYYbXGqzhzKAueZtrYI1FWYx6jnMBYP+E0W8n2eBL9KAWTvyX0m517ERvQaxGgehKKdLBj/ysW4/p+/vzSjEGTv9v9xGXxqlqnC2/Ab0P4UTsysN87pIvGzkmdbfWaSe6uPm38Mjp2ApD29U8SL3vv1J1T+6Y9fMlcCdL7lhHI/ZQ6Dny3BbOS55qGPgEqvQtfpjPrBz4RjRJ+rqMpD+I/TXxSuHl/Y/4yjbSLhhOt8Lxe1A0RhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSnUWuosl60NLmnMuRPraOdfkFw7B+Xqy+gcfjwwD4M=;
 b=cxUL3irOJ6oCzDhBXJv11JuBOycesupK+IGB5bgFG4isP5T6d0o+17k6XUe+Q5LO0UI8Ux1/w/lW1ZiQEhPZou8qsTVh8xG5rZ0stYMzARb11PD8MHnT5ER98O3b+hSGXLMQdrKLs6VCx8mF8F+eceYg+hUlv7kGRUF99QGivbWNe0eemi/TwPwpR2lHoAgxQZ68GzEswfaBn003vF+fKDbUrpI9gGWTtU6cwqvVC9e4Um/G4UTH5swGCphgAYV4zd3D4x/Q/Td3rt6jIRCvHWPzaPYo0pmTe0eCVcPA68vEIxMd3kLw+GhsTK2rbY28zKU5Y95EQuQoAeigEsYtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSnUWuosl60NLmnMuRPraOdfkFw7B+Xqy+gcfjwwD4M=;
 b=A3Cdz9jNpaVrzRWSUBAX4ROlvo8nP5GcqDYIDPTUwUjDBnLdXZFlQ6nhoP9JegOve/ElupInqrl8uXevW42Len9y626hIXHjr4gtEwUFlmDFi2wCvGy8b6CUgeiZ8HqJj9A80Fxeqwn/V6PDSKJ1gBZIMuJhe3UqVbF0o4yR2pQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Mon, 28 Jul
 2025 16:12:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 16:12:02 +0000
Message-ID: <592f29f2-b107-482b-a2e7-2c440e011cac@amd.com>
Date: Mon, 28 Jul 2025 12:11:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Fix checkpoint-restore on multi-xcc
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Rajneesh.Bhardwaj@amd.com
References: <20250722174712.450292-1-David.YatSin@amd.com>
 <20250722174712.450292-2-David.YatSin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250722174712.450292-2-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: f949d629-b007-4f20-4c4d-08ddcdf17c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3MrYXE3S2FvbnVkOEY5L0QwaERrY1VKNFczQTcwMDRjK0MxZ0RyS2NEYW52?=
 =?utf-8?B?TVUxNVFrNTdpSzVQYWZpcStLaFYzQjFUMTlWSFhMYUJxZnFCZnRFeGNJSU52?=
 =?utf-8?B?ZEUzcUVVMGVxNWVMckN2Qm9hb0JlRTluTERlaWhwOE1RN1IyRzFoNy9aemQv?=
 =?utf-8?B?WGx2UGxHeXh3SjBuT0REVFFPVXNOK0pCb2FBQ3R2SG1ldHdxaUZ3ZHJUWkwx?=
 =?utf-8?B?M3c5Z2VrMnptSkR3eTllaUVxSHBBeWEzV1ZBclFsYUtpUWl2MWpEVUJYSkpl?=
 =?utf-8?B?clpYOUh4UytKbnR2YWV3SkVNWHpmMitEazIrOSsvVDBtY2k3UkRnNlJ5SE1z?=
 =?utf-8?B?TEZwbHlLQlF5RWlyOCsrV09lUnlxTUxPZ05qcndwa1RIdVhxSWdrdHZtOUgv?=
 =?utf-8?B?MW44RUNlWExOK1ZMR2E1Q1NKNU5jK0hINEM2dkRXSHF2VGk2aTgrelI3KzJa?=
 =?utf-8?B?UFN1dHpiOEhEK1l5OGJESWtxYi92ZGxnWDAvV25HeUtsSTNRMjBpblluR3JS?=
 =?utf-8?B?aU5sb2hGY1hhMXRHS1doQnh2ZDVvSG1JRGlUeGphT3pwSURsYi9UQ1dVeCtj?=
 =?utf-8?B?MU5WSE5SNWRkYS96YlRiVXd0MjI1MlFTeFg2bXpYQm9LNk9JNk9ZOGdocEpY?=
 =?utf-8?B?b0UreU5qb01KWW1kUE9jdXpkalU0dy9HM2tENmdIZEZTKzgzb2M3L2c0dktl?=
 =?utf-8?B?V2ppaDYrc254bVo4Nk52aUpNcUNLbEV4aWlGUlBnUmJidFBVaVMzZWxwNWpn?=
 =?utf-8?B?ZENpV1U3WGhpSU5hOWNPT1pEdVZZejVhTUkrUndtQnk5Ti9rYm9ndkZzdm8v?=
 =?utf-8?B?NFVDYzhCS1AwbGVra0VBajBmeGpURDloTzluV1BlMkExSzJ2ckQwZ0tsYjlN?=
 =?utf-8?B?by9RSDBSZEJKZGlqbzJBM1F4K1VLdjZPU2pFcEp5QUtZL1BTb1Q5VkdvQjVI?=
 =?utf-8?B?NUY1SFNNdTNybHVjUDlaODNNL2tZMGlWWEpZZXdHK28rS3JJOUczWG4zU0xq?=
 =?utf-8?B?V0dUT2dTYmRoT1MxbUxvc0FLWTVTYTJrdXE5bDZ3aHdHMjNxdDY3d0luanlD?=
 =?utf-8?B?d3lUL0M2N2FCcW8yVWwvUi9nT09kQzFFelJYc1pXbTlCZ3JFMWkzOEVSS2t3?=
 =?utf-8?B?QWhXSzhLalhQenRyWEkwa2NtZlhMK0V6MXdac2ZIeGVURjNvVjAyeTRBeUlp?=
 =?utf-8?B?MHlSUkNMZXQ3N0JMTUw5VFBmVk9mRWVwcUVrUUNGSFJIVmVTSnlkWTlCRE5W?=
 =?utf-8?B?OWYyWUtEN3NkSjZEMUVVT1Y2emYwNm9RajdYa3NqSFBKKyt0aWpKbTEvTkNn?=
 =?utf-8?B?WFE1aDVsNEk3TTh6OWhISW1WQWt1bGx5NzZ2cnpCMGtrTXFVTXc4b3NIR3Uz?=
 =?utf-8?B?WnZTTExRVFBhZHhibW9TUW1nejRjNnI5TWJGTE1YZlBwYTZCNTJmWmlNN3F0?=
 =?utf-8?B?TlpRcCs4WHRnU3JHTE13R2h1UnFVdjBkb1FkbjF3QTd0ekh3WHE2VFhxdTEw?=
 =?utf-8?B?aVVyU3lKL3dJOVMvdVZ5RTRPeklaeFZ4dktPUEhsS0RlT2FBc3NQVW00M3Fz?=
 =?utf-8?B?b0xiMHpSWGhHU1U5OXUzUEZWSjhYUUFYM1Q3WUpBR0VKRVh1WDBxNEF6OXlN?=
 =?utf-8?B?VTJ1L2pVZDE0RUVvVFlMZ3d0NDBKaU1yWjBvcFBGWDJQWWVjd2ZGanF2WHp6?=
 =?utf-8?B?SUErZm9Sbk1DZ2dOb0FGVWRNZ0hjampEbTNnRTFZNk9oNmpTdFlGSDlna3lp?=
 =?utf-8?B?N3pKVUpqMFVMRURmc1V3RHRCMWJIa0pybnB1R1lKTVdiTm5kczB4Qk1zblZK?=
 =?utf-8?B?Z3crTEhuNVBMRDAzSkdlR1FNb1hqWVlZOEpwYTIvWFNmOVE2Z3JHQU1XUmpj?=
 =?utf-8?B?TmpwUmFLWnloaGttNmZCRHBsT1hxcVlXWE5nRDNrK3c1UHZ6YVJ2MHpob3hB?=
 =?utf-8?Q?t2wdesBEqgI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlucDE0SXFxQTRHTFp6RlNIYWROc01DTlk3UFV0MFpzSGRFVzZ3TERMRHB6?=
 =?utf-8?B?NHNnV0JXcWJ2bi9RV2dMSlk5bHRCRXNnVE1JRzdFTGcxQXphV0tJVmV6U2Yz?=
 =?utf-8?B?cmRWbU1NWEhQMXFkb0xRc2tId2Vtd2I5QWdUQXF1V2xidWxrTjNGcEtSM05t?=
 =?utf-8?B?ZWhXdG5IUnZDVDVhYXFCS0xRcHg1Um9QbnJnTVdHSHVOaGs5Ukd6dlQ4THph?=
 =?utf-8?B?dVlZNEJxcTQ1YmZ3YmxaUVA5anJxTElCc1JIUndybWhBRXAyZzROOXhweDRw?=
 =?utf-8?B?SjZ1V0xGT3NKZmJMU0J2WC90REdrQzl5SlhITHc5c1ErS3R5bThYWGoxcm5u?=
 =?utf-8?B?aUhQYkdPbXY4SE1uWXcrWkxqMGJJSHNFcnFEMG5ENVpjVHBrVjJLU3JaMEpo?=
 =?utf-8?B?eEE1NE5xcEpQUGZnc3ZRQkJwdXhTckZHb2hYYW12NC9IN1BrMHdadzZSZkdB?=
 =?utf-8?B?MjhMZUU5UXlzZnUrQjdwM21YdHZzNHZkcnd5aDRZUlFQSGgwMmZKR1VJUVpZ?=
 =?utf-8?B?L0MreVBQVzNhQkp5ZDZ4bVJkbFdmeDYzTm1QZDdWRmorb280TjdJcjVKbFhl?=
 =?utf-8?B?eVBIaWhZM0pvYllvUHFYcUd5cEJKZFJyby9PeEU5Rm5aaldSYUFldkdVcFF3?=
 =?utf-8?B?anFyVG5oeVJxUFZHaHZCdzJqMm5INUpKVHljQTJKemh6WEV6VUNhVm9TYnc1?=
 =?utf-8?B?RlJPaFY5UWFTU2N0K0s3SHVGNVJDbWVoenp3OFhGTUhVKzZ6L2IyZXRHYnBo?=
 =?utf-8?B?QUQxMngwV0puMWZVckJYYSs2dDNBa1ZPUU01N3l5U2ZNN0NVU2tPRkNQOVJX?=
 =?utf-8?B?WTdXTTB1cjlIbUN3ZG5yclR3eUZuMmRtTEUwbUdpbVE0TmhWS250ZkVaaUZM?=
 =?utf-8?B?VkFTZEozdHdCWFN0cm1tZExJUzhoZkdrQy9xSEZzMXE5OHVyekNpNktyMUFZ?=
 =?utf-8?B?TG0xcFFRa3VReDFwcVp4VXN2by9jNHlsQ3ZDZUVOZ1lGQ1VmK1VCNzNsbUM5?=
 =?utf-8?B?SytIN1NLeUt4SkdLK1MrMmQxM29rLzd6OUhlT2NKMld3T3BLUUhDL01NZFlV?=
 =?utf-8?B?QUtZRS9VSVVtQXF3QUE5T2paU1V3RXhBTVhGd3Y3MmhneHV3ZHkzVTFYMlhk?=
 =?utf-8?B?b3FvUW1lMkc5WVJtdEhPbTgvWHRBT21xNmh6WXIzNHRKbHhOMHlQaXBIZVhS?=
 =?utf-8?B?RU1hazZ0RGM0NWtDWk43VDdjQ2tiMzBxRHp3ZnRHV01PVG5Ddm5pN1RWVmpv?=
 =?utf-8?B?UGVnVHVCM1FPSXdPZzRYSnVjTUZjUEQvaGpabjFaMU41LzQ2R2ZRYUsrWjBa?=
 =?utf-8?B?WTFkL0lkRjJTR1FMOUVteUR2MmJ6TFZXVFlRVnRKNktBVXVpeVdibHFBejhK?=
 =?utf-8?B?VU9wVWVQZjh2dTVFSG1YTlQvVWJmNGVwUUppVldQOXI4dmpLamg1Nk5iZzdG?=
 =?utf-8?B?dVZVNWZhT3hPcmJ0cE1SSXBRUDROeHlmUEhHT3FEcUpreXpzMXhXaTlFbmxS?=
 =?utf-8?B?anBjcFVUNGpiUXR6TmQxN3ZOYlo5ZE1TRzBOc01BdUExeUwvZ2RrQkIwczY5?=
 =?utf-8?B?aGt6VjgvRkhhdTNXTnUzYjJzM1E1QU1aQzFaSXQ2NzkxNjRLT1NOSWxMdGM5?=
 =?utf-8?B?WkExdzRuTGI0eFlIVmZ0aW9LME94NzY3QXJJalpTcEtkS2RtcGQzc0hPZjM0?=
 =?utf-8?B?UWwxRXBJZFJpY29sNXBMTmtFV1l3K2xwcnpVV3NNbCtkZ05yd244YmRYK2Fu?=
 =?utf-8?B?ejZ6VHIzS3VzWUV5VnUva1d2WGxtSmE0bzR0UTF0U3Q2bTYvOEZIQnFxb3ZI?=
 =?utf-8?B?ZFBJMUZZcHMwb0JKMmxnNEowNFpjMDlKV0ZMdVBEdGJGY1Q5R2kzOHI5NHVE?=
 =?utf-8?B?MTRUNkN2WklIMnV1R2JQZG5yZzM5czRIeGNPUGZjN1BVT1pGNFpCVTJRdlZQ?=
 =?utf-8?B?cFhxZE1pQm95YmNDZ1FndGQvV1N0M0laMmNrZG1SUFBYSlFQUVZlL1JVT29X?=
 =?utf-8?B?OU92QmtpY1lQanFQaHo4YjRibG5Ha2oralh3Vmc4cU1qYVdpMlFFTnU2aHp6?=
 =?utf-8?B?eDZDUzNyaDEvK0ZlbDFDbGdqVnpsSVpaYzlsUWV3eGRIMWtYTGd3bjM2b0lZ?=
 =?utf-8?Q?Jhwg0JOSgSTu/a5V3YCTmUdEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f949d629-b007-4f20-4c4d-08ddcdf17c96
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 16:12:01.9829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtRUwTJsRCf7F7YL/jHOr7Air0XiwjbGHb3E8wKgdwHr4pvj5qNnE+WeTF5hTVdp8IU37GyFg9TZmzi3+Vmfrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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


On 2025-07-22 13:47, David Yat Sin wrote:
> GPUs with multi-xcc have multiple MQDs per queue. This patch saves and
> restores all the MQDs within the partition.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 61 ++++++++++++++++---
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 20 ++++--
>   3 files changed, 67 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2d91027e2a74..6c5c7c1bf5ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2725,7 +2725,7 @@ static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
>   
>   	dqm_lock(dqm);
>   	mqd_mgr = dqm->mqd_mgrs[mqd_type];
> -	*mqd_size = mqd_mgr->mqd_size;
> +	*mqd_size = mqd_mgr->mqd_size * NUM_XCC(mqd_mgr->dev->xcc_mask);
>   	*ctl_stack_size = 0;
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE && mqd_mgr->get_checkpoint_info)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 97933d2a3803..f2dee320fada 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -373,7 +373,7 @@ static void get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stac
>   {
>   	struct v9_mqd *m = get_mqd(mqd);
>   
> -	*ctl_stack_size = m->cp_hqd_cntl_stack_size;
> +	*ctl_stack_size = m->cp_hqd_cntl_stack_size * NUM_XCC(mm->dev->xcc_mask);
>   }
>   
>   static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
> @@ -388,6 +388,24 @@ static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, voi
>   	memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
>   }
>   
> +static void checkpoint_mqd_v9_4_3(struct mqd_manager *mm,
> +								  void *mqd,
> +								  void *mqd_dst,
> +								  void *ctl_stack_dst)
> +{
> +	struct v9_mqd *m;
> +	int xcc;
> +	uint64_t size = get_mqd(mqd)->cp_mqd_stride_size;
> +
> +	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
> +		m = get_mqd(mqd + size * xcc);
> +
> +		checkpoint_mqd(mm, m,
> +				(uint8_t *)mqd_dst + sizeof(*m) * xcc,
> +				(uint8_t *)ctl_stack_dst + m->cp_hqd_cntl_stack_size * xcc);
> +	}
> +}
> +
>   static void restore_mqd(struct mqd_manager *mm, void **mqd,
>   			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>   			struct queue_properties *qp,
> @@ -764,13 +782,35 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>   			const void *mqd_src,
>   			const void *ctl_stack_src, u32 ctl_stack_size)
>   {
> -	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
> -	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
> -		struct v9_mqd *m;
> +	struct kfd_mem_obj xcc_mqd_mem_obj;
> +	u32 mqd_ctl_stack_size;
> +	struct v9_mqd *m;
> +	u32 num_xcc;
> +	int xcc;
>   
> -		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
> -		m->cp_hqd_pq_doorbell_control |= 1 <<
> -				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;

Is this special handling for SRIOV no longer needed? Maybe it's enough 
that it's handled during queue initialization. Then checkpoint and 
restore just preserves the updated doorbell mode. Other than that, this 
patch looks good to me.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +	uint64_t offset = mm->mqd_stride(mm, qp);
> +
> +	mm->dev->dqm->current_logical_xcc_start++;
> +
> +	num_xcc = NUM_XCC(mm->dev->xcc_mask);
> +	mqd_ctl_stack_size = ctl_stack_size / num_xcc;
> +
> +	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
> +
> +	/* Set the MQD pointer and gart address to XCC0 MQD */
> +	*mqd = mqd_mem_obj->cpu_ptr;
> +	if (gart_addr)
> +		*gart_addr = mqd_mem_obj->gpu_addr;
> +
> +	for (xcc = 0; xcc < num_xcc; xcc++) {
> +		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
> +		restore_mqd(mm, (void **)&m,
> +					&xcc_mqd_mem_obj,
> +					NULL,
> +					qp,
> +					(uint8_t *)mqd_src + xcc * sizeof(*m),
> +					(uint8_t *)ctl_stack_src + xcc *  mqd_ctl_stack_size,
> +					mqd_ctl_stack_size);
>   	}
>   }
>   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
> @@ -906,7 +946,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->get_checkpoint_info = get_checkpoint_info;
> -		mqd->checkpoint_mqd = checkpoint_mqd;
>   		mqd->mqd_size = sizeof(struct v9_mqd);
>   		mqd->mqd_stride = mqd_stride_v9;
>   #if defined(CONFIG_DEBUG_FS)
> @@ -918,16 +957,18 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->init_mqd = init_mqd_v9_4_3;
>   			mqd->load_mqd = load_mqd_v9_4_3;
>   			mqd->update_mqd = update_mqd_v9_4_3;
> -			mqd->restore_mqd = restore_mqd_v9_4_3;
>   			mqd->destroy_mqd = destroy_mqd_v9_4_3;
>   			mqd->get_wave_state = get_wave_state_v9_4_3;
> +			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
> +			mqd->restore_mqd = restore_mqd_v9_4_3;
>   		} else {
>   			mqd->init_mqd = init_mqd;
>   			mqd->load_mqd = load_mqd;
>   			mqd->update_mqd = update_mqd;
> -			mqd->restore_mqd = restore_mqd;
>   			mqd->destroy_mqd = kfd_destroy_mqd_cp;
>   			mqd->get_wave_state = get_wave_state;
> +			mqd->checkpoint_mqd = checkpoint_mqd;
> +			mqd->restore_mqd = restore_mqd;
>   		}
>   		break;
>   	case KFD_MQD_TYPE_HIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index fe4c48930aad..bae200035ff4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -922,7 +922,10 @@ static int criu_checkpoint_queues_device(struct kfd_process_device *pdd,
>   
>   		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
>   
> -		/* data stored in this order: priv_data, mqd, ctl_stack */
> +		/*
> +		 * data stored in this order:
> +		 * priv_data, mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
> +		 */
>   		q_data->mqd_size = mqd_size;
>   		q_data->ctl_stack_size = ctl_stack_size;
>   
> @@ -971,7 +974,7 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
>   }
>   
>   static void set_queue_properties_from_criu(struct queue_properties *qp,
> -					  struct kfd_criu_queue_priv_data *q_data)
> +					  struct kfd_criu_queue_priv_data *q_data, uint32_t num_xcc)
>   {
>   	qp->is_interop = false;
>   	qp->queue_percent = q_data->q_percent;
> @@ -985,7 +988,11 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>   	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
>   	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
>   	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
> -	qp->ctl_stack_size = q_data->ctl_stack_size;
> +	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE)
> +		qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
> +	else
> +		qp->ctl_stack_size = q_data->ctl_stack_size;
> +
>   	qp->type = q_data->type;
>   	qp->format = q_data->format;
>   }
> @@ -1045,12 +1052,15 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		goto exit;
>   	}
>   
> -	/* data stored in this order: mqd, ctl_stack */
> +	/*
> +	 * data stored in this order:
> +	 * mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
> +	 */
>   	mqd = q_extra_data;
>   	ctl_stack = mqd + q_data->mqd_size;
>   
>   	memset(&qp, 0, sizeof(qp));
> -	set_queue_properties_from_criu(&qp, q_data);
> +	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx.xcc_mask));
>   
>   	print_queue_properties(&qp);
>   
