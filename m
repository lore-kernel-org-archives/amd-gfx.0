Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21BFC18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 12:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CF320663
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 12:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R9UyPy3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CF320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB596E40B;
	Mon, 16 Mar 2020 12:05:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208CC6E40B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvJBd+mmkw668cpeEn4FNZZSPenSMSmB9dLRQrMqrJ9vAu8uEk4NgxkoJ8lrpJ6Ee+8BhGi2OI6isowI2cB7ilTJbKYhPwh0n3l59F4Db8Vd0VbFc/MDFzUnRgCGDIFq9pe5ngS6hDnLHj9DK7sKZFotky3VSsH3Yzpl3By/i5mzPOM2dGPFbxv1to5vCGJDQB4Lyje3ZyqWXAMuqCwkOziUmXcQQ/DRBQ4tK3sKRIrcD6FHp37nS4hkQJnUavH34Z/Pvi3YxkTjH6e+A8AuR4gDZSWqaXbqQiY6il9fyd+PkRxxoAc3lGFwOcBJxZPg+WgYlOJhi//v9XfChnH56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgaAfns3IcHMiLXsspLrmiZakQ5CaUUiNpIszLRwCUI=;
 b=CMQEqUuS3BbLeHQaCTPLuG5/11vbY4cR1xK6X7tZ9MHguhyBydWFwLAGzkHuAx664qVQnd4uxitIddDxIoTQC2TeGnZTY6GNUWbDzpNkFciJU5ensnCshivwjv/v6QsTkzqbqizzX/h/Whc607xI4aq3McBZ+pnVyQGTqbmMitpF8FWPCuA66nTnvQyTZ6rbhDCqSiv4AOSOF4YoHBdP11qvanktLsIDCH1mHqgwv55BLr9fCw1f/0d+tzW9tERiUk6nc/pIJxO62/xH7eq3ZHt89a5pj4E5E+PRDNqDriiZepnII49dK5oAEVf+1dN6zBw9SNeu+kikxU1qUhwWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgaAfns3IcHMiLXsspLrmiZakQ5CaUUiNpIszLRwCUI=;
 b=R9UyPy3iFUrHYgdkie4hhNbFtdX5TGIq8dM5Hk31UuZFCv6X6j+aBPo4HOKpefhMtUgiEyh1nLpR0FGZ/MJ0QSbbHot1qFc4grClen2SYhIy4ZCXNU7lA4nNiJkgvmG3HIxK7yeORK5OE15DVpzqVklps33WjIyQhE/a7eTCeC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 12:05:12 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.023; Mon, 16 Mar 2020
 12:05:11 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5] drm_amdgpu: Add job fence to resv conditionally
Date: Mon, 16 Mar 2020 20:04:46 +0800
Message-Id: <20200316120446.13607-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0181.apcprd02.prod.outlook.com (2603:1096:201:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 12:05:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97ff1132-a019-4415-40ad-08d7c9a2475c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:|SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB268815536DA1773D8C43F52787F90@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:309;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(66574012)(5660300002)(1076003)(4326008)(36756003)(66556008)(66946007)(7696005)(52116002)(6916009)(66476007)(86362001)(81156014)(8676002)(81166006)(6486002)(2906002)(6666004)(316002)(8936002)(2616005)(956004)(26005)(54906003)(478600001)(16526019)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2688;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1Am8DQobp2Xz6Gwk3CsdlVoW0nN/RAdipQ36J5+Bo7amNhH1OI9HG7je3RHqQIieYrZqDvWDMUQDdpSUnC0LcoxznYv5NLbqRu40v8i+FjhpguAV7hYQsYXrqf4sHwEb+3jUYbqewjTJZU5lHMOIJfS2oyb38YAEiEd1O9lqjVc6P3yrI4Y44ooiEf304yTGxVUZWaJ6BJqz95w664rCUX+DxaqHk/5sfJWMhpo4nmdNpvSuRtYw8dW+m8qbG8SAyWfnUdr3CCVksEvuruV+BQsfKG35lX1oInk3YLmb2bP+ntiIsBTyBNYNYFqVuADBZLVzENpMJARBxsrIyRW7y/5h7gQaAMXf4l+GVENfUW8lOfLDdTxxsUzGpthU70ecjLY4UpotAvWJIouee5qINK/NXh0jC8HS2HGJtU2Pkuv7aLDHYhrOFQwj2b7CTVz
X-MS-Exchange-AntiSpam-MessageData: KM3p3sCYwy1USvVB74mZwFryokM/M6Rucry3mDBzf3RQoMtn3jEjFQYNEFKadllVTfiSjJOCEN3dj0oS/IjYS0TWgHL0OlD4oe1agbUU/Q/+znToOIwzlJ9KYvFjXLnNL5TPpz2/boyGeee/bggRXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ff1132-a019-4415-40ad-08d7c9a2475c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 12:05:11.7886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agYNY/TkByRLz6VbRQ3Fw1q0HWqKQsjUu1GuFqtzn/Xq8xYtp4iCUdHoZqr00ajH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Yintian.Tao@amd.com,
 xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sm9iIGZlbmNlIG9uIHBhZ2UgdGFibGUgc2hvdWxkIGJlIGEgc2hhcmVkIG9uZSwgc28gYWRkIGl0
IHRvIHRoZSByb290CnBhZ2UgdGFsYmUgYm8gcmVzdi4KbGFzdF9kZWxheWVkIGZpZWxkIGlzIG5v
dCBuZWVkZWQgYW55bW9yZS4gc28gcmVtb3ZlIGl0LgoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpT
dWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
U2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgotLS0KY2hhbmdl
IGZyb20gdjQ6CnJlbW92ZSBsYXN0X2RlbGF5ZWQgZmlsZWQuCgpjaGFuZ2UgZnJvbSB2MzoKdXNl
IHZtIHRvIGdldCByb290IGJvIHJlc3YuCgpjaGFuZ2UgZnJvbSB2MjoKdXNlIHRoZSBjb3JyZWN0
IHBhZ2UgdGFibGUgYm8gcmVzdgoKY2hhbmdlIGZyb20gdjE6CmZpeCByZWJhc2UgaXNzdWUuCi0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgICB8IDE2ICsrLS0t
LS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oICAgICAg
fCAgMSAtCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jIHwgMTAg
KysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggNzMzOTg4MzEx
OTZmLi45ZTFiYWEzNjBlNmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
CkBAIC0xNjA4LDkgKzE2MDgsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAogCQlpZiAoIWRtYV9mZW5jZV9pc19z
aWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQogCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5s
YXN0X2RpcmVjdCwgdHJ1ZSk7Ci0KLQkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxh
c3RfZGVsYXllZCkpCi0JCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwg
dHJ1ZSk7CiAJfQogCiAJciA9IHZtLT51cGRhdGVfZnVuY3MtPnByZXBhcmUoJnBhcmFtcywgcmVz
diwgc3luY19tb2RlKTsKQEAgLTI1OTIsOCArMjU4OSw3IEBAIGJvb2wgYW1kZ3B1X3ZtX2V2aWN0
YWJsZShzdHJ1Y3QgYW1kZ3B1X2JvICpibykKIAkJcmV0dXJuIGZhbHNlOwogCiAJLyogRG9uJ3Qg
ZXZpY3QgVk0gcGFnZSB0YWJsZXMgd2hpbGUgdGhleSBhcmUgdXBkYXRlZCAqLwotCWlmICghZG1h
X2ZlbmNlX2lzX3NpZ25hbGVkKGJvX2Jhc2UtPnZtLT5sYXN0X2RpcmVjdCkgfHwKLQkgICAgIWRt
YV9mZW5jZV9pc19zaWduYWxlZChib19iYXNlLT52bS0+bGFzdF9kZWxheWVkKSkgeworCWlmICgh
ZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGJvX2Jhc2UtPnZtLT5sYXN0X2RpcmVjdCkpIHsKIAkJYW1k
Z3B1X3ZtX2V2aWN0aW9uX3VubG9jayhib19iYXNlLT52bSk7CiAJCXJldHVybiBmYWxzZTsKIAl9
CkBAIC0yNzcwLDExICsyNzY2LDcgQEAgbG9uZyBhbWRncHVfdm1fd2FpdF9pZGxlKHN0cnVjdCBh
bWRncHVfdm0gKnZtLCBsb25nIHRpbWVvdXQpCiAJaWYgKHRpbWVvdXQgPD0gMCkKIAkJcmV0dXJu
IHRpbWVvdXQ7CiAKLQl0aW1lb3V0ID0gZG1hX2ZlbmNlX3dhaXRfdGltZW91dCh2bS0+bGFzdF9k
aXJlY3QsIHRydWUsIHRpbWVvdXQpOwotCWlmICh0aW1lb3V0IDw9IDApCi0JCXJldHVybiB0aW1l
b3V0OwotCi0JcmV0dXJuIGRtYV9mZW5jZV93YWl0X3RpbWVvdXQodm0tPmxhc3RfZGVsYXllZCwg
dHJ1ZSwgdGltZW91dCk7CisJcmV0dXJuIGRtYV9mZW5jZV93YWl0X3RpbWVvdXQodm0tPmxhc3Rf
ZGlyZWN0LCB0cnVlLCB0aW1lb3V0KTsKIH0KIAogLyoqCkBAIC0yODQ3LDcgKzI4MzksNiBAQCBp
bnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRn
cHVfdm0gKnZtLAogCQl2bS0+dXBkYXRlX2Z1bmNzID0gJmFtZGdwdV92bV9zZG1hX2Z1bmNzOwog
CXZtLT5sYXN0X3VwZGF0ZSA9IE5VTEw7CiAJdm0tPmxhc3RfZGlyZWN0ID0gZG1hX2ZlbmNlX2dl
dF9zdHViKCk7Ci0Jdm0tPmxhc3RfZGVsYXllZCA9IGRtYV9mZW5jZV9nZXRfc3R1YigpOwogCiAJ
bXV0ZXhfaW5pdCgmdm0tPmV2aWN0aW9uX2xvY2spOwogCXZtLT5ldmljdGluZyA9IGZhbHNlOwpA
QCAtMjkwMiw3ICsyODkzLDYgQEAgaW50IGFtZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKIAogZXJyb3JfZnJlZV9kZWxheWVkOgog
CWRtYV9mZW5jZV9wdXQodm0tPmxhc3RfZGlyZWN0KTsKLQlkbWFfZmVuY2VfcHV0KHZtLT5sYXN0
X2RlbGF5ZWQpOwogCWRybV9zY2hlZF9lbnRpdHlfZGVzdHJveSgmdm0tPmRlbGF5ZWQpOwogCiBl
cnJvcl9mcmVlX2RpcmVjdDoKQEAgLTMxMDUsOCArMzA5NSw2IEBAIHZvaWQgYW1kZ3B1X3ZtX2Zp
bmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQogCiAJ
ZG1hX2ZlbmNlX3dhaXQodm0tPmxhc3RfZGlyZWN0LCBmYWxzZSk7CiAJZG1hX2ZlbmNlX3B1dCh2
bS0+bGFzdF9kaXJlY3QpOwotCWRtYV9mZW5jZV93YWl0KHZtLT5sYXN0X2RlbGF5ZWQsIGZhbHNl
KTsKLQlkbWFfZmVuY2VfcHV0KHZtLT5sYXN0X2RlbGF5ZWQpOwogCiAJbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKG1hcHBpbmcsIHRtcCwgJnZtLT5mcmVlZCwgbGlzdCkgewogCQlpZiAobWFwcGlu
Zy0+ZmxhZ3MgJiBBTURHUFVfUFRFX1BSVCAmJiBwcnRfZmluaV9uZWVkZWQpIHsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKaW5kZXggYjU3MDVmY2ZjOTM1Li5iNTJlZmM1OTEx
NjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0yNzksNyArMjc5
LDYgQEAgc3RydWN0IGFtZGdwdV92bSB7CiAKIAkvKiBMYXN0IHN1Ym1pc3Npb24gdG8gdGhlIHNj
aGVkdWxlciBlbnRpdGllcyAqLwogCXN0cnVjdCBkbWFfZmVuY2UJKmxhc3RfZGlyZWN0OwotCXN0
cnVjdCBkbWFfZmVuY2UJKmxhc3RfZGVsYXllZDsKIAogCXVuc2lnbmVkIGludAkJcGFzaWQ7CiAJ
LyogZGVkaWNhdGVkIHRvIHZtICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm1fc2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtX3NkbWEuYwppbmRleCA0Y2M3ODgxZjQzOGMuLjE1YmIzMGRmOWFlMSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCkBAIC0xMDQsMTIgKzEwNCwxMiBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV9zZG1hX2NvbW1pdChzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0
ZV9wYXJhbXMgKnAsCiAJaWYgKHIpCiAJCWdvdG8gZXJyb3I7CiAKLQl0bXAgPSBkbWFfZmVuY2Vf
Z2V0KGYpOwotCWlmIChwLT5kaXJlY3QpCisJaWYgKHAtPmRpcmVjdCkgeworCQl0bXAgPSBkbWFf
ZmVuY2VfZ2V0KGYpOwogCQlzd2FwKHAtPnZtLT5sYXN0X2RpcmVjdCwgdG1wKTsKLQllbHNlCi0J
CXN3YXAocC0+dm0tPmxhc3RfZGVsYXllZCwgdG1wKTsKLQlkbWFfZmVuY2VfcHV0KHRtcCk7CisJ
CWRtYV9mZW5jZV9wdXQodG1wKTsKKwl9IGVsc2UKKwkJZG1hX3Jlc3ZfYWRkX3NoYXJlZF9mZW5j
ZShwLT52bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2LCBmKTsKIAogCWlmIChmZW5jZSAm
JiAhcC0+ZGlyZWN0KQogCQlzd2FwKCpmZW5jZSwgZik7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
