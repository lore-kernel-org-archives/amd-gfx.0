Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D8D1A639
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 14:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3D610E8DB;
	Fri,  9 Jan 2026 14:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L408MHBo";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1012510E8DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSYjo0ZQ3u8PWiZ6mtwVisX1QRB597vloAO9aYiRMB4HmrNq39Qho1p+/ptP77PXtpEdA+HgR76ALe8eB0p5TdHO53TX0ZQqGCt/78xUl0wExFOl1epuEcb6oXNTtM/w2iSIyxD+LuXXgOb9GWNS9gM0s/vYnxx/agUhXQbWCDKZJHqmYVVII9z/mBZGecTKC8DXdtgqWQ1qmmNkA6Fe10jBdeUDm1dawV/cBWDk5//hr+HNCd4N7MMnR0p7XegbAvBjvmnHGdVQZ/1cHYdTyPOD6NdPljpwvIiTV/L65Xq22paNCqphFsfw1PnwW+fwgvRRa8n7z3xlu7iPQI1m1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bKwt9xhCBlb6PV+Tv9f0UdBxpKPBrWiLk/wnQxP1Gg=;
 b=X9JC4XzYdyshhR/X+8ScTySjKG+ojK+jn2dQfgMa2QAMzWCw+BwM+5PeM4Q8TtRxuyMBYNNN6Nca5hPyvtG731Fh+v0bd5ZKA+NFd3SZpm+5gUpjF9y6kyzfihk7+Mw+t0NuTJ/N44gHxLEc68XsTJh4BSS5LuIU1sMrgpURMNkeEzlnFywjMbRrzZ1Mb8t/AyW4hfslwubRGBLYgkU1XKwBLrJhIPebnHn6cNxnttrVsI4U8AeGY3nitB76SFVAynw4t8a2maXfzkhuEdMk026i0l118TUnFhLxUOr/D5p1cCm4nWsrmjrZKyn3F+b/veWjj4SK2JE2dMRRgFrQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bKwt9xhCBlb6PV+Tv9f0UdBxpKPBrWiLk/wnQxP1Gg=;
 b=L408MHBo/3q7SLzXJZxNNfa2HHsVZ2yLLoY1sxEptgQJxWx+Taf5E0IACuMbQxtveims+aJI081uBjCw/Qw5r/yT12Qm0G0cVP2L2IL2hm2FqCLU0HQln38M/KRJAiI9TMeCFd9B24N0BnbKeGKjjpytF6bxfQRbucXMmdbNbAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 14:28:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:28:18 +0000
Message-ID: <30405899-ce8b-4abe-b170-5d52c9065d35@amd.com>
Date: Fri, 9 Jan 2026 15:28:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: make sure userqs are enabled in userq IOCTLs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Prike.Liang@amd.com
References: <20260109135743.3241773-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109135743.3241773-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:408:e5::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: d04f31f0-f8c4-4e50-a5fe-08de4f8b5569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RndZQXduTmFLZ1BIaFhiS3Z1Qmx3YmxOdDZiY0E3SDA2RDRLK0Q1SEFCUC9m?=
 =?utf-8?B?UzRlYjFsMjhVUFRmcEJ6OGg2WWdDNGR1UU5Qazk5Q25kdWw0S29RYWZDVVhs?=
 =?utf-8?B?amdYUXljOXlvakkzclVLUzZ3aXZwT0xIazZpU1VwYXJwaTZ4NHUvZWZmMmdo?=
 =?utf-8?B?dC9QNzcvam45eFVaandPTS9uNUMvL3FtZGhlMkV1Rm5IOWtnQ1VZaW5rNzY5?=
 =?utf-8?B?L0RhMFFwZ0J1dUJYN2VWZms5UWZPajA0UWNPS1B3S3lhV0FtcENuNUdJeU5i?=
 =?utf-8?B?WkxqN205dmdYdmM3OWs3T1cyNXFRQXFBWXg2UzRGTWgvdDBQTjBtMHpsV3l1?=
 =?utf-8?B?Y20veEN5U2hraVVDS0FmUktwWnl3Rzk5VkdQY096bTk3MXBOTFl2MzRqdkU0?=
 =?utf-8?B?TldUUkFOS040Vm15b2JSVFNlVXpVcUdSdCtPNm5OSlZrZVg1VnkyV3Z0c21U?=
 =?utf-8?B?ZnNNUDB4U2RRdU8wSGxxSWRxNlB2QTh2S2Nhdjd1am4zeUtkTmJhdkNidUpY?=
 =?utf-8?B?TEhMakZtSUJudXQxS2NqdHMxcjlMYXE0QmxFVGNZa2l0ZFRlYS9kV292cjdD?=
 =?utf-8?B?emdVR1lWclE3eEc1N0pzTmV5ZGxCSDVQcHZjSVhLNEsxL1FBVjg1QWdEbDBt?=
 =?utf-8?B?TXJzY0JxMWIzVytIOEpFa1Q2UG9ZcXFERVd6c2VMa251QXpvWTdnRnhUOTUy?=
 =?utf-8?B?SS9ET3NxYnNhV1dMTko0T1F4MkFvVWtMOHJqQnhIU0t6VUhaYXNXLzNJd1lL?=
 =?utf-8?B?VVpqL0w2Q1ZaNmRIWEU3U3pMNVZhb0Fza0pJV2VHTGZybjd3K05JdDFSck5i?=
 =?utf-8?B?RFJYdWFrZVVEeGtYcTdpb28zbDVSM3AxVkRpcU5qWitDbnFiNlN3TWtGTVRB?=
 =?utf-8?B?MFQ1U29mdFcrVkFsTWRyZXhEQkc1Q3R0aXYzZDdLc3g4Z2U3a1JLczk2bkFw?=
 =?utf-8?B?Z3VBZTBhN1AwZXpqYTZOMGdRQmNoeXFaTk1OVTd5TzZ3RzMvVTUzWVBlek1a?=
 =?utf-8?B?dWNBNkQrUSszSGdrN1ltSGVzci84ZnVCOGFRRGI3TUpmdDExTVlNZ1hDTlJk?=
 =?utf-8?B?TXNJblFGYStleU5seU5NNitSdDVuNFBiL0F6YTVoTTNtQ1JTNHBWNEVXMUJF?=
 =?utf-8?B?NjhSZXdqQkZNZzZQeFltU2d6b2lUd3loQ2hES1dFK0dSUUtCMWloM0xGYnhT?=
 =?utf-8?B?bk4yaTRlNXU5YUl1QjhpMXJiT1RMblJ6eGxyaUxQamZDUUlWTVJhdkxaNWRv?=
 =?utf-8?B?cnFRVmlqWlRGV3ZtVkJ6UVVBKzErVnc4OS9QUWE4cHhEL0hoT01FVWpubGR5?=
 =?utf-8?B?YkVSK1ZiK3BaOGhuSGJTYmwwbWYyQjFtODZwS1NDL2F6OWRSKzNXL0lVTjd0?=
 =?utf-8?B?Sm5WaVlEdHd6SHJUZlg3ekFhMHdtTkpZZTFEVUhGNVY5ckVvQlA2YTd5dlFy?=
 =?utf-8?B?MExwQzUvMkQ2bDBJdlFxRUh5c0FqSW15VGZURVZJbm9ldU9JLzFBazBuOFY2?=
 =?utf-8?B?RWtZWnQ5M2poUmNCRmluNEIxa2NtQ0tVZlI3d010SGhDaVVtL0wvL0x6T1dH?=
 =?utf-8?B?Unc2ekU0M2NZUGZoT2ExY001WTRSTm5pVEdVdzV3dXpQNWRjVWFvdUduQVRM?=
 =?utf-8?B?SU5MNDhvZ1RpdDZ2TnJUS2R3MEViUWswdHcxdWFQWUJTMmFRTWsyVHpnVllY?=
 =?utf-8?B?b3VkRityaExpRnR2dWV1YkpBbW5RcjdhdEdQM2J6aUQ0M013L0lmQ0U4ckRV?=
 =?utf-8?B?dlBnUHVENkRNbVltVXJuNUZEQWpqT0graGgvS0kzcC93Rkt4QmUyOEZXNERZ?=
 =?utf-8?B?eExLbWZ1SXNXRzBTZnN2NlJYQnJPcnlGcWtvdGViVnZBUXg4MFBnZ282SUZq?=
 =?utf-8?B?b2kzMzRuamw2bnQwbHB4aG5ETHdMWk5nR29yU1dNM1NuTWN5b3NrVjJxSVQ1?=
 =?utf-8?Q?5PIa8m/NcnME6jB+4rTszvJY7CmZfEEy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjM1T0t6ejVzanU2SmJyU3EyUmdXY2ducXZmWDhIRnoxMEpmV2U0UEM4MXU4?=
 =?utf-8?B?RFVHQ2V3bWRUTnFBb1ZtMmd5NVdXZk9mK1QwMmxFdUcyV0w0QlVobVdpdC9m?=
 =?utf-8?B?S1BqdXh6YXIrM0FobHhDWDJJWGl3ZGF4eVpqS2RkdUxuT0RUcks2SlZ3Zjcy?=
 =?utf-8?B?b3BlOWN5N2x1K0lvVnlhTlA0MnZka2tZUmdEWVZDYWJ6MDBzM2x5V1k2Y2ZK?=
 =?utf-8?B?ZmZ5MHl3OXRrYlFTSWw5NE42Q0JQcjAzUEc3NE5nYjZGVE1rY2twMmNWd00y?=
 =?utf-8?B?dWpPOEhTYWpXaDkyNzZsWS84ZkZwbUFsM2J2dlptd2JJNW1PYWg5RFFud3J2?=
 =?utf-8?B?bjQ0VkFmZ2VlVUJkdnN4U0hBR3o4b3pWbUpqaDE4V1pwRmxaSHN4ZDBLcElZ?=
 =?utf-8?B?eEExaG5XeGltVmFHN2dVS01QTTdhQnNNVUtua0tSbE1lamFNMWhXVFQwNTJ5?=
 =?utf-8?B?L2NIakplZnZUMGRWaUFBcXRGTEdsMEJtQTBybGUrVlQ2K2VXY01kYkREZi9O?=
 =?utf-8?B?T2w1K3d5ek54cHBHTWIrQXZKYk9ZUVMwcVVwWmZDN3JrMjU3alo5WkdHQlpE?=
 =?utf-8?B?anlwaFBxTFBqbS8wZXd1ZlczMTFlQlNtWTBnZlV1ODhjT1JQT0NXMjNCTEdT?=
 =?utf-8?B?dEU5VHpXcS80THZtaklEWmlYWE5qb3ZiQjJZdjlySlRGMmw1QTljSWpTL0tG?=
 =?utf-8?B?a1RpRFRSTHZrMW1hMjZsVUtjdXk1R1U3NDVxQmNjTHdBeThSTEswbkVWREYv?=
 =?utf-8?B?THJWdzhMdlh4Uk8ybCtKMlJlanlBOGtrbGVnaUdwSHZCa0pNZW1GTEtpSGlD?=
 =?utf-8?B?VVlncDlwU0ZPZkJyRHRQNnExR1IxUHlwVWdnNW9GbUxzdFVDd0VIVWN4SzFG?=
 =?utf-8?B?czRrbjgxTlZDUENPUjJ4MCt4TjhRRDlROHcvN29oeVBESEo4ZndIS3R2Q0Vk?=
 =?utf-8?B?MVRiZGRMWEp4N0xhcHBwUC9DbFovQ2t5NnFzWXk3aGNDdGtFVW1YOWtxd2Fm?=
 =?utf-8?B?R2JNcS9wcmtxa0R4QkJHeU5SRDN4cnhBVlVUL1hsZDFVRERnTzNzbktCZE5V?=
 =?utf-8?B?R1RZUnNCWjkwd2IzbVpDOW9ubTZZS1J3c1ZMQ0QzSzEwOUgwTGROcGVUK0xH?=
 =?utf-8?B?N2drZWxIYkRZcEdNZEtxVWFqNyt3bHpKcGZaeklXd1p1MjFoOUFRVjIrWnh6?=
 =?utf-8?B?SVhzV1BDZ3dDYXR6UGxaWUVkT09Qek5rL0N4KytJMy81bjEvejJHYS85dkNy?=
 =?utf-8?B?bTVtbXB5eE1TYTJEdlFJUjViM3hESlBvMDNuc0VwbE1MeEhFaldLTDNqc0VJ?=
 =?utf-8?B?SVlURXZQdVcxOXI0WURVSG00YVcyeEFKWldKczNsWXQ3RXRqZzRhUkl5aUlL?=
 =?utf-8?B?Vi8ydHlNdVptWmlPdDh4cDJaSWFPWmhsald0emFjL0dTb2pmUm1GNHBjSlRT?=
 =?utf-8?B?clExZzY2SWk3ZUJiQkdWei92SjU3OS9walBRT003bk9Sb2c5aXVzejdFT2R2?=
 =?utf-8?B?ekhBRWxsTEFDNk00dGRqQktiVngvRSs3S1Bza1JGOStoYlR1S2NSUElFQVVm?=
 =?utf-8?B?OWdnS1hCbVgrY2VtN3VkVmZLR1JDS0t5NzRWcW5CQ3lqMGJWejh4YU1hTVFi?=
 =?utf-8?B?ZHcwL0E5ZjlVMmVDa0ZLcVVnOHJqMG92NGpodVladGd2TnhXN0tFS3FjQjZo?=
 =?utf-8?B?eVh0dzBSYVJzQjRrYmhBeVNMVDBkZDdTR2lkZ0x0VkdMaGlqSHErTjA3anJq?=
 =?utf-8?B?Vkg0RUFDSmwxZ3F2cXZmWkRVU3hWdCtCbER0N2JpZEdQVFZWU3dEWWVDMEYy?=
 =?utf-8?B?RGxXVGU3QzA3LzJ5dmpPeUN0c3VCUS9qM3VKazJRNXk4elI5OFE0M09EY3VF?=
 =?utf-8?B?ZnFVU1Q3ejNob3JjN1NwNCtJNVhmZm5JUkh6RW9yd3dBMjhBNzh5c1hQS0ZJ?=
 =?utf-8?B?SzN0aU1qZ0tFZkl4WHp4VFk2eS9ESU1Td0IvNmpUQWZ2KzFsQkYrQW42ZU5N?=
 =?utf-8?B?eURKUS9qbHFIZmRDUm00SDBINDJJRUxkNHJIb0k0VUp4aDA3U1owZ2JKbWsz?=
 =?utf-8?B?My9tZVlnWEMxa0cwTmV1MU5Lc3NnaldLN0QzTjVNYmpOdncxaFlUYXllQjdk?=
 =?utf-8?B?SmlXTzNqOStLSDJaRTRFQzIwamkyaTVLZnMzRXl4Q0JmK01tS2c4SERrTDNo?=
 =?utf-8?B?WGU3eHphMWNRY2hHRU1PSzdVc0FHTkpNRmtRNWxBWlplTHE1b1lZYUZGTFNx?=
 =?utf-8?B?Z29ObFJmMkVhbnlueHdKUUFzSjlyaVphS3ZQY3NyeWJUcVN5T2FJVUZrdmNJ?=
 =?utf-8?Q?nrPbl8u2tMRN0TjiqR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04f31f0-f8c4-4e50-a5fe-08de4f8b5569
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:28:18.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71vFf9YOkDyAXDpqP7kiFQf+MwtLO5bbaiuAcDrbzy2yoSqDiDjjC0x9VxEnso/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

On 1/9/26 14:57, Alex Deucher wrote:
> These IOCTLs shouldn't be called when userqs are not
> enabled.  Make sure they are enabled before executing
> the IOCTLs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  6 ++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 98110f543307d..256ceca6d429b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -888,12 +888,28 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>  	return 0;
>  }
>  
> +bool amdgpu_userq_enabled(struct drm_device *dev)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int i;
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> +		if (adev->userq_funcs[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		       struct drm_file *filp)
>  {
>  	union drm_amdgpu_userq *args = data;
>  	int r;
>  
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
>  	if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 7a5ec17704567..468b65d953b0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -136,6 +136,7 @@ uint64_t amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  					     struct drm_file *filp);
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
> +bool amdgpu_userq_enabled(struct drm_device *dev);
>  
>  int amdgpu_userq_suspend(struct amdgpu_device *adev);
>  int amdgpu_userq_resume(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 1a23e7709dea9..d6fc65803a309 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -493,6 +493,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	struct drm_exec exec;
>  	u64 wptr;
>  
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
>  	num_syncobj_handles = args->num_syncobj_handles;
>  	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
>  				      size_mul(sizeof(u32), num_syncobj_handles));
> @@ -680,6 +683,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	int r, i, rentry, wentry, cnt;
>  	struct drm_exec exec;
>  
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
>  	num_read_bo_handles = wait_info->num_bo_read_handles;
>  	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
>  				      size_mul(sizeof(u32), num_read_bo_handles));

