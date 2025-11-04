Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81058CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F154810E28B;
	Tue,  4 Nov 2025 15:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKqkV5+z";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED12910E28B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj3N5J66eZPKfXpd1k7Id6oB+a0USy0dUv8QGKE6+grsa3HZUcpbu5zNTeI19+0+RMc3m/xhGAw69upV7LxDxchQl6uVDa9gTo+9HIaFJv/JlQ+u4Xwc5b7FLWlKeSiGy7thDRlJ1ZtTKuFJnEWAecvm0UGJ7NL2K0S/6nOZ4aNg0QjcciLQQ3etdS3UPGpJBhLIg3jEOBzu2pH9QhykUpPJ8ts3Ya14Hvjns30DPKDpKGk6eSRVR9k9HkHem8vVtrm4LWoyGp6A7L6tQnAhWh1NOxjIafsgb/uEZQ4Hou/FR+H3s4M3mgUjOkNjqgeQNQ1xVwuS/nFF0f9Wt5oAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAW1ez5yfYY9zLE/Y8InY1dOdLoy8LwQJbkqd9NaVzA=;
 b=cziQZjNbaXarBXhVLbpVlJUzbXw4OaJSSyCzik26ItyoF6A2X62yeIyJBRIxhTaPC3nW3FCB7gTPu+IpzBafJG3ORFcdaJaqzMDfWVZsERh/gO7dY2Hm6S65Y8sK3g7zjEJ4czkvzb7J3hokvjHMtSH1C3gO/Wo7XRNsMcfjbx3Se1t5ISslsBxAgSCVQIHuzfXSB1PD1xVghGdgrEDXwGO3c2/8qccV8Zz5flzs0vmMCxhSUCpEAxUEjviouualHfM9kCYbAIKciNt30THZKJT24VPm/hCraClFiT+CHrCRwLpkPWXGf/SCnS+xHhJ5m5hGsimiADc7MPKuKuT7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAW1ez5yfYY9zLE/Y8InY1dOdLoy8LwQJbkqd9NaVzA=;
 b=AKqkV5+zXBR1f4tMwyoh/B5pPIUcnsm7649Trw2+gydt9VMk4YkElgG6cT/LmraB7GdEMoY3O2R6r3+lYgrmSWeMIwwiAC2Jed6+tWjb+u5Cg3uI2VUwQXxJd/S5Hl1WA9tGImjLxPL8CTVZI8v8PgzHmG8iVzE3rWKMdNp8F+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:24:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:24:23 +0000
Message-ID: <88849efb-f9a5-472b-8eab-929e0e1abf62@amd.com>
Date: Tue, 4 Nov 2025 16:24:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-2-timur.kristof@gmail.com>
 <9b4daf2b-d97d-4b3d-bd7b-3b136a4e304c@amd.com>
 <237b5110-bf9b-452a-ab51-51ca67f7589d@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <237b5110-bf9b-452a-ab51-51ca67f7589d@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:408:142::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 409edb55-60f5-420b-231e-08de1bb63bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWpCZjR0cWtlcDJZQmphUEVIQUdPeWVMeXlTenhER25Jck05NzR5ajBwTTN6?=
 =?utf-8?B?d2JqSE85bXJiamZpTjNOUERSVHI2ZkpKaHcxc1RaYVFKS3c2ZW8wV3QzWEMv?=
 =?utf-8?B?K250MnlOMEMwYXhFOU1ZS2FpdHQ2TGZidWFFZ2hqRnFYUFhycG15VDJHKzBs?=
 =?utf-8?B?WDJuQ1MrK1A2SWFYK0lhbExHTWViOU9zK0Q4cU1hN0VNczBSRS8zSDIzeWd0?=
 =?utf-8?B?T3cySVJ3b3NwSVNoZFlNUzZiZVpHQ1d5VVVGOHB2MTJCSk1xWktxVU1sdXc4?=
 =?utf-8?B?SkhiRjg5bG1nRHk1a3MzWU9vVlphTHk3MEVQWWZxNUhraTFJMHZXVC9laUc1?=
 =?utf-8?B?cnVhRFNxTks5ejJNZHMyZk9YK2JKRjRpb3hsM3QvdE52Z3pNMk1DaWplWU82?=
 =?utf-8?B?K0h4WTJhUGEwK2EwclFxQ2JKV3hoOGxvVXRURU5CYkwxNGxFYnJCVmcrT3Br?=
 =?utf-8?B?MFpYVkE0RHB0Q1BQUDE5MnZiN2RyUDNmUWpkWXZ4ZEZjc1FOK2RCL05aYSs0?=
 =?utf-8?B?TEhLL1JFMGw3cnFoaVZPenV1VE1VRlBIbWFXMHRMeHpVSjhMQ3Ezblh3cVdD?=
 =?utf-8?B?Z1F2cnVFVW96R2J0bjAxTGYvTkFOK3k4Vys4VlZmdVZPUTdrR05RTlJVcm9V?=
 =?utf-8?B?cEhlOE5jV1M5bHplNjA4ZHJaVENOdmhmQWpSUER5WXczd0t2M1NnbklOSDda?=
 =?utf-8?B?Nk4yTWgzUnJTb1hOeXZxV1BxSEV6LzNYanhNeCtSRjVDVGdQTzhVMW0zekpU?=
 =?utf-8?B?RXVjOEZoL3BzTUlZQ0VFREhLblJjakVqN1lFMk1qeVdKRkNOb1BKanR4MmZ6?=
 =?utf-8?B?Wi85MGJjQjgwK0UrdVZQbDhsMHNuaE4vUmxJdXVMMkxZZmhQUXc4N2NRQk03?=
 =?utf-8?B?NXJIU2JOMURsMkhkQjJ5RjZDYlF0aURsSUVlTUFKUlA4K3ZxTnZpRDdsWmRY?=
 =?utf-8?B?Z1FRTlF3a051aEMrOW1OdFdXUVBudTFGVXhTSlA3ckVxenZIeXZ4UHFvQW84?=
 =?utf-8?B?QVdGTzJHUmJCaVdrMkttM1NDVkFqakgxazhmcWtjblovNmM4OGV2dWxESXlT?=
 =?utf-8?B?VDFHNng0dGpSZE4yeHlqbFdtSlpaZUZ5ekYxR21PcS9vT0hXOE8wcGIzdUtU?=
 =?utf-8?B?UjdLenpmVGxRb1Y4RDdSQkNNTjc5Z05ycnJkam5DbEswR0NkUFFLZE0yMzFs?=
 =?utf-8?B?SFZXdXgrNlpCQnVocE0zOGs5UlA3TFJsdnpKcWRodTZtMXh5OXAra1FvcEp1?=
 =?utf-8?B?enpPcGlYVnlqNFZFUXNDcTJ6WHExSnkydzRLbFJrNGN3Tm5RZmVIL3lIL3N6?=
 =?utf-8?B?UXZrcGs5Qnl2RERoM3ZJSkJDc1V5eTNiM0R5WEk5ZkJqM3MvRStjeUpNMktl?=
 =?utf-8?B?Z3loaTBHWGowNTlVaGdBQStUaStPcGZob1ZWWTdoQWtBTjFqYlkvcThRR3pG?=
 =?utf-8?B?U21ITStaTFV0S1drK1lWSlBoeFRMSkx6emk4akZBazZVVVRQTWl6eGx1Smhs?=
 =?utf-8?B?UE1MRzVKNHc3YUVndEw2NmxCQnoyVHRhSWwybFpDNnR6K3dZdTdVcHhscWp3?=
 =?utf-8?B?cTZRbkt1Zkk0WWNTbHdTZXZhVENCUDZTck9wSWN1SnJnYitpcmpWQWFHRk92?=
 =?utf-8?B?cEpoZkpQSnZRZW1YZUhleCtFMTZEam1kVzVCZFlDdWs0NmNuR1g3SEd3U1lS?=
 =?utf-8?B?M2Q2bEFZM052Qm1RNzhSbHVhS0JOK2hKellHdkpqaW5obHlPam9WY3pQZVpt?=
 =?utf-8?B?cnZVWlFRYWNhTHg3Z3VkcGRBWE1MY0tKZDE0dFdmV0ZUZVVQWDZNanAvR2Nx?=
 =?utf-8?B?eCtvWXZESXo3NnNNTk1MZng0YVJ2S0YxYlJwc21ndUJ6V0xsZ01zNlBhQmtH?=
 =?utf-8?B?M1l0N0p5NHVuSGQ2WkU3Q0hWd2o4TTNJendEN2wvMVFXcUFycWl1Wmc3S01t?=
 =?utf-8?Q?uT3kULXKnHFvDxYYRPgiZ8kdJKipA/NR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBWUG5hdGJrOFE4T0toZGpqNmFtblptYW42SzlVUDZJeFBiRXl3WXp4OHBp?=
 =?utf-8?B?SmMvQ3BjcTlRUUZVR2dCd3NLWlgxemN6L1JxLy9PWFpiQWhHdnN5VmhRd214?=
 =?utf-8?B?RXZTcnkydHBWc3JEck1TL0ZUbW5nTlJVaWdjeW9OVkI5M3Y4RU1NYUNRelBl?=
 =?utf-8?B?ZUk0VnRqYk4reUJKMGZkWHBVaW9CMFVtVFByN0dWc2E4Zm1XdVE0QVZ3R3Mx?=
 =?utf-8?B?L3U4d3FnOTZqSCtvRGhON09wMkhnM3A2RjNtU0paSmZtMmF2K3h1Z2NWdUxs?=
 =?utf-8?B?em1DZDdJR3JPNVROelVoUUU1QzZLN0Q1YWJOMi9CODZQMzF0K0owcVFQdHlC?=
 =?utf-8?B?YUxZSkxJcUFPbnNIUjZHajZpRmRTLzhxWEIyUGZ0cFJuSEZ1SFVJQVpUa3Rv?=
 =?utf-8?B?djExVFk3MEFoVFZ4ZU9WeU02ajZqYlRBdkt1YzlYTWsrWFhLUFNPbUhlZXRa?=
 =?utf-8?B?N3diSWZ1VDJxVmZjYzFUVjBXNUh3bzJaY1R6UXRkQ2Q0WE95NnNuQURWNmtU?=
 =?utf-8?B?MktRbXhQaFVpdHI5eDZST2YwV3VLazRGVFIrblVJa3VQWUgvMmJmN3c1UXdq?=
 =?utf-8?B?b2tyM1UvVkFmRlBSMjN5M0lDM0I4aFRKL1ExczF5K3ZEWFJKOE8rOHJ4b3ZC?=
 =?utf-8?B?NG5OSDdwNUNDZ2V3S2VYYk1ndkY1WFEvK0hDb0xLV3pwYm10RC9zQXVVSnFG?=
 =?utf-8?B?Rk5yZzlvTTVubkw5SnhLV1UyUGkvWEFUZTJQVDJPQ28xbDlJNVhCMmQ5NE03?=
 =?utf-8?B?R1V3ZksxMElOY3pzMGtaRGxkNWhWVFdLdGhFVDhma1gvNGM2MkpxeWZ5NjRZ?=
 =?utf-8?B?MnVlOEJ0M2dIM2ZIY05uOFVYMGhIWks5K29hQnlWS2J1QU5sRG9XV29mTTRS?=
 =?utf-8?B?bC9wdjR6dmpPTm50TWpQZS9Qd0tGOWpIMG81RG5JU2dGODdRM1VNT29rK2du?=
 =?utf-8?B?TEQyUXFlQzNLWUo5WlN5Wml4NWdqTGNoRXBuc1hBVGM3YmMxWjhaZXpzMWJK?=
 =?utf-8?B?MlRrODl3NVg3eEgrZ0dKQ3MvQjlqKzAvbTNTaXRCdUkyREJocTZZZnErUi82?=
 =?utf-8?B?c095a1E4ZHpvekFETnIyWmlneXg2K0VmOTUxSFlEOUJEa2NHTzRyVHlGWFNE?=
 =?utf-8?B?bVNwNEFDQTRxcG5NcXZ0YXJrbWtlZVhDSFNFc3ZyZ1NuNjJ0eDNSZkJxQWR4?=
 =?utf-8?B?Z0xRWGpSak5VcGRqd29KZ2hOZno5bkhvbzhqNGp2VHlBMit1RXQxRjFPalEx?=
 =?utf-8?B?RnEwZitLK2oxVFY5Znd5QXFPQ1VuU0xzWVNzY09Wa29ERzNXbksraW0wQWRa?=
 =?utf-8?B?RGZOdlZ6dGVrRThTcWNLc0QvTlg1dFozV3F2MXN2Mkd3T2ppS0JmWDBhQnJx?=
 =?utf-8?B?bmJiTnplcnJFb28zSUpCT1AvOTN2WndBVmpkdnYybEhsN0hHZlBJWUFVYUZ5?=
 =?utf-8?B?a2lheDBhWlRocVlsMU94ekh0RkxXem10TUlaaGhPeWQzb0VJRGJBYkwyanRY?=
 =?utf-8?B?OTg1ajRXcjNyenNIeG5WYXJISGp2emdJYWo0WVo0b2RhL28rSjNrOTNQYlFI?=
 =?utf-8?B?Q2tET01RaHRTMUFSOUJJc1lyaUlURVpxSVRyOU5ZWklvQ051bmVUQXBhd00w?=
 =?utf-8?B?QXNGZzA2OXNwYkhjQjZyK2dCTHFUdTlHOXpmTEl3cEg0K0YyeWVFalNBa1pH?=
 =?utf-8?B?TmNpb2RXK01OcjN3TjFNVVVJNlgxU0JxSElVSGtzRjc2VUx5d09oSGxlV1FM?=
 =?utf-8?B?RjBjN3pXYXdRdmsrL0pqd2EwWUlTaHZrUHlhNUZtU1JTUUVnNi9lSUtVeXhC?=
 =?utf-8?B?b05qd0UvcVJ5eit1WmZ2NXl4UDdjUnprbWZTZ2pSZzB5Um0yRzg2NzJjSzZq?=
 =?utf-8?B?bkY4eFE1ZGMwZnVpUWVZcGp0b2NxWU9LM01sajdmTkl5SFZlZjcxSzhjNXpR?=
 =?utf-8?B?YmJRR1I2TGwyK25xcmxoWmxiWUFZWGNXVU9sdENPR0F1N3p4Z1lQTDlQU0JL?=
 =?utf-8?B?WFhDcGxVdjBtSnRmWFNzWEpzSURicVVJR2hCc0xXR0RQMTV4QlkxdWJsTkJr?=
 =?utf-8?B?MlBSaUVPY0l0SmNCNW15c2NsY3NROFg4ZndubkkxVzRUaXI5c2RXOVRWN254?=
 =?utf-8?Q?192cqFay8K9iR2bwMVykCYh9i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409edb55-60f5-420b-231e-08de1bb63bec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:24:23.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAcTuHN9Em8BBJWujF94uoEUbgF8GlbFosYdtudR4aCyda6GeCEm+7C3r3C5+/8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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

On 11/4/25 16:08, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 04/11/2025 à 14:23, Christian König a écrit :
>>
>>
>> On 11/3/25 23:23, Timur Kristóf wrote:
>>> GART contains some pages in its address space that come before
>>> the GTT and are used for BO copies.
>>>
>>> Instead of hardcoding the size of the GART space before GTT,
>>> make it a field in the amdgpu_gmc struct. This allows us to map
>>> more things in GART before GTT.
>>>
>>> Split this into a separate patch to make it easier to bisect,
>>> in case there are any errors in the future.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 2 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
>>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index 97b562a79ea8..bf31bd022d6d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>>>           break;
>>>       }
>>>   +    mc->num_gart_pages_before_gtt =
>>> +        AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
>>>       mc->gart_start &= ~(four_gb - 1);
>>>       mc->gart_end = mc->gart_start + mc->gart_size - 1;
>>>       dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index 55097ca10738..568eed3eb557 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -266,6 +266,7 @@ struct amdgpu_gmc {
>>>       u64            fb_end;
>>>       unsigned        vram_width;
>>>       u64            real_vram_size;
>>> +    u32            num_gart_pages_before_gtt;
>>>       int            vram_mtrr;
>>>       u64                     mc_mask;
>>>       const struct firmware   *fw;    /* MC firmware */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> index 0760e70402ec..4c2563a70c2b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>>>         ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
>>>   -    start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
>>> +    start = adev->gmc.num_gart_pages_before_gtt;
>>
>> I would prefer that we have a single function which returns the number of GART pages we need before the dynamic GTT mapping.
>>
>> But let me see how Pierre-Eric solved this first.
>>
> 
> The only conflicting change with my series is that I changed this:
> 
> -    start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> +    start = AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;
> 
> So to account for Timur's change, I would only need to adapt this part:
> 
> +    mc->num_gart_pages_before_gtt =
> +        AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;

Where is reserved_windows comming from in this calculation?

Regards,
Christian.

> 
> Regards,
> Pierre-Eric
> 
> 
>> Regards,
>> Christian.
>>
>>>       size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
>>>       drm_mm_init(&mgr->mm, start, size);
>>>       spin_lock_init(&mgr->lock);

