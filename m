Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27739C5517A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA1020878
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 07:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yz7UCU6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75B46E497;
	Fri, 23 Oct 2020 07:12:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD2F6E497
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 07:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K68R0SrD/BMllJtmQviUPYswYI4tc8wD6nH4P8yI5id82eeHq0JhRqCog2DuGq9tWC8fWcnKFpP1xSDNfKsjm4q/L618tTosFpi16TSOFu42gdxd4vKPjpXk+zFxtRlG0Kax3GIOoC6DwxvqtmafUa2UQXf922pm/+dUxnnx9Kdx+QEfoubBdkCUdUQAEHI68zDlPZOMsN0882UrQ9YbWLcj/hLKjOKYXefGMjdelq687brQs+BYbuV9RS4GB9/jwf2As9NXU5gahxQOSRc0Ruk8NFmWf9ob9TFUmp/9pNSodykNHSdXA9B42cDSRLJ8TG3EmX8kZQewzfGsnSkmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjsUUN4AZGjImz9kEpdpCVhTl9D37C/dFGiqgM1VMps=;
 b=mcVUd19IQGMa2lfy30jYM9R/CGk0EzGx40kHbwAL6VhDd01SDW6n2Ht9lxwwNO6/55+1CRwkRChZmsWScExFHb1Wu5s6mTzetZbBluie/8lkUWhdhPhkgvFHWOWScByWjZHvua+ItVSHG7Dnu838Z/rngMt5yqu3N0Gqrjyj45LvU4nH0hdlFJNpSI6GR6J0DD4viHYEsp8or0zya4L59KFq1kSTcq8+bCQjoejleSdPSCNW+aPISQJR63sYN9m6jVhGOfV1Aa+oJh7XFLdxbZfQPnodO3Ya16Ve90+cT4jjU2j8jcyDMGJXzNdefbTpxFtA4VR0z8UbbphKrwoYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjsUUN4AZGjImz9kEpdpCVhTl9D37C/dFGiqgM1VMps=;
 b=Yz7UCU6cjU6afLG0cN26mZQqbxdTWfYGBagxLdpOKfUhCmD57pbqgTcj5K/C4lfZ9SHE9YiaKXnDz3ZASTN7EJ/LyzIiTDtTI6aJbQ7JJWnRBM0EMOQT/5YJQpXP9W3pjG84YmVKw4BYY8ytlIkajpX5M+OL+icVIn1+YTGQg7M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 07:12:36 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 07:12:36 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix size calculation when init onchip memory
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201023054112.3307-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a71b6131-5d5b-d00b-fb46-973d333d73fb@amd.com>
Date: Fri, 23 Oct 2020 09:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201023054112.3307-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0098.eurprd02.prod.outlook.com
 (2603:10a6:208:154::39) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0098.eurprd02.prod.outlook.com (2603:10a6:208:154::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Fri, 23 Oct 2020 07:12:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5254f462-377c-470b-74c8-08d8772304eb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44388DC3019DA33274038849831A0@MN2PR12MB4438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OtdfJ8cM4O6Gp04FIxi71Pka1/0FXmvW86WD6eqh9TivWyRG/4cTCcJoUTRDV85hYYpFu6dr077gwZIY/2yYvs6V1aplGBFl7XcZWvmKOPhDUUy5FYqRIMdI3DuKRdEY9hfehsf72A/wAne60bCMOsHgw9/mjkHBitt2rvNWWNbla64Jc5zpRsajEFyATjKeTfbt4HRT67uqP70aWK/WQAKbQErKYCfqeCgrwd23JZa0Oxq1hJyhcaenOmYEo0UynoytIdAc80dstFNr9n1V7YpNo82UeZ43B9FwBKMfv7/x/tog80Q9aPcpjCpS1X6SxhhO2xbSzcKkBdh1jBB9FG0fSR2X2Nm2vcBVpKg1swj5KGBGZ8dwNQhtakzjtd0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(478600001)(2616005)(16526019)(66556008)(83380400001)(66476007)(52116002)(316002)(4744005)(36756003)(5660300002)(66946007)(6666004)(8676002)(4326008)(6486002)(8936002)(31686004)(86362001)(2906002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: l1nOjzokIgdzyb/soMIU1TDTNvVFD6FsFCRg+rwv9zFeajc5WLABXNDUFqs/kaf3QulhELfQNBfdUVD9BGlYnl4Lu0bCVfQTqKmPL76UVHW5au8+go63zfxrYiypvDq8EI6YYy2Ks7+OOhJNlS6kzvBy+WmOXmwGzHo0RQbwA2uLwo8qkWDheMMl4p1u5dKVYqrNfNAgFTcGoW3AqY7VuvRjjAWMktiSqXPiRFRU3w37No/LZOZnFC9d7qN1F2Ypok5bO14eKSnDIYfuxBsWY4u2uy8XXoUbMeBlH616QNq2Y+UYhqrRCT5GRirjZJLVlNIWa1paHhoLLSuWzM+roud8G9cMaoM9THx6PLzgivGaEOxzPxuIeqwcXtrRxJVfvZnPl31sMA3eE94BXNryGOTMbU8S2MBP954rQ6qiVIul+pMN5ptmvETJ8Gw4MWRx3egsEBV2GMhUPmBQXp2CHRvj9k/q8qJcU4mGhPnhU9lyVO11uatnPCI/Xfjp75vMR+PxBy/P1jGbPXH2cLUQHXm/XTTaolW+gu1YrJtRs0VFPBN0lihM3pMli0P4O9MziytMoJj4NbcaUyN8nHR/fPsWRkzDTJFDcJbP+lBBo4fWRSqaewbTbt40Dd0ZJVDB5l39DMWfJCHfETqXEker0UH6KEIGiU3th5vYSF3moo0e4+qoF66BUSoa5c3gOtI4liBNnvU66x/lgpAZhL4pSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5254f462-377c-470b-74c8-08d8772304eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 07:12:36.5354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbPZRXI+WVwPXX+SShR7ny4jMgC0s/KvlQyT36z2P4GupfgCn/h7/Rtxa0+a56TU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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
Cc: alexander.deucher@amd.com, Guchun.Chen@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMTAuMjAgdW0gMDc6NDEgc2NocmllYiB4aW5odWkgcGFuOgo+IFNpemUgaXMgcGFnZSBj
b3VudCBoZXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQu
Y29tPgoKQWggeWVzIHRoYXQgb25lIGFnYWluLiBBdCBzb21lIHBvaW50IHdlIHJlYWxseSBuZWVk
IHRvIGNsZWFuIHRoYXQgdXAuCgpQYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKPiBpbmRleCA0YTg1ZjhjZWRkNzcuLjExZGQzZDllYWMxNSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBAQCAtNjUsMTEgKzY1LDExIEBA
Cj4gICAKPiAgIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9pbml0X29uX2NoaXAoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJICAgIHVuc2lnbmVkIGludCB0eXBlLAo+IC0JCQkJICAg
IHVpbnQ2NF90IHNpemUpCj4gKwkJCQkgICAgdWludDY0X3Qgc2l6ZV9pbl9wYWdlKQo+ICAgewo+
ICAgCXJldHVybiB0dG1fcmFuZ2VfbWFuX2luaXQoJmFkZXYtPm1tYW4uYmRldiwgdHlwZSwKPiAg
IAkJCQkgIFRUTV9QTF9GTEFHX1VOQ0FDSEVELCBUVE1fUExfRkxBR19VTkNBQ0hFRCwKPiAtCQkJ
CSAgZmFsc2UsIHNpemUgPj4gUEFHRV9TSElGVCk7Cj4gKwkJCQkgIGZhbHNlLCBzaXplX2luX3Bh
Z2UpOwo+ICAgfQo+ICAgCj4gICAvKioKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
