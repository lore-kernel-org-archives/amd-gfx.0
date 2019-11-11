Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2847C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A84206C3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 18:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A84206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038F46E9B7;
	Mon, 11 Nov 2019 18:05:02 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720065.outbound.protection.outlook.com [40.107.72.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830D16E9B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 18:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR7/LftXmBoLAC2MbKLv+dupGV/FDRcNKMI7RPyePKKBHQkh/q/4Lzg6kCLaL+JLR9RNIdJbKnk1PIaNhu2VYiPRxjSd37e46HjVKfXquqOiUgbblfo1BJ6BnNJAO9nSje5tJ5TcdzusFuYqhoTMG9/bNkGbNqd2G/tSUPAHzruKdvjUTUivE5TF0wWGX/ZN5rpe+222SD3zyXOYcNabEKTFEXgipJT00RXuh37oxIb6Gi4CwTU2L78gxQBr/HZg3BC574de21O5GYRQb4bIVflQ5utrT7g0hTf1ydiHVRawIOg8opwHz15Lksxfd2prrC7Bng0eZ3oFvALsXcx8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7G+91LOiSlA1bVeH2mxw9yoI3oto8lm5ausPdH8n8A=;
 b=WufBrhXXFEOA2RQ20rJL9Xu1w2JHh2tGPtsmIbY356UbrygDBhmUR/kz6vcEoQQRRRspXROvFwo/RBBtZL+6fPZSNLA0I9LqakSOe/K4fsHA8c/YyV2xv4l44s1mi//Jamq97zRFtVfASJGGgvABNjXcgssEYP24oOminPIqcaXqHWdmWc9iMq/LmoEy39yOSDdrv7mANAZ5j4rNcp2qbB81ctZFSPp9UxV/p5LwvMmm6mxL17OX19LNniM+9JOmJoMtfqWtwxc4bARGgNY1upVOlp92KTQkwrzsydq5bDz4Ax47OYbD8vaQOc8gXY7KxA4UzH8GYwdXD2OuPzpOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3611.namprd12.prod.outlook.com (20.178.199.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 18:04:59 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 18:04:59 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Use better name to indicate the offset is
 in dwords
To: "Zhao, Yong" <Yong.Zhao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20191101201016.5973-1-Yong.Zhao@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <5b7995b2-2db7-3365-9d5e-6b27f9606945@amd.com>
Date: Mon, 11 Nov 2019 13:04:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191101201016.5973-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99e0236b-c9ba-424c-aa1f-08d766d1aa7f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3611E1638FB93BFF367028A4F0740@DM6PR12MB3611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(2616005)(476003)(6512007)(11346002)(446003)(47776003)(65956001)(66066001)(65806001)(66476007)(66556008)(50466002)(6506007)(53546011)(6486002)(386003)(2486003)(23676004)(52116002)(76176011)(66946007)(5660300002)(186003)(230700001)(229853002)(110136005)(316002)(6116002)(6436002)(3846002)(99286004)(14444005)(25786009)(31686004)(58126008)(478600001)(8936002)(14454004)(36756003)(6246003)(31696002)(44832011)(2906002)(8676002)(7736002)(305945005)(486006)(81156014)(81166006)(26005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3611;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7JlxCF63E1NnGH2OA7XgOvwuGamnXfuoh4ARCwU4E9PnxIqCukUGytRliVgeo+8P9sVCoEel55kqqQUTbQ6Mh+9vO8wBtKVPRMXQdpy17+N4iyAPXrzk9DnsYqbyPvAThipo0RIOeSvO17mQzk3270b2+C6yJ7LpWr3xmFs+3uE7I4x19lu5X6p+1lwCbOYOHICp8qKYvCxV94APgu4IQ6YqNwluzg5SiEHGEMQG72xqcqdrJ70yWbpp7pCBu8i1f5fo2gnFcfIRY69n6pdQcHjDlTa+YLlCe/8zfGmAJwIq7MVRhbt9/aTVf6ZBeA8qph4CCjoMrFLMqel5VAe6gZZlZTPoFhlNJ5GawXAMzR9B9+1cna/C6T36xJ9KX7UJgBVmmMy0snMUxAGYdFVmrrGM3ZuGgLdYK5NnUiAnFDyC0ane3Pp+alsiypNfTGb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e0236b-c9ba-424c-aa1f-08d766d1aa7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 18:04:59.4084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlQPaWMtHSJin5gixQalP/Un7RIiQsk/sWtsik0xDmZOtv7fF5L9nmicN90jAN7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3611
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7G+91LOiSlA1bVeH2mxw9yoI3oto8lm5ausPdH8n8A=;
 b=irHIFpxdqobIB8E2aM6GMAIPCuX0t6vnVB6ybFz8+z/AxNahsgu/1e6uWQ/s9/DJZYc6akkGxJfyzwzQXie40p1mijejR3r4E2w3C4tAjRrEgTJ/234ZTWVYdqEiHdairU6KS40lTp5zBW8IGUblJmQA83zE8cxEHRK3nREacYs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191111180457.ltOe7UvUzokRJAJBLPD_UPcaJHZVs7U81aReALWfI7k@z>

cGluZwoKT24gMjAxOS0xMS0wMSA0OjEwIHAubS4sIFpoYW8sIFlvbmcgd3JvdGU6Cj4gQ2hhbmdl
LUlkOiBJNzVkYTIzYmJhOTAyMzE3NjJjZjU4ZGEzMTcwZjViYjc3ZWNlNDVlZAo+IFNpZ25lZC1v
ZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Cj4gLS0tCj4gICAuLi4vZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jICB8ICAyICstCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZG9vcmJlbGwuYyAgICAgICAgICB8IDE0ICsrKysr
KystLS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgICAg
ICAgICAgICB8ICA4ICsrKystLS0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBpbmRleCA5ODRjMmYyYjI0YjYuLjQ1
MDNmYjI2ZmU1YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gQEAgLTE3MCw3ICsxNzAsNyBAQCBzdGF0aWMg
aW50IGFsbG9jYXRlX2Rvb3JiZWxsKHN0cnVjdCBxY21fcHJvY2Vzc19kZXZpY2UgKnFwZCwgc3Ry
dWN0IHF1ZXVlICpxKQo+ICAgCX0KPiAgIAo+ICAgCXEtPnByb3BlcnRpZXMuZG9vcmJlbGxfb2Zm
ID0KPiAtCQlrZmRfZG9vcmJlbGxfaWRfdG9fb2Zmc2V0KGRldiwgcS0+cHJvY2VzcywKPiArCQlr
ZmRfZ2V0X2Rvb3JiZWxsX2R3X29mZnNldF9mcm9tX2JhcihkZXYsIHEtPnByb2Nlc3MsCj4gICAJ
CQkJCSAgcS0+ZG9vcmJlbGxfaWQpOwo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2Rvb3JiZWxsLmMKPiBpbmRleCBlYmU3OWJmMDAxNDUuLmY5MDQz
NTVjNDRhMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZG9v
cmJlbGwuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5j
Cj4gQEAgLTkxLDcgKzkxLDcgQEAgaW50IGtmZF9kb29yYmVsbF9pbml0KHN0cnVjdCBrZmRfZGV2
ICprZmQpCj4gICAJa2ZkLT5kb29yYmVsbF9iYXNlID0ga2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmRv
b3JiZWxsX3BoeXNpY2FsX2FkZHJlc3MgKwo+ICAgCQkJCWRvb3JiZWxsX3N0YXJ0X29mZnNldDsK
PiAgIAo+IC0Ja2ZkLT5kb29yYmVsbF9pZF9vZmZzZXQgPSBkb29yYmVsbF9zdGFydF9vZmZzZXQg
LyBzaXplb2YodTMyKTsKPiArCWtmZC0+ZG9vcmJlbGxfYmFzZV9kd19vZmZzZXQgPSBkb29yYmVs
bF9zdGFydF9vZmZzZXQgLyBzaXplb2YodTMyKTsKPiAgIAo+ICAgCWtmZC0+ZG9vcmJlbGxfa2Vy
bmVsX3B0ciA9IGlvcmVtYXAoa2ZkLT5kb29yYmVsbF9iYXNlLAo+ICAgCQkJCQkgICBrZmRfZG9v
cmJlbGxfcHJvY2Vzc19zbGljZShrZmQpKTsKPiBAQCAtMTAzLDggKzEwMyw4IEBAIGludCBrZmRf
ZG9vcmJlbGxfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkKQo+ICAgCXByX2RlYnVnKCJkb29yYmVs
bCBiYXNlICAgICAgICAgICA9PSAweCUwOGxYXG4iLAo+ICAgCQkJKHVpbnRwdHJfdClrZmQtPmRv
b3JiZWxsX2Jhc2UpOwo+ICAgCj4gLQlwcl9kZWJ1ZygiZG9vcmJlbGxfaWRfb2Zmc2V0ICAgICAg
PT0gMHglMDhsWFxuIiwKPiAtCQkJa2ZkLT5kb29yYmVsbF9pZF9vZmZzZXQpOwo+ICsJcHJfZGVi
dWcoImRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0ICAgICAgPT0gMHglMDhsWFxuIiwKPiArCQkJa2Zk
LT5kb29yYmVsbF9iYXNlX2R3X29mZnNldCk7Cj4gICAKPiAgIAlwcl9kZWJ1ZygiZG9vcmJlbGxf
cHJvY2Vzc19saW1pdCAgPT0gMHglMDhsWFxuIiwKPiAgIAkJCWRvb3JiZWxsX3Byb2Nlc3NfbGlt
aXQpOwo+IEBAIC0xODUsNyArMTg1LDcgQEAgdm9pZCBfX2lvbWVtICprZmRfZ2V0X2tlcm5lbF9k
b29yYmVsbChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+ICAgCSAqIENhbGN1bGF0aW5nIHRoZSBrZXJu
ZWwgZG9vcmJlbGwgb2Zmc2V0IHVzaW5nIHRoZSBmaXJzdAo+ICAgCSAqIGRvb3JiZWxsIHBhZ2Uu
Cj4gICAJICovCj4gLQkqZG9vcmJlbGxfb2ZmID0ga2ZkLT5kb29yYmVsbF9pZF9vZmZzZXQgKyBp
bng7Cj4gKwkqZG9vcmJlbGxfb2ZmID0ga2ZkLT5kb29yYmVsbF9iYXNlX2R3X29mZnNldCArIGlu
eDsKPiAgIAo+ICAgCXByX2RlYnVnKCJHZXQga2VybmVsIHF1ZXVlIGRvb3JiZWxsXG4iCj4gICAJ
CQkiICAgICBkb29yYmVsbCBvZmZzZXQgICA9PSAweCUwOFhcbiIKPiBAQCAtMjI1LDE3ICsyMjUs
MTcgQEAgdm9pZCB3cml0ZV9rZXJuZWxfZG9vcmJlbGw2NCh2b2lkIF9faW9tZW0gKmRiLCB1NjQg
dmFsdWUpCj4gICAJfQo+ICAgfQo+ICAgCj4gLXVuc2lnbmVkIGludCBrZmRfZG9vcmJlbGxfaWRf
dG9fb2Zmc2V0KHN0cnVjdCBrZmRfZGV2ICprZmQsCj4gK3Vuc2lnbmVkIGludCBrZmRfZ2V0X2Rv
b3JiZWxsX2R3X29mZnNldF9mcm9tX2JhcihzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+ICAgCQkJCQlz
dHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2Nlc3MsCj4gICAJCQkJCXVuc2lnbmVkIGludCBkb29yYmVs
bF9pZCkKPiAgIHsKPiAgIAkvKgo+IC0JICogZG9vcmJlbGxfaWRfb2Zmc2V0IGFjY291bnRzIGZv
ciBkb29yYmVsbHMgdGFrZW4gYnkgS0dELgo+ICsJICogZG9vcmJlbGxfYmFzZV9kd19vZmZzZXQg
YWNjb3VudHMgZm9yIGRvb3JiZWxscyB0YWtlbiBieSBLR0QuCj4gICAJICogaW5kZXggKiBrZmRf
ZG9vcmJlbGxfcHJvY2Vzc19zbGljZS9zaXplb2YodTMyKSBhZGp1c3RzIHRvCj4gICAJICogdGhl
IHByb2Nlc3MncyBkb29yYmVsbHMuIFRoZSBvZmZzZXQgcmV0dXJuZWQgaXMgaW4gZHdvcmQKPiAg
IAkgKiB1bml0cyByZWdhcmRsZXNzIG9mIHRoZSBBU0lDLWRlcGVuZGVudCBkb29yYmVsbCBzaXpl
Lgo+ICAgCSAqLwo+IC0JcmV0dXJuIGtmZC0+ZG9vcmJlbGxfaWRfb2Zmc2V0ICsKPiArCXJldHVy
biBrZmQtPmRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0ICsKPiAgIAkJcHJvY2Vzcy0+ZG9vcmJlbGxf
aW5kZXgKPiAgIAkJKiBrZmRfZG9vcmJlbGxfcHJvY2Vzc19zbGljZShrZmQpIC8gc2l6ZW9mKHUz
MikgKwo+ICAgCQlkb29yYmVsbF9pZCAqIGtmZC0+ZGV2aWNlX2luZm8tPmRvb3JiZWxsX3NpemUg
LyBzaXplb2YodTMyKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3ByaXYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPiBpbmRl
eCA2MmRiNGQyMGVkMzIuLjdjNTYxYzk4ZjJlMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3ByaXYuaAo+IEBAIC0yMzgsOSArMjM4LDkgQEAgc3RydWN0IGtmZF9kZXYgewo+ICAg
CQkJCQkgKiBLRkQuIEl0IGlzIGFsaWduZWQgZm9yIG1hcHBpbmcKPiAgIAkJCQkJICogaW50byB1
c2VyIG1vZGUKPiAgIAkJCQkJICovCj4gLQlzaXplX3QgZG9vcmJlbGxfaWRfb2Zmc2V0OwkvKiBE
b29yYmVsbCBvZmZzZXQgKGZyb20gS0ZEIGRvb3JiZWxsCj4gLQkJCQkJICogdG8gSFcgZG9vcmJl
bGwsIEdGWCByZXNlcnZlZCBzb21lCj4gLQkJCQkJICogYXQgdGhlIHN0YXJ0KQo+ICsJc2l6ZV90
IGRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0OwkvKiBEb29yYmVsbCBkd29yZCBvZmZzZXQgKGZyb20g
S0ZECj4gKwkJCQkJICogZG9vcmJlbGwgdG8gUENJIGRvb3JiZWxsIGJhciwKPiArCQkJCQkgKiBH
RlggcmVzZXJ2ZWQgc29tZSBhdCB0aGUgc3RhcnQpCj4gICAJCQkJCSAqLwo+ICAgCXUzMiBfX2lv
bWVtICpkb29yYmVsbF9rZXJuZWxfcHRyOyAvKiBUaGlzIGlzIGEgcG9pbnRlciBmb3IgYSBkb29y
YmVsbHMKPiAgIAkJCQkJICAgKiBwYWdlIHVzZWQgYnkga2VybmVsIHF1ZXVlCj4gQEAgLTgyMSw3
ICs4MjEsNyBAQCB2b2lkIGtmZF9yZWxlYXNlX2tlcm5lbF9kb29yYmVsbChzdHJ1Y3Qga2ZkX2Rl
diAqa2ZkLCB1MzIgX19pb21lbSAqZGJfYWRkcik7Cj4gICB1MzIgcmVhZF9rZXJuZWxfZG9vcmJl
bGwodTMyIF9faW9tZW0gKmRiKTsKPiAgIHZvaWQgd3JpdGVfa2VybmVsX2Rvb3JiZWxsKHZvaWQg
X19pb21lbSAqZGIsIHUzMiB2YWx1ZSk7Cj4gICB2b2lkIHdyaXRlX2tlcm5lbF9kb29yYmVsbDY0
KHZvaWQgX19pb21lbSAqZGIsIHU2NCB2YWx1ZSk7Cj4gLXVuc2lnbmVkIGludCBrZmRfZG9vcmJl
bGxfaWRfdG9fb2Zmc2V0KHN0cnVjdCBrZmRfZGV2ICprZmQsCj4gK3Vuc2lnbmVkIGludCBrZmRf
Z2V0X2Rvb3JiZWxsX2R3X29mZnNldF9mcm9tX2JhcihzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+ICAg
CQkJCQlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2Nlc3MsCj4gICAJCQkJCXVuc2lnbmVkIGludCBk
b29yYmVsbF9pZCk7Cj4gICBwaHlzX2FkZHJfdCBrZmRfZ2V0X3Byb2Nlc3NfZG9vcmJlbGxzKHN0
cnVjdCBrZmRfZGV2ICpkZXYsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
