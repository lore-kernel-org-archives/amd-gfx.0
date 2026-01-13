Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8196ED2D11B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 14:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5F210E2B9;
	Tue, 13 Jan 2026 14:48:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4TNPM0z";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65C610E2B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 14:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiIde6sEEI1UHrOfgNKT1HqhqDtLlqI2Z5qO0lFKf7u5AmeaM9wdJjZS521Aa8Gb/WbtG8b4nzEherYZ5RT3QrUumKzls9BK2NxO9GUCEYJzZeygfHtntAz7kxl7hDu3yznoI0bwSyZ3Zs9svbFvqBsGgCg8RYODaBIDroMA0UUftUCuSytVfxN/8s5/JxDxseJrWEcw47f8cuDnGJlrNCSM/2ottzks194/i2TYXBwP1dSz1Dv5wukQpJmPq9WMzQd0NJQwSOWl9plpVUhI2hGYW5XwKQDK/i+dJCS0gi4JxqcJQH/l07FAEeoPJ6EhLvhTFaVy0IRDUYZ4SqblpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM/ZdgZxTsc2kQGGNHfwT8RBSMO1qAdyoYLJjPIEsCE=;
 b=unL6TAR8dDuudIicoXMdHTfUe60ZvhfydwJg7CxOhNh43Bwf+m8eHdf3M6GvbvzGj1+LpQ0PXTxzlRO+e9yAlF2UH0A5LLcVphcVSlrI+coBOUPToDCX/nsMYOA/RfsLGqooNbyt9tDDOsy/It0OkJaTzzPl58C7eL56tbbvswl8A185r5wnvrUKnXxnGYevtz2nn5IuoRZprMc5EK+Ojr9mBrYmM8NO2F7VPrmbVNQo7W1OkSFW6rz9Pyi5AM5Ipw5HWV7H1HcFtW/1qn3xueiI8MFQM56fvWinyE5FaFQZAvY1O67clsmmatAaeqv7qPocQ3VAcQs6bljC/VGBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM/ZdgZxTsc2kQGGNHfwT8RBSMO1qAdyoYLJjPIEsCE=;
 b=M4TNPM0zp+etozflKd6FwEffMBby+BBFlRcjhNNr2ZPS2mjfcB3NMoqj1ncr2OEWBJIRBpsCJ561ktUzdtjxgeq7duK+qVAHBXl6IlAN41ZkIK1tRYAS7S6+9S1DSG47b441H4WEw7dBt0f2oyo06r7kAcEUreRElDrbivcX+NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:48:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 14:48:01 +0000
Message-ID: <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
Date: Tue, 13 Jan 2026 15:47:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/42] Improvements for IB handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d35d74-6c2c-45f8-02c0-08de52b2bfdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHBpWWZ4czBiSGVCd3BwMk9JREZtUUFoTHNyNTdVN2EvcDBxYnRaQzA2VmRT?=
 =?utf-8?B?QVR2aUtuNDZONDdMQVRMZHFYcXluRmdWa0c5akVKTnY4ZXVQa2Q4Vmg3NUxy?=
 =?utf-8?B?L3p3Y3ZmYUZsWWczaHZZSCtPZ1hZaDg2OFN0Sm5YMnUrUFY2SWpoeTNKV3FN?=
 =?utf-8?B?aXVrNDl1QW0wOTMrSkRXTWt0amJLbVFtRnVBNDB3bjhKRlNPclovUStwSFZw?=
 =?utf-8?B?MUJlZlZKb2VScVh1b3ZObWJHOVIzUzJwNjRLU0lMd2p6TXFteU81ck5hc3do?=
 =?utf-8?B?NHBTeCtqdUs1Y1NyTTVKeThSUXkrV1dwQk9yMWJERktiTzFIVys1eXZBQXov?=
 =?utf-8?B?ZXMwTWtXY005Q2ptT3ZURlBSSUY3TW5JZ2ovekM1M3NEVGR5eXQxRFRmU2xl?=
 =?utf-8?B?UnlqWHJSNnN5eE9FZ0czUk12RG1LYUk4d2V5S1hNUlZiMDNHcVRJTFNUcWZk?=
 =?utf-8?B?UU81VDFGQmVsVmR5bUdwc3JhZzNaUy9LQ2d0VnVpK2xJakN3TUtWY2c0cHk2?=
 =?utf-8?B?cnl4ODBaSFJpRjUyRm15VXJmcS9yczZFWDg4TzZqNHhYQTRWTElpU05PVmRN?=
 =?utf-8?B?QTF3UlAwcVNyaXVJd2dOM0pYRmNFMTMraHF2ZEVuZ1N1eGNUY3lwWHdablNB?=
 =?utf-8?B?MTZhZzcwQUk0ZlB0bXlVVUs2NU1WTU9vK2VGWnZyOTQzeGNaSXdIU0F3QTVQ?=
 =?utf-8?B?YXBQN3NaamZKSDl3RkNjdEdzcGlEYXBOU3NYdWtNejlCZzh4VzF5cGMrSCt2?=
 =?utf-8?B?cUUreURwT0hBaCtJNWlEekJjcEgyNVFoNnlDTk8zYUhmT2piRFZaaVJ0S1VB?=
 =?utf-8?B?QTFUQ3ZtSmFIQ1VtajRkMi9xRGczZzRTSEZPT0o0bCsxaDd0QzUvekx4MnVM?=
 =?utf-8?B?b3hSZTN4MnJ5aHl0QWVOSXA3bjM1Z0RlRlB1UVNZdHpVdXNBZ2liUk80Vjk3?=
 =?utf-8?B?MWtYQ1pzaWtBdjUvMlRvZmNUb3lhdkZiYmUyLzhJRnBYZ00yMklDdkdQTzd2?=
 =?utf-8?B?MG1mSFZNQWx4NjNFTG8vcFh2MDVNZ0hNTHJpTDVkcUdKZ041OE9aRjZBRjFL?=
 =?utf-8?B?NXJuSnhFMnRlamhubjRLNHFnU3lzeFR5L1hPK0RmWG5HQWNVOVRtWkZxVm5j?=
 =?utf-8?B?MnNaOXdnMjh5T2o1VDIya2ZyMXhGWDdDdmNRTm9pNHIvWjN3NWJzUTlTTnlI?=
 =?utf-8?B?bWl4eHJPWGJIa0NOR2F1Y1ozclgxYUZlUjJEVnBNVytvUldBVWlXRkV1U044?=
 =?utf-8?B?VFU3QlFFZlRSWDJVRHJzSGUyaWN6RkJjZjZ6WW9vYW95SG16QkRrTkE3L05s?=
 =?utf-8?B?KzR0V0owRkZ4a0ZmVjFNN2FocnV1N0l3ZnVPSnRNNVB6N3ZXNXNJR1VKdzQw?=
 =?utf-8?B?dHdJOUlycW9FWnR5YzJ4akZyeXpJM3B5ZTJsTWQwL0x3TDJKdTNpb2FLSHNN?=
 =?utf-8?B?eFdFVjhTVjZkVytNU1RmNEVUWit6K3dyNGJaS3JGV3VKZ0xjNW53SW0rMXA5?=
 =?utf-8?B?UHQwTStOaUg4QXl6SUVHdWpPaEpid210cVhhSDJtdU5JSUZaN0RWZCtQNWxL?=
 =?utf-8?B?YzhNcnU5VzExbFFCK1FEcm5ibGdMZlRES1NmWlVaYzFhVnQ4WW1DMzBlYmJ1?=
 =?utf-8?B?dWhyWXF2NElyMHMwcDRGOHIxZFpUeUFWTi9wZDVvQnloQTdSallBYW1DZVRo?=
 =?utf-8?B?NEhlNjdBc3U0bUhxc1QrU3MveTNkemx0ODVkVnVBOVJTTklrYVZjeFN3WmZ1?=
 =?utf-8?B?d2s5OFdCdnltNDdKWVBudVlNRzNua3FwME9waDM1VUFDNW5mamFFQk12V2Jr?=
 =?utf-8?B?RTYxRUQxSmlFc2E5OXlKZjRlTzFyczd3NFRDa1FzUzk1NnRvL3ZYdjBRckZJ?=
 =?utf-8?B?QWdCOWprZGhEem1FOW5VNzNUbjNXbXFaWHZ0UTZUZG15U215b215RHhiTzgv?=
 =?utf-8?Q?xITVGtTCJc3dkWRe8DVbjdrrZI7L/6jj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFSSnZQZ1A4Q0RCZ2V4OTYwYnNES1JrOU5QbG9sYVhQS29oUVFhOGt2MHdG?=
 =?utf-8?B?UVljWllFQmJVOVBIdTlRV01XVlBaeEFlMEdBeXB2UVpXd2xNSVErcGJid3JZ?=
 =?utf-8?B?YlFFdm5MT2lXeXh4aTd3bFBwSitMQnhBN3BiS0VtNDFPMGdPeHMxZm9YeEpV?=
 =?utf-8?B?MDB0Qkw5WDVLU1NyaHFYMkZiYUxuUEk3VVlKbGQ5Y3ZHYldGVHN3S2tXOHBv?=
 =?utf-8?B?TU14L0hUdTg2ajduUHdNNHdFNGpwcy9QTVY4blVvTkJFdVB3VEptZktBK2lH?=
 =?utf-8?B?M3VqSDRMQ2p2MmVGZ0VPOEF6MjVnT2ptZlVjUWk4aDdXOHdaV1RrdnB1M3dL?=
 =?utf-8?B?cE0xWUc2TXZMVHFNQ0tWWlpnYkhuUStydEk5dmM5UTQ5MTJwWHNOS1M3L2RE?=
 =?utf-8?B?b2IrUGw5b2cvblpHcHpYMWNUamdjVnlmZVR6ZEw4eVZNcEMzeG9STWcxRCtz?=
 =?utf-8?B?ampHN2dRR0RITjhkeUw2ZWtJbmtEWXpySDJZalBTckV3bTZaa0xvbVJ4aGtl?=
 =?utf-8?B?ckttNXFIdCtlakRLeko4S3lCUUlOWnNVQmtrYUY5dGdIZFR3MGJmd2plUzdP?=
 =?utf-8?B?bVZZSTNYM2ZzZndScVhBT0RzWXA3UU9abkFYYlNKYklrVlFhZ25renFZVXd1?=
 =?utf-8?B?T1R4dldUSkcrYS9ZL1VaZXpsTjZhcG5La3g0L1FxUEdzOU1EdTNkUEwvQ0NW?=
 =?utf-8?B?UFhPWndsYlVHOUVPcHFPTWxBWit6Sm1XQjdBREpzZngzc3o3QWVOWDRuWjVl?=
 =?utf-8?B?Tk1aYmpISThsUjVxbDFpOVlBT253TnlEVndPVG9JaGpsbFRraCtZRXdNVUpj?=
 =?utf-8?B?SVJ6M3V4Yjk2alp4dklEdW9HbHlLM0F0UDI1UmpDL1c4YjBIbmk0dE9TaHVE?=
 =?utf-8?B?WHZSR1Q2c1NHS0x3ZWlsY2p0M0xRdWRqYVlUR3JhSGxPdTJ5WU1MamlLZU56?=
 =?utf-8?B?WGloQkx3RW1YaUU2TTJzbXhYUE1yZnROQlN1ZEFGYTZGbXpjVlJLaUZiczdn?=
 =?utf-8?B?OFd6STZLYXlBdlNZamVQc0x0bXZYeFdTV3NydThqVXZBTVloOEZjbXN2anhD?=
 =?utf-8?B?L3dCSEpyYWtvL1lSY21UWjg0V1FlZTBRNmxQczJ2aEFlTzJDalVlRzlCRC80?=
 =?utf-8?B?VS9oN3hUWHZsQzRYY010SzJacWlmaUpHQUJBWHRMRGFPY21OdzJtZHJva2wz?=
 =?utf-8?B?ZmxncHE5NDAxWTdOcEpNOHZ0Qk9lY25IZDdjSnhkZUkwbER6WHJ2NmsxWXkv?=
 =?utf-8?B?WDd1RG9JTWpHa3EwOUszSm1HaU9oUS8zcCsvc1Brb2hZVFM4cFY2RWNHMmFQ?=
 =?utf-8?B?YjYrOWNEa0VYa0pXaGI2TFEzNDZQQVBSK0M5MkdsVUlveGtBdkdQb2VQRUNl?=
 =?utf-8?B?YVlYR1BUQ1Myc2szUGQ0THZqV01uWFBUdkZKS0YxS3l0SXBOU1ZrTStKdmF2?=
 =?utf-8?B?VGZ2T2MrUDMxM3ZiRDd2ZVpzNDlVRjNSenJsSzRpa01RYnJKTzZDKzRTR1Nj?=
 =?utf-8?B?NUpUVlBtVjNRZ3YwQndmR0JCN3dzb2hXK25iV2plRmVFQld1SGU2TVRaejlB?=
 =?utf-8?B?ZW1DME9jeTNNVzRjUWpqUUoxc3M2dmtpcmw2cjVwSTVWODA1UVpwaTJ0RWI3?=
 =?utf-8?B?WlhSVHJLYUg5UDhGL2dVcHQrTWVqT05SZmczaS85aUdwd1lOYzM1eUFDbmFp?=
 =?utf-8?B?OTFRU0E5UWwyQVlVTDNOVVhNNlRtT2MzaWJmTjFmRzBBVURiZjRLTzF6ZEJX?=
 =?utf-8?B?TzM1ZEVmM09qeUlSVDgyYWVSUUJpYmc4WGFmbEZ0QTJMUldqNlZNZFJpaGtu?=
 =?utf-8?B?VGpRTHdSMVNobXhHc1JIdzNHNzJLWkE0YWpaK3pQQ05MWENucW13UW9kbXZR?=
 =?utf-8?B?Z094eDU3UnlrNWwzR1JleVBDUTdUNGlySGZMcURsZUdJeFU0Z25rbVBUYUVV?=
 =?utf-8?B?WWpvVFZzYnBBam93TFFWb3ZrK0RYcXY4cjZNb2UzSHB4Y0xkK1VJRWNRZVAr?=
 =?utf-8?B?aDZtYWR5ajZnRGZKd1Y0Q29yQU15SW1sOGEwUXJRZElqWTIzVHpEOXpHQ3RD?=
 =?utf-8?B?N0g4RnhaUXhrcGxlVnFZSXNNQ3NsT2pJU3g5UURJSkY5R1pibjFiZm5YbXcw?=
 =?utf-8?B?bEJVM0FyMXI4eXVmaWRsZVNKMURxZ0RnS05nY2tFTHByeEhuM0tORithb1hR?=
 =?utf-8?B?OExTS0RURU43N2ZnOE03WmpOVzhhVUQ5VGtwZDJleHVZR1Vpc1g2cHdQdFFC?=
 =?utf-8?B?V2lrTkQwTFA3bVF6cmFpVXltdnN4WlUzZWFyVFlla1hRS2V1cVlrUHBHUTYx?=
 =?utf-8?B?emlQeVAwdHpZblhBa3NvZ2s5SzBhWVZjYktQNXk3bm9MWUN0TTZoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d35d74-6c2c-45f8-02c0-08de52b2bfdb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:48:01.1536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyO3l433+Prp+K5ap9x73zxjDu37PzEDmXm0ZCW7xqfcdZF7XEyq5+FPdsemKQsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

On 1/13/26 15:10, Alex Deucher wrote:
> On Tue, Jan 13, 2026 at 8:57 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Patches #1-#3: Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Comment on patch #4 which also affects patches #5-#26.
>>
>> Comment on patch #27 and #28. When #28 comes before #27 then that would potentially solve the issue with #27.
>>
>> Patches #31: Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Patches #32-#40 that looks extremely questionable to me. I've intentionally removed that state from the job because it isn't job dependent and sometimes has inter-job meaning.
>>
>> Patch #41: Absolutely clear NAK! We have exercised that nonsense to the max and I'm clearly against doing that over and over again. Saving the ring content clearly seems to be the saver approach.
>>
> 
> I disagree.  If the ring emit functions are purely just emitting
> packets to the ring, it's a much cleaner approach than trying to save
> and restore packet sequences repeatedly.

Exactly that's the problem, this is not what they do.

See gfx_v11_0_ring_emit_gfx_shadow() for an example:

...
        /*      
         * We start with skipping the prefix SET_Q_MODE and always executing
         * the postfix SET_Q_MODE packet. This is changed below with a
         * WRITE_DATA command when the postfix executed.
         */
        amdgpu_ring_write(ring, shadow_va ? 1 : 0);
        amdgpu_ring_write(ring, 0);

        if (ring->set_q_mode_offs) {
                uint64_t addr; 

                addr = amdgpu_bo_gpu_offset(ring->ring_obj);
                addr += ring->set_q_mode_offs << 2;
                end = gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
        }
...
        if (shadow_va) {
                uint64_t token = shadow_va ^ csa_va ^ gds_va ^ vmid;

                /*
                 * If the tokens match try to skip the last postfix SET_Q_MODE
                 * packet to avoid saving/restoring the state all the time.
                 */
                if (ring->set_q_mode_ptr && ring->set_q_mode_token == token)
                        *ring->set_q_mode_ptr = 0;

                ring->set_q_mode_token = token;
        } else {
                ring->set_q_mode_ptr = &ring->ring[ring->set_q_mode_offs];
        }

        ring->set_q_mode_offs = offs;
}

Executing this multiple times is simply not possible without saving set_q_mode_offs, the token and the CPU pointer (and restoring the CPU pointer content).

And that is just the tip of the iceberg, we have tons of state like this.

> If the relevant state is
> stored in the job, you can re-emit it and get the same ring state each
> time.

No, you can't. Background is that the relevant state is not job dependent, but inter job dependent.

In other words it doesn't depend on what job is executing now but rather which one was executed right before that one.

Or even worse in the case of the set_q_mode packet on the job dependent after the one you want to execute.

I can absolutely not see how stuff like that should work with re-submission.

> If you end up with multiple queue resets in a row, it gets
> really complex to try and save and restore opaque ring contents.  By
> the time you fix up the state tracking to handle that, you end up
> pretty close to this solution.

Not even remotely, you have tons of state we would need to save and restore and a lot of that is outside of the job.

Updating a few fence pointers on re-submission is absolutely trivial compared to that.

Regards,
Christian.

> 
> Alex
> 
>> Regards,
>> Christian.
>>
>> On 1/8/26 15:48, Alex Deucher wrote:
>>> This set contains a number of bug fixes and cleanups for
>>> IB handling that I worked on over the holidays.
>>>
>>> Patches 1-2:
>>> Simple bug fixes.
>>>
>>> Patches 3-26:
>>> Removes the direct submit path for IBs and requires
>>> that all IB submissions use a job structure.  This
>>> greatly simplifies the IB submission code.
>>>
>>> Patches 27-42:
>>> Split IB state setup and ring emission.  This keeps all
>>> of the IB state in the job.  This greatly simplifies
>>> re-emission of non-timed-out jobs after a ring reset and
>>> allows for re-emission multiple times if multiple resets
>>> happen in a row.  It also properly handles the dma fence
>>> error handling for timedout jobs with adapter resets.
>>>
>>> Alex Deucher (42):
>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
>>>   drm/amdgpu: fix error handling in ib_schedule()
>>>   drm/amdgpu: add new job ids
>>>   drm/amdgpu/vpe: switch to using job for IBs
>>>   drm/amdgpu/gfx6: switch to using job for IBs
>>>   drm/amdgpu/gfx7: switch to using job for IBs
>>>   drm/amdgpu/gfx8: switch to using job for IBs
>>>   drm/amdgpu/gfx9: switch to using job for IBs
>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>>>   drm/amdgpu/gfx10: switch to using job for IBs
>>>   drm/amdgpu/gfx11: switch to using job for IBs
>>>   drm/amdgpu/gfx12: switch to using job for IBs
>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
>>>   drm/amdgpu/si_dma: switch to using job for IBs
>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
>>>   drm/amdgpu/sdma3: switch to using job for IBs
>>>   drm/amdgpu/sdma4: switch to using job for IBs
>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>>>   drm/amdgpu/sdma5: switch to using job for IBs
>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
>>>   drm/amdgpu/sdma6: switch to using job for IBs
>>>   drm/amdgpu/sdma7: switch to using job for IBs
>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
>>>   drm/amdgpu: require a job to schedule an IB
>>>   drm/amdgpu: mark fences with errors before ring reset
>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>>>   drm/amdgpu: drop drm_sched_increase_karma()
>>>   drm/amdgpu: plumb timedout fence through to force completion
>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
>>>   drm/amdgpu: drop extra parameter for vm_flush
>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>>>   drm/amdgpu: store vm flush state in amdgpu_job
>>>   drm/amdgpu: split fence init and emit logic
>>>   drm/amdgpu: split vm flush and vm flush emit logic
>>>   drm/amdgpu: split ib schedule and ib emit logic
>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
>>>   drm/amdgpu: rework reset reemit handling
>>>   drm/amdgpu: simplify per queue reset code
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>>>  54 files changed, 952 insertions(+), 966 deletions(-)
>>>
>>

