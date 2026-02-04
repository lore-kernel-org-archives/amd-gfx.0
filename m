Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01E7E95374
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 10:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D95B10E5AE;
	Wed,  4 Feb 2026 10:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCzpukCa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEC010E5AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 10:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIVv6Z97lykwD5zdOmikj3MBOX4cxdCMou8mai5wy/wcTRWl+UjsUSidqfUmG7BPqJAvFlpJRDivc5HWL02Y2su1qCIjLBT7ujmh8JRiqBldJ5TEbxsdfx/dMdVdjvT8axFbrg/Thu/M4YAA9+To3bhZoWZG2dwaeoLGet5BPAXhmLZEYhZ43tv7hd4DO1hoEzVOMjHCsInXhg4PkBjtLv0TzN6X+T9kROh42j9HivBkcSE+LC9vBjXRzzCtDW9HXpWJ7+subDYFhp9TbtnD5zYX8ZzDvw2AJfqnz7iYEgySlqkS4ulYn/cCLtwpKN/TfYTtQRqd4CVNJuYfiWdTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLfNg/pnQGfXj9u6KY1HXaOTx3rwNStBcQMLb9I067w=;
 b=ILHh7wGME8QNgfKobrHi9xcJ/WD6bhKYuRfK4yiARsVnKZvTB9yHjnkFkA2qJIbB3BuJa2s2G+hemrSSXP19udJGI8TiEy+/xzfzi9ZZnuNKuhB65BpbILAqqp30400fGDTucPAOJ/snysKVe6nAxLxtCBG48DQIEuULxmtY+BwmY6Fmtrt1RDaR50HxutswxB+3bsW5sw8IXq4v921ME+sVu0IOOzE/1RZXyehl5R/+kMyXU2pJ76JW2yNUCyCTyB3bcVM+U2FCraXxr9HhAP5AAPqBdHWRpbV4pESmkzffH8BBx0LLKhUCAtwYzOdwoM3twPPkn8bkrBDsA/dZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLfNg/pnQGfXj9u6KY1HXaOTx3rwNStBcQMLb9I067w=;
 b=sCzpukCa2NabF9yQ7rrUipeGA7eYj42CiajD0ighJ7MaNFMOrl5I5nArWPUPvrEBjc25+X8wRqkLwjhnmB/1eeUEqE3z4AeJtgV9P4pZJFX8+UPIA6TCyz1uRUAZe1MHKFR/+oVEoRwdUgqYT/kK6otlIPUSkTEjve+H87fYWVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:16:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 10:16:17 +0000
Message-ID: <d9bf1860-36b8-40cd-a3d4-82a699ef9b60@amd.com>
Date: Wed, 4 Feb 2026 15:46:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260204082547.3799740-1-asad.kamal@amd.com>
 <13ffc589-243b-41f6-b219-9136fbcaf09d@amd.com>
 <PH7PR12MB59970022C8B598A0111B4F478298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB59970022C8B598A0111B4F478298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 597e12ff-fbc8-40f1-fbf7-08de63d66f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0NHNWZjVEd1ZnBoWm1xV09kMkk0KzZ3clBJN1E0em94Qlg3UFJTY01KVnlz?=
 =?utf-8?B?N0pUVDZWWDJhaTFCMDdodFNYQ2VHclpFeDZaRHBUZnJSdkVQS29rQ3VyU0Rv?=
 =?utf-8?B?TysxdFJpVkFpMmNNanZpQ1JzV1Y0bmduRXk3RDZxVHJtbHpFQVFoSkE5RWJR?=
 =?utf-8?B?aUMyQmVvM1Roc2dwQmZPZ3V5NlR6Wm9jSWJCNkFLaDN5T2doSXNIcGYzdm1U?=
 =?utf-8?B?d1VRRU9vRGlyc0ZHbTg4a0FQT1VZb2h3K1JkYXVYU3V6QnczMlR5Ykg3TkZQ?=
 =?utf-8?B?ME9Wb1hKR1ZtTEtJMktCaEJZaTlWZVFkSmZGUWpiUDZaY05nV0RNQkhodGZy?=
 =?utf-8?B?MVBsYVRTV2FoSmRxMEhaUDJOOVdkQnhiMHpCckVLWXFuUTZ6NkFOcTlRUGRW?=
 =?utf-8?B?dUFCL2p3K3dlZDdmTVNSbm5qejRlMDlKRzNCMmxtazl4V1owUGtTZWdHZUg3?=
 =?utf-8?B?UXJicTVzNW9ZbTRMbVVSaHRNRUsyZVNvOXI2MHAzZDJqb2g2TnJ5Mlp3TjN2?=
 =?utf-8?B?VkIwb05TZ0ExTmg3TlJZcW1SeWtsRGxGMVdjNTduRjlVK0F1endlamlKcW9m?=
 =?utf-8?B?dktIRzlwanRMMjRwVnRWQldFUWVLc0xYWEZqdWRaQ3JLSDMxbFNTMDE4Y1FF?=
 =?utf-8?B?TXY4bEh2UDZXbGdUTjBnaEN5d3NtaU83c2luSU9ZcTFMYWR2M1c4enRjcGRq?=
 =?utf-8?B?emliSm1VOGQ5SWIyd0dka29LTTRMNmpqakNJazRmbXpxUkJCSUV1M21aUDhD?=
 =?utf-8?B?UmY2dzgzTG5seUFTUG1qdVdBT2xiOXQwOFAraXZ5cVU5aEhJQzRzTFlic3Ew?=
 =?utf-8?B?bG82dVZNTmhIMVMvY21NSUloRGREOXFOeEEwNzlmMDU3RWY5NVQ5S3JOYUtW?=
 =?utf-8?B?UG5LOExrTEJXSEhORngxa0tmWDB0MS9IZXlEamI5OUhuOTRrdkxYTzl1U3I5?=
 =?utf-8?B?dmpGbnFUcWdRMEhWU01iQjdKOVFrZ2JQek9UL3ZnYVd0VVVHV2dCOGQrZGpR?=
 =?utf-8?B?QnoxOURxM2M2MWIrZEdDRm00bzBjbG0zYU5ubFpzcTdoZE4vUVRmM2l3VFN2?=
 =?utf-8?B?RTFYQVlrVkxkaE1ObGlBbjNlT2hPRmI5SEFDcEp1Y0VXaG5ZRjlGYTE5U3Rh?=
 =?utf-8?B?OURNdVAyakhleVVuMlBHY3JpY01rVGpjK2d4SGJkK09rQlhXUXE3bHpyaDR1?=
 =?utf-8?B?cW55djBaUDJIa2ZnaWZRcmRkRmNzbzhoeVkrWVJHL1FyS2t4b3Buekhkbzdi?=
 =?utf-8?B?RUpZYmJLQk9rWHdKdTJqTElVREVBYklWYW9sSndYZmFTMkJaOFgyZ0ljQStX?=
 =?utf-8?B?OHVrOUoxaVJSNVJoYXRYMFM2WTl2MmNzL1ZidnpXM3lXRlk3b0RCaFcxaHNi?=
 =?utf-8?B?eGZZRTAwZk41WWNHazNhR0V1bTlGc0kzTlprYnFZR002M0VKZFVReHhFVUJ6?=
 =?utf-8?B?RFdRRStlZTRkei93RmtRWHVXM1NHZEVHTnVTbDhELy92Z2ZrVDZnNmZ4VG9J?=
 =?utf-8?B?SUJMbUFMRHVvS3RvN09Scy8ydE5KVFhCakdFT0FoREtMVHp3RjFYOEdxY01I?=
 =?utf-8?B?ZGlvNm9iWU4yL3dQMGhOYmxNSGFjOElDZ0g5SW1PclIwRlNnNndscnpwWU9z?=
 =?utf-8?B?bGcyUCswc2tXeE9TbUh1N3pPc1BaWnVEb0pnS3lMUEVLdCs5aUFURnlYckM2?=
 =?utf-8?B?ZmZlOUlSRWlUbnJyTHMrR1pLM0FIWUJic3dxVFU0enVxTEtwUkpCekJRRTBJ?=
 =?utf-8?B?MUZtaUljRGZBOVovY3ZBMi9yT2MrWFp4YmQ4ZmRrZUVmWWtZZmFsWERLd1U5?=
 =?utf-8?B?YXlONm9Ic2tITyswajlTa0hEelJZYmkwekJVUyt3V3F2OUsrdXJDUnQxclJL?=
 =?utf-8?B?QVZaMXAxYWpiV2NLcVhQaWNRbUwvR24vWWkyMzlTbmRGUGZTdXgzNWc4QWxW?=
 =?utf-8?B?Q1NRWXVPNVB4UnVzM0UzQXJHaFJJWkFMVEFQVmVOU3IzdHF5THNJREpIeXhO?=
 =?utf-8?B?WDJoZmw3UTMvdFdqU0N1S01ETXI0dWJsa3hTRDNYZitLUWttUGhPZEtyaFhY?=
 =?utf-8?B?QkpBVVpxQ05BajFCQ0FJNWVSQXI1OVF0UGNZeUxGaTBDY1B3dEoxR3FjbGhr?=
 =?utf-8?Q?C0Fg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRwd21rdXZLbkJOOUF2c3dqaGkxTEF5czZCOWxZUnZ0VmdwbWk1OGpldWgr?=
 =?utf-8?B?b1VsYVlPK0lJbm1vQk5adWlKeUZZTTNjREtnTXlBa1IvOE14L1pDeDgxMFZB?=
 =?utf-8?B?bUxmRnU5UGxRbEdkMlVMMWFhT1cxSXJlUkJ4VHVGTjNROGlZSkJnb01hSnhv?=
 =?utf-8?B?RXRFd3hiV1VzRzVyTDF3dkh4ZXlaQ0lIeHk3em1Zd0Q2d1ZHUFpncnJDVlIz?=
 =?utf-8?B?d0ptWnJlUUUvd3h5NCs5N1dlV0hsbDBuUG5XSjAvRDZqbjFPTUFvdWFML1J1?=
 =?utf-8?B?bWh6RS9YYmJrNHNmNWFuQnFGNEFsQVdLd3YxMHk4TkRMTkdnS2p6UXNFOERX?=
 =?utf-8?B?aEpPVjdHa2srT3RwRmhxeGlQRThGVFE4MTRnZ042bXRQNlB4UmNGNGJNZ0NR?=
 =?utf-8?B?Wk8vMjZUUHp4YnQzYXNXTmc3YnE0Q3Y0OXB5WEpqQi9BVGhqazZ1SEt1RFY2?=
 =?utf-8?B?OUpwVERwSGRBcFV2QSt5SlJiUld6THhXb0tDN0V3cVFYalNaZEtzMjRQNzZk?=
 =?utf-8?B?aDV1V3kxMEdzT0NrS2RCSlFIdHFmTG9nc0NuL0RtK1hFQ1hFa3RxR3k5RllL?=
 =?utf-8?B?cXVGc3B4SXJOSFVabG5DSjdBM2ZHOFhabGlJUVpGTXE4OWh3VXo5WmRvNUxR?=
 =?utf-8?B?UXBjRTBmcCtoaFd5MnM4T1NnSWl4TTBuQW5aRitCV1pXNHRJWm5wMmFmK0dF?=
 =?utf-8?B?dmlTSlBRZXFUMUJELzB3UUkwcnhwVVhpSkNNb0t5a0h1MHNTLzl1MlZBVi85?=
 =?utf-8?B?a2RsV2xMZDhOSExkZHNBRE5MU0hyVkw4R0hvOWhBVVgxck1NVlZoNGsvZDNy?=
 =?utf-8?B?M2VGVFRxSVRlOWVSTkx2aFh1NnBjcFFldXhiZE56bnE0K05zRldNZnQxZ09E?=
 =?utf-8?B?R3dXajBXb2NvSm1jVmUwdFdTRUEvdXoxTjJIRWc4RlJ4SzZkdTExam1SeUhY?=
 =?utf-8?B?ZGUyU1gyZ2xBS1c4MldZYi9NRnYyK3oxVHR2MXBBNDM5RE9ldTBkaUU2THg2?=
 =?utf-8?B?ZnVwa1hFR1l2ZkxzeFcrU1RldytwWVdKOXRMcFlaUitOOEZMOUVoaXgyNXpt?=
 =?utf-8?B?ZXhIbk1UU0RpLzYyNjMwZXJPOHAvdDlrZFNtVCsyUXpHT3lZNW1xZDJrS1ZB?=
 =?utf-8?B?WDNIL0h4a0UxQlQ2d0o3K3pxd3cyTzRpaEpQOG9Wd2xlSlJQckt3MCtjbWF6?=
 =?utf-8?B?Y0dsRG5oSlh2eEROOEJzNHRUTFFSNThVT1FraW9zMFIrNkRPeUZzYi9lVnZk?=
 =?utf-8?B?Wk5RVi9RVWc1cVF1MUpTeGp4Vk81RzlvaXdiTnhTWkNHeEhlOGZCQ2o4aDdi?=
 =?utf-8?B?TGhSNXQ2eUhEZTNjQXZUbXMwaVFBL3hraFJIYWMwdFRpTlQ2UDdPRCt3d0pw?=
 =?utf-8?B?cU9PWW8xU0k4b052NmtTNjJscHpqa0lodkFVZE9wNm1JRlFBeGh4cmNNWDUr?=
 =?utf-8?B?enZFYmxKWEtLWEFiSEdqN3oyWTF3K0Vqc2sxdjhML0p3Y2k0cGxEMnZ4by9L?=
 =?utf-8?B?UkxmQ2J5LytiZHR4eFgzUjlOU0k1cGxjbzNmN2dKWUVxSTRFM3hTMktqVktE?=
 =?utf-8?B?UzRhbEZROVo2WkdCS25USnRzMlg3emgyZkVkeFVVRjR1K2VuWHRwK01nQkV6?=
 =?utf-8?B?RitHaE5NaHIvQWc3VDllZG12b1dwL1loQjBqTy90NWt1OFdvVTF1RlEwcUd1?=
 =?utf-8?B?ZFN2bS9vcytNZDlmQVZxUE9reTBId3hYMWlUaDVPcUlUMXhSd1ZTejhmeWxs?=
 =?utf-8?B?aGQvaFJBdnNzMklvcWNyWXg5L2xUT3JacGhmR1RUdXpac3RuRGE3Z2liM1FE?=
 =?utf-8?B?TWsvNmt0VWQ1ZGExL3NYNkhoSkxQQmsxcDVYOE1CVzAvWC9qNE4zR0RBdzBj?=
 =?utf-8?B?aGdTK2I5dWlLMHo2R1VZM3pYUWpMU1ZwVVgxM21kUWpmMWtPMWs2dWIzTEtk?=
 =?utf-8?B?Zjc4b2xQRXRLTnBXZHk1RVJpcVhmRDVkTmM3RHMvbEUzTTZWZXpHSU5OWWtF?=
 =?utf-8?B?ZHF0ZlpOdHp3QUIyWis1MkN5TFliK2JpTFd2UjRSVDJxWXBBd0ZkL25lR0pa?=
 =?utf-8?B?TjlzZitrU3dXWU5YTEFxZEZMbHNPeHVweTgzb2I5R1BMaS9XTlJvdFVsTDBB?=
 =?utf-8?B?YnJweStGL0NhTHUxMnNEZ3FYMlViS2dsMGl0dnZnNHZranJLSVl3RGUvQ3Ex?=
 =?utf-8?B?UnJKMDBxYVBZd0FsZFBxaVYraXptaFZZZm1IRjRTd1BUeWpKc3Faalhlbloy?=
 =?utf-8?B?OGswaGlhNjc3Tml1SVdmZkNZdDhzclJOazdnOUJGSVdSZTExSmUrZjRlcUJW?=
 =?utf-8?B?M0dJVXU3LzZyN3IycS9nR09aOW9uR25kTFNzZFpiWkJDZXFoMWdlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597e12ff-fbc8-40f1-fbf7-08de63d66f2e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:16:17.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjpqhc3CcdBYLQxf3YVSHnMYqbNkLKMxIeAPjac/sGCL8o4TMT/ogZ863zZgNngp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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



On 04-Feb-26 3:35 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> Remove redundant and incorrect multi-vf check for pp clock setting, as
>> the code path will never be taken. Mask check take care of same.
> 
> I suspect there might be a misunderstanding of the code logic here. This is not redundant code.
> Currently, AMDGPU does not support the multi-vf case, so no sysfs node will be created for it.
> However, in one-vf mode, for security reasons, setting frequency information from the vf side is not allowed.

/* setting should not be allowed from VF if not in one VF mode */

This comment is not inline to this.

The logic before this change "drm/amd/pm: centralize all pp_dpm_xxx 
attribute nodes update cb") also supported set frequency  in 1VF mode.


-       /* setting should not be allowed from VF if not in one VF mode */
-       if (amdgpu_sriov_vf(adev) && (!amdgpu_sriov_is_pp_one_vf(adev) ||
-               DEVICE_ATTR_IS(pp_dpm_sclk) ||
-               DEVICE_ATTR_IS(pp_dpm_mclk) ||
-               DEVICE_ATTR_IS(pp_dpm_socclk) ||
-               DEVICE_ATTR_IS(pp_dpm_fclk) ||
-               DEVICE_ATTR_IS(pp_dpm_vclk) ||
-               DEVICE_ATTR_IS(pp_dpm_vclk1) ||
-               DEVICE_ATTR_IS(pp_dpm_dclk) ||
-               DEVICE_ATTR_IS(pp_dpm_dclk1))) {
-               dev_attr->attr.mode &= ~S_IWUGO;
-               dev_attr->store = NULL;


Thanks,
Lijo

> Therefore, the .store interface is removed and the node permissions are configured as read-only.
> In conclusion, this segment of code serves a clear purpose and is by no means redundant.
> 
> Best Regards,
> Kevin
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, February 4, 2026 5:31 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: Re: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf check
> 
> 
> 
> On 04-Feb-26 1:55 PM, Asad Kamal wrote:
>> Remove redundant and incorrect multi-vf check for pp clock setting, as
>> the code path will never be taken. Mask check take care of same.
>>
>> v2: Update patch title, Remove the check (Kevin)
>>
>> Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute
>> nodes update cb")
>>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> 
> You may drop any redundant multivf check in other attr_update calls also.
> 
> Thanks,
> Lijo
> 
>> ---
>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ------
>>    1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 07641c9413d2..81bef5c5aae9 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2057,12 +2057,6 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>>                break;
>>        }
>>
>> -     /* setting should not be allowed from VF if not in one VF mode */
>> -     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
>> -             dev_attr->attr.mode &= ~S_IWUGO;
>> -             dev_attr->store = NULL;
>> -     }
>> -
>>        return 0;
>>    }
>>
> 

