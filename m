Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361C6CF07C6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 08:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D3F10E898;
	Thu, 10 Oct 2024 08:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GR4BOnLA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE25910E898
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 08:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUqgoFJG9Whjlq5hZ+x+PNYl4U9TPTiKF+BOm7flrWKeWUIY4OxfQuKOtYP+bxFsoP+QQglJznsV0aMKshLBWL9u5rcaXRdLU5E6cM11L/swmzT1KTVcw/CzQwhlV17PRvi8Ur5iM06vkLv74kjo+bfxm4MPwt9kaRXM2pAz1f+3lDIjhAInfBjk2mgDh/J1IPfnP5Zv9hqGJzZjsxxViOEYOBXFbaFN9MfpBcS4//RliMShNTKRXMyP+PcfcfSqGmsbwzFh+qk20cxsOiXx/hLyPK/p+J4JWKGd9V6Hr10lQbuz2bAnozCOGbl+xBuATV2nc6xhEhEhw2MCCixdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z32Mbj+Za9NTzRMsRb5r0TFtY3QMgR8jyWLF5knpvDI=;
 b=dFeW1piK7XScSWRwaI73oo82aFFCyLpsCuWiYGByH4Mz75HxwI84VAhnwdqwE58bXSAohrYLNL1IrPJG/Ak+eE73w3o3v2eDYFdMq12fMIDObndN9GfqQXi+cnT89Da1skw4mLPb6r/Qbe369STdg+xaYYOWZ6gFgg9N7AKMRkYmTZCXWnQ5xjRzMgwGjNdT2cJcP2FsBOJLIeJM5N3sL4y64v2vXhV6jiBhEegDQoSktgFTIcticIEKrox1luXiJ6Nvfkcd5Ls8YXrl/ZnuBHLlk9cQuYvWDqTkEAl700mR1ivZbyrpyzVR0WFTHD0squAL+Ar3mjEFjyW8d+Uejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z32Mbj+Za9NTzRMsRb5r0TFtY3QMgR8jyWLF5knpvDI=;
 b=GR4BOnLAuMuBnTmXxtjfsYzcLLUyTl2vn2iEYT5QDbPviaAwUk5TGXe25JDBzXImdYGukIKY6Vwfg7PdGL+BBuPT3CS27Oc7aL4YE+beALma9+u9wDnYBLhaVTX7b6NHcUMcSPAOB5FMBhgZcGKfo1W726UP1TfLS6lJPvrRRNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Thu, 10 Oct 2024 08:45:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 08:45:36 +0000
Message-ID: <b774ebf7-f191-43dc-ae35-7cfbee126e1b@amd.com>
Date: Thu, 10 Oct 2024 14:15:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: "Khatri, Sunil" <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
 <832aea2f-8692-406e-874e-679bbf0c33a1@amd.com>
 <85fe3fd1-53e3-2c00-d27c-96ed595634b3@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <85fe3fd1-53e3-2c00-d27c-96ed595634b3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aceede-d76e-448f-78ea-08dce907e919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXlCOUpvUTQxYStFT3o2NWNVcklzVGlLQVFWc0hEdDlXeWRnTGRObGczVFVs?=
 =?utf-8?B?citnQzRFTk9vUGxIS0pYZWtmT29tTmNLeTJDSDYwekxGL0x5RWZvdHU0Z0Yw?=
 =?utf-8?B?ZUZGd29UVTNOYVRFclF3eWZMMHBtVW8vK1VJblBDMnJKWm1FUEw3aEEyMjJo?=
 =?utf-8?B?NURWNUxuVndla1R5R21VSGJCYVVjMnFlNEVsamxCN2VreEI2b1FnMjhHSk1B?=
 =?utf-8?B?Mi9nTDZReWN4M3YvVmFxM1hDUzc2dlhnVjR0MjMvMTJreGw2Z2l3RGdWNSto?=
 =?utf-8?B?aUNZbFNHS1kwK3R2ekxnWXJPYTViQ2hUYmRRK25DUHExd1ltaDZURVBYUHcw?=
 =?utf-8?B?a0xENlArYk9oaWQrQzNOMlBIT0I3dHQrWTJLaDYxU0ptY0FQOXduTkkyaFVv?=
 =?utf-8?B?cVVVMDUrOTIyUi9YRGtMdmZyOE96VGw2Uzc1b1lVemdxRytlZFhQVi9qQ3BK?=
 =?utf-8?B?U29sVVkwRHo2YlN2bXZWbjg5cWZVZ3cyKzRBVy9xblZjMFg0NkoyMXN2RWF5?=
 =?utf-8?B?eVhSNzZYVWFuTW55WDB2emJPZHVGcFJDVDQ3ZHZuWUlCZWxOQTdLMkttSTRU?=
 =?utf-8?B?NjRPcmRIRWFSbEVETWcxbDlsNHJnWEVrVTdKTitlZUtvbWJBaXdETUUvbEpl?=
 =?utf-8?B?WlZUeVdNTm5xMzNENnNqNURsUDdPQWYvSEVGUWl3RXZ6eHRNREVCK0VoNkV3?=
 =?utf-8?B?ZDlUY0ZNNVRSVmF6aGptYVZPUmJ5NDQvM3p4MUcvbld1ZGVzRzBXWE9JelI4?=
 =?utf-8?B?K3ptbk84SXhoeHF5U0w3MndLcThGdWFKRUl0R1M1UEpjTHJTVEowTEE3TVVm?=
 =?utf-8?B?ZmZJNWNTQjl4dmZxamVpMksrRW9US1kwaU1ZWThHenVFY2VxUEtFMGkzRHRY?=
 =?utf-8?B?MzVEQmFxMDBIbzhHQ2VXbG94OVE0REhndWZ2eERaWE1XTnJnclVwMGdrN3dS?=
 =?utf-8?B?N3oyVWFtdjBXNkxiZEpCS2RFcDhrcUxoWVpYOWtNOHJ3WGFaZE9WYjJLTXJK?=
 =?utf-8?B?Ync2ZFpEUzFMSmM1Y2I0dzg3ZGxuZEJISUgrdFZIOGZUVHU1UHBUU1JhWndp?=
 =?utf-8?B?YWpWUS9pTFo3aURROE82QlpzMDdGemxTV0greEszcUlCaHVWeXBiM0E5bDFy?=
 =?utf-8?B?TUdDei9KUFFNVk9pZnh1bXVXS2x6OFJOdHV1Q2czWno2cjhZSkx4WHRBd25m?=
 =?utf-8?B?QWtjUDh4dnE0c0FOZTBOVWlTRjhjSzZ4TytkU0UwTkdkbFFsV2ZhOVA3aFZP?=
 =?utf-8?B?Q1J2VTZJM3hUbUFPYWhWeEx4ODlwQ0Y3L0NOZnA5d1dkeG9wY1A2bkJkVU16?=
 =?utf-8?B?U0lyVkhaeS94bDU0cGpnWi9QaDh2MTdsREFsaCs0UHJUdWpSd2VvcGRzYlpG?=
 =?utf-8?B?cWZDdUg1dk1xbG42NUM4akJyY2RoeWxMYXZnUFc0QTRVaUdrZkp2MytQMzg0?=
 =?utf-8?B?UFBLai8yS2ozbEFNOUQ2RStYK0ZOV2NDbWtMMDRiWlNlWk5ZMmJ1dzFQMXVD?=
 =?utf-8?B?L2s5TXFOanIvYVdPZ1JMUEVDalBHOG8yRGFGblhkVDJIQ3VCTXRTWGsramRy?=
 =?utf-8?B?bXg3VDViZ25jUmdTVGRPUnAxZW9tblVEd2dyVWFQYjFjQVhVWTB0ZG9xdDE3?=
 =?utf-8?B?dzQvandFZHhNVERMaTljUGdnNnRFeCtiMGRUOFl2NGZDUkg5VGVqa0tpT1NV?=
 =?utf-8?B?MldpK3JFMGNUVXY4QlBMN3pZTUN6V1F0amk3enpJVGhkYmtwaktTNGJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEVQNDQ1MUxCQ1lOMitQQmFYaW9yMWdZNVBCdmtYbDNrODdBbkQ2WmhKWjk4?=
 =?utf-8?B?UFNLdlJCa3dVMlpsNXY5WUtrMVV3dERFZm93YWpFMHBDNDlCK2JZL21aZno0?=
 =?utf-8?B?ZTJSOE9nTDhtd2JmRzc3VWtHOHZPbk1Gb2IyVTFaeitCR2VKU2xISkhUMmNG?=
 =?utf-8?B?RlRPUS9BNlRHOElqUE5wSWYwczZWVnNUeVpjeTRiVHUxTmp0UEVJUjQzcVZP?=
 =?utf-8?B?Nk52QUJxOHFUd0ZpNjRENDhqVkVHclZsMDg5YVY3MUpkbGRYMnNQWWdDTDVB?=
 =?utf-8?B?N0hPSkI5UlczbjlFa2pCVk01d3h0TWRuc0NOaThISGhGM1R5eFRPVXUwT2Y0?=
 =?utf-8?B?M0NpdXBSSVk2TjF1ajQvVlVVY2E4YVJOMHQ5SWJVLytaRHd3VU9ZaVRuSkhx?=
 =?utf-8?B?ZlQrMFIwUSsxNmpzWnZTZTNkNlYyNEZRVElaNUw3a29jbFR1d3dnTjdrSERV?=
 =?utf-8?B?NWpCZklzT25KK2dpVS9YS2tKM1MrV0dJQkFqcVJ1Q3JFREZ1b0lCUTV4LzJZ?=
 =?utf-8?B?cTN2Nm5PdGVwaVJPTDFMTEI5VlFLOHNRVW1pOVZOQzQrK0VHRzFkTkpBTVVV?=
 =?utf-8?B?RUhKanlucm4ySFZJU3N4aFIzMnJBVHpjZk9XMUZaZVQ0TmJIbjdZWXJBZG5N?=
 =?utf-8?B?S2srK21naFp0VWpLMFlTMVk3NEp1Q1p2UURlRHFQVHRsRjVKbVYybHVWT1p0?=
 =?utf-8?B?M3ZGWTN4aUgxK1BTNVZWR2dUQWlSclppOVd6c2EyQitFMW1sNUxjeU9XY1hC?=
 =?utf-8?B?NDZRSUVudzdVOGVPWWx0T2dxeHZ5aUlHeFIvYmFXMlF5bUtRLzlWV1FRZDhp?=
 =?utf-8?B?VFg3bWM5eXZWQm92djlBVDBLUVlDZUZEdFo2cEZHa2RMY3VKUTRPMFFLNFF6?=
 =?utf-8?B?bCswRkt2UkVscDRRY05vNEFnWXVvTlJYRXVBL2JwVFRPM3hLVEZaZm9RcHJC?=
 =?utf-8?B?VEdiNk1tbGI1d3hUQWlLY1RqYTRzMVlYY3pSQjVHbkFiZXdxcGgreXdYZVR1?=
 =?utf-8?B?RWZSTFNQUCtzd1B0Y2lRRGxSZEVLeXF2dTJaNWxSbVJzMVRyRXZUYXhhQlF4?=
 =?utf-8?B?MCs1M1dCaVpWOUxiYUszUVZ0ektrRVplRStzbms4TlpzTUYwUzF5Sjg3N0Zm?=
 =?utf-8?B?a2xnMWNBSjJvVittSWRrcDNFUU4rdklUUzBOOHdRVzJPSU14ZGRaVmNZdlJL?=
 =?utf-8?B?OC9OSi9SbyszRWZMVm8xbS9XWmpWSTN0VXdoYXk3VDlMcG5VVVA1Ti85M2JD?=
 =?utf-8?B?N1pRL2VsTWVTQ2ZYT2xkZ1NSRGYvaUs0aTBYemhEdkh5SlZta0VqaTl3SkZL?=
 =?utf-8?B?ZndHdHliTW5QV1F6SFpST08ybi96czZrTkxhV0pleTdncDNaSkEzb2FXaTBU?=
 =?utf-8?B?UEVUUjNiTldZdDA0dTI0RVBwZ01UZGc1SWNTZ0Vjck81NGJNek1qdjA1c1VI?=
 =?utf-8?B?cUZNQ1NHVlZXaHR2ZlRCL0dGdzdmSi9BTEo5VzdSaTJxSjBGUVp2NWo4TUFr?=
 =?utf-8?B?N28xTytBTC9STmoxMnhNYVZ0QWducVlIckRMRncyUWxIVXBKMDhsTUpKTnJv?=
 =?utf-8?B?UU5xamZLeWdZb3MycWV5L3VKTUhaZ05UOVVJOWFPZjdFUWlCblErVG5JR0dt?=
 =?utf-8?B?RmVteUgvekVKeEEwK3FhYWtLYkNuc0JQOTZrdHZQTFcxL3lyL3N3Nzdpa1Zh?=
 =?utf-8?B?K2lkSVRyazNZNXhLSWVWeThlV284TXVUbUUrVld2UnhSMmtHS3NLS0djRjJB?=
 =?utf-8?B?TnFENitzU290YnlJSlhYMUlpcjBhZElQVG1ocE1xdU83eGY2ZDg3dGF5dzEz?=
 =?utf-8?B?L0xwdHNUUWIwNndLWWN1R1NOb2MrU1JwL2dOc2lyd2VEekNiSXZ2RFluUkMy?=
 =?utf-8?B?WGlOWnp4d2UzRWkzSFVud2Y5bGw2bHpwS053QUR3cWZZeFQzdkRjZFhDWkFi?=
 =?utf-8?B?RXBnVzZORHZlYkprL244dk82aGYyaTVVU0hZdjVOR1VJL0lMN0hpK2RaNlV0?=
 =?utf-8?B?Y0VVMi9wQXNyaDV0akt1RytNbzBRb1ozaEUyWEI3djNQVFJGemtnYkt3U2xP?=
 =?utf-8?B?d1M2TmNPVlNlMFVSQUl2WXBjaDU1akRabS9rTmJjQzk3UjlqcnNyL3RkTEFl?=
 =?utf-8?Q?/sZ3lV1757BT5ZA1jfLNwqiaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aceede-d76e-448f-78ea-08dce907e919
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:45:36.8220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzIPGUhF3NSMcKuRY6UwuqMmboWw7FJgXU3Ez5O++kW9yuQFs93DyzYmHTG3ji8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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



On 10/10/2024 2:05 PM, Khatri, Sunil wrote:
> 
> On 10/10/2024 1:42 PM, Lazar, Lijo wrote:
>>
>> On 10/10/2024 1:13 PM, Christian König wrote:
>>> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>>>> Before making a function call to suspend, validate
>>>> the function pointer like we do in sw_init.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26
>>>> ++++++++++++---------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>>>    drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>>>    drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>>>    5 files changed, 46 insertions(+), 37 deletions(-)
>>>>
>> Original patch series is somehow missing in my inbox, hence posting it
>> here.
>>
>> Below ones are SOC specific files where we know those blocks implement
>> the suspend sequence. If they are taken out, then that needs to generate
>> attention. But this check will cause a silent skip.
> 
> Hello Lijo,
> 
> I have not idea why the series has not reached you in first time.
> Second i did not get your point clearly, I am just cleaning up code
> which just return 0 and doing nothing else. I guess those suspend/resume
> functions were expected to be implemented but right
> now its empty and just an additional call in stack doing nothing and
> hence needed cleanup.
> 

In those files, the logic is to call suspend resume of SDMA/GFX blocks.
The implementation is expected for those blocks. For others, it's a
'continue' statement.

Thanks,
Lijo

> Regards
> Sunil Khatri
> 
>>
>> aldebaran.c
>> sienna_cichlid.c
>> smu_v13_0_10.c
>>
>> Thanks,
>> Lijo
>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>> index c1ff24335a0c..e55d680d95ce 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct
>>>> amdgpu_device *adev)
>>>>                      AMD_IP_BLOCK_TYPE_SDMA))
>>>>                continue;
>>>>    -        r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> -
>>>> -        if (r) {
>>>> -            dev_err(adev->dev,
>>>> -                "suspend of IP block <%s> failed %d\n",
>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>> -            return r;
>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>> +            r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> +            if (r) {
>>>> +                dev_err(adev->dev,
>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +                return r;
>>>> +            }
>>> I think we should probably create a function for that code and error
>>> message repeated a number of times. Same for the resume function.
>>>
>>> Apart from that the whole set looks good to me.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>            }
>>>>              adev->ip_blocks[i].status.hw = false;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 340141a74c12..51607ac8adb9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3471,12 +3471,14 @@ static int
>>>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>>                continue;
>>>>              /* XXX handle errors */
>>>> -        r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> -        /* XXX handle errors */
>>>> -        if (r) {
>>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>>> -            return r;
>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>> +            r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> +            /* XXX handle errors */
>>>> +            if (r) {
>>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +                return r;
>>>> +            }
>>>>            }
>>>>              adev->ip_blocks[i].status.hw = false;
>>>> @@ -3553,11 +3555,13 @@ static int
>>>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>>                continue;
>>>>              /* XXX handle errors */
>>>> -        r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> -        /* XXX handle errors */
>>>> -        if (r) {
>>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>> +            r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> +            /* XXX handle errors */
>>>> +            if (r) {
>>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +            }
>>>>            }
>>>>            adev->ip_blocks[i].status.hw = false;
>>>>            /* handle putting the SMC in the appropriate state */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> index 3e2724590dbf..6bc75aa1c3b1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>> @@ -40,11 +40,13 @@ static int
>>>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>>>                continue;
>>>>              /* XXX handle errors */
>>>> -        r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> -        /* XXX handle errors */
>>>> -        if (r) {
>>>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>> +            r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> +            /* XXX handle errors */
>>>> +            if (r) {
>>>> +                dev_err(adev->dev, "suspend of IP block <%s> failed
>>>> %d",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +            }
>>>>            }
>>>>            adev->ip_blocks[i].status.hw = false;
>>>>        }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>> index 475b7df3a908..10dece12509f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct
>>>> amdgpu_device *adev)
>>>>                      AMD_IP_BLOCK_TYPE_SDMA))
>>>>                continue;
>>>>    -        r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> -
>>>> -        if (r) {
>>>> -            dev_err(adev->dev,
>>>> -                "suspend of IP block <%s> failed %d\n",
>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>> -            return r;
>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>> +            r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> +            if (r) {
>>>> +                dev_err(adev->dev,
>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +                return r;
>>>> +            }
>>>>            }
>>>>            adev->ip_blocks[i].status.hw = false;
>>>>        }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>> index 5ea9090b5040..ab049f0b4d39 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct
>>>> amdgpu_device *adev)
>>>>                      AMD_IP_BLOCK_TYPE_MES))
>>>>                continue;
>>>>    -        r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> -
>>>> -        if (r) {
>>>> -            dev_err(adev->dev,
>>>> -                "suspend of IP block <%s> failed %d\n",
>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>> -            return r;
>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>> +            r =
>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>> +            if (r) {
>>>> +                dev_err(adev->dev,
>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>> +                return r;
>>>> +            }
>>>>            }
>>>>            adev->ip_blocks[i].status.hw = false;
>>>>        }
