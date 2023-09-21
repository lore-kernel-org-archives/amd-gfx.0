Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00691E706FA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 09:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB1B10E5A0;
	Thu, 21 Sep 2023 09:24:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBC710E5A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 09:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLJ9a0BOLMtPgWN2tkixy16QfdLgrADxe9cnxEi6p9kU1kwHQqlRFpqcoPWlZP7yOPU6aFpnV36/zebV5Hp08pgPF+tz91GDatGIeXwbWkBrL3kSCmPUoqdIi5LdlekRC/LMsA7j6pTDrf58EECE2eVQtqQ61GFv0E35Uj1hrSuQXIBfPeeMMYhY0G9l8oxqrCtF5Waa2XwtjrUMHWDmi3KDimsRC0daBEWMOjDb/DDn0/erIq4TzuqxZbMJrIHABmA1yRaGcTvfmaFN2cBNkb/E+v4Fq5OHzNVusZzT2fM3zAUfSysEYUOJ9ncECGQg7mu17eyW1wBb/gxM+soJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxZA07151EqFrvH5RFULR+SeAUlctv466LdiRrSSYt8=;
 b=SWdT/VhwV1Rcl0CNy3n23ffZ20sucRsZwANsl06kpqWd/I3nNEJqhtE6JekgyXHZcV4i5k0+u86QUQdFrje1L+shXVk0lgrfTr9coGbbojKVcqSXsTPDAN+/T3xPKJpM7xZJvd5llFKRZ9V7317YE/YV5Tnq7Oiktnewi2OimEt92dM1hfqXcW9mukDlRz78sdeaGlMrgDZ9QsQPDOoT8D5G8CFSSEiyOOF4wQnea66lmJQGbx9gv+2Yz7J6KR0Zgwd/G2+NJCHB0D4hSvo354aVwc1bEd1d2fFphuIHxoYEosvvTq+xrRErs1k0LlO15d6DIsoi0VUaHm+VXswyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxZA07151EqFrvH5RFULR+SeAUlctv466LdiRrSSYt8=;
 b=OzDbT8WiexNDVFS/dawdBCHDKIhET3I2XaF9FC+KnCHV1iEUoCf7oMNEppXk3iocHIJOcQmlvFuG+fmRoFtFXXmq7nKjI/chZAdLZZ1/IeAj+nyc7Iyv3etqd4YOQE/jtnje7Q8FNPm4cEk9byJiiFTSt4FBFhtWA/tndG/0tbI=
Received: from CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:24:03 +0000
Received: from CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::e34c:6461:a974:4c77]) by CY5PR12MB6081.namprd12.prod.outlook.com
 ([fe80::e34c:6461:a974:4c77%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 09:24:03 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Gadre, Mangesh"
 <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
Thread-Topic: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
Thread-Index: AQHZ7EU1x/xXaOV7gEyoYQPU0Mwdg7Ak2p0QgAAk1QCAAAFqUA==
Date: Thu, 21 Sep 2023 09:24:03 +0000
Message-ID: <CY5PR12MB60810C6DB5A566ED57F636E88EF8A@CY5PR12MB6081.namprd12.prod.outlook.com>
References: <20230921043551.3903891-1-Mangesh.Gadre@amd.com>
 <CY5PR12MB60813F7A23726EE11AA88DFD8EF8A@CY5PR12MB6081.namprd12.prod.outlook.com>
 <0a924f0b-1892-c8b0-6985-7bc259c65c0e@amd.com>
In-Reply-To: <0a924f0b-1892-c8b0-6985-7bc259c65c0e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8f14b578-cdc2-4e78-a967-cac512f48d65;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-21T09:19:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6081:EE_|MW4PR12MB7030:EE_
x-ms-office365-filtering-correlation-id: 5a2fa7ca-2b5d-469f-9f15-08dbba847f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygknTop8mMZlNj3xglXgoF8MHTgap5NuLS9x/MuN4kk6rPAAARDBmP5I+Bwf6heeta8TYt3oLxm7qSQgdJpJpdQWT9A//i7RunTFCW1bgMqmpsqRscYlUHPtgo/zY+Juc2uQvj3RhpCrMpN2H2ZEAZYNTv1zuw6RTQHrprI23aV3KtkSRonJN4ow2v8p82FAWyr2hKnOIb/XGaEGGJtDHycCl/9FvQi7rlapYkjdCa1q+LuplF9z4RNFq1WnlY4fOlUZGEfgsl58MnghTiLMjEwmGtnGVqrqZsQpkD+Zf87MShtmhI7kvC9/93RruqBfrM+38ERKsOImMJ8byFO1UkFxv+GpCM4n/hgBn7mHGsnawSvJEw0JXn8FEEZUsIeSLp1FUb6/p9jieX8YoLWwgiqKD3wkxNfMI9+aUlKIFpM45sB3Wg840y7fnM+s+gNjucP5lyOuweiWbUi1qaxSfz/8U7bSVRz15rc2VxSJZgdg+7x2Kg1LajDUcHB1LrqLGbARUOCumxpD9biaGosGXaoB5Fl2J20bPNCe9O/7GAkzQbAVzR7QwbnUYBcgaUj0RUbKWarkG1i646gOc/3HyOtDLqDM3JtMoY9UhuX03A6bfaYLHkIny9PCiMboMLy5vzBoUd7EuNj5pmQiD7XVqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6081.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(316002)(6636002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(5660300002)(55016003)(52536014)(8936002)(8676002)(71200400001)(86362001)(26005)(83380400001)(41300700001)(921005)(122000001)(38070700005)(478600001)(38100700002)(6506007)(7696005)(53546011)(9686003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk9UTUV0d0dCRU1Sci9HL3c0cTVndFE1c202RXM1VkxRVEJiWVZXQjBmZTRW?=
 =?utf-8?B?SzBEYUZLdjBnZElpTTN6eUtyNnQ2MnZnZDlQUGVJeWFXR0xWWURpaDdMcmJF?=
 =?utf-8?B?TzRtYTNEUUZ0d2YvKytTT1lHYktydGhmRHRCWHBjOS9IOW50UFVFU2ZUeG42?=
 =?utf-8?B?TFlMWXFyNjA2Rkh0UVVjVUF1ejg1cVVVblhpcHk3WEh6RHlVaDVJd09IbEEv?=
 =?utf-8?B?OTlSMG9xanRCK0NlMUN1bkIvdmlFVTFzQ2FtTkpISm5IT1BYNmVMV1psaWpL?=
 =?utf-8?B?Q1V6QXFQd0wzVnhzVW9RdXIxOTg4MlBJVXpmQlFtVWlSYWdEU3ZsUzFoUEV3?=
 =?utf-8?B?VU5EeEQ4M2R4ZzhnKys2Z1pkcE5ud21IUkdZOCtGYnNzWUxxaWJnenc2eGZK?=
 =?utf-8?B?VWJyQzI2b0tBWEkyc0Q4YXFKNTF6U014akEzZXBzRVdPYlo1d01BbXk0VDdy?=
 =?utf-8?B?b2U5MkRUejFBRlhwV0prMGJ0L0h4TzRFY3pDTUhyQjNPU00vdFR6MzhWRmJU?=
 =?utf-8?B?SVFua0dYOE5MUEtzTWsrL1VvRDB2TmtBazIzVGdhd2I4ZlNPbUNRWjNEVEtz?=
 =?utf-8?B?K2ZBZ2o0ZjJ2K29xWXB2ajNELy8zVys0ZjgrVVRCWVErd1BDcVpjZFVTZUIz?=
 =?utf-8?B?U2YyVHJReXRvWE5ZdHArZjZ3MHBzbDlENGw2RXFIc3BsVEhXcStDSWwxV3Nz?=
 =?utf-8?B?NUtYbi9aVExmNHBOSXRaTVNGSEVvbWxxVkFSRmNkRmxra1JOdGtaRW5WTVVI?=
 =?utf-8?B?NlhXTUhKOGxaTk5IODc3MjZLS1MxMUZIZVVURXE3L2V1WGRxZFJ2dEhWQUlt?=
 =?utf-8?B?M3NOVkd6Zms4N05rclErNjMyOWo1T1V3YU80S0hCTU55MUVLY2FEN1lHRFF6?=
 =?utf-8?B?dW1udkJRVFRqTkRzak5WWlhFejJFM1ZXaVBiQ0lTa2k4SENjMlFVc29RVGlY?=
 =?utf-8?B?Nk5NQ25wbVhOOTRWUVIzNEpUdFlESUw3RWlkd0p4WUlMbHB0Y0xKT1hSMGM1?=
 =?utf-8?B?U1JrMDRDd00yM3FwTDA0UUVkU1JDc1pPVXdTZnErTmpqMktiT21zOXZaTG05?=
 =?utf-8?B?RHMyZVhNUUZNaElCcTlzVFpkWFZudjczWGhianlCVWdZNDZWR09lMFd1TXZO?=
 =?utf-8?B?QU85Qm9OWkN6b1dOUVhObkllbzRpbVBPTXYzQmNFd0ZrdTlmQlNVdkVld2FF?=
 =?utf-8?B?WEdSbGU3T090UWF0SlMyMzJUbHREUEltZXNyRDdDVXZYTHJtSlkrYlhUekxm?=
 =?utf-8?B?ZnZwVnU4aXJPN05zR2dtSTNFYjVsNnl2QXRqK09raXVQWHdITFAzOW9xZ2VC?=
 =?utf-8?B?d1NRTWd0YWlib1BNcHRhOCtva2FJb1BzTFE2WEtvZEVuMnZqS3Z3OVZseTJq?=
 =?utf-8?B?WndSVmFMaTY5c05UclQyNnQrQmRPK0ZqMm4vOTlOME1NbXhKR3FSeGJRSW9N?=
 =?utf-8?B?cHZSRG50anJpaDVCK3FKaVI1UkF5aE9HNi9VOUpBRFplbzBEVy90VzJ5NVpm?=
 =?utf-8?B?Z1JSYzVmSngyTnB1bG52ckZPQ05ZVHdGSjAyM2ZmT0ltbWp2ZEF2TjdKN2hG?=
 =?utf-8?B?b1k4RmR5Q21zd0pnNGFDRitOUFc4VDNDdnJmV0kwZkpJZldoWkk1QWt6NVFY?=
 =?utf-8?B?MU1zditWc0ZKNkRmd1MwbHRQNlhiNGJ4Y1ZwWlFvTjROYlZWNWcyWGloc1dW?=
 =?utf-8?B?S1Q3Qk9XVmhQMldRdW8rRWFvVnd0Ukk3ekw0dVEzck1YWXVVTGNKNXhIbG81?=
 =?utf-8?B?OHVzakwrZk52OWRTTGxLdUNRUndKU3VCUXRhMGRiSmNmeUFWWTlXNmZzczFu?=
 =?utf-8?B?L0F4MUtuMTdDVGJpUmJRR1RJTVBDSHBaMk1ENE5Jb2ZvKytJa2lEd3UyR25X?=
 =?utf-8?B?bUV1bnJLemdKZ1VpMmVOTDcwd1Y5ZmlHSmRqU2o1YlB5dkJwMEh0bkxhRVlj?=
 =?utf-8?B?bWs1VFJtVVN4NXlQVjBmWU1VM2NmNXRoY2tXZnNwTXVBSnBiTmo2UWhkUGVm?=
 =?utf-8?B?OGJWUHhpbjlRb1hWd2JpYk1IZ2NGZzFqYy9NU2lOc2dMb0hJdm55aFB0MVdP?=
 =?utf-8?B?b1ByRVBwd2MxaSs1YWdESnVpL0lkcDBOdEpheWVDYnE0Q092Y3FuSFlPamRk?=
 =?utf-8?Q?wOps=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6081.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2fa7ca-2b5d-469f-9f15-08dbba847f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:24:03.6275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvJgHNqpMPRQA7n+E6DeDO3gyJh7ui3qWQQ8Y2yqznXMNQ9tJR1D33yZfkJYLfLfBjl747qH7JJ4QESl9lheOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldpdGggY2xhcmlmaWNhdGlvbiBm
cm9tIExpam8sIHBhdGNoIGlzLA0KDQpSZXZpZXdlZC1ieTogQXNhZCBLYW1hbCA8YXNhZC5rYW1h
bEBhbWQuY29tPg0KDQpUaGFua3MgJiBSZWdhcmRzDQpBc2FkDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50
OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIxLCAyMDIzIDI6NDQgUE0NClRvOiBLYW1hbCwgQXNhZCA8
QXNhZC5LYW1hbEBhbWQuY29tPjsgR2FkcmUsIE1hbmdlc2ggPE1hbmdlc2guR2FkcmVAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgWmhhbmcsIE1vcnJpcyA8
U2hpd3UuWmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6RXhw
b3NlIHBoeXNpY2FsIGlkIG9mIGRldmljZSBpbiBYR01JIGhpdmUNCg0KDQoNCk9uIDkvMjEvMjAy
MyAxMjozNCBQTSwgS2FtYWwsIEFzYWQgd3JvdGU6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkg
LSBHZW5lcmFsXQ0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQt
Z2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YN
Cj4gTWFuZ2VzaCBHYWRyZQ0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIxLCAyMDIzIDEw
OjA2IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tp
bmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFt
ZC5jb20+OyBNYSwgTGUNCj4gPExlLk1hQGFtZC5jb20+OyBaaGFuZywgTW9ycmlzIDxTaGl3dS5a
aGFuZ0BhbWQuY29tPg0KPiBDYzogR2FkcmUsIE1hbmdlc2ggPE1hbmdlc2guR2FkcmVAYW1kLmNv
bT47IExhemFyLCBMaWpvDQo+IDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZGdwdTpFeHBvc2UgcGh5c2ljYWwgaWQgb2YgZGV2aWNlIGluIFhHTUkgaGl2ZQ0K
Pg0KPiBUaGlzIGlkZW50aWZpZXMgdGhlIHBoeXNpY2FsIG9yZGVyaW5nIG9mIGRldmljZXMgaW4g
dGhlIGhpdmUNCj4NCj4gU2lnbmVkLW9mZi1ieTogTWFuZ2VzaCBHYWRyZSA8TWFuZ2VzaC5HYWRy
ZUBhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jIHwg
MjAgKysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3hnbWkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMNCj4g
aW5kZXggMDYxNTM0ZTg0NWE3Li40Y2YzODE2NGQ3MmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0KPiBAQCAtMzI1LDYgKzMyNSwxNyBAQCBzdGF0aWMg
c3NpemVfdCBhbWRncHVfeGdtaV9zaG93X2RldmljZV9pZChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYs
DQo+DQo+ICAgfQ0KPg0KPiArc3RhdGljIHNzaXplX3QgYW1kZ3B1X3hnbWlfc2hvd19waHlzaWNh
bF9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1Zikgew0KPiArICAgICAgIHN0cnVjdCBkcm1f
ZGV2aWNlICpkZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsgICAgICAgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZGV2KTsNCj4gKw0KPiArICAgICAgIHJl
dHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVsbHVcbiIsDQo+ICsgYWRldi0+Z21jLnhnbWkucGh5c2lj
YWxfbm9kZV9pZCk7DQo+ICsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV94
Z21pX3Nob3dfbnVtX2hvcHMoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikgQEAg
LTM5MCw2ICs0MDEsNw0KPiBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfeGdtaV9zaG93X2Vycm9y
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4NCj4NCj4gICBzdGF0aWMgREVWSUNFX0FUVFIoeGdtaV9k
ZXZpY2VfaWQsIFNfSVJVR08sDQo+IGFtZGdwdV94Z21pX3Nob3dfZGV2aWNlX2lkLCBOVUxMKTsN
Cj4gK3N0YXRpYyBERVZJQ0VfQVRUUih4Z21pX3BoeXNpY2FsX2lkLCAwNDQ0LA0KPiArYW1kZ3B1
X3hnbWlfc2hvd19waHlzaWNhbF9pZCwgTlVMTCk7DQo+IFtLYW1hbCwgQXNhZF0gIENhbiB3ZSB1
c2UgU19JUlVHTyBpbiBwbGFjZSBvZiBoYXJkIGNvZGUgdmFsdWUgMDQ0ND8NCj4NClRoaXMgaXMg
dGhlIHJlY29tbWVuZGVkIHdheSBieSBjaGVja3BhdGNoLiBTX0lSKiB3aWxsIHJlc3VsdCBpbiAi
U3ltYm9saWMgcGVybWlzc2lvbnMgYXJlIG5vdCBwcmVmZXJyZWQuIENvbnNpZGVyIHVzaW5nIG9j
dGFsIHBlcm1pc3Npb25zIg0KW0thbWFsLCBBc2FkXSBPay4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+
IFJlZ2FyZHMNCj4gQXNhZA0KPiAgIHN0YXRpYyBERVZJQ0VfQVRUUih4Z21pX2Vycm9yLCBTX0lS
VUdPLCBhbWRncHVfeGdtaV9zaG93X2Vycm9yLCBOVUxMKTsgIHN0YXRpYyBERVZJQ0VfQVRUUih4
Z21pX251bV9ob3BzLCBTX0lSVUdPLCBhbWRncHVfeGdtaV9zaG93X251bV9ob3BzLCBOVUxMKTsg
IHN0YXRpYyBERVZJQ0VfQVRUUih4Z21pX251bV9saW5rcywgU19JUlVHTywgYW1kZ3B1X3hnbWlf
c2hvd19udW1fbGlua3MsIE5VTEwpOyBAQCAtNDA3LDYgKzQxOSwxMiBAQCBzdGF0aWMgaW50IGFt
ZGdwdV94Z21pX3N5c2ZzX2FkZF9kZXZfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwN
Cj4gICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgICB9DQo+DQo+ICsgICAg
ICAgcmV0ID0gZGV2aWNlX2NyZWF0ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3hnbWlfcGh5
c2ljYWxfaWQpOw0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIGRldl9l
cnIoYWRldi0+ZGV2LCAiWEdNSTogRmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgZmlsZSB4Z21pX3Bo
eXNpY2FsX2lkXG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgICAg
fQ0KPiArDQo+ICAgICAgICAgIC8qIENyZWF0ZSB4Z21pIGVycm9yIGZpbGUgKi8NCj4gICAgICAg
ICAgcmV0ID0gZGV2aWNlX2NyZWF0ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3hnbWlfZXJy
b3IpOw0KPiAgICAgICAgICBpZiAocmV0KQ0KPiBAQCAtNDQ4LDYgKzQ2Niw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3hnbWlfc3lzZnNfYWRkX2Rldl9pbmZvKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPg0KPiAgIHJlbW92ZV9maWxlOg0KPiAgICAgICAgICBkZXZpY2VfcmVtb3ZlX2Zp
bGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJfeGdtaV9kZXZpY2VfaWQpOw0KPiArICAgICAgIGRldmlj
ZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0cl94Z21pX3BoeXNpY2FsX2lkKTsNCj4g
ICAgICAgICAgZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3hnbWlfZXJy
b3IpOw0KPiAgICAgICAgICBkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJf
eGdtaV9udW1faG9wcyk7DQo+ICAgICAgICAgIGRldmljZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYs
ICZkZXZfYXR0cl94Z21pX251bV9saW5rcyk7IEBAIC00NjMsNiArNDgyLDcgQEAgc3RhdGljIHZv
aWQgYW1kZ3B1X3hnbWlfc3lzZnNfcmVtX2Rldl9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiAgICAgICAgICBtZW1zZXQobm9kZSwgMCwgc2l6ZW9mKG5vZGUpKTsNCj4NCj4gICAg
ICAgICAgZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3hnbWlfZGV2aWNl
X2lkKTsNCj4gKyAgICAgICBkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJf
eGdtaV9waHlzaWNhbF9pZCk7DQo+ICAgICAgICAgIGRldmljZV9yZW1vdmVfZmlsZShhZGV2LT5k
ZXYsICZkZXZfYXR0cl94Z21pX2Vycm9yKTsNCj4gICAgICAgICAgZGV2aWNlX3JlbW92ZV9maWxl
KGFkZXYtPmRldiwgJmRldl9hdHRyX3hnbWlfbnVtX2hvcHMpOw0KPiAgICAgICAgICBkZXZpY2Vf
cmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJfeGdtaV9udW1fbGlua3MpOw0KPiAtLQ0K
PiAyLjM0LjENCj4NCg==
