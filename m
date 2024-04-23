Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218C5C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 11:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3FE10FBEC;
	Tue, 23 Apr 2024 11:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J5iXQWz9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6801710FBEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 11:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lbmq+y9W1BUM3rbdFXUVVv1Yg87iKoHUEQf36sNIEmatnWll4geYH4D2rb3y51wGpzso7LRUpjuqITI8gOlc83j9gNWK5gz8aYvPbSvU4L5DmDU3pB6xMUW3vUGJyjeKHNkFrOiIOXfRkqR83NvooOq/hTuVy3RvAUzuJP/ualBjLUarQfvjh7rHqjkduvilJgKjA7wcSLJ+440DJCZBHTsFstAmaaJvMbSy+fE97LdwbXsXWTtnfJtoUIXHYFY6U/iYKClj/YosjmA/ey2tVSWgeTNVomDVaL5SWWXHR+VpArD8asq36bAlka9VIt2iCS5Dvijfz2BxP6n/47gLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjqJzNlRg8LeszPAqfnemQU/GpUQZeoSAlOpekhEJPY=;
 b=GdJSMsNgHwzWbOwCz5iAba0dOYTDLUEJAmsamUQScMk0+ezB3B8O3N3dr/wvAv7Cs8nrriQHWl71DRONIBCCEnrd1S3KM1F/S9fjEzy6WpE+4qB6x1RwYbTe8Cfezf2mUTkbr90lSd5c/2yBkMrvdPUNPlstx89QkK6e98uo2yQlIPGUUbgm8N/goPjXGkDyD1DtcyHW1Bqn6eZv5uYxMFhacl77pT8GKiTs40g79QGYU6Ix+bywJWeqGikXhRTZzwZhOTcLtOQe1FiuZUUZEyyV/Mm4QrY72wpya+lALg8Zqi/stxZRinUsNT2oml7wKR3xuWTPEHYqKCsCGxA8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjqJzNlRg8LeszPAqfnemQU/GpUQZeoSAlOpekhEJPY=;
 b=J5iXQWz9OtlKQUHc1avDd5+k7L6WzH0h+Rqq9JBg5zag3K9jUrPmsaUlrOlQZLsQRZ7MtoSDc0wwgDzZGG3dTC1uB6OXVYBOzeOsnGYxPRzwQxB+XISg6BZkes7cjBiS/sC8IkASumg2gmQ/HFtKhw9lsrWcsJEs70Wa/5ihFiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:22:49 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:22:49 +0000
Message-ID: <8219c256-b286-4e6b-8960-6977f4cad790@amd.com>
Date: Tue, 23 Apr 2024 13:22:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
To: "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240423062853.1022925-1-Tim.Huang@amd.com>
 <5456f6b4-7fc4-4ac1-b85e-cf3b00b5c4c6@amd.com>
 <CH3PR12MB80747050F8AAA33C6F32851DF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH3PR12MB80747050F8AAA33C6F32851DF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To MW5PR12MB5684.namprd12.prod.outlook.com
 (2603:10b6:303:1a1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: a4769dd7-1e11-428b-4b10-08dc6387b4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ditnR2FMdkNBSUdFcXVCQndBaHJQN1poMVVVYVZEWCtRZTJ0RlFFczhXSjlq?=
 =?utf-8?B?Y3dNRm4zN2JSejEwYm1qRGZvWjk1M1BZTU9XZzhqcHkvT3dGUXRaRklNU2da?=
 =?utf-8?B?S0dqaTRveHI1dXFUdE9IQTNyYlhXNUpuL2JpTGZpY01lcERYZmZLMGE2OFVo?=
 =?utf-8?B?Nm9lREQ1RVVyRnpKRDd4bm1NbTB6VDFzMnlHMnlNTkYzYmV6dFpOUUtiR2RR?=
 =?utf-8?B?WWxubUhYTWZHWEd4QVMyTk80UUJUcGdTVmo1UjhCRXNxOWQyMTNDaWxYcG91?=
 =?utf-8?B?SzZLUGNDbXNxZVlQU3dPZUNCekdodnM3dXFSQzB1QWZGWVFBTWgyMFFqQ1Z6?=
 =?utf-8?B?THpZTTBOMXRFVk5KakpoeDRoSjllU01rL0p0SWNUOGJQN0U3YkkvbFZuSURJ?=
 =?utf-8?B?dGFMZ0x6Y3VISHFWamszKzVXa0R5NitFcTd5Y25teDF6Um1oQ1lsYjRRVVhM?=
 =?utf-8?B?Y013VzhsenA0Y1JjWW9WMTF3NUZZMUJJT2F3N0JEYnFEMWxla2pzL0orTmJG?=
 =?utf-8?B?elFtNXhaUXNONFlCaThaSEF5Ry9oSWJ5bURPcWtrYmd1a3dBV3FTNGkvVmZo?=
 =?utf-8?B?MjR6bTlScUJ5QkhGOXUxcXN2QVVyanpHOHNNTmpxWVFUMklvcENBSHhxTUlG?=
 =?utf-8?B?SkoxaVB3c2lzMktzQXo1NndtY0pUTEtWeXpiL2pKK1IwRWw2VXl3M2NwYXAr?=
 =?utf-8?B?S3VSRDFWVkl5V0Z0SXlWSG9rZmZ1VXVRMU5yZkZkVzlIQ1BoVFhZakdRQVJ3?=
 =?utf-8?B?R0lUeS83ZXdqNmhVWUhQU3NTVkh4WldYdVJSenJUNEV0azNEL3dsbVE2ZE5p?=
 =?utf-8?B?UHRLdHVIaDJiRE13N0xlNnY5WDFPNENmbURKS05kVkhoZnlGdlMxYm9xU3Zt?=
 =?utf-8?B?TkhEK2QyZVhRYXBMaU05dyszU1FnaThpZ3J3c2J5cU5EMlBWVWQzRFBpcXpn?=
 =?utf-8?B?MUY2cENFbG1XT2c1SGd3Z0ZtYmhEK0ZzM1hhVWg0eXhmelBWdS9IaGxYZ1Bj?=
 =?utf-8?B?azJNVEw2akFqY0FpVEdzMW9kZkFWS1FGOE9jaUlCVlp3aEJiUDliSGROdW9z?=
 =?utf-8?B?WDRSSGhOMUthOUJ2eE82RzJic09rTzJobWhuL2hSUTFONlZIa3NCUGdVNExk?=
 =?utf-8?B?WUhXSmZNeHNSaWRXWHQ5M0I2ZHpIMk5tbjBONGhRQ0R2OE9pYW5BNFFHb3hm?=
 =?utf-8?B?alVEQWpDS1hONmVCZFFnVE9Xc0FjRU5ucTNxYTZxcUhXb2xwUkdKaEMwMG1M?=
 =?utf-8?B?alpIOGxtNEE5dkNWQjFQMlkzZXA5L0w2RWNkTGRkSkJlWDNIRENpd0pWZ3NW?=
 =?utf-8?B?endnWEVxUWMrOEpsaEI3ZzVMbnZ5c2IvOG05UjkyUm1xaEZOdnZRdVVNMjJr?=
 =?utf-8?B?MVpMakxZeFQ2Q3U4eVd5WXk0ZE9XS3RVZjN5ZzkwOUJQYXlhTWFLc2t4MWNw?=
 =?utf-8?B?UW11K1hRMno5b0ZMQWhDeWJHbExOSjJtK2tmMFg4bDV5ZXYwNjBNK0ZtWkpI?=
 =?utf-8?B?eTg0TDlBSGJuTzBRUTV3RERDNUVibExlZG1rVzN6bFkwbE4ySUhXTXBFSTFk?=
 =?utf-8?B?NDlnWWI4M3NVU3lvaVIvSGlpeWdCS0tuK2NLOTF4dE1ybVcrbEgrTnZPb2RY?=
 =?utf-8?B?OW5EL1pCdFhIclZtZXZVZGlsZy96Y3kvWHJWUGV0MUJ3dEpKR2gwZjRIL2ZS?=
 =?utf-8?B?VjVyVmRITzRuODM1TVpGSzBTbzF1ZGVlZ015ekowNnJYVFJVMUo3bWV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Q3WmxmQVZaZ1c4c0pNZkVsNno5K29tTUdyL2ZGUU0yTzB1Y3lOUks2Qm5R?=
 =?utf-8?B?T2ZKYnBOTDVCRk9ZNTBsQjJnNkVMeDFtaDZaWE82eC9tNUxQTVYxUHdZSUFU?=
 =?utf-8?B?bU9UVSt1alJBMFlmejNwdUdxRmtXQTNyNjJhU21jdHlHZFViczV1T2VQK3R4?=
 =?utf-8?B?Q1dpU2NnRjBMWlU4bW51QUlwT1dVWjFCYkFUUnVPYW1JQkw5OC9KTGU3SXJl?=
 =?utf-8?B?NmVhUis4TTVMbjduRmNuN1hIMTNWTytNcEFLbExNcit5WmFTZGpGY2RwMzFl?=
 =?utf-8?B?K3lkMEFYSEcrcEdVTzh4NmNzSG9qZUR5U2Q3Lzc3VmlJNUNzcFBzL0J4L1pn?=
 =?utf-8?B?NjBYL050aWZ1Q0dVS0dqdVI4bGZuRG9RdVhad2pGWUhkbEVpdmRZbWtWRFhs?=
 =?utf-8?B?S3ovRkluT2ZWZm1NOVdoMjJ5MTN0Z0M0TEdVczNPUURFVHllc0E2YU1Bc3lu?=
 =?utf-8?B?ODRXVU01cGZtaGNHc0xWb0F5Nm56ZlMzcGhSakFhYWRvQXhHUWVGLysvNXA0?=
 =?utf-8?B?Z1Zjempkb001SzFXcTVTNUpGYy9vV3BIZk56eDVhclFYRkZVMWhSRm94NC9s?=
 =?utf-8?B?a2xqSTVMZ2lFdDJvMkNYbzNEbTB4amZZSUZ6a0grNVZzOFV3czdsRkdPcnF6?=
 =?utf-8?B?bVlFSEw4N0xUYlppYk50aWRpb3RnNG1SaEpSRFRBM3FabXVwemJRaHlveFEv?=
 =?utf-8?B?MVFEZHcwU2R5cUpXL0FML0dDY2IxZXJEcjNLazMraU5YOFhrM04xRXFXMUNt?=
 =?utf-8?B?SmdIVDR2bzRNZit3ZnBNSitRaUJWdnExZ3NmUktqNVIwbDFNZlZsOXBteEU1?=
 =?utf-8?B?RjdkdlNrMDVJenU0SFlwaFdscEJhcStlZTA5ZlJaTDV4OWtIY2s1end0YUEv?=
 =?utf-8?B?RzBLSzZ0MGlXbUYzTitrNXFhbDRKb2FPazNOSzN1cDJvMEFBL2RzaHp5cFZl?=
 =?utf-8?B?Uk1CWWkydHJRVndqdkNWcXBKcEZGdUFqUXBLL3JFK28zK2dSSDFXZU5ZalVu?=
 =?utf-8?B?MG1ENnpZcnpNVnloZDkrNUxEY2hNbFVkTFlwOXBobFNkVjRzZlp6bzN1UEYy?=
 =?utf-8?B?SVh4bE55WTROWEI2STNGT3lhMFAwdUdxTDZmaGRSNnppSGhtYng5VDZ3VHdk?=
 =?utf-8?B?R0JIWmFjRzF4QmtTZ0IwbUduRFpNVUp0bEJoQjdpRWJwSVdFeGhwb0h1UFlN?=
 =?utf-8?B?Z3AzWjZCalFVWDJSSmRwQ1VrM08vNWtvaXp5dFF3cytVOUt2NXF0NzhGU2FZ?=
 =?utf-8?B?SlYyVmFrdFlIZ0d0VWo2Q285YmRvUDg2bUVwZW9TTmRRei9rOGk3ZFJZSW5v?=
 =?utf-8?B?aDd4WWhDcDBiVUlVcmRmSnNodXREYVEzb09yeThueUdocmFpb005NmtkMno2?=
 =?utf-8?B?dWZwQ2tmbDlVd2lPQnorUG1pVzZBcTM3OU81WS8ya1VxNEsxc2Vvb2UwdGN4?=
 =?utf-8?B?NHFvd0ZsOUhVZU9tM2YwbXFBbFdHMm9wQzdYeVVUY3ZXSHE1WkdmOVhrdHY3?=
 =?utf-8?B?Sy9zSFhIMzhVdDEzZGZBTmFMbkF1S3lNVDRHLzQ0RHU4TGJXV0h4NHZpV01s?=
 =?utf-8?B?K3ZRK0l6ek1aT0RVSW1EVGhzV3JHTTdYQlFtcUJxbitWdEU3a3BsbGNjbXVs?=
 =?utf-8?B?bEtjTXhkSWpRMGNIekJMZDkvemFjKzYrQkFtV3o4Vzl4amlIQXdPcW1GT0hq?=
 =?utf-8?B?MFZValFUTWtOZ0ZUM1pDMlN4bGhHSFprc1UzZkZKNWJpcWVvSWZCTGJlS0J3?=
 =?utf-8?B?RDNGODB2bW9pZmd3UDEvQW1Rd1pkSFF4TUMyYWtPVnBQQmVMTkV1SkRXZU9M?=
 =?utf-8?B?Q2dWVENscDgzZ1FDUVJlL2s0UU1pQUpVUitRTUNnbHRZR2tJa3d5Nm1IMzMx?=
 =?utf-8?B?VEF5c1lIRnVyZUpqbFhtLzVhWlN4UjByRkErbEJ4d3dOWFRJWjZiNVN3TGE0?=
 =?utf-8?B?cFJjZ2ZTMWlHbjB0SUl4N0F6dVZSbUFMUG1sS1dsWU91VVRIVWhJV1p4MnZR?=
 =?utf-8?B?UXVsSitCbFdxM1lnUEdkRjY0aE11eEVoSHJBU0kzcHFYc1pRenRIbCt3bUxv?=
 =?utf-8?B?U1d4QjNpNmhxNG8vRUg0bnhWQW1uR3dnWTdxcGN2RlBsa3F6VU52aGM1aFhP?=
 =?utf-8?Q?eeu+OjZ9dEqMU0DdExwGXhokj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4769dd7-1e11-428b-4b10-08dc6387b4fe
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:22:49.5705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dt0yi2kJK+U46CH6YStAgtLkoI+tbvfVSRvazGHckfbW67Hz/my8F60cyVKyx4wg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

The problem is that it's a hit all case and that's usually seen as bad 
coding style.

In other words when one branch by accident forgets to set the fw_size we 
wouldn't get a warning any more and just use zero.

Please rather add setting the fw_size to zero to the default branch and 
maybe even add a warning when that happens.

Regards,
Christian.

Am 23.04.24 um 10:01 schrieb Huang, Tim:
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, April 23, 2024 3:43 PM
> To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
>
> Am 23.04.24 um 08:28 schrieb Tim Huang:
>> Clear warning that uses uninitialized value fw_size.
>> In which case is the fw_size uninitialized and why setting it to zero helps in that case?
> It's a warning that reported by the Coverity scan.  When the switch case " switch (ucode_id) " got to default and Condition "adev->firmware.load_type == AMDGPU_FW_LOAD_PSP", taking true branch,
>   it reports " uses uninitialized value fw_size " by this line.
> "adev->firmware.fw_size += ALIGN(fw_size, PAGE_SIZE);“
>
> It may not happen if we call this function correctly, but it just clears the warning and looks harmless.
>
> Regards,
> Christian.
>
>> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index d95555dc5485..6b8a58f501d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1084,7 +1084,7 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
>>        const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0;
>>        struct amdgpu_firmware_info *info = NULL;
>>        const struct firmware *ucode_fw;
>> -     unsigned int fw_size;
>> +     unsigned int fw_size = 0;
>>
>>        switch (ucode_id) {
>>        case AMDGPU_UCODE_ID_CP_PFP:

