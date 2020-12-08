Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD585C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC9D23AFB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC9D23AFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB63B89C6A;
	Tue,  8 Dec 2020 19:39:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC8F89C6A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxv8mumA73+noR8pAwR/6W5Nr/cQnccF9j2ap+FX1s3/rVHbONru6mswA3shkwgM/EWUNXOWmHeNo1x4/DawDhu66tIPimJH5ZeA1O1I8veb8hb7f5/hLj15sTxN7PbWPvvtVE63N81GARgWuja7wk5X4FWQaEkX9VhgzUsyVcmLQxK+VsSdic0EDh4+7nx5EZliq0BTN+N4Ar5KoBtlHTdkyF+SIUU3Elq3+GvVngsTm5JkyvsZtaJU3Mm6TvCt8KHBFYRR8OaE6vW+s23nehga1UPRoZ6k/nRhVl4m6Vt+jSXZ5QFEqg7ZYmom3jDJ2fuuwblN8Q/kAlPHX4NE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKm+Ux/+X989PMAeADNk9oqdp7fL8I4P3RIhCV8CgoQ=;
 b=J1KfnXOBl17kM0KNDwnxBJ//FgRCzrOKM6LNm3vIGR4Xslm6lwjlf22Wk5HQeq1eXOGvSrSMV1+nTTm6PoWSi5mEFYUKXa4zCToNn+Y2LQtdOLO8DVYfgsGEQRcgtXL/83v6QkUYtooJgC7HO9h8FsxliNqWIi1aLB+54zImAsDs1LOYYnLlly1/AkcBHNzc3m5oSdsmHwXwSch9OEHcD6MxzScgICPEa0kB3gYQYpKUEQos+La7krcYZq6L9jO+5JzkrOhLHYFx8f0vDSdklwEqf6x7P655z1rVz7/8Rbii0Ahk7alJ7igCAhfRSmi2Z8grYvXN9l6BXgKJfQG0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKm+Ux/+X989PMAeADNk9oqdp7fL8I4P3RIhCV8CgoQ=;
 b=hGLYZztqi3L9vLPsvoQTAM93op5RrVowD+JsyPxIat72SakjRbLlkRYEgPSJG1MDru2mWdGiQN6xcY7nOiHY+/ET25qJlTvbBsAt1MGVQHo67Y7sECETzbZKsVcdPmdlTsVW5m0Nq407XDtFVSdRuD7z6HHsafbhsIC2Lqew5wg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 19:39:36 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:39:36 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: clean up bo in vce and vcn test
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <772be2aa-56f0-14d5-3de4-343c556e1dc2@gmail.com>
 <20201208185916.4569-1-nirmoy.das@amd.com>
 <2823362e-9a76-b3f7-6d26-7143d7a8f40c@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <612b0789-81cf-4347-fc80-d5f64b7e3432@amd.com>
Date: Tue, 8 Dec 2020 20:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <2823362e-9a76-b3f7-6d26-7143d7a8f40c@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:408:e6::32) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.7.220] (165.204.84.11) by
 BN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:e6::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18 via Frontend Transport; Tue, 8 Dec 2020 19:39:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0145f9c8-b8b4-487b-a1b4-08d89bb0fea2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB431360E20CEF68F0F73069988BCD0@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZETjiVJR2r45GiU31B0wyPyaNfKZsm6xEvxUHKQSHsEQe9RagnVaqZOVgzs3QJBHXSvtDJj/yENP/2LSI13msyHMt9/zQz8IJDL46HETec8TMJJTs0qld06czhqWJ+x2bd0rFL3qjgBJJT1QmQqH6613gtsp6W4HDxcKvhjP3D8qPXfcXvZp3oLUf+63fMvXXRrdyaZ9vh43jHLeF+2FehOQZ+vwid7WuH3VDKqSXwoRz2FjhModvQTmIgDbLbSj+ecIoJtyXFn5NhLnOEEKUqn/tajLg6EigJvJ8p/VEw6ao983AdOC+yYjg8H9n4y36F22+6HejcMwzh/lBoqtaz9B2Xfk05fqxjwLH5DRmeBBDirkRdSfEQt3GeBn+bnH9sXLJMhzEs+Otw9o2ZbKcx96oPFHpRX8x+wtrIQ72rO+Bbq6kjh41RcsLZwBVue3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(6486002)(8936002)(31696002)(66574015)(110136005)(36756003)(4326008)(66946007)(66476007)(16576012)(5660300002)(83380400001)(53546011)(34490700003)(6666004)(186003)(2616005)(52116002)(508600001)(66556008)(956004)(8676002)(26005)(16526019)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2dwTGJtUEdQUk83MXFzRW1oSEluMGV3dG5reDY5czRYT1RJL2hVaEZyL2hF?=
 =?utf-8?B?ekQ3ZkZVdFJmUVYwS3NCZXYzc1NEMVA4c1JabC8rd3l3SlJQQjJ0RG5MNllz?=
 =?utf-8?B?QzU2NlR3NEp0SjJkeDIxeXd4TTVjN0UwaXBjWWNqa1kxZUhVVmtsSFlTcmhj?=
 =?utf-8?B?WWQ5Tk9wRFJSWk40MVRUVXBhVUJtbGtxYjdsR0IzMUowUDZnZ1pTVU9kSzZJ?=
 =?utf-8?B?ZXFKbllzUCtjL2xpWU1uUEp2eU42M3gwL0FLOUtGalNoNXdVSU5VNDZxQ00y?=
 =?utf-8?B?MVVoellINkIrNzY0b1ZrWlhZay9RbW54UGgxVlAybk91d2dhdzEydW9qSjB0?=
 =?utf-8?B?OTdhRzZPV2RsQW01cjhETnlVejQxcTBlYXI5Z01tV1dGeGgrN1QxTzVvaHBt?=
 =?utf-8?B?Ukx2MEU2endJTXZxMUMvY1h0MXJ3NjQ0bWhBK21MSHZFM21rOU1jQkdxWVJU?=
 =?utf-8?B?L09qVC83UDZ2SmhuNitGVUF1TDh1azRhVlNJVUk2YWU1T0R6TFAxZW8vZUVj?=
 =?utf-8?B?V0YwWE5SZmR3NHNCbVh2eEVPYndEcEMySFd5cDIvYmNzd0lwc0xaN3FwS01o?=
 =?utf-8?B?OVhabmRKT3lMZTFWK004Q1Q4cVFuZC9hdUJMdkpseXNLUE84VkV0UGMzSEZG?=
 =?utf-8?B?d0hDYTUxL0twdGlKOGxPVzBDeUROMzF0TmpFZ1ZHM0F3eXN2clgwTDhmUVhx?=
 =?utf-8?B?dEpvUUdnd2gwU25Jc3M5VFBmOFJHeWp5TmZBSmM2aC9QRGpRUm80SERTNUdv?=
 =?utf-8?B?QVlLOHh0VEllWnNRbFU1TitsaUFGVkZIMTd0UzBBVzQ4anBaaGFoVjRGSCtX?=
 =?utf-8?B?VUZRRW9nNUUvbk9ob2lwSGJtOXpsd0hwQ2hVSkdJV25OenYvWjE5RXZ1dFJU?=
 =?utf-8?B?d21hNkIzbG9lRENkUFJpd2tVaWl0QU90SFUrcnVXMVMzSVp3ckdjS085TG9l?=
 =?utf-8?B?N2dlWDIzQzc3UGRRMlFKT25KVnora2sxRmFuWUZiSVM3cDN3VWJodmh0dHFS?=
 =?utf-8?B?SnFzbW1oRkh5MnplanRBYm81cTdYUm9IRGErakRqNTZRYi9CeEdnMU1HOHM3?=
 =?utf-8?B?dEs5UEFienRwd1BlTEIwc0VrZ1ltay84eFZzWWsrVDJJYlYwMHpGMkZmR052?=
 =?utf-8?B?eWlQQjJNQStVeEhQdnI3d3BCdStGUml2MEtBM2JreVNsYm9JVHNaQW9zcHB1?=
 =?utf-8?B?U1crVUh0NUQrTXJnMzZrT2dnZ2VXK1MzbEEvdEY3TTBLWWdsMkZIMUlHK3BK?=
 =?utf-8?B?RkVic09BSmJiNnFWQXBmb2JJTS9qSi91UTgwU3JWaHZSTFBsNFdFdEE0WFpH?=
 =?utf-8?Q?ZbvHXhEG3LLXZnmo5UA5hrBrDDEYEgxDZ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:39:36.0506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0145f9c8-b8b4-487b-a1b4-08d89bb0fea2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JimstTfV5Q2KYh1xOIQzaz+y1++bYxVQIMjrKLMWUbl1JrBwbjAkEVST1wLg9q2EZBowqNDIF6b5T9s5ZY+CyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

Ck9uIDEyLzgvMjAgODowNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwOC4xMi4y
MCB1bSAxOTo1OSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEJPIGNyZWF0ZWQgd2l0aCBhbWRncHVf
Ym9fY3JlYXRlX3Jlc2VydmVkKCkgd2Fzbid0IGNsZWFuCj4+IHByb3Blcmx5IGJlZm9yZSwgd2hp
Y2ggY2F1c2VzOgo+Pgo+PiBbwqDCoCAyMS4wNTYyMThdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDcg
YXQgCj4+IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmM6NTE4IHR0bV9ib19yZWxlYXNlKzB4
MmJmLzB4MzEwIFt0dG1dCj4+IDxzbmlwPgo+PiBbwqDCoCAyMS4wNTY0MzBdIENhbGwgVHJhY2U6
Cj4+IFvCoMKgIDIxLjA1NjUyNV3CoCBhbWRncHVfYm9fdW5yZWYrMHgxYS8weDMwIFthbWRncHVd
Cj4+IFvCoMKgIDIxLjA1NjYzNV3CoCBhbWRncHVfdmNuX2RlY19zZW5kX21zZysweDFiMi8weDI3
MCBbYW1kZ3B1XQo+PiBbwqDCoCAyMS4wNTY3NDBdIGFtZGdwdV92Y25fZGVjX2dldF9jcmVhdGVf
bXNnLmNvbnN0cHJvcC4wKzB4ZDgvMHgxMDAgCj4+IFthbWRncHVdCj4+IFvCoMKgIDIxLjA1Njg0
M13CoCBhbWRncHVfdmNuX2RlY19yaW5nX3Rlc3RfaWIrMHgyNy8weDE4MCBbYW1kZ3B1XQo+PiBb
wqDCoCAyMS4wNTY5MzZdwqAgYW1kZ3B1X2liX3JpbmdfdGVzdHMrMHhmMS8weDE1MCBbYW1kZ3B1
XQo+PiBbwqDCoCAyMS4wNTcwMjRdIGFtZGdwdV9kZXZpY2VfZGVsYXllZF9pbml0X3dvcmtfaGFu
ZGxlcisweDExLzB4MzAgCj4+IFthbWRncHVdCj4+IFvCoMKgIDIxLjA1NzAzMF3CoCBwcm9jZXNz
X29uZV93b3JrKzB4MWRmLzB4MzcwCj4+IFvCoMKgIDIxLjA1NzAzM13CoCB3b3JrZXJfdGhyZWFk
KzB4NDYvMHgzNDAKPj4gW8KgwqAgMjEuMDU3MDM0XcKgID8gcHJvY2Vzc19vbmVfd29yaysweDM3
MC8weDM3MAo+PiBbwqDCoCAyMS4wNTcwMzddwqAga3RocmVhZCsweDExYi8weDE0MAo+PiBbwqDC
oCAyMS4wNTcwMzldwqAgPyBfX2t0aHJlYWRfYmluZF9tYXNrKzB4NjAvMHg2MAo+PiBbwqDCoCAy
MS4wNTcwNDNdwqAgcmV0X2Zyb21fZm9yaysweDIyLzB4MzAKPj4KPj4gU2lnbmVkLW9mZi1ieTog
TmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+Cj4gQXQgc29tZSBwb2ludCB3ZSBzaG91
bGQgcHJvYmFibHkgc3dpdGNoIHRvIHVzaW5nIGFuIFNBIEJPIGFuZCBzdG9wIAo+IHRoaXMgbWVz
cyBoZXJlLgoKCkkgd2lsbCBsb29rIGludG8gdGhpcy4KCgo+Cj4gQnV0IGZvciBub3cgdGhlIHBh
dGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIAo+IDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CgpUaGFua3MsCgpOaXJtb3kKCj4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyB8IDIgKy0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgOSArKysrKystLS0KPj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCj4+IGluZGV4IGVjYWEyZDc0ODNiMi4uNzhhNGRkOWJm
MTFmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNl
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCj4+IEBA
IC0xMTUxLDYgKzExNTEsNiBAQCBpbnQgYW1kZ3B1X3ZjZV9yaW5nX3Rlc3RfaWIoc3RydWN0IGFt
ZGdwdV9yaW5nIAo+PiAqcmluZywgbG9uZyB0aW1lb3V0KQo+PiDCoCBlcnJvcjoKPj4gwqDCoMKg
wqDCoCBkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPj4gwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZXNl
cnZlKGJvKTsKPj4gLcKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmJvKTsKPj4gK8KgwqDCoCBhbWRn
cHVfYm9fZnJlZV9rZXJuZWwoJmJvLCBOVUxMLCBOVUxMKTsKPj4gwqDCoMKgwqDCoCByZXR1cm4g
cjsKPj4gwqAgfQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+
PiBpbmRleCA3ZTE5YTY2NTY3MTUuLjkyMWI4MTA1NGMxYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+PiBAQCAtNDY1LDYgKzQ2NSw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3Zjbl9kZWNfc2VuZF9tc2coc3RydWN0IAo+PiBhbWRncHVfcmluZyAqcmluZywK
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iOwo+PiDCoMKgwqDCoMKgIHN0cnVj
dCBhbWRncHVfaWIgKmliOwo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHI7Cj4+ICvCoMKgwqAg
dm9pZCAqbXNnID0gTlVMTDsKPj4gwqDCoMKgwqDCoCBpbnQgaSwgcjsKPj4gwqAgwqDCoMKgwqDC
oCByID0gYW1kZ3B1X2pvYl9hbGxvY193aXRoX2liKGFkZXYsIDY0LAo+PiBAQCAtNDc0LDYgKzQ3
NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNfc2VuZF9tc2coc3RydWN0IAo+PiBhbWRn
cHVfcmluZyAqcmluZywKPj4gwqAgwqDCoMKgwqDCoCBpYiA9ICZqb2ItPmlic1swXTsKPj4gwqDC
oMKgwqDCoCBhZGRyID0gYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYm8pOwo+PiArwqDCoMKgIG1zZyA9
IGFtZGdwdV9ib19rcHRyKGJvKTsKPj4gwqDCoMKgwqDCoCBpYi0+cHRyWzBdID0gUEFDS0VUMChh
ZGV2LT52Y24uaW50ZXJuYWwuZGF0YTAsIDApOwo+PiDCoMKgwqDCoMKgIGliLT5wdHJbMV0gPSBh
ZGRyOwo+PiDCoMKgwqDCoMKgIGliLT5wdHJbMl0gPSBQQUNLRVQwKGFkZXYtPnZjbi5pbnRlcm5h
bC5kYXRhMSwgMCk7Cj4+IEBAIC00OTIsNyArNDk0LDcgQEAgc3RhdGljIGludCBhbWRncHVfdmNu
X2RlY19zZW5kX21zZyhzdHJ1Y3QgCj4+IGFtZGdwdV9yaW5nICpyaW5nLAo+PiDCoCDCoMKgwqDC
oMKgIGFtZGdwdV9ib19mZW5jZShibywgZiwgZmFsc2UpOwo+PiDCoMKgwqDCoMKgIGFtZGdwdV9i
b191bnJlc2VydmUoYm8pOwo+PiAtwqDCoMKgIGFtZGdwdV9ib191bnJlZigmYm8pOwo+PiArwqDC
oMKgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYm8sIE5VTEwsICh2b2lkICoqKSZtc2cpOwo+PiDC
oCDCoMKgwqDCoMKgIGlmIChmZW5jZSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgICpmZW5jZSA9IGRt
YV9mZW5jZV9nZXQoZik7Cj4+IEBAIC01MDUsNyArNTA3LDcgQEAgc3RhdGljIGludCBhbWRncHVf
dmNuX2RlY19zZW5kX21zZyhzdHJ1Y3QgCj4+IGFtZGdwdV9yaW5nICpyaW5nLAo+PiDCoCDCoCBl
cnI6Cj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4+IC3CoMKgwqAgYW1k
Z3B1X2JvX3VucmVmKCZibyk7Cj4+ICvCoMKgwqAgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZibywg
TlVMTCwgKHZvaWQgKiopJm1zZyk7Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgIH0KPj4g
wqAgQEAgLTc2MSw2ICs3NjMsNyBAQCBpbnQgYW1kZ3B1X3Zjbl9lbmNfcmluZ190ZXN0X2liKHN0
cnVjdCAKPj4gYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCkKPj4gwqAgZXJyb3I6Cj4+
IMKgwqDCoMKgwqAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2Jv
X3VucmVzZXJ2ZShibyk7Cj4+IC3CoMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZibyk7Cj4+ICvCoMKg
wqAgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZibywgTlVMTCwgTlVMTCk7Cj4+ICsKPj4gwqDCoMKg
wqDCoCByZXR1cm4gcjsKPj4gwqAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
