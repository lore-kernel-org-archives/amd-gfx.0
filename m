Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29419EC1E86
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 10:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73D310E068;
	Thu,  5 Feb 2026 10:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2+FdB92";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAAA10E068
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 10:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt/Tb5t6WdGvI46Qf2qhuwIdAUEvljNgZeO0+Zc4CsCZA2tBTbc6DvnRuiH47P3zKcBQIhJDcezy+ixiNkre2tLwKX03/6YaPwvNmoYN+flNj9YKSo43bXEb12rjFWGQTcRYUQ+6iBz3a5RUymB1VzhkuLsdy+ovBWln3zxcHXjLQ5XeT3xybPE+X73HeAiIAwz+aXQE6uq1lze7BO7F1RcbIyZYYWx5hdyU2C327HMRvOACvI0bef2XTMn/ZacII8PsNH0FrhPE3ujJOGt+Dj3bY5s9AfoDngl7ltkjlQpylZrU0JRLiowS9xf/CREgvjZVUVHmfhD22BsKYHQ4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY2yBPWJ/SSa1fnuvJSeQxZ4I0QSye8JRkKFUXUD8Gs=;
 b=jYKt2//Dd6P/FZdYlTi3swFeDLJUREeAJOBUn9qznQvfwdF/Xn+0C5lZGbd7KjxHHUdLKV81uBOTeRiOJHc7ElFUTtGysyIqBWR+NYryGdT6sPbFE9S62JBBLMj3izlgJQ8C0DxHAvD21fN3Vt4gohwcr49dlmV2D7T+45pPlRzC3rD+i3S8BRCabt9wK8APKsTTSV8xHge3NucWtPbgWtSgfC9HIjVTnSWsE8K2HfYz1VWtJIavSnVo8TkQGy8dXzIHUB8SiQcw+/vbZAJ6YD/RONCvN+PMqv0TXOtxmJZxqbmxBFNTasqHTrq8ESO4pHMsyUGfAG25Q8xWZ5CAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY2yBPWJ/SSa1fnuvJSeQxZ4I0QSye8JRkKFUXUD8Gs=;
 b=I2+FdB92W3HXgQkYlAgEVIDrNwiurpPyY73BbThd7nRuNniMC7Q/iE5LqjFIBmE0Eoa1Hx8gPFe/mnXCoKYzIetdPHN6PhjlVPHg+yDuOqe31JU6dD6N6EptXOZWk7fXpDC2SsvuQVYdjUan8oaGbD+Xk38qewc13ox8J05/IcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 10:10:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 10:10:01 +0000
Message-ID: <3d834539-3796-409a-9126-d8a7b9226aff@amd.com>
Date: Thu, 5 Feb 2026 11:09:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/gem: add drm_gem_objects_lookup_safe() helper
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
References: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
 <20260205095957.278704-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260205095957.278704-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:408:fc::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd9313d-05ce-4e15-a178-08de649eb9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEtuU25qWmhDK3JJa3pCZmZhTmNvVnFUSzhBanJVOTZDVW9VZTZlNS9CVUpF?=
 =?utf-8?B?dmxkMGNpVENpdzZ0c2FFZnVQZGFGRjJoK0kvMUxGZ2hST0thb3BLaERhSUo0?=
 =?utf-8?B?QnBUODZQUUI3aCtFYXhWcWZ1SkowWWJJQzBEVlNkaHRkZ1hsejkxVU5xcHVC?=
 =?utf-8?B?cWVtUWZJQld4NzJBbG1HZTM2OGpsb2prTE9XdVdmbzNha1pLK3hRa05vdGxM?=
 =?utf-8?B?OFIyeXEvYk1mdTltbWFHOGRaSnErQSsycG9XdGV0NVVWc3lwOUNzWW9RbUlK?=
 =?utf-8?B?Qy9YeElpVkZlTkM2VGpRSngxdTVVWnlFNVZkeFc0dzFudVpteGswM1R6Z0RS?=
 =?utf-8?B?NHFwSWdsazhHeklVeTlPcFJxRmorQnRKWWZtWG00Q0tORVBBalBLYTBoZ1pB?=
 =?utf-8?B?SlJybGRjVzdCWHRnblk2UFQ5TnhFcy9nbzdZWW9idWppem9vTlJxUFZONFV1?=
 =?utf-8?B?ZGtqVUZiZHZIaURQaHYxSGxYalJrb3JERFpVYlA1UlZERi9EalZNZE5WcnBi?=
 =?utf-8?B?S3dkbmtxMjRsUTRocVJjWXM3UWord3VKZzVieU5QejdiTGFEbThxZU5ybllT?=
 =?utf-8?B?amdaR0VIZDF0cDk4TFAzbElVN205ZkpsTldWZGJJeThXK0ZFdWRFOUIvYVhK?=
 =?utf-8?B?Qmp0QjVoeG1hSVE1d043RnJhMk1lZ2k4RlEzM2FZS2dOYU9qU1Ezemc1L2xD?=
 =?utf-8?B?RnVnRUp5eUJKaEsrTERaRUJaTTVzRVBqcm9oTEE3OTlCNm9RbjRUNDdFeU1E?=
 =?utf-8?B?SThTN3FVRStjMTdxejFrN1lnRFN0cHd3bGduNWhNMTU5cEF3bEwvRDd1VEhN?=
 =?utf-8?B?ZkxrYnpVUWVaNWFndklMMkkrVjdURElhaTMzMUJwKy96eDRNazBVQWttdndS?=
 =?utf-8?B?R0szY2RwM0FJWllkN2VMMmRzQUZEN0VOb2p4NDZaejlKN05OM3dJSlRUZHNx?=
 =?utf-8?B?VW93VmxpcnUyL2tsRy9WZEFJV25CZXR3c0MyOW85Ym1ZWm9XTlBuYklmZGJW?=
 =?utf-8?B?TllvQmV4RldvU1JtSStqSldPZ09uU3FEUHJ0V0kvbDVhemNxUTdpUmhSQkZz?=
 =?utf-8?B?VFA3K2k2dmZoVFJFVDV1V3laSThwcHJoTEhDZm0vYXo3TXJFcVFXYVhaMVJR?=
 =?utf-8?B?U2ViU013ejBNOFF6clFtRVBOblBpenN0RGl5aDBBS3JxUTUyNHFEdG90Ujlx?=
 =?utf-8?B?WmJLc0U4V3VqMjMwaTVTNVR5aEhkZmQ0Y0FzWmhBYmRLaDJKSmFsRlR5ZS8y?=
 =?utf-8?B?QWZrTC8vbVpPWjdmRDFpbGRTWXY0Q2hjNlRtMXFXSUkyeURLN3Fzb0l5K3lk?=
 =?utf-8?B?ak1NVzgvNHVSNzFleUUwaXJNTEx5NzI4Umh2dkh6VUlpRkZ6T0VHeml3aE1i?=
 =?utf-8?B?am9sYktmZFN4andQa2p3NThLNUdPL3FiZ3hJWGtvRTBRNDh1cFRpckpGUjJw?=
 =?utf-8?B?c1lycUxKV1lpQUR6WXI5RVpLNFNLRkNPcEZweTROMHdJV01SbFBiV21EWW16?=
 =?utf-8?B?ZVk2YlhDOHhyNUFKamEzQmFsVFp5cjRISG10MldBL0Q0SHJsMTJHNU9nRjBu?=
 =?utf-8?B?TlZaV1NwZkxYM0MxaEU1elJLZ1lJb1RQUFRzMGRpL2VFWTdweTJiWXRrOWtZ?=
 =?utf-8?B?ZDE5bGtZQVJsbk1ONjQyRUNUdzlZNWRVVjNTbDNPVEFKaTNXM3FISVNHNWtR?=
 =?utf-8?B?RUd2dHBoeTdpdlBqbW5GZ3BoSEkyVkxkM2hGRi9HOWtRVmJTY0l4WFBlZEM5?=
 =?utf-8?B?Ynh4NGRLVVpCZzBrd2pqSDdaTFl2SEsyYnFCbDVOcU0vN2xBcWhDTmx3anpI?=
 =?utf-8?B?ZUJ3N2dRTFRkZmM2WEQxbGZEN2JmOVFmTVQ0UjI1bFN4ZDdaUGZtOEU4Y1VR?=
 =?utf-8?B?c0dZV0hKdXBsSmxYMnltMHVCVnl5K29KRWJ1L2FNcHZ0RDFpbGZtTytmUitH?=
 =?utf-8?B?eTBZcHRpaTUvQ3YvZEw0UWdXcDRMOGhOMk44MGlEaVpMak41SmtGZ3lkT3Rv?=
 =?utf-8?B?aVA0ZjdEdFJVVkVTc3h6MEowUUJrWTlWcmdaTjYraG9zbGZGZHplMzdFRHVa?=
 =?utf-8?B?aFlnMy9QWnRrZVYrQXlhUyt5MS9kWkJRZjFCeVVveDZCVlR5M2Rjenp2OUVs?=
 =?utf-8?Q?iQlY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JQdlpVMDhXVkVHaW1XNkpNZzdHN3p0SGZIL3VXU0tSYVBUV2lRRG1TK2ph?=
 =?utf-8?B?NHY4Mm1SSlFuckdrQmlyRkN1UHlMNTE2Q1JTc3RpK2dFaW9lSXo2QWVNd3Q1?=
 =?utf-8?B?dFFxcWlKeHRQWk4xSFROeXFwcTZISFNadWJUTUo0bGk2cUk5TTl3VmVXY05F?=
 =?utf-8?B?MmVNRS9oZkVIVElTc21ybEo1anZxelBNdVNKODlIOG1kamYzL0g4eC9Rd3pI?=
 =?utf-8?B?dGF5clhabE93Ym12QWJ2T2hocWxTZnhFZmN5VTd3aHNxVjhOdGV3MkRQYXF3?=
 =?utf-8?B?a0k1Qkw0aUh3eE9vMkVVQjVyaXZSQWxZUUFPK1E0U2xJcHdWTGVvajVnVjFl?=
 =?utf-8?B?aUxVZkZnMUlVN0tKc1NOVWgrWXBQODlTOW42eXJDdGlHRElTMFRqTXI0ZHpx?=
 =?utf-8?B?YUkrZ3RaMGNzWGlpdkhzUnQxSlhtYWJKS1JOTkhTZlRIbVFOT0ZwMjlNcmV4?=
 =?utf-8?B?eW1tMzBLRjJOY1N3WEY2REpuM1BFc0ttSG1xdGRpWWdUTkl3NmViQUdiNHBX?=
 =?utf-8?B?ekdHeERieGlPNlh3TUlLMGFnb2U5cGdZSkdENFVpaWJNbTkyeWJpclU1Skgy?=
 =?utf-8?B?UjlFTldXeFRVMXpMd2tQRmNXZmd2b0Y0WjN6ejZjTnZlY1BXR1NLWDl3ZHR0?=
 =?utf-8?B?Wml3QW9aOXl2OWpRaG5zMkhQMnBhdE5IMTR5VHBVaFp0aFBwRVp4ZkoxYkI0?=
 =?utf-8?B?azhKM1ZzZXgrY3I0MlhQcUxpT0Y5ajBORThwKzYxM0VrNHlMcjh4dlFuRkdK?=
 =?utf-8?B?UmIxNkE5SlRLcENnV1ZjdFU5ekd4TDRBRkJxR3UrZXJXbmNlNmU0NzBXckNx?=
 =?utf-8?B?U2R2UGFvVzI2bHNscFNoTVd0RW5LS2R6QjhYdGRwWmltQXk0aWMzSjM3U09W?=
 =?utf-8?B?Szc4V1dzL0pCeTh2NnBQUDJUMmVSM3NjZGNmV1JJUEpLczFNcVNRTXpoUUt5?=
 =?utf-8?B?NDdDTUhMTDNOWG1lNXRIdy9YQ0d6bXN1a1lGYmc5cUNoUy9oLzdvMm5qY1RO?=
 =?utf-8?B?VkQ0a1lKS3ZxZUtTSjd6RjhlcnRiRnJJajdYeFFHSnVYbE54a1ViVjlSVWRZ?=
 =?utf-8?B?dTdDd3d1anJEOEFnUHNDNkRUdC9NS2M2alNiK3BTdkZNNERwVjRILy9sc3RS?=
 =?utf-8?B?d2hXZVBib09CajhaSnBDVUxqcnZncnpKREZzRVZWckRxQkwzc3pMaUk2dGFL?=
 =?utf-8?B?WWpIeWdxVmlZRkQ4V2dJNnRCbDdPVWZ6TFd3ZEJoaEZxTzh6Rlh2N3ZYWXlG?=
 =?utf-8?B?ZDg5UWsyeU9mUlRzM3hqRzZWK0JZajYzb3RCSDRkeEp2STh5UTU0cDBZZ1JE?=
 =?utf-8?B?V1htUGRqeG1YcytRRk1zYUhXYlJSakJYRUxSUGErYjR6S0szc0VYQ1Rvb2ZQ?=
 =?utf-8?B?ejE2SW1kUVM3ZDZ1RGU3czRjQ1lqQVUzSUpSc29ObTczMkZGbzZyVDFIby9j?=
 =?utf-8?B?eEwvWWhSaUFOMERoTmVSZEszZ003RzdPWWx4Yy9QNHBQVXE5WXN4ank5UHk0?=
 =?utf-8?B?REw2bjl3YTFNMnlZWCtic0tnYWdMSmhRa0ZNQWJiWTczWk1WQVJQb0lMUWJv?=
 =?utf-8?B?TW9GbEdvclhjOCsvb2ZIZ1lBQkdYOHZMSDVwbzNhL0NUdWd3dU1ZcGR2MGFj?=
 =?utf-8?B?Nm1zNXM5a0xNdWYxeG1LWUZWbEtxM1hxS3VlSy82Qzg4eFNpWnhBVFk2SHFn?=
 =?utf-8?B?RWhNUnhRU0YxclZTUFhBeUFwd1prellRc1NmZk82NkRBRUlZb1VvbTVRRnNE?=
 =?utf-8?B?aDdZamR3VkgwTlZFNHZSUmlkSHZrYUlxQXVBWkY5VW82bWN2dytqVWQxNUk1?=
 =?utf-8?B?eXAzT3U2cERmSWJNSHl5UlB0TXdMR0wveEcvOHF2ZzY0N05NZjNMRThRUFZP?=
 =?utf-8?B?V2ZERExCbDlJWVJVbUJyQjdNZEoxQXVNbXYram1ZT1gvOC9GM1k5T1ppaFg2?=
 =?utf-8?B?MllONlhOWDlUUGtYYkF2L3k3RzNwQ2ExeWV4RVJMSTdraXBGRXVjL3JYU2VB?=
 =?utf-8?B?Yk45ZThLcXFLTWZXL0ZNWC9JcHowTElldCtYaWhMZ1Q4cUdBTURvWGVrRUdQ?=
 =?utf-8?B?MjNvaHJWN2FoZERmTFVmRXk3UndyMmFzUFAyYTVYTWxyLzE0Rnd1N2tXaDlV?=
 =?utf-8?B?ZWo4OWxMeW9NTHlvRzd3S0tMSGxwVnYwRmk2Z1hOb0h0RVArcFQ0anNhRUFN?=
 =?utf-8?B?K2NoTUd2VHJwdHAwclpBaEhXT3I4NWFTeEhDMDB6aEtCQTY5S2hqVlZjQnYz?=
 =?utf-8?B?dzJCQ29xc3Z3cC91cm85bFVPRTNsZEtIS0tUaC9sUGw2SEtvR0RRUDNmaXNY?=
 =?utf-8?Q?drb+B4y5NsR9kyfdC/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd9313d-05ce-4e15-a178-08de649eb9b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:10:01.7802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9W5vo5Q3ghAf0I5bcz2TlWun1H4O9dBbCPYD2RRaCi29hvRskLSN0n8rYkRsP/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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

On 2/5/26 10:59, Srinivasan Shanmugam wrote:
> drm_gem_objects_lookup() may allocate the output array and acquire
> references on GEM objects before returning an error. This requires
> callers to handle partial cleanup correctly, which is not obvious and
> easy to get wrong.
> 
> Introduce drm_gem_objects_lookup_safe(), a wrapper helper that
> guarantees cleanup on failure. If lookup fails, the helper drops any
> acquired object references, frees the array, and sets the output pointer
> to NULL.
> 
> This provides a safer alternative for new and fragile call sites without
> changing the behavior of drm_gem_objects_lookup() or affecting existing
> callers.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I553551dd1e7aadf1b2a477eaf19ce9c80b2ce2ea
> ---
>  drivers/gpu/drm/drm_gem.c | 48 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_gem.h     |  2 ++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 0f8013b9377e..f1d13700a62c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -830,6 +830,54 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  }
>  EXPORT_SYMBOL(drm_gem_objects_lookup);
>  
> +/**
> + * drm_gem_objects_lookup_safe - look up GEM objects from an array of handles with failure cleanup
> + * @filp: DRM file private data
> + * @bo_handles: user pointer to array of userspace handles
> + * @count: size of handle array
> + * @objs_out: returned pointer to array of drm_gem_object pointers
> + *
> + * Wrapper around drm_gem_objects_lookup() that guarantees cleanup on failure.
> + *
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop references with
> + * drm_gem_object_put() and free the array with kvfree().
> + *
> + * On failure, this helper will drm_gem_object_put() any successfully looked up
> + * objects, free the array, and set *@objs_out to NULL.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_objects_lookup_safe(struct drm_file *filp, void __user *bo_handles,
> +				int count, struct drm_gem_object ***objs_out)
> +{
> +	struct drm_gem_object **objs;
> +	int ret, i;
> +
> +	/* Ensure callers never see stale pointers on failure. */
> +	*objs_out = NULL;
> +
> +	ret = drm_gem_objects_lookup(filp, bo_handles, count, objs_out);
> +	if (!ret)
> +		return 0;
> +
> +	objs = *objs_out;
> +	if (!objs)
> +		return ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (objs[i])
> +			drm_gem_object_put(objs[i]);
> +	}
> +
> +	kvfree(objs);
> +	*objs_out = NULL;

I see the point with the existing error handling now, but that is clearly really fragile.

I would clearly prefer that when something unforeseen happens that we drop the GEM reference to the already looked up objects inside the function and also cleanup the objs_out pointer by freeing it and setting it to NULL.

Regards,
Christian.

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_objects_lookup_safe);
> +
>  /**
>   * drm_gem_object_lookup - look up a GEM object from its handle
>   * @filp: DRM file private date
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 8d48d2af2649..7decce2fdef7 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -561,6 +561,8 @@ void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
>  
>  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  			   int count, struct drm_gem_object ***objs_out);
> +int drm_gem_objects_lookup_safe(struct drm_file *filp, void __user *bo_handles,
> +				int count, struct drm_gem_object ***objs_out);
>  struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
>  long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
>  				    bool wait_all, unsigned long timeout);

