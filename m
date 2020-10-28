Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E9C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893DA247E5
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cd4KkusU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893DA247E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9C16E4B0;
	Wed, 28 Oct 2020 16:15:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1476E4B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsSMnN3tNHd3ygvACBfd+e8mqbUKpndE/tYfGv5yDv/SnsuCAcmzMvGR8OvCktYf50GaIZtSFUKiyNSk0jzAryR/Ey/YtvwSWLZVsh2j1ms2rXUhJTPt91cQt9pLyigi8pTSG/ZITlwHLd837GJzZL0yDoHhv+ZzGd+FWdr3S8lJnV506TBeyEzil9+FMXcpOMYjQzPw/gtkPZVh8fFDsAg2j4rnYa0fmYebhe//qjn1sfOAgWKK4W9n4WvlJRb/t4Pe1dFuBKKaMWFg8Ve0LIcinppdNgpNHF46aHc3LTcw8oeXfkssJcxyOLHaMaccSH5+5pFRzZLaIOpHcv4ieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5R5feRAZh5hETtPbA+I8NKiaOV6VtuPmonKM9lSTSg=;
 b=JIPQBex2qCaG4ALfAwcSYgPWleHY4t/3HUtD5fLj79IV4RrWS9GssuglpcQIMh4+HhomkILElsPhxLWz1bD4sqC3a+sOSS3UaJNtJQETp+udgr2tLXZRDOYGHPhOv8hJadOAiAd9ZErv1hkQMsRQuHBzfCaJX3/wVnwpaehZcEXZ6pwW8XyiyX9gxD6AltEFnDlXuChvBClva8RugYzX02STOi1X7O37g80jCj4/WmhC0nM4HZq4uYiVXig5fpXRDTh4dnqyXPC3Brv4zGq+4R2OEXIuV69ur6nxEZ/bwYnI9TNn4cc3wpMZDji1U0v2hyvNa44W77sWDBnU9EEADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5R5feRAZh5hETtPbA+I8NKiaOV6VtuPmonKM9lSTSg=;
 b=Cd4KkusUkl6NnS9GOmZm/gtOOf/fbA6CTZ0jjQoqs2SiWaQNWb2wotYpYQdGn7eqgibkxl/p2eFUP+lyMstE16IEMAuFYFv2sdI+j+6MuXtqb3APz+DyLbyzuFtaBv1PT8OVLnCpNg8yxpRjX/dyDqExu7RPS26UlTstmxjN3rc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 16:15:32 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:15:32 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix getting unique_id in topology
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201028152218.18485-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a6a645a5-5dea-54a2-b3b0-2ad84d7224dc@amd.com>
Date: Wed, 28 Oct 2020 12:15:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028152218.18485-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 16:15:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26967d10-54bb-4a3a-54b4-08d87b5cb1bd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4946:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49461262230102F519E59AB092170@BL0PR12MB4946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD4avPvj4eNB6z29oI5ox+TRV9V0QNk6kw3nwTdXwe9gqWsvY6Pfi82gpAEK/aOAlgH+qvOX9xOdSg/yMfa1FTZAJ/kGrrZ/bnyEV+f7CjGeapx4NV7bUCnnwsE/C161Fn3VKzD+0X2vCOO/HeZhVDdAjinmMgiMz6/+U9TfaY/BhsSTZiHAimn8kEd3P8UOXbtXnMhXyQqhH+rh1kOJPEEa06ZWfnUeuXw/OZjgDBDgchdHLOWO0S2CZtDxTCwlApFBcnC05HQktlwTK6vKfUjlJpYX58wddcwO2vQP3eHTz1mZsRt1bJsc6CDgZLHjD950Zx7m8FlMHGJ3jxgA44wrcYpBADZf7q07DagSsZm3zm9jBh6AJBzNoJAdH15U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(4001150100001)(2616005)(5660300002)(83380400001)(52116002)(478600001)(6486002)(26005)(31686004)(16576012)(44832011)(36756003)(2906002)(31696002)(8936002)(956004)(16526019)(86362001)(8676002)(66476007)(66556008)(66946007)(186003)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gJA5RAHi458gRRoYGGuB31AD5UFqfuy223Qc2TWBZ171TtJ1tVnrLOmduA/E2grsimYmEF55BFbKHvqgNTwrX2563X74YYO2zIr1pzzUWAJbxfH+UKbVK8Sne66lA4dQNhVuBBXGGFU6v0Vu+ccQJMBVbknzixslhBcWqZ402CEN1iWglGplo+TP/AmNVn1EZLMLSBxnCl3tIjEihcuMP2oRUc3d49W7adbwjndMYARL4qeAucbZHVdiO2PgPD/brQnLuwprooQSZe+M1QLJv+tD7pQdrrTzjlRHJfK/S5unuHNowxsfXIA0CzyyK9eGrIqXjwI9luDzTvWPxsYGkRDF3e7Y5LX26e6eKgo8WifID5ZQOz1sOoE7JPoV0cTtzZ8iOKADJI08IpxQpj7vdP00BSDR6FLUmyhXOIg/cK1VjWsSOwu0Lk51eHR4hj9PAW9xggaJEbTatjNyzH1yh1hiI61D/CgNgpzGKRDfIjEBiRqEOsm1dI6yo1rTJ6E49fWlh2BWrngmDnmRblvusCluDFz/FcyJwauzJ0DUTPrjXTwiGBuqavbj2CgzlCt3bX/0yz/6BthWGpPYP4BZSpAbxfnMOXAJ3JzxuonRebIADhkbjxtfpvLnzRo9ssdJFsnV5cGA8gGfa8JXABwbvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26967d10-54bb-4a3a-54b4-08d87b5cb1bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 16:15:32.3382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtPVkGgAATglT2my6O/smuOdP8LVrxwiGq54wXmp0zqdk+wt4p/37endNmDqZehfvm0Y4uwd37ZMpUXmNUgvGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
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

UGxlYXNlIGFsc28gcmVtb3ZlIHRoZSBicm9rZW4gY29kZSB0aGF0IGluaXRpYWxpemVzIGdwdS0+
dW5pcXVlX2lkIGFuZApyZW1vdmUgdGhlIHVuaXF1ZV9pZCBmaWVsZCBmcm9tIHRoZSBzdHJ1Y3R1
cmUuCgpSZWdhcmRzLArCoCBGZWxpeAoKQW0gMjAyMC0xMC0yOCB1bSAxMToyMiBhLm0uIHNjaHJp
ZWIgS2VudCBSdXNzZWxsOgo+IFNpbmNlIHRoZSB1bmlxdWVfaWQgaXMgbm93IG9idGFpbmVkIGlu
IGFtZGdwdSBpbiBzbXVfbGF0ZV9pbml0LAo+IHRvcG9sb2d5J3MgZGV2aWNlIGFkZGl0aW9uIGlz
IG5vdyBoYXBwZW5pbmcgYmVmb3JlIHRoZSB1bmlxdWVfaWQgaXMKPiBzYXZlZCwgdGh1cyB0b3Bv
bG9neSBtaXNzZXMgaXQuIFRvIHdvcmsgYXJvdW5kIHRoaXMsIHdlIHVzZSB0aGUKPiBhbWRncHVf
YW1ka2ZkX2dldF91bmlxdWVfaWQgdG8gZ2V0IHRoZSB1bmlxdWVfaWQgYXQgcmVhZCB0aW1lLgo+
Cj4gU2lnbmVkLW9mZi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4KPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgfCAyICstCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiBpbmRleCAzZjJhYTA1NWMzMmMu
LmEzZmMyMzg3MzgxOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfdG9wb2xvZ3kuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3Bv
bG9neS5jCj4gQEAgLTEzNDAsNyArMTM0MCw3IEBAIGludCBrZmRfdG9wb2xvZ3lfYWRkX2Rldmlj
ZShzdHJ1Y3Qga2ZkX2RldiAqZ3B1KQo+ICAJCWRldi0+Z3B1LT5kcW0tPnNjaGVkX3BvbGljeSAh
PSBLRkRfU0NIRURfUE9MSUNZX05PX0hXUykgPwo+ICAJCWFtZGdwdV9hbWRrZmRfZ2V0X251bV9n
d3MoZGV2LT5ncHUtPmtnZCkgOiAwOwo+ICAJZGV2LT5ub2RlX3Byb3BzLm51bV9jcF9xdWV1ZXMg
PSBnZXRfY3BfcXVldWVzX251bShkZXYtPmdwdS0+ZHFtKTsKPiAtCWRldi0+bm9kZV9wcm9wcy51
bmlxdWVfaWQgPSBncHUtPnVuaXF1ZV9pZDsKPiArCWRldi0+bm9kZV9wcm9wcy51bmlxdWVfaWQg
PSBhbWRncHVfYW1ka2ZkX2dldF91bmlxdWVfaWQoZGV2LT5ncHUtPmtnZCk7Cj4gIAo+ICAJa2Zk
X2ZpbGxfbWVtX2Nsa19tYXhfaW5mbyhkZXYpOwo+ICAJa2ZkX2ZpbGxfaW9saW5rX25vbl9jcmF0
X2luZm8oZGV2KTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
