Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCDEC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB0410EC5D;
	Tue, 14 Jul 2026 08:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i88AfFke";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB24F10EC5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEcvINtmY+NUqBrHmlZZV01Dbth/niCoS35++8MoYREK0KcFnrhISa+gRqIVnZFqhMWJU2atWrVRWBALCkx9fRJ82acrMV4uvaGGgQyTXtABALxRXIFiSUexu80JNiRQnCUF+aFIa/FPe2hPw/8509iaj2Qtfe03Ed0xDiwWJ2kPl5zPXj4DjHSOTjspQRd+BUDQEwTqcpCnrtBeh2pO/QKVVF63RfrX47f/7Sy8nWFKOMxM84kh/Ov7R52CKVAH80DokrK+6iV/bFp+OGlEuBSW9IBKB4I2R+Fn9set8RiZcfKmgbvn97+s6I20JgaHYjiCgOxtaB+3vzVY4+t7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEj0K4NArqvMkhJJuoye+uHNd04yD4zQiruVbz9f1to=;
 b=WDOl1O67qto5GQhF8YaceCrbeQJZB8wTxapeUnVCgF9RF8A12Iqci/pSNh57y2VgiQKvSJAI2cnOmwMzHYQC7c3QWqZlZdE3rxC4UIY3F49pZ5gxG5HfWzQNYhdH5WDUpPqKNtPRvXe0k9t7i5FDYNrk608VKw3TA01yXK14cL9kneOgPgBYDL63I/aaBS2bckGVRI324NiGHtIWu0g7zLRZSACjdDGjHDsPtf7rq3PXwpYmvvup0VK2RyVyb87GECYaxuVTAVCp+5CXW37/CPnODIjzDEw+C9NV10w4Dhl4gqJdqTPY3RKe87XK4xh9x5K0ygpTiK+IoMuSE7TRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEj0K4NArqvMkhJJuoye+uHNd04yD4zQiruVbz9f1to=;
 b=i88AfFkecPjhlUVOvRbjGTqftYyu6tmiKQgWy0n0l8s2Ct18DIBS7BFHRAEINTPJe00OWnineHaaWSK/oKO9m4/vIKxmh7/qPwVLzfb5HxgPq8+pVaGHLnCCKJKRc/dRrt5mSfa8bTYAQQldyo5Zu7SKDN/sJlzMNH++3UXoVkE=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:11:33 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 08:11:33 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: John Olender <john.olender@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Thread-Topic: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Thread-Index: AQHdEoAu5kk8xWOkZESufTPc44VTJrZsKNwAgACCs7A=
Date: Tue, 14 Jul 2026 08:11:32 +0000
Message-ID: <DM4PR12MB574846B8F1905E0647087B3D8EF92@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260713042902.2220454-1-asad.kamal@amd.com>
 <1690367e-5e83-4121-bf3c-96f15f7060c8@gmail.com>
In-Reply-To: <1690367e-5e83-4121-bf3c-96f15f7060c8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T08:10:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|SJ2PR12MB8980:EE_
x-ms-office365-filtering-correlation-id: fff40c1a-a38a-4a89-7108-08dee17f8444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|3023799007|22082099003|18002099003|4143699003|56012099006|6133799003|11063799006|38070700021;
x-microsoft-antispam-message-info: oa2nZ1qlmbq7hJptmjBS6/OcaRu5TP9WxW9EqPZTkAf4EGH6XN3fGkNOjP91FGUR4F3slXcs0eJXbzwj2ayAnaP2dgg3k8YdRc4VXE2tEsNUBwNbKclKKzitm3Dh5sLaykAQjV13m6tXKdAwu/ukATQyN8u+hDemV4sAgptWXjsxtwIG8IkpHrC0xT5yF8qGsagdlOglgk4J6hZZpW2Ui7vs7E+yMsE6j41nAIenuHfchBfLg8Fne8wgJVb5XOSf8Dwv8VQ7wUZiVwr+mWuu3MgCYea3aU4ixYkCHhCeqaEzZ8GLjVkeeSVB1TVbfXFkZdwgS8xoglDGLrjpW152s5os1DzC8g8zHi6Jsh28+C2Z0wzcHAtqCIELqFLd8iaMC7TefLWrioLCIi8hB0S9e1oBYMyQje9AFHbiQiVps9C3oG+6DEm0CSfdcbEJLk4l2m8jAppEepiR3A1HNVnJkED1DcF8uOjdTAR+aBylVD56uSNuFqcGS8pcMbX1ECUJ0w5DID8BQZQyehMWgsag0ICGziZcRFWePvB8GITpTx812ePzXAVU14oVPE7mRN/UPhEho43BB06hzRl0GiaV522wigPKszOH4jhuiLF2JSEtic0YQq+4XiyeUDe+R760hcLysp/OjbhwjVc5To5Q1Jleb233CmdcuB8tWCa7tjSL8eRUIy4TgQ/rhj0qrJTmCFmk3U1cbUWothNIDdMXTyB5H/nm98GiyEqCNDXzgPw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUtxMDhlOGJTazR4Y0dFWUZST1FzakNZNDIwSmRIQ1JNVjB4VmR5NjltMkc1?=
 =?utf-8?B?dFQ1QjRUOTJseGt6UWVxNzFGbnRkajF0czN3enZ1SVM4YmNSTXdrdThicjlM?=
 =?utf-8?B?THJvV3VFZWo1Zk50VG5MMnN6RGZjWjRpSHh2dFdQZloyMGpIY3UyYXN6TnMv?=
 =?utf-8?B?WVV1Zjhza0dQeXFVR2gzL3ozZGRnek5ENEJBbGtUUnRaRXZFcWNtM00weDlp?=
 =?utf-8?B?THBYVmxvNk1BTFlYaGdKRDBvOVd5ZU5LbTh4MVQrczA4TTV5WmFHT1NWejVP?=
 =?utf-8?B?dUkwWmNQMlI1NUlKSFJYbnF5NlNpRDVBSmdtRzlnY3ZhS25aWTE0VnlqZEZJ?=
 =?utf-8?B?UWR3L2VkYjE3TURkR1N6S2dtYXE1cElhM0Fsd0R1NGtvQk1FRTQwaVdaUlFl?=
 =?utf-8?B?WEJlMHl5YkpiSVJzRjFnb3c5RnB1cTk1RFQrRzNETjJ3MWprUXFlV0dDSEE2?=
 =?utf-8?B?cjYrY0Z6QXdQYjBOZ0NoekRYL05mMWZyNjI3UmJnNG1URWJCUGYwWjVQNTIv?=
 =?utf-8?B?aFM5eElCS05NRG1hZ1psTXVGcStMOGFsZkI0R1I4UWEzUW9vc3BlSU9iSUU0?=
 =?utf-8?B?SkcrbHdjTmFTcnVvZURhdGJFUG1Oamg3TGNnc29jd3NFVHBYTjEydlAyRmZl?=
 =?utf-8?B?cmxrUlBUZHZpYjNhaHlHeGkyZFo0cDJob0I0RnJ3TWFPbWN1QjMwbzI3ckNK?=
 =?utf-8?B?N3A4MkZqQ0xHejRnMGpVZkU2YVhLSmJuTzFvU3VnbisvSW92TUpUZE1qMlBL?=
 =?utf-8?B?eHAvVWFSWmFpeUFYM0tFSUlwa1Z5SWJYT1pjRmtJNkFlMTZUMmVkQWMybktF?=
 =?utf-8?B?Z3dkL240aHY0MGxMNzNGV2NWbkVJTTF0V3FMYjdkRnhYUjZGYTVkaFRDZ1VS?=
 =?utf-8?B?d1AxZTh3ZXF3RTBSMDNkd3ZhUXZVSE5oY1F2RWsvcmZ3L3RsUUx0RGlkaElN?=
 =?utf-8?B?YmxEWDk3K0lwc0NTSy9mUDRqUDBkWXJvV05jRytZdDR1d1RuUVNFL2RHRlZ4?=
 =?utf-8?B?RzZHZHUrcmpTVkEzcS9KMEFFSm9yUUplSXp6MWpSdEwwVUM0ZTRxeFVma3ZJ?=
 =?utf-8?B?VGlLbzhtbGR1aEJocTdhR0FpVkh5NUo5QWtXKzFra04rWDI2aThpck1ra09r?=
 =?utf-8?B?VXh1YWZoTG5DVnlxb2JtVkJVODNjMC9WdnE0KzJaTVVveE45UldGN3BnM3Z3?=
 =?utf-8?B?VlRPcDRIcUg2dmNiaWkydkkwUnQ4SC9NMWF0b2xrR3M1WFptTzQvMFh1Vkgw?=
 =?utf-8?B?Z1pPOXJYb3M2TmpHQVNsaXBIb29ZbUpMOHg3cWRmbGJ6YVNuVnR0YTJhZlBL?=
 =?utf-8?B?NGdCYndPSlE1Rlk2Z0hxMlR4aW9oc3FWTXhEdzIrQlRabUhlS3Q1S1ZkaUU5?=
 =?utf-8?B?eXlDUE1zMk8yR0NqVTk1UkZLQTRlNFU0bUpOWmhlRXV0L2pLb2VId3lVL09t?=
 =?utf-8?B?Rk5JWFo5dVVLTlZoOWpaV214RlJnUC9BUU1rMVdyV2R2NVIxaTJpNXVSQkxV?=
 =?utf-8?B?a0dORzd4aUdSTGdFczg0OXF0OFZGVHdqUE5QWmRETDRMc21DQnJ3OVVVVDgr?=
 =?utf-8?B?YXFOS21jWnZla1dqMUNyNUcyeHdyR1drVkRPMDZXbko2dFREV1M4bmk3TVZs?=
 =?utf-8?B?a3ZacEJPZy9TNHhRbi8xRDYxaUdhNUFkNHVPUG5wS2poVWd3ZWl3WEdCS1dj?=
 =?utf-8?B?ZWtzREUxaUZ2QThyeC9ZL1Nub1pTM0s4WWRsS3c0YmNHbjc3eTNvQ2J0K2R2?=
 =?utf-8?B?RGZOYzJoN01Zc0xUMUdSRkFlMWt3NEw4bHBwZ2o5RXVlcFUvVlgwaUJXYm5x?=
 =?utf-8?B?dm1KWWRvRTJHaVNjNGVROWViUzFxTC9ya0hUWkdXY1AwSElldUJ2N3NySXgr?=
 =?utf-8?B?VU51dEtiZ2J6bFd3YWczMzJCMXh6RUF6dUpqQ21HS2lSeE9ibXBNZTVxam9Q?=
 =?utf-8?B?V1hkOHdzVjdDZkN0Zlo0RVZraW5ZcUswbGZpMFd4SE1YV1U0YWFXbGtOZmMx?=
 =?utf-8?B?K2RTeEZxemtDcU44SzE2eEFxOHJIUG9Kd0NJYTg5enNZa20zUmR6UzRxTWdH?=
 =?utf-8?B?dXZmb3BNTDA2c1VKdU0yZTcvc3BEOFl3Y1JWaUp5Zm5EUkoreUZZT3U5U0NQ?=
 =?utf-8?B?bXhZV1JzWGNKTUZJOFFYYnBNRDFQdElUSU82aWNVYVdocFArKzFFWUFmalpn?=
 =?utf-8?B?MUxvdGVlL1J2UnFteGNRRzNQckVwY1dLSnlLQkhER2pkc1dDbVVuTU5CczNG?=
 =?utf-8?B?L1FBOCtHb05IQllTMUVHeHg2dWRtTDZjVjNoV1RqRlBNaFFwNVBoOWVQZ2lP?=
 =?utf-8?Q?5+Z5MaLyKvs+cIW/8D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff40c1a-a38a-4a89-7108-08dee17f8444
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 08:11:32.7560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1Gh8yKH8N3KAR/62KocSI6JdMm6ISuUtBJl64YJMKdD/ixgF9kUowodQPorrHX/eRIsbcE8WiRn6b2WRbvY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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

QU1EIEdlbmVyYWwNCg0KVGhhbmsgeW91IGZvciB0aGUgdGVzdCBhbmQgY29tbWVudCwgd2lsbCB1
cGRhdGUgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHdoaWxlIHN1Ym1pdHRpbmcNCg0KVGhhbmtzDQpB
c2FkDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvaG4gT2xlbmRlciA8
am9obi5vbGVuZGVyQGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEp1bHkgMTQsIDIwMjYgNTo1
MyBBTQ0KVG86IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgTWEsIExlIDxMZS5NYUBhbWQu
Y29tPjsgWmhhbmcsIE1vcnJpcyA8U2hpd3UuWmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZp
bllhbmcuV2FuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9wbTogRml4
IHBwX2VudHJpZXNfbWF4KCkgYmlvcyBjaGVjaw0KDQpPbiA3LzEzLzI2IDEyOjI5IEFNLCBBc2Fk
IEthbWFsIHdyb3RlOg0KPiBDb21taXQgM2NmZTQzMzYzMDUwICgiZHJtL2FtZC9wbTogVXNlIHVw
bG9hZGVkIHNpemUgZm9yIGxlZ2FjeSBjdXN0b20NCj4gUFBUYWJsZSIpIGNoYW5nZWQgcHBfZHBt
X3NldF9wcF90YWJsZSgpIHRvIGttZW1kdXAgdGhlIHVwbG9hZGVkIGJ1ZmZlcg0KPiBkaXJlY3Rs
eSBhbmQgc2V0IHNvZnRfcHBfdGFibGVfc2l6ZSB0byB0aGUgdXBsb2FkZWQgc2l6ZS4gIEFzIGEg
cmVzdWx0DQo+IHNvZnRfcHBfdGFibGUgbm93IHBvaW50cyB0byBhbiBhbGxvY2F0aW9uIGNvbXBs
ZXRlbHkgb3V0c2lkZQ0KPiBhZGV2LT5iaW9zLCBtYWtpbmcgdGhlIHVuY29uZGl0aW9uYWwgcHBf
ZW5kID4gYmlvc19lbmQgY2hlY2sgaW4NCj4gcHBfZW50cmllc19tYXgoKSBhbHdheXMgdHJ1ZSBm
b3IgY3VzdG9tIFBQIHRhYmxlcyDigJQgc2lsZW50bHkgcmV0dXJuaW5nDQo+IDAgYW5kIGJyZWFr
aW5nIFBQIHRhYmxlIG92ZXJyaWRlcyB2aWEgc3lzZnMuDQo+DQoNCldoZW4gSSBoaXQgdGhpcyBp
c3N1ZSwgdGhlIHBwX2VuZCA+IGJpb3NfZW5kIGNoZWNrIGRpZG4ndCBhbHdheXMgcmV0dXJuIHRy
dWUuICBUaGUgb3JkZXIgb2YgcHBfdGFibGUgb3ZlcnJpZGVzIG1hdHRlcmVkIGZvciB0cmlnZ2Vy
aW5nIHRoZSBmYWlsdXJlIG9uIGEgc3lzdGVtIHdpdGggbXVsdGlwbGUgY2FyZHMuDQoNCkkgYWxz
byB3b3VsZG4ndCBjYWxsIHRoaXMgZmFpbHVyZSBwYXRoIHNpbGVudC4gIENhbGxlcnMgb2YNCnBw
X2VudHJpZXNfbWF4KCkgcHJpbnQgYXBwcm9wcmlhdGUgd2FybmluZ3MsIHBhaW50aW5nIGEgbmlj
ZSBwaWN0dXJlIG9mIHdoYXQncyBoYXBwZW5pbmcgZHVyaW5nIHRoZSByZXN1bHRpbmcgY2FzY2Fk
ZToNCg0KJCBzdWRvIGNwIGN1c3RvbV9wcF90YWJsZS5iaW4gL3N5cy9jbGFzcy9kcm0vY2FyZE4v
ZGV2aWNlL3BwX3RhYmxlDQpLaWxsZWQNCg0KWyAgIDcxLjMyMDEwOV0ga2VybmVsOiBhbWRncHU6
IGFtZGdwdTogTU0gZGVwZW5kZW5jeSB0YWJsZTogY2xhbXBpbmcgdWNOdW1FbnRyaWVzIDggLT4g
MA0KWyAgIDcxLjMyMDEzN10ga2VybmVsOiBhbWRncHU6IGFtZGdwdTogUG9sYXJpcyBTQ0xLIGRl
cGVuZGVuY3kgdGFibGU6IGNsYW1waW5nIHVjTnVtRW50cmllcyA4IC0+IDANClsgICA3MS4zMjAx
NDldIGtlcm5lbDogYW1kZ3B1OiBhbWRncHU6IE1DTEsgZGVwZW5kZW5jeSB0YWJsZTogY2xhbXBp
bmcgdWNOdW1FbnRyaWVzIDQgLT4gMA0KWyAgIDcxLjMyMDE2Nl0ga2VybmVsOiBhbWRncHU6IE51
bWJlciBvZiBQY2llIEVudHJpZXMgZXhjZWVkIHRoZSBudW1iZXIgb2YgU0NMSyBEcG0gTGV2ZWxz
ISBEaXNyZWdhcmRpbmcgdGhlIGV4Y2VzcyBlbnRyaWVzLi4uDQpbICAgNzEuMzIwMTc5XSBrZXJu
ZWw6IGFtZGdwdTogU0NMSyBEUE0gaW5kZXggZm9yIFZSSG90IGNhbm5vdCBleGNlZWQgdGhlIHRv
dGFsIHNjbGsgbGV2ZWwgY291bnQhDQpbICAgNzEuMzIwMTkwXSBrZXJuZWw6IGFtZGdwdTogYW1k
Z3B1OiBWZGRjTG9va3VwIHRhYmxlOiBjbGFtcGluZyB1Y051bUVudHJpZXMgMTUgLT4gMA0KWyAg
IDcxLjMyMDIwMF0ga2VybmVsOiBhbWRncHU6IGFtZGdwdTogVmRkY0xvb2t1cCB0YWJsZTogY2xh
bXBpbmcgdWNOdW1FbnRyaWVzIDggLT4gMA0KWyAgIDcxLjMyMDIxMV0ga2VybmVsOiBhbWRncHU6
IFtwb3dlcnBsYXldIExvb2t1cCB0YWJsZSBpcyBlbXB0eQ0KWyAgIDcxLjMyMDIyMl0ga2VybmVs
OiBhbWRncHU6IFtwb3dlcnBsYXldIExvb2t1cCB0YWJsZSBpcyBlbXB0eQ0KLi4uDQpbICAgNzEu
Njc4Njc5XSBrZXJuZWw6IG5vdGU6IGNwWzIyNDNdIGV4aXRlZCB3aXRoIGlycXMgZGlzYWJsZWQN
Cg0KPiBGaXggdGhpcyBieSBjb25kaXRpb25pbmcgdGhlIEJJT1MgY29udGFpbm1lbnQgY2hlY2sg
b24NCj4gaGFyZGNvZGVfcHBfdGFibGUgYmVpbmcgTlVMTC4gIGhhcmRjb2RlX3BwX3RhYmxlIGlz
IHplcm8taW5pdGlhbGlzZWQNCj4gKGt6YWxsb2MpIGFuZCBvbmx5IHNldCB3aGVuIGEgY3VzdG9t
IHRhYmxlIGlzIHVwbG9hZGVkIHZpYSBzeXNmcywgc286DQo+DQo+ICAgLSBoYXJkY29kZV9wcF90
YWJsZSA9PSBOVUxMOiBWQklPUyBwYXRoIOKAlCBlbmZvcmNlIHBwX2VuZCA8PSBiaW9zX2VuZA0K
PiAgICAgdG8gcmVqZWN0IGEgbWFsaWNpb3VzIFZCSU9TIGluZmxhdGluZyB1c1N0cnVjdHVyZVNp
emUgcGFzdCB0aGUgQklPUw0KPiAgICAgaW1hZ2UuDQo+DQo+ICAgLSBoYXJkY29kZV9wcF90YWJs
ZSAhPSBOVUxMOiBjdXN0b20gdXBsb2FkIHBhdGgg4oCUIHNraXAgdGhlIGJpb3NfZW5kDQo+ICAg
ICBjaGVjaywgc29mdF9wcF90YWJsZV9zaXplIGlzIHRoZSBrZXJuZWwtc3VwcGxpZWQgdXBsb2Fk
IHNpemUgYW5kIGlzDQo+ICAgICBhbHJlYWR5IHRydXN0ZWQuDQo+DQo+IEZpeGVzOiBlMzBiM2Uz
YWI1MWEgKCJkcm0vYW1kZ3B1L3BtOiBhZGQgcHBfZW50cmllc19tYXgoKSBoZWxwZXIiKQ0KPiBS
ZXBvcnRlZC1ieTogSm9obiBPbGVuZGVyIDxqb2huLm9sZW5kZXJAZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBc2FkIEthbWFsIDxhc2FkLmthbWFsQGFtZC5jb20+DQoNClRlc3RlZC1ieTog
Sm9obiBPbGVuZGVyIDxqb2huLm9sZW5kZXJAZ21haWwuY29tPg0KDQpUaGFua3MsDQpKb2huDQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9pbmMvaHdtZ3IuaCB8
IDE1ICsrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2luYy9od21nci5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBs
YXkvaW5jL2h3bWdyLmgNCj4gaW5kZXggN2ViYzEzNDQwMjNmLi5hMjNlMDE5MjE4NDIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2luYy9od21nci5oDQo+IEBA
IC04MzMsMTQgKzgzMywxNyBAQCBzdGF0aWMgaW5saW5lIHVpbnQzMl90IHBwX2VudHJpZXNfbWF4
KGNvbnN0IHN0cnVjdCBwcF9od21nciAqaHdtZ3IsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IHZvaWQgKnN1Yl90YWJsZSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZV90IGhkcl9zaXplLCBzaXplX3QgcmVjX3NpemUpICB7DQo+
IC0gICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICopaHdtZ3ItPmFkZXY7DQo+IC0gICAgIGNvbnN0IGNoYXIgKmJpb3NfZW5kID0gKGNvbnN0IGNo
YXIgKilhZGV2LT5iaW9zICsgYWRldi0+Ymlvc19zaXplOw0KPiAtICAgICBjb25zdCBjaGFyICpw
cF9lbmQgICA9IChjb25zdCBjaGFyICopaHdtZ3ItPnNvZnRfcHBfdGFibGUNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArIGh3bWdyLT5zb2Z0X3BwX3RhYmxlX3NpemU7DQo+ICsgICAg
IGNvbnN0IGNoYXIgKnBwX3N0YXJ0ID0gKGNvbnN0IGNoYXIgKilod21nci0+c29mdF9wcF90YWJs
ZTsNCj4gKyAgICAgY29uc3QgY2hhciAqcHBfZW5kICAgPSBwcF9zdGFydCArIGh3bWdyLT5zb2Z0
X3BwX3RhYmxlX3NpemU7DQo+ICAgICAgIGNvbnN0IGNoYXIgKmVudHJpZXMgID0gKGNvbnN0IGNo
YXIgKilzdWJfdGFibGUgKyBoZHJfc2l6ZTsNCj4NCj4gLSAgICAgaWYgKHBwX2VuZCA+IGJpb3Nf
ZW5kKQ0KPiAtICAgICAgICAgICAgIHJldHVybiAwOw0KPiArICAgICBpZiAoIWh3bWdyLT5oYXJk
Y29kZV9wcF90YWJsZSkgew0KPiArICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaHdtZ3ItPmFkZXY7DQo+ICsgICAgICAgICAg
ICAgY29uc3QgY2hhciAqYmlvc19lbmQgPSAoY29uc3QgY2hhciAqKWFkZXYtPmJpb3MgKyBhZGV2
LT5iaW9zX3NpemU7DQo+ICsNCj4gKyAgICAgICAgICAgICBpZiAocHBfZW5kID4gYmlvc19lbmQp
DQo+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKyAgICAgfQ0KPiAgICAgICBp
ZiAoIXJlY19zaXplIHx8IGVudHJpZXMgPj0gcHBfZW5kKQ0KPiAgICAgICAgICAgICAgIHJldHVy
biAwOw0KPiAgICAgICByZXR1cm4gKHVpbnQzMl90KSgocHBfZW5kIC0gZW50cmllcykgLyByZWNf
c2l6ZSk7DQoNCg==
