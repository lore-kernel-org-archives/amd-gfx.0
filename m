Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1A7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 14:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F28E10E343;
	Mon, 21 Feb 2022 14:19:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D66B10E32A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 14:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awxznRZRlTdk5Qg/xpjdyKHsWg0rim1ZdWNxMfSsUkpJivYw9tFd9TsKkdE8kA7ACPFHe3aXW9ykG2kRwl3CqWoznyJBRazGR5f7pVZHRm6TEGW4pCRyhwbCVIY/JHMHr1QPoYQbI8DANn3iwPaB2RseHcsg0e624RuRr3A/ujzRhH8I7Rf4xuDaRTGphXVk/6ETL+JbDGlr7NeGqj2/CTNkfbymIVDOgSi21xHT7MlaZkGfd3DbGBwp2GlbvZI8YlnM8tUtkCdS17XMM9lB7B9rlbXdrvc07jAhA6nv+d0edRXsZyKrZDwAzSdLusqaFebQBN/9XyZqg1iYXpX8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+BzlNg5p3VmszjxeEt3Jfx9BBG5svo/7ZTmhiN/5+Y=;
 b=U8SsqNhjskpPvhkECJKXKwf3zd7qQNrKFoIo3TZgkbCaeJZPqzRXHLR16TyhgegxIl1itTHgly235DnDrzavtbLvr2+n7+2Oxm0E+R0JZh5fMsgIgbLbAffFfBIxJ/PK9RfbQIqrPJhE4moFyEvCiUBBjFkbs4jVgVp6eMbSDO3inuODjBPIOytqLB6bI95EKiRyPDDZnoozOvNSV+aUHn40xnAhfroF3IMy/4IDthRZ9c9GGnFS3ageTs9A3g4nblYv4I3isHkbvJ0S42ea+n9mFh/krSnSu6+Xr1BdBiAybFl9pbFG0TgLTOwBybPe38ltC6flapQ5PXe2PfA4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+BzlNg5p3VmszjxeEt3Jfx9BBG5svo/7ZTmhiN/5+Y=;
 b=oYkHpboQJDrZIfkZP14TRqhZXgJj1sYeTqWyt9kIQPxEN7toT6XYvE5Q5iAfMFP5MRPjMjO3SzwhTKWy8pp9hAeSJkropMe01L2N1Xd4b2jLacNEv32l9nHjTOoKHF7ICbwNYgDr5900QCrx9Cbm6gTovwG4ynfikw+/MmcXdPs=
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BN6PR12MB1410.namprd12.prod.outlook.com (2603:10b6:404:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 14:19:50 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 14:19:50 +0000
From: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Somalapuram, Amaranath"
 <Amaranath.Somalapuram@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Thread-Topic: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Thread-Index: AQHYJyfHx5GV2l/mUUKoTOH9APF0iKyeArCAgABnIgA=
Date: Mon, 21 Feb 2022 14:19:49 +0000
Message-ID: <DM6PR12MB389730FB7E38A62EA781C141F83A9@DM6PR12MB3897.namprd12.prod.outlook.com>
References: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
 <3a66af2c-edd2-cc0b-1caa-8fa989b94a02@amd.com>
In-Reply-To: <3a66af2c-edd2-cc0b-1caa-8fa989b94a02@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-21T14:19:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f0bdce0d-6fac-483c-b2ba-eaa6219a1b95;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-exchange-imapappendstamp: DM6PR12MB3897.namprd12.prod.outlook.com
 (15.20.4995.027)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db42f89b-f0ab-4c49-dac5-08d9f54538a9
x-ms-traffictypediagnostic: BN6PR12MB1410:EE_
x-microsoft-antispam-prvs: <BN6PR12MB141018E2C29EE35EE7F8998DF83A9@BN6PR12MB1410.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAYHYi18PhnrDNmbv7kk59Un2qrpH95Xdpgy9cEWSY3nKJa1gN1YbMwOa1Fc7c6OcJkqYnx3rO/EAeRpoYUcs6qUw+vsJl9YynbhprX8Vn7n35/4Ln41mBQwPZF1JFwjJyb3y5bdhInrHBESDhDB8vM6fNr7Mmf6oCfybjbyPflFqBF2n1UyM0odtfJQKRzRbaipt3Z+L3M2NsNrCLr7mEaA4A/gnGqkPg858lP9anSS40FmrMn2tNJkaTokRgUqf3GieLxMGDYOyb9cZHbZ69PyDTjWkdfgewSHotx6/Z8nehVJCRxQXZVXReaCKAFjmZSrGmsx8apeA0RbkQmREFEInUlHJYFEJkr2f+YBk6BznL3SNRvM9sl7SBpsfc75VuVyz+l95sdorlkN9fwwpn2wzQ2WlmAn8xLtyceSiLW7jZziZFpJMyCMoWS3VOXbQfIkWQvMliqMapkkIJhDKUOLeLJ9eEkhrnKosOj1DAfWsGBwiqFd8m1P7dOFsYG5a8RV/rLt2An3uxanwFMYmF7qtVXmkcEy+QWmyx9yrhARl9lua7b3hxJekKKcVsyRCGASzHf3TqjTFFB5Zxtqk7UU3xzQ76dL0YN+mlm4FzuLnnoPK1RRGhhNptccERZq5jbrfPzNGagYBFAaVHaafZIDwowSgbJd1lx9HzNHIdhcSKYEx2rtNJ1nOqydtJCNCeNr6MpVvixPaA4ZKjYy9t6WGwNbBSiqMD5+k4cnWNcEacSxmWZDbhXCR80sanuagxldndPy7CylAQdf3oNR2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8676002)(4326008)(66556008)(64756008)(6506007)(7696005)(55016003)(66446008)(66946007)(38100700002)(76116006)(66476007)(71200400001)(122000001)(52536014)(53546011)(26005)(38070700005)(33656002)(508600001)(8936002)(9686003)(5660300002)(316002)(83380400001)(66574015)(54906003)(110136005)(2906002)(65966003)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjlEVkpseWc1NC9nOXBxYzdxcWIwcUNYKzdLa2ZUdkN1aFpmSmRlRGNKOWwx?=
 =?utf-8?B?NWhibTUzVVZJekFzZ2pUa3MxUi9HTU43Q1g5VmdWaW1PL0lWT0hLOTJhRDRq?=
 =?utf-8?B?VlNZTkdNWHNXZ2lpazJoU2xxMzRIdWpFVkY1d0xzdW5XK09aQjBoem5kNWta?=
 =?utf-8?B?emdFRStQTUhUL201cE9reDZnWkhJVXhPUTZVNXgzampBN0kwU21PUWRsUjRN?=
 =?utf-8?B?UUIwb1dvRUtaYXNTanZVNU1lWmNwMHVBbnAxQkRkcnZNNE42bDdBVFQyeVNt?=
 =?utf-8?B?RFk1b0hWcUtNUi9zaklEa2w3ZEtTY1hXRFhoLzM5MVZWNjJwMWFBeHBqeDkw?=
 =?utf-8?B?Nk5XVXBka2NxYm9vNHlYM1V6dUo3N1Rjd0VDMnNZbkJCcDJxSmNlMVVWaGhW?=
 =?utf-8?B?Ynp1SExia24vSGdqWXlmbWsxWTRsUldoT2k3QzN5eXhwV3JuRDhUZEUxdkJL?=
 =?utf-8?B?bHd0by9ZTGlTZTZPUWtWT0V4YzVoQXQzb1VCZWRmejVTRzhXbS9tLzJHdEQ3?=
 =?utf-8?B?OEtuaExBUm9waGU5NjZ1MjY2RmhOblYrd3FVaTZPZWRLTEltTG9XaFRVTDBK?=
 =?utf-8?B?SlNkUWRsOWNsYndVUU94b1pnTVBpQXkxMXora3JrbFZpWTk0UU8wb3FZQS9U?=
 =?utf-8?B?aWwvNE5rNENTYktCaFVITUw0MWYyUXd3c0p4QTBSbGlpbHViTXQyNXp4QXI3?=
 =?utf-8?B?L214c1NQNk8yVkx4cW5xNXNGQzdyak5nVUgvakgxU1B0Q2dzN0FzR3VaWVA5?=
 =?utf-8?B?VFFMaWwvTkQydnJsMDc2Zjcxem13azdNNE4rQzlkRnpSTTdjN1VxVUpyVTR4?=
 =?utf-8?B?TmFuRlNpUXpmY0ZJUkV6MVVlTXNXcXhJdzZVQitpdElsMkpFT0VVWTJ0UE0w?=
 =?utf-8?B?Y2Y1UXl2RXVlcUZIRDkwaEEzaGlVN2lGNnowbmxxMFJzNllRN3l4Q3IyK3BB?=
 =?utf-8?B?Wmx1cDllakZ0ajBvZWZlNkZWL3JoQ3M4Szk4RWdlRjVPeVEyYXEzR2xwbDBX?=
 =?utf-8?B?SnB2b091NUdoeFdTUy9PN05vb3dSK2V5Q21yWll5TWFQN2R5SW55c1N5cVVl?=
 =?utf-8?B?ZXViVWhqc1lwOXd6NnA5Q3VickQ0U2pDR0hVMDNEZ3R5M3B1bk52bkFZNWRm?=
 =?utf-8?B?ZkVJd2txSXlGSVJvM2kvbEZFOWZlRmxCbVhEaEVuM3NGTWw2K29uMDdOdlpU?=
 =?utf-8?B?N25QeURGeWtTWXRPdjBhVFIxQW9SWkdEaGN5S0UxblBBWjR5eDNPSEJYVTRS?=
 =?utf-8?B?WDA4OW9waloyS01ra0ZNRWdNOFhpOFIvb0QvVFhva21FUlB4VG55TjVMTkFh?=
 =?utf-8?B?THg5MXpyaEJMYyt2Yk1YZmEzc25EZkdBaG1OZDdNZHBaUjVDMHRCQmRqaU9Q?=
 =?utf-8?B?WXZYbjJ1OHZYbjhRWXg1TUhqVUxUcUF2M3lVcWZwdjhMYkFQT0MyVkwzcGd3?=
 =?utf-8?B?SmR5bEkvaXcxWWtUV1VsdkViQ0FKU3BiN2R4dDJEK0JWRzhSWXB2ZVVaRU1T?=
 =?utf-8?B?UHNXeW8vVG8xdy9LclBKcGZFdmFRRlh1N1JCQmduZTJBeGNIeEJFQzVaRG5z?=
 =?utf-8?B?MEk4Uk12WkVSMHdvUkFTSHJnY0orMS9aenVaRHdpV2RyODRiT2lJZ2gwOGlO?=
 =?utf-8?B?OHBuZHhrU1dZaEppb0I5aWUwWmV1TnAxckUyRkJQT1FLN2todm5DdGFybWFT?=
 =?utf-8?B?V3RjRUtxc09ZaGREUWtRSnVvOG5VdElDZFRLQlFtQ3dBZ0JldnM3K0poTFZ1?=
 =?utf-8?B?M2hJMWdJVWRnZUVGcU9TSHZXaW5CdEJaZnJ5Vk5HMnFadnJJYTQ0Q1h3VXRa?=
 =?utf-8?B?UUxWTWQzS0Z4SFA0Q0RlQWN6RFZmelR5Y20wNEhoU2JhSEhhazBGMkM2NldQ?=
 =?utf-8?B?bDRTRHp1b1F2Qi85QzBubjI0Tks0bTh5dnpDeGtXYmdpTWY2ZjFLbm1Rbmlo?=
 =?utf-8?B?dzdLUmVjQ05JZTlOTU85Z0VRTTFYZkJrYU11Y2R5WjdIYmxWWGNCL25mWjNm?=
 =?utf-8?B?Y050WGtrcitwVDZYSE9aWVZCZDhxclpqa285OWUwL2JzUTVwYWZxUTJVMnpR?=
 =?utf-8?B?RTNKZ25iODdrUm0wakRvNC84VXpvN0tidTNvUnBWMkJDV0p3MjErdmZHdUlJ?=
 =?utf-8?B?aGxLSmV2REVjbHpKazdWVlJuaWNKSEhyOVVMLzdCNFJSeHJud2dBTWEwK3RI?=
 =?utf-8?Q?/9eDTvwWQM+bFGIxVpZ+gX4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B80AB466B22E12498710A0663B99E5C9@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db42f89b-f0ab-4c49-dac5-08d9f54538a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 14:19:50.0433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCMKaRhNy9sm2S1QSIOLqO0R0b4+y59U7Aj0JGntVbcbPEVpkdZtEe5G8Y5csx/NN4VvaL1OyzxWVpCaBpkjQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQpPbiAyLzIxLzIwMjIgNzowOSBQTSwgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToNCj4NCj4NCj4gQW0gMjEuMDIuMjIgdW0gMTQ6MzQgc2NocmllYiBT
b21hbGFwdXJhbSBBbWFyYW5hdGg6DQo+PiBMaXN0IG9mIHJlZ2lzdGVyIHBvcHVsYXRlZCBmb3Ig
ZHVtcCBjb2xsZWN0aW9uIGR1cmluZyB0aGUgR1BVIHJlc2V0Lg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFNvbWFsYXB1cmFtIEFtYXJhbmF0aCA8QW1hcmFuYXRoLlNvbWFsYXB1cmFtQGFtZC5jb20+
DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5owqDCoMKg
wqDCoMKgwqDCoCB8wqAgNCArDQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGVidWdmcy5jIHwgOTYgKysrKysrKysrKysrKysrKysrKysrDQo+PiDCoCAyIGZpbGVzIGNo
YW5nZWQsIDEwMCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIA0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaA0KPj4gaW5kZXggYjg1YjY3YTg4YTNkLi42ZTM1ZjJjNGM4NjkgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4+IEBAIC0xMDk3LDYgKzEwOTcsMTAg
QEAgc3RydWN0IGFtZGdwdV9kZXZpY2Ugew0KPj4gwqAgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X3Jlc2V0X2NvbnRyb2zCoMKgwqDCoCAqcmVzZXRfY250bDsNCj4+IMKgwqDCoMKgwqAgdWludDMy
X3QgaXBfdmVyc2lvbnNbSFdfSURfTUFYXVtIV0lQX01BWF9JTlNUQU5DRV07DQo+PiArDQo+PiAr
wqDCoMKgIC8qIHJlc2V0IGR1bXAgcmVnaXN0ZXIgKi8NCj4+ICvCoMKgwqAgdWludDMyX3TCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICpyZXNldF9kdW1wX3JlZ19saXN0Ow0KPj4gK8KgwqDCoCBpbnTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
dW1fcmVnczsNCj4+IMKgIH07DQo+PiDCoCDCoCBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICpkcm1fdG9fYWRldihzdHJ1Y3QgZHJtX2RldmljZSANCj4+ICpkZGV2KQ0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgDQo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4+IGluZGV4
IDE2NGQ2YTllOWZiYi4uNjljMGEyOGRlZWFjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4gQEAgLTE2MDksNiArMTYwOSwxMDAgQEAg
REVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKGZvcHNfaWJfcHJlZW1wdCwgTlVMTCwNCj4+IMKgIERF
RklORV9ERUJVR0ZTX0FUVFJJQlVURShmb3BzX3NjbGtfc2V0LCBOVUxMLA0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2RlYnVnZnNfc2Nsa19zZXQsICIlbGx1XG4iKTsNCj4+
IMKgICtzdGF0aWMgc3NpemVfdCBhbWRncHVfcmVzZXRfZHVtcF9yZWdpc3Rlcl9saXN0X3JlYWQo
c3RydWN0IGZpbGUgKmYsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYXIg
X191c2VyICpidWYsIHNpemVfdCBzaXplLCBsb2ZmX3QgKnBvcykNCj4+ICt7DQo+PiArwqDCoMKg
IHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlIA0KPj4g
KilmaWxlX2lub2RlKGYpLT5pX3ByaXZhdGU7DQo+PiArwqDCoMKgIGNoYXIgcmVnX29mZnNldFsx
MV07DQo+PiArwqDCoMKgIGludCBpLCByZXQsIGxlbiA9IDA7DQo+PiArDQo+PiArwqDCoMKgIGlm
ICgqcG9zKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gKw0KPj4gK8KgwqDCoCBy
ZXQgPSBkb3duX3JlYWRfa2lsbGFibGUoJmFkZXYtPnJlc2V0X3NlbSk7DQo+PiArDQo+PiArwqDC
oMKgIGlmIChyZXQpDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4NCj4gV2UgdXN1
YWxseSBkb24ndCBoYXZlIGFuIGVtcHR5IGxpbmUgYmV0d2VlbiBmdW5jdGlvbiBjYWxsIGFuZCBj
aGVja2luZyANCj4gdGhlIHJldHVybiBjb2RlLg0KPg0KPj4gKw0KPj4gK8KgwqDCoCBmb3IgKGkg
PSAwOyBpIDwgYWRldi0+bnVtX3JlZ3M7IGkrKykgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGRvd25f
cmVhZCgmYWRldi0+cmVzZXRfc2VtKTsNCj4NCj4gVGhhdCBoZXJlIHdpbGwganVzdCBjcmFzaCBi
ZWNhdXNlIHdlIGhhdmUgYWxyZWFkeSBsb2NrZWQgdGhlIHNlbWFwaG9yZSANCj4gYmVmb3JlIHRo
ZSBsb29wLg0KPg0KdW5mb3J0dW5hdGVseSBpdCBkaWQgbm90IGNyYXNoLiBTb3JyeSBJIG1pc3Vu
ZGVyc3Rvb2QgeW91ciBlYXJsaWVyIGNvbW1lbnRzLg0KPj4gK8KgwqDCoMKgwqDCoMKgIHNwcmlu
dGYocmVnX29mZnNldCwgIjB4JXggIiwgYWRldi0+cmVzZXRfZHVtcF9yZWdfbGlzdFtpXSk7DQo+
PiArwqDCoMKgwqDCoMKgwqAgdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsNCj4+ICvCoMKgwqDC
oMKgwqDCoCByZXQgPSBjb3B5X3RvX3VzZXIoYnVmICsgbGVuLCByZWdfb2Zmc2V0LCBzdHJsZW4o
cmVnX29mZnNldCkpOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKg
IGxlbiArPSBzdHJsZW4ocmVnX29mZnNldCk7DQo+DQo+IEFuZCBoZXJlIHRoZSBkb3duX3JlYWRf
a2lsbGFibGUoKSBpcyBtaXNzaW5nLg0KPg0KPj4gK8KgwqDCoCB9DQo+PiArDQo+PiArwqDCoMKg
IHVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7DQo+PiArwqDCoMKgIHJldCA9IGNvcHlfdG9fdXNl
cihidWYgKyBsZW4sICJcbiIsIDEpOw0KPj4gKw0KPj4gK8KgwqDCoCBpZiAocmV0KQ0KPj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAtRUZBVUxUOw0KPj4gKw0KPj4gK8KgwqDCoCBsZW4rKzsNCj4+
ICvCoMKgwqAgKnBvcyArPSBsZW47DQo+PiArDQo+PiArwqDCoMKgIHJldHVybiBsZW47DQo+PiAr
ZXJyb3I6DQo+PiArwqDCoMKgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7DQo+PiArwqDCoMKg
IHJldHVybiAtRUZBVUxUOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgc3NpemVfdCBhbWRncHVf
cmVzZXRfZHVtcF9yZWdpc3Rlcl9saXN0X3dyaXRlKHN0cnVjdCBmaWxlICpmLA0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IHNpemUsIGxv
ZmZfdCAqcG9zKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgDQo+PiAqKWZpbGVfaW5vZGUoZiktPmlfcHJpdmF0ZTsN
Cj4+ICvCoMKgwqAgY2hhciAqcmVnX29mZnNldCwgKnJlZywgcmVnX3RlbXBbMTFdOw0KPj4gK8Kg
wqDCoCB1aW50MzJfdCAqdG1wOw0KPj4gK8KgwqDCoCBpbnQgcmV0LCBpID0gMCwgbGVuID0gMDsN
Cj4+ICsNCj4+ICvCoMKgwqAgZG8gew0KPj4gK8KgwqDCoMKgwqDCoMKgIHJlZ19vZmZzZXQgPSBy
ZWdfdGVtcDsNCj4NCj4gSSB0aGluayB5b3UgY2FuIGp1c3QgZHJvcCB0aGUgcmVnX29mZnNldCB2
YXJpYWJsZTsNCj4NCnN0cnNlcCB0YWtlcyBvbmx5IHBvaW50ZXIgYXMgaW5wdXQsIHRoaXMgaXMg
d29ya2Fyb3VuZC4NCj4+ICvCoMKgwqDCoMKgwqDCoCBtZW1zZXQocmVnX29mZnNldCwgMCwgMTEp
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGNvcHlfZnJvbV91c2VyKHJlZ19vZmZzZXQsIGJ1
ZiArIGxlbiwgbWluKDExLCANCj4+ICgoaW50KXNpemUtbGVuKSkpOw0KPj4gKw0KPj4gK8KgwqDC
oMKgwqDCoMKgIGlmIChyZXQpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9y
X2ZyZWU7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgcmVnID0gc3Ryc2VwKCZyZWdfb2Zmc2V0
LCAiICIpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHRtcCA9IGtyZWFsbG9jX2FycmF5KHRtcCwgMSwg
c2l6ZW9mKHVpbnQzMl90KSwgR0ZQX0tFUk5FTCk7DQo+DQo+IFRoYXQgbXVzdCBiZSBrcmVhbGxv
Y19hcnJheSh0bXAsIGksIC4uLiBub3Qga3JlYWxsb2NfYXJyYXkodG1wLCAxLCAuLi4gIQ0KSSB0
aG91Z2h0IGl0IHdpbGwgYXBwZW5kIChpZiBub3QgaXQgc2hvdWxkIGhhdmUgY3Jhc2hlZCBvciBz
b21lIGtlcm5lbCBkdW1wKQ0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+PiArwqDCoMKg
wqDCoMKgwqAgcmV0ID0ga3N0cnRvdWludChyZWcsIDE2LCAmdG1wW2ldKTsNCj4+ICsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBl
cnJvcl9mcmVlOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGxlbiArPSBzdHJsZW4ocmVnKSAr
IDE7DQo+PiArwqDCoMKgwqDCoMKgwqAgaSsrOw0KPj4gKw0KPj4gK8KgwqDCoCB9IHdoaWxlIChs
ZW4gPCBzaXplKTsNCj4+ICsNCj4+ICvCoMKgwqAgcmV0ID0gZG93bl93cml0ZV9raWxsYWJsZSgm
YWRldi0+cmVzZXRfc2VtKTsNCj4+ICsNCj4+ICvCoMKgwqAgaWYgKHJldCkNCj4+ICvCoMKgwqDC
oMKgwqDCoCBnb3RvIGVycm9yX2ZyZWU7DQo+PiArDQo+PiArwqDCoMKgIHN3YXAoYWRldi0+cmVz
ZXRfZHVtcF9yZWdfbGlzdCwgdG1wKTsNCj4+ICvCoMKgwqAgYWRldi0+bnVtX3JlZ3MgPSBpOw0K
Pj4gK8KgwqDCoCB1cF93cml0ZSgmYWRldi0+cmVzZXRfc2VtKTsNCj4+ICvCoMKgwqAgcmV0ID0g
c2l6ZTsNCj4+ICsNCj4+ICtlcnJvcl9mcmVlOg0KPj4gK8KgwqDCoCBrZnJlZSh0bXApOw0KPj4g
K8KgwqDCoCByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICsNCj4+ICsNCj4+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBhbWRncHVfcmVzZXRfZHVtcF9yZWdpc3Rlcl9s
aXN0ID0gew0KPj4gK8KgwqDCoCAub3duZXIgPSBUSElTX01PRFVMRSwNCj4+ICvCoMKgwqAgLnJl
YWQgPSBhbWRncHVfcmVzZXRfZHVtcF9yZWdpc3Rlcl9saXN0X3JlYWQsDQo+PiArwqDCoMKgIC53
cml0ZSA9IGFtZGdwdV9yZXNldF9kdW1wX3JlZ2lzdGVyX2xpc3Rfd3JpdGUsDQo+PiArwqDCoMKg
IC5sbHNlZWsgPSBkZWZhdWx0X2xsc2Vlaw0KPj4gK307DQo+PiArDQo+PiDCoCBpbnQgYW1kZ3B1
X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+IMKgIHsNCj4+IMKg
wqDCoMKgwqAgc3RydWN0IGRlbnRyeSAqcm9vdCA9IGFkZXZfdG9fZHJtKGFkZXYpLT5wcmltYXJ5
LT5kZWJ1Z2ZzX3Jvb3Q7DQo+PiBAQCAtMTY3Miw2ICsxNzY2LDggQEAgaW50IGFtZGdwdV9kZWJ1
Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgDQo+PiAqYWRldikNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmFtZGdwdV9kZWJ1Z2ZzX3Rlc3RfaWJfZm9wcyk7DQo+
PiDCoMKgwqDCoMKgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoImFtZGdwdV92bV9pbmZvIiwgMDQ0NCwg
cm9vdCwgYWRldiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmFtZGdw
dV9kZWJ1Z2ZzX3ZtX2luZm9fZm9wcyk7DQo+PiArwqDCoMKgIGRlYnVnZnNfY3JlYXRlX2ZpbGUo
ImFtZGdwdV9yZXNldF9kdW1wX3JlZ2lzdGVyX2xpc3QiLCAwNjQ0LCANCj4+IHJvb3QsIGFkZXYs
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZhbWRncHVfcmVzZXRfZHVtcF9y
ZWdpc3Rlcl9saXN0KTsNCj4+IMKgIMKgwqDCoMKgwqAgYWRldi0+ZGVidWdmc192Ymlvc19ibG9i
LmRhdGEgPSBhZGV2LT5iaW9zOw0KPj4gwqDCoMKgwqDCoCBhZGV2LT5kZWJ1Z2ZzX3ZiaW9zX2Js
b2Iuc2l6ZSA9IGFkZXYtPmJpb3Nfc2l6ZTsNCj4=
