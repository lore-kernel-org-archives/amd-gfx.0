Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F48FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 07:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B7310FC91;
	Thu, 14 Apr 2022 07:12:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3F010FC91
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 07:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG+LV+d7swko7BAh513QS69HeMoeYbrtUhc5ZPuYQvCXQtF/hdCwLjjJnZnEIz+OGbkxO627hob67PQ9hhSStBot0roelst5VTUMkZ4lm9JHfiLrf2yvJvZ2C0TecbsutTPDOIBwx5j4BoY2zbCXO01j/OJk5nabCHVPhZZItuw70Jd5XW75Uiu7271VbGK005uPkAZDcbc0Hr4Mz+bRpTpNVg+o6GvbX/kCiGJXmxCS07EryEIFUzDRAaOSy/xNCT2bhRSqeXesb3AAVWO/HcGZODeYgIIqEG9fewYRwHmp+3Cl4dhPlQ1q4Vxe/fHHFPctLCXUmhrVkLLalGzP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCwtsCbS5+n23kHEgmlvhx72YzpWOBf/vecPlocTfaQ=;
 b=Emu8BtJsGrU+j3RSqrV29uFaCfRpIujHeyQzKMwd6fAHvdHZaBeFDajZg1MvQELF6z3PaFMP5mIuXsS2LDl6BH8l9KcntReRfEXr0GbtJGYUzyqcvFVQS12L6nqflwsahfz2Vl9PVWHHxXo2h9bPDZS8kZFHkOu2rvVzzhL98eLDKDOwU8+dPg0jGyjtXGe92nlVx4Kd7jKrDEMTHhk46umoEq0z4kWr59n+Hw5hHUexxK9r42z8OH6JvW8A5+GRK8O1sbS0L8tdLkcqN1ou/J0ZDsMFy8KZCm+gooqkKGqArTJ7YUct7PT//pGL7yfSakBTpTpqWWYdO9lQU08uXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCwtsCbS5+n23kHEgmlvhx72YzpWOBf/vecPlocTfaQ=;
 b=xrwEKY8tSFnbtOPoiMgM+o10W5S/lH+a6RAqK4zliCp4TdsuA/NxeZGHPQ4dm3rIzxnc0t/GWyfZRNwW1SAbGJYAEoDc0sHZPeqpKVUfb42NtUUlxEGdl9LJHdli9nm0jf7VOpRdIuO7CsTAXvoMl2BupTS/WepdoO7HnIe1A4k=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BN6PR12MB1540.namprd12.prod.outlook.com (2603:10b6:405:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 07:12:04 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::c36:d920:511b:de6b]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::c36:d920:511b:de6b%5]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 07:12:04 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Thread-Topic: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Thread-Index: AQHYT20Q7pt+1nvieUer+jguBeaFbKzu9igAgAAIOgA=
Date: Thu, 14 Apr 2022 07:12:04 +0000
Message-ID: <BL0PR12MB24658257A9A31C1C69C38745F1EF9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
 <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
In-Reply-To: <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ff1f3fe-36af-4b92-71d4-08da1de6140c
x-ms-traffictypediagnostic: BN6PR12MB1540:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1540D99EA18864586ECB7D5CF1EF9@BN6PR12MB1540.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FAPq73BQ/cwKrS+W2g4rNb1uniQwVR2dmXnCTYb07Ck7FRZcP3IeXMOy6Y6yAo+6keaBYydClvmkfdNQmoGbjeAkgqmMUbhYJlKnEnCCf7JaPNWFgI9ZUE+ZD7erzMgavzFNENM9US5iB3oIizxhKOW4wvpE8ocGJ+8404DQanirrr4O8L9kVHG9WeimHVa3Kb/HaLaD7h16/1FymJrLfLYJ9/l34SVd24aGBPgOSVN5LNCHjsssO8YGNHpKCQw8teXS0FBVbBRC151WxXR5twILsY0E8niETaZlVjheaLOOUSiTDABdj5G+XQsibH4rhSW4fwa8TRtX4T74nT2bxjwx0QqJAyT2c0fPykiw2MC56ztOKgq+oWxGyScXsXGo+5TktyWuAqFpRhkcfFF9Y9knh5APyBWhODUkbodPMqXLfN5RGzCWFc4lBrxQ9S6RNGWRwNQR1Zw0kaPfehJQOj/6lyb0R2jfH3OJGcB8Ln3bwiKwW1nKEykT2lH1/D6k8nfngC13q61NAh62nFI5Qpv3cZPxtD8zYRwwAI2HdCgD9PTSg9hs9YipSlImsZdLdAdmQVlHGECOrpVqETHKt7JlRoervtegBcli2/l5R96gOUrKg+a0KouWRJ8Uew3Y99stUxJNKCIJwZagV01P9xnV/V4Jf3tqcC2ProJ988V0M7WiBTfdOksifI3Y4k9/NfCAK8Uo4pY1V2pirKBvpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(66574015)(71200400001)(52536014)(38100700002)(33656002)(86362001)(53546011)(5660300002)(7696005)(9686003)(316002)(2906002)(83380400001)(55016003)(38070700005)(8936002)(110136005)(66476007)(508600001)(122000001)(66946007)(76116006)(66556008)(4326008)(64756008)(26005)(186003)(8676002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzR0OVJLZmVhanBidHQzdE5BS2ZvMEt3RmR6VjQzNEFwYnBHWW5BZHZyM3B1?=
 =?utf-8?B?STF5YTlKRzN6MlljSWo5VDljNXZpN3VjMGkwWldFVXJueGV4bkVWK09lM1ly?=
 =?utf-8?B?UStaQzFxbmdHOG16OXMwUTFIUmp2SytQSXNpSC9wMmpMQW1lSGg5RFR1d1Jr?=
 =?utf-8?B?QytuRlN4OWNxcVJIL3hBTFN4eWszN2hKKzlnZ2lQRWRsdkpYaitBazBQcHZ1?=
 =?utf-8?B?RTIrUHE4RkhVMXNCUlA1N2k4bDloaXdTRjFzNFgwWklxbWxMdVVNaVhRVkZZ?=
 =?utf-8?B?cHhrM05URXNyU1VmYjdhK2U5QmRGL3hwZzR5T29pODN2Z2RiK2syUGpiZXBK?=
 =?utf-8?B?VksrejJHeXVVRVNlL3ZVRStlbVpNVFJwKzVtVncxMTQ4dzllRUtDbFpHbkYy?=
 =?utf-8?B?U1JZNW9hbnNQQzhlMy9OUU8vcGdSUU5nZGd0MHNXQUV5bk00QXo1WVVKUC9i?=
 =?utf-8?B?cmU0aVRHYWFiZTlCdmtiVGRuZzBjTjZnNjJDQXM5cTl0WFZzTnJKSHEzQUND?=
 =?utf-8?B?MEkzdkZCdXFZbFRETkdlQy9wYllpRTVqRGhUKysxWks2ZnRSa2pRNTczUUZo?=
 =?utf-8?B?cERJSElCZGVRWmh0QVdCcXkycHhSdUIrMEQxZjRuSTQ4cjQ2cXczQ2Npci92?=
 =?utf-8?B?YkZkU0ZZTGRqdWtPUmdqY2ZWMk9IWS9NYVJlRkkrOHpCQWdiOUJ2YVNSSG1q?=
 =?utf-8?B?VzhjSzA1TUpORm9iMmNTbXR6ZzBDTEk4aU13U0ZwWGtCNXpMditpaEVQUWE2?=
 =?utf-8?B?Vit5cHBKVzYralJpdU82K1kwOUtvQWNJeVQvd1ZFb29rdWVoOVgyZlI4QmZQ?=
 =?utf-8?B?WVdOWlpQMlFra0hTSUlsWEp0d0djRSs1WVRrZFNqUWM1RUdsemlFcklLT01H?=
 =?utf-8?B?bXVremoxRkRwaUZlV1ZSVjdhRUtXZnZKQ3BhaUxjWElPUFdsanRCeTM5R0lY?=
 =?utf-8?B?OVBOdEtHZThiWEgybzEvT2lEcnh6N1VJa2JFL25tcStsWUYxT1NYdGdVeEZV?=
 =?utf-8?B?TStoR3pyOWJVVDBESGdWNXlmRTV5VjMyY2xlVGhtN05NRVUxYnIwajM4WDJK?=
 =?utf-8?B?akQ0T0dGcTY4ZDc2ZGJ5TWZ5UTBKTUE4V213V2JnbTF6a0hQN29TSXErNzIv?=
 =?utf-8?B?NXJNVWVGZkdHd0pNdCtJNGFZL3lqUldtSldKNXhRTklDRkdmclpXVWR3SFQ5?=
 =?utf-8?B?V2lPeUFyVTR2YmZqZmtYVUw1NFRQbW9JMkhhTUZOd0gvRW9oK0VKWE5keVFU?=
 =?utf-8?B?elpMUWNtOGRaMlZyRERpZkhSWlF0bWErdFJqTTE0MnMzWmRNTGtLbzhKWng5?=
 =?utf-8?B?cVh4aUJsVEd2NlhCVUxxa1VCV3JILzNremFPaVBEU0xLVU9iZUVkY2JpbnVE?=
 =?utf-8?B?U1F2UXlEcjhHcDhPMldZeXFPZEl0VC9qeWowYStTaUZtN2JBOU5QaUF5alV2?=
 =?utf-8?B?K2M4Wk8zZXRZc1Z2ZXdFdUNJVGhmWk9HQVFBdE1MYmtrTFU2OG1RMnplRnpN?=
 =?utf-8?B?ZjhTNVMyWG0wSWozZ0RvRmhKQTVndUhxOThkdlhXQVpSTTBzRlViczlzdG0z?=
 =?utf-8?B?NHRPdjBZVWl5RUpGZS94dlVrZ2Z4ZkNhRUpUT1l1aEYwZnBlaEZldWpZdGZw?=
 =?utf-8?B?aEZqYW1Wb0FRYzhDUnp6dytMYmtLdFRTQ2ZGTFFVdVBxbktnazY4cXJ1d0Jr?=
 =?utf-8?B?dWh4OTh3RVdCR1ZoZ2xleHNkM25YRkN3NEZIMHFqMUd3ejNXRjhrTVgxK1Mv?=
 =?utf-8?B?YXE5UlJKaVhqYVIvQnlZNmtYd00vOFZRWEo1TkJOSGYzVVdWTzhqakNSbHF5?=
 =?utf-8?B?azdUOG9tcUtzMWI0M3NZQXdFZUtwUXpLcXNiRk90MU1TbVRERUdUV1owT0FK?=
 =?utf-8?B?SGRZeC95ZXhCU0RqeHRBNG4zbDdBVStxQ1NxTmVGWkRCcXdjUWptUk5VOUdy?=
 =?utf-8?B?WUQvc3p0YmdjYTdZZ2lxNTBoTnpCdmFydFNvNXZ0NmNWNmd6QkMzZ1dzK0VP?=
 =?utf-8?B?TkxtZUJaTXZwUHZyUmJDUU1PL2N5cDd5RUIzcTZCUFJqby94RW5kM0ppNlRN?=
 =?utf-8?B?TFFJZGwvODhZUXJncHhtRGtJTi9ESzh4RmR3ZXlUV29MQ2JmekV3Y0FPRUIx?=
 =?utf-8?B?dG9xZ2N6UzhibDlWOUV6VEY1VTlBVTltbzlZOEs1bEVpcjJZSWtRUVVkVzcr?=
 =?utf-8?B?RTBXSm91RVdhUm80V1Zoek5IUUJBbnJBL1ZTQnpWb2hsMjRGSGliQWEvN2dW?=
 =?utf-8?B?RnB5L1F3RXQ5N0VTMVczMXMwckw0VTU4cEJicmRBUUNXdkhwak8xMXp4Ylc0?=
 =?utf-8?B?VzBtWmhEUjZqTHBGTXFjR1E5VHJNckVkbmJoTHhaNVlQUWhqUFNSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff1f3fe-36af-4b92-71d4-08da1de6140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 07:12:04.1452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohQxv4/OP4ipSAXCWV/dZyglpccATAJM1q4S1ZRqiY6do5vaiccWOsvJSIhcQVua1Z8zKz54w5yHAwy6eLwMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1540
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
Cc: "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SXQncyBpbiBhbWRncHVfcGNpX3Jlc3VtZS4NCg0KQW5kcmV5LCBzaGFsbCB3ZSBtb2RpZnkgdGhl
IGNvZGUgYWNjb3JkaW5nbHkgaW4gYW1kZ3B1X3BjaV9yZXN1bWUgYXMgd2VsbD8gT3RoZXJ3aXNl
LCBhbiB1bnNldC91bmxvY2sgbGVhayB3aWxsIGhhcHBlbiB3aGVuIHBjaV9jaGFubmVsX3N0YXRl
ICE9IHBjaV9jaGFubmVsX2lvX2Zyb3plbi4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IFRo
dXJzZGF5LCBBcHJpbCAxNCwgMjAyMiAyOjQwIFBNDQpUbzogR3JvZHpvdnNreSwgQW5kcmV5IDxB
bmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBBbnRvbm92aXRjaCwgQW5hdG9saSA8QW5hdG9saS5BbnRvbm92aXRjaEBhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogTW92ZSByZXNldCBkb21haW4gbG9ja2lu
ZyBpbiBEUEMgaGFuZGxlcg0KDQoNCg0KQW0gMTMuMDQuMjIgdW0gMjE6MzEgc2NocmllYiBBbmRy
ZXkgR3JvZHpvdnNreToNCj4gTG9jayByZXNldCBkb21haW4gdW5jb25kaXRpb25hbGx5IGJlY2F1
c2Ugb24gcmVzdW1lIHdlIHVubG9jayBpdCANCj4gdW5jb25kaXRpb25hbGx5Lg0KPiBUaGlzIHNv
bHZlZCBtdXRleCBkZWFkbG9jayB3aGVuIGhhbmRsaW5nIGJvdGggRkFUQUwgYW5kIG5vbiBGQVRB
TCBQQ0kgDQo+IGVycm9ycyBvbmUgYWZ0ZXIgYW5vdGhlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
QW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDE0ICsrKysrKyst
LS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gaW5kZXggMWNjNDg4YTc2N2Q4Li5jNjVmMjVlM2EwZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTU1MzEsMTggKzU1MzEsMTgg
QEAgcGNpX2Vyc19yZXN1bHRfdCANCj4gYW1kZ3B1X3BjaV9lcnJvcl9kZXRlY3RlZChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgcGNpX2NoYW5uZWxfc3RhDQo+ICAgDQo+ICAgCWFkZXYtPnBjaV9jaGFu
bmVsX3N0YXRlID0gc3RhdGU7DQo+ICAgDQo+ICsJLyoNCj4gKwkgKiBMb2NraW5nIGFkZXYtPnJl
c2V0X2RvbWFpbi0+c2VtIHdpbGwgcHJldmVudCBhbnkgZXh0ZXJuYWwgYWNjZXNzDQo+ICsJICog
dG8gR1BVIGR1cmluZyBQQ0kgZXJyb3IgcmVjb3ZlcnkNCj4gKwkgKi8NCj4gKwlhbWRncHVfZGV2
aWNlX2xvY2tfcmVzZXRfZG9tYWluKGFkZXYtPnJlc2V0X2RvbWFpbik7DQo+ICsJYW1kZ3B1X2Rl
dmljZV9zZXRfbXAxX3N0YXRlKGFkZXYpOw0KPiArDQo+ICAgCXN3aXRjaCAoc3RhdGUpIHsNCj4g
ICAJY2FzZSBwY2lfY2hhbm5lbF9pb19ub3JtYWw6DQo+ICAgCQlyZXR1cm4gUENJX0VSU19SRVNV
TFRfQ0FOX1JFQ09WRVI7DQoNCkJUVzogV2hlcmUgYXJlIHdlIHVubG9ja2luZyB0aGF0IGFnYWlu
Pw0KDQo+ICAgCS8qIEZhdGFsIGVycm9yLCBwcmVwYXJlIGZvciBzbG90IHJlc2V0ICovDQo+ICAg
CWNhc2UgcGNpX2NoYW5uZWxfaW9fZnJvemVuOg0KPiAtCQkvKg0KPiAtCQkgKiBMb2NraW5nIGFk
ZXYtPnJlc2V0X2RvbWFpbi0+c2VtIHdpbGwgcHJldmVudCBhbnkgZXh0ZXJuYWwgYWNjZXNzDQo+
IC0JCSAqIHRvIEdQVSBkdXJpbmcgUENJIGVycm9yIHJlY292ZXJ5DQo+IC0JCSAqLw0KPiAtCQlh
bWRncHVfZGV2aWNlX2xvY2tfcmVzZXRfZG9tYWluKGFkZXYtPnJlc2V0X2RvbWFpbik7DQo+IC0J
CWFtZGdwdV9kZXZpY2Vfc2V0X21wMV9zdGF0ZShhZGV2KTsNCj4gLQ0KPiAgIAkJLyoNCj4gICAJ
CSAqIEJsb2NrIGFueSB3b3JrIHNjaGVkdWxpbmcgYXMgd2UgZG8gZm9yIHJlZ3VsYXIgR1BVIHJl
c2V0DQo+ICAgCQkgKiBmb3IgdGhlIGR1cmF0aW9uIG9mIHRoZSByZWNvdmVyeQ0KDQo=
