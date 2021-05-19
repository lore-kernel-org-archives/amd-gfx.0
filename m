Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECABC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2950611BD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2950611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7CC6ECD3;
	Wed, 19 May 2021 03:29:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CB86ECD1;
 Wed, 19 May 2021 03:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrJOfO7hLM6iD09Vxosl+nPxnSTtNQziqrgjVfLDh5vkKBgDZ1JM63lVcjpiv4xZXtKr8af7YWQM5wGca0Bq/qE0fGyHz86n6YJywQbnWorPyZ3bJhYtk95znqm0yfaylJBRGPzbqIeof/DiYBjGu29Dp7GdfPAb72jhuOD4alUXWjDcqXCNQFOQCOnW+2ct3IKMF1GmYpXgSDrjTlrVxpar90s/Gur76v4UCb9SrFlLt3sOd70kLs2pjdwBSyVibeY1o+Kpu1Q0pCvFEtSYhVWgjcgc55Vpza2EOhU3hAsVpOonAtIHDLtKbUbZ2XXAtsQciWosusklvrKWlNIcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDf/k2KMi1Uh+Jct7VOkEKJ/0oNNOt4kXbFaqZGO+88=;
 b=MWt9yzajOp4pVt+2j1S+xM4U0AVBbsQWN7hE3UnXDZLDxkqFVCq0/i79Vra6ZVFX5PlcBfRk7DlDgXEf1C7pjbp+WVpPWbwT2ECaaaT+6FZJp8eRPjG6e2mbDL90rjNUpCz7cQuNATnzIvKPBg2smRiMfL+rIAUM6O17ZN980T2rKDMWVAGnJOrvU/IAB1ymLzMR8HHc44mL7FK47f0G+ZQ+IXRIoyj6VCCdyiYb9o8HzsNPYve1JqR69QLDuG5Ey2LaasLWYQohLqrnRhLdnId3lddPtGEqjWnoBnlpz/IU67FgRz3hPS/lq6QjIi2QsyhoA/lUNqiz7Tyjk3Oh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDf/k2KMi1Uh+Jct7VOkEKJ/0oNNOt4kXbFaqZGO+88=;
 b=4KOBd5QtGAK0O4tuT0Hp8fIOCTJTEUSguEc8taTEXr0n8OFFZLTxdyfR7VSQinBEB8XrKSh1wPhDzjbzy583bOPFe002t3n8K8o4Rlt/MMz5d9hg7QV7r03SRcnOHJmUaNOKWnrKuER6oFA5mfG51YP+jrEDJZ3cCpJMKeEMHxY=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 03:29:09 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 03:29:09 +0000
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Fix memory corruption due to swapout
 and swapin
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210519022852.16766-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c7f28ef7-c0a1-ff76-2b48-4559a8e0e593@amd.com>
Date: Tue, 18 May 2021 23:29:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210519022852.16766-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT2PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT2PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Wed, 19 May 2021 03:29:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ba8050-192e-49cc-cc2c-08d91a764348
X-MS-TrafficTypeDiagnostic: BN9PR12MB5227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5227B9190992E6C8C7ED82C5922B9@BN9PR12MB5227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMzWgPQP9EFy9uhC4OiSk9k4B+TC+r4GOkaQ6agOUBfRQRHnif+GEJzw+Ts34IkKE+AoPItwXW87PH8F1p+YwjjhgVhqyefxOIR4GxMYgP4FBIdEbRthXklTVKS3E2pmuT8XkReOAZPQRyDK9JBE2PYg/UTsaM8heQXZPItwOz6vSvFsZUWOh2O+UVzpn+uM25f9z6T0AZeWUJB5lLfd9HoczDkYkD4QwMTUogwNcJavmQPgIbVyZ+s7cee97LIlTOwbVk1RjM5baUqh2YK9O9rurkQGnFaX7lQiCJEDTIpWqAYHOy8vdcMSxmyTzEJbHJA+UmPiPRjBjR+HiTTSfDexbdhyVq7sk510GEMzZhmIDabwpmenBLCFOKpB9KjQmvcqQgff1+wm8Jui27NZhloGlt0EQcqcaI2bUeq4lBtahPPb7vwNoMcPnNIkJVQy2VKuuB1PwIdjpSoFVLTc65GS10V3d/fodnTPrmoS2dRIjmVOC7mmiU/Ndwtkz3ToaQc9QokD66OWyDc3g8dKmhOnauzCkvFAEB8AVjlXlgCNOcMXlDwbOzdGgQNQ+Z40HNCzd4Zej2ZEb2rcAG7oixIEQ1RVGdUXBbQNEbZ/4zDFiAO+s7JSmljydcqINAO49AuYlRyt9X5gsJ24iYoDeKaAXPIjM+80sU+wUt2Hb3jM6kA1XTQXQ9W1YQxwQbuuPt+VJbKl6NfIJxwaT5IiaON+Kl16fiPA0XPazBkCFZ0MgXum1Ib3rhxGNqTDAcKd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(4326008)(2616005)(66556008)(31686004)(5660300002)(83380400001)(956004)(66476007)(86362001)(66946007)(66574015)(52116002)(186003)(36756003)(16526019)(36916002)(8936002)(2906002)(26005)(38100700002)(53546011)(8676002)(6486002)(966005)(31696002)(478600001)(316002)(38350700002)(44832011)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTNyb0F1UWhscUszSkZDSmlXWGFWL0xYOE95aW1QNUQyMTJCMkRTeC9rTEdv?=
 =?utf-8?B?YVdiOG1tMmtJMk5lZ0hwWkVqTHVDalNyTS80NldTV2lnWEJWSjEzNVhzeS94?=
 =?utf-8?B?eWRNZlo2Q2RMcW03M1ZVWHl6dmR5WkpGRjJKSVdlTytmZ2psVklNN2VhNFZD?=
 =?utf-8?B?bXl2aDB6N1Q3ZE9yOGJBbUFiem5ONlB4MWh0bDZqZERNdi8yYkNJQUdGV3ls?=
 =?utf-8?B?KzIrRW9xVXBVK2t0T2ZFaWZsM1lEckJNUjFxV1dDampITWtmd29rUGNlbll1?=
 =?utf-8?B?RjJEM09UTTNoZDhsNWdROE95cm4xV1c0aW5acmZDd0pmUGFhRFk2WHZERE1i?=
 =?utf-8?B?ZkJES1F3S2xNa1BEc1hyTjFUcEJyQWhIYTdHS3ZhdUNRQ09rdnQ1NStPWmFk?=
 =?utf-8?B?UEowejFYblBqVklBTTVmenBNZG4wUUkxbzVFcWNFYXNUN3NxcGU5VFQwTFUw?=
 =?utf-8?B?TVpCN3hidTFyM2p4dlBkRHNmZmErNnVaL1NjTlV3WmMrZG8wbVgrUFZXRjRI?=
 =?utf-8?B?ejR0VHFGYXpzajdFTFZJa05JV0Zmc1FZV3czckRnYkM3N0tNYm93QTFiKy94?=
 =?utf-8?B?cHFNODlqeUtoK0h6RXc5N0YzZkZYbGlxcENEVGZlQ2FVbWFWZWdOOUhwQWVX?=
 =?utf-8?B?WWZjMnVGbFBta2VUTlgrc2gvbFVKaGxqL1JRaThrQWdqaEtxN3B6VmpHakE0?=
 =?utf-8?B?TEpyL3FBTkYzek53TzgrSWJOZlZoNTJIcDVETlI2Z2s0V1VzRkxvUkFNbENP?=
 =?utf-8?B?aDdDblR4aGdNTHdTdiswd21GTEd5eHJwYkVPaU1mVHYvVEdjSk1ta29CL1A5?=
 =?utf-8?B?aEE0VHZWSWxOV3ErY3QvV1gwbmZXS0FhV28vZjl4QkRwdUR5NndVQzZCamp2?=
 =?utf-8?B?WTJFcGxNcnQxM1JZWGFGaVJGVnN1NTc2THliQTJJVElYZS9rR29oMW8vYjRR?=
 =?utf-8?B?WG5jRlRCMFhkZGRqL1JQa2ZYU2RaQVZNRkx1bTdRZ3JBNkVYZ1plbGlZYjg1?=
 =?utf-8?B?WXhjVTkwU1ppRFQvRkFHUGtGbURmcWtGZzBZTnVCUWZha25QaXMvdXZ0UVdq?=
 =?utf-8?B?VHFxV0wwdkNKWm94WURZVy9KZ1hFajRsMHpaT0ZFWHgyeUdrVFBpQTV1aTZS?=
 =?utf-8?B?RUpRYnIxR1hFY3NCUmx6WUlVZ0Q1UW5wZ0MxWXFRYzF6QWEyK0ptMlBENGFp?=
 =?utf-8?B?VFRpSzlUNTJHaVdkVVAyRFczZVN2N0dKZml0SzF0UzF1MmdFangrNXJWT256?=
 =?utf-8?B?NGlqK1ViaUJUcENvODViUjF4SHBKNi90QWtVeWVDZ1ZRZkRYaVhrV3lpbFBC?=
 =?utf-8?B?MER6WDQ2azZtWlRVQkpUbGRXdDQxdXRpSHlWZHZrcGpDQW0wS2c1R3o5RC9w?=
 =?utf-8?B?ajFoNXptVHV2VzBhRjBhTHp5MlN3ZFVWN0lzb3c0NWExaWVEYzF5TmFrTGNx?=
 =?utf-8?B?aXNMWGVtTnE0ckExWm9JQTEwc3NHbUVzQTk0bWhtNWtDUWlWSDBBVEE5R2pS?=
 =?utf-8?B?RkpMZjIyZ2hWK1ZpWFBhdUVrWEo1RkNrRkZhR01ZQzNOdEQ4SUdFSW9PUTU2?=
 =?utf-8?B?cjk0V3l2M2h0NGgzeTBiRDhyU3VKa3lTNU4wR1YyL3FaMHJlNGVVa2pweFVh?=
 =?utf-8?B?QW5YcEwzWUVzbXZjL3krUWp1MFFXdkRzRGNJK0U2RnNIQVBrYUxtUS9ONURi?=
 =?utf-8?B?TGZPNXdGOWh3N0RlRGxwSi81N3NmSGFnaDFINE5oYjBPeVcrNWFDQ0o0S0Fv?=
 =?utf-8?Q?qEtGRIHav0VOrK64cODZT+HTC8CZsD9moeeGFfG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ba8050-192e-49cc-cc2c-08d91a764348
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 03:29:08.8934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqI5SYrunimSujT+obTMPWRHE3np3+uI2VEMKBH9kvDO2I361C30Is8/t/5HazDMoDzwK8oGYn/hajqYZrvsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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
Cc: alexander.deucher@amd.com, daniel@ffwll.ch, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U3dhcHBpbmcgU0cgQk9zIG1ha2VzIG5vIHNlbnNlLCBiZWNhdXNlIFRUTSBkb2Vzbid0IG93biB0
aGUgcGFnZXMgb2YgCnRoaXMgdHlwZSBvZiBCTy4KCkxhc3QgSSBjaGVja2VkLCB1c2VycHRyIEJP
cyAoYW5kIG90aGVyIFNHIEJPcykgd2VyZSBwcm90ZWN0ZWQgZnJvbSAKc3dhcG91dCBieSB0aGUg
ZmFjdCB0aGF0IHRoZXkgd291bGQgbm90IGJlIGFkZGVkIHRvIHRoZSBzd2FwLUxSVS4gQnV0IGl0
IApsb29rcyBsaWtlIENocmlzdGlhbiBqdXN0IHJlbW92ZWQgdGhlIHN3YXAtTFJVLiBJIGd1ZXNz
IHRoaXMgYnJva2UgdGhhdCAKcHJvdGVjdGlvbjoKCmNvbW1pdCAyY2I1MWQyMmQ3MGIxOGVhZjMz
OWFiZjk3NThiZjBiNzYwOGRhNjVjCkF1dGhvcjogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgpEYXRlOsKgwqAgVHVlIE9jdCA2IDE2OjMwOjA5IDIwMjAgKzAyMDAK
CiDCoMKgwqAgZHJtL3R0bTogcmVtb3ZlIHN3YXAgTFJVIHYzCgogwqDCoMKgIEluc3RlYWQgZXZp
Y3Qgcm91bmQgcm9iaW4gZnJvbSBlYWNoIGRldmljZXMgU1lTVEVNIGFuZCBUVCBkb21haW4uCgog
wqDCoMKgIHYyOiByZW9yZGVyIG51bV9wYWdlcyBhY2Nlc3MgcmVwb3J0ZWQgYnkgRGFuJ3Mgc2Ny
aXB0CiDCoMKgwqAgdjM6IGZpeCByZWJhc2UgZmFsbG91dCwgbnVtX3BhZ2VzIHNob3VsZCBiZSAz
MmJpdAoKIMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+CiDCoMKgwqAgVGVzdGVkLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFz
QGFtZC5jb20+CiDCoMKgwqAgUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5j
b20+CiDCoMKgwqAgUmV2aWV3ZWQtYnk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVs
LmNvbT4KIMKgwqDCoCBMaW5rOiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0
Y2gvNDI0MDA5LwoKUmVnYXJkcywKIMKgIEZlbGl4CgoKT24gMjAyMS0wNS0xOCAxMDoyOCBwLm0u
LCB4aW5odWkgcGFuIHdyb3RlOgo+IGNwdSAxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNwdSAyCj4ga2ZkIGFsbG9jIEJPIEEodXNlcnB0cikgICAgICAgICAgICAg
ICAgICAgICAgICAgYWxsb2MgQk8gQihHVFQpCj4gICAgICAtPmluaXQgLT4gdmFsaWRhdGUJCQkJ
LT4gaW5pdCAtPiB2YWxpZGF0ZSAtPiBwb3B1bGF0ZQo+ICAgICAgaW5pdF91c2VyX3BhZ2VzCQkJ
CSAgLT4gc3dhcG91dCBCTyBBIC8vaGl0IHR0bSBwYWdlcyBsaW1pdAo+IAktPiBnZXRfdXNlcl9w
YWdlcyAoZmlsbCB1cCB0dG0tPnBhZ2VzKQo+IAkgLT4gdmFsaWRhdGUgLT4gcG9wdWxhdGUKPiAg
ICAgICAgICAgIC0+IHN3YXBpbiBCTyBBIC8vIE5vdyBoaXQgdGhlIEJVRwo+Cj4gV2Uga25vdyB0
aGF0IGdldF91c2VyX3BhZ2VzIG1heSByYWNlIHdpdGggc3dhcG91dCBvbiBzYW1lIEJPLgo+IFRo
cmVyZSBhcmUgc29tZSBpc3N1ZXMgSSBoYXZlIG1ldC4KPiAxKSBtZW1vcnkgY29ycnVwdGlvbi4K
PiBUaGlzIGlzIGJlY2F1c2Ugd2UgZG8gYSBzd2FwIGJlZm9yZSBtZW1vcnkgaXMgc2V0dXAuIHR0
bV90dF9zd2Fwb3V0KCkKPiBqdXN0IGNyZWF0ZSBhIHN3YXBfc3RvcmFnZSB3aXRoIGl0cyBjb250
ZW50IGJlaW5nIDB4MC4gU28gd2hlbiB3ZSBzZXR1cAo+IG1lbW9yeSBhZnRlciB0aGUgc3dhcG91
dC4gVGhlIGZvbGxvd2luZyBzd2FwaW4gbWFrZXMgdGhlIG1lbW9yeQo+IGNvcnJ1cHRlZC4KPgo+
IDIpIHBhbmljCj4gV2hlbiBzd2Fwb3V0IGhhcHBlcyB3aXRoIGdldF91c2VyX3BhZ2VzLCB0aGV5
IHRvdWNoIHR0bS0+cGFnZXMgd2l0aG91dAo+IGFueWxvY2suIEl0IGNhdXNlcyBtZW1vcnkgY29y
cnVwdGlvbiB0b28uIEJ1dCBJIGhpdCBwYWdlIGZhdWx0IG1vc3RseS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDE2ICsrKysrKysrKysrKysr
Ky0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
Cj4gaW5kZXggOTI4ZThkNTdjZDA4Li40MjQ2MGU0NDgwZjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAgLTgzNSw2ICs4
MzUsNyBAQCBzdGF0aWMgaW50IGluaXRfdXNlcl9wYWdlcyhzdHJ1Y3Qga2dkX21lbSAqbWVtLCB1
aW50NjRfdCB1c2VyX2FkZHIpCj4gICAJc3RydWN0IGFtZGtmZF9wcm9jZXNzX2luZm8gKnByb2Nl
c3NfaW5mbyA9IG1lbS0+cHJvY2Vzc19pbmZvOwo+ICAgCXN0cnVjdCBhbWRncHVfYm8gKmJvID0g
bWVtLT5ibzsKPiAgIAlzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4ID0geyB0cnVlLCBmYWxz
ZSB9Owo+ICsJc3RydWN0IHBhZ2UgKipwYWdlczsKPiAgIAlpbnQgcmV0ID0gMDsKPiAgIAo+ICAg
CW11dGV4X2xvY2soJnByb2Nlc3NfaW5mby0+bG9jayk7Cj4gQEAgLTg1Miw3ICs4NTMsMTMgQEAg
c3RhdGljIGludCBpbml0X3VzZXJfcGFnZXMoc3RydWN0IGtnZF9tZW0gKm1lbSwgdWludDY0X3Qg
dXNlcl9hZGRyKQo+ICAgCQlnb3RvIG91dDsKPiAgIAl9Cj4gICAKPiAtCXJldCA9IGFtZGdwdV90
dG1fdHRfZ2V0X3VzZXJfcGFnZXMoYm8sIGJvLT50Ym8udHRtLT5wYWdlcyk7Cj4gKwlwYWdlcyA9
IGt2bWFsbG9jX2FycmF5KGJvLT50Ym8udHRtLT5udW1fcGFnZXMsCj4gKwkJCXNpemVvZihzdHJ1
Y3QgcGFnZSAqKSwKPiArCQkJR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwo+ICsJaWYgKCFwYWdl
cykKPiArCQlnb3RvIHVucmVnaXN0ZXJfb3V0Owo+ICsKPiArCXJldCA9IGFtZGdwdV90dG1fdHRf
Z2V0X3VzZXJfcGFnZXMoYm8sIHBhZ2VzKTsKPiAgIAlpZiAocmV0KSB7Cj4gICAJCXByX2Vycigi
JXM6IEZhaWxlZCB0byBnZXQgdXNlciBwYWdlczogJWRcbiIsIF9fZnVuY19fLCByZXQpOwo+ICAg
CQlnb3RvIHVucmVnaXN0ZXJfb3V0Owo+IEBAIC04NjMsNiArODcwLDEyIEBAIHN0YXRpYyBpbnQg
aW5pdF91c2VyX3BhZ2VzKHN0cnVjdCBrZ2RfbWVtICptZW0sIHVpbnQ2NF90IHVzZXJfYWRkcikK
PiAgIAkJcHJfZXJyKCIlczogRmFpbGVkIHRvIHJlc2VydmUgQk9cbiIsIF9fZnVuY19fKTsKPiAg
IAkJZ290byByZWxlYXNlX291dDsKPiAgIAl9Cj4gKwo+ICsJV0FSTl9PTl9PTkNFKGJvLT50Ym8u
dHRtLT5wYWdlX2ZsYWdzICYgVFRNX1BBR0VfRkxBR19TV0FQUEVEKTsKPiArCj4gKwltZW1jcHko
Ym8tPnRiby50dG0tPnBhZ2VzLAo+ICsJCQlwYWdlcywKPiArCQkJc2l6ZW9mKHN0cnVjdCBwYWdl
KikgKiBiby0+dGJvLnR0bS0+bnVtX3BhZ2VzKTsKPiAgIAlhbWRncHVfYm9fcGxhY2VtZW50X2Zy
b21fZG9tYWluKGJvLCBtZW0tPmRvbWFpbik7Cj4gICAJcmV0ID0gdHRtX2JvX3ZhbGlkYXRlKCZi
by0+dGJvLCAmYm8tPnBsYWNlbWVudCwgJmN0eCk7Cj4gICAJaWYgKHJldCkKPiBAQCAtODcyLDYg
Kzg4NSw3IEBAIHN0YXRpYyBpbnQgaW5pdF91c2VyX3BhZ2VzKHN0cnVjdCBrZ2RfbWVtICptZW0s
IHVpbnQ2NF90IHVzZXJfYWRkcikKPiAgIHJlbGVhc2Vfb3V0Ogo+ICAgCWFtZGdwdV90dG1fdHRf
Z2V0X3VzZXJfcGFnZXNfZG9uZShiby0+dGJvLnR0bSk7Cj4gICB1bnJlZ2lzdGVyX291dDoKPiAr
CWt2ZnJlZShwYWdlcyk7Cj4gICAJaWYgKHJldCkKPiAgIAkJYW1kZ3B1X21uX3VucmVnaXN0ZXIo
Ym8pOwo+ICAgb3V0OgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
