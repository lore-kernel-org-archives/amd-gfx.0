Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E0C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DA620728
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yzlp3PKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DA620728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6DB96EDC1;
	Fri, 30 Oct 2020 11:11:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6966EDC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsN92HIw69nyBgcnbpnCrQSyTiMj3XteOpl9Ba3mg4kv2dRIL+8YKECiyVFR7K4zRNNMoFlS734puKlr8D9BwbmVNv2xhQyXP2oTrzm0O4V+7R1iHvtGARV6kmjBWE2bns55u2m1Uqtpwrg0IbS+NGQQLFz9ZJxMT0KVn8QSCBchHDDt0ybUSs5LCFQfRTQ3grNZxIRxqrNjUmvIqeg/GDkw+ARMo4OE8EDXqVNiM7o0LIUxHnNJhLDuJ7RQp/UJZ1jyWWyHhGJDhvN3p/nIv1KVD5Cq+d4I/j9GFXlrrbCYlDQCqKr9M/MD7na1PuGWKulQcdRS+hhgELaUMzAUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdC07d+XP66rVIUHK+DPE0vTlDbFW2Mm39NAAtPi0Ps=;
 b=hPVP4OPHPWApNQIGz+W7kU20Rz5wirEEorj8DIqzoG9rLHMu7RAy8819g1oDcfISbFAc1U99asy1ZK7NnjHZmpJISXb/bfA5Mq09I3Bp8hAJgXHxmtY1z5kDCmFFizjHH466Mrv1q9x93CiK0r0zbStw+wGEZvNR7ryMQGar/aEAzsmx/3paTzLIJpYUtnaITBlj/fw7cBygsHuRrZSpapQz8s60Aj42Mo+KuzoZQzeA5GF/nIZVw1sS0DVX8y8Ip87M1q9/xfikK71wGDYX65ND+nYeXZQN3Pg1aE6wD/o8hBIhbvA84KTw9VrlIEYhECIRLK3l7c31EHRadAFe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdC07d+XP66rVIUHK+DPE0vTlDbFW2Mm39NAAtPi0Ps=;
 b=yzlp3PKSh6sDAlI4MxC4i46T8Zkn8oqtZyBIszzV4Ts2YZmQjy+LoB9O+jxh2HMADMBMW5VLATgFHQx81on6ZVbbxDXLhxkzaOMB3GJGf80eOdkLQ0ZOCn/iknw6rFNr4aqGzK9xKRK+hDP/WYyuK9O/QDqdacjYG1pbi55RPUo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 11:11:32 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437%5]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 11:11:32 +0000
Subject: Re: [PATCH] drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for
 Polaris only
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201030110445.1662217-1-evan.quan@amd.com>
 <ee27f030-05a6-6a21-94fd-c70e53325de5@amd.com>
 <DM6PR12MB26196EB75BE3C8DA9BC5B9B1E4150@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3b15772e-89db-da66-aa20-d9a463aac757@amd.com>
Date: Fri, 30 Oct 2020 12:11:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB26196EB75BE3C8DA9BC5B9B1E4150@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::18) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM8P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Fri, 30 Oct 2020 11:11:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6560098b-56c4-493b-035d-08d87cc48eb7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40847E29C1469277665A8FC283150@BY5PR12MB4084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djKo0iZ7PPZlCTd/tcpJlANMNXaihH4v2gJ51/1NeCGqvlofG4uC0XmqMnKtREtpDzV0ryUn/yKLKQyqTlPEB2mqnApbyQmUTIvHBMjPsLO2NwzJIk0RsU8KmvF5w8ck0CfFZSbZ77eLoNwHURS2X537slkAvTDah7EATnIVim5lU0lX0ystlIxB01l2dYEzm162yZqQGmWPWCVlDUMM3JaUtA6kCasQXQkR5K2SKuNDOyl9Hi218VXpYiK2y9q4MlVRcxp1NYM3ny8qBp/SLaKmxZwY1OCQS+5Ne/95UQn6+Bp/tEzOdQajc0h3yhmMt1fpz0H9Eojdl9sxfEvi1hCVOZ8RnlGR751HQQa4X9OxMxfC64+LLvKg999XKUXD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(2906002)(2616005)(316002)(66556008)(5660300002)(66476007)(31696002)(66946007)(31686004)(66574015)(83380400001)(8676002)(8936002)(86362001)(110136005)(6486002)(6666004)(52116002)(4326008)(53546011)(36756003)(186003)(16526019)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: liG4ULC3RqsLJF10F9vVWcPBLNDhRFmFhbcmHo6yzvsyXwey/Irtc/dBEm0TC+24R4722HRWuig6wM7m5e5ABhfbmqUI7M36WzvfJaquB96z1TW92u2NgsedB6M23Gftn1A5fVpLtaYteya6ehDFym14cmyk7VYlkH6zyOm5P2cflt0/i8HUYnEvWIQM+aIPgEU6TOQcsLg7h76s2jxzAim2LKM6/G7WXn7KFQPfbdAoAkToTi4j7WVSlsaJ7w266NThnEmmEVREdICT56Nn9wHE1xQe1ByejeDgkSrAB38otPvt7F2HKqlhUWqng7TKOplj26ZpzNTokltK9tU0UZoCFJwEq7lB6jRMPwoXBFx2mcG2bDkK8HEb3WAU5EVTWKNJTiluymB/Re1x981Ajh8vQ7PYLAQQQ83yRij0JLQiywHJT+dTfus8vvcPtIjGqsJgnJZQ+3snE4+1hwYd8cJRYAY7quXIpCHm1mF2AgJc9C61WjYeUi2LBqvuVEEhtH6l7xIjKsxAKY/jW6CMq/4Yt9jpCQU7FCgmpKqz4Ds4JwqVcZOBWpykNOqMudXYHvc7VfoIJf7IEtCHL6mXnHJaXe/kNBWApZeRJuhgRgABhPAvD9O7hlV46DiBOl9OcTmnMY2gXXH985ZoIVCVq/bU4KRoHx4XyrFNzPv/teGwzX7wRq+B3Aakak13PeyuPnH+NuSRPjjTk9X3HgIc6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6560098b-56c4-493b-035d-08d87cc48eb7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 11:11:32.4487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOZ21A4Fvw98nm/QmJD+CHrEm7PDTJQLxHwz7S/bKHItt7iYHSykqRwDXyAbSLIt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzLCBnb2luZyB0byB0ZXN0IGl0IGxhdGVyIHRvZGF5LgoKQ2hyaXN0aWFuLgoKQW0gMzAu
MTAuMjAgdW0gMTI6MDcgc2NocmllYiBRdWFuLCBFdmFuOgo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPgo+IFllcywgaXQgaXMgaW50ZW5kZWQg
Zm9yIHRoYXQuCj4KPiBCUgo+IEV2YW4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZy
b206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Cj4gU2VudDog
RnJpZGF5LCBPY3RvYmVyIDMwLCAyMDIwIDc6MDYgUE0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogYXBwbHkgZG1fcHBfbm90aWZ5X3dtX2Nsb2NrX2NoYW5nZXMoKSBm
b3IgUG9sYXJpcyBvbmx5Cj4KPiBBbSAzMC4xMC4yMCB1bSAxMjowNCBzY2hyaWViIEV2YW4gUXVh
bjoKPj4gV2lsbCBleHBhbmQgaXQgdG8gb3RoZXIgQVNJQ3MgYWZ0ZXIgdmVyaWZpZWQuCj4+Cj4+
IENoYW5nZS1JZDogSTAzZTA3NGVhMGU5MjFhOTg0ZWI4MTliMjIyZTQzNGU4ODg4OGUzNzUKPj4g
U2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiBBY2tlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gSSBhc3N1bWUg
dGhpcyBmaXhlcyBteSBpc3N1ZSBvbiBWZWdhMjA/Cj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+
Cj4+IC0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9wcF9zbXUuYyB8IDcgKysrKysrLQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCj4+IGluZGV4IGZkMzlk
ZDY3YmZhNC4uODQwNjVjMTJkNGI4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYwo+PiBAQCAtNDYy
LDcgKzQ2MiwxMiBAQCBib29sIGRtX3BwX25vdGlmeV93bV9jbG9ja19jaGFuZ2VzKAo+PiAgICB2
b2lkICpwcF9oYW5kbGUgPSBhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlOwo+PiAgICBjb25zdCBz
dHJ1Y3QgYW1kX3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBvd2VycGxheS5wcF9mdW5jczsK
Pj4KPj4gLWlmIChwcF9mdW5jcyAmJiBwcF9mdW5jcy0+c2V0X3dhdGVybWFya3NfZm9yX2Nsb2Nr
c19yYW5nZXMpIHsKPj4gKy8qCj4+ICsgKiBMaW1pdCB0aGlzIHdhdGVybWFyayBzZXR0aW5nIGZv
ciBQb2xhcmlzIGZvciBub3cKPj4gKyAqIFRPRE86IGV4cGFuZCB0aGlzIHRvIG90aGVyIEFTSUNz
Cj4+ICsgKi8KPj4gK2lmICgoYWRldi0+YXNpY190eXBlID49IENISVBfUE9MQVJJUzEwKSAmJiAo
YWRldi0+YXNpY190eXBlIDw9IENISVBfVkVHQU0pCj4+ICsgICAgICYmIHBwX2Z1bmNzICYmIHBw
X2Z1bmNzLT5zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tzX3Jhbmdlcykgewo+PiAgICBpZiAoIXBw
X2Z1bmNzLT5zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tzX3JhbmdlcyhwcF9oYW5kbGUsCj4+ICAg
ICh2b2lkICopd21fd2l0aF9jbG9ja19yYW5nZXMpKQo+PiAgICByZXR1cm4gdHJ1ZTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
