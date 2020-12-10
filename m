Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E297CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 17:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791A823D57
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791A823D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933256E435;
	Thu, 10 Dec 2020 17:49:19 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690058.outbound.protection.outlook.com [40.107.69.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A797B6E435
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 17:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3b3WOAzXWPWqxD2556CLRF1LAH8agHTuWCeLokeZb3iik5WJqTkEPtOzoE+C/abrK5Sxq0iGiM54Ynu2ibwW3N6nFIvaWvnyWoMqposqA9xosdQaqaJb9JIP5eeH1JdqoE/8a1Z4p7As4mLrgm3y18ssJHposf/frfj7smQijRqXJw6Alm1/bxXgRXbZZwaM5BZSu/KUvyUURW22l9Ce3ACzQtPGFUBCWPPhYYe8kReFOPNeTvimuZne+PsGDt59mOF+0M4YwgR2pGd85Y8E/tIGlj7Ih9qKf2JuI+CH9cr08otihnDKgzLXARuLa/0P8MPnaR9Ip6+oJOq6Ol9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt0TQ0dwNQJA0yAjmf9q9lrbJguqQ4EtOdj2lVrRXCM=;
 b=D3s1ZZOEHzfDj9gQicAqHOPgM2Oh3hquhfSguAdp/q0haceZzxR14dMNRcwOi76YEd1e+YrXtSAE/n2hm8rVHvKsM7qwEHDhfYhimOcUCTYL6wDcO+fnHL0UtkS14c+N/cukG+LsKfSK+uz37gfceloBie2ele1SfDYYQpclCkkCRBHalSaw/ah0B8eOcGiVGxnmuxkNi5JKINiL6JRYWkPZCr86lM2UYpYNKRZZQUr6T3rwYMERF/7FnzPRoNMeQ6S8Yblr6/G7awKrGzo59I6Kd0tfBeXNbbF4SHlJYfEWzZ6klipekJPFIvn+3eKscBEQisrWAKbOYwtyHu2N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt0TQ0dwNQJA0yAjmf9q9lrbJguqQ4EtOdj2lVrRXCM=;
 b=X9uZwzFzWx2bVaoAaQRpOl4ez0xM7PYdsdwIP7A4VQ7J3d5ujUBgyWJtnFIxnr/2srNBB5c52MaUsdDebEz5fFpJvk4tSJ7IufvhpVTMiMPScou5pbajlJv+bN5EYJNl9WnY6Nnq7f9r/NL7W0pc0D4/sOAJh8jxXtQJmwqbf8A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 by MN2PR12MB3040.namprd12.prod.outlook.com (2603:10b6:208:ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Thu, 10 Dec
 2020 17:49:17 +0000
Received: from MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135]) by MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 17:49:16 +0000
Subject: Re: [PATCH] drm/amdgpu: take runtime pm reference when we attach a
 buffer
To: Alex Deucher <alexdeucher@gmail.com>
References: <20201204204130.3697-1-alexander.deucher@amd.com>
 <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
 <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
 <2eb41038-2e69-68ab-2f6b-017cd1bcb455@gmail.com>
 <dd8e7365-c432-f6bc-407e-e3cb1f88d9f5@amd.com>
 <CADnq5_OPiZkybCZbF6Zn6fqTGd=fqpb-E117CCqgL7C_BgF4BQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <dd8670ec-6f8c-9c61-f309-aca183c2b14c@amd.com>
Date: Thu, 10 Dec 2020 23:19:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <CADnq5_OPiZkybCZbF6Zn6fqTGd=fqpb-E117CCqgL7C_BgF4BQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::18) To MN2PR12MB3133.namprd12.prod.outlook.com
 (2603:10b6:208:c7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 17:49:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ed3c279-723f-42c2-cb98-08d89d33ea21
X-MS-TrafficTypeDiagnostic: MN2PR12MB3040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3040468822A22EE5DD3FB7BDF2CB0@MN2PR12MB3040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ju7wGLlx2cGnuty0GDAlVnu6Li/eBaC2swtFfoRNg0uoA6yWXeKfUeyEV9GPKEwQRIvhaf85VpYb54+oidahUwPSkp+nhAr8pb/0xQyZzi1EVKzuQEjeRdF38z0AZpfsf4IbjL7WZw/VeSYK5LJARcShhQSZnrwULt1wXrJOfSr5dgDW+WXn+b0JgRXiXiqbuWp1Eaef0Kq9bzLvhnjixm5aH5eIuce9RATuu5CXWapexZ6cO9GBLK+/wYWaSUTbUC9oZXR94n8xtX1ui7SZhkYbqDBAaJcTEDdW02ysHVXwrsTPGZUQEwLHcN6LxUVXm2dMtMbH7zDKe5TbAu+SEF23D0r/sJnGZlO0tTZMVzFwcU7CJ+AIwm60vo2GYb5FFM3vBOeUFVhbBeHnUUDvbmxtSuy/iakdLatE5kuDEyQIQM8qDtX2whMfzdlocxI2nYZ4utVJAMg59mMIN0tKOKSuQ47y/Db4fLjBH53MRjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(54906003)(31686004)(16576012)(186003)(66476007)(66556008)(508600001)(55236004)(6916009)(45080400002)(34490700003)(2906002)(2616005)(52116002)(83380400001)(4326008)(86362001)(44832011)(53546011)(26005)(66946007)(5660300002)(6486002)(966005)(1006002)(6666004)(956004)(8936002)(66574015)(16526019)(31696002)(36756003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2MxK2ZnaVNadmFDZHpKMlBxS2dBTFZ2VlRqTWpoV0d1ZmlmYjJkTmFsRzFU?=
 =?utf-8?B?OE9oWlEydTdSam4wTlUyYVdrUVNRNEsrYlgyMmljUldpdzlUbURpSTBVa0Ja?=
 =?utf-8?B?YllTMTFaVndjVG53UEdzZjhwWFhNYnFQbHNMSTcydjVMa2R4Q2N4cVBDUGJY?=
 =?utf-8?B?TGc0dEQxdDlra0g1cElBOWF5T0xRUHM3YTBVdUNUWVpuVjFNK2toWnNQSG5q?=
 =?utf-8?B?ejZFK1B1Wk00YjVkSHRMV3JoNy9PZzRjZ1h0eExtY0k3QzM2aWRzeWJWNjhU?=
 =?utf-8?B?SStrRVBHb2sxWitXUitqaFpwbDZzMW9paWszNHo5RldqQWxIb1lFMVhFTUxD?=
 =?utf-8?B?RXcrQktNWjZFeFYzR3l1NkVXM205L2tDWXFCQWVHUGVselNZdXFYaGw5UTZT?=
 =?utf-8?B?eGJBU0x2eVN3MWRjSVBjUWE3OHdzWjl1enNvTDVTcHo1NEFOU3V6K1NpNDRE?=
 =?utf-8?B?RXA1Q1djMzcvZ0laTWQwRE8wSWRNT2JsY0FZM3dPeEVjYVFEcDV0ZWpaZCtT?=
 =?utf-8?B?QWRpLzB5Y0hYcFdoZVJMSlV1bTk4UzZWSEhwdlhjLzR6SkZUY1NISGJVdERC?=
 =?utf-8?B?MXlpZ2g4Q1pZVVV1MVlqRFZFTHRZa3VHZUUyMzdpdERuM2dwYWo1Y3JhclFl?=
 =?utf-8?B?ZkM5bHVZMU5qeUo1SlFSeW1TQXA2cVFQeXdKMWJwdktlaU9oQjFaK3E2L1gy?=
 =?utf-8?B?WDd6cG95SUYvaWp3VkpZYnFkLzVKYnNWU0ljOS85ZjRZZXIzRUE1MjhWYndX?=
 =?utf-8?B?N0gwVXZwU2NLSG1Lc0NVM2NHL3pybE8rWDl1elQ5NWF0M2dIZUJ3MS9peHVp?=
 =?utf-8?B?TDUxbTlIWWdUaVROSlRFcVpnK29EaTF3b1gxeTF6NDE1TjZjMHR5amhtVDFo?=
 =?utf-8?B?eUxuQUVEd1ArY0p2SHhBTkRrOXRLLzBoMFh2ck9PSnNaOFh6NTZ0M2NtdkZ1?=
 =?utf-8?B?TnhyNlNRa2hmellOMmEwc25YTiswdFJxRzdoNnM0VUsyYXJMZTBXbHF4ZjN0?=
 =?utf-8?B?RndaZk9mL1BkYkZqRkMwZERwZlpjN3BWYldTVmpVZnZldDFlbUxJMjE2b0pV?=
 =?utf-8?B?L29BZkczcUVqUEtURjk5Z1Vrd3ZDU0tZTWtkZ0Z0c0J3WW5ldWE5QWIyeWk5?=
 =?utf-8?B?YWIyQTNYZ0tXUGRhUFhmYlc3STh5ajZtVExqMWsrRU5wU3dDakkvYXlQN29x?=
 =?utf-8?B?VUdBbHdITldKLzRpV2hQQXZlMDduSmUxRFJ5Q04vSjBqQWRGRTJZNEgyVk9K?=
 =?utf-8?B?WWN1bVlxZDZXaktIZ25CVStPcmZTOE5ZTktyVzBDSWtoc2RZNjA1ZlhsU2Zp?=
 =?utf-8?Q?E0r0HRQX+M9ctVNaOLSnlgvRc07RyuR9gQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 17:49:16.7862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed3c279-723f-42c2-cb98-08d89d33ea21
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxJW7zSN1wyz2fr+6j9YEsdVyZZpsAhBAg4Hdxu84yT2Bz1XdNGXJt0o5f9F2RwsOMvo84OYyoCg81qFZQ/qmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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
Cc: Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEwLzEyLzIwIDk6MjMgcG0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUaHUsIERlYyAx
MCwgMjAyMCBhdCA4OjAzIEFNIFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5j
b20+IHdyb3RlOgo+Pgo+PiBPbiAxMC8xMi8yMCAzOjU4IHBtLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOgo+Pj4gQW0gMTAuMTIuMjAgdW0gMDU6NDkgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+
Pj4gT24gMDkvMTIvMjAgMTE6MDAgcG0sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4+Pj4gT24gRnJp
LCBEZWMgNCwgMjAyMCBhdCAzOjQxIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPiB3cm90ZToKPj4+Pj4+IEFuZCBkcm9wIGl0IHdoZW4gd2UgZGV0YWNoLiAgSWYgdGhlIHNo
YXJlZCBidWZmZXIgaXMgaW4gdnJhbSwKPj4+Pj4+IHdlIG5lZWQgdG8gbWFrZSBzdXJlIHdlIGRv
bid0IHB1dCB0aGUgZGV2aWNlIGludG8gcnVudGltZQo+Pj4+Pj4gc3VzcGVuZC4KPj4+Pj4+Cj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cj4+Pj4+IFBpbmc/ICBBbnkgdGhvdWdodHMgb24gdGhpcz8gIFdlIHJlYWxseSBvbmx5IG5l
ZWQgdGhpcyBmb3IgcDJwIHNpbmNlCj4+Pj4+IGRldmljZSBtZW1vcnkgaW4gaW52b2x2ZWQsIGJ1
dCBJJ20gbm90IHN1cmUgb2YgdGhlIGJlc3Qgd2F5IHRvIGhhbmRsZQo+Pj4+PiB0aGF0Lgo+Pj4+
Pgo+Pj4+PiBBbGV4Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RtYV9idWYuYyB8IDE2ICsrKysrKysrKysrKysrLS0KPj4+Pj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+Pj4+PiBpbmRl
eCA1YjQ2NWFiNzc0ZDEuLmY2M2YxODJmMzdmOSAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPj4+Pj4+IEBAIC00MCw2ICs0MCw3
IEBACj4+Pj4+PiAgICNpbmNsdWRlIDxsaW51eC9kbWEtYnVmLmg+Cj4+Pj4+PiAgICNpbmNsdWRl
IDxsaW51eC9kbWEtZmVuY2UtYXJyYXkuaD4KPj4+Pj4+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS1w
MnBkbWEuaD4KPj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgo+Pj4+Pj4KPj4+
Pj4+ICAgLyoqCj4+Pj4+PiAgICAqIGFtZGdwdV9nZW1fcHJpbWVfdm1hcCAtICZkbWFfYnVmX29w
cy52bWFwIGltcGxlbWVudGF0aW9uCj4+Pj4+PiBAQCAtMTg3LDkgKzE4OCwxMyBAQCBzdGF0aWMg
aW50IGFtZGdwdV9kbWFfYnVmX2F0dGFjaChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLAo+Pj4+Pj4g
ICAgICAgICAgaWYgKGF0dGFjaC0+ZGV2LT5kcml2ZXIgPT0gYWRldi0+ZGV2LT5kcml2ZXIpCj4+
Pj4+PiAgICAgICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4KPj4+Pj4+ICsgICAgICAgciA9
IHBtX3J1bnRpbWVfZ2V0X3N5bmMoYWRldl90b19kcm0oYWRldiktPmRldik7Cj4+Pj4+PiArICAg
ICAgIGlmIChyIDwgMCkKPj4+Pj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4+Pj4+ICsK
Pj4+PiBJIGFtIGEgYml0IHNrZXB0aWNhbCBpZiB3ZSBzaG91bGQgZmFpbCB0aGUgQk8gcmVzZXJ2
ZSBpZiB3ZSBkb24ndCBnZXQgdGhlIHN5bmMgPyBJIHdhcyBob3BpbmcgdG8gY29udGludWUgd2l0
aCBpdCwgd2l0aCBhIHdhcm5pbmcgbWF5YmUsIHNvIHRoYXQgaXQgZG9lc24ndCBibG9jayB0aGUg
ZXhpc3RpbmcgZnVuY3Rpb25hbGl0eSA/Cj4+PiBJJ20gbm90IHN1cmUgd2h5IHBtX3J1bnRpbWVf
Z2V0X3N5bmMoKSBjb3VsZCBmYWlsLCBidXQgbm90IGF0dGFjaGluZyB0aGUKPj4+IERNQS1idWYg
aXMgY2VydGFpbmx5IHRoZSBiZXN0IHdlIGNvdWxkIGRvIGhlcmUgaW4gdGhhdCBtb21lbnQuCj4+
IEFoLCBJIHNlZS4gSnVzdCBjdXJpb3VzIGFib3V0LCBiZWZvcmUgdGhpcyBwYXRjaCwgd2hlbiB3
ZSB0cmllZCB0byByZXNlcnZlIHRoZSBCTywgd2l0aG91dCB0aGUgUE0gc3luYywgaG93IHdhcyB0
aGF0IGRvaW5nIE9LID8KPiBwMnAgaXMgbm90IHdpZGVseSB1c2VkIGF0IHRoaXMgcG9pbnQsIHNv
IHdlIG5ldmVyIHJlYWxseSBoaXQgaXMgZXhjZXB0Cj4gZm9yIHNwZWNpZmljIHRlc3Rpbmcgb2Yg
dGhlIGZ1bmN0aW9uYWxpdHkuCj4KPiBBbGV4CgpHb3QgaXQuIEFwYXJ0IGZyb20gdGhpcywgbG9v
a3MgZmluZSBieSBtZS4KCkFja2VkLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJt
YUBhbWQuY29tPgoKPgo+PiAtIFNoYXNoYW5rCj4+Cj4+PiBPdGhlcndpc2Ugd2UgY291bGQgZW5k
IHVwIGluIGFjY2Vzc2luZyB0aGUgUENJZSBCQVIgd2l0aCBwb3dlciBkaXNhYmxlZAo+Pj4gYW5k
IHRoYXQncyBpbmRlZWQga2luZCBvZiBiYWQuCj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pj4+
ICAgICAgICAgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZShibywgZmFsc2UpOwo+Pj4+Pj4gICAgICAg
ICAgaWYgKHVubGlrZWx5KHIgIT0gMCkpCj4+Pj4+PiAtICAgICAgICAgICAgICAgcmV0dXJuIHI7
Cj4+Pj4+PiArICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+Pj4+Pgo+Pj4+Pj4gICAgICAgICAg
LyoKPj4+Pj4+ICAgICAgICAgICAqIFdlIG9ubHkgY3JlYXRlIHNoYXJlZCBmZW5jZXMgZm9yIGlu
dGVybmFsIHVzZSwgYnV0IGltcG9ydGVycwo+Pj4+Pj4gQEAgLTIwMSwxMSArMjA2LDE1IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X2RtYV9idWZfYXR0YWNoKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsCj4+
Pj4+PiAgICAgICAgICAgKi8KPj4+Pj4+ICAgICAgICAgIHIgPSBfX2RtYV9yZXN2X21ha2VfZXhj
bHVzaXZlKGJvLT50Ym8uYmFzZS5yZXN2KTsKPj4+Pj4+ICAgICAgICAgIGlmIChyKQo+Pj4+Pj4g
LSAgICAgICAgICAgICAgIHJldHVybiByOwo+Pj4+Pj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0
Owo+Pj4+Pj4KPj4+Pj4+ICAgICAgICAgIGJvLT5wcmltZV9zaGFyZWRfY291bnQrKzsKPj4+Pj4+
ICAgICAgICAgIGFtZGdwdV9ib191bnJlc2VydmUoYm8pOwo+Pj4+Pj4gICAgICAgICAgcmV0dXJu
IDA7Cj4+Pj4+PiArCj4+Pj4+PiArb3V0Ogo+Pj4+Pj4gKyAgICAgICBwbV9ydW50aW1lX3B1dF9h
dXRvc3VzcGVuZChhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsKPj4+PiBXaHkgbm90IGp1c3QgcG1f
cnVudGltZV9wdXRfc3luYyA/IFdoeSBhdXRvc3VzcGVuZCA/Cj4+Pj4KPj4+PiAtIFNoYXNoYW5r
Cj4+Pj4KPj4+Pj4+ICsgICAgICAgcmV0dXJuIHI7Cj4+Pj4+PiAgIH0KPj4+Pj4+Cj4+Pj4+PiAg
IC8qKgo+Pj4+Pj4gQEAgLTIyNSw2ICsyMzQsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1hX2J1
Zl9kZXRhY2goc3RydWN0IGRtYV9idWYgKmRtYWJ1ZiwKPj4+Pj4+Cj4+Pj4+PiAgICAgICAgICBp
ZiAoYXR0YWNoLT5kZXYtPmRyaXZlciAhPSBhZGV2LT5kZXYtPmRyaXZlciAmJiBiby0+cHJpbWVf
c2hhcmVkX2NvdW50KQo+Pj4+Pj4gICAgICAgICAgICAgICAgICBiby0+cHJpbWVfc2hhcmVkX2Nv
dW50LS07Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAgIHBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3ko
YWRldl90b19kcm0oYWRldiktPmRldik7Cj4+Pj4+PiArICAgICAgIHBtX3J1bnRpbWVfcHV0X2F1
dG9zdXNwZW5kKGFkZXZfdG9fZHJtKGFkZXYpLT5kZXYpOwo+Pj4+Pj4gICB9Cj4+Pj4+Pgo+Pj4+
Pj4gICAvKioKPj4+Pj4+IC0tCj4+Pj4+PiAyLjI1LjQKPj4+Pj4+Cj4+Pj4+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IGh0dHBzOi8v
bmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
Rmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1w
O2RhdGE9MDQlN0MwMSU3Q3NoYXNoYW5rLnNoYXJtYSU0MGFtZC5jb20lN0MyMjJlNDFiMzgzN2M0
ZDdmM2VjOTA4ZDg5ZDIzY2E4YiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc0MzIxMjQzMzc2NzkxOTQlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMzAwMCZhbXA7c2RhdGE9YmdTdm40WHFtb0tmZnlDRjF2MWxkVnB0aUtNWlhmRWZrekZu
SmozQ2EwWSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q3No
YXNoYW5rLnNoYXJtYSU0MGFtZC5jb20lN0MyMjJlNDFiMzgzN2M0ZDdmM2VjOTA4ZDg5ZDIzY2E4
YiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0MzIxMjQz
Mzc2NzkxOTQlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2Rh
dGE9YmdTdm40WHFtb0tmZnlDRjF2MWxkVnB0aUtNWlhmRWZrekZuSmozQ2EwWSUzRCZhbXA7cmVz
ZXJ2ZWQ9MAo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8l
MkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NzaGFzaGFuay5zaGFybWElNDBhbWQuY29tJTdD
MjIyZTQxYjM4MzdjNGQ3ZjNlYzkwOGQ4OWQyM2NhOGIlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDMyMTI0MzM3Njc5MTk0JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFX
d2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPWJnU3ZuNFhxbW9LZmZ5Q0YxdjFsZFZw
dGlLTVpYZkVma3pGbkpqM0NhMFklM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
