Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8494C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 16:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7550122D01
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 16:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7550122D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A98389913;
	Thu,  7 Jan 2021 16:10:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EAB89913
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 16:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZvEhTR0PgEMQ0N+7QnLqKSH1zFtcLTPA8m1nUfjOvE4Qzha9iUvUXIvb7aJfrSwdQAvgiFbOmyq7nhMVgmxQ6y4TDjfFTXLIiY30wy2o0CPh1FLE7H+xGRcV7MuRnEbHWq6v1ZZBS+n7yK8Nf0IHuQjigbGK0JAhZRd+zSkAtxmm3/qqxBDIk1Dr/hGD7hbcnxigt+LmAlzNpqpjgOqjRZ/i/hZKBXpnDETy4+klOBjwUhAZckg9SUL023FK1684yWRmmyOLv/HfBTKEXDTRC1K7v2iw+ybU66V2B8/M9jduQPCzZk+1kRMb3ZMP+6BwfjBOBewRb66f8pe9e4Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6km0WqaIXumyOjB1PvwZCRK+xum98XbqHmI4qEXViM=;
 b=PZDAVBHxbMPGZ8Ec+QoX9B6RqGcZ+wR94EbSBJr5hkmFMVm0zSfgUqVWGOeng4mgd4o1yUglZ1KUpFPuUaUptgdKmNc4GZYCJ8CLl1uALsUAOazrwuRMUPgdhQ3zJIZilb6P0J2KUgPqlKj8wMNXWdxHKKkcLwD4iibv6Yn+2dh4gJ6e/XxDhzPUaQ7yzLZDoqXAlo3rHhzDPzyagQhE0Xd7GOwx3QJBUKvc9RA1D4XzRiy2xipczMB/vuPl+7d3NFFGZ4AYYO9TrgrbynLxn6gugQvJo7DBZLvP1IT4GZRc6pISEa4DRMi7Py0aoQvIG6/U2wf9Lzi3qs5mqCxixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6km0WqaIXumyOjB1PvwZCRK+xum98XbqHmI4qEXViM=;
 b=hJJINM+Jixbloa9J0hNwftv/O0HYT8XkUCvh2yV2dbpKRkHYn8obgLKhasPHPAQmSkTd8CD26a3UcZIiC/0QuHIT8eVCCpQMnoREwlqDNPsc59YSSbfoZVz6umt92ZKS78Kycyi3fP1kdrVKMINDC/XF4BUz1Y8Tomqbkn+SOnI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 16:10:23 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 16:10:23 +0000
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
 <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
 <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
 <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
 <CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com>
 <66dc40b3-caed-6b3d-899d-32d1d0f74239@gmail.com>
 <f2009e7d-6fe5-0a55-0c37-8b0b2ca2c45c@froggi.es>
 <77444d7b-e8c4-16e3-6348-e322af9db103@amd.com>
 <f831126b-c31e-96cd-b056-0902d6d0d5cc@froggi.es>
 <02c779e3-4e17-3afa-6b3f-9b5284254f55@amd.com>
 <4ff7da1d-2f30-7364-cd1a-4267240bc4bf@froggi.es>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5b489918-7c15-d4f7-a0fa-e2b1994e07d2@amd.com>
Date: Thu, 7 Jan 2021 17:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <4ff7da1d-2f30-7364-cd1a-4267240bc4bf@froggi.es>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR06CA0134.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::39) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0134.eurprd06.prod.outlook.com (2603:10a6:208:ab::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 16:10:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f45a998-c89e-424a-111d-08d8b326bd15
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40959F65F6810379EFF8B07183AF0@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FcbIlIAzKb8iK3OzHz0W1cdLGSjPyN3U60cQ8bTmONsEgaCXfZg2QsdCBSvYxX+1xa4Ri2gUz0ZYHEVQcU6gd/qtyvrzDMukJRMb0C1+y5dRkl9Mkx4cp7Ht6z01tq4HNojqgTaRptDV4cF63oqg/YxlQsOZM2+bNLGmE3AzkIwBSV8SZh9SB2mZ4NQ9ZwqIfAdEPg/CkQFtiw9rpvhnoI9+Sqi9QRF69qq3ze8/cSvRpG9W53mT+Gj3c/ykUkGecZhi1QqcNckBbfRWwQ+NhvSiVv3Uj6SPFY4SzI38A+Prc97Z7z+0Ax8LF+GcbcN2h7toOvamiuGEsOEhRYjvkS9BKRV0Bn+JwqxhIkrq5WCNYqckMmUozlt2SfosqvEPaN1L27DW+slk0qSoWMB41tTZMy2kE22M3OxIuk8FG5RCPlI9etLx969uGiWyG+VeBGALKUBSkmStPSoeipIj/IM+T5H3pXE0SdjAv0mRdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(8936002)(8676002)(6666004)(6486002)(31686004)(2616005)(54906003)(5660300002)(4326008)(53546011)(16526019)(83380400001)(186003)(66574015)(316002)(2906002)(31696002)(52116002)(110136005)(36756003)(478600001)(66476007)(66556008)(86362001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXlRSmp5WVdDcmRLbnZYMitGUnlycksxNUlEeFV3N29UVDhJUTdHenIxM1F4?=
 =?utf-8?B?b1Ewc0dsbnJMdzA3bzE3NktTMXJ3UmlNTmE2bXg3SFdRb2k3TEYxRXdDZnVo?=
 =?utf-8?B?NTJ0MEY4YndoZlBBa3Q4T3lwODZMQy9WUFo4NmtBYXNiZ09KTVpNSC9Rejha?=
 =?utf-8?B?bkJqdHdEeFRVM2pGTVcwODdsdzdBdGhDelRFY2VLNWxhei9WTEJNTHVaMWNK?=
 =?utf-8?B?aEE3VC9xTkFuL25xa0szVHBobk1TVmhDVXNNS0RJcHRRd0JmR21IbDBxNnA0?=
 =?utf-8?B?SGtGWFdESVk5ZUpFUWQ3WUMyQ1d3YzdYUnM1cDVkQVZZMDdTNGNXQlV1eTRQ?=
 =?utf-8?B?UndsL05rNGs3SkIrYklsWS9paUVlV0oraUUvTFJ0TDc5YndENXB0TmdmOFor?=
 =?utf-8?B?blBHb2ZpdEN3TjZENUlWeHdFbkRmZGpOUzczYWhiclViTG9xQ1hoWm92cFVv?=
 =?utf-8?B?ZDFlMUY4enNKNmdhT2xmYUhoYkFWVlZWTXdQVUdla1p1SmZERUk2cWNNbGdh?=
 =?utf-8?B?R1pNbjR0QmwvVHVhbWdWSjlMTGVFbWg1M25yQisxcE9jbFBweEltSkVKaVB5?=
 =?utf-8?B?bENNWE53eE44VXNWSjc4aGFlZG1wMzh4b0dFcGUyVlVwQXA4RjVTeGFudVdj?=
 =?utf-8?B?b0RzejhtT0lOd0kvNk04TVJNaGNiZ3FnQ3hWRXpDcVR5RmVDR29hZkcvRFR1?=
 =?utf-8?B?K0QreTVsbVEraWM5TGI5RkZKRFVTa2tZQUwwck4yVVBDNXUxdmxodkpvWXAv?=
 =?utf-8?B?OTVtc1IyRlo0KzdNRWhsb2JlV2EzZmlCZTJJQ05scmF2MnEzekl5akR3OW5T?=
 =?utf-8?B?OG81MzdXRFRvekJnYm9pM05nMXRxSld2SUloRnphTFhoTXJKN1ZZUGN2UWpm?=
 =?utf-8?B?UzVzS0h6N0ZJYUVxUWRkeGh0NkNmQ2dLZ3pMZXFKU0Nhc2NEZkhrL0RtQjlo?=
 =?utf-8?B?c2RvS2NqUGY5aTNDeUF6V09IUDg3Um9vUWJlSkp0ZUFHUTF3eXQxZmJwb2Nx?=
 =?utf-8?B?aGxVUnlSQTdqUzZxM2U4TnhPbjJpQkNMSFA1TTlqZ0JFWFpza3cybjN6bGtC?=
 =?utf-8?B?V3ZaZ3RVOFBEVDM0L3Y5UndHeURBV3c2SyswVFJlK1JteDU2T3dXaS9UNU96?=
 =?utf-8?B?K2s4dThXUUY0cnIzYjQ1MDVGUk56Qnl2T0orUVJMQWV3cU1MNlNDT2NiM0J6?=
 =?utf-8?B?S29XbjdBWSthRUtpOUVaNTc1ZkxRenNta1dBZUpLMVVTdDdCVno1ZVp0RnpE?=
 =?utf-8?B?ZVI5aXRwK2RSTmNkVjNjQ2JqR1ZyOHQvbHorWlpWRzlvalVEMTZXRVhpdndG?=
 =?utf-8?B?SFU1RU1mRExYNW1VVDBWLzM4VkhXSXFvcFVXbnlFbHVEUzVZd25WRzZWZDRZ?=
 =?utf-8?B?UGt5aDY0ZDJsTXJWbEFhSXY0cTE1ckRvRlJvSC9NUWxMZzlWMXlnOVZzR2tB?=
 =?utf-8?Q?Dl9qDlBQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 16:10:23.4589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f45a998-c89e-424a-111d-08d8b326bd15
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CyaMQuij5rFX+shIx594mKKsISkXRH5dZpq3ig/w2yENR2PSYoatFyyDCtMJyGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDEuMjEgdW0gMTg6MDQgc2NocmllYiBKb3NodWEgQXNodG9uOgo+Cj4KPiBPbiAxLzYv
MjEgMjo1OSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDYuMDEuMjEgdW0gMTU6
MTggc2NocmllYiBKb3NodWEgQXNodG9uOgo+Pj4gW1NOSVBdCj4+Pj4+Pj4gRm9yIFZ1bGthbiB3
ZSAoYm90aCBSQURWIGFuZCBBTURWTEspIHVzZSBHVFQgYXMgdGhlIHRvdGFsIHNpemUuIAo+Pj4+
Pj4+IFVzYWdlIGluIG1vZGVybiBnYW1lcyBpcyBlc3NlbnRpYWxseSAiYmluZGxlc3MiIHNvIHRo
ZXJlIGlzIG5vIAo+Pj4+Pj4+IHdheSB0byB0cmFjayBhdCBhIHBlci1zdWJtaXNzaW9uIGxldmVs
IHdoYXQgbWVtb3J5IG5lZWRzIHRvIGJlIAo+Pj4+Pj4+IHJlc2lkZW50LiAoYW5kIGV2ZW4gd2l0
aCB0cmFja2luZyBhcHBsaWNhdGlvbnMgYXJlIGFsbG93ZWQgdG8gCj4+Pj4+Pj4gdXNlIGFsbCB0
aGUgbWVtb3J5IGluIGEgc2luZ2xlIGRyYXcgY2FsbCwgd2hpY2ggd291bGQgYmUgCj4+Pj4+Pj4g
dW5zcGxpdHRhYmxlIGFueXdheSAuLi4pCj4+Pj4+Pgo+Pj4+Pj4gWWVhaCwgdGhhdCBpcyBhIHJl
YWxseSBnb29kIHBvaW50Lgo+Pj4+Pj4KPj4+Pj4+IFRoZSBpc3N1ZSBpcyB0aGF0IHdlIG5lZWQg
c29tZSBsaW1pdGF0aW9uIHNpbmNlIDMvNCBvZiBzeXN0ZW0gCj4+Pj4+PiBtZW1vcnkgaXMgd2F5
IHRvIG11Y2ggYW5kIHRoZSBtYXggdGV4dHVyZSBzaXplIHRlc3QgaW4gcGlnbGl0IGNhbiAKPj4+
Pj4+IGNhdXNlIGEgc3lzdGVtIGNyYXNoLgo+Pj4+Pj4KPj4+Pj4+IFRoZSBhbHRlcm5hdGl2ZSBp
cyBhIGJldHRlciBPT00gaGFuZGxpbmcsIHNvIHRoYXQgYW4gYXBwbGljYXRpb24gCj4+Pj4+PiB3
aGljaCB1c2VzIHRvIG11Y2ggc3lzdGVtIG1lbW9yeSB0aHJvdWdoIHRoZSBkcml2ZXIgc3RhY2sg
aGFzIGEgCj4+Pj4+PiBtb3JlIGxpa2VseSBjaGFuY2UgdG8gZ2V0IGtpbGxlZC4gQ2F1c2UgY3Vy
cmVudGx5IHRoYXQgaXMgZWl0aGVyIAo+Pj4+Pj4gWCBvciBXYXlsYW5kIDooCj4+Pj4+Pgo+Pj4+
Pj4gQ2hyaXN0aWFuLgo+Pj4+Pgo+Pj4+PiBBcyBJIHVuZGVyc3RhbmQgaXQsIHdoYXQgaXMgYmVp
bmcgZXhwb3NlZCByaWdodCBub3cgaXMgZXNzZW50aWFsbHkgCj4+Pj4+IG1heCh2cmFtIHNpemUs
IDNHaUIpIGxpbWl0ZWQgYnkgMy80dGhzIG9mIHRoZSBtZW1vcnkuIFByZXZpb3VzbHksIAo+Pj4+
PiBiZWZvcmUgdGhlIHJldmVydCB3aGF0IHdhcyBiZWluZyB0YWtlbiB3YXMganVzdCBtYXgoM0dp
QiwgMy80dGhzKS4KPj4+Pj4KPj4+Pj4gSWYgeW91IGhhZCA8IDNHaUIgb2Ygc3lzdGVtIG1lbW9y
eSB0aGF0IHNlZW1zIGxpa2UgYSBiaXQgb2YgYW4gCj4+Pj4+IGlzc3VlIHRoYXQgY291bGQgZWFz
aWx5IGxlYXQgdG8gT09NIHRvIG1lPwo+Pj4+Cj4+Pj4gTm90IHJlYWxseSwgYXMgSSBzYWlkIEdU
VCBpcyBvbmx5IHRoZSBtZW1vcnkgdGhlIEdQVSBjYW4gbG9jayBhdCAKPj4+PiB0aGUgc2FtZSB0
aW1lLiBJdCBpcyBwZXJmZWN0bHkgcG9zc2libGUgdG8gaGF2ZSB0aGF0IGxhcmdlciB0aGFuIAo+
Pj4+IHRoZSBhdmFpbGFibGUgc3lzdGVtIG1lbW9yeS4KPj4+Pgo+Pj4+IEluIG90aGVyIHdvcmRz
IHRoaXMgaXMgKm5vdCogdG8gcHJldmVudCB1c2luZyB0byBtdWNoIHN5c3RlbSAKPj4+PiBtZW1v
cnksIGZvciB0aGlzIHdlIGhhdmUgYW4gYWRkaXRpb25hbCBsaW1pdCBpbnNpZGUgVFRNLiBCdXQg
Cj4+Pj4gaW5zdGVhZCB0byBoYXZlIGEgcmVhc29uYWJsZSBsaW1pdCBmb3IgYXBwbGljYXRpb25z
IHRvIG5vdCB1c2UgdG8gCj4+Pj4gbXVjaCBtZW1vcnkgYXQgdGhlIHNhbWUgdGltZS4KPj4+Pgo+
Pj4KPj4+IFdvcnRoIG5vdGluZyB0aGF0IHRoaXMgR1RUIHNpemUgaGVyZSBhbHNvIGFmZmVjdHMg
dGhlIG1lbW9yeSAKPj4+IHJlcG9ydGluZyBhbmQgYnVkZ2V0aW5nIGZvciBhcHBsaWNhdGlvbnMu
IElmIHRoZSB1c2VyIGhhcyAxR2lCIG9mIAo+Pj4gdG90YWwgc3lzdGVtIG1lbW9yeSBhbmQgM0dp
QiBzZXQgaGVyZSwgdGhlbiAzR2lCIHdpbGwgYmUgdGhlIGJ1ZGdldCAKPj4+IGFuZCBzaXplIGV4
cG9zZWQgdG8gYXBwbGljYXRpb25zIHRvby4uLgo+Pgo+PiBZZWFoLCB0aGF0J3MgaW5kZWVkIHBy
b2JsZW1hdGljLgo+Pgo+Pj4KPj4+IChPbiBBUFVzLCkgd2UgcmVhbGx5IGRvbid0IHdhbnQgdG8g
ZXhwb3NlIG1vcmUgR1RUIHRoYW4gc3lzdGVtIAo+Pj4gbWVtb3J5LiBBcHBzIHdpbGwgZWF0IGlu
dG8gaXQgYW5kIGVuZCB1cCBzd2FwcGluZyBvciBydW5uaW5nIGludG8gCj4+PiBPT00gb3Igc3dh
cHBpbmcgKnZlcnkqIHF1aWNrbHkuIChJIGltYWdpbmUgdGhpcyBpcyBsaWtlbHkgd2hhdCB3YXMg
Cj4+PiBiZWluZyBydW4gaW50byBiZWZvcmUgdGhlIHJldmVydC4pCj4+Cj4+IE5vLCB0aGUgaXNz
dWUgaXMgdGhhdCBzb21lIGFwcGxpY2F0aW9ucyB0cnkgdG8gYWxsb2NhdGUgdGV4dHVyZXMgd2F5
IAo+PiBhYm92ZSBzb21lIHJlYXNvbmFibGUgbGltaXQuCj4+Cj4+PiBBbHRlcm5hdGl2ZWx5LCBp
biBSQURWIGFuZCBvdGhlciB1c2VyIHNwYWNlIGRyaXZlcnMgbGlrZSBBTURWTEssIHdlIAo+Pj4g
Y291bGQgbGltaXQgdGhpcyB0byB0aGUgc3lzdGVtIG1lbW9yeSBzaXplIG9yIDMvNHRocyBvdXJz
ZWx2ZXMuIAo+Pj4gQWx0aG91Z2ggdGhhdCdzIGtpbmRhIGdyb3NzIGFuZCBJIGRvbid0IHRoaW5r
IHRoYXQncyB0aGUgY29ycmVjdCAKPj4+IHBhdGguLi4KPj4KPj4gT2ssIGxldCBtZSBleHBsYWlu
IGZyb20gdGhlIG90aGVyIHNpZGU6IFdlIGhhdmUgdGhpcyBsaW1pdGF0aW9uIAo+PiBiZWNhdXNl
IG90aGVyd2lzZSBzb21lIHRlc3RzIGxpa2UgdGhlIG1heGltdW0gdGV4dHVyZSBzaXplIHRlc3Qg
Zm9yIAo+PiBPcGVuR0wgY3Jhc2hlcyB0aGUgc3lzdGVtLiBBbmQgdGhpcyBpcyBpbmRlcGVuZGVu
dCBvZiB5b3VyIHN5c3RlbSAKPj4gY29uZmlndXJhdGlvbi4KPj4KPj4gV2UgY291bGQgb2YgY291
cnNlIGFkZCBhbm90aGVyIGxpbWl0IGZvciB0aGUgdGV4dHVyZSBzaXplIGluIAo+PiBPcGVuR0wv
UkFEVi9BTURWTEssIGJ1dCBJIGFncmVlIHRoYXQgdGhpcyBpcyByYXRoZXIgYXdrd2FyZC4KPj4K
Pj4+Pj4KPj4+Pj4gQXJlIHlvdSBoaXR0aW5nIG9uIHNvbWV0aGluZyBzbWFsbGVyIHRoYW4gMy80
dGhzIHJpZ2h0IG5vdz8gSSAKPj4+Pj4gcmVtZW1iZXIgdGhlIHNvdXJjZSBjb21taXQgbWVudGlv
bmVkIHRoZXkgb25seSBoYWQgMUdpQiBvZiBzeXN0ZW0gCj4+Pj4+IG1lbW9yeSBhdmFpbGFibGUs
IHNvIHRoYXQgY291bGQgYmUgcG9zc2libGUgaWYgeW91IGhhZCBhIGNhcnZlb3V0IAo+Pj4+PiBv
ZiA8IDc4Nk1pQi4uLgo+Pj4+Cj4+Pj4gV2hhdCBkbyB5b3UgbWVhbiB3aXRoIHRoYXQ/IEkgZG9u
J3QgaGF2ZSBhIHRlc3Qgc3lzdGVtIGF0IGhhbmQgZm9yIAo+Pj4+IHRoaXMgaWYgdGhhdCdzIHdo
YXQgeW91IGFyZSBhc2tpbmcgZm9yLgo+Pj4KPj4+IFRoaXMgd2FzIG1haW5seSBhIHF1ZXN0aW9u
IHRvIHdob2V2ZXIgZGlkIHRoZSByZXZlcnQuIFRoZSBxdWVzdGlvbiAKPj4+IHRvIGZpbmQgb3V0
IHNvbWUgZXh0cmEgaW5mbyBhYm91dCB3aGF0IHRoZXkgYXJlIHVzaW5nIGF0IHRoZSB0aW1lLgo+
Pgo+PiBZb3UgZG9uJ3QgbmVlZCBhIHNwZWNpZmljIHN5c3RlbSBjb25maWd1cmF0aW9uIGZvciB0
aGlzLCBqdXN0IHRyeSB0byAKPj4gcnVuIHRoZSBtYXggdGV4dHVyZSBzaXplIHRlc3QgaW4gcGln
bGl0Lgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4KPiBJIHNlZS4uLiBJIGhhdmUgbm90
IG1hbmFnZWQgdG8gcmVwcm9kdWNlIGEgaGFuZyBhcyBkZXNjcmliZWQgaW4gdGhlIAo+IHJldmVy
dCBjb21taXQsIGJ1dCBJIGhhdmUgaGFkIGEgc29mdCBjcmFzaCBhbmQgZGVsYXkgd2l0aCB0aGUg
T09NIAo+IGtpbGxlciBlbmRpbmcgWC5vcmcgYWZ0ZXIgYSBsaXR0bGUgYml0IHdoZW4gR1RUID4g
c3lzdGVtIG1lbW9yeS4KPgo+IEkgdGVzdGVkIHdpdGggbWF4LXRleHR1cmUtc2l6ZSBvbiBib3Ro
IFJlbm9pciBhbmQgUGljYXNzbyB0aGUgCj4gZm9sbG93aW5nIGNvbmRpdGlvbnM6Cj4gMTZHaUIg
UkFNICsgMTIgR2lCIEdUVCAtPiB0ZXN0IHdvcmtzIGZpbmUKPiAxNkdpQiBSQU0gKyA2NCBHaUIg
R1RUIC0+IE9PTSBraWxsZXIga2lsbHMgWC5vcmcgYWZ0ZXIgYSBsaXR0bGUgYml0IG9mIAo+IHdh
aXRpbmcgKHBpZ2xpdCBkaWVkIHdpdGggaXQpCj4gMiBHaUIgUkFNICsgMS41R2lCIEdUVCAtPiB0
ZXN0IHdvcmtzIGZpbmUKPgo+IEkgYWxzbyB0ZXN0ZWQgb24gbXkgUmFkZW9uIFZJSSBhbmQgaXQg
d29ya2VkIGZpbmUgcmVnYXJkbGVzcyBvZiB0aGUgCj4gR1RUIHNpemUgdGhlcmUsIGFsdGhvdWdo
IHRoYXQgY2FyZCBoYXMgbW9yZSB0aGFuIGVub3VnaCB2aWRlbyBtZW1vcnkgCj4gYW55IHdheSBm
b3Igbm90aGluZyB0byBiZSBhbiBpc3N1ZSB0aGVyZSDwn5C4Lgo+IExpbWl0aW5nIG15IHN5c3Rl
bSBtZW1vcnkgdG8gMkdpQiwgdGhlIGNhcmQncyBtZW1vcnkgYW5kIHZpc2libGUgCj4gbWVtb3J5
IHRvIDFHaUIgYW5kIHRoZSBHVFQgdG8gMS43NUdpQiwgdGhlIHRlc3Qgd29ya3MgZmluZS4KPgo+
IFRoZSBvbmx5IHRpbWUgSSBldmVyIGhhZCBwcm9ibGVtcyB3aXRoIGEgY3Jhc2ggb3IgcGVzdWRv
LWhhbmcgKHdhaXRpbmcgCj4gZm9yIE9PTSBraWxsZXIgYnV0IHRoZSBzeXN0ZW0gd2FzIGxvY2tl
ZCB1cCkgd2FzIHdoZW5ldmVyIEdUVCB3YXMgPiAKPiBzeXN0ZW0gbWVtb3J5IChpZS4gaW4gdGhl
IHJldmVydGVkIGNvbW1pdCkKPgo+IElmIEkgZWRpdGVkIG15IGNvbW1pdCB0byB1bml2ZXJzYWxs
eSB1c2UgMy80dGhzIG9mIHRoZSBzeXN0ZW0gbWVtb3J5IAo+IGZvciBHVFQgZm9yIGFsbCBoYXJk
d2FyZSwgd291bGQgdGhhdCBiZSBjb25zaWRlcmVkIHRvIGJlIG1lcmdlZD8KCldlbGwgbWF5YmUg
MS8yIGFuZCBvbmx5IG9uIEFQVXMuIEFuZCB5b3UgbmVlZCB0byBmaW5kIHNvbWVib2R5IHdpdGgg
CmFub3RoZXIgUmF2ZW4gdG8gdGVzdCB0aGF0LiBNYXliZSBOaXJtb3kgaGFzIHRpbWUgZm9yIHRo
aXMuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gVGhhbmtzIQo+IC0gSm9zaGllIPCfkLjinKgK
Pgo+Pgo+Pj4KPj4+IC0gSm9zaGllIPCfkLjinKgKPj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
