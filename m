Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE32C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 16:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEB5610E9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 16:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEB5610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA796E288;
	Mon, 17 May 2021 16:34:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FC66E288
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 16:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW4jRO9DQHTqqUMbq+H81KUD4PLrb/IEprbSGajiGZj2xUNPvvZWufXEci1ga11yYYazvJTat/h7P2TUNhGo3qNifJ7OqOFFa9xGG4pz8bVNDQP3ot5AbogtqT0mq0dxUlLebSbR3dsnAXZDOu0vnFL8cM5fpHOVPZJkx3D3QRBphn8z2AakEI6WxTgRnSavfnGEXhCALcmjmfUnNdo0Vh0bO0jVYE8bKEj8RebfEDjezl8yqIN2tRpl/U7ArWCMHRAUxv+fQC9A/ZG3vHZvjNZC/JO4fUuORzjf7JtTa1qfJB+EtLG1MY4DRmQsSO+YanGU6ikYMhrjbP6rjaXJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNNgpIVaKRqukVNq3+S8k0poRg6658IB3cCIrXvk1WA=;
 b=UrPjWWv1eKxFogDhBzUT/27TcEwgJZ2BYDF1PR061LlmFk7CdfbZUZpEJojJ5lNMKxYwUjpZIoWZ50baAvLDlfCLXFxto1EQo9c7u4bHme58x9QRhUO9w33rqZRb1O2USqQU/aqfYNC+RGqVtqBtL/ejuVKa3C1oXAhqofhTVz0AP42Gsax+eD4eCLr3pZDgsJMFjaUjPtnEv/VanZGG48cj7MU48eqNnF0blImTZqClzMDbvKssI5lEPvpqvKSq79wObAC5dDN2fRUkw8oH5yjWZEYdjSHQjoI5zuFDp8CmjPdaX9AWrOw6hatJkLF7gv9q+FiQ5ZBnEXbTgCWlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNNgpIVaKRqukVNq3+S8k0poRg6658IB3cCIrXvk1WA=;
 b=MmauNzq+qpeHiHKSYhc2jbNhfiPBan6rf3q2VZ0qIMXsYHhd6b7O1KJPis1fUvt7U3jZo7lQrVRXJCqlhseCYoREUq8wYONu0ojUvFn0iVAEzRK5YGF3aDyd8r5u7n/DxK19+/o3HOZYwSe4u1Uw2/2H2SNQT6/Ot4zoxdxWJcc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 16:34:21 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:34:21 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
Date: Mon, 17 May 2021 12:34:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:2d72:2c13:41f3:31af]
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:2d72:2c13:41f3:31af]
 (2607:9880:2088:19:2d72:2c13:41f3:31af) by
 YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 17 May 2021 16:34:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3c3f41-3884-4335-bcdd-08d919519fb3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01693BFB0A19B291502553ABE52D9@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTU3r1a5cN14X7NcQbw5fjhzydndJpMviyC7avotgtRYcnX8cc7qY1Y9vvn9klUPvnSgmEUlyTym+AyoZgiXdA8B22hAmoljRk2y9dbFO8cKOy8RD0VK52lSjHaLX4b1hChNuHYf9UWzbyynrMhHxpY+SKrI1/uMxNZuT+W5Z2gnoX9nIq0GRVvD9Ao6z1mFapFiI24X7h71RskbliUabtDU/CnCJ4Gu43ZqMjTKfhYlvMdHLDPgyf4PUZsL9E2Fk3VVteeYEUxPyRmiyO5MR2LPi4e+Q+7V2Mt8dPtxFBVfSnW8qqn7hl9YTcJkr6atohyvY/sAu3dba+s5hFScBrBB9fr3IZeeSH/AzO6dKNjuGqmlvNN7Na7NoelV+bnZ9FkVgh9xOhJUQn/JLj+W+mbzntUaMJc7lmsaE8hj5gQkyoqlCWii0+OfcCyN6QYxq+Iy4a7W7pkynZzatl6POrFGZowjgtsvIOxau5M/6NNDez0i41FPUBenCHQpyb9Y1xr36X7r0uPtU2jaXspH4p6ElOm8zagLJ8b23PPHKVbm9SAGnXoNeA79FMW5u7H18t2009c7kMl/r9ezFojDVqcTXXA0rMw5+UAohRL3izneEnMYu34NMmLZZiOZcMMMb2bSmV6cPGZ6KyhkA+UbnxFR256zEsHapan5KH1X1xEFUD3qHzqgtmqPBFEDljIt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(44832011)(5660300002)(2616005)(52116002)(6486002)(53546011)(86362001)(36756003)(8676002)(83380400001)(4326008)(2906002)(31696002)(38100700002)(8936002)(316002)(66476007)(186003)(16526019)(66946007)(66556008)(31686004)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWtFS3NjLzhGeGMyb0I1TnYzb2dNSWVGcW1mT0xvaVU1b2Y5VVZja2xBY1hS?=
 =?utf-8?B?OGdOeFkybGJMcHVKWi9kSDRPbldaM2xlVEdMYmdSODhWYUlmWnAwODNmVUxa?=
 =?utf-8?B?WTZoZHlKL2szY3dYRkxPbnluQmNRSWR3dXNqUTFZWklqNXpTOG5TeHhDK240?=
 =?utf-8?B?TFlXSGloYXZaWE5oVUZOeG53ejYyZG1rUGU3SXZHZHVsTzM4WEwxSmJRb0di?=
 =?utf-8?B?YmZsTDNzemtIemNDRWFCSUpadzdSZUxQQzBaN1F2TUtVY3BHcXpsbGpXRTBy?=
 =?utf-8?B?Q0pCRDFWWlQyZFpNT0VIalJPY1hZd0ZBMVVBa0pBdWdnK1BrNTFQRWhZM3Nt?=
 =?utf-8?B?QlB0d1I1bDA1Q1IvcU1Zdi9pcGprdkorUEpqSEttQ2hteWtnYlFnT2psNm5y?=
 =?utf-8?B?VlR5TEpqYmYzZmVHN245YkEvYzREMk5sY2Q5ZkhLWFdRRENBNXJucktEcDBl?=
 =?utf-8?B?YzBjdHEyeWMzb1FXYkkwL0dJWkVON2tXVk5TN0Z1ampNdUhlYzhHUTcxWUFX?=
 =?utf-8?B?aWpiYXBvMmo5YWZZYWdKRStjVnpKOEtLWnBzcUZDdG5TVlEzaURQQjg3Zkpy?=
 =?utf-8?B?UGVsUUR0cHh5dnVuQTdrcmhYVzZrVUNmMmpENDQ0TWhZbEI0SXBULy8xOFVT?=
 =?utf-8?B?QTNmZHh3YXpMMHpSTE1qTGZQSkNxV0ZOSVVoZy81blZ0eFdlTkhBZXVnaVhO?=
 =?utf-8?B?bzJtb04vSGRFa1NCMlhWWUN4YzJ6WVpoYkw5ZC93a2FXY010QzkrckR2VWZp?=
 =?utf-8?B?Q1VjaVFySVJCK1ZjR25vUzRKcEh4THZ0U2JLU2tBOUUzZld4WnlubmJpVDdN?=
 =?utf-8?B?UDEzWXVZbTM0TXNkM2xtT0dxeGxhTXJXajNUdElreVpGcHBHd2tmQytUL3Nr?=
 =?utf-8?B?YzUzQURIN0dMaTEvQlkwMWY4MkNId01VZkdOc3E2VGo1TEhyYmV3cGh3Uno0?=
 =?utf-8?B?WGVYN3puaFJmS0JXNXBRY0lRWDV1NnZMc0NHalBmRmQzbjZtWlFWNjJUc1hp?=
 =?utf-8?B?dkwzaUpsdzRPMENhZ3l5SEI3WnNNaERjeUtUMUdLaG44ZWJ6amd0YkJXcmtt?=
 =?utf-8?B?a3JobTJMOUtxdlVVb0M0OXZzeSs2VjhNaStySXA4RTlyZlJQNzcwRzNXd0gy?=
 =?utf-8?B?cmhqNVJGeWJJUEVIUUNHd3c4YklSTjBnUkkyR09sdHpSOHRyZ0xiYXFQaXVw?=
 =?utf-8?B?UG11WHZFSHUzOGExUk1JdDBwME1tQnJYakY5V0x3VXB0RGNmZ2tGb3Fwamc2?=
 =?utf-8?B?bUhIVWFocUpiK1V1dWRJTW04bjVkZEd3dTFUMHVySWdEU0VXcWJGMCs0RG13?=
 =?utf-8?B?VzJmc2dPcXNmRDl1NWNMN00wOGlqTDNGVFhVVUNOSjFBR0N5dnpVZFlWZDhF?=
 =?utf-8?B?UGN6VW45S2ZpdEhiMHdpOTQ0WEVTMk1aZitjQUluZ3ZUOVh4czhyckl6UEMz?=
 =?utf-8?B?aTNBWjcybG5Od0dQVXBtanY0YlQ2b0tTRncyeXR5dmFtb3EvWXNlbWlzRGhL?=
 =?utf-8?B?RXJYM2k5cjU2MVdRU3dicXA5OGNSRkROQkJhbEVoUVhXQWdmcVkvdUhwR3lw?=
 =?utf-8?B?WmpyUGJYSG53Y3ZISzlIRVhrWm5uSEM3TUg0eXN6WDlHbWM0YjN1bFBpSmRV?=
 =?utf-8?B?cXVrVWVsa2ZrcGZCaU1VdVBveXo3emRuNXVLL0o5U0gwWlhwSmphRlg4cUIr?=
 =?utf-8?B?YnBIRENCcEl0aEJPM2hVUnZTRUlKeFBXdkJrZlJ2UFdoQTY2S2JpUUdqVGpm?=
 =?utf-8?B?bHhGTktneW4vTUtmR3Fhc1dkMzhZWWVCbGhlY1RvQWNvV3pJd1hSTVBnZURT?=
 =?utf-8?B?VkdxMnFTTDF2S1J5WVBGT0VnakFvdmpZVEsyOTRoQytOZGppNVU5MmN6Z0Jx?=
 =?utf-8?Q?1FIg7iJy81icK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3c3f41-3884-4335-bcdd-08d919519fb3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:34:21.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlQNXp07yQMi5wfpA/POY9r4AwZ5C4su/wunUnXfKPfaqwTPxeeE11F+OtSLTxIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDUtMTcgMTE6NTIgYS5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+IER1cmluZyB2Y24g
c3VzcGVuZHMsIHN0b3AgcmluZyBjb250aW51ZSB0byByZWNlaXZlIG5ldyByZXF1ZXN0cywKPiBh
bmQgdHJ5IHRvIHdhaXQgZm9yIGFsbCB2Y24gam9icyB0byBmaW5pc2ggZ3JhY2VmdWxseS4KPgo+
IHYyOiBGb3JjZWQgcG93ZXJpbmcgZ2F0ZSB2Y24gaGFyZHdhcmUgYWZ0ZXIgZmV3IHdhaW50aW5n
IHJldHJ5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4K
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDIyICsr
KysrKysrKysrKysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5j
Cj4gaW5kZXggMjAxNjQ1OS4uOWYzYTZlNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMKPiBAQCAtMjc1LDkgKzI3NSwyOSBAQCBpbnQgYW1kZ3B1X3Zjbl9zdXNw
ZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+ICAgCXVuc2lnbmVkIHNpemU7
Cj4gICAJdm9pZCAqcHRyOwo+ICsJaW50IHJldHJ5X21heCA9IDY7Cj4gICAJaW50IGk7Cj4gICAK
PiAtCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4gKwlm
b3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsgKytpKSB7Cj4gKwkJaWYgKGFk
ZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQo+ICsJCQljb250aW51ZTsKPiArCQly
aW5nID0gJmFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZGVjOwo+ICsJCXJpbmctPnNjaGVkLnJlYWR5
ID0gZmFsc2U7Cj4gKwo+ICsJCWZvciAoaiA9IDA7IGogPCBhZGV2LT52Y24ubnVtX2VuY19yaW5n
czsgKytqKSB7Cj4gKwkJCXJpbmcgPSAmYWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbal07Cj4g
KwkJCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4gKwkJfQo+ICsJfQo+ICsKPiArCXdoaWxl
IChyZXRyeV9tYXgtLSAmJiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZjbi5pZGxl
X3dvcmspKQo+ICsJCW1kZWxheSg1KTsKCkkgdGhpbmsgaXQncyBwb3NzaWJsZSB0byBoYXZlIG9u
ZSBwZW5kaW5nIGpvYiB1bnByb2Nlc3NlZCB3aXRoIFZDTiB3aGVuIApzdXNwZW5kIHNlcXVlbmNl
IGdldHRpbmcgaGVyZSwgYnV0IGl0IHNob3VsZG4ndCBiZSBtb3JlIHRoYW4gb25lLCAKY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jIHByb2JhYmx5IHJldHVybiBmYWxzZSBhZnRlciB0aGUgZmlyc3Qg
dGltZSwgc28gCmNhbGxpbmcgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIG9uY2Ugc2hvdWxkIGJl
IGVub3VnaCBoZXJlLiB3ZSBwcm9iYWJseSAKbmVlZCB0byB3YWl0IGxvbmdlciBmcm9tOgoKU09D
MTVfV0FJVF9PTl9SUkVHKFZDTiwgaW5zdF9pZHgsIG1tVVZEX1BPV0VSX1NUQVRVUywgMSwKIMKg
wqDCoCDCoMKgwqAgVVZEX1BPV0VSX1NUQVRVU19fVVZEX1BPV0VSX1NUQVRVU19NQVNLKTsKCnRv
IG1ha2Ugc3VyZSB0aGUgdW5wcm9jZXNzZWQgam9iIGdldCBkb25lLgoKClJlZ2FyZHMsCgpMZW8K
Cgo+ICsJaWYgKCFyZXRyeV9tYXggJiYgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewo+ICsJCWlm
IChSUkVHMzJfU09DMTUoVkNOLCBpLCBtbVVWRF9TVEFUVVMpKSB7Cj4gKwkJCWRldl93YXJuKGFk
ZXYtPmRldiwgIkZvcmNlZCBwb3dlcmluZyBnYXRlIHZjbiBoYXJkd2FyZSEiKTsKPiArCQkJdmNu
X3YzXzBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9QR19TVEFURV9HQVRFKTsKPiAr
CQl9Cj4gKwl9Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5z
dDsgKytpKSB7Cj4gICAJCWlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiAoMSA8PCBpKSkK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
