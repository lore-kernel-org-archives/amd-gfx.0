Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226DC433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 07:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99342087D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 07:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3/kNJVzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99342087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B636E913;
	Wed,  2 Sep 2020 07:13:40 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CAB6E913
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 07:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH0MZhbKoRFhH7G7exfchRwjrBApJkz8/x2VuTVlEs32vsLHrLi1ByDASo6RfL9Ul8tjtg8W3b/wnNwL/xlNexXqFVKpyUMKfOiEjdQ+wfjyMmdbN9DAo7sgFZRPhF6SbTVjKpkNjhFsqpW+j/GlZOiUAs5WWx8iFlwrDHzYlKHM/xR8/oyEb/rvgx+coYvdAmc/kBOVmFOn9o1Dc4wcjRTrjSES3B1uzl11+vkNIvXQgbE1mm4ehdnoex0EnAkLeqntrjOP7nzlrJqdnrAuC9M8HSQ2STeE4y7FUdR2LcNfMCrgP3jJwAWgPi+dGzKc4gjH1Jfl+tg0K80SE4o3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtOH1fYLpPgFZbby4eLhxuGLrSRc1+hxsBRPRKoXIeg=;
 b=Ke+lDvBhW8sBIXe9hzIzgldgGxlytyHLSEQSGpklnXYyk8xpZPmk9JbbX7BEun/V8UGg4FOdxAxzmeNZvN1XnERHdsDtIHVprrf4RsaOnKwxH2/R2qAqjuRoojF3ZaYpFy8iebyzBIXc7tVsyLP7BZkRYHmZADMav0PPjQ0yIQS07LowGar4tMvR26DAF2t0GO0u9ibyrMAL88gtbCZZgWBB3G998wdjYCrLTamdlQBewW0HF+wb5DFpcN0twnwgYoMcKj1w/W/3m8yAi8RYiDzGjBKM1l6SVtz3sYURK/UmuCv211i1jQ+zcrhl7TLA4cSJZUYoNYthceWZs/tmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtOH1fYLpPgFZbby4eLhxuGLrSRc1+hxsBRPRKoXIeg=;
 b=3/kNJVzBDhzx6f+GSMVmq4mP6bJWEhcdz3l0mVi5G8lYJWBddwJQES/kWynL39UPhCFshPnNcQN2gaLZZAn2w5VmMPqVf80aqXJqXWNT+vcZx7RjJUJE5jIA+QabTgoG/Slk/EjEPZoMA8hh4ZIjN29qXZh8slse9qCAkZvljYQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 07:13:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 07:13:37 +0000
Subject: Re: [PATCH V2] drm/amdgpu: Do not move root PT bo to relocated list
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <SN6PR12MB28007664AFF433168DF33CC787190@SN6PR12MB2800.namprd12.prod.outlook.com>
 <DM5PR12MB1708207A4C9E047F17B4DAA5842E0@DM5PR12MB1708.namprd12.prod.outlook.com>
 <3066e4cb-0ffe-d26b-228b-6cdad7de4702@gmail.com>
 <A0B5D148-7D8F-48F1-ADF2-B31EFA320817@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e4de2679-937f-f4f1-08bf-12fe1c3173a4@amd.com>
Date: Wed, 2 Sep 2020 09:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <A0B5D148-7D8F-48F1-ADF2-B31EFA320817@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0120.eurprd05.prod.outlook.com
 (2603:10a6:207:2::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM3PR05CA0120.eurprd05.prod.outlook.com (2603:10a6:207:2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 07:13:36 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ceb8273-ceb3-4265-e949-08d84f0fb615
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42212E5159BAC0015C29D646832F0@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3YCoUtPqxEXLFcCwq450ErbxoXbwvbJVzTIk9XcEAi1ZDQVbu5PqG/xl/lAbAnft/5/jpy3vgKmHh4pQj6nOa0KvffbA16wTGOgxCuCdmGG4Ggej+XdyhTH5VHrc6IIc0UvY091dYltAHpuzAtgb7ICPAvhvdMVZdDIoH/DdYsJVnFq+LZkca+C+cfKR9tdjC++qaryVZjNvbN9d7xCoakwgDr+MO0olJDodmsVuH02ZpEBtILWryCj/A952bMsx2BfgtqZYIhMGbo8PjfnLp9lg/1Sl+fj8Dl/I5fRD+qaj5j7oyz1LLOWGPQTy0PWRk4ArNPq5C/rijsOmMVIfvbU0Sy3sf2c/w7ny4fMC8DEitMcsApX48L2mS3J/SvketnFk4Eb2Ti7XhqMDEyAJ1OWiMGwbFVlEsWhMI3bJ6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(478600001)(8936002)(86362001)(66476007)(66574015)(66556008)(6666004)(8676002)(66946007)(31696002)(956004)(36756003)(186003)(52116002)(2616005)(83380400001)(5660300002)(6486002)(316002)(37006003)(54906003)(31686004)(966005)(6636002)(45080400002)(4326008)(16576012)(6862004)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1ole7b9aoH/HT51Or/Xm1WiVpSrYscjkBco9IfkTrojbdYdcS21PTdtnVYhql3WJNYEN1MZIZ8krCdYzTaI1L9q2H8RTu4dy3iCslhuKsblhWPlWPKlliotKsHMNbyijkwIn6hgbkODBwUb9+WjZJyUQ5UrpBl+T0bVSH25z4wMdhABw25WlWZN2acH8rNv4YlXUDG1zvHcZZCOYHJ5X3uL5ixEsTPHblFZf6i2KUxkceI27+8L7i5EYhtHkgFZf++gXR3RfqR3U2smzbsr7d6y6NtFp/tSvW/j4aJugZr3Kuw2ullOG60HfVYAWdpveezrQxn1nfRh8svliIJb3hqOg4JePnuaTzscmYpqKQ4ub0sGp2bZXZGtspoy8Wub3NpYntlcLZ/fWhnx6Y2koBUen17xZF+9d/NK0vJGPSEkONNxZKpbVcHV9n5o0G5UF+PT+1kvWyjOYfuCyIw1Q28ySAAh/7JJuV+6H92w3VOqO8l3OwKCP2GK9bGWPlofjcAVGhruI403sIw1JRS8H1Pqa5P2vJSv6oKNgIeaIGtkd4GtV1QBG8v+hx74vAAbv0U0lAoK1kQbhPsjFKdUSlKU6pisoShk2Cl7ElcHwjIKbMHmp7Y1Xwp5Bk5/6dC3ifW4lffEhYgPGhNR5S3csqPqPHvz/PAk6kacUeFhQ6CJP2vzB1oKSnNmRcPGqUiEZ7kQFTCMkDTlLi7aZGVDmCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceb8273-ceb3-4265-e949-08d84f0fb615
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 07:13:37.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REDAW7pArcFTbmbXJ5cb5ZZuKbKfpTyyDt09185Ud3HYZp7G5LMh9gjSDHDBzzHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Monk" <Monk.Liu@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMDY6NTAgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Oeac
iDHml6UgMjE6NTTvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4g5YaZ6YGT77yaCj4+Cj4+IEFncmVlZCwgdGhhdCBjaGFuZ2UgZG9lc24ndCBzZWVt
IHRvIG1ha2Ugc2Vuc2UgYW5kIHlvdXIgYmFja3RyYWNlIGlzIG1hbmdsZWQgc28gYmFyZWx5IHJl
YWRhYmxlLgo+IGl0IGlzIHJlcGx5IHRoYXQgbWVzc2VkIHVwIHRoZSBsb2dzLgo+Cj4gQW5kIHRo
aXMgcGF0Y2ggd2FzIHNlbnQgb24gMTB0aCBGZWIuCgpOb3cgSSBzZWUgaXQgYXMgd2VsbC4gSSdt
IGp1c3Qgbm90IHVzZWQgdG8gcmVhZGluZyBDaGluZXNlIGxldHRlcnMgOikKCkkgd2FzIGFscmVh
ZHkgd29uZGVyaW5nIHdoeSB0aGlzIGNhbWUgdXAgYWdhaW4uCgpSZWdhcmRzLApDaHJpc3RpYW4u
Cgo+PiBDaHJpc3RpYW4uCj4+Cj4+IEFtIDAxLjA5LjIwIHVtIDE0OjU5IHNjaHJpZWIgTGl1LCBN
b25rOgo+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBP
bmx5XQo+Pj4KPj4+IFNlZSB0aGF0IHdlIGFscmVhZHkgaGF2ZSBzdWNoIGxvZ2ljOgo+Pj4KPj4+
IDI4MiBzdGF0aWMgdm9pZCBhbWRncHVfdm1fYm9fcmVsb2NhdGVkKHN0cnVjdCBhbWRncHVfdm1f
Ym9fYmFzZSAqdm1fYm8pCj4+PiAgIDI4MyB7Cj4+PiAgIDI4NCAgICAgaWYgKHZtX2JvLT5iby0+
cGFyZW50KQo+Pj4gICAyODUgICAgICAgICBsaXN0X21vdmUoJnZtX2JvLT52bV9zdGF0dXMsICZ2
bV9iby0+dm0tPnJlbG9jYXRlZCk7Cj4+PiAgIDI4NiAgICAgZWxzZQo+Pj4gICAyODcgICAgICAg
ICBhbWRncHVfdm1fYm9faWRsZSh2bV9ibyk7Cj4+PiAgIDI4OCB9Cj4+Pgo+Pj4gV2h5IHlvdSBu
ZWVkIHRvIGRvIHRoZSBiby0+cGFyZW50IGNoZWNrIG91dCBzaWRlID8KPiBiZWNhdXNlIGl0IGlz
IG1lIHRoYXQgbW92ZXMgc3VjaCBsb2dpYyBpbnRvIGFtZGdwdV92bV9ib19yZWxvY2F0ZWQuCj4K
Pj4+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPj4+IOWPkeS7tuS6ujogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g5Luj6KGoIFBhbiwgWGluaHVpCj4+PiDl
j5HpgIHml7bpl7Q6IDIwMjDlubQy5pyIMTDml6UgOTowNAo+Pj4g5pS25Lu25Lq6OiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4g5oqE6YCBOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPgo+Pj4g5Li76aKYOiBbUEFUQ0ggVjJdIGRybS9hbWRncHU6IERvIG5vdCBt
b3ZlIHJvb3QgUFQgYm8gdG8gcmVsb2NhdGVkIGxpc3QKPj4+Cj4+PiBoaXQgcGFuaWMgd2hlbiB3
ZSB1cGRhdGUgdGhlIHBhZ2UgdGFibGVzLgo+Pj4KPj4+IDwxPlsgIDEyMi4xMDMyOTBdIEJVRzog
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAw
OCA8MT5bICAxMjIuMTAzMzQ4XSAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVs
IG1vZGUgPDE+WyAgMTIyLjEwMzM3Nl0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJl
c2VudCBwYWdlIDw2PlsgIDEyMi4xMDM0MDNdIFBHRCAwIFA0RCAwIDw0PlsgIDEyMi4xMDM0MjFd
IE9vcHM6IDAwMDAgWyMxXSBTTVAgUFRJCj4+PiA8ND5bICAxMjIuMTAzNDQyXSBDUFU6IDEzIFBJ
RDogMjEzMyBDb21tOiBrZmR0ZXN0IFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICA1LjQuMC1y
YzcrICM3Cj4+PiA8ND5bICAxMjIuMTAzNDgwXSBIYXJkd2FyZSBuYW1lOiBTdXBlcm1pY3JvIFNZ
Uy03MDQ4R1ItVFIvWDEwRFJHLVEsIEJJT1MgMy4wYiAwMy8wOS8yMDE4IDw0PlsgIDEyMi4xMDM2
NTddIFJJUDogMDAxMDphbWRncHVfdm1fdXBkYXRlX3BkZXMrMHgxNDAvMHgzMzAgW2FtZGdwdV0g
PDQ+WyAgMTIyLjEwMzY4OV0gQ29kZTogMDMgNGMgODkgNzMgMDggNDkgODkgOWQgYzggMDAgMDAg
MDAgNDggOGIgN2IgZjAgYzYgNDMgMTAgMDAgNDUgMzEgYzAgNDggOGIgODcgMjggMDQgMDAgMDAg
NDggODUgYzAgNzQgMDcgNGMgOGIgODAgMjAgMDQgMDAgMDAgPDRkPiA4YiA3MCAwOCAzMSBmNiA0
OSA4YiA4NiAyOCAwNCAwMCAwMCA0OCA4NSBjMCA3NCAwZiA0OCA4YiA4MCAyOCA8ND5bICAxMjIu
MTAzNzY5XSBSU1A6IDAwMTg6ZmZmZmI0OWEwYTZhM2E5OCBFRkxBR1M6IDAwMDEwMjQ2IDw0Plsg
IDEyMi4xMDM3OTddIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5MDIwZjgyM2MxNDgg
UkNYOiBkZWFkMDAwMDAwMDAwMTIyIDw0PlsgIDEyMi4xMDM4MzFdIFJEWDogZmZmZjkwMjBlY2U3
MDAxOCBSU0k6IGZmZmY5MDIwZjgyM2MwYzggUkRJOiBmZmZmOTAxMGNhMzFjODAwIDw0PlsgIDEy
Mi4xMDM4NjVdIFJCUDogZmZmZmI0OWEwYTZhM2IzOCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5
OiAwMDAwMDAwMDAwMDAwMDAxIDw0PlsgIDEyMi4xMDM4OTldIFIxMDogMDAwMDAwMDA2MDQ0Zjk5
NCBSMTE6IDAwMDAwMDAwZGY1N2ZiNTggUjEyOiBmZmZmOTAyMGY4MjNjMDAwIDw0PlsgIDEyMi4x
MDM5MzNdIFIxMzogZmZmZjkwMjBmODIzYzAwMCBSMTQ6IGZmZmY5MDIwZjgyM2MwYzggUjE1OiBm
ZmZmOTAxMGQ1ZDIwMDAwIDw0PlsgIDEyMi4xMDM5NjhdIEZTOiAgMDAwMDdmMzJjODNkYzc4MCgw
MDAwKSBHUzpmZmZmOTAyMGZmMzgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAgPDQ+
WyAgMTIyLjEwNDAwNl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4
MDA1MDAzMyA8ND5bICAxMjIuMTA0MDM1XSBDUjI6IDAwMDAwMDAwMDAwMDAwMDggQ1IzOiAwMDAw
MDAyMDM2YmJhMDA1IENSNDogMDAwMDAwMDAwMDM2MDZlMCA8ND5bICAxMjIuMTA0MDY5XSBEUjA6
IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAw
MDAwMCA8ND5bICAxMjIuMTA0MTAzXSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAw
MGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMCA8ND5bICAxMjIuMTA0MTM3XSBDYWxsIFRy
YWNlOgo+Pj4gPDQ+WyAgMTIyLjEwNDI0MV0gIHZtX3VwZGF0ZV9wZHMrMHgzMS8weDUwIFthbWRn
cHVdIDw0PlsgIDEyMi4xMDQzNDddICBhbWRncHVfYW1ka2ZkX2dwdXZtX21hcF9tZW1vcnlfdG9f
Z3B1KzB4MmVmLzB4NjkwIFthbWRncHVdIDw0PlsgIDEyMi4xMDQ0NjZdICBrZmRfcHJvY2Vzc19h
bGxvY19ncHV2bSsweDk4LzB4MTkwIFthbWRncHVdIDw0PlsgIDEyMi4xMDQ1NzZdICBrZmRfcHJv
Y2Vzc19kZXZpY2VfaW5pdF92bS5wYXJ0LjgrMHhmMy8weDFmMCBbYW1kZ3B1XSA8ND5bICAxMjIu
MTA0Njg4XSAga2ZkX3Byb2Nlc3NfZGV2aWNlX2luaXRfdm0rMHgyNC8weDMwIFthbWRncHVdIDw0
PlsgIDEyMi4xMDQ3OTRdICBrZmRfaW9jdGxfYWNxdWlyZV92bSsweGE0LzB4YzAgW2FtZGdwdV0g
PDQ+WyAgMTIyLjEwNDkwMF0gIGtmZF9pb2N0bCsweDI3Ny8weDUwMCBbYW1kZ3B1XSA8ND5bICAx
MjIuMTA1MDAxXSAgPyBrZmRfaW9jdGxfZnJlZV9tZW1vcnlfb2ZfZ3B1KzB4YzAvMHhjMCBbYW1k
Z3B1XSA8ND5bICAxMjIuMTA1MDM5XSAgPyByY3VfcmVhZF9sb2NrX3NjaGVkX2hlbGQrMHg0Zi8w
eDgwCj4+PiA8ND5bICAxMjIuMTA1MDY4XSAgPyBrbWVtX2NhY2hlX2ZyZWUrMHgyYmEvMHgzMDAg
PDQ+WyAgMTIyLjEwNTA5M10gID8gdm1fYXJlYV9mcmVlKzB4MTgvMHgyMCA8ND5bICAxMjIuMTA1
MTE3XSAgPyBmaW5kX2hlbGRfbG9jaysweDM1LzB4YTAgPDQ+WyAgMTIyLjEwNTE0M10gIGRvX3Zm
c19pb2N0bCsweGE5LzB4NmYwIDw0PlsgIDEyMi4xMDYwMDFdICBrc3lzX2lvY3RsKzB4NzUvMHg4
MCA8ND5bICAxMjIuMTA2ODAyXSAgPyBkb19zeXNjYWxsXzY0KzB4MTcvMHgyMzAgPDQ+WyAgMTIy
LjEwNzYwNV0gIF9feDY0X3N5c19pb2N0bCsweDFhLzB4MjAgPDQ+WyAgMTIyLjEwODM3OF0gIGRv
X3N5c2NhbGxfNjQrMHg1Zi8weDIzMCA8ND5bICAxMjIuMTA5MTE4XSAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQo+Pj4gPDQ+WyAgMTIyLjEwOTg0Ml0gUklQOiAwMDMz
OjB4N2YzMmM2YjQ5NWQ3Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVp
LnBhbkBhbWQuY29tPgo+Pj4gLS0tCj4+PiBjaGFuZ2UgZnJvbSB2MToKPj4+ICAgICBtb3ZlIHJv
b3QgcHQgYm8gdG8gaWRsZSBzdGF0ZSBpbnN0ZWFkLgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgOSArKysrKystLS0KPj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gaW5kZXggMzE5NWJjOS4uYzNkMWFmNSAxMDA2
NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gQEAgLTI2MTks
OSArMjYxOSwxMiBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+Pj4gICBjb250aW51ZTsKPj4+ICAgYm9fYmFzZS0+bW92ZWQgPSB0cnVl
Owo+Pj4KPj4+IC1pZiAoYm8tPnRiby50eXBlID09IHR0bV9ib190eXBlX2tlcm5lbCkKPj4+IC1h
bWRncHVfdm1fYm9fcmVsb2NhdGVkKGJvX2Jhc2UpOwo+Pj4gLWVsc2UgaWYgKGJvLT50Ym8uYmFz
ZS5yZXN2ID09IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3YpCj4+PiAraWYgKGJvLT50
Ym8udHlwZSA9PSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKPj4+ICtpZiAoYm8tPnBhcmVudCkKPj4+
ICthbWRncHVfdm1fYm9fcmVsb2NhdGVkKGJvX2Jhc2UpOwo+Pj4gK2Vsc2UKPj4+ICthbWRncHVf
dm1fYm9faWRsZShib19iYXNlKTsKPj4+ICt9IGVsc2UgaWYgKGJvLT50Ym8uYmFzZS5yZXN2ID09
IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3YpCj4+PiAgIGFtZGdwdV92bV9ib19tb3Zl
ZChib19iYXNlKTsKPj4+ICAgZWxzZQo+Pj4gICBhbWRncHVfdm1fYm9faW52YWxpZGF0ZWQoYm9f
YmFzZSk7Cj4+PiAtLQo+Pj4gMi43LjQKPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q1hpbmh1aS5Q
YW4lNDBhbWQuY29tJTdDYWNhM2ExYmFhZTlhNDMyZDE0NzgwOGQ4NGU3ZTliNjclN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MzQ1NjUyOTY5OTg5ODUzJmFt
cDtzZGF0YT1OMUVGN3pnSmphaiUyRkRLeUdpSzlXbTVXenFhWG9DJTJCcmRnSDR5eEJoQmhsRSUz
RCZhbXA7cmVzZXJ2ZWQ9MAo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1h
biUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDWGluaHVpLlBhbiU0MGFt
ZC5jb20lN0NhY2EzYTFiYWFlOWE0MzJkMTQ3ODA4ZDg0ZTdlOWI2NyU3QzNkZDg5NjFmZTQ4ODRl
NjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczNDU2NTI5Njk5ODk4NTMmYW1wO3NkYXRh
PU4xRUY3emdKamFqJTJGREt5R2lLOVdtNVd6cWFYb0MlMkJyZGdINHl4QmhCaGxFJTNEJmFtcDty
ZXNlcnZlZD0wCj4+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
