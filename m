Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C76C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25E9207F7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FL7cMb/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25E9207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEB06E0D4;
	Wed, 12 Aug 2020 12:09:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C2E36E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 12:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyGUHXp95aJnCc+ukwdqNVgXEz5wwakDdbeBRXFDIc+b4c1JqttSSb3UShngNkal7+EeJmw5+c15GDPKfa2ZF3OdvVg3xZPeduAGUC4YQLN5ouZd+WWAbsLHIlriyc8La3lfqZdVH2N3W8iSyUUkAsIgwTTtimGmLtetF3CmriiHDHiJsUUk0VX74KjYYVwQkulDLWxoXRsZdHf7nYX5IiD/f4EadSJQbiLKFhA8jz5nXuL1U3XNX/8GAqSoqoiS2XfmF1UZOVLStsXwXdEIFpt5lX+5h0jrlv4Ks1inwec1RKtqxlGKRkdX3gjFVj1eTI5z4orsdP4Mnw+uPXzWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXXepKTvN8+zAsT55zxecRH7eSeTF9o8oAk6YZa7qIY=;
 b=JulVpOFLrCECySH/34xVy319KPU8hLj3OwPJgkSjKhBzFNuvmxMQeVPLpvxxMtcRmZcMUpZtzvca4g4qY1O78N5QGbzG0pcZuAKjw36I8TXJoXNTWwyuR0dkb8JGeXlQ+mrshOm7yJqQj7rtJVZ/S2cGVnF57KpoFl6lsntYDK1zfExKeiHaIdgd40QMy5jfYENbrG3OThHqjwSevwhyrW3OIe80rLKcrdo+4RVV1prVEawAfBtOic9hA8vAeyyF5U2uU8xSlTm6cLwMwd3KMAS6gw3wsMh5FU03JimV0TlQCoNsx+hyxhMPJkwMuJdNNJ5stscJav1AWZfoMb/+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXXepKTvN8+zAsT55zxecRH7eSeTF9o8oAk6YZa7qIY=;
 b=FL7cMb/ZAo5XfVgoZXcD9DlKEBJ1g6sGSit0QKSyYJt13txI+6C6lGN6BJyyNj10gbCzhNnVsYWBaqsQ99kou/oBtrIsZH2Nr/nLQqpJpc1mzOzgZcfPjKEsFOSh0nyVrfuujthQK/pnf48Bh0amdlvw+0keZyRgYC2bmm3Fn/A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 12:09:18 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 12:09:18 +0000
Subject: Re: [PATCH v3] drm/amdgpu: add new trace event for page table update
 v3
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200812043336.127057-1-shashank.sharma@amd.com>
 <e32e6e5c-d808-44eb-7136-9b258c0201c1@gmail.com>
 <43f137f7-90cd-bb8b-f27f-a80a6c18aedc@amd.com>
 <be160250-b879-3478-2788-fee82dd60d53@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <6579415d-5a4f-e5b4-2142-e38931d71c7f@amd.com>
Date: Wed, 12 Aug 2020 17:39:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <be160250-b879-3478-2788-fee82dd60d53@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::33)
 To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.155.163] (165.204.158.249) by
 BM1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 12:09:16 +0000
X-Originating-IP: [165.204.158.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c25b6a0-ee73-490e-a50b-08d83eb889e8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2791EC486F1B0AB61E978A12F2420@BYAPR12MB2791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quJxMIJ7IMOz7MpqqkPLZkN5PAfU4D2YGDpUdyhGKw32yki9h5vFAQ3hDU0ByQPXmCbhnoeU06uoakh5whxHboxhN6fCDT/lNOH0enFDRAbLza7ftHQ8jtV3bOWtR4daH7+uMkJ6sGmJZhekTO6MrXVxqVeAij29qR2Fg0ou7mCklhcHjW9OjFbgBG63WnhIziPFgkliyby1bK0FuyiiB03CKJo0Y0nu8LOBVg+Z3F+9F2gtB5H959DU0Y4zMF5mOe6ABsidp0Cj91ZmO+oTp3DlkB0pu+hFubvgtG1x5QKsxGZL0x6E/UT46dDgIj3mXh6IvntbqGJXTSXHbJn/sAEiB1D9VmF+hBIWLuTfqToXMDxyHAxosx+uHDMv9pxV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(52116002)(36756003)(6666004)(31696002)(66574015)(83380400001)(15650500001)(4326008)(26005)(8676002)(86362001)(53546011)(16576012)(44832011)(31686004)(6486002)(316002)(2906002)(478600001)(8936002)(5660300002)(956004)(186003)(16526019)(66556008)(66946007)(66476007)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 56uNfeL1JITpK+FNPHU9EQuUxItMessrFQiKMgtDSNQzj9WmTXRHv/Tk2CN14F3wdvCliObwbcClKd/E42YJyPCnr+uRVbXeFXBPSA4H5/EdnkzvqCenzMukBUn2fo2wFImezJtwRfqzDGdBsAv4AjQ5O4mGeEGeHXcBnv56TubZ6eGi0CbLOrmi55qUG6fAo7+OH9agffqTzLG9AUluuMbstOGUw3Csksp3+aH+uRQIQLzfNPWges7QwadNIxeD0mUpNPoN6o2RHZDmbCUVWtl34Runld6NZHPXp36QgJWDUWQTnYUwwT5M26YC2f4B3ym4O/4Lj+ZVl0UdtAuECUxPkuTw7+Uyqg/fttNSC79fYhuS8c5jwMUi/XVR+G8sdswpJ/ArZUp1FzmsCbUCoDOl7lEaTwzys4d8scaiM61hrEPKYXem2GrpSyibE6pxErzAhzNMIkbVe6VIIH7SgcI7lEl5ffZs05SOl0Az5BS0XqCIM3+UcWZDrnnIUpOQYVwHMCvsc2zUmwD7vA59usvta4ejNsobz/GqsXYnVsuQJ4rRu6djw+pBuefNiENknqSnE2CyPBvNDCf+WB/Ol6QxPOodWPTWcVbaTLZ8xCOTHhGLvHYDNErb0CsPonNer1AHBBrxhnmgdd1JGk8UNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c25b6a0-ee73-490e-a50b-08d83eb889e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 12:09:18.3583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy/BPrUQKYjn7T3rse91b9Q5Bve0LDaiBtPYSv1ZZPRRRlnTSqLQZ1fO60julIFvWgb9nvCM7Zz9SEf2K/azjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEyLzA4LzIwIDI6MDIgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTIuMDgu
MjAgdW0gMTA6MTUgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IEhlbGxvIENocmlzdGlhbiwK
Pj4KPj4gT24gMTIvMDgvMjAgMTI6MTUgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBB
bSAxMi4wOC4yMCB1bSAwNjozMyBzY2hyaWViIFNoYXNoYW5rIFNoYXJtYToKPj4+PiBUaGlzIHBh
dGNoIGFkZHMgYSBuZXcgdHJhY2UgZXZlbnQgdG8gdHJhY2sgdGhlIFBURSB1cGRhdGUKPj4+PiBl
dmVudHMuIFRoaXMgc3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxpa2U6
Cj4+Pj4gLSBzdGFydCBhbmQgZW5kIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmcKPj4+PiAtIEhX
IGVuZ2luZSBmbGFncyBmb3IgdGhlIG1hcAo+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFw
cGluZwo+Pj4+Cj4+Pj4gVGhpcyB3aWxsIGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9y
eSBwcm9maWxpbmcgdG9vbHMKPj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRo
ZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVudHMuCj4+Pj4KPj4+PiBWMjogQWRkZWQgcGh5c2ljYWwg
YWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQKPj4+PiBWMzogc3dpdGNoIHRvIHVz
ZSBfX2R5bmFtaWNfYXJyYXkKPj4+PiAgICAgICBhZGRlZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQg
YXJndW1lbnRzIGxpc3QKPj4+PiAgICAgICBhZGRlZCBwYWdlIHNpemUgaW4gdGhlIGFyZyBsaXN0
Cj4+Pj4KPj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+Pj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFt
ZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3RyYWNlLmggfCAzOCArKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+ICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgIDkgKysrKy0tCj4+Pj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4+PiBpbmRleCA2M2U3MzRh
MTI1ZmIuLmI5YWFlNzk4M2I0YiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4gQEAgLTMyMSw2ICszMjEsNDQgQEAgREVGSU5FX0VWRU5U
KGFtZGdwdV92bV9tYXBwaW5nLCBhbWRncHVfdm1fYm9fY3MsCj4+Pj4gICAgCSAgICBUUF9BUkdT
KG1hcHBpbmcpCj4+Pj4gICAgKTsKPj4+PiAgICAKPj4+PiArVFJBQ0VfRVZFTlQoYW1kZ3B1X3Zt
X3VwZGF0ZV9wdGVzLAo+Pj4+ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRl
X3BhcmFtcyAqcCwKPj4+PiArCQkgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQsCj4+
Pj4gKwkJICAgICB1bnNpZ25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRzdCwKPj4+PiArCQkgICAg
IHVpbnQ2NF90IGluY3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4+PiArCVRQX0FSR1MocCwgc3RhcnQs
IGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAo+Pj4+ICsJVFBfU1RSVUNUX19lbnRyeSgK
Pj4+PiArCQkJIF9fZmllbGQodTY0LCBzdGFydCkKPj4+PiArCQkJIF9fZmllbGQodTY0LCBlbmQp
Cj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgaW5j
cikKPj4+PiArCQkJIF9fZmllbGQodW5zaWduZWQgaW50LCBucHRlcykKPj4+PiArCQkJIF9fZHlu
YW1pY19hcnJheSh1NjQsIGRzdCwgbnB0ZXMpCj4+Pj4gKwkpLAo+Pj4+ICsKPj4+PiArCVRQX2Zh
c3RfYXNzaWduKAo+Pj4+ICsJCQl1bnNpZ25lZCBpbnQgaTsKPj4+PiArCj4+Pj4gKwkJCV9fZW50
cnktPnN0YXJ0ID0gc3RhcnQ7Cj4+Pj4gKwkJCV9fZW50cnktPmVuZCA9IGVuZDsKPj4+PiArCQkJ
X19lbnRyeS0+ZmxhZ3MgPSBmbGFnczsKPj4+PiArCQkJX19lbnRyeS0+aW5jciA9IGluY3I7Cj4+
Pj4gKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7Cj4+Pj4gKwo+Pj4+ICsJCQlmb3IgKGkgPSAw
OyBpIDwgbnB0ZXM7ICsraSkgewo+Pj4+ICsJCQkJdTY0IGFkZHIgPSBwLT5wYWdlc19hZGRyID8g
YW1kZ3B1X3ZtX21hcF9nYXJ0KAo+Pj4+ICsJCQkJCXAtPnBhZ2VzX2FkZHIsIGRzdCkgOiBkc3Q7
Cj4+Pj4gKwo+Pj4+ICsJCQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRzdCkpW2ldID0g
YWRkcjsKPj4+PiArCQkJCWRzdCArPSBpbmNyOwo+Pj4+ICsJCQl9Cj4+Pj4gKwkpLAo+Pj4+ICsJ
VFBfcHJpbnRrKCJzZWc6MHglMDEwbGx4LTB4JTAxMGxseCwgZmxhZ3M6MHglbGx4LCBucHRyPSV1
LCBwZ3N6OiVsbHUsIgo+Pj4+ICsJCSAgIiBkc3Q6XG4lcyIsIF9fZW50cnktPnN0YXJ0LCBfX2Vu
dHJ5LT5lbmQsIF9fZW50cnktPmZsYWdzLAo+Pj4+ICsJCSAgX19lbnRyeS0+bnB0ZXMsIF9fZW50
cnktPmluY3IsCj4+PiBUaGlzIGlzIG5vdCBjb3JyZWN0LiBUaGUgaW5jcmVtZW50IGlzIE5PVCB0
aGUgcGFnZSBzaXplLCBidXQgcmF0aGVyIHRoZQo+Pj4gcGFnZSBzaXplIHJvdW5kZWQgZG93biB0
byBhIHBvd2VyIG9mIDUxMis0Sy4KPj4+Cj4+PiBJbiBvdGhlciB3b3JkcyBwYWdlIHNpemUgY2Fu
IGJlIDRLLCA4SywgMTZLLCAzMkssIDY0Sy4uLi4xTSwgMk0sCj4+PiA0TS4uLi41MTJNLCAxRywg
MkcuLi4uCj4+Pgo+Pj4gQnV0IHRoZSBpbmNyZW1lbnQgY2FuIG9ubHkgYmUgNEssIDJNLCAxRy4u
Li4KPj4gVW5kZXJzdG9vZC4gQnV0IEkgdGhpbmsgdGhlIHJlcXVpcmVtZW50IGhlcmUgaXMgZm9y
IGluY3JlbWVudC4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSB0b29sIG5lZWRzIHRvIHNh
dmUgdGhlIHBhZ2UgZW50cmllcywgYW5kIGZvciB0aGF0LCBpdCB3aWxsIG5lZWQgc3RhcnQgb2Yg
dmlydHVhbCBtZW0sIHN0YXJ0IG9mIHBoeXNpY2FsIG1lbSwgbWFwcGluZyBzaXplIGFuZCBzdGVw
IHRvIGluY3JlbWVudCB0aGUgZW50cmllcy4gSWYgdGhhdCdzIHNvLCB3ZSBjYW4gcmUtbGFiZWwg
dGhpcyBlbnRyeSBhcyAic3RlcCIgaW5zdGVhZCBvZiAicGFnZSBzaXplIi4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHlvdSB0aGluayBpdCdzIHRoZSByaWdodCB0aGluZyB0byBkby4KPiBXZSBjb3Vs
ZCBzdGljayB3aXRoIHRoZSBuYW1pbmcgaW5jcmVtZW50IGlmIHRoYXQgaGVscHMsIGJ1dCB0aGlz
IGNhbiAKPiBhbHNvIGJlIGRlcml2ZWQgZnJvbSB0aGUgbnVtYmVyIG9mIGRlc3RpbmF0aW9uIGFk
ZHJlc3NlcyB3ZSBoYXZlLgpzdXJlLCBpIHdpbGwgbWFrZSBpdCBpbmNyZW1lbnQuCj4KPiBPbiB0
aGUgb3RoZXIgaGFuZCBleHBsaWNpdGx5IG1lbnRpb25pbmcgaXQgcHJvYmFibHkgd29uJ3QgaHVy
dCB1cyBlaXRoZXIuCj4KPiBBbmQgYnkgdGhlIHdheSB3aGF0IGRvZXMgInNlZyIgbWVhbj8KCkFo
LCB0byBnZXQgaW50byA4MCBjaGFyIGxpbWl0LCBJIG1hZGUgJ3NlZ21lbnQnIGFzICdzZWcnIGFu
ZCBsYXRlciBqdXN0IHJlYWxpemVkIEkgaGF2ZSB0byBzdGlsbCBicmVhayB0aGUgcHJpbnQgaW50
byB0d28gbGluZXMgOikgLiBJIHdpbGwgbWFrZSBpdCBiYWNrIHRvIHNlZ21lbnQgb3Igc3RhcnQv
ZW5kCgotIFNoYXNoYW5rCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+PiBBbmQgZG8gd2UgbmVlZCB0aGUg
bnB0ZXMgaGVyZT8gV2UganVzdCBuZWVkIGl0IHRvIHByaW50IHRoZSBjb3JyZWN0Cj4+PiBudW1i
ZXIgb2YgZGVzdGluYXRpb24gYWRkcmVzc2VzLgo+PiBBZ3JlZSwgd2UgZG9uJ3QgcmVhbGx5IG5l
ZWQgbnB0ZXMgaGVyZSwgSSB3aWxsIHJlbW92ZSB0aGF0IGFuZCBzZW5kIFY0Lgo+Pgo+PiAtIFNo
YXNoYW5rCj4+Cj4+PiBSZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+PiArCQkgIF9fcHJp
bnRfYXJyYXkoX19nZXRfZHluYW1pY19hcnJheShkc3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpCj4+
Pj4gKyk7Cj4+Pj4gKwo+Pj4+ICAgIFRSQUNFX0VWRU5UKGFtZGdwdV92bV9zZXRfcHRlcywKPj4+
PiAgICAJICAgIFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRfdCBhZGRyLCB1bnNpZ25lZCBj
b3VudCwKPj4+PiAgICAJCSAgICAgdWludDMyX3QgaW5jciwgdWludDY0X3QgZmxhZ3MsIGJvb2wg
ZGlyZWN0KSwKPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+IGlu
ZGV4IDcxZTAwNWNmMjk1Mi4uYjVkYmI1ZThiYzYxIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+PiBAQCAtMTUxMywxNyArMTUxMywyMiBAQCBzdGF0
aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJh
bXMgKnBhcmFtcywKPj4+PiAgICAJCWRvIHsKPj4+PiAgICAJCQl1aW50NjRfdCB1cGRfZW5kID0g
bWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+Pj4+ICAgIAkJCXVuc2lnbmVkIG5wdGVzID0gKHVw
ZF9lbmQgLSBmcmFnX3N0YXJ0KSA+PiBzaGlmdDsKPj4+PiArCQkJdWludDY0X3QgdXBkX2ZsYWdz
ID0gZmxhZ3MgfCBBTURHUFVfUFRFX0ZSQUcoZnJhZyk7Cj4+Pj4gICAgCj4+Pj4gICAgCQkJLyog
VGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZlbCBQRHMgdG8KPj4+PiAgICAJ
CQkgKiBzaWxlbnQgdG8gc3RvcCBmYXVsdCBmbG9vZHMuCj4+Pj4gICAgCQkJICovCj4+Pj4gICAg
CQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPj4+PiArCj4+Pj4gKwkJCXRyYWNlX2FtZGdwdV92
bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4+Pj4gKwkJCQkJCSAg
ICBucHRlcywgZHN0LCBpbmNyLAo+Pj4+ICsJCQkJCQkgICAgdXBkX2ZsYWdzKTsKPj4+PiAgICAJ
CQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBhcmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPj4+PiAg
ICAJCQkJCSAgICAgICBwZV9zdGFydCwgZHN0LCBucHRlcywgaW5jciwKPj4+PiAtCQkJCQkgICAg
ICAgZmxhZ3MgfCBBTURHUFVfUFRFX0ZSQUcoZnJhZykpOwo+Pj4+ICsJCQkJCSAgICAgICB1cGRf
ZmxhZ3MpOwo+Pj4+ICAgIAo+Pj4+ICAgIAkJCXBlX3N0YXJ0ICs9IG5wdGVzICogODsKPj4+PiAt
CQkJZHN0ICs9ICh1aW50NjRfdClucHRlcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0
Owo+Pj4+ICsJCQlkc3QgKz0gbnB0ZXMgKiBpbmNyOwo+Pj4+ICAgIAo+Pj4+ICAgIAkJCWZyYWdf
c3RhcnQgPSB1cGRfZW5kOwo+Pj4+ICAgIAkJCWlmIChmcmFnX3N0YXJ0ID49IGZyYWdfZW5kKSB7
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
