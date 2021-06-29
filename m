Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909C5C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 19:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C89861DC2
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 19:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C89861DC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61476E8ED;
	Tue, 29 Jun 2021 19:00:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719076E8EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 19:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlQuXBlHdFTyY3DzIBn8hFvQnTrcrKoXRfMwg7DWp3gd9T6B0tPbXwlsIXNtwF4evoUm2IDmEofTgQvDCwf1t07lJyMvBEcqTM2qk1wHCmgLcNXBlo8chWMfN/DW8QgfBlhzKr5se6qjoO43GFrCSBwY1JT3sN0lO9wT3M1x8fQjg7V1Z7Ea1I+yOE14qPhJBS5cC8kdQCICa+LD5u0pzjJt1hZdOwqZ/hsaMepgqDHZEx1wPGfnyeC5Jnn6KyqTzSdF/zwEi5h0UxqJRsEyHAbjiJtagheT2vP/o1ZlAFXxhX8xgCiAJslPKRFLasmaKUbvdLWJmFJ77fbSv52IBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS76emhX722cyi+DAU/72PVRmpOYvLMK8qOzu7Mrmd4=;
 b=gk+ZKlG0LWGW90N/NUjIpbx50lCTTaGCK4FGVMOs6U3N9coWaQMqZOBMeWxlQEQDFFoDOBfgeBaf8UFYBobbGHkvmJp3hDVsMnw8v7Kyh/EYc3hT+HGL3Z/37lW9A1QGbft0MB+krFnaGG4nrWsLcf/pBK5QPnL3kCQ60j6/iHRNieWT3DvA7QZ3ml7XbzXryMz8C2wQfeMWw4TEiFSpxP7atXFbbC12fohTNrI5lITxH1Z61fNbNyN1luY4HZf7KaZUG3gMv/AeXDZbXwRMkv41M7mIwQiChtGG1jG443tvmXbD/ZwV9NmgIMLBCIVGr5814vyioosLV0xcQaeUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS76emhX722cyi+DAU/72PVRmpOYvLMK8qOzu7Mrmd4=;
 b=KzFuhcM2SNDwfHcozzzXYAN7HhlvNBqADh0N8GpEjaYpH/lICooEO9d7L/s4ZL8U9RqwcGOVGd/etFmW/fXkhYdrnWqC+olCfHV/m7eVcV3wJqiP3dMIxYjBQFYQNsNn7ycF9+i2npbXGNke0xSidkxtz1Qbsec5PH5PWLhCsGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 19:00:21 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 19:00:21 +0000
Subject: Re: [PATCH 11/11] drm/amdkfd: inc counter on child ranges with xnack
 off
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629180206.8002-1-alex.sierra@amd.com>
 <20210629180206.8002-11-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a8079f5c-43ee-f811-7730-1ec5b6f03170@amd.com>
Date: Tue, 29 Jun 2021 15:00:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629180206.8002-11-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 19:00:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 380f3f4f-13c6-4f51-fc9b-08d93b302513
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5384A956B5DA1B13B0FDA64692029@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAp76MfgEsaN+Om7excbmji5+uu8Y7VQlA2g+yLNN8MZNDLim/VHb0RfnCHKfCLqXCaRqSoVTSRv5qUn6GZLv2nOnX7WCMyWipj8+yF6ZFpwZ3L+oewBBI0K3yrehl5UEz4qPOGWq216z1BTm3azJpNH16ww2jrzHL3mgm4LNLsXW9la7s/1g3CoZCEaEV+saTJ18ZGVTVmN163n4Ffp6z9e0xUufCIQPfFePcgTT1OCyQbW2H2jlH9DFvJU8nsfCBK3rEKjZrhfMyFfhmjalgGAExKj54ttS7rjzX1nCzt3BDc4rsut7kGyckScobSBQuIsY4tn3XDmqPbrGNxcH4iAlIHqUsW4o3FuAsTx0OztZveSeXW+KDQaV5ZNPtmDcv1yaRbJBjH4HDHq+BcqC3j6MKwHD9o3hVLIojmAgXuRBHtbIzrlcfCWhj4urYnJ92YBB47Epxo4CZIrGO6QJbNPdFmnUuipWBYH6WofDOFVjQnQRSemHP5K2xVq2+pKKC4tBUcphxOaxG/GjvptTyskcwcQp+uNPkAu1GLoH4O76m1jmDioul21U44xxgCdamc+NMhWNS9D7U1+zR/L7AiIHYWOTJskO8PU25FK0U2CHY5p3WOHX9qX7potRFVSAThST6p6om1s1equ9c4WshJ4tySejSBWL9nRg+oIMpV6qvjHlKFTbIT8eWyDgp2ooChxopeaXz+KwbJcjipquT/uvcKuXbuOGJuCCzNwtFmOnjJsTNvUlfrMVi56Dt9j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(478600001)(44832011)(5660300002)(956004)(66946007)(66476007)(66556008)(8936002)(8676002)(2616005)(31696002)(86362001)(38100700002)(186003)(316002)(16576012)(6486002)(26005)(83380400001)(36756003)(16526019)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hlQUVaTmVUejFZa0pNWEZ5M0o4RXNtT0JoRWtvY2ozSGZ6S0x1SHZDOURo?=
 =?utf-8?B?YmI1WEVTU1FYUzhwZ1NXSWlSOWpqbXJ4TzJuY0tGTlc5SEU0Ukw1QXpBNlJj?=
 =?utf-8?B?a2Q5STlWejhpRFZNUGpCTm5tVkhZNmF4VzQ0bkRhTmdsdmJvMTA1VFVDdE9L?=
 =?utf-8?B?T2pQT1pIVnBVYjNWYi9oNDVrck54eVY0RjUyTTV1T2tIUXhPMDBFTUo3Wmk5?=
 =?utf-8?B?bm1qRGhFWEFhTWpZWFdsa2lPZ1ZkME40LzVhT1VuOHE2OTdsMVJFRTltL2Z5?=
 =?utf-8?B?VmV6aTZNa21zV2N1WGNZckY0alRFSXBYTy93UStoUEhNcGZ2N0txZkNzd0dN?=
 =?utf-8?B?N1RQYUM5OFNRYVF6NytsVjFUNWxTNFRPa3FrRW9tSzhiVmd3RnVFR0kxTWli?=
 =?utf-8?B?R1FSSmRQWFkxaFl3S0FxWjBDUjNLQitNMWVUMHYrTXR3OFYycUlwbVpPRFVS?=
 =?utf-8?B?OFpQblJxTis4T21hSFJLN1JGZXd1SW42bmN2aU5WdHR3Rm55VkliTVYySUlJ?=
 =?utf-8?B?NmZGY1Z1c3FVaFl4NnJCK2xjMzFtZUtNR1RNQ1pVTDUrcFVFNjJlZnV5aDJj?=
 =?utf-8?B?YUc5NXR5cTZLbXFsWXFzeFQ2S2xMeTc4MWV1MThxSlhRYWlpUExkdjVNWGJ3?=
 =?utf-8?B?SFNQczJ0N0VjTld4OWEyNXR3ZCsxTnZnbTJuL1lacDZDbHZYLzg3eVBsa2xE?=
 =?utf-8?B?VmU2K3dBdEpmMHd4cUF5YVp0aGZOaVR0OGJNYy82NHhQY0xLY09NVmU2M3Rh?=
 =?utf-8?B?MVNReWpFUFVEZHI1dlpCdWVsb0xkKzRxYkJ1S1hEaTZJa2dPZFg3Z0FGMnVz?=
 =?utf-8?B?YkVQcjlkazNkRDNDT0xLNEJOSzFCWFoyQjFzYnZxdWlvbDVIUFR6ZUxkQ05B?=
 =?utf-8?B?VEM4dzd1YUNOWjE5Qk93ZWV3VEptbFpPTm9RNWZzcWt0WnFFOSsreEhWb1Ar?=
 =?utf-8?B?bC9XZkN3bTAvaEUxZ2RwWVI5RDQzNGxJd1BtYVp3U3U1S2txTktXZmRIcmlJ?=
 =?utf-8?B?eE0yejFhZWZYbGF4cUFDZUwrZnU0aW9aWU9CeHBPL0tNbmN0TXVsUXoyaVFE?=
 =?utf-8?B?TkUwWFJoejM2b0djb3VzcFVjQ0ZFU0puMzJFYzF4YWk4Z0JkSzVFTHpqdnk2?=
 =?utf-8?B?dTZzdndnT0dRR3NQdjZRcG96bkc0aTlOMHNUa1B1S0FxWU9xb2xCdXRvWkU4?=
 =?utf-8?B?cHdPSWgzTENSN1I1bGczeFdMcHFvZEd4WHF3a1ZWam11ZFhaZGRDd2lGQTJH?=
 =?utf-8?B?OWdYZWIwRzF6Wm5NVlQ0dnBVL2RHNmpKcTFEeTcweE9RZWxzNmVjNFNNVk1F?=
 =?utf-8?B?K2Z6alBMelhraFpnTnk5YmQySGx3MkNsdWtRZFN1d0VIUlFvR3pxVlNRcDJp?=
 =?utf-8?B?c0JDTjV2cks1MWxFTDBUbkthVmdHem1IeEh6VEdqNXd4Z3YvVldubXZsTVQz?=
 =?utf-8?B?Z0pPajgwWkRLMmxkSnN0bG9ZbnhKK1NidUJxS2YyRmY4K3BsS1IxajgxV2py?=
 =?utf-8?B?TTAveS9LRUNQY0tqN0NzclBDVmJXVHZWaW9OSFdqb282S3hXbkloWUg5Qi90?=
 =?utf-8?B?MmJtZ3FOM1JEK2NMUXl2UFJtRm1lOUFYUHlNOVZsYS95NHZUcG94M1UvK2wz?=
 =?utf-8?B?SWVmd01QbUo2c2dvWjRTS2VtQVk0MUJ2dWpiVERweTYzeWsxSVdoeDRLbjBl?=
 =?utf-8?B?SzlhekNjbU9iVzBzRkFYVHRwNnFMelVWNStRTmZJK1htOTQ3TXhzNFQ3Tk9j?=
 =?utf-8?Q?MT6rFAi6F0r0nPe6EftbhltXi5+WkvBulXyUeyw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380f3f4f-13c6-4f51-fc9b-08d93b302513
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 19:00:21.7237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZQ2wwvj00wcMzMc7tF2iKH4i6KqYFJjGtY5IK4jsZgkl8KKgv/Z/5swMcRmG2HE4muDU51zQRDwuLMdxZOQBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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

CkFtIDIwMjEtMDYtMjkgdW0gMjowMiBwLm0uIHNjaHJpZWIgQWxleCBTaWVycmE6Cj4gRHVyaW5n
IEdQVSBwYWdlIHRhYmxlIGludmFsaWRhdGlvbiB3aXRoIHhuYWNrIG9mZiwgbmV3IHJhbmdlcwo+
IHNwbGl0IG1heSBvY2N1ciBjb25jdXJyZW50bHkgaW4gdGhlIHNhbWUgcHJhbmdlLiBDcmVhdGlu
ZyBhIG5ldwo+IGNoaWxkIHBlciBzcGxpdC4gRWFjaCBjaGlsZCBzaG91bGQgYWxzbyBpbmNyZW1l
bnQgaXRzCj4gaW52YWxpZCBjb3VudGVyLCB0byBhc3N1cmUgR1BVIHBhZ2UgdGFibGUgdXBkYXRl
cyBpbiB0aGVzZQo+IHJhbmdlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4
LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
c3ZtLmMgfCA4ICsrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBpbmRleCAy
OTRjOTQ4MGExODQuLjY3NjA1ZTRiYzNjNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMKPiBAQCAtMTYyMiw2ICsxNjIyLDcgQEAgc3ZtX3JhbmdlX2V2aWN0KHN0cnVjdCBz
dm1fcmFuZ2UgKnByYW5nZSwgc3RydWN0IG1tX3N0cnVjdCAqbW0sCj4gIAkJdW5zaWduZWQgbG9u
ZyBzdGFydCwgdW5zaWduZWQgbG9uZyBsYXN0KQo+ICB7Cj4gIAlzdHJ1Y3Qgc3ZtX3JhbmdlX2xp
c3QgKnN2bXMgPSBwcmFuZ2UtPnN2bXM7Cj4gKwlzdHJ1Y3Qgc3ZtX3JhbmdlICpwY2hpbGQ7Cj4g
IAlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnA7Cj4gIAlpbnQgciA9IDA7Cj4gIAo+IEBAIC0xNjMzLDYg
KzE2MzQsMTIgQEAgc3ZtX3JhbmdlX2V2aWN0KHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwgc3Ry
dWN0IG1tX3N0cnVjdCAqbW0sCj4gIAlpZiAoIXAtPnhuYWNrX2VuYWJsZWQpIHsKPiAgCQlpbnQg
ZXZpY3RlZF9yYW5nZXM7Cj4gIAo+ICsJCWxpc3RfZm9yX2VhY2hfZW50cnkocGNoaWxkLCAmcHJh
bmdlLT5jaGlsZF9saXN0LCBjaGlsZF9saXN0KSB7Cj4gKwkJCW11dGV4X2xvY2tfbmVzdGVkKCZw
Y2hpbGQtPmxvY2ssIDEpOwoKWW91IHNob3VsZCBjaGVjayB0aGUgYWRkcmVzcyByYW5nZSBvZiB0
aGUgY2hpbGQgcmFuZ2UgYW5kIG9ubHkgaW5jcmVtZW50CnBjaGlsZC0+aW52YWxpZCBpZiBpdCBp
bnRlcnNlY3RzIHdpdGggc3RhcnQuLmxhc3QuCgoKPiArCQkJYXRvbWljX2luYygmcGNoaWxkLT5p
bnZhbGlkKTsKPiArCQkJbXV0ZXhfdW5sb2NrKCZwY2hpbGQtPmxvY2spOwo+ICsJCX0KPiArCj4g
IAkJYXRvbWljX2luYygmcHJhbmdlLT5pbnZhbGlkKTsKCkFsc28gYWRkIGFuIGFkZHJlc3MgcmFu
Z2UgY2hlY2sgZm9yIHRoZSBwYXJlbnQgcmFuZ2UuCgpQbGVhc2UgbWFrZSB0aGlzIHRoZSBmaXJz
dCBwYXRjaCBpbiB0aGUgc2VyaWVzLCBvciByZXZpZXcvc3VibWl0IGl0CnNlcGFyYXRlbHkgZnJv
bSB0aGUgc2VyaWVzLiBUaGUgc2VyaWVzIGlzIGFib3V0IHRoZSByZW9yZ2FuaXphdGlvbiBvZgpW
UkFNIG1hbmFnZW1lbnQuIFRoaXMgcGF0Y2ggaXMgYW4gdW5yZWxhdGVkIGJ1Zy1maXguCgpSZWdh
cmRzLArCoCBGZWxpeAoKCj4gIAkJZXZpY3RlZF9yYW5nZXMgPSBhdG9taWNfaW5jX3JldHVybigm
c3Ztcy0+ZXZpY3RlZF9yYW5nZXMpOwo+ICAJCWlmIChldmljdGVkX3JhbmdlcyAhPSAxKQo+IEBA
IC0xNjUwLDcgKzE2NTcsNiBAQCBzdm1fcmFuZ2VfZXZpY3Qoc3RydWN0IHN2bV9yYW5nZSAqcHJh
bmdlLCBzdHJ1Y3QgbW1fc3RydWN0ICptbSwKPiAgCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnN2
bXMtPnJlc3RvcmVfd29yaywKPiAgCQkJbXNlY3NfdG9famlmZmllcyhBTURHUFVfU1ZNX1JBTkdF
X1JFU1RPUkVfREVMQVlfTVMpKTsKPiAgCX0gZWxzZSB7Cj4gLQkJc3RydWN0IHN2bV9yYW5nZSAq
cGNoaWxkOwo+ICAJCXVuc2lnbmVkIGxvbmcgcywgbDsKPiAgCj4gIAkJcHJfZGVidWcoImludmFs
aWRhdGUgdW5tYXAgc3ZtcyAweCVwIFsweCVseCAweCVseF0gZnJvbSBHUFVzXG4iLApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
