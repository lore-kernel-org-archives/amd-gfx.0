Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D82EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 11:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF6210FBF4;
	Tue, 23 Apr 2024 11:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wTn707E9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4CD10FBF4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 11:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9KUABs0Bo9yyY/Jq6IL7yM7qra+pZt2h6d3r92pDr3gStn1bWxRKRUwwMXKA+at+X7dmeCnEg8L8lRBKsKbpwQ2dC4LY7jlrAFKNZuxxLjMlrLLbJSJ/3T9e+EcDWGNqLnfRkQHs+pwWOSAmKihTgRh0QVyZR9m/calEizOAfgMOGj/EOqEuTyC9Q7xCZo0X99eSnedSXyoQjBJlrLu4fDRXmEHV2+qOI4XMkwEUJmN/LyP/YhpVXrnpTcniNdepBXwtkXFYgqix+l5bADlD3GBIJOt7Aocgy7EskEgmh3VDqxqHE4uOCwX2VFjm9yK36YCOc86snsrHLdo4f83/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amIF8qq04mpK3TebnzDXru0Q3L9XQAWveEaZbgfGBSA=;
 b=WpYGegQKmVQiMLL8NP9eHVmJvFAxxSQ2FZlzw1cW45oeOPlT1QlEYHy/dj2p2KD3p1G0ahLKEOGyuAlQVVm2ZhWu0A5kyMrFt/jba5rOTJHrMWGDAkJRgoGtNl+nvqQV/C9cYFC1VBNKCFlqn0deupyGLX1kvbLN3OvpHJNJ/HL9BxlTjyiE+QlVcJKCv9BtVOFy5gq/TT0ycOm5Vj2JoJrkrBclxrdzwnM9YBRKwYiEV96dlBT+yYAI0/0hP3hdn0DwAF+RdO92OJMB7FuKCveT6TsNWKFd54Vn9tjmuD0yJaqpBX7nwrIspgC5LenuEpFe71zJFiq379KGW/8UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amIF8qq04mpK3TebnzDXru0Q3L9XQAWveEaZbgfGBSA=;
 b=wTn707E9M9C7Pv13p6hVgMd0KyqPNRmDgms2drGOWyRol7zlOcvE3LP5s97iEkCe+QIgnOPEHQ2ERERsZ/PDxbD2I5oeUCr1EEHkxSo6bFQhwd6+NQr4Kygo7yvY3u2Ymc8vPm3deitDP47KKsMJHXrIGoNog30VzZ7mM4JCBW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:23:43 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:23:43 +0000
Message-ID: <200375a6-8b3a-472a-88ab-c1b970c4d519@amd.com>
Date: Tue, 23 Apr 2024 13:23:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
To: "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240423062853.1022925-1-Tim.Huang@amd.com>
 <5456f6b4-7fc4-4ac1-b85e-cf3b00b5c4c6@amd.com>
 <CH3PR12MB80747050F8AAA33C6F32851DF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
 <CH3PR12MB8074838DBE40AF8978A976FEF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH3PR12MB8074838DBE40AF8978A976FEF6112@CH3PR12MB8074.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To MW5PR12MB5684.namprd12.prod.outlook.com
 (2603:10b6:303:1a1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df71ec4-a019-4642-eb11-08dc6387d518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bC8rbUowa2xJYXh0SENmZElBeWxIZ3B4OVZudkwwMW1YYmRLWDhsQVlsRU5t?=
 =?utf-8?B?ZExOeDhlUG5hY01PbHhUc3BUaWFrb2hQRVRRSitJazJNZ2VqZjhITTVjVzhY?=
 =?utf-8?B?VzdIZHZGeHRVc3RkMlNxL0lKanBqdmd6dGwyQ1Z0M1dFYldJZHlYSllEMU9H?=
 =?utf-8?B?Q2lLTzFHS2VRdTdhWDI3V2NsSnN2TDNzcmppVXZFUmg4WHZ2aWVNSWUxN0pt?=
 =?utf-8?B?anREc0theFhMYXJXVGRreGJSbi9xS0ZTY0gxK2xJcFpXeGo5eGpWalJuc29q?=
 =?utf-8?B?cWhwT3pUU2dvQzdJTVlWRmNCSVFBSHcycy9SRW5IcEl1RUlBczRCeWdNNjJP?=
 =?utf-8?B?REFYZnlMWWRyeU14aTA5Q1NWSTJUQkVUaVV0RGNEQW96anJIbkpWTGRBTHJh?=
 =?utf-8?B?QndsbDhXWnBvWjNwNzlMUkdwc2xGVU1yZ0FISjZ6K3hpSGNQdk0xL25lWDFE?=
 =?utf-8?B?UDlwdFpjcnV0azMyYjVLR3NQNUJVOWdEOEc4bGJUc1AzbVVoY0MzQ3RPNTZ6?=
 =?utf-8?B?TVhmYWkvYmxnRWI2SHlKbkpQejZ0RnZTYjV4aWg1WDV0WE83ZEVzd25FZDlW?=
 =?utf-8?B?R0FWMFArQWFZNzE0ODFiL0I3eDh1R2tLMUhGWGFsUGtPVW9OUHZnSllPQVVh?=
 =?utf-8?B?c3Y0U1cwWDdqYUo4YXB5SGgxczJrM3hpUGRlaXBUcTU0ak1UYWxycXliUmlh?=
 =?utf-8?B?K1hvMy91aGU2SnIzTjB1YmUyMDdtT1c0Qzl6R1VRWGN4b1Yrb05zVHI5Vmh2?=
 =?utf-8?B?Q3licUpVdU00S2UxUlhiZzNtQkVYSnZSZldmTExzZGEzZExRV204RWlNaWhx?=
 =?utf-8?B?UjdVZjlVTlB4UWpOYzUvdVM1ZldMTkNpRUxVL3I5WCtBL2JleS9FTEF3RjhS?=
 =?utf-8?B?MEpFcVl6TWJOVVZyUHJDYmhNSHNpMWM3bk5NeXR5MXdTTHJNVFFSanFnU1Rs?=
 =?utf-8?B?U0lYQ1dNYm1HcVAvV2IwYzdGYUVtZEo0S2NyNFg1N0tHTm5XMmNZZVlVbzJw?=
 =?utf-8?B?YTF5bE02ZHM5dEdhZGN2WlB5VFFlOUdYWVNhZVJYa0lDWm9FVG53WGd2TVl6?=
 =?utf-8?B?R3hvV1VWWE5OaEExV2tlTGYrbUhiQlFEQzRyN2dqSDIyZkExdi9mZFp5cU5I?=
 =?utf-8?B?Tkg0VURyMXNlZmpiZ0FNckxFWklnWVVsWFVEWFN6NGFidElwK3p0QXJwY3Z2?=
 =?utf-8?B?V3hyVGU2VGVrenJyZWFNTi9VSmJ2c2FBa3pia2xSSnhVa2xpSkJHNFFya2t3?=
 =?utf-8?B?N2x0c3JRNEJoRjdaZ1h5QkRjK29yWE5Sc21vSzhybld5VnRuUTZxQXZOamRu?=
 =?utf-8?B?SzBZUk91SkZTN3RHWExONTcxMnlKMUJGMm9ib0lYNVJ0SWo2MHR0blBtRllS?=
 =?utf-8?B?cnJEN3JPdEtWS2gyU1dwMTlOWDRWMkdvaG1BcEhJWUljeXlmSm1ldlgySGE1?=
 =?utf-8?B?REpScVI2UkJhK0RuR01UVGV0K1dyUE5iZ3ZjTlMwNkRqdEljL2lWRExKV0V2?=
 =?utf-8?B?S25jMm9Rc3daL2JLWERKMnE2T3pSRDB6M1Q0ZVBUbkgvL0lRWXg3YitjZDhL?=
 =?utf-8?B?NHJxMEsxelRJSGZHR2FRUDZpdVpJSXN4citCRHA1MUxxQytWeTBMT3NTSGVn?=
 =?utf-8?B?L3dZT05KVWo4b1NRTDZON2o5R1dqMWk4OTI4SEN5TXZvcGc1dmR1Q1NJaE1G?=
 =?utf-8?B?bDBnNXNPL1FycDdWdTVPN1UvREJlSVdBdVBTT2FnaE51ajA0KzFQR2RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUY5SVNGaWgxTlFSV29RblZ5Zmp3a2pHN29GZDJMRFN0OEd4bUZISkxkZXF4?=
 =?utf-8?B?emErSzkvcEFPTm42elZFK1dXOXZtZVJTU2Zzbm1nRy9vUGduVWdYbVBpVHhF?=
 =?utf-8?B?bXVjNWFyTlJSL2NkYitYZE5oQkZNOXVMSzE0UzVwUUpxdVN1UXArNEFZdlZF?=
 =?utf-8?B?dFNsUjJKdUtYRmV2UGpBVWZHQjlkS2lGUXVybHpVQ1NNUi9YVnJGV3YvY2Zj?=
 =?utf-8?B?TXdOM21RNmZ3TkQrRkc3SXI2VjNramZDYkdCT1ZyY2VzQy9pRlp3WnNtcHBF?=
 =?utf-8?B?dDM1VVAwK0c0VWJHTXI2VnNhd1BTMFFHVGljb2xrZmFEZE5NZGVRcVNkWVBN?=
 =?utf-8?B?alFTa1JDanZzalQ1MFhzZm1id2Y0ZWFLV2RZYmtMMVFITllnZ3dhU2tPOUky?=
 =?utf-8?B?WEdxcFVaWW9TclZnSFlsN2lNVUo2ay93Nlh1S3pZWHJKWCswdkNUQXIzakQy?=
 =?utf-8?B?ZXd5R3dBODhqVG82Z282ZU5EVmR2Z2thSXphY3MxSGJocG5OcHJUOStQdmor?=
 =?utf-8?B?U2RhbUlDcFc4aVgzQXNBNjVRZHVOU0l6eTQwc0JiQjhSSVN0R0RheGU1V0p5?=
 =?utf-8?B?dnJTVFdZNkNoMnYxSUdBemRIcDJZbTJLVEowVmJ3eVBqSWFTVFRuQ0RDcUdY?=
 =?utf-8?B?U0h4VkRBWlB0b3NxeUxKd1JmRUJFZE5BL2RPRzRyVjliZE85OGZEZUkvb3pH?=
 =?utf-8?B?dnFwUkEvemtkVkhqelk1bTd6TW4zN2V5UFZqdWVOS3FxWFl4TWQ0YnZsRXNR?=
 =?utf-8?B?aGRkbzduWkptQ2I1NjBXbElGbm9lWTZqSzRIZWlUS1ZsQm8wdksyb1VEOGZW?=
 =?utf-8?B?by8zSkpZTWdhZjBCa1lWRmZnL0xNM0NDWElsZVo0ZXhRYS9GTjF5WWdqNHVy?=
 =?utf-8?B?NG9uMDdBZWU5aTRSa0N6MVNEbmFqNGRYUXl4SHlWczFFS1N4T0xuSnppa2dm?=
 =?utf-8?B?aVloM3V0c2EvWUEzZHFFQ2RxSExNVzBSOVJrWDk4Z2tINXd0QmdHQ2xXaTNl?=
 =?utf-8?B?Rmh3dWxDTUlVbk16TzJGd3JHRE12QW1oSU1yOHoyVDRyWUk0cHRVbi80K3R0?=
 =?utf-8?B?cjBCdStlam40NXRnZEt1cFY4bnNXOEJMTkV0Z0NIVzNuRzdvNjFmdzY3Rjk3?=
 =?utf-8?B?eTRJbkIwT0ZvU1FRVmgzcGVwR0s1K3pBU3pEVjlvSEhmNncrRTA1eC81NDh0?=
 =?utf-8?B?dlN3TmdnZGtlajM1eEkxdiswSFBYSjF5aW1pM2V4TlA5dG04QVpGVVk3c2tP?=
 =?utf-8?B?Z0J2VlRiWnVtT2xQclpTSVdzWDNscjQ3bndmTVpvWSt6UzVxeWllZk0zYlBn?=
 =?utf-8?B?aDgrbXdoQWtsMnlaSVBnMkpTWXE0RUZOYU11NGxEUCszU1lDdkNDWGg5UmlT?=
 =?utf-8?B?VHFNQklqcUV6MkwwREFNYWlqY0kzclU3TEhVaHNLNHNuVlZSVFBLNS9uNnVq?=
 =?utf-8?B?aXhDMTVWUFBWczZGamc1ZzVhcDRkWktSRVFZRFl0VnQ3ZDB1VEFzQlNmSk5M?=
 =?utf-8?B?RWJIYzE3UUE2bFZRbzlPeVpvMndLVjU1c3FJUy9rNDdwOW1Ia3R4ZHdBNXVU?=
 =?utf-8?B?TkMvdkljbWJNWmJzT0FjL2RiVXRsSzRPOTVkVU9xczdKRmFxL1FaYmI0R09Y?=
 =?utf-8?B?Um0yQ0ZIODJGZTg5S2J6UTBudEovbTFMWTFuL0RLd3V0dnVsRm00UHFRWk9n?=
 =?utf-8?B?Ti9UV3hXYmpwT0JHWXkyMVNDQ0dDUjdESFcrK25ySnRCRHZ3ZmhpRDFXUHNx?=
 =?utf-8?B?b0hKSy8wQVhKMmF5dGdvaFc5enlpRStnUE9oOGxIbnpPRXRiYVUrK0tCelhm?=
 =?utf-8?B?S3NLejFFSVNJMWVvRjFqSmZ1SndsN0UvOFhzbFg0K3FwaCtBSDFlcVEwc0lH?=
 =?utf-8?B?dzNmdlowMjREUHdlWGs5bFJrR2xvUGkvZjBzc0oyVnI2bVhUVHVMVzhoTHha?=
 =?utf-8?B?WFFwUXEzc1hvTG04QVU0RjBNYVRSUmtDL0lYRkdHc2NKU2s0Mzd2TjVvMENB?=
 =?utf-8?B?Y1Q1T2d5WTFtaEM5SVFyNkR3MU5SSUNTZmpkWVcxMENJOU9pdWI0c1A0S3RP?=
 =?utf-8?B?SGlLNkdnR3hqelowUUhMakVkZUl5dWdsK0lhZDlFWWNranl1ODcrT3hMVnF6?=
 =?utf-8?Q?w89Y6pM1v3y7N5LWVqo3dDCxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df71ec4-a019-4642-eb11-08dc6387d518
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:23:42.9303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqvi3rcu6W/G7DmnID0ttQMAfCy53bbNsgdtF4FcJAYG9f71/Q5UYp4Rq7PIafc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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

Am 23.04.24 um 10:12 schrieb Huang, Tim:
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang, Tim
> Sent: Tuesday, April 23, 2024 4:01 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
>
> [AMD Official Use Only - General]
>
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
>> It's a warning that reported by the Coverity scan.  When the switch case " switch (ucode_id) " got to default and Condition "adev->firmware.load_type == AMDGPU_FW_LOAD_PSP", taking true branch,  it reports " uses uninitialized value fw_size " by this line.
>> "adev->firmware.fw_size += ALIGN(fw_size, PAGE_SIZE);“
>> It may not happen if we call this function correctly, but it just clears the warning and looks harmless.
> Hi Christian,
>
> I think it more to fix this warning, maybe I need to print an error and just return when go to the default case of "switch (ucode_id)" , will send out a v2 patch. Thanks.

Yeah, exactly that's the right idea.

Regards,
Christian.

>
>> Regards,
>> Christian.
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

