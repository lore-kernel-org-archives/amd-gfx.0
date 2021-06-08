Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34411C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E1060FEA
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E1060FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F0589FA0;
	Tue,  8 Jun 2021 15:58:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAE889FA0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTLKVcZp2kFG68ikCZjHESit36rYD8/DZE6zsUNX1qjRaySq43zpWQABLyDq4iBOs3D2Wlr2QfU6cs4D+wbUcxcKfpxfuHZAuuNrauFOOeiXBwVeNWFI6qst9CybmaSAY6NeBJQ5oCegwlaoxkrBub5w1hshOJF302hkk+pR7XcyY8XW/utvLEOwUZejNKEp/M4NkMamyCXy01W1E35uCOzEjTMRA/TXuN6qQqwaJ2yMvhkk7YYSYHCqYtZnCrEcH3k/Q5M3imAQiCx8dWsxuAn0cY582ViE3dKh5DvC+UC/uSJv8blI5saJT+TCQw1sZ9PN750rcXRqQlFaE8HDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9qci88v6faZDpl5Tkk7Fk8zv0cKdQTZ8oTRjfSZ+AE=;
 b=Eq1NU6/4PLo8FzxmqZqJ/1TYbZaPhoXe5B7226fBTwsCpVXVlzMKDGb7inZjvL70AI6Rpn/ciV77M0dpBctg4RoaQV7IoL0mipD/MSwn9FtBKJgDstudtIo74APN/wk4p0fzl2zf3uSG+6zdQBzFlZyOF+9WTu0WnDPRhFU00LKNUAE6Z2LG18RE37elfMfFwcy71+swZZSNCrJ3ymggo+BXjYJm/kCvkXSDy72A+bZ6+v5byyH7fOK4vXPTKwqmy7dmvr0wSoVGd2SD6uCoDJ1IcS4nrayJ2yDVrBhYx4jIXwM+TLJwfGiFuQlCdY2P3WOeui/xdb7Z7aO46FHglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9qci88v6faZDpl5Tkk7Fk8zv0cKdQTZ8oTRjfSZ+AE=;
 b=pm1Ax4G8KQellWtVTlOSf6ilU1Z+YYJ6PZGoqUvuSoN+sNNLgZkkGiyMlCXgiV3yUC1tKl470SBHY5yD9z6oh9k8czUpU8dT/vdBKb/I0GSsyNCo/mDV2rueT4Hd1lxeSaKZyjzkT4sTJmGjf2y8ZixB2RbFb4wbDXBMdeVxvYA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 8 Jun
 2021 15:58:29 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 15:58:29 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210608112714.50475-1-nirmoy.das@amd.com>
 <915174f0-0341-6465-5775-4220de577720@gmail.com>
 <b1c3b109-38d3-cda3-a733-147f904c038d@amd.com>
 <656B99E1-1579-4BBF-900F-813823FD0760@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <c7a4d29c-5605-259f-6657-1d43433e0860@amd.com>
Date: Tue, 8 Jun 2021 17:58:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <656B99E1-1579-4BBF-900F-813823FD0760@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f2b:6400:c449:165a:413d:7e84]
X-ClientProxiedBy: PR0P264CA0255.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::27)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:6400:c449:165a:413d:7e84]
 (2003:c5:8f2b:6400:c449:165a:413d:7e84) by
 PR0P264CA0255.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 15:58:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6610dd8-92d0-48c0-23e6-08d92a964253
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5136D34CB60E366BD037F2658B379@DM4PR12MB5136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+nWWg7QMiUSlZ+u2+ebWn/whJX2tmq964QWKfclBNZ6hsi8gjT4KviXxv1RHpUom9X05JzbMK5kxCmIN2PSfYM3dhkKr6KFrBh6Xdwjhcy4rfB6M85HCrSVnIGE8ydKZRgyoHnf1/wY43qWdAeGrFcEbhjvGtSCFcJ9AR35s6aFW9iDYtwHBaAfSg2X4sQNXR3tkkcf4Hipv7cQMuwFI6STL2N6lhrJ2VM1yYxFgN6HNnQwB7IPxeWxOjc5zdtW0PSD/vwxSnK0kNcyjQwx038ZX+qnkdl+6ZCFeLAETIp5ASoGyodJ7us5sSsQlPXiK0pKd3n3EkxOcpP9Vg91eMbmhiGuhtcDuJrUYKuL5e5hXZ/tmOY99U9fT4Yem2gVYvj+A9z7vhpJKP4kP+xnU5tba/8gRfr/FdBwdAxzyF2PBPuQqGmmMmmvQPpUGNSyiYI5hMesp1X7EoKjCo6wfQztyd/7DvKX5u8N3yWoUJ2uNfEdRxaxw5uIInaMa5nniw33UxFm+wu+qluby+CA9PMNaOL/0nejzTtVpnSq+Z/kfrvYIuhCBQESJnS5qRME0X60lf2du/4+QxiZSBovwJIgx8SyaANXgbz+UI83KoHZCnjYliJwSepdsGbkfCIygmrrbTIXNBz6doLKGakKxDhJLzrEhJyi70OCwmsOA/AXUaz+RRI3w9jnhfJYODMPLIAttKOXLZjajmkR1QGa8MElbxns1uK338N7+Ha+WnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(6486002)(66946007)(6666004)(86362001)(16526019)(4326008)(66556008)(186003)(5660300002)(31696002)(38100700002)(966005)(478600001)(45080400002)(53546011)(316002)(31686004)(83380400001)(54906003)(110136005)(66574015)(8676002)(8936002)(36756003)(52116002)(2906002)(66476007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VBeUlCVWVhQUdGNXM4dDFtckp1YitMZjdkU01EaG1MTXI5TDBKYU1GUWZH?=
 =?utf-8?B?eTA5VVdmc2dzcFJ1NWowYUtMUVErM0VvNUdKWWhtRUhRRXJaQlY3ckwwdDk0?=
 =?utf-8?B?a0hBZ2Z2aGRHa1JjazE1dG5CRGpzZU1aN1AxYnoveFM2Q1U4Z1FJeG1iSVg0?=
 =?utf-8?B?YmFBYmY1NkRwNVZWbWloSjlKNDY2RFR5eGNWc2dISEZObUZxdk9BNHRwQ1hM?=
 =?utf-8?B?bTdjMWpXMTJQRU4reXhqdzlRWG93Q0l1elNWSWo2QlI5RTJaNWI1MVVDUXVv?=
 =?utf-8?B?bTRMaCtxTHQrL3g3VW5jWWZoODlaVUpVOVVZMzJBaE04bGR0akVGc0hLdk5E?=
 =?utf-8?B?b013NXB1STBEekZMeEFQekY3UmtnSnpRMmg0d1NxZEM3NC82M2pxV04zOVI0?=
 =?utf-8?B?STlkUlgrWTF5dlVUbzBaU0hQdlBSNVYyUjRKRWRXV2VySEdBM3R2MHc5Y3cw?=
 =?utf-8?B?SWo2UHQ4ZjNGS09icGtmZHdWcHFQeFd2aEViTEhrTUtNY1FDZDJwbGU2OWh2?=
 =?utf-8?B?UFpUd3JwdEw0clBDWDZsbk9VcVlqYnhhSzJlNmg2enU3VnRYWkYzbXZ0VSs1?=
 =?utf-8?B?NEYrNHFxa2pVOEoxOUVCbHZKTG1ieXhrdlZjckRMeUVzcWh5MjFnekJhUk9n?=
 =?utf-8?B?SnRaUzk4ZGppTHowUjFkQThsbVdpYmp4SkUwR1VEajdhemZveVZNTTBlcGl6?=
 =?utf-8?B?bW1oRTlqRWp3WjNLd0I0MEQ4VlJYb2lpREp4RGs4SlVqcHQ2ZzNtYmVQRmgz?=
 =?utf-8?B?UURVRG1NQ3RZNVZlVEkybWJFMnVycytzRWovemZXMnpDT25zV3gvYmkwWm1P?=
 =?utf-8?B?NFk0QjFrRzV6OGx3MEZZTkJDVWlyVGVRaHJ0SkZrRXFZbUIrdm5ROUN4QkFJ?=
 =?utf-8?B?YVdIMlBrUUNTWW1BcFpFSTVxZXpMWHFrWkNwc1dkMUh0eG9STVVoc2ordmRY?=
 =?utf-8?B?YnE4eC9tZGpnUUFlSlV1QTRoVjNSUWtCNGMrTk96S0tlbGI1MHV5WkUxNk9Q?=
 =?utf-8?B?anpFbEorWXdaRkVzcW9XbHVoa2gxc1kzWnArMnFJRFVUeE10K0lJODFFQlJv?=
 =?utf-8?B?aERManptTHJCampzZXRLaWlLNCt5bUUxdzFFRmo1dkhLVDh5ZlM0STQ5ZUs0?=
 =?utf-8?B?SGRFeFdDaEVhQ3RhVStmVFF0VVp2SkN1YmRqVGJtdlp6c3VXMnk2dTRkdzMw?=
 =?utf-8?B?LzJzSEpEWTd1Q3N3aEFRQ2pMMUlNK1VZaUcvVDlRaGNMc0Y2YXE4UDVha1Zu?=
 =?utf-8?B?Z0RmM25WaDNVTmEzMHJQL1VzY29vSi9mTkF6S3REdFJtWGlrUlMrTDFiMVhN?=
 =?utf-8?B?LzgrOVFVRldpUW02bzlRbmhvMHVwSWNmZGg2S2NqM1Vta0R4WmJMV0cxUnZh?=
 =?utf-8?B?MTVNN0FvNlplMm5RTWYvOWozajFOOGpEaTFMUjU1S2thbHZtdzRnVGl5TDJr?=
 =?utf-8?B?UE8zNFRiNitNY2tvd2cweW9QQVFjSDVkcXFuZDdQcTVPWnhhR1M0a0gwV0JT?=
 =?utf-8?B?L3FCUExHY3VOMU5yQ1FPc1JMK3M2S0pybkppMm51Y0VDT0hCVVV5bWxsMHNE?=
 =?utf-8?B?N2NJVjRhelMzY2FiODkzUzNVbm9JZTJ0cHMxV1RMYjkyNll1WnRnWkdaZHFN?=
 =?utf-8?B?YUxiS2JWbVFIQmwxTlphaUtiVGZseFhwWXQ5MW9EeityaUlFN21mblFkaE12?=
 =?utf-8?B?a04xaFduWlllU3hUMHlYK0J4SWFQVVhWa3ZkV3FmaVNmT1JQWlFud0c5ZTYy?=
 =?utf-8?B?YkVhL242SHpXTys2aCt2ZWJXeGZWUlgzdlB3c1hXL2ZtUzZrTkdxei8ydzdo?=
 =?utf-8?B?cy9TRWVqRWU1MmxXNUlOY0Vxc2plRVZyVnNLQVl5VlNtNm9oNnJJZFlEeTN0?=
 =?utf-8?Q?V8ba17vkQo/Y1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6610dd8-92d0-48c0-23e6-08d92a964253
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:58:29.7693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zKUOJMJno1CXioHr+LhF0kYnW5R1vKCpUlNp6bkv9jUtiX2pQ1mCc4CTTItfqpWn9zMPRJmiTFl2JqmhE5FNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvOC8yMDIxIDU6MjggUE0sIFplbmcsIE9hayB3cm90ZToKPiBIaSBOaXJtb3ksCj4KPiBX
aHkga2VlcCBhIHVudXNlZCBwYXJhbWV0ZXI6ICtzdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfdmFs
aWRhdGVfdm1fYm8odm9pZCAqX3VudXNlZC4KCldlIHBhc3MgdGhpcyBmdW5jIHRvIGFtZGdwdV92
bV92YWxpZGF0ZV9wdF9ib3MoKSB3aGljaCByZXF1aXJlcyB0d28gCmFyZ3M6IGludCAoKnZhbGlk
YXRlKSh2b2lkICpwLCBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKCgo+Cj4gV2hlbiBJIGxvb2tlZCB0
aGUgY29kZXMsIHRoZSBvbmx5IGxvZ2ljIGNoYW5nZSBpcyB0aGUgdmFsaWRhdGUgcGFnZSB0YWJs
ZSBibyBpbiBhbGxvd2VkX2RvbWFpbiBpbnN0ZWFkIG9mIHZyYW0gZG9tYWluLiBDYW4geW91IGV4
cGxhaW4gd2h5IHZhbGlkYXRlIHBhZ2UgdGFibGUgYm8gaW4gdnJhbSBkb21haW4gY2F1c2UgYSBw
cm9ibGVtPyBXaGVuIEkgbG9va2VkIGF0IHRoZSBjb2Rlcywgd2Ugb25seSBwbGFjZSBwYWdlIHRh
YmxlIGluIEdUVCBkb21haW4gd2hlbiB2cmFtIHNpemUgaXMgdG9vIHNtYWxsIChmdW5jdGlvbiBh
bWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5fZG9tYWluKS4gSXMgdGhlcmUgYW55IG90aGVyIGNh
c2Ugd2UgcGxhY2UgcGFnZSB0YWJsZSBpbiBHVFQ/CgpZZXMuIEkgZG9uJ3QgdGhpbmsgdGhlcmUg
aXMgYW55IG90aGVyIHRyaWdnZXIgZm9yIHBsYWNpbmcgcGFnZS10YWJsZSB0byAKdG8gR1RULsKg
IEkgaGF2ZW4ndCBvYnNlcnZlZMKgIGFueSBpc3N1ZSB3aXRob3V0IHRoaXMgcGF0Y2gsIHlldC4g
SXQgaXMgCmp1c3QgcmVwbGFjaW5nIGhhcmQtY29kZWQgZG9tYWluIHZhbHVlIHdpdGggYSBwcm9w
ZXIvYWxsb3dlZCBvbmVzLgoKClJlZ2FyZHMsCgpOaXJtb3kKCgo+Cj4gUmVnYXJkcywKPiBPYWsK
Pgo+ICAgCj4KPiDvu79PbiAyMDIxLTA2LTA4LCA4OjAyIEFNLCAiYW1kLWdmeCBvbiBiZWhhbGYg
b2YgRGFzLCBOaXJtb3kiIDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIG9u
IGJlaGFsZiBvZiBOaXJtb3kuRGFzQGFtZC5jb20+IHdyb3RlOgo+Cj4KPiAgICAgIE9uIDYvOC8y
MDIxIDE6NDIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gICAgICA+Cj4gICAgICA+Cj4g
ICAgICA+IEFtIDA4LjA2LjIxIHVtIDEzOjI3IHNjaHJpZWIgTmlybW95IERhczoKPiAgICAgID4+
IEZpeGVzIGhhbmRsaW5nIHdoZW4gcGFnZSB0YWJsZXMgYXJlIGluIHN5c3RlbSBtZW1vcnkuCj4g
ICAgICA+Pgo+ICAgICAgPj4gdjI6IHJlbW92ZSB1bndhbnRlZCB2YXJpYWJsZS4KPiAgICAgID4+
ICAgICAgY2hhbmdlIGFtZGdwdV9hbWRrZmRfdmFsaWRhdGUgaW5zdGVhZCBvZiBhbWRncHVfYW1k
a2ZkX2JvX3ZhbGlkYXRlLgo+ICAgICAgPj4KPiAgICAgID4+IFNpZ25lZC1vZmYtYnk6IE5pcm1v
eSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPiAgICAgID4+IC0tLQo+ICAgICAgPj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAxNSArKysrLS0t
LS0tLS0tLS0KPiAgICAgID4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pCj4gICAgICA+Pgo+ICAgICAgPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+ICAgICAgPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiAgICAgID4+IGluZGV4
IGQ2Y2I3Y2Y3NjYyMy4uMDIxZjI1MDg1NzYwIDEwMDY0NAo+ICAgICAgPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gICAgICA+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiAgICAg
ID4+IEBAIC0zNDgsMTEgKzM0OCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF9ib192YWxp
ZGF0ZShzdHJ1Y3QKPiAgICAgID4+IGFtZGdwdV9ibyAqYm8sIHVpbnQzMl90IGRvbWFpbiwKPiAg
ICAgID4+ICAgICAgIHJldHVybiByZXQ7Cj4gICAgICA+PiAgIH0KPiAgICAgID4+Cj4gICAgICA+
PiAtc3RhdGljIGludCBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlKHZvaWQgKnBhcmFtLCBzdHJ1Y3Qg
YW1kZ3B1X2JvICpibykKPiAgICAgID4+ICtzdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfdmFsaWRh
dGVfdm1fYm8odm9pZCAqX3VudXNlZCwgc3RydWN0Cj4gICAgICA+PiBhbWRncHVfYm8gKmJvKQo+
ICAgICAgPj4gICB7Cj4gICAgICA+PiAtICAgIHN0cnVjdCBhbWRncHVfdm1fcGFyc2VyICpwID0g
cGFyYW07Cj4gICAgICA+Cj4gICAgICA+IFRoZSBzdHJ1Y3R1cmUgZGVmaW5lIG9mIGFtZGdwdV92
bV9wYXJzZXIgaXNuJ3QgdXNlZCBhbnkgbW9yZSBpZiB3ZQo+ICAgICAgPiBkcm9wIHRoaXMgYXMg
d2VsbCwgaXNuJ3QgaXQ/Cj4KPgo+ICAgICAgUmlnaHQsIEkgbWlzc2VkIHRoYXQuIEkgd2lsbCBy
ZXNlbmQuCj4KPgo+ICAgICAgTmlybW95Cj4KPiAgICAgID4KPiAgICAgID4gQ2hyaXN0aWFuLgo+
ICAgICAgPgo+ICAgICAgPj4gLQo+ICAgICAgPj4gLSAgICByZXR1cm4gYW1kZ3B1X2FtZGtmZF9i
b192YWxpZGF0ZShibywgcC0+ZG9tYWluLCBwLT53YWl0KTsKPiAgICAgID4+ICsgICAgcmV0dXJu
IGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUoYm8sIGJvLT5hbGxvd2VkX2RvbWFpbnMsIGZhbHNl
KTsKPiAgICAgID4+ICAgfQo+ICAgICAgPj4KPiAgICAgID4+ICAgLyogdm1fdmFsaWRhdGVfcHRf
cGRfYm9zIC0gVmFsaWRhdGUgcGFnZSB0YWJsZSBhbmQgZGlyZWN0b3J5IEJPcwo+ICAgICAgPj4g
QEAgLTM2NiwyMCArMzY0LDE1IEBAIHN0YXRpYyBpbnQgdm1fdmFsaWRhdGVfcHRfcGRfYm9zKHN0
cnVjdAo+ICAgICAgPj4gYW1kZ3B1X3ZtICp2bSkKPiAgICAgID4+ICAgewo+ICAgICAgPj4gICAg
ICAgc3RydWN0IGFtZGdwdV9ibyAqcGQgPSB2bS0+cm9vdC5iYXNlLmJvOwo+ICAgICAgPj4gICAg
ICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYocGQtPnRiby5i
ZGV2KTsKPiAgICAgID4+IC0gICAgc3RydWN0IGFtZGdwdV92bV9wYXJzZXIgcGFyYW07Cj4gICAg
ICA+PiAgICAgICBpbnQgcmV0Owo+ICAgICAgPj4KPiAgICAgID4+IC0gICAgcGFyYW0uZG9tYWlu
ID0gQU1ER1BVX0dFTV9ET01BSU5fVlJBTTsKPiAgICAgID4+IC0gICAgcGFyYW0ud2FpdCA9IGZh
bHNlOwo+ICAgICAgPj4gLQo+ICAgICAgPj4gLSAgICByZXQgPSBhbWRncHVfdm1fdmFsaWRhdGVf
cHRfYm9zKGFkZXYsIHZtLCBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlLAo+ICAgICAgPj4gLSAgICAg
ICAgICAgICAgICAgICAgJnBhcmFtKTsKPiAgICAgID4+ICsgICAgcmV0ID0gYW1kZ3B1X3ZtX3Zh
bGlkYXRlX3B0X2JvcyhhZGV2LCB2bSwKPiAgICAgID4+IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGVf
dm1fYm8sIE5VTEwpOwo+ICAgICAgPj4gICAgICAgaWYgKHJldCkgewo+ICAgICAgPj4gICAgICAg
ICAgIHByX2VycigiZmFpbGVkIHRvIHZhbGlkYXRlIFBUIEJPc1xuIik7Cj4gICAgICA+PiAgICAg
ICAgICAgcmV0dXJuIHJldDsKPiAgICAgID4+ICAgICAgIH0KPiAgICAgID4+Cj4gICAgICA+PiAt
ICAgIHJldCA9IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGUoJnBhcmFtLCBwZCk7Cj4gICAgICA+PiAr
ICAgIHJldCA9IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGVfdm1fYm8oTlVMTCwgcGQpOwo+ICAgICAg
Pj4gICAgICAgaWYgKHJldCkgewo+ICAgICAgPj4gICAgICAgICAgIHByX2VycigiZmFpbGVkIHRv
IHZhbGlkYXRlIFBEXG4iKTsKPiAgICAgID4+ICAgICAgICAgICByZXR1cm4gcmV0Owo+ICAgICAg
Pj4gLS0KPiAgICAgID4+IDIuMzEuMQo+ICAgICAgPj4KPiAgICAgID4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gICAgICA+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+ICAgICAgPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiAgICAgID4+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q29hay56ZW5nJTQwYW1kLmNvbSU3QzYyZTRiMGNjYWZh
ZDRlM2QxMTBiMDhkOTJhNzU1MTgxJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzU4NzUwNTY0MTYwODI1MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpX
SWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1vdWZJMmRJWXM2R3gwRUZ1UEVQZ0wwZVlrNWpyaHNOd1Bi
dkRmOGVCSiUyQmslM0QmYW1wO3Jlc2VydmVkPTAKPiAgICAgID4+Cj4gICAgICA+Cj4gICAgICBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ICAgICAgYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiAgICAgIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
ICAgICBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8l
MkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NvYWsuemVuZyU0MGFtZC5jb20lN0M2MmU0YjBj
Y2FmYWQ0ZTNkMTEwYjA4ZDkyYTc1NTE4MSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2Mzc1ODc1MDU2NDE2MDgyNTElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4
ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhW
Q0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9b3VmSTJkSVlzNkd4MEVGdVBFUGdMMGVZazVqcmhz
TndQYnZEZjhlQkolMkJrJTNEJmFtcDtyZXNlcnZlZD0wCj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
