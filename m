Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F91C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316BA20678
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DsVZKl30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316BA20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68866E943;
	Mon, 20 Jan 2020 13:03:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889256E943
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 13:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv25652UM8c+mWwDa/cMfN37BvzqPWytvGd8TgjsrILLi3YZiNNwj5SwV1vpFHnH6pgR04GYs1ktChkoJBpUDkgBvZti3gdrcm0VwpicQ4XUBX9QDC0lZaDAQNh9eEsSDMC/pKEjqBTWIxPnkzlwnGniwnppqKHVukw1O4Y5EP5xCWBjJ3BW97AjoVt25UceFvNJO99bDo18dmgXTzPOYOEK5oYZk/x/0lC8tsA0IyFFcUdTF8kAkcPCoLo9LH3CI6jDWNwz//qmy4528blWGk6ERAgnsHKIT8jlwGNN3YQzh/6bfr7ovneO2t7r2ypFwS8A0ANTpIuzV88a5VoJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rdrKDn0lGliCG9v5NzTu7zL0QM0Iw0RvFQIwiPEWSQ=;
 b=ClOr3glPSUvjSTD/YtlUMMEcOA8VKcwTHiGb9B8cWt4wvG8zQPlg6g8REE/M+OLzU0jSqGBkjcR16nsV6jI5+s8PW/ABbRU2xwMi5djGkxuRUkA8zi3Z2UBsyxnlHJtyDBHp7A7EI5hCdgsVn1eWMOPBGQx+z1UYEyjmXFlHR6GZdRciDGeenNOUr6mn6Z3y9SgMnXIA2+fWaCKnbu4SbvdooHdgtyqREFfgEKH1wECFLrrQPqh4ndqHONFu1CckS3Yjv/YWWnhucK38tmaNzeAoZGpNFOhK8jR4C81m2nEBL8jXJygMUH3CbNL0+Ouk/Nkxf3nG+Dn+jo2IWGkUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rdrKDn0lGliCG9v5NzTu7zL0QM0Iw0RvFQIwiPEWSQ=;
 b=DsVZKl30dghI0QVrPLTmVF4YVAeT75l4uQ3fHUB0B2NnNEwBnSlPpMyABCoWA8oSgeBLajnOC32fGSK0sGYEdaMdOpbbCUeTJPEzrd1xTGmrseQ9Q7YLrDU6AN25JyQKH96C71sD2O4wW9rdiDqZuPRDTnFs6dnJuzheZLV1csU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1371.namprd12.prod.outlook.com (10.168.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Mon, 20 Jan 2020 13:03:53 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 13:03:53 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: christian.koenig@amd.com, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <2c917837-6f3a-d6a6-1bb0-3ec1fc33a202@amd.com>
Date: Mon, 20 Jan 2020 14:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f25:0:97a4:c6c4:f4a6:fd0b]
 (2003:c5:8f25:0:97a4:c6c4:f4a6:fd0b) by
 ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 13:03:52 +0000
X-Originating-IP: [2003:c5:8f25:0:97a4:c6c4:f4a6:fd0b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 381a9495-ecd1-45a9-006c-08d79da9334d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:|DM5PR12MB1371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13716A714238AFFC64B122F48B320@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(81156014)(8676002)(52116002)(66476007)(66556008)(5660300002)(31686004)(4326008)(478600001)(8936002)(6636002)(53546011)(81166006)(31696002)(2616005)(6666004)(6486002)(2906002)(66946007)(36756003)(316002)(186003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1371;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNFNElgU5DijbY/6YdfZxRfe2xxHNA+ag+7tRg8NCa2rhcTYHZ2yNHbPWQNKTtQMOKE9JJZ1NLK9vFsUU7zCjT8vn4MrAC5BHXw/21iWQCOkMTK4pnDagoDg7w6m8wyXrSLMYi5nvyH+4CzabIYrb0nBL73UaJ4veRBr8sladKKZh6J9IeKfifEzfhH+Vlq3KgJIOo+KSn4kDoF2BtKJqdMbR/zlyL4Zeyjl3kKt/wIuDjMYoCnLzuFXO86aSd2bwBQXuPFlCXSgSh5KtVrc9YJmHyw+JFmp/+kOyTUv2+qZdy2Vs/5wSD/fSOjddbwWY4EqHPY3c9tMjfE/L6Eak+PyQx8/OEpKtCCd0UArlA0EHrIYFtpzk0LBPZpW/PYENNCL5j4cT1NIV9/pWSYKcV8eajbY+JHTNYCN30dSCnJK2lN34kLEa57iWsYY7oCu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381a9495-ecd1-45a9-006c-08d79da9334d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 13:03:53.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SUxSmGYwSJES58iVoAL+Uxo6s5hfHw0lGK3r2GGT8gSqvZoZ7fTukMTs/T4eAfditT8jq209Dao4u/tJpWdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMTEvMjYvMTkgMTA6NDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4gSXQgbG9va3MgbGlrZSBhIHN0YXJ0LCBidXQgdGhlcmUgbnVtZXJvdXMgdGhpbmdzIHdo
aWNoIG5lZWRzIHRvIGJlIGZpeGVkLgo+Cj4gUXVlc3Rpb24gbnVtYmVyIG9uZSBpczogV2hhdCdz
IHRoYXQgZ29vZCBmb3I/IEVudGl0aWVzIGFyZSBub3QgdGhlIAo+IHByb2JsZW0gaGVyZS4gVGhl
IHJlYWwgaXNzdWUgaXMgdGhlIGZlbmNlIHJpbmcgYW5kIHRoZSBycV9saXN0Lgo+Cj4gVGhlIHJx
X2xpc3QgY291bGQgYWN0dWFsbHkgYmUgbWFkZSBjb25zdGFudCBzaW5jZSBpdCBzaG91bGQgbmV2
ZXIgYmUgCj4gY2hhbmdlZCBieSB0aGUgZW50aXR5LiBJdCBpcyBvbmx5IGNoYW5nZWQgZm9yIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkgCj4gaW4gZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHko
KS4KPgo+IFNvIEkgd291bGQgc3RhcnQgdGhlcmUgYW5kIGNsZWFudXAgdGhlIGRybV9zY2hlZF9l
bnRpdHlfc2V0X3ByaW9yaXR5KCkgCj4gdG8gYWN0dWFsbHkganVzdCBzZXQgYSBuZXcgY29uc3Rh
bnQgcnEgbGlzdCBpbnN0ZWFkLgo+Cj4gVGhlbiB3ZSBjb3VsZCBlbWJlZCB0aGUgZmVuY2VzIGlu
IGFtZGdwdV9jdHhfZW50aXR5IGFzIGR5bmFtaWMgYXJyYXkgCj4gYXQgdGhlIGVuZCBvZiB0aGUg
c3RydWN0dXJlLgo+CmFtZGdwdV9jdHhfZW50aXR5IGFscmVhZHkgY29udGFpbnMgYSBmZW5jZSBh
cnJheS4gRG8geW91IG1lYW4gYW5vdGhlciAKZmVuY2UgYXJyYXkgPwoKc3RydWN0IGFtZGdwdV9j
dHhfZW50aXR5IHsKCiDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZXF1ZW5jZTsKIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfZmVuY2XCoMKg
wqDCoMKgwqDCoCAqKmZlbmNlczsKIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRfZW50
aXR5IGVudGl0eTsKfTsKCgoKUmVnYXJkcywKCk5pcm1veQoKPiBBbmQgbGFzdCB3ZSBjYW4gc3Rh
cnQgdG8gZHluYW1pYyBhbGxvY2F0ZSBhbmQgaW5pdGlhbGl6ZSB0aGUgCj4gYW1kZ3B1X2N0eF9l
bnRpdHkoKSBzdHJ1Y3R1cmVzLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
