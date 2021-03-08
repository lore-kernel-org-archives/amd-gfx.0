Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A235AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAA8651D1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAA8651D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50B689E65;
	Mon,  8 Mar 2021 13:56:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB87289E65
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i341Hq+y8TN0MyB6hHA2HzWK7HJg2ClM/QUM9ZuroLfb9+95jpCHMFog1HdKCt/scHk7p3MMW1l3g61GG+XdGwjA/067UY/72Q8T4YsxEcFWrwbDAVK8zBKAhh5PVxdqDfmVvmvwhJSsOqko/zJCkoY3on1DueTyNjohPsT8jp6RwARiz6xuJH5nQcW4GtLmlN08RREZ+DDl9thnVfnrLyQ2HnGuyOs/evh2J6RQGCMZfdcz6klsuIW2dbpiywNO0DhmGcPIvRR8D/KI4/SVxpD4cvrWAvP441Xx2HOPyvqSyFyqMcIgWbjvfPyzJS4gGco218JFPGiTF/bGWkCwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6yW+cgzx8hMf0eQZgYH37/z1Vca797FHiO7UYg79ss=;
 b=TixLK4kjFjHc7oJ3wk7VZhHLsZ72zZ5mHwNtNhvDjEu7acXG2l2M38vDGzxoVFh8Thc8KwPk6Rmz71U6hi/Mf2SxDTucqvftcs9f7UpsoCe7oVaftvWawR5nO9+276Ihb5lGgtvq43lsnfTFV0t7sokssKAkAiAdgfD3v2PStnzn4B5WZYZbLz4LBa159Ss8Qq54g3OhQux8RH9SFmaA66mr1zpECPUfuXPYs16f9T1VQ4HYSk20iioY+g/PJLS07wIZsYETjnep23ufztVIfsDCIjgMOt/79i9em5QhINoSykoOliouUOFp5tGSFxaNW1EoERxEORb1dfC72YhNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6yW+cgzx8hMf0eQZgYH37/z1Vca797FHiO7UYg79ss=;
 b=btB8GJyt2Ld2c+JUNFm7ONNydduXxDrRfZIylVuRBnQ1YrhfSLTXCdNAbw7aFWSLXQ4G+GYueeLvcAn+3mcxmuC0vmuwn/aUE1CPZyEZt5sM3QLe0WlaIPAXKgcufFsnsIZQunQEkiO69kN0H2DRnVx2U0c05faRwKzvEHRxm5w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 13:56:45 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:56:45 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: use amdgpu_bo_create_user() for gem object
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-3-nirmoy.das@amd.com>
 <0d083697-b194-99ac-71b5-866d2974a6a8@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ede649d0-2e9a-1826-28c8-e2d348887d1a@amd.com>
Date: Mon, 8 Mar 2021 14:56:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <0d083697-b194-99ac-71b5-866d2974a6a8@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0916.namprd03.prod.outlook.com
 (2603:10b6:408:107::21) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.7.169] (165.204.84.11) by
 BN9PR03CA0916.namprd03.prod.outlook.com (2603:10b6:408:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 13:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bf1b344-de67-444e-673f-08d8e23a026a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24684E04137190CEFDB675918B939@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3FnabOV1ht0gGZlJLuPExugyTDLjf2aNdn4SCSG1JTAHFADMA7DrSTWRPTk1p4upJRo/3Uwv7kyfESLq9rKINZxTmD5Iu6ZY6YpY4iCsxyf+8UtvrzgqTnvxJdR5LNqHtGvu5A8oAxRQM3NE2j5y1AJ4T3FBZDQmhhEDz11ZUo7RdOKwUtCybpMlNYXIoGTcROEF65sqmpd6NQ6kpM23AeX0SEucgBc6y0PrIGS05n3ZI7M0kJ5EzHBdjeCEdUtxC6g8sAwZLdLIOB4o9HYbakBfeKCEqdc+aWHqsI0B0ChW3SH+L7Vz04bgqwlU8dnD0mbFJz9DFOx6M5jNPxMc1MVGAyfupXs7ewA4q6tytC/btCNcbUG4NRGfpACmKoNtZ3oVvNypbSVIyEL7/cr/z4KQQmHXfIf96AC6/KCL6uGMAz8cFOfC4QofDl4iSTwnBY/ovnIRHBVjNrZXS1gbBO9YrqHNR4AfmX0IoKVGIWJNQdpuCFdhFMlCEQN41A9Re7Avy+YCZBmfWaoSA9mjRZ+Q4Rl2zYc8q+hgvdKQZ3VAIuq5AizjcGPscA2q8ic6rBS5pkgzDgDQqf0pRLooWIuiaifIs8/7+iPjUxAVH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(316002)(16576012)(2906002)(66946007)(36756003)(478600001)(31686004)(66476007)(66556008)(6486002)(8936002)(6636002)(4326008)(16526019)(186003)(26005)(53546011)(2616005)(956004)(66574015)(110136005)(31696002)(83380400001)(5660300002)(52116002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SktXQXVVVFZMVWV4bVlxOFNPOVpoWDJ5WThnaVBwaXg3YXZISTEwUmk3aFEy?=
 =?utf-8?B?RXlVOFp6cC9UM3dubzE2VWN4SkpBbGJOUDNmUEV6Mnk2aldYb2kvSHRmb1ND?=
 =?utf-8?B?QlN6aTgrU2tlUTBPbHBudHFDc3JEaEtHTEEvdGwyQm5ObEJZb0dVOGw4MmJC?=
 =?utf-8?B?RFBoQ0s5Ry9zQ3lZMHdNbzZwUE5ndmNNaWR2eXIya1Y1VE5tTzRScG5kZTJH?=
 =?utf-8?B?QmZ5QmJLaENPLzdISE5WRWovWFc2VEVVT1FEQWhFdURGNUxpM3ZOUHVQM0R5?=
 =?utf-8?B?WlhobUNaV2JabVl6WjRyazlpaWN5OW5jUUpOOVEwTWFhTVlMbTUraWtqR1pO?=
 =?utf-8?B?dThhYzZLcUc0Y25wVnRyazVvYVgxdG85b0tXcURyR080d3ZESWt1WU1vU21Y?=
 =?utf-8?B?SUFsWnJpTTRuTUI1Ulg1cVM2U3RycmlScXpJMkd1eDFWeWhuL2g5Wm9tNmNp?=
 =?utf-8?B?MXpkSExPY2dSZjhlY2EvR0M4eE5rYWVmKzdscVVSdmNobVBaeXdZbnZrd3JQ?=
 =?utf-8?B?N3RkUmFBTG5SWUZRZ2hqbWFNTnQybUFFL2FBUVR6ZmRVTVpDMXRoRG9qajZF?=
 =?utf-8?B?eXJmdHdob2JxSjY3NWJNaHBuZDlXR05QenJ2U2xvc0RxeWFxbXlXa0FhQ25i?=
 =?utf-8?B?OEFzd1NoRThjVVBOa0FaRnoxejdLZ3Rlb2ZNaUF1d2hWUXh1Uk53SHNVaUVT?=
 =?utf-8?B?WFRBM0ZBUDh3VFNUZU5nZ09VKy82UGpxVjYwaFQyd2VWMVpCcDl3eEtrOE5L?=
 =?utf-8?B?VWxNWWpEYXUzN0dNWTFXbFRsWkNBRmRraDFBa2V6NTZ0VDB3L0gxWDNwcGRR?=
 =?utf-8?B?WlRhT1djRTlldHJtWmNoTjhkSE55ZnUya1ovMW10ZkU3bUFoK0FReW1JdHd6?=
 =?utf-8?B?eEZxcFJCUURUSG5GUnh1RFBTZmd6QTJmYnFVVGNCUTBEL3dWTWd5eUhhamF0?=
 =?utf-8?B?MDJBQ3hNd1AvLy9ZVEdUNXQzZm4vRXA4V2Q1QU5XUlR4MTUxU01pT3ZGY1dS?=
 =?utf-8?B?YTVhQlYvQkFGRDg1WFRIT1pzOGUvL3d2U2lITXVweUVQTE9JZFBERGJ0SnE3?=
 =?utf-8?B?WXJ4MHBpOHUybDMrOGVJQU42cUtjeVRoSHhtM2Y3T0JNL3JzRW5jbXAxTTBk?=
 =?utf-8?B?enNIVFNJYnhyQkdpSFh4UnJrb3VUS0g1UzVuRW1JbG5qQUt2Z1NWd3lTdmN0?=
 =?utf-8?B?a1N4YWpZQjFPZXlBeTlOcWtvSjBaeE53Um5PYldLTmtGT1NDMTFWMXEyd2po?=
 =?utf-8?B?SWFTdk5jTW9hYlM1YVlOVlkyMHdaT0trbDRtbWN3bldvM05VZWlxZlQ4NFRH?=
 =?utf-8?B?UU9yRW5GOFVpQ2R4VkdObTNVMCttS1FJaXZzQ3ZDeEt3Y0s4QWJjRGU4MXda?=
 =?utf-8?B?M2hkaHZsVWdoNkU4YzlTOE1CQXFBek16NHYreEttZ1pCK2FKdE4rVWlXV0ta?=
 =?utf-8?B?bWZiUityVGlQUHNCS05PWktCbkMzVFRrRXM2SG9nUmM1MEljRWFZamp1NDB1?=
 =?utf-8?B?NytwQmFkRkpJOUQ2Y1JNS2J3QThxN2V1RVlZM29vZmQ3K1NrKzRZNkxvVnJr?=
 =?utf-8?B?SzcxSExCUjBPMWZMdDlVQkFSeC9yUlBMdUsrYlA5NzZCZndqSC9LL0ZCeDg4?=
 =?utf-8?B?cmUzL0Z1ZHhCb1E4Zk9HZVpHY05XL3JUOUZuMmdCZVJBRVlNVDdUdndxSFNx?=
 =?utf-8?B?U3gvQ2tEbkx6NDRXNFFjWlFEVUFWNzlvRXZtV3hNbm5tQ2ZSNXI0d2EzTTZS?=
 =?utf-8?Q?bPWTo2YbKjHpbNd004qdXTND5b0Za1khtEADprq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf1b344-de67-444e-673f-08d8e23a026a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 13:56:45.2732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYVgQL9aL9BQy9mafCbkSunhDtU1sF1A57vktUd9oeaSqZZQrvxiTCQ5H4SqzfnYaZUKE2/jt3V1+ONe9gjLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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

Ck9uIDMvNS8yMSA0OjExIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFdlIG1pZ2h0IG5l
ZWQgdG8gdXNlIHRoaXMgZm9yIHRoZSBLRkQgYXMgd2VsbC4KCkRvIHlvdSBtZWFuIGZvciBhbWRn
cHVfYW1ka2ZkX2FsbG9jX2d3cygpID8KCgpSZWdhcmRzLAoKTmlybW95CgoKCj4KPiBDaHJpc3Rp
YW4uCj4KPiBBbSAwNS4wMy4yMSB1bSAxNTozNSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEdFTSBv
YmplY3RzIGVuY2Fwc3VsYXRlIGFtZGdwdV9ibyBmb3IgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucy4K
Pj4gTm93IHRoYXQgd2UgaGF2ZSBhIG5ldyBhbWRncHVfYm9fdXNlciBzdWJjbGFzcyBmb3IgdGhh
dCBwdXJwb3NlLAo+PiBsZXQncyB1c2UgdGhhdCBpbnN0ZWFkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCA0ICsrKy0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+PiBpbmRleCA4ZTliOGE2ZTZlZjAuLjlkMmI1NWVi
MzFjMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+PiBA
QCAtNTQsNiArNTQsNyBAQCBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKHN0cnVjdCBhbWRn
cHVfZGV2aWNlIAo+PiAqYWRldiwgdW5zaWduZWQgbG9uZyBzaXplLAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqb2JqKQo+PiDC
oCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4+ICvCoMKgwqAgc3RydWN0
IGFtZGdwdV9ib191c2VyICp1Ym87Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJh
bSBicDsKPj4gwqDCoMKgwqDCoCBpbnQgcjsKPj4gwqAgQEAgLTY4LDcgKzY5LDcgQEAgaW50IGFt
ZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsIHVu
c2lnbmVkIGxvbmcgc2l6ZSwKPj4gwqAgcmV0cnk6Cj4+IMKgwqDCoMKgwqAgYnAuZmxhZ3MgPSBm
bGFnczsKPj4gwqDCoMKgwqDCoCBicC5kb21haW4gPSBpbml0aWFsX2RvbWFpbjsKPj4gLcKgwqDC
oCByID0gYW1kZ3B1X2JvX2NyZWF0ZShhZGV2LCAmYnAsICZibyk7Cj4+ICvCoMKgwqAgciA9IGFt
ZGdwdV9ib19jcmVhdGVfdXNlcihhZGV2LCAmYnAsICZ1Ym8pOwo+PiDCoMKgwqDCoMKgIGlmIChy
KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAociAhPSAtRVJFU1RBUlRTWVMpIHsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BV
X0FDQ0VTU19SRVFVSVJFRCkgewo+PiBAQCAtODUsNiArODYsNyBAQCBpbnQgYW1kZ3B1X2dlbV9v
YmplY3RfY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldiwgdW5zaWduZWQgbG9u
ZyBzaXplLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHI7Cj4+IMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgIGJvID0gJnViby0+Ym87Cj4+IMKgwqDC
oMKgwqAgKm9iaiA9ICZiby0+dGJvLmJhc2U7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
