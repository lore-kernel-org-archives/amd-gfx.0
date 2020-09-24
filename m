Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A70C4346E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 15:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAA020758
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LyrjTIiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAA020758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4424D6E045;
	Thu, 24 Sep 2020 15:35:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690080.outbound.protection.outlook.com [40.107.69.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05AB6E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 15:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSusHtliH45IMy5d1tHKSbrGa003xb26ukFZRhNkzYxS3yX6y6121g09HvV6zMKEsQkDv9D07dOESN3hhh0FBsJrcetKr2nSGy3Q/18Ku86ciluqKabZTDzUFLxS6ndSQfKS1nCMn6liU9IdtDqA0McAcR0dWSva8jAnVjQYkbNGb9Q/f21NRtTCWASLq5dISoUpWcdpUU3JdalrA08+RJIN6XY9tA5Fdhx061tJGbNORuqulrRYi36HRVAizQzlGBjYhI4mlOD5LxKFV6mXfg/MZeYjOwqObW7vvEbn25tgvJre7/ZlhyFcV6seKM593LGpmQAFoFpKdZ9Me2XMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYXWMxZEKueYedzX1ZBHPXzt8Z8wPlMcAU0VegkdbZc=;
 b=K/ZKD+IWnsLqLjkh0HC/Gy6U3iQKwnX5ltXthiBy03a/SKuaG8q1/GhC01jAPbKwc9Oh6ng7IFfegnCw3Oxgmzf0uncR+cFVyPadwfhYQoOcstoYttsECSfZK8aO1ccxu9CAw8f9KaJz0jMb+BC5kpyf0mnxcPxs2E7j92lNccKkBZQvRHnizU8klzPx/5A3WtOLy2vl5C8CZNXdX+0m0I2EwarmYgCm73YFPFpGbtbyzM5PBhKALnqr81DjbsD4rpfYAfAO8CoAilN6XkVq5I6SqBbxlD9z2Vvw6heN08KwHLJuwJl9CmKMt+Z4AP1azewDXERiXniwmq/DWb5Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYXWMxZEKueYedzX1ZBHPXzt8Z8wPlMcAU0VegkdbZc=;
 b=LyrjTIiX01ByWSP7QphZ+i4ryiKzwNoVR8kZpYpvTTqY0GSxLv0dDhyjxb16sfuGhaU5THLSE480ywRGD4sKVyYsFUctXtuzMGFQUIwCZefBxYe6Zfw07RKF0xMyTvC1dNZ0ihEwkMb1uPzbF7AdERoHyRfqhNknhIyrVWO57W8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2516.namprd12.prod.outlook.com (2603:10b6:207:4e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 15:35:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 15:35:45 +0000
Subject: Re: [PATCH] drm/amdgpu: clean up ras sysfs creation (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com, alexander.deucher@amd.com, lijo.lazar@amd.com
References: <20200924145156.8114-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e8f096c4-55b3-fc67-9b6f-333c0200f6b7@amd.com>
Date: Thu, 24 Sep 2020 17:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200924145156.8114-1-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR07CA0058.eurprd07.prod.outlook.com
 (2603:10a6:207:4::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0058.eurprd07.prod.outlook.com (2603:10a6:207:4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.9 via Frontend Transport; Thu, 24 Sep 2020 15:35:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c5ebb59-33e2-452b-df1e-08d8609f810e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25167D80056DF875A3A44D9C83390@BL0PR12MB2516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8l3V24hlpVr5XIeumRMXbj5UYu6Y/eOOcjq13YR6Ana5ZpgT+yKk3CbqFLUTq3huevr2hazArv7bsOsA5RbQAiedqVTfpbkjwooctqNhJtZ6t1YQYcZCS4L4Yzoxbzm3XgWDhrPYeN4E5J4vD7h+1c1MdB1J+nceKCnIHBt4+ZU/kkLJFyAOWP71dD6bZS/SJEgnqRc6ZH+55hy4T8aBr33EXvWRHiQHu7nnjb9GgzFeZDxAo9j8rcqRkP7eazkofvv4ijtz7IhWkD5tlQdkGzQnf3BWM0A3LckCW7WUenLU4SyOY+uPG8JnY7XW2kIWXtlpJmYlli8Mr14Y4v7es4ZDBq6fB+wf0jyOctmlOukeQJ5dHQTbjwmUkKavuoZrxCKxac2tkFwTM0cbC8z4dSlVxwaieB3wXPk6QLdCwK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(86362001)(8936002)(66556008)(316002)(66476007)(52116002)(16526019)(66574015)(6666004)(2616005)(6636002)(6486002)(5660300002)(478600001)(186003)(31686004)(2906002)(83380400001)(31696002)(36756003)(66946007)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KUTt57Y0oJCsb8RgWzmGd5Jny4+ej4B9fIJJ3UnzHxnCyzEv3Top37g8x/J4hKiVmKxn72vhjGQkGgQL1lU7ddopRrB+nEwgTtBwnRmhwOZ80hr+JAu8kfpiS809O7sp4wKU2cbmgrtBme1LO/AP8s0nL5QuFm7qid3pVXQ+cFYtpbpwQGAaqWYxxty3rZVRvIujXi650fjafl0TLI8zzqrzvd5Lylhq1QOsKOvNlYm/AXDlRnGXV+DNnTQ64kcyKJ9QgkXyET4Us1gcBPh4iVi2YJr6i9aYUwYHKgYIV2ZeJ4zrYybAZlqeg/PlPdyM0JoxapWSQw4WXAVyfitpL69IPBiyjZ/t95oqx2uv9bIoNwmdZIb3HkQPL3S/2eI+1Lz7YsDiFFj9A9/1LGB0O8wH1AX3ou0koa44+M/aQ6z0/17UTMgVJARsBOG1LFUlmGn+uRfdPiCoXRuVghW49EAnVvIZTmhAxtNBr0dliMtsI6OovSKr0Pt+oHeNcVeXZ1e/ZIRORVpwtaimpJtgA9BRL82ft6oahNppkkpkOwhL3FzOqamt7duP6xISi2wzJZOH0OqtOWJo4WnLkyh69WWvmri+Y7TjeF+RDMw2XiXZMGK+jurujx2F2l/6qQ7LT3Z2uNKh8CQDMY/wm35pvjgYtZfmDLCmBN180MiaKPGPlH9ncFv55U3tnKs89jo1wNb9AEgqnc1ldZvsckZOnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ebb59-33e2-452b-df1e-08d8609f810e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 15:35:45.6875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkS/AtlsCv4dSxfEEPkoByicjpMnlk+TlwSmUV2ym9q4daAxFYAqW8CPjMHgKjRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2516
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

QW0gMjQuMDkuMjAgdW0gMTY6NTEgc2NocmllYiBHdWNodW4gQ2hlbjoKPiBNZXJnZSByYXMgc3lz
ZnMgY3JlYXRpb24gdG9nZXRoZXIgYnkgY2FsbGluZyBzeXNmc19jcmVhdGVfZ3JvdXAKPiBvbmNl
LCBhcyBzeXNmc191cGRhdGVfZ3JvdXAgbWF5IG5vdCB3b3JrIHByb3Blcmx5IGFzIGV4cGVjdGVk
Lgo+Cj4gdjI6IGltcHJvdmUgY29tbWl0IG1lc3NhZ2UKPgo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1
biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMgfCA4NyArKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4gICAx
IGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNTYgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4gaW5kZXggZTVlYTE0Nzc0YzBjLi42
YzU3NTIxYjIxZmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
Cj4gQEAgLTEwMjcsNTggKzEwMjcsNiBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfcmFzX3N5c2Zz
X2ZlYXR1cmVzX3JlYWQoc3RydWN0IGRldmljZSAqZGV2LAo+ICAgCXJldHVybiBzY25wcmludGYo
YnVmLCBQQUdFX1NJWkUsICJmZWF0dXJlIG1hc2s6IDB4JXhcbiIsIGNvbi0+ZmVhdHVyZXMpOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfc3lzZnNfYWRkX2JhZF9wYWdlX25v
ZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gLXsKPiAtCXN0cnVjdCBhbWRncHVfcmFz
ICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOwo+IC0Jc3RydWN0IGF0dHJpYnV0
ZV9ncm91cCBncm91cDsKPiAtCXN0cnVjdCBiaW5fYXR0cmlidXRlICpiaW5fYXR0cnNbXSA9IHsK
PiAtCQkmY29uLT5iYWRwYWdlc19hdHRyLAo+IC0JCU5VTEwsCj4gLQl9Owo+IC0KPiAtCWNvbi0+
YmFkcGFnZXNfYXR0ciA9IChzdHJ1Y3QgYmluX2F0dHJpYnV0ZSkgewo+IC0JCS5hdHRyID0gewo+
IC0JCQkubmFtZSA9ICJncHVfdnJhbV9iYWRfcGFnZXMiLAo+IC0JCQkubW9kZSA9IFNfSVJVR08s
Cj4gLQkJfSwKPiAtCQkuc2l6ZSA9IDAsCj4gLQkJLnByaXZhdGUgPSBOVUxMLAo+IC0JCS5yZWFk
ID0gYW1kZ3B1X3Jhc19zeXNmc19iYWRwYWdlc19yZWFkLAo+IC0JfTsKPiAtCj4gLQlncm91cC5u
YW1lID0gUkFTX0ZTX05BTUU7Cj4gLQlncm91cC5iaW5fYXR0cnMgPSBiaW5fYXR0cnM7Cj4gLQo+
IC0Jc3lzZnNfYmluX2F0dHJfaW5pdChiaW5fYXR0cnNbMF0pOwo+IC0KPiAtCXN5c2ZzX3VwZGF0
ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+IC19Cj4gLQo+IC1zdGF0aWMgaW50
IGFtZGdwdV9yYXNfc3lzZnNfY3JlYXRlX2ZlYXR1cmVfbm9kZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAtewo+IC0Jc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0
X2NvbnRleHQoYWRldik7Cj4gLQlzdHJ1Y3QgYXR0cmlidXRlICphdHRyc1tdID0gewo+IC0JCSZj
b24tPmZlYXR1cmVzX2F0dHIuYXR0ciwKPiAtCQlOVUxMCj4gLQl9Owo+IC0Jc3RydWN0IGF0dHJp
YnV0ZV9ncm91cCBncm91cCA9IHsKPiAtCQkubmFtZSA9IFJBU19GU19OQU1FLAo+IC0JCS5hdHRy
cyA9IGF0dHJzLAo+IC0JfTsKPiAtCj4gLQljb24tPmZlYXR1cmVzX2F0dHIgPSAoc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUpIHsKPiAtCQkuYXR0ciA9IHsKPiAtCQkJLm5hbWUgPSAiZmVhdHVyZXMi
LAo+IC0JCQkubW9kZSA9IFNfSVJVR08sCj4gLQkJfSwKPiAtCQkJLnNob3cgPSBhbWRncHVfcmFz
X3N5c2ZzX2ZlYXR1cmVzX3JlYWQsCj4gLQl9Owo+IC0KPiAtCXN5c2ZzX2F0dHJfaW5pdChhdHRy
c1swXSk7Cj4gLQo+IC0JcmV0dXJuIHN5c2ZzX2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2Jq
LCAmZ3JvdXApOwo+IC19Cj4gLQo+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19zeXNmc19yZW1v
dmVfYmFkX3BhZ2Vfbm9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsKPiAgIAlz
dHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KTsKPiBA
QCAtMTMwMCwxMyArMTI0OCw0MCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2RlYnVnZnNfcmVt
b3ZlX2FsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIC8qIGRlYnVnZnMgZW5kICov
Cj4gICAKPiAgIC8qIHJhcyBmcyAqLwo+IC0KPiArc3RhdGljIEJJTl9BVFRSKGdwdV92cmFtX2Jh
ZF9wYWdlcywgU19JUlVHTywKPiArCQlhbWRncHVfcmFzX3N5c2ZzX2JhZHBhZ2VzX3JlYWQsIE5V
TEwsIDApOwo+ICtzdGF0aWMgREVWSUNFX0FUVFIoZmVhdHVyZXMsIFNfSVJVR08sCj4gKwkJYW1k
Z3B1X3Jhc19zeXNmc19mZWF0dXJlc19yZWFkLCBOVUxMKTsKPiAgIHN0YXRpYyBpbnQgYW1kZ3B1
X3Jhc19mc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+IC0JYW1kZ3B1
X3Jhc19zeXNmc19jcmVhdGVfZmVhdHVyZV9ub2RlKGFkZXYpOwo+ICsJc3RydWN0IGFtZGdwdV9y
YXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7Cj4gKwlzdHJ1Y3QgYXR0cmli
dXRlX2dyb3VwIGdyb3VwID0gewo+ICsJCS5uYW1lID0gUkFTX0ZTX05BTUUsCj4gKwl9Owo+ICsJ
c3RydWN0IGF0dHJpYnV0ZSAqYXR0cnNbXSA9IHsKPiArCQkmY29uLT5mZWF0dXJlc19hdHRyLmF0
dHIsCj4gKwkJTlVMTAo+ICsJfTsKPiArCXN0cnVjdCBiaW5fYXR0cmlidXRlICpiaW5fYXR0cnNb
XSA9IHsKPiArCQlOVUxMLAo+ICsJCU5VTEwsCj4gKwl9Owo+ICAgCj4gLQlpZiAoYW1kZ3B1X2Jh
ZF9wYWdlX3RocmVzaG9sZCAhPSAwKQo+IC0JCWFtZGdwdV9yYXNfc3lzZnNfYWRkX2JhZF9wYWdl
X25vZGUoYWRldik7Cj4gKwkvKiBhZGQgZmVhdHVyZXMgZW50cnkgKi8KPiArCWNvbi0+ZmVhdHVy
ZXNfYXR0ciA9IGRldl9hdHRyX2ZlYXR1cmVzOwo+ICsJZ3JvdXAuYXR0cnMgPSBhdHRyczsKPiAr
CXN5c2ZzX2F0dHJfaW5pdChhdHRyc1swXSk7Cj4gKwo+ICsJaWYgKGFtZGdwdV9iYWRfcGFnZV90
aHJlc2hvbGQgIT0gMCkgewo+ICsJCS8qIGFkZCBiYWRfcGFnZV9mZWF0dXJlcyBlbnRyeSAqLwo+
ICsJCWJpbl9hdHRyX2dwdV92cmFtX2JhZF9wYWdlcy5wcml2YXRlID0gTlVMTDsKPiArCQljb24t
PmJhZHBhZ2VzX2F0dHIgPSBiaW5fYXR0cl9ncHVfdnJhbV9iYWRfcGFnZXM7Cj4gKwkJYmluX2F0
dHJzWzBdID0gJmNvbi0+YmFkcGFnZXNfYXR0cjsKPiArCQlncm91cC5iaW5fYXR0cnMgPSBiaW5f
YXR0cnM7Cj4gKwkJc3lzZnNfYmluX2F0dHJfaW5pdChiaW5fYXR0cnNbMF0pOwo+ICsJfQo+ICsK
PiArCXN5c2ZzX2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+ICAgCj4g
ICAJcmV0dXJuIDA7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
