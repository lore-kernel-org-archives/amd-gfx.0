Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72752C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45612206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="egSHmROR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45612206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E213D6E5C3;
	Tue, 11 Aug 2020 16:14:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD876E5C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 16:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E28LxrhH8ZE3C1PCPi0IaiK8zmF4JztLAR/b05dbQ2E/zSD10L/rWQCF4GxxyYaBRyeWv9MCQQOU6jLryW91n9psL37U5rLEAdkjYxmEP0IV5Mzrse779V3O/Y8aF9v0PCl9yqiTjqaMYA0Rscp8VXGqPrlZ51t5M7daDZ3YX38RtlUq0fgLa5233G1c4htSsqDe0hVjjxaL9Sj8CUeQrcJk6fMjxdz5OMEYgvqNda9lRjrM70E3mV39MhrcjNx0wdhezvQ4xC/oi3XwA2d5jjQUvjPaYoBYbO0oIsRWBJW8GDEAOQmTd/0sacBUwA61LTpGNufJAObBtTej6toi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7GReJYSmHNbuB3j4ZSVuv+JAl5ERtPeSsKKSN8SI2k=;
 b=BUskMdDo7cBoj+HLvyFVMMXX1NIFombQ0k/FUX8huNS9FZ8tgbsH0P3OCDSCA/WNyonUO8/rvh0GDXu7CH+uv9bHBdhQmLg1jNMMA5mejj2UhFsXnw0wfDcBRWiZq8VL6m42RbcGJaiJquo1iuGYQ9Y/HrhQeUS3rJX4niNvqWJb4OAHxphxbY/KCUrc2+Dg2BbQytdiTj+B5JDKDiywEEp8olkUbPCALp5GsQywkJ0mqKUiZ478QDqZlUL01YBiDFG8EJMsGsBQaA8bLy5fh2eEsB+HntoY3+w9GW/GTzWoQx7ACYwcaNf456XMeZhNVbawGNI0Wly8i0v3KGqZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7GReJYSmHNbuB3j4ZSVuv+JAl5ERtPeSsKKSN8SI2k=;
 b=egSHmROR3/THVVa7+RUzFKpxgEuQ83FqHXYzec3CnAU9tpv61lRKJsau8ABVRYs/CfYLaKbST7a4VnSgYggrrhZM9oAsR9eLOZmrdK+wgVWPgeq2hHBAvyNGroz8M5LDX61LW8Cq0Cf226riZ7pGdRoexQeiSfgtQGK3r4wrqAA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 16:14:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:14:52 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a potential circular locking dependency
To: Felix Kuehling <felix.kuehling@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
References: <20200811093208.13149-1-Dennis.Li@amd.com>
 <baafa5b8-018a-f704-d5be-89b8a24f6082@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <aea9be29-26ee-e618-b05c-b0ac10754c91@amd.com>
Date: Tue, 11 Aug 2020 18:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <baafa5b8-018a-f704-d5be-89b8a24f6082@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::39) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:208:3e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 16:14:48 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d86c18aa-d348-4ba5-e36e-08d83e11ad86
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42549467EEB775CE2F56014C83450@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Au3/fYvKWnvBw/BFjji4A13CRyNdXtK4EbhD3E1tNODzi6w35rGvzcXqITl67pr2nGUOBI/pRP3BL9ZJyYsEyzmDrkC3sRT9buyUQz+KtnBRR96CtMiylVQuAJdtky5j/74qrIADBk7ww8KEhG1+Lsk77newVoZhyRu0Znli4OJoC7c/qAYTEiUdZ4YvKkVDkr5HB9aLHP7ocstbLxhEj4qUo9lUz81Znpqg+SBUGGiQ/sPoWkAPDfSBMeCBSgDY9oup0vCB3tRIMJRvTSxLxXNm1R1PRGQ4wW768iQ1+1NHMi9EmcOgtXDTGhBXPauoNwpJt0YM8SqEi0mKpJgSZhr3gKGPIgIGZZzYIdmoeT0l9pGYYl+5vSPxo+6C4/DG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(8676002)(316002)(2906002)(6666004)(5660300002)(6636002)(110136005)(478600001)(31686004)(186003)(16526019)(66946007)(6486002)(52116002)(83380400001)(2616005)(31696002)(66556008)(86362001)(66476007)(8936002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RmONbFApHYYgIEfDWnjlA+4bvy+AqeFRQJXohfvvGELfA8Fg1xKbJy2GzUHDMS+kQzsM0Re5G/82KT1MWOvhPqdvpOpkeROfmy2K5ltG41FOKL2HdXNlB2O1onV/utEmuPzTZRdAd2szXet3IoIzr3SKUNwaxH8K+9buI8rscMGpzFrTrvnTIqGrLtXqdGxilqxlBhZrA+gIdWqt5QFIWBVC4KjEJnR9xEnqWTLK1FoMPlLek5D7fIBvakgWncnPmxrzD7H9/5FZ51WPFQ/zEMJdaOg/Qo+9XG2KfLw0GymHd5RjDPd+1QJu/vliBIXt8p7KRrCz8u3YpjqOZSLmweCQ5xBoJS0HSUb6+upGBRBIzgWvhaUK5OQxKxUkNs56vgKUs02ZYsJKm5yXWW+hunb8u8fDTsPnHLd4dgzDNSsPBzwIGE6Ej1E8K0Mv3QnaBOy1Aynldo9Ycm3pfg3iw/g/3rW5Vt6F3UL+vwbUjw67LWFT8dqxdk+KgPX0xNWGa1iuaiS0/0nO2NJDgHDx/7TXwGXQYgNwoi1AIK35pPhjaUgp4Gyw+/H/Bc9NYtUllPbLV9ys+4WJEz6Fb48uje9SFmGPGYuYLq0lx8tNvIFR/MJyBSd9hBQE/TSp29hPxxUbtZvYnN/Zqo8AfPZ5nGFy4gH4LBsDqsbRxNHiLywmfURI8sCXr5ouk7pydPsAJJU1FLMooeqbhrjsqbJvbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86c18aa-d348-4ba5-e36e-08d83e11ad86
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:14:52.1588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZQpzhKxd16RHyg88vlF6MuQMQ60iXDhB+OPhonQBiKz63EjTyIIMoUOQO9/v4T8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

QW0gMTEuMDguMjAgdW0gMTU6NTcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA4
LTExIHVtIDU6MzIgYS5tLiBzY2hyaWViIERlbm5pcyBMaToKPj4gWyAgNjUzLjkwMjMwNV0gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4+IFsg
IDY1My45MDI5MjhdIFdBUk5JTkc6IHBvc3NpYmxlIGNpcmN1bGFyIGxvY2tpbmcgZGVwZW5kZW5j
eSBkZXRlY3RlZAo+PiBbICA2NTMuOTAzNTE3XSA1LjYuMC1kZWxpLXY1LjYtMjg0OC1nM2YzMTA5
YjBlNzVmICMxIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FCj4+IFsgIDY1My45MDQwOThdIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiBbICA2
NTMuOTA0Njc1XSBhbWRncHVfdGVzdC8zOTc1IGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6Cj4+
IFsgIDY1My45MDUyNDFdIGZmZmY5Nzg0OGY4NjQ3YTAgKCZhZGV2LT5yZXNldF9zZW0pey4rLit9
LCBhdDogYW1kZ3B1X2dlbV92YV9pb2N0bCsweDI4Ni8weDRmMCBbYW1kZ3B1XQo+PiBbICA2NTMu
OTA1OTUzXQo+PiAgICAgICAgICAgICAgICAgYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxv
Y2s6Cj4+IFsgIDY1My45MDcwODddIGZmZmY5NzQ0YWRiZWUxZjggKHJlc2VydmF0aW9uX3d3X2Ns
YXNzX211dGV4KXsrLisufSwgYXQ6IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMrMHgxYWUvMHg1MjAg
W3R0bV0KPj4gWyAgNjUzLjkwNzY5NF0KPj4gICAgICAgICAgICAgICAgIHdoaWNoIGxvY2sgYWxy
ZWFkeSBkZXBlbmRzIG9uIHRoZSBuZXcgbG9jay4KPj4KPj4gWyAgNjUzLjkwOTQyM10KPj4gICAg
ICAgICAgICAgICAgIHRoZSBleGlzdGluZyBkZXBlbmRlbmN5IGNoYWluIChpbiByZXZlcnNlIG9y
ZGVyKSBpczoKPj4gWyAgNjUzLjkxMDU5NF0KPj4gICAgICAgICAgICAgICAgIC0+ICMxIChyZXNl
cnZhdGlvbl93d19jbGFzc19tdXRleCl7Ky4rLn06Cj4+IFsgIDY1My45MTE3NTldICAgICAgICBf
X3d3X211dGV4X2xvY2suY29uc3Rwcm9wLjE1KzB4Y2EvMHgxMTIwCj4+IFsgIDY1My45MTIzNTBd
ICAgICAgICB3d19tdXRleF9sb2NrKzB4NzMvMHg4MAo+PiBbICA2NTMuOTEzMDQ0XSAgICAgICAg
YW1kZ3B1X2FtZGtmZF9hbGxvY19ndHRfbWVtKzB4ZGUvMHgzODAgW2FtZGdwdV0KPj4gWyAgNjUz
LjkxMzcyNF0gICAgICAgIGtnZDJrZmRfZGV2aWNlX2luaXQrMHgxM2YvMHg1ZTAgW2FtZGdwdV0K
Pj4gWyAgNjUzLjkxNDM4OF0gICAgICAgIGFtZGdwdV9hbWRrZmRfZGV2aWNlX2luaXQrMHgxNTUv
MHgxOTAgW2FtZGdwdV0KPj4gWyAgNjUzLjkxNTAzM10gICAgICAgIGFtZGdwdV9kZXZpY2VfaW5p
dCsweDEzMDMvMHgxZTEwIFthbWRncHVdCj4+IFsgIDY1My45MTU2ODVdICAgICAgICBhbWRncHVf
ZHJpdmVyX2xvYWRfa21zKzB4NWMvMHgyYzAgW2FtZGdwdV0KPj4gWyAgNjUzLjkxNjM0OV0gICAg
ICAgIGFtZGdwdV9wY2lfcHJvYmUrMHgxMWQvMHgyMDAgW2FtZGdwdV0KPj4gWyAgNjUzLjkxNjk1
OV0gICAgICAgIGxvY2FsX3BjaV9wcm9iZSsweDQ3LzB4YTAKPj4gWyAgNjUzLjkxNzU3MF0gICAg
ICAgIHdvcmtfZm9yX2NwdV9mbisweDFhLzB4MzAKPj4gWyAgNjUzLjkxODE4NF0gICAgICAgIHBy
b2Nlc3Nfb25lX3dvcmsrMHgyOWUvMHg2MzAKPj4gWyAgNjUzLjkxODgwM10gICAgICAgIHdvcmtl
cl90aHJlYWQrMHgyMmIvMHgzZjAKPj4gWyAgNjUzLjkxOTQyN10gICAgICAgIGt0aHJlYWQrMHgx
MmYvMHgxNTAKPj4gWyAgNjUzLjkyMDA0N10gICAgICAgIHJldF9mcm9tX2ZvcmsrMHgzYS8weDUw
Cj4+IFsgIDY1My45MjA2NjFdCj4+ICAgICAgICAgICAgICAgICAtPiAjMCAoJmFkZXYtPnJlc2V0
X3NlbSl7LisuK306Cj4+IFsgIDY1My45MjE4OTNdICAgICAgICBfX2xvY2tfYWNxdWlyZSsweDEz
ZWMvMHgxNmUwCj4+IFsgIDY1My45MjI1MzFdICAgICAgICBsb2NrX2FjcXVpcmUrMHhiOC8weDFj
MAo+PiBbICA2NTMuOTIzMTc0XSAgICAgICAgZG93bl9yZWFkKzB4NDgvMHgyMzAKPj4gWyAgNjUz
LjkyMzg4Nl0gICAgICAgIGFtZGdwdV9nZW1fdmFfaW9jdGwrMHgyODYvMHg0ZjAgW2FtZGdwdV0K
Pj4gWyAgNjUzLjkyNDU4OF0gICAgICAgIGRybV9pb2N0bF9rZXJuZWwrMHhiNi8weDEwMCBbZHJt
XQo+PiBbICA2NTMuOTI1MjgzXSAgICAgICAgZHJtX2lvY3RsKzB4Mzg5LzB4NDUwIFtkcm1dCj4+
IFsgIDY1My45MjYwMTNdICAgICAgICBhbWRncHVfZHJtX2lvY3RsKzB4NGYvMHg4MCBbYW1kZ3B1
XQo+PiBbICA2NTMuOTI2Njg2XSAgICAgICAga3N5c19pb2N0bCsweDk4LzB4YjAKPj4gWyAgNjUz
LjkyNzM1N10gICAgICAgIF9feDY0X3N5c19pb2N0bCsweDFhLzB4MjAKPj4gWyAgNjUzLjkyODAz
MF0gICAgICAgIGRvX3N5c2NhbGxfNjQrMHg1Zi8weDI1MAo+PiBbICA2NTMuOTI4Njk3XSAgICAg
ICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQo+PiBbICA2NTMuOTI5
MzczXQo+PiAgICAgICAgICAgICAgICAgb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVi
dWcgdGhpczoKPj4KPj4gWyAgNjUzLjkzMTM1Nl0gIFBvc3NpYmxlIHVuc2FmZSBsb2NraW5nIHNj
ZW5hcmlvOgo+Pgo+PiBbICA2NTMuOTMyNjQ3XSAgICAgICAgQ1BVMCAgICAgICAgICAgICAgICAg
ICAgQ1BVMQo+PiBbICA2NTMuOTMzMjg3XSAgICAgICAgLS0tLSAgICAgICAgICAgICAgICAgICAg
LS0tLQo+PiBbICA2NTMuOTMzOTExXSAgIGxvY2socmVzZXJ2YXRpb25fd3dfY2xhc3NfbXV0ZXgp
Owo+PiBbICA2NTMuOTM0NTMwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9jaygm
YWRldi0+cmVzZXRfc2VtKTsKPj4gWyAgNjUzLjkzNTE1NF0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGxvY2socmVzZXJ2YXRpb25fd3dfY2xhc3NfbXV0ZXgpOwo+PiBbICA2NTMuOTM1
NzY2XSAgIGxvY2soJmFkZXYtPnJlc2V0X3NlbSk7Cj4+IFsgIDY1My45MzYzNjBdCj4+ICAgICAg
ICAgICAgICAgICAgKioqIERFQURMT0NLICoqKgo+Pgo+PiBbICA2NTMuOTM4MDI4XSAyIGxvY2tz
IGhlbGQgYnkgYW1kZ3B1X3Rlc3QvMzk3NToKPj4gWyAgNjUzLjkzODU3NF0gICMwOiBmZmZmYjJh
ODYyZDZiY2QwIChyZXNlcnZhdGlvbl93d19jbGFzc19hY3F1aXJlKXsrLisufSwgYXQ6IGFtZGdw
dV9nZW1fdmFfaW9jdGwrMHgzOWIvMHg0ZjAgW2FtZGdwdV0KPj4gWyAgNjUzLjkzOTIzM10gICMx
OiBmZmZmOTc0NGFkYmVlMWY4IChyZXNlcnZhdGlvbl93d19jbGFzc19tdXRleCl7Ky4rLn0sIGF0
OiB0dG1fZXVfcmVzZXJ2ZV9idWZmZXJzKzB4MWFlLzB4NTIwIFt0dG1dCj4+Cj4+IGNoYW5nZSB0
aGUgb3JkZXIgb2YgcmVzZXJ2YXRpb25fd3dfY2xhc3NfbXV0ZXggYW5kIGFkZXYtPnJlc2V0X3Nl
bSBpbgo+PiBhbWRncHVfZ2VtX3ZhX2lvY3RsIHRoZSBzYW1lIGFzIG9uZXMgaW4gYW1kZ3B1X2Ft
ZGtmZF9hbGxvY19ndHRfbWVtLCB0bwo+PiBhdm9pZCBwb3RlbnRpYWwgZGVhZCBsb2NrLgo+IEl0
IG1heSBiZSBiZXR0ZXIgdG8gZml4IGl0IHRoZSBvdGhlciB3YXkgYXJvdW5kIGluCj4gYW1kZ3B1
X2FtZGtmZF9hbGxvY19ndHRfbWVtLiBBbHdheXMgdGFrZSB0aGUgcmVzZXRfc2VtIGluc2lkZSB0
aGUKPiByZXNlcnZhdGlvbi4gT3RoZXJ3aXNlIHlvdSB3aWxsIG5ldmVyIGJlIGFibGUgdG8gdGFr
ZSB0aGUgcmVzZXRfc2VtCj4gd2hpbGUgYW55IEJPcyBhcmUgcmVzZXJ2ZWQuIFRoYXQncyBwcm9i
YWJseSBnb2luZyB0byBjYXVzZSB5b3Ugb3RoZXIKPiBwcm9ibGVtcyBsYXRlci4KPgo+IFRoYXQg
bWFrZXMgbWUgd29uZGVyLCB3aHkgZG8geW91IG5lZWQgdGhlIHJlc2V0X3NlbSBpbgo+IGFtZGdw
dV9hbWRrZmRfYWxsb2NfZ3R0X21lbSBpbiB0aGUgZmlyc3QgcGxhY2U/IFRoZXJlIGlzIG5vIG9i
dmlvdXMKPiBoYXJkd2FyZSBhY2Nlc3MgaW4gdGhhdCBmdW5jdGlvbi4gSXMgaXQgZm9yIGFtZGdw
dV90dG1fYWxsb2NfZ2FydAo+IHVwZGF0aW5nIHRoZSBHQVJUIHRhYmxlIHRocm91Z2ggSERQPwoK
SSB3YXMgd29uZGVyaW5nIHRoZSBzYW1lIHRoaW5nIGZvciB0aGUgYW1kZ3B1X2dlbV92YV9pb2N0
bCgpIGFzIHdlbGwuCgpXZSBzaG91bGRuJ3QgaGF2ZSBhbnkgaGFyZHdhcmUgYWNjZXNzIGhlcmUs
IHNvIHRha2luZyB0aGUgcmVzZXRfc2VtIApsb29rcyBsaWtlIG92ZXJraWxsIHRvIG1lLgoKQ2hy
aXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4Cj4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBE
ZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPgo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jCj4+IGluZGV4IGVlMWU4ZmZmODNiMi4uZmM4ODljNDc3Njk2IDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IEBAIC02NTIsNiAr
NjUyLDggQEAgaW50IGFtZGdwdV9nZW1fdmFfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwg
dm9pZCAqZGF0YSwKPj4gICAJCWFibyA9IE5VTEw7Cj4+ICAgCX0KPj4gICAKPj4gKwlkb3duX3Jl
YWQoJmFkZXYtPnJlc2V0X3NlbSk7Cj4+ICsKPj4gICAJYW1kZ3B1X3ZtX2dldF9wZF9ibygmZnBy
aXYtPnZtLCAmbGlzdCwgJnZtX3BkKTsKPj4gICAKPj4gICAJciA9IHR0bV9ldV9yZXNlcnZlX2J1
ZmZlcnMoJnRpY2tldCwgJmxpc3QsIHRydWUsICZkdXBsaWNhdGVzKTsKPj4gQEAgLTY3MCw4ICs2
NzIsNiBAQCBpbnQgYW1kZ3B1X2dlbV92YV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2
b2lkICpkYXRhLAo+PiAgIAkJYm9fdmEgPSBOVUxMOwo+PiAgIAl9Cj4+ICAgCj4+IC0JZG93bl9y
ZWFkKCZhZGV2LT5yZXNldF9zZW0pOwo+PiAtCj4+ICAgCXN3aXRjaCAoYXJncy0+b3BlcmF0aW9u
KSB7Cj4+ICAgCWNhc2UgQU1ER1BVX1ZBX09QX01BUDoKPj4gICAJCXZhX2ZsYWdzID0gYW1kZ3B1
X2dlbV92YV9tYXBfZmxhZ3MoYWRldiwgYXJncy0+ZmxhZ3MpOwo+PiBAQCAtNzAxLDEyICs3MDEs
MTEgQEAgaW50IGFtZGdwdV9nZW1fdmFfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9p
ZCAqZGF0YSwKPj4gICAJCWFtZGdwdV9nZW1fdmFfdXBkYXRlX3ZtKGFkZXYsICZmcHJpdi0+dm0s
IGJvX3ZhLAo+PiAgIAkJCQkJYXJncy0+b3BlcmF0aW9uKTsKPj4gICAKPj4gLQl1cF9yZWFkKCZh
ZGV2LT5yZXNldF9zZW0pOwo+PiAtCj4+ICAgZXJyb3JfYmFja29mZjoKPj4gICAJdHRtX2V1X2Jh
Y2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOwo+PiAgIAo+PiAgIGVycm9yX3VucmVm
Ogo+PiArCXVwX3JlYWQoJmFkZXYtPnJlc2V0X3NlbSk7Cj4+ICAgCWRybV9nZW1fb2JqZWN0X3B1
dF91bmxvY2tlZChnb2JqKTsKPj4gICAJcmV0dXJuIHI7Cj4+ICAgfQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
