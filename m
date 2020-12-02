Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F099EC64E7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 08:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E36C206D5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 08:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E36C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189036E967;
	Wed,  2 Dec 2020 08:45:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EB66E967;
 Wed,  2 Dec 2020 08:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWQ8F5ftmqOYtEHS0hxMWV2VcfC1p5YiPLEXCI6XJMcprsbLjz7JJmv8NmSVKpVSIyvNZfA/elYFEmnXX4VzJiOIu9nWJpZ7IoR2nR4h9wx24KxX7Zxo5VhOMErPGcIgoLQQfpIfrLRFqguHJqxq+aTdoyS7PtqXyLyb2OKJOi6EgZrwD8vSw6o3sL5RvWIT/tl3csszRNIS2jal/twpYUTbQK0YlHeyg2/n0TFRYuTVa7hrc0Itvz6SqU19BmTZ4gQAGe+klVIPg1hlFms6ZnWBGbEtdRIUQuC6c/xcrGzh+elqrx0ZQNQwb4tVYU6DJqKOC/A+VS8Bbx1agmFa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GNN1qPnenFEQR940Eqq0s5ZOzLnqLNnvL87h3qdNug=;
 b=jE8WoznvXT1RXHVvjyiiwutAkVCsucLuO7wBudYW7sedQCQtwmpTXSSRMEntiB0CDE36G3gwU6NnpiH6OcdbnaeY7GxvYBVxpLvdmag3VzG2dimpUnskH731/mJaBYBaPNnu7pHfX37yT9YHmQwyFARf77oa5j5CkLYE6eTIGcq9c6KF9vfZxm5sqdicHo/qNrUG5jzOluVypkbNRp1lS/Sd5nlgJPWQTA63zaOgvdU/S6o/yAzNfs7ZDfzPztU1J70lzVoyXWxiXR8FLDgWwUtEPcYdeq+Yw+EWQZuLHykbk2Y2XD6quLDcjfWqBHBFgWcu3o7qNBEj6d5pTM6xHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GNN1qPnenFEQR940Eqq0s5ZOzLnqLNnvL87h3qdNug=;
 b=CSoYv+68MOQsi+44Vzpk7oPdpHvxiNpRKGhLRFf4PagEax0mGlaEjYGTNLNIHT855PXbGt/x5JwgkZSprao7VHB+aeNofXkEqUuFXL928RGvCKjvROapAGapBbJuzEq51z1deJRcCcHzd3P71PC4H5JH+OnNHyC+J1BvFurCGtw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Wed, 2 Dec
 2020 08:45:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 08:45:07 +0000
Subject: Re: [PATCH 2/2] drm: amdgpu: fix a kernel-doc markup
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <cover.1606897462.git.mchehab+huawei@kernel.org>
 <65bae21ebb9de534483b282fb091d4526cff0be8.1606897462.git.mchehab+huawei@kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <21d4e623-4250-454f-67ff-658da99cf26d@amd.com>
Date: Wed, 2 Dec 2020 09:45:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <65bae21ebb9de534483b282fb091d4526cff0be8.1606897462.git.mchehab+huawei@kernel.org>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P192CA0030.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM8P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 08:45:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4de8c102-4fd4-48e7-a926-08d8969e9222
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578EC67CE945DBE671F007A83F30@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tOHTjHPdLlzjAkOhbtrSyUhMNYfWS8pGUFgbquuWgbZmVl/rM8gTPnXoFqKlHDgHvr+pubhMwsX/8yIJ27K1anDAcTZAEBgvbGi6K3i3JveF1wKGzbce9xKeRbYB53+NS13g+Rdum8Me3kDPsJKxabnstXe4Q17eme83PNoLseU7PA34b69FGgqf5sRyR+a+d7sTK73j5ZHBlgvEeHB4CHeNcvJVsPA2eMipSN+YHDZJKqdsURTRkAs8V/a2PXbgNJSCGNGpkjhewwhG8RtSP751w5bLbSfoV8MTcVD4BFf8JXVFjqSdKF8xzHOlyU/MaTpAWjrFvD3WW0w0SUkSYHJypbysBo6sVE8ymYVE+5tJwsQsq6YBoB3XXjnOLYTtg5/Dzq2P6MVVckfUjdlFrteWpOui5uEfRZiZ1CGiZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(31686004)(4326008)(2616005)(316002)(7416002)(16526019)(186003)(66556008)(52116002)(31696002)(36756003)(2906002)(478600001)(110136005)(86362001)(66946007)(6486002)(8936002)(6666004)(66476007)(83380400001)(66574015)(5660300002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eDF4b09DUk03TU9taVltcUVUdnJXaURtVEtvWEpMOUJuWmptU2hVQy8zSmRy?=
 =?utf-8?B?ZzhkUVM1Tks1Q3p0RGI1MGNQQTlJcEVmQWd6QVE0Q3d6cWJnSnBFR2tSRnJy?=
 =?utf-8?B?bkFrdGtyb2hZanNlY3R6NkkvVVIzbi9oRVZwdmxhallJd2JzY2JWTnhkS0lP?=
 =?utf-8?B?RHU2VWJYaCsxK3Q5QTZZSTVzMXFYMkZBb3NlbEtZZFBKN1VSQU8rYXRJMFZw?=
 =?utf-8?B?NzkzWm0rbjFzNXZwWFZmSG9Cb0JlWlZmVmNad0UrbXNOb1hQVTNPY3B4MUE5?=
 =?utf-8?B?UDNGdDByb3VvYnhacGpYSjdVVjBOMFhzNjlnREx0VVAzeVlZYXVLWmdPRUVM?=
 =?utf-8?B?VG83eVBlQUF4K0FiOW9FSWhhZCtvWVBhNTQyRmlhY0Z6WlcvbUVlM0xzSy93?=
 =?utf-8?B?TUxxWEliclp0cHlwYlhIWkhocW5Sc1dkZHJpbUdmNXBCYUhVSjZUYjlqQTA2?=
 =?utf-8?B?a3VxUVcvUFVLem9jMTNQdzhxS1dpblJYRkZtV1JyeFE3T3ZGWkt2ajlDMEZu?=
 =?utf-8?B?ajhIVjZIV2NnYmdocHVXcmMrRFFwMGlnKzg3cnhpNC9IQTJoUzlEVmx0YzFm?=
 =?utf-8?B?SHR3NWFxbXpKeUFBYVZsUXhGQWx5dDd5YXl3NkpoaGRPVWtCMXRsb3FYNk9N?=
 =?utf-8?B?cWJybjRqd3o3U2c3a3ByQzJIMlRxNk96RVZzcVFBWVVvT0lHL1ZZWG92bTRZ?=
 =?utf-8?B?THM1U0tHcnBzSFhKNjRrcnY3UXpBSlJEQlRSSmZ0SGxYQnNTYTRCaVhid2dz?=
 =?utf-8?B?K3FmZmlwbzhkMElQc2FLRmNndWQyTzdZaGpCRlMrU1FvTnZJVStiK3YzaFNC?=
 =?utf-8?B?L25pOUwxQ1VLeFZlcU5HRzUrN09rcU1lSnFJOElmVGsrZG1kUEtCT1ZBU1FN?=
 =?utf-8?B?UmJmaDJyTk5Zamdya2I3eUZPOTdEbDlKcjJVdjdnaDNQYUJWc1NOaDJtVnNj?=
 =?utf-8?B?UXl0LytXSGlUSGw3TzFncjNic1RGbnlDaUp3Z3dzMGd0ZlFkdmd2WHVjc2lm?=
 =?utf-8?B?WGsvNGtOYVZjOUk5TzdUdVIzVWZlelkyWUZFMXJRaEVmZ3JOLzVZYmJIZEZK?=
 =?utf-8?B?c3EwMmdRcncvWjZueHhmSm9uQVl4UG0xZlh3bi9OVS9haUI2VzkxaUdpMkNy?=
 =?utf-8?B?WEo2dS9VUjdING9OMk5JL0Q0Y0I0dExyaFpWWDZ5eG91UUxNMTd3ZG1aNEhq?=
 =?utf-8?B?NFNqT1dDeFNweW5Gd0hIcE1Pc1JWYWx1QllpcVNCeVpqNDRBMDJ5RnZiSlM1?=
 =?utf-8?B?QzJ5MXRWd3JURXFFWjFOTUFRVXhleTY4Zm0rUDN2RzVCQXc1TC9HQWh4VnFX?=
 =?utf-8?B?ajJiUnM0ZFlZM21nTlQySnplNmtsMi9FTGtncUs2eFozdlI3blFoZzhEUkJX?=
 =?utf-8?B?N2pkOVdzMG12eHNwV20zc1FWcGZrVkwxaFh4VE0vTmVUc3RabDhDZldZRVY3?=
 =?utf-8?Q?N40q64Ub?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de8c102-4fd4-48e7-a926-08d8969e9222
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 08:45:07.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em390tUmV7Pgtqnu4xTAtlXUSIKw2xFcmlDoObUEiApzgpQxLK2i9ffhgfM9TtQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Cc: Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMTIuMjAgdW0gMDk6Mjcgc2NocmllYiBNYXVybyBDYXJ2YWxobyBDaGVoYWI6Cj4gVGhl
IGZ1bmN0aW9uIG5hbWUgYXQga2VybmVsLWRvYyBtYXJrdXAgZG9lc24ndCBtYXRjaCB0aGUgbmFt
ZQo+IG9mIHRoZSBmdW5jdGlvbjoKPgo+IAlkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmM6MTUzNDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1kZ3B1
X2RlYnVnZnNfcHJpbnRfYm9faW5mbygpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfYm9fcHJp
bnRfaW5mbygpIGluc3RlYWQKPgo+IEZpeCBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hdXJvIENh
cnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4KClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMiArLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggYzZjOTcyM2QzZDhhLi5mZDdh
OTNjMzIyMzUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jCj4gQEAgLTE1MTgsNyArMTUxOCw3IEBAIHVpbnQzMl90IGFtZGdwdV9ib19nZXRfcHJlZmVy
cmVkX3Bpbl9kb21haW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJfSB3aGlsZSAo
MCkKPiAgIAo+ICAgLyoqCj4gLSAqIGFtZGdwdV9kZWJ1Z2ZzX3ByaW50X2JvX2luZm8gLSBwcmlu
dCBCTyBpbmZvIGluIGRlYnVnZnMgZmlsZQo+ICsgKiBhbWRncHVfYm9fcHJpbnRfaW5mbyAtIHBy
aW50IEJPIGluZm8gaW4gZGVidWdmcyBmaWxlCj4gICAgKgo+ICAgICogQGlkOiBJbmRleCBvciBJ
ZCBvZiB0aGUgQk8KPiAgICAqIEBibzogUmVxdWVzdGVkIEJPIGZvciBwcmludGluZyBpbmZvCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
