Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2D0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 16:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C0C10E72A;
	Fri,  4 Feb 2022 16:50:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A015E10E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 16:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Giiwjxgsmvr/aWg5/cYV8coPU7fqIbUZI969z+uiXqljuRBmDPyNAV/XoKGlb7gyZlmiZal1hCvy2Jn0OE+aB4GRArk1hIQaKUCVwhVGPKySI0G4GC25uJ9xI2w58uOWKzeiFG/gk1c2BNT0kkvpp7+0FCk9Ra5RjhsGFzoHOo0NYnxVhmBfz36siZpxtPUV/DIObVtoi2YKYMnBY9deXkKSKAFxpiZDed4TE3WA75ddcsX6NqHMf4aKTr2VBxNgBbOK7vARSXl5/jGhafeu2N6Ob2z6LoIlohSGmYzh61q54XhKeKVZoyfACJowXb2eRujrqrhL/G3ARiNkp0tmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyhKCKzjGJ1bRclJ08q0/vu07kz7kRR5oj0JqXo0rMM=;
 b=Z8pwxUrRxy93JkgZx6jkSw4kpEw8c63UOowYyTN5eqXdXLnQbNlozKOLs3LO26wBmWVs10vnqBDg65B2tofP1mO4AkfXjPFbqA7jWlmU/47P8iJw7YY0sBCg+b6r6mNDlQjLTt6B8rwOczvcyNg8unY3KrHNVxLhSYmsE+lHOt0hHTmTyY8nNzmv/Ea14DtKMBNSDFLoHbTyjx8+1b7IYSq4dE9RdRcBk1gXeoVA1hSSHCv6LT+izC8LH4i2EakD5TR+mng5dLNcMDDds3BI9GGycaUqLGtYN6mpBqp2yAkQxRs/+C5LGUOrGWbVRcqT86XqUL4axtVIITzTBtBLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyhKCKzjGJ1bRclJ08q0/vu07kz7kRR5oj0JqXo0rMM=;
 b=udIlN/Nt5fNiPfjdK/Mg7LhKB1uJ9WDNHybYtG2tk0fILr58QDgsi8g+4eG5R1QSLSj+0NeLy6s9Lt/HDs8kgVVrrT67hgrZP3ArrEjGqcsLBnoVCZoJZo/7P2ufcaBnaiz2qrpXB6jvpeEvElThqJN3odRTq0zJmTttuzo2iRo=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 16:50:39 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636%4]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 16:50:39 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Topic: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Index: AQHYDwZjidvy0bXGukSiArQ04UD9j6xumGUAgBUU44CAAAJvEA==
Date: Fri, 4 Feb 2022 16:50:39 +0000
Message-ID: <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
In-Reply-To: <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-04T16:47:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b9f0c2fc-5ee9-4e1d-af31-c4bb68c7134f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-04T16:50:35Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ffb0d2a0-8004-4924-b876-b1ac30f8d6a7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a13689ca-6204-4679-ee34-08d9e7fe793b
x-ms-traffictypediagnostic: BY5PR12MB3666:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3666687389F9D67C5A1565F597299@BY5PR12MB3666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UkZ2fWhBHTO6MbOhQgax9RRzkTIyPNDtvcNAdkzMfLhQtmeWBxmkYQZI//RmlRXk5sm968L1J8JvfsnVDn9Z0egpx6s31yz5DgqyR+ZcGm0YkCksBmFPNTWNK24ogU35JXPmhfmsL04HWdnnNM8UL2R0o4co9xoVh6zTcbHyVjD1Pm71IVdjHU/rpiAb+vSK7QBJNHWufKuoArXqbfKcrgDtO6AKNzAIlon06JDBwCpJGdocDFMXMN2Ih6bQj+f8bDoJqyCUNmxhEhT1WzmSZb/USahO7BYfsWaBNZEoBZMlUR1MdbWuRmRrgv4fxZSxHlrPJGl/uMZQ7GaUTaReXRsphf/xuz5Em/cjIAnG9V2sEceZrVXYdpTX7Wu+QIQjUUBYWTBmVZ9d4kAKKFku44jBkAs3CurON6zPVsEBiuJ0WgUYDq3skOWiCoXZca98L3eedOscvLcpEHiK2KiNW7slWfYmdEKF6sxpAR1VzUc33v0zRSUwIsumc6Mmm0ySK6Ft3Bu+sq/qWtgX5m+3oYhMzi7V2nOZPTk0RMaeHMMTjhBKO7gpWhecCHcwHWKi/h5R6BPpf5OFyueLgLfrFXThVyYL8MlhA+MEaEl5XQKFZdYxw71HNt8rq/oatYNu1R9F3YUssOgHVWoXtssU/cAuCu8snkcXHUPDj2GFG2xOjItDIj/uxim+iTbjARA2K2101AoGqp1LYQq/hA2Tjz76f4K+vLW1D64EN3+EvmGiNWdigOWxJDbGrWXSx0WRVhKO2rmbZtnTj7WDyft3XUKUEtRqC3vuNauOk9Uy8mU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(33656002)(54906003)(55016003)(316002)(110136005)(83380400001)(86362001)(66556008)(508600001)(122000001)(38100700002)(5660300002)(6506007)(71200400001)(186003)(66476007)(66446008)(66946007)(26005)(4326008)(53546011)(7696005)(38070700005)(9686003)(2906002)(76116006)(8676002)(8936002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm5TUTFQMGNUZVpnaFlNSU0xVDVDN3RxelJtczE1RlNKcVRyamNCT0dxZUdC?=
 =?utf-8?B?ZzRxTTNNYVp0RkF3VzJRWllBMms3dXJBRUVyem1nSHZZcXMwRG1qN3liTnJX?=
 =?utf-8?B?Zy84ZWEzejlqZ2tRcG9jalhrSXRuQUozZ24wNEVLS0wvdS96cWUrK2NWTU85?=
 =?utf-8?B?VUdySlBJbFNoekdwRVFTLzlhTHVTaHlRemNsczZyeVpCZ3BneEpmNFVQVTVL?=
 =?utf-8?B?MHlWSW9uRzdxOWNNSXhVTGdCVzRXTDNwWklXV1FQRkh3aThzZmFYbUxTVk0x?=
 =?utf-8?B?WFcwQmFicmNoVURBS045Z1M2azljdWFkUW5Rd21Wazg4NVFMZURhY1FyNWJs?=
 =?utf-8?B?M0p6U0NScnBITG0wRTNUNThMVkN3cS96RC8zbVJtWWNPdU5lYWFMNjg2REQx?=
 =?utf-8?B?YVJuRkNLYzlKYmRLeWNQMi95SDRjK2ZNWTN2cTdBSTRzL2M4MXVFRCtGaHZw?=
 =?utf-8?B?WldBU2NwdWlSUkx0aFlMZmROMU5IUDlKYUdRUWk5ekE5UkxGZy9VNFBmaDJq?=
 =?utf-8?B?R01qOWEzWlV3U2JaZ211R3FHZXZ5RzdNNTYxT0VqdDMrRnNNV2pCM2NOQ1Zn?=
 =?utf-8?B?ZnBSVEdsNTdTdGs5U3N6MzY3MnYzS2FKaHFxcmlSTTVNZmNZand1aENnT3Ji?=
 =?utf-8?B?ZXMyeWlvc0tjWW0rRy8vOE00aUloM2NSWm9YQmtjODJLZm1UZWZYV3lJT1RH?=
 =?utf-8?B?MXdJYzdaTlpWcE1rRTZieitOWnFDS0dsT2REVmVUUE9DSjZRUUt4VVp6RjZh?=
 =?utf-8?B?eVlka2dBWHJSd2FidWEyLzVxT3NxSDhxeXdTM0pPWm5Uei8yMUN2T1FHV1gx?=
 =?utf-8?B?cDk1cm4zcGV0YThjVTRNMHVNVTRHbnI0aHhLOVJYUXhhZXNrODgvdGF3VG92?=
 =?utf-8?B?ZUNYR2RVR3Nmd3F4aGo1SGhSNkdhSys0K2NqRTc0bFRPbW1ZNmd0Um95dWF5?=
 =?utf-8?B?blAyVndkTUJWcnFDU3k1TU1FYU1KZGdtUVBrTk5GWjdRS1VxT3I4TnVuNU81?=
 =?utf-8?B?dG05Q1YwWXg2YVN3SzN3OGdoU0QxNVJaQzZuMHlseDk2LzB3NjB4cGVaTHd5?=
 =?utf-8?B?amtKdVNTWUZWSUJnTzB1SGp2Q3hzRTJxUXJpS1dSeEVCMVhySWNGZTViS1Fw?=
 =?utf-8?B?bVVCMFJWWjJTUkFMR0l2TjkrY3V3YzBOeXpJSXZGQUsxb0FQODFZY1F2eCtL?=
 =?utf-8?B?a2xGRTZ2aGt1ZmtVQlJyQTVLWXU3OHNYMnB0N1Fhd0hkY2ZLaUhFY24wTU1W?=
 =?utf-8?B?MWwydDcxSHJzSXQwVGlya1V1ZEJaQ3BIcmFDZHl5QndBbWpXc2M4dzdKSVJq?=
 =?utf-8?B?UUU1NTdjcEs0eGMzaGJDc0l2Q2tGSTV6U0EyZGx1R0grVExmcGRkWnZtNXEw?=
 =?utf-8?B?TU9DTk94WDFWY2tLb3NrSzh5ZFJ4TEM1dzJURWNTMnpXR1o0QTdaU0pUYXBm?=
 =?utf-8?B?TndQZis2czJmZFRsdzM0THA4eWN3c1lSZWlNeS9EY1ppTVFBMHJwNm1jdEtV?=
 =?utf-8?B?bStoU0lpR3J6RURyVGJvbWgrQk5OWkN0UmtwVVo4aGV1OWkybmlDUTBGUXI4?=
 =?utf-8?B?NnkvYjRyVDI3Z3ZxMTA2ZW0yRXpmWTVrRnVBNVRsZmoxNTVGS01XR0wwY2lr?=
 =?utf-8?B?MkFxOVA3UWhtSTBwY3ZTeUxtVjFGSHhDK2NaSVc3ekNYUjBkZ3FXK1M0Zzd1?=
 =?utf-8?B?cFFtTWtyZVhROFJZL2Znc3pUZ0xiRXRCQkdWM1JWc3hodUF0bFdXd2xxa0dj?=
 =?utf-8?B?VnpmTEs3Y0xJcmJ6RC9JQmltSStmQXNnbThXelpIaEFaTml1TzNnVnJLbk9I?=
 =?utf-8?B?VUdhd1FGZlhHS2ZqQkxTWHRmbUFaNHB4eGhYSHY2dk04cExTZVNBSWwvOVRt?=
 =?utf-8?B?THh2Y0tzMFZKWXVndER0MGxWNmxRKzBPY21VN2JBQ0RJZE1FYmRyTjdmOFEy?=
 =?utf-8?B?dk12K0ZHaFdYaGo1eFp3Y0hPd3lnWjROa3R5NGZqSXRNS1UzT2gwUGg2L0tJ?=
 =?utf-8?B?NzRHZll2RkR5dXpKc293dE1aeUN0Ny8vZVM4bjdNNGtXYnFmdUtpTG4yajRp?=
 =?utf-8?B?VHhvMXphZHh1VFNNQ3RLVnBraDF1VjZiM1VpaDJ5dk9zZUpFemFMWVlsY0p2?=
 =?utf-8?Q?kd5c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13689ca-6204-4679-ee34-08d9e7fe793b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 16:50:39.0847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoakXLXuqUo/6gRz9gJXpeV5B7F+eLSwsEMBKAR6rlhKbTvkvYBeore3gAof+Rrm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVG8gZXhwbGFpbiBtb3JlIC0NCglJdCdzIGFuIHVu
Y29uZGl0aW9uYWwgcmVzZXQgZG9uZSBieSB0aGUga2VybmVsIG9uIGV2ZXJ5IHN1c3BlbmQgKFMz
L1M0KS4gSW4gc3VjaCBhIGNhc2Ugd2hpY2ggcHJvY2VzcyBpcyBnb2luZyB0byByZWNlaXZlIHRo
ZSB0cmFjZSBldmVudHM/DQoNCk1vc3QgbGlrZWx5IHVzZSBjYXNlIHdvdWxkIGJlIHJlbGF0ZWQg
dG8gZ3B1IHJlY292ZXJ5LiBUcmlnZ2VyaW5nIGEgdHJhY2Ugb24gZXZlcnkgcmVzZXQgZG9lc24n
dCBsb29rIGxpa2UgYSBnb29kIGlkZWEuDQoNClRoYW5rcywNCkxpam8NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNoYW5rLlNoYXJtYUBh
bWQuY29tPiANClNlbnQ6IEZyaWRheSwgRmVicnVhcnkgNCwgMjAyMiAxMDowOSBQTQ0KVG86IExh
emFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFNvbWFsYXB1cmFtLCBBbWFyYW5hdGggPEFtYXJhbmF0aC5Tb21hbGFwdXJhbUBhbWQuY29tPjsg
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggNC80XSBkcm0vYW1kZ3B1L252OiBhZGQgbmF2aSBHUFUgcmVzZXQgaGFuZGxlcg0K
DQpIZXkgTGlqbywNCkkgc29tZWhvdyBtaXNzZWQgdG8gcmVzcG9uZCBvbiB0aGlzIGNvbW1lbnQs
IHBscyBmaW5kIGlubGluZToNCg0KUmVnYXJkcw0KU2hhc2hhbmsNCg0KT24gMS8yMi8yMDIyIDc6
NDIgQU0sIExhemFyLCBMaWpvIHdyb3RlOg0KPiANCj4gDQo+IE9uIDEvMjIvMjAyMiAyOjA0IEFN
LCBTaGFybWEsIFNoYXNoYW5rIHdyb3RlOg0KPj4gwqBGcm9tIDg5OWVjNjA2MGViN2Q4YTNkNGQ1
NmFiNDM5ZTRlNmNkZDc0MTkwYTQgTW9uIFNlcCAxNyAwMDowMDowMCANCj4+IDIwMDENCj4+IEZy
b206IFNvbWFsYXB1cmFtIEFtYXJhbmF0aCA8QW1hcmFuYXRoLlNvbWFsYXB1cmFtQGFtZC5jb20+
DQo+PiBEYXRlOiBGcmksIDIxIEphbiAyMDIyIDE0OjE5OjQyICswNTMwDQo+PiBTdWJqZWN0OiBb
UEFUQ0ggNC80XSBkcm0vYW1kZ3B1L252OiBhZGQgbmF2aSBHUFUgcmVzZXQgaGFuZGxlcg0KPj4N
Cj4+IFRoaXMgcGF0Y2ggYWRkcyBhIEdQVSByZXNldCBoYW5kbGVyIGZvciBOYXZpIEFTSUMgZmFt
aWx5LCB3aGljaCANCj4+IHR5cGljYWxseSBkdW1wcyBzb21lIG9mIHRoZSByZWdpc3RlcnNhbmQg
c2VuZHMgYSB0cmFjZSBldmVudC4NCj4+DQo+PiBWMjogQWNjb21vZGF0ZWQgY2FsbCB0byB3b3Jr
IGZ1bmN0aW9uIHRvIHNlbmQgdWV2ZW50DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU29tYWxhcHVy
YW0gQW1hcmFuYXRoIDxBbWFyYW5hdGguU29tYWxhcHVyYW1AYW1kLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+DQo+PiAtLS0N
Cj4+IMKgwqBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgMjggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gwqDCoDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgDQo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgaW5kZXggMDFlZmRhNDM5OGU1Li5h
ZGEzNWQ0YzUyNDUgDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L252LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCj4+IEBA
IC01MjgsMTAgKzUyOCwzOCBAQCBudl9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSANCj4+ICphZGV2KQ0KPj4gwqDCoMKgwqDCoCB9DQo+PiDCoMKgfQ0KPj4NCj4+ICtzdGF0
aWMgdm9pZCBhbWRncHVfcmVzZXRfZHVtcHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsN
Cj4+ICvCoMKgwqAgaW50IHIgPSAwLCBpOw0KPj4gKw0KPj4gK8KgwqDCoCAvKiBvcmlnaW5hbCBy
YXZlbiBkb2Vzbid0IGhhdmUgZnVsbCBhc2ljIHJlc2V0ICovDQo+PiArwqDCoMKgIGlmICgoYWRl
di0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZFTikgJiYNCj4+ICvCoMKgwqDCoMKgwqDCoCAh
KGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNfUkFWRU4yKSkNCj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm47DQo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tz
OyBpKyspIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0
dXMudmFsaWQpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+cmVzZXRf
cmVnX2R1bXBzKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+PiArwqDC
oMKgwqDCoMKgwqAgciA9IA0KPj4gK2FkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+
cmVzZXRfcmVnX2R1bXBzKGFkZXYpOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyKQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFJNX0VSUk9SKCJyZXNldF9yZWdfZHVtcHMgb2Yg
SVAgYmxvY2sgPCVzPiBmYWlsZWQgDQo+PiArJWRcbiIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzLT5u
YW1lLCByKTsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCAvKiBTY2hlZHVsZSB3b3Jr
IHRvIHNlbmQgdWV2ZW50ICovDQo+PiArwqDCoMKgIGlmICghcXVldWVfd29yayhzeXN0ZW1fdW5i
b3VuZF93cSwgJmFkZXYtPmdwdV9yZXNldF93b3JrKSkNCj4+ICvCoMKgwqDCoMKgwqDCoCBEUk1f
RVJST1IoImZhaWxlZCB0byBhZGQgR1BVIHJlc2V0IHdvcmtcbiIpOw0KPj4gKw0KPj4gK8KgwqDC
oCBkdW1wX3N0YWNrKCk7DQo+PiArfQ0KPj4gKw0KPj4gwqDCoHN0YXRpYyBpbnQgbnZfYXNpY19y
ZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+IMKgwqB7DQo+PiDCoMKgwqDCoMKg
IGludCByZXQgPSAwOw0KPj4NCj4+ICvCoMKgwqAgYW1kZ3B1X3Jlc2V0X2R1bXBzKGFkZXYpOw0K
PiANCj4gSGFkIGEgY29tbWVudCBvbiB0aGlzIGJlZm9yZS4gTm93IHRoZXJlIGFyZSBkaWZmZXJl
bnQgcmVhc29ucyAob3IgZXZlbiANCj4gbm8gcmVhc29uIGxpa2UgYSBwcmVjYXV0aW9uYXJ5IHJl
c2V0KSB0byBwZXJmb3JtIHJlc2V0LiBBIHVzZXIgd291bGQgDQo+IGJlIGludGVyZXN0ZWQgaW4g
YSB0cmFjZSBvbmx5IGlmIHRoZSByZWFzb24gaXMgdmFsaWQuDQo+IA0KPiBUbyBjbGFyaWZ5IG9u
IHdoeSBhIHdvcmsgc2hvdWxkbid0IGJlIHNjaGVkdWxlZCBvbiBldmVyeSByZXNldCwgY2hlY2sg
DQo+IGhlcmUgLQ0KPiANCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0
L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZA0KPiBncHUvYW1kZ3B1X2Rydi5jI0wyMTg4
DQpJbiB0aGUgZXhhbXBsZSB5b3UgcG9pbnRlZCB0bywgdGhleSBoYXZlIGEgY3JpdGVyaWEgdG8g
ZGVjaWRlIHdoYXQgaXMgYSB2YWxpZCByZXNldCBpbiB0aGVpciBjb250ZXh0LCBpbiB0aGUga2Vy
bmVsIHNpZGUgaXRzZWxmLiBTbyB0aGV5IGNhbiB0YWtlIGEgY2FsbCBpZiB0aGV5IHdhbnQgdG8g
ZG8gc29tZXRoaW5nIGFib3V0IGl0IG9yIG5vdC4NCg0KQnV0LCBpbiBvdXIgY2FzZSwgd2Ugd2Fu
dCB0byBzZW5kIHRoZSB0cmFjZV9ldmVudCB0byB1c2VyIHdpdGggc29tZSByZWdpc3RlciB2YWx1
ZXMgb24gZXZlcnkgcmVzZXQsIGFuZCBpdCBpcyBhY3R1YWxseSB1cCB0byB0aGUgcHJvZmlsaW5n
IGFwcCB0byBpbnRlcnByZXQgKGFsb25nIHdpdGggd2hhdCBpdCB3YW50cyB0byBjYWxsIGEgR1BV
IHJlc2V0KS4gU28gSSBkb24ndCB0aGluayB0aGlzIGlzIGNhdXNpbmcgYSBjb25zaWRlcmFibGUg
b3ZlcmhlYWQuDQoNCi0gU2hhc2hhbmsNCj4gDQo+IA0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+
IA0KPj4gwqDCoMKgwqDCoCBzd2l0Y2ggKG52X2FzaWNfcmVzZXRfbWV0aG9kKGFkZXYpKSB7DQo+
PiDCoMKgwqDCoMKgIGNhc2UgQU1EX1JFU0VUX01FVEhPRF9QQ0k6DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZGV2X2luZm8oYWRldi0+ZGV2LCAiUENJIHJlc2V0XG4iKTsNCg==
