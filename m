Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D81CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 17:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC52D10E104;
	Thu, 14 Aug 2025 17:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKalWNiT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C952010E104
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 17:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAqT49hRhHdUdUxXfeQ/dM7PWCoA3HAozk7DnsgE87plL2dfk5jNl9THFphCVtFJpjKDb6W3K5TIobBfbyy2OLquknVzDGTrJAyyuf6gnjgctn3ST2ON8+DEJy4ppZh4mUrt6KT4GWd947NwWSw6VAIfrMdXb1k0TMnJGjlBdlW0srMvQty2QgcD5NCeVYbvluScJlb1Xb3CVPNvbmU5ouPY8REobSa1+lEoNVipneqgKDzCz9d3UpgUzHwvnaMemvQxLhvTZk20+y3v8CE2TCuiTG+CJaIbZrUHCb3kLMfrck1QoEHxI5kVytpfdkz6DAdX+wLH7Z2G0mfWkGHVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20v/zVFz9oN0EhZw/En7wE4tw1OP3Yt+uwRi7KU09Qc=;
 b=gcTdIQtERAslGv5SmLJwHiHc+NqQGwlyo4IMyVWt//Ku+r9wPvxXOK5hVPtlZuUe+6lvZbhu9oJeikV7Ssqx0ov008smsJEf5Gvu1wDFpWvTCEqMyr/HM7v52Er2PPEjNmeRC6MViyvX/Z9Mfxo+g/vVERgVA8P5iH+9A9sh4VEkFKGtsN6z+LJw+eEc0ER0nFCBDU3pu4idK32YVdY9D+61POWkDMJHuoRiJxQH6nj2Q/EKsoMUjc5z2P/gpblokCihLY6/oeVZNcNteWrmpaax69T6NCydercRe7FXeTHn6B/lU+D1M62DLvFirlTNbvNvw1p2nmf/iJirDhCE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20v/zVFz9oN0EhZw/En7wE4tw1OP3Yt+uwRi7KU09Qc=;
 b=fKalWNiTF/nntomav1DE7uaEIkAdigw8MdONOQEK2pQDjBHpva7QTdCODp3DIOFUnTn2uu+Rw/SG3x7TLCPVBLEj0RSdTn4C2Za9ooxgfL1JPX8mBmzfe18V5c+p0jTQKtG/vOE8nDNCrts1inaxcwuxagwvLDCuYcjInDw0CWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 17:44:29 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 17:44:29 +0000
Message-ID: <535641b0-6fb2-4541-ae89-c8f278869eb4@amd.com>
Date: Thu, 14 Aug 2025 13:44:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <David.Wu3@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
 <DS0PR12MB780432BEB1D74FE5685273F59735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <6ecd4ff4-d427-6c62-0c9f-21b7c601de79@amd.com>
 <DS0PR12MB780439434F2D1BD589ABC9359735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <3e0fe19f-68af-5802-0a33-bb5b63132f9e@amd.com>
 <DS0PR12MB78044AEE4BC81BD6338492DB9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <DS0PR12MB78044AEE4BC81BD6338492DB9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::12) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6306a719-93fb-48d7-ec72-08dddb5a3810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUdoSXpRVC91Tm9VU3lXOVdjTGdlUEVJV2Z1dkpVd1gvWCtWcERvZVFiY2dm?=
 =?utf-8?B?VlRsc1pJZGN0THJiOHlsNkR3TSsraHArZlMzRXF2VFJBOHdzRlczTGpudmFR?=
 =?utf-8?B?M1lUemwwTlkzRlEvRHowbDBJaUJha2w2bFRURnM4elE2aFB5VVRYRUlKYUs0?=
 =?utf-8?B?VjU0a2l2QldhWnBqa09TNVRhM2dkclFwSmtva1dUMlFoRXpsZGhUNEFFMnRw?=
 =?utf-8?B?RDZhZjBKR0FyTU9oWlA1SEtLeEZnUkxNanBLZDNQYzZ6S2NzZHNLZTZtOUJj?=
 =?utf-8?B?RVBQa1hRZElVUHF6em0xdDI2c2tpUUlkY3plcG54MVJIQy9hTzdwRDlTajMx?=
 =?utf-8?B?Y3JvQU5JRktQeFNzUlViQ0pnZ3Q2VUlpSEJWNFNJMFp3dlBYNWR5ZUl0dHBS?=
 =?utf-8?B?WXhmSzhONzAyTlZPN2crcjdZZ01yWEx2d1pXeFF5S1VZM3Q4T0pjZ2RqYXdM?=
 =?utf-8?B?NnYzT01PWThCRldoOFg4SnZKUVNkeDFoVVcwYWliWlpVV3gyaDhwSmdnd2sw?=
 =?utf-8?B?ZjVtM2N1cVh6eU04V05lSmJkMm15Mks3OUo4TGhtbUJGT2xrRUlmcTFCVm5N?=
 =?utf-8?B?c1EvSUVUdnhpeHF2Rm1oQXMxeUdLWWZvRmIvRjNLdS9IczVIOCsxWVQ1SkdK?=
 =?utf-8?B?SnBnc3dBQ0RQU0MxbjNRT3doS3lOVkRmc0RZOVRqSFdGM0JtOHVpRFFLeG01?=
 =?utf-8?B?cTBWL1Zna2RwRHlrdkdqM2M0L3ZlN1QrYTVXbXdyK3gxcFZGUEFYUDAwaDJF?=
 =?utf-8?B?aWNjQ29sd3owTkNXNFhkREJISjYwTTFmZjE5YTZUUzA5T0VLNDd5R0h3VlJN?=
 =?utf-8?B?ZFdINkROKzR1T2F4aWNHcUZJWkRkb0hZWCtGN2l2YjlNOWF6ZGVJakxmQndo?=
 =?utf-8?B?T21rRDRIdDRZemtUNUwwNmxianhTWXhRLzJmL3Z1Q3phMkd4TTY3MGsvS0RT?=
 =?utf-8?B?NW9veFRJK0cvWXNxUGVOTXM3M1EwdkF1TVlnMHFVRDNxTUd4bU1ydFNjM0tH?=
 =?utf-8?B?d2FKT1JEUFNyK3hXaXlYdFhRVDN2cjh1aG91blBpeVZxc3VlZ2xLMFBQQXBj?=
 =?utf-8?B?Znc3YWNkK2d5ejFhR2dQR3ZuQWNQbDZrbW5tWEl1ZGZOSFhPOTl2R0hWODB5?=
 =?utf-8?B?bGpFZEVOeHlNVm0reWV6bkEwVFVjOU9HOEhaTDZpT0pyY0RPeUphV0pXSGhO?=
 =?utf-8?B?dFZub1MrUHdSRnVMYkJ6N1hhY083L3htQ2QvRjQzRk1jZm96K1FESVIrZzRN?=
 =?utf-8?B?THBQTnFubDdSVWFDcHhUSXA4RnlWR0FiKzgrLzVYR1huYWZ4c0kzTVg0TUwx?=
 =?utf-8?B?V2ljdzFscUFmTHQwMHkzSnp5SXluMW5XMGQ2R1h3RzdvREZLcm9ob1doVWlj?=
 =?utf-8?B?cDIxajRTdWE0V3AxWkxmdEFCdWFBY3Y2am9WN2VKYURwdzNsajZvMk41c0JG?=
 =?utf-8?B?UHFTWFdLd2ltQWwybjlxV3Y5Yi84R0UvWjFGRmdaQUpxL2VndTBWeCtKS1BN?=
 =?utf-8?B?SUFOczFqZ2I5bHFKUlp4QmVZSzVJOGoxSWNPZEJkb0xKZTJqclVPNXFLR2tz?=
 =?utf-8?B?NUJBU0l5Vndjb0ZETTVjR05WZGxnTHFQdkI4Sk13MFROUFYyQzA3ME5PanhC?=
 =?utf-8?B?dVhXN3M0TVArdldKTkRVdy8xMnA5VE52ZHBiSWxzZCtDM1J0Wk1OM25BZkRE?=
 =?utf-8?B?ZUFIdFJuTzJEOUViY2FlZitWQm8vQUdtSUQyTlM4SXRQRjROc3pudEExbGpB?=
 =?utf-8?B?VVl1TTRYL3VVbWRLR3YxcWVpOXA2ZXhFck1wU291UnhTR3RPeGtLWldLM2RY?=
 =?utf-8?B?TmVuQzRoZkpNbjVUVElZbStuOW4wRklPMWkwYnF3YnpuTWwyNGpZeWVQcVBo?=
 =?utf-8?B?Y1hPS0IySDRmSmZESU9OS2JKRklRSlVkV3NSU2hUaEFuT0l0blVOVDJ3SnlI?=
 =?utf-8?Q?f1pllLSx3hQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJDQUlTb0orWVJzNXpyMUNuUzVxbU9DU2pGalRGQzE2dFE3b2FsZnhEOHQ0?=
 =?utf-8?B?Vi9ZTTdpNUJvdE5BWEF0a21KeDRzRld6TmdnV0JUU1FIaFpZNE00em1OQUJB?=
 =?utf-8?B?STFzb05VUzI1Snp2M1B6ZjZwOWhBRUc0dndzSGFZTFMvTXRkOVFxb1hBUzgx?=
 =?utf-8?B?VEphOE03eDErbldmODQwSmhCbFJRU1pROEYxdUVFUSt5TlpCWWc4R2l5amhq?=
 =?utf-8?B?QTgxRm53c2E1S2ZGM0piZitMb3RkeGl4M1RranhPbVJaVk5Jb1lVUnBkM1N2?=
 =?utf-8?B?UFhwYWxGNVZ3aCttK1EwZllyUncwS2NLK1MrT3NNR2xvZk4yOEp1R0FmZ2dI?=
 =?utf-8?B?bUVCeXdSbzBOMDk0TFhWUDdzMDBycklrLzErczlJMmlsSklDME52dFozMFJL?=
 =?utf-8?B?QWYwR3h6S1YxN05rK0F5V0puRklpVHFKZTA3dWNDZkNCY2p2VWU1cHJQbWhp?=
 =?utf-8?B?OGExTTFKemluYXJ5eDl3b0FUV3dBbnJnTTIwMW9iczNKRUlNUCt1RVJDTzAv?=
 =?utf-8?B?Zm9BNCtYZzAxTk5abWkzNVhFS1o1amN4ZC9SUTFrUWhpU3c4K3VSME1GR2U2?=
 =?utf-8?B?eTlEeDJkY0hQb1VScG9GRWFEanNpQTdwVm53cktaRTBCcWxyZ2VIdUFuR1lC?=
 =?utf-8?B?d2Jpa0ljYThDUm95Mm8xMDJqcGpjbjB2ZHVjNHV4UlZkQlRXTzJzK1BXMlpQ?=
 =?utf-8?B?WFdxZjVYdWJFVnZsblZ3SmQ5MXo1WE5TczFIUW83dlI3UW1yajlWaTU5ak0v?=
 =?utf-8?B?aUY4R3oyS1Q2OTNoZ1psS2JDZ1JjNVN3cDd3azZlL0xBVEEyNUkwa3hnQ2F0?=
 =?utf-8?B?OUk3eXZMTm90ajBlM0RnalNYc1JEaG5SaUVVQSt0TnlGNHNVK0w1ZGxwd2tn?=
 =?utf-8?B?dStnZ2JCdVVCb2JzVlN6UFBENCtnbDZzbytyV2NjaTZSWEdjeHR4OFpMZWhG?=
 =?utf-8?B?dTNYY0tFSUJIVDNHQmwrSkd1MnZ3L2x2S0NKcmJsbkEwUVpDS0RNY1NOa0Iv?=
 =?utf-8?B?Q1RCL3NVOEVQS0k1b3M0TUZOL3A4OGRJQktic2VuM2tRM3lzbHpQSXpEekxT?=
 =?utf-8?B?SzZMS3liTEJWOVJSMVg1RzVmSCtKa0dxVEdBYzBNZ3NUajFSZnUyLysrQkZ3?=
 =?utf-8?B?a2U5VGpqWGxDMSs3OWlybnJrWFRFU0NsVkNrZHl0ZEgvSkcxSWRoTU5BS0Fr?=
 =?utf-8?B?MWhNbitrQlVWQnVtN00rOU9Kd2tMVDBSUlkvZmNWVnk4cERMcXdhRFBBWmhJ?=
 =?utf-8?B?ZGdsSWcwbGZqenEwQUsycEs1dER4OHRUaTU1VndXeGRRUlRQemJNbVhQKzcy?=
 =?utf-8?B?YUhwbXlRR2RKODVKYTBkNk1sZ0VIM3VMUFdpZjcxd2tSQXUvOXJmNzE5QkFI?=
 =?utf-8?B?VDgzU2d1QVZGeGJaVVh5d1lwK2cwL3ZiT2R2ZmlCWkJJQnNHNHB5RHI3OVVa?=
 =?utf-8?B?cW1Tc1BXOU9HeXVBUnlYWlU4M2FZTjNiRVhocWxKTkRLZmY4YlNvcCt1TW1X?=
 =?utf-8?B?Rm9ib2pBM1IzUTJLUStqYzlRUi84blo0TWU5M1pJWkZVdVUwMjhWRVZoa2Zv?=
 =?utf-8?B?c2ZoSXVnS0wybDVHUkxDMkpmU0svQWVrTTRMY0g4L3BuNmgzOGx0S3dEQWxB?=
 =?utf-8?B?USt6YmROazJxejlUckRidlRsdENVVUhObVdhaTNmNTY4a3R6S1JtWHhWUTBr?=
 =?utf-8?B?UndWdFBCcXR2aktnZ0dNUXFpRHJCRTNzUW1Rc25LN1JJSmh2a0R4Znh0b21L?=
 =?utf-8?B?YzRCYVBzVHMzWDlLcTVnb21mcW1CemJrNlhMamdVWUcyQWxYWlhTZFhTM210?=
 =?utf-8?B?OGFqZmtWSGpvRTZxUk5sNGZrSFhkMm5jVGlqRG1EMHhZemxVUU1mek5RRnRK?=
 =?utf-8?B?eWFsUkUzWjZQMXFuMFFxSm8vT1dhUUJnV2ZmeVRQTHpmTkFvVWM2OEg0NmdT?=
 =?utf-8?B?bnRXQjV4S0pqcHZhdERhc1ZKRDUwek9VcmFGc1RtNHNRRlFHcXFNMTg4bmRx?=
 =?utf-8?B?anU1M3RYWWVOZlhuK25NdDFneWJPZjVmZEZ6N1hPOGxPaTAzQURtMXo0OHV3?=
 =?utf-8?B?UjlWNjFFcVFkQ1plYnZCT2x0aXBKOWJKUk9WckllcUtJeWZqL1c3QWI2MDUz?=
 =?utf-8?Q?p++lknfY7TsUDVjFheFn6cGav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6306a719-93fb-48d7-ec72-08dddb5a3810
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:44:29.3801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHbfKiQWVxJ7fJ+01HtoSYipNkHBRGCLcIRsIajfSAjrD+mPy7v9IoqHebdPqHJhDWRXeFWTgyDPHR8mSdH3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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

amdgpu_vcn_idle_work_handler():
     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
----------- could it be possible a context switch here to 
amdgpu_vcn_ring_begin_use()?
  if it could then AMD_PG_STATE_GATE will be set by mistake.

David

On 2025-08-14 08:54, Lazar, Lijo wrote:
> [Public]
>
> The request profile can be moved outside the pg_lock in begin_use as in the attached patch. It needs  set power state -> set profile order.
>
> This is the premise -
>
> Let's say there are two threads, begin_use thread and idle_work threads. begin_use and idle_work will need the workprofile mutex to request a profile.
>
> Case 1) Idle thread gets the lock first.
>          a) Idle thread sees vinst power state as PG_UNGATE, no harm done. It exits without requesting power profile change. begin_use thread gets the lock next, it sees profile as active and continues.
>          b) Idle thread sees vinst power state as PG_GATE, it will make workprofile_active to false and exit. Now when begin_use thread gets the mutex next, it's guaranteed to see the workprofile_active as false, hence it will request the profile.
>
> Case 2) begin_use thread gets the lock first.
>          a) Workload profile is active, hence it doesn't do anything and exits. The change made by begin_use thread to vinst power state (state = on) will now be visible to idle thread which gets the lock next. It will do nothing and exit.
>          b) Workload profile is inactive, hence it requests a profile change. Again, the change made by begin_use thread to vinst power state will now be visible to idle thread which gets the lock next. It will do nothing and exit.
>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Sent: Thursday, August 14, 2025 6:18 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
>
>
> On 8/14/2025 5:33 PM, Lazar, Lijo wrote:
>> [Public]
>>
>> There is no need for nested lock. It only needs to follow the order
>>           set instance power_state
>>           set profile (this takes a global lock and hence instance power state will be visible to whichever thread that gets the work profile lock).
>>
>> You are seeing nested lock just because I added the code just after power state setting.
> Pasting your code from the file for ref :
>
> @@ -464,32 +509,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> *ring)
>
> -pg_lock:
>
>        mutex_lock(&vcn_inst->vcn_pg_lock);
>        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>
> +   amdgpu_vcn_get_profile(adev);
>
> vcn_pg_lock isn't  released here yet right ? And in-case you intend to only order the locks, then still there is an un-necessary OFF followed by ON, but yes that is acceptable,
>
> May be you want to move that vcn_pg_lock after amdgpu_vcn_get_profile to protect concurrent dpg_state access in begin_use.
>
> The concern is, this patch access power_state that is protected by some other mutex lock hoping it reflects right values also when holding powerprofile_lock.
>
> Or
>
> Have shared a patch with global workload_profile_mutex that simplifies this handling, and renamed pg_lock -> dpg_lock  and used
>
> that only for dpg_state changes per instance.
>
> Regards,
>
> Sathish
>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> Sent: Thursday, August 14, 2025 5:23 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>
>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> (v3)
>>
>>
>> On 8/14/2025 3:16 PM, Lazar, Lijo wrote:
>>> [Public]
>>>
>>> I see your point now. Attached should work, I guess. Is the concern more about having to take the lock for every begin?
>> This is closer,  but the thing is, IMO we shouldn't have to use 2 locks and go into nested locking, we can do with just one global lock.
>>
>> Power_state of each instance, and global workload_profile_active are
>> inter-related, they need to be guarded together,
>>
>> nested could work , but why nested if single lock is enough ? nested complicates it.
>>
>> Regards,
>>
>> Sathish
>>
>>> Thanks,
>>> Lijo
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Lazar, Lijo
>>> Sent: Thursday, August 14, 2025 2:55 PM
>>> To: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>;
>>> Alex Deucher <alexdeucher@gmail.com>
>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>>> (v3)
>>>
>>> [Public]
>>>
>>> That is not required I think. The power profile is set by an instance *after* setting itself to power on. Also, it's switched back after changing its power state to off.  If idle worker is run by another instance, it won't be seeing the inst0 as power gated and won't change power profile.
>>>
>>> Thanks,
>>> Lijo
>>> -----Original Message-----
>>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>>> Sent: Thursday, August 14, 2025 2:41 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>>> <alexdeucher@gmail.com>
>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>>> (v3)
>>>
>>> Hi Lijo,
>>>
>>> On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
>>>> [Public]
>>>>
>>>> We already have a per instance power state that can be tracked. What about something like attached?
>>> This also has concurrent access of the power state ,
>>> vcn.inst[i].cur_state is not protected by workload_profile_mutex
>>>
>>> every where, it can still change while you are holding workload_profile_mutex and checking it.
>>>
>>> Regards,
>>>
>>> Sathish
>>>
>>>> Thanks,
>>>> Lijo
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Sundararaju, Sathishkumar
>>>> Sent: Thursday, August 14, 2025 4:43 AM
>>>> To: Alex Deucher <alexdeucher@gmail.com>
>>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race
>>>> condition
>>>> (v3)
>>>>
>>>>
>>>> On 8/14/2025 3:38 AM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 5:1 PM Sundararaju, Sathishkumar
>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>>>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>>>> Hi Alex, Hi David,
>>>>>>>>>>
>>>>>>>>>> I see David's concern but his suggestion yet wont solve the
>>>>>>>>>> problem, neither the current form , reason :-
>>>>>>>>>>
>>>>>>>>>> The emitted fence count and total submission count are fast
>>>>>>>>>> transients which frequently become 0 in between video decodes
>>>>>>>>>> (between jobs) even with the atomics and locks there can be a
>>>>>>>>>> switch of video power profile, in the current form of patch
>>>>>>>>>> that window is minimized, but still can happen if stress
>>>>>>>>>> tested. But power state of any instance becoming zero
>>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>>>> Consider this situation, inst0 and inst1 actively decoding,
>>>>>>>> inst0 decode completes, delayed idle work starts.
>>>>>>>> inst0 idle handler can read 0 total fences and 0 total
>>>>>>>> submission count, even if inst1 is actively decoding, that's between the jobs,
>>>>>>>>         - as begin_use increaments vcn.total_submission_cnt and
>>>>>>>> end_use decreaments vcn.total_submission_cnt that can be 0.
>>>>>>>>         - if outstanding fences are cleared and no new emitted
>>>>>>>> fence, between jobs , can be 0.
>>>>>>>>         - both of the above conditions do not mean video decode
>>>>>>>> is complete on inst1, it is actively decoding.
>>>>>>> How can there be active decoding without an outstanding fence?
>>>>>>> In that case, total_fences (fences from both instances) would be non-0.
>>>>>> I mean on inst1 the job scheduled is already complete, so 0
>>>>>> outstanding fences, newer job is yet to be scheduled
>>>>>>
>>>>>> and commited to ring (inst1) , this doesn't mean decode has
>>>>>> stopped on
>>>>>> inst1 right (I am saying if timing of inst0 idle work coincides
>>>>>> with this),
>>>>>>
>>>>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
>>>>>> correct my understanding here.
>>>>> The flow looks like:
>>>>>
>>>>> begin_use(inst)
>>>>> emit_fence(inst)
>>>>> end_use(inst)
>>>>>
>>>>> ...later
>>>>> fence signals
>>>>> ...later
>>>>> work handler
>>>>>
>>>>> In begin_use we increment the global and per instance submission.
>>>>> This protects the power gating and profile until end_use.  In end
>>>>> use we decrement the submissions because we don't need to protect
>>>>> anything any more as we have the fence that was submitted via the
>>>>> ring.  That fence won't signal until the job is complete.
>>>> Is a next begin_use always guaranteed to be run before current job fence signals ?
>>>>
>>>> if not then both total submission and total fence are zero , example
>>>> delayed job/packet submissions
>>>>
>>>> from user space, or next job schedule happens after current job fence signals.
>>>>
>>>> if this is never possible then (v3) is perfect.
>>>>
>>>> Regards,
>>>>
>>>> Sathish
>>>>
>>>>> For power gating, we
>>>>> only care about the submission count and fences for that instance,
>>>>> for the profile, we care about submission count and fences all instances.
>>>>> Once the fences have signalled, the outstanding fences will be 0
>>>>> and there won't be any active work.
>>>>>
>>>>> Alex
>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Sathish
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> Whereas if instances are powered off we are sure idle time is
>>>>>>>> past and it is powered off, no possible way of active video
>>>>>>>> decode, when all instances are off we can safely assume no
>>>>>>>> active decode and global lock protects it against new begin_use on any instance.
>>>>>>>> But the only distant concern is global common locks w.r.t perf,
>>>>>>>> but we are already having a global workprofile mutex , so there
>>>>>>>> shouldn't be any drop in perf, with just one single global lock
>>>>>>>> for all instances.
>>>>>>>>
>>>>>>>> Just sending out a patch with this fix, will leave it to you to
>>>>>>>> decide the right method. If you think outstanding total fences
>>>>>>>> can never be 0 during decode, then your previous version (v3)
>>>>>>>> itself is good, there is no real benefit of splitting the handlers as such.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Sathish
>>>>>>>>> If it is possible, maybe it would be easier to just split the
>>>>>>>>> profile and powergating into separate handlers.  The profile
>>>>>>>>> one would be global and the powergating one would be per instance.
>>>>>>>>> See the attached patches.
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>>> can be a sure shot indication of break in a video decode, the
>>>>>>>>>> mistake in my patch was using per instance mutex, I should
>>>>>>>>>> have used a common global mutex, then that covers the situation David is trying to bring out.
>>>>>>>>>>
>>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
>>>>>>>>>> flags to track power state could help us totally avoid this situation.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>>
>>>>>>>>>> Sathish
>>>>>>>>>>
>>>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>>>
>>>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer
>>>>>>>>>>>>> in case someone adds more before the lock and not reviewed
>>>>>>>>>>>>> thoroughly)
>>>>>>>>>>>>>           - up to you to decide.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> David
>>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>>>>> If there are multiple instances of the VCN running, we may
>>>>>>>>>>>>>> end up switching the video profile while another instance
>>>>>>>>>>>>>> is active because we only take into account the current
>>>>>>>>>>>>>> instance's submissions.  Look at all outstanding fences
>>>>>>>>>>>>>> for the video profile.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload
>>>>>>>>>>>>>> profile
>>>>>>>>>>>>>> handling")
>>>>>>>>>>>>>> Reviewed-by: Sathishkumar S
>>>>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>           drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>>>>           drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>>>>           2 files changed, 21 insertions(+), 20
>>>>>>>>>>>>>> deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>>>               struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>>>>                       container_of(work, struct
>>>>>>>>>>>>>> amdgpu_vcn_inst, idle_work.work);
>>>>>>>>>>>>>>               struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>>>>               int r = 0;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 <<
>>>>>>>>>>>>>> + vcn_inst->inst))
>>>>>>>>>>>>>>                       return;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =
>>>>>>>>>>>>>> + &adev->vcn.inst[i];
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>>>>> +     }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>               /* Only set DPG pause for VCN3 or below, VCN4
>>>>>>>>>>>>>> and above will be handled by FW */
>>>>>>>>>>>>>>               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>>>>>                       struct dpg_pause_state new_state;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>                       if (fence[i] || @@ -436,18 +442,18 @@
>>>>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct
>>>>>>>>>>>>>> work_struct
>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>                       else
>>>>>>>>>>>>>>                               new_state.fw_based =
>>>>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst,
>>>>>>>>>>>>>> + &new_state);
>>>>>>>>>>>>>>               }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>>>>                       mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>>                       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>>>>                       mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>>>>> !total_fences &&
>>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>>>>                               r =
>>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, false);
>>>>>>>>>>>>>>                               if (r) @@ -467,16 +473,10 @@
>>>>>>>>>>>>>> void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>>>               int r = 0;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>               atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>>>>> -      */
>>>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>> move to here:
>>>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>>>>> David
>>>>>>>>>>>> Alex
>>>>>>>>>>>>
>>>>>>>>>>>>> David
>>>>>>>>>>>>>>               if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>>                       r =
>>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, @@ -487,7 +487,6 @@ void
>>>>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>>>               }
>>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>>>>               mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>>               vcn_inst->set_pg_state(vcn_inst,
>>>>>>>>>>>>>> AMD_PG_STATE_UNGATE);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
>>>>>>>>>>>>>> amdgpu_ring
>>>>>>>>>>>>>> *ring)
>>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submiss
>>>>>>>>>>>>>> i
>>>>>>>>>>>>>> o
>>>>>>>>>>>>>> n
>>>>>>>>>>>>>> _cnt);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submissio
>>>>>>>>>>>>>> n
>>>>>>>>>>>>>> _
>>>>>>>>>>>>>> c
>>>>>>>>>>>>>> nt);
>>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>>>>>                                     VCN_IDLE_TIMEOUT); diff
>>>>>>>>>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>               uint16_t inst_mask;
>>>>>>>>>>>>>>               uint8_t num_inst_per_aid;
>>>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>               /* IP reg dump */
>>>>>>>>>>>>>>               uint32_t                *ip_dump;
