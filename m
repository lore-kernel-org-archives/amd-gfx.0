Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F6C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 07:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39CA61242
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 07:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39CA61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEAC6E8EC;
	Wed, 14 Apr 2021 07:01:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1421B6E8EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 07:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6VMMSYPx+e4g7GHlgRgolmObfXCX73XFseCF9KJkJ1HjCnT+UKvIZOvubhqsZscTWhsAk9+llhjkoZvgIw9LMGFqsjSJwu1kzlFTHTJsNEdEtu0HBveXhYiBacOsQLBJWULLC0VVwlwPHCCQRKojYMDY8BdY2ng+Hedo8rRp7nspNryW++XFJJz625OSgSZ7aHOf29CWFHcY91EmitdOIBYZDkpgffIwV7QKtBNb5R+5HbYMaoH1o1XZC078sGtOrL3zHBnp51mX/SVZXQJvFNMiDm0B+nQR8vrRh/DYdi5ZtIKXAMJp0WcyAWQoQKHc/EMhhbq0X+XIlwWrIYsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBgFpXHL81JOiSaGuV9L4v2ZrWvkR9O04TfEGNOQwiQ=;
 b=kGpxMXHPqTNthopGbuO9JJiD9ThM5+MS196K2A2wrYr67TV/6ONSnZK/sZeDTufcowys7slE+94MMGuLFD/A/mVSqJ21vRJbo8Bfx70lKH8oGd70a2Lc+JqAXHHQyJ8eNE8yoxWNVf+6maXTJmddbvBqRNOZRUqECA9slvW4OdCgwDyt/v7uZAxv6ynjkLDUwGd9nYhaM5M4BVgPnaNlltJMtNTAKOLTm3N8lWBi5QeGp3r2UXLFstHixmtaZKDaTsCWUEO1y120C8/IpEhVFj6zvHepsk5lAJopM5YQb6+dxSAtvsNet0P1oIW14n6LbS1tGYp+ZtrVaTqYR1WTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBgFpXHL81JOiSaGuV9L4v2ZrWvkR9O04TfEGNOQwiQ=;
 b=JW+HMq+89h8MFpub23UNVlhyVl1kQPsrINQHoYFix2B3sH1UTdbUm++2D1Wh1G6+zL6h8Fay8XOuhR5jZYWdaAx2EJOaArcxp5DiF7Z6HRIkIm3uUjXMLgrrMYZ/9F1MfP0NMd8XjxNZTiVDXFqJlkYPVhqfzNq0uaVsQWINyWQ=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Wed, 14 Apr
 2021 07:01:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 07:01:22 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
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
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
 <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
 <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
Date: Wed, 14 Apr 2021 09:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:eb49:bad8:5b80:ea48]
X-ClientProxiedBy: PR3P195CA0011.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:eb49:bad8:5b80:ea48]
 (2a02:908:1252:fb60:eb49:bad8:5b80:ea48) by
 PR3P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 07:01:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e62e3e9c-239e-4bec-10ec-08d8ff131c3b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566AF8D3658BAA608E4FF7F834E9@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAuvFfnNsZYGI6ZUIBR3iY7VsTL7Rhc9+wArdjkodR+0wnjyGhr27yB9ASt1d/Jqe8QeS227JbIishjzdDhzDnWiSjIYpZIZpLYRivwHNKVeB8j0oxoQDzoitHnTPrJwQO4Krh86vyHkRZVQFTA+PVu7O0gbQxiwGHlaLLZNqIrfT4ZJK9FLLaFQwNQ53GZ4o8n0RdZ8Qec17zu+agrQ8HXnKs5zfZljzaA4aaqQdmZOC2wMb6IEvw/+LwyR4E7rALyTdpzA3M4vur7Vt3oiCyco3NqWmsG06BV+uHFxlWCC+B8d1eHwEMkjd3F7cch9L0lCaZQBwMBQuhm61hhrVneKOJ2Cd7zCcl5dwFxSzgzZ1yxCwYpnrf35xz+9QFjHeOd3u7YR67qpw454wk3gxJoT8aoi9yCrLC6DshMOpgSpqrQoNvkFBlxRj0cj6YaexK72ddLGGwoIkGGpxDWcRk/X4PNlha3BJdChqYBB+7iuynGZvNuAYxDsYJiwS0FlZzY0VgcobvrgRAF5S0x/OAYLsDbeLUDLtZQGFLO6yIMz3VuEF147JtxNIFwG3FXRQi/TW6aR+u9ohXFMrCu7o6HxzwybLwRS24noAhDranfKShZaeNmRAI7KgQuWD1OZpxWzj5FhXrncluaOGJ2MjohGONCcIpvGAHx1Kg+dHwUKifePQiEhLS6IrfIogvkHrZsqKQJaQj2PBCp1ekSb70U8cyRbvn3rmhkPHN3dIUqcv9dTSy537P68keDHed4ZwwTc0bpDZPkJyvE71/hb4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(966005)(5660300002)(8676002)(53546011)(31686004)(66946007)(66476007)(66556008)(6486002)(45080400002)(110136005)(38100700002)(36756003)(83380400001)(66574015)(478600001)(31696002)(16526019)(8936002)(316002)(186003)(921005)(2906002)(6666004)(30864003)(86362001)(2616005)(52116002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlhtOEZ1R09pZitMUWNwUW9WczRkT2EwSDZ2NVhSSEZQLzV3MStMblJkY2Q5?=
 =?utf-8?B?aXphVDdtV2RRMmgrVjhWOXhYMDVTY0RSQ0lhVWRzdWJvN3BNNml0WjNQYXgr?=
 =?utf-8?B?RGVQeWN0cmxaclZNRWZpWjBqcndqWlFWcnJtejlhbGdFZGlVWm1rei91ejlB?=
 =?utf-8?B?OW1YSjRnYkp1dGY1VG5KOWNHSkE2ZXA2VlR1MnpOZHBwTitrYVZuQVBSQTFt?=
 =?utf-8?B?SHU1eWxJZUZNZ0dxVlhnd0NacGIxTnUyeU1oVVlEQWNPeXcxeGU0OFlXUy9r?=
 =?utf-8?B?ZVlCZmJKODh0ZUNnTmFmSUpNVGJOZXBhWllXZ1RiTHpCUzNRUTNsRkd0ZWQx?=
 =?utf-8?B?MXdYUjN6QTViRmgxbFV5VGdWYUxoLzlFeWdVcnhPL1B3dGdGT1VDZ3RvdTBM?=
 =?utf-8?B?bmpyVXgxQUVoVG5KTVhwdWRIaXVITndjYzdndW5yQ0lVYldONnBEaURXM2Vy?=
 =?utf-8?B?VGtJeXdjb1EwZnRJZVByR1FrdjJJNzZ2QWY3MERuMkFGVEJQa1hDMW5iQ04y?=
 =?utf-8?B?SlVtTVh4Vy9BYllldHZGV3VTbG1QQTJmeSttbGdmdWpCc0djcFpReTNBc2RJ?=
 =?utf-8?B?TUUrM3NjcWFENjJXeFAwYWtEUFdiMVR6bnBlMTgxRkNCUUNxb0czbllhRXJM?=
 =?utf-8?B?bnlIS1Y2VVUzN3NiSG10KzNNYnZtTFRKbHJDcXZIVWZHblFZSFNZL3ZzMDF6?=
 =?utf-8?B?a0RkVFhkVFRUaVc5RDNiVHV0Vk9mYnVxWFMrOVdPbmVSTWlkSFhVSGVHbGNw?=
 =?utf-8?B?WVBLdjFCVjkyanRtT2JQeHhxY1YxajU1YjBoSWRia0NETW9BdzNEak1XKzUz?=
 =?utf-8?B?bENITlRLZ0hkVFVGVDNZWWNOdnFJNzJLRi9WQ1k0dkxVTTJER2xsZ2J5YlZF?=
 =?utf-8?B?dzRqeUtKVjlMV250N0J5YUhzRXVPbXM2eGxwbUtwN1p5ckw3TWFJQk5SUnJy?=
 =?utf-8?B?NG1VNThmOWxqRFBVYUJ5bWFyM2g1WC83a2hrSWxCRVEyaklsM3RqR09hczlO?=
 =?utf-8?B?dEJBTWRKZktjamJSa0U1MjhDRTlPbEFvZmFua2orV25zekt2bEQ5Rlg1c1lm?=
 =?utf-8?B?OFpaQUZac2lTSHc0RzVCb2czZm1WVDhVa0FuYnc4N0JucmhDS2xudE5MYStD?=
 =?utf-8?B?bDhOTDBScjlYOUViQjVaOU45QzViTG9Pb1RDaGpscjg5OWxldWtUUkFnYlE1?=
 =?utf-8?B?V3lEaVJBWnh5U3lTQXNHS1JmaVNMU0RvcmNYWXI0aGFpRTFlbVFPR05vUld0?=
 =?utf-8?B?TW5RL3BXaEptbU44cE4vdlFzSHhla1RwbndxREpYUis4T3N6SGJFdFVEVzZo?=
 =?utf-8?B?U0pTZm8yTU5LeUNGTGZoVWwrTTBLSmRxakVNdTY4N0k0dUcxUTIrdGQydnBB?=
 =?utf-8?B?NHExSllycUthd1llelFpQmpDODg4d2FXcWxVOFRVTUI3YmlwVGdtUkQ5SC9Y?=
 =?utf-8?B?STRpYi95K3hoWHZ5ZWd4Rm1KbUZuUCtjazR4RHhLN0haOEZNNGlZalo5My83?=
 =?utf-8?B?ZlJMdWtlTWNSL3BYUVZLK1BOcXpUTXJ5VTlHcnRsTTRwdDdOejkyb2p4MmNu?=
 =?utf-8?B?eUdvRVV2NklYdGkrLzlBa3BUelJwbjNCTFBKV2dhYlJ3cCt1d1RIRVdGNERG?=
 =?utf-8?B?a0g0eW9tenppMUJHZG14VWRPdFpPVUJHa1NDclYweXZ5aWJjbGRoa3hkU1Rl?=
 =?utf-8?B?NVdJN2Z0MCs0TUtnZjdwQTR5aGtIZ1ZJdWM5TCsrblR5Y1ZPdVlramgvV2lY?=
 =?utf-8?B?bVZ0dkg3T3NWbjNHWDBDRDhoSjlHSGsvRzNIS3Jwa0JZNXJ4ZU5ZN2NIM0I3?=
 =?utf-8?B?ZEdYc2tPZ0dnVzY4WHVUdWJJL2lpa3VENlliczhybGgwcFZkNFhkNkgrOTFM?=
 =?utf-8?Q?tyv9Gp4wV6Z1A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62e3e9c-239e-4bec-10ec-08d8ff131c3b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 07:01:22.1696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnRpAfFCVbfG6H6AjKKyvZhSrymZSrNBx8BYC289OId1CIPh+Fwdc3w1ULDmHSWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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

QW0gMTMuMDQuMjEgdW0gMjA6MzAgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDQtMTMgMjoyNSBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pgo+Pgo+PiBBbSAx
My4wNC4yMSB1bSAyMDoxOCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4KPj4+IE9uIDIw
MjEtMDQtMTMgMjowMyBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDEzLjA0
LjIxIHVtIDE3OjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+Cj4+Pj4+IE9uIDIw
MjEtMDQtMTMgMzoxMCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4gQW0gMTIu
MDQuMjEgdW0gMjI6MDEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Pgo+Pj4+Pj4+
IE9uIDIwMjEtMDQtMTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4+
PiBBbSAxMi4wNC4yMSB1bSAyMToxMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4+
Pj4gW1NOSVBdCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IFNvIHdoYXQncyB0aGUgcmlnaHQgYXBw
cm9hY2ggPyBIb3cgd2UgZ3VhcmFudGVlIHRoYXQgd2hlbiAKPj4+Pj4+Pj4+Pj4gcnVubmluZyBh
bWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24gd2Ugd2lsbCBzaWduYWwgCj4+Pj4+
Pj4+Pj4+IGFsbCB0aGUgSFcgZmVuY2VzIGFuZCBub3QgcmFjaW5nIGFnYWluc3Qgc29tZSBtb3Jl
IGZlbmNlcyAKPj4+Pj4+Pj4+Pj4gaW5zZXJ0aW9uIGludG8gdGhhdCBhcnJheSA/Cj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBXZWxsIEkgd291bGQgc3RpbGwgc2F5IHRoZSBiZXN0
IGFwcHJvYWNoIHdvdWxkIGJlIHRvIGluc2VydCAKPj4+Pj4+Pj4+PiB0aGlzIGJldHdlZW4gdGhl
IGZyb250IGVuZCBhbmQgdGhlIGJhY2tlbmQgYW5kIG5vdCByZWx5IG9uIAo+Pj4+Pj4+Pj4+IHNp
Z25hbGluZyBmZW5jZXMgd2hpbGUgaG9sZGluZyB0aGUgZGV2aWNlIHNyY3UuCj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IE15IHF1ZXN0aW9uIGlzLCBldmVuIG5vdywgd2hlbiB3ZSBydW4g
Cj4+Pj4+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV93YWl0
X2VtcHR5IG9yIAo+Pj4+Pj4+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3LT5hbWRncHVf
ZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24sIAo+Pj4+Pj4+Pj4gd2hhdCB0aGVyZSBwcmV2
ZW50cyBhIHJhY2Ugd2l0aCBhbm90aGVyIGZlbmNlIGJlaW5nIGF0IHRoZSAKPj4+Pj4+Pj4+IHNh
bWUgdGltZSBlbWl0dGVkIGFuZCBpbnNlcnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJheSA/IExvb2tz
IAo+Pj4+Pj4+Pj4gbGlrZSBub3RoaW5nLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gRWFj
aCByaW5nIGNhbiBvbmx5IGJlIHVzZWQgYnkgb25lIHRocmVhZCBhdCB0aGUgc2FtZSB0aW1lLCB0
aGlzIAo+Pj4+Pj4+PiBpbmNsdWRlcyBlbWl0dGluZyBmZW5jZXMgYXMgd2VsbCBhcyBvdGhlciBz
dHVmZi4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gRHVyaW5nIEdQVSByZXNldCB3ZSBtYWtlIHN1cmUgbm9i
b2R5IHdyaXRlcyB0byB0aGUgcmluZ3MgYnkgCj4+Pj4+Pj4+IHN0b3BwaW5nIHRoZSBzY2hlZHVs
ZXIgYW5kIHRha2luZyB0aGUgR1BVIHJlc2V0IGxvY2sgKHNvIHRoYXQgCj4+Pj4+Pj4+IG5vYm9k
eSBlbHNlIGNhbiBzdGFydCB0aGUgc2NoZWR1bGVyIGFnYWluKS4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+
Pj4+Pj4gV2hhdCBhYm91dCBkaXJlY3Qgc3VibWlzc2lvbnMgbm90IHRocm91Z2ggc2NoZWR1bGVy
IC0gCj4+Pj4+Pj4gYW1kZ3B1X2pvYl9zdWJtaXRfZGlyZWN0LCBJIGRvbid0IHNlZSBob3cgdGhp
cyBpcyBwcm90ZWN0ZWQuCj4+Pj4+Pgo+Pj4+Pj4gVGhvc2Ugb25seSBoYXBwZW4gZHVyaW5nIHN0
YXJ0dXAgYW5kIEdQVSByZXNldC4KPj4+Pj4KPj4+Pj4KPj4+Pj4gT2ssIGJ1dCB0aGVuIGxvb2tz
IGxpa2UgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgc2VlIHRoZSBmb2xsb3dpbmcgCj4+Pj4+IHN0
ZXBzIGluIGFtZGdwdV9wY2lfcmVtb3ZlIC0KPj4+Pj4KPj4+Pj4gMSkgVXNlIGRpc2FibGVfaXJx
IEFQSSBmdW5jdGlvbiB0byBzdG9wIGFuZCBmbHVzaCBhbGwgaW4gZmxpZ2h0IEhXIAo+Pj4+PiBp
bnRlcnJ1cHRzIGhhbmRsZXJzCj4+Pj4+Cj4+Pj4+IDIpIEdyYWIgdGhlIHJlc2V0IGxvY2sgYW5k
IHN0b3AgYWxsIHRoZSBzY2hlZHVsZXJzCj4+Pj4+Cj4+Pj4+IEFmdGVyIGFib3ZlIDIgc3RlcHMg
dGhlIEhXIGZlbmNlcyBhcnJheSBpcyBpZGxlLCBubyBtb3JlIAo+Pj4+PiBpbnNlcnRpb25zIGFu
ZCBubyBtb3JlIGV4dHJhY3Rpb25zIGZyb20gdGhlIGFycmF5Cj4+Pj4+Cj4+Pj4+IDMpIFJ1biBv
bmUgdGltZSBhbWRncHVfZmVuY2VfcHJvY2VzcyB0byBzaWduYWwgYWxsIGN1cnJlbnQgSFcgZmVu
Y2VzCj4+Pj4+Cj4+Pj4+IDQpIFNldCBkcm1fZGV2X3VucGx1ZyAod2lsbCAnZmx1c2gnIGFsbCBp
biBmbGlnaHQgSU9DVExzKSwgcmVsZWFzZSAKPj4+Pj4gdGhlIEdQVSByZXNldCBsb2NrIGFuZCBn
byBvbiB3aXRoIHRoZSByZXN0IG9mIHRoZSBzZXF1ZW5jZSAoY2FuY2VsIAo+Pj4+PiB0aW1lcnMs
IHdvcmsgaXRlbXMgZS50LmMpCj4+Pj4+Cj4+Pj4+IFdoYXQncyBwcm9ibGVtYXRpYyBpbiB0aGlz
IHNlcXVlbmNlID8KPj4+Pgo+Pj4+IGRybV9kZXZfdW5wbHVnKCkgd2lsbCB3YWl0IGZvciB0aGUg
SU9DVExzIHRvIGZpbmlzaC4KPj4+Pgo+Pj4+IFRoZSBJT0NUTHMgaW4gdHVybiBjYW4gd2FpdCBm
b3IgZmVuY2VzLiBUaGF0IGNhbiBiZSBib3RoIGhhcmR3YXJlIAo+Pj4+IGZlbmNlcywgc2NoZWR1
bGVyIGZlbmNlcywgYXMgd2VsbCBhcyBmZW5jZXMgZnJvbSBvdGhlciBkZXZpY2VzIChhbmQgCj4+
Pj4gS0lRIGZlbmNlcyBmb3IgcmVnaXN0ZXIgd3JpdGVzIHVuZGVyIFNSSU9WLCBidXQgd2UgY2Fu
IGhvcGVmdWxseSAKPj4+PiBpZ25vcmUgdGhlbSBmb3Igbm93KS4KPj4+Pgo+Pj4+IFdlIGhhdmUg
aGFuZGxlZCB0aGUgaGFyZHdhcmUgZmVuY2VzLCBidXQgd2UgaGF2ZSBubyBpZGVhIHdoZW4gdGhl
IAo+Pj4+IHNjaGVkdWxlciBmZW5jZXMgb3IgdGhlIGZlbmNlcyBmcm9tIG90aGVyIGRldmljZXMg
d2lsbCBzaWduYWwuCj4+Pj4KPj4+PiBTY2hlZHVsZXIgZmVuY2VzIHdvbid0IHNpZ25hbCB1bnRp
bCB0aGUgc2NoZWR1bGVyIHRocmVhZHMgYXJlIAo+Pj4+IHJlc3RhcnRlZCBvciB3ZSBzb21laG93
IGNhbmNlbCB0aGUgc3VibWlzc2lvbnMuIERvYWJsZSwgYnV0IHRyaWNreSAKPj4+PiBhcyB3ZWxs
Lgo+Pj4KPj4+Cj4+PiBGb3Igc2NoZWR1bGVyIGZlbmNlcyBJIGFtIG5vdCB3b3JyaWVkLCBmb3Ig
dGhlIHNjaGVkX2ZlbmNlLT5maW5pc2hlZCAKPj4+IGZlbmNlIHRoZXkgYXJlIGJ5IGRlZmluaXRp
b24gYXR0YWNoZWQgdG8gSFcgZmVuY2VzIHdoaWNoIGFscmVhZHkgCj4+PiBzaWduYWxlZGZvciBz
Y2hlZF9mZW5jZS0+c2NoZWR1bGVkIHdlIHNob3VsZCBydW4gCj4+PiBkcm1fc2NoZWRfZW50aXR5
X2tpbGxfam9icyBmb3IgZWFjaCBlbnRpdHkgYWZ0ZXIgc3RvcHBpbmcgdGhlIAo+Pj4gc2NoZWR1
bGVyIHRocmVhZHMgYW5kIGJlZm9yZSBzZXR0aW5nIGRybV9kZXZfdW5wbHVnLgo+Pgo+PiBXZWxs
IGV4YWN0bHkgdGhhdCBpcyB3aGF0IGlzIHRyaWNreSBoZXJlLiAKPj4gZHJtX3NjaGVkX2VudGl0
eV9raWxsX2pvYnMoKSBhc3N1bWVzIHRoYXQgdGhlcmUgYXJlIG5vIG1vcmUgam9icyAKPj4gcHVz
aGVkIGludG8gdGhlIGVudGl0eS4KPj4KPj4gV2UgYXJlIHJhY2luZyBoZXJlIG9uY2UgbW9yZSBh
bmQgbmVlZCB0byBoYW5kbGUgdGhhdC4KPgo+Cj4gQnV0IHdoeSwgSSB3cm90ZSBhYm92ZSB0aGF0
IHdlIGZpcnN0IHN0b3AgdGhlIGFsbCBzY2hlZHVsZXJzLCB0aGVuIAo+IG9ubHkgY2FsbCBkcm1f
c2NoZWRfZW50aXR5X2tpbGxfam9icy4KClRoZSBzY2hlZHVsZXJzIGNvbnN1bWluZyBqb2JzIGlz
IG5vdCB0aGUgcHJvYmxlbSwgd2UgYWxyZWFkeSBoYW5kbGUgdGhhdCAKY29ycmVjdC4KClRoZSBw
cm9ibGVtIGlzIHRoYXQgdGhlIGVudGl0aWVzIG1pZ2h0IGNvbnRpbnVlIGZlZWRpbmcgc3R1ZmYg
aW50byB0aGUgCnNjaGVkdWxlci4KCj4+Cj4+Pj4KPj4+PiBGb3Igd2FpdGluZyBmb3Igb3RoZXIg
ZGV2aWNlIEkgaGF2ZSBubyBpZGVhIGlmIHRoYXQgY291bGRuJ3QgCj4+Pj4gZGVhZGxvY2sgc29t
ZWhvdy4KPj4+Cj4+Pgo+Pj4gWWVhLCBub3Qgc3VyZSBmb3IgaW1wb3J0ZWQgZmVuY2VzIGFuZCBk
bWFfYnVmcywgSSB3b3VsZCBhc3N1bWUgdGhlIAo+Pj4gb3RoZXIgZGV2aWNlcyBzaG91bGQgbm90
IGJlIGltcGFjdGVkIGJ5IG91ciBkZXZpY2UgcmVtb3ZhbCBidXQsIHdobyAKPj4+IGtub3dzLi4u
Cj4+Pgo+Pj4gU28gSSBndWVzcyB3ZSBhcmUgTk9UIGdvaW5nIHdpdGggZmluYWxpemluZyBIVyBm
ZW5jZXMgYmVmb3JlIAo+Pj4gZHJtX2Rldl91bnBsdWcgYW5kIGluc3RlYWQgd2lsbCBqdXN0IGNh
bGwgZHJtX2Rldl9lbnRlci9leGl0IGF0IHRoZSAKPj4+IGJhY2stZW5kcyBhbGwgb3ZlciB0aGUg
cGxhY2Ugd2hlcmUgdGhlcmUgYXJlIE1NSU8gYWNjZXNzZXMgPwo+Pgo+PiBHb29kIHF1ZXN0aW9u
LiBBcyB5b3Ugc2FpZCB0aGF0IGlzIHJlYWxseSB0aGUgaGFyZCBwYXRoLgo+Pgo+PiBIYW5kbGlu
ZyBpdCBhbGwgYXQgb25jZSBhdCBJT0NUTCBsZXZlbCBjZXJ0YWlubHkgaGFzIHNvbWUgYXBwZWFs
IGFzIAo+PiB3ZWxsLCBidXQgSSBoYXZlIG5vIGlkZWEgaWYgd2UgY2FuIGd1YXJhbnRlZSB0aGF0
IHRoaXMgaXMgbG9jayBmcmVlLgo+Cj4KPiBNYXliZSBqdXN0IGVtcGlyaWNhbGx5IC0gbGV0J3Mg
dHJ5IGl0IGFuZCBzZWUgdW5kZXIgZGlmZmVyZW50IHRlc3QgCj4gc2NlbmFyaW9zIHdoYXQgYWN0
dWFsbHkgaGFwcGVuc8KgID8KCk5vdCBhIGdvb2QgaWRlYSBpbiBnZW5lcmFsLCB3ZSBoYXZlIHRo
YXQgYXBwcm9hY2ggd2F5IHRvIG9mdGVuIGF0IEFNRCAKYW5kIGFyZSB0aGVuIHN1cnByaXNlZCB0
aGF0IGV2ZXJ5dGhpbmcgd29ya3MgaW4gUUEgYnV0IGZhaWxzIGluIHByb2R1Y3Rpb24uCgpCdXQg
RGFuaWVsIGFscmVhZHkgbm90ZWQgaW4gaGlzIHJlcGx5IHRoYXQgd2FpdGluZyBmb3IgYSBmZW5j
ZSB3aGlsZSAKaG9sZGluZyB0aGUgU1JDVSBpcyBleHBlY3RlZCB0byB3b3JrLgoKU28gbGV0J3Mg
c3RpY2sgd2l0aCB0aGUgYXBwcm9hY2ggb2YgaGlnaCBsZXZlbCBsb2NraW5nIGZvciBob3RwbHVn
LgoKQ2hyaXN0aWFuLgoKPgo+IEFuZHJleQo+Cj4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4KPj4+
IEFuZHJleQo+Pj4KPj4+Pgo+Pj4+IFJlZ2FyZHMsCj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+
Cj4+Pj4+IEFuZHJleQo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+PiBCVFc6IENvdWxkIGl0IGJlIHRoYXQgdGhlIGRldmljZSBTUkNVIHByb3Rl
Y3RzIG1vcmUgdGhhbiBvbmUgCj4+Pj4+Pj4+Pj4gZGV2aWNlIGFuZCB3ZSBkZWFkbG9jayBiZWNh
dXNlIG9mIHRoaXM/Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEkgaGF2ZW4ndCBhY3R1
YWxseSBleHBlcmllbmNlZCBhbnkgZGVhZGxvY2sgdW50aWwgbm93IGJ1dCwgCj4+Pj4+Pj4+PiB5
ZXMsIGRybV91bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2LmMgYW5k
IHNvIAo+Pj4+Pj4+Pj4gaW4gdGhlIHByZXNlbmNlwqAgb2YgbXVsdGlwbGUgZGV2aWNlcyBmcm9t
IHNhbWUgb3IgZGlmZmVyZW50IAo+Pj4+Pj4+Pj4gZHJpdmVycyB3ZSBpbiBmYWN0IGFyZSBkZXBl
bmRlbnQgb24gYWxsIHRoZWlyIGNyaXRpY2FsIAo+Pj4+Pj4+Pj4gc2VjdGlvbnMgaSBndWVzcy4K
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFNoaXQsIHllYWggdGhlIGRldmlsIGlzIGEgc3F1
aXJyZWwuIFNvIGZvciBBK0kgbGFwdG9wcyB3ZSAKPj4+Pj4+Pj4gYWN0dWFsbHkgbmVlZCB0byBz
eW5jIHRoYXQgdXAgd2l0aCBEYW5pZWwgYW5kIHRoZSByZXN0IG9mIHRoZSAKPj4+Pj4+Pj4gaTkx
NSBndXlzLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJSVJDIHdlIGNvdWxkIGFjdHVhbGx5IGhhdmUgYW4g
YW1kZ3B1IGRldmljZSBpbiBhIGRvY2tpbmcgCj4+Pj4+Pj4+IHN0YXRpb24gd2hpY2ggbmVlZHMg
aG90cGx1ZyBhbmQgdGhlIGRyaXZlciBtaWdodCBkZXBlbmQgb24gCj4+Pj4+Pj4+IHdhaXRpbmcg
Zm9yIHRoZSBpOTE1IGRyaXZlciBhcyB3ZWxsLgo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBDYW4n
dCB3ZSBwcm9wb3NlIGEgcGF0Y2ggdG8gbWFrZSBkcm1fdW5wbHVnX3NyY3UgcGVyIGRybV9kZXZp
Y2UgCj4+Pj4+Pj4gPyBJIGRvbid0IHNlZSB3aHkgaXQgaGFzIHRvIGJlIGdsb2JhbCBhbmQgbm90
IHBlciBkZXZpY2UgdGhpbmcuCj4+Pj4+Pgo+Pj4+Pj4gSSdtIHJlYWxseSB3b25kZXJpbmcgdGhl
IHNhbWUgdGhpbmcgZm9yIHF1aXRlIGEgd2hpbGUgbm93Lgo+Pj4+Pj4KPj4+Pj4+IEFkZGluZyBE
YW5pZWwgYXMgd2VsbCwgbWF5YmUgaGUga25vd3Mgd2h5IHRoZSBkcm1fdW5wbHVnX3NyY3UgaXMg
Cj4+Pj4+PiBnbG9iYWwuCj4+Pj4+Pgo+Pj4+Pj4gUmVnYXJkcywKPj4+Pj4+IENocmlzdGlhbi4K
Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4KPj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4g
wqDCoMKgIC8qIFBhc3QgdGhpcyBwb2ludCBubyBtb3JlIGZlbmNlIGFyZSBzdWJtaXR0ZWQgdG8g
SFcgCj4+Pj4+Pj4+Pj4+Pj4+PiByaW5nIGFuZCBoZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9y
Y2Ugc2lnbmFsIG9uIGFsbCAKPj4+Pj4+Pj4+Pj4+Pj4+IHRoYXQgYXJlIGN1cnJlbnRseSB0aGVy
ZS4KPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgICogQW55IHN1YnNlcXVlbnRseSBjcmVhdGVkwqAg
SFcgZmVuY2VzIHdpbGwgYmUgCj4+Pj4+Pj4+Pj4+Pj4+PiByZXR1cm5lZCBzaWduYWxlZCB3aXRo
IGFuIGVycm9yIGNvZGUgcmlnaHQgYXdheQo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgKi8KPj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgZm9yX2VhY2hfcmluZyhhZGV2KQo+
Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIMKgwqDCoCBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBkcm1fZGV2X3VucGx1ZyhkZXYp
Owo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIFN0b3Agc2NoZWR1bGVycwo+Pj4+Pj4+Pj4+Pj4+Pj4g
wqDCoMKgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1ZXVlZCB3b3Jrcyk7Cj4+Pj4+Pj4+
Pj4+Pj4+PiDCoMKgwqAgaHdfZmluaQo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIHVubWFwX21taW8K
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2ZWx5
IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
c3RvcHBpbmcgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgc2NoZWR1bGVyIGNvdWxkIAo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiB3b3JrIGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBhYm92ZSBhbmQgSSBk
b24ndCBzZWUgd2h5IEkgbmVlZCB0byAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiByZXVzZSB0aGUgR1BV
IHJlc2V0IHJ3X2xvY2suIEkgcmVseSBvbiB0aGUgU1JDVSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB1
bnBsdWcgZmxhZyBmb3IgdW5wbHVnLiBBbHNvLCBub3QgY2xlYXIgdG8gbWUgd2h5IAo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUgc2NoZWR1bGVyIHRocmVhZHMsIGFu
eSBjb2RlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHBhdGNoIHRvIGdlbmVyYXRlIEhXIGZlbmNlcyBz
aG91bGQgYmUgY292ZXJlZCwgc28gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYW55IGNvZGUgbGVhZGlu
ZyB0byBhbWRncHVfZmVuY2VfZW1pdCBuZWVkcyB0byBiZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0
YWtlbiBpbnRvIGFjY291bnQgc3VjaCBhcywgZGlyZWN0IElCIHN1Ym1pc3Npb25zLCAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBWTSBmbHVzaGVzIGUudC5jCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gWW91IG5lZWQgdG8gd29yayB0b2dldGhlciB3aXRoIHRoZSByZXNldCBsb2Nr
IGFueXdheSwgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBjYXVzZSBhIGhvdHBsdWcgY291bGQgcnVuIGF0
IHRoZSBzYW1lIHRpbWUgYXMgYSByZXNldC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gRm9yIGdvaW5nIG15IHdheSBpbmRlZWQgbm93IEkgc2Vl
IG5vdyB0aGF0IEkgaGF2ZSB0byAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gdGFrZSByZXNldCB3cml0ZSBz
aWRlIGxvY2sgZHVyaW5nIEhXIGZlbmNlcyBzaWduYWxsaW5nIAo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBp
biBvcmRlciB0byBwcm90ZWN0IGFnYWluc3Qgc2NoZWR1bGVyL0hXIGZlbmNlcyAKPj4+Pj4+Pj4+
Pj4+Pj4+Pj4gZGV0YWNobWVudCBhbmQgcmVhdHRhY2htZW50IGR1cmluZyBzY2hlZHVsZXJzIAo+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBzdG9wL3Jlc3RhcnQuIEJ1dCBpZiB3ZSBnbyB3aXRoIHlvdXIgYXBw
cm9hY2jCoCB0aGVuIAo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFu
ZCBzY29waW5nIGFtZGdwdV9qb2JfdGltZW91dCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gd2l0aCBkcm1f
ZGV2X2VudGVyL2V4aXQgc2hvdWxkIGJlIGVub3VnaCB0byBwcmV2ZW50IAo+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBhbnkgY29uY3VycmVudCBHUFUgcmVzZXRzIGR1cmluZyB1bnBsdWcuIEluIGZhY3QgSSAK
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYWxyZWFkeSBkbyBpdCBhbnl3YXkgLSAKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzOiUyRiUyRmNnaXQuZnJlZWRlc2t0b3Aub3JnJTJGfmFncm9kem92JTJGbGludXglMkZjb21t
aXQlMkYlM0ZoJTNEZHJtLW1pc2MtbmV4dCUyNmlkJTNEZWYwZWE0ZGQyOWVmNDRkMjY0OWM1ZWRh
MTZjOGY0ODY5YWNjMzZiMSZhbXA7ZGF0YT0wNCU3QzAxJTdDYW5kcmV5Lmdyb2R6b3Zza3klNDBh
bWQuY29tJTdDYzdmYzZjYjUwNWMzNGFlZGZlNmQwOGQ4ZmU0YjM5NDclN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTM4OTQ2MzI0ODU3MzY5JTdDVW5rbm93
biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJU
aUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPTY0MzYyUFJDOHhUZ1Iy
VWoyUjI1NmJNZWdWbThZV3ExS0klMkJBanplWVh2NCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IFllcywgZ29vZCBw
b2ludCBhcyB3ZWxsLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFu
Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFu
ZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5k
cmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlz
dGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4KPj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
