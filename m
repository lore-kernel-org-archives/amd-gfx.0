Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7F6C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 14:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1911010E3A6;
	Mon, 21 Apr 2025 14:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0InOWgF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE1610E0DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 14:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W29knFHZIOrOC7n972L37VVoR83BGWq8z/GiOHv1GgY9qXeJooH3L+Zx5hMIqDHOLpK5ge6Q9vZHdAht8GKXYHP2syD4+eqkUCyGCqXF2Umy4GVtMvb5c8T2BLNsRaIV8ejU6qWvBNuM1v1DfXdfLKwN+RxucPhEPXDiCOiJ8Dw3Xii9n1U5oobO9uPvujAvh9xl0KwpyQHCuN+3VJCyHut9/v+2gMm8LnqQr2Gsqg+C8PgUKoZYcPAEkW+nCxL18PtawUHj9HbDbMn5XPF68So9Y9aNfGrwtPVptCkDhn7aZhq/sGwSPxtX9BWhupvoRxsn3EcNw4HATMMQ85lL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn85rnGsEUQURGo3gSjeiuIxsTNIPW5+7JpCpcFIYJ4=;
 b=w0kq+6WscuYj+qXZ6TH4Cy7uNY7IpID1bJh4xNYrHinA6jycRhIfDb9OjwGgAeeAqdLj54hddRP9I7ZQcXOpWGFTZR+f5V9/dINegGXiIfiP7Eab7ducok284J9oGMzlEK7TO7okDgAZESPpzMcu/k22ENcLHQwfwzbD30IBD03Yf4aownmBm2zjsIfmkGG6/xh10qHA+BeQTbVb3mlw1epQ20U18m8aWPSTq/KZCExSd5Qjd2PDIgWcXmg+/r+ZF1IWBIf6FB3h6cZLtpO4pbgp7Yh9pFyesGzbvcXsTgfO9fENC+jZPN24zQV6XqbbaEHoZXdyK/gha8G+siSTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn85rnGsEUQURGo3gSjeiuIxsTNIPW5+7JpCpcFIYJ4=;
 b=B0InOWgFb9cvQdglnyGxarTchg55Ovkijq/K0cGGOvvhToWNHEh/lPIX88B5wE511Ha6hL7F1/LSdBFbSbWyEzyspk+vY1Ae8Aq57jiXwz25TtbNrVQgkaQj8htZwK0Klyi0er2CLpD+PVyFtMTEIiVNOVcGTn2hPgmG0xU2a1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.33; Mon, 21 Apr 2025 14:28:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 14:28:05 +0000
Message-ID: <2acc7cec-17f2-490b-a23e-0441cd999222@amd.com>
Date: Mon, 21 Apr 2025 19:58:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix offset for HDP remap in nbio v7.11
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com
References: <20250421093804.880633-1-lijo.lazar@amd.com>
 <CADnq5_PmP9+JM8fLOctX-vuhkUpK03QzbAX21bMag5cg6zMTBw@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PmP9+JM8fLOctX-vuhkUpK03QzbAX21bMag5cg6zMTBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 013ec6a8-c9b2-40a0-7883-08dd80e0baf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dllqUUNmSVhmK2lNamd6elVHc0lTYlZWVlcwNURSaWZ6YzAzeWNkdjk4Wkow?=
 =?utf-8?B?S3dGL0ZsZmU1Q29UMThpSnAwN2RIV0JPNEp3cmNubFV5S2lTQUtRMVQwV1Qy?=
 =?utf-8?B?U3kzc0NLZ1RDZ2NaMEFYbWgvaHRRMWVWWlMwSnptV3hLcnQ5K0dlUjZybkxM?=
 =?utf-8?B?aVFLV09DdWpEVkFDeFhVc0g4Yll6Q1JJR3kvckhnTE9WdjMzeFNSSm5jUWFm?=
 =?utf-8?B?T2RTN3NSNW94VFRYZXBZaG9UZHBNak9wRkhJY2pZMi9IODExOTh4TDB1cDB5?=
 =?utf-8?B?Ny9lSGJtaFkvOXM0dk5YSTJLMUtmbHhUNmxKRVZFZTRuUWVSSmVHYzQrVjlp?=
 =?utf-8?B?ejZWVEk1R1REaEV4M1Y2Z1U5c1VuUkNudEphSWx2RGU4eURUTTRtV1UxYnYw?=
 =?utf-8?B?eXQwMkYwbTNRcC9UeDluQ3dpMUFVSTh4cnkxcGRNczBWSWZxSGdBNmxWTFho?=
 =?utf-8?B?WTZ5ekpjUkVMVm8wVmtJOCsrREQwM2pqYXZ0eTcxT1lkNUMvNGZWSi92bjRC?=
 =?utf-8?B?dlBlUitTTzdoemRrUXRhaWdmRlJzZ2JIY3VhS3k1amFDZThjZEcrZXpGam80?=
 =?utf-8?B?NGdaUm5aL056aHdXYzh6Qk5uQ0FlZDVYb010S2VQSnJhd2pGS05OcnZyZ3FB?=
 =?utf-8?B?QWJOaXhmWTZGeWVqanVub3JhQ1VRNnczOG9NNGN6YnlKYlA5RUhxZ3ZocDd0?=
 =?utf-8?B?VWhNOFpsd1UzWTBidFJaWmJEci9WZmNCYUNwMWVYRCtyWU1jZUdjQ3FUa3JO?=
 =?utf-8?B?MjJjVFFKMk1yUVQwRC8xWC9Saklrd1EvYkRxZVN3emtYYWJNbUc1dmVEN2ZW?=
 =?utf-8?B?RTdENEtRb1pIUFdDVXZiankrWXVycHJvM2drUHVLemtCaEZYejBKdzMxWm1o?=
 =?utf-8?B?dUlXSDUva2pjc2tra1dEdzRJRS84UklmdWs1T0tIeEdMSDlKMFpReUFnS3dj?=
 =?utf-8?B?RlR1NEFLYjRzTWNLZHMvL1hPQVRxbk5BWXpSU3FVY0hCZ3ZSazUvTGowVmMz?=
 =?utf-8?B?VE5tdWlxY0pTdmpFT1VZR0JtaWkyRUQ5bWhkb2xqeGU2YSthY0JuTGlhSXVY?=
 =?utf-8?B?Y1IvcEQ0U1lOY0RBMzgyVk5HQVJicGJPYTRyWlE5Y2xxdDlYRVJwcnN5VGtk?=
 =?utf-8?B?dXo5eHRBYXJHcTl5aVZFRUVMbEd6L0xNS0VwL3pVZUpPdFVXSVl0bDhnYXo3?=
 =?utf-8?B?SlZ5M20vSUFEdjVOQVNWbWJjM3p5QWdKRlNiRGR5UkEvSmdrbVZ1aWlybWJQ?=
 =?utf-8?B?VzZ3eUY5NzZsS1NhZEF4c0VMaGZ5Y2VUcTI4TzlyQ1FaVlI5aDJJbVMreVU5?=
 =?utf-8?B?WEpkMVlPQlJEZXZHRFEyeUdjTWxPY3R0UHdveUx5VlBER1hya3JhQ0dyZXI0?=
 =?utf-8?B?Q1kzYWpiWnFyWUloajRaeDlUcUhXWTdtV3VjUU45b09JWnZ0NG1xM0x6alBM?=
 =?utf-8?B?aGg3WEorT2hrUFVuN1FoUVZvV2pMV0N4OStVMlhjT2lTL3hzWmgvUGtoWTRO?=
 =?utf-8?B?ZHlXWFVzM0xYV1hQTlA5NHg2dFhJcEFKemdkeVZrUWdXUTBUN0I1Yi8za3ha?=
 =?utf-8?B?N3E3dFl5aWlvVHhHSmxxUng2MXlRYlBTUTBGOHh4VHA2Q1VpTU1LVGNuOHcr?=
 =?utf-8?B?YTRJaERackVqUC9PT2tuaGh2MlFwR1BTRVFWeU5ZNStoUG56VzJUaG5BYmMv?=
 =?utf-8?B?UVRQZE1zYld2Q2NwM0JYNE9hNWU4czk1YUtneGJhandMZkdXQmVSRExOZVp5?=
 =?utf-8?B?ZWh6eDNQQWV4Z1VrRkpUaDBZQjBNM0xZT09kYTg1ZDYvZ3R6M2JQYWtCWDFD?=
 =?utf-8?B?QUQ4L2NvdkJCV1RSZ1Q4WlRvQ05YSytwQWVGMkIvR2I5OUV2QnNwbjV3anNV?=
 =?utf-8?B?bE9pQzU3VjJMcDlMZG00REk4aExUOHFOVS9ZVTE5cTF6bkw1cC85amQzUm5v?=
 =?utf-8?Q?q8e+4ahFzTU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFnaTdpVm90QVAvVUN0azJodUVrekozM2tNYnM2bDBxMVJJcWx5NlhtL1gr?=
 =?utf-8?B?TU90amYxMjMzV21kTjgvT2c2QjBLSE5HYnNGYWo2Vkp4eFJVbkFiMlNXeUVY?=
 =?utf-8?B?Q0dFSkRTRTdYelowRlNlYTVHYStrSkxJb2ZIZmgxbWtvd08ybUFWS3pMTkpq?=
 =?utf-8?B?c2F5SnRXQUwwWWxUTnVaWVBOMExUblVkaUFNS3FSdFFOVTFlSGpGUFppQlN1?=
 =?utf-8?B?bFRPL1I3MHJ0d0Vtd3Z3ckl4M3M5M25ZNVM4aDQ1WCs0S3B1SDJ3dkoyYlRo?=
 =?utf-8?B?Nk1EWEFLRGhtbzZmQlBEb2h1VGhoTWJsU1hlZklnSlhBY0hiU3lpYjZ1QVVQ?=
 =?utf-8?B?SU1yOXgyNTAwV1FNRjl6elJHbTh3VmRFYmpyamZBcmNMdldwWmdsVVlNL3NK?=
 =?utf-8?B?eVAvRnl5R1VXeVhrOGszL2YyL0wxc2NWVGtPajk3WkExLzRlS0NmM2VEWVFa?=
 =?utf-8?B?anNZRFhOOVRrNEcwVDY1RnliTXNwKzV3SytzcUZ3VXR6Z3N0dlMxNUk3eVZ6?=
 =?utf-8?B?Z2RvYk9NalNyY25yeWl4dHBRbFNaakFJQXRTVFB3R0VWVmRZalcvMnFkV1RY?=
 =?utf-8?B?Q1VqZmlmYnhkeGpyNEo2Y1pTTUI5L21xSjluSnJaNVZuN2MweHlETDJEbnoz?=
 =?utf-8?B?c2FtdEJMNmpscEhybkpXSkJPVVBDc1hQeXp0a045VHAyd0NRY2wyR016c0xn?=
 =?utf-8?B?RDNSTC9rRExnV0R3L2JQWlk5bTU2OGFHRjZ3ZklkdisxRlB1bnFtMU8yT2Z6?=
 =?utf-8?B?UUNkSWNHRkdPcjRCMHVocFlabXRGV0daeHZYVmo4bXd4REM0VXU2WjA2bXBH?=
 =?utf-8?B?ZEpzb1o0c2FDN2dOa3kxOVVRL3Znd2hDWEtBSU03QjlVQkc2TTNDdFNzS2Ew?=
 =?utf-8?B?dWVERzlSYStrampuNU1NMitlbkZzYk1vL1RKeE1yUjROd0tRa2p6emtBWGNt?=
 =?utf-8?B?RDZSWE8xQnJHN2dWM3krQlluZDAxNjJWbXM4WW4wM2haNnVpNEhhczlwQXlj?=
 =?utf-8?B?RGFFUU1DWFViUjRVdWVyK0pxR1lvdWcrbmM1ZHhlTFdMTTBZbUNRV3htVDh3?=
 =?utf-8?B?STlXUHRjVHVDK2h1NjFSZFdFUktVTFE1Z0JUNk5velhXZWwwN1VzcjJtZHFD?=
 =?utf-8?B?WVRtU2VaQTZzcVlqK3dPUmxNVGs3TTN4eFFGOStpSXlpYnplaVVmdE0yMGh3?=
 =?utf-8?B?QzhvcDZhS0U3aGdJbDVPUVdhbldDZU5FYWxXbTk0QVhrUm5QRFFBVUl1Uyt0?=
 =?utf-8?B?ZjlEYlFrOVhKME5FK1pmdUowVlZmRzNZMFNYYUU3KzRLVXhxbXBIWU5lTWE5?=
 =?utf-8?B?aEw3N3NZUW0rZTFGM3FNbCttdXhseGFLUGdMTmlyTHdiS2NvaGhodGZ5SmZx?=
 =?utf-8?B?ckV5eGNtRElxYTREOTBxaUNRY0YwMW5KR044akRrUlhFdTRoQktmUWo2cDhH?=
 =?utf-8?B?K3dZb1pWbnpRbURnaXdKU01DM2h0bGlHYXZTRzlaYVY1SjU1VHRySlRZaFI4?=
 =?utf-8?B?dVllSjlMNEtmb0svQkxyQ0FKYmNpeU1yeUVpenp4dytxNkVHN2NqOWhzMTFo?=
 =?utf-8?B?eGF4SkppNTcwenVoR2ZSSVZVTkliUW16RmtVWDQyT2piNkt0cTc2bnBuemRG?=
 =?utf-8?B?bjczZzNOOXVKL0t1NjlSdm0yU2g0VGJ5bVc2VklXMEFKVnFjdWRwM3lMYS9n?=
 =?utf-8?B?aUNZWTd3WURzQTFOMFgvdWZGblRIU0lmNUMxWE9qNW9yY3pqMWZwTUlrZndz?=
 =?utf-8?B?OXExVFJtRlNQODA0OHhuRXdqeTZiSzNwbEY5NzNjN3NZa1FlcVlDa0RJMVJI?=
 =?utf-8?B?NllGYURyQnYwYXdLVDVXZXE5OEI1dUk4K1RTQ042M21pKy9pWlhUUDBRdEs3?=
 =?utf-8?B?UVNsMVpxUkV1NU1pRmxGTklxbXFaY0RaMFpHK1RZbEFzWnBlK0V5SlhPYTlS?=
 =?utf-8?B?d0N6bVBZaGczdWN5OXczbjc4V1lJdFloLzZtYVJIQ1B3UC9GUk1GQ0VGeEg2?=
 =?utf-8?B?SEJFL0Y0TmQ1RHVzQktiMzhhRE5hWWdITmZHS2QzMkFHdi9EcmFDVGpFN3RU?=
 =?utf-8?B?ekVmdkpGb1NrdHJWN05DYTd4eHhWNGd1YS9LUzlEMWYwb2tWdlVXZ0JraU9O?=
 =?utf-8?Q?pF0vM2amH7duMWQEOu5a4Wb7G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013ec6a8-c9b2-40a0-7883-08dd80e0baf4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 14:28:05.7625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK0/znRiZJU7xRudoaLWSOzoCZB6TpKQnt7W8+zH6IhAhpfWl7qOF2VS67zNi8ez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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



On 4/21/2025 6:39 PM, Alex Deucher wrote:
> On Mon, Apr 21, 2025 at 5:48 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> APUs in passthrough mode use HDP flush. 0x7F000 offset used for
>> remapping HDP flush is mapped to VPE space which could get power gated.
>> Use another unused offset in BIF space.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> Assuming we have a full 4k at that offset:
> 

Yes, 4K size is available.

Thanks,
Lijo

> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
>> index 2ece3ae75ec1..bed5ef4d8788 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
>> @@ -360,7 +360,7 @@ static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
>>                 *flags |= AMD_CG_SUPPORT_BIF_LS;
>>  }
>>
>> -#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>> +#define MMIO_REG_HOLE_OFFSET 0x44000
>>
>>  static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
>>  {
>> --
>> 2.25.1
>>

