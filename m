Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77FAC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 19:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C322086A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vTpzlw2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C322086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E59D6E0D2;
	Fri, 25 Sep 2020 19:37:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636B96E0D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 19:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJt0AphjDqEl30OButTbHqL3tihQ48gTxhAI8PNC97ajq4omEsQXw7rBkA7Svj1gmxxiPuvXmxbecn9FyN5qTJnlWl+Qp+OyPGDhpZ4G5F4RsldudRwsP/jJh12/rUA4v5plg4ZjsgTqg2bP0fC9Y+ptRw8GBhRSVXCeVh3hMpg0Ed/tLm+h7CIIysZeEMts18ewozx3yuX5M0lg7QYkKYI+PTUsVE8CNc5vdJ+NMoZ3HAGsEegP9kJtaGcC0XYtedST4WwOMjXRqd4+CYNCdQvrJC5Wr664TiqUoji+AKzGih4bv+D7g8kLxFg3xQH07aEfzgUlS9zpFzdZ6cqyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itlK+ilcHRQoGTEc2ZpI/gmV7kftfHggSjtkuHYdOGY=;
 b=Yit1kVEXwUkG7zsgzXqDHBB8K2P45cFVU8KiMNfGTdi7VlMs1ssAUVQV/+14SmQR574Pg2oXqBHcc3h66dqGXTPe3t9KpEbU3u6E+DViwcTxAgZBf8rFweM/wTQg90PwQB5SarloQDp4LPBuETzvBTFqdxYv6C1skLbV8Yq+xyMnyVmSOFVX8ObZwauMMY9oWEm7teQSHoim9VxzctAIuopWUtUgtIDalL7JdLAc9wXd9k7oNWcb0p/1mV17m668znCg5JcyfsB9lkG9VlYbX+RC2FO4Wnr/3N79cDDXlsF8Xuu39yXKbZs4AjKBPM/Iqm/+BQPLmWcKF6MHAjX6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itlK+ilcHRQoGTEc2ZpI/gmV7kftfHggSjtkuHYdOGY=;
 b=vTpzlw2McnNBLrYELH6989CJEboSTWW44wwb52Ye1tzIO9ziksxppk4j+bfIxMGIJ+ld6eUFuya290kQGqYM0PFXsBtxz2Ik4F6AoWvh5FllS1gH6JSnDFloM0tcV9jRbO3KIOrJWZgQvVzGF3naP5wS8Ct3a1P3xBqh48LIrYs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2520.namprd12.prod.outlook.com (2603:10b6:4:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 25 Sep
 2020 19:37:31 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 19:37:31 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a warning in amdgpu_ras.c (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925192357.1635290-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <d027b812-cb00-81f2-823c-2bdff972c538@amd.com>
Date: Fri, 25 Sep 2020 21:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200925192357.1635290-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.126.213]
X-ClientProxiedBy: AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.126.213) by
 AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 19:37:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25e0c2e9-86d4-41a0-86a8-08d8618a7164
X-MS-TrafficTypeDiagnostic: DM5PR12MB2520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2520CBED17008BA31BABFFA18B360@DM5PR12MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngRe/fMIWEQhZmyDpNM/KKOn9moHHKPKxxNsVC+nSyiDwX8jfi3POY5AxrIh7SuVmWp8uBhF+Ic2VCBIlh6JeV43axfPBS8KJduu5C/wZpf+b6kCiYyI+O5vA7WL6DAwkFB+LGGDi9dTEfVv4cQpL4QCcJdPieeXDrsvii4S0UOuCXPUG5sDZInZa3/B8EQ+1GiL+j4OobPF33+eWwSBMqq39W2+Gdr7re4Uh5U6Wv2wjDaj9VrE0SrbavYwCmzZ03ZbFtLv5yAPEG2SNVfO69pEQb2lzJnwpQZ9ippagjtc3C7xq4XM3U1UKZ6cin/KbhDa4SskpFBflcZmnTVckZRBgiDTa6Lmg/MaRp4TNv04dkFQSe3+Wkevo+pJgTMGabTZPNh+CrITltXtsH6f5G+OmjhhW0AGoCCbRd7QIYVYQx48lvI4iMRksunAgkuN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(31686004)(6486002)(478600001)(8936002)(956004)(66556008)(186003)(36756003)(4326008)(66476007)(83380400001)(316002)(2906002)(16576012)(52116002)(26005)(2616005)(66946007)(6666004)(53546011)(16526019)(5660300002)(31696002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yd4WQrfQB0Qg/xFOdmxL3k5rmXC2qDXW3ew3+27jp2cyOBDm4Lje1aojugx32O2lHjHDNEx48fsmsIObTPxkrEF75nxCNJJySZvSxfzfHIuZd2+5E0NnJTvM7bSTflyz2BLhxMLuH56mLiI1fZ6bj0FOP/VCT2nWtd4p4nB3yzLQgThlSm+257NJVk6gpxFQNeozVjr0ooAQbluL9B2A8r1vb904aA2UKNtDB4q1ZIJhxPEt37qghZRMgzjl9OEgUtEnkWTYGiCRBmHQZftwxcNL8Y3Km/QNYxxbMi/RD6Hznmrzf/AEtNWELE3pAlkVNfh+zAYf/ytQPhdtYYgba+6hEQIqx/KOJ0O1B+24Dv7UbENrx3rDGbsS4XlxgrYVSfJGEfkaWeLnLBuhq1Jc+MetmrbQg3Vjd7H53GLIx9/TM/PVBqlHGAvfX3HhN6rHwRosCQmt2q8i+e+RsvDiZnbo8Bklipyu8pEGyON0CGAbTJ5R3TDvSJFrO4GUvLTfxNJlDbaZHIlSlSS09BIprsfLvk2uD8yrX6+lzjKjq2aRqSDGkRUQJ4WghXYMYa2sJRw4Qmrx4sQrtpfafe0bHUPdUIxVWb5dWLE1Rsw3YIQIidjSuSqrUkrIG7he3NXO8EYKVUOBSdd8HU/J1itVAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e0c2e9-86d4-41a0-86a8-08d8618a7164
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:37:31.0568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGG+DbEkEgOhuMx6kReYjZ6F6oiFpZszSuJyAUKKtiGyxOWWdNFGZf8yS8TP4wNxXuJ7fnQp6NhK3183PePu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2520
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

QWNrZWQtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KCk9uIDkvMjUvMjAgOToy
MyBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYzogSW4gZnVuY3Rpb24g4oCYYW1kZ3B1X3Jhc19mc19pbml04oCZOgo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzoxMjg0OjI6IHdhcm5pbmc6IGlnbm9y
aW5nIHJldHVybiB2YWx1ZSBvZiDigJhzeXNmc19jcmVhdGVfZ3JvdXDigJksIGRlY2xhcmVkIHdp
dGggYXR0cmlidXRlIHdhcm5fdW51c2VkX3Jlc3VsdCBbLVd1bnVzZWQtcmVzdWx0XQo+ICAgMTI4
NCB8ICBzeXNmc19jcmVhdGVfZ3JvdXAoJmFkZXYtPmRldi0+a29iaiwgJmdyb3VwKTsKPiAgICAg
ICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPgo+IHYy
OiBqdXN0IHByaW50IGFuIGVycm9yIGZvciBzeXNmcyBncm91cCBjcmVhdGlvbiBmYWlsdXJlCj4K
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA1ICsr
KystCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4gaW5kZXggNDlkMTAzMzBi
ZjY0Li44YmY2YTdjMDU2YmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jCj4gQEAgLTEyNjYsNiArMTI2Niw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19mc19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQlOVUxMLAo+ICAgCQlOVUxMLAo+
ICAgCX07Cj4gKwlpbnQgcjsKPiAgIAo+ICAgCS8qIGFkZCBmZWF0dXJlcyBlbnRyeSAqLwo+ICAg
CWNvbi0+ZmVhdHVyZXNfYXR0ciA9IGRldl9hdHRyX2ZlYXR1cmVzOwo+IEBAIC0xMjgxLDcgKzEy
ODIsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAkJc3lzZnNfYmluX2F0dHJfaW5pdChiaW5fYXR0cnNbMF0pOwo+ICAgCX0K
PiAgIAo+IC0Jc3lzZnNfY3JlYXRlX2dyb3VwKCZhZGV2LT5kZXYtPmtvYmosICZncm91cCk7Cj4g
KwlyID0gc3lzZnNfY3JlYXRlX2dyb3VwKCZhZGV2LT5kZXYtPmtvYmosICZncm91cCk7Cj4gKwlp
ZiAocikKPiArCQlkZXZfZXJyKGFkZXYtPmRldiwgIkZhaWxlZCB0byBjcmVhdGUgUkFTIHN5c2Zz
IGdyb3VwISIpOwo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gICB9Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
