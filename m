Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D9C021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 06:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B092610E8D2;
	Thu, 20 Feb 2025 06:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6VaANHL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A42910E8D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtkO0AjKvIWVaTevmrSQVSG6mi8TdwTXEOykUksWWF8q9lPkcfcfpTRXPeD48w8dULzfJgifinyykswzfi+k0o0sSqnvIIhdi2X8a7vSIQG8vFGUzJad0/DzxosVajEuzNXLRXO5XlpiQc4y8KeQZpl2Gg3HGxe0jPPOI89lGxpqldAWFMVN8EQW7mx2awAertVQh65IKYVyI//IbrC8cwb8m/lnz3o3GTwIzMJcaxiPR2uyOQIvOW2zoRUnRhsLEP4rh9kiOvDgkcLhYSlacYQfvuIdg8mzAulkzt7Eo3WEKpMhYdF9UdicwRhImWddfYbPmGnuQTAKfSW3qwR/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRUihUhoeT1Ks1EvkqKxyRUEROUfPf72tFUFt+nr3PA=;
 b=XIXW3zTXtMG01sYceTUidbm/MWUE8vOknqtgfPLXUJXRfv3nfgSwDlXtPyaH4Kwm/An07u7ZlUGMnTaPdNkWiUk5GlPR5ReNat6w+dsA+00UrZtQsd8wXVe09shKOxPBuZQpvVasZni8/LrtKlk7MxIBSJI0igqLzjbQbPxnr/Q2VBq26hqxgeQDKxRw9atxN1id25NXkmqC9wyH0LeZEZ2rqY99tYLy+1JJItIsi5hRo7f1020fEqFGOhRICsPxAiqhB7rcSFCKVwnE1WSuEzwOgtoMC0s9Of7xXGRdgBVQqIl5aoBLsgs1DwsfRzxl66gdmFYaTwsJijQ1xpv33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRUihUhoeT1Ks1EvkqKxyRUEROUfPf72tFUFt+nr3PA=;
 b=C6VaANHL03DzG+YgxWLP9NQiVph8+5unsZIDOmQj/BRhvGYHgRsrMJY0Iz/5pOLKr0tm0EdsecJrH2gnE4q+dUIHYXKLDnYmvY6stQRc32gaW6XGh1Zokob+ZsXZAcDej+xLwwVTG1s+hRX0JJxaenYFXPQbU4vfx8Y7v+diXZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 06:30:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 06:30:05 +0000
Message-ID: <c50a333c-0690-4db7-91fd-9baa6b1f6d2b@amd.com>
Date: Thu, 20 Feb 2025 11:59:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-3-jesse.zhang@amd.com>
 <f61682b9-59cf-487f-9d83-a79d4555ffd8@amd.com>
 <CY8PR12MB74359FDE16AF97D324B7EFB285FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <BL1PR12MB51449A0FA22045FA57CB3162F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CY8PR12MB7435A90C377278B3CDF1174B85C52@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_M1V6JOB8vfWSUPz2CoCB7VcGWrUZcbV3-P8NAY=9Uq7A@mail.gmail.com>
 <CY8PR12MB7435C6714F11F813E249144585C42@CY8PR12MB7435.namprd12.prod.outlook.com>
 <0578f426-2053-406f-8527-ea174be96d89@amd.com>
 <CY8PR12MB7435E2F0780D56D4F7E2B11B85C42@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435E2F0780D56D4F7E2B11B85C42@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd568fd-7d3b-4446-a685-08dd5178034a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1ZpOWs0UzhmT0NjQ01hc0VkUHE2eHZhd2dNcWh6QTk3cmZNUTMxa1VFMGox?=
 =?utf-8?B?SDFIb0hTaWJnVVJkTVViNExFOXQxNWcyOWk4azJMVUJSUlEvU1hYYTdTYWRp?=
 =?utf-8?B?bXJZRVh6amx1bGc1QkxSc1hoZ3k0emZKSkVLY2JhVlVWSW5tMUJUMVFqMHR4?=
 =?utf-8?B?ZTBxZGRpZVEwWU5nN055RU1DckRCb1NhNlhSdVFDME10MnB4cXVpU1VKMVh3?=
 =?utf-8?B?TlBQY1lBTGlIb3djMC9iNERhMTdjenNWTkljR2N6em84dElsWnJiT1BWK3hK?=
 =?utf-8?B?b3FUOEY5bDFsclJjYjczZTc3Tkg4Z281K0JxenFlUGlWR3FKZmNlSFozQkNy?=
 =?utf-8?B?aGhyTmJuQWxYTGFtQnJ4V1hmclgyWGVMa2hXZUp0ZjRNZVB6bkRaSmNoeFF2?=
 =?utf-8?B?TXdYeVRXQVFJYmwwQ3pPanVNNW41c281KzRhYzJjTzByYTJOZXVIY1NZTE82?=
 =?utf-8?B?UWhaUXMzRVV1THNrY05nVkNEMTA3SHltZXc0NDJlTUdiREN3WTU0M3BMZHpR?=
 =?utf-8?B?N2JrUzBLc2Q1SlN0TVJYcCswMndwUmNhVnpvL3JtRGd2NUkyVk8zWDhhM1VI?=
 =?utf-8?B?c1BYMkd0c3JWOGJNRG5yRU9US1ZzK3JLZXZOT1hhbmRGOXBaSy9Sc1ducWFa?=
 =?utf-8?B?amlmQ0FVcXArakRCVVk2cUNEOXV2dDl5d0hWUmFKWTIzK2lUaDRoOGViRzNi?=
 =?utf-8?B?L0JnNnIxK29Jb015WFNFN1ozUUVFYTdKS2loSlpPZ1UyK2JTODZvcUhsT1hY?=
 =?utf-8?B?V2E1M0Z0bVhzUFZaK1pTakl0ZCtHNDVXT2ZnS1JSQnRWOXI3NElDSlZCYVps?=
 =?utf-8?B?TldnamljRDlQN3lEeVJPT1VJMzNyM3pwU2NlQ2JjNDc2a2tGU1NQQVYzOTV3?=
 =?utf-8?B?aWRwa01GRXg2UVdiUWNlUS9YcDB1YUc0Rmp3dUpEMjdRbWRxRERsVVkxVisz?=
 =?utf-8?B?c01BVTlaY0s5U2NtUExPMXJpZ3BhMkhlMCs0ZzVLOE1EVkJ6VnRSaXUvUGh5?=
 =?utf-8?B?cW1jenhUL3VtL3BTVWNUempWSkJCK2VBcytxMmNmT0lnSHJFMkJhMU5zeWR4?=
 =?utf-8?B?WGVhdkhrR0gySCtzVmZHdkJGVXVQa1FxTVdZeTcyNHBkbmYyVzJmS0hrN0Vs?=
 =?utf-8?B?K2pVYmxkYTUwQm5FNEdqdW5DOXp3WktIUHJXU3diSlJOQnZyeURUcXZpUENE?=
 =?utf-8?B?RzA5bFhmQVQ2bExTZE9DMWdVdyswd0w0amdPUXp3aVArd2c4djlVV0FjMjNi?=
 =?utf-8?B?Q1gzbzVNKys1WFBBblNyTHlycWR5aVRTaDAxNWlnVDVZVU9EZlZRTGdISlI1?=
 =?utf-8?B?dzV6VGNDazgvbDRFdVBnYVNmeU9xM3h1M1BnYzNrY2Fvd05Ia2tNWkxab3Vv?=
 =?utf-8?B?cXd4OXR1c05QUXlKUFhxTHlLdFpYYktmMkh3SkVRajdFRC83aDlKME9tSTVt?=
 =?utf-8?B?Z1NQV2x5TEoxNTE4ckorcjcwbnI0TDR4bENUYWd5d2N0ZHRGYUY5NDRwMmhE?=
 =?utf-8?B?WFNIdGFJRzM4QndUTlJwSUZjYnVnMS9kZ1FSWENxclhSVmRCNW9tOFlYdmNU?=
 =?utf-8?B?cjcyR05naTRGbU1LeCtWUmRPV1hUS0h4bTdrQ2JuUFhseGdnSldVcG9PQmNv?=
 =?utf-8?B?b3ZqZG1jMkt4YlE0T252bG9kRm9oZWJUYngxSGxGOGwyazBLbkpTcUZmNmVV?=
 =?utf-8?B?UHJFL29yRUR5ZzBDUnExSFlnbmk1OW9ZYndBUWRBbnM1UmlobTZjR3VSNnFS?=
 =?utf-8?B?eEh0MHduNTBKNmJzbU5CZURObzdQSGlnUnovRVgxV1REVzJKby9OaU9rQXNR?=
 =?utf-8?B?amk3M0pGQVYrNmViOVhobnAxMUtlbXJWWlhIREswTkJOeFowTjdOM0RENEFv?=
 =?utf-8?Q?FyJ1QDvRJgaAd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1pVOXFLbzFnZVg3Q3VpUndqWjFyK0lsaEw4ZGtha2F2dkVlWm5Mbm5IYmgr?=
 =?utf-8?B?Z3BlMmFFdDZhb0dlQzNjMDlrUGhkNTJkT1RWNko2MFF5a3cvY3JtYzE4N3JN?=
 =?utf-8?B?VStqNnpaanZ4NmpUa0tPNzhPYmZYU2xzbzVPYnNweG5MQWVaVXpRZU9GOFFx?=
 =?utf-8?B?MzhZMlplSFdrMmJIN3RCMkZTSlpWZnZSeEJvK3UwbDE1d09xalQ0SUZIazJW?=
 =?utf-8?B?Y2hua3FZb2M3RWluZCtsc2p4d3FIOUZuMXR3VTcyWkgyaXBHTUxNRjRNalBF?=
 =?utf-8?B?b2hXSytIZldDazBwS1dYWkY4MlN0NlQ1R0FER1h2VVp5UFFsMVAzY3FCWmpl?=
 =?utf-8?B?TTRHY2FJWFB6cUlGcFoyK2IrWUdtS2pJdDJsZkFhNEUrb04ySUt6RVpMTkNI?=
 =?utf-8?B?VVBqMlF0MDhKRkRtS2lGNzlNYmdFZlhSVGR1eXVPd3E5MFV4MUU2akQ5MEtF?=
 =?utf-8?B?bDRTYjE2YVZOcS94SERlOUQ5OE5vR3JDZGVIVEVuUXp0TmMrRGJmbFFMTGpK?=
 =?utf-8?B?b2Q5KytHSEF5a3RpYXBkaEpVcjE4Q3BXU0lidHpUOVZWbkZHQ0RzN3ZldE55?=
 =?utf-8?B?M0hjQ2srQ3F6VTNPWkczNDc2dHZrUWN4bFhjQ3NnWmlaNWx2V0tsYVRGeGli?=
 =?utf-8?B?Sm5yLzI4c1VLN2JRNlYvN3VUSDlwZE40enlXY2pXOTJiYndoWW1uaFJYRmp1?=
 =?utf-8?B?WkZrTklFeWVMOXNwWldXMDRyd2FpdHZqcGJsYklZZFhhYm9aUm93YUgwczFY?=
 =?utf-8?B?MXMvQUlReC9sdng1OFI0c1VrTHFsZDg0UDh5Y1JkMFFJejY2d0p0Mmtjc0ha?=
 =?utf-8?B?dTg0cDA2S3VRSlllN0J6THpZM3RxNldkS1E0WTdtTWdRaUNJQWh0RktpbnlK?=
 =?utf-8?B?ejFvTTR5RTNXZzB1K3g0MjVJL0ZOZ3d1alFzRmFrdjk2RTVQSkhwYm1Hb1RU?=
 =?utf-8?B?K3N4djdQTi9pUlRjRzZBZS85VUplVlZORCtzM2pLZTNMS05yOVBCVTZEMGx5?=
 =?utf-8?B?SElQendQd3QzYmYyRFhJT0RyZjN3OWx4MkFPYVV2empsckUyYzRzODlQNWZM?=
 =?utf-8?B?dEZzK0drSHlkRkRpbDluUFU4TDN3SWQwZW9wVDFZQ0NuWWVkZlAwZUhHR0FB?=
 =?utf-8?B?Vmd1KzdtUjI1VmcvdWN0a0w5NzNHSFpwakI4QkJleHJIcG5OLzZKWDZDVjZ2?=
 =?utf-8?B?RGhjclgzSDZBcjBWS0VDSTgzVnM2Y2pXbzFLem5BNUltdGFNYm5kZzV4WUl1?=
 =?utf-8?B?dmp2NDA1dzlzYTdJeDdFcklGUm5pYUJzd0tJcXpHa3pyYy9RbEZwOHZ2cU9Y?=
 =?utf-8?B?c1crUDhPK2tSaWVWQ3gwSGQzME52eFgvMEI5MW8yRHRWSUg2WlIxL0I4L0lL?=
 =?utf-8?B?dG1TTkhQZUk0UlRNakZtMzVLNVVWM0cyalExYlg0MkNGWlNzSjBzVkNGVmVN?=
 =?utf-8?B?bFpSbnBuK2ZOdkFpT0hkK0k5NUU4YmFXcmJ3T0lpdlhveHdscmVtSU42SWRG?=
 =?utf-8?B?NWVCVE9RUnBoSGxMRG5rZ3BSamltRkl3bXg3b0tXWGV0Wm0rWjV5VnJZR211?=
 =?utf-8?B?a1lXQkgrdURWVTVOSUZtUDh2YjJJeVdDVlREZVYwL0RzbUZTWXVKNWpWbGxZ?=
 =?utf-8?B?L1hhMzFheVd4S1FkU0tzb0xuaFBBSnZ3TWkxTGhxcUkwR0lhQWNlcGpvWCs2?=
 =?utf-8?B?RWNjTmZpbThDemZVdWU3SVU3dW1YbmhXMkw2OTY5dmZUaXA0amJXZE1HbHdJ?=
 =?utf-8?B?aXQ0b25qMUVYNE56b2FxU1gwdWZRYW1oOWxiTEljVG5HNGhvczVRRHpJeUE4?=
 =?utf-8?B?V24rZDdKdWJuSUgrSSttYmUyMEZrUWN1RGJ5R0NRdnpUdFlFL29tSlZCYmdt?=
 =?utf-8?B?M2FmQUJaYkhtVHVpdlpCWnJwbXZzY0FpNUdMVUo4RkhXRWNQSUpSQzBkaGZY?=
 =?utf-8?B?RDZrZm1aTXdZVXlJemR5dmZISlJ6V3B5MHUvSTc0RW4zRVlnVGdrZHBtMHpT?=
 =?utf-8?B?VTBFSm1PRmRhRE9vaG1ITU9qdTd2YTQ4dkxUKzVFV0srRWpHbU1xZUQvZDZZ?=
 =?utf-8?B?dmErbGtaZEFzS2o0V01mby8zeC81UEdyTm9yTVlyUFhGWng0UStCYTFVQ25o?=
 =?utf-8?Q?uvRGNJajQPoE9ZcIoJu4hdvYl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd568fd-7d3b-4446-a685-08dd5178034a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:30:05.3220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74iC1eAco9xbOUp+08DO7yuZ5BNq9PIUhcpFKuNAO/1oZln3wnZoCei1Hjw3igG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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



On 2/20/2025 11:44 AM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, February 19, 2025 10:18 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
>> <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
>> Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>> parameter for SDMA reset synchronization
>>
>>
>>
>> On 2/20/2025 6:57 AM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Alex Deucher <alexdeucher@gmail.com>
>>>> Sent: Wednesday, February 19, 2025 6:09 PM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
>>>> gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu,
>> Jiadong
>>>> <Jiadong.Zhu@amd.com>
>>>> Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>>>> parameter for SDMA reset synchronization
>>>>
>>>> On Wed, Feb 19, 2025 at 3:29 PM Kim, Jonathan <Jonathan.Kim@amd.com>
>> wrote:
>>>>>
>>>>> [Public]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Sent: Wednesday, February 19, 2025 12:39 PM
>>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>;
>>>>>> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu, Jiadong
>>>>>> <Jiadong.Zhu@amd.com>
>>>>>> Subject: RE: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>>>>>> parameter for SDMA reset synchronization
>>>>>>
>>>>>> [Public]
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>>>>> Sent: Tuesday, February 18, 2025 12:42 PM
>>>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie)
>>>>>>> <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>>>> <Felix.Kuehling@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
>>>>>>> Subject: RE: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>>>>>>> parameter for SDMA reset synchronization
>>>>>>>
>>>>>>> [Public]
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>> Sent: Monday, February 17, 2025 10:36 PM
>>>>>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>>>>> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
>>>> Zhu,
>>>>>>>> Jiadong <Jiadong.Zhu@amd.com>
>>>>>>>> Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset
>>>>>>>> caller parameter for SDMA reset synchronization
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/13/2025 11:17 AM, jesse.zhang@amd.com wrote:
>>>>>>>>> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>>>>>>>>>
>>>>>>>>> This commit introduces a caller parameter to the
>>>>>>>>> amdgpu_sdma_reset_instance
>>>>>>>> function to differentiate
>>>>>>>>> between reset requests originating from the KGD and KFD.
>>>>>>>>> This change ensures proper synchronization between KGD and KFD
>>>>>>>>> during SDMA
>>>>>>>> resets.
>>>>>>>>>
>>>>>>>>> If the caller is KFD, the function now acquires and releases the
>>>>>>>>> scheduler lock
>>>>>>>> (ring->sched.job_list_lock)
>>>>>>>>> to protect the SDMA queue during the reset.
>>>>>>>>>
>>>>>>>>> These changes prevent race conditions and ensure safe SDMA reset
>>>>>>>>> operations when initiated by KFD, improving system stability and reliability.
>>>>>>>>>
>>>>>>>>> V2: replace the ring_lock with the existed the scheduler
>>>>>>>>>     locks for the queues (ring->sched) on the sdma engine.(Alex)
>>>>>>>>>
>>>>>>>>> v3: call drm_sched_wqueue_stop() rather than job_list_lock.
>>>>>>>>>     If a GPU ring reset was already initiated for one ring at
>>>>>> amdgpu_job_timedout,
>>>>>>>>>     skip resetting that ring and call drm_sched_wqueue_stop()
>>>>>>>>>     for the other rings (Alex)
>>>>>>>>>
>>>>>>>>>    replace  the common lock (sdma_reset_lock) with DQM lock to
>>>>>>>>>    to resolve reset races between the two driver sections during KFD
>>>>>>>>> eviction.(Jon)
>>>>>>>>>
>>>>>>>>>    Rename the caller to Reset_src and
>>>>>>>>>    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to
>>>>>>>> AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
>>>>>>>>> v4: restart the wqueue if the reset was successful,
>>>>>>>>>     or fall back to a full adapter reset. (Alex)
>>>>>>>>>
>>>>>>>>>    move definition of reset source to enumeration
>>>> AMDGPU_RESET_SRCS,
>>>>>>> and
>>>>>>>>>    check reset src in amdgpu_sdma_reset_instance (Jon)
>>>>>>>>>
>>>>>>>>> v5: Call amdgpu_amdkfd_suspend/resume at the start/end of reset
>>>>>>>>> function
>>>>>>>> respectively under !SRC_HWS
>>>>>>>>>     conditions only (Jon)
>>>>>>>>>
>>>>>>>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>>>>>> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
>>>>>>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>>>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 65
>>>>>>>>> ++++++++++++++++++++---
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>> |
>>>>>>>>> 6 +--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +--
>>>>>>>>>  4 files changed, 67 insertions(+), 14 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>> index 4d9b9701139b..5b86e12ff9fe 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>> @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
>>>>>>>>>     AMDGPU_RESET_SRC_MES,
>>>>>>>>>     AMDGPU_RESET_SRC_HWS,
>>>>>>>>>     AMDGPU_RESET_SRC_USER,
>>>>>>>>> +   AMDGPU_RESET_SRC_SDMA_RING,
>>>>>>>>> +   AMDGPU_RESET_SRC_SDMA_HWS,
>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>>  struct amdgpu_reset_context {
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>>>> index fe39198307ec..808c7112ef10 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>  #include "amdgpu.h"
>>>>>>>>>  #include "amdgpu_sdma.h"
>>>>>>>>>  #include "amdgpu_ras.h"
>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>
>>>>>>>>>  #define AMDGPU_CSA_SDMA_SIZE 64
>>>>>>>>>  /* SDMA CSA reside in the 3rd page of CSA */ @@ -485,6 +486,7 @@
>>>>>>>>> void amdgpu_sdma_register_on_reset_callbacks(struct
>>>>>>>> amdgpu_device *adev, struct
>>>>>>>>>   * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
>>>>>>>>>   * @adev: Pointer to the AMDGPU device
>>>>>>>>>   * @instance_id: ID of the SDMA engine instance to reset
>>>>>>>>> + * @src: The source of reset function (KGD or KFD)
>>>>>>>>>   *
>>>>>>>>>   * This function performs the following steps:
>>>>>>>>>   * 1. Calls all registered pre_reset callbacks to allow KFD and
>>>>>>>>> AMDGPU to save
>>>>>>>> their state.
>>>>>>>>> @@ -493,20 +495,49 @@ void
>>>>>>>>> amdgpu_sdma_register_on_reset_callbacks(struct
>>>>>>>> amdgpu_device *adev, struct
>>>>>>>>>   *
>>>>>>>>>   * Returns: 0 on success, or a negative error code on failure.
>>>>>>>>>   */
>>>>>>>>> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>>>> instance_id)
>>>>>>>>> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>>>> instance_id, int src)
>>>>>>>>>  {
>>>>>>>>>     struct sdma_on_reset_funcs *funcs;
>>>>>>>>> -   int ret;
>>>>>>>>> +   int ret = 0;
>>>>>>>>> +   struct amdgpu_sdma_instance *sdma_instance = &adev-
>>>>>>>>> sdma.instance[instance_id];;
>>>>>>>>> +   struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>>>>>>>>> +   struct amdgpu_ring *page_ring = &sdma_instance->page;
>>>>>>>>> +   bool gfx_sched_stopped = false, page_sched_stopped = false;
>>>>>>>>> +
>>>>>>>>> +   /* Check if the reset source is valid for SDMA ring reset */
>>>>>>>>> +   if (src != AMDGPU_RESET_SRC_SDMA_RING && src !=
>>>>>>>> AMDGPU_RESET_SRC_HWS)
>>>>>>>>> +           return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +   /* Suspend KFD if the reset source is not SDMA_HWS.
>>>>>>>>> +    * prevent the destruction of in-flight healthy user queue packets and
>>>>>>>>> +    * avoid race conditions between KFD and KGD during the reset
>>>> process.
>>>>>>>>> +    */
>>>>>>>>> +   if (src != AMDGPU_RESET_SRC_SDMA_HWS)
>>>>>>>>> +           amdgpu_amdkfd_suspend(adev, false);
>>>>>>>>
>>>>>>>> It this has to be done here, what's the idea behind registering a
>>>>>>>> separate pre/post callback for KFD initiated resets?
>>>>>>>
>>>>>>> The problem is that for SDMA v5.x and below, a single soft reset call will reset
>>>> all
>>>>>>> queues on the target SDMA engine.
>>>>>>> If the KGD calls the reset, a transient KFD suspend/resume around the reset
>>>> will
>>>>>>> guarantee that healthy user queues survive the reset.
>>>>>>> If the KFD calls the reset, it will only do so during preemption failure, and we
>>>> don't
>>>>>>> want to suspend and resume the KFD again when the KFD calls this function.
>>>>>>> The KFD needs to call this common function to not disturb GFX and paging
>>>> queues
>>>>>>> for the same reason KGD resets need to be wary of KFD queues.
>>>>>>> In the case of preemption failure and a KFD initiated reset, the KFD is holding
>>>> the
>>>>>>> device wide preemption lock, so if the KGD is trying to reset as well, it will
>> have
>>>> to
>>>>>>> wait on its own KFD suspend call until the KFD is done its own reset.
>>>>>>>
>>>>>>> I think SDMA6+ can target specific queues via MMIO reg writes, but I see in
>>>> the
>>>>>>> KGD code that soft_reset for SDMA 6+ does a sweep of all engines so we
>>>> would
>>>>>>> still need to keep KFD queues safe (I'm not familiar with this chunk of the
>> code
>>>> or
>>>>>>> the need for sweeping all engines on the KGD side).
>>>>>>> So I'm not sure if Jesse had concerns about potential multiple calls being
>> made
>>>> in
>>>>>>> other parts of the code and maybe this was some way to simplify things.
>>>>>>> Either way, not sure if it's simpler to drop the reset source param and have
>> the
>>>>>> KGD
>>>>>>> remember to unconditionally KFD suspend/resume around the soft reset call
>>>> for
>>>>>>> each IP version, or keep the reset source param here so that we only have to
>>>>>>> remember to do this once.
>>>>>>
>>>>>> Could KFD keep track of whether the hang was detected by KFD or KGD?
>> E.g.,
>>>> if
>>>>>> KFD detects the hang when suspending queues, it could set a flag and then
>> KFD
>>>>>> could include a call to amdgpu_amdkfd_suspend() in its pre_reset callback that
>>>>>> would depend on the value of that flag.  At that point I don't think we'd need the
>>>> src
>>>>>> parameter any more.
>>>>>
>>>>> Hmmm.  Something similar to GPU resets?
>>>>> The thing about GPU resets is that the KFD could just detect the flag, schedule
>> an
>>>> event then carry on knowing the driver is going to die and re-init at some point.
>>>>> SDMA resets are different because the KFD would call back into the common
>> KGD
>>>> call immediately because it wants to fix things right away, and the KGD has to
>> ensure
>>>> the KFD is quiesced in any case.
>>>>> So any flag would have to be locked as well in the KFD pre/post calls.   Which
>>>> means we'd probably have to conditionally lock it based on a new reset context
>> that
>>>> the KGD would have to supply anyways.
>>>>> This was the main reason why I wanted to simplify things by leveraging a
>>>> conditional suspend/resume call in the common interface.
>>>>> Maybe I'm not looking at things clearly atm, but if feels like we're pushing the
>>>> complication from one part of the driver into another.
>>>>>
>>>>> If we really don't like the idea of adding flags, maybe we can just add a param
>> "bool
>>>> suspend_user_queues" to the common interface?
>>>>> Then maybe it's clearer that the KGD, as a reset requester, wants to be careful
>> of
>>>> destroying in-flight user queues while the KFD doesn't care about this for its own
>>>> needs (since it's already in post-preemption recovery).
>>>>>
>>>>
>>>> Having the src for a parameter is fine with me.  It just seemed
>>>> logical to keep it in KFD since presumably KFD would have detected
>>>> this condition after calling amdgpu_amdkfd_suspend() itself so it
>>>> would know whether it would need to be called based on its own state
>>>> so it would know what to do in its pre and post reset hooks already.
>>>
>>> The case of successful KFD suspend during reset isn't really a concern since the
>> KFD cannot get into a preemption failure at this point.
>>> It's the corner case when the KFD suspend fails on a KGD initiated reset because
>> of a user queue hang and KFD has to reset through the KGD call again.
>>> In this case, KFD suspend from the KGD initiated reset is in limbo and this initial
>> suspend call is holding the lock for all KFD processes.
>>> The KGD is still forced to pass some sort of SDMA reset trigger hint to the KFD
>> when it calls suspend (or pre-reset) for this corner case.
>>> Otherwise, the KFD will deadlock on the on its own recall of the reset function
>> when it hits the KFD processes lock again during kgd2kfd_suspend.
>>> So we're stuck either way with the KGD still having to pass something to the KFD
>> (new reset context, bool, flag hint etc ...) if we want to avoid this deadlock.
>>>
>>
>> The reason why I asked about making use of pre-reset KFD callback is -
>>
>> Ideally, this is a reset of one instance of SDMA instance (even though
>> it's termed as queue reset). What amdgpu_amdkfd_suspend() is doing seem
>> to affect all processes running on all instances. Basically on a system
>> with 8 or 16 SDMA instances, this is not really making sense if it's
>> going to affect all other processes.
> 
> F32 HWS devices quiesce the entire device on runlist update anyways so I don't really see any performance savings there.
> RS64 HWS devices per-queue remove/suspend but that means save/restore is overall more efficient anyways.
> The KFD will have to quiesce the device prior to queue reset on RS64 HWS devices via the MES suspend_all call as well because the KFD doesn't know the cause of an MES hang apriori regardless of the queue on remove_queue request.
> "Not really making sense" only "doesn't really make sense" if there's a strict performance requirement for reset handling.
> What's the benchmark requirement here?
> If there isn't one, then having the KGD do new reset_context baton pass in pre-reset to a new KFD suspend/resume to filter suspend by SW queues by assigned engine id, then locking out all processes from doing a KFD queue creation on the targeted engine (because we'd have to prevent user space from creating new queues that could enqueue that engine during reset) before we do a reset seems not only like a huge waste of time but potentially creates an explosion of more corner cases to deal with.
> So a single bool param here to trigger conditional device quiescence that temporarily locks out KFD activity during reset for safety, though crude and simple, seems reasonable enough to get the job done.
> If there is a target reset handling benchmark that I don't know about (and I'd be curious to know about it ... and optimization again would probably only apply to RS64 HWS devices ...), then maybe doing an engine id filter is a follow-on scope to consider.
> 

My thinking is -

Doing a targeted queue or engine reset doesn't affect other processes
which are not making use of the queue or engine (a similar thing is done
during poison consumption on some SOCs where only the affected processes
get unmapped leaving other running processes unaffected). This may have
more significance when there are multiple partitions on the device. I
guess F32 HWS in co-operative dispatch mode also just affects the
particular partition and not the entire device.

Engine/Queue reset is comparatively faster than doing a device-wide reset.

Alex may be able to provide better details.

Thanks,
Lijo

> Jon
>>
>> Is that really required? Or, is it like KFD can identify the processes
>> using the user queues of that particular instance (pre-reset passes
>> instance) and only suspend them?
>>
>> Thanks,
>> Lijo
>>
>>>> I guess we also stop the kernel queues explicitly in the same function
>>>> so it makes sense to do the same for KFD.
>>>
>>> Yep.  We definitely want to minimize reset damage from either caller (KFD or
>> KGD).
>>> I kind of look at it like the rest of the amdgpu_device_reset/suspend/resume calls
>> that need to consider the KFD as well.
>>> I think I'm fine with just passing a bool suspend_user_queues here to do the
>> conditional KFD suspend/resume instead of coming up with new reset source
>> context(s).
>>> That way we don't have to force callers to use extra long strings in their calls that
>> have no use anywhere else.
>>> They can just pass true/false according to their needs.
>>>
>>> With that fixed, this patch is:
>>> Acked-by: Jonathan Kim <jonathan.kim@amd.com>
>>>
>>> Jon
>>>
>>>>
>>>> Alex
>>>>
>>>>> Jon
>>>>>
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Jon
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +   /* Stop the scheduler's work queue for the GFX and page rings if
>>>>>>>>> + they are
>>>>>>>> running.
>>>>>>>>> +   * This ensures that no new tasks are submitted to the queues while
>>>>>>>>> +   * the reset is in progress.
>>>>>>>>> +   */
>>>>>>>>> +   if (!amdgpu_ring_sched_ready(gfx_ring)) {
>>>>>>>>> +           drm_sched_wqueue_stop(&gfx_ring->sched);
>>>>>>>>> +           gfx_sched_stopped = true;;
>>>>>>>>> +   }
>>>>>>>>> +
>>>>>>>>> +   if (adev->sdma.has_page_queue
>>>>>>>> && !amdgpu_ring_sched_ready(page_ring)) {
>>>>>>>>> +           drm_sched_wqueue_stop(&page_ring->sched);
>>>>>>>>> +           page_sched_stopped = true;
>>>>>>>>> +   }
>>>>>>>>>
>>>>>>>>>     /* Invoke all registered pre_reset callbacks */
>>>>>>>>>     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>>>>>>>>>             if (funcs->pre_reset) {
>>>>>>>>> -                   ret = funcs->pre_reset(adev, instance_id);
>>>>>>>>> +                   ret = funcs->pre_reset(adev, instance_id, src);
>>>>>>>>>                     if (ret) {
>>>>>>>>>                             dev_err(adev->dev,
>>>>>>>>>                             "beforeReset callback failed for instance %u: %d\n",
>>>>>>>>>                                     instance_id, ret);
>>>>>>>>> -                           return ret;
>>>>>>>>> +                           goto exit;
>>>>>>>>>                     }
>>>>>>>>>             }
>>>>>>>>>     }
>>>>>>>>> @@ -515,21 +546,39 @@ int amdgpu_sdma_reset_engine(struct
>>>>>>>>> amdgpu_device
>>>>>>>> *adev, uint32_t instance_id)
>>>>>>>>>     ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>>>>>>>>>     if (ret) {
>>>>>>>>>             dev_err(adev->dev, "Failed to reset SDMA instance %u\n",
>>>>>>>> instance_id);
>>>>>>>>> -           return ret;
>>>>>>>>> +           goto exit;
>>>>>>>>>     }
>>>>>>>>>
>>>>>>>>>     /* Invoke all registered post_reset callbacks */
>>>>>>>>>     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>>>>>>>>>             if (funcs->post_reset) {
>>>>>>>>> -                   ret = funcs->post_reset(adev, instance_id);
>>>>>>>>> +                   ret = funcs->post_reset(adev, instance_id, src);
>>>>>>>>>                     if (ret) {
>>>>>>>>>                             dev_err(adev->dev,
>>>>>>>>>                             "afterReset callback failed for instance %u: %d\n",
>>>>>>>>>                                     instance_id, ret);
>>>>>>>>> -                           return ret;
>>>>>>>>> +                           goto exit;
>>>>>>>>>                     }
>>>>>>>>>             }
>>>>>>>>>     }
>>>>>>>>>
>>>>>>>>> -   return 0;
>>>>>>>>> +exit:
>>>>>>>>> +   /* Restart the scheduler's work queue for the GFX and page rings
>>>>>>>>> +    * if they were stopped by this function. This allows new tasks
>>>>>>>>> +    * to be submitted to the queues after the reset is complete.
>>>>>>>>> +    */
>>>>>>>>> +   if (ret) {
>>>>>>>>> +           if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
>>>>>>>>> +                   drm_sched_wqueue_start(&gfx_ring->sched);
>>>>>>>>> +           }
>>>>>>>>> +           if (page_sched_stopped &&
>>>> amdgpu_ring_sched_ready(page_ring)) {
>>>>>>>>> +                   drm_sched_wqueue_start(&page_ring->sched);
>>>>>>>>> +           }
>>>>>>>>> +   }
>>>>>>>>> +
>>>>>>>>> +   /* Resume KFD if the reset source is not SDMA_HWS */
>>>>>>>>> +   if (src != AMDGPU_RESET_SRC_SDMA_HWS)
>>>>>>>>> +           amdgpu_amdkfd_resume(adev, false);
>>>>>>>>> +
>>>>>>>>> +       return ret;
>>>>>>>>>  }
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>>>> index f91d75848557..2ef2da772254 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>>>> @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {  };
>>>>>>>>>
>>>>>>>>>  struct sdma_on_reset_funcs {
>>>>>>>>> -   int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
>>>>>>>>> -   int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
>>>>>>>>> +   int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id, int
>>>> src);
>>>>>>>>> +   int (*post_reset)(struct amdgpu_device *adev, uint32_t
>>>>>>>>> + instance_id, int src);
>>>>>>>>>     /* Linked list node to store this structure in a list; */
>>>>>>>>>     struct list_head list;
>>>>>>>>>  };
>>>>>>>>> @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {  };
>>>>>>>>>
>>>>>>>>>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device
>>>>>>>>> *adev,
>>>>>>>> struct sdma_on_reset_funcs *funcs);
>>>>>>>>> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>>>> instance_id);
>>>>>>>>> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>>>> instance_id, int src);
>>>>>>>>>
>>>>>>>>>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)-
>>>>>>>>> mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>>>>>>>>>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b)
>>>>>>>>> (adev)->mman.buffer_funcs- emit_fill_buffer((ib), (s), (d), (b))
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>>>> index 29a123be90b7..50a086264792 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>>>  #include "amdgpu_xcp.h"
>>>>>>>>>  #include "amdgpu_ucode.h"
>>>>>>>>>  #include "amdgpu_trace.h"
>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>
>>>>>>>>>  #include "sdma/sdma_4_4_2_offset.h"
>>>>>>>>>  #include "sdma/sdma_4_4_2_sh_mask.h"
>>>>>>>>> @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct
>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>     if (r)
>>>>>>>>>             return r;
>>>>>>>>>     INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
>>>>>>>>> +
>>>>>>>>>     return r;
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct
>>>>>>>> amdgpu_ring *ring, unsigned int vmid)
>>>>>>>>>  {
>>>>>>>>>     struct amdgpu_device *adev = ring->adev;
>>>>>>>>>     u32 id = GET_INST(SDMA0, ring->me);
>>>>>>>>> -   return amdgpu_sdma_reset_engine(adev, id);
>>>>>>>>> +   return amdgpu_sdma_reset_engine(adev, id,
>>>>>>>> AMDGPU_RESET_SRC_SDMA_RING);
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev,
>>>>>>>>> uint32_t
>>>>>>>> instance_id)
>>>>>>>>> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev,
>>>>>>>>> +uint32_t
>>>>>>>> instance_id, int src)
>>>>>>>>>  {
>>>>>>>>>     u32 inst_mask;
>>>>>>>>>     struct amdgpu_ring *ring =
>>>>>>>>> &adev->sdma.instance[instance_id].ring;
>>>>>>>>> @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct
>>>>>>>> amdgpu_device *adev, uint32_t instance_
>>>>>>>>>     return 0;
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev,
>>>>>>>>> uint32_t
>>>>>>>> instance_id)
>>>>>>>>> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev,
>>>>>>>>> +uint32_t
>>>>>>>> instance_id, int src)
>>>>>>>>>  {
>>>>>>>>>     int i;
>>>>>>>>>     u32 inst_mask;
>>>>>>>
>>>>>>
>>>>>
> 

