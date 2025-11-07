Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E32CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 13:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9FA10EAC1;
	Fri,  7 Nov 2025 13:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="147GZ1jv";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD8210EAC1
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 13:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlH1Z1hCS76wRj7cmw5bv+fuGJyhULcdT0ODkRZ17OQI2ts16CNqRMXtiFGh3mxYIqBj5/mJk1uXo0FyJcey/votQCrascp6s0d9acfAuJ4cLM4VR5eJlnKiwBlj3AZFPatBp/GdlI82cMXxVcqsv3M064JKS74s6sTcu/3AiEQ6w8AQwjs7w21pMtMYl4F/pJxoMjDKBoPbarzXkrPR5d1D2by5Po6vJEyf1uRNkG3ErW3f5eBvqFlsH6CbGVKlj7JJtbw9R0YSQkG9asbWc1SBe1Rxo/cYnApcV1UHrR8il/KeNMSVkRt5N8fWro08pLne/A5Csrz48tiptrBspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnjcod72zEbmWTywWM+y2Am96j3ThocKMNazgN31EUU=;
 b=GvLqJeGOUAa7G5y5upla2QHmAx4FoZllFyiLLFj2QvY5O1uAnfw73wgcwenqEPIKQ23qRtBPmBLQk+Wtxf+mUDZuSGgGhWNn4ZSoXuCwvy0s0FiBiwqBaQnZbmUo4KV5c/OBeTjoeBBnMwY3VkIz3RFVOHkDAB3z9aCLDKSa/TmTVwrmFBtq891edvT24nNgY/6yEB7PB3Avp3lLsi4659sL1+60I4Z7Zz0r4IAopsaDlDHPh6o7MO0QOJvoAMwlEY082zZGWor2N9F8BLveR3FXnC+VXSx70aC2WX2lMK/YoD0qi2P0jLrq8+kg01Qo5w+tJOJNaGlXDIEhIjSVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnjcod72zEbmWTywWM+y2Am96j3ThocKMNazgN31EUU=;
 b=147GZ1jvoATF7cqRTTf4LDL5/VyecvckQL21yGvfL4UBDNr8m0gZdkyhQFr6U2Fkdv7wDEdwVtK6XTRE4tqefgGJOzjEa1s9Vt+dbIZCu13wlVKRNRhPsprWqU9wnnxPgzQdrKOOk4BdV9Ui23OY5ANp0SVIDLd1CPBvO/GFX10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 13:33:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 13:33:10 +0000
Message-ID: <425e9d98-73ea-4799-b4b0-7fde38927080@amd.com>
Date: Fri, 7 Nov 2025 14:33:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,
 "Dong, Ruijing" <Ruijing.Dong@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
 <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
 <a1f6e8e49d4f3d3a90afa8d3232b15626c34d991.camel@gmail.com>
 <180c651a-1711-4618-96d4-692d0c9c8996@amd.com>
 <9363414739e3053e04d971424a38293552c51348.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9363414739e3053e04d971424a38293552c51348.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cffec8-f165-4890-234e-08de1e023150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk9FUE0zcTlrZTN2RGJ3RTRlbkg1VDlaZFFrSnhSZGQ4MFJGNDF3RloramxX?=
 =?utf-8?B?bEhEVmw0bGp4OHpmdGRYeTNCbk5CNFlzMSt4VHB5QUx6ZW9TR3hMdUpTa21P?=
 =?utf-8?B?djliT3hNOGlKSVk0UTZZWUZuYzMyalAzbUtUZmR6ZXJIK0xZN25VVjQvcFlG?=
 =?utf-8?B?bDFnR2cvMkdmMnYydFdVZFJKN2c5cVc2SFM2d2syV1MvUkhVd1R3WnNrNWFa?=
 =?utf-8?B?cUxhczVFeWp2eVFzNVo2cG1keTkydlZBczg5V0ppdVFWVzg5Qndwd29xYTVO?=
 =?utf-8?B?OW9GdUpUdFlkcmFIUkZ0MlNaOFdaUGIvNU5hQTEySnhMYzQ4aFFhY0EyUjRl?=
 =?utf-8?B?VHhDZkU2SU9VYXJraWVSNmpKRFV6KzgxNzc5UzFnblBKUXRMbnNoQ3hYK3FI?=
 =?utf-8?B?ZzNGcWZRK21UaUx6TkNsZ0VZN0J2U04vYmhCN1JYOUw1WHVFNmJWUHNKcmVC?=
 =?utf-8?B?dDVBdnB4TG5yUHpkRHd0Zll0TGlNOGtoUzR6eEtWZklpQ1dGbStOejl5Y3pr?=
 =?utf-8?B?WlVreEljNUVDbDlnZVZZYkN6WFF6dHdmMFNydGdBMXBrSFMvL3lzWU8wUEEv?=
 =?utf-8?B?YURJbXhaRXlDa2NkcTE1VHhyMStQUGxvNTlGb1JEWGU3WFJLdVJPcG8zdnhJ?=
 =?utf-8?B?cmNEVFNhNXFWQzhsNXA5dFV0Y0M2eVY1c2hIL2xvcnAyazJxa3pLTDUzc1FO?=
 =?utf-8?B?S2FNMjU4RkNLall0WGdjeFU1djNvajR0Nno4M216MllnV0hUL0VTOEd5eWw4?=
 =?utf-8?B?ZTNoR3RSeFphWkxiQk5tL2hlK0Y0a0xOS2FvN3JMUTRWR2hBVkY4VTVZR1BE?=
 =?utf-8?B?cmNhTlNtenVmMDhnVkF0YjVmQ3lJN3N6YU1lOXZCSUJKL0dWejlzbjd0Q0ty?=
 =?utf-8?B?MENjKzgweUZsWXROajVZVGloZ0M0aEd5cDc0WldKOXdnNWVNK2tBMGZudkRy?=
 =?utf-8?B?QU43eDd3YmZlTjByTlN4UkUrNXkwVWV0MGZyeUkwcVdtelBocVRSdXVtMmdn?=
 =?utf-8?B?bk1ScTVRSlYyLzdLc0M5Y2ZwQ3NISXBjSGJCQ1l1OUtpQzBRUHh3WFZqeVps?=
 =?utf-8?B?NWNGeWthMmd2QVZCMVlaRmdWd0NSZmNyeHRtU0FaREh0SU9ucjNySXBHWU5p?=
 =?utf-8?B?NUdUYitFZzZGb1N2UUswY2tQeER2bk8vM3Q2emVhVlZwREphUVR1OXVVUC9u?=
 =?utf-8?B?d0hyWXRUT3M4VmVRQmZtRG1oZ3RRK245SUlXaGx1aFJreFNDZmxJUk5hM1NP?=
 =?utf-8?B?S0F4ZXJmTjArNGhJUEU5QklaajZNS3VaaHZNV3FpNUJ6MnpnSERvdmx6QS9l?=
 =?utf-8?B?N3hmRlQ0ZHFUeWoveWthUk5nQ2Q3Nk80ejYxMmNYcFh4dHNycHI1UTR5UTQ4?=
 =?utf-8?B?OVFMeGpXNWZ6bWl6MUFHcmdrb3RUMWdjSXVCa2Q2cUxnRG50Z2tERnA0QnZr?=
 =?utf-8?B?aCs3NzdFcUdLSkFEM0JLU2hUWFVnSG9ac295NS8wWXM0cW9FUFJLbUsybU1B?=
 =?utf-8?B?N25xcnJtbzNab1k0TU0vQk1IaG5XVHZvajJzd2VXQmt4SFJSTFFSNkFwbUJC?=
 =?utf-8?B?OEVhaURXQ1R0eE52Q0R5TEdUQmJKZjFDK0VaVy9iVXZxTUplengvQzVPYnRu?=
 =?utf-8?B?ZlF4Q0c4ZlQ4ZkdhRnJRZExSc1FDcDJkUU8yNEFSNGJhVldpbTJCNytNQmJR?=
 =?utf-8?B?VlRxcklrREVyM0tQUjZoRlVGbnhuQUkrWjViRmh4SGN2Zkk5V3RMQlZCTGZx?=
 =?utf-8?B?Z1Z6YVhTdEtrZWhWczhiMHJkL0cvbVJWTDBPQ0dqa2VrRDEzNzM4OUhCV215?=
 =?utf-8?B?Nm5vWWl6eDRhRUpXeFQ1Vk42dmJ0UzBTVHRES1BhZTlXejlKT1JGTFRJVFdq?=
 =?utf-8?B?SXpkYWd0U2twa04vZEdmL09EZnJjT2wycldYNnE0UG5hbklHa1Ewc3Mzc0Fz?=
 =?utf-8?Q?DqbEJLpoxkt2U7/CIfMy3MrYOZK1nAjl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVrajJuU1ZYenhTeVh1TlNmRXMzbGUrYm0reVZZcTlVODczVHVacThVVmVs?=
 =?utf-8?B?NWduNWo2SjhIcTBTV0lFRkpMKzV4YTIrOWNTK3VKYnFUbUhPTlgzMTVXTEdu?=
 =?utf-8?B?bnZuQTdDTERDMFpETkNzbTFsYStBMkJySk9yVVIrTHpvQjkrN01WazFjZW9w?=
 =?utf-8?B?UktoY0RZQzZxNElLSTlhL0lLdzJYZkxuMFdxSG5pNVRTZVZYRjV1Q1J1Zmpa?=
 =?utf-8?B?MmlRZW9ENGU5MlFFWmxLWFZRV2FKUnJqQzBuYmpTKzlqL0xKQU9GbFV5cFF2?=
 =?utf-8?B?SnhIM3pJTkpKSXlSOGI4akwvdklwQXlwSVZYa1lRczI5TFl0VjNkTkljRDZ1?=
 =?utf-8?B?MFRuUlF1eGtMdHBTR2NiUFlJZ252K2crVUFRbUR5MGpDVjV5ajhENkxoeTE4?=
 =?utf-8?B?OE5tem9JVWsyZTY1NW1adlJ0Z2FZOEZGK0ZZWktjb0YrMWdxVTc2SFBBbHcx?=
 =?utf-8?B?bkJlLzZvMmdGaGcvUnU2Y2QzWlMrOExIVVdFWTM0SWM0RVM3OFRVVzExRjF3?=
 =?utf-8?B?NEtmOGVoQUxZUk55enhZU3kxdUZZSnk2S1VjZFpCeDFuREJLODVDS3JBWnVh?=
 =?utf-8?B?QkpaYzJ6RWU4c2didk96SWN1T0NWL0NpanVYMHUwSTJsdElDcENYcjZVVzNO?=
 =?utf-8?B?KzJRb01PRlNVUHlDbG9JbU5Pbm1LaXl5TWo0V25GTmFKYUYzaFJGMFVGdTBo?=
 =?utf-8?B?OUtqaXZIbDE0eFFianA5UVAwcnBLME12cXlYa09Ea2ZjaVhkaWw3SVExUDd6?=
 =?utf-8?B?a24wUDFwZGxNY0p3d1VsdE1mTjRjUlZLQjFxMmpwb1lJVENsR0diMHAzK0Zp?=
 =?utf-8?B?dDU0MkpqVnFpZERSRzRReGVHQ3Q1bHdPc25FNFVPSlhyaURjUHdhQkRIRXdC?=
 =?utf-8?B?U3o5L2JtK3JZdVFVZFNmSE1tSFZXLzcwK09PNGlRVUNLNEtiOEV3V1VsaEdJ?=
 =?utf-8?B?ejFORHo5SlFoSTRlWXYwVHpMMEtEMW83Qk81UTlzeTVnQ3hmZFJZNURJT2M3?=
 =?utf-8?B?L1lJQUJsMEM1cGdKbW1OUno0YllkeXFUZmxkUjhRWk93QnRPakwzTmJNY2Uy?=
 =?utf-8?B?Q3VuM0x4S09ibG5lZ2pRcDdTN3FMYWlXZVF4RWI1M3MzajBDV21CUjVOVEFw?=
 =?utf-8?B?OWN2cGdFVmJzQXRyTTNibVloZUJpWElKdDFYV1dPd3Y0djVhR09XMzlSMzlD?=
 =?utf-8?B?S01yQnkrVDZIRUU5VUtJZi9lNitNbmNBUmxOeXpvdFlRZHdibzU4aGVXNXBh?=
 =?utf-8?B?V25DQmwyb1Z1a01EQnFZd3lrNkxaNVAyZlZvRGRUQnl4MDJhT05Bam5qTWVS?=
 =?utf-8?B?TXZ5THBxRFB6UGRzL29HTGlzb3lXaHZ4OVp5cm5jVkFEd2dWT3RHRUw1bGFW?=
 =?utf-8?B?elJzR3F4NnBQbUpUTGtKQTJzRS9rZ1Zxb2lDdzBpUVQ3NDlZYThUaFV1SXZj?=
 =?utf-8?B?cDhpckk3dzhsL3dydFNWRVA1Q3FCOUhLUWVDL3ZTdUo2SERubWgyTDVTWXA4?=
 =?utf-8?B?OU9OdUpESkhOekhGU3RPUzl6OExacWlkSG5taG5jMHBreXY2TkppUDljZXpE?=
 =?utf-8?B?aXJ2VkNrMmtVUFNxY3h0V21BRTg4ak15bU82Zmg1TURqSm9rWlRKSUhlZG5U?=
 =?utf-8?B?dHlWaWo4eWoxM0NzN1dkUkdVWmYrMGJnMnh6QitEaFROd0VBbU1UQkNOUkg5?=
 =?utf-8?B?RlVQRzRYQjVJYXhJY0tVT2NkWGc1amR1WlpFdjg5ajBrWExRNEY3QUthaUsr?=
 =?utf-8?B?MVp4YW5EMjRGOVFQZW9Fcmcxems1VDZWd0J2VTlkY3VLTS9qMkpzdC9lVTEv?=
 =?utf-8?B?Y3BVL0t6OGxLVEZXTldqcFMwZVZsbUdGMG5Lb0pCYmpBSVFYRWFjdGhvRUxt?=
 =?utf-8?B?bmZsTGttbGZsdExXclR2RXFwUWZnWWVtQWltMStteHA1ZUdLcjh0K0R4T2NH?=
 =?utf-8?B?WG8rY1A5Vk5Uc21NUVViTzZDVmJNa1k5a2ZKdTZ2OGh6cG1DZC8ySzRuNlk2?=
 =?utf-8?B?cmp6OVFCRm4xOGs2SnVEZnliZUJGM0RjWHBhMnhROXJDR1htOWF1S3FXNUxP?=
 =?utf-8?B?SUFRdWNTM0xhMjhud2xwci9nZy9SdklsN29ROFFLaGNEK3V5Wm1pdEl3QXBC?=
 =?utf-8?Q?wWopnUam3gKDTQ6/d6t6tU5Uc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cffec8-f165-4890-234e-08de1e023150
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:33:10.1672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW+E4rXJcIp+2vCv/XIu+VjB0XJ7mq+U/w6omaD4yOHR+d1GjcRu68kP1DnTEu8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

On 11/7/25 14:31, Timur Kristóf wrote:
> On Fri, 2025-11-07 at 14:14 +0100, Christian König wrote:
>> On 11/7/25 11:47, Timur Kristóf wrote:
>>> On Fri, 2025-11-07 at 11:01 +0100, Christian König wrote:
>>>> On 11/7/25 10:53, Timur Kristóf wrote:
>>>>> On Fri, 2025-11-07 at 10:49 +0100, Christian König wrote:
>>>>>> On 11/6/25 19:44, Timur Kristóf wrote:
>>>>>>> VCE uses the VCPU BO to keep track of currently active
>>>>>>> encoding sessions. To make sure the VCE functions correctly
>>>>>>> after suspend/resume, save the VCPU BO to system RAM on
>>>>>>> suspend and restore it on resume.
>>>>>>>
>>>>>>> Additionally, make sure to keep the VCPU BO pinned.
>>>>>>> The VCPU BO needs to stay at the same location before and
>>>>>>> after
>>>>>>> sleep/resume because the FW code is not relocatable once
>>>>>>> it's
>>>>>>> started.
>>>>>>>
>>>>>>> Unfortunately this is not enough to make VCE suspend work
>>>>>>> when
>>>>>>> there are encoding sessions active, so don't allow that
>>>>>>> yet.
>>>>>>
>>>>>> The question if this is the right approach or not can only
>>>>>> Leo
>>>>>> and
>>>>>> Ruijing answer.
>>>>>>
>>>>>> If we can get VCE1-3 to keep session working after
>>>>>> suspend/resume
>>>>>> we
>>>>>> should make this change otherwise we should rather make all
>>>>>> old
>>>>>> sessions invalid after suspend/resume and only re-load the
>>>>>> FW.
>>>>>>
>>>>>> Anyway I think you should make the removal of
>>>>>> "amdgpu_bo_kmap(adev-
>>>>>>> vce.vcpu_bo, &cpu_addr);" a separate patch, cause that
>>>>>>> seems to
>>>>>>> be a
>>>>>> good cleanup no matter what.
>>>>>>
>>>>>
>>>>> This change is necessary for the VCE1 code when it loads the
>>>>> firmware
>>>>> signature. Without this patch, we would need to call reserve(),
>>>>> kmap(),
>>>>> kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
>>>>>
>>>>> Let me know which approach you prefer.
>>>>
>>>> In this case definately make removal of amdgpu_bo_kmap(adev-
>>>>> vce.vcpu_bo, &cpu_addr) a separate patch.
>>>
>>> Sorry, can you clarify what you mean?
>>> Should I just go back to the way things were on the first version
>>> of
>>> the series, and then clean it up later?
>>
>> Just add a patch (early in the series, probably as first patch) to
>> remove amdgpu_bo_kmap(adev-> vce.vcpu_bo, &cpu_addr).
> 
> Is it allowed to keep a BO mapped when it is unreserved?

Yes, as long as it is also pinned.

IIRC the VCE BO is allocated by amdgpu_bo_create_kernel() and that both pins and maps the BO.

Regards,
Christian.

> 
>>
>> Then put the memset_io() into amdgpu_vce_resume() like you had in the
>> first series of the patch so that VCE1 behaves the same as VCE2-3.
> 
> Ok
> 
>>
>> And when the series has landed we can clean everything up depending
>> on what Leo/Ruijing has decided to do with suspend/resume on VCE1-3.
> 
> Sounds good.
> 
> 
> 
>>
>>
>>>
>>>>
>>>> I want to get initial VCE1 working and landed independent of what
>>>> Leo/Ruijing say to suspend/resume.
>>>
>>> Agreed.
>>>
>>>>
>>>> Can be that suspend/resume is then still broken, but that is also
>>>> the
>>>> case for VCE2-3 then.
>>>
>>> Yes, some extra work is going to be needed on top of this patch to
>>> make
>>> suspend/resume work (if it's possible at all).
>>>
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++-----
>>>>>>> ----
>>>>>>> ----
>>>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 52 ++++---------
>>>>>>> ----
>>>>>>> ----
>>>>>>> ----
>>>>>>>  2 files changed, 24 insertions(+), 72 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>> index 2297608c5191..4beec5b56c4f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>>>> @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct
>>>>>>> amdgpu_device
>>>>>>> *adev, unsigned long size)
>>>>>>>  	if (!adev->vce.fw)
>>>>>>>  		return -ENOENT;
>>>>>>>  
>>>>>>> +	adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
>>>>>>> +	if (!adev->vce.saved_bo)
>>>>>>> +		return -ENOMEM;
>>>>>>> +
>>>>>>>  	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>>>>>>>  				    AMDGPU_GEM_DOMAIN_VRAM
>>>>>>> |
>>>>>>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>>>>>> @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct
>>>>>>> amdgpu_device
>>>>>>> *adev)
>>>>>>>  	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev-
>>>>>>>> vce.gpu_addr,
>>>>>>>  		(void **)&adev->vce.cpu_addr);
>>>>>>>  
>>>>>>> +	kvfree(adev->vce.saved_bo);
>>>>>>> +	adev->vce.saved_bo = NULL;
>>>>>>> +
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>>  
>>>>>>> @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
>>>>>>> amdgpu_device *adev, struct amdgpu_ring *ring)
>>>>>>>   */
>>>>>>>  int amdgpu_vce_suspend(struct amdgpu_device *adev)
>>>>>>>  {
>>>>>>> -	int i;
>>>>>>> +	int i, idx;
>>>>>>>  
>>>>>>>  	cancel_delayed_work_sync(&adev->vce.idle_work);
>>>>>>>  
>>>>>>>  	if (adev->vce.vcpu_bo == NULL)
>>>>>>>  		return 0;
>>>>>>>  
>>>>>>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>>> +		memcpy_fromio(adev->vce.saved_bo, adev-
>>>>>>>> vce.cpu_addr,
>>>>>>> +			      amdgpu_bo_size(adev-
>>>>>>>> vce.vcpu_bo));
>>>>>>> +		drm_dev_exit(idx);
>>>>>>> +	}
>>>>>>> +
>>>>>>>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
>>>>>>>  		if (atomic_read(&adev->vce.handles[i]))
>>>>>>>  			break;
>>>>>>> @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct
>>>>>>> amdgpu_device
>>>>>>> *adev)
>>>>>>>   */
>>>>>>>  int amdgpu_vce_resume(struct amdgpu_device *adev)
>>>>>>>  {
>>>>>>> -	void *cpu_addr;
>>>>>>> -	const struct common_firmware_header *hdr;
>>>>>>> -	unsigned int offset;
>>>>>>> -	int r, idx;
>>>>>>> +	int idx;
>>>>>>>  
>>>>>>>  	if (adev->vce.vcpu_bo == NULL)
>>>>>>>  		return -EINVAL;
>>>>>>>  
>>>>>>> -	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
>>>>>>> -	if (r) {
>>>>>>> -		dev_err(adev->dev, "(%d) failed to reserve
>>>>>>> VCE
>>>>>>> bo\n", r);
>>>>>>> -		return r;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
>>>>>>> -	if (r) {
>>>>>>> -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>>>>>> -		dev_err(adev->dev, "(%d) VCE map
>>>>>>> failed\n",
>>>>>>> r);
>>>>>>> -		return r;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	hdr = (const struct common_firmware_header *)adev-
>>>>>>>> vce.fw-
>>>>>>>> data;
>>>>>>> -	offset = le32_to_cpu(hdr-
>>>>>>>> ucode_array_offset_bytes);
>>>>>>> -
>>>>>>>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>>> -		memcpy_toio(cpu_addr, adev->vce.fw->data +
>>>>>>> offset,
>>>>>>> -			    adev->vce.fw->size - offset);
>>>>>>> +		memcpy_toio(adev->vce.cpu_addr, adev-
>>>>>>>> vce.saved_bo,
>>>>>>> +			    amdgpu_bo_size(adev-
>>>>>>>> vce.vcpu_bo));
>>>>>>>  		drm_dev_exit(idx);
>>>>>>>  	}
>>>>>>>  
>>>>>>> -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
>>>>>>> -
>>>>>>> -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>>>>>> -
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>>  
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>> index 2d64002bed61..21b6656b2f41 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>>>>> @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>  		return r;
>>>>>>>  
>>>>>>>  	if (adev->firmware.load_type ==
>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>> -		const struct common_firmware_header *hdr;
>>>>>>> -		unsigned size = amdgpu_bo_size(adev-
>>>>>>>> vce.vcpu_bo);
>>>>>>> -
>>>>>>> -		adev->vce.saved_bo = kvmalloc(size,
>>>>>>> GFP_KERNEL);
>>>>>>> -		if (!adev->vce.saved_bo)
>>>>>>> -			return -ENOMEM;
>>>>>>> -
>>>>>>> -		hdr = (const struct common_firmware_header
>>>>>>> *)adev-
>>>>>>>> vce.fw->data;
>>>>>>> +		const struct common_firmware_header *hdr =
>>>>>>> +			(const struct
>>>>>>> common_firmware_header
>>>>>>> *)adev->vce.fw->data;
>>>>>>>  		adev-
>>>>>>>> firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
>>>>>>> = AMDGPU_UCODE_ID_VCE;
>>>>>>>  		adev-
>>>>>>>> firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =
>>>>>>> adev->vce.fw;
>>>>>>>  		adev->firmware.fw_size +=
>>>>>>> @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>  	/* free MM table */
>>>>>>>  	amdgpu_virt_free_mm_table(adev);
>>>>>>>  
>>>>>>> -	if (adev->firmware.load_type ==
>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>> -		kvfree(adev->vce.saved_bo);
>>>>>>> -		adev->vce.saved_bo = NULL;
>>>>>>> -	}
>>>>>>> -
>>>>>>>  	r = amdgpu_vce_suspend(adev);
>>>>>>>  	if (r)
>>>>>>>  		return r;
>>>>>>> @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>  static int vce_v4_0_suspend(struct amdgpu_ip_block
>>>>>>> *ip_block)
>>>>>>>  {
>>>>>>>  	struct amdgpu_device *adev = ip_block->adev;
>>>>>>> -	int r, idx;
>>>>>>> -
>>>>>>> -	if (adev->vce.vcpu_bo == NULL)
>>>>>>> -		return 0;
>>>>>>> -
>>>>>>> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>>> -		if (adev->firmware.load_type ==
>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>> -			unsigned size =
>>>>>>> amdgpu_bo_size(adev-
>>>>>>>> vce.vcpu_bo);
>>>>>>> -			void *ptr = adev->vce.cpu_addr;
>>>>>>> -
>>>>>>> -			memcpy_fromio(adev->vce.saved_bo,
>>>>>>> ptr,
>>>>>>> size);
>>>>>>> -		}
>>>>>>> -		drm_dev_exit(idx);
>>>>>>> -	}
>>>>>>> +	int r;
>>>>>>>  
>>>>>>>  	/*
>>>>>>>  	 * Proper cleanups before halting the HW engine:
>>>>>>> @@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct
>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>  static int vce_v4_0_resume(struct amdgpu_ip_block
>>>>>>> *ip_block)
>>>>>>>  {
>>>>>>>  	struct amdgpu_device *adev = ip_block->adev;
>>>>>>> -	int r, idx;
>>>>>>> -
>>>>>>> -	if (adev->vce.vcpu_bo == NULL)
>>>>>>> -		return -EINVAL;
>>>>>>> -
>>>>>>> -	if (adev->firmware.load_type ==
>>>>>>> AMDGPU_FW_LOAD_PSP) {
>>>>>>> -
>>>>>>> -		if (drm_dev_enter(adev_to_drm(adev),
>>>>>>> &idx)) {
>>>>>>> -			unsigned size =
>>>>>>> amdgpu_bo_size(adev-
>>>>>>>> vce.vcpu_bo);
>>>>>>> -			void *ptr = adev->vce.cpu_addr;
>>>>>>> +	int r;
>>>>>>>  
>>>>>>> -			memcpy_toio(ptr, adev-
>>>>>>>> vce.saved_bo,
>>>>>>> size);
>>>>>>> -			drm_dev_exit(idx);
>>>>>>> -		}
>>>>>>> -	} else {
>>>>>>> -		r = amdgpu_vce_resume(adev);
>>>>>>> -		if (r)
>>>>>>> -			return r;
>>>>>>> -	}
>>>>>>> +	r = amdgpu_vce_resume(adev);
>>>>>>> +	if (r)
>>>>>>> +		return r;
>>>>>>>  
>>>>>>>  	return vce_v4_0_hw_init(ip_block);
>>>>>>>  }

