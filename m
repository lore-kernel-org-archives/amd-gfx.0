Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF4C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 06:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8D2207AF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 06:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8D2207AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11DE6E462;
	Mon, 21 Dec 2020 06:43:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CE16E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 06:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPR8bqdQw5Sz1HAKSwVtSQQYF4CGTFkAjDv/FNTB4aBzJw8POeD6kQ7elyp2JXerbDY1mR3sR0BBFJ4Pk7QNNjqD+nOgrcQiIahRFAIq7mQnmGHEuwYupho6X6fFfxMliKHMGINsXVAJ43Q/TH0sB6NcRMSAQ/aVL71uVsk4vfkxZBzHwN9caLbTEG8UdQ0DbSmgbGeGOEodf3lmcBYTJs9amQsiOYhbSXTXSoIvz68b78vxQR5VKSkezIXFSUHyeTVl3bVxRYDoTOACFPM7awXMz67hj4FkHCpzJjd4TLsK4k0MJ/mskzATu4NCXyr4HI8ZovDTNE79ICR//592Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7dcUoBlz4BuEFDNY35NMug+NND/5cBNdEFQ8x1YVvA=;
 b=ogp1B37IRg0n1kMbmOfxrNWpfzcEViGNcqZU/lT9l8loxai2pq0gDb/1wRgVgLvsT1wVsBxuCPz7P+jbG4dsZ7NjaIn2oNjfni+E/+LUIzN/EkoZZ6vzsBB9XM1xYKF7Xyl6IiPSZQtkTIU9kEhopwC1FLfNlLThPRbxrDVj0/vLmyPY6W0uCcvsfbV9gx+WYgetv+qEp+pcWbDiZqp0Zv3oxWoGqVoqh8WEOIk5GsR0l9Fo3sPWjPrmOH1VKRLhjX6Wpa+/glRU6rg8zOSksi9sTY9oEWKYNHzxFBFfXro/is7igpZoojyYZSp6eEG+xUzWW3njhBeu1oplWqdGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7dcUoBlz4BuEFDNY35NMug+NND/5cBNdEFQ8x1YVvA=;
 b=euQ0mSN+BCp0jypM+yLcYNlnk9iW+vFqd33SsqlqwJUTk93gNvfU0j/qiGBp2XpqfSmuskS9giFngPoNna4XgvGYedEvZcjdAI7uL0CGT/M2CD4PTnE7IlrSEndpfjHvHMh87WLWIGDc3iOxSFhcZ1lpjEeMeBk+1sajimtO+M8=
Received: from BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31)
 by MN2PR12MB3904.namprd12.prod.outlook.com (2603:10b6:208:165::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 06:43:21 +0000
Received: from BL0PR12MB4707.namprd12.prod.outlook.com
 ([fe80::c9c3:9ac3:102c:226d]) by BL0PR12MB4707.namprd12.prod.outlook.com
 ([fe80::c9c3:9ac3:102c:226d%3]) with mapi id 15.20.3676.029; Mon, 21 Dec 2020
 06:43:21 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: de-initialize software ih ring
Thread-Topic: [PATCH 3/3] drm/amdgpu: de-initialize software ih ring
Thread-Index: AQHW11wt1712gt0HdES6z4EQOkr5GqoBGi4g
Date: Mon, 21 Dec 2020 06:43:21 +0000
Message-ID: <BL0PR12MB4707CDCA40E938D70DA8FA9CFEC00@BL0PR12MB4707.namprd12.prod.outlook.com>
References: <20201221054244.7421-1-Hawking.Zhang@amd.com>
 <20201221054244.7421-3-Hawking.Zhang@amd.com>
In-Reply-To: <20201221054244.7421-3-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T06:42:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=87a747f3-8331-4174-874f-0000df877e07;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-21T06:42:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7cfdfc48-39d6-4e1e-ae8d-00003f8f302e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4534c5b9-ed73-41de-358f-08d8a57bb583
x-ms-traffictypediagnostic: MN2PR12MB3904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3904610DBE328C25E44C07D4FEC00@MN2PR12MB3904.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlCgaLRGS77bWoT7iXwaznEcG/2n6Bc8VTsKbtqefmoqRhaNMqURTskI0Pko1gBs8lKkETH5wqce0BwyhtBQlklHabPIrVrI5B8FnnNzVwJOzxuLvb+K6ovj6lFI2mctJ/Gk21xbwYiLunzBTOm0vGMfk4Jg6oZ0oASN+z3kOuuzXABySrssCqGa5VZ4Q1EDqYNvjboez/y6Rhf1LrNeKT70nKvNSG7Y0BmuxlCOhfAMSoQvVJGzhWjEhrAUelas+p76/1tpIorx016+LRAr8d4D/aLPHPDLiPpnxV8Eqpqdd5wTQvmXFPSyu/+65Pkl7c4AH1VM0cy7kHU8RPs9HUr4Xt5SuWhM8TfwZDUAbv49UFnRq4gnWvWnv9tKQrdwBBeMYKczBuBakjS/+C63Uw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4707.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(2906002)(316002)(5660300002)(110136005)(7696005)(8676002)(55016002)(83380400001)(9686003)(71200400001)(26005)(53546011)(6506007)(66556008)(52536014)(66476007)(478600001)(33656002)(64756008)(66946007)(66446008)(6636002)(76116006)(186003)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?U3lVTmIvMEJwZmw2RTFDaHZwSlROV293ZW9Ed25sdVpkTDdIUTh1cnlwcitY?=
 =?gb2312?B?WW1CcWVpazd2RWZRbmNaelpoQXVYaC9oSW9lUXgzdDdTa0xTWVI4L296Tjl0?=
 =?gb2312?B?ZWdtVlRLelpYTHhScHJncUtNUUlSZjJQVWFJT1dXL01TNzNkZ0R1cXlZQUt2?=
 =?gb2312?B?L25wWWRCT0QzZVQzS0NoRCtwdzhKd0JuODk3YTJlYzh4MDUxdEJ2Mzl0ZFlW?=
 =?gb2312?B?bjByMGZ0dmE3WDBZekZraktyZUFjZzI5bVJBNkRBVnVBVjFtaEUxZWxwWTVK?=
 =?gb2312?B?ZUdDb2lxV0dzSk9JNTRhWFVoTmllMGFUaVVwdWdVZXdUS3JYdGFHOG5lOFdC?=
 =?gb2312?B?a0p6WjhKZ0dEUzl0OElJclo1NDcxOG5SQ2hWQUgxdmw2WUlrdGVzYnB4YXpk?=
 =?gb2312?B?a2c2RVg2UUZLMXpBMUViRzJncjh3empPbkp2eUEvcUcxZEUxc1cwV0FwQzJV?=
 =?gb2312?B?WDdwczJXdXZtbXNIYld2TlhVM2d2ZDQzL1p3S0pUSmRzQlk2Vy8ranNFVWZl?=
 =?gb2312?B?R3JESDlDLzlnRVgxT3hzMjFmYy93azFLTUpPMys4eEo5eVhZbFBtNWdGeHYx?=
 =?gb2312?B?d0pyL05mbWQ5QmduUVdkdFJ5eEFrYndlWGNZQUF5SmlIa1RJRDArVW1CMEpE?=
 =?gb2312?B?N1N5ZFNMeVZ6V0tpOWJhVFozL2RiU0NTWExJV1FFNWh4L25Gb210SVNZZU00?=
 =?gb2312?B?L21pd21jbkduWFM3NWp6SndnV0xweU5ib1hjbE1pUVJkTit3WTNWYWN3OElG?=
 =?gb2312?B?ZVBJR2tFNG9nNyttS3I1TGEzbXliZHc3ZzhCRUJtNWgxWDk4Zi9oV0l2RDBj?=
 =?gb2312?B?N1pTQlVkbXhWSk9Jd2NjNHQraWV3TFRRNUZDSmRVNFhNc2dyTkdNQ0syRElL?=
 =?gb2312?B?T25UL3JtZE5BZUNmdVBSRmFoaEQxVVBMT2Y4SmE3VnFNQmtPL0pEYmhESWxR?=
 =?gb2312?B?R1YrNWoyLzBqVjJiYXpxbFdQeXJzanBTSVlPQXhkS2pUcWYyY0Q4TzEycWFJ?=
 =?gb2312?B?ZkY4ZXNZN0kxL0d5bTVlaHd4NzFmdEp4L0ozdFcydlh3ZkFkQklkdVROUXQx?=
 =?gb2312?B?OFFHRHhZUXJHeFYybGJDdlM4RzFwZy80N0E2b3NYOHJ3MlVKbXJHVWxVTHdt?=
 =?gb2312?B?aHprVHNFTnR0bTVWd2NNT0U0NXVmVkEwMzh0am1WTTgxT2JsS25ZQ0lkSEJ0?=
 =?gb2312?B?OWJKQ3VYTS84dzRXVmZVL0RwclJBN3hmR1VIeGhMVHVsR25CTTdpTS9UUXZG?=
 =?gb2312?B?aDJQRFozdVFzQ1AxbzBGUFM2dTVFY1FiSlBHS1dSSGpZMlY4cjVLWmZhbVlK?=
 =?gb2312?Q?wImLqOSvy8/uI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4707.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4534c5b9-ed73-41de-358f-08d8a57bb583
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 06:43:21.5781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1sCKcs0Jy6SsMAyiydUOzr+VK88eRZAqeaQ3cI/Pek8bx+FnKa0448X6Q5jCeKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3904
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KU2VyaWVzIGlzDQpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+IA0KU2VudDogMjAyMMTqMTLUwjIxyNUgz8LO5yAxOjQzDQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCkNjOiBa
aGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDMv
M10gZHJtL2FtZGdwdTogZGUtaW5pdGlhbGl6ZSBzb2Z0d2FyZSBpaCByaW5nDQoNCnRlYXIgZG93
biBzb2Z0d2FyZSBpaCByaW5nIGFuZCBpdHMgc3RhdGUuDQoNClNpZ25lZC1vZmYtYnk6IEhhd2tp
bmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L25hdmkxMF9paC5jIHwgMSArICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
ZWdhMTBfaWguYyB8IDEgKyAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMg
fCAxICsNCiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9uYXZpMTBfaWguYw0KaW5kZXggMDRjYzQxYjgyNjYxLi4wNjAzNTc2MjU1MDQg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMNCkBAIC01ODQsNiArNTg0
LDcgQEAgc3RhdGljIGludCBuYXZpMTBfaWhfc3dfZmluaSh2b2lkICpoYW5kbGUpDQogCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0K
IA0KIAlhbWRncHVfaXJxX2ZpbmkoYWRldik7DQorCWFtZGdwdV9paF9yaW5nX2ZpbmkoYWRldiwg
JmFkZXYtPmlycS5paF9zb2Z0KTsNCiAJYW1kZ3B1X2loX3JpbmdfZmluaShhZGV2LCAmYWRldi0+
aXJxLmloMik7DQogCWFtZGdwdV9paF9yaW5nX2ZpbmkoYWRldiwgJmFkZXYtPmlycS5paDEpOw0K
IAlhbWRncHVfaWhfcmluZ19maW5pKGFkZXYsICZhZGV2LT5pcnEuaWgpOyBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92ZWdhMTBfaWguYw0KaW5kZXggMTU4MTExMzQ3N2NmLi44ODYyNmQ4M2UwN2Ig
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMNCkBAIC01MjQsNiArNTI0
LDcgQEAgc3RhdGljIGludCB2ZWdhMTBfaWhfc3dfZmluaSh2b2lkICpoYW5kbGUpDQogCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0K
IA0KIAlhbWRncHVfaXJxX2ZpbmkoYWRldik7DQorCWFtZGdwdV9paF9yaW5nX2ZpbmkoYWRldiwg
JmFkZXYtPmlycS5paF9zb2Z0KTsNCiAJYW1kZ3B1X2loX3JpbmdfZmluaShhZGV2LCAmYWRldi0+
aXJxLmloMik7DQogCWFtZGdwdV9paF9yaW5nX2ZpbmkoYWRldiwgJmFkZXYtPmlycS5paDEpOw0K
IAlhbWRncHVfaWhfcmluZ19maW5pKGFkZXYsICZhZGV2LT5pcnEuaWgpOyBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KaW5kZXggYTFkNGQ2N2Q1ZWUxLi41NDg3MjYyNTI3YWEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMNCkBAIC01NzEsNiArNTcx
LDcgQEAgc3RhdGljIGludCB2ZWdhMjBfaWhfc3dfZmluaSh2b2lkICpoYW5kbGUpDQogCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0K
IA0KIAlhbWRncHVfaXJxX2ZpbmkoYWRldik7DQorCWFtZGdwdV9paF9yaW5nX2ZpbmkoYWRldiwg
JmFkZXYtPmlycS5paF9zb2Z0KTsNCiAJYW1kZ3B1X2loX3JpbmdfZmluaShhZGV2LCAmYWRldi0+
aXJxLmloMik7DQogCWFtZGdwdV9paF9yaW5nX2ZpbmkoYWRldiwgJmFkZXYtPmlycS5paDEpOw0K
IAlhbWRncHVfaWhfcmluZ19maW5pKGFkZXYsICZhZGV2LT5pcnEuaWgpOw0KLS0NCjIuMTcuMQ0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
