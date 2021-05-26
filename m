Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7AFC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 21:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABE860FEB
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 21:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE860FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690966EB86;
	Wed, 26 May 2021 21:25:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFF06EB86
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 21:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BilNsAd7K0Fs4jOa3XzDMIOl7dNijUVgFVp61l3/faDR+rGwM/MbbLNOgOMBPrw/lhA8gtChF5iwteEU6nR5YVmeylcQe8ei9/mvx5GTXyyPhXgdxGrO5XOHmdA1NF0PuJEIiD68DkKqcF05mleb9ICm1Gvtf4YkeEsBUl8IU9li80pmHseXY3TLuj4QZHVl+rNxR6YvSAqu5ZVW1/0GwQpLAQ9yL/2wArVMCOdOIDVevoDRmLOB5HALVBAvFK7K34xhC+knrsnOCx3TxmU62MCzhErGoYMuxO9tlBIQ8erYQR9KJ8+j+8ROLJcKRZ4q8/NdpmDkhJPQ05Krp2gOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJKeSanXJWJUF6fbDv8jWEw3lPad4vwhVby1JFNCnYE=;
 b=Tgo2wUSwQ5R4AIEzmmBHsvCL+ZdOf2UVoKvKS+yJvIZ0Z5jA50oSgbQ6DdMq0methw5Va0KtLnwNlWXWa4ugiNEdNaddxuXPTZwqYF33XKKTn6otlNxPk0iBIWoFsWaYImQDUBt959g6f0m8flWRFgDcKutl7sz5DYB3KF8lZsfiLjcmYsAUqtC4ZDSD0zbWCUcrEm5OGe+xN39DVVLhgXugIxDcWc7W6rwRAkm01i1r1B5g1BoVozhFOQ4mVdtjgCDl4F5Sv4qtpNFd9iGpPP+Yy5vdaYZzvNYucNNSaQzALwZgaUrGstjsvSqyZ3FU9OhDMop8Wbt0lfMX0M1Juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJKeSanXJWJUF6fbDv8jWEw3lPad4vwhVby1JFNCnYE=;
 b=ullwsy6CTh/sAakCX+ublmfSvfiNkSSN63pyCLxOejaBoNrUXoGrnwPcHMmOBhugvH3rAhsxYi9BTNqawbTna/4wq0HVHXLljUOzrS3nyPjrQIPLVutN7Ja78J66TVj1+eGbSJ4+0MexZAuf6RH6UIxDj96HG/zK3brJvOOfNPE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 21:25:16 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 21:25:16 +0000
Subject: Re: [PATCH] drm/amdkfd: move flushing TLBs from map to unmap
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
 <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
 <236a115f-7209-37ea-277a-ec86ec57f9ce@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <80a52ee7-0a94-0861-128e-ab23d209987e@amd.com>
Date: Wed, 26 May 2021 17:25:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <236a115f-7209-37ea-277a-ec86ec57f9ce@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 21:25:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb9484a-8785-4c04-5ca0-08d9208cc15f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5100A765595EFAABA875309192249@BN9PR12MB5100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LujJVX1SfLKqgRB+ZalUq1EDEHR7rCT4kxhxn8SBK2ji4DWf4mrTDir9uPFc1KkzTBJwXzCZ53434fbJYcSXu6N9v7pQC2hV2IZidVVQsxFTogjVnAJQz2JsY2ieCuLMU9fAvN8XXSRYCjDXDhvZIt9xVR134oZEKuPTYh1bPhJuWL0fOsQ3kf2WHUmYtI1N34e7O6HIivM7+yC/Rn4ACMqPaHbCFNmYHFmL8S4JU6jMzYJkdwPZjsUi/WY8PmN32Ny91YfF1f9+nfAnS5hl5D+Rw30gF7b9FUicAMYQ+yw4cuojwbRRSFRZxdJje2bRW24d0nelN/W9hWMDVHQKWCXRBTYWVXnn9FdYeIT241aTjwxnqxakcF0WkgoexQ2T8Yb1z27Kq2vR3vKO5YQgud2qP1iq++be0CeIsdE9hsug7+CDswHvhHCf1tOsBc5O5BQEnmhFxKkmpOQJtGFHtStr3rSWXbUCLau/gZkrthkto+4WJUHsqS+rB9dm80RdnLO13Zumorh2x0PDQH+VwgQO5vELhH9i4LZuTw/mlfUT4yoWDIoa/ztjcc8CWWFxFr6/RJ5vC5QA02HGr6okc+nX1Cnl9OWhjoPMrwehBr6+MGHtpXSTP9V8aChRNiaxYcSCJkSH0EB1xL9ckZjW99YHQOtdPqdOgzUEKPuztvt2vgWVsije4QVAgQSNxGCA+MBZ5smOO0Kckb9weiUVLBwZUS4qw0232PSZ/9grHRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(316002)(16576012)(2906002)(31686004)(5660300002)(8936002)(26005)(16526019)(966005)(86362001)(478600001)(36756003)(186003)(6486002)(31696002)(2616005)(956004)(53546011)(66946007)(66476007)(38100700002)(44832011)(66556008)(83380400001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y29PNjJWaWFWYm5KWjVjWEpOWkl4WURmaDFxbDhHeEpsZnA4enBoQ3hKRk5L?=
 =?utf-8?B?elZaa3ZSUmQ2cnAzWU9YYzZSMmtxMk4rZkEwSThwV3I3MC9tbldpUjRQWkpJ?=
 =?utf-8?B?dDVjWXlTcmtjSkdUSXJDMExnbkE4aEZmeDVZU1VPd1I3WDMyajdSQXIvUTdl?=
 =?utf-8?B?NUE4Z3NCYzZZVHg1dXdXUTUzQUlNdTRRdlJBVGdvaTFBSWtoVmJiUUV1RjY0?=
 =?utf-8?B?cmM3QzRkdmNxRlRRTXZ2SWc1TjliL2lpcTkrdnl4L1ZVS1RMSFZhd1o0dldQ?=
 =?utf-8?B?MkFtSEhBcnNOQnVJVUY1d0FSa1RNdlJZTEpkT3NVV1ZpWG1NLzZUMVoxVnFu?=
 =?utf-8?B?NEFKUytjdXBSMTc3dFlsc1o5OEtVMU5CQit6cnF0MDN2dGp5bUNWWlN3M1d0?=
 =?utf-8?B?dEZjQ1lGaWg3Z3g5a2ZNaUg3LzAwTDB0ZTE3L2xXYmMwM0I4NURyVTFrblpQ?=
 =?utf-8?B?M1FuVFNyZGNBY0pma0xidGdTaU0vMEFqSlpYOGdXTzNKTEFTWGhybld2bm9Q?=
 =?utf-8?B?Q0lIY3YwRWFWdEw1WTIzcmRZbE41cS9IdTdPb3g5M2ljOElmWHk3UW5yYVc2?=
 =?utf-8?B?NVRXdUM0UlJtMnZwS3pLYlE1a0RXYUI2ZkVrVCt1c04yZkRnb05UZVZQR2VC?=
 =?utf-8?B?dGhIdkN1dUxzOFNqZkU5RC9hNzVrZ2VZTVBZbUxPTzlEUkd0bERZSTg0N0NR?=
 =?utf-8?B?b3JvT0UzVDlyUWV5dGpmR3FtYXl2L3RGeXNQcHFVNWVHeVdNSDVOR3VVSk94?=
 =?utf-8?B?WXZiRGlIOFFWVUtOdVJYMGhJT0Q4R2E0cWwwcnhWcVFhZHo5SGIrbGpQZndu?=
 =?utf-8?B?VFNrb203NEQ1dGIxNG0rTXplelNZNEQvVERDOG9uOWYybTZGWUN1dUtMOFd3?=
 =?utf-8?B?OTlVVkNWMHlEV2ppa3FCT2RxRFBXNTQ3WHlpMG1LZWVUWGx2aHE5T0JJNHRV?=
 =?utf-8?B?RWpvckkwdHlVZ3R0azRjckhPN3hoWWVmWFNnTklWVVJzQnd4cDNSUlcvZ3Fn?=
 =?utf-8?B?TWV5MzFKQ3hKM01STUxPdTA3dDNsNW1ybHhYVFNGZjlQWnBKbFIyK3dpMGNO?=
 =?utf-8?B?bm1aNmVPNGN3SFk0S3A0TWRuWm4vNk1UOVNESktaVWhCbEd1N00vVmpwN3N2?=
 =?utf-8?B?T3cxTnFUYUtWd3NvakJCanVBY2dCdlh0bnloNUJiMVdJdmNmdk5mNnRpU29n?=
 =?utf-8?B?ZE9YQlREK1F4bUswbWdXaU1xd1ZjYUFxb1JQdFFxWjZaUmZPaWlQK0YrM0NZ?=
 =?utf-8?B?MFJ4eTNrTGEvYWs4WnBPak5CSU5Qa2ZlNURHbVdkSjJQR0h0RjM1Y0d2MFJw?=
 =?utf-8?B?WjJZc044L3R0WnZ5UWJ5dEUyOVl2WmJDdHVNT0xlRExxUTlYU1FpTFlkQ2sz?=
 =?utf-8?B?SlNKNWY1RU96OVBQVDA1VDRReDRjemZvcEQyMzArRUxpSXJ3WXBxTjhWSUJx?=
 =?utf-8?B?UGJIVld1cnRVVkdFaHVSc2trekl2WWdPOFdRNkJQQmVJMkNhYnd1SjdVOVp5?=
 =?utf-8?B?R0FlM2w2RlVHNXh6d1lUY1Z4ZUx1QStqWlQzZ2xFU0F4YlpVVTdjcHk3YmlB?=
 =?utf-8?B?QVFNbDM2NXErT3N0WXY3L3c2Y05VWExBR0NpU3JJdktZNWdvSU51WFBGWEZF?=
 =?utf-8?B?cCtzSHZBMlBPemZJbEdsd21BTmplMnNOa3E3OFhFMVY2czZOOVdTN2dicjJS?=
 =?utf-8?B?ei80UHJFYURnZmRwNHBOUUFzTUJCSTQ4RFRZYzdGN212dXVFcjFZR2txYUVU?=
 =?utf-8?Q?rSQg2xtut+wqFg2ugIPqa1CEaARGDbCkb/qB2cL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb9484a-8785-4c04-5ca0-08d9208cc15f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 21:25:16.3270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx4/tsVyBYpi7J57IcdW4WkqE6uAE+gfTKAwWy0nLHESBD3jPhhO/GJriPFj7ZIwuouwiOdwvhOiToV/JZdlNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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

QW0gMjAyMS0wNS0yNiB1bSAzOjIxIHAubS4gc2NocmllYiBFcmljIEh1YW5nOgo+Cj4gT24gMjAy
MS0wNS0yNSAzOjE2IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+PiBTaW1pbGFyIHRvIGEg
cmVjZW50IGZpeCBieSBQaGlsaXAgWWFuZyA3NmUwOGIzN2QwYWEgKCJkcm0vYW1kZ3B1OiBmbHVz
aAo+PiBUTEIgaWYgdmFsaWQgUERFIHR1cm5zIGludG8gUFRFIiksIHRoZXJlIG5lZWRzIHRvIGJl
IGEgY29uZGl0aW9uYWwgVExCCj4+IGZsdXNoIGFmdGVyIG1hcCwgaWYgYW55IFBERXMgd2VyZSB1
bm1hcHBlZCBhbmQgdHVybmVkIGludG8gUFRFcyBpbiB0aGUKPj4gcHJvY2Vzcy4gVGhpcyBpcyBj
dXJyZW50bHkgcmV0dXJuZWQgYnkgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nIGluCj4+IHRo
ZSAidGFibGVfZnJlZWQiIHBhcmFtZXRlci4gVGhpcyBuZWVkcyB0byBiZSBhbHNvIHJldHVybmVk
IGJ5Cj4+IGFtZGdwdV92bV9ib191cGRhdGUgYW5kIHJlcG9ydGVkIGJhY2sgdG8gS0ZELCBzbyBL
RkQgY2FuIGRvIHRoZSBUTEIKPj4gZmx1c2ggYWZ0ZXIgbWFwLCBpZiBuZWVkZWQuCj4gSSBmb2xs
b3cgdXAgeW91ciBzdWdnZXN0aW9uIHRvIGNyZWF0ZSBhbm90aGVyIHBhdGNoIChhdHRhY2hlZCkg
YW5kCj4gdGVzdCBpdC4gSXQgc2VlbXMgaXQgZG9lc24ndCBpbXByb3ZlIHRoZSBsYXRlbmN5IHdo
ZW4gbWVtb3J5IHNpemUgaXMKPiBiaWdnZXIgdGhhbiBodWdlIHBhZ2UgKDJNKSwgYmVjYXVzZSB0
YWJsZV9mcmVlZCBwYXJhbWV0ZXIgd2lsbCBhbHdheXMKPiBiZSB0cnVlIHdoZW4gbWFwcGluZyBw
YWdlIGlzIGh1Z2UgcGFnZSBzaXplLiBJIHRoaW5rIFBoaWxpcCdzIHBhdGNoIGlzCj4gdG8gZml4
IHRoZSBjYXNlIG9mIHJlbWFwcGluZyBtZW1vcnkgZnJvbSBzbWFsbCBwYWdlIHRvIGh1Z2UgcGFn
ZSBpbgo+IEhNTSwgYnV0IGl0IGRvZXNuJ3QgY29uc2lkZXIgaWYgdGhlIG1lbW9yeSBpcyByZW1h
cHBlZCBhbmQgYXJiaXRyYXJpbHkKPiBmbHVzaGVzIFRMQnMgd2hlbiBtYXBwaW5nIGh1Z2UgcGFn
ZS4KClRoYXQncyB1bmV4cGVjdGVkLiBUdXJuaW5nIGFuIGludmFsaWQgUERFIGludG8gYSB2YWxp
ZCAoaHVnZSkgUFRFIHNob3VsZApub3QgdHJpZ2dlciBhIFRMQiBmbHVzaC4KClJlZ2FyZHMsCsKg
IEZlbGl4CgoKPj4ga2ZkX2ZsdXNoX3RsYiBwcm9iYWJseSBuZWVkcyBhIG5ldyBwYXJhbWV0ZXIg
dG8gZGV0ZXJtaW5lIHRoZSBmbHVzaAo+PiB0eXBlLiBUaGUgZmx1c2ggYWZ0ZXIgbWFwIGNhbiBi
ZSBhICJsZWdhY3kiIGZsdXNoICh0eXBlIDApLiBUaGUgZmx1c2gKPj4gYWZ0ZXIgdW5tYXAgbXVz
dCBiZSBhICJoZWF2eS13ZWlnaHQiIGZsdXNoICh0eXBlIDIpIHRvIG1ha2Ugc3VyZSB3ZQo+PiBk
b24ndCBldmljdCBjYWNoZSBsaW5lcyBpbnRvIHBhZ2VzIHRoYXQgd2Ugbm8gbG9uZ2VyIG93bi4K
Pj4KPj4gRmluYWxseSwgaW4gdGhlIHRpY2tldCBJIHRob3VnaHQgYWJvdXQgcG9zc2libGUgb3B0
aW1pemF0aW9ucyB1c2luZyBhCj4+IHdvcmtlciB0byBtaW5pbWl6ZSB0aGUgaW1wYWN0IG9mIFRM
QiBmbHVzaGVzIG9uIHVubWFwIGxhdGVuY3kuIFRoYXQKPj4gY291bGQgYmUgYSBmb2xsb3cgdXAg
Y29tbWl0Lgo+IEl0IGlzIGEgZ29vZCBpZGVhIHRvIHVzZSB3b3JrZXIsIGJ1dCBob3cgZG8gd2Ug
Z3JhbnRlZSBpdCBkb25lIGJlZm9yZQo+IG1lbW9yeSBpcyByZW1hcHBlZD8gaWYgcmVtYXBwaW5n
IGRlcGVuZHMgb24gaXQsIHRoZW4gbW9yZSBsYXRlbmN5IHdpbGwKPiBiZSBpbnRyb2R1Y2VkIGlu
IG1hcC4KPgo+IFJlZ2FyZHMsCj4gRXJpYwo+PiBSZWdhcmRzLAo+PiDCoMKgIEZlbGl4Cj4+Cj4+
Cj4+IEFtIDIwMjEtMDUtMjUgdW0gMTo1MyBwLm0uIHNjaHJpZWIgRXJpYyBIdWFuZzoKPj4+IEl0
IGl0IHRvIG9wdGltaXplIG1lbW9yeSBhbGxvY2F0aW9uIGxhdGVuY3kuCj4+Pgo+Pj4gU2lnbmVk
LW9mZi1ieTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPj4+IGluZGV4IDk2MDkx
M2EzNWVlNC4uYWI3Mzc0MWVkYjk3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NoYXJkZXYuYwo+Pj4gQEAgLTE2NTcsMjAgKzE2NTcsNiBAQCBzdGF0aWMgaW50IGtm
ZF9pb2N0bF9tYXBfbWVtb3J5X3RvX2dwdShzdHJ1Y3QKPj4+IGZpbGUgKmZpbGVwLAo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBzeW5jX21lbW9yeV9mYWlsZWQ7Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Cj4+PiAtwqDCoMKgwqDCoMKgIC8qIEZsdXNoIFRMQnMg
YWZ0ZXIgd2FpdGluZyBmb3IgdGhlIHBhZ2UgdGFibGUgdXBkYXRlcyB0bwo+Pj4gY29tcGxldGUg
Ki8KPj4+IC3CoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFyZ3MtPm5fZGV2aWNlczsgaSsr
KSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZWVyID0ga2ZkX2RldmljZV9i
eV9pZChkZXZpY2VzX2FycltpXSk7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoV0FSTl9PTl9PTkNFKCFwZWVyKSkKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBlZXJfcGRkID0ga2ZkX2dldF9wcm9jZXNzX2RldmljZV9kYXRhKHBlZXIsIHApOwo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT05fT05DRSghcGVlcl9wZGQp
KQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRp
bnVlOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFhbWRncHVfcmVhZF9s
b2NrKHBlZXItPmRkZXYsIHRydWUpKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAga2ZkX2ZsdXNoX3RsYihwZWVyX3BkZCk7Cj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3JlYWRfdW5sb2NrKHBl
ZXItPmRkZXYpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gLcKgwqDC
oMKgwqDCoCB9Cj4+PiAtCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGtmcmVlKGRldmljZXNfYXJyKTsK
Pj4+Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX2tmZF9tYXBfbWVtb3J5X3RvX2dwdV9lbmQo
cCwKPj4+IEBAIC0xNzY2LDYgKzE3NTIsNyBAQCBzdGF0aWMgaW50Cj4+PiBrZmRfaW9jdGxfdW5t
YXBfbWVtb3J5X2Zyb21fZ3B1KHN0cnVjdCBmaWxlICpmaWxlcCwKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfcmVhZF91bmxvY2socGVl
ci0+ZGRldik7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byB1bm1hcF9tZW1vcnlfZnJvbV9ncHVfZmFpbGVkOwo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2ZkX2ZsdXNoX3RsYihwZWVyX3BkZCk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhbWRncHVfcmVhZF91bmxvY2socGVlci0+ZGRldik7Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhcmdzLT5uX3N1Y2Nlc3MgPSBpKzE7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgIH0KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
