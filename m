Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66931C47089
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 02:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C50461131
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 02:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C50461131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867EE6E02F;
	Fri, 28 May 2021 02:57:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2396E02F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 02:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcu5jF8SBk2VRTlMDBEpAUs0Tqb+vAKPKCkNWLfK/8GZT2kQqgPwbBrGmEhtif/cKN3H+cpEF38ms2P8yKI895Syx9xwGD3dzsJy2QHqsTJQ3+CYXD0Ik7H3hlNjUxzBacgJJEzFRkMKCTN9c3zRYczTq5U9LO2fC8IkxxLlcM28ZFfp+9qR3ABRfTstoHAm0kobvCKIROMfLF0KjpREI3GTh5s/LAjgUjxbjjIFEP2j4gV4L/UHX/1R8Y0cb0sTm0SVvdeHqlaEtBvjBZ0UXREt4WYZREnoJho9e6HHCzx09yl1eQR6yMV50Ek/dv7vzshVzYLPOC79/lsEx8bvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvSIJQjzmiGI9RnuxmEGBsqcCHfOBtKOvhqSgr3aB2U=;
 b=W4R+T4BurM9G30++qQMATHXywHoKhfyyLWWW0yRVlpB/vTImq5LTTHIQNZhS2MkqG87vxst+K8Mjr65sMs/tTvPhd47C0GGJ+bN4cyNzMDI+fN4oNPsV489NdYhxWN6IlAMjLaBrY7PUJfeUQX6WUbQaUcpZVPxRJz2hayrFkimnC8I0WJ8IL3s+1b1yueao8ZhzlmCWtzvlSrrXyK+hPlupih+3xA+1ff2fJIEBQ8w/4abBjqBVDiJY4yQMuhuwKoJgig1DeBM+qHNZEJKHrS2xQOXd+DBDtJjDE0EeqGfVpwMo2/nmtKoLxB3PLM2u9pxSeSimsBFdNyNaL7gv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvSIJQjzmiGI9RnuxmEGBsqcCHfOBtKOvhqSgr3aB2U=;
 b=27liwBLVsecrke/PNFVemCk8pQRBHWHGpClyeFT4fDSz6fzEDNIeysOgkzhW9sEU+DfA+dbop1xovG4QmhnKPzb29TxBuZuTfh7ZIHR9s5eQHriu9pyP8T57seR2UfDcdvPByDO0VPWCr+oYTn9UgzLd7QKcBnEdeLmh93eKDJw=
Received: from DM6PR12MB3196.namprd12.prod.outlook.com (2603:10b6:5:187::27)
 by DM5PR1201MB0041.namprd12.prod.outlook.com (2603:10b6:4:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 02:57:43 +0000
Received: from DM6PR12MB3196.namprd12.prod.outlook.com
 ([fe80::2477:9f69:235:8392]) by DM6PR12MB3196.namprd12.prod.outlook.com
 ([fe80::2477:9f69:235:8392%4]) with mapi id 15.20.4173.020; Fri, 28 May 2021
 02:57:43 +0000
From: "Zhang, Morris" <Shiwu.Zhang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>
Subject: RE: [PATCH] free the metadata buffer for sg type BOs as well
Thread-Topic: [PATCH] free the metadata buffer for sg type BOs as well
Thread-Index: AQHXUizRp6+Ztr8pF0aiomc4snQOhar4NW6g
Date: Fri, 28 May 2021 02:57:43 +0000
Message-ID: <DM6PR12MB3196FCEDC698619B3251397FF9229@DM6PR12MB3196.namprd12.prod.outlook.com>
References: <20210526034625.5805-1-shiwu.zhang@amd.com>
 <152919d2-6ded-3121-1be5-a423cfd3b531@gmail.com>
In-Reply-To: <152919d2-6ded-3121-1be5-a423cfd3b531@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-28T02:57:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3c9c2649-0dba-4eb2-9268-ec3503562848;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e0fa48d-54b1-4237-1502-08d921845d5c
x-ms-traffictypediagnostic: DM5PR1201MB0041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB004190F24F5756C646B29046F9229@DM5PR1201MB0041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoMP66ID/FEMA9mZ/8937fPTMswc232O6I5SDvMF/6PnSUmq3pt3M/2GFOhWhj1oM/MdPOI6qptzvxSzqzu/nOpp8VoxTBnuwVgvNOpxyz98W+1VREsyu6RHMYgKFkrkHW6UfE/wEcojQmRO+I9oUlkaHrQspj9FiBHldlJ6Lbqf8WdOeyO0HArjh58ul2u1HjkkdzT3y4vb9trr8Bep7KsL/EfTjxVVQAblkJIbOQjLu7feqIM+dKRl6Lx1S79zGMzfsePRN9prF9ZrBowuVDq9fvMWtCnFrwYgaDFh2AsRpW55wRYa6IxBkiP3yqUevS8B3QzkGMVqB/I7ZXk15Bfb3XETZJ13wJsVevNfw1qx/k9jQQqf9dqPkjWTIooLpugcaBGZQuRm+ObyRhxxID8rdG4uyK0pElmO47Hy9nBSjwEKTOg22cl8UbHQ/3Ju2WfUlQMujojXWOUj3r21388X8OG2k7KfLKxPRGwH6gHZ3ooIdlCC3i5R9fls4RLcZZb3fXZAs37sXVUWvvMfepHzTOMfAl2oKxvdJRmi82tzPJaqTMxeE8+vbDVABjR/FQ5iccyI6jj2VvUicuRW3onvBSruYtdosTgZdkJHdkc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3196.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(396003)(366004)(376002)(66946007)(2906002)(76116006)(5660300002)(71200400001)(38100700002)(122000001)(86362001)(52536014)(66476007)(66556008)(64756008)(66446008)(6636002)(55016002)(8936002)(316002)(8676002)(110136005)(478600001)(83380400001)(26005)(33656002)(9686003)(186003)(7696005)(53546011)(66574015)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WlBwY2Z6cFhWcDJheGM5a0o5czZ0YXd0cFZoUjNSaDF1ZGRvRjRVMERCVGNj?=
 =?utf-8?B?RHJobTNEeEdEdFpwUnlRZFVpYlVweUtEc1lPd2RZckdyN2lOeGQ2bGkwVjNy?=
 =?utf-8?B?YUdoZWErS0dkUFljRDZraGRPK1llcVJJbStRYnp6S3I0Y2plNXhkVWgreFB5?=
 =?utf-8?B?TkVpWUc5Qit6QmI1S2w3VXZUSis4T2o2Y1JpOTZFaXdwZVlkK2xJUGdxMm8x?=
 =?utf-8?B?Y0wwc1AvVVdvWWgyZDRaSDA3aURyc0M2S3REMFhlOFlJbkJySTFYdWZnSXhy?=
 =?utf-8?B?SHNPLzE2STJSQ1FnaTY4bFFDOVhQS2ZQNnRtSUJTSWRFV0x1eVcrQ0FLRUlT?=
 =?utf-8?B?T1g0Wllld2Z3SXVOTFJJalgvSnQyVWJucGZWeW1ieW1TMzRURlhCUFlHdFNB?=
 =?utf-8?B?TnVRUDQ5N25ia3IzaFVGSEV6Zm9YV3haTkpYZVBKUVA0QnZxN2dhdUhyaEFa?=
 =?utf-8?B?YnUxMDJnZTVGME1oZXE5TjY2aHVXZis5c1owMk9pZ0gwOU00VG0xMnlHcHFE?=
 =?utf-8?B?OHBVYldOK1QrMGFMOEdrbm9VYjBMS0l0UGZEN2FaajlNZno3a2RNZ2RKQkdv?=
 =?utf-8?B?VlFvRzAzeXovVDk2N1ZxR3dBa1pXL0lZV2xaWldYaExzR3Z6elBKeFc5amU1?=
 =?utf-8?B?ZDIydktKZGVKYlVDaFcrOEhzTEk0MERJZlBFcm9rdGxWMlRjNFNtTU9rai9v?=
 =?utf-8?B?Z1JXKzBMbGdzWmJnL01wUFZ6SHNtZm9aWFNUcVMzZFBwWWVUK1I3dTRyWEpV?=
 =?utf-8?B?Y3NaRHl4Z21YTmhCRHpOSGFJNWM5SmVaUXVvS2NUSEdvekk1S0p1dVNrb1hX?=
 =?utf-8?B?NFR4OCswWkJkOGpEeVJabDNuS2VXd1Z2SkxmN0V6TWE2NWoramFJeHR3ZjlG?=
 =?utf-8?B?eVZFSm5nSHUrMzhOc1hOOG5Lbmt6eWVMemI3UytXcEphR2tYbjM3Y0E0QTQ4?=
 =?utf-8?B?VC9PMVNmVURBWElsajZob1UzMXdhTHV3RVJmR0gxVGQveXBybzVOci9kL01v?=
 =?utf-8?B?VDVPUy9uSldHbm9hTnBHTytlbjYzTE10c1Y5Nm1qZHlVcWUwZEJLUytyck5l?=
 =?utf-8?B?WmZyeXVqY2daQmRnM3JLTDdNNWEraEthVnd1SUNia2owUkwrQW1pbFFibVRw?=
 =?utf-8?B?bEFPQ3ZSOWNSamZneDdVVzJ4bE8yVFBWMmRIZURoWUxmUVVqRzRtT3gyaVYy?=
 =?utf-8?B?NmxWNUIrRW52VjN3aUg5VnhITjdHNW85dlB3TDllMk5tS3VvQUJiM2JtTGoz?=
 =?utf-8?B?ZkUvZXY5Q01RNGFBcHdHand6MEJoOUpOeWZ0b0RTaTVmeGxJNHBsYVhma1k3?=
 =?utf-8?B?dGNPZXRSME1QWWovQ1JTTlp0VnExaFI4bW1sT1lFU3BVWDUveFpTN0RjWEkx?=
 =?utf-8?B?RTV2MndQeFpHVGgvNW84anBnWXAzemNqd2wzYytVR2RDamF5aCtoUG51TjRX?=
 =?utf-8?B?MFoyYjVDNmNLQ3EyRUd0ZXhjcWEyRXRFOGdWUDVSUHhqaVpxbmJZa2xtTGpC?=
 =?utf-8?B?Q1FXM1VXdzBrb0pFeFBkKzRiaVVJaFRGQ0Nuc3UzY2s4KzFvT1orbUlQKzZn?=
 =?utf-8?B?Z0ovZDhJdjFYQ0dXd1JCd2ZpZVFKOHltV3F5T1hpNjZNVEVxUDJlWC9lVHM0?=
 =?utf-8?B?RVFZajFlaDJCZXRSSzR4bDVla21QeEx2bUFXTy9iMGdoM1IyY0pWaGx5UmxJ?=
 =?utf-8?B?c015d2pHdWY3a0c5SW9XT05CNlN3d3dyT1pKdGxvTVllM0hnT3dhT2dOL296?=
 =?utf-8?Q?dwCROHq7kGCaWfOp7XitC87AtxjQRJmdpaSeBsq?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3196.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0fa48d-54b1-4237-1502-08d921845d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 02:57:43.3612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcKFfLmbzo2i/lgVEaa6BgKynHi5Qj5FPRFuteyKyuI80kzdGd7c/25bTGV9FxNlyhYGnzQ92M6p+nsJQeaqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0041
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBEYXMmQ2hyaXN0aWFuLA0KDQpNZXJnZWQuDQpUaGFua3MgeW91IGJvdGggZm9yIHRoZSBjb21t
ZW50cy4NCg0KLS1CcnMsDQpNb3JyaXMgWmhhbmcNCk1MU0UgTGludXggIE1MIFNSREMNCkV4dC4g
MjUxNDcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7Zu
aWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwg
TWF5IDI2LCAyMDIxIDg6NDQgUE0NClRvOiBaaGFuZywgTW9ycmlzIDxTaGl3dS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERhcywgTmlybW95IDxOaXJtb3ku
RGFzQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBmcmVlIHRoZSBtZXRhZGF0YSBidWZm
ZXIgZm9yIHNnIHR5cGUgQk9zIGFzIHdlbGwNCg0KWW91IG5lZWQgYSBjb21taXQgbWVzc2FnZS4N
Cg0KQW0gMjYuMDUuMjEgdW0gMDU6NDYgc2NocmllYiBTaGl3dSBaaGFuZzoNCj4gU2lnbmVkLW9m
Zi1ieTogU2hpd3UgWmhhbmcgPHNoaXd1LnpoYW5nQGFtZC5jb20+DQoNCldpdGggdGhhdCBmaXhl
ZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jDQo+IGluZGV4IDJkODc2ZTFlYWE3Yy4uZTlmODcwMWZkMDQ2IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+IEBAIC05NSw3
ICs5NSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9ib19kZXN0cm95KHN0cnVjdCB0dG1fYnVmZmVy
X29iamVjdCAqdGJvKQ0KPiAgIAl9DQo+ICAgCWFtZGdwdV9ib191bnJlZigmYm8tPnBhcmVudCk7
DQo+ICAgDQo+IC0JaWYgKGJvLT50Ym8udHlwZSA9PSB0dG1fYm9fdHlwZV9kZXZpY2UpIHsNCj4g
KwlpZiAoYm8tPnRiby50eXBlICE9IHR0bV9ib190eXBlX2tlcm5lbCkgew0KPiAgIAkJdWJvID0g
dG9fYW1kZ3B1X2JvX3VzZXIoYm8pOw0KPiAgIAkJa2ZyZWUodWJvLT5tZXRhZGF0YSk7DQo+ICAg
CX0NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
