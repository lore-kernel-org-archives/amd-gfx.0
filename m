Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C12C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 13:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B14222B40
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 13:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XYwP7X5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14222B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058356EAC6;
	Fri, 31 Jul 2020 13:57:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA66F6EAC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 13:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlcAyoagqr2Fg8UnCCVXDkoCBQXqpWCjaCJkW9nHwjUSMjNbtPnT0eeeiZhDiWM4UE7yq11GWBvy0zMdhrMJ6lINiN9OpEZD+aON0tn+ej22dlPzzVBQqC8jD16oVIu6H4XyjMLTsm0irB7PPQ8PXTki2Xng+4IIhgX9hEkmIpU0AdRv5d3ZImItZPcY2rgXraHJGHrtLPw/nGWffagXcWPF0ofFv2MJqbGr1ih4QXswu35hIgrXQ/9VNvfwuf0wrygNmUYQPKec2LVqmK6mT6NG8gbFKe/Mytd8/QJ1C64Vv5qAIoA+fgDouN36HeN2Ie1l/a3ufARLslFX0xr0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms1QL1zitgs/5SLwehnhHRBvVuYUTaZRMUWpZv2hKwE=;
 b=VUabamhDzNuQWHzWxgsaJGGpjegXReKA3AGUX1gCfF3PLgN1mIiB9AJC7VF/tc4xDjBQo3QT5kbX7rXCP310Em2v8Ef1yW/SDnzFoe7viOC90v15M4hZC72ydYEMpQZE8hNhsuy39AQ2kMSjyIDbYkhN9qXQlMsUIX0O74xB74nw6pbMhZEdM/ytW3O7jLkLJ1FCrmihvIj5kRvsR411UO+xrcIfGwsKT+0Wvq+BwlgRoW8WJBkZ9ABhVOxyhRHlPqSTh41VQnV2etCmkVksMCNTbpmEmhC1lq/k+9d8d9DQKtyvnAtg04rzW5Y0JoNUH9X5oYR43QR+vMAMIl9C4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms1QL1zitgs/5SLwehnhHRBvVuYUTaZRMUWpZv2hKwE=;
 b=XYwP7X5QfHGvAwwcP0Nvt2n+Uy6Y9zKhuGNAbxggNkzWRcSIN7gOTnMCfosAV0b8FKXp3bOTllRrL9NQvtpcAO8ryj7xGeTggEXNGo7CrBXVrjg8OTZTzWz09dk9437wGaEdAePxkiBuil/9BW867Wxaueljmtwj7NKJmpjUaAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:57:13 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.019; Fri, 31 Jul 2020
 13:57:13 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a1c5e0a7-d392-8774-d6a1-decb4f9c3235@amd.com>
Date: Fri, 31 Jul 2020 09:57:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::14) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Fri, 31 Jul 2020 13:57:12 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dad576e8-c091-43e8-30e8-08d83559a041
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23665C20479ACB0A7FD6CF9D924E0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 497aRh7EEo7h1BV5VQ5SjXeJOywQOxgQ72KIMDtlanM34L5f0lpz6lc/eoyWT4EM8aNq2Dz+vvmaCpnITY0oeEzmiPw71+7ii2H18c5giMWcotNwVYNA4kuotAnR0BpKW+lp1e05BYkU6tpLU6KjM13gfadwrGqnZ0Hiad+fe2rbb+j5Uqc5x4BzMIVHFjgg2ywbxCnSu4+mN3kz6mQrDsx7kD7Klvu5mInp8bfNNWKGMId2I1JlwprcJYt0kE7oQH4LXAnn5CWv7RW4td8PvjiAY8mZSt5m3cHfQb2euSWi+w7kStNnmPZqzsJnMhWArGI5XnmGfhaEzsU5OpopWtqjt8OEJH83V509Pb0Zk9WhXHVR4ONpPIaq1fMgxzV8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(186003)(16526019)(6486002)(36756003)(8676002)(2906002)(31686004)(83380400001)(8936002)(52116002)(26005)(44832011)(2616005)(956004)(66476007)(66556008)(66946007)(16576012)(86362001)(31696002)(316002)(478600001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9RU5ghXHEdKjkcOhBtruwBTRIztO2Ww1yujnkeqzBUawnDVmdRWSP3p+TLst0ge39diK3Z2SYTZdGd5PVtMQljW3zoXiBGD5iKdfypQwUOmOADKW7ekVS4aNnqoEH4obiewtNvHDz5W4Rt0nBAydVHheDW6QUM5UH3iHW+NZHee8pEWfqcSlWBFq5xEbKIzX3P6bzd1oLBIZrgXIUZAc+nbd50A6muxcb5iyY6zMJ9KB6Wg5CehrrbfhlwkhYbZMJDBYV9RUHoBZogi/fXX5Y/+7QAfUkMR85ufFQfdXdAbbEJ8k1gyFHfWbHfwO5PIRAaqXt2dQWA1b27NFnhNhnMBEmpZX3SKoqS+TEgLwzhHcWw0/PxG/XxlVtOJXx3UvjnNjXdBFrm/IDZvE/abKymvJRLJ9YGw1e+GaSRJ0gVZjRf52S+BZCD5M44jHdggqdjzgJ9MjW84+dP16wvPkLQOUHxCfggp9qTHOh55CtNebaPM3GTzOFZ2S23rMI8yDA+bog86EceSOGghh7NVp76rTvx8Jsbav/UCTfXmbPVF9/rq7IL8EcXC+367gbaE3jcz6VZd79fVORP0hfirG3Nelkb0HAM8ifjlvT8MOMbvdD6rPzfuNvLuVYMgHnw6ETQ2skd9htTRsrfZx3hiuVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad576e8-c091-43e8-30e8-08d83559a041
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:57:13.0913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ua6XsKNfaUUayl8VwlTb4jeYVUIPg46cJt8Blq999r3ym2B5NSc3ZJW0ixLfRc4kkQOirUnDgCuJgmzQdEtSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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

SW4gZ2Z4X3YxMF8wX3N3X2ZpbmkgdGhlIEtJUSByaW5nIGdldHMgZnJlZWQuIFdvdWxkbid0IHRo
YXQgYmUgdGhlIHJpZ2h0CnBsYWNlIHRvIHN0b3AgdGhlIEtJUT8gT3RoZXJ3aXNlIEtJUSB3aWxs
IGhhbmcgYXMgc29vbiBhcyBzb21lb25lCmFsbG9jYXRlcyB0aGUgbWVtb3J5IHRoYXQgd2FzIHBy
ZXZpb3VzbHkgdXNlZCBmb3IgdGhlIEtJUSByaW5nIGJ1ZmZlcgphbmQgb3ZlcndyaXRlcyBpdCB3
aXRoIHNvbWV0aGluZyB0aGF0J3Mgbm90IGEgdmFsaWQgUE00IHBhY2tldC4KClJlZ2FyZHMsCsKg
IEZlbGl4CgpBbSAyMDIwLTA3LTMxIHVtIDM6NTEgYS5tLiBzY2hyaWViIE1vbmsgTGl1Ogo+IEtJ
USB3aWxsIGhhbmcgaWYgd2UgdHJ5IGJlbG93IHN0ZXBzOgo+IG1vZHByb2JlIGFtZGdwdQo+IHJt
bW9kIGFtZGdwdQo+IG1vZHByb2JlIGFtZGdwdSBzY2hlZF9od19zdWJtaXNzaW9uPTQKPgo+IHRo
ZSBjYXVzZSBpcyB0aGF0IGR1ZSB0byBLSVEgaXMgYWx3YXlzIGxpdmluZyB0aGVyZSBldmVuCj4g
YWZ0ZXIgd2UgdW5sb2FkIEtNRCB0aHVzIHdoZW4gZG9pbmcgdGhlIHJlYWxvZCBvZiBLTUQKPiBL
SVEgd2lsbCBjcmFzaCB1cG9uIGl0cyByZWdpc3RlciBwcm9ncmFtZWQgd2l0aCBkaWZmZXJlbnQK
PiB2YWx1ZXMgd2l0aCB0aGUgcHJldmlvdXMgY29uZmlndXJhdGlvbiAodGhlIGNvbmZpZwo+IGxp
a2UgSFFEIGFkZHIsIHJpbmcgc2l6ZSwgaXMgZWFzaWx5IGNoYW5nZWQgaWYgd2UgYWx0ZXIKPiB0
aGUgc2NoZWRfaHdfc3VibWlzc2lvbikKPgo+IHRoZSBmaXggaXMgd2UgbXVzdCBpbmFjdGl2ZSBL
SVEgZmlyc3QgYmVmb3JlIHRvdWNoaW5nIGFueQo+IG9mIGl0cyByZWdpc3RnZXJzCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+
IGluZGV4IGRiOWYxZTguLmY1NzFlMjUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYwo+IEBAIC02NDMzLDYgKzY0MzMsOSBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9r
aXFfaW5pdF9yZWdpc3RlcihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gIAlzdHJ1Y3QgdjEw
X2NvbXB1dGVfbXFkICptcWQgPSByaW5nLT5tcWRfcHRyOwo+ICAJaW50IGo7Cj4gIAo+ICsJLyog
YWN0aXZhdGUgdGhlIHF1ZXVlICovCj4gKwlXUkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfSFFEX0FD
VElWRSwgMCk7Cj4gKwo+ICAJLyogZGlzYWJsZSB3cHRyIHBvbGxpbmcgKi8KPiAgCVdSRUczMl9G
SUVMRDE1KEdDLCAwLCBDUF9QUV9XUFRSX1BPTExfQ05UTCwgRU4sIDApOwo+ICAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
