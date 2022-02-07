Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A624BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 13:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2161B10F68A;
	Mon,  7 Feb 2022 13:01:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8585C10F68A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 13:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHlLXnbTEaM/es2HFMh8PD4+pdyLjOImovzx171TNLHcqDxetofBGZHRi/EsQFlig/RCH7DMZS27tJm6XO0GishvAUkvIUkYFpeSRQshKqGGQWKV+zZNmxKXu8jtMM802lNSnYcVhSk3dA+1xzCSKkY4VuncjeUImYuSfXYJW+b70zjaCyfDM2OvkpoxlLz3yluk0sIJZ0ScAg3oMZbgvwFiF/uWGspauLi/JTkDCY0fzfiU/zJdIGzVz6cS6mNqE1cr9zmd3ZjAqbS0PxwxvBJ24TdJ+W/WfadqMehqzPyTwHdhYgvuco1syX0DiDjBLPpL1cZWGog/ZOQV1i/m4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPEWhdjufn6kfUVXdeDr/xVtQuGpvKBYgKB7sq0c+U0=;
 b=OTHdlx7h1ICDoO9yOyIElPMFBoLFN7JxQqD7nVUJ+IrnfoVfbsZsTFPhmdouR8nfM4QdvSwAufT43COr280ZOPRk2jxUKNvWxgIrs4VBCrtU8LEzljAeEdjpkbA2jx4agzhjCQCX+gXNLdLGwfNvHSMgTeD9U8X1mTTAKz7lTSCCZiaj+qInqvCBOUHv6VC3RJ3uI+NLrYHNIi8JytsHyZwDbM5NJVlKutR4K/2Qn38ga3SDNM2Amm8rhWzrAfV1aNBOu7y9goM3ENRnaxWJm/NW/AWLElBuUM36HKbnb5kXJwb6yFmGjKB7A9KHxYlvxqP2tQKhLEFK9xJuAW/7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPEWhdjufn6kfUVXdeDr/xVtQuGpvKBYgKB7sq0c+U0=;
 b=m5HoWjyxnIfIshpFNbntDcG3cJiIBTJJlocYTqHmDIm2br7K8w3CUqKzaLMWc6k64AuredJuWyTQ8Iw/ADru2xiQ9rCEVTsO4mkVsQfxpClVWf/Umx6Ge076Rnpw3FXIoKH8RqQpr7FNGk23BtYl6J/7MtlKLa3O2H5EKpTK8io=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW2PR12MB2553.namprd12.prod.outlook.com (2603:10b6:907:9::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Mon, 7 Feb 2022 13:01:01 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 13:01:01 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Vega20
Thread-Topic: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Vega20
Thread-Index: AQHYDuJcz35TlKp2sUSkzZugij9h4KxynmOAgBWI3IA=
Date: Mon, 7 Feb 2022 13:01:00 +0000
Message-ID: <DM5PR12MB2469C8132EB95A22A8091EB8F12C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220121161648.14729-1-jinhuieric.huang@amd.com>
 <CADnq5_MpZS7z7tjRXzXmGv7Dq6+O96a=89JY1TQ15=b7+bziKg@mail.gmail.com>
In-Reply-To: <CADnq5_MpZS7z7tjRXzXmGv7Dq6+O96a=89JY1TQ15=b7+bziKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-07T12:59:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2e8071b1-a9e4-4a5e-a986-30655f2ca8d1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-07T13:00:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: deeff2d5-393a-44e8-97e4-074855a17da9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd462275-a70d-4230-88a3-08d9ea39e414
x-ms-traffictypediagnostic: MW2PR12MB2553:EE_
x-microsoft-antispam-prvs: <MW2PR12MB255364C913D05CA743ECDE00F12C9@MW2PR12MB2553.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:285;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9iLvTF3At9yInagbu+GdQoBlq95RocX8LvAqZVGgdJFsuauwdZppJwFcVHv+ncPIBn0ephf/i2aSI8vs0GWOwrpcdzZqB/LjDS1Vig4et36JFvokHx5dXazLinFyVH0AMSK3DVJE5xJl2mP9TAFY2EQW5d2eeLKy/s4zhfyok0sOpuHChRciB0JbBRHlK+nBDUEJSx7NodySwZTNVjbYdYKE7dnYP4sViL97JvFgjWqvI6Ffl81Br3i7Lnq9+9xp0I/H8TZrXdtPqBOMNZS9up/Wafg0XWljiRBozqTl6NETxTYek2Gd+ERvbdcDyhc3SzseKAlx7J/W5mdPgMx05AZTm2ojs27D4KAYLFYxD6qTIb6m6I3rlc51wunbyL2h1yd2++5OpMDgiV4zQZ9M9T1iTYAz/CYbMwlE/BLkuKWe2WhXudYhc0V4TQ58Wb+QwhvOQnuEXY0Vg9k4sgrp7H8YbEa3CH+iTbGzw3ZF2WipeFoBtWP39ac6mpPOYcJmLtMCFBRa29sBA1UxdSO1t6E3igh6riO/7+elEKc9ruwA97UCZcCm5hCTcnB+aHZ00brZWdw/NX6DBD2AXhPnfQa/iDplvjZA+3iffIBynCOuxpiD2IktUvYx9hNDjBwaHbQMmIK3oQKseqJXFhZDunMZEV/BFJinbI+WduDuUNzW2U3S6zmx6Os+FZcFJb4QUUob4oculjjYi7Iy5sVHxzJ39xHR0crCIWeCpqVsbY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(38070700005)(2906002)(5660300002)(26005)(316002)(6636002)(110136005)(53546011)(66476007)(8936002)(66556008)(66446008)(64756008)(4326008)(8676002)(6506007)(7696005)(9686003)(66946007)(86362001)(52536014)(76116006)(71200400001)(83380400001)(55016003)(33656002)(122000001)(508600001)(38100700002)(16393002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xFR08weGhlYkNvRnQxdThqa2haMk9nVGFmMThTbU9TQmx0NzFBR2JuOTN3?=
 =?utf-8?B?akxIQnRMa21WaHBhSE1TUURhSXR3dTlPTjkzL2taQ2pCODA2V010YmhVUmZD?=
 =?utf-8?B?WUl2UUxBTmlJcm55eDd1alVvZStoc0g2RzljSm9HdWlZenFCWGdhNzQyRTEr?=
 =?utf-8?B?ZUw4TWFaUnlaYVN0SzFjZ3BScDJmcGNZVmMvWEZ2cHovc2E3U1dYOGU2Q2xW?=
 =?utf-8?B?TFdCNk5KenNlMERoSndFZ0g1bmxhUHFzaElVRXlOTDdOQnQwU2Z2RzdVQVFF?=
 =?utf-8?B?bFpQQmxUUi9uN0JZdEVNeVNkOWRxUTBYVitGYlpORHI3WTgyQS9HNS92Und3?=
 =?utf-8?B?RXMxeHRraU1USFJraGE2c2F4VFBaNlJESmNSQ2wxNnpWOXk0MnovTzF3NDZu?=
 =?utf-8?B?K3VHSVVBRVRNSk5ZQ3RjSEpNL0tYcmE2VGdMcEg2RGVCMXE3UUdtdDgxcm9u?=
 =?utf-8?B?aUNpa3ZoUGdLQzZSeFBUN3k5SndjWWtWTXhyMzdaZkg4aEFWcFlJSFgzSUFl?=
 =?utf-8?B?U1QwM3VxZ3IyWkZLcEgyTko4T1VpN21XaTVrQVFEbWtkcTQ0dHZMWllYQXFV?=
 =?utf-8?B?WW52QWMyYllVNUpnT09haldrQjZTemFhTS92c1Fwd24vVFFMOWhSL1c2OVhS?=
 =?utf-8?B?T2QrT2pCK1lzV2JtS2ErNXdvcitFdmVHWk9iVVlaKzVZbVQ2ZEh4VGsrcDEz?=
 =?utf-8?B?ekIydFF3YnpyQmhrMFdoUDNmc1loTFErU3BKdTAreDJVTGhBYVZjMjhNL25O?=
 =?utf-8?B?VmtBOStybmRDSTA3c044SU1wbmhXWHpML0p5aE16a1FIdlZacTdCazM1S2R5?=
 =?utf-8?B?RHIwMXNDaDkxaFkvUE9sdXFDZE9pUGc2MFlzeGEwNHMvOWthdmhTcHhvdUpI?=
 =?utf-8?B?UmUza0I0d3hSVnE0RlZKM1Vtd0V6Vk40T0l4WTZ6NytFMElidkd5NHdoWWgv?=
 =?utf-8?B?YmtvcG9TRTNINmZraTZQRTF2Y0VvUlJVOVJ4SEc3Smh5RTQwemxjZXZBc2tF?=
 =?utf-8?B?QTlvblJlV29qcUZtM0hxbGVIUTJpNkkxdTdyMWowVFFycGF3c1I3dm8yQlI5?=
 =?utf-8?B?ZU5rRFdHQ3lWZ1hJcVlDcjhjZkZFU29rRjgzbmw5eERxRmJ6ZFpCWmZ2aHJT?=
 =?utf-8?B?SU9MTWpxNDB4SmZnbWZaQTVQU3BqK09NL0pJcS9UVUNvWnVOUlVlZjBjclZl?=
 =?utf-8?B?UkRUaHJkdlZzR0hlN0hjOFJ1QVJhZkFEV0JzOG9WNURuSTVxNzVVa3YwdlFH?=
 =?utf-8?B?Z1VUV2NjTjRzOGphenI4ZDBJaVlnRk1oU2NxZ0hqOVhrSGZNZXhUZk5TVnU4?=
 =?utf-8?B?a1V6OHQ5OGJLM2hnOFRNM205Tm5KTTlPR1VXUDF4dXdPMTNGQ20vUmtsejAz?=
 =?utf-8?B?WUlKcCsvME1pQ1AwSjJpampqODNSV2pIMXNsQitEd0o4ekNDWmJ6bWYzNFJl?=
 =?utf-8?B?U3B2RUtaSmRNblFDSVlNVEdDNjBiTTBVQkxRZ1FYWm9XUiszVWhxemlmc0pD?=
 =?utf-8?B?N2tBOFZMcitnSHlXZ0Iwa0QxeVNYZmJGbkNob3dsTG5seWM3ZE0vK2pwSVNP?=
 =?utf-8?B?aXQ3b0ZxQURBUjZDem1iTExQTDRCK0ZlVmhaQ214ZXJRVGtQNkFMNVVPa3dx?=
 =?utf-8?B?NWZmemZRZmxzQXF2bXNyRGF4dUNCRXlqR242azdBSzFyc0ZXTFREK1NvN29y?=
 =?utf-8?B?ZFFMcDJDWjlPK1pOR0VXVGhZRGFFQTBmbkh0RU5hTWJrWnlkdVpLNzFndDdM?=
 =?utf-8?B?bHo0L1BuOHd3cW1KZ1IvUUkzclJDWC82TFZQQno1YkhlVzl0eVhwYy9ZQUlO?=
 =?utf-8?B?cWdOWTdqcHZkMk1LbGxTQTFXa0VTQVo3S3ZmZGhQUzYyc2ZPNm9KU1FXUHI5?=
 =?utf-8?B?dnJQMHV4akJhZ1NYRVU3TEJPbjl4MWJTTHpGNzBobTFUSTBNdEFjSUd0bzI3?=
 =?utf-8?B?Y0lzVkJDSE9CK2FEaG9keWdBVUI5bjFIdk9Bc3ZyY3MrRWRvUlNmeVVwLzNU?=
 =?utf-8?B?REprRUpEOUQ5aTlELzV6VlZBdFJZVEpkZkN6dktRL1NpcUpwMjdtYm5RMmlp?=
 =?utf-8?B?SWpKSlVOaWZrKzNyZVBCMnQyWnovUmdwOWZRQWk2ZEdzbVNza1lFNHgyOXpZ?=
 =?utf-8?B?ZHZNdzIrVytJSmRna1hHUGVpOWh3Tzd0d2dTZ0p0YUJUcFZQc2h0UDc2NDBX?=
 =?utf-8?Q?3PFXMeypdGPSLrIeBG1qdMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd462275-a70d-4230-88a3-08d9ea39e414
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 13:01:00.8816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjaPYocugTamklNbb7FjVjl6gr4hnPOmAAj1sOl6eMCSNu8ofzLczv6LPdoHz47meLTwOrprB17FrgwrfosHfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2553
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGkgRXJpYywNCg0KQXJlIHlvdSBzdXJlIHRoYXQgdGhlcmUgaXMgbm8gRlcg
cmVxdWlyZW1lbnQgZm9yIHRoaXMgcGF0Y2ggb24gVmVnYTIwPyBLRkRNZW1vcnkgdGVzdCBmYWls
ZWQgYnkgdGhpcyBjb21taXQuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IFR1ZXNkYXksIEphbnVh
cnkgMjUsIDIwMjIgNDowOCBBTQ0KVG86IEh1YW5nLCBKaW5IdWlFcmljIDxKaW5IdWlFcmljLkh1
YW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGVuYWJsZSBoZWF2eS13ZWln
aHQgVExCIGZsdXNoIG9uIFZlZ2EyMA0KDQpPbiBGcmksIEphbiAyMSwgMjAyMiBhdCAxMToxNyBB
TSBFcmljIEh1YW5nIDxqaW5odWllcmljLmh1YW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBJdCBp
cyB0byBtZWV0IHRoZSByZXF1aXJlbWVudCBmb3IgbWVtb3J5IGFsbG9jYXRpb24gb3B0aW1pemF0
aW9uIG9uIA0KPiBNSTUwLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5odWll
cmljLmh1YW5nQGFtZC5jb20+DQoNCkFzc3VtaW5nIHRoZXJlIGlzIG5vIGZpcm13YXJlIHZlcnNp
b24gcmVxdWlyZW1lbnQsIHRoZSBwYXRjaCBpczoNCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NoYXJkZXYuYw0KPiBpbmRleCA1YjhhZTA3OTVjMGEuLmQ3MDhmMWE1MDJjZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+IEBAIC0xNTgy
LDcgKzE1ODIsOCBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF9mcmVlX21lbW9yeV9vZl9ncHUoc3Ry
dWN0IA0KPiBmaWxlICpmaWxlcCwgIHN0YXRpYyBib29sIGtmZF9mbHVzaF90bGJfYWZ0ZXJfdW5t
YXAoc3RydWN0IGtmZF9kZXYgKmRldikgew0KPiAgICAgICAgIHJldHVybiBLRkRfR0NfVkVSU0lP
TihkZXYpID09IElQX1ZFUlNJT04oOSwgNCwgMikgfHwNCj4gICAgICAgICAgICAgICAgKEtGRF9H
Q19WRVJTSU9OKGRldikgPT0gSVBfVkVSU0lPTig5LCA0LCAxKSAmJg0KPiAtICAgICAgICAgICAg
ICAgZGV2LT5hZGV2LT5zZG1hLmluc3RhbmNlWzBdLmZ3X3ZlcnNpb24gPj0gMTgpOw0KPiArICAg
ICAgICAgICAgICAgZGV2LT5hZGV2LT5zZG1hLmluc3RhbmNlWzBdLmZ3X3ZlcnNpb24gPj0gMTgp
IHx8DQo+ICsgICAgICAgICAgICAgICBLRkRfR0NfVkVSU0lPTihkZXYpID09IElQX1ZFUlNJT04o
OSwgNCwgMCk7DQo+ICB9DQo+DQo+ICBzdGF0aWMgaW50IGtmZF9pb2N0bF9tYXBfbWVtb3J5X3Rv
X2dwdShzdHJ1Y3QgZmlsZSAqZmlsZXAsDQo+IC0tDQo+IDIuMjUuMQ0KPg0K
