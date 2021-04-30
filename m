Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B0C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 01:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C20613B3
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 01:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C20613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D646E409;
	Fri, 30 Apr 2021 01:12:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA0B6E409
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 01:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF8vah9yYmsvT0xwwmr0OUdCE4ACxWQU3Fy6L42q60Q2YfRgAnQrN0azJAWH2h2+x7xq03OkRxYC1/9K3xEeK9bMwd7AyHP4SdW5LjgnTdIfaxGSJQsXUCfMwn0zqt07PaS7j2+//PAdPlonx5FTwVh0pb3B0N2JdRdWRgmEEOUkOq/nyM9hli4QzbvfdPcXNhMt/EQT5+CP1zCVyY521n/Yi3AbsgJ+lOUYSXWyNJ77dMZzjzlVTo30EZHLAe+bExBJwC4m1qfKmue68KzkaCDqswjJJXA/kkTy5AvA18qej8PAk9K14XM9EmomC1sM7qq/s5fP6CW8wi1Pk42qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZG0WbhaVYrJ/j5fwA0Nbwnhmf33qnVEn10s+UiHPg=;
 b=ITIHeVFkyhlz3oHeb8C1D4gRZHYmpl47lUkNR0oIIw0CPSWcr81GAPBotKuF3F3Sc2jvtCxpjyOGXwLducmgfkqLviUNpBZu6PDc4Ydnoyv6dBHm74XNXlvshi+y/6gSSguuPP1sXWDIYlD+zqhlIst05pCxxruqaaoM4DcNEHv/aj/+n4Y8OogPQB5dyoGXa5cW0ZSusE3YL6CW1fbrADrd5e8BS1czBPUzdHEm6R2045z1SxhFyuByiLL0la4TzNVHqqDgKp3/zfaMYpZHxSg80W8qHRbYvaFUf3f6GBUsAEPEymsSNvsygTF4aj5kT/RlMknmH1l8JGtlzHAnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfZG0WbhaVYrJ/j5fwA0Nbwnhmf33qnVEn10s+UiHPg=;
 b=lMNWUu5E9WQT+LGD+69ZL/UhFFZdvUu0jjCASAQ1f4UJ5wRURZfQWshmEakHa3bYmnuEe/I0z8honkmXyiFQTlYFoy1RTF6lNzpuNsjO1IrR1WR+/bBgZ/Hj0gLJ6M8dNyT2tx61FHVXtUrFWZTqeNz27LK6dlUg9mpf+Dk6O7c=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Fri, 30 Apr 2021 01:12:49 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.4087.026; Fri, 30 Apr 2021
 01:12:49 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Topic: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Thread-Index: AQHXPNsdJwQQg7kfg0u/pLaX4dXpUarL/xkA
Date: Fri, 30 Apr 2021 01:12:49 +0000
Message-ID: <73D22904-489B-4F5F-ABDF-EC534F21D9F5@amd.com>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
In-Reply-To: <20210429093609.71616-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5c7ea2b-ee06-4ad9-619d-08d90b75124a
x-ms-traffictypediagnostic: DM6PR12MB4928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49282C53B3A943262A0FAF4B805E9@DM6PR12MB4928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bP33Wfil2iwT7jDx+ocnihEgebmUFxNWhj0Vuc8lut9TmSjjXg7dGMHT6I9fyRjFOcFnU0fkXoNmOFYkw53enfjd6XUpTfunBMTJurQKi15ClFTjjg70xs+yw5aApNMzpnB9M3aTYNIS/xYRze7I6aXEnzuioqIvXQ1EcMUnjXA6+g40i1sO4/en6Uw/VO5ZGvB4tpI+E3td5pU4vfP6VOW1cHfiLiFqD5Q2uyYHPKaaFK7GM6+1D0/RwcBNogEE5NA2/8xA3U8pg9Sip1I4tEX0WMFvN8uMSdm3z7ij5Tp2MxFFznYVNxN74b/fR5QGT/ZLTNl5jv+TfN8eBXicl9pf9HZ73fU4Kk/M0CpteFhICVXDABBEWgDE0wlvQanQesmFBVs9KUE+gu2f02TjQzAlhPgcfxvqPxtNjrmqK6Bpe1k1u+LGQ4Tp4qfDfXH0GLKvGyAUCw792AcjKbV+HUWVXo4VspOh/rKaxeDp3az3+7AIzT59UjQzMZxv92avzDTV+8DNxyqIfOykdDL/JcaHNOoOWvfHmRcdv//KQT8OM0eGqYUrskgsOtVlHgUZtVckKHUBDPJNTbFZ0g2OTFaiYSosVpyYaFD8FO0cJhr6TR5sT+uJxhPhFKc2MJVGntXucAt5Udo4CqlAl8umJrId/Y6Ev1DR4V9RQLkpsxo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(5660300002)(36756003)(316002)(8936002)(8676002)(54906003)(2616005)(478600001)(86362001)(76116006)(66446008)(6506007)(64756008)(91956017)(83380400001)(66946007)(110136005)(66476007)(26005)(186003)(33656002)(122000001)(6486002)(2906002)(6512007)(71200400001)(66556008)(38100700002)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RVo3UW03dzN0aTZXS1dyRFo3MmRrTjVCeWJRaGhTdmR6SUNvbmMvQ2dGV0p5?=
 =?utf-8?B?ODhWUHRoNk9jZzJuM2hta0FJNjExQmliQTlycUxpeEdhRlJpdDZRWXdEOUtv?=
 =?utf-8?B?bFF2MmdLTEtlelJnMkNwSmhXMDhZQStwQmdUT2srVll4TEIxQkRUdmgwUkxZ?=
 =?utf-8?B?TVhWMG9JQkxDazlIVU5vRGl6OXhiQjBHY1FYcGM5Um54VXJsS0MyY0VrUGFJ?=
 =?utf-8?B?akVlMXBVMzRtZlBkSHc0YTVwVzczcFZsb3UwS2pKTEg0OWV4VURSWS9PTTcx?=
 =?utf-8?B?azB6eTdLM0VBTGtIY09jcnlJcGp0Rms1WTJVUEJUZGFiM3ZTYVFUWlk4MzZn?=
 =?utf-8?B?WExYR2pIdzVsbW5TQ1NXVFRrTldoc051MTV6U1lKRnlLaWdHK3U0a2o1WEoy?=
 =?utf-8?B?R2xoSjVMK1FYbUw0NzNMS1E1NHZoU2F3YVJHR3ZBQ0pJSFpVQUUwd05NbHBL?=
 =?utf-8?B?M3VVZEMvNWdwUVROWXlnV3hSVStKVUVhb29QcUU1MGY3NC8vZ3YzR1R2MmFh?=
 =?utf-8?B?RzRMTUk4RWNKOGpKR3czWXlKTFhCRGVsNmszWnNuV2ljVTF3a3VsSVZWMHNG?=
 =?utf-8?B?WEpXT0lLVmpNcVVtS0l4UEJ6OWk1TmU3Z3FiS2hsMER1QzZoMFY1anVGOEZP?=
 =?utf-8?B?Z0Via0F3eUc5TUVvajJ6V0g1RmwzU0NoZ2Y2bnl2M3dDWFllN1pETWFxUENQ?=
 =?utf-8?B?eDJHdi9JdnlUZlZ1OTB0OHZaUi9kWDBoY0poTy93ckpkTERWSGNKd0dLSEhG?=
 =?utf-8?B?SmpyeXlTZ2l0QUh0d1ZtN2N2R25jb3NVd1k4UkFCRDYwQ1E1azc2aVBNTDBx?=
 =?utf-8?B?ZWU3ODZKYTlwMlk4bEZNa1FDT0tBQ2F6cCt2a0R4OC9BQmlIb0NzRHp1STVO?=
 =?utf-8?B?ZlVzWnExSHA3L0RhbnA1djJodHMxUkRCQXBPYlExdjQ2UDRQQnhHRzljMUpX?=
 =?utf-8?B?WjVnZUVPQjgrVW9HUTZlK0ZZb3RUYUpzMWl5eWhsRGc0Vmp1Qks4bkZkZXNP?=
 =?utf-8?B?c1JZNDgrNkNIN0ZUc1ZyN3RrdUV2dUdtYTlIVEFCME1sTzh6MU9DZWgwaXUz?=
 =?utf-8?B?WE9oOW9RYWtWSThkTDRNU25ob29QR0hPRXNlUUJuNnZtRURjNWJsTUJXZzBX?=
 =?utf-8?B?cnZEZElFNHJrc1ZldTJGekhWOEhla1N6NDA3L1NYMnpGMTAxZzFTQ0dlM0hp?=
 =?utf-8?B?dHhBdmJxTDBOS2RKbHhYWitmaXhLWUNlTzJNanpmMkdQQjNmdm9yVWt6c1NW?=
 =?utf-8?B?SjdzM2F0TjBqbzN6OEZ4VXBwWmhqc2k1YVd5dE5nNG14L1FkQ2REc3hnMXUw?=
 =?utf-8?B?THNFWFA4NmMzajhEKzFEWlRTd0pnbkRZZFZuRHVxdFhVOE5LVWo4ODMvUXpH?=
 =?utf-8?B?T2xSWVQxWTNWWmZqWGQvSkpkck1PVjZpQWIzZUpzR1hOekNKaERXVXFCZWlK?=
 =?utf-8?B?azB1WVg0NzRDblZ0TTY3M1pDdExTZjRYRU5tYXhFQmZDN05NMFRjV1dHd2ow?=
 =?utf-8?B?Z1F1SXVBZGRyVjBQTDJPR1JDQVoyTlB5NEZXTVIwb1ppMlF0SEdPaVArMktY?=
 =?utf-8?B?UzZNbGxQK2NrYmtFeVJtTWZadklRNVEvbDVTNFcyKzhEVkZCUU0zVER4Ymlo?=
 =?utf-8?B?Vk85cE1BbncyU2UwZ1g4MlpKckp2T01MNXdkY3VFVExFWm9SOXBUeGFCK05w?=
 =?utf-8?B?Q1hpZEhDd2E4Y0xJMW5CTHM0RUE2SFUrbEdxeThiVmtsTU42bGhReDNtYUNS?=
 =?utf-8?B?aTdrampCU2dJTzZVelYrSVprZklCTW9NVkFmcGhEd1pDMy95VG9vNnVSSXNv?=
 =?utf-8?B?U2Q3b0hzZHZrOHlVbXcxdz09?=
Content-ID: <3AFCB6843D3EB44B904B2147F9C3C854@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c7ea2b-ee06-4ad9-619d-08d90b75124a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 01:12:49.3830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVR9wR8vrfap/bX1sQVl2QESkmKQ5t4znH2Yr1lBYllMANp2UNZ3tXQ4prVogD79
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Errabolu,
 Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB0aGluayBwYXJ0IG9mIHRoaXMgY2FuIGJlIGRvbmUgbW9yZSBjbGVhbiBpbiBhbWRncHVfZGV2
aWNlX2luaXQ6DQoNCglyID0gMDsNCglJZiAoIWFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19j
cHUpDQoJCS8qIGVuYWJsZSBQQ0lFIGF0b21pYyBvcHMgKi8NCgkJciA9IHBjaV9lbmFibGVfYXRv
bWljX29wc190b19yb290KGFkZXYtPnBkZXYsDQoJCQkJCSAgUENJX0VYUF9ERVZDQVAyX0FUT01J
Q19DT01QMzIgfA0KCQkJCQkgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KTsNCglpZiAo
cikgew0KCQlhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCA9IGZhbHNlOw0KCQlEUk1fSU5GTygi
UENJRSBhdG9taWMgb3BzIGlzIG5vdCBzdXBwb3J0ZWRcbiIpOw0KCX0gZWxzZSB7DQoJCWFkZXYt
PmhhdmVfYXRvbWljc19zdXBwb3J0ID0gdHJ1ZTsNCgl9DQoNClJlZ2FyZHMsDQpPYWsgDQoNCiAN
Cg0K77u/T24gMjAyMS0wNC0yOSwgNTozNiBBTSwgIktpbSwgSm9uYXRoYW4iIDxKb25hdGhhbi5L
aW1AYW1kLmNvbT4gd3JvdGU6DQoNCiAgICBMaW5rIGF0b21pY3Mgc3VwcG9ydCBvdmVyIHhHTUkg
c2hvdWxkIGJlIHJlcG9ydGVkIGluZGVwZW5kZW50bHkgb2YgUENJZS4NCg0KICAgIFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQogICAgVGVzdGVkLWJ5
OiBSYW1lc2ggRXJyYWJvbHUgPHJhbWVzaC5lcnJhYm9sdUBhbWQuY29tPg0KICAgIC0tLQ0KICAg
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDI5ICsrKysrKysr
KysrKysrLS0tLS0tLS0tDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCg0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3Bv
bG9neS5jDQogICAgaW5kZXggMDgzYWM5YmFiZmE4Li4zMDQzMGFlZmNmYzcgMTAwNjQ0DQogICAg
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCiAgICArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KICAgIEBAIC0xMTk2
LDYgKzExOTYsNyBAQCBzdGF0aWMgdm9pZCBrZmRfZmlsbF9pb2xpbmtfbm9uX2NyYXRfaW5mbyhz
dHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqZGV2KQ0KICAgICB7DQogICAgIAlzdHJ1Y3Qga2Zk
X2lvbGlua19wcm9wZXJ0aWVzICpsaW5rLCAqY3B1X2xpbms7DQogICAgIAlzdHJ1Y3Qga2ZkX3Rv
cG9sb2d5X2RldmljZSAqY3B1X2RldjsNCiAgICArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
Ow0KICAgICAJdWludDMyX3QgY2FwOw0KICAgICAJdWludDMyX3QgY3B1X2ZsYWcgPSBDUkFUX0lP
TElOS19GTEFHU19FTkFCTEVEOw0KICAgICAJdWludDMyX3QgZmxhZyA9IENSQVRfSU9MSU5LX0ZM
QUdTX0VOQUJMRUQ7DQogICAgQEAgLTEyMDMsMTggKzEyMDQsMjQgQEAgc3RhdGljIHZvaWQga2Zk
X2ZpbGxfaW9saW5rX25vbl9jcmF0X2luZm8oc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRl
dikNCiAgICAgCWlmICghZGV2IHx8ICFkZXYtPmdwdSkNCiAgICAgCQlyZXR1cm47DQoNCiAgICAt
CXBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKGRldi0+Z3B1LT5wZGV2LA0KICAgIC0JCQlQQ0lf
RVhQX0RFVkNBUDIsICZjYXApOw0KICAgIC0NCiAgICAtCWlmICghKGNhcCAmIChQQ0lfRVhQX0RF
VkNBUDJfQVRPTUlDX0NPTVAzMiB8DQogICAgLQkJICAgICBQQ0lfRVhQX0RFVkNBUDJfQVRPTUlD
X0NPTVA2NCkpKQ0KICAgIC0JCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01J
Q1NfMzJfQklUIHwNCiAgICAtCQkJQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7
DQogICAgKwlhZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopKGRldi0+Z3B1LT5rZ2QpOw0K
ICAgICsJaWYgKCFhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KSB7DQogICAgKwkJcGNp
ZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoZGV2LT5ncHUtPnBkZXYsDQogICAgKwkJCQlQQ0lfRVhQ
X0RFVkNBUDIsICZjYXApOw0KICAgICsNCiAgICArCQlpZiAoIShjYXAgJiAoUENJX0VYUF9ERVZD
QVAyX0FUT01JQ19DT01QMzIgfA0KICAgICsJCQkgICAgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNf
Q09NUDY0KSkpDQogICAgKwkJCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01J
Q1NfMzJfQklUIHwNCiAgICArCQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklU
Ow0KICAgICsJfQ0KDQogICAgLQlpZiAoIWRldi0+Z3B1LT5wY2lfYXRvbWljX3JlcXVlc3RlZCB8
fA0KICAgIC0JICAgIGRldi0+Z3B1LT5kZXZpY2VfaW5mby0+YXNpY19mYW1pbHkgPT0gQ0hJUF9I
QVdBSUkpDQogICAgLQkJZmxhZyB8PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJ
VCB8DQogICAgLQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOw0KICAgICsJ
aWYgKCFhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMpIHsNCiAgICArCQlpZiAoIWRl
di0+Z3B1LT5wY2lfYXRvbWljX3JlcXVlc3RlZCB8fA0KICAgICsJCQkJZGV2LT5ncHUtPmRldmlj
ZV9pbmZvLT5hc2ljX2ZhbWlseSA9PQ0KICAgICsJCQkJCQkJQ0hJUF9IQVdBSUkpDQogICAgKwkJ
CWZsYWcgfD0gQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9CSVQgfA0KICAgICsJCQkJ
Q1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7DQogICAgKwl9DQoNCiAgICAgCS8q
IEdQVSBvbmx5IGNyZWF0ZXMgZGlyZWN0IGxpbmtzIHNvIGFwcGx5IGZsYWdzIHNldHRpbmcgdG8g
YWxsICovDQogICAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGxpbmssICZkZXYtPmlvX2xpbmtfcHJv
cHMsIGxpc3QpIHsNCiAgICAtLSANCiAgICAyLjE3LjENCg0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
