Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8CFC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70D264FEF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70D264FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C1D6E214;
	Fri,  5 Mar 2021 14:48:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22A56E214
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKuM0jYu74b/MCKMVOECrjtTyfiflRTDeF5xpMnE87b+00A2ikGgrgFTcLAzF0dZ4n4o6gTPmd6bP0Nym771rItkK7JOV7KwwNSk+qU9n3u35E1xYXL9Au6i6qTNWP/Ggexs6/iQC9fANiVw8B/Ip1JOhQKy1uprDkJFhH0L5u7H4ji4xAfB2pwqxmzPJ8pimRhBeyxU6owHitzaT3Ngb1nq/9XWoxWDHiKzBy0234RVhnx7/mMwVzqf706VzXCvAXfsXZurODN2KTqs5CI6rxUfJitG5ohHx3F8BIB7DjAgf9s88QZwegRkhS1gfyw9AlVVEzZmpEXqbrm6lpMQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkurWzmBgUESnpGL21HLaNI5u+WsY8PPPWN09LZm8LI=;
 b=AIdoe/ol2l+X/xRnHYEP55Q9zAiJNIfUoDUIyJr4Z1inUjRuZd2CjRJf8NUWRBjhpf36nDH9rvYyZkOPmia7cvXjLbUGYnKkIycxS5wenxrRc0L15gdmi7kfj+b/vXBHMyJYKgwXovYueABkSW344N5rEUlESR4AaCzmCPs3Nc6SdPcg79NoqTxnH4ih8UplKxwfXn6UVW2yCkqRf4elyiGZQiXMGPpRXl5BlgoSfNQD0o4zZ0CCE9nIQQwB818PLluxdO4Ug11pKT5B7BxME6NFIS+K/6QIokKR49E8UKL4A5SxGypR3dfpxOvd28QucEBPR/A+ZYYQH7durAoLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkurWzmBgUESnpGL21HLaNI5u+WsY8PPPWN09LZm8LI=;
 b=lhllmg7ED8MmQ6jC1K2HidRW7DwIxNL2n0zF9NpExWJC+cbKf8Xl7f3YfveEKFzuTkzYrYV5G+OcRWOZr4wB1L5z0FbYSn8eGAk/JimlcXlmDB0hHQedSJBmhySage+5AgfOue9rF9JAhWh4CR39bjUZ3XnqRQwF3GXCQvjQDhw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1848.namprd12.prod.outlook.com (2603:10b6:903:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 14:48:38 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 14:48:38 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <015f2823-e03f-1cc0-6b9f-4c6109225863@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <5f17b6b0-15b6-bcfc-9576-6d5c8ee70f0f@amd.com>
Date: Fri, 5 Mar 2021 15:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <015f2823-e03f-1cc0-6b9f-4c6109225863@gmail.com>
Content-Language: en-US
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: AM0PR05CA0077.eurprd05.prod.outlook.com
 (2603:10a6:208:136::17) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.122.77) by
 AM0PR05CA0077.eurprd05.prod.outlook.com (2603:10a6:208:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 14:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc84ecdc-c6f5-4d32-379c-08d8dfe5c299
X-MS-TrafficTypeDiagnostic: CY4PR12MB1848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18488677B783D64A51B0E7DA8B969@CY4PR12MB1848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E95LTWnbhcIfxA9+Yc4xKR9cXcXmM3Wh61DFt0u0F9VfmZuR+B+yjMnwSw/d0R6+KlSVuxa24vyZozOgPK8403NVeitSp+rDEGV5F2s+cbHx3KQgIflUytlBxQ9oUHmHGzIrzUaAhlCbxRourOM+sa3rLe9qbiRFldnwb84YQjHqnztowV2SvhwjwuLK7T1tS935HaIBmpLrDBAfwXdXcrcwbUcvfxyFISLh10EtPtZ5HgHPtb+KBdB2WPuuqWafDWLSdIr1gPnstb3Cd5bsX11PGW4aiQ2EkBoBxEshoIu5TmYeoE+NtY1cPI9BaD60Mu73tcotenPsYuUUpk57MME1LcaB1afcu4IKImAtyOTYtPOeSgeF/8FgwB+nvOq7Hp4d9mbMSDIjaypVVw1srvcVoRzVK4flanafip4nW3c51u1cj8sNISwXC9q1jpxlazlkSs4dOg5Aabr+xfyL8hswq9Fx+rqoAT5uZf5XCG0mpatpCIQ6Lw4UQ2MJ6DHLSj9N/rmtouLaHj1QcN0E+amFOX2nGVXJOXMG6zNwTMMNPC4VEQZak2v3mDjEaJOq2nd+FW0wH1vQSn3CD+4hIDukyc+xtntOzQOrUBebJSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(8676002)(66946007)(956004)(316002)(186003)(16526019)(6666004)(478600001)(6636002)(26005)(8936002)(31686004)(6486002)(52116002)(36756003)(5660300002)(2616005)(66476007)(110136005)(16576012)(31696002)(66556008)(4326008)(53546011)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UHV5dzdXanZCVDExR2x6K0Q4eFRia1Q5a1N0RG45V1pmUUJ2cmZwU3F0VjJO?=
 =?utf-8?B?S3lOZ1I0c2dJVVdLVmMxbjQ5YlAyakhxblRvdnQwVzh0N0Y3NU8wSy9GbHZV?=
 =?utf-8?B?WUo4WDFPSFhITWtjZDJUc3VNaktBd3pnci80eTNqSlJYNTV2ZGl1eXV1Ynpy?=
 =?utf-8?B?SjhzTDk0eGlOOGlqUC9DWlgxemxOWFpUSUIzeFVmdmJjVE4yZGVRbURBUzVp?=
 =?utf-8?B?cGRxUE50ekoxT3lmRzZCVHVXZ3RMd0VIMDMwR0VQcW55M0JKbFZUVlNvaENa?=
 =?utf-8?B?dUNPaXB4YXZDRkp0NWJMTmhjdU1RSGIwaHAydXZmS0pGYzdCb2hUMnF4RXMz?=
 =?utf-8?B?dVV1VG54aUsvZjhWTDhaRGxTYVNENkdjUmR2RFdDVnQyVmEybWwxQWF2TzdC?=
 =?utf-8?B?MW9ZRlRtRmwyOEJDd1BkNmEvQTgrZG9uT1hCNUhZQXg1OVZ2VHdDWmNGbEhR?=
 =?utf-8?B?d1VZZHNKdGVuVnA0bUt5dUVqTVRUOVJaT1BkdUxkeTg5OWNEYmZNTTljeG5x?=
 =?utf-8?B?eEtrdHloQTI2Wjczb0lhdlIya3dRSzNDem12NzhDNjZrbWhMaHNQRWZhbUJR?=
 =?utf-8?B?OXFNcTgxeVA4UlpGQ1IvelNTQWlia1dMcFZxbVZqU3J5VE5yTTJRRlhKVDBK?=
 =?utf-8?B?a01meE1QOWZoRkJ5WUJmQVp4bWkxUThKODFvQTBYdWVlb3FPSzlSQTFiUXph?=
 =?utf-8?B?Zm80aDBwVi9ZcmIyY0owa2VlZWxYN3lvMStmOWpWRndFSGpidUU4c1FyZW43?=
 =?utf-8?B?UE5hK1pZcmMwMFJrUDNoTVJ2djN6TVFxM2d0Nm00cEhRTS9NekdWTld3T2ZU?=
 =?utf-8?B?OHRaODU2Q2FGaHJhT0N4L3ozZWJVaVBNWC8wVnpjSC9yWDIvWHdWOTVHWmRE?=
 =?utf-8?B?K1UxMHdSaysycmw1SWZOY1FQMW82R1RBMWYrbDZydDdhUEU1eFFZODFTT3JE?=
 =?utf-8?B?NWdKY3ZhMXVIeFZlL0ZpU2xTdzJHSjAvaFBtaVFjRGFDbnhWOE1Ub0hOVTVs?=
 =?utf-8?B?SUtUWXkrTmx4QWdVZXRvbHozV0RXVmhiU2Y3RkRERVZVbG5va3VIbXh5R0ly?=
 =?utf-8?B?Z3hjMkJveWEzcTdTeGpuZk10aHV2MUsyUHVvYi9SS2Y3bHVGTmZrQlRWY3NW?=
 =?utf-8?B?dVIwWEplWkJPU1JtYVpRbEZpWjAydmtQU0hpRXdBbkVIczQ2MUwxV0NmblQ0?=
 =?utf-8?B?SkY1anVOaDRRcHRDRzFubFpjbWsveDRYaHArRFZkdGI2M1ZNc3gwbjd2ZXNl?=
 =?utf-8?B?RjFLMHNKSDM0aXFUV3RQZ2dwblg3SkgzYUplRTAzRWRDZFIwZmlzZFJBUW1S?=
 =?utf-8?B?Wk5kU3ZpMHUyU1hMOGVWWDhhS0V5N3Q4Nkw0MUZXT0FjbDNDMlFTbFN3S3Vj?=
 =?utf-8?B?a0Y1OG9EcW5nZ21Ub2pSZkFyem9md0MrMzFHRjNaSzZhNFpPcGwvcmZ4RGgr?=
 =?utf-8?B?Z3dpTXcvZUV5cmczWXNkS2VmVkxoVkw2RklZWGd5WEd0YjZySUg3Ry9GNHRr?=
 =?utf-8?B?VFhMNXJpend0RmRBMVRpOEtyNTdlK2JvM2ZJZ2JwZW9oTUxmS2RIcDV6TjZI?=
 =?utf-8?B?Z0RWMWI4WVdQMzNSemF2WDVxdlNONWRVNTRraExJZU5SWUtqcGY4alMxZTlL?=
 =?utf-8?B?Y2g2dUtsY3VuZTVseUZFeXplTnI1UStTTU4vam9SR3hleGtsQ2lmYmFXYnhj?=
 =?utf-8?B?RkE3eEdYdGtDU0hNdUE3R092V1FhbGlMWGo2eFZnOTVoU2ZmblBLSFltRHE1?=
 =?utf-8?Q?KId1xwSSCaukp7LdV0uI71XC/mgn81sKt5agW+L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc84ecdc-c6f5-4d32-379c-08d8dfe5c299
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:48:37.9930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5o7On6nSSLWBrWpp1o0FtHYq7TrZnAJBGprw8pNW94nOQ01umkMvUqRmzMusDDphu2l+t+Qvb8sF69kYZw5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1848
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

Ck9uIDMvNS8yMSAzOjM3IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAwNS4w
My4yMSB1bSAxNTozNSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEFsbG93IGFsbG9jYXRpbmcgQk8g
c3RydWN0dXJlcyB3aXRoIGRpZmZlcmVudCBzdHJ1Y3R1cmUgc2l6ZQo+PiB0aGFuIHN0cnVjdCBh
bWRncHVfYm8uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1k
LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyB8IDIgKysKPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5oIHwgMSArCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+IGluZGV4IDBi
ZDIyZWQxZGFjZi4uNzQ1MzkzNDcyNTY0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jCj4+IEBAIC01NTEsNiArNTUxLDggQEAgc3RhdGljIGludCBh
bWRncHVfYm9fZG9fY3JlYXRlKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqAg
wqDCoMKgwqDCoCBhY2Nfc2l6ZSA9IHR0bV9ib19kbWFfYWNjX3NpemUoJmFkZXYtPm1tYW4uYmRl
diwgc2l6ZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvKSk7Cj4+ICvCoMKgwqAgaWYgKGJwLT5ib19wdHJf
c2l6ZSA8IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvKSkKPj4gK8KgwqDCoMKgwqDCoMKgIGJwLT5i
b19wdHJfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvKTsKPgo+IFlvdSBzaG91bGQgcHJv
YmFibHkgcmF0aGVyIGZpeCB1cCBhbGwgY2FsbGVycyBhbmQgbWFrZSBzdXJlIHRoYXQgdGhlIAo+
IHBhcmFtZXRlciBzdHJ1Y3R1cmUgaXMgY29ycmVjdGx5IGZpbGxlZCBpbi4KCgpPayB3aWxsIHJl
c2VuZCB3aXRoIHRoYXQgY2hhbmdlLgoKClRoYW5rcywKCk5pcm1veQoKCj4KPiBDaHJpc3RpYW4u
Cj4KPj4gwqAgwqDCoMKgwqDCoCBibyA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm8p
LCBHRlBfS0VSTkVMKTsKPj4gwqDCoMKgwqDCoCBpZiAoYm8gPT0gTlVMTCkKPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCAKPj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPj4gaW5kZXggOGNkOTZjOTMz
MGRkLi44NDhkYzBhMDE3ZGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmgKPj4gQEAgLTQwLDYgKzQwLDcgQEAKPj4gwqAgc3RydWN0IGFtZGdwdV9i
b19wYXJhbSB7Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZ8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2l6ZTsKPj4gwqDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ynl0ZV9hbGlnbjsKPj4gK8KgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9fcHRyX3NpemU7Cj4+IMKgwqDCoMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRvbWFpbjsKPj4gwqDCoMKgwqDCoCB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcHJlZmVycmVkX2RvbWFpbjsKPj4gwqDCoMKgwqDCoCB1NjTCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmxhZ3M7Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
