Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB83C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44B120885
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0HtluUzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44B120885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A886E02F;
	Wed, 19 Aug 2020 13:09:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013336E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 13:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR7zcYIhFi8+o+jv97Fw1j0bxW38Ihpd/QGZ0XScA8GyN9/yDvpKQHHgn/dWDfDw6iCweuipaeQ9rc9BrPJxYOPeTYjv0DO+/S36Gi1uZoDUxH3DJtYQ8anwcyeZ1ycNBIg72z50JSg9geOSncfrRJOZsfjuCDMpnKlnR8OWQvsIUv+rimd8MfQsqwOyLp6wzFx5XKVslYN+iE8dHV1a7+kQeMMQnjRotuy9WSYB1ELjFkhVbC4ZMQfy5ZgQzxYQ1DD23QWG9tZUspdiLIgBgIk77I2BcufzQ6ueQiQ52rUx3790IaNBU3grygsBXoTOC6o3hD9hxGFRB4ijWNDsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjrtnLqQmy8/FEj1wXdGAyUWLvtVV5PtGprPDvkjGBk=;
 b=eP28D5tx546XJtXCWzSzPAugtvhSEzuW1VSsqrLwRlSCLFIdxFRR4d2RBbXCfi2a/aoWato+l993Zd0c6zuhJAdEUc4FEabf63nf8IgLM8AbxRQCNX4z/a1F3cvPQwsDQyHGvvePusHMiyWHUhY09NCdH2ELhpMpz0nPjywZTTzUQ0UbDgUPVAwRizvsctnxnE5dbyYq5C6HsKVB9Q20vIQwTledDzOWUtgn589F37s4WL2D0a5DhWJMkHjA8jSbwAkd8j2HJgx6P8147vBGM8U/GM/G4C5aDy7VLJKeCmKxMQBCculpFuN9C6RVg3F0qstXroTcYd0RHWA4aeVzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjrtnLqQmy8/FEj1wXdGAyUWLvtVV5PtGprPDvkjGBk=;
 b=0HtluUzuudDMu8bPThDX3NW0n3yUkDZPytXmttCLAHPM6ldroKj0OEQlybBKStDCUeXrcomb4W6B2Un5XGCz1v/2t2rK9g2VgrlxC1NVpTPmrwAnXcaEEIsys6EQHsTOhfMhdrO4LI4YqHMMlGZeGdpy/LuO8Pd9AFRviXL9xgQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2969.namprd12.prod.outlook.com (2603:10b6:5:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 13:09:46 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 13:09:46 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <2bfb1e81-1c25-9cad-0bd9-dccb8fb18c33@amd.com>
 <e8aca13f-2399-0627-0208-c3085e6ec7f6@amd.com>
 <4e6d00c9-5fd8-81a6-5420-ae95306d43cb@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <2b5cfe6d-df9c-8f1e-369c-0c5aa1ec39f1@amd.com>
Date: Wed, 19 Aug 2020 15:13:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <4e6d00c9-5fd8-81a6-5420-ae95306d43cb@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0146.eurprd05.prod.outlook.com
 (2603:10a6:207:3::24) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.116.56) by
 AM3PR05CA0146.eurprd05.prod.outlook.com (2603:10a6:207:3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 13:09:45 +0000
X-Originating-IP: [217.86.116.56]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2170c3bc-b3af-45d7-aef6-08d844412519
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2969AE506BFD94C4E914E55D8B5D0@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xjx7y6ZeQQyl4us49AhdMQ1dz0V1TT0W+aMmWM4NRY2HXjpMhCMND/sOw4MNYZWL0aDTGMrdeHONX3ZMMjdQx3hLvDj6R3uTO9ktl4uwXpauo6OtetQkqXkQlQ0/qcVrXJunY0lHd+D6iPBp2+7WraRPyUglXYEIRtj3RJPmz/FgnauEtLCNzOaDz6XJUn6b5XtBzTMwk0SN22F4l5tV5gcMy52vXgBYfmUOLbaHwlg171oebpRVKrqFrTgxekkzk0dji9N0rgFODZ5hcM87eFio2/jEutiaw2r+vMPGUXEjUMEzyJllCaQMjwHrGC0GRKRWUz9o2mCAK8LS41wZyJoDQr0eSzAG/sDhkYf1WrV0KOCL69D4e6VF5i9Afep
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(16526019)(66946007)(6666004)(6486002)(15650500001)(478600001)(52116002)(66556008)(66476007)(8936002)(4326008)(16576012)(8676002)(66574015)(83380400001)(5660300002)(36756003)(2906002)(53546011)(316002)(26005)(186003)(2616005)(31686004)(31696002)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2smIdA1Bt0+D5Zj7r6x65NOX9JfmvnIvzzmalhzyKOIy2O5F8YrihDl83ScS00xJzVqNyKDsAIhG6yCrxHNqKWptLLQZZkakZPia2gmGACuUGOoa8/mkmVRlX2Ky5Q6mTd8xxrweEEPvp7tvvwMlCP7Q86uC5XaE7TIW/TPbSRW05rZZFHKO7UNMXtQJBnoTqc74UBT9fSc5sUEx3uGtaRIeTqwJu6dlBUBjg74ol8HHKxOmPeDsz1WU1U0PfPlT4/PZhmpRdcv8vOrDEts7Tk1SAyAJVNHSMTJ6KUl+vGVGEwiKQ/EBZrs/jL5vm78QxI67wwtoQ+UsvLGzBKtnpmcXmXwDBE/Z3t+fBQNcDdoqmli8dpI1jeFH/5AVRM7XrWTkRJfk3COoPjaBGF+u1ut3WfC5tg11ikTSrpBnjeHeAH4mU15NBtsHFBPPtKAcgUc/GDFThNPvoBEaLziQ9XySO2fDSY4EVprffdUxmFb1AYcS7j2+pikAc3NdBs50S75ud70HdUDQHjwd1AR97b+44Nt02yqRK+5oD+JLVedCzYHXIDMBjBzVzXBnz/lJYMfPB/g9HKJzsDEh2aqFN8Y/UlnggTqwrFBWTOGQhtGSUU6D/rFjVMayCQwyEgdd2JBECxyKIkEZ+krbG4pvNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2170c3bc-b3af-45d7-aef6-08d844412519
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 13:09:46.0497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlEJiMnb6n6TxhWtF2K4SO8bB5h3vSdpWZItUje2H3+TQXGPwt/qwNdDBPzoEtQVAl/BG5JP81scRkOxx7YQgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
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

Ck9uIDgvMTkvMjAgMjo1OCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxOS4wOC4y
MCB1bSAxNDo1MSBzY2hyaWViIFNoYXNoYW5rIFNoYXJtYToKPj4gT24gMTkvMDgvMjAgNjoxNSBw
bSwgTmlybW95IHdyb3RlOgo+Pj4gSGkgQ2hyaXN0aWFuLAo+Pj4KPj4+IE9uIDgvMTkvMjAgMjow
OCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Cj4+Pj4gQW0gMTkuMDguMjAgdW0gMTM6
NTIgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+Pj4+IE9uIDEzLzA4LzIwIDE6MjggcG0sIENo
cmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+PiBBbSAxMy4wOC4yMCB1bSAwNTowNCBzY2hyaWVi
IFNoYXNoYW5rIFNoYXJtYToKPj4+Pj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgdHJhY2UgZXZl
bnQgdG8gdHJhY2sgdGhlIFBURSB1cGRhdGUKPj4+Pj4+PiBldmVudHMuIFRoaXMgc3BlY2lmaWMg
ZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+Pj4+Pj4gLSBzdGFydCBhbmQg
ZW5kIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmcKPj4+Pj4+PiAtIEhXIGVuZ2luZSBmbGFncyBm
b3IgdGhlIG1hcAo+Pj4+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFwcGluZwo+Pj4+Pj4+
Cj4+Pj4+Pj4gVGhpcyB3aWxsIGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9yeSBwcm9m
aWxpbmcgdG9vbHMKPj4+Pj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBw
YWdlIHRhYmxlIHVwZGF0ZSBldmVudHMuCj4+Pj4+Pj4KPj4+Pj4+PiBWMjogQWRkZWQgcGh5c2lj
YWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQKPj4+Pj4+PiBWMzogc3dpdGNo
IHRvIHVzZSBfX2R5bmFtaWNfYXJyYXkKPj4+Pj4+PiDCoMKgwqDCoMKgwqAgYWRkZWQgbnB0ZXMg
aW50IHRoZSBUUHByaW50IGFyZ3VtZW50cyBsaXN0Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgIGFkZGVk
IHBhZ2Ugc2l6ZSBpbiB0aGUgYXJnIGxpc3QKPj4+Pj4+PiBWNDogQWRkcmVzc2VkIENocmlzdGlh
bidzIHJldmlldyBjb21tZW50cwo+Pj4+Pj4+IMKgwqDCoMKgwqDCoCBhZGQgc3RhcnQvZW5kIGlu
c3RlYWQgb2Ygc2VnCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFn
ZV9zeiB0byBiZSBhY2N1cmF0ZQo+Pj4+Pj4+Cj4+Pj4+Pj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBT
aGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+
Pj4+IMKgwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCB8IDM3
Cj4+Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4+PiDCoMKgwqAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmPCoMKgwqAgfMKgIDkgKysrKy0tCj4+Pj4+Pj4g
wqDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHJhY2UuaAo+Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3RyYWNlLmgKPj4+Pj4+PiBpbmRleCA2M2U3MzRhMTI1ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQK
Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+
Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+
Pj4+Pj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9tYXBwaW5n
LCAKPj4+Pj4+PiBhbWRncHVfdm1fYm9fY3MsCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBUUF9BUkdTKG1hcHBpbmcpCj4+Pj4+Pj4gwqDCoMKgICk7Cj4+Pj4+Pj4gwqDCoMKgICtUUkFD
RV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFRQ
X1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQsCj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRz
dCwKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGluY3IsIHVpbnQ2
NF90IGZsYWdzKSwKPj4+Pj4+PiArwqDCoMKgIFRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMs
IGRzdCwgaW5jciwgZmxhZ3MpLAo+Pj4+Pj4+ICvCoMKgwqAgVFBfU1RSVUNUX19lbnRyeSgKPj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZmllbGQodTY0LCBzdGFydCkKPj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZmllbGQodTY0LCBlbmQpCj4+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKHU2NCwgaW5jcikKPj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZHluYW1pY19hcnJheSh1NjQsIGRzdCwgbnB0ZXMpCj4+
Pj4+PiBBcyBkaXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVtIG1haW50YWluZXIgd2Ug
bmVlZCB0byBhZGQgCj4+Pj4+PiB0aGUgcGlkCj4+Pj4+PiBhbmQgcHJvYmFibHkgdGhlIFZNIGNv
bnRleHQgSUQgd2UgdXNlIGhlcmUgdG8gaWRlbnRpZnkgdGhlIAo+Pj4+Pj4gdXBkYXRlZCBWTS4K
Pj4+Pj4+Cj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+IEkgcHJpbnRlZCBib3RoIHZtLT50YXNrX2lu
Zm8ucGlkIFZzIGN1cnJlbnQtPnBpZCBmb3IgdGVzdGluZywgYW5kIEkKPj4+Pj4gY2FuIHNlZSBk
aWZmZXJlbnQgdmFsdWVzIGNvbWluZyBvdXQgb2YgLgo+Pj4+Pgo+Pj4+PiBnbm9tZS1zaGVsbC0y
MTE0wqAgWzAxMV3CoMKgwqAgNDEuODEyODk0OiBhbWRncHVfdm1fdXBkYXRlX3B0ZXM6Cj4+Pj4+
IHN0YXJ0OjB4MDgwMDEwMmU4MCBlbmQ6MHgwODAwMTAyZTgyLCBmbGFnczoweDgwLCBpbmNyOjQw
OTYsIHBpZD0yMTI4Cj4+Pj4+IHZtaWQ9MCBjcGlkPTIxMTQKPj4+Pj4KPj4+Pj4gcGlkIGlzIHZt
LT50YXNrX2luZm8ucGlkPTIxMjggd2hlcmVhcyBjcGlkPTIxMTQgaXMgY3VycmVudC5waWQuCj4+
Pj4+Cj4+Pj4+IFdoaWNoIGlzIHRoZSBvbmUgd2Ugd2FudCB0byBzZW5kIHdpdGggdGhlIGV2ZW50
ID8KPj4+PiBUaGF0IGlzIHZtLT50YXNrX2luZm8ucGlkLCBzaW5jZSB0aGlzIGlzIHRoZSBQSUQg
d2hpY2ggaXMgdXNpbmcgdGhlIFZNCj4+Pj4gZm9yIGNvbW1hbmQgc3VibWlzc2lvbi4KPj4+IE5v
b2IgcXVlc3Rpb246Cj4+Pgo+Pj4gV2h5IHRoZXNlIHR3byBwaWRzIGFyZSBkaWZmZXJlbnQgPyBJ
cyBpdCBsaWtlIHRoYXQsIHRoZSBjcGlkLTIxMTQKPj4+IHByb2Nlc3MgY3JlYXRlZCBhIHBhZ2Uv
bWVtb3J5LWFyZWEgYW5kIG5vdyBwaWQtMjEyOCB1c2luZyB0aGF0Cj4+PiBwYWdlL21lbW9yeS1h
cmVhIHRvIHN1Ym1pdCBhIGNvbW1hbmQgPwo+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhp
cyBpcyBkdWUgdG8gYSBzZXJ2ZXItY2xpZW50IGFycmFuZ2VtZW50LCAKPj4gd2hlcmUgYSBjbGll
bnQgcHJvY2VzcyBjYW4gY3JlYXRlIGEgbWVtb3J5IG1hcCBhbmQgZmlsbCBpdCBmb3IgdGhlIAo+
PiBzdWJtaXNzaW9uLCBidXQgaXQgZG9lc250IGhhdmUgcHJpdmlsZWdlIHRvwqAgZG8gdGhhdCwg
YW5kIHRoYXQgc2hvdWxkIAo+PiBiZSBkb25lIGJ5IHRoZSBzZXJ2ZXIgcHJvY2VzcyAobGlrZSBY
L3dheWxhbmQgZXRjKQo+Cj4gVGhhdCdzIGNsb3NlIGJ1dCBub3QgcXVpdGUgY29ycmVjdC4KPgo+
IE9uZSB1c2UgY2FzZSBpcyB3aGF0IFNoYXNoYW5rIGRlc2NyaWJlcyBoZXJlIHdoZXJlIHRoZSBz
ZXJ2ZXIgCj4gYWxsb2NhdGVzIHNvbWV0aGluZyBvbiBiZWhhbHZlcyBvZiB0aGUgY2xpZW50IGFu
ZCBiZWNhdXNlIG9mIGRlbGF5ZWQgCj4gdXBkYXRlcyB3ZSBlbmQgdXAgdXBkYXRpbmcgdGhlIHBh
Z2UgdGFibGVzIGluIGEgZGlmZmVyZW50IHByb2Nlc3MgdGhlbiAKPiB3aGVyZSBzb21ldGhpbmcg
aXMgcmVhbGx5IHVzZWQuCj4KPiBCdXQgdGhlIG1vcmUgY29tbWFuZCB1c2UgY2FzZSBpcyBldmlj
dGlvbiB3aGVyZSBwcm9jZXNzIEEgaXMga2lja2luZyAKPiBvdXQgQk9zIG9mIHByb2Nlc3MgQiBh
bmQgYmVjYXVzZSBvZiB0aGlzIHRoZSBwYWdlIHRhYmxlIG9mIHByb2Nlc3MgQiAKPiBhcmUgdXBk
YXRlZCBpbiB0aGUgY29udGV4dCBvZiBBLgo+CgpVbmRlcnN0b29kLCB0aGFua3MgQ2hyaXN0YWlu
IGFuZCBTaGFzaGFuayBmb3IgdGhlIGV4cGxhbmF0aW9uIQoKCk5pcm1veS4KCgo+IFJlZ2FyZHMs
Cj4gQ2hyaXN0aWFuLgo+Cj4KPj4KPj4gLSBTaGFzaGFuawo+Pgo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
