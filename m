Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F478C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57402074D
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qDC29lGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57402074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E83589FFD;
	Mon,  6 Jul 2020 10:44:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101086E03B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 10:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQM/Gwu8Jl/URxidWGHCmwKsjxUpBZd2VpuKvDN7gQqfMgVtL3IXPAM8ermNe50H8WQ8ZJaE2froZ/knnkAS89YmH8JGEMz9Rw5LH4FIQ7dVysjvYr+FbvQoc5HHt9XGFqvgh69mjHxwAUQQCYsTfxGN5g9fLAQ9H+9Ll0No3cBnEiVy0j4+02zmwAzsLnsz+kC0fzFkKvqc+6g5saXE/udIeTOM2f2PQm7D1RfsWkMKJsjfXtlfqe40xW6o6QqE4X/gmyouobt28vxnW1qeaut1py6VsfiTcYFq5gClEKeYGLabfmArrIPiGjDZ1f4LG5QYT8+FDjtfwd8T4OQ4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp//mvE+0MtLx2K/OyxexdrkuZxjy7velxW/MWL7YC4=;
 b=EAikJ8W2CIQX6xvnNT6e3c0gMlXlTi7ful60nzCN7NJ0Jo5mwWL3Llv/8UTme0vTpgxpOgfg5ut9N1SmRB+rnzeMaAOdn8h/OWAaMp4I16fO0HmheDPGO4foSPN6ygwfnGvn0o6PTQ4teSywdlmHKFwGHzZ0PbtklqORJ3XpbxPhXUHOKbi8ofIVX5uSc1DUlK04HYL9f3uazE53eNMt80f58fwU7msG0Q4/gk+zFAgcaXjCu3iaGtTbGaHQF4G4NLqaj6DNEtwt88m6cbl5qLXLHoD9qAC13FMKK3pSmTUqvB5jbqq/RHNqSVioTQmOLTsVRK3OTmrRzFQcIVsBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp//mvE+0MtLx2K/OyxexdrkuZxjy7velxW/MWL7YC4=;
 b=qDC29lGXBKmiuQ3xAoDHN7pCHos/VokofvbnmDw/85aj5X03NpPdciVtBZk5nGNWxtxZdwXXKcUxd/nsds7uN+r9aKpGfKjsDob/tl6lgKpjCTyezCEgJhxqxEWG8sYsMshb3AB60tjD6fS+/TqNRbxB3kMIOCxQh32hPD+Yhck=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3695.namprd12.prod.outlook.com (2603:10b6:208:15a::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Mon, 6 Jul
 2020 10:39:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 10:39:39 +0000
Subject: Re: [PATCH 00/12] drm/amdgpu: add register distance
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200706050509.714975-1-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a56c76d4-71bc-3a70-c8bc-5584104f6963@amd.com>
Date: Mon, 6 Jul 2020 12:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:208:d2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 10:39:37 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aac70556-8869-4a87-5e86-08d82198e1e4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3695C2CF091EA6545B1AC5D483690@MN2PR12MB3695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdqjJKRpvI+bDrl0hGn3pGNrwooSRfacplBrKi+8I/JeUr9oenHzrASPlnEuv3z6EQzwDnU0JZpa8S2BXyvl7nP+Fehk0fgeyzLySyDglivA7MMjdPOPjHbff6AY4w5wUUvP17tLEHRjuh6Vn5w+LA5VcBPBocXqsqFp+awkTk7G6qFQi4wXfVkz7TnaeouNn8pT/4LkFXfjwiDaAKxLbKiqYW1gv/2lGSJrmP6yJNUKgHeHYQZdkTLFw4fVeA8h7eDwnLw/Ko+2cYxehbgnhpFMSshSoC2woZbgCo73+xplGkfQdmKhNS9cYyaICMBxmri8BrrSMf9Dm2ISCzj/udKo4sM80lVXv/NenODcWbG3+QVbWIXP8NgDcjKAn5Sf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(8936002)(31696002)(186003)(478600001)(66946007)(52116002)(16526019)(66476007)(66556008)(31686004)(4326008)(2616005)(86362001)(316002)(54906003)(6486002)(36756003)(83380400001)(8676002)(6666004)(2906002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mMWc4TTFvuVzhqq+/B3ilX5B+tuu5JMr9+8prL1EA4V6dpJQZUWeuQ5oiHJff5GSWkhLY0kkQ9O5kB9XTXr3Yia6ffkGpYYVlb0dabi3aSeCXpnISQwLGZGGyQVjjeMyOwH07fm/1lCzvr7y821QS7/VXszSwsITjP6BmxlOI87uulTNozq+WEoXRVIJVUM7zD/PXhEQAmSpnrHEjYIq1WAHU6sz20M+QDPP0E7LbZkpyos+DAhzdJ6Zh91bnmYiThxm0IBWv+gl/TB1dcJ+ffAW2CjRjbS1wuSE6ng6Xyk3SSCGGGuOeU8GbTUzz05BeBD6fKu9XQSw01AGpVwEEnQObBc0axoqyuVpxsmY3UiMKlH/3dz3y+p3ZtPJMMGa7NMkUaeiIszrdHx2ZeGQq2j44EhgJvX1e09+k1PTcCC/CzLMhIPdBhfSya0w5A0RELsqePxAQtw+wh98yYXTLyL19zN6atQlQK6vtXyOS7s3kMVTUwD+MauIq7+AJam3wpIGvuHBCC3tsghqGcCKzZzFbGzqCuEYvxiye2eL8VyDrjO0o3YWnpIGIAB73kF/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac70556-8869-4a87-5e86-08d82198e1e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 10:39:38.9645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGpUN0BvQuLG3LZfPqJoHRYZDnJsvHsJNZMTX72mEcDcFIEmiB7wRlQunQcHxPn6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3695
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 AnZhong Huang <AnZhong.Huang@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDcuMjAgdW0gMDc6MDQgc2NocmllYiBIdWFuZyBSdWk6Cj4gRHVyaW5nIElQIGJsb2Nr
IHVwZGF0ZXMgaW4gc29tZSBhc2ljLCB0aGUgcmVnaXN0ZXIgZGlzdHJpYnV0aW9uIHBhdHRlcm4g
b2YKPiBjb250ZXh0IGRvbWFpbnMgYW5kIGludmFsaWRhdGlvbiBlbmdpbmVzIHdpbGwgYmUgY2hh
bmdlZCBpbiBnY192KioqLmggYW5kCj4gbW1odWJfdioqKi5oLiBIb3dldmVyIHRoZSByZWdpc3Rl
ciBkaXN0YW5jZXMgYXJlIGFsd2F5cyBjb25zdGFudCBpbiBvbmUgSVAgYmxvY2sKPiBiZXNpZGUg
Z2Z4aHViIGFuZCBtbWh1Yi4gU28gd2UgY2FuIGFkZCByZWdpc3RlciBkaXN0YW5jZSBtZW1iZXIg
aW4gdm1odWIKPiBzdHJ1Y3R1cmUgdG8gc3RvcmUgdGhlIHJlZ2lzdGVyIGRpc3RhbmNlIHZhbHVl
LCB0aGF0J3MgYWJsZSB0byBhdm9pZCB0aGUgaXNzdWUKPiBvZiBoYXJkY29kZSBhdCBjdXJyZW50
IGluIGZ1dHVyZSB1cGRhdGVzLgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRoZSB3aG9sZSAKc2VyaWVzLgoKPgo+IFRoYW5rcywK
PiBSYXkKPgo+IEh1YW5nIFJ1aSAoMTIpOgo+ICAgIGRybS9hbWRncHU6IGFkZCByZWdpc3RlciBk
aXN0YW5jZSBtZW1iZXJzIGludG8gdm1odWIgc3RydWN0dXJlCj4gICAgZHJtL2FtZGdwdTogdXNl
IHJlZ2lzdGVyIGRpc3RhbmNlIG1lbWJlciBpbnN0ZWFkIG9mIGhhcmRjb2RlIGluIEdNQzkKPiAg
ICBkcm0vYW1kZ3B1OiB1c2UgcmVnaXN0ZXIgZGlzdGFuY2UgbWVtYmVyIGluc3RlYWQgb2YgaGFy
ZGNvZGUgaW4gR01DMTAKPiAgICBkcm0vYW1kZ3B1OiB1c2UgcmVnaXN0ZXIgZGlzdGFuY2UgbWVt
YmVyIGluc3RlYWQgb2YgaGFyZGNvZGUgaW4KPiAgICAgIFZDTjEvSkVQRzEKPiAgICBkcm0vYW1k
Z3B1OiB1c2UgcmVnaXN0ZXIgZGlzdGFuY2UgbWVtYmVyIGluc3RlYWQgb2YgaGFyZGNvZGUgaW4K
PiAgICAgIFVWRDcvVkNFNAo+ICAgIGRybS9hbWRncHU6IHVzZSByZWdpc3RlciBkaXN0YW5jZSBt
ZW1iZXIgaW5zdGVhZCBvZiBoYXJkY29kZSBpbgo+ICAgICAgVkNOMi9KRVBHMgo+ICAgIGRybS9h
bWRncHU6IHVzZSByZWdpc3RlciBkaXN0YW5jZSBtZW1iZXIgaW5zdGVhZCBvZiBoYXJkY29kZSBp
biBnZnhodWIKPiAgICAgIHYxCj4gICAgZHJtL2FtZGdwdTogdXNlIHJlZ2lzdGVyIGRpc3RhbmNl
IG1lbWJlciBpbnN0ZWFkIG9mIGhhcmRjb2RlIGluIGdmeGh1Ygo+ICAgICAgdjIKPiAgICBkcm0v
YW1kZ3B1OiB1c2UgcmVnaXN0ZXIgZGlzdGFuY2UgbWVtYmVyIGluc3RlYWQgb2YgaGFyZGNvZGUg
aW4gZ2Z4aHViCj4gICAgICB2Mi4xCj4gICAgZHJtL2FtZGdwdTogdXNlIHJlZ2lzdGVyIGRpc3Rh
bmNlIG1lbWJlciBpbnN0ZWFkIG9mIGhhcmRjb2RlIGluIG1taHViCj4gICAgICB2MQo+ICAgIGRy
bS9hbWRncHU6IHVzZSByZWdpc3RlciBkaXN0YW5jZSBtZW1iZXIgaW5zdGVhZCBvZiBoYXJkY29k
ZSBpbiBtbWh1Ygo+ICAgICAgdjIKPiAgICBkcm0vYW1kZ3B1OiB1c2UgcmVnaXN0ZXIgZGlzdGFu
Y2UgbWVtYmVyIGluc3RlYWQgb2YgaGFyZGNvZGUgaW4gbW1odWIKPiAgICAgIHY5LjQKPgo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oICB8ICA5ICsrKysrCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jIHwgNDggKysrKysrKysrKysr
KysrKy0tLS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5j
IHwgNDcgKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeGh1Yl92Ml8xLmMgfCA0NyArKysrKysrKysrKysrKystLS0tLS0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgICB8IDQzICsrKysrKysrKysrKy0tLS0t
LS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgICB8IDM5ICsr
KysrKysrKysrKy0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjFf
MC5jICAgfCAgMiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmMg
ICB8ICAyICstCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMgIHwg
NDUgKysrKysrKysrKysrKystLS0tLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bW1odWJfdjJfMC5jICB8IDQ2ICsrKysrKysrKysrKysrKy0tLS0tLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgIHwgNDYgKysrKysrKysrKysrKysrLS0tLS0t
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMgICAgfCAgNSArKy0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92NF8wLmMgICAgfCAgMyArLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyAgICB8ICA1ICsrLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYyAgICB8ICA1ICsrLQo+ICAgMTUgZmls
ZXMgY2hhbmdlZCwgMjYwIGluc2VydGlvbnMoKyksIDEzMiBkZWxldGlvbnMoLSkKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
