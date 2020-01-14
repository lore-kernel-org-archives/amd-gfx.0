Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F00C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B064A24656
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UHn7d+Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B064A24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682B26E430;
	Tue, 14 Jan 2020 16:34:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049796E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 16:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsDmLuVC+oqlbiXdQabXMUqXwI7E9CnQkv9CVd7ttWuRMuRyOfp1HSyMm3RKtFMK3s03lN4LdJTTlsORzDnrk0N7AWtEMWPC4txPJoKAUAKekqHneDrvz6TyfDAHPVQEsM/tqEPl3wi1pH4VDQGBkzPZYHgZRo1vlt0uMsZtgFQZbNG+PyXQWy33+U+ChGRtJdF9lGO2PCH/02wsNNqrtHyyy90sgMm+p1f2Lgck4vHMlsZ0BwrLuXWekGOZUv8spaoR+H3zU1ZKtGSdI03qXCuzQXPQg0q8RFwde+VBsxkTru5zP+CQcLGHi+7/Mz5f2Psl1yFz13yyqFetjJMfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k0kfr3J+g6m4yRvjcUumDrBH3a2O5XIqW7/sGVereg=;
 b=bLwbymHjAGQZp1pcgi3Pim7mDlr+Rh557lny3p47/CHgTz4oJGfpvjFrFqa9sar6fy02ssS8kHGoJHr4vCusIdtXfwpmGZDX+AQeGet4Erb0uat0eD3WFzmP5H6ez+2CLW7xCRLAGzqDhzh3SZzGc8F/obvGMZqvObACwwcWxK81qtTSNT4IHWRCt0nEygBRrU2fjXVtn29r4yG9p9YWCHCUmKNsc8iOjdmYCO3kIikoZ/9b6FZwfAdLJOjoiKAyMUhmB95UxQNad23NewCsHu1oo9CBoobpdX66yolGvqyJlottUx7kmb5HjY86S6EZP9VPV4cV2y63wt6DTc315g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k0kfr3J+g6m4yRvjcUumDrBH3a2O5XIqW7/sGVereg=;
 b=UHn7d+Gf3WibSnjlOd6iF9JdpAQQlWF6aWdECg74EibL34Tu8fj1KO9FqG0MObW/kTKk5crYvcTJiW+tjguECfvh0eD8fdtbPLnqyafMsExOR1oZ952Fc8gI++xyK0AKLmcp5t4idQvxZpAXCGcqnDLavG6KM/C+4lJSefn1BLw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2566.namprd12.prod.outlook.com (52.132.141.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Tue, 14 Jan 2020 16:20:25 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 16:20:25 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
 <529f8218-09f4-cb67-7bc0-18a1a808bff6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ac0b01a8-f360-41ba-568f-74e10fe95ecd@amd.com>
Date: Tue, 14 Jan 2020 17:20:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <529f8218-09f4-cb67-7bc0-18a1a808bff6@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0080.eurprd07.prod.outlook.com
 (2603:10a6:207:6::14) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0080.eurprd07.prod.outlook.com (2603:10a6:207:6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5 via Frontend Transport; Tue, 14 Jan 2020 16:20:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ed37ffa-19af-4670-2670-08d7990da95d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:|DM5PR12MB2566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25665A8F87FF95FF866DC12583340@DM5PR12MB2566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(2906002)(86362001)(8676002)(8936002)(66574012)(31696002)(6666004)(186003)(2616005)(81166006)(81156014)(16526019)(316002)(6486002)(31686004)(110136005)(4326008)(5660300002)(36756003)(53546011)(66556008)(52116002)(66946007)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2566;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36sGtdqmkJv1CJIOAr3beZwqRBfwHM/bkzIjZkpIJD4kx9UAX5nLJkcju7S0ct+hairiTZE7IHj1lusRNTQKm17TAF3sWm0zD7ZDAXbl5xnB3pQwA1fyyW2n7kvaamQXGh7xY4IK3pofged2b0AzKm5q00mMPOHfFaYo1yGPjKuHmcRPBmjEMlNugvzsUAheG6msI63f9hOEI/hJx2F1QyxH9N3pO+Oz1VyfgmgC2j5hoCLPedDMoJC6ZlP8iE2tHyfb6jZK7rWYtzCbk9J3EFivovb+k2gQ/txo3BRtBs6GN9l9HiVZ1SEi+r2NB3plB+G8BkeMLxmchSwg483Kps24xtSc4qoKP34+GpqjL2Pk+vyJvR6aqH8dKll+czzReYycpdKadb8KckgLvoiypkis5Rzhg8RNUKkPomuEgzPPtoTlzvXbzLaGTrBkmbFH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed37ffa-19af-4670-2670-08d7990da95d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 16:20:25.3342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Blr0OuQJLdCESVkN0m45SU6XXfzHPtwMzwkp1gDCJMbrE3oOpcgRZXrC1S45gmw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
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

QW0gMTQuMDEuMjAgdW0gMTc6MTMgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxLzE0LzIwIDU6MDEg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE0LjAxLjIwIHVtIDE2OjQzIHNjaHJp
ZWIgTmlybW95IERhczoKPj4+IEpvYnMgc3VibWl0dGVkIGluIGFuIGVudGl0eSBzaG91bGQgZXhl
Y3V0ZSBpbiB0aGUgb3JkZXIgdGhvc2Ugam9icwo+Pj4gYXJlIHN1Ym1pdHRlZC4gV2UgbWFrZSBz
dXJlIHRoYXQgYnkgY2hlY2tpbmcgZW50aXR5LT5qb2JfcXVldWUgaW4KPj4+IGRybV9zY2hlZF9l
bnRpdHlfc2VsZWN0X3JxKCkgc28gdGhhdCB3ZSBkb24ndCBsb2FkYmFsYW5jZSBqb2JzIHdpdGhp
bgo+Pj4gYW4gZW50aXR5Lgo+Pj4KPj4+IEJ1dCBiZWNhdXNlIHdlIHVwZGF0ZSBlbnRpdHktPmpv
Yl9xdWV1ZSBsYXRlciBpbiAKPj4+IGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2IoKSwKPj4+IHRo
ZXJlIHJlbWFpbnMgYSBvcGVuIHdpbmRvdyB3aGVuIGl0IGlzIHBvc3NpYmUgdGhhdCBlbnRpdHkt
PnJxIG1pZ2h0IAo+Pj4gZ2V0Cj4+PiB1cGRhdGVkIGJ5IGRybV9zY2hlZF9lbnRpdHlfc2VsZWN0
X3JxKCkgd2hpY2ggc2hvdWxkIG5vdCBiZSBhbGxvd2VkLgo+Pgo+PiBOQUssIGNvbmN1cnJlbnQg
Y2FsbHMgdG8gCj4+IGRybV9zY2hlZF9qb2JfaW5pdCgpL2RybV9zY2hlZF9lbnRpdHlfcHVzaF9q
b2IoKSBhcmUgbm90IGFsbG93ZWQgaW4gCj4+IHRoZSBmaXJzdCBwbGFjZSBvciBvdGhlcndpc2Ug
d2UgbWVzcyB1cCB0aGUgZmVuY2Ugc2VxdWVuY2Ugb3JkZXIgYW5kIAo+PiByaXNrIG1lbW9yeSBj
b3JydXB0aW9uLgo+Cj4+Cj4+Pgo+Pj4gQ2hhbmdlcyBpbiB0aGlzIHBhcnQgYWxzbyBpbXByb3Zl
cyBqb2IgZGlzdHJpYnV0aW9uLgo+Pj4gQmVsb3cgYXJlIHRlc3QgcmVzdWx0cyBhZnRlciBydW5u
aW5nIGFtZGdwdV90ZXN0IGZyb20gbWVzYSBkcm0KPj4+Cj4+PiBCZWZvcmUgdGhpcyBwYXRjaDoK
Pj4+Cj4+PiBzY2hlZF9uYW1lwqDCoMKgwqAgbnVtIG9mIG1hbnkgdGltZXMgaXQgZ290IHNjaGVk
dWxlZAo+Pj4gPT09PT09PT09wqDCoMKgwqDCoCA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Cj4+PiBzZG1hMMKgwqDCoMKgwqDCoMKgwqDCoCAzMTQKPj4+IHNkbWExwqDCoMKgwqDC
oMKgwqDCoMKgIDMyCj4+PiBjb21wXzEuMC4wwqDCoMKgwqAgNTYKPj4+IGNvbXBfMS4xLjDCoMKg
wqDCoCAwCj4+PiBjb21wXzEuMS4xwqDCoMKgwqAgMAo+Pj4gY29tcF8xLjIuMMKgwqDCoMKgIDAK
Pj4+IGNvbXBfMS4yLjHCoMKgwqDCoCAwCj4+PiBjb21wXzEuMy4wwqDCoMKgwqAgMAo+Pj4gY29t
cF8xLjMuMcKgwqDCoMKgIDAKPj4+Cj4+PiBBZnRlciB0aGlzIHBhdGNoOgo+Pj4KPj4+IHNjaGVk
X25hbWXCoMKgwqDCoCBudW0gb2YgbWFueSB0aW1lcyBpdCBnb3Qgc2NoZWR1bGVkCj4+PiA9PT09
PT09PT3CoMKgwqDCoMKgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4+IMKg
IHNkbWExwqDCoMKgwqDCoMKgwqDCoMKgIDI0Mwo+Pj4gwqAgc2RtYTDCoMKgwqDCoMKgwqDCoMKg
wqAgMTY0Cj4+PiDCoCBjb21wXzEuMC4xwqDCoMKgwqAgMTQKPj4+IMKgIGNvbXBfMS4xLjDCoMKg
wqDCoCAxMQo+Pj4gwqAgY29tcF8xLjEuMcKgwqDCoMKgIDEwCj4+PiDCoCBjb21wXzEuMi4wwqDC
oMKgwqAgMTUKPj4+IMKgIGNvbXBfMS4yLjHCoMKgwqDCoCAxNAo+Pj4gwqAgY29tcF8xLjMuMMKg
wqDCoMKgIDEwCj4+PiDCoCBjb21wXzEuMy4xwqDCoMKgwqAgMTAKPj4KPj4gV2VsbCB0aGF0IGlz
IHN0aWxsIHJhdGhlciBuaWNlIHRvIGhhdmUsIHdoeSBkb2VzIHRoYXQgaGFwcGVuPwo+Cj4gSSB0
aGluayBpdCBpcyBiZWNhdXNlIHdlIGFyZSB1cGRhdGluZyBudW1fam9icyBpbW1lZGlhdGVseSBh
ZnRlciAKPiBzZWxlY3RpbmcgYSBuZXcgcnEuIFByZXZpb3VzbHnCoCB3ZSBkbyB0aGF0IHdheSBh
ZnRlcgo+Cj4gZHJtX3NjaGVkX2pvYl9pbml0KCkgaW4gZHJtX3NjaGVkX2VudGl0eV9wdXNoX2pv
YigpLiBUaGUgcHJvYmxlbSBpcyBpZiAKPiBJIGp1c3QgZG8KPgo+IEBAIC01NjIsNiArNTYyLDcg
QEAgaW50IGRybV9zY2hlZF9qb2JfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9iLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0VOVDsKPiDCoCDCoMKgwqDCoMKgIHNjaGVkID0g
ZW50aXR5LT5ycS0+c2NoZWQ7Cj4gK8KgwqDCoCBhdG9taWNfaW5jKCZlbnRpdHktPnJxLT5zY2hl
ZC0+bnVtX2pvYnMpOwo+Cj4gwqBAQCAtNDk4LDcgKzUwNCw2IEBAIHZvaWQgZHJtX3NjaGVkX2Vu
dGl0eV9wdXNoX2pvYihzdHJ1Y3QgCj4gZHJtX3NjaGVkX2pvYiAqc2NoZWRfam9iLAo+IMKgwqDC
oMKgwqAgYm9vbCBmaXJzdDsKPiDCoCDCoMKgwqDCoMKgIHRyYWNlX2RybV9zY2hlZF9qb2Ioc2No
ZWRfam9iLCBlbnRpdHkpOwo+IC3CoMKgwqAgYXRvbWljX2luYygmZW50aXR5LT5ycS0+c2NoZWQt
Pm51bV9qb2JzKTsKPgo+Cj4gbnVtX2pvYnMgZ2V0cyBuZWdhdGl2ZSBzb21ld2hlcmUgZG93biB0
aGUgbGluZSBzb21ld2hlcmUuIEkgYW0gCj4gZ3Vlc3NpbmfCoCBpdCdzIGhpdHRpbmcgdGhlIHJh
Y2UgY29uZGl0aW9uIGFzIEkgZXhwbGFpbmVkIGluIHRoZSBjb21taXQgCj4gbWVzc2FnZQoKVGhl
IHJhY2UgY29uZGl0aW9uIHlvdSBleHBsYWluIGluIHRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQg
YmUgCmltcG9zc2libGUgdG8gaGl0IG9yIHdlIGhhdmUgbXVjaCBtdWNoIGxhcmdlciBwcm9ibGVt
cyB0aGFuIGp1c3QgYW4gCmluY29ycmVjdCBqb2IgY291bnQuCgpJbmNyZW1lbnRpbmcgbnVtX2pv
YnMgc28gZWFybHkgaXMgbm90IHBvc3NpYmxlIGVpdGhlciBjYXVzZSB0aGUgam9iIAptaWdodCBu
b3QgZ2V0IHB1c2hlZCB0byB0aGUgZW50aXR5IGJlY2F1c2Ugb2YgYW4gZXJyb3IuCgpDaHJpc3Rp
YW4uCgo+Cj4KPiBSZWdhcmRzLAo+Cj4gTmlybW95Cj4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4K
Pj4+IEZpeGVzOiAzNWUxNjBlNzgxYTA0OCAoZHJtL3NjaGVkdWxlcjogY2hhbmdlIGVudGl0aWVz
IHJxIGV2ZW4gZWFybGllcikKPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+Cj4+PiBSZXBvcnRlZC1ieTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5
ZXIgCj4+PiA8cGllcnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4KPj4+IC0tLQo+Pj4g
wqAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDkgKysrKysrKy0t
Cj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uY8KgwqAgfCAxICsK
Pj4+IMKgIGluY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMSArCj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9lbnRpdHkuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRp
dHkuYwo+Pj4gaW5kZXggMmUzYTA1OGZjMjM5Li44NDE0ZTA4NGI2YWMgMTAwNjQ0Cj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+PiBAQCAtNjcsNiArNjcsNyBA
QCBpbnQgZHJtX3NjaGVkX2VudGl0eV9pbml0KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5IAo+Pj4g
KmVudGl0eSwKPj4+IMKgwqDCoMKgwqAgZW50aXR5LT5wcmlvcml0eSA9IHByaW9yaXR5Owo+Pj4g
wqDCoMKgwqDCoCBlbnRpdHktPnNjaGVkX2xpc3QgPSBudW1fc2NoZWRfbGlzdCA+IDEgPyBzY2hl
ZF9saXN0IDogTlVMTDsKPj4+IMKgwqDCoMKgwqAgZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5V
TEw7Cj4+PiArwqDCoMKgIGVudGl0eS0+bG9hZGJhbGFuY2Vfb24gPSB0cnVlOwo+Pj4gwqAgwqDC
oMKgwqDCoCBpZihudW1fc2NoZWRfbGlzdCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRpdHkt
PnJxID0gJnNjaGVkX2xpc3RbMF0tPnNjaGVkX3JxW2VudGl0eS0+cHJpb3JpdHldOwo+Pj4gQEAg
LTQ0Nyw2ICs0NDgsOSBAQCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAKPj4+ICpkcm1fc2NoZWRfZW50
aXR5X3BvcF9qb2Ioc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+IMKgwqDCoMKg
wqAgZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IAo+Pj4gZG1hX2ZlbmNlX2dldCgmc2NoZWRfam9i
LT5zX2ZlbmNlLT5maW5pc2hlZCk7Cj4+PiDCoCDCoMKgwqDCoMKgIHNwc2NfcXVldWVfcG9wKCZl
bnRpdHktPmpvYl9xdWV1ZSk7Cj4+PiArwqDCoMKgIGlmICghc3BzY19xdWV1ZV9jb3VudCgmZW50
aXR5LT5qb2JfcXVldWUpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVudGl0eS0+bG9hZGJhbGFuY2Vf
b24gPSB0cnVlOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gc2NoZWRfam9iOwo+Pj4gwqAg
fQo+Pj4gwqAgQEAgLTQ2Myw3ICs0NjcsOCBAQCB2b2lkIGRybV9zY2hlZF9lbnRpdHlfc2VsZWN0
X3JxKHN0cnVjdCAKPj4+IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+IMKgwqDCoMKgwqAg
c3RydWN0IGRtYV9mZW5jZSAqZmVuY2U7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRf
cnEgKnJxOwo+Pj4gwqAgLcKgwqDCoCBpZiAoc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2Jf
cXVldWUpIHx8IAo+Pj4gZW50aXR5LT5udW1fc2NoZWRfbGlzdCA8PSAxKQo+Pj4gK8KgwqDCoCBh
dG9taWNfaW5jKCZlbnRpdHktPnJxLT5zY2hlZC0+bnVtX2pvYnMpOwo+Pj4gK8KgwqDCoCBpZiAo
KGVudGl0eS0+bnVtX3NjaGVkX2xpc3QgPD0gMSkgfHwgIWVudGl0eS0+bG9hZGJhbGFuY2Vfb24p
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gwqAgwqDCoMKgwqDCoCBmZW5jZSA9
IFJFQURfT05DRShlbnRpdHktPmxhc3Rfc2NoZWR1bGVkKTsKPj4+IEBAIC00NzcsNiArNDgyLDcg
QEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycShzdHJ1Y3QgCj4+PiBkcm1fc2NoZWRf
ZW50aXR5ICplbnRpdHkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5ycSA9IHJxOwo+
Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCArwqDCoMKgIGVudGl0eS0+bG9hZGJhbGFuY2Vfb24gPSBm
YWxzZTsKPj4+IMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmVudGl0eS0+cnFfbG9jayk7Cj4+PiDC
oCB9Cj4+PiDCoCBAQCAtNDk4LDcgKzUwNCw2IEBAIHZvaWQgZHJtX3NjaGVkX2VudGl0eV9wdXNo
X2pvYihzdHJ1Y3QgCj4+PiBkcm1fc2NoZWRfam9iICpzY2hlZF9qb2IsCj4+PiDCoMKgwqDCoMKg
IGJvb2wgZmlyc3Q7Cj4+PiDCoCDCoMKgwqDCoMKgIHRyYWNlX2RybV9zY2hlZF9qb2Ioc2NoZWRf
am9iLCBlbnRpdHkpOwo+Pj4gLcKgwqDCoCBhdG9taWNfaW5jKCZlbnRpdHktPnJxLT5zY2hlZC0+
bnVtX2pvYnMpOwo+Pj4gwqDCoMKgwqDCoCBXUklURV9PTkNFKGVudGl0eS0+bGFzdF91c2VyLCBj
dXJyZW50LT5ncm91cF9sZWFkZXIpOwo+Pj4gwqDCoMKgwqDCoCBmaXJzdCA9IHNwc2NfcXVldWVf
cHVzaCgmZW50aXR5LT5qb2JfcXVldWUsIAo+Pj4gJnNjaGVkX2pvYi0+cXVldWVfbm9kZSk7Cj4+
PiDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMg
Cj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+PiBpbmRleCAz
ZmFkNTg3NmExM2YuLjAwZmRjMzUwMTM0ZSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX21haW4uYwo+Pj4gQEAgLTU2Miw2ICs1NjIsNyBAQCBpbnQgZHJtX3NjaGVkX2pv
Yl9pbml0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpqb2IsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FTk9FTlQ7Cj4+PiDCoCDCoMKgwqDCoMKgIHNjaGVkID0gZW50aXR5LT5ycS0+c2No
ZWQ7Cj4+PiArwqDCoMKgIGF0b21pY19pbmMoJmVudGl0eS0+cnEtPnNjaGVkLT5udW1fam9icyk7
Cj4+PiDCoCDCoMKgwqDCoMKgIGpvYi0+c2NoZWQgPSBzY2hlZDsKPj4+IMKgwqDCoMKgwqAgam9i
LT5lbnRpdHkgPSBlbnRpdHk7Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVk
dWxlci5oIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+PiBpbmRleCA5NmExYTFiNzUy
NmUuLmE1MTkwODY5ZDMyMyAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVs
ZXIuaAo+Pj4gKysrIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+PiBAQCAtOTcsNiAr
OTcsNyBAQCBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBk
bWFfZmVuY2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmxhc3Rfc2NoZWR1bGVkOwo+
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdGFza19zdHJ1Y3TCoMKgwqDCoMKgwqDCoCAqbGFzdF91c2Vy
Owo+Pj4gwqDCoMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Rv
cHBlZDsKPj4+ICvCoMKgwqAgYm9vbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2Fk
YmFsYW5jZV9vbjsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGNvbXBsZXRpb27CoMKgwqDCoMKgwqDC
oCBlbnRpdHlfaWRsZTsKPj4+IMKgIH07Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
