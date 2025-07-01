Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F05C83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 13:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B579C10E086;
	Tue,  1 Jul 2025 13:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+sUY8iF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6140A10E086
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 13:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK6p2suavkH2YnlIyV6hW5UNtar+MBjKgahAXMcSC4zBBVfcfgIwd41/Ufs68B9DW99d4j+i3V/fMDHw8eyocvCFeJXb77OrmUcubsTSvzKaYSUEHgkoGHehyoHSb7c75DrTyJbcCTrI8T0vaQgAO8+55pnlIKvThLDdKhbJYFfnOKiGyRc9B6FocDAiwA6e1gBRcK8KvoFzUUCCk8bXDr1wVn4uJQsCVLHZsdjXCL+Q2izwcU9/cJee2rfk25Kh4de3FB/oP73xUajJHVJBOfzV9r8EVLJvf7SBWc2+UdyNC7ql1d8WlD5AmGXBsg/NUw9NCYRmePqCqlo3iEF9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA18bH1yG5tOdi/gblgtuI+HTLSiOQfXvxniiXFXNCo=;
 b=gLlKothdVwUatpgdwB03h30bWXBOuMdgupL/hPrp0yvDZMCNRMRAUBHxn8RkBWMvW+DYEs61c4AlrMEKsCIx7H3/5OBNmC2gSo5hVict8AN32h8qGVzHjWZlC1YqqhI7JF093pMQVuKtiO8T4gYYP+XI4yHeq5DN7waHfvx+HzsJAn6+9R8WXFDzKliChq6TNHEPIPvK2mTPs8dO5k7LQ09Eilr6E3jN+rGSpsBoDK/kUWW0PJyzz4tENJSkN3SLgFQmBEYtnIaJj4Znv6po+UEeHDfkWrfpOVQEMKwQkVhzCWju6b+wLU5an+JLZzldRm5bmggjE50O8KRm9AxE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA18bH1yG5tOdi/gblgtuI+HTLSiOQfXvxniiXFXNCo=;
 b=F+sUY8iFFfSegSySxbLUzfLCfgwclYF/Bxpt6ea/6Wu814K0MwSHZSu0wANhkqt1BNstr8vJkgXEzjEv+qaxwK4i+YRn/K5Ih5tVit+BeYJb60vQOn8OZdUN+LGwaoH9TDlhfjq8Yho4guxSgg0XcxdOwNYaljnS+1ZC27hd3Mw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Tue, 1 Jul 2025 13:21:24 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 13:21:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
Thread-Topic: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
Thread-Index: AQHb5ORrfgBI0MLUM0OQwir1QlR+H7QTgbUAgAnII/A=
Date: Tue, 1 Jul 2025 13:21:24 +0000
Message-ID: <DS7PR12MB60051F95EB72971ADF7CA5F3FB41A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-10-Prike.Liang@amd.com>
 <95e86cba-b3de-4f42-bd47-6e7eebcf2acd@amd.com>
In-Reply-To: <95e86cba-b3de-4f42-bd47-6e7eebcf2acd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-01T13:12:42.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ1PR12MB6123:EE_
x-ms-office365-filtering-correlation-id: c6600f1f-dfc8-4879-3dad-08ddb8a22d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?OTM3Z0EyNFl2S1F3dnkvVkl6RDBrOG0zT2trVWJ3VnZqKzYwMTUyZW43aTFL?=
 =?utf-8?B?WGFBT3dkK25iM2oxeHU5YnVFNDZGYWtyZ0RDUjE1Vk9Rc0NjVGdFc3B0UDNO?=
 =?utf-8?B?ZzYwZHplaXVUbUU4Ni8vcGpwaGxGdlh3WXhoZUpEV0Q0K2FZTkpqMno2VnZL?=
 =?utf-8?B?Vlc0VGlyQ0F5Ui9rMU1VekFHUHBMNGVKK1hEQkRJSnJER3VnZW9OOGovY0hB?=
 =?utf-8?B?dzJHRW9pYlZFQzFUUExQNndZeUdKUDIrd3hDbnc3bHg0Z3VkN3FhR3NyUjlI?=
 =?utf-8?B?OW9zT1NodFdTMHZBQTk5cFVLVE1ZUW1DNllYN2RzQ2YrWWpvRldIMkE0UmlY?=
 =?utf-8?B?NjUxV0tVRm5WZXZoVTlYMy9FWG9aV0JZazNSajdwK1lGM3pwWXA1RWZrQS9n?=
 =?utf-8?B?YmFMYzdKNWNMNjJuV3pDUkZ6aGZUNUdZM3M4d2ZIRU14QWJuaU5uc00rbSs1?=
 =?utf-8?B?UFR5K2c2NXRYQnMzdzFKVm9vVTY2NGlwVUxCaG9RUzE2a1FWelVHZlVNSFE5?=
 =?utf-8?B?RXZXQlZkZ2xrazRtcmVoOWVQK1dtTXVnaEFnSUdnVlZvazlZVHRuc2RkeTU1?=
 =?utf-8?B?MU1Cb3AyY1NuK0RMUEEyTEtWcCs0OER1NmJaU1dhMkMraVA5VHp0ZElDN3lS?=
 =?utf-8?B?bDhvYkU3R3ViTmpiWWpGcFlEWHorUmUyUDJkSlRYTCtHVjVxNkNmM2lRY0dN?=
 =?utf-8?B?SXFjV1ozdEFmRUUwWWlIbXpKRVdTQ0pKSFMyeGVvbHlhTk9XcFRneGpEc1hO?=
 =?utf-8?B?Y2VZeDJkaUxUc2pOeFllQ0hFNDFwcGtOdTZPcS80Y2J2MzVlZ0RxaVFzUlUv?=
 =?utf-8?B?cnFIcjlPdEtFOFAxMEN6RjN5U0t4RVVLSjdYWlVlNWQzcU5YSUYzc1JGejVV?=
 =?utf-8?B?S2RzUmIrMGRnRkhOY1U1VjFTaDA3VmRycmJqOGJlMUJ2TkJBdlBuQnRaUkw3?=
 =?utf-8?B?YWg5dDJ1eXhiRTlUTkZOZFNacGxLakoxcFg0dWRZVFRLRXJqK2lrZ0xKUjJT?=
 =?utf-8?B?SEJvd3NqQVhMYW1FWFk3Z3BaYWlLMUpXR0lwcXdrKzNQQUNQM1VoMnRoZHBu?=
 =?utf-8?B?c3pTVE0wSmt1cG4xdjZSMTdUKzRMazA0WUdSSDhQbSttU0dFc05mK0x5K1dN?=
 =?utf-8?B?eE9iUThyK0cwRThIaUc5Tm4xL0ZGdlp3cUN3TG1JQUhDSzlzVlpSRTRHUm95?=
 =?utf-8?B?dHExMnNpcWgxUmJzUnBGaXUxRmhCTmJHYU5TZm9SOG55SHpXdkQ0UzFZYW9P?=
 =?utf-8?B?WEt3a2hFWjJQN0puclZvMm9RVmxEN09DSkhPZnVZOUFiNDkrckJlcWV1V0pN?=
 =?utf-8?B?dXJ4K216MS9oLythc3J2TExwVmNUcnlodjlqR0F5SDIyQUJ4UGJqY2g5ZExQ?=
 =?utf-8?B?NlE1RzB6MVhabGJGSTE5bS9yYVpNUXBTcWI2d3dZUHp0MFdBSy82NjU0Q0pw?=
 =?utf-8?B?UlFFdGlnRW56MUZIa3BTS05SNkhXNzQ5dVNEalV2MFR5dmlnMjJ3Q3ZheUJk?=
 =?utf-8?B?M1pnK2xBVHJNdkJHSDhST0NaRFdOOTBzaEdDRkhHWXhialExVGJzQnJvaDls?=
 =?utf-8?B?VUpDSnhkUjBkc3Jub01EaUsvaU95UFYzbEU5M1h1MllMSGwzOUZCS0REQnlK?=
 =?utf-8?B?VktMNXp5ZHFmV1orQTlBRlJ3QmhxZWtlYTlZQWtrMlpMMzhjOHozL2VtSVp6?=
 =?utf-8?B?TFlZOXhZeFNBNTZzOXl2SGt2Y0UzbVJ0YjdXK2VTSi92S1VBVkF0UE45ZTlE?=
 =?utf-8?B?L0xzZ04wSzVvY05EdDFhZ1pvaVZHWUJEYUVITU9JTk5aL0hMcVdoTWR2Z2ZN?=
 =?utf-8?B?RXV2U0g2QlNUSkxhWU5nYnhvdE11cWd3QTZXL1k2cXoxR0tIYzgrVmliRmNR?=
 =?utf-8?B?UmJOa0c2TXY1djhhS0pieXpJKzI1QUxsOXA0KzAyNk1SL3o3ZjVFSU9QRmxw?=
 =?utf-8?B?RmlMM1ZlRG1Qc0hVbHFGdEJRT0xYYnF3djgwbHZxbkVxaXBub2NGN3NDWDJG?=
 =?utf-8?Q?GPLBR75w8HvlTptI2VnBoF+H8VIG30=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVtRklIL1hFSCt5RVpsc2htZXFHMk1vS1prZVlvemtLRFNLZURWeUNvMStP?=
 =?utf-8?B?V1FnSzk1MEZXcnZYZlFoeCtrK2t1ZUFrMFNmbE9oU2J2bmhNczludTJURjl6?=
 =?utf-8?B?QnlHUStEeGV4dWM5dmVjcDh4NEtTNUNMUmduUWUwaHNvRkZEcko1MjBMQkRv?=
 =?utf-8?B?bGkwUkdGUkd3ako1MHpoTzF4L3BUclNKeThuU2xnSjNuWHpBdHVJOTdRT1Rm?=
 =?utf-8?B?L25udS9KNmdCK1ZveDFKWWpkYlRRSFl5SHBKY2dXZ20zL3Y4aC9iZ05iVWVv?=
 =?utf-8?B?cndmMG5KZXExcWhnQVRqYWtuZU1jTThPZGpsTWRldGhKR2RCRTZJVmgyV3lr?=
 =?utf-8?B?dkFxa1pwM0FTUVg0Wi9nd3hIeFBPSGY2bWNkNWlOYzROYkZ2YWxJUkFKdDJx?=
 =?utf-8?B?SDJTbEZUdDhTY0pwNjJ1cnErMFpyUzhaS0Z1VklKS1o0NFI5NXZ1Y21QVnp0?=
 =?utf-8?B?L2ZyMU5IdHRMM0xieEpwY2phK3RGV1Jub2ZDYVRmSEVZRld1UHdyMVBDWm1G?=
 =?utf-8?B?MFlwbURwZlVFWldEZlhpdm5BNG9TQmVlckNRSEMwd2VlaGJqUlltT25qYWlH?=
 =?utf-8?B?WHZMdEdnTkFQVXcwY0thWUVwQlNaU2dMa3IzN0pyQTJaMDhxV0czNUp4SGRS?=
 =?utf-8?B?VDZFc094THc1Z2s0aHJWQ25GL0pKdjdSWGhoMzcwRzU0Q3gzREt3S1U1cUhH?=
 =?utf-8?B?d2JOVmd1aStzUmNVV0xOblhqTVFyUjJJQlhLUjllT09PSUg1b20zZERaOWJs?=
 =?utf-8?B?cCs0OEJuMXJ0bWNFK0VrazZRUUZvb1BYa2tHcG44UU5xQnN5N1hNNnpIZjlu?=
 =?utf-8?B?ZHl5ZWNERG1wdEZoZU01WEVJcnBzRjRobit3RlpQeVBiRUVPYXU1RWRwMDVC?=
 =?utf-8?B?WnlRS1FjVFVmVDJ2SmlSNXJYMnZFaFRNQ2UrOWlzbmQvMFFFbGxiMEFDNlhs?=
 =?utf-8?B?Umx1SStJdjNDUTZJNmdoYjdvYzdHK2dTaHdDVUFiRFdDZFY5UkhWdHI5dzh2?=
 =?utf-8?B?am5PNDBkTU45VDB2dmthdUpMVlVIbTZ3L1d3YmVScW0vbTdhbWxLd01RaUpP?=
 =?utf-8?B?eE55UVQyTm5GMjNwOHo0T1kxMnNhZkdvVHBkeEpRSnlQUVkxbU9jZGFjTk03?=
 =?utf-8?B?Zlc2eHFKNjdXbXluZFpPbWFVTzU5bHN2Q2d3bUdzZUlwd0JnOVkzaUZwcTlY?=
 =?utf-8?B?aXhCbHQra29ueEhaVk5NTm51OS9XU245YUZQWm1tOXBMUFk0TmhVNU5iSWY4?=
 =?utf-8?B?R2sxV1NEbDFiUlI2b1Y5U3NLOTBRL2p2NWRZZ3A2czFkUkI2eDdZcW1kTHl3?=
 =?utf-8?B?cVRQNWZSaldoT1RyZ1cvUVZJWFY1Y0VFZlYxWHlYdCtwNnVzR0hvWVdBQUtN?=
 =?utf-8?B?czJjeWdQYmFhd2JKbDRLZEh4aC9qdWpla3U0YWUydGlZZTA2TnhaeFZNNW5m?=
 =?utf-8?B?YkRHRVNzTEEzN0svLzc0b3pOWGZnZFV6bWJjM0dBOGxmbHNiWXpueklpMWNN?=
 =?utf-8?B?OFVIUkNwWVpyQzlMRzVRMDBqQ2pKdGhJVDZjMWtRR3M1UWlya2FzN2taa2k3?=
 =?utf-8?B?UEtGMDJLRXlJODhBNE00U28zT1VNMWpDN3JQUjNxdDJ1MS9lN0FCd0Z0NVUw?=
 =?utf-8?B?NW5xdFNBQythN3hJcVZYc0ZWMHR4TDE3aE1FTDdRVm93OGpaRFBMLzFsVUl1?=
 =?utf-8?B?d3czc1NreExZVnRuUFJRTHJ5ZTZvUFFseDNwdXVrWCtVVlNYS0NmR3g1L0lP?=
 =?utf-8?B?UXdjUk9VQlovblVCa3VveWRENVg4Vk1CMldGUHdEeUFPaFRVQllwTklXci92?=
 =?utf-8?B?QmxlQmp1UjlXVzB1dUZxU3d0TDVCUTdvcCtjdUpyMUxZamF0enpwZEJkdkhv?=
 =?utf-8?B?Tk1mTGd2S0JOOEJDSXIrTGkxaVRCSGlFUjBxSitSNmpwY1huSit1UzEvSVBQ?=
 =?utf-8?B?RjNkaTYvdUlKNHp1NUdEMFpuRzdMUzl1WE9DNnZEanBGUFVhL21XK3c3Q09B?=
 =?utf-8?B?dXhVNnNnSEo5RVNQc3Q1d0JYdW9OU1BJeUhVbExZWWpPblRITCtaVEZOc2pm?=
 =?utf-8?B?Y1hDK2M4RTIrUkdoZUR6aUVlK1p2MlJtaEtKZmhUb0grMERYQkFiVUNta0Rk?=
 =?utf-8?Q?fKjs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6600f1f-dfc8-4879-3dad-08ddb8a22d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 13:21:24.2822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgA8aQjNqJYJ8e+dGPwbbqP1e3RTptbMuokHGIyew+I0Zcaan8S8wtXLKFsPjGjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI1LCAyMDI1IDM6NTAgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTAvMTFdIGRybS9hbWRncHU6IG9ubHkgYm91
bmQgdGhlIGV2aWN0aW9uIGZlbmNlIHRvIHVzZXJxDQo+IGJvDQo+DQo+IE9uIDI0LjA2LjI1IDEw
OjQ1LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBJdCBkb2Vzbid0IG5lZWQgdG8gYXR0YWNoIHRo
ZSBpbnZhbGlkIGV2aWN0aW9uIGZlbmNlIHRvIG5vbi11c2VycSdzDQo+ID4gQk9zLg0KPg0KPiBD
bGVhciBOQUsgdG8gdGhpcy4NCj4NCj4gQk9zIGFyZSBvZnRlbiBjcmVhdGVkIGJlZm9yZSB0aGUg
dXNlcnFzIGFyZSBjcmVhdGVkLg0KWWVzLCBidXQgdGhlIGV2aWN0aW9uIGZlbmNlIHdpbGwgb25s
eSBiZSBhdmFpbGFibGUgd2hlbiB0aGUgdXNlcnEgdGFzayBpcyBzY2hlZHVsZWQuIEJlZm9yZSBy
ZXF1ZXN0aW5nIHRoZSB1c2VycS1jcmVhdGUgSU9DVEwsDQp0aGUgZXZpY3Rpb24gZmVuY2UgaXMg
aW52YWxpZCBhbmQgaGFzbid0IGJlZW4gY3JlYXRlZC4gSW4gdGhpcyBjYXNlLCBkbyB3ZSBuZWVk
IHRvIGF0dGFjaCBhbiBpbnZhbGlkIGV2aWN0aW9uIGZlbmNlIHRvIHRoZQ0KQk8/DQoNCj4gUmVn
YXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlh
bmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDE2ICsrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiA+IGluZGV4IDJjNjgxMThm
ZTlmZC4uNTAzNTZhYTIzYTk5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYw0KPiA+IEBAIC0yOTQsMTIgKzI5NCwxNCBAQCBzdGF0aWMgaW50IGFtZGdw
dV9nZW1fb2JqZWN0X29wZW4oc3RydWN0DQo+IGRybV9nZW1fb2JqZWN0ICpvYmosDQo+ID4gICAg
IGVsc2UNCj4gPiAgICAgICAgICAgICArK2JvX3ZhLT5yZWZfY291bnQ7DQo+ID4NCj4gPiAtICAg
LyogYXR0YWNoIGdmeCBldmljdGlvbiBmZW5jZSAqLw0KPiA+IC0gICByID0gYW1kZ3B1X2V2aWN0
aW9uX2ZlbmNlX2F0dGFjaCgmZnByaXYtPmV2Zl9tZ3IsIGFibyk7DQo+ID4gLSAgIGlmIChyKSB7
DQo+ID4gLSAgICAgICAgICAgRFJNX0RFQlVHX0RSSVZFUigiRmFpbGVkIHRvIGF0dGFjaCBldmlj
dGlvbiBmZW5jZSB0byBCT1xuIik7DQo+ID4gLSAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2
ZShhYm8pOw0KPiA+IC0gICAgICAgICAgIHJldHVybiByOw0KPiA+ICsgICAvKiBhdHRhY2ggZ2Z4
IGV2aWN0aW9uIGZlbmNlIHdoZW4gdXNlcnEgY3JlYXRlZCovDQo+ID4gKyAgIGlmICh2bS0+aXNf
dXNlcnFfY29udGV4dCkgew0KPiA+ICsgICAgICAgICAgIHIgPSBhbWRncHVfZXZpY3Rpb25fZmVu
Y2VfYXR0YWNoKCZmcHJpdi0+ZXZmX21nciwgYWJvKTsNCj4gPiArICAgICAgICAgICBpZiAocikg
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgRFJNX0RFQlVHX0RSSVZFUigiRmFpbGVkIHRvIGF0
dGFjaCBldmljdGlvbiBmZW5jZSB0bw0KPiBCT1xuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICBhbWRncHVfYm9fdW5yZXNlcnZlKGFibyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1
cm4gcjsNCj4gPiArICAgICAgICAgICB9DQo+ID4gICAgIH0NCj4gPg0KPiA+ICAgICBhbWRncHVf
Ym9fdW5yZXNlcnZlKGFibyk7DQo+ID4gQEAgLTM2NSw3ICszNjcsNyBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QNCj4gZHJtX2dlbV9vYmplY3QgKm9iaiwNCj4g
PiAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCj4gPiAgICAgfQ0KPiA+DQo+
ID4gLSAgIGlmICghYW1kZ3B1X3ZtX2lzX2JvX2Fsd2F5c192YWxpZCh2bSwgYm8pKQ0KPiA+ICsg
ICBpZiAoIWFtZGdwdV92bV9pc19ib19hbHdheXNfdmFsaWQodm0sIGJvKSAmJiB2bS0+aXNfY29t
cHV0ZV9jb250ZXh0KQ0KPiA+ICAgICAgICAgICAgIGFtZGdwdV9ldmljdGlvbl9mZW5jZV9kZXRh
Y2goJmZwcml2LT5ldmZfbWdyLCBibyk7DQo+ID4NCj4gPiAgICAgYm9fdmEgPSBhbWRncHVfdm1f
Ym9fZmluZCh2bSwgYm8pOw0KDQo=
