Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFE3CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 21:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75D110E0A7;
	Mon, 18 Aug 2025 21:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cw2rxE+Q";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650C610E0A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 21:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhGQTxKPxLW8UiGiCTyVZhqWkrhMQ+X7+WKd69S08eogQanNr2KbIbx17da/ixyfUPptzoLGQw7P2dGa5NErWphZM/OQ95Wqdwsnar4xOEhy35rTY537t4KGrwfivNMq5jXkmwl91wL1oUhkXKMlcDeW2ke20PyC0uM0+j0x2Udglz1OfesJ3YSA/Bk5zywCpiTVG/LwMWN97u10NvJztjRrrisnjMNT9/bPPpH92Dt7GIp08v5EgFteDiERvPoPxhrjVauu3mShLgd5hZQXM3H6yVVNVg9qVS3k8REH5mlIeifa/vNxXPa9gcB6RO+PWq1iPMvLtcyAJE1Y0I+lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+fjQvI5gsfuCW0ASV17FgCtqMkivTU0D/U5LDuf4qI=;
 b=U/S81U80Ng/ktBdEg6jSQJiA+mdHjC0Xrhvoa5THz1KZ4liqqbiWNVJq7ipgpq66t4xQ3C1IWA7zW9eHWP2oFPbOes7/U47Hgl4atyHtAYgdiRBTirkOaNuNcp3bCa2noPBtNCVGsoJN29to8XDz6dwgB2xnhWd4kP8rI3gyiGczlbwp81PpxoJJYanIIOSG4fs/CG+MHYJhtOgtFdiFoZkSYZ85x5nhfnN3jv3nR11fw86GORbsZkLMHLW2nElj9XJHDp5vi6rb2K9beiLBujNt2NvDoEksGYNBJ2iDjDyRKJouG4VHEkZS2lX85p93JB2iIVB7aCEUfugNAucclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+fjQvI5gsfuCW0ASV17FgCtqMkivTU0D/U5LDuf4qI=;
 b=Cw2rxE+Q6vYaGUey7nN1eDyTaqJdzu6BY3HAex52bCv7TFIibDvJCsjvW5EbxmZ8gDtQCTgHS5ttCjAOiR8Gsyu/ni8N4OoVPFbYCbD2MDXzyMrJ40sV8Y4yskU0GsFXhrTzMfa56M/eVChG34lavwnnI66YON04iCN95yHpgsI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 21:18:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 21:18:02 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Hung, Alex" <Alex.Hung@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: Re: [PATCH 07/11] drm/amd/display: Attach privacy screen to DRM
 connector
Thread-Topic: [PATCH 07/11] drm/amd/display: Attach privacy screen to DRM
 connector
Thread-Index: AQHcDKnyYMguBY5qSEGu8YDGmZsc4bRo8WiAgAAAbAA=
Date: Mon, 18 Aug 2025 21:18:02 +0000
Message-ID: <78266d43-9d6e-4e22-84de-e30ea0def90e@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
 <20250813232532.2661638-8-alex.hung@amd.com>
 <CADnq5_NhgCORJE6YqiWfS8qX2FK6b9y8dHjHf1quXrUP_MrFMw@mail.gmail.com>
In-Reply-To: <CADnq5_NhgCORJE6YqiWfS8qX2FK6b9y8dHjHf1quXrUP_MrFMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: afb0582a-a9dc-4189-98ad-08ddde9cb752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWNlRngrZERvRG1QUGZ0N2FzSVNMR29uOFByVDR3eVVsZ1BKa0g1dGhzOUFl?=
 =?utf-8?B?aHd5bTlNNTdQWlI0MHFTSERNZk1yUDAxVFJTT2dEdE9Mb0VFZmZRc2toSzRD?=
 =?utf-8?B?Q2ZialU4Qi9ZYUE1OTlDMkRPNURUTmVpemtpaHkxOWd0L09scnhZZGtrTUZ2?=
 =?utf-8?B?amRhbUYybXA5dmlqTHQ3VG5rbTJ5c1ZTdTN5SkQ2RGd3TWZrVkkrQW5DTndo?=
 =?utf-8?B?UUF4Y2RPdHIxY1M4L2FPTGNHS2NncXZWbXhsRktLVG1VR1lOODVhYnB3ckJI?=
 =?utf-8?B?NEFESDA1cmowYTFaLzZrOWlDRWVGcjRCY25XZXFGcWRXU1VhbnVISFQxckJa?=
 =?utf-8?B?U0E5L0dGa01nVFVXN0RBTWkrZ1BKRTVxVVR1NnpJUnNxWDFyanRDR2cwZW51?=
 =?utf-8?B?ZnVna0NabHRYM2VzcHgyUWsrN1BCSFV2L3RPTVptQ3ZheFdySTlpVHlMZmsv?=
 =?utf-8?B?S0hnWWpnMUxuN3pKRzNtRVcra0Nab1pMRVJGa240WXV4NnM4b3FCaE8vV25n?=
 =?utf-8?B?UEJOcmVTVHFERUJxaU9QenQ5NzNVUGVXdDZPRWYwTjU4VDFUTFhLTEEvNllZ?=
 =?utf-8?B?Um9NTkJDSnVwYlZiUTYya2hjL25nZldpWkd4eUhKNERreEc2cjNBcFJsL3NE?=
 =?utf-8?B?c0trQ0cyTW9YS1piTG1BTU9PUWxZMG9HeWI3NWdLdTRONmFIMkZhdDBGcitC?=
 =?utf-8?B?dEtMa2xvZm5CakJuMjk2STBpSzZ5TmQ3WGovNzFUTGhPS3Bhb2hCeXJKaUpG?=
 =?utf-8?B?Sk1HQi9mbkNuRmZSS0FONFJaYXNpeGhiR0dKaXFvaFNLbXNLdzFvcmFKaysr?=
 =?utf-8?B?RUtnbzBLdlNod3QxdHhBaFFWRXdkWjQweFQ5U3lIREZYcHVVVlk2bXZjNGJr?=
 =?utf-8?B?UHU4Q0g3ZmVMMFZ2S01MWVlrWURFeEpDYjNPMkNBK3pJODVrelQrMDFpNkIw?=
 =?utf-8?B?MlRNK1FqWDlHVWxlaDk5dG12R0tSd1o0OGpVM3JlSyt3NFF0OHBPMmx0T2Vw?=
 =?utf-8?B?WS8wNzVuM1BhRndLQXBDcGswcEkxZDVzeTlNc1NGVXFhYk40Q2VDWnErejJt?=
 =?utf-8?B?V2o5Y0xjNmswNDl0bHh3YmtzTVJYbmJCeGViODhMOEF0MEZoTS9WV08wQ2xh?=
 =?utf-8?B?dGpwMk9zRTkzZldyaGI0UmkwamNKbFp4M1gzUXFTcXFKQzVKNm1MdGVuajdH?=
 =?utf-8?B?czFzNFQzaUZhMVhUZEcxaUMzSWt5RE8xTFIwbnhja0JLcTVXNE4wMzFmZG5B?=
 =?utf-8?B?RUIzWmxHcXN0dGxTOVlzaDJBSzFlOHc2M3R6eUMyQWtOU3p0eFZWdjU5QzZE?=
 =?utf-8?B?NDFUbGhaN1NFWDgvalVXbnArQzBXSU5YT0MwZzg3VVhiekNpT01KSUkreWcv?=
 =?utf-8?B?ZG1MMS9Pc0wvY2F3bWMxSTBPWVV3cEtoQ1dobmRQQzNtVEdEaVFBaG1McGNX?=
 =?utf-8?B?SVpXaW15UFhrYzlkeEY1bVVhdTRVbnVhZ3FlaHFYY1ZqckFRZkZoQ2JxSCtP?=
 =?utf-8?B?NjVXV3RtOGJUVjZrckhzSEhKSmY2aFdlcFYwaVJnVDlFWkpySFRnSXl5c3JL?=
 =?utf-8?B?ODM5NjVSRjVYT1JOdlV2U3kzT0MrbDlrNzlMT3FqNzJlSkFzQ0NNM3JOb0Rs?=
 =?utf-8?B?amxERTlkNmFQcE5UclNwejUybklpZFF4emZYMCtVeVVXWnF4dkhTNVJvMnZG?=
 =?utf-8?B?L2FkUWx3NzVqS3d3UzJvY0JKRGJpaEszbjRETGtWSDh0a2tPalcycW9SUWtN?=
 =?utf-8?B?MVZwakNJY2NUaEVub3podjdHcEMzeXo1VkhvSFZVZTF1MkFVMGJSN3cwMG1m?=
 =?utf-8?B?MlY0eUNVbkRUQkc0S3pzeUpWYjkrbHZqTG9ZWExmcHdaamVaTkFQSWxtdHNG?=
 =?utf-8?B?U2w4eUxpQ2xOT3Exa0FWcndQdnJ0czBkUmdYMTMrUzE3emcyNGV3U0wxVlpt?=
 =?utf-8?B?UEFlRUtBZ0x0UjU4aDE2YXhiZ1ZobmxFNzI5RE41Y3ZMY0lCRzVaWVhCczNF?=
 =?utf-8?Q?R8ON5+76K9ALr21z5X0qk4pV8wvHK4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVlGZ1VpMUNQeGZNb2pnUTV4Nk9SMENJWWdqZnJHSk9rd2hVbjhiYkhmNk9w?=
 =?utf-8?B?QmxBOTE1VFdEdmh3NDd2UG1ISU8vdEVRcFh4dlZrRlo3WEMxbm1CL3JLMTBj?=
 =?utf-8?B?UnEwZHlOMzkwWTJkTmxnTUIvV1ZVa0REdEQxUjhvVmFuSkc5T3VScWR1YmdO?=
 =?utf-8?B?M1IwS0xXcCtFcW9mRXdyVFU0NEd1b2dtWXAvZG45R1llMHdNRldXV1E1RFpS?=
 =?utf-8?B?MDIwY0svNnovVGduUCtwQXU0bUdTYmJpaWcxT2IvUFlyN09BN24wcTN6TXVN?=
 =?utf-8?B?cUpnRkdGcnFsVWM5ZEhtT3hOaG5kNjBDeEVCWDQrZEVCQlNoUVJybXYvbWZ6?=
 =?utf-8?B?RVNJQ3JYNzVCR2Jnd0g4MXVJMnRVeC93YjI0SjdhajhXWHYrNm5EZ1lPMkpI?=
 =?utf-8?B?MFFibkdNc2FHOUFkemhhQ0hLQXJhdU9DNDc1YS9LbDBMNXpYSE1hbmtEdHds?=
 =?utf-8?B?NU5HdnJDcVQ5RWpNUXJ5aEFTRjdvTlFCcUNjQzllNEQ1dy9lK2x3dmF3NG1Y?=
 =?utf-8?B?dG5DRmM2dzhUMFdVUm9hM2ljZ21ITGlLWlR6SDRoTWFNY05LeWZOcGFUZ1Yw?=
 =?utf-8?B?dEpodWpyTk9DbkFvUGpMVVAzMS9RSjZnYXVNdXF6UW0zTktTeTVZK0tORHlz?=
 =?utf-8?B?T1dLQlh2eTlOR1FmNWdlbm9HZ2pZR2txQ3FsYkRmSjVKRlI1cSswWTNYb0JE?=
 =?utf-8?B?Y1VpaFpuK0sxaG5CdlFwejlTWGN4b1lhanRwMUk1ZmNZZFk2a2FPZkFWRDVB?=
 =?utf-8?B?bEkvdlh3RjJXWXFjbFRzN3ZlUHduTmR5S0xLaVVyQmdrMjMrWG12OEc3anNa?=
 =?utf-8?B?a2RRREhWL0pvL3hWTjVOSWFhTVFhZ1FNakR4TUlDZ2FZL1U5YVNGOEppNXBN?=
 =?utf-8?B?eHJYLy9QWGIvd2txN3NYdmJWaEJlRXhEb1hnWlplYzJlSnczNHJtWXdwWnFP?=
 =?utf-8?B?WHhNTVY1R0tFWTBPQ0tISXQ0VHRuandBMnhZVERuMjBKeWtRN2xkcVRYS1cx?=
 =?utf-8?B?SEV3enBTbWZvRUJmbXNuU0RtWnRmLzdPSzQrKzR6QVp5ckVoTDdUL21adzVN?=
 =?utf-8?B?UmYrWlNOZWJUejRtd3NTN2owOURwRm1scC96RHdvMG40K0NWNENHdjBPTkNZ?=
 =?utf-8?B?ZjlKbFYrSlpEYks2a25PZW9hMzdvK0tPamR3UDhaaTJLRFNJSFFLaC90MFNG?=
 =?utf-8?B?VUpxRHBjYkNwQ3NTRi9ZeC9iKy9GM3ptTHMyZi9sMVRWTG1RVGQzd2QzWm9i?=
 =?utf-8?B?TkFFcjhXQ3A0eFY3OUQydE15a1loYjNoU3pKcTVCdUFyNDhnb1VMMGRJZFNR?=
 =?utf-8?B?c0lPY05hcW5ZdHV0LzJ0TlhibVpsR2NvbDByTWkzZjFYS2RoTHFKQXpxSzl3?=
 =?utf-8?B?VkVabEhlZS9VaGVFeFhNVExJZnhadWUwcEViZkVjWXpqTXdEcE91N1ZxdmM4?=
 =?utf-8?B?b3JXMS9mS2pURlZ4WDNmbWxiMkpiekZRTmk2SkpOSUY1UjBOYlFoUXpmam83?=
 =?utf-8?B?dXdjdWFDNThyYkRLMDJBaFpZdjVLWk44anpJWjlYcFJUa2l0alBpY09neER6?=
 =?utf-8?B?NElvaFNqV3VRb3dmVUN6SmkzNDQyNWo1WUpBdDlGOVpvYUpjeG1CZXNIcldP?=
 =?utf-8?B?RW1pcDJiQkpIYnI0UTFWVHA3QzZLNSt1eU0rT0JMMmQ1a3o0SG01VlBGMUdy?=
 =?utf-8?B?S0NqN1BoSER3WGNibUM2Q0JWeVBiczljMlkzUlZPUzhJSzZjQ3RFSUlZdWha?=
 =?utf-8?B?ODdDOHNOYTA0VTgyaVViUG5IKzI0eGdqSHZwTjR6QUE3WExEYnNRZEVaRmRl?=
 =?utf-8?B?TkcwSXc3T0xQWjgwZitIeDJ3Q1BPQk53dFhOYllBUGorejE3T2svaFI0Wk1x?=
 =?utf-8?B?UUt1VjJMUk8yK1MrYWYzdDBlbHhyc3Fpbld4b1NJeXdSUkdGSGxrMXFTazV0?=
 =?utf-8?B?dXZxaU9GSUNlaC9vZys0TUFRck1vTDYyVVV5ODVKV0tpaFFJWE0zdVlRTnZN?=
 =?utf-8?B?YXlBOFAvN2JtZ3VNUmdFQ0hTZU9jb2xkUGYwSFRVMm9UZW9QTGR0WXB4R3Ex?=
 =?utf-8?B?aGxGMGVkZStDdi8yUStnZWl0R0VBYzFsUWYyT3hDNGdsLzJsTlhxU1loTUpw?=
 =?utf-8?Q?bMqs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A3BC4BE6B0AA344A6430C9745D8CF1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb0582a-a9dc-4189-98ad-08ddde9cb752
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 21:18:02.8098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H02rWIByAMtoaDyHOCSanwZoKPTVMutibdiYrts9bV/Nszu0bfWiXIQocbLqdFE8zy8sd/RTzscm+X5Yf8PM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

T24gOC8xOC8yNSA0OjE2IFBNLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDEz
LCAyMDI1IGF0IDc6MzPigK9QTSBBbGV4IEh1bmcgPGFsZXguaHVuZ0BhbWQuY29tPiB3cm90ZToN
Cj4+DQo+PiBGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNv
bT4NCj4+DQo+PiBbV0hZXQ0KPj4gSWYgYSBzeXN0ZW0gaGFzIGEgcHJpdmFjeSBzY3JlZW4gYWR2
ZXJ0aXNlZCBieSBhIGRyaXZlciBpdCBzaG91bGQNCj4+IGJlIGluY2x1ZGVkIGluIHRoZSBEUk0g
Y29ubmVjdG9yIGZvciB0aGUgZURQIHBhbmVsLg0KPj4NCj4+IFtIT1ddDQo+PiBEZXRlY3Qgc3Rh
dGljYWxseSBkZWNsYXJlZCBwcml2YWN5IHNjcmVlbnMgd2hlbiBjcmVhdGluZyBlRFAgY29ubmVj
dG9yDQo+PiBhbmQgYXR0YWNoIHByaXZhY3kgc2NyZWVuIERSTSBwcm9wZXJ0aWVzLg0KPj4NCj4+
IFJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBIdW5nIDxhbGV4Lmh1bmdAYW1kLmNvbT4NCj4+
IC0tLQ0KPj4gICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
fCAyNSArKysrKysrKysrKysrKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+PiBpbmRleCBlOGNmYWUyYmQyYWUuLjE3
NmY0MjBlZmZkOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4+IEBAIC04MCw2ICs4MCw3IEBADQo+PiAgICNpbmNs
dWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3NvcnQuaD4NCj4+
DQo+PiArI2luY2x1ZGUgPGRybS9kcm1fcHJpdmFjeV9zY3JlZW5fY29uc3VtZXIuaD4NCj4+ICAg
I2luY2x1ZGUgPGRybS9kaXNwbGF5L2RybV9kcF9tc3RfaGVscGVyLmg+DQo+PiAgICNpbmNsdWRl
IDxkcm0vZGlzcGxheS9kcm1faGRtaV9oZWxwZXIuaD4NCj4+ICAgI2luY2x1ZGUgPGRybS9kcm1f
YXRvbWljLmg+DQo+PiBAQCAtNzg0Niw2ICs3ODQ3LDE0IEBAIGFtZGdwdV9kbV9jb25uZWN0b3Jf
YXRvbWljX2NoZWNrKHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uLA0KPj4gICAgICAgICAgaWYg
KCFjcnRjKQ0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+PiArICAgICAgIGlm
IChuZXdfY29uX3N0YXRlLT5wcml2YWN5X3NjcmVlbl9zd19zdGF0ZSAhPSBvbGRfY29uX3N0YXRl
LT5wcml2YWN5X3NjcmVlbl9zd19zdGF0ZSkgew0KPj4gKyAgICAgICAgICAgICAgIG5ld19jcnRj
X3N0YXRlID0gZHJtX2F0b21pY19nZXRfY3J0Y19zdGF0ZShzdGF0ZSwgY3J0Yyk7DQo+PiArICAg
ICAgICAgICAgICAgaWYgKElTX0VSUihuZXdfY3J0Y19zdGF0ZSkpDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gUFRSX0VSUihuZXdfY3J0Y19zdGF0ZSk7DQo+PiArDQo+PiArICAg
ICAgICAgICAgICAgbmV3X2NydGNfc3RhdGUtPm1vZGVfY2hhbmdlZCA9IHRydWU7DQo+PiArICAg
ICAgIH0NCj4+ICsNCj4+ICAgICAgICAgIGlmIChuZXdfY29uX3N0YXRlLT5jb2xvcnNwYWNlICE9
IG9sZF9jb25fc3RhdGUtPmNvbG9yc3BhY2UpIHsNCj4+ICAgICAgICAgICAgICAgICAgbmV3X2Ny
dGNfc3RhdGUgPSBkcm1fYXRvbWljX2dldF9jcnRjX3N0YXRlKHN0YXRlLCBjcnRjKTsNCj4+ICAg
ICAgICAgICAgICAgICAgaWYgKElTX0VSUihuZXdfY3J0Y19zdGF0ZSkpDQo+PiBAQCAtODU0MSw2
ICs4NTUwLDE4IEBAIHZvaWQgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9pbml0X2hlbHBlcihzdHJ1Y3Qg
YW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAqZG0sDQo+PiAgICAgICAgICAgICAgICAgIGlmIChhZGV2
LT5kbS5oZGNwX3dvcmtxdWV1ZSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBkcm1fY29u
bmVjdG9yX2F0dGFjaF9jb250ZW50X3Byb3RlY3Rpb25fcHJvcGVydHkoJmFjb25uZWN0b3ItPmJh
c2UsIHRydWUpOw0KPj4gICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICBpZiAoY29ubmVjdG9y
X3R5cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkgew0KPiANCj4gRG8gdGhlIHByaXZhY3kg
c2NyZWVucyBleGlzdCBvbiBhbnkgb2xkIGxhcHRvcHMgd2l0aCBMVkRTPyAgSWYgc28sIHdlDQo+
IHNob3VsZCBhZGQgRFJNX01PREVfQ09OTkVDVE9SX0xWRFMgaGVyZSBhcyB3ZWxsLg0KPiANCj4g
QWxleA0KDQpBdCBsZWFzdCBmb3IgQU1EIGxhcHRvcHMgSSBkb24ndCB0aGluayBzby4gIFRoZXkn
cmUgZm9yIG5ld2VyIGRlc2lnbnMgDQp0aGF0IHdvdWxkIHNvbGVseSBiZSBjb25uZWN0ZWQgZURQ
Lg0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fcHJpdmFjeV9zY3JlZW4gKnBy
aXZhY3lfc2NyZWVuOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIHByaXZhY3lfc2NyZWVuID0g
ZHJtX3ByaXZhY3lfc2NyZWVuX2dldChhZGV2X3RvX2RybShhZGV2KS0+ZGV2LCBOVUxMKTsNCj4+
ICsgICAgICAgICAgICAgICBpZiAoIUlTX0VSUihwcml2YWN5X3NjcmVlbikpIHsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGRybV9jb25uZWN0b3JfYXR0YWNoX3ByaXZhY3lfc2NyZWVuX3By
b3ZpZGVyKCZhY29ubmVjdG9yLT5iYXNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpdmFjeV9zY3JlZW4p
Ow0KPj4gKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoUFRSX0VSUihwcml2YWN5X3NjcmVlbikg
IT0gLUVOT0RFVikgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZHJtX3dhcm4oYWRldl90
b19kcm0oYWRldiksICJFcnJvciBnZXR0aW5nIHByaXZhY3ktc2NyZWVuXG4iKTsNCj4+ICsgICAg
ICAgICAgICAgICB9DQo+PiArICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGludCBh
bWRncHVfZG1faTJjX3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICppMmNfYWRhcCwNCj4+IEBAIC0x
MDI2NSw3ICsxMDI4Niw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3Rh
aWwoc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlKQ0KPj4gICAgICAgICAgdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4+ICAgICAgICAgIGJvb2wgd2FpdF9mb3JfdmJsYW5rID0gdHJ1ZTsNCj4+
ICAgICAgICAgIHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3I7DQo+PiAtICAgICAgIHN0
cnVjdCBkcm1fY29ubmVjdG9yX3N0YXRlICpvbGRfY29uX3N0YXRlLCAqbmV3X2Nvbl9zdGF0ZTsN
Cj4+ICsgICAgICAgc3RydWN0IGRybV9jb25uZWN0b3Jfc3RhdGUgKm9sZF9jb25fc3RhdGUgPSBO
VUxMLCAqbmV3X2Nvbl9zdGF0ZSA9IE5VTEw7DQo+PiAgICAgICAgICBzdHJ1Y3QgZG1fY3J0Y19z
dGF0ZSAqZG1fb2xkX2NydGNfc3RhdGUsICpkbV9uZXdfY3J0Y19zdGF0ZTsNCj4+ICAgICAgICAg
IGludCBjcnRjX2Rpc2FibGVfY291bnQgPSAwOw0KPj4NCj4+IEBAIC0xMDM4Myw2ICsxMDQwNCw4
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3RhaWwoc3RydWN0IGRybV9h
dG9taWNfc3RhdGUgKnN0YXRlKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnN0cmVhbV91cGRhdGUpOw0KPj4gICAgICAgICAgICAgICAgICBtdXRleF91
bmxvY2soJmRtLT5kY19sb2NrKTsNCj4+ICAgICAgICAgICAgICAgICAga2ZyZWUoZHVtbXlfdXBk
YXRlcyk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgZHJtX2Nvbm5lY3Rvcl91cGRhdGVfcHJp
dmFjeV9zY3JlZW4obmV3X2Nvbl9zdGF0ZSk7DQo+PiAgICAgICAgICB9DQo+Pg0KPj4gICAgICAg
ICAgLyoqDQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KDQo=
