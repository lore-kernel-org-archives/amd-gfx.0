Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AABCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1410E76C;
	Wed, 29 Oct 2025 10:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hJIwqo8q";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4F410E76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zaseqx2hjwRzw0q586t4X/OS+7iUWFSdlkCfa+FsgwUmHssLHTK10xLBEFrbR6m9eZK8icLdViJS965tQkM2eORqLuQk6DB/Q5vPvCi3c4kymw9jvQtTk8xImMr+nf4bWEa8nXWqjb0yGEoXiaWU2dpja0nByQinAIeRGoF59VdjQQGDOGfloldGzMbawVEwwH/llesd06cNfnc/FTWO2b0t55qJxK7onfNakUyZlufLix1IoiLxOZGsOsOSELWy6dkRGlvYK+CIK7HqEI3mL7fhxiLvANeTpXSQpQoZtb/o00fSQRfBBdCZ7yNi0144ebsPCz2PXmXMIUdaWQQ/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM6fvEOBL5Xt9EFU6xcDmHVvLZG0mldRPIgx3qeBeF4=;
 b=I68x/S6owMVvQ6qeQ/azX26GFxZXbhrh5ymYNFPvVXo/sRwVr1QwgXDadnUYhbi9UhW0KiYSWWwkS20GGUkhUoSrAYx0fXyX7+jiJ4ESfB445/eTSb62RcFaF7fBPpAWHLCZ52hMlosChVvU437ksGDtkuoP0mJFW9oRsCvqUNynQfz7EGJmpfI2VljRrLSHx5LblUOE82r5SnjS2FcmNBvNXqlMBziUSarbtcvI6SOrVg9Ea4i6HXMKqOneQQG+/dm9msxSt4dfgX9U9PLHfARz+JddMhioDDJZEjMkOhwKtGiSDJL0aUqaRGp6vwlfiA/DqpjL/h39FmL0ghOH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM6fvEOBL5Xt9EFU6xcDmHVvLZG0mldRPIgx3qeBeF4=;
 b=hJIwqo8qy5OaS6ptpD3KjS3Otc3oTa+8YmV+B1JDGmDwoz6ZAj7MdlKH6syOBNmho7afsxYPgq3dneMo4UU9XafbEfqOYWdqxsdgAIQoKFVBB7EUCJu4FK/CweKRM7aD3V5Ge/Hra4mY8Iaq5LfIVwLlhuXYiWb1tk8K9stSZUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:00:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:00:16 +0000
Message-ID: <f1e7e9ff-5314-4ace-9ced-42110ea791be@amd.com>
Date: Wed, 29 Oct 2025 11:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-2-timur.kristof@gmail.com>
Content-Language: en-US
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fe3d8c-edf7-40af-e341-08de16d1f5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXhjU2l1TEdxNFlPelFXdXI0SXBnQ3VQb3YrRzhWb1JwbjI5N001UkZNdnZI?=
 =?utf-8?B?dGtLVERRc3FLRDhLNUdsdEZPQTlxTENzMTFSNU5udk43VlpGaC9vRkFPSEd4?=
 =?utf-8?B?dkRHdU5UbVFVZEp4THc2cXNRcDFUeGVWdUZIRU4wMjgyckgrWG5rY1hqdmZR?=
 =?utf-8?B?a2JHTW1LTnZHenpRT2lBYVQ3QStudDNyQUE5OUdNd2p0SFl2MysxUk0rWU9n?=
 =?utf-8?B?bGFGQjl3dExLZkZwd1A0U0lBSTJSZmlNTlljc3ZBdWx4ZWJ2Qkg1aEFOM0lF?=
 =?utf-8?B?VVc0bUFvVTNsaW5lSXJMUTExTExDUzY5Mis3ZU85NnNhOUg2RE5RK0pDd1N2?=
 =?utf-8?B?eGkrY1ZWbmZsbURBNU5jYkN0VHcxUFVZcmVkZlU2VUNUK1c2aWpHZmUwdURk?=
 =?utf-8?B?MEZNeFYwaWdOVmcvMEE0cjNqS1hMZGhCSUN1Z1NucGdZV3JhdlZuUlFKUDYy?=
 =?utf-8?B?bERzaHJmN3g3R0VWY1R0L0FrWnFPRGZpM3k1dFhSYmJmeEZTd3Boa3VleUwz?=
 =?utf-8?B?d0RyaHFZK0I4MXh0QWFFbHJNZ3doRW5hMy9OUGppZzRZZ0JMaXhuVDV4VVVj?=
 =?utf-8?B?ajVSVzZuSEV6UVJLOG5GVUN2Q09ERUZiL0Q4T1JWY1VJTzJudFZWV0VxT1Bw?=
 =?utf-8?B?WXBxRmk0Wnk1S0Znbzhad1l3ZGdFWTVWRWg4V0hLYUlia2RiSzN4R2czQzhK?=
 =?utf-8?B?aE1hSVg0RFBwMXNjaDRjOU1JYUdKNU5Nd3VHMVJRTTlleUNNN0Z6OWRsMUVD?=
 =?utf-8?B?SW5wNGlGK0dSenFoUi9zSG9EYUtlc2c3OHVvMTN0eHNDZ2lzSmdFU0FRcVBy?=
 =?utf-8?B?amN1T3R3TDA0L3NkaXVnU1Nnb0xSLzlNZkFqeHYxZjl4MW4wTjk1VjkxLzM0?=
 =?utf-8?B?dUJKQW9SVXpSVDRROFBCSWV4WlZxaHZYWlVrV083ejZUcE0yZXZydW54UmpN?=
 =?utf-8?B?a2hJS2FUQnJFZVFQVTBVR0dJU0NkcjhoNXlZQ3pmdHdySnJ5UEg5aE5FdGFY?=
 =?utf-8?B?SzFoeVJtTkpoT2RsYkRCTzh0djM3V1NNYjMzTVAxS1ZBbUtXNERtVWVINDg4?=
 =?utf-8?B?QmI0QXUvRnZpQURoM25TaVdWOWZUeWxnczk1OTFzWHVqWHliWXdpUkRNNVhs?=
 =?utf-8?B?b3g2NzF5UzRnZENTdk94REN1VXE0SE1WMk14ajdGQThqdGtrVGZuYm9zOEZK?=
 =?utf-8?B?TUNEeGVwQXFEdW54azhvMlc3QXMzZHBhcWo2a3BNTE95ZUw0WmdqSUdXNjFU?=
 =?utf-8?B?SzNtS2JySGRCRURVUmZNMlZaQ1h2OUZ1WlpDUDQxbU5GUi9yZ1phdGVxTTJ6?=
 =?utf-8?B?bmFIOEwreXRPSnlUYXhiUll0dmdmQS9xUUhDNy9pUWhLNjBlS1p2SnY2SUM0?=
 =?utf-8?B?OEVFaUt0V0N3eDBsSGdQS2xjY3l3TVlxd3RPa0YrMDl2ZmpabkduUC9KUnQ1?=
 =?utf-8?B?R0MzaTRiOHRjTjdNQi9rWDRyMURraTdNTTdvMlU2TGErTkdiMEhrbTAyOTky?=
 =?utf-8?B?bnNEMXN3SUVpSHRoS1kxckdwWllVaUV4RnNNNW9lSHFhbGxpRkZkbGtPQVNu?=
 =?utf-8?B?UWMyMTc0eG5iZ1VJVkZPK08vdWJ2TFpiTE1hTWVTSDhwTlQvK3krdzV1aVV5?=
 =?utf-8?B?eUVpalFtVGxrYWJ3VWhQS3JyeHFYQnZ4RFBsTkpWUzVMSm5aeS81Z25NWldX?=
 =?utf-8?B?QklaeFI3NUFPSVlDV2x5VW0rdWlVWXNVV3RhdnY4S3VwLzRDSzJNZlZ3cjZH?=
 =?utf-8?B?NkdIQUtiZlFicElZVFlIdG5Fc1dNMWtHZnZjUzNuOCsxWFVPNEpoblJGUkor?=
 =?utf-8?B?TUZkd211NEczWi9ZTjd3WG12b0x4WDVIY0xVNllEdnBjY0g0TG1kazBuaHdI?=
 =?utf-8?B?T0ZzaVdTK01HaitPdnZweTJUYVBDbnN5djFiNjlTcGhlUGxMSG9HbGFXTFBP?=
 =?utf-8?Q?csUZija4G3xK7bJqtX2jaM1tbmOBwDCh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5Ucm9IM2V2emZ0OFJxQkwxcXlqcHRPMXBQczVzRHJlWUUrWDVVNDlMbmxF?=
 =?utf-8?B?TmFMUGZCUWRjSTNTOWdSRUhkNW5oekJ3VEdaUmtLbTdKODJIa1kzQ21saFFH?=
 =?utf-8?B?QWlGd0hNQXJxRlRoOTA5WlM4K3VvRSszdVFlUmg1MFA5UUVKRTB0b1A2RXhF?=
 =?utf-8?B?UU5RcDBuTWFKUDRZNk5yZ21NVHg0QVBvaGdvanBna0ExdkJpekVIczdMNTdF?=
 =?utf-8?B?dHFHTExrRitEZzRZNldSQXp4OEU0RnJDQ2JEVmg3M1FYTXNQd2tWY3QxZjhT?=
 =?utf-8?B?bmpTaEtJZnMwT2VBZXREdTJ5anZkV0ltYmo0RVh4b3lmNEZIbHoweU9mbmxH?=
 =?utf-8?B?MWpIV0Q5U2tYcG9Cb2hOTEg2OW9HL01mbkNNNjBHN1QzcUFYRUtTUHBHdTlF?=
 =?utf-8?B?ZjZWUjBWWW0yMUhrdkwyQzhZN0xXcDk0clEycjcyNVhROXYzMVBzTFZZcWh2?=
 =?utf-8?B?bDArblMxb29uaDh3aXNEbDQxNEg3Rmc0YUVSUmRSaVVHcVovZlVqdnBnNVZX?=
 =?utf-8?B?WEIrVGlCOE53QWtmL0x0anNNRzhEdVZJRjdCWkdQZDM3N2RhckpqbWtVTmx1?=
 =?utf-8?B?eVJQT0R6a2RoMVl4VzA2bWVld3huaDNGRDZ3ZzZnSTBEd05UNGt1SjB5K3Zm?=
 =?utf-8?B?cVJkQk1UYVNJa1ZOa3lCdW1QS05LcWpGM2hicTF1b1FOZ04vNnRZMjJKWXFw?=
 =?utf-8?B?YlhKZWUrays1eFA0Zkt1cFlGRFdjTDJ0c3hTamxod01IdTJ1ZXg4anJhdmh0?=
 =?utf-8?B?YjhtbGJSRzAxdDJnWUFiSGsvRGdoNGNHOWdvSUpLZmIyU09pVnZQRmNaTXpI?=
 =?utf-8?B?bEZBNHJNZ050UjBZUzJwcWhUOTNJak4rUE4vc2RmM25jVjZTcXp4QVNNMHRn?=
 =?utf-8?B?VHg2bG1WdGQxaWNhRGVlaG1kWjg3ck14K0Fyc1I3emRnVE5jSElNVlQ0ckVQ?=
 =?utf-8?B?Zmc2YURBU0pRa3Bid3dKK1Jad2xRK0JidmdNYnJUNVJZdDh4bGxndnRkTlF6?=
 =?utf-8?B?ME1hT3JMU25JbDRJNWJiQklObUdlT0dNaHkzc09aT0ZOMmJuaGpBTi9pQy9h?=
 =?utf-8?B?ZGtyN1VLUEZ5UXh5dW1aK0FkMUtSRm5IK1dTZUhFWHFuQlE3UXFaaUozYytV?=
 =?utf-8?B?R2JIS1RRa3N6TlFBdmY2Z3RIeVlUSEY4eE5qTVN3ZFAzM2lSZGxWTm5vWWdy?=
 =?utf-8?B?OFIyREttcEg1NWwyR2VyM3FRRG1oOGRSbjhGNFZsVm9kb2p5dGxKQVJjWEpL?=
 =?utf-8?B?SzJiTDY4TUZ5YmxiWkUwQlZHTThaSUJXckxUZXdkZXkvSUZKeHZ1d0FQZ0hE?=
 =?utf-8?B?NTQveHp1ZXgzaCs5ZnBaSXRnZkRTVTF5UHVxMGd5aWpiMDlPczVsTXRTN2lt?=
 =?utf-8?B?Rk5NRWVXRmwzTzM1ZUE0R01RUmtZVDZUTk9qSXNEOHFmc0Nxc3NBMm1nVzVp?=
 =?utf-8?B?eitQY2laVEtaVW1tV2FBWVJGWmRwd29wTW96SElCc1JXRU5zUGZ4bVFHVFhs?=
 =?utf-8?B?dUNmdGdyZllGcWJxZWJ5emZZRzZGMlRWMHMvNkpGODJaWEloUVNET29TV1ZT?=
 =?utf-8?B?OGpMd2ZwQ0FiUHNUdjNXVy9vaEcwYXpmbFZwTXpZTWxNdGphM1g5bWdSUHdp?=
 =?utf-8?B?Nm1vZDA5Zkk2YXIxZzUwMWtrSk1nTmhrTVRLY1BRc3dteDJuWDhhaTQ2d0NQ?=
 =?utf-8?B?WWdyck5QZXRTOVgvOFA0aDlwZk1NekJ4RUxMQndtUmNHa3pNbkdJUVdtenFr?=
 =?utf-8?B?U214VmpsUDkxbFEyYnJyTDg2YTB6ZmozeHIyV2pCRGdtWUx0c0NRSlRMeEUr?=
 =?utf-8?B?eFlYNk8xTGZCN1JYUzB1ME8xRUEwRFlVd0k2US9jYmlPaTBVcnpvd05kbThv?=
 =?utf-8?B?KzNZNk1nQ04ycVh2V2FtVU9JL1lKNnNWaGJoZlE4K3BKbURJb1lFSWxJVno1?=
 =?utf-8?B?MUVXODdaRzk0dkl1TkhNbTRHNjFvRVpsTk5mSlFuV3N6SmFhTWU3ZWY3N2RY?=
 =?utf-8?B?V3d4MjNmNEpaUmNEMmdOUGhaeUJlRzFiTzFxWTREUnk1RTM2MnJyTUtOMUlu?=
 =?utf-8?B?RUZLRUNZTlN4ZHJWQ1h6aWUyWFFXYWRQWC9RY2RWQVdFc29LN2hIeVZrcmM5?=
 =?utf-8?Q?uD8uS+gtq8vHR0/yhX8KFlqfs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fe3d8c-edf7-40af-e341-08de16d1f5bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:00:16.4155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOT6NliKYb9u4Dm3MXT38hyxwKrT8ZjrgTynpPRUMgcQNM57ayeCvVKY3oKAHabe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
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

On 10/28/25 23:06, Timur Kristóf wrote:
> GART contains some pages in its address space that come before
> the GTT and are used for BO copies.
> 
> Instead of hardcoding the size of the GART space before GTT,
> make it a field in the amdgpu_gmc struct. This allows us to map
> more things in GART before GTT.
> 
> Split this into a separate patch to make it easier to bisect,
> in case there are any errors in the future.

Pierre-Eric has been working on something similar.

On the newer HW generations we need more transfer windows since we want to utilize more DMA engines for copies and clears.

My suggestion is that we just make AMDGPU_GTT_NUM_TRANSFER_WINDOWS depend on adev and so the HW generation and then reserve one extra transfer window for this workaround on SI.

Regards,
Christian.

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 97b562a79ea8..bf31bd022d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  		break;
>  	}
>  
> +	mc->num_gart_pages_before_gtt =
> +		AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
>  	mc->gart_start &= ~(four_gb - 1);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 55097ca10738..568eed3eb557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -266,6 +266,7 @@ struct amdgpu_gmc {
>  	u64			fb_end;
>  	unsigned		vram_width;
>  	u64			real_vram_size;
> +	u32			num_gart_pages_before_gtt;
>  	int			vram_mtrr;
>  	u64                     mc_mask;
>  	const struct firmware   *fw;	/* MC firmware */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0760e70402ec..4c2563a70c2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>  
>  	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
>  
> -	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> +	start = adev->gmc.num_gart_pages_before_gtt;
>  	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
>  	drm_mm_init(&mgr->mm, start, size);
>  	spin_lock_init(&mgr->lock);

