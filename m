Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E725060F6E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E725060F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7986ECCA;
	Thu, 21 Oct 2021 16:42:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D7F6ECCA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AORMUfc0kPUOj/FXwiWxApd4G23EmdbgLE4wBHxdOaRdLO12Ldit4Yg2wlCjSZ+y8yoKv0trMDzW8j7yzyYeNspTlYmqE0+aTG4CaB2bM/Ez4mFhUFmHO8nBtyQwUiq5EqXPof+d+I3Mltk7N3hApGxf4M/SXzIhFGk9qWJKuD0U11MdkzHupEgEOdWmuaLDwlJz96EoDNXut6ro0eV6ZX79C2jmHuogcn9gVWIidiGj0rOakhfD/rKbFpKzo8VGTdYjw215fBw5ayiKxUdaJbdd6CTt0CAyjaLHphJrcwlPAcaVhR0Wb3u/K1Rj9QVuQfT3QhLe8mtYTy1pKhPFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GjU55tkIXYLRMuYVbarR9/CQWh6YAefde03W/8a+JU=;
 b=mtXU0Vct+LYEXUSCZxhbi647J3CcONcphwKySyN7rdxyELA4Yz0QU6eYeLyQ57U3B0jKvnBgHMCeZEUlF8XeJMuqgI+hs4Qf2vmJQDEX3haGQkAipxSZwWPyfQ5rnSpJfwYeyoRwgO4Iyph7au5JLmrFKf+lOece266eM4MZD6BU/L+c0kPnHukyspS2udXs8NclKrpjwYH/UY2Enq+DoKQSQMqaC8eBu5orwp2kLmAsZsNyf76tmSvN9Sjee340kwgfG1RGSD42UIzdkpIC/A3OqTd3oAC51OrOiixx8pQnKhfJQHs+8hX1jxC7yMTHphoHOV6gF60LYEv7O3jenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GjU55tkIXYLRMuYVbarR9/CQWh6YAefde03W/8a+JU=;
 b=nuIzgkoIlFOsVZHWOnbTq/uRMKKwIvtPn+jgunnG8VLGi0xpUIBNc/tH3u8XQmOE3Ifa2IQ35KwA7P9Dnxlumd/X5tMFmkrTdUVxglUJJ8gmEjTi37gCBrF4vstrWQI72jd61sOnU4OOBN4FFjjiXRCX2G7nMwtwRImbc8Oou4w=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3659.namprd12.prod.outlook.com (2603:10b6:5:14a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 16:42:25 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:42:25 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring
 bad page threshold
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for
 ignoring bad page threshold
Thread-Index: AQHXxpTqXezHY5DBVkSA/VmHl8QW+6vdoisAgAAEY3A=
Date: Thu, 21 Oct 2021 16:42:25 +0000
Message-ID: <DM6PR12MB332402EACCE9F2EC589B2DF285BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <20211021155711.1191830-2-kent.russell@amd.com>
 <b6e919fb-f4f6-299d-c0c9-de15b16b7b47@amd.com>
In-Reply-To: <b6e919fb-f4f6-299d-c0c9-de15b16b7b47@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T16:42:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d1690ffd-905b-4087-bc4e-1dd3291b7688;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 599fe80b-ca55-4ee6-09d2-08d994b1c35e
x-ms-traffictypediagnostic: DM6PR12MB3659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3659BECB01BB9E0540F8205585BF9@DM6PR12MB3659.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cX6Z2IexrjNPL1/g3tgZRmSX23sItRs9XfHEkml+i0XLcla6Xc/7aqbVNlzIeAPugR0O4sKaFpOwaiWq9gQi8CR48TeTSQQMh7iZnudg2bEu8WF9vsJbZryr0bsvY4ePvfNiHh4H6oPabr7loY0YAH2e+zbccg2psrxBbUv3UdxlCuD/RdoXFKUPixCw21Lm3+J1nyekcOiierUQzwBZJQziQgtwWtJvhm8dVnClsteoy1TGiX0IW7RlpTGjXRUZ2aOTjkUP22oiGY9edzm2MNKKVT8IZWE7jkdLPHU/TDK50oPIu/K1nmjdBZZgAKp8BBJYOD84fXrpVInPEXvZOMlUaDuXsHnicOmEQs+jASW3rl3LCw6OlgXmIlPt9i0tOzRBM7zNL5uRjqsHMGD3qyBQbbO73sXBcacRe3vRsaOC4t2f+JCyvendrIDYdGy/xKBdPHEa6In7WT9k+02qqnZATE22suaA6F/H9fFGW7tjQUDzZ/OZ0GW65eAGrdPwwKIFfOxmY5cwcjhZdD8VZd1sP5I+Gjaj09mynn170cLuxqArdWwG3KmdQCsIBeWpepSjtIa/U0lvMcB+jKfb4ubAcD272HPyLLjCp2erS27JWhMwklvd8Gb86/ebmPPojkO+kTEBDu4WpmVI14DynK1EGByiK6SJQEA2DvY5lG/WWy14nq+SFtMz4p2xMfafN1wUsDtIi7PV6ETHLb2I7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2906002)(508600001)(66446008)(4326008)(38070700005)(4001150100001)(9686003)(8936002)(38100700002)(55016002)(316002)(110136005)(7696005)(122000001)(6506007)(52536014)(66556008)(8676002)(83380400001)(71200400001)(5660300002)(66946007)(64756008)(186003)(54906003)(53546011)(76116006)(33656002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YSt3L3NzWk9JaWdmdm5Dc05tSldkdTJROWxHNGQyUUhtdGppRFY2K0s2ZGFz?=
 =?utf-8?B?SDhSM2hkdzFZUVYwbDlBRVFFamxHdUpQYm9JMjBhbEdpaVp6MXJLTThiYWY5?=
 =?utf-8?B?aS9aYVdpUkVwMURUcThaQStmRFhLOWRFTUlEVlUzMVNMZXRDTnRtdUxKZ2R0?=
 =?utf-8?B?aDEwMTF6SGJ2RFVaSDlMWVQzWE9Dd1NwYUhhMXpQUEdtUUdIWW1OVEs5NlU0?=
 =?utf-8?B?L01TZHNkTDNTaldqNXFjZFRuMmRCb2xzV0EySUhjcExSeVg1dXBUdlNjc29B?=
 =?utf-8?B?bmhKSlJUdkNzRDI4bU5yUU9BbDZlUG80dzBOMXd2SnJDdjB3SGNaSFZaREVq?=
 =?utf-8?B?bThiOTJsTENoSWw5cURuZzRYMTR6VDNqOUZVb09OcDZGUDJjWjNhZWpKdUNM?=
 =?utf-8?B?UnUxbHRGMGtmVlU2M1BMbG50a0FBYWRQWUNqUWF5aUQwWHhlUnB1YVpmSzNS?=
 =?utf-8?B?NXUyeE5HTklmY1FRL0pZOGMrTVR2UVdEQ01PRHUvdVZPeE9HckRpVkZQSTNY?=
 =?utf-8?B?QlM4ODBqYlRwZlhlU0d5T0xJckYyRlFzRWZIUnJmT1JEbXJyNTk5VXF1YWRU?=
 =?utf-8?B?bTA3Mlo1a3lnUC8yZDNwdXZCSWZ4Ujh6OWV6ZFpzQVV0NUcyZFlpQlloWHF4?=
 =?utf-8?B?UzBXRCtaN0NBTGRPK2M0dFplVlBVTmdNRnRaQlV4MHNTVnhiazdHdDl2YjRx?=
 =?utf-8?B?YmNUSVU2TzFPNThiZUYyTGRzeFRlYTVlSHZLZlB1U1Z2UEVYaHl3MlpzakVX?=
 =?utf-8?B?ajR1a3pIQUtneTVUd25uQmlZYUR4bHBLQzR2bVdraVliQ0RjUmh6UWVUQ1pw?=
 =?utf-8?B?cTRwSW8xNlRNdUxVSEcxRVpaWVpsT1ZGb2poN1hsYjZsS0p2cWRremxGa2ow?=
 =?utf-8?B?a2FVVXZVcWVHdkx2aEg1YzVpOUhOZU1nOEt5dmR6cnJRVzZjei9qWVFabG1l?=
 =?utf-8?B?M0dnMnFCTDhlWkN4YUFXSEFNTVNrVTB0Qk1kdmFKUmJtNlA0dzRFdk5oYk0x?=
 =?utf-8?B?VldVcFdzaGx0MjVIM29nMWZXamdBaUJhZlkxUFA2NzBzVW9KVEVjK0xxdm81?=
 =?utf-8?B?dThhdU5uVWhTR1JpTDhNTkZBQlZWV3NjaDlWTllKRUZsMG5yeHY5eCtvOGJE?=
 =?utf-8?B?WFg5d3A3SXIvOUFnNHZMQmEyVGp6S2tsSFlwTTZNa3k4ckc1QkFVc1h5VW5v?=
 =?utf-8?B?UUx6ZWZJek1aaFFHenA3TGQ1Y3hyUjN5NE01ZUJaL0JmN0tWejU1UWNwY1dz?=
 =?utf-8?B?NGVVTGFsOTlRbVk2a3Q1WmMzS24zd0hDZTdjQktxU0VvWFFnenREZ3QrMkhQ?=
 =?utf-8?B?NENVMU1PUkpNTldOYnpXUDdYbDcwemxIZ0ZEM1lwd0tSMTdWa0xEdGNicGRo?=
 =?utf-8?B?bS9JbnJvbUdVekdCS1BiV1dVbnprWmJWMU9wbENyYkEvRCtJdkRRMS83WkVS?=
 =?utf-8?B?UUZqVURBRUhvT2psS2hLc3FwVzNVY2p5WXJ2Qytxc3ZWRmJjOGRMdi9lVVBC?=
 =?utf-8?B?MTBHeTUzYWplYnZGYld4RitaUTRTTm9pVFBQUXdoVVd0YnZoMTladHZIaU5w?=
 =?utf-8?B?ckFQTURCTnhRcW5XUzNuMHRBMzQyeld0MFZMU0xCdUw1ZGNjSFpzZWFSOXd0?=
 =?utf-8?B?dkNJT203R2F0MU5SeC9kNmhkRlVIeUpEMjRsS3NTT0NORU5jeWd0TEVMZkdy?=
 =?utf-8?B?MFJCQkhsMGxYbS93cHlEZEZQUFkwT3NiK3NKTGlneTU3eXBCOE1lTDhod255?=
 =?utf-8?B?TmJYeFVMd3JVZnNZMEcxeWFvaE05Wk5CWTVrQUVlMVdVQjNWVGswT2dCczc3?=
 =?utf-8?B?T1AxdmloM2llTjNmY3l4REx2Q3dCS3ZLSUU2UFYwOCtOSGFHVGYyWlZ0STRt?=
 =?utf-8?Q?yeh/XenBwixpZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599fe80b-ca55-4ee6-09d2-08d994b1c35e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 16:42:25.6068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krussell@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3659
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDIxLCAyMDIxIDEyOjIxIFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50
IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBKb3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Ow0KPiBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZA
YW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IEFkZCBrZXJu
ZWwgcGFyYW1ldGVyIHN1cHBvcnQgZm9yIGlnbm9yaW5nIGJhZCBwYWdlDQo+IHRocmVzaG9sZA0K
PiANCj4gT24gMjAyMS0xMC0yMSAxMTo1NywgS2VudCBSdXNzZWxsIHdyb3RlOg0KPiA+IFdoZW4g
YSBHUFUgaGl0cyB0aGUgYmFkX3BhZ2VfdGhyZXNob2xkLCBpdCB3aWxsIG5vdCBiZSBpbml0aWFs
aXplZCBieQ0KPiA+IHRoZSBhbWRncHUgZHJpdmVyLiBUaGlzIG1lYW5zIHRoYXQgdGhlIHRhYmxl
IGNhbm5vdCBiZSBjbGVhcmVkLCBub3IgY2FuDQo+ID4gaW5mb3JtYXRpb24gZ2F0aGVyaW5nIGJl
IHBlcmZvcm1lZCAoZ2V0dGluZyBzZXJpYWwgbnVtYmVyLCBCREYsIGV0YykuDQo+ID4NCj4gPiBJ
ZiB0aGUgYmFkX3BhZ2VfdGhyZXNob2xkIGtlcm5lbCBwYXJhbWV0ZXIgaXMgc2V0IHRvIC0yLA0K
PiA+IGNvbnRpbnVlIHRvIGluaXRpYWxpemUgdGhlIEdQVSwgd2hpbGUgcHJpbnRpbmcgYSB3YXJu
aW5nIHRvIGRtZXNnIHRoYXQNCj4gPiB0aGlzIGFjdGlvbiBoYXMgYmVlbiBkb25lDQo+ID4NCj4g
PiBDYzogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4NCj4gPiBDYzogTXVrdWwg
Sm9zaGkgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VudCBSdXNz
ZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPiBBY2tlZC1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEx1YmVuIFR1aWtvdiA8
bHViZW4udHVpa292QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oICAgICAgICAgICAgfCAgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgICAgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIHwgMTIgKysrKysrKystLS0tDQo+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggZDU4ZTM3ZmQw
MWY0Li5iODViNjdhODhhM2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaA0KPiA+IEBAIC0yMDUsNiArMjA1LDcgQEAgZXh0ZXJuIHN0cnVjdCBhbWRncHVfbWdwdV9p
bmZvIG1ncHVfaW5mbzsNCj4gPiAgZXh0ZXJuIGludCBhbWRncHVfcmFzX2VuYWJsZTsNCj4gPiAg
ZXh0ZXJuIHVpbnQgYW1kZ3B1X3Jhc19tYXNrOw0KPiA+ICBleHRlcm4gaW50IGFtZGdwdV9iYWRf
cGFnZV90aHJlc2hvbGQ7DQo+ID4gK2V4dGVybiBib29sIGFtZGdwdV9pZ25vcmVfYmFkX3BhZ2Vf
dGhyZXNob2xkOw0KPiA+ICBleHRlcm4gc3RydWN0IGFtZGdwdV93YXRjaGRvZ190aW1lciBhbWRn
cHVfd2F0Y2hkb2dfdGltZXI7DQo+ID4gIGV4dGVybiBpbnQgYW1kZ3B1X2FzeW5jX2dmeF9yaW5n
Ow0KPiA+ICBleHRlcm4gaW50IGFtZGdwdV9tY2JwOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCA5NmJkNjNhZWVkZGQuLmVlZTNjZjg3NGU3
YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4g
PiBAQCAtODc3LDcgKzg3Nyw3IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChyZXNldF9tZXRob2QsIGFt
ZGdwdV9yZXNldF9tZXRob2QsDQo+IGludCwgMDQ0NCk7DQo+ID4gICAqIHJlc3VsdCBpbiB0aGUg
R1BVIGVudGVyaW5nIGJhZCBzdGF0dXMgd2hlbiB0aGUgbnVtYmVyIG9mIHRvdGFsDQo+ID4gICAq
IGZhdWx0eSBwYWdlcyBieSBFQ0MgZXhjZWVkcyB0aGUgdGhyZXNob2xkIHZhbHVlLg0KPiA+ICAg
Ki8NCj4gPiAtTU9EVUxFX1BBUk1fREVTQyhiYWRfcGFnZV90aHJlc2hvbGQsICJCYWQgcGFnZSB0
aHJlc2hvbGQoLTEgPSBhdXRvKGRlZmF1bHQNCj4gdmFsdWUpLCAwID0gZGlzYWJsZSBiYWQgcGFn
ZSByZXRpcmVtZW50KSIpOw0KPiA+ICtNT0RVTEVfUEFSTV9ERVNDKGJhZF9wYWdlX3RocmVzaG9s
ZCwgIkJhZCBwYWdlIHRocmVzaG9sZCgtMSA9IGF1dG8oZGVmYXVsdA0KPiB2YWx1ZSksIDAgPSBk
aXNhYmxlIGJhZCBwYWdlIHJldGlyZW1lbnQsIC0yID0gaWdub3JlIGJhZCBwYWdlIHRocmVzaG9s
ZCkiKTsNCj4gPiAgbW9kdWxlX3BhcmFtX25hbWVkKGJhZF9wYWdlX3RocmVzaG9sZCwgYW1kZ3B1
X2JhZF9wYWdlX3RocmVzaG9sZCwgaW50LCAwNDQ0KTsNCj4gPg0KPiA+ICBNT0RVTEVfUEFSTV9E
RVNDKG51bV9rY3EsICJudW1iZXIgb2Yga2VybmVsIGNvbXB1dGUgcXVldWUgdXNlciB3YW50IHRv
IHNldHVwDQo+ICg4IGlmIHNldCB0byBncmVhdGVyIHRoYW4gOCBvciBsZXNzIHRoYW4gMCwgb25s
eSBhZmZlY3QgZ2Z4IDgrKSIpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhc19lZXByb20uYw0KPiA+IGluZGV4IGNlNTA4OTIxNjQ3NC4uYmQ2ZWQ0M2Iw
ZGYyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXNfZWVwcm9tLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzX2VlcHJvbS5jDQo+ID4gQEAgLTExMDQsMTEgKzExMDQsMTUgQEAgaW50IGFtZGdwdV9yYXNf
ZWVwcm9tX2luaXQoc3RydWN0DQo+IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNvbnRyb2ws
DQo+ID4gIAkJCXJlcyA9IGFtZGdwdV9yYXNfZWVwcm9tX2NvcnJlY3RfaGVhZGVyX3RhZyhjb250
cm9sLA0KPiA+ICAJCQkJCQkJCSAgIFJBU19UQUJMRV9IRFJfVkFMKTsNCj4gPiAgCQl9IGVsc2Ug
ew0KPiA+IC0JCQkqZXhjZWVkX2Vycl9saW1pdCA9IHRydWU7DQo+ID4gLQkJCWRldl9lcnIoYWRl
di0+ZGV2LA0KPiA+IC0JCQkJIlJBUyByZWNvcmRzOiVkIGV4Y2VlZCB0aHJlc2hvbGQ6JWQsICIN
Cj4gPiAtCQkJCSJHUFUgd2lsbCBub3QgYmUgaW5pdGlhbGl6ZWQuIFJlcGxhY2UgdGhpcyBHUFUg
b3IgaW5jcmVhc2UgdGhlDQo+IHRocmVzaG9sZCIsDQo+ID4gKwkJCWRldl9lcnIoYWRldi0+ZGV2
LCAiUkFTIHJlY29yZHM6JWQgZXhjZWVkIHRocmVzaG9sZDolZCIsDQo+ID4gIAkJCQljb250cm9s
LT5yYXNfbnVtX3JlY3MsIHJhcy0+YmFkX3BhZ2VfY250X3RocmVzaG9sZCk7DQo+IA0KPiBJIHRo
b3VnaHQgdGhpcyB3b3VsZCBhbGwgZ28gaW4gYSBzaW5nbGUgc2V0IG9mIHBhdGNoZXMuIEkgd2Fz
bid0IGF3YXJlIGEgc2luZ2xldG9uIHBhdGNoIHdlbnQNCj4gaW4gYWxyZWFkeSB3aGljaCBjaGFu
Z2VkIGp1c3QgdGhpcyBsaW5lLS10aGlzIGNoYW5nZSB3YXMgYWx3YXlzIGEgcGFydCBvZiBhIHBh
dGNoIHNldC4NCj4gDQoNCkFoIHNvcnJ5LiBXaGVuIHlvdSByZXZpZXdlZCB0aGUgb3JpZ2luYWwg
cGF0Y2gyIGNsYXJpZnlpbmcgdGhlIG1lc3NhZ2UsIEkgbWVyZ2VkIGl0IGFuZCB0aGVuIHJlLXN1
Ym1pdHRlZCB0aGUgcmVtYWluaW5nIDMgKHdoaWNoIHBhcmVkIGRvd24gdG8gMikgZm9yIHJldmll
dy4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24sIEkgd2FzIHRyeWluZyB0byBtaW5pbWl6ZSB0aGUg
bnVtYmVyIG9mIG1vdmluZyBwYXJ0cy4NCg0KIEtlbnQNCg0KPiBSZWdhcmRzLA0KPiBMdWJlbg0K
PiANCj4gPiArCQkJaWYgKGFtZGdwdV9iYWRfcGFnZV90aHJlc2hvbGQgPT0gLTIpIHsNCj4gPiAr
CQkJCWRldl93YXJuKGFkZXYtPmRldiwgIkdQVSB3aWxsIGJlIGluaXRpYWxpemVkIGR1ZSB0bw0K
PiBiYWRfcGFnZV90aHJlc2hvbGQgPSAtMi4iKTsNCj4gPiArCQkJCXJlcyA9IDA7DQo+ID4gKwkJ
CX0gZWxzZSB7DQo+ID4gKwkJCQkqZXhjZWVkX2Vycl9saW1pdCA9IHRydWU7DQo+ID4gKwkJCQlk
ZXZfZXJyKGFkZXYtPmRldiwgIkdQVSB3aWxsIG5vdCBiZSBpbml0aWFsaXplZC4gUmVwbGFjZSB0
aGlzDQo+IEdQVSBvciBpbmNyZWFzZSB0aGUgdGhyZXNob2xkLiIpOw0KPiA+ICsJCQl9DQo+ID4g
IAkJfQ0KPiA+ICAJfSBlbHNlIHsNCj4gPiAgCQlEUk1fSU5GTygiQ3JlYXRpbmcgYSBuZXcgRUVQ
Uk9NIHRhYmxlIik7DQo=
