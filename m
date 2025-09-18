Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581FFCAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 21:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3E810E179;
	Thu, 18 Sep 2025 21:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKy5wePk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F93610E90D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 21:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf/xJO3E6pxgibRG8ZwzFif3IUF7djA6wvknynI/wMb3FW5OnszBisOBeAfUor/sNwMON0P7MnQNv9u7fjOOpezuqZwaIU6GSyfnKCdSEvIgQox/5Wc+KasIrjgsUPKVvCxFRFf3ZE8JhqUszXVP3X1agQ6Bmg1gctwoc/Dbt5JbG5bap1AlrDVdhVkgBpN+q54hgTpQzULVSZylMdyLupa4vLvCpmat0MNpxSX8a0hEufyQhpY915F/fWEnD9toJJSRCjE3Bv3y+D4usHsm7FJoI0a1mDRf0EUvytxDEBZ9wlKuqkoFlTJRGcPHly1TITd1fsloJekinRT7Rbu8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbO0RDlBreE9LiZnyMNM20TA3Wbvg70WNtQm8cKCxPY=;
 b=KUiBKoBMQF1mvJcn1LSvBVQjMBXi04DAeZCqzRzkDA9ShrJ6lA8rkfSXgh2DegxDCjtAntl3Axi/VWY628utBxEyMbv+BVgYiWiSVs9UDfwiNAq8hfKaGACC6Va4asxf5Z13T5nBfL9ZUYBJ5Ymg+mopCrFbdjjzKcuLeS0fNSJ1BEgzTu1QfaCYSsj6+2VBfbalbO43VjrdiEoJ7nzco1ayR9jpOMi+YpcuOjC3HbvKZ1ccPxX0aQiCN368loM2CJX3jM6DhV0JjP50lZ500wwP9gMviJ6vOa+ecnKko1/nfwGorRgPcBxWxUvVPcr2sg5AqINSU/D/H7+S0sJm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbO0RDlBreE9LiZnyMNM20TA3Wbvg70WNtQm8cKCxPY=;
 b=QKy5wePk5+QjpvPInPDfLkR6YbdpckAWpfLRly44iT1z42a48slb0IzYlgGZ/cuuBhbFrIafwklwNPDqM9zdsfKdnMFIoaZsNOZMas+VUmVptKb3LsieZdxKh56XnZBcI/2+OAMqby6W9yvt+f/WMuRB4mkouTCeUW9O1hPSW3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 21:35:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 21:35:51 +0000
Message-ID: <c6ed9443-1465-489e-8c8d-d3c06604d97a@amd.com>
Date: Thu, 18 Sep 2025 16:35:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Enable MES lr_compute_wa by default
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
References: <20250918184150.394532-1-mario.limonciello@amd.com>
 <CADnq5_M13ADiuoKKdgEyi=1MVbLJ9qCJKTHUPd+F+aLXUzwtDQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_M13ADiuoKKdgEyi=1MVbLJ9qCJKTHUPd+F+aLXUzwtDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:805:f2::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4aca89-aef6-4ec3-7213-08ddf6fb56bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFBGa2htSWJHTURXLzdwVzN4TXlzcldvL3NHc2MwTklManQzL29xejFaa1Nt?=
 =?utf-8?B?aTFrdkdlNVQ3dENhenZQZStaQnV5RDlXb0FPN05hTDYycHZKTkx2WkluUlBl?=
 =?utf-8?B?VWtMQmhUUFVXUG1KYmJYUE9HbEJ2TWFNNStFNHR1Vjd4V281d0dvSHBwZDNJ?=
 =?utf-8?B?NHBiY0ZPejRMRTRybXVYUDdRbk1uVGc0d3lQWjRRYjBjR0JnSFFaWkcxMkJP?=
 =?utf-8?B?dlBmVHU1dkxVb2paR2kzaVhPUU1TNU5LVmYzQ2lZUHBCc3hkQ29PNW5Dc2Yz?=
 =?utf-8?B?d2pqN2dLL08ycjF3MGJ3R2tBZUJlM25jZHpiKytMZjRIbU9UT3hscjJVTFpV?=
 =?utf-8?B?MnN2eG1qL3ZYa29xR2kva3N2a3FENmhDUG1iZllIU2p4QVlrZnFpYm1IbGF6?=
 =?utf-8?B?cE1TSlFhMWZ0YmljeWRIWksvNGhmdW1UamRtV3Y2dHlHUm13dStJazNKU3NM?=
 =?utf-8?B?a1MrUTRidUNUZmovMXpKWDJOUE95T1JWNDJQdmFnRzNtV2FzRGFydElKejR6?=
 =?utf-8?B?WVlid01EQlZzYWkwaHJWcjlubk1GNW1ua0VxV1k0d0crOHBsL0tITmZIVmZM?=
 =?utf-8?B?SE5zT1hacEZyeEZqN2x5aXcrQlhYdWtvUzA1WVViY0EvYWprUFZoUXMrRm5o?=
 =?utf-8?B?T2pUSHNyOWQ3R0NTZU1KZHZrNkNKL2NOL1prN2tKR2xsclh3dFRCZHArUTRw?=
 =?utf-8?B?UHlza2dYNVFGdWQzY1FvSFJLSXk5MzJtTlNaQUw0ZEc2MGlWYUZIdmxBdENS?=
 =?utf-8?B?alpPcXhKTHVRK1NXYk45cGwxZ1FSTkEyelM5eGtIT0s5V2xTaXZaeldmOTJs?=
 =?utf-8?B?UnJXdHVHM29JL1FYUFB5MDlvYitOZ2h2VmVpckJ2WUV4WkF1Vkoya09VaUlX?=
 =?utf-8?B?QkFzZ3NCc1R0MDFyYVh4TTVsVWg2aC83clBKMEJIcmpHZnF4dEtDR2VoR0hk?=
 =?utf-8?B?bEEwQ2hQUE44VnJtdnM3Tkx1U01pMndLQVJ3a0ROWmdOTzJHeVpKSlltV1d2?=
 =?utf-8?B?K1ZuOHFYNURCQ05CNitiUFNyamtjU2RwRXZwaUJyVzh4UE05WTdSM0R6MlpY?=
 =?utf-8?B?OCt1NGEwS1RQYmlwRFY5YXJmaFZQeGRJeGZyWjExa0s2QWV1S1I1ZnRqNFhi?=
 =?utf-8?B?cXp3amgwN3R1dVRDeGJuSjlKc0dPamZCWEs5VWRCSFNYdFFCQTZNNFQ2UmdL?=
 =?utf-8?B?ZVB0MFVoK2NFUm5LWHc4N0hxYmkwT1hwNm9xVkJKdjU5T05zS1U1Q0I2RFhG?=
 =?utf-8?B?aFo4S3dxM1ZkanpLNjhkcHA2VDVRVHVKV2kxVHZPWVhKQmhuTWRUdFp6ZU04?=
 =?utf-8?B?QTR4c2gvekI3b1BLRjBpNVI4RTQzSnpoaHdLWmZlZmZGWkc3Q3NTcWU5Rzlh?=
 =?utf-8?B?MnZTMGVRaVExVTJqbWJETWQ1Rk9wMWFKZ0prUEpkMUJ4NGgrQTNESHg1dHZa?=
 =?utf-8?B?TTN0cEJxV29iOU9maWdVVG0wa3MxZmg3SGxIRGpDWCsvVHFJSUpOalFDa2xw?=
 =?utf-8?B?MFUyeWQvTzhaWkJPdGlqdUhNSFVuV2NnK2svSVJkMUd2WHkwUUF4S3BxWVpr?=
 =?utf-8?B?OVg0eWMvNFpEN0V6bEZFVWJRTkt2L1pZWkZYdnNmWjYrTmlxZkxsNiswZjRE?=
 =?utf-8?B?bHNHL0NBbE5tZE9QN05wQ05JTmdCMlZTRW91dlNlS0JzazkzaEdjZDgvS1dE?=
 =?utf-8?B?dEoya3FEWkdEcDZST2I0R2x3QVM2QjRuUVFJdHpUM1U5U1ZPYm1YeW54R2Rm?=
 =?utf-8?B?dzYxWmw5Q1FMdkl4NlAvbldvYWZ6aFZkUWR4b2Fhb3JDT243UGE2ZlpsL1VZ?=
 =?utf-8?B?YnR6VnF5QjRmVml5cDJJU3VwTDErT0E2WmVWbTk3R29PTndIMWZCMWs0WE5o?=
 =?utf-8?B?ZWVkVERiakRuc1lxRnFTeFl6VCtCZndHYWxyMW82Qlh2b1EwYkNSbTFKZTdO?=
 =?utf-8?Q?4ofcD029ijE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzN3SDdyQStkeTAxMmlINy9aQVU4REVoYVVPNkZ4T0pSb1c2b3JTZlhUOTZu?=
 =?utf-8?B?Z3pWbjhKUXZBSG85R3RjdUo2UFg3TEh0NlBXSGw3NHI0VkIzUFVWellCRVhV?=
 =?utf-8?B?WmNRWWowczUvb0NyaVdnejVyY3I3d2x1TllPaXJzWnhwb1YxbTlRUldVaTRE?=
 =?utf-8?B?TXo0YVZuZmF5Sk0yak9ENVRsOGJBb3d2Y3VNeEROOGxhcFdEM1hjbWhJZlAv?=
 =?utf-8?B?WEN4K2JTWXROeVVJbEtoSEQzYWxFY3dQQW5PV3ZWQStZbjNtMUx6TDZnNXFj?=
 =?utf-8?B?MWRjQW4xR01WWlpoajRQTGZzNE1PYzIvWjM1ZXh0YkxGN2s1VkxwaXAvTFJo?=
 =?utf-8?B?T1Z4alVQOTFSdDE4SWszTkxQMWxKS1ZJLyt4RXhNZVpHdkYyaHpUV3NXdnlM?=
 =?utf-8?B?bFVxV0x4a0JPMWVsclFUZmMwT1NwQjlwK245VFJUMjF5eXRkVi9VK1R6Q2ZC?=
 =?utf-8?B?UE1nUnZ1VEpsZFVXM3lieXJsSnIwdVFrK2xVVDdOcllBRlMvaThYTUxEWDR4?=
 =?utf-8?B?K1htbjA4THVOQ21HUVdWaVIwV2dzOWpyOVJVQ01hVVRNWmlWYTBOZloyci9h?=
 =?utf-8?B?aHZ1S3E4a2NkL2wxTDlVUGlVRGpKcGduTjdRbzhRdW1EZHdoNlpkMlNEV043?=
 =?utf-8?B?SWlPYzhCRXF3SG5yMEJNQkpFK0J3R2Q3L3l0dUR3ZXkyQ1hjNWtNZTNaSU1p?=
 =?utf-8?B?bVJqTFY5WWV4a0t1bktIZkVaMmxVd2pCZ2piV2ljc09tTlhNRXpEVWdnak52?=
 =?utf-8?B?WWMxcFNTUDZBYWZOY3N0MkxqaUlteG95QUFQTy94OS84TXZnRkt6VkFOZXVW?=
 =?utf-8?B?OUhnVkhRbTNUM0ZWRnc0TWlkZi9Yby9nSkJUSmhwTEdMdEkrZG5uQml5WXFH?=
 =?utf-8?B?N2kzck1BajdWT3hoSzFwZmM0anZrenB1eUFBWnZVMUZGOCtjSVF1SXJsK1Jh?=
 =?utf-8?B?azNkV0RqNG9SS2ZqMnVGWDJJWnl0NWNHKzR4dkdsdmMvdDVhYzh0eXVSblRZ?=
 =?utf-8?B?WlhWSGRPMHdpMkZLanRiSlQ2Yk1ZWGRrRThqU0Y2RUlDZTE2anF6eG96bFE1?=
 =?utf-8?B?UW9zbDVKNFhzdzAyVGkzL3d1RnhydUhTWW0xbmpUUlBFaW1ZWTRISWNJeU9L?=
 =?utf-8?B?aUJmQXVmaDl5eUlaNnNHMkMxTzAveVQ4bkdMaER1bHFIWlZuR1FsUTBhWjJm?=
 =?utf-8?B?bjIzY1FTbkxGMmhzajlaQlJ2d2xPd3FrelJLUVlRZXVpVEtIamhzL0dWZ001?=
 =?utf-8?B?REN6RWlnMTB0aEZ5R3doOHErUldZR2dmMFJwa1lrTlFDTXVFdW5nclFBdUdS?=
 =?utf-8?B?K3dZTUVRNVhMVzBubHNsQXJ1RGJZS1M3ejc2dUhGb01ZLzc1aStzMDc2TVpC?=
 =?utf-8?B?UklGOFVYZHNMY2dOdDBBMC9ob2ZpZm1EUFh3U3RFamFMazVSWkljSGpNSnFM?=
 =?utf-8?B?T0dFUkRsdy84KzFrc1lUeitDQWIwNjhnRmg2bHByWnpQZXBmcElFS201dVBa?=
 =?utf-8?B?aDR2Q3doWUU1NnpPL0k5UC9NNmUyTjdxb1FuRDFKd0c3TVJWUlBMazFmSS9S?=
 =?utf-8?B?VDh6dzkxdWRJblM1cFljTFMxYmEzd0RQVDR5Tm1jWno0RXdGSldIV2xtQnVF?=
 =?utf-8?B?QjEwY3BDR01UNEg2MitTWkRvcUhxZFNSUnVlVjdnTE5CU1VLNTU3WUF1SEoz?=
 =?utf-8?B?R0NCV2xVWDlFMW9xZ0FPVWhWQU9QNnQ3ajVuTjR2dklZK2FxTzVuYWx5am9z?=
 =?utf-8?B?Vnl5UE9tdlc3OWlqZGt1bndWZ3dIa1pZeGdQd2RncUN0a0p3S01MbElYQVE5?=
 =?utf-8?B?ZHNsbU9CTWx1a25wZnUzQkpYUHVicXBZUWZHcTVyR3g2L0M2bkVKNkh3Rkxq?=
 =?utf-8?B?Smp2UGdTb0ZZbHJHS1lqOWN4V3BOV21lc282bWFhcS9jaU8wRUZDRU56YnAz?=
 =?utf-8?B?cEJkRit1Sm5uQjJiYmgwV3JjRVM0S1ZuK1hrWDJLU0tGK0s3aDlOZlNTMDlk?=
 =?utf-8?B?M3FiUnJyTkxSeXVLNjBkeTFlc2dNQzlDT0h4U1FVRDc5TzlkL3RBRVRQL1I1?=
 =?utf-8?B?MnJlc01DMEVQSU9wYVpKb0NYSUZmVm8wUHB6OGY4TFJBUlg0a1ZpVVYyVU1S?=
 =?utf-8?Q?gspNFHXtymHU8FwjkZ2qozA6z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4aca89-aef6-4ec3-7213-08ddf6fb56bd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 21:35:51.0777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei8AgKKhRZHGmPgRMf/xza0ixJ8RHjTGHpNdzyXLrwvpDrQwpr8Cqo+iXdYT1RWHYP/c7hNqI5jwNe3QbtZKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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



On 9/18/2025 2:05 PM, Alex Deucher wrote:
> On Thu, Sep 18, 2025 at 2:59 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> The MES set resources packet has an optional bit 'lr_compute_wa'
>> which can be used for preventing MES hangs on long compute jobs.
>>
>> Set this bit by default.
>>
>> Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Presumably this bit will be ignored on old firmwares?  If not, we'll
> need a firmware version check.  Assuming this works correctly on old
> firmwares,

I'm assuming it does get ignored, but maybe Yifan can confirm it.

> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Alex
> 
>> ---
>> v2:
>>   * drop module parameter
>>   * add more description to commit text
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 1 +
>>   drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
>>   drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
>>   4 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 3b91ea601add..540b514312b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -713,6 +713,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>          mes_set_hw_res_pkt.enable_reg_active_poll = 1;
>>          mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
>>          mes_set_hw_res_pkt.oversubscription_timer = 50;
>> +       mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
>> +
>>          if (amdgpu_mes_log_enable) {
>>                  mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
>>                  mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> index 998893dff08e..01266eef65cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -769,6 +769,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>          mes_set_hw_res_pkt.use_different_vmid_compute = 1;
>>          mes_set_hw_res_pkt.enable_reg_active_poll = 1;
>>          mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
>> +       mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
>>
>>          /*
>>           * Keep oversubscribe timer for sdma . When we have unmapped doorbell
>> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> index 15680c3f4970..ab1cfc92dbeb 100644
>> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> @@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
>>                                  uint32_t enable_mes_sch_stb_log : 1;
>>                                  uint32_t limit_single_process : 1;
>>                                  uint32_t is_strix_tmz_wa_enabled  :1;
>> -                               uint32_t reserved : 13;
>> +                               uint32_t enable_lr_compute_wa : 1;
>> +                               uint32_t reserved : 12;
>>                          };
>>                          uint32_t        uint32_t_all;
>>                  };
>> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> index c04bd351b250..69611c7e30e3 100644
>> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> @@ -287,7 +287,8 @@ union MESAPI_SET_HW_RESOURCES {
>>                                  uint32_t limit_single_process : 1;
>>                                  uint32_t unmapped_doorbell_handling: 2;
>>                                  uint32_t enable_mes_fence_int: 1;
>> -                               uint32_t reserved : 10;
>> +                               uint32_t enable_lr_compute_wa : 1;
>> +                               uint32_t reserved : 9;
>>                          };
>>                          uint32_t uint32_all;
>>                  };
>> --
>> 2.49.0
>>

