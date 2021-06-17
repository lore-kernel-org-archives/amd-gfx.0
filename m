Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05023C49361
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 02:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C0F613E1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 02:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C0F613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F3C89471;
	Thu, 17 Jun 2021 02:38:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE10689471
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 02:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvKJ4B4S4fr4ZH41wpX6Wz+0N7EZaC84Ra872x8oLv/klBkL1jySG+JR5ARw01mdvsPV1Q1+pPQo5Ma307dMtiP375xCn2P70xZ8uqHlHVS4JsxE2oW0TG0+JzvCUQGdMB9qijIj+O1thWS/silSDrGRF5qMFo2SFKul5nMdeMCwzhF6bnjANyiT6lS6aLVNVjzLCuxR3FEKm60acTdZKB8FbVlF8mfVTIiAMetS+RZZJe0w4GilBc5fPHHH1Zqt50Tkw20A3EvECb31TmR/BymJvwbh7Ce8rd8GjSEpYF6Ey0TgyJez2o6BNV5eJPPhVIYuVSrNbkT0Fz6hhmPHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1vFYBjByr5IECCDp7HsfoPUK5ToH0LuESm5YdMBDhc=;
 b=mxFvhtEMKmdq8+yIWFGob6J5J2f+AJhu47EaaiGdoBpQEa6ReK93obAdjyUtfaz4ZzBtCF9lECuEXdjjnpdOfqAlbInsSRkAAJgqJVSq/Z+YFdXn+8Ec5nX7w4eb0GAfdcpRQSVrFKR6ZKylXPjACEFmO2xJb6mS6xYoQeu3MTS/DGWxPDzbetxdzf4ksqxds+A+h8/XQYoyMVWCb44426vT2nxsoGw7wDcqZuh9QqmI7LFIhXbNyPh9igc+8t/vw1I6UPpWLgEZsqChP+DAE4FzuqxwQhPvpjSE9CIVi/qzVr0Wmytm8NdRYVXGoLSDgTp2uJO5SkkzjqUtTnlD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1vFYBjByr5IECCDp7HsfoPUK5ToH0LuESm5YdMBDhc=;
 b=rC7VLXpD4WXjrCwfIxYOu3xyU+tSFk7Ewea2tD2hlM7p/MX+dnNq8oATP6oYXK2U/SSzKtGNbzpoWScVmwyF/GfQkMP5B4swOk1t6E1SYd0Euq94xyxu2y+zAop4yHDVOWXxRuz247lPhHiFnTVWTFs/UCxbEiw0IK8P27sTRx4=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 02:38:39 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%4]) with mapi id 15.20.4242.018; Thu, 17 Jun 2021
 02:38:40 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXNldCBwc3AgcmluZyB3cHRy?=
 =?gb2312?Q?_during_ring=5Fcreate?=
Thread-Topic: [PATCH] drm/amdgpu: reset psp ring wptr during ring_create
Thread-Index: AQHXXNvhZqNpjRY+PUextJk28CKASKsXiffQ
Date: Thu, 17 Jun 2021 02:38:39 +0000
Message-ID: <BL1PR12MB52694DD1921E8CB71B365DF4840E9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210609030145.1215878-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210609030145.1215878-1-YuBiao.Wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5578126a-78e2-44d8-8c2e-a24201a000a4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-17T02:38:22Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93f331b9-bb0a-428f-500a-08d93139040d
x-ms-traffictypediagnostic: BL1PR12MB5173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB51739F05E2820794E1DD2A84840E9@BL1PR12MB5173.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nDfiRn85JDRUQSPTawmXpGkAN0valUIm0eAfuXudbdqXr47tyaSApEFlWbfc3DA8Ey28h4ukNKkooSclM9KuaSDUQvn6OBIW9F21kwNUOH1P8ICuvRDkvhv1Y9j+SUXyO4H153bIoBOGTIbeN+ag1itVkiE+GpgK9FghWOplBYRFv337P+V3hRJ6RbnDYmWITddt3ROaB3j4hTEYENspwjE96PG4jf2LJVAsziDGBNFZZEtcNlkll3pwURrmeQmwtHD2gPEfz7MzslHVWcxcWhwiBwzlW0ALjqRag7fWvwBsq7elq8Qf3oF5r6Nw3tDrS7ky4jfg/NPbq+Wk+cGcZgF7kZIMALnJhhTQh9MN3CU0ocCI60/tRZUEq4RnIMpsXZD1eC+xtu+akUthnYbz/jpfk36CCVyuuMehTjKPo3DzYI5eX7BalNDybi6fL3Q+tyq+Y4qrvSCVss4h1eAPUFEwnCoN2gmsCIxlddQqHEJxmabZwc+o8ZMlU+pAZYzNx+drcZcEB6jwnDQzWKulpj+iVuN8RROn6xJ/ms20jMhTIz8LSMVPuwKHAXd6gLx1wFpvnUlnjbSN39gE1qqiDNq+B1MMy7QHOHsS6p5yJ3QqbJs8qVIcdn72dOeT2Iz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(498600001)(224303003)(186003)(54906003)(2906002)(110136005)(71200400001)(26005)(33656002)(7696005)(83380400001)(966005)(66946007)(86362001)(52536014)(55016002)(66476007)(64756008)(66446008)(4326008)(66556008)(76116006)(8936002)(9686003)(5660300002)(6506007)(122000001)(45080400002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SExUSXVZREwzYTBuZVFNUzl0cllIOTAvUTFOS2RXckhEYlhadHhJUkE0cE9i?=
 =?gb2312?B?emZJeTUxM0IvTThWdEhJa2g1S2prUldJU2U2N3dhMU5EdENJTXpDZHVieU9B?=
 =?gb2312?B?ME1yTFJjTm5lYzF2STg0ZWIyOEl6RU8xbTgvcllIK05JK3kxNlpKQStZUy92?=
 =?gb2312?B?UHgvU1c2dUNZK1h1aG5vR2dFR3IvVFhKam1mVm94YW14bHkzdWIrVGpBN0JV?=
 =?gb2312?B?Sk8xRFBpOXk2N2NmUXMwYzN5cHRXc1N2dTRURUZYa2RaQllkbXMzR1dnb0pS?=
 =?gb2312?B?dDkrU05xRm5kVEk4c0prZ1NLbUd6a3JSZkR6SUcrSjk4YjQvR2pDVUVoaE53?=
 =?gb2312?B?NmdzTVdVM3NuREZtclVCYjFGeFdpQmFQNXV3N0VDZHVPNVJkcG4zL2pVR3pG?=
 =?gb2312?B?Yzl0NlFoQlhXSS9naTBwMmVJWE5YNG82elhlVUwzbmNvbmFDaWV1cWQ3dzJT?=
 =?gb2312?B?SEZaOXpZbktuMUx5eVh3VWIrc04wL0V3ZnlBRmhDMVQ2OXFhUnQyaDlRYTYx?=
 =?gb2312?B?Vlo4VFFoSHA4NzdGM2FWbTVWcDNZTGFaayt1Uk5vbTlCQzl6dmVEVjRVYVIv?=
 =?gb2312?B?TjViaG8wYXNtSHl2Y2ZwVEpxMTVjeG5NUVVybnZpK3VNUkJza2srdmV3dnhY?=
 =?gb2312?B?ZzRERWNLUXlrd09TWG43VGhoMzgvaUtjcENoWXl5bWRIQ2p1YVFrUGdYT1py?=
 =?gb2312?B?ZDZlc2txLzVaelB5LzE4Z1VkaEVFZmlkZk9oOFNpQ3R3cGxOVGZCTVFwaEpR?=
 =?gb2312?B?VjhWTEFmS2Rtb3ZZTkdqNzBoc1UyUGxRQmUyVTZFaTU1djVYRmRrQ2VVQzkv?=
 =?gb2312?B?Y3FwbTcxRFN2ZWhaa09YVmJqUVpyUC9peGtqVCtVV0VxcXY5dC9xakdIb3VR?=
 =?gb2312?B?WjF4QnRzRUw3bVhkY3piWTBoeFpoZ1hoRUpDRjhoU1JsWm1SN1ViVFhzbURY?=
 =?gb2312?B?RmxOZFhTc2l5NzIrWklYRFpyQmxqZFBjanNhcTRma2ZWOUJQV2M2MVl0OHRH?=
 =?gb2312?B?cWhrR3ZuNG5lZnZXb2x5blIraTIvWTlQbktRaURJWkRZUTZVQTJyenYyKzNo?=
 =?gb2312?B?UmxteTdrS3Z5aU85NitYclFLWEMvaytDMWhyUXcrT3FSVS9JVFVyWUdSQTVS?=
 =?gb2312?B?WU5USFh5djBwcnVBSUdQOEhYUHFMVkVIS2xNakM1ODdYWFJOREsyRGVMMkpN?=
 =?gb2312?B?TEhpbGsyVlR3TjI4cXRSZU91YnhMWUZ4QlVISzdsSXZpeklibDhLVmVQR1VD?=
 =?gb2312?B?ZnEva2oyNWRCaEM4L0Rlam9LS3Y1cHlQLzc4NUtoSFYyaXNkbnJEd2FzSFRB?=
 =?gb2312?B?SkVBM1pYV1FFejI0anNJZFV6bUxrQUFEKy9reE5SL0R4MG52N0JqZDlzTVhF?=
 =?gb2312?B?enltMjRlSkNlQUgyTWhzdGhsWDJXRTFuZVYwdnBMSE1TMGZmTUhOaU9URDVP?=
 =?gb2312?B?ZFdjUWVPbzlSOW4rQlJUNnYrMHhkWmU1RHZLc2I1NnplMndnbng5VGI5dDJr?=
 =?gb2312?B?YlNuZDdBN0REa3NXZnhQbm9uQnVzS25iVHFRdGJ1a25pdHVlcHFVUEhQQzIr?=
 =?gb2312?B?THRjbWV2MjV0QUk5NjVBODZDd05tS2FrYmJXTFJxL3BBejZoT1QrMkJ2a3VC?=
 =?gb2312?B?bVR2d2xnd1Qxbmg0ZXRYZnNLOTQ1QWtyQmN1V1duNHpwN3Z6NEEvQktRT0xH?=
 =?gb2312?B?bUFoZEZscXowK1ZXbmlDSHl4Ulc3UlBvTnNnN2tTZGJaOEtQc1FuWVUvb3dv?=
 =?gb2312?Q?ya5Dj/4ahGez9bZ+4y1i/Jq1S84GOQt/pgOOx/f?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f331b9-bb0a-428f-500a-08d93139040d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 02:38:39.9627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6i+PvbCMKtEQ29pDcukSly9qIfuEMXP3252exwH9y8+vHh0qj0npNRLvpS1BoYzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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
Cc: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUmV2aWV3ZWQtYnk6IE1vbmsgTGl1IDxtb25rLmxp
dUBhbWQuY29tPg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gtPqx7SBZdUJpYW8gV2FuZw0Kt6LLzcqx
vOQ6IDIwMjHE6jbUwjnI1SAxMTowMg0KytW8/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0Ks63LzTogV2FuZywgWXVCaWFvIDxZdUJpYW8uV2FuZ0BhbWQuY29tPjsgR3JvZHpvdnNr
eSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgWGlhbywgSmFjayA8SmFjay5Y
aWFvQGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IENoZW4sIEhvcmFj
ZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IFdhbmcsIEtldmluKFlhbmcpIDxLZXZpbjEuV2FuZ0Bh
bWQuY29tPjsgWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT47IFR1aWtvdiwgTHVi
ZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxp
dUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCtb3zOI6
IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVzZXQgcHNwIHJpbmcgd3B0ciBkdXJpbmcgcmluZ19jcmVh
dGUNCg0KW1doeV0NCnBzcCByaW5nIHdwdHIgaXMgbm90IGluaXRpYWxpemVkIHByb3Blcmx5IGlu
IHJpbmdfY3JlYXRlLCB3aGljaCB3b3VsZCBsZWFkIHRvIHBzcCBmYWlsdXJlIGFmdGVyIHNldmVy
YWwgZ3B1IHJlc2V0Lg0KDQpbSG93XQ0KU2V0IHJpbmdfd3B0ciB0byB6ZXJvIGluIHBzcF9yaW5n
X2NyZWF0ZS4NCg0KU2lnbmVkLW9mZi1ieTogWXVCaWFvIFdhbmcgPFl1Qmlhby5XYW5nQGFtZC5j
b20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyB8IDEgKyAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YzXzEuYyAgfCAxICsNCiAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvcHNwX3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEx
XzAuYw0KaW5kZXggMGZkMWVkOTE4NjI3Li4zZTYyMTg3OTlhMGMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvcHNwX3YxMV8wLmMNCkBAIC00NjgsNiArNDY4LDcgQEAgc3RhdGljIGludCBw
c3BfdjExXzBfcmluZ19jcmVhdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsDQogICAgICAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcHNwLT5hZGV2Ow0KDQogICAgICAgIGlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpIHsNCisgICAgICAgICAgICAgICByaW5nLT5yaW5nX3dwdHIgPSAw
Ow0KICAgICAgICAgICAgICAgIHJldCA9IHBzcF92MTFfMF9yaW5nX3N0b3AocHNwLCByaW5nX3R5
cGUpOw0KICAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAgICAgICAgICAgICAgICAg
IERSTV9FUlJPUigicHNwX3YxMV8wX3Jpbmdfc3RvcF9zcmlvdiBmYWlsZWQhXG4iKTsgZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5jDQppbmRleCA5MDg2NjRhNTc3NGIuLmJlMDVkOWNi
ZDQxZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMNCkBAIC0yMzEsNiAr
MjMxLDcgQEAgc3RhdGljIGludCBwc3BfdjNfMV9yaW5nX2NyZWF0ZShzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCwNCiAgICAgICAgcHNwX3YzXzFfcmVyb3V0ZV9paChwc3ApOw0KDQogICAgICAgIGlm
IChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCisgICAgICAgICAgICAgICByaW5nLT5yaW5nX3dw
dHIgPSAwOw0KICAgICAgICAgICAgICAgIHJldCA9IHBzcF92M18xX3Jpbmdfc3RvcChwc3AsIHJp
bmdfdHlwZSk7DQogICAgICAgICAgICAgICAgaWYgKHJldCkgew0KICAgICAgICAgICAgICAgICAg
ICAgICAgRFJNX0VSUk9SKCJwc3BfdjNfMV9yaW5nX3N0b3Bfc3Jpb3YgZmFpbGVkIVxuIik7DQot
LQ0KMi4yNS4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q21vbmsubGl1JTQwYW1kLmNvbSU3Q2YwYzRkOGM3MWU3
NjQwN2JlZjIwMDhkOTJhZjMwMzIzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzU4ODA0NTQ4NDgwOTU0MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpX
SWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlN0MxMDAwJmFtcDtzZGF0YT0wMHk0OFNBYUYlMkZsJTJCZGM1TktHbEhPVmh0bW40Z245
aFdJeWlhQVRpWWY1dyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
