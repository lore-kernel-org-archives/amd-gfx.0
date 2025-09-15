Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E6DCAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 14:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0143810E4CA;
	Mon, 15 Sep 2025 14:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEhVgOF9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBB210E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 14:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOxf0T6/jLQZYGTsBdV3xtu6WAGEqHExCchrx4i+Ap59vtnk4IJMjX2PYqrgJtEO1JqFWOHHgTSbzPiSOjkAb/doBsFFOznzXXmJ9Fquyk/nESaUKlqv0tJA9DOLrJDBAjswig5AiW4VhJaZeW0JD3GS38lJnHJ0x2IC6yMeK1SAmakmD28ayoyB4TYT6vS5xX4VfhFucNoy/RPK7mD5Do643IM9CQgpOhDCCjRnDqdAbANTkzi2iwxjMLoGQvps3ksaZjae9EKAl9SJ3p0IUX6sfjhzg0cFELX4zVphp8UbSPAeg70aOiMFDqJjwbcoSYcCyLCC1z8NlaunKer/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D7OBozjWZKsXHQRlvUm15tTYxGiDR5bj6XMA/6EZ0w=;
 b=BBMLjTOt3nB27fEW1QrAapa3EV1KpC2Y9BDQWnGYhS0am3n2eF3AI7L2yWLiEbB1fdhkGN+CgBy90BiZrARM6MNUR9Xf1xRip9H6N6W64A07n72L4uwsTIGYzU+ZOPPFY8pLf0Ae0c/Q06i+AktNbijWvi/6Mvm2RbAbbv+/eUdwiORWK+EVBp4m0qveX5een94stIf/EBjxG+gWP8LyQki9cfYQdp02C8kCKj8hBluW3sSLmZ1Vmw7/t+JMwFOXhyOsbqb7IZBsheaUv8fRCpRsO4Hsq3q/bF2Qh907iq62D0J6peF5BqYorxVzw0rsvTW7QOXsqi0/36lCxPfcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D7OBozjWZKsXHQRlvUm15tTYxGiDR5bj6XMA/6EZ0w=;
 b=kEhVgOF9RwqQNH6K1b6JoD0hzRu+8gAfmO5z66VGmTR6XaSrWwCIAFgxbeaod2TrLHjVL/E3Bhvay/T60R96hTUEodWHY/c2Qq+v77flvLgMA5xcbH8JrYx/WGDbs0hHze6f65ilK9btvRXymrw1SG43jZflifxz3ou/+4Wd2Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 15 Sep
 2025 14:32:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 14:32:28 +0000
Message-ID: <e5546919-aca4-4f8c-be0f-0895f3eb28ee@amd.com>
Date: Mon, 15 Sep 2025 16:32:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad
 context
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250915133356.3547174-1-alexander.deucher@amd.com>
 <70e8c427-f816-4bdb-8f92-9382cd5ab13a@amd.com>
 <CADnq5_PUzTPcAchWfQGzsBc_SgY6E11B5aHMv8472NMoGPz48A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PUzTPcAchWfQGzsBc_SgY6E11B5aHMv8472NMoGPz48A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfd5866-1d31-418c-42b1-08ddf464b26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzU0bXlMdEQ4YUNtL3gzVHNuZUFtcS9tbEQzaTRRZGtMQUlkbm1yT2lLYmp4?=
 =?utf-8?B?UUlMaHZXMDJtNkVrZmo5RHFuRWJrUlZrVkpzYzI0Zk4wUm93ZTB1TnNjVE1x?=
 =?utf-8?B?SnRrNjhlMTlaR2tITGJNWTZ4V0dUdlRSS0Z5akFUSHM2U25qdEVYZUpqcXJu?=
 =?utf-8?B?ZVUraFdOTElGTlNhRE44ZWM2RkZEY2RadTltVzMxU0NWaVhYQ3RtSythVDlX?=
 =?utf-8?B?dkc3N05yMmF3MEhSYmRQMlc4RytKS0lLUnV1NTNsdnQ1K3lXSW5zL1JWTllP?=
 =?utf-8?B?SFRobUhCQmY5anNsVkxrVFAvTUJhT1lTZ2dMNEFLZDNsV2ZxeDVpQ2xmRmpj?=
 =?utf-8?B?bVFnQ0p6NnFrSVJrQVpXRklybk1kWUVtU055STd6ZWxyNW5xb1ZrcS9sKzE3?=
 =?utf-8?B?ZnZQa2VQOHg0citMWGVEREk0RFhVUm9rTzFPTEFibHpSUFlEWXR4cVhqR3JG?=
 =?utf-8?B?V24vMDNKMGRnbEo5TVdjdmtzTThEWVVVeGQ4Wm8rQSs3SWJZSmsvbFVpTGhx?=
 =?utf-8?B?eEx3V2J2NzlIdlVzN0I1Wkg5eGhkZzdXcndEeUF3dUgzS25OaCs3UThkV3Mr?=
 =?utf-8?B?N1VIajQ0bFdoRFVwVVlYb3diQ05KY2JuOWljK2xSbVZYaHRsNnI1SXJMOXBw?=
 =?utf-8?B?amQxSEJjbXA3VHpxeFdkTEl0aFBsRVVWaENwSG5KQTVvRFFpMzVoaDZPc3Qw?=
 =?utf-8?B?UHg0aUNHZnlBdW5kUHg5ODAxWnlFUWZkcnZUUGdHS0dsclllNVJJcTBEM2lR?=
 =?utf-8?B?WlBTdEFpdGJDTHFCdXdPRk9Lck9pczR2ejNCZ1Ztd0lEbUgrYldOZVBLMFlp?=
 =?utf-8?B?RGRKZHh6VnR5bWRjcE54dzdjVDZaODBiTTZxdVZOUXBpZHBTWEFSRVpsR1N0?=
 =?utf-8?B?cVZ4UjNNMTBMaHJhNzNDeG55ZFJSeXlTT3lweTN6R1lFbHY4WXZ4OUoxRmwx?=
 =?utf-8?B?RGpUdDltRjNub0FwS1lkNTMrVGQrQnkwb25LK0t6OSsvUXZkbEN6ZmhENjVI?=
 =?utf-8?B?TnRmZ2Nwaks0OGhaVGdSMW15L3ZpWEljNzJHSGxrQUhSeTBabmtWS0NRZXp5?=
 =?utf-8?B?MVZmYXpBd2pRTzZLOUwvby9hSXJVaDVJNkdDTGU4WXFtTTZIT0lkb3VWeFp0?=
 =?utf-8?B?UEJ0M2ovYTVPS2NyNTR5ZHdSdmpNNkhRYkY3S3VHWlpWVUFPcEVrREwxdFhs?=
 =?utf-8?B?K3BBc1UwR0FDTDhCbzhhc2YrRUthbFBzTjNNaVBsdHlHRnI0WnI5WGZ4TWZh?=
 =?utf-8?B?UElzVFBVeUZlanVaODRiQzNocjFlcFNIelRaN3VjOFVOdXQ0RVQwaG1WUEUz?=
 =?utf-8?B?aHprSndZRWJVbkdzVjRGY1pmVXNrYmxKQVlnYk1PeEF3MGJuNmdyc2lDYzRY?=
 =?utf-8?B?L3ZUTGlNM0ptcmxMSVV3bFV6NEFCbmo5OEpEZWxwMVhLOU1MNkVnakM3Kys3?=
 =?utf-8?B?dDhyaXkybjYwRmloT0NGTndOam8yWE5EU25PRzEvRFRWRXJzaXVobE12MWcx?=
 =?utf-8?B?QmFGanRSblYzcURHSGlETWI0ME1pSGdRM3lJNjdtTHlQWVVoa2p5ajNxSVVh?=
 =?utf-8?B?TnhFMUFTYWlEVlJpZXZwQ25HeHdaLzRzSVhqWXJTN1JMeVZsd092S2tIOGVI?=
 =?utf-8?B?aXN3amc3VEZNcjFCSDgvNlVORmFJbmllL216Q0RMUDQ0K0dDeEh5RkFNaE5l?=
 =?utf-8?B?NmRtMXo0U0lxV3F2U1BEMkhyRW5lTnFlR3NVTTQ2a0tuZTFtTDlqaC90TDZo?=
 =?utf-8?B?anVIYU5Fb0ZoMmJCenNLZ3MzaDZwWlViY2ZYOWE1VWFGZEZHQUV3NXp3d3hq?=
 =?utf-8?B?ZGp2N0YreExBZkJRN290Wnh0L1lwb0FnNEM4WFhuWXJJWkdWZE1IOWhPUThD?=
 =?utf-8?B?WjJORXE2R2x3WWtuTE82djJTOUhEVTNPMWpuZnFWQWVoWTdrYnc1SW1MWXhp?=
 =?utf-8?Q?fHYhh96rxtw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCs0R0puVXI2RTVuR2RxVXI3dXNDazZONENVaHEzTGc4WmljRkFNUGRIRHBo?=
 =?utf-8?B?ZG5jVEF2R2wya3g3VDRlRGNUMWVNeHYvdlREM1FGTkx1cmRhbkxKNWFXeHpi?=
 =?utf-8?B?K0hvc244aGthYU1xL3hZOWRzaCtJUFhJYzBZU1NUOWcxUTJsK1RjOEM4WGhv?=
 =?utf-8?B?dnJsMDNxTGhzellhSFVwV1llTC8xNnBGb1RRNmVHZWtaT3NqcWx6UWJaV1N1?=
 =?utf-8?B?bTltNVp2cURGMS84d1hMUGhNWGlodTdxSlFBcHJ0QjBzdWpwdWNXS1lVRkY2?=
 =?utf-8?B?WXlTT0IzSHpxeFhISlVnNTROK1UzbEtPUnQ0cmcydWZSUnlwWXMrVlQ5WS9k?=
 =?utf-8?B?V1Z6YXRmMldndFppcFVKMXBTR01kdGdhTmMzeDJwZnhoS05mU1ZLUUw0YUts?=
 =?utf-8?B?eWJVMXFma2plL3F5SjRYRVlQZGVqb2RsMnM3aW5ONHlsdjhBRnhRNHYybk4y?=
 =?utf-8?B?aTNkbktBZlJkZy85YjBWbUZzR3p6SjFFdEUyaG5RTThGWmdzMytTRmtSWTdp?=
 =?utf-8?B?VGlDa3hpVjZUMzByMG5GM0RTWmp1M0hJRnV0ZUdiZnhSU3R3Nzd2RXZwdHgr?=
 =?utf-8?B?b2o4YkZmdE5jZ2JrVjhzakd1elUrWUpUKzR1Z1RyM0FGcEFlVy84NHJITmxo?=
 =?utf-8?B?SS9TT0hiMlFiZXQ2OC9SRXdETDZFa29zbzY1MXQ3bHdvUXJ2Qk1td1BKYjVH?=
 =?utf-8?B?bGlheFpaS2FwVTAwaTF5UU5LSk45WUlaZTQ4dWVDSGVCczIrQnBFTG1oT1Bj?=
 =?utf-8?B?NFZWcTlhWk4xS3o0MXZHMGZTdW1BOXEzU3dVRDExTldmZnVxOFA0VWFpWC9M?=
 =?utf-8?B?V1FuN1hEWFVYbldtMHFhenBxZWxLOGo2WkV6cFJBMEVsNUgxK0tzSjNLVWJZ?=
 =?utf-8?B?QjhXVDJwUXdWU0tNbVAydnVPYWw1N0NZQ0JRcE95eXNpdlcxTlhXYk9tM0N2?=
 =?utf-8?B?UG1MZ1prdHFMV2lGRGJIcmw5aVlNVEJaUnYvdEEwTCtFVFlCekl1Znl1MmNn?=
 =?utf-8?B?QWt4azh4UDQ4V3JaOFlKdVBTeDJSUkcwaE1TRktKMkVEMTNiNnFkWExvUE9w?=
 =?utf-8?B?bFNoRUJNZm1RZUFwQkhIUHBnTnFTR1ZTMk0vTHBNT3lCSW01ZHQ3NEwwVkZH?=
 =?utf-8?B?dkpyRFhOYlVKYkRDMXJIWDEvU09MUFVPeU9CV25GQzhyaG5uWXQ0V1lVN285?=
 =?utf-8?B?UEJhdHhSSEZkUG9wbWhwRDdRQlVueW9WZ0Y0U29DSlJWQ0lKT3lVTnFJSVBk?=
 =?utf-8?B?UUh3SUFEQTc1V244TWpPN0ZjTGwzM0VGWFBNL1I3MUdGNlpXSzB5NU9pNDgr?=
 =?utf-8?B?S0Zscy8yY1c4aUxGRkNCY1VlQnQxOFh5eFJLajhrb0wvaHlDckpUQUZIb1Mw?=
 =?utf-8?B?QlRHVTVjVHF0Z1VId1BpcFJ5YlJrVTRXSzhIMzhEbUp4bFlKTTRvU1liZk1I?=
 =?utf-8?B?NHFaTUZjUGhsTjNrclhudHUyMlB1ZEJXUFRBVC8yaEtGaVo2bnZHUmRiQU5v?=
 =?utf-8?B?WlpGZThjWUJEWjJUMzRsSUQ0SlhZOHg1K2RQNGZoaFdWeFd4djlxQUZ4WmdL?=
 =?utf-8?B?SHcwVVg3YUZUL0hRNm5uVHBTeTA1WVJkandrVVdnREdabVVPaE8reTVRM0Ey?=
 =?utf-8?B?RUtyRHB6Tk9meVRlbzBvenpmQnFsdC9iQlhSOWhHT0dPRkUyWjByY2pGY2N5?=
 =?utf-8?B?UzNzdW5nYUFnTk05U0RkaElHUHQzVGpmckpURnd0VE1IOVVMN3JKQ0QrUkdS?=
 =?utf-8?B?S24vbmhNckplK1dnais1WkxxZjVtMnRUTDNrZXo4OXJ5bzlvVFE1L1FXZW5Z?=
 =?utf-8?B?TFFwRnBmeTZ3bUNDYVJ4dHVXL05rVHZUZUdacEdUN2MwVUJJNG5nMVhuMWxx?=
 =?utf-8?B?Rmt3Z29SaGdrZXg4OWkycDMzazZqWS9rWFRUQ3VsTVFqMWdHUHc0aFA3bnpp?=
 =?utf-8?B?ejBqVTNvcTZBZmxDV1ZmMnpucEpmRllOa28vUStCcVdBcFc0c3E1YWxqbC9J?=
 =?utf-8?B?clcyR01DdXFJd3VLMUJNdG94aVdpQTJua0plWi9WSXFlRUI3UmwvcEJMYTFa?=
 =?utf-8?B?OTVOdmNRU2lQc3BabmtvKzVLVEtBWWVja1hndWduekpndmUxbjJLcm1HZTc3?=
 =?utf-8?Q?0HXMc089sskO+Xlak3QvPOgJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfd5866-1d31-418c-42b1-08ddf464b26a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:32:28.5051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23PbcyQCmyOiJZeYokcSBVApCyC95AuJ6VkrNpbY/MVbZRmpBfWi5FTVlZoYj8lS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

On 15.09.25 16:24, Alex Deucher wrote:
> On Mon, Sep 15, 2025 at 9:59 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>
>>
>> On 15.09.25 15:33, Alex Deucher wrote:
>>> When we backup ring contents to reemit after a queue reset,
>>> we don't backup ring contents from the bad context.  When
>>> we signal the fences, we should set an error on those
>>> fences as well.
>>>
>>> v2: misc cleanups
>>> v3: add locking for fence error, fix comment (Christian)
>>>
>>> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
>>>  3 files changed, 31 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index fd8cca241da62..72f0f16924476 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>>>   * @fence: fence of the ring to signal
>>>   *
>>>   */
>>> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
>>> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>>>  {
>>> -     dma_fence_set_error(&fence->base, -ETIME);
>>> -     amdgpu_fence_write(fence->ring, fence->seq);
>>> -     amdgpu_fence_process(fence->ring);
>>> +     struct dma_fence *unprocessed;
>>> +     struct dma_fence __rcu **ptr;
>>> +     struct amdgpu_fence *fence;
>>> +     struct amdgpu_ring *ring = af->ring;
>>> +     unsigned long flags;
>>> +     u64 i, seqno;
>>> +
>>> +     seqno = amdgpu_fence_read(ring);
>>> +
>>> +     spin_lock_irqsave(&ring->fence_drv.lock, flags);
>>> +     for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
>>
>> That won't work, the seqno can wrap around.
>>
>> I would just go over all fences, e.g. from 0 to end of array.
>>
>> The checks below should make sure that we don't try to set an error on something already processed.
>>
>>> +             ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
>>> +             rcu_read_lock();
>>> +             unprocessed = rcu_dereference(*ptr);
>>> +
>>> +             if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
>>
>> dma_fence_is_signaled_locked(), otherwise the function would try to lock the same spinlock again.
>>
>>> +                     fence = container_of(unprocessed, struct amdgpu_fence, base);
>>> +
>>> +                     if (fence == af)
>>> +                             dma_fence_set_error(&fence->base, -ETIME);
>>> +                     else if (fence->context == af->context)
>>> +                             dma_fence_set_error(&fence->base, -ECANCELED);
>>> +             }
>>> +             rcu_read_unlock();
>>> +     }
>>> +     spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
>>
>>> +     amdgpu_fence_write(ring, af->seq);
>>> +     amdgpu_fence_process(ring);
>>
>> That's actually wrong. We want the other fences to signal later on when we process them.
> 
> This fence is the original guilty fence.  The other fences will
> naturally signal when the later fences signal.

Ah, got it. But that is still racy as hell.

We should probably rather signal the guilty fence separately by calling dma_fence_signal().

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>  }
>>>
>>>  void amdgpu_fence_save_wptr(struct dma_fence *fence)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 6379bb25bf5ce..f6c9decedbd51 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>>>       if (r)
>>>               return r;
>>>
>>> -     /* signal the fence of the bad job */
>>> +     /* signal the guilty fence and set an error on all fences from the context */
>>>       if (guilty_fence)
>>>               amdgpu_fence_driver_guilty_force_completion(guilty_fence);
>>>       /* Re-emit the non-guilty commands */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 7670f5d82b9e4..0704fd9b85fdb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
>>> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
>>>  void amdgpu_fence_save_wptr(struct dma_fence *fence);
>>>
>>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>

