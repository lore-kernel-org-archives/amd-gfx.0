Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E3CC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 19:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7836135A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 19:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7836135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE426E3E3;
	Fri,  7 May 2021 19:12:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE5A6E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 19:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoOrrYeMEx1IOgX+DDNtOxxn+lQfQs4oONRulxV09IIIkfFiyyspO8M4v0mxhaOKcsSD796ss3z9KnYH2gN1LnxXV7y6XIdnsHsl64vizLMWevLbia2v0/PKbv3HhW1E/42GPnT99OzzLkFsAzMPCZZgwFY+1xM6DlHbQjWJpGe7chF3Wkhrj/w632aYN86bdSEeh4Fi5fyfSZ2Nyb2JMdKxASmnNVjUhuiib7/krGXvhnr8A6h8WKLbmr2nhqaBsuHVFDuAaI5ukAchBFHgRDbsZesLLscKal7E3RHZiDabVc/bhPG4Efh9+X66xwiNCZ9Jp2u7N2v0ppEg5XD1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsFU+gcAJMVfIHIYFTMKew04TzhrQBmKq0TS0Fj88lM=;
 b=LLBjVrPVHz9ymL5TONYQYTQY/DKbeVnJvZ7uq1fGnlgpPKF5ZbpBMURTudkSks9xF/OhWRJ8Iwa8apadvHkIdmga5dHO/LsBi569Nw3MqDPpsBVqXOxGP1YDNip9juuZyZwPjfaaGv135BZvaOAU4ShWWCgR0nq6uXeWQ8GdUu5whbwsQ0H4LVDUctA7mdNA+dgXPte7fAMO+EBk3panU2+ZyHdSDMC1HXCSG7zMa+4epjgV4ytDAoBIPIDkv0Z8v5ET73pU34xoyffiF6koRD0iJ8h5IORVwbBBQjTqYKL8puJF0q9aWpLS5zQH0U8Vbqja05Sex9XFLL62bYPMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsFU+gcAJMVfIHIYFTMKew04TzhrQBmKq0TS0Fj88lM=;
 b=3Umwf4Foef8bVc1fTOzL1LJ2FabHxggpecApYUi04UChFsNaVb6txrdYx07zDJ/qrwIxu9nMUZxuxLbC23s5LEgsNR2yGxfFkcokswC9mgSuOtqk1STT9VdLgSkX8atH4fVaSJMYB2m8YuIHI2KoRwwObmfvfuaI+n6Vwuzrr04=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Fri, 7 May 2021 19:12:32 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:12:31 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is
 disabled
Thread-Topic: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is
 disabled
Thread-Index: AQHXQt5kIRHiP5DRAE+FBiBAZGXte6rX/ZoAgAAjdoA=
Date: Fri, 7 May 2021 19:12:31 +0000
Message-ID: <1461C211-D83A-4573-B569-BB04EDC271FE@amd.com>
References: <1620350085-22406-1-git-send-email-Oak.Zeng@amd.com>
 <BN9PR12MB5368CC933FDBA85FAE4A9391FC579@BN9PR12MB5368.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5368CC933FDBA85FAE4A9391FC579@BN9PR12MB5368.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef4f956-6cf2-423d-3df0-08d9118c105f
x-ms-traffictypediagnostic: DM6PR12MB3915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39157015D4CE1E471EA5CF4B80579@DM6PR12MB3915.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+yam3NJNJF2Q1/NA+EHbkb5bU2ygUpBGsOs6Qdctyk9Ht9c1ASMPyeZfU0szUD/PNkzRy3Q2FC3RzKlc32i/kGPiGMIxaJvaoG438/D/Bv7vFSbN6kmiI3JikOjMVnxRkMIyMhwO+J5vQHJ0KbS4hSqttfoS3hWhq8WTsy3Rg6jp6PBww3reZ+ImyhuqFvUNscmUtEQ0nzPcz72x+P4q9zeIYa8SDBiZEw19m/MkAxMK8U1VUpxPPiebewYNrU0xcIM55QSh5S98k2M2U2A3sA8gdvgXEdCTaXgDEUpjC4nuOOw3gu+I3dIId+nNmcTnHFjyEldm3GXn3B2EFL3YfNxvurZt6EB58y2NH6RQ6j85VvBmy6jeemcfk87xiPt68fR+KJmphxPzIjm1Rho+TiAItMorpzM1xl0BjTeT+J9nG1ZaUtIaCILqy8li4GVHed3rmlew1lU0Z0EZEIhjIOz+8ZY86UnzQ541HjKF72htXlA5zwNGTIUVYGbclCpRp1eVqJk+7MKh34nFD0/YiE79h5vhgXHs7WrpK66HOlPI8Ohe1t9+tTuZwd34zUK5HN2zEeJY/3yLoBrslNzWMVtWgUFW8LtECynO6/Ut9+eww0Hd/aJxTJbyEXT/NckfTUJC67XPxd5w3/idlG3i0Z3iBblqE22lxY5IW0Tmg0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(66556008)(6512007)(64756008)(66446008)(66476007)(66946007)(76116006)(71200400001)(91956017)(110136005)(2616005)(478600001)(36756003)(8936002)(86362001)(33656002)(53546011)(6506007)(54906003)(5660300002)(186003)(26005)(8676002)(6486002)(2906002)(83380400001)(38100700002)(122000001)(316002)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?eFRUSXBPU3dlTWpoV1VZR2QxUG5PWHBjWGhVeG8zbEdyK0N5aGVocCtYbmdR?=
 =?utf-8?B?eXdYR3YvQ2NQSDNrOVIvM0ZBTVEwZjd0VXFuWnZ4MEVBSklLQWRMaTdBUnJW?=
 =?utf-8?B?RHBXWnJnNDNmWU5UMFpKNE1PcnV6YWZmcDBwdVNsR3BlRG0rdEt1OHlVTGhY?=
 =?utf-8?B?cGtLUmJjZndvbjBjUG9IY2VPQmpLNWQ0anlMUHNOQVN5aXhZS3Y4Yk80eG1a?=
 =?utf-8?B?WFlWN1lGQWZINFQxd2lkSnhoUWx1cmJRVFlqaTY4eFpJdGJhWnhnbkpUdjVF?=
 =?utf-8?B?cHF3OU9qOFhnREc4dm0weDFoaFZ5WUxBWnFLNnM1c1pNKzlna0dZNU5BRVo4?=
 =?utf-8?B?ZlhSNGZKamZUcktWMngrZ3hzbWpnbENVRjBZTmdoVVZUeSticTQvL3RIRjVD?=
 =?utf-8?B?aEN1UFc1ajBwdndWMHZjZFNQWHRKZGwrNFR2Z29IeWV6akEyVmhwWFo0dnVm?=
 =?utf-8?B?VmJQZXpycFB6WWRZQVA4ek4zRUs3eHRNNGtLS2JuSEFGMHl3RHNuZ0M3NGpz?=
 =?utf-8?B?WlV1ODBSVVNVZWNHTGV4RUxXWnRDNWlvRDc5Sms0L3ZCcjVTS0tGTFN1SUpi?=
 =?utf-8?B?Y3dXWHdaUkhadHE0S3A4dERVb2VQbWV2T2dNemRhTGgxQ3dia2V2U1l6Smc5?=
 =?utf-8?B?WHBUM1Q5eXQ5aG00cWVZVEpXSTF5UDhrVjJJTkpIMytMczBNTWRvd1pVNC9M?=
 =?utf-8?B?anh3NGFrNzdNcTZWZEtmVnVTMEtVeGlweXl2RnVncTRFTUExZ2V1VU96WEdj?=
 =?utf-8?B?ZXg5NmcxSWZhT2ZVQloyZGFHS3lPclpTczJVWUdranJzSFc0MTFwYXB5TGJ2?=
 =?utf-8?B?QmdTemd2Uzl0Y3NFWm5SWmtSeFNZbHRnd0t3S1VheVp0OTdYUXFJR3VSOTkr?=
 =?utf-8?B?Wis5YncvM08rSHl0RmlQUlU1Y2piQjNRVms0clh4ZlF2VGdFY0tjWDcxVGVO?=
 =?utf-8?B?RkdQbWpWaWUwL1lGek5SbTU2KzVlNkUvWTFQa1BuS1d6Z0tGcFdKeTdEWUdB?=
 =?utf-8?B?ME43R3ZFUDhlakJWa2Z0Yi9YSVZWMzdQS0o3bEY0UmFmRVE4WEFYTWxLdkpE?=
 =?utf-8?B?OG1OaFNmWE9JLzVRdlZwWFBXRVhoMFU2VEtMOUNNSSt1YmxDK0dpUGpYWlFm?=
 =?utf-8?B?NzJZNGdrWXgvWU5sZnRXclVWYkRQSlkwYnVXSzBiQWYvSU9jaHl0b25wNDNC?=
 =?utf-8?B?YzBVQnJvS084R1dVcVdHQ21ac3RId29lQitMNjhsd3JSMlJHU05CbkF6d1JY?=
 =?utf-8?B?bXcwaWNkRFplRW9VbEtiN3NEUVNBdHd6Z3Qyc3dWOTR0cy9lZzVKM0MvMkxL?=
 =?utf-8?B?ajh4MmVvenUzTi9RSkhvRStYSWVKQlAvR2xiTkRJdHZUZitocnRoQzZzOXdW?=
 =?utf-8?B?Z0Z1T2ZJY0w0M0VTT0FTcldVdVdOVmc2Q2pWVzBRY3JUalI0d1pMNFJiTWJ4?=
 =?utf-8?B?MU5lQXBtZjdiY2JyVFNIVUFZaWw5MGRCclQvOWFCT3VxN2wxcUlWWTJHYkI5?=
 =?utf-8?B?Vy9xTXpCdndaM2xHK1hUMTVtek5HKzF6QmFvNjB0QnB5RFlSOG9YQXZDS2d0?=
 =?utf-8?B?K0RlTGs4YUtITUwwNEtQbS9sQllGWjBOSENhQW5JOGxHdnZMUDZuaG9UbDV5?=
 =?utf-8?B?RWNYT0V4ZFFDenh6M1FhSDIxZUdpcGlkZWxkUEVHUHd4WS96TnFIWlVuVGhO?=
 =?utf-8?B?VUoyVnliSk52TXJGdnRrTGJBUDdweXFBTEJyOUw5ZUowWVF3MEdrSk9ZRGRZ?=
 =?utf-8?B?c21Hd2NFSnI2Vnk2MmxyNURYVWhyV3h2SE92Y1pPcUplMFdHdVNUUDBpVGVi?=
 =?utf-8?B?RUhEUjJNa3dNVy9OVFFmQT09?=
Content-ID: <DF9FDACD151FD846A4041892228D70DB@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef4f956-6cf2-423d-3df0-08d9118c105f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 19:12:31.5217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVZ471Z2Vbweff2nvd7xbjtNTFWOCevbz7PGD6PLpL/EJUWZmEVA2IHqhmecE9+R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmsgeW91IEhhd2tpbmcgZm9yIHJldmlld2luZyB0aGlzLiBJIG1hZGUgYSBtaXN0YWtlIHdo
ZW4gSSBwdXNoZWQgdGhpcyBpbi4gSSBmb3Jnb3QgdG8gYWRkICIgUmV2aWV3ZWQtYnk6IEhhd2tp
bmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4iLiANCg0KUmVnYXJkcywNCk9hayANCg0K
IA0KDQrvu79PbiAyMDIxLTA1LTA3LCA5OjA1IEFNLCAiWmhhbmcsIEhhd2tpbmciIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KDQogICAgW0FNRCBQdWJsaWMgVXNlXQ0KDQogICAgUmV2
aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KICAgIFJl
Z2FyZHMsDQogICAgSGF3a2luZw0KICAgIC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQogICAg
RnJvbTogWmVuZywgT2FrIDxPYWsuWmVuZ0BhbWQuY29tPiANCiAgICBTZW50OiBGcmlkYXksIE1h
eSA3LCAyMDIxIDA5OjE1DQogICAgVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQog
ICAgQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMYXphciwgTGlq
byA8TGlqby5MYXphckBhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1k
LmNvbT47IEpvc2hpLCBNdWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT47IFplbmcsIE9hayA8T2Fr
LlplbmdAYW1kLmNvbT4NCiAgICBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IFF1aXQgUkFT
IGluaXRpYWxpemF0aW9uIGVhcmxpZXIgaWYgUkFTIGlzIGRpc2FibGVkDQoNCiAgICBJZiBSQVMg
aXMgZGlzYWJsZWQgdGhyb3VnaCBhbWRncHVfcmFzX2VuYWJsZSBrZXJuZWwgcGFyYW1ldGVyLCB3
ZSBzaG91bGQgcXVpdCB0aGUgUkFTIGluaXRpYWxpemF0aW9uIGVhcmlsZXIgdG8gYXZvaWQgaW5p
dGlhbGl6YXRpb24gb2Ygc29tZSBSQVMgZGF0YSBzdHJ1Y3R1cmUgc3VjaCBhcyBzeXNmcyBldGMu
DQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4NCiAgICAt
LS0NCiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMiArLQ0K
ICAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KICAg
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCiAgICBpbmRleCBlYmJlMmM1
Li43ZTY1YjM1IDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYw0KICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KICAgIEBAIC0yMTU1LDcgKzIxNTUsNyBAQCBpbnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQ0KDQogICAgIAlhbWRncHVfcmFzX2NoZWNrX3N1cHBvcnRl
ZChhZGV2LCAmY29uLT5od19zdXBwb3J0ZWQsDQogICAgIAkJCSZjb24tPnN1cHBvcnRlZCk7DQog
ICAgLQlpZiAoIWNvbi0+aHdfc3VwcG9ydGVkIHx8IChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9W
RUdBMTApKSB7DQogICAgKwlpZiAoIWFkZXYtPnJhc19mZWF0dXJlcyB8fCAoYWRldi0+YXNpY190
eXBlID09IENISVBfVkVHQTEwKSkgew0KICAgICAJCS8qIHNldCBnZnggYmxvY2sgcmFzIGNvbnRl
eHQgZmVhdHVyZSBmb3IgVkVHQTIwIEdhbWluZw0KICAgICAJCSAqIHNlbmQgcmFzIGRpc2FibGUg
Y21kIHRvIHJhcyB0YSBkdXJpbmcgcmFzIGxhdGUgaW5pdC4NCiAgICAgCQkgKi8NCiAgICAtLQ0K
ICAgIDIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
