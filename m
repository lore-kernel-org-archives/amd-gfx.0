Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6129C54754
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 15:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2665410E8F5;
	Thu, 15 May 2025 15:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qq+M3azc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAAC10E8F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 15:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFHBsVOISk4tV7vr7hyU228Tb1iY+UX6fsdQ0dw2+qT+Efpdr8LXuxOGe3XS0nsrKSk9G9dcuqy5iaacashpD02koCdFU1++SDuEdwNVCa6zgkcIWNLQIR8gUy8xVQysxMWCg/IxzjnT53+rf2axPuCjXzyq/+63TiPfDndYDEyYl956Zfu6yRD8ch4GrlW46D0UHV1tD+NM5aKKVLh47q//5uCI/QgIbwtu9qfrYrHT2aq4ipepIJ0LVNyMiwQURbIqD/XTerW3uJ9n6JVjOqAJymE5SQChTPetHgWyNYJrv9U9XO4CF2edEAlivLX1aKZZSPd1YmV12Eh8kILLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdFM3JRePJvubp751XJLD+YAUSrVgI7eLRpJZ85sl8o=;
 b=oYyE4dIQxSiGUV7QjuNOpmGDOi19k1VLl/DLcq5apaUkLhkzMCaU7qTOVEmfshWUJVx64Gxhdn9w+c2uSbcDrGijNpu0VLGT7ZETdULFoGK481MGVNEOLPE0tCg5PJc+SaV/qdO8l/xzfaTc+cPACNL/oR0rV9A774DfH8vFgIUzVpOUp5Q7Mr1oscl12l2zJgL9LlBTDn4G5ik3tBul1gFszpy5go0mt2Hju3xCu0u2WG3sflIZ5BM74ojiHo0alQWCQ3f1MmfVQE6H/YJz1vzIsY+yACaCKSTBkvjqvoW/gxwz75RQOzibw+6O1opPNSxjqdhXVNt9Upn4M4EEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdFM3JRePJvubp751XJLD+YAUSrVgI7eLRpJZ85sl8o=;
 b=Qq+M3azc/2syrB8ZCzIZKjuWGISF8QJbVRG3o46Uusw9hreO2waJyrHXheDOqcXltxE4VeJslQKKzU2AqLYaI//dYix69tr0uqkeQAmTGzKG8gsP/f5Qz1tcFrpepf5+pWSSFRqkGgRIq6Mo7e+5UOb3CI7Ld5vTlpYPxsEp4To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 15:49:13 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 15:49:13 +0000
Message-ID: <34f28c86-8899-47c5-888e-5b44add5ca3f@amd.com>
Date: Thu, 15 May 2025 21:19:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
 <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
 <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
 <cb73b496-1008-4338-83f4-a1ddcb81be46@amd.com>
 <74e83de0-1a1e-458a-b110-f6458db129c2@amd.com>
 <01435a2b-e4f6-4265-a355-e970fad8fa29@amd.com>
Content-Language: en-US
In-Reply-To: <01435a2b-e4f6-4265-a355-e970fad8fa29@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::34) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cc5f6f-6e4f-4948-366e-08dd93c809f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2xERlUwZUNsaDhGMTlpVDd4eTJ5QlhYL3JudW1jMndSTWhTRnFDVHp2dlRC?=
 =?utf-8?B?dG1WS2xQR04zYk82TW9kaHhGaVY2RWMyVXBlRk9STGttWEZTazZhdW5FL1pC?=
 =?utf-8?B?RUxvUlFSdW5tVW9RWEFvbjZJNCtzSUVGUmw5cjAvRjJVNlFqdXF1WDhFcm5z?=
 =?utf-8?B?SUxzN2xEbGlxRUlqeG5GMVlsWGlqUUlQQlE5QXRqVmdwSW03V3R1Q3o2VG8x?=
 =?utf-8?B?QjkyVWNNakJLNHdSZ1hZZXpicFoyL0tTQkZWQ056QzU4UE5lU1ArdW9LSy81?=
 =?utf-8?B?TFF3aHptSVlCZlVhdGU0cTNjRlRtZGY4NVdUOGRHMEp5eXJybDRiWVZ3aXJH?=
 =?utf-8?B?cVV3T0R1YnlIdDRsKyt5SmRRd0ZFZ25yYkkrQ0JidFpBQzJyK2dieTFsZndS?=
 =?utf-8?B?VXVrY2JJeS9XZmlqTkUrYnJrSndrNzdROWhtR081R094WXpRSEdtRG1uRnBm?=
 =?utf-8?B?a2JUZTd1MlpIdWJNY0ZVamxNMFZJbmx5YjlIU1VNTFZCaDNzZ0Q5MTR6alM5?=
 =?utf-8?B?L0Urc0c0c0Z4U09KVmVtQnNzbk1HK2Nyck1mVXBLYjVncTROOWlIZ0psV1pk?=
 =?utf-8?B?RnJuRldlWm1JclE2RGEvZ1lXSWJmcWJMQUx1RUJWSEdHQUtFbmdTQ2hMck8y?=
 =?utf-8?B?OVdXUlFYaSsvR2tTQUpDQ1lWaDhSUmV1STZnUUpNMHpZRlJzK2dndkkzNkpu?=
 =?utf-8?B?NW90SFNabW1ySmptdTBQcXZqa3ZDNDZNNllnT3krK0UzMXZWVnlISkpBQ2tu?=
 =?utf-8?B?ZWlSWHNIZXVnT0k0WG0zTDZ2OWNxcFZ0Q2ZlbExHeHgrS1dLeVNpVHJpWkxP?=
 =?utf-8?B?RE0yNmtsTDkyTlk2ckdja29sMGNGUy9XcjBtZkFxZ2piMTlPZnhjRUlyOUpR?=
 =?utf-8?B?anJxNHVjWGpMWWxwZ0hiNEFSNEtzMVdyWmsyNkx6ZzRFSS9YTTVTWmZONEx4?=
 =?utf-8?B?cWVMcEZ1S0dQS2Z4N01SbzNhVHB0Z2l1NlZpK3BpZjUyYVlhd0VtV2l0ZS9L?=
 =?utf-8?B?V0lVVm85Rlg5ZjVrbHJNemFyd0lyZVBIZlBaazFzMlo5Z0VodStabjJYUG90?=
 =?utf-8?B?OFk1V21aT1ZBbEoyZ0hjT2VXb3AxckZkTnV5VUJQZnJXZS94bjg3bU5IUFdS?=
 =?utf-8?B?NTBNSXMvUW9VU2Q0anZVdlQ2d1ExVWtsdzFSOGpLWnFkYUF1ei9kMjY0aVVl?=
 =?utf-8?B?OWZRYWZvdVZtSGhRa0ppTWRjaDFzUEF4MUFtRktUYTNsS25hWnJWQjFXZ1Jy?=
 =?utf-8?B?aTNFYXdJYnV3ZUVKa1JWSndTeGhjaGVzaGhydTJraXoxY2RGS2lOc2puQUZk?=
 =?utf-8?B?UHdUY1JyWnJtcWw5aHREMllvYXFGcTFsY1ZVSlBLYmFHdjVIRWxDRG9zN2g5?=
 =?utf-8?B?M3VSdW5ZQ3ZJdFhLd2xEemtjWWN1ZnV0c2xaMW9ZMXpqbmFHNlcyRGplSTh1?=
 =?utf-8?B?bTBVOUdDbUViMFIxQk5ST0tnMVFseXpWQTZmTkJvWnVlRVI2cEptVXZqTjcr?=
 =?utf-8?B?U3FVcVNENVZQaVVKVXVNT3BJTHhDMi8zQ1hWZzZZTDBsN2cwUDRDWTVRV2ZV?=
 =?utf-8?B?UXFUWTZkVGJ1dUJwVHNVeVVDcDAzN0hpNjdWVkErSU5tcnU4WEFCOUxxZmV6?=
 =?utf-8?B?SHYzaWVvYXhybGpMRU04QXBLRG45aC9ySHpVbDI4NVdiL2REdCtTenkra2wy?=
 =?utf-8?B?Q0VNcGV5eG9oUHJ5dDdybktYNHRoZlRaY24yVTZ5VUVJbG5OV3lrd1MzQWo1?=
 =?utf-8?B?Z050QVBSTVg4VEtNTWNqUmgwYy9mK0ZIV0ZaRTNzTlRMeks1cEtTanRRWjJI?=
 =?utf-8?Q?p4LOO5kz8T9UjvdrHhLbEFQxuSsS25JpvpHTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXR4NWdkR2liZTdGWkdZWEpVQ0pCYU40RVZqdy9BMjF3QnF5WlIvUmxEQ0s5?=
 =?utf-8?B?aVpLN3VLZUI1YzdobVZVOGtOMnNYckc0TXJkcWV5VXB3ZWNmc3M5NVVYUHF4?=
 =?utf-8?B?SG1OSC9TKzhvKzNEbzR1cUp1dlY1Nld4RktNMDJTeFVJTHhXUk1XQWZMKytP?=
 =?utf-8?B?RzYvQjlSMDd3OVA2b2FqYkRWRXBJazRBa1dRUG0vMUN2MjlTT0JFNWRzU05R?=
 =?utf-8?B?azNCTU5xbEoxR2JtWWh4RStjU3VqYU1IT2NCdlpZdnROY2QveWhQdjFBR3Jy?=
 =?utf-8?B?eU45eUZOV01tQkJpMmpnVE1VOXRDb3piMXlwSFhkRFAvT3hDYkh0K1d3VlJi?=
 =?utf-8?B?eXRzSGU4OEhXN3I1dk5oYWQ5MVZLZEsreGc1dGVvQy82T0JWaU8wd2dkb3Yy?=
 =?utf-8?B?bWhRUU15OFFTbnFBRXZxRXoyZEthUjlZYUk5dTZBY0RSd1BOa1B6Uy9PR1lh?=
 =?utf-8?B?RzY2K3FjeVY3ZXFCOGVCZUZyd1Uzc0VJeW1iZGJrK01ONU1leTlIei9lWEtU?=
 =?utf-8?B?MkNRV2RpNjBJZkNNWjZhRHp3ZHRPYVhjaU1tR0ExckNBNGE3dzlWaVZwMjRP?=
 =?utf-8?B?NWpHWGJ0N3dSMVA4bWhDRHpwOVQ5MVZvbUtaRHA5enVxQWRPdlM4cDFPdG1Z?=
 =?utf-8?B?dzc5YWZFNFNUU0ZpL01lNzZlSkUzK0hqVDF1VUNFSEd2cFBlSFhSRWsrWURi?=
 =?utf-8?B?L1lGUFJWWDlqbUJ1R1dNVldyT21yaHVFaUZ1czc1L3A5U0xISEtsSTl2bXR5?=
 =?utf-8?B?OGtaRm5KUUhqbUxaNUh4MUZRSWVZUnBpNlF2MFVCcmdpL3NoSGJ4NUdJcTFj?=
 =?utf-8?B?REpNNER4RkQxcElsa0R5eS9CanlOeU0rVFZIWnlpWlVMTERHL0F4N01RTzBH?=
 =?utf-8?B?NkFycWlqMVJUQjkwWWw3NWFDblI3NkZVNTZKeU5GcmFYU1cwK1AralAvclhJ?=
 =?utf-8?B?R1R6czlmcks3cVVqbmUvdGdOZ21mZThDbE9USXovMlphcWJTdzZYNm85MldI?=
 =?utf-8?B?VzIvVDk4L3lGbXJxWEIvK3pSWGxFZmNhREE0K3ZCeVdsR2FkbHNPcmtaaHQ2?=
 =?utf-8?B?MDF2TDB0dFNwcmtUNml6T01jdGUvN2ZnUitDeFFpZHRHaE0yakJCQzBCVkpv?=
 =?utf-8?B?WG5Ebm5peTZPS1FUV3FmUjhFSmlTQzJxTG9OVXZNTnNWZEIvZHY4NTVVL0Ra?=
 =?utf-8?B?MW55cE4wYWJSMmcvY1YzZElmMm92eTUyWWNaZ0grY2pOaDZDcFd2VGEvNzlx?=
 =?utf-8?B?aHE5cE5IK05kbEQ3UEU5dzlHSDAwVjB2SnNldENZV1JJaTNLNmVZQmtVb3ha?=
 =?utf-8?B?dFoxbithQjJBazZOWndZUTV3OXF4ZURFK1VTdDJiYzVGc2V1bjBSUjdRT2dN?=
 =?utf-8?B?VXhKZ082VlJma2ZtTWdsZEluZUVNUGhxQ1hyOEgyb09nemZrSkZiUUZPWkth?=
 =?utf-8?B?aE0vMFREMlJTMDF0cGFVbzVuR1Q5RjVUMXdHMWhDSStCK3doYzdteTJCQWRF?=
 =?utf-8?B?c1pEN3BjQWM4MXVTOE5sYUpqUEZCaVpNTTJhT0VwZkZTWjFSbitla0RrMEgv?=
 =?utf-8?B?OE5hQ2ZnT0hlYi81dHdSbjNqc092YjRac3o2eG1TcEVOTkV3MlBsUW9UVUZY?=
 =?utf-8?B?NHZ5ZGs4QVo5WVcybW5BazRjVTJlcThSVHZEdFFlTXdCUTJGMXVIa01sdytx?=
 =?utf-8?B?c210QWIraG56dHJRUDluYkdobDl1Q3g4M2gxOHJ1Sldjak9vZmNsdytLVjJD?=
 =?utf-8?B?c1JERm83QVpaTWUyVEFlSW9YSDI2aWtTaHRsQVBoN0R4S0h6YmVFQW1zOWlW?=
 =?utf-8?B?cVBKanBiLzdoTVNSakhjOVg3OFFpQjlYL0ZIenZGbExhZVZBNmVKdDVFdHky?=
 =?utf-8?B?Y3BNV2xMZFBUeXVTbnIvTS9JS2VtNTgzQzBxUnZpYUFBZGxpejZVK094VG9k?=
 =?utf-8?B?UHRqQTJ2NlVjcnBRbHo3K1hTSmNScUxtRlBpUnRsam5xOUlGdFVOMEF4ZS9n?=
 =?utf-8?B?SnJkNU0yRm4rakpHUFBhZURLdkljK3llUzVFekdsb2FSMUdXd3huZ3dGK0wx?=
 =?utf-8?B?emRhSFZxYmJ1eUEzSjZWcDJlWXV6NVMrVVBOS3YvdlJibUxPcHhSMXVjZXZU?=
 =?utf-8?Q?utW5HgDfMIHcINwGb8BjtwQW+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cc5f6f-6e4f-4948-366e-08dd93c809f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:49:13.1464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nvwef83FFeHZU8oZt3/PrD04rSntWhBpQZ01wUe1W+c9oEIDyGBLNKMlksaGkaEm0Xva/W/xUzNLWWSIxybdWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
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



On 5/12/2025 12:41 PM, Paneer Selvam, Arunpravin wrote:
>
>
> On 5/12/2025 12:39 PM, Christian König wrote:
>>
>> On 5/11/25 22:37, Paneer Selvam, Arunpravin wrote:
>>>
>>> On 5/12/2025 2:03 AM, Paneer Selvam, Arunpravin wrote:
>>>>
>>>> On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
>>>>>
>>>>> On 5/2/2025 9:02 PM, John Olender wrote:
>>>>>> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>>>>>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>>>>>>> + Christian
>>>>>>>>
>>>>>>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender 
>>>>>>>> <john.olender@gmail.com>
>>>>>>>> wrote:
>>>>>>>>> The drm_mm allocator tolerated being passed end > mm->size, 
>>>>>>>>> but the
>>>>>>>>> drm_buddy allocator does not.
>>>>>>>>>
>>>>>>>>> Restore the pre-buddy-allocator behavior of allowing such 
>>>>>>>>> placements.
>>>>>>>>>
>>>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>>>>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>>>>>> This looks correct to me.
>>>>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> I was thinking that we should return an error when lpfn > 
>>>>>>> man->size.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Arun.
>>>>>> This patch restores the previous behavior in the spirit of "Do 
>>>>>> not crash
>>>>>> the kernel".  The existing uvd placements are pretty clear in their
>>>>>> intent and were accepted until the switch to drm_buddy. I think it's
>>>>>> fair to consider their style as expected.
>>>>>>
>>>>>> With that in mind, I'm not sure amdgpu_vram_mgr is the place this 
>>>>>> change
>>>>>> really belongs.  That is, I think it's worth asking:
>>>>>>
>>>>>> 1) Why does drm_mm accept end > mm->size without complaint?
>>>>>> 2) Why doesn't drm_buddy do the same?
>>>>> I remember that during the development of DRM buddy , we had a 
>>>>> discussion with Intel folks and decided to
>>>>> return an error in DRM buddy when end > mm->size. This was done to 
>>>>> ensure that, at the driver level,  lpfn
>>>>> has the correct value.
>>>>>
>>>>> I will modify this at drm_buddy to match with drm_mm and send the 
>>>>> patch.
>>>> After giving it some thought, I think it is more effective to 
>>>> implement this tolerance at the VRAM manager level
>>>> and allow the DRM buddy manager to perform a strict validation, as 
>>>> this is necessary for other graphics drivers
>>>> (e.g., i915).
>>> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Ok in that case please pick this patch up and make sure that it land 
>> in amd-staging-drm-next Arun.
>>
>> Alex most likely won't follow the discussion till the end.
> Sure Christian, I will merge this patch into amd-staging-drm-next.
I see a black screen problem during the amdgpu driver load on the tip of 
amd-staging-drm-next,
once that issue is fixed, I will push this patch into amd-staging-drm-next.

Regards,
Arun.
>
> Thanks,
> Arun.
>>
>> Thanks,
>> Christian.
>>
>>>> Regards,
>>>> Arun.
>>>>> Regards,
>>>>> Arun.
>>>>>> Thanks,
>>>>>> John
>>>>>>
>>>>>>>>> ---
>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>>>>>>>> b/drivers/
>>>>>>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>>>> ttm_resource_manager *man,
>>>>>>>>>            int r;
>>>>>>>>>
>>>>>>>>>            lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>>>>>>> -       if (!lpfn)
>>>>>>>>> +       if (!lpfn || lpfn > man->size)
>>>>>>>>>                    lpfn = man->size;
>>>>>>>>>
>>>>>>>>>            fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>>>>>>> -- 
>>>>>>>>> 2.47.2
>>>>>>>>>
>

