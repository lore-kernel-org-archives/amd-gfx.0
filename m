Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A1C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 14:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E5321655
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 14:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y+e3L2hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E5321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 771706E199;
	Thu, 12 Dec 2019 14:38:59 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680042.outbound.protection.outlook.com [40.107.68.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA9C6E199
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 14:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alS4namLAiYLJD4GPm8/mk+Ml9uyxn1fvGN4vMeumaXEuxea+iGvnPHx6pbJdPc9UWi+V/NvhHmfPqqSAmgyEmavOIhzJaGLLHW+wTGR1QqbFTpj+Zyvq4XFkaFA9/glqibz19/0C92ayr9k64t1lKFrjE6EwUKdZiNZ+0exKsTWLSNiXyEU+wzN6ivoLwppPiSkQ8n8SBLOE07Ie4UUkQR+oy2L8gXe3+xNpW4O4JJFl8XRhObAUd94Nn7DVtUNm2uibhdByz+qgbwltScyc1BNACB1nK/PN9cfH4xAOQ4hb0l/mgVmPDn7rcsXvhEhGT4eRhC3IBebKhJAaTB+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7XuJqbuVefc7NQBtYXmU5oqQU+4ZLMdjNQNJOoq9TA=;
 b=JygpntjA71Zl7ZF8FllT5uasioEz1hJ2LT17nKbG0ABB/mHjfcvjSdsJnfm/EgJE+FSQkNYFM1PMTP/BcMjY9XOg/yii96Za4bNT2C5y2/jQqVx5k5xrjBycKjZhLQfnd+UAe3h/kntkMuVMELUbTUs8G80Afrx9g2YOqcmct25KsMs5tiv585hCWEc37gJ+gVK1Le9kWk8tfkDM6EpcSbv3v8P6K1jw59SmDtBnUWt52gD/eYnateOQ+naOJpG2YdYYLNPSc03YTSazmqEDBOBfqb0AiRMH/MAuxV6D7FbMiX9nd7ZuBUjHCqdoLvWXGboN27Nbzz9vudAaXhg+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7XuJqbuVefc7NQBtYXmU5oqQU+4ZLMdjNQNJOoq9TA=;
 b=y+e3L2hS+27ysD9TFGSTcYJo6+fwepiD0UIb3+DRMPuIq5RUrxeqAYTYAbpLwuJoLrGBFgcQ6egFV15tVgnPFMqid4JLxlGZHfq8kVoJsDM3Wh2fn6UGfRDivpNRXrLwy/ppZvKJfNXP+KanWoYRe9FnO7JuLLwzSqR3Re6HRKM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3742.namprd12.prod.outlook.com (10.255.238.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 14:38:55 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::65a4:15fa:629f:149e%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 14:38:55 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
To: christian.koenig@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
 <afc4a884-dc56-867e-580c-7845e7de2257@amd.com>
 <98ce952f-f52d-bf60-00b3-d984b7c2184d@gmail.com>
From: Philip Yang <philip.yang@amd.com>
Message-ID: <5a8ca58c-07e9-1e55-939c-7396de95317c@amd.com>
Date: Thu, 12 Dec 2019 09:38:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <98ce952f-f52d-bf60-00b3-d984b7c2184d@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f29113e4-83e3-4eea-f85c-08d77f110401
X-MS-TrafficTypeDiagnostic: MN2PR12MB3742:|MN2PR12MB3742:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37426E344FC33F53429D5F88E6550@MN2PR12MB3742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(43544003)(4001150100001)(66556008)(478600001)(86362001)(36756003)(6506007)(45080400002)(186003)(31696002)(26005)(66946007)(66476007)(53546011)(316002)(2906002)(66574012)(31686004)(44832011)(6636002)(81156014)(81166006)(8936002)(6486002)(8676002)(52116002)(2616005)(6512007)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3742;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ypiVubW9z/sxFCCgyupqT0bZr1wkBgUDQAXTD341XsKI92+IGOzMidsz50inKqb0KZCn+IIPzKx1ejVOtnHBgL9ZGj2I7qt85zlQtUQ2iPLm+rWTPfsF8CcWt/P1ICzs++jgOtpP6CLhTNt9Jn7sM2E8TmfJNw6UPlA+2lmwwroqQ/et8MfzSl3FBSZitX6dLTk9HRo3MB3PI1Ec1K3KUkqY/78TcnbcWPg9MWrY/RjLiTI700sorWrEHiGaLPRELCfFI3FDnTVcge3y1XOS2yVrpUrj9YyfEZbsAx3EcX/AN4JPaDG+t8dz7UeWIkwdKl0fH/c/Vh7y1shTZ6WIroFWp+yvbyRXDZZ2vwA8GSdtxfgWqBs37N/BkuWP3S0L7ta6Oo6dvwIjsJz1ujKb7gWtp7NcTi1pOqMXtFsu8wJqNi5+Dh4TpXxHfaoNiEuOoEhdDvs75irko1Tu/v7IyC9DCEjDFmeudfkQpPvSUU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29113e4-83e3-4eea-f85c-08d77f110401
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 14:38:55.7102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d5EsY91SGpqRHrZ5gx9qQhAAU80/gB/8FYkpSiAG8idQlt0mNp1KL/TldzfOkaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
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

SGkgQ2hyaXN0aWFuLAoKRllJLCByZW1vdmUgYW1kZ3B1X2JvX3Jlc2VydmUocm9vdCwgdHJ1ZSkg
YmVmb3JlIGNhbGxpbmcgCmFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZywgSSBnb3QgdGhpcyB3
YXJuaW5nIGJhY2t0cmFjZToKCiAgICAgWyAgMTgyLjM5MDA3Ml0gV0FSTklORzogQ1BVOiAxMiBQ
SUQ6IDQzNzYgYXQKIAovaG9tZS95YW5ncC9naXQvY29tcHV0ZV9zdGFnaW5nL2tlcm5lbC9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jOjEyMjkKICAgICB0dG1fYm9fdmFsaWRhdGUrMHgxNGQv
MHgxYjAgW3R0bV0KICAgICBbICAxODIuMzkwMDg1XSBNb2R1bGVzIGxpbmtlZCBpbjogZnVzZSBp
cDZ0YWJsZV9maWx0ZXIgaXA2X3RhYmxlcwogICAgIGlwdGFibGVfZmlsdGVyIGFtZGdwdSBhbWRf
aW9tbXVfdjIgZ3B1X3NjaGVkIGFzdCBkcm1fdnJhbV9oZWxwZXIKICAgICBkcm1fdHRtX2hlbHBl
ciB0dG0gazEwdGVtcCBpcF90YWJsZXMgeF90YWJsZXMgaTJjX3BpaXg0CiAgICAgWyAgMTgyLjM5
MDEyM10gQ1BVOiAxMiBQSUQ6IDQzNzYgQ29tbToga2ZkdGVzdCBUYWludGVkOiBHICAgICAgICBX
CiAgICAgNS40LjAtcmM3LWtmZC15YW5ncCAjMQogICAgIFsgIDE4Mi4zOTAxMzNdIEhhcmR3YXJl
IG5hbWU6IEdJR0FCWVRFIE1aMDEtQ0UwLTAwL01aMDEtQ0UwLTAwLCAKQklPUyBGMTIKICAgICAw
OC8wNS8yMDE5CiAgICAgWyAgMTgyLjM5MDE0Nl0gUklQOiAwMDEwOnR0bV9ib192YWxpZGF0ZSsw
eDE0ZC8weDFiMCBbdHRtXQogICAgIFsgIDE4Mi4zOTAxNTNdIENvZGU6IDQwIGZmIDUyIDE4IDhi
IDQ0IDI0IDA0IGU5IDRmIGZmIGZmIGZmIDQ4IDhiIDg3IDIwCiAgICAgMDEgMDAgMDAgYmUgZmYg
ZmYgZmYgZmYgNDggOGQgNzggNjAgZTggNWIgM2EgZTEgZDQgODUgYzAgMGYgODUgZTcgZmUgZmYK
ICAgICBmZiA8MGY+IDBiIGU5IGUwIGZlIGZmIGZmIGJlIDAxIDAwIDAwIDAwIDQ4IDg5IGRmIGU4
IDJmIGM0IGZmIGZmIGU5IDE5CiAgICAgWyAgMTgyLjM5MDE2MV0gUlNQOiAwMDE4OmZmZmZhYjdh
MDMyZjM5OTAgRUZMQUdTOiAwMDAxMDI0NgogICAgIFsgIDE4Mi4zOTAxNjZdIFJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IGZmZmY5NDNjNTliMzc4NTAgUkNYOgogICAgIGZmZmY5NDNjNTliMzUw
MDAKICAgICBbICAxODIuMzkwMTcxXSBSRFg6IGZmZmY5NDNjNTM5ZGFmMDAgUlNJOiBmZmZmOTQz
YzU2ZmIzMWQ4IFJESToKICAgICBmZmZmOTQzYzUzOWRiNzkwCiAgICAgWyAgMTgyLjM5MDE3OF0g
UkJQOiBmZmZmOTQzYzU5YjM3ODMwIFIwODogMDAwMDAwMDAwMDAwMDIwMCBSMDk6CiAgICAgMDAw
MDAwMDAwMDAwMDAwMAogICAgIFsgIDE4Mi4zOTAxODRdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBS
MTE6IDAwMDAwMDAwMDAxZmVlMGUgUjEyOgogICAgIGZmZmZhYjdhMDMyZjNhNTAKICAgICBbICAx
ODIuMzkwMTk0XSBSMTM6IDAwMDAwMDAwMDAwMDAyMDAgUjE0OiBmZmZmOTQzYzU5YjM3ODAwIFIx
NToKICAgICAwMDAwMDAwMDAwMDAwMDAwCiAgICAgWyAgMTgyLjM5MDE5N10gRlM6ICAwMDAwN2Yw
ZDI3ZjQxNzgwKDAwMDApIEdTOmZmZmY5NDNjOWU5MDAwMDAoMDAwMCkKICAgICBrbmxHUzowMDAw
MDAwMDAwMDAwMDAwCiAgICAgWyAgMTgyLjM5MDIwM10gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwogICAgIFsgIDE4Mi4zOTAyMDldIENSMjogMDAwMDdm
YmE3YTEwMTBhMCBDUjM6IDAwMDAwMDA3ZjI2MjQwMDAgQ1I0OgogICAgIDAwMDAwMDAwMDAzNDA2
ZTAKICAgICBbICAxODIuMzkwMjEyXSBDYWxsIFRyYWNlOgogICAgIFsgIDE4Mi4zOTAyMTldICA/
IHJjdV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweDUyLzB4ODAKICAgICBbICAxODIuMzkwMjIzXSAg
PyBfcmF3X3NwaW5fdW5sb2NrKzB4MjQvMHgzMAogICAgIFsgIDE4Mi4zOTAyNjddICA/IGFtZGdw
dV9ib19kb19jcmVhdGUrMHg0ZDEvMHg1ZDAgW2FtZGdwdV0KICAgICBbICAxODIuMzkwMzE5XSAg
YW1kZ3B1X3ZtX2NsZWFyX2JvKzB4MTNkLzB4M2EwIFthbWRncHVdCiAgICAgWyAgMTgyLjM5MDM3
MV0gID8gYW1kZ3B1X3ZtX251bV9lbnRyaWVzKzB4MWUvMHg3MCBbYW1kZ3B1XQogICAgIFsgIDE4
Mi4zOTA0MjRdICBhbWRncHVfdm1fdXBkYXRlX3B0ZXMrMHg1NjEvMHg1ZDAgW2FtZGdwdV0KICAg
ICBbICAxODIuMzkwNDgwXSAgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKzB4ZmQvMHgxMzAg
W2FtZGdwdV0KICAgICBbICAxODIuMzkwNTMwXSAgYW1kZ3B1X3ZtX2JvX3NwbGl0X21hcHBpbmcr
MHgxZWEvMHgyYzAgW2FtZGdwdV0KICAgICBbICAxODIuMzkwNTkxXSAgc3ZtX3JhbmdlX21hcF90
b19ncHVzKzB4MTYwLzB4MzEwIFthbWRncHVdCiAgICAgWyAgMTgyLjM5MDY1MF0gIGtmZF9yZWdp
c3Rlcl9zdm0rMHhiOC8weDJiMCBbYW1kZ3B1XQogICAgIFsgIDE4Mi4zOTA3MDhdICBrZmRfaW9j
dGxfcmVnaXN0ZXJfc3ZtKzB4ZTgvMHgxMTAgW2FtZGdwdV0KICAgICBbICAxODIuMzkwNzY1XSAg
a2ZkX2lvY3RsKzB4MjMyLzB4M2QwIFthbWRncHVdCiAgICAgWyAgMTgyLjM5MDgyM10gID8ga2Zk
X2lvY3RsX2dldF9wcm9jZXNzX2FwZXJ0dXJlc19uZXcrMHgzMTAvMHgzMTAKICAgICBbYW1kZ3B1
XQogICAgIFsgIDE4Mi4zOTA4MzhdICA/IHNlbGludXhfZmlsZV9pb2N0bCsweDE1My8weDIxMAog
ICAgIFsgIDE4Mi4zOTA4NDVdICBkb192ZnNfaW9jdGwrMHhhMi8weDZlMAogICAgIFsgIDE4Mi4z
OTA4NTRdICBrc3lzX2lvY3RsKzB4NzAvMHg4MAogICAgIFsgIDE4Mi4zOTA4NjJdICBfX3g2NF9z
eXNfaW9jdGwrMHgxNi8weDIwCiAgICAgWyAgMTgyLjM5MDg2OV0gIGRvX3N5c2NhbGxfNjQrMHg0
YS8weDFiMAogICAgIFsgIDE4Mi4zOTA4NzldICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0OS8weGJlCgpQaGlsaXAKCk9uIDIwMTktMTItMTIgMzo1MSBhLm0uLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+IEhpIEZlbGl4LAo+IAo+IHllYWgsIEkndmUgYWxzbyBmb3VuZCBhIGNv
cm5lciBjYXNlIHdoaWNoIHdvdWxkIHJhaXNlIGEgd2FybmluZyBub3cuCj4gCj4gTmVlZCB0byBy
ZXdvcmsgaG93IGRlcGVuZGVuY2llcyBmb3IgdGhlIFBURSB1cGRhdGUgYXJlIGdlbmVyYXRlZC4K
PiAKPiBHb2luZyB0byB0YWtlIGNhcmUgb2YgdGhpcyBpbiB0aGUgbmV4dCBmZXcgZGF5cywKPiBD
aHJpc3RpYW4uCj4gCj4gQW0gMTIuMTIuMTkgdW0gMDE6MjAgc2NocmllYiBGZWxpeCBLdWVobGlu
ZzoKPj4gSGkgQ2hyaXN0aWFuLAo+Pgo+PiBBbGV4IHN0YXJ0ZWQgdHJ5aW5nIHRvIGludmFsaWRh
dGUgUFRFcyBpbiB0aGUgTU1VIG5vdGlmaWVycyBhbmQgd2UncmUgCj4+IGZpbmRpbmcgdGhhdCB3
ZSBzdGlsbCBuZWVkIHRvIHJlc2VydmUgdGhlIFZNIHJlc2VydmF0aW9uIGZvciAKPj4gYW1kZ3B1
X3N5bmNfcmVzdiBpbiBhbWRncHVfdm1fc2RtYV9wcmVwYXJlLiBJcyB0aGF0IHN5bmNfcmVzdiBz
dGlsbCAKPj4gbmVlZGVkIG5vdywgZ2l2ZW4gdGhhdCBWTSBmZW5jZXMgYXJlbid0IGluIHRoYXQg
cmVzZXJ2YXRpb24gb2JqZWN0IGFueSAKPj4gbW9yZT8KPj4KPj4gUmVnYXJkcywKPj4gwqAgRmVs
aXgKPj4KPj4gT24gMjAxOS0xMi0wNSA1OjM5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4g
V2hlbiBhIEJPIGlzIGV2aWN0ZWQgaW1tZWRpYWxseSBpbnZhbGlkYXRlIHRoZSBtYXBwZWQgUFRF
cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgMTcgKysrKysrKysrKysrKysrKy0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gaW5kZXggODM5ZDZkZjM5NGZjLi5lNTc4MTEzYmZk
NTUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IEBA
IC0yNTY1LDYgKzI1NjUsNyBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCAK
Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm8sIGJvb2wgZXZpY3RlZCkKPj4+IMKgIHsKPj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICpib19iYXNlOwo+Pj4gK8KgwqDC
oCBpbnQgcjsKPj4+IMKgIMKgwqDCoMKgwqAgLyogc2hhZG93IGJvIGRvZXNuJ3QgaGF2ZSBibyBi
YXNlLCBpdHMgdmFsaWRhdGlvbiBuZWVkcyBpdHMgCj4+PiBwYXJlbnQgKi8KPj4+IMKgwqDCoMKg
wqAgaWYgKGJvLT5wYXJlbnQgJiYgYm8tPnBhcmVudC0+c2hhZG93ID09IGJvKQo+Pj4gQEAgLTI1
NzIsOCArMjU3MywyMiBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCAKPj4+
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+PiDCoCDCoMKgwqDCoMKgIGZvciAoYm9fYmFzZSA9IGJv
LT52bV9ibzsgYm9fYmFzZTsgYm9fYmFzZSA9IGJvX2Jhc2UtPm5leHQpIHsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9IGJvX2Jhc2UtPnZtOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRiby5i
YXNlLnJlc3Y7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGJvLT50Ym8udHlwZSAhPSB0
dG1fYm9fdHlwZV9rZXJuZWwpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBh
bWRncHVfYm9fdmEgKmJvX3ZhOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9f
dmEgPSBjb250YWluZXJfb2YoYm9fYmFzZSwgc3RydWN0IGFtZGdwdV9ib192YSwKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFzZSk7Cj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZShhZGV2LCBib192
YSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJv
LT50Ym8uYmFzZS5yZXN2ICE9IHJlc3YpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KCFyKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV92bV9ib19p
ZGxlKGJvX2Jhc2UpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51
ZTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+
PiDCoCAtwqDCoMKgwqDCoMKgwqAgaWYgKGV2aWN0ZWQgJiYgYm8tPnRiby5iYXNlLnJlc3YgPT0g
Cj4+PiB2bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2KSB7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKGV2aWN0ZWQgJiYgYm8tPnRiby5iYXNlLnJlc3YgPT0gcmVzdikgewo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX2JvX2V2aWN0ZWQoYm9fYmFzZSk7Cj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
