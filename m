Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D759C433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 08:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43CA205F4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 08:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jmQCE0U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43CA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5154F6E1B2;
	Thu,  3 Sep 2020 08:34:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB406E1B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 08:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNOZeLJFyzMAYJljwneyj+TVgSMo0ZVkinr68NFTjqaz4ZniqRXo9/v3sA5HMDNv1+oppY5rKn+6aKij+Nemdx9V67ApccGtVidWx9Gl7z5P+l4ftN5ZOOW6Oa9P7ygV2s9Q6pEjcJ3BdgDSzdVc89azbbfqJiioz5owReQiO0MNZNqg6RWF3+340fDG0ligSS/4vIIrk4tnPPsMqa4s/btngScmGhet/As6LTex2cwY3aqPwYoJ8YNHxbkDKbAqYZYw9xb+iWhl7Rb8R5owA1mGW7UXUY6ztWNQJCXzv65SmCxQibzwLJpAVCbh7J5L911epcJ7V/9Zxc2ezR1MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MLC4ON77kbVpm4lO79AN/uyPF8jo8bJzbChC21EJV4=;
 b=YJIJp8RBqWNHTdoHp2oMC5QA391S1X8e50ha7UgQyFt6HBoyhF2NHDKD03GvSuv63zxyedv3UOb6IdAzHjrMrTiz/aIEzinqh5gTu8uo6MkVuAiZzZAGg+opsiDN0KXoHj6Xc+NTQRoSeExe+73uL7vOdUdrstKYH5EgWQkJWYKC4c7W0DxxhjAiJUxvoMr1gXfqMgpjrcX7pXfloCXQPjHRmLFuXushklGY3ot0r5KBMi7V1x3XvIXRSV0CAPRCrruyODrF2oYCRlulH8mm6CcWWNKvtSyoXWlNs9oFdKQfiyropLWCja9/Knuvv/vH16px/X2TMuYnmPDcLPoo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MLC4ON77kbVpm4lO79AN/uyPF8jo8bJzbChC21EJV4=;
 b=jmQCE0U0DGqi0VFnHazUO5oQEWU9VcjbL79fz0PVEreoZzXNnD0TjZJ9b3x0/T8HdZvpcdkAwT0SOYW1xwAvzBpNERvJlO+pi9ckx/XjZvMaZHmiRjs9PRqtLZOycLjPzcIQR7HslgC2ZIZfQzZn4jYe8ftyEo2EDo+KOIGEYl8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 08:34:22 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 08:34:22 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd_enc
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200902101536.47112-1-nirmoy.das@amd.com>
 <9fc4a69d-3783-0626-5e88-18a579ada03b@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <5ca799fd-d0bb-3c75-d30b-f236753e6cc8@amd.com>
Date: Thu, 3 Sep 2020 10:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <9fc4a69d-3783-0626-5e88-18a579ada03b@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN3PR03CA0065.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::25) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN3PR03CA0065.namprd03.prod.outlook.com (2a01:111:e400:7a4d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 08:34:20 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2392e5fc-55cf-4ee7-31b7-08d84fe427f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39150CE581527F21F552FBB18B2C0@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBGo3lHuuuGtJzWmWS8t7bkN0yv0fKlW/vhy+dNr7X+Pw+Y+2zrz35tYyvZfsEzb92xcLXeBING1pwk+PfrhCe1QYawFBVdf//ik2svq6Oa8aXrY8qtoh5QbO9qCLGIs6k5puw/vpT5qSRO1DOuth3uJ9hyOm9rmL4O4hpZ8EmUC5UsdGaT9WmnY6mnRXJIrp5p8tyNt95XR27v8X9J5gvYMqb09j5Ey5RDqMJDdgXqiSrMjJ5PmqD3JfuVQl+lMxcY8lTnyBDtTY1XJpMW9pZY0H8Pq8AHH03lN9mwN9K4zEljxkwUco1c1p+nk/HtvIlXEGF7q3wKHCOOmTK2zEDo7W1l/ADFTUSTPIGxPgmURsAVUWp1tjmiZmkppAPHRHKFzaQAx+hoSyEtSXKBG+FNVnLKioDmlxm1cVZ53eL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(956004)(2616005)(53546011)(4326008)(66946007)(66556008)(966005)(66476007)(316002)(5660300002)(52116002)(6486002)(26005)(36756003)(186003)(16576012)(8676002)(31686004)(6666004)(478600001)(8936002)(45080400002)(2906002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Oh+M9V0qJm9+Eduyg7F5xNg8jzbu/cwico0RCHd9xA6wTn2WbkBiJeax9kgrmaH0Ge9AYu/lCPS+8U/rh6371l2wvCN4zuSKtKS+fiEN7keHwLDKoUeOVCt0O0C7uRU/9rP5DrVCARZJcWGKEy9wCQaDnAJU7+idFcOwJc6bqGJaM76Kn1yTN6a4QInFI28DPYb1y/gZlqdn0GTUu1XQF+pVvkYJti2vWf8DNVjwbXtYzGzEO6rNNuGVYUCIJHYWYNfLF0HMalj8rLgT3Oam3p79heDHs4r4Lb0H1to8rpkkU+inO/MLlO9VZ/yGS3eSRTXJCkSLh+Ncllb/qHUaJG0fK619QpjT1ms2X9KEWPUkaWMtk/XOCeETYNFlfJ4fsQNAcsKbSpacphvUbRPEQgyXs1u25JnhgphR8wX6IbY46IV5D2wRFa+Ar/LUDvrY23Hr3dObm/hOPHqk7DbpmUsOgrHK9PgIuROFFcMRNfkSB+VojDEDm14kCqrY+OXAm/YN8MwTqhexownInvRyP3MqC1llrVXoKPJgahDjpwxSnF2fSHCwpU56eA9GN/MzKrMoH5UXAJXZSatl9W6SSv/XsleeBfweOnO+C5Nvh2+1xBP0WQknmdWAZc/D9h7KJOXBb9I9JX4MnnwZ9PAOSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2392e5fc-55cf-4ee7-31b7-08d84fe427f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 08:34:21.9074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV1KF979lwHinGtHC+8qRNOrn/9/HyC37CSxc3FjSYpVQd6DpKPJWhIly11L1kxg4mj+J4/ytvtvamFb1OVAjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: pmenzel+amd-gfx@molgen.mpg.de, alexander.deucher@amd.com,
 Tianci.Yin@amd.com, Leo.Liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwKCgpJZiBwb3NzaWJsZSwgcGxlYXNlIHNxdWFzaCB0aGlzIHdpdGg6CgoKY29tbWl0
IGUwMzAwZWQ4ODIwZDE5ZmUxMDgwMDZjZjFiNjlmYTI2ZjBiNGUzZmMKCmRybS9hbWRncHU6IGRp
c2FibGUgZ3B1LXNjaGVkIGxvYWQgYmFsYW5jZSBmb3IgdXZkCgoKUmVnYXJkcywKCk5pcm1veQoK
T24gOS8yLzIwIDE6MDcgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDIuMDkuMjAg
dW0gMTI6MTUgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBPbiBoYXJkd2FyZSB3aXRoIG11bHRpcGxl
IHV2ZCBpbnN0YW5jZXMsIGRlcGVuZGVudCB1dmRfZW5jIGpvYnMKPj4gbWF5IGdldCBzY2hlZHVs
ZWQgdG8gZGlmZmVyZW50IHV2ZCBpbnN0YW5jZXMuIEJlY2F1c2UgdXZkX2VuYwo+PiBqb2JzIHJl
dGFpbiBodyBjb250ZXh0LCBkZXBlbmRlbnQgam9icyBzaG91bGQgYWx3YXlzIHJ1biBvbiB0aGUK
Pj4gc2FtZSB1dmQgaW5zdGFuY2UuIFRoaXMgcGF0Y2ggZGlzYWJsZXMgR1BVIHNjaGVkdWxlcidz
IGxvYWQgYmFsYW5jZXIKPj4gZm9yIGEgY29udGV4dCB0aGF0IGJpbmRzIGpvYnMgZnJvbSB0aGUg
c2FtZSBjb250ZXh0IHRvIGEgdXZkCj4+IGluc3RhbmNlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBO
aXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCAyICsrCj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3R4LmMKPj4gaW5kZXggN2NkMzk4ZDI1NDk4Li5jODBkODMzOWY1OGMgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gQEAgLTExNCw4ICsxMTQs
MTAgQEAgc3RhdGljIGludCBhbWRncHVfY3R4X2luaXRfZW50aXR5KHN0cnVjdCAKPj4gYW1kZ3B1
X2N0eCAqY3R4LCB1MzIgaHdfaXAsCj4+IMKgwqDCoMKgwqAgc2NoZWRzID0gYWRldi0+Z3B1X3Nj
aGVkW2h3X2lwXVtod19wcmlvXS5zY2hlZDsKPj4gwqDCoMKgwqDCoCBudW1fc2NoZWRzID0gYWRl
di0+Z3B1X3NjaGVkW2h3X2lwXVtod19wcmlvXS5udW1fc2NoZWRzOwo+Pgo+PiArwqDCoMKgIC8q
IGRpc2FibGUgbG9hZCBiYWxhbmNlIGlmIHRoZSBodyBlbmdpbmUgcmV0YWlucyBjb250ZXh0IGFt
b25nIAo+PiBkZXBlbmRlbnQgam9icyAqLwo+PiDCoMKgwqDCoMKgIGlmIChod19pcCA9PSBBTURH
UFVfSFdfSVBfVkNOX0VOQyB8fAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaHdfaXAgPT0gQU1ER1BV
X0hXX0lQX1ZDTl9ERUMgfHwKPj4gK8KgwqDCoMKgwqDCoMKgIGh3X2lwID09IEFNREdQVV9IV19J
UF9VVkRfRU5DIHx8Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBod19pcCA9PSBBTURHUFVfSFdfSVBf
VVZEKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZCA9IGRybV9zY2hlZF9waWNrX2Jlc3Qo
c2NoZWRzLCBudW1fc2NoZWRzKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNjaGVkcyA9ICZzY2hl
ZDsKPj4gLS0gCj4+IDIuMjguMAo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NuaXJtb3kuZGFzJTQw
YW1kLmNvbSU3QzE0YWJhZmZlOTc5NDRkMTczMmEwMDhkODRmMzA2ZjAxJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM0NjQxNjczNjk0Nzg0NSZhbXA7c2Rh
dGE9MUY4YWwlMkY3eFRYMnNqaG9VSTg4VU5FMm1qV1BKeE5wRnNsbUF1QkpqZXZVJTNEJmFtcDty
ZXNlcnZlZD0wIAo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
