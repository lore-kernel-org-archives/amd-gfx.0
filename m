Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F95C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 21:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE59460230
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 21:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE59460230
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399196E047;
	Thu, 17 Jun 2021 21:52:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FE66E047
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 21:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkFFrj/UGWUIe2eGWvdEHJ58ZIuPSweobrn1PsZ/mhUKvlIsmjolVItJLYEwRE1p1YpGWUsW3B8Glp7uHPeZFlOVxd0bvT3Ha14Nh68J7EclhGDpXocOXJmfRQ4AD2nXeY98JjIafykyZi8MEusmWF97utf5CgZ4FhKnuZfzNH2bUN39IuwqFMW2/74aIo4YJtjVPup7/WHRQPrxGACC6xgbMEQe2AlnnSc/fn14YnKbWeBzfjZpj0724xMDZfbN4HwE8i/zZNJL2B6E0dvUwWerH6UmRtQmhQeMyG+l7ALZt197yOiDK7Z7s2FgndEV9m/kAdY4OE73MfFELgtAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INo17SPeya9uEPZm2qXS9OlkR14LHkDTkjeng4qznQs=;
 b=Wyv30QdkNHEnEcGLaE1RARP+8BihSQ9APar0ZT/y/0sRaRy1UwKRkHwSUINlDdBuwde57M2h9/zz6My6iLHfiyKJP1Z4OgycPBYHPDGLXvn0WOe8zoBSdk1lf73YRAwx5EzoyM299qAFjXI76CVnr1Ul91BOBEpMri2mKya/VaWcdZEYw4DPxj3PI4W3/A2xYigpwg3aj153busyZJDVKispopiT4HSZY/EUPrsd4jyrw1Tz6vGt0LhdoBod990lDUK7OQEq4sadB6c9KLs1z2BYGC2qReliBbyRdGr6iNvcuTBVZRtutsAKyPOEUxAm01oBvQD9VscqwxIxkzhPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INo17SPeya9uEPZm2qXS9OlkR14LHkDTkjeng4qznQs=;
 b=qb24sUd2cq4yB9xCRJBFsMPI7GUW8Zywv7fIKC+sHZRoYK1VThaLEoimiy7SQHYiV+WlK0w3uOx/LQA2sgqG9ojihtG9x7cFWQXURKfhJ5zDfVil8FAT68FSNbT4rqRT25oI5ws/gH86DzluF61lsorBgvZGlky3gKtH7SNkZ94=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 21:52:14 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 21:52:13 +0000
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix some double free when destroy
 queue fails
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210617120246.1730-1-xinhui.pan@amd.com>
 <037C33F6-4BC3-411A-A50D-7C0CA46FA367@amd.com>
 <C72C2F16-2810-4194-9FE7-03A5DFC69BDE@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <695a84ae-fb0d-ce62-5680-09ae8fd4581f@amd.com>
Date: Thu, 17 Jun 2021 17:52:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <C72C2F16-2810-4194-9FE7-03A5DFC69BDE@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 21:52:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 493878e5-d5f3-4217-3e01-08d931da2a9a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5083F8BD0777B945FED7FC94920E9@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0JjwIxLfzCLM2VIDiSlP1aJlTZIOdjzUaBrS5f678bANlRJvNrOy3fQzERgGRFJlysaWk7++m6S4IwLRPfoqW9MfwD3FxEzyWSwGs6HM42Huh9WfKUP5BEpJotz/PJQjV1WbQzQj7g+uF48edxFsDTb+2ie5lRBkTOt6ybl/MzuXpPPXriVk6mzhHX2bsULScHknl2R27PaPrIoZkgPc4leZqYsQs6+tQ0wY1hroxpqIX+fYG80icCPmcO6E7aVda5Cfz3LtTsh9nkcLJohZ2ILOjBVgqyq+PcLhNExTvzFIbMN5E6PClSc/+g7GMgQzpn9yyNYkmwXWendm44R+Cs2LPzGCUKoNm40un9rSJc/lmJSNje6V7aV6QxBTHtlTOyW9BKtwPvK7guTrFvwrC7am0qZ64OuydIrDQOpIbqFFSjxNsZxOtuRpvcbrOsMDOICi8NfV8i8DQ3aYS7DQDEz1nCsC5o3x1LVbdDEOzQFprVLP96HLXEndr4sidJxdhWkKMeeUpnE4wNM+KatcE4GQuxD6oF+S6x18e4Hu49Aaz0AD2s5VSYJLn+n2C+9FjnqvdUwfVvny0OKQ8TnH80ZsUz+JJ8GABSnhcccjzuFbKsA9PGF3f/gERGe41PLPfgidTwxKloTpeJHKq6AD7oNJtcVVV//k/ym+HZiBZBGz6MBVCPIwnHyXTFocpsr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(54906003)(44832011)(86362001)(5660300002)(8936002)(66946007)(2616005)(956004)(8676002)(6862004)(31696002)(186003)(26005)(31686004)(16526019)(478600001)(83380400001)(38100700002)(4326008)(36756003)(16576012)(6636002)(37006003)(316002)(2906002)(66476007)(66556008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk91dDhHTG5FdkxuZlp1dDVtUTdmT1g3UCtpUEdrQjdBeTFrRmJQYU0xZ0pX?=
 =?utf-8?B?dEIxS1NUanhRMS9XcW1BbFdSclR2SGgweGRIdk1hanZhSlVMcGZyTW5pdFMv?=
 =?utf-8?B?WGhjS1haRVhqYTJtbk10Q2QvWXU4eGJtWnptS0o1ZDJKS1pDUkpadHROMjFm?=
 =?utf-8?B?U2JvdnFRbXlEUnB1M3hBSzA1UVBXcExiQ3FoWGJMUzdjTFJUSm5qZ2YrUmJM?=
 =?utf-8?B?b0tWRlV3c2VhQjAwUzlnYkhOY1M0WjQzNnAwOWgxM3M2QVI4aGNDamlSM0xs?=
 =?utf-8?B?L1V5VkY0NlFVaUhnVmtnVldXbmE1ajdoUVJiZ09EbmI4OGJid2pQUFdhb2xQ?=
 =?utf-8?B?RzRaU1p0UnBiOTdxWGprZFJBaERDZ04rNzM2V3lRc3lFSkpDYkhKT2FibStF?=
 =?utf-8?B?NzdsVUZqQWFZUklWOUtTckpiQ3lSb283SkNBUkRIdGo1YWdic3FTbjV5aWRD?=
 =?utf-8?B?N2dxNHFKcnphU3poQm9DaVZLY1BwU2FpL0hjeGtZclVGV2tsN1JqN05GZTc2?=
 =?utf-8?B?czJQMDhEM1FValA4K2tOZUV6aXFrQzNONFZteGFBZm90Wmp2TkMxOFI0MEpo?=
 =?utf-8?B?eG9kaVVicE43d1pjK0R6SkF4b2hORngzb0JLQTRYOFNTOEpLdTNwYzZJSElp?=
 =?utf-8?B?Y3ZaTUlLWHN6UVhDamRGUHhwM1lvVmVFOWhVVDdtdVJjVWVQOEdnUC84eTho?=
 =?utf-8?B?WUZsSk1Ba1phb2dOaHMrbGFPNmh5WjYzTlVaSWdiZ3NoOXZOY3Y1dGk2d3lV?=
 =?utf-8?B?ZXp5c2JVUU5Ib0RjdEtXbXhDWVpkZ0NDcDYrcU9Ia2NIWlRWelVrNmVIcHhX?=
 =?utf-8?B?VzBNN00xUjBJWUV4T3hvb21oaUpzTXhLbno4THFMb0J2SHZ0SUxKdmtaS3Vr?=
 =?utf-8?B?ZkdQNjgyaU5UVjNjOGJhL3JlS2paYXpBQXZ3Uk9RemgvOHpYT2ZJeGIrcG8z?=
 =?utf-8?B?bVJ0Ti9zcXo2MmExS3RDZ0FPMG1LN3pkbjFmaUY2UFh6UVIzQ0o0ckErdHVB?=
 =?utf-8?B?M0F4RkRBUDAzZGtwdSs0YWd6bVZzMkd0RWFjREd0NHAxZzJBYmpLR0dmcVU0?=
 =?utf-8?B?QmFyK1VmcjQ5dkJPcXVWZVFUeEVlS1J4UWJTU2NTSlA1a3lUazczaUJBL1dz?=
 =?utf-8?B?Skl5OWVsTTRyMTgzd0o1WGE2SytHd3dDd1pGM05WY2svbXFpZE1GbllwNDhH?=
 =?utf-8?B?bGUyR1N3ZW53R2lRT2JXNlJsajczOUtwRmI5ZEFvbWpRTGRoakhiV0w1d0p4?=
 =?utf-8?B?ZjVrZElVNW5aSkM0WHRNdytVTWM0REx2Tnd2VXdPc3IrZkNneUtVK1o3R2Ez?=
 =?utf-8?B?WHdCb0NtVHNvVlpyaHBVY0xlS0xPeC8zY0dFSHIwN3c4L2VhbTR1NkxnbDB3?=
 =?utf-8?B?QWJmUkZOV0ZJejUvUzV6amFpVElMRGhRdHc5bDhiejc1QnVlNy8zbzdVTWdI?=
 =?utf-8?B?blZFL2xuZWJucFI1aG9mdUNzUkdBM1kwMUJJbUl0bmdDNWx2OFFEUU9aSTZj?=
 =?utf-8?B?YUlqT3hEaENEK203OFUxZ0VRdVFteWxhSlp4dWp4QTRhdFo3RGlFVm5XMFI2?=
 =?utf-8?B?Q3hhNUVIWVdNdXJiNEdTOW5IYS9WUkMxUGFZdGhPcXZUbzJXK21GSEFoS04z?=
 =?utf-8?B?WDd5bkd0UzdpNkgrYkk4VEZHTkNmYnc5aHFBQW5VaVNPaktid3ZpT0RmVU5u?=
 =?utf-8?B?em91M1pWNmMvVWI2a0ZoNk93UzZZdkt6UXdOMkZuTHRZaWxMd0RvRjFEUDdW?=
 =?utf-8?Q?q3VvO8Bp9Ks73BnAJfsv9uGs+irb+tN1AQ4xhBm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493878e5-d5f3-4217-3e01-08d931da2a9a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 21:52:13.8044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h586tg8+/yYdk1EQPPImEL05BCKZrJSoxhEsbKaf6aUR6ktatMQtadxatIxcZa76UHEJpPEM24OA/Zyeao/dPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0xNyB1bSA4OjQxIGEubS4gc2NocmllYiBQYW4sIFhpbmh1aToKPiBGZWxpeAo+
IFdoYXQgSSBhbSB3b25kcmVpbmcgaXMgdGhhdCBpZiBDUCBnb3QgaGFuZywgIGNvdWxkIHdlIGFz
c3VtZSBhbGwgdXNlcm1vZGUgcXVldWVzIGhhdmUgc3RvcHBlZD8KPiBJZiBzbywgd2UgY2FuIGRv
IGNsZWFudXB3b3JrIHJlZ2FyZGxlc3Mgb2YgdGhlIHJldHZhbCBvZiBleGVjdXRlX3F1ZXVlc19j
cHNjaCgpLgoKUmlnaHQuIFRoYXQncyB3aGF0IHdlIGN1cnJlbnRseSBkbyB3aXRoIEVUSU1FLCB3
aGljaCBoYXBwZW5zIHdoZW4gdGhlCmhhbmcgaXMgZmlyc3QgZGV0ZWN0ZWQuIEkgZG9uJ3Qga25v
dyB3aHkgd2UgbmVlZCB0byB0cmVhdCB0aGUgY2FzZQpkaWZmZXJlbnRseSB3aGVuIHdlJ3JlIGFs
cmVhZHkgaW4gYSByZXNldC4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+PiAyMDIx5bm0NuaciDE3
5pelIDIwOjEx77yMUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4g5YaZ6YGT77yaCj4+
Cj4+IEZlbGl4Cj4+IHdoYXQgSSBhbSB0aGlua2luZyBvZiBsaWtlIGJlbG93IGxvb2tzIGxpa2Ug
bW9yZSBzaW1wbGUuIDopCj4+Cj4+IEBAIC0xNTAxLDYgKzE1MDEsMTEgQEAgc3RhdGljIGludCBk
ZXN0cm95X3F1ZXVlX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+PiAg
ICAgICAgLyogcmVtb3ZlIHF1ZXVlIGZyb20gbGlzdCB0byBwcmV2ZW50IHJlc2NoZWR1bGluZyBh
ZnRlciBwcmVlbXB0aW9uICovCj4+ICAgICAgICBkcW1fbG9jayhkcW0pOwo+Pgo+PiArICAgICAg
IGlmIChkcW0tPmlzX2h3c19oYW5nKSB7Cj4+ICsgICAgICAgICAgICAgICByZXR2YWwgPSAtRUlP
Owo+PiArICAgICAgICAgICAgICAgZ290byBmYWlsZWRfdHJ5X2Rlc3Ryb3lfZGVidWdnZWRfcXVl
dWU7Cj4+ICsgICAgICAgfQo+PiArCj4+ICAgICAgICBpZiAocXBkLT5pc19kZWJ1Zykgewo+PiAg
ICAgICAgICAgICAgICAvKgo+PiAgICAgICAgICAgICAgICAgKiBlcnJvciwgY3VycmVudGx5IHdl
IGRvIG5vdCBhbGxvdyB0byBkZXN0cm95IGEgcXVldWUKPj4KPj4+IDIwMjHlubQ25pyIMTfml6Ug
MjA6MDLvvIxQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPiDlhpnpgZPvvJoKPj4+Cj4+
PiBIYW5kbGUgcXVldWUgZGVzdHJveSBmYWlsdXJlIHdoaWxlIENQIGhhbmcuCj4+PiBPbmNlIENQ
IGdvdCBoYW5nLCBrZmQgdHJpZ2dlciBHUFUgcmVzZXQgYW5kIHNldCByZWxhdGVkIGZsYWdzIHRv
IHN0b3AKPj4+IGRyaXZlciB0b3VjaGluZyB0aGUgcXVldWUuIEFzIHdlIGxlYXZlIHRoZSBxdWV1
ZSBhcyBpdCBpcywgd2UgbmVlZCBrZWVwCj4+PiB0aGUgcmVzb3VyY2UgYXMgaXQgaXMgdG9vLgo+
Pj4KPj4+IFJlZ2FyZGxlc3MgdXNlci1zcGFjZSB0cmllcyB0byBkZXN0cm95IHRoZSBxdWV1ZSBh
Z2FpbiBvciBub3QuIFdlIG5lZWQKPj4+IHB1dCBxdWV1ZSBiYWNrIHRvIHRoZSBsaXN0IHNvIHBy
b2Nlc3MgdGVybWluYXRpb24gd291bGQgZG8gdGhlIGNsZWFudXAKPj4+IHdvcmsuIFdoYXQncyBt
b3JlLCBpZiB1c2Vyc3BhY2UgdHJpZXMgdG8gZGVzdHJveSB0aGUgcXVldWUgYWdhaW4sIHdlCj4+
PiB3b3VsZCBub3QgZnJlZSBpdHMgcmVzb3VyY2UgdHdpY2UuCj4+Pgo+Pj4gS2ZkIHJldHVybiAt
RUlPIGluIHRoaXMgY2FzZSwgc28gbGV0cyBoYW5kbGUgaXQgbm93Lgo+Pj4KPj4+IFBhc3RlIHNv
bWUgZXJyb3IgbG9nIGJlbG93IHdpdGhvdXQgdGhpcyBwYXRjaC4KPj4+Cj4+PiBhbWRncHU6IENh
bid0IGNyZWF0ZSBuZXcgdXNlcm1vZGUgcXVldWUgYmVjYXVzZSAtMSBxdWV1ZXMgd2VyZSBhbHJl
YWR5Cj4+PiBjcmVhdGVkCj4+Pgo+Pj4gcmVmY291bnRfdDogdW5kZXJmbG93OyB1c2UtYWZ0ZXIt
ZnJlZS4KPj4+IENhbGwgVHJhY2U6Cj4+PiBrb2JqZWN0X3B1dCsweGU2LzB4MWIwCj4+PiBrZmRf
cHJvY2ZzX2RlbF9xdWV1ZSsweDM3LzB4NTAgW2FtZGdwdV0KPj4+IHBxbV9kZXN0cm95X3F1ZXVl
KzB4MTdhLzB4MzkwIFthbWRncHVdCj4+PiBrZmRfaW9jdGxfZGVzdHJveV9xdWV1ZSsweDU3LzB4
YzAgW2FtZGdwdV0KPj4+IGtmZF9pb2N0bCsweDQ2My8weDY5MCBbYW1kZ3B1XQo+Pj4KPj4+IEJV
RyBrbWFsbG9jLTMyIChUYWludGVkOiBHICAgICAgICBXICAgICAgICApOiBPYmplY3QgYWxyZWFk
eSBmcmVlCj4+PiBJTkZPOiBBbGxvY2F0ZWQgaW4gYWxsb2NhdGVfc2RtYV9tcWQrMHgzMC8weGIw
IFthbWRncHVdIGFnZT00Nzk2IGNwdT0yCj4+PiBwaWQ9MjUxMQo+Pj4gX19zbGFiX2FsbG9jKzB4
NzIvMHg4MAo+Pj4ga21lbV9jYWNoZV9hbGxvY190cmFjZSsweDgxZi8weDhjMAo+Pj4gYWxsb2Nh
dGVfc2RtYV9tcWQrMHgzMC8weGIwIFthbWRncHVdCj4+PiBjcmVhdGVfcXVldWVfY3BzY2grMHhi
Zi8weDQ3MCBbYW1kZ3B1XQo+Pj4gcHFtX2NyZWF0ZV9xdWV1ZSsweDI4ZC8weDZkMCBbYW1kZ3B1
XQo+Pj4ga2ZkX2lvY3RsX2NyZWF0ZV9xdWV1ZSsweDQ5Mi8weGFlMCBbYW1kZ3B1XQo+Pj4gSU5G
TzogRnJlZWQgaW4gZnJlZV9tcWRfaGlxX3NkbWErMHgyMC8weDYwIFthbWRncHVdIGFnZT0yNTM3
IGNwdT03Cj4+PiBwaWQ9MjUxMQo+Pj4ga2ZyZWUrMHgzMjIvMHgzNDAKPj4+IGZyZWVfbXFkX2hp
cV9zZG1hKzB4MjAvMHg2MCBbYW1kZ3B1XQo+Pj4gZGVzdHJveV9xdWV1ZV9jcHNjaCsweDIwYy8w
eDMzMCBbYW1kZ3B1XQo+Pj4gcHFtX2Rlc3Ryb3lfcXVldWUrMHgxYTMvMHgzOTAgW2FtZGdwdV0K
Pj4+IGtmZF9pb2N0bF9kZXN0cm95X3F1ZXVlKzB4NTcvMHhjMCBbYW1kZ3B1XQo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPj4+IC0tLQo+Pj4g
Li4uL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyAgIHwgMTMg
KysrKysrKysrKysrKwo+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3Mu
YyAgICAgICAgICAgIHwgIDQgKysrLQo+Pj4gLi4uL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzc19xdWV1ZV9tYW5hZ2VyLmMgIHwgIDIgKysKPj4+IDMgZmlsZXMgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4+PiBpbmRleCBjMDY5
ZmEyNTliMzAuLjYzYTlhMTlhMzk4NyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+Pj4gQEAgLTE1MzAs
NiArMTUzMCwxMSBAQCBzdGF0aWMgaW50IGRlc3Ryb3lfcXVldWVfY3BzY2goc3RydWN0IGRldmlj
ZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4+PiAJCQkJS0ZEX1VOTUFQX1FVRVVFU19GSUxURVJfRFlO
QU1JQ19RVUVVRVMsIDApOwo+Pj4gCQlpZiAocmV0dmFsID09IC1FVElNRSkKPj4+IAkJCXFwZC0+
cmVzZXRfd2F2ZWZyb250cyA9IHRydWU7Cj4+PiArCQkvKiBJbiBncHUgcmVzZXQ/IFdlIGxlYXZl
IHRoZSBxdWV1ZSBhcyBpdCBpcywgc28gZG8gTk9UCj4+PiArCQkgKiBjbGVhbnVwIHRoZSByZXNv
dXJjZS4KPj4+ICsJCSAqLwo+Pj4gKwkJZWxzZSBpZiAocmV0dmFsID09IC1FSU8pCj4+PiArCQkJ
Z290byBmYWlsZWRfZXhlY3V0ZV9xdWV1ZTsKPj4+IAkJaWYgKHEtPnByb3BlcnRpZXMuaXNfZ3dz
KSB7Cj4+PiAJCQlkcW0tPmd3c19xdWV1ZV9jb3VudC0tOwo+Pj4gCQkJcXBkLT5tYXBwZWRfZ3dz
X3F1ZXVlID0gZmFsc2U7Cj4+PiBAQCAtMTU1MSw2ICsxNTU2LDE0IEBAIHN0YXRpYyBpbnQgZGVz
dHJveV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwKPj4+Cj4+
PiAJcmV0dXJuIHJldHZhbDsKPj4+Cj4+PiArZmFpbGVkX2V4ZWN1dGVfcXVldWU6Cj4+PiArCS8q
IFB1dCBxdWV1ZSBiYWNrIHRvIHRoZSBsaXN0LCB0aGVuIHdlIGhhdmUgY2hhbmNlIHRvIGRlc3Ry
b3kgaXQuCj4+PiArCSAqIEZJWE1FOiB3ZSBkbyBOT1Qgd2FudCB0aGUgcXVldWUgaW4gdGhlIHJ1
bmxpc3QgYWdhaW4uCj4+PiArCSAqLwo+Pj4gKwlsaXN0X2FkZCgmcS0+bGlzdCwgJnFwZC0+cXVl
dWVzX2xpc3QpOwo+Pj4gKwlxcGQtPnF1ZXVlX2NvdW50Kys7Cj4+PiArCWlmIChxLT5wcm9wZXJ0
aWVzLmlzX2FjdGl2ZSkKPj4+ICsJCWluY3JlbWVudF9xdWV1ZV9jb3VudChkcW0sIHEtPnByb3Bl
cnRpZXMudHlwZSk7Cj4+PiBmYWlsZWRfdHJ5X2Rlc3Ryb3lfZGVidWdnZWRfcXVldWU6Cj4+Pgo+
Pj4gCWRxbV91bmxvY2soZHFtKTsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
b2Nlc3MuYwo+Pj4gaW5kZXggMDliOThhODNmNjcwLi45ODQxOTdlNTkyOWYgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+PiBAQCAtNjA3LDExICs2
MDcsMTMgQEAgc3RhdGljIGludCBrZmRfcHJvY2ZzX2FkZF9zeXNmc19maWxlcyhzdHJ1Y3Qga2Zk
X3Byb2Nlc3MgKnApCj4+Pgo+Pj4gdm9pZCBrZmRfcHJvY2ZzX2RlbF9xdWV1ZShzdHJ1Y3QgcXVl
dWUgKnEpCj4+PiB7Cj4+PiAtCWlmICghcSkKPj4+ICsJaWYgKCFxIHx8ICFrb2JqZWN0X2dldF91
bmxlc3NfemVybygmcS0+a29iaikpCj4+PiAJCXJldHVybjsKPj4+Cj4+PiAJa29iamVjdF9kZWwo
JnEtPmtvYmopOwo+Pj4gCWtvYmplY3RfcHV0KCZxLT5rb2JqKTsKPj4+ICsJLyogcGFpcmVkIHdp
dGggdGhlIGdldCBhYm92ZSAqLwo+Pj4gKwlrb2JqZWN0X3B1dCgmcS0+a29iaik7Cj4+PiB9Cj4+
Pgo+Pj4gaW50IGtmZF9wcm9jZXNzX2NyZWF0ZV93cSh2b2lkKQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYwo+Pj4g
aW5kZXggOTVhNmMzNmNlYTRjLi4wNTg4ZTU1MmI4ZWMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMKPj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYwo+
Pj4gQEAgLTM3Myw2ICszNzMsNyBAQCBpbnQgcHFtX2Rlc3Ryb3lfcXVldWUoc3RydWN0IHByb2Nl
c3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNpZ25lZCBpbnQgcWlkKQo+Pj4gCQlkcW0gPSBwcW4t
PmtxLT5kZXYtPmRxbTsKPj4+IAkJZHFtLT5vcHMuZGVzdHJveV9rZXJuZWxfcXVldWUoZHFtLCBw
cW4tPmtxLCAmcGRkLT5xcGQpOwo+Pj4gCQlrZXJuZWxfcXVldWVfdW5pbml0KHBxbi0+a3EsIGZh
bHNlKTsKPj4+ICsJCXBxbi0+a3EgPSBOVUxMOwo+Pj4gCX0KPj4+Cj4+PiAJaWYgKHBxbi0+cSkg
ewo+Pj4gQEAgLTM5Niw2ICszOTcsNyBAQCBpbnQgcHFtX2Rlc3Ryb3lfcXVldWUoc3RydWN0IHBy
b2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNpZ25lZCBpbnQgcWlkKQo+Pj4gCQlrZnJlZShw
cW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayk7Cj4+PiAJCXBxbi0+cS0+cHJvcGVydGllcy5jdV9t
YXNrID0gTlVMTDsKPj4+IAkJdW5pbml0X3F1ZXVlKHBxbi0+cSk7Cj4+PiArCQlwcW4tPnEgPSBO
VUxMOwo+Pj4gCX0KPj4+Cj4+PiAJbGlzdF9kZWwoJnBxbi0+cHJvY2Vzc19xdWV1ZV9saXN0KTsK
Pj4+IC0tIAo+Pj4gMi4yNS4xCj4+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
