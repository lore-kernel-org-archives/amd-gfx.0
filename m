Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3AC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 16:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE561603
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 16:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE561603
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F04B6E28A;
	Tue, 15 Jun 2021 16:16:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838636E28A;
 Tue, 15 Jun 2021 16:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAMWFET5Hj44C8fK6vTvzU02SVDjs6xF0eUyUT/VgBpjYbCIJA4qpjerNrwY3cGw90i0VoD0+oLgL0U1OPZono1yVdLOzPuYJTAbElaeXSwLOKXonX3xKco7w7CQbR3Dq5x0J3sd3hOv+ogDvBgq3PZH26xyhwp6cnc1zkhJk2+ezrDKk/i4u+Bhmbpy5w9CkZD2/eSmn5ekSPhrrvTzItr4vSVDiyh7B9VnOGfl0Zq2oOdSGHNlcHPVCOwhiwxCze0bDSnjBDenKOReQjB01YVE7Itv1+IBUSTCO0zAC8irC052cg2f5Az9Fofp15fD+bgWcW/aEzvqF96YP5PUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ajh9Z0MVBu5qh3Ib21Mn8SoQFvElkpIwNIztSbBBFc=;
 b=C+rM01HdESvl9Xsxv5Pdjp001AvawG2h6pFv4ehNuiSmnf4JPA+ovqEjmGKTSmRx7rPG/ggYMTX7g98NOdeKvveTqe3tYC01LNWpotxMiUBa3NXJAp2oLB8PlOzAdLb0+MIrIeTr61mihgRhuwmyE02JqhtfxZbGMXKsO/9A6gfJK9KsReRJnl871uHDANdvA+sFchQn6Mqq9dytP9r9cqwr9zr2wFRBp241mfE1OgavGCGsNy/TWEAkn2gbK7o5GQ6mgs96Jyr88zmWO8/TOf/0TqY33URWVHPn2/6qOfWGuyND/1vGsVqYNdM+pWavc3l4fKX6XzaxzMaVz102GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ajh9Z0MVBu5qh3Ib21Mn8SoQFvElkpIwNIztSbBBFc=;
 b=gL4+/0uTDhWoOpKJM+wqojVB9Pz4wlCza4u1jxwO9bPnhAn87dFTBmKX+9TqxQIFwyvsX9vVokTqjhbmSEbJIUJTUGc1boasCgZPb7wBITJ3kfoWtz4gjOc8a8bqyrGQ5XrhyPn3icsb83T5QuE587vczeUeGZbXxJNYyW2rtXU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 16:15:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 16:15:59 +0000
Subject: Re: [RFC PATCH] drm/ttm: Do page counting after populate callback
 succeed
To: Felix Kuehling <felix.kuehling@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <ckoenig.leichtzumerken@gmail.com>
References: <20210615115746.27424-1-xinhui.pan@amd.com>
 <f70e88b3-f0db-fca8-f05e-f685f1a913ad@gmail.com>
 <4719A30A-0B23-4053-B8EB-AC9BD21DBE40@amd.com>
 <88115e0c-5cee-5b16-f60f-480136f0bcad@amd.com>
 <da147e95-e59b-3f38-2ba2-9f4447f7ea86@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4575e86e-8cb7-2d22-93fb-c1279c404a33@amd.com>
Date: Tue, 15 Jun 2021 18:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <da147e95-e59b-3f38-2ba2-9f4447f7ea86@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:791b:b5ea:2111:7d75]
X-ClientProxiedBy: AM9P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:791b:b5ea:2111:7d75]
 (2a02:908:1252:fb60:791b:b5ea:2111:7d75) by
 AM9P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 16:15:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3637518a-bd21-4402-626a-08d93018dcb2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2482BB665A72C4CC3A5B7B7283309@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ar2r4nRryYNmygHziYAwuG9qgAk10bj56MzEHt+EXSuIddd+Wbmm5HXLXdzvJ4PEbLjVeM1STaNLtuTNb6Nn1I+hqWPlOPxkqwSn48+L2kDrbohbN+YYPqpi8bLPFjp6q6TK+ELdYI+GBzjh6+wiNb7XJVEk/9rXTtMckGeI/nz9GbXzSW7BmpY6oC+V7yhYuYa3mglTvKGl4sajN1DGnj4w0lv57jZaOvOHow4yKJwKxU7gE5CXbk/kf548woApG5dbxBfhp1SxCGG0Dt+zyVJV+jPlOWhVxquo3I9COzAn4ZRB71Sb7CW3lqdTsGgv9cDvrmzhaUPkn3C0V0Tijo7Gd8MqATYZwwpnQ/yTRtM3ojBI1K1k7oX6R0faKxEefqYWNwA9cLAGkAH2Mi+uXEtMtkNKL0ygw4B0vR/uC3EBxi04K6Sx2w8+5S50T5ql5ZK/xzGmN135hsitxtT5e6BSm8ZwhFWBNjHhVnvMER7Wx5j2+RQxobOQCv5Chh06RCpWbvlKQIrH4nWctE19DWzpmnSVQJbNpyJU6s9qWnemf6jG8Yo5RKvpql2DJUh8bQ8TjDMk57v5VoMFjeigVv5LkiVc5orEyWI8sXR+oKTu6HM4zY4xHkQ9rGQhMygjak3WoVlsCOc2uXHUF/cfH8aB8FO2bf7K0xTs5AYPO4tCDEScKQ95YIST3ITC1BW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(5660300002)(66476007)(66946007)(66556008)(4326008)(31686004)(6666004)(16526019)(186003)(38100700002)(2906002)(83380400001)(8676002)(66574015)(2616005)(31696002)(8936002)(86362001)(110136005)(54906003)(6486002)(36756003)(316002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NCRUJLdUtlUzVqb3M1V1IxN2h0Q0sxVVlMQmtBZzdXa1lRWFNQSzFzMTdH?=
 =?utf-8?B?S2tMcktNOEk2QkM3enpxdERwZzh2TENpRHAwQ0svZi80VnNLQzE4V1BKd0Fy?=
 =?utf-8?B?aDBWMUp4b0QvRHZZQ09sa0JIVDRUUTlybjluVVF3MjdmWjRhSzY1cWxzRzIy?=
 =?utf-8?B?cVdvcXNBejVFaVc4bFNWUkF1cmhEUkNNTEFKVlZlR21vbjhHRENpV2VOZFBo?=
 =?utf-8?B?TGs1NG9rdlhMdjhFZFQ5ZUlweE5FYlJLRmhSMHE2L3dpVUs4NC9iOHNBajVs?=
 =?utf-8?B?R1A1dGFhZmtmcnpTSVdHNEYxbXdZMlFrVjRrdnRJV3YvK0F1WDJHVlQzV05s?=
 =?utf-8?B?V0c1VGlvM1A3cmp5MjhKODZjOVVKYkxiZDhWekF5SklsWWszdjZEUjRZR2dw?=
 =?utf-8?B?ck5iTUVPNWFDSWluM2ExcEdMSGIrNmRYc3Q2MGlWWEhMUzkrQWVxSUNQcjQy?=
 =?utf-8?B?c0RsN2V1emgzT1Mxa282Slo3ZlQzc2FNNTloZDdPMHdRRTNYeStvTDJrSDJo?=
 =?utf-8?B?a3d3VExQUVBQL1Bpa3VVeXpzREluenBvLzZSYkZRaHEyMmpWNE1USmRZZmRr?=
 =?utf-8?B?dkZYM2ZjQmJZNUJsZEtXQkNQSUt3Yk5ZWVgzMk1lOEpLei9weGk5bE9kRVJs?=
 =?utf-8?B?MDdicXRrdVRiK1puWW5LOEpZalRWYjVKcUI0SVpVd25EWFNhdk5hc3RaWE96?=
 =?utf-8?B?MkFaNlRmT2hqUnNveGkwTUxvYllMd2RZZlJWU2VLdkYxelFiY29VT0MyYklj?=
 =?utf-8?B?UXA2WW82STkwdnc1c0piOFNXL05WVitPTElBeXR5dTZWbVVncnpUdXAyWkRi?=
 =?utf-8?B?Zlg2dzBuSmhZS2xPSEpvOUVEWUhnaGRVZHhkSVU2bitNcHBrMlJWSk00b09a?=
 =?utf-8?B?dHUrUFAxWURROTg5YW5oVzZycWFkTmFkRXRCREhwWHZiWlVwbzNUcU9yWFli?=
 =?utf-8?B?NjVZTzhZdm5lazNNRCtCNm0vK3FxcHJRc3RSRnk4YTkvN2tUNk9GenVBeTE5?=
 =?utf-8?B?Y0xJK1dSM1hzcHZmZFgwZWNBekRFVktwa1VYMTUwWmlPMStSZGhaTHVhQjRW?=
 =?utf-8?B?VDNHR1A0bmp6VDA5a2VTYndyTURENDJ0K1BrMHhqOXR4VUtDUXJKNzJaZjQx?=
 =?utf-8?B?QW1rQTU2bEFoYWVobUJKQlpGSTRRR1krYS9hSXBabUhvZmtBelBGcnR3UW9X?=
 =?utf-8?B?V0hjbHQ4K0svcEdPanFnMXR3eDhHVFdFdVJuR29zQUt1MThFVlhvWGdXS0E2?=
 =?utf-8?B?WFZYNkRnODZKT0NDbU12U2ZHNjVaWUVvdUN6SVNHQU8xeUtFRm10Si9sSDNj?=
 =?utf-8?B?RTdqQll0MFVIcVJGaXFkdlFwVTBGTVN5RGF2aGI2dVFGejE1YWlFOHh2QUZi?=
 =?utf-8?B?aFp1Q1JldGs4OStvenZRVE05OW5YS1FkSnJVZ0lMTjBSa1FuUWZFelZmTFpZ?=
 =?utf-8?B?RjgvaVdIU0tCNFJWbG13dnBVcllsL2RwM1JyS0FlVGdPbDFkTS9yR2RUbU1O?=
 =?utf-8?B?b2QvZ054Z01WM0JoVXhTYk50TktYbVg3ZGgzbDYyNHJtclVNTDZ5UTNUYkJw?=
 =?utf-8?B?aGR5OWVjeDdDdGNDdnZ2NzV1RXREaHZJRDM5QXZYT3VWRUFZQlRla3FPYjhJ?=
 =?utf-8?B?OUZTOHNqN28zVVZvWmttZW9IT0Ivdzd3Rjhja2R2c2tGZmVtMFZmQ3VpS05J?=
 =?utf-8?B?akRySVB2VHpSdFQ5c3ZHb08xUmkrbnZIdHg0QW9meVNMWkpVVkxTb0c4NlNE?=
 =?utf-8?B?Nk9MMVhSQlZqWFQ4eWVUMENGTHE3QjlnWmdKUVYxSHk2OGJoZU81dzdGemdn?=
 =?utf-8?B?RzJvYWp3dmw4RXdQTDg3Ky9NbjJNT0ZIMXBNT3BNODZacVhrRWdVWjhyemYy?=
 =?utf-8?Q?PWEQ5MacW49Nj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3637518a-bd21-4402-626a-08d93018dcb2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 16:15:59.2051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPSeqc2YWd78MaQhtCpCaDFWS8LSBBEbgM1ndrJWQaBdKv3lfbIBOGPAd2+/s6CV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNS4wNi4yMSB1bSAxNzowNiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEFtIDIwMjEt
MDYtMTUgdW0gODoxOCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4gQW0gMTUuMDYu
MjEgdW0gMTQ6MTEgc2NocmllYiBQYW4sIFhpbmh1aToKPj4+PiAyMDIx5bm0NuaciDE15pelIDIw
OjAx77yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+
Cj4+Pj4g5YaZ6YGT77yaCj4+Pj4KPj4+PiBBbSAxNS4wNi4yMSB1bSAxMzo1NyBzY2hyaWViIHhp
bmh1aSBwYW46Cj4+Pj4+IEFtZGdwdSBzZXQgU0cgZmxhZyBpbiBwb3B1bGF0ZSBjYWxsYmFjay4g
U28gVFRNIHN0aWxsIGNvdW50IHBhZ2VzCj4+Pj4+IGluIFNHCj4+Pj4+IEJPLgo+Pj4+IEl0J3Mg
cHJvYmFibHkgYmV0dGVyIHRvIGZpeCB0aGlzIGluc3RlYWQuIEUuZy4gd2h5IGRvZXMgYW1kZ3B1
Cj4+Pj4gbW9kaWZ5IHRoZSBTRyBmbGFnIGR1cmluZyBwb3B1bGF0ZSBhbmQgbm90IGR1cmluZyBp
bml0aWFsIGNyZWF0aW9uPwo+Pj4+IFRoYXQgZG9lc24ndCBzZWVtIHRvIG1ha2Ugc2Vuc2UuCj4+
PiBmYWlyIGVub3VnaC4gTGV0IG1lIGhhdmUgYSB0cnkuCj4+PiBObyBpZGVhIHdoeSB3ZSBzZXQg
U0cgZmxhZyBpbiBwb3B1bGF0ZSB5ZWFycyBhZ28uCj4+IFRoYXQncyBwcmV0dHkgcmVjZW50IElJ
UkMuIEZlbGl4IG1vdmVkIHRoZSBjb2RlIGFyb3VuZCBhIGJpdCB0byBmaXgKPj4gYW5vdGhlciBw
cm9ibGVtLgo+IEkgbW92ZWQgc29tZSBjb2RlIGZyb20gcG9wdWxhdGUvdW5wb3B1bGF0ZSB0byBi
YWNrZW5kX2JpbmQvdW5iaW5kIGZvcgo+IGF0dGFjaGluZyBhbmQgZGV0YWNoaW5nIGRtYWJ1ZnMu
IEkgZGlkbid0IGNoYW5nZSB0aGUgc2V0dGluZy91bnNldHRpbmcKPiBvZiBTRyBmbGFncyBmb3Ig
dXNlcnB0ciBCT3MuIFRoYXQgZ29lcyBiYWNrIGFsbCB0aGUgd2F5IHRvIDIwMTUuCj4KPiBBcyBm
YXIgYXMgSSBjYW4gdGVsbCwgdGhpcyBpcyBuZWVkZWQgYmVjYXVzZSB1c2VycHRyIEJPcyBhcmUg
bm90IGNyZWF0ZWQKPiBhcyBTRyBCT3MuIFRoYXQncyBzb21ldGhpbmcgSSd2ZSBhbHNvIHBvaW50
ZWQgb3V0IGJlZm9yZS4KCkFoLCB5ZXMuIFRoYXQncyBiZWNhdXNlIHdlIG5lZWQgdGhlIHBhZ2Vz
IGFycmF5IGZvciB1c2VycHRyIEJPcy4KClRoZW4gd2Ugc2hvdWxkIHByb2JhYmx5IG1vdmUgdGhh
dCB0byBhbWRncHVfdHRtX3R0X3NldF91c2VycHRyKCkuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4K
PiBSZWdhcmRzLAo+ICDCoCBGZWxpeAo+Cj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4+IENocmlzdGlh
bi4KPj4+Pgo+Pj4+PiBPbmUgZWFzeSB3YXkgdG8gZml4IHRoaXMgaXMgbGV0cyBjb3VudCBwYWdl
cyBhZnRlciBwb3B1bGF0ZSBjYWxsYmFjay4KPj4+Pj4KPj4+Pj4gV2UgaGl0IG9uZSBpc3N1ZSB0
aGF0IGFtZGdwdSBhbGxvYyBtYW55IFNHIEJPcywgYnV0IFRUTSB0cnkgdG8gZG8gc3dhcAo+Pj4+
PiBhZ2FpbiBhbmQgYWdhaW4gZXZlbiBpZiBzd2Fwb3V0IGRvZXMgbm90IHN3YXAgU0cgQk9zIGF0
IGFsbC4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBh
bWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMg
fCAzMiArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+PiAgwqAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYwo+Pj4+PiBiL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX3R0LmMKPj4+Pj4gaW5kZXggYTFhMjU0MTBlYzc0Li40ZmEwYThjZDcxYzAg
MTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKPj4+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYwo+Pj4+PiBAQCAtMzE3LDEzICszMTcsNiBA
QCBpbnQgdHRtX3R0X3BvcHVsYXRlKHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+Pj4+PiAgwqDC
oMKgwqDCoCBpZiAodHRtX3R0X2lzX3BvcHVsYXRlZCh0dG0pKQo+Pj4+PiAgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAwOwo+Pj4+PiAgwqAgLcKgwqDCoCBpZiAoISh0dG0tPnBhZ2VfZmxhZ3Mg
JiBUVE1fUEFHRV9GTEFHX1NHKSkgewo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgYXRvbWljX2xvbmdf
YWRkKHR0bS0+bnVtX3BhZ2VzLCAmdHRtX3BhZ2VzX2FsbG9jYXRlZCk7Cj4+Pj4+IC3CoMKgwqDC
oMKgwqDCoCBpZiAoYmRldi0+cG9vbC51c2VfZG1hMzIpCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGF0b21pY19sb25nX2FkZCh0dG0tPm51bV9wYWdlcywKPj4+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ0dG1fZG1hMzJfcGFnZXNfYWxsb2NhdGVkKTsK
Pj4+Pj4gLcKgwqDCoCB9Cj4+Pj4+IC0KPj4+Pj4gIMKgwqDCoMKgwqAgd2hpbGUgKGF0b21pY19s
b25nX3JlYWQoJnR0bV9wYWdlc19hbGxvY2F0ZWQpID4KPj4+Pj4gdHRtX3BhZ2VzX2xpbWl0IHx8
Cj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljX2xvbmdfcmVhZCgmdHRtX2Rt
YTMyX3BhZ2VzX2FsbG9jYXRlZCkgPgo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR0
bV9kbWEzMl9wYWdlc19saW1pdCkgewo+Pj4+PiBAQCAtMzQyLDYgKzMzNSwxMyBAQCBpbnQgdHRt
X3R0X3BvcHVsYXRlKHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+Pj4+PiAgwqDCoMKgwqDCoCBp
ZiAocmV0KQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3I7Cj4+Pj4+ICDCoCAr
wqDCoMKgIGlmICghKHR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZMQUdfU0cpKSB7Cj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBhdG9taWNfbG9uZ19hZGQodHRtLT5udW1fcGFnZXMsICZ0dG1fcGFn
ZXNfYWxsb2NhdGVkKTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChiZGV2LT5wb29sLnVzZV9k
bWEzMikKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljX2xvbmdfYWRkKHR0bS0+
bnVtX3BhZ2VzLAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JnR0bV9kbWEzMl9wYWdlc19hbGxvY2F0ZWQpOwo+Pj4+PiArwqDCoMKgIH0KPj4+Pj4gKwo+Pj4+
PiAgwqDCoMKgwqDCoCB0dG1fdHRfYWRkX21hcHBpbmcoYmRldiwgdHRtKTsKPj4+Pj4gIMKgwqDC
oMKgwqAgdHRtLT5wYWdlX2ZsYWdzIHw9IFRUTV9QQUdFX0ZMQUdfUFJJVl9QT1BVTEFURUQ7Cj4+
Pj4+ICDCoMKgwqDCoMKgIGlmICh1bmxpa2VseSh0dG0tPnBhZ2VfZmxhZ3MgJiBUVE1fUEFHRV9G
TEFHX1NXQVBQRUQpKSB7Cj4+Pj4+IEBAIC0zNTUsMTIgKzM1NSw2IEBAIGludCB0dG1fdHRfcG9w
dWxhdGUoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsCj4+Pj4+ICDCoMKgwqDCoMKgIHJldHVybiAw
Owo+Pj4+PiAgwqDCoMKgIGVycm9yOgo+Pj4+PiAtwqDCoMKgIGlmICghKHR0bS0+cGFnZV9mbGFn
cyAmIFRUTV9QQUdFX0ZMQUdfU0cpKSB7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBhdG9taWNfbG9u
Z19zdWIodHRtLT5udW1fcGFnZXMsICZ0dG1fcGFnZXNfYWxsb2NhdGVkKTsKPj4+Pj4gLcKgwqDC
oMKgwqDCoMKgIGlmIChiZGV2LT5wb29sLnVzZV9kbWEzMikKPj4+Pj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYXRvbWljX2xvbmdfc3ViKHR0bS0+bnVtX3BhZ2VzLAo+Pj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnR0bV9kbWEzMl9wYWdlc19hbGxvY2F0ZWQp
Owo+Pj4+PiAtwqDCoMKgIH0KPj4+Pj4gIMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+Pj4gIMKg
IH0KPj4+Pj4gIMKgIEVYUE9SVF9TWU1CT0wodHRtX3R0X3BvcHVsYXRlKTsKPj4+Pj4gQEAgLTM4
NCwxMiArMzc4LDYgQEAgdm9pZCB0dG1fdHRfdW5wb3B1bGF0ZShzdHJ1Y3QgdHRtX2RldmljZQo+
Pj4+PiAqYmRldiwgc3RydWN0IHR0bV90dCAqdHRtKQo+Pj4+PiAgwqDCoMKgwqDCoCBpZiAoIXR0
bV90dF9pc19wb3B1bGF0ZWQodHRtKSkKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47
Cj4+Pj4+ICDCoCAtwqDCoMKgIHR0bV90dF9jbGVhcl9tYXBwaW5nKHR0bSk7Cj4+Pj4+IC3CoMKg
wqAgaWYgKGJkZXYtPmZ1bmNzLT50dG1fdHRfdW5wb3B1bGF0ZSkKPj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIGJkZXYtPmZ1bmNzLT50dG1fdHRfdW5wb3B1bGF0ZShiZGV2LCB0dG0pOwo+Pj4+PiAtwqDC
oMKgIGVsc2UKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHR0bV9wb29sX2ZyZWUoJmJkZXYtPnBvb2ws
IHR0bSk7Cj4+Pj4+IC0KPj4+Pj4gIMKgwqDCoMKgwqAgaWYgKCEodHRtLT5wYWdlX2ZsYWdzICYg
VFRNX1BBR0VfRkxBR19TRykpIHsKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfbG9u
Z19zdWIodHRtLT5udW1fcGFnZXMsICZ0dG1fcGFnZXNfYWxsb2NhdGVkKTsKPj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoYmRldi0+cG9vbC51c2VfZG1hMzIpCj4+Pj4+IEBAIC0zOTcsNiAr
Mzg1LDEyIEBAIHZvaWQgdHRtX3R0X3VucG9wdWxhdGUoc3RydWN0IHR0bV9kZXZpY2UKPj4+Pj4g
KmJkZXYsIHN0cnVjdCB0dG1fdHQgKnR0bSkKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmdHRtX2RtYTMyX3BhZ2VzX2FsbG9jYXRlZCk7Cj4+Pj4+ICDC
oMKgwqDCoMKgIH0KPj4+Pj4gIMKgICvCoMKgwqAgdHRtX3R0X2NsZWFyX21hcHBpbmcodHRtKTsK
Pj4+Pj4gK8KgwqDCoCBpZiAoYmRldi0+ZnVuY3MtPnR0bV90dF91bnBvcHVsYXRlKQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgYmRldi0+ZnVuY3MtPnR0bV90dF91bnBvcHVsYXRlKGJkZXYsIHR0bSk7
Cj4+Pj4+ICvCoMKgwqAgZWxzZQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdHRtX3Bvb2xfZnJlZSgm
YmRldi0+cG9vbCwgdHRtKTsKPj4+Pj4gKwo+Pj4+PiAgwqDCoMKgwqDCoCB0dG0tPnBhZ2VfZmxh
Z3MgJj0gflRUTV9QQUdFX0ZMQUdfUFJJVl9QT1BVTEFURUQ7Cj4+Pj4+ICDCoCB9Cj4+Pj4+ICAg
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
