Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76BC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 09:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4AA60EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 09:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD4AA60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644656E902;
	Fri, 27 Aug 2021 09:31:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34ED86E902
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 09:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiHom49z56bRAJFZTog7DEqNYHTZ+u79r7vPo//liJriHd5t7LInitdRIp6rSUsCGAdunIs2jzpS3g2FwfM74FNmWdfXJ5okNQ2nFjtjZ+uWCFU1pwK0JiYxHV81pAZS6+bliw3g+03Dl79Ee8g1I6gOr/W7AalwyvU+MU8kVNCIKvwhIj5YZNELZ1Vn718uMkRw3mnxhseZkPR41gKUWU9WlFJr3iAIJ1RvVbsQQF1GNcRFWNiufFxgV1cksEK9PLfnol0fzMDCMOaXc8uMWIb/7ZcWZn4GvzgQzE9Ej4bMwwjhqJOhgrT0gMUAExEike4fFGShu/hcvHzXdzX8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYkeNfVH4snwTsf/gxtBv3kBksTSzk1Vw1cc+PEAmOc=;
 b=YgpY0pb8rU/jID7AlEif4hZ5MDHN3kyzXAzgVlPAIbk/ZJxuYabfvHO3X4lBK/frD5F9N0GAV4PiOBEtGIRorut29e7wTXR9QZvDSTL0Si/7xZqT1MEV9ZI7ZEH7U8H6bHv+r0WS6NVXsAofE9DD9/pSn2yVytKpFxNjtrJsMj3daXcEeEm4FJvAtaQotXs2ASoit8KWJ3/gmUMg5c59lfYNwv9BvDxgQ/2v2dCmJcvkPPkTGvglARFJIMIj1lmcOGwtegQXNuzN/35nB4BoGFK7BTedaDfwgsDCGxW926e3hbvE2kuYlBELfE85sO5/cawdWac3UTgFUiWLfi5Epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYkeNfVH4snwTsf/gxtBv3kBksTSzk1Vw1cc+PEAmOc=;
 b=feXe54bbBji63Ky0buKqhk3F7xnawmbthnhSwJCMyWi+87CWDN3y3r4qCjElJ9EbMBux/8ZtojJh6LUsro99qrdvrWv4D/YKM+R7HCAOETnoQGM805/0GjcQ2s0jxMPD1Dj0t1G62Hk+tfE0h8IN0lUblo3tkraWgxvrqVYuOLQ=
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 09:31:39 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::68c9:ebec:60ec:f7e8]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::68c9:ebec:60ec:f7e8%4]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 09:31:39 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: adjust get preferred domain policy
Thread-Topic: [PATCH] drm/amdgpu: adjust get preferred domain policy
Thread-Index: AQHXmx/1ORiG2gzx10O1kqk/mqwyY6uHCyeAgAABRuA=
Date: Fri, 27 Aug 2021 09:31:38 +0000
Message-ID: <BYAPR12MB34167A6B6371BB7FAAF50B0EC1C89@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <20210827084549.166223-1-yifan1.zhang@amd.com>
 <e2c78532-0950-e2fc-00ea-b55a36f4fe1d@amd.com>
In-Reply-To: <e2c78532-0950-e2fc-00ea-b55a36f4fe1d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-27T09:31:35Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=de9bacf3-6b7e-4284-9e5e-a31d610f4991;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7c384d4-a49d-445b-c0a8-08d9693d78de
x-ms-traffictypediagnostic: BY5PR12MB4036:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB403646FF052623BE4C590D7FC1C89@BY5PR12MB4036.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elB+ECCsSOZGzheWiI6jiHmBPfw5gCp22gJcYPDNN6/1Q1xbQhSNN9pQ0CMNpevMU6tF5Dhu2UK1oEaYpGFL/L1tCbzumAgtVl9sDXNBC6vIk+dpY0eJxm97nn76iBwAxiQNYxZ0eEuSpo9IYmrIvqt13Z5a7HA3o/9bc3dW0hienltS2DBV4ZHR9VHRfYLT65sQWNVB9YYO0w6UVgZyw4m4xlG6YsAxvx8L9o4goyc//9oFQm+RCCzcaf3djWwC8eB7EO+W/Ae4anHh/ySU7xFT6V4OEdjLOi26Gam0c1Cn0q9jk66MI3/zXxpfKHMDhG3V4/T0FZ9SNBN7Y8hYgaUgPITviNXrbDRHU0z5FP0L8RvdbeQHWwApxMZyg40CxtZQ2aAbRVxbV9x157BZQzrecVgMImcTYzCvmU7AVYIHub3zj5pfACpO9+6frdm8RaHM48T7YzXxdSkUY4HAGQTOqTcAM+dHjptJ75cN7Cww8osgj4o8Rc4OoK5B3bG96aqAhbF0QqdfNvtI3WXyUdFZzrv3spOEvJ4BhfCQ47pA+sTFgrDa1vGZ8nM2fbgZ2XGylynO3yD+496G6/zQM8a9VCKSw6cmoyeWcBRB82c4ocpIp7sCCsmkiYRWpOhNPEhgz0yQTAOKvHeOBq27AYkWNE3n45se0korzeqgBb4889NUuk5oIVACik6s05wt2Uo2VFeZ53gLUxtzcTdD7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(186003)(122000001)(8676002)(38100700002)(7696005)(5660300002)(66556008)(64756008)(33656002)(478600001)(53546011)(9686003)(2906002)(6506007)(55016002)(26005)(110136005)(86362001)(316002)(38070700005)(76116006)(52536014)(83380400001)(66476007)(66946007)(66446008)(8936002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjBkRGM3K21GQXFmQjR5MVp0czFKamNTcUtyVTZnYnpVNGhpYVdQVnNrK2RN?=
 =?utf-8?B?M1gwYWo2Q2RmdGlCS0QwY0tqKzdNdzlORmFLcFJkTjFmaVF4RGRvaE12Nmdh?=
 =?utf-8?B?ZVBWMldkWTVoa05hcDVndldUZHpQdk1VT2xwRXJnNEJIV0loN09sUDZoYVBa?=
 =?utf-8?B?U2RtM1EybGplRjFpQ0VsdEQyMVFHZFhvU05va3JISi9IVDVFcG1GN3VmdWxE?=
 =?utf-8?B?SDJXaHIxRGxVdjJKT0JJY0RObFUySTIzWWZraU9CQ21IbzJyVkhLbXYxZndk?=
 =?utf-8?B?a0o5ZUhEdk05VXdWNUVoSmFVUmVTMDhib2hpd01zNEU4OUs5cDVuTGY1dmlJ?=
 =?utf-8?B?Nno1KytnaDRRT2dEeEtSU2c4S00ybDFGVFQwdWxHNjFKdUVuQUtzRkN1Y2V2?=
 =?utf-8?B?d3kwOXEvZGRmM1d5R1FYbDN4YlBQTHpYNk1tcGpaODhMdnVZTmVPZGx3bkNI?=
 =?utf-8?B?REc5bkZ1REwrREp4Tm43QlRwSnd0cDNTVWRGeGp3WXBYUXI1clBGWmlsdFFJ?=
 =?utf-8?B?cit2SjZ1d3ZOQTRzTHRNVWxjU2E4TTlXK1ZGdjYwSjhscHF6NnZ3a1o2WlN5?=
 =?utf-8?B?MEZoMGZ1QTF4SFZmMDVwS0cwMmdCZi9QV2xoM0Y2aEUyaTBJZGlvQTJkazFj?=
 =?utf-8?B?aHhZdForVGJ1UGVOQTN2UWdNN04vdkJUcEpiR2kvVTgxekt3M0ZZNGNnenVB?=
 =?utf-8?B?OWFiaStZY1A3TzdDYlcyTE5TMXJFSGhaMjJVOUVKWHQ5REdzRWpYREhjK0tw?=
 =?utf-8?B?K3NZQVNZMEU5MUxsUjdxSGYvUjRlZnAwSVJXUWFSUS9GVEFkQWpONGJxeVRS?=
 =?utf-8?B?YVpobXhqU3FpSGZQQSt5Ulp3VWE2cVYrNVVtWUNwZWJVUStnRXZqeGl2SFJD?=
 =?utf-8?B?N2l2b2lHcFFaSVg5MWZxUXZWNzBGV3FDUUxkay9kZFJuZ0xtSmxUYU96b3Z6?=
 =?utf-8?B?SjBGZTRnMWtqVU5zYUUvRk5LYUU0Zyt3ZXBmUmRoYTJISUVYbnZ2bWJiNE5h?=
 =?utf-8?B?U3JucW1iK21PajRaRTFrYmpOUEplSE44Sm9vSHJST2JlQzVxSFozT2RlUFNx?=
 =?utf-8?B?aWxGN0t6czlwa1RkRW5rZ2U5bXRPeEIvYklBWnQ3TFA5Z3B6NkdaNGhsOThU?=
 =?utf-8?B?UStxdko4ZEtWZFNRZ0k4Tk1ZbnFXeUZ0VFQ3V1Vua2FLL1BtWUFVY2dMUXBT?=
 =?utf-8?B?a0lIK3B4dTF6cjFTUlZOS2dwSjh2cjZGTGRHakZEdE5tb2lmekhlK2MxSG43?=
 =?utf-8?B?M1hCYzBWRjBYYWg3SlFMOGFNVG1FblhuUWZrS1U4c1NCTFVhK2EwU3IyTmpt?=
 =?utf-8?B?WFVJQU1vZDMyUFo0L2hQa2ZPQmhKSVJIL0VqZmxESUp1N04zWFhUZHMrcXo2?=
 =?utf-8?B?a1NwL1NkMm1SUkxmL2NidWdIN1ovVTFVUHNFaURkaVhnUmxFWnpDOTRjYUVR?=
 =?utf-8?B?eXF4UHBKeVo0YmEzendPVTB2NU1idDVncGl6VkcwOEVlMFR3eXlLVG1xVnZS?=
 =?utf-8?B?SUROVC9lVXJVMGtzY0pIZzM1NlZtT0NEdjVBNitJdHlZQzNzalgwSlI4TWUv?=
 =?utf-8?B?MTQ0RGl5bHM2TnVxTXdIQlJWYm1DSTJrTXg1MlJPWER2cXVuSit4R2gvdWN4?=
 =?utf-8?B?d2wwVkp2RDBBNFE1bmMxTkhlWC9HUFhzWTMyVUlPb1JIMHBrMEpPYVJ3VFAv?=
 =?utf-8?B?bFg4Z2hLR3daNjhNaU1rbko3VHVZQkNFbktsQWlDUk1rdDdJRjdWL2MrQlA2?=
 =?utf-8?Q?3SSYh0TMuJpxOdlwCeh5fwurCc08ZMYzhnYMDTH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c384d4-a49d-445b-c0a8-08d9693d78de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 09:31:38.9742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+mYtz0dfbJZ6g+KJcyUwnfkYciceU14we/rIEPRrHzSToSIt+I56tmI9nqnk0Aw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

W1B1YmxpY10NCg0KSGkgQ2hyaXN0aWFuLA0KDQpBY3R1YWxseSB3ZSBtZXQgc29tZSBpc3N1ZXMg
d2hlbiB0cmllZCB0byBlbmFibGUgbXVsdGlwbGUgNGsgZGlzcGxheXMgaW4gc29tZSBBUFUgcGxh
dGZvcm1zLiBXaXRoIGN1cnJlbnQgY29kZSBsb2dpYywgZnJhbWVidWZmZXJzIGFyZSBhbHdheXMg
YWxsb2NhdGVkIGZyb20gVlJBTSBhbmQgZXZlbnR1YWxseSBwaW4gZmFpbGVkIGFmdGVyIHZyYW0g
aXMgdXNlZCB1cC4gQWx0aG91Z2ggc3lzdGVtIGlzIGFibGUgdG8gc3VwcG9ydCBTL0cgZnJhbWVi
dWZmZXIsIGl0IG5ldmVyIGdldHMgIGEgY2hhbmNlIHRvIGRvIGl0LiBUaGlzIHBhdGNoIGlzICB0
byBlbmFibGUgUy9HIHN5c3RlbSBtZW1vcnkgZnJhbWVidWZmZXIgaW4gdGhlc2UgY29ybmVyIGNh
c2VzLiBJIGFncmVlIHRoZSBkZXNpZ25zIG5lZWQgdG8gYmUgY2hhbmdlZC4gQW5kIGNhbiB3ZSBz
aHJpbmsgQU1ER1BVX1NHX1RIUkVTSE9MRCB0byBhdm9pZCBlbmFibGluZyBTL0cgZnJhbWVidWZm
ZXIgdW5uZWNlc3NhcmlseSA/IG9yIGRvIHlvdSBoYXZlIHRvIGFueSBzdWdnZXN0aW9uIHRvIGZp
eCB0aGlzIGlzc3VlID8gVGhhbmtzICENCg0Kc3RhdGljIGludCBkbV9wbGFuZV9oZWxwZXJfcHJl
cGFyZV9mYihzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwNCiAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqbmV3X3N0YXRlKQ0KIHsNCiAgICBpZiAocGxhbmUtPnR5
cGUgIT0gRFJNX1BMQU5FX1RZUEVfQ1VSU09SKQ0KICAgICAgICAgZG9tYWluID0gYW1kZ3B1X2Rp
c3BsYXlfc3VwcG9ydGVkX2RvbWFpbnMoYWRldiwgcmJvLT5mbGFncyk7DQogICAgIGVsc2UNCiAg
ICAgICAgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07DQogDQovLyBXZSdkIGxpa2Ug
dG8gcGluIGZyYW1lYnVmZmVyIHRvIHN5c3RlbSBtZW1vcnkgd2hlbiB2cmFtIGlzIHVzZWQgdXAu
DQogICAgIHIgPSBhbWRncHVfYm9fcGluKHJibywgZG9tYWluKTsgIA0KICAgICBpZiAodW5saWtl
bHkociAhPSAwKSkgew0KICAgICAgICAgaWYgKHIgIT0gLUVSRVNUQVJUU1lTKQ0KICAgICAgICAg
ICAgIERSTV9FUlJPUigiRmFpbGVkIHRvIHBpbiBmcmFtZWJ1ZmZlciB3aXRoIGVycm9yICVkXG4i
LCByKTsNCiAgICAgICAgIHR0bV9ldV9iYWNrb2ZmX3Jlc2VydmF0aW9uKCZ0aWNrZXQsICZsaXN0
KTsNCiAgICAgICAgIHJldHVybiByOw0KICAgICB9DQp9DQoNCg0KQlJzLA0KWWlmYW4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IA0KU2VudDogRnJpZGF5LCBBdWd1c3QgMjcsIDIwMjEgNDo1MSBQ
TQ0KVG86IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGp1c3QgZ2V0IHBy
ZWZlcnJlZCBkb21haW4gcG9saWN5DQoNCkFtIDI3LjA4LjIxIHVtIDEwOjQ1IHNjaHJpZWIgWWlm
YW4gWmhhbmc6DQo+IGN1cnJlbnQgcHJlZmVycmVkIGRvbWFpbiBwb2xpY3kgaXMgc3RhdGljLCB3
aGljaCBtYWtlcyB2cmFtID4gMjU2TSBBUFUgDQo+IG5ldmVyIGdldCBhIGNoYW5jZSB0byBhbGxv
Y2F0ZSBzeXN0ZW0gUy9HIGZyYW1lYnVmZmVyLiBDaGFuZ2UgdGhpcyANCj4gcG9saWN5IHRvIHRh
a2UgdnJhbSBtZW1vcnkgcHJlc3N1cmUgaW50byBhY2NvdXQuIElmIHN5c3RlbSBzdXBwb3J0IA0K
PiBib3RoIHZyYW0vc3lzdGVtIG1lbW9yeSwgcmV0dXJuIHRoZSBwcmVmZXJyZWQgZG9tYWluIGJh
c2VkIG9uIHZyYW0gDQo+IHVzYWdlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8
eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuYyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gaW5kZXggNjVhOWIyM2YwYTQ2Li5lYTNiMDg0ZTNjM2Yg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4g
QEAgLTE1MzAsNyArMTUzMCw5IEBAIHVpbnQzMl90IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX2Rv
bWFpbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICB7DQo+ICAgCWlmIChkb21haW4g
PT0gKEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gfCBBTURHUFVfR0VNX0RPTUFJTl9HVFQpKSB7DQo+
ICAgCQlkb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNOw0KPiAtCQlpZiAoYWRldi0+Z21j
LnJlYWxfdnJhbV9zaXplIDw9IEFNREdQVV9TR19USFJFU0hPTEQpDQo+ICsJCWlmIChhZGV2LT5n
bWMucmVhbF92cmFtX3NpemUgLQ0KPiArCQkJCWF0b21pYzY0X3JlYWQoJmFkZXYtPm1tYW4udnJh
bV9tZ3IudmlzX3VzYWdlKSA8PQ0KPiArCQkJCUFNREdQVV9TR19USFJFU0hPTEQpDQoNCldlbGwg
YXBhcnQgZnJvbSB0aGF0IHlvdSBhcmUgYWNjZXNzaW5nIGEgcHJpdmF0ZSBtZW1iZXIgb2YgdGhl
IHZyYW0gbWFuYWdlciBhbmQgaGF2ZSBtZXNzZWQgdXAgdGhlIGNvZGluZyBzdHlsZSBJIGRvbid0
IHRoaW5rIHRoYXQgdGhpcyBpcyBhIGdvb2QgaWRlYSBhdCBhbGwgZnJvbSB0aGUgZGVzaWduIHBv
aW50IG9mIHZpZXcuDQoNClNjYW5uaW5nIG91dCBmcm9tIFNHIGhhcyBzb21lIGh1Z2UgZGlzYWR2
YW50YWdlcyAodW5zdGFibGUgb24gc29tZSBIVyBnZW5lcmF0aW9ucywgbW9yZSB3YWxrZXIgb3Zl
cmhlYWQgZXRjKSB0aGF0IHdlIGNlcnRhaW5seSBkb24ndCB3YW50IHRvIGVuYWJsZSBpdCB1bmxl
c3Mgd2UgZG9uJ3QgYWJzb2x1dGVseSBuZWVkIGl0Lg0KDQpDaHJpc3RpYW4uDQoNCj4gICAJCQlk
b21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7DQo+ICAgCX0NCj4gICAJcmV0dXJuIGRvbWFp
bjsNCg==
