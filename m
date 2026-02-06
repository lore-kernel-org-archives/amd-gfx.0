Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B35EE20AA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D8B10E7F9;
	Fri,  6 Feb 2026 14:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vbE5B/my";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF5910E7F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/Cj5Ff75TRHpLZQqA3qW1QMAGiu1hlmRUu2wsmKkkPHlexFbjX70pyg84GgHZeVYk3MiyxyiVM/ebG+vtLGlIHP/B4j8e6rBBEm1z/XEDjS9az1vzJTs5ShXonipmJAJhKOZBpTA0RxSL/7stkQQziv+CRhsVLrs+9A7JadS3Orm+/DYg2xyPLy9hq4+ibDj/75KxItAgy7Dngx5rggy9RC3dR3X7/acfKDFRExmpKPz2z4CHkrZDCsPlHG2vufTA/RE2eIhgzSPgZdNKQ+BEx/2oUgtoD/R86EcaPTT3lJZ5FPxq2NUE9Cwz1TUHGDj2vO37V4UyDUe4DuOeBvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAaIVWuZmdxEZbaIkVKRYiIGwD+O9ElPrJJ6arsCrYU=;
 b=R+b50kI9b0nDMW9wge4ZKXNcnG2DcaB0Hc92A0Iqv2h+d24nT/UjdhwVhbOf8FuRgmDAr6cYIPc3VL1/Q5evkj6Z/uvEMMc9srAtsLu3XauZ6KY/6+og+ZZewOUzL6dRCCGAaFfI/ZiPYUh2T+/V1fbDaW5il8CZGMRVS/4ebQWoxdRF9RrDf/y+kw2+y/p3sfvJS81CzCHaaaM+A4UJ9E4u8l9bJC68ChgtoOT+6lxN09gc4YjsC8K18LTGhJj5PfmVvVHTO4I0nsQaq+kmSYicir6CpSHRPqTGNuvbq5gcyVrOwUndyHhqxABNitA63t9w3kc/7M9P7+kZKlNVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAaIVWuZmdxEZbaIkVKRYiIGwD+O9ElPrJJ6arsCrYU=;
 b=vbE5B/myZsUEZfzRXPohPbN4hrrlLhRr2IHE6REUfLt7XeZ4tskrczIA+P58jTcqtPcov0picvFW5DBc0YhLos8HTneoOCuwECj0raYCU1pRUXjpCjLA3uNNvy8dhjzRyT7iY+GIRUeMvypURRt8cWCYOWkrL5XL/FEzMWb89hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:36:15 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:36:15 +0000
Message-ID: <dc70b070-d000-431c-97c4-822ddc662fb8@amd.com>
Date: Fri, 6 Feb 2026 20:06:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] drm/admgpu: Update metrics_table for SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
 <20260206140049.105294-4-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206140049.105294-4-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::20) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: ced44999-7bc6-4f22-f458-08de658d14ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDY1RytLNDU4UTJXdjg5enRkYzJnVXVGTkxYY2hsRDk0L3luQUVlT0hGOUs1?=
 =?utf-8?B?TmdxaHBSRUQ1YnFzQ0p4N2ZKakhrcmVVcThwWXVhY0RrVnVhNVdJcHlndXpp?=
 =?utf-8?B?WmJ0MWN3aTFuVUhmNzdkd3pvRjNLcXBtUjJQeDNHNTA1YXhONm1tZkF1TDM2?=
 =?utf-8?B?dWVxUDg3cXhZVGRWd3Y0ZXg0TlVGSXN5NlEvMUVsSzlPdGoyQmcvYkxjSlVE?=
 =?utf-8?B?K014UWhIL2MxQXF6ZDQ3T0xsenl4bGFpbTR2ekRZd2t3dkhRWjRTMmNxSHJN?=
 =?utf-8?B?U1lZWlAzUnk0d0l5WnorY1F5K2ppZTJ0YlIvTmVIM2Z2Y01WOFZwKzZzN1A3?=
 =?utf-8?B?RkphbUZhZ2xsWTZYS2VoUmI1RTdYZm5reCtsM0Zjek5VNEhSNUNYc2V6Vzgy?=
 =?utf-8?B?bHdjeVU0cDlCQmttaC9meEcvQXVMK0NOb0t0eTBzQnBodTdwYmF6dkRNQ2R1?=
 =?utf-8?B?SStFUUNUbXYwalE0OTY4dG9uMjc5cWhxZytISkNNV1N3NGlsYVlBTkRORk1h?=
 =?utf-8?B?cy9LdlE4VjgzNzFWS3Z3WllXamZHTGlHRUg2QUgwSmFPRmhrWnkwaG9qOE9r?=
 =?utf-8?B?S051T1NUcEVUcGdFcmNWRVpTc1hEZmU3R2FwTXNVekdVdXA5dTcrRU5jYzg1?=
 =?utf-8?B?RlE4WUdGRFd4bEYrY01INlFLOGtRVkp0ZjI4cUoyK1ZCNzRicmlpc3NMNlFs?=
 =?utf-8?B?S0Z2SW0rTEw2VDZGTmRFNkplQWNoQkk0emZYMzA1R1BRbjZoQnBWM1RqZ1I0?=
 =?utf-8?B?RDEyVkk4SVlwOEVSeEtMYktmSjV1K2VHSWdwai9aOTBtMFZnTnB1WEF4YmZx?=
 =?utf-8?B?Qk5ydTI0a2dsbklSNnBzcHJSalk5emgzU2E2RTlKQmN2RmN1Qk0zanM1YzJ3?=
 =?utf-8?B?T1pUT3RXR2YrQlZjaHFzMCtQUVZ4ZmFKUzg1Qmp5VjJEUXlBTlFKL2ZEYWoz?=
 =?utf-8?B?WWVoODZUenYrT0Q5RFdDQWRXN2dDd3VGVG0rcGJhSlV4Qm5tVC81MWpJNXZK?=
 =?utf-8?B?TkFabkRwaVJ4ZzQ5c0VSaUNTZmF3czRSOG1BZ1BRUlZPZTU1bnlRd0N5OGd4?=
 =?utf-8?B?SHBrSkZ3Mzh0cHQxKy8vZFVJeUY3VGlESnFyRGVZa3NBSC85ZHdlL3pRZStM?=
 =?utf-8?B?NE9Nai9idWFvL2F2eWlYZmlGcDg3d1c0R3JRS0h6eExSbWQ0RHVqTDF6QVIw?=
 =?utf-8?B?TmliOW9uOUREcGNieHFQamsvVnpSWTM4T2ViZk1TWDk4SmVwZndDd2NQaFM0?=
 =?utf-8?B?SmhDbHIyMXA3Q1ppYlVCeXM3VVltR0l0YTZxOE1uMzlNcGxJU24xL1BvaGZt?=
 =?utf-8?B?dUhvdFBrcGtjV3k3LzdOVzhmTXk5NUJvVDZZc1dEbUZGUnk4cThNSVRBVkN1?=
 =?utf-8?B?eHVZYzNtK2hKZVgwdXUyNS9OMkg2a1VFOEUxUVI1UHE0QTVMM0Z0cVRyMHI3?=
 =?utf-8?B?UUhoNnRWbEQ4aGhxaWFyZXByYXJGNndyckpjRUJ3SFdLSnl5MHZxTDYxRlhP?=
 =?utf-8?B?Z056SzZqN0pha1VKd3grdHlVRXl4WUpBQ0Y1RVljemowVnplWUJmbk9tWC9s?=
 =?utf-8?B?MXNrQnkzM01KN1pvb25EaTE2L213SjVuQW1uNG9LemF6bEtxTHBGeG84UXRV?=
 =?utf-8?B?WnhaR0RTQTI3M0lGKzQzeUlBRzk4cVdFMVJMTGZFeW9KejlMalBpdExnL282?=
 =?utf-8?B?S3hnMGpEUENPMGx5UHZHZm00bmdrYmlBQmpOUnFQekMzaGc4T21zVkdxQU5w?=
 =?utf-8?B?eFVQSWVtYVJabms3aXFmUDZ4Zkhud2NWdG5CdDY4MVRPWjd5d3hhUHpvR00r?=
 =?utf-8?B?eEJ1SDFFWStxcDVOMzNvbFVraTNGNjNEYXBJTmd5Zk9oSCt6S0hzZmFXcGhK?=
 =?utf-8?B?Q1NEekxpQkh0YlhjeFVSUVZLR29NUm03cDZESzdINGI3K1pHK2NWNGFSdEtB?=
 =?utf-8?B?aG9vYlluMmtRWDVLNFZ2S1haUS85SkxQOGpOMWp2NVcvdlVFWlhiaDA5ZVNR?=
 =?utf-8?B?S05oU0pPTGFYdHA5Vi9UN2hOSURHYW13aDZvOEVZMzNmdnhNK0tzRzI3L3c0?=
 =?utf-8?B?YTg0T00wNGhoK2ZrNG04ZUs4Y0ZvR0c0N0dJcnBZS0t0ejVrQ0w4TWhLbjZU?=
 =?utf-8?Q?UKHs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJHWnhtN3Y5RFJSbndIQzRQdTJ0d1hSSXZnQm1TTmlvc05sUS8ycVdCL3cz?=
 =?utf-8?B?dWh4eFI0RHhVaitoNXp2Z3ZNeHRlTTdxT2FDQzM1eDUweTBUeUFCSDBqM2x3?=
 =?utf-8?B?M0g3QU5DMS94bmx6TjR0TjZaWndYck5CaFRVUWVVMDAzUkZIZ25henY0bjk3?=
 =?utf-8?B?RGNobVRIVU0yeUlVY0ZIRGJYS2ZKdUpDdE9mZEljVXE2U3pHUjlzTytHNG9Y?=
 =?utf-8?B?RE1Pc2lOZFRDajRFTlRjaEhPMHZ6WGlpUDNpQWVIeGNmd1ZCU2hXQ2FDMmJC?=
 =?utf-8?B?Y3dpajU2dThydCtBRzlnTCtRNVFYZ2p5SkZJb1dnSTV0aEFGbmhLOFFHakF5?=
 =?utf-8?B?Y0dBTGNEQXkweVBwVjBZMWpreGJVVTlpbUhScmNHRUY4djU3SHlIOXFpY3gv?=
 =?utf-8?B?VjhvRWFkTTJacWdqODIzQlBBaFdKS3ptMnNLM0tMS3M4OWUyUW1TdXV6Rzh1?=
 =?utf-8?B?TWlYbVRnYTM2S1FOYUJoNDNOOFJSMjRHdDJhSngvMEpVV2VFQi83UzlJNFQ4?=
 =?utf-8?B?N1ZaS0NoV3JyaWYxNmJ5QURNaWpQT2VXMzkvenNuM2J0UXpkY2x2bEsyVEth?=
 =?utf-8?B?SEUza2ducXBmTEtsQ0Nxdm9HM1Bsam03c2RydXlHNnplRytLc2x2NDAxaGZs?=
 =?utf-8?B?UVVzMnBNTjRuY3VlQ1JhV29NTm5ld0EvMXhMOFVrZkFEbmUxWTNvS3dkVC9R?=
 =?utf-8?B?OGNkM3paYjZ5b05Qa0hick1tMU1Sc1lOTThSaVZQc1ZIaEdBYmtRWlBVMkhG?=
 =?utf-8?B?UWNPYUQxTnVzYTZmSG4wVWJkOXJ5aEhLeng5TENEbXpMcXNjdERDZ3RhMEQ3?=
 =?utf-8?B?MlIzdVF3WnFad042YjFuaUkyR0dpN1ZoazlkSEVTMFp0UGNNUU85QnFTcjVq?=
 =?utf-8?B?Y3NvMThvamRTWXhxUXk0eFQ1RVArNEF1UHlndkJDSVRKVVpXUFMwd1ptRDlK?=
 =?utf-8?B?MUczbzN5NTA4SzJVNzQrTFkwY1BGY2NPMEp0M1gxdnZHZlNLWDJSRHQ4aTBL?=
 =?utf-8?B?WElQR3Z5cDlGNmFXTDAzMVFPY1o2Si9xK0EyQXUxZGdkMm5uSmNNV3JIeHRK?=
 =?utf-8?B?UDZOb3BudVFCUFR1ZkFmb1loeldWWWh1Lzh1dFRlZGdVNUtNSzlmOXFIL09B?=
 =?utf-8?B?d1QyVXQvck4xVjdZWGRlbm1mYnFQNWRpR3hYWlFiTWJiYmF6c0E0STFzWDNZ?=
 =?utf-8?B?Q3pwVUNvNy96T3dOOVF4ci9lM3ViSmFaTXkwdUZXMHJEWElwOVN2Uk5CS2pZ?=
 =?utf-8?B?bW9Bc0FUb094N1ZBdG9DNEtZQjdFOFBCUHc3ZCtnSEw2dlkwZld1R3Fud2ZT?=
 =?utf-8?B?akRRQnYvc0FNYzMrYXBLLytUR1BsZGNQT1RDM1QwVUhHbEtpb1lTL2ZXdjFx?=
 =?utf-8?B?YXdILzdEdG9kNjJvMzQyakJ3c2Y0TzFOQ0huRlBlYWN0VmNMRWp5a1NuMTN1?=
 =?utf-8?B?Ym9VbFZ1NjcvWXpFSTRUU1hzeFE3SC9lc0RES3BRRTFxTDI1MVZDZ2ZUN0R5?=
 =?utf-8?B?ZEN4OXJiZjZFTms2RWpOeTBsSk0ybjFyTHRXY2xJY3U0U0hjQzJTVWZ3ZFhv?=
 =?utf-8?B?cmxJdW9ZZWZKYlIyejNXUU0vYkQ3cjlFMTc5T2pwVnFHQVJLZ2dEVFlxZkI4?=
 =?utf-8?B?S0xQaHUxdXNEZk4vYTZqazF1QmVIUVZKMlpnYnMyMzZMR0dGL29sRUpVYThx?=
 =?utf-8?B?OWVBbVJpRUxRUGlDYkdUZnVWUkFqd0RQRDhmYk5Nbm8ybElienJDOUt2bUlt?=
 =?utf-8?B?TFBqd3hHaHhoSTAwUE0xR3lkYzJRcDRnaVF2QjhEd0hra2ZtRlkwc1RuTEU2?=
 =?utf-8?B?cDRLRmU4VUhGdVZuVllyV2tnZEkwN2E4QUU1ZUZnVjZnR3J0TVZKajJzTS8v?=
 =?utf-8?B?WjMwY21JeHEzN2htS1Q3OGl3TWJFRGVUMkZpNzhvSlNnOFlyQkJhV2FZdXVN?=
 =?utf-8?B?ckFnWkhLNTVnb3N5RWlNQ3BPMzE5RGszZnNLUWFXdzlUL2tHQmxWOVlCR3V3?=
 =?utf-8?B?bGJiQS9OcmxoZ0VUUHpTOUxqSXpzNGhCenFOUko4K2NXTHRPeHM4eklabXEy?=
 =?utf-8?B?WmJ3KzlWM0xrK3hoRjdmVmlQTURZMVpwL3JnLzMzTDFKZDh6bHFSWkNjMjBy?=
 =?utf-8?B?aW9MdGd4ZU8zT3BsVVMySmR5cTdkOXlMNWo5clo1bytmWXQ4cmNxY1Mxdyth?=
 =?utf-8?B?Q1d4b1V3dSttWFB6Mm1PQkZyQ0UwaHZHaDUvd0xLNzZUSlc5WXNuMHlCM0xo?=
 =?utf-8?B?ajNibVc4bjM3TjlLRFZWUlllaTBKaGNQTVJ3UitxSzBhN2FlNjFHenNjck9P?=
 =?utf-8?B?SVFlR1NISEVsWDUrcGJYbHRSVXFoQjVqSnhjaEI0VTk2VGQ5dnQrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced44999-7bc6-4f22-f458-08de658d14ec
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:36:15.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvH3gE2OcpLhkNNM5cX6hcp2qmJizfUj1JrlZm0yGxPALDQQseTxInUzAUIw6Zu2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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



On 06-Feb-26 7:30 PM, Pratik Vishwakarma wrote:
> Use multi param based get op for metrics_table
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

One minor comment below, that aside -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 9a2e2c2f4e06..e53201f42e40 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -284,6 +284,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
>   	return ret;
>   }
>   
> +static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
> +							void *metrics_table,
> +							bool bypass_cache)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	uint32_t table_size =
> +			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
> +	int ret;
> +
> +	if (bypass_cache ||
> +		!smu_table->metrics_time ||
> +		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
> +		ret = smu_v15_0_0_update_table(smu,
> +						SMU_TABLE_SMU_METRICS,
> +						0,
> +						smu_table->metrics_table,
> +						false);
> +		if (ret) {
> +			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
> +			return ret;
> +		}
> +		smu_table->metrics_time = jiffies;
> +	}
> +
> +	if (metrics_table)
> +		memcpy(metrics_table, smu_table->metrics_table, table_size);
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>   					    MetricsMember_t member,
>   					    uint32_t *value)
> @@ -293,7 +323,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
>   	if (ret)
>   		return ret;
>   
> @@ -568,7 +598,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> -	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
> +	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, true);

For 1ms interval, now we tend to use cached data for gpu metrics also 
for other SOCs.

Thanks,
Lijo

>   	if (ret)
>   		return ret;
>   

