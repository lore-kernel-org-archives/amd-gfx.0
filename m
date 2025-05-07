Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF07DC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 12:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B91F10E798;
	Wed,  7 May 2025 12:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YOYXDnFY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1A410E798
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 12:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqrP1LyMG0jMYsgFYouGVDhPp1frXBg1oi5P0puO6w74g3D9vWxymRAZR40rdS+3zLaipI9xdqhPrq5ozzPfJGkwwwWqPaF6ubKm4PPAkQkceURNTIi1R0g3X9SEF8XMFwSfepNXTVXYtoqsQ03v+uVNbIYzlOvL5uTqmKZU3S0mGtKnmTWt0fheeNSLl18sezxakEdjfbrTbZx0HQMlGbuUCuGCGi8KCakpp+ObJ3i30Y+CiAr1IEg+rE9Awl6QjaAtrGgj1msAwjhnxCSf9vF8cG6QBAwdrOYr/VW2BNF3mVvicPqwWub6+w/h7UVDAPlcITpfkF+hmhmUuigOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/85G9nItg9mXMyMtw+fMrtSr8TskJ+rQhvGrKTywX+8=;
 b=qOCCkeDJchfBRNF3zFMN5uq/KXl8vjAmXazPud5b4Q/3cVbqOdw/yuC1d0FqoLprQbNLjFjrKT3xqDaxy4MHoCDqLUBEHLBpXi53fM76b1z0nUem7Q8yjvvm6fQ90Qf0zFoJagDxQh04E07URaYHSL0MpclWGsRANkoOOk3BqGnnFwyikiSZ31+6xRj9gWoxnPUtU7KlVBMgwUk/56qbZYvzHnjJth0uaLS1V6eEoAitamELJ1UcYvdFhb9CSHDeYOyIVkIZbz1OhFTo8EGhIlftsXZAPJXxUSipqxpkYCyB7rFewS/iL8n46QyL1owv2Ni4MEHoOMjyOreawZEPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/85G9nItg9mXMyMtw+fMrtSr8TskJ+rQhvGrKTywX+8=;
 b=YOYXDnFYX06f5i0apHXhEFQCFeOz1lDRCZ8XgdNogK3Hh2HH+9AWI29gOWfw/eIx5Ms79cBKS7c0vpjAqeE53v9BMSRbwNlWctQTcSJ7YUaIzsLr5w1JyX5zhi9CQYU0P4eb/37lDPt4thAdUVTu2AN64to/xO/62JXS/PipkX4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Wed, 7 May 2025 12:14:17 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 12:14:17 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Topic: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Thread-Index: AQHbuAbbGAa0pwMfOk2XdnXKBBngkbO7hSoQgAohxyCAAAncAIABF9mAgAAdVwCAADyeAA==
Date: Wed, 7 May 2025 12:14:17 +0000
Message-ID: <DS7PR12MB60052ECAC0FAF72ECEA90FF1FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
 <20250428062853.4057900-2-Prike.Liang@amd.com>
 <DS7PR12MB6005F7AA06172FDF96E96F59FB832@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB600557F4E08F81716AAD4D69FB89A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <72c1df20-46a5-459b-9c4b-5775a55bbae6@amd.com>
 <DS7PR12MB60059FF6EC19EC5485240D89FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <d399c75f-be3d-415c-bd2f-de9ee92751c5@amd.com>
In-Reply-To: <d399c75f-be3d-415c-bd2f-de9ee92751c5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=974f8111-7249-48a2-afce-c978f098376a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-07T12:12:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6275:EE_
x-ms-office365-filtering-correlation-id: 7d56e43a-b359-432e-4b28-08dd8d60b05a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?LzIyS3J1Q2R2V1RWTllTR3JDK1ZVRTZTVWNJL1ZISThEYkI0bUZMaUxpUEpn?=
 =?utf-8?B?L3ZQYThOSVNCUWRFWlZrWEE3RDRhOFIvUjhlYXRyQ2c4eWpJaVBVVkc2cFBq?=
 =?utf-8?B?NzNxcUQrRll3NHUwTHNabytCQmJaaXRlWStOQlpLNVVVbFJIbXlXdGdXZjV6?=
 =?utf-8?B?bWhtTll4VDc1L3ZyRk1iZG5sd29vUjBKUkFKd3VqRGh0MW5Za2tPNFBLMm9Z?=
 =?utf-8?B?cVlKdkJoUnc1cUJ6VmtndjNkZTRKNjJ4SC8yUC9nQkcwVDBJdXlGMzk0U3Yy?=
 =?utf-8?B?dHNKSWNSczFpS1ZzcXpRbFpVRkh6Sjd6cUtCOHBKVU4vNVJGc201Vmw2dWhU?=
 =?utf-8?B?UzBPMlZVRmVCQm9HVkFjeVBnSkNST3BpTGRITjFDMStDYXJhSVZFT1QvTEdn?=
 =?utf-8?B?N09CWDZ6TDd2UVVBSlZQMnRRQWtGSlphZDB1eHIwL3NabnZhQXBPVHdoM2hF?=
 =?utf-8?B?NE1mTEFRdUhneXZBaHFTTkpSYzh3MkN3UHdHM3NYZlBKUlRwVTNPTm5BaFBS?=
 =?utf-8?B?OXlxK3dkZ0xsTU1Wajl4Y2JWMldlY25XWnR6dUh6cTZsYnZ1QndWRWlKRGN0?=
 =?utf-8?B?QVpRZ2Y0VTlacjhBTWlGN2xUSmRxY3ZnZHZjdFN4MDBBVUMwU3IyZ2Uxd2J2?=
 =?utf-8?B?YkR6VmplMlc0UkxrMzVwZDdnSm1ZWjFLZ0I0UU8yWGRLZnlOaDVKSXdrc2sx?=
 =?utf-8?B?V1UvRnNLaGRNdEY3WGhxTkFGU1J1YUVMSFlOUmlub3R6OFRmWVZUTHd6dGtW?=
 =?utf-8?B?aThQbHpjbHMrOFdIN0xWdThpN0dBc2hVZlhRQ0lSNlpqTHpGYTlMZHd2T01O?=
 =?utf-8?B?Tk5vSzFEbXdSMHk0WklJT0hXd1RKRWUxcVc5SERMbXNRZzhUSk5pNGxuaFo3?=
 =?utf-8?B?cmVhK3UrbG15R1Yxa0dYWmthYXFDUnpGRGV6UFhrVUsvU3hTd1EzbHBleVJH?=
 =?utf-8?B?YmlmRnJmcUgvS25CTVVXcWZwOFJEWEQ4TzczQlhUQmRiY1NjNTFzSWh2cVkx?=
 =?utf-8?B?NWJ1UEFEK2czSDFHVVY0QzE4WHRDd2htbFF0K0hJaTlteWpBRzFQQUs2eTU1?=
 =?utf-8?B?MFdkY2RJYkowQWpXTkxaUlVJMWw2K2l4dmlsV0s5bFZLSFo5MzJQN0NGZVJP?=
 =?utf-8?B?dHFXSmd1c3dZR3QxdXY2MnlKTHNZZituT0tMUFVGZmZFWkhrR0RqcXhYQ3Fo?=
 =?utf-8?B?WElYZXJxTFhwaGpTMFplK2xmdFB4SWsvVjRWaDVyMDFINTEwNkY2TFBOdE1u?=
 =?utf-8?B?cE5JdmRWWE1ISWZWbmRiczkrOTM5OUo0c2pkdnNxekZvaVN6VHEvVDM1QzBG?=
 =?utf-8?B?S2hzandTTVphdE8wcmRSQ2VjNUVka2gwOEpTaXhJZzREUjNjY21tTEVDK3Q0?=
 =?utf-8?B?a0REM05UUkpZZjFsNGpTYnFiTnFZMTV6ajV5bEt3YzFTblV1MENDZ2hpYnVL?=
 =?utf-8?B?ZzcvcGRKWHFFeXNhaFBWazB2RDFKQVFSOUwxeTlvRW9DNUV2bldOZ2QrTFMy?=
 =?utf-8?B?bTcvTUVtMVJtSkd1YjdRemRYNUhraldQa0l4VkJFSnhZdm9ZQi9lOHN3ZTZY?=
 =?utf-8?B?Z3pKUFJ3WE41bnZiQXh3b1lIVkxBaFdCSUM2RDNtZFlsWFAyMEorNnJsZ2JM?=
 =?utf-8?B?SXpiQ29oVTBXZER4M2xMeTN3ZVdLdE40WTN4ZmJRM3ZUOUFuZGx4SGNNQWMr?=
 =?utf-8?B?N1l6R3hkRGtjL2FlRkpsN2NrWGMzV3J2QnAyR1gvQmN3eWc3TGc2T1ptemY2?=
 =?utf-8?B?REJYRjAvZkhZalN2UlRFN3lFcWtrV1I4SjVOK2xvOEFnb0FQYjJCWVk5RFls?=
 =?utf-8?B?WmNlNHBEK3VwejhpclRRZWdKd0JlNGEyOHhBYUxmRlZpMUg1SWVobHZSdGx2?=
 =?utf-8?B?NUs0S2R1RHkzQUJBYWJiNkZBa0d5TkxuaDd4U2pwR2IrZE5lQ01oWi84elFX?=
 =?utf-8?Q?nb8dLd7kvTo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNjU3dQQ0tHVVUrWHFqVXFiNkZOUjZ1QjMycHpRV2NUZ0pxMzNpeE1lQzdw?=
 =?utf-8?B?aHpWWnY3OVN6Y3Eya2RSNHlTUGozS2UzdjFDRk0yNEREeFAxV01GVmMwbmF4?=
 =?utf-8?B?NVpvMXhvT2wwcFF1cHlKTEh1bHhNU0xwcTYwUFQ1K3BmZUdOSXRVYzNGTkJ4?=
 =?utf-8?B?ejJvWG0zaGNXUjhPamJLSmJJZ0NYYTBINVpoSUZKcTR1TzJLUkd1SEMwNm5Q?=
 =?utf-8?B?UkFzL0FoR0E4ZElrUkpQZW93b1JEdFVwby8zZDVOeWxsdnE0ZTZDaFBBcDVm?=
 =?utf-8?B?RE5jM3lNSmptWHJoRktmbVRvZVRtZVNGUEZoZXdzR0hqdUYrWU5IeE1vNEJh?=
 =?utf-8?B?c1NlUGxnZlZ3ZHdKK2VycGV4UmVQd3VHVEtlamlweUJ4azM2czNFclFSdjFQ?=
 =?utf-8?B?ZEp5R3JZcEswRXRhTjFLcmtSYjNvNXY1ZVVFQlJhaHMraUkxc3RTVXpkOTBX?=
 =?utf-8?B?ZFNFc2xFYWVXanNQWmRWVzVOMXdxQWNaSWQ1eXNtWWNCZnFZZ2txbTBXRHZ4?=
 =?utf-8?B?UVo3QlFPb0tkeUtqd0xpTWUrWGhidkRqcFVRbjdUbmtuREFaVUNJRlpHK3lp?=
 =?utf-8?B?R3UvOG9LZEVrODU5UWx3SzRVSWJSRnNQNTFod1FFVUxWbTQvRXErVEl3SlBB?=
 =?utf-8?B?dm91eHU0Ynh0d0ZScS82ZEdKaXUvRGlaZE13L1lxS0ZRaTVKZW9JeDVkQ1ow?=
 =?utf-8?B?SjdzbC9UOXRseGRpS3ZUOUxvWmxtdzU0aUl2dnhXZ09rZ2pXaVFOcEt0WWkz?=
 =?utf-8?B?M0dOU212STU4Q0RSSzhMM012cm9aM1ZSbk82Mng5ajgzV1V3c0V5U1BFdFJi?=
 =?utf-8?B?L2lLOW9FWEtsNzN5bXU4ZkRrR1dnVmlRMnRRM0Y4M1QwRjBpc1hwbFBGcmZR?=
 =?utf-8?B?cXhITWhJRmY4aWNvRjAwR0JZckM4MFdWTlZBeW9uSXJESGZnSGo3ZnFpV0ht?=
 =?utf-8?B?blZoeFI1RG9ON3JwNU0rMkRzZzgxbFZnSFlIUTlPR2RMcnNleWJBME1GODF1?=
 =?utf-8?B?T0tqMnpqRTA3ZDRNMWY0Y0ViV0NVQmY2aU5TdTYxN1doTDNwUEowOVVRZlNn?=
 =?utf-8?B?a3crSld3T3hLUjBUYVkyVHMrcndlYUo3Sk52SDZ2R1ZFblJDTFlrNWZPSml2?=
 =?utf-8?B?ZFI4dDNVclpxT0JKTWRxa0NwaE5ocHFQeUJXcDM3bElQQUhUUkV0MUxpNDBU?=
 =?utf-8?B?akI3SWZMci84VlpTTzdmcVE4NE43ek8ybTZWSVlvSEZJakJqUERkWWRieExP?=
 =?utf-8?B?TXBhSUVnems1YTBYYmhFc2NYYlRDWUdTWE1iNDlwQ3I3dzlUQS9uUVFvbHB0?=
 =?utf-8?B?dXZIOXZuRHZJcTJFalFBSU5vd3FOa3JTWDcyZlB2WGgzek5vNmlyT1gvUmYr?=
 =?utf-8?B?R3l4VWxxeGJQdmlJamp2cTJFVWpBT3JPR01EdnB3STBybkMxb1VnQWlQVFlj?=
 =?utf-8?B?eUpFT2tVZDlhSnE5ZnhjeHk5RE9NWi84a1BFZmhselFka053am9NTzJvSnhq?=
 =?utf-8?B?OUhSZ290ZTA0MnVHUnlrZXJTU1JjOURqSXJjemlpMyt4NHBoZUdaTDdra05Y?=
 =?utf-8?B?aExLTENqWXZadlRUdmtsQWplR0kzbXFYOXkzOERtNERHbXVPdEIvd2pjdm00?=
 =?utf-8?B?YUY3YlJaakVHVDViQTFVK1VxbEJOM2FwNGhvTmJNNkRjZFNjbmM3Q2IveThi?=
 =?utf-8?B?NFlKeVFKS2ZpK3BCdTlQbGlqZmIzU2ExOWhPeGVpZHQ4ZzdnZmh4TWptTTNU?=
 =?utf-8?B?T0o3c0Evb3VxYUJkbWpNTFRsdVB4OW9Ddkgzb0trK2xLdmpkZlc5MmgwUkJS?=
 =?utf-8?B?OEZJQjZxbzgvYkV1bDdnUjhsS3VjWjdjS3BZeWp3Q2QxN2l3cnQrV3FUZCtV?=
 =?utf-8?B?RkZQYlNrU1VqcWFEL3VtdFJGQ1V5cG44VENtRGZEWmp0UGdrVnVjWFpCMHhm?=
 =?utf-8?B?OVBreWdCOEtHVS92Yzk3ME9JeDZvRVNwTFVCYzhxOGJFZDBXTDJrVHh3ZUs1?=
 =?utf-8?B?QmwyemNDc2kyUnFNT05SK3laNDF0WWdXWWxSaUhGbGZaMlRiODZpeTA0bUdY?=
 =?utf-8?B?N21iTzlQL1Q2L3FLengvb1JzOEdpbllFU2xOVC9YZXhFYXpGMUk2VFhrdjkx?=
 =?utf-8?Q?8fBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d56e43a-b359-432e-4b28-08dd8d60b05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 12:14:17.1035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tT10V90ElKaX5/57nNB93Yc2JI/EuoFWj/jKbYU8xqeV23OU6vq4ZUgkvU6V9cn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSA3LCAyMDI1IDQ6MzYgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBsb2cgdGhlIHVzZXIg
cXVldWUgb2JqZWN0IFBSVCBtYXBwaW5nDQo+DQo+IE9uIDUvNy8yNSAwOTowNSwgTGlhbmcsIFBy
aWtlIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgTWF5IDYsIDIwMjUgMTA6MDkgUE0NCj4gPj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBsb2cg
dGhlIHVzZXIgcXVldWUgb2JqZWN0IFBSVA0KPiA+PiBtYXBwaW5nDQo+ID4+DQo+ID4+IE9uIDUv
Ni8yNSAxNTozNCwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+Pj4gW1B1YmxpY10NCj4gPj4+DQo+
ID4+PiBBbnkgZmVlZGJhY2s/DQo+ID4+DQo+ID4+DQo+ID4+IFNvcnJ5IHRvdGFsbHkgbWlzc2Vk
IHRoYXQuIFdlIGFscmVhZHkgaGF2ZSBhIHRyYWNlIHBvaW50IGZvciBhbGwgcGFnZSB0YWJsZQ0K
PiB1cGRhdGVzLg0KPiA+Pg0KPiA+PiBJZiB5b3Ugd2FudCB0byBvbmx5IHNlZSB0aGUgUFJUIHVw
ZGF0ZXMgeW91IGNhbiBwb3RlbnRpYWxseSBlbmFibGUgdGhhdCBhcyBhDQo+IGZpbHRlci4NCj4g
Pj4NCj4gPj4gSSBjYW4gdHJ5IHRvIGNvbWUgdXAgd2l0aCB0aGUgbmVjZXNzYXJ5IGNvbW1hbmRz
IGZvciB0aGF0IGlmIHlvdSB3YW50Lg0KPiA+IFllcywgd2UgY2FuIGNoZWNrIHRoZSBQUlQgbWFw
cGluZ3MgYnkgY2hlY2tpbmcgdGhlIHRyYWNlIHBvaW50IGF0DQo+IGFtZGdwdV92bV9zZXRfcHRl
cygpIG9yIGFtZGdwdV92bV91cGRhdGVfcHRlcygpLCBidXQgaXQgcmVxdWlyZXMgZnVydGhlcg0K
PiBwYXJzaW5nIHRoZSBQVEUgZmxhZyBhbmQgUFRFIHVwZGF0ZSBvd25lci4NCj4gPiBBbnl3YXks
IGl0J3Mgb2sgdG8gY29uZmlybSB0aGUgdXNlciBxdWV1ZSBQUlQgbWFwcGluZyBieSBjaGVja2lu
ZyB0aGUgdHJhY2UNCj4gcG9pbnQsIGFuZCBJIHdpbGwgZHJvcCB0aGUgcGF0Y2ggc2V0cy4NCj4N
Cj4gVGhlIHRyYWNlIHBvaW50cyBoYXZlIGJ1aWxkIGluIGZpbHRlciBmdW5jdGlvbmFsaXR5IGFu
ZCB5b3UgY2FuIGFsc28gdXNlIHRoZSBSTVYgdG9vbA0KPiB0byB2aXN1YWxpemUgd2hhdCBpcyBn
b2luZyBvbiBpbiB0aGUgYWRkcmVzcyBzcGFjZTogaHR0cHM6Ly9ncHVvcGVuLmNvbS9ybXYvDQoN
ClRoYW5rcywgSSB3aWxsIHRyeSBpdCBvdXQuDQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0K
Pg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFByaWtlDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+
IENocmlzdGlhbi4NCj4gPj4NCj4gPj4+DQo+ID4+PiBSZWdhcmRzLA0KPiA+Pj4gICAgICAgUHJp
a2UNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9t
OiBMaWFuZywgUHJpa2UNCj4gPj4+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDEw
OjUxIEFNDQo+ID4+Pj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+Pj4g
Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5p
ZywNCj4gPj4+PiBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPj4+PiBT
dWJqZWN0OiBSRTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogbG9nIHRoZSB1c2VyIHF1ZXVlIG9i
amVjdCBQUlQNCj4gPj4+PiBtYXBwaW5nDQo+ID4+Pj4NCj4gPj4+PiBTb2Z0IHBpbmcgZm9yIHRo
aXMgc2VyaWVzLg0KPiA+Pj4+DQo+ID4+Pj4gUmVnYXJkcywNCj4gPj4+PiAgICAgICBQcmlrZQ0K
PiA+Pj4+DQo+ID4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+IEZyb206
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4+Pj4gU2VudDogTW9uZGF5
LCBBcHJpbCAyOCwgMjAyNSAyOjI5IFBNDQo+ID4+Pj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+Pj4+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgS29lbmlnLA0KPiA+Pj4+PiBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IExpYW5nLCBQcmlrZQ0KPiA+Pj4+PiA8UHJpa2UuTGlhbmdAYW1kLmNvbT4N
Cj4gPj4+Pj4gU3ViamVjdDogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogbG9nIHRoZSB1c2VyIHF1
ZXVlIG9iamVjdCBQUlQNCj4gPj4+Pj4gbWFwcGluZw0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGlzIHBh
dGNoIHdpbGwgbG9nIHRoZSB1c2VyIHF1ZXVlIGJ1ZmZlciBQUlQgbWFwcGluZywgYW5kIHRoaXMN
Cj4gPj4+Pj4gd2lsbCBoZWxwIG9uIGNoZWNraW5nIHRoZSB1c2VyIHF1ZXVlIFBSVCBmdW5jdGlv
bmFsIHN0YXR1cy4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcg
PFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3B0LmMgfCA0ICsrKysNCj4gPj4+Pj4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+ID4+Pj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3B0LmMNCj4gPj4+Pj4gaW5kZXggMzAwMjIx
MjNiMGJmLi43OTkyYTk3Zjg3NDUgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+ID4+Pj4+IEBAIC05MDMsNiArOTAzLDEwIEBA
IGludCBhbWRncHVfdm1fcHRlc191cGRhdGUoc3RydWN0DQo+ID4+Pj4+IGFtZGdwdV92bV91cGRh
dGVfcGFyYW1zICpwYXJhbXMsDQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVwZF9mbGFncywNCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm0tPnRhc2tfaW5mbyA/DQo+ID4+Pj4+IHZt
LT50YXNrX2luZm8tDQo+ID4+Pj4+PiB0Z2lkIDogMCwNCj4gPj4+Pj4NCj4gPj4+Pj4gdm0tPmlt
bWVkaWF0ZS5mZW5jZV9jb250ZXh0KTsNCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAgICBpZiAo
dXBkX2ZsYWdzIHwgQU1ER1BVX1BURV9QUlRfRkxBRyhhZGV2KSkgew0KPiA+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHBhcmFtcy0+dm0tPmlzX3VzZXJxX2NvbnRleHQpDQo+
ID4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9kYmdfcmF0ZWxp
bWl0ZWQoYWRldi0+ZGV2LA0KPiA+Pj4+PiArICJUaGUga2dkDQo+ID4+Pj4+IHVzZXIgcXVldWUg
UFJUIG1hcCBpcyBmdW5jdGlvbmFsXG4iKTsNCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAgICB9
DQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3ZtX3B0ZV91cGRhdGVfZmxhZ3Mo
cGFyYW1zLA0KPiA+Pj4+PiB0b19hbWRncHVfYm9fdm0ocHQpLA0KPiA+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cnNvci5sZXZlbCwgcGVfc3Rh
cnQsIGRzdCwNCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBucHRlcywgaW5jciwNCj4gPj4+Pj4gdXBkX2ZsYWdzKTsNCj4gPj4+Pj4gLS0NCj4g
Pj4+Pj4gMi4zNC4xDQo+ID4+Pg0KPiA+DQoNCg==
