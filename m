Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D8C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 20:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1D4222BB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 20:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1D4222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667EA6E14D;
	Mon, 14 Dec 2020 20:44:32 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760049.outbound.protection.outlook.com [40.107.76.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201D489369
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 20:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4CVjKpuAqhPijRRyz84sffs3k1OenZKp1VknY0uF8kGlxds5gULYot0B8NMVI8NISrfw0cZgrfr2TtyTeLAV37rLlTu3OEqmG3q6TuKkXkPcYj/QgIQKX9wa0KrHyCpNcd3sNqJaUfuM8/VNoWUsOpr2aMLSb1isYe2js/QPeIcAn5GW7b9CU66tYHzw33zAAJGxyqD88p7GxZnBwIoPRLFLylZ39YdJrCngej4QLsEeiugcGvRm6+g1hx+qSm1LxpzOPBR8ZJcXCP8m3tKIFEeaYGArHk92rLTa6fCPlsSCci9xudXLOZaDbv4ctUsoMteXLpSKJ90gFnddQSqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzvoTjuUVIl67fUqOLJfr5LF5AW6CEjwTMMIIljguWQ=;
 b=X9Wea2vdrRYV9jjc0KWVxzNSwh4kiYtXoea3zjqO3WE0wSsaN0Nmzst+id7LIb+107F0YvUqfDsUFZabUi1hPrvlrqay+kEK+gTtxC4Yv5du9xRxxJ306C5/5+YmfbY/TAiAC89umX846KOEL2TZD7UwgJkGBw62h2kPTMNk+74x6qMz5HoY+sk1lXayQ6slU53pqfoFECBRabWRKkI10NtgSd7S72pzGB54+q96xS0jzqE1bJDVq8p0OM3GFpk4Kr2uTX7yUwXRfglKURbnFJ0EHCDT+pFbA1JzscK916XfY3xunTkpHVp6BW9dNznXTQnITnmnxwHTkwyg9CG2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzvoTjuUVIl67fUqOLJfr5LF5AW6CEjwTMMIIljguWQ=;
 b=RsJHtiVgfOsCAad7w6z4DPT/VDhyM5NFCRpHOynMFxOCJp+3Oi4CsQavPgvt/xwFA7YH9QFS7B1CvmObUa5SqvfCcEj0FQu9eg0zLpJ6Hh+LB6XLDYFC4jTuSdJKilM8f0k35zV1zg4tnI9L6a7PYn4fxle1fwXoKLqJPkdjJPQ=
Authentication-Results: moreofthesa.me.uk; dkim=none (message not signed)
 header.d=none;moreofthesa.me.uk; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Mon, 14 Dec
 2020 20:44:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.024; Mon, 14 Dec 2020
 20:44:26 +0000
Subject: Re: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
To: amd-gfx@lists.freedesktop.org, Darren Salt <devspam@moreofthesa.me.uk>
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
 <20201211005506.4554-4-devspam@moreofthesa.me.uk>
 <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com>
 <58E2B73AC8%devspam@moreofthesa.me.uk>
 <1d482d3c-ef99-ffdf-84c6-61182fd0f757@gmail.com>
 <58E43922F8%devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e166d0df-ef79-4f72-e58d-8db807f4ae69@amd.com>
Date: Mon, 14 Dec 2020 21:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <58E43922F8%devspam@moreofthesa.me.uk>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:208:14::46) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:208:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 20:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fce2092b-40fa-421e-28e7-08d8a0710c30
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4360821D9914FA1D4544C9A383C70@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2LB6ccKIJ36+cLYFKcEMstOmkyCNn/L+Mb5b2/50Xw6K53t9LX1CRPiXwA9BzJQaW81F6Lvsq2OadbF/+ukm/iH0YY+OHCgn4lBgSprTsSDplYg+A9dSlRQg0rnv/XvLG7xeEIC9Wclg894HYt+VWfmK5akrmkR1CTDpoVZIhugxKoNmllaXa1xobjTiOPMiCKOZGmeEc0+cte0S1lkR/VBvhxuM22KW9lOGGJI5wYXR6X+41qfgTe2mS+oXB4UiYwkxF5npkRgJxSTQOoFv1nufGLdnkoEfkP3KEC1Boo0jL1W0BFIFOJvUTGTVLjGNlDVmnjIRRBtHS8DV6YLgrvuKne9jSiSJahMobMPneXDMqu7M0KiJ3hVAhf6r8eCXRPHFy6+LWIypzSi9+EHma1aZzvrg/iw4GU64JGNWTLF/lmrYqe8asnCOT60U+vx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(31686004)(36756003)(86362001)(52116002)(508600001)(5660300002)(83380400001)(6666004)(34490700003)(31696002)(2616005)(2906002)(6916009)(8936002)(66476007)(66946007)(66556008)(16526019)(186003)(6486002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U2ZWUnlobzltT0RUQnRJcVRTKzh0MmdrUFBmWFIzQzF3Z3BJVk5NZXhURHdq?=
 =?utf-8?B?OXJFdkJKQ0lISjBiSGdvRHFtZXdkNnFCU2JZeUFSaEF1U2FlSE5yTVV6NGZK?=
 =?utf-8?B?MEZXUWRwQmpIWk1DOUVBRkhsQTVaaUVLMEZ3ZEZWTUd5YUw0SVg0VE1mUTdl?=
 =?utf-8?B?eWs4NHl0b3laZlNzWm5qQjd1T254TW1aYjMxakdIWlo4VnpGV2Y2S3gwOGhV?=
 =?utf-8?B?RW44M2dadFNMS0xKYTNWdFYyaTZUZ1hRSjFPSk1aSGM5cURJZ25mdzZCaHNu?=
 =?utf-8?B?cUFiR1R4cXJSZHFmOWpnQmNUQkp2QXcwZFNKbzNIaDMxQ0JMcFordGgwUjEw?=
 =?utf-8?B?YWRHR0pYV2dRYVUyVWhjMWlaTDR6Tnp5R2RoMVIyK3lxWDh3eDFYMm9WM09B?=
 =?utf-8?B?ZFI3Ky8yMEgxazZsNi9xZXVkcmROdm9BdGRNSG14V3hqZUtJa1kzRWYwQ1ds?=
 =?utf-8?B?V1FHSWFtSFJwQmRxd2JXUjZhYTVpc1c3WHRuTGN5d0RUSVFtaFBBR29Ob1Y3?=
 =?utf-8?B?Y1Q2bnBQRC9vbmpncVdwUW5DZEpnVGlzQVVSUmViSVNNQTYzN3I3eVB1MWRW?=
 =?utf-8?B?cVU1ejdid3gvOCtreGwrMGkyMC9YbEd1QWdHY0ZYTThWK2xQamJlMjdvYktW?=
 =?utf-8?B?UHl2ZytkcGhHdG92NHRPQXRrTXhVZjRjRExNVERCN2JxK3pYRlF2aDdxaWcv?=
 =?utf-8?B?QmZ4bWVkWUtqdks5MHQ5ZkNwdW5VdDc0K21MNm1jRXJ4VVdkZk8vWlM5VnJR?=
 =?utf-8?B?c0VURkFYbmw3ZmVwTzBROWVIK0dBSWdwRmlpeVAxR0ZyVXVaeHJjUUFGUVJO?=
 =?utf-8?B?bCswNmdBWDJxYlcrbHNJZ2RtQmQ3ZE1WVVdYUkhMa2pJd2xGUHhsZDB0N0tk?=
 =?utf-8?B?V2JmYXVmbC9YRks3UEh2b3pkZUxXZSsvb0RDNVI2MnkxNStLN04yTFBabHNW?=
 =?utf-8?B?ZWV3NXJxUGJxOWw1M2RuSDd5WTNSa3VVS0VUaUsxQUc4V0k5Rm54eHVlVjk3?=
 =?utf-8?B?M2ZXbVp0NDFBNnNPYmlsVzJDNzFSOGZxcFJTdnlVOFpkcUhFNnlQSHFWYVBY?=
 =?utf-8?B?QUc1eitkVHNmc0ZNRGxwbVZ2MDFBZ1RFRG5RcWZlZFpUczgzZFFkejNWdEpq?=
 =?utf-8?B?RW1OZmdMb1h6RzhlNUtraGsrcjk3NHpQcWdtdWJmcE5uM2wyUlJvZkU3RzIz?=
 =?utf-8?B?K24zMGtQbExKU0lrci9BR2VWWlRHaE1Rc0tFMEM3a3NJRDBhbFRFSVBGKzdh?=
 =?utf-8?B?MDlyamZvN21RTVdGVmRQd0V5WExIV29UWThzUWxPbkpyVFdXZEJyWkhreUho?=
 =?utf-8?B?N21kZFBBSjZGdE56Y3FzN1BzdlhDMDJBMERWcloyVG83OTN1SEpZcU1JU1pD?=
 =?utf-8?B?Wk5wK3l4aDdKbTJnTlJ6SXZ5NmZkMFZMeVVlanZVcFd4MjhoTytKQXV0bEV2?=
 =?utf-8?Q?QvwTEWOS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 20:44:26.7617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: fce2092b-40fa-421e-28e7-08d8a0710c30
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfarRjgFS4xBPGFJD+Kx5EX1SR/YBzFh7LyyIu1laQYD1zWd67WBvXx7bMsBmRxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMTIuMjAgdW0gMTY6NDYgc2NocmllYiBEYXJyZW4gU2FsdDoKPiBJIGRlbWFuZCB0aGF0
IENocmlzdGlhbiBLw7ZuaWcgbWF5IG9yIG1heSBub3QgaGF2ZSB3cml0dGVuLi4uCj4KPj4gQW0g
MTEuMTIuMjAgdW0gMTg6MzEgc2NocmllYiBEYXJyZW4gU2FsdDoKPj4gPCBbU05JUF0KPj4+PiBJ
ZiB0aGF0IGlzbid0IHRoZSBjYXNlIHVzZSBmbHMoKSB0byBnZXQgdGhlIGhpZ2hlc3Qgc2V0IGJp
dCA8IDEzLgo+Pj4gVGhhdCBzdWdnZXN0cyB0aGF0IGl0J2xsIGJlIGVhc2llc3QgdG8gY2xlYXIg
ZWFjaCBiaXQgYWZ0ZXIgdGhlCj4+PiBjb3JyZXNwb25kaW5nIHNpemUgaXMgY2hlY2tlZCwgSSB0
aGluay4KPj4gT2ssIHdlbGwgeW91IGRvbid0IHNlZW0gdG8gdW5kZXJzdGFuZCBteSBjb25zdHJh
aW4gaGVyZTogTmV2ZXIgY2hlY2sKPj4gbW9yZSB0aGFuIG9uZSBzaXplIQo+IENoZWNraW5nIGNv
bnRleHQ6IGl0IGFwcGVhcmVkIHRvIGJlIHRoZSBmb3IoKSBzdGF0ZW1lbnQgaXRzZWxmIHJhdGhl
ciB0aGFuCj4gdGhlIHdob2xlIGxvb3AuIEl0IGRpZG4ndCBoZWxwIHRoYXQg4oCcdHJ5IGFuZCBl
cnJvcuKAnSBsb29rcyBsaWtlIOKAnHRyeSB0byBlcnJvcuKAnQo+IHRvIG1lOyBJIG5vdyB0aGlu
ayB0aGF0IHlvdSBtZWFudCDigJx0cmlhbCBhbmQgZXJyb3LigJ0uCgpJJ20gbm90IGEgbmF0aXZl
IHNwZWFrZXIgb2YgRW5nbGlzaCwgc28gYmVhciB3aXRoIG1lIGlmIEkgZ2V0IHN1Y2ggc3R1ZmYg
Cndyb25nLgoKPj4gRmluZCB0aGUgZmlyc3QgdmFsaWQgc2l6ZSB3aGljaCBpcyBnb29kIGZvciB5
b3UgYW5kIHRoZW4gdHJ5IHRvIHJlc2l6ZQo+PiB0byB0aGF0IG9uZSwgaWYgdGhpcyBkb2Vzbid0
IHdvcmsgYWJvcnQuCj4gU28sIGJhc2ljYWxseSwgc3RvcCBldmVuIHdoZW4gdGhlIG5leHQgc2l6
ZSBkb3duIHdvdWxkIGJlIGZpbmUsIGUuZy4gMTZHQiDihpIKPiA4R0IuIEp1c3QgYXMgd2VsbCB0
aGF0IHNpemUgbGltaXRpbmcgaXMgZG9uZSBpbiBhIGxhdGVyIHBhdGNoLCB0aG91Z2ggSQo+IHdv
bmRlciB3aGV0aGVyIHRoYXQgc2hvdWxkIGFsbG93IHBlci1HUFUgY29uZmlndXJhdGlvbiAobm90
IHNvbWV0aGluZyBmb3IKPiB0aGlzIHBhdGNoIHNlcmllcywgdGhvdWdoKS4KClllcywganVzdCB0
cnkgdGhlIHdob2xlIGRhbmNlIHdpdGggZXhhY3RseSBvbmUgc2l6ZSBhbmQgbm90IG11bHRpcGxl
IHRpbWVzLgoKPgo+Pj4gQWxzbywgdGhpcyBsb29rcyBsaWtlIGl0J3MgYWRkaW5nIGNvbXBsZXhp
dHkgdG8gdHJ5IHRvIG1ha2UKPj4+IHJhcmVseS1leGVjdXRlZCBjb2RlIHNsaWdodGx5IGZhc3Rl
ciBpbiBzb21lIGNhc2VzIChJIGNhbid0IHNlZSBpdAo+Pj4gaGVscGluZyB3aGVyZSBhdmFpbGFi
bGVfc2l6ZXMgPT0gMHgzRjAwLCBmb3IgZXhhbXBsZSkuCj4+IFRoZSBpbnRlbnRpb24gaGVyZSBp
cyBub3QgdG8gbWFrZSB0aGUgY29kZSBmYXN0ZXIsIGJ1dCB0byBwcmV2ZW50IGlzc3VlcyBvbgo+
PiBzeXN0ZW0gd2hlcmUgd2UgcHJvYmUgbXVsdGlwbGUgR1BVcyBhdCBvbmNlLgo+IFByZXN1bWFi
bHkgc2ltdWx0YW5lb3VzIHByb2JlcyBhbmQgcmFuZG9tIG9yZGVyaW5n4oCmCgpFeGFjdGx5LgoK
R29vZCBuZXdzIGlzIHRoYXQgSSB0aGluayBJJ3ZlIGZpZ3VyZWQgb3V0IHdoeSB0aGF0IGhhcHBl
bnMgYW5kIG91ciAKaGFyZHdhcmUvVkJJT1MgZW5naW5lZXJzIGFyZSBpbnZlc3RpZ2F0aW5nIG5v
dyB3aGF0J3MgdGhlIGJlc3QgYXBwcm9hY2ggCnRvIG1ha2UgdGhpbmtzIHdvcmsgYXMgaXQgc2hv
dWxkIDopCgpXZSBtb3N0IGxpa2VseSB3aWxsIGVuZCB1cCB3aXRoIGEgc3RhdGljIHF1aXJrIGZv
ciB0aGlzIApQQ0ktSUQvcmV2aXNpb24vYm9hcmQvbWFudWZhY3R1cmVyLgoKUmVnYXJkcywKQ2hy
aXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
