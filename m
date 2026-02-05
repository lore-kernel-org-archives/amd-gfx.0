Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45529EC1E8F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 11:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D847310E868;
	Thu,  5 Feb 2026 11:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbgq1bW1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F4310E872
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 11:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOy9n1BJ4i5TWAELajRuhdoAJ4kSUzjnc2YhHRIaiN0M8xLnYlvb5NSgDiqbk/Z9n4Go3zzskIu12Q7C6TtT5Jx2lTx8sJvV3WxRCMZrk9uhjENK6M7AqVjbCN1lGzcZjynOKe3djin+0xSPBxasVjVBgAeHKBd1E6feh77o5NWzFLvViVaTbr2FX2p5rOoqFxMtYnkXMnNmrIUv6wSY5oMBaaB1mpTMGfyEsLQuM2ZGjP51ncCOk+Yj52R5wtK6woKM2+9mGPj4gaI7nleVS3Lqh5Gqqrq0Hsl48GfTzqSp7VH2PnzTKVe0NYQZQO//vmW4P9MzWmvcQL0ZVghLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCWgiJVR+b4lbv0QiGyvTSYiOBwp/txJDAV8j1w5cwE=;
 b=vjDZ54yzb+TS8xOU5cOjX69b6+2NNk6jAxTMWwQRdxfpRxy6AwDDNSb6sdymIu45vGh4HIqp0BL2r4zpS5+NODSf/DhFKsgb0atuG6ScyNrTztIzDHY2lUanpXkU+Y3gGpMrqabWUmqP3oXrEaQOO7SDZn1iDHvOUbsZYGcXlltfisxqKAKWk67XnQcf0hzcRbzEu4SUDtw+bAI65t7+BvgdWOMKcAB6hSllJdPBaaQdIx+ClJtETUMoa+In7RVjWxesI1nc3hklLzPt1+9KYp9yS3hsQvGHDSk5ewoMeXPKdqbpgfe0fyzW446mwsh/+p/C/rWp7vqnGw86B/K3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCWgiJVR+b4lbv0QiGyvTSYiOBwp/txJDAV8j1w5cwE=;
 b=mbgq1bW1GAs3A8eTr/hoUyO5HkBrR+MZ7CpHXehZ5U1Tm+PHJKCm+jc5kH3tT/4PauQFjcvT5gT7XPp4/y19h9k9a7ePVmn5za48LP/asx8wmdeH6e2CvpbxJ7/BNA8s7qQ/GZwh+h3XiI7qwMnmjbIBZWJN2m2vAwUvmRgd9nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 11:14:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 11:14:10 +0000
Message-ID: <d5788ae2-6ed8-4a80-8682-af2f4cd68d9d@amd.com>
Date: Thu, 5 Feb 2026 12:14:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu: rework amdgpu_userq_wait_ioctl v2
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-7-christian.koenig@amd.com>
 <DS7PR12MB600564F569B67F91D9AA6F59FB9BA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600564F569B67F91D9AA6F59FB9BA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0729a7d8-75e5-4a48-21c2-08de64a7afc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRUWXlhVmIxaFVwZnBiekdnWlgvYU9USzRSWG5KZDdoeHpnTGNlODdjWHhj?=
 =?utf-8?B?MEgzSUw3Z2VSdnRqOXBVVG91WWNJbStNdndYeGRVYnhWenlvR1dmbDAzMDZm?=
 =?utf-8?B?RFg3Mis0K244eDF3ZWlIT3pWdFhDVEVxMzA3Vk10V01jcW1jbzFwTnlEODE1?=
 =?utf-8?B?WmhBZy9LcWdTR0I0azZiYTByNjdRNzdYbkVUek5ZYjdXaCs1NEVuRW52Y0FE?=
 =?utf-8?B?MWpIbmxmcVVoMGxEUjZsRkFTdm5vbDBDbGROSm14ckcxbVRUalQ1LzlIZzV6?=
 =?utf-8?B?Q05mQ0Ewd1lubGlmRmMwRTZFMkRxTHB1M3lMNnhqcm1WQTlScGllMUMzRHZL?=
 =?utf-8?B?azNET3c3MHdZSXNmSkZsV3Y5Rm5sbjZhdDlneXFVRjVwdjRLZm1iLzcrV1dH?=
 =?utf-8?B?TU1DOTN2MXRaaXlyRndhUTBDbllDQkVqbXNFcmdJUUltT1RaU3hkU2IzODRs?=
 =?utf-8?B?cDZ2NlY5N3psdFFGeGczWm1sWmpjeTBSb0xuTzlMSTZlOFFtdFdSMXdCN3kr?=
 =?utf-8?B?ZHIxVVNNdGs0MDBUN2dBeG81U0pzQ2pSK0svdFE2amFPeU1xaXRZTllZcFNL?=
 =?utf-8?B?aGMzWGJ5L2hFenZkbGZFL0RKZkVIbW95OE0zRmY3ZjRub2hyNnltZ3Y5UzNj?=
 =?utf-8?B?ZEpJWWxWeW1RSEFDK2p6TGJLd3h0Q2JoVTUvcXRxdzA3clhCM2plNFZPbDRj?=
 =?utf-8?B?TFZTRkxvY3VKelVyV1p2RWVxSTE2U0RUTUJCOVBGLzBMRE1PcGx2MTJydHgy?=
 =?utf-8?B?QzdIKzJhS1NEcWRmem9oMElxc3FTT3MyWExreEV0elhXbzgxQVZ6L204R0V1?=
 =?utf-8?B?eExHN0gyTU9OWGFWSldpZlZRTUtoM2pjT0NYelBoc0JSK0R5V3RTM205OUZh?=
 =?utf-8?B?cHhxU2c2cnFmVzYvY0JhZHZzLzBFT0FsdGRXV2wzTDltUFhYbFIwSzdFeU1W?=
 =?utf-8?B?dnJWK3A2c0hHMGJmS2MwTktCbXgvTFVvaEd6NDRGSGJUY0RrL1JQd2Qxd1Rp?=
 =?utf-8?B?S0NsalZQS1Zpbm4yT21xT2tRdFREYndOUnV4UFFTaXZpK1NJUnpscFNkV0xh?=
 =?utf-8?B?Wm5zL2Qya0VrOEl6c2JCUGVNZEJ5Z1Rra1dIdEdINm5XdkdFZlBQcGhKRFN1?=
 =?utf-8?B?T2N5RnYwaWg5bGtEOEZMaUlpTndxdExwVE1TYmZSTUtwQ21uMDFDZGVtU0Rx?=
 =?utf-8?B?VW5sWWJNYkxQaXVGU1p3S0t2ams4eHB1NnArK1pYc3A3L3pDcEJVZkw5K1Fv?=
 =?utf-8?B?SUJ5THNHTFBFSkpGd3BhMVhIOE1rQnQ4NThSdHEzL0hTUy9pbHhvVEtmenQ1?=
 =?utf-8?B?L2kvMGdsNktqdkxiWW1wQVBvZDJkUFgyVzJXQUhOL2lLd3AwM1ZFZXFveUQr?=
 =?utf-8?B?Y0lWQ0ovMFEzUjJBT0V2LzNzSHNocmh2ajdzMmVDZWI4ejVaRFU2SEpWbTU0?=
 =?utf-8?B?UC82aDFTd1Nkd3hPbmJtOFVCc1I4Z2Y3bVhFRU5mTmtweCttcE8rWFYyZm4y?=
 =?utf-8?B?MDJyMWtpOVFkeFNWb05WUGZoSnV1aWVKQ1ZVZEtiL3VBdGlycmo1ODhLQWsx?=
 =?utf-8?B?T0VhdDllTForbDN3SGdOckV3SmZvREZuZXFOYUJUeitiNzYyRlVnZ1l2a2pQ?=
 =?utf-8?B?SUFJenppUGF0RVcraWt0Z052bVM2R1NxWVRyVXROWEhSR3ZCOWQ3OTF6c0Vl?=
 =?utf-8?B?RVRWNkJxSk45bkRYU2twZTZLeTc3VlZoMkpzU3c3eUdNYUZNcW0zcmJaaU9Z?=
 =?utf-8?B?ODMreVN5cDdhdWNEbTZod21lUnJDakpOdys3a0ROZWFPUHBGYnVNTWFxSTQ3?=
 =?utf-8?B?ZFNxQ0N1cDhGYnFRaFJTUWdlWXYwTTBJV3NHMmdXK3p4Ry9SSnRDV05SQ2sw?=
 =?utf-8?B?OW5jcUdOb1FQUEV3am9Va0h4dzlaYjBIKzdEK1N6djBXZmFwQUpaT2xDQk9m?=
 =?utf-8?B?K2ErQjQ4Q1lRQ0xCQ2IrT2cvSERrOGVEc2xXL0M0N1hmNjcrVWlPZnZxcWdz?=
 =?utf-8?B?RXl5ZldqdjFIbjl2TkRiNlYrbE1yNEpnaFFLU2tmNk0wamxJV1ZRRnFSQ3dI?=
 =?utf-8?B?R0QrY1FwL25vODNtYnlSelhZUnY0d2pWVjl3SWZlYUNyY2NIdTJBQnM2bWlm?=
 =?utf-8?B?TXRWaGdzL3Jzc3ZJZjFyRDZyRGlHUnl1czkxbER0OUhNVVpkZ2phcm5rK2Ur?=
 =?utf-8?B?VlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmgwbVhyd3Jta0lObHFvTG8vRXdZNHRxMTFjaXcvaXJyNmtlT01OL0ZmZTZx?=
 =?utf-8?B?UVdVVWZseHNhT2R0bUhVL3ErY1phWDdNaFNxOXlubjdhcFB0TUlPNkZTZ2RL?=
 =?utf-8?B?bnFLUitwVi9UcFVnekZXMW8zd3BidmZXQUJWeFZaZjV5L1dCRWRuY2REbU9R?=
 =?utf-8?B?ZGFyN1VoRm9iVVNrajVKTXJQbHNNejFEK0pRSWZTV1NGZ0o0ZmZxblM0WXdu?=
 =?utf-8?B?dk1Nb0U5ZS9la1U4S2UvVmV6NFdpcllrUU8zajJtT2dpWXFITDZBcTMyTWlO?=
 =?utf-8?B?UTFkRUpWOUR5cGdTWjFxOGcvT3NoYUpLTkNTazdodWhQYWRXVE1KT3pIaFd2?=
 =?utf-8?B?VTRORURjWXNZc0ZaRUljSHZNcWpRZzdCZ0gvVXBGeUZlZW9ycmN6YTMveU1o?=
 =?utf-8?B?cyswWSs2MjVnS0lJbS81TnVhcktHeDRwK2YrRG80Vi95LzhwaitGS2d2c1Vs?=
 =?utf-8?B?eDFMUWZield6MTMvcXBYREtRTFRHQ1lsUHlEOEprd0hza0x4cW5TR2xwYjR3?=
 =?utf-8?B?NjdrNkZjM0RuTDlBZ05iTlNuTnpqWlI2K2RNaUl1ZjZOeSt4cklNeE0vWU4y?=
 =?utf-8?B?OC8zTnZQeURxTjZTa0pCZ1NQcitPL1VhU2c4SSt3ZkVPdGhXK0dtZFlJMGpD?=
 =?utf-8?B?SjhMY2tsUGJ4M2szQmJFeGxMb1NXdzJ5T2RIaXlra2x6NThxNzg1Y09qL3N2?=
 =?utf-8?B?c2VOb3BMR29XeFpxN3FkdDh0Slo3aWVJa3R6VkZ6OXQ5Nm9jSXA4Z3JzNThJ?=
 =?utf-8?B?Y1R4MnBwbjJaMEJoNzZMeXkzRTE1ZFRQRjgreU8wdnJSSkxUa1lDL1NJSGlj?=
 =?utf-8?B?V0dud1E0N1h4d3g0SkFQVEUwZnNpTngzL3ZhUDVBbUJhRGppWUF0Zm4wSlJn?=
 =?utf-8?B?NG0xeEhLbHROR3BrVnNmTmE2anVNOTlvaDRETHg5bVNzb05ZWXJSRmlMSDMv?=
 =?utf-8?B?MVdHckdRU0twVXloaWlUWU1ZZk84bEJubDBjbnVpN0Jma0hWVUgvZ2xIL29m?=
 =?utf-8?B?MmlxV2JiVlJFRVRsK1RCWjVDZHBzYkd0aXRRSHBzaXR0Vnhmc01IaWNFRXJs?=
 =?utf-8?B?dG9oVi9BaVY1VGdnc0p5UFozVFRnczNSdy9SK3UvTE5CLzZ6NWc5VHlMSzNr?=
 =?utf-8?B?VFNtenpkRWVkUHZIa2RoREJLRlVGR29YYTJwSjBWUW5PR0EwbzZRekdoLzdV?=
 =?utf-8?B?VG16cVFCYTRPVDlPWHJNTTlYU0F1MGVBTTVnTFQ0SDRibjVzcEswQVdQQzBz?=
 =?utf-8?B?bUxKQWlhNWhmUWkyeDFERllCMnEwd2RvQlAwOFlITHVPMW5NNk43NW1jRE51?=
 =?utf-8?B?N2QyNFRKblhjVmVaNnE1Ny9XdnhjemI4WWdLMWZuZ0hYRDlKMEZQZjRmREpG?=
 =?utf-8?B?TExiczBnOFBzbTZiaXdiZFBlK09mQ2dhcWRCcVhXMWlmdFA2VGVXR0RHRmhX?=
 =?utf-8?B?a3h0QkZHK1RlUTE2TnJEd044WVZqRFVkbzMzMjVFdHRYNldUWTBTUnB1a0Q3?=
 =?utf-8?B?djJFN0V0NzlCV3FnZ0gvZjNUM3dsVExHbUpWRWd6TXUvR2ZPOEkzM3F3MjB2?=
 =?utf-8?B?c2g2cW4rWHprN1JVMWMxK2xWdW9RSTQ3Lys4eGZoY3RackQrRFc3U2JyOHRE?=
 =?utf-8?B?MUJ1ak9jY3RVbS9KMG1yOW9nTkRGTkJsdzFmMVhpRGhma2FjS1ZuRll5UmZG?=
 =?utf-8?B?K3RwblptQmoxOWVXVWpUcStURnROMVFuazQvUERpLzNvbEFJWGlHMGtDUkxS?=
 =?utf-8?B?RTFhdVFTZitaNmFuQjkyeTFmYVBFNGNDdmZUVXU5SmwzRFZweFJTb2w1YWZB?=
 =?utf-8?B?TzRXSUx6b3JHWnR2Z0hQbGJqdGlqNFdKdlJEY0JXWWNuNVJodlpmRjBQUG5W?=
 =?utf-8?B?eTEwais4T0VSeUkwZC9KeC8vTjNIV1hQenhBVlBzQlEvN0wxTHhZd2ppVDg3?=
 =?utf-8?B?REdhRk14TTliMkx1Q0pqa3J2Sks0QTRQWWZFSm1pQll4T0RGcVJKVTdSYkxr?=
 =?utf-8?B?OW5oamx0R0lNUkM1SGp6M0JaN0NzanNHOVkzUGV5eTJhMlF2aG1mUlpwVzdD?=
 =?utf-8?B?OWJaVitmUDR5TXFjdFFKQWRkd01VdVY3bEU2ZzhmcDNqSlJMS1g1VE9zSVkz?=
 =?utf-8?B?amNiamNBU0hvdUZTcjRFeUhaeU15Y21BOExNRVVML0ZtNmV0dXdNUkNGS1hk?=
 =?utf-8?B?TXFVS1o0VHphdHc3ZWRod0w5bTFKN0hPZ1dSSWh4TndqUmhSVUd4ZUR6SFNh?=
 =?utf-8?B?UnB5ckY4d0pxcFlvYU9ETnpWOVM1bGZCK3Y0RkdQaDVMcVB0eTBsenl4NmVP?=
 =?utf-8?Q?2vkF/OVLndN6JjkiA5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0729a7d8-75e5-4a48-21c2-08de64a7afc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:14:10.8292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QS8noZp63DcHyQG98Y3tp3r/7PI+PJ+SKfU+SEVO057SHo9oGVmGJhkoHkCF4XEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

On 2/3/26 04:39, Liang, Prike wrote:
>> +     ptr = u64_to_user_ptr(wait_info->bo_read_handles);
>> +     num_read_bo_handles = wait_info->num_bo_read_handles;
>> +     r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>> +     if (r)
>> +             goto free_timeline_points;
>> +
>> +     ptr = u64_to_user_ptr(wait_info->bo_write_handles);
> 
> 
> The gobj_write pointer allocation is missing, and this part also has some error handling issues.
> I’ve drafted an attached patch to address this, which can be added to the end of this series.
> 
>> +     num_write_bo_handles = wait_info->num_bo_write_handles;
>> +     r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>> +                                &gobj_write);

The gobj_write pointer is allocated by this call here.

We currently need to clean that up, but drm_gem_objects_lookup() should potentially be changed to do that itself.

Regards,
Christian.
