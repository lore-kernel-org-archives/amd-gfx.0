Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D888DC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A171206A3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A171206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585516E4FF;
	Tue, 12 Nov 2019 20:37:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770077.outbound.protection.outlook.com [40.107.77.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789466E4FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 20:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS1pbXTFodLysV0/ab8cXTB3NBAS+BlFgnatQLsoijspS2mBpACBGTw6HOOAkGtSuY+l47Ay/bVrfy6LAJjH1mpRVxFpGXz1Ttm6MgnbqHPWFdfinaNP8irdPyuEsGvZhR+fT2FEnSsfWfHOpUUnUAhDahQuWU3cYE+2/E5b3IRpCjYlamkdrmKui93Xg+2/RV6KDXb68EJ3J25JaSLaSKRMyfUiYbjSsMOQn9K3J+oxKwTKeyMR6Er1SJtMqsmhptcbixIfx7Ip2dpLgBjtcRUiCYZtI6zlncJbNYVRUrsiNvjkWCVfWOQ2PvHR4kOI4BxyvDMMg+9KeUT157AZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYvwx74qwQDiLwtP2NiCOiyTcmJX4GFltPg4FF5pwmA=;
 b=d9MEZ5DhXtMKmhrS7M9RZsLAv2I8UHReeA6fqsod8vh2QF/7emZlyNhW2y63lhCSnY0j5ly/aK9qtk7DGrpUUayAbpKI2PMYUEwcvB7MUy+ht1tkjrpvH3TRtz+4bQYonk7lNYFGddnOCrK9ft5khWGkYki4p90Pig2cWNV6FvxepHB+pqo7uIt1qLW5qj2Y0KVrkUudoIGdxlJKfNGHbFFolJIimpj9yUu2jOtTBd+NZffax5WcRG+YhMm6pXKWOLf2HtwPnwpq7Q0jzvY5qLltnwoPhq4WEfsB7qq+jEFTrAg9qmjirttm4ZsS4w5UCoWgAC/cleVKlejSJVUCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1532.namprd12.prod.outlook.com (10.172.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 20:37:29 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 20:37:29 +0000
Subject: Re: [PATCH 00/21] Separate JPEG from VCN
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <CADnq5_NVBemrfE5OB=NBeb5XM5HPWdnhjaWM0KjdDyb6+pm9zA@mail.gmail.com>
 <171a5818-a2b5-6e91-ac35-050b43963988@amd.com>
 <CADnq5_MRfvfE1D5SPOWTyWZFnLZezZ3N61QXvrwnLFssM++LrA@mail.gmail.com>
 <bf523547-408a-536d-5f61-226691058a7b@amd.com>
 <CADnq5_NjNPZC=2xt5Qft6_jiZnbdtR+LqogTWdfty_N_zWR_uA@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <524ed49b-1f55-eb6d-3903-81964b33baac@amd.com>
Date: Tue, 12 Nov 2019 15:37:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
In-Reply-To: <CADnq5_NjNPZC=2xt5Qft6_jiZnbdtR+LqogTWdfty_N_zWR_uA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3622ad66-afb8-4b51-93eb-08d767b02301
X-MS-TrafficTypeDiagnostic: DM5PR12MB1532:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR12MB1532848DFA2AE540DBDDB1EEE5770@DM5PR12MB1532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(81156014)(36756003)(6246003)(31686004)(44832011)(486006)(1411001)(8676002)(3846002)(66476007)(66556008)(66946007)(81166006)(4001150100001)(50466002)(65956001)(65806001)(66066001)(47776003)(2906002)(2870700001)(6116002)(26005)(966005)(8936002)(6486002)(6436002)(6512007)(6916009)(229853002)(478600001)(186003)(7736002)(36916002)(316002)(2486003)(58126008)(23676004)(11346002)(25786009)(305945005)(99286004)(52116002)(446003)(76176011)(86362001)(31696002)(53546011)(476003)(2616005)(14454004)(6506007)(386003)(4326008)(5660300002)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1532;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YqPwAJU1o+SIVD7V2v2jG4QJkcpLJEOS1bEhyhWPw9rNHjiVlt7phhFerzkS2ku0RaSiIAmnc5w3v+dBbX8BMUVBe2D+xWo14tsySVQy/ASHpE2QoON6K9Sv8Nr5l8mc0FhMQhO1GsFf0YYWHDKhWN38IFpva1opPoGBPv8gIRV6PswGNkIyVvpNRr99yd3/+kc7PMWVVfLp01HGIzOyaA98g6XQZOOpA/Amwiwm3oj1zCtYFGVsfNP5unKSOogcfS9uJmuUTqbhWPxTL7VHSKPeCXdYeeCsnY5a03RZ3A9wpw04zwum+AKn/TeRr1JW9atXcce7iSIyBK+SKtC7ksrquW3EqnY67XSMoLs/GHu3Z/t/Y9ta1W6dDXp8g63j0bkouYqyhM+TDPZqEEon97YS5RyIKgKpjAXjAxyADDNPIf8pznkFmjj3Jch3QcQvytuVVs8Nlxyyo7qvdcxLCtR9hAWjm3xL4v33kgVZ9Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3622ad66-afb8-4b51-93eb-08d767b02301
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 20:37:29.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I+dj5rMa9VTVPKywHAe8x2VjB3XBgOdr9x18iu4GuZOWnrTKUsV+iHChFmw2WPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1532
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYvwx74qwQDiLwtP2NiCOiyTcmJX4GFltPg4FF5pwmA=;
 b=z7JCAo1hjMDda19NzQbONclQH7RzC2gge0/Y+IKzfJIe4z6Hq+03jAVZb0CuRuTmuvard7tDYfvWJtmu2+JOvJUjha5sr9QDieqZ3BQ8CHT7k4jcOp6j+WMBTA2OH1uKpjMG84GXXmyJNcUQjfF1a+8oXzaXYnkGGcIPFQXuwqM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112203728.idbn11jdZtPYQJX-46Tz1Z9r4cVq7Vz4TZbr_jNFRAY@z>

Ck9uIDIwMTktMTEtMTIgMzozNCBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gVHVlLCBO
b3YgMTIsIDIwMTkgYXQgMzoxNiBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+IHdyb3RlOgo+
Pgo+PiBPbiAyMDE5LTExLTEyIDM6MTIgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4gT24g
VHVlLCBOb3YgMTIsIDIwMTkgYXQgMjo1NyBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+IHdy
b3RlOgo+Pj4+IE9uIDIwMTktMTEtMTIgMjo0OSBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+
Pj4+IE9uIFR1ZSwgTm92IDEyLCAyMDE5IGF0IDE6MDMgUE0gTGVvIExpdSA8bGVvLmxpdUBhbWQu
Y29tPiB3cm90ZToKPj4+Pj4+ICAgIEZyb20gSlBFRzIuMCwgSlBFRyBpcyBhIHNlcGFyYXRlZCBJ
UCBibG9jaywgYW5kIGhhcyBpdCBvd24gUEcvQ0csCj4+Pj4+PiBhbmQgcG93ZXIgbWFuYWdlbWVu
dC4gSXQgZG9lc24ndCByZXF1aXJlIEZXLCBzbyBpbmRlcGVkZW50IGZyb20gRlcKPj4+Pj4+IGxv
YWRpbmcgYXMgd2VsbC4KPj4+Pj4+Cj4+Pj4+PiBQYXRjaCAxLTQ6IFNlcGFyYXRlIEpQRUcxLjAg
ZnJvbSBTVyB3aXNlLCBzaW5jZSBKUEVHMS4wIGlzIHN0aWxsCj4+Pj4+PiBjb21iaW5lZCB3aXRo
IFZDTjEuMCBlc3AuIGluIHBvd2VyIG1hbmFnZW1lbnQ7Cj4+Pj4+PiBQYXRjaCA1LTEwOiBTZXBh
cmF0ZSBKUEVHMi4wIGFzIGFuIGluZGVwZW5kZW50IElQIHdpdGggUEcvQ0c7Cj4+Pj4+PiBQYXRj
aCAxMS0xNTogQWRkIHBvd2VyIG1hbmFnZW1lbnQgZm9yIEpQRUcgb2YgTmF2aTF4IGFuZCBSZW5v
aXI7Cj4+Pj4+PiBQYXRjaCAxNjogRW5hYmxlIEpQRUcyLjA7Cj4+Pj4+PiBQYXRjaCAxNy0yMDog
U2VwYXJhdGUgSlBFRzIuNSBmcm9tIFZDTjIuNTsKPj4+Pj4+IFBhdGNoIDIxOiBFbmFibGUgSlBF
RzIuNQo+Pj4+Pj4KPj4+Pj4gSXMgdGhlIGpwZWcgcG93ZXJnYXRpbmcgZHluYW1pYyBvciBkbyB3
ZSBuZWVkIGEgaWRsZSB3b3JrIHRocmVhZCB0bwo+Pj4+PiB0dXJuIGl0IG9mZiBsaWtlIHdlIGRv
IGZvciB2Y24/Cj4+Pj4gSXQgaGFzIHN0YXRpYyBQRy9DRyBmb3IgSlBFRzIuMCBhbmQgc3RhdGlj
IENHIGZvciBKUEVHMi41Lgo+Pj4+Cj4+Pj4gSXQgYWxzbyBoYXMgRFBNIGZvciBKUEVHMi4wLiBT
byB3ZSBuZWVkIGlkbGUgd29yayB0aHJlYWQgYW5kIGJlZ2luX3VzZQo+Pj4+IGxpa2UgVkNOIHRv
IGluaXQvZGVpbml0IEpQRUcgYW5kIHR1cm4gb24vb2ZmIEpQRUcgcG93ZXIgdGhyb3VnaCBTTVUK
Pj4+PiBtZXNzYWdlcyBzdWNoIGFzIFBvd2VyVVBKcGVnIGFuZCBQb3dlckRvd25KcGVnLgo+Pj4g
T2ssIHNvIHRoYXQgc3RpbGwgaGFzIHRvIGJlIGltcGxlbWVudGVkIHRoZW4uICBJIGRpZG4ndCBz
ZWUgdGhhdCBpbgo+Pj4gdGhlIHBhdGNoIHNldC4KPj4gImFtZGdwdV9qcGVnX2lkbGVfd29ya19o
YW5kbGVyIiBpcyBpbiBwYXRjaCA2LCBhbmQgY2FsbGluZyB0aG9zZSBTTVUgbWVzc2FnZXMgYXJl
IGluIHRob3NlIHBvd2VycGxheSBwYXRjaGVzLgo+Pgo+PiBUaGUgc2V0IGlzIGNvbXBsZXRlIGZv
ciBhbGwgSlBFR3MKPiBBaCwgeWVhaCwgSSBtaXNzZWQgdGhhdCBwYXRjaCB0aGUgZmlyc3QgdGlt
ZSBhcm91bmQuICBUaGFua3MhCgpZZWFoLCB0aGUgc2V0IGlzIHRvbyBiaWcuIFNvcnJ5IGFib3V0
IHRoYXQuIFNob3VsZCBkbyB0aGlzIGNoYW5nZXMgCmVhcmxpZXIswqAgYnV0IGp1c3QgZ2V0IGFy
b3VuZCB0byBpdDotKQoKTGVvCgoKPgo+IEFsZXgKPgo+PiBUaGFua3MsCj4+IExlbwo+Pgo+Pgo+
Pj4gVGhhbmtzLAo+Pj4KPj4+IEFsZXgKPj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+IExlbwo+Pj4+Cj4+
Pj4KPj4+Pj4gQWxleAo+Pj4+Pgo+Pj4+Pj4gTGVvIExpdSAoMjEpOgo+Pj4+Pj4gICAgICBkcm0v
YW1kZ3B1OiBhZGQgSlBFRyBIVyBJUCBhbmQgU1cgc3RydWN0dXJlcwo+Pj4+Pj4gICAgICBkcm0v
YW1kZ3B1OiBhZGQgYW1kZ3B1X2pwZWcgYW5kIEpQRUcgdGVzdHMKPj4+Pj4+ICAgICAgZHJtL2Ft
ZGdwdTogc2VwYXJhdGUgSlBFRzEuMCBjb2RlIG91dCBmcm9tIFZDTjEuMAo+Pj4+Pj4gICAgICBk
cm0vYW1kZ3B1OiB1c2UgdGhlIEpQRUcgc3RydWN0dXJlIGZvciBnZW5lcmFsIGRyaXZlciBzdXBw
b3J0Cj4+Pj4+PiAgICAgIGRybS9hbWRncHU6IGFkZCBKUEVHIElQIGJsb2NrIHR5cGUKPj4+Pj4+
ICAgICAgZHJtL2FtZGdwdTogYWRkIEpQRUcgY29tbW9uIGZ1bmN0aW9ucyB0byBhbWRncHVfanBl
Zwo+Pj4+Pj4gICAgICBkcm0vYW1kZ3B1OiBhZGQgSlBFRyB2Mi4wIGZ1bmN0aW9uIHN1cHBvcnRz
Cj4+Pj4+PiAgICAgIGRybS9hbWRncHU6IHJlbW92ZSB1bm5lY2Vzc2FyeSBKUEVHMi4wIGNvZGUg
ZnJvbSBWQ04yLjAKPj4+Pj4+ICAgICAgZHJtL2FtZGdwdTogYWRkIEpQRUcgUEcgYW5kIENHIGlu
dGVyZmFjZQo+Pj4+Pj4gICAgICBkcm0vYW1kZ3B1OiBhZGQgUEcgYW5kIENHIGZvciBKUEVHMi4w
Cj4+Pj4+PiAgICAgIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBQb3dlcnBsYXkgaW50ZXJm
YWNlCj4+Pj4+PiAgICAgIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBwb3dlciBjb250cm9s
IGZvciBOYXZpMXgKPj4+Pj4+ICAgICAgZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBQb3dlcmdhdGUg
SlBFRyBmb3IgUmVub2lyCj4+Pj4+PiAgICAgIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBw
b3dlciBjb250cm9sIGZvciBSZW5vaXIKPj4+Pj4+ICAgICAgZHJtL2FtZC9wb3dlcnBsYXk6IHNl
dCBKUEVHIHRvIFNNVSBkcG0KPj4+Pj4+ICAgICAgZHJtL2FtZGdwdTogZW5hYmxlIEpQRUcyLjAg
ZHBtCj4+Pj4+PiAgICAgIGRybS9hbWRncHU6IGFkZCBkcml2ZXIgc3VwcG9ydCBmb3IgSlBFRzIu
MCBhbmQgYWJvdmUKPj4+Pj4+ICAgICAgZHJtL2FtZGdwdTogZW5hYmxlIEpQRUcyLjAgZm9yIE5h
dmkxeCBhbmQgUmVub2lyCj4+Pj4+PiAgICAgIGRybS9hbWRncHU6IG1vdmUgSlBFRzIuNSBvdXQg
ZnJvbSBWQ04yLjUKPj4+Pj4+ICAgICAgZHJtL2FtZGdwdTogZW5hYmxlIEFyY3R1cnVzIENHIGZv
ciBWQ04gYW5kIEpQRUcgYmxvY2tzCj4+Pj4+PiAgICAgIGRybS9hbWRncHU6IGVuYWJsZSBBcmN0
dXJ1cyBKUEVHMi41IGJsb2NrCj4+Pj4+Pgo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L01ha2VmaWxlICAgICAgICAgICB8ICAgOCArLQo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICAgICB8ICAgNSArCj4+Pj4+PiAgICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jICAgICAgIHwgICA0ICstCj4+Pj4+
PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgICAy
ICsKPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jICAg
ICAgfCAyMTUgKysrKysKPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfanBlZy5oICAgICAgfCAgNjIgKysKPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMgICAgICAgfCAgMTUgKy0KPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyAgICAgICAgfCAgIDggKwo+Pj4+Pj4gICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5oICAgICAgICB8ICAgMSArCj4+Pj4+PiAg
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jICAgICAgIHwgMTEzICst
LQo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCAgICAg
ICB8ICAgNSAtCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192MV8w
LmMgICAgICAgIHwgNTg0ICsrKysrKysrKysrKysKPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9qcGVnX3YxXzAuaCAgICAgICAgfCAgMzIgKwo+Pj4+Pj4gICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jICAgICAgICB8IDgyNyArKysrKysrKysrKysr
KysrKysKPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuaCAg
ICAgICAgfCAgNDIgKwo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdf
djJfNS5jICAgICAgICB8IDY0MSArKysrKysrKysrKysrKwo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5oICAgICAgICB8ICAyOSArCj4+Pj4+PiAgICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyAgICAgICAgICAgICAgIHwgIDExICstCj4+Pj4+
PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyAgICAgICAgICAgIHwgIDEw
ICstCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyAgICAg
ICAgIHwgNDgxICstLS0tLS0tLS0KPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjJfMC5jICAgICAgICAgfCA0OTYgKy0tLS0tLS0tLS0KPj4+Pj4+ICAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5oICAgICAgICAgfCAgMTMgLQo+Pj4+Pj4gICAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgICAgICAgICB8IDI0NiArLS0t
LS0KPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oICAg
ICAgfCAgIDUgKy0KPj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMgICAgfCAgIDUgKwo+Pj4+Pj4gICAgIC4uLi9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aW5jL2FtZGdwdV9zbXUuaCAgICB8ICAgMyArCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaW5jL3NtdV92MTJfMC5oIHwgICAyICsKPj4+Pj4+ICAgICBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgICAgfCAgMzIgKy0KPj4+Pj4+ICAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgICAgfCAgMjcgKwo+Pj4+
Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV9pbnRlcm5hbC5oICB8ICAg
NCArCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMg
ICAgIHwgIDExICsKPj4+Pj4+ICAgICAzMSBmaWxlcyBjaGFuZ2VkLCAyNTkzIGluc2VydGlvbnMo
KyksIDEzNDYgZGVsZXRpb25zKC0pCj4+Pj4+PiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMKPj4+Pj4+ICAgICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuaAo+Pj4+Pj4g
ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Yx
XzAuYwo+Pj4+Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3YxXzAuaAo+Pj4+Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYwo+Pj4+Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuaAo+Pj4+Pj4gICAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzUuYwo+Pj4+
Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVn
X3YyXzUuaAo+Pj4+Pj4KPj4+Pj4+IC0tCj4+Pj4+PiAyLjE3LjEKPj4+Pj4+Cj4+Pj4+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+Pj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
