Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20DDE7E0AF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 10:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4FE10E3C4;
	Mon,  9 Feb 2026 10:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+yL9aD5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B39C10E3BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 10:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dak7gqDggKBGZhDliKeUWcTbHc/DFMUhTOVRK1Hzt64zW5gefGSB37YG46XWIlEeY0+RKYPEBMnTqBIk9KTljSkaI9VD88B7e5I9nyrGxjGO2/AZu4lGbnblK7W1lLgW9gBPk0D3a1QylnJNzAX6KjrkAy1o3i2nrKhWPttgExUom2N6acQB1sjY1genuqDwG/ryuKHK5+7xmY90aRFrD2ydlMRsrWiD0e+bbpH0UUarNHArdbC9NTzV46jSFZward7fulwNRyyzPG3io8k6qxC+QHNij/vTyEQSAyGTgTfnK7A4WrNxGxCdup/CUoZNyrFAUz28HL+aaUQswHwNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+RkRVTafyPcmPCpqSOlzDLDIrgsKG0FtDNN5w6YA44=;
 b=GH7g2U8QkVGijv+gm24eZLKaq+Xu9K79EbdDi+EXEA6h0QRxyIjNOAWwldwiGLVHA6IFveam2W17dS3RmGz6R7pbAGVsSeatZxdRj66ss93i6tupiGpFPPbT378pHnCH6rz1nN1EFUISsNVjgI4P4TZEY2qgmDjyYKsw9joXsQ1yS8MEPD1lh+niQOdcdfuerGLhja2O4h7O6SWsNJKSebO3mmzCZmNNlEkFRjrb2ubAs4sHPTXX1yx3XKccz5+RBzQBaQqfhT09p5ULEzvXWT0mChXa8c4YgMRxmBBcVmYHUvT2W67f6q4b3t9/qqFfLGGiYivbc8Ymzf2FxTrlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+RkRVTafyPcmPCpqSOlzDLDIrgsKG0FtDNN5w6YA44=;
 b=U+yL9aD5n/r3DjoCLWhpFEIKQNuxHLCgyBEvYd0zLKWLzV4ZY2tZ9QigS1rkHlHyJILf7OsSIUnRZ2F89TGfHkU8uAd02KjsRq/SBqZuS9Op6aUO/T6ysQPaOtlBBs9kDaN1QhZsqWCYHWsw/aQ2x8+rF/tmmW1r6IJY9y2uuk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 10:05:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:05:45 +0000
Message-ID: <0332f527-e3e7-47f8-a635-6165d05364e2@amd.com>
Date: Mon, 9 Feb 2026 11:05:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Don't propagate errors from amdgpu_vm_flush()
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260208062713.1500367-1-srinivasan.shanmugam@amd.com>
 <65a74779-bcf9-4d19-a1b7-ca0b148dfbda@amd.com>
 <IA0PR12MB8208C4A6ED62884D4AC130EF9065A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208C4A6ED62884D4AC130EF9065A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6122f070-a24e-4c42-aeca-08de67c2ca9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVFrNUtTWEc0d1IrWkEzdWE1V2RrS1piRlIwbnhTT3g4d2J0OXFMc2tGTGR3?=
 =?utf-8?B?eFdIY0pKVC9HdlVLQ0JTcFlUNGV3a1JJMlc5dzBLczZVa0xmN2RIYTZKbU9y?=
 =?utf-8?B?QlNtbWFiQkR2UXJVSFRXZWlzd0lpcnRGbERvejdIS28rWThDNTF4NW9pZmxU?=
 =?utf-8?B?RmlMZFY1b0VoZ3lDSEVPT2dKR2VMSTRXZjhTL2tYUlUrWDhLWUNpQU04RDE4?=
 =?utf-8?B?QzVjMDByYmVKcFppUnFXdVZWYTZDS2lsMldSeHEvaEF5RWZOeXlkaXF3UFky?=
 =?utf-8?B?S1Rrbm1raGh6WWorUUlndWdTTHJmS3JDZEVqM1lKa2lSV0k4bldsd0FxUUo1?=
 =?utf-8?B?cmluU1U2NjRmaC9NendKakNiZitMR083ZVdQUTkyK1ExMVROeWlzUVFUZGdW?=
 =?utf-8?B?aDdTWkp3ZE5QNnZBVS9FQkMwY1BYMnRyY2lQM3I0eTFvZHVUZW8vKzNBeFBN?=
 =?utf-8?B?TTN5V05DN1E2S0lRQlhhTmgraytpdkVsVHhBVGh1UVlJdFhzT1FEUHJlTmZG?=
 =?utf-8?B?Rmw4alNqN1Y1SHprTFd0cU9iWEZuNHRCMktBVTJtQ0pPQUZ0RVZ0OTliUjl2?=
 =?utf-8?B?TWFzZ29wU1o4WElKQ1RzVU9QVzJRMzVmdkpudjhEREJlS0l1WEhta0xUUHZp?=
 =?utf-8?B?bHRSVFlzQUpWVHh6bUdJSTh3cFpWSEo1Z2JXa25leEdUN1VPN2tIaFE3NjU3?=
 =?utf-8?B?RGswYWk4b1oyNFF5K09RWENyNEFqNWNHczhSS0JKV2tEZFpXb0FlQ3dkUkZy?=
 =?utf-8?B?dWlmcW1mYklZYW51dXBXL253ZHdLdG85cE9od0ZGS3ZZUVFUbzlUN0dxZ3Jv?=
 =?utf-8?B?N2hkVmdzNUY0VXhNNHpJOE9Wbkd4MEV6Z1ovckNjbFhUK2Q3S0lzckI0MDRT?=
 =?utf-8?B?ajg4bFJPcUZDUkZFTHNHakVHZWtJMGErblA1RkRVb2p2R3hjcTF6allkS1Fp?=
 =?utf-8?B?NVYvSWN2WGRkVzJ5WnozSmVuc2cxY01ZbHZKQW8wUk9LZ1hqTVYzL1lDNFZZ?=
 =?utf-8?B?ek9aNHU3Wk5ZbXFZdjlLOVozVXYzTVFxZ2Y1ZnI5N0VMUjhka0J0a012UGZR?=
 =?utf-8?B?WmxibnBxdXFTZFdmNGgrWjFXeUtsNzFObHYzSnlwdzNoeFgvMllZUXlyZjVP?=
 =?utf-8?B?cmRlRXVIcys2U2FjS25IOXZUc0JwVTVNOHMvS1JnYy9kaHFaSWgydXBFUW1G?=
 =?utf-8?B?N0c1TzRPdE5IUVZFNk9xNDRNME94QXl0LzA3eUNKZmNjMWlBUHoxelV4Wk1i?=
 =?utf-8?B?dEtacmFZakdnWkJvNHl5L2VEUEdDMGhSTStjbWZsNCtHellxdDNnZXZ4bnM4?=
 =?utf-8?B?YnVuNGZETGgzbTB1VE5ReHVWdXpwMGJ5QzNsNy9aR1pCRjlPcjN3NEdvbUpS?=
 =?utf-8?B?bGtMQTB4NC9ac1JHS1JySmV0NnpHb1dmQm1CbjZuZ3JQYnNrZ0ZYays0TUg4?=
 =?utf-8?B?ZVBVOGdrNWNNNVBZVHNIdHgrd0JrUVlxVklDSmlzdkg0bzIzNWs2L2g1M0w0?=
 =?utf-8?B?MjdlV1RuSFlmWGJTNlpqYk1tcDNvYzdGZG0yeFdWL0FWcVlmTnYzdGFjZm5i?=
 =?utf-8?B?dnpwSS8xaG1wcXpidW0rUy9rL1p3M2gyb3BrVEJmcE5xc0ZUbzFFbTJ1WnN6?=
 =?utf-8?B?ZjdPQjdPR2JNYW84ZXpqWFYyeEJjaG9LYjVpNDZUSkxONW1TbEg3ejM4Unh1?=
 =?utf-8?B?cW1kMzI1a28wVmVYZHQvcGNaRERwZVZ0ajZ6aXlDTUVpL2V3WDJoWEhUY0ZI?=
 =?utf-8?B?ZVd3Smd1NUFHamN0d3cvVDRLYlA1bDJNQ2FkL2cxM3g4K0ZhMDJPejNQOWhJ?=
 =?utf-8?B?RktTN1JQSTJGZzhaN1IwdlJKd25wV3h3eHduQTFPYm56ZWNFVE1FZ0tyR3dB?=
 =?utf-8?B?dzBlNUswckR5NjFtVlI2TDN4M2VZWVhyWGFjQ2drT1RRSGNhV1M1Q2x2dU45?=
 =?utf-8?B?VjlEZ0t0TTI3TlFqY3FlK2NnczVhSUpXdmt6VENsd0ZJWExiREg2U0F2MXdR?=
 =?utf-8?B?cFhhSUVrYUIxNFd5RVZhSE5NbjBRWjN3VzZaMnFMU1JPRjh6UTU0VXBoeTlv?=
 =?utf-8?B?RkdHYnhVZ1JLeUF3c3JmdW41bkRMclpndlhONGQ1NlM0Q3dYektPRjlwUllU?=
 =?utf-8?Q?Y+Gc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hOSFdBcnE4ZHhMclMxMnlxV3I5TWQzMmxOSXFvVGo3M1RBMVNoSENsTDhw?=
 =?utf-8?B?SVBSaUNqNXdlUlhDdEhMZVlUSHJFaHU5eC9QR3RpOHZvTmdaN3dUUFNPa2h5?=
 =?utf-8?B?M3dVNkR5N3lqeDArdk5xckliczd1YzB3TWVoRHlaUHIybkUwL3RQMTA5dWVO?=
 =?utf-8?B?MGV5L2cvR3M0L29iejNQMVM4U1dUSHY5c2ZOaGVnM2t0UFo4ODNMRC9XOG53?=
 =?utf-8?B?MTVhTXYzRkFGMWprWWY2bEd2cHJqcnJ3UFhCRU1LSllOZzBBcHhJZ2ZPZGtq?=
 =?utf-8?B?UzNVeXhHMWFQM1VBMjVMejlpUGJuck04U1ZRcHZ1R0E0NW1FMWRWODJpTmFr?=
 =?utf-8?B?QndrRzNhK2ZBM0FqRGZxNUdQbUdhdkZVMTB2V250SHg1dWRVVy9td1NDMG9I?=
 =?utf-8?B?eWtDaHBPbEpkcHQ0bCtSb1RtS2VSd3V0NUc3L0FEK0N0dTVqRDdnOWI3U0I3?=
 =?utf-8?B?RmdQSjJmU1dVTU9yaUxRdXlPdm5IalNCSTJscjZSeHU2aDZWR0E2ZmZNZytt?=
 =?utf-8?B?SGJKaWN3QTRTM1ltZnBKeEtLMjhLR3VrbnpjZlJVMElQb3BkS1dmZjZSS0VB?=
 =?utf-8?B?T2dCSGp1eUgrQ2lvQ2M2aFA0ditPUXpqelp1SG9QRU9XWHZZbDVxbjdFRC8v?=
 =?utf-8?B?QmpjbHA5UUowdGgvZWI1VXh0dkJTcDVjSUpZaGJadWtxRkh3cXhyak41Mi9C?=
 =?utf-8?B?NTQram56dStpcHJuZmFIRElZaFY2NnVFYVBEd2FRVE1aQzZFOE03YzhGVlNr?=
 =?utf-8?B?R012cWR3VGdiZHVvdDBJRkh4c2NuSG10NXcwblZmUk9FaThMaWx4Ri9WMVBy?=
 =?utf-8?B?WWp3cGk3RitFZ1gwRHBETkg3K0FSSGNtby8wMU9FTDZwZUtJejFvVndDalk1?=
 =?utf-8?B?VE5IdXpTeEp1YTc1bUM3R3RvaU1jMDVmK011TnN0NmxJUkltS2ZnVHZwbEpu?=
 =?utf-8?B?SEI0dXhvMjRwNHBBQmFjOVU0dCtxUm5sak9hQ01OVGZONjdyMWkzQ282VCt4?=
 =?utf-8?B?VGxQeU5TTFZ0ZmVhYW5pbmxhSzNpcHZhMXpWWDFwOU5STHQyRDlQVjVkYkJF?=
 =?utf-8?B?cXVZc0NaTEtYZERSdTArdFJIeFlUTlNJR0hseSt3bmVWVVcxd05ScXh0UWhK?=
 =?utf-8?B?cVI5RTBSMHJ0cmdWMGtrV2pFcEZRSnliZUphaHRjZitZYVZoYmZjeCtPV3Mz?=
 =?utf-8?B?eXBUbk1seEVFU3pEUTVVMldFSFlYb1d5c1NZamVnN09Wa2tRNlprWXYzcXNO?=
 =?utf-8?B?TkhscFNBTW5ZZU9BdVYyM0hZYWt1RFFiUEYxTk1nOFhPek9nbTRUYzBmczdm?=
 =?utf-8?B?VFZRU3JRanM2aWQ0NTU4WTltcGJEeHZoR2RnUms0aXQ0RitHamgxSFBoRExS?=
 =?utf-8?B?RG5jbVZYeE1aaTVxZFVTTmdPRkIvSmYzSEhRZnpVWkdvTk8zQXlncGNVaW43?=
 =?utf-8?B?NTRBejArZDhxMXU2N25zT1d0NU11RmhWRjhlMUk2VHBXdWhWNWo1WTdNdjhr?=
 =?utf-8?B?Ym9CQ0IzbHk5MDN2d0phSEhpdjdJaWEyQXA3VHo0V0VpTTJIMUJzSmhMYmpM?=
 =?utf-8?B?Nm0rSlIvbm9qNVB5eFZKMW84MHA4a2tjN0c1akhmY1ptUllBR00zeURNamY3?=
 =?utf-8?B?YndmK0wzanQwVHEwY1FCOWUwTk9tRVdFREZEWlFiVTRIYUZOTEVyMTRkVWND?=
 =?utf-8?B?cVlnOXVwcmZ5V0p5cXcxd3piUDJpbkd3Z1FvemU5YzYzRE5tV3IwYld0L1E2?=
 =?utf-8?B?a0tjeWs0MnZTRTlNSnpkOHNOeFl0TVVwV0hmNTBwZDlNQUU1L3N3d1dza2gr?=
 =?utf-8?B?dk9KWS84YXhMWTZNVjgySDFRcngzQ2trTVJLZS83ZTE2KzBCRXZNYlRncXBT?=
 =?utf-8?B?U0hzMmNiTXVDaUx1cTNvd256L0dyRkNseHBCeitwZ21Tc1dBWS9zbk1Lb29L?=
 =?utf-8?B?WTV3NHY2UWg2UHFTZjYwNy9OQnNVUHNhQmhHOFdHSXc2NXZ0d2F2ZGlpMHpj?=
 =?utf-8?B?NE5kdG9RUlh1THF5QTNwc3p0eFU2bE16U09JK2pjSDdCZ1R6MWI1Y3FTL3lO?=
 =?utf-8?B?OTU0YWZ5cGY0ZE95b1VuZEh6eWR5VS9pZFBubjgxdzNQUHlCSGlNcC9XMDcw?=
 =?utf-8?B?Vjdwd2g2K2hlVnptNUI4VVk1OUp3dHo0N21ESDFKcVgza0pGTnNuUW9ZQ24v?=
 =?utf-8?B?ZllWUFk4NnZ1a0c5d1ZSMHFzd3BVY3lmMW1kUHZjNzFCbG5zT2ZiNW5XRWsy?=
 =?utf-8?B?VzVwN0IyN0J2eS9NcFIvTjgzTk5TNG5rdG80WnI1ZVZ5ZDV5OGZTY0Y4Zy9p?=
 =?utf-8?Q?vX/iomHVkjVlaHx6MJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122f070-a24e-4c42-aeca-08de67c2ca9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:05:45.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wjfpFuYGbCOrXuaT1a5CHAWeHOPAYglEombQGsB+Ol3+Miphfc14Hw8BABcAiPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

On 2/9/26 10:51, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, February 9, 2026 3:11 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Don't propagate errors from
>> amdgpu_vm_flush()
>>
>> On 2/8/26 07:27, Srinivasan Shanmugam wrote:
>>> amdgpu_vm_flush() only returns an error when amdgpu_fence_emit() fails.
>>
>> You need to take a step further amdgpu_fence_emit() can't fail either.
>>
>> The fallback wait inside that function blocks forever until the fence signals and that
>> should never happen in the job submission path in the first place.
> 
> Thanks Christian, understood.
> 
> For amdgpu_fence_emit(), I will not add any recovery logic.

IIRC we only used the recovery logic for direct submission for low level benchmark testing.

I think we completely dropped that, but I'm not 100% sure.

For now potentially just remove the error handling here:

                        r = dma_fence_wait(old, false);
                        dma_fence_put(old);
                        if (r)
                                return r;

Background is that dma_fence_wait() can only return an error if the second parameter is true.

In the long term we could move this waiting completely out of the emit function, but that is clearly something separate.

Regards,
christian.

> I will keep only a WARN_ON_ONCE() and return early if it ever triggers.
> 
> Please let me know if this approach is OK, and if you would like this as a follow-up patch.
> 
> Regards,
> Srini
> 
>>
>> Regards,
>> Christian.

