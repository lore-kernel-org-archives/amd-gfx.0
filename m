Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E4C48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 14:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA6A61364
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA6A61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E238B6E3EF;
	Wed,  9 Jun 2021 14:01:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2DC6E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 14:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLA2EjRIA+jOjeNGQIbEc6Sxg4hKz7rfrnULTeuFImQDTqz5Ja6Dxm34eMMd/IKQbx45VX0Ee3vK6lUPAImUv2ntGZ8gT7YeokIcSlvdjLs5xIxwuZxRFKSx1ZfAGzwvRyZf/hozLSstBwylWb87dJL+QGANh1s1eyefjLTbSR7UmrGL+9OjcvfmrllrHEquCYsaflsc7Q9gtuTRcDgYtVjl5c8urKZ7vo42A+D4JIo+8p0vbJwLj6sjYLU8bEqkEQKQ1ZI72ECl7JC+eGYePswG6IOuTPe2KAQwTr7gjzOxoREfkdG++g3Awh6YXj3EC82vcvzd7+Anj85ECvR+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02Vg1j5YcUNjUdNInvebAoG/51/mP7FSkmzuwbi4TI4=;
 b=Er0tYV0T4gUja6qQxMwULAX5vNjAlwNBUQeWWcVDpXG6G1zaFLF4QnOJJ04UvBEVFaG1ZYfjG+IISidrxO+6LUhjbmTOj/vDgCDA3aGPffr/9vME7psHYyU1NgnnPt8i6wnRQPECWcV7ON+IRwvGXb3RazbuP4qGi6MYn5/QlPSvDzUvkodGMX8IqCmJefxOCR6GwWrpbpgo2vOOp4y23ryvk0CwHXdGUeoaiixS2Aei2fThu3HT7GSpylnAXz7hf8LgQMlttdQskv3s2DJT7H4v2M8NTltyHQtH8NFFGD6OKwVEsMnyTWmTej1yeC/Q05qcGoF8WmIPIsKOrcvyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02Vg1j5YcUNjUdNInvebAoG/51/mP7FSkmzuwbi4TI4=;
 b=E+ssknNSBQ0XwxR0d0h1NN6b+rWA0tMkS3/dbzviv++Gw4nOvUGc7YrzTUfVy1kWm+QA1UYC7Y+xtUc3y7Qh0cdvZyKzAxkgOvUND4wmD4N9Wh31HJUel6wzZ1Z+HKVxqVQ24JQ5w4HKPNqpO1yih66fXoKUWxXrwYQPTWybVTM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 9 Jun
 2021 14:01:25 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 14:01:25 +0000
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 luben.tuikov@amd.com
References: <20210609092323.32650-1-guchun.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ab48ac1a-16a4-3bc2-13e4-bb3c1fb6a3ba@amd.com>
Date: Wed, 9 Jun 2021 10:01:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210609092323.32650-1-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 14:01:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c376102-6ecc-4fce-abd9-08d92b4f11c7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5307F8DEF74F8719E1EB460292369@BN9PR12MB5307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sejeGwlPbl8BrWAhM4TFNosbDqaoJlysLPKlh/R61biA1lNUakMd2EpfrewVI4Kce4MhQYWmAxTPpRm8443ofQgxObvaSxKHW9BgVJ5+kOdueNXdTM9i1vY7ImDRHz3Hhr24v05/nfQB5CXt161Gp85VW2vMqLF10u/n9OBfSLmHqKpgPzxLwDpNx8UxH5PFG+SMIKhBcHn5Ht8S+aa2kXbJi/00yWUbSw9b2LrO61ag3N3M/aKt2+rYF+qeTjUNhK10JLpuowVDcmY7oUqfS/BIQABENm5pXC9TDuv99PxIzxA6MN5GV/f4P4F3m6T/9EIpAy/sEF39JZRUc8isPfNpAdwxB1DZbHuZsnqvOKxSTuYD1ghLbkSbGaALNiLE4/J4bAWLlL68MTauIBxlSAqBEQvBoX0e8JhfrcLmqlKK199u9Es5yG4+peg8LB4mhyf2GEHdYrs4z7PGMikCdpwP/uylmo739PI0XtHishxqU0N4zec0nOONfLV4juLwNLCK1aUyV7um0Meyb4Eg9C9LrCTv99rp1/bCLyvGTJY+RLS5Oz5RZ3dTM9Asez/i9ndhZFaTzFkPu4vWH+oKTfbENaC8+Ps/LbjqDk/CjijwRf1gVvEBaBbgJKiJQ25voml6IrDoUTSyZjF7ORzEEkCwSHASOzl2tDSYfzhm1R9paq3h8SKNBjtGgPzdhR5x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(8676002)(36756003)(478600001)(6636002)(26005)(8936002)(186003)(16526019)(2906002)(956004)(66476007)(5660300002)(83380400001)(66946007)(66556008)(31696002)(86362001)(6486002)(16576012)(316002)(31686004)(2616005)(44832011)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBkTVdPb2ZVT00wb2lRZkFCYk9wejR0T0JmVldQUituNnJRSER2S1ZxNUE1?=
 =?utf-8?B?a2xNRnpmbGt1aUVuVXcxcndSV21vNDVFQ25rRnY4elEyN0FWUTUzT25EelVy?=
 =?utf-8?B?YkpXbURiZndpNE1EZzZtckxZalhPeG40cFBHWEJJeGRXZ0xuMFZZNzhCcFpu?=
 =?utf-8?B?clp6VnplUHZwbDVXM0kzL2huSDNCWnBZVUZaRVFDNUl4ckYxT3NycXFNWVFr?=
 =?utf-8?B?ZjdHbTR0ZXBBNXZiSEhCb09GMjNZeUE5Qmh2OTBoZ3FhdUFuT0JJa082aTlh?=
 =?utf-8?B?U05rK0pTT2FvMHNUaExIZVNXTXVBcXJEOVJuNkJ5d3R1NXoyV0thYlFxSGlW?=
 =?utf-8?B?UEluTytkRWxpRTNENDdxT1JMR1F0cG5jRHJNdnU3dG1XK3R5UHlRMzBHNE1S?=
 =?utf-8?B?MlNtYm8rTDJxNkE5ZFJ1Z2p1U2YrTXJsaHZQWk5yVmxFUzBTNi9heTF0VERa?=
 =?utf-8?B?MzJPYzhrV3hNc21Qa0gxeFBGQ3kwZHo0Vm9jNmZrbEk2K1QwczEwQjc1NWsr?=
 =?utf-8?B?Y0hWUGptb01GeitkalloMDRwdDJSNzJRWVJ4K0dOdWQ4N0g4QkNWOUQ5OXlO?=
 =?utf-8?B?OUkwMDRUTHZ3QXBDVXBiZXRFYm1CdUlackRmYzA5Y0F5dnNITXl3dngxTlpi?=
 =?utf-8?B?cDFMYWlsOEthTHdRcmdvMGxzdGNEY1pDT053OGtYN0FJNDJiako2ekx0MHlv?=
 =?utf-8?B?NVNUcUVFT0RrdTZvSnhMSnkwckRLMTZEdDJpQmVOVDhyY3dJTUFmd1kvVWxn?=
 =?utf-8?B?c2w2VDZoVHFHbXVNT3IrSzZmamd4OFVzNVMwL0RYZ01ENnBUUy9wcFJwM3pO?=
 =?utf-8?B?U0YyeVhlQVl2aG1xLzVoSiswNnR4QkowZFBQTEdRaVQyQXU4cUtDdVJ1WWR3?=
 =?utf-8?B?YVhJcHVKaFBxelplV2pFQ1ptam82UTVGYm01WHdmOU9ZOFloUDZRdjZzb3Fs?=
 =?utf-8?B?QmtyanVlT1luMnMwNWNTQlkwNGVoeXhzMnRTakFZWUxsQldHUkNyTDJqNGxq?=
 =?utf-8?B?dHEyREdOTmVnMGpLWHFRNmxwSnM0ZzJwZWc3bzZCV2puaExVMFh3aDNEdXc2?=
 =?utf-8?B?NXBNTUc1VHhFaVNzbXJ5eWFBSlNjTTR3WjRVcjlmaFdiRU53amxEV0ptc0dP?=
 =?utf-8?B?WHIza2RSNTJnS2lHQyttWDNhZW5uQU1DTklkUHFSQWN1aTc1YVdBQmdPcjdz?=
 =?utf-8?B?VHVzR05WOXNkdWs3YnFuc1p5a0dBeDU5Y040QkxIZGEvMVFUQTFTQmxyaS9u?=
 =?utf-8?B?NklGbEgxVmlvTEZTcHR0R0lGVDVHZzh2MVZvSzFaMGM1NDVUa1hVMXNVeWVu?=
 =?utf-8?B?endycFZmTWU4dysrQnVwaS9qMGV4dTZBb2c4U3NyOFlIMWZzVWpCL09obG5r?=
 =?utf-8?B?aHlTVFZadk13UDk2VFUwbTlneGxCWktsUFFlT3FXeFlmZDdQWllBSzBFK2N2?=
 =?utf-8?B?WFlDanFQR1VJalhWR09TNGd5OFFVOTI4SzRkTWpZQzdEbUN4N2hNd3dQZXAy?=
 =?utf-8?B?dHc0dktmbXNsdE1yZksxTkR5MVkwYnl6OXkzSHFJNEhCNlVudkoxdmZXUnQ2?=
 =?utf-8?B?T1JZSS9aSi9JUkwxZG9FMHFqZFFIU1FCQlBBb1A4K3BuNHhhb21nMEZRNGdT?=
 =?utf-8?B?M0FUU24wRDRLS0RVYkJ2NDM2ME1haGdKOXdQRnV3am92dUFtejUvS2RvZE5G?=
 =?utf-8?B?TDRLdWltejVaaHptSkErWTdRbEQwbzhFMmFNRnRwMHJnNUwvTWVPSXlmOUFI?=
 =?utf-8?B?SUlzdzlrd0cxRjlUR1dkai9kaDByTEtJS3Z2Q2lzR1o3TkJndnRoR21kU01s?=
 =?utf-8?B?Y0VzbUpNRjZ4RzA3OWdDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c376102-6ecc-4fce-abd9-08d92b4f11c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 14:01:25.2137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKDTuUIdF/Om1MlBAr3v/n9wQ6sgTtSlGkOUVLdNBdwxcPj0cPbhAyXFbgzVxRxmTjR2Qy8AHxxEtM7XcncNNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0wOSB1bSA1OjIzIGEubS4gc2NocmllYiBHdWNodW4gQ2hlbjoKPiBGaXhlczoK
PiA5ZmFmMjYyYzMyZDMgZHJtL2FtZGdwdTogQWRkIERNQSBtYXBwaW5nIG9mIEdUVCBCT3MKPiAw
OTBmM2E2MGQ3ZTggZHJtL2FtZGdwdTogVXNlIGRlbGF5ZWQgd29yayB0byBjb2xsZWN0IFJBUyBl
cnJvciBjb3VudGVycwoKQSBGaXhlcyB0YWcgaW1wbGllcyB0aGF0IHNvbWV0aGluZyB3YXMgYnJv
a2VuLiBIb3dldmVyLCB0aGUKaW1wbGVtZW50YXRpb24gb2YgYWRldl90b19kcm0gZG9lcyB0aGUg
ZXhhY3Qgc2FtZSB0aGluZy4gSSBkb24ndCBzZWUgdGhlCnBvaW50IG9mIHRoaXMgcGF0Y2guIEl0
IGRvZXNuJ3QgZml4IGFueSBwcm9ibGVtLCBhbmQgSU1ITyBkb2Vzbid0IG1ha2UKdGhlIGNvZGUg
bW9yZSByZWFkYWJsZS4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IFNpZ25lZC1vZmYtYnk6IEd1
Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAyICstCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyAgICAgICAgICB8IDIgKy0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gaW5kZXggMDE2ODE1Yjdh
NzczLi5mYjZiY2MzODZkZTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAgLTYzOSw3ICs2MzksNyBAQCBrZmRfbWVtX2F0
dGFjaF9kbWFidWYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBrZ2RfbWVtICpt
ZW0sCj4gIAkJfQo+ICAJfQo+ICAKPiAtCWdvYmogPSBhbWRncHVfZ2VtX3ByaW1lX2ltcG9ydCgm
YWRldi0+ZGRldiwgbWVtLT5kbWFidWYpOwo+ICsJZ29iaiA9IGFtZGdwdV9nZW1fcHJpbWVfaW1w
b3J0KGFkZXZfdG9fZHJtKGFkZXYpLCBtZW0tPmRtYWJ1Zik7Cj4gIAlpZiAoSVNfRVJSKGdvYmop
KQo+ICAJCXJldHVybiBQVFJfRVJSKGdvYmopOwo+ICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jCj4gaW5kZXggZWM5MzZjZGUyNzI2Li5iZmJjYjlmZjI0NTMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4gQEAgLTIxMjIsNyArMjEy
Miw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfY291bnRlX2R3KHN0cnVjdCB3b3JrX3N0cnVj
dCAqd29yaykKPiAgCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBjb250YWluZXJfb2Yod29yaywg
c3RydWN0IGFtZGdwdV9yYXMsCj4gIAkJCQkJICAgICAgcmFzX2NvdW50ZV9kZWxheV93b3JrLndv
cmspOwo+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBjb24tPmFkZXY7Cj4gLQlzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2ID0gJmFkZXYtPmRkZXY7Cj4gKwlzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2ID0gYWRldl90b19kcm0oYWRldi0+ZGRldik7Cj4gIAl1bnNpZ25lZCBsb25nIGNlX2NvdW50
LCB1ZV9jb3VudDsKPiAgCWludCByZXM7Cj4gIApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
