Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835E6C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4125A61360
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4125A61360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B746E48E;
	Tue, 22 Jun 2021 10:40:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7916E6E48E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 10:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6yIBCvXAlyrWff1egps/N7znj4qn4XSGfRkwg1xNIpj4+ZJWyfzMqL3+3BTI/6OtyKmBitlSntmq3kLwPFuLYMBsb/voCXSt8UnhrKz1E5hTgh84LsmcXQ8N8eEavfB/sfE3ohD46tEZOerfAMslpbil+EWmvt77ecSe0bSbzISel1uox03POrLFZZ3VFpZkpRm8anM4wAAAhkNMuGJa4hdYajGEp/GznIUOkA9xPQ3Io3JD1iDyvh1OZJ7bGJ6M/wgFkZvPQQdqHCqNVHnJsBaLJVqYlOOYs3TceW0pCJZ/k5i3Pc0Ks4hTYNGYdu051eNmTWxKaEx5vUp9wRq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW4oOTe4xfAwikKM276mDonZf02cosGCYAdtntVGx74=;
 b=c4vUYSKP+ONIlm6G25IIJi+SSCL1tQ+sdQiOQsUjkkBUJrsqQxAK1yE63EepO7ifVWg+Lz6tcWE+TEbRQ3XNbdEjtOLgVb2Iy3xU3d1wPrWsmjE9rNLBHufEWwacU7UjU7CMRYS3V+VTyEIGfp+0BFeqfBuFnOuqh/diFRG//mJ3cE/DhDSFWcjFVwJSbLNsGu1cAG2xEHgpUvomeXdkVjqalt/tVKRf9X92NWpiUu3vQgLynHZdmIY1tgUFyYz18NZB/Zz4EieizcOH2Petqwv4VKI2uqTjUH1QMlp9Dw9LjElMm+4vqaDr4eXxjyXeWljPx9ePqX+MOxqqbtPl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW4oOTe4xfAwikKM276mDonZf02cosGCYAdtntVGx74=;
 b=ocQ6AeFuW2Dn2uDqURQuREkUtIIPqbJNcBhbJjbtQ2GDKZ4JpKNaSkuHGE38J4UUKJGo0nhWOm7Z2U+wGylOXKLpPQyZAGasCZ9UUWmBlP3HmNixeAXCTL9N6YoqEsorZ5gozuU2ytu4ZEepc9dutvPl3R6p/bIoQJUnbXO2lPc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 10:40:43 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb%6]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 10:40:43 +0000
Subject: Re: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 "Quan, Evan" <Evan.Quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
 <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
 <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CH0PR12MB5348A92078FAAEB0F132A78D97099@CH0PR12MB5348.namprd12.prod.outlook.com>
 <7486e471-4ff9-bfe1-947a-d726b2eadc2d@daenzer.net>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <71eeee2c-fae7-17b9-f33d-5bb3191fed28@amd.com>
Date: Tue, 22 Jun 2021 16:10:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <7486e471-4ff9-bfe1-947a-d726b2eadc2d@daenzer.net>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SI2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.3 via Frontend Transport; Tue, 22 Jun 2021 10:40:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6759b379-a520-4633-dd84-08d9356a2f76
X-MS-TrafficTypeDiagnostic: CH0PR12MB5172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5172E5F873C5EEAEB87D584797099@CH0PR12MB5172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97d8zwmjcnmU9p7rwkLxwKWwrKHx8AICCvPv9FyEULTHd79FVMH/xazsvwcj1Twk1AY64fhWGMazpOnNqdWr8NoDkUBgPvyM819trPykPmXDguYNyEfD5U6ibfQAbX1/p7kKsEV3ElAT4zfy6c7yYsTG7qaboBVjkJu9hl7heEbnFDHeQJTBrHnS6C5nRy1jcl8UmBtowSL/gb9Bw2anjuxbRVKk158qOwMSeJEnmiRDjiScRPU+gb/goX1Ywt7AqvmKj176To/6MlPWM39HXKF4a7OOBJAIjgV+jWZrD8JNiC4VZKHABxqZEAbkM0+lK5k7V6awsoB8PmTFrKKW9XZfbbGy2JkPWUgwF55U6HtvHjAZnpuxSp5oa3vQnFSX3NLHAdlClCP0j/g+vAg97cnywrlYSoBmYBhiZ4i9u38VXhb7/p6WbqqpMUsiVL7y/3Ymm0uK3reo5l9g2UHZqPDSRhFc66rTs2joglIVyCKrHp+Gz/OjdeDKpeKhdxtLmFGuNZuMjIl2NVFrWtRRgxn5MgXDW15s2esgxp/lRLHQotQj4I7ZATm01CJPoxqiRwuEqnj/yPLoPpXnhBWVyCs9+JtOIsfy/PDa/j5dZ+G8KU0uaVDcC5yn9ipOEKmQ2p8zWuBqVBSYApeAIndgWmXRZo6MMmIpGsBI5TyRb+vO5hyzjlSxCBZwvbI4+KNr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(6666004)(31686004)(2906002)(38100700002)(956004)(186003)(6486002)(66946007)(83380400001)(2616005)(4326008)(8676002)(5660300002)(26005)(8936002)(54906003)(66476007)(110136005)(86362001)(6636002)(16576012)(16526019)(316002)(478600001)(36756003)(66556008)(53546011)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ExcTlEcUJmd3ZOZitmTUhsaGw5M3VUUmJGbER6Q1J4QURucHNOYWJqYkR5?=
 =?utf-8?B?MkdZRHBiNi9hNmVmN0dtYmJKd0J2VXI2M3lQc0lGdkEvS2tIU3RZaSt4WHBO?=
 =?utf-8?B?MUZwc3IrWkpvTmFiYkpXTU90eWJ0d2g2UkVRQzNqbzhPbm9sSG9IbXQ2eDNv?=
 =?utf-8?B?WmUveTczYk1NaW41NU5uSk54S2RPQmNCOXRJTlU4V2VDeU51d1dWY0ozbEVy?=
 =?utf-8?B?M2UrVDhnZVhSd2E1ZkxWZlNiNVpNVzRUOEtKa1kyY3E1YnFBNFYrVW94dEVa?=
 =?utf-8?B?QTY3SFpJNzdMVEVFa25IUVJOaE5raVpNejZmckhGT0dxMUFPV2xRTDlUY2Fh?=
 =?utf-8?B?VGVQejI0WVlObU9IWCs0RDRRUExtNVdJM1diQmhyVUxPQXI4V1dKWHRkODF4?=
 =?utf-8?B?c05xdGVpRFJPcWpPZ3RjTWs3Z05YMEtBbzM0MVRnL2NrTHN2cDNDUjJQVVVR?=
 =?utf-8?B?MWtGWGZKRVNQcnh0NUxpY1lNLzJISERsbzZTM3E0Tm9uN0d3TGZGS28yZVdo?=
 =?utf-8?B?R21FSWRtc3VROGxNSWdhTVB3ZU5ROWdYSy9nTFFLdnZ2WEpEWlZ2SXpCMCtj?=
 =?utf-8?B?THYyVmxXVloyckpwZVJiTUpCL0xNZ2RKM2RocTVHdEdNRE1NNFJvVlNNeklw?=
 =?utf-8?B?b29mdzdsOVNNc2J1U2JhdGs2SW1QQng5WFlZbC9NUlJZaGhKZHpMbm1VcEJv?=
 =?utf-8?B?WkVZcXh1VGJOcEF1SmZxeENLQVhqU2ovN0svNU15ZnNDSTNJL1JZQVJORnZS?=
 =?utf-8?B?b216M1o2TVd3ZjNSUG01WmhXSXRKWlc2L2Z4aWpYbkUydVZiQU9iaWVXZmhQ?=
 =?utf-8?B?cFZScXBzbFNyNVBRNHlKZFpBZ09MOWFBRlZmU2daRkVjREJPQmtQQ2MwWFZx?=
 =?utf-8?B?ZmQ4dE13d21DRWpsRXNlYXQ2R1ltbXNYNDhKU1JuSWUyQytEOTFCeWwwelBT?=
 =?utf-8?B?Uk9OWVEvSDRSc2dMMVY1V05KS2xYRlNXY25mNit3NUE4dTJraXYzNTNYd1lz?=
 =?utf-8?B?M1FCSjcvSmlVWFhWeXFFVXBhdWt6Vkx3dFFZYWJrWUZMMVdQRi9nMng4eSs4?=
 =?utf-8?B?VTRtcDZqWlpBTHI1aGF1QXE4UkFXYS95V2RmVDhrd1RCK3RsVWE0V2pLU0hr?=
 =?utf-8?B?bHhzM3BHVUJkSkRQNCtPbzRNellKdXc1TlBwallMMHFRSkZrWHMvRGhFbzJm?=
 =?utf-8?B?bFZKS0hXejUvKzI0bGxUdk12Z2tVelpIaWZzTGEvZXFnYTR2REM2QVJkZGJy?=
 =?utf-8?B?ZkV0ZGtLM1E3Zk45OHlrTWpUWU1Benp2bjJrQ3JFSlhmZjBneTBDOVBWblFK?=
 =?utf-8?B?ci9TdklaRXNBd00vVVdGa2kyVGtvWEM5WXVqU0x0MStqRHZYMHkyTzZRS3VG?=
 =?utf-8?B?dW5TTlM4ZjBBZFNzY2JxN3pIV2hOdDB6cmVialpEMGNUaTZEdWk3d29ESDZQ?=
 =?utf-8?B?Qmo0QjNrQXpIV2kzK0dDRktWcFlzeWtnU2hVUVIrRkExS1FMUkRNTEFGR1Ax?=
 =?utf-8?B?YmdLQVFrc0VDZE1FSUJJVUIreGU0cDlFMm5UbUFmTFAvUWRBZXlJUE9XRGpj?=
 =?utf-8?B?ZzU3LzZRZ2UyNHM1M3p2N2IrZ0FJSWd2WU9Qd1RkZ04xNk1najJDNysydVNH?=
 =?utf-8?B?bGZlL2Y5eFhDUU9peWZyZjNucDJYYWFkUWgxYmcyL0ZUbkw4aW9SaWVJaUsz?=
 =?utf-8?B?UWRINWk3cUFYajVJMHI5cnlUN2ZrRzNvNmF4N3ZNb1JDakdMUHhqMzA4WDlk?=
 =?utf-8?Q?nXdp6NiI7COwmRcURTT/fSwBIDs3bj+cbpgNFme?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6759b379-a520-4633-dd84-08d9356a2f76
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:40:43.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtNI5OkGm7CDVdJEV/VkLw9UHt+s5HBon4ZNB57FhbrvtkMrtsEaIkdt/KGP7kaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiA2LzIyLzIwMjEgMjo0OSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAyMS0w
Ni0yMiA4OjA4IGEubS4sIExhemFyLCBMaWpvIHdyb3RlOgo+PiBbUHVibGljXQo+Pgo+PiBBRkFJ
SywgdGhhdCBleHByZXNzaW9uIGlzIGxlZ2FsIChzb21lIGNvZGUgYW5hbHl6ZXIgbWF5IHdhcm4g
b24gdmFsdWUgb2YgNCptYXhfd2dwX3Blcl9zaCk7IHNpbWlsYXIga2luZCBpcyB1c2VkIGluIHJv
dGF0ZSBzaGlmdCBvcGVyYXRpb25zLgo+IAo+IFRoZSBkZWZhdWx0IHR5cGUgZm9yIGNvbnN0YW50
cyBpbiBDIGlzIGludCwgc28gMHhmZmZmZmZmZiBpcyBhIDMyLWJpdCBzaWduZWQgaW50ZWdlci4K
ClByb2JhYmx5IG5vdCBhcyBwZXIgc2VjdGlvbiA2LjQuNC4KCiJUaGUgdHlwZSBvZiBhbiBpbnRl
Z2VyIGNvbnN0YW50IGlzIHRoZSBmaXJzdCBvZiB0aGUgY29ycmVzcG9uZGluZyBsaXN0IAppbiB3
aGljaCBpdHMgdmFsdWUgY2FuIGJlIHJlcHJlc2VudGVkLiIKCkl0IGlzIGEgaGV4YWRlY2ltYWwg
Y29uc3RhbnQgYW5kIHRoZSBmaXJzdCB0byBmaXQgdGhpcyB2YWx1ZSBpcyB1bnNpZ25lZCAKaW50
LiBSZWdhcmRsZXNzLCBhZGRpbmcgdSBzdWZmaXggd2lsbCBhdm9pZCBhbnkgYW1iaWd1aXR5LgoK
VGhhbmtzLApMaWpvCgo+IAo+IFRoZSBDOTkgc3BlY2lmaWNhdGlvbiBsaXN0cyB0aGlzIHVuZGVy
IEouMiBVbmRlZmluZWQgYmVoYXZpb3I6Cj4gCj4g4oCUIEFuIGV4cHJlc3Npb24gaGF2aW5nIHNp
Z25lZCBwcm9tb3RlZCB0eXBlIGlzIGxlZnQtc2hpZnRlZCBhbmQgZWl0aGVyIHRoZSB2YWx1ZSBv
ZiB0aGUKPiAgIGV4cHJlc3Npb24gaXMgbmVnYXRpdmUgb3IgdGhlIHJlc3VsdCBvZiBzaGlmdGlu
ZyB3b3VsZCBiZSBub3QgYmUgcmVwcmVzZW50YWJsZSBpbiB0aGUKPiAgIHByb21vdGVkIHR5cGUg
KDYuNS43KS4KPiAKPiBTbyBpdCB3b3VsZCBiZSBzYWZlciB0byBtYWtlIGl0IHVuc2lnbmVkOiAw
eGZmZmZmZmZmdSAob3IganVzdCB+MHUpLgo+IAo+IAo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+PiBGcm9tOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4KPj4gU2VudDogVHVl
c2RheSwgSnVuZSAyMiwgMjAyMSA3OjU2IEFNCj4+IFRvOiBMYXphciwgTGlqbyA8TGlqby5MYXph
ckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KPj4gU3ViamVjdDogUkU6IFtQ
QVRDSCBWMyAxLzddIGRybS9hbWRncHU6IGNvcnJlY3QgdGNwIGhhcnZlc3Qgc2V0dGluZwo+Pgo+
PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQo+Pgo+PiBUaGFua3MgTGlqby4KPj4gSG93ZXZlciwg
SSdtIG5vdCBxdWl0ZSBzdXJlIHdoZXRoZXIgIiAweGZmZmZmZmZmIDw8ICg0ICogbWF4X3dncF9w
ZXJfc2gpOyIgaXMgYSB2YWxpZCBleHByZXNzaW9uIHNpbmNlIGl0IGtpbmQgb2YgdHJpZ2dlcnMg
c29tZSBvdmVyZmxvdy4KPj4gQ2FuIHRoYXQgd29yayBmb3Igbm9uLXg4NiBwbGF0Zm9ybSBvciBl
dmVuIHdvcmsgcmVsaWFibHkgZm9yIHg4NiBwbGF0Zm9ybT8KPiAKPiAKPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
