Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F1D4A613
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 08:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBA210E82E;
	Fri, 16 Jan 2026 08:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCQd+fqI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 152B410E82E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 08:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg/C6YSmd46wNpBba6cZYExbzh5ZaJxdFTLtiqbDEMOkknYYRRq66t4rqqHACN92zbQwreL9RpuR2Rkyer4gTyrfQ3TqQTQjprXPo6ddN6xa7qZyWAOXRIgLyg8ZTnD88cEZ1rAJTiAEZ1uN9+6ccgvRGklpLE/3y2QJGYynjSQg4gnPf0gdVZoGzv+5Z/qQtU/YdtOE71ZDXb+eb6n2BcYh3PKJjftAyfVATktzLUg1pAQ68BHzpCBGT8yS3EdCFmVL7X97qqUozVG+DA1ZxvKtulbDHXFz6w+ccEGxdMdjnQ8LHevV5OLsnwYSqWl55gVxkadtbry7WkDiry3ZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/v8vKNSJnjiR4AheqgOhAmO03jcJtOLltQ2OLxnQU4=;
 b=dRczwLFaqRHOpASfKhSJmtijcBxie0g4/AqGv7Tyu+ifgTcxK03BC8/ogIOe+cCxGN0CcsTPCJcCr23YZdB3T5lbmEsadiWvjmukPgFsN4Sfzxm/FInfUb10dZTWjU5DbogmVV7BoLKJARpVVNYrxFz4m5goHEEDbKBo5KMglfRua8a5s2+lto7Am233Hjg6cPi84qpkeJeYNgyUHln49wdv8jqR/Os4QTcHSKEHBg3wR18klVwAuoQ5Ypsnkmo4sbdjNdu4ISW7AxxGbNYyKh/4WS0vrfG2oMLnEXXOalIg1aHMe28nq3HO+8zhkhzvJJcJmI4gXwhhohkSe2fNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/v8vKNSJnjiR4AheqgOhAmO03jcJtOLltQ2OLxnQU4=;
 b=ZCQd+fqIlQ8SPRFiCrHu//jl2sUSnWrYEHCFzLh/ob1BMzc0n4/n3WCunkGDUaLszL0rbu3sbVwlaTYRsoUM8dzHgBQoqbnxl/mQ9jVWgujC8ctBcaEzOO8n1dTyN7TlDouUlhK9RwgCeVqriGZo9otrX8CkvPOcNewulwNXMRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:56:58 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:56:58 +0000
Message-ID: <1158b267-0b9c-4ab1-adda-c05fd5fd2eac@amd.com>
Date: Fri, 16 Jan 2026 14:26:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: initialize the smu dpm table by pptable on
 smu 14.0.2
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com, kenneth.feng@amd.com
References: <20260116080223.3014638-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260116080223.3014638-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: e07b934c-4506-4fba-aa8e-08de54dd3438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStFaVNvNWo5U2RNWFF3L3M1TFZlellSOUV2SVd0Q3F0NWd4REFldGlUMENk?=
 =?utf-8?B?bG03cmpzaHpkSE1nMUlldU94SnBaZnlCTUgrQkRjL1VWNFRjM0MyVmI1bzBF?=
 =?utf-8?B?QkU5Nkw2RVZqUHpLQjR2QjhuZmdBUHl4QnI3Z1ZzVjVYYkE2TFFWTjdWbzNw?=
 =?utf-8?B?dkhGcHcrTUh4Y2NuaU5wL2pLODNkY1VwMVd2RFlCTmE1cGpaY25GQkR2eWlJ?=
 =?utf-8?B?VXBBOWdlR0wzVDhCdHF2KzZleUJpTUlscFJmTlZDTWZBZUkvYzh3TUNGQUNK?=
 =?utf-8?B?RElHK0tpMXJud1I0L09Md1BSR2thVi8wYnBCT2pVM1Q1UWh2UktuYUpvWEp0?=
 =?utf-8?B?MXg3aDlyRWdRSjEvR01SOWt2eU5yNFE1U09DQnBLVFE1Yk0wNHhsejk0M2R6?=
 =?utf-8?B?bzJsSGdUeGhPVkYvR1M3UUtTcmg0VlVFaWI0N20yOFJGc21YaUJrWi9ZTzJ2?=
 =?utf-8?B?ODhrRU5XZjZCS2FISDQvSWhBK2VPbGs4ZUZXVExVQjNaNUo3Sjk2eGpiU3Bz?=
 =?utf-8?B?QXdtS0doNmRLWTl0RkgvaU15Uy9iN0VJMHZQbTVZSVJOTkRGSTA5NVM0b3p1?=
 =?utf-8?B?YWs0NWhrWS9sbjR2enBsUWYzYTR4ckVQM2NXN0tFOHMrOE1jSTEwRnRGemMy?=
 =?utf-8?B?cGU4WUQwVEd2c21OdnhZRmRVMngvVGJQK2taZjJrZkF0aERLVWN2cjUyVHNk?=
 =?utf-8?B?SFAwQ0R0M3lzc0tERldZNGY3QzVPNks4aHRPL3JVQXRndFRBT3pBTjNXY2pQ?=
 =?utf-8?B?SzhzNGtDTXl2OXYzd0ozT0tzclMrTWM4eFZuMitHU1c2a1JyVmZCUlkwTGZi?=
 =?utf-8?B?R1AvbzhuUEVvL3YzU2l0VjRQWm5ZUHdNU203MFprSTFKdTNWNjN4cHVpeTRE?=
 =?utf-8?B?RzRGQ2Y0eU5XZTZYZkdqR1JtTXB5VnhkVVZDbnNBd1dkYWVCVmFOdjFtSzEz?=
 =?utf-8?B?TUM5Z2JCdmtqdUJDMURkN3NzWkJBMFkxTEQyQjZPS1V5R0dEczRqWGZXZEVQ?=
 =?utf-8?B?ME5hcWhwN0UyVmFxT25WKzJEVzJUcGYxK3FjYWF0cWkvTkRuVUd6MzdhdzIv?=
 =?utf-8?B?dU52MnZ3Q1haTkNzVWhuM3dKNXIwM2UxbnFzQWpiSmgyREFqNmF2M0VoQVNh?=
 =?utf-8?B?QVBHcEZkV2dodkdTenA5cElTYVVjMXZBcTBCS1hDdkprQVkzZFVxMElOTmZS?=
 =?utf-8?B?LzZvTEJEcUM1WVBPVFRxRk52SnYrdm9NdlQ2M1I3bnl6NnBkSHBzM21GaGE4?=
 =?utf-8?B?YVdNTys0SHdYTWwyUUhBUmVxckhJS3hnQlVpeEQ3UXNMNHdoNGJxbVNEY0N4?=
 =?utf-8?B?OWZKdWJocjlWKzdIeG1MSGt4QUxKcjlBcG1aNFQyTWVQTmtYdUI0M0FJMXVa?=
 =?utf-8?B?TWZTRW5GUmdyczljOTUvL29wQVdiOU1GQU5CQVYwaG9LU1cyUE5nVW9uV3Mz?=
 =?utf-8?B?azZqclFBSTlhdTB3QTl1a0ZISzhodDZyUzRBa0l1dGJnNnZGS3c3amhHWUlr?=
 =?utf-8?B?N1liQTYxcElyZ2ptOUV5NnllVjA4dllYc0xoSURhWFlxbXJoZTFKWS8reW9u?=
 =?utf-8?B?TmxuT2lmKzgvL2pkQnY3bVB2NlFVOW1ERTk1bjRHZTJsWC9aaTNKbHZ2MlJE?=
 =?utf-8?B?TEFZT0UvVHNGYXI3ZnovdWZVdndyS3M2RVQrNEdoRW1Kc2NXeXJHcVdOUXdw?=
 =?utf-8?B?M1BKejZaMWpPeSs0d0U0NzVxTlVVSWtGcm9NUmtGb2hCakNpeUozdzVxejNK?=
 =?utf-8?B?S0ZoR2YweW9KN0xrYS9HQjVGOEpXZ0xPMGVXT0tIZlJTanZreWtuZkRjSjdj?=
 =?utf-8?B?QmdzV1BaM0FSaDc4VERSVFBIMkNYWmhiRlZWbmk0bGdLK1hYTG9xTXZYWHlX?=
 =?utf-8?B?Mm1qRVc0ZGozUlVtU2FHdkJsbUxRcWIrVFQrSjhVcDZvNVNxeWMxeTlNU0N5?=
 =?utf-8?B?eFhWRWIvTkt4OVlGTndueGN3R08vbVA0ZGtjOGRGZHo5WW55QlVCdkNFdUpB?=
 =?utf-8?B?VVBrT1JHc3RqY2VEK3JmcmEwU1dFaitRcGpEZmR3MUErZE9PZWNsR3JDSXBh?=
 =?utf-8?B?VzIrcTBIeS9YMFVsaThCT1pmZFNzT2R2Z3RxOENwSHRrTDI4REJUbTNkNmo0?=
 =?utf-8?Q?UgNI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1kxNTVTcVlIcDJOVXhuWFRRWm9NRXBvSVBxWHh0U2FLOVh5dVFJc0o1Q1Q4?=
 =?utf-8?B?YWszNmdFU0xlaFM4SWkyWFc4MWtCSEZ5YWQ0dkJvdVFjL0xyVU5PMFdTclRZ?=
 =?utf-8?B?TEhkMWl2SHVqeXpEcU52RlB1bENBM0hscUREUUJXQXo0aElLSnhRamJVTUIv?=
 =?utf-8?B?MHpJOWhEVS9BdkNlVExiaThBMXRNSnlxMC9tU290UnFPUWsvakxBV1JMZWhw?=
 =?utf-8?B?bHlMQTZxR0crZFFSaFlUM3podHJpL2g2SE1KYkI1eWpBUURPNkJ3aGcxMnBp?=
 =?utf-8?B?UTJpczkrcmZtZkpwRDFHSllRbTVEMUxhT2VMR0gvWko1UkJXbnhYN3hVb3pP?=
 =?utf-8?B?N3NTeU52Sk1zalRxSytBZDBwVm1ucjREay9GSHRyaXcydEtjd1VjMzNVSjBF?=
 =?utf-8?B?UEp4RzNHNm9EbUtYM3FjdGpwVFBkNUFoOUszRjVIT1FoUFppY3dmaVM0dTY0?=
 =?utf-8?B?R1h0Qm1jb3NKU0E2cWVqYUV3cXhzS2poUmd1Q0t4bTdhK2M4LzlEbmFDRlV4?=
 =?utf-8?B?Ym04MTZXMG1SUWhJT083WHBGVk8zVzZyQjBrRWxhS0ZmNVB6KytlR1dsYTd6?=
 =?utf-8?B?WkxnWTJEMVpGQlVtQnF2ejRlYnNLcmpwTzVhRkpzS0ttVHRYMUgvMVprRk5C?=
 =?utf-8?B?SjR1d3A3MjlKU0pTaWNDZ2pkaXFrMngwOU5sRkg2ZmpDd0lQOHc5eW9XTWcv?=
 =?utf-8?B?OWNKMmRwSDhvTG8wTVlSSjJPSElLajJ2c0F5SHBRckhzNDc1T0s5WExlNGFB?=
 =?utf-8?B?UUFEZzlseVVEd1U5M0o5Titia1psOHhkeWJycFlhUHFaUWpYYzJLbkdIMDdR?=
 =?utf-8?B?TUhPOVNlYUJtWi9FOFpzWk50c2V1bGR1ZWI3bkNvcG9rWkx1TDNhckx3Yk5M?=
 =?utf-8?B?dUUwcnV3ZXpaUkg3TkhtY0hjbDJUZDZJSG03OW1ZbXVHdUJ2dnNBYTRUTkpt?=
 =?utf-8?B?L20zVlRaemlWcDlOZ2VMTDBZRENNaWQzT0JPb3RxTXNTTUlMZzlEd0xpOWFH?=
 =?utf-8?B?UCtHSVZBZFNOYkhva2lITUJxenlvMzViZUFyT0RBb3lEV09BS3dxMFNSMm1N?=
 =?utf-8?B?SFNHOGJKSHk1Q1hWMGpWdThjTjIzQ0s2cnNXMWRCeGlvNmplZytOeGRlNXVI?=
 =?utf-8?B?QmlLVHJYNVJlSTZXdU1BR2lKWjRXOUV0ajRFSUpDaDFodjNwME5XU1Q0MmQw?=
 =?utf-8?B?VEVseTJiRy9JNUdxMGdFOExJZC9Gbm5lL2VpRUUxUkNhK0gyUFZqN242MStx?=
 =?utf-8?B?akdqeU14aDR0aVR3Y3E2TkIwblB2REgrcmRsc3Z4a01Bd0wxTW54Uk00UHhC?=
 =?utf-8?B?dlVXR0o5NlhjdGRBTlJGYmlRZEU1NnJSM2c2WlVGSWM0Ty9oMEo3eDNJYS9H?=
 =?utf-8?B?enp4Y3NGZ1FmUTJ5a3RCVDVqZHdhcFRnZUZRQjl5RjFobUU4UTRXMGVWNkRO?=
 =?utf-8?B?UTJhanF1US84UnNHcTd2MjRYNlhJbjBPQ3l5RDU3aEhHaE5RTGFON3ZCWCti?=
 =?utf-8?B?b2I0YUV3MjJDdGQ4VjJTVjV1ZzVYTm92WXgwcVJ3VkRub29SVzNaSDRHWWJU?=
 =?utf-8?B?aVd5R0hXWmtmWHFHY0RlQkJNNDZtUituMnNzK0c1VXZaRVJYWHZmNEQrdmNH?=
 =?utf-8?B?dS9iUHExOUFYSUZtSklxOHljYlM5NXRrcUNKd05JSDRFT1RkUUNLUjU3aDlX?=
 =?utf-8?B?NVBRbS93cWJQNm4wT3hTVUdYVFo4dUMxVWRRUFAycW1VTEVBUzBkQ3BJZmpa?=
 =?utf-8?B?NkV3dHE1MG5wMCtXSVhJTmJ1Qkt4WXZQNjljNUxLZHVQOExrdXllMnlDWUJB?=
 =?utf-8?B?SzVTMDdWbm5HVW5lTHpHaGdZOXhyM3NzUTBqRGk2Yk5zSlJSQWhzaVVpTHI0?=
 =?utf-8?B?QllJVUlIVGdxb0ZhVWlTV01RK3JEVXVrWi91VXJrcHFhMVNIWUlpSTFYa1dO?=
 =?utf-8?B?c3JxUUZGUm5zMDUwNERmZURtcFkrZW1XL2R3aC9nNUhvSjVGSXcrTHgvOStj?=
 =?utf-8?B?UU5pcHplMU1naGN6bHYvUnc4T3hEek12WTNYWFA3a1Nlc240d0NBZVZxWWZB?=
 =?utf-8?B?MU11Um1yMHVNS2NvdnJMc3YzZUtvd3NRK0dzNDlhT1JsSlJhNURxVktGVFBW?=
 =?utf-8?B?enNDVUtCT0N1NGExOGNlVXR5eHkxZjRaQUliNHhkZ1B1bVlzU2FBR2phcDAw?=
 =?utf-8?B?OG82MlY3NmxvNFhUeG11RjZmYzNHcjdJZTlTSjYxNlowelhLRGJWUUxCYWZn?=
 =?utf-8?B?TUNrNHg4cnl3bjZhbjh1cWpCeXRtVUp2Q0ZQaFRpU3JtK1ViekwwOHRXa3Fj?=
 =?utf-8?B?UDlDZTh3dWQ3TGpMVTNpZlNCTytnVDhibHc2UDh1VzF3eXc5OG5qdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07b934c-4506-4fba-aa8e-08de54dd3438
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:56:57.9361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeddwBobt5uMq73t+2Iaiy23MXpZfQamFOhZ1iMqkQmuHqgOmQPCan39TsbOXRNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
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



On 16-Jan-26 1:32 PM, Yang Wang wrote:
> Use PPTable to initialize the dpm table to avoid loss of frequency precision
> when using SMU message PPSMC_MSG_GetDpmFreqByIndex.
> 
> e.g: uclk dpm on smu 14.0.2
> - by SMU MSG: 96, 456, 772, 875, 1124, 1258
> - by PPTable: 97, 457, 773, 875, 1125, 1259
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 112 ++++++++++++++----
>   1 file changed, 91 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index faae1da81bd4..03246455d727 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -497,6 +497,76 @@ static int smu_v14_0_2_init_smc_tables(struct smu_context *smu)
>   	return smu_v14_0_init_smc_tables(smu);
>   }
>   
> +static int smu_v14_0_2_set_dpm_table(struct smu_context *smu,
> +				     enum smu_clk_type clk_type,
> +				     struct smu_dpm_table *dpm_table,
> +				     DpmDescriptor_t *dpm_desc, uint16_t *freqtable)
> +{
> +	int i;
> +
> +	for (i = 0; i < dpm_desc->NumDiscreteLevels; i++) {
> +		dpm_table->dpm_levels[i].enabled = true;
> +		dpm_table->dpm_levels[i].value = freqtable[i];
> +	}
> +
> +	dpm_table->count = dpm_desc->NumDiscreteLevels;
> +	dpm_table->clk_type = clk_type;
> +	if (!dpm_desc->SnapToDiscrete)
> +		dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
> +
> +	return 0;

No real error returns, can be made a void function.

> +}
> +
> +static int smu_v14_0_2_set_dpm_table_by_pptable(struct smu_context *smu,
> +						enum smu_clk_type clk_type,
> +						struct smu_dpm_table *dpm_table)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	PPTable_t *pptable = table_context->driver_pptable;
> +	SkuTable_t *skutable = &pptable->SkuTable;
> +	DpmDescriptor_t *dpm_desc;
> +	uint16_t *freqtable;
> +
> +	switch (clk_type) {
> +	case SMU_SCLK:
> +	case SMU_GFXCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_GFXCLK];
> +		freqtable = skutable->FreqTableGfx;
> +		break;
> +	case SMU_SOCCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_SOCCLK];
> +		freqtable = skutable->FreqTableSocclk;
> +		break;
> +	case SMU_UCLK:
> +	case SMU_MCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_UCLK];
> +		freqtable = skutable->FreqTableUclk;
> +		break;
> +	case SMU_FCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_FCLK];
> +		freqtable = skutable->FreqTableFclk;
> +		break;
> +	case SMU_VCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_VCLK_0];
> +		freqtable = skutable->FreqTableVclk;
> +		break;
> +	case SMU_DCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_DCLK_0];
> +		freqtable = skutable->FreqTableDclk;
> +		break;
> +	case SMU_DCEFCLK:
> +		dpm_desc = &skutable->DpmDescriptor[PPCLK_DCFCLK];
> +		freqtable = skutable->FreqTableDcfclk;
> +		break;
> +	default:
> +		dev_dbg(smu->adev->dev, "[%s] Unsupported smu clock type: %d!",
> +			__func__, clk_type);
> +		return -EINVAL;
> +	}
> +

If this is only internal usage (only known clock types are passed), 
probably this also can be made void and avoid the return checks at 
caller site.

Thanks,
Lijo

> +	return smu_v14_0_2_set_dpm_table(smu, clk_type, dpm_table, dpm_desc, freqtable);
> +}
> +
>   static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   {
>   	struct smu_14_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
> @@ -510,9 +580,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.soc_table;
>   	dpm_table->clk_type = SMU_SOCCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_SOCCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_SOCCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -525,9 +595,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.gfx_table;
>   	dpm_table->clk_type = SMU_GFXCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_GFXCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_GFXCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   
> @@ -556,9 +626,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.uclk_table;
>   	dpm_table->clk_type = SMU_UCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_UCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_UCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -571,9 +641,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.fclk_table;
>   	dpm_table->clk_type = SMU_FCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_FCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_FCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -586,9 +656,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.vclk_table;
>   	dpm_table->clk_type = SMU_VCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_VCLK_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_VCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_VCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -601,9 +671,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.dclk_table;
>   	dpm_table->clk_type = SMU_DCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCLK_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_DCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_DCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -616,9 +686,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
>   	dpm_table = &dpm_context->dpm_tables.dcef_table;
>   	dpm_table->clk_type = SMU_DCEFCLK;
>   	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
> -		ret = smu_v14_0_set_single_dpm_table(smu,
> -						     SMU_DCEFCLK,
> -						     dpm_table);
> +		ret = smu_v14_0_2_set_dpm_table_by_pptable(smu,
> +							   SMU_DCEFCLK,
> +							   dpm_table);
>   		if (ret)
>   			return ret;
>   	} else {

