Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF2DC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 14:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8170310E0AB;
	Tue, 28 Jan 2025 14:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbFA+z7E";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF81810E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 14:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxUKvangHScCTQAF5H53zLeC7WtA5OlR3yJyYEOyNzsyOjZnxFgpGv93RJlsjq8aIL989Rs9ZjbL7zySVt+tDChitMQRMF0nitvIKZezjrD/WrAdM1NwLPJ/zr/mtmvxN+bVxjw5U41vxnheiJ8rOqUimIa1Ypcpdxf+Lun+AJsrPob4p1ltVlgSONqlBgwj+faNLyu6WMOHDA9omUWeuVcwVVav4KnOLtuChmQfg60dTXPKt1BjreS5y3b2S6w+ARNaMClfbT8QFZ/uxOEgejFfroPyHWjWqG4xHNe/3eJi3DaeTIy86NFyuD1oszHl3q2mnZh4uoyoQSMcW8aZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93tkgfC4iKO6e0IOmFbAbxXPOHGrcDUqNBWMkrsFbOw=;
 b=JInNOVVliQ+xy4gQMkIZleg3Wnx0KUQrxaxtpO7PIUSiA847R3pS9sTN9oNaPgOrrFd11dd9HdbqafSOCqN9VymSC+EKY9pvIcZerrQUcBJ3dJCrnKePWncJAZj4Eg+mG4fuUuVjVmZahdrsV8sQE5xlhwFKyrQw4Ar70XnwvaugTMJ+CZoHcYJWUjIlFuOIHS3yya4d8776LlgBvIcv2eTC0E7hcAvJC/wkTUXCmv7lvTVBe6EdjZ+5fjOIGxrfzRJzp2jQ+q7IuQWP96HpcIM5NRVKruJD69iTk5Rh+V3ITH6TWp/4as67uMgSHvV7Nea2/0ANsd/Yf8XP3ozWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93tkgfC4iKO6e0IOmFbAbxXPOHGrcDUqNBWMkrsFbOw=;
 b=QbFA+z7EUZ6ibkdv8Gtx2EaiT87rqeQqRmweYX7cZ2et+dR9ArnUtiZJBNflLDO1PXkE3KsVijEYtdz/TklmDbRaDlJ0q/6r573HJizFRMQQKGsc1j0qv43/11bNOM+9PZNoTyeTdLHxzxeE6PhSO3n2HQ6U+U+hvH5BxRcrU+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 14:52:36 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Tue, 28 Jan 2025
 14:52:36 +0000
Message-ID: <6aa7b882-0924-4899-a7a0-71fd53ff9f40@amd.com>
Date: Tue, 28 Jan 2025 20:22:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
 <16793f54-a7b8-4e45-b899-fb177b39f8f7@amd.com>
 <9b7392c7-6085-4c99-93b4-2bfac8b332ce@amd.com>
 <174adca3-3b0f-4174-bf71-a57598db912f@amd.com>
 <803921d9-c743-4c13-bff7-06df704f300f@amd.com>
Content-Language: en-US
In-Reply-To: <803921d9-c743-4c13-bff7-06df704f300f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc69680-4197-41af-15cb-08dd3fab6733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzYzU0I1WjlzaFd5TktpSXRLMlk3OS9oMFdNK2tvbHNxZzBuT3N5ekd2Nm9T?=
 =?utf-8?B?d29jbkpZSVNGakc1eGtveGxwNUo5ZUhtcjQrZ3FYb1hpK0phMTlwNUNHSVU3?=
 =?utf-8?B?eXY2OFN0YXlsS0ZxWkwrVGV3V0s4UjRRL2sxN0YxbjloTlBPeEhiSkFvTXRM?=
 =?utf-8?B?NWZIamd1dzJzeDFuZGc0cUNoc1ZqRzdDWGZkenVpT1c3NkNZRUoxQjZhaDQz?=
 =?utf-8?B?dmNPcWQyQ3JwQXRUUUxITFgxNHlkUmxwRXRTSnRtSkZlelBLYnhaSGpoV2dC?=
 =?utf-8?B?V2twT2lTcGhhVVBMT24zc01TdHZ2OXUyVXRraTZzeWpxakN6RnVIV2VlUXhC?=
 =?utf-8?B?eUxqMDFDMUVHWkMwVEZFNzBMTVZOQzR6NnZGSlFTTTJjbFVBSzlKL0Q0Y3BB?=
 =?utf-8?B?cENld3ZYcUQyT1Z0aVZTaDRLRnlNVEhGaTF3cm9QOFBCTHZaMHZxdUxrV0pR?=
 =?utf-8?B?QTQwT2JsTFB3SkJaeEVHTFlTMDRsVEpodk8yTFBHb2JzZlpKZEF2dU52S3ZZ?=
 =?utf-8?B?ME16YWx2cWVPSFVoRzRrZlpqSTlPdzRvd2pJMXVHbXRqK05JNW51MXpCdGVq?=
 =?utf-8?B?UU5XdHgrakhoOHZ1b2RUYjNJZUlIVlA4Z2JWaXdPNXd3eFFFWDVtbENjUGNk?=
 =?utf-8?B?SFBDQmNJNk1jakU5bUd3RG81TTNlbnJLWi9JVnFSTUc4cWt1cmUvaDZIb0Rs?=
 =?utf-8?B?SGV5ZE5ZTzMweXNPNzVBTlM0YlR4M2xiNnZzb2tQb0Z5cktkcGRLOWRNTm01?=
 =?utf-8?B?YnRxZHREL20zRDZuTnJWVytuMTRiSnB4eFJ3UHp2NVpuTTZSY25iZkhsYWRq?=
 =?utf-8?B?VWVNMitIeE9xbVBDdTZCK2ZjUmNhWjZ4alNqcm9iSDVkQlczRmwwZ3lZR3Uw?=
 =?utf-8?B?K2NYaS85YUJHNTVMREVEZEFEQ0R6RUFYZ1djc0Fzb2hNOG9ES2NnV2RURjk5?=
 =?utf-8?B?cVJ0WjhtTllabDljS0Q0bjFIYi9rTmlnYXcycm9NOVZYOHJPVlVOWEF3ZU4r?=
 =?utf-8?B?TzBsZzhybHRieTJ3M2t4MEQ4Nlc1N3pTK2lIY0ppaFEwTTdPdm9KU3cvTis5?=
 =?utf-8?B?eHZvUDMyWWpaNEVQMDEwNFU0UjErK3hqdWllcXNWaVI3R21ta3h2aC9qcFNU?=
 =?utf-8?B?eUN6dlFsMTI1VStKeEFrNjhMTkhDVEgxOGs0UGdnY0JIaU9pcURXeU10WFZ6?=
 =?utf-8?B?Z3ZLZjRBT2JYYWJsZXIvYTdDM0UreG5jTVBxUjBTNisweWRCbGlxY0tjNEFa?=
 =?utf-8?B?WFFTSWxvRTY5RFBUVGp0RjJ6M0VGc0hJQ244SU5Vd0FBa2d1VVIwbDBvNndv?=
 =?utf-8?B?SzUyRnlGRExvN3lZQ0hubzFZbDIybTZlUjk1M3RJeFBCZ0x0QUd5N3d6ckk2?=
 =?utf-8?B?ZjNiSnQ3bWZLdHh0emVlazR6ZXdyQzBjUzRuWm9zSDJBWVFPK3AxVzNHTXVR?=
 =?utf-8?B?MGJsdlZJWFdaMkhwTTVwbVpCS1Q1dm5LWENCTlZzNlc2eGVPbVdMakJIMXA4?=
 =?utf-8?B?UDFkOFphYVBKSU93U2V4TUNZVktLK2dITnlNem5YMER0RXVnV1pWTHZqMmtq?=
 =?utf-8?B?Ull3cUlwRnJpOU44WjJiWWN1VUxnL1FwdUREU1BZTStQTG1NVTVORzF2K01a?=
 =?utf-8?B?d1hUMWVlbkJleTNLZWw3Wit0VENEYTZGeTUyazhxYmVUMklDWHlsMDVNSXNI?=
 =?utf-8?B?Ujg5Q3NFNW9URjB1RVZ6ZW5WdjVWV0RQYTl6M1VlendoMXJ2c2NNWW9MWm04?=
 =?utf-8?B?cmRTaForZC9rY2dWYzdQc3grOGxPODNmZnJzbnk0ZDJWNm80WHFXSFQ1YXNY?=
 =?utf-8?B?TTNVdWJlQ2xob1I5SXJIS1JSbnB6RjArMU5SRWg4YkN3VlN0OTEvdGZkQW81?=
 =?utf-8?Q?RZnWfpC7PtT3p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDR0cUJzRk9sYVlwU2lTSUVjUDNMR2xBTEd6YVh1eHVYWnY3RWtJWWUyYkh0?=
 =?utf-8?B?UnpKQ0cybEtFZVN5ckJLeW9tVDR1NmJxWGs5Nzh0dWVQZ2JWTDNDeFVmZXBo?=
 =?utf-8?B?bzY1WVFZb1VGVm5zclJVMFZrN3R1aGpJa0xOY044Y09vOC8raXVSNWh1Rldn?=
 =?utf-8?B?MlFVZEpXYmRTZWQvM1FtcVV2bGl2T1huM0xpazFCUFVHM3dHNUR4dTI1Zytx?=
 =?utf-8?B?Z0h6L0YwTlpYY1lIdnA1eDJMN09tTHY0NCtoYUpINGdCQUxqdEI5TFZiekp3?=
 =?utf-8?B?S0dmcWcySXArMEdhNTlnbmZHV1R5WGNJK0o0REVKZGdVMWpHZ09KVjNQcERP?=
 =?utf-8?B?bWtFTHdKRkNBNXZIc0pXN2svejdpbWlBazl3V3MvcWNzeEw0aGp5V09YWW5m?=
 =?utf-8?B?UHc0NHRQREhvdUdibWIvUk5WdnJabEVCVG9TMHRsWWtqR25vK1laTlhBNXZj?=
 =?utf-8?B?c3ZFdVZVdlF4Z1NNcnpFRC9RYlNKL01EcnhWUnhzMkNvNHFOYUE2S2s4a09K?=
 =?utf-8?B?UkFUVUNGUTJaTzJvVVNlSkNpSWUzYTN4NzZzaWFOZHI2Ti9BZjl3TzNBc0I4?=
 =?utf-8?B?aUNyanhmNlhncEx6eVk5SUx0U3RvK1FyK3RUS3F5dzlKV1ZJTlFETmhXSUpU?=
 =?utf-8?B?dENydGdNeE0zckFGZklkeFdlN2pKN1E5NlNkU2ZoYUNvd0s1TjZCaEJDNk1V?=
 =?utf-8?B?eTRKVjJoKy9FUC9OUWp5NjFQR1dWaGxPUkZNTi9Jb25ITkxEbUdmTHNuNTdY?=
 =?utf-8?B?T2Y3ZEY0U094Z1JNUXEwTzAxVU9kM29QN21uMlNUTWZsT29GMzNIV1UxWlBx?=
 =?utf-8?B?a2xIN2xiRjR4K1FsS3c3SFhMWG8vNEVGNnArb2xDVDl2SEhaY2xKN0hnVkhp?=
 =?utf-8?B?dnNGVi8zVjc2aDY2dkR1NFFMNGpibWJIcmlCS2xPMXZZdmVIcE9IeGR2bU1K?=
 =?utf-8?B?d25kalVLMFBrRXVtRmlSbkFsVjBFOW51Mk42bE01VnMrTUxXY3JpWFdBVVAr?=
 =?utf-8?B?VEdJSlZnakRVTnhtcHN5VDRlclhJL1VVbmo4ejNmR0dPTjRTNnpmSDlteUR2?=
 =?utf-8?B?OFhqRWhyMFdjRk0wV0hlNGJRRm9zdm9wMmhad3F3blZNajZ6QXpSOWJGbDJk?=
 =?utf-8?B?d0ZmaDYvaDBhSks1eW45eXdxUWFXd1BJbEIwaUNuZU1OMmkzMWRndlJwVkdZ?=
 =?utf-8?B?cldhTWw0R0JFcU5rVitTOFc5cDBMME5Bd1YxRkZVSHV5ZndZdEVUeGVYcndO?=
 =?utf-8?B?NmNCS2pQUDFwWHNMMUwyU3FxVVNXcWd2blFlSXJRaTNEajhGLytOMTVGbWdG?=
 =?utf-8?B?a3hETzIwTGQ5VVZBbHVtS1d5QTh1Z1FCTWdVSlRmTzE4dG05Zm9rQnM3anRL?=
 =?utf-8?B?SytOYnlBNmlqRXByWGUyaUhncnM0YW9mK0FjaGJ3RmVTaVdpczQrd09jazZw?=
 =?utf-8?B?WUtGeERSNGRyVDFzWHVnellyQndmR3E0Z2lVdkV3U3Q0VWZNRU5rWnM4OFpy?=
 =?utf-8?B?Z0JTdzlTTENJTDRYSzc4Q095NHR6ZGNOU0xLRXROcVZ5d00wTWhwNlY5eURK?=
 =?utf-8?B?azZZWFVjZXJNSWRHR3BRRGNrMlhJRUlIVTR3OFJEeGE0Y3lLdU03Tk9vdmxv?=
 =?utf-8?B?M2ZmSTJSUDJCbWllcGZwRzF6WlQwTzNiMC9JUlR3T0x4V3lIajlmWU9DNmZX?=
 =?utf-8?B?dTZuSE5TRmVCRFh1TlMxRjQxRkRPZ2hJYTJmTDhQL2VGSEZQd1F1cnptUDlo?=
 =?utf-8?B?YUJoZ2l1czFBd0gveDJESG90blhIVnNtUmdCdllOdllydjgxVWhaWXZBVytp?=
 =?utf-8?B?SndTNVlUN0tKcU0vd0I0WkxGRzhKQnd5WnIvNEVaV2FzS29lWURTRFVtaUNr?=
 =?utf-8?B?RWcxd09GNTI0ay9VV0U1Nk5YVUlIRTAzcHF4M28wVmhuQUhIWTZ3THNUbmFo?=
 =?utf-8?B?VFdvcjFYaUVISWF5U05WclhHUVJKVWRJY1FQZDREYkJHTjFpTjdXU0VsY1E5?=
 =?utf-8?B?Ny82ZTRWNnBnRlhMNTc5QUM2YVpIZHl3VFZDQWxuWWNKeHBPUUNlZk45NXFh?=
 =?utf-8?B?cEJ0bmNlL3JXZm80NnMwNWhpbEsrcGY5dXF2V3MyNDVlU2NqbWxSbTNGUGcw?=
 =?utf-8?Q?d0cKdUJ6RGEAFdDlwmYBHE+kw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc69680-4197-41af-15cb-08dd3fab6733
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 14:52:36.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tbjQsZQ8b4oicEItOzwGNKMfzrm+NR0guSvgiNAwNEu2oIM1Rxhc4myrtI1/lEeyh9GViI9mx/1Sf2DA7UUiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
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




On 1/28/2025 7:55 PM, Sundararaju, Sathishkumar wrote:
>
>
>
> On 1/28/2025 5:29 PM, Lazar, Lijo wrote:
>>
>> On 1/28/2025 5:06 PM, Sundararaju, Sathishkumar wrote:
>>> Hi Lijo,
>>>
>>>
>>> On 1/28/2025 3:04 PM, Lazar, Lijo wrote:
>>>> On 1/28/2025 2:39 PM, Sathishkumar S wrote:
>>>>> Add devcoredump helper functions that can be reused for all jpeg
>>>>> versions.
>>>>>
>>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 59 
>>>>> ++++++++++++++++++++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  7 +++
>>>>>    2 files changed, 66 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> index b6d2eb049f54..70f1e0e88f4b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>> @@ -452,3 +452,62 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct
>>>>> amdgpu_device *adev)
>>>>>                device_remove_file(adev->dev, 
>>>>> &dev_attr_jpeg_reset_mask);
>>>>>        }
>>>>>    }
>>>>> +
>>>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>>>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32
>>>>> reg_count)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>>> +    u32 inst_off, inst_id, is_powered;
>>>>> +    int i, j;
>>>>> +
>>>>> +    if (!adev->jpeg.ip_dump)
>>>>> +        return;
>>>>> +
>>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>>>> +        if (adev->jpeg.harvest_config & (1 << i))
>>>>> +            continue;
>>>>> +
>>>>> +        inst_id = GET_INST(JPEG, i);
>>>>> +        inst_off = i * reg_count;
>>>>> +        /* check power status from UVD_JPEG_POWER_STATUS */
>>>>> +        adev->jpeg.ip_dump[inst_off] =
>>>>> RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[0],
>>>>> +                                          inst_id));
>>>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>>>> +
>>>>> +        if (is_powered)
>>>>> +            for (j = 1; j < reg_count; j++)
>>>>> +                adev->jpeg.ip_dump[inst_off + j] =
>>>>> + RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[j],
>>>>> +                                       inst_id));
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>>>> struct drm_printer *p,
>>>>> +                const struct amdgpu_hwip_reg_entry *reg, u32 
>>>>> reg_count)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>>> +    u32 inst_off, is_powered;
>>>>> +    int i, j;
>>>>> +
>>>>> +    if (!adev->jpeg.ip_dump)
>>>>> +        return;
>>>>> +
>>>>> +    drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>>>> +        if (adev->jpeg.harvest_config & (1 << i)) {
>>>>> +            drm_printf(p, "\nHarvested Instance:JPEG%d Skipping
>>>>> dump\n", i);
>>>>> +            continue;
>>>>> +        }
>>>>> +
>>>>> +        inst_off = i * reg_count;
>>>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>>>> +
>>>>> +        if (is_powered) {
>>>>> +            drm_printf(p, "Active Instance:JPEG%d\n", i);
>>>>> +            for (j = 0; j < reg_count; j++)
>>>>> +                drm_printf(p, "%-50s \t 0x%08x\n", reg[j].reg_name,
>>>>> +                       adev->jpeg.ip_dump[inst_off + j]);
>>>>> +        } else
>>>>> +            drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>>>>> +    }
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_jpeg.h
>>>>> index eb2096dcf1a6..1d334f35d8a8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>>>> @@ -92,6 +92,8 @@
>>>>> *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;    \
>>>>>        } while (0)
>>>>>    +struct amdgpu_hwip_reg_entry;
>>>>> +
>>>>>    enum amdgpu_jpeg_caps {
>>>>>        AMDGPU_JPEG_RRMT_ENABLED,
>>>>>    };
>>>>> @@ -137,6 +139,7 @@ struct amdgpu_jpeg {
>>>>>        bool    indirect_sram;
>>>>>        uint32_t supported_reset;
>>>>>        uint32_t caps;
>>>>> +    u32 *ip_dump;
>>>> It's better to keep this at per jpeg instance level 
>>>> (amdgpu_jpeg_inst).
>>>> If the hang happens for a single jpeg ring, that will help rather than
>>>> dumping out reg settings for all instances.
>>> The devcoredump infra in amdgpu does not propagate the job itself or 
>>> the
>>> hung instance, so there is no feasible way of doing this, meaning
>>> dumping only the affected instance.
>>> And if every instance is represented by an ip_block then I can 
>>> implement
>>> this with a flag to handle per instance case, but I doubt it is, as 
>>> seen
>>> from the below commit
>>> fba4761ca00f drm/amdgpu: partially revert VCN IP block instancing 
>>> support
>>>
>> Even if the API in its current form doesn't support per instance dump,
>> suggest to keept the reg_dump data struct in jpeg_instance. That way it
>> doesn't need any calculation to find the right offset etc.
>>
>> On the other hand, a single copy may be maintained for the reg address
>> list if that is feasible. As I see the address calculation is dynamic
>> based on the instance id and it may not make sense to keep it in all
>> instances.
> I am aligned with you on maintaining a single copy of the reg_list, 
> and so, yes address calculation is dynamic
> based on the the instance id as you pointed out, in that case 
> maintaining this inside an instance tracking structure
> doesn't feel right, as multiple instances track the same reg_list 
> pointer which is the same list for all instances given an IP version.
>
> The request I am proposing is to maintain the reg_list inside 
> adev->jpeg, a common list of registers for any instance in the ip, and
> all the ip_blocks of type JPEG refer to this common list when separate 
> instances are represented by discrete ip_blocks, and dump per instance
> register list in the future when that is planned and enabled.
>
> Regards,
> Sathish

If I think through again, it seems to me as well that the reg_list is 
meant to be stored here considering it's relevance to ip_block.
I will rework the patch with your suggestion. Thank you.

Regards,
Sathish
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Sathish
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>    };
>>>>>      int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>>>>> @@ -161,5 +164,9 @@ int amdgpu_jpeg_psp_update_sram(struct
>>>>> amdgpu_device *adev, int inst_idx,
>>>>>    void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device 
>>>>> *adev);
>>>>>    int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>>>>    void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device 
>>>>> *adev);
>>>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>>>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32
>>>>> reg_count);
>>>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>>>> struct drm_printer *p,
>>>>> +                const struct amdgpu_hwip_reg_entry *reg, u32
>>>>> reg_count);
>>>>>      #endif /*__AMDGPU_JPEG_H__*/
>

