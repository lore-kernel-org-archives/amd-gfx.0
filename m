Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A5C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 04:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ABF206D8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 04:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UzsgFHmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ABF206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAFA89590;
	Tue, 10 Nov 2020 04:34:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4DF8926E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 04:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtpQIGquF83QApqD+5acr1g73A/X6Gyho/T9gIi2+hbQ3N34fke+CIO3ixPJcKdjXZ1/tKe+Jcm5rfIyp+v7e+dqN8RLKfZoLedZp9e8jI95WTg6z1bfxyAKISqRGx8kXlMlZDbEsaLtqls4nmH+lIblsqe+huoW6XCj06z99/A0+r41YDP3+0zi0gnyypUad3Jgstc+Hjay5rc3Wr2NJdWyUrE49E9FEdMMD6FKqCcL01SbAPXBbOGSpm249lOff+h+gspgj3xpv0f/hsdU3xx8yVFcXEZC4Dj5NEabnQOP6lL2tGSwB2n+hNPXS1HcIB/WS8i1G26m+aD8dSSuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkt2cWTuwbrxJj/2ciR8C4/3dAcmg5zj3ZHNaFauv6E=;
 b=KCVXsBWmvFtJ2b0pGxlrYBZ6FralxekGVYXxiF2UY0RgJTsN2DrsFQ2FXOONWQJJkyO3xXAnB27bYlJKD3bnoqN+tr1EK0ZdaU9kor6yvWHmAZ8WLA5bM9pfaBTk/77myUZrtcbcejZEZuZXuV/92cNgX7mWPU11VClDGJInsS5+oAyxjUsxGMQSaGWhpWikUUZbzYH9jrs4CjQgqdn3OULIwD/8c4tgNiCAapwNa7LUBUlLQ+dWQw7qgi23hfahQ+UW/DRBQCGePbaBmIfLMqgLgZmC6wvCnD9s2nTiXz9yTycbmiG1bJF0CKOwebXrjkW4dZYin2u3IUEcFYbA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkt2cWTuwbrxJj/2ciR8C4/3dAcmg5zj3ZHNaFauv6E=;
 b=UzsgFHmnHxp4GZ71HncpuDzziW+RehlvrNwav/ODSliMqSy4lWtpaLO3Q7hfwy0dicMpm4UeSvUa9Z9aONG+Fa5VeCzjEAK2NH21Rl4T0BzEa8xChvepE4NQmXR4SKRGXToPWpQv5kmrd0i7FN195J07cj6mi+cHDWpy5bq0AtY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 04:34:50 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 04:34:50 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Import amdgpu_amdkfd_gfx_v9 header file
 into implementation
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201106190528.10807-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2728a120-a114-2fcb-0eeb-0de4dc0eadea@amd.com>
Date: Mon, 9 Nov 2020 23:34:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201106190528.10807-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend
 Transport; Tue, 10 Nov 2020 04:34:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 248ab3ba-2615-412f-994d-08d88531f642
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41269EDE636FF950D7657B6492E90@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihLQHpSs+LfwHRRD/T8B6MbCChE9bcojSW7Zh85+upgwKBKjp4LfcTmiPzVvz/7UQHBwfN1zJLkpY7RP/ok9blxLL6H/KOtWBxXBDIDTzPlycT8pwHbhqoFFkzniLXwuoKeXpvrHXPwak3srRN1aysz+jL1g0syK3/QIdkWDe/1asNoeXib4z0lHC4eRFgX6Mg5Z1eBktVft7ZIOi2HauxNTVHoA3j+As7cb59AFvYsqojmD+OeHXVNR1VqgHYUV6+CpyjOYoU+pQtAklayS75Z61emJ3NXKqicsI4AiVckG/bpwWl5ArUj/Snk9BOPrSzQsL5H10mtveYy8KVaTpL0DDSl8Y/acDoKQo7vWwI4Uw+2GbzfOiShCJHpEb2wO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(8936002)(31686004)(83380400001)(478600001)(6486002)(186003)(26005)(16526019)(52116002)(956004)(2616005)(44832011)(8676002)(66946007)(66476007)(66556008)(316002)(5660300002)(36756003)(2906002)(86362001)(31696002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6cQWaiQURlVexSaO7HxjtIdkPbYPopjhrBdut9W+vp8mt0zTgZy4Nl8b4Scw62rrRHpX1pxAs3bRwSXAtC0sXenZm8XqhrpAr7mPKqGMCy5R8QSPdvABQPrfB6wfYpsQyLEsaLwXheS6lJfC8dfURGW+3UC5/cf+52IwvifF1BywBbPxR2c+CqzOmZ+SrOjgNhI4RgsK0E+p4u4is6aQ6hQ1MdLvRQoqPnXMxVWHhE2WVLh2B4OoETy8licdDJ4Y+OJ52oeeuFBnYkTDo5MJdGR8zdJHR1GxVhDXm9q48dLxV/HXqvKY0KWsmdqLg6szWFPI4s/TZR5N695zgFI55wBWS1ejiD/XKBr+ujqkkcWPWh9AGm3n5Wyg8citIbzDzwRdmDfSYDI4c9+OZOKuxCaUdsXZXgHm5WmQXhZicLmpZBkG51t5a8b94MkEQ2UkNzuFe1+tRd0ZGpne1qkJEhET/hqRFR6CjdRAHWhjiov12rFChh1oqMgxahIDxTJYt1R13HmL/EmlumkUPAvXJG4hVEXQeDT3KXsuyuJRFLgR7m+SoubifFLX0doAI3mSQ2kEQBv4h2HhU578R6bTDlVtb5f+zxWAYoGOQVWNjeYGoxU/cdQyx89+IhLX/6NO3mivc0bX1rqISKK6ylqCnkbZoJ2nUOudXJ3aEtuOilYp048GDibRAUVgs9Z+DAyFuMOKsBpCB6vlcBrsqNKK0TWE+0C5RrYsaoG9ig1x9kHw7ZQsQoO/yiFptijMQisAkyZcs5OOpRuBTJP8Bp2JPtzVQ/6k+Pcl+qqL5OTgQFpCrEm7LXXHj6lLbH/hbTPZRdktZXHXUIlKY/toGVwshCQMDmE4nC9NKy5gAoP9bHklviMJPBM+P424fQLapXBbtAtMYooP7J6scQFLhuIPTw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ab3ba-2615-412f-994d-08d88531f642
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 04:34:50.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS5/kJ8UIPQV7SbBvQ2mjsBxkdu4MjV8i8XcYfMbSCBtKoc2TfpC1H86e+MFYWeHAuneNdKrIWDr0mROQeB2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzZWVtcyB0byBmaXggYSBwcm9ibGVtIHRoYXQgd2FzIHJlcG9ydGVkIGJ5IHRoZSBrZXJu
ZWwgdGVzdCByb2JvdAppbiB0aGlzIGVtYWlsOiAiW3JhZGVvbi1hbGV4OmRybS1uZXh0IDY1NS82
NjNdCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmM6ODAy
OjY6IHdhcm5pbmc6IG5vCnByZXZpb3VzIHByb3RvdHlwZSBmb3IgZnVuY3Rpb24gJ2tnZF9nZnhf
djlfZ2V0X2N1X29jY3VwYW5jeSciLiBJdCB3b3VsZApoYXZlIGJlZW4gZ29vZCB0byBpbmNsdWRl
IGFuIGFwcHJvcHJpYXRlICJSZXBvcnRlZC1ieToiIHRhZywgYW5kIGFsc28gYQoiRml4ZXM6IiB0
YWcgdG8gcG9pbnQgb3V0IHRoZSByZWNlbnQgY2hhbmdlIHRoYXQgaW50cm9kdWNlZCB0aGUgd2Fy
bmluZ3MuCgpSZWdhcmRzLArCoCBGZWxpeAoKQW0gMjAyMC0xMS0wNiB1bSAyOjA1IHAubS4gc2No
cmllYiBSYW1lc2ggRXJyYWJvbHU6Cj4gW1doeV0KPiBQcmV2ZW50IGNvbXBpbGVyIHdhcm5pbmdz
IHdoZW4gYnVpbGRpbmcgYW1kZ3B1IGtlcm5lbCBtb2R1bGUKPgo+IFtIb3ddCj4gQWRkIHRoZSBp
bmNsdWRlIGRpcmVjdGl2ZSBmb3IgYW1kZ3B1X2FtZGtmZF9nZnhfdjkgaGVhZGVyIGZpbGUKPgo+
IFNpZ25lZC1vZmYtYnk6IFJhbWVzaCBFcnJhYm9sdSA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5
LmMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMKPiBpbmRleCBi
NzViZjBiYjA1YWUuLmM3MGQ4Y2FkYWYxOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwo+IEBAIC0zNyw2ICszNyw3IEBACj4g
ICNpbmNsdWRlICJzb2MxNS5oIgo+ICAjaW5jbHVkZSAic29jMTVkLmgiCj4gICNpbmNsdWRlICJn
ZnhfdjlfMC5oIgo+ICsjaW5jbHVkZSAiYW1kZ3B1X2FtZGtmZF9nZnhfdjkuaCIKPiAgCj4gIGVu
dW0gaHFkX2RlcXVldWVfcmVxdWVzdF90eXBlIHsKPiAgCU5PX0FDVElPTiA9IDAsCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
