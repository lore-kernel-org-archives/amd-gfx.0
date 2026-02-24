Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C69EFB816
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55F410E50A;
	Tue, 24 Feb 2026 08:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3eRC5Ys";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC6A10E50A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH9iisKSBjNWgf9BRpjLRzbGHgIc5Q8b/7wLZNSYAM+0QIrSQSPC7eieuA/ap/lDgA00zgS3owPu0/2yHYfvLktXzSTIaZSXkIyFZMzMArnGxV85a/0V6loPDHDN5qAPoUP3QEsa34cCpgNgkbHVGSHKjKp/91ulNVfC0+4/my8O37RZuAg6VECgXN/kncmWpXLLwHjFekaGHdbQmulaHPVf+ktjLtfAL7qJVMWqF0yXHmumTlbZu+nu12nHFn7FIL1Qq4C4QrXHwuaqaoCoSpYi0KkjjAPzchqiYQqRKQ2Jz4luo26otxF5Q/G1B96oyf7RBxuRxNyi3qZbtY9tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa3GONxxOxsnvOaogVQp+q1PTeadsVbZwElUeeOhEcE=;
 b=vQW0T+VifhIdwMlNjm68Yno03tcrPlOGSC5bIVGkoiTIb7alTGHvtM2sDh4L+wJspOZoun5lu2Y9usS+EQse92A9SCw6UTPHg4qqJkUa3BY4EagF4u2QpxzQlIFURcLdxh+Ko0MgwdJ3rjYJcZnaFgRa8pKFtanl8tC8/Jdo0iFk0INGFJi1TsuAL0L7IFuuhVNLwQlJT2qCsDn9j3WU2t5a+sx1zsJJJPAVBIEW5YWw1QgT5tM/QKB/XtbJC8BVmPqkw5/+T7YQm8gElOKNNYosNgLOV49rqjWw7udSYvN6lJ5PuYbGsNOsL5uT+PXh4PAYPFrdU5FH3aze1a9TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa3GONxxOxsnvOaogVQp+q1PTeadsVbZwElUeeOhEcE=;
 b=v3eRC5YspN9DTNNATJmwiV+B70B0wm3gyaZhpkGAuTKFU4s8c0AtPaVV6nisJfVPQHbO8gkHARjMQVeebu4p/5FnVW5dXq9fbi7HL9iSvAmR+4SNL8wAV/HuNK677/znXnMk44Bp+XgTc6MXVf5xROl7jHTdksC/2g6jycwzGDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:45:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:45:38 +0000
Message-ID: <2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com>
Date: Tue, 24 Feb 2026 09:45:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amdgpu: add upper bound check on user inputs
 in wait ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <20260224082443.4002292-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260224082443.4002292-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: c1664bd9-1dab-4281-7665-08de73811562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eC81cVN0MzdwVkQ2cmpuK00rNDlsVzFiZlQvcXozZGY1TmhMcVU2QVVrMjJx?=
 =?utf-8?B?aWtiQmdOL2hKbEpESEo4bWp6ckFLcmFxLzJQSENxdG8rNiszb2RNckR5TXdm?=
 =?utf-8?B?dkRnMUxoWTM5MTlOa0tZeTQ3eHg5bnJiaTlDS2NtNENKMUpxV1Bvd3dUeWNR?=
 =?utf-8?B?bnFIYkh0d3Vqa25tbFVvSmJPZW9ZVzA5TldGODc0a2dkMEdnN1lQMkVLNW5T?=
 =?utf-8?B?QUtXd2dXSEZTOUZoM01wV29vYkZKOTZPZ1hBWEg4WkhhS2JVSzYyelNIRjZr?=
 =?utf-8?B?N09kQ3RVOHJWTzMwOGdWR1BqTUxPenFRQUhtK0NSL0VRQ3FsZHhCN3lyU2s2?=
 =?utf-8?B?NzJwYmpCMXY1VGZHaVFiaTlUdEFDTzlFOUJDYy9XdFkrajJPRnZ6aGFicHFh?=
 =?utf-8?B?ek1KZ2F5NlBkN0lTZHorb3J1Q0NKWXpKRVA4RlY3V2FzTFFoRElzc0M1ZFZV?=
 =?utf-8?B?cjVob2NJM01mN1FubE5jY29CY3NOS0haUlh6Kyt3Y1NNUGQzQ0Npdkw2MTRF?=
 =?utf-8?B?N1YyOERwQVg2YWluYng0dXdLQmxpK1hjcHlMM0NiK3FHcXlNcW9kVTJKcEZV?=
 =?utf-8?B?RlJWYW83WHhlVzdLR0V2QXNsU3E3Qm05Mk5aZWhheWo5ZEp3N0UyMFV6bC92?=
 =?utf-8?B?OGM0OVJsZSs5M29pVjVjeTN4RlpJMjR2M1dXOExjNUgzSmkvKzRrMk5acnhj?=
 =?utf-8?B?M0I2WnA2ZUE4NVhMU25ocTBscW9MNWc2TGZTdUd1aU41SWtxcHMwUjlOYzJT?=
 =?utf-8?B?Y0RSeDh3ZFEwa01pS0krRGhTaCtVaWF2WmNkK3dyOW1jUjZ2dHVqdTRVczN6?=
 =?utf-8?B?K0JYWGlnSGxHVGVwSnNQWllsWXJaSUJOSDQrSmlrRE5QK3B3eEU1WFp2ZGd4?=
 =?utf-8?B?M2w4Ujc1SVdQTTExNlc2bVBFNnBDeWpIeHY5MGdKWWZ6WXYzSnZsekhYcU1M?=
 =?utf-8?B?TVpVKzluMUNaOTVNcXIxQXRsTTBNQ3EyZlp0Q1EzcklSY2pvejhqMzl1dDRk?=
 =?utf-8?B?ZmVBREREbkQ4amdsc3J0YWhNZ0ZmTHVmRC90MWlVaWdsT3QyVnRseStnSjlI?=
 =?utf-8?B?bC9BbEYwR0xTMWtJQ2NhSHJJQ1JDNVJIQllqeGhhVVpPUmVVcENYdFQxdnhB?=
 =?utf-8?B?bzBmNzhWR0VORXFESnc4ZXpNWU0zcmQxNVA2SkszNlo1aVdxVEVtU3BES1dB?=
 =?utf-8?B?UmY1WkJVL1lTWmtZemlZTUlybG1JR1dsTlNBa25yRU1KUGhURytVSEo2bGZW?=
 =?utf-8?B?aWJhU1pjeHlZY1J3TGhOYUxnbVpWRjNRNXZ2ZkdUL0ZJWkFTeG81dXVIbVdm?=
 =?utf-8?B?UTZzeG9wb09LaWJycTkyVkE4ZklYUGpBWEFEUm5wc1dJUFQ5MUZpRzFNWUlW?=
 =?utf-8?B?dnlDVkNKOXZLUHpyZVRxR0RnN1RYckRDZG1NUU1IZERoSEJ0Nk1IL1dBZjlT?=
 =?utf-8?B?Z3d4OFlhRFVtZlYyWUpRSjQvWnJZT2RyWHgxRDF6VzFPUEtQZ2gzT25XNUhx?=
 =?utf-8?B?Tng5L2JGWjgvaFpsWGZieEYwdk1LcWlOTzV2cnFDZ256VXVQVDBCcXZha1Z3?=
 =?utf-8?B?SVpzV2FVRHhQZ2NLRWxnUkFKMDV3NnF3MXVjS3FVWXF4Y0RMTmNJdURSS1N0?=
 =?utf-8?B?cHJGNzB1d3ZZUGxmVFhsekR6UVY0NWI4cW83cHBkTVY1bmY1ckRPc0lwSXUw?=
 =?utf-8?B?WlJraDFqNnJtVngwU1JKR3dqRytlL0hOVEhVd2tNQk9VQVdnZEFKTVI3UEFX?=
 =?utf-8?B?eWhsU3FKcXl1YVUwYVNmN0JnRmpQdVpYdUoxRXh1dmNSeldKa0lLNDhnbTQ4?=
 =?utf-8?B?endTcm5lOW1xMk4yY2FUZTk5RENCMWFIdTRyZnB3UDhtVnhDaGtxV00rN2FR?=
 =?utf-8?B?TXBCQzdaajdJWUxEYzNPSTJCeUtrbFk0b1c0N1ZqY1prbk1DTjJsZ1lrWVpu?=
 =?utf-8?B?OEszdTNEZXBNSEkrNUZ2UGFrSFl3LzNzZFJZcElyOUlqMUVqcWdLU2VtSFRS?=
 =?utf-8?B?V0RobGNrSFc4R3NWTWFkamVIb291bHFhUElTcWhqT0RwMDVVZ0RheGpXZUor?=
 =?utf-8?B?Mi9ycFBMY3JCakdSMThtVzRQbkF2NWFPSno0V2VRYzA5QmozN1pIdjJ4Q29i?=
 =?utf-8?Q?Tk84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2x2NVJxVkRscHBNWFFaOG44VjdiS0RJTWZoeUxnZHFqMEVDU1lONy8wK20x?=
 =?utf-8?B?STF5NWN2Z3hwS2RRa29jUjcvc0dUS2RwNFNJNzhrS0lHL3dCcmNDZG9ydG1x?=
 =?utf-8?B?dVBSRGdCT2Y1UmNzUnNEZDQ5M1hXSmRFeDA3T3diZVRvUThJUTZnUWRqQm1O?=
 =?utf-8?B?aTRwc1hkSXdqVU1JMVRHN2VuYlNGSjNOR0U3OG43d0VISVV6VGZSeE1Bcmtn?=
 =?utf-8?B?WlVib1YrcEk3VkJFRGY4TklLbGtkZDZFZXAvNi8wQjkxTVJ2dGVCQ0xLTkJK?=
 =?utf-8?B?Wk5xRDFxUVpmV3pZTytsTmZkU2xOcTA2d0pHYjd6K3FONnE3Nk1RUklDQVRr?=
 =?utf-8?B?T0xhejVJblUvelM2QmZhZWs1OExCZDNzL2VuOXI2SzBKOU5RY1F5NnJ0WENQ?=
 =?utf-8?B?WXY3TFJnaHZoRldaa09nekQwMEo4cVNkaHJWbUxIYm1nM0UxMVJBbWlUZUh1?=
 =?utf-8?B?M09zd3NvM085U1hFOHpaUXpjeFhWTEZDYkNlTUx3Vmx3VURLVmE5MW9Cbzkr?=
 =?utf-8?B?dEJ1Snp0VnY1N0x0ME5md21DVjRNUWtUUWV1VmZRay81aWJPemtqb2cyRllp?=
 =?utf-8?B?dDZCTjA2MldxMXQxNmpHNncra0NNSFVXL29vQ0hTUTlxL2U2T244cGZnbHE4?=
 =?utf-8?B?RG1sUDRrY09VQnVKNzRRaGRaQVEzY3k1TW52V2xYSmczU1JTZ3g3NnpXYjAx?=
 =?utf-8?B?Q3RBdzZ2SjlZNEU4Nm5DN0FrdmpCaVBhVjM2bGFsSmRiTmFyQ2piZW5XQzlP?=
 =?utf-8?B?WFBrNVpBcWZWT1l4OFMxQnV1Mzhxa29FbFhGaEtCQUNDb0dLdEV4TGkvYXV5?=
 =?utf-8?B?Q21WQ2JPQ3ZiM3ZvRTlBbDFKN0l2VVo5NzFIeWpPYkpPMHY0WjJxaEt6WTZB?=
 =?utf-8?B?cTEyMXRBWWkwVGVJMzFTRTBWOVVOT3hoczN2TXVBTDVUTGtHbUZEU21tejFx?=
 =?utf-8?B?UGl2cWE4aHUwRi83WHJNQkRlODhKN0JWRUx3MkQ2ZTc5QWs3N0Uyam0xWnR4?=
 =?utf-8?B?bS9Sd2xHSW1GMlUzWUNJNkNLY0JtTDZtZ2R4VzB1cmZsMTgvYWU1ZmNHRVJJ?=
 =?utf-8?B?WG5zeWFabUZRTUtpR21WbEc5Q1hwWEsydThhd09NdWk1SXRWNDNTR2J1UDl3?=
 =?utf-8?B?Qlp1ZjRWbVg5TUhURUdsVzcyTFE5K2Q2ZE56elhsUnc4UEpYYkZPeFZsMUls?=
 =?utf-8?B?cW85M3ZXblBLTEtXTXMyS3NCN2lGck1BcVRMOGx4dGZKTE5iYmw4cWl0V3R4?=
 =?utf-8?B?Y1Q5dnhhS0xZcGlzQ1FqRWhNT3FjVVlnNitIRVJjcS9vbnAyL1ZYTW1qZmZY?=
 =?utf-8?B?dC9hc250OEx2eDRPL2xpUDgyYU5FVDJNdVBrbGtwNEs1eW1UalB4WW1haWZV?=
 =?utf-8?B?cVZlcXpCckF5bjkrNkp4amZIYmwzRWUwSmdLYmZOb3ZWQkVxdlczRnNsMDZn?=
 =?utf-8?B?MWhKRG9nS0Y1aTZRYm15bTI5NkRucDR5MTgrVEF5Qk45bzlZVk1NSmcxSjJu?=
 =?utf-8?B?OWJQRExmTW4xYjdJSmFvQTBvd1FaQlhmejNEN3I3Zys3UGcwaHpub2RuTU1l?=
 =?utf-8?B?SEkwOC9wbDJuZzdPUGtQVGJMcDI0WkJSdnliU0tad1AyaHluRk5VdEIvZHhn?=
 =?utf-8?B?bUU2eE95UnBQdzgvYkdIc1BjQ1laZGFVV2pHak51TFhxNm9VajRVRUNKSHVI?=
 =?utf-8?B?enRyY2g2ZmlvY0ZuL2VUSTN5bGxRZlpoYXlHemsyOG1zTXpRRm5NUXR5NkRu?=
 =?utf-8?B?TUpKek1BcXRvYW85WEkrSlRHbDhpQW52Z3BCVDdXdHBaRStIb25HZGhvamw3?=
 =?utf-8?B?Q2w0NkZUajVVUERFSzNZeTVXcUxhcHNRQkFjbWdHdi9XbldDdHcwRmxFQnNO?=
 =?utf-8?B?Nk5jOU13VTdwa2pDc002VEdvaTZZejhKa1ZVVXRQcHNONlpyT2ZLSFkyWnJn?=
 =?utf-8?B?bnE0MHNPWTdQcUJBZ0JrTVdMS1N2NG9nUmVBcVI2K0g3bjh5NmlkSzBRUEpu?=
 =?utf-8?B?VlpMWUpxRTBPc3FIVzdmaElQUXA2RDcrTkZHWUVSM2s2TVZkeWsvNWU4VVB3?=
 =?utf-8?B?V2g0U1kxd2gra1FpYk9WMXFCR2dTdVRyWDd4bkNQK0d4Y0ZFOWlOb05QSElQ?=
 =?utf-8?B?R3lqajhKZkViaUI4TlEyUVpWQzJuS0p1b015dzR3L2dIQkl4WFFXdGd0QThX?=
 =?utf-8?B?SFpjcEtJZGxsb1JMU2NzMzJZY2lEdktUc0RiRVVYUFJBWnMvOTl6QTZYRDdE?=
 =?utf-8?B?elJhWEw0RzhkZXgvbWtGRnRoYzk4RWxsSEVBRWowaXpxYTA4R1RRMXIvb0hx?=
 =?utf-8?Q?U3k1bTSSYPElLCqmrj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1664bd9-1dab-4281-7665-08de73811562
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:45:38.1173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBJjU31z09POdddb5inlKC0m+y+BOk/74B2Kq1hW+kJgdzc8nKGrLlX6MYOVds5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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



On 2/24/26 09:24, Sunil Khatri wrote:
> Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
> could be exploited.
> 
> So check these input value against AMDGPU_USERQ_MAX_HANDLES
> which is big enough value for genuine use cases and could
> potentially avoid OOM.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 4f9386677c47..c2435ddfbd49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -636,6 +636,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	if (!amdgpu_userq_enabled(dev))
>  		return -ENOTSUPP;
>  
> +	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	    wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||

> +	    wait_info->syncobj_timeline_points > AMDGPU_USERQ_MAX_HANDLES ||

That here is wrong, syncobj_timeline_points is a 64bit VA pointer.

The number of timeline points is always the same as the number of timeline syncobj handles.

Regards,
Christian.

> +	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
>  	num_syncobj = wait_info->num_syncobj_handles;
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>  					    num_syncobj, sizeof(u32));

