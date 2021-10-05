Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D20DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 11:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE160611CC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 11:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE160611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625626E3E3;
	Tue,  5 Oct 2021 11:43:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A93C6E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 11:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goOyiGjsaflxoXfWz1ZnBtczKXYcStt6LcOZIDMWItJKupMQJnUXmiaDmZT/Tnhw23w4RlsdWr8aD0ftDTLwGgF6yXvBVDFyX+K+pHrLs/b1fz1wiUT1ahso8I4fOO4rnOP9w6/l1w1Myu4DtBZslQYU2m96pq97g2xbmNts8gcnmjUP0dmAkGUTlrDyI2vjF2UFyCytQbPCPUMi8nUb7zD02NiOeuPxVDC7zi8FNh3HlYAsx+qACNqcGtFUsGTC4v85WF4L9tIIfqoKNPFPj5QXpWErL2b3NsI2CS3lTjAv3+326nUK+rQ974UUzgMKIzJriqfvmD/Wozvfyx1uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaWLU94tKuOBSJjVUjcK+GhETQCX3y52Yz83eAkTOwE=;
 b=dpo/XHzX9gd/k08jPhDDdJRU9Cy3MuZIhO5EwFBHFWUZZza7Dv4m8gZDAZofcle1wBbp+mIoIF+QNo55HWY2zb9vCUtEq3Soq4MW/CaKPFIAZ1zezMQNyG1EaEGhgfHsQ7WwSq7jmfrFmitQIbuzWrS8vPy1+ev6kGi5S8N4BmYDi8s4bwWblRmgiIRYTaVjg0tL9m6hNDdLWJV8xXuzQUvSFPMWEWv8yLLpFB3ZDnjcdPlunu2jnJ9Y0fRzEcnZNJfmUUx3anF3ljwOiolUwEaw27lwvgwsCIGb1D6+XZObOqjbwvIlNMxal0FAa/8y7raHCQqTyheqj4+gH+MOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaWLU94tKuOBSJjVUjcK+GhETQCX3y52Yz83eAkTOwE=;
 b=KMHoHwkL/SjjFgxfWaL+feSOLYaiWndTZKUL6NUIc3fvx+434cM026r2KJQB4OXnqX5DTYH+9z0f/8dA6LYqI5Jrl5NmVo5jI3aTpcRes8/TJjq7ywZGny1Eoty8M1MmzRouhqXSVso6Q4+rAj1om4LlSY+dMC6IDPlwDr4CMGY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Tue, 5 Oct 2021 11:43:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 11:43:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: handle the case of pci_channel_io_frozen only
 in amdgpu_pci_resume
Thread-Topic: [PATCH] drm/amdgpu: handle the case of pci_channel_io_frozen
 only in amdgpu_pci_resume
Thread-Index: AQHXt6C9Yevx7zJ+F0y62HUbXWKIZKvDA60AgAFJJqA=
Date: Tue, 5 Oct 2021 11:43:00 +0000
Message-ID: <DM5PR12MB2469CAE133E0CCFB09F19F2AF1AF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211002151802.11872-1-guchun.chen@amd.com>
 <7a2fadb8-8576-14ab-2bfa-ba880f0f241f@amd.com>
In-Reply-To: <7a2fadb8-8576-14ab-2bfa-ba880f0f241f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-05T11:42:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a70cd26e-2660-4ddc-9a6c-0bff52006c6f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 435f7ab1-fe07-4b92-2c0a-08d987f54885
x-ms-traffictypediagnostic: DM6PR12MB3690:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3690CCA283B70FA13D77758BF1AF9@DM6PR12MB3690.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4KYlPjqKT2W+PiKLjQ8sF7rmghv8B7LuTSQ2JSJnILtNonNqFZbTqy7qx69M3ERDP/NXBDsdpUym6Q63MdyZPBcwPlW85vNlymFeHVHGNRGL7Ro4zUtiq4QZ1L7fC2lRfG43IW8xg0SkljJmmy31fSp9ntyN5j79Iy2NYn6S6Wm1AgUEksxPEpP3EFXIqaiOdLmaFtK4ln9+/2K0456TB8vYYPC32d0kCdE6H4YSxZWmeJFRfImZWsW8l0pfhAngVC+ATF9mY9jY6E9T1n7AqCyGOTACxKzM5GyPn7quGsILT9yxwRV6XQldX0tq2LwNYc4wEufjTYjUaDBTqMd88tneT0TPqLB6exAJO8o+UfS6ZdE/+41h2yPEQYy69vrLml60I4g6SttwNmgtlKA47cLRi2CV8Cz9gir09HoqZjnJIhvBIMUv4QceeWD9LKebiem9Va+MTSGD7lO+kQJ+D0Edfm+vn6sz/NJIZqS3db6cuV2G1TvHmc8Q+3fG0LTCJFvgeHV2TIIzNdOOEJR/8xWA2BwFq4unm7JJ4B8H/R2M2WcpoVXmPGx1dPcMl63j8VYlsbppAMzhkkG7+iFtzrixl5+jRzNal50VqVA49w4qDRHDTJL3NPIhrqUO3WNTuAZgqooCjaeh0ZkqZTxgQP4ZmjB8+kqsQwAu5ZMWKT2aXoPblbtcNWTbS6QAZQpyN6afc6IQ+cgVq2OEFvw/Wybn4C4F4Rp+aVlJc9EfqQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(5660300002)(9686003)(8676002)(122000001)(38100700002)(6636002)(8936002)(7696005)(83380400001)(508600001)(55016002)(26005)(316002)(2906002)(38070700005)(71200400001)(52536014)(53546011)(6506007)(66946007)(66476007)(76116006)(921005)(186003)(86362001)(64756008)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRpZDA3cTI5OWF0MjFUVytXZ3Rrb3RNengzWlB2NDY5Q1pJYUZyVFNSNUxB?=
 =?utf-8?B?K0p4UWQ5UWlBSUZseThwdit4VWVjRlVJa1YzQnpweFh0TUN2aGtpZXhRUWt3?=
 =?utf-8?B?Uncxb2hkRkdZaFNPanFnYU93cXlXNENoWEw2R0VEcXFZODBsRkoxOC9Rb0ow?=
 =?utf-8?B?QWFGTDMwMFhTenZrWGNBOG1acjBmNDZKTSs0NllQMURBSzgwUWNyK1dXRDVp?=
 =?utf-8?B?R01rM3VsSGRXUXEzclVhTXpaZ0ttVTRaZkNqU01UWmY3TWhBR3NOR1lQUTl4?=
 =?utf-8?B?NjM2VE5rS1o3TVlxL1E2Vlh1YlhDWlNuNVZlYW1ZNVdydXZKeGpDcUZuRGl3?=
 =?utf-8?B?cWRaRno2WFdPYXBYYitXRVB6V0ZBa29YWllNcmpTUHZUaEI0aEFTckRJNHBD?=
 =?utf-8?B?NXBNSndrcjhPcS9pY0pnQWRSekxHa09EZjgwWDd4bVhHaEpxK2thdzZKMGZs?=
 =?utf-8?B?VEFkK25UQ0lUWUF2M1J6UTZISlZUOUZvdzdzSFNLUkJBZmdsMkpPRTN4a1h0?=
 =?utf-8?B?aDlMdlBwU1kwOTBMWG1nUzViMWdIZzNzOEVwZXhaSS9QYTNrNExhaURRMlRo?=
 =?utf-8?B?dU14WDFoQ0Vyb0dNQkd6VEZBMUZ4aENYNGswbmNpZ3oyemEvOElPQlBPZGpP?=
 =?utf-8?B?dVN3eHBKQkVmWDhCZGlRZ1p3bTBuaFZMa09aT2NOSEJld29YU2NxZzRFdFlY?=
 =?utf-8?B?SldCTitHQm1xam5tVXdhWVpMRXpVMzJRa2cwQnFqakw3U1hWWDNDTWxWL3dC?=
 =?utf-8?B?NHlpVlZEelRWeDdDeDdlZ1JBV3ZVTlUzTUtVYTMvNnJ1TU54a1hKZVcwdG1M?=
 =?utf-8?B?a2RJQkhLOWVPcHBybHZ6cG9IUVlPVDBaZDBMNGF1NlIrckc5R0ozLytGY1dL?=
 =?utf-8?B?QjNtcmVscUVWYjNKV1RyT1ZhSGJyUnR2ZFJLRFUrbFJGd09YZkpBZ0RiNU9q?=
 =?utf-8?B?dC8rcE96MFBUUXgycXlWRzVtUDNWeElPTndGMWVkSmlFMm1SREttQ3RwWTdI?=
 =?utf-8?B?dGVZRjR5d2QvZ0wrNHpMU0hMWU1lakhkS0wyREtIN1RSVzJNejlSRVh1Y0k5?=
 =?utf-8?B?RytBZmVKUlFoMGF4TVdzdGZNS1B3MnkxRm85dy9UVGNsOUNuYlVtaWlxU3JO?=
 =?utf-8?B?MEpRVnVrbGJIT3R0aHk2SHJnZ29NRXlTOGpFY0xKTGNzb3UySm05OFJKT3E2?=
 =?utf-8?B?dzhybkx1NkIvM3lTQ1VKWTFkTjg5L21iVzIraUJndXpVK0tUakJkRGoyaDIx?=
 =?utf-8?B?blB3N2lmaXRyMnc4YVdYWWNtOTlNUW5TQjB6ZTNEclRXbEZtT0lKaC9sTm1a?=
 =?utf-8?B?RG1tT1Z2bVBydjJZOGxDZVJ6MExGcEtnNWVDcC9TM2ZaWDlodDI4Sk9MMEMx?=
 =?utf-8?B?M1k3Z3ZYQ3AzV3BsamNObm95UUdPODR1TjkzeXZHL2xnTlNXN2N0YUZ2RzBK?=
 =?utf-8?B?R3ozTyszRkQrTURlNDVYdlQ5L28wZ1hJUHFVd1ZwZWZzZk9qUGZKcHFuUEdi?=
 =?utf-8?B?bHZqRlpvUnk3OFpyVG1rZytZN20wWVlSb3JWTW43ckx4T3BHVDR3cXNYcU92?=
 =?utf-8?B?dnZ4UzArQ0cvUjkzcVpObHQ4cTNnUkp2THFKbzNsaDg2RG9aWWsxS2UxaG82?=
 =?utf-8?B?Q3A0MGVwd2FCRHV4YjJCUE1TK2szN2ZHS2J0b0pBd09nQzVFZy9sNng1emZO?=
 =?utf-8?B?QkVkVDZ6S1VUV1B4WUExd0RpYjhWN1dyTTVUTTg0ak9UMnRVUmZEN2VsY2c4?=
 =?utf-8?Q?hmG1kCHTBkHLmYikpN0L3A8HVRIQIyvuZdEAalm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435f7ab1-fe07-4b92-2c0a-08d987f54885
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 11:43:00.1161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTtU6kfi3Pv/eY3/pgjTRhHdh1UW5DpidYDBJEhJvsDsJViMz2f7cOIywmvSIbuL6PIQSXyMd9YTrM24DBInfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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

W1B1YmxpY10NCg0KVGhhbmtzIEFuZHJleSwgSSB3aWxsIHVwZGF0ZSB0aGUgbmFtZSB0byBiZSAi
IHBjaV9jaGFubmVsX3N0YXRlICIgd2hlbiBzdWJtaXR0aW5nLg0KDQpSZWdhcmRzLA0KR3VjaHVu
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHcm9kem92c2t5LCBBbmRyZXkg
PEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+IA0KU2VudDogVHVlc2RheSwgT2N0b2JlciA1LCAy
MDIxIDEyOjA0IEFNDQpUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGl1LCBNb25rIDxNb25r
LkxpdUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogaGFuZGxlIHRo
ZSBjYXNlIG9mIHBjaV9jaGFubmVsX2lvX2Zyb3plbiBvbmx5IGluIGFtZGdwdV9wY2lfcmVzdW1l
DQoNCg0KT24gMjAyMS0xMC0wMiAxMToxOCBhLm0uLCBHdWNodW4gQ2hlbiB3cm90ZToNCj4gSW4g
Y3VycmVudCBjb2RlLCB3aGVuIGEgUENJIGVycm9yIHN0YXRlIHBjaV9jaGFubmVsX2lvX25vcm1h
bCBpcyANCj4gZGV0ZWN0ZCwgaXQgd2lsbCByZXBvcnQgUENJX0VSU19SRVNVTFRfQ0FOX1JFQ09W
RVIgc3RhdHVzIHRvIFBDSSANCj4gZHJpdmVyLCBhbmQgUENJIGRyaXZlciB3aWxsIGNvbnRpbnVl
IHRoZSBleGVjdXRpb24gb2YgUENJIHJlc3VtZSANCj4gY2FsbGJhY2sgcmVwb3J0X3Jlc3VtZSBi
eSBwY2lfd2Fsa19icmlkZ2UsIGFuZCB0aGUgY2FsbGJhY2sgd2lsbCBnbyANCj4gaW50byBhbWRn
cHVfcGNpX3Jlc3VtZSBmaW5hbGx5LCB3aGVyZSB3cml0ZSBsb2NrIGlzIHJlbGVhc2QgDQo+IHVu
Y29uZGl0aW9uYWxseSB3aXRob3V0IGFjcXVpcmluZyBzdWNoIGxvY2sgZmlyc3QuIEluIHRoaXMg
Y2FzZSwgYSANCj4gZGVhZGxvY2sgd2lsbCBoYXBwZW4gd2hlbiBvdGhlciB0aHJlYWRzIHN0YXJ0
IHRvIGFjcXVpcmUgdGhlIHJlYWQgbG9jay4NCj4NCj4gVG8gZml4IHRoaXMsIGFkZCBhIG1lbWJl
ciBpbiBhbWRncHVfZGV2aWNlIHN0cnVjdXRyZSB0byBjYWNoZSANCj4gcGNpX2NoYW5uZWxfc3Rh
dGUsIGFuZCBvbmx5IGNvbnRpbnVlIHRoZSBleGVjdXRpb24gaW4gDQo+IGFtZGdwdV9wY2lfcmVz
dW1lIHdoZW4gaXQncyBwY2lfY2hhbm5lbF9pb19mcm96ZW4uDQo+DQo+IEZpeGVzOiBjOWE2Yjgy
ZjQ1ZTIoImRybS9hbWRncHU6IEltcGxlbWVudCBEUEMgcmVjb3ZlcnkiKQ0KPiBTdWdnZXN0ZWQt
Ynk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgIHwgMSArDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNiArKysrKysNCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1LmgNCj4gaW5kZXggZjRiY2ViMjYyNGZiLi43MjBkMGNjZWNmZTAgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IEBAIC0xMDk0LDYgKzEwOTQsNyBA
QCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7DQo+ICAgDQo+ICAgCWJvb2wgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbm9faHdfYWNjZXNzOw0KPiAgIAlzdHJ1Y3QgcGNpX3NhdmVkX3N0YXRlICAg
ICAgICAgICpwY2lfc3RhdGU7DQo+ICsJcGNpX2NoYW5uZWxfc3RhdGVfdAkJY2FjaGVkX3N0YXRl
Ow0KDQoNCkkgd291bGQgZ2l2ZSBhIG1vcmUgZGVzY3JpcHRpdmUgbmFtZSB0byB0aGlzIChlLmcu
IHBjaV9jaGFubmVsX3N0YXRlKSBPdGhlciB0aGVuIHRoYXQgUmV2aWV3ZWQtYnk6IEFuZHJleSBH
cm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KDQpBbmRyZXkNCg0KDQo+ICAg
DQo+ICAgCXN0cnVjdCBhbWRncHVfcmVzZXRfY29udHJvbCAgICAgKnJlc2V0X2NudGw7DQo+ICAg
CXVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgaXBfdmVyc2lvbnNbSFdfSURfTUFYXVtI
V0lQX01BWF9JTlNUQU5DRV07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQo+IGluZGV4IGJiNWFkMmI2Y2ExMy4uMWFhZWI0YjMwZWRjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC01MzY4
LDYgKzUzNjgsOCBAQCBwY2lfZXJzX3Jlc3VsdF90IGFtZGdwdV9wY2lfZXJyb3JfZGV0ZWN0ZWQo
c3RydWN0IHBjaV9kZXYgKnBkZXYsIHBjaV9jaGFubmVsX3N0YQ0KPiAgIAkJcmV0dXJuIFBDSV9F
UlNfUkVTVUxUX0RJU0NPTk5FQ1Q7DQo+ICAgCX0NCj4gICANCj4gKwlhZGV2LT5jYWNoZWRfc3Rh
dGUgPSBzdGF0ZTsNCj4gKw0KPiAgIAlzd2l0Y2ggKHN0YXRlKSB7DQo+ICAgCWNhc2UgcGNpX2No
YW5uZWxfaW9fbm9ybWFsOg0KPiAgIAkJcmV0dXJuIFBDSV9FUlNfUkVTVUxUX0NBTl9SRUNPVkVS
OyBAQCAtNTUxMCw2ICs1NTEyLDEwIEBAIHZvaWQgDQo+IGFtZGdwdV9wY2lfcmVzdW1lKHN0cnVj
dCBwY2lfZGV2ICpwZGV2KQ0KPiAgIA0KPiAgIAlEUk1fSU5GTygiUENJIGVycm9yOiByZXN1bWUg
Y2FsbGJhY2shIVxuIik7DQo+ICAgDQo+ICsJLyogT25seSBjb250aW51ZSBleGVjdXRpb24gZm9y
IHRoZSBjYXNlIG9mIHBjaV9jaGFubmVsX2lvX2Zyb3plbiAqLw0KPiArCWlmIChhZGV2LT5jYWNo
ZWRfc3RhdGUgIT0gcGNpX2NoYW5uZWxfaW9fZnJvemVuKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4g
ICAJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsraSkgew0KPiAgIAkJc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07DQo+ICAgDQo=
