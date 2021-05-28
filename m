Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B0DC2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E079611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E079611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109ED6F5D6;
	Fri, 28 May 2021 14:58:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1243F6F5D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 14:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwOWy1VWSEI1rqNpeH9fvRHG1qnhjeFgpaqwg1n24DN5l7Ah2WSkxUfBnEsEzVIGsF3KAPvIk8xmUSYr4bidEzH4l/TZDngzWSd2gtJ51y1x64YDEqwAkvAQFqV+/LozUH0zI4kzi1A559BNY7Upp90hwZfpsTuIgjL3cFhVnMVJSm80WBt87NQKkANL3y7bh1tIyhJWOaCPXMHNKC9uiwkvJ0v4ayPtSLoCpByGJ5CqE04h3POJRe/WPNLsOKa5zKyDWOcqx1oNVi6SMUnde3C365R3l9cmH4ftcQOh8vi2HIbQFi9Uxa2W6gqGzbGuvUQp963oimHDVjPWboQ1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgyTI5bYMqwKKTlccBBmKH7fIJnzMrr0DFGMLlI/xdU=;
 b=NJWsQO0g/4eSJwNclYh7glicWCUqxh5xE49vRtBq1AQ8QM87eOwrEqb5S92L24ZqLUQjTUtC71QtyncWw8uu4XcezDGrZmQpPkBYpXzXpEvsHHQugUhzoi1TMeYaOaDhgNY93FaPK4q2r7h0rn03KrAcOsGRTqOOvVZTJg/QBmMHQWf1HXiY8vlJGviGoW5LOznKFaeIbq3nZp9Td6Gb0sswzkudEeGyj4bbOIcp8Orquk46x4xxJoc6HcYZ8eP/wdXMfJCT1hNo4O/59NN/HG84WfBQ605/Zow8iJyCUO46ALwxkfSPov+7iY8XWhGq/vSU0M+bl9SBxA7Yto4F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgyTI5bYMqwKKTlccBBmKH7fIJnzMrr0DFGMLlI/xdU=;
 b=y7H083VdslslQgqotd3GKn/WmH0RTUXvibVFDX+QCqa/IVMCrGiivBOWrGOicZ/k9Zwxlk892UiJwbqK7QPgfKRGbAnXL+u17KZGnixGYxxQpCzTMUDRL+INOu7XXd5MFF7JFgF1ceYcCTGaCmhDIqz63PI7bMpFq7x5lQLMx94=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 14:58:33 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 14:58:33 +0000
Subject: Re: [PATCH v2 6/6] drm/amdgpu: do not allocate entries separately
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210528105623.28148-1-nirmoy.das@amd.com>
 <20210528105623.28148-6-nirmoy.das@amd.com>
 <ae7ac2b1-a819-fde7-8c03-3d8e79cd7cc8@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <41fcd8e6-0697-4d5e-cbec-980a9a20820f@amd.com>
Date: Fri, 28 May 2021 16:58:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <ae7ac2b1-a819-fde7-8c03-3d8e79cd7cc8@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f21:6900:10f4:3065:5814:d1ee]
X-ClientProxiedBy: PR0P264CA0264.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::36)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f21:6900:10f4:3065:5814:d1ee]
 (2003:c5:8f21:6900:10f4:3065:5814:d1ee) by
 PR0P264CA0264.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 14:58:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5253881-81e6-4d02-4dd5-08d921e91079
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5056DAE8A6EBAE8E8A062A878B229@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Gd6kPyC9y+XFTW8rYbI7r6/BoYRO+cGfCddU4qEiYkrmclx5cI6y4flYOAop3I9dW/abP7I0KmLBu3GKv3C6ylPP+z9hAmFNtmKHk1SlVDxOIKZQWygM5obZbGYCNrqBtVrSYoGnjNaflV722QNyQyh0J6xJwbwXedgWI0IwfC9LX19ZYXEra3jla6PiVGxmOI05q2kbd4GcnCYXaab4fa0nHLslKtig5+nBoS3dO22kcWIlIGFcyrg1VrzmbdDSonCXhlbMo/fAmdgcfJ3OLDgki3k3BuME3qaL9UCiepH6y265Wj/eVI5jOPHqJPKmLM78T4qb9LVp3qgBeLY0xTCDnVXocpuApwukarzXM9qHAGX/zYwnjSbhLKGDPbF9H5QsvyyY59TNxgiAWRCvL+3RdOS4iwfUiEMG6C0zl7oYp+EG/vfkPsRsnXkshpKF63RKx5MYR//qrPIycF79hhOAJaQRW2i6qqif7hkgurCJjur4kbheMq0KcNqrtigWMWPuI/zWqyZrWJUAhAIk2tVzf29ltu3XF01AfgfyYsQa38FfckhDdBh7eCwo7J62wNmDSH8ThphphglpbzcErDTMxMuSCgpa3n9Gdn/jMzsqMrjHyb5+cxqW3HlNR+2C4iDId336dndiRQlU7Mp+2hWUxEmqul7zqEgxno0FZnQwLsBh4UV4KVOqxsf2dg5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(83380400001)(478600001)(86362001)(66574015)(2906002)(8676002)(31696002)(8936002)(316002)(38100700002)(31686004)(186003)(16526019)(5660300002)(66476007)(66556008)(66946007)(2616005)(6486002)(6666004)(53546011)(36756003)(52116002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkhueXNRZWpJTVM5STZlLzhJUVVTeFRWb1JCc2JEQ2wzd3dFWnJTLzNveDY4?=
 =?utf-8?B?U2ZpbW93RFFvWk00Tjk0OUJIYkF4alVuRHFXbmV5c1d3ZTl3NGVxekJEa2h6?=
 =?utf-8?B?QzViVXJEZmQ2R2hBdHNLTHRpMWVabTZ6dnI5dVY0SHFDTCtnM2hoZzY5M3o3?=
 =?utf-8?B?QUtXWlN6ZHgwTkJBWCtIWXExNlo4eTFQanlUSnpmdmF1M0sxc2ZpOXE0aU1m?=
 =?utf-8?B?aUt6SHBqWndkZkpoR2gxS3Q2NzAyRzZCK0xkZmxYdTZ4TGV6ck1Yek1rZDZy?=
 =?utf-8?B?UkpuRjcrZmN1clg5NFZBa3I1Z2Jiam5MODc0Zi9zSkhWem5UeWRqVFNSVWRk?=
 =?utf-8?B?ZHlyRUp5NU0zNjhuaXBqb3k3MVlaalFLVFlSR2NtempuV3MvQ3JzRzc0ZFpO?=
 =?utf-8?B?S0Z0dzlGRWFKRGxrZ3QzMU53SVN6N203THNCby9DMFpUQmpHaGIzeXFKZVg4?=
 =?utf-8?B?T0lCVVhYY2dOY3dtSUladEZEZEF6VG9nUHNSblo5dkRaSWhXQlBnbXphaEgv?=
 =?utf-8?B?L3VKejNQTkx1RHNLUTkvcVdFY3UrWWNZSUVWeVY4VWwxQ1NjaUh1bzVTRUV4?=
 =?utf-8?B?M2pLdnVKb2gzbHZ6dzRTRkJ2anJHajcyeUtnZ0d6SUVlUkpGaW9PSGhTRjZD?=
 =?utf-8?B?U1VMWEJlcVo3ZWlnTk9FOU5Da3g3RHhXOEd0bUIwZmJvZkhvUGxEVFF4Z0pR?=
 =?utf-8?B?QVRGZTFZMEFKM2JjSHhyT3dYeG9jTSs0NXVLWUU2YTZEd0RnT0dTM2ZpM1dR?=
 =?utf-8?B?OEhvdEo3WFR4azBEMWVlTW5QNUxSTmZSV1hKYUNZUUZhTXY2Z3JGQTllRUs2?=
 =?utf-8?B?ZU5kK1RrVWVsdkpWL0poVVZ6NGh5Zis1TXRZVlpSRXZCWjNxcjByTExmbFBo?=
 =?utf-8?B?eDFvbXkvL096aDJRbFluU1VhcVphUmJ3cG9CL1B3TW9pcGF3UitFYnNmVWpV?=
 =?utf-8?B?cEpsaHFrS3NBb0RMUlhQMm0yczlTK0VRazhSK0JGSlNsbEkwc1ZJck9tK2JO?=
 =?utf-8?B?cWpyQy8vRDZXc0FUZHRwWU0yR1dGOFRoQzJJczRoY0M2UkxGWVBqSHFMYVZ0?=
 =?utf-8?B?YWZ4aTN3NlFaVFNCNHRsTnU1VkcxcWZZSnJmVEVIMmJEZVZzczlETFBLbGJR?=
 =?utf-8?B?dFVvbzJvK1RzOU5vZjh2RkVuU3JqajA3SEVCU091K2NzVlVnT2pBS2k1N29i?=
 =?utf-8?B?Nm9TVHZKcGNnR3ROR2x1TkE5NjF0a3EzVzh2SThYUGhuQTA4SFZYcVk4b3FE?=
 =?utf-8?B?UFplUUpBSjdJTXRMNGt2alhsTUpaZm5uUzdUSm1JNWdIQ255WnpnLzhqSmo2?=
 =?utf-8?B?b0F5ZHprWnlibzlPcVZNTXBNcEZNSXhLV1c1TG9YRmNDOEF0WmpTS1YwRDE4?=
 =?utf-8?B?NnE2T3Z0emdITjRCRnFjZmtmK09YK25wUjg4SGdhMldMdWtITmFhVEk0dEhl?=
 =?utf-8?B?MGZKRXFGcDJwZXNCQnFBc1JnM01ST3hKeVIyZ3JnaEpKZmZNd0lqMGF6eVlM?=
 =?utf-8?B?SWZLcmJ0cmlQeGpPbjNZTEdEUUJRYXdTOGFSRkkrT05UV0xSWjJaR2ZOa1VU?=
 =?utf-8?B?UEhFSHNOSFkwcmx0cDJ0Y2dkZ0dES0xrdWQvTmpyWWZpMmdCU3JwVzMxSGd0?=
 =?utf-8?B?RmhxRXV5TnpSaCs3bnRGOFg1bEhidHY4bVE2S0RJVEw4L0lJRmJ1NHVMSnVD?=
 =?utf-8?B?Wlc1aDIxTGdqYnEwWG9LYnpXMU8zVUpCaGFKM0J3aTFPNVRzTUtncHBVc1Zl?=
 =?utf-8?B?bi9wYSs5UitIakVTMGhPVnM1TjlPUkJmWHk0TWdwNXRNM0IyVHRyWVRHVVhw?=
 =?utf-8?B?WUtoUVdQUzgxVm1KaW12MEpVOTdhR3BVTnJWRkZ5dGI4R0t3ekZVejNIdzNt?=
 =?utf-8?Q?GexNRY1+IZVLt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5253881-81e6-4d02-4dd5-08d921e91079
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 14:58:33.8212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcnKoZnGzfoFVQ27d2+LF5Zd4XNbUyxSN+S9NKVk3/nB2jmOJr7vTjXnVwV9q3mQ02JWLUz1nqJRlEJViqWy5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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

Ck9uIDUvMjgvMjAyMSA0OjA5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAy
OC4wNS4yMSB1bSAxMjo1NiBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEFsbG9jYXRlIFBEL1BUIGVu
dHJpZXMgd2hpbGUgYWxsb2NhdGluZyBWTSBCT3MgYW5kIHVzZSB0aGF0Cj4+IGluc3RlYWQgb2Yg
YWxsb2NhdGluZyB0aG9zZSBlbnRyaWVzIHNlcGFyYXRlbHkuCj4+Cj4+IHYyOiBjcmVhdGUgYSBu
ZXcgdmFyIGZvciBudW0gZW50cmllcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAzNCArKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAKPj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBpbmRleCAyMjNjNjMzNDJlY2Qu
LjdlNDc4ZmZiN2ZkZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPj4gQEAgLTg3Nyw2ICs4NzcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9wdF9jcmVhdGUo
c3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRn
cHVfYm8gKmJvOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdjsKPj4gwqDCoMKg
wqDCoCBpbnQgcjsKPj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXM7Cj4KPiBNb3Zl
IHRoYXQgYSBtb3JlIHVwLCB2YXJpYWJsZXMgbGlrZSByIGFuZCBpIHNob3VsZCBiZSBhbHdheXMg
ZGVjbGFyZWQgCj4gbGFzdC4KPgoKVGhhbmtzLCBJIHdpbGwga2VlcCB0aGlzIGluIG15IG1pbmQg
bmV4dCB0aW1lLgoKCj4gQXBhcnQgZnJvbSB0aGF0IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiBOZXh0IHN0ZXAgc2hvdWxkIHByb2Jh
Ymx5IGJlIHRvIHJlbW92ZSBlbnRyeS0+ZW50cmllcy4KCgpSaWdodCwgSSB3aWxsIGRvIHRoYXQu
CgoKUmVnYXJkcywKCk5pcm1veQoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IMKg
wqDCoMKgwqAgbWVtc2V0KCZicCwgMCwgc2l6ZW9mKGJwKSk7Cj4+Cj4+IEBAIC04ODYsNyArODg3
LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3B0X2NyZWF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgYnAuZG9tYWluID0gYW1kZ3B1X2JvX2dldF9wcmVm
ZXJyZWRfcGluX2RvbWFpbihhZGV2LCBicC5kb21haW4pOwo+PiDCoMKgwqDCoMKgIGJwLmZsYWdz
ID0gQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VTIHwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQzsKPj4gLcKgwqDCoCBicC5ib19wdHJf
c2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvX3ZtKTsKPj4gKwo+PiArwqDCoMKgIGlmIChs
ZXZlbCA8IEFNREdQVV9WTV9QVEIpCj4+ICvCoMKgwqDCoMKgwqDCoCBudW1fZW50cmllcyA9IGFt
ZGdwdV92bV9udW1fZW50cmllcyhhZGV2LCBsZXZlbCk7Cj4+ICvCoMKgwqAgZWxzZQo+PiArwqDC
oMKgwqDCoMKgwqAgbnVtX2VudHJpZXMgPSAwOwo+PiArCj4+ICvCoMKgwqAgYnAuYm9fcHRyX3Np
emUgPSBzdHJ1Y3Rfc2l6ZSgoKnZtYm8pLCBlbnRyaWVzLCBudW1fZW50cmllcyk7Cj4+ICsKPj4g
wqDCoMKgwqDCoCBpZiAodm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSkKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGJwLmZsYWdzIHw9IEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7Cj4+
Cj4+IEBAIC05NTcsMTkgKzk2NSwxNCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMo
c3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRn
cHVfYm9fdm0gKnB0Owo+PiDCoMKgwqDCoMKgIGludCByOwo+Pgo+PiAtwqDCoMKgIGlmIChjdXJz
b3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQiAmJiAhZW50cnktPmVudHJpZXMpIHsKPj4gLcKgwqDC
oMKgwqDCoMKgIHVuc2lnbmVkIG51bV9lbnRyaWVzOwo+PiAtCj4+IC3CoMKgwqDCoMKgwqDCoCBu
dW1fZW50cmllcyA9IGFtZGdwdV92bV9udW1fZW50cmllcyhhZGV2LCBjdXJzb3ItPmxldmVsKTsK
Pj4gLcKgwqDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0ga3ZtYWxsb2NfYXJyYXkobnVtX2Vu
dHJpZXMsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNpemVvZigqZW50cnktPmVudHJpZXMpLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7Cj4+IC3CoMKgwqDC
oMKgwqDCoCBpZiAoIWVudHJ5LT5lbnRyaWVzKQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVOT01FTTsKPj4gLcKgwqDCoCB9Cj4+IC0KPj4gLcKgwqDCoCBpZiAoZW50cnktPmJh
c2UuYm8pCj4+ICvCoMKgwqAgaWYgKGVudHJ5LT5iYXNlLmJvKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAoY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9WTV9QVEIpCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVudHJ5LT5lbnRyaWVzID0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0b19hbWRncHVfYm9fdm0oZW50cnktPmJhc2UuYm8pLT5lbnRyaWVzOwo+PiArwqDCoMKgwqDC
oMKgwqAgZWxzZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IE5V
TEw7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gK8KgwqDCoCB9Cj4+Cj4+IMKg
wqDCoMKgwqAgciA9IGFtZGdwdV92bV9wdF9jcmVhdGUoYWRldiwgdm0sIGN1cnNvci0+bGV2ZWws
IGltbWVkaWF0ZSwgJnB0KTsKPj4gwqDCoMKgwqDCoCBpZiAocikKPj4gQEAgLTk4MSw2ICs5ODQs
MTAgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4gYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBwdF9ibyA9ICZwdC0+Ym87Cj4+IMKgwqDCoMKgwqAg
cHRfYm8tPnBhcmVudCA9IGFtZGdwdV9ib19yZWYoY3Vyc29yLT5wYXJlbnQtPmJhc2UuYm8pOwo+
PiDCoMKgwqDCoMKgIGFtZGdwdV92bV9ib19iYXNlX2luaXQoJmVudHJ5LT5iYXNlLCB2bSwgcHRf
Ym8pOwo+PiArwqDCoMKgIGlmIChjdXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQikKPj4gK8Kg
wqDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0gcHQtPmVudHJpZXM7Cj4+ICvCoMKgwqAgZWxz
ZQo+PiArwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPSBOVUxMOwo+Pgo+PiDCoMKgwqDC
oMKgIHIgPSBhbWRncHVfdm1fY2xlYXJfYm8oYWRldiwgdm0sIHB0LCBpbW1lZGlhdGUpOwo+PiDC
oMKgwqDCoMKgIGlmIChyKQo+PiBAQCAtMTAxMCw3ICsxMDE3LDYgQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X3ZtX2ZyZWVfdGFibGUoc3RydWN0IAo+PiBhbWRncHVfdm1fcHQgKmVudHJ5KQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZzaGFkb3cpOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5ibyk7Cj4+IMKgwqDCoMKgwqAgfQo+
PiAtwqDCoMKgIGt2ZnJlZShlbnRyeS0+ZW50cmllcyk7Cj4+IMKgwqDCoMKgwqAgZW50cnktPmVu
dHJpZXMgPSBOVUxMOwo+PiDCoCB9Cj4+Cj4+IC0tIAo+PiAyLjMxLjEKPj4KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
