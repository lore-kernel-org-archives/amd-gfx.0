Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCBC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E358124655
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="11J5eOes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E358124655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A116E428;
	Tue, 14 Jan 2020 16:26:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06726E428
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 16:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIF6/Dx5zat6OdF9cPfeVQBqrwTaeWDHQq2B8MhXiJY9vdaTl1s4gYG+iUBuSVKc45Zxi47Su4pwq/aF/GdSAOzrkg4VLl77zeZgnlZ8fHuJ5xnwaQvuVrLgxZnLGdxzCBbZPX4ll9vnB+kD45vUJnlpszAtcBCE8uB7Ldp9JPuIK+0gXaSK7hoA57KLemaO9MckmZG5IjqKT+usv3Aj4J0JVRu7OR21K4oeGUOMnRgH/4MGJddPdpB2LWf/0RspumALgUpZdkUxFhQaRzQ2XgxJTcFJCRMTzZDwqmldTLZDwQtOzio3vtYDLoxfMu5j4Aq3nBCj+Lb3EGEBiPINsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uThW9QuiV8A+gvnZ5FsCYjb684bcolUZ7hL6yYv6vDM=;
 b=cnR/pvp41lBwCvGzPCx2eotf6eHsJ25TSoUP7G0joYWrh7t4ybcNR604hvG2OVJL6vZnNZGfwNr6BBrYLmco9Wb28sVieO3JxMJpfrA11DdQiG3iyIkklBchz/5L8L6QSB2+JCdxY0nHPVEQqQl/ofN8zz7QC1iwkABqpxfumpJsJF2jgunS8Uuw7iglM6+PcoSszQIAm1DjwjJ00kB6kvDf4VeFx6jEzvoya7cw2U+nfNpBdh4SuUBJzRxDiqwEuFtQimj3kfExAe3HzQuvWjmhqQHQdYhTuhIye1XJ1NjwxgFwSLRtAM5exZ1PCdmv/LCBO+LDh0Opq8uFJGcdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uThW9QuiV8A+gvnZ5FsCYjb684bcolUZ7hL6yYv6vDM=;
 b=11J5eOes/6ZwiI+d5qG4C/kTu//1YqYP83UZSUC4y6I0UA3kx7xfhtVlFOZiCY9Z4sEIF+EO2BNjO2Vysby8HslMwGumAP3cBUkWP2n8enJV4WPRzC0qbg7uN6M0YYz8k+iLbmy6qT8KSR9NoRVXF1HO0Wlb+HyZgo9q/YGkJ9k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1465.namprd12.prod.outlook.com (10.172.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 16:26:20 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:26:20 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
 <04f6d680-02ff-7526-adb4-4d44e83712bc@amd.com>
 <fec78b0f-809a-15de-5c54-996f480eb4eb@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <9ce31047-6b53-4a5c-7483-660d671afca3@amd.com>
Date: Tue, 14 Jan 2020 17:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <fec78b0f-809a-15de-5c54-996f480eb4eb@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [192.168.178.76] (93.229.32.95) by
 AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.12 via Frontend Transport; Tue, 14 Jan 2020 16:26:19 +0000
X-Originating-IP: [93.229.32.95]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67764397-b645-419c-e25a-08d7990e7d1b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1465:|DM5PR12MB1465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1465051C10225C2BA1DF24D08B340@DM5PR12MB1465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(16576012)(2616005)(316002)(2906002)(81156014)(52116002)(81166006)(956004)(8676002)(36756003)(26005)(6486002)(16526019)(478600001)(186003)(8936002)(66574012)(31696002)(53546011)(31686004)(5660300002)(110136005)(6666004)(66946007)(66476007)(4326008)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1465;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JP1zl6zk63YbHkLX+K9PRZFv73xExWWfMjjXTb8WrkRRwteEN0JFHxosB80ujWpYFoI0hT/XQK6D2e47Q0TAVTnnwKO9Sa/EHY+1BFKgsKTCFfU6IKvYnHYYYcVJ5nheaNvRSuzPHKYe2HJ9PG4ClbraQbX7dqTCopP51+DgY6025drXX2vn0yd12/mFgKiudOisSngeZjspgJ+N0nS2ZoT4JW9jMI5+CDAl6laQgyosA47WDxOFkFNt1Fbxs/hADLjCD3bvMKH3Rv2I0/1NAp3w7+sL1mHisC82fMfdkLh+9Uh+WfTKbr96xcutDe9P5pB4DFM2/qV9cGWOpO77cCQBdYmahRz1nBXtbu+jWfD7RGFP6CwlaZjhhc82SSdO/Ji2AH8nWY8O+RIdD1Uu9VKx8AjOZmEO+dULjJZg8rRpZUuJuRBMwZrHqy+cAlP7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67764397-b645-419c-e25a-08d7990e7d1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 16:26:20.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKgvdYyIv/upUkCDDUQ3GpTPqCO+nyKxTaBK1NTYws61nGkbg1T0Gbw2YFz5znyGhDuxe2L7LdNCbQz1bT9/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
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

Ck9uIDEvMTQvMjAgNToyMyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNC4wMS4y
MCB1bSAxNzoyMCBzY2hyaWViIE5pcm1veToKPj4KPj4gT24gMS8xNC8yMCA1OjAxIFBNLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTQuMDEuMjAgdW0gMTY6NDMgc2NocmllYiBOaXJt
b3kgRGFzOgo+Pj4+IEpvYnMgc3VibWl0dGVkIGluIGFuIGVudGl0eSBzaG91bGQgZXhlY3V0ZSBp
biB0aGUgb3JkZXIgdGhvc2Ugam9icwo+Pj4+IGFyZSBzdWJtaXR0ZWQuIFdlIG1ha2Ugc3VyZSB0
aGF0IGJ5IGNoZWNraW5nIGVudGl0eS0+am9iX3F1ZXVlIGluCj4+Pj4gZHJtX3NjaGVkX2VudGl0
eV9zZWxlY3RfcnEoKSBzbyB0aGF0IHdlIGRvbid0IGxvYWRiYWxhbmNlIGpvYnMgd2l0aGluCj4+
Pj4gYW4gZW50aXR5Lgo+Pj4+Cj4+Pj4gQnV0IGJlY2F1c2Ugd2UgdXBkYXRlIGVudGl0eS0+am9i
X3F1ZXVlIGxhdGVyIGluIAo+Pj4+IGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2IoKSwKPj4+PiB0
aGVyZSByZW1haW5zIGEgb3BlbiB3aW5kb3cgd2hlbiBpdCBpcyBwb3NzaWJlIHRoYXQgZW50aXR5
LT5ycSAKPj4+PiBtaWdodCBnZXQKPj4+PiB1cGRhdGVkIGJ5IGRybV9zY2hlZF9lbnRpdHlfc2Vs
ZWN0X3JxKCkgd2hpY2ggc2hvdWxkIG5vdCBiZSBhbGxvd2VkLgo+Pj4KPj4+IE5BSywgY29uY3Vy
cmVudCBjYWxscyB0byAKPj4+IGRybV9zY2hlZF9qb2JfaW5pdCgpL2RybV9zY2hlZF9lbnRpdHlf
cHVzaF9qb2IoKSBhcmUgbm90IGFsbG93ZWQgaW4gCj4+PiB0aGUgZmlyc3QgcGxhY2Ugb3Igb3Ro
ZXJ3aXNlIHdlIG1lc3MgdXAgdGhlIGZlbmNlIHNlcXVlbmNlIG9yZGVyIGFuZCAKPj4+IHJpc2sg
bWVtb3J5IGNvcnJ1cHRpb24uCj4+IGlmIEkgYW0gbm90IG1pc3Npbmcgc29tZXRoaW5nLCBJIGRv
bid0IHNlZSBhbnkgbG9jayBzZWN1cmluZyAKPj4gZHJtX3NjaGVkX2pvYl9pbml0KCkvZHJtX3Nj
aGVkX2VudGl0eV9wdXNoX2pvYigpIGNhbGxzIGluIAo+PiBhbWRncHVfY3Nfc3VibWl0KCkuCj4K
PiBTZWUgb25lIHN0ZXAgdXAgaW4gdGhlIGNhbGwgY2hhaW4sIGZ1bmN0aW9uIGFtZGdwdV9jc19p
b2N0bCgpLgo+Cj4gVGhpcyBpcyBsb2NraW5nIHRoZSBwYWdlIHRhYmxlcywgd2hpY2ggYWxzbyBt
YWtlcyBhY2Nlc3MgdG8gdGhlIAo+IGNvbnRleHQgYW5kIGVudGl0aWVzIG11dHVhbCBleGNsdXNp
dmU6Cj4+IMKgwqDCoMKgwqDCoMKgIHIgPSBhbWRncHVfY3NfcGFyc2VyX2JvcygmcGFyc2VyLCBk
YXRhKTsKPiAuLi4KPj4gwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9jc19zdWJtaXQoJnBhcnNl
ciwgY3MpOwo+Pgo+PiBvdXQ6Cj4KPiBBbmQgaGVyZSB0aGUgcGFnZSB0YWJsZXMgYXJlIHVubG9j
a2VkIGFnYWluOgo+PiDCoMKgwqDCoMKgwqDCoCBhbWRncHVfY3NfcGFyc2VyX2ZpbmkoJnBhcnNl
ciwgciwgcmVzZXJ2ZWRfYnVmZmVycyk7CgpPa2F5LiBUaGVuIHNvbWV0aGluZyBlbHNlIGlzIGdv
aW5nIG9uLiBMZXQgbWUgZGlnIG1vcmUuCgoKVGhhbmtzLAoKTmlybW95Cgo+Cj4gUmVnYXJkcywK
PiBDaHJpc3RpYW4uCj4KPj4KPj4KPj4gUmVnYXJkcywKPj4KPj4gTmlybW95Cj4+Cj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
