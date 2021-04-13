Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E5C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA273613C7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA273613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A098992E;
	Tue, 13 Apr 2021 18:03:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173EB8992E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 18:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVv/W3Kjx+gT4h7/wv1t89XSZ/9P2H+3CEXucq0a3dCQ0KTKkmaaH0j8H8Okt79DNIRf7YXh5foKlYYmm/1VT9lxf9xiEfunBZ/2CwFXi1IUuBFlxcxRj1pebpC2dv6ZhudqWITof8/WzenXl/V4qcVKn8nGHlkU29SNxrqufQlBYXBz2uwreQS8T3pMe0z4jtdeOpF/xSx90CtcGG4hEYS60UceAAJu7bEGhqkF8KgV2gbA5GqlRlkXLYMn4BbQXilI6lRS4hd0mlXq4U1ZfZVxwlW6Q/0kzztEnDT+p7fGYnyoKlSiSyK3oMRnPjwaEn1JgL5hiH0HkleyKXFO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBGmUz+G/LBIZuH7nLF0M/bwWn+Cp5HTOTJ0qAuIrFQ=;
 b=H2dKRNCLiOKxOdyIIBtMdxNclncdWIIgh+4EiFKx5l7aqe7A8Sg9mKnTD7vMGtQZdaNHFhTXuIrq5ETzN3fUnfVWyA2RP7DOB2645lvcsj2aAXNKF4d+Q9qVQlHy5jsIv35F1cLKE05sIqqRL0SDcKioheA+E0CmyerWz+c79C8JEQQ+CA980pfShe6EE4wlUzhQHXM/z/OPSkufrliNnUCiSQ8ettqMzDYCZOPlFlj89mA3ZeJoCLnQLhBf2TD7oXEiiifkMhkhttmACtU/pMqvAs4ou6i7rBQsKVOFwXbM3t3DzeIpyE7m8VZFrUcNEMKMO67+bpJGN+C1OzPS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBGmUz+G/LBIZuH7nLF0M/bwWn+Cp5HTOTJ0qAuIrFQ=;
 b=Nqap02Sr1bGtnCQG4BCadG+zRf+uJ5W4/jwx6sfc1krb0NP7YCNezaJjR/+RLt7FM4g6W7/azlx0hw1sSJ9OK57kehA5RfJTrHwy6aAwZPY1/xP2WH+ETOiaYaZKPVgY01dMQpiI1VZJgOnGpankDykumA9/YGR8lsoxm0B5eKs=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 18:03:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:03:21 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
Date: Tue, 13 Apr 2021 20:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:68fb:3c11:fcc3:c883]
X-ClientProxiedBy: PR0P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:68fb:3c11:fcc3:c883]
 (2a02:908:1252:fb60:68fb:3c11:fcc3:c883) by
 PR0P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 18:03:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec656b3-e7af-4a13-d3d8-08d8fea66a4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4389D64B1848A40E6C3064C3834F9@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bMV/IOONuWg/wr0tbmoHEaGuFE+Oj6ylU/AwmllrkvTXzdShH4/aw6Vmk5e7PwZIsXL14lz6hSClhXKgQ1IcZftTuHZf6NRxcMAsJPZljR0BObvkESWuArSzdETFoJlF2SDmxYxlgQpo07hagI8QET1SG/PjPiO+7AwB45UfGHok2dpAXOwSHfMfqB3eCsgOS6a/qDivijsuSoO99kulDrTQqmlqGAbLc4xqo3vvKwec7XaA9eFqs+zIPHMhPON4aR0LDgyDHyPYa5l48jen7kYx6JMZ+Yc3moMinBqMu5EVk4QJNDm8hxl460lTb0hyF29qGEozEsJdDrK0ceQ3azWPceIhDKYYxX2XcVD+W8vQnLvWNuk7IeOQ2l62up/nP4NPraAnRwICzajITd9DPCo8ygzi+yEz+T00dpeEru/0EcVMYgdt0BoNBbtx3zrUGLCSONHHXRD49O9uXSsA8uPlK7jnQkbvLUFrvjFzxebo5jv0dvYGPzeMOn+VHhU4JlIfpmkk8/QJGR1B65IUN61uuEDg7+wba9JsjM/oBAKCabL05+uAxVe1xAEwH8GXlIZvoJPfbKzmdICzqqr5XWKGQ1M7k0wf0GNlOf7hLzFteyyrbtB91zB8LHZW/ZfZ/hOCVoNS9iXigLA1eBYqPxY6JQJOIXPhObzeJ5TD0S9oAfXzrtjqpk1d6QeHU+bDKAT+KQ5CrjPhb/VpKhxHztBPeHCF6CE8JDoUUjldyngxlp9YTyzskYYTpdsz4LvQWE1krV78pwkNdkHrSobfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(16526019)(316002)(45080400002)(8676002)(31696002)(110136005)(478600001)(8936002)(186003)(66946007)(66556008)(83380400001)(6666004)(6486002)(921005)(31686004)(2616005)(2906002)(66476007)(52116002)(38100700002)(66574015)(36756003)(86362001)(5660300002)(53546011)(966005)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vk1hQ3R6QzNMS055R0dtZjhjQndzRmNjenh4YjFQUTN6WTNGaTJzVS9GY09E?=
 =?utf-8?B?UlhSZXhaVW9QS0lBUi92elo3R3RXVTRhenBnNmtvZlBMUkFPWEpWT3paOTZN?=
 =?utf-8?B?QjI4RFZqaGkzTWUyRzNjaENzMkgzMWFtTTRSRkNOY3dpbG5JeVhUMm5xOC9S?=
 =?utf-8?B?TFQvMm16cVk5eGk1dVpYWjlqblZVM3NEKzEwUWk5K1lvQ3dzd1Q5TC9BTUJG?=
 =?utf-8?B?QzIrSXRmcW8zQ3JjMVd5M2docEJpNHhhYWQ5MHc2cWRrMG91OTBaVmJFazdt?=
 =?utf-8?B?Y3ZNQWVOUUlVdHJkZkVMQWFnZ2owYThVNTQwQnVORDNYREl6OGJtMC9lMi9w?=
 =?utf-8?B?cnoxUUc4bStyb2FwTGxLT3lzaFR1OVB1S0dMeU5WOXVOblZBbFY4eFBYK0JC?=
 =?utf-8?B?VGRxakRvU2ZjdC9UMHlkQ0gxNUxpSWRsSGI4RERlaDBXSU5sUm5tN1NPTDZK?=
 =?utf-8?B?SEFuaVlQeUxSWUVZNWxFWEV1TGdGNEEvQUMybGh6ZU8zTkZoZFJiTS95aTlT?=
 =?utf-8?B?SzR6YTBROCs4V3k5bzBNTkRrVWZ4T0JMME11dCtEMEFvNmJQS0ptNG5EcGFO?=
 =?utf-8?B?ZHJVb3FtTHFyMEx0UzQ2RkRvVWlXcit3cVhZNTNBNkdUSnM4QzY1UmYrRDFN?=
 =?utf-8?B?VlgvTU9CaG9nNEdTMnZ2ajBTckJKRkVicEdQQzdBeXYxVHIwZjNzYXZzSWY2?=
 =?utf-8?B?VnZYWTBFSWQ2OUwzdDlEQUl4bDVBRXB5OXRCb01YQXRGN1J1N1R5TEdLNGMr?=
 =?utf-8?B?N2VoZ2s5a2RyeHJoTkdPYnZLTk9qdnZMR2pvWkFTOW5IQTVybnprb25qS1Rj?=
 =?utf-8?B?RWQ1UitLSVQ2SWx3Nk9DWExUd3Nqb2h2dUU1K3RIVEprMktxZ1JzNjQyekl0?=
 =?utf-8?B?aEgrYTVISDZGaWxrQ0drUkt4UGFrWnljKzA3Y0JEN2NRSjFGYWVNYVoxV1BQ?=
 =?utf-8?B?VUQ0Z0N1UGE2dndFa2s4blM5eHZmREw2aHh1ZGtmaGZpTjNtM2dYaUI3TkdO?=
 =?utf-8?B?VFpLalE5SW1hUTZneCs4dGNaU0VsUldEaWpIRmhpbDcvb0UvYXh6Z0lUakxL?=
 =?utf-8?B?TWFwQ0dSK2xzZUZ5czZ6czhPQ2RiNFdrQTBEb1RPK0ZCUUdWNmVyTE8rQ29v?=
 =?utf-8?B?UDg5cXNSZzVxMEZkU2xpTk5sNmhGTTA5NFhoUUhOTWcrOHAwdkJBN3BFeXha?=
 =?utf-8?B?NlFmK0VxYVBNMyswMHVlNzRsaXkvbFdlMUpTTkEzeld1YUkyVG5lbU1tK2ZG?=
 =?utf-8?B?RWNLMmNyOXN3VmtkbTJOUWlXWElCSXZwV3Z5MHNjdUY2VXdOc0tFaEZTTmdQ?=
 =?utf-8?B?d1FjVXZGRVo4YTUvS2M2eUE1aEJuL2VwL0FuWkpVT3dJaTd0ZW0rV0FxdW94?=
 =?utf-8?B?d1FZRVpvREduem5oS055OURXZHh2RU5oNnczLzNnMUN3YWliWFAvVmRDdnBh?=
 =?utf-8?B?ZlowRDdUNlZsLzJJRzZzZkZWNW5jNWFlOGJQQlhSMXhQSXR2OGNPM2tTK3Zt?=
 =?utf-8?B?dHlMOStCaWJDdjE1ck12d2xlRWFlTTJNOUxQZnU4bmU4QWZVT3hWck1QaUNM?=
 =?utf-8?B?VndrZnR3T0lUWno2MGZzcGVsMXV6cng3blF6TzNMRWgwR2x0RDl5T2pMckxG?=
 =?utf-8?B?MjNPcENKNzk5UlpSYXpleXkvT1M1bjZmOHNSeXlVZVN3UHlPOUl1NGRGbWd2?=
 =?utf-8?B?NjNqN1ZPZ2p5NC9sSmVxdXVrVllXWGd1SUh1M0hCWWdDTWtXc04yUU52NHhG?=
 =?utf-8?B?YlY5OWFkNDlYZDNmSldZVlExblkra1ZtcldXd0ZIYklTTnl5K095d3dxQWhJ?=
 =?utf-8?B?VWM3cnd5WWkxSWMwZ1hTL1BNZUlRaG5xekJwN2lKQ3ZhWGZvS0xFREMwYnFW?=
 =?utf-8?Q?Hc5WasorkTHYb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec656b3-e7af-4a13-d3d8-08d8fea66a4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:03:20.6153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vO/5YmvcFRsLVqEirGJysTUTE/wBCpQKJg72FodHaM7YD3qD4KHpkkqlJM0qUBHw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDQuMjEgdW0gMTc6MTIgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDQtMTMgMzoxMCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMi4wNC4y
MSB1bSAyMjowMSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4KPj4+IE9uIDIwMjEtMDQt
MTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDEyLjA0LjIxIHVt
IDIxOjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+IFtTTklQXQo+Pj4+Pj4+Cj4+
Pj4+Pj4gU28gd2hhdCdzIHRoZSByaWdodCBhcHByb2FjaCA/IEhvdyB3ZSBndWFyYW50ZWUgdGhh
dCB3aGVuIAo+Pj4+Pj4+IHJ1bm5pbmcgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0
aW9uIHdlIHdpbGwgc2lnbmFsIGFsbCAKPj4+Pj4+PiB0aGUgSFcgZmVuY2VzIGFuZCBub3QgcmFj
aW5nIGFnYWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gCj4+Pj4+Pj4gaW50byB0aGF0
IGFycmF5ID8KPj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFdlbGwgSSB3b3VsZCBzdGlsbCBzYXkgdGhl
IGJlc3QgYXBwcm9hY2ggd291bGQgYmUgdG8gaW5zZXJ0IHRoaXMgCj4+Pj4+PiBiZXR3ZWVuIHRo
ZSBmcm9udCBlbmQgYW5kIHRoZSBiYWNrZW5kIGFuZCBub3QgcmVseSBvbiBzaWduYWxpbmcgCj4+
Pj4+PiBmZW5jZXMgd2hpbGUgaG9sZGluZyB0aGUgZGV2aWNlIHNyY3UuCj4+Pj4+Cj4+Pj4+Cj4+
Pj4+IE15IHF1ZXN0aW9uIGlzLCBldmVuIG5vdywgd2hlbiB3ZSBydW4gCj4+Pj4+IGFtZGdwdV9m
ZW5jZV9kcml2ZXJfZmluaV9ody0+YW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkgb3IgCj4+Pj4+IGFt
ZGdwdV9mZW5jZV9kcml2ZXJfZmluaV9ody0+YW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21w
bGV0aW9uLCAKPj4+Pj4gd2hhdCB0aGVyZSBwcmV2ZW50cyBhIHJhY2Ugd2l0aCBhbm90aGVyIGZl
bmNlIGJlaW5nIGF0IHRoZSBzYW1lIAo+Pj4+PiB0aW1lIGVtaXR0ZWQgYW5kIGluc2VydGVkIGlu
dG8gdGhlIGZlbmNlIGFycmF5ID8gTG9va3MgbGlrZSBub3RoaW5nLgo+Pj4+Pgo+Pj4+Cj4+Pj4g
RWFjaCByaW5nIGNhbiBvbmx5IGJlIHVzZWQgYnkgb25lIHRocmVhZCBhdCB0aGUgc2FtZSB0aW1l
LCB0aGlzIAo+Pj4+IGluY2x1ZGVzIGVtaXR0aW5nIGZlbmNlcyBhcyB3ZWxsIGFzIG90aGVyIHN0
dWZmLgo+Pj4+Cj4+Pj4gRHVyaW5nIEdQVSByZXNldCB3ZSBtYWtlIHN1cmUgbm9ib2R5IHdyaXRl
cyB0byB0aGUgcmluZ3MgYnkgCj4+Pj4gc3RvcHBpbmcgdGhlIHNjaGVkdWxlciBhbmQgdGFraW5n
IHRoZSBHUFUgcmVzZXQgbG9jayAoc28gdGhhdCAKPj4+PiBub2JvZHkgZWxzZSBjYW4gc3RhcnQg
dGhlIHNjaGVkdWxlciBhZ2FpbikuCj4+Pgo+Pj4KPj4+IFdoYXQgYWJvdXQgZGlyZWN0IHN1Ym1p
c3Npb25zIG5vdCB0aHJvdWdoIHNjaGVkdWxlciAtIAo+Pj4gYW1kZ3B1X2pvYl9zdWJtaXRfZGly
ZWN0LCBJIGRvbid0IHNlZSBob3cgdGhpcyBpcyBwcm90ZWN0ZWQuCj4+Cj4+IFRob3NlIG9ubHkg
aGFwcGVuIGR1cmluZyBzdGFydHVwIGFuZCBHUFUgcmVzZXQuCj4KPgo+IE9rLCBidXQgdGhlbiBs
b29rcyBsaWtlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsIHNlZSB0aGUgZm9sbG93aW5nIAo+IHN0
ZXBzIGluIGFtZGdwdV9wY2lfcmVtb3ZlIC0KPgo+IDEpIFVzZSBkaXNhYmxlX2lycSBBUEkgZnVu
Y3Rpb24gdG8gc3RvcCBhbmQgZmx1c2ggYWxsIGluIGZsaWdodCBIVyAKPiBpbnRlcnJ1cHRzIGhh
bmRsZXJzCj4KPiAyKSBHcmFiIHRoZSByZXNldCBsb2NrIGFuZCBzdG9wIGFsbCB0aGUgc2NoZWR1
bGVycwo+Cj4gQWZ0ZXIgYWJvdmUgMiBzdGVwcyB0aGUgSFcgZmVuY2VzIGFycmF5IGlzIGlkbGUs
IG5vIG1vcmUgaW5zZXJ0aW9ucyAKPiBhbmQgbm8gbW9yZSBleHRyYWN0aW9ucyBmcm9tIHRoZSBh
cnJheQo+Cj4gMykgUnVuIG9uZSB0aW1lIGFtZGdwdV9mZW5jZV9wcm9jZXNzIHRvIHNpZ25hbCBh
bGwgY3VycmVudCBIVyBmZW5jZXMKPgo+IDQpIFNldCBkcm1fZGV2X3VucGx1ZyAod2lsbCAnZmx1
c2gnIGFsbCBpbiBmbGlnaHQgSU9DVExzKSwgcmVsZWFzZSB0aGUgCj4gR1BVIHJlc2V0IGxvY2sg
YW5kIGdvIG9uIHdpdGggdGhlIHJlc3Qgb2YgdGhlIHNlcXVlbmNlIChjYW5jZWwgdGltZXJzLCAK
PiB3b3JrIGl0ZW1zIGUudC5jKQo+Cj4gV2hhdCdzIHByb2JsZW1hdGljIGluIHRoaXMgc2VxdWVu
Y2UgPwoKZHJtX2Rldl91bnBsdWcoKSB3aWxsIHdhaXQgZm9yIHRoZSBJT0NUTHMgdG8gZmluaXNo
LgoKVGhlIElPQ1RMcyBpbiB0dXJuIGNhbiB3YWl0IGZvciBmZW5jZXMuIFRoYXQgY2FuIGJlIGJv
dGggaGFyZHdhcmUgCmZlbmNlcywgc2NoZWR1bGVyIGZlbmNlcywgYXMgd2VsbCBhcyBmZW5jZXMg
ZnJvbSBvdGhlciBkZXZpY2VzIChhbmQgS0lRIApmZW5jZXMgZm9yIHJlZ2lzdGVyIHdyaXRlcyB1
bmRlciBTUklPViwgYnV0IHdlIGNhbiBob3BlZnVsbHkgaWdub3JlIHRoZW0gCmZvciBub3cpLgoK
V2UgaGF2ZSBoYW5kbGVkIHRoZSBoYXJkd2FyZSBmZW5jZXMsIGJ1dCB3ZSBoYXZlIG5vIGlkZWEg
d2hlbiB0aGUgCnNjaGVkdWxlciBmZW5jZXMgb3IgdGhlIGZlbmNlcyBmcm9tIG90aGVyIGRldmlj
ZXMgd2lsbCBzaWduYWwuCgpTY2hlZHVsZXIgZmVuY2VzIHdvbid0IHNpZ25hbCB1bnRpbCB0aGUg
c2NoZWR1bGVyIHRocmVhZHMgYXJlIHJlc3RhcnRlZCAKb3Igd2Ugc29tZWhvdyBjYW5jZWwgdGhl
IHN1Ym1pc3Npb25zLiBEb2FibGUsIGJ1dCB0cmlja3kgYXMgd2VsbC4KCkZvciB3YWl0aW5nIGZv
ciBvdGhlciBkZXZpY2UgSSBoYXZlIG5vIGlkZWEgaWYgdGhhdCBjb3VsZG4ndCBkZWFkbG9jayAK
c29tZWhvdy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBBbmRyZXkKPgo+Cj4+Cj4+Cj4+Pj4K
Pj4+Pj4+Cj4+Pj4+PiBCVFc6IENvdWxkIGl0IGJlIHRoYXQgdGhlIGRldmljZSBTUkNVIHByb3Rl
Y3RzIG1vcmUgdGhhbiBvbmUgCj4+Pj4+PiBkZXZpY2UgYW5kIHdlIGRlYWRsb2NrIGJlY2F1c2Ug
b2YgdGhpcz8KPj4+Pj4KPj4+Pj4KPj4+Pj4gSSBoYXZlbid0IGFjdHVhbGx5IGV4cGVyaWVuY2Vk
IGFueSBkZWFkbG9jayB1bnRpbCBub3cgYnV0LCB5ZXMsIAo+Pj4+PiBkcm1fdW5wbHVnX3NyY3Ug
aXMgZGVmaW5lZCBhcyBzdGF0aWMgaW4gZHJtX2Rydi5jIGFuZCBzbyBpbiB0aGUgCj4+Pj4+IHBy
ZXNlbmNlwqAgb2YgbXVsdGlwbGUgZGV2aWNlcyBmcm9tIHNhbWUgb3IgZGlmZmVyZW50IGRyaXZl
cnMgd2UgaW4gCj4+Pj4+IGZhY3QgYXJlIGRlcGVuZGVudCBvbiBhbGwgdGhlaXIgY3JpdGljYWwg
c2VjdGlvbnMgaSBndWVzcy4KPj4+Pj4KPj4+Pgo+Pj4+IFNoaXQsIHllYWggdGhlIGRldmlsIGlz
IGEgc3F1aXJyZWwuIFNvIGZvciBBK0kgbGFwdG9wcyB3ZSBhY3R1YWxseSAKPj4+PiBuZWVkIHRv
IHN5bmMgdGhhdCB1cCB3aXRoIERhbmllbCBhbmQgdGhlIHJlc3Qgb2YgdGhlIGk5MTUgZ3V5cy4K
Pj4+Pgo+Pj4+IElJUkMgd2UgY291bGQgYWN0dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNlIGlu
IGEgZG9ja2luZyBzdGF0aW9uIAo+Pj4+IHdoaWNoIG5lZWRzIGhvdHBsdWcgYW5kIHRoZSBkcml2
ZXIgbWlnaHQgZGVwZW5kIG9uIHdhaXRpbmcgZm9yIHRoZSAKPj4+PiBpOTE1IGRyaXZlciBhcyB3
ZWxsLgo+Pj4KPj4+Cj4+PiBDYW4ndCB3ZSBwcm9wb3NlIGEgcGF0Y2ggdG8gbWFrZSBkcm1fdW5w
bHVnX3NyY3UgcGVyIGRybV9kZXZpY2UgPyBJIAo+Pj4gZG9uJ3Qgc2VlIHdoeSBpdCBoYXMgdG8g
YmUgZ2xvYmFsIGFuZCBub3QgcGVyIGRldmljZSB0aGluZy4KPj4KPj4gSSdtIHJlYWxseSB3b25k
ZXJpbmcgdGhlIHNhbWUgdGhpbmcgZm9yIHF1aXRlIGEgd2hpbGUgbm93Lgo+Pgo+PiBBZGRpbmcg
RGFuaWVsIGFzIHdlbGwsIG1heWJlIGhlIGtub3dzIHdoeSB0aGUgZHJtX3VucGx1Z19zcmN1IGlz
IGdsb2JhbC4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4KPj4+IEFuZHJleQo+
Pj4KPj4+Cj4+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gQW5kcmV5Cj4+Pj4+Cj4+Pj4+
Cj4+Pj4+Pgo+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4KPj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pgo+
Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IMKgwqDC
oCAvKiBQYXN0IHRoaXMgcG9pbnQgbm8gbW9yZSBmZW5jZSBhcmUgc3VibWl0dGVkIHRvIEhXIAo+
Pj4+Pj4+Pj4+PiByaW5nIGFuZCBoZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9yY2Ugc2lnbmFs
IG9uIGFsbCB0aGF0IAo+Pj4+Pj4+Pj4+PiBhcmUgY3VycmVudGx5IHRoZXJlLgo+Pj4+Pj4+Pj4+
PiDCoMKgwqDCoCAqIEFueSBzdWJzZXF1ZW50bHkgY3JlYXRlZMKgIEhXIGZlbmNlcyB3aWxsIGJl
IHJldHVybmVkIAo+Pj4+Pj4+Pj4+PiBzaWduYWxlZCB3aXRoIGFuIGVycm9yIGNvZGUgcmlnaHQg
YXdheQo+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqLwo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiDCoMKg
wqAgZm9yX2VhY2hfcmluZyhhZGV2KQo+Pj4+Pj4+Pj4+PiDCoMKgwqAgwqDCoMKgIGFtZGdwdV9m
ZW5jZV9wcm9jZXNzKHJpbmcpCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IMKgwqDCoCBkcm1fZGV2
X3VucGx1ZyhkZXYpOwo+Pj4+Pj4+Pj4+PiDCoMKgwqAgU3RvcCBzY2hlZHVsZXJzCj4+Pj4+Pj4+
Pj4+IMKgwqDCoCBjYW5jZWxfc3luYyhhbGwgdGltZXJzIGFuZCBxdWV1ZWQgd29ya3MpOwo+Pj4+
Pj4+Pj4+PiDCoMKgwqAgaHdfZmluaQo+Pj4+Pj4+Pj4+PiDCoMKgwqAgdW5tYXBfbW1pbwo+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
IEFuZHJleQo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IEFsdGVybmF0
aXZlbHkgZ3JhYmJpbmcgdGhlIHJlc2V0IHdyaXRlIHNpZGUgYW5kIAo+Pj4+Pj4+Pj4+Pj4+Pj4+
IHN0b3BwaW5nIGFuZCB0aGVuIHJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCB3b3JrIAo+
Pj4+Pj4+Pj4+Pj4+Pj4+IGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+IEkgZGlkbid0IGdldCB0aGUgYWJvdmUgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBJIG5lZWQgdG8g
Cj4+Pj4+Pj4+Pj4+Pj4+PiByZXVzZSB0aGUgR1BVIHJlc2V0IHJ3X2xvY2suIEkgcmVseSBvbiB0
aGUgU1JDVSB1bnBsdWcgCj4+Pj4+Pj4+Pj4+Pj4+PiBmbGFnIGZvciB1bnBsdWcuIEFsc28sIG5v
dCBjbGVhciB0byBtZSB3aHkgYXJlIHdlIAo+Pj4+Pj4+Pj4+Pj4+Pj4gZm9jdXNpbmcgb24gdGhl
IHNjaGVkdWxlciB0aHJlYWRzLCBhbnkgY29kZSBwYXRjaCB0byAKPj4+Pj4+Pj4+Pj4+Pj4+IGdl
bmVyYXRlIEhXIGZlbmNlcyBzaG91bGQgYmUgY292ZXJlZCwgc28gYW55IGNvZGUgCj4+Pj4+Pj4+
Pj4+Pj4+PiBsZWFkaW5nIHRvIGFtZGdwdV9mZW5jZV9lbWl0IG5lZWRzIHRvIGJlIHRha2VuIGlu
dG8gCj4+Pj4+Pj4+Pj4+Pj4+PiBhY2NvdW50IHN1Y2ggYXMsIGRpcmVjdCBJQiBzdWJtaXNzaW9u
cywgVk0gZmx1c2hlcyBlLnQuYwo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBZb3UgbmVl
ZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0IGxvY2sgYW55d2F5LCAKPj4+Pj4+Pj4+
Pj4+Pj4gY2F1c2UgYSBob3RwbHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGEgcmVz
ZXQuCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IEZvciBnb2luZyBt
eSB3YXkgaW5kZWVkIG5vdyBJIHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gdGFrZSAKPj4+Pj4+Pj4+
Pj4+PiByZXNldCB3cml0ZSBzaWRlIGxvY2sgZHVyaW5nIEhXIGZlbmNlcyBzaWduYWxsaW5nIGlu
IG9yZGVyIAo+Pj4+Pj4+Pj4+Pj4+IHRvIHByb3RlY3QgYWdhaW5zdCBzY2hlZHVsZXIvSFcgZmVu
Y2VzIGRldGFjaG1lbnQgYW5kIAo+Pj4+Pj4+Pj4+Pj4+IHJlYXR0YWNobWVudCBkdXJpbmcgc2No
ZWR1bGVycyBzdG9wL3Jlc3RhcnQuIEJ1dCBpZiB3ZSBnbyAKPj4+Pj4+Pj4+Pj4+PiB3aXRoIHlv
dXIgYXBwcm9hY2jCoCB0aGVuIGNhbGxpbmcgZHJtX2Rldl91bnBsdWcgYW5kIAo+Pj4+Pj4+Pj4+
Pj4+IHNjb3BpbmcgYW1kZ3B1X2pvYl90aW1lb3V0IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNo
b3VsZCAKPj4+Pj4+Pj4+Pj4+PiBiZSBlbm91Z2ggdG8gcHJldmVudCBhbnkgY29uY3VycmVudCBH
UFUgcmVzZXRzIGR1cmluZyAKPj4+Pj4+Pj4+Pj4+PiB1bnBsdWcuIEluIGZhY3QgSSBhbHJlYWR5
IGRvIGl0IGFueXdheSAtIAo+Pj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9y
ZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZp
ZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQl
N0MwMSU3Q2FuZHJleS5ncm9kem92c2t5JTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVjMzRhZWRmZTZk
MDhkOGZlNGIzOTQ3JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzUzODk0NjMyNDg1NzM2OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0Mx
MDAwJmFtcDtzZGF0YT02NDM2MlBSQzh4VGdSMlVqMlIyNTZiTWVnVm04WVdxMUtJJTJCQWp6ZVlY
djQlM0QmYW1wO3Jlc2VydmVkPTAKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBZZXMsIGdvb2Qg
cG9pbnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Cj4+Pj4+Pgo+Pj4+Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
