Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5CC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DAA613F6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DAA613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD3A6EC86;
	Wed, 26 May 2021 11:21:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CE86EC86
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 11:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxF7QGfu85s3gvnmYXfIgP0MefhTI/hnAFUdvwZkPqwQJSibgNQwVEkQqhQqmZbwKmAOQZKFyMcqw8AaB47oR+A4IuMY+Cy2H57Ho8d/vA88hwrorFnbeDauSnaOE/zyVNpPFAHgdfog2ZpOuXUzpuDxqqc/ikz7uiDZOzI781x4flFdnWi9ABKKGm4yyhlHhSg0o/3ulWdNFmNQawM0uXECa0DwHWBv/iMjp6FBkAxPSD/AeeIOImhoxHzhTmLWm6FfudSPSfUU+/MQK9x0cl0zIuRaQ3EvLY0QUCWzwCAZrx27sH3vgMjdgGxvxGU7K+nW8FtJiUdE4hcle/UjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPpWvhUkm9J1ZoSYHqA4uoji7zxuQ+uTGWrlqGk4U8w=;
 b=MHBhziXqPG0lBEMb20AhVnFx+MnIPYEiUoH4ybiUXHOD6yuKizBYDKOiL38sxJ1gxEVM93lzCns/c74omGohGULFFCD3bHmKAfEruPoxrYy43Ug5r9oJW0Wvoi3uguO2GHheYbWkkS2cKRQiECttzge/bpb2ww6ni4UNsPKfv6xeiDqOgGel545LQUUT8jxYVCKc0tup8B13A4cvYxfrjWdw4x8/YQCAvHYydbqH0Jy0nWEWrAJg7+bAG9ttSLTIJxsfu7hozn9nM5PjiAuahqpKXUeMF+byxvg9isNCRjOPAAtP5p5566SMOkOXfsHBJjUbAyDbqRbDhhU88UjreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPpWvhUkm9J1ZoSYHqA4uoji7zxuQ+uTGWrlqGk4U8w=;
 b=1A8UFXJJIt0lvLuAxEP6P1Q01qCcvj2iGEHk/yWo8srHd8+cxnXm9aeWxMY3ifRelExHtDA9+l75QVPzvakFIq+67vb/LwcjRD7cMfr664HLnS9k2GlgjHTSPHmoJK1jjgpSKoYD1b4d9qAxVWKFkdXd9pbnLkcPccTXldA2cj0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 11:21:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 11:21:32 +0000
Subject: Re: radeon ring 0 test failed on arm64
To: Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, Peter Geis <pgwipeout@gmail.com>
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
Date: Wed, 26 May 2021 13:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7216:94bf:3812:bd88]
X-ClientProxiedBy: AM0PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::40) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7216:94bf:3812:bd88]
 (2a02:908:1252:fb60:7216:94bf:3812:bd88) by
 AM0PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:208:3e::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 11:21:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8de7af9-bc4b-4b38-0797-08d920386a76
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41257220E420C96F05DA138483249@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmC+yGxTfmZjSgQqkbxSvJdQs+xFA/R9WIoBL/pvoaK5wf3wpw9xNj8xwcUfw90lA3Y6DHU6o/VVFKihvK0kpnWgFz1FoqWhyH1/ygr0A1LxZvTL0Cso/r2Svbdsxm5vymfpLxVcA5e76BAw0n83O1WIOthDLaa0qESzHK0lnl6H41ySgMDW7k3YTc6EkVf0BU+Zxcl4MzIWC4F4zaiHVR6+QocE/QCrKS15oOvvHkeCwVWdmFnfYR5sST42c06caGmWZH/RB/fhc8mgnCCsUmNdNF1lyg5/71I2MxcVJ55rxgANlvFTpR4u2pxjkN8+zjUsyysgFSjOy3lnHKF0Hv4fX6HwCqa0WGDuygYGsH2tOSCIhPVYUB2Ugz1ceFfDebRzIUVhqoH+31RU6uI1T27mXZYmaYZcriYa03nNwk7JfUmHBoJ2sSFXlLEWAym0cBnZhJu34/8ELFdo2XWcWADXuV20ZfKID9scMOnwXQqtOGCewhBKT4btHbUto0xvGYVXke9vYuXvJ/b4cz8AWDiH304sxNxGcaOSt/NekbvD6mOWIGFt59ga3pR9nj1F8aNH3I0lxMELDYAdMaEH8ZY5Ko9KHqgkbQXV3O+QUAWau5gTvHLQdnyVDNPXlcERCIahiPDgxSj5GE+hIWQzMc465jDOYhJBoJmcnTe2IKppZIAsrko/Z2efgM+kOT2I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(31696002)(52116002)(2616005)(86362001)(16526019)(186003)(6666004)(66946007)(66556008)(31686004)(53546011)(54906003)(5660300002)(110136005)(6486002)(8676002)(8936002)(2906002)(4326008)(83380400001)(66574015)(38100700002)(478600001)(66476007)(36756003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djJlN3MrczZnWEJUelg2ZUpXMkt1N09KUXB6MnQxcG9QeG5BaytoVEV3QzZk?=
 =?utf-8?B?eWpqMllzSklyU1VXWlFrRjR0cEh1ZG1HZTgvYlJTS3l5M0hoNXJhVERwaDVT?=
 =?utf-8?B?OTN6SXdTMkJtQnZOcVNvWStZNGJjWHc5VWFuVU5IazlHblZzdk9id0I0Tko0?=
 =?utf-8?B?emQ1dVJ2dndTaWFleEZQZkptRUI1VjVqQ3ZYdWN1S21vWDlEVEhKUzRCMGt5?=
 =?utf-8?B?UmFXTWdUQnFlUER2ZEZ0Q2pvL3E4VnM5dEFIblNtcWluSE9VR3ZPMkFHekxD?=
 =?utf-8?B?V1JyN3BUSzZFWTVNRDFNZ3BWbEpHVkVMTFZKZDZZTldMY1M5QndNaHhEN1Y1?=
 =?utf-8?B?RWFnUm5QTFBwSlRBRFViU0pRNGhZQzFHSThJWGFtK0NvZ1gvMU41SFRuRXhY?=
 =?utf-8?B?cDFuQlRSaDdLMG5zakMyRzFiYkhZS1dPeHBObWJ2Nm9lNmVtaDhlLzBoeFZL?=
 =?utf-8?B?R0VBQzd0bzY0eW9xYlRMbnRiUzBXRE1Nd09ZTE1odDM3aHVvUDVIRGdSa0h0?=
 =?utf-8?B?NnA5YWtpbFlwRnJEVmZVUm5rOTQ1elFGZWlaQU0xd1JTTDRISEVEaWRjcHpC?=
 =?utf-8?B?WDZweWYvSk1oYmhESFZqZXpEYU5TTm1pWW9YNXh1bG1qNU82cGZ2L3JwbHJu?=
 =?utf-8?B?ckQ0WGorVk96dXMwUTJ1ZWsxTEE1S1V2R1E0aWZuMWVIZWUreThGQ1JkSEdS?=
 =?utf-8?B?NThQTWJMRkxGdEwrOTUwa2RMSzd1UmJNNUw3Sk1mVFNmTy95RkgzUVhjYXhL?=
 =?utf-8?B?UmFhNFpzcjRWd2d1TlhaMTRvTXd4UjdRQmlzNnpaOEhZdkxxSTYvZGxTWmRq?=
 =?utf-8?B?OGl3OUE3K211SHBGVGloZGtxeHZqcUUvNGJqUnVZMEF1TnB6REpKSTQ2Q25l?=
 =?utf-8?B?OXBVenBabWFOcDkzNU12ZWQ4QUlqMTJpSTR4d2FIcWRKaUpFaHhzR0dBdTAw?=
 =?utf-8?B?aHRpTmZObENsaVVVOFZ3SWhNWG55U0RaTXQ4cFdEQ0lRQ0tCMHg4cXM2V2xu?=
 =?utf-8?B?WlhhRkIyMVYrWVZZSkh5c1hlbE8ydHZHcDgzNlZxaTNMclFpcERQY2hWd2xE?=
 =?utf-8?B?cXdPOVNYc3BSQnlkMGFNMS9vSyt6WDdkV2xzaTdSbmxkdGVLVkt6eERHOElL?=
 =?utf-8?B?aXlXTnB2QndVM2h1U3FsSkwzeVNHcUlnMXF3MVBDazhkNDVlaUtrVnVnWjFH?=
 =?utf-8?B?dE1WR2VZZ2ZkZ3VvWHZqRWFVTmFEdFFjV2lMY2svQzdMQ1lYd1h4bkRlQllD?=
 =?utf-8?B?UHV3S2t6N3g4UWZ0Z3JhUXpOVUtxTWdPSEI5UUs4UU5hVGVWdUdmbkg2Y0tP?=
 =?utf-8?B?NDV4MnNLeE54S2tnSWN6NEw5bzRLWHF0ajI5aDZKRllqZHlEd3dRNGs2aXAx?=
 =?utf-8?B?dXdvZGJJWDZ0MU1VZ0NGdGp1VDRWN3NUQmRrWU5aTjRqQU5xMGFjTXQ4a2VZ?=
 =?utf-8?B?VUEyTnNRMmZGY0ZKVUEzY2V5b09uWWNJVS80K2xRcFFZakN2UVNoOEpOZC8r?=
 =?utf-8?B?ODN4RW1KZ0hQV205WWZsd0VWeldSRlVycWJvZDJFSzNSUFZGNWRRWW40dmVm?=
 =?utf-8?B?OWZ6aExjKzJRK0Z5QnQ5d1U5SDdwZmx3Z2xlUldIMjNNa2c1aTBWeHRoRWEv?=
 =?utf-8?B?RTg0MHdoNytOaGljMC9OazRHenB1eEtWVlZNMnBOM0MxWm5ueWZiV2pIa2pD?=
 =?utf-8?B?R016Rll2NWJrSE5WTVdaWXBHMDhaSWlpVzJTNTBWRWFqVk0rOEhpRnQ4NXF4?=
 =?utf-8?B?NC90bW5UeFAyeTFJTFl6dzB2YkwyanpnVTFlSnl5d2t3YVJjR2o5RFBzdWtY?=
 =?utf-8?B?NDZxbVZnVk1YYUowdjR5dFQ2UHFrWlY5NzR5cW1qRnBUNjNQWE0ybnBEbUF4?=
 =?utf-8?Q?cnW+7zIU4s5t3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8de7af9-bc4b-4b38-0797-08d920386a76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 11:21:32.7832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ/Cqa1X7ll+wyQYbt9H2v9uJEVOpiqXAXpqKHxIk7cWDVD7AXtR0cLvlzvfOUZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgUm9iaW4sCgpBbSAyNi4wNS4yMSB1bSAxMjo1OSBzY2hyaWViIFJvYmluIE11cnBoeToKPiBP
biAyMDIxLTA1LTI2IDEwOjQyLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBIaSBSb2JpbiwK
Pj4KPj4gQW0gMjUuMDUuMjEgdW0gMjI6MDkgc2NocmllYiBSb2JpbiBNdXJwaHk6Cj4+PiBPbiAy
MDIxLTA1LTI1IDE0OjA1LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+Pj4gT24gVHVlLCBNYXkgMjUs
IDIwMjEgYXQgODo1NiBBTSBQZXRlciBHZWlzIDxwZ3dpcGVvdXRAZ21haWwuY29tPiAKPj4+PiB3
cm90ZToKPj4+Pj4KPj4+Pj4gT24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgODo0NyBBTSBBbGV4IERl
dWNoZXIgCj4+Pj4+IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+
IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDg6NDIgQU0gUGV0ZXIgR2VpcyA8cGd3aXBlb3V0QGdt
YWlsLmNvbT4gCj4+Pj4+PiB3cm90ZToKPj4+Pj4+Pgo+Pj4+Pj4+IEdvb2QgRXZlbmluZywKPj4+
Pj4+Pgo+Pj4+Pj4+IEkgYW0gc3RyZXNzIHRlc3RpbmcgdGhlIHBjaWUgY29udHJvbGxlciBvbiB0
aGUgcmszNTY2LXF1YXJ0ejY0IAo+Pj4+Pj4+IHByb3RvdHlwZSBTQkMuCj4+Pj4+Pj4gVGhpcyBk
ZXZpY2UgaGFzIDFHQiBhdmFpbGFibGUgYXQgPDB4MyAweDAwMDAwMDAwPiBmb3IgdGhlIFBDSWUK
Pj4+Pj4+PiBjb250cm9sbGVyLCB3aGljaCBtYWtlcyBhIGRHUFUgdGhlb3JldGljYWxseSBwb3Nz
aWJsZS4KPj4+Pj4+PiBXaGlsZSBhdHRlbXB0aW5nIHRvIGxpZ2h0IG9mZiBhIEhENzU3MCBjYXJk
IEkgbWFuYWdlIHRvIGdldCBhIAo+Pj4+Pj4+IG1vZGVzZXQKPj4+Pj4+PiBjb25zb2xlLCBidXQg
cmluZzAgdGVzdCBmYWlscyBhbmQgZGlzYWJsZXMgYWNjZWxlcmF0aW9uLgo+Pj4+Pj4+Cj4+Pj4+
Pj4gTm90ZSwgd2UgZG8gbm90IGhhdmUgVUVGSSwgc28gYWxsIFBDSWUgc2V0dXAgaXMgZnJvbSB0
aGUgTGludXggCj4+Pj4+Pj4ga2VybmVsLgo+Pj4+Pj4+IEFueSBpbnNpZ2h0IHlvdSBjYW4gcHJv
dmlkZSB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLgo+Pj4+Pj4KPj4+Pj4+IERvZXMgeW91ciBw
bGF0Zm9ybSBzdXBwb3J0IFBDSWUgY2FjaGUgY29oZXJlbmN5IHdpdGggdGhlIENQVT/CoCBJLmUu
LAo+Pj4+Pj4gZG9lcyB0aGUgQ1BVIGFsbG93IGNhY2hlIHNub29wcyBmcm9tIFBDSWUgZGV2aWNl
cz/CoCBUaGF0IGlzIHJlcXVpcmVkCj4+Pj4+PiBmb3IgdGhlIGRyaXZlciB0byBvcGVyYXRlLgo+
Pj4+Pgo+Pj4+PiBBaCwgbW9zdCBsaWtlbHkgbm90Lgo+Pj4+PiBUaGlzIGlzc3VlIGhhcyBjb21l
IHVwIGFscmVhZHkgYXMgdGhlIEdJQyBpc24ndCBwZXJtaXR0ZWQgdG8gc25vb3Agb24KPj4+Pj4g
dGhlIENQVXMsIHNvIEkgZG91YnQgdGhlIFBDSWUgY29udHJvbGxlciBjYW4gZWl0aGVyLgo+Pj4+
Pgo+Pj4+PiBJcyB0aGVyZSBubyB3YXkgdG8gd29yayBhcm91bmQgdGhpcyBvciBpcyBpdCBkZWFk
IGluIHRoZSB3YXRlcj8KPj4+Pgo+Pj4+IEl0J3MgcmVxdWlyZWQgYnkgdGhlIHBjaWUgc3BlYy7C
oCBZb3UgY291bGQgcG90ZW50aWFsbHkgd29yayBhcm91bmQgaXQKPj4+PiBpZiB5b3UgY2FuIGFs
bG9jYXRlIHVuY2FjaGVkIG1lbW9yeSBmb3IgRE1BLCBidXQgSSBkb24ndCB0aGluayB0aGF0IGlz
Cj4+Pj4gcG9zc2libGUgY3VycmVudGx5LsKgIElkZWFsbHkgd2UnZCBmaWd1cmUgb3V0IHNvbWUg
d2F5IHRvIGRldGVjdCBpZiBhCj4+Pj4gcGFydGljdWxhciBwbGF0Zm9ybSBzdXBwb3J0cyBjYWNo
ZSBzbm9vcGluZyBvciBub3QgYXMgd2VsbC4KPj4+Cj4+PiBUaGVyZSdzIGRldmljZV9nZXRfZG1h
X2F0dHIoKSwgYWx0aG91Z2ggSSBkb24ndCB0aGluayBpdCB3aWxsIHdvcmsgCj4+PiBjdXJyZW50
bHkgZm9yIFBDSSBkZXZpY2VzIHdpdGhvdXQgYW4gT0Ygb3IgQUNQSSBub2RlIC0gd2UgY291bGQg
Cj4+PiBwZXJoYXBzIGRvIHdpdGggYSBQQ0ktc3BlY2lmaWMgd3JhcHBlciB3aGljaCBjYW4gd2Fs
ayB1cCBhbmQgZGVmZXIgCj4+PiB0byB0aGUgaG9zdCBicmlkZ2UncyBmaXJtd2FyZSBkZXNjcmlw
dGlvbiBhcyBuZWNlc3NhcnkuCj4+Pgo+Pj4gVGhlIGNvbW1vbiBETUEgb3BzICpkbyogY29ycmVj
dGx5IGtlZXAgdHJhY2sgb2YgcGVyLWRldmljZSBjb2hlcmVuY3kgCj4+PiBpbnRlcm5hbGx5LCBi
dXQgZHJpdmVycyBhcmVuJ3Qgc3VwcG9zZWQgdG8gYmUgcG9raW5nIGF0IHRoYXQgCj4+PiBpbmZv
cm1hdGlvbiBkaXJlY3RseS4KPj4KPj4gVGhhdCBzb3VuZHMgbGlrZSB5b3UgdW5kZXJlc3RpbWF0
ZSB0aGUgcHJvYmxlbS4gQVJNIGhhcyB1bmZvcnR1bmF0ZWx5IAo+PiBtYWRlIHRoZSBjb2hlcmVu
Y3kgZm9yIFBDSSBhbiBvcHRpb25hbCBJUC4KPgo+IFNvcnJ5IHRvIGJlIHRoYXQgZ3V5LCBidXQg
SSdtIGludm9sdmVkIGEgbG90IGludGVybmFsbHkgd2l0aCBvdXIgCj4gc3lzdGVtIElQIGFuZCBp
bnRlcmNvbm5lY3QsIGFuZCBJIHByb2JhYmx5IHVuZGVyc3RhbmQgdGhlIHNpdHVhdGlvbiAKPiBi
ZXR0ZXIgdGhhbiA5OSUgb2YgdGhlIGNvbW11bml0eSA7KQoKSSBuZWVkIHRvIGFwb2xvZ2l6ZSwg
ZGlkbid0IHJlYWxpemVkIHdobyB3YXMgYW5zd2VyaW5nIDopCgpJdCBqdXN0IHNvdW5kZWQgdG8g
bWUgdGhhdCB5b3Ugd2FudGVkIHRvIHN1Z2dlc3QgdG8gdGhlIGVuZCB1c2VyIHRoYXQgCnRoaXMg
aXMgZml4YWJsZSBpbiBzb2Z0d2FyZSBhbmQgSSByZWFsbHkgd2FudGVkIHRvIGF2b2lkIGV2ZW4g
bW9yZSAKY3VzdG9tZXJzIGNvbWluZyBhcm91bmQgYXNraW5nIGhvdyB0byBkbyB0aGlzLgoKPiBG
b3IgdGhlIHJlY29yZCwgdGhlIFNCU0Egc3BlY2lmaWNhdGlvbiAodGhlIGNsb3NldCB0aGluZyB3
ZSBoYXZlIHRvIGEgCj4gInN5c3RlbSBhcmNoaXRlY3R1cmUiKSBkb2VzIHJlcXVpcmUgdGhhdCBQ
Q0llIGlzIGludGVncmF0ZWQgaW4gYW4gCj4gSS9PLWNvaGVyZW50IG1hbm5lciwgYnV0IHdlIGRv
bid0IGhhdmUgYW55IGNvbnRyb2wgb3ZlciB3aGF0IHBlb3BsZSBkbyAKPiBpbiBlbWJlZGRlZCBh
cHBsaWNhdGlvbnMgKG5vdGUgdGhhdCB3ZSBkb24ndCBtYWtlIFBDSWUgSVAgYXQgYWxsLCBhbmQg
Cj4gdGhlcmUgaXMgcGxlbnR5IG9mIDNyZC1wYXJ0eSBpbnRlcmNvbm5lY3QgSVApLgoKU28gYmFz
aWNhbGx5IGl0IGlzIG5vdCB0aGUgZmF1bHQgb2YgdGhlIEFSTSBJUC1jb3JlLCBidXQgcGVvcGxl
IGFyZSBqdXN0IApzdGl0Y2hpbmcgdG9nZXRoZXIgUENJZSBpbnRlcmNvbm5lY3QgSVAgd2l0aCBh
IGNvcmUgd2hlcmUgaXQgaXMgbm90IApzdXBwb3NlZCB0byBiZSB1c2VkIHdpdGguCgpEbyBJIGdl
dCB0aGF0IGNvcnJlY3RseT8gVGhhdCdzIGFuIGludGVyZXN0aW5nIHB1enpsZSBwaWVjZSBpbiB0
aGUgcGljdHVyZS4KCj4+IFNvIHdlIGFyZSB0YWxraW5nIGFib3V0IGEgaGFyZHdhcmUgbGltaXRh
dGlvbiB3aGljaCBwb3RlbnRpYWxseSBjYW4ndCAKPj4gYmUgZml4ZWQgd2l0aG91dCByZXBsYWNp
bmcgdGhlIGhhcmR3YXJlLgo+Cj4gWW91IGV4cHJlc3NlZCBpbnRlcmVzdCBpbiAic29tZSB3YXkg
dG8gZGV0ZWN0IGlmIGEgcGFydGljdWxhciBwbGF0Zm9ybSAKPiBzdXBwb3J0cyBjYWNoZSBzbm9v
cGluZyBvciBub3QiLCBieSB3aGljaCBJIGFzc3VtZWQgeW91IG1lYW50IGEgCj4gc29mdHdhcmUg
bWV0aG9kIGZvciB0aGUgYW1kZ3B1L3JhZGVvbiBkcml2ZXJzIHRvIGNhbGwsIHJhdGhlciB0aGFu
LCAKPiBzYXksIGEgd2Vic2l0ZSB0aGF0IGRyaXZlciBtYWludGFpbmVycyBjYW4gbG9vayB1cCBT
b0MgbmFtZXMgb24uIEknbSAKPiBzYXlpbmcgdGhhdCB0aGF0IEFQSSBhbHJlYWR5IGV4aXN0cyAo
anVzdCBtYXkgbmVlZCBhIGJpdCBtb3JlIHdvcmspLiAKPiBOb3RlIHRoYXQgaXQgaXMgZW1waGF0
aWNhbGx5IG5vdCBhIHBsYXRmb3JtLWxldmVsIHRoaW5nIHNpbmNlIAo+IGNvaGVyZW5jeSBjYW4g
YW5kIGRvZXMgdmFyeSBwZXIgZGV2aWNlIHdpdGhpbiBhIHN5c3RlbS4KCldlbGwsIEkgdGhpbmsg
dGhpcyBpcyBub3Qgc29tZXRoaW5nIGFuIGluZGl2aWR1YWwgZHJpdmVyIHNob3VsZCBtZXNzIAp3
aXRoLiBXaGF0IHRoZSBkcml2ZXIgc2hvdWxkIGRvIGlzIGp1c3QgZXhwcmVzcyB0aGF0IGl0IG5l
ZWRzIGNvaGVyZW50IAphY2Nlc3MgdG8gYWxsIG9mIHN5c3RlbSBtZW1vcnkgYW5kIGlmIHRoYXQg
aXMgbm90IHBvc3NpYmxlIGZhaWwgdG8gbG9hZCAKd2l0aCBhIHdhcm5pbmcgd2h5IGl0IGlzIG5v
dCBwb3NzaWJsZS4KCj4KPiBJIHdhc24ndCBzdWdnZXN0aW5nIHRoYXQgTGludXggY291bGQgc29t
ZWhvdyBtYWtlIGNvaGVyZW5jeSBtYWdpY2FsbHkgCj4gd29yayB3aGVuIHRoZSBzaWduYWxzIGRv
bid0IHBoeXNpY2FsbHkgZXhpc3QgaW4gdGhlIGludGVyY29ubmVjdCAtIEkgCj4gd2FzIGFzc3Vt
aW5nIHlvdSdkIG1lcmVseSB3YW50IHRvIGRvIHNvbWV0aGluZyBsaWtlIHRocm93IGEgYmlnIAo+
IHdhcm5pbmcgYW5kIHRhaW50IHRoZSBrZXJuZWwgdG8gaGVscCB0cmlhZ2UgYnVnIHJlcG9ydHMu
IFNvbWUgZHJpdmVycyAKPiBsaWtlIGFoY2lfcW9yaXEgYW5kIHBhbmZyb3N0IHNpbXBseSBuZWVk
IHRvIGtub3cgc28gdGhleSBjYW4gcHJvZ3JhbSAKPiB0aGVpciBkZXZpY2UgdG8gZW1pdCB0aGUg
YXBwcm9wcmlhdGUgbWVtb3J5IGF0dHJpYnV0ZXMgZWl0aGVyIHdheSwgYW5kIAo+IHJlbHkgb24g
dGhlIERNQSBBUEkgdG8gaGlkZSB0aGUgcmVzdCBvZiB0aGUgZGlmZmVyZW5jZSwgYnV0IGlmIHlv
dSAKPiB3YW50IHRvIHRyZWF0IG5vbi1jb2hlcmVudCB1c2UgYXMgdW5zdXBwb3J0ZWQgYmVjYXVz
ZSBpdCB3b3VsZCByZXF1aXJlIAo+IHRvbyBpbnZhc2l2ZSBjaGFuZ2VzIHRoYXQncyBmaW5lIGJ5
IG1lLgoKWWVzIGV4YWN0bHkgdGhhdCBwbGVhc2UuIEkgbWVhbiBub3Qgc3VyZSBob3cgcGFuZnJv
c3QgaXMgZG9pbmcgaXQsIGJ1dCAKYXQgbGVhc3QgdGhlIFZ1bGthbiB1c2Vyc3BhY2UgQVBJIHNw
ZWNpZmljYXRpb24gcmVxdWlyZXMgZGV2aWNlcyB0byBoYXZlIApjb2hlcmVudCBhY2Nlc3MgdG8g
c3lzdGVtIG1lbW9yeS4KClNvIGV2ZW4gaWYgSSB3b3VsZCB3YW50IHRvIGRvIHRoaXMgaXQgaXMg
c2ltcGx5IG5vdCBwb3NzaWJsZSBiZWNhdXNlIHRoZSAKYXBwbGljYXRpb24gZG9lc24ndCB0ZWxs
IHRoZSBkcml2ZXIgd2hpY2ggbWVtb3J5IGlzIGFjY2Vzc2VkIGJ5IHRoZSAKZGV2aWNlIGFuZCB3
aGljaCBieSB0aGUgQ1BVLgoKQ2hyaXN0aWFuLgoKPgo+IFJvYmluLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
