Return-Path: <SRS0=m9pB=DM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2625EC4363A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 14:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C6620776
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 14:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gb+DxD0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C6620776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DF889DE6;
	Mon,  5 Oct 2020 14:43:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AB089DE6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2020 14:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A31hV2N07mBPamEMHfPV9SVE7QjqfVuy4Tqn7dHJNbF3lChxluKfWbRnd0D35237ToWrZeFCAVw3d4x3OK5TvtIeFXdVxteG9f9s47fVxfOcKyjsqOBfu+Kh4YhuVa+FHzSCmCNjvflOv9ALfkY86Nas+HLxvazu39AELDtqMgY/QLD9gT23o9dqjYT/IbxwYVYDFf9x0aUbibV1r3uTv/yZ04pG6yiUQdZ+Xo8/oySKfZeE6B0JYhsvWF9kfvUpHJa+ie19rrSgwJ8K9pw2PH1jH5AqUu6+uhc9I1tuwn9FDrqPfuty29X14rz2eQZuZvcPHpNZ+OAlSENOyj3FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oUV+iMQ77z0ANayzREeGOOSwS5OrzFkUPnGP1TAc80=;
 b=aNvnkcOCA12nDrHoOh789pWNOi6J4PqMMY80wCycZQhAwjxGOJvHEpW0oxWBBYZNl5Aipp51UFoJ4GeaMwLzTpokiTwMxLgvSAYvuQh1qM2J2VIyWLTIqAhnDsiPA4cLIMWDMjt8/yAiO4r/cOVxJ0r7Pj1c/MqvdVgfXs/WIO7cBEkMHc0HvMb/PlcDGYd7qLoYNE2YDzsd8zJKx9e12Inu24FcGPUqqSb2ocsXL6sCzNqsMTPbPWJMPr0dyO/kZiMpa/SYYOOGfbzxMLzHYO2jfnxjF/ebDUdd/824ZPQxc99zNlpUVUfaOlxEbYR/scjimPZnbh3EMdClZhODNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oUV+iMQ77z0ANayzREeGOOSwS5OrzFkUPnGP1TAc80=;
 b=Gb+DxD0pRJK+7BiartJKPyUaRbIz/ZRZFxMphbLuIXwOn9k9l5BrFpELVW1uQiaQUDAwrDtItrI87zld9JZu4Y2dw4f1TtU+B6ItvGoe5eO21j7Oxl20tfmaeQU4d4kuN0SmJGJk9P8yGvnMYbsk+wLKrMGhUMEIe8mdZ3ilpe8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3903.namprd12.prod.outlook.com (2603:10b6:208:15a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Mon, 5 Oct
 2020 14:43:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 14:43:19 +0000
Subject: Re: [PATCH] drm/amdgpu: align frag_end to covered address space
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201005144059.14765-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <29f9c9a0-4cb0-0cec-1345-84d3305f12b8@amd.com>
Date: Mon, 5 Oct 2020 16:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201005144059.14765-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0016.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0016.eurprd02.prod.outlook.com (2603:10a6:208:3e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36 via Frontend Transport; Mon, 5 Oct 2020 14:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7373ebc-e651-4192-5915-08d8693d0034
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3903CE795AB6A5169BFD424E830C0@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRk+kTEWCj4hzb4IL9s2UHjE+K9uTWpElW+xlfDHjG96en6Yose1D0jPSn3BaQOktrCQKPvXvqdYzQwIRpeXyP0QLqB5CL/Wtb0ur0Uu4wzbU97Y2ohE9Id8fQ/iivqibQHsfqI142pCkgWzElbaf1jgDWg52aes1hcvos1GNSmGk2wo24ttG+Gv9wpjbXZ0jrPMhT7OmdJGx1yBU/KCQapmwcKfiCyAGCERKxurxvr1ncvhhLfB1NPyLUT7lEKKCcf9urLx/X4ZTpTInZ7KN99y52MeH9Quo5qaQcHoIhwmELIauQHYqguF9Nzw7lMvlxZciqSdhrZVLPK3MRHvK7ziQmMB7ntlDJLQZU+KEwZYvytgv4K8Mfcmy9ydeAYj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(478600001)(186003)(16526019)(52116002)(2616005)(6486002)(66574015)(83380400001)(36756003)(8676002)(8936002)(31686004)(316002)(31696002)(5660300002)(66946007)(66476007)(66556008)(6666004)(86362001)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IYg6KmH/9wR/0wGkc2JSaPSNJ0HiMg5TVZUTeI1I7osh0e5MPgizVfbmajQP4kLNphVWKsqh5lt6aiRnM7yC2HHaRxT+NnviMlg0uQtAnuQIcYoDoxsq1NwsA4b5VNIeFx0qcG5vUpB/7oUnB+Ya2eSK4KimggkB3uUnJi+koiSFr9/lMuydqzS99XquQPD0e9k9eB6IJMbYi6vDpg7Dv+V+cn/WLDq1hMDCv8Odx1gD+T7tZyYcD8iCulnNMo8u/NPzfGqcWMtytUgqg0VRQVv0gBSF3mHLBXoZqrpLX97TqfgglMXJg8Ql0alk2ChSk9+kTAo5TjVgl25XrIqJodgxXiVG+a02npqxilsfe5PsBtJIKFLNFKy1BPturxUZBrBVc7hVGN434lvQO3R5d0qANW6xqkAJNP8xjdC3ewgrjprhtHK35gv6GXAYXMp+eOm43NL13Trmda0DD0fgo2C60Rwj9E8Ow3/bNNihGodfceUrWwhFZw8NIo5+sC2HO1+kNy51qy3+RISobt0D+saQwFmME+NuhrkQ25sLsysURJ+uJE/4GIAy/PTR3uUbCkAIy2jwAYu+vLyVvmDA8r8fAVedsBgE81Xo5T7hPlGsjOgcZ3dEkEQ6GVbYdWxMJM3AHjiKEuVewe0V3GCkjWd/Bwg3kGcbFpzLOx181JfgFIdMr85CWNHzT514f+WuprsgaQZDqyIiHvICiUHDRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7373ebc-e651-4192-5915-08d8693d0034
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 14:43:19.2446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXS1hQ+nlMsXjEKhPrFxVT20pUXsY967QB59SihRE1RKTb1fNCZ+UOQxK3//umfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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

QW0gMDUuMTAuMjAgdW0gMTY6NDAgc2NocmllYiBBbGV4IFNpZXJyYToKPiBhbGlnbiBmcmFnX2Vu
ZCB0byB0aGUgbmV4dCBwZCB3aGVuIHRoZXJlIGFyZSBubwo+IHBhZ2UgdGFibGUgZW50cmllcyBv
biB0aGUgY3VycmVudCBwZGUuCgpNYXliZSBhZGQgc29tZXRoaW5nIGxpa2UgIlRoaXMgZml4ZXMg
aW52YWxpZGF0aW9uIG9mIGxhcmdlciBhZGRyZXNzIApzcGFjZSBhcmVhcyB3aGVyZSBzb21lIHBh
Z2UgdGFibGVzIGFyZSBhbGxvY2F0ZWQgYW5kIG90aGVyIGFyZW4ndCIuCgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2l0aCB0aGF0IGRv
bmUgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBiNDE1MTdkMGYwMGMu
LjNjZDk0OWFhZDUwMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4gQEAgLTE1MDIsNiArMTUwMiw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVz
KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+ICAgCj4gICAJCQlwdCA9
IGN1cnNvci5lbnRyeS0+YmFzZS5ibzsKPiAgIAkJCXNoaWZ0ID0gcGFyZW50X3NoaWZ0Owo+ICsJ
CQlmcmFnX2VuZCA9IG1heChmcmFnX2VuZCwgQUxJR04oZnJhZ19zdGFydCArIDEsCj4gKwkJCQkg
ICAxVUxMIDw8IHNoaWZ0KSk7Cj4gICAJCX0KPiAgIAo+ICAgCQkvKiBMb29rcyBnb29kIHNvIGZh
ciwgY2FsY3VsYXRlIHBhcmFtZXRlcnMgZm9yIHRoZSB1cGRhdGUgKi8KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
