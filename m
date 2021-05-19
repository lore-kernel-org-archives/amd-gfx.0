Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6E7C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87893610CB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87893610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35ACF6ED7D;
	Wed, 19 May 2021 11:49:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A18376ED7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 11:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQDtUR0ppgWB+HGWx6IC1NB8GnAgDcvAxIo1lGDAdWx7u9VBLi/1y/QzyD6cj58swQSKdxbfk/LvU9UwLW9vld5tVFO66Brv95/RGi8xE0FYyrjYN4DGeY6Gd0g0aL+wbk5iGegheBMo9qK352eE27HFGPNevLVoeEe6ypVkI5z2JKwAH3vEDdEvy1rxd3urOkf92CVdR/wNYkPF/5C5Widc9Odz5OBQ5Dz2nErc23k3Iwols5vGsHQrwuev99P9tZQMKmeUsTgNJhXMc1i9lDaO+tukYPvmSxy4yYtH8OWxT/jnLxkzqc6EBOX0VD2jK8SO6IgiZfS7v8lf0tTnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ECiMpz1wjE+7POqLillyMcjsQcRLuPhLdVrIiBApMI=;
 b=CWpK2bf/IsA+1n6JIAZM+MlnBeUhjlRcHfXAQ91K6UvY7Fkgiw/RcIujVox3duMFfkNd/NSnYw0rfPzRwv3DU5aK7+kG7WCypApOvJ/LD87n8Qpj9mmP8Mm+Xdh9oNktpdZC0LL8feDBrl5D9c9zomxKDCQpRNxRRI1ntpjpR+qNAKVEcFKFOVL8zG/A9I+vaIn6uL6jYoWFt5czvtUHsTvFaGK7I2MZXi5ttZIxuzCpIe6wvGlUgBQYiIDPD4WGkl9KyqkUbfONCYXq3m/CmP3BfWOZgsJW1gSafgwlswNez0kmOoFRQ5QTxVza9P/4tOMvuFdh2h4HCMDFZrGiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ECiMpz1wjE+7POqLillyMcjsQcRLuPhLdVrIiBApMI=;
 b=WWjdQkv9r1i6rI15BJWFa6dHtNMvcmR3wQTq8ted0cNUJ4uDD8fY2r9eQXdvFa1oVgSevEKekgpDN1foaKQBcdlkur4Udg2erK4VdRqUAZXlDLQI1b2wZNoiIX1Nh6r0aTbewB3U0w6jHiiWFc/VAOVlPradQ/VCLEUoDftqPrk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 11:49:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 11:49:11 +0000
Subject: Re: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
To: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210519093209.888377-1-ChengZhe.Liu@amd.com>
 <b9d6e51c-b172-9627-799f-937c3e94851a@gmail.com>
 <CO6PR12MB54592ED7CDBD40D670A80361932B9@CO6PR12MB5459.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cd905238-aeb7-dd71-e1a7-2fd8d20a2474@amd.com>
Date: Wed, 19 May 2021 13:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CO6PR12MB54592ED7CDBD40D670A80361932B9@CO6PR12MB5459.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8e28:1d3:41f3:e15a]
X-ClientProxiedBy: AM4PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:205:1::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a]
 (2a02:908:1252:fb60:8e28:1d3:41f3:e15a) by
 AM4PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:205:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.11 via Frontend Transport; Wed, 19 May 2021 11:49:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 357d8092-7e9a-42e5-07e1-08d91abc1e09
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408868FD6F091BBBFA8B1F3832B9@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7zXEr9S2vkz1dsIM2p2XZ0zq6j+i55eQUnlnXx9a+GmlyFSLsNetzKyYepNSJTvdLXoAV1CuzMgQIWjdB9XOPtTwaNFYPbc7wXWRzkc69fJBLMLcNBsrkV8o1V4ekFHL+DKZ3FEJpm7MiB8A5NfyhhthKzVIXm3vq921DYbcQZ+lvRWId1LdrHw0EEkf0eSWhCdue8kT88Ok1ip8iB9yTmA7PiYOa2fSqXZkpMKPc5p8+3zQjQv5MkmOXmXtoW7us2mBamUTKHf0ZKFSjCd/p/XEfInmGgZx/T4QC+9+4l6X38kCjaQGeenrgJG5nL1jrkiw7iuExJODbWe3rpDwoHsOc+ikJ+jwjspm8lv5BjV3GXuCBeQ5Jqf3Ex4M75t6cBGyysJeFaMpUN64YXf96XkfuyTXRLDazcLANZC4oXUMig0JL5iF4vwDE896k/gX0GBOCykcHKsKZt6a2t27PX4CL5IEPbt2UZCqRbw4cvWzlN/k+0CU5q1mXS5HqaT+WKwVHZVQ+5EYc9q0O/N9uq1uHbAw4pQl9Fvr+RBfK6nGFcNgeMSs476c/a/OG2Oc67gisiO3wFbg6tZ5msqqjoDCLI5itRn2n4ACeVTbjn2vBiYWfHueF85/35GbkJIfb8j9ZywZXpdb08xNDGn5eiEdDS74KaE4SAdm84tiAYoipDNmlBhJ4rmV5BxmNQu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(31686004)(4326008)(52116002)(2616005)(66476007)(66556008)(6486002)(8676002)(66946007)(16526019)(186003)(8936002)(478600001)(38100700002)(110136005)(316002)(31696002)(54906003)(5660300002)(2906002)(83380400001)(66574015)(53546011)(6666004)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cVVlUEExSnpBWk11T3pJZDVvNURrdmN2VUUyR3FlbTJTRGkzcTVvUE1UMzNj?=
 =?utf-8?B?dGlodDJqbGZHUW9MSExxejFRNWRMVHNzTXA4aGNhKytkcmVlMWdxTUhDK2ZF?=
 =?utf-8?B?NFVDZ3Z0ZHliSEpiMHlZWFI3bUVlUHdxTitGdmdobUlFbVU2N2RqMXhia0gy?=
 =?utf-8?B?ditLQXh4eDB5MXhrUVgwcVVPS2tKUHpMbklpdDgrR1oyRWdZMUFKRnJPR1Vw?=
 =?utf-8?B?djUwa3YvQmlyTVBZUjR5dFJLdDZLREZtQ2tBS1E5UlN1VUxXYlJjZW9QbThU?=
 =?utf-8?B?K1pqNU1QRUtpWndlTDJNVlAva0dtM3gvY04zNVZVMEhKVi9qWGVIczg4Zml0?=
 =?utf-8?B?c2RqZFlob1ZJWEMvTjNJM3hjNWp3d0RsN3JrYWRFaTFlSEhoS1ZUK0t0czhH?=
 =?utf-8?B?bVVpeVBrQ2V4TEFRNnlDWTI5Z2kzMmRWc1o1NHdpZUJ5TlREZXg1SU9VUlNh?=
 =?utf-8?B?TS9pSTZVTm01SkxDc2FYZTh0WUVpTHF4QVVmQW5PUU1wNHdlYUl6N01Dd3U5?=
 =?utf-8?B?QUQ5eWtZMEdQcmhCa3REZTJGaDhYbHVwN2FScUZpQksreVJ4Qmt0SWFMdE12?=
 =?utf-8?B?UHBnSlJHa0Fqd1NtekZ6eUJvN3JMbVpZRHFwc0RwSEhHVjhQVkxNbWduQTRx?=
 =?utf-8?B?RzhyOW0zdkE5V1lSekVHeWp1ZXZ2RC9lNVNjRjFrQjc3OWhDbDJnK1d4MFdV?=
 =?utf-8?B?NGtsSE81WWhSbmVPNlBvTUtoMi9FbjNhdElQbmV3VGhXTWp3eEx2WVNuWE1y?=
 =?utf-8?B?ZUV6WGlOZ2FDdUpRVU1ZMy9nUlViU1dQdENLMUNyanJKSWx2bE1ta1hzZ1FT?=
 =?utf-8?B?N1BmMVdGWkpEMHRzSUVxend3VFVlYjBqaHJDWEtVM3RPTkplZDZiYlV4RkFU?=
 =?utf-8?B?WWV1L2xrVjhiRWFTcnN3cy9XWFpyYUdDdXlZd3l1V1ArYnFzMHZ2UUthU1Qz?=
 =?utf-8?B?aDFZcENFSnBPK3QvZDdxUDNxSWRLeHFXNDhjNThXT0w0dnVUbmloV2Z2dG5v?=
 =?utf-8?B?VzVUSDRaNStvTmZjeHArY1k2anlGQnI4WDE4TkZkYlJzSDNzbWFXZlZMSGhu?=
 =?utf-8?B?b3lMTVh1YjE5dU5ZdjFTVGtBNXdYVjNRZDVtRDlkUlJMdWZoaE5XVmRtS2pW?=
 =?utf-8?B?ZkZ6TmJnL0JJZnFGc2tUaC9uYUg4MU02UlFMaVpDcXFRNGNyZTJHcHZ4YVVv?=
 =?utf-8?B?eHVmN0M3czhhKzdoSHdHRXc0UUtVRjl0ZTg0R2xWQUN0T1ZKZUtNMjYwUUFQ?=
 =?utf-8?B?RXBncjNmNU9zRnRSQmp1d2hQMXhFajRTSFZ3VEJ5Y0VnamhsYndZVGh1Sldz?=
 =?utf-8?B?bzBublcyL3FLT2dOUDN1bnhPY2pFSkRmT0ZaQ3FTdVNla0dTS0hWN2dpTGls?=
 =?utf-8?B?b1pua3pOMkMvLzMyazV5SWFsanJJaGlqOGk3MHgzMXRMeFM0SGxsUmVhdVRu?=
 =?utf-8?B?NFBFRjJWK2xoWFZJY05LeWp4emF2amFYUlBvL3owckRRRE1wQzA1N2NKck90?=
 =?utf-8?B?b2RJMkJ1R3pxcFE5cXRlVHAyQldQNVFRYy96WlpucnpWdEMwaitWNFkvSHRa?=
 =?utf-8?B?bFJZWmJMdlRLYjBLL2JTSXA4Z1grMXhzcXA3TjRqR00zMXZUMHV5Y2lySzdn?=
 =?utf-8?B?cXhMcmFCWFhzWTZRbk9xM0JDdmdnR1k2NW5VT2VJNEpvQWhFTzR6S1Y5UXUw?=
 =?utf-8?B?RW02c2lBR25lTzdKc0FDZTNmQkduVjM2RXVrdUZkV01tV0FUNnpxNy9vbjlr?=
 =?utf-8?B?N09YVCtxZmI0Y0tBdHc2bHNLaHA3aFhTNE14NGhJZ1VOSUoxVEsrSzd3bWpu?=
 =?utf-8?B?SFVkaS9LbGxrSEI0bi9nVXZGZ0VKOS9mNkdzZ1UvQUZlOGVXUitwQ2xPTTFZ?=
 =?utf-8?Q?Nz3id94nxSkh5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357d8092-7e9a-42e5-07e1-08d91abc1e09
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:49:11.0967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrkYFmawhKIpO+Mxznym6WTo621q+iBTxedS37N92GYOFkkzM+6Zutlxp9fWhMcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVhaCwgYnV0IHlvdSBjYW4ndCBkbyB0aGF0IGl0IHdpbGwgcHJvYmFibHkgdHJpZ2dlciB0aGUg
d2F0Y2hkb2cgdGltZXIuCgpUaGUgdXNlY190aW1lb3V0IGlzIG5hbWVkIHRoaXMgd2F5IGJlY2F1
c2UgaXQgaXMgYSB1c2VjIHRpbWVvdXQuIApBbnl0aGluZyBsYXJnZSB0aGFuIDFtcyBpcyBhIG5v
LWdvIGhlcmUuCgpXaGVuIHRoZSBvdGhlciBpbnN0YW5jZXMgZG8gYSBGTFIgd2UgZG9uJ3QgcmVh
bGx5IG5lZWQgdG8gd2FpdCBmb3IgdGhlIApUTEIgZmx1c2ggYW55d2F5IHNpbmNlIGFueSBGTFIg
d2lsbCBraWxsIHRoYXQuCgpDaHJpc3RpYW4uCgpBbSAxOS4wNS4yMSB1bSAxMzowOCBzY2hyaWVi
IExpdSwgQ2hlbmcgWmhlOgo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldCj4KPiBXZSBzdXBwb3J0
IDEyIFZGIGF0IG1vc3QuIEluIHdvcnN0IGNhc2UsIHRoZSBmaXJzdCAxMSBhbGwgSURMRSBmYWls
IGFuZCBkbyBGTFIsIGl0IHdpbGwgbmVlZCAxMSAqIDUwMG1zIHRvIHN3aXRjaCB0byB0aGUgMTJu
ZCBWRiwKPiBzbyBJIHNldCAxMiAqIDUwMG1zICBmb3IgdGhlIHRpbWVvdXQuCj4KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVp
Y2h0enVtZXJrZW5AZ21haWwuY29tPgo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE5LCAyMDIxIDY6
MDggUE0KPiBUbzogTGl1LCBDaGVuZyBaaGUgPENoZW5nWmhlLkxpdUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5j
b20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IFdhbmcsIEtldmluKFlhbmcpIDxL
ZXZpbjEuV2FuZ0BhbWQuY29tPjsgVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJ
bmNyZWFzZSB0bGIgZmx1c2ggdGltZW91dCBmb3Igc3Jpb3YKPgo+IEFtIDE5LjA1LjIxIHVtIDEx
OjMyIHNjaHJpZWIgQ2hlbmd6aGUgTGl1Ogo+PiBXaGVuIHRoZXJlIGlzIDEyIFZGLCB3ZSBuZWVk
IHRvIGluY3JlYXNlIHRoZSB0aW1lb3V0Cj4gTkFLLCA2IHNlY29uZHMgaXMgd2F5IHRvIGxvbmcg
dG8gd2FpdCBwb2xsaW5nIG9uIGEgZmVuY2UuCj4KPiBXaHkgc2hvdWxkIGFuIGludmFsaWRhdGlv
biB0YWtlIHRoYXQgbG9uZz8gVGhlIGVuZ2luZSBhcmUgcGVyIFZGIGp1c3QgdG8gYXZvaWQgZXhh
Y3RseSB0aGF0IHByb2JsZW0uCj4KPiBDaHJpc3RpYW4uCj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hl
bmd6aGUgTGl1IDxDaGVuZ1poZS5MaXVAYW1kLmNvbT4KPj4gLS0tCj4+ICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgNiArKysrKy0KPj4gICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgfCA2ICsrKysrLQo+PiAgICAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4+IGluZGV4IGYwMmRjOTA0ZTRjZi4uYTVmMDA1YzVk
MGVjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
Ywo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+PiBAQCAt
NDA0LDYgKzQwNCw3IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGJfcGFzaWQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgIAl1aW50MzJfdCBzZXE7Cj4+ICAgIAl1
aW50MTZfdCBxdWVyaWVkX3Bhc2lkOwo+PiAgICAJYm9vbCByZXQ7Cj4+ICsJdWludDMyX3Qgc3Jp
b3ZfdXNlY190aW1lb3V0ID0gNjAwMDAwMDsgIC8qIHdhaXQgZm9yIDEyICogNTAwbXMgZm9yCj4+
ICtTUklPViAqLwo+PiAgICAJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gJmFkZXYtPmdmeC5r
aXEucmluZzsKPj4gICAgCXN0cnVjdCBhbWRncHVfa2lxICpraXEgPSAmYWRldi0+Z2Z4LmtpcTsK
Pj4gICAgCj4+IEBAIC00MjIsNyArNDIzLDEwIEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2ZsdXNo
X2dwdV90bGJfcGFzaWQoc3RydWN0Cj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgIAo+PiAg
ICAJCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsKPj4gICAgCQlzcGluX3VubG9jaygmYWRldi0+
Z2Z4LmtpcS5yaW5nX2xvY2spOwo+PiAtCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhy
aW5nLCBzZXEsIGFkZXYtPnVzZWNfdGltZW91dCk7Cj4+ICsJCWlmIChhbWRncHVfc3Jpb3ZfdmYo
YWRldikpCj4+ICsJCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhyaW5nLCBzZXEsIHNy
aW92X3VzZWNfdGltZW91dCk7Cj4+ICsJCWVsc2UKPj4gKwkJCXIgPSBhbWRncHVfZmVuY2Vfd2Fp
dF9wb2xsaW5nKHJpbmcsIHNlcSwgYWRldi0+dXNlY190aW1lb3V0KTsKPj4gICAgCQlpZiAociA8
IDEpIHsKPj4gICAgCQkJZGV2X2VycihhZGV2LT5kZXYsICJ3YWl0IGZvciBraXEgZmVuY2UgZXJy
b3I6ICVsZC5cbiIsIHIpOwo+PiAgICAJCQlyZXR1cm4gLUVUSU1FOwo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4gaW5kZXggY2ViMzk2OGQ4MzI2Li5lNGExOGQ4Zjc1
YzIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+PiBAQCAtODU3
LDYgKzg1Nyw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gICAgCXVpbnQzMl90IHNlcTsKPj4gICAgCXVpbnQx
Nl90IHF1ZXJpZWRfcGFzaWQ7Cj4+ICAgIAlib29sIHJldDsKPj4gKwl1aW50MzJfdCBzcmlvdl91
c2VjX3RpbWVvdXQgPSA2MDAwMDAwOyAgLyogd2FpdCBmb3IgMTIgKiA1MDBtcyBmb3IKPj4gK1NS
SU9WICovCj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAmYWRldi0+Z2Z4LmtpcS5y
aW5nOwo+PiAgICAJc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOwo+PiAg
ICAKPj4gQEAgLTg5Niw3ICs4OTcsMTAgQEAgc3RhdGljIGludCBnbWNfdjlfMF9mbHVzaF9ncHVf
dGxiX3Bhc2lkKHN0cnVjdAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiAgICAKPj4gICAgCQlh
bWRncHVfcmluZ19jb21taXQocmluZyk7Cj4+ICAgIAkJc3Bpbl91bmxvY2soJmFkZXYtPmdmeC5r
aXEucmluZ19sb2NrKTsKPj4gLQkJciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcocmluZywg
c2VxLCBhZGV2LT51c2VjX3RpbWVvdXQpOwo+PiArCQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYp
KQo+PiArCQkJciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcocmluZywgc2VxLCBzcmlvdl91
c2VjX3RpbWVvdXQpOwo+PiArCQllbHNlCj4+ICsJCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9s
bGluZyhyaW5nLCBzZXEsIGFkZXYtPnVzZWNfdGltZW91dCk7Cj4+ICAgIAkJaWYgKHIgPCAxKSB7
Cj4+ICAgIAkJCWRldl9lcnIoYWRldi0+ZGV2LCAid2FpdCBmb3Iga2lxIGZlbmNlIGVycm9yOiAl
bGQuXG4iLCByKTsKPj4gICAgCQkJdXBfcmVhZCgmYWRldi0+cmVzZXRfc2VtKTsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
