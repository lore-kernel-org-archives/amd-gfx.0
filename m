Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C738FC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BBB10E97F;
	Fri,  8 Aug 2025 19:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQxxXCNp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C0910E97F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj6Z/m0902vUEnbimhn6E7S0SyUx1BSP8tGKp17r4xtRo7LLTRDyGeNIBbMSGJTBfXUOy6TKarxoWfZ/3r7Yjv8hW3ELZ4MmZY07v7HWZAFX7mweiPSyukxAvGGA+uO6UzyyNxJvP2knetnQqE/hZqxncl/2TqsI9w3coFB96HSwEMOVSmJsl9jS1sCzKJeTpScLCFmeZAO4vRfjoDykn+sAQm4PXNUI62DAA9yvXFZIsrrZXRh2D8CPltxtCd7ymgr4mRtXOu/CYjm/Hv3BTuEOkuACOjrfDCVOnN3ERwCE/FikMD2EcRKtIcfMydH+SjoCMzslN25SqFUhMCJO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=484o+P5kry2yIXEbhnj4u/7BhJkqxDCEI1Fek4XcNBY=;
 b=XYgLochEwzSkxsOvQT1kPa9iqz7ks5U8Q1DoCR27CyynWMxu5ZRa8nrf1Zwmiw273pDkUE8zsp+CYVY90XOSGlRwgaeQYHBSz2Avv0xzVMa+cseWRY+5YbuKq/wZ121QkMW9slD0RTbzd3S+5HSrmArQ6z9hu1gzukPfgkrFrzr66ptINoDHnTCrCAZQ9rKiLQXQWCIaFuSgYbU/WiLu1lLNCRQn0eCSv5p+9g7VT1auKjfxHVmH+ESrr/dseJC2j/DMTwrVTIUkA5HuFTyyLldhzMFSoO22b17TDXlamFfELlVdferxESQsZUJeE8l1dT3dyl2uMUgVdAwbzun6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=484o+P5kry2yIXEbhnj4u/7BhJkqxDCEI1Fek4XcNBY=;
 b=bQxxXCNpKOOpd/Gk/r2unYw+k4n+Nvf+tiEkfZeNrm9kzj0gnFLhpFEG0LnCxKovBbAe+/oP3oPp6WpIl1tF6NxFQS7zTRksWYDwEVJ+ChX5mxzLxczCHkfy9dKd70c2CX6X2EJF1WjyWbEFz0S1JDXTTVUNhyGVzcdkQZjlLeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 19:56:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Fri, 8 Aug 2025
 19:56:28 +0000
Message-ID: <60cc16ca-8209-487d-854c-57ebcbcf1365@amd.com>
Date: Fri, 8 Aug 2025 15:56:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250805145743.104650-1-kent.russell@amd.com>
 <83fc2476-de21-4869-abc9-54ebd9aef146@amd.com>
 <BL1PR12MB5898292B07D57D667E029938852FA@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <BL1PR12MB5898292B07D57D667E029938852FA@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 4464ae3a-ef8c-48d1-cf1a-08ddd6b5a987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3p6aWh6Y3lQKzBENW5ueUxac08zdHlEUzRmV0VBa3R3cUdKZmNKYjJsSEVP?=
 =?utf-8?B?Skx6NWNNUHhCWDVUcFF0bUFDNTcrZGlHRHNYMU5yNDZ0OTR3aDh0SXlHdXJQ?=
 =?utf-8?B?dlZEc0VqQjVxZFFZbkdXc0FGTlpKRk8zbTZEaHhEVlVYLzNjcnlLTVNzN1Ja?=
 =?utf-8?B?NmxtUTJjM1NPcTBJZjlSWXl5c1pjZlkycHFlQWJDTzJnN1dNNHRVWXFFVjJR?=
 =?utf-8?B?anluUy9yNjRhWkpnVmsvZTNBOTd1RXdsanFJMnhYTmU0RzY0TU5hUGZxL1Ay?=
 =?utf-8?B?NHVaZHVDVUxENmN1LzNxd2RwTWRSMUZ5ZnBVZDMwYmx2ekVJVVdRNkYwa0ln?=
 =?utf-8?B?QTU4cmlVMDJieUhqM3ZUcWY2UkJma255RU5FVVB0NnNCcDZmMDJGZGRtUnpp?=
 =?utf-8?B?Q29WaG5QNHh6Z0dUS1psMG01OVJLWXpSRVhzeGl6QWFTb0J5M2l2OWpLU3B5?=
 =?utf-8?B?aEZHZEp3NjNkU0Y1NVI0NEEwelk5WmUzY2N0QXFqdCtibS9TK0lMTDMyTTdG?=
 =?utf-8?B?WUI5UFlndm5tbUdBS29wODdiRE1mVkZRT3pQcXJDQngvS0N2TUl1UWUyMnFa?=
 =?utf-8?B?TkFoY1p4MjVsOC82UHRGUGJ6Q0FMUWRvUC9Ld25ReXR4MnoxTkVxOXRpajQy?=
 =?utf-8?B?VlpPMFlMVzhOQ0N2czlGUGxoTVBCcEhYS0hnQXF0T2xST3U3NThKK2Yrd1Z5?=
 =?utf-8?B?R0lFN0ZLa1AxZXZLSElnMEhsa2FDR3dYV0VRUENtYlZtaHN2akZnYjlGczRZ?=
 =?utf-8?B?YjlKVFFRRXlOZEpMQlRYUG9mOWZSNHJkeHRNdXEvOTZleStMTmhYb2pPY1hj?=
 =?utf-8?B?NkIzc0MxK1BOV013UVdSbXNYRUpQOUR1TW15ZS85SjZDcmIxVlVkZEJSYlpt?=
 =?utf-8?B?VHp5VW9ubHN2UGgzRkhjemZJMjhRdC82SEFDQ3lWK2FSd2dJSzBiY3hSdWRq?=
 =?utf-8?B?T0tYRXZZaWN6bXpONERoRVJTV1g0eGxCNTJQY2tucnM1U2pIUHVxUzQramcv?=
 =?utf-8?B?WG83cEZFY09lYVNZak90MWpHL1h2QmRDSnEvcjhHcjZMbTluOTFFWkM4dzdW?=
 =?utf-8?B?Q1k0clBRc1dEOW5aZUdsemczc1JaWnQ1N0V6STF4cm5sSVVvcXpMZ0RXL3Vo?=
 =?utf-8?B?NkdDaUhQSUNzN29EMkp0bFlHNGxiY256YUVQOTNDWFc4S0RVajJadE5EWEdj?=
 =?utf-8?B?WHlMT3VSU3N5WG8rTjViektxdW5YN0p4OWVmb1p2NExhQlFxY1RoMkxTczV5?=
 =?utf-8?B?ZXJtT1dqWmwyTUVuaFVzNVdWdTdtVDR5ZVRJUDJiaE1OQzlDR040UTVLWTd6?=
 =?utf-8?B?MWFYaGpFYSt0YUlZMHdsN3lMQVFZNElKcE9qa1VhYTBXMmp4elNVdDg4ZC9T?=
 =?utf-8?B?bVNEcy8yVzJSaFN4RDd6cldBZjg3cUVmTmhGY0VKNW1XZDVvRUUxc0tnbzcv?=
 =?utf-8?B?SXBGazdMUkJ0Q2lZeElkUmg3UG1GN1BKMjRWVjY4aTF0Q2Fmbyt5eHkxQmJH?=
 =?utf-8?B?QW94WkYycWJJajdRNWpONjFmSDFCeHc1SHVySzlITXFMMExtTEY5WW5UcjRu?=
 =?utf-8?B?OTJ4OTk1Rk51anMwaXFhUmlEaSsyNktPTUNxSE45M1JoYjB0cENrOGgyVFE1?=
 =?utf-8?B?TEc3QVBYUkkzdmZ6Zy9GMDlpMXowSEwwcUMyV2FINWVqWFEya1Z0OU1BbnhO?=
 =?utf-8?B?WFpBd1ZOUm1IK3NqUURFMHNKNDVlVjl0N3h2Vi9FWjEzblJpcVRzRUhsdEl5?=
 =?utf-8?B?R0NjcHorYWorL0NJenJqbURJWXExNzVuaWg3eWc4dHJRU1RUUGdrWEZGdEhm?=
 =?utf-8?B?cDRubVhRd09SbnpEMHBNRkFWU3l2R3BGckk3aU9OZElBL0MzTC8rdkcvU2Nw?=
 =?utf-8?B?L21yVjlFT2pjcE5FcElOVXcwWmlJTG90dS9GVGg0QVAzY082T3hLWWkxaHN2?=
 =?utf-8?Q?HzDyskCKHnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEZwRXVtRkh6OExvV1l6c3hiVlNXbFlUc0UyelZoNzEzSU4wYVNzOXI5emZx?=
 =?utf-8?B?SWZtQ2dWM3d3dEczTkY0UGdaRTI0VVJIVWRwUHNMTXBQaE1uclFHVGhjbzhS?=
 =?utf-8?B?UjdmYVU2ODdNMWFISHpJSmhzTjVLd2VZMENWc2kwN0RKdzF5VFozYVBQWm12?=
 =?utf-8?B?Qkh0YWwreGtlZW8rN3pBbnV0UjI5SFFzUFhZbjdZbXM1M1JSUzRTZXdFOFJE?=
 =?utf-8?B?K2NLRzU2SWczemp4OU4xT1gxM09RRjNNYlAxN05yVlo2UkJIcmNuQUdwTWov?=
 =?utf-8?B?dGQ0WEZ5eDloRmJxdkFNQ29lTThTckphYStCS0tTTFJXeDk3cGxHQi91aXI5?=
 =?utf-8?B?UVBja2Y5ZndyZll1REVqbHF1R1ZER0Mxek40TUZzRUxSQzJIYjNoWm5USFpl?=
 =?utf-8?B?TTk1bHVBS2daL1dSVGVzcG5EWXpHZDF5MUcwc1Y2QkxKR2xCcnVVbG5WQjRF?=
 =?utf-8?B?RWtmcWpYTWJLNm42NG11TW9CTXhXL1Yva29NdEh3RjV3VEhmWnRSQ2dKbUNF?=
 =?utf-8?B?czd1Nlg0cThJQ1hGakd3b29mWkhQTGhRWjZhNmZsakxORWw5YTdHZnIzS2N6?=
 =?utf-8?B?dE5hR2RJZC81aS83b1RITjhGUkF2ZXQ3Uk1LUEV1V01BNUJ3RUdleEU1Q3hq?=
 =?utf-8?B?WldXMVM5WkU2WmI1ckl5dnp0Y0p4Mm5yTWU3aWtoZnk0YnZCUUdPcFhseW1S?=
 =?utf-8?B?THZrdktPQk5kaURaV1h6Ujlkd1NDTmdYZzhOcm5ZVDFsdTlXSDUzcERuR3FO?=
 =?utf-8?B?bks1UXBEOTFmY2d5Ny9NYnV6a3JhblJqRStrbncwNEp2ZGxEY3VXRk41UUxQ?=
 =?utf-8?B?RzRxN0srWWNmaEdRN3hodmw0ekJXWENsVmZST0JRZTZHUmVHak9wTWZFWE9K?=
 =?utf-8?B?eFhxTHRSb3ZoY2c2RzhoMkpkRnZPVkZBVm11OWdSMUxUUVNPQlJkT0t3M0sz?=
 =?utf-8?B?UWd2L2pnMDdaZmp1RFFiR2pQdTJ3cUFRcXB3NDgwSGdVK25NbFJtRnIxR2pt?=
 =?utf-8?B?Lzc3SEJhT0dNT3lzTUhzTDcvcnRXYzFkZ2NpMnRLWnZUUDd5b3F3cmlJeVcz?=
 =?utf-8?B?M3l3YzJnTmJUdTRHRTlGakU2RHJ2OWUrVGlQaVQyYzBvU0UxOVhHcEQxVW5N?=
 =?utf-8?B?di9sSWxkWkZNT0V5ckdjaVVDWUNsNFEyRS81RjlNdkFNUDFkaVYvSk5PSTVx?=
 =?utf-8?B?VW10VnRmcjhnM1grcktxanN3aXZDZFJFVUVzS2VneW55cWwvajFZQmNPT0VP?=
 =?utf-8?B?YjhPWEdyK0dNY0xYYklBQ0hTVzRmalJtSlV5QU9pdGx0bkc2WTJEMW1LMHhw?=
 =?utf-8?B?TTNiZXF3TWduMzJnbGxPbW10bVNqZGR0VFl4eHRtRkRtS0FidGUvVGpGM0Ru?=
 =?utf-8?B?YUdvZXcxR2pDQVl0U3JNNHFOWEJpbUVVTTZRd2VCNnBoNEZ5YUFaTGN2MkFs?=
 =?utf-8?B?M0RjQkVmZ1FDQ2tJVTZOSDVKUnExaWNwek1EekRvUEM2M3hML2JUZ2MybzlW?=
 =?utf-8?B?U2hLOEs2TFgzb1FMTWVDVDV3UmVFVnF3VGxUVVhrYkpUT3ZJUEhxNjg4L0dY?=
 =?utf-8?B?Zmd6Q0xyd05pRGd6RUFORG5HbXBUZ001N0kzV1hZdDFXQ1dobGdjRjdmdUdo?=
 =?utf-8?B?K2hXcUl3bkl6MFE5QzN0dTk2OEF2ZUV1M1E2cGN5bXZvMGdWcThpN1dHMkN4?=
 =?utf-8?B?TFhnL2FwT0Ixd0ZoQkRNR2JQTDBqdmd2N3lTSlF2V0FaNnlaU2JaWmgyU1hw?=
 =?utf-8?B?TGxOVnRhd2J0TFQrTGlzeU8rZXdabk9VVmU5cmlwc2FkOU1tSkJWOE8zSE9p?=
 =?utf-8?B?UUhwWWZobXAyS3NuWUQ4SzZtUVQyOENwWXNHY1FlMmt2VVZRQ1hFRmJ4WlVi?=
 =?utf-8?B?UnBub2dIeDljckp0aCtVNkRhbi9hN1BhNFQyK3lyRHJCK0FnTWhYb1RCUEV4?=
 =?utf-8?B?Mm16eVZLaEl1WHFjWEFBc21jV2JQN3ZpR3VXS0gwMXpTeDNMZ0JEWUl1TWlU?=
 =?utf-8?B?bkN1SVdqTEVRWjE3cS9GK2UwK1VMVDZCODNEWG43Ky9nY2FxM3Z1eWl2eWYw?=
 =?utf-8?B?bHRRVGY0TTZGbzh1NXBza0pxczJhQ3ppT1hOeXg1aDA0ejB1bmxNNGZoamxv?=
 =?utf-8?Q?sAedk7ZEfk3UpnZ8lm/LVIqu8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4464ae3a-ef8c-48d1-cf1a-08ddd6b5a987
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 19:56:27.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqFfajuKTWo5tbJAJir1M7HfnayYIcq/64eoKDkLr2jAMIf6vadznI1Jy6JsLSIWRNjAzXm67piUEx9qfYl72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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


On 2025-08-08 15:47, Russell, Kent wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, August 8, 2025 3:34 PM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM
>> mapping
>>
>> On 2025-08-05 10:57, Kent Russell wrote:
>>> HMM assumes that pages have READ permissions by default. Inside
>>> svm_range_validate_and_map, we add READ permissions then add WRITE
>>> permissions if the VMA isn't read-only. This will conflict with regions
>>> that only have PROT_WRITE or have PROT_NONE. When that happens,
>>> svm_range_restore_work will continue to retry, silently, giving the
>>> impression of a hang if pr_debug isn't enabled to show the retries..
>>>
>>> If pages don't have READ permissions, simply unmap them and continue. If
>>> they weren't mapped in the first place, this would be a no-op. Since x86
>>> doesn't support write-only, and PROT_NONE doesn't allow reads or writes
>>> anyways, this will allow the svm range validation to continue without
>>> getting stuck in a loop forever on mappings we can't use with HMM.
>>>
>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 22 ++++++++++++++++++++++
>>>    1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index e23b5a0f31f2..449595aab433 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1713,6 +1713,28 @@ static int svm_range_validate_and_map(struct
>> mm_struct *mm,
>>>                      next = min(vma->vm_end, end);
>>>                      npages = (next - addr) >> PAGE_SHIFT;
>>> +                   /* HMM requires at least READ permissions. If provided with
>> PROT_NONE,
>>> +                    * unmap the memory. If it's not already mapped, this is a no-
>> op
>>> +                    * If PROT_WRITE is provided without READ, warn first then
>> unmap
>>> +                    */
>>> +                   if (!(vma->vm_flags & VM_READ)) {
>>> +                           unsigned long e, s;
>>> +
>>> +                           svm_range_lock(prange);
>>> +                           if (vma->vm_flags & VM_WRITE)
>>> +                                   pr_debug("VM_WRITE without VM_READ is
>> not supported");
>>> +                           s = max(start, prange->start);
>>> +                           e = min(end, prange->last);
>>> +                           if (e >= s)
>>> +                                   r = svm_range_unmap_from_gpus(prange, s,
>> e,
>>> +
>> KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>> +                           addr = next;
>> Maybe move this as the last statement before continue below.
> Do you mean just the addr=next line? IE Not worrying about setting addr while holding the prange lock?

Yes. Setting addr=next sets things up for the next loop iteration. 
Therefore it seems logical to see this just before the continue, rather 
than "hiding" it between locking and error handling.

Regards,
   Felix


>
>>> +                           svm_range_unlock(prange);
>>> +                           if (r)
>>> +                                   return r;
>> This will skip some cleanup, including svm_range_unreserve_bos and
>> kfree(ctx). I think you can just continue in any case. If r != 0 the
>> loop will terminate.
> Thanks, I missed the !r in the for loop conditions.
>
>   Kent
>
>> Regards,
>>     Felix
>>
>>
>>> +                           continue;
>>> +                   }
>>> +
>>>                      WRITE_ONCE(p->svms.faulting_task, current);
>>>                      r = amdgpu_hmm_range_get_pages(&prange->notifier, addr,
>> npages,
>>>                                                     readonly, owner, NULL,
