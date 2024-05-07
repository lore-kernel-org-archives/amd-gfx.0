Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C245DC25B5C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 02:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B62410EA9A;
	Tue,  7 May 2024 02:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vtvIdwAq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D536510EA9A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 02:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+rqmOeXZfydexbYtRar3Symk5VnruWHjRPVhAnZQpMyY7fw+pg3LvN+F+Jr2gtsNjEtsxdMYaQwrD5TqP/nY4P+VrwYEMDfOQ6wN4coy1IWkasOAKR5WK/3aZdCHPgUTy5BDSEJy6/ITa7KWOxokCbs+4lStdN3pEF7rMfngW+AgLMOTUr6AG1JNWhsB5T3WOM+yE72qGbTSGgx03PEXj3C7D7PNttVaHkgjpI8J9Ut2BCH/kyDpZ6VS/P5G/bhI9OvEC3w9RzB6R8s7wO01sRxxrEh5jsmISlHz81vxjB1qp1z2VIY2a8Eq8/CtWqDaYgVNkUsDE8zOPHtn/q3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zOZvCIKWaWcgRIUoDV3tpGqI4UYV8geXhpM2dyCkH4=;
 b=SPIvCuXw6OPDtINkPSI7euAnwmmEg3foBjl3YP0Flw6XDMWjkzaRbxD0lyk3IMbb7Wo+zXQqMZFwfWico78bQb5zMWpnVi5npKxuQltGULDY8TnNvUU4YT1M+F0CazcCVNM22qJWTHQZ+eTpp4l7DWbWEUM3KiKi252NczQzK6kkMArq0xQ4fiD0jFEjdPHmFszFoVUgPpL1wManXIoSPnF3Tpmkc2od1TZyi3vyYKJta2vVTunIEWWoNTH6++vXbx+JyfpQ/Y0cu71KIOXp2QbGPgJhoTTYWKBk0veBRdR3w4TwFhjuaOMliFswBy9YvvcVuKUgaCSNsh+3RNkh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zOZvCIKWaWcgRIUoDV3tpGqI4UYV8geXhpM2dyCkH4=;
 b=vtvIdwAqt1LFh8A/vfhUzFbmqQe+ud3adLFkxPxqfxaQDlSM+ZPt0z+hauVWNGwiM9ElrhZgjRgeDc9CRr2/VM8ntTbE2Nobj++Im9OsHMkxsHv/iwufLGvrBqMgPYy83EbpVTKu78HWbTDx1rHdoJ7ND8Pj1IVeP+d6cD8Hb0Y=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 02:17:42 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::3d7b:7e5b:458d:a32e]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::3d7b:7e5b:458d:a32e%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:17:42 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA bank
 dispatches
Thread-Topic: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA
 bank dispatches
Thread-Index: AQHan4FKQZ56Ru+clkuuYfh3JKppCbGK/uOAgAAK4PA=
Date: Tue, 7 May 2024 02:17:42 +0000
Message-ID: <MW4PR12MB6875FEFBE26B9CBC50E7DF8D91E42@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20240506064723.996050-1-kevinyang.wang@amd.com>
 <DM4PR12MB6012E9C995CC8F7B7F3CC93682E42@DM4PR12MB6012.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB6012E9C995CC8F7B7F3CC93682E42@DM4PR12MB6012.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=73398bab-d0ee-4add-8304-fe9280a00d44;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-07T02:15:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|LV8PR12MB9420:EE_
x-ms-office365-filtering-correlation-id: 3bd19aa5-2dfe-42c3-88be-08dc6e3be066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?YjdwSm0ra3lqcUJNWUlEaUdNL1ZLMXNoVjA0dDhRRWliSTljcVllekFS?=
 =?iso-2022-jp?B?Q3F5WHAzWjRVTXVZR0VEWDFxeHF1dk1GeTdqejBaSkJLaXUycUN0eGY5?=
 =?iso-2022-jp?B?NGFlZHVRNXRUTGRKRjNwOEgraWFUcHROcFREU1pTcHI0TWErN2F6Nzh4?=
 =?iso-2022-jp?B?YWorZERla0Y5blJNRitvdlN5dTlEVmN3dFJOb21lYU5va1JxVi9BTmVG?=
 =?iso-2022-jp?B?MFQyZkxYUEtSMlp2QkhaeHkyMlBnS0lRdGZRWWFpQXlVT0lEWUFydTlT?=
 =?iso-2022-jp?B?cmY4eis2VldvMFNwUjZtNEtGM0hrRFZtNDVkbUpQaFZnOXdoOWM1U3VS?=
 =?iso-2022-jp?B?WjRLUzFjRkFWQzlGWDZGVStKRmJEa1JkdHMrNTA0Nk1NTXZtaHNEZGh1?=
 =?iso-2022-jp?B?LzV5S1ZBUWZSSGcvV0M5dHlTelk5Tkk0aWM2dnBtOFlmejNWS3RiZlh5?=
 =?iso-2022-jp?B?ZlVPaHgvL3BvQVhyQTF3dGh6dFBiamNEVm5tSTJCbDlLNmdhUjVoRzVn?=
 =?iso-2022-jp?B?ZGI0dm5wTi9ldXplc3h3Qk9sUGxuQXlFdlliWWgvUjZ1YTIzUERjQW13?=
 =?iso-2022-jp?B?WXNpblh1Zk0yRnJzN3Y4NjYzVHFKOFpsYllldjJIRUdJd2xhNm4wMUFF?=
 =?iso-2022-jp?B?ZmRzNnFUVnI4aURndFZMMzZHenhTL1N5amFWYzZPMm1IeGxKUzd1YVJY?=
 =?iso-2022-jp?B?aURIa2hSZFlrTW51Z0JQWEE1ODBoWnRuZEVadzJpcWI1eEU5eU11Z3Ra?=
 =?iso-2022-jp?B?RWh4NHZydUFidjRWOURIZHprSVV6UjMvbFNQcVNkWUd4U25rOTIrZ0Nh?=
 =?iso-2022-jp?B?U3dxUTUzR1Vpa0dPM0UzOWlHcjNVdnp4eDArN0pHNDVOV0hZQzlmTlNE?=
 =?iso-2022-jp?B?cjBPNktldUcrSnNFSi8rSUV5aWdKODZWZnZlTm5pRWNhWVkrekFUQlZT?=
 =?iso-2022-jp?B?ZmpDMjZGM2FWOUNSMTRTMVpLQm5naHN6WU9KZzlIWERvNTdFK1kwTFNC?=
 =?iso-2022-jp?B?QTdRaG5ZOXZhNksrcVRmczgveG4yOFZEQS9uRjFkUzAyVm5pQ3BHM0hv?=
 =?iso-2022-jp?B?aXducTBxbWtCTjNtZnB2WWkxMkFJY0EyZVA3STI3Mkp6QlE4OTBaVkhW?=
 =?iso-2022-jp?B?dk5MZlhzbDYraVgrNFZoUksxYk5hT0xrY1JwQ3ZLVjZwajRYYjduUmVQ?=
 =?iso-2022-jp?B?Rzh0VFkrakhnKy9LdGhMTVRmbHdYRjBJbDFvRGNlTHI2dXJ5VlFmNy8y?=
 =?iso-2022-jp?B?M09LWm4rWHp4ZWhmMGlWUzFxVlhjVWZuRXFEcXlGSTdxZzUrLzlEODE0?=
 =?iso-2022-jp?B?TGZCSVQwbE95M0xjU0ozZGxZTDF6VDhlWnphZkJ6ekxZN21rTjFDejZr?=
 =?iso-2022-jp?B?ZVVCT01MdEJOOTB5MlR2dTM1SWpIRmxERFU0bkl3SG5wbW04VTR6K0JZ?=
 =?iso-2022-jp?B?K2Z0K1BNSEhuTUs0L3JUeHc4OVJya3UwOHFncDB4b2FvUHkwMGMwcG0r?=
 =?iso-2022-jp?B?QkdQbnQrdWlKN3dSUlhmdE9vbFhvaFNwNFBKWXpoeWNQMjl4TkFJK2Jx?=
 =?iso-2022-jp?B?NFRhVVQrTEhmWkJpNWFhWXMybjY1ZW1wdjRHYldtTGRxVk5Gbjd0VTNC?=
 =?iso-2022-jp?B?SUNMRGdrdnBpNDZEdU5hUzhUTndBTG9sQno1MGdmMFF3TmFFSG9rTDBo?=
 =?iso-2022-jp?B?NTR4NXZFUEp3TUIvL29SSlZ2Ty9RL2FrNjlzd0lDVFJFc2NtU21YWmd2?=
 =?iso-2022-jp?B?SVdyQWN6dDZVWGt5MFh3VGlBWFFOcXQ3QmVJeE9sbzVWbW5RTTRISHBx?=
 =?iso-2022-jp?B?RU03UTA2ZWkvL1VqMVVwUnVQdkNrUWZXYjg2ZjlLUTB2ZFgydEZkSktu?=
 =?iso-2022-jp?B?V2VRNXZQa3NSM3JXVjRocHdwbDZlYnRGTTF6RHhLMm0yc0RwZGM4dXBG?=
 =?iso-2022-jp?B?eDQ5b3l0S0pDbHIvUE1ndzhOa2lJdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NEVBK3JENWRja2w5SmcrNExnVk13eXNMUDJ2WmVJZE9DTXU0aklhTGMy?=
 =?iso-2022-jp?B?Q25xYUNLeUhYUHJONHF5WWZ5MVRGRTlLQWZSNVJULzZSZDhDU2pDZEh6?=
 =?iso-2022-jp?B?OTlvMlBpOG9qTnBLcGg5cExCK2JRYzYrQ3QydFltRC9tQnVZWDAxcHpk?=
 =?iso-2022-jp?B?cHJmUXdBQ0NZeTc5d0VEOWJWYTNBWTlmOS9qcnNsR3J6RkNYNGNRRUhY?=
 =?iso-2022-jp?B?bkVKdkdGZHVDcWdiekQrZzFuQWFVSnZMdmRhbThkcER0OWxIMERJOTg1?=
 =?iso-2022-jp?B?TDJhNjdnMmFKMG1oeUF1UklNZlJUUXRzSFR1UXA2RFZsc2xYdUtQK1BG?=
 =?iso-2022-jp?B?QVJxdUxINXpxM3hTNWN5bUZEZHFHamtTOW1mcE9DbGRNcy9WS0lZbmFm?=
 =?iso-2022-jp?B?ZGJBZ1N3dTNmN1hQU1NLMEFpclFyaVZ1NTVEeGNoOTJvdXJQaEN0QkE3?=
 =?iso-2022-jp?B?OGg1dG9JZjdXZUg5WExvM0Z2MTNJQmhPQmx2ejA2WjUxelpUMkNRK0VH?=
 =?iso-2022-jp?B?TXE1dmQrTDdDVXVJUFN5Ymd6OGV4TmUwcUFoa01sRWNTN1hyUlV4T1lm?=
 =?iso-2022-jp?B?NDZ6VUVTbmVqR3d0Lzltd0VXMmtsaUZCRUpKOTRraUF0MmFoZEZLdFpX?=
 =?iso-2022-jp?B?RGo3RW0yUDhOQjl3bUF5TmVaTm5xREhQUlZ1Q3JycitsZThNKzFEVlVY?=
 =?iso-2022-jp?B?Q3dGTlZtelpxT2xFMWxPZWUvWmNPZkpMb2FkSkp5VVU0QUxORmlqcWha?=
 =?iso-2022-jp?B?OW40VC95UGU3TE8yblpaUnlUQmZUV3ZqMmVqWFhBbWNsaXg2dEROQmRD?=
 =?iso-2022-jp?B?bWZvMkF6RHUwSTBhKy9CRnpoVk5STGJTbTFPMGdqQk5pamZRTnpYY1RU?=
 =?iso-2022-jp?B?OVJEOUVkRmRNbFErYUEvbVllbUpVK1BzVnVYUnp4S2VQbUgxVHRIQWtQ?=
 =?iso-2022-jp?B?ajdDVTd6WEpUVEd1RE5zTjljVkNyeW5DOXlaalZBZnpXa2NaSDdOTjFa?=
 =?iso-2022-jp?B?bG42eU02TXZVUjREOVdCdGtPbklNdHlyNC9nNDZDQUNpYkNIUUVsdDNt?=
 =?iso-2022-jp?B?QlVhKzBITGVpYlVkcDhnUVRwSEZpUWgwdkV2Z0dpd3d5QmpGY2gxNWlv?=
 =?iso-2022-jp?B?NkFwTW1aaVlXelFsNEVwK2RaWGJDOHZOd0VwR2lDSXIwanV1dU1WcS9l?=
 =?iso-2022-jp?B?eWRWZUxicWgwNnlOZUlhenJzUG0xKzY3RHRKOVVGank4MXAyenA0QU84?=
 =?iso-2022-jp?B?eHUrcHFyaFJ5ZWxTQ1pNZ0RWQitFSS9DRERkVmV0Z3BiU0c5VjAxZTVH?=
 =?iso-2022-jp?B?cWhja0FkL05PaXFRbzU0QjBvbHVSdmF6Snk0K0ExbWtjNndsUnl4eDhE?=
 =?iso-2022-jp?B?TTV6NVp2c2l0K1JvbEZIcnk3VjlxeENMSkFnWjhiQU1jUWJlNFpBdGpl?=
 =?iso-2022-jp?B?V2QzdjMyNGl2TURkMEdEYkNaZVlsa2ZDaWdUOVRTOUM3cEp1YU1Ydzg0?=
 =?iso-2022-jp?B?NndjZkRyRGpPOFlMZXpFeFpNc0I1RXd5eVQydmtmOFM4NEZ5VERnQkpW?=
 =?iso-2022-jp?B?MHFjS1RmYi91RElQUlFicW14SVo1N25RR3E2OHgyVmU0RnFXa0lXVWF4?=
 =?iso-2022-jp?B?YVR4SHhCV2ppazhIN0pPcUtBYlBxeUExWXRieVRSQWdLNHltWjRiMXBt?=
 =?iso-2022-jp?B?YmxSTHZZL3dncFZDb0ZCQXhWMmo0NytrWDB2eCs5YWNHdlUrQmVMU2pm?=
 =?iso-2022-jp?B?OUJ0bDQvWW1leDJRMUE5U1ZBdnRpVEJ3WWQ1c05RRnhHREdZbitjaVln?=
 =?iso-2022-jp?B?ZkVaZlBneGs5RTdkNG5RUFN0U25oeC8rRFVLUGRwZ3lzTlFiMmY4cGxE?=
 =?iso-2022-jp?B?dWdHU2VEbStqZHBmMDEwV0J3VUFaTEpuV3RYNGtrbjU2clJXOFV5Yk8w?=
 =?iso-2022-jp?B?dC9pNmpvb0lsUTB1NUJnRzBjakpadGNiRWdyaEtkb1VkdEgxcmVESTUv?=
 =?iso-2022-jp?B?dDNneWlXbmVVSnVRTWZGY3ArK1dKVW9zeEdGSHBBL0RGUXpEZGR3Slps?=
 =?iso-2022-jp?B?bTFxVlJiZytHUktDczhpV3BXZDhhaXFQZkt5Y09yeXBFdFhYMTVNeHNt?=
 =?iso-2022-jp?B?dXB3VWg0R2lDUFk2K0x2Ui9rSTg2L3k4UW9SdUVaSlJEaTZEOFZvM1Nl?=
 =?iso-2022-jp?B?Wm1vdEUvNW9JSnVoUG5FdVVYMkErdXkrS0ZXcDJUWndGRHRuK0tPQndT?=
 =?iso-2022-jp?B?UXA2WGZiSEgxTnZKWEhzdEtvcmFLVEdhQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd19aa5-2dfe-42c3-88be-08dc6e3be066
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 02:17:42.4001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVW5XXGc6i3InWbqjKcAXH8k9qciAbTW5qrUNGPkVoj4iJEupvJxPDqlj/JFFt3z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

[AMD Official Use Only - General]

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, May 7, 2024 9:36 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Zhou, Hao (Claire) <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA b=
ank dispatches

Ping...

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: 2024=1B$BG/=1B(B5=1B$B7n=1B(B6=1B$BF|=1B(B 14:47
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA bank =
dispatches

This patch is used to solve the problem of incorrect parsing of error count=
s.
When the UE trigger gpu is reset, the driver will attempt to parse all poss=
ible ras blocks.
For ras blocks that are not supported by the current ASIC, the driver shoul=
d ignore this error.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index a7736aa58ba9..0c9a271c5028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -415,7 +415,7 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_de=
vice *adev, enum amdgpu_r

                count =3D 0;
                ret =3D amdgpu_mca_smu_parse_mca_error_count(adev, blk, typ=
e, entry, &count);
-               if (ret)
+               if (ret && ret !=3D -EOPNOTSUPP)
                        return ret;

                if (!count)
--
2.34.1

