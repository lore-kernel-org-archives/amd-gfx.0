Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F1C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 14:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB0E206E2
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 14:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OZgTYbKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB0E206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614C36E9A3;
	Thu,  2 Jul 2020 14:42:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6A06E9A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 14:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myPl7zHwUKoiP0jr84JF/X2VIvPjAxanhLWr3UaUG8feiwPxRsNB2DZoNbzGIfhJwDGhMOOD/ICWHp+A+jTIisCSaoYlmXWOSrfk8i/7nVe76zjPfvaqtK4NEcGIAh0IdPBd7ga2xMWuJVRyK2SgMjUTiybuxTeGbaBfuP1TqTiCKn63KWKXmWlOui80CTcu+gwxlZrBApaxN/SWb4b+khGMHjyVVyU7hmQQLy4Fca6W26yeYDCFoMOqtT8u6pHfDNa7pVA3LVZYHShuKJERznHbT/S/hnszirTwVTlHaayrkEk+2N7XRTRcX2C75NFvkYRqeQh57Qpqd/L9O5p/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A31+P0kpH/RIG4uYaz8DliMzp4g5Ncqx7wadAnp/U=;
 b=l8Vcbdu9Xob4GHamKu32HI/Fyo0MMgWSsH/3N6T0b0dJ7AxoLd+NluJNA8WR7BLNyNxU3UW6YwlAK7y7PBFQ4BPXjELjuSGdWYtIJaB6difiB9jUaT9uLOw4HPZT2HluoR+Um3BVTdu0KT3y9gv9Ep8NISo4gkuNYkZ9JURo5Ikh+WrbQmAAMCpbkT8oytsP06B56zKBGByLQvWNt+a45JajzR8uqCjThn+utBnbwhdP+MRSqnqw1bwWhh02IUgdkp82gOlL2WyhgU1sMii3larnpt9PI13eQabrtFfHNiuCH1jY0tXdsELotTTHA48nxNNa1+K4aXYd+usCzPGYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A31+P0kpH/RIG4uYaz8DliMzp4g5Ncqx7wadAnp/U=;
 b=OZgTYbKu/ZADJf5xABMVnAfb5jt8MOGkpTF2ZGKOSbkdDWuWWWj+C5jQmjUWH5goktj1WcQ5VZnn+GM+7EEU88L6A8asAQV4l70lYvTFAPSXuFyCW4MazMUcqdsTmU8x9c71sZpBhMjGaoGvQjgV4bs31mk5BNaD54YuQhnK85E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 14:42:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Thu, 2 Jul 2020
 14:42:45 +0000
Subject: Re: [PATCH 1/2] moduleparams: Add hex type parameter
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
Date: Thu, 2 Jul 2020 16:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:200:89::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0202CA0010.eurprd02.prod.outlook.com (2603:10a6:200:89::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend
 Transport; Thu, 2 Jul 2020 14:42:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dc3fe78-084a-4a0e-eba9-08d81e962ec6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB451879E32AA64435A9E88F26836D0@MN2PR12MB4518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyMTpAPYa8bvk4ecoO/UpsmhPhC+nfuO+ju0SMjlkD8hI7apji/QgOSYLOXSP4RQawh3F32X0IlwZA+d2BpglLLwm9nW+63Nt5J4peE6d5WyfrR3+kaRvAwfGPpnasdvVibM/pxkcYSm5MXqmfNwnLvF4CTHKe7yigf5KZDISgJ6qDteoLhQ5T4Uj9CsrwHggmjCTWaD1WwpPdIVfwx9rLTQ+ZMsnncyVEBEHWuyyMQKSV79zo58wXU+WH5mU1e09W5MWZUZtACy5DGsNSv+1DT8I2uIcGLkLi9yLu5+SHeW6scsHff5EOKSRexcVZIMkTwto+YDx5OBCkpGOVC7YbncBM91iBIkeoSfVq1uPlriUmbjMUnevc7UaTOxo4Iv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(66476007)(36756003)(498600001)(2616005)(86362001)(16526019)(31696002)(5660300002)(110136005)(66946007)(2906002)(83380400001)(8676002)(8936002)(186003)(31686004)(66556008)(6666004)(6636002)(52116002)(6486002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZjWWeFP3LMm4ZraaqiN6g6EKxXTRU7Zn+mDBndEZmlvMBbX9arO7A4ZfQyWuBs1++7UT2jxFzedUxUZ2s5MxN8Y2TPaSQQyYIylHan84lvzucQeDAIMiT1T3QDYCG5cqlGKdKIX9tspy4adT1WMSI8+4v852Peb3PwV2EEYY/EZbqm9DEX8HYwIHM4yExq4s3ITNXUcXEEm+k1qdrAcRic73hJuD1Mj2mGvlqr65b0v0wb6FtonChq50hjE+yGLDQzMDRE37M25gJ5WNaS67GL/8tkMYga4kcHiqNm9TSLZMyyOj+aiaoyMXOk+m2cCkWfbAezTQZQL+AjTfbeo1OnrU3HIhzwMULaldxdyQGTYia+hMzjC/V0LmV1cx3PENDeaUfC7yqK2TiUQ32uOROuzOXOCpxybTvz83v8PRUfawZY2DJanZb4+SSnyIon89X22ZeD0BE3Y65yk0JvFK1ZCqNx9TZwPZo7YhZ2l64f2B1LhRPHNNxg7QNG3zPdB3ecYMgw1RvTigjo3jpVK2gK1NyyHp2prTPJf4wkOznu3D3gfW0ydvG9JUuHArSWa0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc3fe78-084a-4a0e-eba9-08d81e962ec6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:42:45.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw1xgdk3eGDYiyw087ShViCSxfAy31tuvzQVvzv5KdD0pePsxZxPdxDE7gze8qK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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

QW0gMDIuMDcuMjAgdW0gMTY6MDEgc2NocmllYiBQYXVsIE1lbnplbDoKPiBGb3IgYml0bWFza3Mg
cHJpbnRpbmcgdmFsdWVzIGluIGhleCBpcyBtb3JlIGNvbnZlbmllbnQuCj4KPiBQcmVmaXggd2l0
aCAweCAoIykgdG8gbWFrZSBpdCBjbGVhciwgdGhhdCBpdOKAmXMgYSBoZXggdmFsdWUuCj4KPiBV
c2luZyB0aGUgaGVscGVyIGZvciBgYW1kZ3B1LnBwZmVhdHVyZW1hc2tgLCBpdCB3aWxsIGxvb2sg
bGlrZSBiZWxvdy4KPgo+IEJlZm9yZToKPgo+ICAgICAgJCBtb3JlIC9zeXMvbW9kdWxlL2FtZGdw
dS9wYXJhbWV0ZXJzL3BwZmVhdHVyZW1hc2sKPiAgICAgIDQyOTQ5NTA5MTEKPgo+IEFmdGVyOgo+
Cj4gICAgICAkIG1vcmUgL3N5cy9tb2R1bGUvYW1kZ3B1L3BhcmFtZXRlcnMvcHBmZWF0dXJlbWFz
awo+ICAgICAgMHhmZmZmYmZmZgo+Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBQYXVs
IE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPgoKR29vZCBpZGVhLgoKSSdtIGp1c3Qgbm90
IHN1cmUgaG93IHdlbGwgdGhpcyBpcyByZWNlaXZlZCB1cHN0cmVhbSBiZWNhdXNlIGl0IG9ubHkg
CmNvdmVycyB1MzIKCk9uIHRoZSBvdGhlciBoYW5kIHRoYXQgaXMgcHJvYmFibHkgYWxzbyB0aGUg
bW9zdCB1c2VkLgoKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvbW9kdWxlcGFy
YW0uaCB8IDcgKysrKysrLQo+ICAga2VybmVsL3BhcmFtcy5jICAgICAgICAgICAgIHwgMSArCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW9kdWxlcGFyYW0uaCBiL2luY2x1ZGUvbGludXgvbW9k
dWxlcGFyYW0uaAo+IGluZGV4IDNlZjkxN2ZmMDk2NC4uNDA4OTc4ZmNmZTI3IDEwMDY0NAo+IC0t
LSBhL2luY2x1ZGUvbGludXgvbW9kdWxlcGFyYW0uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW9k
dWxlcGFyYW0uaAo+IEBAIC0xMTgsNyArMTE4LDcgQEAgc3RydWN0IGtwYXJhbV9hcnJheQo+ICAg
ICogeW91IGNhbiBjcmVhdGUgeW91ciBvd24gYnkgZGVmaW5pbmcgdGhvc2UgdmFyaWFibGVzLgo+
ICAgICoKPiAgICAqIFN0YW5kYXJkIHR5cGVzIGFyZToKPiAtICoJYnl0ZSwgc2hvcnQsIHVzaG9y
dCwgaW50LCB1aW50LCBsb25nLCB1bG9uZwo+ICsgKglieXRlLCBoZXgsIHNob3J0LCB1c2hvcnQs
IGludCwgdWludCwgbG9uZywgdWxvbmcKPiAgICAqCWNoYXJwOiBhIGNoYXJhY3RlciBwb2ludGVy
Cj4gICAgKglib29sOiBhIGJvb2wsIHZhbHVlcyAwLzEsIHkvbiwgWS9OLgo+ICAgICoJaW52Ym9v
bDogdGhlIGFib3ZlLCBvbmx5IHNlbnNlLXJldmVyc2VkIChOID0gdHJ1ZSkuCj4gQEAgLTQ0OCw2
ICs0NDgsMTEgQEAgZXh0ZXJuIGludCBwYXJhbV9zZXRfdWxsb25nKGNvbnN0IGNoYXIgKnZhbCwg
Y29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOwo+ICAgZXh0ZXJuIGludCBwYXJhbV9nZXRf
dWxsb25nKGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOwo+ICAg
I2RlZmluZSBwYXJhbV9jaGVja191bGxvbmcobmFtZSwgcCkgX19wYXJhbV9jaGVjayhuYW1lLCBw
LCB1bnNpZ25lZCBsb25nIGxvbmcpCj4gICAKPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBrZXJuZWxf
cGFyYW1fb3BzIHBhcmFtX29wc19oZXg7Cj4gK2V4dGVybiBpbnQgcGFyYW1fc2V0X2hleChjb25z
dCBjaGFyICp2YWwsIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwKTsKPiArZXh0ZXJuIGlu
dCBwYXJhbV9nZXRfaGV4KGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAq
a3ApOwo+ICsjZGVmaW5lIHBhcmFtX2NoZWNrX2hleChuYW1lLCBwKSBwYXJhbV9jaGVja191aW50
KG5hbWUsIHApCj4gKwo+ICAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIHBh
cmFtX29wc19jaGFycDsKPiAgIGV4dGVybiBpbnQgcGFyYW1fc2V0X2NoYXJwKGNvbnN0IGNoYXIg
KnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApOwo+ICAgZXh0ZXJuIGludCBwYXJh
bV9nZXRfY2hhcnAoY2hhciAqYnVmZmVyLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCk7
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9wYXJhbXMuYyBiL2tlcm5lbC9wYXJhbXMuYwo+IGluZGV4
IDhlNTZmOGIxMmQ4Zi4uY2VjYTgzOTRkYWM1IDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9wYXJhbXMu
Ywo+ICsrKyBiL2tlcm5lbC9wYXJhbXMuYwo+IEBAIC0yNDEsNiArMjQxLDcgQEAgU1RBTkRBUkRf
UEFSQU1fREVGKHVpbnQsCXVuc2lnbmVkIGludCwJCSIldSIsICAga3N0cnRvdWludCk7Cj4gICBT
VEFOREFSRF9QQVJBTV9ERUYobG9uZywJbG9uZywJCQkiJWxpIiwgIGtzdHJ0b2wpOwo+ICAgU1RB
TkRBUkRfUEFSQU1fREVGKHVsb25nLAl1bnNpZ25lZCBsb25nLAkJIiVsdSIsICBrc3RydG91bCk7
Cj4gICBTVEFOREFSRF9QQVJBTV9ERUYodWxsb25nLAl1bnNpZ25lZCBsb25nIGxvbmcsCSIlbGx1
Iiwga3N0cnRvdWxsKTsKPiArU1RBTkRBUkRfUEFSQU1fREVGKGhleCwJCXVuc2lnbmVkIGludCwJ
CSIlI3giLCAga3N0cnRvdWludCk7Cj4gICAKPiAgIGludCBwYXJhbV9zZXRfY2hhcnAoY29uc3Qg
Y2hhciAqdmFsLCBjb25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcCkKPiAgIHsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
