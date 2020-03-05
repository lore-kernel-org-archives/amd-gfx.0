Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59949C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 06:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DF92073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 06:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v6uT5Z3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DF92073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91D76E069;
	Thu,  5 Mar 2020 06:20:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680086.outbound.protection.outlook.com [40.107.68.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E5D6E069
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 06:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lekNxMb+IzyxnrwiyQyvYrPnDOaXUui/Gww3v20hF0TJ9PgYFfyphEb7kwicLK0XOs7D2Fzbk+yyNPQyjbxtOIPwsc/2dmzK5pa18LlFM3p9nMjMo/vpEBUeKn2C+scbXliNiJvAavw3cX7BXPliTHuFAltIsJO9tyF33jSCRWLNlSdnnlcp1TU5mCLhG2W13YVl5MOSkp+AmeMrNbwf07Bl0e0iNciunjM2WyElMFrzhssP80EVIXBK1qGzmuzCJsWZAXlERZUM0chy8hNUA97EqBRIKFBHJooT734YIPZhDG1Z7olPV2qsMwOshxOT6iVLQLZqeXDsB6jG7XJzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhqGwlVIxNitHemtXnRGm7BSWqTapuBSdQ67CEzjtmM=;
 b=Mw0Jtd93nZj903mNsbnAwpR1WwHQMbWBaXKEcsihhLMs5sVLy3VF0s/E0wzs5WMt6tuPG4cDVPUdJsPQ5chiizl0ItXJXMXnqsel14tmvm74ieq0ea14ACE8LQ3Uv++6ZSL+YkP8qXd7E2V7HirH73sMYdjEaw+fz0uRWqIsHqjn7vup2fnadPDR0g7BfqdiBJn2/p8EqwKrVVpQlH67c5IbbAIJxzVr9LWzM48W0Q8Dwfz/DxJ8eQNn/7PJ0V9nj29RvQEUotkSdu8IjUiMNWliaIpGL/WFRFU3nm4B8/5DLWu/8eRc+ROeDAH7NaJ9vtF0WM5v3hx51Qx1tH4ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhqGwlVIxNitHemtXnRGm7BSWqTapuBSdQ67CEzjtmM=;
 b=v6uT5Z3Qsoyral1QLjSWD5PGrANjzeN1Df5VZbgPMM4Z/LyZZ3Mjh0H7PeAAWMNA5RkDYLNy0heIZIbdfs/+gQTh31NhPinvfhgyPNedCOZsKTkJEe7u6TbL4e5GwgAdmjVVg888P6jfzF9GjdUvv0nuM+RTIPxv8SSAfsFn63Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 06:20:16 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 06:20:16 +0000
Subject: Re: [PATCH v2 2/4] drm/scheduler: implement a function to modify
 sched list
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-2-nirmoy.das@amd.com>
 <dbbe81d7-ff99-b85d-ddfd-1f3f13322d53@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <d9b7b57c-0b62-8503-658d-97d8492e23da@amd.com>
Date: Thu, 5 Mar 2020 07:23:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <dbbe81d7-ff99-b85d-ddfd-1f3f13322d53@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0046.eurprd05.prod.outlook.com
 (2603:10a6:200:68::14) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
 (2003:c5:8f2e:a500:1f22:cf19:9085:11a1) by
 AM4PR0501CA0046.eurprd05.prod.outlook.com (2603:10a6:200:68::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 5 Mar 2020 06:20:15 +0000
X-Originating-IP: [2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 43729ae1-1aa6-406a-c8c3-08d7c0cd457c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:|DM5PR12MB1708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1708303D07807F7E6114BF8A8BE20@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(199004)(189003)(6666004)(66556008)(2616005)(66476007)(66946007)(52116002)(31696002)(186003)(53546011)(16526019)(81166006)(36756003)(4326008)(8676002)(66574012)(81156014)(45080400002)(110136005)(478600001)(31686004)(316002)(5660300002)(6486002)(966005)(2906002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1708;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyOqQqlWaNd6prPc6JESLiM6IXB/Pri08NIddg2r6mnhabiKlxFTskJBZEgyHVtVSusFAph38DNJFZIbxLKA9OJOMwwz4Xbgdz57syxEjmjNfPH5mREAsQ5OPKgscZchAWx8Pyc4dQ7AVgRHT6EIe9+8KVXKgmIMHCLaG6Ief3HFBdLe3AY9BgA3DrFIfZ+QWgBOLm3NjVfAn0uHOiwKCytvPWIaRIB6zQgrvkjy9+r+wvzk/vK9jNG9LPlBGaakwrPCTS5R83rEMjmvt7UHNp4IiP790PQx1JasU42ESowKTB0ket6iCOA/3U8U8SVoNQR67xtp+kqAzWLXgm8y6G3ntXElOoeweccbTwEiTsgPi6iDma6TtfkpB6wuwTOxDqd6jvyTuAdvq/+aL33Unje6H4GvBKDwnAuiETCp77kfCRQV3qNTe532b158OB+o74u43d7ElZnZhSJcWbOe1zwOLV2wUMQpK1hCutC3GhE=
X-MS-Exchange-AntiSpam-MessageData: inLWxozrJ6djxDF2HEe/jljv3/MoSfxFjgextUdLyxkQmtv5xRkUzCiOQFXqEkuR5OkmHdNTUbRy1UAVrxogahJW6ZXPT6/ejo4Cn4m7fpFxvmoDEt2frr3VmKnrZD55s8YoJ5gF5KFBybzorMZspf5hqnXDCTXTkJJqlYHRjFF4MaKehrw+G7lsdwWkHHponuRA6yQKSeokUpBQlRWlXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43729ae1-1aa6-406a-c8c3-08d7c0cd457c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 06:20:16.5467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/6zB4Q2JKPS5IpqLU6So7N7BkeEn1TsZ6CBZGwnOXVbrq8FKLRWNO9ribnc7rFP2iKxQ+4G/WQ8q6/TlT4b+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvNC8yMCAxMTowMCBQTSwgTHViZW4gVHVpa292IHdyb3RlOgo+IE9uIDIwMjAtMDMtMDMg
Nzo1MCBhLm0uLCBOaXJtb3kgRGFzIHdyb3RlOgo+PiBpbXBsZW1lbnQgZHJtX3NjaGVkX2VudGl0
eV9tb2RpZnlfc2NoZWQoKSB3aGljaCBjYW4gbW9kaWZ5IGV4aXN0aW5nCj4+IHNjaGVkX2xpc3Qg
d2l0aCBhIGRpZmZlcmVudCBvbmUuIFRoaXMgaXMgZ29pbmcgdG8gYmUgaGVscGZ1bCB3aGVuCj4+
IHVzZXJzcGFjZSBjaGFuZ2VzIHByaW9yaXR5IG9mIGEgY3R4L2VudGl0eSB0aGVuIGRyaXZlciBj
YW4gc3dpdGNoIHRvCj4+IGNvcnJlc3BvbmRpbmcgaHcgc2hjZWQgbGlzdCBmb3IgdGhhdCBwcmlv
cml0eQo+Pgo+IFRoaXMgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkIHN0YXJ0IHdpdGggYSBjYXBpdGFs
aXplZCBzZW50ZW5jZToKPiAiaW1wbGVtZW50IiAtLT4gIkltcGxlbWVudCIuICAiY2FuIG1vZGlm
eSIgLS0+ICJtb2RpZmllcyIKPgo+IEFsc28gYSBzcGVsbCBjaGVjayBzaG91bGQgYmUgZG9uZSBv
biBpdCBiZWZvcmUgY29tbWl0dGluZzoKPiAic2hjZWQiIC0tPiAic2NoZWQiLgo+Cj4gInRoZW4g
dGhlIGRyaXZlciIsICJ0byB0aGUgY29ycmVzcG9uZGluZyIsICJIVyBzY2hlZHVsZXIiLgo+Cj4g
QW5kIHRoZSBjb21taXQgbWVzc2FnZSBwYXJhZ3JhcGggc2hvdWxkIGVuZCB3aXRoIGEgcGVyaW9k
LgpUaGFua3MhCj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQu
Y29tPgo+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0
eS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+PiAgIGluY2x1ZGUvZHJtL2dwdV9zY2hlZHVs
ZXIuaCAgICAgICAgICAgICAgfCAgNCArKysrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNl
cnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+
PiBpbmRleCA2M2JjY2QyMDFiOTcuLmI5NDMxMjE1NGU1NiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+IEBAIC04Myw2ICs4MywyNSBAQCBpbnQgZHJt
X3NjaGVkX2VudGl0eV9pbml0KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4+ICAg
fQo+PiAgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9pbml0KTsKPj4KPj4gKy8qKgo+
PiArICogZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQgLSBNb2RpZnkgc2NoZWQgb2YgYW4g
ZW50aXR5Cj4+ICsgKgo+IFRoaXMgZW1wdHkgbGluZSBpcyB1bm5jZXNzYXJ5Lgo+Cj4+ICsgKiBA
ZW50aXR5OiBzY2hlZHVsZXIgZW50aXR5IHRvIGluaXQKPj4gKyAqIEBzY2hlZF9saXN0OiB0aGUg
bGlzdCBvZiBuZXcgZHJtIHNjaGVkcyB3aGljaCB3aWxsIHJlcGxhY2UKPj4gKyAqCQlleGlzdGlu
ZyBlbnRpdHktPnNjaGVkX2xpc3QKPj4gKyAqIEBudW1fc2NoZWRfbGlzdDogbnVtYmVyIG9mIGRy
bSBzY2hlZCBpbiBzY2hlZF9saXN0Cj4+ICsgKi8KPj4gK3ZvaWQgZHJtX3NjaGVkX2VudGl0eV9t
b2RpZnlfc2NoZWQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPj4gKwkJCQkgIHN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqKnNjaGVkX2xpc3QsCj4+ICsJCQkJICB1bnNpZ25lZCBp
bnQgbnVtX3NjaGVkX2xpc3QpCj4+ICt7Cj4+ICsJV0FSTl9PTighbnVtX3NjaGVkX2xpc3QgfHwg
IXNjaGVkX2xpc3QpOwo+PiArCj4+ICsJZW50aXR5LT5zY2hlZF9saXN0ID0gc2NoZWRfbGlzdDsK
Pj4gKwllbnRpdHktPm51bV9zY2hlZF9saXN0ID0gbnVtX3NjaGVkX2xpc3Q7Cj4+ICt9Cj4+ICtF
WFBPUlRfU1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKTsKPj4gKwo+PiAgIC8q
Kgo+PiAgICAqIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZSAtIENoZWNrIGlmIGVudGl0eSBpcyBp
ZGxlCj4+ICAgICoKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaCBi
L2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+PiBpbmRleCA1ODliZTg1MWY4YTEuLmY3MGE4
NGFhYWY3YSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+ICsr
KyBiL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+PiBAQCAtMjk3LDYgKzI5NywxMCBAQCB2
b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpOwo+PiAg
IGludCBkcm1fc2NoZWRfam9iX2luaXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYiwKPj4gICAJ
CSAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+PiAgIAkJICAgICAgIHZv
aWQgKm93bmVyKTsKPj4gK3ZvaWQgZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQoc3RydWN0
IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPj4gKwkJCQkgIHN0cnVjdCBkcm1fZ3B1X3NjaGVk
dWxlciAqKnNjaGVkX2xpc3QsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0KTsKPj4gKwpUaGlzIGdlbmVyYWxseSBkb2Vzbid0
IGhhcHBlbiB3aXRoIG15IGN1cnJlbnQgdmkgY29uZmlnLiBJIHdpbGwgYmUgZXh0cmEgCmNhcmVm
dWwuCj4gQWdhaW4sIHRoZSBhcmd1bWVudCBsaXN0IGhlcmUgaXMgdW5hbGlnbmVkLiBQbGVhc2Ug
YWxpZ24gaXQKPiBjb3JyZWN0bHkuIFRoZSBjb3JyZWN0IGluZGVudGF0aW9uIHdvdWxkIGFkZCB0
aGUgbWF4aW11bSBudW1iZXIgb2YKPiBsZWFkaW5nIFRBQiBjaGFycyBmb2xsb3dlZCBieSB0aGUg
MCB0byA3IHNwYWNlcywgdG8gYWxpZ24KPiB0aGUgYXJndW1lbnQgbGlzdCB0byB0aGUgZmlyc3Qg
YXJndW1lbnQgaW4gdGhlIG9wZW5pbmcgcGFyZW50aGVzaXMuCj4gVGhlIExLQ1MgZGVzY3JpYmVz
IHRoaXMgYW5kIGFsc28gaGFzIHRoZSBzZXR0aW5ncyBmb3IgRW1hY3MuCj4gSW4gRW1hY3MsIHBy
ZXNzaW5nIHRoZSBUQUIga2V5IGFsaWducywgYWZ0ZXIgd2hpY2ggcHJlc3NpbmcgaXQgbW9yZQo+
IGRvZXMgbm90aGluZyAob24gYW4gYWxpZ25lZCBsaW5lKS4KPgo+IFJlZ2FyZHMsCj4gTHViZW4K
Pgo+Cj4+ICAgdm9pZCBkcm1fc2NoZWRfam9iX2NsZWFudXAoc3RydWN0IGRybV9zY2hlZF9qb2Ig
KmpvYik7Cj4+ICAgdm9pZCBkcm1fc2NoZWRfd2FrZXVwKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxl
ciAqc2NoZWQpOwo+PiAgIHZvaWQgZHJtX3NjaGVkX3N0b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1
bGVyICpzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCk7Cj4+IC0tCj4+IDIuMjUuMAo+
Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBo
dHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQt
Z2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NsdWJlbi50dWlrb3YlNDBhbWQuY29tJTdDYmU4NDQ1OTQ1
YzE5NGJkOGIzY2MwOGQ3YmY3MTA5YzUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3MTg4MzY0NTU3MzU0MjE3JmFtcDtzZGF0YT1VQXhWMk50a05jajZWWEFQ
aERiazRHbGlVT25QRWZ1TE9INEJWdU9ycWR3JTNEJmFtcDtyZXNlcnZlZD0wCj4+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
