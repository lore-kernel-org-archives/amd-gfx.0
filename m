Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DEC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 17:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D9E206D4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H4AxSrNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D9E206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC1D6E26F;
	Tue,  4 Aug 2020 17:32:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED88F6E26F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 17:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9X99XEbaSWH8Dnvq4KGdsMHeGXvLKm2t26HdMUmMXroLCVvRKfCBf+rpR4C6J5kmBIkxkjXh4TVFnjEaoUwxSuWutkwEouaiovTRhLEaCrgkaeIF5ifO8PD+lkojfUfO1QByT+IodICS82HJyb1+00AIjOo/+0vEegyTInNaZ79osR22XtFo7S3j+C8DE1J9H9gaozYUhgI8zJRBl1BOFZY4vaGC4uH1G9VxkTAhrhAlZwyH+uo2yA29vwriVXCacYNShSooCdY9JzeTwtqakz8bH15aH4H2JcW5RE4Cugf97HsU8OVeBwV3mj61ik6frWHLnxya+4g2PHKPv7mnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+ukNlFjVRQ5FR1Q679GTlXBg7xtLEYJ+fCDfbKiD5A=;
 b=ItkyzEcECwBSAqx2GEiMBHgV2vWrPSHABsXUUrjX1egt2evi7bre+L8DoD3ILxQs5JgXw2prBzMPs77hJFtePTq8vwuzNMItkePjxNe7XqSMFXAbiWFNPO2ssJ+KzG3qNuZ9s3jXxr3wqUegBJIuP8sEEGrEY3c9o6mbnmTDPOwMd9ZaXrKYLzcT8TeVkMJ+eGDTHA1x4/+rckQZPZHiI/tw2oKn6PJD40coCHeFmcWZKyItLAhtLjsbG+UL4EO5kOTlbqRAu090Oj/QxtaPZ+WDTr5Fs+/NW5/0IbCRPi31Ii1LS0h+vPh5TAe2G41qUIBnVxHqqVAzTaOvRFm35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+ukNlFjVRQ5FR1Q679GTlXBg7xtLEYJ+fCDfbKiD5A=;
 b=H4AxSrNP05K3SBfptwn9xzk+tKaSe5eFfvl66iKI47jV654KxsNi+VZq5JEX9df/VX8a2kKBza20z+dInYIvxywrgu8ySO2qNS0bJ5qagJEC+fDlR7EgCdWB1mGOCtHSL9eBJBnj99EDdMUo4+gi9qHOnBvJGUUp1mYT0dRgabo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Tue, 4 Aug
 2020 17:32:22 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 17:32:22 +0000
Subject: Re: [PATCH] drm/amdkfd: option to disable system mem limit
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200727132455.26657-1-Philip.Yang@amd.com>
 <406653af-5b66-6c77-1104-8fdf89be5c99@amd.com>
 <CADnq5_Nbg+sKXOJ9diUwqt6y19Uk+v_YNcE_PhDEGmgnZLm0cw@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3ffb67dd-4607-69fb-3acf-2552ee9101ce@amd.com>
Date: Tue, 4 Aug 2020 13:32:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_Nbg+sKXOJ9diUwqt6y19Uk+v_YNcE_PhDEGmgnZLm0cw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::42)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YQBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 17:32:21 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c672aed5-f487-4c98-b500-08d8389c585d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB457312D9AD8240AF049595B4924A0@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsgCVRXI59c9kUZ0pZR71ZzWtK2A/OxuzV1J621G8NhZjfOgo0awHxt5Ngt+Mj2fU/vPBySTqO+TEfocuvsZTIknDoK2j6thQSd9FeHQqyeUmdKV3XXRCgZzDnObJsgalOib+g7Kq2sRrUTL94NEaz5cCJEq9xsF62Dy6ACC2F2nsZ8neIbS7B+JNYLsekg7RGOgcMZEQiN5QC0OP71ZfWNYz4SpkVZMGTol8r+OY4T9ED0XGRM+DQmEXgv2hdiGUoZ4dtJ7sSXKhUbvk52lg7iu+5UhuXv2MvqkfRdqr5TmKYDcrJ6K6jEBYbgMEesiiNVo0Du93OU6wRgbJLDqQTvvnHC45Z6BDF8OYutbgTBYOn7omdb8chIz0mMGtyL0x7ppTlCUr0v7iGLSqbew3370pK5wT+60oR6IMjTq+jA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(36756003)(83380400001)(966005)(5660300002)(478600001)(4326008)(86362001)(31696002)(2616005)(956004)(44832011)(53546011)(52116002)(8676002)(16526019)(186003)(31686004)(8936002)(26005)(54906003)(316002)(6916009)(6486002)(2906002)(66476007)(66946007)(66556008)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xdc49t/190MRGYz56Bmv7gNA6THNGy35kZcKgOgtXaC4ddCCkz/VvO9QReN+e0av79mD5cYMsnuFTHYQlKyZDXSVlOYUSaCcyQlS89I2aN9+BMCBPHtFf1umdBObRDDCAImO6Xt8EnCUZstfStsiTv6qSW30xyJ3QMWvoK1gV1b/T9VrMbjVYNuhomh62eTqkRJSN4IaXR+QugIZFyhbTUbLnVXeNZ6FvW3R4NzNcyGngnnfOkWZZnniTfxjen4AOLtWEp5UTSjoNV7vK1+k2QwvqPk7iLbegaTce50hD7fOv/SZzrheG2VB+IKP5MtGT0E/RjMIc1f8dk+RjLtAfa6JPYqNxo/wAX2biwqRAzz/GqJbeiMXkWMD1BRt7F0b8KlXPUmKTM7p0MZqyeKWA7Y5ioHc3fu1QNzhlynyeh7acNKDwbXZRs7IfOr3d7svjdVll3isrdoggm2ra03NsEpdxr483kL0jBovp5QPqjAHLM9OYQCUFeg8C25b4GteFZ1dedk6ghSNOoFdSQ9h1b531MOmGBhy8q9SBy8YoTEXfEDq0p9q98UqeMWrFkUwVl738WpTLn8b3TH1+913OBu35UVfJSW7S62qFFjyhiwTwn6HFuxHSBvaM/Y2auirdAh6cRdv1wpuDLAvNIFRPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c672aed5-f487-4c98-b500-08d8389c585d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 17:32:22.3034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBl6vfiCgC9tP/5S9b+KJZW9ylfTcrIJxaxVXxcXN+EGXCN3L/A4Pwz7mv+xlvG5Cm9XzfcFDtEUBoyT5lTmMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wOC0wNCB1bSAxOjI5IHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gVHVl
LCBBdWcgNCwgMjAyMCBhdCAxOjI3IFBNIEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0Bh
bWQuY29tPiB3cm90ZToKPj4gQW0gMjAyMC0wNy0yNyB1bSA5OjI0IGEubS4gc2NocmllYiBQaGls
aXAgWWFuZzoKPj4+IElmIG11bHRpcGxlIHByb2Nlc3Mgc2hhcmUgc3lzdGVtIG1lbW9yeSB0aHJv
dWdoIC9kZXYvc2htLCBLRkQgYWxsb2NhdGUKPj4+IG1lbW9yeSBzaG91bGQgbm90IGZhaWwgaWYg
aXQgcmVhY2hzIHRoZSBzeXN0ZW0gbWVtb3J5IGxpbWl0IGJlY2F1c2UKPj4+IG9uZSBjb3B5IG9m
IHBoeXNpY2FsIHN5c3RlbSBtZW1vcnkgYXJlIHNoYXJlZCBieSBtdWx0aXBsZSBwcm9jZXNzLgo+
Pj4KPj4+IEFkZCBtb2R1bGUgcGFyYW1ldGVyIHRvIHByb3ZpZGUgdXNlciBvcHRpb24gdG8gZGlz
YWJsZSBzeXN0ZW0gbWVtb3J5Cj4+PiBsaW1pdCBjaGVjaywgdG8gcnVuIG11bHRpcGxlIHByb2Nl
c3Mgc2hhcmUgbWVtb3J5IGFwcGxpY2F0aW9uLiBCeQo+Pj4gZGVmYXVsdCB0aGUgc3lzdGVtIG1l
bW9yeSBsaW1pdCBpcyBvbi4KPj4+Cj4+PiBQcmludCBvdXQgZGVidWcgbWVzc2FnZSB0byB3YXJu
IHVzZXIgaWYgS0ZEIGFsbG9jYXRlIG1lbW9yeSBmYWlsZWQKPj4+IGJlY2F1c2Ugb2Ygc3lzdGVt
IG1lbW9yeSBsaW1pdC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlw
LllhbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oICAgICAgICAgICAgICB8IDIgKysKPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA5ICsrKysrKysrLQo+Pj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgICAgICAgICB8IDkgKysrKysrKysrCj4+PiAgMyBm
aWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPj4+IGluZGV4IGU5N2MwODhkMDNiMy4uM2MwZDVl
Y2ZlMGQ1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+PiBAQCAt
MTg3LDkgKzE4NywxMSBAQCBleHRlcm4gaW50IGFtZGdwdV9mb3JjZV9hc2ljX3R5cGU7Cj4+PiAg
I2lmZGVmIENPTkZJR19IU0FfQU1ECj4+PiAgZXh0ZXJuIGludCBzY2hlZF9wb2xpY3k7Cj4+PiAg
ZXh0ZXJuIGJvb2wgZGVidWdfZXZpY3Rpb25zOwo+Pj4gK2V4dGVybiBib29sIG5vX3N5c3RlbV9t
ZW1fbGltaXQ7Cj4+PiAgI2Vsc2UKPj4+ICBzdGF0aWMgY29uc3QgaW50IHNjaGVkX3BvbGljeSA9
IEtGRF9TQ0hFRF9QT0xJQ1lfSFdTOwo+Pj4gIHN0YXRpYyBjb25zdCBib29sIGRlYnVnX2V2aWN0
aW9uczsgLyogPSBmYWxzZSAqLwo+Pj4gK3N0YXRpYyBjb25zdCBib29sIG5vX3N5c3RlbV9tZW1f
bGltaXQ7Cj4+PiAgI2VuZGlmCj4+Pgo+Pj4gIGV4dGVybiBpbnQgYW1kZ3B1X3RtejsKPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4+
IGluZGV4IDg3MDNhYTFmZTRhNS4uNTAyZTgyMDRjMDEyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4+IEBAIC05OSw3
ICs5OSwxMCBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZ3B1dm1faW5pdF9tZW1fbGltaXRzKHZvaWQp
Cj4+PiAgICAgICBtZW0gKj0gc2kubWVtX3VuaXQ7Cj4+Pgo+Pj4gICAgICAgc3Bpbl9sb2NrX2lu
aXQoJmtmZF9tZW1fbGltaXQubWVtX2xpbWl0X2xvY2spOwo+Pj4gLSAgICAga2ZkX21lbV9saW1p
dC5tYXhfc3lzdGVtX21lbV9saW1pdCA9IG1lbSAtIChtZW0gPj4gNCk7Cj4+PiArICAgICBpZiAo
bm9fc3lzdGVtX21lbV9saW1pdCkKPj4+ICsgICAgICAgICAgICAga2ZkX21lbV9saW1pdC5tYXhf
c3lzdGVtX21lbV9saW1pdCA9IFU2NF9NQVg7Cj4+PiArICAgICBlbHNlCj4+PiArICAgICAgICAg
ICAgIGtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQgPSBtZW0gLSAobWVtID4+IDQp
Owo+Pj4gICAgICAga2ZkX21lbV9saW1pdC5tYXhfdHRtX21lbV9saW1pdCA9IChtZW0gPj4gMSkg
LSAobWVtID4+IDMpOwo+Pj4gICAgICAgcHJfZGVidWcoIktlcm5lbCBtZW1vcnkgbGltaXQgJWxs
dU0sIFRUTSBsaW1pdCAlbGx1TVxuIiwKPj4+ICAgICAgICAgICAgICAgKGtmZF9tZW1fbGltaXQu
bWF4X3N5c3RlbV9tZW1fbGltaXQgPj4gMjApLAo+Pj4gQEAgLTE0OCw2ICsxNTEsMTAgQEAgc3Rh
dGljIGludCBhbWRncHVfYW1ka2ZkX3Jlc2VydmVfbWVtX2xpbWl0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+Pj4KPj4+ICAgICAgIHNwaW5fbG9jaygma2ZkX21lbV9saW1pdC5tZW1fbGlt
aXRfbG9jayk7Cj4+Pgo+Pj4gKyAgICAgaWYgKGtmZF9tZW1fbGltaXQuc3lzdGVtX21lbV91c2Vk
ICsgc3lzdGVtX21lbV9uZWVkZWQgPgo+Pj4gKyAgICAgICAgIGtmZF9tZW1fbGltaXQubWF4X3N5
c3RlbV9tZW1fbGltaXQpCj4+PiArICAgICAgICAgICAgIHByX2RlYnVnKCJTZXQgbm9fc3lzdGVt
X21lbV9saW1pdCBpZiB1c2luZyBzaGFyZWQgbWVtb3J5XG4iKTsKPj4+ICsKPj4+ICAgICAgIGlm
ICgoa2ZkX21lbV9saW1pdC5zeXN0ZW1fbWVtX3VzZWQgKyBzeXN0ZW1fbWVtX25lZWRlZCA+Cj4+
PiAgICAgICAgICAgIGtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQpIHx8Cj4+PiAg
ICAgICAgICAgKGtmZF9tZW1fbGltaXQudHRtX21lbV91c2VkICsgdHRtX21lbV9uZWVkZWQgPgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+Pj4gaW5kZXggNjI5MWY1
ZjBkMjIzLi5lOWFjZDBhOWYzMjcgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYwo+Pj4gQEAgLTcxNSw2ICs3MTUsMTUgQEAgTU9EVUxFX1BBUk1fREVTQyhx
dWV1ZV9wcmVlbXB0aW9uX3RpbWVvdXRfbXMsICJxdWV1ZSBwcmVlbXB0aW9uIHRpbWVvdXQgaW4g
bXMgKDEKPj4+ICBib29sIGRlYnVnX2V2aWN0aW9uczsKPj4+ICBtb2R1bGVfcGFyYW0oZGVidWdf
ZXZpY3Rpb25zLCBib29sLCAwNjQ0KTsKPj4+ICBNT0RVTEVfUEFSTV9ERVNDKGRlYnVnX2V2aWN0
aW9ucywgImVuYWJsZSBldmljdGlvbiBkZWJ1ZyBtZXNzYWdlcyAoZmFsc2UgPSBkZWZhdWx0KSIp
Owo+Pj4gKwo+Pj4gKy8qKgo+Pj4gKyAqIERPQzogbm9fc3lzdGVtX21lbV9saW1pdChib29sKQo+
Pj4gKyAqIERpc2FibGUgc3lzdGVtIG1lbW9yeSBsaW1pdCwgdG8gc3VwcG9ydCBtdWx0aXBsZSBw
cm9jZXNzIHNoYXJlZCBtZW1vcnkKPj4+ICsgKi8KPj4+ICtib29sIG5vX3N5c3RlbV9tZW1fbGlt
aXQ7Cj4+PiArbW9kdWxlX3BhcmFtKG5vX3N5c3RlbV9tZW1fbGltaXQsIGJvb2wsIDA2NDQpOwo+
PiBUaGUgcGVybWlzc2lvbnMgc3VnZ2VzdCB0aGF0IHRoaXMgcGFyYW1ldGVyIGlzIHdyaXRhYmxl
IGF0IHJ1bnRpbWUgdXNpbmcKPj4gc3lzZnMuIEhvd2V2ZXIsIHRoZSBwYXJhbWV0ZXIgaXMgb25s
eSByZWFkIG9uY2UgZHVyaW5nIG1vZHVsZSBpbml0LiBTbwo+PiBhbnkgcnVudGltZSBjaGFuZ2Vz
IHRvIHRoaXMgcGFyYW1ldGVyIHdpbGwgbm90IHRha2UgZWZmZWN0Lgo+Pgo+PiBZb3UgY2FuIGZp
eCB0aGlzIGluIHR3byB3YXlzOgo+Pgo+PiAgMS4gTWFrZSB0aGUgcGFyYW1ldGVyIHJlYWQgb25s
eQo+PiAgMi4gQ2hhbmdlIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBhbWRncHVfYW1ka2ZkX3Jlc2Vy
dmVfbWVtX2xpbWl0IHRvCj4+ICAgICBjaGVjayB0aGUgcGFyYW1ldGVyIGV2ZXJ5IHRpbWUgYW5k
IG9ubHkgYXBwbHkgdGhlIHN5c3RlbSBtZW1vcnkKPj4gICAgIGxpbWl0IGNoZWNrIGlmIG5lY2Vz
c2FyeQo+Pgo+PiBJIHRoaW5rIHRoZSBzZWNvbmQgb3B0aW9uIGlzIHByZWZlcmFibGUsIGJlY2F1
c2UgaXQgYWxsb3dzIHVzZXIgdG8KPj4gZXhwZXJpbWVudCB3aXRoIHRoaXMgd2l0aG91dCByZWJv
b3RpbmcuCj4gQWdyZWVkLiAgSWYgd2UgZ28gd2l0aCB0aGF0IGFwcHJvYWNoLCBtYXliZSBqdXN0
IGRyb3AgdGhlIG1vZHVsZQo+IHBhcmFtZXRlciBhbHRvZ2V0aGVyIGFuZCBqdXN0IGxldCB0aGUg
dXNlciBzZXQgaXQgbWFudWFsbHkgcGVyIGRldmljZQo+IGF0IHJ1bnRpbWUuCgpUaGUgS0ZEIHN5
c3RlbSBtZW1vcnkgbGltaXQgaXMgZ2xvYmFsLiBUaGVyZSBpcyBubyB1c2VmdWwgd2F5IHRvIGFw
cGx5CnRoaXMgbGltaXQgcGVyIGRldmljZS4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IEFsZXgK
Pgo+PiBSZWdhcmRzLAo+PiAgIEZlbGl4Cj4+Cj4+Cj4+PiArTU9EVUxFX1BBUk1fREVTQyhub19z
eXN0ZW1fbWVtX2xpbWl0LCAiZGlzYWJsZSBzeXN0ZW0gbWVtb3J5IGxpbWl0IChmYWxzZSA9IGRl
ZmF1bHQpIik7Cj4+PiArCj4+PiAgI2VuZGlmCj4+Pgo+Pj4gIC8qKgo+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
