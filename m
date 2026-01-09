Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F83D167F4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 09:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4FE10E86B;
	Fri,  9 Jan 2026 09:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrqEWHY9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B0810E320
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 09:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjW4x+EMM3rB/GoNTN2CH8KCxlNiwMV2Co6ALHwS6NwAMXt33Vx8IsHUccfY1NUgkHkwlFWIpTWQB9nhj1GqJu09w3fl2+CDjK4mHp/hxl72F2m22aTDgdQuYFE4MuNhy10ZuFhG3FZ6ROPh28zjK9z7P7nJ7eMs53/3gjTt909W51gQQsSmRSWlIRuCaTNBeACeq043KGUfyot6yqWxdAI4DkMCb38JixEK29nEophi7FUveqV5ZbNXC6QvVGiwZ11r7yeWsXHvfJcBDEtiGkEl5OEHAtz6jnmmKfHJoe7WMRuoGVIHJWOd8D9Dxh1+I8BR2HpgRNsHPmhQP/4a9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfnpAPYM//e5OQHpcHFVBkf9bbhN0DOEyhedTyrhD8c=;
 b=C51K1vI+8+ijfE7PfA4/hZ0Hz1QquP8s0m9n/GtB/B3c5LSeMk3avIMvz1xM/Y1pMP+8l0cD1LwlnzWBRydFd+XNgFo5RV0gtVXrd40QCY96L2vChTXJXX+ZHEpwEolTUg7Hj6Vrd6jiSq86ujxqRIjahzv079IYG1bVb9kO9TTeXk1gnGkICRcdKS1Kg8h20m5gdt4Vi1QqQppj9r+riroSVQyjuBNhN50n5sl09rD/Hd4B3uPjq2V5GUCPFiJFvV7dMRBy2+GRvfNXMuTdyHfE6oECWihhTUFMBgeXZFcAQILJlAhz5vNJovGGO7ybDt2NOLpSSpIlJLWRUEMxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfnpAPYM//e5OQHpcHFVBkf9bbhN0DOEyhedTyrhD8c=;
 b=XrqEWHY9pK7Uf0ow/FFOpmk7CPXvaWolFsPew6iyqhfUI8H/kPGTKTBo2818SAuZz/6gWMSpb0LyfAGoGBD6XObde2m14Y5givaY2JIxQOivfcq6gbVp6FSXN+pabSycUY3cHrzGG1zzwkD9m0Uotouodd0lDYnYa0SZhbs+uy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 09:49:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:49:01 +0000
Message-ID: <4abc4a8d-969d-40cc-b81c-543f54fcbee0@amd.com>
Date: Fri, 9 Jan 2026 10:48:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: Add timeout for user queue fence
 waiting
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
 <f9ed2178-06a7-4d2d-96d8-ec3c6f64bd12@amd.com>
 <DM4PR12MB515245A14DE04DAC9988AC82E382A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB515245A14DE04DAC9988AC82E382A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 921dc91f-e864-4435-b230-08de4f64512b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGZ6Y0FZb3UySFpYREN2ek9Qb1dBQUJ6SkcvWXIrbXh6eCtTSW1qNUdVSEk2?=
 =?utf-8?B?U1ZvNEs5YmYzdXV3UGxUT21vczVHTldrSWlOV082LzRrcGdTVFlJQXc4UEky?=
 =?utf-8?B?MldpZ0VmQVhRMDlrWFBvVWg2RnUwdHlNeGlneVlPWllsWWx4VVJuNzBGeG5m?=
 =?utf-8?B?WUJNdUV6VlQvVlZ3eTB2OTZPK01wYUpUcllCRlB3bXVEVlo2Y0FxemcraHJz?=
 =?utf-8?B?Qjc1S0o5bW1OSjNMY3MvVktqSTVWSXJVOWttWDRpTTBvT0QwV2pRbkFpYUJv?=
 =?utf-8?B?UHF4SUtlK3BlbnI3WlNXWXgzZDlxbVFxZWJHa2M1QjcwT2g4bWNLMWM5Rytz?=
 =?utf-8?B?Zjg2WlRlK1N4Y25vRkoyU21iUXRvSnppdnowVUpuZmo2QlcrYlRWMHJBOVcr?=
 =?utf-8?B?dmNQdkRxNWErdHZzWmlJOFByVitLVG8rQzJTWE1XZnY0WGVoTGc2TXo5NG9t?=
 =?utf-8?B?VERadWVmOEFVMnN2WEk4eTFoL0NEYWJVTGl2MFJQVmo1SGFtMFBFQWJoTElD?=
 =?utf-8?B?QTh4SDhmWTg5bHN3eW5ueVJpVnMwS3FiV0pxb2NJUHdqanQ0UWh2MGdoaFJw?=
 =?utf-8?B?TEZ1Y0RYbEIxMWRjbTVEZFltKzg3T1ZOVUM1SDhBRWFXWHdMU3BueENkc1Bt?=
 =?utf-8?B?ZWdJRjJacVJlUWg4TEYza3lQN1MzNTRHM0gyQmVLNVh0OU9nVnpZZ21CZ1Uy?=
 =?utf-8?B?eFd5cmd0L0M3WFEzLzdjUlFFNkRtRXlnQzdpcjhrc2lDWG9lblFVbkE5QW5F?=
 =?utf-8?B?Um5sTWpRWDBQcFFDV253SFE2K1dTYkFZeGpPdnNxYjM4bHZjU1gvcHJPNlRr?=
 =?utf-8?B?bzJIRzg5RWZDL01RWTJyN3JZY3BOcllpd3dXZ0tUbHZVcjAyalF3TDc3RjR1?=
 =?utf-8?B?d210Q3JmS0s2VTlCUTEyS0JsbzhudWoyWGl0MDh5K1k5YmQwSzMzUjJnOHBi?=
 =?utf-8?B?Wk15c3hmb2pJVGxVd2trL2tYWUpvUE1SZE8yRHA2Y1ViMTEzZFNSd0kvSlFw?=
 =?utf-8?B?SUJRVjg5cm0raGxqN2tUT2JRRC96cUxyVC9kOGE4MGhuUzBRVWtIcjZOVitE?=
 =?utf-8?B?ZUl0QW5FOWw2R0dmMkJtR0laUFZvL2tBT0V5SS9HV0k2SHl4YUZTd0ppSytS?=
 =?utf-8?B?ejlROTlxSGxyQlV2OENYNjY4N1RzNGlkSlZlRDRGbWlLRUtvRkRZUUFnMXll?=
 =?utf-8?B?dlVrVVlGekJ6S1IzaGcvZUpvZWljeWVaemFrMDVXdEhzYnR3c0tOOThoMC9i?=
 =?utf-8?B?MEEzOUhlYkVuMkExQS9rL0RGYmhsa0JkRmhDTGVHaWdzU1I3a1pKUmsrY1NL?=
 =?utf-8?B?QmtDcUZ6YUd1bi9YbG9HQllvYm9FU0hKb2Q1L1BEQ2NDQ1F2blZIeW5KaGg3?=
 =?utf-8?B?ckE5M2xxMGlTeWpDMWkwMnJCaVZYa1A1cjlyc2lJVDhtSUM1QWkzNUVzRU1i?=
 =?utf-8?B?dXVDdDUveG5ud1NJNzF2NmRUMnBFbVprMVNVV20waGpJMHdVNG10bjdpeHJo?=
 =?utf-8?B?cXlBRzdQRjkvSGhsd2hUWE1zNEJWajZqaGpld2MycDFGbzVKQXNxNzE2V3Fl?=
 =?utf-8?B?cDVHL1V3cFVqT0VwQUs3QVZRWHAvSThybXhwQVpKWVZQbkYzckd6Wmp1a2VE?=
 =?utf-8?B?WXNaTm9acHU1MjNXSW1XOGdOM2JLZEo0TktqNlpsVStRK0loa050NDJDek9q?=
 =?utf-8?B?c2k1cXhCTGt5UE1zcW5nU3d2QmFNVm9PRXh0ckdtNjZNOHdWU1drTFhieU1v?=
 =?utf-8?B?UDFOL08vOWltUm4xSWRPdFNFVldJNW5FSjRnNEdQdGtHRWg2RWtjWlJmcjRK?=
 =?utf-8?B?UmRiQmhBeXR1clJuczFDZGE0UnEzdDBYYXVhbUpIaUp0YjJrc2ZNTEFRMmY5?=
 =?utf-8?B?TUczd0FqNEZvWWw0WmNSZ1l2L0FHaVd3ZG5pVTZtNnJGSVV5cFk3eVE2VjBQ?=
 =?utf-8?Q?2GJzh+YbriX5VrrYJ5TNxdqbtmgSEq9q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpwbjVkL1RkcFc5RHVoOEM4dThubzJIWmpYMVMvR3c0dmZFZHhZTlJkeVd4?=
 =?utf-8?B?SDZVZjhKdUtEWkVJR0JPNkZKcDRNUEp6WFhsNE9jdHkzL0xnZm1nOHoxNHFK?=
 =?utf-8?B?eWF2NXkwVkYyQVYvTUhFdGJxNlZXVHZlT2JPQ1ZWVnc2a1d5cm1IMGxsMmtM?=
 =?utf-8?B?ZFBmcVlteVRUTTBZVGU4aTI0Q3diUmRSTUdFK1lKZ3BEYWdkc0h0d3pKR2hh?=
 =?utf-8?B?b2ovTG9qcTF1L2huMGxURzVvSGs1RGdWRS9ZdjUzK1Fad0dGbDF1R0ZGK2o4?=
 =?utf-8?B?SmZpNVZKajNuT09GbEdjK2FOdFlZVVBjUk1idHZZYTQxYTNhU1pXYkpjS3Jr?=
 =?utf-8?B?RWg0Q0JYd2xDQmVLa3dPdE5sUDc4bUFZakFwVGwyb1RVWjEzK21iRFMvMUJZ?=
 =?utf-8?B?VEtPMnZpMk9vUjBtQVJmcG1SN2pMV2xJdnkvNHlkUGduRlp2cDNKdVBtbzNL?=
 =?utf-8?B?MFBZS0t0WUFjWUw1azRTZUZKQkNxTEJVNXdSOVgveXF0MTdHQWxEVHVuRlNY?=
 =?utf-8?B?Y1FSY0lLODM4dys4eHlnRWliV1RDUFpPRmZYQjJzY3I2aithWlZqN2VvdDRk?=
 =?utf-8?B?Rld0Y21DOUNycmxudmdwSkQ4enIydytjbkQ5cHNSbFFzOURIMm9obm9uL1lS?=
 =?utf-8?B?VDFMZGw1VWRGVUJUNGttcHlzSWc3WHBpREJCN2hJMFM5VWhRb3JOajhtNmFk?=
 =?utf-8?B?S3VNLzFyY1V2dFpReGI0OXRtaE5zcWJCaXNjdU5DZUhLWHJ4djNldnV5K2h2?=
 =?utf-8?B?NzBlM0toQUJOUFhIK3ZLUkhhZ1ZKMFJzVEQzL1ZRQW5OSVdKWXN5NTVGeU5C?=
 =?utf-8?B?NDRLcUE3RC80bmZ3NEhQVFJ3NnBiVlhmb1IwKzhJbDZOcmlGUDZRSlNnc3BO?=
 =?utf-8?B?dVJwZ3k3RnQyY0JzUWlQOS95TElEZE1FSlU2cVY3dEtNK2lWVksyZ3Q0TkE3?=
 =?utf-8?B?djl4VXJrVVlsbHArVC9jbTk2K2RaYmlKRjdtMytVTUpDeXBHVGE2TVhPWVJV?=
 =?utf-8?B?ZithUEtkcTExd3I3TC9icVUxOEJsa28zTytsSzVCaXhsTUxUK2R3Qkcra2lF?=
 =?utf-8?B?VTJWNG1NK2RvMmgrMEdEWlBoT2FoRk94NnZaZG15K2pndVJZRTVRdGg0RitP?=
 =?utf-8?B?MmxkZnVNeWVVRWRuSzYwRTMxZUVyTzlPSG84dU5QVEFyWDUvMW1mdnZTRDIv?=
 =?utf-8?B?ODNoaGRrWHQzQTV4eXFPN1dDRkZhMWd1djAxUEtxVDhSSDFxUjJRTzZhaVYv?=
 =?utf-8?B?YVdMYlhYOUJoWHp1OUc3QzZ4VkRidGpoSjBDVkY1aTBBNis5N0VWRXRLOWlS?=
 =?utf-8?B?V3VQT2lpWStpckdqRWdPZEw5ZS80TWpRTDVoRzRXVGRjRDkwV05rdnp5c2Nw?=
 =?utf-8?B?M3VzcmRUZjNEN1dEbERRQnJ1b1duVDVqR28wRlhrYnJmL3RXMVFPL0ZDZ1Jk?=
 =?utf-8?B?enNubXZQR2R5YUQyUGpIeTduV0VyTGZKdGdGNlkrditOS1JHVnpnQ1l4ak5M?=
 =?utf-8?B?dkk3d0NxZG1LZmpzTXdJVndrWUpzdDl3QkxFWU93OXlsamlEZ3dZNGN0enN6?=
 =?utf-8?B?L3VNRlJjVjgycTA1MkJHNS9IK3ZPdnNURU95VUZEQjFKQm8vbSswVFZYS1N3?=
 =?utf-8?B?UzRkUWtQQTdNYUVKVUsxY3NNOHNmM0FkMmVPTDZVdzQ3WjM0NE5zbFVpcG5C?=
 =?utf-8?B?WUpZZCt2Y3R2djMzdW1hOGhseDY5N0Zsd2Y3Zk5yWm1pZUNpUXdzYXcwaWxp?=
 =?utf-8?B?cHp4TWg0SnF3Mi9pMHQ3QkxHRGpxOE8xdDVmOUF2RXlESHNiTEttUHowYld6?=
 =?utf-8?B?YzcxVGZ3U2haYlRRYzliNUloMGdwdUNndDFtUWJhYkU0T1Z1bExYWFQyL2Er?=
 =?utf-8?B?S1g0UlllUnNhSHY3SUo2anlGdTBVclprMGpLVjh2VXpXN0VhY3JkUkVzYjlG?=
 =?utf-8?B?UkcvSGtqdXk3Ly85SHRwMXdZTWRxOUVlM3gzenl3eDJTWXVXM2JDYzJmV0Vv?=
 =?utf-8?B?bTJWSUZGcUc2WFpWeHVXSzZnSUNlTlpiS24xY2pUSlZHS01NRlc1UE5TaDVQ?=
 =?utf-8?B?TDNtMzhWayswcW01dHhucEcvKzMyM3pselJtVVFpWVBzYklESW9wS09GaDVP?=
 =?utf-8?B?cG1VaDJReUlsaU1OSlNZTXhMZnd4VTdla1pXSUw1NENVWjArL2hwRVlFbXAy?=
 =?utf-8?B?dmlzSEVBVlh2YTZ2UUdOZFFVQ2IzZWtUUUY5MEVCdm1TQXE2WlB3SHdPUGcw?=
 =?utf-8?B?SmtDNXpJcWlxYkErMTVCTjZUcHh1RnFxOUUyM3U2M2hvU044cDdwMnVvaUs2?=
 =?utf-8?Q?2boGpuEdKB+PmVTCsb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921dc91f-e864-4435-b230-08de4f64512b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:49:01.1551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C00u/oF1atcnHQMeIBfnZIGkcrEPTLr3RyDOBz77csPyZxb1yI68Us3QuTv35BDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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



On 1/9/26 10:44, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, January 9, 2026 5:02 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amd/amdgpu: Add timeout for user queue fence
>> waiting
>>
>> On 1/9/26 03:34, Jesse.Zhang wrote:
>>> In certain error scenarios (e.g., malformed commands), a fence may never
>> become signaled, causing the kernel to hang indefinitely when waiting with
>> MAX_SCHEDULE_TIMEOUT.
>>> To prevent such hangs and ensure system responsiveness, replace the indefinite
>> timeout with a reasonable 2-second limit.
>>>
>>> This ensures that even if a fence never signals, the wait will time
>>> out and appropriate error handling can take place, rather than stalling the driver
>> indefinitely.
>>>
>>> v2: make timeout per queue type (adev->gfx_timeout vs
>>> adev->compute_timeout vs adev->sdma_timeout) to be consistent with
>>> kernel queues. (Alex)
>>>
>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>
>> Once more: Absolutely clear NAK to this here!
>>
>> The function amdgpu_userq_wait_for_last_fence() *MUST* wait forever for the last
>> fence to signal otherwise we run into massive problems.
> [Zhang, Jesse(Jie)]
> If data packets are corrupted (e.g., injecting error data packets), it can cause the queue to hang. The last fence will not return, and the process will wait indefinitely.

Yes that is expected behavior.

> Therefore, we should set an appropriate timeout period.

No, exactly that is absolutely broken.

> We can trigger a detection and reset mechanism to recover the hung queue and, if necessary, set the error status of the last fence.

Yes, that is the right thing to do.

The timeout detection must be independent from the fence, e.g. you don't wait for a timeout on the fence but rather have the timeout start as soon as the fence is initialized.

The timeout will then trigger, does the queue reset and signals the fence with an error code.

This will then unblock the waiting processes.

Regards,
Christian.

> 
> Thanks
> Jesse.
> 
>>
>> Regards,
>> Christian.
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 98110f543307..402307581293 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -367,11 +367,29 @@ static int amdgpu_userq_map_helper(struct
>>> amdgpu_usermode_queue *queue)  static int
>>> amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)  {
>>>     struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>> +   struct amdgpu_device *adev = uq_mgr->adev;
>>>     struct dma_fence *f = queue->last_fence;
>>> +   signed long timeout;
>>>     int ret = 0;
>>>
>>> +   /* Determine timeout based on queue type */
>>> +   switch (queue->queue_type) {
>>> +   case AMDGPU_RING_TYPE_GFX:
>>> +           timeout = adev->gfx_timeout;
>>> +           break;
>>> +   case AMDGPU_RING_TYPE_COMPUTE:
>>> +           timeout = adev->compute_timeout;
>>> +           break;
>>> +   case AMDGPU_RING_TYPE_SDMA:
>>> +           timeout = adev->sdma_timeout;
>>> +           break;
>>> +   default:
>>> +           timeout = adev->gfx_timeout;
>>> +           break;
>>> +   }
>>> +
>>>     if (f && !dma_fence_is_signaled(f)) {
>>> -           ret = dma_fence_wait_timeout(f, true,
>> MAX_SCHEDULE_TIMEOUT);
>>> +           ret = dma_fence_wait_timeout(f, true, timeout);
>>>             if (ret <= 0) {
>>>                     drm_file_err(uq_mgr->file, "Timed out waiting for
>> fence=%llu:%llu\n",
>>>                                  f->context, f->seqno);
> 

