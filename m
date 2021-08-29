Return-Path: <SRS0=a+kB=NU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF1C432BE
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Aug 2021 13:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEC360C41
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Aug 2021 13:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CEC360C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02CE89DA3;
	Sun, 29 Aug 2021 13:46:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E2C89DA3
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Aug 2021 13:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8MkkYY2gM6ABYus4pq03nDUz9M5YfnZUDnAmzDxZag1uC8h3oycf2ivwZgTmjlTRN9QiTAEhDDF6iqNc15j9zejl3xg12Vp4mah/14YLULPtfiQjFQD8eCafzRRIODu9zVCwbD5jmCyQ9WcrOTipW7E0hNfQuiwAcvtjchvdSrOaVKwBOOQuKk4kND8ebMANIOMums27GaoAsN/4n4wtNp8ibcXftdl9CFUy672qnybAWA8nnL0niB3ZgnpUgUcuHJBYOz5nwjVN3aPRYL/zPG16hBwm0C1velwcch59c/sl+u1tudQuDTxOSv90tT0YjrzrzIDM0gSkMtkMZOIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPGMoR1w57OwclbQc9e6sxy6NCqc4aSivqN5B59HH9k=;
 b=S4iot/mCixz+uInLbhJmxxI72eImzpNN0BZ9Aw+GrPOIF5KpPWYkHdx7QCuaK/P9Nh6YBFXW7oqpvHwFEK+7fJNCG4i3IHJSUezu0dPl/arquPRzHu2bBVpCfEgkh8k8v/K69BxaPEbEKr39S/2q6rW4l7dZAvPlDdY1Q63FpRNCUW2nBmX0DmPsb2+530xgSBv/AO5YbkpyQzLstvlUglC58V2et3XXFkYocw1OHqXs93HKlgtl7kgtbrv2IoO3XU4RX3u2Fqt9WPQf+5EkJQDjfcdUUzgPl2TQWRWPQB/CK3oZeEUu6rMiuC8Y/LP9maGA12J/qIuZ3dHKpXYo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPGMoR1w57OwclbQc9e6sxy6NCqc4aSivqN5B59HH9k=;
 b=kFKExPyfiDX0IZCfdf/wqcrVoye5AjsVo3dTqRdTadJFpTWAnRaDKOtBBlkepau0WnZQ5VODbMz+3DoKvxTF2LGaAnKNRAQ7khNSEMGjghtE5jz82rzMQjoaVu8ittX8noK1R8sbSaSRSucTL4HmG0VeJo26LcyJ5BfeeQWps4k=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19; Sun, 29 Aug 2021 13:46:30 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 13:46:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "mike@fireburn.co.uk" <mike@fireburn.co.uk>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini
Thread-Topic: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini
Thread-Index: AQHXmzAFSUCvFO7XIUuc/tIFdaKMhKuHOKeAgABzkoCAAtWQEA==
Date: Sun, 29 Aug 2021 13:46:29 +0000
Message-ID: <DM5PR12MB2469503C59074A4412939848F1CA9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210827104038.4945-1-guchun.chen@amd.com>
 <5bc45025-b524-926f-736f-95e5b70ae8be@amd.com>
 <4d7eee83-e0f9-47a6-abc7-f690f2bca496@amd.com>
In-Reply-To: <4d7eee83-e0f9-47a6-abc7-f690f2bca496@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-29T13:46:26Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=078446f3-74c6-4e8b-a549-773d2f0ace41;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d09ba19-e94c-43a9-3a3a-08d96af367af
x-ms-traffictypediagnostic: DM5PR1201MB2507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2507070BDC82CBC3F22F32E7F1CA9@DM5PR1201MB2507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KpioxUiG8/htPj4rniikmY0Zuen053MTYrMOFUBtITHkv36tEoipx//jEBLwnSuyP89sJkFqPTDq/1ZCGfI2Vul/EzHNZ80bI5AVFVH6kNrT6TaKUzxr9bPOOG7xcah8N22xu3IFkRNBSz6yWXRmP0rOiGMNxYMHm4IuSVUhl7wkW9i5/GNXz0UtwcEUjejmw0SFB1Rw5xjw8QGwmUa8td4mIeiyqY37au4MTNf8lE4NJoIayHNupTXciaPhvmxOMTf86ueGJ31hf7gMCX5aIYYkQCidFnPAyO4VencqI6jjwVHmyYXK1Oop6GKmL2SUhgzLeLh4JeZPk4AydMuIXN/MAVpaeIMNhl3LyNY5rcoqyTF/PP/8UzIg8kVFxkx4keZKYWalSnefRTTeC80CkMPDwGuGQSojam57jF33+xoiUI8zGM9/FaosuXS1wzdtqqL7zTR/4WN/g4Tje6W31OS0YP12NJAKk4MQDOJppg4w0gOZf7TwakhSSGeDM+Vl4a2NIFjWgfWvH00KmFRn24ndBalZEV6ZaFjasa9/fdjGgcPN97TpVf6F/1w5Ins9TZIULv0UqWb6POwFp9SE+QwcaE0rwE7ibbeSIGoDOQ1I4w8nhBg5TEUI0IKOkhEWvwgmy28SNl4BZDOjnPEE2bRMXYMJZc+z55rTGrsRkgqjdAbejkMpV8wzflMcELfKEwboWT1r92FUiB3bpO7ERXnlc/ze/uRiWozz87Cufkc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(71200400001)(83380400001)(66446008)(64756008)(9686003)(76116006)(66556008)(6636002)(33656002)(508600001)(26005)(38100700002)(110136005)(66476007)(66946007)(316002)(2906002)(52536014)(55016002)(8676002)(53546011)(5660300002)(8936002)(921005)(6506007)(7696005)(38070700005)(66574015)(186003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk5wbFV4Q1gyK0xRNXFNcGFaUWgwOWh4MmJuM2g2a2wybS8vaExYMFdNSGY1?=
 =?utf-8?B?cDdkMzlEOVRtdWt5OVZ3aC9CeWFYSFJNSmtucjNwZjV2cHFRZ1lqZEp2Z3ZU?=
 =?utf-8?B?MjQxZzlnZi96TkhtRDl1dEt3OFBFUkRaV2I5NG5EUXdodE5uZUJKRXFyQWdT?=
 =?utf-8?B?aHBUc1dQN01aaWIvOFRzR1hkcmZVaU8va2pOSHhodlozK3JHaUZCaUxCMWpy?=
 =?utf-8?B?UlFDV254MGJwcHZTUFFOWHVrYXRuQmZmb2VjMjdUb2xMbVNMdGo0cEt1azZr?=
 =?utf-8?B?K3RtQ2dhdEpNWHF2NmdzeTEwTG1ZdFhkejlXWHIrYUV2b1pTSkxuU0s5OHUz?=
 =?utf-8?B?akV0OFhqOUpCY3dwbjV6SGhLUFAwVGRXazI0Z0RRbTdZaUhFYzVGSTBKU2FZ?=
 =?utf-8?B?bDhyUUlVUzZCbVArVlU3aFpVaVlka3Q4M2lBbG5vWG1VdzhkVlhJWSsyWWR2?=
 =?utf-8?B?bnVpSy82K0dVS2U0V1JMalY1VWpIUFAwS1hNazMwRHcvaEloNW1GdnBEcURp?=
 =?utf-8?B?UDdHejI4dEw3YVRjNWN1UmpWSVh3MUlTczhvZ0hDY3lNNG51TTBKdlhVL2tl?=
 =?utf-8?B?cG5oVEdvYmFHdjN6QVFTQTBaOHQ5V3BFTm50eVJ4Q1NwbVV2ejc0S2NEYjQ5?=
 =?utf-8?B?UXMzc1grSWdLL1RrMGhuM1NkNU1CNis4YjhNYitOR3lLWmVpd0JOTWlWL3J2?=
 =?utf-8?B?TkRPeVBUa0hORXZZSHRnNUVqRHlGcnJlMjlEQ25OY2lDejA1U1BSZWpvK2Zq?=
 =?utf-8?B?R2IwMzRpVUp2YUdKd3JXME1QMHR5RlA2ZmRFK3lzdHJLNXNtOVU4NVArME9Y?=
 =?utf-8?B?dXVoWDlBbXlrTHMvNUR3MllvL0tVb1daL1VEWWFTK1VqV2dVeXFzUElFd25h?=
 =?utf-8?B?SDVFd2swY05RT0FhWk5NQXFVNU1iZEtiL0p4WFYrYTVkK1ZYSHp1ZlVOQ1Nv?=
 =?utf-8?B?cjd1L2VRSVdxZi8zZE1zZTBrRGtJUnY0bHk0VWhLSVZLL2FhZGVwb0JxaUdk?=
 =?utf-8?B?czg5TWljdUsyUkZNQWNKTlRHMHQycnN4SlNKbEROdmFYQUNoUzZQb1BpaUZk?=
 =?utf-8?B?ZDRwbzdJckNOODhlV1FmQ0N5THlsNGtNZ2tEQVk5UWY5eGZQNEJUeUhOY3VV?=
 =?utf-8?B?Y3FRL3hLQW1QVlVZNE9tdWtSNkZ4cFhRNHVBdHV6V1Z3WWh5Z3RPT1VETVlK?=
 =?utf-8?B?bm54WHVEUmVxb0RwTWlnd3V3TGtRa0VhVWc4VFduTkVuME5qYXBJZWFOQlN3?=
 =?utf-8?B?dEtEQXM5Ukg4Q2RjMzE5N3l1VXEyZXlTS25wVk9nLzg1QVptR1Nhc09XQ1Uy?=
 =?utf-8?B?Z3A4dEE1QjlrbUlPdW9zbmdWUG90UUtrd1VSaDk5ckFDZUF1SFZEWVBvSWdG?=
 =?utf-8?B?Q3JoTXovOUZISWZCNmJPY29GZ1hEYmNVRUtUNVpCL0cvQUpUWHBETkZGUXBZ?=
 =?utf-8?B?LzVhMjl4R00xRFNJYlNYbjhIcGo2KzRYam40M3lGNFVZS3VDeE5BRHVkRnhP?=
 =?utf-8?B?eDlQTjNFbm0ySmVTNlJNYzBsWWdQV1J2WDBydHJqV29RNDY2WllwbnhrNUxR?=
 =?utf-8?B?cnAxQVYwOVhmRmJVRkU2MGdXeU9kRDN6OThiSGloYnB2cDZ1OEdiWE9SOWs1?=
 =?utf-8?B?N3NxdS92ZXVHblJxblovWStKTzdmVWRqVE9uWmpWL0VaOE9xNkxWM3ZUTjlR?=
 =?utf-8?B?OE1lV0k0bGpoU3B6UE5CYlh6QmJJMVdGRlBpK2ptdlQwSVdvTVd3MnZXbFNn?=
 =?utf-8?Q?cMPtIQiagbkjG1JxV4Vqk6m9Ms2ksV8I1skopc4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d09ba19-e94c-43a9-3a3a-08d96af367af
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2021 13:46:29.6841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JifI97231BwIHPfD6MoXeiUEMUGDcqpPe7kSAg4CsrV1pb9nEgznKoiKonSnRFIYbNzipSgqMqUkLiGb2q5Vyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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

W1B1YmxpY10NCg0KSGkgQW5kcmV5IGFuZCBDaHJpc3RpYW4sDQoNClRoYW5rcyBmb3IgeW91ciBj
b21tZW50LCBJIHdpbGwgc2VuZCBvdXQgYSBuZXcgcGF0Y2ggc2V0IGxhdGVyIG9uIGFmdGVyIEkg
dmVyaWZ5IGl0Lg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+
IA0KU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyOCwgMjAyMSAyOjI4IEFNDQpUbzogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVu
LkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3
a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgbWlrZUBmaXJlYnVybi5jby51azsgRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogc3RvcCBzY2hlZHVsZXIgd2hlbiBjYWxsaW5nIGh3X2ZpbmkNCg0K
SSBkb24ndCB0aGluayBpdCB3aWxsIHN0YXJ0L3N0b3AgdHdpY2UgYmVjYXVzZSBhbWRncHVfZmVu
Y2VfZHJpdmVyX2h3X2ZpbmkvaW5pbnQgaXMgbm90IGNhbGxlZCBkdXJpbmcgcmVzZXQuDQoNCkkg
YW0gd29ycmllZCBhYm91dCBjYWxsaW5nIGRybV9zY2hlZF9zdGFydCB3aXRob3V0IGNhbGxpbmcg
ZHJtX3NjaGVkX3Jlc3VibWl0X2pvYiBmaXJzdCBzaW5jZSB0aGF0IHRoZSBwbGFjZSB3aGVyZSB0
aGUgam9icyBhcmUgYWN0dWFsbHkgcmVzdGFydGVkLiBBbHNvIGNhbGxpbmcgZHJtX3NjaGVkX3N0
YXJ0IHdpdGggZmFsc2UgZmxhZ8KgIHdyb25nIGhlcmUgc2luY2UgaXQgc2tpcHMgYWxsIHRoZSBw
ZW5kaW5nIGxpc3QgaGFuZGxpbmcuDQoNCkFuZHJleQ0KDQpPbiAyMDIxLTA4LTI3IDc6MzQgYS5t
LiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gSW4gZ2VuZXJhbCB0aGF0IGxvb2tzIGdvb2Qg
dG8gbWUsIGJ1dCB3aGF0IGNvdWxkIGJlIGlzIHRoYXQgd2Ugbm93IHRyeSANCj4gdG8gc3RvcC9z
dGFydCB0aGUgc2NoZWR1bGVyIGR1cmluZyByZXNldCB0d2ljZS4NCj4NCj4gQW5kcmV5IHdoYXQg
ZG8geW91IHRoaW5rPw0KPg0KPiBDaHJpc3RpYW4uDQo+DQo+IEFtIDI3LjA4LjIxIHVtIDEyOjQw
IHNjaHJpZWIgR3VjaHVuIENoZW46DQo+PiBUaGlzIGd1cmFudGVlcyBubyBtb3JlIHdvcmsgb24g
dGhlIHJpbmcgY2FuIGJlIHN1Ym1pdHRlZCB0byBoYXJkd2FyZSANCj4+IGluIHN1c3BlbmQvcmVz
dW1lIGNhc2UsIG90aGVyd2lzZSB0aGUgcmluZyB3aWxsIG5vdCBiZSBlbXB0eSBiZWZvcmUgDQo+
PiBzdXNwZW5kLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1
bi5jaGVuQGFtZC5jb20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mZW5jZS5jIHwgNiArKysrKysNCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZlbmNlLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zl
bmNlLmMNCj4+IGluZGV4IGI0MzllYjdkNDE3Ny4uZDZlNDI5ZTYzNjA0IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+PiBAQCAtNTUyLDYgKzU1
Miw5IEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9od19maW5pKHN0cnVjdA0KPj4gYW1kZ3B1
X2RldmljZSAqYWRldikNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJpbmcgfHwgIXJpbmct
PmZlbmNlX2Rydi5pbml0aWFsaXplZCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnRpbnVlOw0KPj4gwqAgK8KgwqDCoMKgwqDCoMKgIGlmICghcmluZy0+bm9fc2NoZWR1bGVyKQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX3N0b3AoJnJpbmctPnNjaGVkLCBO
VUxMKTsNCj4+ICsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBZb3UgY2FuJ3Qgd2FpdCBmb3Ig
SFcgdG8gc2lnbmFsIGlmIGl0J3MgZ29uZSAqLw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
ZHJtX2Rldl9pc191bnBsdWdnZWQoJmFkZXYtPmRkZXYpKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgciA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOyBAQCAtNjExLDYgKzYx
NCw5IEBAIA0KPj4gdm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX2h3X2luaXQoc3RydWN0DQo+PiBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghcmluZyB8fCAh
cmluZy0+ZmVuY2VfZHJ2LmluaXRpYWxpemVkKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29udGludWU7DQo+PiDCoCArwqDCoMKgwqDCoMKgwqAgaWYgKCFyaW5nLT5ub19zY2hlZHVs
ZXIpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1fc2NoZWRfc3RhcnQoJnJpbmctPnNj
aGVkLCBmYWxzZSk7DQo+PiArDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogZW5hYmxlIHRoZSBp
bnRlcnJ1cHQgKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmluZy0+ZmVuY2VfZHJ2Lmly
cV9zcmMpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfaXJxX2dldChhZGV2
LCByaW5nLT5mZW5jZV9kcnYuaXJxX3NyYywNCj4NCg==
