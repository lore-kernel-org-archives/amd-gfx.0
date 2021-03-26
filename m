Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC08EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 08:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CDA61A43
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 08:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CDA61A43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DD46F382;
	Fri, 26 Mar 2021 08:51:05 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690089.outbound.protection.outlook.com [40.107.69.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0449B6EF31
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 08:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+tJNZhOp6R9Al6DKs4N8fiYTFGyw7w15dfceVqRk8bl0RxpWWFMD5IlZJl/+vnPuVvAcyb/44J4XscCMD4NG89iJVe0/xqsc16G5bXWZWTKwLPcC/s0TEG2Az+TPgUqdw/SIMw5Bkty8HrHvk9fMTCKOjkvlR6uWnv5j2gpDQtI69/mvm5gUAg9Q/7eENLe/oMPZaw5rI4Af25NefNspr3fYhgUypYq0dUHu8GKh3Dqbr+x3pNsQ7x54mHQT2o/KX7f/4HVX7iUZmNiEmxUQsM8GG/2obYPiUCNlPOn0gdU2ewgBd5Pd8PZKJhumLy8U11mJMWX/NU7iCYY51cPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDVP6AO1k53n/pQn633PJ/udxLsjwn7l9K67+3pX0sY=;
 b=n7LnLazo+tOE5l+Bb2n2JRHgjD6Uo6/G5Grif1O3Y/YFvSXugV/57z3HKhhi47lMqdsHA/Y1Jam9juBxptdMtFwtbkFH64+c64q91ji/1xNriQXJ156yRW8XAW157vSN4MoGEaR9B6pbWnsLSlQRWphHZQtlNRk5h8BkJyQiRS1ULcCU6ImqDY7Tn6MWGzF7ylLkaYyTdw1ACCT2FdkJdXai2AyfDS6nOItyMC+FOBidUtMr1Tusln5N4JQpjmYFtLGLXsLNyoNe4xfJ9udwseZDhhMjoKnmkcWuG50AK9yDXtVxXTJcy1xzoyijE10JnQO8Zlk+BvpEccQ4ma6hjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDVP6AO1k53n/pQn633PJ/udxLsjwn7l9K67+3pX0sY=;
 b=EoQtmMW6JE0KGYdYRt0QxajYcgD+FvOItNAxvlHR9trq8OYrxW7u4aqnHFQyXkni2E202wRT1HAdaTAxPcDbXBZtwXd+1EHEexls36DgkcpKp0/MKTls7vztc25Sty4McHPn5nyjn3n0cJwr+gltDMkBtH22tRMcWmCixQ3N6HQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 08:51:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 08:51:02 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
 <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
 <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
 <94b1e462-eff6-77f3-f0c4-1ae99f02a178@amd.com>
 <7c4be3bd-8d73-bd8d-3eed-9ddc68a9c364@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6bfefd19-ca3f-72d4-6d29-34f2f4885aab@amd.com>
Date: Fri, 26 Mar 2021 09:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <7c4be3bd-8d73-bd8d-3eed-9ddc68a9c364@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:f5e9:4efc:3566:86b9]
X-ClientProxiedBy: AM8P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f5e9:4efc:3566:86b9]
 (2a02:908:1252:fb60:f5e9:4efc:3566:86b9) by
 AM8P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 08:51:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fa013c6-f93a-4822-0fde-08d8f03448dc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB474085A44C1A7BACDCED395B83619@BL0PR12MB4740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmAL9p+edUrrXj8bFScLItNHCOud+6wsmBaqb73h+OO5rBAI51jdqNJ9A2BH9EPKGL5wKrgvRBwO+dlKIJHVTeg0Jvpk7LYUOe1dPAW3Hnn7tehgAH5nErPdXJSBu1FHtcx0BlGGgYYIsiYv6B39ybGD371uqEtLW8dlYTCD0F2Lp9Ws8IJvffgZuyPvskFuCpPkANCRHVkFBTOu8gqj8dRGYhMw8hG3mTtGKwN6oKCXC0PkyLL6xVf8gl8sakwk4KUEleezKhiNu9Zs38iJIuCho98MHjHzN5wxEk8C7+JD13G88VdjKOdGYIdy2tW70fiBtU0SRh4PwPe9BK402NNXVijJH6jF+boBFU8jEFIROUUbRHqHyoPD6Aur+5vq2vcOa8Dgzwgtb7LWUfyl5cL3ygnVKji5OUq1oz7sTdx/g4xgwIcy3R3UanNt8NAYxDNFrFG2EPwg40SLjV4yuZelnRCfaiDyva94u9kgpqjw28wn+JOB8KArmuL5P0AArNK1VQLgpLrsZg+/gcWC7h/nmtfz/7CsXTb+uMLed7aUlxadqmiW3Ug8Cos0PvTqpf6L9dutn0zJLaEHU9wHiifLOapQlAPpaZzSQrIgIfJeZpuQdvjGupYQNWYoVGaMcD65oDboXsySS9NXhK8zQGNYUrzU8kT99Yg6cwQ/WX4tCfD/8Vc6ijOgMBHPkRARLaHAr4jUj/4I4nk/m4Zjtwm+Q6tDVSOQOaXcsPJkWDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(478600001)(8676002)(38100700001)(2616005)(2906002)(6486002)(86362001)(16526019)(6666004)(36756003)(31696002)(316002)(8936002)(52116002)(31686004)(66946007)(186003)(66556008)(83380400001)(110136005)(66574015)(5660300002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlUrK0dnaGNzSzdsUGNYMzZERG1WcGhPTG94UW1mYk1QMmt2dXhNQnNQUmJI?=
 =?utf-8?B?Q0xYQ2xwTjZMRkJveFh6cU94eGlIbDM0WXZXS05kOHBaSTdVRlRzR0JablpM?=
 =?utf-8?B?OFU2VW5oc1V3ckdOOUJ3Z2Vad3B6YUp4ci9yVEpqYTI0ZUJhR2dheUNRV2t4?=
 =?utf-8?B?YzlvQzJuWU4wN0xCWDVEeWVsYklRN0JzcmVCeWpnQ1hxUFVNUlpwZFM2OTFJ?=
 =?utf-8?B?NW1qcFVVR1RVUG1qemZLWUdJSmwwQ2dxYnRQcncvNkxGSndNS1NwVzV3d212?=
 =?utf-8?B?OUdaUjhwU29Qb3AxbGFOUE5JUzhUZlcvU3BHa2hKK0dtWTJkd2VjTWhpZ1c4?=
 =?utf-8?B?aFB1QmVTRFZLQW92bTFUVGR5OXh6bHNuZGo1S3BpVmlya1doaWFIbXVBUHpk?=
 =?utf-8?B?cm5HdzVVa3h3V1FrUEswMFlvK3RHNTcvTWtRb081MXprMGY0RDUzSWxTSzJY?=
 =?utf-8?B?eFZ3eUZwdFdGOGNDZzg5cndtdG1vYUMyYmFWZzhGOHdKVjNUa29YcVN0YXZn?=
 =?utf-8?B?MWplZWF0cmJmMlBySnpSRFRnQjlkU0tpdUE2ZE9DMWxDc25vc0RwbDlJYmlJ?=
 =?utf-8?B?dTN0Z1BBZzZVV2xIMDduUWVkWjJtL2ZEU3I4bmFXRkQzNHdFR0xQclQ3VFZu?=
 =?utf-8?B?L09QN0hMdDlmVFJQODhRbjFCejNsUjJ3QVY2cFNkaW43QVJHMndmZGNSbEJq?=
 =?utf-8?B?dGdWUlcrbmNJS1VnN1dsczZ2U3NYNUNUajNBRitsL3YrU2FBbXhhWkhDeUs3?=
 =?utf-8?B?SVl2bUhnelNXc0V4b2w0NUpYYzlFK2ZTYmQzYVJNWldpMkgrZmt0T0pGaFJw?=
 =?utf-8?B?TktIeHlFbEdkZjRBdEgxWGZFMkhwbmFCMTVEVEJZN1FEWVlrZHpsYWd3VlJZ?=
 =?utf-8?B?ZXhRbG5BT0JWQ21CbXBiL29iRWdOTDJPVjJYdmJ1b2x1eVVSTnVIYU1ieXJN?=
 =?utf-8?B?K2tNbnNSSCtTTXYxVUdEMUZGbEtwb3JUZk1JNG1oYllZWi9WQ3VBUUxFc2V3?=
 =?utf-8?B?R3MvZnhGQ3RPVjQwUmJ0NEhXYjA2TXFnVWlxblNnRDg1K2JEbXYyN3ZvVkk5?=
 =?utf-8?B?Q2Y3VzNwWEFuYXkxa2I5RnM1b0YrRzBOdWlWYUxhKzQwWms0dlh5cFhHU2JD?=
 =?utf-8?B?QXZ5MXpPVUl1Ry9mU3dxOFRjdXVGVUlNb1hhL1lCeVZtWWkrajRWTDhmT0RX?=
 =?utf-8?B?OWNKaENBbFBCSVRNcVNEam9tclkvZVlvZWhVaWx6QkMycWdnOG9DblV1QUlE?=
 =?utf-8?B?OGhIcFBkOURja0ZFdXdtQWp6OFBEaGJaUnNoaDQ3MG1aKzhJZjl6Y2Y2Q0Y5?=
 =?utf-8?B?Y0ozZS9iZ0MzQnpxZE5SK0wrY0tnejVxYVVCQUZCYTl5blZRR0NKcXNSQS9L?=
 =?utf-8?B?RFA0MjBjK2ZLTTgvNWV0anZxZVo0SGF0WU82UDM0WnhhWmpwcUFiUnBvdGNv?=
 =?utf-8?B?V3Y1QU45aGNMcE1aVldlQlBuZ3BXZlBRL2pxZ2ZDOU11ZlRMU3NtOGhFYXVl?=
 =?utf-8?B?cG96VTNnTktMWWlzbmpKUTYwM2tlVUJVTnUxcnh2cDgwTjFhZGV4N2pOemVq?=
 =?utf-8?B?cjU4ZlZjbXpETnBXSTBIZHRTTW1SZk01RjFCazhZdGVWOGlJL0IvSC9FWHd2?=
 =?utf-8?B?TFI5c1E4dTZHcEs4aXBtOWJqTm9HUitpZVFZNjhvS1hZY3NJQ3crcnNraFM5?=
 =?utf-8?B?SG5nZDJLS1dQSFErSEFQZ2cwSS9GOFcvOFU3WWkwdUJNMXhOOExYNFl0Rm9t?=
 =?utf-8?B?MHNFeURYMUhCZ0FqN3QwQytSakttQUVCdkNJbUVSeFgzNkF0NXdYYXNCL1pQ?=
 =?utf-8?B?dmlTazVSK0RyV25Bbm1iaXVDdnRreGFLNW5CejVBdEZZTDF5WVhOYm1PUDJ2?=
 =?utf-8?Q?BS36P8Yl/d9wZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa013c6-f93a-4822-0fde-08d8f03448dc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 08:51:02.5611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpmBfZmdO8wnPu3wIpJyDG39LJfi4QPonZJpz43zP/TnfnZepSnUjmwjy7AkTNkz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4740
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

CgpBbSAyNS4wMy4yMSB1bSAxNzoyOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEFtIDIwMjEt
MDMtMjUgdW0gMTI6MjIgcC5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+Pj4+Pj4gTXkg
aWRlYSBpcyB0byBjaGFuZ2UgdGhlIGFtZGdwdV92bV91cGRhdGVfbWFwcGluZyBpbnRlcmZhY2Ug
dG8gdXNlCj4+Pj4+Pj4gc29tZQo+Pj4+Pj4+IGhpZ2gtYml0IGluIHRoZSBwYWdlc19hZGRyIGFy
cmF5IHRvIGluZGljYXRlIHRoZSBwYWdlIHR5cGUuIEZvciB0aGUKPj4+Pj4+PiBkZWZhdWx0IHBh
Z2UgdHlwZSAoMCkgbm90aGluZyByZWFsbHkgY2hhbmdlcyBmb3IgdGhlIGNhbGxlcnMuIFRoZQo+
Pj4+Pj4+ICJmbGFncyIgcGFyYW1ldGVyIG5lZWRzIHRvIGJlY29tZSBhIHBvaW50ZXIgdG8gYW4g
YXJyYXkgdGhhdCBnZXRzCj4+Pj4+Pj4gaW5kZXhlZCBieSB0aGUgaGlnaCBiaXRzIGZyb20gdGhl
IHBhZ2VzX2FkZHIgYXJyYXkuIEZvciBleGlzdGluZwo+Pj4+Pj4+IGNhbGxlcnMKPj4+Pj4+PiBp
dCdzIGFzIGVhc3kgYXMgY2hhbmdpbmcgZmxhZ3MgdG8gJmZsYWdzIChhcnJheSBvZiBzaXplIDEp
LiBGb3IKPj4+Pj4+PiBITU0gd2UKPj4+Pj4+PiB3b3VsZCBwYXNzIGEgcG9pbnRlciB0byBhIHJl
YWwgYXJyYXkuCj4+Pj4+PiBZZWFoLCBJJ3ZlIHRob3VnaHQgYWJvdXQgc3R1ZmYgbGlrZSB0aGF0
IGFzIHdlbGwgZm9yIGEgd2hpbGUuCj4+Pj4+Pgo+Pj4+Pj4gUHJvYmxlbSBpcyB0aGF0IHRoaXMg
d29uJ3Qgd29yayB0aGF0IGVhc2lseS4gV2UgYXNzdW1lIGF0IG1hbnkgcGxhY2VzCj4+Pj4+PiB0
aGF0IHRoZSBmbGFncyBkb2Vzbid0IGNoYW5nZSBmb3IgdGhlIHJhbmdlIGluIHF1ZXN0aW9uLgo+
Pj4+PiBJIHRoaW5rIHNvbWUgbG93ZXIgbGV2ZWwgZnVuY3Rpb25zIGFzc3VtZSB0aGF0IHRoZSBm
bGFncyBzdGF5IHRoZSBzYW1lCj4+Pj4+IGZvciBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgcmFuZ2Vz
LiBCdXQgaWYgeW91IHVzZSB0aGUgaGlnaC1iaXRzIHRvCj4+Pj4+IGVuY29kZQo+Pj4+PiB0aGUg
cGFnZSB0eXBlLCB0aGUgcmFuZ2VzIHdvbid0IGJlIGNvbnRpZ3VvdXMgYW55IG1vcmUuIFNvIHlv
dSBjYW4KPj4+Pj4gY2hhbmdlIHBhZ2UgZmxhZ3MgZm9yIGRpZmZlcmVudCBjb250aWd1b3VzIHJh
bmdlcy4KPj4+PiBZZWFoLCBidXQgdGhlbiB5b3UgYWxzbyBnZXQgYWJzb2x1dGVseSB6ZXJvIFRI
UCBhbmQgZnJhZ21lbnQgZmxhZ3MKPj4+PiBzdXBwb3J0Lgo+Pj4gQXMgbG9uZyBhcyB5b3UgaGF2
ZSBhIGNvbnRpZ3VvdXMgMk1CIHBhZ2Ugd2l0aCB0aGUgc2FtZSBwYWdlIHR5cGUsIEkKPj4+IHRo
aW5rIHlvdSBjYW4gc3RpbGwgZ2V0IGEgVEhQIG1hcHBpbmcgaW4gdGhlIEdQVSBwYWdlIHRhYmxl
LiBCdXQgaWYgb25lCj4+PiBwYWdlIGluIHRoZSBtaWRkbGUgb2YgYSAyTUIgcGFnZSBoYXMgYSBk
aWZmZXJlbnQgcGFnZSB0eXBlLCB0aGF0IHdpbGwKPj4+IGJyZWFrIHRoZSBUSFAgbWFwcGluZywg
YXMgaXQgc2hvdWxkLgo+PiBZZWFoLCBidXQgY3VycmVudGx5IHdlIGRldGVjdCB0aGF0IGJlZm9y
ZSB3ZSBjYWxsIGRvd24gaW50byB0aGUKPj4gZnVuY3Rpb25zIHRvIHVwZGF0ZSB0aGUgdGFibGVz
Lgo+Pgo+PiBXaGVuIHlvdSBnaXZlIGEgbWl4ZWQgbGlzdCB0aGUgY2hhbmNlIGZvciB0aGF0IGlz
IGp1c3QgY29tcGxldGVseSBnb25lLgo+IEN1cnJlbnRseSB0aGUgZGV0ZWN0aW9uIG9mIGNvbnRp
Z3VvdXMgcmFuZ2VzIGlzIGluIGFtZGdwdV92bV91cGRhdGVfbWFwcGluZzoKPgo+PiBpZiAobnVt
X2VudHJpZXMgPiBBTURHUFVfR1BVX1BBR0VTX0lOX0NQVV9QQUdFKSB7IHVpbnQ2NF90IHBmbiA9
Cj4+IGN1cnNvci5zdGFydCA+PiBQQUdFX1NISUZUOyB1aW50NjRfdCBjb3VudDsgY29udGlndW91
cyA9Cj4+IHBhZ2VzX2FkZHJbcGZuICsgMV0gPT0gcGFnZXNfYWRkcltwZm5dICsgUEFHRV9TSVpF
OyB0bXAgPSBudW1fZW50cmllcwo+PiAvIEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7IGZv
ciAoY291bnQgPSAyOyBjb3VudCA8IHRtcDsgKytjb3VudCkKPj4geyB1aW50NjRfdCBpZHggPSBw
Zm4gKyBjb3VudDsgaWYgKGNvbnRpZ3VvdXMgIT0gKHBhZ2VzX2FkZHJbaWR4XSA9PQo+PiBwYWdl
c19hZGRyW2lkeCAtIDFdICsgUEFHRV9TSVpFKSkgYnJlYWs7IH0gbnVtX2VudHJpZXMgPSBjb3Vu
dCAqCj4+IEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7IH0KPiBJZiBhIHBhZ2UgdHlwZSBj
aGFuZ2VzIGZyb20gb25lIHBhZ2UgdG8gdGhlIG5leHQsIGl0IHdpbGwgZW5kIGEKPiBjb250aWd1
b3VzIHJhbmdlIGFuZCBjYWxsIGludG8gdGhlIGxvd2VyIGxldmVsIChhbWRncHVfdm1fdXBkYXRl
X3B0ZXMpLgo+IEkgZG9uJ3QgdGhpbmsgYW55dGhpbmcgbmVlZHMgdG8gY2hhbmdlIGluIGFtZGdw
dV92bV91cGRhdGVfcHRlcywgYmVjYXVzZQo+IGFsbCBwYWdlcyBjb250aWd1b3VzIHBhc3NlZCB0
byBpdCB1c2UgdGhlIHNhbWUgcGFnZSB0eXBlLCBzbyB0aGUgc2FtZQo+IGZsYWdzLiBBbmQgdGhl
IGV4aXN0aW5nIGNvZGUgaW4gYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nIGFscmVhZHkgZG9lcwo+
IHRoZSByaWdodCB0aGluZy4gSSBob25lc3RseSBkb24ndCBzZWUgdGhlIHByb2JsZW0uCgpCdXQg
dGhlbiB5b3UgY291bGQgYWxzbyBqdXN0IGNhbGwgYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nKCkg
bXVsdGlwbGUgCnRpbWVzIGZlZWRpbmcgaXQgZnJvbSB3aGF0ZXZlciBkYXRhIHN0cnVjdHVyZSB5
b3UgdXNlIGluIHRoZSBITU0gY29kZS4KClVzaW5nIHRoZSBwYWdlIGFycmF5IHNvdW5kcyBsaWtl
IGFuIGludGVybWVkaWF0ZSBkYXRhIHN0cnVjdHVyZSB0byBtZSAKeW91IG9ubHkgY3JlYXRlZCB0
byBmZWVkIGludG8gYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nKCkuCgpSZWdhcmRzLApDaHJpc3Rp
YW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlh
bi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
