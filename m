Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1497D25934
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 05:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B0B10E289;
	Tue, 27 Jan 2026 05:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vd0daM0K";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A64510E289
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 05:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqQdGF7j/khgNOHvAfR9rtY9jTqGoMHf6hgD825q21KNvG+iyztf3hAMj5bneNvO/bqZA0G308RIaOCAXqDfrabvKv22ipC6Lf9TPH0QcoA3ABlsaCfNTYhacsMXE2IdI9qIR885Q/2NwyISzu7mYPU/E25+rDgr9DKrFTF0VfwNV9csskMM58sP97cbVAuRBWVhKfOE14XeWcq7efOWCtNyduYKhIFgBqb8Ua6P350WITNwS8GjCaJvsu7QfixHzZn9jPp6IjtZsBsvIqe2G44ikMhTZNIdqygxyjpB2R2Y5CX6BIf8HNkXHhRx4VUQm2U98NTkBlxz9MOnp/X6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTmUXi3g8QhF/fGjqIr4d2hDqc2OqsQPfu1Wa1GnRvE=;
 b=GGEkYqjjP1/w4uN2Udb/1Cr4Powd7wZPf5otEZDx/Pst/1AqQljckRuPb/Wx65xJNpUGz3J1p+5A8LlyLt0IsnZHAX/x3NbH39Q+JtkYLUVT01p12Xu6NGPr8bIzlvpdAaUPRBS5tpkMpryr2Arubky90oEcci87NckrlmX7+RlfcwTF1nxn/OoxL4Tqu5XsG0r9yHThR7KgHSinh+EpxElBel6AvA0zslAtS4fSn+WLPxyi90VxiQpHKlCnF61FgFSZ90462gaNjx6/1h7ArarG6/y0dQPnZ7rB7FQsK6fJKvE2OhFiphCsDB8OiWdG6zYtAGNpPNN4p4v1XrRSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTmUXi3g8QhF/fGjqIr4d2hDqc2OqsQPfu1Wa1GnRvE=;
 b=Vd0daM0K25zNvqe9T0BI2jDHALp+a5+033ErEqrMMRTdj2vtidlfvXXgTPaYYx3Ln6DYVLH/IKawTjB9/2vAQVQv2P6rdIfumuVm9hQBtZjLNm+WNf5OcAskWXRX9uHIHLWFDmqmcqrK4YKZ5JAnL2FzAHQN8X9j3QeTEKRDLKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 05:35:54 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 05:35:54 +0000
Message-ID: <d7e73dbe-fa0d-42ed-8b16-fee352e8b662@amd.com>
Date: Tue, 27 Jan 2026 11:05:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-5-lijo.lazar@amd.com>
 <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::23) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddad3a6-6ef9-47a9-2c88-08de5d65f051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tlk2QXZuSDh1TjUweWZaUisxV2lyb0szR2p4aUMrSXNNM2RBY0puOXRoVVNr?=
 =?utf-8?B?QTk0aXBNWFpRU0VJWU5naFZmbTZ1UlIyTHk5eUIyS052R1JhQy81cWFEVmMw?=
 =?utf-8?B?aEtZK3lYVVpRdlhvL0ZHUHR1bXhMMGhvbHloMDBBQ2RtTTVlQVFodUp5dnUz?=
 =?utf-8?B?QmpGNU4xUW54RGJmQ0NYRURiak5KZjFiTGs2NEJqWGdVOFhnSUIxbXA2ekpL?=
 =?utf-8?B?STQybGVNK0pSNnpnWlJmK0ZKMVlMWmpjd0tBbm5IamJDZXRPVkRnVWRleWli?=
 =?utf-8?B?cFNwc2E3K1JsOHRSMG4xcE1wRVRWaHVXUktBZ1NqT1dZcmoxVEE1QkxiY0sv?=
 =?utf-8?B?dS9qMVI2VmFXc0o0VEZoTmdEbVp4V1pkM0pjVkVndEFXZ1E1K2FLNEpYaUl0?=
 =?utf-8?B?bk0vcDZPZldHWVh1SlhiWE9hSkhaOGZGMXNXaCtVWkV0WWE5aEdBcC9GckJW?=
 =?utf-8?B?bTVwNm5mem5udWhkMy94R1ptd1RkbXNQVjcyZFFQVVlsdnVWajZoYzB5TE1V?=
 =?utf-8?B?dStwUmdGMmZYSkF1NVZiaExXRVZkUDZRaGZiR01oSTRRcmdkWlNYcTRlSGRY?=
 =?utf-8?B?dGNRTHlxY3dWZkczMmFINE9odUtPV3VVWDRCSElmdXBJQ05oVElzTHd1MDlM?=
 =?utf-8?B?cnB3OW5ib0hwMktkOTJqS0Y3aWxHck5tTU9zcnlHMmt1TVdUei9kem5RS08z?=
 =?utf-8?B?SWQ2SHNray9WaTV4ZTBkNkFYVCtwQkJXVWExSEZQVTZVcEdHZThCb1llUFRO?=
 =?utf-8?B?cVBHdGlGcTc4dEFTbGhrcEJtTU45dVVoOVA4TzY1bDB6SVRaUDNVTG5nSHIx?=
 =?utf-8?B?all1SVRHbTRoeHVsMVRuN2lkZVFIWGJjZWpNVjc1M2tEaUFCbXpCSWxaRmFQ?=
 =?utf-8?B?UFB5ZmF0TFNUWDd2a3FHUWpwNjYvbTIyMnpVSHZkcm1wMkJqbi9DQXZRRWdS?=
 =?utf-8?B?ZmltVW5sL2V3c0x3RFIrMGk5UjZKR0k5amx0NVlISFI3ekgrZGw4UDhLdGlS?=
 =?utf-8?B?eHQ2U3FDdC9lRmVNeXA5bjQ5c1RFMzMwejIzVGtvQ1ozRHQvRmFHcGw1Z0E3?=
 =?utf-8?B?UzdOZnJpNVdDS0hVdG9NUWhiSU4xekk3MEMwblVkYzRHa1l6VlBBcnl3M25i?=
 =?utf-8?B?ZjNYUHp5MTJRSlhlSG9HTnN3Y0VaSlJQb1o5YVJVWTJ1a0JYRGU4TjZyV2tR?=
 =?utf-8?B?R2ZRcUNmQ0F2VksvV2pMRmNCOXFVR0R2d2tmZXlKQk1iRnlVTk9xK3NhY0J2?=
 =?utf-8?B?dFdYUy9iN2NRUUJEVHNkTmxHS09kUGZhQkJiQmxveHVhVGYyNHNFMFphZ0c3?=
 =?utf-8?B?YXVZNStpd0NnM3VsTGZjTHdZMTBraThVb2tORDZ5c0V3RzdmVXU4OUVLWXRI?=
 =?utf-8?B?Ti9xU0VnYTBVcGFYdlo5eGFNQzAzempBK0RtUHFVSDVNMFFUaHR1dUlJMm9Y?=
 =?utf-8?B?YjZ6TVNSZEptbHJaOE1NdU16OTNXaEczbEdIeEhQTzFNOGdad1YwTzBLMFM1?=
 =?utf-8?B?dVF0ZkJBRkE3SkhzN0pMYjU1Y1RTSHczclc1Rmk3RUJXcU9JQ0dxZXRSUmRT?=
 =?utf-8?B?ajBxS0llZlowQXhMT1Ryem5hZktLNWFubTNpWDMweUpyTEtIcitMNEFiZnly?=
 =?utf-8?B?czYyTW5tUVFISm02emw1cll6aldqN3FmaDRCbTJxNTQyZHorOGt0V1lkQm43?=
 =?utf-8?B?bG9yYUVOWjFXVzFMcDVBZVhhRlJBUEVCMGtzM0dKOHlTL1pDUWpPTjZ4UFRH?=
 =?utf-8?B?dE1XU1FGVlZpc2M4aExyc1pjczV5UkpPM0U5ZWZ2REZ0c2tMUERjdlFIZkVD?=
 =?utf-8?B?RkdrMVpiRjdlMjZOd2h5Y3IzWXhjYS9PcEt6dWxMTFcrTXFXQWFYd3dCWktz?=
 =?utf-8?B?YlNMRWNXeUx4NlR0SldKMWo0RFlRQkhJRE5mVTc0bEdaUDhLbHBvSkh3cUc1?=
 =?utf-8?B?SnJidHhDY3pRWTFFQTFEaFJjUnhuc0RvQmpKSVY2UWRPd2w3ckNyUmFNVVY3?=
 =?utf-8?B?VUlSQVNSNmNzTHN1WTQ2NGNSakFBSWZKWXlmWHovSDB4NEVhZXo0OStHb1ZJ?=
 =?utf-8?B?T0xRM3B4U2NaTmVqVk9hTlIyMXIrY3NuVVFkaGYxZHloVFRINWNBaUcvSCt5?=
 =?utf-8?Q?kQWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUwwWE5UYUtJNllnMTMzS2FDUHhXZmtEcW5uYjQ2TStYd3BVdjJON2VMVlo3?=
 =?utf-8?B?V1Z2c2pMMDN1SFpDa0grY1E5WDRCSW5Jak9hOHZRYm5VRC9PdUNMa0daS2pG?=
 =?utf-8?B?K2FZazM2aE9xUmloellvbCt2NzJpbE5NOFlIZFcra1BJcTkvTmVzalR1eFU2?=
 =?utf-8?B?S0loN2NwWmRwZjA4aFc5YkNkVGpseXlOSDVQbFBEQk1xM2I2OTZiVi80UjAw?=
 =?utf-8?B?VzZkcXp6NkRGSTlTUEtnN0FNZ0NvUDl3bjJLdzI1T3dDV0ZENXNROWJXbmNy?=
 =?utf-8?B?Nys0VlQrNXdqdWQvVmZzOTdJZ3drQTgxRTdxWWUrMmdQRmlWa1Z5NzVnL3Ja?=
 =?utf-8?B?ZHFkUFpTZFZ0ZFZMOXhBdHE2QytuQ3EyNkIzZGRob0xxZDVpcTFxeDVUYmFj?=
 =?utf-8?B?M0pMTE94aHQwNm8yVXc2eFVDcXFWZkZ1eXFDdzZPTUk3VFZGTEx3TnZoYlN5?=
 =?utf-8?B?SFQ0eDBEaHpYQXdycFVzbFRWNFNjVnBXSlhvWWN2U2d6cmduQWhaL0ZLN1hE?=
 =?utf-8?B?eDBSeVdONU5YWkV3MFdyb1BTb1h2TDFWSkRwZUxsUnRmYkVtNVlxdEU5VEY1?=
 =?utf-8?B?bE9pWUZ5TW5xc0pDNHdjaDdVRUFoT001ZE1jVWJxLzJ5c3RsdGpRY013Sy8x?=
 =?utf-8?B?ZS80NlhnY0kxeW4xN2NhSWpxaGdRSS9pbGpTVVZwckRLSXhWK2NYWjZzZkYy?=
 =?utf-8?B?Q2MvOXpaWFFyeSt1ZjU3Vk1WWnJ4VmFYcnVaV215Nm0vVXBHYmdFWXNsUUJ0?=
 =?utf-8?B?S1RlYTJBZG1yRm5xNlp5REJXOGtkVEd3WDMzUEZ0U0NyM2p5LzBEaEVmODVy?=
 =?utf-8?B?VjFoQ2tlV28rL2xvcEhDL3dlcHRtdjZiQ20xbDVQU2Z6YU1iSCtpSGhrMnJT?=
 =?utf-8?B?MFZHTGozQStVNHRkV3NDOEtvZXBvSmxnV0JEdTVkYm1qZ29JaENyR0pKb1pO?=
 =?utf-8?B?Y1VhZkJPQWtFQlFlL0N3aEtiZkVOTWZPeFdmTE1zUFVDYlBsL0g3dTZQRWY5?=
 =?utf-8?B?dnNvUWpKU2dHSXFYZzdwc2cvYTVSYmNsdThEa2p5SGlSK3I3M1ZuYTVYYndh?=
 =?utf-8?B?Zk9ISVMvMm5taWVleUhtSHhZRndkL1REZkM5T2ZKcC95bGNPek9CeE52WDVx?=
 =?utf-8?B?SDdzRkNPRmhjNkIxUy9rL2kyYnB6NXN1d09CRVd6bDk0bWt5d1JjMGtxelJx?=
 =?utf-8?B?WnpJd0w2VzBlOElSTFVKWTZhUWp5c2dPYTBidW5BQU83dmlzSE1QUjJOdFk3?=
 =?utf-8?B?NkIwMWdndHlWb0ZZOUdLYzF5bG81U3pPYXgyRDQzeFMxRExpL1NmdlN6eFF2?=
 =?utf-8?B?T0l0QVYwNTFxLzJNdWMxOXNVaWhZT3NtL0x1SlpyUEIraTJHWVpHOXY2T1BR?=
 =?utf-8?B?Y1VTQ2ZEQjA3cW1LOHZ4aHhwdHMwNGR2Y1d4eDFWWkdUT3ZER3FFNEZsSEgy?=
 =?utf-8?B?TERkaldkN24xN3hYb3dVdWdCdkpmb3RDTFhkaWRaTjZFSCtTU3BpK2JMc2xn?=
 =?utf-8?B?MFJuVHQrcHdQeEF5QUJrOW5vNWU5cHNEUFZaWS8zbGlHT1hxdFFwcXV4VXA4?=
 =?utf-8?B?TzdyWXU0NUg4am1UaFRWZEdUTEFTYU5QZ0thT2U4QkZRZlVkdFlsV0FDNHJY?=
 =?utf-8?B?N2t2NzJSTDh5dEJUTmJxNXBzbWNSV1lzN0FOeUYwY2ZaUWFzS1VseElKTU1o?=
 =?utf-8?B?N3JWNmlGa0RrUmo4TCtlVlVEOHhHRzN2UkkrRm11bFlRdHROREh6UlJIcE53?=
 =?utf-8?B?NFZOaVpOTldqUDdqN2dNUURmaDMrSGtUazlCZGlXMjFLdGkvMVFicTJvb2dW?=
 =?utf-8?B?SE00SithQ3IzYkc2UUFrTGRnNjZVTUM4K0JjUE1ZSnpHVEV4aHBQVXdCQk1N?=
 =?utf-8?B?Y3FLS0dQWEVVK0N2Tmc2K2ZyM0FBbkhlcFF6UnJGY0IybEpkekVTcXkzQjVw?=
 =?utf-8?B?aTROZE5PcmZNMFp2bnNXbmUvdW9VbW0rbjhiR3ZhN3ZVQ2hkVXd2Qlc5dGsy?=
 =?utf-8?B?dzJHSVlTczVnaExmOUowQk03anA4TmxITmIySTZVMmFsN2ZzMEVNRGJzOXhX?=
 =?utf-8?B?eVhUcXcwTUhLYXBrWVdLNllhdldubXdaWSszOTdmNGZzdHB0RFcycEdLb0Jp?=
 =?utf-8?B?a21BY0xNcmRzcmxUbE1nVUVuT2Z6V1duMUpEL3RWc29wZDNaL3BodFl4YzdG?=
 =?utf-8?B?czI1QkV6SW5CMS83YUpWMHFwVTJZOWljYityYjFLVXpVMlN4UVpma2xhYzha?=
 =?utf-8?B?ZGdnWXpvdml0M25raWJ1N3VDbTZyM2hxcWFIT2JTRXFYdmdZV2J2RFBEUEgv?=
 =?utf-8?B?ZmxzKzV2NTJINjlVMGFiRDR3eVZ5RHh4SmNGVlBSc0hkOU41Rjdndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddad3a6-6ef9-47a9-2c88-08de5d65f051
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 05:35:54.1764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltTNX+w/BizEjnyHm3AHs2x+a5DlX9cvRiNVKLXk//S0dJb/fMZHOCy1DgG6PFfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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



On 24-Jan-26 2:14 AM, Alex Deucher wrote:
> On Thu, Jan 22, 2026 at 5:52 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> Add an interface to validate user provided save area parameters. Address
>> validation is not done and expected to be done outside.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>> index 80020fd33ce6..32d9398cd1d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>> @@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
>>          return true;
>>   }
>>
>> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
>> +{
>> +       if (!amdgpu_cwsr_is_enabled(adev))
>> +               return 0;
>> +
>> +       return num_xcc *
>> +              (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
> 
> These could overflow if userspace passes in especially large values.
> 

Sorry, I didn't get that. cwsr_info contains driver calculated values. 
This function returns the size required.

Thanks,
Lijo

> Alex
> 
>> +}
>> +
>>   static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
>>                                           struct amdgpu_cwsr_info *cwsr_info)
>>   {
>> @@ -425,6 +434,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>          return r;
>>   }
>>
>> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>> +                               struct amdgpu_cwsr_params *cwsr_params,
>> +                               int num_xcc)
>> +{
>> +       struct amdgpu_cwsr_info *cwsr_info = adev->cwsr_info;
>> +
>> +       if (!amdgpu_cwsr_is_enabled(adev))
>> +               return -EOPNOTSUPP;
>> +
>> +       if (!cwsr_params)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Only control stack and save area size details checked. Address validation needs to be
>> +        * carried out separately.
>> +        */
>> +       if (cwsr_params->ctl_stack_sz !=
>> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
>> +               dev_dbg(adev->dev,
>> +                       "queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
>> +                       cwsr_params->ctl_stack_sz,
>> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz * num_xcc)) {
>> +               dev_dbg(adev->dev,
>> +                       "queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
>> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc_cwsr_sz);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                        struct amdgpu_cwsr_trap_obj **trap_obj)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>> index 3c80d057bbed..96b03a8ed99b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
>>          uint32_t xcc_cwsr_sz;
>>   };
>>
>> +struct amdgpu_cwsr_params {
>> +       uint64_t ctx_save_area_address;
>> +       /* cwsr size info */
>> +       uint32_t ctl_stack_sz;
>> +       uint32_t cwsr_sz;
>> +};
>> +
>>   int amdgpu_cwsr_init(struct amdgpu_device *adev);
>>   void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>>
>> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
>>          return adev->cwsr_info != NULL;
>>   }
>>
>> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
>> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>> +                               struct amdgpu_cwsr_params *cwsr_params,
>> +                               int num_xcc);
>>   #endif
>> --
>> 2.49.0
>>

