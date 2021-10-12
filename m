Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACEBC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D99A61078
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D99A61078
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0366E82A;
	Tue, 12 Oct 2021 09:18:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CA86E82A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 09:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmcJ6fO+4nFnV4abGIrQ5PVb3aZRgR98ELcFd8O/XYTiHGWquns3md4lUF/o1kPvEaqP4aIhxOS9n7KsEG/+nuq1YqINSylKkFssB1Mv69x9MWMEvsoMa94VRVbv4Xkb3guH5Y6IsAFpzCwlF+y1WJc8fVw9ak06Ce13g+dWOvbC7BuoLoUFqOocQ7Rlq0Kv44dr3EfL5gkbHKSY4d+9d7jxIjOBKHBhX9vmz+Ufe3okB6Qwm8VqCbtbbk0i5cubuqgktIryR2dpeUKmxtNFoVVfXAzG2BadZcR8Sgef5BC7RAgMfhQ+p3J9elR/T0blyL5B55Hpi3DAkbITws6idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UxG2lpr6Jx6ANEonZluSrtimZ11PB9DotFVfdRbPVo=;
 b=Vx96DJlFCVIH78lXhntJBHC8hsd/aRBgxbkbNXn0WV9uh1UvpmoFu4PYWhpBQ0/DsBiWxH9BMMHoX4XN0lLsyCrilz7awoBfuHgiNv7L+JYErkH5y6yegQlc6bWEJzInUFgaimwPXH89+6CoD17yHDoIEyPjyw3kKdalLGR9vJtwdUcqtU8dejlbES0MvB4xVo/FAXnLIsB+GNN10o8P2t0zoYF8XojyxmGPpn0y6RPr38cu8tDpkSovk2eokmgztV5cTzR2OYJ8kePHW0FmUruCF4AeaLQxmtiV9IEmIwV3DDiD4MHYFQCLqmRNRLbSLLmzxRknoCnDjkRD1QexxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UxG2lpr6Jx6ANEonZluSrtimZ11PB9DotFVfdRbPVo=;
 b=djr+IEQiMayFFJfxAzLVk3zeb2Y47gSZxTIHs6GfyQjSWG6Et+cNmW7+ixays4fztRsk8Yzq/C+qFD/EGAkx5DrgriumLHZXyFeZcajR9AFTO1J7IT4WnGGXrRCK64uJVGBztBVSt48tpzVhgRcUPLfU94kS6BBtvpISl18D42I=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Tue, 12 Oct 2021 09:18:14 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:18:14 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable display for cyan skillfish
Thread-Topic: [PATCH] drm/amdgpu: enable display for cyan skillfish
Thread-Index: AQHXvzCwBv8EHO/Mvke4mBbIO+N7wqvPDkcAgAABQlA=
Date: Tue, 12 Oct 2021 09:18:14 +0000
Message-ID: <DM6PR12MB42507547A4CCEAE8D595F923FBB69@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211012061605.809634-1-lang.yu@amd.com>
 <fb7a3b6f-4f53-59ec-d9da-031145b08ac4@molgen.mpg.de>
In-Reply-To: <fb7a3b6f-4f53-59ec-d9da-031145b08ac4@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-12T09:18:11Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0b8e1887-3af8-4b21-9945-6e509c8f2514;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5abd3003-e8ca-44ee-7caf-08d98d613866
x-ms-traffictypediagnostic: DM5PR1201MB2490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB24900CCFE8E25BBCC848FA44FBB69@DM5PR1201MB2490.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkCkQbDTs65IjKCsOnO4kvr2T+WFiasiFhd4bYhkNWXgazu/j09BptAUTo3qOq6wmH0exnK4t9bvQL9o7e5dwyrD63LhUtHuEFpQOOiVSrkxMlnMt47lmuwmiTU7ACCa3AifyuiV8MUUkskFXhI8GmGr8U/CIqW8leGUMTF5fuWTkCsSgNud02RXu+j/U8cVpQrZ5cBHSIxBwdzi2aAdYNh+UnpFVqwQQnLEh7MNEByrZpHMlnrSGtCqhyCqIRTyTKQTxEYBdSOMf7KP4pi13iHQcW3zwCdNPF/m8gxT6gxFy3AsLXWG57o0fuKlSqtyslrOb6mBBj4938A02izS5QzEJ3NsBAJJPfKo5wtitZ+m0jgddYPZjHiDRw69leyTfgteP0jY7H43A3lWbNKQYVWbdR/p3564JNWRQhYCkbcK/hagl44ecCEOhDLooOsGeo6ZRDTMZgGkCBA3WT1Yt+O0F6/O9ClEvRMABmob+mxpAIyEi2+O6Tfobv7cLwyRg2Uuad0NPbZQPtuEm+JJqYqb8RXxhoX//mzOIFyiYPsIqWYEDsdUtG0QOdYHXc+0sYnnK2KWUGlt/zY1pwjNtGwRYDZTgkWpkphGoTMMJlncOQ4jsZZpSPnFEuOPk2GbZRsgbUC5oSczAeEGGDVi2KLHbomEClE3lLUCXsn+s98Tbt4ZH7IQMp3jMDVqBxfqs22nm30FNDWRIil96Y9SYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(33656002)(122000001)(38100700002)(55016002)(9686003)(508600001)(7696005)(38070700005)(8936002)(8676002)(83380400001)(86362001)(52536014)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(6916009)(4326008)(186003)(54906003)(26005)(6506007)(316002)(2906002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkdmRGRlMkZVYkV4bW5IZHVhUjlkTU4xVHpzTThhYzBHL1U3Q01IbFJtOTA3?=
 =?utf-8?B?dEVaQVZUZ0pITTFDcDhod3NtZHJ2c01lcE4yNUlURGpKY0c2SGEzL1RQRUQ5?=
 =?utf-8?B?NnM4Vmw3dGRGRHpSc0lCWXd5QVNnM1hWTER2dXJJNFZZbng4bVJEV1FaVW1x?=
 =?utf-8?B?eVhCbGt1blo5d1dINk9VdEpIV0F4bmRiNDdDeXYxOVdJL1dVTE9Sb3l4c3Ju?=
 =?utf-8?B?a0dsTjBIeWI3VDlSa3ZnVDM4a3U1N3BKSlVzRHN2Zml2QnIvaFpyZTNxcVM1?=
 =?utf-8?B?ZWpHVEZDUXNVUlFhNFZTbnhMaitzaCsrRzNyTzhNczVWckUzWHdaMVpkSGpp?=
 =?utf-8?B?U2ZBNUlrelNqVzYxa3hsbEtUSGE2ZUVXdnlWSFp1K3NqTE00QzBwKzJaYzFX?=
 =?utf-8?B?NlFDYXpad2NGOWhpdWoxNDdCR3kvUXB0TmRxRWMrNllaeDcwb202NkxSdGYw?=
 =?utf-8?B?dVl0K1YzQlk0K0JtcjNIZ21mc1AweUFSZVY1Vm96dkQ5eGhKNC9hTTFTU3Fp?=
 =?utf-8?B?Q1JHL0FSbUhGYUVHZU9sVUhhdXhHbUJTS3BYUEV1SUpTZFZOSUZ3Z2orc2kv?=
 =?utf-8?B?Ly92dFQyY05PRTFmTXZVRnB4YUt6QjZYS2VBY0crd2RUNGVDdGF1eDJRMStp?=
 =?utf-8?B?aUtEQkZPMGRFdzBRSXppeGl3VXgxTnh6V0llN3djUW0wM0k0T2Qva04renVV?=
 =?utf-8?B?MVZJb1F2eTNRNEZER0dPcVNzb3JoczFEaGZxSlJaTi9BUk5DeHFIWmdEY2s5?=
 =?utf-8?B?b1d6L2Z1NEpGVkIrdnJYYjE3VlhTL3RxSlNYZmpnUTlVMzRTUmoxbmN0a3pM?=
 =?utf-8?B?cG5GTlczMmhTUElBR0tsS0t3K0dhUlBSUE1mTlVkZnY1cm9wL0J2SW9CTjNY?=
 =?utf-8?B?b2huNzlCeC9JcHBPWFpGWG1PYXlWSlltRDlWbjBiN2F5blV6OUQyanJiR2ZG?=
 =?utf-8?B?a1BWd2Y2ODEvS29maUEyQ3RBUkJOVSsrTXBpM0hOS0U4VHlmNzkwc0pXd3Fl?=
 =?utf-8?B?OThUdmdDT2VTcDZmd1phQVJkbjJxdkdrNzJQd3JuUFlPNUhCbDVRL0NXWlFJ?=
 =?utf-8?B?MDdDUEQ2QWVmSW00Y3lVNFJXTEd4QU9lcFhtWjRvTC9uaDZvaWVNOHIwN3lI?=
 =?utf-8?B?cmRPUis0ak5YdEx6MTNKc1ZrOHpBeTFOd2dHK25LQkdsWEZqU2hZQUxDZVZx?=
 =?utf-8?B?KzRxVlJHUW1QTHVVZHhuYW1qNTUzLzhrcU9lMGRXWiszZkRWTkliZzVTcXlW?=
 =?utf-8?B?V29ERWlXeHFBMUQzTklCOXVkQngvRmE4NCtxN0tFMVQrTjNCOTBWOVJma2dm?=
 =?utf-8?B?Y1lsMi8vS1hJVXQzRFdwUjkyRklpMk1wQ0hYbTZlZm5sZVJXQ3hZcXJrM0ti?=
 =?utf-8?B?dEhUVDdOTUQraGlMZTR2UDg3RnZxOVZGQml0Ui9sTGUrdGJYdVgxZjFLUnRD?=
 =?utf-8?B?YkgxQzlCbHk2Y3hoU3ZneFh5RmQvS2JmVUV5aExFN0JjM3VVWkg0cmlzOTl4?=
 =?utf-8?B?S1NuSVp1ZmxsVnhyb3FCbTlydlFmTFlWb05EZlc3L0xnYVA0NlFPditTS1VT?=
 =?utf-8?B?Ymp5czcxTlhZczJTWHFadEtrcjJLdUhRaTdPM3BSQ05hdnJReWJTNHpQbHdy?=
 =?utf-8?B?UFVWOE5xK0xjbHdsTTBwWWVzYnNOa3VIUEFOTDU4TDBlcjkxMFE4TjB5VnNq?=
 =?utf-8?B?Tkx3VzZqTHZMVGJjalg5bUxpVCs0VlRrSWdqMlJ3ZFJ4Yk1NZTByZEtXV1p0?=
 =?utf-8?Q?4TqMlGzsfYobg/IoR7cVQ3uxSKKrAMMx/U1wn1a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abd3003-e8ca-44ee-7caf-08d98d613866
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 09:18:14.5388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZscut0WasZJ578DamaqQ19aNP0eOGevlJWJTj0Bx84OJa2SpC9x13YZVVVhM/v+/gNGrgTeyh98e3aspP2YTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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

W1B1YmxpY10NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhdWwg
TWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+U2VudDogVHVlc2RheSwgT2N0b2JlciAx
MiwgMjAyMSA0OjUxIFBNDQo+VG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQo+Q2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkN
Cj48UmF5Lkh1YW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPlN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGVuYWJsZSBkaXNwbGF5IGZvciBjeWFuIHNr
aWxsZmlzaA0KPg0KPkRlYXIgTGFuZywNCj4NCj4NCj5BbSAxMi4xMC4yMSB1bSAwODoxNiBzY2hy
aWViIExhbmcgWXU6DQo+PiBEaXNwbGF5IHN1cHBvcnQgZm9yIGN5YW4gc2tpbGxmaXNoIGlzIHJl
YWR5IG5vdy4NCj4NCj5XaGF0IGlzIHRoZSBsYXN0IGNvbW1pdCBtYWtpbmcgaXQg4oCccmVhZHni
gJ0/DQoNClRoaXMgb25lLCANCmNvbW1pdCA0YWM5M2ZhMGVjMTJhODg3YjQwYjgxZDliOGI3ZmNk
MTAzM2Y0OGQ1DQpkcm0vYW1kL2Rpc3BsYXk6IGFkZCBjeWFuX3NraWxsZmlzaCBkaXNwbGF5IHN1
cHBvcnQNCg0KQWN0dWFsbHksIGl0IGlzIGZpbmUgYmVmb3JlIHN3aXRjaGluZyB0byBhbWRncHVf
ZGlzY292ZXJ5X3NldF9pcF9ibG9ja3MuDQpEdXJpbmcgZGV2ZWxvcGluZyBhbWRncHVfZGlzY292
ZXJ5X3NldF9pcF9ibG9ja3MsIGl0IGlzIG5vdCByZWFkeS4NClNvIHNraXAgdG8gZW5hYmxlIGl0
Lg0KIA0KPj4gRW5hYmxlIGl0IQ0KPg0KPkhvdyBkaWQgeW91IHRlc3QgdGhlIHBhdGNoPw0KDQpJ
IGNvbXBpbGVkIGFtZGdwdSBkcml2ZXIgd2l0aCB0aGlzIHBhdGNoIGFuZCBsb2FkZWQgaXQgb24g
dWJ1bnR1IDIwLjA0LiANClRoZSBkaXNwbGF5IHdvcmtlZCB3ZWxsLiBPdGhlcndpc2UgdGhlIGRp
c3BsYXkgd29uJ3Qgd29yay4NCg0KUmVnYXJkcywNCkxhbmcNCg0KPj4gU2lnbmVkLW9mZi1ieTog
TGFuZyBZdSA8bGFuZy55dUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDMgKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPj4gaW5kZXggMmJlYmQyY2U2
NDc0Li40MjI4Yzc5NjQxNzUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPj4gQEAgLTczNiw2ICs3MzYsNyBAQCBzdGF0aWMgaW50
DQo+YW1kZ3B1X2Rpc2NvdmVyeV9zZXRfZGlzcGxheV9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+PiAgIAkJY2FzZSBJUF9WRVJTSU9OKDEsIDAsIDEpOg0KPj4gICAJCWNh
c2UgSVBfVkVSU0lPTigyLCAwLCAyKToNCj4+ICAgCQljYXNlIElQX1ZFUlNJT04oMiwgMCwgMCk6
DQo+PiArCQljYXNlIElQX1ZFUlNJT04oMiwgMCwgMyk6DQo+DQo+VGhlIG51bWJlcnMgYXJlIG5v
dCBvcmRlcmVkLiBDb3VsZCB5b3UgcGxlYXNlIHB1dCBhIHBhdGNoIGJlZm9yZSB0aGlzIG9uZSwg
Zml4aW5nDQo+dGhlIG9yZGVyaW5nPw0KPg0KPj4gICAJCWNhc2UgSVBfVkVSU0lPTigyLCAxLCAw
KToNCj4+ICAgCQljYXNlIElQX1ZFUlNJT04oMywgMCwgMCk6DQo+PiAgIAkJY2FzZSBJUF9WRVJT
SU9OKDMsIDAsIDIpOg0KPj4gQEAgLTc0NSw4ICs3NDYsNiBAQCBzdGF0aWMgaW50DQo+YW1kZ3B1
X2Rpc2NvdmVyeV9zZXRfZGlzcGxheV9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+PiAgIAkJY2FzZSBJUF9WRVJTSU9OKDMsIDEsIDMpOg0KPj4gICAJCQlhbWRncHVfZGV2
aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmZG1faXBfYmxvY2spOw0KPj4gICAJCQlicmVhazsNCj4+
IC0JCWNhc2UgSVBfVkVSU0lPTigyLCAwLCAzKToNCj4+IC0JCQlicmVhazsNCj4+ICAgCQlkZWZh
dWx0Og0KPj4gICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICAgCQl9DQo+Pg0KPg0KPg0KPktpbmQg
cmVnYXJkcywNCj4NCj5QYXVsDQo=
