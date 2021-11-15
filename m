Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEFEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 07:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C8461AAB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 07:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30C8461AAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03A46E43F;
	Mon, 15 Nov 2021 07:48:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C576E43A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 07:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWuT/quzIv/apwPpcbkwoPWZg0cVnlNqsCdaj/qUdQN/e0R5U4nkp9+PYz5kNS6hIMbRU3j3UbcxdarOdLPaua8Dxtg5ME3Dg1xuHvtUTE1/0DlrQfmkmBm4fCXCOP+wVrpJN6de+TaBeWTT0CXKbZ8wCwxVoNaaOogPE99V2fdRXSF9iKck69eCUtJ7RAu9/bxtuCDR2sAtQX0PzS/hCNzMmJcDwdEnd7X3osF7rKqUKlJGcvXXZTIAbACQdhZE7SPfVLKApGwatT386IkEyLtuLl6jvXvp20lCuBGv0UUJhfhvt8rrOdv4t3wBQvZHdfzeasr8tEQ5bJ6hk/Fgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3JCppQ/XacnqJNTjggLN8aFn+ijvACloTjovdE2HqI=;
 b=UfLn/X3pUyPNsFNfCC+sxWIupZZbqIj0URVtt0Uhl1PdQTIp/nT6P57JUkJ29BBEdNz6ogmXbo2A8UJg5yc0UZwbpWiBvgurUDioHaQ1iTJ7k8zx6mC94dxqhomsAVjdUKShorwHCyVc79coOj0UFNBjFZtVAdwmC4DeoLqCwBHK+5Zhra857+8rdeDxWQCUI3Ag7hCh6Ywoc9iL+sCUcrQOUEo+XVwP0li+p/R4F044fRWNXiw8HMGCel4EbVQpAegmnOWiZLWcHCtl1RdoibFG8sr5Nl3P2Pi7sahNvl+guyok96iy5n62p8yW7d+qGnd86oAgFoR+HgLPMdko+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3JCppQ/XacnqJNTjggLN8aFn+ijvACloTjovdE2HqI=;
 b=E0mS7MK6bMyZw/spFlHG4r4HF2NOWS+3F26MGmERWxYGYOJCydmaWioIh6MPYMWx/Nx+qGRAohHywD8sw+ClWfYoQADPjqbfODFszUBpQ0UXMyI89Mwet+Xpk+CEsL53WSbXs6eiYsr+SKG96qbpAFtb5Ia+LUKrbfffPxyGtyw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25; Mon, 15 Nov 2021 07:48:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 07:48:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Topic: [PATCH V3] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Index: AQHX2cvC474hYHKYfkG0Zf1Z94ThmKwEAH2AgAA1M0A=
Date: Mon, 15 Nov 2021 07:48:14 +0000
Message-ID: <DM6PR12MB2619E03AC2A6F2682497CD43E4989@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211115025137.639014-1-evan.quan@amd.com>
 <69ae10e6-bacb-3ce1-fb18-46a60be451db@amd.com>
In-Reply-To: <69ae10e6-bacb-3ce1-fb18-46a60be451db@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T07:48:10Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dd8ea44c-0267-4693-8a99-8cadc10f942b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dff741a4-27c8-4375-bd45-08d9a80c4792
x-ms-traffictypediagnostic: DM5PR12MB4680:
x-microsoft-antispam-prvs: <DM5PR12MB46807714DF5844CB29B4A726E4989@DM5PR12MB4680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:118;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7auiLVxCLnAOidq+VcxQr2j99d59Ms9BdarV/TiEBx6adCQdfnMhtd2dIgQTvBeCGDexASoCA6tijiJRG/MJDuz8Muit5NvIBMQiWu9FusnGVbIhKnXbNc6PQRFmwFQbZkb8BPAFkoFqt1gW/WxDGQbChexMgkzdjRmRP8VRbJLG4+hEbg1BdfTVDX6iI5m6oMymYQHdZcFOxnVLmYBoBbnwow5QQUFbXAHMw7oQLGfHAnjl7vb1hnXVCrM3fQdeY31GCriGbS+whPYvhayeXz3Ow6ONzoSpXp/mnPcb7W7KkqHT6/1MUoPCebVZ5XDwug/Q8fR/3jUf9LPdJVUDwG+azYuEF/iqcieb61/hnmqTw0visytd5mw/h4QMocllLtOsZPb8VD3tNjZENWjiDtO97FlUU+n7kqPLKFJ6EWuamCH88jH8G5FAg8FGqwC3+Kn//gTQDUBKe76G7lwug4RcTAVz8uAgSqM8YzLwOjDyAS3oTfftuKW9ccUM4mRRxOZkoGyk/b4XhaY/B5MnUhgTF50XVidoEjTs/J6GM4v2t5jsoBRW5R3bDR+KRfzJA6LYm5VNd3U0Mnu5xVbnbROO6ICcQqpH+M3UXXV73e7oMfBYbT49N+u3d+481GonxRH/s7OmlG7Ee676WXGZlcQih4E9/RYvJ423YD6KoaphVusfFxhtYsRj4WiodyhjGiVXGPAfZTpRmPO8YF0lLX3vcepVrt7dTx1yO7Avd+/DLqTBZmHBIQQRI9ce0SGTCiczV3KXHmj1BrcjkkGKNOORf1gwSDtih7wd6JWlH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(52536014)(26005)(86362001)(122000001)(38100700002)(83380400001)(38070700005)(4326008)(71200400001)(2906002)(54906003)(7696005)(110136005)(316002)(55016002)(508600001)(66476007)(64756008)(66446008)(6506007)(5660300002)(9686003)(53546011)(186003)(66556008)(76116006)(8936002)(966005)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmo4eTZFYlpEK0pOM2o2bGNhOEdjZDZ6RnIxVURhVkdmY1pJdnlTKzFKb3FR?=
 =?utf-8?B?SElYS292bFk4alpra3JGRVZNQ1VsT2tEZDBjWC9abk5OVXU0RWVpSDV6ZFhF?=
 =?utf-8?B?dGVNeFVRd3VIWXora3dIWlpJQjRHZWljY0NOc1BaS0lDL0VyWXlnbnVsNzg1?=
 =?utf-8?B?eUQ4WXpvcUw3aFFncWp1Zks1SDlVOEFPeGk4NVJ6OFYyeTkyUG5PNTZUTzFx?=
 =?utf-8?B?RWs4cUc2UmRRV0UxeXRld0JmUE95Zi83aGF2OG1hczE3ck4xeXBtc3FMZ3BF?=
 =?utf-8?B?ZEpwK2pBK1RqMDVKMjZhMVNDaHJBOWdqaW9jTUVzclZ3K1FWVEx3TjRxQ0Zh?=
 =?utf-8?B?a3JKaTZUVnFoMmhpV1JKYzEvL3lnOUpBYlRNT2xPYTNoSE1qeENYT3c2T0hD?=
 =?utf-8?B?YTY1bnJCRXZ2cWZaWUcwUWFpR0o3QXh6d3FSd1VGcWRtcE0wS2gyb051NStl?=
 =?utf-8?B?VTVxWnRYNWM5bmh2WjJDZDVQWkpJY1dkeW5rNWtnWVY5SFAzQWthbkVJb2M1?=
 =?utf-8?B?SkFDV2hGYnB6OWorczZtOHVvbWtiWFo0MFRFdU5XeUlMQ3A5TzZWZFhPMHkz?=
 =?utf-8?B?cnU0NHNnL0ZNb1NzZFJxME5vTnFESmZxN3FuRitZTkFPNlZGekNab0syVWQ2?=
 =?utf-8?B?Rm16d0xSZ1RBUEs4d0ZYeU85OTYySEYzSjkwYmNSc0lhYktpclJJRmlxVUxW?=
 =?utf-8?B?VWRkYjJZK0ttdDNjUmNHdUEzRFJXV1UxMEdyY2t5VVJQNmsvaitYN2VTK0pL?=
 =?utf-8?B?RVJ6OCtDYzQrd0hWS3FUZVY0TnVpK3FUbEp4bCtwWGovekwzUGxZOVh5WEl2?=
 =?utf-8?B?RGVUR0NTMXErQ2pURU5menBQV1AwTGs5RDRNRjYrUUMrY2g5WG5ielZEWDVP?=
 =?utf-8?B?RWhvWVF5U3pvWnZVTHJxQTgxQXp6NzBDMjMzeWhMdWM5Y3VoMjhmNnNVS3RP?=
 =?utf-8?B?Q3NUbmU0LysvVDlBdWdtaitSbERWOEZKb0R6TmE5OUw5RnZCTVNwRzRNcjBX?=
 =?utf-8?B?cWhWeGdzRWVtd0hhVGNCdUpvZ0g5VkJyMnNXZmUxRXZRdmlSU3FRVHh2QjN3?=
 =?utf-8?B?RVc4S0ZlcXNXTWk4K3gwVnpzaUlJVTB1TDJxd0xKTThodEN6L00wZWJMQ09S?=
 =?utf-8?B?Y0E3SDlhVFp5WFVGS0FhT2xMWVg3MTJtVklQNVZxbnA5T1pxS20xQ1BSb1Rl?=
 =?utf-8?B?L1VqVk51ZzlhajNSK1pFZ2hrNFJ6V3hGb2psVWpCNjBWT1VMNjdYTWJzalZJ?=
 =?utf-8?B?Unhzajc5VlZ3WTFQRlovVllvV0pDa3JmRjUwYi85THZtQUIzUURjcjhwS1Er?=
 =?utf-8?B?V1B5bExyTEZMV2dNLzBLSVY2T1AxdTNad3Z1dlAxU21iQzVSN1EwdElpSURC?=
 =?utf-8?B?eEdMS1pTaGlhenVja2hlczArb015RTVZM0doamhUZEdid1lJaGxacnFaVDFw?=
 =?utf-8?B?UWNFdjFzUVR2aXhJVEJZVjVrQVdLOTN5VDRaMmN0NDV5YXVaYzdNNlcvc1dB?=
 =?utf-8?B?YjB5ZXYyM1ltSDFxTlB2MjZrS3NTb1YwWEdhZzVFNitXVGpwd2VIaDl6Z2J1?=
 =?utf-8?B?c0wzeHU5bmM3c1I5N2V4YkpGR2kzS2NPZlZiRUVXTzl4dUc0ckwxN0wyNU1y?=
 =?utf-8?B?ZFJid1pLRU1Ecm81ZkJyK1d0QUVWREFreDROTUcxN1dNR2EwREM1V2UydWpl?=
 =?utf-8?B?REN2NDd1MG5hdndGTFdHQzYyRU1tYmU2UVNJZUtxQklnQk9ocC9NNkdoNS9v?=
 =?utf-8?B?M3RjeGFCOSsxMGx5SE5pd1lLMm9hN2Jvbm9NZ0t3RDNscCtiMEp6TitsakxK?=
 =?utf-8?B?emlJdDJTeXVOa2F6cll2TFlVdmt0ZytVSVRlbHhrTTljbnk1aXBIRkJhdHdB?=
 =?utf-8?B?L0F2WmxEV0hMZ0swWWZGMHM3cjh3TDVEUTVvNml4dHhSa2FzWTlrNXQ5T0lY?=
 =?utf-8?B?SFIyc0QwRlM4aWN3YnJWSzJkNVFKWjZaNWRLcU9GZkkxa3ppd1JkRDdrQjNj?=
 =?utf-8?B?ckxoMHdRRzFlaTU4bE00Tjd3V1BzNUxyRW1kZ1FUcXB3TFd3Z0Y4UE9peGhU?=
 =?utf-8?B?alBHclZ6WE9xVHBSVDRwUkVLRm9ra0ErOWtYNTY5eGpsTU9ZOTNLWXdJRWlq?=
 =?utf-8?Q?jYvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff741a4-27c8-4375-bd45-08d9a80c4792
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 07:48:14.1639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msU0yTbhkVWDHgmFzNzsSn1LvZ1KxLiK6H5ZYo3jiRsLEwcGnUtyS6Pi2PAHH+g8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAxNSwgMjAyMSAxMjozNCBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgQm9yaXNsYXYgUGV0a292
DQo+IDxicEBzdXNlLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzXSBkcm0vYW1kL3BtOiBh
dm9pZCBkdXBsaWNhdGUgcG93ZXJnYXRlL3VuZ2F0ZQ0KPiBzZXR0aW5nDQo+IA0KPiANCj4gDQo+
IE9uIDExLzE1LzIwMjEgODoyMSBBTSwgRXZhbiBRdWFuIHdyb3RlOg0KPiA+IEp1c3QgYmFpbCBv
dXQgaWYgdGhlIHRhcmdldCBJUCBibG9jayBpcyBhbHJlYWR5IGluIHRoZSBkZXNpcmVkDQo+ID4g
cG93ZXJnYXRlL3VuZ2F0ZSBzdGF0ZS4gVGhpcyBjYW4gYXZvaWQgc29tZSBkdXBsaWNhdGUgc2V0
dGluZ3Mgd2hpY2gNCj4gPiBzb21ldGltZXMgbWF5IGNhdXNlIHVuZXhwZWN0ZWQgaXNzdWVzLg0K
PiA+DQo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1lWODF2aWRXUUxXdkFU
TU1Aem4udG5pYy8NCj4gPg0KPiA+IENoYW5nZS1JZDogSTY2MzQ2YzY5ZjEyMWRmMGY1ZWUyMDE4
MjQ1MTMxM2FlNGZkYTJkMDQNCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVh
bkBhbWQuY29tPg0KPiA+IFRlc3RlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0K
PiA+IC0tDQo+ID4gdjEtPnYyOg0KPiA+ICAgIC0gdHlwbyBmaXggYW5kIGFkZCBsaW5rIGZvciB0
aGUgaXNzdWUgcmVmZXJyZWQgaW4gY29tbWl0DQo+ID4gICAgICBtZXNzYWdlKFBhdWwvQm9yaXMp
DQo+ID4gICAgLSB1cGRhdGUgdGhlIGRhdGEgdHlwZSB0byB1aW50MzJfdChQYXVsKQ0KPiA+ICAg
IC0gYmV0dGVyIE1hY3JvIG5hbWluZyhMaWpvKQ0KPiA+IHYyLT52MzoNCj4gPiAgICAtIHN0aWNr
IHRvIG9yaWdpbmFsIGxvZ2ljcyBvbiBoYW5kbGluZyB1bm1lbnRpb25lZCBJUCBibG9ja3MoTGlq
bykNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8ICAzICsrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFy
ZWQuaCAgIHwgIDMgKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0u
YyAgICAgICAgfCAxMCArKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2lu
Yy9hbWRncHVfZHBtLmggICAgfCAgOCArKysrKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCAwYmQ5MGVjOWU0M2Uu
LmZjYTU5MjM5NGZhMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtMzUwOCw2ICszNTA4LDkgQEAgaW50IGFtZGdwdV9kZXZp
Y2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgIAkJYWRldi0+cm1t
aW9fc2l6ZSA9IHBjaV9yZXNvdXJjZV9sZW4oYWRldi0+cGRldiwgMik7DQo+ID4gICAJfQ0KPiA+
DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgQU1EX0lQX0JMT0NLX1RZUEVfTlVNOyBpKyspDQo+ID4g
KwkJYXRvbWljX3NldCgmYWRldi0+cG0ucHdyX3N0YXRlW2ldLA0KPiBQT1dFUl9TVEFURV9VTktO
T1dOKTsNCj4gPiArDQo+ID4gICAJYWRldi0+cm1taW8gPSBpb3JlbWFwKGFkZXYtPnJtbWlvX2Jh
c2UsIGFkZXYtPnJtbWlvX3NpemUpOw0KPiA+ICAgCWlmIChhZGV2LT5ybW1pbyA9PSBOVUxMKSB7
DQo+ID4gICAJCXJldHVybiAtRU5PTUVNOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvYW1kX3NoYXJlZC5oDQo+ID4gaW5kZXggZjFhNDZkMTZmN2VhLi40YjllNjhhNzlmMDYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgNCj4g
PiBAQCAtOTgsNyArOTgsOCBAQCBlbnVtIGFtZF9pcF9ibG9ja190eXBlIHsNCj4gPiAgIAlBTURf
SVBfQkxPQ0tfVFlQRV9BQ1AsDQo+ID4gICAJQU1EX0lQX0JMT0NLX1RZUEVfVkNOLA0KPiA+ICAg
CUFNRF9JUF9CTE9DS19UWVBFX01FUywNCj4gPiAtCUFNRF9JUF9CTE9DS19UWVBFX0pQRUcNCj4g
PiArCUFNRF9JUF9CTE9DS19UWVBFX0pQRUcsDQo+ID4gKwlBTURfSVBfQkxPQ0tfVFlQRV9OVU0s
DQo+ID4gICB9Ow0KPiA+DQo+ID4gICBlbnVtIGFtZF9jbG9ja2dhdGluZ19zdGF0ZSB7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+IGluZGV4IDAzNTgxZDViMTgz
Ni4uMDgzNjJkNTA2NTM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
YW1kZ3B1X2RwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBt
LmMNCj4gPiBAQCAtOTI3LDYgKzkyNywxMyBAQCBpbnQNCj4gYW1kZ3B1X2RwbV9zZXRfcG93ZXJn
YXRpbmdfYnlfc211KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiB1aW50MzJfdCBibG9j
aw0KPiA+ICAgew0KPiA+ICAgCWludCByZXQgPSAwOw0KPiA+ICAgCWNvbnN0IHN0cnVjdCBhbWRf
cG1fZnVuY3MgKnBwX2Z1bmNzID0gYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzOw0KPiA+ICsJZW51
bSBpcF9wb3dlcl9zdGF0ZSBwd3Jfc3RhdGUgPSBnYXRlID8gUE9XRVJfU1RBVEVfT0ZGIDoNCj4g
PiArUE9XRVJfU1RBVEVfT047DQo+ID4gKw0KPiA+ICsJaWYgKGF0b21pY19yZWFkKCZhZGV2LT5w
bS5wd3Jfc3RhdGVbYmxvY2tfdHlwZV0pID09IHB3cl9zdGF0ZSkgew0KPiA+ICsJCWRldl9kYmco
YWRldi0+ZGV2LCAiSVAgYmxvY2slZCBhbHJlYWR5IGluIHRoZSB0YXJnZXQgJXMNCj4gc3RhdGUh
IiwNCj4gPiArCQkJCWJsb2NrX3R5cGUsIGdhdGUgPyAiZ2F0ZSIgOiAidW5nYXRlIik7DQo+ID4g
KwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4NCj4gPiAgIAlzd2l0Y2ggKGJsb2NrX3R5cGUpIHsN
Cj4gPiAgIAljYXNlIEFNRF9JUF9CTE9DS19UWVBFX1VWRDoNCj4gPiBAQCAtOTc5LDYgKzk4Niw5
IEBAIGludCBhbWRncHVfZHBtX3NldF9wb3dlcmdhdGluZ19ieV9zbXUoc3RydWN0DQo+IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IGJsb2NrDQo+ID4gICAJCWJyZWFrOw0KPiA+ICAgCX0N
Cj4gPg0KPiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJYXRvbWljX3NldCgmYWRldi0+cG0ucHdyX3N0
YXRlW2Jsb2NrX3R5cGVdLCBwd3Jfc3RhdGUpOw0KPiA+ICsNCj4gDQo+IE9uY2UgdGhlIGRlZmF1
bHQgY2FzZSBpcyBza2lwcGVkLCB0aGlzIHdpbGwgc2V0IHRoZSBzdGF0ZSBmb3IgdW5oYW5kbGVk
IGJsb2Nrcy4NCj4gU2hvdWxkIGJlIGZpbmUgaWYgc3VjaCBibG9ja3MgYXJlIG5vdCBleHBlY3Rl
ZC4gDQpbUXVhbiwgRXZhbl0gWWVzLCB0aGF0J3MgdGhlIGNhc2UuDQoNClRoYW5rcywgDQpFdmFu
DQo+IE90aGVyd2lzZSwganVzdCByZXR1cm4gMCBzdWNoDQo+IHRoYXQgdGhleSBob2xkIHVua25v
d24gcG93ZXIgc3RhdGVzLg0KPiANCj4gUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6
YXJAYW1kLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiA+ICAgCXJldHVybiByZXQ7DQo+
ID4gICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMv
YW1kZ3B1X2RwbS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBt
LmgNCj4gPiBpbmRleCA5OGYxYjNkOGMxZDUuLjE2ZTNmNzJkMzFiOSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmgNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfZHBtLmgNCj4gPiBAQCAtNDE3LDYgKzQxNywx
MiBAQCBzdHJ1Y3QgYW1kZ3B1X2RwbSB7DQo+ID4gICAJZW51bSBhbWRfZHBtX2ZvcmNlZF9sZXZl
bCBmb3JjZWRfbGV2ZWw7DQo+ID4gICB9Ow0KPiA+DQo+ID4gK2VudW0gaXBfcG93ZXJfc3RhdGUg
ew0KPiA+ICsJUE9XRVJfU1RBVEVfVU5LTk9XTiwNCj4gPiArCVBPV0VSX1NUQVRFX09OLA0KPiA+
ICsJUE9XRVJfU1RBVEVfT0ZGLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHN0cnVjdCBhbWRncHVf
cG0gew0KPiA+ICAgCXN0cnVjdCBtdXRleAkJbXV0ZXg7DQo+ID4gICAJdTMyICAgICAgICAgICAg
ICAgICAgICAgY3VycmVudF9zY2xrOw0KPiA+IEBAIC00NTIsNiArNDU4LDggQEAgc3RydWN0IGFt
ZGdwdV9wbSB7DQo+ID4gICAJc3RydWN0IGkyY19hZGFwdGVyIHNtdV9pMmM7DQo+ID4gICAJc3Ry
dWN0IG11dGV4CQlzbXVfaTJjX211dGV4Ow0KPiA+ICAgCXN0cnVjdCBsaXN0X2hlYWQJcG1fYXR0
cl9saXN0Ow0KPiA+ICsNCj4gPiArCWF0b21pY190CQlwd3Jfc3RhdGVbQU1EX0lQX0JMT0NLX1RZ
UEVfTlVNXTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgICNkZWZpbmUgUjYwMF9TU1RVX0RGTFQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0KPiA+DQo=
