Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 12:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1DA222F9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 12:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1DA222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F186E096;
	Mon, 11 Jan 2021 12:26:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1656E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 12:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXpTi2uWtscSbNqSGlMYnN5k04eioRgPExBQgizzjlfDKCOltFNFdDNAmpeYFK1b4MDBk2pfRCgnvJY6SyN0pH4i4DWrCHuUfdLgy0eWOVg3VwPzUCruswXXaVRYkyze2VSlvS54xHCHJZM6pGgpM2ilsvwuyWCfpkXJ6cTJ/4a7CDQcqgEto5KCRHPwxrmTcRY+uI46Qzdy5EE865nMtZ+Wu5eY998J8Kba9KlyPacG6wm8Z4dVQZY/H7sdhelo0F7nJj/Qsm5PM9kwTpRGVmPx7PVp8x0uk+p8xtYbB5DJ6chhiLM1ULH0zJFhaJn5EALIzaBVPeTW0u39xBBrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6oDMuwzlcfW4HKElIevH5epmm1PAg8ysnBnIq+OY5w=;
 b=A5SI7+FtXNZY1MAVAQbPdDE7kTNaxbG/ZOvdo8DOA/n4fYokvcfeFndzUcH3sMKkiO+IUclnTaRnTfqGfw6+N4HLVy7g5iVQULKAX6Ws6y0roYxcTcYMA9rlpEFTTzS00sxzD332g7WHbiNAirqQ7BZdOeZdmBwuVXdVGaX7fWgHKp8GW28waQs1vC0OwQ7t8f+kDJ8R9NBh84FckkFveFJDrElFvpxl4GgXSJkziCfK27lod+xUqkfADbZBBD3VhkQdWtY0klGAkYiLdEMifE/C55n6VXVq3wPj1O29kh4AFat0emnFRklvSuE70h2cUHa34ISQ2jiRgLxZ4//WOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6oDMuwzlcfW4HKElIevH5epmm1PAg8ysnBnIq+OY5w=;
 b=S+2Pqlut8ivW/fqsSEaRIfUBjFg6IfmuBUFIgcRY1XekP1ZKq9FpsJN9BOJoHGlvhXCNC1l5S8Tav4nGjAGuslSflz4hgMkboX8z8iZVQbq19TwhycB0ZlJ5Jtyli3xL4YJ8khFYiGZQu91rnQAlB5odOhbG7CkzuiUgIhnygGk=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 12:26:07 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c%8]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 12:26:07 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
Thread-Index: AQHW5/8ewD03bTXH6kSCZqcdLA3KZqoiUfwAgAAFTMA=
Date: Mon, 11 Jan 2021 12:26:07 +0000
Message-ID: <BY5PR12MB4885C09A5D21C96E7A175753EAAB0@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210111094938.2764-1-Jiansong.Chen@amd.com>
 <ea359d1f-169a-7b93-94aa-8bcaf38cef39@molgen.mpg.de>
In-Reply-To: <ea359d1f-169a-7b93-94aa-8bcaf38cef39@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dfa76a8e-184a-4a3c-97d6-c3d729e569f4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-11T12:16:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00a6bcc3-2a2e-4feb-e3df-08d8b62c1232
x-ms-traffictypediagnostic: BYAPR12MB2839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28398A3981C1B959CB19AE3CEAAB0@BYAPR12MB2839.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6qCg0lsdw6dlJMTfMpBr0tlERHCpSbq7wGlf9gfTL8ej7RS7gyNaMBEhTjo4FEA4f/HENehCYc1ZjlFtRJmws1s5EwvNMU2BD0UediXTUqGoCs6QfcfqJlKYsQzLSNw7nfjwjnsptvmTikk992V4xXIiJSnaQY05bmIC6/QfgEAg2lmPzbPTrGdx6FyCljzDTG+lXcVWVElfzTAtnWcDHvQKrLFhY7gKBwpPHh0jv01R4doyrBf/inBpLQyIHqrjY+NKee8nMJPGpDnLcjOa+Lzgvj58e48XxT6FegeZVkxZ6IItPXCwRDzNlZgZDrIuHQWcjnbuADVmqIr2eYWkrl3/GHs5oSId0sqMdRWL9EYTobCbLOZCHkEaKrmznG9S8DxKRuRyhzWT4eQ2DP5PVZX6vRJJbWPK1FklhNrKXASS0xm79n5ggRQLIuGo9LOBrbbjwZss0DzkIBBy4ugnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(7696005)(4326008)(186003)(6916009)(26005)(966005)(478600001)(8936002)(55016002)(54906003)(316002)(2906002)(52536014)(8676002)(76116006)(5660300002)(53546011)(66446008)(66556008)(64756008)(33656002)(6506007)(9686003)(71200400001)(83380400001)(66946007)(4744005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aWZqZXVmRHRCRlJ5cU81VURqcUJCd1NONllmNDJEc1RqQ1BhRUVDb1VUWm9R?=
 =?utf-8?B?VlhOc1UxQmZjYytTTU5mS1lIdjRzUmtsUE5FNUZIeEVOUmhKLzMyMEJLTWtH?=
 =?utf-8?B?QmJuWTY4K3pqL0hBY2xjNWtvZDBGaTlldkpsaDUrdWxqSWZaQWtmc3FnYmJk?=
 =?utf-8?B?ckJRcGxHTFNLWXNJcjFrZmx1VHhZaWZhd0srWmdPdGVQVnpoV0tFYkVGYXFI?=
 =?utf-8?B?Y004ejVFODMwREx4TUdFUFU2czdXSEl0MlpCUk54S2l6ZGdUWEVtUjMwdDBL?=
 =?utf-8?B?OUhRS0cyNEhwb3dSK0txR3pjTWFzUFhiRXFITnEyRWtKMGYzeTFzaldLTHRJ?=
 =?utf-8?B?dE13c1lITkpEV3ZYWXRGNDJsVDVLMWM4dnNOZjYrdXhJdyt1ZVU5OGZQOUt0?=
 =?utf-8?B?cEZRUDZxM0JYZDlsVGpvVWpoTno1MFBmZDJ0U1pYaXNLY0RGSnhpZUxLYkxk?=
 =?utf-8?B?aFoxYklJSHFqL2RPRzRPaFNieTZVR0NYYnVjc0EyQS9pUHE3NnZ2TmtHa0to?=
 =?utf-8?B?aWxLNlF1N003aVpiSmQycDM5T1VaM0lsNHFiMDFXdG9ob1htVmwzU0dSaGpo?=
 =?utf-8?B?UTdPN1Q4cWw4cDRJdHFSdHI2VFlNNm5tSGxXNkJuaVZENFQ4ZzNLYzlqZU5u?=
 =?utf-8?B?OEd0ZVIyZXFaVDE4L1FQMnEwV1RRVVppUTlpbktLeGk4dE1jMk5wWTdEZjJQ?=
 =?utf-8?B?dUI5bnA4QXZDRXdaT1ZTbWZCdUxtTjdZQ20vSWRhYm5Fc2hOb29VZnFzUWZ3?=
 =?utf-8?B?bmF4UXl0REkzZ0kvY3hwb2NXWkwyeDBtSnlOYkladnhuZGJpcVhPalFCdGQw?=
 =?utf-8?B?WDEwNUFLeTF1b1BUWkRldmhPczJsTEJ4dTYwRWowK0JKWUsvakZFVjlmY1lY?=
 =?utf-8?B?d3pCSFFuVWRCL0JoZHBibFNxQ1VtYWpMWWtsRWNqNFlvMjhSb3lxU3RoVlVs?=
 =?utf-8?B?MnhsM1FZKzlDUFZQL0VJZVc1eEdQL0RPZ1d6ZGIzY2tzTVFHb01Wb0dyNkZV?=
 =?utf-8?B?M0w4NU9CM2FnM1F3Mkt3NXROQlNtc1FCdmVNZ2ppTjVoQWdNRmtiZm9tekxB?=
 =?utf-8?B?d3dHRDdBUmwyaEZ4ck50M2pQZytuU21Gam5rOXlxUndJUHFzb045SnF2YTN2?=
 =?utf-8?B?Tk9kYmY0bS9CcXhPRWx0UDI2dFhJb29UdGpNUm84cUpMYWt3aE8xb3l2Y1J6?=
 =?utf-8?B?SWs0RTlwbnFxaDBtRVlEY2ZidTdhaTVLdndRdXlBc1R3TEh0djFaN3E0bGU4?=
 =?utf-8?B?WDRwNEdiK2YvbGZWdGM2WVpuSGdIQ3kzMkxyRWZFRzR5bWRuaU9PVi9OOVNl?=
 =?utf-8?Q?9+qgKdYbDk9eo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a6bcc3-2a2e-4feb-e3df-08d8b62c1232
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 12:26:07.1891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4tY+WkJ+WsXt5iPciwRVl1k28g5RBafFHtZVpD14VQhuEKOdVbVYvnFV4ufmAjk98wZqBRNWcdzHurQfRj7Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBQYXVsLA0KV2UganVzdCBlbmFibGUgZ3B1IHJlY292ZXJ5IHdoZW4gdGhlIGZlYXR1cmUgaXMg
c3RhYmxlIGVub3VnaCBmb3IgbmF2eV9mbG91bmRlci4gIEFuZCB5b3UgY2FuIHVzZSBkZWJ1Z2Zz
IGludGVyZmFjZSB0byBwZXJmb3JtDQphIG1hbnVhbCBHUFUgcmVzZXQuIEhlcmUgaXMgbW9yZSBk
ZXRhaWwgaHR0cHM6Ly9naXRodWIuY29tL1JhZGVvbk9wZW5Db21wdXRlL1JPQ20vaXNzdWVzLzYx
Ni4gVGhhbmtzIQ0KDQpSZWdhcmRzLA0KSmlhbnNvbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDExLCAyMDIxIDc6NTggUE0NClRvOiBDaGVuLCBKaWFuc29uZyAoU2ltb24p
IDxKaWFuc29uZy5DaGVuQGFtZC5jb20+DQpDYzogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5j
b20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGVuYWJs
ZSBncHUgcmVjb3ZlcnkgZm9yIG5hdnlfZmxvdW5kZXINCg0KRGVhciBKaWFuc29uZywNCg0KDQpB
bSAxMS4wMS4yMSB1bSAxMDo0OSBzY2hyaWViIEppYW5zb25nIENoZW46DQo+IEVuYWJsZSBncHUg
cmVjb3ZlcnkgZm9yIG5hdnlfZmxvdW5kZXIgYnkgZGVmYXVsdCB0byB0cmlnZ2VyIHJlc2V0IG9u
Y2UNCj4gbmVlZGVkLg0KDQpb4oCmXQ0KDQpXaHkgd2FzIGl0IGRpc2FibGVkIGJlZm9yZT8gV2Vy
ZSBzb21lIGJ1Z3MgZml4ZWQsIHRoYXQgaXQgd29ya3Mgbm93Pw0KDQpIb3cgZGlkIHlvdSB0ZXN0
IHRoaXM/IElzIHRoZXJlIGEgY29tbWFuZCB0byDigJxjcmFzaOKAnCB0aGUgR1BVLCBzbyBpdCBj
YW4gYmUgcmVjb3ZlcmVkPw0KDQpQbGVhc2UgZXh0ZW5kIHRoZSBjb21taXQgbWVzc2FnZSBhY2Nv
cmRpbmdseS4NCg0KDQpLaW5kIHJlZ2FyZHMsDQoNClBhdWwNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
