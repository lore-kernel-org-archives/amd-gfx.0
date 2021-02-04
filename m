Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A9C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 15:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7945F64F58
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 15:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7945F64F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBC66EDAC;
	Thu,  4 Feb 2021 15:14:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753FC6ED92
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 15:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z18f+P3GSV69akbZNC4yV8jjkgdakPiyoNGcwjex3kig3SBu8oJT50SvH7uOtR+bBnrxhjwwNgw5sX1J7B64e2sG6FOKCQXug/vto4cukQHUNEqNetwGIRBGppjezNrRlx4Cu29Z+AP3xgU8EC0sXAeESc0B4x5ZWsRiepGplWTZRnVUrh0AqACJMTDAn/PHuATrgneQCy43y/FDq+UaSbtBqkcNU5/rJDropZhdojb6NS4kTcwg3R+oGgh3MKNWf8xnJtarERrOy73u/BKbeJKE2LQGwijcu+qyZeHFnqN9MoX2dwS/Cug2VbOMdHgpDqvdFmC2SRRXFkgh23TuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DavuRVXBeMDnDkHDKMtM7o2Mid4XVWks73wRdwUISaI=;
 b=eKpjm/MxRy2B/+3hzB4zscg9BM/LHJMopzX7HBEKQ3yWk5O6en3LRFZNFoMkT5eY546fGh4sfJ6VzDpCjLemk3fQSGpPvv5BOn7uE7tC3wrMDFsyIjGUJMfNr0AZIA9+T7MEle1axnvQZvS1139ADFt0NhMsaHfszkIgbcPrMBbsjXAqLngLFWFUC6/ZrsNbnnB0dHawE3hV6XLhBVNWUdWdGcJuecZAxbioi7bHyLfSI6kuxGMIYdbOgoZdhJFSfvRXvVaL15eGyBadDpuJ/mprONp2z+zta0YdTde/FtL5gsYoc47p0KU81JHO5gP6sLDfpZQVqClIoK0/Ld5Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DavuRVXBeMDnDkHDKMtM7o2Mid4XVWks73wRdwUISaI=;
 b=3ox6lG9KZDt7a7biiJi3DwJbGuoB9r4IPIiVyF0lwbbyGWO+c5Eue/nXhjltyn+OP7WLAyhY2WgEXUJKH9pm7sKyLrd0B1ofGGVl+k683ysHEpIy15NsUVYeaA2kxxUALjH6x5jjNdRnasaEaBXyoNp6XQb7MlBXhQHv+HXTS1k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 15:14:22 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Thu, 4 Feb 2021
 15:14:22 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
 <20210202171748.1062530-2-alexander.deucher@amd.com>
 <MN2PR12MB454926B93FE2B67447AF46A197B49@MN2PR12MB4549.namprd12.prod.outlook.com>
 <CADnq5_NH0ezDtVhOE-teJZBZNdDV22is1jVkaKxe7pcof8-qbg@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b153dea1-2c64-5607-028f-855c1c86fea7@amd.com>
Date: Thu, 4 Feb 2021 10:14:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_NH0ezDtVhOE-teJZBZNdDV22is1jVkaKxe7pcof8-qbg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 15:14:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 109840f0-018b-45a8-c7b2-08d8c91f8cdb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41096DB5DF3F265D33D4272B92B39@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZSRtg/6js14GoLrESwK6bMbzl+iZfR4pON4SpAKlokQ05kKfiXrKvwHC5NtPf9uTaIlrR3bq0s947yZFtEnT5LNs/9dIBfm6/BmhBJ4oMEAuSfbVJqnngt7FWxO7/Ura5tjvNADMH0+4vJrYYoVtr2jjO2KIkKXmwq9k+vV0Fv6MReLihYrdM7tvm3zhC2k3UnVfjEhrDb0RoJetfPf+HP/DNqRWD31oe2uugCslgw2o9cyaXK2jnhU5EagnZdO+DL68a9e0THuJeKljcP5AW1kmPoOoCNAWPDJvAdFmeKNL06WqjYNMkZfVUPDXH7OauP0CxPT9PhFam2LmbiUy1l1emIc4M2d8OkOCJJiDupQirAd9ykSRhDM324Q4m6MvikF8/HBnzxUtC4ayYH642Q9p0j1Vo84Te8A+sq6SrvsBDkz/pjCBrJ1pbn/vSPB8AjaWPgeZzWEZGDLsh34EsIRRc+qG3IOzWsqLndtbVIjj8dSpOQhjknZm3SHbZfBrEC8SicHhUw90L+6P71kAZAhlvPJf4OzEPPYAvtnUHWB3t/NAtTdBilAaQPctuXntf6sT+dsC+DxavlxTtisJtkr4B6geZnAY1Sc841h7f9WhEE9AHkgBC5YBms4MwoH52szmma3J5rN7t7xhVkQUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6636002)(53546011)(26005)(8936002)(83380400001)(478600001)(66556008)(66476007)(4326008)(66946007)(36756003)(44832011)(6486002)(54906003)(956004)(8676002)(2616005)(16576012)(31686004)(5660300002)(966005)(2906002)(16526019)(186003)(110136005)(31696002)(52116002)(86362001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZlRZa3pVcTcyVVV0SEJEMnZaKy9PRktTckhpUFVqeU80MU8yeU45SnYwMjIv?=
 =?utf-8?B?a1BMN2RCQVk2aVcyMmtjTjdwV084SWpNeHErcjNyQ21JVzl5V0QxODJ0d0Vw?=
 =?utf-8?B?K0VQRzBmcC80SVN6dHBGaDhXZWpGQTZXR2RGV3V5dE9ZbXh1eDR4UjhRWEdn?=
 =?utf-8?B?N0RlUVRtZ1VJaXAvWmxFZUYyb09qS2RDVFVUcFRNQU1ZS2dIR2RaMjhEMjhU?=
 =?utf-8?B?YlYvOURnSWh6elZQcDlTdXU1YXBQaUJwRXFOSHIvR21FVENWYUliSk5aY0Fw?=
 =?utf-8?B?QW5VcytkS0hZUHFXNGFNaTZ4ZW1wNWZTSndoWE9BZ2hWTFlidXZsbTQrclM5?=
 =?utf-8?B?ZGtEdjNCbDJGSmFWZVVrQUJwNTFha0dFVkdvWXBWbUNERzJsY3FKNjBJbWlh?=
 =?utf-8?B?dlljOTVsZWtnbEtRN0ozbk5SeVFLc2pMdVlUSC92RnYxL0ZUUWFoZzJLY1I1?=
 =?utf-8?B?RngvbHl3MGNoOW5zQmNZNmVTMmxCemxhOVVNajg1aGRkK0VySlVJU1NTVm8z?=
 =?utf-8?B?S2FlV3pES3RlWG01UVhCTHZLeUkrSnR0ZElpREVLZ3BYQXZUT2h2SzlNMytt?=
 =?utf-8?B?MkZXRVdMaWpvQ2FNYXFJSTVaODZ4QnZlVVloR0pOVUhZMytNY0svL1NMTGVF?=
 =?utf-8?B?SlE0TUhIT0doTzVlcmFjSlF3bXlldEtRczUyU3Y0NTZ6ZXBNTk83OGlpWURD?=
 =?utf-8?B?TzJnZll4cWdEZzBVSlhIYjZ2TG5QYmt1VEVTTjNBWEdRUklDMGVHem5vako4?=
 =?utf-8?B?Y2dCUStqYVA5Z2psTUhNTnBlcWdYZTE3SklmeFVONEp6YmFLZUE0dWg3YUw3?=
 =?utf-8?B?enhDR29vY3JhMFFKaWRqd09DUzZzRkJIL2NwekZOL1AydFY2cGE3ZUpoMzFU?=
 =?utf-8?B?VURUYjJzOVpBWXpZUDB2MERKdlZmWnFuVFFXa2RCQnJtVHlQb2xXOC9DNFky?=
 =?utf-8?B?Y2JxalY4RDc0d3VFN2xIM0k0NVE1dlV4ckQ0Mk5tbWFjSllFKzNHSmdHUFhw?=
 =?utf-8?B?V3ZwcmJkYVd5Y2JJMmhBbEU1NDJodkl6ZHBTT1JVN1BIR3MxWHp1SjRFMTNx?=
 =?utf-8?B?K0lleDlRVm1tR2RMNU81RGxTNzhTV01yV05SWTJOeW1DYUgyWnN4MWFYU2hW?=
 =?utf-8?B?ZmpUK1AvU2w2M1NTQmhqWGVUd1dOMHNFdjQzRHBCcTZGUC9wb0xhUURaTVlH?=
 =?utf-8?B?d1dzenhtK2xRQXY5a3Zhamt6NEpzbTkyOXZHNXg3U3RHclpyOWcyWFhsVG1X?=
 =?utf-8?B?RHNFQUV3RS9ISTBuNHBkZmo2bUNvQnIwSHpCWjRLMDlzYzZBMjZlbkJnamxC?=
 =?utf-8?B?NEZJOUUyNkZCVFBORFh6ZUJSbCtrWnlqZTljdmo4VnhqSkp3ejJSbExEcmF1?=
 =?utf-8?B?Z2JnREdmWmZud1B3SEdGT09LTTZxM3ZvNmpKTGFTOFpjbit0aVducGtiZk0y?=
 =?utf-8?B?NHdyc0dYbEczckJxTVpIT05ReUs2cElRV3FvRTQ3emhvQTBvTGg4dFpuSjNB?=
 =?utf-8?B?dmpLbmREc3BqdmNBb2FyQndQanlYYzlJeldHQ3RyOEFpaUJZbjEzSHJWalhw?=
 =?utf-8?B?YXFuY3gvdmpjcTZPNkJLeVU0MHpLbWViMkdDb1dTZWtESTBweXhiMnpZMkp5?=
 =?utf-8?B?MUthQVBRaHcrUUI0WE9nYzhEN3krbDFZS3BZUmNacEFFL2E5WXIxVlBGODhm?=
 =?utf-8?B?RVc3RW53a3RWQi9kOGlUd3RNbE55VituUHNRRkFMYjhKVGJrYmRSeUY0aFQr?=
 =?utf-8?B?MlhlTWNsU21oZzlXRDVKQnBsa0xVZU4wY09PQmZDbXhrSHNmYmYrSllhV2tY?=
 =?utf-8?B?THp0WHR5VVJEMXR2dnk5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109840f0-018b-45a8-c7b2-08d8c91f8cdb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 15:14:21.8970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks6bMI8zjFGAiyTjypHmjM6xgIRyazB/I8tlkn1F3vnlLzVa2OF+t+1+DRc/Z9HoTvME8Jo/G3mirCt2ZH0nYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDItMDQgdW0gOTozNyBhLm0uIHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+IE9uIFdl
ZCwgRmViIDMsIDIwMjEgYXQgMjo1NiBBTSBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29t
PiB3cm90ZToKPj4gW0FNRCBQdWJsaWMgVXNlXQo+Pgo+Pgo+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyCj4+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1
YXJ5IDIsIDIwMjEgMTA6NDggUE0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+Cj4+
IFN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGVuYWJsZSBEUE1fRkxBR19NQVlfU0tJ
UF9SRVNVTUUgYW5kIERQTV9GTEFHX1NNQVJUX1NVU1BFTkQgZmxhZ3MKPj4KPj4gT25jZSB0aGUg
ZGV2aWNlIGhhcyBydW50aW1lIHN1c3BlbmRlZCwgd2UgZG9uJ3QgbmVlZCB0byBwb3dlciBpdCBi
YWNrIHVwIGFnYWluIGZvciBzeXN0ZW0gc3VzcGVuZC4gIExpa2V3aXNlIGZvciByZXN1bWUsIHdl
IGRvbid0IHRvIHBvd2VyIHVwIHRoZSBkZXZpY2UgYWdhaW4gb24gcmVzdW1lIG9ubHkgdG8gcG93
ZXIgaXQgYmFjayBvZmYgYWdhaW4gdmlhIHJ1bnRpbWUgcG0gYmVjYXVzZSBpdCdzIHN0aWxsIGlk
bGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMgfCA2ICsrKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+IGluZGV4IGI0NzgwMTgyZjk5
MC4uYjc4ODQ3ZmE3NjliIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfa21zLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ttcy5jCj4+IEBAIC0yMDYsNiArMjA2LDEyIEBAIGludCBhbWRncHVfZHJpdmVyX2xvYWRfa21z
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQo+PiAgICAg
ICAgICAgICAgICAgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYXRweChkZXYpICYmCj4+ICAg
ICAgICAgICAgICAgICAgICAgIWFtZGdwdV9pc19hdHB4X2h5YnJpZCgpKQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfcG1fc2V0X2RyaXZlcl9mbGFncyhkZXYtPmRldiwgRFBNX0ZMQUdf
Tk9fRElSRUNUX0NPTVBMRVRFKTsKPj4gKyAgICAgICAgICAgICAgIC8qIHdlIHdhbnQgZGlyZWN0
IGNvbXBsZXRlIGZvciBCT0NPICovCj4+ICsgICAgICAgICAgICAgICBpZiAoKGFtZGdwdV9kZXZp
Y2Vfc3VwcG9ydHNfYXRweChkZXYpICYmCj4+ICsgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2lz
X2F0cHhfaHlicmlkKCkpIHx8Cj4+ICsgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV9z
dXBwb3J0c19ib2NvKGRldikpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9wbV9zZXRf
ZHJpdmVyX2ZsYWdzKGRldi0+ZGV2LCBEUE1fRkxBR19TTUFSVF9TVVNQRU5EIHwKPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFBNX0ZMQUdfTUFZX1NL
SVBfUkVTVU1FKTsKPj4KPj4gRGV2aWNlIHJ1bnRpbWUgc3VzcGVuZCBjYWxsYmFjayBkb2VzIC0K
Pj4gICAgICAgICBhbWRncHVfZGV2aWNlX3N1c3BlbmQoZHJtX2RldiwgZmFsc2UpCj4+Cj4+IFN5
c3RlbSBzdXNwZW5kIGNhbGxiYWNrIGRvZXMgLQo+PiAgICAgICAgIGFtZGdwdV9kZXZpY2Vfc3Vz
cGVuZChkcm1fZGV2LCB0cnVlKQo+Pgo+PiBPbmUgb2YgdGhlIGVmZmVjdHMgb2YgdGhpcyBmbGFn
IGlzIGZvciBLRkQgdG8gZGVjaWRlIHdoZXRoZXIgdG8gZXZpY3QgYWxsIHByb2Nlc3Nlcy4gSXQg
aXMgZG9uZSBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgYnV0IG5vdCBkdXJpbmcgcnVudGltZSBkZXZp
Y2Ugc3VzcGVuZC4gV2lsbCB0aGF0IGhhdmUgYW4gaW1wYWN0IGlmICB0aGUgc3lzdGVtIHN1c3Bl
bmQgcm91dGluZSBpcyBza2lwcGVkIGluIHRoaXMgd2F5Pwo+ICsgUmFqbmVlc2gKPgo+IENhbiB5
b3UgY29tbWVudCBvbiB0aGlzPyAgSWRlYSBvZiB0aGlzIHBhdGNoIGlzIHRvIG5vdCB3YWtlIHRo
ZSBkZXZpY2UKPiBmb3Igc3lzdGVtIHN1c3BlbmQgYW5kIHJlc3VtZSBpZiBpdCdzIGFscmVhZHkg
aW4gcnVudGltZSBzdXNwZW5kLgpLRkQgb25seSBhbGxvd3MgcnVudGltZSBzdXNwZW5kIHdoZW4g
dGhlcmUgYXJlIG5vIHByb2Nlc3NlcyB1c2luZyB0aGUKR1BVLiBUaGVyZWZvcmUgaXQgc2hvdWxk
IGJlIHNhZmUgKGluIHRoZW9yeSkgdG8gc2tpcCBwcm9jZXNzIGV2aWN0aW9uIGlmCnlvdSdyZSBh
bHJlYWR5IGluIHJ1bnRpbWUgc3VzcGVuZC4gSnVzdCBtYWtlIHN1cmUgYWxsIHRoZSBzdXNwZW5k
L3Jlc3VtZQpjYWxscyBpbnRvIEtGRCBhcmUgcGFpcmVkIHVwIGNvcnJlY3RseS4gSWYgeW91IHNr
aXAgc3VzcGVuZCBidXQgdGhlbgpsYXRlciBjYWxsIHJlc3VtZSBhbnl3YXksIGl0IHdpbGwgbGlr
ZWx5IGNhdXNlIHByb2JsZW1zLgoKRm9yIHRlc3RpbmcgdGhpcywgSSdkIHN1Z2dlc3QgcnVubmlu
ZyBzb21lIEtGRCBhcHBsaWNhdGlvbiAoZS5nLiBrZmR0ZXN0Cm9yIGFuIE9wZW5DTCBhcHAgd2l0
aCBST0NtLWJhc2VkIE9wZW5DTCkgYmVmb3JlIHN1c3BlbmQsIHRoZW4gc3VzcGVuZCwKdGhlbiBy
dW4gdGhlIGFwcCBhZ2FpbiBhZnRlciByZXN1bWUgdG8gbWFrZSBzdXJlIEtGRCBpcyBzdGlsbCBn
b29kLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gQWxleAo+Cj4+IFRoYW5rcywKPj4gTGlqbwo+
Pgo+PiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV91c2VfYXV0b3N1c3BlbmQoZGV2LT5kZXYp
Owo+PiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoZGV2
LT5kZXYsIDUwMDApOwo+PiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV9hbGxvdyhkZXYtPmRl
dik7Cj4+IC0tCj4+IDIuMjkuMgo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
