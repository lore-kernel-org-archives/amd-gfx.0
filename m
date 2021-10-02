Return-Path: <SRS0=D5He=OW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6297C433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Oct 2021 15:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DD761B00
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Oct 2021 15:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1DD761B00
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1DF6E84E;
	Sat,  2 Oct 2021 15:20:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831FB6E84E
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Oct 2021 15:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z35tBeg6iYvVaBJh3dnMZb8V8ecCQCQpwBars5En2CZA29c67wW3qscDMwBoAvyVexVMTFJ5zBFj8dJhftD5xzdmoIcz8zF+yEfzCV7VeBefRh2GtM1XvvKxOy5/NAo3AMQgtg0obK5LAV9Vl1ekMdjgM1o0dUMvjnVs3aGHY/qRnKY2bLj92eeN3bX4Y62Sib4FtSZMS0wGOZCwjIYDyO8MtZAxlYbccNjqDYBMA/FCwSGOTLslBief+wxeBwyEldihOR+en18E5Sccixa97ihEaxh56BQ2m+uxY0ZHlcac6lWDTWViEuWm1Lq/unvwvBzCVmZJ+iyrif5Cjsvxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahp5eMws+/IX9HRuNb8HzuTACV7EHe663siaNI30QuI=;
 b=jM7u2/g8EuNn2CCjnR5aHcg6imFSlZSHzMNWQSFmTlGLlT26mc9fAExDSTuB+pQw5eKu5fASGz34DsHV+/XIFqhFtUC0TI8UpIggF8K94HlbcLNlbkHEGViTj77bDfLw/cVvClmG/jts3VlQ9JmZRymLX0hgYaG6dIjj5rBwkQk25Vz8hvlRv4AxSQsxvnAoXlvbH+Jhp2eF0onw9SP84nWGY/oLqFxN03F2F9GqDWcRYhL7DXHB2sAwI6AWlmZophyYXPIx7xacUU4oFMM4DYOBCGzHAvgtciJCOMWPxwiaMmAgNzuzsyNSEa1LTG52wgwvAieWy7DXyFnNejrSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahp5eMws+/IX9HRuNb8HzuTACV7EHe663siaNI30QuI=;
 b=kELR1SZouh1S1Jr92h0TtGFFoYXA2tOehnAHsftb+nI4GnIt5y+lnOe4NchJ8vAcO8u/xJxzoBAnSsBPyPwpNwa4F8oXBC712EJl7JhvtNMUijyYSFJY50kvEsdLilOi/RtQ4S+32KInKU7SOv9yUuODFRH9O8ZjcsB1i+Dbqmc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Sat, 2 Oct 2021 15:20:18 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd0e:e376:6277:8109]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd0e:e376:6277:8109%6]) with mapi id 15.20.4566.022; Sat, 2 Oct 2021
 15:20:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Thread-Topic: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Thread-Index: AQHXtmgcFP6hLZvNJE64Efk6FSBEOKu9aU0AgABjvXCAAGdygIAADknggAGSMyA=
Date: Sat, 2 Oct 2021 15:20:17 +0000
Message-ID: <DM5PR12MB246998ECCF8122818696AF20F1AC9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211001020000.14501-1-guchun.chen@amd.com>
 <b7febaef-5442-1503-d743-24a6c50fa179@amd.com>
 <DM5PR12MB2469D34B746A0C1927906879F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <b45147f2-9ced-23f2-5020-2ff9aff1e12d@amd.com>
 <DM5PR12MB2469490BBE6ED3A83D542004F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469490BBE6ED3A83D542004F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-02T15:20:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8e7d453e-8c36-466a-a8a9-19f51563b0cd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32534a27-d951-4684-be5b-08d985b8245b
x-ms-traffictypediagnostic: DM5PR12MB1449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1449AABE009E81DABB4AEFEEF1AC9@DM5PR12MB1449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vt/Vui0rLlvnDkeqBhUTPhWeFOSuEG4kGLf/XF1JKOdV7HLnHy435eACOIOEvItP36RS+bcnhBBBkalHrt7cniP0x0eB0vAWmv8Roj8hCual/pZqe8PlOV769S8bnNvdi8pTJjBKExkLOMeolA7WrQ7PbOmizzY4kbKVH2gkL2k+jS27tiYu7x87VjnmgCYQGiMKv5vyM1u0Mf6pswE2rojiJ2ZCXPeVDhqequbcCJVv5IxxehnzsITIQt1C7jrmWQ+7dwMZzUQA8/3LdULPYmzffrJhdSnZknSo/h6kl8KPETxfzrNzGJ5rdMxeyrxLwC0texvtKRaD9qc9j+y2FoNkFTHC0XHR+XZ90aZyU3MnH+RmM6mfxxF7fVDI43IL2LRDYyLMBZjzIdUTxwDBCp8czFAdnHJ4wVD1/78DLGF747aiyLvgmBIe/ZiIMwjLT7EeGqpEuW8o2agviV4zwo9HRQXkuR7E8flggcNWsSG5GY1+XprvSa3Lf9GVvmuZ6oSTGCWK4VYy/QioBsz8yXjSVd8ELtXUHrLjWemC5u9fIFnKk5DL3Y9wVLeyAkSqNDYDatz/j/nYXzNfkjMG5VfasTY+CUdAgCIGQ6AT0xjS4+/OJBc4P6m310GcAPirDFQOoso0W0b28kFYxtpGbYj/bReTWCX6kCU95xzKdg9NaWRdreD+C+bfI5FhgwOzNih2XLaviukQRCL2LmNygw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(38100700002)(7696005)(9686003)(6506007)(508600001)(110136005)(76116006)(53546011)(8676002)(86362001)(66946007)(66446008)(66476007)(66556008)(64756008)(38070700005)(71200400001)(52536014)(8936002)(122000001)(5660300002)(33656002)(83380400001)(2906002)(26005)(186003)(316002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1ZmY25ORkR0N3N3T2VJb1huWmlrYUZ1by9XRXppejQ2MEt0TnJKS3orcFlx?=
 =?utf-8?B?OWhRZ0FVZ3ZNc1JmbVhza2lOblZtbnZ0ZW5HQ040TmFoOW84eXZzOVluQlJv?=
 =?utf-8?B?YVF1Z2x0MWFQdlFOd0tYTy9pOC8rRmRlTVVSOHRHREN6OUhMenc4ZDFLQUZI?=
 =?utf-8?B?cDlLOXo4czhCay9zWVVjU2N3elJLNU9ZMnU0elNPaGhTWTVwV1RnRzFPL2Jj?=
 =?utf-8?B?L0hYTE45MExRZys4UStnUy9jSHR1YTJIUndNT2pLV2RjZnNoKzBsV25lYmcw?=
 =?utf-8?B?VWRNQ0tyclp0dzFKOWpzQ0hDd211dVhJZ0dEZjdpTGEyQjYyUklhVnRsRW5X?=
 =?utf-8?B?TlUwS0dvZ3lKNmJ2UkRheTZ4N1RqZ3FIQU52NVY2WG1SdC9FTWNaUks1cldq?=
 =?utf-8?B?bk8yb2RQYmVmWGVXSUhaYXBWSVZCZ1VuU3dEc1lKMVl5REpFRmNWZVZJS2pv?=
 =?utf-8?B?Qm5ZajFycjh0SEdJRUNTMG1xT0tDU1hjSU9kNHdxSXkzdjNVajluS2Ewdk1Z?=
 =?utf-8?B?N2JpUE1iME16K3ZsL0FjcGhmNHZpem1uUHUyNXVJWmUxem9MOEZ5TnhiWnpp?=
 =?utf-8?B?WFM0dEY0U2d2SVRLdFNjR1hyNXBXNFNObEh4VUs3ODB2aGVrS3VKb3pkbTZT?=
 =?utf-8?B?bSszM3RqQmVhazZRUzg0WlZCNVIxYjh5RGxDbUhWZHh1SmZLTmxtVGMwOHdu?=
 =?utf-8?B?WWtqZzIzWUJrd3JDQ3JDMjRXZ2h3NlNTZnMrc0s4cm5CUC8xeEpXeE5XVHZy?=
 =?utf-8?B?SlM5MmpvcHlxWXZvdTR2YUw1dkw5WHV2RGpNNW00QlNMZjhPUWdXaGpKaDNY?=
 =?utf-8?B?ci9oQVpHa0V4N293aGFvRzJSZWZKNTVTZzd2RzJwYndTUCtRdGlOQUp5aWIw?=
 =?utf-8?B?RUNGWlExUC9WbjBVM1hPd1lDeUFsR0xLK0pHdE9QbHJYL21kUVBYSjJqWmhV?=
 =?utf-8?B?N2FONDRGckhtS0lsMGxYc1RBL3ZRdWJodEhpN3VLRHRUTCtiZmVvTUNoNTVC?=
 =?utf-8?B?NVJWK25zQ3J6QjBtNHJoanBmYy9iR3BLRmUyVDFqeDBUc29haFh5bUVjUHZV?=
 =?utf-8?B?TWxwTkdjTm9RSnFBcmtoVStSc0w0ZWdKVzR1RFZSSkNESFdqZ0FhYTVPVFRu?=
 =?utf-8?B?alpaUEZCUUdZaldOeFFTRU81RGQ3R1pxQnUvdUtNSFlEbkVqT245NDNCRzlQ?=
 =?utf-8?B?N3A0UEFMTzZ5WmM4U2dyNFhjZFJyMGhFWG4xUVh0TmxBeVphVjBiejRqU3Rm?=
 =?utf-8?B?OXRvS214c2pmUGovUHRQVmNaOHpQUVljZzFoc1d5QzI3RXF5TmtvN0laZ3F4?=
 =?utf-8?B?ZERaUURwNDVLMDh0VFpLVmUwVTBvdDd2OXNMRkptaXFNbzBsZW0xSzZRdkth?=
 =?utf-8?B?ekpEcjFkZXByaHNXb1NnVGw2aWhrUklxKzZnUVRtNk1EUUN4YkxjSHJaSnlo?=
 =?utf-8?B?MmFQbkNpaTl4VTI2elUxanhIMTdnckdhb0JWT3BSUUhSN2JWMDRCVG9yYmxP?=
 =?utf-8?B?NE84cmRibjIwdmlKcG9GNXBSbHdRZnpUTHRYczRrRXhzMnI4SkpNY3Q1UUpU?=
 =?utf-8?B?K0JGNkU5RXJZZldzbWdrdEJoQUo0M1V6Nk1OKzNSeEpxS21PTC94UW11bWEy?=
 =?utf-8?B?b3hhSEVjeFFNZ1hzclZjRXFIMlFEMSsxYU0rRFVSRUhtN1FRZzlNM28xZ2VQ?=
 =?utf-8?B?T3pVTFR4eWtSeU9PdWhIUjNWRU94aitjeTE5OTF2ODFRdmM1Y292eXJFSEV3?=
 =?utf-8?Q?STeU4ebBqzbpqfg394=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32534a27-d951-4684-be5b-08d985b8245b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 15:20:17.8105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XewXUG4joY4yHnLcIemV7fx7zU0MkP8Jr8wx+XTFq08fdKT2De0xmKuT3KLAw9+Hny+QnNKlDE/ESufjfvcqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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

W1B1YmxpY10NCg0KSGkgQW5kcmV5LA0KDQpBIG5ldyBwYXRjaCB3aXRoIHN1YmplY3QgImRybS9h
bWRncHU6IGhhbmRsZSB0aGUgY2FzZSBvZiBwY2lfY2hhbm5lbF9pb19mcm96ZW4gb25seSBpbiBh
bWRncHVfcGNpX3Jlc3VtZSIgaGFzIGJlZW4gc2VudCwgcGxzIHJldmlldyBpdC4gVGhhbmtzLg0K
DQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBD
aGVuLCBHdWNodW4gDQpTZW50OiBGcmlkYXksIE9jdG9iZXIgMSwgMjAyMSAxMToyMSBQTQ0KVG86
IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hd
IGRybS9hbWRncHU6IGFkZCBtaXNzZWQgd3JpdGUgbG9jayBmb3IgcGNpIGRldGVjdGVkIHN0YXRl
IHBjaV9jaGFubmVsX2lvX25vcm1hbA0KDQpbUHVibGljXQ0KDQpHb3QgeW91ciBwb2ludC4gV2ls
bCBzZW5kIGEgbmV3IHBhdGNoIHRvIGFkZHJlc3MgdGhpcy4NCg0KUmVnYXJkcywNCkd1Y2h1bg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3JvZHpvdnNreSwgQW5kcmV5IDxB
bmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBPY3RvYmVyIDEsIDIwMjEg
MTA6MjkgUE0NClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBhZGQgbWlzc2VkIHdyaXRlIGxvY2sgZm9yIHBjaSBkZXRlY3RlZCBzdGF0
ZSBwY2lfY2hhbm5lbF9pb19ub3JtYWwNCg0KTm8sIHNjaGVkdWxlciByZXN0YXJ0IGFuZCBkZXZp
Y2UgdW5sb2NrIG11c3QgdGFrZSBwbGFjZSBpbmFtZGdwdV9wY2lfcmVzdW1lIChzZWUgc3RydWN0
IHBjaV9lcnJvcl9oYW5kbGVycyBmb3IgdGhlIHZhcmlvdXMgc3RhdGVzIG9mIFBDSSByZWNvdmVy
eSkuIFNvIGp1c3QgYWRkIGEgZmxhZyAocHJvYmFibHkgaW4gYW1kZ3B1X2RldmljZSkgc28gd2Ug
Y2FuIHJlbWVtYmVyIHdoYXQgcGNpX2NoYW5uZWxfc3RhdGVfdCB3ZSBjYW1lIGZyb20gKHVuZm9y
dHVuYXRlbHkgaXQncyBub3QgcGFzc2VkIHRvIHVzIGluwqAgYW1kZ3B1X3BjaV9yZXN1bWUpIGFu
ZCB1bmxlc3MgaXQncyBzZXQgZG9uJ3QgZG8gYW55dGhpbmcgaW4gYW1kZ3B1X3BjaV9yZXN1bWUu
DQoNCkFuZHJleQ0KDQpPbiAyMDIxLTEwLTAxIDQ6MjEgYS5tLiwgQ2hlbiwgR3VjaHVuIHdyb3Rl
Og0KPiBbUHVibGljXQ0KPg0KPiBIaSBBbmRyZXksDQo+DQo+IERvIHlvdSBtZWFuIHRvIG1vdmUg
dGhlIGNvZGUgb2YgZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMgYW5kIGRybV9zY2hlZF9zdGFydCBp
biBhbWRncHVfcGNpX3Jlc3VtZSB0byBhbWRncHVfcGNpX2Vycm9yX2RldGVjdGVkLCB1bmRlciB0
aGUgY2FzZSBwY2lfY2hhbm5lbF9pb19mcm96ZW4/DQo+IFRoZW4gbGVhdmUgYW1kZ3B1X3BjaV9y
ZXN1bWUgYXMgYSBudWxsIGZ1bmN0aW9uLCBhbmQgaW4gdGhpcyB3YXksIHdlIGNhbiBkcm9wIHRo
ZSBhY3F1aXJlL2xvY2sgd3JpdGUgbG9jayBmb3IgY2FzZSBvZiBwY2lfY2hhbm5lbF9pb19ub3Jt
YWwgYXMgd2VsbD8NCj4NCj4gUmVnYXJkcywNCj4gR3VjaHVuDQo+DQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zz
a3lAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDEsIDIwMjEgMTA6MjIgQU0NCj4g
VG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyANCj4gS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT47IFBhbiwgWGluaHVpIA0KPiA8WGluaHVpLlBhbkBhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBhZGQgbWlzc2VkIHdyaXRlIGxvY2sgZm9yIHBjaSANCj4gZGV0ZWN0ZWQg
c3RhdGUgcGNpX2NoYW5uZWxfaW9fbm9ybWFsDQo+DQo+IE9uIDIwMjEtMDktMzAgMTA6MDAgcC5t
LiwgR3VjaHVuIENoZW4gd3JvdGU6DQo+DQo+PiBXaGVuIGEgUENJIGVycm9yIHN0YXRlIHBjaV9j
aGFubmVsX2lvX25vcm1hbCBpcyBkZXRlY3RkLCBpdCB3aWxsIA0KPj4gcmVwb3J0IFBDSV9FUlNf
UkVTVUxUX0NBTl9SRUNPVkVSIHN0YXR1cyB0byBQQ0kgZHJpdmVyLCBhbmQgUENJIA0KPj4gZHJp
dmVyIHdpbGwgY29udGludWUgdGhlIGV4ZWN1dGlvbiBvZiBQQ0kgcmVzdW1lIGNhbGxiYWNrIA0K
Pj4gcmVwb3J0X3Jlc3VtZSBieSBwY2lfd2Fsa19icmlkZ2UsIGFuZCB0aGUgY2FsbGJhY2sgd2ls
bCBnbyBpbnRvIA0KPj4gYW1kZ3B1X3BjaV9yZXN1bWUgZmluYWxseSwgd2hlcmUgd3JpdGUgbG9j
ayBpcyByZWxlYXNkIA0KPj4gdW5jb25kaXRpb25hbGx5IHdpdGhvdXQgYWNxdWlyaW5nIHN1Y2gg
bG9jay4NCj4NCj4gR29vZCBjYXRjaCBidXQsIHRoZSBpc3N1ZSBpcyBldmVuIHdpZGVyIGluIHNj
b3BlLCB3aGF0IGFib3V0IGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzIGFuZCBkcm1fc2NoZWRfc3Rh
cnQgY2FsbGVkIHdpdGhvdXQgYmVpbmcgc3RvcHBlZCBiZWZvcmUgPyBCZXR0ZXIgdG8gcHV0IHRo
ZSBlbnRpcmUgc2NvcGUgb2YgY29kZSBpbiB0aGlzIGZ1bmN0aW9uIHVuZGVyIGZsYWcgdGhhdCBz
ZXQgb25seSBpbiBwY2lfY2hhbm5lbF9pb19mcm96ZW4uIEFzIGZhciBhcyBpIHJlbWVtYmVyIHdl
IGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgaW4gY2FzZSBvZiBwY2lfY2hhbm5lbF9pb19ub3Jt
YWwuDQo+DQo+IEFuZHJleQ0KPg0KPg0KPj4gRml4ZXM6IGM5YTZiODJmNDVlMigiZHJtL2FtZGdw
dTogSW1wbGVtZW50IERQQyByZWNvdmVyeSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hl
biA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMSArDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPj4gaW5kZXggYmI1YWQyYjZjYTEzLi4xMmY4MjJkNTFkZTIgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gQEAgLTUz
NzAsNiArNTM3MCw3IEBAIHBjaV9lcnNfcmVzdWx0X3QgDQo+PiBhbWRncHVfcGNpX2Vycm9yX2Rl
dGVjdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwY2lfY2hhbm5lbF9zdGENCj4+ICAgIA0KPj4g
ICAgCXN3aXRjaCAoc3RhdGUpIHsNCj4+ICAgIAljYXNlIHBjaV9jaGFubmVsX2lvX25vcm1hbDoN
Cj4+ICsJCWFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KGFkZXYsIE5VTEwpOw0KPj4gICAgCQlyZXR1
cm4gUENJX0VSU19SRVNVTFRfQ0FOX1JFQ09WRVI7DQo+PiAgICAJLyogRmF0YWwgZXJyb3IsIHBy
ZXBhcmUgZm9yIHNsb3QgcmVzZXQgKi8NCj4+ICAgIAljYXNlIHBjaV9jaGFubmVsX2lvX2Zyb3pl
bjoNCg==
