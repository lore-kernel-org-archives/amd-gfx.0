Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D7C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA48964E45
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA48964E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A03389EAC;
	Mon, 15 Mar 2021 15:22:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0DA89EAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJvRZuBowB2C6RHib5JwJY8VqivYs3UV/n1ySL7vTnDAT1hin3XzP9a7jZJcsyEzvTICtag8rOzQaFKhod7M586MImKkyGofvSobrP5iTVf0yATwm9h8CmCmymLuw1mpZZ8GfznMwq0xi+5K6QvDsXbZPl8kOpXiYr047+i5mGKLIKzp1QfYAt0zE5T6f/up0ChJp4BXsK1ehIynhX0O5MtBdKuQ/v/YbHD1Uo6+awS6jr5BF5PwP2z7E5lhSjefAwfxGUyLUyMILH4OIaf0WSrP4/OVTd4m1UXX41OeG4oOjltNk+DqNtu8R5yfzYxzExiI/XasdGU6PzdrCTlISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPxXCs8SFP9NXPSfEEmQ32CrJa65TYbRS099hx/j3LQ=;
 b=dA6MLYLRV0qLW8VUPO+s7kSRqP/yBgGl9z37gx0yGfcoMJ8U7YTtO6s+8iben6TZZt6DF4gVVn1bnTATLQAH2yEFvml3veuk/PLN8avtbXqNQ5Cj8kWuNE39ouBy2u89cSn1Eaw5FXJnvWGlX4ZodhxcK+8vBEgImUntaiFUjyk3eO04fUM0Cps/OjWeDbCBdHjpLM9IJadrXMgsIoQtHre22kPCd9J5L+mY8sF2La/kSH7zW95XR77zW7361NxjML+YEBPtYpT621Z9vt+xcEi7hJCJzTPv7uL/OyGV65VIzsh77sNdo+HbThhMY1tLoPob+Nh5pqTsjhwIaZnj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPxXCs8SFP9NXPSfEEmQ32CrJa65TYbRS099hx/j3LQ=;
 b=Q4jxXOUV/5fBFifSegSyjENM7yAvjIe6A2S6Kci98fH4vhkcsVlL4BJDiJ3rp9wPvYoP/Kd8+Z6GdmqTUO49GNsGb+CeDHR/foAwrWNake6jUAxBCxSdvhaTRP9WLTzp6L8L2+KwXPRbG+CBmHYegrFlRUrXGMN1fYJmtdi5SAU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 15:22:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 15:22:13 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: make BO type check less restrictive
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210315151414.50491-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bfd582a4-34f3-4e34-5e2d-f740ba2295c0@amd.com>
Date: Mon, 15 Mar 2021 16:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210315151414.50491-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:dd5e:327:8807:376f]
X-ClientProxiedBy: AM0PR02CA0111.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::8) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f]
 (2a02:908:1252:fb60:dd5e:327:8807:376f) by
 AM0PR02CA0111.eurprd02.prod.outlook.com (2603:10a6:20b:28c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 15:22:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5009e26-8064-4e08-8967-08d8e7c61c07
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB443866CB5F0B1B42465F1599836C9@MN2PR12MB4438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVZ8hqNhICgzpBzCgNBTitpOSaTmuvkbYTXmhuNT6jbyfRghuc9DejPTo64b+HFW6GReKyqz0qq5THn4lQemo8xp21VsF5JaG6HCla466QUM45gRYJrEPmQcpQXoRjjVZn5qzq8hFmDkplEelou9j7eMbd/+HjXBw4FBPMRyBfTwa5b3Amr6mAwZXmyGq4oDYQqD2oG/EDZL14mj6on42rstJtovxZiwRPixvyyXHafNYkx5rRX1QlAU0s6Bz8t3rZ+0XtX53CvzUQ4OhuNufCJoNgHZUUaXvI9kc2oi/ut/IS/wH7SAFsRWIIpf/2SnQO67Qdm6A3AB/SfoHVvEC4j5yMu4OGjLEIhFAPSSbEPkR9wZdfteF9XPPuw7RLggoQKtj20/xpxb4ph6twM21DqNDc5Kflqd6zD4Iyxso1HG+TOAiatHwfmLCrrKFdLQYBHqpdtP2QIS7iPxziDEidWxmJL3aJgNGr30KzutH2uGfv/FaM1yTKxJGeoafWm/sWzXQHYeoStPGWmZ3Qdl1OU5GDulB+LWpLhfWxmtBOrSA5a2DRmBrSllcM/+PYBMLuqWSOymLUBdgrq2A3h3o9m225ozhPegDQXViAOxpAcefjVM3Ph2w+ZIwEIbrwYWZDF1hfokhzVkHWOGnuVHew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(8936002)(6486002)(6666004)(2906002)(52116002)(86362001)(36756003)(31696002)(31686004)(83380400001)(66476007)(478600001)(66946007)(8676002)(66556008)(5660300002)(4326008)(37006003)(6636002)(16526019)(2616005)(6862004)(316002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dDM1RFhZdkxqVjJWTWhGcSsvNkV2TTYrY0N0RTU3eDdmaUc5NGlyc256dG5X?=
 =?utf-8?B?dzUrTDhmcVgxWFFpVTF3N3Vsb0s0QWNHVjBUV3JUaXZXUU8rZ3c4RTZDS1hB?=
 =?utf-8?B?dDVjRjdFa0NPK0VHN2VYOE1keGh5N1hYSDRJMmtVM2ZqS0JOa1JwOWFLTitN?=
 =?utf-8?B?TEpTSWMrT2FJOFhZMG92ZTZrT2NWek00REd6d1FoVjNlVlpIRWQvZCtmM0My?=
 =?utf-8?B?Q1VYS25weWQ0bFZyRzNpREtWVE4yU0NVQXg2MVN4di8yTVZOMVdvWVMvSTRN?=
 =?utf-8?B?RzEwM1ZqRTZvN0tHYkM1bmIwWTdQWHF6cEtRZjN0dytnTUcvMDFLQnQwRGJC?=
 =?utf-8?B?bURUUVg3SHpwUEN4YlhUcVNIL2hoQWJ4azRVUzZPZ1FWcitBTk1leXY3OHJG?=
 =?utf-8?B?MEZFcFI1N3M4My9mWDJSNzMrRUFHbDd5OFV5UW4wbWpiamM5emhEbDM1dkU1?=
 =?utf-8?B?U0RGOHllOTVXenlEb3ZWa0pYcy9PNlVCbnpvVFZqYjdLT01tQjQreEs0VGJs?=
 =?utf-8?B?RW1VNUU0YUg2WGtEcVh4MS84NjB4bERtRTN2ZGRtWnBFSTR3aDNoT1czK1lZ?=
 =?utf-8?B?Ri9XbU5YRnUvT0lQR3p2UVVibE9UNE53cW1tVGlaVDFUNjBGSnNBQ0RpQmMy?=
 =?utf-8?B?Q0xQT056NFExUjc2bjZaNjNqSnpQTHV1ZlBzZ0pjS0JXZmdzeFl4dFZKL0xY?=
 =?utf-8?B?bzJMMlpZMHZlaTJIWmNmNWtxZ2ZBYlFsVmxwdDFldVBwaU5GMndrcXBzY29a?=
 =?utf-8?B?QXVHWTc1UDlxNkg3aEdCV1BYaHU3Mk1JQU0vMWpkOU54U0I5N0R2TFZxQnhr?=
 =?utf-8?B?UEtzQ3RYeFJla1psNmdEcnZiMWRYdThYcWFnVUY1aDdjOUNZcW1Oc0JtMUdK?=
 =?utf-8?B?d3dNS0dCV2ZrR3pyVldEbUxGb3FRbWhQQm55WW1OaGM0dnF3UzNsMEpJSUVz?=
 =?utf-8?B?a1ZDU1k4aTdZaVNQMHZhU2JBeG9PMkNnWVNuS2taS2NpMi9RZHpadEFqbWtx?=
 =?utf-8?B?ZEJTd0JYUTlTcjhzZGcreW9lVVdya0doS05vWmRiZUdwUzNXMWJTSVM1NzI3?=
 =?utf-8?B?MmR6SlpWNVdLY2pQR0lDaVBtaVBNWUJBTnJVS3FQZE9SZm9aVGJSRUVIRkYr?=
 =?utf-8?B?b0NEU3BCSWZnL1FCVmFSMnZmaWxxMVErSG1xdi9tVHYxN09OMXR3QzNvaVVX?=
 =?utf-8?B?aU00SkhUM3A5UG9RbzZRSUZ1dkdRM3JuTDBkby96SGhtSFk2RzRqMDhraE9S?=
 =?utf-8?B?YW5IN0NKTk5lVVJqcDlRczdHeWx1YmRVd3lJVy9LM1hna1FkejJCdjlZZ2Ri?=
 =?utf-8?B?aTlEa1p0a0dNbDdzSVhxcEEvbDNCczRKOGlFazQ2SEQ0THBlcUNIMWNXUXp3?=
 =?utf-8?B?M2h4bDRFdEt0bjJJdWUyUWZBanRjYXRsdE45VnNNeHgvQTlnYmFxR3FMYmk5?=
 =?utf-8?B?ZVpMNFoxRkphSlJGcElwd2VFUXNhNXpUN0k5OXNQUXArNGpBVjVNVVlsS2xV?=
 =?utf-8?B?MmNiajhNbFF6K2JPcVhFN1RxY1R4Tis4UmdXbnk1bGJDZEsyVGVsd2xzSnE0?=
 =?utf-8?B?TzlwYzdVK25iWDJqcnJSKzJKOUthS2RVMC9xamJ2ZkxZVDZDM1dEQzRCNFFl?=
 =?utf-8?B?SDdrK1ZLV2M0TnVpVTZLU3FYb2dKckdKTHRNMjNhVHhrRDN4N0JZRW1QMmlJ?=
 =?utf-8?B?M3JGKzJYeGE0UGZFS2pZQkdXcDI5NUtOZ3lEbHl5Vm84TS9GOG1zRDJtb3ZL?=
 =?utf-8?B?WWxHSytlclVRZXFXWlUxTVBOdk9XQTA3eDd5RHRKU0RXL05jK0VreDhLNDFG?=
 =?utf-8?B?NEFQQnFEUU03eWtJSHpzOEJkRFNhNlJ0amJzekVRa21SWnJORHA2TG5EN0FX?=
 =?utf-8?Q?QlDgUwTgIJePJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5009e26-8064-4e08-8967-08d8e7c61c07
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 15:22:13.8248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5NWMa2UQIhJUax8VQgmTadM4r9OfI1jzgwEj/Q31PCtjfTMhgrn2nmOkwv1qnzz
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
Cc: Tom StDenis <Tom.StDenis@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDMuMjEgdW0gMTY6MTQgc2NocmllYiBOaXJtb3kgRGFzOgo+IEJPIHdpdGggdHRtX2Jv
X3R5cGVfc2cgdHlwZSBjYW4gYWxzbyBoYXZlIHRpbGluZ19mbGFnIGFuZCBtZXRhZGF0YS4KPiBT
byBzbyBCTyB0eXBlIGNoZWNrIGZvciBvbmx5IHR0bV9ib190eXBlX2tlcm5lbC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPiBSZXBvcnRlZC1ieTog
VG9tIFN0RGVuaXMgPFRvbS5TdERlbmlzQGFtZC5jb20+CgpBdCBzb21lIHBvaW50IHdlIHNob3Vs
ZCBwcm9iYWJseSBhZGQgYSBhbWRncHVfYm9faXNfdXNlcigpIGhlbHBlciAKZnVuY3Rpb24sIGJ1
dCBmb3Igbm93IHRoYXQgc2hvdWxkIHdvcmsuCgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDggKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggYWMwZTFjZDgzODU4Li5mZGYyM2U0Mzli
NDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4g
QEAgLTExNjcsNyArMTE2Nyw3IEBAIGludCBhbWRncHVfYm9fc2V0X3RpbGluZ19mbGFncyhzdHJ1
Y3QgYW1kZ3B1X2JvICpibywgdTY0IHRpbGluZ19mbGFncykKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOwo+ICAgCXN0cnVjdCBh
bWRncHVfYm9fdXNlciAqdWJvOwo+ICAgCj4gLQlCVUdfT04oYm8tPnRiby50eXBlICE9IHR0bV9i
b190eXBlX2RldmljZSk7Cj4gKwlCVUdfT04oYm8tPnRiby50eXBlID09IHR0bV9ib190eXBlX2tl
cm5lbCk7Cj4gICAJaWYgKGFkZXYtPmZhbWlseSA8PSBBTURHUFVfRkFNSUxZX0NaICYmCj4gICAJ
ICAgIEFNREdQVV9USUxJTkdfR0VUKHRpbGluZ19mbGFncywgVElMRV9TUExJVCkgPiA2KQo+ICAg
CQlyZXR1cm4gLUVJTlZBTDsKPiBAQCAtMTE4OSw3ICsxMTg5LDcgQEAgdm9pZCBhbWRncHVfYm9f
Z2V0X3RpbGluZ19mbGFncyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdTY0ICp0aWxpbmdfZmxhZ3Mp
Cj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9ib191c2VyICp1Ym87Cj4gICAKPiAtCUJVR19PTihi
by0+dGJvLnR5cGUgIT0gdHRtX2JvX3R5cGVfZGV2aWNlKTsKPiArCUJVR19PTihiby0+dGJvLnR5
cGUgPT0gdHRtX2JvX3R5cGVfa2VybmVsKTsKPiAgIAlkbWFfcmVzdl9hc3NlcnRfaGVsZChiby0+
dGJvLmJhc2UucmVzdik7Cj4gICAJdWJvID0gdG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+ICAgCj4g
QEAgLTEyMTYsNyArMTIxNiw3IEBAIGludCBhbWRncHVfYm9fc2V0X21ldGFkYXRhIChzdHJ1Y3Qg
YW1kZ3B1X2JvICpibywgdm9pZCAqbWV0YWRhdGEsCj4gICAJc3RydWN0IGFtZGdwdV9ib191c2Vy
ICp1Ym87Cj4gICAJdm9pZCAqYnVmZmVyOwo+ICAgCj4gLQlCVUdfT04oYm8tPnRiby50eXBlICE9
IHR0bV9ib190eXBlX2RldmljZSk7Cj4gKwlCVUdfT04oYm8tPnRiby50eXBlID09IHR0bV9ib190
eXBlX2tlcm5lbCk7Cj4gICAJdWJvID0gdG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+ICAgCWlmICgh
bWV0YWRhdGFfc2l6ZSkgewo+ICAgCQlpZiAodWJvLT5tZXRhZGF0YV9zaXplKSB7Cj4gQEAgLTEy
NjYsNyArMTI2Niw3IEBAIGludCBhbWRncHVfYm9fZ2V0X21ldGFkYXRhKHN0cnVjdCBhbWRncHVf
Ym8gKmJvLCB2b2lkICpidWZmZXIsCj4gICAJaWYgKCFidWZmZXIgJiYgIW1ldGFkYXRhX3NpemUp
Cj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gLQlCVUdfT04oYm8tPnRiby50eXBlICE9IHR0
bV9ib190eXBlX2RldmljZSk7Cj4gKwlCVUdfT04oYm8tPnRiby50eXBlID09IHR0bV9ib190eXBl
X2tlcm5lbCk7Cj4gICAJdWJvID0gdG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+ICAgCWlmIChidWZm
ZXIpIHsKPiAgIAkJaWYgKGJ1ZmZlcl9zaXplIDwgdWJvLT5tZXRhZGF0YV9zaXplKQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
