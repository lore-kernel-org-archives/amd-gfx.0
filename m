Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D6C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD31611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD31611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82B96E1AA;
	Wed, 19 May 2021 11:34:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DFB6E1AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 11:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH+IM/TzxXO87eaPMeorTdCjwPnA43ZRA04VT35QINK8d14hXKhFNagsiCcvVR5Y/YSuoW9nXe2B9Esz82ViTdQSYHyJsTG3RGAaSwCHkAK155xDHkEM8+k3/Q8gUG4/5nAYB000syhSVhWPnsD2bUkiyndaAtwZWWyHeUx8n9DaWTTj+qVG0jXZQEIJzXFiyLRJKi15cUxHk2LfQtgI1JYuWGVrcZ+RoC8RNWc0XEsrwoxYwbWX2EnnTbnEXq0EGp7tf4E0vvJigkaZgjqFs3yTlSknrEeo5NgDNaJ5K8DPyvRDmB0wcgSHxIkZgCA3k950dUod3bCoxeL3RjB0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oipJT7sSczdgoBhivBOWGNeSvgpwcAnTJYsokVdekq0=;
 b=mqMA5Ta0pc/nWiYH6cKGpl2zS+nlyG6paFQh66uZAUWPgu3EJoa6pvVUs6XuAR7jGQPmzReK9Vi5zIjI+pNDYa/LXVPq9hWaUyypnvzBm/mbIG0UvVtaGSelnkdYZ8aPMFkYexEUxWApOTRAK6iOcBxv0hL4pqNQbXaThmXNCnKQfFdko/6A4GLoDQAUTWUmSv4xCj3rKyWoq5Ugi9iMC8zrnIatiJ2KUqWyhgWc9ia8jLYXuCMR8jstflpc/hDivL/2S0G+3B7SYraiBca5qQIHWxVvXeXhaERLor7zbPyS/xcl5zfUHCeCjSTbs8srBfHIXp0oF/+3LAY2l8v3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oipJT7sSczdgoBhivBOWGNeSvgpwcAnTJYsokVdekq0=;
 b=xfs1hA3Gs7l4coMkEqWqFqAFiaxkQUg/b9HS5gTG69m/sEghdX9R3U5ssO+83HDqfk4h/Wlfu5BoGdJYz7Or6h+vy0zfaHsP1aS/rHD4Vk3cVYI8mnpNsC2vW/H0rxMXk8pTg6w+zLNfRWZ0AxMd2MqFx1E9hoExdLivAA7lNaE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1240.namprd12.prod.outlook.com (2603:10b6:903:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 11:34:53 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 11:34:53 +0000
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
To: Alex Deucher <alexdeucher@gmail.com>, changzhu <changfeng.zhu@amd.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ecbe948e-1127-6a50-784f-f5f5afa8ecc7@amd.com>
Date: Wed, 19 May 2021 13:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0630.namprd03.prod.outlook.com
 (2603:10b6:408:106::35) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.40.28] (165.204.84.11) by
 BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend
 Transport; Wed, 19 May 2021 11:34:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78e0094-f432-401e-0c26-08d91aba1e82
X-MS-TrafficTypeDiagnostic: CY4PR12MB1240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12401FDD7A7001FECF7B52BF8B2B9@CY4PR12MB1240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJSE9/s8PFSO2MxVoc4z4K+rNSVCBd6CPIW0x3whDGedkK359HJ3sf6aMLrau82f+dtGNMFfhkrMsYpN4Lfyays3c+/QZE/01Cdpv8pKjKDJ3ZTsUYZQDUKsWTcTJEDGyfT6s/w4p9+JnvEfdOeAsYTOYlOaWlBb4fgmH+iFgv5I5Lp+ClCenYfeO+qlZK4I1uXA3mUROPINETdh3yKlVZSoFm+H8toaxRZY5kRnnaaggCMrWeFviSamOgn3C+dGlyj8uiwmqfRMYoEvKc1gwH4PvJ1xumFBYG6mZxcasoDMdKzFqbcQ4BXAoYTaBDtcDK4WugkvU+8q1D5oAfINDf722wdm/mqR5l2ovFuQlO8ii/puR7jHZ4ZLZTaOheaKFBuwMo/jGwNyTGVmW62zWXFf48agSGmfeKmBDprmMsligsbG3vV1Jwrm2+mpCyMaFEEFoFihbEnywIJZtLXCqaURdeLxXILxo+TuNW+2Ql4hyvqTdf8IQzZZnPMT012j29k+fu7yXKVuqJdoGCHdZ98sUFpjrX0Gi6YP4qJ8KewPskMztjdrhQoipqchgfK752lbTm0aMZ4aTiyPnrDMRlX1YVn1H/6uSZChBLkSbRGKVAalhfD1ZAsCZPpj9oQpHKpFNIZH/L+AEBrBiUc63JAp8cwykEOkPZRdJc28+33KcraeRPJMv+w91EMYh9DedPW8FHuqQ7jUKPXKy3/PfeOhOtJDwdJY4VHlwIsPGHwVA9Z72NP3xupDyArlUfhH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(110136005)(966005)(956004)(2616005)(52116002)(16576012)(26005)(16526019)(186003)(54906003)(31696002)(316002)(8676002)(4326008)(66476007)(8936002)(66556008)(45080400002)(66946007)(36756003)(83380400001)(5660300002)(478600001)(6486002)(6636002)(53546011)(38350700002)(6666004)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXFkcFVKKys4SDlMODA3TUdoRTN5UjFuVkFyUUJrSzZVMlIwZXYza2gxUXZt?=
 =?utf-8?B?ZlBPYWV5R1pGNVBYMjl3cU5oOFdXd0xjVlF0aHpOZGhuc3RTQTNYRGlLM051?=
 =?utf-8?B?QVZUSTJYbFN3enZtS0xXNHNmYXNtVVlucFhWTjFBWHRsZ2JuTU83Y2tYYUdr?=
 =?utf-8?B?cWpERGYxeGJPVVJpaXZvUy93UW5OMStCSDF0emc5ZUxvMU53YkVGbHNpdUZZ?=
 =?utf-8?B?NFV3RXpDdm5RU2hNcmF0Z1AxRG81RmQzcU9HWk5XZkNiMkQ2dTVQdERoR0tK?=
 =?utf-8?B?YkhtaHZjbGVVekF0NXdJbDlEWURXSURmM0d0VzBSZklZaHROTStRRjJJNkFF?=
 =?utf-8?B?dnVpUEhNeVRiTk1aQjhaZXl1cEhhT2xzeXlrRFVjUlZhQjZhVGFPeWxqc29B?=
 =?utf-8?B?cXpZZmtacDVqcE5VaUprVFBrc04xUkMya1h2ck5ZUlV3MVdpU1l0Vk03SWx5?=
 =?utf-8?B?Y2hvb0d0bWZPUkNzMVluZTA3YWhENFU1VjB2V2JyZVVlWFNRM3E4VGFKYUs3?=
 =?utf-8?B?Sm1ZTnNWQmV3L2M3NzY5YUdLWkhYYzF2dHFwWjloVkVyb3c2aEJWTHFjeVhB?=
 =?utf-8?B?NTRiblhPOFVmZEdEdjFUcEthNzBDN1A5VTQzb1NqNEtYN1gyZksySit0eHpy?=
 =?utf-8?B?aWRSWnRIb2swZFloZ2ZPNnU2cDc0ZElPYTh5dkcvU3hnODdFNzFXQ2VKMDFp?=
 =?utf-8?B?eit4M2Y5Ri83WWgzVXlIUnBEN3dwaXR1NlpyWUxyeU0xbFdGU0F6SGNCaFJQ?=
 =?utf-8?B?TUdQd0w4TGNEMnZKbVZCVzFPQTVQTU5UU3ZDMUZ5R3JkdGFybkVvYTJqSlpj?=
 =?utf-8?B?VDkzcU9ob3lqNU5PMzVxRzA1cUVqYi9YMGNDaTJrbi9NNGVuOXNYdThHeHda?=
 =?utf-8?B?TWFxeEtWZHg1K3RhUWtFbDZZbGZ4R3VGb2VYQXg1MmtHV045cEdRU3AxeVgv?=
 =?utf-8?B?Y2NTYUN3ZWFWaTFBMFM2eHlpTUVJUEhWTXZRems5ZldJSVIwZGFJWDB0aEla?=
 =?utf-8?B?ZTVEckswWHZFLzhKNnRocjBqTzhzbENOZkpNdHZ0bFZlVFZxV24rdzY1U3Ay?=
 =?utf-8?B?RDlGS09SRWxRZndKem9STUw5SHMwVXlLTnNXTzJqV3hQbUZ4OWlFQ1NwUmYz?=
 =?utf-8?B?ejMzNENXM1BrQ3RDSGI5dDZnRVk2QnBDR1FCRnJ3MTVDaExOZXUwVjdUMHhS?=
 =?utf-8?B?OEtnejRBZWtObldOQ3IxOWRMUldSVHdvdGlpbCtZZEpPVUU5WFpsRlVzK1dv?=
 =?utf-8?B?YUEvVVEwOW85bk85S003b1BUbklJMDVQdlJoWWZtblRVUHE5T0JsS3VNOEVS?=
 =?utf-8?B?aXcyUmxIYWQ2TEVoWldhZE1qUVNPOE96clV0VzJCMEd5TldZZ0lSKzBqejho?=
 =?utf-8?B?Q0doMVhJbktvcXlwclU2QXJMRk5kT3ZmajlRa0l6TlQrbnYweWJYTVJwd0du?=
 =?utf-8?B?bHNSaFh4cHpMUDJIaTBsOUMvTTdQd0JSU0N5T2Y3TVJSb1VvaXB6SkswYzk2?=
 =?utf-8?B?VWVFb3FQeXNGamhsa3dUczM1VG1SMDB6RVF3SHBLN0ZOTk41WG1oQ2s5NkZn?=
 =?utf-8?B?SDlockVvKytNdHdNY2xVeTVxTGNkSTZmQkNrQmxJNUdxVkpJSTFIYjlCQVpp?=
 =?utf-8?B?NzJUVlFDWU9xMkJpMGswNndMaktNd2tFa29xMEdSYkhzVGZWQjViRGdOMi9D?=
 =?utf-8?B?dktQOVMwamRzRjRqLy9HNTI4a3dpQUV3WlY3d05CckorSUk1TFpROVVMd0RO?=
 =?utf-8?Q?9ZYhKpnbb8O3IMhM2J4UG/KCbhHr/isVzWU6lTj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e0094-f432-401e-0c26-08d91aba1e82
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:34:53.1782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66aMdyubngKcaOU7evNcDZoXuDwcqEBSVLFDN2XYOQiMv5GPg45jpVcAUai1rhxWJgW4sPTJtxB/wOJZoB/98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1240
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
Cc: Huang Rui <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDUvMTQvMjEgNDoxMyBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIEZyaSwgTWF5IDE0
LCAyMDIxIGF0IDQ6MjAgQU0gPGNoYW5nZmVuZy56aHVAYW1kLmNvbT4gd3JvdGU6Cj4+IEZyb206
IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4+Cj4+IEZyb206IENoYW5nZmVuZyA8
Q2hhbmdmZW5nLlpodUBhbWQuY29tPgo+Pgo+PiBUaGVyZSBpcyBwcm9ibGVtIHdpdGggM0RDR0NH
IGZpcm13YXJlIGFuZCBpdCB3aWxsIGNhdXNlIGNvbXB1dGUgdGVzdAo+PiBoYW5nIG9uIHBpY2Fz
c28vcmF2ZW4xLiBJdCBuZWVkcyB0byBkaXNhYmxlIDNEQ0dDRyBpbiBkcml2ZXIgdG8gYXZvaWQK
Pj4gY29tcHV0ZSBoYW5nLgo+Pgo+PiBDaGFuZ2UtSWQ6IEljN2QzYzc5MjJiMmIzMmY3YWM1MTkz
ZDZhNDg2OWNiYzViM2JhYTg3Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW5nZmVuZyA8Q2hhbmdmZW5n
LlpodUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4KPiBXSXRoIHRoaXMgYXBwbGllZCwgY2FuIHdlIHJlLWVuYWJsZSB0aGUg
YWRkaXRpb25hbCBjb21wdXRlIHF1ZXVlcz8KCgpJwqAgZGlkbid0IHB1c2ggdGhhdCBjaGFuZ2Ug
YXMgSSB3YXMgc3VwcG9zZSBkbyBtb3JlIHRlc3RzIHdpdGggS0ZEIGFuZAoKSSBwcm9iYWJseSBn
b3QgZGlzdHJhY3RlZCBieSBzb21lIG90aGVyIGFjdGl2aXR5LiBTb3JyeSBmb3IgY2F1c2luZyB0
aGlzIApjb25mdXNpb24hCgoKQWNrZWQtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNv
bT4KCgpSZWdhcmRzLAoKTmlybW95CgoKPgo+IEFsZXgKPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMTAgKysrKysrKy0tLQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgfCAgMiAtLQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMKPj4gaW5kZXggMjI2MDhjNDVmMDdjLi5mZWFhNWU0YTU1MzggMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+PiBAQCAtNDk0Nyw3ICs0
OTQ3LDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfdXBkYXRlXzNkX2Nsb2NrX2dhdGluZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gICAgICAgICAgYW1kZ3B1X2dmeF9ybGNfZW50ZXJf
c2FmZV9tb2RlKGFkZXYpOwo+Pgo+PiAgICAgICAgICAvKiBFbmFibGUgM0QgQ0dDRy9DR0xTICov
Cj4+IC0gICAgICAgaWYgKGVuYWJsZSAmJiAoYWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9S
VF9HRlhfM0RfQ0dDRykpIHsKPj4gKyAgICAgICBpZiAoZW5hYmxlKSB7Cj4+ICAgICAgICAgICAg
ICAgICAgLyogd3JpdGUgY21kIHRvIGNsZWFyIGNnY2cvY2dscyBvdiAqLwo+PiAgICAgICAgICAg
ICAgICAgIGRlZiA9IGRhdGEgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NHVFRfTUdDR19P
VkVSUklERSk7Cj4+ICAgICAgICAgICAgICAgICAgLyogdW5zZXQgQ0dDRyBvdmVycmlkZSAqLwo+
PiBAQCAtNDk1OSw4ICs0OTU5LDEyIEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3VwZGF0ZV8zZF9j
bG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgICAgICAgICAgICAg
ICAgLyogZW5hYmxlIDNEY2djZyBGU00oMHgwMDAwMzYzZikgKi8KPj4gICAgICAgICAgICAgICAg
ICBkZWYgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NHQ0dfQ0dMU19DVFJMXzNEKTsKPj4K
Pj4gLSAgICAgICAgICAgICAgIGRhdGEgPSAoMHgzNiA8PCBSTENfQ0dDR19DR0xTX0NUUkxfM0Rf
X0NHQ0dfR0ZYX0lETEVfVEhSRVNIT0xEX19TSElGVCkgfAo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICBSTENfQ0dDR19DR0xTX0NUUkxfM0RfX0NHQ0dfRU5fTUFTSzsKPj4gKyAgICAgICAgICAg
ICAgIGlmIChhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX0dGWF8zRF9DR0NHKQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBkYXRhID0gKDB4MzYgPDwgUkxDX0NHQ0dfQ0dMU19DVFJM
XzNEX19DR0NHX0dGWF9JRExFX1RIUkVTSE9MRF9fU0hJRlQpIHwKPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBSTENfQ0dDR19DR0xTX0NUUkxfM0RfX0NHQ0dfRU5fTUFTSzsKPj4g
KyAgICAgICAgICAgICAgIGVsc2UKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGF0YSA9IDB4
MCA8PCBSTENfQ0dDR19DR0xTX0NUUkxfM0RfX0NHQ0dfR0ZYX0lETEVfVEhSRVNIT0xEX19TSElG
VDsKPj4gKwo+PiAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19T
VVBQT1JUX0dGWF8zRF9DR0xTKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSB8PSAo
MHgwMDBGIDw8IFJMQ19DR0NHX0NHTFNfQ1RSTF8zRF9fQ0dMU19SRVBfQ09NUEFOU0FUX0RFTEFZ
X19TSElGVCkgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSTENfQ0dDR19D
R0xTX0NUUkxfM0RfX0NHTFNfRU5fTUFTSzsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
Cj4+IGluZGV4IDRiNjYwYjJkMWMyMi4uMDgwZTcxNTc5OWQ0IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMKPj4gQEAgLTEzOTMsNyArMTM5Myw2IEBAIHN0YXRpYyBpbnQgc29j
MTVfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWRldi0+Y2dfZmxhZ3MgPSBBTURfQ0dfU1VQUE9SVF9HRlhfTUdDRyB8Cj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JUX0dGWF9NR0xTIHwKPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NVUFBPUlRfR0ZYX0NQX0xT
IHwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9HRlhf
M0RfQ0dDRyB8Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQ
T1JUX0dGWF8zRF9DR0xTIHwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1E
X0NHX1NVUFBPUlRfR0ZYX0NHQ0cgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBBTURfQ0dfU1VQUE9SVF9HRlhfQ0dMUyB8Cj4+IEBAIC0xNDEzLDcgKzE0MTIsNiBAQCBzdGF0
aWMgaW50IHNvYzE1X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NVUFBPUlRfR0ZYX01HTFMgfAo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9HRlhfUkxDX0xTIHwK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1EX0NHX1NVUFBPUlRfR0ZYX0NQ
X0xTIHwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9H
RlhfM0RfQ0dDRyB8Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9DR19T
VVBQT1JUX0dGWF8zRF9DR0xTIHwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QU1EX0NHX1NVUFBPUlRfR0ZYX0NHQ0cgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBBTURfQ0dfU1VQUE9SVF9HRlhfQ0dMUyB8Cj4+IC0tCj4+IDIuMTcuMQo+Pgo+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25h
bTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
aXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtk
YXRhPTA0JTdDMDElN0NuaXJtb3kuZGFzJTQwYW1kLmNvbSU3QzIzMzdkYTMzNDljYzQ2MTNhNWJm
MDhkOTE2ZTI4YjgyJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzU2NTk4NDU0MzQ5NDE0OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0Mz
MDAwJmFtcDtzZGF0YT1CQ0k4Y2tFdW5GZmI1UDgwTmNhYTNpdXo5U0hFcWowN1NYdDZIMmxaTUNn
JTNEJmFtcDtyZXNlcnZlZD0wCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbmlybW95LmRhcyU0MGFtZC5jb20l
N0MyMzM3ZGEzMzQ5Y2M0NjEzYTViZjA4ZDkxNmUyOGI4MiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1NjU5ODQ1NDM0OTQxNDklN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9QkNJOGNrRXVuRmZiNVA4ME5jYWEz
aXV6OVNIRXFqMDdTWHQ2SDJsWk1DZyUzRCZhbXA7cmVzZXJ2ZWQ9MApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
