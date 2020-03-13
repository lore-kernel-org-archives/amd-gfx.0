Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2FFC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20CC206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NI0korHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20CC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C086E9BD;
	Fri, 13 Mar 2020 13:34:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BC16E48B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDKm+m07DpKTp7mGnpRlHsV/j14EHUgUppjua4c9DuB6ZA1xbLRJu4uimOEz2lnHq0+neBWIqSuXMffHH67qzNxk9k2mfKuFiiiHpCYTJRMk4co2S8A3EPM0+PdAOYui47L+Z4cJhzihuIUfL6JtSx/yend9p9rpEOnpaTfjfJFhqkUnRCOYDbwrv67G5M9AeUyrnqpHt7dmr2ryy9k21nwYrGstsS0vlVCUCdLszk+MAnZRS/XfDEzLAyapm5IK4DUGQZm13YxSCiT5MojQ7TBsIvAfJQxOGBH9jVL7AsLluN+j9xB1pABG4QHMFlpF9PcFqTGzToWIETX+nYqJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4lZkhYJsRAAIueiUgn1VHVDzqRYdoaKNUVrCN7XXJE=;
 b=bVOmWqrFJHzEkFkXg8zrcEfxoSCjUZ2Pl9ahpI0Sv43zxxR1SFL86UmPVljSYkxAURztEPCSb6BuxOy9UT3ttAhkbi68Dp+2R/fJpafK8X/hrLTZSS45QYmd0lo7M/FdHbXmEAzxKY31P1/2umb9IcJjxaUUp6jwnZA7XWtdOhM678vWFaZ26AotF1P9C04Uuu3T7ce7VPjfsikQ7ypB84k+KK4oSmHErWGrjYMKHriyuKltuH0KFuglxZT3j8oeYlgVDl/FQHbHjnBv1oYxx8LnJIjdsle3N2ddIyxc0xSZpQNb2SY3cV8AbhmBZpjJucrJhLzAn12dJt8IlBPgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4lZkhYJsRAAIueiUgn1VHVDzqRYdoaKNUVrCN7XXJE=;
 b=NI0korHRT6ZLzTJmcY/9neJ+opBMBva4HXB+NlL8C2c/xcH4c2pdi5IU2oW/tRuU+uqS6+HdspMvJru2FFKeXpD90uUv04evI8p5DDkYd2j93NFYunVU8QD8hxpAC1BH4+JlgN5+vWYFCfCZncif4xSLsK+AIQFddJYl8ClPzmU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 13:34:49 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 13:34:49 +0000
Subject: Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200313115305.32325-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <46ae936e-d255-bf37-6491-2ff25757eac3@amd.com>
Date: Fri, 13 Mar 2020 14:34:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313115305.32325-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 13:34:48 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0f37475-aa66-4e4e-e05c-08d7c7534da0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:|DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB165880BB3913CE728AFBFDE883FA0@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(199004)(66946007)(54906003)(316002)(2906002)(66556008)(66476007)(36756003)(2616005)(8936002)(5660300002)(66574012)(81156014)(52116002)(86362001)(31696002)(81166006)(31686004)(8676002)(186003)(16526019)(4326008)(6666004)(478600001)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1658;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcTgo8gaMU/wzhmoqYdc2RpPlKccXjNFaEf+J1tqMr2YjP0otkK2o9QTJMT8lEUvqckZfxQCiLYXnLUhaoUbhH3nVaKeckEU18YFiZ6IgGjA9OoNNNmutQbMjlqDhDNolQghoUM1cvu2nm9k3tsiwCZex0lkGwKs5oaIvbhL0SB9atHMuOyjVd7It4SmRx/HMbD6RjOdJMV+N0jKRvOX26tkE+ijin1OVZ0JDCRLkyWFDO7MVDSvR94gFsaI89bqeyjUf8DHvsUPdmd7/iOMZvisZOkGREPeF6nNmUiMx1BKzJLjrbWriZVGEF1kDiRIw2bvkXuX0fVXh2/qWD4Rd/v3QM65mL5lznjY108BQtIYfXOQVgC18STgxkIgkYML4CvnF7KDgXbG76/3/KIFcL5aey2JcxgLm1jasEswRyfaDLGwbBzRKUPjS888NPrp
X-MS-Exchange-AntiSpam-MessageData: InE4CNUehW+qTlxVbdxM5ebKMsEgI3Cz5dtcfKilgxEQdFF6bqcNFP4x2y2hv9VWdIbbcA/S84XPgZm515jr4p2m24TvMqHwPM+Gf7jldFRSiSTbIf8sm+FTK/7TvTy1+IuopW0dpgbHz6dVVmRNxQrQig/YAOQh72ptk5nOH89eRkEeo5kCVMiU6WeztoQPtBto2xga5vWF2eVQM/tjqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f37475-aa66-4e4e-e05c-08d7c7534da0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:34:49.8124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McDswS9/+AkNQ/YfBiZ079mcPHG7ptaIqtTndYOkFotT3bbeRy/xgZdEpoVCfugM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDMuMjAgdW0gMTI6NTMgc2NocmllYiB4aW5odWkgcGFuOgo+IElmIGEgam9iIG5lZWQg
c3luYyB0aGUgYm8gcmVzdiwgaXQgaXMgbGlrZWx5IHRoYXQgYm8gbmVlZCB0aGUgam9iIGZlbmNl
Cj4gdG8gc3luYyB3aXRoIG90aGVycy4KClRoYXQgd29uJ3Qgd29yayBiZWNhdXNlIHRoaXMgaXMg
dGhlIHdyb25nIHJlc3Ygb2JqZWN0IDopCgpZb3UgYWRkZWQgdGhlIGZlbmNlIHRvIHRoZSBtYXBw
ZWQgQk8gYW5kIG5vdCB0aGUgcGFnZSB0YWJsZS4KCk5vIHdvbmRlciB0aGF0IHRoaXMgZG9lc24n
dCB3b3JrLApDaHJpc3RpYW4uCgo+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiBTdWdn
ZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCAgICAgIHwgNSArKysrKwo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyB8IDkgKysrKysrKysr
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gaW5kZXggYjU3MDVmY2ZjOTM1Li5jYTYwMjFiNDIwMGIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+IEBAIC0yMjYsNiAr
MjI2LDExIEBAIHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyB7Cj4gICAJICogQG51bV9k
d19sZWZ0OiBudW1iZXIgb2YgZHcgbGVmdCBmb3IgdGhlIElCCj4gICAJICovCj4gICAJdW5zaWdu
ZWQgaW50IG51bV9kd19sZWZ0Owo+ICsKPiArCS8qKgo+ICsJICogQHJlc3Y6IHN5bmMgdGhlIHJl
c3YgYW5kIGFkZCBqb2IgZmVuY2UgdG8gaXQgY29uZGl0aW9uYWxseS4KPiArCSAqLwo+ICsJc3Ry
dWN0IGRtYV9yZXN2ICpyZXN2Owo+ICAgfTsKPiAgIAo+ICAgc3RydWN0IGFtZGdwdV92bV91cGRh
dGVfZnVuY3Mgewo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm1fc2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEu
Ywo+IGluZGV4IDRjYzc4ODFmNDM4Yy4uMGNmYWM1OWJmZjM2IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4gQEAgLTcwLDYgKzcwLDggQEAgc3Rh
dGljIGludCBhbWRncHVfdm1fc2RtYV9wcmVwYXJlKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3Bh
cmFtcyAqcCwKPiAgIAo+ICAgCXAtPm51bV9kd19sZWZ0ID0gbmR3Owo+ICAgCj4gKwlwLT5yZXN2
ID0gcmVzdjsKPiArCj4gICAJaWYgKCFyZXN2KQo+ICAgCQlyZXR1cm4gMDsKPiAgIAo+IEBAIC0x
MTEsNiArMTEzLDEzIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBh
bWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPiAgIAkJc3dhcChwLT52bS0+bGFzdF9kZWxheWVk
LCB0bXApOwo+ICAgCWRtYV9mZW5jZV9wdXQodG1wKTsKPiAgIAo+ICsJLyogYWRkIGpvYiBmZW5j
ZSB0byByZXN2Lgo+ICsJICogTU0gbm90aWZpZXIgcGF0aCBpcyBhbiBleGNlcHRpb24gYXMgd2Ug
Y2FuIG5vdCBncmFiIHRoZQo+ICsJICogcmVzdiBsb2NrLgo+ICsJICovCj4gKwlpZiAoIXAtPmRp
cmVjdCAmJiBwLT5yZXN2KQo+ICsJCWRtYV9yZXN2X2FkZF9zaGFyZWRfZmVuY2UocC0+cmVzdiwg
Zik7Cj4gKwo+ICAgCWlmIChmZW5jZSAmJiAhcC0+ZGlyZWN0KQo+ICAgCQlzd2FwKCpmZW5jZSwg
Zik7Cj4gICAJZG1hX2ZlbmNlX3B1dChmKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
