Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83395E7E0BC
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 17:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4E310E0E3;
	Mon,  9 Feb 2026 17:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrGsksVA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FD510E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 17:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNfOjb3RzQG926kIsG81UL9aRqYBIQAWILztYRVrw5J6piLF9CANcZZ4xWD+kBAe4uEb1uYtULNTUGqkOL1TsdXWE1+deUp+da7w4Z9/3AvlPM9RL94ZSSudaBjvxQxp8GFtX5oiwzPI28797kXhsDDHH2Kq0Ro4t30yK2nDGUhh1gn5VnmcrCHRn5xo1gEZeRIZrB8nsmvCGICe5FCuSizae2dcpEh2iNVPOf1tXqErv4n5jdfMhA1IwQsuu/ffVixpmP8/lsrS8jy0qyRaRVGRQ6eIdteR6PViZWUx8WiEIdehDLonYMoOl+shKIdfXBZ1EuRsuXG5N6NMo4TXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMpDh9H6nBUhk6mnOIAoskaibBLR5kdiOCkugestUjw=;
 b=ViLdiuoYlPrhEvhLyxz0ZgjxGSh2uf/P74/1f1nwZIWIq/pXUjAxTNzudekP4JKQxVSH8RnRxRMTGtcyL2hdD/IGGGepD3UWmCAhWQ7rypr78p/s7JyCdnXf7COdebcKk/0Z4Bks70lovdauYWFydFby+ywCJ6xb+6vSFPcnqMrSjRAkPPFRvIEs4PBSLnBvP4pjrMNYtQUkWb2LIzJHLSJXz6RlRUlcedPqLHCVEsQ0elFXnq/YyJVc5xnFFOQJY3n3ebSSzowzPsN+bdV0CbVX0BiRa2kS2QIkCMm7I0UaKJPLav+LcW5IWM8Lk2OVU670e5yxecwMkM+cy0ENgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMpDh9H6nBUhk6mnOIAoskaibBLR5kdiOCkugestUjw=;
 b=nrGsksVAqiPgVkpjQiiIBao1hIPBpt1BUNw37Vcd6x6Aw1swhoGvCOdDdzdugmN0XVcmPYfGVh1qB9iD1nDxcr8jtmc+0wrvHDUzu4blfCbYQ6j+3sRPFqbWg+J0zAgXxZJ3uVWuP2xGYPX/+De/nOnGOYLFQ/aSKxe4s7ZmJ4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 17:25:10 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:25:10 +0000
Message-ID: <af3927c6-5e27-4477-973b-3fb2565860d1@amd.com>
Date: Mon, 9 Feb 2026 10:25:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd/display: Clean up some DCE 6 code
To: Rodrigo Siqueira <siqueira@igalia.com>,
 "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amda.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <aYoA2Z4svnQ-Md_x@atmagalia>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <aYoA2Z4svnQ-Md_x@atmagalia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: ad19174f-5132-4465-2cf1-08de68002d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzVNUDZ2cDZ1WFVLQXp0eGVCUjY4VlhXY245RTltOFFzNVJaUDlZekUvN0p2?=
 =?utf-8?B?RDJNNmZURGxqNW5iZFBQSFZMN2FKTjVTZzBReHhKYkJMMWVtUmxmaHFIMjFS?=
 =?utf-8?B?UzJnRVdxV3YyK2p4VE5Ha1ZlNXFiL3VsbTZXTWtCdTVMNEhRZ0ZrTHhMT1Qv?=
 =?utf-8?B?R2FnSWlIdDd4U1pLbUJVREtldVhFR05LU09Nb1FYdG0zZjl3VkV4dEd6SVpl?=
 =?utf-8?B?ZFhLczRzUTFwL0NxRDEyNmNoRVpMNFhpaTl3RjB6VmpBWFVJSXlsY3NHVHE3?=
 =?utf-8?B?R1lPcDEyU20vN0RSOHVZTDZoWisxbEJIbUU2a1dLOFZGZTcxSkdsQlMwVnBN?=
 =?utf-8?B?RlgvNWFLOGhsYTJnRG94OCtRdjEraEU5SUlaOENiTVJQNnowOCtPVWpSQzI3?=
 =?utf-8?B?NGIwUFZDdSszcFdLQ2VTR0JqQ2lEcWp6V01HK1ZadERuU0J5NkVxdWtoQ2dD?=
 =?utf-8?B?VkNVR1M5QmhsV2hTb2xhOXBSRXBIcFdkZUtBNW4wbldXUVpVaWdGdjBNUS9w?=
 =?utf-8?B?MWkySWMwR1BPL2lCSFpFeW0vd2dSTFJvaFlDZFJKeG91NHEzOVF0Z3VIWHZa?=
 =?utf-8?B?b09Ebkd1K3BIY0N3aEdLMHVudEEwOE0zeHFSZFJOUUhXcU5tU3pPbEQ4V3F0?=
 =?utf-8?B?RHNVUXN2ODBZMnYwcjY2RFJEOFptWmlCV3RITEpnVHdnN3l3OWxtLzF5d0tO?=
 =?utf-8?B?eE9OLzgya1F0ZHRVSEJUNzJ6b3NNc3RxaG5Kdlh0ZnNBZnJhSG5zbU52eWlZ?=
 =?utf-8?B?cE94MDhId0pxTTliN09ZclZEMC9VOVBZMXZNOFVaSEkwckRFKzdtaGFzWit5?=
 =?utf-8?B?dW1sRWt2Vm1pZitjOVVtNUkxdEl5MkxHYWlUOE81ZG9SUFliM0pXMU9BanBP?=
 =?utf-8?B?RjZDeXNoM1lEbnptaTFtMkk5bVNhaEdMR1dJQUtmVUtVd3lldjJwTUVVYWcx?=
 =?utf-8?B?VEx2ZnI1b0NxTFlYTk5DNUtKbWZWYjFrd2NOVHhSK2lhWjdGTVJxck9naHJP?=
 =?utf-8?B?czBsY0gzR3d4bUlQS1ZOR3ZtTXNGS1UxQXRBc01mK0pZcm9sTVJtdGo3cVNJ?=
 =?utf-8?B?YTdYczcvRUl5UklwK2FYd1p2Z0NMSHJJSzJHVEU5Szg3djMrQnZ3WFlHdkVV?=
 =?utf-8?B?b24rMWhVdm5xWkp6ckV3NkNheFd2ZTgrUzZKVThaOW5KWkpHZFlUV2lJa3Mz?=
 =?utf-8?B?Tm1ZYWZYRWZSUGZEb04zR1VoU1RmNFFKRyt3TGQ3REJyR1JPVFZRaXFvSW8v?=
 =?utf-8?B?SkxWMmIyYURmUHhPL0NiVjZxdkhmWHNWaWNlQkV1QkdHSm5ueUIrblVYSTFs?=
 =?utf-8?B?TWM3NjA3SzJjWG5YOE5HVFF6TTZPL2ZnUHcwVnpTZlBJMnRNVEN2Wm1QbDJm?=
 =?utf-8?B?WW5UZXp6QndRSzM3MncvMVBxakZzRU1tbjJzTkFld01saW1nc1M2cUpEUGRu?=
 =?utf-8?B?aytxT2RrTzJXQmVLK1Z5Y05MSDMxN2JycDB2VnhWSk1CSEQ0QkJFOHFGOGpv?=
 =?utf-8?B?Mms4cUhoQVljSW4vayt2VDNoSnlGVHlXMHBMV0srNzR6UDZLV2QxWlFBZGR2?=
 =?utf-8?B?U3pXMnBEc1ovMHRwNGxHUHdnQTRJVGpwRTdKZVBUSjNaelk0eW5hY0ljeUhQ?=
 =?utf-8?B?MjRRTXZKVkViQ1luN05jb1BudXZOWXN3aVM4VHRyQWlNd3NVcGtJcFJCVlBv?=
 =?utf-8?B?SWdFd2hNS1R6RTBPSzNwbkFVYW1rY1E0b3FkRXBiUGpIUW5EZ1Bpdjh3OXM5?=
 =?utf-8?B?YXRoZ1pwZEJ2ZlBPbHg5RWw0alNYTFBpTWVDa0Ixd1ZPS2htcjRvY1V1ZWZj?=
 =?utf-8?B?SDJxdWlHZGlqdVVuMFJnb2lqZEptc2pOWkloZXIrLzRZaXpNTlBmWXZibTZt?=
 =?utf-8?B?L1FqRllpdWI1aDRpakpQOThCQnk5VFcyWWpXekxVZzMrUHFiZkNCbWUvNGg3?=
 =?utf-8?B?YkEvRjFQcjVDQkpIMW9oUnVQTTFvM2d2cjJ1SGtraktOSjJSVjVNOGEzT3Zi?=
 =?utf-8?B?QUlCUlhyK3J6VHV6aWhqaTNlY1FyTC9aL0RFSGhUVEZ3ZmJTQzYwSXRnT1NE?=
 =?utf-8?B?aU1ybjFvUzFYZW80dmVIN3BHUVJ5SFhYa3BHZ09yNXU1cndDU3JwaFRTNDdp?=
 =?utf-8?Q?tj6M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmM2ZEMycjJGWitqTXF6UUxjQm5pbkJTa3FWOTk4dWtwU0FubG9ZdkMwVDAy?=
 =?utf-8?B?eGw3Y2RzRTdBNjVBdmJpTFduaFdEVXFvSEtiVjZBdUV1eTgwYjB1ekkzcnRC?=
 =?utf-8?B?a3FhQklsVUVEdUdEWHVKK1pzOTF0NWlWL29Ib3R3ZXYwQmNjQzFkc2xtZ3Ev?=
 =?utf-8?B?TE1rRi83WDJaY0xSVTh3Nlp2Q2M3V05ZYWdtT09mcWJUREIvdE15THlzOS9y?=
 =?utf-8?B?cXpCU1l5R05zUFpIQlpzVC95OEFRRFNRZHk1cGkvbHdaWEoybHZwRlZoaEta?=
 =?utf-8?B?bjhUWklzZDhqUExHSXNFZTg2RDF3b2JTcE9vZ3doWmFMY1BCVVBEcUlUU1lI?=
 =?utf-8?B?Z2ZPSUNObWY0VnQ1cFV2TG9NRjBVTW1VdjBvRFo5bnBybzUxMGI4UUpiWkx1?=
 =?utf-8?B?Y3p2dTNsNUN0OTUzZVdRS0J3NkhBcElPaEZSZFJYZVBCUURHUktyVVFScjNB?=
 =?utf-8?B?aExDNHNNaGhuclV3Y0IyNWEvc3JFelIwQXpsUFY5MGlhTjA1L1d2WHpWbTNm?=
 =?utf-8?B?MXBJL2NBYVpTSkxXOWJ1U3ZtT2VwemlJanRDeC9qaXpvZFFQeTZrZFpWRTVv?=
 =?utf-8?B?dG5pWWdjU3VtQUR4RFpRZWtoTVloRlErVS94QXRSeGN6MjJkbzZweE5sNXVS?=
 =?utf-8?B?eXQxZGloUW4xUFhOcFB4M3dNeVZXaHlYTXdSWWN4bGsvRnZQQTZrNUxTdEx5?=
 =?utf-8?B?akhxeXdEajRmYjdkdWNENm5peUlwYnlYZWVYdDRIYmZLTk9aZndXMWtETUVS?=
 =?utf-8?B?MElsUnJScjBWMUhaMDEwRC9WcWhLTHdUY0c3a2MyK04xMTFSSUJDaDBoOHhT?=
 =?utf-8?B?UzQ1RWg5NFFSL2paL3lxUGpwMUJIMDdPcU5qOSsyMTlEK2JHY3RNY1haVGd6?=
 =?utf-8?B?eGJ0TEV6SzBoa1N0Mzl0dXlFOWpVUjdsSTJGYkpTb28yRGdhSS80NTNQSlFD?=
 =?utf-8?B?aXA5Nnh4a3JkbXlkRCtrRTA0eFV0RXNuQjlYOFVYMmZPQktCVmNqZG9UNlBB?=
 =?utf-8?B?eGZTTkE3WnJ4dmdlZmUxa05tcFBUZGN2SVJaek14UGtUcUZ3UFZOVlludEd4?=
 =?utf-8?B?cnVRdWdsRUVDNE1jZEp5TzYrbHpwd2JyT09pYndjbVlJUUNyZlNjNlhReldY?=
 =?utf-8?B?cUY4OVFYWTVSaC9ZM014dmQrWCthd3NwNXdGd281SFljZVlVZ3dwbVdrVDVM?=
 =?utf-8?B?SG1yUzlVK1IrZU84c1NuYm92ZUk5a3p5cDBXSG9IUDhZS0Y4MmVEeDFMR1di?=
 =?utf-8?B?ZjZXelgrOEpuMWY1K1FKcnNIQVNvL3NrdUNFQWs2ckV4R1hHd052WTh5S1NF?=
 =?utf-8?B?dmhWT243elUrSURVZitSRWk4YmpxanRmbi9mai92SXBDRWlqWjVKMHU2TXRR?=
 =?utf-8?B?T0UzaTV1NlNtS0o3clVpQ2VyS0dDUXVWNE5vRWp1WmlWUjdyNC90ZC9vSjVO?=
 =?utf-8?B?WXkrYmpFSmRzeldHK3J4S3M1QW8zYzkwZjN2UVdQUGdvK0NRYnMxNk5jL2M3?=
 =?utf-8?B?UWwxMGt5MFgwQlYzUkgvYnNtaENpcm9KVWQ2VG1GZUI5YzhuUUhpeHpCY3RM?=
 =?utf-8?B?Q21LQ1QwV2U2T0pkb3RJanRacjdCbEV6eDBXSmNyZktGVWJGSDJZNTQ0Qlg0?=
 =?utf-8?B?U25vckxnZktFbjFMWFpZOGlSTDdvb1AyelRNR0tmREVuZkVYQjM1NldSamZ0?=
 =?utf-8?B?aUxHejRGa3hhOXlDVXpoa3MzK09xUDhMTWJzdlIrUEdlWXpjN21lRFIxbTll?=
 =?utf-8?B?VUFsa2ZjNmJ6alRJbytoTEZGdWdHb0pBNUx2Y2ZsSlVFVDJSM1Z4aExYMkdZ?=
 =?utf-8?B?U0FvTXlmTkVmenR1MEVic2o2dDMzbFVXa2ZudFNtdXVFMDBsRWlxTGoyazVU?=
 =?utf-8?B?dmEvOWxVVkt3clkyMFFadnk2Tk9uYUhGWjhKbjdQdXRlSlNIODhPLy9pOXA5?=
 =?utf-8?B?eWgveVZ4cWcyNTBLNzRGVk84YldJOXZleUdtTUNveStXMTYvV1VLQVJGL01a?=
 =?utf-8?B?YkI4eGwweGliZVI2REZEVVFkQ2NWR0dJcDQ4QU9tWFE2cm5jbjdya1JuSzhJ?=
 =?utf-8?B?Nm55dmpUUWRoWjNoSVBYNi9uUVF1YzYxdE96WktGWUtRRU5xcElkcVpxUzlq?=
 =?utf-8?B?d05iWFI1dzdPN21sQzg3a255VjV0SE9IRm52MFVYbllmRzNKOTNXc2xhMWdU?=
 =?utf-8?B?bkR0ZCtVdU5LWkk5dXp0UGErSm1VbEU5Z1VuRmk1ZEtucHZSRlA2ckFYUXVL?=
 =?utf-8?B?c2U5dTlSMFlyRzJwT1lxWHNTZTBxSTV4QUpMa3BNcVcvT2RubFB6NXpBckZh?=
 =?utf-8?Q?9vXtz3WtwvVGnmmuvM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad19174f-5132-4465-2cf1-08de68002d2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:25:10.2400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT0w6V6DHHwmr148aWM7qzQ9GyUBKZIjkxr7JaSpg6qbK4+NhMs6hAuuZZ5ez6Z2VnxuisLd0JRb3dOCcXhurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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



On 2/9/26 08:48, Rodrigo Siqueira wrote:
> On 01/18, Timur Kristóf wrote:
>> Reduce code duplication and ease maintenance burden for old
>> DCE versions. Clean up some code that was duplicated between
>> DCE 6 and the rest of DCE.
>>
>> Timur Kristóf (5):
>>    drm/amd/display: Use dce_audio_create for DCE 6
>>    drm/amd/display: Delete unused dce_clk_mgr.c
>>    drm/amd/display: Remove unused dce60_clk_mgr register definitions
>>    drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
>>    drm/amd/display: Handle DCE 6 in dce110_register_irq_handlers
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 165 +--
>>   .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
>>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 +-
>>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 166 ---
>>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -
>>   .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 131 ---
>>   .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   9 -
>>   .../gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  | 967 ------------------
>>   .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  11 -
>>   .../dc/resource/dce60/dce60_resource.c        |   2 +-
>>   10 files changed, 88 insertions(+), 1475 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
>>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
>>   delete mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
>>
>> -- 
>> 2.52.0
>>
> 
> I Alex, Dan, Tom,
> 
> Could you also include this series in this weekly promotion? Overall, it
> looks good, but I believe the last patch needs thorough testing via
> promotion since it can affect multiple GPUs.
> 
> Thanks
> 

This patchset was included in promotion test last week and no issues 
were found.

However, I just realized patch 4 won't build without modifying a 
Makefile (see my reply to Patch 4). I'd suggest to address all comments 
to patch 4 in V2.


