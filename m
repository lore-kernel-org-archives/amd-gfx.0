Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CD2C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 12:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07D710E8C5;
	Fri,  2 May 2025 12:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uP9gtu2S";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0867F10E8C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 12:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRE1hi0kTdltXl53lcS7QlL6kSvqLLmAiFwbeYmUm+E3qyZjSX4X15hnN8K1SGW9wbjvrHChZcd97cYaa986JbG5V3/irhs1HDnmWM8KbKPmzW98hCnsamJg/AfpTS28sRIRuPwMeL7B5UUbbjgPpFkTokPr7tf5OJ+FQ++SzEPfetL8b9CajdNcoQG3jYN8rFhDBlrnQjn5zSG/HoZKttpRqjJ0+xpep4R5lY78/XDPnhNsDB18KFA2mnMLr60kaTJe6yu9B8gTgwTBa+FlO9W6fUZP4yzoTMgO/pgRRg0OwdaFSiCPEmuYZx0fJjKW1wvzVUV+Xv8l8TdGg1H/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VSdaXAP4wdl9WdkSoIKIFexmIwVh72NNLPIwZwFrGQ=;
 b=yRaPwT6JCtp8xGp79e/UgiyObh70eiynugdVM6yBX8NDylvBbKKmMXhiQ6C0B6ClXXjhMn7aym0ROuT90Gj8F73tO4yJuKU36hjAXOMVy5IFesPX4NGndddqYBASWvysxgpHrye2cSM/k/aL8bZWEqX2k9kLDIt3h/O5VNRBW8OvRW3YHPPIzeYuHDjsEqDenuDDvViQjmszhAnDcBqVM6lrWV/62zB4Dgcw/nBlmlU1iI5IMj4+UGFgN9QfmH0XNUWgYkDiPeu6VcTbG8+7XJlhYl29DBh5b/fFb8UXGHbJo35PMw4eTvlcN6sGTJJVQA51sQrcgNLYHIh7npme5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VSdaXAP4wdl9WdkSoIKIFexmIwVh72NNLPIwZwFrGQ=;
 b=uP9gtu2SO/zYrYWsHH9TBlHXkG49oOHuFBm2m7lz5cJ2xKguZY64ZBC3qDDhW/GY480O2HmNSqdORWBXmAQ2IlLnOwbhpC0hmu0p9OwjzvAufephJdLJe/pdqzE0LwVdyBu0t15SaaolLQtiTrqmFoMpNSx0qAeHCLDAPz0UswE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 12:42:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 12:42:42 +0000
Message-ID: <20609a79-6b02-46ea-abe2-4056b00264d1@amd.com>
Date: Fri, 2 May 2025 14:42:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Fix userq ttm_bo_pin and ttm_bo_unpin
 lockdep warnings
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
 <20250409054831.2411-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250409054831.2411-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 085bf093-d49a-454a-3ede-08dd8976d4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVIzMDMxUXE3ME0yd0VqQ0Eydm82ZWt4ODNEYUJkZGxPVE9GY3hDanZ1bVZy?=
 =?utf-8?B?OE1Ldmx4Y1FLbkNyTzZCVVBjUWRxUDJPakpXQ3lISjN4dTMzVk5ZellYSXpz?=
 =?utf-8?B?a1RlZmo2Q0ZRZDBSRzZkZFJmRDRrVUh3WlhreFRVNmhicThqQ2VGcVc5KzZM?=
 =?utf-8?B?UDE5aktFS1NrUUVmQzdpSStldmRBMHd2M3pJcFdkSmNQSURvditSV3Z2UFhX?=
 =?utf-8?B?NmpGS09tMXd5QkJFSmVxNFFjT2VFY2I3eHk1VGZpWEJhSGFIUXFxd1gyZk5G?=
 =?utf-8?B?b1dmVldiYUNzdmhjVEhTVU1va3dEUUFZTXRoc043bER4dGdQL0lyQjI0WG5r?=
 =?utf-8?B?d3pmWjRuZ1Z5NEtPaEdDNXkrV1ltTnI3WktncXYxWlpST0tid0tERGVJd2RJ?=
 =?utf-8?B?U20yeHlSek55YmR3TzRGYnVveFdLbEgyRENJMHRJZ3U2THNvUTQ3bHo2Z3g3?=
 =?utf-8?B?UXBNdzYxK2h6UERkeTZHVmd6VlBXamYySUF2UDY4UzNnNnVqR3ZuUVJleE53?=
 =?utf-8?B?L2tzajNjbytWbnhCK2FDYmY3UXd2UjhWZnJ0V2E4ZTRDcWpaWjhXc0pnZ0g0?=
 =?utf-8?B?WFplVkF6Q0VEb1I0UEh3eWFLWFRvenhPRVNWekxYL2VEcEd4eGRyVFZwL1J5?=
 =?utf-8?B?d2cySlNJVkJqR2kwZTJGdDBHZVhwcnBJWlQwTEx4RE5BUzBsM1VXazk3MGZt?=
 =?utf-8?B?QmRzelRzcWpyd2pTWC9hRkorOHp0RHNjTW1lQTBDRTZSbGhISHMzZUZ1VDM0?=
 =?utf-8?B?akg3N1FjanJkRitBYXVZOEZvRE5BOTJxcGhJOCsxZVhRbnp2UEVzVHh6aUtt?=
 =?utf-8?B?R2F2L0Z2ZStWUnFYa2huZlhmdGFkZTZ2Wk5oaUR1c2FzOTA3NWFVbTNRNEhm?=
 =?utf-8?B?U1hsZXJqYkVPd3YwQkkwQSt6RmQrT1hpVzZHeTR1em8wM1hucXpNR3hFYnJ0?=
 =?utf-8?B?NTdiREo0L1ZTRFkya2MyaDdHSjlidFk5c1MraFNLeEJPUEhNdnhnVEV6T2gr?=
 =?utf-8?B?VUo3R01IRmFoa29SS2g2NmprRit1ZlBDVXVRWEJ1YXhqTDJrdStEZmNXa2ha?=
 =?utf-8?B?YURrL2d6K0tpT29UelRrWVp5elhKV1Zwd2p5anZ0cm91eVVYYzNraFhTV0w4?=
 =?utf-8?B?UHBWZ0IwWHRHOGJvbk1qS2NMOFBnUnhSUVhkVE5BeFRLcWtYMzFLNzNLQlY3?=
 =?utf-8?B?WmdVdG9jcllBeHhOVC9pdFBjeGJNaVVhbDRUN1BJNld3R1JaVjRPMzdGQVR6?=
 =?utf-8?B?ZENraGk1enduQitRZmNUR0s4L0ZDWjZ1dFZwZkg3eG00RXpXUFNnc0kySGcr?=
 =?utf-8?B?TWlJMnRJZGR1RHdKUW5kcWlFaGtTKzk5RzExUG80SC9heW02RjIvWkYwMEky?=
 =?utf-8?B?TEZYSTVSZ0M1OFc2aHVjSzU3bElnMzhtQklpTk0xc0o5aEZiMlpFNzN3azFY?=
 =?utf-8?B?eFNIOW5adS9UdGN2bHEvVGgzTFFkVTB5WVgxK3ZzWGxXL3Nrek44bXp1OHdO?=
 =?utf-8?B?bVlXeStYeEFBbjJpZzNLdWFKclArckZoNnNheWxOcEl1ak1BZWpMWmFaelZL?=
 =?utf-8?B?Qjlia1psNWh3b2dQZGhGRTlxLzFlaDZVUFo3YmEyWHFER0dHbHU1Nno5TFh0?=
 =?utf-8?B?MTE3WFptUUJObnBzbXdSVGNzck94S3g0d2taZFVNN0RPaGZMWnBDWVJKOFAz?=
 =?utf-8?B?RjdwZjF3emduNEtZQnVkNWlSK1JXQkRKVjF1NDdvOE1wTU02WXJDSnI5NXph?=
 =?utf-8?B?eWptUE1qL3NvMGtNenQzRUF5SWpsbjF4QlpwTGZnbXJ2Ri9lNGR5MHFLY0c1?=
 =?utf-8?B?MGpkcGxUSVBGYTRIRnBLSlNteWpqdjRWS0tSUWNBWWNVcC9kU3puUjBkekdY?=
 =?utf-8?B?bFdWdU5BclMvdk8wN3F3UlNTNHVrNkFIOHhSZHhNRm1rS0pQZzkzYnFsTkFw?=
 =?utf-8?Q?i803E8Q6b2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVd0VnpSTkQ2M3llZ0R4L1FsUEdjQW9OQ25rZDZpSUZsK2VDNVd4amllR3JV?=
 =?utf-8?B?ZGV2Z0owcnJldGx0Ym9ueVAxRlB3Q1RMOFV2blp1MmUxS2ErUTUybGFIMVFK?=
 =?utf-8?B?RTJVQXBCOE44Z3RTLzFoOVgvWlpRVFhNVlozVTJZM2g5czQ5ZEJzV0MrOTFy?=
 =?utf-8?B?eitRZTZQcklKVkw2VDJwVjZURTdWazBvc3Z3cnB1clFVbStmbGdFL2puY1dQ?=
 =?utf-8?B?QVBLL055TnljSmo4bnBvZFkxK3diQ2E0U0x2QnVYTnRuVXlVUElvbFkwemgx?=
 =?utf-8?B?d1BDc2gwQndrNU53QWN1L2pFRnBDTDlUWEFHRHBkWWMrRmJmZFRsVmxDQ0dm?=
 =?utf-8?B?c2xIMXdsUVFUWGhkL2tjWWh1VmFKQTIvSjhremtYbUlQY2lXK1liZ1J4ZllP?=
 =?utf-8?B?dndGTkp3QzhEangxZFRYOHZhUlZlZHNmMGh3amRRakJ1Y0ZwU0JsUkZTWnB2?=
 =?utf-8?B?Mi9zSE1MZjVuQ1R4WlBkbXdsY3M2SklUZ3djbkM5UVcyQkUzcFpTcW4yekt2?=
 =?utf-8?B?L3pmVHFnaHU4KzVXRnoyRE1ITnJVZzZtN3h1K29wdmM1Z2JtUlJ4VGpzbnVh?=
 =?utf-8?B?ZUcvQWtDMjdWQURYa2oxa2NtQVh0U2R4czFnQU9pVTIwTnZSaGtGNXYxZDhz?=
 =?utf-8?B?dGNwWElsQWNKeWl4T1c5eVA2b0xZck90NTZFWFlOcVh0a1hyQ3N6TXBhUlVh?=
 =?utf-8?B?cEVsSkFoMVNSZnFRQmh6M25yOWhnSDcrNkdNRVl1UTM3M05rL3VNS3BNR0hU?=
 =?utf-8?B?OHliUDZBa2w1cUZleDdYbVBaU3d1OVVNUmRUL1ltd3B1RU5tdGhHcHpsOXU4?=
 =?utf-8?B?M3ZwYTFFRjlkN2V2NkVpa1VZMGNjejhKNjVBOUwwbFVObEtpbG9pK0lZTHpi?=
 =?utf-8?B?dU5zQzNQSVVoajdQYXJpc2tGZU1wUUcrMXRLbXlVc2drbVluRzFGckVzZGxC?=
 =?utf-8?B?QWNTMENRSGoyUkVPTDdGUElCRER1RUxwaVBYT3VhUVRJVm1qcXpkOCtHOEhF?=
 =?utf-8?B?R2xEbmRDQ0ppeVlKeUYyNkwwbCs5ckJGM2Z1a3FtL3ZaUjNBcGJoQ00wRUdD?=
 =?utf-8?B?Uk9DVWUzbCtiVmJJcDlBQkQrWGQweW0zellHcFJndjVqdUdWaFdYeGJLaVBm?=
 =?utf-8?B?TlNNcmp6ZTBkY21MNGdjZE1qL0FqRmFvbDlINEpiTG5qZkxocFlCNTNBMFgw?=
 =?utf-8?B?S28zbnZndHU1NnpaU2pvV0RzWWxqeWdzK25FRFQxcmJPUU95VVVNUU5nV3Ns?=
 =?utf-8?B?UFFsaEdUYVYxU0FOc1hldks0T1FQc2g2ZENOY3dZR3I5cjkwNTZrSWxuQmlh?=
 =?utf-8?B?WS9ucEg4MitJa1Zob1M1TThYZWhKSFUrNXFDdmdIRFJGMGI1ZHBXL0NLNzJn?=
 =?utf-8?B?Q0c5TUg4K1dURjlLU2FkdTdsZXZ6YlQvVXR0R0hUc3YzZ0pGN2pBTjdubkRL?=
 =?utf-8?B?cnBUbWFmbG5pQTY4STZieTlDbUo1bGdkTFV4UUkzUEpRWFVTTU5oZUJBM3pL?=
 =?utf-8?B?RGQ4TS94RkFvZlVzb25yeld3SEJhRmd4RmFRdXZKbTV3T0ZhR1ZTSFdiV2Y1?=
 =?utf-8?B?R05sekwwVE00RmxHei9pUUtsb25GSDI1b1hQY091UkxLQkR2dHhhRGluQVpE?=
 =?utf-8?B?ZklNWElSUUxxV2h0bW9LRHBDN1V0L2lDMCtIRjR2eTBLaU8yR2N3K0p0SG0y?=
 =?utf-8?B?V01HYkxqaStjUGU3ODNORXFEa1dvaHJkR21xa3laRzF5RG83eUk4R3NzRTc0?=
 =?utf-8?B?aXMxSmlKWXVqZGNTcStsMjY1bWVlSlpzNERCVHpudERUWUpBekFhbkYyankr?=
 =?utf-8?B?aVpZd1NaTUlZczN5a0RVSVM4U3JpZElHRVg2Z1Z5YVQ4ak8yZ0pYSlZIUnNi?=
 =?utf-8?B?QmV3NFZqYlFZR1VlSFl5MFozeDQzM3pQLzBvZjRlUUtKQzBUOWpmK0J1ZVNH?=
 =?utf-8?B?aXBYZTJndEM4Y1FzVFZjSmdCTDlXOG1saVZjUU1ucVp1aXgzVmM5VzVuWjdJ?=
 =?utf-8?B?TXMrK2lVc2F1Skh6b1p4WHA2VnVqb0lXYTgvY0p1dkcyNnlteXFEcDFoVmQw?=
 =?utf-8?B?eDBZMXNPc0R0cVZ3RnpjYjRYdjFwQUlOV2Q0YkRDTHYrWVorcmI5YWd5K1Yw?=
 =?utf-8?Q?hpHVHeAuK73SOalQqeecBDd+3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085bf093-d49a-454a-3ede-08dd8976d4d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:42:42.8431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8hm2dGYwwDoLZFzv7W6tXPz9uyRV/g+M2TBovZvhy78giyuxv1l9d76RamRAP+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

On 4/9/25 07:48, Arunpravin Paneer Selvam wrote:
> The ttm_bo_pin and ttm_bo_unpin warnings are resolved by moving the
> doorbell bo reserve up before pin/unpin.
> 
> WARNING: CPU: 11 PID: 1818 at drivers/gpu/drm/ttm/ttm_bo.c:592 ttm_bo_pin+0x1f6/0x270 [ttm]
> [  +0.000277] CPU: 11 UID: 1000 PID: 1818 Comm: Xwayland Tainted: G        W          6.12.0+ #15
> [  +0.000006] Tainted: [W]=WARN
> [  +0.000004] Hardware name: ASUS System Product Name/TUF GAMING B650-PLUS, BIOS 3072 12/20/2024
> [  +0.000004] RIP: 0010:ttm_bo_pin+0x1f6/0x270 [ttm]
> [  +0.000005] RSP: 0018:ffff88846ca879d0 EFLAGS: 00010246
> [  +0.000007] RAX: 0000000000000000 RBX: ffff88810b7ca848 RCX: 0000000000000000
> [  +0.000004] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  +0.000005] RBP: ffff88846ca879e8 R08: 0000000000000000 R09: 0000000000000000
> [  +0.000004] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810b7ca848
> [  +0.000004] R13: ffff88846c666250 R14: 1ffff1108d950f44 R15: ffff88846ca87aa0
> [  +0.000005] FS:  00007c45ff436d00(0000) GS:ffff888409580000(0000) knlGS:0000000000000000
> [  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000005] CR2: 00005b0c142a60e0 CR3: 000000012ce5a000 CR4: 0000000000f50ef0
> [  +0.000004] PKRU: 55555554
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000005]  ? show_regs+0x6c/0x80
> [  +0.000007]  ? __warn+0xd2/0x2d0
> [  +0.000007]  ? ttm_bo_pin+0x1f6/0x270 [ttm]
> [  +0.000031]  ? report_bug+0x282/0x2f0
> [  +0.000012]  ? handle_bug+0x6e/0xc0
> [  +0.000007]  ? exc_invalid_op+0x18/0x50
> [  +0.000007]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000017]  ? ttm_bo_pin+0x1f6/0x270 [ttm]
> [  +0.000014]  amdgpu_bo_pin+0x365/0x9d0 [amdgpu]
> [  +0.000191]  ? __pfx_amdgpu_bo_pin+0x10/0x10 [amdgpu]
> [  +0.000185]  ? drm_gem_object_lookup+0x81/0xc0
> [  +0.000008]  ? kasan_save_alloc_info+0x37/0x60
> [  +0.000007]  ? __kasan_kmalloc+0xc3/0xd0
> [  +0.000013]  amdgpu_userqueue_get_doorbell_index+0xee/0x5f0 [amdgpu]
> [  +0.000209]  amdgpu_userq_ioctl+0x6b4/0xd40 [amdgpu]
> [  +0.000193]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
> [  +0.000211]  ? lock_acquire+0x7c/0xc0
> [  +0.000006]  ? drm_dev_enter+0x51/0x190
> [  +0.000015]  drm_ioctl_kernel+0x18b/0x330
> [  +0.000007]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
> [  +0.000190]  ? __pfx_drm_ioctl_kernel+0x10/0x10
> [  +0.000005]  ? lock_acquire+0x7c/0xc0
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? __kasan_check_write+0x14/0x30
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000011]  drm_ioctl+0x589/0xd00
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
> [  +0.000194]  ? __pfx_drm_ioctl+0x10/0x10
> [  +0.000006]  ? __pm_runtime_resume+0x80/0x110
> [  +0.000021]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? trace_hardirqs_on+0x53/0x60
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? _raw_spin_unlock_irqrestore+0x51/0x80
> [  +0.000013]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
> [  +0.000185]  __x64_sys_ioctl+0x13a/0x1c0
> [  +0.000010]  x64_sys_call+0x11ad/0x25f0
> [  +0.000007]  do_syscall_64+0x91/0x180
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? irqentry_exit+0x77/0xb0
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? exc_page_fault+0x93/0x150
> [  +0.000009]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000005] RIP: 0033:0x7c45ff924ded
> [  +0.000005] RSP: 002b:00007ffff7167810 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000008] RAX: ffffffffffffffda RBX: 00000000c0486456 RCX: 00007c45ff924ded
> [  +0.000004] RDX: 00007ffff7167870 RSI: 00000000c0486456 RDI: 000000000000000b
> [  +0.000004] RBP: 00007ffff7167860 R08: ffff800100000000 R09: 0000000000010000
> [  +0.000005] R10: 00007ffff7167950 R11: 0000000000000246 R12: 00005b0c2a51bc48
> [  +0.000004] R13: 000000000000000b R14: 0000000000000000 R15: 00007ffff7167950
> [  +0.000022]  </TASK>
> [  +0.000004] irq event stamp: 80693
> [  +0.000004] hardirqs last  enabled at (80699): [<ffffffff86a693a9>] __up_console_sem+0x79/0xa0
> [  +0.000005] hardirqs last disabled at (80704): [<ffffffff86a6938e>] __up_console_sem+0x5e/0xa0
> [  +0.000005] softirqs last  enabled at (80390): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000005] softirqs last disabled at (80385): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000006] ---[ end trace 0000000000000000 ]---
> ------------------------------------------------------------------------------------------------------
> 
> [  +0.000006] WARNING: CPU: 10 PID: 1818 at drivers/gpu/drm/ttm/ttm_bo.c:611 ttm_bo_unpin+0x21f/0x2c0 [ttm]
> [  +0.000280] CPU: 10 UID: 1000 PID: 1818 Comm: Xwayland Tainted: G        W          6.12.0+ #15
> [  +0.000006] Tainted: [W]=WARN
> [  +0.000004] Hardware name: ASUS System Product Name/TUF GAMING B650-PLUS, BIOS 3072 12/20/2024
> [  +0.000004] RIP: 0010:ttm_bo_unpin+0x21f/0x2c0 [ttm]
> [  +0.000005] RSP: 0018:ffff88846ca87888 EFLAGS: 00010246
> [  +0.000007] RAX: 0000000000000000 RBX: ffff88810b7ca848 RCX: 0000000000000000
> [  +0.000005] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  +0.000004] RBP: ffff88846ca878a0 R08: 0000000000000000 R09: 0000000000000000
> [  +0.000004] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888164e90050
> [  +0.000005] R13: ffff88846c666200 R14: 0000000000000001 R15: ffff888168402d28
> [  +0.000004] FS:  00007c45ff436d00(0000) GS:ffff888409500000(0000) knlGS:0000000000000000
> [  +0.000005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000004] CR2: 00007c45f7373b20 CR3: 000000012ce5a000 CR4: 0000000000f50ef0
> [  +0.000005] PKRU: 55555554
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000005]  ? show_regs+0x6c/0x80
> [  +0.000008]  ? __warn+0xd2/0x2d0
> [  +0.000007]  ? ttm_bo_unpin+0x21f/0x2c0 [ttm]
> [  +0.000012]  ? report_bug+0x282/0x2f0
> [  +0.000013]  ? handle_bug+0x6e/0xc0
> [  +0.000006]  ? exc_invalid_op+0x18/0x50
> [  +0.000008]  ? asm_exc_invalid_op+0x1b/0x20
> [  +0.000017]  ? ttm_bo_unpin+0x21f/0x2c0 [ttm]
> [  +0.000011]  ? ttm_bo_unpin+0x217/0x2c0 [ttm]
> [  +0.000011]  amdgpu_bo_unpin+0x45/0x250 [amdgpu]
> [  +0.000216]  amdgpu_userq_ioctl+0x2c3/0xd40 [amdgpu]
> [  +0.000226]  ? drm_dev_exit+0x2d/0x60
> [  +0.000010]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
> [  +0.000201]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? lock_acquire+0x7c/0xc0
> [  +0.000006]  ? drm_dev_enter+0x51/0x190
> [  +0.000015]  drm_ioctl_kernel+0x18b/0x330
> [  +0.000007]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
> [  +0.000188]  ? __pfx_drm_ioctl_kernel+0x10/0x10
> [  +0.000006]  ? lock_acquire+0x7c/0xc0
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? __kasan_check_write+0x14/0x30
> [  +0.000006]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000010]  drm_ioctl+0x589/0xd00
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? __pfx_amdgpu_userq_ioctl+0x10/0x10 [amdgpu]
> [  +0.000211]  ? __pfx_drm_ioctl+0x10/0x10
> [  +0.000006]  ? __pm_runtime_resume+0x80/0x110
> [  +0.000020]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? trace_hardirqs_on+0x53/0x60
> [  +0.000005]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? _raw_spin_unlock_irqrestore+0x51/0x80
> [  +0.000013]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
> [  +0.000186]  __x64_sys_ioctl+0x13a/0x1c0
> [  +0.000010]  x64_sys_call+0x11ad/0x25f0
> [  +0.000007]  do_syscall_64+0x91/0x180
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? do_syscall_64+0x9d/0x180
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000010]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
> [  +0.000005]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
> [  +0.000013]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? syscall_exit_to_user_mode+0x95/0x260
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? do_syscall_64+0x9d/0x180
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? do_syscall_64+0x9d/0x180
> [  +0.000011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000010]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000009]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? irqentry_exit_to_user_mode+0x8b/0x260
> [  +0.000007]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000006]  ? irqentry_exit+0x77/0xb0
> [  +0.000004]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  +0.000005]  ? exc_page_fault+0x93/0x150
> [  +0.000010]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000005] RIP: 0033:0x7c45ff924ded
> [  +0.000005] RSP: 002b:00007ffff7168790 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  +0.000008] RAX: ffffffffffffffda RBX: 00000000c0486456 RCX: 00007c45ff924ded
> [  +0.000005] RDX: 00007ffff71687f0 RSI: 00000000c0486456 RDI: 000000000000000b
> [  +0.000004] RBP: 00007ffff71687e0 R08: 00005b0c2a49b010 R09: 0000000000000007
> [  +0.000004] R10: 00005b0c2a4d7140 R11: 0000000000000246 R12: 000000000000000b
> [  +0.000004] R13: 00007c45ff19e5cc R14: 00005b0c2a51c538 R15: 00005b0c2a51bbd8
> [  +0.000022]  </TASK>
> [  +0.000005] irq event stamp: 87419
> [  +0.000004] hardirqs last  enabled at (87425): [<ffffffff86a693a9>] __up_console_sem+0x79/0xa0
> [  +0.000005] hardirqs last disabled at (87430): [<ffffffff86a6938e>] __up_console_sem+0x5e/0xa0
> [  +0.000005] softirqs last  enabled at (87058): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000006] softirqs last disabled at (87053): [<ffffffff8687377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000005] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>


The patch itself is Reviewed-by: Christian König <christian.koenig@amd.com>

But somebody should work on removing the pinning alltogether. We now have the eviction fence for that instead.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index beae931152a3..7427e080b389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -208,14 +208,14 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>  	drm_gem_object_put(gobj);
>  
> -	/* Pin the BO before generating the index, unpin in queue destroy */
> -	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
> +	r = amdgpu_bo_reserve(db_obj->obj, true);
>  	if (r) {
>  		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
>  		goto unref_bo;
>  	}
>  
> -	r = amdgpu_bo_reserve(db_obj->obj, true);
> +	/* Pin the BO before generating the index, unpin in queue destroy */
> +	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
>  	if (r) {
>  		DRM_ERROR("[Usermode queues] Failed to pin doorbell object\n");
>  		goto unpin_bo;
> @@ -264,6 +264,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>  	struct amdgpu_usermode_queue *queue;
> +	int r;
>  
>  	cancel_delayed_work(&uq_mgr->resume_work);
>  	mutex_lock(&uq_mgr->userq_mutex);
> @@ -275,7 +276,11 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>  		return -EINVAL;
>  	}
>  
> -	amdgpu_bo_unpin(queue->db_obj.obj);
> +	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
> +	if (!r) {
> +		amdgpu_bo_unpin(queue->db_obj.obj);
> +		amdgpu_bo_unreserve(queue->db_obj.obj);
> +	}
>  	amdgpu_bo_unref(&queue->db_obj.obj);
>  	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);

