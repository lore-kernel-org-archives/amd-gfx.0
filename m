Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63939C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 09:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D89260F57
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 09:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D89260F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A569489FFD;
	Mon, 11 Oct 2021 09:10:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85AD89FFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 09:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR8ZrpVAmqj6cR1SSi/pLKnh4U+Ch0D5/s7c24dkFWIi1ajRAifvPbJlzIZuOk7AKuLno13x9yfn4dAa6RJlhgLO8DQ0H47coM4uBy8ey0UaGSVV8LVGWSMTEFGfyXIT/2ukiPDVrxe9e2TyWGFhCEC/7ZJacLQKd/mSIYMwDJ1VgfOmh806QgMzYf6D3FapFablgB0x018a/eJshG4766orgJM5jDRrTkLU2Lw4TEOzoalI2mRGcRRbLirSEnQOKPARyeh7vDzeE9XBg0w6MYyEeBO9guzjj4/cQZj33O+Xk/uzs5TUHn02ES4JoPopG7SXtxnd+hQSo2G2q3isGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFKJi7sP95hJAgrdp6eLNEnIJULG/0U8ZwrYSxeuSYU=;
 b=aBlmE1zAJ45SOJpK4liTW8lGtJIojL+MvTDG5faiMJ1xIQ+fdENhj6GphSq/CCHn7ulxWk7IDNHTUMS9jJJKMEBhB+qIcM1XYPeLKA/HXbYTYDasqux4vlhTsvDOUEuenOC/+je/n4MmtuenqT/d/f7e/SIHz3t4WSDW/aixn5Ox/MKHpQ/tRl2g/GttjIXbWjm52EiUfoF8SPqxIXztp9eMSv/vDxkTb6PdTW2gYu5w8gccbKdnutX1+qB/teKBY0q2YgA6xKhErOmYfXtr8SbEZRYFoaA9gZT67P/v7cJ9XwRYcmubPaLzO2kPV7T/Hq76VtDjM7AWsFXNOSSDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFKJi7sP95hJAgrdp6eLNEnIJULG/0U8ZwrYSxeuSYU=;
 b=FfXP6iwt/QTjocMx0RSEwH22wwj2ZN8CWCRrFPKjTye7h6zhL6YouDZMfV7bq9dzoFgn0BM4BWvl1U1INi+KpMQ3CDZn/KPDKnO6Ym+QrS+yoOtSQ+tHSMSd+uAGlz8UILu6meIIjYTKceTDZ6F7c2Iuc6DlcmHidE1H4yEo0Bo=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.24; Mon, 11 Oct 2021 09:10:51 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 09:10:51 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish
Thread-Topic: [PATCH] drm/amdgpu: query default sclk from smu for
 cyan_skillfish
Thread-Index: AQHXvnp/LKZGotaDt0WIprQNFBx+GqvNffuAgAAEjEA=
Date: Mon, 11 Oct 2021 09:10:50 +0000
Message-ID: <DM6PR12MB4250E06092041432C1932F64FBB59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211011083147.577024-1-lang.yu@amd.com>
 <53bf0be2-be7a-5a38-4c04-dbd82a928db0@amd.com>
In-Reply-To: <53bf0be2-be7a-5a38-4c04-dbd82a928db0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-11T09:10:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=094e87f3-ca1b-4133-a9c4-f469a740c3df;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62e3278e-14d2-4e01-ee57-08d98c9705bb
x-ms-traffictypediagnostic: DM5PR12MB1434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1434FFC87E1BC20E32945958FBB59@DM5PR12MB1434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE8q91WgbR/ZvEnoDSHH304S8hJOjp8kbOwNbyPGKd/BH5B0GRI3YikfCvUD0EJZ4YCrO8mFkybLVWDK1D0mAPGeK6vsLqP6KOAtIow77PBSftMFvgE7ztEWTFQy/gSbESTM9YhqlVYX+7dlTu59iILUfBoE1DQhmOprewm3Re5NpNyR/zhBTc7MN+SQhwXHU5iuhjufdAVDbF3LgShYwvmazvRBqQ4aKU3CyHocZDwCVEKuLsZDgT6EQOCiyFqa5eghogclMqYL+WPyT0nn8qKy4ZmFfoYmMVvE9GFgV6lPSQz/Clp7zBPtomQDY0KOzA319LSWi6u3BOK7fPFhhD8Usrm9YR7keyzSXe/Tk5eqN7kFD5UvlCH6JRLRqo7Bftxw0qaJ3ndkabwTI7zsVnzSUJXAqNvxdC/xp0e1NYOLSRcOFyqyNtEMnIXe6iZpAlGrZ3gEENMtiOzEUJfUezSbhYB+ZlJ8IhHd7UJwib98uQ5MWAC0D1m2Z2wZZwaLnNjgvWdQWmPKizW/MNuA9xAsSlpETVLgKKWOTxmv3nPOLsP51jnigvGw4lytGt5dtKAlFA4ah6v4ITdXtJbfiuJHVvyNj3nUQ4yveeGxBRjppOTXIe7bTTR1teiBcylCKzS+uDBP09/WcO5BdYOOea+dAmtXHmMXIQNK7JRn9Gmmm2Q5cYKAzcLzZvWCv8UFINHLxn+OhHOg/BDGm6FEMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(8936002)(54906003)(83380400001)(4326008)(8676002)(52536014)(26005)(7696005)(316002)(86362001)(6506007)(186003)(64756008)(66476007)(66446008)(2906002)(508600001)(5660300002)(66946007)(66556008)(55016002)(9686003)(71200400001)(76116006)(38100700002)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djRPeW8vTU5lQ0JqVms2ZE1GT1N3VjA0Q1VkRlZ6MnBzT1pqeVNZT2hXcDZC?=
 =?utf-8?B?OWE5NjQwMzRZSCtLOUNnUUxncWRxL0gyQkdFYWEvWlVVMjVIWjBkRGdsYkRw?=
 =?utf-8?B?MmQ0RXVZUm1wOVFvOFQ4QTJYLzRvMmw2MWVQZjR6dE9nT3VxRTE0b0JyUDN1?=
 =?utf-8?B?ODAxZkpJbDZLZ0ljWHFGUlQvZVVQSUhYdm9KVVZQNE82dWdhaWZMdjJ4RlFh?=
 =?utf-8?B?cDZjVUlkandSbE5OR2R1Zkc0VUZTU3lwZkRlL2RvblM5d1RhbWxoSVc0L2J6?=
 =?utf-8?B?QUpXTEZVNGV1UVNHVGZTMzh0dlJmNUJYeUM2aVEwKzlYbW94RktmbjhGZllV?=
 =?utf-8?B?c04zSWxZTytXb0VJY0lVMmFyR3c2Rk9oTVY5Vlg1c0M5N2RMY1NjbGNoM2Mv?=
 =?utf-8?B?MElLQlZ6TDNEUmxOeUF2alpiWmNCYXVBdzhiSVFqalIrTGRNeEJnM3ZvdE5L?=
 =?utf-8?B?dHd4S1Npempqb2hqVVUvZUp3RDJDUWpNcjlkVWl3bS8rWE9MeVVJWFZLSkFS?=
 =?utf-8?B?TVNhK3UrZWJYN3EyTmtmaXJGZytTYmF3MVlyRjFlck5jYzlyTU5iaVF4dHR3?=
 =?utf-8?B?Y05QVllrSjFYTzBJQVYzM1VnUXYrdC9FMHFjL3U2V2UzREFkMUhSdzVORkxn?=
 =?utf-8?B?dUlqeHVkdU84MFE4WEJ2UjgrR1NQbVk5ZFg3VFNyVm1GWnNtVFFGNHhMSHY0?=
 =?utf-8?B?aUZpay9lZ1pMaUs5b2YzYzFMdFJ6THN4RDNvZUNBS0N3aHFERjVXM2V2cVVC?=
 =?utf-8?B?UFVNamhMdmo3VWVSb2FTZWdZUTM0OGVreXVMMEtvakVDM0FDMUJoNG52MkFG?=
 =?utf-8?B?SDVqYk85QU9iVjA5SUJjR1RnNUlwelh4aU8zbHR4UWZZMWVMR242WEZTUHA5?=
 =?utf-8?B?NXZ3UytkRWNsRVhRQ1JQd2QrVTNzS2FCSkgwVVk2eVFTbFNLZVRYc0p3NmhK?=
 =?utf-8?B?T3pNY2FUM0FPMEJzaGFtTkZiS0hqRHprbnZ5UG4rbkcya0tYRHkrMG90Z3Bn?=
 =?utf-8?B?QWd1WlZ4bnZmNXFMY25VMlptakwzbUU2QTEwSUkwVXJEeGpNTTB2KytVaGFQ?=
 =?utf-8?B?bTh4ZWVKdnhWTnVGRGpCYWQrc2VjYlFHcTBYNllHT1FSU01neSthLzZyRjJ0?=
 =?utf-8?B?M1JvU3pka0JsbXU0YkNYNytzd1pFU1lXTVNxRVdSTjFIckJvVllUSXdXNU1i?=
 =?utf-8?B?WVE3VnFsT01LN09mb29pWHVuS1ZZWUEwSWczWUNtQ04rL0Q1NWx1Tm1PanFm?=
 =?utf-8?B?aXVHL2FGTDhKUlN5Z3FmWldtcGxNNnZOU0k1T0x4aTAvR1VwMldhWis0YjRZ?=
 =?utf-8?B?UmpxaDdvRnBvT3FqMmZWVU9KbStPYkU0SWhuUDQ3ZkNQQXl2UFJUYVVIQjcw?=
 =?utf-8?B?TzRXVXVaWWU5MG1GOHBzT3UvTEd3KzdhYnA2Qk8vRExQR3MzZ0N3NjVVc3Ju?=
 =?utf-8?B?ZXE1VWdDSkZTcUJxUUxqRDIyZU8xeCt6bWIwRmJIdU9Edm9RK2VYQS9aQlM3?=
 =?utf-8?B?OG5adUJtZWZPQ1FiM0JWUTEya0N5eWxWSFF3dFpQT0JPMFM0V2FJS0FtdTJX?=
 =?utf-8?B?QTFSOFAreis4MDRlTW54TS9SWFBEZjFHazg3TlN2TWVEbUxselordEtPU2Yv?=
 =?utf-8?B?Zm9jT2ZlOEVGa25uOXMyUjExTTV0TzJMMjdBbHFubCthd1pQYzJVOTBhNjdq?=
 =?utf-8?B?Ylg5cTEzWWdzdzc5T2JablgrQlJkVnRqbGQrUEpjeXg4ZTJuYkRHUVlsZ21L?=
 =?utf-8?Q?84uGXxDy3rdsJAATuf57Ubzj7uwP6vOKf8NT0PW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e3278e-14d2-4e01-ee57-08d98c9705bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 09:10:50.9347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VI4tfP6xZyi3Mfy+rMxhPpQECDZhgKwcYfZGLkH/3w3JpaYaV7dOIBkm8hlIUcaU5A8YMjFhh108eYuMG2nwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+U2VudDogTW9uZGF5
LCBPY3RvYmVyIDExLCAyMDIxIDQ6NTQgUE0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5nQGFt
ZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcXVlcnkgZGVmYXVsdCBz
Y2xrIGZyb20gc211IGZvciBjeWFuX3NraWxsZmlzaA0KPg0KPg0KPg0KPk9uIDEwLzExLzIwMjEg
MjowMSBQTSwgTGFuZyBZdSB3cm90ZToNCj4+IFF1ZXJ5IGRlZmF1bHQgc2NsayBpbnN0ZWFkIG9m
IGhhcmQgY29kZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFtZC5j
b20+DQo+PiAtLS0NCj4+ICAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5fc2tp
bGxmaXNoX3BwdC5jICB8IDEyICsrKysrKysrKy0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5fc2tpbGxmaXNoX3BwdC5jDQo+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvY3lhbl9za2lsbGZpc2hfcHB0LmMNCj4+
IGluZGV4IDNkNGM2NWJjMjlkYy4uZDk4ZmQwNmEyNTc0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9jeWFuX3NraWxsZmlzaF9wcHQuYw0KPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9jeWFuX3NraWxsZmlzaF9wcHQu
Yw0KPj4gQEAgLTQ3LDcgKzQ3LDYgQEANCj4+ICAgLyogdW5pdDogTUh6ICovDQo+PiAgICNkZWZp
bmUgQ1lBTl9TS0lMTEZJU0hfU0NMS19NSU4JCQkxMDAwDQo+PiAgICNkZWZpbmUgQ1lBTl9TS0lM
TEZJU0hfU0NMS19NQVgJCQkyMDAwDQo+PiAtI2RlZmluZSBDWUFOX1NLSUxMRklTSF9TQ0xLX0RF
RkFVTFQJCQkxODAwDQo+Pg0KPj4gICAvKiB1bml0OiBtViAqLw0KPj4gICAjZGVmaW5lIENZQU5f
U0tJTExGSVNIX1ZERENfTUlOCQkJNzAwDQo+PiBAQCAtNTksNiArNTgsOCBAQCBzdGF0aWMgc3Ry
dWN0IGdmeF91c2VyX3NldHRpbmdzIHsNCj4+ICAgCXVpbnQzMl90IHZkZGM7DQo+PiAgIH0gY3lh
bl9za2lsbGZpc2hfdXNlcl9zZXR0aW5nczsNCj4+DQo+PiArc3RhdGljIHVpbnQzMl90IGN5YW5f
c2tpbGxmaXNoX3NjbGtfZGVmYXVsdDsNCj4+ICsNCj4+ICAgI2RlZmluZSBGRUFUVVJFX01BU0so
ZmVhdHVyZSkgKDFVTEwgPDwgZmVhdHVyZSkNCj4+ICAgI2RlZmluZSBTTUNfRFBNX0ZFQVRVUkUg
KCBcDQo+PiAgIAlGRUFUVVJFX01BU0soRkVBVFVSRV9GQ0xLX0RQTV9CSVQpCXwJXA0KPj4gQEAg
LTM2NSwxMyArMzY2LDE4IEBAIHN0YXRpYyBib29sIGN5YW5fc2tpbGxmaXNoX2lzX2RwbV9ydW5u
aW5nKHN0cnVjdA0KPnNtdV9jb250ZXh0ICpzbXUpDQo+PiAgIAkJcmV0dXJuIGZhbHNlOw0KPj4N
Cj4+ICAgCXJldCA9IHNtdV9jbW5fZ2V0X2VuYWJsZWRfMzJfYml0c19tYXNrKHNtdSwgZmVhdHVy
ZV9tYXNrLCAyKTsNCj4+IC0NCj4+ICAgCWlmIChyZXQpDQo+PiAgIAkJcmV0dXJuIGZhbHNlOw0K
Pj4NCj4+ICAgCWZlYXR1cmVfZW5hYmxlZCA9ICh1aW50NjRfdClmZWF0dXJlX21hc2tbMF0gfA0K
Pj4gICAJCQkJKCh1aW50NjRfdClmZWF0dXJlX21hc2tbMV0gPDwgMzIpOw0KPj4NCj4+ICsJLyoN
Cj4+ICsJICogY3lhbl9za2lsbGZpc2ggc3BlY2lmaWMsIHF1ZXJ5IGRlZmF1bHQgc2NsayBpbnNl
dGVkIG9mIGhhcmQgY29kZS4NCj4+ICsJICovDQo+PiArCWN5YW5fc2tpbGxmaXNoX2dldF9zbXVf
bWV0cmljc19kYXRhKHNtdSwgTUVUUklDU19DVVJSX0dGWENMSywNCj4+ICsJCSZjeWFuX3NraWxs
ZmlzaF9zY2xrX2RlZmF1bHQpOw0KPj4gKw0KPg0KPk1heWJlIGFkZCBpZiAoIWN5YW5fc2tpbGxm
aXNoX3NjbGtfZGVmYXVsdCkgc28gdGhhdCBpdCdzIHJlYWQgb25seSBvbmNlIGR1cmluZyBkcml2
ZXINCj5sb2FkIGFuZCBub3Qgb24gZXZlcnkgc3VzcGVuZC9yZXN1bWUuDQoNCkdvb2QgaWRlYSEg
DQoNClRoYW5rcywNCkxhbmcNCg0KPlJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFy
QGFtZC5jb20+DQo+DQo+VGhhbmtzLA0KPkxpam8NCj4NCj4+ICAgCXJldHVybiAhIShmZWF0dXJl
X2VuYWJsZWQgJiBTTUNfRFBNX0ZFQVRVUkUpOw0KPj4gICB9DQo+Pg0KPj4gQEAgLTQ2OCw3ICs0
NzQsNyBAQCBzdGF0aWMgaW50IGN5YW5fc2tpbGxmaXNoX29kX2VkaXRfZHBtX3RhYmxlKHN0cnVj
dA0KPnNtdV9jb250ZXh0ICpzbXUsDQo+PiAgIAkJCXJldHVybiAtRUlOVkFMOw0KPj4gICAJCX0N
Cj4+DQo+PiAtCQljeWFuX3NraWxsZmlzaF91c2VyX3NldHRpbmdzLnNjbGsgPQ0KPkNZQU5fU0tJ
TExGSVNIX1NDTEtfREVGQVVMVDsNCj4+ICsJCWN5YW5fc2tpbGxmaXNoX3VzZXJfc2V0dGluZ3Mu
c2NsayA9IGN5YW5fc2tpbGxmaXNoX3NjbGtfZGVmYXVsdDsNCj4+ICAgCQljeWFuX3NraWxsZmlz
aF91c2VyX3NldHRpbmdzLnZkZGMgPQ0KPkNZQU5fU0tJTExGSVNIX1ZERENfTUFHSUM7DQo+Pg0K
Pj4gICAJCWJyZWFrOw0KPj4NCg==
