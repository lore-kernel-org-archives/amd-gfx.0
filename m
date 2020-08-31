Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A34C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 11:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8DD20866
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 11:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3QUF9zyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8DD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373DB6E122;
	Mon, 31 Aug 2020 11:40:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885DB6E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 11:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPngevn29mVSsSz8RXo8SOo7A6y7M9Crk1OZqNROcBjdOkEhiQ5ZtIfbKAybgZwlqsKZToH2fmY9cZTCz17+bc8ejQhEOKDBBaMrhKSX5CA2hatGKVYRdz0vnanXb6TgsKbQtteJFePdW5+aHBjkzxTVYd/J8Ry+s3nF4x8StoijxdiH1QFUAxzeDRZtlyuOqYVx5wL5mfukOM0C3rAXJ78uY56C+zlwg8Xh9mf6Qe3tcwiX4Mw6tWxWAEyI0gHhO/7KRGlMPGaHNgkZwu5053+rFVNhWAR3cZcQvI/iTY4M3sr46pgOfc2CjMn9ufmasN/mUF0KBUVPvRyCLbJL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLJMeOr2LrMayApaNxHUN5W686hl9nUqPbFSLmKLmDY=;
 b=mSluwMOAVjDBSdW5GQ5W/jZbO1Fg3jEE0gezBsBWsc4vNIphY4qmTwOPIfhyfstsE0oUEQkxnJ2thCkjQE5ihQADWRa3NERGPdLuNpwksISTD401NOS7btX9AC+/eki7OdkghTgf4pXaNh3spjBsiTmWJWY6u6dc6aDv84Zx3KYYunTryPCoHujygUCdaqED11fdFuil+P0Oc3DBey1Ci/Oaqkjmzk1whUa/OC0DBu9g2tEFiABDNnTAeZ3zSWXs04dInLrWSiy3Lb7hedFEnJyqHzIsb2309B8R08fVYGM8yNwFhmiErBA8jgwPJuDuGGwsGidnDytdG5FUJmweVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLJMeOr2LrMayApaNxHUN5W686hl9nUqPbFSLmKLmDY=;
 b=3QUF9zypBoxAfWLamXLFWRznIm5W5b0S7+5/gujpYWt1lugD834dy1o9lLNt9iQkaLy984GhHv4nTQp90JrVQeBezpkWtsxDp/02xdapPoLhmQy0I2YKyn9AYWwllfk5nfGmZWunF0TinGYIN694ZkGyQzkWRVG+2hyJ8HgkxBs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 11:39:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 11:39:56 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200831104553.10207-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5c0c59a1-1daf-cd51-680a-cd1762eb40fa@amd.com>
Date: Mon, 31 Aug 2020 13:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200831104553.10207-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR01CA0166.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 11:39:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16107c25-89f5-4a4e-1f93-08d84da2959d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39675EA6C3AAD158FF6143A683510@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2b1StRVY8jYpBDWN8C8UcOWB2r0fLjtX2EADSgBnfyIkuLLc5FlerTokpinE2yjJzgJQ+ZbF55QxwvNn7PkH6dZkiTs/IaLilBtIQ87bZTaXksebUCND0vgNtRblNEEjDzuIASEq923eHVhcuC64DAi3ee/1YBlLLlfYdR8Py6kIxhVULe1uG8YOz1aHjXRgGffQgtgTUQAIy4XSpZPz8zD1ZbhS9LSjcQmVyJFQMNfVnZCF5abEwvOxUQk0hRVZuNE/grFTGim25iwkCXmXPUiuOvoHzfZnhWemIk26OsLvjOopRi6Bc5dSSNgqpoVzBWLRytRE14TiXbNpfuEVAMxiuMHPCNrkJtydD6GeIboILLrRBi45TcR9g6DT0ipT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(5660300002)(8676002)(8936002)(956004)(36756003)(31686004)(2616005)(52116002)(478600001)(86362001)(6486002)(316002)(16576012)(4326008)(186003)(66556008)(66476007)(66574015)(83380400001)(31696002)(2906002)(66946007)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8mx5Z1Rqcd6b1yuQARNmVNauVy47PW3tfFtQmfSb7XM9DVKMr2VdddwefGd7trPuRFaaQECdDq9zlD83iJEPSyXX0+2OKHWBnGWAKf97EY8Vj42/2f3obLvB8xqjZ5xBs2AbfAxnVmf+jZSJH1hdbJ+f457Jid++pMbXlG+eZQ3pXab8HQeLO0n4lz0P0J8f6GvQgHr5BNUDOhNk4aPKvBO1OODgdtUUYVjdfS91ZMI1wwzObldHxzkyX530iIFeYhuGAfpjp+sKjBqEo0+g6m9pYDiyNlb6CPL+743QCbfc+cHj1yz1AGQuqVcvQqE5NDCDqHKoEfqlc6GDpt9VVBZ5sP5OjFIaCQhFUOgZ93D5lk171P6KTicDQtWc+FzbEMwK+fStpy4fXrs+d2uLqlBcNqV2YrVXfnDZ/IRWSBPoibhGEQBAgS4K20FmXJ51TjdhPKjepIiGUuKl4IzD67XT3+8SU7PQgRV9PeSXiJxWkb87Z9rVi9r4aSCbgiy/+jCsDyEqgiuD+7sn2GyPC3uq817fL11EAKVTrQ4SRNFkrTXrpIIyWy2Q7hV81d7MyegtNxb4Rd94qaTgmsClVQuDd4+egZ3bnK3kYeZfFcO8rAtXbEg4hJCGTJhTzRgN+xwcxADtrk6BHY10zyhcITdfA26inHwgZBHJRHFa95ndLf/Xev1Q1TcWchuVbKHkBIvBA0cZuDYdE8lxf+94hA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16107c25-89f5-4a4e-1f93-08d84da2959d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 11:39:56.6306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFUfmC0ZCGox3OQqEn6aGC5pOaGdbMWX6avdeGpwXtktxG7LYSFcj1loi+yU9tpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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
Cc: alexander.deucher@amd.com, Tianci.Yin@amd.com, Leo.Liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMDguMjAgdW0gMTI6NDUgc2NocmllYiBOaXJtb3kgRGFzOgo+IFVWRCBkZXBlbmRlbnQg
am9icyBzaG91bGQgcnVuIG9uIHRoZSBzYW1lIHVkdiBpbnN0YW5jZS4KPiBUaGlzIHBhdGNoIGRp
c2FibGVzIGdwdSBzY2hlZHVsZXIncyBsb2FkIGJhbGFuY2VyIGZvcgo+IGEgY29udGV4dCB3aGlj
aCBiaW5kcyBqb2JzIGZyb20gc2FtZSB0aGUgY29udGV4dCB0byBhIHVkdgo+IGluc3RhbmNlLgo+
Cj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCA0ICsrKy0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPiBpbmRleCA1OTAzMmMyNmZjODIuLjdj
ZDM5OGQyNTQ5OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMK
PiBAQCAtMTE0LDcgKzExNCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9pbml0X2VudGl0eShz
dHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4LCB1MzIgaHdfaXAsCj4gICAJc2NoZWRzID0gYWRldi0+Z3B1
X3NjaGVkW2h3X2lwXVtod19wcmlvXS5zY2hlZDsKPiAgIAludW1fc2NoZWRzID0gYWRldi0+Z3B1
X3NjaGVkW2h3X2lwXVtod19wcmlvXS5udW1fc2NoZWRzOwo+Cj4gLQlpZiAoaHdfaXAgPT0gQU1E
R1BVX0hXX0lQX1ZDTl9FTkMgfHwgaHdfaXAgPT0gQU1ER1BVX0hXX0lQX1ZDTl9ERUMpIHsKPiAr
CWlmIChod19pcCA9PSBBTURHUFVfSFdfSVBfVkNOX0VOQyB8fAo+ICsJICAgIGh3X2lwID09IEFN
REdQVV9IV19JUF9WQ05fREVDIHx8Cj4gKwkgICAgaHdfaXAgPT0gQU1ER1BVX0hXX0lQX1VWRCkg
ewo+ICAgCQlzY2hlZCA9IGRybV9zY2hlZF9waWNrX2Jlc3Qoc2NoZWRzLCBudW1fc2NoZWRzKTsK
PiAgIAkJc2NoZWRzID0gJnNjaGVkOwo+ICAgCQludW1fc2NoZWRzID0gMTsKPiAtLQo+IDIuMjgu
MAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
