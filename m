Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6FC4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 15:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CBC20715
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 15:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x5BPyoxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CBC20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DC56ED0D;
	Fri, 25 Sep 2020 15:00:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084776ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 15:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0B4zYIDiRoun/DXylZ/KPbxCyW6hUWCyISGtIyLYYukHrXBjaPcBgEYWWM08oWeSiPYu73z1GDrP05fmj/ZJWqfNIKhViv4WLVgSzXnSWmyUdGcAM+LlfedDisMspBvwJS8HSXxLJwmEiAkSTypm+eAN933S/XWO0j/dnlFN/RNlJI/Wosk8GijaGMn4gspO3SK8y0pT454pcOGj5wyC1S1WDo7805yJT/GX8wclL43MkYx3wLsksIkU8MjIdZVyx28kxasH3Y0QyDxcRACg7+3DzeCHHHbduucygdwvHQOg+PTr33mTLHNvwx/9QeoYzm1c0/csT3iepigsNw3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiUWfuvHeX9Is0LizPMtADWddSIl4RuMJuInUIymRQ4=;
 b=dut/AmsfgC3Z2GBKdWt21qs0aQRT0U3SXtq/EvpQzk1uwm6BjyGhetrDS6lGKnFCgPrmSDlzVSAmSGcIb0B2iLbtoCwT3b1RxbOzM8Zh86b9z6rcVfW8HEyEmc45hLHjrtAeYjFzdVTbpgAituaym9NBcVX5wx4IyWmPJOMDs2Oe55h994L3arRCr7O08tDVz45cXedNX7NBQEyfy+CAU+Id11De30wCCxrn8+0+zoZqdbW82NmnmWmtq8huAU0hlwOiu3sStBKy/Ofp9xNrAH/A7lXkUVq/gsdBEFOGdp48F8HwAIzMleuYD8kvinyWetMTB5bhPT3634mbjoY7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiUWfuvHeX9Is0LizPMtADWddSIl4RuMJuInUIymRQ4=;
 b=x5BPyoxmmih2F39idpMMHMkq+a/2eosz3gS184NvfMVbyLS2Lq1Us16K6siftrcP2zQ//Lvihl3ul2/PbUFlxxClgJt+FfZ6K30HgtNLXhLbvRDs4qpIva3hp58kWDAFt3e56dz6d8BsSiiVJ2pbBgWu2wV7VhLpOEzaBW/kUfc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 15:00:42 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 15:00:42 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a warning in amdgpu_ras.c
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925143127.1588029-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <41d3580f-9267-308b-dcff-e2b828812348@amd.com>
Date: Fri, 25 Sep 2020 17:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200925143127.1588029-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.126.213]
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.126.213) by
 AM0PR05CA0075.eurprd05.prod.outlook.com (2603:10a6:208:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 25 Sep 2020 15:00:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3a8ecda-d21b-4e37-33f8-08d86163c5b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3788:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB378845773AEDA0661F5DB9EB8B360@DM6PR12MB3788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0u5FRR+gUZkU03+BnfV1iKinmhvxi+7LGfl/Uddm3JaX/STtWH4w8osmzLMWyBzrZ9hc1wtYis8gBd2izYw1RQJJbGPDfTLiJUZnL04d+VOuXNB19zLsapdAXO3sN6+mPfGhyqLg+ffYuZ34w2mUtmycfF+G+ND22pijUVX9PrHm3fowEQk/BniskkrwR/Ph8wIRnTY2nOwlz56WiVzXrSetmeuUWOfkrhb5aeH/QQxNPHtyYAqxR5HAb0Quco2p/tl8WU+73Ssm3dzD8jKAUPS4EbZ6YIULgr0BQ8XHgmSR0JAGS0JVDy8/78KXWgRmuGP7rnTsnPmnKLUAtBnvOlwwYzOX87qPOm2i7GRw3XaBOLoYV434Aft3Rx60Hef6b2W4ela2LEoKaSiP24rTaLmp1u9OtrJkux/Qt3SyJHqD7/8YartbHS1wiGWtMB7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(36756003)(6666004)(53546011)(8936002)(956004)(5660300002)(2906002)(26005)(186003)(16526019)(66476007)(66556008)(66946007)(52116002)(16576012)(316002)(478600001)(31686004)(4326008)(83380400001)(6486002)(31696002)(8676002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tYiM+yqgUyruw0gYorjKDyM8X5sfNh/gB1eZIqoe5AnTdwo3ih/o/h91TrdUYiKQr8wOijSpn8gsh30fo6gNer4gL9M/QSXljm0YrBUacUfx/bJxVJRlK4ab8CkqPznN/0AuZf0Bjtr+NP/2xES06lS3kiHWDMA/zWdqWLhjcH+UpBdS+VFxQCjdSA8XzCr7M9ygDFYyBbem+BqkcBiqbCpn2801XpHRczsl4E0pho7M4azo+4KvIAoG9MPuRNy+UMLKgkP3NvuTmvI8mKUeB1AJ4u/KY8AcCC+lZbUQ8XWAB28r2nbAbZXs86PRTXA1j/e1Yf6oO56KfVA5U35RIf6Vj3osjOqGyFQTppO6H6ajeucMOcrQyORPFY06wnLSI23Pp2n/B44Yj1Iuxpf9vTzJhIHYsVFJblnmAEZisWkp9uQLA6Ylh4alFfhx/+C+IFYccIZekNXZq1G4daCtTD8JRWPM+HU+n+ZtZxEnvR5wA1I2c+Os2qVQkqwxcH3eH10I0b2xxEgre7oIoEl4LJAmht/Y0DOT9/V+YQKm8jpk83hBqR+VS4rw4fdOf/XgJ4aH/j6ZT8NOajvO7RVNfrumwtj604/5+cq73gAaYrEhzorLODrbqUOqHrWMBfJTkDROJrkUvDF1ETw/DLUiiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a8ecda-d21b-4e37-33f8-08d86163c5b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 15:00:42.2702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kd/PrHRmwyV+FRIUD1e8K7gOyt7p0xVD6B9aDeq3MeAO3IZPA+7IxnT/IupuFwLLRDK9LUWPOH1PNJWf1BfWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3788
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KCk9uIDkvMjUvMjAgNDoz
MSBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYzogSW4gZnVuY3Rpb24g4oCYYW1kZ3B1X3Jhc19mc19pbml04oCZOgo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzoxMjg0OjI6IHdhcm5pbmc6IGlnbm9y
aW5nIHJldHVybiB2YWx1ZSBvZiDigJhzeXNmc19jcmVhdGVfZ3JvdXDigJksIGRlY2xhcmVkIHdp
dGggYXR0cmlidXRlIHdhcm5fdW51c2VkX3Jlc3VsdCBbLVd1bnVzZWQtcmVzdWx0XQo+ICAgMTI4
NCB8ICBzeXNmc19jcmVhdGVfZ3JvdXAoJmFkZXYtPmRldi0+a29iaiwgJmdyb3VwKTsKPiAgICAg
ICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPgo+IFNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAt
LS0KPgo+IERvIHdlIGNhcmUgd2hldGhlciB0aGlzIGZhaWxzIG9yIG5vdD8KCgpJIHRoaW5rIHdl
IHNob3VsZC4gRmFpbHVyZSBpbiBzeXNmc19jcmVhdGVfZ3JvdXAoKSBtZWFucyBtZW1vcnkgc3Rh
cnZlZAoKc3lzdGVtIG9yIHdlIGFyZSBkb2luZyBzb21ldGhpbmcgaW4gdGhlIGRyaXZlciBjb2Rl
LgoKSU1PIGluIGJvdGggY2FzZXMsIHdlIHNob3VsZCBlcnJvciBvdXQuCgoKTmlybW95Cgo+Cj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA0ICstLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPiBpbmRleCA0OWQxMDMzMGJmNjQuLjY3NzI0
MDQ5YTBmYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPiBA
QCAtMTI4MSw5ICsxMjgxLDcgQEAgc3RhdGljIGludCBhbWRncHVfcmFzX2ZzX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCXN5c2ZzX2Jpbl9hdHRyX2luaXQoYmluX2F0dHJz
WzBdKTsKPiAgIAl9Cj4gICAKPiAtCXN5c2ZzX2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2Jq
LCAmZ3JvdXApOwo+IC0KPiAtCXJldHVybiAwOwo+ICsJcmV0dXJuIHN5c2ZzX2NyZWF0ZV9ncm91
cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW50IGFt
ZGdwdV9yYXNfZnNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
