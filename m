Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF63DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 13:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C91E60201
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C91E60201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BC56E15D;
	Tue,  2 Mar 2021 13:36:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740CD6E15C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 13:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/zEdxP+rTQ5PeDG2OpZUBDbwnJ7pg39tA3VT/aSfWpXTMGPPHyfGYZAI7BdCjPaAbaBH0cVkQNbdhF5B1vLxAb44Amoq+UeF/rcOpk8FPl845SbYiEpr4U5qffOwdCc4U/QdJTItaLyIdVzn1S5WOzctLVMpILGdciKHJ4tLu2qINb9Jpfpoh48iQZ1GnwBrniTH/I7nmXlefM9LJOll941/qpUW0SkYRU+8UEPMlVyvzjADAH7z2nNPSW+6KNWypwBJiZikfQvth8XJbJ1OTsXy3UYe4LFSb0apjEgNho0Awa9zK7FLurbLQa6mq89SKrBvI//aEPyT0mpUriDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW/ifSVX160ttlmoKDaXJaxMPp37LteabgWA0tqEXzg=;
 b=WhYl+mPFWd7FzrcT82xqh/yAKMmFZQNypjIqumVFSj5agNx25eQ/O5teIqHkwSQuoD3x1we45Jx1vlXLwRh5OjBeI0yL+68NjJNVkWWFch82WCkwKjEPIOCyr4GBlpJGjvzbYQVZXxQ6fqwAGW6lsd+3gQTEhriv53581M5pKpIc1y8L+aVeDHHmzJ0bBD/Gk12ylBeCWXCoHRiMM0saQ4QEgN6LYsHAZvCdHpaEYB1mOoEN2o/8FGJixGVfEstYh+nopmILRyTPifh/1/41WiBtcRwELSiTspbp9n5hs8VAZhueKngTYfwq6t9kGwfdkbNJZi8vi/bXu4IVRxGoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW/ifSVX160ttlmoKDaXJaxMPp37LteabgWA0tqEXzg=;
 b=LEpTvCXjZLvUS6f0lbo0sDIPS6kK6MjDhB2d5m7dqjXhkugubbOVUHk5NcFLOcnewRpBw5/kIVJH/js6owcW9pDiN7NcVG58UoGVWS71wQ9MELM005+m9I10Xd0AZyzPBCuJYgAq5wpnCSU2dTGoJGsi04g4MSkOH0HdsF8BMGE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2469.namprd12.prod.outlook.com (2603:10b6:903:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 13:36:21 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 13:36:21 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Felix.Kuehling@amd.com
References: <20210302113341.74813-1-nirmoy.das@amd.com>
 <20210302113341.74813-2-nirmoy.das@amd.com>
 <2a73e3af-92a1-a356-0206-935c661c978a@amd.com>
 <dd5ac16c-c5ca-c5f7-226c-3f226e1b3589@amd.com>
 <81315296-f0a3-b196-fdc0-179e608c2535@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <88e2ec1a-e3de-3699-4088-c1cf3d5f6674@amd.com>
Date: Tue, 2 Mar 2021 14:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <81315296-f0a3-b196-fdc0-179e608c2535@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.44.238]
X-ClientProxiedBy: AM8P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::18) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.44.238) by
 AM8P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 13:36:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b994c62-2b78-4718-2450-08d8dd802a9a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24695F5F6B1D1200586D97148B999@CY4PR1201MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1WMKTqDh33TXwyultHbz9pFOvI2C8pQJeT7evY6IUcuIL9NutVayxIkX+HSmCjuUCkR6IzGBpeHB7MjgUpUSJXTa9PohGczy1TQHqv+rPJm7FksZj4XCyy9Uk94RDrmZRI4m4FSSHUhmq1u5HLZY/Vidf51YPVE5cy9f0irPOe4KGzvzlxW7FEucFa/7Nr4sKxXiZFZaTR9IzlZktb0kAK2VpBO4b50bZ/eCerrr6KrPvVSuvF9Wzb47YoiTiArz/5Lq/Mldz5dtNUayMD8x8g7wmWARdpDdOtlngjZu99xMtZY1MuyzWrEoosXO/LR2Jn3xWKZoz2PJptOaF9APCnqIvj0Z/h6lECIRmgLztprNLo7RDilfbN3abED2r87MbdvWs7kpM6rI1XBEZI3/z39t9lQGu8jMnGTYokQftLq4dznFWsHBynwVrk+nfixjPj5LlkBeu8CSmede/4NbU/Cta6PjHf+0HFnRnW7LkrTY6WBO6N0y/ztl1VJ/H4LMm55zqCD14V0UtNwgrwL7QvKD44DeNe5eRSt2ui+R+DVKqKe6goBl22Jkks2ivwXz6SKh2ZXYZIo/aOFThul+nSMa3L9gL4c3SnITkHun98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(16526019)(26005)(66946007)(36756003)(186003)(16576012)(66556008)(5660300002)(31686004)(31696002)(110136005)(6636002)(8676002)(2906002)(6486002)(6666004)(8936002)(316002)(83380400001)(52116002)(2616005)(956004)(53546011)(4326008)(66476007)(66574015)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eDAzYkp3QUludU9IUW9Ybm8yL1hXbi90K2ZwR0NBRUlFSGU4QVlsaVRybFFN?=
 =?utf-8?B?K2tBYmtMTVpyQjZzVFNTT1dlYVZDNGV4a2FiZGsrbUU3Z3pWS29pMnJXV21i?=
 =?utf-8?B?Y25Vcm9DU3kvd2ZwUWM1eXY3TEhPaDFhd1dpelZpTk9sZ0U2K3l2ZlF4MG5j?=
 =?utf-8?B?R0lQNk13YXlBS3pzcEpWTndsdGlKcVhYbzBMOEE3cklpWVorSS9xbklNcUt3?=
 =?utf-8?B?TzgvcmNkNm1Cb2IrbTNsTFY2bEFVamlRQVVNMVB3UitONjNValNWbllBK3pU?=
 =?utf-8?B?ZmovMVA2Z1Yzc3I0SkNVdy9ySVlZWS9lMU5YTGw1SmFTdTZVWFhCdTh0VnRG?=
 =?utf-8?B?WUNLUWZEVEJGbzFlWkQ3NnRsTW44bFNrMzI0TWhkdDBFR2JmdElqYW1KazZn?=
 =?utf-8?B?MnFUaElFNlZudk1GeEd4c2dCclF2QWxNRXlPcjZldGdxWm9XTTlkc0Y4Qk1P?=
 =?utf-8?B?a0JURS93R0kzWDd5V1B3SXRmV2ZheHo5Vm9uZEpna1p3bFhsS2t2Vldad1h3?=
 =?utf-8?B?Z1ViTkQvMDZiRFdmUXFjMVBOeWF6MStYNFFOd0tKdjBlL3cyeFBCTHdzc1dM?=
 =?utf-8?B?R3A1Zk1xQlUxNjVaNENudmtyc3lGK3NWcUlqVDl3NVo3cjFvT201RzJFNzVQ?=
 =?utf-8?B?aStWT29vSXYyMFdRZzdmcHdBYUVYdkxmdjVwVW51Y1AySEhhSlpEZlVFM1VR?=
 =?utf-8?B?a3B0c2pSWGdYN0RrMnQxS2FtOXlsZ0g5VjdtY0F3bWhQcm0zUlY2QkFmbjVH?=
 =?utf-8?B?MGI4WjNlTTh2THFaQllSM3l1Z3VBbGNxVlEzU0VlaXhTZExuSXU1L3NTNHFu?=
 =?utf-8?B?VThuVURnMHBmcTQxWmphdUk1UzRTaTV5UWtKQnBTelMxbUdVMjlmWHFDaUxp?=
 =?utf-8?B?cksrK2R3VFkwenYzQ0VVM0lHN2JlOUtZTmo0bHVSQ2wvWUpZV3FpK0JGU3R4?=
 =?utf-8?B?UlVYSHRsS0pKQUV6Qk1FczV3NXQ2RnU4MzFRUk9tUVpCYktJZVFkdGhOeVdZ?=
 =?utf-8?B?TEVQbEZxb0QrMkVZM1JYR1J6N0NsaDZwTi82VVhtTGpxUWJXRlNld0hHaVRp?=
 =?utf-8?B?WTFScXNYYndKcXRpMkRDdnRiM1ZnbGhxRTMyK0xKWldmZXhkTDBIU0xkM0lw?=
 =?utf-8?B?bDZWMjNpc2dWMVV1d0ZFNGhwUDVqMUY2cGFiRStieE1DbE5Qc0U5L2w2d3dT?=
 =?utf-8?B?TzFRSHVvTHZKdjFpT0Z5My9EME5sNS9IQUNnV1p5YUllRDBkZFlUeWI3aFhC?=
 =?utf-8?B?NWhtRWxxUkt4S1Y5OGcrOEs4MkQxTi82R0FxSkJVOE1VZUV5SnR5eVlXUmQ4?=
 =?utf-8?B?VDB6UXVqa1R5K210RWJxRE1ia00rUWdibzdETmRPUGhGN0tiTDdnNVpzd3B5?=
 =?utf-8?B?VC9SYWVZWkhmS3ZVMHVUV21ZcDR0Wjd4NTBBVUM5UWVIMXpHc204SWRnUytV?=
 =?utf-8?B?NERqSmc4MThPZEQ1eVFyb3lQZk04czFpdE84OUQ5OHljQ1cxRDRUSndwemJi?=
 =?utf-8?B?ckRKT201bnJ5NS9rM3pVa0VnRGRwQTV0YWoxSFoxRVlJZ09INlBOemRMcVZm?=
 =?utf-8?B?b0hoQjAzYnQ0QXlTWndzL29Kd3hYTStLU0VzV256a2RKdUVwU3oyTGNaTTlS?=
 =?utf-8?B?cTkvdytjejFwUG4zbERsdnc1Q3BKb3JmV05IRklOQm90bFdxcklTdHJSZDd6?=
 =?utf-8?B?L2M5WTZjN09FQmJBN0ppWDV1VnNadnpLOU1IS3YvUFBzOEg2VXRuM1lIczNn?=
 =?utf-8?Q?sk91SS9bGzBNZyMHtMZBnmn4n0QdaADLc+wqblo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b994c62-2b78-4718-2450-08d8dd802a9a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 13:36:21.6890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyiaBSRy7JXlsmIga/dVla7QXr1GDu5w4HdksHxKwutUcgFdhLBzfvQW//zI7Y0XnOd5ujhH1vypFMfjqkCehA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2469
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMi8yMSAyOjA2IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAyLjAzLjIx
IHVtIDE0OjAxIHNjaHJpZWIgTmlybW95Ogo+Pgo+PiBPbiAzLzIvMjEgMTo0MCBQTSwgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToKPj4+Cj4+Pgo+Pj4gQW0gMDIuMDMuMjEgdW0gMTI6MzMgc2Nocmll
YiBOaXJtb3kgRGFzOgo+Pj4+IEludHJvZHVjZSBhIG5ldyBmbGFnIGZvciBhbWRncHVfYm8tPmZs
YWdzIHRvIGlkZW50aWZ5IGlmCj4+Pj4gYSBCTyBpcyBjcmVhdGVkIGJ5IEtGRC4KPj4+Pgo+Pj4+
IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4+PiAtLS0K
Pj4+PiDCoCAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uY8KgIHzC
oCAyICstCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jwqDC
oMKgwqDCoMKgIHzCoCAzICstCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jwqDCoMKgIHwgNDggCj4+Pj4gKysrKysrKysrKysrKysrKysrLQo+Pj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaMKgwqDCoCB8wqAgMyAr
Kwo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uY8KgwqDCoMKg
wqDCoCB8wqAgMiArLQo+Pj4+IMKgIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5owqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysKPj4+PiDCoCA2IGZpbGVzIGNoYW5n
ZWQsIDU5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIAo+Pj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+Pj4g
aW5kZXggODlkMGU0ZjdjNmE4Li41Nzc5ODcwN2NkNWYgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+Pj4gQEAgLTEy
MjcsNyArMTIyNyw3IEBAIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9vZl9n
cHUoCj4+Pj4gwqDCoMKgwqDCoCBicC5mbGFncyA9IGFsbG9jX2ZsYWdzOwo+Pj4+IMKgwqDCoMKg
wqAgYnAudHlwZSA9IGJvX3R5cGU7Cj4+Pj4gwqDCoMKgwqDCoCBicC5yZXN2ID0gTlVMTDsKPj4+
PiAtwqDCoMKgIHJldCA9IGFtZGdwdV9ib19jcmVhdGUoYWRldiwgJmJwLCAmYm8pOwo+Pj4+ICvC
oMKgwqAgcmV0ID0gYW1kZ3B1X2tmZF9ib19jcmVhdGUoYWRldiwgJmJwLCAmYm8pOwo+Pj4+IMKg
wqDCoMKgwqAgaWYgKHJldCkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9kZWJ1ZygiRmFp
bGVkIHRvIGNyZWF0ZSBCTyBvbiBkb21haW4gJXMuIHJldCAlZFxuIiwKPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbl9zdHJpbmcoYWxsb2NfZG9tYWluKSwgcmV0
KTsKPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+Pj4g
aW5kZXggOGU5YjhhNmU2ZWYwLi45N2QxOWY2YjU3MmQgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+Pj4gQEAgLTIzNCw3ICsyMzQsOCBAQCBpbnQg
YW1kZ3B1X2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgCj4+Pj4gKmRldiwgdm9p
ZCAqZGF0YSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQU1ER1BVX0dFTV9D
UkVBVEVfVlJBTV9DTEVBUkVEIHwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
QU1ER1BVX0dFTV9DUkVBVEVfVk1fQUxXQVlTX1ZBTElEIHwKPj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQU1ER1BVX0dFTV9DUkVBVEVfRVhQTElDSVRfU1lOQyB8Cj4+Pj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRCkpCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRF
RCB8Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9HRU1fVVNFUl9LRkQp
KQo+Pj4KPj4+IFBsZWFzZSBzdGljayB3aXRoIHRoZSBuYW1pbmcgaGVyZS4gQW5kIHdoeSBfVVNF
Ul9LRkQgYW5kIG5vdCBqdXN0IF9LRkQ/Cj4+Cj4+IE9rLCBJIHdpbGwgcmVuYW1lIGl0IHRvIEFN
REdQVV9HRU1fS0ZEIHdoaWNoIHNvdW5kcyBtdWNoIGJldHRlci4KPgo+IE5vLiBXaGVuIHlvdSB3
YW50IHRvIHVzZSB0aG9zZSBmbGFncyB5b3Ugc2hvdWxkIHByb2JhYmx5IGNhbGwgdGhpcyAKPiBB
TURHUFVfR0VNX0NSRUFURV9LRkQuCgoKQWggSSBzZWUuCgoKTmlybW95CgoKPgo+IENocmlzdGlh
bi4KPgo+Pgo+Pgo+PiBUaGFua3MsCj4+Cj4+IE5pcm1veQo+Pgo+Pj4KPj4+Cj4+PiBDaHJpc3Rp
YW4uCj4+Pgo+Pj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+PiDC
oCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
IAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4g
aW5kZXggMGJkMjJlZDFkYWNmLi41ZWJjZTZkNjc4NGEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4gQEAgLTY5Nyw2ICs2OTcsNTIg
QEAgaW50IGFtZGdwdV9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4g
wqDCoMKgwqDCoCByZXR1cm4gcjsKPj4+PiDCoCB9Cj4+Pj4gwqAgKy8qKgo+Pj4+ICsgKiBhbWRn
cHVfa2ZkX2JvX2NyZWF0ZSAtIGNyZWF0ZSBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3Qgd2l0
aCAKPj4+PiBrZmQgdXNlciBmbGFnCj4+Pj4gKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9iamVj
dAo+Pj4+ICsgKiBAYnA6IHBhcmFtZXRlcnMgdG8gYmUgdXNlZCBmb3IgdGhlIGJ1ZmZlciBvYmpl
Y3QKPj4+PiArICogQGJvX3B0cjogcG9pbnRlciB0byB0aGUgYnVmZmVyIG9iamVjdCBwb2ludGVy
Cj4+Pj4gKyAqCj4+Pj4gKyAqIENyZWF0ZXMgYW4gJmFtZGdwdV9ibyBidWZmZXIgb2JqZWN0OyBh
bmQgaWYgcmVxdWVzdGVkLCBhbHNvIAo+Pj4+IGNyZWF0ZXMgYQo+Pj4+ICsgKiBzaGFkb3cgb2Jq
ZWN0Lgo+Pj4+ICsgKiBTaGFkb3cgb2JqZWN0IGlzIHVzZWQgdG8gYmFja3VwIHRoZSBvcmlnaW5h
bCBidWZmZXIgb2JqZWN0LCBhbmQgCj4+Pj4gaXMgYWx3YXlzCj4+Pj4gKyAqIGluIEdUVC4KPj4+
PiArICoKPj4+PiArICogUmV0dXJuczoKPj4+PiArICogMCBmb3Igc3VjY2VzcyBvciBhIG5lZ2F0
aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KPj4+PiArICovCj4+Pj4gKwo+Pj4+ICtpbnQgYW1k
Z3B1X2tmZF9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCwKPj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIpCj4+Pj4gK3sK
Pj4+PiArwqDCoMKgIHU2NCBmbGFncyA9IGJwLT5mbGFnczsKPj4+PiArwqDCoMKgIGludCByOwo+
Pj4+ICsKPj4+PiArwqDCoMKgIGJwLT5mbGFncyA9IGJwLT5mbGFncyAmIH5BTURHUFVfR0VNX0NS
RUFURV9TSEFET1c7Cj4+Pj4gK8KgwqDCoCBicC0+ZmxhZ3MgPSBicC0+ZmxhZ3MgfCBBTURHUFVf
R0VNX1VTRVJfS0ZEOwo+Pj4+ICvCoMKgwqAgciA9IGFtZGdwdV9ib19kb19jcmVhdGUoYWRldiwg
YnAsIGJvX3B0cik7Cj4+Pj4gK8KgwqDCoCBpZiAocikKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHI7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgaWYgKChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRF
X1NIQURPVykgJiYgIShhZGV2LT5mbGFncyAmIAo+Pj4+IEFNRF9JU19BUFUpKSB7Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGlmICghYnAtPnJlc3YpCj4+Pj4gKyBXQVJOX09OKGRtYV9yZXN2X2xvY2so
KCpib19wdHIpLT50Ym8uYmFzZS5yZXN2LAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCkpOwo+Pj4+ICsKPj4+PiArwqDCoMKg
wqDCoMKgwqAgciA9IGFtZGdwdV9ib19jcmVhdGVfc2hhZG93KGFkZXYsIGJwLT5zaXplLCAqYm9f
cHRyKTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghYnAtPnJlc3YpCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX3Jlc3ZfdW5sb2NrKCgqYm9fcHRyKS0+dGJvLmJhc2Uu
cmVzdik7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocikKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZWYoYm9fcHRyKTsKPj4+PiArwqDCoMKgIH0KPj4+
PiArCj4+Pj4gK8KgwqDCoCByZXR1cm4gcjsKPj4+PiArfQo+Pj4+ICsKPj4+PiArCj4+Pj4gwqAg
LyoqCj4+Pj4gwqDCoCAqIGFtZGdwdV9ib192YWxpZGF0ZSAtIHZhbGlkYXRlIGFuICZhbWRncHVf
Ym8gYnVmZmVyIG9iamVjdAo+Pj4+IMKgwqAgKiBAYm86IHBvaW50ZXIgdG8gdGhlIGJ1ZmZlciBv
YmplY3QKPj4+PiBAQCAtMTMwOSw3ICsxMzU1LDcgQEAgdm9pZCBhbWRncHVfYm9fcmVsZWFzZV9u
b3RpZnkoc3RydWN0IAo+Pj4+IHR0bV9idWZmZXJfb2JqZWN0ICpibykKPj4+PiDCoCDCoMKgwqDC
oMKgIGFibyA9IHR0bV90b19hbWRncHVfYm8oYm8pOwo+Pj4+IMKgIC3CoMKgwqAgaWYgKGFiby0+
a2ZkX2JvKQo+Pj4+ICvCoMKgwqAgaWYgKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX1VTRVJfS0ZE
KQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9tZW1vcnlf
bGltaXQoYWJvKTsKPj4+PiDCoCDCoMKgwqDCoMKgIC8qIFdlIG9ubHkgcmVtb3ZlIHRoZSBmZW5j
ZSBpZiB0aGUgcmVzdiBoYXMgaW5kaXZpZHVhbGl6ZWQuICovCj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCAKPj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4+IGluZGV4IDhjZDk2YzkzMzBk
ZC4uNjY1ZWUwMDE1ZjA2IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuaAo+Pj4+IEBAIC0yNDUsNiArMjQ1LDkgQEAgdm9pZCBhbWRncHVfYm9f
cGxhY2VtZW50X2Zyb21fZG9tYWluKHN0cnVjdCAKPj4+PiBhbWRncHVfYm8gKmFibywgdTMyIGRv
bWFpbik7Cj4+Pj4gwqAgaW50IGFtZGdwdV9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2Jv
X3BhcmFtICpicCwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRn
cHVfYm8gKipib19wdHIpOwo+Pj4+ICtpbnQgYW1kZ3B1X2tmZF9ib19jcmVhdGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
YW1kZ3B1X2JvX3BhcmFtICpicCwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBhbWRncHVfYm8gKipib19wdHIpOwo+Pj4+IMKgIGludCBhbWRncHVfYm9fY3JlYXRlX3Jlc2Vy
dmVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IGFsaWduLAo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiBkb21haW4sIHN0cnVjdCBh
bWRncHVfYm8gKipib19wdHIsCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYyAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwo+Pj4+IGluZGV4IDdiMmRiNzc5ZjMxMy4uZDM2YjE5MzJkYjc4IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+Pj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+Pj4+IEBAIC0xNjQs
NyArMTY0LDcgQEAgc3RhdGljIGludCBhbWRncHVfdmVyaWZ5X2FjY2VzcyhzdHJ1Y3QgCj4+Pj4g
dHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBzdHJ1Y3QgZmlsZSAqZmlscCkKPj4+PiDCoMKgwqDCoMKg
wqAgKiBEb24ndCB2ZXJpZnkgYWNjZXNzIGZvciBLRkQgQk9zLiBUaGV5IGRvbid0IGhhdmUgYSBH
RU0KPj4+PiDCoMKgwqDCoMKgwqAgKiBvYmplY3QgYXNzb2NpYXRlZCB3aXRoIHRoZW0uCj4+Pj4g
wqDCoMKgwqDCoMKgICovCj4+Pj4gLcKgwqDCoCBpZiAoYWJvLT5rZmRfYm8pCj4+Pj4gK8KgwqDC
oCBpZiAoYWJvLT5mbGFncyAmIEFNREdQVV9HRU1fVVNFUl9LRkQpCj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAwOwo+Pj4+IMKgIMKgwqDCoMKgwqAgaWYgKGFtZGdwdV90dG1fdHRfZ2V0
X3VzZXJtbShiby0+dHRtKSkKPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmggCj4+Pj4gYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+Pj4+IGluZGV4
IDhiODMyZjc0NThmMi4uZjcxNTdiZDhhMWYwIDEwMDY0NAo+Pj4+IC0tLSBhL2luY2x1ZGUvdWFw
aS9kcm0vYW1kZ3B1X2RybS5oCj4+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmgKPj4+PiBAQCAtMTQyLDYgKzE0MiwxMSBAQCBleHRlcm4gIkMiIHsKPj4+PiDCoMKgICovCj4+
Pj4gwqAgI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUTCoMKgwqDCoMKgwqDCoCAo
MSA8PCAxMCkKPj4+PiDCoCArLyogRmxhZyB0aGF0IHRoZSBhbGxvY2F0aW5nIEJPJ3MgdXNlciBp
cyBLRkQuIEl0IHNob3VsZCBuZXZlciBiZSAKPj4+PiB1c2VkIGJ5Cj4+Pj4gKyAqIHVzZXIgc3Bh
Y2UgYXBwbGljYXRpb25zCj4+Pj4gKyAqLwo+Pj4+ICsjZGVmaW5lIEFNREdQVV9HRU1fVVNFUl9L
RkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxIDw8IDIwKQo+Pj4+ICsKPj4+PiDCoCBzdHJ1Y3Qg
ZHJtX2FtZGdwdV9nZW1fY3JlYXRlX2luwqAgewo+Pj4+IMKgwqDCoMKgwqAgLyoqIHRoZSByZXF1
ZXN0ZWQgbWVtb3J5IHNpemUgKi8KPj4+PiDCoMKgwqDCoMKgIF9fdTY0IGJvX3NpemU7Cj4+Pgo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
