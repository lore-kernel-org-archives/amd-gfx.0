Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEEAD2F7EB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 12:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827A710EB23;
	Fri,  5 Dec 2025 12:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a5VRzA5t";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4583C10EB22
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 12:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky8YhnuW9czQnDtjCp/FrXVKFIfPIwLU52BwalAIPpsYt5uIoAWIghbaAaDA1FSsw86aWGEjY3RbvoseWjQdZSNUox6fcv7HRVCU+x5wCXG6rKsaLgQBv7I7Mu0mjtzhezaZKhQm9fudlmdkAk7xSmym1lcCwOGo747wZcNVUPQzB7Xm4vMcmNDgIDYNvwCTZc25fI8GGgzX7tKxKHd5MtOXQ5dSmXhOx9IzBXlBU1bvYqr7qzVos4bFgxfSWpvjWW25m0f1jDGbvc9GBtaNMoAiOuThdK4NxzEChBmLnkMt/UVq171oKR8QLEZDqbnhHVaoAmRLMQAiqO9xiDR2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQhVsBbxq+JzgZ0WSkqVtDgiBYRCpfCuUi8VO/CzRdg=;
 b=F6UZed/joCxehHwdIuWludDjstGjC+Idc3g59JAeK+Ub+qW4dlI1fEvlyDoQM+Q3ijWHsBzqKiGHmqUlu73vvwBmcweY8mniDYceEH31PR9okDZ9d0K/dYbwAXusswpVQLdVznODp+4jvmRRza6i+HxI0YYnpDzdO4FQuABkJFnMdiO/eDE9VWmzZhly9LFlsORuHY80sHZMwt38nROhbEokWLR/k7VXbeZRudkkslzJUEjS/s+/nOVNfTJFDH2tEVtTFBj+dlD5c0WJUPlIxdERcP1YDKcsYP65fwmv0d6H11mMRdpYJ+M4NDAkDcXw/8EgihhDNu7pvfEOp7salw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQhVsBbxq+JzgZ0WSkqVtDgiBYRCpfCuUi8VO/CzRdg=;
 b=a5VRzA5t5tdL9p0ISVFS2o4/6ZYL7bsfGM1wYp0AuZtunJcLLQ1Y+llVsCzjHwlWSmugt0AXaQMaBRtL8gdov+xJFOf3BYjovrD7BXRrE0dd7SoGXEbs2Zmi+K80Y7DPi0wWs9U49vc1UyWxGyHvccrOHnY5o8zDxPilbzLGAmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 12:34:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 12:34:58 +0000
Message-ID: <be0f0bef-a54f-4606-80d9-09b8c0a961bf@amd.com>
Date: Fri, 5 Dec 2025 18:04:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20251205083521.1337481-1-chongli2@amd.com>
 <8f562315-824e-43eb-a4d5-614f077e39ba@amd.com>
 <LV2SPRMB0010696B4E2D4E772CD683A09BA7A@LV2SPRMB0010.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <LV2SPRMB0010696B4E2D4E772CD683A09BA7A@LV2SPRMB0010.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: cdabdce6-a477-49da-feb7-08de33fab3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1NJamN1SFNFeWlVRTNzV2tRNzg4ckNsMkQ1cmM0bGdkL1lhY1RnUmZKMi81?=
 =?utf-8?B?d2JZL2kvbjhDNDB2MVpEMVNtYlF2TWxXNzZzUU9pbHhZMmdCMy82T2o2YS8v?=
 =?utf-8?B?YVhBNThiaEh0OE55NmJvUVQyWTlQeWl0K1hPQ1NqUGlMeXRxWVJlQk94SGVB?=
 =?utf-8?B?Q3J6ZU9OWCt1TzVtdFdkK1NQUS9nZndRYVZRSUo2aGpxNi94ZXZjdGNHeGtU?=
 =?utf-8?B?ZGRlcnFISlVEV2tKaDN4VVR6V3F3TStleTdnVG5BRHVmWmNOVkZTRGtLZHlI?=
 =?utf-8?B?TUxmemhYcThTNlNPcmZXUXdmN2hTbVUvOHVWc0NIejhGMW44WTk0WVpXT0JN?=
 =?utf-8?B?ZUVaZUNyOWdoZjg3aE12Zk9pa21reDVOaC8vdzBGc0tZdktvak5RQUdIbCs3?=
 =?utf-8?B?VHd4eGhhY1kzTzFnSkNjOGx3RHRLRC8yT0pKZlhrOVR5ZERFUVV4K3dEY2Vr?=
 =?utf-8?B?N0J3WTZscTVQZmUyL0tTS2ZGRzloeUJpaDJMY3h6SlMyVjdjeS9mMTBVbE5t?=
 =?utf-8?B?SjhZTjhiUnZrWGRDb2lvQmxkYXdTZU8zOHo5aXVNVURlYUtKNWhleHBCVE9P?=
 =?utf-8?B?dVJNRjZheGl0TkxDS1FON3MwZFhRRmU0Y3NZVFNUa1lsd0J2bFZlZ1J0cmFm?=
 =?utf-8?B?SnI2cVpqY2JabDRNTjVJSk43emJGZmhJczZXMUVKR0FCTk5Ga3BYV3pETTV2?=
 =?utf-8?B?UXUxWG5USFpCRnN1SitNTnhITE8vMDVhZWFsbWo3UFhOTWpkM0lqV3lQNWVN?=
 =?utf-8?B?UXVJWXF1ZUtta2c4R0N5eStNZWpUWkpoVzhKRUN6K0JsYW50OEZUa0l4dWRi?=
 =?utf-8?B?WGVXOWpYZkplU2wvWWJnVms5dVAxd01JVWZaeWhkaGc4RGNFbFFyVDZ3ME8w?=
 =?utf-8?B?WGJBZDZOanMvdGx0djJiM2ZLNWdPa082S2xxUHduT1l5MDFGL3owN0Z6cmIr?=
 =?utf-8?B?dkt0YjRjd2l0ZXdGSEFEY3I0ZGxDUE9TS0RNMkpEM2xERGVpcDdiKzQxYURB?=
 =?utf-8?B?OVRKQ0lzQmZ2dFdqaG9LdkEzU2pjenpSeGlnZDI3MkhCbnFCbGxzMC9HN2ZQ?=
 =?utf-8?B?dVB3WUJuTnc2VnJTTlJxZ2poVUJHaUNWeXJuWmdmdzlyRmVBeHRqT2tWWnNH?=
 =?utf-8?B?V0NES0xrWi9RS2lNVUpTWGVha0szdXV4aS91cmltcEVIVnRlNTBqZUIzK0d6?=
 =?utf-8?B?d0RRSXVMK1IvaG5LR2VacVdzbGJhRThwYWxEMkR2allTMmdkbXFwemhlNEho?=
 =?utf-8?B?aHloR09MaTJSWkw3V3Y1TGtlTElHdmdsNW5BZ0VZeDE0OVV3Yml1MWV1cXpM?=
 =?utf-8?B?dGJkY3J2MHBwMVZzcm4wQmdWTGlrekJSb3RYNzhYUnJlUENRZXoxS0kxZHBz?=
 =?utf-8?B?cHVOaXVzUGliOWFpMHJJT0NQbUFsdzM3VzI3bktDc3IzRWplTVBSZE95ZmI5?=
 =?utf-8?B?RXBnVU5hVWtLMC9DajhveWdvNEdaMVJIbklkSXhyRGZWVUtqQXFSM1lwM0dF?=
 =?utf-8?B?RVZ5MGQ3SjVvdEZWT2lGVlVMZWY2THNUandHZmlMYmZIT1hpeHV1QW9jYUlK?=
 =?utf-8?B?VGh3eTEwMXlCa0xUZmlQSktNZ3dXaVhDUVVndmltRDdZdWhzeUVRa3l1UFBv?=
 =?utf-8?B?VDFmbFdUNzAyYW9XWG9WTlZUQTdHeEF5WjRJVmhBZlFGUlBONXNyNlk4cHZB?=
 =?utf-8?B?V1dYbmQzTkk4MWwzNTgwejNjR0NrSUpjcG9mNXF2L25Xa1NZaFE5enczRXcv?=
 =?utf-8?B?bElGeXhsNERHNkdSMlU3VnBpQW9iWldiQVl1VC9TOWFWWnVQYjN5bUE3VUt2?=
 =?utf-8?B?enNJZTB0U1J6WXJDNU5qUmg3THFMTHZQd2xhNHpoUkVObTU2SW5NLy9aQ3Nw?=
 =?utf-8?B?MWpQaGNwOWlhUWxEKy9xcHp1Z1FwNDBnVFVvbmJhM21VaGhIQUw1a3ZDRkhx?=
 =?utf-8?Q?ukIHaLiNO7/H+HChTibIZEnpCYmo7DNw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXRmUlFSYjRDNndjd3BxclFLcXVubTdGNDd6cittMGVyR0tkaVdKMzVzUzdn?=
 =?utf-8?B?V3RzbFI3bEQzeE4xMVBFeTNpYWhxTEFuaGtnL2FuZUVESzNoR1RrSjY5S1pz?=
 =?utf-8?B?Q0s2RFZFNmlFbGpqdHJOdG5uSEMwQk1Hb3ZzRFc4QkQ4dUxqTXBOWGFQbFF1?=
 =?utf-8?B?U2ZNcXc5VTRWdFhqSlNzbmFWSldqYlRtSDNpSFFyQmZDL05XM2VlK0pmaUNx?=
 =?utf-8?B?aUVKaW9XZStVUHVVUkJsMFdJZTlQMkpneC9TYWU0ejY2SmgvVEhPUDd0NTNq?=
 =?utf-8?B?TzBFdmpVWGg5dEtTY0E0blJzeDQ5dzZaLzVmaXNaSmpJekt5elNQZFhBbFRj?=
 =?utf-8?B?Q3dqT3pZenFGdEd3OTlDZDcwMVRJTS8xMlpRRjNVMDZQSitiR3ltR2ZRWEFx?=
 =?utf-8?B?aE1SaVQyZC8xWC9wdjZ3V0Q0L1pLdFNBZHdxZm1Dd2x4dWVJZkhnb2NOdVNn?=
 =?utf-8?B?eHhTbXExMWxmVGhyT2QrdGc1eWtFVnpqemw5am1RcDVQNElyL2dYaWNVTjJp?=
 =?utf-8?B?TXZHWmNuMWtWRFZIMm1VT3p2SVducXhqcTB4dk9qTUhyL0RqckxtckptcFBs?=
 =?utf-8?B?QWttRElGZjdRaGNJdUxhbzluc0tadzYyRUttL2daamxZQnJMRFp5a1J2SmpQ?=
 =?utf-8?B?T2ZJQ3pFT3UrSUt6a3kxZUFmdHdvalFtR0wwR1BzVktNcUpZMXE3OVYwVitF?=
 =?utf-8?B?Y2JOUXc5dVhSL2MxR2VjNFJ6OVViOXpyR2dxTFFZazgyckR3S2g0S2hUWTg3?=
 =?utf-8?B?UHNtMFhaZ1FrYWVsbGk2WHl5YnBXems3TWIxckpCMnVvVVNmU0liMUVhM21Z?=
 =?utf-8?B?a2QxVkJmOXFQQnpIKzJkVUdIRWJjY05ZQ3Fpa242eW55dmxZUFFaZlBBWThi?=
 =?utf-8?B?bDdwbUdkZTdyWEZORlZjMmJWVVlTdWh4UVJzWmx5VTE5dzR4YUVsdGFodks2?=
 =?utf-8?B?VTR4QjIrb1o5bTZGczE0VWlaeSs1R00veWh2VzVzZVB0SWNzS2w2UFVTUy9N?=
 =?utf-8?B?T3VrOW1CaWtvUGttQkJPa1FqaXZMZVBHREVqeTNTd1JXRXl0VGRhazhaOExP?=
 =?utf-8?B?NnV1N28xUXdPR2tYWWtra3VyTHovVUtBS2FIOXhBR3JkZzFSVkhWdXhIenZZ?=
 =?utf-8?B?NUNoOWo5R3VaZ2Z6VDRPOUlSMXhueFhkRW91WjFyUjc4dVZVdnIyU2VKRHpH?=
 =?utf-8?B?R2l5Y3dyNElINlphTlR0cG5VM2JGa2IyMDk5c1Jzb01Dc1ZrWnFSZFBrVDJL?=
 =?utf-8?B?aUhtYkdYZjZvMEJBZnFmaHBaK2g2REY0OW44QWdTTXNENVF5TExYd1p0LzJV?=
 =?utf-8?B?NlNodDJqNkFnMVMrbjVxYkZ3RFBTN3NWaXNWd0pEUHFiSlhsUHU2S3RuZVZM?=
 =?utf-8?B?V1p0cVBuZ3R4QklMUWtDcmZGU3pSV3ZXdlREbGZ4cVZTSEpZY2hUWWxsRENL?=
 =?utf-8?B?cEROU2pqQXJGWWNBOTVETFZTTjBkTFFZU2N3aUExUzJ5U0Izem81bEZVbDdQ?=
 =?utf-8?B?ajB2V2xOV2JUdEpLSjZseStQazhrdEhvWlRDRWNGWElJN0c4ZWZDVE51SVJm?=
 =?utf-8?B?cDhJNGFWN2tITUJ6bEljU0xsM29uejNlV1labXJra2RlYjlXYXhwQVpmUHhv?=
 =?utf-8?B?QmhsdDhIV1o4S1dJdERDNmVzNVZLNGVGWVl5QkZDTDhzVEJBbE84ZGFyNU1p?=
 =?utf-8?B?dTI4cCtXMlNjWVFlMlVKeE5Rdm9yYXVOanlwMHc0Nk5SWk5MZkFDaEJwbTN4?=
 =?utf-8?B?QkhIOVNXaTdWQm5zMUxJRlBJeEhhWmpiZUJkZjVDNjc4RDZCaHVyd3lTeWxF?=
 =?utf-8?B?RFB1cHhkWnp4MWV5cC9pcHBQMEV6OVVlZWRGbTJodXlYak5EWE4vQWhmMVVz?=
 =?utf-8?B?WFo1SHl0VnhoZ0ZTTDcyb2tHazF6VjF5OW52OU5zZnAxQlR4YlVMRnl5L3Qx?=
 =?utf-8?B?bzBteDFSMlNTTDRnSGZrTGxKNE5FNkFmdW1oeE15MEdNb0NOblgrTkNxZTNS?=
 =?utf-8?B?RHRoUHl3b2NuZ1RLem9NbDJlc1ZWQlBIeDBBSDd5QmdkVlFuRk4rbUZxRTFp?=
 =?utf-8?B?eDRIREZlSEVOcjdJSDVMb2pHUGt6bTk0MmoybjZnZ1pETlExZFpKOVhzeEpZ?=
 =?utf-8?Q?TdfAjYIdNw8HKWV1QFmAGnJAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdabdce6-a477-49da-feb7-08de33fab3a8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:34:58.5962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ6ruk73RJ+U3uf2EOuX3VQ1x8B/bmV/ZqO8ObwkV25SUH4OnHjPG+CXrvXhK5mH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
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



On 12/5/2025 5:06 PM, Li, Chong(Alan) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> Does this really require a function? Why not keep hdp_flush_mask in amdgpu_mes struct and initialize within mes_v*_sw_init()?
> 
> 
> Hi, Lijo.
> 
> Thanks for your comment.
> 
> The original code handled ref_and_mask assignment for GFX and Compute rings directly within emit_hdp_flush.
> This patch implements a new helper function, get_ref_and_mask, and extends the scope to support MES and KIQ rings.
> 
> Centralizing the management of CP entries in a single location improves code readability and facilitate future maintenance,
> 

Here also, it is implemented as a ring function and the assignment is 
not getting centralized for all rings. Moreover, the ring function 
remains unimplemented for other types of rings.

Thanks,
Lijo

> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, December 5, 2025 6:21 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
> 
> 
> 
> On 12/5/2025 2:05 PM, chong li wrote:
>> both gfx ring and mes use cp0 to flush hdp, cause conflict.
>>
>> use function get_ref_and_mask to assign the cp entry.
>> reassign mes to use cp8 instead.
>>
>> Signed-off-by: chong li <chongli2@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 15 +++++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 +-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 40 +++++++++++++++++++-----
>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 40 +++++++++++++++++++-----
>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +-
>>    8 files changed, 87 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 895b841b9626..73305f07ddd9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -556,11 +556,22 @@ int amdgpu_mes_reg_write_reg_wait(struct
>> amdgpu_device *adev,
>>
>>    int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>>    {
>> -     uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
>> +     uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
>> +     struct amdgpu_ring *gfx_ring, *mes_ring;
>> +     uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>> +
>> +     gfx_ring = &adev->gfx.gfx_ring[0];
>> +     mes_ring = &adev->mes.ring[0];
>> +
>> +     if (!gfx_ring->funcs->get_ref_and_mask) {
>> +             dev_err(adev->dev, "amdgpu_mes_hdp_flush not support \n");
>> +             return -EINVAL;
>> +     }
>>
> 
> Does this really require a function? Why not keep hdp_flush_mask in amdgpu_mes struct and initialize within mes_v*_sw_init()?
> 
> Thanks,
> Lijo
> 
>>        hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>>        hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
>> -     ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
>> +
>> +     gfx_ring->funcs->get_ref_and_mask(mes_ring, &ref_and_mask,
>> +&reg_mem_engine);
>>
>>        return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>>                                             ref_and_mask, ref_and_mask, 0); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index a1fb0fadb6ea..adca4396658e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -250,6 +250,8 @@ struct amdgpu_ring_funcs {
>>        void (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid,
>>                              uint64_t pd_addr);
>>        void (*emit_hdp_flush)(struct amdgpu_ring *ring);
>> +     void (*get_ref_and_mask)(struct amdgpu_ring *ring,
>> +                             uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>>        void (*emit_gds_switch)(struct amdgpu_ring *ring, uint32_t vmid,
>>                                uint32_t gds_base, uint32_t gds_size,
>>                                uint32_t gws_base, uint32_t gws_size, diff --git
>> a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index aaed24f7e716..aafd34ddcfcc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -8616,7 +8616,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>        u32 ref_and_mask, reg_mem_engine;
>>        const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> adev->nbio.hdp_flush_reg;
>>
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>                switch (ring->me) {
>>                case 1:
>>                        ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe; diff
>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f4d4dd5dd07b..0ada69d0cc68 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -5829,29 +5829,50 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>        }
>>    }
>>
>> -static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>> +/**
>> + * gfx_v11_0_ring_get_ref_and_mask - get the reference and mask for
>> +HDP flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v11_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>> -     u32 ref_and_mask, reg_mem_engine;
>>        const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> adev->nbio.hdp_flush_reg;
>>
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>                switch (ring->me) {
>>                case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>>                        break;
>>                case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             case 3:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>>                        break;
>>                default:
>>                        return;
>>                }
>> -             reg_mem_engine = 0;
>> +             *reg_mem_engine = 0;
>>        } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> -             reg_mem_engine = 1; /* pfp */
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> +             *reg_mem_engine = 1; /* pfp */
>>        }
>> +}
>> +
>> +static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     u32 ref_and_mask, reg_mem_engine;
>>
>> +     ring->funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>>        gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                               adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                               adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> @@ -7235,6 +7256,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>>        .emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
>>        .emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
>>        .emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
>> +     .get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>>        .test_ring = gfx_v11_0_ring_test_ring,
>>        .test_ib = gfx_v11_0_ring_test_ib,
>>        .insert_nop = gfx_v11_ring_insert_nop, @@ -7281,6 +7303,7 @@ static
>> const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
>>        .emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
>>        .emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
>>        .emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
>> +     .get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>>        .test_ring = gfx_v11_0_ring_test_ring,
>>        .test_ib = gfx_v11_0_ring_test_ib,
>>        .insert_nop = gfx_v11_ring_insert_nop, @@ -7323,6 +7346,7 @@ static
>> const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>>        .emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
>>        .emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
>>        .emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
>> +     .get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>>    };
>>
>>    static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index f9cae6666697..0bdb4f292dea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -4385,29 +4385,50 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>        }
>>    }
>>
>> -static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>> +/**
>> + * gfx_v12_0_ring_get_ref_and_mask - get the reference and mask for
>> +HDP flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v12_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>> -     u32 ref_and_mask, reg_mem_engine;
>>        const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> adev->nbio.hdp_flush_reg;
>>
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>                switch (ring->me) {
>>                case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>>                        break;
>>                case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             case 3:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>>                        break;
>>                default:
>>                        return;
>>                }
>> -             reg_mem_engine = 0;
>> +             *reg_mem_engine = 0;
>>        } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>> -             reg_mem_engine = 1; /* pfp */
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>> +             *reg_mem_engine = 1; /* pfp */
>>        }
>> +}
>> +
>> +static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     u32 ref_and_mask, reg_mem_engine;
>>
>> +     ring->funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>>        gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                               adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                               adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> @@ -5515,6 +5536,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
>>        .emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
>>        .emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
>>        .emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
>> +     .get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>>        .test_ring = gfx_v12_0_ring_test_ring,
>>        .test_ib = gfx_v12_0_ring_test_ib,
>>        .insert_nop = gfx_v12_ring_insert_nop, @@ -5557,6 +5579,7 @@ static
>> const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>>        .emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
>>        .emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
>>        .emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
>> +     .get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>>        .test_ring = gfx_v12_0_ring_test_ring,
>>        .test_ib = gfx_v12_0_ring_test_ib,
>>        .insert_nop = gfx_v12_ring_insert_nop, @@ -5599,6 +5622,7 @@ static
>> const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
>>        .emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
>>        .emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
>>        .emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
>> +     .get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>>    };
>>
>>    static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 66a4e4998106..176658846b81 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -2070,7 +2070,8 @@ static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>        u32 ref_and_mask;
>>        int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
>>
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>                switch (ring->me) {
>>                case 1:
>>                        ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe; diff
>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index e6187be27385..bc1d0870cb2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -5382,7 +5382,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>        u32 ref_and_mask, reg_mem_engine;
>>        const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> adev->nbio.hdp_flush_reg;
>>
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>                switch (ring->me) {
>>                case 1:
>>                        ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe; diff
>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 89253df5ffc8..418b8daa7097 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -2820,7 +2820,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>        u32 ref_and_mask, reg_mem_engine;
>>        const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> adev->nbio.hdp_flush_reg;
>>
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>                switch (ring->me) {
>>                case 1:
>>                        ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> 

