Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECCCC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7362610C8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7362610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755276EC8A;
	Thu,  6 May 2021 00:48:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2796EC8A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 00:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHvMkhzK1r1ApOcYaEfnFdLbVLtZwTYFwrRMt9g9fJdqbQMdNJxSnd3auYHqnBg2V89g2itKkkWIC+KDd0LReQPHTfSeMiLtOKdyi06unRrvzgzuZdqDaxXwn/WjhBINgpEnlI7+CUkSQAwbOH/EfBCtQPqWfiUzdupvqkn9L0DwAOQWM3hC2Qpk15XS4Cl5pRDu7edm36r1+NXUlrcgrmE2kWIsA0dHAOM2bRthssv1ZwoQzFw4F9E4fBc6wTVYtOW4cqHIBBrRWi6/uomjL5SBpapeOku2JoGUZKRl+9NhGLIkyr6MtfexBeEcHzu3MUTXt6bEh9VVukLasV2cPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPxajS7YciWg//Uc5m2F2F0djgppR/b4LzmzKyS92rw=;
 b=G5hN4lxF6fP7CCavOxGOBXIU2r4v7+70RwkqIZzwefKdyFj9K7T8jdKsL5H+7kjDMirts/dF4nB78qpve8JXGJunlVwLM0a5mPOG/5vDb0fI/NacY4dW8C7nsiatrR1eXL5ZN5p0EfDHueyxlR0BFx7dmT13LNM3kxGgiJ5vSVDGg7bvyYYNO5JQVPstL0NCv6yuMXTRjeKSwFVeG5FRwPU32O9i8xAWpkhIyjlbxP55EQUl99wT+TfRiA15h2TVltadsyaNuAvKHya09UQ1fXOQY8fmIWvpGaxjqGWbAqWvBaO0NB6qTRE+cCw/gXgDMGB5BYY299E2jd4l+IJp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPxajS7YciWg//Uc5m2F2F0djgppR/b4LzmzKyS92rw=;
 b=ZfWD3IOyppyJawvSYBbSx73gwyvrX7m9Nf9OdNmpg86IRVm66BsHdTmY3BlcPRNXUmpWvtgjnWper4RVitpgX2Os+WfIDaX0HzOVESw0xkXnAItb+t/QlxcqJuxI7DqM8UOYrHlqAMU2DS6DEMSe5s2Vn4YAO4iioW72BK7UhwU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 6 May
 2021 00:48:49 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Thu, 6 May 2021
 00:48:49 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: classify and map mixed svm range pages in
 GPU
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505225944.4425-1-alex.sierra@amd.com>
 <20210505225944.4425-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <125fb9e7-a47a-468a-9895-634d81a14f3c@amd.com>
Date: Wed, 5 May 2021 20:48:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210505225944.4425-3-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::25)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.37 via Frontend Transport; Thu, 6 May 2021 00:48:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40d5ad6-903a-4c28-beb4-08d91028b66b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53224E0C18DBA98F473ED04792589@BN9PR12MB5322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9Q8ffdmS2FfP5ilLR6icA69080rus16u2DUGI8lRCUHYySO3ZMZB419RayWX8mmhHuTMaXZ0cGfll6Fs7YytfeESFptKckhm46hQyFNu7DJ7AO9qbOB+hmWOpi5DV99FYJsNOiwYaGclrJXBg0C+VMQ/q5ATjL6Gg3TVWNperKtz3zjwdJAqFt7h0L8huZffr4ezCS02+E1/JbVY33kMtqnXRI1UNNhTo4oEhved6VcjmlBaIl0D6129GGoSXTbM8h2MYo/PGJKgiZdz7UuLBeQ9u0sihsqUvg5eYU5SAuZR+D9Gm9CJxidtrFymI1tIcxB5SoWDrY5w3TsH8JJLMUULw/Wk6amXTQ2I1ynCwuDmmPSSs/Y4P/NFNmnkE8G1i3d+jDKmwFokXqmGUSZEkfnil6FXuYG4XSEiE4YLLM1YVsU623Z50waMFtuPvaO7ZsLjd6oI3CK/rogZcWXdNv6N6KJpoAjjU+H+PR/XclZzoQSuN+FKK7cCA55e1ohyOa43Rblz0ltBkMzL9glJxuFlUDfhOafHpETPSB87f4x3O2H1m+PlYaEyhmq/r4XvZ9Jkuu6jYG83sERVSvj7QCNS2r7F4KSNr6Yw+mWvUlltKSyTjgoRNCorflMmmJdRg5XjdDOqmWJQyu0U8mP+ODd1t5MogDRfRC2BF8ws3e9p9K1MxCuNGPkSPpvNiYC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(956004)(316002)(36756003)(44832011)(5660300002)(478600001)(186003)(83380400001)(31686004)(8936002)(6486002)(2616005)(16576012)(26005)(31696002)(66476007)(66556008)(8676002)(66946007)(38100700002)(2906002)(86362001)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MjVhYTUxbDIwRDljMnJWSmZZd2Iwb1FSTzNPWlE4a2o5bGVKRHRqeWNnU2RI?=
 =?utf-8?B?bVB4TWduYm95TUFtVGVhWEJuRkpXVFZjSGxYV1VUeEx5M1pqayszOTFuWDEz?=
 =?utf-8?B?LzFCdnM4LzJzWm03WUdRbkUxRGpPNUtTeWRlZlZSNUJHZGJwRCtqRTZrazdi?=
 =?utf-8?B?VDdxSUhTNSs0M0ZrSlV4THVFWS9xVzBsaE5OdU1hbUdkNS94WTBkc3VlKy94?=
 =?utf-8?B?aWY4Z0ZYdFIwT1RyWnZhekNnQWNUbGVLcVRCbmpVQ2d3OStEN2UxZFVSbkRL?=
 =?utf-8?B?MFJaR3N4ZTNHNFUvOVBvcW9HVENuOXRqTUZxb0l6TWJsSWJ3ZURWc0tZeVlY?=
 =?utf-8?B?UzNwZnplQVp0MTRBTERaWHZjUy8vZSsvVnB1djg4RFdsS1R2QXRDNnkwVDFn?=
 =?utf-8?B?S1VmRXI1OFVYTnRkaFNzRU0xNGE3V2NBc0w3eE5iL3dQSWVDUktkWTNWT1Ew?=
 =?utf-8?B?NzczQ0hJQ2lSV2MxNStSTUJ1c3N5dmJ2dkl2aGpSaUtqZGh5YlVvOWx4R2p0?=
 =?utf-8?B?TzlRZnZldmtUQlNncUtnNDZSSzhlNFpXV0JvU2tqbFBBMDBzUGFOUHhSdXFS?=
 =?utf-8?B?ZWhoV2V3dEtqdE0za3V1elBET0E5VnBLOTZtWFZ3T1h2S1FlSXV3ODc1MG96?=
 =?utf-8?B?b0Z6SWNjdEJxcE04L2hybEJoRERuMmxTSXlZR29oOEZXT1I0QnN0bURnNFlW?=
 =?utf-8?B?TEdPU1diYmcydXhQN2gzWW5wR1NHT2QraTM5eDVwZHIyWW40akRIUEN3RmpO?=
 =?utf-8?B?NllTemcrZE9uUHp3STJhcVZNVi9mV3JOSmxsV3J1RnJKMzFRcllDeU9OTmZY?=
 =?utf-8?B?ZlRGMWtPUE1LOWhBcnFlMVR0Wm5CdGxSSXA3aVRTcjdWbWc0WWowWHptVnBR?=
 =?utf-8?B?cHlFdk40Vkp4c3lUWEFLY29oeTFkYUVmdmNBOTRYUnpYZTVGNCtuWFhVYXRR?=
 =?utf-8?B?YmMwYUhvaUVNK2gzc0JybTRQN0FzajlEL1lIei8wRWNvVVFnQXMwUTAveFh1?=
 =?utf-8?B?aW1uUWNMbEgxUWdnY2lIVEhrRnVPWGtzUGs5RHFqRTR1ckJmU0V1OExGZzh0?=
 =?utf-8?B?QTRHUmVSaUdJdTFxSE1WMHp2SHZwRzRUQmpFRk5kQkJIQzZDTkxDZTMraHNL?=
 =?utf-8?B?WUZiWWl6SDI4dmxEZnQ5STZrMjJweHA4OWNYcEx3Q0tGQzdTOXl3aks3dlFP?=
 =?utf-8?B?S2oxRkYvaFUraUJyL1MweTBkblh5TjRFalVjNmtDRUkxa29JSi9yRGpzb2Ro?=
 =?utf-8?B?MHlyZ21ZY0svSTUxbDBTdXNsb1BabnNUSFB4VjFvR2RjNU9SeFJOS000aDJ0?=
 =?utf-8?B?WktNZFh5QU9pQnljeXkycG9Jc2pFZ2VxT1JjMG10bVBjVUpGdFhsTG1qQnkr?=
 =?utf-8?B?QnJucUszVnJWM0pRQ2ppUXA4SG4vTlorczJrVkpnZ1VUekUzR09qYkl0dERX?=
 =?utf-8?B?aGU1YUg4ellSd1E4elpwTk14YTJUNWlqWlFkb1M3SVpoYktaUlk5UVNrbHA5?=
 =?utf-8?B?RW8yRE5ZMjIycDc0am5UblAyanJLQlBpQmxzYXZBQkozM3ZrbGYxZnhRbitS?=
 =?utf-8?B?VmpNWmdhRklSc0hXNHV2eTNoNjNYakZ5NnNEUllLVTk2a2VEMlVMRWxnMHE1?=
 =?utf-8?B?ZnhRbm1vaEZGS3Fsd1ZoZTFBTlJnSmJlam1FYVFYQzdnek9hSzBTdUVLVENj?=
 =?utf-8?B?T3pJOS9ZajJJc1B5UVdNTEhTMUFvNEhxNENBOFhGT1hxeTZHaGFaZkFCclBZ?=
 =?utf-8?B?QUxVaXJQeE9HZmcwQWJuVWlybDhaSFFIVUhDYjJuc0gwR1FXSmVyYkJDSlBD?=
 =?utf-8?B?ME1sR1lLMDZRNVVDSlM4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40d5ad6-903a-4c28-beb4-08d91028b66b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:48:49.5792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viZgY8m7NEEJdko7yY/N1vto4MSmZ076bMzzC+Tn+HpKc7QahivWZ4uu+R3YD8bLTVPgY5V0ptb2Gc9zxRjjng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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

CkFtIDIwMjEtMDUtMDUgdW0gNjo1OSBwLm0uIHNjaHJpZWIgQWxleCBTaWVycmE6Cj4gW1doeV0K
PiBzdm0gcmFuZ2VzIGNhbiBoYXZlIG1peGVkIHBhZ2VzIGZyb20gZGV2aWNlIG9yIHN5c3RlbSBt
ZW1vcnkuCj4gQSBnb29kIGV4YW1wbGUgaXMsIGFmdGVyIGEgcHJhbmdlIGhhcyBiZWVuIGFsbG9j
YXRlZCBpbiBWUkFNIGFuZCBhCj4gY29weS1vbi13cml0ZSBpcyB0cmlnZ2VyZWQgYnkgYSBmb3Jr
LiBUaGlzIGludmFsaWRhdGVzIHNvbWUgcGFnZXMKPiBpbnNpZGUgdGhlIHByYW5nZS4gRW5kZGlu
ZyB1cCBpbiBtaXhlZCBwYWdlcy4KPgo+IFtIb3ddCj4gQnkgY2xhc3NpZnlpbmcgZWFjaCBwYWdl
IGluc2lkZSBhIHByYW5nZSwgYmFzZWQgb24gaXRzIHR5cGUuIERldmljZSBvcgo+IHN5c3RlbSBt
ZW1vcnksIGR1cmluZyBkbWEgbWFwcGluZyBjYWxsLiBJZiBwYWdlIGNvcnJlc3BvbmRzCj4gdG8g
VlJBTSBkb21haW4sIGEgZmxhZyBpcyBzZXQgdG8gaXRzIGRtYV9hZGRyIGVudHJ5IGZvciBlYWNo
IEdQVS4KPiBUaGVuLCBhdCB0aGUgR1BVIHBhZ2UgdGFibGUgbWFwcGluZy4gQWxsIGdyb3VwIG9m
IGNvbnRpZ3VvdXMgcGFnZXMgd2l0aGluCj4gdGhlIHNhbWUgdHlwZSBhcmUgbWFwcGVkIHdpdGgg
dGhlaXIgcHJvcGVyIHB0ZSBmbGFncy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxh
bGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMgfCA1OCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaCB8ICAyICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMKPiBpbmRleCA3MTA0NzYyYTAxMTkuLjk0ZmU5YWI3MGU5NCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBAQCAtMTQxLDYgKzE0MSwxMiBAQCBzdm1fcmFu
Z2VfZG1hX21hcF9kZXYoc3RydWN0IGRldmljZSAqZGV2LCBkbWFfYWRkcl90ICoqZG1hX2FkZHIs
Cj4gIAkJCWRtYV91bm1hcF9wYWdlKGRldiwgYWRkcltpXSwgUEFHRV9TSVpFLCBkaXIpOwo+ICAK
PiAgCQlwYWdlID0gaG1tX3Bmbl90b19wYWdlKGhtbV9wZm5zW2ldKTsKPiArCQlpZiAoaXNfem9u
ZV9kZXZpY2VfcGFnZShwYWdlKSkgewo+ICsJCQlhZGRyW2ldID0gaG1tX3BmbnNbaV0gPDwgUEFH
RV9TSElGVDsKClRoaXMgaXMgbm90IHRoZSByZWFsIHBoeXNpY2FsIGFkZHJlc3MuIEl0J3MgYSBm
YWtlIGFkZHJlc3MgZnJvbQpkZXZtX3JlcXVlc3RfZnJlZV9tZW1fcmVnaW9uLiBZb3UgbmVlZCB0
byB0cmFuc2xhdGUgdGhhdCB0byBhbiBhY3R1YWwKcGh5c2ljYWwgYWRkcmVzcyBieSBzdWJ0cmFj
dGluZyBwZ21hcC0+cmFuZ2Uuc3RhcnQgYW5kIGFkZGluZwphZGV2LT52bV9tYW5hZ2VyLnZyYW1f
YmFzZV9vZmZzZXQuCgpSaWdodCBub3cgaXQgbG9va3MgbGlrZSB5b3UgZG9uJ3QgdXNlIHRoaXMg
YWRkcmVzcyBmb3IgVlJBTSBhdCBhbGwuIFlvdQpjYWxjdWxhdGUgdGhlIGFkZHJlc3MgZnJvbSB0
aGUgdHRtX3JlcyBpbiB0aGUgc3ZtX3JhbmdlLiBUaGlzIHdvcmtzIE9LCmFzIGxvbmcgYXMgd2Ug
ZG8gdGhlIFZSQU0gYWxsb2NhdGlvbiBwZXIgU1ZNIHJhbmdlLiBFdmVudHVhbGx5IGl0IG1heSBi
ZQp1c2VmdWwgdG8gY2FsY3VsYXRlIHRoZSBjb3JyZWN0IGFkZHJlc3MgaGVyZSBmcm9tIHRoZSBQ
Rk4uIFRoZW4gd2UgY2FuCmJlIG1vcmUgZmxleGlibGUgaW4gdGhlIFZSQU0gbWFuYWdlbWVudCBh
bmQgbWF5IG5vdCBuZWVkIGEgcmVmZXJlbmNlIHRvCnRoZSBCTyBpbiB0aGUgc3ZtX3JhbmdlIGF0
IGFsbCBhbnkgbW9yZS4KCgo+ICsJCQlhZGRyW2ldIHw9IFNWTV9SQU5HRV9WUkFNX0RPTUFJTjsK
PiArCQkJcHJfZGVidWcoInZyYW0gYWRkcmVzcyBkZXRlY3RlZDogMHglbGx4XG4iLCBhZGRyW2ld
ID4+IFBBR0VfU0hJRlQpOwo+ICsJCQljb250aW51ZTsKPiArCQl9Cj4gIAkJYWRkcltpXSA9IGRt
YV9tYXBfcGFnZShkZXYsIHBhZ2UsIDAsIFBBR0VfU0laRSwgZGlyKTsKPiAgCQlyID0gZG1hX21h
cHBpbmdfZXJyb3IoZGV2LCBhZGRyW2ldKTsKPiAgCQlpZiAocikgewo+IEBAIC0xMTMxLDMzICsx
MTM3LDQ5IEBAIHN2bV9yYW5nZV9tYXBfdG9fZ3B1KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgCQkgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICpi
b19hZGV2LCBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UpCj4gIHsKPiAgCXN0cnVjdCBhbWRncHVf
Ym9fdmEgYm9fdmE7Cj4gKwlzdHJ1Y3QgdHRtX3Jlc291cmNlICp0dG1fcmVzOwo+ICAJdWludDY0
X3QgcHRlX2ZsYWdzOwo+ICsJdW5zaWduZWQgbG9uZyBsYXN0X3N0YXJ0Owo+ICsJaW50IGxhc3Rf
ZG9tYWluOwo+ICAJaW50IHIgPSAwOwo+ICsJaW50NjRfdCBpLCBqOwo+ICAKPiAgCXByX2RlYnVn
KCJzdm1zIDB4JXAgWzB4JWx4IDB4JWx4XVxuIiwgcHJhbmdlLT5zdm1zLCBwcmFuZ2UtPnN0YXJ0
LAo+ICAJCSBwcmFuZ2UtPmxhc3QpOwo+ICAKPiAtCWlmIChwcmFuZ2UtPnN2bV9ibyAmJiBwcmFu
Z2UtPnR0bV9yZXMpIHsKPiArCWlmIChwcmFuZ2UtPnN2bV9ibyAmJiBwcmFuZ2UtPnR0bV9yZXMp
Cj4gIAkJYm9fdmEuaXNfeGdtaSA9IGFtZGdwdV94Z21pX3NhbWVfaGl2ZShhZGV2LCBib19hZGV2
KTsKPiAtCQlwcmFuZ2UtPm1hcHBpbmcuYm9fdmEgPSAmYm9fdmE7Cj4gLQl9Cj4gLQo+IC0JcHJh
bmdlLT5tYXBwaW5nLnN0YXJ0ID0gcHJhbmdlLT5zdGFydDsKPiAtCXByYW5nZS0+bWFwcGluZy5s
YXN0ID0gcHJhbmdlLT5sYXN0Owo+IC0JcHJhbmdlLT5tYXBwaW5nLm9mZnNldCA9IHByYW5nZS0+
b2Zmc2V0Owo+IC0JcHRlX2ZsYWdzID0gc3ZtX3JhbmdlX2dldF9wdGVfZmxhZ3MoYWRldiwgcHJh
bmdlKTsKPiAgCj4gLQlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYsIGJvX2Fk
ZXYsIHZtLCBmYWxzZSwgZmFsc2UsIE5VTEwsCj4gLQkJCQkJcHJhbmdlLT5tYXBwaW5nLnN0YXJ0
LAo+IC0JCQkJCXByYW5nZS0+bWFwcGluZy5sYXN0LCBwdGVfZmxhZ3MsCj4gLQkJCQkJcHJhbmdl
LT5tYXBwaW5nLm9mZnNldCwKPiAtCQkJCQlwcmFuZ2UtPnR0bV9yZXMgPwo+IC0JCQkJCQlwcmFu
Z2UtPnR0bV9yZXMtPm1tX25vZGUgOiBOVUxMLAo+IC0JCQkJCWRtYV9hZGRyLCAmdm0tPmxhc3Rf
dXBkYXRlKTsKPiAtCWlmIChyKSB7Cj4gLQkJcHJfZGVidWcoImZhaWxlZCAlZCB0byBtYXAgdG8g
Z3B1IDB4JWx4XG4iLCByLCBwcmFuZ2UtPnN0YXJ0KTsKPiAtCQlnb3RvIG91dDsKPiArCXR0bV9y
ZXMgPSBwcmFuZ2UtPnR0bV9yZXM7CgpUaGlzIGlzIG5vdCBuZWVkZWQgaGVyZS4gU2VlIGJlbG93
LgoKCj4gKwlsYXN0X3N0YXJ0ID0gcHJhbmdlLT5zdGFydDsKPiArCWZvciAoaSA9IGogPSAwOyBp
IDwgcHJhbmdlLT5ucGFnZXM7IGkrKykgewo+ICsJCWxhc3RfZG9tYWluID0gZG1hX2FkZHJbaV0g
JiBTVk1fUkFOR0VfVlJBTV9ET01BSU47Cj4gKwkJaWYgKChsYXN0X3N0YXJ0ICsgaikgPCBwcmFu
Z2UtPmxhc3QgJiYKCkkgdGhpbmsgdGhpcyBzaG91bGQgYmUgdHJ1ZTogcHJhbmdlLT5zdGFydCAr
IGkgPT0gbGFzdF9zdGFydCArIGouIFNvIHlvdQpkb24ndCBuZWVkIGouCgoKPiArCQkgICAgbGFz
dF9kb21haW4gPT0gKGRtYV9hZGRyW2kgKyAxXSAmIFNWTV9SQU5HRV9WUkFNX0RPTUFJTikpIHsK
PiArCQkJaisrOwo+ICsJCQljb250aW51ZTsKPiArCQl9Cj4gKwkJcHJfZGVidWcoIk1hcHBpbmcg
cmFuZ2UgWzB4JWx4IDB4JWxseF0gb24gZG9tYWluOiAlc1xuIiwKPiArCQkJIGxhc3Rfc3RhcnQs
IGxhc3Rfc3RhcnQgKyBqLCBsYXN0X2RvbWFpbiA/ICJHUFUiIDogIkNQVSIpOwo+ICsJCXByYW5n
ZS0+dHRtX3JlcyA9IGxhc3RfZG9tYWluID8gdHRtX3JlcyA6IE5VTEw7CgpZb3UncmUgdXNpbmcg
cHJhbmdlLT50dG1fcmVzIGFzIGEgdGVtcG9yYXJ5IHZhcmlhYmxlLiBVc2UgdGhlIGxvY2FsCnZh
cmlhYmxlIHR0bV9yZXMgYXMgeW91ciB0ZW1wb3JhcnkuIFRoZW4gdGhpcyBiZWNvbWVzOgoKwqDC
oMKgIHR0bV9yZXMgPSBsYXN0X2RvbWFpbiA/IHByYW5nZS0+dHRtX3JlcyA6IE5VTEw7CgpUaGVu
IHVzZSB0dG1fcmVzIGluc3RlYWQgb2YgcHJhbmdlLT50dG1fcmVzIGJlbG93LgoKCj4gKwkJcHRl
X2ZsYWdzID0gc3ZtX3JhbmdlX2dldF9wdGVfZmxhZ3MoYWRldiwgcHJhbmdlKTsKPiArCQlyID0g
YW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYsIGJvX2FkZXYsIHZtLCBmYWxzZSwgZmFs
c2UsIE5VTEwsCj4gKwkJCQkJCWxhc3Rfc3RhcnQsCj4gKwkJCQkJCWxhc3Rfc3RhcnQgKyBqLCBw
dGVfZmxhZ3MsCgpUaGlzIGNvdWxkIGFsc28gdXNlIHByYW5nZS0+c3RhcnQgKyBpLgoKCj4gKwkJ
CQkJCSgobGFzdF9zdGFydCAtIHByYW5nZS0+c3RhcnQpIDw8IFBBR0VfU0hJRlQpLAoKSSB0aGlu
ayB5b3Ugc3RpbGwgbmVlZCB0byBhZGQgcHJhbmdlLT5vZmZzZXQgaGVyZS4gT3RoZXJ3aXNlIHlv
dSBicmVhawp0aGUgY2FzZSB3aGVyZSBvbmUgQk8gaXMgc2hhcmVkIGJ5IHNldmVyYWwgcmFuZ2Vz
LgoKCj4gKwkJCQkJCXByYW5nZS0+dHRtX3JlcyA/Cj4gKwkJCQkJCQlwcmFuZ2UtPnR0bV9yZXMt
Pm1tX25vZGUgOiBOVUxMLAoKVGhpcyBsb29rcyBsaWtlIHlvdSBuZWVkIHRvIHJlYmFzZSBvbiBD
aHJpc3RpYW4ncyBsYXRlc3QgY2hhbmdlcy4KYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nIG5v
dyB0YWtlcyBhIHR0bV9yZXMgcGFyYW1ldGVyLgoKCj4gKwkJCQkJCXByYW5nZS0+dHRtX3JlcyA/
IE5VTEwgOgo+ICsJCQkJCQlkbWFfYWRkciwKClRoaXMgbGluZS1icmVhayBpcyByZWFsbHkgamFy
cmluZy4gUHV0IGRtYV9hZGRyIG9uIHRoZSBzYW1lIGxpbmUgYXMgdGhlCnJlc3Qgb2YgdGhlIHRl
cm5hcnkgZXhwcmVzc2lvbi4KCgo+ICsJCQkJCQkmdm0tPmxhc3RfdXBkYXRlKTsKPiArCQlpZiAo
cikgewo+ICsJCQlwcl9kZWJ1ZygiZmFpbGVkICVkIHRvIG1hcCB0byBncHUgMHglbHhcbiIsIHIs
IHByYW5nZS0+c3RhcnQpOwo+ICsJCQlnb3RvIG91dDsKPiArCQl9Cj4gKwkJbGFzdF9zdGFydCAr
PSBqICsgMTsKCmxhc3Rfc3RhcnQgPSBwcmFuZ2UtPnN0YXJ0ICsgaSArIDE7CgoKPiArCQlqID0g
MDsKPiAgCX0KPiArCXByYW5nZS0+dHRtX3JlcyA9IHR0bV9yZXM7CgpSZW1vdmUgdGhpcy4gU2Vl
IG15IGNvbW1lbnQgYWJvdXQgbWFraW5nIHR0bV9yZXMgdGhlIHRlbXBvcmFyeSB2YXJpYWJsZS4K
V2Ugc2hvdWxkIG5vdCBtaXN1c2Ugb3VyIGRhdGEgc3RydWN0dXJlcyBmb3IgdGVtcG9yYXJ5IHZh
cmlhYmxlcy4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiAgCj4gIAlyID0gYW1kZ3B1X3ZtX3VwZGF0
ZV9wZGVzKGFkZXYsIHZtLCBmYWxzZSk7Cj4gIAlpZiAocikgewo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfc3ZtLmgKPiBpbmRleCA1NzNmOTg0YjgxZmUuLmJiODUyODhjZDY1OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmgKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmgKPiBAQCAtMzUsNiArMzUsOCBAQAo+ICAj
aW5jbHVkZSAiYW1kZ3B1LmgiCj4gICNpbmNsdWRlICJrZmRfcHJpdi5oIgo+ICAKPiArI2RlZmlu
ZSBTVk1fUkFOR0VfVlJBTV9ET01BSU4gKDFVTCA8PCAwKQo+ICsKPiAgc3RydWN0IHN2bV9yYW5n
ZV9ibyB7Cj4gIAlzdHJ1Y3QgYW1kZ3B1X2JvCQkqYm87Cj4gIAlzdHJ1Y3Qga3JlZgkJCWtyZWY7
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
