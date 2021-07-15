Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F3C1B08C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2D9613BA
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2D9613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7086A6E7DC;
	Thu, 15 Jul 2021 09:31:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784A06E7DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 09:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkNI1Ymw+VyuC6YJXFatRL/Sfa3armTfhdJSB+xs7+HQCxl6jy1rspZDly9imba+7u939mq8ekMe7h4DWgP45EwBeAHN50z/H+tGa50qOjZhsiWYHb5goD8z2vj1ULPlcpTZ8CtnRC8ScH9Icv7IAoEPX95IPC+NpNY5GjUU8DT1Iw7omCIyDFWco3mHo0E5oSE0BFQ9+UsQ9FmvGfAUZDuG618GSfiTihsTH4roV4EGNxKPwZvWzUd9MEHxw6fTFEcE3/JX8ujyx/8eIUc8E/ROMVVe4xsfwGKuh5vSaHHoOhfKBwDqevaojWYZxjQqn1TU8DklEZyBBdPOC05qUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwfY96ARowsywVxv7v8mdYbu4RZxEyieGBKo1ssrv28=;
 b=D1KC+jBNZBrJyEhM3FK4txJKiXiPTFI7HQ6sqwB3od/r0Yvmz79SFGry+X/jrQNrCeeRUjQ4jU2SdOiL8MGT9VUyyimvsRItQxzUg8COMXhrhPp7nBIUFBb2Ve9dXsYXgFz51BKW3z7slzTKBZg/nqgh+ezDNgHCC1azUu4MoizV019vj0+eIvBgquDXj+JJ3jK2g/Tf6EKB+IZe0+fP/KivBvhQNVSXvmzcKPv4gNAjvfUromDara2h1F//+jsSF8UvDwMPp+ejRx2hwHdEA5twjLs63R6p9vsEddahFJc3Ix6KVcd0MXEh5tfvPh1zcAbd1ORsqY6C1SFEhxtlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwfY96ARowsywVxv7v8mdYbu4RZxEyieGBKo1ssrv28=;
 b=ewURtiVhcaSw2WQ6/fXtnTWddqit72J9M2v3ifX/WI0GFMQs+IFe9TDD3oHCKJWC0PG6uid/7n5ndNFbCU6FatsBP9pdXPQImufGrHwidd2mrr7wqRjqAC72H+3Pl5+ZVjqM8PiBH23ptpHSjLZ9QoPts7wq6oBoZ3I3HjHXJIg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 09:31:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 09:31:37 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu/ttm: replace duplicate code with
 exiting function
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210715082439.678512-1-kevin1.wang@amd.com>
 <20210715082439.678512-2-kevin1.wang@amd.com>
 <0606dabf-3558-d263-fa88-e6d6fff47047@amd.com>
 <12b0918e-f37d-d283-0a89-eb4a36158d7f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2564023b-548f-3c53-82c9-ded0930a8b00@amd.com>
Date: Thu, 15 Jul 2021 11:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <12b0918e-f37d-d283-0a89-eb4a36158d7f@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:36d5:a331:b1c9:384b]
 (2a02:908:1252:fb60:36d5:a331:b1c9:384b) by
 PR0P264CA0191.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f875314-201c-4dae-4ecc-08d947735807
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109C4D9E0781367DBC2EFBF83129@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAImMcxcihuAl0Am6RbEiI3CR7XqHBWgjlrMxchMvbCUKtl13HI3zvP0vvTDuK7UpcsZ2cZafmKtgivQ8uWedsnrvubYrx/1b0tf/On7N2XatTJCBBbP7N5TRs7HElrH2skn5grkjnUUCH4uyz+KKVXaotomoNRoSZmPPKMReffOr8S115nXspTPy0lQ0T8mNiWKeqBsghbwyYZZT8DcUWdNHumAOXwLdXoqPcaiWLochy6+FGESrv+rLtQ0BE5AyqpwtMA2yulFtCpMum4ZeO9OAV0OkneDK5rWuhnN1CIjsIBq4JJvWNCFkYCfs+1W1+eleBHUfKxYKZRCyFC9Xn7wIEZFwG/bj4JkwPdyKq4aqN3jGqSM87jFlJFeXmn869ICGtpQCvTujVsBUJICRy9B72f0C3S0UcNOqPm2hy4mBh4eX6F2OzCy7xqY2UlQ/7AnyfxGbW+9pmcyTVP8FOaC184xhvcs4O5N8mcMPPT4MBX2pWJNi2VBbprgs7GUwE/NesZCWdwEAPydHJYwHrMS7nyD2FlupsDYZ4+3MHBj0b2TDtYY0sTBzdL509HyxYBDajkFker+QTuNMxezIkgJXiANS54ESpO7Ql+5LMn3qslSQBjY7gHM7cxlctFE5BNsHJlDjqwuu7pI0hC50LWpcxi8exqSP5YSZX1WPFNUkSl2rXU2XgTvRp3oqe+tG5NQv3rfBDZTs5P/yemPLnkS29zY2bDfnv/rJxHs61V5J3coBHVnAdnp3nI32kTJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(110136005)(2616005)(316002)(5660300002)(53546011)(38100700002)(8676002)(66556008)(66476007)(2906002)(6666004)(186003)(4326008)(8936002)(66946007)(83380400001)(66574015)(31686004)(36756003)(6486002)(31696002)(478600001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RlSTRsUjJvZ3YwSWRVOENpcVRIa0pkOWdEbzZCSVVtL0dRTWM0V2x3Rnc2?=
 =?utf-8?B?bjZzVDhqa2tvQUJpRlNoZjRCZm8xNWVTa05jenU3ZEtwbTM4R01pTTNOZWhs?=
 =?utf-8?B?Z2hhMGFqd1oyVzYvajN2S0pLaFZwR0tabnAraW1Ed3FlT2RyMW05bStianVl?=
 =?utf-8?B?T2F0YlUrMDRYcVMreWl6NXN2MlRiYURnV3FmbnBKdTA1VTArRlBQdDVzMTNW?=
 =?utf-8?B?VzU5N1pTd1VtYzcvU0QrWXV5UGk3Ymd0MHBDbS9LaTVMZzlFMVNYQjZlWGhX?=
 =?utf-8?B?NE85Vy9UdklXcEdFWXBscXJBcnA4TlNma0FISVY2dU5wOENyV0djamIzYlpS?=
 =?utf-8?B?UUIzVG1Od1FvNkpWL1hKcWs5YmNCYmFJRVlqeDUwcmVMOURwd2FLY2ordTZ6?=
 =?utf-8?B?cjhBcjM0UVZTU0FCMGt5VnhxUGkwUlFDU29ZSlJwaWpMdkN5d3FVUDc3UW5Z?=
 =?utf-8?B?OVZwOEEzNEswcFRNbWwxbUtwUWZwT2FRcVVLMytFZDJtVUdiRGJGZHVvZkgr?=
 =?utf-8?B?YlpENFdJU0I4aVVpd0lVZng4c0hZYUphUHJpMlRzWHBKSmdleHhaKzhlQkd1?=
 =?utf-8?B?aDhHdVV0MEdvTnJrc2xHZ2xiNWNoT09IMFROdUFyTHNDL0VnbDFkMGI1RVRD?=
 =?utf-8?B?R1dXZzB0Mnc5Q2toQWtUL3hhNXdKRlNiUGpUYzZaem1CRG9NTmJ1d3NKVE9w?=
 =?utf-8?B?aWVYOHYzYmNJcVBHMks4ZEdWNWprT0RnQTIydE5RUEF5KzNuRUdkb0FWMlg4?=
 =?utf-8?B?Tksya05lTkxqaUs2aXNvN2pyRml1bzNmUUxBYlpjVEpvY2E3N3ZudUtKaG8r?=
 =?utf-8?B?cDNaWDIvclJkamNNOVQ2d2ZtWlljQ0RQTVFWa0xVUzk3bG03RmJsSDB0aUNt?=
 =?utf-8?B?RDBmcWJSZXFUUEswWHBJamM2Y0JkSTVRK1p2bmJneGVVNkpsVXRTaGI2bnRH?=
 =?utf-8?B?bjdkSzdIcHNndXR4cTdXNEtRV1d4emNaN0JqTG02aGpjaXIwaGZkM0ZyRmYy?=
 =?utf-8?B?WFcyd0ZGam1WTzN5a1Y3bUlOM3d5a2JNdTZjVHRMeTdkUVoydjB5YmNNV3Qx?=
 =?utf-8?B?NXJvYjN1NHJuZjQ1Mi9TdFloRHVjOGdUM2dVcm93aDRCTG40cm5CazBoZ2Nn?=
 =?utf-8?B?MXF0SlJ3OFRDRFQ1Y0Q1UllzbEZrN1h2K2tOdHFCcERwQ0NHUFRGZmZVNDdE?=
 =?utf-8?B?RUdvditQV3lad0RSZ2QrdmJrbkF4bHEzM2FUOGNaZmF4bkNTQ3R5WE1STWNx?=
 =?utf-8?B?S09nM1g3T3duSEkyMTRLQy9PeW85L1FPYzJOeFNBbG1EWklNa1NtNGpCSkhj?=
 =?utf-8?B?TVVidm9qanEvZ2FSK2RvZ2liU2ViOHFBdEg4LzVGV2pQbEpDN1MxRU9ESG91?=
 =?utf-8?B?elNxdkF1OTNMaDl6RHBtbndYWWlRZnlaa0JIbW5tQmRpTS9NdDZKd3Eya1VU?=
 =?utf-8?B?aExTVlVLTVMwT2NzUmg2akM0OWNDWFhxbTQ5OXJyVEhuQjhncy9Uell3L2RE?=
 =?utf-8?B?SG9VbWM3cWdRWnhoN3ZQU2VTYmhsU1J4WVlnbDVzREhXNkM2TU5NNDBpeHlY?=
 =?utf-8?B?dXhHaWorcXlwa3N3TUJFR1JXMlRYbmhSNXlOV3pNZ3NBVzZ3RStMS2dFeDRs?=
 =?utf-8?B?Mkd1ak8vdWlHZVVpYS9ZZFJyandPZXRNZndnc2NkRC9mRjRubEcvZlFNbW41?=
 =?utf-8?B?UXpXakZXTXl2MW1lWjM5SmJxWmZNbHhNV2dZYVRsbDFFTHhVd3BObTlyYVhx?=
 =?utf-8?B?aExyL244d0p6TG5mc1NKQ3dJTDMxOXVSNWIyVHJMUW5BVGJEZE1XUEE0eUlp?=
 =?utf-8?B?SWtTMGdKSGgwK1NBL2EyWGxrQlFXeEJxL3JkenNWVXlvTTMyR0VNb0dnZGlN?=
 =?utf-8?Q?M/jzdeN9XDb0J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f875314-201c-4dae-4ecc-08d947735807
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:31:37.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVqBdE6vBDunRlk8guRq+tAbn5YkmVsgNw4Hk8VvL2Hj93WqGnlAdBqdMqQmwo1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: alexander.deucher@amd.com, frank.min@amd.com, hawking.zhang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDcuMjEgdW0gMTE6Mjkgc2NocmllYiBMYXphciwgTGlqbzoKPgo+Cj4gT24gNy8xNS8y
MDIxIDI6NTYgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE1LjA3LjIxIHVtIDEw
OjI0IHNjaHJpZWIgS2V2aW4gV2FuZzoKPj4+IHVzaW5nIGV4aXRpbmcgZnVuY3Rpb24gdG8gcmVw
bGFjZSBkdXBsaWNhdGUgY29kZSBibG9ja3MgaW4KPj4+IGFtZGdwdV90dG1fdnJhbV93cml0ZSgp
Lgo+Pgo+PiBOQUssIHRoaXMgc2hvdWxkIGludGVudGlvbmFsbHkgb25seSB1c2UgdGhlIE1NIHBh
dGggYW5kIG5vdCB0aGUgYXBlciAKPj4gcGF0aC4KPj4KPgo+IFdoYXQgYWJvdXQgcGxhdGZvcm0g
Y29uZmlncyB3aGljaCBkb24ndCBzdXBwb3J0IEhEUD8KCkdvb2QgcXVlc3Rpb24sIEkgaGF2ZSBu
byBpZGVhLgoKQXMgZmFyIGFzIEkga25vdyB0aGUgd3JpdGUgaW50ZXJmYWNlIGhlcmUgaW50ZW50
aW9uYWxseSB1c2VzIHRoZSAKTU1fSU5ERVgvTU1fREFUQSB0byBieXBhc3MgdGhlIEhEUCBjYWNo
ZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBUaGFua3MsCj4gTGlqbwo+Cj4+IEJ1dCB5b3Ug
Y291bGQgdXNlIGFtZGdwdV9kZXZpY2VfbW1fYWNjZXNzKCkgaGVyZSBub3cuCj4+Cj4+IENocmlz
dGlhbi4KPj4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0Bh
bWQuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMgfCA3ICstLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
NiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKPj4+IGluZGV4IDJhYTJlYjVkZTM3YS4uMmM5OGU0MzQ1YWQzIDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+IEBAIC0yMjA3LDcgKzIy
MDcsNiBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfdHRtX3ZyYW1fd3JpdGUoc3RydWN0IAo+Pj4g
ZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVOWElPOwo+Pj4gwqDCoMKgwqDCoCB3aGlsZSAoc2l6ZSkgewo+Pj4gLcKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMy
X3QgdmFsdWU7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCpwb3MgPj0gYWRldi0+Z21jLm1j
X3ZyYW1fc2l6ZSkKPj4+IEBAIC0yMjE3LDExICsyMjE2LDcgQEAgc3RhdGljIHNzaXplX3QgYW1k
Z3B1X3R0bV92cmFtX3dyaXRlKHN0cnVjdCAKPj4+IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHIpCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcjsKPj4+IC3CoMKgwqDCoMKgwqDCoCBzcGluX2xvY2tfaXJxc2F2
ZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9OT19LSVEobW1NTV9JTkRFWCwgKCh1aW50MzJfdCkqcG9zKSB8IDB4ODAwMDAwMDApOwo+Pj4g
LcKgwqDCoMKgwqDCoMKgIFdSRUczMl9OT19LSVEobW1NTV9JTkRFWF9ISSwgKnBvcyA+PiAzMSk7
Cj4+PiAtwqDCoMKgwqDCoMKgwqAgV1JFRzMyX05PX0tJUShtbU1NX0RBVEEsIHZhbHVlKTsKPj4+
IC3CoMKgwqDCoMKgwqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT5tbWlvX2lkeF9s
b2NrLCBmbGFncyk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2RldmljZV92cmFtX2FjY2Vz
cyhhZGV2LCAqcG9zLCAmdmFsdWUsIDQsIHRydWUpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
c3VsdCArPSA0Owo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZiArPSA0Owo+PgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
