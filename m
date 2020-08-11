Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0299DC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1EC204FD
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="axSgx2n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1EC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C18F6E512;
	Tue, 11 Aug 2020 13:57:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400EC6E525
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 13:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfRp5kQh9616/oYY6QDhGlI5Pns5Sa8/LFfvW27wthpUySeRwSKMVnJBdUZwqMwbjvJZMxYuhgwsnN/wqQRD9bZKyKu67MJL5Jd4d2hnfMxhn/TipGQPOcSaVS9N68/z7uWw/EC1QL6zJhF7vNO8WsY26jJgiARF2L0P+r2G4z9LfiVW/Sk2STSv3MgrP5uAmBVKmbqrvZ8wjxqN2TUeyCcMBLt2GCkwMOFlMdfazi0J291YpEVmRkkUXTJ662yvjLaAffrJnqRZEHryPji0J0j6gD3dSxIHZh+vWmWt5JW+yqFDcFkkcPyu5KgjB9WLNVg0WBimOzjhIPOqsPMdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeC2ExLQwdR0GPPN+Q2C6d5mYWPVmrGkdwV+6lwPgsY=;
 b=d7ovAOWiyCsn9pXGBH6ue3I4YpcygLraZbilH/C2k5wacxFj3wOlGeBsQRUAdCemjh0OPmYwNNAglEOUUnUoBBF2TvcIBM5/FVOx7RT4fFDSmT/r4CK1dRBNJncBDS3f83Vf5mMPGBYxzNp3wDhF6Of3t5QKy3RJ/jfMx/GnBXPYY9JpcxeygOCNtoWB6/43wqXP/2VX0NIwqqDHfRjmXJWwXejn2hHSIz4rfaHKa8sWmLrnRequoGtfmQGYsOKv+MtRWLaDbMqRkBEEi3cLu9MF6XvM+ULSSlfRPt/gwrMLSwqq4dzgkdH4qxQiReYnqRR0jf4T6X+G+lrQsMf4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeC2ExLQwdR0GPPN+Q2C6d5mYWPVmrGkdwV+6lwPgsY=;
 b=axSgx2n4P4okYKg1guws11dAbMKmCnJ06JGixPu0AtH6tCnGoSQraCHN1Gma4CwUEkXvMLQOsX0JwIyUikc4hqlNLBvPMCRXuNHcnXkvyuPq/j1ilDa+JgKrc3DYGKzrcJ89VbNPNYvbO6hwN6AMVd8Bo7gGQYMaWPbnp0W/NMo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Tue, 11 Aug 2020 13:57:16 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5%7]) with mapi id 15.20.3283.015; Tue, 11 Aug 2020
 13:57:16 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a potential circular locking dependency
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, christian.koenig@amd.com
References: <20200811093208.13149-1-Dennis.Li@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <baafa5b8-018a-f704-d5be-89b8a24f6082@amd.com>
Date: Tue, 11 Aug 2020 09:57:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200811093208.13149-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Tue, 11 Aug 2020 13:57:16 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e54c86ab-63c3-4d13-1cea-08d83dfe74c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45641D3F3C127BA2ADDD2B1592450@DM6PR12MB4564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOH7M0eo3MlFYatAf3DCCxihw/JdurzXn7Jj2g3ImCQFLmbY5aPFZpT9Z01+Zn8sul5RkV+AbHq8z82h4bn5eq+sYYIIgSJIR/jFK5oNGZO57TCrYdGvQ4UR1J0TiRbjx2XKtY0kqHJXYAa6dwXmp9h2hctA9m4nhW1a1jgUkdbieKG/yx5MSg3WRYEfnlVp5Xp8RhbGhhdsjne87KaPPFtj6ByAl3woSW9gcKCDW2BU593qNp2uMYxeWohA/MGvqC1qxw+LDxTKYPOsKe3A+cA4Ec39NyYP+zOkYS36tCRxn7WzuXJQrz55ECVo0/8nJ5qJO28yR/3wiaI0CeWWiFf6uvefeBDkigFuXJlshExbHVhSXjpVVjrC0ORYW72y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(316002)(2616005)(66946007)(956004)(16576012)(83380400001)(478600001)(36756003)(2906002)(186003)(6636002)(44832011)(5660300002)(8676002)(6486002)(26005)(8936002)(31686004)(66556008)(66476007)(31696002)(86362001)(16526019)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IcOjBvUuC+0b0SlIRGuZ0g9GRxmd6LXggFwGX2umaXh5RXMj7xukToI8nPo2wCJOCuje6ZKi2E8uZNVysM9t1ZpPLtM/FwxLM2yy8TYzC2GQaU6vpR2rd2bcxoPN8qeB6oFfqj+QROWHiKvcldmK8HHYU6GuwXWTIlsbH++76RN0iOYmj29wOTTFLlm2KeXT8E4pHpaRd2+orCDNkCxmMXVyVejM2kXPu5PSaOYutNQAXLI77G/2TAkERSD3eTQKQc7YATvM7Sw7ucLhGxQzD43tfLOUsFL7bvDB7Jnj4xidYF34n48qdXMknzK75Fwe/rrfODHft75mN+I5/ulfA9y0rcAOULFUoPBQcPigwBcjRtIK7yao5pp5lk+rzWUHSBGaBOkwfODWxhC9kxItVftEvUNNmh1WFt8K68oLhFeytKWr/wZpSUADVp7BW+idUOqMPAhJeRg0UZdN96SlxRhilc/xy1R/4dQm31QWiSF4c+zsRWfDEyjV5JsrdTFfKEoYln7JAhrqgySi18H00vxqZnAR55DS4aViZN5iH904Z+8ZxZK1EarWoTuv0BP89ZZcHfyc0OrCMVG0cmMFGXc+ihWWPcmRZrgyaPh07iWt4RlO0wBngxa7AihjYVD9sjtxZrpkl81ROGkcIl8/Ug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c86ab-63c3-4d13-1cea-08d83dfe74c8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 13:57:16.4363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cQgnqbgCYJndGp5CDQqpR/B261ZOJM7eZOxRfAgXy/FlCHaLWWlBqsWpVq9dgjg0yPGebj9c41/6KzrCsJbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
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

QW0gMjAyMC0wOC0xMSB1bSA1OjMyIGEubS4gc2NocmllYiBEZW5uaXMgTGk6Cj4gWyAgNjUzLjkw
MjMwNV0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cj4gWyAgNjUzLjkwMjkyOF0gV0FSTklORzogcG9zc2libGUgY2lyY3VsYXIgbG9ja2luZyBk
ZXBlbmRlbmN5IGRldGVjdGVkCj4gWyAgNjUzLjkwMzUxN10gNS42LjAtZGVsaS12NS42LTI4NDgt
ZzNmMzEwOWIwZTc1ZiAjMSBUYWludGVkOiBHICAgICAgICAgICBPRQo+IFsgIDY1My45MDQwOThd
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
IFsgIDY1My45MDQ2NzVdIGFtZGdwdV90ZXN0LzM5NzUgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9j
azoKPiBbICA2NTMuOTA1MjQxXSBmZmZmOTc4NDhmODY0N2EwICgmYWRldi0+cmVzZXRfc2VtKXsu
Ky4rfSwgYXQ6IGFtZGdwdV9nZW1fdmFfaW9jdGwrMHgyODYvMHg0ZjAgW2FtZGdwdV0KPiBbICA2
NTMuOTA1OTUzXQo+ICAgICAgICAgICAgICAgIGJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBs
b2NrOgo+IFsgIDY1My45MDcwODddIGZmZmY5NzQ0YWRiZWUxZjggKHJlc2VydmF0aW9uX3d3X2Ns
YXNzX211dGV4KXsrLisufSwgYXQ6IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMrMHgxYWUvMHg1MjAg
W3R0bV0KPiBbICA2NTMuOTA3Njk0XQo+ICAgICAgICAgICAgICAgIHdoaWNoIGxvY2sgYWxyZWFk
eSBkZXBlbmRzIG9uIHRoZSBuZXcgbG9jay4KPgo+IFsgIDY1My45MDk0MjNdCj4gICAgICAgICAg
ICAgICAgdGhlIGV4aXN0aW5nIGRlcGVuZGVuY3kgY2hhaW4gKGluIHJldmVyc2Ugb3JkZXIpIGlz
Ogo+IFsgIDY1My45MTA1OTRdCj4gICAgICAgICAgICAgICAgLT4gIzEgKHJlc2VydmF0aW9uX3d3
X2NsYXNzX211dGV4KXsrLisufToKPiBbICA2NTMuOTExNzU5XSAgICAgICAgX193d19tdXRleF9s
b2NrLmNvbnN0cHJvcC4xNSsweGNhLzB4MTEyMAo+IFsgIDY1My45MTIzNTBdICAgICAgICB3d19t
dXRleF9sb2NrKzB4NzMvMHg4MAo+IFsgIDY1My45MTMwNDRdICAgICAgICBhbWRncHVfYW1ka2Zk
X2FsbG9jX2d0dF9tZW0rMHhkZS8weDM4MCBbYW1kZ3B1XQo+IFsgIDY1My45MTM3MjRdICAgICAg
ICBrZ2Qya2ZkX2RldmljZV9pbml0KzB4MTNmLzB4NWUwIFthbWRncHVdCj4gWyAgNjUzLjkxNDM4
OF0gICAgICAgIGFtZGdwdV9hbWRrZmRfZGV2aWNlX2luaXQrMHgxNTUvMHgxOTAgW2FtZGdwdV0K
PiBbICA2NTMuOTE1MDMzXSAgICAgICAgYW1kZ3B1X2RldmljZV9pbml0KzB4MTMwMy8weDFlMTAg
W2FtZGdwdV0KPiBbICA2NTMuOTE1Njg1XSAgICAgICAgYW1kZ3B1X2RyaXZlcl9sb2FkX2ttcysw
eDVjLzB4MmMwIFthbWRncHVdCj4gWyAgNjUzLjkxNjM0OV0gICAgICAgIGFtZGdwdV9wY2lfcHJv
YmUrMHgxMWQvMHgyMDAgW2FtZGdwdV0KPiBbICA2NTMuOTE2OTU5XSAgICAgICAgbG9jYWxfcGNp
X3Byb2JlKzB4NDcvMHhhMAo+IFsgIDY1My45MTc1NzBdICAgICAgICB3b3JrX2Zvcl9jcHVfZm4r
MHgxYS8weDMwCj4gWyAgNjUzLjkxODE4NF0gICAgICAgIHByb2Nlc3Nfb25lX3dvcmsrMHgyOWUv
MHg2MzAKPiBbICA2NTMuOTE4ODAzXSAgICAgICAgd29ya2VyX3RocmVhZCsweDIyYi8weDNmMAo+
IFsgIDY1My45MTk0MjddICAgICAgICBrdGhyZWFkKzB4MTJmLzB4MTUwCj4gWyAgNjUzLjkyMDA0
N10gICAgICAgIHJldF9mcm9tX2ZvcmsrMHgzYS8weDUwCj4gWyAgNjUzLjkyMDY2MV0KPiAgICAg
ICAgICAgICAgICAtPiAjMCAoJmFkZXYtPnJlc2V0X3NlbSl7LisuK306Cj4gWyAgNjUzLjkyMTg5
M10gICAgICAgIF9fbG9ja19hY3F1aXJlKzB4MTNlYy8weDE2ZTAKPiBbICA2NTMuOTIyNTMxXSAg
ICAgICAgbG9ja19hY3F1aXJlKzB4YjgvMHgxYzAKPiBbICA2NTMuOTIzMTc0XSAgICAgICAgZG93
bl9yZWFkKzB4NDgvMHgyMzAKPiBbICA2NTMuOTIzODg2XSAgICAgICAgYW1kZ3B1X2dlbV92YV9p
b2N0bCsweDI4Ni8weDRmMCBbYW1kZ3B1XQo+IFsgIDY1My45MjQ1ODhdICAgICAgICBkcm1faW9j
dGxfa2VybmVsKzB4YjYvMHgxMDAgW2RybV0KPiBbICA2NTMuOTI1MjgzXSAgICAgICAgZHJtX2lv
Y3RsKzB4Mzg5LzB4NDUwIFtkcm1dCj4gWyAgNjUzLjkyNjAxM10gICAgICAgIGFtZGdwdV9kcm1f
aW9jdGwrMHg0Zi8weDgwIFthbWRncHVdCj4gWyAgNjUzLjkyNjY4Nl0gICAgICAgIGtzeXNfaW9j
dGwrMHg5OC8weGIwCj4gWyAgNjUzLjkyNzM1N10gICAgICAgIF9feDY0X3N5c19pb2N0bCsweDFh
LzB4MjAKPiBbICA2NTMuOTI4MDMwXSAgICAgICAgZG9fc3lzY2FsbF82NCsweDVmLzB4MjUwCj4g
WyAgNjUzLjkyODY5N10gICAgICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ5
LzB4YmUKPiBbICA2NTMuOTI5MzczXQo+ICAgICAgICAgICAgICAgIG90aGVyIGluZm8gdGhhdCBt
aWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6Cj4KPiBbICA2NTMuOTMxMzU2XSAgUG9zc2libGUgdW5z
YWZlIGxvY2tpbmcgc2NlbmFyaW86Cj4KPiBbICA2NTMuOTMyNjQ3XSAgICAgICAgQ1BVMCAgICAg
ICAgICAgICAgICAgICAgQ1BVMQo+IFsgIDY1My45MzMyODddICAgICAgICAtLS0tICAgICAgICAg
ICAgICAgICAgICAtLS0tCj4gWyAgNjUzLjkzMzkxMV0gICBsb2NrKHJlc2VydmF0aW9uX3d3X2Ns
YXNzX211dGV4KTsKPiBbICA2NTMuOTM0NTMwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbG9jaygmYWRldi0+cmVzZXRfc2VtKTsKPiBbICA2NTMuOTM1MTU0XSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbG9jayhyZXNlcnZhdGlvbl93d19jbGFzc19tdXRleCk7Cj4gWyAg
NjUzLjkzNTc2Nl0gICBsb2NrKCZhZGV2LT5yZXNldF9zZW0pOwo+IFsgIDY1My45MzYzNjBdCj4g
ICAgICAgICAgICAgICAgICoqKiBERUFETE9DSyAqKioKPgo+IFsgIDY1My45MzgwMjhdIDIgbG9j
a3MgaGVsZCBieSBhbWRncHVfdGVzdC8zOTc1Ogo+IFsgIDY1My45Mzg1NzRdICAjMDogZmZmZmIy
YTg2MmQ2YmNkMCAocmVzZXJ2YXRpb25fd3dfY2xhc3NfYWNxdWlyZSl7Ky4rLn0sIGF0OiBhbWRn
cHVfZ2VtX3ZhX2lvY3RsKzB4MzliLzB4NGYwIFthbWRncHVdCj4gWyAgNjUzLjkzOTIzM10gICMx
OiBmZmZmOTc0NGFkYmVlMWY4IChyZXNlcnZhdGlvbl93d19jbGFzc19tdXRleCl7Ky4rLn0sIGF0
OiB0dG1fZXVfcmVzZXJ2ZV9idWZmZXJzKzB4MWFlLzB4NTIwIFt0dG1dCj4KPiBjaGFuZ2UgdGhl
IG9yZGVyIG9mIHJlc2VydmF0aW9uX3d3X2NsYXNzX211dGV4IGFuZCBhZGV2LT5yZXNldF9zZW0g
aW4KPiBhbWRncHVfZ2VtX3ZhX2lvY3RsIHRoZSBzYW1lIGFzIG9uZXMgaW4gYW1kZ3B1X2FtZGtm
ZF9hbGxvY19ndHRfbWVtLCB0bwo+IGF2b2lkIHBvdGVudGlhbCBkZWFkIGxvY2suCgpJdCBtYXkg
YmUgYmV0dGVyIHRvIGZpeCBpdCB0aGUgb3RoZXIgd2F5IGFyb3VuZCBpbgphbWRncHVfYW1ka2Zk
X2FsbG9jX2d0dF9tZW0uIEFsd2F5cyB0YWtlIHRoZSByZXNldF9zZW0gaW5zaWRlIHRoZQpyZXNl
cnZhdGlvbi4gT3RoZXJ3aXNlIHlvdSB3aWxsIG5ldmVyIGJlIGFibGUgdG8gdGFrZSB0aGUgcmVz
ZXRfc2VtCndoaWxlIGFueSBCT3MgYXJlIHJlc2VydmVkLiBUaGF0J3MgcHJvYmFibHkgZ29pbmcg
dG8gY2F1c2UgeW91IG90aGVyCnByb2JsZW1zIGxhdGVyLgoKVGhhdCBtYWtlcyBtZSB3b25kZXIs
IHdoeSBkbyB5b3UgbmVlZCB0aGUgcmVzZXRfc2VtIGluCmFtZGdwdV9hbWRrZmRfYWxsb2NfZ3R0
X21lbSBpbiB0aGUgZmlyc3QgcGxhY2U/IFRoZXJlIGlzIG5vIG9idmlvdXMKaGFyZHdhcmUgYWNj
ZXNzIGluIHRoYXQgZnVuY3Rpb24uIElzIGl0IGZvciBhbWRncHVfdHRtX2FsbG9jX2dhcnQKdXBk
YXRpbmcgdGhlIEdBUlQgdGFibGUgdGhyb3VnaCBIRFA/CgpSZWdhcmRzLArCoCBGZWxpeAoKCj4K
PiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPgo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4IGVlMWU4ZmZmODNiMi4uZmM4
ODljNDc3Njk2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+
IEBAIC02NTIsNiArNjUyLDggQEAgaW50IGFtZGdwdV9nZW1fdmFfaW9jdGwoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiAgCQlhYm8gPSBOVUxMOwo+ICAJfQo+ICAKPiArCWRv
d25fcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKPiArCj4gIAlhbWRncHVfdm1fZ2V0X3BkX2JvKCZm
cHJpdi0+dm0sICZsaXN0LCAmdm1fcGQpOwo+ICAKPiAgCXIgPSB0dG1fZXVfcmVzZXJ2ZV9idWZm
ZXJzKCZ0aWNrZXQsICZsaXN0LCB0cnVlLCAmZHVwbGljYXRlcyk7Cj4gQEAgLTY3MCw4ICs2NzIs
NiBAQCBpbnQgYW1kZ3B1X2dlbV92YV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lk
ICpkYXRhLAo+ICAJCWJvX3ZhID0gTlVMTDsKPiAgCX0KPiAgCj4gLQlkb3duX3JlYWQoJmFkZXYt
PnJlc2V0X3NlbSk7Cj4gLQo+ICAJc3dpdGNoIChhcmdzLT5vcGVyYXRpb24pIHsKPiAgCWNhc2Ug
QU1ER1BVX1ZBX09QX01BUDoKPiAgCQl2YV9mbGFncyA9IGFtZGdwdV9nZW1fdmFfbWFwX2ZsYWdz
KGFkZXYsIGFyZ3MtPmZsYWdzKTsKPiBAQCAtNzAxLDEyICs3MDEsMTEgQEAgaW50IGFtZGdwdV9n
ZW1fdmFfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiAgCQlhbWRn
cHVfZ2VtX3ZhX3VwZGF0ZV92bShhZGV2LCAmZnByaXYtPnZtLCBib192YSwKPiAgCQkJCQlhcmdz
LT5vcGVyYXRpb24pOwo+ICAKPiAtCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7Cj4gLQo+ICBl
cnJvcl9iYWNrb2ZmOgo+ICAJdHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxp
c3QpOwo+ICAKPiAgZXJyb3JfdW5yZWY6Cj4gKwl1cF9yZWFkKCZhZGV2LT5yZXNldF9zZW0pOwo+
ICAJZHJtX2dlbV9vYmplY3RfcHV0X3VubG9ja2VkKGdvYmopOwo+ICAJcmV0dXJuIHI7Cj4gIH0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
