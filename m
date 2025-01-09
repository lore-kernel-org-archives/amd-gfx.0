Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667F5E7719A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 01:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB4310E14E;
	Thu,  9 Jan 2025 01:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j+mV06m1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9B310E14E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 01:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKL8w/K2GWwYVHmjnyf5nMSQURV4p6E0CxxqJbHG8PbjssUavsXggYqv7+iVEbqqx5q4+6ygc+SyOaMUg2+dQ87w5BqG3YUR9zeFJEUfPHKQ0RXkok/BCmcm0urm/y5+GwDYaU19dHN7+TN9c/d6ksD99rcaN7KNQUjQ38OzKeZcrw10eBBpOpKxq3NoUI0mZmqX88DEmtRs5o5tS6jfQiaC7SmdYaGdFDQLee6NGg/ZrelgVs94BobOzefgwpUt0zVJdjtjo9eOVP3jLZ3U4xMOQWgAXUtPdRh+yQbCaulSq2OfvLveVo8my/L3wIAixRkoMtIJvb4Ikm/dV2eRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8PjUsj3ySGcLdTk/KcDP9syKeEIdMil+FYOsHLDSGQ=;
 b=DiTBXMU40LivgnWPx7D72VBYm0mLDC4pjKMh3eLA6I15EHK99Tj+H2O3tyRCIgp+lyB6uTrExcicNpY+Dfe1P0Tu2854QtGX3rZnEcgU501peSOcWkNmPI5+GpbaxadY3XYJcnT+KYT/m40mrz3awAApH/R8ROV+0l7F7+W8L5YZlNW0JWeTNcu8ESdOM/bEk1OI9L3+tv1tjyTrBdgcsIqs7fOe3miC7HjKkzmr23vNtGke1pmI9ylTG71hnGfTX3dQc8KbCCDFRXdmmpiDMIDQr5jzQPGuBJNlK0HUtUlnGqjv7/IQRUdBoCofthWgvRNDoCw8fcV/3B7zx4XTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8PjUsj3ySGcLdTk/KcDP9syKeEIdMil+FYOsHLDSGQ=;
 b=j+mV06m1BZfd5VVXxyEOZZ98w/8KxY34sVUbyTDkbR+3Pv9um/rP/WUb8AHjP1JfPsYomClGF14kwsnkHz//Pp/FTbGPI4qbepoFv1jAFT7sHOdXTFxEgZzXOzMFY8g3sEB+mr9WgLvJJrb5n5V+/9pNSMItrhPtlI9UdPXOhlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 01:11:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 01:11:46 +0000
Message-ID: <2015756a-974d-67a2-d875-9b90a1a9b1f3@amd.com>
Date: Wed, 8 Jan 2025 20:11:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
 svm_range_restore_pages issue
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250103022615.1399054-1-Emily.Deng@amd.com>
 <62496e35-e23c-4d10-a5b1-99978665cebc@amd.com>
 <PH0PR12MB54177A7932BF4D91A8A41FE38F102@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417D0B508B3DECD240478E48F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <22e5cee7-52f4-ef08-b44b-e4fb96027ea9@amd.com>
 <PH0PR12MB54172D04315DCA27E581B2CD8F122@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417561D4BF4379DAFF7CF698F122@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB5417561D4BF4379DAFF7CF698F122@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 544e21fa-a18a-48fa-34d5-08dd304a9634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjRBMCtzTjNFeCt1aVc1R0daRzNTYTlJZC9ValhiWGpsL0JnT1F0YzVwNzZy?=
 =?utf-8?B?ZW4zUnZTOEhNVG1IWWwvM3RaQm5Ra2lwVkNCUys3UkZDQ3F0ZG5JdUFheitC?=
 =?utf-8?B?Y25kbGhLZSs5UXNjVFRSMXJxRkdxSDNPZ0xHZTZnQmYvcEhMWmpROUYyQmlI?=
 =?utf-8?B?SVhVaTdvajFaYXNrVytQMGJGSmRvMWFpNjJCNUFFU2IxWm5COUZEMmZwMjIv?=
 =?utf-8?B?K3RVYk1KMXY0THhTN1dvNVphRjhUa0lkZHJlN1phbktKKzdNSHJqSzFZeHBO?=
 =?utf-8?B?N2VtT0NaU203MGo4N0RxK201c3hEbG5qMHprNEo5UE9hTFdlS0tya1BmUkN5?=
 =?utf-8?B?U1UvMGhpQnlFZ1piWjdNWlRZNEM0MERGTjVwaEJPTzNKL25VL0UzYXZsMmZ3?=
 =?utf-8?B?TTNoOHJ3WGxyd2MrTlhYMnVQWEltYzZtR0R6bHhNS3oyelZWR3RwM0JEUnA4?=
 =?utf-8?B?WHZ1QTg5eE9mM1BGNURwakVDTW1VQjBFcWJEWm9xb1FybVREWHhBbWxaSTJw?=
 =?utf-8?B?VDljdmZJSFFTU040a21vZHZlZTJydDM3UmlvMXlYcEdnRnhrSDBiNFpQeDhi?=
 =?utf-8?B?bEoycUtyaFdYV3gzR1VwMTl6L2FHdWQrK3NhTDhOQ0hJM3c4OVIweEgvWmZW?=
 =?utf-8?B?QlM1ZUoxZ0RsSC91d2tiUEllVGptU2tuMzAxMHlkMm9wNitjckt2ZkFXU2Q4?=
 =?utf-8?B?NlUzdHh6NS9uVnVnd0IzcjdSUG5GWC9BUlNZSXlvNXl6djdyT3hlNzJWcWJL?=
 =?utf-8?B?OVdkT3FTT212cVZwNjhqMGVqQi93V0VwNWdwK1BuZmUrRy9BSnpzODFxVEp3?=
 =?utf-8?B?VHNIZHVrcEt2K3ZXTFpqQnM1WFlYbFB1OXlicHNtNHNNUFVSNGhmS1BLVHVG?=
 =?utf-8?B?YVVJWmZ0Vm1IS0E2czA1aDUyVjh1R0V2VUJObkRXZVg2TG5BZ0JzQ0ROT3Aw?=
 =?utf-8?B?NWlnVTdWTmJZS0Y2TzJlR2t4ZHVZUEtpc213WkpiT05JSURJdjl6R3c2UW9j?=
 =?utf-8?B?NDg5U0ErL2pSVXhDODVkVjVRMmxBVVBkWmtEMXB0eXJ3djhFT1VmZlZlSXY2?=
 =?utf-8?B?ckNmVFVkS2thT3htWkE5OElQMjNrMHZOU3BJdjNKY0QzeFVhMXp0eWlIMEtQ?=
 =?utf-8?B?UVFBMFRMNHNsNVpIMG9NZHZ4ZERKbm43aHRkeElxTUl5RjhKRmtaeTFRRzJO?=
 =?utf-8?B?djcyeUFMZksreEl3TWdmSVNBTjdPY2hrcHJjd1p5QTFncFlvNjVObFp0ZGVW?=
 =?utf-8?B?VE5uSWZ6RUJZN2t3bFFkSVc2R285Vk5pKzlYWkM0SlpCemFoc3BtbVEydTZ4?=
 =?utf-8?B?QWRxVm00eXpWR205ZkcwczRyeUhTYm1XT3N2dnVHNFZrRlFNWk00MHNROUZ3?=
 =?utf-8?B?czFTbHJFL0dHSzFBYUhZS3Qzb3R3QUR3RFJXbmw0WW5MbEVrNCszK2tSWVpB?=
 =?utf-8?B?Wjg2dzhzc0lwdEk3K2YrZUdHZXNTUURLd0d1d1d2ZUZaSFkrV0FiK01aWGww?=
 =?utf-8?B?K200S0xUd1lTbWZuWVpKKzBRZWJkcmk3TDJ4T0lPNG96SVpGellZYkw3dllZ?=
 =?utf-8?B?STBVRWltOUljZm5PQzlUZm12WmhOZW1qVUQxMFBqalhSOSttcXk0RU1xOGJ0?=
 =?utf-8?B?RXN2a3hmR0JuRUpVQ1F2cTVjL1o3QkFsMW9kZzFnU05vSXU2cStxaitna25x?=
 =?utf-8?B?UlVoalowVkgwTXRUNkhhTFlMaVYzQWJka09KRThQbzVIQzY4LzJSUkdLSCtE?=
 =?utf-8?B?MXJhZlRvYnZ3WDlJOEhQOTUreTA2aW5HS1ZVOVFORHhSZkdyY2ZheGU5STRa?=
 =?utf-8?B?cGY0OCtmVk9UWjBsMDVueGxlUVdPUjgyUFlyMTFSeHcxT0p0R1B5aXdxTHRR?=
 =?utf-8?Q?7Fu6TF3c+ADVF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BYdEdXa2RjU0ZXK0swV0lNelREQ09STFViSmxkalliU1lWTnZrR0RHRHdZ?=
 =?utf-8?B?dWY0KzhBQy9CeHBVeWRWa1VUQ2NyUlloak9KdUUrRmVGK05XNXpGN280WmFK?=
 =?utf-8?B?TW1BRTR3UitTL2ZIY1FieXcra2NQRTNHS2xpYTVxditPam0yd1VFZlg3UnE0?=
 =?utf-8?B?NlRDKzJLQTUwd3JqQXpBVGY1Z2FxVEcyVGZtYnl5VTB0dWd4U2EzK3VtaGtj?=
 =?utf-8?B?WjVJUi83WnhQaUgxa1gzbVNIMDRraFl5bXY3blliUGlHRXE5ZjZ6emxKdkYv?=
 =?utf-8?B?NjgwZmd3NzgwL0gzaWUvSkJwM0V0OEw1ZGhnNjJ0djg4eHZrd095dWFtMldR?=
 =?utf-8?B?NkYrRWhSa2hpblNEOXY2ZHg0a0FOUC9NTTNqcTdFdW50enFoa1JSZWpkTytw?=
 =?utf-8?B?cGdic1ZiQ250MitVazM2RTNoOW9TR3V0ODdCdW5yQkw0dzUvNklZWEIxd1N5?=
 =?utf-8?B?cENYU2xzbkZ4a2Z2ckFObzFTcW10Y3RrOWkyenBHZmVXMm9mb1R3YzJSdjFo?=
 =?utf-8?B?WFI1Wmg5eFJmTzBXRTlTQ0NFWDRwUVR6NHhvMmJaWGVSZVpNUWF3cHI1N3Nm?=
 =?utf-8?B?aHR5Ly9WdlpRV2NobXpzZVlPcUtSOThtS2dVbExQZldEVDRIODZjZTlNN0tK?=
 =?utf-8?B?NVFDaVVoYU11Q0Y5MVFWbGxMZjRwb0Rsa05JRnhCT3A1MHV2U0JhWkpkTXJa?=
 =?utf-8?B?YWRuRjZ4dUtVcTRRSmRCOE43WHZhK3dWY0VwbXJFTXI1dThaYlRIY09oeHov?=
 =?utf-8?B?ZnoydzlFL01uLzVjaWhTTjZvZHRwVWxHZ2piTmtxRE11UVdSNGliam9FSlF1?=
 =?utf-8?B?dXU2dEdUK1VQbTgyeXBvV0lrS1JiaXp0U2Y3WTQ1OUllekM3d1REdURxV1hl?=
 =?utf-8?B?QTFQeFBUR2JycUJ6cGV2dVdCM0kyOFlPVEpEaXdWN3BXL1o1VE5VUlp4ZXNR?=
 =?utf-8?B?SUF0Um5oTkMzWkxMRkpyZ1QvTVpzakJaaDE3MWJoNUFJSkxseVVNZlRBeEtE?=
 =?utf-8?B?TmphK05TRzVVd21xeU0ramNiZk5uWjdxUm9GaXI1WU04clA1a3lZaTIvRWtx?=
 =?utf-8?B?Wm0zZ1Y1UEozQjYzRStHdmZkamVGRGNuRzhpZFkrbTdxLzVEREtGbVFRWXFP?=
 =?utf-8?B?NHZLei9ZYmZ4VDBmcTlPRDZKL2N5Mm9DVmNjcVJNRENPOSs0aHJvTHV0bHRn?=
 =?utf-8?B?cFgvN0w2TWVqdTlvcHJZSmtMTjJlc3UrV2FTN3RWcUZkVW9YNnZsNElTc2Vj?=
 =?utf-8?B?SlJ2YytxM0tubXNZYXVtQXpjZHlHYWUrWjNOUXIvb3hScXRYQzJ3Yko4RzJ2?=
 =?utf-8?B?eWdNY090RTFjWFhtbUxKRG1tWk9La3VZVXdsTTRDWTVhVzhmWkNTc3dlaUMr?=
 =?utf-8?B?QS9rTEJaN2hFMFpDUEw0N2Z1MHVwWWFNWnEzV1JIRUxaaHNpSFBKanlBYWZY?=
 =?utf-8?B?QXVJSS9BeVU5bm5UcjA3eWJGNldPVFVBYWpEcUVhOEhyVTdBVHVUa0JjNTh1?=
 =?utf-8?B?bHVoWHZ6dnQzazIzcTZvK0J6VTlNZlpNL0VLaTFXcjJ5Vy9jdjhTTnc1TTVT?=
 =?utf-8?B?R0JuclFUVkRRWUZWWEh6NWJIUHJvQjU5SWFRRm04U0hUeW15SDhNR2phQ09v?=
 =?utf-8?B?a1dLN0ZJOXpqdFF4YmhDaUlNMFZmcm1tZng1WHJHaUJGd052UUtJVXZkdjdV?=
 =?utf-8?B?Vkw2dXF3cGxtL0tRQ3JoVVJISE9lUWszdHRNME5oS1BKSGpmL2pIVjFqNDNh?=
 =?utf-8?B?eENZL3JFRzl1WGt0bTZhdXFRSUlNOVJZai9DL1JKM1hzR0NnTkFhcXZ2cTVF?=
 =?utf-8?B?aXJOZFk2VXpuL2lmZHlIV2liT2VMYTA0TytRQXJXOEV0T1pwYU1HUGtFc3RW?=
 =?utf-8?B?c1ltNHVqZnV5Z1NORnJuRlgwS3lHRmRXdlk3QTUzWlByMzRWV2tnaEh2Vldw?=
 =?utf-8?B?bExYU0xLS3Vqem9lMlRvbmViSHdKNjhjL0Rackc0N29KSCtkUU5RRE1UNCtP?=
 =?utf-8?B?Z0FUMlVSelY1QVBpbm9rZnNnUi81Tkc0N1hlN2UyOWg4K1Y5c1JiRG9vdDhw?=
 =?utf-8?B?c0RrcHk1RkpUdURCTE9HVXV0eWNVYktNbm53NmlsVFgwWjRBY29tSUlaSEV0?=
 =?utf-8?Q?TrdmIxq4vA8qgWyDJwbNL2cii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544e21fa-a18a-48fa-34d5-08dd304a9634
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 01:11:46.3779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF52DClcBOTaPix9Dl1VZ8/A+ryHCZQTCpplFOEWvu23+RLVXGfuiBxLqp8ivy10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-07 22:08, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5417561D4BF4379DAFF7CF698F122@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Hi
              Philip,<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">It
              still has the deadlock, maybe the best way is trying to
              remove the delayed free pt work.<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000000&gt;] INFO: task
              kfdtest:5827 blocked for more than 122 seconds.<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000290&gt;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tainted:
              G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE K&nbsp;&nbsp; 5.10.134-17.2.al8.x86_64 #1<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000243&gt;] &quot;echo 0 &gt;
              /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
              message.<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000317&gt;]
              task:kfdtest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid: 5827 ppid:&nbsp;
              5756 flags:0x00004080<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] Call Trace:<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000006&gt;]&nbsp;
              __schedule+0x1ba/0x490<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp; ?
              usleep_range+0x90/0x90<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp;
              schedule+0x46/0xb0<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp;
              schedule_timeout+0x12a/0x140<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]&nbsp; ?
              __prepare_to_swait+0x4f/0x70<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp;
              __wait_for_common+0xb1/0x160<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000004&gt;]&nbsp;
              flush_workqueue+0x12f/0x410<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000126&gt;]&nbsp;
              svm_range_map_to_gpu+0x1b8/0x730 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000078&gt;]&nbsp;
              svm_range_validate_and_map+0x978/0xd30 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000065&gt;]&nbsp;
              svm_range_set_attr+0x55f/0xb20 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000060&gt;]&nbsp;
              kfd_ioctl+0x208/0x540 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000058&gt;]&nbsp; ?
              kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000004&gt;]&nbsp; ?
              vm_mmap_pgoff+0xf2/0x120<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp;
              __x64_sys_ioctl+0x88/0xc0<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]&nbsp;
              do_syscall_64+0x2e/0x50<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp;
              entry_SYSCALL_64_after_hwframe+0x62/0xc7<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000008&gt;] RIP:
              0033:0x7f8c472617db<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;] RSP:
              002b:00007ffd2908a688 EFLAGS: 00000246 ORIG_RAX:
              0000000000000010<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] RAX:
              ffffffffffffffda RBX: 00007ffd2908a6fc RCX:
              00007f8c472617db<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] RDX:
              00007ffd2908a6c0 RSI: 00000000c0384b20 RDI:
              0000000000000003<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000000&gt;] RBP:
              00007ffd2908a6c0 R08: 0000000000000000 R09:
              0000000000000000<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;] R10:
              00007f70f467f000 R11: 0000000000000246 R12:
              00000000c0384b20<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000000&gt;] R13:
              0000000000000003 R14: 0000000000200000 R15:
              00007ffd2908a770<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;] INFO: task
              kworker/u129:7:5942 blocked for more than 122 seconds.<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.001897&gt;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tainted:
              G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE K&nbsp;&nbsp; 5.10.134-17.2.al8.x86_64 #1<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000247&gt;] &quot;echo 0 &gt;
              /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
              message.<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000315&gt;]
              task:kworker/u129:7&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid: 5942
              ppid:&nbsp;&nbsp;&nbsp;&nbsp; 2 flags:0x00004080<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000067&gt;] Workqueue:
              amdgpu_recycle amdgpu_vm_pt_free_work [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] Call Trace:<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]&nbsp;
              __schedule+0x1ba/0x490<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp; ?
              newidle_balance+0x16a/0x3b0<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp;
              schedule+0x46/0xb0<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp;
              schedule_preempt_disabled+0xa/0x10<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp;
              __ww_mutex_lock.constprop.0+0x390/0x6e0<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000045&gt;]&nbsp;
              amdgpu_vm_pt_free_work+0x97/0x160 [amdgpu]<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]&nbsp;
              process_one_work+0x1ad/0x380<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp;
              worker_thread+0x49/0x310<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp; ?
              process_one_work+0x380/0x380<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp;
              kthread+0x118/0x140<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-indent:12.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp; ?
              __kthread_bind_mask+0x60/0x60<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Wed
              Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp;
              ret_from_fork+0x1f/0x30<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
        </div>
      </div>
    </blockquote>
    <p>Move&nbsp;<span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">
        flush_workqueue to the beginning of svm_range_validate_and_map
        should fix the deadlock, deadlock is because it is after
        svm_range_reserve_bos. Also there is no concurrent unmap mmu
        notifier callback to free pt bo as mmap read lock is taken
        outside </span><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">svm_range_validate_and_map</span>.<br>
      </span></p>
    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Ideally
        it is enough to flush work </span><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">amdgpu_vm_pt_free_work
        (not flush queue system_wq), but </span><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">svm_range_validate_and_map
          cannot get the correct vm to flush.<br>
        </span></span></p>
    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">adev-&gt;wq
        is shared by all processes and all xcp partitions, maybe better
        to add wq to KFD process info, but right now
        amdgpu_vm_update_range cannot access KFD process info.</span></p>
    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Regards,</span></p>
    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Philip<br>
      </span><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"></span></p>
    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><br>
      </span></p>
    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"></span></p>
    <blockquote type="cite" cite="mid:PH0PR12MB5417561D4BF4379DAFF7CF698F122@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
              Deng<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
              Wishes<o:p></o:p></span></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    amd-gfx
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                    <b>On Behalf Of </b>Deng, Emily<br>
                    <b>Sent:</b> Wednesday, January 8, 2025 8:34 AM<br>
                    <b>To:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Koenig, Christian
                    <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                    <b>Subject:</b> RE: [PATCH v2] drm/amdgpu: Fix the
                    looply call svm_range_restore_pages issue<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                  Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Philip.Yang@amd.com</a>&gt;
                          <br>
                          <b>Sent:</b> Tuesday, January 7, 2025 11:19 PM<br>
                          <b>To:</b> Deng, Emily &lt;<a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Emily.Deng@amd.com</a>&gt;;
                          Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Felix.Kuehling@amd.com</a>&gt;;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                          Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Philip.Yang@amd.com</a>&gt;;
                          Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;<br>
                          <b>Subject:</b> Re: [PATCH v2] drm/amdgpu: Fix
                          the looply call svm_range_restore_pages issue<o:p></o:p></span></p>
                    </div>
                  </div>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  <p><o:p>&nbsp;</o:p></p>
                  <div>
                    <p class="MsoNormal">On 2025-01-07 07:30, Deng,
                      Emily wrote:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>Hi Felix,<o:p></o:p></pre>
                    <pre>&nbsp;&nbsp;&nbsp; You are right, it is easily to hit deadlock, don't know why LOCKDEP doesn't catch this. Need to find another solution.<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>Hi Philip,<o:p></o:p></pre>
                    <pre>&nbsp;&nbsp;&nbsp;&nbsp; Do you have a solution for this delay free pt?<o:p></o:p></pre>
                  </blockquote>
                  <p>Thanks for debugging this case, I had a patch to
                    not free PTB bo when unmapping from GPU, but it will
                    waste VRAM memory. My test case also passed with the
                    tlb flush fence fix, I don't see the no-retry fault
                    generated any more.<o:p></o:p></p>
                  <p>The deadlock is probably from
                    svm_range_unmap_from_gpu -&gt;
                    flush_workqueue(adev-&gt;wq), this is from mmu
                    notifier callback, actually we only need flush
                    pt_free_work before mapping to gpu, please remove
                    the flush_workqueue in unmap from gpu. If deadlock
                    still happens, please post the backtrace.<o:p></o:p></p>
                  <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Emily]Yes,
                      you are right, will try to remove
                    </span>flush_workqueue in unmap from gpu to have a
                    try. Will send a v3.<span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
                  <p>I think you don't need add new adev-&gt;wq, use
                    default system_wq and flush_work.<o:p></o:p></p>
                  <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">[Emily]No,
                      it doesn’t allow to flush a system_wq in driver,
                      it will trigger a kernel warning, as lots of other
                      work will be put in system_wq. I have tried this.<o:p></o:p></span></p>
                  <p>Regards,<o:p></o:p></p>
                  <p>Philip<o:p></o:p></p>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>Emily Deng<o:p></o:p></pre>
                    <pre>Best Wishes<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <pre>-----Original Message-----<o:p></o:p></pre>
                      <pre>From: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>Sent: Tuesday, January 7, 2025 10:34 AM<o:p></o:p></pre>
                      <pre>To: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>; Kuehling, Felix<o:p></o:p></pre>
                      <pre><a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>; Yang, Philip<o:p></o:p></pre>
                      <pre><a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>; Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply call svm_range_restore_pages<o:p></o:p></pre>
                      <pre>issue<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>Ping....<o:p></o:p></pre>
                      <pre>How about this? Currently it is easily to reproduce the issue on our environment. We<o:p></o:p></pre>
                      <pre>need this change to fix it.<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>Emily Deng<o:p></o:p></pre>
                      <pre>Best Wishes<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <pre>-----Original Message-----<o:p></o:p></pre>
                        <pre>From: amd-gfx <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of<o:p></o:p></pre>
                        <pre>Deng, Emily<o:p></o:p></pre>
                        <pre>Sent: Monday, January 6, 2025 9:52 AM<o:p></o:p></pre>
                        <pre>To: Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;<o:p></o:p></pre>
                        <pre><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>; Yang, Philip <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>;<o:p></o:p></pre>
                        <pre>Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><o:p></o:p></pre>
                        <pre>Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply call<o:p></o:p></pre>
                        <pre>svm_range_restore_pages issue<o:p></o:p></pre>
                        <pre><o:p>&nbsp;</o:p></pre>
                        <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                        <pre><o:p>&nbsp;</o:p></pre>
                        <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                        <pre><o:p>&nbsp;</o:p></pre>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <pre>-----Original Message-----<o:p></o:p></pre>
                          <pre>From: Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><o:p></o:p></pre>
                          <pre>Sent: Saturday, January 4, 2025 7:18 AM<o:p></o:p></pre>
                          <pre>To: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;<o:p></o:p></pre>
                          <pre>Yang, Philip <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>; Koenig, Christian<o:p></o:p></pre>
                          <pre><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><o:p></o:p></pre>
                          <pre>Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call<o:p></o:p></pre>
                          <pre>svm_range_restore_pages issue<o:p></o:p></pre>
                          <pre><o:p>&nbsp;</o:p></pre>
                          <pre><o:p>&nbsp;</o:p></pre>
                          <pre>On 2025-01-02 21:26, Emily Deng wrote:<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>As the delayed free pt, the wanted freed bo has been reused which<o:p></o:p></pre>
                            <pre>will cause unexpected page fault, and then call svm_range_restore_pages.<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>Detail as below:<o:p></o:p></pre>
                            <pre>1.It wants to free the pt in follow code, but it is not freed<o:p></o:p></pre>
                            <pre>immediately and used “schedule_work(&amp;vm-&gt;pt_free_work);”.<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.276838] Call Trace:<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.276841]&nbsp; dump_stack+0x63/0xa0<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.276887]&nbsp; amdgpu_vm_pt_free_list+0xfb/0x120 [amdgpu]<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.276932]&nbsp; amdgpu_vm_update_range+0x69c/0x8e0 [amdgpu]<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.276990]&nbsp; svm_range_unmap_from_gpus+0x112/0x310 [amdgpu]<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277046]&nbsp; svm_range_cpu_invalidate_pagetables+0x725/0x780 [amdgpu]<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277050]&nbsp; ? __alloc_pages_nodemask+0x19f/0x3e0<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277051]&nbsp; mn_itree_invalidate+0x72/0xc0<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277052]&nbsp; __mmu_notifier_invalidate_range_start+0x48/0x60<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277054]&nbsp; migrate_vma_collect+0xf6/0x100<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277055]&nbsp; migrate_vma_setup+0xcf/0x120<o:p></o:p></pre>
                            <pre>[&nbsp;&nbsp; 92.277109]&nbsp; svm_migrate_ram_to_vram+0x256/0x6b0 [amdgpu]<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>2.Call svm_range_map_to_gpu-&gt;amdgpu_vm_update_range to update the<o:p></o:p></pre>
                            <pre>page table, at this time it will use the same entry bo which is the<o:p></o:p></pre>
                            <pre>want free bo in step1.<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>3.Then it executes the pt_free_work to free the bo. At this time,<o:p></o:p></pre>
                            <pre>the GPU access memory will cause page fault as pt bo has been freed.<o:p></o:p></pre>
                            <pre>And then it will call svm_range_restore_pages again.<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>How to fix?<o:p></o:p></pre>
                            <pre>Add a workqueue, and flush the workqueue each time before updating page<o:p></o:p></pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                      <pre>table.<o:p></o:p></pre>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <pre><o:p>&nbsp;</o:p></pre>
                          <pre>I think this is kind of a known issue in the GPUVM code. Philip was<o:p></o:p></pre>
                          <pre>looking at it before.<o:p></o:p></pre>
                          <pre><o:p>&nbsp;</o:p></pre>
                          <pre>Just flushing a workqueue may seem like a simple and elegant solution,<o:p></o:p></pre>
                          <pre>but I'm afraid it introduces lock dependency issues. By flushing the<o:p></o:p></pre>
                          <pre>workqueue, you're effectively creating a lock dependency of the MMU<o:p></o:p></pre>
                          <pre>notifier on any locks held inside the worker function. You now get a<o:p></o:p></pre>
                          <pre>circular lock dependency with any of those locks and memory reclaim. I<o:p></o:p></pre>
                          <pre>think LOCKDEP would be able to catch that if you compile your kernel<o:p></o:p></pre>
                          <pre>with that<o:p></o:p></pre>
                        </blockquote>
                        <pre>feature enabled.<o:p></o:p></pre>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <pre><o:p>&nbsp;</o:p></pre>
                          <pre>The proper solution is to prevent delayed freeing of page tables if<o:p></o:p></pre>
                          <pre>they happened to get reused, or prevent reuse of page tables if they<o:p></o:p></pre>
                          <pre>are flagged for<o:p></o:p></pre>
                        </blockquote>
                        <pre>delayed freeing.<o:p></o:p></pre>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <pre><o:p>&nbsp;</o:p></pre>
                          <pre>Regards,<o:p></o:p></pre>
                          <pre>&nbsp; Felix<o:p></o:p></pre>
                          <pre><o:p>&nbsp;</o:p></pre>
                        </blockquote>
                        <pre>Thanks, already enabled LOCKDEP while compiling the kernel. The delay<o:p></o:p></pre>
                        <pre>work seems for other reasons, I am not sure whether it could be deleted completely.<o:p></o:p></pre>
                        <pre><o:p>&nbsp;</o:p></pre>
                        <pre>Emily Deng<o:p></o:p></pre>
                        <pre>Best Wishes<o:p></o:p></pre>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <pre><o:p>&nbsp;</o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                            <pre>---<o:p></o:p></pre>
                            <pre>&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<o:p></o:p></pre>
                            <pre>&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +<o:p></o:p></pre>
                            <pre>&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 7 +++++--<o:p></o:p></pre>
                            <pre>&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 +++++-<o:p></o:p></pre>
                            <pre>&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 +++<o:p></o:p></pre>
                            <pre>&nbsp; 5 files changed, 15 insertions(+), 3 deletions(-)<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
                            <pre>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
                            <pre>index 93c352b08969..cbf68ad1c8d0 100644<o:p></o:p></pre>
                            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
                            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
                            <pre>@@ -1188,6 +1188,7 @@ struct amdgpu_device {<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enforce_isolation_mutex;<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_init_level *init_lvl;<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; struct workqueue_struct *wq;<o:p></o:p></pre>
                            <pre>&nbsp; };<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp; static inline uint32_t amdgpu_ip_version(const struct<o:p></o:p></pre>
                            <pre>amdgpu_device *adev, diff --git<o:p></o:p></pre>
                            <pre>a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
                            <pre>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
                            <pre>index f30548f4c3b3..5b4835bc81b3 100644<o:p></o:p></pre>
                            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
                            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<o:p></o:p></pre>
                            <pre>@@ -2069,6 +2069,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; ret = reserve_bo_and_vm(mem, avm, &amp;ctx);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))<o:p></o:p></pre>
                            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                            <pre>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                            <pre>index 9d6ffe38b48a..500d97cd9114 100644<o:p></o:p></pre>
                            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                            <pre>@@ -2607,7 +2607,7 @@ void amdgpu_vm_fini(struct amdgpu_device<o:p></o:p></pre>
                            <pre>*adev,<o:p></o:p></pre>
                          </blockquote>
                          <pre>struct amdgpu_vm *vm)<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;vm-&gt;pt_free_work);<o:p></o:p></pre>
                            <pre>-<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; cancel_work_sync(&amp;vm-&gt;pt_free_work);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_put_task_info(vm-&gt;task_info);<o:p></o:p></pre>
                            <pre>@@ -2708,6 +2708,8 @@ void amdgpu_vm_manager_init(struct<o:p></o:p></pre>
                            <pre>amdgpu_device<o:p></o:p></pre>
                          </blockquote>
                          <pre>*adev)<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp; #endif<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; xa_init_flags(&amp;adev-&gt;vm_manager.pasids, XA_FLAGS_LOCK_IRQ);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; adev-&gt;wq = alloc_workqueue(&quot;amdgpu_recycle&quot;,<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WQ_MEM_RECLAIM | WQ_HIGHPRI |<o:p></o:p></pre>
                          </blockquote>
                          <pre>WQ_UNBOUND, 16);<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp; }<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp; /**<o:p></o:p></pre>
                            <pre>@@ -2721,7 +2723,8 @@ void amdgpu_vm_manager_fini(struct<o:p></o:p></pre>
                            <pre>amdgpu_device<o:p></o:p></pre>
                          </blockquote>
                          <pre>*adev)<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp; {<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids));<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; xa_destroy(&amp;adev-&gt;vm_manager.pasids);<o:p></o:p></pre>
                            <pre>-<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; destroy_workqueue(adev-&gt;wq);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vmid_mgr_fini(adev);<o:p></o:p></pre>
                            <pre>&nbsp; }<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<o:p></o:p></pre>
                            <pre>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<o:p></o:p></pre>
                            <pre>index f78a0434a48f..1204406215ee 100644<o:p></o:p></pre>
                            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<o:p></o:p></pre>
                            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c<o:p></o:p></pre>
                            <pre>@@ -554,15 +554,19 @@ void amdgpu_vm_pt_free_work(struct work_struct<o:p></o:p></pre>
                            <pre>*work)<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; vm = container_of(work, struct amdgpu_vm, pt_free_work);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s\n&quot;, __func__);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s 1\n&quot;, __func__);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; /* flush_work in amdgpu_vm_fini ensure vm-&gt;root.bo is valid. */<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(vm-&gt;root.bo, true);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s 2\n&quot;, __func__);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next, &amp;pt_freed, vm_status)<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s 3\n&quot;, __func__);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);<o:p></o:p></pre>
                            <pre>&nbsp; }<o:p></o:p></pre>
                            <pre>@@ -589,7 +593,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device<o:p></o:p></pre>
                          </blockquote>
                          <pre>*adev,<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;params-&gt;tlb_flush_waitlist, &amp;vm-&gt;pt_freed);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);<o:p></o:p></pre>
                            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;vm-&gt;pt_free_work);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_work(adev-&gt;wq, &amp;vm-&gt;pt_free_work);<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                            <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                            <pre>index 3e2911895c74..55edf96d5a95 100644<o:p></o:p></pre>
                            <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                            <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                            <pre>@@ -1314,6 +1314,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device<o:p></o:p></pre>
                          </blockquote>
                          <pre>*adev, struct amdgpu_vm *vm,<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; uint64_t init_pte_value = 0;<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start, last);<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);<o:p></o:p></pre>
                            <pre><o:p>&nbsp;</o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_update_range(adev, vm, false, true, true,<o:p></o:p></pre>
                            <pre>false, NULL,<o:p></o:p></pre>
                          </blockquote>
                          <pre>start,<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last, init_pte_value, 0, 0, NULL,<o:p></o:p></pre>
                            <pre>NULL, @@ -1422,6<o:p></o:p></pre>
                          </blockquote>
                          <pre>+1423,8<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>@@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct<o:p></o:p></pre>
                            <pre>svm_range<o:p></o:p></pre>
                          </blockquote>
                          <pre>*prange,<o:p></o:p></pre>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * different memory partition based on fpfn/lpfn, we should use<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * same vm_manager.vram_base_offset regardless memory partition.<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
                            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);<o:p></o:p></pre>
                            <pre>+<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, last_start, prange-&gt;start + i,<o:p></o:p></pre>
                            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags,<o:p></o:p></pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                    <pre><o:p>&nbsp;</o:p></pre>
                  </blockquote>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>
