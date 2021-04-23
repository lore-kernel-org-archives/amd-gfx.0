Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8451BC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1536F61458
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1536F61458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988B56EBAA;
	Fri, 23 Apr 2021 14:26:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700083.outbound.protection.outlook.com [40.107.70.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949586EBA6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 14:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtWB7y2mARoy6fZxLAzm8zulYPbQa2xMUAbjQ9jC1EGZbZ4utvK/hfW14s/mokwtB0O39U827Iqz73xjp2kHyFvlxirByFtBpZhCxuO4BHp2QzFm/vQnZlKQI2AjtEduV4uNiP8vQWjZRe5jOd9rBi3ENcmeOdsSqnxuCOnUAVpQxPFOy4d8p2utvTh6dTatr1UBHz+fx6xXL5GiPhiHA9TrX6yuJZpAjmtklImWcKisFxQuEaQllUskzx6opvAUc/vPYRrBu/z7NTqGu2uHeTq53IRu4s8yiLFmBq3h6H1OyjpHfthwq8Xo/Nl+iZyemdTC4/4ir1s4WwN0t8zYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXph83cO5mwuEPML48xx/0oiLuC1uj+at/GDv0EGYds=;
 b=Mf+dgDkbK+eRuagSyQ2I/fQq83w3PRQrsR4NvkavNlJODaiIzMbCAkfq9wSXxWQsKn5rIsgwyy+y1gCacJJdV8oelcNZbdmgGNQ0bvIbxy1z2UTIGqM3VCB5dcEKB2An1YjIh9CjYN5nMQ+wCye4qJMrXwcOUrYINZ2YjEfh9g9ThbCja3KfeROv1IQTkk2tG8JCJyMDfB59Z9ufszeCgy2RRYZkkTdKAIlND+1seFFC1xaj26O1aQD785Cvz3NngK3MMiQSR50HQufUqJIUSysPksIscFEgvVArdEeX4Zt8ODPZIis/gtbsGKKgPsbQ+qxO5dkvq3cvnm4dOP57GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXph83cO5mwuEPML48xx/0oiLuC1uj+at/GDv0EGYds=;
 b=SqcZAgn3+F4Fj1cgjXywxTPkpd3BuvBNCfU4tx6tPxvmum1JjS7D1Ka3NlAv5VCcELl8pjktQyAHOY+/ztZaKk/3zNryI9eujXHpvx28vsIobXbdt2QA98fTNeRGZidZc/YikEWp97DU+xhWt7lmurVWM2eboaoy4h2wAXixF9U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1357.namprd12.prod.outlook.com (2603:10b6:300:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 23 Apr
 2021 14:26:03 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%5]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 14:26:03 +0000
Subject: Re: [PATCH v2] drm/amd/display: Reject non-zero src_y and src_x for
 video planes
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210423140958.25205-1-harry.wentland@amd.com>
 <49d21b75-eaf7-5e24-7a16-480698e1498c@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <b3ea9558-52ff-0c0b-0766-ad6e55f6e49e@amd.com>
Date: Fri, 23 Apr 2021 10:25:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <49d21b75-eaf7-5e24-7a16-480698e1498c@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:404:f5::18) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.6.172] (165.204.84.11) by
 BN6PR16CA0008.namprd16.prod.outlook.com (2603:10b6:404:f5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 14:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9b8c6f-cd99-4a9c-9542-08d90663b8ff
X-MS-TrafficTypeDiagnostic: MWHPR12MB1357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1357EB856E996293E64F0D488C459@MWHPR12MB1357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hK8ahCvr60CEFMmexEvTzrcq5oOo3ZnAXZhl8d0DQT/ureXf7M4zJkP4vTJKL9JNxGD1qXxQpx4gggKCQ0x/RPmJrGsncRKw4WUXhQUmbK6oycG0CD1qV0s5NLQ10Z5pHX8Wz1+dEkoLD9heiCQ3aFucS08FMGAykT/8hPxgt6tuaLfns7FUEFeU1MptvY12GeYg/TKYFeavWeBkkg6D734sjCAVtT66FEV06EXtnMnpmzdRUftddgIq2mPrV9xTLLd2Hrc9UTPJjTt4SotqULm/BUnQQC1LjMymLgnKEifEl62bY3Lbs7ffzwcXbWUnR8mIN1KhVBVS7HiJGIQxdPOrHkCtFdnD8JrlZIjyy+2Gqbs0WwXSdh4tR/R03BE4JAgLWqIlHnE3xKuamAMYcDgsjj7JlLTcPGeyQLGgkMCS5hGWs/Z3GJErWdTJV1i3Mcz7rN2GRXgo2peb8rD7r/q3GkLGbJu77Jjj+D9anFiOzq5EtE7ve5NaeryeDcFnyMka39oRcYGmqiSVQWF4e3Ba7Er2ncF/Q/iaplT/au3rSiHc1o9bbqzEqCyidIGSu96M9DVmzafavpe9HpJNj+y2y6cfm5VljyfhnMNHOUiYQg6+ZI655/bs8u/xx9bOBR2o0m86NAK+BSKSG7OtWQ6vqPuqkraWdNAw6ilj/HPSpixs6VtcaV7kN7QIUtEs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39850400004)(136003)(44832011)(316002)(2906002)(66476007)(31686004)(8936002)(956004)(2616005)(86362001)(53546011)(16576012)(66574015)(4326008)(6486002)(6666004)(8676002)(83380400001)(36756003)(38100700002)(66556008)(5660300002)(26005)(478600001)(31696002)(66946007)(186003)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eEdOT2Z5NXJRWURHdm16TTlvUVFxYUtMWGgySGNwbWFqM09RMHVjN0ZJcTk0?=
 =?utf-8?B?eENYNi84RFdwczFvaEFQcGg4WTNpZUtyczNuc1NTUG5Ba2ZaT09BNVlmRXMr?=
 =?utf-8?B?ejdPWFhBU2JVMmhNL0VlbVRNQmdaQ3VXYUFQOGJuM2lvR0NUYkg2ZUg2Ujhw?=
 =?utf-8?B?Vkt0RVVWenMyTWorVnNoNHpsV3RkalY0aVIvbEZEMWltV2doSXZrTk43b2hV?=
 =?utf-8?B?dW1la05ma24vMmliN01YdCthdSt1NmRYNDdkMjEzdWQzT1pYVFpISzZMU05V?=
 =?utf-8?B?WW1hQkZ1YTM3L09GQldWK2EvZlJqQXlheVpPZ3BOK1VNTUpXKzdQUWpIQXNE?=
 =?utf-8?B?ZGc0dE1MalBYRnQ4Sk8rV1JOVXNFUEFNbkdpRjE2TVBwWTcxbE1hRi85YkpN?=
 =?utf-8?B?MGp0a25IZ2tNbCtDbnN0dEROMGxFb2F4djUwR2xLdUJjcWc3enA3VHJIRXht?=
 =?utf-8?B?NnFXc05MNWpPSkNEZ1V4cU9mZEVIYnVMR1JKMzFjbGVxbmtLcjNuaFIrLzNm?=
 =?utf-8?B?SDE4aGZvUEdJdGpIdGlQYjRPQ1VkR2VuQnNkREZwb1BZUGh4dXMwMzFxS3pV?=
 =?utf-8?B?TkdJeEEzcUd5QTAyc3FvTDluNzliSXUrMytVdk4vaFVmK3VvbzhTNWJCRDVV?=
 =?utf-8?B?Y0FBNUNhUkVNYkNIZk5WcVpTMytLVjJvV3FrbE4yNi9BQVZTVExLaDBDWVdC?=
 =?utf-8?B?S1ZRM09oQkIrVTJFaGMyRElkbjR3RjFQaTdoM1JJWXBzWTl5bmZzUEQ5SjNE?=
 =?utf-8?B?MCtVMXh6S0Rka2pQWEhOZU5KRDF4YVFUbE00TnNUcldHRk9NY1NrOHFnbndY?=
 =?utf-8?B?ZHJxZHlwUHViNzBzU2pZNG9JWkZLTXl3QWQvZWF6VWtHVE1SMmpCNWs1V3g3?=
 =?utf-8?B?RUJaTThUaWpqYUxrb0JxcDNvRmNyNFRCcFo5U0dDd29RQ1k1cDNYT1p6ODh4?=
 =?utf-8?B?MTJ2akUyWmN6dW8yQllQQUxkZzZQUnVnamZTNG5aa2hDN1grb1FzbVR4c2F1?=
 =?utf-8?B?ZHAxY3pCcnFFM3lTN2gzVlJqd3h5N1UzL04xODJqdlYvcEc1czZoTnBvaHdx?=
 =?utf-8?B?dERzbFh5WWh1dURaQXlCc1VsVEVoQU9sbUhSb0FrMDVjc3dac250cnBLWCti?=
 =?utf-8?B?eHpES05VOG85eWpZbDlud3BsSkVqTzRmdjdEaE9QK0dFbG0xMk8xNEZ3Wmd0?=
 =?utf-8?B?d1VtM2NuYTJ1UFNpek9OVUZoUjhSVlR0VVNNQm0wbW5MVllMbVVJUW9tTWcr?=
 =?utf-8?B?RldyNE1uUk91UHpiWERJS0tkSmtGZ3RUVGplMHhwcmg5RHhoQ01rTjVzeWg2?=
 =?utf-8?B?ZW5CVlowaEJlSnptZGVadFpRdVJMZGlpZy8wb2xzMGlPZ2ZPNlVUWVZrOVRP?=
 =?utf-8?B?WDcyRWdlOW05dDFveXl6KzRnMEN2dWEyWkFwY0Nnc0hFYUVIWmtHRDdJK0hU?=
 =?utf-8?B?OG16a2JwMHhZbHRnVGNVMEFqc3NZMVh3c2FXRkhnWThnOTdJUFhQbHFtOW8z?=
 =?utf-8?B?MGIrdFNmUWRQaWxnL2R1cHFuMUphaWsrelFGSmFGOTdidzNNSHdYRUpVUXht?=
 =?utf-8?B?b2djM2V6dVJ5Wi9hMitob0tsZUdOQzZPcFF3TFJnUUNZbC9TRk5ITEQwV3lT?=
 =?utf-8?B?WXF3S2Vqa3BEZldwdmlSVnpScWwxU1ZsZjF6OTF5SG03ajU2U3ZyNXZBd3VI?=
 =?utf-8?B?Qmo3VDhLYUJ2a0grVjBhN0hmSEZJd3pvMWUrWkt4MTN1L29ZWFN1aU02UFNq?=
 =?utf-8?Q?jg6eQqhpmqGVfISwVoJ9nCYH7olIUn5RaOAUkxy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9b8c6f-cd99-4a9c-9542-08d90663b8ff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 14:26:02.8038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQu4l9tZ2u6CQdZmRCBe1RZWN4s1K9ke8UEtNPPeZw3WQ4rJHgbeBHDDdaSEbwVsASkD4SsGM4efDHA2T3Fvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1357
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
Cc: Roman.Li@amd.com, stable@vger.kernel.org, hersenxs.wu@amd.com,
 alexander.deucher@amd.com, danny.wang@amd.com, nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNC0yMyAxMDoxOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEdvb2Qg
dGhhdCB0aGlzIGhhcyBiZWVuIGZvdW5kLiBKdXN0IGEgY3VyaW91cyBndWVzcywgYnV0IGhhdmUg
eW91IGd1eXMgCj4gY2hlY2tlZCBpZiB0aGUgc3JjX3ggYW5kIHNyY195IGFyZSBhIG11bHRpcGxl
IG9mIDI/Cj4gCgpUaGF0IHdhcyBvbmUgb2YgbXkgZmlyc3QgZ3Vlc3NlcyBidXQgSSBzdGlsbCBv
YnNlcnZlZCB0aGUgaGFuZyBhZnRlcgpmb3JjaW5nIHNyY194IGFuZCBzcmNfeSB0byBiZSBtdWx0
aXBsZXMgb2YgMi4KCj4gTWlnaHQgY2F1c2UgcHJvYmxlbXMgdG8gdHJ5IHRvIGFjY2VzcyBhIHN1
YnNhbXBsZWQgc3VyZmFjZSBpZiB0aGUgCj4gY29vcmRpbmF0ZXMgZG9lc24ndCBtYWtlIG11Y2gg
c2Vuc2UuCj4gCj4gQW55d2F5IHBhdGNoIGlzIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gCgpUaGFua3MsCkhhcnJ5Cgo+IFJlZ2FyZHMsCj4g
Q2hyaXN0aWFuLgo+IAo+IEFtIDIzLjA0LjIxIHVtIDE2OjA5IHNjaHJpZWIgSGFycnkgV2VudGxh
bmQ6Cj4+IFtXaHldCj4+IFRoaXMgaGFzbid0IGJlZW4gd2VsbCB0ZXN0ZWQgYW5kIGxlYWRzIHRv
IGNvbXBsZXRlIHN5c3RlbSBoYW5ncyBvbiBEQ04xCj4+IGJhc2VkIHN5c3RlbXMsIHBvc3NpYmx5
IG90aGVycy4KPj4KPj4gVGhlIHN5c3RlbSBoYW5nIGNhbiBiZSByZXByb2R1Y2VkIGJ5IGdlc3R1
cmluZyB0aGUgdmlkZW8gb24gdGhlIFlvdVR1YmUKPj4gQW5kcm9pZCBhcHAgb24gQ2hyb21lT1Mg
aW50byBmdWxsIHNjcmVlbi4KPj4KPj4gW0hvd10KPj4gUmVqZWN0IGF0b21pYyBjb21taXRzIHdp
dGggbm9uLXplcm8gZHJtX3BsYW5lX3N0YXRlLnNyY194IG9yIHNyY195IAo+PiB2YWx1ZXMuCj4+
Cj4+IHYyOgo+PiDCoCAtIEFkZCBjb2RlIGNvbW1lbnQgZGVzY3JpYmluZyB0aGUgcmVhc29uIHdl
J3JlIHJlamVjdGluZyBub24temVybwo+PiDCoMKgwqAgc3JjX3ggYW5kIHNyY195Cj4+IMKgIC0g
RHJvcCBnZXJyaXQgQ2hhbmdlLUlkCj4+IMKgIC0gQWRkIHN0YWJsZSBDQwo+PiDCoCAtIEJhc2Vk
IG9uIGFtZC1zdGFnaW5nLWRybS1uZXh0Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhcnJ5IFdlbnRs
YW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zwo+PiBDYzogbmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tCj4+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBDYzogYWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbQo+PiBDYzog
Um9tYW4uTGlAYW1kLmNvbQo+PiBDYzogaGVyc2VueHMud3VAYW1kLmNvbQo+PiBDYzogZGFubnku
d2FuZ0BhbWQuY29tCj4+IFJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xh
cy5rYXpsYXVza2FzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCAuLi4vZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmPCoMKgIHwgMTcgKysrKysrKysrKysrKysrKysKPj4gwqAg
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiBpbmRleCBiZTE3
NjlkMjk3NDIuLmIxMjQ2OTA0M2U2YiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+IEBAIC00MDg5LDYgKzQwODksMjMg
QEAgc3RhdGljIGludCBmaWxsX2RjX3NjYWxpbmdfaW5mbyhjb25zdCBzdHJ1Y3QgCj4+IGRybV9w
bGFuZV9zdGF0ZSAqc3RhdGUsCj4+IMKgwqDCoMKgwqAgc2NhbGluZ19pbmZvLT5zcmNfcmVjdC54
ID0gc3RhdGUtPnNyY194ID4+IDE2Owo+PiDCoMKgwqDCoMKgIHNjYWxpbmdfaW5mby0+c3JjX3Jl
Y3QueSA9IHN0YXRlLT5zcmNfeSA+PiAxNjsKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBG
b3IgcmVhc29ucyB3ZSBkb24ndCAoeWV0KSBmdWxseSB1bmRlcnN0YW5kIGEgbm9uLXplcm8KPj4g
K8KgwqDCoMKgICogc3JjX3kgY29vcmRpbmF0ZSBpbnRvIGFuIE5WMTIgYnVmZmVyIGNhbiBjYXVz
ZSBhCj4+ICvCoMKgwqDCoCAqIHN5c3RlbSBoYW5nLiBUbyBhdm9pZCBoYW5ncyAoYW5kIG1heWJl
IGJlIG92ZXJseSBjYXV0aW91cykKPj4gK8KgwqDCoMKgICogbGV0J3MgcmVqZWN0IGJvdGggbm9u
LXplcm8gc3JjX3ggYW5kIHNyY195Lgo+PiArwqDCoMKgwqAgKgo+PiArwqDCoMKgwqAgKiBXZSBj
dXJyZW50bHkga25vdyBvZiBvbmx5IG9uZSB1c2UtY2FzZSB0byByZXByb2R1Y2UgYQo+PiArwqDC
oMKgwqAgKiBzY2VuYXJpbyB3aXRoIG5vbi16ZXJvIHNyY194IGFuZCBzcmNfeSBmb3IgTlYxMiwg
d2hpY2gKPj4gK8KgwqDCoMKgICogaXMgdG8gZ2VzdHVyZSB0aGUgWW91VHViZSBBbmRyb2lkIGFw
cCBpbnRvIGZ1bGwgc2NyZWVuCj4+ICvCoMKgwqDCoCAqIG9uIENocm9tZU9TLgo+PiArwqDCoMKg
wqAgKi8KPj4gK8KgwqDCoCBpZiAoc3RhdGUtPmZiICYmCj4+ICvCoMKgwqDCoMKgwqDCoCBzdGF0
ZS0+ZmItPmZvcm1hdC0+Zm9ybWF0ID09IERSTV9GT1JNQVRfTlYxMiAmJgo+PiArwqDCoMKgwqDC
oMKgwqAgKHNjYWxpbmdfaW5mby0+c3JjX3JlY3QueCAhPSAwIHx8Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgIHNjYWxpbmdfaW5mby0+c3JjX3JlY3QueSAhPSAwKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOwo+PiArCj4+IMKgwqDCoMKgwqAgc2NhbGluZ19pbmZvLT5zcmNfcmVjdC53
aWR0aCA9IHN0YXRlLT5zcmNfdyA+PiAxNjsKPj4gwqDCoMKgwqDCoCBpZiAoc2NhbGluZ19pbmZv
LT5zcmNfcmVjdC53aWR0aCA9PSAwKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5W
QUw7Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
