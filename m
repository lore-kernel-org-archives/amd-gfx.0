Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4298C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 11:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0DA2187F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 11:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s/tQLUT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0DA2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5412A6E90E;
	Wed, 15 Jan 2020 11:02:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F54A6E90E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 11:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFEr/soZMKwgONQGQAUAMrSNaSDSrrLFf/+GARWfboOyie114txmtPwd0fSq0fFANgfuzOOD/cOyuu4jFQyDwX6VXzYrseWnBsMUoBf4n9eHx/rcfut50rmCZtfW5OsE7jTF3FYTxfVJOyhhhUSW01h9FXMA7AQftMCYO8jnwqHGuw6wdhtaVVK7JiLfyvqEWuv4oXgS2vIbf2MGJ70TFL6oQyC7jV/mntslH2d9+hJfXmiex7tNupXguKcGyR7fI/yew1/1YMxZ+GE30uvgX8wNVoEOhwk/uxOywyMihdlE7vjFS5sGGYBTygE/fNOZLD+XbFsTOwg9rvjnixlJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSWGvqywdfubeo6FTbRZ7chUx6gHCLlEOYpgq3weGKA=;
 b=gkgOizaEbkQqql3y5agXLQV9Yyn6aMcT38djn06G/qmQIrsWHxnzB/r7zb3pVmP0aubxhemNEP2weROOve2dUyEozDhKqsmCJXev2aG1ex6tiI30oPgQHCrt95GsDYHiZOqd3MosSPRFibDeje/gfcbkZ15gzVDxqTyk66b5rscup41Dewy4wRB50ryBGuEanafGMWpVZ4aEudIK/lNN36Hwi2LKoOCSXBWJLB0bvHhe84gXIQ2BPT9SyKki4yipufjaoPF2d7o11eqp/ooEoljiyueLmqMjDbNBx7BLFW1rKGsuKYMNwyqf115elLM75b3DDQCLegYmHqfwoum1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSWGvqywdfubeo6FTbRZ7chUx6gHCLlEOYpgq3weGKA=;
 b=s/tQLUT3KLiTgn9fKesv8mSamGKkNYolSAIzUD/h2fXywyTzfmD2oEK1fs+y8KOvsonazUcgPf8S5uTdDlRKazXollJB8BmEVWaVKS01/xsu3RlvzqN7U3sGjoQVsHQPokwEQ3Zl+9xK56RL3/6drmKATJ/Uno7Y94F7GZs+8Cw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1786.namprd12.prod.outlook.com (10.175.91.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 11:02:50 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 11:02:50 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <862ad550-082d-7ece-1d4d-99801ab10428@amd.com>
Date: Wed, 15 Jan 2020 12:04:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0102CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::25) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2b:bb00:33a:7193:ff09:7830]
 (2003:c5:8f2b:bb00:33a:7193:ff09:7830) by
 AM0PR0102CA0048.eurprd01.prod.exchangelabs.com (2603:10a6:208::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 15 Jan 2020 11:02:37 +0000
X-Originating-IP: [2003:c5:8f2b:bb00:33a:7193:ff09:7830]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f7867d3-e960-4643-4023-08d799aa75e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:|DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1786E4F2E7693B29D80406708B370@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(16526019)(478600001)(186003)(6486002)(81166006)(31696002)(5660300002)(8676002)(316002)(6666004)(31686004)(81156014)(66946007)(52116002)(2616005)(4326008)(53546011)(66476007)(2906002)(36756003)(66556008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1786;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZfontPshSInM/biV3y8S1zcx23idn5vHoKUbqtZYOUo7t9BSW0IPtFcqJM+L+WGTm953ywYzPmRV82aoctq3rb7Y0tlO2fdQyp8/MbRvRY/RPMy5r9hrNc9R2esSidotmARmaYxh3Kr60hwLaANCShsQG49sPJXIu5nb81hdiZkSghiEO4YUHSvCpUECCrM54/+F5e8OUEUGsxYhvo4TLBFVvBPlyNT8rSXNof6E7DIpU4wE5Xz9i2684l/br1L+mqN117TIp7wpM6RAGqMafLzh/pvmBDjJTpqmwr0zbaNPLZYQX9GT+jMOGHjEuC0IsB/bpi8OrGK3b5suXpqJWmxMyvGL71OPJmcUb93gTDbATzUIYlFD85IEtAsRXTzGMm3izlVPW1MSaTTBjQZAURGAwgFJOIOulNLMwDxgwl+YlXUITeDzcereTzMzNUw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7867d3-e960-4643-4023-08d799aa75e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 11:02:49.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkllpe018FXiYVKOIGllvCrHjOkoPAEim3R707rIzjHsXVMUOXFeGN+5iyILkSApc5DvjifzOUQTeJQe9jTqRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMS8xNC8yMCA1OjAxIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3Rl
Ogo+Cj4+IEJlZm9yZSB0aGlzIHBhdGNoOgo+Pgo+PiBzY2hlZF9uYW1lwqDCoMKgwqAgbnVtIG9m
IG1hbnkgdGltZXMgaXQgZ290IHNjaGVkdWxlZAo+PiA9PT09PT09PT3CoMKgwqDCoMKgID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4gc2RtYTDCoMKgwqDCoMKgwqDCoMKgwqAg
MzE0Cj4+IHNkbWExwqDCoMKgwqDCoMKgwqDCoMKgIDMyCj4+IGNvbXBfMS4wLjDCoMKgwqDCoCA1
Ngo+PiBjb21wXzEuMS4wwqDCoMKgwqAgMAo+PiBjb21wXzEuMS4xwqDCoMKgwqAgMAo+PiBjb21w
XzEuMi4wwqDCoMKgwqAgMAo+PiBjb21wXzEuMi4xwqDCoMKgwqAgMAo+PiBjb21wXzEuMy4wwqDC
oMKgwqAgMAo+PiBjb21wXzEuMy4xwqDCoMKgwqAgMAo+Pgo+PiBBZnRlciB0aGlzIHBhdGNoOgo+
Pgo+PiBzY2hlZF9uYW1lwqDCoMKgwqAgbnVtIG9mIG1hbnkgdGltZXMgaXQgZ290IHNjaGVkdWxl
ZAo+PiA9PT09PT09PT3CoMKgwqDCoMKgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KPj4gwqAgc2RtYTHCoMKgwqDCoMKgwqDCoMKgwqAgMjQzCj4+IMKgIHNkbWEwwqDCoMKgwqDC
oMKgwqDCoMKgIDE2NAo+PiDCoCBjb21wXzEuMC4xwqDCoMKgwqAgMTQKPj4gwqAgY29tcF8xLjEu
MMKgwqDCoMKgIDExCj4+IMKgIGNvbXBfMS4xLjHCoMKgwqDCoCAxMAo+PiDCoCBjb21wXzEuMi4w
wqDCoMKgwqAgMTUKPj4gwqAgY29tcF8xLjIuMcKgwqDCoMKgIDE0Cj4+IMKgIGNvbXBfMS4zLjDC
oMKgwqDCoCAxMAo+PiDCoCBjb21wXzEuMy4xwqDCoMKgwqAgMTAKPgo+IFdlbGwgdGhhdCBpcyBz
dGlsbCByYXRoZXIgbmljZSB0byBoYXZlLCB3aHkgZG9lcyB0aGF0IGhhcHBlbj8KCkkgdGhpbmsg
SSBrbm93IHdoeSBpdCBoYXBwZW5zLiBBdCBpbml0IGFsbCBlbnRpdHkncyBycSBnZXRzIGFzc2ln
bmVkIHRvIApzY2hlZF9saXN0WzBdLiBJIHB1dCBzb21lIHByaW50cyB0byBjaGVjayB3aGF0IHdl
IGNvbXBhcmUgaW4gCmRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQuCgpJdCB0dXJucyBv
dXQgbW9zdCBvZiB0aGUgdGltZSBpdCBjb21wYXJlcyB6ZXJvIHZhbHVlcyhudW1fam9icygwKSA8
IAptaW5fam9icygwKSkgc28gbW9zdCBvZiB0aGUgdGltZSAxc3QgcnEoc2RtYTAsIGNvbXBfMS4w
LjApIHdhcyBwaWNrZWQgYnkgCmRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQuCgoKVGhp
cyBwYXRjaCB3YXMgbm90IGNvcnJlY3QgLCBoYWQgYW4gZXh0cmEgYXRvbWljX2luYyhudW1fam9i
cykgaW4gCmRybV9zY2hlZF9qb2JfaW5pdC4gVGhpcyBwcm9iYWJseSBhZGRlZCBiaXQgb2YgcmFu
ZG9tbmVzcyBJIHRoaW5rLCB3aGljaCAKaGVscGVkIGluIGJldHRlciBqb2IgZGlzdHJpYnV0aW9u
LgoKSSd2ZSB1cGRhdGVkIG15IHByZXZpb3VzIFJGQyBwYXRjaCB3aGljaCB1c2VzIHRpbWUgY29u
c3VtZWQgYnkgZWFjaCAKc2NoZWQgZm9yIGxvYWQgYmFsYW5jZSB3aXRoIGEgdHdpc3Qgb2YgaWdu
b3JpbmcgcHJldmlvdXNseSBzY2hlZHVsZWQgCnNjaGVkL3JxLiBMZXQgbWUga25vdyB3aGF0IGRv
IHlvdSB0aGluay4KCgpSZWdhcmRzLAoKTmlybW95Cgo+Cj4gQ2hyaXN0aWFuLgo+Cj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
