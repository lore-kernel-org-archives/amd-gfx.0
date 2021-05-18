Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE2C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B277C611B0
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B277C611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66DE6EC70;
	Tue, 18 May 2021 18:49:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEAEE6EC6D;
 Tue, 18 May 2021 18:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuASau+pd0M6wgi+/bp0Qv7s5r7GGhAhwYI3Kp7O4mjqAehHM05T4CRNiteCD+Oqb+8PBf5ovsMNNvxkLGXXtiCf+lwzdl6FwBE6M4Vnl1UgxqKXprDx52Im43zI0yNUoKOsdZjGsVI32w67jdemnZdHabKeJhwxBqFcXDTX+S89wnFvq7vD8v/AWkeej3wal4zT3Z0IS9YtIPfAmjr1rOVL21pFtE57cWlxGG+2eouaROjmvCX63/40A1j42GOkQhGgI/EubfqdNxDkx+Fw/I5tv8AOcFyBYJkHISDFlQFe1zSm52DH3gVeVwWp9po9fbuhAV207GBGfdJ1yq6AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ1zFzQc6M4Sav8VzzUmjgiekH21tMZiAGh4gaVXdis=;
 b=j3oIkO9xGZBCUtEVuhzLvtmbi6za1+fV1kb9L++OnDAEOwaQMerEBq7IGpDQ/gJ2wuDlUFs4D8lUYdT1XTDkvxN/yBVcHp0PjS3zCuG3t65kJ13QPMaSX31xihH+riVeVZ9SsE20wJZGioKiMX8q9cp2U5Q0Jg1mPit8YJjo8xre9M45dXV2m3IUGQJUacO4YfOvawyTbXWl1vTUo2QBrwALCK4LD5XkR2cj+MW18EzZkdLhg+DjjBoMb9t2xVBgY8kmOms6i8izzajM5nAmEWSbpAK2hbOAEjBPjL6RdPNhubsXFD/2y2aLBXCmHOPlb5Y6RCjrU8lu4AEMJIqxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ1zFzQc6M4Sav8VzzUmjgiekH21tMZiAGh4gaVXdis=;
 b=L/AsJng/xsQcuOiFGGhtaF6kQYVCU+ddiWNu6np2G5ZF/St/1be2/pW6IzmJJwEuXp+gxDsS3a6F8S8zSfmmdXABA575lKIH5xvvPRJPkR3KU6Sv1Bk5/AyCr5hMVq0hOWEa4tI7Low8xvU8rkBOs35Bqcu7m3XrACVKSG0bLJ0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Tue, 18 May
 2021 18:48:57 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 18:48:56 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
 <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
 <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
 <31febf08-e9c9-77fa-932d-a50505866ec4@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <cd6bbe33-cbc5-43cb-80f7-1cb82a81e65d@amd.com>
Date: Tue, 18 May 2021 14:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <31febf08-e9c9-77fa-932d-a50505866ec4@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024]
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024]
 (2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024) by
 YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 18:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a294da-fc61-42a6-a7bc-08d91a2d9762
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4576FFA99D89FFC4036EBE95EA2C9@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIqGP1Ee22YxQRqLQLLtjT+nR8uilfYEGeUnNK9aBZGSNgcOF9i42StcKRWN0+7ixJ+i0Fl2fyHN807ub+MUE8EZlU0Cqpnwf2xz2ZS3UjiTU0EicKm9qekTPQm59qXqpFxacunYKR9h9iZ21eR1uDjNxTa5pJNWceKnBPm7vb1VWMcOgnPjQ3SYycbB/xnXoXWMfA0R6DytSthnKgUk6T1zWZyXa1pAS8bdX06G4j7CPKhReLgkacbFjLQq/igHh8PMoJI80gYhYav1Ldn0OSBIRK9qkOQ1ZSOo1ojk4s5bcEo64Se5tjbAb3T8HRriVtiQgLtTTTPddJqcXiuY350lcbdpj56i2lkJeDERhbvBnbSrwjltAR319ybAf4oRuEwjXmWEMtML9lxNGz/OwmEB26E9Wq6/BXoWVarywzhJ8oY3O5RlfbX+39vKM3B/myWUvZ7ymR7JPUyUmLsKI20O1Ot59TRW+rZ3THiZqDc8K0qGqSpPUv2ewO0wRa438ONda7LsdpzAgDvS/f0E5jjxeUCDkqs0zK1e/hHRFvoIdFr5DB36+K4HV9DBod3/68fdR5LDerm+ccSwd/JbgI9QUj1c7BiJmWwIT93nLsWXvChyhpijNz4uXvAj8l98/JOvkWstk/9hUFfIhyD9S1kDl4v48O+H/R6nvsLxYac2/JGDxTp7raLWC4QdFTmF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(83380400001)(38100700002)(4326008)(31686004)(8676002)(316002)(53546011)(31696002)(2906002)(186003)(86362001)(6636002)(16526019)(44832011)(36756003)(5660300002)(66476007)(66946007)(66556008)(6486002)(8936002)(2616005)(52116002)(66574015)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TnQvVUZvMDRZakVjeENaT0lpa3JCUmQ4SXJkVGMrOHRYdHRWa2prZlYvdUM3?=
 =?utf-8?B?bFBlSWFkOXRzMEVDY0RaajB2Q3lld0FMZ3JhdGpqMnpKWjZQaTZBRUdPU2g4?=
 =?utf-8?B?V2gvbllldDB3cnIrQlVtcGlnL0xrMWxUVjg2WTVYV0hOOUFaVjYwUGN1aG52?=
 =?utf-8?B?OGRQb0dJWVBGeC9Hb0UxU3hTbXBvN1dnSG00dWNsa3NkWlhXd0lMVktxa1Az?=
 =?utf-8?B?dWM0WWxlWjcrM0g3cXdYYkJXMmdVdVZkS0MzRWpjQWFsbkhqNEtmck9UZXdY?=
 =?utf-8?B?UXVxRnZycW5FNjBUTFRwUi9rNGJ0V00vWVJ2d3BYZDdFbjk5OUxCOXpVUVg4?=
 =?utf-8?B?dlVUUnBSdVkyNytlY1B2OFlzQytoeFF4UlJiL2hQK0JyMmFSMVEvZkNHVFgz?=
 =?utf-8?B?a0xIWW02UHBRTENramFTWTRxd2gxR0x5SGQxeW1yZUVSWXBJUTdueTBrQWl1?=
 =?utf-8?B?b0ZhUDI1R3hkdEltZW90Y1N0OXU1SkVFRjQ4clMyR2JJWm0waXdpRGt4SWlv?=
 =?utf-8?B?a3dvR1pSNzM0NjVCaDhOd3pjMTVucHZpbE5PM2M2cXZqdmNLaDNwbjQyM3pV?=
 =?utf-8?B?RTUxZm42cmQ2OGt6ZnNMOURubjJCRGtvZ0cvTm5DL204eTlHUUlySXIyYWVi?=
 =?utf-8?B?UjJPTktqREJoN1JiNFRkUWtVYXJVYU44dzgxOVdxRUc2bHgrTndjSmViZWht?=
 =?utf-8?B?QkJVTXo5UFA0cHR0LzNvRDhrdVJxeWZ2N3pVK0I5NFdNcTUzNnNrazhTV29i?=
 =?utf-8?B?cWVJYTNtVHFaOFJzT1hPbGgxc1dlM3M4V3FucUJpUXJHbnd1enNMTnRRSWMx?=
 =?utf-8?B?eThIQXJ2OE1pZUFIMzgvUXB4SEdYM20wS01MZFNZSit2QVdiaFo1Mm9XdG55?=
 =?utf-8?B?dmE0NituNW0wMjExMFVka09Ocjk1T0w0ZnovZGtEN1M4QnlWdnl1QXRJRTVI?=
 =?utf-8?B?Y0RqUEZyVXhuVVQ4RENndzJWcEczUXVrUWtiTGN4aXZieGZzOU90azJtcng0?=
 =?utf-8?B?OFVYRjFuTEVyQWV5K0lCNkIyMGhWbzZwcVh3b3J3Ym81d3ZjajVrWEJhZkdS?=
 =?utf-8?B?Q0s5b2dJZ0ZiY0ZYZVFoU1RSK2g2TVVhOE4vaFJ4TkRneUpOK2Fud3JFWlVQ?=
 =?utf-8?B?V25OSzRDcW02UXlGWkhaSi9JNmcwWW42eGUwcXpWQ1A1RWNOUHZ0NjI5YW9q?=
 =?utf-8?B?ZkxNYWhFVnFkeUFyL3JMSFBvd0JvZVpoeEhqd2twRmdlYWFmdVBvdkVRMElm?=
 =?utf-8?B?UlBrSXFiUTZKVkRGTGJOdnBnaFN1TjdQemU3WEFDakxGNHBhVXJHU2MwUHpQ?=
 =?utf-8?B?V3duNG9OL0MyTnZKK29vRUVRak83eUEwemtVcEZaVUR5MDAyM09UL0laL3Fa?=
 =?utf-8?B?azludVBaMmtOdTJyamV6QVhVeDNWSVFkMDVZTnk3YU16cUwvSU55eFNGVERO?=
 =?utf-8?B?TndsaVV3Z3o3QUMrZE5Ic3pybzVqR1I5eHVJME9XQTVHc3hYS29XT2t5Mk1j?=
 =?utf-8?B?a1YvL0dYU2RUekx4cDEzOHZTajdWazl4L25NZkgxQ3ZXTXhRZ05TbWRlMng3?=
 =?utf-8?B?YWxzOUtHdjZGZFl1dzJFbmlRVUJDbThEbmNBclVqa1duMkZrM1E1dXg0eUtr?=
 =?utf-8?B?MC94V0VrMHo2Wm5pSk5vNjczclZPMGIwNWMyNGZOMDBEdmcwamx4ZUZETHVR?=
 =?utf-8?B?VzdVbnJIb000ek9jRWprM3NtUUpLSEF3YjZqdWZwU0k4NzZralJqbUR3RjJ1?=
 =?utf-8?B?NlZiYmlGT09Hc3l0OXVHdi9DVmlxQy9uUUlEay9zM1lLSEdldFY0cFAxdnBF?=
 =?utf-8?B?NzBCU1VSTW9Ubm10UnFDYjJXT2ViNFB1SXdkdjg3Vi93TVZrcTdmdWtZZmJP?=
 =?utf-8?B?VVYxVmdtTm8yWmpFYUlLdllYejBjbE5oNmlsNk4wTnBwOGc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a294da-fc61-42a6-a7bc-08d91a2d9762
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:48:56.7330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Hj1rX5GHAn64W0O4P7HJGs9eRw8kvagPeldYrqmAyXKDdj+Q2uEMEkgGUL2wvbSn/CD29byymAgQWmXh0X+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE4IDI6MTMgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiAKPiBB
bSAxOC4wNS4yMSB1bSAyMDowOSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+PiBPbiAyMDIx
LTA1LTE4IDI6MDIgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDE4LjA1LjIx
IHVtIDE5OjQzIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4gT24gMjAyMS0wNS0xOCAx
MjozMyBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAxOC4wNS4yMSB1bSAx
ODoxNyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBPbiAy
MDIxLTA1LTE4IDExOjE1IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+Pj4gQW0g
MTguMDUuMjEgdW0gMTc6MDMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Pj4KPj4+
Pj4+Pj4gT24gMjAyMS0wNS0xOCAxMDowNyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
Pj4+Pj4+Pj4gSW4gYSBzZXBhcmF0ZSBkaXNjdXNzaW9uIHdpdGggRGFuaWVsIHdlIG9uY2UgbW9y
ZSBpdGVyYXRlZCBvdmVyIAo+Pj4+Pj4+Pj4gdGhlIGRtYV9yZXN2IHJlcXVpcmVtZW50cyBhbmQg
SSBjYW1lIHRvIHRoZSBjb25jbHVzaW9uIHRoYXQgCj4+Pj4+Pj4+PiB0aGlzIGFwcHJvYWNoIGhl
cmUgd29uJ3Qgd29yayByZWxpYWJsZS4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBUaGUgcHJvYmxlbSBp
cyBhcyBmb2xsb3dpbmc6Cj4+Pj4+Pj4+PiAxLiBkZXZpY2UgQSBzY2hlZHVsZXMgc29tZSByZW5k
ZXJpbmcgd2l0aCBpbnRvIGEgYnVmZmVyIGFuZCAKPj4+Pj4+Pj4+IGV4cG9ydHMgaXQgYXMgRE1B
LWJ1Zi4KPj4+Pj4+Pj4+IDIuIGRldmljZSBCIGltcG9ydHMgdGhlIERNQS1idWYgYW5kIHdhbnRz
IHRvIGNvbnN1bWUgdGhlIAo+Pj4+Pj4+Pj4gcmVuZGVyaW5nLCBmb3IgdGhlIHRoZSBmZW5jZSBv
ZiBkZXZpY2UgQSBpcyByZXBsYWNlZCB3aXRoIGEgbmV3IAo+Pj4+Pj4+Pj4gb3BlcmF0aW9uLgo+
Pj4+Pj4+Pj4gMy4gZGV2aWNlIEIgaXMgaG90IHBsdWdnZWQgYW5kIHRoZSBuZXcgb3BlcmF0aW9u
IGNhbmNlbGVkL25ld2VyIAo+Pj4+Pj4+Pj4gc2NoZWR1bGVkLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
IFRoZSBwcm9ibGVtIGlzIG5vdyB0aGF0IHdlIGNhbid0IGRvIHRoaXMgc2luY2UgdGhlIG9wZXJh
dGlvbiBvZiAKPj4+Pj4+Pj4+IGRldmljZSBBIGlzIHN0aWxsIHJ1bm5pbmcgYW5kIGJ5IHNpZ25h
bGluZyBvdXIgZmVuY2VzIHdlIHJ1biAKPj4+Pj4+Pj4+IGludG8gdGhlIHByb2JsZW0gb2YgcG90
ZW50aWFsIG1lbW9yeSBjb3JydXB0aW9uLgo+Pj4+Pj4KPj4+Pj4+IEJ5IHNpZ25hbGluZyBzX2Zl
bmNlLT5maW5pc2hlZCBvZiB0aGUgY2FuY2VsZWQgb3BlcmF0aW9uIGZyb20gdGhlCj4+Pj4+PiBy
ZW1vdmVkIGRldmljZSBCIHdlIGluIGZhY3QgY2F1c2UgbWVtb3J5IGNvcnJ1cHRpb24gZm9yIHRo
ZSAKPj4+Pj4+IHVuY29tcGxldGVkCj4+Pj4+PiBqb2Igc3RpbGwgcnVubmluZyBvbiBkZXZpY2Ug
QSA/IEJlY2F1c2UgdGhlcmUgaXMgc29tZW9uZSB3YWl0aW5nIHRvCj4+Pj4+PiByZWFkIHdyaXRl
IGZyb20gdGhlIGltcG9ydGVkIGJ1ZmZlciBvbiBkZXZpY2UgQiBhbmQgaGUgb25seSB3YWl0cyBm
b3IKPj4+Pj4+IHRoZSBzX2ZlbmNlLT5maW5pc2hlZCBvZiBkZXZpY2UgQiB3ZSBzaWduYWxlZAo+
Pj4+Pj4gaW4gZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMgPwo+Pj4+Pgo+Pj4+PiBFeGFjdGx5
IHRoYXQsIHllcy4KPj4+Pj4KPj4+Pj4gSW4gb3RoZXIgd29yZHMgd2hlbiB5b3UgaGF2ZSBhIGRl
cGVuZGVuY3kgY2hhaW4gbGlrZSBBLT5CLT5DIHRoZW4gCj4+Pj4+IG1lbW9yeSBtYW5hZ2VtZW50
IG9ubHkgd2FpdHMgZm9yIEMgYmVmb3JlIGZyZWVpbmcgdXAgdGhlIG1lbW9yeSBmb3IgCj4+Pj4+
IGV4YW1wbGUuCj4+Pj4+Cj4+Pj4+IFdoZW4gQyBub3cgc2lnbmFsZWQgYmVjYXVzZSB0aGUgZGV2
aWNlIGlzIGhvdC1wbHVnZ2VkIGJlZm9yZSBBIG9yIEIgCj4+Pj4+IGFyZSBmaW5pc2hlZCB0aGV5
IGFyZSBlc3NlbnRpYWxseSBhY2Nlc3NpbmcgZnJlZWQgdXAgbWVtb3J5Lgo+Pj4+Cj4+Pj4gQnV0
IGRpZG4ndCBDIGltcG9ydGVkIHRoZSBCTyBmb3JtIEIgb3IgQSBpbiB0aGlzIGNhc2UgPyBXaHkg
d291bGQgaGUgYmUKPj4+PiB0aGUgb25lIHJlbGVhc2luZyB0aGF0IG1lbW9yeSA/IEhlIHdvdWxk
IGJlIGp1c3QgZHJvcHBpbmcgaGlzIHJlZmVyZW5jZQo+Pj4+IHRvIHRoZSBCTywgbm8gPwo+Pj4K
Pj4+IFdlbGwgZnJlZWluZyB0aGUgbWVtb3J5IHdhcyBqdXN0IGFuIGV4YW1wbGUuIFRoZSBCTyBj
b3VsZCBhbHNvIG1vdmUgCj4+PiBiYWNrIHRvIFZSQU0gYmVjYXVzZSBvZiB0aGUgZHJvcHBlZCBy
ZWZlcmVuY2UuCj4+Pgo+Pj4+IEFsc28gaW4gdGhlIGdlbmVyYWwgY2FzZSwKPj4+PiBkcm1fc2No
ZWRfZW50aXR5X2ZpbmktPmRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzIHdoaWNoIGlzCj4+Pj4g
dGhlIG9uZSB3aG8gc2lnbmFscyB0aGUgJ0MnIGZlbmNlIHdpdGggZXJyb3IgY29kZSBhcmUgYXMg
ZmFyCj4+Pj4gYXMgSSBsb29rZWQgY2FsbGVkIGZyb20gd2hlbiB0aGUgdXNlciBvZiB0aGF0IEJP
IGlzIHN0b3BwaW5nCj4+Pj4gdGhlIHVzYWdlIGFueXdheSAoZS5nLiBkcm1fZHJpdmVyLnBvc3Rj
bG9zZSBjYWxsYmFjayBmb3Igd2hlbiB1c2UKPj4+PiBwcm9jZXNzIGNsb3NlcyBoaXMgZGV2aWNl
IGZpbGUpIHdobyB3b3VsZCB0aGVuIGFjY2VzcyBhbmQgY29ycnVwdAo+Pj4+IHRoZSBleHBvcnRl
ZCBtZW1vcnkgb24gZGV2aWNlIEEgd2hlcmUgdGhlIGpvYiBoYXNuJ3QgY29tcGxldGVkIHlldCA/
Cj4+Pgo+Pj4gS2V5IHBvaW50IGlzIHRoYXQgbWVtb3J5IG1hbmFnZW1lbnQgb25seSB3YWl0cyBm
b3IgdGhlIGxhc3QgYWRkZWQgCj4+PiBmZW5jZSwgdGhhdCBpcyB0aGUgZGVzaWduIG9mIHRoZSBk
bWFfcmVzdiBvYmplY3QuIEhvdyB0aGF0IGhhcHBlbnMgaXMgCj4+PiBpcnJlbGV2YW50Lgo+Pj4K
Pj4+IEJlY2F1c2Ugb2YgdGhpcyB3ZSBhdCBsZWFzdCBuZWVkIHRvIHdhaXQgZm9yIGFsbCBkZXBl
bmRlbmNpZXMgb2YgdGhlIAo+Pj4gam9iIGJlZm9yZSBzaWduYWxpbmcgdGhlIGZlbmNlLCBldmVu
IGlmIHdlIGNhbmNlbCB0aGUgam9iIGZvciBzb21lIAo+Pj4gcmVhc29uLgo+Pj4KPj4+IENocmlz
dGlhbi4KPj4KPj4gV291bGQgdGhpcyBiZSB0aGUgcmlnaHQgd2F5IHRvIGRvIGl0ID8KPiAKPiBZ
ZXMsIGl0IGlzIGF0IGxlYXN0IGEgc3RhcnQuIFF1ZXN0aW9uIGlzIGlmIHdlIGNhbiB3YWl0IGJs
b2NraW5nIGhlcmUgb3IgCj4gbm90Lgo+IAo+IFdlIGluc3RhbGwgYSBjYWxsYmFjayBhIGJpdCBs
b3dlciB0byBhdm9pZCBibG9ja2luZywgc28gSSdtIHByZXR0eSBzdXJlIAo+IHRoYXQgd29uJ3Qg
d29yayBhcyBleHBlY3RlZC4KPiAKPiBDaHJpc3RpYW4uCgpJIGNhbid0IHNlZSB3aHkgdGhpcyB3
b3VsZCBjcmVhdGUgcHJvYmxlbXMsIGFzIGxvbmcgYXMgdGhlIGRlcGVuZGVuY2llcwpjb21wbGV0
ZSBvciBmb3JjZSBjb21wZXRlZCBpZiB0aGV5IGFyZSBmcm9tIHNhbWUgZGV2aWNlIChleHRyYWN0
ZWQpIGJ1dApvbiBhIGRpZmZlcmVudCByaW5nIHRoZW4gbG9va3MgdG8gbWUgaXQgc2hvdWxkIHdv
cmsuIEkgd2lsbCBnaXZlIGl0CmEgdHJ5LgoKQW5kcmV5Cgo+IAo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKPj4gYi9kcml2ZXJzL2dw
dS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+IGluZGV4IDJlOTNlODgxYjY1Zi4uMTBm
Nzg0ODc0YjYzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X2VudGl0eS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMKPj4gQEAgLTIyMywxMCArMjIzLDE0IEBAIHN0YXRpYyB2b2lkIGRybV9zY2hlZF9lbnRpdHlf
a2lsbF9qb2JzKHN0cnVjdCAKPj4gZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+PiDCoHsKPj4g
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYjsKPj4gwqDCoMKgwqDCoMKg
wqAgaW50IHI7Cj4+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9mZW5jZSAqZjsKPj4KPj4gwqDC
oMKgwqDCoMKgwqAgd2hpbGUgKChqb2IgPSAKPj4gdG9fZHJtX3NjaGVkX2pvYihzcHNjX3F1ZXVl
X3BvcCgmZW50aXR5LT5qb2JfcXVldWUpKSkpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRfZmVuY2UgKnNfZmVuY2UgPSBqb2ItPnNfZmVuY2U7Cj4+
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlIChmID0gc2NoZWQtPm9wcy0+
ZGVwZW5kZW5jeShzY2hlZF9qb2IsIGVudGl0eSkpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFfZmVuY2Vfd2FpdChmKTsKPj4gKwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX2ZlbmNlX3NjaGVkdWxlZChzX2ZlbmNl
KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV9zZXRfZXJyb3Io
JnNfZmVuY2UtPmZpbmlzaGVkLCAtRVNSQ0gpOwo+Pgo+PiBBbmRyZXkKPj4KPj4KPj4KPj4+Cj4+
Pj4KPj4+PiBBbmRyZXkKPj4+Pgo+Pj4+Pgo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+Pgo+
Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJIGFtIG5vdCBz
dXJlIHRoaXMgcHJvYmxlbSB5b3UgZGVzY3JpYmUgYWJvdmUgaXMgcmVsYXRlZCB0byB0aGlzIAo+
Pj4+Pj4+PiBwYXRjaC4KPj4+Pj4+Pgo+Pj4+Pj4+IFdlbGwgaXQgaXMga2luZCBvZiByZWxhdGVk
Lgo+Pj4+Pj4+Cj4+Pj4+Pj4+IEhlcmUgd2UgcHVyZWx5IGV4cGFuZCB0aGUgY3JpdGVyaWEgZm9y
IHdoZW4gc2NoZWRfZW50aXR5IGlzCj4+Pj4+Pj4+IGNvbnNpZGVyZWQgaWRsZSBpbiBvcmRlciB0
byBwcmV2ZW50IGEgaGFuZyBvbiBkZXZpY2UgcmVtb3ZlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQW5kIGV4
YWN0bHkgdGhhdCBpcyBwcm9ibGVtYXRpYy4gU2VlIHRoZSBqb2JzIG9uIHRoZSBlbnRpdHkgbmVl
ZCAKPj4+Pj4+PiB0byBjbGVhbmx5IHdhaXQgZm9yIHRoZWlyIGRlcGVuZGVuY2llcyBiZWZvcmUg
dGhleSBjYW4gYmUgY29tcGxldGVkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9r
aWxsX2pvYnMoKSBpcyBhbHNvIG5vdCBoYW5kbGluZyB0aGF0IGNvcnJlY3RseSAKPj4+Pj4+PiBh
dCB0aGUgbW9tZW50LCB3ZSBvbmx5IHdhaXQgZm9yIHRoZSBsYXN0IHNjaGVkdWxlZCBmZW5jZSBi
dXQgbm90IAo+Pj4+Pj4+IGZvciB0aGUgZGVwZW5kZW5jaWVzIG9mIHRoZSBqb2IuCj4+Pj4+Pj4K
Pj4+Pj4+Pj4gV2VyZSB5b3UgYWRkcmVzc2luZyB0aGUgcGF0Y2ggZnJvbSB5ZXN0ZXJkYXkgaW4g
d2hpY2ggeW91IGNvbW1lbnRlZAo+Pj4+Pj4+PiB0aGF0IHlvdSBmb3VuZCBhIHByb2JsZW0gd2l0
aCBob3cgd2UgZmluaXNoIGZlbmNlcyA/IEl0IHdhcwo+Pj4+Pj4+PiAnW1BBVENIIHY3IDEyLzE2
XSBkcm0vYW1kZ3B1OiBGaXggaGFuZyBvbiBkZXZpY2UgcmVtb3ZhbC4nCj4+Pj4+Pj4+Cj4+Pj4+
Pj4+IEFsc28sIGluIHRoZSBwYXRjaCBzZXJpZXMgYXMgaXQgaXMgbm93IHdlIG9ubHkgc2lnbmFs
IEhXIGZlbmNlcyAKPj4+Pj4+Pj4gZm9yIHRoZQo+Pj4+Pj4+PiBleHRyYWN0ZWQgZGV2aWNlIEIs
IHdlIGFyZSBub3QgdG91Y2hpbmcgYW55IG90aGVyIGZlbmNlcy4gSW4gCj4+Pj4+Pj4+IGZhY3Qg
YXMgeW91Cj4+Pj4+Pj4+IG1heSByZW1lbWJlciwgSSBkcm9wcGVkIGFsbCBuZXcgbG9naWMgdG8g
Zm9yY2luZyBmZW5jZSAKPj4+Pj4+Pj4gY29tcGxldGlvbiBpbgo+Pj4+Pj4+PiB0aGlzIHBhdGNo
IHNlcmllcyBhbmQgb25seSBjYWxsIAo+Pj4+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNl
X2NvbXBsZXRpb24KPj4+Pj4+Pj4gZm9yIHRoZSBIVyBmZW5jZXMgb2YgdGhlIGV4dHJhY3RlZCBk
ZXZpY2UgYXMgaXQncyBkb25lIHRvZGF5IAo+Pj4+Pj4+PiBhbnl3YXkuCj4+Pj4+Pj4KPj4+Pj4+
PiBTaWduYWxpbmcgaGFyZHdhcmUgZmVuY2VzIGlzIHVucHJvYmxlbWF0aWMgc2luY2UgdGhleSBh
cmUgZW1pdHRlZCAKPj4+Pj4+PiB3aGVuIHRoZSBzb2Z0d2FyZSBzY2hlZHVsaW5nIGlzIGFscmVh
ZHkgY29tcGxldGVkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Cj4+Pj4+Pj4+
Cj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IE5vdCBzdXJlIGhv
dyB0byBoYW5kbGUgdGhhdCBjYXNlLiBPbmUgcG9zc2liaWxpdHkgd291bGQgYmUgdG8gCj4+Pj4+
Pj4+PiB3YWl0IGZvciBhbGwgZGVwZW5kZW5jaWVzIG9mIHVuc2NoZWR1bGVkIGpvYnMgYmVmb3Jl
IHNpZ25hbGluZyAKPj4+Pj4+Pj4+IHRoZWlyIGZlbmNlcyBhcyBjYW5jZWxlZC4KPj4+Pj4+Pj4+
Cj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQW0gMTIuMDUuMjEgdW0g
MTY6MjYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Pj4+PiBQcm9ibGVtOiBJZiBz
Y2hlZHVsZXIgaXMgYWxyZWFkeSBzdG9wcGVkIGJ5IHRoZSB0aW1lIHNjaGVkX2VudGl0eQo+Pj4+
Pj4+Pj4+IGlzIHJlbGVhc2VkIGFuZCBlbnRpdHkncyBqb2JfcXVldWUgbm90IGVtcHR5IEkgZW5j
b3VudHJlZAo+Pj4+Pj4+Pj4+IGEgaGFuZyBpbiBkcm1fc2NoZWRfZW50aXR5X2ZsdXNoLiBUaGlz
IGlzIGJlY2F1c2UgCj4+Pj4+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlCj4+Pj4+Pj4+
Pj4gbmV2ZXIgYmVjb21lcyBmYWxzZS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEZpeDogSW4gZHJt
X3NjaGVkX2ZpbmkgZGV0YWNoIGFsbCBzY2hlZF9lbnRpdGllcyBmcm9tIHRoZQo+Pj4+Pj4+Pj4+
IHNjaGVkdWxlcidzIHJ1biBxdWV1ZXMuIFRoaXMgd2lsbCBzYXRpc2Z5IAo+Pj4+Pj4+Pj4+IGRy
bV9zY2hlZF9lbnRpdHlfaXNfaWRsZS4KPj4+Pj4+Pj4+PiBBbHNvIHdha2V1cCBhbGwgdGhvc2Ug
cHJvY2Vzc2VzIHN0dWNrIGluIHNjaGVkX2VudGl0eSBmbHVzaGluZwo+Pj4+Pj4+Pj4+IGFzIHRo
ZSBzY2hlZHVsZXIgbWFpbiB0aHJlYWQgd2hpY2ggd2FrZXMgdGhlbSB1cCBpcyBzdG9wcGVkIGJ5
IAo+Pj4+Pj4+Pj4+IG5vdy4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IHYyOgo+Pj4+Pj4+Pj4+IFJl
dmVyc2Ugb3JkZXIgb2YgZHJtX3NjaGVkX3JxX3JlbW92ZV9lbnRpdHkgYW5kIG1hcmtpbmcKPj4+
Pj4+Pj4+PiBzX2VudGl0eSBhcyBzdG9wcGVkIHRvIHByZXZlbnQgcmVpbnNlcmlvbiBiYWNrIHRv
IHJxIGR1ZQo+Pj4+Pj4+Pj4+IHRvIHJhY2UuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiB2MzoKPj4+
Pj4+Pj4+PiBEcm9wIGRybV9zY2hlZF9ycV9yZW1vdmVfZW50aXR5LCBvbmx5IG1vZGlmeSBlbnRp
dHktPnN0b3BwZWQKPj4+Pj4+Pj4+PiBhbmQgY2hlY2sgZm9yIGl0IGluIGRybV9zY2hlZF9lbnRp
dHlfaXNfaWRsZQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdy
b2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+Pj4+Pj4+Pj4gUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+Pj4+
PiAtLS0KPj4+Pj4+Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0
eS5jIHzCoCAzICsrLQo+Pj4+Pj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfbWFpbi5jwqDCoCB8IDI0IAo+Pj4+Pj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKwo+
Pj4+Pj4+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgCj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4+Pj4+Pj4gaW5kZXggMDI0OWM3NDUwMTg4Li4yZTkz
ZTg4MWI2NWYgMTAwNjQ0Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9lbnRpdHkuYwo+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfZW50aXR5LmMKPj4+Pj4+Pj4+PiBAQCAtMTE2LDcgKzExNiw4IEBAIHN0YXRpYyBi
b29sIAo+Pj4+Pj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZShzdHJ1Y3QgZHJtX3NjaGVk
X2VudGl0eSAqZW50aXR5KQo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgcm1iKCk7IC8qIGZvciBsaXN0
X2VtcHR5IHRvIHdvcmsgd2l0aG91dCBsb2NrICovCj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAo
bGlzdF9lbXB0eSgmZW50aXR5LT5saXN0KSB8fAo+Pj4+Pj4+Pj4+IC0gc3BzY19xdWV1ZV9jb3Vu
dCgmZW50aXR5LT5qb2JfcXVldWUpID09IDApCj4+Pj4+Pj4+Pj4gKyBzcHNjX3F1ZXVlX2NvdW50
KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCB8fAo+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBl
bnRpdHktPnN0b3BwZWQpCj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVl
Owo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4+Pj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyAKPj4+Pj4+Pj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+Pj4gaW5kZXgg
OGQxMjExZTg3MTAxLi5hMmE5NTM2OTNiNDUgMTAwNjQ0Cj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+Pj4+Pj4+IEBAIC04OTgsOSArODk4
LDMzIEBAIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+Pj4+Pj4+Pj4+IMKgwqAgKi8K
Pj4+Pj4+Pj4+PiDCoCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxl
ciAqc2NoZWQpCj4+Pj4+Pj4+Pj4gwqAgewo+Pj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGRybV9z
Y2hlZF9lbnRpdHkgKnNfZW50aXR5Owo+Pj4+Pj4+Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4+Pj4+
Pj4gKwo+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqAgaWYgKHNjaGVkLT50aHJlYWQpCj4+Pj4+Pj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGt0aHJlYWRfc3RvcChzY2hlZC0+dGhyZWFkKTsKPj4+Pj4+Pj4+
PiArwqDCoMKgIGZvciAoaSA9IERSTV9TQ0hFRF9QUklPUklUWV9DT1VOVCAtIDE7IGkgPj0gCj4+
Pj4+Pj4+Pj4gRFJNX1NDSEVEX1BSSU9SSVRZX01JTjsgaS0tKSB7Cj4+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRfcnEgKnJxID0gJnNjaGVkLT5zY2hlZF9ycVtpXTsK
Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcnEpCj4+Pj4+Pj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJnJxLT5sb2NrKTsKPj4+Pj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShzX2VudGl0eSwgJnJxLT5lbnRpdGllcywg
bGlzdCkKPj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBQcmV2ZW50cyByZWluc2VydGlvbiBhbmQgbWFya3Mg
am9iX3F1ZXVlIGFzIGlkbGUsCj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGl0IHdpbGwgcmVtb3ZlZCBmcm9tIHJxIGluIGRybV9zY2hlZF9lbnRpdHlfZmluaQo+Pj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBldmVudHVhbGx5Cj4+Pj4+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNfZW50aXR5LT5zdG9wcGVkID0gdHJ1ZTsKPj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
c3Bpbl91bmxvY2soJnJxLT5sb2NrKTsKPj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4gK8KgwqDCoCB9
Cj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+ICvCoMKgwqAgLyogV2FrZXVwIGV2ZXJ5b25lIHN0dWNr
IGluIGRybV9zY2hlZF9lbnRpdHlfZmx1c2ggZm9yIAo+Pj4+Pj4+Pj4+IHRoaXMgc2NoZWR1bGVy
ICovCj4+Pj4+Pj4+Pj4gK8KgwqDCoCB3YWtlX3VwX2FsbCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQp
Owo+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+PiDCoMKgwqDCoMKgIC8qIENvbmZpcm0gbm8gd29yayBs
ZWZ0IGJlaGluZCBhY2Nlc3NpbmcgZGV2aWNlIAo+Pj4+Pj4+Pj4+IHN0cnVjdHVyZXMgKi8KPj4+
Pj4+Pj4+PiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnNjaGVkLT53b3JrX3Rkcik7Cj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Cj4+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
