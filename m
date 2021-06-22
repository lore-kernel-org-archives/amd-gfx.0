Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1459EC49EA4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 07:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98586113D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 07:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98586113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9756E429;
	Tue, 22 Jun 2021 07:39:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF116E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 07:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4DzR5jUFtmpMFk/kOxA99W4XNmbgL3/TJgoacYh1tCIhOnzQWK6kaK9GLChoWXmPRzDPdPzONwaXpMuZCNg+LRsURuVSN9rx13aiJoTtetPbiyViC3Sy9sH5W4XVMbTwnsq7OA6wBMJryvCv6QAgTwSCGCEXW4nSbUV53ORr/FQEBN41Jai19+/ntMToYP/RFLvp3b3+CO+HlaMQJMgm5JAldmxcXOw+ldL1icFM/kcL+k7z2acTAvHM/VxHtNNg/SFlU/F/f6bXLbeJdBicJzFCI7OyXtik2Eaz1ypd9KQWtRNx3aBOqufv3iaax4bvarEQdzJvth1yXogD7FScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMhOdoJktDAxFo4EgxGIXPmhUgVRMIAh9k3g/iBU9PM=;
 b=GQqL7iXpo8eOdqXVAl4WC1xsfD8D6dVQ4m8JUuF/nENhsdEcJDSJO+sIXgr880v1IR9rymw1TC878B97nMjqi9NylAV9U1YNAqrONeHsYgxWyktasewJIs4yoALdlMVg7BKKLcRJVUDBQQkyLz9RSz4uXLT55DbGZObweP59Upn+3n3FisspxotlFwNqTYOOIxJ1lmCyKP/o5Lx14Jzk/NCgpd5t7urmxOz38txdu8yyhPZsAT3Vbn6l6zqDiQ2ZVewfduv4UPjXOKWWJePWJ+ktccmKprUnwYHcb7EZ3Rp1Wwoj6hE82QHgCWwi74gvqPE/faQNnIV/tVjUo9wkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMhOdoJktDAxFo4EgxGIXPmhUgVRMIAh9k3g/iBU9PM=;
 b=LFELTjJmPKjqKy/Y5RoWZJaOsuMca8jptE8bb9nkAEqYw38B+Tvht8XnocjWZtSe1nrkUtoubQ9ktFTVknp8VcR9nfqLQ09scBWPATtpDGJD/FpwxyhbBnvEbrGyb1bqqM4GUgoEhVqhWiS1w3N4Z+eriS8u/vVhtJ6FHsL8Exg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 07:39:26 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:39:26 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210622065711.4589-1-nirmoy.das@amd.com>
 <e2a64dee-ca51-ab36-9255-8950e78c6190@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <5ad4ce29-2a7c-efc2-1541-4e204064f045@amd.com>
Date: Tue, 22 Jun 2021 09:39:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <e2a64dee-ca51-ab36-9255-8950e78c6190@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f26:2100:2c2d:c190:70a6:56ff]
X-ClientProxiedBy: PR3P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f26:2100:2c2d:c190:70a6:56ff]
 (2003:c5:8f26:2100:2c2d:c190:70a6:56ff) by
 PR3P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 07:39:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3aeeae9-da2c-49de-ec7f-08d93550dcb0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB507208EAFA526C9D2F78D61A8B099@DM4PR12MB5072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOf5+s6mc8C1VAJULepJT3OGnA8XtQWYdqpZiTviXZ2OD7Gi7O38QuyFuYbcWFBHGohmHe9A+x0i7cQWSYVYYTFjKfgghRqqHC0qZ4IgNZoVb+97qSehEpv5v3P5+/QS8GGtnBT4PA+C3ho4a0VXYUzRI2f+xFMs4CeHa0Mtz49Mc6lQjbLHpat/h4lmqmu74dWvHeW8O3p+6nCOwSiFLIPNwmDd74NHqlABlJixmZZorml7IGrVD7u/HZJwngYNifM/1dS8GYW+C8pQfSz2AUgeDwyvoFWIjNB+z2aN93pqrVi4kG2pn2/A/6SJewOAPfe9gypse8PN40eZyjcYdNxemcpiJnJYDMW6Hkflix3BpfQk7fJZXEAWSnwaFRPLjO734EYyB2oLLwwZHMn6TI/sWHgGYfeL/fdIv9cvbRfh2J2yN006CDJXMukvexDtsG8s3g4iIIWum5LE+CerYiQ28ih90HneMgigqo82EJ8XmfBmIgeWkLngXz6iF4pIPUhrrSC+SxHYsAPrqy+c4bqZV04m63bPYYD7ntjmskVxQjGMHHfrAoYg895VSs5ERd7Z1a6XlxRslBqzmjbULpE3jVpe0FFNzoQXs5uKBphKbNuhtqvkcA4BB1E3sap8Oe+33zxg+4mnqO55CzVJ2JBhBxKvUrZSOYkD9LQdP5hh7bp0q4ewwM8PESE7vxQy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(53546011)(83380400001)(52116002)(186003)(16526019)(31686004)(66574015)(6486002)(4326008)(38100700002)(478600001)(8676002)(2906002)(8936002)(316002)(36756003)(66946007)(2616005)(66476007)(66556008)(31696002)(86362001)(6666004)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJCcTUvQ3YrNEZNbzQzaVdqMG5EVHhPMW5XVnQweFNoWE9QOUJTSDc2ZlUy?=
 =?utf-8?B?L3BtQzhNZ3BKMExPbE9DQllyUkN0bDNBL1ZjTjZrUWZDb2IwMWY4bTRSRVJS?=
 =?utf-8?B?Q3hTeG9ZMW10ZTFyZ2xIclZmNFFtQWR3QkNZT2lUbm1SdmkvRitvZDZ1Sk5X?=
 =?utf-8?B?dFNHN3ljQUZaT1ArMFc3QURZcWFVcW5HQUpDNS9LY2VxNEFmb0hvY1RGbURR?=
 =?utf-8?B?WWJ4Z3hrRTVNNXF6WHlTc3R3QytkQWxjSTBoVUlhcTVzZ1ZIN1lHb0V2VUNP?=
 =?utf-8?B?c1BvU2wzUVp1ZmtSc1JvK3JFelVTQ1hZRzVnMWVQMTRtSTY0ZXQ0cGlKOVA2?=
 =?utf-8?B?WkRvRlBvRExSMm5UWWptZENIOWtRU1ZQZktpTDJPcXBMcHNqS25tbnpqMnZS?=
 =?utf-8?B?aHk0am9Lc2h0SWUvcVlpQ3hLRG5Gc3lQMG1VZ2pianl3YklCUDF4b2dtMFhq?=
 =?utf-8?B?MmdHMHdOMllBVlBkc0lMZmd5a3NXTEYvQlF3MDM1YVpsZ1NmYWo4WjBPTS9P?=
 =?utf-8?B?b1dGTTJla2xXc0ZNTnY2UzZ2bFBiS2dYVGFUWk5oazhQODMzajBhWHlRSUMx?=
 =?utf-8?B?cTZIR3UyNkpNdVhTekJhZ3hRb1dGU05EUmorSVZhSnVoUnR4ZHdReFZlcjNJ?=
 =?utf-8?B?QmFTN0VvbWZWSzQ4MlIyT0lPTnZRNmxRSG9oeUJBeWdMczY4ZkY3N2w1Qmxj?=
 =?utf-8?B?aktsMHdlMVhOZzBydFFXaGJxTGJyZ0VGdmlPdU1qU2JESWE0OXF5ZHV2K1Zq?=
 =?utf-8?B?TS95ZzJBV2E4ZzR6cS92VC9oYXBqUllOTm1hUC9ic3ZxNnA5S2Z5alpFT3ZC?=
 =?utf-8?B?ajNiMzQ3a0tuVWFlVyt5RU1SZGpFSjVCbUNzUHFpaE9mbjJmUEtqODdIcHFm?=
 =?utf-8?B?SklGczVTbUJ3eWQxUFJhS1Z2RlcwVGhwcGNRN29HUktnUU5iZ3BRdHE3MjRu?=
 =?utf-8?B?VFA1VTh3ODlHRTBYMFJXQ2trVCs4Q2FHREdQMkhNTG1FZnJGa21nby9taVQ3?=
 =?utf-8?B?UjZRbnMzaEVzcXNkR2F2Qzl0SE10blVmZW9EVDhOT1VEMEZJNGRJRzV3enB5?=
 =?utf-8?B?ckhDdXExMEJjbFZjS1pYYm1JZW5oYVJ2UGpQdVpLYnJCRUhPUnYyTmxUa2s5?=
 =?utf-8?B?WDk5TnNtOHMvcFYwZVM3U0prWEZtbWV0eWRSdkNSbzQyekt1ZW5WOGw5ZWlp?=
 =?utf-8?B?ZE5CaUlRNFN1WCtTYko4Qk1lOXNLRnpDUGEvbTNPZHVCb3NqeXZ1a042NUdV?=
 =?utf-8?B?OXlSTDZpL3VVT2xoaWlyYmFmcm1rdDUzbmN3M3pFMXZUMWY4ZjdGVXZBd0xP?=
 =?utf-8?B?OCtWR2Y2aTJscy9TdFAya0RiR0YzZm5IN0lQZlR3bjNmUDFCZ2c1TlBWMUhp?=
 =?utf-8?B?R2ludURJdEhtZjdnNGs3SHo2VXBkOHFuTCtsejJkbldIS1RaM0lVbjBiWUpk?=
 =?utf-8?B?SVBpOFhYRFB4dys2b0p4MVNzVUU3ZzJIdHFVb2Y4OTI3R0ZYT1NQUDh1Y1dO?=
 =?utf-8?B?d3AyYWUvMFYzSFJ2U1BBZ21rNXEwSTdhbXJoNkFCLzNIVDdhTlpkUTVBUEtI?=
 =?utf-8?B?MjJ3Tk1KZDBzRGZOcGlPOUVjQ1hhNnZCVVBmQmZ0dklSc0NZaHc2akRCNlZQ?=
 =?utf-8?B?dVg4bHhPU25xSjIvQk1qTE1TWTBIRTVRcXdGU3RGU2NjWXYvRWFxUkhNQ3k2?=
 =?utf-8?B?RnNNb21aaStJVzdTak5DT01GSlN5aW14dytFSDMvV1lKWUJDRVQza0psR3k0?=
 =?utf-8?B?UTRRNDhuTEE5Y1pEWmJCZ09LblZMWHpzcUxVaEk2NEpKc3g1MEhhUnZIaDB5?=
 =?utf-8?B?eXFWTkQzUXRBMlFOOElzNHN3bkN2Rm9ZWERtdFQrbDBpdVY5alQwUmRPbGhE?=
 =?utf-8?Q?sRBC9hVP8VrxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aeeae9-da2c-49de-ec7f-08d93550dcb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 07:39:26.7526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VmcGZg2QIylZ0xjiyQHotTIJxbZ8n6NXWjklDVh7H1fvXKJfiaQzAcBDuHCbMjyG2/9qyYvHkQVPQKvoxupSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMjIvMjAyMSA5OjAzIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAy
Mi4wNi4yMSB1bSAwODo1NyBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IENsZWFudXAgY29kZSByZWxh
dGVkIHRvIHZtIHBhc2lkIGJ5IGFkZGluZyBoZWxwZXIgZnVuY3Rpb25zLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEwNSArKysrKysrKysrKystLS0t
LS0tLS0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCA1NSBkZWxl
dGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+
IGluZGV4IDYzOTc1YmRhOGU3Ni4uNmU0NzZiMTczY2JiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBAQCAtODcsNiArODcsNDYgQEAgc3RydWN0IGFtZGdw
dV9wcnRfY2Igewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfZmVuY2VfY2IgY2I7Cj4+IMKgIH07
Cj4+Cj4+ICtzdGF0aWMgaW50IGFtZGdwdV92bV9wYXNpZF9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBh
bWRncHVfdm0gKnZtLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgaW50IHBhc2lkLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgaW50ICp2bV9wYXNpZCkKPj4gK3sKPj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+
PiArwqDCoMKgIGludCByOwo+PiArCj4+ICvCoMKgwqAgaWYgKCFwYXNpZCkKPj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAwOwo+PiArCj4+ICvCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYt
PnZtX21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+PiArwqDCoMKgIHIgPSBpZHJfYWxsb2Mo
JmFkZXYtPnZtX21hbmFnZXIucGFzaWRfaWRyLCB2bSwgcGFzaWQsIHBhc2lkICsgMSwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9BVE9NSUMpOwo+PiArwqDCoMKgIHNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+PiAr
wqDCoMKgIGlmIChyIDwgMCkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+PiArwqDCoMKg
IGlmICh2bV9wYXNpZCkKPj4gK8KgwqDCoMKgwqDCoMKgICp2bV9wYXNpZCA9IHBhc2lkOwo+PiAr
Cj4KPiBPayB0aGUgbW9yZSBJIHJlYWQgZnJvbSB0aGlzIHBhdGNoIHRoZSBsZXNzIGl0IG1ha2Vz
IHNlbnNlLgo+Cj4gV2UgZG9uJ3QgYWxsb2NhdGUgdGhlIHBhc3NpZCBoZXJlLCB3ZSBqdXN0IHNl
dCBpdCB1cCBpbiB0aGUgaWRyLgo+Cj4gV2hhdCB3ZSBjb3VsZCBkbyBpcyB0byByZXBsYWNlIHRo
ZSBpZHIgd2l0aCBhbiB4YXJyYXksIHRoYXQgd291bGQgCj4gY2VydGFpbmx5IG1ha2UgbW9yZSBz
ZW5zZSB0aGFuIHRoaXMgaGVyZS4KCgp4YXJyYXkgbG9va3MgZ3JlYXQsIHdpdGggdGhhdCB3ZSBk
b24ndCBuZWVkIHBhc2lkX2xvY2sgZWl0aGVyLgoKClRoYW5rcwoKTmlybW95CgoKPgo+IENocmlz
dGlhbi4KPgo+PiArwqDCoMKgIHJldHVybiAwOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgdm9pZCBh
bWRncHVfdm1fcGFzaWRfcmVtb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBwYXNpZCwKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgKnZtX3Bh
c2lkKQo+PiArewo+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+ICsKPj4gK8KgwqDC
oCBpZiAoIXBhc2lkKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiArCj4+ICvCoMKgwqAg
c3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+
PiArwqDCoMKgIGlkcl9yZW1vdmUoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfaWRyLCBwYXNpZCk7
Cj4+ICvCoMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+dm1fbWFuYWdlci5wYXNp
ZF9sb2NrLCBmbGFncyk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAodm1fcGFzaWQpCj4+ICvCoMKgwqDC
oMKgwqDCoCAqdm1fcGFzaWQgPSAwOwo+PiArfQo+PiArCj4+IMKgIC8qCj4+IMKgwqAgKiB2bSBl
dmljdGlvbl9sb2NrIGNhbiBiZSB0YWtlbiBpbiBNTVUgbm90aWZpZXJzLiBNYWtlIHN1cmUgbm8g
Cj4+IHJlY2xhaW0tRlMKPj4gwqDCoCAqIGhhcHBlbnMgd2hpbGUgaG9sZGluZyB0aGlzIGxvY2sg
YW55d2hlcmUgdG8gcHJldmVudCBkZWFkbG9ja3Mgd2hlbgo+PiBAQCAtMjk0MCwxOCArMjk4MCw4
IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgCj4+IHN0
cnVjdCBhbWRncHVfdm0gKnZtLCB1MzIgcGFzaWQpCj4+Cj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2Jv
X3VucmVzZXJ2ZSh2bS0+cm9vdC5ibyk7Cj4+Cj4+IC3CoMKgwqAgaWYgKHBhc2lkKSB7Cj4+IC3C
oMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+PiAtCj4+IC3CoMKgwqDCoMKgwqDC
oCBzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2NrLCBmbGFncyk7
Cj4+IC3CoMKgwqDCoMKgwqDCoCByID0gaWRyX2FsbG9jKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lk
X2lkciwgdm0sIHBhc2lkLCBwYXNpZCAKPj4gKyAxLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBHRlBfQVRPTUlDKTsKPj4gLSBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZh
ZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGZsYWdzKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGlm
IChyIDwgMCkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl9mcmVlX3Jvb3Q7
Cj4+IC0KPj4gLcKgwqDCoMKgwqDCoMKgIHZtLT5wYXNpZCA9IHBhc2lkOwo+PiAtwqDCoMKgIH0K
Pj4gK8KgwqDCoCBpZiAoYW1kZ3B1X3ZtX3Bhc2lkX2FsbG9jKGFkZXYsIHZtLCBwYXNpZCwgJnZt
LT5wYXNpZCkpCj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yX2ZyZWVfcm9vdDsKPj4KPj4g
wqDCoMKgwqDCoCBJTklUX0tGSUZPKHZtLT5mYXVsdHMpOwo+Pgo+PiBAQCAtMzAzOCwxOSArMzA2
OCwxMSBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+PiDCoMKgwqDCoMKgIHIgPSBhbWRncHVf
dm1fY2hlY2tfY2xlYW5fcmVzZXJ2ZWQoYWRldiwgdm0pOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB1bnJlc2VydmVfYm87Cj4+ICvCoMKgwqAgciA9IGFt
ZGdwdV92bV9wYXNpZF9hbGxvYyhhZGV2LCB2bSwgcGFzaWQsIE5VTEwpOwo+PiArwqDCoMKgIGlm
IChyID09wqAgLUVOT1NQQykKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gdW5yZXNlcnZlX2JvOwo+
Pgo+PiAtwqDCoMKgIGlmIChwYXNpZCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBmbGFnczsKPj4gLQo+PiAtwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYt
PnZtX21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+PiAtwqDCoMKgwqDCoMKgwqAgciA9IGlk
cl9hbGxvYygmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9pZHIsIHZtLCBwYXNpZCwgcGFzaWQgCj4+
ICsgMSwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0FUT01JQyk7
Cj4+IC0gc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2Nr
LCBmbGFncyk7Cj4+IC0KPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyID09IC1FTk9TUEMpCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gdW5yZXNlcnZlX2JvOwo+PiAtwqDCoMKgwqDCoMKg
wqAgciA9IDA7Cj4+IC3CoMKgwqAgfQo+PiArwqDCoMKgIHIgPSAwOwo+Pgo+PiDCoMKgwqDCoMKg
IC8qIENoZWNrIGlmIFBEIG5lZWRzIHRvIGJlIHJlaW5pdGlhbGl6ZWQgYW5kIGRvIGl0IGJlZm9y
ZQo+PiDCoMKgwqDCoMKgwqAgKiBjaGFuZ2luZyBhbnkgb3RoZXIgc3RhdGUsIGluIGNhc2UgaXQg
ZmFpbHMuCj4+IEBAIC0zMDg5LDM1ICszMTExLDIzIEBAIGludCBhbWRncHVfdm1fbWFrZV9jb21w
dXRlKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0s
Cj4+IMKgwqDCoMKgwqAgdm0tPmlzX2NvbXB1dGVfY29udGV4dCA9IHRydWU7Cj4+Cj4+IMKgwqDC
oMKgwqAgaWYgKHZtLT5wYXNpZCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBm
bGFnczsKPj4gLQo+PiAtwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPnZt
X21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWRyX3JlbW92
ZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9pZHIsIHZtLT5wYXNpZCk7Cj4+IC0gc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2NrLCBmbGFncyk7Cj4+IC0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEZyZWUgdGhlIG9yaWdpbmFsIGFtZGdwdSBhbGxvY2F0
ZWQgcGFzaWQKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXaWxsIGJlIHJlcGxhY2VkIHdpdGgg
a2ZkIGFsbG9jYXRlZCBwYXNpZAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgYW1kZ3B1X3Bhc2lkX2ZyZWUodm0tPnBhc2lkKTsKPj4gLcKgwqDCoMKgwqDC
oMKgIHZtLT5wYXNpZCA9IDA7Cj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfdm1fcGFzaWRfcmVt
b3ZlKGFkZXYsIHZtLT5wYXNpZCwgJnZtLT5wYXNpZCk7Cj4+IMKgwqDCoMKgwqAgfQo+Pgo+PiDC
oMKgwqDCoMKgIC8qIEZyZWUgdGhlIHNoYWRvdyBibyBmb3IgY29tcHV0ZSBWTSAqLwo+PiBhbWRn
cHVfYm9fdW5yZWYoJnRvX2FtZGdwdV9ib192bSh2bS0+cm9vdC5ibyktPnNoYWRvdyk7Cj4+IC0K
Pj4gwqDCoMKgwqDCoCBpZiAocGFzaWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2bS0+cGFzaWQg
PSBwYXNpZDsKPj4KPj4gwqDCoMKgwqDCoCBnb3RvIHVucmVzZXJ2ZV9ibzsKPj4KPj4gwqAgZnJl
ZV9pZHI6Cj4+IC3CoMKgwqAgaWYgKHBhc2lkKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBsb25nIGZsYWdzOwo+PiArwqDCoMKgIGFtZGdwdV92bV9wYXNpZF9yZW1vdmUoYWRldiwgcGFz
aWQsIE5VTEwpOwo+Pgo+PiAtwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYt
PnZtX21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWRyX3Jl
bW92ZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9pZHIsIHBhc2lkKTsKPj4gLSBzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGZsYWdzKTsKPj4gLcKg
wqDCoCB9Cj4+IMKgIHVucmVzZXJ2ZV9ibzoKPj4gwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZXNl
cnZlKHZtLT5yb290LmJvKTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gQEAgLTMxMzMsMTQg
KzMxNDMsNyBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+PiDCoMKgICovCj4+IMKgIHZvaWQg
YW1kZ3B1X3ZtX3JlbGVhc2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0IAo+PiBhbWRncHVfdm0gKnZtKQo+PiDCoCB7Cj4+IC3CoMKgwqAgaWYgKHZtLT5wYXNpZCkg
ewo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsKPj4gLQo+PiAtwqDCoMKg
wqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jaywg
ZmxhZ3MpOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWRyX3JlbW92ZSgmYWRldi0+dm1fbWFuYWdlci5w
YXNpZF9pZHIsIHZtLT5wYXNpZCk7Cj4+IC0gc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+
dm1fbWFuYWdlci5wYXNpZF9sb2NrLCBmbGFncyk7Cj4+IC3CoMKgwqAgfQo+PiAtwqDCoMKgIHZt
LT5wYXNpZCA9IDA7Cj4+ICvCoMKgwqAgYW1kZ3B1X3ZtX3Bhc2lkX3JlbW92ZShhZGV2LCB2bS0+
cGFzaWQsICZ2bS0+cGFzaWQpOwo+PiDCoMKgwqDCoMKgIHZtLT5pc19jb21wdXRlX2NvbnRleHQg
PSBmYWxzZTsKPj4gwqAgfQo+Pgo+PiBAQCAtMzE2NCwxNSArMzE2Nyw3IEBAIHZvaWQgYW1kZ3B1
X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3Zt
ICp2bSkKPj4KPj4gwqDCoMKgwqDCoCByb290ID0gYW1kZ3B1X2JvX3JlZih2bS0+cm9vdC5ibyk7
Cj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3Jlc2VydmUocm9vdCwgdHJ1ZSk7Cj4+IC3CoMKgwqAg
aWYgKHZtLT5wYXNpZCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFnczsK
Pj4gLQo+PiAtwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPnZtX21hbmFn
ZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWRyX3JlbW92ZSgmYWRl
di0+dm1fbWFuYWdlci5wYXNpZF9pZHIsIHZtLT5wYXNpZCk7Cj4+IC0gc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2NrLCBmbGFncyk7Cj4+IC3CoMKgwqDC
oMKgwqDCoCB2bS0+cGFzaWQgPSAwOwo+PiAtwqDCoMKgIH0KPj4gLQo+PiArwqDCoMKgIGFtZGdw
dV92bV9wYXNpZF9yZW1vdmUoYWRldiwgdm0tPnBhc2lkLCAmdm0tPnBhc2lkKTsKPj4gwqDCoMKg
wqDCoCBkbWFfZmVuY2Vfd2FpdCh2bS0+bGFzdF91bmxvY2tlZCwgZmFsc2UpOwo+PiDCoMKgwqDC
oMKgIGRtYV9mZW5jZV9wdXQodm0tPmxhc3RfdW5sb2NrZWQpOwo+Pgo+PiAtLSAKPj4gMi4zMi4w
Cj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
