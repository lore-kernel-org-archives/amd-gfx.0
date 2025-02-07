Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD6C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6071310EB13;
	Fri,  7 Feb 2025 14:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DnbrJ8M9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC8510EB04
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 13:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBdHjbTaC1v6pFqJhR0cMGFmykkow4h8HNs0LMn0vqgXo/TDi5YyKY7+7osrMrxhr9P01V+VnJCYSIruthRJbB9QrNci7iu1v8uFSW81Gmdj+uVozeES+b4nLWnaLjsxGf1M/KRpjN+I5O+4xPpHooquzfLvW8M7FqEl3MVOnCyXxBog4C6OcI+0uBSVcEZekttd6X9rlGTPrMd6NmNVe+opph2QRI0QGpDV3kplknuy1TbdG2GbvHDNQtI27aoEfQjB7eR0FXov+jwmVIPsFqm5rpL3tqIWpqDILvkQeugt86UJSSouNOZb/x6hZtd0gT1gR8ZBIkBxdyBNjBugqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMw6oiBvG5suS06CJtk7RjpsAfYyF/UDRlE8UTp2Ivc=;
 b=r93BzpAV57Sf9T7qYOnZyR1+PpBMFw0WovS7o8ZTuyD6YaHE6ShRksZidIg08oHipqC2LfXZgeUROd6J8e+t9ulYm0DCAip65LPUthF4tGE9uL9+owa1jneebxAqRcEdH1zoscMROF28O1IXL7bVdjGqunUcV3JRRCiIDSWzaOclFW8bJhZctWp9QqtxIWBfZARv9espf/umqFfMMMBDhLNQStdHzO4NW7j2OsGIHJ4QKmYZFKxDjh0Ww95Z5zujVbp/zqNYdz4H1tUYSwbwHdVSbc7WHCmvC9V/bmtsFCN6sZIOCb1zPCkREcuETDfeLUZC9tLd3Tz9DRUlpVYFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMw6oiBvG5suS06CJtk7RjpsAfYyF/UDRlE8UTp2Ivc=;
 b=DnbrJ8M9JdOEOAiIFvAuamwFZhyvqRvDqCtaNuPNwLYNMEgaBlbqBYevOYM3hDMquld09C4EwB9DAm+YNq0V04AlVG49Tb9Tef+C4KEEpQha/GtIfJ/hCpBmZ4XT44HJT/EIWer5owXmN7mBMORie+hPrkjY2xHnDhFFwYjpFaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 13:56:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 13:56:03 +0000
Message-ID: <2eea4227-86b5-443c-8ebc-efc2bb975aab@amd.com>
Date: Fri, 7 Feb 2025 14:55:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lin cao <lin.cao@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250207100900.1115660-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250207100900.1115660-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2604a091-36fd-454e-4c29-08dd477f2924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cCs4UjJPNE5qUm1NamZqbjJqMlpBQTFOYTM3bU9LRnJZQ0RpMm9wc2lxYjJ5?=
 =?utf-8?B?b1ZkQ3ZCRzhWSzdaSmIySUtsaWJCcFJqMVlVc1dVVE9HVnFsK0tqUUNlSll0?=
 =?utf-8?B?Z3k0cGdSalI1cDZzUnhvajNlM0lsTTdaWkEzVzdlL1N6Q05ucllGNVF1d2to?=
 =?utf-8?B?LzE5NTArZ2YwVmdwUGZJR1Fjd3pRaVhicXBsNjZVZFE2bTk5cHNSRlNLT01T?=
 =?utf-8?B?WDRTRnlETFRoWlk5emx6UWRkMjVVd1MwYkw4aXZYWDlkc09NNGxYZWVnN0FD?=
 =?utf-8?B?dHBVQ0tYcGYzYVJOUkpQNmp0MWJwdVoxQ3FraHZ0aWcxRjAxVTNrTkk2RmdS?=
 =?utf-8?B?N3VyRE5xaE1aRzVLQWZmOTFtRDVKRktFdXJkaURBRlAzWVFGTk9zeHozTzMr?=
 =?utf-8?B?cnVmQTJ0VmhpZkxyVEVjaVBJbWRESVllWDBNcEZRM0NYN2ZsSWpUQ2tjNm1W?=
 =?utf-8?B?R0FwVWdvOS9PZE4vOUhzWUljUGIzNzlLTVJERUhLYlZoMWh2V3Zxd1pXZXBS?=
 =?utf-8?B?WGlBODl1cUVEamx0Zk4yaG9oRHkyN1BHelV6WE9KZlhxb09UMzgyREIrZFZE?=
 =?utf-8?B?Y1Qvc1NJeW1xTzB6Y2RnUXFxR2FZd1MvYVNzUStydEM0ZHExRExDQlZwenly?=
 =?utf-8?B?T2w4cUk2ZlZGZEdWaUdWY1dTM0R3c1BwOXBtMmVXMnFic09zQUhlRHlxYkY4?=
 =?utf-8?B?NkdDZzdXMFNHanZ2RGxleVpWUlVuUW5heVZlRmFvQXZOam1Pb1hXelJwRVFl?=
 =?utf-8?B?VGlQM1N0Y3dpQzMvbFVseTRtRVBJdGtKbStTeEZDNURBMmxaQ2FWQS9aQmNJ?=
 =?utf-8?B?V2lHUkVCYTBWMXgvMzcxUERpRFRoRHljNmtGaHh0WEdwTDB3MlgyWkFYN1BY?=
 =?utf-8?B?eG5VSUNndHpQQ3VQWVhtdDhwcG1TMFJmaWNZSFN6ZzRVWDd6RHo4Ni9jRmJL?=
 =?utf-8?B?MFI2d25TdDhlZUVFcEoxVGs5TDhxSU1PRkRJSENCYTUvcWFDeEMyQVNUbnA0?=
 =?utf-8?B?WDB1UDJJZXkrU3VWdURaTHdSeFhoNkQ5em8wbTd6WDc2QXkxMWRsRlA0dndK?=
 =?utf-8?B?dEtkcUwzQ2hzcVFUMWZQcndPaFdOcjVSOHJJUUlsNnJmV1FyTnMyejBySjl6?=
 =?utf-8?B?NGRLQnRwYVgzbVc3S3d2UkM4SEIxSWtvbDA4RE1QbWVQbkQwa0RTNVBQY1BC?=
 =?utf-8?B?M1E2ekJuR3EyZ2lZL2RnZGwyK1NZdjFXUmg1WTE4TTk5Z3dQN1F2NGJjOXk4?=
 =?utf-8?B?Uk1RNUJkcGNxTXRFZmQ3M2dJSVhDYUlvMzFROTNIc1pPdlJ5VUFzRWRMWThD?=
 =?utf-8?B?QkVxWi9oU2Y5emI0d1dLRUxFelI2ZWQwd096VUdQdGxwSXNGOWl5VUg0UE5K?=
 =?utf-8?B?UVRqZnB3WVk3aTFMZkZ2S0hhdk5QU2E2MzdpQUV0b1NlQlVYM0hMeDA4YWdv?=
 =?utf-8?B?RVhJUzRXdjVqcUc2VXRxZW9tRVR6OEJzajFWbmxoRXRzRUZKWmVMczhBdStO?=
 =?utf-8?B?QzBvY2N1SmtsVm1QV1JreDJmMk01K0pmQXBYSnlXUEQ5QmtjcU9NeWthKy9m?=
 =?utf-8?B?R3gyaHdDaG54VG1GSWhJZ1NTdkhZQkpaSVc4RVByaG9ZUDZQdk0vTmllZnBz?=
 =?utf-8?B?QTI5MTlBWkJNQW1rZkFJbW5JamVtRXNpaXFONm1SbE9qb1dBcVV2Y29sTStj?=
 =?utf-8?B?M3FicDZZZFVCQTVoRGFXQmo3V2dBWHV3SGNhOU5FOEhIdFcwS0Z4NXF0dkxW?=
 =?utf-8?B?ZWY2MEpwUy9ObVVUTTcrZGs3WFZBbkNPQm8zZkVSd1IweWpkNlhSL1JEaHda?=
 =?utf-8?B?SHZ1K2FpSy9rQlF2aWdvV1BXd2M0MUgwZWJEQTFRaS9Od3lsOElTZEZaKzBP?=
 =?utf-8?Q?0soZqVYvqM4ZU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDVsQWlCd0E1aVU2Y0Y2UFozV0FhKzdkS1V1dlppc0d3QldxWndjSlRDUXFU?=
 =?utf-8?B?Z2lFaENEVVlaS21pbHR5K3N0YUxVOTMxc2hkQmNhVC9xWDFRWFNnZ2Y3UzMv?=
 =?utf-8?B?djVQR21rOEhSWkgzYmIxYWljQktXa3hGNFFhRUxBdm55Um4zbW1GR2VKbTM2?=
 =?utf-8?B?S3NEMUcrSmxzdDFqYkdPL0hOQ2hralBMUlNVYk44QnFwemtIT0hDekxPNDdj?=
 =?utf-8?B?cDF1V3NrRXlGSUNodVl5UzYwSnhWTCtpRVNyVXR4a2w5dTdndU9JTDhHWjB3?=
 =?utf-8?B?cFlGNkFEUFpIZEZibmZmS001dldUYzhhS2oyNUFhUmJwM0xQNWQxZktVYUhH?=
 =?utf-8?B?dHdMZk40QjB0a2I5UVNDWGRSQXY0TEFSbE95UEkwTGwwZ0NOS1liTFNNU1di?=
 =?utf-8?B?QVBnNW1PTXc1NndCeExNOXZ6SWZBZWV1SzJYT3FwZEc1RTRpSlRzYlZJdmx2?=
 =?utf-8?B?amFJbjFuOHQveTcwVGdtTnE5QTRFc2JucTc3SmxFandrK0lxOTBpbGJJRWJC?=
 =?utf-8?B?TVAveFRDL25lSmJEM1hjUWVTMFBpcUN5cHJieHE4d0FuanA5b1BDU3JoZmhh?=
 =?utf-8?B?ZVVWckhQNjkvQUYrQ2lBUnZNakdWL3dodVRvc2F4K3lsMFFFQnpqc1M0eDBp?=
 =?utf-8?B?dzVrWENTenFIU3MxL1FRNlZidXRBd0VXRm5zcXJkS1BGbHdrWmRVTTdEQlRL?=
 =?utf-8?B?NG5JcTFPVW9Qd0pkNVNBZmlkMGErTDRDUGZEbHIwdTVTRUJ0NXMwQjN2cU02?=
 =?utf-8?B?bTUyYTNZZkphS3hoSmMvOVJGMVZCV05RN2FNSlJwcWhIMnF3MDBxZFZ0bWg3?=
 =?utf-8?B?ZUkxV0xYYmR6THZnZ2lRUFhzelZCVDR6TVBIMFRTVjBsQ3FwbCs3bS9qcUtR?=
 =?utf-8?B?TE9HOUJKK2UyczlPdllBQU14enloQXVzZEt1ekRiWWV1cWxyQ3NuUzJkeERp?=
 =?utf-8?B?YnJVUjZwTW9WV3hibGNYMFE3T29VbDhVZW1uYmoxMjRpTXc4SC81aWtRTiti?=
 =?utf-8?B?TXBaQmt5eHBVVHQwOEZEYzBFQ3lwdlJMd1hvd0w4RmZTV2lyK01CU3hTaXV2?=
 =?utf-8?B?Y1Z2NndidGVNKy9oTXpscGEySHFBS29aR0h6QW1EcFZQS2Exak1YUGJYNHhG?=
 =?utf-8?B?TFJYVnJIOWZkV2ZaWkVEOWNuODd2OEVmN0VyQUlMbVliN1hvZXdGbVpCQUxC?=
 =?utf-8?B?WU1HT3NYWTJFQitNZUZ6WHNRaUlMdmNPZ3ppay9FM015YkJnUUN6eW5NKzVF?=
 =?utf-8?B?amZXV2d6cXp1Z09NOEhNQzdSdHBUb2ZiR21qekN4R3o1REtoNVREeXZZY3hS?=
 =?utf-8?B?RDE4bmxNTjc2N0N3NDR6SHNrdi9wSUFwakphK3VDcFlaQlZtTWpqQ2FjUmpD?=
 =?utf-8?B?OUg0YnhrUktNT2svSmM3UkdabkkwZ1pIY2FuVWpyL2xKdWdPN01aOE5IRzdl?=
 =?utf-8?B?N3ZqR3kzT1NxL2tYdlVRbXRBSlBRSmNWd0wwM3BXUmY3anZ3MmFYYUgyNDhX?=
 =?utf-8?B?RVlYYzFGMVRHS3VMRkNOOWoycXM2ak5oYkNZa2hrai80YTFqcU1QL05OR3Rh?=
 =?utf-8?B?aWRrSFEwT3VtZ0FvMlFqN3ZZZnFzakFTUmI2dDZENURpd0NjS2piVmRxMGwz?=
 =?utf-8?B?TjZyNnlSTVg2WkpKcGk2eWhBYm5maW1XY1daSWVCYzFQNWxlNVZmSVpXZHp4?=
 =?utf-8?B?cEpTSDdhQ3FzR2VOZk5vbFgxZHpnd3gvd2hMVkgzM0w3UFJwUUpUbXB0L1VQ?=
 =?utf-8?B?dDNPclIvcXpoVG9EZjFuNEpxK1VmU0JHQm0ycDd1Q3cyMzU0TkdWemYyUjRI?=
 =?utf-8?B?amJiVzRxMW1WT0k3Y3FBZmNpZDAxTEoyOFpBSm10WXNzUXIvdzlFMWdXaE1Q?=
 =?utf-8?B?N1pHa2xFY2Jad2FPRjRzWGdKNUNxcE0ydkl2TGNuN3lUZVkzZXhHL24rbGZl?=
 =?utf-8?B?SnE1dkcxbUFCOEllYnBPRGQ1SG1ZZkE2SFFRV1dkMnp0a05YbGd3TXp1TGVa?=
 =?utf-8?B?MTVYVitpMUgvUVl1VWE2OW5kWStLZnNsUkxoa3piS1lrNHFReHFXYThsWGZo?=
 =?utf-8?B?Z2pnT3BiUHpZS0EwR2llNFM3U1huanh1ckFYME5JdnpXYUJjN3c1RksyaUox?=
 =?utf-8?Q?VyTCjvaq45FqPuXoAcU9g5OH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2604a091-36fd-454e-4c29-08dd477f2924
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:56:03.6133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p5xUxoOmgpLb1xGz2BFo8h71lcP0DK6Z0ePiMcJXS8AcxNtAlZnh9G3JZbZYnn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

Am 07.02.25 um 11:09 schrieb Srinivasan Shanmugam:
> This commit introduces enhancements to the handling of the cleaner
> shader fence in the AMDGPU MES driver:
>
> - The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
>    KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
>    that requests are handled in a controlled manner and avoiding the
>    race conditions.
> - The CP (Compute Processor) firmware has been updated to use a private
>    bus for accessing specific registers, avoiding unnecessary operations
>    that could lead to issues in VF (Virtual Function) mode.
> - The cleaner shader fence memory address is now set correctly in the
>    `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
>    the cleaner shader execution. This is done by calculating the address
>    using the write-back memory base address and the cleaner fence offset.
>
> - **Memory Offset Retrieval**: The line `ret =
>    amdgpu_device_wb_get(adev, &cleaner_fence_offset);` retrieves the
>    offset for the cleaner shader fence from the write-back (WB) memory.
>    This is important for ensuring that the cleaner shader can synchronize
>    its execution properly, as the offset is necessary to calculate the
>    exact memory address where the fence will be located.
>
> - **Setting Cleaner Shader Fence Address**: The line
>    `mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = adev->wb.gpu_addr +
>    (cleaner_fence_offset * 4);` sets the memory address for the cleaner
>    shader fence in the `mes_set_hw_res_pkt` structure. This address is
>    calculated by adding the base GPU address of the write-back memory to
>    the calculated offset. By setting this address, the MES (Microcode
>    Execution Scheduler) knows where to check for synchronization related
>    to the cleaner shader, ensuring that it operates correctly and that
>    the GPU is in a stable state before executing new tasks.
>
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: The checks for amdgpu_sriov_is_mes_info_enable were removed to
>      simplify the resource management logic in the MES initialization and
>      finalization functions, ensuring that the necessary resources are always
>      set up and cleaned up regardless of the SRIOV mode, thereby enhancing
>      consistency in cleaner shader operations.
>
> v3: amdgpu_device_wb_free(adev, cleaner_fence_offset); to release the WB
>      entry and prevent memory leaks. (Kevin)
>
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 37 +++++++++++++++++---------
>   1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index bf51f3dcc130..ad849ff2fa7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -745,14 +745,21 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   {
>   	int size = 128 * PAGE_SIZE;
>   	int ret = 0;
> +	u32 cleaner_fence_offset;
>   	struct amdgpu_device *adev = mes->adev;
>   	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
>   	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
>   
> +	ret = amdgpu_device_wb_get(adev, &cleaner_fence_offset);
> +	if (ret)
> +		return ret;
> +
>   	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
>   	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>   	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
> +	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = adev->wb.gpu_addr +
> +							  (cleaner_fence_offset * 4);

That code here doesn't make any sense. The function 
amdgpu_device_wb_get() just allocates a temporary write back pointer.

That is never ever a correct value for the cleaner_shader_fence_mc_addr.

Regards,
Christian.

>   
>   	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>   				AMDGPU_GEM_DOMAIN_VRAM,
> @@ -766,9 +773,16 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   
>   	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
>   	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
> -	return mes_v11_0_submit_pkt_and_poll_completion(mes,
> -			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> -			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> +
> +	ret = mes_v11_0_submit_pkt_and_poll_completion(mes,
> +						       &mes_set_hw_res_pkt,
> +						       sizeof(mes_set_hw_res_pkt),
> +						       offsetof(union MESAPI_SET_HW_RESOURCES_1,
> +								api_status));
> +
> +	amdgpu_device_wb_free(adev, cleaner_fence_offset);
> +
> +	return ret;
>   }
>   
>   static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
> @@ -1632,12 +1646,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		goto failure;
>   
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> -		r = mes_v11_0_set_hw_resources_1(&adev->mes);
> -		if (r) {
> -			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> -			goto failure;
> -		}
> +	r = mes_v11_0_set_hw_resources_1(&adev->mes);
> +	if (r) {
> +		DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> +		goto failure;
>   	}
>   
>   	r = mes_v11_0_query_sched_status(&adev->mes);
> @@ -1665,10 +1677,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> -		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> -					&adev->mes.resource_1_addr);
> -	}
> +
> +	amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> +			      &adev->mes.resource_1_addr);
>   	return 0;
>   }
>   

