Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E2C433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 15:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750DD208C7
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 15:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DHZXAKuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750DD208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AB06E179;
	Fri,  3 Jul 2020 15:29:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87746E179
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 15:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O30riP3SMFkryDSEmcrOxvl7n2rkzcrP2UP2v4SZ8O6TmW9yxQGEZGbWmzz2ZyeqkHK/u658Id/ujuqtJnR3fkrepkj+99aG6W5hp9Hnq4bvq7+LMxI0gyrTWIdezAeibcZinW4zjdL0PyvGWHXOxjbu94e9Du1J91Z/x+qr72BEM1Hts4SFxQ18dJBep9uKtQnGc1MQwH90owNkzw6xeg3C3PU94iLWvvtiV3azluzhcyYji2sfxbuT/z8KuTyM7yTqTY/WKS7019F5QITKH8SVglD7R/rWTzKfaQomkrTK/vErS68ZjJoHk2X2CErBUAwU03CUQq+1OunKPgLbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6yUdBO9RAF+aTmX5tTgG4Z7zLC4jgQr+Gc6kvCPf7c=;
 b=LgQ8m6iXaN/5LKIS3cMlqKSvC539UlgOKsW8yiLDUE0ATWzv6GMOqEhA2cmT4LkHQZLjsxeeZJp3fxortVO/9coJx6KSQYPsDMOxvUz9OpIbtVC2qhmMK/3cXgN0Z2RJ/QHqHIISPQCFdjpAd7uocV2fUtZ33G6On9ZmiJzR0tWkrfgdx3/GriS2TGzsYxfaaQOkODYsSiWo+1VBTfkOWXPyEvSt40zcIN/6Ie1CN1baLXXb/i6m+rBTGclpgQNn/NDeEZPM9xPwLp+qplQw1Co7SHR/A97wMSkl2pI9jnA3dcUV0cdbRFQKkjUT6pqQcpwfxkxCUmNY/+CbCSbFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6yUdBO9RAF+aTmX5tTgG4Z7zLC4jgQr+Gc6kvCPf7c=;
 b=DHZXAKuG8uuoKf/VZqm8Fc/PIrXQgoRQbzEvlzmtr3lFV3aRAL3Je1oRMqIduQ2cGILZ3otcap6Pb51ARQNcr4Llyk3/iCCsvUOidB6OqiLm7IdCGIQCpg61ljGi6TKV5zEV4vFnqXvrjZ+yrO5r8FD4+cSb1MitHD7PTMDCLsc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 15:29:12 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 15:29:11 +0000
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
Date: Fri, 3 Jul 2020 17:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200703142939.28663-3-pmenzel@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR08CA0029.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::42) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:208:d2::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 15:29:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2fdc63b-774f-4475-17f0-08d81f65d615
X-MS-TrafficTypeDiagnostic: MN2PR12MB3839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3839DDF6540974C5A811898E836A0@MN2PR12MB3839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUAm/PbnchD8TRuvdQ1Rp40ymHhW7Y2rD+HrJARenBrPD4ychM8avMHTHRIeED8f20D38GOffy+rUNfxM2DuTRuMVfRn/tbdvufWmAYvxEz1ALtHvc1UlTILOa1n7kqaGt5tvkOZIVbyl3GqwVU+duyWEfi9TWxuhBczgtemr8CdxpFoxQhzzMLztDKxzdpbVNiBToZixMHsM6iXn/hwi/HqpixAQ4JAX+jLHv7wYfFkQcbuXShgB15yMSWAUiw9PyUfocF/LrAtRwBANz1JbFtGN9d73341Co2RzQnIEFxYFUx/A0Ga/nAPUwUii00lZXja7dOd5vHHuBCzd+oYu2z2BS37cMf7Wqxid6nGTE9CBwnWDHJcxHMA1zArCb4Am8/igHSixMVVAeb6MM/4oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(31686004)(16526019)(316002)(5660300002)(186003)(2616005)(8936002)(8676002)(66556008)(66476007)(110136005)(52116002)(66946007)(4326008)(86362001)(478600001)(31696002)(83380400001)(6486002)(6636002)(6666004)(2906002)(36756003)(81973001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u7O+ZgBM9Oh1ZD2FAo4CcndV00am0qttbvzIt5uOaAlSynLXjlfA9EPlBjM0d0/yYFG8GgP5jkLP0tLWsnthkvoGCkbcQ1woI/5PayG9ZYA3DbzQCL+MZ1IzG7qrP3WwwMbXv7KmgN+fOIwDG92X2xyY3Kd2wrKDciRh09U8LNW5LyM95NUJjBziTTOYXIhqQRnlE0M5f5Bd1VRkkU0E0HI8PhjoFTNwzXyUGfR4vq8T+hAXaqRpgcpReIR+3IYx0eFW7OlFfiI2ErFwt7aXefI7IinaTUAp1QnMqH7JmdmOBfOcAxGULvXTJLIWfYhWzOnVrpIV7THYAg3wRh95pP2exwLRO/VPa/LrzYnvbBZ/2fow4Zq46L+jNFEZ2JCCsGTvEdGJh576yvxrDilEaqNwlp3D5sXKKimVU7mtb/puvEl2VRXaOBTI86wrWsYauAWcG7JCp/NUKSYYifMsKYtGMl/crx0p5w4Py/XqT+NL1/OJiTVBwY945V2nGwV8zQb4+8TBMZGPyS9p+nJ2xEc+gzXr3D5M6/1RkFsNnXRpOopnoDMwD3MRl/OR1Rtb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fdc63b-774f-4475-17f0-08d81f65d615
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:29:11.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZiT2I58EHHSoOPzrgtqd9OMVBMJbokNwM8rrusKJAPY/Im2hWXaDRtzD2Wf3NIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3839
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDcuMjAgdW0gMTY6Mjkgc2NocmllYiBQYXVsIE1lbnplbDoKPiBUaGUgbmV3bHkgYWRk
ZWQgaGV4aW50IGhlbHBlciBpcyBtb3JlIGNvbnZlbmllbnQgZm9yIGJpdG1hc2tzLgo+Cj4gQmVm
b3JlOgo+Cj4gICAgICAkIG1vcmUgL3N5cy9tb2R1bGUvYW1kZ3B1L3BhcmFtZXRlcnMvcHBmZWF0
dXJlbWFzawo+ICAgICAgNDI5NDk1MDkxMQo+Cj4gQWZ0ZXI6Cj4KPiAgICAgICQgbW9yZSAvc3lz
L21vZHVsZS9hbWRncHUvcGFyYW1ldGVycy9wcGZlYXR1cmVtYXNrCj4gICAgICAweGZmZmZiZmZm
Cj4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwo+IFNpZ25lZC1vZmYtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1v
bGdlbi5tcGcuZGU+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPiBmb3IgdGhpcyBvbmUuCgpGZWVsIGZyZWUgdG8gYWRkIG15IEFja2VkLWJ5
IHRvIHRoZSBvdGhlciB0d28sIGJ1dCBJJ20gbm90IGZhbWlsaWFyIAplbm91Z2ggd2l0aCB0aGUg
Y29kZSB0byByZXZpZXcgdGhvc2UuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgNCArKy0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IGluZGV4IDEyNmU3NDc1OGEzNC4uNWM0MjYzMzM1
Y2JhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IEBAIC0z
OTEsMTIgKzM5MSwxMiBAQCBNT0RVTEVfUEFSTV9ERVNDKHNjaGVkX2h3X3N1Ym1pc3Npb24sICJ0
aGUgbWF4IG51bWJlciBvZiBIVyBzdWJtaXNzaW9ucyAoZGVmYXVsdAo+ICAgbW9kdWxlX3BhcmFt
X25hbWVkKHNjaGVkX2h3X3N1Ym1pc3Npb24sIGFtZGdwdV9zY2hlZF9od19zdWJtaXNzaW9uLCBp
bnQsIDA0NDQpOwo+ICAgCj4gICAvKioKPiAtICogRE9DOiBwcGZlYXR1cmVtYXNrICh1aW50KQo+
ICsgKiBET0M6IHBwZmVhdHVyZW1hc2sgKGhleGludCkKPiAgICAqIE92ZXJyaWRlIHBvd2VyIGZl
YXR1cmVzIGVuYWJsZWQuIFNlZSBlbnVtIFBQX0ZFQVRVUkVfTUFTSyBpbiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oLgo+ICAgICogVGhlIGRlZmF1bHQgaXMgdGhlIGN1
cnJlbnQgc2V0IG9mIHN0YWJsZSBwb3dlciBmZWF0dXJlcy4KPiAgICAqLwo+ICAgTU9EVUxFX1BB
Uk1fREVTQyhwcGZlYXR1cmVtYXNrLCAiYWxsIHBvd2VyIGZlYXR1cmVzIGVuYWJsZWQgKGRlZmF1
bHQpKSIpOwo+IC1tb2R1bGVfcGFyYW1fbmFtZWQocHBmZWF0dXJlbWFzaywgYW1kZ3B1X3BwX2Zl
YXR1cmVfbWFzaywgdWludCwgMDQ0NCk7Cj4gK21vZHVsZV9wYXJhbV9uYW1lZChwcGZlYXR1cmVt
YXNrLCBhbWRncHVfcHBfZmVhdHVyZV9tYXNrLCBoZXhpbnQsIDA0NDQpOwo+ICAgCj4gICAvKioK
PiAgICAqIERPQzogZm9yY2Vsb25ndHJhaW5pbmcgKHVpbnQpCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
