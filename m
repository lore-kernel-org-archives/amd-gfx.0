Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6D5C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 05:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E6210E2FC;
	Mon, 29 Jul 2024 05:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="intzOyAE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F145710E2FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 05:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5tdxV/4Ffd7gBY3390LPrSJn1GsiY+hgT2kvOLXsPVkHfaGAuqMKeOcfuqayDHJIbpIxpUxNM0LMVhFH8yj531NXeSrgxM02fASuuXmgpVj4m39jcc07Ym0CLWxyN7yD+030dDvYiWm/3FsIP4i0rthRxo4pJMtEL9v1631tZU5vGDI+m1jqdDGsJzczgsncZrye/oGcwanRk3iBWIsLbbbX3IrDt97xRLoo4Fl3XTAFLV2CMrMp15jZZDANBXXsL5XCHrADZ7q1d/EiN1cSVHz4VuXc8Nr5+wQ6R+XkekUB+ytQQW4DeW3vzhpoD/EqUZ7yyOh01S4qrqhEGCeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZeffz37nmuz0PN9Gu2A8ydX8/70e68aoeK4Gw+GK50=;
 b=h70QQ1cBsKn4iqSbjjBZE4ACqQt2R7hFCy5tzorqcdLqnmgGdaO6sxioAevFO5y2Le1ADAxAnPYcEOOWVMg9AZyGqz1WuZ6ONu72qs8lFgDwy2f82W+tRp9dtuKCEfiwWDujDV6F5hxHjKtssCsJjrkfNBXd14OoUIGHBI36C4ssf/KUDPQ8zy1mRqdTwP+/JKxoqclm6Mfaxvw87hzCFcFdVJovi5ckzGOd31TmF+W0rGiTBr9Cy5HpX0znhR3Vnsiz23pyLvWJA+hoSmVft6eyafIT3EOD0HXXeJTjuiEM3TmG4p7PMjnaTT6pCgmthsgIm88zhIpcvuRPJffgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeffz37nmuz0PN9Gu2A8ydX8/70e68aoeK4Gw+GK50=;
 b=intzOyAEL20vnPSMkmbyA4mZCbqGjdR5GuiAXdh3E1ZHG48qkWuxMEJTS+hbSAZMI8udrbMH5TCBhyWPO5TX7blC/vP0ZEB1G5HjmnbhFvDQ3M+SLIFliqqMA0+MMH4GLd7F3cRZDkS7w4kLKAXraPDGYndmowjmIanv0hNMgkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 05:38:46 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 05:38:45 +0000
Content-Type: multipart/alternative;
 boundary="------------zTDnLeW1px0I6l0BJfXs1kgk"
Message-ID: <16cfb6c9-c2de-4d19-909e-f06df27c78a6@amd.com>
Date: Mon, 29 Jul 2024 11:08:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
 <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
 <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
 <CADnq5_OY_Zoqcrk-n6JvLt8fQCQifAfMX9r8a0qyRu0i9UEEaA@mail.gmail.com>
 <5d3f962c-6efc-4aee-99ac-5dc48c43235f@amd.com>
 <a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com>
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: e79044a8-e52a-47d6-f262-08dcaf90b6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWJuOXVod2lndFgwNGNVL1hjY2xLQWI4UkU0LzM0Z0pOR3ZBb1ZPMG10V0lI?=
 =?utf-8?B?aUdRYkkxd1ZJSW5IQkF3QVkyOCtyNjFubHpYQ3h3Z1F1WTVBK2FVQnpjZUN0?=
 =?utf-8?B?Z1NTaUdaNk9XYzRoNmpRZ2pNbHdVSXVOSGZtSWdSM2x5NnJpRTZpZnJDZkpQ?=
 =?utf-8?B?RkFpRUtCUktRWEpEUjZ2UUFyb2ZDVWhiTzlQb3JqdDA2TnI1RS9FVURjQ0xP?=
 =?utf-8?B?ZGJUT1dvaWdLVFlqVjFmQlVSRDk4YzBYYlZyeTdsYWtveTVwWk4rUXdBdXdp?=
 =?utf-8?B?UDI4eUZybkY2MkpvUjlSTGx0VDVqaUcyUUQydEhyN2doeGJJNUFKcTBKcnhR?=
 =?utf-8?B?eFkyRk9GWHRPenBtOGJpeVo1R05xTjJITGQrZlcvSElOc2F0blYveWJEVzhw?=
 =?utf-8?B?T3pNdXFiR0h4WVl1bW1td3Rudi8raUU0bHR1aGFSTW02enhnRmk2U2JyS0la?=
 =?utf-8?B?QjZyT3RDbVRDcHZLKzFwU3NMdWxBMG1iVUJlaEdyVmMxZE5rUFBPUGQ4OXI2?=
 =?utf-8?B?U21mQURkT0ZVSUF2cFJzaUEvMlBMVTVMeElSRitGa2JPdE90UGE3TmR4ZGNE?=
 =?utf-8?B?WElwMUNCOTZIMzR1elpjdkZDUVNIS25YWnAwbXFUN2hRbm43UUIxcWxVejh4?=
 =?utf-8?B?UjFoWWdtdkNhbGYxaFdac2NheW01TzYzQ0xFYTZMNWNxekF0T29Zcmg3a3M4?=
 =?utf-8?B?ajBackE5c3l1emZkWlJkMW5jZHdiMFdCVzFZdEtkNzVOZ0hOamFBMWxSbk45?=
 =?utf-8?B?ZGJjUmJ6Q1Qra1ZDNTU1K0ZXa2ZjVC9PaldSNVI2RURsWXdFSmJxZENlTTVs?=
 =?utf-8?B?cHFiZnpEdVZFZCt4ODRGNmx2ZkFQZzhOUS9aRm1tYnVLMmkyUTFkWVNhRzd2?=
 =?utf-8?B?WmxBeHZGVGdPV3lNQjZJNUFmZDFIOWRWUkpOeE1lekZQN1M5U3hnaERDK0NU?=
 =?utf-8?B?czRtUXA3NEMrdFl3bENMMCtsVk9lU1Z2QTFiQ2REVWZqVTYweTBLY0R0SWdE?=
 =?utf-8?B?ekFiTGRYK2RLenRpSmVCUjIwNFo2UFF5ZEtSMTRucUxqeEhNNTlOVGZ1NFJ2?=
 =?utf-8?B?aHRhWUlpdHpTZEwzVXU5dml3OVpOdkUvcHYzYm41dmhneTA2bUF5bUM4YnNM?=
 =?utf-8?B?Q2pUUy90RWNnZk9PVVFYZFNBL1BxWm85TWRTb2RaQXJMMnJtaVhOOEZSb21l?=
 =?utf-8?B?cDN6UEJtYytaTzZNMGxpVDRmUldnOE5abS9VcHpCZE1XR1ptTy9ybUpIVWI1?=
 =?utf-8?B?YUZqNmhrUUFXSWIxd0dwR0pDQTl6aEJjVnFWaVl4d0ROZFZWMGxjRE91dHdL?=
 =?utf-8?B?V2tmQ3diRHRRT2NsOEcxYlJSTkJpMXhGdVRCNHpnR1BRdSs5dHRoUUoxQ043?=
 =?utf-8?B?a3A3RG9BYVYwR0YvTVFzWFJRek1KM2lHd3VoQ1ZkZ2xJeUR5K0NQTXpieG5M?=
 =?utf-8?B?cDcxSXdkcjE3WXZ5czZhTlZQUVJ0YS9OSlk3T3NUM2NPQTEwMnF4d2NydVMx?=
 =?utf-8?B?NTlNRmNGWnE4V09JbVFwUjJFRXBVYmxWZVV6alB1WHJaeU43dXh4M2wwOEwx?=
 =?utf-8?B?K3BqbVc1eWh5Mm9sY3hWZGlKQ0lxVzlNMGF3UFU2aSthdHdEOEVXSjlja3p4?=
 =?utf-8?B?WG9aRnoyUmhCOUZNalhOVnpJejhPSkdZUC8wTzhoMGo5ZFRTS1RkZHdZOHRi?=
 =?utf-8?B?OWlQWHEwcmdWQ3UrY3BMeFNic0w2a2NXSUpXbXNneEZtTmJxaVNZbEs1eS8w?=
 =?utf-8?B?TVFEMEhrRUVTdXZjS21vVmFnREV3dzkySkdaK3dyWWJadlBSTVhkZTB2aUJS?=
 =?utf-8?B?NktSVTNsN3p2Rnd2QzBHdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlQ0TTJ4OFcwc0hUK0dpbDJiaGVMbHZ4RkhnNmZocnlLdUphaFV6OGtxTGlw?=
 =?utf-8?B?U1dNOVNrYWdKcGU5akdHZXJlc2ltbUJwdy9YeHpRRTFWck4xdzNkV1JoeHBS?=
 =?utf-8?B?aEYxTUd5UEFxOEd1R05tRy9kS2ZGL1JsSEJMUmJjMnJSTVhOZlVKU0JkSDAw?=
 =?utf-8?B?OXd4aG9sNTFZUFFkUlNrblkrNE0xczRPZ1NZNkcrS0ZMU3lPQXJkTXRlRHVT?=
 =?utf-8?B?ZXVId2FmRi9waHZ6d09JRitBZ3BUdmsxVHAvdEhqR004RFJkQUZjNkV1cW5F?=
 =?utf-8?B?dStCUFVOYVE1ZnlIdTd6cExKOFpoVDl1c3htcGhCcGxFRktxMWh3ZkViVmha?=
 =?utf-8?B?N0ZhVFA2MEl4WmNNb1BUYWZZcDJscmtnMHBqQTNaMG9pQjdUZ0d3WmJ5NU1L?=
 =?utf-8?B?Q21hL1lYZG5nQjh1MUdnZHBOblBHazU2bGVZek9pTkNuNHNxVXlWK2tlbVpI?=
 =?utf-8?B?RHNMOUphT01GN0hvYjBRTXlRd0xTSVYwZ2dGcTNmRXI5UTI3d0JRalg1YkU0?=
 =?utf-8?B?RUxBVGJXM1hZemowMTBXNElqbXo4eVJmRWVoVmE3SFBvLzFZdHY2UnZMZkYy?=
 =?utf-8?B?U0h0ZVB0Uzk4TVR6MUJDNnlvS1I0dFZlZVhIUmxxRi9rYkdYNkJsRHlSZG4y?=
 =?utf-8?B?VnVhcm5tZHROZkkyTG9VRzhKdHRzUzJBeUtDZUVFK1hOQlpXc3doUXdJRkJH?=
 =?utf-8?B?SDB1YmRqbTZpRTZsMkZhKytQM2hPWVpBUzlDYk51aGcrTDROanIwd2kzWTJZ?=
 =?utf-8?B?Q3BpejFPTHFrZE1BaHZENG9UNlN5QmVLZDBnWTI0Z1VTUHBnem90SEFTTVNJ?=
 =?utf-8?B?S1NXcVVub2hSR3dLY3dLV3BhbWVkYzQzSlNROGlZZThINzdFVlFXMFh5WlhX?=
 =?utf-8?B?cjgwaVRyWWdjcVlvQThwN1hhOHorK2syOXRGMVVYakFYejhkSmNraHdkbVhN?=
 =?utf-8?B?QnRuUTkxbDI4WGFZL1NoYWs0djRtTi9weWdocGJsY3RhdmdLNy9DS2tWM0Jp?=
 =?utf-8?B?cnJOcG1wYnpsWm9odms4Q1VCbUhtb1BZeHJGdEp3L1lTM0xEUUxsWkY0QWU2?=
 =?utf-8?B?N0x2NGhVcnRTM1dYbkpEQS9hTFN3OTFtZURoZ1lyRUkyMFRIaHZ2bFVZSDRG?=
 =?utf-8?B?aVVRaWI5RGxGMTY5VENjdGRKSmVzREh2bk9ESDFBT1luY2lpT2JqS2NjVlRJ?=
 =?utf-8?B?RzVOSWF3dzBBcTAwblBqbGJ3b2VOS0RjVm1vd0NmNUIzSStHMVpaSno1YktX?=
 =?utf-8?B?VW5ZdytvRk5GKzROaXBlbnN2TDcvOFUxTWZMVDRsQVJOUVpENHJOK0R0bTkz?=
 =?utf-8?B?WHpqL0lLclZxNFN6WDJPb3B1RXNYVGJhWWRTY283L1I0Vm91MW9NWU12emMy?=
 =?utf-8?B?aGdHdkRkZWNZTUw3amw3VHR4cDJ4MHNUck5qOWhVWnI1S1BmcTl6cDhybzJy?=
 =?utf-8?B?V3RqZnMzTG13Sk8xU1BtVGVxY1lrNWFOMDY1dFVJcDVVbVBqUjRhMEZEU2Jn?=
 =?utf-8?B?MGhqSlo5WDFuMDlNUHNlREtJcDQzT294WHpqa055dTVpcHg2L2paTjVKZit1?=
 =?utf-8?B?WFlWNTBxSVF1cjc0UVMwaUlSMkY2aEFkbFF6MlZHSWlxeUlPRmRVSXlLdmlD?=
 =?utf-8?B?YjVjZHRBSGIwRnVpTGZva0ZYeC9Hc2ROQUU1OVVFMVVSRmVISy9vV1Jxc04r?=
 =?utf-8?B?b3I3NHZNUkpkWUkvUmNpWmZYV2ZnUmpSNDFubDZNQXJGbHpXdHc1bklqeVJE?=
 =?utf-8?B?NzFzbDU3c2dXZUhVNVZSS0xDcHBlQ2RtQzRBRmw5STUwaU9Yd3AyQTB5bVNC?=
 =?utf-8?B?bjVTL0dLTDEvbkJwbzZGdzFxd2o1U2RheVpaNGVidVZRRkpkWVBvRUd5SWQ0?=
 =?utf-8?B?OFh2ZjZIbmxKK2s0Y01uc1dUVFh2QTNJeWJuelR1UmorM3VOM0lHSGtwc1RB?=
 =?utf-8?B?NU85SHdTL0F4cVRDSXJrMFIwejlma0FoUUUraWp2bGxraTIrVCt2UmEvdGFF?=
 =?utf-8?B?VTNhZW5CS3dUeVdQeElPL2hyOUEyODRUbkhBbEpEN3pNQ2xxeFZQcElQQjly?=
 =?utf-8?B?anpEQ2R5eDJwb25veEVsMjRERVdxVm9GaGIybXgvTHBqbHQzUThtanlmMDRr?=
 =?utf-8?Q?muHvoTQarnT+G19tfuxtBpn2J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79044a8-e52a-47d6-f262-08dcaf90b6b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 05:38:45.8485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB2yCObEKK4iZPvIbMPesycKbzyL6/gbhLcEylAvA3y9MFgx4tpLj8cKN5rkemDVv8cxjNrYkNOMW+kgiHkeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
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

--------------zTDnLeW1px0I6l0BJfXs1kgk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/29/2024 10:08 AM, Lazar, Lijo wrote:
>
> On 7/27/2024 12:51 AM, Khatri, Sunil wrote:
>> On 7/27/2024 12:13 AM, Alex Deucher wrote:
>>> On Fri, Jul 26, 2024 at 1:16 PM Khatri, Sunil<sukhatri@amd.com>  wrote:
>>>> On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
>>>>> On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
>>>>>> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>>>>>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>>>>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>>>>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri<sunil.khatri@amd.com>
>>>>>>>>> wrote:
>>>>>>>>>> Problem:
>>>>>>>>>> IP dump right now is done post suspend of
>>>>>>>>>> all IP's which for some IP's could change power
>>>>>>>>>> state and software state too which we do not want
>>>>>>>>>> to reflect in the dump as it might not be same at
>>>>>>>>>> the time of hang.
>>>>>>>>>>
>>>>>>>>>> Solution:
>>>>>>>>>> IP should be dumped as close to the HW state when
>>>>>>>>>> the GPU was in hung state without trying to reinitialize
>>>>>>>>>> any resource.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>>>>>>>> Acked-by: Alex Deucher<alexander.deucher@amd.com>
>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>>>>>>> +++++++++++-----------
>>>>>>>>>>      1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>             return ret;
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>>> +{
>>>>>>>>>> +       int i;
>>>>>>>>>> +
>>>>>>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>>> +
>>>>>>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>>> +
>>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>> A suspend also involves power/clock ungate. When reg dump is moved
>>>>>>>> earlier, I'm not sure if this read works for all. If it's left to
>>>>>>>> individual IP call backs, they could just do the same or better
>>>>>>>> to move
>>>>>>>> these up before a dump.
>>>>>>> Suspend also put the status.hw = false and each IP in their
>>>>>>> respective
>>>>>>> suspend state which i feel does change the state of the HW.
>>>>>>> To get the correct snapshot of the GPU register we should not be
>>>>>>> fiddling with the HW IP at least till we capture the dump and that is
>>>>>>> the intention behind the change.
>>>>>>>
>>>>>>> Do you think there is a problem in this approach?
>>>>>>>>             amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>>>             amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>> Adding this does sounds better to enable just before we dump the
>>>>>>> registers but i am not very sure if ungating would be clean here or
>>>>>>> not. i Could try quickly adding these two calls just before dump.
>>>>>>>
>>>>>>> All i am worried if it does change some register reflecting the
>>>>>>> original state of registers at dump.
>>>>>>>
>>>>> I was thinking that if it includes some GFX regs and the hang happened
>>>>> because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
>>>> For GFX and SDMA hangs we make sure to disable GFXOFF before so for
>>>> those IP's
>>>> I am not worried and also based on my testing on NAVI22 for GPU hang
>>>> their registers
>>>> seems to be read cleanly.
>>>> Another point that i was thinking is after a GPU hang no where till the
>>>> point of dump
>>>> any registers are touched and that is what we need considering we are
>>>> able to read the registers.
>>>>
>>>> For VCN there is dynamic gating which is controlled by the FW if i am
>>>> not wrong which makes the VCN
>>>> off and registers cant be read. Only in case of VCN hang i am assuming
>>>> due to a Job pending VCN should be in power ON
>>>> state and out intent of reading the registers should work fine. Sadly i
>>>> am unable to validate it as there arent any test readily
>>>> available to hang VCN.
>>> We want to take the register dump as early as possible in the reset
>>> sequence, ideally before any of the hw gets touched as part of the
>>> reset sequence.  Otherwise, the dump is not going to be useful.
>>>
>>> Alex
>> Sure Alex. I am also of the same view that we dont want to change any
>> power status of any IP as it could change the values.
> There is a debugfs interface 'amdgpu_reset_dump_register_list_write' tp
> add registers to reset_info.reset_dump_reg_list. Presently there is no
> check about which registers are added to that list. For ex: if user has
> added some GFX related registers, this is going to hang while in GFXOFF
> as ip dump state comes later.
>
this isnt being used and i will clean it up. its original intent was to 
for dump only which we based on all conditions are taking care. So this 
needs clean up and i will check on it.

> Also, all IPs don't handle dynamic wakeup; therefore, regardless of a
> reset scenario, direct access to powergated IPs could result in a hang
> and that will make things worse.

Before dumping any IP we are taking care of Power status of the IP so we 
should be fine. Like for GFX, SDMA we make sure GFXOFF is disabled. VCN 
we are dumping only if its power is shown as ON and like wise it will be 
done for other IPs too.

Regards

Sunil Khatri

> Thanks,
> Lijo
>
>> Regards
>> Sunil Khatri
>>
>>>
>>>>> BTW, since there is already dump_ip state which could capture IP regs
>>>>> separately and handle their power/clock gate situations, do you think
>>>>> this generic one is still needed?
>>>>>
>>>>> For whatever we have implemented till now seems to work fine in case
>>>>> of GPU hang withotu fidling the
>>>>> power state explicitly. But Calling suspend of each IP surely seems
>>>>> to change some state in IPs and SW state too.
>>>>> So i think until we experience a real problem we should go without
>>>>> the generic UNGATE call for all IP's
>>>>>
>>>>> But i am not an expert of power, so whatever you suggest would make
>>>>> more sense for the driver.
>>>> Regards
>>>> Sunil Khatri
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>> What u suggest ?
>>>>>>> Regards
>>>>>>> Sunil
>>>>>> I quickly validated on Navi22 by adding below call just before we dump
>>>>>> registers
>>>>>> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>>>
>>>>>>        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>
>>>>>>        amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>        dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>        /* Trigger ip dump before we reset the asic */
>>>>>>        for(i=0; i<tmp_adev->num_ip_blocks; i++)
>>>>>>            if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>                tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>                                        (void*)tmp_adev);
>>>>>>        dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>>>>> }
>>>>>> If this sounds fine with you i am update that. Regards Sunil Khatri
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +
>>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>>> +
>>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>      int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>>>>>>                                      struct amdgpu_reset_context
>>>>>>>>>> *reset_context)
>>>>>>>>>>      {
>>>>>>>>>>             int i, r = 0;
>>>>>>>>>>             struct amdgpu_job *job = NULL;
>>>>>>>>>> +       struct amdgpu_device *tmp_adev =
>>>>>>>>>> reset_context->reset_req_dev;
>>>>>>>>>>             bool need_full_reset =
>>>>>>>>>>                     test_bit(AMDGPU_NEED_FULL_RESET,
>>>>>>>>>> &reset_context->flags);
>>>>>>>>>>
>>>>>>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>                             }
>>>>>>>>>>                     }
>>>>>>>>>>
>>>>>>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>>> &reset_context->flags)) {
>>>>>>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>> +
>>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP
>>>>>>>>>> State\n");
>>>>>>>>>> +                       /* Trigger ip dump before we reset the
>>>>>>>>>> asic */
>>>>>>>>>> +                       for (i = 0; i <
>>>>>>>>>> tmp_adev->num_ip_blocks; i++)
>>>>>>>>>> +                               if
>>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>>> +
>>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>>>> +                                                       (void
>>>>>>>>>> *)tmp_adev);
>>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>>> Completed\n");
>>>>>>>>>> +               }
>>>>>>>>>> +
>>>>>>>>>>                     if (need_full_reset)
>>>>>>>>>>                             r = amdgpu_device_ip_suspend(adev);
>>>>>>>>>>                     if (need_full_reset)
>>>>>>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>             return r;
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>>> -{
>>>>>>>>>> -       int i;
>>>>>>>>>> -
>>>>>>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>>> -
>>>>>>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>>> -
>>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>>>> -
>>>>>>>>>> -
>>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>>> -
>>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>>> -       }
>>>>>>>>>> -
>>>>>>>>>> -       return 0;
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>>      int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>>>                              struct amdgpu_reset_context
>>>>>>>>>> *reset_context)
>>>>>>>>>>      {
>>>>>>>>>>             struct amdgpu_device *tmp_adev = NULL;
>>>>>>>>>>             bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>>>>>>             int r = 0;
>>>>>>>>>> -       uint32_t i;
>>>>>>>>>>
>>>>>>>>>>             /* Try reset handler method first */
>>>>>>>>>>             tmp_adev = list_first_entry(device_list_handle, struct
>>>>>>>>>> amdgpu_device,
>>>>>>>>>>                                         reset_list);
>>>>>>>>>>
>>>>>>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>>> &reset_context->flags)) {
>>>>>>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>> -
>>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>>>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>>>>>> -                       if
>>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>>> -
>>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs
>>>>>>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>>> Completed\n");
>>>>>>>>>> -       }
>>>>>>>>>> -
>>>>>>>>>>             reset_context->reset_device_list = device_list_handle;
>>>>>>>>>>             r = amdgpu_reset_perform_reset(tmp_adev,
>>>>>>>>>> reset_context);
>>>>>>>>>>             /* If reset handler not implemented, continue;
>>>>>>>>>> otherwise
>>>>>>>>>> return */
>>>>>>>>>> -- 
>>>>>>>>>> 2.34.1
>>>>>>>>>>
--------------zTDnLeW1px0I6l0BJfXs1kgk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/29/2024 10:08 AM, Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com">
      <pre class="moz-quote-pre" wrap="">

On 7/27/2024 12:51 AM, Khatri, Sunil wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 7/27/2024 12:13 AM, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Fri, Jul 26, 2024 at 1:16 PM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sukhatri@amd.com">&lt;sukhatri@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
</pre>
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">On 7/26/2024 6:42 PM, Alex Deucher wrote:
</pre>
                    <blockquote type="cite">
                      <pre class="moz-quote-pre" wrap="">On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
wrote:
</pre>
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">Problem:
IP dump right now is done post suspend of
all IP's which for some IP's could change power
state and software state too which we do not want
to reflect in the dump as it might not be same at
the time of hang.

Solution:
IP should be dumped as close to the HW state when
the GPU was in hung state without trying to reinitialize
any resource.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
</pre>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">---
&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
+++++++++++-----------
&nbsp;&nbsp;&nbsp; 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 730dae77570c..74f6f15e73b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
amdgpu_device *adev)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
&nbsp;&nbsp;&nbsp; }

+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
+
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lockdep_assert_held(&amp;adev-&gt;reset_domain-&gt;sem);
+
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;reset_info.num_regs; i++) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_info.reset_dump_reg_value[i] =
+
RREG32(adev-&gt;reset_info.reset_dump_reg_list[i]);
</pre>
                      </blockquote>
                    </blockquote>
                    <pre class="moz-quote-pre" wrap="">A suspend also involves power/clock ungate. When reg dump is moved
earlier, I'm not sure if this read works for all. If it's left to
individual IP call backs, they could just do the same or better
to move
these up before a dump.
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">Suspend also put the status.hw = false and each IP in their
respective
suspend state which i feel does change the state of the HW.
To get the correct snapshot of the GPU register we should not be
fiddling with the HW IP at least till we capture the dump and that is
the intention behind the change.

Do you think there is a problem in this approach?
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">Adding this does sounds better to enable just before we dump the
registers but i am not very sure if ungating would be clean here or
not. i Could try quickly adding these two calls just before dump.

All i am worried if it does change some register reflecting the
original state of registers at dump.

</pre>
                </blockquote>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">I was thinking that if it includes some GFX regs and the hang happened
because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">For GFX and SDMA hangs we make sure to disable GFXOFF before so for
those IP's
I am not worried and also based on my testing on NAVI22 for GPU hang
their registers
seems to be read cleanly.
Another point that i was thinking is after a GPU hang no where till the
point of dump
any registers are touched and that is what we need considering we are
able to read the registers.

For VCN there is dynamic gating which is controlled by the FW if i am
not wrong which makes the VCN
off and registers cant be read. Only in case of VCN hang i am assuming
due to a Job pending VCN should be in power ON
state and out intent of reading the registers should work fine. Sadly i
am unable to validate it as there arent any test readily
available to hang VCN.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">We want to take the register dump as early as possible in the reset
sequence, ideally before any of the hw gets touched as part of the
reset sequence.&nbsp; Otherwise, the dump is not going to be useful.

Alex
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Sure Alex. I am also of the same view that we dont want to change any
power status of any IP as it could change the values.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
There is a debugfs interface 'amdgpu_reset_dump_register_list_write' tp
add registers to reset_info.reset_dump_reg_list. Presently there is no
check about which registers are added to that list. For ex: if user has
added some GFX related registers, this is going to hang while in GFXOFF
as ip dump state comes later.

</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">this isnt being used and i will clean it up. its original intent was to for dump only
which we based on all conditions are taking care. So this needs clean up and i will check on it.</span></p>
    <blockquote type="cite" cite="mid:a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com">
      <pre class="moz-quote-pre" wrap="">
Also, all IPs don't handle dynamic wakeup; therefore, regardless of a
reset scenario, direct access to powergated IPs could result in a hang
and that will make things worse.
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Before dumping any IP we are taking care of Power status of the IP so we should be fine.
Like for GFX, SDMA we make sure GFXOFF is disabled. VCN we are dumping only if its power is shown as ON and like wise 
</span><span style="white-space: pre-wrap">it will be done for other IPs too.</span></p>
    Regards
    <p>Sunil Khatri<span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com">
      <pre class="moz-quote-pre" wrap="">
Thanks,
Lijo

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards
Sunil Khatri

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">BTW, since there is already dump_ip state which could capture IP regs
separately and handle their power/clock gate situations, do you think
this generic one is still needed?

For whatever we have implemented till now seems to work fine in case
of GPU hang withotu fidling the
power state explicitly. But Calling suspend of each IP surely seems
to change some state in IPs and SW state too.
So i think until we experience a real problem we should go without
the generic UNGATE call for all IP's

But i am not an expert of power, so whatever you suggest would make
more sense for the driver.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Regards
Sunil Khatri
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Thanks,
Lijo

</pre>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">What u suggest ?
Regards
Sunil
</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">I quickly validated on Navi22 by adding below call just before we dump
registers
if(!test_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context-&gt;flags)) {

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_reg_dumps(tmp_adev);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP State\n&quot;);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Trigger ip dump before we reset the asic */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(i=0; i&lt;tmp_adev-&gt;num_ip_blocks; i++)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state(
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void*)tmp_adev);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP State Completed\n&quot;);
}
If this sounds fine with you i am update that. Regards Sunil Khatri
</pre>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">Thanks,
Lijo

</pre>
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">+
+
trace_amdgpu_reset_reg_dumps(adev-&gt;reset_info.reset_dump_reg_list[i],
+
adev-&gt;reset_info.reset_dump_reg_value[i]);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
+
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
+}
+
&nbsp;&nbsp;&nbsp; int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context
*reset_context)
&nbsp;&nbsp;&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job = NULL;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =
reset_context-&gt;reset_req_dev;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_NEED_FULL_RESET,
&amp;reset_context-&gt;flags);

@@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }

+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(AMDGPU_SKIP_COREDUMP,
&amp;reset_context-&gt;flags)) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_reg_dumps(tmp_adev);
+
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP
State\n&quot;);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Trigger ip dump before we reset the
asic */
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
tmp_adev-&gt;num_ip_blocks; i++)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
+
tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state(
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void
*)tmp_adev);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP State
Completed\n&quot;);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_full_reset)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_device_ip_suspend(adev);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_full_reset)
@@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
&nbsp;&nbsp;&nbsp; }

-static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
-{
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
-
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lockdep_assert_held(&amp;adev-&gt;reset_domain-&gt;sem);
-
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;reset_info.num_regs; i++) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_info.reset_dump_reg_value[i] =
-
RREG32(adev-&gt;reset_info.reset_dump_reg_list[i]);
-
-
trace_amdgpu_reset_reg_dumps(adev-&gt;reset_info.reset_dump_reg_list[i],
-
adev-&gt;reset_info.reset_dump_reg_value[i]);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
-
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
-}
-
&nbsp;&nbsp;&nbsp; int amdgpu_do_asic_reset(struct list_head *device_list_handle,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context
*reset_context)
&nbsp;&nbsp;&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev = NULL;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset, skip_hw_reset, vram_lost = false;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Try reset handler method first */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev = list_first_entry(device_list_handle, struct
amdgpu_device,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);

-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(AMDGPU_SKIP_COREDUMP,
&amp;reset_context-&gt;flags)) {
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_reg_dumps(tmp_adev);
-
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP State\n&quot;);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Trigger ip dump before we reset the asic */
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; tmp_adev-&gt;num_ip_blocks; i++)
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
tmp_adev-&gt;ip_blocks[i].version-&gt;funcs
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dump_ip_state((void *)tmp_adev);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev, &quot;Dumping IP State
Completed\n&quot;);
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
-
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context-&gt;reset_device_list = device_list_handle;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_reset_perform_reset(tmp_adev,
reset_context);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If reset handler not implemented, continue;
otherwise
return */
-- 
2.34.1

</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------zTDnLeW1px0I6l0BJfXs1kgk--
