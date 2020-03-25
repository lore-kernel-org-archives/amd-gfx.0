Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D84C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C76B20714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U1s212XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C76B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DF86E7E5;
	Wed, 25 Mar 2020 10:59:24 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50EA6E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnEscBhHShHr7D2TUaklaP8WxNEzlquCuj/HrM2j2376pQDcoGiA3KbayjI5cWu9J4kxx+H0lgOZT2wVtHUO15W8z3vX/Kfvl/IqGFwhbBO0eVvK/vKgINnsvsK50lWCe8Ea71kCuvlW/RMmwFNTrn3Ymo/4Vw6zqSWmXeeVgYPVtYKCeoeZ3IWzxJMaNqNro2lXw1qQ6dsNOtyjFDNYRtr2Fh1o1HLvex6gv6CTgByJ/rK4OQGGm0KX5iuOyBqYwgaS/BsQxEmv139r75Kze8bwN3Kbn2fwEAGI4wlrEXxKa3L+Wd0e90E3tT5leJJAjVOPx0OrPiZITbzLu+reJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLDCyA+Q3U6/DgCXKrTOukFLVrC7//GBu4ZplyIm3QA=;
 b=f4KM6J7C+p5v38oDyOBLqHEyjqSChUgItFS8G/idw9nHCwSh2k4UxrrLoqhGE/BDTewW3abVP86gPrvENR9+j2rVVVZLdu0Ekttxgb2jdXFxXimz+EEm2vJmQncUCwfsjW94eoyRH5jTX8l7KZSBmYrFba81iUgOIddeIbEkTLypUdlHKJkYfqjo/AXv2M0fHuJ8pdVHtAXFyPyOOeMH7u1TmGOFcC+4G72KYpNDlEkQcYYptCwLXu1433/IN8rxwIqHipJiWj8vSdrLkiLfAAL308Gxd4zxfnzIGSuge+jjv2Y3V+VztCnxZjcjQ+XW1O2tP9pOc4HshjfYqQUQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLDCyA+Q3U6/DgCXKrTOukFLVrC7//GBu4ZplyIm3QA=;
 b=U1s212XLE0Nn2tHZ4DZHgA46M1cce1d6PV1a6HTNJ094Sw2G63juQGB80SCJtgtBnmwue0oOocrHWAouc5Z4S/njLg3QuZd4M1Nr955fVKcN1+S3gXLis7P6jZmoersx95uGtAzpqacWblRD2GtZlpG8sdOR2EqatHA/uNjTCDU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3152.namprd12.prod.outlook.com (2603:10b6:208:ca::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 10:59:20 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:59:20 +0000
Subject: Re: [PATCH] drm/amdgpu: Check entity rq
To: amd-gfx@lists.freedesktop.org
References: <20200325054723.4560-1-xinhui.pan@amd.com>
 <15d695c5-539b-2461-c265-d3590f1540e5@amd.com>
 <E108D9FC-CE64-4F4F-B5C9-08780CFF1356@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <985d6068-7dd9-b305-e34f-d9c59a6db11b@amd.com>
Date: Wed, 25 Mar 2020 12:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <E108D9FC-CE64-4F4F-B5C9-08780CFF1356@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::14) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0]
 (2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0) by
 AM0PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:208:ab::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 10:59:20 +0000
X-Originating-IP: [2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbb62d57-d044-4d16-db1b-08d7d0ab9217
X-MS-TrafficTypeDiagnostic: MN2PR12MB3152:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3152553339746D364123C2848BCE0@MN2PR12MB3152.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(2906002)(36756003)(8676002)(31696002)(81166006)(66476007)(66574012)(2616005)(66556008)(31686004)(6916009)(8936002)(5660300002)(66946007)(81156014)(45080400002)(52116002)(478600001)(16526019)(186003)(316002)(6486002)(966005)(6666004)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3152;
 H:MN2PR12MB3872.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqugjsQWmDYOAOvQan03eSYhqeUGj13QOxrkycqfzyHKQgeX1rX3dS5CS+7GnlHmv7RB+qzKq8B+IE9ci5zRUnkwJNeBWg5kwfaHkAn8Es/8P6L1JmrzR9ZBI8/OkVzL1ZtpB7/PL8u7/KJj3vHS6Uh7XunJxzgSgd03vAYfXe9G9eJU63N1aBDt3MW0KrVIbIuTJ23v4TcG5xyKllrJrkTSubWQe+OTsdstFDGwVIx2ENOmQEiOC817eV4G5Pfbw6XWFsBJITCAkQIBCFlwxoPy7wwvHyIbm2TN0JbBwgIFgGGof6m+MShysHqWOqAvUkqCEfqPPnNqoE+y2EmbaDoRuEnxRpg24jY613mUMvOaxG0cOJyp7EkST+lXOyKso7rGYrezMHBinmFwgylW7ZPOHXLofQhkhQOnBA0BP//84lpzwCiKaedDTv3ACG1t9rRlMWMlLsfkfmTixCdrp6ziL6uF2PjhEORo/jT3zVY=
X-MS-Exchange-AntiSpam-MessageData: uy566S8MgxRbKvqlEuXiSznOoRYeftz8kzoECw2CuAMUfxVp4gMDZJshABpAAaWIu1T40UOUWN4ZwR2e9iHZkFJbaaonwZPo2VgCE52IoW9nVtZnhyjex7mcMuksEvLm5Ier7a2zZwPaeO3vLUvvMRumI9byD76i0NJpvQsg7t1IJXfSbtwwO8tck2VSt2jCidPcgb/2CCSaagcHJyz85w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb62d57-d044-4d16-db1b-08d7d0ab9217
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 10:59:20.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1/DZ7DAqW1eN8Ux2nlAjc5FOxtUL9Uy0jEU2IilW8zlxz2865YPGyWgewOh5266LuF2wi+a2O33VDN5zQJY+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3152
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

Ck9uIDMvMjUvMjAgMTA6MjMgQU0sIFBhbiwgWGluaHVpIHdyb3RlOgo+Cj4+IDIwMjDlubQz5pyI
MjXml6UgMTU6NDjvvIxLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PiDlhpnpgZPvvJoKPj4KPj4gQW0gMjUuMDMuMjAgdW0gMDY6NDcgc2NocmllYiB4aW5odWkgcGFu
Ogo+Pj4gSGl0IHBhbmljIGR1cmluZyBHUFUgcmVjb3ZlcnkgdGVzdC4gZHJtX3NjaGVkX2VudGl0
eV9zZWxlY3RfcnEgbWlnaHQKPj4+IHNldCBOVUxMIHRvIHJxLiBTbyBhZGQgYSBjaGVjayBsaWtl
IGRybV9zY2hlZF9qb2JfaW5pdCBkb2VzLgo+PiBOQUssIHRoZSBycSBzaG91bGQgbmV2ZXIgYmUg
c2V0IHRvIE5VTEwgaW4gdGhlIGZpcnN0IHBsYWNlLgo+Pgo+PiBIb3cgZGlkIHRoYXQgaGFwcGVu
ZWQ/Cj4gd2VsbCwgSSBoYXZlIG5vdCBjaGVjayB0aGUgZGV0YWlscy4KPiBidXQganVzdCBnb3Qg
dGhlIGNhbGwgdHJhY2UgYmVsb3cuCj4gbG9va3MgbGlrZSBzY2hlZCBpcyBub3QgcmVhZHksIGFu
ZCBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycSBzZXQgZW50aXR5LT5ycSB0byBOVUxMLgo+IGlu
IHRoZSBuZXh0IGFtZGdwdV92bV9zZG1hX2NvbW1pdCwgaGl0IHBhbmljIHdoZW4gd2UgZGVmZXJl
bmNlIGVudGl0eS0+cnEuCgoiZHJtL2FtZGdwdTogc3RvcCBkaXNhYmxlIHRoZSBzY2hlZHVsZXIg
ZHVyaW5nIEhXIGZpbmkiIGZyb20gQ2hyaXN0aWFuIApzaG91bGQndmUgZml4IGl0IGFscmVhZHku
IEJ1dAoKSSBjYW4ndCBmaW5kIHRoYXQgY29tbWl0IGluIGJyYWhtYS9hbWQtc3RhZ2luZy1kcm0t
bmV4dC4KClJlZ2FyZHMsCgpOaXJtb3kKCj4KPiAyOTc1NjcgWyAgIDQ0LjY2NzY3N10gYW1kZ3B1
IDAwMDA6MDM6MDAuMDogR1BVIHJlc2V0IGJlZ2luIQo+IDI5NzU2OCBbICAgNDQuOTI5MDQ3XSBb
ZHJtXSBzY2hlZHVsZXIgc2RtYTAgaXMgbm90IHJlYWR5LCBza2lwcGluZwo+IDI5NzU2OSBbICAg
NDQuOTI5MDQ4XSBbZHJtXSBzY2hlZHVsZXIgc2RtYTEgaXMgbm90IHJlYWR5LCBza2lwcGluZwo+
IDI5NzU3MCBbICAgNDQuOTM0NjA4XSBbZHJtOmFtZGdwdV9nZW1fdmFfaW9jdGwgW2FtZGdwdV1d
ICpFUlJPUiogQ291bGRuJ3QgdXBkYXRlIEJPX1ZBICgtMikKPiAyOTc1NzEgWyAgIDQ0Ljk0Nzk0
MV0gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAw
MDAwMDAwMDM4Cj4gMjk3NTcyIFsgICA0NC45NTUxMzJdICNQRjogc3VwZXJ2aXNvciByZWFkIGFj
Y2VzcyBpbiBrZXJuZWwgbW9kZQo+IDI5NzU3MyBbICAgNDQuOTYwNDUxXSAjUEY6IGVycm9yX2Nv
ZGUoMHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKPiAyOTc1NzQgWyAgIDQ0Ljk2NTcxNF0gUEdE
IDAgUDREIDAKPiAyOTc1NzUgWyAgIDQ0Ljk2ODMzMV0gT29wczogMDAwMCBbIzFdIFNNUCBQVEkK
PiAyOTc1NzYgWyAgIDQ0Ljk3MTkxMV0gQ1BVOiA3IFBJRDogMjQ5NiBDb21tOiBnbm9tZS1zaGVs
bCBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgNS40LjAtcmM3KyAjMQo+IDI5NzU3NyBbICAg
NDQuOTgwMjIxXSBIYXJkd2FyZSBuYW1lOiBTeXN0ZW0gbWFudWZhY3R1cmVyIFN5c3RlbSBQcm9k
dWN0IE5hbWUvWjE3MC1BLCBCSU9TIDE3MDIgMDEvMjgvMjAxNgo+IDI5NzU3OCBbICAgNDQuOTg5
MTc3XSBSSVA6IDAwMTA6YW1kZ3B1X3ZtX3NkbWFfY29tbWl0KzB4NTUvMHgxOTAgW2FtZGdwdV0K
PiAyOTc1NzkgWyAgIDQ0Ljk5NTI0Ml0gQ29kZTogNDcgMjAgODAgN2YgMTAgMDAgNGMgOGIgYTAg
ODggMDEgMDAgMDAgNDggOGIgNDcgMDggNGMgOGQgYTggNzAgMDEgMDAgMDAgNzUgMDcgNGMgOGQg
YTggODggMDIgMDAgMDAgNDkgOGIgNDUgMTAgNDEgOGIgNTQgMjQgMDggPDQ4PiA4YiA0MCAzOCA4
NSBkMiA0OCA4ZCBiOCAzMCBmZiBmZiBmICAgICAgIGYgMGYgODQgMDYgMDEgMDAgMDAgNDggOGIg
ODAKPiAyOTc1ODAgWyAgIDQ1LjAxNDkzMV0gUlNQOiAwMDE4OmZmZmZiNjZlMDA4ODM5ZDAgRUZM
QUdTOiAwMDAxMDI0Ngo+IDI5NzU4MSBbICAgNDUuMDIwNTA0XSBSQVg6IDAwMDAwMDAwMDAwMDAw
MDAgUkJYOiBmZmZmYjY2ZTAwODgzYTMwIFJDWDogMDAwMDAwMDAwMDEwMDQwMAo+IDI5NzU4MiBb
ICAgNDUuMDI4MDYyXSBSRFg6IDAwMDAwMDAwMDAwMDAwM2MgUlNJOiBmZmZmOGRmMTIzNjYyMTM4
IFJESTogZmZmZmI2NmUwMDg4M2EzMAo+IDI5NzU4MyBbICAgNDUuMDM1NjYyXSBSQlA6IGZmZmZi
NjZlMDA4ODNhMDAgUjA4OiBmZmZmYjY2ZTAwODgzOTVjIFIwOTogZmZmZmI2NmUwMDg4Mzk2MAo+
IDI5NzU4NCBbICAgNDUuMDQzMjk4XSBSMTA6IDAwMDAwMDAwMDAxMDAyNDAgUjExOiAwMDAwMDAw
MDAwMDAwMDM1IFIxMjogZmZmZjhkZjE0MjUzODVlOAo+IDI5NzU4NSBbICAgNDUuMDUwOTE2XSBS
MTM6IGZmZmY4ZGYxM2NmZDEyODggUjE0OiBmZmZmOGRmMTIzNjYyMTM4IFIxNTogZmZmZjhkZjEz
Y2ZkMTAwMAo+IDI5NzU4NiBbICAgNDUuMDU4NTI0XSBGUzogIDAwMDA3ZmNjOGY2YjIxMDAoMDAw
MCkgR1M6ZmZmZjhkZjE1ZTM4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCj4gMjk3
NTg3IFsgICA0NS4wNjcxMTRdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwMzMKPiAyOTc1ODggWyAgIDQ1LjA3MzIwNl0gQ1IyOiAwMDAwMDAwMDAwMDAwMDM4
IENSMzogMDAwMDAwMDY0MWZiNjAwNiBDUjQ6IDAwMDAwMDAwMDAzNjA2ZTAKPiAyOTc1ODkgWyAg
IDQ1LjA4MDc5MV0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBE
UjI6IDAwMDAwMDAwMDAwMDAwMDAKPiAyOTc1OTAgWyAgIDQ1LjA4ODI3N10gRFIzOiAwMDAwMDAw
MDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKPiAy
OTc1OTEgWyAgIDQ1LjA5NTc3M10gQ2FsbCBUcmFjZToKPiAyOTc1OTIgWyAgIDQ1LjA5ODM1NF0g
IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZysweDFjMS8weDFmMCBbYW1kZ3B1XQo+IDI5NzU5
MyBbICAgNDUuMTA0NDI3XSAgPyBtYXJrX2hlbGRfbG9ja3MrMHg0ZC8weDgwCj4gMjk3NTk0IFsg
ICA0NS4xMDg2ODJdICBhbWRncHVfdm1fYm9fdXBkYXRlKzB4M2I3LzB4OTYwIFthbWRncHVdCj4g
Mjk3NTk1IFsgICA0NS4xMTQwNDldICA/IHJjdV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweDRmLzB4
ODAKPiAyOTc1OTYgWyAgIDQ1LjExOTExMV0gIGFtZGdwdV9nZW1fdmFfaW9jdGwrMHg0ZjMvMHg1
MTAgW2FtZGdwdV0KPiAyOTc1OTcgWyAgIDQ1LjEyNDQ5NV0gID8gYW1kZ3B1X2dlbV92YV9tYXBf
ZmxhZ3MrMHg3MC8weDcwIFthbWRncHVdCj4gMjk3NTk4IFsgICA0NS4xMzAyNTBdICBkcm1faW9j
dGxfa2VybmVsKzB4YjAvMHgxMDAgW2RybV0KPiAyOTc1OTkgWyAgIDQ1LjEzNDk4OF0gID8gYW1k
Z3B1X2dlbV92YV9tYXBfZmxhZ3MrMHg3MC8weDcwIFthbWRncHVdCj4gMjk3NjAwIFsgICA0NS4x
NDA3NDJdICA/IGRybV9pb2N0bF9rZXJuZWwrMHhiMC8weDEwMCBbZHJtXQo+IDI5NzYwMSBbICAg
NDUuMTQ1NjIyXSAgZHJtX2lvY3RsKzB4Mzg5LzB4NDUwIFtkcm1dCj4gMjk3NjAyIFsgICA0NS4x
NDk4MDRdICA/IGFtZGdwdV9nZW1fdmFfbWFwX2ZsYWdzKzB4NzAvMHg3MCBbYW1kZ3B1XQo+IDI5
NzYwMyBbICAgNDUuMTU1NTUxXSAgPyB0cmFjZV9oYXJkaXJxc19vbisweDNiLzB4ZjAKPiAyOTc2
MDQgWyAgIDQ1LjE1OTg5Ml0gIGFtZGdwdV9kcm1faW9jdGwrMHg0Zi8weDgwIFthbWRncHVdCj4g
Mjk3NjA1IFsgICA0NS4xNzIxMDRdICBkb192ZnNfaW9jdGwrMHhhOS8weDZmMAo+IDI5NzYwNiBb
ICAgNDUuMTc1OTA5XSAgPyB0b21veW9fZmlsZV9pb2N0bCsweDE5LzB4MjAKPiAyOTc2MDcgWyAg
IDQ1LjE4MDI0MV0gIGtzeXNfaW9jdGwrMHg3NS8weDgwCj4gMjk3NjA4IFsgICA0NS4xODM3NjBd
ICA/IGRvX3N5c2NhbGxfNjQrMHgxNy8weDIzMAo+IDI5NzYwOSBbICAgNDUuMTg3ODMzXSAgX194
NjRfc3lzX2lvY3RsKzB4MWEvMHgyMAo+IDI5NzYxMCBbICAgNDUuMTkxODQ2XSAgZG9fc3lzY2Fs
bF82NCsweDVmLzB4MjMwCj4gMjk3NjExIFsgICA0NS4xOTU3NjRdICBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJlCj4gMjk3NjEyIFsgICA0NS4yMDExMjZdIFJJUDogMDAz
MzoweDdmY2M4Yzc3MjVkNwo+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IENjOiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+PiBDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4gQ2M6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8
eGluaHVpLnBhbkBhbWQuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bV9zZG1hLmMgfCAyICsrCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9z
ZG1hLmMKPj4+IGluZGV4IGNmOTZjMzM1YjI1OC4uZDMwZDEwM2U0OGEyIDEwMDY0NAo+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+Pj4gQEAgLTk1LDYg
Kzk1LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1fc2RtYV9jb21taXQoc3RydWN0IGFtZGdwdV92
bV91cGRhdGVfcGFyYW1zICpwLAo+Pj4gICAJaW50IHI7Cj4+PiAgICAgCWVudGl0eSA9IHAtPmRp
cmVjdCA/ICZwLT52bS0+ZGlyZWN0IDogJnAtPnZtLT5kZWxheWVkOwo+Pj4gKwlpZiAoIWVudGl0
eS0+cnEpCj4+PiArCQlyZXR1cm4gLUVOT0VOVDsKPj4+ICAgCXJpbmcgPSBjb250YWluZXJfb2Yo
ZW50aXR5LT5ycS0+c2NoZWQsIHN0cnVjdCBhbWRncHVfcmluZywgc2NoZWQpOwo+Pj4gICAgIAlX
QVJOX09OKGliLT5sZW5ndGhfZHcgPT0gMCk7Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbmlybW95LmRhcyU0
MGFtZC5jb20lN0NkMjkzYWY4Mjk2OWI0NDUwNDJlMDA4ZDdkMDllM2Y1MyU3QzNkZDg5NjFmZTQ4
ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcyMDcyNTA0NDE5NTYyMDEmYW1wO3Nk
YXRhPWN2VyUyQiUyRmxtYmVlb3ZTNEVIazRWanRDMU1UYUNBVmpIVFYlMkZpdFNvQW9PRDQlM0Qm
YW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
