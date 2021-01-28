Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 16:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B193E64E07
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 16:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B193E64E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077FF6E9C1;
	Thu, 28 Jan 2021 16:54:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455EA6E9C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 16:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApD5D/sp7y/q4sOXXIQMmnCYgTSAl4NOKRNPV7WcIGNLzU8qP/2mWIoiDOX92ZUEZd9ZdlC+usC+9WV/Q5x98art8BUdBtL9+r+1/Hv7wsxzQvxRvaY3KWmA1jaVIbs5+R7JdJPEuzluKkmn13r22zb3vAfQPfIlfOIuBTyLLSVn+DKw9nbGw3r9a1R/AeZ53tk+myHFLJQmDa0jnbx829HU0OrKJlZQXlnm3fd6rz8hP4F0a0I6ISYw08PRsUXezNa1SnNVn2lEED+Krn3Y96ANz51dshxAiFjDh0X7+8J7fiYdKPfnamCxUF5k+bu15FWPS9MLGdvSvqULWcOTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RK1efU0ufNsaNkdCnkMJtsYMLmSqKtFjDlk084Ej/U=;
 b=Skc1jNchoQR/4ZIUMogs7wS+ETdis+RdPusYXMw/PuWS7i2TrD920caIC8KIODiGA6Uq7mOd/i7AgSNoJS6pgdfzFDzNYEeV7kxxVBp8E4BHXo5MCsw3wEmSDOJYdvTHbY9LoLEL9rLhNXXl/LNqTio5EfIUPjzvmh+1OKL4l4I3Gi64fFrQeeDgC5r4tNyujvIG9JaymMXtC6itpwLoLFQmg6BR1It+kEY8Hv7oIIlNAkKzsh8i51dSMZ0VFu34dalCosX/slGOJuquMbvREtMFoxeN7g81khONxfl2ccs0NRPcK7s5VRYgv6s7oPiwCH5Kqtua2k9vo+B82PYhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RK1efU0ufNsaNkdCnkMJtsYMLmSqKtFjDlk084Ej/U=;
 b=adUp/4tukEPvcBUmIadhcO0xwxzZ7tNzgeiF6K1E9ezownNBKE8EJ7hSUY89WwSRo+SnRd8M8wGGfeglKcbUPJd+OjIPortZ3mSF7h+PmnlQhqNYeOBCgAkfPnpgSnY7bnGwBtbKLcDfKTNOpTfgsaPU10ll+osw+tS78YsCdZU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3353.namprd12.prod.outlook.com (2603:10b6:5:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 28 Jan
 2021 16:54:32 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 16:54:32 +0000
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210128143554.61100-1-nirmoy.das@amd.com>
 <20210128143554.61100-2-nirmoy.das@amd.com>
 <0adf796d-c0c8-87cc-e7c0-8a29336385f7@gmail.com>
 <a44f5a1a-4be3-06a0-764d-23918a51698f@amd.com>
 <4cd8a507-f472-3394-55c2-b55fee588040@gmail.com>
 <b90dd6f2-919e-837b-f26f-73258ab899cb@amd.com>
 <a1d26d23-acf4-e76e-6f4d-fecc6bf4fa27@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <afefb9f0-f276-8817-d4b6-c9a59e476f09@amd.com>
Date: Thu, 28 Jan 2021 17:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <a1d26d23-acf4-e76e-6f4d-fecc6bf4fa27@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:404:65::22) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.3.25] (165.204.84.11) by
 BN6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:404:65::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 16:54:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d66c064-d6c4-4040-3c72-08d8c3ad62a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3353A37213B886D3E75580AE8BBA9@DM6PR12MB3353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJDqSiaCbnIw+zDmje6yMOl16gCym4c5RULBoICwRw627Rgb/Mr5nZyGCPpJMpfx8/GzhcUlFrO5+4JW+tSWoplz1p/2d0kBcxySh/S7a8XyZDXXiRU8KapCrtgQR0mmv9MnV7OZXKd7A12oPAJSaV7iU6MKwOe3ZD5kZUxy5k2+cTI/JDgPu4HruHYWidYRVHKlI2PsqYgO3kF776RYmNBkVwOJHmxeBc8KehvZpvqpfCgqQI/3dkAe+zPgyzWycW1UMi/pASafY2IodCieDqfr+5N/1V55HneYqaNjkZtuUgq0cq0bItSMCY/+5YBD0wL3ahMvBPCUGoYtL8RJowEoMEmwHT7OP38aG3L0GBuX5evHYmf57OQHnqONiliSd1G9Z6UpWw2Jex4pZ4ISDEkkmSy51GumrmNtbbP4fXVgslAPrYEWhKQmIm2FvcJmDNlCOW8yq3Y5ujzgk2g3GQ+dsMwLkPh3s0Rci4tVFL5rWSteDF4CKW5KVRpTdWbmJcUq/Ngp7/0sya9vZgjPPbHfOgplb/Hef9NLnYtVFWsxRwDk7smoEh7h8/BS2Dzt+cTKW1RH1hmpK4JdGMrzzZUZZ6AaI0gXPXlAXiBYOJI+pQnqD6X9gH9VCGLC8t6+Er1224qs+XzdEuH8lmyLXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(5660300002)(31696002)(2616005)(83380400001)(66574015)(66946007)(956004)(66476007)(316002)(26005)(478600001)(52116002)(45080400002)(31686004)(66556008)(110136005)(36756003)(8936002)(53546011)(6666004)(966005)(16526019)(4326008)(6486002)(186003)(8676002)(2906002)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGk3dm9nYmpWWUN6dEtOTjJ4YnRpbW1xSVFsdk9jdDNta2k2MlFuck41VjZM?=
 =?utf-8?B?NmFXNC8xZUxnM3ZOK3dlYjJ1UTFnOXJ3VVI0U3k4cFZBbFVHUDJnZXVNTkJZ?=
 =?utf-8?B?NVpmL2NSbXZZK04zYWJadXBxM2F5WDJCZHdyU3ZubTJNRUtJVGZ4bHpLdkZH?=
 =?utf-8?B?RmhOZzJxZVJwSGp3d2pSYXNTMyt6bmlGcmZVL2VMVlRVVE9STjdueWQ2eFZI?=
 =?utf-8?B?djRmdXlpM2lSRkk5TENKS25xbWtOMGNETnk2dTJrSFU3VktIV1FXOU1WNXhU?=
 =?utf-8?B?aXdWblE1M3BvZUZzQ21zZVExQk1aTENUQU1nbzgybEcrbDVQdWZ5czRRL0p6?=
 =?utf-8?B?UUtnMjljZWQ4ZEQzQ0UyNC9nTHJSZURDT1h1dm5QV0JDazRuYzc0aHpzRHc2?=
 =?utf-8?B?MWpjMHRJb1RkV2d6WFB1S0VwN29lSkk5eTNvT2RTMVhoQld3QWtSQmhTK0V4?=
 =?utf-8?B?QTJZU29hdEVseUJWcDc3VStJazVUd3FhVGx2Z0IzR2dDME9XaHF6ajE3UXVO?=
 =?utf-8?B?V0R3NmJBODlwRm9BZ2lpeWh4VEI1d2NqQk1nY1V5YUVPeFo0c0RuRjBkMzAz?=
 =?utf-8?B?MlpkSm8vQ0x0QVBadExxRm9iSDhiN0kvNnFIaWVxU1RyNThDREVOdmMvaFFY?=
 =?utf-8?B?elVRVXBTN1doeVVTdmhRWHFXYnhiZ0ZKOTBEa1VhMVJzMlR1UkROR2tIRldX?=
 =?utf-8?B?bGNzYlJTM2VqV05XcWpTQ084dTQya0xjeHlzQnZ1ZHNtOVo4S0FiMFd4Y21M?=
 =?utf-8?B?Rm5xOFdjeGhOT1ZiMWpuenVLRlV3ZUIxZ1c4WWZ4ZWxFbXJjRUFQMmQ5NVRO?=
 =?utf-8?B?eDByZ2x1VWp3TkRmV09GV1RMUCtnZ2Nzc3pvT20wdjBKWGdHMnlsK1pLNnZF?=
 =?utf-8?B?WElUWXVUczdsQ1pZamtnMnlnbjBYMm0vYTQ1L1N2d0l0VlNZMDRpVldtZnE3?=
 =?utf-8?B?L2txd0VsSTVidDJDOVJqb0t4ZFNWUHA1dE01Q1Z5cVZ3d1VjS1BGdExpQjBk?=
 =?utf-8?B?VXNXYnE5M0xVQjlqM1ZRcVZtcjFjVFp4VGRYSDA4WExLdzFvOVNNK201RlpE?=
 =?utf-8?B?ZlB3cWYxNzIwZHNGN0ljTXZJQkhyeStLNTNlT3QrNm5QUVN2UkppbUgwQ1NB?=
 =?utf-8?B?ODR0SE5qWTVoWkxIVm02T2I3bW85WVlPNEVzK2YwR0VNVFcwa200ODNMQXlr?=
 =?utf-8?B?WFE2ekNnQXNUVFBWc0Ryc2Znc0g3UlFnQVlGT2NoRWtCVjRvL2N0MnVHQzI2?=
 =?utf-8?B?T1h1UFhrYVIvNDJEdit5ZytBeHphY0x4OWdEak4vUXpoNWg0S09WbUpJOU5l?=
 =?utf-8?B?TGUyTEJINFVIQVRhT3VuRllXTUlscDBxdmNaR0s3U0pSTnlXaFhKa0FZSmY0?=
 =?utf-8?B?d3hIVzhWSXUzL2hicEJlclZ4THdwVUhXTXkveTZSeFhNbS9ZUHNmT01JYitB?=
 =?utf-8?Q?AO+LFvsi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d66c064-d6c4-4040-3c72-08d8c3ad62a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 16:54:32.6851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxqsV0KoHsEOpPciNzSyEe9aPT0+zu0WH/ll6q1DFb93QVXWsB78OYDUAtvc0UBVCRA+24C/92N4nbmR3Z0xmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3353
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
Cc: Alan.Harrison@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMjgvMjEgNToxNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyOC4wMS4y
MSB1bSAxNzowMSBzY2hyaWViIE5pcm1veToKPj4KPj4gT24gMS8yOC8yMSA0OjI1IFBNLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMjguMDEuMjEgdW0gMTY6MjEgc2NocmllYiBOaXJt
b3k6Cj4+Pj4KPj4+PiBPbiAxLzI4LzIxIDM6NDkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4+Pj4+IEFtIDI4LjAxLjIxIHVtIDE1OjM1IHNjaHJpZWIgTmlybW95IERhczoKPj4+Pj4+IEVu
YWJsZSBnZnggd2F2ZSBsaW1pdGluZyBmb3IgZ2Z4IGpvYnMgYmVmb3JlIHB1c2hpbmcgaGlnaCBw
cmlvcml0eQo+Pj4+Pj4gY29tcHV0ZSBqb2JzIHNvIHRoYXQgaGlnaCBwcmlvcml0eSBjb21wdXRl
IGpvYnMgZ2V0cyBtb3JlIHJlc291cmNlcwo+Pj4+Pj4gdG8gZmluaXNoIGVhcmx5Lgo+Pj4+Pgo+
Pj4+PiBUaGUgcHJvYmxlbSBoZXJlIGlzIHdoYXQgaGFwcGVucyBpZiB5b3UgaGF2ZSBtdWx0aXBs
ZSBoaWdoIAo+Pj4+PiBwcmlvcml0eSBqb2JzIHJ1bm5pbmcgYXQgdGhlIHNhbWUgdGltZT8KPj4+
Pgo+Pj4+Cj4+Pj4gQUZBSVUsIGluIHRoYXQgY2FzZSBxdWFudHVtIGR1cmF0aW9uIHdpbGwgY29t
ZSBpbnRvIGVmZmVjdC4gVGhlIAo+Pj4+IHF1ZXVlIGFyYml0ZXIgd2lsbCBzd2l0Y2gKPj4+Pgo+
Pj4+IHRvIG5leHQgaGlnaCBwcmlvcml0eSBhY3RpdmUgcXVldWUgb25jZSBxdWFudHVtIGR1cmF0
aW9uIGV4cGlyZXMuIAo+Pj4+IFRoaXMgc2hvdWxkIGJlIHNpbWlsYXIgdG8gd2hhdAo+Pj4+Cj4+
Pj4gd2UgYWxyZWFkeSBoYXZlLCBtdWx0aXBsZSBub3JtYWwgcHJpb3JpdHkgam9icyBzaGFyaW5n
IEdQVSAKPj4+PiByZXNvdXJjZXMgYmFzZWQgb24gQ1BfSFFEX1FVQU5UVU0uCj4+Pj4KPj4+PiBR
VUVVRV9EVVJBVElPTiByZWdpc3RlciB2YWx1ZS4KPj4+Cj4+PiBZZWFoLCBidXQgd2hlbiB0aGUg
Zmlyc3QgaGlnaCBwcmlvcml0eSBqb2IgY29tcGxldGVzIGl0IHdpbGwgcmVzZXQgCj4+PiBtbVNQ
SV9XQ0xfUElQRV9QRVJDRU5UX0dGWCBiYWNrIHRvIHRoZSBkZWZhdWx0IHZhbHVlLgo+Pj4KPj4+
IEhhdmUgeW91IGNvbnNpZGVyZWQgdGhhdD8KPj4KPj4KPj4gWWVzIEkgbmVlZCBiaXQgb2YgY2xh
cml0eSBoZXJlLiBJc24ndCBvbmUgZnJhbWUoLi4ucG00KHdhdmVfbGltaXQpLCAKPj4gcG00KElC
cyksIHBtNChyZXN0b3JlX3dhdmVfbGltaXQpLCAuLikKPj4KPj4gZXhlY3V0ZXMgdG9nZXRoZXIg
YXMgb25lIHVuaXQ/IElmIHRoYXQgaXMgdGhlIGNhc2UgdGhlbiB0aGUgbmV4dCBoaWdoIAo+PiBw
cmlvIGNvbXB1dGUgam9iIHdpbGwgc2V0IHRoZSB3YXZlIGxpbWl0Cj4+Cj4+IGFnYWluIGFuZCB3
aWxsIGJlIGFwcGxpZWQgZm9yIGl0cyBkaXNwYXRjaCBjYWxsLgo+Cj4gWWVhaCwgdGhhdCBpcyBj
b3JyZWN0LiBCdXQgdGhlIHByb2JsZW0gaXMgc29tZXdoZXJlIGVsc2UuCj4KPj4KPj4KPj4gSSBn
dWVzcyB0aGF0IGlzIG5vdCB0aGUgY2FzZSBiZWNhdXNlIHlvdSBhc2tlZCB0aGlzIHF1ZXN0aW9u
LiBEbyB5b3UgCj4+IHRoaW5rIHdlIHNob3VsZCBoYXZlIG9ubHkgb25lIGhpZ2ggcHJpb3JpdHkK
Pj4KPj4gcXVldWUgdGhlbj8KPgo+IFllcyBleGFjdGx5IHRoYXQuIElJUkMgd2UgY3VycmVudGx5
IGhhdmUgNCBsb3cgcHJpb3JpdHkgYW5kIDQgaGlnaCAKPiBwcmlvcml0eSBxdWV1ZXMuCj4KPiBU
aGUgcHJvYmxlbSBpcyB0aG9zZSA0IGhpZ2ggcHJpb3JpdHkgcXVldWVzLiBJZiB3ZSBvbmx5IHVz
ZSAxIHRoZW4gd2UgCj4gd29uJ3QgcnVuIGludG8gdGhpcyBhcyBmYXIgYXMgSSBjYW4gc2VlLgo+
CgpJIHNlZS4gSSB3aWxsIGFkZCBhbm90aGVyIHBhdGNoIHRvIGxpbWl0IGhpZ2ggcHJpbyBxdWV1
ZXMgdG8gb25lLgoKClJlZ2FyZHMsCgpOaXJtb3kKCgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+
Cj4+Cj4+Cj4+IEkgdHJpZWQgdG8gdGVzdCBpdCBieSBydW5uaW5nIHR3byBpbnN0YW5jZXMgb2Yg
c2FtZSB2dWxrYW4gdGVzdCAKPj4gYXBwbGljYXRpb24uIEkgY2FuJ3QgdHJhY2UKPj4KPj4gdHdv
IGFwcGxpY2F0aW9ucyB0b2dldGhlciB1c2luZyBSR1AuIEZyb20gdGhlIHRyYWNlIG9mIG9uZSAK
Pj4gYXBwbGljYXRpb24oYWxvbmcgd2l0aCBvdGhlciBydW5uaW5nIHRvZ2V0aGVyKSwKPj4KPj4g
SSBkaWRuJ3Qgc2VlIGFueSB0aHJvdHRsaW5nIGRvd24gb2YgaGlnaCBwcmlvcml0eSBjb21wdXRl
IGpvYih5ZWxsb3cgCj4+IGJhcnMpLgo+Pgo+Pgo+PiBMZXQgbWUga25vdyB3aGF0IGRvIHlvdSB0
aGluay4gSSB3aWxsIHdvcmsgd2l0aCBBbGFuIHRvIGNoYW5nZSB0aGUgCj4+IHRlc3QgYXBwbGlj
YXRpb24gc28gdGhhdCB3ZSBjYW4gdmVyaWZ5IHRoaXMKPj4KPj4gdXNpbmcgbXVsdGlwbGUgaGln
aCBwcmlvcml0eSBjb250ZXh0Lgo+Pgo+Pgo+PiBSZWdhcmRzLAo+Pgo+PiBOaXJtb3kKPj4KPj4+
Cj4+PiBUaGFua3MsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+Cj4+Pj4KPj4+PiBSZWdhcmRzLAo+
Pj4+Cj4+Pj4gTmlybW95Cj4+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+PiBDaHJpc3RpYW4KPj4+Pj4KPj4+
Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+
Cj4+Pj4+PiAtLS0KPj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jIHwgOSArKysrKysrKysKPj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KykKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2liLmMgCj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jCj4+Pj4+PiBpbmRleCAwMjRkMGE1NjNhNjUuLmVlNDg5ODlkZmI0YyAxMDA2NDQKPj4+Pj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4+Pj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4+Pj4gQEAgLTE5NSw2
ICsxOTUsMTAgQEAgaW50IGFtZGdwdV9pYl9zY2hlZHVsZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgCj4+
Pj4+PiAqcmluZywgdW5zaWduZWQgbnVtX2licywKPj4+Pj4+IMKgwqDCoMKgwqAgaWYgKChpYi0+
ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19FTUlUX01FTV9TWU5DKSAmJiAKPj4+Pj4+IHJpbmctPmZ1
bmNzLT5lbWl0X21lbV9zeW5jKQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmctPmZ1bmNz
LT5lbWl0X21lbV9zeW5jKHJpbmcpOwo+Pj4+Pj4gwqAgK8KgwqDCoCBpZiAocmluZy0+ZnVuY3Mt
PmVtaXRfd2F2ZV9saW1pdCAmJiBqb2IgJiYKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBqb2ItPmJh
c2Uuc19wcmlvcml0eSA+PSBEUk1fU0NIRURfUFJJT1JJVFlfSElHSCkKPj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCByaW5nLT5mdW5jcy0+ZW1pdF93YXZlX2xpbWl0KHJpbmcsIHRydWUpOwo+Pj4+Pj4g
Kwo+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAocmluZy0+ZnVuY3MtPmluc2VydF9zdGFydCkKPj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nLT5mdW5jcy0+aW5zZXJ0X3N0YXJ0KHJpbmcpOwo+Pj4+
Pj4gwqAgQEAgLTI5NSw2ICsyOTksMTEgQEAgaW50IGFtZGdwdV9pYl9zY2hlZHVsZShzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgCj4+Pj4+PiAqcmluZywgdW5zaWduZWQgbnVtX2licywKPj4+Pj4+IMKgwqDC
oMKgwqAgcmluZy0+Y3VycmVudF9jdHggPSBmZW5jZV9jdHg7Cj4+Pj4+PiDCoMKgwqDCoMKgIGlm
ICh2bSAmJiByaW5nLT5mdW5jcy0+ZW1pdF9zd2l0Y2hfYnVmZmVyKQo+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGFtZGdwdV9yaW5nX2VtaXRfc3dpdGNoX2J1ZmZlcihyaW5nKTsKPj4+Pj4+ICsK
Pj4+Pj4+ICvCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5lbWl0X3dhdmVfbGltaXQgJiYgam9iICYm
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgam9iLT5iYXNlLnNfcHJpb3JpdHkgPj0gRFJNX1NDSEVE
X1BSSU9SSVRZX0hJR0gpCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmluZy0+ZnVuY3MtPmVtaXRf
d2F2ZV9saW1pdChyaW5nLCBmYWxzZSk7Cj4+Pj4+PiArCj4+Pj4+PiDCoMKgwqDCoMKgIGFtZGdw
dV9yaW5nX2NvbW1pdChyaW5nKTsKPj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+PiDC
oCB9Cj4+Pj4+Cj4+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q25pcm1veS5kYXMlNDBh
bWQuY29tJTdDNjdlOTAzMzU3ZWUyNDdmOWNlYjAwOGQ4YzNhMGVmZGYlN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDc0NDQzMjg3MDA3OTMwJTdDVW5rbm93
biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJU
aUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPUV5b3VTVXZhS2pRSUlX
ZUtEaWxWcmE3M2lMMWViMHJwbmFVQ0RBSUR2WEElM0QmYW1wO3Jlc2VydmVkPTAgCj4+Pj4+Cj4+
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+PiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
YW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbmlybW95LmRhcyU0MGFtZC5jb20lN0M2N2U5MDMz
NTdlZTI0N2Y5Y2ViMDA4ZDhjM2EwZWZkZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2Mzc0NzQ0NDMyODcwMDc5MzAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4
ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhW
Q0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9RXlvdVNVdmFLalFJSVdlS0RpbFZyYTczaUwxZWIw
cnBuYVVDREFJRHZYQSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Pgo+Pj4KPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
