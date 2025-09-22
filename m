Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45766CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 11:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F7A10E43C;
	Mon, 22 Sep 2025 11:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rjtrspxw";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E29210E43A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 11:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+L1cYSUN55GtGEQ69KxZXM9IEpA3OQDivmLQKDmFGKGAZ0nqyHhw+s5tl3OmRbEtyCYqHXmcqbReEq72ZluV/kJfED+059h+0NLpHZE8l2xiIjO6euAKSzh/qEK8FwvnON5WZqR90158xWsppAtUToPV2SOBRdAuPAfwjsDDXiCUKLBdafX+jaCNhPGRWSe8Mj2VJPMnALrUv4/zq+LvLlBe3XT1n1BAaxBHuaWT7x0xKnwViYHHExhfyBf+F/S/DwbQT07N88O95OpLX4UFWzm6nwfNtejZqd5NPg0/u+6U03LPKIOdpAYV4ZiJm+jt9OHfmR33OVxyEtcEFD3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbxdiA7pXVM1lDdIFP3roZlZfk4/07neo0bzEU7FB8I=;
 b=RI8du/s5aTT0nv+2P+O4WjrhMgVJGMKHNFR6odkz89ZVwYzuMr/rCIyH8nSXuMYbtPgyS5jAYczHPGfiU7A21aqlCU42mGL2We/wCq4QmLpRXG77NbLbRNbXhY/1RcRr+H9CSCUEGqoc/CsQUhrLMGoSzLDPVA9BjBxHj8K2ubqN5evJ27yuMgw+sL87cmHhm3MIff5mUAHsfJuGsIqxXh22pvJQ+mPqCB6dpd/Ah/DbHoyYKwjb+cUsfAeSILxG4n3PLI5iy5WtwJyBTCpVKiQpKlqBtrUyfjp0/rMeoWLsA2V04tM7v9VkWr4A9p0rKlzn8N5SIZeexaddo5UHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbxdiA7pXVM1lDdIFP3roZlZfk4/07neo0bzEU7FB8I=;
 b=rjtrspxwq+1Ei5dCi0kCpHTaOrO4/pRT0jaednDj5UdwY9qRvXOk1Ni+32YduKuomd72zIvduSIiTx1YOmbanJDU9lnxp0T1+hUDXAVCm84irdyVqFsAJh3pxceasPdQh4W6Ba9hygT15I7vqhuuVdtfqtattpnKLa3c++CgMNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 11:31:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:31:19 +0000
Message-ID: <a828e3e1-b384-4bf1-a809-cb2ee0752e55@amd.com>
Date: Mon, 22 Sep 2025 13:31:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu/dma-buf: Map/Unmap MMIO_REMAP as BAR
 register window (dma_map_resource)
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
 <20250912111148.833465-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250912111148.833465-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f4f828-7179-4d23-5339-08ddf9cb8d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFFISGRoSmtETkJPTGhtNm5MTnN2dlduMkFJaFZnNlM3czEvSGViMWtXTTd6?=
 =?utf-8?B?UXdjVDNQc092a2FnV1lyT2J5ZGF3SUpESDdlNFFvSDgrdG9WL25zYXIwdW1x?=
 =?utf-8?B?SS8zZ0JnMHZqL2p0M1F5YS9oNXdHSnl3WHVINWtVcTFHR3gwUWJtWk1TVVF1?=
 =?utf-8?B?b2lVVTI5aTk2Q2MxWGlKT3lrZ0pzcnpnekZSdjVpVjRFamR4eXgwS2c4eFRl?=
 =?utf-8?B?MXE3VjYwL2tIaFhBV2VYRVp0cjc3QzlPYTRVV1haYm1PQmRpWC9jSTI5NTl0?=
 =?utf-8?B?cDh6b3ZCUkpKeEkxYjRHbXAyNFp1bURCanJJK3NTdzlYaDhjZUpFVHMzQjN1?=
 =?utf-8?B?ckdJTkMrYnpQbG1KOWRmcWh5QUkxYTdwMEpaby9SdVprYVN0bkVLQ3l5TndI?=
 =?utf-8?B?RmU2clpCQy9najhrMit5QlBSTWtxb2JKS2lyTkZtWmNNUENZQ1M2OUc5dDFR?=
 =?utf-8?B?Zlk0dWg3OWhYZkp1V1hGUHRKcUYwcnRCdEg3MXhLcm1ucFhPclJxK0Eza2ti?=
 =?utf-8?B?RWZEdWRrWi84ZFBZRVdSNldBbEY3RVQ1bHgxYUNWdmtoc3hWK3AvZnFiazRO?=
 =?utf-8?B?OEd4c1FOS1hvNlhIMUdXK2Z1NkVHcU44OTAwNXVUVU1mcEVKOGY4dDdnaVhI?=
 =?utf-8?B?ZERGRlZYL2tCbVBhQS82WXdUaXBtUnVHTElnZy9idEM1VFhDRW0wTmZ2cDFX?=
 =?utf-8?B?enNhTWpTNjZ0U0UxZko0V0tjZ3VBRDFRSlgvejB0WDRZME5wRFFpMGgxRlV0?=
 =?utf-8?B?ckJuZkVIU0hGU0twZTNCMERZelhhL0plOEcvOXZKMFBnZFFKNkwrZzBOYURv?=
 =?utf-8?B?YWRNajloVnJOejlxRXd2c01oYkNVQ2tvU25QNmEzdTdja0pvVzcxNndoQnR2?=
 =?utf-8?B?c1FDZGl6WWtHM3FuZWs4ZDhadnF0SnZodlJQMDRha1JqV1Q1YXhBc2pRYUQy?=
 =?utf-8?B?Y0NBVHRlZitEaG0yZmhLdVphTVNCT0FtRWlIU3U3M0Z4djJnRXVDNnJWMnl6?=
 =?utf-8?B?VEx4NzF2VGtZZ2FYMVo4ZnZpL05VcVc1dFhHRnBqSTl0RjlqQnNrQVAvbmFh?=
 =?utf-8?B?RVdUbUZOZXlQZzZ5RE14cE1IMGN6cUNwYitha0luOVV0L3BneGtJMXNHNGRU?=
 =?utf-8?B?OCsycnNjUGZFc2l4S0VVMmxWelZtRzZ6b3l6Q3hnTGhNL3JtMGYvTEIvcUxV?=
 =?utf-8?B?WFhPWExrM2Q0Y0hTb3J1VmxnUFhva1ZwbXJxMkhyMTZ3OWZWNDljcW1FSnNX?=
 =?utf-8?B?cU9jNTVoWE1YdVMybmdIcWZzdDM0WmpmZFFxV1lOMlpUSDJvTERvVisvMlpo?=
 =?utf-8?B?N3pzQ2pCZGxwWlNPTHdjTlp1NzU1Tkt2Ky9uUDBNTSt1S29zR3E4WTN0NTdi?=
 =?utf-8?B?ckdBS2U4UG1iTDlubjhha3c5enBBcEdTY3cybUp6ZFdjSkNlWjE3cXM5ak42?=
 =?utf-8?B?cEpSblV1Y3g2U0VXa3Y5Z1FjcUx3cTZUUDZ2d0tFcUQvbTlFN3M0OGhXRzZL?=
 =?utf-8?B?aVBFZS9QOGJvTExWaG9icWFKUWxXWWdkS2NVM3VwSFQxRE9GZERPWUhoeHZ6?=
 =?utf-8?B?Mk5OL21tb0RvTmpBTHFOaTFDOEN0M3NaVmZ0WE5jYk9DNXpEQ21RODY1NlFx?=
 =?utf-8?B?azgwSmNzUVZXZzlpSTlIQkRvNFZqRFJ6Vkl6am50dCtwV0FXOTc4eWlFaEQy?=
 =?utf-8?B?ZkgrNXdnTjFyQWJMWGxPMXpiYVBVb3JYaXZVM0xhNW1jOG1vWTlzZHVwZnVM?=
 =?utf-8?B?S2pQYm1CcmFRQlRrdllabWg3bnkrTGtrc2hlTXJONkUzQnVybWllR2h4L3Z5?=
 =?utf-8?B?L3lHbHgwcXFpR21wVUVMd2pSRzFRWnNEMVV0eENUMk8zQW92UnNPcnlYaEx6?=
 =?utf-8?B?M1VwQ3pxY0lSOGhIVG1jcEQwRUdwRVRYbUQ1enplMW1uRTZIa2pGNVJIREFD?=
 =?utf-8?Q?z+1Rh7M6WNc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdjWFJkTzQwZjFsdDhNT0Vaa0IvUzliaWg4RWJ0YjI3QzZmbERWcFJqbEFI?=
 =?utf-8?B?QUVxK0RnOThpdFUyZ2pXQVgyNkFEbXJFWThzejl1bDdzUHdhbzVrbU9SZTY1?=
 =?utf-8?B?NHNFK21IS0w3KzVsNENWVGhUTmp3OHQvdWFhUzVIVVJ5VEtxV0E2czdETGo1?=
 =?utf-8?B?dm5ad1psbDk3SU0zUWYrU1Z6VHZyc0NIMGxvV2ZuUHVCZUdCZmlOb2IzdVdh?=
 =?utf-8?B?TVdMMklNSlFpN1J2OFBscXhIRHhMbEh3c0luNjZ3LzFqSkJmZE1rYVR2bmp5?=
 =?utf-8?B?WjBuR1cyWm5DYklqSndCMVR0QnRZSVE0M1lESjQxOXZSdlcxbjF5Umc5WEV5?=
 =?utf-8?B?MVhlVSttZXJUWUhBbkt2cmgyTGVuYldPK3hnWjlUVWV2K215d3hZTS9sV202?=
 =?utf-8?B?UTFXRnhQOGNuQTV3a2h1VXJVZFQ0SWdycWp3aGQvRWp4aXJRbk5Sa3lETVJ0?=
 =?utf-8?B?Rm02eUxDU1ZLY2FKN3hBR2U4R2RzUVJiNlpjS0wyaHBjVWwvZWdEUnVaZHRJ?=
 =?utf-8?B?YXJwd3BrZ2pQOG5FWjNNUlpnamhESzFuWlNhT1pmMy91RGI5TGEydzVMNVBk?=
 =?utf-8?B?bGNSWTc2L1prZ3dTdWMxVEh4VHNqYWt3cFJ4LzZGNkF3MngvQnFLajlFaE1m?=
 =?utf-8?B?QzBsSmIrOXJOdHhuK0dUR0VhYmtWUitUUzdvSDM4dEZ6Uld0cWo0WDVYYWNp?=
 =?utf-8?B?c1lsUnB2WVlTQUU4clV1TDVOcHBQeXhBd1dzU00xNnJOU3I1Znl3dkRWR0Jw?=
 =?utf-8?B?MDdGRytpUXB5ajlEVktGUmg2NmpiYUNONG5wVWcwdkY3ZldTcmZOMTBsL0lX?=
 =?utf-8?B?djdoQWxtRG4rRUE3R05wN2RRRWJYVk5pT0xIcTlhbEZYNUpxT29yUHYrMmpt?=
 =?utf-8?B?YUk5aDMxbk5qd0hXK3BSRFZoYkJrZXdlQWlxbGlwSjk3UzdvRDJzYUczVS9P?=
 =?utf-8?B?Y21rWDdrYk5SYTNCamcvNXAwOU5kdExtelE1NzhzcHBDdStFdjU5dmcvci9t?=
 =?utf-8?B?bHFFb3NLNXVkWDcxeUw1N0dEOW1zMGpjSlBRUVNReFFPVkI1RFU0bEZwUWNZ?=
 =?utf-8?B?UGN4ZDhQZUp4aHJRNUxHaC96aGxJc2hQdk9VUEYxbGFpTkFSdFN2U3p3c2pv?=
 =?utf-8?B?S2RrNFNjV0tLU2FUUnZUY29CeFNCNExJb3R4YU04V2pIWnJVbmVNaGVFbzFs?=
 =?utf-8?B?QUlPdnQ2YXJwTWxHQURqVHdjT3RmTU9hbk96Z0RDN2dPTHZmc3hKQkFCaEFy?=
 =?utf-8?B?QUFNTFJmVllPUEd1ZlhlVjNXWnFiN2NxNlNkNUVGOHM3MW1uMmJNN3lKTVh6?=
 =?utf-8?B?N1NUZktMVTJIYkRFWEJRU0xtaW9aR1pranc3R1dpc1ZsZ0M1cE41dHBtbHQr?=
 =?utf-8?B?a21jOUlKN01FU2JDMG9EM29OeHRCT0pBZ3NSMElERWdpbGFkWmR1OVFJNitO?=
 =?utf-8?B?UXBaMUJxMzdEOW1qOEFkbnhJK1dzWUF4NzlFemhWMGgvamRqTlNUbGM1dzN3?=
 =?utf-8?B?MzNJMnl0RDRBUitTL2ErNW1IenE4UGI4eDllQlNNZEJRUkRzeGk5bXpOVlBQ?=
 =?utf-8?B?aW4vNkd1QnBYL0xLVDdqN2x5aUowbEhOVTQzbDduNG9Eam4zY3V5NUNHa0tu?=
 =?utf-8?B?S08wVU1oeXdiZm1icFZucEJycGRKWWN4ZzMyQmtTakd4RTJUTEh0SmFsU3lH?=
 =?utf-8?B?Ri81VTNOR0o1ZWVMbnNmUnczR2VaWGk1Sjg2OE5tWTFoQU1EdGVhZWUydDli?=
 =?utf-8?B?TVhlU2pkMktZNEdNOTNoREZhVmR2ZG9RZWJJRjErZlI3Rk9HUUd6V0xzYzdN?=
 =?utf-8?B?SVRUejVwbjlPd05vajNSWUhEMlpacGVSR0hRRGJHMEZWUGhwbzZLd2E1bVFL?=
 =?utf-8?B?UnJ2K0ZERGVZOVg2MmdwYkRNMFNoZjN2aWpXS3NQTUZPc1VwVjQ3S1ZFUHQ1?=
 =?utf-8?B?clZ6OEQvQVVuU1ROMUVORXpKcGg0YWtkMVlUODVNU0hpaVUxWGlzMW1BeVpU?=
 =?utf-8?B?Z2FxdlBLeEZrTEhSTFN4THhMem5CZkxnR1hNMHJsbEpxdHVwQnpGMHBUWTJ2?=
 =?utf-8?B?MTBPZE13Z056TUVaQlk0Tzc1K0Y4VHZ5dVE5SFZBNWlpWW9KckdGWCs2cmlI?=
 =?utf-8?Q?k/DOV9rruuYw1UI5bS9My+XSl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f4f828-7179-4d23-5339-08ddf9cb8d0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:31:19.8626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qahDrNWW/QBugdeuNhSFvTvJh0RjmJW7BUTFvQOpQljMGfYKHFgGDcTBE4LzqsMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

On 12.09.25 13:11, Srinivasan Shanmugam wrote:
> MMIO_REMAP (HDP flush page) exposes a hardware MMIO register window via a PCI BAR.
> 
> Handle it as fixed I/O:
> - map(): if MMIO_REMAP, require P2P, compute the BAR address (bus_addr + page
>   offset), and build a 1-entry sg_table with dma_map_resource().
> - unmap(): if MMIO_REMAP, call dma_unmap_resource() and return.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 +++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 33fa17a927ce..f85e16be438f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -151,7 +151,7 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>  }
>  
>  /* Map a BAR-backed I/O span as a 1-entry sg_table via dma_map_resource(). */
> -static __maybe_unused struct sg_table *
> +static struct sg_table *
>  amdgpu_dmabuf_map_iomem(struct device *dev, resource_size_t phys,
>  			size_t size, enum dma_data_direction dir)
>  {
> @@ -183,7 +183,7 @@ amdgpu_dmabuf_map_iomem(struct device *dev, resource_size_t phys,
>  	return sgt;
>  }
>  
> -static __maybe_unused void
> +static void
>  amdgpu_dmabuf_unmap_iomem(struct device *dev, struct sg_table *sgt,
>  			  enum dma_data_direction dir)
>  {
> @@ -218,6 +218,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct sg_table *sgt;
> +	resource_size_t phys;
> +	u64 off;
> +	size_t len;
>  	long r;
>  
>  	if (!bo->tbo.pin_count) {
> @@ -261,6 +264,29 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  		if (r)
>  			return ERR_PTR(r);
>  		break;
> +
> +	case AMDGPU_PL_MMIO_REMAP:
> +		/* Only allow when importer can reach exporter via P2P. */
> +		if (!attach->peer2peer ||
> +		    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> +			return ERR_PTR(-EOPNOTSUPP);
> +

> +		if (!adev->rmmio_remap.bus_addr)
> +			return ERR_PTR(-ENODEV);
> +
> +		if (bo->tbo.base.size != AMDGPU_GPU_PAGE_SIZE)
> +			return ERR_PTR(-EINVAL);

I think you can drop those checks.

> +
> +		/* TTM start is in pages → convert to byte offset. */
> +		off  = (u64)bo->tbo.resource->start << PAGE_SHIFT;

Please don't use resource->start for that. Instead use the functions in amdgpu_res_cursor.h.

> +		len  = AMDGPU_GPU_PAGE_SIZE;
> +		phys = adev->rmmio_remap.bus_addr + off;
> +
> +		sgt = amdgpu_dmabuf_map_iomem(attach->dev, phys, len, dir);

Move the amdgpu_dmabuf_map_iomem() function as well as the off and length calculation into amdgpu_ttm.c.

That is still not an ideal placement, but better than here.

Apart from that looks good to me.

Regards,
Christian.

> +		if (IS_ERR(sgt))
> +			return sgt;
> +		break;
> +
>  	default:
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -286,6 +312,15 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>  				 struct sg_table *sgt,
>  				 enum dma_data_direction dir)
>  {
> +	struct drm_gem_object *obj = attach->dmabuf->priv;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
> +		amdgpu_dmabuf_unmap_iomem(attach->dev, sgt, dir);
> +		return;
> +	}
> +
>  	if (sg_page(sgt->sgl)) {
>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>  		sg_free_table(sgt);

