Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F98FC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF14205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zdOm7maz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF14205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829A86E433;
	Mon, 30 Mar 2020 15:48:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E476E426
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 15:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHNT9x829r+RB2jI9H0oN8YS+r1sfVhHYDlbUHJa/7tBwXUDWWKZExOz1bTKFqC7SAOLaMio902ANrjY7RX1vH0c4+P/D05PmCp88v6AzTPYoCeZYnM5jidrUror7IPO5zOtDJbml9Y/MQDzbTBbk5FYYCz3L2RQVHqsjAf2qeu4RLJRf0m7gtbuVmGIGL+vDXcHGPo9+xLA1U1NNKRYhV5f0BruBHPkTs7UaXeGpkyTw2jgYWeXqUxyvhi2tXZjuT7zBHbEQ13ANSl+XV8FVhDDHfjncy+KUm0ro5tmx9U41XZDacSZocHJvcUuHwbYDqFKsPiZ0cYyfRp6T7M8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYuvMXcSIGYNM0WH0EDZEi6JeKeVx2TPMMRyd8rOn+A=;
 b=R3cIVhJCvigvuYuGij1n4gwsyYG3q9apItUA9j4PfZCYxIzRz9vuzj+dsi9549M4yDSuB83cr35wMH/toZu7/L9Kxn/Ga5w0sw+BlKxwwQkRtnO6OBJhfzIsj6tGaAFxADxhXWghuVBYNlJ3LqjWs9DnMYSjHq7VNERyEOLiw6oqWycC3xtJcN0tOAjdzXO86F6BYno+501AABVK2LgGMIqxwcmBaOpg37aplH3UPNbODeUd3AWBJ15cmIYx2QSBlQSxZTjozReNrEz14VaFn4hr0qdnfTN6EflVi/zEtFDMoeMCVkIAEQMioGi7r55DQFrvR29ZzlevfwJPnDP3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYuvMXcSIGYNM0WH0EDZEi6JeKeVx2TPMMRyd8rOn+A=;
 b=zdOm7maz78WhRSN95I6g9LSNKuIbDecXfSLmVB9C9OKeYsPrEqbCEeJHOaB3R1rtT9kSQFO/5ENEEMA0ZpjtI5B0VtulLGCdeZgsLOTOV3nejqf1g/93YR0XYHpsifNlNxp+/etvd61kBGQh0I2eP6Rls3E/x2O0IFD04IGuG7U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 15:48:32 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:48:32 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu/vcn: Add firmware share memory support
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
 <1585570418-13894-3-git-send-email-James.Zhu@amd.com>
 <ba771d61-642d-4ea3-ba77-1b22c7334ee1@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <c0466c55-8f47-1147-1a3f-44d7de193978@amd.com>
Date: Mon, 30 Mar 2020 11:48:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <ba771d61-642d-4ea3-ba77-1b22c7334ee1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 15:48:31 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 398375c4-5b02-4b4a-300d-08d7d4c1cc67
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:|DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485FC050B23FD316C4ED736E4CB0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(31696002)(36756003)(36916002)(186003)(2906002)(5660300002)(6486002)(2616005)(53546011)(956004)(26005)(16526019)(52116002)(478600001)(66476007)(66556008)(66946007)(31686004)(110136005)(316002)(16576012)(8676002)(81166006)(8936002)(81156014);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grdEU8xp2ZeiqPgnsTXJBj3t4IG7bC6pAGyUEbfkLTtgH6Rx06EUi0oudR6M6JQXj4eNu8X/r0TecQtuQ7DlWbnFCW9zTWLl1z2e7orgMEd+0l4NKMJdPcVD3IsZ5BNB1lXXY0/tBgzXgKg2tJQ10OrT/H7L//2IYKmQW40NBOJjX9oT3RnLdRKJzOHbsspnpdgXKCIO9wvcu10++F9Gv97avLFbmimLkZnMPP2Y+zBtGOZzoMTJ2uvq7mLgKZ+3EgTpcVev+kBSmEvdeQBTYDZq+jmu9cWjgLAH5ju5mjBdrdnpYpN/oly0vUoYvfdOXEpvRn1o1x5RxSc1b/rU0+u5uKPOGNBcrc/pYdmaUNL7L3+YmfC/X7MI7lFgt8vFc4Z6FUssk+eAzuwa9zusswBWxgr2Gu6YTM9zSWH/BoKG63hWFiUtN8HGy7pSyyDZ
X-MS-Exchange-AntiSpam-MessageData: FeeCssI/f9YAVD899tXn/G7P2i3jZ3z1isDyHu5NVMgQVZV5zcCsqLXupjaxb+OBTWyqZIg8EAJZ4LwOANQJCpcRV2DIXAQaI0eQCS5Jr7LL8/ypXCehl5/rw+5+/OjKsT+PmQ19So0ZZ/cL4tyEkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398375c4-5b02-4b4a-300d-08d7d4c1cc67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:48:32.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmNzr0fE83oTZ9MbmjIa4OuAoLuXoOXvsrF+xjVFemIvGGABB8LQaEcu4MQfFsRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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

Ck9uIDIwMjAtMDMtMzAgMTA6MjEgYS5tLiwgTGVvIExpdSB3cm90ZToKPgo+IE9uIDIwMjAtMDMt
MzAgODoxMyBhLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4+IEFkZGVkIGZpcm13YXJlIHNoYXJlIG1l
bW9yeSBzdXBwb3J0IGZvciBWQ04uIEN1cnJlbnQgbXVsdGlwbGUKPj4gcXVldWUgbW9kZSBpcyBl
bmFibGVkIG9ubHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFt
ZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNu
LmMgfCAxMyArKysrKysrKysrKysrCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uaCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCAyIGZpbGVzIGNo
YW5nZWQsIDM3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMKPj4gaW5kZXggN2EwYjA3NC4uMzI4YjZjZSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+PiBAQCAtMTgyLDYgKzE4MiwxNCBAQCBp
bnQgYW1kZ3B1X3Zjbl9zd19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoMKg
wqDCoMKgIHIgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCAKPj4gQU1ER1BVX0dQVV9Q
QUdFX0FMSUdOKHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2Z3X3NoYXJlZCkpLAo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBBR0VfU0laRSwgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwg
Cj4+ICZhZGV2LT52Y24uaW5zdFtpXS5md19zaGFyZWRfYm8sCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgJmFkZXYtPnZjbi5pbnN0W2ldLmZ3X3NoYXJlZF9ncHVfYWRkciwgCj4+
ICZhZGV2LT52Y24uaW5zdFtpXS5md19zaGFyZWRfY3B1X2FkZHIpOwo+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKHIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycihhZGV2LT5kZXYs
ICJWQ04gJWQgKCVkKSBmYWlsZWQgdG8gYWxsb2NhdGUgCj4+IGZpbXdhcmUgc2hhcmVkIGJvXG4i
LCBpLCByKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+ICvCoMKgwqDC
oMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiBA
QCAtMTk2LDYgKzIwNCwxMSBAQCBpbnQgYW1kZ3B1X3Zjbl9zd19maW5pKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+PiDCoMKgwqDCoMKgIGZvciAoaiA9IDA7IGogPCBhZGV2LT52Y24ubnVt
X3Zjbl9pbnN0OyArK2opIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uaGFy
dmVzdF9jb25maWcgJiAoMSA8PCBqKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
dGludWU7Cj4+ICsKPj4gKyBhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPnZjbi5pbnN0W2pd
LmZ3X3NoYXJlZF9ibywKPj4gKyAmYWRldi0+dmNuLmluc3Rbal0uZndfc2hhcmVkX2dwdV9hZGRy
LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh2b2lkICoq
KSZhZGV2LT52Y24uaW5zdFtqXS5md19zaGFyZWRfY3B1X2FkZHIpOwo+PiArCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmluZGlyZWN0X3NyYW0pIHsKPj4gYW1kZ3B1X2JvX2Zy
ZWVfa2VybmVsKCZhZGV2LT52Y24uaW5zdFtqXS5kcGdfc3JhbV9ibywKPj4gJmFkZXYtPnZjbi5p
bnN0W2pdLmRwZ19zcmFtX2dwdV9hZGRyLAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uaAo+PiBpbmRleCBlOTEzZGU4Li44NTNmMGNjIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+IEBAIC0xNzksMTEgKzE3OSwxNCBAQCBz
dHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0IHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2lycV9z
cmPCoMKgwqAgaXJxOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdmNuX3JlZ8KgwqDCoCBl
eHRlcm5hbDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvwqDCoMKgICpkcGdfc3JhbV9i
bzsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvwqDCoMKgICpmd19zaGFyZWRfYm87Cj4+IMKg
wqDCoMKgwqAgc3RydWN0IGRwZ19wYXVzZV9zdGF0ZcKgwqDCoCBwYXVzZV9zdGF0ZTsKPj4gwqDC
oMKgwqDCoCB2b2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZHBnX3NyYW1fY3B1X2FkZHI7Cj4+
IMKgwqDCoMKgwqAgdWludDY0X3TCoMKgwqDCoMKgwqDCoCBkcGdfc3JhbV9ncHVfYWRkcjsKPj4g
wqDCoMKgwqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgICpkcGdfc3JhbV9jdXJyX2FkZHI7Cj4+
IMKgwqDCoMKgwqAgYXRvbWljX3TCoMKgwqDCoMKgwqDCoCBkcGdfZW5jX3N1Ym1pc3Npb25fY250
Owo+PiArwqDCoMKgIHZvaWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpmd19zaGFyZWRfY3B1X2Fk
ZHI7Cj4+ICvCoMKgwqAgdWludDY0X3TCoMKgwqDCoMKgwqDCoCBmd19zaGFyZWRfZ3B1X2FkZHI7
Cj4+IMKgIH07Cj4+IMKgIMKgIHN0cnVjdCBhbWRncHVfdmNuIHsKPj4gQEAgLTIwOSw2ICsyMTIs
MjcgQEAgc3RydWN0IGFtZGdwdV92Y24gewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGluc3Rf
aWR4LCBzdHJ1Y3QgZHBnX3BhdXNlX3N0YXRlICpuZXdfc3RhdGUpOwo+PiDCoCB9Owo+PiDCoCAr
I2RlZmluZSBBTURHUFVfVkNOX01VTFRJX1FVRVVFX0ZMQUfCoMKgwqDCoMKgwqDCoCAoMSA8PCA4
KQo+PiArCj4+ICtlbnVtIGZ3X3F1ZXVlX21vZGUgewo+PiArwqDCoMKgIGZ3X3F1ZXVlX3Jpbmdf
cmVzZXQgPSAxLAo+PiArwqDCoMKgIGZ3X3F1ZXVlX2RwZ19ob2xkX29mZiA9IDIsCj4+ICt9Owo+
Cj4gUGxlYXNlIG1vdmUgdGhlIGRlZmluZSBhbmQgZW51bSB0byB0aGUgdG9wIGFzIG90aGVycy4g
V2l0aCB0aGF0IGZpeGVkLCAKPiB0aGUgc2VyaWVzIGFyZQoKU3VyZS4gQ2FuIHlvdSByZXZpZXcg
dGhlIHBhdGNoZXMgYWxzbz8KClRoYW5rcyEKCkphbWVzCgo+Cj4gUmV2aWV3ZWQtYnk6IExlbyBM
aXUgPGxlby5saXVAYW1kLmNvbT4KPgo+Cj4KPj4gKwo+PiArc3RydWN0IGFtZGdwdV9md19zaGFy
ZWRfbXVsdGlfcXVldWUgewo+PiArwqDCoMKgIHVpbnQ4X3QgZGVjb2RlX3F1ZXVlX21vZGU7Cj4+
ICvCoMKgwqAgdWludDhfdCBlbmNvZGVfZ2VuZXJhbHB1cnBvc2VfcXVldWVfbW9kZTsKPj4gK8Kg
wqDCoCB1aW50OF90IGVuY29kZV9sb3dsYXRlbmN5X3F1ZXVlX21vZGU7Cj4+ICvCoMKgwqAgdWlu
dDhfdCBlbmNvZGVfcmVhbHRpbWVfcXVldWVfbW9kZTsKPj4gK8KgwqDCoCB1aW50OF90IHBhZGRp
bmdbNF07Cj4+ICt9Owo+PiArCj4+ICtzdHJ1Y3QgYW1kZ3B1X2Z3X3NoYXJlZCB7Cj4+ICvCoMKg
wqAgdWludDMyX3QgcHJlc2VudF9mbGFnXzA7Cj4+ICvCoMKgwqAgdWludDhfdCBwYWRbNTNdOwo+
PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZndfc2hhcmVkX211bHRpX3F1ZXVlIG11bHRpX3F1ZXVl
Owo+PiArfSBfX2F0dHJpYnV0ZV9fKChfX3BhY2tlZF9fKSk7Cj4+ICsKPj4gwqAgaW50IGFtZGdw
dV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+IMKgIGludCBhbWRn
cHVfdmNuX3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+PiDCoCBpbnQgYW1k
Z3B1X3Zjbl9zdXNwZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
