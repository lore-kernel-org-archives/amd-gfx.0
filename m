Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EDDCA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 07:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F071410E893;
	Thu, 21 Aug 2025 07:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuZvkLtc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4440010E893
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 07:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ0Wfn81rQwLM4+eTMR8aJT1oTk0Q1DNLCFW6Yel06IAPMCnC/FrEi4fzqRCZ43lQDNqqX10CYTS+4sLlvQEKK0obYmy+PguSiiGkqI0ohDIsJSjDTNuUiEmjMZGTfMZ2pynkIn9PBnZFhWBJbm6XfJLVCpl/0lKqo3/f/6oECHluLsxshSrQ94IHcPOw3kIbNhzaDFw9oNORUV+UZqNyMovC1oZeFG+bUhJdC+snuhQJHUq2up5P+spDBwAIH1NL5jDSwpEQ5XpGGdHRAcK2bAdTx0GQP4zAo3Sc/wlqHCOXwL1Ok4tEUCS69HS5f+pqZ2TLTqPXLoLnqD0yOJu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU6R/21mB1EQZfwcMgqN06eDKYCAgQq1A3xMwlpaH04=;
 b=viz+BbQGVflU6zVwUXVlD8UMo9JugXJhLaGaP9XvDn2Gz6u+WLvkdU01N4EMHoPT/5XFcZQ6NhLBNKnrkji35/BEYyKDzluePIbd+KFGKpW5PRLL09IEJdv0O7ivbhiXkZfv7Q4kRrjJgi1I2JjrLx/fiB9Pa6/PTV5lmj8aDyowC9kkwd3ZN/DWQObMbPReuF/7A/+iMzuQb4romFXm7vuVGIdgb3izIiePyVBoVIoIJ8J3wS0NwFxlFs4EpP1f2lhhFzCtJjR5SmtNoNizAGOspGNY8PLAgyP+WaJXslGM4DNLuPflr9R+HNys3+p9iOugndvP01p7QQvnVGgDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU6R/21mB1EQZfwcMgqN06eDKYCAgQq1A3xMwlpaH04=;
 b=FuZvkLtc6SvVTiS23pHh8Jis7fXexJzeChyLVoUdoY5mVzECO5N0vyN+MFtMTaocBlISTvZCWRvpFwDdrht05AOwj4glPaW9Kvf5TNgIt/n/SWEXMnDy0qfHAtq7d6Pgs9vxEraVdNuF2MEsd2FThgCqs/B3fHgg6/KmHG8ORsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 07:35:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 07:35:08 +0000
Message-ID: <dd84e53c-606a-4522-a63b-e0c9b9f7b041@amd.com>
Date: Thu, 21 Aug 2025 09:35:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
 <BL1PR12MB5144B533CFA6A83FC47B1A8CF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB5144B533CFA6A83FC47B1A8CF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ed2766-aaa7-4878-4027-08dde0854125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnZUMUdUcjNxSjJRU3VUdkFtQmVJSHd6Vy81VzlVRU0xN0RSRW5UWmEvWmZ4?=
 =?utf-8?B?OTBFWnR5WU96d0lBcVk0ekd3WTBybHdQNHk5NWNDc3FNY1l1NlFXZlY5MlJX?=
 =?utf-8?B?ZTZIZUJsVE1UL3NVSkRIRmFrRE5NdXVzR3N6dnIweVY1UWpsWmZiM3hSakhM?=
 =?utf-8?B?eVB1cmZrUnhyRStnaXhmRitOTjgxQWdMVElQaDYxTm5rbUduZmJxMFZ6cTND?=
 =?utf-8?B?R0d2c1dPOEUvYUJ0YkxZZXUrdllKTTg0cE54T3o1ZjJMTjJ3aUhLZFAxT2Rq?=
 =?utf-8?B?b01leDBYRjAxZk1wbTkvWXRxVGpEeVBkS3I0WWw2VlF2dDY2L2ZNUm92N2pM?=
 =?utf-8?B?dFpJV1JKTzByZ2IwVEpnUFVJK0R1MDBVN0phZFNRc1diaFlUUEd3MTAvbm9P?=
 =?utf-8?B?bHArNUkwdTliNnpCRVhjMXpLQXR5TUZYRDRHYzU0Q3FlODdsL3R5WC8wR2VY?=
 =?utf-8?B?TDFCcmhsU1o4S1Y5VTBoQ3krTGZyNGFGcHhRbnJlSTc2ckZpc1lLcXdLRW85?=
 =?utf-8?B?YWlDV1dERFdCejhSSTVaVDhrMFZ5c2ZvUVJGZ05KSVlhcTAra2F3dlo2aWl1?=
 =?utf-8?B?SlROc1haanp6c0xXMVFCcTY5bHdjNzNNenZZWHpDeFMzMERvYUVmYllQNHVI?=
 =?utf-8?B?SkxWZW5QR2hLaUlPZ1lnenRIekdHdGxoTlVyQlpYRjdlQjkyTEZrVjJSbG54?=
 =?utf-8?B?b0JUK283TDhjM1hSamZUUEdnbXB2UklRMHpEQWdCek44WjBIRlNKbTlWdllZ?=
 =?utf-8?B?REtRRUhvc3Y3Mmk2aklyUm9Nc2pWZHBWaEkzT3lzU28vVjAwWWpZbEMzNE1F?=
 =?utf-8?B?RFdQV1pEZjk4OWhHUnliaTFSd0xMR0VDZmc2eGJRcXRtSHBqamE1OURuUVQ2?=
 =?utf-8?B?b3E5MFowWXc1YVpRRGV1bVRTZDdsQ0RSelNKWjNSc2c1UHdTL0FrYnd1dUZT?=
 =?utf-8?B?Qk95Q0tpd0pVdCtVS1pxUjMzd1h5Z0YxRGkrWTNzZVdGUXdDQUFzelhDaUkw?=
 =?utf-8?B?QXNGV2ZwMWtTdit5VWhXTURFaUx2YlYxcVo0TmgraExNZEY5NWpiSVJaTGlU?=
 =?utf-8?B?blAyVnFwRUo1SUZxNVZmOS9DczdNQTVDK0pVSUZCS3Npd2lLZThJNGRxWHFX?=
 =?utf-8?B?NjNvRlB6THNnVnczRnk0VkpacWQwQVNYMDVPTnZqaW1uSytBYjlPRTVwZFh6?=
 =?utf-8?B?elJkV29BUkVRMmpMZzR3aDg4cDBWWXFQMmRXQXBOY1lwNnpuRDdCMDQyUHJh?=
 =?utf-8?B?Y3B1Sm9tdXNDYTZoNS9zcFNxa3FEbzlXVmNMZm1FK2FLUnljK1pVQlRtZ2JP?=
 =?utf-8?B?OTJneEhiV2l3TkVSYXRHbU81NjlFWUxDK3hrQjAyVkt1OCs4c05HcmgyTE9P?=
 =?utf-8?B?Mzd0amRFakM2TlpEZVVNbGthN0ZyVFhqVDdneXhYSUUwbHdLMlNIYk5vOWU5?=
 =?utf-8?B?RHBsME4reFRCT0VsWGk2cEpKTzlrQmEvNkpwbXAxWkZwaFJ1VUVFeEV4NHV2?=
 =?utf-8?B?QjhqUTZjWllERk4xR1ZMQXNnc0tQSFBMeGhCdENNcE1rNzJXWmxoVGNyNjlO?=
 =?utf-8?B?MVNYOWhrU094T3o2ak5mS3FXMGZjN09hSkpOMUJLUmxMcDZSbnppV05RMUU4?=
 =?utf-8?B?eTQvdE9MYzkrRGpjOVU0OW1lRmtyTjQ5b1liamdQakVLRE8vSGpCMTdvY0pH?=
 =?utf-8?B?QmRkdnYvWUtPYXF5cFhWTXVPeW85b3JmQk1maTFZaU44T0Nnd1htcWRCUGdU?=
 =?utf-8?B?Mm9KUXIzQnlCcHBtVk00TkRxWnBha2dZbm1uRWY2RDRhU0N0bXRZQUZ5LzZC?=
 =?utf-8?B?eS9KOERtOGpMMnpXeC8zL1oxeFovb3JhZGE0Vng3MUxaajlJTmxERE9IaERx?=
 =?utf-8?B?aktvaXhnNWRLVmVoMDloaGxTUFAyZGZwZzFuUjljY0pudldhWk5TMkptK3o3?=
 =?utf-8?Q?ud2QultWrRA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhJcDY2M2RRVGtKai9TeGZFMVl5V0hXY0VZZ1h2RWNoVE9FWld4bEVud2tK?=
 =?utf-8?B?WERodXlGT1BzMHJyVkk5bUlVb2pUZ0pMY01TR1FnRTJGZU03bW1sKzEwM1Zy?=
 =?utf-8?B?SXhmVGNWeTRLUHhvcnE0NmUyZlB4OEd2K003Y1hyVUF1TlUyaFc1bWxDUlh5?=
 =?utf-8?B?QnBVMWU2dnVHUnFkMitlUll2ZDRMb1JRYzBsRTBUZlVwRjA2b1BpQ3JuNk1K?=
 =?utf-8?B?NlVSOVV2Y3IzbGQwbEM2R2pxQmMvL1plVUJYMEV3UTU3VzdMYUcrWmRUbXR0?=
 =?utf-8?B?dzFMWXBLN0lMTXg3bVd0cmlRTVlxQU80NFlWaExON1FSc25HUjk2VGdMUkM3?=
 =?utf-8?B?bytKM3hFeHgrQ1kyRVJmaHJvVnIxZTFHOGJtODdFbFJPSVhPWDh6Mzhybjg3?=
 =?utf-8?B?QnRCMGdFWEVoU241dzJIWnJ6ekVtNHJGck5Vc1JlVjZ3YkxOeXJOc3lVem1E?=
 =?utf-8?B?cXN2cCtlYnBNck05eEFHQXh5a1kyQjJiM0d0VTUxYmpBRGVya29xL2RDRGV0?=
 =?utf-8?B?MGEydXhTcTdKb0srRWxCSmI1NWR5eCtlS2hDSHpMcWNzMTV3K0FNMkVEeVYx?=
 =?utf-8?B?UE90czhBbmVuNHRDNnlVQXpOL0RIWWtzeVlQVFF1Rjh2UVFRWHJ0ZTJlT2xk?=
 =?utf-8?B?K3pXOXd1Z0tUSUpIU3RvMDdxM0pUM3hyRGF6Wk8rSEErelRJbi9iQ0xmanZ0?=
 =?utf-8?B?WmtPYTFiS1JjQW1aRmI5M1JEN05CeGhvdjZCcFZlWnpOcU5VOXFVckIrUC9G?=
 =?utf-8?B?dXFoT2U5dHltVG9TYUV0OFRnZmM2UjUyZzJUb1hBV3BxTUY4THUrOExNTVJF?=
 =?utf-8?B?TUNWVTlPR3NLTUptQXJDZ1FkNDhBdDdiRW02dVEzV2lXNE1lMFdheDVId3Iv?=
 =?utf-8?B?T3Q4UFVDWlEyM2Ztc20vZ0xXMlM2VlIzODBuazVMMTVQOGhESEJIY05qL1po?=
 =?utf-8?B?dEQrMlJkVEFGOGZtbHdTSVpZalFZSVI1c0Vod05MZDc3Tkd2K0xsdDF1Z3ZB?=
 =?utf-8?B?VjZxWXJKamlDUndlR1kwamcrd3J5L2lKbi82N1B0clBnMVlGaGdndHV2NGRO?=
 =?utf-8?B?aUdpMDN4aXRvZVRZMmN3UlJQbWo5eFZmd2JHUlpiWjZiQlh4RXhkdlozZG5v?=
 =?utf-8?B?QWFOVm52VGVyczVGRVJGbkxJTTJqTDVqOSt6NkdBZXRRWkZGWGFMK3NkaEpT?=
 =?utf-8?B?bFBuQVF2cEQ3N2pNWVFxZ0EyRUhSaTk2QkgyeTlkWDZlc242OVIwOGdza3lI?=
 =?utf-8?B?S3VRL2VyRDI1RjNvL0dJM1VZMlozWm4yME9DM1dzMUNRS09QYXNDQ2N4a0pz?=
 =?utf-8?B?cEV2QThPM1FOWmswQ0dzWlZCbkVyc1d5WHFoSkZJeWZKN3JURjl5cTNvK0dU?=
 =?utf-8?B?djNrNjlZYUxFVjg3L1N4MnBXVS94MmRMMlhDdmU5S2lRRHF0aUx1MEtobGZW?=
 =?utf-8?B?YWxWQ1pZYThVcHNUYUI3cUpTS2hOZXc0OFBoZmc5Q0pXMk50b3VwenAxSXNq?=
 =?utf-8?B?K1lrMmlJSG8vSVQ3YXVpK2sxNVA0THAyUmFWYzZsalZWNkNMSFI4aGNYUExr?=
 =?utf-8?B?WFFHZ1I1aWxYcGxXWHdpQm13bUpHbkhXWU1meHkrYkZpYnVNQk9nVk11Qkt4?=
 =?utf-8?B?LzJsSEZINkNuQlhURWM5SEo5Smp5U2dlRFVwU0EwVWZCQXZUd2tsTGxQUGhB?=
 =?utf-8?B?eWpZMlZFUHRnRlFhcnQ2d1hnSGhhSUdHN0lmeThIT2pjY3dvaDRtMy9XU0wv?=
 =?utf-8?B?cjlybFprSHh5cGhkRnkwR1dtZzVyRmR3UUlFWUdveng0ejMwS0k1M2dqOWcr?=
 =?utf-8?B?WEV6YitvMkl3NjdDcXIzMHI2QkNSaTlVb2l1ang0S2ZEeEthVDFiYjMvMERw?=
 =?utf-8?B?VXh6bjFod0VUYWNGaCtqV2xHZkRXTVl3YjE4Z25ZWjdLNUxnZyt3SG1UaEpP?=
 =?utf-8?B?VUhieXM2Z2lDckxqSkZQa3pJU3ZBOFhjWWZsYUNRekt2dllsVGZSOWoxTngv?=
 =?utf-8?B?UEtzN3pML2JNWm8vL25jOHlsOEdpb2ZhbExkMXdwcEZkRkF6QzdVUHVtb0ZD?=
 =?utf-8?B?NStlaEV1TTlYbzROZUM5M3JOS2xneG5FMjFOU3NZay90VGdaeGxrdWFIa1V0?=
 =?utf-8?Q?hKfxqHn2RXfIvtgXK3Sude01+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ed2766-aaa7-4878-4027-08dde0854125
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:35:08.6913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmVN6IJrzUsIQghaihwm9wtB3sl8+I09e0u8cqat7aUspSM6lWwT8BsJR1AQcwAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

On 20.08.25 23:00, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>> Sent: Wednesday, August 20, 2025 7:33 AM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
>> <SRINIVASAN.SHANMUGAM@amd.com>
>> Subject: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
>>
>> Add bookkeeping for the remap page to struct amdgpu_device:
>>
>> * mmio_remap_bo (singleton BO)
>> * mmio_remap_base, mmio_remap_barsz (register BAR base/size)
>> * mmio_remap_offset (BAR-relative offset of the remap page)
>> * mmio_remap_size (PAGE_SIZE)
> 
> It's not PAGE_SIZE it's 4K.  If the PAGE_SIZE is >4K on the system, then we can't support this.

Please use AMDGPU_PAGE_SIZE for all defines, it should be 4k for current GPU HW generations.

Regards,
Christian.

> 
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index ddd472e56f69..6c477596617b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1038,6 +1038,13 @@ struct amdgpu_device {
>>       amdgpu_block_wreg_t             audio_endpt_wreg;
>>       struct amdgpu_doorbell          doorbell;
>>
>> +     /* ===== MMIO remap (HDP flush) bookkeeping ===== */
>> +     struct amdgpu_bo                *mmio_remap_bo;   /* singleton BO */
>> +     resource_size_t                  mmio_remap_base;  /* REG BAR bus base */
>> +     resource_size_t                  mmio_remap_barsz; /* REG BAR size */
>> +     resource_size_t                  mmio_remap_offset;/* BAR-relative offset of
>> remap page */
>> +     resource_size_t                  mmio_remap_size;  /* always PAGE_SIZE */
> 
> Always 4K.
> 
> Alex
> 
> 
>> +
>>       /* clock/pll info */
>>       struct amdgpu_clock            clock;
>>
>> --
>> 2.34.1
> 

