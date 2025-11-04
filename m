Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D628BCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7518710E269;
	Tue,  4 Nov 2025 13:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3pl8gtNr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE3710E269
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UO/OiYPq1xinlo9j9qrWeA/njaUzusoFzTP3fwmcDaiOZjfSc/xo78lfQNSZYSDsttfTx2cv1o21D2HvBJa3zeHFo7lAPW0rcXCtFXrIlQ5JYiTgF8+FnaWd075Mbuh+Qa2Y81zMQ+s1nF7GJs6AQW5nynTHpW+p0pYXqkkmRKyggp9FRDHP/z8P6GuY+RIbQxG4zNvc25aG/ku2qp6Kf3FWlW/2ZkJTD/DVHWstEsxCzQRzU37hHiL582qyFyTMWO1QKLRqcr1CdaGOQR7KwhzNZW1383ehO3mCP8w/iaztXUbSiLf1vDHyS9S7xHSJDJm/r+K9+qa8yEKCFUCcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlqWjOA0ljyLn7Umn2mlSSQKrZRJHjo22k3IoZZM+Y4=;
 b=Jh8z11DV8RqnuAvTbYWYnV6tw7hg7lWdNGtJ+NFpSYyLl4oQ0Xg8CHkxaadLJOsxjKdW8mCG3O2m1uJVbiXCVWOXzYRfCVlBZJOmUHJF/DFjmCWs/3BpRJK8iKuvApFBR1Rp7GjFhketR9ogATMxsfFQOwq0DebvA8NoD3TPXh0NK3OhPM704ip/01JiXK+YSu/pEMALA1G+3HfTosALp4jfsVKR0Y334gJ53EHEAqNfsvF/boR1sIcVJE2FbPy2XgAApN+FNFaZ7kDNhPW45RFhtnHlwD2WsKW2TLDtmYiMj0CfUxkQJfVWn1bbUICklw3DwntB1yUIDnJroYUB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlqWjOA0ljyLn7Umn2mlSSQKrZRJHjo22k3IoZZM+Y4=;
 b=3pl8gtNrvXbuigxi8hFBzgS3o2XV/PtaUlko0VpWyRTga21qE/ZOY+jj2gjQAJDXazW8idpQPM/bVPPWjHVL1NTXwqlbMl38B6n0v/lu3vdY4anCY/QhI9YyTHHxnLpvCJzH38Kv/9BO3SZI2ROEJHVVhyb4khxA/XL4j5FZDlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:23:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:23:20 +0000
Message-ID: <9b4daf2b-d97d-4b3d-bd7b-3b136a4e304c@amd.com>
Date: Tue, 4 Nov 2025 14:23:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103222333.37817-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de24f71-57d6-47a1-68d6-08de1ba552ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnhyVG5pMTFLZVhrc2tPS3hPT2VXWVE0UW5pQVRtak1mdjV1Wml2dnR1ekVs?=
 =?utf-8?B?R0sxN3VOQlVJcCthYzlWY1B2MlJJZXdRdUVhNG9kTkVKaDRuOUFQeHU0ODNY?=
 =?utf-8?B?WTRzNmtsWGovUXB0MmNscVhTSzVMY0RGQTBOakEwQXhSUFRTQTlBMmV2b3pZ?=
 =?utf-8?B?OGhwa0x5VkJhZ1lGbzJKbXNpa09SOTJZV3ZGMnMrOVRBclRhOEdvbWVCaVIz?=
 =?utf-8?B?alp0TDFKMHN6bGZJSlF5YUw5WmJ3ZVhSYTk5aytnWUNKNmRCSlNLVVFPUW9G?=
 =?utf-8?B?cG5PYUtSTmJWUGdmTThZQ2xSd1lGTDNWU05oa2JZNXE0cmJsL2hhUFp4SWsz?=
 =?utf-8?B?ODVSNUovYXlNbWxLejdGQnVRUmo2NlVwQ1I2Zk1DcG5obDVqSnNUbCs2VDlV?=
 =?utf-8?B?UVo2enRuYXZPQ3RsaFRnWTlyQysrSmFpSE9MeFRVcThiZkNZbGxCYm16aGt2?=
 =?utf-8?B?V2JiQVp2c1UvMGE4MEpzQ1JuZkFYYXVXd050b0lPb0UyT1Y2NFRMTzlVMENX?=
 =?utf-8?B?KzZYVGZOVStuME50UVNiOUFTanhKRWxMNGlGVG15T3hzbzRFMlZqc0JrRXVM?=
 =?utf-8?B?b2RxbE5Zb0M4S2Z0bDVaWFJLcENieFowV1g1L0ROS09FUFVneHRLUkRvTVJS?=
 =?utf-8?B?R05LNEJVT3UvVUlROG1QR0tDRytyQ1M4MGdmRFhuVmdoeUNNVHZ0OVlaR01x?=
 =?utf-8?B?RmpMKzlHcDRJeCt6d1htbVkwYjVBRGQxUlhWM09qNTFNVXhub21xbURzd0I0?=
 =?utf-8?B?MFhCVHQrZ0VndHc4ZXJzV1JLeCtlWkgyalBGMFpyTFVpRnArWUw1aFVYZGJ3?=
 =?utf-8?B?T29WdW9XRnUwWU9FZTM0UXppTzRON1dvTjZsL09NeVdIYXlJREJFblB0UE9t?=
 =?utf-8?B?akNUaHFiblhVeC9leTFidng2NVpDdDJzNjNzSWs2Wmp4TDU2ajRWTHNYTlho?=
 =?utf-8?B?ZmpBWWxlUjNza1RqQXRpM3lVZWtQY1dZK3RNalVvSTVIY2NPVUZPcU5oRTZh?=
 =?utf-8?B?ZHlIaFI3eFdlOVA4UzFMalpnR2lOQWprU2hSTGNpMytzZFovL0pIUlFRZkg0?=
 =?utf-8?B?UjhXSTBGQ0drS1FPUzRzRGNmS2l6c2xtT2pZbDN4dE5lYWh3akFHTEhud1lP?=
 =?utf-8?B?RDdWaCtsbFdHbGN4bWVLa2sxVlgzZ2N4NGFXbkNQWTdrSWxDRkR1RDc2ck9v?=
 =?utf-8?B?VGxXZWNmbUh0ZnJHMHQyOU5ydlk0Q08vM0xHSWJ6alVwNTl4S2kzYnR1QTFS?=
 =?utf-8?B?U0dkZUg1VFo3b0pCNEdFYVpqdVVFNU50VXRwUHhSVmVoekdva0h2RGhhUFNl?=
 =?utf-8?B?SmRTRThKSU84NUVFM2hqMkFQUzhrZzdEOVJnbkNPY0VxWVB3My96aUpiekU1?=
 =?utf-8?B?OEQ4MnpOVjFDQ2txOFgvSWprWTlvRVQ1TGE1dlVna2t0N3UySlU5WlBtOWdX?=
 =?utf-8?B?U3NIR2x5MEYzalpnQnhVMmdyMlF2U3ZVTWRJd2hVNzBBQmlHT0w2M3hWVzRn?=
 =?utf-8?B?TDRiQXF4Ky9TYjBwLzJaMmJQQ2RianBtbEh5MTRwcmYyOTUyVS8ybGNiK0Zn?=
 =?utf-8?B?RlRnR0prc083MXNIVFVJOEtjbWg0U1hEZWVtV2lIeWR5OVcrVVRNL3E2QVQz?=
 =?utf-8?B?NERwek00QVJxKzhiMGdMU05id2UzQ0tsUk9WV1BCN01jbXN4alJnVWNFeGtY?=
 =?utf-8?B?ODBYNDN3d04xSFpYN3NzVzhOOWdtREd2eFpTeHQ4YnZoMzBZRTlWZE01MFpi?=
 =?utf-8?B?ZyswdFh6THFFZGY5Ukc1WWFaWjloNHYzK1VrQWRZNXpoUkhQeVIyaVdLUXJC?=
 =?utf-8?B?cDY1eXBtMUd3SVFMdkZyRnE4a241Y2tvZFdVMU5obzc3alh1bGVLNXRZQ3pM?=
 =?utf-8?B?R01uZ1V1c3duTk9kRUF5eFE3NE9hQWlJeG50TWpBeVFyNWM0ZlpJL2VBek05?=
 =?utf-8?Q?0ozAQ1DcZqG3+nmpRsUB98aE8F7bXyVo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNVRGZQUFprN3pqTlEvZ3N5WXcyVGdQLzJLUkJXQVl2OTRncElZZElwTTRy?=
 =?utf-8?B?Zjl0RERZRXdQZkRhZUdYelJJYTJobzVrUkI2d01tZFdKZGNhbEZFTWtJTVBO?=
 =?utf-8?B?aVFnUkhFbG16dHFqR05UVGNWa1BHaHdkWFpWdndYT2t5WXNzNmlLMVdvZlZD?=
 =?utf-8?B?dHlpR2YvWWhRdFpWODdYWEphSkdXNnNCSEdDYS90OHA1S0NBM0ZhTnAxUmhC?=
 =?utf-8?B?V2tpZzUrVk9TeVRJdldMenJDVEFqTzM2YU95WTBCUjJONkFHWE95VUdMTzh2?=
 =?utf-8?B?Zk92YTA1TUVwOHRnT2JXTGRBWGZUU2FlZTFyTHMxdlpQN3I0VHY0Zml4ZEhq?=
 =?utf-8?B?WmdTTXZWS3EvMTJtUHBkdzhGZXA1NmVPQmJEUzNJeDh0RWljWm1NTEhlTWky?=
 =?utf-8?B?bVI0YTNMQk84djBMZVA1MHRVU0tIUWEwZjRzT04wYWFqUnF2VzdmbFlTdmJ5?=
 =?utf-8?B?c3JiV05MV0JUb2tWR0NwSVc1SHdtc2lJbTFJRS80c25KVEN4UWI1bncrMzIx?=
 =?utf-8?B?WjlvVUlwOUJOMkJkTkhxaWJXWktpWUJETzB1VENPeVFPUGxiMTBzN3VSd2I2?=
 =?utf-8?B?cU45SUM4SDNoUm50ZkY0WmdXQ3FWS05qRFdpWjJ2UGdtZG5EUm1xcUVzb1FN?=
 =?utf-8?B?TFhsS0gvU0hzWFByZHFCNk1mS0pHRDdmdHRqTm1CYkJFZFl3ZkVoa2dPK1Bs?=
 =?utf-8?B?SXViWjA2OHJyNkdBOG9aNHV6RVVlYm1ndkFoQ2tFU05XWTdaTDdsTDJjWXM5?=
 =?utf-8?B?ODFRbGFrcktxQzk1MU5NQWhFK1ZsZUJ5Um5ZanJSZzUrdEtNZXRTR1FzVGRX?=
 =?utf-8?B?STdUMTBNVjFsTVFwZ1pHWkpFMEk4OXF0cnFsTncvMjJkTU1pMTdHc01aSHkx?=
 =?utf-8?B?b0JVdFdRTGZ3UHdtVVA4Q2ptWHExenZmY0NYbm1SYjhlT0Z1OWczMUR6bUVE?=
 =?utf-8?B?SExSdDdUdkxTbEtybVU5WW51OUpTc05reFk5RzZyRDA3aHprT25sdGRveThp?=
 =?utf-8?B?dWRQOG5lWit2cXd3dkVGRWdEZU0ya2tXWTdWbzFEbWM2RGw5c3hGUXNKb2Vs?=
 =?utf-8?B?RzJmL3NzWk1lNXNtZ3YzVkxaZFdJSWtYMUNIM1NRU2VPRkd6a0ZaZnlDWWIz?=
 =?utf-8?B?ekhnWldVZFI3dHl4cUx3MU5QMTd0Nmx1WjkycHU4ZE1KM2FWU05HL1ZBam9z?=
 =?utf-8?B?V215Nzc4b3k5SkdiVTAxWkt2VGZhdU5LaStPazFzTnlFZjZYaW8wUFdjMU9Z?=
 =?utf-8?B?L1dwL09icEVRaUFLMW0zTHlxanVpcE4rV1prY0dwcEErejI1TmNPMWRDTUQy?=
 =?utf-8?B?azA1MFdDVDQva0lsVnN2SGpsaUdHRVRrME0zUE5LK0JqblNnNDNsdnZGTFp3?=
 =?utf-8?B?ZFFYVFVhNTFBbXNhWkd1aGVNZHNnNUhTblpxaHVyUEptNDVldVRHSWJHa25T?=
 =?utf-8?B?ZGIwcXB1SWNZRldoRnMra2Ntc0h0cWFHdUswZ3pTNmRZTnZlMUNRaDV6MjZQ?=
 =?utf-8?B?cGRYOVg2d0hpSUpnd3RKL21uVVRzNEtEQXJMSW1XQllWN0FpdFJmNHBtMzVM?=
 =?utf-8?B?NzNZcW9IbHFKWE1EejFVNStHeWxYYnROT2JxV1AxSjhTSzAzUXA0M2Ixb0xB?=
 =?utf-8?B?WHZpWmJjMytlekFmRmIxQk5ZS2NxdUZVRjdwMGlNZlNwY1Jma3lzZisySGha?=
 =?utf-8?B?Qk00VUYyZTRQZDlIcWdNWkRKaHNHeWIzdEt4bS9zcjMwN2d1TGlUQ3ZEZ0sr?=
 =?utf-8?B?RW9sV0p0eC9yczJmRUxOMDEzMklvOEFiOGpydGhTaU1QdUlMelRHRXBheHhE?=
 =?utf-8?B?dHlzRlB3RVlMelhVcStwL2VLMk9TZmhzNXJFbnAxSEh4Wk9qYm04Ly9YYjJX?=
 =?utf-8?B?Z2xQSmFvUVFmV3Fsd1JuTEFGTkhRZ0JpVG93U2l6SkVpZFdWZmRza1dFTmlU?=
 =?utf-8?B?NGNZd3RVVjVwakNYcVYrclJFRVVoNnE0WmthUG9xbitYb3FYeFY2dFQvYm5J?=
 =?utf-8?B?MTc0SHB2NmQ0cHI2MXZLd0lZL2cySGNDRjB2YjRLN3VSS09uQm1PK2NoWlli?=
 =?utf-8?B?RmhxNkRQNE90L1dJSndtRFBoV2psamtSVE9jdlYrNmZjSXAzYnNTTFppV1cv?=
 =?utf-8?Q?f7Zny9YIMBRyDW+SBVAXfElHu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de24f71-57d6-47a1-68d6-08de1ba552ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:23:20.7004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuOZGwA0CtQFaMQ5FNFxAJwDh8EKNxAMD6d3DE4rkwHP8d1AlFFBdIu82fF5r3RZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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



On 11/3/25 23:23, Timur Kristóf wrote:
> GART contains some pages in its address space that come before
> the GTT and are used for BO copies.
> 
> Instead of hardcoding the size of the GART space before GTT,
> make it a field in the amdgpu_gmc struct. This allows us to map
> more things in GART before GTT.
> 
> Split this into a separate patch to make it easier to bisect,
> in case there are any errors in the future.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 97b562a79ea8..bf31bd022d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  		break;
>  	}
>  
> +	mc->num_gart_pages_before_gtt =
> +		AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
>  	mc->gart_start &= ~(four_gb - 1);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 55097ca10738..568eed3eb557 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -266,6 +266,7 @@ struct amdgpu_gmc {
>  	u64			fb_end;
>  	unsigned		vram_width;
>  	u64			real_vram_size;
> +	u32			num_gart_pages_before_gtt;
>  	int			vram_mtrr;
>  	u64                     mc_mask;
>  	const struct firmware   *fw;	/* MC firmware */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0760e70402ec..4c2563a70c2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>  
>  	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
>  
> -	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> +	start = adev->gmc.num_gart_pages_before_gtt;

I would prefer that we have a single function which returns the number of GART pages we need before the dynamic GTT mapping.

But let me see how Pierre-Eric solved this first.

Regards,
Christian.

>  	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
>  	drm_mm_init(&mgr->mm, start, size);
>  	spin_lock_init(&mgr->lock);

