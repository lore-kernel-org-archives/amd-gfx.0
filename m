Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC1C369CA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 20:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC8510E3B2;
	Thu, 17 Apr 2025 20:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KzJkuqOA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6079710E3B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 20:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1q3+2DHqerR5wFWa/dY9/QPUI8eOOjI3QIcM2DiXm08jezaP3+nY3gxaPrQgVQ1MC+SC9+2LSI0OH/qa/FCzVc1J9OqcDPD8mbZwFaxZXe8YuQ9Fwv7dmyabRJxps0G3UAp5JiL18aqd2gS715HOg+9F6Vy2+UqOkR1A2vlsi7XKXCM4aQ0IYLXxxuob2PhTLoiApr1EbZcpC5hjOKqGAk+Xmv3KkYY6tPVD5MzsEN+4Kna8dBFGbSX1modQv4Ndsobq6BwESyxElVrrnp+QjBcu865BCzG46SmXjKH1w7EtSWPL6aHbk8pPqYHPhwk327wOIKCIQda0bXMM16N+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbLCO0S9AQhWt29phspCINIfFsKiFDKr3CGklvffS+Q=;
 b=uc1zGfbjfe0DwqXTyz7nuHhCHIu7IZlcC6CDrP+T3C6XMB+O9loYTYaSx8H7fAdhP2ZDTVLjM6v+3cuVEYrn2T/vwfLk321iSnjdZBUjD7jQwaniQMW+DHxDUlPWZoEJ1xoZ1DUS3J4BaHE+jaGlO1NlsvI5JEz08bBjFlD89TDhViHXi13/Am4lrGaP2fguErW4TNR7L/ZjkNvAAagLMX9al8pHteYtYEQ/AcfYZsX6AqGDZA1Gv1SluWbnfpkoSqWa2wyw2W4szmBfhAllO6U8dMzwGqljjKc3zk8lu/SOuJevDrcwEuiECWV5kh0Vyvopfzc/e4zC3RmKNlIbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbLCO0S9AQhWt29phspCINIfFsKiFDKr3CGklvffS+Q=;
 b=KzJkuqOAUedBLcfqXT8sIevjQ4uDluqKQWsD9xALOku+zT/bJ0R4CURMd1u9AvBvR/OjzGmdBFj8Xx/nigzT04FG8hpj0dKzGvGKgN6Mh/yVBUtIjG2xXJM4aD6zahWS4wDgZ5w0jYJRTpIyHFZr49cZW2P+iZKckxQBarigZ8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 20:12:49 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 20:12:49 +0000
Message-ID: <7e39f2c1-c1e0-4e5c-8cbb-a31c9f4188d9@amd.com>
Date: Thu, 17 Apr 2025 16:12:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add NULL pointer checks in
 dm_force_atomic_commit()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20250417193026.3760783-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20250417193026.3760783-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0349.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::14) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: af3ae747-39e6-4247-6ada-08dd7dec3992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUwvamVyOWRQSWZvOFNuYXp1RUJpdC95ZUIwRGFZSERHQVZTV05IMFRubnZW?=
 =?utf-8?B?QjJhRlJKTU50Q01nR3A0SDdzMTFGYktTRENiamtyZElvT2JmdWV4SnBKVWRs?=
 =?utf-8?B?emhpYXRWQnR6ZnpUUjFJcnNYNnRsdU5rNVdzeTRpN2thdVZ1UmhWbXFCYUVM?=
 =?utf-8?B?KzNwMnlPMG5pMzhaUjFrNDgxTmxuSnpCUFVXVGRPL2RVYnBUdFY4VWUyVFgy?=
 =?utf-8?B?Z2h5d2Z5Q2dXUE1kS1h1RXZQTFZTMHpuUWZPUEorR0g0UDk2UW4rbS9ReEhB?=
 =?utf-8?B?QXNtZUFtRkJoazgxTzU4RXRwcW5MVEI0NGJkKzVkajB3VVplbkJCMk5leG1X?=
 =?utf-8?B?TlAyQ1ZQejRna1JXdjhyNzdQc084dXloK0ROWTlQQzArY2RKRzNiTGZXV2FM?=
 =?utf-8?B?THBJZUJpUFVlZG1INS94L3orUlhRaEU5dnhFNE02SWpDRVVkWi9ScXYzME90?=
 =?utf-8?B?cE8xVDZ1RnV0YmFUYlRLaUhSbHByM0FwUXErZStpd0NabkRhU3lZaDBwazFK?=
 =?utf-8?B?N1RYUysydUxhZDkveWgwSjJCQngycE0yMHpYMExEcFVjem4zUEREZ3R5a3Iv?=
 =?utf-8?B?WmlRaStJVStBaG52UXUxcnBGVFJJeVhPenNwZmg3V2dORytlMkRkMVA4Wk1k?=
 =?utf-8?B?R3pXK3IxTm1iMmhJTCtGYXhtdXhvZjJINUQvRmtWWEdJZjN6R0hraytZS1k1?=
 =?utf-8?B?dDZUOWVpM2NjQTJZQlhKYmhOV2R6cnhITmRVTXJ6ZGNlK0JWZisraW55NnQr?=
 =?utf-8?B?b2o3bGlzc0loc25OR0NnYnJ0Tzl1MEZLdStkNCtXdjk2blJSZHlXRG95MFl4?=
 =?utf-8?B?ci9WRnIzT2VWN0sxY3pqdWU2NU56cXgyY3dBNUNIS2dud2ZiT2lpa3pMTTdn?=
 =?utf-8?B?a3lJL3NPMi9oNFhQNFdHYWFFVU13ZlNVOWNFSkNCY2QxWUx2SmtjWnBTb2Y3?=
 =?utf-8?B?RVdpSm1TbkYzMXdYdVpMVzM1REZOa2lVNUNwQ2FMK0FMekFORXhSWGRNVnAv?=
 =?utf-8?B?bWJqZkN6Ylo2T0xKTUwyc1ByV0pHQXNlcVRndjc0RWtSR0ltQldiYnlEQ203?=
 =?utf-8?B?a0cwdzFjMkNwNDNBbzRBTTYrQll4MWN3NFhNc3FLMHlySTFkNUpRR09ReSts?=
 =?utf-8?B?VTY5cFhQOEVZWHhkMDZad1o0NFlyeUtlWkgydEszOWhyL09PTG5pSDdnSDBQ?=
 =?utf-8?B?dDNObHVLemtrLzlqa2lpalhFR2VWUXcwMmtHeFZyKzBYN1dHdndUMytmTSsr?=
 =?utf-8?B?ME5jUWVEK0d3N2dQQktYb3BncG82T1prSmZRWHRWS0g3R2hTUmRvaWNXcU84?=
 =?utf-8?B?RllkU0JBUVoyK2lPaW53cHh6cTBSazc4a2d3UDl4VE1SNGFTRmloZzFxUWhx?=
 =?utf-8?B?SkJoaWQ0NHlTNWtodktvMUhESzdnNEIwV0ZZeGhIbnBxd1p6ZnFQeFB5dXdU?=
 =?utf-8?B?UytUcG9naVJuaVd2WVI3Tldxeks3V29WdU1sUDRqYlhtNUVuQms3alFLWnU4?=
 =?utf-8?B?UmNmbm9XSlN3cEhpZld4N3krRlVYME1nK0ZVejNKRjZFbHJ0NTkvb2NsQ1Z1?=
 =?utf-8?B?dDdmWE1PM2ZVaitVbzZXdS9UZ3lPZXdFU1NOTlVFNWI3dFZCOTZEWWk1Q3Fk?=
 =?utf-8?B?YkcvdEdCK0I4aHk1WlZoRGJsU255ckUwWHh2ZzZ0VnFhVU92U0Nkc2tKRU1h?=
 =?utf-8?B?SW9PZXdzYzhkMytybGsvYWdVaXY3VnlCaTczc3FhNzNPbTFKVmxhWkRQZDlw?=
 =?utf-8?B?NDBrdEF5Skx2djl6bW9VL3VIQ2F6UUZpNWh0TE12WWFwYkpUdE5JN3FqR1Fo?=
 =?utf-8?B?T0Zrd0todFUzUTRsanVwbTdIY3dxRjJNZmcrSU44S0Zwa2hPbWNRWDQ5M3ls?=
 =?utf-8?B?OWxNSURyT0pPczBCOGt1THdnOHNpRTFBcHR0WTByVkE4VFJ5VWVUT3hlbVFi?=
 =?utf-8?Q?UucLbQW+XWo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVVb1FLSHpkTEJDNi9HVHBLaEFlSnJsMG5JcTFjeVJObkVVclRSVTdkWnc3?=
 =?utf-8?B?TVR3VjQzanl0b0tnZFA4YU9ISXBPYkEwY2V0UUcwTklzTm5GeWJsZ1dQWUdO?=
 =?utf-8?B?cjF3THpDVXJhQ1FyMXdOMVhKVytYYS92ckZ5RFZjdlBiTWtEUUJpV0UzUEQy?=
 =?utf-8?B?V296OGFQOFpXaEtxQytpMVZHZzNFY1dPdUN4bHZTNmtuZTRTcUpKRTBwVXNr?=
 =?utf-8?B?Z0RWYndSbEJlczdoYWNnV2hwNzZ3SDdCTm1tYzZINFpOTlU2M3YvOExtS01B?=
 =?utf-8?B?RzdoTzRtY2lkYlY3Z0RBVE9jVkY0Z080ZWRMUUtZZDVZQkVTMCtlUlRoR1BN?=
 =?utf-8?B?bkdRZEFZMlNmQmlGeGZXNHdZbG1pVUVyQ2VaRXByOWNTSjh0ZlhRM2NVS3Ey?=
 =?utf-8?B?cnV2RStMQ3cyK21IUkR2Y1BLd2l3N0ZCeGU2ZHFiUVRKS0s2ME93ODNTT1g0?=
 =?utf-8?B?Tmx5Mk1DWVJFcytpTGNDUEd2VzdPcWpxbXB0b3lkOW1IVlJZQkhyK2ZRbVlO?=
 =?utf-8?B?NGJ2eWUrYUpLUGtpVTgzWkZPQTJrR2sxZmsrRzNMZFdrQ1UxdjZOOTBBMVda?=
 =?utf-8?B?SkxJSEFmVEpRbDNwSTVheUdoMTBCVGxCZktIUmZKd3JIOUc5NFBLQ1hGaTcz?=
 =?utf-8?B?czlIeWsxanNpQ01PWGozdUlpWUpRZXhzdEJpUytCdWg2c1VoVXovSFRiSUY1?=
 =?utf-8?B?RnRaSDRCZjRvVjVKUkVqV3QwdzVON1VwTlJMenV5TUNzblIvSkdKRGlnMnlj?=
 =?utf-8?B?Z2lPWjhRVXBLOXR3cTRlY1h4eDdmQzBXb2ZFOXRMNVA1V05uckZxSjlMMCtQ?=
 =?utf-8?B?SkhLN1RqaUJBZENNZ0RQZVEwZ0dmSmlMUXRURGVyd1Z3djZYWmpaR3puY2tT?=
 =?utf-8?B?QWlJb0RwYlRYbEhXWkdkOGhYYnpIQ0Z1dzVua29MVk5IMTFCdytQdWN1bC8w?=
 =?utf-8?B?WUJxR1JIMWV5SWR4VTU0YVFSSDNNZUE4WlRZTlFtbUJPaFZHT3BEZEQ0eXVN?=
 =?utf-8?B?MFJlZXQ0YjVYWlIybDQvK3hCS003RFZobkFlZ3RXY29obUgvTEZWbXhWTlNG?=
 =?utf-8?B?NmRUdzFrQnNEb0dQcmtjVHRFV05uaFdQN29jejcxcXlLeE8rUURxOFRGT0J3?=
 =?utf-8?B?YlhMK1BWY1lHK2hkMjN3QVNLYW1OU0plVFV2cHpER2lJY0FCdlBPeFdNOExo?=
 =?utf-8?B?bUJNWVNsVlVKTUVUTWRkTy9rTVJkK0NwOVE3VllCeHhqcUpUMitad3hPaEo2?=
 =?utf-8?B?cjBGYmRjbWlYMWkzb2RmYkEveVVtQkRnSFFPTlcyaEV0UCtJYU8vdjRmOWZt?=
 =?utf-8?B?Y2l3NDFpc294RFBMaGhBODBiUkpHWG8vUk1FdGtBZDRBbStIZFVnNkF1TmFq?=
 =?utf-8?B?a3F5V0ZtWFBZS1lad2loMzd4MXdvblF5bDl3V0lORmRqUElyNHZFRzlFZC8r?=
 =?utf-8?B?aDJYTEEzSkEvRWxwYjVMaVNVTTMvZHBBeWNDTXY0Q0JRcm13elJtY0RuODJa?=
 =?utf-8?B?WHdMS1ZlUFdmOFJlc3VleDJmbHZMT1lOWC9mcnhSU2w5c2c0ZUt1dkpXYzVM?=
 =?utf-8?B?aXlMeHI3SWE2M1V0bmxYV2dJSkhPR2dMRW9ubjdaWkkxRUpVNlRUNEd5YWxC?=
 =?utf-8?B?ZFR4S1B3SmQxMzY2L3YwTnlTdUtOVGlCYzlYSDdYNzV1QnUrcVY1N2x1RWdH?=
 =?utf-8?B?ZXNyRjlFNXczck1ZQ3diMGdFQjRka0VNMlFtYVBBbGp6WlZOQ3pJL1JRQzl2?=
 =?utf-8?B?ODFibnEzWjhKRXQraER1dnpqTlQ4c2ZzN0ZxbGhTUk1GWHhTWkc5WTh6UVBx?=
 =?utf-8?B?WEIwazVDcDF0R3V6ajl6aUh2eGlOcW1RbkxzK0NKU0luL20wSDVXajBiZmh4?=
 =?utf-8?B?S0UvdE5jcURLSER6S0hhcGxwY2huY3pWdWlRSGJBOU54MWQzVEN0M1JLWUxo?=
 =?utf-8?B?NHVSQjcranlndnNBS3ZXTWdENVkvdmJMYVQwRmpJZ25WK0VacE15SlBYaXVR?=
 =?utf-8?B?b1BvMWJPWDBtUE1LTW9JWXIrR0FlRlJneFRhNDBQeHM2VUNHS1VZRTd4ZjZJ?=
 =?utf-8?B?VVdCWkpLK2w3REpuMDhhNXg2cXA1aUlreG1ldjNZTHhzOWlIRll4bWhPcWJT?=
 =?utf-8?Q?nYkAhPmkvqJpAtFL0GQJOkZMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3ae747-39e6-4247-6ada-08dd7dec3992
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 20:12:49.0342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD4OF5RdkxIUxpgYJGglwXHNiTJ+5RnxWWyKjRtgk469qwd9sTbSFZuiCZZn8R363RGvG/JrTSnRwkdmOLWLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 2025-04-17 15:30, Srinivasan Shanmugam wrote:
> This commit updates the dm_force_atomic_commit function to replace the
> usage of PTR_ERR_OR_ZERO with IS_ERR for checking error states after
> retrieving the Connector (drm_atomic_get_connector_state), CRTC
> (drm_atomic_get_crtc_state), and Plane (drm_atomic_get_plane_state)
> states.
> 
> The function utilized PTR_ERR_OR_ZERO for error checking. However, this
> approach is inappropriate in this context because the respective
> functions do not return NULL; they return pointers that encode errors.
> 
> This change ensures that error pointers are properly checked using
> IS_ERR before attempting to dereference.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 012ff8332dd2..4a31d99da505 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10621,16 +10621,20 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
>   	 */
>   	conn_state = drm_atomic_get_connector_state(state, connector);
>   
> -	ret = PTR_ERR_OR_ZERO(conn_state);
> -	if (ret)
> +	/* Check for error in getting connector state */
> +	if (IS_ERR(conn_state)) {
> +		ret = PTR_ERR(conn_state);
>   		goto out;
> +	}
>   
>   	/* Attach crtc to drm_atomic_state*/
>   	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
>   
> -	ret = PTR_ERR_OR_ZERO(crtc_state);
> -	if (ret)
> +	/* Check for error in getting crtc state */
> +	if (IS_ERR(crtc_state)) {
> +		ret = PTR_ERR(crtc_state);
>   		goto out;
> +	}
>   
>   	/* force a restore */
>   	crtc_state->mode_changed = true;
> @@ -10638,9 +10642,11 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
>   	/* Attach plane to drm_atomic_state */
>   	plane_state = drm_atomic_get_plane_state(state, plane);
>   
> -	ret = PTR_ERR_OR_ZERO(plane_state);
> -	if (ret)
> +	/* Check for error in getting plane state */
> +	if (IS_ERR(plane_state)) {
> +		ret = PTR_ERR(plane_state);
>   		goto out;
> +	}
>   
>   	/* Call commit internally with the state we just constructed */
>   	ret = drm_atomic_commit(state);

-- 
Thanks & Regards,
Aurabindo Pillai

