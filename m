Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE6FC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1AE410EC3D;
	Fri, 11 Apr 2025 17:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1eVaCw5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464D210EC3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXQVmPxU4NxA5hJ4+vpf6KocVcmuJrFweTUWo9F14dI3+VgReTiwIeNPGVFr80AwC6pPEQ8rps+TUWnv5E+aXIa5KEzFqM+Ef+8WAlHveDkWVr+QN0+o8sCIbS3F+up2m0gmF3q6+aocgwHAc1wkpE753wKqrvdlGws95NJnFrAXr7uBGhEYg6q8b+wvjScdwikYCBdQAoqdKSptZuXhga3GJBMlRzTSXUdGdclPom8Uooz/9FPEYjJ4TDSZfaEqG34FcppLgraSid/8VJSnWw52ewETVWBAOcqSwO3A8wrmJDwCLvQ2Dl9kCGJOrqlSo5Udkkx7ENlVeqJZTjfYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA1Hdi3JUfCLfnNLw1ensDsfGDJ7zGJ3ocxnOFpZ2GU=;
 b=cK4uqVPXCXE6+SCk7fHLWKpxIZ5TOhseCdm/y35BdK4tUKBnVJ7e++95TjYQPzMZBX2Up0FV13rfQNe36Urnt/BeO99vYSU4fpmQRpEney99nIqDQyNNgymIlLEiU/KUuMH0NFhcokQb3jUTnihsTXE3QIpdPDrhBhqRHdEjmZXAFPTNxcP5a+Oj3g9EVhF4cpHFKY5/H/kB8o7+UwIiwqTeyB0OXGoihOs67P9Ya8zRlvnu/xsdBMrnGcgo1eQB1rl0OfqE7r2fYCG4Yjt5tCaiJbGeh5wvJ3/nMQK3G0ByaBwfBrqPnk/Qpv9yFixWJGZDh28YuGxbeZAtjaqM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA1Hdi3JUfCLfnNLw1ensDsfGDJ7zGJ3ocxnOFpZ2GU=;
 b=b1eVaCw5M9ysPnGmgQCyyfwTIbpk9A789iWk5KJhMzUuQoy3P1hY3IaWt6Qa0FRKD/cRxXUDHT60XK6kFn1YtZNR2lcM79z/cH8AZ3DG6LGWgU/MsjI3npdO80YQvgHDkUN+QBul31lSJ5Zjc9tzkKbwpvi7qHokEkqfAnKZ8W8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:14:14 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:14:14 +0000
Message-ID: <99c82095-79d5-49fc-a682-7da8d0ffe4c0@amd.com>
Date: Fri, 11 Apr 2025 22:44:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] drm/amdgpu/gfx11: add support for TMZ queues to
 mqd_init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-10-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 00244b75-662d-4efa-8bff-08dd791c48a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnNsY0kwNEZSYVlyM3NyYUJyN090ek9QaXlORG9nWnI2RUZsb08yb1NZLzl5?=
 =?utf-8?B?NTUrdmVla2lyT3hEb21vQjRaTUN0YnB1V2g1dDc4VkRJdzhGU3BOdFBTbThB?=
 =?utf-8?B?bXAxOGhBNFNtbVUyN1ZSZmJjSzVrdFhVbWFibExmOXlzeUdKOGxUcHFyZFA4?=
 =?utf-8?B?YVpmMzZEdTZpZGZVMEREcVhscGxNL0dzdzhMT05CbVN0aG1FR0hpMnR2NFZ3?=
 =?utf-8?B?QkdpRlZaOVZVS1RBcllJem1aTlVoTytTSitmdXdJUzhBVkNyRkJOcHN4bnVn?=
 =?utf-8?B?WFNRSnZJTW5wL3llRzNiNStRMDJwYUJpcEFwZVU3anB3Tm1WWXRkY0doMmp4?=
 =?utf-8?B?SWVOamZUQ2xaK0JjOHNubFkreDZjZGNVNXlia1IvVGUrY1FnNU5PbnFVeEhR?=
 =?utf-8?B?ZFJLbXAvUzZOWUJaSEN2czRoSnNXRjhZT3ViQkkvcXZUbU85UXVFQ1ZmdDFk?=
 =?utf-8?B?czNOci9ZRzNSRXFPWktoaG56RlZCLzJaVnVrSnhwakZmNDBUaDFYWVV0L0VD?=
 =?utf-8?B?K2hiaDl6eXUwTVh5TTVyK0lYQkR4SE5lN0Jmb283VWJEeWQ1d040WDNyMEh1?=
 =?utf-8?B?cHJPM2xlS0FNYTFxZkRIalFZMnV3bjJkWTRXTzVHbktrcFVZU3ZGb1pKcE9F?=
 =?utf-8?B?b0RmMjJVbU9GZllYdWUvVG1OY0dsN0NQRXA4UEhjUUV4YzZQZ25aOGVpZ1lI?=
 =?utf-8?B?b2ZQWGpFcjdMSmJoYmRIMmU0akZHS1lLWE8zTVYzWDJZR0hwZUlvUTlwWlRU?=
 =?utf-8?B?VlY3MCtOMzZoM0dMRUY1ZkJFTXJqUnNRVjRTNmhtQ3ZhR3hhK3dHcER3MEZJ?=
 =?utf-8?B?VWdiMU1KaFBrMWpMNmV4MVVjQXovTDdrMUFXakFNTXl0TmYyak4rbS95TWI0?=
 =?utf-8?B?NWhtc3JVZWFtOWJ0eGJUa0VRbjBqenh3aG55MUE4QndXRU02cVk4RSttMGxl?=
 =?utf-8?B?ZjQrYkRZUjZHZEZkT1pPNjZacjczdkpiejBWMFQrNHJYVnlkdFZWVlRKWUpi?=
 =?utf-8?B?amlEcjdMQ0RaWTh0MUhoaW9Kcm9teTBjSTgvSjdMd056c1hvNzNmUTRMa0hP?=
 =?utf-8?B?bmdLNDZyWUJtbWlXSHJBTWZ2OGYrOEJRaHpmYTNuUVllVVA5QmwrR0pNbk9z?=
 =?utf-8?B?S2JGd2huY09JNVkxVVU5SU1HenZVakkyTFJVQVRLM3FNNFF5eXVmd0I1MW0z?=
 =?utf-8?B?b2NLTmdhdm5jWFl6TFNvdXFUN0lNVTZTS1llMkQxb3Y1c0t0VmRvZkNqUG5r?=
 =?utf-8?B?VUJXUTBseUhqUVA3cGtRVkhKamlra0hDRGpDWEVBeERnVGV1TGx5OERYblI1?=
 =?utf-8?B?Zk8wSW9XMFY5M0FIQXd5aEZ3aFhmS29pdlpPOHpmM2xoeXVHRTVjSDIxN0FX?=
 =?utf-8?B?K1ljT0l6MlpvdHdJSFdJNnBjYjFaV0xzVi9OWGtNVzg4b2hrbHFJWkJGNmg4?=
 =?utf-8?B?dGFFbW9VdXRsZkY5WFVHWDhCQTJQekdzSTRnYm1rcmFKRC9lc2c5eVdsQjdC?=
 =?utf-8?B?NzFRVUxTN1JMa3FlL1dDbHo0QjBIZk9CYUtTL3IxUUgyNXU4WTN1c1V5RjAx?=
 =?utf-8?B?QXVGYXZDTUhjRWRQR0lzc0dldkx1NjhXVFZDcmtCTUE2VHh6M0F5ajhvR0dP?=
 =?utf-8?B?U0dHNENOQjRONFF4aE52dFBSaW9pNnhPZ2hDWFZ4NVVSOE9qNHROd3FWVEYw?=
 =?utf-8?B?YlFuallVVjJrc2F5aTY3djd6ZFZjYk9vVEZQajFhMG5vT2ppd3pTL1ZCUm16?=
 =?utf-8?B?WUVzZFBDY1RsTlRqakRLZmZWcFhkc09RR1I1ekxjZmR2b2ZXVHU4bkYyeklV?=
 =?utf-8?B?aVkrKy9JQktma2VoWlBTQmxmOXh2Y2pSVElTVDhKZVFwSkRFMXpOcWxYSmlu?=
 =?utf-8?B?QkFDSVE1cDJEcUhKZlNaWXFSZ1UxVUdzczlBUVBBQSt0bDdwRzhLVXUwSHF6?=
 =?utf-8?Q?sr09MDUDrxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE0xSGU2Q2JtOUl2OXUvd1hvTlljTnIwbEZ0NXArdU9CUkUxV2NCeUZlZXFu?=
 =?utf-8?B?MGpPOTFhL2ljUWQ1dkdkUEpLVFJ4b1BWcU5mY28xc3ZRZzQzQTJRNDV1UE9x?=
 =?utf-8?B?ODFHVklGZkJINzkrTTRqYmxLWWRvRERVR3NodTY4UjBTNDdvcXdpZmd1RlZS?=
 =?utf-8?B?ZUNiUkxFQVdYamhsNGUydHJCSU9mUDJtMEpWY2E2VTJjMEZOTGtCNlJyRlhx?=
 =?utf-8?B?cFA2MStWUDVwYXNCNUpCeEppMVNjYUgzYUNXS2orR2wrZDBEQWhmYXlBZG9T?=
 =?utf-8?B?UHlhR1NnOVJmM2pmbXE2Mm1aRk9CMEZBM3FrY01pRUQwZjNoN0hvc01lR2lL?=
 =?utf-8?B?RndROVZ3dEJMSFhQdWRXbFFxWmhZSHVQcG9SSmFNTTdYV29BcUNEVmREd29G?=
 =?utf-8?B?Z1JDL09xc2xEWUkxOEpObmxuQThMTms2U24xb25EQUJUdjZ0QjdUVTBHQzI2?=
 =?utf-8?B?YUpIb0hoRUwweENKMDhrbGlINmVmWnpLMFRFSy8rVnhTNGtyVzB1ZUdTY2k0?=
 =?utf-8?B?b2FJQWtCN0xWRk4reVVicndEZTBDYklyUEpORldOd3RWRi9mREx2L0lHS3Fx?=
 =?utf-8?B?RHpTOSs2d0hkZ0hiWEZrRkw1TDNobjlMNm5YeHBQN0NBRHNKdm5GRll1NTh3?=
 =?utf-8?B?Z3VwZGxQYjdXQUtRR0V5eVZ1RWl0VFdwNFBLMnM3T2ZJOERGNzRjTUpKZllZ?=
 =?utf-8?B?VHZVaUpxdjZBQ05pbjV0SUNHdC9WZ1ZJQURoN3dNNGJqcFNIS1hQenhPR3Mx?=
 =?utf-8?B?TlpGYWd5ektYNkhEQVFVWkpLQjNUS1JJeHQ4eEVIY3RpMFQ2SGpTeU9xbWw2?=
 =?utf-8?B?K0QxcktoSlI5ZU1Dc29leXN4UlYzMmJNaWNsbE1SUWM1SG9hTHQ3Ulp6dVZu?=
 =?utf-8?B?by9KaW5oYzBsU2hlYk5tcmVSMFBJMlVpZWV2K1lkYUtNU1l0ZFJkTmFYemlW?=
 =?utf-8?B?d2ltU3VsSG1RaVJJK2hIRlYwNncvTk1vK1hlQUEzekNLVCswQUQ0T2NRYlkw?=
 =?utf-8?B?c3VadzNIeW5YZnFHQWNRWkkzWWNFSmhVNERhWmVDWkVpYkdmb1ZtVFhNQWpL?=
 =?utf-8?B?UzcwOStwWGMvRlp6NVM0dlZrTmM2SmtQcVpHa2V1YndNZzB4aGpraXBzSElt?=
 =?utf-8?B?N0Via3NEVUZqdlZPcGpjTjlFQ2dnYVNFaUdIa2V6N1BZaFVZSTlyS1JSd2da?=
 =?utf-8?B?OWNCZzZiNFFiV3grZFNMaWNZWlVid2NsbTVlcG10dW1mSllwZmh1eW0wdHIz?=
 =?utf-8?B?djhOc1NWSFNaVzNvWkdKVTI1Y2VsWDJxc3M5N0Q4NGN0eHpTbGxjdi8vTjVY?=
 =?utf-8?B?azluQ0x1WGE0bm9QMUY2RDBjd2FlQTRoVGREc3FvM1FQQmM2T1pjS00zemtw?=
 =?utf-8?B?Y052RkJwc2RHcFpkT1dUdDdvQUk4anlhbi9lZlZiQ0FBRU5SMk1GMDdpL3dr?=
 =?utf-8?B?VGxweC84SzkvWGdMcUZVUlU0Z1dRbm5EbDRhQUhSVXcrVTNRb09DTU9PRGlO?=
 =?utf-8?B?ZGdvN21yNk9CbE0xeENTN3JpM2k4RFA3dVd1WGRHRnBiZmhGWWdHQWhLeXJw?=
 =?utf-8?B?WWVzN1RoVXJRaEVoYVRDMkluZTlxeFlSQTUwdUtIZUdzN2xBNCtpVEhkQ1dY?=
 =?utf-8?B?RmY1ZGg5azZ1TG5QUWZ4WmhlUEt0TldNYkJWQUFUY2dVazRUMVhYUGh4TmZ6?=
 =?utf-8?B?OWJRY0s0T2FVSWo2U1lSTHQwRkpLbTBRWFZOWUtaS1Q4QXltT0EwQnhsY0Rl?=
 =?utf-8?B?TVVrVEF1aS9ucUc2ZUVjdVVpcWxzK3ErZzVaVmdpZGVOa1hSWDRnQzBlUUJu?=
 =?utf-8?B?OXNvQTg1RE4zWkFha05mNG44a3NWMkhnOXpRZHJhK1Bxbng1Y1pjcGJTV28y?=
 =?utf-8?B?WnhNc2pLbXAyVEVXTFh6OGlBenhvYXRiUnJDdGxOMUV5bmFSMHVFQm54YSs4?=
 =?utf-8?B?VkdzcnoxSmUvNnoybmJsRUloK241T3Vxb0tqaGN3eWZxZVBrQzFULy80MU1F?=
 =?utf-8?B?aHdiaFNRbDFaMVNEbUlBa003UHdFTGgxcDBpU1pqK2FtcEYzNU1aSml5T0h1?=
 =?utf-8?B?STFYZlFxSHpMK0JvbVc5T1dFSEFxelAxQ0Yva2p6Q1B4L0krVmt0RGJiSU5v?=
 =?utf-8?Q?mHV8Y/jDxxZt2ZdA1ajqXybuk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00244b75-662d-4efa-8bff-08dd791c48a2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:14:14.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7tZCFbCgJPT88jLYDMFKMzXs43XvUFomN2fbV/jdMabkV6YU7TED9TgdoxHl4oi4V7qxzOM8kn4sdz3RUU3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Set up TMZ for queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 91d29f482c3ca..b204d0e6e816d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4114,6 +4114,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
>   #ifdef __BIG_ENDIAN
>   	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>   #endif
> +	if (prop->tmz_queue)
> +		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
>   	mqd->cp_gfx_hqd_cntl = tmp;
>   
>   	/* set up cp_doorbell_control */
> @@ -4268,6 +4270,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   			    prop->allow_tunneling);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +	if (prop->tmz_queue)
> +		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>   	mqd->cp_hqd_pq_control = tmp;
>   
>   	/* set the wb address whether it's enabled or not */
