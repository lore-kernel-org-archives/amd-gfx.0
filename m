Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D6BC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 06:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9158B10E0D7;
	Tue, 30 Jul 2024 06:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uW9W0Szk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DAE10E0D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 06:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDLm5Rp2PB3eNz2gYefsxMDr7xwfcayONTOwOmVeHsR9hHE6ZaLI1WTUbrgbQuQJ7TFPyDvdBGEKEQVGXfsNEhpSHSfPJuM0Xq1IH6FrL3TRUgDYG4zlzCjMdzzAl2AIt3cDJF0915EzqLxX/dOR8ueMFKR4aBxbto88b1+ka3M+jimNkoDPwTlLIDdosUe/BxWrqHDhLT8JbEH7cGXmB83mebWyujB7Xd16h6Wit2j96ekvcnpHcr3AJX6hz/EGg0cH62yWBmnueHa4Sv8hUQ48f8tqHBhWgp5hTRyMCbbbA5h6bWIOOPu9xF1CZYDEl6hz1sHyTciV+IrT0C1+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hN+kU1zowWJTh8WzICLkNESqMJKm4IYcO5D24HkJXw=;
 b=NF3rSfdVkjRku3QE9lqYlsfoNteMtgnBdjzKOF/L7+mJOcXP5sNC6MyXP2usVJvR/1Oml/BTUO2YRcwP8o/j4k2mM/twjHrWbbA859UiArrfEF54ov+Yv4tkqjBukKEzYFuQQbd5ye7MPLeeCznnlKf6LCga9gdv89txj6a0esRIrDYgak0Q0Ydv3iuJHexKxD0aNpIDXZ9Tbs/9SIyvmzKuk4UUOemgOf1bkpCIIIPFWFqd5H65XXMKJ5HO7Pll9cI3q3trgpTfxcw5uPYojY/w+VuGO0l3sss287hn/gnKj+6pV6JV/+HTj4vxBJ5kjOj9E4HbrYczCwmDPIwMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hN+kU1zowWJTh8WzICLkNESqMJKm4IYcO5D24HkJXw=;
 b=uW9W0Szkoa7pA4b1r+YMAOPvyc+j3llZ1sFXkZ+NHNKsnbrPm3pgpsGZRICsj3g47ECpmGqBH1i1/pZ+cPoYK5wM0TD/4ckt9CGBWBWi5Y73EKokDB678oWs0zx/hh4uWzHxQvoxRt0A+P2uOxseWsNBRgTGmbaQ6uRLPG7Nico=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:00:07 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 06:00:07 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: Jiri Slaby <jirislaby@kernel.org>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>
Subject: RE: [PATCH 08/43] drm/amd/display: FEC overhead should be checked
 once for mst slot nums
Thread-Topic: [PATCH 08/43] drm/amd/display: FEC overhead should be checked
 once for mst slot nums
Thread-Index: AQHagUlg6Cef/KmCfUCiXusgiAZVNrH8wD8AgBLH2sA=
Date: Tue, 30 Jul 2024 06:00:07 +0000
Message-ID: <CO6PR12MB5489857D91F3CDC7F7517D02FCB02@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
 <20240328195047.2843715-9-Roman.Li@amd.com>
 <87138377-d5b0-4c28-96bd-35a0ffd5f204@kernel.org>
In-Reply-To: <87138377-d5b0-4c28-96bd-35a0ffd5f204@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1ba4d850-3739-4be4-bb32-79c152c507cf;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-30T05:57:29Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|LV8PR12MB9110:EE_
x-ms-office365-filtering-correlation-id: f8363ff6-bf6f-4b62-5ee2-08dcb05cdd32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M3pWNHdCMS8wcWlZNS9LY0lRYTI3bjhucVdrSndZdUpnN2xCUWxZeEZLUlhO?=
 =?utf-8?B?ZnpIc2N4aXdoNmJwVjJsR0FnSVB4TFR5NEhlN2lYN1FHcWMwRWdtUjI4bTBw?=
 =?utf-8?B?a08vV0tZenNSL1kvMFJkVHg0aXR3cWdFYWQrK2Y1NFpVTDBvb0ZkNWpQTzg5?=
 =?utf-8?B?azYreG0wd3FKWVJUdkNQVWdkdXJFRERGM1ZwQWo3ZUNnTUFOUHY2RzZaaVFs?=
 =?utf-8?B?aDBBcWQ5QlYxcmRiaTI5dDBBUTNGQllXY3AvRU1QZmo5WFZDb0pKUGh3U3Yv?=
 =?utf-8?B?eTRBclBBNkJPejFxNzF4LzBqaTd4QXYyK2IwMW1VNFBKVkVHSnBVOVZVREdy?=
 =?utf-8?B?OFVSbGdSUlk2ZnlMdDNhbEV6THlDNGVucE1MbVNLQ1BkRUoxbktpdmIrNjZj?=
 =?utf-8?B?c1BEZVFSMTRYa3pRZGszemU5QXNFc2FEaVgwSDNpWEJmamJYOUFYMnhscDc1?=
 =?utf-8?B?TnNGVFJ5ZXBLVm1mUU1vRXl3ektJRS9ibTJoaVhkUFRBVU1iZUM4WkZxVTNk?=
 =?utf-8?B?T3RzT2ZoZzV2dExGVWhqSllySlFUQzVuVm1Gc0xxVy9lZXBsV1huRXFhNWpT?=
 =?utf-8?B?U2pSeE53LzlsTUhLdlpqdXZ5eW91dkh4OUwyNGFOaE0yeHA0RzBESFNCMjl2?=
 =?utf-8?B?UUVjMGk4Lyt0TUtZUUNQUE1rQ1B2N2xwY1ZlektrOTBsWm4vT0tGcW5nWEwy?=
 =?utf-8?B?akNSNGZrQ2xpRXg1Mit1UDRBdUZpMCszTDhMNC9iQlJYbVBuZzRwM2tNTmpu?=
 =?utf-8?B?Z0lkY2V2TUZ1bkhqUlQrMkZod0xrTGpRcGlYZUhRSTNUUDJORWZFNkE2TzV1?=
 =?utf-8?B?bXQ0QmZ5SGR2RDhKVHBQejYwTWFPWHVoMHdpTUgrdHIrKzliMmREUXgrUzJE?=
 =?utf-8?B?MjZhK2t5c3g3QTlEYW1ZY3pabnNKM1JLZlY3SnM0N2cydDFjakRzMjEvV1hW?=
 =?utf-8?B?Z1NSV1djN0ppVEt4VEVTdUtuVkRqMW50VjdVOEE5ZWR2Z2NydXRuVXovSzhY?=
 =?utf-8?B?SzV3dWUwTTNQZzh0ZmlORWVoQStEY1FZWmR6bllBQmdpckJCZFBHTURheHJV?=
 =?utf-8?B?WW5Ca1E5UWliZjQvWkQ5OWE3UzhYc21mZDhwN0RvTVp5SVBlVzJhMmNVMzFn?=
 =?utf-8?B?amJIeE4yRGFuNkJrbWVlSnNYNUh2NzhSaFBGQkVuWkdOYzViSldkbHJpeUdD?=
 =?utf-8?B?YXczWWw2WTcvOWh3NjFWOXlkWVZ3RWRHWUhJRG8xN3h3WEh0dDM1dEhyN01j?=
 =?utf-8?B?UmVQT0Y1ZWRCcTNlOGdjZ0Z2ejRHRER1Tm5qejRVMW1NOURPOG9LWG1ISDZY?=
 =?utf-8?B?eFhkeU1LQWQxanBKZjdKb1FFNGcwTEVoWVVtSm9ON1FPMjRhYjlKS3dxZVhi?=
 =?utf-8?B?R3M1eGw1Nk9XdGU3bnV0OE1yWElqdVRNbGZuTit1K0hXSjFrZ2RsclA3V1E0?=
 =?utf-8?B?SVUwZERBZ1Y5MTB0YklhdkxtbkRkQ0h2YWxTWm9qOW50WlJYOElWR0xBSGhF?=
 =?utf-8?B?eGljaEx5MTRUZHVPK2dxbFdXMHNWUGp6RGxFSTkvMzEyOXhhS0lwQmpyU2lp?=
 =?utf-8?B?YURFRklaSXkyOURlckFNK2V3VlEycUxpUjdza1FrZjhXUEwrZlBhT0MvcXZZ?=
 =?utf-8?B?RHRZQzVyQjBad00za1dXM3BQaVpkNVl5TFU4MjFjUC9yNzBqeHZPQUIyeW5L?=
 =?utf-8?B?YWY5citITjNUeEdWY1FMeFJTV2lOQmlWb25zTTZoc2RpRzZocitCK3NoUlBJ?=
 =?utf-8?B?cDQrSGJReUxMTEF2YUo2aE5kYzUwdTVqa0VKQ3pURVdrd0JDYjhIa3I3Uzhj?=
 =?utf-8?Q?8c2fphXazJcaDVoYjnmkz2H5yGiFEBx/NFT+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzZ4cjNmRG1WMjlkMGN0aDg2UUY0enVjajk2VzUwYzFzejJOK25mUFRDUUk2?=
 =?utf-8?B?eTlOUktsRGx6OTBDMFBKMTV1cWh3N1NmOGM3RnMrQ0V5aXdqQmZNRERla08r?=
 =?utf-8?B?SlJNd3piQ2xDNjQzdFh4R1F1RC85cXR3WEt6YTRwREx5NWcwSktnSmR6UExF?=
 =?utf-8?B?UlRSZUt2WnkzTU9BQVBUTDdwN3pkNHI5NW5MV0lzMXN2M2pFNE04cnd1VVUr?=
 =?utf-8?B?WjloQy9LaS9uMnU1QmRON2p6cnovajlzWks1VDdOZTcxUHlXQUgxNUZPNXd4?=
 =?utf-8?B?ekREd0ZJamV4RnBRUXNYS0JIbFRHK1NkSHcwdTVOQThReENOeVhmbVhPQnFT?=
 =?utf-8?B?OEFSWnBCb3BhNWFKc1NLdTFkUGVoZXRzbVFMOVk3QUxWRHhvdTA5dVY4NHZD?=
 =?utf-8?B?eGVHQ2ZsMjNGQ0c0TXluNnhvNTlFQUUvSWpoUlIrMEpQZUJDcEdGclV6Z3Ni?=
 =?utf-8?B?blA3T1hyQklYRElsL0NTZitPNW10b0dDSVVIYmhvdUFoaE9FbjR1dEYrLzR3?=
 =?utf-8?B?NEFFcThTM0ZjVGRLN3RYQ2lnNll0UHVjRDE2ZUlpQW1Zdm9LMkkzSEdRRDAy?=
 =?utf-8?B?SkFMRDlmUHlaQVd4MSsrQnZVRnVJa1lzY1lmVEVYMk9zT1ZHUW1rVEYxWXBW?=
 =?utf-8?B?akkyL3FrRVNkSC9xM2M3MllKcCt5YUMrRWRuTGMrVHIzNzZ4WlY5TStyMHUv?=
 =?utf-8?B?eUdkcEl0ODZQalZYc1BzYVJNK05TL3g1TE1jWVFDZEJGN2F5b3J0VVZFSzdr?=
 =?utf-8?B?bFF1L0J5dFNyaVJmS2tJS0ttRTdCek5QMElZMjM0amFJS0VkRVhVaHVma3Zp?=
 =?utf-8?B?cjlCWHNvWkN0OGxsRjFqbDd4Q3IxN1ZBTUdHVXFUc3M2dW9IZDlScjlRUGdI?=
 =?utf-8?B?Q0ZmMHFjM2UrSVVYSjF1L3lSQXpIKzZoTGVVSmxXakdMWVlaVnpNOVJvM0Va?=
 =?utf-8?B?MzJjb2l0MCsvSU43bmc5bXhYQ2xPdFFwZ1BNbUhEL2VTcldMeWpuSmhXMlVk?=
 =?utf-8?B?V0lKRkFWYUVleEg0UFpDZ0tNaDRISWd3MHhHdGwxb3VXUnFGVVRubmowVXJp?=
 =?utf-8?B?ZXdHZVJ4S0diRis1OVNrNHBSZXV4VzFPWi90QlRJUDdMMlpGUGVrenhHZUtl?=
 =?utf-8?B?WGE3Y1RycjhReWRML0x6UWQvVlVpS2d0KzhjS09MOEhBNm94SDJ3dVV5Rmp4?=
 =?utf-8?B?d2o4cisrZ2VVd0NXUEFJeEFGOTJmOFpvV3QwWkJNRHd5K1U4QThyUFZPY29C?=
 =?utf-8?B?VWtwT09Hc2FodEtQS0U4NzFQSUJHM253bW9tdy9PTnoydXBXZ1JCdmg4S0dM?=
 =?utf-8?B?YkZ1QnBVQmZsQXlsTnpXakRCSnlRZ0tkdUtlQi9hWGNZL2gwTjFCTTcxRDc0?=
 =?utf-8?B?YTBjR3dRTm1HQjkrV2FCamErYTFvdVppNmNsTWFnVERoQ3l2eU9kUmVidlRw?=
 =?utf-8?B?QVpZY2d6eG5MbnNuNVZLK2ZVMGV4N1BzMGN5dXdvSjY5cHVOb3NjME5IcUlD?=
 =?utf-8?B?d1M4T1ExRExNMEhqZXpwVDFSUWNSUEwxK1laNm1sVVo3dXk2OS84OGNnQ2Mv?=
 =?utf-8?B?ekFSbkkzQ1lOQTdpWGRmeFpHakFQWGhHYXVUNW1YcDJiWjhyb0JZSmJEbVlX?=
 =?utf-8?B?Q1g0VGNTSllGNHIzeXIyTzNFaHdNRkEzaVdiT0dKQkxDRm5YSTVvd3Y3UWwx?=
 =?utf-8?B?T0JXdWFGdW05Ynh0eHRKUzcvU0hSUTZSZEZyQyt6clloWjU4RGJVSWJ2NUZm?=
 =?utf-8?B?SWRjdUZEZVd2UllzVXhLazgvU0xST2FoTnUyTzVoSzFQZXk5RStQMmx0cVh4?=
 =?utf-8?B?c3YrTktHZXpyTjloM21Jak50Vm5oNitOUnNXTjN4K2lBNmNHT3puOWRCa0ox?=
 =?utf-8?B?YmE3Qnp5OFpIOFNxL2FQWFRDZmk0T05zZU9pZ2ZPTkxtNmtYdkdlUndxU3FF?=
 =?utf-8?B?cUJsNXVueXZoTzM1Y1ZzankxeVZRMGFhcUtiRjN2SURDNDR0aFh0K245VnEw?=
 =?utf-8?B?Q3JVWkVvcnFGUlJCQ1U5VFVnMkxpNnNHWnN6QzEreUQ5RkwzVkNzTjJMZ3RO?=
 =?utf-8?B?emhQOVhXUWY0TkpuZGNaRSsydkdaSndTZXJHbUpBOEhMNlAxTjZpMzZUOVpp?=
 =?utf-8?Q?S1bU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8363ff6-bf6f-4b62-5ee2-08dcb05cdd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 06:00:07.3727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLhTlf9SLcr2ZR3Q/ZIZs9aHWn0fUpQzR8/BvulytuaQdi2BfrYOUN10THwfC+6FOGgobLDtLI+T/ZPM0qZraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

W1B1YmxpY10NCg0KSGksDQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydCENCldlJ3JlIGdvaW5nIHRv
IHJldmVydCBpdCBhbmQgY2MgdG8gc3RhYmxlLg0KDQpSZWdhcmRzLA0KV2F5bmUNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE4LCAyMDI0IDM6MDkgUE0NCj4gVG86IExp
LCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBXaGVlbGVyLCBEYW5pZWwgPERhbmllbC5XaGVlbGVyQGFtZC5jb20+OyBXZW50bGFu
ZCwgSGFycnkNCj4gPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExlbykg
PFN1bnBlbmcuTGlAYW1kLmNvbT47DQo+IFNpcXVlaXJhLCBSb2RyaWdvIDxSb2RyaWdvLlNpcXVl
aXJhQGFtZC5jb20+OyBQaWxsYWksIEF1cmFiaW5kbw0KPiA8QXVyYWJpbmRvLlBpbGxhaUBhbWQu
Y29tPjsgTGluLCBXYXluZSA8V2F5bmUuTGluQGFtZC5jb20+OyBDaGl1LA0KPiBTb2xvbW9uIDxT
b2xvbW9uLkNoaXVAYW1kLmNvbT47IEd1dGllcnJleiwgQWd1c3Rpbg0KPiA8QWd1c3Rpbi5HdXRp
ZXJyZXpAYW1kLmNvbT47IE1haGZvb3osIEhhbXphDQo+IDxIYW16YS5NYWhmb296QGFtZC5jb20+
OyBXdSwgSGVyc2VuIDxoZXJzZW54cy53dUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDA4LzQzXSBkcm0vYW1kL2Rpc3BsYXk6IEZFQyBvdmVyaGVhZCBzaG91bGQgYmUNCj4gY2hlY2tl
ZCBvbmNlIGZvciBtc3Qgc2xvdCBudW1zDQo+DQo+IE9uIDI4LiAwMy4gMjQsIDIwOjUwLCBSb21h
bi5MaUBhbWQuY29tIHdyb3RlOg0KPiA+IEZyb206IEhlcnNlbiBXdSA8aGVyc2VueHMud3VAYW1k
LmNvbT4NCj4gPg0KPiA+IFtXaHldIE1zdCBzbG90IG51bXMgZXF1YWxzIHRvIHBibiAvIHBibl9k
aXYuDQo+ID4NCj4gPiBUb2RheSwgcGJuX2RpdiByZWZlcnMgdG8gZG1fbXN0X2dldF9wYm5fZGl2
aWRlciAtPg0KPiA+IGRjX2xpbmtfYmFuZHdpZHRoX2ticHMuIEluIGRwX2xpbmtfYmFuZHdpZHRo
X2ticHMsIHdoaWNoIGluY2x1ZGVzDQo+ID4gZWZmZWN0IG9mIEZFQyBvdmVyaGVhZCBhbHJlYWR5
LiBBcyByZXN1bHQsIHdlIHNob3VsZCBub3QgaW5jbHVkZQ0KPiA+IGVmZmVjdCBvZiBGRUMgb3Zl
cmhlYWQgYWdhaW4gd2hpbGUgY2FsY3VsYXRpbmcgcGJuIGJ5IGtwYnNfdG9fcGVha19wYm4NCj4g
PiAoc3RyZWFtX2ticHMpLg0KPiA+DQo+ID4gW0hvd10gSW5jbHVkZSBGRUMgb3ZlcmhlYWQgd2l0
aGluIGRwX2xpbmtfYmFuZHdpZHRoX2ticHMuDQo+ID4gUmVtb3ZlIEZFQyBvdmVyaGVhZCBmcm9t
IGticHNfdG9fcGVha19wYm4uDQo+DQo+IEhpLCB0aGlzIDYuMTAgY29tbWl0ICg4YjJjYjMyY2Yw
YzYxMykgY2F1c2VzIG15IHNlY29uZGFyeSBtb25pdG9yIG5vdCB0bw0KPiBjb21lIHVwIGF0IGFs
bC4NCj4NCj4gUmV2ZXJ0aW5nIHRoaXMgb24gdG9wIG9mIDYuMTAgbWFrZXMgaXQgd29yayBhZ2Fp
bi4NCj4NCj4gUmVwb3J0ZWQgYXMgKG1vcmUgZGV0YWlscyk6DQo+IGh0dHBzOi8vZ2l0bGFiLmZy
ZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzM0OTUNCj4gaHR0cHM6Ly9idWd6aWxsYS5z
dXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIyODA5Mw0KPg0KPiA+IFJldmlld2VkLWJ5OiBXYXlu
ZSBMaW4gPHdheW5lLmxpbkBhbWQuY29tPg0KPiA+IEFja2VkLWJ5OiBSb21hbiBMaSA8cm9tYW4u
bGlAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIZXJzZW4gV3UgPGhlcnNlbnhzLnd1QGFt
ZC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBEYW5pZWwgV2hlZWxlciA8ZGFuaWVsLndoZWVsZXJAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0
X3R5cGVzLmMgICB8IDM3ICsrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgIC4uLi9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmggICB8ICAzIC0tDQo+ID4gICAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPg0KPiB0aGFua3MsDQo+
IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0KDQo=
