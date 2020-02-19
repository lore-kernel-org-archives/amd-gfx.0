Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850ADC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455B02465D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ToXGaM8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455B02465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17AF76EC36;
	Wed, 19 Feb 2020 15:47:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2B36EC36
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMvsHBYydDW6Z1HV7kje/oTS/6H3Lvum+Loc8We5W3oG5J+TluRRqRRmJ8zBIi7es/ZhQR2YffofHThjxqZfOfCBv5ffwrp441w77fsqQpq/4foIYHMJjzNl9owx0gWvcKSvoy/d4vYALh/MbUNhHKKD2Dg3y4GQJgKN7TyFRM1yt0MYdTWKtm77ojKQkh9wsl+916jtT8Q8nyjbHBwbEZioFU/Uva+ugPWxLl18el1Qh9LQRthljBMyBbMH5RfYUbROSFqgu0ANZuFqHf4Yia6wvpYfYTTjfDvTcWh2bVas3m6inL6ZVS7O+fax8nsF1Dj/jBFlHy3e+0lMh9pmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE9uiu/B1yW7lEB91K7iCD1WPWp3QvgPaT14zPleNt8=;
 b=Qf2em0j4APmd4uwN8QM8wW85RvrLVgCjbf4TENMgoGHF4COQ/BLan9eVQRY/7KOpfTYHJxYl7wiVs22hf6bp3khCe5mKFB9SB3386v8WjCjc9xSpfpY+BHWLrUQSG+f2oParKgl3rA2Y3Ba8+SbaTxZmrbBVqpPuoWuhU3ChRBhlV+2XH5mu/ObottXcJikMtqZZMd9yXFXvpUjr8HVS1faF5dg0h1G8Vji4Qb+MlKMAgT5wcrO52lRQNt4ucfLUnL3I8HTFLVIHKKqNeaZXtoZoQMzVGBuwMoJu8roQRbP48MqpK2Z1uARvZqUsk084oPBN39TrkqjU2lYoo2Tg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE9uiu/B1yW7lEB91K7iCD1WPWp3QvgPaT14zPleNt8=;
 b=ToXGaM8MJRDy9e3Eeh+4gtQ13r9MH/zZQ+K97eILiougj7Evc7vScff6V28BsKRIFULPcbZybUnIBh617KoWSLQ7Uh0FCClvttMfqyvVRwEt8SApL88dbSC50vEcqFgUk575/Du7juOsZ4At8yPeTYi89wh/Yurgyf/E9T7ymuw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB4343.namprd12.prod.outlook.com (20.180.247.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 15:47:46 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:47:46 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
To: christian.koenig@amd.com, luben.tuikov@amd.com, Marek.Olsak@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
 <9af8bcf0-bfe6-d622-ec12-9bddba8e2d76@amd.com>
 <59eabaf0-a5b2-c43f-f4bb-491d9c6e655f@gmail.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <a462df72-605a-1d9b-6825-59f5293c4a41@amd.com>
Date: Wed, 19 Feb 2020 10:47:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <59eabaf0-a5b2-c43f-f4bb-491d9c6e655f@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:208:23c::16) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 MN2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:208:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Wed, 19 Feb 2020 15:47:45 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dff21713-e7d4-438a-8822-08d7b553107a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4343:|MN2PR12MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB434350E6C3454AAAD507D66FF7100@MN2PR12MB4343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(31696002)(66574012)(36756003)(26005)(6486002)(2906002)(15650500001)(6512007)(186003)(6506007)(86362001)(66946007)(31686004)(53546011)(5660300002)(498600001)(16526019)(8676002)(81156014)(81166006)(8936002)(52116002)(2616005)(66476007)(956004)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4343;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7qXWXugdvMDkvJsWeb+qkxncq3zuf8+Wmu/YTzuYv5JDqm6Voj9IeGJZ7q+vwua7ApWK90TcarGcgx3p2JQ5+8QCdU/siIaPrnZXefAXYghyMD2N3ZvKJOiMO28lhXqhlNid4BQY9gGjJaU4dUbjyOiF0tfa1zHw3imWTYS75qOq6Epi0u0v858I95K7Ue2ucXmaNwOSapW49eVwf6xjgli+0OvRGMcwAGugyVkm0oemXzjQfxaRkRZc6QbUCP+IS4uI1Al60S4sWgIxPjTk9AoGF2kxE9ytkzSQJbx1LxS/vPoQfvPCGTnzv6wmnag2eE89BDpOKTh+2pydmyp/OXL4MqFcTNbZdk3QWQdtIml4JGlxstX7//72MmPx7SYmxNzfm9Jv706tWgukYlM6oHHa3e4Ia8cVn3a+Ha0W/ASuSIHlJx91D6k7ChUeo0B
X-MS-Exchange-AntiSpam-MessageData: SMXXRyxsTboTK7whO8Dw+QIRubB778FlNfmUr1r6qwDQRwJR16Y/l2FLv6y4RHt7PP22Ua5897H/r+E0lXfCB9IYAUZTj44I51FVLp3xRRzlDV3zYpfIV4nA4BFebu0sZhlnx27rSzzWqRh+3JgO4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff21713-e7d4-438a-8822-08d7b553107a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:47:46.3311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6gQuy1skFDO/n9QHl5suOnSh08AyimJAPuOQxuSrKde9jaD1Z3VXkQsuiLtycE/GpiOL5qRuU1z4d7j/mBLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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

VGhlIHRpcCBvZiBvcmlnaW4vYW1kLXN0YWdpbmctZHJtLW5leHQgZm9yIG1lIGlzOgoKY29tbWl0
IDdmZDNiNjMyZTE3ZTU1YzVmZmQwMDhmOWYwMjU3NTRlN2RhYTFiNjYKUmVmczoge29yaWdpbi9h
bWQtc3RhZ2luZy1kcm0tbmV4dH0sIHY1LjQtcmM3LTI4NDctZzdmZDNiNjMyZTE3ZQpBdXRob3I6
wqDCoMKgwqAgTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+CkF1dGhvckRhdGU6IFRodSBGZWIg
NiAyMzo1NTo1OCAyMDIwICswODAwCkNvbW1pdDrCoMKgwqDCoCBNb25rIExpdSA8TW9uay5MaXVA
YW1kLmNvbT4KQ29tbWl0RGF0ZTogV2VkIEZlYiAxOSAxMzozMzowMiAyMDIwICswODAwCgogwqDC
oMKgIGRybS9hbWRncHU6IGZpeCBjb2xsaWRpbmcgb2YgcHJlZW1wdGlvbgoKIMKgwqDCoCB3aGF0
OgogwqDCoMKgIHNvbWUgb3MgcHJlZW1wdGlvbiBwYXRoIGlzIG1lc3NlZCB1cCB3aXRoIHdvcmxk
IHN3aXRjaCBwcmVlbXB0aW9uCgogwqDCoMKgIGZpeDoKIMKgwqDCoCBjbGVhbnVwIHRob3NlIGxv
Z2ljcyBzbyBvcyBwcmVlbXB0aW9uIG5vdCBtaXhlZCB3aXRoIHdvcmxkIHN3aXRjaAoKIMKgwqDC
oCB0aGlzIHBhdGNoIGlzIGEgZ2VuZXJhbCBmaXggZm9yIGlzc3VlcyBjb21lcyBmcm9tIFNSSU9W
IE1DQlAsIGJ1dAogwqDCoMKgIHRoZXJlIGlzIHN0aWxsIFVNRCBzaWRlIGlzc3VlcyBub3QgcmVz
b3ZsdmVkIHlldCwgc28gdGhpcyBwYXRjaAogwqDCoMKgIGNhbm5vdCBmaXggYWxsIHdvcmxkIHN3
aXRjaCBidWcuCgogwqDCoMKgIFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQu
Y29tPgogwqDCoMKgIEFja2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+CgpXaGljaCBJIGhhZCBmZXRjaGVkIGp1c3QgYW4gaG91ciBhZ28uCgpPbiAyMDIwLTAyLTE5
IDEwOjQxIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2VsbCB3aGF0IGJyYW5jaCBh
cmUgeW91IHRyeWluZyB0byBtZXJnZSB0aGF0IGludG8/Cj4KPiBUaGUgY29uZmxpY3QgcmVzb2x1
dGlvbiBzaG91bGQgYmUgc2ltcGxlLCBqdXN0IGtlZXAgdGhlIAo+IHZtLT51cGRhdGVfZnVuY3Mt
PnByZXBhcmUoLi4uKSBsaW5lIGFzIGl0IGlzIGluIHlvdXIgYnJhbmNoLgo+Cj4gV2hlbiB5b3Ug
Z2V0IHRob3NlIGVycm9ycyB0aGVuIHNvbWV0aGluZyB3ZW50IHdyb25nIGluIHlvdXIgcmViYXNl
Lgo+Cj4gQ2hyaXN0aWFuLgo+Cj4gQW0gMTkuMDIuMjAgdW0gMTY6MTQgc2NocmllYiBUb20gU3Qg
RGVuaXM6Cj4+IERvZXNuJ3QgYnVpbGQgZXZlbiB3aXRoIGNvbmZsaWN0IHJlc29sdmVkOgo+Pgo+
PiBbcm9vdEByYXZlbiBsaW51eF0jIG1ha2UKPj4gwqAgQ0FMTMKgwqDCoCBzY3JpcHRzL2NoZWNr
c3lzY2FsbHMuc2gKPj4gwqAgQ0FMTMKgwqDCoCBzY3JpcHRzL2F0b21pYy9jaGVjay1hdG9taWNz
LnNoCj4+IMKgIERFU0NFTkTCoCBvYmp0b29sCj4+IMKgIENIS8KgwqDCoMKgIGluY2x1ZGUvZ2Vu
ZXJhdGVkL2NvbXBpbGUuaAo+PiDCoCBDQyBbTV3CoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0ubwo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYzog
SW4gZnVuY3Rpb24gCj4+IOKAmGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZ+KAmToKPj4gZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmM6MTYxMjo0MTogZXJyb3I6IOKAmG93
bmVy4oCZIAo+PiB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKPj4gwqAx
NjEyIHzCoCByID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhj
bHVzaXZlKTsKPj4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn4KPj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmM6MTYxMjo0MTogbm90ZTogZWFj
aCB1bmRlY2xhcmVkIAo+PiBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFj
aCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jOjE2MTI6NDg6IGVycm9yOiDigJhleGNsdXNpdmXigJkgCj4+IHVuZGVjbGFyZWQg
KGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQo+PiDCoDE2MTIgfMKgIHIgPSB2bS0+dXBkYXRl
X2Z1bmNzLT5wcmVwYXJlKCZwYXJhbXMsIG93bmVyLCBleGNsdXNpdmUpOwo+PiDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fgo+PiBtYWtl
WzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjY2OiAKPj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLm9dIEVycm9yIDEKPj4gbWFrZVszXTogKioqIFtzY3JpcHRz
L01ha2VmaWxlLmJ1aWxkOjUwOTogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHVdIAo+PiBFcnJv
ciAyCj4+IG1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDk6IGRyaXZlcnMv
Z3B1L2RybV0gRXJyb3IgMgo+PiBtYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6
NTA5OiBkcml2ZXJzL2dwdV0gRXJyb3IgMgo+PiBtYWtlOiAqKiogW01ha2VmaWxlOjE2NDk6IGRy
aXZlcnNdIEVycm9yIDIKPj4KPj4gU2hvdWxkIEkganVzdCBtb3ZlIHRvIGRybS1taXNjLW5leHQ/
Cj4+Cj4+IHRvbQo+Pgo+PiBPbiAyMDIwLTAyLTE5IDEwOjAyIGEubS4sIENocmlzdGlhbiBLw7Zu
aWcgd3JvdGU6Cj4+PiBBZGQgdXBkYXRlIGZlbmNlcyB0byB0aGUgcm9vdCBQRCB3aGlsZSBtYXBw
aW5nIEJPcy4KPj4+Cj4+PiBPdGhlcndpc2UgUERzIGZyZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3
b24ndCB3YWl0IGZvcgo+Pj4gdXBkYXRlcyB0byBmaW5pc2ggYW5kIGNhbiBjYXVzZSBjb3JydXB0
aW9ucy4KPj4+Cj4+PiB2MjogcmViYXNlZCBvbiBkcm0tbWlzYy1uZXh0Cj4+Pgo+Pj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4g
Rml4ZXM6IDkwYjY5Y2RjNWYxNTkgZHJtL2FtZGdwdTogc3RvcCBhZGRpbmcgVk0gdXBkYXRlcyBm
ZW5jZXMgdG8gCj4+PiB0aGUgcmVzdiBvYmoKPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxNCArKysrKysrKysrKystLQo+Pj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gaW5kZXggZDE2MjMxZDZhNzkw
Li5lZjczZmE5NGYzNTcgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPj4+IEBAIC01ODgsOCArNTg4LDggQEAgdm9pZCBhbWRncHVfdm1fZ2V0X3BkX2JvKHN0
cnVjdCBhbWRncHVfdm0gKnZtLAo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBlbnRyeS0+cHJpb3Jp
dHkgPSAwOwo+Pj4gwqDCoMKgwqDCoCBlbnRyeS0+dHYuYm8gPSAmdm0tPnJvb3QuYmFzZS5iby0+
dGJvOwo+Pj4gLcKgwqDCoCAvKiBPbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICov
Cj4+PiAtwqDCoMKgIGVudHJ5LT50di5udW1fc2hhcmVkID0gMjsKPj4+ICvCoMKgwqAgLyogVHdv
IGZvciBWTSB1cGRhdGVzLCBvbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICovCj4+
PiArwqDCoMKgIGVudHJ5LT50di5udW1fc2hhcmVkID0gNDsKPj4+IMKgwqDCoMKgwqAgZW50cnkt
PnVzZXJfcGFnZXMgPSBOVUxMOwo+Pj4gwqDCoMKgwqDCoCBsaXN0X2FkZCgmZW50cnktPnR2Lmhl
YWQsIHZhbGlkYXRlZCk7Cj4+PiDCoCB9Cj4+PiBAQCAtMTU5MSw2ICsxNTkxLDE2IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCAKPj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxvY2s7Cj4+PiDC
oMKgwqDCoMKgIH0KPj4+IMKgICvCoMKgwqAgaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkg
ewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5i
YXNlLmJvOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25h
bGVkKHZtLT5sYXN0X2RpcmVjdCkpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVf
Ym9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPj4+ICsKPj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kZWxheWVkKSkKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9k
ZWxheWVkLCB0cnVlKTsKPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCByID0gdm0t
PnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVzaXZlKTsKPj4+IMKg
wqDCoMKgwqAgaWYgKHIpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxvY2s7
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
