Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C0C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172DE61179
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 23:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172DE61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B0189D8A;
	Wed, 14 Apr 2021 23:48:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C2789D8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 23:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeXEFCGL4yB83vPUJpcFRcwgYq6mHCX1/JnJ2oqyqImE+n97T1PFFIJIe9KNdBV4UTuIxETWDafQPM1nIv0GcofWVaN5G8aw0hvTWfIPn8gI9FmqAd4qkL2ke36MyTK8kpGHnWeC/cWWsupsRaxS1ppqunwCLqgeDxvSyo8FFpnaet9QTUVwxxLoxIyIHSVBRNvul/TZsPiMqca6Ev9AaaoK31RJSrB1ZG7mB21ciCWxe8Nk9ysEB66EMlx2NuU0Cu173Eh4dsukKTlQyafDhCLovj+rSbM1BojZBIY6yb+KQgD4AwuFNP4wWWa5E1S6W1c6O8Q77QElkMVRE2U7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERFhKaxr0KxzEd8mG+X4Rbiiz3Spgmtc+2slGbW5IeQ=;
 b=DXL3+1y5fOG/2Vv2QHGOlcWjEjzu8DgD/YZOe5MNVvH6eWUp+X/TWYhZE8fWAdd8E5+5s1ExLqIu7/yP99fo0sPcor5itfCUZQrw7ntaPznRCtWB5JZT9UsMXKpIMc6x0XEZ+yqtvBEtlEz1wMh6o7doUurJBOS/Fa/K/W2i57RrYZWm/i6kRKUoJ++5lG3a7CWrCZsL0MjM6Bz9pNDC7Yo+8cqs465CTY+4+KKiHUHGALPLDRDsoc23t/CkYEYP++Mb+Qa008j85DVkvEiT/R5Fs+0shQAtZXxZLCUMYyzMxWgNh5kpDkc+KJYT8CRDPm2z1E1d8xvCloldlBPydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERFhKaxr0KxzEd8mG+X4Rbiiz3Spgmtc+2slGbW5IeQ=;
 b=yU4FZAwEvFcy+MU/GGAau+IpJJhSDLj6BJovgO8lhSwX77md5hA/EEWo/JRE4HHUWMS2259+LlMeyHTKL+awehvMTXkmXFuQTqBIt+PZz4p6Mnz32MeAnMQYdTSZL5ZR2SXjyi5PCq9fa3KXG3uMX9Vta5JwvePcxu3v6VFDZwE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 23:48:04 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 14 Apr 2021
 23:48:04 +0000
Subject: Re: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped
 loading MEC2
To: amd-gfx@lists.freedesktop.org, "Clements, John" <John.Clements@amd.com>
References: <20210414233933.266833-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2ac51104-b60c-0b7f-8cb8-74f6eda71e33@amd.com>
Date: Wed, 14 Apr 2021 19:48:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210414233933.266833-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22 via Frontend Transport; Wed, 14 Apr 2021 23:48:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 178e2d17-579f-47c9-cf1b-08d8ff9fbf14
X-MS-TrafficTypeDiagnostic: MN2PR12MB3936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB393623792B90610F8E3F161F924E9@MN2PR12MB3936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPwLGXy74E3hbXaUaIKSlToRONNfVnWoC1xqY7lXFojzecj5s2/6+4VQipIa2Gfk/ZFF9B6XnRexeLqamMeI5ON3hd+uSYIrKWqT6MzW5Df+UrF+hv0I+2AU5/7u+LgoU/ldtnmTNjmiCgTfkYEGBPS3Htvlvtav6Ruw5Onben2Fh7r8wK9jd4SVckA0snvZfXSX1Y9o6wjreZyAWDmvkLNN78b+dhC+62RNTsPr68f3cScP9jd+WeX0j/084ujV1cBdhbY7XSKP8FuCTCtrnZyxowhMV2NydLXnQOOam1jWU50iBn4ze4OrVPTOWXuaLf9eLx9gVMo/Fi+heEIwTvS6OsMQa3KUeLA38D9i3GV7RdxJ67/hwlqqlcnLMMvNSwsHQDt4fqQuLpZuddY1GOgpAtRX697pbER/bWvVmIqLcKxqRCObBSl2x+jO0rIwoT/YvEi7ZFt2mjJoVIucZjjvAgaG3EirPKjZ9aT8UB038rStb7kTugzeXxZdQ1sqyU4slqOcVkEdjbHtlJnzYMUCTIcRiG3HqMHNaOgqnwnDR5l6Ie8wL6hLLEt+USOP/QvEPvzYvhjf69z2B6W2iB/0qnvAyOKNXcABJq3qLb8a5wH7cx9a5kG30B+NS395Vhyvu3VetjYNCGRPLkAMkAd9H95/wqfyo1UsPVMXkQulNnbN5kLW/vSFhNAVgk/0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(16526019)(2616005)(38100700002)(26005)(66946007)(478600001)(66476007)(66556008)(186003)(31696002)(956004)(36756003)(31686004)(8936002)(6636002)(316002)(6862004)(5660300002)(37006003)(16576012)(86362001)(2906002)(8676002)(6486002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VmVCTENwUHAzM1hPQ3I0eG1vSGphL211YzlFbVoyOFo2aHNoWEwyRFZnRmtI?=
 =?utf-8?B?V0p6SHRNcnpKRi9UMlowV0poa29xY3N6bVp3L3N3OTcvd2M4NmNxOG9CSU1D?=
 =?utf-8?B?REFOdHNadngzVCtBR0pheWU0WEpJREY1dFhGTTJJTElDMWlBV3FEdHVKZ01F?=
 =?utf-8?B?Z3R4K0ZyTncyTzRKbFlIbDhQMFlGeHkwTC9EL2FTSFl4NG5ndTByZFA2YTFF?=
 =?utf-8?B?UHhRY0VkMnpXYlJMaVkxelVlYTF0TFFXNGk2enZDK2p5T2t6VzhGTFlzVXFt?=
 =?utf-8?B?V2ZjbU9tNHNUb1BkMlJhbXpTK3VvZlZQcm9wR0l6WFA3UHY5NXgzUXp0YUZi?=
 =?utf-8?B?ZGVvcE1kMkFmVW5yTVdQb2lTa1dtR2hrZmNHS0tGWWExS0JKQWJBVkVDaXRu?=
 =?utf-8?B?TmxJS2lZZEdTam1PUSt0V0Q0NVZOTXJyTUVHVE1rNmJrQWI4MDludG0zVmNN?=
 =?utf-8?B?SCtndkgyL2l6MGFmZWt6TEwvck5OSDV2L09aeUo0MHMxMnJabkFzbkM0WGFw?=
 =?utf-8?B?VTlhN1J2ZG5CbnlMMEl1SFJwNlFsV0ZkUThMSG1xQWY4MHkwdzcwMzdGSmRW?=
 =?utf-8?B?N1BVUzc0NElHNXlncnhKZEhGUXdhUmo1eHpxdmdGRXk2dEJhNS9JUTFvemdh?=
 =?utf-8?B?V2NWV1RnNzNjRDJMSEc5Y2RaaDdtd2dQM1R1YnN0Mmx6aGpqdG41MG1mTjFr?=
 =?utf-8?B?ZVdPUzdSdUlDOXEyK1FlNnU1K1NpVGx1SnBmSDBhSElsRmJMVTg1YStTa2NZ?=
 =?utf-8?B?Vis2dEFJelRXV1NHSlFaWGZ6SjgzOHFrVHl5cjR2UnNNOU4xY1A5MWJURlRY?=
 =?utf-8?B?dDlkUDhWWGFHSXVKcDJlbFdFZmVmVSswV2ovaDZMVytPZHZVdzlwOC9xYzhy?=
 =?utf-8?B?cHpDcytEa1NDcUl4NFpOUDZEYyt0L09lczFYbjY1RzY0QUJEZmhiRnBiL29W?=
 =?utf-8?B?NytQQnEvZnpKRTlXR0d6TFlvOE5IOUVVaExJbWFMNlJEejVtZFByRE5oUXBx?=
 =?utf-8?B?TktvVC9tYUF2bXZIK3hpbkN0dHdhZ1BNQW9Vanc5YlQ4d1hoU1lhNjQxNnVK?=
 =?utf-8?B?emxIR1Y1SUpZQ3U0cGFOd0hCNUcxaFY4SktnZkVyN2ZUbE5FNWJmVDRubG8y?=
 =?utf-8?B?SkJleUROWEwzMTEyb25NdHpla1o3YzNWSEVwSzg5aE1MRU9OQmt3TUs0M1ZV?=
 =?utf-8?B?OUFBUWFWNWpMUUNjZDgrMmQvRmNlMFZ1azJDTmRaT1N1dnBRNExYUkt1WUNR?=
 =?utf-8?B?YUZwOHRrbTBac1N4T2R3SUJkaStVRVFDOEI4a2xyVEQ1cEtZTlZPeFhrY0dK?=
 =?utf-8?B?NVhhQXY4S3ZKN1hCMEpXZWJCREJKL1pKRnZzMm80SWgrUWtxNlNhUTVQOU1r?=
 =?utf-8?B?VVNYUlh1NkdXSjNtbThwR1diT1FZYnRIY2FDanh0Zzk3WU9sQ2IxMHJMN0pp?=
 =?utf-8?B?UFZicnJuQTBhWG1TZ3M1bWFVb2JiTHRBM1pFZVUvTDh6Mmxva0kwRmZyTDdH?=
 =?utf-8?B?VEJ3bDMxc1NseDl4dEpiTHV2MnI2NFQyNzROQS91eFlqTjV6Z2VXNVV2MHFF?=
 =?utf-8?B?UDUvZ3p0alltNEZPdlRXV2ZZWkF2dVlKVlJtR0M3NitoUzloeTByTkhWbXRR?=
 =?utf-8?B?MG13cDRPa29iUGR2RTVCcjR3SmRrUEJraW5WWUhlcllHckk0dmlyMlczZWZG?=
 =?utf-8?B?QnBZM1hYcFdTbmZCK05rT0g1c1lpT1g3TjVaZGZoQ2F5NkxpYkFIVkVrNXNG?=
 =?utf-8?B?ZS8vUUNTL2V2dW4yaDhBa090TnZvR1FmN2pIS2dxVkIrdUNEanMwNGhVS05X?=
 =?utf-8?B?b29TTm9qU0cybVRmVk9GUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178e2d17-579f-47c9-cf1b-08d8ff9fbf14
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 23:48:04.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJTnVXeUMF0MmMzQgyfCvKzzVVOb6r7chuvki8DHr6kjETXlH+0uzbJrki5VlVNvVzRSUD2z5q75XRwYkeUpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
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

QW0gMjAyMS0wNC0xNCB1bSA3OjM5IHAubS4gc2NocmllYiBKb3NlcGggR3JlYXRob3VzZToKPiBJ
ZiB3ZSBza2lwcGVkIGxvYWRpbmcgTUVDMiBmaXJtd2FyZSBzZXBhcmF0ZWx5IGZyb20gTUVDLCB0
aGVuCj4gTUVDMiB3aWxsIGJlIHJ1bm5pbmcgdGhlIHNhbWUgZmlybXdhcmUgaW1hZ2UuIENvcHkg
dGhlIE1FQyB2ZXJzaW9uCj4gYW5kIGZlYXR1cmUgbnVtYmVycyBpbnRvIE1FQzIgdmVyc2lvbiBh
bmQgZmVhdHVyZSBudW1iZXJzLiBUaGlzCj4gaXMgbmVlZGVkIGZvciB0aGluZ3MgbGlrZSBHV1Mg
c3VwcG9ydCwgd2hlcmUgd2UgcmVseSBvbiBrbm93aW5nCj4gd2hhdCB2ZXJzaW9uIG9mIGZpcm13
YXJlIGlzIHJ1bm5pbmcgb24gTUVDMi4gTGVhdmluZyB0aGVzZSBNRUMyCj4gZW50cmllcyBibGFu
ayBicmVha3Mgb3VyIGFiaWxpdHkgdG8gdmVyc2lvbi1jaGVjayBlbmFibGVzIGFuZAo+IHdvcmth
cm91bmRzLgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIEdyZWF0aG91c2UgPEpvc2VwaC5HcmVh
dGhvdXNlQGFtZC5jb20+Cj4gQ2hhbmdlLUlkOiBJZDZmNjcyZmM2OTQ1MmFiZDZmZjQxODIxYTVm
MjI0MDAzNzA0OGE2ZgoKVGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIEknZCB3YWl0IGZvciBK
b2huIHRvIGFwcHJvdmUgaXQgYXMgd2VsbC4KClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCkpvaG4sIGlmIHRoZSBwYXRjaCBsb29rcyBnb29kIHRv
IHlvdSwgcGxlYXNlIGZlZWwgZnJlZSB0byBhcHBseSBpdCB0bwphbWQtc3RhZ2luZy1kcm0tbmV4
dCBpbiB5b3VyIHRpbWUgem9uZS4gV2UncmUgaW4gYSBodXJyeSBiZWNhdXNlIHRoaXMKZml4IGlz
IG5lZWRlZCBpbiB0aGUgbmV4dCBST0NtIHJlbGVhc2UuIElmIHlvdSBiZWxpZXZlIHJlcG9ydGlu
ZyBhIGZha2UKTUVDMiB2ZXJzaW9uIHdvdWxkIGNhdXNlIHByb2JsZW1zIGZvciBncmFwaGljcywg
YW4gYWx0ZXJuYXRpdmUgZml4IHdvdWxkCmJlIHRvIGNoYW5nZSBrZmRfZ3dzX2luaXQgdG8gY2hl
Y2sgdGhlIG1lY19md192ZXJzaW9uIG9uIEFyY3R1cnVzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMyArKysKPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jCj4gaW5kZXggMDY4MTFhMWY0NjI1Li5hMDc4YTM4YzJjZWUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBAQCAtMTU4Nyw2ICsxNTg3LDkgQEAg
c3RhdGljIGludCBnZnhfdjlfMF9pbml0X2NwX2NvbXB1dGVfbWljcm9jb2RlKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAJCQllcnIgPSAwOwo+ICAJCQlhZGV2LT5nZngubWVjMl9mdyA9
IE5VTEw7Cj4gIAkJfQo+ICsJfSBlbHNlIHsKPiArCQlhZGV2LT5nZngubWVjMl9md192ZXJzaW9u
ID0gYWRldi0+Z2Z4Lm1lY19md192ZXJzaW9uOwo+ICsJCWFkZXYtPmdmeC5tZWMyX2ZlYXR1cmVf
dmVyc2lvbiA9IGFkZXYtPmdmeC5tZWNfZmVhdHVyZV92ZXJzaW9uOwo+ICAJfQo+ICAKPiAgCWlm
IChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSB7Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
