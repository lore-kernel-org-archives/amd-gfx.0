Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760B464E64
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760B464E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3268C89EA3;
	Mon, 15 Mar 2021 13:08:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB9E89F1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 13:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a25Tz9tYIqAv6xQ2W0YFCdcwVOziq2oplTjbwpJcpHcfsAYkJTLYV0Ql+ab2eBad+HmVBctIVuyWSBw/OeUnDciXqiDH+6vgxOo5wKhd2ZOde02yVxIHRnI+iCvQ1/1ADcmB10wfWmE6n7MKVcHyrCut7oV3DW/qtNzC7Onoe88WZHkyk/1LkpajE0JjaSjctHwlgqj3ydZBXVriuXDhW/GYiX2l8hOvsGMdYgo8sWh3fKj64FD+tCRfNcZXIR6smQ2f2b9ALmplG9RRtTTG0fxch8otWDJGDaCMKXPg1BXbhgsdDqX39vWnnRjSBMgbPE4VlXaAwgCttWaQFOCG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/8kERtBOfQIrsvmzOo/WY9NjIYJnfC9epHeRxYMzt0=;
 b=R2JM2pHV5SYHQ9kBg1hFkjD3F1H9N6i6TSGS+y3QyFjZnyiz7lCMl7ULv8K3IegklLG2hZbsQpTlwNFTgtRHBeF94TEu2GheDTeOHKpM7iiwS9aUOJlk4QQfNU7Ldce5xlAF7ubq0IxcUzxsJqhsEunRRatNpWmvagN3koNnDzqtl+wCsQprCjMH0rFFZmgGgS1aF4GDO8GphoZVdLxN7XJTAOU+npHiRhY9TDx3MA5aFjdqIqAeQi7VUPiPeod6zpTv5wglE7bHBkrM0TM99Ew3se8x3Jcwaw9cTXnTmCO2f0ziZZBODTl03SpVV7TXoNje67I6CQcokLUNh1MvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/8kERtBOfQIrsvmzOo/WY9NjIYJnfC9epHeRxYMzt0=;
 b=uNd4y/3L+T7kWQFPMqZOgipYR9Jgsp1R+o1rTwRgQFOj9fWhnnAvMzKFJPfDxEhJRN78K3mqw4S7JdSI7ZDoSJ1AzSWQ5lZKAr3dzjl8ygZBQyiTMy6Fyl6yWfFrWtqWDNuz29KPqr6njpi+oXt/3CL4tu3G8zRCoYKiXqjlFDI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 13:08:46 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 13:08:46 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Fix resource cursor initialization
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210313024351.10908-1-Felix.Kuehling@amd.com>
 <20210313024351.10908-3-Felix.Kuehling@amd.com>
 <84a69b44-6d5b-7068-f88f-889c252472c9@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <aec5a6f2-6b1b-18b1-6297-c24ad8673657@amd.com>
Date: Mon, 15 Mar 2021 09:08:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <84a69b44-6d5b-7068-f88f-889c252472c9@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.118.192.89]
X-ClientProxiedBy: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.118.192.89) by
 YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 13:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70da6a9c-0bbe-49b4-fd26-08d8e7b37764
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45366B0C9AB8CC8762223527926C9@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU7TZCHYWPMYrVGRo9+2MyY+ALfMK0+OQ/VJJdzCYzISLbLuR0OQIp+NAdLeIwLiAMbtRlOXsxvilsIhZqrez+CPkbAUJ8dBI3B4wTMC4/9aEAqhdI4hXanWzi8K3Ye6U4VIiPutTaEFtAADLgAGYPw+bzmy1pnx0zKde/8TNqf5/l3ibPQ4RVzycQKinV/Kd0JUiN0wpDVHu4kOZ8lvgJaqkK6FatyW1vhQlUlXvK9PLZr+CmJSqE3L41t3SgIQ3gylwETVK3vrfo64Z13e7xF5/LcPuMADFr/XX6UQPDl8a1Jtsc/3AhdMwyDCvoohuBnuZa0PSAKrzLewWkp28906EUwvd0ofXcVOBwBo81lSeH6NuRQQ0vz/ToeosxLjymZomSNDrI9vnz9aMTnDm6Sp49vV3xPlkSRnZW4r9cgn4Tv73Ql9bQtGiRAZLPObagbNIgi57ExaeWyBAHdjc6onOmSgEWX5I6TivBBVfiHOafSAqLZMpuyl6TByZThaquzysqT2pl6JFUAW/cDQQ7OU36chFYUDUlveFB0F/OHriMd4SjwmlSAEstARs+BuUSg+n/OaC78Vvk06mneoAvOYx8fal21uViz/dCngoOdl2jImp3ahmh447yTHuv4IT8B9b4YNbhkz5u1qVzJFEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(31696002)(4326008)(66946007)(2906002)(86362001)(52116002)(6486002)(8676002)(5660300002)(8936002)(16526019)(66476007)(66574015)(83380400001)(66556008)(31686004)(36756003)(26005)(44832011)(2616005)(316002)(16576012)(478600001)(956004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N1prNmM0eXpwajZsUTZ3U1JXUTQxTGJaQUl1L0Q5TCtJZXVlSnhSUUN3REVm?=
 =?utf-8?B?Z0UxVk00YS9NOHJZZjBSQ3gyRTczc2d1WHJ5MkJjZjl3TGFHeUNWRlQrK0R4?=
 =?utf-8?B?OFJyK2JXOTYwQVpHTm5QMFZYdk4yTVFpY0JSRk5GTk9GYWx4WGRITG93Vjhi?=
 =?utf-8?B?UlhvN01tRElQK1c1d3U4MHRNcUxZUnFtZ2l1dG1DTm14YTlXNUxudDhka2Vk?=
 =?utf-8?B?VHVKREdIeThadVFZSHd6NVR0dldQb3E2SWZpR2FwTG14c1VyTC9MOFdIMWxH?=
 =?utf-8?B?cWM3N2tSdTlWREhhRkh1QkR3S0V3alpCeTZKTVVPMm04NHJlQWlYSTJoQkhQ?=
 =?utf-8?B?czRJQmVKVW9PWDZqZmdPMzgxSURxa3B2RjVPY09lRlpDWmVwaDd3cXU4QTIw?=
 =?utf-8?B?ZitDYW02cVNFWWlNV1dpQ2lueUlqTkdncVM4cDJLQzF0S0tja0UvbVNscm41?=
 =?utf-8?B?bDgzRlcwbk5VRDJJQjdWN1JpYXhqcThUQ01LWFo5dWg0R2w1WUdUMkU5RFhY?=
 =?utf-8?B?ZEJGbFoxUSszdmo1RDFwWmVTOXF5dHk4MzdFY21iZHhTeGl1MUtDeE1TTUg1?=
 =?utf-8?B?UGovS1VuRWt1Mldlb1VGTHRwS3FBb3Evam0vZk9yd1pDL2pYNERtQkdqNUtr?=
 =?utf-8?B?cVZ4Y2FQM3RvSFVHbjFRcm9rVVluREZ6eGVPZEd2SW5SYUxFdGZnYkp4eFM3?=
 =?utf-8?B?SFJkaXhTNnczeXlvRTgwUitaRkRqcmY3WkR2R21iOFh3WEt3b0FXckJHaTgv?=
 =?utf-8?B?eGdqNTBUS0hqRXMrdmR3TFNoR2prVG9xbGlxVDNraGRuQXNFMElZTndKVUZo?=
 =?utf-8?B?TXFjQnBPNDZEQjlvZmw3aUtTSnBBbUtZLytpODZvV0Q4ZHFya2U5SHlGdmxr?=
 =?utf-8?B?ZHEzbTdDVWNKTklWdStKbDFYay9qblFZU281dlRIek9EM0M5M0pXdXg0Kzds?=
 =?utf-8?B?OTJlaU51K1JoaFh6UkFmRU1IekNuRVJvek5qUW4yY253cVhlU3B6ZTFFaDBr?=
 =?utf-8?B?QXdEU05SWWhOTHZicytrQ202R3dET1JwOGVRMllmSis4UlFEMDVQbFI3ZGZN?=
 =?utf-8?B?QitqZVhpeHdoMnFoc1R5bEZaTnFjaER4Q3A0eFJMS1EvOThFMU5TWkhXTFJk?=
 =?utf-8?B?Ykk1ZzJLZlVMbFozMFdObUUrSG5pZ1dLcmdtNU5ZUEVWNEhUVEJHSlpPWFdv?=
 =?utf-8?B?WUtyTjNtVE9HaUo4MXA1NnREYW9lcGRqSXNHdXM5VzdJaXpYNmxhQXZ2VzJ5?=
 =?utf-8?B?M0tKbVVEYVUyek5mc0tHN2lOVThUUUdjQW1yRVlCR3dsb05oeVlLVlR2OURY?=
 =?utf-8?B?NUlIWFJtSmdORWw0V2NnbExpUFdxTzRvOFlqSDBhMzVtT1lNQXJTOGxWUEZt?=
 =?utf-8?B?VEVrQlEwVkc0d1VXT2JYMWpYQVRWbTU3K21zL05rOGhETlBONmNvN0VhWU9I?=
 =?utf-8?B?eXEwRWJrL0dPMG9CUGc4ajdzL1pRSVorbG5KRGxCUnArL3BSVVBMMDFPaTlz?=
 =?utf-8?B?a2ZtT2ZBUkxja3RxYzREZXdUT3lmSnpUMk9HbG9vRWhvSGk4Y0s2OEt3NWVM?=
 =?utf-8?B?T05TZkJyTERDd2l2bG1WM0JUYkRwVG1YNWx5dk5oQnk4elBUbTdvank0UTVP?=
 =?utf-8?B?REhJVlNXWUZZbVBBSWE1V3RTOGQzbzEwQ2lMT050bjRJZGdHVHJyeHNZRWFx?=
 =?utf-8?B?Nkx6d2VqV0pjaFQrVDg1V0NFTDFlVkpMK2swMU9OOTVRbDR2ZzEzSTJxOWxQ?=
 =?utf-8?Q?8hpFO9zgO60+rvmuW8SKoPUb8w1qE5D3jdIeEvG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70da6a9c-0bbe-49b4-fd26-08d8e7b37764
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 13:08:46.2976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlzXqZN45TT724oBYR1nsIRVfXz7z39AEEnON6RVUKycFvakww9+6PvwzZLDBU5r0FNrXmHL+dZMDvyiq4g2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDMtMTUgdW0gNjoyMiBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAxMy4wMy4yMSB1bSAwMzo0MyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBNYWtlIHN1cmUg
dGhlIGN1ci0+c2l6ZSBkb2Vzbid0IGV4Y2VlZCBjdXItPnJlbWFpbmluZy4gT3RoZXJ3aXNlIHRo
ZQo+PiBmaXJzdCBjYWxsIHRvIGFtZGdwdV9yZXNfbmV4dCB3aWxsIHRyaWdnZXIgdGhlIEJVR19P
TiBpbiB0aGF0IGZ1bmN0aW9uLgo+Cj4gTWhtIHRoZSBCVUdfT04gaXMgY29ycmVjdCBzaW5jZSB0
aGUgZnVuY3Rpb24gY29tcGxhaW5zIHRoYXQgd2Ugd2FudCB0bwo+IG1vdmUgdGhlIGN1cnNvciBm
b3J3YXJkIGJ5IG1vcmUgdGhhbiBvcmlnaW5hbGx5IGV4cGVjdGVkLgo+Cj4gVGhlIHByb2JsZW0g
aXMgcmF0aGVyIHRoYXQgc29tZWJvZHkgaXMgdXNpbmcgY3VyLT5zaXplIHdoaWNoIGlzIHRoZQo+
IHNpemUgb2YgdGhlIGN1cnJlbnQgc2VnbWVudCBhcyBwYXJhbWV0ZXIgZm9yIGFtZGdwdV9yZXNf
bmV4dCgpLgo+Cj4gRG8geW91IGhhdmUgYSBiYWNrdHJhY2Ugb2YgdGhpcz8KSSBkaWRuJ3Qgc2F2
ZSB0aGUgYmFja3RyYWNlLiBUaGUgcHJvYmxlbSB3YXMgaW4KYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9t
YXBwaW5nLiBudW1fZW50cmllcyBpcyBiYXNlZCBvbiBjdXJzb3Iuc2l6ZSBhbmQKbGF0ZXIgdXNl
ZCBpbiB0aGUgYW1kcHVfcmVzX25leHQgY2FsbC4KCkJ1dCBJIHRoaW5rIHRoYXQgc2hvdWxkIGJl
IE9LLiBJZiBjdXJzb3Iuc2l6ZSBpcyB0aGUgY3VycmVudCBzZWdtZW50CnNpemUsIGl0IHNob3Vs
ZCBub3QgZXhjZWVkIGN1cnNvci5yZW1haW5pbmcuIE90aGVyd2lzZSBldmVyeSB1c2VyIG9mIHRo
ZQpjdXJzb3Igd291bGQgaGF2ZSB0byBjaGVjayBib3RoIGN1cnNvci5zaXplIGFuZCBjdXJzb3Iu
cmVtYWluaW5nIGFsbCB0aGUKdGltZSwgd2hpY2ggd291bGQgYmUgaW5jb252ZW5pZW50LiBhbWRn
cHVfcmVzX25leHQgZW5zdXJlcyB0aGF0IHdpdGgKY3VyLT5zaXplID0gbWluKG5vZGUtPnNpemUg
PDwgUEFHRV9TSElGVCwgY3VyLT5yZW1haW5pbmcpLiBJIHRoaW5rCmFtZGdwdV9yZXNfZmlyc3Qg
c2hvdWxkIGRvIHRoZSBzYW1lLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gVGhhbmtzLAo+IENo
cmlzdGlhbi4KPgo+Pgo+PiBGaXhlczogM2FmMGEwMThhNzI4ICgiZHJtL2FtZGdwdTogbmV3IHJl
c291cmNlIGN1cnNvciIpCj4+IENDOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jlc19jdXJzb3IuaCB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jlc19jdXJzb3IuaAo+PiBpbmRleCAxMzM1ZTA5ODUxMGYuLmI0OWE2MWQwN2Q2MCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJz
b3IuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNv
ci5oCj4+IEBAIC02OCw3ICs2OCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVzX2Zp
cnN0KHN0cnVjdAo+PiB0dG1fcmVzb3VyY2UgKnJlcywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0
YXJ0IC09IG5vZGUrKy0+c2l6ZSA8PCBQQUdFX1NISUZUOwo+PiDCoCDCoMKgwqDCoMKgIGN1ci0+
c3RhcnQgPSAobm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKyBzdGFydDsKPj4gLcKgwqDCoCBj
dXItPnNpemUgPSAobm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0Owo+PiArwqDCoMKg
IGN1ci0+c2l6ZSA9IG1pbigobm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0LCBzaXpl
KTsKPj4gwqDCoMKgwqDCoCBjdXItPnJlbWFpbmluZyA9IHNpemU7Cj4+IMKgwqDCoMKgwqAgY3Vy
LT5ub2RlID0gbm9kZTsKPj4gwqAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
