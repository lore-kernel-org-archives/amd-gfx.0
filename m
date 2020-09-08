Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A49AC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 05:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C6C21532
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 05:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EOtYzvKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C6C21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62176E0AA;
	Tue,  8 Sep 2020 05:04:58 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03946E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 05:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IizyeoWeII02G4prAj/3eLlDuN2cfxK2MF/hxvPWpn/l2EEKXYlhG1bEV/1l9eqE5E/T9+PWj1kMvrfy1jLyQwTvd2/Yo/uQDAQ+AL9wUXgonH+2HL+DMSvf55v1OW0wQFx8/Pjkh3e+DxXG2X7YNTK1GbK8y02hXwI1e835bLh5UsMyhknUIZK3yP3ic/YzUruSIHqIIPWDF3IA++gQOpWb2hBX605f58K35Jj2C0A3GbffJR2IbVYSrXjcGzsapEflztdSUL3rxgXu7wIcjUS8dCxY9OTIKjoV5iTaXRD7N7z2Phj1y34EHje/mzNzW0iSMHg7HEZOpQKHRrox4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo8GPB7NI8zwb7OUOYEwWDsqusUFcUEPr/FCmIQl0WI=;
 b=cKkUdjuypA7EWKRcFfUdzPj3cReDCwt7V+utV1UI40P+KHjP/XaBom5l9yLyR4QjT8oWuTkpoyyxx/suBd9hnP5KlGnvWhUWcoozhumYB37AxLRV1nv8Zk6tv7oxncoohj+N9bfDXg6Mw6TSjaFQUxUDFDDweoUBS/Z7zEcvwLMP0wHj0Eg/RdKLCKTtxVx6V1OPJrN1gfVY2AtbJS6OJraYszXotjzISAHkoYxc7XYuDuiPtjx4s3XNFDzEnqahHp8TXGTSpMQ3s5yVp14195+9Okz7f/xYyM9XWzZRsWCTJs3cBYVmIXI3dCigCiNtid8/zChAbKbsofZnL6DxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo8GPB7NI8zwb7OUOYEwWDsqusUFcUEPr/FCmIQl0WI=;
 b=EOtYzvKdCUhah9fiOtZ5YIIQQL/fxkVMQDK749/zBReKTHItsuKqey4OLNif+k7RKaoqnQq2C2PnA4IlZ26Uq0GV5IAiLYDb2GksPzH7OPVztJjcJsAsolMowZVEEK+0fQvKcPoG3sFizJwUzPjSwJM3v/Qi6MlwJXN7JMWyCMk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 05:04:54 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 05:04:54 +0000
Subject: Re: [PATCH v2] drm/kfd: fix a system crash issue during GPU recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, christian.koenig@amd.com
References: <20200902050226.7968-1-Dennis.Li@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cec71c3a-1665-3a73-f395-b65b6c1e196c@amd.com>
Date: Tue, 8 Sep 2020 01:04:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200902050226.7968-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 8 Sep 2020 05:04:53 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17bcdd8b-3f5b-4776-d407-08d853b4b965
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB268795259D67E87AD5A4BB0892290@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UeG0NQeolKX1/Pp2Z/lPt0u5jD3S+3k5RP1IvP3BqldjgZscpz9rBEZSJwyRWWP0sKenZW7GThjjNmiXPpx/nCzIDl1JPJdpTsYbw/2Z5OvMrlBnCCfNIxnkuZULvvDJcXRq/Jt8aa7Ef0HHv4Io288RUH8kvzyJYVueXSZhQh961USZFAl2crkbDI0sBF+wv/pnrlGF4mZOXcqNqaXikco4dR/DNKCw5U9Ay2AJ1OnU+MBB6K0vs0sl/Raa/Qxo3frxLCLfdfp8QQeco3XusrHK8EZpXLFwiD9QlMw5ERGUg2G7tAm4fDKb+6C97jvnSmtNcFQKgAT9h2rhOw+VJNOi5gfpXmTM4jobabm1ffnbw9LZwcqTcsV6A+O6C7R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(6486002)(44832011)(86362001)(316002)(31696002)(83380400001)(2616005)(478600001)(956004)(31686004)(8676002)(52116002)(8936002)(5660300002)(2906002)(16576012)(36756003)(26005)(66476007)(66556008)(6636002)(66946007)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hqWu5pgvst1TK7P9jI4zPLY6oLqytqmyybkP2qj8OskfkaFti4H9N3UqmXtoeRN8S4psfGBAZqdBgSZhJGLOxSYEhCG95lA7kr0z+l/0C4/V9EyWoQVl+ThOaQ2lOLq6x/byH5AJIGuRjJT3fxihMgjWtxHMgUIBkm86GEnT/Z8Eu0fyU0dgdTePGrNIdEH4BamA4wQlpEDcvcOyhX7uyDh8m940TzG59o2gd+/dfZd0BOM6OvPU6WTDtbFarm3//L963sTFgfhAcqM+Qb0eK7Rg8eOWKUwSvDDQNbKEnNRUjEdXBfUKpC9WomLWDWJAGd4PeP1U/M2GyX2/lZe3L34LZygPih1s6fBOUcst3MEuZPMjw5xvPLnr/G6ti9HDXYyHAjChlBc+uZc/tNTr29NEUBzPmzhdVyLly2ZlTW+x6Tjya4F4aJlBoG//Lj9Zutixn51KnFrM4OLJA03jbl6pM2XxqwiGb+AlOh4ePhdSA0iAkCLdbSa7S87JNQECxomVrO8czOPANsegxP+UoqqBdi7rKGFFrWUE9pLrhFyFSSJyi06C9/5ELKH4VqMdQiVwBXNxibj3cz1HqRBWO+WMRDN9whxto2QGskHo9vg29t4p4htL8X3Kt/SXQKUOGXse8bTEn9CdErq+E8qbvg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bcdd8b-3f5b-4776-d407-08d853b4b965
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 05:04:54.4501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v677xcd4qP34NEs2JEQRYUa9QVkt1PYoqmT5QhVG+VieGj1Csgb+KEgWUl9hSkr44g7pLZh5tAEIbLKuSfVbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
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

QW0gMjAyMC0wOS0wMiB1bSAxOjAyIGEubS4gc2NocmllYiBEZW5uaXMgTGk6Cj4gVGhlIGNyYXNo
IGxvZyBhcyB0aGUgYmVsb3c6Cj4KPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBnZW5lcmFs
IHByb3RlY3Rpb24gZmF1bHQ6IDAwMDAgWyMxXSBTTVAgTk9QVEkKPiBbVGh1IEF1ZyAyMCAyMzox
ODoxNCAyMDIwXSBDUFU6IDE1MiBQSUQ6IDE4MzcgQ29tbToga3dvcmtlci8xNTI6MSBUYWludGVk
OiBHICAgICAgICAgICBPRSAgICAgNS40LjAtNDItZ2VuZXJpYyAjNDZ+MTguMDQuMS1VYnVudHUK
PiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBIYXJkd2FyZSBuYW1lOiBHSUdBQllURSBHNDgy
LVo1My1ZRi9NWjUyLUc0MC0wMCwgQklPUyBSMTIgMDUvMTMvMjAyMAo+IFtUaHUgQXVnIDIwIDIz
OjE4OjE0IDIwMjBdIFdvcmtxdWV1ZTogZXZlbnRzIGFtZGdwdV9yYXNfZG9fcmVjb3ZlcnkgW2Ft
ZGdwdV0KPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBSSVA6IDAwMTA6ZXZpY3RfcHJvY2Vz
c19xdWV1ZXNfY3BzY2grMHhjOS8weDEzMCBbYW1kZ3B1XQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0
IDIwMjBdIENvZGU6IDQ5IDhkIDRkIDEwIDQ4IDM5IGM4IDc1IDIxIGViIDQ0IDgzIGZhIDAzIDc0
IDM2IDgwIDc4IDcyIDAwIDc0IDBjIDgzIGFiIDY4IDAxIDAwIDAwIDAxIDQxIGM2IDQ1IDQxIDAw
IDQ4IDhiIDAwIDQ4IDM5IGM4IDc0IDI1IDw4MD4gNzggNzAgMDAgYzYgNDAgNmQgMDEgNzQgZWUg
OGIgNTAgMjggYzYgNDAgNzAgMDAgODMgYWIgNjAgMDEgMDAKPiBbVGh1IEF1ZyAyMCAyMzoxODox
NCAyMDIwXSBSU1A6IDAwMTg6ZmZmZmIyOWI1MmY2ZmM5MCBFRkxBR1M6IDAwMDEwMjEzCj4gW1Ro
dSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gUkFYOiAxYzg4NGVkYjBhMTE4OTE0IFJCWDogZmZmZjhh
MGQ0NWZmM2MwMCBSQ1g6IGZmZmY4YTJkODNlNDEwMzgKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAy
MDIwXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMDgyIFJESTogZmZm
ZjhhMGUyZTQxNzhjMAo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIFJCUDogZmZmZmIyOWI1
MmY2ZmNiMCBSMDg6IDAwMDAwMDAwMDAwMDFiNjQgUjA5OiAwMDAwMDAwMDAwMDAwMDA0Cj4gW1Ro
dSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gUjEwOiBmZmZmYjI5YjUyZjZmYjc4IFIxMTogMDAwMDAw
MDAwMDAwMDAwMSBSMTI6IGZmZmY4YTBkNDVmZjNkMjgKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAy
MDIwXSBSMTM6IGZmZmY4YTJkODNlNDEwMjggUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAw
MDAwMDAwMDAwMDAwMAo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIEZTOiAgMDAwMDAwMDAw
MDAwMDAwMCgwMDAwKSBHUzpmZmZmOGEwZTJlNDAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAw
MDAwMDAKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0g
Q1IyOiAwMDAwNTVjNzgzYzBlNmE4IENSMzogMDAwMDAwMzRhMTI4NDAwMCBDUjQ6IDAwMDAwMDAw
MDAzNDBlZTAKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBDYWxsIFRyYWNlOgo+IFtUaHUg
QXVnIDIwIDIzOjE4OjE0IDIwMjBdICBrZmRfcHJvY2Vzc19ldmljdF9xdWV1ZXMrMHg0My8weGQw
IFthbWRncHVdCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gIGtmZF9zdXNwZW5kX2FsbF9w
cm9jZXNzZXMrMHg2MC8weGYwIFthbWRncHVdCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0g
IGtnZDJrZmRfc3VzcGVuZC5wYXJ0LjcrMHg0My8weDUwIFthbWRncHVdCj4gW1RodSBBdWcgMjAg
MjM6MTg6MTQgMjAyMF0gIGtnZDJrZmRfcHJlX3Jlc2V0KzB4NDYvMHg2MCBbYW1kZ3B1XQo+IFtU
aHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdICBhbWRncHVfYW1ka2ZkX3ByZV9yZXNldCsweDFhLzB4
MjAgW2FtZGdwdV0KPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSAgYW1kZ3B1X2RldmljZV9n
cHVfcmVjb3ZlcisweDM3Ny8weGY5MCBbYW1kZ3B1XQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIw
MjBdICA/IGFtZGdwdV9yYXNfZXJyb3JfcXVlcnkrMHgxYjgvMHgyYTAgW2FtZGdwdV0KPiBbVGh1
IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSAgYW1kZ3B1X3Jhc19kb19yZWNvdmVyeSsweDE1OS8weDE5
MCBbYW1kZ3B1XQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdICBwcm9jZXNzX29uZV93b3Jr
KzB4MjBmLzB4NDAwCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gIHdvcmtlcl90aHJlYWQr
MHgzNC8weDQxMAo+Cj4gV2hlbiBHUFUgaGFuZywgdXNlciBwcm9jZXNzIHdpbGwgZmFpbCB0byBj
cmVhdGUgYSBjb21wdXRlIHF1ZXVlIHdob3NlCj4gc3RydWN0IG9iamVjdCB3aWxsIGJlIGZyZWVk
IGxhdGVyLCBidXQgZHJpdmVyIHdyb25nbHkgYWRkIHRoaXMgcXVldWUgdG8KPiBxdWV1ZSBsaXN0
IG9mIHRoZSBwcm9jY2Vzcy4gQW5kIHRoZW4ga2ZkX3Byb2Nlc3NfZXZpY3RfcXVldWVzIHdpbGwK
PiBhY2Nlc3MgYSBmcmVlZCBtZW1vcnksIHdoaWNoIGNhdXNlIGEgc3lzdGVtIGNyYXNoLgo+Cj4g
djI6Cj4gVGhlIGZhaWx1cmUgdG8gZXhlY3V0ZV9xdWV1ZXMgc2hvdWxkIHByb2JhYmx5IG5vdCBi
ZSByZXBvcnRlZCB0bwo+IHRoZSBjYWxsZXIgb2YgY3JlYXRlX3F1ZXVlLCBiZWNhdXNlIHRoZSBx
dWV1ZSB3YXMgYWxyZWFkeSBjcmVhdGVkLgoKLi4uIGFuZCB0aGUgZmFpbHVyZSBhZmZlY3RzIGFs
bCBwcm9jZXNzZXMgaW4gdGhlIHJ1bmxpc3QuCgpXaXRoIHRoYXQgYWRkZWQgc3RhdGVtZW50LCB0
aGUgcGF0Y2ggaXMKClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KCkEgZm9sbG93IHVwIHBhdGNoIHdpbGwgYmUgbmVlZGVkIHRvIGhhbmRsZSBhbGwg
ZXJyb3Igc2NlbmFyaW9zIGluc2lkZQpleGVjdXRlX3F1ZXVlc19jcHNjaCBhbmQgbWFrZSB0aGF0
IGZ1bmN0aW9uIHJldHVybiB2b2lkLiBDdXJyZW50bHkgaXQKb25seSBoYW5kbGVzIHByb2JsZW1z
IGluIHVubWFwX3F1ZXVlcyAodHJpZ2dlcnMgYSBHUFUgcmVzZXQgaW4gY2FzZSBvZiBhCmhhbmcp
LiBtYXBfcXVldWVzIGNhbiBmYWlsIGluIG91dC1vZi1tZW1vcnkgc2NlbmFyaW9zLiBUaGUgYmVz
dCB3ZSBjYW4KZG8gaXMgdG8gcmVwb3J0IHRoaXMgYXMgYW4gYXN5bmNocm9ub3VzIEdQVSBoYW5n
IGV2ZW50IHRvIGFsbCB1c2VyIG1vZGUKcHJvY2Vzc2VzIGFmZmVjdGVkIGJ5IHRoaXMgZmFpbHVy
ZSAobm90IGp1c3QgdGhlIGNhbGxlciBvZiBjcmVhdGVfcXVldWUKaW4gdGhpcyBleGFtcGxlKS4K
ClJlZ2FyZHMsCsKgIEZlbGl4Cgo+IFRoZXJlZm9yZSBjaGFuZ2UgdG8gaWdub3JlIHRoZSByZXR1
cm4gdmFsdWUgZnJvbSBleGVjdXRlX3F1ZXVlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBM
aSA8RGVubmlzLkxpQGFtZC5jb20+Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IGluZGV4IDU2MGFkYzU3YTA1MC4u
MDY5YmE0YmUxZThmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBAQCAtMTMwMiw3ICsxMzAyLDcgQEAgc3Rh
dGljIGludCBjcmVhdGVfcXVldWVfY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpk
cW0sIHN0cnVjdCBxdWV1ZSAqcSwKPiAgCWlmIChxLT5wcm9wZXJ0aWVzLmlzX2FjdGl2ZSkgewo+
ICAJCWluY3JlbWVudF9xdWV1ZV9jb3VudChkcW0sIHEtPnByb3BlcnRpZXMudHlwZSk7Cj4gIAo+
IC0JCXJldHZhbCA9IGV4ZWN1dGVfcXVldWVzX2Nwc2NoKGRxbSwKPiArCQlleGVjdXRlX3F1ZXVl
c19jcHNjaChkcW0sCj4gIAkJCQlLRkRfVU5NQVBfUVVFVUVTX0ZJTFRFUl9EWU5BTUlDX1FVRVVF
UywgMCk7Cj4gIAl9Cj4gIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
