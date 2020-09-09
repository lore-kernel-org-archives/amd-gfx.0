Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92379C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272CA20708
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NU5pJXLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272CA20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875376ECF2;
	Wed,  9 Sep 2020 09:13:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F7F6ECF2
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 09:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEOznZH+e1BoyB4k3j10qslK7Cx7+wAgdZZrbknSsCTTy3nk6nZg1goo37QuvaEOl977WqUnHjN4Ujt5pegDWROvoZoeGCN8q2TAQGeD77Mi064+UBeoBSco10x8kG/moP+BkMlWevgZH8K+U9cmx4Ofn6qPZyxGaGX3hSUDTFBsLh0qNepuEUa61DqYwIOvQSG/eh5QRPiQ1J8/nmNCGZkYfQP3Ehz9LVbaPLZ5dt2pD7EaOwW/flibwJYw1+XdgFR19QH5Zz+Gm6vRDbP3H4XwObAX+V1FGVJ2zH4Gu7Kr0i1oKq2OS+q1FE8/RAjOct5R3MJdZ7L9N6KK+xqoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP7kewc7LCeF3oeNiKnybmOiToRmsVZcAhk3G4CPwC4=;
 b=KSFnFXQKlGYczZ34eGwcC0goUUmMehx+9LmAbVecFgOhXxKoUJ3UUq9m+jjvsNX4IVktsPJo/4I8wX6UYyiv8ybvfpR3HgSEKpdbHyT1iMv4dV1Kf0M7XCRYm6MjVcNhL6R1Iq3L/prcDoFwuOSw7DTY8o6YnypWoXKAr/iXWDvs/1tZhOnRWvFWw64sdI7sKmOy1HCF/fvPJyBnTdQEAwLQ0j38gJAn7PAwKXHPIHJPVFJ0X1vXEu7NtaRHLjUmtJLCQRou8BkPXGo5rpNYYjDQ8ws0vrdjICgzB4btln752WnF/2Qek83uVKYAcvpqAhnxGdKXrf3erYVLyOmBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP7kewc7LCeF3oeNiKnybmOiToRmsVZcAhk3G4CPwC4=;
 b=NU5pJXLEaKBnVAGGnJVBGpjh84OTkJA8FgDH+0Fqnr6KSxRJ6r814++FqIfiFIe1vFMAld7g4ocAfoLxXSwvvH7tdyK3hG76b/6UwIW2R3OdHEYRfpK7oEwzj/enyG9ibqm25DHtDYPThM9xp4ghZ9Iol1z+K2BdLMEGAwJZRaY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 09:13:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 09:13:30 +0000
Subject: Re: [PATCH] drm/amdgpu: Do gpu recovery when no job is running
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200909085604.804266-1-ChengZhe.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <073b3317-e635-99cd-1ba7-039d8810d8ce@amd.com>
Date: Wed, 9 Sep 2020 11:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200909085604.804266-1-ChengZhe.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:205:1::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:205:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.8 via Frontend Transport; Wed, 9 Sep 2020 09:13:28 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8c0b66e-a1a6-422b-540c-08d854a09de4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44708940068D35EB656BFEC583260@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUJGzCzIJWWBEzWnq6+1PABHj/1yboi0YknvpJHXDIxMBcdoaUCI3FhyfxnIjNdLbrk/ZTlx5+motykt5djCa70kvgP0j5aoSLl+LFB5nhD/Mgz7knNTdQWvNQyg/MuJM/HaJqruB/v/0aJrHpHye1iNtB429oZ3La5b09vSfFTDam/RYkSdkAbNAiHUa/An2cubAk+c5UfoPeyt0M2UF70ZFIt1AO7MyDks3MdMnTE6KMt5YzWVNbajHPWnFS7ShcBfBKwmo1z/A+FXLVHA5W0GflYvoWTDaCc1IZaXbta+NoYwupMGtxmVnBBQOBEHAyLyM9oLPSlVjdd0A2Iw6eOZAwBoyx4iu+V9ihsvDIobnNwdClwfmNNGuyiyiCNz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(366004)(54906003)(66946007)(66556008)(66476007)(6666004)(8936002)(316002)(2906002)(2616005)(36756003)(5660300002)(31696002)(16526019)(8676002)(186003)(4326008)(6486002)(31686004)(86362001)(52116002)(83380400001)(66574015)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e3x6UorU1Ao0TyvLd7wp5xaJ/aPg0hwpYMgXGyo5mviT3zCKnufIkkAh1Gu0qX2N74reOFqFbRy05VyNllFPlHy22zmgWlvKVEKubrS3xgGCKJSw+UmwPLf1LXA6aAbFttnf+rfCowvp+iPtMwQ5JxoHgJjOl9iGfXE4EecqVRqXtmPej+rYujmwMKoKcPc4tu4HsgnGHFkHsupgliLLl0jbV/Ic/YyYUvsYfm6Egg7k4MssZ9y9SEp9sv15y8yQhl6tLl5JwagYGjJzPjEpn+HhDpagjnYk77HpOFEcJDAPOE7zRPBtcMv8wqQ0ifhqCxpjiat1P/TIOW7EamDorp9O7+fPKHTvzzbbGIiCO5NGImYW+zF/x6BmgVwPMCJCVENXM1agT9hMVhASBoT1l7kPXPAgq79h67qDuclB5s3avGQZYssf/wN4H+TRL51eiDOYMC0gytiynHyuuNQCC6kuAIPuaklOuHdMVC+qXDqLVgwo9nPGHtoEEoTsRqovaV4FJtXrMf9CylS+OJKGSLFeNh2Ym3A5XgjLLA6vO189K+TPClbAZ+40pIV3um2OOpTlKZuMb8HZM8WvV5tl2pwG5R9Zd10LcyHlsj5AUsnEzP4kMWcUHyq6z5kh2zXQTC3Rk+2rgmRy2Hy+5QJTfHkey2t4QGrKvphzrbaGqXGMprtAkPQt0KFTOpnnMpqzdpTP6cO2xj17Xd0gLRAtdQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c0b66e-a1a6-422b-540c-08d854a09de4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 09:13:29.7080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jnSnKrP1u0RS5vzMhW6M8W21cF6ST9ZMdoBE54mzQUcIPtmAQlcpV56mWLvWLVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDkuMjAgdW0gMTA6NTYgc2NocmllYiBMaXUgQ2hlbmdaaGU6Cj4gSW4gZnVuY3Rpb24g
ZmxyX3dvcmssIGRvIGdwdSByZWNvdmVyeSB3aGVuIG5vIGpvYiBpcyBydW5uaW5nCj4gaW5zdGVh
ZCBvZiB3aGVuIHNvbWUgam9iIGlzIHJ1bm5pbmcuIEJlY2F1c2UgaWYgdGhlcmUgaXMgam9iCj4g
aW4gbGlzdCwgYW1kZ3B1X2pvYl90aW1lZG91dCB3aWxsIGRvIHRoZSBncHUgcmVjb3ZlcnkuCgpN
YXliZSB3cml0ZSBzb21ldGhpbmcgbGlrZSAiRml4IHRoZSBsb2dpYyBieSBpbnZlcnRpbmcgaXQi
LgoKV2l0aCB0aGF0IHRoZSBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPgo+IFNpZ25lZC1vZmYtYnk6IExpdSBDaGVuZ1poZSA8
Q2hlbmdaaGUuTGl1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV9haS5jIHwgMyArKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1
X252LmMgfCAyICstCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdw
dV9haS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwo+IGluZGV4IDlj
MDcwMTRkOWJkNi4uZjVjZTlhOWY0Y2Y1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L214Z3B1X2FpLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
eGdwdV9haS5jCj4gQEAgLTI2Miw3ICsyNjIsOCBAQCBzdGF0aWMgdm9pZCB4Z3B1X2FpX21haWxi
b3hfZmxyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCj4gICAJLyogVHJpZ2dl
ciByZWNvdmVyeSBmb3Igd29ybGQgc3dpdGNoIGZhaWx1cmUgaWYgbm8gVERSICovCj4gICAJaWYg
KGFtZGdwdV9kZXZpY2Vfc2hvdWxkX3JlY292ZXJfZ3B1KGFkZXYpCj4gLQkJJiYgKGFtZGdwdV9k
ZXZpY2VfaGFzX2pvYl9ydW5uaW5nKGFkZXYpIHx8IGFkZXYtPnNkbWFfdGltZW91dCA9PSBNQVhf
U0NIRURVTEVfVElNRU9VVCkpCj4gKwkJJiYgKCFhbWRncHVfZGV2aWNlX2hhc19qb2JfcnVubmlu
ZyhhZGV2KSB8fAo+ICsJCWFkZXYtPnNkbWFfdGltZW91dCA9PSBNQVhfU0NIRURVTEVfVElNRU9V
VCkpCj4gICAJCWFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoYWRldiwgTlVMTCk7Cj4gICB9Cj4g
ICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfbnYuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252LmMKPiBpbmRleCA5YzIzYWJmOWIx
NDAuLjY2NmVkOTljYzE0YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV9udi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfbnYu
Ywo+IEBAIC0yODMsNyArMjgzLDcgQEAgc3RhdGljIHZvaWQgeGdwdV9udl9tYWlsYm94X2Zscl93
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAo+ICAgCS8qIFRyaWdnZXIgcmVjb3Zl
cnkgZm9yIHdvcmxkIHN3aXRjaCBmYWlsdXJlIGlmIG5vIFREUiAqLwo+ICAgCWlmIChhbWRncHVf
ZGV2aWNlX3Nob3VsZF9yZWNvdmVyX2dwdShhZGV2KQo+IC0JCSYmIChhbWRncHVfZGV2aWNlX2hh
c19qb2JfcnVubmluZyhhZGV2KSB8fAo+ICsJCSYmICghYW1kZ3B1X2RldmljZV9oYXNfam9iX3J1
bm5pbmcoYWRldikgfHwKPiAgIAkJYWRldi0+c2RtYV90aW1lb3V0ID09IE1BWF9TQ0hFRFVMRV9U
SU1FT1VUIHx8Cj4gICAJCWFkZXYtPmdmeF90aW1lb3V0ID09IE1BWF9TQ0hFRFVMRV9USU1FT1VU
IHx8Cj4gICAJCWFkZXYtPmNvbXB1dGVfdGltZW91dCA9PSBNQVhfU0NIRURVTEVfVElNRU9VVCB8
fAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
