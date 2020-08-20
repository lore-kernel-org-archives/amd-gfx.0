Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817CC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E30B206FA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tgc8oNSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E30B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8BB6E088;
	Thu, 20 Aug 2020 08:58:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B20A6E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 08:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSafRuYikz4ePQntNA88xPVC+0C13OqOXaYAGPhx/1vEzjD9CSoQ1v7p9av6Xb+eZA3J1qNDf3oxD90OYv5LXIjkpm4mj9eZlYwl4qHXtp/KKuORVEdbN8/ZlHE8TWI5htLDZXAesem/3FdqlAeLUZvgJXQ3KCMTOE8Ho1aZZI60NUHKZMCrywSQ/5JnWrdyr5cdvv3FkZ4lsfERix2UubGDU+jia8pTQsT154a+363MeKf4nhAsXK16/Tdo9YWDTgFxA8NqeewFkiZONwDQJKatnj17KSaiwoTZJomi8/24UbjLz6me4VO5oZLfUMtBFPiRuI8yJzNY5qEl7aZH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSGFhLlAWiHnOwuugqJBbku/tZHWksXOtGc8+IkSAOA=;
 b=Huon9Zq3BMp0U1jXnMISjsTS7PVrD//Gx6zVkViRAZXSOno6FGIQbz/xScVsn6bitQ4J9eoXdOuafRwPm9tmGf7blOblTi0DN645mWAzuwdUhPF553FDqOItQGaUZsCpU/5rxxGRDtfAwCiMw96uTn2Q7ed02u1s0e7cuGhWLJXU/44CVxDxVnerDjKQSj+2K7vbQc5I8n5fgBV/q+aCOz2NjD6hqoTNqa4MnBgeMQS3AtBV52QwD170R/sWe02cNKG4X+hWd+6T3fjLV0sIQykLJU3NEDeWwKFYE9VcYMcWTO9xnaW4qstfAiiYJMmS2+rMlwVgk0NRjDh0Raffwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSGFhLlAWiHnOwuugqJBbku/tZHWksXOtGc8+IkSAOA=;
 b=Tgc8oNSPFV+OnzfTpNLsRxMGrXVIKPbHrUQUJcpSaTs0VidRdcunmN0KNkxAn4nLCwfl2/Xjv4wozW3ZWe6zpz9ZvB3scQFno+WAFMiZ4IDXYkyXaYZDUrj8I9bulK8U5dyOh/vVK/y26EYhaZq8xNPcLLP9V5pIDyeJQMTWHSU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 20 Aug
 2020 08:58:48 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 08:58:48 +0000
Subject: Re: [PATCH v5] drm/amdgpu: add new trace event for page table update
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200820052705.14468-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <448fc685-b28f-77e9-4785-c8d9f0e4caba@amd.com>
Date: Thu, 20 Aug 2020 10:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200820052705.14468-1-shashank.sharma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0021.eurprd02.prod.outlook.com (2603:10a6:208:3e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 08:58:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5402a67b-c8d5-433a-4fae-08d844e74039
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37259B1773BAA516A4992276835A0@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsAxe/WuG6XKrybyn0g/5qX1cg2WmRNcfQizwTzKxUOBPF+8/eHelPHS3RRGZKCRXhtOGw08hLrkCPKNjRV/i4Ljliw9YtMur9npHII0iOpVdZJ7ShKcggBXZOOzd3nZkmR5cPhpQS90ea4Ut+X5R9G0Gkdh+Y6qniT/HSkVxts9l8uyD7e1qLfTa0Fnc/epEZWcb1goRmEk8pgIN1zxa+HeyDJBSQWN7IhNo4wMITZmV3o0M5i4PLvDtsUBk6RQH2HSg+uspcDrRPsqSDm6eFxezNN82UnyiLRLhElTBxy8wKehGZmQ5TlslCe+eRRIb+wkm+NS7dG8S4DznaIXg82q6sFBNffq7cCjj8Ykt3OKP1sdvvP+H3w4ngcPhYww
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(2906002)(31696002)(66556008)(16526019)(4326008)(8676002)(66476007)(8936002)(83380400001)(316002)(186003)(15650500001)(5660300002)(66946007)(52116002)(478600001)(66574015)(6666004)(6486002)(86362001)(36756003)(31686004)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Rl3jd6dA3nZFfDfOBbIzli7+ND1zVN2l5jRoO5G1zZwGMnSQNCNLB+OBsZgm2T/X+qIU/nrJVzRyEKrJJYaZ/Og01n5WDBr2rA0LhgwxXM+V9lkj+ccc91LsQXNbV4nZigEZ+Q+L4X1bthtrxtWH6avlkkCkBFF/hM766CgmE+dCOB+1wrtjwaJZt1Qm+zdefK4Ju4iJt4QhaF57uKuEoPCWaamLCR9dogGf23JFX4I2I6aaGmwmJFnwRJH3cyJMogDNV5WOC+Imm3vYf4aseWnfwQC9BB7yGZc3XMJG/7r/oQHQFgGY8mwcjlbXGd14zdoJlt9eHu4+acrkozgiuJH/6S2Nb+i7AIMDuuUG6/kf9sQ5DAW5NcdTJMF3TKOIvi5VSzye9VonOyaGmcs7L6Z6GiWUSQSnzJ/MqRqoYOVJCbQLkXEjEfGCBaq8f/fGJ+OoNaPxpCd9PpDj5+dfYkGWZXfkXjBDmTB7yp76bB3r5ky9Msq+PJpdH9F4T5C0+zQrGvE2a1g7SVvDOJjjM4QwZ7T5d/fWxiHbEy0dT+H+IhYcDj1TPOsSfK1oQEmIPNHq/NC4hJVYVJJ6r7ixMpvAkyFCUK4mewWIXywGG4pTkxxxE4lVeBSE95C6KVGfInqrlCREaDHThMywarcb+QkxFQApk0qEBm4yksg6W4HALBgCBo7GZqI2DJccJfmLnglqlbl07tkPC14ORu6oaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5402a67b-c8d5-433a-4fae-08d844e74039
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 08:58:48.0306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT1nWRHS+BPvQE1CyxoMI22lU8u+74p9srbui0H9yweRDMW1DGHFe/387VcQV8mJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDguMjAgdW0gMDc6Mjcgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gVGhpcyBwYXRj
aCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRlCj4gZXZlbnRz
LiBUaGlzIHNwZWNpZmljIGV2ZW50IHdpbGwgcHJvdmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+IC0g
c3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4gLSBIVyBlbmdpbmUgZmxh
Z3MgZm9yIHRoZSBtYXAKPiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPgo+IFRoaXMg
d2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkgcHJvZmlsaW5nIHRvb2xzCj4g
KGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRhdGUgZXZl
bnRzLgo+Cj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJlc3MgbG9va3VwIGxvZ2ljIGluIHRyYWNl
IHBvaW50Cj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5Cj4gICAgICBhZGRlZCBu
cHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPiAgICAgIGFkZGVkIHBhZ2Ugc2l6
ZSBpbiB0aGUgYXJnIGxpc3QKPiBWNDogQWRkcmVzc2VkIENocmlzdGlhbidzIHJldmlldyBjb21t
ZW50cwo+ICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+ICAgICAgdXNlIGluY3Ig
aW5zdGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4gVjU6IEFkZHJlc3NlZCBDaHJpc3Rp
YW4ncyByZXZpZXcgY29tbWVudHM6Cj4gICAgICBhZGQgcGlkIGFuZCB2bSBjb250ZXh0IGluZm9y
bWF0aW9uIGluIHRoZSBldmVudAo+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJt
YUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Ry
YWNlLmggfCA0MyArKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAxMSArKysrLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4gaW5kZXggNjNlNzM0YTEyNWZiLi4wMjQwNmZjNmRiMGYg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+IEBAIC0z
MjEsNiArMzIxLDQ5IEBAIERFRklORV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywgYW1kZ3B1X3Zt
X2JvX2NzLAo+ICAgCSAgICBUUF9BUkdTKG1hcHBpbmcpCj4gICApOwo+ICAgCj4gK1RSQUNFX0VW
RU5UKGFtZGdwdV92bV91cGRhdGVfcHRlcywKPiArCSAgICBUUF9QUk9UTyhzdHJ1Y3QgYW1kZ3B1
X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCj4gKwkJICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3Qg
ZW5kLAo+ICsJCSAgICAgdW5zaWduZWQgaW50IG5wdGVzLCB1aW50NjRfdCBkc3QsCj4gKwkJICAg
ICB1aW50NjRfdCBpbmNyLCB1aW50NjRfdCBmbGFncywKPiArCQkgICAgIHVpbnQ2NF90IHBpZCwg
dWludDY0X3Qgdm1fY3R4KSwKPiArCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwg
aW5jciwgZmxhZ3MsIHBpZCwgdm1fY3R4KSwKPiArCVRQX1NUUlVDVF9fZW50cnkoCj4gKwkJCSBf
X2ZpZWxkKHU2NCwgc3RhcnQpCj4gKwkJCSBfX2ZpZWxkKHU2NCwgZW5kKQo+ICsJCQkgX19maWVs
ZCh1NjQsIGZsYWdzKQo+ICsJCQkgX19maWVsZCh1bnNpZ25lZCBpbnQsIG5wdGVzKQo+ICsJCQkg
X19maWVsZCh1NjQsIGluY3IpCj4gKwkJCSBfX2ZpZWxkKHU2NCwgcGlkKQoKUGxlYXNlIHVzZSBw
aWRfdCBmb3IgdGhlIHBpZCBoZXJlLgoKPiArCQkJIF9fZmllbGQodTY0LCB2bV9jdHgpCj4gKwkJ
CSBfX2R5bmFtaWNfYXJyYXkodTY0LCBkc3QsIG5wdGVzKQo+ICsJKSwKPiArCj4gKwlUUF9mYXN0
X2Fzc2lnbigKPiArCQkJdW5zaWduZWQgaW50IGk7Cj4gKwo+ICsJCQlfX2VudHJ5LT5zdGFydCA9
IHN0YXJ0Owo+ICsJCQlfX2VudHJ5LT5lbmQgPSBlbmQ7Cj4gKwkJCV9fZW50cnktPmZsYWdzID0g
ZmxhZ3M7Cj4gKwkJCV9fZW50cnktPmluY3IgPSBpbmNyOwo+ICsJCQlfX2VudHJ5LT5ucHRlcyA9
IG5wdGVzOwo+ICsJCQlfX2VudHJ5LT5waWQgPSBwaWQ7Cj4gKwkJCV9fZW50cnktPnZtX2N0eCA9
IHZtX2N0eDsKPiArCQkJZm9yIChpID0gMDsgaSA8IG5wdGVzOyArK2kpIHsKPiArCQkJCXU2NCBh
ZGRyID0gcC0+cGFnZXNfYWRkciA/IGFtZGdwdV92bV9tYXBfZ2FydCgKPiArCQkJCQlwLT5wYWdl
c19hZGRyLCBkc3QpIDogZHN0Owo+ICsKPiArCQkJCSgodTY0ICopX19nZXRfZHluYW1pY19hcnJh
eShkc3QpKVtpXSA9IGFkZHI7Cj4gKwkJCQlkc3QgKz0gaW5jcjsKPiArCQkJfQo+ICsJKSwKPiAr
CVRQX3ByaW50aygic3RhcnQ6MHglMDEwbGx4IGVuZDoweCUwMTBsbHgsIGZsYWdzOjB4JWxseCwg
aW5jcjolbGx1LCIKPiArCQkgICIgcGlkOiVsbGQgdm1fY3R4OjB4JWxseCBkc3Q6XG4lcyIsIF9f
ZW50cnktPnN0YXJ0LAoKSSB3b3VsZCByZW9yZGVyIHRoaXMgdG8gInBpZCwgdm1fY3R4LCBzdGFy
dCwgZW5kLCBmbGFncywgaW5jciwgZHN0Ii4gQW5kIApiZXR0ZXIgdXNlICV1IGZvciB0aGUgcGlk
LgoKQXBhcnQgZnJvbSB0aGF0IHRoaXMgbG9va3MgZ29vZCB0byBtZS4KCkNocmlzdGlhbi4KCj4g
KwkJICBfX2VudHJ5LT5lbmQsIF9fZW50cnktPmZsYWdzLCBfX2VudHJ5LT5pbmNyLCBfX2VudHJ5
LT5waWQsCj4gKwkJICBfX2VudHJ5LT52bV9jdHgsIF9fcHJpbnRfYXJyYXkoX19nZXRfZHluYW1p
Y19hcnJheShkc3QpLAo+ICsJCSAgX19lbnRyeS0+bnB0ZXMsIDgpKQo+ICspOwo+ICsKPiAgIFRS
QUNFX0VWRU5UKGFtZGdwdV92bV9zZXRfcHRlcywKPiAgIAkgICAgVFBfUFJPVE8odWludDY0X3Qg
cGUsIHVpbnQ2NF90IGFkZHIsIHVuc2lnbmVkIGNvdW50LAo+ICAgCQkgICAgIHVpbnQzMl90IGlu
Y3IsIHVpbnQ2NF90IGZsYWdzLCBib29sIGRpcmVjdCksCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA4YmMyMjUzOTM5YmUuLjNkMjU3MzliNDE1OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE1MTEsMTkgKzE1MTEs
MjYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91
cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gICAJCWVudHJ5X2VuZCA9IG1pbihlbnRyeV9lbmQsIGVu
ZCk7Cj4gICAKPiAgIAkJZG8gewo+ICsJCQlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9IHBhcmFtcy0+
dm07Cj4gICAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+
ICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+
ICsJCQl1aW50NjRfdCB1cGRfZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKTsK
PiAgIAo+ICAgCQkJLyogVGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZlbCBQ
RHMgdG8KPiAgIAkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4KPiAgIAkJCSAqLwo+
ICAgCQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPiArCj4gKwkJCXRyYWNlX2FtZGdwdV92bV91
cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4gKwkJCQkJCSAgICBucHRl
cywgZHN0LCBpbmNyLCB1cGRfZmxhZ3MsCj4gKwkJCQkJCSAgICB2bS0+dGFza19pbmZvLnBpZCwK
PiArCQkJCQkJICAgIHZtLT5pbW1lZGlhdGUuZmVuY2VfY29udGV4dCk7Cj4gICAJCQlhbWRncHVf
dm1fdXBkYXRlX2ZsYWdzKHBhcmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPiAgIAkJCQkJICAgICAg
IHBlX3N0YXJ0LCBkc3QsIG5wdGVzLCBpbmNyLAo+IC0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQ
VV9QVEVfRlJBRyhmcmFnKSk7Cj4gKwkJCQkJICAgICAgIHVwZF9mbGFncyk7Cj4gICAKPiAgIAkJ
CXBlX3N0YXJ0ICs9IG5wdGVzICogODsKPiAtCQkJZHN0ICs9ICh1aW50NjRfdClucHRlcyAqIEFN
REdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0Owo+ICsJCQlkc3QgKz0gbnB0ZXMgKiBpbmNyOwo+
ICAgCj4gICAJCQlmcmFnX3N0YXJ0ID0gdXBkX2VuZDsKPiAgIAkJCWlmIChmcmFnX3N0YXJ0ID49
IGZyYWdfZW5kKSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
