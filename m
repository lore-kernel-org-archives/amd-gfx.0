Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C93C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC2324671
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uJUZOW7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC2324671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B340C6EB7D;
	Wed, 19 Feb 2020 15:14:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C8F6EB7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArffUGCayfRAQu8QKWVLpu2WCrzs4KGwfwYpdPg2M+bFEqLP/wp5Nbq6C8J3xmrWizandKIPxsAOQZ7fMJsfwFifhmZ/ySBbeohb/FiHE1z35J8hXEbMi0Wh8cN0iwc9JqauxIq0+aUOdHWtMmNHPWdwE9TCZUANNwzcvCyrRWGh/nNcr1L3WwGv4GuVtF6AhQWcvIxw71lLR7qXG7Yt2WCvoFJVP2VHvkIiczvBm3g/o9n8RmGU43jT0+K2GG9+H83LKZx5z7+Te4pDq809z/8eft3y8PqnjwfIOy0ncKN3Ak4v780pQnuvvVEUQ5OSBLixbG2lcpkbsK1z5idQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNQHO+VHRkqKvI/1+wjHAiIjg3r2mlWL7cVvLMSUR4A=;
 b=TjdVy3pcSTjTPUomq3K0FgRUwQNKXLmt/YS4zU7T0wHDm7rywpyyUKeNO0xbI5vFBqgbJ6NHpg+6InDBNbZlTrxPKf6Yy4jfUiclNqWlP/aZm/H5azFXP3nYDfBYq23vKNMh6WmSRFe39fVE/q2AHW6QmV4sNE32ihN02Q9hd/X9Jk0NfibSEnl1Xb9ga0pyRBWr3ACIooU7ake5BneGzWmYmfgnYKEuw0jtzOwZPspeAdgCbhOUr1cwo7PQmOC5MUvFUz79bgncJ94Z5JNt/sNWrxcUwJ10OlD/d7mzqszj0IDVwZKiC7DJuYo4VufPpe/De78zs14zNk3K1qRi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNQHO+VHRkqKvI/1+wjHAiIjg3r2mlWL7cVvLMSUR4A=;
 b=uJUZOW7epfkM7zjh2pZEBVbaTErakbsxTjvojNPU64zGya2J6lLMKRoH3mez042VT+MbAoWHZ68FGEttAwsL38hpLeo+pL/ikZFIX/+zod+FgHGt0pCl8zu7udWm01gnMyzgioHX3hpg7AUM0OPm3Nx51m/Czq3qetXhByFxSsc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB2894.namprd12.prod.outlook.com (20.179.84.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 15:14:28 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:14:28 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 luben.tuikov@amd.com, Marek.Olsak@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <9af8bcf0-bfe6-d622-ec12-9bddba8e2d76@amd.com>
Date: Wed, 19 Feb 2020 10:14:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200219150251.123917-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 15:14:27 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cfdb243-91d0-4214-d578-08d7b54e69d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB2894:|MN2PR12MB2894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB289437AC672ADAB650759421F7100@MN2PR12MB2894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(478600001)(81156014)(66574012)(8676002)(6486002)(2906002)(31686004)(52116002)(26005)(956004)(5660300002)(6512007)(186003)(8936002)(15650500001)(2616005)(31696002)(86362001)(316002)(66946007)(16526019)(66476007)(6506007)(81166006)(53546011)(36756003)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2894;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MhIrJGG/cSF9M1+CGFchuCMcMMnoOA28rqCI6fNhZK/B0QuDv31rq5DlCANCKvNzlRdKOKe/dVmoi6pbYlW5wJNAQil73tyN5NRuCKlypgJDyW5v1SKI/ACVzTNtsYt97Zeh3Zd8Hczpnb/JXJE1wAAIbLcAqoCDaQiEbGRgjz+3fZB0y19JDVUA0xI/h6C9v8fJQjt7AbPamvej3VI/EjZMn69FLIltQXvfuXZ73YB4DtdwCg2D8GxExnKYNlEvtJW5QHhNiqE2vc+FBgOK366zvwlc6aBrVC4XgbdsFbHM1wSEVTJiylCTZCMjCaws7UuUempfcKRTNv+GhefqaZk7PiE1BqL6ZfB+4LZZyv0/RiayjalD4ekw9MI27YTgfwZpiWTtq3Rcty25B9N0yHZseVXn7jarantbL8lRMSS+4b62qPrgRTc4cNrh9Sy
X-MS-Exchange-AntiSpam-MessageData: bbxMOuACBRMAXnW722Toaq6VUJLDQLG/PqDqN4WKio/g7u+VxghxMWAUfPGchMyB88Z+EXkKzzCy+ED/8i/aqc3eN3YRlYIct401WRwp8fwOLWUGIIK0EhgICyFHkvwhDlRXtYhecCrHlfFcf5cf9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfdb243-91d0-4214-d578-08d7b54e69d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:14:28.6364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAJcnTkv+KVW62STUXPq3bNFMhlVIj4tvP6LCe6bDYD2O0Dk2Qy22rSrALhfzuDBidXuxsxNHy/S0CDw3CQOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2894
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RG9lc24ndCBidWlsZCBldmVuIHdpdGggY29uZmxpY3QgcmVzb2x2ZWQ6Cgpbcm9vdEByYXZlbiBs
aW51eF0jIG1ha2UKIMKgIENBTEzCoMKgwqAgc2NyaXB0cy9jaGVja3N5c2NhbGxzLnNoCiDCoCBD
QUxMwqDCoMKgIHNjcmlwdHMvYXRvbWljL2NoZWNrLWF0b21pY3Muc2gKIMKgIERFU0NFTkTCoCBv
Ymp0b29sCiDCoCBDSEvCoMKgwqDCoCBpbmNsdWRlL2dlbmVyYXRlZC9jb21waWxlLmgKIMKgIEND
IFtNXcKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5vCmRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jOiBJbiBmdW5jdGlvbiAK4oCYYW1kZ3B1X3ZtX2Jv
X3VwZGF0ZV9tYXBwaW5n4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YzoxNjEyOjQxOiBlcnJvcjog4oCYb3duZXLigJkgCnVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQogwqAxNjEyIHzCoCByID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgm
cGFyYW1zLCBvd25lciwgZXhjbHVzaXZlKTsKIMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF5+fn5+CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jOjE2MTI6
NDE6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCAKaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9u
Y2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgpkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYzoxNjEyOjQ4OiBlcnJvcjog4oCYZXhjbHVzaXZl4oCZIAp1bmRlY2xh
cmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKIMKgMTYxMiB8wqAgciA9IHZtLT51cGRh
dGVfZnVuY3MtPnByZXBhcmUoJnBhcmFtcywgb3duZXIsIGV4Y2x1c2l2ZSk7CiDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fgptYWtlWzRd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjY2OiAKZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLm9dIEVycm9yIDEKbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkOjUwOTogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHVdIApFcnJvciAyCm1ha2VbMl06
ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDk6IGRyaXZlcnMvZ3B1L2RybV0gRXJyb3Ig
MgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTA5OiBkcml2ZXJzL2dwdV0g
RXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE2NDk6IGRyaXZlcnNdIEVycm9yIDIKClNob3Vs
ZCBJIGp1c3QgbW92ZSB0byBkcm0tbWlzYy1uZXh0PwoKdG9tCgpPbiAyMDIwLTAyLTE5IDEwOjAy
IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQWRkIHVwZGF0ZSBmZW5jZXMgdG8gdGhl
IHJvb3QgUEQgd2hpbGUgbWFwcGluZyBCT3MuCj4KPiBPdGhlcndpc2UgUERzIGZyZWVkIGR1cmlu
ZyB0aGUgbWFwcGluZyB3b24ndCB3YWl0IGZvcgo+IHVwZGF0ZXMgdG8gZmluaXNoIGFuZCBjYW4g
Y2F1c2UgY29ycnVwdGlvbnMuCj4KPiB2MjogcmViYXNlZCBvbiBkcm0tbWlzYy1uZXh0Cj4KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4gRml4ZXM6IDkwYjY5Y2RjNWYxNTkgZHJtL2FtZGdwdTogc3RvcCBhZGRpbmcgVk0gdXBkYXRl
cyBmZW5jZXMgdG8gdGhlIHJlc3Ygb2JqCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYyB8IDE0ICsrKysrKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gaW5kZXggZDE2MjMxZDZhNzkwLi5lZjczZmE5NGYzNTcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC01ODgsOCArNTg4LDgg
QEAgdm9pZCBhbWRncHVfdm1fZ2V0X3BkX2JvKHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAgewo+
ICAgCWVudHJ5LT5wcmlvcml0eSA9IDA7Cj4gICAJZW50cnktPnR2LmJvID0gJnZtLT5yb290LmJh
c2UuYm8tPnRibzsKPiAtCS8qIE9uZSBmb3IgVFRNIGFuZCBvbmUgZm9yIHRoZSBDUyBqb2IgKi8K
PiAtCWVudHJ5LT50di5udW1fc2hhcmVkID0gMjsKPiArCS8qIFR3byBmb3IgVk0gdXBkYXRlcywg
b25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhlIENTIGpvYiAqLwo+ICsJZW50cnktPnR2Lm51bV9z
aGFyZWQgPSA0Owo+ICAgCWVudHJ5LT51c2VyX3BhZ2VzID0gTlVMTDsKPiAgIAlsaXN0X2FkZCgm
ZW50cnktPnR2LmhlYWQsIHZhbGlkYXRlZCk7Cj4gICB9Cj4gQEAgLTE1OTEsNiArMTU5MSwxNiBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPiAgIAkJZ290byBlcnJvcl91bmxvY2s7Cj4gICAJfQo+ICAgCj4gKwlpZiAo
ZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7Cj4gKwkJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9
IHZtLT5yb290LmJhc2UuYm87Cj4gKwo+ICsJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZt
LT5sYXN0X2RpcmVjdCkpCj4gKwkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJl
Y3QsIHRydWUpOwo+ICsKPiArCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9k
ZWxheWVkKSkKPiArCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RlbGF5ZWQsIHRy
dWUpOwo+ICsJfQo+ICsKPiAgIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1z
LCBvd25lciwgZXhjbHVzaXZlKTsKPiAgIAlpZiAocikKPiAgIAkJZ290byBlcnJvcl91bmxvY2s7
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
