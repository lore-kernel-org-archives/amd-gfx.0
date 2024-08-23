Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7264C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 13:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F6A10E67D;
	Fri, 23 Aug 2024 13:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KuP+psIU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B387010E67E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 13:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq+1sh3OPnfjJ8He14WQBY/VMY6/d+oJN1B3UWm7t1QQ9/7kYZOPfkXq2efmYEcmqNGNcltNhX/gE3nvz/m8kHzq6DAG63EJpCrk4VGa6pN0ylTBZgrySrhDcuBqeSWrnM4xo+2L8KmppA6grFvFJ6YGKGQZ4jm08Ai2tfP8AfoB9jJ/JKDMJf4wdTqd3GcctdEd/ufkDxu1wttSE8hE4S/sewsFkwFHlUY7zMjXC7+dZj7Uw8ThYPEi0NaPv5K/y1MaYyhTr7yoXTDKxfBKlxr7CVBQW5ouAfHALpuT7Jw121n2gzgv/y1JPqKkptSPfNLvdcvCV7BfT0MQxJt5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5ciMGp6pJd/T7iNR6MoEMDlNd/L1IgHJVvudR+DwRc=;
 b=uuLofBeGi1OXSrG+GqgS8sdeISyBa0hvYRfVyCx6lvlelhROfsDVNjmdrlEp5wc3lEwIhheepHUA46QsSJGDpJaMtr3Yqj34wuE+TCz4aqqV/lY1uWwPkiHeA+GCTKwyMHNPrUIspv55oeFcSjhlTTqVjP9E8TIV03dJnoVKjT76IPh3Xsu06LfOmCiFgamyeSzrt93KmBKt2pAFrgOsv0f8g2bof9thmpGJA6B9li6tvrmTkRJdNNs5uBWt11JZs0QFstpVubXuIp10JRhbiwIkFA7U/ZoZeAtyUF25xH3MsHRBot/ShYj+lHlT0h6M7Vj3FRTLr+CcXTMHTtrNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5ciMGp6pJd/T7iNR6MoEMDlNd/L1IgHJVvudR+DwRc=;
 b=KuP+psIUoSpWmsWlgc1rSOka1n8kSI9j8Zf0EWsPivxt+PSMaYR+0xZ1F84joyENnbTSTna9kcO+wlSco/hZgljSC+4apzvBwiUFGQ/xSkPqHnTLczue5U9gDpooJRPajNXCJN5FcQL2hiJGDPp1V3+zG0zgbsVdCDkl9D7lVeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 13:09:03 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%6]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 13:09:02 +0000
Message-ID: <e7089408-41c8-41d6-9f00-8ad4f74be6d0@amd.com>
Date: Fri, 23 Aug 2024 09:08:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/display: SPDX copyright for spl_os_types.h
To: Zaeem Mohamed <zaeem.mohamed@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com, jerry.zuo@amd.com
References: <20240823001453.1845297-1-zaeem.mohamed@amd.com>
 <20240823001453.1845297-2-zaeem.mohamed@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240823001453.1845297-2-zaeem.mohamed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::17) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: fefdea75-8471-4e27-4923-08dcc374c277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUF3dWNSS0Rpb2F2b0NvRGNRc0ltbGlmSkkwdVM2UUhYemg0T1RhU0t2aUp3?=
 =?utf-8?B?ZSt2c2dMUndOL21hd2lYLzhLU2pSMEh6NVpFcnEzQnZaSHlSMXhRZEFSdWRo?=
 =?utf-8?B?eWhmSHhZd200R3lPVndaQ25wVGhMcVJzdm5iSW5ib2ZiMC9aeUI2TVMxMk9M?=
 =?utf-8?B?b2FGdmNHcWhjelJSN0N2VkxBRWMrUjNKaW10TTM1WWlHNmV6SHlsSEYrcEFi?=
 =?utf-8?B?OWw3NVdodnEzZklUeDIvV005WEhqOG16VDdZYTN1N1p5NUNHL1lyWEFxYk41?=
 =?utf-8?B?eVFOak4va2VFd3VBWWQxUVdnWGFCUEJwR2dkZStQZ215RGV6RXkvZFNVQ3ZR?=
 =?utf-8?B?b2E0YUl5Y0hrdzVvaTdkSmQ0TW9lN1hZQ1ZMSkhXbG1ZOGNNNHl1eVhjQXRi?=
 =?utf-8?B?MHZVaHRVSVE2OUlhcjhwWHVqaGhCMzJ1Y00xcjhXSk5xQ1pDaElvM0xxdGRG?=
 =?utf-8?B?eFN3V1BKOFYyMUtEb1FOTEo1OTFEeUlOR3hYUVNibllpRGlvdVd3OGZ3VEFG?=
 =?utf-8?B?d1FtbDhNNnEwbktHSlhEcUdXNWhZRUovZ3IwUmtET0lod01uMS90QVhQNUJi?=
 =?utf-8?B?WXI0cGYvV1ZPYk1NV1RZWUo1ZnNJYW1EUUVSVS9Nd0Z6QlBnZE5CMXBVek91?=
 =?utf-8?B?bGRNTzh6V25Mb2NoeUZtLy9YT1lweHdCN0hleC9ibnZTMmpnR3hmNE54TGlo?=
 =?utf-8?B?cE94UGZlWnNvWkpKNndiL0NxZGJSeGU1T2RJU0R0MmtETy9DaUMyU0JIU202?=
 =?utf-8?B?YnM2Y3dXb3BxK0hnV0x2U1dVOG1UcXAvVFRpSnpmRVBHdkJOY25WRk9xcktz?=
 =?utf-8?B?dnNNbXkyTnkxK2QyZDJ2UDhJZUtVUHN5TjA5bElaa0loLzZMM3R2alZYSUZv?=
 =?utf-8?B?TUJIZUZmY3Jxalltb0FVN3FpNXVzTCt2UEtwVHRsWUM1VUZQVk1kRG1rSERw?=
 =?utf-8?B?MDlEbmtobkVQMzI2aEgvdmhFT2Y0bzAxQVJYZUkyZDBCQ2FnMWdhbVVVNXNY?=
 =?utf-8?B?SGVqR0YrZWVRQkdkVWtjZDNtMVdHeWt3aWJtejJuTnR1WGhYemxzalM1Wmt2?=
 =?utf-8?B?dC9neHpGTlp1NlZkTjV1N1d0dGxlTnpoRzlXSFJJUWl0bnNLVVE0SHJrU2ZL?=
 =?utf-8?B?b2ZrNEFyVVhYZHlzbXVvSTJYQURhNGxkdE8yclhhSk5hWGtZR3FielhNUjRV?=
 =?utf-8?B?Qjh1VGVvaEkwaDJNZjB3TTFZVkhsWDFYb3dOWWozTUthUmFUNDJDRVc5WE5k?=
 =?utf-8?B?OEs0SThmZGNzKzA5dm55TVNmSGNXQSs5Q0VGd05XSUR0bXNiUXhrQVVxdWUw?=
 =?utf-8?B?OWJlTk9qblJlbHJwRW5ubWxJeHZGMERZdlNGdElGdnY4YUlaKzQvYzdtSHNz?=
 =?utf-8?B?aHVsdmdQMkwvcGJIMGxpM2J4aGVsQzVRcm1CWmZScUdVc2xHRmVVWk92YTJV?=
 =?utf-8?B?bFhxT3BPc3A2QzZrMHNPOHVnSldySTR3WDROVFQ0SjJTNlpLNXJFMjdBNFQw?=
 =?utf-8?B?Y1pNbEYxanpqY25ONjZLUFlCaUlwL0RIRTZVbHpwemh6N21RS1dveVNXY09n?=
 =?utf-8?B?QzJHLzBWajlmZU5lWXJpZ3FzVUl4dGZIejZsVzFsV1ZPVEtpeHRRamtBN09W?=
 =?utf-8?B?TStjTU1GS0FlM2ZSMzRYN3VGNkdCVkEzaldzUmYxS3dOL25WOG5pTzJGS0Js?=
 =?utf-8?B?TWRJK2E3OHhia2pZYU43NldzcHpXR0hVaktkczRSRm5PR3dGdVZuQzJFWTZK?=
 =?utf-8?B?TWRQaE1LRUpLRmt4Zzg3WEY4YlZsWUtzaFNMdzhLZWt2LzdUWjRNVXlvaU1V?=
 =?utf-8?B?VmQ4WTcxdVdZRk5oVVBLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3YwZzVFMjd4MzkrY3VQU0V5bHBEeGUwdWtuOVN0VlZ6WERVa0kreWozL0FF?=
 =?utf-8?B?TUNGYTQrak1SQnh4bENwTjJUWDdWK2NlRVRXM3JsNS8rZCtQWVJuQTNhdUpr?=
 =?utf-8?B?d21jclBDR3BMc0x5dnNNKzBJQnR0aERzRGZ1ak9abENTbTZPRzA3cHRlb2FC?=
 =?utf-8?B?bXFSV2srWFM3N2Mrd1dzK1Q4SFUrVGdCUFRtNkNKNlYyVVlOZzNIYUtlRW1t?=
 =?utf-8?B?NEM5alJPVFVqaGoxK0JMQ2krN2tpeU5haXNPNTc5di9iN1R4QXJvZzBUUzdL?=
 =?utf-8?B?V2ltVlMveU5OYmdidU1UNVlSL3pMa3hHRTRiby9RMlJZNWM3dTFSV1hNUUdu?=
 =?utf-8?B?K0ZUWU10ZkpHUGEvV0FhOUZlVy9oSEdSVW1JYWh4THJCcnd4V01qdkRZcGlV?=
 =?utf-8?B?MC9IL2trbmd2SExtODYwQzVhQ0JmeGVNWDNuOWtVbUVMRUVzY3V5WUlhaVZ5?=
 =?utf-8?B?UkgyVm1zNzg4STNiVHdnUnpjSTJuWHJmbWZBYkJjbXQ2VUhJeUlYbjdWa3dX?=
 =?utf-8?B?T2pQOHJCUWFGQ1hqaE9oZW9CWnNVOExxUmxOSjBnNnBpSkxROEVSNlpYRjJj?=
 =?utf-8?B?K3BDa3hCWkpBQlZVbktHb3BMOHh2d2xWL2ZWU2x0WWRDenZBWHRwYmN6ZWtQ?=
 =?utf-8?B?bXhhaDdOc01ZUTRhMmY1OHJYZjJHckZCeW5zd21Cc3crQ29NZ1RRalhvaWtr?=
 =?utf-8?B?Z1FvRGxnU2piWWM2Z3lYbVovR1VDeENmZ1BoYmlacElSSnFidVdlYUdBZmM0?=
 =?utf-8?B?TnRTUGF2bFF0Mmx1KzVoUURGWVV6VmFiT2R1TGRMR3FkVXI0bmZkR3NLUVUv?=
 =?utf-8?B?aDRndHh6QmdZVW1sRHJmRFI0Y0pTTGZFZ0N1WWxjMHZDUmRxOVNxQ2tiTTc1?=
 =?utf-8?B?RjNiTWE3b3owWnZRMStEQkdsOWlRMjE4WjFKYzdMdlNVcmxFeFdIQWk1SzI2?=
 =?utf-8?B?RXZISWNPQ3dtV2hQVkp5a0pnd1ZoMHEvdng0V0RSaGxqcVBERXhUUUt0L21G?=
 =?utf-8?B?Qm93ZlU4cXdzYVBCRlpFTWp4WFlJaWhTdVQ1TUhpMjdya0Q0eGRkTW5wM01q?=
 =?utf-8?B?Y3QrdlJKcnVrU1RMLzBCS3VQbnR0T3FuR2ErUWxnV2dNZjBlMzFEaDFrUW9Y?=
 =?utf-8?B?aDI1YStrWHo3dEp4VFBjb0U4VDlVVC9MK04xbEo0djZaTnVGV2orR2FkS0Jn?=
 =?utf-8?B?cVFISUhwTU1PNTJXdHoxa215ZTVpbERvd24xY2Z1ekw2OVBsZXRGc2M5a2x5?=
 =?utf-8?B?aGluMXZ5ajFFdHhPOUx1Mi9iQVNyRFBtcENueWd0TUFRVXFCZUplZllHOEg0?=
 =?utf-8?B?TFROR2d6M3pJd2d3aVN1cElOS3pweDlmM2FDOWtvSUhWdU5ob1dkeHZXZEEy?=
 =?utf-8?B?MHNqOEg0emtVQWZLV1h6VTZzSHI0T1pxWSt3NVlBR05lRDhMeUNMSjErazl6?=
 =?utf-8?B?ZGtZQlFyTW1zcnZvYk1USUtTeDNYbW0zRGlqbVZ1c1NjQ1c3dTBwUnpwWE5B?=
 =?utf-8?B?MnJrNUIvUlR6ODNQVTNKWGg4U0hCU2lleDdDU2RCSklraEJFL3NGeldKdFdB?=
 =?utf-8?B?MUtGQUdMUkQ4Y29qR2p1U09rNmRIMGI1VGtUK20yTTRaWlFnMWYvSU1sS1Rn?=
 =?utf-8?B?SnFSYVEzYkpOVXQwQjVFcFZjSzNGSy9WT1dxV085UmF5dHZTSlRxU1ErUXpG?=
 =?utf-8?B?UjlFcmVERGdRamZKZ0pvREplczNCcXVXTDFxWUltMkVNSk9pdHZ4ckI5dEFO?=
 =?utf-8?B?Ly8xWk1uTU1peHdhbytBOGVhOEtlSWNnSEV2NWRBajNSdVJkYVlpdHRMUzlN?=
 =?utf-8?B?bjNoT3N5TjEwYXZrbWNKMk1QRDdRZEhPUVhtbVFNYXMxYndFQzlDNlg1dHNJ?=
 =?utf-8?B?Mi9XTHRsTHBqWWdLa0UweitrWXo0emIxdUVIQzNLQ1NvVEMybHpXRTVDc1Yz?=
 =?utf-8?B?VW0vSXFvMUdieUVuZzMxRVMxT3lSdmNoRzFPVGkvdWlydEdRZTNDU0JQaGZj?=
 =?utf-8?B?ZDlMMkhRUlpUZUtSb3k0TFhlbnVSa1dXalRNWnpwOWJid2MyY2RYMVc3eU1j?=
 =?utf-8?B?VXdJV1ZEMzAycUlQMzU5RHJaNlV6emNNVDJWYWFDcjhDd1pSMWlUQnh5OGdF?=
 =?utf-8?Q?jXvEzkJZd+B6YMfvgxQCIShOK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefdea75-8471-4e27-4923-08dcc374c277
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:09:02.7320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi2hvl+6ItkyDyJFu8CI/5X/gbckjC574DAgwiUyaThCaY+mzwo8OBh9B+LX2il3suZFAeL9B3FkWzNCQXlYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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

On 8/22/24 20:14, Zaeem Mohamed wrote:
> Use appropriate SPDX copyright for spl_os_types.h
> 
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   .../gpu/drm/amd/display/dc/spl/spl_os_types.h | 29 +++----------------
>   1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
> index 7ebea91c84f6..058306bb41aa 100644
> --- a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
> @@ -1,28 +1,7 @@
> -/*
> - * Copyright 2012-16 Advanced Micro Devices, Inc.
> - * Copyright 2019 Raptor Engineering, LLC
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> +/* SPDX-License-Identifier: MIT */
> +
> +/* Copyright 2024 Advanced Micro Devices, Inc. */
> +/* Copyright 2019 Raptor Engineering, LLC */
>   
>   #ifndef _SPL_OS_TYPES_H_
>   #define _SPL_OS_TYPES_H_
-- 
Hamza

