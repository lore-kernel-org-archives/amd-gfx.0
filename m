Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB296C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BBF6135C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BBF6135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE186F878;
	Fri, 21 May 2021 13:54:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5DD6F878
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 13:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1g9Cj39sB6O53WgfD/qvz3uFAcci6PBCiDZiXdMcFVRw1iJ4gVts+Tx7DigeQeGdPlKIUV7lF3wkhYUVhOXRML0DqB5ESJsjC7Ly2gu491Jzgjdvby1lwu0KbCASrLLuVwSjijJcR5DPvYVqabttmsoY53mzZK7GN/FeypEGc++hCK1CrloEMR7onr/nyyq85VUbOsWq0HnqsYKhiHx12S301Za9mnb0SMV069ZyP44BfDdA8Mu610vNTqRterbABSZAbcind9F24tw+s2RMlaaGTPRVw/BI9yTyBVsjO66h4BU8EeMCRo+LRU9oe945NMuGdhlO0B+tzgLZruEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWmP5xQDbMu7bkVtsHu1UiGma07q0CGRV1z0DpLohsU=;
 b=fsHceJOCN4K2oTKsYnsntR4Q+v8Cu9HOlXYZFkJS+k4MeUg4KimCINip+K+8O8i6oEhZ7mWIQDtNZBbc3srGFVpanEnT7qW6OeoLDK9RuS+cCT3cJkvFHlBMuj2M6WHwBoKVnz16kaOs+c9TbusAUvP15UuO3JeoljG+epLuFgEXtA9yZCj8TWfLMqq5jfALp7jZrfQ1mJzZep/9YpYSdiMjeZmJ3kQ56hbO+eEiQ+kHR4ntcr7Xw1c4Cp9LNhA+20Aci34LANzhUwHgSZP3pWTt72e/HmxW0WpMe0EY/jOrBmlitUmV6fpzQEeXZ9KdXxveQvgsXDtxSRkksoHVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWmP5xQDbMu7bkVtsHu1UiGma07q0CGRV1z0DpLohsU=;
 b=px+I0+ZWGOG4vnzL3A3fvfcw+ZD97ItHWAzdqgI3DVMIZl8iLPdazD5CMsaShHmos84eOktfWfNCtFC/Nyn8ajJneKEC6EKhEo2gR2tBJjTYh1Gxp2sRuq5NcVDPwMDbX6XTYzmI5Ik+QCE6zrm9k7hrD0UV8rzDmgxlxIRqjUw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 13:54:39 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 13:54:39 +0000
From: Nirmoy <nirmodas@amd.com>
Subject: Re: [PATCH 2/7] drm/amdgpu: add a new identifier for amdgpu_bo
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521124533.4380-1-nirmoy.das@amd.com>
 <20210521124533.4380-2-nirmoy.das@amd.com>
 <38fd15b4-aacc-9be6-deaf-9fcd61d59477@amd.com>
Message-ID: <a1a0b4ae-98dd-b434-7a07-d46c84d2a1b0@amd.com>
Date: Fri, 21 May 2021 15:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <38fd15b4-aacc-9be6-deaf-9fcd61d59477@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR1P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.105.51) by
 PR1P264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 13:54:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f833ed5f-385e-42a0-244f-08d91c5ffa56
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5055028B540CE0987AD9F3CD8B299@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noYE3M0DRWZrUTXaTOdjKPSpiECNKde60wU1fmCf8rdgiNga7tNrskF9Fa68+gdkxzDt+qds9/1BML84d1g9/A1g7RAFoY5FoPylh3h+eTwhehlFNoeHzfiuUpO+moXKMDwVLPhOfxgN+Izzxs9XSF/2h6wheYXFqY5OyB2dTgzItBLLduwS3RWW1eCkQTt4c4CnwwYJMNnwEEQOcXKWRTEjeljyl0OtNy8sseisgKFQPNXkGcd8mWjFyLX1VCi8jjkfPz1QOhsiHC5tXRjU/dkgCbWeBNEpOYY53vXXKuCtvmFRo3MS87GFwVIel68Gr4Wp+XA9/JiS2eDWu6hg+Vh+ED8CybQ+47k/AnGkHOI0ydOHwIPknKsM0Dm+kdO3UWiPe5MUJiZvt9TRYqhFQy3qTrAS2VrITGbBqzAWpD3GsUSzzMZhWkxhgVlCklzWAXzsclqiNz5yyS5Yh7MYdFd+zJViDC892bm3wVg+cXjbPYYMjfaNH9tIMSehFE4R5CBWuuNJUucwHPmBO7XC+DhP7bTpQv62B4DVIt+P5Jb3z8R0x2LgJzXxnd6PjV6pOUgQ5X98pXQHIDLbWkyOgT6FFxiKKuPrpdk0Zs1c6FZyes/dRTGb9rbWGpWMfvEyrza+Fzou0zA5/6eh4eyctXElO5vhqntrIUCXJzC9eoRbL2EMu/17RptbTsD5cRkF/vs6eLdIs61dDcnSA69SqNJnPvRnTg8wtuPKdxwcXyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(31696002)(38100700002)(38350700002)(316002)(6666004)(110136005)(52116002)(31686004)(478600001)(16576012)(36756003)(2616005)(956004)(4326008)(8676002)(53546011)(5660300002)(26005)(83380400001)(8936002)(66476007)(186003)(66556008)(66946007)(16526019)(66574015)(2906002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TGEvV3dLZUFhNjlKVlZNU3YzZEZtTWFOa0kxTFJMaXFGL3NpdDdyOEFJbzNn?=
 =?utf-8?B?MUxuQlpIYUlMUDRvcU1XSVVxVU1QdFJLRE1LeDRXRzFGQnNsL0JST0EyLy8y?=
 =?utf-8?B?SEdKZ3pRNnh3SWZsTHNTcUhOeUQwWWRJWTFGYnNpZmY2YXRrR2l6dWwvQWtz?=
 =?utf-8?B?bFFNdWY2ZUI3SzVFRDRNV0RSR2FpaVJaVDRKcUlabERPck1XcUdPY1pqU2pU?=
 =?utf-8?B?Tm9aQXd0Q1pSZDdmTFd3WlcxWHRaMmRRYlRoTW5yQ3JibWJNWG03dGJrVnNz?=
 =?utf-8?B?dzlIQ0EvZXAxYmFCZ3EzSnRuQU1mUHQrZkVoU2ltLy96cXZMbUZ6eldPTGJ4?=
 =?utf-8?B?UCtoTk9YV2J0K0xwV1ZqUkZVNXl0T3R3QmVZVkhzNUoxaFVpYkV6RmtnWWpD?=
 =?utf-8?B?ZkRqdlVld3JLYmJ2d1k4QVVQcnRrTWtsZHVIMEdLOWVjNUhNM3BWQmh0d3RS?=
 =?utf-8?B?Ni9aVmQ5bFdYYzkzREk2blF2VmxwVUlkbGsrQ2hmd1ZFTmFWQkJOdy9aaHNv?=
 =?utf-8?B?MTBtUHV3UHFPbGFvNXhGL1UxQ0g2TmpobnVUMmZLdmtXaDBlQnR5UWYxcXBW?=
 =?utf-8?B?UFRzcVhtM0hYRW1hQTVqdEw1WVp6N1YyNEVyamttTUJsby9YNjZUWTIyYWhW?=
 =?utf-8?B?dHVGVUN6UDQxVnROZGdrSjMzcTRpcWRRU2JJaHI4cTArbnhyKzc3VmFDT1hI?=
 =?utf-8?B?MG5RbTA0bkZQL1BIVU5idGFBbzhsS0dDWkJEMFVxb0ZDQlAyU1RtejZ3VFNj?=
 =?utf-8?B?bTIyUlZpZld0VG51UVltRlU3TDltMEIrenJQWEV4Ry9BZDM0eUxaUGJjb3Nt?=
 =?utf-8?B?dVQ1RWJTNlE0WkN4bklaZlVoeDJOeEkybXRseFdBSVpQMmpUOG81WWp5RUNz?=
 =?utf-8?B?SDNkYWhiU2dPRTcwQmdIbGdnU1hMWHZTU3JMbVIvL1ZKRHpQeVI1UENBRjFX?=
 =?utf-8?B?cU1pOWNCRmFxMHBHVmI0WU1oN012aWJEUmhsMC9wREpFbW9VeEhKT3FmbW8w?=
 =?utf-8?B?SnFYdCtiTkhqQzNBNTVTSHJNVkJDbWJtM1I0NXA0Y1lVSFZHYkNoUlRQQ2h6?=
 =?utf-8?B?Um9sNXBnbXByNXVQY1lrRlFlQWJ1Mm9kWWc1WG1aMnhHOUJwSm85UmJXN2pK?=
 =?utf-8?B?OFNVb1VTR2hBSUNENTFiL1JabGZlN2hKMjd4WTNlS0VnMjRud05XOXoxVERJ?=
 =?utf-8?B?T1MzRXRTenlRcFRSSWdFOFJYbzR5QmtHMkZyRjhqRnRxeDN0bUVnQkN6ek1t?=
 =?utf-8?B?S01LdTVXTjFkVDNRQnVRbk5hVGVyNUJYYkhGVktkMzFoT2NTUVlyRGQxem5n?=
 =?utf-8?B?VVNQMXJnSkZ6a3NyZnExdm9meEJLRk9jcEhLZmhmWnlwWVFvczBEcjhzQXZo?=
 =?utf-8?B?elFWb2x2ckgvbXhJLzRxdFRSdkU0UlpjTktjZ3FkbkRnTEtpWE9TZHUzenVU?=
 =?utf-8?B?dG9RSW91Z1VmbHNtRFRqdmxoQzFZVTJQMHo0WElRNlNBU21obVB4VEoxb2U2?=
 =?utf-8?B?cnJHMUNFKzFIOWNhT1Bvd2lVcTJiSGJpNVptZy90aWFyYUtrSTB2Y1lEcVBZ?=
 =?utf-8?B?SXFuNnUrck1qZ3RlaEJDMERIUGhzZlBCVjdsemQ5NkhVSDhmZkdMdDVkVFFq?=
 =?utf-8?B?Vjc2cmcyakNvMi83ZUxoL1ZZYUV6TmRLZG16bnY0OXlFT2IvS1ZtMTJieHpW?=
 =?utf-8?B?Q2FHaDlCZ2FudklRUWJIUGF4ZDJXQkg1b2FKOEJNWmVWRGRvdVVzWFd0OUZN?=
 =?utf-8?Q?47ZBtzWWAK8DNzfrA9Nb8efbb3HkfOMz9M+/+C+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f833ed5f-385e-42a0-244f-08d91c5ffa56
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 13:54:39.8688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtK6Ydexb+1ZKTEMqnw+aRIv3ksDrdBpecgPRc0Ktrwa/jVQV7ya6zuOne0qohoHWxpM27AqiZIBsfGOzH2JxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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

Ck9uIDUvMjEvMjEgMjo1OCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMS4wNS4y
MSB1bSAxNDo0NSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEFkZCBoYXNfc2hhZG93IHRvIGlkZW50
aWZ5IGlmIGEgQk8gaXMgc2hhZG93ZWQuCj4KPiBPayB0aGF0IGlzIG5vdCBnb2luZyBpbnRvIHRo
ZSByaWdodCBkaXJlY3Rpb24uCgoKSSB3YXMgZXhwZWN0aW5nIHRoaXMgOikgYnV0IHdhc24ndCBz
dXJlIGhvdyB0byBoYW5kbGUgaXQuCgo+Cj4KPiBJbnN0ZWFkIG9mIGlkZW50aWZ5aW5nIHdoaWNo
IEJPcyBoYXZlIGEgc2hhZG93IHdlIG5lZWQgdG8gaWRlbnRpZnkgaWYgCj4gdGhpcyBpcyBhIFZN
IEJPIG9yIG5vdC4KPgo+IEkgdGhpbmsgdGhlIGZpcnN0IHRoaW5rIHlvdSBuZWVkIHRvIGRvIGlz
IHRvIG1vdmUgdGhlIHNoYWRvdyBoYW5kbGluZyAKPiBmcm9tIGFtZGdwdV9jc192YWxpZGF0ZSgp
IGludG8gYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcygpLgo+Cj4gQW5kIHRoZW4gZG8gaXQgb25s
eSBmb3IgdHRtX2JvX3R5cGVfa2VybmVsIEJPcywgY2F1c2UgdGhvc2UgYXJlIHRoZSAKPiBQRC9Q
VCBCT3MuCgoKVGhhbmtzLCB0aGlzIHNvdW5kcyBnb29kLgoKCk5pcm1veQoKPgo+IFJlZ2FyZHMs
Cj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5k
YXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyB8IDIgKysKPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5oIHwgNSArKy0tLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmMKPj4gaW5kZXggNjFiMWVkY2I0OTBhLi5lYjNjZTMzY2JmZmYgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gQEAgLTYx
OSw2ICs2MTksNyBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgaWYgKCFicC0+cmVzdikKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlc2VydmUoYm8pOwo+PiArwqDCoMKgIGJvLT5o
YXNfc2hhZG93ID0gZmFsc2U7Cj4+IMKgwqDCoMKgwqAgKmJvX3B0ciA9IGJvOwo+PiDCoCDCoMKg
wqDCoMKgIHRyYWNlX2FtZGdwdV9ib19jcmVhdGUoYm8pOwo+PiBAQCAtNjU3LDYgKzY1OCw3IEBA
IGludCBhbWRncHVfYm9fY3JlYXRlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFk
ZXYsCj4+IMKgwqDCoMKgwqAgciA9IGFtZGdwdV9ib19jcmVhdGUoYWRldiwgJmJwLCAmYm8tPnNo
YWRvdyk7Cj4+IMKgwqDCoMKgwqAgaWYgKCFyKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBiby0+
c2hhZG93LT5wYXJlbnQgPSBhbWRncHVfYm9fcmVmKGJvKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGJv
LT5oYXNfc2hhZG93ID0gdHJ1ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmFk
ZXYtPnNoYWRvd19saXN0X2xvY2spOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9hZGRfdGFp
bCgmYm8tPnNoYWRvdy0+c2hhZG93X2xpc3QsICZhZGV2LT5zaGFkb3dfbGlzdCk7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2spOwo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIAo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+PiBpbmRleCBh
N2ZiZjVmNzA1MWUuLjNhMGU2Y2E4ODU2MyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+PiBAQCAtMTA0LDkgKzEwNCw4IEBAIHN0cnVjdCBhbWRn
cHVfYm8gewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZcKgwqDCoCAqdm1f
Ym87Cj4+IMKgwqDCoMKgwqAgLyogQ29uc3RhbnQgYWZ0ZXIgaW5pdGlhbGl6YXRpb24gKi8KPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvwqDCoMKgwqDCoMKgwqAgKnBhcmVudDsKPj4gLcKg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvwqDCoMKgwqDCoMKgwqAgKnNoYWRvdzsKPj4gLQo+PiAtCj4+
ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9ib8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
c2hhZG93Owo+PiArwqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFz
X3NoYWRvdzsKPj4gwqAgwqAgI2lmZGVmIENPTkZJR19NTVVfTk9USUZJRVIKPj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgbW11X2ludGVydmFsX25vdGlmaWVywqDCoMKgIG5vdGlmaWVyOwo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
