Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6EEC87FD3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 06:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D671410E2C0;
	Mon,  4 Aug 2025 06:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5WBIkBzg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A7D10E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 06:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZCf/pQVu9iHUwxlzQthJ2FbdKbCRmc8FkmOfYLPs+NOvV9XmQ5VjXA/2XfOSWAu/Q0Vy1kmsvjsSHopLEPEDYETX/BwS7c9CiJi0u3HdUDSOBsyQd43az/qVALk60d3GbLJzhXae9mUN/YcwaJFmclQEt6RKVunVdDDxEonT1sdBG/b1CqIfsluU1SkGtn7Hi4kxp7FCWqznkd9zJ4DGP3jVcNVLu1PfKQgBhd4wpQbm5klBwl4/5mxkALsfuJUxf8E0xqvOuv02lBZXiOZ2QDwLtFA11rcylKzR33mmyNpUgMjiSKqAKnx98+ay9v10l6fR9eOMnI/7X6RESDiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeNVNPFUZyCesY2SMb7zoSopaAGoKUJqVbgI8mWkPIY=;
 b=JsQL0sdFdf0AOE3qMOy8uS4Oy2e3AXZlR9OIZj3/TuKH8hwfMzQiXdOiDze4D1AXX0KulDLh2JTNM3kInFao6crPFex9xScV2S4D6odChFcRXDMi9NlDmx8UFLkWfkbS1ttmVI7VFRgNGxXSHK0bt8I0GzeIW4UaacgsS7WOZb8o0nhiHzxIIFGoYGBLY0n1ZH5MXxUm8jSZSz6hl7j6QQBz3iWK6IYxmNEsPg1NX9aaGCDWIvNgojCyJq8MmtXI8Tj9PEYlXRO6DziiL+Y50kQPZaXwldi3dvYggmH0NGfcRSIxKkYvgDEVmQXl6DxqsbLrZTCXzahXDQVu2fI1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeNVNPFUZyCesY2SMb7zoSopaAGoKUJqVbgI8mWkPIY=;
 b=5WBIkBzg6yH+b9Sti6XcfndO1dqfCh2sref57Cm03EjEOlVnwS2B9VrBYkmjXAFcXBFuCqCaWJbxK3XbZr86W6kgh5SpK5h54pni9XDrFrDbvlKjuYSgradrSp5W2JFNrLYpxAhqrr9PzRPw2pjvOlJARrq0+FqJg78U+eVD1l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 06:31:09 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 06:31:03 +0000
Message-ID: <73ba42f7-f879-4b0b-8e6d-2fb554e0f35d@amd.com>
Date: Mon, 4 Aug 2025 12:00:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
References: <20250731060920.1694915-1-lijo.lazar@amd.com>
 <PH7PR12MB59975C7A637B78C04BAA82C48227A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <c182e36e-e8ef-4507-a6c3-8441ba8915fe@amd.com>
 <PH7PR12MB5997C569108C22D2BDC00B358223A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB5997C569108C22D2BDC00B358223A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::29) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 166a47b9-8119-485e-2cb4-08ddd3207c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlB5Mzg0bjRFVzFMT0I0NXRTUi80N3Q1V0pOQkpuZnRzT1VvenlVOG5OV2hm?=
 =?utf-8?B?ak9nOHhmc1I3MXVrV3pVZlVRWmlrSGdLS3pUZjFsUVl5MDhkOHB3RnBmQlpI?=
 =?utf-8?B?d015SFpvRVdJNTZCQTIwMEFFbkZTRmNWeWJOOFlwS0ZRNlhVeTlneDVwNGpa?=
 =?utf-8?B?SEIrSnlHeE91UlhZaXZkQjFSZlhESytZTkozcXo5QVA1OXBRTDdqTGJIUTN6?=
 =?utf-8?B?cUlpT2I4RG9CTFcrZVNJN2d2ZCtYMytlR1dSZVRTRElib01IcEo3M3N0WmtI?=
 =?utf-8?B?U1JyVTV3cDJUSzNlSGZDZ3FNeE83dkh0cmVLS21uSEFVaStnQVZsVTBXemhh?=
 =?utf-8?B?SjVLSEh6OTNWQVEzMThMblViWDZFSUUzdjNwcWVwQzcxdXI2cm1rcEZNMDA1?=
 =?utf-8?B?ck5SRkIwbzVLRDVqSzR6RmlPZzdFdjlKWGhQM3NjaTd0eXh0V2tTOTJMWHhS?=
 =?utf-8?B?aGR5Z3NEUmxJVkZhS3hjYzYzRERrazU1dnZGM1hHbWl2U1NUOHh4NTJVeitj?=
 =?utf-8?B?cHJHMW5HL0NzRk83UFo3S1QyM285RVFpMFBUL3JIUStlblY3ZXQzUUVGNmVJ?=
 =?utf-8?B?em5aa2dVeFExQmVraG5lUVpVbjdYbHBKalZhMmFnNE9nTm1XNW9GZ0s5MkRt?=
 =?utf-8?B?UEZhUDdlbFkxKzlVTXJvamkwa3pvbFE4QVpnSmx6QnBveVVHdnhvUytuTjdx?=
 =?utf-8?B?aHZTc25Fc05mMHZQLzAvNG5lL3phNFdIbUV4UkxpalY5UUtTTUZUWU1vMnN2?=
 =?utf-8?B?ODY0QXJtNFpVaEYwWlNiR2w3SzdjcEovV2dINk12NUdOdFFYbmJFQVNHZXJQ?=
 =?utf-8?B?cTBWVGVkbW8wSzNiUVMva3o4OGFJOW8wTm9ISmhCc1A1SmZnTDVXNjRONThy?=
 =?utf-8?B?UkttMG5QbWRFeVFlYmEyNDU5Mmh3SkVFZ2FZWG9oMmorS1pMbnFPNE9aeTBO?=
 =?utf-8?B?U0V1KzBBQVp5QkZQWkZ6SGVuSHN3elcxUTJlZkE0ZUxmUnVDMlkxeDJpajBn?=
 =?utf-8?B?TjlvcW9UY0lILzhWYVduWm1HUE10emFlWVI2TzVoMDFQWDF5TzA4VDhCVWZL?=
 =?utf-8?B?K2ViK0hrM1htZjN6TEVleHlNaFVKaVAvVUZRLzVEeDhhVjd5MnViUlM2c1Jq?=
 =?utf-8?B?Z3dXODgvVUZBN0pmTlRuaGpVQlRXb1ArMjBweTdBYVB3b2ZuVW9icndFM2JJ?=
 =?utf-8?B?NFFoZUlwQkRlOGJ1TXFrYk1PMTJsOG1DL1Qrb1pZN0RzdUZ6SEdyeFp3N3JP?=
 =?utf-8?B?d1hTMzlqallRVStiV1NCMUkwbm5tZWhOUTlPZ2liZFdWQ1dTZFZFRzdVdkJo?=
 =?utf-8?B?d2RETUp3NWphSUNYSXdtdzdXakRSQnRTQTNJK2NMNFVlT1U5d09SRjRUYkgz?=
 =?utf-8?B?TGI2cWV3R2Y4S1FkdkZJeDdCRzJ2Mno0dUJXUktENzBmdC80eTh4U2VhZHQr?=
 =?utf-8?B?cmhCMm1kd0JTU0VmV1RuajRia2VRczFRYTlQTUF0b2o5SUtvQUVaM3JhN1Zz?=
 =?utf-8?B?WnU1TUZXT3VYZWZCVUY0L3ZrMW9oajI1OWs1c3lqV2UyTkJRZGE2eUtTVC9s?=
 =?utf-8?B?QWlqdzI1QjVaMjhwWnlVcGhWZEhaRFFvUzVVTkgrNGNaWWFDVFVDQkttancr?=
 =?utf-8?B?Mjh2VjdYdE91Q0Z5NzVJMU8wWGtwemZOUTZ5TkNPeHlXTnU0dmJQUVFFRUwz?=
 =?utf-8?B?K3NSeTI0K3VEQ1V3VzQ1VWkvVFV1R0hpM3B0RW80K09sMlhZMnh0dDFHTTQy?=
 =?utf-8?B?NGdNaXRqeW5xdHlmTGZ3dDRkUUQyMENuWmoySFgvTVk2NlhiVHVZTGw1MStI?=
 =?utf-8?B?WmpCTHR4ZE5UOSszYzFHOVQyRG9PL3dmM2xxcWdjRk9QTjVIbWE0angySmNx?=
 =?utf-8?B?eWtrTkZRYm1STEtvWkd6T1pLVGpNWlcrL0dBODh2T3VacytOK3c4UEY4WTZr?=
 =?utf-8?Q?OCcoekx1oiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm15L1NPaTEzWWpGSHBnc2FKWWpwZE1wOTVtcW1raHNXNytpL0pScHI5Z1Vh?=
 =?utf-8?B?UGViSmIxOHFJcHhlSnBtaTBIZHlTY2ZnRWttYmZRbld1L3AzSGFOUTVDdktw?=
 =?utf-8?B?WE5pT0VnS3oxK2Y3LytsOHV5ZGFOTTVzL2xqUXFXN1ByaWZnL21YRmNjdm15?=
 =?utf-8?B?WWZFSER1LzA5L2lwcWFMMVRjZnhWemxlSHJBYTRhcUEvR21ScXI2R2s5V2g4?=
 =?utf-8?B?M0d6clBOTVNXbm1icEJLNml2TGZleHdScStnOUo0RFpQWXhIT090ZGFjS255?=
 =?utf-8?B?K25GYWRKZ1loVTQ3TmhnUER3VzZjQmRNWkhIdGtKUlZha2NSOEp4Z2NrTm5k?=
 =?utf-8?B?eUFadytRVkZGekRiSU1VNncrdWJFRFlnNjc4WUZuVHBnTGd2K0RaM1dPNmdx?=
 =?utf-8?B?MzVEUFhac1gvSENWanVNUkFpNFp6bHVIaVZpaXJxcVBqTnJReTMxMjN3T2Zk?=
 =?utf-8?B?WjBHanB6QTFJZ2dlMklzOUp5Vk9XSERGYkxSZ1h4ZlNuWFpRbENkakpWSlhz?=
 =?utf-8?B?OGF6QTI1MVpGSll2dzJWSXJnRm1FZkxuRGg5dUFDTDFKSFovd3BFd1BSVUxM?=
 =?utf-8?B?Njc2WDY1aTFITktpOWNEZEl3N0k0QzBqdVJnUkluUHhSaWxmS2hMMzF4S3ZR?=
 =?utf-8?B?R1RSMEM2b3B6ME96T2NFRDRXd1hhc1Y2NVlEZzFvZFFZa2kwWUtNT0xYd0F5?=
 =?utf-8?B?WjQxZnNXZHZHWnRIU2k0dHQzUjBLVmlwL1AwdWpxaWl4K2RkSDA3Z0YzMG04?=
 =?utf-8?B?QXNDZDMwN3VIWkRxKzRGRHFGTmFtWGVwbEx5b2dZTjYyZWtGOElXWUlUVmxq?=
 =?utf-8?B?dnRWdTNIMjFLTHUzR3U5WFBJQzdtUWg0WlY5SC91ck9rSWthMlVUb1dqU09X?=
 =?utf-8?B?YWhCU2Jha1kwWUE3VStqWHlQTWtYNzhkQ0xQWXYvTHlFRUo5WVZvZ0xrMk5z?=
 =?utf-8?B?bWtPVEVWOFRvb2JaVzdqNG9sZStuRFo4NGZPd29DY2xLbE1hT04ySGNHVGc4?=
 =?utf-8?B?akxpK0kvb09rUW1LOTgyQ0hZY05DRFpsN1BKRSs0UWcvUElMZFY5dGtnek14?=
 =?utf-8?B?UitNYWt3b1NndUJVNHpteFV2QWRSZXBRQW9jYlUyQXNyNnZ3Q3lkV3ZFd25i?=
 =?utf-8?B?eGFzbjR0UFBaalRHUkVGMTZHbEh6SEE0SlliMGtlajBRU2xjeTM0R1A2QTZY?=
 =?utf-8?B?VkZBRkllcmhuQ0JQOC8rQkRzck5PblFFY3JWZXFDNGs4UnRGUlVTaEZnYnAr?=
 =?utf-8?B?SzJFN2ZWalo0ZmlFeHVHZzExSnMwUTBnM3dvMTFtSmlZTVFUbkh0QlBheVgr?=
 =?utf-8?B?R0dXUXpNZ0hVN1cwZDA5YlFMd1lYQXBncFQ0bEo4eFhhMmVrZUZ1R1JBOXY0?=
 =?utf-8?B?TTZFNnRHd1BoM1hvbU5GUmVRRERnSGJPNmYza1VaYzl0R1ROdW44MVY1djl2?=
 =?utf-8?B?bFZjUXNLMTBYR0ozVUZZQzU5MGsyQXpoRExhSE1RQm0wNitPajUzdnVUTzEz?=
 =?utf-8?B?VEkxRklVQkw4dUt1WkdyMXF6RlJhaWFqdEhwOGQ4aGpmK2RZOGsydWtUeHFm?=
 =?utf-8?B?UzY3THhKUVlXL3puNFhoVDQ0dTBnYW5IaU94WndyYnd3Z2llTVpuaHNYQTh4?=
 =?utf-8?B?NllIMThUcHZCOEJTOGUzRUJzS2JhTXdXenFycXNPVEYrNzZMa0JPWUQvaW9s?=
 =?utf-8?B?V0JTazcvYkkzTXRXazgxeDVqdWZENy9IakdBN25RQXlVekdJcXplMWJxWXBW?=
 =?utf-8?B?R0h1cDVZenhQc3B0ZFpDemFwZmdlTVI5Tllsc3NnVWRmbUN3a3RKTXVXM0xk?=
 =?utf-8?B?bjFVeml3N2ttSEZkdld5c2ovUWJUSlppTVBJUzNDV0FIMkkrbjQyek44V09X?=
 =?utf-8?B?WFRMK0NWQ20zbWRXekVlT01UV0lQSUltUFFRN213WlBxQkg0cWZ4SmZPeXRV?=
 =?utf-8?B?S2ZSMndSU1dEKzFaZDFZUmVGbmYxeGxBV2lJdEhsbkxZYzZHZktkaE83NW9I?=
 =?utf-8?B?YWp3T3c0aGRhbWZ4bWUzTWlTbWtEd2xRWC9qMGhsa210RXFNckIzVG85L3Jv?=
 =?utf-8?B?SGtXV014dVJUMWRsNDJ5bWE1SFN5Vm5DcHJ4QXR3clFKYnRuQ1QrZGF3bXBs?=
 =?utf-8?Q?6/IGQtyDO0QY9EZpIuL+FPUUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166a47b9-8119-485e-2cb4-08ddd3207c2e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 06:31:03.6408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMFHYpAGybK4BiqNPv/FmuKTpfcYEy4ShDn216fubPV17IkQFUXR5yPoKgVkFf+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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



On 8/4/2025 11:10 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> RE: SMU_MSG_HI_PRI
> 
> The name doesn't look clear and generic enough and how about rename to SMU_MSG_NO_RESP_CHECK ?

Since we check the response of the sent message, NO_RESP_CHECK may be
confusing. The check is skipped only before sending; will change to
SMU_MSG_NO_PRECHECK before pushing. Thanks!

Thanks,
Lijo

> 
> Anyway, the patch is
> 
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, August 1, 2025 15:43
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
> 
> 
> 
> On 7/31/2025 2:00 PM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Patch looks good to me.
>>
>> But I prefer to add a flag such as "link reset" to indicate that the response register may not accurately represent the execution status of msg.
> 
> There is nothing wrong with the response register status. The message is simply not processed since the firmware is doing link reset state. Hence the response status is actually correct in the sense that previous message is not processed.
> 
>> And mark this flag in the necessary case (such as reset/flr). And the check of the previous msg response can be ignored when the next msg is issued.
> 
> A similar thing is done for RAS and there we allow a certain set of messages to be sent.
> 
> In this case, we are marking messages as priority messages which are expected to be processed any time regardless of the execution status of the previous message. Reset is considered one such category of messages.
>  > Additionally, this should belong to a global state of an SMU/PMFW, and it doesn't seem very reasonable to bind it to a specific MSG.
>> What do you think?
> 
> Though it is related to state, only specific messages will be processed by firmware in that state. Here, this is only having a single message.
> If there are others too, those will be flagged as well.
> 
>>
>> Btw, the msg of GfxDriverReset/FLR both can cause the response register to be cleared.
>>
> 
> This is only bypassing the checks before sending reset message, not after sending reset message.
> 
> Thanks,
> Lijo
> 
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, July 31, 2025 2:09 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Sun,
>> Ce(Overlord) <Ce.Sun@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>> Subject: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
>>
>> Certain messages will processed with high priority by PMFW even if it
>> hasn't responded to a previous message. Send the priority message
>> regardless of the success/fail status of the previous message. Add
>> support on SMUv13.0.6 and SMUv13.0.12
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  1 +
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  2 +-
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  2 +-
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 14 +++++++++-----
>>  4 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> index d7a9e41820fa..aaf148591a98 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> @@ -469,6 +469,7 @@ enum smu_feature_mask {
>>  /* Message category flags */
>>  #define SMU_MSG_VF_FLAG                        (1U << 0)
>>  #define SMU_MSG_RAS_PRI                        (1U << 1)
>> +#define SMU_MSG_HI_PRI                 (1U << 2)
>>
>>  /* Firmware capability flags */
>>  #define SMU_FW_CAP_RAS_PRI             (1U << 0)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> index 02a455a31c25..17e0303f603b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> @@ -106,7 +106,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>>         MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqByIndex,               1),
>>         MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,                     0),
>>         MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,                     1),
>> -       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI),
>> +       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
>>         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDramAddrHigh,          0),
>>         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDramAddrLow,           0),
>>         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDramSize,              0),
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 9cc294f4708b..c22b3f646355 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -145,7 +145,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>>         MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqByIndex,               1),
>>         MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,                     0),
>>         MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,                     1),
>> -       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI),
>> +       MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,                  SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
>>         MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDramAddrHigh,          0),
>>         MSG_MAP(DramLogSetDramAddrLow,               PPSMC_MSG_DramLogSetDramAddrLow,           0),
>>         MSG_MAP(DramLogSetDramSize,                  PPSMC_MSG_DramLogSetDramSize,              0),
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index 59f9abd0f7b8..f1f5cd8c2cd9 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -256,11 +256,12 @@ static int __smu_cmn_ras_filter_msg(struct smu_context *smu,  {
>>         struct amdgpu_device *adev = smu->adev;
>>         uint32_t flags, resp;
>> -       bool fed_status;
>> +       bool fed_status, pri;
>>
>>         flags = __smu_cmn_get_msg_flags(smu, msg);
>>         *poll = true;
>>
>> +       pri = !!(flags & SMU_MSG_HI_PRI);
>>         /* When there is RAS fatal error, FW won't process non-RAS priority
>>          * messages. Don't allow any messages other than RAS priority messages.
>>          */
>> @@ -272,15 +273,18 @@ static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
>>                                 smu_get_message_name(smu, msg));
>>                         return -EACCES;
>>                 }
>> +       }
>>
>> +       if (pri || fed_status) {
>>                 /* FW will ignore non-priority messages when a RAS fatal error
>> -                * is detected. Hence it is possible that a previous message
>> -                * wouldn't have got response. Allow to continue without polling
>> -                * for response status for priority messages.
>> +                * or reset condition is detected. Hence it is possible that a
>> +                * previous message wouldn't have got response. Allow to
>> +                * continue without polling for response status for priority
>> +                * messages.
>>                  */
>>                 resp = RREG32(smu->resp_reg);
>>                 dev_dbg(adev->dev,
>> -                       "Sending RAS priority message %s response status: %x",
>> +                       "Sending priority message %s response status:
>> + %x",
>>                         smu_get_message_name(smu, msg), resp);
>>                 if (resp == 0)
>>                         *poll = false;
>> --
>> 2.49.0
>>
> 

