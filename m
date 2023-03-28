Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83485C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 06:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F7410E7ED;
	Tue, 28 Mar 2023 06:07:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D2710E7ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 06:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkdVUIfbwKf27wWq05UBaidvOVe78m92APWUZl+k/VXXbuNxuup8Gq2N+zdZ1omCqS6ATIJveHeugoM4txOtI7XcNwi6L0xyjGoGErskwTD7Z04R6ej/sRw83C1HFF+s2oeQsHNm/kMoWF7BvfBdhISoGRq/2FdEAB/z0tL6cn2OEwiToYU8op36LMNBBQnW9Fn4zv8hyROoP+/PpvNK4woSD3VwTjmvqXgUwRyCieVVX4bXMV9InPZuZgLbCLTsrC0LzuLmK1hSDu0CcADwjzXN7ktE0pyvHsgrnMfz0NuoKWd5I3Ump5JOdTfhjqvWlXqjRJOEyK8qoMruM7UrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZu+dcBJI8D0wJf/NV9WRYh4/PW+QUNfaKMwZ6kzCJo=;
 b=gmqZAfIEuy9CnhWmB8E4+FBDfwIP5cl6vIPU6IzdahE2HV4iXtgOWMI2BiHI9iYsoVQHawu2AA2lSzpa80pVa0cL7IgOP6htZom6PO/FpQTvQk9JMxkZAgEeFp/hrc2VkUIZgfzkZPwG6bM2enrYopqRaXYWpMkaP/hOwkcdwFDOHf/w/H5HGIyQN5T1NqjaFXb5jMLy03CznqUoB7stz8J3a36m3IKPa1Bt0ASoaT4L1QlC1s1sj+XsTpKDZXi6h4Y3GO5tNGCvG9TZF9PzOX2rPMZxDIFtUZ6yCBEXhMZ2uDtt6FBmwnSrgxmy5epKIuFAsTgt66wHhfXMAG6pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZu+dcBJI8D0wJf/NV9WRYh4/PW+QUNfaKMwZ6kzCJo=;
 b=T67llIeyUgBSRqeGfY2pEYfzmQpRlJELUcMARA8jjksvjr2/QFZEkKrThXMERrYJ7ShDxMPBSE6B9WrBdSDuh5fcYyroa7YhVfo6HLl8LF2T29zpYXd/b8ikZnIG4NEsODHo0TG9NODQGy7WbKGyfte6fnIvV3J+NGCPhhw5MBw=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 06:07:41 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 06:07:41 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Thread-Topic: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Thread-Index: AQHZXdCRiq1WHho1wE6x8W+3r8tG5a8N79AwgAC/yACAAQsOoA==
Date: Tue, 28 Mar 2023 06:07:41 +0000
Message-ID: <DM6PR12MB35312CF3EAB7E9CF6092665FFD889@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <a75662b0-7e5b-16d9-735d-11b00a385a58@igalia.com>
 <DM6PR12MB353134DD69F58F5C9D3FFA8DFD8B9@DM6PR12MB3531.namprd12.prod.outlook.com>
 <49ef6b76-6e49-d7ee-377b-0cb700f5da71@igalia.com>
In-Reply-To: <49ef6b76-6e49-d7ee-377b-0cb700f5da71@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-28T06:07:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1b031475-cfed-49bc-a94d-de076a571ed9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|MW4PR12MB5627:EE_
x-ms-office365-filtering-correlation-id: 42867956-3ec2-42af-b1a3-08db2f52bd34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjYGQpp15pNmRQ2HTCoMdoCVVUhNXdE9bVcqHAjKx3AitfljeYe5ww7c2qfoMTnSr9G3f7iH/7MAx8jqvbeRKPuj2MaxlCLHVbf2o8aDnRAeCMEMCkGeva9XRmkUxeTQWz3GaBxNHi7mIxajvb664d29YdmsxQ4VawugrVBf0KMV1I2YaVqc9sPb+oCPyF3ApOi3ZacYa0BmsAJFAMBilwynhPyFw5wYnd+3JFxPF4WorUZjQgPTpgiZskiFKF6qTzx27r9TfmeqQ+Wf+2nsVusovDhyf9pzYTLhrV7BH0Nmf6E6gigWbQ/A+FU1NlTpW9keGm7qJ0DDguTt3XI6vaTuVwD4JuzVuDykCmiUWLJOrCGaKoSb9MDQAljqR2iae3VUqFKxk2nGasKpFvFonHwKheHxaKgLjrirzcg42LacKU0pSCuRcmPBbDwH8SClUeQLHy5rhtg5ZdkuELvIfmXrwYO8HlXYCGCi8wFHGrMCwzVQ6AniVwxnpw7GVNDHlSLXSIk/0JQxX+SHL3Oa4Odt7JAfmev8UAubiH34mpBbXRf1jznpnXzcZwwUb0CuDall5hFPcVTzCKpPcLuvVbc3GOCcOe/8KURx1mBt1mE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(83380400001)(8676002)(66946007)(66556008)(64756008)(2906002)(4326008)(66476007)(7696005)(966005)(478600001)(76116006)(71200400001)(54906003)(316002)(186003)(9686003)(110136005)(26005)(38070700005)(55016003)(53546011)(6506007)(15650500001)(66446008)(86362001)(52536014)(41300700001)(8936002)(122000001)(33656002)(5660300002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTRoSXU3KzJDYURQcUtUU1pvVDBwMjY2SkM3ZWtiWFZURC94ZjNuV0RuQ2lV?=
 =?utf-8?B?S3p5N1RoWHFWSGtuQm03Z1Q3M21JblNTcDlWVDU5WmNOOXRJYXNoZWlQYmZt?=
 =?utf-8?B?NGZZNkdHZjRVZXJYTnZjUE5qdE9VV2JhdzZqcmZZeEpuMFZtZzhNNjZkNlBC?=
 =?utf-8?B?d0FwL1ZTeXdvQnBucENKME1zSzUvVEJDcS9XZWl3UW90TTdrR3ZkdXRlcmRs?=
 =?utf-8?B?THVyeCs2Yi8zV0JJZ0pBeGR5anh3NmN1TXgraTJZejg4S0VBWkFJTXhybmR0?=
 =?utf-8?B?K2Z3R1o5cFV5aE9nbnJFVjJWSlJtM2s3bkpkZzdmMmpuOFI2aUpXVEJuKzY1?=
 =?utf-8?B?VHJRS0xQMlkyZEhFUlViRDJHN3A3Mk1MSXNWNHJRbWExOWxabjN3U2x2K3VG?=
 =?utf-8?B?UStIeit3K1FJWVE0TnNueW9WS1Z1K3lnNnJxcGFScDdwUW1sa3JqMGprOUgx?=
 =?utf-8?B?SWZZTmVKRW1iRVNpS0NrRlIwSDh3c2ZWZUdWTW5uVFJhbkFOMndYcGg3K3lj?=
 =?utf-8?B?Vk9yU0JMaXRMQ09ncDBMTTE3cllJaTZWY1FKQkJueHJzdUhMa2RybHMxQ3cw?=
 =?utf-8?B?b2thS1Rud25vZitqOEJ1MEhJeGQrNDRNeG0ydVZJMUNDWm5EemlLeVFYOUo0?=
 =?utf-8?B?NkMwZmxGMDBjbWdoNGJPUm5jK0lyUDFFR2l2U3YyMG1tTE85ejJKWktSditp?=
 =?utf-8?B?QitqWWlxMmlpcVVGSVBtYlVnekdqeHJEaXhHc09laHJFSmRsNmdiUUJRbUFO?=
 =?utf-8?B?dkwzMFlPOWZ3b3I1VXhYR1BHcHh1UnJ3L1FUWjNVQlF0NGVOYzNMckdCWi9a?=
 =?utf-8?B?dkxHeFZHVEZVeDI2b0hab29KS2tkdko3ZCtTL2hEOWo3YUk2QWNTUXFzY2lK?=
 =?utf-8?B?UmllbVVXbkkrcVpUbmtIQWgzQTEydXhrWllBd3E0cmd3SXBPUXRqNHU3V01s?=
 =?utf-8?B?NWxVNUJKb2xpWmh1aWRDSW11YkJlcERTUkw3U1R3cUZCL2xpM0pvbSsvckxl?=
 =?utf-8?B?bEhxM0laSC9lemY4RDI2UUhmLzRGRlBjaVRVcm1XMkxXWGwrcFB5MHlDTWZU?=
 =?utf-8?B?NUJVaTJWQ2NaODl0akF4dlJkMmw2cW1IdE1NRjRiZ0RvNU5iUDlvcm9Fak0v?=
 =?utf-8?B?SSs0V3FNaTA1Qi9MNitHZWRCeHkrNTBOQ2FDaFc1SVV2dnBCUFFGRDJVMFFu?=
 =?utf-8?B?VmtmdFNUSUdUM05CSkJ0aURReXR2Y2M0dEFybVYyS2xHK0RYSnNtdW9yU3pN?=
 =?utf-8?B?bFBZbVZ5RGx2MXU0UCt4b1BMelFueTRjKzdIWDJ3NXJWRGpPM3lmcm9TTDVs?=
 =?utf-8?B?WFFPbFRzMkFpV2lWYVVyY25uMUo0bWdIejhoWDZqMmFGSkxUUy9BTGduc3Fl?=
 =?utf-8?B?QVBCaXhocnphbkZySnJDeDNtUUZiN3RsM3YvTXVnTlF5cFJOUFZGNm4wcFo0?=
 =?utf-8?B?amZhUEZJZW1BOWtFK1hqNFBTcWdOVk53L05aNm1vdlZ2OXI1ZjFQcjhTRzhW?=
 =?utf-8?B?Z3VXWEF0V1F3YU5sNEM5c0VyT3g1NHZnWEg2b3lrbVAwellVbUV6T2Y3akUy?=
 =?utf-8?B?Z1lkUGtzdHQ2Tll3KzBLOXpaWFFBdFo4MmJOWXpTdXpoM0g5Z1gwOXFhd2VQ?=
 =?utf-8?B?Nk54dWRnVWIxR2JSY0crTmNLL0pHd3FENG5GbWJ1cGtQRm10cEZPN0N2b3p2?=
 =?utf-8?B?UXJlWWFWU3llbEtzYURzSW03SmhOYUVJQ0dGRXd1cWpIdXRORmlHY0FXcU10?=
 =?utf-8?B?RXBTL21hTE11MHdBWGJVMFM4dG80WmlnTlo3Z3NJQUpkMWFNRGNja1dtRW5K?=
 =?utf-8?B?eHN4ODg1dUhBcE9NSU5Hc00yTTNpcHRsbGM2UVYrdE1OWWZtd3hvZkxaOWYv?=
 =?utf-8?B?bktxeHdJYnhxcC9VNVQxR1RMSWNUTTZrU3RVQlM1WFlWRDdBeU5ydS9BbHo1?=
 =?utf-8?B?NVBtdEJ0YS8ydjFpaHE3WmdGR0ZwQ3B6YTJnSmNwdUVGdGdKcEZxQWNQMDBF?=
 =?utf-8?B?VVc1MGRnbys3QjFCUVlrTlo2RDRPMEJNQUM5aFJubWR2T2lNVDFJdHFhbGpp?=
 =?utf-8?B?WGo3ZEhPQ2tEL2QrZ2hzdTMxc21aVi82cHFuUk9rTHE1alN0dVVTd3dYMVlG?=
 =?utf-8?Q?cQMI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42867956-3ec2-42af-b1a3-08db2f52bd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 06:07:41.0915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uektz8GPRUWJTr9CEgpcjBsTypjxhv60Gw7kvR3YHNmSwoBjwE75s6AQschEo6d8xA7wqcTbRb0wd/Sn8XuaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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
Cc: "Li, Ying" <YING.LI@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBpZ2Fs
aWEuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI3LCAyMDIzIDEwOjA5IFBNDQo+IFRvOiBZ
YW5nLCBXZW5Zb3UgPFdlbllvdS5ZYW5nQGFtZC5jb20+OyBhbWQtZ2Z4IGxpc3QgPGFtZC0NCj4g
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgTGl1LCBL
dW4NCj4gPEt1bi5MaXUyQGFtZC5jb20+OyBMaWFuZywgUmljaGFyZCBxaSA8UmljaGFyZHFpLkxp
YW5nQGFtZC5jb20+OyBZdWFuLA0KPiBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgTGksIFlp
bmcgPFlJTkcuTElAYW1kLmNvbT47IExpbW9uY2llbGxvLA0KPiBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT47IGtlcm5lbC1kZXZAaWdhbGlhLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1Jl
c2VuZCBQQVRDSCB2MSAwLzNdIHNlbmQgbWVzc2FnZSB0byBwbWZ3IHdoZW4gU01UIGNoYW5nZXMN
Cj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwg
U291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBj
bGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+IA0KPiBPbiAyNi8wMy8yMDIzIDIz
OjQ5LCBZYW5nLCBXZW5Zb3Ugd3JvdGU6DQo+ID4gSGkgR3VpbGhlcm1lLA0KPiA+DQo+ID4gVGhh
bmsgeW91IGZvciB5b3VyIGF0dGVudGlvbiBvbiB0aGUgcGF0Y2ggc2V0Lg0KPiA+IFRoZSBwdXJw
b3NlIG9mIHRoZSBwYXRjaCBzZXQgaXMgdG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ugd2hlbiBw
bGF5aW5nIHRoZQ0KPiBnYW1lLg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IFdlbnlvdQ0K
PiANCj4gSGkgV2VueW91LCB0aGFuayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uIGFuZCBmb3Ig
dGhlIGludGVyZXN0aW5nIHBhdGNoIHNldCENCj4gDQo+IFNvLCBqdXN0IHNvIEkgY2FuIHVuZGVy
c3RhbmQ6IGlzIGl0IGV4cGVjdGVkIHRoYXQgZ2FtZXJzIGRpc2FibGUgU01UPyBJIGhlYXJkDQo+
IHNvbWUgZ2FtZXMgZ290IHRoZWlyIHBlcmZvcm1hbmNlIGltcHJvdmVkLCBidXQgbm90IHN1cmUg
dGhlIHJlYXNvbi4uLmlmIHlvdQ0KPiBoYXZlIHRob3VnaHRzIG9uIHRoYXQsIEknbSBwcmV0dHkg
aW50ZXJlc3RlZCENCkhpIEd1aWxoZXJtZSwNCg0KTm8sIGl0IG5vdC4gSXQgaXMgbm90IHRvIGRp
c2FibGUgU01ULg0KDQpZZXMsIHRoZXJlIGlzIGEgY29tbWl0IHRvIGdldCBwZXJmb3JtYW5jZSBp
bXByb3ZlZC4NCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvYThmYjQw
OTY2ZjE5ZmY4MTUyMGQ5Y2NmOGY3ZTJiOTUyMDEzNjhiOA0KDQpCZXN0IFJlZ2FyZHMsDQpXZW55
b3UNCg0KDQoNCj4gDQo+IENoZWVycywNCj4gDQo+IA0KPiBHdWlsaGVybWUNCg==
