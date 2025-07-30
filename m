Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175A5C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 14:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A851510E00F;
	Wed, 30 Jul 2025 14:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hHKyqkRo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32ACD10E00F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 14:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBdjy/+QbmymmKQOui59k/EWLhMZWdRgydIXxak2lmZbY2iv0OhRAf2dByqElnE6B8N/zcGJWfsur3cJclXQ7nG/6HkOrc7xkriOJzVYnz1IRxcA6AHPWFfVSauxTOs5eUEjGklHIcWp+D4zGrM+bhRkaYOOuhWzrQ5/YgtuI5onDpNqOQ7ot3TENL+MCLg4p7RDSFsdKJd8bkuugYySfH5r3n/t5URo0TMFVXvo3/PNGGBS978S4EP1mH5hqtvHz30l4+sgESVFaIV8YNAih2v9T3aFJElI3dXMJYtycmUewnzVzj31B0vY1cXHzT9i4BbUOt+H4auikHixgfPwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/3NBVESXO3gpUBMJaLZyJbRuFTdWCq841DOgoyL38Y=;
 b=rso36t5Ofwhr87wNNo7QvzeJPCeC8cP7BkpK4avXRuom859ZfYVvRtiXpujokXgoFFJKmAIIObmDttJmmz111lPTusD7j4TAujY/Vyymbaud58rl01RH+cA/xeMhAFzJshjC+mVSvTRJ2GZ7WX03TyD6hMxWuTmsAAhy2Jr+FW84hbtajckMkK9WyyDUBGpMlZEUxF94BHa1N1FAkHiaibQx7/n4uJ3RJsHdbsAVezKKGj3xNBGkfdiNXunyy3fXugCEl4EZ0G34Gq+OAZuDd5H9ppt8ZzEPERkDpcyRJfIxDI/CvLpNJn1yt5oCJ7zxb1vf/tInKHIE4xRSGC78og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/3NBVESXO3gpUBMJaLZyJbRuFTdWCq841DOgoyL38Y=;
 b=hHKyqkRopniNqAiQoqueSTI3BbOU2dDBUMXYHKdHKZilfEDFKe6pemBob6L3aUqroahbWTVfKm08Btlg/8vLcKUOQ+Uu3yAXm0fPCu7R64t8OBtAcKvy3b559Ik5P+3fHF88UAyet2TqviD2Nn2x+Wv3f3VBKHL4c6JEDt+WxvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 14:34:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 14:34:41 +0000
Message-ID: <714ca8d3-5da7-4266-b258-aba3fbed4a40@amd.com>
Date: Wed, 30 Jul 2025 10:34:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio on
 RGB signals
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-8-timur.kristof@gmail.com>
 <1ef9ce5a-0b6d-4d0d-834d-d1f6b0dc12bd@amd.com>
 <7d1df06a6b19dc2d8e78059efb6e26f00bdb280a.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <7d1df06a6b19dc2d8e78059efb6e26f00bdb280a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0063.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 625b2a31-4168-4c52-f1a2-08ddcf76387b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTdUL0Jobm5wY0p2WStiZ3N6eGlYWXlsc0NPVWZkRURSbnQ0ZWpQTG5GZDFm?=
 =?utf-8?B?dG1PRFcraDVLN0M5TWxXUk1FS3VOeXpKRlZ6V1QzcStZa1RUY0IrRzJzRnNa?=
 =?utf-8?B?SkRKMWVlQnBOaGZwYk53MDUyL3FyYlJhcjk4eHBoYzZ4QWVTdGFDdmJwaVVM?=
 =?utf-8?B?MVpyRy81dVpwYlpPc0RmcS9GTGVTTW8xSU9zdko0ZFBLWHBoWVN2SHd6aDdn?=
 =?utf-8?B?dTFPZGplZjVTMDJGZXRlSURTOW0ySDNNYmtOVkpZZmlTOFV3YndJcktqT0xt?=
 =?utf-8?B?MUVKS0d0NXNxZkg5S1d2WUZTK25ZaUYvK1lvTXlPNnFxa3B1ZnJUVkxzRWF2?=
 =?utf-8?B?ZFUrQnY1WjRXUy9uY09IL2U2WWZ3N0NiMmVEZzZPTFIwdTg3bnhJcVN0akY3?=
 =?utf-8?B?eHl4c1dHTTgxMm85UE91aWJsSDloMlExUHZIK1NCcm5OdDMvNG9zMFJ5ZWtR?=
 =?utf-8?B?bTIvMndkMjNSL05MdE9MREVieFdGR0JpWXJsU3hsQjVBdm9oMWVaVTlMOFpC?=
 =?utf-8?B?OFNkd2xCN0FhYVpNUkRnUGc0bE05OWFlc0paOStQNzd2U2lPMytrdTFnNjFI?=
 =?utf-8?B?ZDUxUkRRMHVTaGxEWXJaOTNka1pWNDBjRndnbDZGRzFLUHp6UXdpSFRicHlP?=
 =?utf-8?B?bU1tcWM1UTZlZldVaFF0OGRCTVczK2Z4NitKcmZJRzQweWtEcDVEY1lMUjRN?=
 =?utf-8?B?M1lSck9MSnd3UU43ZVQwSDZBU2tJMzBYNHJNay9hUG1QWXRmK1o0TlNCSGNO?=
 =?utf-8?B?UWFrcEtqQVNHcXNSR1k1M0lBNTk3OVFPUlhaMnlzMTBpTW9RWmROOEM4VVdU?=
 =?utf-8?B?NHhYR1VUend4Zlk4enRCbnltVEx0YXpCU3UyN0JoNzUxeExkT0NBSDJkQWNi?=
 =?utf-8?B?TW5FdGtvWkZZdElTakgxTlNKeGNoa0dQbjRTOTl1NnhrZ2lEUmYyNElNeGc0?=
 =?utf-8?B?MmJqRStaTWVMeURrMm5jbDc5T2RyRmR2ZHNMdW0yRnJXck42UDdoWVp5YU9a?=
 =?utf-8?B?WTJjaG51MFI0MHdCMndNQmplV1hucXAzMzNZa3YzU1BNaXloTDdwT1pYOGlh?=
 =?utf-8?B?QVVtd3hXQWxjOUh5Rk5hUGxRNTlzMkNkb2JDKzV1cy9WdFN3Z095TGRBY2Ey?=
 =?utf-8?B?UnFTNkpuZjZoam5TYWdFbU4wSVEvL01aYVhiNDNrN1ZuNkpaM1B1SXRGeDFt?=
 =?utf-8?B?TExvNSttaFFtVFJBZm9nbnJ2R05DeGthTmY1bmExcjRFRGt0dEdhU29PWUR3?=
 =?utf-8?B?N3RGZDVqZC9wVElQUDR3SjgzSHVOS3pYbGFpZURNWUlIMCtheWFtZmV6WTBz?=
 =?utf-8?B?VGdPNU1VTmgzb2ZUNUt1cVRPdHlReGFJZytRcEd0MWhpRWxqdnpFUUdTQW8v?=
 =?utf-8?B?WHo4NUJCaUNzOVhQQWROVjBGL1NlNUYycjUrYnUyN29pcmx0a051aUNGWDZP?=
 =?utf-8?B?VjJLQkxIS2Z5MTY4WTQvelZKVmI4aFhReC9PTkxvUmFlekpta2dvcU5uZmhQ?=
 =?utf-8?B?NmtJL0RVRUlSREIrdHE1WHIvbDh2bzNDbkN4RnZleDlQZmczRWlJNmQyWmtM?=
 =?utf-8?B?ejc5TTlYZ2ZPbGxVellOS2R4UytLdmZLdWRia2hTNFZCN2NWNE41dGJKZEZG?=
 =?utf-8?B?bFZuVkZ0V1ZpVmNGOWcyTmhpTHd2TzdLditIMHd0M1Q0cDBEWFdZN01TVTRp?=
 =?utf-8?B?OEpvZ1ZqY2JTNnFOWXA5SGhZalVTM0tBaFNhMmN3SThsZTlvZWRGOE5IY0NX?=
 =?utf-8?B?VnF2bWNhNGVKWlFkTXBRcURGZlFwM1JKVG9FWDZPMTJPZURMV2p0bThjb3Ri?=
 =?utf-8?B?NXpiem5aVGNPaXdXaWVzRUk0Zy9IczQwbkcxSi9OMjIydjU1c2VXQzZFb3VI?=
 =?utf-8?B?WGI2WjRpY2pNbGV1YmlqVy9kUStGaXBneXNOK0Nna0NkT1BSbnhLRUhYY3JT?=
 =?utf-8?Q?HEPFHJ5xDeQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZnNUNHM2R6OHFCSjRPd09Fdk5IRVhrY2ZHc3l4YTNFK0ZPZVQxN3d4MGJj?=
 =?utf-8?B?OTBNQ3YvUkJzczY4ZWNRQUVSVUt3ajVteHh0ak5FL1hvZnFSeXdBT0xSdGJZ?=
 =?utf-8?B?M3ZUNWVYQUpEKzFxSEh2YkFRTGJvM1Z1SGc4RWFTRDlSMktFZU5sOElFbWt2?=
 =?utf-8?B?OVhrTTJhV3pEaXFNUCsyYTE0V3VsdG5ua3lSRXU0cFBVZldsVnVOTXZaZFFB?=
 =?utf-8?B?WHBybTNIT2FJYjZsR2doZmVFeWdSSGVORCtQd2NDb0JiNEt6a1JoaVI1dmho?=
 =?utf-8?B?MHVHVnptejdxS1BOUkZMMUhFbWI1ZmRNNWI4UWNYOXdJZVo3WjAwdUJITHZZ?=
 =?utf-8?B?cDdwcHRQNHUzRlpOK2hTWkFoclhLb3JKbHdYRldjM3ZSNlRBWllyY05SOG9u?=
 =?utf-8?B?OE9NRXozb1Y3K080OXRHMWtQTEpTRWxXTDBkNzB2WWVpUjUrc1dMU0RvU2tw?=
 =?utf-8?B?emUzbXVETGIzeHpYYlQ2czlnLzBnZTMrQjVzeFhuVndkTXBiUEtMeDJGWEh1?=
 =?utf-8?B?LzVJNGt1YVZ1NHg0YjlhUTJlWUF0SUYvYkY4dnNWYjVRaUlVZG1ERFpPcjl2?=
 =?utf-8?B?RGp4MjZDUGhlUzJDSXkrdE52QzY3ek9Udm85bmtyWVFacXNmYm9wRENoT3hp?=
 =?utf-8?B?SkFlY0dFV1dnRUxHbFVvcDM1cWd2TTJZNXVZRThRSGt5T2d2c01XMVQyOFM1?=
 =?utf-8?B?emdjT3dOY2Exb1RhaEpHZE0zZkQ0cTlCRTBvS0NYNHBoN3lYalcwR0YwWTQ0?=
 =?utf-8?B?UHk4SFk5MzdqWFgxOTZWT3dIQlo1SUtDSm9CZWJTL2NNQWFZVmxyUjNmQUFr?=
 =?utf-8?B?UmVJSzZIWS9OL1JoeXJWb0RZcFNRNjlsT1N0OXFQM3lMNnV4bkxyQ0tpVG1H?=
 =?utf-8?B?aFNNMG1CUVVCWUdoZlk5bVRJSHkyd0c5bm1GOG1HYmNRVVprS0gwRFFMM3gw?=
 =?utf-8?B?MllJQjV2T05weUVpaVdMTktNQnhsdFVJa25VcjdNNEZBOHZOa3VqNG5OdlJY?=
 =?utf-8?B?UksyTm5Jb0QrSlVEek5idVNwb0ZsR3dEUjlaMXF4aUc3UTM5TGpjem0wV0Iz?=
 =?utf-8?B?RHRqUHRjcDFLK0xiTDFjUVhRYXVPSUMyaEFoTGJkdmJhamp1MmI2Yk9Sb1hZ?=
 =?utf-8?B?SVA3bUpCbVNOK2xsYWh5SkdZQjFYQXA5V2g4RGFSTFQ5VGFNajZ5OEFXcUJJ?=
 =?utf-8?B?djdyTnJSeklUemNEamZrM0drM2diRWRGWnpScGo1YU10V042Qi9TRjVMQnl3?=
 =?utf-8?B?ZllPQ0w3dFZDdzRmendZbWJwRC9sNUVMcGdXbmJhNFlpOXhWYzVjeG9DZWwz?=
 =?utf-8?B?YjVjSDd1aUJIZnBtYmZueldhT09PTVplTDQ3ZTVaZ0MxdnFpWlhLSTdNYTRQ?=
 =?utf-8?B?OXR2MzI0d2pRYUhnTHYrZzNkTjFpWXN0ek9uZjFIMC9PQ0cxRFFiOWpHS09B?=
 =?utf-8?B?TG9XL2lBbDhSdFByOUEzdjVHZXFIME15MnZxc2VXM1puM3BNWnV5RkZRWWFY?=
 =?utf-8?B?TjdmdW1OSW80Vm94aGY2WGFCQWZ0clFobUI4R0xkVE9xYmhYR2kvNkRTV0RB?=
 =?utf-8?B?MXgvNVNrV1RFeEl5aUZTUDBubEw1NXowbVU1Z0Rab3BmWFVXWXhsQi8zOFlW?=
 =?utf-8?B?ckVpclFqdjVCMXY0RW9QWDNFS2F1NHcyKzJkSlBGZnhTbmhzUnQxQmNPOUFN?=
 =?utf-8?B?VDlaWVZnK3dhdy9aZHZlRGYzNHc3ZmNRVkc2NUN1UFNMSzVmR0R3UmpPMEhV?=
 =?utf-8?B?cUVzU2F4cElXaHk5SnM2Z1NDVjc5T0FsMFp3ZDJ4SGxVV2d5S0YvVmNpZ1VX?=
 =?utf-8?B?bEhjRzhKVlpocDhHNFRsblFGbkt3NkRCOC9lQTZ5YVV1SGVEOGRReWU1TUR4?=
 =?utf-8?B?bHBURUlQb2wvcTRtQk5IZG5MbWFXMnU5cXc3RVc0ME5BOHBtK1FKL3lmU1NE?=
 =?utf-8?B?VFlyVWg3d3JzT1puUFFaNDJTMmFaRkpmQk05elBqVHZFTU1FalpPQURPdjBS?=
 =?utf-8?B?U1BxTlFyUUc3R0EwSWY5anJNNStVK2lYWHJQLzZBTTB2Q1BSc3MxTURzK0pG?=
 =?utf-8?B?ZGxIWWg3YUFYY0NJci9ZVktsZFhXR21yYzMxbG9xTm1vejh2L2xxUm9aYmJE?=
 =?utf-8?Q?5vHuwPGd+86Omp1TJo2j/n3A7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b2a31-4168-4c52-f1a2-08ddcf76387b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:34:41.9023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj3yK3Fy7Me6F/ErstJSRB26yRGK0kQT6ICm/6ygyCvY0cRGf55Zc89CSFwfsBK49eFPtu9ROleqZzr1d92Gww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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



On 2025-07-30 04:19, Timur Kristóf wrote:
> On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
>>
>>
>> On 2025-07-23 11:58, Timur Kristóf wrote:
>>> Features like stereo sync and audio are not supported by RGB
>>> signals, so don't try to use them.
>>>
>>
>> Where does it say that?
>>
>> Harry
> 
> 1. Audio
> 
> VGA ports (and the analog part of DVI-I ports) simply cannot carry
> audio. So there is no hardware to control any audio, therefore there is
> nothing for this code to enable, which is why I added those ifs to not
> even try to enable audio on analog video signals.
> 

My bad, I was thinking RGB as opposed to YCbCr. Forgot that we use
RGB signal to refer to VGA.

> As a side note, DVI-D ports (and the digital part of DVI-I ports) may
> have a non-standard extension to carry digital audio signals, but that
> is not revelant to supporting analog displays.
> 
> 2. Stereo sync
> 
> With regards to stereo sync, I didn't find any reference to this in the
> legacy display code, so I assumed either it is unsupported or the VBIOS
> already sets it up correctly. At least, considering that the legacy
> code didn't bother setting it up, we don't lose any functionality if we
> leave it out of DC as well.
> 
> That being said, upon some further digging in the DCE register files, I
> found a register called DAC_STEREOSYNC_SELECT so maybe I could
> investigate using that. Maybe it would be better to work with the
> registers directly instead of the VBIOS? Would it be okay to
> investigate that further in a future patch series once this one is
> merged?
> 

I don't think DC supports stereo sync currently. I'm not sure there is
much value in pursuing that.

>>> diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h
>>> b/drivers/gpu/drm/amd/display/include/signal_types.h
>>> index a10d6b988aab..825a08fcb125 100644
>>> --- a/drivers/gpu/drm/amd/display/include/signal_types.h
>>> +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
>>> @@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum
>>> signal_type signal)
>>>  	}
>>>  }
>>>  
>>> +static inline bool dc_is_rgb_signal(enum signal_type signal)

To avoid confusion with people that haven't worked on analog
signals in years (or ever) it might be better to name this
dc_is_analog_signal.

Harry

>>> +{
>>> +	return (signal == SIGNAL_TYPE_RGB);
>>> +}
>>> +
>>>  static inline bool dc_is_tmds_signal(enum signal_type signal)
>>>  {
>>>  	switch (signal) {

