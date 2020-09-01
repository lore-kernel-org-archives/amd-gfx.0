Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A17C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 08:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F64205CB
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F0hR73hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F64205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBFD6E484;
	Tue,  1 Sep 2020 08:51:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C776E484
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 08:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdlf7KiBNuJ22DBVpTXxvhhCZH8umzvTPtARJ/vnGEQWieAC891I0TLimVGaA/4rrZKtTTOqwSrjqvEvexANOnTpd9/comYbkDNoaMJbJUmJX4+qETA5Pd7Kzyp3K0MS2bzlijZg0W9+JaFuMGCXKEiA4bcMpRbVCMzYXuD7miJXkiDsWq3ErQ//wbY29d8DH2aFZCJ6FcTE1Gd4yDUbtionTXjvTx1hr6kK+AH5eqYttf9sZWzSCLAiHAQ64k04fN2zDYdEc2SSslb9MK/gYDpIgbPTkOPzho12CDtwV7WtYgnZoIOsbX6sMr5qTVNX64v/51WxysoxIVrTrvCnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxFOmV5pALtDGGfG0w7QflQJ6me2CkE3fXa7RvIxY/U=;
 b=Kqg79mtxQJnpY81XovYnJJrVMduNt4QUB98PWiU1NxPO5ZPBMGzLUQNnCHQyd9w5z8AGlqWLFIvz5SBaRUsSpVfEQAEGUA20GBbBVaFH3EnxpJjuxerOTVCcoY8N3dND6GG/H4SBSVtDlGDMJNvkGfXlZlqeL0jrE4H3M+wWGJ9S2lirdC8HdGwiNopJyENu9SvwnHWcWjSXv0t6ZehNyP6lHpNa4onVapapigVKKAF27goGlRF8yulw5sBagNracbxFG1M5tnvdoPfXwEcZOYK7G7lIJM/L40c4DHqAoP8QmxuxiPbTtQ31cnK4LC5sqKG7hafHPwYMa1/8VrKZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxFOmV5pALtDGGfG0w7QflQJ6me2CkE3fXa7RvIxY/U=;
 b=F0hR73hDnc7FqpG7z4eIgCosEKTksMgSUNaSXMX11EnlobuMq7ZSHG0FC40fCBQeKA/3zu+9WOnVeJ4cGmbXifxot66vD7ycMPeLfp5WMv0Xp9j7IeBKMbBMWcl2rwmtGsqGgGCWBK5Ge+sFded+Kl0Z3xTT25F1TNAeRlDyWYQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 1 Sep
 2020 08:51:31 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 08:51:31 +0000
Subject: Re: [PATCH v2] drm/amdgpu: block ring buffer access during GPU
 recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com
References: <20200901075029.23502-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3af1dbc6-2b81-ec5a-b457-96b06a5e05c9@amd.com>
Date: Tue, 1 Sep 2020 10:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200901075029.23502-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::46) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR01CA0105.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 08:51:30 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8414be8-bc1f-47a2-307e-08d84e5438f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2385253997C7E103F516692A832E0@BL0PR12MB2385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/+2Jxn2n67bVJ4qm5qaYejvv6RrYVCdKcCvRXY/hwRJAzA5rqb176FKC35FWwfRKnqHiN+NHGLXm6Xlw9sPKgyIs+NOWe3p5sDz8JTSwv/+WQJIUqDJVPoawjlu3tDLLdqUYFntq6lo4MoMUvsUbpTidOHufrZG0XctVB4YATAqILkeREjdOdiSXBnsTbR+bL9U02Mdb3XFAW2wGPY0MtVD8pVIMo7gIu+zdxlxOrWuNiiJAYW+HiWEvnp2Sw8lvY1ll888FOt54/s4apBMwce9eCHOLhf9OzIo6+0ERtk2FHV1qpfaF21nHnijgChMgiOB8L8vQeyr1U14hF4Fe+fjXPcqabKyzb5zndC3oGWVpJB9IKUpVnt6XhPZCC18
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(86362001)(36756003)(66946007)(66476007)(6666004)(83380400001)(66574015)(5660300002)(66556008)(6636002)(956004)(478600001)(31696002)(2616005)(8676002)(52116002)(8936002)(2906002)(31686004)(186003)(316002)(16576012)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: suufN3W0EvFHGbmvCBJAgWRWAM/Ie+svcinXzJvvt2czlRkyP9qOwwYZS6W2GB8+xwCeMYL3fhSmE0Mbxtq5MNoZFGhJRe0DrAXHo0IRUsCQbYGzv/3BaqW9UoZm6BFfr0+k061Bc1dDvdNfERlfedvkCifyvB448MxwBlAPnG9rMf2j28AUuMi/LnukeejLbBuR9RTXKXB0nHly2FMlynW0ATgFJqDqXmg3QGT3Z+86N2I7/F/UT4Nd003xyHOi3AkyJr37jqKWnRC7iaRNDYZ2BF6/r6kmnfA7wC6yUx79rVvDdNj2UvYQADq6LftERIvnBzZcm3hrAPlS0x+2V4Xqh0jn3zdXDbKyMPdYKpK+DnJtPXtetuKZY0TZoT1fFWFxXZdhsMqLbKCuCTGPfGtN0yb8XmxVYE72HHlFPGIZXxfj+8Ni+LCxro6IqRdJGTZ9o/CxFQ+YmY/SKJZcqtRGznze79oiInjfEq022jiQztp6rouz5xIDSXZ56cCkB6gBinaXrq/JEAZU46XOgRkW5Ufc+WS54nPdv76EijFZV9oIWDy+j0xI6AWXonALzpYBj+h1kjUzrtbFE/4OmF/q+cyjhvwcVUh2AsoV8HClNpQ39Qro60t+hl0CesXVYAFGf5VUcw2yUsfcwDfQb2LYFI83v45HMwiJjV1h/A0sS6yJEYMvqxcp1Jv/Zy3RVJ190Vo3CKHIfZVmub7phA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8414be8-bc1f-47a2-307e-08d84e5438f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 08:51:31.4928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG4M7HYaWvG7rmPLzt5N2qNUaOGYZ+wX9rG0JjDnU9ithjn00pbNS6qkXQFrNVf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
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

QW0gMDEuMDkuMjAgdW0gMDk6NTAgc2NocmllYiBEZW5uaXMgTGk6Cj4gV2hlbiBHUFUgaXMgaW4g
cmVzZXQsIGl0cyBzdGF0dXMgaXNuJ3Qgc3RhYmxlIGFuZCByaW5nIGJ1ZmZlciBhbHNvIG5lZWQK
PiBiZSByZXNldCB3aGVuIHJlc3VtaW5nLiBUaGVyZWZvcmUgZHJpdmVyIHNob3VsZCBwcm90ZWN0
IEdQVSByZWNvdmVyeQo+IHRocmVhZCBmcm9tIHJpbmcgYnVmZmVyIGFjY2Vzc2VkIGJ5IG90aGVy
IHRocmVhZHMuIE90aGVyd2lzZSBHUFUgd2lsbAo+IHJhbmRvbWx5IGhhbmcgZHVyaW5nIHJlY292
ZXJ5Lgo+Cj4gdjI6IGNvcnJlY3QgaW5kZW50Cj4KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgTGkg
PERlbm5pcy5MaUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4gaW5kZXggMTcyZGM0N2I3ZjM5Li45YjU4NmJjODBjMzggMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTMxOSw4ICsz
MTksMTIgQEAgdWludDMyX3QgYW1kZ3B1X21tX3JyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHVpbnQzMl90IHJlZywKPiAgIHsKPiAgIAl1aW50MzJfdCByZXQ7Cj4gICAKPiAtCWlmICgh
KGFjY19mbGFncyAmIEFNREdQVV9SRUdTX05PX0tJUSkgJiYgYW1kZ3B1X3NyaW92X3J1bnRpbWUo
YWRldikpCj4gLQkJcmV0dXJuIGFtZGdwdV9raXFfcnJlZyhhZGV2LCByZWcpOwo+ICsJaWYgKCEo
YWNjX2ZsYWdzICYgQU1ER1BVX1JFR1NfTk9fS0lRKSAmJiBhbWRncHVfc3Jpb3ZfcnVudGltZShh
ZGV2KSAmJgo+ICsJICAgIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9zZW0pKSB7Cj4g
KwkJcmV0ID0gYW1kZ3B1X2tpcV9ycmVnKGFkZXYsIHJlZyk7Cj4gKwkJdXBfcmVhZCgmYWRldi0+
cmVzZXRfc2VtKTsKPiArCQlyZXR1cm4gcmV0Owo+ICsJfQo+ICAgCj4gICAJaWYgKChyZWcgKiA0
KSA8IGFkZXYtPnJtbWlvX3NpemUpCj4gICAJCXJldCA9IHJlYWRsKCgodm9pZCBfX2lvbWVtICop
YWRldi0+cm1taW8pICsgKHJlZyAqIDQpKTsKPiBAQCAtMzMyLDYgKzMzNiw3IEBAIHVpbnQzMl90
IGFtZGdwdV9tbV9ycmVnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcs
Cj4gICAJCXJldCA9IHJlYWRsKCgodm9pZCBfX2lvbWVtICopYWRldi0+cm1taW8pICsgKG1tTU1f
REFUQSAqIDQpKTsKPiAgIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+bW1pb19pZHhf
bG9jaywgZmxhZ3MpOwo+ICAgCX0KPiArCj4gICAJdHJhY2VfYW1kZ3B1X21tX3JyZWcoYWRldi0+
cGRldi0+ZGV2aWNlLCByZWcsIHJldCk7Cj4gICAJcmV0dXJuIHJldDsKPiAgIH0KPiBAQCAtNDA3
LDggKzQxMiwxMiBAQCB2b2lkIHN0YXRpYyBpbmxpbmUgYW1kZ3B1X21tX3dyZWdfbW1pbyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLAo+ICAgdm9pZCBhbWRncHVfbW1f
d3JlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2
LAo+ICAgCQkgICAgdWludDMyX3QgYWNjX2ZsYWdzKQo+ICAgewo+IC0JaWYgKCEoYWNjX2ZsYWdz
ICYgQU1ER1BVX1JFR1NfTk9fS0lRKSAmJiBhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSkKPiAt
CQlyZXR1cm4gYW1kZ3B1X2tpcV93cmVnKGFkZXYsIHJlZywgdik7Cj4gKwlpZiAoIShhY2NfZmxh
Z3MgJiBBTURHUFVfUkVHU19OT19LSVEpICYmIGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpICYm
Cj4gKwkgICAgZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X3NlbSkpIHsKPiArCQlhbWRn
cHVfa2lxX3dyZWcoYWRldiwgcmVnLCB2KTsKPiArCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9zZW0p
Owo+ICsJCXJldHVybjsKPiArCX0KPiAgIAo+ICAgCWFtZGdwdV9tbV93cmVnX21taW8oYWRldiwg
cmVnLCB2LCBhY2NfZmxhZ3MpOwo+ICAgfQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTBfMC5jCj4gaW5kZXggYWQ5YWQ2MjJjY2NlLi4zMTM1OWU1MTlkNjkgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IEBAIC0yODcsOCArMjg3LDcgQEAgc3RhdGlj
IHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVpbnQzMl90IHZtaWQsCj4gICAJICovCj4gICAJaWYgKGFkZXYtPmdmeC5raXEucmluZy5zY2hl
ZC5yZWFkeSAmJgo+ICAgCSAgICAoYW1kZ3B1X3NyaW92X3J1bnRpbWUoYWRldikgfHwgIWFtZGdw
dV9zcmlvdl92ZihhZGV2KSkgJiYKPiAtCSAgICAhYW1kZ3B1X2luX3Jlc2V0KGFkZXYpKSB7Cj4g
LQo+ICsJICAgIGRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9zZW0pKSB7Cj4gICAJCXN0
cnVjdCBhbWRncHVfdm1odWIgKmh1YiA9ICZhZGV2LT52bWh1Ylt2bWh1Yl07Cj4gICAJCWNvbnN0
IHVuc2lnbmVkIGVuZyA9IDE3Owo+ICAgCQl1MzIgaW52X3JlcSA9IGh1Yi0+dm1odWJfZnVuY3Mt
PmdldF9pbnZhbGlkYXRlX3JlcSh2bWlkLCBmbHVzaF90eXBlKTsKPiBAQCAtMjk3LDYgKzI5Niw4
IEBAIHN0YXRpYyB2b2lkIGdtY192MTBfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgCj4gICAJCWFtZGdwdV92aXJ0X2tpcV9yZWdf
d3JpdGVfcmVnX3dhaXQoYWRldiwgcmVxLCBhY2ssIGludl9yZXEsCj4gICAJCQkJMSA8PCB2bWlk
KTsKPiArCj4gKwkJdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKPiAgIAkJcmV0dXJuOwo+ICAg
CX0KPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IGluZGV4IGUxYTBh
ZTMyN2NmNS4uYzYwMmRkYzY4Mzg0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djlfMC5jCj4gQEAgLTUwMCwxMyArNTAwLDE0IEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNo
X2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICAJ
ICogYXMgR0ZYT0ZGIHVuZGVyIGJhcmUgbWV0YWwKPiAgIAkgKi8KPiAgIAlpZiAoYWRldi0+Z2Z4
LmtpcS5yaW5nLnNjaGVkLnJlYWR5ICYmCj4gLQkJCShhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2
KSB8fCAhYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSAmJgo+IC0JCQkhYW1kZ3B1X2luX3Jlc2V0KGFk
ZXYpKSB7Cj4gKwkgICAgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpIHx8ICFhbWRncHVfc3Jp
b3ZfdmYoYWRldikpICYmCj4gKwkgICAgZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X3Nl
bSkpIHsKPiAgIAkJdWludDMyX3QgcmVxID0gaHViLT52bV9pbnZfZW5nMF9yZXEgKyBodWItPmVu
Z19kaXN0YW5jZSAqIGVuZzsKPiAgIAkJdWludDMyX3QgYWNrID0gaHViLT52bV9pbnZfZW5nMF9h
Y2sgKyBodWItPmVuZ19kaXN0YW5jZSAqIGVuZzsKPiAgIAo+ICAgCQlhbWRncHVfdmlydF9raXFf
cmVnX3dyaXRlX3JlZ193YWl0KGFkZXYsIHJlcSwgYWNrLCBpbnZfcmVxLAo+ICAgCQkJCQkJICAg
MSA8PCB2bWlkKTsKPiArCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9zZW0pOwo+ICAgCQlyZXR1cm47
Cj4gICAJfQo+ICAgCj4gQEAgLTU5OSw3ICs2MDAsNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX2Zs
dXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJaWYgKGFt
ZGdwdV9pbl9yZXNldChhZGV2KSkKPiAgIAkJcmV0dXJuIC1FSU87Cj4gICAKPiAtCWlmIChyaW5n
LT5zY2hlZC5yZWFkeSkgewo+ICsJaWYgKHJpbmctPnNjaGVkLnJlYWR5ICYmIGRvd25fcmVhZF90
cnlsb2NrKCZhZGV2LT5yZXNldF9zZW0pKSB7Cj4gICAJCS8qIFZlZ2EyMCtYR01JIGNhY2hlcyBQ
VEVzIGluIFRDIGFuZCBUTEIuIEFkZCBhCj4gICAJCSAqIGhlYXZ5LXdlaWdodCBUTEIgZmx1c2gg
KHR5cGUgMiksIHdoaWNoIGZsdXNoZXMKPiAgIAkJICogYm90aC4gRHVlIHRvIGEgcmFjZSBjb25k
aXRpb24gd2l0aCBjb25jdXJyZW50Cj4gQEAgLTYyNiw2ICs2MjcsNyBAQCBzdGF0aWMgaW50IGdt
Y192OV8wX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4g
ICAJCWlmIChyKSB7Cj4gICAJCQlhbWRncHVfcmluZ191bmRvKHJpbmcpOwo+ICAgCQkJc3Bpbl91
bmxvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsKPiArCQkJdXBfcmVhZCgmYWRldi0+cmVz
ZXRfc2VtKTsKPiAgIAkJCXJldHVybiAtRVRJTUU7Cj4gICAJCX0KPiAgIAo+IEBAIC02MzQsOSAr
NjM2LDEwIEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmco
cmluZywgc2VxLCBhZGV2LT51c2VjX3RpbWVvdXQpOwo+ICAgCQlpZiAociA8IDEpIHsKPiAgIAkJ
CWRldl9lcnIoYWRldi0+ZGV2LCAid2FpdCBmb3Iga2lxIGZlbmNlIGVycm9yOiAlbGQuXG4iLCBy
KTsKPiArCQkJdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKPiAgIAkJCXJldHVybiAtRVRJTUU7
Cj4gICAJCX0KPiAtCj4gKwkJdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKPiAgIAkJcmV0dXJu
IDA7Cj4gICAJfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
