Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CD6C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 19:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CFB10E108;
	Fri,  9 Aug 2024 19:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWmyFKUX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451B910E108
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 19:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqElUCtPWWX92nqoNnpd1/IuqLF+3Pgy8ix2fMQnd3kKLZ9gc6gY4D4GfVd+6cZTNC9T/d71BT6yrggFTX1fAYwsvaRWA8tnHVHxx3ss7pAP2dxySJG3rLH7jMVGvNPGEc4c3uy47qpejQ+F90Nd/g1SbR4pAbknHu9UYPy1aDDE0Qudfyb64VzLVC9Cr/JOGTVTmj+cF+6v2rFnXwe48Hghrs00ZQ7Fr5wZqXph2Q7UGUnBjo0cyMM7ys/oavtAU39y10t4V70/e5EBVh6/YgalEuIv9xXbQwEWi6w2Dpi0co6i36R9+sYBBzhi6/hlNhpGEcomEqKzgOJTdxEGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oll5G7xDMwJ7GUSifu0n1fDafyS3M3WYJbbEkA6/iHo=;
 b=KF5Oiuj7NZDXSPvhPqc+LUzHBHzYN8fXLGgT7H8z6w/9VsNDjXqCGKY1uRBfNowcNsVG02shZoxJOtuHau+offbHNP8P3UBI8/5I+/NROg+dkMwpkXqLuLH15moXL7NTzN81aZ7kr3BXhXzWnWgB631l6Mmx9n1K2Ttk+uOiUnH58gy+dpsYQjebDVDvb0IWNqi7b/jk14Ib8eFRShLfDPsPjLrqR4lPHRKhefIC95n8zMQx+alD9x/CsCLanuCkFzbmMlSkzQs0bZmc8FxWRPGYitu8FO9JY06Gp6nQffdjnZsshxoln7GjMS5rB8tEVeQxOcf1IGAWf637lpvgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oll5G7xDMwJ7GUSifu0n1fDafyS3M3WYJbbEkA6/iHo=;
 b=QWmyFKUXmfIEivJ4Jka9iK//WUYKi22/444/T6ig8l0LOovJwVuAC1fxF12ENNVVV59Cvt8ktuYZPFU2bgUZMU7eMmGSE7e2bmH3Dzs2fKQy/nXjJ6Ki2Ft/dBEfSKOFZp2WgCaJMVm+c3rppzOX0uY+a4WAyAuGI/Bw7DC09uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Fri, 9 Aug
 2024 19:06:47 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e%5]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 19:06:47 +0000
Message-ID: <6149f47b-3b30-4a1c-bcbe-e94b598bad6a@amd.com>
Date: Fri, 9 Aug 2024 13:06:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] drm/amd/display: Adjust cursor position
To: Melissa Wen <mwen@igalia.com>, Tom Chung <chiahsuan.chung@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 jerry.zuo@amd.com, zaeem.mohamed@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
 <20240807075546.831208-23-chiahsuan.chung@amd.com>
 <24bdf1f8-4661-46d1-9f5b-3cf835e39c22@igalia.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <24bdf1f8-4661-46d1-9f5b-3cf835e39c22@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0687.namprd03.prod.outlook.com
 (2603:10b6:408:10e::32) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7c3cac-6af5-4f11-0f0d-08dcb8a66a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEk5M2ZBdVJvMk1DcjFGZ05SRWR1Ty93S1VJUmNBZjBOMGYya00wQzJha2dB?=
 =?utf-8?B?Ni9LS2VESXFpbm44cm5seW8va05mRWV6SS96SkFCaGdVcDNtaTFCRDdMRzdm?=
 =?utf-8?B?M3JLRFN3UjdQazU4UjVCWi8rRXRpclVGaUNJVlhxU01xZFNRY3JFbVJzTFJv?=
 =?utf-8?B?NmFVbENxYTFPampKUkJqY0tIYTVEcUpZK0VwNUd4UjNFSEdyL3hIdGV3c1NL?=
 =?utf-8?B?V2FwQ2Z1SmozU1plYlpFRzVMdEtuTzVkU1Q2SmZOaEFEdk05U2J3UnEwR3p4?=
 =?utf-8?B?bzZCV1N1S0R0SHV0VldqQjdmMHFTUWRJNFVyL3l0ZWZhWW5oU0FKTDYrUDk3?=
 =?utf-8?B?clFSb3BqZ3RxdS9ZbVUyTUJGSzBBdWRaSm9LWHpMWWxEVGlaczhWRkRwdy9C?=
 =?utf-8?B?SGVmWmpxL0xwd0hXTm9yR2Yva08yMXZySmRQZ3JweGpEMS9SUWZmeWZhek4r?=
 =?utf-8?B?UFFINE51ZkNubEhxaEJJdVQ5WGpqSkNhUlJRSjVsSjNFTVBMaHVnVStyRE1T?=
 =?utf-8?B?bUxRajdqb2ZGbm0zVnNTUzFiYmRJa1loajRiUkkzN3RDWS8vV3k5SzEzOElG?=
 =?utf-8?B?blNrVEZLMnFvbkpwNHdpdVpRQTlrUG5Xd1RnN0hPbXJuRW1KdXZqbVYwK3V2?=
 =?utf-8?B?QW1oTE1iVS9NK2hjODV2SVJTNFB6MXFCNkNBaVVlN201UDNXM0pmdjlKWnhE?=
 =?utf-8?B?ci9MdmVhdHY5RzQzbXB5TDVwM0ZxbnVLOEZ3WUd1a2Fnc3ZlWkFYY3VsRXBM?=
 =?utf-8?B?RFZuTVdNSW1sdExvY3Z6bXRKRmhzQmxJZ3VKVHR0ZjBpSkF5QVFBbkFJWnBr?=
 =?utf-8?B?VTczVlJaeGJqaW9FbnFqTlAreDhLYnI2U1VGYzRpbmpsWGN4RFVQZGRhSDdr?=
 =?utf-8?B?VnZRSTZ1VnpTdUpTaFFoYUhGSDBsUXh1YmtPNmRRMFZrQWFYNnlDMXZxVUdO?=
 =?utf-8?B?alJmakx1TjluUjdUUjYyS25CUnVFTVhKZkkxSmh2QkdldHVhUEpUVjBKOGFv?=
 =?utf-8?B?cHl4TUVSS0o2SlRJNDd4R2g0SDdYcSs0YTRzQzlzc3ZEeFhoaUNBS1VubG9I?=
 =?utf-8?B?eXdnWVowUlovcUpVdXpNemJmWktDRzR0QUltM1lNV3J1MklCcGRxaXFzRlpY?=
 =?utf-8?B?SFUrdjVtSzlJaHByNHBxN2M2TUxjUktyQmpvRU1iT1docVdUY3BlcWJhQkNI?=
 =?utf-8?B?K3orcnZ0SmJLMTFNZEhqTEw1cnN0UzArekFzYm5OZkR4S0V4T0pnamQxbXJr?=
 =?utf-8?B?VUlQQ1Q3ajl2dUh2c1FrMFNFdFRXY2xJYzJMejZ1SjZ5STlqK1ZvVDIwdHBq?=
 =?utf-8?B?eDRmdnlXQmJ0Vit3aUE0SDN5a25DclpDU0tkZW9oT3dSZkdmcTIrMms3YnRi?=
 =?utf-8?B?Tk01eUpBRjI4YjRnUTlEaFBQb25CakhIZXh1TkpzNDYxZUNGVlRXT2ZGWUw0?=
 =?utf-8?B?WGtJTHFTNW13ZWZiRVdDb3gxL3hNZHRXY1A5aFI4Mll0ZGVMV1VKaE8vdSta?=
 =?utf-8?B?RWo1TWs0NzljRUM0eE4xdVVRdjFLWjllUlhHd3E1d3RzZEhhc2FSL1UzYS9L?=
 =?utf-8?B?N2trbTd1SXNwUGk1RkY3N2xpS3BmbWxMdHl1a1NBNGJYbmdBS0l5bXI2anEw?=
 =?utf-8?B?VTZBSjcxOHFaY2RVKzVMY3VFeVZ6Mkh5WkFRY0NVdWVESGNPRXRmWWQ3TGRo?=
 =?utf-8?B?RjFoeEF2cmZxb3lTcCtBMkgvckZNb2F4VTVRYWY4ZnE3L1FVTW5FSG9pQVlZ?=
 =?utf-8?B?VnROTGdCRDdsclRhUk5MbkFtbEM0UG9Ua0pZejIyLzJZZnU2cC8rMzFiVHUv?=
 =?utf-8?B?Q2dEZXF4VGRKeUx3RXZkQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytZOXl0Mkttc08zS0dUeFZzYUNwNDNpcUtxWDRXQXZqTEk3amFLU3RYakZT?=
 =?utf-8?B?Ny9Jd1RCcW11cEF0TDZOR3BkZm5XWGlvZ2JDNnhnVmRQSXZRaWs5ald6WTln?=
 =?utf-8?B?eTlhdFh0bFdBTVNnWXF0ZlZ4cUhjbzVKd0EwWU5RSUhvTTNOQlZmMURHbWZx?=
 =?utf-8?B?VEROVERDdXBMSXRPbXBpbkI0WEVkVENjM1lHUllYZ0szUG9qbjJMbFltYW9z?=
 =?utf-8?B?eDJiK25IK0twczY3bWNiUTZmSmFBZDUvMFJNc2NSTlJuTVZSY0szcHlkRmU1?=
 =?utf-8?B?blFnN3BiTWprOHpKNnhtRkQ1TEF0TDhaTytIak9DQVNHNXlLZGhnOFp3Uno4?=
 =?utf-8?B?SVE4TGZ0WEo4bmVPRWlMZEEwMVMzOFlVUlBQTUdyakNSU2VmN3l3TCtDRmQ3?=
 =?utf-8?B?YUMyNWpiMEYxUGt1UFI2MHpZTER3eTRUeFlITXVSaVh6dWJ2ekJLZTRCS2lU?=
 =?utf-8?B?MGdLSWpzN0J0WGRLaWZ1Y2MrQWRtKzhNK2RhYWVQTjZyd3BPOEIxZEsxRDAx?=
 =?utf-8?B?S2YvN2NHN2d0bmxVcmxVdlZ0MnZWWEhCVEd0Mjd1ZXhYSHo0UVNUM0pYZzdQ?=
 =?utf-8?B?OWVEUy9FWmNxUUJsbTF3V0lLUk5FQ3h2ckJubHZrby9VZjZ4clNZMmh6YUVG?=
 =?utf-8?B?MTdDRFRXWmxTK0VjNUlmTlEyeHBDQVNydUNhTFo1MzVmOE1KYXVDRElkelVN?=
 =?utf-8?B?MnVGdE1iZHhtWmNHSGNnYzNMOWhGcFFVNEF5K21NNGtvTy9HclRiTGRzTkR1?=
 =?utf-8?B?bGZ0OVM4RCtiWm1wbDJobHZEenJDQzFaa2JKOFYwbWdoUk4ydHFQZm9iV2dn?=
 =?utf-8?B?UXg3Mlo5eDdnVnpiWUY2TEg2OWFrOTVJQTd4aktNTkYydXkrMHhxb1dxck43?=
 =?utf-8?B?UVRBUE0welkzblZRK0tsdXBJd01aUmJtVnA2ZGxwUW14bmFSQXQ4d1E1MFVr?=
 =?utf-8?B?VmNnanlSMVZlUERRS2V2YzF2L0FHZHFwK3d5aWxYQjFRSEJWMjl3UG4wazNW?=
 =?utf-8?B?Q1NZMEFQblRaZGJ0THZZUHUyTitMaDdudUJBVkNvc3NtSzlVK1VTUmcvTWVq?=
 =?utf-8?B?YzhRTDNveVh1a0FRU2ZnT3pSN0w0REwycUlEdkhqRytjYXk2QmFrR0M0K0d6?=
 =?utf-8?B?YnNBSXlyakdLNjNON3ZmOGc2VXhqQS9hamM1cGRidnRMSmp3TGlGWTdrM1ph?=
 =?utf-8?B?cUtySm81UXRQamRyNjhZU0U5SjdmOEpqTVE0QXJxNzZrWEtYeU5NUVI3a282?=
 =?utf-8?B?dzFwdGRBWUpSVkxwaXFNTjNjb3lKQ2Z6dmN5akFZNkJMQ1VqNUxvM3JucUlE?=
 =?utf-8?B?MHRZYndBODJaTlVuNWc5eDJueHM3eEdHOWVzVy9jODEwUmJGK05FUjM2NG5Z?=
 =?utf-8?B?S1J0aVQ4UHhVMjFGemRCbmViRldPNUcrY1Y0TEkxc015UVJidkJ3L3ZOREhH?=
 =?utf-8?B?U1R3L0FxdXVieGhPWVo2bk9oRWZwSG9Nd1JhMkkwNGczUWFpd2pmQkFqbkVM?=
 =?utf-8?B?S1NnSVA1V2UxUENNcmE3eTNTZWlmRlpDMytuNjNWSHV0Q25TTzkrM1BOa3NM?=
 =?utf-8?B?cE82QXBOaGhHeWlQWXk4cGIyM1V5c095blZDSzVtT0RIa3RYOUlaNFBVTFQz?=
 =?utf-8?B?clVQSDQvRDJ5MzNDdXJJcFBsVnFSb0E0eThhR2FJc2FnMHNscHlRNFlTbkJa?=
 =?utf-8?B?NmR1YUZ4K0tXQ2p2QWcyZkk4eXRGUHV3UjhHYUx4bG04dHArWGVTUUszWXIz?=
 =?utf-8?B?L1RuN1cyYUdYeGZFZkVjemFkSUltakpUekdYNFNkdnlxUURibTV4VFV4ZTF4?=
 =?utf-8?B?d0ZRb0czcDFoY3MreGlIdTNjUGcwS2ZwY2d4YVVjK2VhQWVoVy9sNGVXTjBO?=
 =?utf-8?B?V3Z1a0FMQW1SbStYWVhybS9DUTNDeHdnRllKSUZSSDh6N1VXSmNmb3JpSFFN?=
 =?utf-8?B?RlpsL3N5NWxLUTc0VURaM3dYOVVqZWdPMUY0MkdwKzErS3l1NE1wczZUZG5N?=
 =?utf-8?B?QmpwaFJrQ0t5eG0yQlc3dXhTaTg0T0M5Mnp2N1RrK1J1eFVPWjhSNXRnbEZa?=
 =?utf-8?B?UUcxNjVGeUg1cjRrUzlKVHFqY25iTXRxM1JRY0hPZlQ3ZWVWQ3lTOE43Qkts?=
 =?utf-8?Q?qft2AenQwTWTYOqTfGYgXtQHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7c3cac-6af5-4f11-0f0d-08dcb8a66a76
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:06:47.1351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5PvI/yN2Uf/02fJ0+dm61elqcMgcRWKEtQ2EAOEMTK4gqM5ZfCmESKY8xM5R+8JqfKRyhCdeD3SQJEduDoDkA==
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



On 8/8/24 4:06 PM, Melissa Wen wrote:
> 
> 
> On 07/08/2024 04:55, Tom Chung wrote:
>> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>
>> [why & how]
>> When the commit 9d84c7ef8a87 ("drm/amd/display: Correct cursor position
>> on horizontal mirror") was introduced, it used the wrong calculation for
>> the position copy for X. This commit uses the correct calculation for 
>> that
>> based on the original patch.
>>
>> Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on 
>> horizontal mirror")
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org
>> Acked-by: Wayne Lin <wayne.lin@amd.com>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> index 802902f54d09..01dffed4d30b 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
>> @@ -3687,7 +3687,7 @@ void dcn10_set_cursor_position(struct pipe_ctx 
>> *pipe_ctx)
>>                           (int)hubp->curs_attr.width || pos_cpy.x
>>                           <= (int)hubp->curs_attr.width +
>>                           pipe_ctx->plane_state->src_rect.x) {
>> -                        pos_cpy.x = 2 * viewport_width - temp_x;
>> +                        pos_cpy.x = temp_x + viewport_width;
> Hey,
> 
> AFAIU, this patch reverts the change in the previous patch.
> Or this should be discarded, or both.

Hi Melissa,

This is a different part of the same function; the above change happens 
toward the end of dcn10_set_cursor_position, and your change occurs in 
the middle of the function. I think your change can probably be applied 
in this second part, but I prefer to do it in a different patch since 
this other change requires validation.

Thanks
Siqueira

> 
> Melissa
>>                       }
>>                   }
>>               } else {
> 

