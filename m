Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B78E7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 22:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C92C10EC2C;
	Wed, 11 Dec 2024 22:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qtsYv7v";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8AD10EC2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 22:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYGiyaFJ94O9m6qWSBNZXeiCQnNxnXVx5X69Jtha+gDzKD7vsSUkVd6srAH/ZNTiivZsSaY8gcuTWsVLUiFeYSjuZJT2O7NVlo64B4kUTPd8fS/15T7DPH6ea0ykLOB0fKucSJQRAZ5gWXdB2T4dvmDcLYpUnM/la5/c4O527EEVoTZh1oACUjdEXHaOa0XyxSzJyk334wy0oDcpDPDn5n1qQvjO6HLR9HivQvtaZ+xN2ll6xjZ6xkkPgpPTN8I8eJmkJmigXY3GezQPpb/yDgmcGot9I+jGmtqYm4SOPwFHTIVp72cVMoU5y+NavUYr5VTmS+aa3aEaq45d0L6KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq2VyXm9BxnHrBALB5mOCZ9yv61woiMs/rbk9yCGmyQ=;
 b=S64lBpzS4IZsrLBkvcwVOBqMohliTuVSsUz400xp8LgPpuCcfl2+bkqiGlVsspm6sT2guL/8EACWj9Y0p0WWI++sKK+o+vzxMMcr11okQA8lWFhRnoEGy6N7m8usvcnRFftxSxuTtrri/h7caw23cIkPDXi7axFUFtgOz57V84KZsxcfKYvK0O9Cui+KUDRqs86gQvc8oWjfgj4MroGkTFs8R5q5xJIGxH7MDvsfD/KDNRweVIgncAZA+Lq4AtzwXOvIZE0lkxMV+43XNBmGVk6V8tv75VN7Ms/DFukia+0vJMWktNSLw1lM8/RdEFqoVPh1kajVnjousPn7A0ZP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2VyXm9BxnHrBALB5mOCZ9yv61woiMs/rbk9yCGmyQ=;
 b=3qtsYv7vnZObshGmBzaiWlAALKfWHuafs/eWHlu1RPVdjr7aNOFaVTxWxzvtC++EDMZaaE4DiCfWlUihF4CPj/FKRSBmTcqjbWQbuVA3eCGUFatFQit+PTpingfcjF1i3q3NXQS/vmiZOnRZWaMkSJ/6oIOM45GdGht7qCySPO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 22:03:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 22:03:09 +0000
Message-ID: <6b799448-a647-4311-81ee-088de33a87ef@amd.com>
Date: Wed, 11 Dec 2024 16:03:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Require CONFIG_HOTPLUG_PCI_PCIE for BOCO
To: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Gabriel Marcano <gabemarcano@yahoo.com>
References: <20241211155601.3585256-1-superm1@kernel.org>
 <CADnq5_PxZP4fgMcuD0xD3m2Y3_kbOV_wK4Qq4GzGHJB_9wxepQ@mail.gmail.com>
 <820bc463-80d7-4121-837d-b620bfa67575@kernel.org>
 <CADnq5_ORSYTV1yLXhmWvaxwi_F9QfOWMzjzFHFrNvF5DCjZ_xQ@mail.gmail.com>
 <848196f8-2318-4a69-8e1c-7f534bbdb00d@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <848196f8-2318-4a69-8e1c-7f534bbdb00d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0122.namprd11.prod.outlook.com
 (2603:10b6:806:131::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: dc623c18-5a28-4bab-ea06-08dd1a2f9964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmhZMCt6U1RwamJRTk00QTk4SmozYU5nWkROT3A2VTlnSk0vdnlwODJPc05Q?=
 =?utf-8?B?SWZ0TGErbVgrdGNTOW4yMFhIcmwyZTh2YktlM2tGTkQ3dHB6bW96Z1dIMWoy?=
 =?utf-8?B?WnpPdERKU1FBSnEwNXZqMGhPb2V2Y2JudzJuRzNndTdldXEwWDBwc25PU1Bv?=
 =?utf-8?B?blpGVEdiT1lDRjl2dkFEazR1NmJQeXhEMllPMnJpMjhhZjE1a2tEdGlTQWVx?=
 =?utf-8?B?TFplZmdFUUtlamt0UUpuVTRFUDNYQk5BM3gvbWFJU1FnNGExNDBtL3BnKzVU?=
 =?utf-8?B?Tm5xSyt6RzRZY0syRDVBMkxOYURTYWlDdm9CV3VoOTgrcUxtL1ppakxxa1c0?=
 =?utf-8?B?VWV0RTRhcmxReUY1L25oQTlxbkt1QmxQaUdtUmtOdklObEJmSjY1UW4rQytr?=
 =?utf-8?B?Slg1SkZLNEdhVk5sRUQrQVdJN2RZdFNHbDdKTjZPeUJRd1dJRWZPTzl4UXgr?=
 =?utf-8?B?Y08yNzJ0QVltVkRmSDl0OWw5RlB3R0VSaERVeVVGNjNsZ0pBZktOWVNwVzFC?=
 =?utf-8?B?bWUzcld5OFArOGU5T2d4ZnhkaG4xQTFrUHVKS0UyUVovUjRCcE0wWnVscFRw?=
 =?utf-8?B?S0poV0xCV2tlR0Q4djRaaENTSnNUS0xleDRXRWRBRlJSTGhCencwV25NaWFu?=
 =?utf-8?B?TkpZbllWeGg3QjA5eDNMdHhJV0xZa1FwdWllcFZlVC9oSnQzVGxJY3lpOGhR?=
 =?utf-8?B?Z3NMeml1Q2xJUkJmNmhHbHBYUm5BZEp3UGdhSGR5dlZPYzJaOTlnNEFkUlBQ?=
 =?utf-8?B?SjBGRmswcHJQcXhSWGdZcmNOcFZpUlp3eXFYUStUcmx5N1loZUs1SjJBVWpS?=
 =?utf-8?B?cG5NTUxsRENNU1JSY1poekNaUGtKZldFcE9lU2oxUFZpdk8vUkRsa2doRmhV?=
 =?utf-8?B?WXdvMmNzOGdNOXF3Y1FidDVON2xSUVUvWUhGY2lPMmJ6QTlUOFkyRHh2Vysy?=
 =?utf-8?B?R0pUWDZmSkZ0aUxBelBNKzlvcS8vd3N6KzNoK2U0QWFsblNFR1dvNFkyeGZy?=
 =?utf-8?B?eXZxSXBJSGM1R1dsT2l2UUhqRGd3RVBXNFFlNTZqUWRmYkp0ajkva1p3NDRE?=
 =?utf-8?B?ajlLSStMZHJ3ZmhRSzdlSmxSNm9Pazk1d3NGTlA0aUpNRC9GSnBJaFo5eURk?=
 =?utf-8?B?MUYvaW5HZXNTT0ZxcFlQUGpuSzY3VXpmVVpSSFYzSklaL0ZoNkdHVVhjQ1Bj?=
 =?utf-8?B?THRXYjUyaWJiK05VRmJ4cVlpcVVHeUxOSHZESHVEdDhNN2Z1T1ArVmx4Vjdo?=
 =?utf-8?B?V3d4c3F5Rkc5UzZvUVlYNW9FN0JLRHlLZUhFUW1HSmFqYU1pd3ByU1FXWk1P?=
 =?utf-8?B?ZWFNNENlenlRTFlkZnU2WFllenVBU3RwVXJtQThsSDlKMWpMUWx3Qm5RY2RC?=
 =?utf-8?B?WW5KalRMbzQ0eldlbTI3SVNGRHNoTlMzWXhRSnhaL1VMNzlPS1A5d2NTNDBJ?=
 =?utf-8?B?TnhlSUN1TE5nZ3ZBV2tmNEx6bmhtb21YY25BZjg1QTlBMnhNTmNCbTlYcytO?=
 =?utf-8?B?RCtMZDB2WTd3RDlnd25FSUVhK21oZVB3dnZBTXhITnlwWTl0VTBncEN3dEdT?=
 =?utf-8?B?a3RPM25FU095VUFUdU1BT3FldlViUmJFVEwyOUJacytzOCtLUEsyUEVLTGJB?=
 =?utf-8?B?OTAvWjB3dTlPekxOeVA1bjNNeVBwVngrTnpQZzRYYlhtbTMxMmkyUC90Qm1q?=
 =?utf-8?B?QTNsc2crVkdhajRMbXk1WDlNMXZvN254bllKbVFjbnIydG0wOXd5ZWhYeTVX?=
 =?utf-8?Q?6+/w/YpFaLYHVm6q8Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNIMXJ6eTcrOUo1dDlRcklXMmdXU3VtQkpYSHNNOHphODhnVWJtaEtYc1Jw?=
 =?utf-8?B?aWxnR2tlUW83eThSZk5PbWwxR3R6ZzREeE9zT2J1dkpXaGIyWWh2S0dpVkN2?=
 =?utf-8?B?b05pRVczNU5qVkxvUFo0eUxPcGRkT0ZudnorMHN4Q0U5cWc0Y2l6TDlBSFll?=
 =?utf-8?B?OW4wMTRBNDMxSEtVanhlYU01elV0b24wVXZMN1BsQTVUYWhoWVppbmd3WU1B?=
 =?utf-8?B?YVViQjZjZWFpWFh0K1lqRmNlRUUweitLZTJacmRFcnZKOHd2SVg4ZThKZmlr?=
 =?utf-8?B?WUQ2azBlamVyb29vb21Ub0xCdnF4VmNPcW12aGJnSEpLRFRVdytIbVJjTkJY?=
 =?utf-8?B?TU43SG5aVTVMWFZQNTQ1bGR1enNXZHpQbUZUVzJnQXdWbTJlblZBYWpkNXpL?=
 =?utf-8?B?ZkY5SlYyc2p0bDlmZWpza2toZTFaVlJnb1loVGhWL1U4UlpabWpzSERoL1FH?=
 =?utf-8?B?YVhYd0dMSGpPY01YNFNIZHFqbTlKQ0Z0UEFKekUrOEo2empFMWM1QlNMbTkw?=
 =?utf-8?B?OGd0Wkdmc29DT2xJb1BpTGk3RHFkbkFGOHdYY2lCY3VIUTU5NmdRbDhvYlkz?=
 =?utf-8?B?cFl0MlRMdy9TMGphY3RDYnJYMy9KZnYvMHNpNTlXQURIRC9mcU4wNG1ZTXdt?=
 =?utf-8?B?VHJZeTdNOVJLYVNzNklsM3R0VXB6RVhkYVQrYk1MdzJTOVJySHVrZG9qMW1k?=
 =?utf-8?B?OHBjclJKQUk4b3VOcXEyaHlEM0lGNkUyTHRISDJGZktKSCtZNjU3TklnVGk1?=
 =?utf-8?B?cUVhOWk3YVNKMnJlZHBmcnJpa0RxQkVOVmd1NmduS3RGUFpCZTYwUHFtTm1O?=
 =?utf-8?B?K1ZMYUp3K3VScGF0S3YvUFRwL2tZd1BuSStxajJvOEhTNjRXUURUeVB2c1hy?=
 =?utf-8?B?ZlpBRGNEN2dZeVR2S1h2UXphWk10RUxicEdOSWlTd3J4RlFVQUxha2RHN1lU?=
 =?utf-8?B?Nmp1dkk3VXd1bEdhVi9NK2Fsdm1nNkllV2hvU1pNK3cvOUZOQzE1c05pNEN0?=
 =?utf-8?B?Mjc0MkN0LzRiUWtORThVa043S04rck9aSWNhMmtzcUorZ1EyVURyZUF6emQv?=
 =?utf-8?B?a01uWGlpcXhaQUFkdHl6K3ppUkRtWHkrV0hSekFpL0pXVzlhQkJveWVHakg3?=
 =?utf-8?B?Smw5SVg5TlZUUkJxTWt0eHZUYzF4MEo5bmloV3ZDT2o1dS9jbGowc2lqQzVy?=
 =?utf-8?B?WVFlVTFtK2NKcXFFYU5HTENRM3k0b0xjZ01paW5iaUtCWmd0SnBoS1VwV0dV?=
 =?utf-8?B?NjZSclo1UWNyMnI0NlBPOU96bUxVck9NemNrbFFhZTB5T0pVVW03V1p2WlZv?=
 =?utf-8?B?L3BkYk9CWDBXS3R3V1FVaXdtNEFIbXVwUWpVUjNPRU1RK0RyRzJnb2poc2Vy?=
 =?utf-8?B?MTFSbDV2U1BsK0V1VWpWd2cxVlNvUFZVQVlGQmIvQ0ZJNXM0SnBjUEc5OFJt?=
 =?utf-8?B?MGREUXBlYzVjMHNoaCtscVlvY2Y2ME96WWYxWGw4ekN2VXhUQi9DN1RuL1hI?=
 =?utf-8?B?K2hmRERBQmN0dXpJZ1NFeDIzU1JpWHN5UW9rbmpPQjFiZ2crTFZSRVl2U1JY?=
 =?utf-8?B?dldoOWxtdGpkNHZrT3pKejgxRkFmODFFNGpBdVBNWjZUcmNLa3N4T3Q0T3BI?=
 =?utf-8?B?TTEzUE85UUp0MFNDZU5FWk52VlhSSzVkcm9ycHJ5VnR0RGpNNGZob1VLTGZY?=
 =?utf-8?B?VllLMy9FYmV6UkFaSjVPUjZKVmZoZjNVTlRSclE1OFkraFkzSHQ1SW1sYm9a?=
 =?utf-8?B?OXZVbk1aSURMSU1oTjRjT3FMTm1sSzZLdFk4bTBmUzY5N0lRdEprL1M2dlQ1?=
 =?utf-8?B?TUJyeGNTNjBDeHQ0R01CTmRYODlzKzJCSDhwOXdNckgvVHFONUg0a01STkdq?=
 =?utf-8?B?NHdxd0RJbkdyWWQzaXpYUVFGcUlHdVUxZUZ3SjA5Y1FvTitJbzE4M0JSNWs4?=
 =?utf-8?B?NzJyWTZ6Q1cyK1RkWnBmeGpDQ1Zub2U5cHdxUFdHc05laHpvcTBBSzJZNmVv?=
 =?utf-8?B?bUJIUmZ2ZnBqUFM0ckkwSVdLTGNKVW1GSVNjRGEwVkkra2h4Qi9kalBDOHN2?=
 =?utf-8?B?aXV1Y2w1cWx1VWxTZzRDc2U0ZzNrVHhSZm9rK2FPSjVzenp2dWNIdFNQSHRV?=
 =?utf-8?Q?ksvbtvO3FAVKkh9Ix2nd6DFJg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc623c18-5a28-4bab-ea06-08dd1a2f9964
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 22:03:09.8151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ewas04LdpHpO6ZbZceUgIR4hEbUdfcrg8vOkMvrIxEw6SYzHAt4+Tlj9pdVX59pcz/055gGozerxFC4iIMZcPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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

On 12/11/2024 15:43, Mario Limonciello wrote:
> On 12/11/2024 15:41, Alex Deucher wrote:
>> On Wed, Dec 11, 2024 at 3:19 PM Mario Limonciello <superm1@kernel.org> 
>> wrote:
>>>
>>> On 12/11/2024 14:08, Alex Deucher wrote:
>>>> On Wed, Dec 11, 2024 at 10:56 AM Mario Limonciello 
>>>> <superm1@kernel.org> wrote:
>>>>>
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> If the kernel hasn't been compiled with PCIe hotplug support this
>>>>> can lead to problems with dGPUs that use BOCO because they effectively
>>>>> drop off the bus.
>>>>>
>>>>> To prevent issues, disable BOCO support when compiled without PCIe 
>>>>> hotplug.
>>>>>
>>>>> Reported-by: Gabriel Marcano <gabemarcano@yahoo.com>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/ 
>>>>> issues/1707#note_2696862
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> Thx.
>>>
>>>>
>>>> Seems like this should affect any device which supports d3cold.  Maybe
>>>> we want something more general as well?
>>>
>>> Any specific ideas?  One of these two hunks I think make sense, leaning
>>> upon the second one more strongly.
>>
>> Actually, I wonder if the affected hardware pre-dates d3cold and uses
>> the old proprietary AMD ATPX interface to control dGPU power.  In that
>> case, the d3cold is managed by the driver rather than the PCI/ACPI
>> subsystems.  IIRC, there was a workaround in the PCIe hotplug code to
>> avoid calling the pci remove function when the driver powered down the
>> GPU via ATPX (or the nvidia equivalent).  If so, this check should go
>> in amdgpu_device_supports_px() instead.
> 
> Gabriel,
> 
> Can you please share a full kernel log so we can clarify which method 
> your hardware uses?

Actually he shared it to the bug.  It's BOCO.

https://gitlab.freedesktop.org/-/project/4522/uploads/5714f4562de8ffeb7d38f70eb7d51d85/dmesg_with_flip_done

Dec 10 22:45:07 localhost kernel: amdgpu 0000:03:00.0: amdgpu: Using 
BOCO for runtime pm

> 
> Thanks,
>>
>> Alex
>>
>>>
>>>
>>>
>>>                                     diff --git a/drivers/pci/pci.c
>>> b/drivers/pci/pci.c
>>> index 0b29ec6e8e5e2..01691f1d26fbe 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -2751,6 +2751,10 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>>>           if (target_state == PCI_POWER_ERROR)
>>>                   return -EIO;
>>>
>>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
>>> +           target_state == PCI_D3cold)
>>> +               return -EBUSY;
>>> +
>>>           pci_enable_wake(dev, target_state, wakeup);
>>>
>>>           error = pci_set_power_state(dev, target_state);
>>> @@ -2797,6 +2801,10 @@ int pci_finish_runtime_suspend(struct pci_dev 
>>> *dev)
>>>           if (target_state == PCI_POWER_ERROR)
>>>                   return -EIO;
>>>
>>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
>>> +            target_state == PCI_D3cold)
>>> +               return -EBUSY;
>>> +
>>>           __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>>>
>>>           error = pci_set_power_state(dev, target_state);
>>>>
>>>> Alex
>>>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>>>> gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 764d41434a82f..7db796ebb967e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -419,6 +419,9 @@ bool amdgpu_device_supports_boco(struct 
>>>>> drm_device *dev)
>>>>>    {
>>>>>           struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>
>>>>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>>>>> +               return false;
>>>>> +
>>>>>           if (adev->has_pr3 ||
>>>>>               ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>>>>>                   return true;
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>
> 

