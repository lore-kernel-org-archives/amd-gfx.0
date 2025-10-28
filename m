Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81E2CCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 13:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C1F10E3DC;
	Tue, 28 Oct 2025 13:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zup/mN5s";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B4610E3DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 13:10:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5T+QfC7oNaPhacPZbl9AtCfibJnulQryErS0LvL4nJJ5W0w+AppaUPvtH6Z0QU1VM4peYgiqGgff7eVaD0Dwy7S7BZXZ/E22a3tpa5gmYUmSkccXoi++Fz/KsuQPHoSHsYPTnrHS2rd2QfnqtWoz+T4+nDyuYXEzGJeAidZnMkxGyD/1rdPCoFdfxOht6l0l77C/icQCt2rvn5Ww+dL90bxov4+3+UgbbncEuRwRZcgy1D1rrYQW4UxlI3SGOwawsPwNri38yrgf0cI/+vWB6ZHN3avZoh5ah06bBiHEfMqRx9Uikr8KWoEoylFoer8rHMaG8oVoqObRqGbA8TLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs3NwUQ2okp2jk6wGXHJ/JIWPS1uBNit6EwAYK2dhCY=;
 b=fjC5fiIIZ06gjdYdkBA1YZ8QpN5M9h0idzi5/h/PmaHP44n4gN3JI4hJQROVJb7mjz3yO9FpArdoymSQEkV6BRrRN3cIlBdNrd5jjXSuhLWXM2ryVtf0d19oI5sUvU+KYDPlwu2GH6ZOIsf2OeOuesF5CXNVxolYu4tsOfMtI3ms4m+YAmYqXqgCCNWnHc+Nd6saHBZo1NVNeUJ7P+r2Q6Pfh0DBk3uLgcMI2ZoLBcfhXcp72dUv9bQ2eTIDaWUdaA9mpH4mVvg0tYN7r/ilavGZWLHjk0S4H70QHWZq/ePkAPs9J6pvdKT/13i/4A4SDIEaYc/FDWpief8kYDcn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs3NwUQ2okp2jk6wGXHJ/JIWPS1uBNit6EwAYK2dhCY=;
 b=zup/mN5sdSr+IqA3xWwvK1eKdM1mytf4R6YK/1CoHsNCoPz7GmUKrH/UqSGGvvVS3lXKgr1GvwfEPAKK5jVeLxNdKQSN/LHdSZvv+ecWxC5xc0YEcAd2n1+fevcq4bpGO79gIkE7wtDS0vzJjrRCWOpkL9zdVc236j6F5siDbaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 13:10:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 13:10:36 +0000
Message-ID: <724fa441-28a5-4dcd-b967-3054eb6ab3b2@amd.com>
Date: Tue, 28 Oct 2025 14:10:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from
 UMR
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-3-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251020194631.102260-3-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b32ff9-d068-4393-62af-08de16236254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjB2Y0xSVGpubU9aSllYUStNZkpHN0J6eFBnTGcxMk5ya3VLV3FsU3M4SEY0?=
 =?utf-8?B?WDBTUnY1aXkyTkhmSUVjSFZUREMxK2Z5cEtFdzE1SlNYaTJCZkUwRllZWVI5?=
 =?utf-8?B?MlNKZDhjaVhwN0g0dnpaWHpjbEMrV1BLV1U3UkV2QmM4MGQ1Z1BMZEd4QTln?=
 =?utf-8?B?MjhERUFMNHM0Rjh6N2t5ZkNSclNnZXBzbS9oeFMxNE5PWVpzM25zSmR5WGFy?=
 =?utf-8?B?QW9RUUZaQzdqV1lhSUlUU3Q0Nm93UEw0eVFzeTNIRTFiY1RId0J3ZXpvajZZ?=
 =?utf-8?B?TWsxQ3prMUpDajE0MDdiTVd1Q0owcUF1UWk0bjdnakh1emJwd3RXMGtSeWdG?=
 =?utf-8?B?cjlpTUs4YjZFL0k1WXkyckZPc0cvWFdxZURFNFJRYURib09hYVFVQ0EyTFk5?=
 =?utf-8?B?eUJkY1FjMU1YM2l0aitQcHRybnhaampOZFpKY2RlY090VzlVdUJKaEowTERq?=
 =?utf-8?B?bTBWSzhlazNoL01SOXc3aGtUMk03Zy92bDhLeTNPbXhxeXVXKzk4T2ZVNTRo?=
 =?utf-8?B?Nk0wb3ZrZkhza3VBS0cxd0d3VmZRYkJhUVVkL0V3T1VZQTQ1WGNJQzlIOEdr?=
 =?utf-8?B?di9BSmlDQXoyNVNZM2VUTHJGMjJhc09mLzNCeW5KbzVuQk9UV3FUMEFUYTho?=
 =?utf-8?B?dzJLM2k1NVFuVENEK2NTcUdOUDFxVHM1SlBzVWZxQTlwWEN3OThGSUt6T3d4?=
 =?utf-8?B?ZG1aUnNaUGlPRDNocmZ5V0UyQVVlQU12TmtkVStMbENPNlBuQW5jMVo4ZXpq?=
 =?utf-8?B?RThpL1pNODZZa1FEeEVEeHZPazNJUHd6ZjdBaURMeDUzekwyaWlGV0U4NVgx?=
 =?utf-8?B?ZmQyVC9vclVlZjhUZng1Ny9VNEhYbVFPeWp0T1NTRVBKQTY4MW96UE9ycVQ3?=
 =?utf-8?B?aFl4NW5hS1V2d0tlNWJUL00yeWZxRFlkSTROSGg5UmF3YkhxYUg5eTJPOGpB?=
 =?utf-8?B?THVXU3NaYVZwZGdFSnIybHpWTktMT1BFNFpZNE9EdlBOdDdPbVNTdzZXaWVN?=
 =?utf-8?B?bHFIblIwM0s2M01JZmw1MkFISWEwUXdtTWwxVVVKdFhDRWNzKzZJY1dDUU5B?=
 =?utf-8?B?WThrZUk5TVpYa2RCYkVXM3B2WDc5eDlueEFDWDVxOC9YRkx0QUxXYUZnRXln?=
 =?utf-8?B?R1loN0NtVGZFaDlPZFR4a29KSnVJSmFkSUxyWVRPM2pwdHhEbm5XZHFWbDBw?=
 =?utf-8?B?T2VrMHhZNnIySUN3RXRLYU9vSUZCT01uSjhsdjJKRkxhWUQvdkJWUjUwMXp0?=
 =?utf-8?B?NWdtdVZyU2o1WXYrcTNLY0hmNE1oRGNOanhidHN6QnVPT3lNMjBtYXVCSmxw?=
 =?utf-8?B?WDF2SHNwN3dsMFFvNkRhY2k1MEhNQS9yK2c4UWl6SXFNem1EYnh1Z3VQTHZn?=
 =?utf-8?B?bjBJUGN6RmhVcFN3MlRUdFhZVDFxVkJTZWFKaUIzZ1kydlA5ZWdhVUU5S0ds?=
 =?utf-8?B?bm5ETWVIZFZ1Wnh4anRzYWlyV05aNGZxMTlKTlp3SEg5SEIvL2E3VXFTeW40?=
 =?utf-8?B?Snh0SHk2UGc0bndRUUtTelVvcWFISmhmdHFBdDFVMzd0M3BOb0U5cm9ra3RZ?=
 =?utf-8?B?eXVJNHM3K2ROTjA1UnFkcStCZS83Q0lJY2pjMWwrV0luaHhERzA5QW1vT055?=
 =?utf-8?B?Zk5rT2pOaE9YM05yNWROdTNQQ0tzeHBpNDlXZ1M1TEpMaVYvUHhrWWdsM0NY?=
 =?utf-8?B?bklYTi9yUmlaWlRaVXdzMUdOMmxDQklHYllVZUNjMVhyOUJoU2pHVEozNk40?=
 =?utf-8?B?RUtudkhLdndVM1EwK3lFaFJpT1JhRFl5eXJLZC8yK0tjU25FcW55TGU2N1hC?=
 =?utf-8?B?Q0o0OG80WlBMc1djV1h1ckEvbnBvV0RsMEphY0duUk1VM05iVG9HRExpaVNF?=
 =?utf-8?B?Q3EwTGEyOWpJVkpRMU9SZldXdlpHK2w0T3BWVW9Kbm9VOCs0YVU0VkNkM0Nh?=
 =?utf-8?Q?m/yd4k5z0/aTQ2HyHTLy9nwgryy4j3gF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3IzNWNEUlZiV051RHhFMlkrQ0ZGQk85cGxCbGVpd3dCODZpaHlQWDBRcitS?=
 =?utf-8?B?d3JpaU9HNXJxWTJCR2kvSGEvOEU0QzViMElTY1lvYUZwWmNpYVJxQmJudGda?=
 =?utf-8?B?Q1RjbzhmYWlqaml5MGttazlGZVFvS1lkcHdmT1RTdmFpTHJLZFh4OHVwQndx?=
 =?utf-8?B?RDNHTmxYRDlOVnZoQ29JbXZJdG02MCtQdnEwUjBtdVR6cmhoTndHWWxrRzBE?=
 =?utf-8?B?ZFhJQzRlRU9rLzFNVWk0amVlRlN0VEc4T0ZkajlQQWxKZ1cwRkhsMkE2ZEx3?=
 =?utf-8?B?ek5nS3dRdEN2eW5IdG10OFVnVlRkWnNtNURXK09WVUIwSmVvMWQvc0VIaVdP?=
 =?utf-8?B?SHd2NjNWbXpzcy9mOFM2NDlmVkRyMHUyQ1FuaVBSUUFPckNuRUswY29uR1h2?=
 =?utf-8?B?b0YvRWRrTGd4YldPNEpvY0RaUm5KYll1Q0dwOE80Tk1tRG9BbnhSRmY2NnJ5?=
 =?utf-8?B?QmNtWDBnVTB0QkdqRXBOSkVoRjZzd2NPdzAvREd1UVp5YVE0dVlQMWNpeXVS?=
 =?utf-8?B?MlVwZFF6N20ybE9ZZmxTNk82VUVsTUxaNnc4NktlOW8rZC9JYWxaSm10cXRq?=
 =?utf-8?B?WWh5OE5HVTZIQ1dLSlFORjVXTU50dWp5ejN3UGZvRWVLWkUxTXRuWFlRbVYr?=
 =?utf-8?B?QkVqdzJydW1laVR5dXdFam8xRVlDdHBBN0ZwdXljZEgvZjNyN1Iyb3REOC9h?=
 =?utf-8?B?NkUrTzU4VUo3NFE4STlnL3c2dzJhMnJZM0h3c2I4Y1M1bldWTXBqUERjMitn?=
 =?utf-8?B?UnpDZllzcnNISjZiUmxSUDBGOHFJMUszOW5lQWlMK3BKZjY2emZWQlk5MUlm?=
 =?utf-8?B?UGhpZ29aV29MRGZ0ZkxEUFd1dzhTR294MGdqdFJSRTRHRzRqUGFLc2hmbDBx?=
 =?utf-8?B?cHJMRXd0aDlvT3l4YkV6TnQrZHIyK0R0aGdkZFhYVkZvbVFKQVVpWGFRR09q?=
 =?utf-8?B?eXFTd2RCcUZCUGRtSnFvdlBIUk0yUUdickl3Uk1ObTQvY0IvYVpCZGQ1enA4?=
 =?utf-8?B?SC9vamtRZnpPWEhFRVBoN1FVejIvTXZmYTJGTzdodnVYNS9aT25mNWx3dEps?=
 =?utf-8?B?ZnBwN1lLZXltdFRjd0ZrVi9rNG40eDdRWUp6UFgwZXd0bThXTlFER3lkVXB6?=
 =?utf-8?B?dVBWS0hWaHY5clRkS0RKeWlzQWNBOEJOMUlFVEFtVnJtbUx1REhCVjZsKzd3?=
 =?utf-8?B?eVdIanhyKzM1djVtTnQ5aVhGZEgrdnREVlFKdnhjcmNaQ3lMMlBlUEorSlZL?=
 =?utf-8?B?TENzVDlIbHVxNTNIZW0vUGI5QVROQnQwb1NFcVZYQ2c0ZlZ2ZDFUcDRmUGls?=
 =?utf-8?B?TStmWmUyTEMzTFBaR0RUUEk4R1NZZWU5azF5K1dXVFg4NUlnK3duZldSV1BW?=
 =?utf-8?B?cWtOc0tFaGZnVy9wTzdReFhDcmNqbTh1elBsSmFzQ1dIazd5dzZob3VDWTVx?=
 =?utf-8?B?RXhVQzh3NTZZdXhlbUxhZE0zclhwZE5DTUE4Lyt6cXdVMTN3VHU2b2t4NENn?=
 =?utf-8?B?YjVSWWhCK0pGOWh0aVZES3ZlZWpFNFJlVFNrM0ZsR1p1SXhEQmpjU0tLZFdh?=
 =?utf-8?B?YWVLdVphc3BsMjJ2U0dKcEJEWWpob3B4T0VSUFRSaktDcktBRmRLakgrOU9U?=
 =?utf-8?B?bHg1ejB1KzJZRDRJRVRXYUNGWlo3ekpFdSs4R0JYdlIrYk1kM2dIakxpSXV6?=
 =?utf-8?B?Y09ITWNDbjkrQWdDU0ljcFpLZzdkTDFqQnY4QjdhVENFd1YyUnNRU29kenZo?=
 =?utf-8?B?cWZ3SHFDWURSdE9WWmhYZkVFSEx3V05NTGFxMHkzV28veU00N3pyOGI0M2VG?=
 =?utf-8?B?K0JsdHAraDN6VTVMOHVTSk84RUhJSWRjU0VFMzdWRkFGVXRyU0x5VWFxYndw?=
 =?utf-8?B?VGlNanNoOUYrOUVzM0pYeTJxRTJDcDBHS1JuYzFZcDlaUmdIWTVCSVA5cXV4?=
 =?utf-8?B?OEFIbTd5ZTV1QTFUeGVpSTNEYjVFOTdIRElkVmhZVVEvdTl1d2FmbWthMEVH?=
 =?utf-8?B?S2p3RTl6d2NRUU1ZZmpwYm9iN3ZKQkpwbFlXQlVXQ0Vmbk1JQ3pRVFU4VTlP?=
 =?utf-8?B?RTNaM25RdkdBcTBpcEd5cFppVHgrNzduaHBpVFdCeExoR3dBZEVHWk56bHY4?=
 =?utf-8?Q?FYTLTkEVyCpgCzYzikVlNrCLA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b32ff9-d068-4393-62af-08de16236254
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:10:36.4192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AdaH/4jjyyIE2jP2PX7Dm46gYSPaHTlR193oa8G5R/nRa2FMw+yROrsHS0KOOEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

On 10/20/25 21:38, Rodrigo Siqueira wrote:
> When using UMR, a dashboard is available that displays the CPC, CPF,
> CPG, TCP, and UTCL utilization. This commit introduces the meanings of
> those acronyms (and others) to the glossary to improve the comprehension
> of the UMR dashboard.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 30812d9d53c6..eb72e6f6d4f1 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
>      CP
>        Command Processor
>  
> +    CPC
> +      Command Processor Compute
> +
> +    CPF
> +      Command Processor Fetch
> +
> +    CPG
> +      Command Processor Graphics
> +
>      CPLIB
>        Content Protection Library
>  
> @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
>      GMC
>        Graphic Memory Controller
>  
> +    GPR
> +      General Purpose Register
> +
>      GPUVM
>        GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
>        virtual address spaces that can be in flight at any given time.  These
> @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
>        table for use by the kernel driver or into per process GPUVM page tables
>        for application usage.
>  
> +    GWS
> +      Global Wave Syncs
> +
>      IH
>        Interrupt Handler
>  

BTW we are missing an entry for "IV Interrupt Vector (the bytes written by the GPU into IH ring buffer)".

> @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core at
>      TC
>        Texture Cache
>  
> +    TCP (AMDGPU)
> +      Texture Cache Processing
> +
>      TOC
>        Table of Contents
>  
>      UMSCH
>        User Mode Scheduler
>  
> +    UTCL
> +      Universal Texture Cache Line
> +

Mhm, UTCL0 UTCL1 and UTCL2 are usually Universal Translation Cache Layer 0-2.

That is not even remotely related to texturing (well UTC requests also go through the TC on some HW generations, but that's basically it).

Regards,
Christian.

>      UVD
>        Unified Video Decoder
>  

