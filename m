Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62745C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4D92071E
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4D92071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0615A6E135;
	Tue, 26 Nov 2019 15:06:07 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790087.outbound.protection.outlook.com [40.107.79.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58E26E135
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 15:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPhgR+mWTrlzgnX6wX/mrPH7oSnGKAAtaPYPql9//nCNGzpseSIfhn6evP4ACLek4QM+b7GFSRzr06QeWbrzZqS/Rqc/wRY+Qxdl2/6oRsQZ7iCHPQXpF0IminuGOWX29Qk6oFJhStHcqVfaGVpvDGruZ40K5aFJ7fKC8bJvwP6MhxnGRP/xkqegocxvOfLekL0SyX5JhSD9wXNBsl/lUq0WNJ0bBaMl4n300hJKVkfdwFy0+PiMCSpZjtGo6kRY+mFO6G0xLbs+u5qaIfMyPi4A17NsXuOE+wAqbCIOPj10EOw9amLS7rnbW6ufpaNo6sAF0WY6obR/IsxVNgVhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68fCFy8hcwShWcgdOrKfXQ5JOHdAgmb0UKDo2AGzbWk=;
 b=d4d8tw4Re8Chsdll30v67E/rYgytBjJIEVnc+9tFOnQC0izZzBtC/+vRtJGyibr+eHYxsKEt/bl9AHgFdFbJcCk+p2hWK6FkxtLU3RX+v0mJ2neflAKERW+iQbeKzAdWff9JBOjDsbCCNkE/JjjBS/dnOXIRmJtD1nrJdNgoQILkh0FeLFEqEKCvGXAYh7PPfSktZBkHKPfgiSPROsvo0Cf2196PV7JjykHS6E5+/3nnBHgFn7koObs/+e96FTj6J5/j+GV5/9tYQZ0+WvnA3AkpOGlHyegb1a46gDRxxJAUnI8yzvsR6FPsTabKrbHak7FrOpZcjPBXQsdRLBRrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 15:06:04 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:06:04 +0000
Subject: Re: [PATCH v7 10/17] drm/dp_mst: Manually overwrite PBN divider for
 calculating timeslots
To: amd-gfx@lists.freedesktop.org
References: <20191116220128.16598-1-mikita.lipski@amd.com>
 <20191116220128.16598-11-mikita.lipski@amd.com>
From: Leo <sunpeng.li@amd.com>
Message-ID: <3db74a68-91ff-3c7b-306a-d646979975e1@amd.com>
Date: Tue, 26 Nov 2019 10:06:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191116220128.16598-11-mikita.lipski@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23caad3b-c6e8-4e63-0351-08d772822812
X-MS-TrafficTypeDiagnostic: BN7PR12MB2593:
X-Microsoft-Antispam-PRVS: <BN7PR12MB25931A03C6266987440279CB82450@BN7PR12MB2593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(189003)(199004)(8936002)(305945005)(7736002)(36756003)(186003)(81166006)(81156014)(316002)(6246003)(99286004)(66476007)(66556008)(66946007)(52116002)(23676004)(31696002)(2486003)(31686004)(26005)(8676002)(76176011)(58126008)(50466002)(6916009)(86362001)(2351001)(53546011)(2361001)(478600001)(6506007)(386003)(6512007)(2906002)(4001150100001)(6486002)(14454004)(230700001)(6436002)(25786009)(65806001)(65956001)(66066001)(2616005)(446003)(11346002)(47776003)(5660300002)(6116002)(229853002)(3846002)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2593;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jeid/QXsq7geFoqKMjK7e/TQbfeYJUeYyNeZTpVkIbk92Sag0sq+184LUyO5+GuhFoPOvykA2nEq8AkekVGECx8GSbvvtn6Ssf1S97qt8nkRf4RhfD0J8uoe+nJb0kjVRDXw/D+2V6iR1J6ykt0c4JGrwji8/tPQEd/cJkxwF9ywrOasku6zMGp7YMKvXloSwybb213IyZnGzaVS/bNfDun+EmwsB6Rz42GouAZZ9Qb+i4BQzzXcWmuO1ZUnLYBptCP3IFeckV1rQWuBF+fuZXdXuneeEUgSOxXAsR8Jf9SFllN0PWt2C33ZY4nMCIVcxKGMdSDSsbvdwCbe3ovwBym4LQCExakqG9YH+gp3j0j+dSLcF4t0GGH3qfhEqVwb2z/N1b1B061cPgaQNjj3B/9mnmMOadNMQ5BGmbFa5Xta8AgRylMC/V6XxOkMpsnE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23caad3b-c6e8-4e63-0351-08d772822812
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:06:04.2327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOY34crv/I74jSklaux8Wkb6wzz0ucqm0OLJ1M2QpKpl+coDmwcGySRKaedu+GcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2593
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68fCFy8hcwShWcgdOrKfXQ5JOHdAgmb0UKDo2AGzbWk=;
 b=derZK0YgQF367UEBJ/yC8bMGnsgrRU9f2SBOPICwYYaBjonDsJWRS13jD36rl5vsOzBug7AcToqQLa4WIjP1tk8zPGyui7eM5oldmUXpW6Q5sQG/Lk2+1aCyWJCVSw0o+18C23bdCZVX5B/o5ic13/1rFWV23ZRYow+qSodjCRs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126150602.Vz7UiI7VA9NLpx7jNekr_FKGdxrUCD0eSHPpvomfJFw@z>

UmV2aWV3ZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgoKT24gMjAxOS0xMS0xNiA1
OjAxIHAubS4sIG1pa2l0YS5saXBza2lAYW1kLmNvbSB3cm90ZToKPiBGcm9tOiBNaWtpdGEgTGlw
c2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gCj4gW3doeV0KPiBGb3IgRFNDIGNhc2Ugd2Ug
Y2Fubm90IGFsd2F5cyB1c2UgdG9wb2xvZ3kgbWFuYWdlcidzIFBCTiBkaXZpZGVyCj4gdmFyaWFi
bGUuIFRoZSBkZWZhdWx0IGRpdmlkZXIgZG9lcyBub3QgdGFrZSBGRUMgaW50byBhY2NvdW50Lgo+
IFRoZXJlZm9yZSB3ZSBzaG91bGQgYWxsb3cgZHJpdmVyIHRvIGNhbGN1bGF0ZSBpdHMgb3duIGRp
dmlkZXIgYmFzZWQKPiBvbiB0aGUgbGluayByYXRlIGFuZCBjb3VudCBpdHMgaGFuZGxpbmcsIGFz
IGl0IGlzIGh3IHNwZWNpZmljLgo+IFtob3ddCj4gUGFzcyBwYm5fZGl2IGFzIGFuIGFyZ3VtZW50
LCB3aGljaCB3aWxsIGJlIHVzZWQgaWYgaXRzIG1vcmUgdGhhbgo+IHplcm8sIG90aGVyd2lzZSBk
ZWZhdWx0IHRvcG9sb2d5IG1hbmFnZXIncyBwYm5fZGl2IHdpbGwgYmUgdXNlZC4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICsr
LQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jICAgICAgICAgICAgIHwg
OSArKysrKysrLS0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9tc3Qu
YyAgICAgICB8IDIgKy0KPiAgZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvZGlzcG52NTAvZGlzcC5j
ICAgICAgICAgICB8IDMgKystCj4gIGluY2x1ZGUvZHJtL2RybV9kcF9tc3RfaGVscGVyLmggICAg
ICAgICAgICAgICAgICAgfCAzICsrLQo+ICA1IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gaW5kZXggNmMzMmI3M2M1MTk3Li4zNjU3YTI2Y2Ux
ZDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPiBAQCAtNDk3Miw3ICs0OTcyLDggQEAgc3RhdGljIGludCBkbV9lbmNvZGVy
X2hlbHBlcl9hdG9taWNfY2hlY2soc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyLAo+ICAJZG1f
bmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90cyA9IGRybV9kcF9hdG9taWNfZmluZF92Y3Bp
X3Nsb3RzKHN0YXRlLAo+ICAJCQkJCQkJCQkgICBtc3RfbWdyLAo+ICAJCQkJCQkJCQkgICBtc3Rf
cG9ydCwKPiAtCQkJCQkJCQkJICAgZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+cGJuKTsKPiArCQkJ
CQkJCQkJICAgZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+cGJuLAo+ICsJCQkJCQkJCQkgICAwKTsK
PiAgCWlmIChkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT52Y3BpX3Nsb3RzIDwgMCkgewo+ICAJCURS
TV9ERUJVR19BVE9NSUMoImZhaWxlZCBmaW5kaW5nIHZjcGkgc2xvdHM6ICVkXG4iLCAoaW50KWRt
X25ld19jb25uZWN0b3Jfc3RhdGUtPnZjcGlfc2xvdHMpOwo+ICAJCXJldHVybiBkbV9uZXdfY29u
bmVjdG9yX3N0YXRlLT52Y3BpX3Nsb3RzOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xv
Z3kuYwo+IGluZGV4IGQ1ZGYwMjMxNWUxNC4uOTRiYjI1OWFiNzNlIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gQEAgLTMyMTEsNiArMzIxMSw3IEBAIHN0YXRpYyBp
bnQgZHJtX2RwX2luaXRfdmNwaShzdHJ1Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1nciwK
PiAgICogQG1ncjogTVNUIHRvcG9sb2d5IG1hbmFnZXIgZm9yIHRoZSBwb3J0Cj4gICAqIEBwb3J0
OiBwb3J0IHRvIGZpbmQgdmNwaSBzbG90cyBmb3IKPiAgICogQHBibjogYmFuZHdpZHRoIHJlcXVp
cmVkIGZvciB0aGUgbW9kZSBpbiBQQk4KPiArICogQHBibl9kaXY6IGRpdmlkZXIgZm9yIERTQyBt
b2RlIHRoYXQgdGFrZXMgRkVDIGludG8gYWNjb3VudAo+ICAgKgo+ICAgKiBBbGxvY2F0ZXMgVkNQ
SSBzbG90cyB0byBAcG9ydCwgcmVwbGFjaW5nIGFueSBwcmV2aW91cyBWQ1BJIGFsbG9jYXRpb25z
IGl0Cj4gICAqIG1heSBoYXZlIGhhZC4gQW55IGF0b21pYyBkcml2ZXJzIHdoaWNoIHN1cHBvcnQg
TVNUIG11c3QgY2FsbCB0aGlzIGZ1bmN0aW9uCj4gQEAgLTMyMzcsNyArMzIzOCw4IEBAIHN0YXRp
YyBpbnQgZHJtX2RwX2luaXRfdmNwaShzdHJ1Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1n
ciwKPiAgICovCj4gIGludCBkcm1fZHBfYXRvbWljX2ZpbmRfdmNwaV9zbG90cyhzdHJ1Y3QgZHJt
X2F0b21pY19zdGF0ZSAqc3RhdGUsCj4gIAkJCQkgIHN0cnVjdCBkcm1fZHBfbXN0X3RvcG9sb2d5
X21nciAqbWdyLAo+IC0JCQkJICBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0LCBpbnQgcGJu
KQo+ICsJCQkJICBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0LCBpbnQgcGJuLAo+ICsJCQkJ
ICBpbnQgcGJuX2RpdikKPiAgewo+ICAJc3RydWN0IGRybV9kcF9tc3RfdG9wb2xvZ3lfc3RhdGUg
KnRvcG9sb2d5X3N0YXRlOwo+ICAJc3RydWN0IGRybV9kcF92Y3BpX2FsbG9jYXRpb24gKnBvcywg
KnZjcGkgPSBOVUxMOwo+IEBAIC0zMjcwLDcgKzMyNzIsMTAgQEAgaW50IGRybV9kcF9hdG9taWNf
ZmluZF92Y3BpX3Nsb3RzKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKPiAgCWlmICgh
dmNwaSkKPiAgCQlwcmV2X3Nsb3RzID0gMDsKPiAgCj4gLQlyZXFfc2xvdHMgPSBESVZfUk9VTkRf
VVAocGJuLCBtZ3ItPnBibl9kaXYpOwo+ICsJaWYgKHBibl9kaXYgPD0gMCkKPiArCQlwYm5fZGl2
ID0gbWdyLT5wYm5fZGl2Owo+ICsKPiArCXJlcV9zbG90cyA9IERJVl9ST1VORF9VUChwYm4sIHBi
bl9kaXYpOwo+ICAKPiAgCURSTV9ERUJVR19BVE9NSUMoIltDT05ORUNUT1I6JWQ6JXNdIFtNU1Qg
UE9SVDolcF0gVkNQSSAlZCAtPiAlZFxuIiwKPiAgCQkJIHBvcnQtPmNvbm5lY3Rvci0+YmFzZS5p
ZCwgcG9ydC0+Y29ubmVjdG9yLT5uYW1lLAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2RwX21zdC5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9kcF9tc3QuYwo+IGluZGV4IGRmYWM0NTA4NDFkZi4uMjEyM2FjMjkzOWYwIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBfbXN0LmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX21zdC5jCj4gQEAgLTY1
LDcgKzY1LDcgQEAgc3RhdGljIGludCBpbnRlbF9kcF9tc3RfY29tcHV0ZV9saW5rX2NvbmZpZyhz
dHJ1Y3QgaW50ZWxfZW5jb2RlciAqZW5jb2RlciwKPiAgCQkJCQkJICAgICAgIGZhbHNlKTsKPiAg
Cj4gIAkJc2xvdHMgPSBkcm1fZHBfYXRvbWljX2ZpbmRfdmNwaV9zbG90cyhzdGF0ZSwgJmludGVs
X2RwLT5tc3RfbWdyLAo+IC0JCQkJCQkgICAgICBwb3J0LCBjcnRjX3N0YXRlLT5wYm4pOwo+ICsJ
CQkJCQkgICAgICBwb3J0LCBjcnRjX3N0YXRlLT5wYm4sIDApOwo+ICAJCWlmIChzbG90cyA9PSAt
RURFQURMSykKPiAgCQkJcmV0dXJuIHNsb3RzOwo+ICAJCWlmIChzbG90cyA+PSAwKQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9kaXNwbnY1MC9kaXNwLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbm91dmVhdS9kaXNwbnY1MC9kaXNwLmMKPiBpbmRleCBjNDU4MzIyMzBjY2MuLjI3
YzVmZjk5Zjc3ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9kaXNwbnY1
MC9kaXNwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9kaXNwbnY1MC9kaXNwLmMK
PiBAQCAtNzg0LDcgKzc4NCw4IEBAIG52NTBfbXN0b19hdG9taWNfY2hlY2soc3RydWN0IGRybV9l
bmNvZGVyICplbmNvZGVyLAo+ICAJaWYgKGNydGNfc3RhdGUtPm1vZGVfY2hhbmdlZCkgewo+ICAJ
CXNsb3RzID0gZHJtX2RwX2F0b21pY19maW5kX3ZjcGlfc2xvdHMoc3RhdGUsICZtc3RtLT5tZ3Is
Cj4gIAkJCQkJCSAgICAgIG1zdGMtPnBvcnQsCj4gLQkJCQkJCSAgICAgIGFzeWgtPmRwLnBibik7
Cj4gKwkJCQkJCSAgICAgIGFzeWgtPmRwLnBibiwKPiArCQkJCQkJICAgICAgMCk7Cj4gIAkJaWYg
KHNsb3RzIDwgMCkKPiAgCQkJcmV0dXJuIHNsb3RzOwo+ICAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaCBiL2luY2x1ZGUvZHJtL2RybV9kcF9tc3RfaGVscGVy
LmgKPiBpbmRleCA0Y2Y3Mzg1NDVkZmIuLmZjMTkwOTRiMDZjMyAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL2RybS9kcm1fZHBfbXN0X2hlbHBlci5oCj4gKysrIGIvaW5jbHVkZS9kcm0vZHJtX2RwX21z
dF9oZWxwZXIuaAo+IEBAIC02NjEsNyArNjYxLDggQEAgc3RydWN0IGRybV9kcF9tc3RfdG9wb2xv
Z3lfc3RhdGUgKmRybV9hdG9taWNfZ2V0X21zdF90b3BvbG9neV9zdGF0ZShzdHJ1Y3QgZHJtX2EK
PiAgaW50IF9fbXVzdF9jaGVjawo+ICBkcm1fZHBfYXRvbWljX2ZpbmRfdmNwaV9zbG90cyhzdHJ1
Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4gIAkJCSAgICAgIHN0cnVjdCBkcm1fZHBfbXN0
X3RvcG9sb2d5X21nciAqbWdyLAo+IC0JCQkgICAgICBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpw
b3J0LCBpbnQgcGJuKTsKPiArCQkJICAgICAgc3RydWN0IGRybV9kcF9tc3RfcG9ydCAqcG9ydCwg
aW50IHBibiwKPiArCQkJICAgICAgaW50IHBibl9kaXYpOwo+ICBpbnQgX19tdXN0X2NoZWNrCj4g
IGRybV9kcF9hdG9taWNfcmVsZWFzZV92Y3BpX3Nsb3RzKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRl
ICpzdGF0ZSwKPiAgCQkJCSBzdHJ1Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1nciwKPiAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
