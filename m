Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862B5C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 14:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C1A10E93A;
	Fri,  8 Aug 2025 14:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BNh537RA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCE010E93A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 14:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km1Yr6SHDg983OjFTBBlG68wP7fDxEyrGh1AxUUqmXZu14WYbmaPpBfFktZ7o7K7OEg1FRbsdN9b2jq/f2eMjXolIwUKMNWRGqgPx3FeQ2tJHkcA49SOKaUz1b+K+7dDX+BeVZiC/mjc90Ny/dJ3y++RJ/qhmn+cGVRoCtNM7m88kdBl0ktbxqaYhxKezRtVa+03w29eaJKcsNdHE1+4TqsIAqspt/hG1cpiRc1bKKgjmpXRocgf4UPsuV3Oy1+Uva5cEQkJc5F98Q6Pbs4HWdP8cVag5ROtPNPJnJgQJmeOemZ1BLa0WRIcVtk4kmtYa3rl+PtO6DCbLNouuqT+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXw6V5ohGabQpZCdHWpVoLDfj+kA9kuwMdRIeTiT8SA=;
 b=tXiEfPTC7KA+aYB7i8ADlVsZg5CgO6LgPQZGxU/JnwIzBzNunePHh/4VYmoTPMW816aKSKef65oDrUWZ2C4K7AULew6Tm925OmQ5cR+VnaEr1Jo23+z2pt4ia66ZUiiKnC/BkqPdXdoBwWiDDKPEm/EDYzF8M3PmE3ahuOToprY+fVU83D5831CC+fuOD7s+8AZvLi0uL+Ren/odaFLOo2FLs1vjyqZZoyKDLa/b7i0s5AVHQyiS8LmkYnA7lqWbBzhBQdbH/W5fNELDssIr3s6zR3iK72SoxxZRntaEpFerTrLExTSNL5uVXRuPbGgg2SHYVyjP2btHXTF5hAH+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXw6V5ohGabQpZCdHWpVoLDfj+kA9kuwMdRIeTiT8SA=;
 b=BNh537RA0UQzwJ2P/8rUcx5H1DP8V2ihDLTNWPHO6oHDTVoZHl3ulVxcLfvF0JWN57ZHx/iACxkW9/Fg9ctmUtR4zcWJtzu7kjdheHMBQj2U/ETyj8vEKq7+B66kPmNvk52oJ2IMJkgZrylXo3nTN7MllswOtPO3V2lU2jt8/9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Fri, 8 Aug
 2025 14:03:03 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 14:03:03 +0000
Message-ID: <b06f9e54-c99e-4c4c-b310-ad043daa50ec@amd.com>
Date: Fri, 8 Aug 2025 10:03:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <Daniel.Wheeler@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-14-timur.kristof@gmail.com>
 <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
 <e68d8be2-4687-4a51-a2ac-1ecc73cef355@amd.com>
 <24b4249761d7edb8df8551350475fd6dce274d93.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <24b4249761d7edb8df8551350475fd6dce274d93.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca31e67-714d-4da9-0625-08ddd6844aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmpNL2ZYemVpdjAyYThlY1VSWFdMcnBRTjlDckVCYkxyZGdwTE1xZ3BCLzJK?=
 =?utf-8?B?T3ZGeDVnT0Fha2tCMDV3d0w3V21zb1c5OS9NdTg4WWdIakRML05lSTc4RTJH?=
 =?utf-8?B?elU1RkZBcjhIY29XYjRNY3dYdzdra2dGY0hHc2o0K2FFdU9wdHJKOG02WC8x?=
 =?utf-8?B?RDIvbjNNRHhJeEZaN1daZ2czbmk4UG95TVpOam9KZlNlYWFDRjl0S0NXR1pU?=
 =?utf-8?B?YlR1UVllajIweE1xNkNqR0ppb25SZVVRTTlUOFZ0MlZhbEdMS3cwRkFPSHQ0?=
 =?utf-8?B?eFhwclNOa21RbVFPYk96TE1lakY2WlgwQ0Irelc2RDBZcURYclVCUUw1UE1X?=
 =?utf-8?B?S0llVWxKc1NnSzMzSGkyZHV3MEk4SWp4QWllMVdENWE1RGplMW45bUZ1R1hl?=
 =?utf-8?B?VFpFNzZBSG5zVTZacHNVTDJYNHBiZERRdk1vYkIwNHRhOE9WQ2c5SGVWUTBY?=
 =?utf-8?B?S2cvS1pFWEJpVDA4aU5wN0VrQll5SHJRbit0dmpPTDNGb0ZZUGVoMGJtQWY3?=
 =?utf-8?B?bkFSVlQzUC8yNnlBTXdXUjJndDJUZkdseWdXajVEY1c3VTAwRGU5S2sxV2VF?=
 =?utf-8?B?NGxVNVYyS2FJUzVGeDJ3dDR2WUMzUDdSS0wwYmhFVGxWcEZvbmFMbVlpWmFs?=
 =?utf-8?B?M0x3NnVpTzduaW01ay9MY3ozdGgzQWhwMkFuTENmL3QyOFJ6VEU4dDdYNDBx?=
 =?utf-8?B?QzV1WXEwUnNsWE8wRXR2dE93TUE2NzJDallSKy9hNUl0NWUvQUY0bXNYUW9N?=
 =?utf-8?B?aW1PWGozNWtmUitNZ2tWNVhjMG04dEc1dGhyczFkVHZKVHV2VEp2QkdGTkdY?=
 =?utf-8?B?WWpCbmZqUHhpOFVWNUNNY0JNZGFDYXRQbS9IbERhUWdya2UrQjNlbVpZeTBh?=
 =?utf-8?B?M3N1dlNvSnFGNnk3WkRYZ01rUFBzUmtuRlkvci9KSUtyaDhpYjZ2K2JCQU9i?=
 =?utf-8?B?WDBHSW5Rd3oxUHNUL2pOb01MZ2RFTm5HMlNTSnhHTU83cTBLaW9uNW1jWjdj?=
 =?utf-8?B?OVFreHVDeXA3ZTlqQ3BjN3Z3U2FpbDRwNTRqQlQ1aStSQVgySmJ5NHg4N0xL?=
 =?utf-8?B?ckloWERJalQ4WmtTTFNhYlNrV2FwcVFCMUovSEErc3VodFFZR3dtOVNzVThE?=
 =?utf-8?B?dlUxS1N0RjJ1eFhsZjN3WnVEaExZcWRJQmR0a2ZENXFobHkzSDc1azFuWmtz?=
 =?utf-8?B?Y0w4c2lpbDFGQTZ3MU1sZWgyd01KWDFvMHNIVDFmSzB1V24xOXFlRjNjVnN3?=
 =?utf-8?B?aUw4VWZHNGwzdWtyczZCbEVNU2FhMStxTmFSaDNONkl4a1EzWW9TRVVnOFBT?=
 =?utf-8?B?SUVOY21ZUTRLSElIcWFteWhHRC9RNCtOWFZ0Y0pvV1I1MHBab0cxRnFKa25L?=
 =?utf-8?B?Y2VDTUJsejh2THYrSVZPNk80UVErTWdPbk01UVJVcXZGSE10MzRqY3JubzFK?=
 =?utf-8?B?NytzUzB5OEh6RnNwY0t4RTNxdDIwZEpidlNSUXY5d0pqTGlkUVh1WVFKcFZS?=
 =?utf-8?B?S2RibWxmdEZRMVh5OGpRUDI4c0FFN3h4bG9hOWtQWUhqTVFVNEcvVUxVWUJP?=
 =?utf-8?B?bUQ2cm5HdkhiblMycGkzK3Vqc3YvaEhOMklXTFk1VytKR21ieGczL2RnM0N5?=
 =?utf-8?B?U2hhbUsvVXAzL0dQbVB3dlZYUmwzcWRSQ2tiZFlJdnhwY2o1SlljaHNJbHRl?=
 =?utf-8?B?Q0hxNVpFcFNTYUM3TEl1OG5ZZ204NE1kQ1BrNnRxNStUdTlvUUx5UWVSdDJY?=
 =?utf-8?B?cDZRdCt5bVhHVmFCQTZiMUpGVndjRldLMzIwSzN5anE3U2liNjMxOEdOY0RQ?=
 =?utf-8?B?QUFNaXFFaEZ6N05SWTl1MDNZVCtTLzJPNTV4dXJUanFvUklJRElkMDJiZ29o?=
 =?utf-8?B?ZklBUUZSMHM4Q2xVYityRlVIZldQTG45RWMvbHFPc3JwcUw3Yy9aREx0dEhF?=
 =?utf-8?Q?iW0ojyaWcgA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRRU2xjT0I0bllXaDBUNmxWL1lvT0MzT2ZYNHpQNksvM2YzT0FHL0lKVHpK?=
 =?utf-8?B?bzdleE5QdjlYZ1dEZnFIM2FlL3Exb2lSRVRvcFhyNld1SUhyK09iYkVFd2l4?=
 =?utf-8?B?Y08xSjdZa0lVMk9OV3RYOTJjK3dhQnNWdDg0QVJkRDE3Z3NYWFdrUEt6OTl6?=
 =?utf-8?B?aUc4aGlqVzN4NC9mMlhMeDhrcnVoSDVRbm53M3VPeUxSY0w3SWdQRzNFcU5C?=
 =?utf-8?B?TTJVZitvMlQrSmVuK0dYQWM4SmlSajFFMnFYcUl2T3JuTWpENTJZRHNsR1Ry?=
 =?utf-8?B?b0R0aFBWL3QyRGdScUFZdXlQSlBpbTB5b3hwejJnd2xycldLaWFxOGtuRlc4?=
 =?utf-8?B?VzEvdGVRQ3dkK2VHbm9aWFA4SzlzT08rWGxNNW0yTmVyb0FTS29WYUdka1I1?=
 =?utf-8?B?TUxWWE0yeUF6UG9FMHRnUk54UHFGbUtuTVg2QkFhOGNEdEdKd0VnTVg3Y3dy?=
 =?utf-8?B?elhuUjRsVHFQYS93ME5tRER0MGdQWllQUjJ1U2N1UGxsVVp0VENRa1lrcDla?=
 =?utf-8?B?bmNTRXdpcFd6RVIyWFdaMkZuNXhqTUdEekxsaU1xdXhHcllRSUl4elhTbGc5?=
 =?utf-8?B?VzZIRkd6ckRpblBLQkdUUkhyWXV4eXkvOW5hMHdwYlBYTkJjSHVEQ3MwNzNK?=
 =?utf-8?B?dTRkc1lwN2hyU1EzOVJrUDY2cEpGOUc4ZlBYdERtRkdSVkhHcmY1aGxjb0VG?=
 =?utf-8?B?STZHZTFLZUhrd0R0KzVTR2dvamFsSEw3S0w4U2pqaHF5cVcyblE4U0tXVkFS?=
 =?utf-8?B?TFVMWkxpUzYrU2ZXUks1cHR2cTg3bTdqMUpLQUFQOVBTb3FUNWZENndiNHA4?=
 =?utf-8?B?bERCTThqenJhK3drbGVZS09CSWg4bjh6Q3RYV1p1L2VTU0VUcjlibGxFSnU1?=
 =?utf-8?B?MkIzN1BVWWhkSmtURzZhM3Z2MGI1SHY2bzZjWEMzZDZLRndHbFQ5RlNlZHVw?=
 =?utf-8?B?SHhKSFJWUDdmVjJKYlg4YlJlZERWR2dsaGJWekthbkU4WjRtY2Nxc3l6WXUr?=
 =?utf-8?B?TzJ0VVZDbnF3L0ZHckJ5UmpEN3U3dHlHZVpOdU1YMHY3MlpXMVcwT2xPdXd3?=
 =?utf-8?B?Z1JUK3NqcVdoQWlTbE90Uk5TSUdNS2czY1lIYTVhemxKVTdmZkUwYmpNQTVY?=
 =?utf-8?B?cVROanpaSkNNeGlsSWdNRzFEK1NheC9LL0VKLzIwdTdYbnY5VEFmUjBrRWVO?=
 =?utf-8?B?QkgyUWVVYkFTZkEydk1WTnRKcTVDMVZZVTN0MEFXb3V5L3Y0Q0RTa3ZjbWFU?=
 =?utf-8?B?c0hldEdLRnVyZFM0d0VjbzZIVWppT2c4TGxRVUF2TGpzWHB5WkZmRHgrckox?=
 =?utf-8?B?elJVNFJxM2xEb2VMRlptaWhOUHRINFlKLy92blNSSUx4ejExTytSMFZZNVlR?=
 =?utf-8?B?bk10bFJES1RwYmQxelNXNUhrTk5VNWZwV3IwYXVKVC9XZnhEdzB2NkNrMTU5?=
 =?utf-8?B?Kzdsd1kyWEU1dEUzMzg0aloxUlRkOGEzaERIZlRjVVQyY1ZEZFI3RmRZRXM4?=
 =?utf-8?B?aWduRHF4NXZTZUhzN1N1UjlKbDU0TVE4YmZPcXRjQjMwZE80alg0bXVrRTZQ?=
 =?utf-8?B?TUxRSmxKdTZvb0JUSkswRXJUZmJ1djhFMWtMZklqbmQwTHZlTjJMWmlMWnpp?=
 =?utf-8?B?ZzlCcXNOQy8rSXc0dWNtSDNLbnMweUFtS01VMHZnWmVwQkVSa3UwSTJsZ0hG?=
 =?utf-8?B?OWRBeFozdzhVZmQ2YnJkaFpFTGRPSzlnbmZray9Zc056SmFHTGsrRldvU0lK?=
 =?utf-8?B?OXRLTmtPTTVOL3laQ2F5Z0dYZWtobkQwT0dueFEzVGpuSHhTZU51bmdRYWlS?=
 =?utf-8?B?NTg0MlJ6Z1BrV092NCtYOExHSllyRG1LTzgyNUJMRHhEQjlJR0R2bzM2TTV4?=
 =?utf-8?B?TDEvVkdnVk5Db0VkL1kyc0s4UnhFWFA1RkhmeEkvS21paTdMbElWN29WWjhM?=
 =?utf-8?B?c09pTm1EY09KMGp2azlQTThDaEpHM1d1U25iRzZTT3ludFhMSTdHN3hHNU5k?=
 =?utf-8?B?SzV6VGZlNUZud1RiRU85d0d1VHdMVGpWTFpRS3ppNjRONDkzUFc4bW9Na3I2?=
 =?utf-8?B?cFdwakZHZWNNTjFBSEg4UEprVGk3NnhGYlV1MHZYZVRYRjliN2hEUUgzcEox?=
 =?utf-8?Q?Y8WM/euHzb4pxuDfQGYRJwgYE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca31e67-714d-4da9-0625-08ddd6844aca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:03:03.7408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CFXxvbBp3YMAzAE0Dnas9BAkAhaS6XQJLxoA5rYtJtXq//4ejWPtETu0BuyickxImXGQVefbKt4sKn2ccK/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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



On 2025-08-07 17:32, Timur Kristóf wrote:
> On Thu, 2025-08-07 at 16:34 -0400, Harry Wentland wrote:
>>
>>
>> On 2025-08-07 15:12, Harry Wentland wrote:
>>> On 2025-07-23 11:58, Timur Kristóf wrote:
>>>> Analog displays typically have a DDC connection which can be
>>>> used by the GPU to read EDID. This commit adds the capability
>>>> to probe analog displays using DDC, reading the EDID header and
>>>> deciding whether the analog link is connected based on the data
>>>> that was read.
>>>>
>>>> As a reference, I used the following functions:
>>>> amdgpu_connector_vga_detect
>>>> amdgpu_display_ddc_probe
>>>>
>>>> DAC load detection will be implemented in a separate commit.
>>>
>>> Another regression in our internal testing with this patch,
>>> unfortunately
>>> only on not-yet released HW.
>>>
>>
>> While this shows on unreleased HW I wouldn't be surprised if it
>> repros on other (recent-ish) APUs (integrated GPUs). It's just
>> that this week's test was on currently unreleased HW.
>>
>> Harry
>>
>>> I wonder if pipe-ctx->stream could be NULL in some cases.
>>>
>>> Harry
>>>
> 
> Hi Harry,
> 
> Can you elaborate when / how it is valid for pipe->ctx->stream to be
> NULL when the code gets here? Maybe that would give me a hint how to
> resolve it.
> 

I don't know. It was just a guess.

I should've mentioned... the NULL pointer access happens on driver
load.

Dan might have more info.

Harry

> Thanks,
> Timur
> 
> 
>>>>
>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> ---
>>>>  .../amd/display/dc/link/hwss/link_hwss_dio.c  | 16 ++--
>>>>  .../drm/amd/display/dc/link/link_detection.c  | 80
>>>> ++++++++++++++++++-
>>>>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
>>>>  .../drm/amd/display/dc/link/link_factory.c    |  3 +
>>>>  4 files changed, 95 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git
>>>> a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> index f3470716734d..b9ebb992dc98 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> @@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct pipe_ctx
>>>> *pipe_ctx)
>>>>  		return;
>>>>  	}
>>>>  
>>>> -	link_enc->funcs->connect_dig_be_to_fe(link_enc,
>>>> -			pipe_ctx->stream_res.stream_enc->id,
>>>> true);
>>>> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
>>>> +		link_enc->funcs->connect_dig_be_to_fe(link_enc,
>>>> +				pipe_ctx->stream_res.stream_enc-
>>>>> id, true);
>>>>  	if (dc_is_dp_signal(pipe_ctx->stream->signal))
>>>>  		pipe_ctx->stream->ctx->dc->link_srv-
>>>>> dp_trace_source_sequence(pipe_ctx->stream->link,
>>>>  				DPCD_SOURCE_SEQ_AFTER_CONNECT_DI
>>>> G_FE_BE);
>>>> @@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct pipe_ctx
>>>> *pipe_ctx)
>>>>  	if (stream_enc->funcs->enable_stream)
>>>>  		stream_enc->funcs->enable_stream(stream_enc,
>>>>  				pipe_ctx->stream->signal,
>>>> false);
>>>> -	link_enc->funcs->connect_dig_be_to_fe(
>>>> -			link_enc,
>>>> -			pipe_ctx->stream_res.stream_enc->id,
>>>> -			false);
>>>> +
>>>> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
>>>> +		link_enc->funcs->connect_dig_be_to_fe(
>>>> +				link_enc,
>>>> +				pipe_ctx->stream_res.stream_enc-
>>>>> id,
>>>> +				false);
>>>> +
>>>>  	if (dc_is_dp_signal(pipe_ctx->stream->signal))
>>>>  		pipe_ctx->stream->ctx->dc->link_srv-
>>>>> dp_trace_source_sequence(
>>>>  				pipe_ctx->stream->link,
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> index 827b630daf49..fcabc83464af 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> @@ -942,6 +942,12 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>  			break;
>>>>  		}
>>>>  
>>>> +		case SIGNAL_TYPE_RGB: {
>>>> +			sink_caps.transaction_type =
>>>> DDC_TRANSACTION_TYPE_I2C;
>>>> +			sink_caps.signal = SIGNAL_TYPE_RGB;
>>>> +			break;
>>>> +		}
>>>> +
>>>>  		case SIGNAL_TYPE_LVDS: {
>>>>  			sink_caps.transaction_type =
>>>> DDC_TRANSACTION_TYPE_I2C;
>>>>  			sink_caps.signal = SIGNAL_TYPE_LVDS;
>>>> @@ -1133,9 +1139,17 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>  				sink = prev_sink;
>>>>  				prev_sink = NULL;
>>>>  			}
>>>> -			query_hdcp_capability(sink->sink_signal,
>>>> link);
>>>> +
>>>> +			if (!sink->edid_caps.analog)
>>>> +				query_hdcp_capability(sink-
>>>>> sink_signal, link);
>>>>  		}
>>>>  
>>>> +		/* DVI-I connector connected to analog display.
>>>> */
>>>> +		if ((link->link_enc->connector.id ==
>>>> CONNECTOR_ID_DUAL_LINK_DVII ||
>>>> +		     link->link_enc->connector.id ==
>>>> CONNECTOR_ID_SINGLE_LINK_DVII) &&
>>>> +			sink->edid_caps.analog)
>>>> +			sink->sink_signal = SIGNAL_TYPE_RGB;
>>>> +
>>>>  		/* HDMI-DVI Dongle */
>>>>  		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A
>>>> &&
>>>>  		    !sink->edid_caps.edid_hdmi)
>>>> @@ -1228,6 +1242,64 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>  	return true;
>>>>  }
>>>>  
>>>> +/**
>>>> + * Evaluates whether an EDID header is acceptable,
>>>> + * for the purpose of determining a connection with a display.
>>>> + */
>>>> +static bool link_detect_evaluate_edid_header(uint8_t
>>>> edid_header[8])
>>>> +{
>>>> +	int edid_header_score = 0;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < 8; ++i)
>>>> +		edid_header_score += edid_header[i] == ((i == 0
>>>> || i == 7) ? 0x00 : 0xff);
>>>> +
>>>> +	return edid_header_score >= 6;
>>>> +}
>>>> +
>>>> +/**
>>>> + * Tries to detect a connected display by probing the DDC
>>>> + * and reading the EDID header.
>>>> + * The probing is considered successful if we receive a
>>>> + * reply from the DDC over I2C and the EDID header matches.
>>>> + */
>>>> +static bool link_detect_ddc_probe(struct dc_link *link)
>>>> +{
>>>> +	if (!link->ddc)
>>>> +		return false;
>>>> +
>>>> +	uint8_t edid_header[8] = {0};
>>>> +	bool ddc_probed = i2c_read(link->ddc, 0x50, edid_header,
>>>> sizeof(edid_header));
>>>> +
>>>> +	if (!ddc_probed)
>>>> +		return false;
>>>> +
>>>> +	if (!link_detect_evaluate_edid_header(edid_header))
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/**
>>>> + * Determines if there is an analog sink connected.
>>>> + */
>>>> +static bool link_detect_analog(struct dc_link *link, enum
>>>> dc_connection_type *type)
>>>> +{
>>>> +	/* Don't care about connectors that don't support an
>>>> analog signal. */
>>>> +	if (link->link_enc->connector.id != CONNECTOR_ID_VGA &&
>>>> +		link->link_enc->connector.id !=
>>>> CONNECTOR_ID_SINGLE_LINK_DVII &&
>>>> +		link->link_enc->connector.id !=
>>>> CONNECTOR_ID_DUAL_LINK_DVII)
>>>> +		return false;
>>>> +
>>>> +	if (link_detect_ddc_probe(link)) {
>>>> +		*type = dc_connection_single;
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	*type = dc_connection_none;
>>>> +	return true;
>>>> +}
>>>> +
>>>>  /*
>>>>   * link_detect_connection_type() - Determine if there is a sink
>>>> connected
>>>>   *
>>>> @@ -1238,6 +1310,7 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>  bool link_detect_connection_type(struct dc_link *link, enum
>>>> dc_connection_type *type)
>>>>  {
>>>>  	uint32_t is_hpd_high = 0;
>>>> +	bool supports_hpd = link->irq_source_hpd !=
>>>> DC_IRQ_SOURCE_INVALID;
>>>>  
>>>>  	if (link->connector_signal == SIGNAL_TYPE_LVDS) {
>>>>  		*type = dc_connection_single;
>>>> @@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct
>>>> dc_link *link, enum dc_connection_type *
>>>>  		return true;
>>>>  	}
>>>>  
>>>> +	if (!supports_hpd)
>>>> +		return link_detect_analog(link, type);
>>>>  
>>>>  	if (!query_hpd_status(link, &is_hpd_high))
>>>>  		goto hpd_gpio_failure;
>>>> @@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct
>>>> dc_link *link, enum dc_connection_type *
>>>>  		*type = dc_connection_single;
>>>>  		/* TODO: need to do the actual detection */
>>>>  	} else {
>>>> +		if (link_detect_analog(link, type))
>>>> +			return true;
>>>> +
>>>>  		*type = dc_connection_none;
>>>>  		if (link->connector_signal == SIGNAL_TYPE_EDP) {
>>>>  			/* eDP is not connected, power down it
>>>> */
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> index d6b7347c6c11..ac25d89a4148 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> @@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
>>>>  		enable_link_lvds(pipe_ctx);
>>>>  		status = DC_OK;
>>>>  		break;
>>>> +	case SIGNAL_TYPE_RGB:
>>>> +		status = DC_OK;
>>>> +		break;
>>>>  	case SIGNAL_TYPE_VIRTUAL:
>>>>  		status = enable_link_virtual(pipe_ctx);
>>>>  		break;
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> index 71c10a1261b9..c9725fd316f6 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> @@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link
>>>> *link,
>>>>  	case CONNECTOR_ID_DUAL_LINK_DVII:
>>>>  		link->connector_signal =
>>>> SIGNAL_TYPE_DVI_DUAL_LINK;
>>>>  		break;
>>>> +	case CONNECTOR_ID_VGA:
>>>> +		link->connector_signal = SIGNAL_TYPE_RGB;
>>>> +		break;
>>>>  	case CONNECTOR_ID_DISPLAY_PORT:
>>>>  	case CONNECTOR_ID_MXM:
>>>>  	case CONNECTOR_ID_USBC:
>>>

