Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8329D3E783
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 23:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C62D10E6A5;
	Wed, 10 Dec 2025 23:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5bNe+5V9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA1210E6A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 23:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2xRz8fc/BWmlNOuLeNpHPUTzG8Y42uFN6jG9FVytaXU7L2XprjqlQcE9p1+MzPOwVKucpn0KUC0Gqk4qdyeowahEldIuRIO8k56LKoW2a9dn9xiftrueFv/pQam4wN4pirhLA65cuEOx2gMa+xsuIY6sRlk75AcfUCbXlO06QNm580c6jqNjo7oXv1BPLAgMXBAHY1HxWmyuIanN6nNOQp0GmSrqyGVjYpYYQBWp4FtNay7ZN+cJfGKMNQAVufGKYEf/lQz4SoSvUnnpTG+9BGW9nYm95HaNk/3OWf6PSwCXXyHf7vVLPiYfyqGiN6cx7dDoeER99wjVrqDJ3WDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0pPFLIg73BP4UaqCmpiCtN6aYgrr7n2fuZlVCjhYuk=;
 b=cpB4V9rNFakDRvtp4sO3crIQvNJUgL5XZJqcXySFr8InKowhru0YGwad07G4j3RWFwMdUIuu/j9vwraHpNC73UqzOQafuMd4mHXVFyf4dXSdqeTXq2FSmYuxC4OIWRzrrI3OtP5pg+Xp75NfQA35utpJK/0lsQucTq77OPz9ZeOBcJpsiOUIHFCqYoA43UdKtF9ompdTPw/PfkuC+pghgSBz2XwiH66c1B5HW7zsAdB+gpJAYJ2Qr9EWk31VCsSNpVJ4MR4bOkcycNVDfjraYAzyskxMFev2z16gKrqIAiDJ1jrcgdCckBJzKBNoxsAXumLz9rPsedhcI24Gov4qkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0pPFLIg73BP4UaqCmpiCtN6aYgrr7n2fuZlVCjhYuk=;
 b=5bNe+5V9Nr5WH74t/lVB7OBmXi6PTkoG3kYIYHN3KdW+WzEWDdRjy4iWKFaSL+M8sWAlBo7XErYwgUhIhpH2xAhdTpFi99IYcOwvL4REMBEMc0zyQb+nW1DozxEvv0lkig3TMQhStYz0P73oIEzYUEFKSmo2yKIEVtcMKbvpirY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 by BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 23:14:03 +0000
Received: from SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::29ca:5c2a:6cf8:bca1]) by SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::29ca:5c2a:6cf8:bca1%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 23:14:03 +0000
Message-ID: <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
Date: Wed, 10 Dec 2025 18:13:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
Content-Language: en-GB
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0309.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::13) To SA1PR12MB9492.namprd12.prod.outlook.com
 (2603:10b6:806:459::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9492:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: bab1dde8-5c4c-4d99-14bd-08de3841cef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3Q2cFY1dmgvQm4wU29FN1VyOHNpSW9WdWU2bURSd0NiNGk0SXM2U1VqSXFq?=
 =?utf-8?B?SVJPTzFuemVjU2VOUk55aUpRWDc1Q2s1MG5iVVYyeXB2VmdLc3IyUzBrR0dj?=
 =?utf-8?B?SFJvbnRSWHNlakRFQ1N3aVBzL1pXMW53YWtDSnlPUGtIWFh1TWJBanJxNmcx?=
 =?utf-8?B?RnVUM1UxVzRuM0NEd1BRTnliZDhqS3JIQ1QrYXRPczhDd3NRY1hMTEtrUG8z?=
 =?utf-8?B?ZDB6Zm9XSnJMVHNBaEc0elBHT1JnWEZmdW5BNmpQNlVKcFg2Y3RiVmtrOHJk?=
 =?utf-8?B?UWdNL0NPQUdwMDhtYjJoNWs5MlFkVWx6NEIxcTZ0a2t2QVBKdGxsTGxHMFBo?=
 =?utf-8?B?Z3Y0OGxzMWZkNjg2YWcvUEhrb25mRExScWFLYXlNUHFBT3pBaUowNmorQ251?=
 =?utf-8?B?Smt0bkxqY0wxOEVFd1I1aElJOFpNRkNkb3FWQ2VQaFpYTTRyRVE0eUVrb3BD?=
 =?utf-8?B?dVpsN2RmbkdTZDRDOGR2MmdseGxmNmJnazZUaTJjMnk5c3p3dGt1bTRYbk8w?=
 =?utf-8?B?WWRmdG8zK20vU2hlMDhLOG5iQitRK3BZMURlMmNlc3ljcHlkM05XMGQ2MDVj?=
 =?utf-8?B?S2JNRUY0UlY5SVBuMGFyWWYrVHBoWmpJSmZyZmk1YWpBTi9GYjcrL0JoZERY?=
 =?utf-8?B?Rm9sTjFQdkpIUDNDa3ZGbnFYbFdHOG9PUjVRRHJFMER0b21qRDZ2dlVMRHFm?=
 =?utf-8?B?RGhBZlM5TkJ3bEpNakV2ZGxqbGUvcjVPa3MxekV2NXZMckFsVjBXWWJlU1dt?=
 =?utf-8?B?VWc0L29jem9tUzRNQXFkQnZUcCtVWFd2Y0dleWl1QlE4cEdvVzk3VTFWZGZi?=
 =?utf-8?B?UVJJdjZhVXZYRDNJUTU5ZE1PYnQzWWJMUjlkTnZmV2pGbjNGcDI4SDZYazc0?=
 =?utf-8?B?b2w5Y0VleFVEZkR5d0xXaC8rZkliajZxL2VCM1JpV0dzUjhZNERFZmlRWTFw?=
 =?utf-8?B?Q0dVbDExUTZYc3NETDA4VDlUOGdTKzh0L0c0OWl5Wnk5ekF1WUF0d0JuL2NY?=
 =?utf-8?B?cEVMeENyc2NqbjVLTGlMMmtQOCt0bitXQks4Vy9vbHlNVWtNVFpaMzVHbE5L?=
 =?utf-8?B?RFJ0K3V5elFuY01PeHcyVHpyWWMvSFgxaTNjQWdSVHFQbTUzYmpZUy9XN0dT?=
 =?utf-8?B?Wm8zeWM0d0Zpdjg5VldTVnVhVExsaWhQN3BTeElNa0M3K0RxMDRvWHFiZm5k?=
 =?utf-8?B?aTZSZnpTTkdYbE4rYng4eE9TRkhjN0w1WWpXUWpDd1FhNlVGRVBNaU5pUHF5?=
 =?utf-8?B?UWpQVUh1ZGFGMTlSTy9ISXVWMm5jbHNsdGtZN2hRbzhRakxST3E0Z2l1M3pl?=
 =?utf-8?B?a3RjbStHaDZmZHUxTVRESlJSSy83U0s3ZEpud2R3YnF0blM5Zk5Hc0ZEQ0Nz?=
 =?utf-8?B?dmZTbEhnczM0Q1pDbS9jK05mbmJCR1RrWkVHZHltK1gweFNYL0tkejlMYVFG?=
 =?utf-8?B?ODZUMWtNaXlsQUdVaHVPQ09kU2orSFV6bzlZbzYwVjlZMEpKdWsrVGRSRzZv?=
 =?utf-8?B?cTFrejVzc2phZ25DSHdNM3FNYklWS1h2aTFnZFoweHZ4UFRqdU1LT3RiS2FH?=
 =?utf-8?B?N1pyek5lNGxNMjMzRDhjclJINjl2a0l1S0JKZWw1eS9ERUtxd3ZoWHBXbzND?=
 =?utf-8?B?cWhyTDFzb29KalZndnhxOVNVQmVOSnRwYTJqUTM2TFBKK2dzdXF6ZXhwZ0xy?=
 =?utf-8?B?Q0JWYUp3QzllYmNrNFAxcjNnR1VUMVR0R1R1b2EwNU1CSGE5Rm04Z0ViTDUz?=
 =?utf-8?B?OEJWcDZBN0NZOEl0WUVQWDFrM2xmL2RuZlNkTXJpa2luOFY3YnpUT3J1ZXJy?=
 =?utf-8?B?eHg5Q1lIMThNOThqd1ZCQ2x2a3dFVXE4cE1MSjN1ajVpODMzWXpGUklwL3Bi?=
 =?utf-8?B?YnMxMmd2MVZORVl3YVFicGEzVGtKeENRZ2U5eXptb1Jka3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9492.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZ5UVp6VVV1aHlvcFJ0Rm5CU01vWmwyRkhXdEdKK1NEUTFXeksvUVBTdGRs?=
 =?utf-8?B?RFFpM2ZrSFkzS1VzdzE0SzVEUGFHajNkR0pNY2t5WExCRTZoMVFoM3hYcHZB?=
 =?utf-8?B?MHVpRTk5QXJwejBuQXlyUWJPSEUzcElWSzJLaDM5OXRjU1FuY1BVaHhrakts?=
 =?utf-8?B?WksxVVc0dnBnWk4vQ3VIQkd6WHlqQUtjZXlWNVBHbFhtbTV3bXdDMFBIWWVp?=
 =?utf-8?B?TWFTUXFWMFY5dXhPYXhJOUdxcWlycE1oV0ZZVjY0Rk41MGJkdGZPczEwTW8z?=
 =?utf-8?B?ekhzQUR6bThIUG5TQ2hsY2lZUnRDeUlWRmdleFdvRVBsZVhEbEJEeldEUDF3?=
 =?utf-8?B?d2lYN1pZbFFlNGd6Q3ladEZ3Tjkwc1pVeDNJN2pwcldvdWl0Y3h3Y2IzNnJy?=
 =?utf-8?B?ZlVMTHVxbjNzTzlMN296WFVnK0xVMnRVUTViUGJTaDgxR3piNVlEWWFlRDdm?=
 =?utf-8?B?U0lBTmlON0FEUy9tVjVjaXhJQWtsNCtXY1d3TGp6ek1XT29jUVdVNVovTVJY?=
 =?utf-8?B?bU4vSllWcU5tNHNGbUNkT0ZHUUpVQmZIYWpVR3hnMHh5bFZsRVNQTk1zTFdK?=
 =?utf-8?B?UHloc3d2VlNndXpMckFXOHlGT0xkaHY0cHpaVXNYYXRYWlpjbVpqZUUwZWJa?=
 =?utf-8?B?S2JvVktpTkVLRU1BZ1lxcVFiM0w4Z2R5RFk4b1FRYVV2REhxekVsbUowQ3dP?=
 =?utf-8?B?UW5nbmYyL1hscTBRUnlDK3M5NzQxS3J5UkFKaVNuMHVvekZRMDNsa1pjT052?=
 =?utf-8?B?d0ZPRkg1U1BQOFdkamk4bXMvRGtMNThkbytlOURwRXo1aFB3RFQ3STZnV2t3?=
 =?utf-8?B?Y3BEckg2ZG1QWngzVFNxaTE0WC9BUkxzUDFBYk9aSXdtTGdLenN3T0UrNWFo?=
 =?utf-8?B?Q2ZDcklFWWZMSUZCWncrRkU4T2dpZ3RWZVpua0pPcnRvbHpkaHYyQmpzaVhY?=
 =?utf-8?B?Ynh4d0xLenBFN0hia0t2VHpBYUcvMTR6VlA4V01TakNBQ3RZSHBUUFdUdkZP?=
 =?utf-8?B?b3pLZEk2M1hwNEJSRk0xK3I2S3ovTlJkaTQ5Z2FTM1pRUDhPakJjaGVBb1Vy?=
 =?utf-8?B?TnBBRmxMYTFPZU9iSzcrQjExckNHbE51cENqdSt5TVBFRmRFMDBpaWdYTkpn?=
 =?utf-8?B?VTFmWGZtMWpwUk5BMmkxS0k0MW5mK0xKdFBUbzk0SWM5aW5tZ0Z4bGp5bUh1?=
 =?utf-8?B?bVFtaElDVW5sMW5pRUwyNnFWNWxINWtYcFpFbXVrMGtzQ3F4MWhnUW9jVWk1?=
 =?utf-8?B?V25helBnaUpTSVZKdXZaQ0tta1RPTndYTkxKY1VLU1hQNkMyTktGQ0lFQjNY?=
 =?utf-8?B?TFZEWDZKQThwczhZSEpJYmtTUU1SVzU2ZjQzK0N2Vy9GRzFxcnRwM1ZSVG1w?=
 =?utf-8?B?TWlyV2lua3JGUnY1QmtzZzU1VlpzbGZLb3ZUT2RrR3ZFdExSWTZiaTMxeElD?=
 =?utf-8?B?ZTYvREgwTHF6QVpGZkhTZWxZQWt2QjF3MzBQTmdQOHFxQWV1ZW5XQ1BVbWlY?=
 =?utf-8?B?eVlMUUx6eTYwMVNFNjRnUzNlTFVRSElpMzgvMU5UVGhibmtuTjNNREV1RkNs?=
 =?utf-8?B?WnUxVGNoT2VGa0FaMVhUcFNPOVpCaGNIVTZiSkozOFdKNjFrakYrMWhZcC8r?=
 =?utf-8?B?eXA3WnFnWGxlTkl2K1VzSTJyYzl1LzhqMlBpeCszenBrWk1ORFhwRVNEUWd3?=
 =?utf-8?B?elBZTm9aT1VaRUZSUzBtSWd5OEFQc3pOeHdZVEl2UzZZOFhZT3JWcU0wSGFa?=
 =?utf-8?B?SEd2MnljakpDSlNRSDg1QzRLaEdBRWdMQ1VySGlaQUFiWHFrNk1UeDd0aDNh?=
 =?utf-8?B?Sjltd2dvR052aXFyR2JSMWxNRnBZRkJnS2pZZytNdFlFeHRkSXJOVWJkYlpD?=
 =?utf-8?B?VUdHcjRZRzEwcUdidkpXVnFlQTJoRW9ORlV1aUNsOTdrZ0RYdXlqdkZGR1Bs?=
 =?utf-8?B?VmdGb3RUdUNBWXU5TmtTdFE3b0ZubGtaL2p1QXdlcDhwbTN3WC84QTZmcjFV?=
 =?utf-8?B?TGEyNUJRaXo5bnBQY3N6bUl2ZVZ5b1haM1EvNDR0bE1na0MwSnEwN3pEU3d6?=
 =?utf-8?B?ZlF2WDRoTlNkby9HSTU0bldTZTlkVHJGeG84Wi9jVVJremNJZVBPcWxLTG9J?=
 =?utf-8?Q?Khr1OOgQ/qJLQesfRlhfveeFe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab1dde8-5c4c-4d99-14bd-08de3841cef2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9492.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 23:14:03.1805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW4nalxdPdlIwIbPB4RDJX9W7vcmxw+VAS3RRCgpoLGw17dW5rD7rW3chnW+1mfjkO+ew3/OvCsKTXNv2LkMnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
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

Hi Mario,

On 12/9/2025 10:28 PM, Mario Limonciello wrote:
>
>
> On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
>> ISP mfd child devices are using genpd and the system suspend-resume
>> operations between genpd and amdgpu parent device which uses only
>> runtime suspend-resume are not in sync.
>>
>> Linux power manager during suspend-resume resuming the genpd devices
>> earlier than the amdgpu parent device. This is resulting in the below
>> warning as SMU is in suspended state when genpd attempts to resume ISP.
>>
>> WARNING: CPU: 13 PID: 5435 at 
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398 
>> smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
>>
>> To fix this warning isp suspend-resume is handled as part of amdgpu
>> parent device suspend-resume instead of genpd sequence. Each ISP MFD
>> child device is marked as dev_pm_syscore_device to skip genpd
>> suspend-resume and use pm_runtime_force api's to suspend-resume
>> the devices when callbacks from amdgpu are received.
>>
>> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
>> Signed-off-by: Bin Du <bin.du@amd.com>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>
> Who is the patch author?  If you guys worked together, there should be 
> Co-developed-by tags to represent it.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++++
>>   3 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index 37270c4dab8d..532f83d783d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64 
>> *gpu_addr, void **cpu_addr)
>>   }
>>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>>   +static int isp_resume(struct amdgpu_ip_block *ip_block)
>> +{
>> +    struct amdgpu_device *adev = ip_block->adev;
>> +    struct amdgpu_isp *isp = &adev->isp;
>> +
>> +    if (isp->funcs->hw_resume)
>> +        return isp->funcs->hw_resume(isp);
>> +
>> +    return -ENODEV;
>> +}
>> +
>> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
>> +{
>> +    struct amdgpu_device *adev = ip_block->adev;
>> +    struct amdgpu_isp *isp = &adev->isp;
>> +
>> +    if (isp->funcs->hw_suspend)
>> +        return isp->funcs->hw_suspend(isp);
>> +
>> +    return -ENODEV;
>> +}
>> +
>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>       .name = "isp_ip",
>>       .early_init = isp_early_init,
>>       .hw_init = isp_hw_init,
>>       .hw_fini = isp_hw_fini,
>>       .is_idle = isp_is_idle,
>> +    .suspend = isp_suspend,
>> +    .resume = isp_resume,
>>       .set_clockgating_state = isp_set_clockgating_state,
>>       .set_powergating_state = isp_set_powergating_state,
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> index d6f4ffa4c97c..9a5d2b1dff9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>>   struct isp_funcs {
>>       int (*hw_init)(struct amdgpu_isp *isp);
>>       int (*hw_fini)(struct amdgpu_isp *isp);
>> +    int (*hw_suspend)(struct amdgpu_isp *isp);
>> +    int (*hw_resume)(struct amdgpu_isp *isp);
>>   };
>>     struct amdgpu_isp {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> index 4258d3e0b706..560c398e14fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -26,6 +26,7 @@
>>    */
>>     #include <linux/gpio/machine.h>
>> +#include <linux/pm_runtime.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>>   @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device 
>> *dev, void *data)
>>           return -ENODEV;
>>       }
>>   +    /* The devcies will be managed by the pm ops from the parent */
>
> devices
>
>> +    dev_pm_syscore_device(dev, true);
>> +
>>   exit:
>>       /* Continue to add */
>>       return 0;
>> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct 
>> device *dev, void *data)
>>           drm_err(&adev->ddev, "Failed to remove dev from genpd 
>> %d\n", ret);
>>           return -ENODEV;
>>       }
>> +    dev_pm_syscore_device(dev, false);
>>     exit:
>>       /* Continue to remove */
>>       return 0;
>>   }
>>   +static int isp_suspend_device(struct device *dev, void *data)
>> +{
>> +    struct platform_device *pdev = container_of(dev, struct 
>> platform_device, dev);
>> +
>> +    if (!dev->type || !dev->type->name)
>> +        return 0;
>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>> +        return 0;
>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>> +        return 0;
>
> Could we store the mfd_cell pointer instead and just compare the 
> pointers?

I don't think I can do a pointer comparision to identify the correct 
mfd_cell, string comparision seems like required in this case.

Its because when isp mfd child devices are created using 
mfd_add_hotplug_devices(), it is not returning the pdev or mfd_cell handles
to store in the amdgpu_isp and later use in suspend/resume to compare 
with incoming pdev->mfd_cell to detect the correct the device.

The mfd-core is doing a kmemdup of mfd_cells data passed to 
mfd_add_hotplug_devices() to create the platform device.

https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L163

I'm considering to add this function to check for valid isp mfd child 
devices that are allowed to do suspend-resume, this can minimize the 
checks, but still cannot eliminate the string comparsion, please let us 
know your thoughts.

static bool is_valid_mfd_device(struct platform_device *pdev)
{
     const struct mfd_cell *mc = mfd_get_cell(pdev);
     if (!mc)
         return false;
     if (!strncmp(mc->name, "amdisp-pinctrl", 14))
         return false;
     return true;
}

Thanks,

Pratap

>
>> +
>> +    return pm_runtime_force_suspend(dev);
>> +}
>> +
>> +static int isp_resume_device(struct device *dev, void *data)
>> +{
>> +    struct platform_device *pdev = container_of(dev, struct 
>> platform_device, dev);
>> +
>> +    if (!dev->type || !dev->type->name)
>> +        return 0;
>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>> +        return 0;
>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>> +        return 0;
>
> same comment as above
>
>> +
>> +    return pm_runtime_force_resume(dev);
>> +}
>> +
>> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
>> +{
>> +    int r;
>> +
>> +    r = device_for_each_child(isp->parent, NULL,
>> +                  isp_suspend_device);
>> +    if (r)
>> +        dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
>> +
>> +    return 0;
>
> Shouldn't you return r?
>
>> +}
>> +
>> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
>> +{
>> +    int r;
>> +
>> +    r = device_for_each_child(isp->parent, NULL,
>> +                  isp_resume_device);
>> +    if (r)
>> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
>> +
>> +    return 0;
>
> Shouldn't you return r?
>
>> +}
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       const struct software_node *amd_camera_node, *isp4_node;
>> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp 
>> *isp)
>>   static const struct isp_funcs isp_v4_1_1_funcs = {
>>       .hw_init = isp_v4_1_1_hw_init,
>>       .hw_fini = isp_v4_1_1_hw_fini,
>> +    .hw_suspend = isp_v4_1_1_hw_suspend,
>> +    .hw_resume = isp_v4_1_1_hw_resume,
>>   };
>>     void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
>
