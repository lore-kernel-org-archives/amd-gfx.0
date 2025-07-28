Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E12C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 18:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4861410E562;
	Mon, 28 Jul 2025 18:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQhOEoSN";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B4210E562
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 18:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4l6GmHgdxkiQYlmpylaRMNZgiy+3NZjNgsRpa6K5JTteEKqnuibMlFsOB16dArDSzbTh1tLc/NMw3kuUdVHq3JFVClQlBMbNG2Ug//QWEagwRpXdB0mSJSoo95v/R1DNbg/OETULm9bgnd0ilosx7k/FIMaIjh3duUmQH1MJnGF8fy5C3amcPPNDbiW6SUR1IFFm+44xi9AsCtiA8vLWbCOz1I/gUak6CtsefS5ogLQmO87C03XQsh2Bn8ATlHhKbeSZuW2IF3stxzdsVaDBVmr1+gH6piaKqZoqgSkjX2NsyDwgMHvaoDsb6U16goMY/FnXa5w9Z/2r3cZImSCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WirZYfv2E89yTPBNrzgY+FUU5MA5MjnUZkycUfl6nNc=;
 b=viG8ch5718+Jh8AH19lyV1TCcGqyYspZ0GlG6LCKSKcbY2xzkO1kNqZLApihOXToTacHgaA0gUiNsbFH42PbMWRtKhr2t4EJXY86/h3iC+ef8KLMnmaj7MR3EvA6bP79zyB3br/0YMKQOrgnSMuXc98rc8XAQTmiNihBlHqIgPmk21wkBt7MGZNbO8BU3J1inalPsl6Mr41eoGTrqGjBdCvlKZku2erftiShFYwjQusvAAjITVPXv7NbDIO6BC/WmwhvtF4E7rXrQpeeWuJcCFal0ZQZjDiFXHXv4I4Px3nFKMSvkDwlr1HFqp+WxSSAHmLys26H9utDFyN8D0QRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WirZYfv2E89yTPBNrzgY+FUU5MA5MjnUZkycUfl6nNc=;
 b=eQhOEoSNRX5bRN6yMan6xfO/pnnbjRy2KYglMXuYjG0lsC9U5tiXmoKf2weXnoZ+ZQ+qW8q/8XlHOoZMuLw2tUaHMY1bC2mqFd+lfBPXgI36TgmBxwsS4jlesFB5mMOt/RLCzAQJTyyVHUbAmoAtYNs4cWMIk147zAJfgNcSS5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 17:59:58 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 17:59:58 +0000
Message-ID: <a997fd4d-9329-4af7-9282-9b567fc3a8f4@amd.com>
Date: Mon, 28 Jul 2025 13:59:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Documentation/amdgpu: add a few acronyms to glossary
To: Alex Deucher <alexdeucher@gmail.com>, Yann Dirson <ydirson@free.fr>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <20250720141318.4845-1-ydirson@free.fr>
 <20250720141318.4845-4-ydirson@free.fr>
 <CADnq5_MM5knDXoQ7WSX5_+xOH7FoG=gk1A5XLGBiJWXfcnWEsw@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_MM5knDXoQ7WSX5_+xOH7FoG=gk1A5XLGBiJWXfcnWEsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 8929a5f4-4993-4f31-a174-08ddce0090fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|15866825006|41080700001; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmdiSlpqaGN5eThUclhKTERWOE5sS2lLZnV5a1Yrekh5bUZQYktyVzJwWWpN?=
 =?utf-8?B?b0gxR1l2a2RJN0hyWkRsRUNCWEdHSndqc0lQOW5zaWVad2pVUW5ILytHRDRY?=
 =?utf-8?B?cVFza3lveTRVcHUzOTZqcVN1OFVWaEpSSEVMTUpRZEVUU3ZPSlhDTVJjcjI1?=
 =?utf-8?B?WXlBbHB5NFBzZjFNVjhXTjM4dFZJQWFBQ2c0eEQ1eHcyOVhmUWJmaFRwNUZG?=
 =?utf-8?B?ZzFuWVlHcHIrZEJwRkVwd3JIazJ0azVJdnI0VEhYaEN3ektBTE95Ty9MSHZk?=
 =?utf-8?B?UzVoODNvMHRrc1g1SGUvZ00xUzZFTG5vZmNCRFBwQjk1Z2Q5V2RkYXhHMUpk?=
 =?utf-8?B?WDNCVWN0Y0JiVnZJT2cwVHRqQ3hjM3hseC9UME0zR1ZwNlJubTlhZktUVndp?=
 =?utf-8?B?R2NoSW5yR0RFZG9IbUU4NEx2ekovanc0UGNQTEc3SXY1a0dONk8wNDdGVVAr?=
 =?utf-8?B?RXBxSXUrZzNyZVk1ZElDWTQ5RWVUakZBSWM4Ymw2VS9LNDdMREZJY3BsdFh4?=
 =?utf-8?B?TUMxaGJ1MmxsS0lPcVBPN3FQMWxlamhHTkh3dVpkcGZ3VXo0ajlVUFY4aVV5?=
 =?utf-8?B?L3Y3cUpvYm1XUmhFSno0MUpkNUlWWjN3Qnoxa2U0Z0cvWSt0QlJkdUUzK1F1?=
 =?utf-8?B?UGdyUGp6WWJIQS9xencxd1JjV3lqNzJjMldDOFVwL2RhazdlbzFIOEgrUHMr?=
 =?utf-8?B?OU5hMzZycm1hMlBCMyt5MkF5MFBRUGh4QjdZZFh2SlBMSWx5WW1mK05BRk92?=
 =?utf-8?B?UTlxalJsN2NsNWVhdEZ3YVlaM0crZ2RpdExKUU1VdEE4bVZ5aDAzem5RV0FX?=
 =?utf-8?B?Nm15QWRXNjdOdW44ZDd4VnhmVDlQYlk3YmVXRTR1VnlnVkxxS0Z3Z1VCbXY5?=
 =?utf-8?B?c1pJcG4rZFJyMkdnZzZEcTFtRVRTWEZMMHFTdFZKcldDMU1sdUplaVpWbGNN?=
 =?utf-8?B?UDdNK3lkdDFDMDFkbzI3U2l2THZJSzNLOFUyK0h1UENLYlZoLzN1UG5FTzhM?=
 =?utf-8?B?eWtjcWdDZG9LdHY4RkROeDNHYVpJc2RhU2pGWC9CREthZFdkak4zOWY3bmdn?=
 =?utf-8?B?S1JoMFJmQmhvRG96WHNWUEpQNjRXSmJ4clBRcnQyMEw2UFkvQS9XdGxFRm1E?=
 =?utf-8?B?SEFrQ3RCRmFZaTJubGxGS2pnTjFmQzRGelFIUFhyanpuR0xXUExHV0lKTEZi?=
 =?utf-8?B?YWdtSGo3VWw2NnBZUnZzVDVuajRWVmpKY3V0d0lid0NQamZ3eTFOQUxQbCt1?=
 =?utf-8?B?OWIwMUQvWEFGTGxwSm1PWnZqN1dpbXpzSE0vTHp3ek9ZS2U4b2VBUnlmMVEw?=
 =?utf-8?B?d29IY1ZLbktFWVhFd3duTXhIZHZmYjBsNWZiUFNGRE1Tem9XcTl6UktsdzFS?=
 =?utf-8?B?em1jNnpOcElCM20xNTV2U1ZlNWQ4SDloK2I4c0ZPdTgvWGlUMFozeWJnQTZK?=
 =?utf-8?B?VnVjd0V3WXJWSHVDeGNwakkrQjBWV05uYzltT0dicUdROGNrVkxOdEd4Rmow?=
 =?utf-8?B?L0hhNWQ2S1Z4Z1M0VWgyczdTNDZINzhkNDJIeDVIdzRsTXVjNEswWVhXdFE1?=
 =?utf-8?B?TjJDZFNkaThONTBzajg1eW5waU43SXJRUDZQZkpPRGJ5S1NyQ2pYNWlOWFNX?=
 =?utf-8?B?aE5mRTV0Rkg1MlpheUllN2kvR3VQQlFjbmg0K2g3amNNSDBaYVA2T0RpUDVM?=
 =?utf-8?B?TlozL0NhWWtPaGZZaUV3Ty9BcXdhUlg4akFDalczQWZITTZHWE05K1dUMWZw?=
 =?utf-8?B?UTcvK0s4R0hVUDV6b1hvaWZCajdod3FQZWVhZVU3SXNzNlFQRXpXcnB2VkJj?=
 =?utf-8?B?Z1lzYWV2NW9BOXdWU3hUL3E4Y1c1a2xKcUxBbitvSDZyM1dvVGVhREVKYlVU?=
 =?utf-8?B?M0lvakljSFc4ajkwVXBvNVZwc1FGcTdhRUtMWmJtUk9jNDV0Y04zbWtsNnNP?=
 =?utf-8?B?dnFYRG5jTGhNeGFXb0lsNjdXcnBqZUNaQk1SMSs2cVdOdWl3UTJuOFlmNnVI?=
 =?utf-8?B?bmJGRGdYV2U3Syt1dTN2UkVSeWJjczVEbjgrNnlIWk42TXdRRDZxR1Nlb0dO?=
 =?utf-8?Q?S6Ubkn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(15866825006)(41080700001); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JsNlRDYVRrTTZlVUlCMkpOVWluMFJ6OHRRQXJrMjUzR2pHRDIyOXhKcTJP?=
 =?utf-8?B?OGE5Ukd3U2JZVGRNcktncGtBT0orUVBpMW5ENi9hNU5xVmZ0WUhrZ3QxNjl1?=
 =?utf-8?B?eDBoUzVPMXZmT0h2czNmRS9IbkRBTENiQkVoYmRFdVlZUWFrTng1elY4Rkx2?=
 =?utf-8?B?SFlHMTNIK0N0R1VxaHE0S3BoZHdVblRrRitaNlFlaUcrOE9lY2IyZTVJaE9w?=
 =?utf-8?B?MEJCWjFHMFhsRHJUTXI2SVZqMVphSEJwYVZxekkzZklmK3JaRXVMSU9tbys5?=
 =?utf-8?B?N04rdEQzTHIrdUZqc0ZHQm1nNHNaWTZnNlhFZDh4a2pEbm9WOE9XVXlKZW5i?=
 =?utf-8?B?cm5Wd0lPUzNGanp2THhJRkVqMGVCS0VKZlBWUVd0ZUViTDhLNlZtT3ptRTM2?=
 =?utf-8?B?NHdWMmRvSyt6ZDhSQTBwcHVwa2cyMFBKVnFBRytzaEFnZmVwREZaUzJraE5k?=
 =?utf-8?B?ejBFR2JRSWJaZEZmQ25rQkh5T3pCZzRrRHp4QXA4QTZycjdqWlE5dDFqdkhS?=
 =?utf-8?B?THd1VkJTRjlLakNNRkQwUEUzbU0xY0dQdkVHTXNtMWdNVitvYi9vbVN3TUV5?=
 =?utf-8?B?Z1JKMUVrVHdLWFhsSEphMVQ5OFc4bWt4YkVJYnJtV0YyNm5KYlhSMlo0UG1s?=
 =?utf-8?B?enJjQnBYUzVXWFRaMlJaTDZ4WHpTVkVkU1FCTjNCLzRaUllNWUFZbFh2b0h5?=
 =?utf-8?B?NUdKNmFZck1lSnVnMXB2UytIcG1SNnBIUFZEWERSVjE4WTdzRDA1YlhjWENK?=
 =?utf-8?B?dzVScUtkSzV3dGRGTHJTSG5QbmVYclJrcndSM2Z5QkJkWFVzNEQrOVRVbHRr?=
 =?utf-8?B?Y3VsVzVxWHVWTForOGozdGErME9QM0thTGJGYTdOZ0dSQ0Z2TG5SLzF4MnZ4?=
 =?utf-8?B?SUZHVUgvSko2WGtMQ0hVVDBLWFlsbHhkdkdYL1JQbU00WnhXbXZMcGxmZXI4?=
 =?utf-8?B?UGVqRVRKR1RFNGsva1ZKNTAwS2NJY2ZVd09KOFhwRnJmOWlBcGJpMTBoUW1R?=
 =?utf-8?B?b05UQ0IxV1crYm1YaFJBSEZ5WEg5eiszRGlKd2g3V08reVpsZGVyei9ZemtV?=
 =?utf-8?B?KzFUZDdlRnF2eVU0Q0lVN2ppQVIxMTNLUnlVYnZTLyttbjFIeFhzYzYzbmtB?=
 =?utf-8?B?ODNqUiswei95T3JSL21SSE1hQUFuN1lKRW5SNzJEM092VWV3OXh4dXUvWE5N?=
 =?utf-8?B?TFZFeWZxM2c0U3RJVlJ1Z3RqdUhYcm02UjJpMTg2ejZRRUdUVi9LNURVRWNm?=
 =?utf-8?B?MHFybWc3WHRLdkRoMFdBemF4WlluZTRnN0pCeWVoRUs2ZkFZSTZEWmFKYUJG?=
 =?utf-8?B?UDYxQTdZYUlqOHRrVlNnRHRwWDZZSGc3eVJoMzhNamtrVDZkbCtlZ1ozbnpl?=
 =?utf-8?B?dHJFR29XdC9qNW9PYk5PdGNqM1RjOVAyZDI5MStHMERRRDgyaENWKzllWDM5?=
 =?utf-8?B?cjllazMrbUVkbm55c0t5V20yTjJvaWcrTzB0bStpN1gxd09wVlFIb3FBUFZ5?=
 =?utf-8?B?eW9JTDkvdWk1b29sZGNkZDV2cU5Kdkp3bGZ3R1BvbldVVS9HbVp5MnVyL2xi?=
 =?utf-8?B?dHc3b1BwRWVtZWhzMGFCVGN2a0M2MEdPeFJYVFRENnpTQk5zVHAxYm9rMFdh?=
 =?utf-8?B?VGlERU90cDIvODJnNFExOXBhTGlYNFI1a1VsSHNNekxDMG1nL0dNZkhJd3Qy?=
 =?utf-8?B?TWE1VXlhbkRUR1gyVjAzdTBNSUlSVFIyNUoreFN2UldZcHUxbkswMTJISzFJ?=
 =?utf-8?B?aGt4Zm13M1o0bVJQaEVDRUZncDRCUEZRS2ZzTjhWYzQ1S0tGWG9pZVl1empG?=
 =?utf-8?B?YXdDUWVHdzVueEE0d1BFZlAwVy9BeHN4RWd4cExHMXRQUWJRbDNodWlSQW55?=
 =?utf-8?B?cmlmRG4rZ3lDc256WXVNMW5YOHdYT2xYdVpwUkJYQlFGYjliM2lBV0x2UVRs?=
 =?utf-8?B?SUhMc1Q1ZGhaVjBxSnc0dFdCdnBvd2NseXZZV3doOFlwSzVFNlQvcnA5cnBL?=
 =?utf-8?B?TVZFQkVJT08zbUx1aVI3WDdZZXBwdG13ODFHcHpSeEcrT1VKNnIrYzl5NFl0?=
 =?utf-8?B?UVUwRjRSd0JZSlNEdkxub0hqVFZ0U1V0VzQwM013elJSYUl4NTlEcTJLTTVF?=
 =?utf-8?Q?ETI47AXzZBNRvDvrvkeIF0FdR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8929a5f4-4993-4f31-a174-08ddce0090fd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:59:58.5804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QCtvUjR0wBJaBt8NjgsDDWURcgNInXYB0/snJkThHPv3wZ2Z3XLjNiCa8alQ6I8RPfaStBhOzj0Mt16ZXrhXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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



On 2025-07-28 13:18, Alex Deucher wrote:
> On Sun, Jul 20, 2025 at 10:23 AM Yann Dirson <ydirson@free.fr> wrote:
>>
>> Signed-off-by: Yann Dirson <ydirson@free.fr>
>> ---
>>
>> Notes (patch):
>>     test patch note
>>
>>  Documentation/gpu/amdgpu/amdgpu-glossary.rst     | 3 +++
>>  Documentation/gpu/amdgpu/display/dc-glossary.rst | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
>> index 30812d9d53c6..ad9e6f0f91ba 100644
>> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
>> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
>> @@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
>>        The number of CUs that are active on the system.  The number of active
>>        CUs may be less than SE * SH * CU depending on the board configuration.
>>
>> +    ACA
>> +      Accelerator Check Architecture
>> +
>>      BACO
>>        Bus Alive, Chip Off
>>
>> diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documentation/gpu/amdgpu/display/dc-glossary.rst
>> index 3205f80ad471..d6a6ed4e6374 100644
>> --- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
>> +++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
>> @@ -88,6 +88,9 @@ consider asking in the amd-gfx mailing list and update this page.
>>      DIO
>>        Display IO
>>
>> +    DPIA
>> +      DisplayPort Input Adapter
>> +
> 
> Harry, Leo,
> 
> Is that the correct expansion of the acronym?
> 

Yes, as far as I know.

Harry

> Alex
> 
> 
>>      DPP
>>        Display Pipes and Planes
>>
>> --
>> 2.39.5
>>

