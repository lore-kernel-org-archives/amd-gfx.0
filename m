Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF5C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B60613B6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B60613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E088E6E424;
	Fri, 28 May 2021 14:09:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896D96E424
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 14:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKlKl2xgb4jgxd4uUU77oAcVvKKX16RK+zulIJTNAxri8HAQKCmJ87NJrV8NO0sjzSkHH+lP/oFDAi/YoUIHPjbxzZM3hJnHs2lzPvOW12NaeTpacWYO4SuSkw6tFPNHbuW7M60PHRLFGeBbiqT1rW27zUTCN8GQUr9h47hLwHw24EOqH2mQpo6WXQJk7CNcuDi2wa0GKqVOdnVZ3d+wq6UTtipmtBtn0fajVHOp9sv6Ih+9lZHsrFWQKwRTk/Q8Dc9X1NYnQwZ2pA4dL0a9AxKM9BLlmcPF01rKHIsf0pGKQBW35dX6OWpqWnJIYyGnPBv3/cLdE0wtw+JDp9q1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql7LFfNjfsWrz8zUoI65cdNzRsXPN+EScAPWLBHcQpI=;
 b=OWrT7mugVju7elQBNgLdXP3WCtaXoXYNbjlvU9FgTbG/D/6z5CTROIAZIr53WppyX7tuAAtisMpsPG7a0xIBegLUhwoWEQ5XyqLH2OpMMO/5c3iA1OvXH/KPH2u78FY4Dxmi0iAeBvNMvp+NSYBhq03zvkbyouXqvTdNNUuHI+H6FiW96AysECPSimEBCUycHPRmUdRVBtDCX49BRcv8IqgctuPzZDga0dSCUK/erduMlCI5KYdk0qkW5oX6Oqq9A1OFeyOMj5eNzc3bc6g9oyOLDiUu0/Y6Xz/ut5ixNHplpCVrXKc0Z0usouUwfjyO/5qybBw+vGgbahddDidNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql7LFfNjfsWrz8zUoI65cdNzRsXPN+EScAPWLBHcQpI=;
 b=4q3jXP7CegDltNOVKon32/DeXvHbZAd+VT23X6W0SchwfNGyuagUVpv6KnhZhM/J/mrso11FZPTy1J052oRWtesVhiwSj1u5ol9cWyfR2Fgf7itO9wEiJclnBvrMaSSYDkUDVL2PAGhkgn/XKbEveVmEQuObXElkSdYp7deoWUI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2579.namprd12.prod.outlook.com (2603:10b6:207:4d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 14:09:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 14:09:17 +0000
Subject: Re: [PATCH v2 6/6] drm/amdgpu: do not allocate entries separately
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210528105623.28148-1-nirmoy.das@amd.com>
 <20210528105623.28148-6-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ae7ac2b1-a819-fde7-8c03-3d8e79cd7cc8@amd.com>
Date: Fri, 28 May 2021 16:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210528105623.28148-6-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:a878:922a:f147:ebc]
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:a878:922a:f147:ebc]
 (2a02:908:1252:fb60:a878:922a:f147:ebc) by
 AM8P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21 via Frontend Transport; Fri, 28 May 2021 14:09:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6a5c6fa-592e-41e9-0f25-08d921e22e02
X-MS-TrafficTypeDiagnostic: BL0PR12MB2579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25797F3F96A955CF8321C14083229@BL0PR12MB2579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUEqNvfexJt0MQ+a+IaI3kUO/byoj5xHSRoX+nB5+4V9t0YrVqL7I/HnoQ3D1r9j9nTFCF0FT8oNm7D0mDeDejJJwwhA2UonCjtH/q+huoVSAFy1Eq9fhUsveIXdfYLlWSyKfzfTPalIaSyiyPwJxWf+MBKYSgWX8bwBTFS4sOX5yNttQK5VHaPSk0C4xxB5as8tHyMpw+fLzeK1g/nX//ONaQ57EtynYlso/meDgbkYu4zA6ctA/4dnxL8QzOchFlj1kmt1nxcWckA9aiYC7Qh/+kgeTcGmFxl7UZiiUQFZuoryudlaQXTZ0b4tMWC50GfCbnHY88fYroHSln/uH95DARoBQG89c3FlpJbQKNPd+0BwbBiFB2WEkuL+gNGP13Vz6F/urFKMHBhsqqK/W1F/tzWZyowO9fk8WxztJlVNJnB9TeiqXILPPllb5IS0/LPTqRIYV/0LXAlNz+AtcXNV7TH5yXxT3kny3saMmMtACUJaN5g+N95dXeo4XI+G15bUCL+v4U28zMQSET18QMZjiN9/bJ1Hi22gFLFHdERG0dWxOwxVrWdMca6sISnEb5WmSeoX5u0pRWI1jYgrgXATetK1Fzb/T/97N/oCuIzrDyRmp1lsJM4LDAtIe3HlXIgvbYmK1wiGNWKJRMSBgudYLJSqvNrXRm4FDGMJh4uNK+pHT3fqTnchJvSfkI0M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(66946007)(66556008)(66476007)(83380400001)(86362001)(478600001)(5660300002)(4326008)(66574015)(6666004)(2906002)(8676002)(36756003)(316002)(8936002)(31696002)(186003)(6486002)(38100700002)(31686004)(16526019)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFBUTUpaMys3bVJhYzNCcmtCUmpNOTBNRW52Skw3eUtCUjVQdm1FeVV4Z3Qx?=
 =?utf-8?B?Qk82ZDluemtFbDVmdGtvWGovaXgrelEweDhyMWNvTUdUVjdORXpvZlNEV2VB?=
 =?utf-8?B?Y3hDODFPbHlhVHlkb2VkQnhiTGNjbmtTbnlqa1pjZkxaelQrSHJXN0F5aW9X?=
 =?utf-8?B?bTNnOXc4QlJIdEpsYUVwOEpKL2owZTlGNXlBWVRUdlRHRlUwL2ZJWXhna2I3?=
 =?utf-8?B?VUlrdGNtQkJPVEhZeVdQSkZ4aXNXVWdhVTlTYXJCc3ZTcXhhRTlBeFRMVUdT?=
 =?utf-8?B?RDNHKytJZllaZ3dMNGZBL00xcVdMM0tlRUdtSkhCcEVlY1Vqb2V6MkNjVHly?=
 =?utf-8?B?OEVMalorMS81bU02RkJzR0lqRGJ6bGhTTDF5ZnZZd2F2WE1BMVM2bVkyMjdh?=
 =?utf-8?B?VWtvN2pSdVpNbjU5c0s5NnRDTUU4N3JXU2l5NDhack1IRjZCaDhkcVY1T3NC?=
 =?utf-8?B?U1kza2ZLbUo5dy9hdEk5N0pTL3Qxb3dweFdJZm5mTm5icng4WlVTUzROZG92?=
 =?utf-8?B?MEYvNVdPaUNLOGgwMzJJS1VuVjMyUnVJcnZLOW9VUmJsVUtMTTNzZlhLc0JN?=
 =?utf-8?B?c2wydjZvbEVuMWNWV2JkeDZmUkpnM3FsK1dYSklHc1RzNzRhL25QZXQycmhq?=
 =?utf-8?B?aEtMbnZxYjBRRWNkUDVDa1N5MkRvd2JuVk8xTHEyNWtkSnp2MG4zVkJqY1JO?=
 =?utf-8?B?VEJEbkxXYTNFeGF3NG5idVppaVBoL3FER3VsQTFZdXQvejBuNTRqQlJKWWRF?=
 =?utf-8?B?UlF5cVVLWVF6dWMxMit5WXNWMkU5a0QvUHFONzZBME1xQWwvbjdsbVo3K2g0?=
 =?utf-8?B?Z1MxekpGOUIyYk4xdkV2aWd3bEU4NFdDT0lNWUV0VVZ2SnEwdkpuSEg5YXhN?=
 =?utf-8?B?TVBzUWtwSytjWWZTbzJvT2lvODgwK29qdjZjb2ZUNGRxS1dJdWxUR09zQnEv?=
 =?utf-8?B?TE4xS2swU2QyYUh6anRYZE9VSDl3blA2SzZwQ0hGUGRQelVBWEJrMlA5MG9l?=
 =?utf-8?B?anV0Y3cxdzZKSk5vS2s2K0JMbU1GTlR3V1pzeUdJUVNZSjlSenEvQVEwYnow?=
 =?utf-8?B?SzJ0dklDRTZQd1hQRVRGOVlUdldpZ2dLNVJqenV3VUNtUFdDVVlwaVFDU3hX?=
 =?utf-8?B?b0RQQitraklwT3NUSTV5Uy9raFg0dEJjUVNGcUk5bnFLY05uWG1XT2Uzb2lr?=
 =?utf-8?B?Ky9zakFTT2c5ZGJqYmtmbW1neDNYR1hrVGpwS2lweUxiUGZHcXgzdzBxdDIz?=
 =?utf-8?B?TmdlYnREZGtDc2VUVHFoYUYyTVZMU2NLN1lmdGMzbmduVmQ2Q2hjc3hVVG5Y?=
 =?utf-8?B?RFBhZlI1SHlTRS9yaWVhRVFNMHZTZFl2Qi9yUkxlTng3bENXaEgxU1hPZmw4?=
 =?utf-8?B?dVNGeFlXRTIwbHhKSGdwZEQrVUo2UE4rNGlBa0tVZ1lFeHd3am9yNEdUOEJt?=
 =?utf-8?B?RW9OckNaMUR3Zkh2OHNkVXoySmVDbzVIUXRzcmJWamFETC9XcVhPcmFudzZT?=
 =?utf-8?B?a1ZSczQzdmkzWTVzbmx0em9uNUUvMk1OV0FnSE5uaVo3bW1MQ1FDaWsyUzFV?=
 =?utf-8?B?M3NoUVZ1WUx2RHpwRUlYblU3bEgvSHdvMWgyY21kT0FxZ1lFM1cvVWtvOVY4?=
 =?utf-8?B?c1VCRHoydGQxMUQxYnRRV20weFN4ZURQbE11MDJCUXh0Zm1LdG1qdnFHcjBF?=
 =?utf-8?B?S3hMK1JFSGcxTHNCV2ZFZmJjTDFnb25yWXJjZng0K3lJbTZxZ05YaTAvTzRJ?=
 =?utf-8?B?T1pQandQTVR2SmZBamVNdWdPWmFVek54Y2dTWktKU2w0OENTWVBNZFdFT1JM?=
 =?utf-8?B?ek44Rzh1aFRIQXRseVlkeUZwdG41SlpTWmFCTGE3dk9XcDlXZ3BoS24rYnhE?=
 =?utf-8?Q?2H/DyNnsfmDzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a5c6fa-592e-41e9-0f25-08d921e22e02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 14:09:16.9337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: if23AoyPy9sYNUQkMNze1WOmUb8ifoeB7G2ZmOGyT1W/HB3dewDwrFEB/onDpU4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2579
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyOC4wNS4yMSB1bSAxMjo1NiBzY2hyaWViIE5pcm1veSBEYXM6Cj4gQWxsb2NhdGUgUEQv
UFQgZW50cmllcyB3aGlsZSBhbGxvY2F0aW5nIFZNIEJPcyBhbmQgdXNlIHRoYXQKPiBpbnN0ZWFk
IG9mIGFsbG9jYXRpbmcgdGhvc2UgZW50cmllcyBzZXBhcmF0ZWx5Lgo+Cj4gdjI6IGNyZWF0ZSBh
IG5ldyB2YXIgZm9yIG51bSBlbnRyaWVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgfCAzNCArKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCAyMjNjNjMzNDJlY2QuLjdlNDc4ZmZiN2Zk
ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTg3Nyw2
ICs4NzcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9wdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCj4gICAJc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4gICAJc3RydWN0IGRtYV9y
ZXN2ICpyZXN2Owo+ICAgCWludCByOwo+ICsJdW5zaWduZWQgaW50IG51bV9lbnRyaWVzOwoKTW92
ZSB0aGF0IGEgbW9yZSB1cCwgdmFyaWFibGVzIGxpa2UgciBhbmQgaSBzaG91bGQgYmUgYWx3YXlz
IGRlY2xhcmVkIGxhc3QuCgpBcGFydCBmcm9tIHRoYXQgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCk5leHQgc3RlcCBzaG91bGQgcHJvYmFi
bHkgYmUgdG8gcmVtb3ZlIGVudHJ5LT5lbnRyaWVzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+
ICAgCW1lbXNldCgmYnAsIDAsIHNpemVvZihicCkpOwo+Cj4gQEAgLTg4Niw3ICs4ODcsMTQgQEAg
c3RhdGljIGludCBhbWRncHVfdm1fcHRfY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+ICAgCWJwLmRvbWFpbiA9IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX3Bpbl9kb21haW4oYWRl
diwgYnAuZG9tYWluKTsKPiAgIAlicC5mbGFncyA9IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09O
VElHVU9VUyB8Cj4gICAJCUFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQzsKPiAtCWJwLmJv
X3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm9fdm0pOwo+ICsKPiArCWlmIChsZXZl
bCA8IEFNREdQVV9WTV9QVEIpCj4gKwkJbnVtX2VudHJpZXMgPSBhbWRncHVfdm1fbnVtX2VudHJp
ZXMoYWRldiwgbGV2ZWwpOwo+ICsJZWxzZQo+ICsJCW51bV9lbnRyaWVzID0gMDsKPiArCj4gKwli
cC5ib19wdHJfc2l6ZSA9IHN0cnVjdF9zaXplKCgqdm1ibyksIGVudHJpZXMsIG51bV9lbnRyaWVz
KTsKPiArCj4gICAJaWYgKHZtLT51c2VfY3B1X2Zvcl91cGRhdGUpCj4gICAJCWJwLmZsYWdzIHw9
IEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7Cj4KPiBAQCAtOTU3LDE5ICs5
NjUsMTQgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+ICAgCXN0cnVjdCBhbWRncHVfYm9fdm0gKnB0Owo+ICAgCWludCByOwo+Cj4g
LQlpZiAoY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9WTV9QVEIgJiYgIWVudHJ5LT5lbnRyaWVzKSB7
Cj4gLQkJdW5zaWduZWQgbnVtX2VudHJpZXM7Cj4gLQo+IC0JCW51bV9lbnRyaWVzID0gYW1kZ3B1
X3ZtX251bV9lbnRyaWVzKGFkZXYsIGN1cnNvci0+bGV2ZWwpOwo+IC0JCWVudHJ5LT5lbnRyaWVz
ID0ga3ZtYWxsb2NfYXJyYXkobnVtX2VudHJpZXMsCj4gLQkJCQkJCXNpemVvZigqZW50cnktPmVu
dHJpZXMpLAo+IC0JCQkJCQlHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7Cj4gLQkJaWYgKCFlbnRy
eS0+ZW50cmllcykKPiAtCQkJcmV0dXJuIC1FTk9NRU07Cj4gLQl9Cj4gLQo+IC0JaWYgKGVudHJ5
LT5iYXNlLmJvKQo+ICsJaWYgKGVudHJ5LT5iYXNlLmJvKSB7Cj4gKwkJaWYgKGN1cnNvci0+bGV2
ZWwgPCBBTURHUFVfVk1fUFRCKQo+ICsJCQllbnRyeS0+ZW50cmllcyA9Cj4gKwkJCQl0b19hbWRn
cHVfYm9fdm0oZW50cnktPmJhc2UuYm8pLT5lbnRyaWVzOwo+ICsJCWVsc2UKPiArCQkJZW50cnkt
PmVudHJpZXMgPSBOVUxMOwo+ICAgCQlyZXR1cm4gMDsKPiArCX0KPgo+ICAgCXIgPSBhbWRncHVf
dm1fcHRfY3JlYXRlKGFkZXYsIHZtLCBjdXJzb3ItPmxldmVsLCBpbW1lZGlhdGUsICZwdCk7Cj4g
ICAJaWYgKHIpCj4gQEAgLTk4MSw2ICs5ODQsMTAgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxs
b2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCXB0X2JvID0gJnB0LT5ibzsK
PiAgIAlwdF9iby0+cGFyZW50ID0gYW1kZ3B1X2JvX3JlZihjdXJzb3ItPnBhcmVudC0+YmFzZS5i
byk7Cj4gICAJYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5pdCgmZW50cnktPmJhc2UsIHZtLCBwdF9ibyk7
Cj4gKwlpZiAoY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9WTV9QVEIpCj4gKwkJZW50cnktPmVudHJp
ZXMgPSBwdC0+ZW50cmllczsKPiArCWVsc2UKPiArCQllbnRyeS0+ZW50cmllcyA9IE5VTEw7Cj4K
PiAgIAlyID0gYW1kZ3B1X3ZtX2NsZWFyX2JvKGFkZXYsIHZtLCBwdCwgaW1tZWRpYXRlKTsKPiAg
IAlpZiAocikKPiBAQCAtMTAxMCw3ICsxMDE3LDYgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2Zy
ZWVfdGFibGUoc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkpCj4gICAJCWFtZGdwdV9ib191bnJl
Zigmc2hhZG93KTsKPiAgIAkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5ibyk7Cj4gICAJ
fQo+IC0Ja3ZmcmVlKGVudHJ5LT5lbnRyaWVzKTsKPiAgIAllbnRyeS0+ZW50cmllcyA9IE5VTEw7
Cj4gICB9Cj4KPiAtLQo+IDIuMzEuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
