Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587CACCF2D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 10:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2ED88952F;
	Mon, 19 Jan 2026 10:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GdyrEKbI";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A908952F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 10:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPibUd/HNCeso4qJqf22R5JiPQCes1C5wmAET3LIyPyR+jkZU5ASuEq5XXtwciBEjIejpHUNbNpu0tkchM8qcL2UzD1ODKeMxYMxoK4LtX94fSAqnoIX51edLDR47uix5cTLc2Xw1yoTrLXt0rDqacXVqkT7ZQZprczK2lUUsa0mJoWrrAAUhndKWbLy4sgqFeE3e2ffuBtIBk1Xd3eAdl+g/AJmvbcBQuDS3yl3ZJa58jzPRji1a70efGmHjK0WtNibc2BpHKiYzgXfKH/JTeTFHf+hBqzS+4VyqWE9Grg1uUtyEKFm5aiLah0husyNTW6twSA2niu1i2onDj/isg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLXpo9kcxMWWE3CYfX31Z5v5A0KZSJyh6Let6SN6sYs=;
 b=Yv0HhDZhe/NawETcvBKYWbceWNSqZ5QWnWPJdgaWMpT5Ec5NkMQJqyj8bcplEi3JEqq/NCOENuO8spDL7H8ULq3AEG37mAu4sVgU9h5UhehczBypXvOn20iZ/g0sdqXJjtEU+OMTXrAz7HXk9NGYTwlldWNqeOAKsEEZhGlkAyE4t4s9ZzXFj7UqzvfHmNTGKvDRCieIfplnQxax/tGDglytP96ZM886NMmZBUtmj9eQz9GX+t4gUEOaGSx2F7CyCBf6jwoU5vu0vjl/cN0lXNXxA2UdCVMCqajhuvc9i2c000U4GMQgMKg0J+UefWrZbJOQwjG1P/EdnQnsgkllXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLXpo9kcxMWWE3CYfX31Z5v5A0KZSJyh6Let6SN6sYs=;
 b=GdyrEKbIqTlKsScP11cLqSShH9ig0vJf1+6XmVkWLGK3w+nJfh5oc3lj20624fJ1e7Xb0a+TlgWQD992SH6Skts/BHki0dRQXiCyuRG+IEATVbcmYIsXueTmF+cdd/m92MkHPRcAQLxUSd8oqA6aK0XBR6wURrdSklaQBoM+pwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:12:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:12:07 +0000
Message-ID: <0b3603e5-f6d1-4be8-80dc-e9aaaac48e40@amd.com>
Date: Mon, 19 Jan 2026 11:12:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Prike Liang <Prike.Liang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260118125746.40221-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 023dfde3-20b3-420b-7fa6-08de574333be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1FsYzlXVmNERGpIWGkrRVo0Zyszd2FIUXBGT3hnZTY2bEE4bm1NSUFKaTNn?=
 =?utf-8?B?TDN0bzlmWmF0dmNLaVBqT0FxWWhBVk1PNUlKWkJYQzRZYnFockhkV0kzTXht?=
 =?utf-8?B?MldSSmVWUURjVmxFVEFBZ20xSG9SUTJ5Rm5XRXIyWWhNZ3NDYkJwT0tkZ1lT?=
 =?utf-8?B?NWdHZU9oN2Z3dzhWL2dxbGxPWXZ4aWpIQk9ZNytXaDQ0djJJWnhEbVdmWTVu?=
 =?utf-8?B?bmJQRHdUeExuVnFOeUViSHNkT0pGWnBaSThhUnN4dEV2M3hLaXlrRERZSEVw?=
 =?utf-8?B?SWVDR1lNaXZxVlZPSHlSSUhaS2pMZW03RmdlT0pLVjNHYVJqbkJ6QS9Cd1RV?=
 =?utf-8?B?TmY4c1NPWXR0YnRMRks5T2xZQmJXUTZYT2M1K3ZpYlNhVXBpUGJwWWtlaHox?=
 =?utf-8?B?MmlRL1JXWTdDQjYrc2h5MFdndC9HbzBVa2hpUURleS85SER5SW9rNExwbUtI?=
 =?utf-8?B?U3NVY0dBR1R4QXpTRWlSeXh0aTBHSUVvZy9kUEF6N2tMQjljU29aankwMWI3?=
 =?utf-8?B?anlMRmhwRkhDYlFTTHdpWkFRRUpIZWFqejBPajAxODl4aWt6RFg5U2RFbEs4?=
 =?utf-8?B?QzFMSlpzQ3JJd2pvR3hsOGhoOHNDOFQvQ1lTWXg0cHN3UFhmVEZxdTg3VDE0?=
 =?utf-8?B?NmdXM2luc0FiQ2JXYm04akhwUjJJZ2w3THhXdis3RVBSQ2tGWDRwamlVOThv?=
 =?utf-8?B?STNMVUg4TWtEeHgweW8xSVNHaDhOYXZIQmlzQ1JjcEozUW90Z2xTSFJNQW5o?=
 =?utf-8?B?STBzbGZhc1VSYnkzTkNmaEp2WjZuUy9BcjlCNU5XcXd3OWdxZlE1VDlXNFVO?=
 =?utf-8?B?Mk1raklRTHZCZHB5UkI4bENwODdRQjNhMGNkTzZCbmRuRUZZenREbkhNWFVS?=
 =?utf-8?B?OWUvNEhlbzl6QW1QbmR4UGUrM0NNYmJoQ3k1QllkU3ZBQTlNNCs4OCsvZ2NZ?=
 =?utf-8?B?NHYxQVFoVFFuRnAyazNaNlpwSmI0SUNZQ0hGQlBNVHRXUGNZVS9qeTRFU3Za?=
 =?utf-8?B?eGhyUmZpTEVWbFY5TjJYVHR0OVhXT2wxaUVCR3VIeWN2bFdZZDlEVGVDbEFt?=
 =?utf-8?B?dlhISzBaeXNnTmZrMFJmREtxNFFPdy9MVzl4Q2VpTk1FQVdFU2R4bWRZbURr?=
 =?utf-8?B?Q1ZFYUNveXc4OWtSdnQvSk1uWWVySGsvdjc3ODgxaXJrRHJpcHZkRjJjZFFt?=
 =?utf-8?B?TEFJTGZwVDNlVGVwMVc2SG1Xa0VYMVhtOFRQNllXM3dhL3ErV1JUMWhGRFhS?=
 =?utf-8?B?UnJnWk5oTUhCVmxkMUxtbExBOGJIbWQ0eDBGcUpUMTdoN216dGVDWFV4ajBK?=
 =?utf-8?B?QndPcVhCclBzbmRiSEQvWkVPSnVNOXU5aTQyRTRlTllOcDBvVk4rdDZFcmlj?=
 =?utf-8?B?eXdtVUgxdC9SMjl6V2pyNFY1cUdmaERzZGhsQ0NKbzJxL2R6OW90L3pReHN2?=
 =?utf-8?B?N25pWFR0VjFBeHg5UjdKQ0VhSTdZRmJMTVJUMnVQblJtcUpjbUNDZ2lQKzc3?=
 =?utf-8?B?VjVSdWdoNE9vSGpPZWNlUE1ndjlNZmJTNTdaVVM5TUZhakRBd1EyTGwzM0Qr?=
 =?utf-8?B?V2pYSW8zTHE0VVFnNVVtZXlMMVRFN3lrTStZTXl5ZEFHSlNXZVJZRjR3RXlw?=
 =?utf-8?B?RTBnMU8ySWlQQ1ZYVU1CcVBscXZyc2FrVnJtLzlDMjhPMFNaQkdqeXEyZEY0?=
 =?utf-8?B?dlpFcEVnTXhtRUdIZzFQOE0raXVOb2UvT2YxNWpnakcvM1EycDZFSWc3SXND?=
 =?utf-8?B?eGVraExCZnZsaUtyREVoME1jVkZFbGtsTjJkUTVTdTVPOUY2RnpCZWx1TENS?=
 =?utf-8?B?d2F0QWE4cWZrV1NLb1NmNHdRbWlUdmJaTXBpMFJSUWFweDQrUXBMbVF5VFpz?=
 =?utf-8?B?ZWNzVlFJVGRNR2JqRnlieVpQOWpOZzVSUExLYmFTcFNFYXRBN0RodHJmTFFk?=
 =?utf-8?B?bUwxSEtJMnMvaDVlYjBqNHVCciszOWZ6WWp6L05Fa0lKV1VaUE1ZSTh1VUdG?=
 =?utf-8?B?SjBMTDI0OUhJV0lQcGkrMDdYLzdncVRaWVUvd2U5SjRQbkZrZ0dpR0FtZkRo?=
 =?utf-8?B?V3FUc0FSSnFmejc0VHRwTUFpU0JrSzczbmQzaG8zTFBWbEErQ0ozbnljM3JE?=
 =?utf-8?Q?TbXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhrdHd3WURtYlRJSUV3YzFCbWVkQWxoU3R4MnpNMVplS1N0c01YQjh1Qlh2?=
 =?utf-8?B?dnh5TFlLQU1vT2NWNGRkdVY1YWtjNDlJMnlGTzgzb1ljbHVmVzZCQzR3eGkr?=
 =?utf-8?B?Tzd6WmxQRzdIcUxkOXVOVUNQeWdIQm9xZmw4K3dnSlV3YktxM1BwZUJOakJj?=
 =?utf-8?B?SGVHNnIzNStHdWQ2NHpTUXdBRXZKRnhwNWI2TWtFNDdHVXRLOEhoSWRjQVpL?=
 =?utf-8?B?OTBlS3ZGT1hSaGdZZ2Q3V290dFNnbGlEM2RmUGVrWVJXajBXSEdNNFRWUGMv?=
 =?utf-8?B?WWlqZkovbEtLN0piK084eFhoa3I2VVRDdDZWNEtCRFAya2hMQW94RlZ5d1ZX?=
 =?utf-8?B?c0hUaFBlbXp4T1ZTUis4czRhTFpQQkVhQVVHVnRrbC95ZlFxMHVqck5vRzZP?=
 =?utf-8?B?ZkpoNFBwZklhTVAvN3lsNVBkRmJYTEF4bFVGR0lXbFR2N25CWW56a2o0THJP?=
 =?utf-8?B?ZENLUFQwQnRYVDRzcGZMamlYSVJkVWVQNWU2b0ZtY3JNYnhZSU9WWHFkdVdB?=
 =?utf-8?B?bDc1Z0t1ZGlMU242VUdRWVBoM3pjWkx1ZWFrcWRnQWd4OTdjbHRlSDNUZ2lw?=
 =?utf-8?B?OFZHZnZiMmlpbHpaT2JiWVo3d2lFK0Q5TnVUMWZ5SmJ2RWJLenN1V3BIWkh6?=
 =?utf-8?B?R0lTVXhSMkp6R0Q4WnprMHBJRCtpUktQOUtSUVJnUFpLNUNtRlM0aW5leWR4?=
 =?utf-8?B?bXZPZTI2eUdwM1hKckp1bXpUZWc3NFpoSUVyeTVkanZFQkxZZVJCUGMyTHJ4?=
 =?utf-8?B?MVU2RCtIV0Zzdk5XMzhFRGJ0bXU4emJqOGRRbFh5V2kwV2NJRStWK0FsZEdi?=
 =?utf-8?B?Rk53andrNGZOK1FiN1RXaWR5TVR6S1lJbm1BOGovT2NrWXVLbHB2SnY5VU5k?=
 =?utf-8?B?VEU4b1BFUG1JU3RkcU9nQXRNTFVvU0Fva05LZS9xZitwYit4V3lBY3NNK3ox?=
 =?utf-8?B?alk2SU8wbzhXKzVyRDB4djVObngwOHgrTkFxdGhYbnkzS092L2lNTmdXNXNr?=
 =?utf-8?B?d1o2YldRZWR1MTY0VFY4b2VnSVVDSmp6VXVpOElOQ3BkSmtMZXRsNTlGMXdT?=
 =?utf-8?B?cnBNN0I3UFZqM1I1K2U4R205RmYwWHJDdm85amJmTHdzRk9uR1ZHSDFqdHUv?=
 =?utf-8?B?aFJZVUY0RldtWFBKem1YWHloVkR5VE1kU3FzdmtUVmZVdE1zMjFMVGFaUkpt?=
 =?utf-8?B?Y2ZvOVJPVlpnSTI5LzNHWS9jN3R1Umc2QWRrZ0Y1cGwrb1AzK3I5QVEvVHhu?=
 =?utf-8?B?L1lRMURNeFhMRmwvdXpCK25RTU9PNzF2aHYyYXArVmcvc3Exdk5yWkIvTytl?=
 =?utf-8?B?YnJOb0k0bHJuMVE5N2Fpdkw3dVpXa3NiQ2ExZXRQLzdiSDF4aUFsQ0pBckZC?=
 =?utf-8?B?QThndUJsWWVCQ25OSEk1T00yRUN1RlV1QW5Ob1BVeTJ4V2Y1WU5HcnU3dTBF?=
 =?utf-8?B?cU15M0xlUE1jTVVhblYzQy9RWE9DUjFKKzZPeXN0cTcwK2p3clorQzJZS1NW?=
 =?utf-8?B?TDZ3ZXR4eDJUOWVzaDNvUGU0c1grNWg1UDY3M2J5UWFPS0RlUTlyenUrakV0?=
 =?utf-8?B?YVBGU3dMbVBDU1BESUJBUHR4Zk81SjVuNEtBdFNWV0hIdHplS2s4Uis1QVl6?=
 =?utf-8?B?YlE5b1ErWmdHUWRlRzRjSWo4U1JXVnN5UFllMm1JeDZjMnRDWDJLMzRuK3lZ?=
 =?utf-8?B?RXZPZXNCeGtmdUU5UVIybWZLNTRJdW51S2IwU1RqaFAwd0Y0dkdaQ0lnWVpp?=
 =?utf-8?B?TER2cG9TNXo5bENEd2d3ZjZyTlNiV0NoUThHdW85Qk50QStMWCtmRzloanN6?=
 =?utf-8?B?M2tWUGQ2bzFEMkZOd0tqTjQycUdabzFXMHIvOVZiVEJEU2tXc015bWdzUkpO?=
 =?utf-8?B?ekNpSnFHM2FtSUZ1NWFPb0FpYzV2eHBJUjk4MmxKTG4xWGxpemF2UUlDV1Ro?=
 =?utf-8?B?cittSUF0eHpWR054MHU5OERxcksrRWdSbnhEUnE1K0NNeHMvQXZJbVA5NldW?=
 =?utf-8?B?cFAvb28rQitlbUNiNmhTcy9FcjZnYU9lMDNtR0RkUG9XakhOUkFIL1lZS29M?=
 =?utf-8?B?em9zcGNJTG52M2xYS2JzbkxlTk5jUlc3cnB6TmZJMEF5cVVIVlZMaTUwa3Rr?=
 =?utf-8?B?WnFTSDQvclJpa0k1bG8wZG5SRXRtV0tWY0w4RlkvcUxzL0NoSjRrdWdJbFBE?=
 =?utf-8?B?MWs2LzloU2NtaGlLaTNBRDV4N3h1WHNhSXNZaDlWcVN4WG81eXVtelE2OSs2?=
 =?utf-8?B?VGxKdk9UbHhDQTFQQU44Y3VHM0szQVNMSm9IeUxmUWdYLzNtRE5SME9MSTV4?=
 =?utf-8?Q?zZd/1uRZEsU58v5o8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023dfde3-20b3-420b-7fa6-08de574333be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:12:07.6939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7YDS+kW/OFZw9QSPv/cPBHX3fpAGaS1wF5w4ImrzFkH14QYBfYmhN6WQNtq/XWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

On 1/18/26 13:57, Timur Kristóf wrote:
> When a function holds a lock and we return without unlocking it,
> it deadlocks the kernel. We should always unlock before returning.
> 
> This commit fixes suspend/resume on SI.
> Tested on two Tahiti GPUs: FirePro W9000 and R9 280X.
> 
> Fixes: bc2dea30038a ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 0e67fa4338ff..4fa24be1bf45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -769,7 +769,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
>  	unsigned int ndw;
> -	int r, cnt = 0;
> +	int r = 0, cnt = 0;

Please don't initialize return values in the declaration, that is usually considered bad coding style.

>  	uint32_t seq;
>  
>  	/*
> @@ -782,7 +782,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
>  
>  		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> -			return 0;
> +			goto error_unlock_reset;

Ah, yes good catch!

With the change to r initialization dropped: Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  
>  		if (adev->gmc.flush_tlb_needs_extra_type_2)
>  			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> @@ -797,7 +797,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>  		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>  							 flush_type, all_hub,
>  							 inst);
> -		r = 0;
>  	} else {
>  		/* 2 dwords flush + 8 dwords fence */
>  		ndw = kiq->pmf->invalidate_tlbs_size + 8;

