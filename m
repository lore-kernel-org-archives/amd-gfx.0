Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F49C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 18:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9602208FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 18:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="drpXOwJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9602208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8956F494;
	Wed,  9 Sep 2020 18:34:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1A66F494
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 18:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWbHIP0Q+nvkQFir58/m6jDepCnj+RkM1R/NYvxh3yDetcx8RTFXfPRVrUq9LSTitJtP2hQhZUtJjAcyrzQV8xWsTcuUgElhbXUDAOFqcqZcHrOIvNNatM4KhB4Y9JsCldTHds4Wt9pBB320Z0AV947HRVVVPTLKgUCRFozlq3zbPFJHPXTiFUTeieIFOmwHt3aOtQnDX3EPjRxdIsZnW5Wryb2U2mqiRnlq6gMFAy/2SnJZpmjKlxCySG4/6mE8viDIn7DAOc1pxiPmniD2a1N5W6hcFCMSknsplN5NsTgetgFRg2FNxFPHrHTjMdX5HlPs/dt17W048yhRLWekbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PuwGecKs7VRp4x0murK6T3dUsNR2KoBR8b23ebqKhM=;
 b=OOP8SvvvdIOI8ZMsrgevYEDCHWAzl6nSqNZEULnbV6QDlTx2OrwhQAAsnV/TCkSwyxnoBAoXzBYuAP9tU2ojLKNBVjIxoMf2PtuKvFHpFDplQQyCqy9gnMoWoDlqWEaeYmbKZCrJ5M2GDYSQBDb9WdFnpDkobtun0eVTnQv59TGr5gIGXW8ArhWr3/2OI+vUYgZ4J17NUQyBKCSGDw2lQNAamtAWZ2C/+kbpaBZF+F6btI1t8GHZ9aoQeUk9blmr0SgPVJcrmnk59Suc4czE8nwz1l1h8neMIjVmZWWdAxPQxxkhEpjzoSA9OhMAdk2NcJHytbG+6o9DX/B5nv9U1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PuwGecKs7VRp4x0murK6T3dUsNR2KoBR8b23ebqKhM=;
 b=drpXOwJfNPRLMz1e41ADO0/YZwJQ3nKmrhvzxsdWKxJDvo13gKrANwWvXfPXI2htEu4Lc7H7AMrL6l4+jydDiV6IPGSNHUgg4/nba6jUq0h1BefothK9Q7/4fG/c244x15g3fOSTSDIWvx2zdjWPsQpXB0aeq5/vaTXi9XH8hZU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:34:17 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 18:34:17 +0000
Subject: Re: [PATCH] drm/amdgpu: Do gpu recovery when no job is running
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200909085604.804266-1-ChengZhe.Liu@amd.com>
 <073b3317-e635-99cd-1ba7-039d8810d8ce@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <fba65e75-676a-3902-b061-36f009f72419@amd.com>
Date: Wed, 9 Sep 2020 14:34:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <073b3317-e635-99cd-1ba7-039d8810d8ce@amd.com>
Content-Language: en-GB
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 18:34:16 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ba6c05a-ffd8-407a-0c26-08d854eef58b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26176B5298B47AC7824CD03F99260@DM6PR12MB2617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIgcgkwg5VlDrufKwjm0qiEUB0/yJ1/xR5++cYrqCf9UOaoWqswCMB1sOCyRi3oV5sruhMGvREPmj/EVZ9zDW1TmrpGm2gStyFsTr/1KRa4R/1jfOk8l6/8WRupLdS81lQECfMbRvPQzVWsFfVOwNvCN2c8Ei9y/EuNY2OXXQkMEDRB6UfYODE7vwfPlCG8FroR5dNotRdmyqNRJi3h65CYIiYoB7dh7eBvkA2Fdhi+HTnlKybnJ2oDx9ko/TndNy8fI0vtwwcY/jqYKaazzh37cPB/F8Eda2gWPBSMnmmBFSzCCz77+2F7pBcYDbNtnRNxvdX/EWwW6nzsy4tTXo+4ivb01KQKnavV4W9Bfz2PLbT4OBnkwxM9zQNiL1lpM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(5660300002)(52116002)(44832011)(478600001)(53546011)(6506007)(316002)(186003)(16526019)(31696002)(26005)(6486002)(8676002)(6512007)(2906002)(86362001)(2616005)(8936002)(66574015)(83380400001)(956004)(66556008)(66946007)(4326008)(66476007)(31686004)(36756003)(54906003)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6fwBu081qxxzAt0LtwzNRV8F3paV0EqCYjNmiaVoLznOTLtSyKBwCcXxYxSh8xKFS28VFJH8kZBUmX7u8Nd5m/yf0dluRrjcGhIx/cHUn1mwPWoDAiGNPfDHcxUBW611FfDl7nDUvkBnTR7gNV0RuMVbmyPnGmJh0P/dFnYBsprZoWTG+WfubqWuk3zyizplWWrb1yTRYlNO2ecBJ6JkOqoRM8OGxk9HnqAMVboSD5MupnV6whjsAejHhOIwHit7P8bVdZfgNMv6vftX9wxezM9AeE+qZRLmEfi/tSjwzSPuOTpJF5S4ZYBAg6a4YdU03V7nmhvySaYlArfiza9GlNfOSMh0keCC030zcZItCZ6RzQ+NSlL7PzEZmzmZ1vneaQyv7tBdY1+i8EVEB9F3MUPkwgrbP86aaurcCw1nodON0Iji9YQACVri32jSdzl7J6z3Zl5siCO06TPxjJ658G1amom812dWX8dcfxZWo/xutlPZ7pVLYJ8SfRO3Nu7XO8I84sACE88W7WBoo33GqQDk/zOxl7hdFWe5SM1r/ObO1cjqvkB7W7vp9fMzJ2Dq1zTDGAA5Pwk7M+8+LcJ/xkbbG2kDsCA+DWkPX2JK+KAEk6fCv+C5gPwT/hraSbsFRDIEMqJhphpUz4tcsP14fw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba6c05a-ffd8-407a-0c26-08d854eef58b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:34:17.3754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d73wK0LpR7gEINNgbThH3tlU5QRn2KU8c7Df8pAwzTypgHBamFQAnI/74oXajvjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOS0wOSA1OjEzIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDku
MDkuMjAgdW0gMTA6NTYgc2NocmllYiBMaXUgQ2hlbmdaaGU6Cj4+IEluIGZ1bmN0aW9uIGZscl93
b3JrLCBkbyBncHUgcmVjb3Zlcnkgd2hlbiBubyBqb2IgaXMgcnVubmluZwo+PiBpbnN0ZWFkIG9m
IHdoZW4gc29tZSBqb2IgaXMgcnVubmluZy4gQmVjYXVzZSBpZiB0aGVyZSBpcyBqb2IKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeYQo+
PiBpbiBsaXN0LCBhbWRncHVfam9iX3RpbWVkb3V0IHdpbGwgZG8gdGhlIGdwdSByZWNvdmVyeS4K
ICAgICBedGhlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5yZW1vdmUgInRoZSIuCgpU
byBiZWNvbWU6ICJpcyBhIGpvYiBpbiB0aGUgbGlzdCIsIGFuZCAid2lsbCBkbyBHUFUgcmVjb3Zl
cnkuIgoKPiAKPiBNYXliZSB3cml0ZSBzb21ldGhpbmcgbGlrZSAiRml4IHRoZSBsb2dpYyBieSBp
bnZlcnRpbmcgaXQiLgoKWW91ciBjb21taXQgbWVzc2FnZSBpcyBmaW5lLCBidXQgYXMgQ2hyaXN0
aWFuIHBvaW50ZWQgb3V0LApfYWRkXyBhIHNlbnRlbmNlIHRvIHRoZSBjb21taXQgbWVzc2FnZSwg
cG9zc2libHkgaW4gYSBuZXcKcGFyYWdyYXBoLCBzaW1wbHkgc3RhdGluZyB0aGF0IHlvdSdyZSBp
bnZlcnRpbmcgdGhlIGxvZ2ljLApwb3NzaWJseSBqdXN0IGN1dHRpbmcgYW5kIHBhc3Rpbmcgd2hh
dCBoZSB3cm90ZSBhYm92ZS4KClJlZ2FyZHMsCkx1YmVuCgo+IAo+IFdpdGggdGhhdCB0aGUgcGF0
Y2ggaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KPiAKPj4KPj4gU2lnbmVkLW9mZi1ieTogTGl1IENoZW5nWmhlIDxDaGVuZ1poZS5MaXVAYW1k
LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyB8
IDMgKystCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfbnYuYyB8IDIgKy0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jCj4+IGluZGV4IDljMDcwMTRkOWJk
Ni4uZjVjZTlhOWY0Y2Y1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV9haS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2Fp
LmMKPj4gQEAgLTI2Miw3ICsyNjIsOCBAQCBzdGF0aWMgdm9pZCB4Z3B1X2FpX21haWxib3hfZmxy
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+PiAgIAo+PiAgIAkvKiBUcmlnZ2VyIHJl
Y292ZXJ5IGZvciB3b3JsZCBzd2l0Y2ggZmFpbHVyZSBpZiBubyBURFIgKi8KPj4gICAJaWYgKGFt
ZGdwdV9kZXZpY2Vfc2hvdWxkX3JlY292ZXJfZ3B1KGFkZXYpCj4+IC0JCSYmIChhbWRncHVfZGV2
aWNlX2hhc19qb2JfcnVubmluZyhhZGV2KSB8fCBhZGV2LT5zZG1hX3RpbWVvdXQgPT0gTUFYX1ND
SEVEVUxFX1RJTUVPVVQpKQo+PiArCQkmJiAoIWFtZGdwdV9kZXZpY2VfaGFzX2pvYl9ydW5uaW5n
KGFkZXYpIHx8Cj4+ICsJCWFkZXYtPnNkbWFfdGltZW91dCA9PSBNQVhfU0NIRURVTEVfVElNRU9V
VCkpCj4+ICAgCQlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKGFkZXYsIE5VTEwpOwo+PiAgIH0K
Pj4gICAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X252
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9udi5jCj4+IGluZGV4IDljMjNh
YmY5YjE0MC4uNjY2ZWQ5OWNjMTRiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9teGdwdV9udi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214
Z3B1X252LmMKPj4gQEAgLTI4Myw3ICsyODMsNyBAQCBzdGF0aWMgdm9pZCB4Z3B1X252X21haWxi
b3hfZmxyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+PiAgIAo+PiAgIAkvKiBUcmln
Z2VyIHJlY292ZXJ5IGZvciB3b3JsZCBzd2l0Y2ggZmFpbHVyZSBpZiBubyBURFIgKi8KPj4gICAJ
aWYgKGFtZGdwdV9kZXZpY2Vfc2hvdWxkX3JlY292ZXJfZ3B1KGFkZXYpCj4+IC0JCSYmIChhbWRn
cHVfZGV2aWNlX2hhc19qb2JfcnVubmluZyhhZGV2KSB8fAo+PiArCQkmJiAoIWFtZGdwdV9kZXZp
Y2VfaGFzX2pvYl9ydW5uaW5nKGFkZXYpIHx8Cj4+ICAgCQlhZGV2LT5zZG1hX3RpbWVvdXQgPT0g
TUFYX1NDSEVEVUxFX1RJTUVPVVQgfHwKPj4gICAJCWFkZXYtPmdmeF90aW1lb3V0ID09IE1BWF9T
Q0hFRFVMRV9USU1FT1VUIHx8Cj4+ICAgCQlhZGV2LT5jb21wdXRlX3RpbWVvdXQgPT0gTUFYX1ND
SEVEVUxFX1RJTUVPVVQgfHwKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
