Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD0C43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 18:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D86E21534
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M+zDkyF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D86E21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3056ED6C;
	Fri, 18 Sep 2020 18:37:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1309D6ED6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 18:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2E4i7xUi0G8UmQmEf3/Uyji6SzXrfIiyaWBwhjP4wOWl0UQoTqalb+5vXc0nXy8EXouCg340q/ewC1dBlxWka8gFJDU3q8BCveMlrDQaPFleSIiU/Z2bX4GEnpoE59LoNA4sTF7KJg3u9jHAAEd/xvizVxNCuy1eIhYC/VzK+7gI9zWGb6o8db/JIR+6q5fK/hV4g2x+lcQ/Jterk6fXfZxsjJeq3rDSRsAqijGS37IQM+nHeMrtHCl2Dx7yRINi9SoLiY/jbdPd7C5u3hDsVjtOO1TpY+gUTNv8R39t8NEgeJVsZrVgyRuYNUhfXND4qtb19hMsvjD0yPu0Ytr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kcykW2+wwSLt2KuiHgMondqkBqBFGCA/3MU0uynB4U=;
 b=eDgKivy5Aq/mDGvrJY5hBU9KKUeRP7Ehumn2BTJjqpkSY045jXMtRirogyz4N8o6kijrvRTEmaJ2/eBt3j4MF+3Q7+rBXXutwr8HFGUwHlkqGxD6iDmMGjn/VoZIxWLySyCxBdMpVqDcs3Yht/C/bXZ6eeoRuETneVRL+WmDM0bvNN0R4Bww7yk3FCjsgUa+t617YOpkuPOlogDBVo51jydjPa7XLTAcJeGtGYi+BND5YmlKE+NceO3mmz2vu6Nd+TQx3+o667dKa+bqIMYYtSxBNJ+m0eKlSykKsH798MgWPlAPW11+HTn32OKqEAuu7fMiVe7QvmC+rGsf5nUJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kcykW2+wwSLt2KuiHgMondqkBqBFGCA/3MU0uynB4U=;
 b=M+zDkyF3Xn0CEPR+/DSy4WLxwT9AMkCaJOozMLVT3A5nIcWHF4TZhu5qloRgqD20ipHl+FdlJbGPlVQTf6CQoD5b5Judfx8hLUgfjhiUMgv0ZEwYRAjEvl2JPClN46JjvXp514d6DaPDUtQyhLBqZ3ZBP0t4z1Rm8NqJVciEo6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 18:37:38 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3391.015; Fri, 18 Sep 2020
 18:37:38 +0000
Subject: Re: [PATCH] drm/amdkfd: Calculate CPU VCRAT size dynamically
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200918173142.11287-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0ccf6eaa-2cc3-79fa-d607-c5da2e070343@amd.com>
Date: Fri, 18 Sep 2020 14:37:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200918173142.11287-1-kent.russell@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Fri, 18 Sep 2020 18:37:37 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4d24279-3df9-4685-0b94-08d85c01eb0a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686D02ECCAAD88BA9DB50B9923F0@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQUBa8e3gAOwl4pkbN2t3yMOryfb68fOPJoByrZ5ptQRv4R0X7cbiTgPtxZNceaGNRDhqZbsqiXbMadfAx00rH31xFRsSLcONgrPbSLJ2IyahX19YEOu4zfkRW2/oRSnFobiVYpAFCcTIGnB/8qK8oWQUThQ3HPCy4dYz0IpFeKhfEALbszO1YupJCjGZ5s8Pq/sDdKMjT9F0SY2RhBCbXkRUlzdZVeYDg+T0y3VcLcFLazOG39BVPul2NP2+gih6kx2EquHmxb32pSJdY+p93mL8MBURS8424uZLcOfIAchL++jVgB+Eznxdcu6SNyW2QmVqaoYQ2kx0+H9PIWzdtpx51Z+b5eiRPQmtPkOopFlpQADx9utcZ0i0i4HkgCrlY1CRBZ1nyev2EfHnotCnKPnpyAbCLbEf6zNISkuMwr6E/HDxkfVtLBJN3wZuuIL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66556008)(52116002)(186003)(8936002)(16526019)(5660300002)(2906002)(26005)(66946007)(6486002)(31696002)(66476007)(83380400001)(44832011)(31686004)(86362001)(956004)(2616005)(16576012)(8676002)(316002)(478600001)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Gottdy5An/0uauAkmFs/5EeMIOQEJIT6IJVU66drNdKVnIXEY8kTLbONIOZXF1u+fNXQcPEayFtoCL5+Tv/MWlPYQ8HDstTncYYMbimlFt/DUcel6Z4geTAuQOVpJ6EzpzG//RVLCVf2o1B6srBt8ra2EGVHJ1VHgWuNsK0n9ow8gz0909msyhbsI/4hJ+1GRKwaf7IlpdzS8PgvdfAxfPMlomPifrtOlxAYCoQseMabKZ3wlBE2PcWxWyLmoFH7lSFRs2m6upoIvQ2BV9YVQ0bKfDeaKNwzhGnT5pLbvJs4J+GxDpeafFibTQ8Unc/pAgumWpAuzquWyjnoxFz0r+Pqe3UUS0E6xG2onw7crRwRBuVA0rAhQkM+cRrg13gZGORaNOLK7gkfRxbV6pxjG6l4QSkcTQ8DQAt0NuEbET0GiMDPwsPA9zDnF376Ij/rQUdCz91uFMVX0958QACgS7JaSlhCIHHrSViyGdeFDGAXNOL8aqMz6JogP2n9l11bjC02oyzaJnIymtS3LXT3a+Qy/eWwJ5OCNxlFMnWpJdvGWfGLVQWxZRXlsCHJ9W7kwXFTAHh4w12KiQ6MbtyYi6RnfRVeb0cPa8HDz99z/m2ElxxPbUdLkEzmyWCn/XVoa7tqO29bucvNri06gw28pg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d24279-3df9-4685-0b94-08d85c01eb0a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:37:38.2521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEGUpMc6jhrQUPyg1M87O8ynPagkJwroDYiS5ijIFRTgc0JKgTRtFNOWfaaxIWMyJ/WAWLspbVojziYrdaLAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
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

CkFtIDIwMjAtMDktMTggdW0gMTozMSBwLm0uIHNjaHJpZWIgS2VudCBSdXNzZWxsOgo+IEluc3Rl
YWQgb2YgZ3Vlc3NpbmcgYXQgYSBzdWZmaWNpZW50IHNpemUgZm9yIHRoZSBDUFUgVkNSQVQsIGJh
c2UgdGhlCj4gc2l6ZSBvbiB0aGUgbnVtYmVyIG9mIG9ubGluZSBOVU1BIG5vZGVzLgo+Cj4gU2ln
bmVkLW9mZi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4KPiBDaGFuZ2Ut
SWQ6IEk1ZmI2ZTYwZjE0MTBhZDY5NmFiNzhkNzgwZDBiNDBkMDFhNGY4MjliCgpQbGVhc2UgcmVt
b3ZlIHRoZSBDaGFuZ2VJZC4KCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfY3JhdC5jIHwgMjYgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfY3JhdC5jCj4gaW5kZXggM2ZhYzA2YjI4MWNlLi45OTE4MmI4ZTkxNTIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiBAQCAtODA5LDExICs4MDks
MTAgQEAgaW50IGtmZF9jcmVhdGVfY3JhdF9pbWFnZV9hY3BpKHZvaWQgKipjcmF0X2ltYWdlLCBz
aXplX3QgKnNpemUpCj4gIAo+ICAvKiBNZW1vcnkgcmVxdWlyZWQgdG8gY3JlYXRlIFZpcnR1YWwg
Q1JBVC4KPiAgICogU2luY2UgdGhlcmUgaXMgbm8gZWFzeSB3YXkgdG8gcHJlZGljdCB0aGUgYW1v
dW50IG9mIG1lbW9yeSByZXF1aXJlZCwgdGhlCj4gLSAqIGZvbGxvd2luZyBhbW91bnQgYXJlIGFs
bG9jYXRlZCBmb3IgQ1BVIGFuZCBHUFUgVmlydHVhbCBDUkFULiBUaGlzIGlzCj4gKyAqIGZvbGxv
d2luZyBhbW91bnQgaXMgYWxsb2NhdGVkIGZvciBHUFUgVmlydHVhbCBDUkFULiBUaGlzIGlzCj4g
ICAqIGV4cGVjdGVkIHRvIGNvdmVyIGFsbCBrbm93biBjb25kaXRpb25zLiBCdXQgdG8gYmUgc2Fm
ZSBhZGRpdGlvbmFsIGNoZWNrCj4gICAqIGlzIHB1dCBpbiB0aGUgY29kZSB0byBlbnN1cmUgd2Ug
ZG9uJ3Qgb3ZlcndyaXRlLgo+ICAgKi8KPiAtI2RlZmluZSBWQ1JBVF9TSVpFX0ZPUl9DUFUJKDIg
KiBQQUdFX1NJWkUpCj4gICNkZWZpbmUgVkNSQVRfU0laRV9GT1JfR1BVCSg0ICogUEFHRV9TSVpF
KQo+ICAKPiAgLyoga2ZkX2ZpbGxfY3VfZm9yX2NwdSAtIEZpbGwgaW4gQ29tcHV0ZSBpbmZvIGZv
ciB0aGUgZ2l2ZW4gQ1BVIE5VTUEgbm9kZQo+IEBAIC05NjQsNyArOTYzLDcgQEAgc3RhdGljIGlu
dCBrZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2NwdSh2b2lkICpwY3JhdF9pbWFnZSwgc2l6ZV90ICpz
aXplKQo+ICAjZW5kaWYKPiAgCWludCByZXQgPSAwOwo+ICAKPiAtCWlmICghcGNyYXRfaW1hZ2Ug
fHwgYXZhaWxfc2l6ZSA8IFZDUkFUX1NJWkVfRk9SX0NQVSkKPiArCWlmICghcGNyYXRfaW1hZ2Up
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gIAo+ICAJLyogRmlsbCBpbiBDUkFUIEhlYWRlci4KPiBA
QCAtMTM2NCwyNCArMTM2MywzMSBAQCBpbnQga2ZkX2NyZWF0ZV9jcmF0X2ltYWdlX3ZpcnR1YWwo
dm9pZCAqKmNyYXRfaW1hZ2UsIHNpemVfdCAqc2l6ZSwKPiAgCQkJCSAgdWludDMyX3QgcHJveGlt
aXR5X2RvbWFpbikKPiAgewo+ICAJdm9pZCAqcGNyYXRfaW1hZ2UgPSBOVUxMOwo+IC0JaW50IHJl
dCA9IDA7Cj4gKwlpbnQgcmV0ID0gMCwgbnVtX25vZGVzOwo+ICsJc2l6ZV90IGR5bl9zaXplOwo+
ICAKPiAgCWlmICghY3JhdF9pbWFnZSkKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgCj4gIAkqY3Jh
dF9pbWFnZSA9IE5VTEw7Cj4gIAo+IC0JLyogQWxsb2NhdGUgb25lIFZDUkFUX1NJWkVfRk9SX0NQ
VSBmb3IgQ1BVIHZpcnR1YWwgQ1JBVCBpbWFnZSBhbmQKPiAtCSAqIFZDUkFUX1NJWkVfRk9SX0dQ
VSBmb3IgR1BVIHZpcnR1YWwgQ1JBVCBpbWFnZS4gVGhpcyBzaG91bGQgY292ZXIKPiAtCSAqIGFs
bCB0aGUgY3VycmVudCBjb25kaXRpb25zLiBBIGNoZWNrIGlzIHB1dCBub3QgdG8gb3ZlcndyaXRl
IGJleW9uZAo+IC0JICogYWxsb2NhdGVkIHNpemUKPiArCS8qIEFsbG9jYXRlIHRoZSBDUFUgVmly
dHVhbCBDUkFUIHNpemUgYmFzZWQgb24gdGhlIG51bWJlciBvZiBvbmxpbmUKPiArCSAqIG5vZGVz
LiBBbGxvY2F0ZSBWQ1JBVF9TSVpFX0ZPUl9HUFUgZm9yIEdQVSB2aXJ0dWFsIENSQVQgaW1hZ2Uu
Cj4gKwkgKiBUaGlzIHNob3VsZCBjb3ZlciBhbGwgdGhlIGN1cnJlbnQgY29uZGl0aW9ucy4gQSBj
aGVjayBpcyBwdXQgbm90Cj4gKwkgKiB0byBvdmVyd3JpdGUgYmV5b25kIGFsbG9jYXRlZCBzaXpl
IGZvciBHUFVzCj4gIAkgKi8KPiAgCXN3aXRjaCAoZmxhZ3MpIHsKPiAgCWNhc2UgQ09NUFVURV9V
TklUX0NQVToKPiAtCQlwY3JhdF9pbWFnZSA9IGttYWxsb2MoVkNSQVRfU0laRV9GT1JfQ1BVLCBH
RlBfS0VSTkVMKTsKPiArCQludW1fbm9kZXMgPSBudW1fb25saW5lX25vZGVzKCk7Cj4gKwkJZHlu
X3NpemUgPSBzaXplb2Yoc3RydWN0IGNyYXRfaGVhZGVyKSArCj4gKwkJCW51bV9ub2RlcyAqIChz
aXplb2Yoc3RydWN0IGNyYXRfc3VidHlwZV9jb21wdXRldW5pdCkgKwo+ICsJCQlzaXplb2Yoc3Ry
dWN0IGNyYXRfc3VidHlwZV9tZW1vcnkpICsKPiArCQkJKG51bV9ub2RlcyAtIDEpICogc2l6ZW9m
KHN0cnVjdCBjcmF0X3N1YnR5cGVfaW9saW5rKSk7Cj4gKwkJcGNyYXRfaW1hZ2UgPSBrbWFsbG9j
KGR5bl9zaXplLCBHRlBfS0VSTkVMKTsKCldlIHNob3VsZCB1c2Uga3ZtYWxsb2MgaGVyZS4gVGhl
biB3ZSBhbHNvIG5lZWQga3ZmcmVlIHRvIGZyZWUgdGhlCm1lbW9yeS4gRm9yIGNvbnNpc3RlbmN5
LCB1c2Uga3ZtYWxsb2MgZm9yIEdQVSBDUkFUIGFsbG9jYXRpb24sIHRvbywgYW5kCnJlcGxhY2Ug
dGhlIGttZW1kdXAgaW4ga2ZkX2NyZWF0ZV9jcmF0X2ltYWdlX2FjcGkgd2l0aCBrdm1hbGxvYytt
ZW1jcHkuCgpMZXQncyBtYWtlIHRoYXQga21hbGxvYy0+a3ZtYWxsb2MgY2hhbmdlIGEgc2Vjb25k
IGNvbW1pdC4KClRoaXMgcGF0Y2ggaXMKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+ICAJCWlmICghcGNyYXRf
aW1hZ2UpCj4gIAkJCXJldHVybiAtRU5PTUVNOwo+IC0JCSpzaXplID0gVkNSQVRfU0laRV9GT1Jf
Q1BVOwo+ICsJCSpzaXplID0gZHluX3NpemU7Cj4gKwkJcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAl
ZCIsIGR5bl9zaXplKTsKPiAgCQlyZXQgPSBrZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2NwdShwY3Jh
dF9pbWFnZSwgc2l6ZSk7Cj4gIAkJYnJlYWs7Cj4gIAljYXNlIENPTVBVVEVfVU5JVF9HUFU6Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
