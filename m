Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE15C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 06:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B61B10E6EE;
	Fri, 18 Nov 2022 06:50:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC41510E6F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 06:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMNdVSZ7Jq2VfSaHJjS8XgBvURZfdlfRoIT+Y8b61qVsQ64igwczMC4jfhN7313Oc4GJZkgAfPBB62MS7jq/r6/aJN7pUjtlCfL9heZzOb4ONQF2JH8Q5l6UtRyVJaf7P2t6czC/Bvw79re7Hvy9UEvuRO1BQ6tqK2S2aGjFeufEftiBVydJiuILAHrfXzLmKfBcyqaUjnG7dIHFc3gxSC10/DP0P62+wxF/vXHkjcD/xOobh4+9fdQmcu+neLZKroio0w5vgS03Wq71D0hWV/hAYGvps3sOZC8FQarmLuMwm0LIqHi+8mmQzlc8VvPbu0gkRRyd8DVf6BzV440s0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y8nwAQBK0TPoCSMuMWr0qOfJhiNfOteQ1D9HKSdTYs=;
 b=nWt1maC5Pxk2PGNuFQFdmoWpm7Nn03McIYBoWw4u3v+FSWPf30E1vwrHL7s2LhTMRE20Z0QY7zQxvzGRYQsCPE1yghDQePch1zDmiG5MAeOtpaWxGNptjsE6goCeEpGSfEJJbqgAcg9nfYpPjiYd+41eJwI/4FSC3q8E+VQmp50qECoNTu4qMurGvj3k7Un+tukf2HNRWXDGGwV4Dr+3NopjNEctGuELnOB0M9GcUQf1EKk4VTANVr2qyORPhwakv9MYzmJpM80KUsoxH3RW1InaWqdpFLX6C8uxWVwWe77spgEyBGg1Mr5vAJc12DWX2TUaLfkH2b/uvz3Q48GEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y8nwAQBK0TPoCSMuMWr0qOfJhiNfOteQ1D9HKSdTYs=;
 b=yhBzANkz8AQSVXusYsn5KUha9qWKzLCeuhA6XKQSb/Q2XE2VtbymqZpS3/eb+WOa5jdmX2httDU6U+4WrdnIg4fDsBwCX6eNB9ZWAfzhU4NMDBkKQjKAlFXOtgba/qMRLiHRPVUXmPY8Me9eEoYaoSvo8MZXGqMzd3SrUVU0Z+c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 06:50:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677%8]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 06:50:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Xiao, Jack"
 <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for
 firmware
Thread-Topic: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for
 firmware
Thread-Index: AQHY+mTEAajZ+OSY5ES/h5hVezZmy65C6R2AgAFWC7A=
Date: Fri, 18 Nov 2022 06:50:24 +0000
Message-ID: <BN9PR12MB525719C92C3689AA15D13DBBFC099@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221117091119.106597-1-Jack.Xiao@amd.com>
 <dbdf8cef-f075-80cc-90e6-a38b61f179eb@amd.com>
In-Reply-To: <dbdf8cef-f075-80cc-90e6-a38b61f179eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-18T06:50:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d5c8dc7b-f510-4e58-8791-8ce8b5016fad;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4051:EE_
x-ms-office365-filtering-correlation-id: 3ae7dc85-1631-47dd-92de-08dac9312bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBCXSVPTNyjUCrOv7Z6Yq6JNnpEltmCJ816g48iA/G9bmPxc8IwgYlqIOKzdJQNZxa40K6nZpojTSNthjoBIo9kpLPsRiDlYjjVVHTiuUOiK2l7YxEI1nPHl/2D8ipxcVc0kJ9EiFXuJbmoZ5PgedHs+9C8a5AlL6IfjhAjzyLWOD66qtMwtol5N/CR2O8thsd6P/ykqzcZP3y53blw2goL1QQkUbn2yMXp4DG+fut48D/+k8IetWJGSqUMR464sjvhElf85RwrmVMtBnhvl3LLZxfZuaeCcrK6M4WWqrWhIspqtfmo4RtTIbExVXQlqQA6cpmRxeD8lkWL/FB27/BJO6oxYy5rPqxTuYk/rNsNc3BtZ4+ogTH9etjdeNqMq49S0ZWAiumSNHkRHPTPeP+66VZrckrjDoIb9Oj7FRIHSUROics9l51OlTy1DSzFD2zT5MeTYml2jawNbLQ3Vh8AjMwQCGr0e+Oul1jL/Gowy+c5ebD9nmBa+94tgYvRMDIet8D4ozyul+lcDCxVpOf93WXeSriVP8FSRTn7s7QRGvSxhiVsO7xkhJxc7fRTfB/BflQ1nSGFwIL5XuViXwoYa6W3pM0w2iv8d8WF0vF0KfbpQi2EFLP6WR+EBQE3+HebXxu8ks53RNz4ApwcTWATFcVKtRCroW2kwprh0PkZj8k3ng+KcYQkKe7JwZb2+gCb+HiKZzIH17WHAArB6+BdTiD8GDtB274AG9UF9bfo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(66946007)(76116006)(86362001)(33656002)(186003)(41300700001)(66446008)(66476007)(64756008)(66556008)(9686003)(8676002)(5660300002)(52536014)(8936002)(71200400001)(478600001)(316002)(55016003)(6636002)(53546011)(110136005)(122000001)(7696005)(6506007)(26005)(921005)(38070700005)(38100700002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3QwTUJ3dExaZEgxM1YwQ0luam1zSk53bkdXT2ROWWtRSlZabEpDVnZXYy9m?=
 =?utf-8?B?bjVQcjBRMkwvbGVMZFRRaXNYTklXdkJVajNjUGR5Y2tFcTdHTXowUkp1a01C?=
 =?utf-8?B?TEwya1AzaEJEQURJUm9MVWdUZlpjeWRIaWlKUE5IeHhlckdyV2lRTXlwTGRD?=
 =?utf-8?B?aXk1T1lRWE1WZHZUVFlRL05jM2tDYkVXbXJaaWVJS0dZaWloWjJwZUZoUXJY?=
 =?utf-8?B?d3kvbklqU3ZtTW0wcm5sbXJuWHNCY3B2YkRLMWVZUEE5ZTA3UGkrV3hDYUlq?=
 =?utf-8?B?YXF3T0dFSXpmYXpoSE1uZXk5cDdiOUNrOEo0ZlpBdURhdlEremh1emYvcDU3?=
 =?utf-8?B?dVRqYjRlOUdUVnNSaW9QbFV2djlzaFRuTXZwRS9TR2M2cTh1VnFHUXBZTUlP?=
 =?utf-8?B?Y1lLblgrMDhtL3EzSU9ONzB2S3VFZ3UyU2YyWmpYazlHcDZSSklwN25uSXJS?=
 =?utf-8?B?MkRrdU5qYmY2dCtHR1QzNDA2dTljZkJSaTBSejVVVWw4TWo3dktUaC9CREVL?=
 =?utf-8?B?WTlTdGh6VVpCUjNKMldSY0p0dkpJVEpuNU8xVE5BNFZIb1NHSlFFY0JETWls?=
 =?utf-8?B?ZXBiNGJDcG5WSGNBdFkzZU1zQkJRYlZWNDZZTTJWaXZjKzFpMS9HcG5NWWEy?=
 =?utf-8?B?TjlpQ1FsZDVJYkwxM3JFS1NzSXhxQ2JUS25RWHhiY0doNHo4UGlodGZ2cFVQ?=
 =?utf-8?B?RmJEUTBtcGxIWW0xK210UDVxRWRRWjVudENLKy9VeUdjS1ZyVms1ZW9BaGhR?=
 =?utf-8?B?eHJ2QU1OTmduMlNRRHBiemVLdVJid2VwSjFuTnpyNUFFMExuL3JNUVo3bkY2?=
 =?utf-8?B?SXNvQStONm52dnlGTW00aVdSVVlmWE9NYjNwUUxmQnhFRVVyYmhMTGU5N3pj?=
 =?utf-8?B?cXZldUFIRmFlWlc3cDRSZmNXdGI4amhhR3k4VGVCcWt6RXRya0dwemdHckh0?=
 =?utf-8?B?N1VSVGhsV3UrZ3NFU0xwalVGZUt5K1RXK0V2eHBiQkI0MkZPZjZpRXg5aE9H?=
 =?utf-8?B?Um5oWUpUamtPZnhXaFhSaU9zYWZGZkNTS3RXZUhLeWVacVZKMXhnYXdQKzJU?=
 =?utf-8?B?OGNHUUxYdEZPNk1odkg2aHZrMWhyZkllaGlPNVRaVFZMQ0pDeEJlNEhpb2xl?=
 =?utf-8?B?aGFuRjFNdUhsNWc4ZDF3Ky82TmFCM241c3AvRkFleVhnVXZKc3VZU3pmQVp1?=
 =?utf-8?B?d0tiL3pHWFNtanF4LzUzRGZ0RW5DNmpaZTBjVGJpVkltcFhUZ25XM01rclAy?=
 =?utf-8?B?YjVyczhhWVJ3RmN3TW5jdTI5eWF0OUg5WmcxOSt3N0YrQU5ISjNYbC81eG1s?=
 =?utf-8?B?TC9QbTJ3S2xSakl3djBSQkFjd0F2NVNxV0NYbFZUTnoxSy9YNTRyYkxxQlhW?=
 =?utf-8?B?VHBlYWFSRjlybDNJM2R5bjFIZUhURkd6RzcvRUJDVjg1bTNGWDFDK3B2MXBp?=
 =?utf-8?B?UmorWjkrdHEwaU5xekRSZno5SDVaeVJhZTl0RGo1MjZvOVJoZjNMYlJmdFg0?=
 =?utf-8?B?dEJqTzc1ajd1Zk8yS2V3YU4zdWdob0FmUkxWNzg4MEpRUURTVlNqWlZOanJa?=
 =?utf-8?B?T0pOd0lpWXRxQ0hBa2NyV2dwc3VjaDJIV01zTXB4KzByNUtTSjJVSENTQlhV?=
 =?utf-8?B?Y3hLU2kxUFZYb2thMWlBUlJReXgvRGFORUxZZFlKR0xBWCtmZWs0QjI5SHVF?=
 =?utf-8?B?ek9wYzF3MmRKWXk2MkRBeEtXaW9KWHhXMG1LRFlENWtUR3BXR3pIemZ3R012?=
 =?utf-8?B?WFB6NDV1d1Z5UnUyL2FUV1FDZEFGaTA4dCtDTnJ3ZW9XRmVZdGlXVzJrMFFu?=
 =?utf-8?B?djZIVEVOaGxweXk3c3VXY0JyVC9jUUhyQ3lVNGw1ZGI4Vkd4TVJhVzkzbkxX?=
 =?utf-8?B?UGJWRlhMaTRtVjlLWGNZMWtQS0k3V3hxYnVvQzM5aFpzNW9UVHluaExYOElM?=
 =?utf-8?B?NFVONGFsbFgyT09Fc0VzdXV0NURnaDdIcmdsSWZxQnVFZ0xSZnp3WWgwNUdt?=
 =?utf-8?B?M1V0eGV6NDU3cnVQazAvVmg0bXZGQnk4UzUwWVBsVmw5VnJqKzVvQTR6dUVS?=
 =?utf-8?B?SVIwaWpPMC9BWFVUTTJDVWdlVmluWG55YTFSNGlDUldvNy9zUWJiaFIxWSt4?=
 =?utf-8?Q?5hiy+ght7XCjmUqNqHSgyz9Kz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae7dc85-1631-47dd-92de-08dac9312bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 06:50:24.9123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeckDa922vxnhVYq/yaduEyPjoWMG+L60b6xAm0Wr0JGZgJp3u8UA2CfrWCfGZi3FL/ZudpukWGNtyDGBrNDtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgaXMgZml4ZWQgYW5kIHJl
cXVlc3RlZCBieSBmaXJtd2FyZSB0ZWFtDQoNClJlZ2FyZHMsDQpIYXdraW5nDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNywgMjAyMiAxODoyNg0K
VG86IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGlu
aHVpLlBhbkBhbWQuY29tPjsgU2lkZXIsIEdyYWhhbSA8R3JhaGFtLlNpZGVyQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogcmVzZXJ2ZSB2bSBpbnZhbGlkYXRp
b24gZW5naW5lIGZvciBmaXJtd2FyZQ0KDQoNCg0KQW0gMTcuMTEuMjIgdW0gMTA6MTEgc2Nocmll
YiBKYWNrIFhpYW86DQo+IElmIG1lcyBlbmFibGVkLCByZXNlcnZlIFZNIGludmFsaWRhdGlvbiBl
bmdpbmUgNSBmb3IgZmlybXdhcmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFj
ay5YaWFvQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuYyB8IDYgKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBpbmRl
eCA0MzY1ZWRlNDI4NTUuLmU5NzBlMzc2MGNlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBAQCAtNDc5LDYgKzQ3OSwxMiBAQCBpbnQgYW1kZ3B1X2dt
Y19hbGxvY2F0ZV92bV9pbnZfZW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAl1
bnNpZ25lZCBpOw0KPiAgIAl1bnNpZ25lZCB2bWh1YiwgaW52X2VuZzsNCj4gICANCj4gKwlpZiAo
YWRldi0+ZW5hYmxlX21lcykgew0KPiArCQkvKiByZXNlcnZlIGVuZ2luZSA1IGZvciBmaXJtd2Fy
ZSAqLw0KPiArCQlmb3IgKHZtaHViID0gMDsgdm1odWIgPCBBTURHUFVfTUFYX1ZNSFVCUzsgdm1o
dWIrKykNCj4gKwkJCXZtX2ludl9lbmdzW3ZtaHViXSAmPSB+KDEgPDwgNSk7DQo+ICsJfQ0KPiAr
DQoNCklzIHRoYXQgZml4ZWQgYW5kIG5haWxlZCBkb3duIHdpdGggdGhlIGZ3IHRlYW0/IElmIHll
cyB0aGUgcGF0Y2ggaXMgcmIgYnkgbWUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gICAJ
Zm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV9yaW5nczsgKytpKSB7DQo+ICAgCQlyaW5nID0gYWRl
di0+cmluZ3NbaV07DQo+ICAgCQl2bWh1YiA9IHJpbmctPmZ1bmNzLT52bWh1YjsNCg==
