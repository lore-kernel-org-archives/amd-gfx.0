Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54415C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB5C61350
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB5C61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27446E0CE;
	Mon, 14 Jun 2021 17:41:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3616E0CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvjS/E3GBLd4zlc5g+FbwiGkNSkmwCcoOgcR2n22dNJb/WU0dvtJsPSh2CNZHHeZvnf9j4tlVItNqzfDxO7dwJZeQ4F2wcwz8+KIysZhh1QUEvnMJYF58clxe6DDUNV/S0Ifiv3YdYEZXRbWhUxqfGXoTrhjl+Y+t/Lcj5RVMsXZq/saAQWmswEi/Jr1WRH7glbvBWfNSN6vWIqKaCMKhxIag6WDLinWq3S6WS4eUktMoYo+1dhqIJ+1cj+WozqpOA4SmO1P3bLcAqbUcuJ7MZf2ae6ll8DKRwdyTPEpxdLKteIWBaZWxTKA4zfZSXJeT88mg54UXQh3MNiDLskNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJEC+MpHFx6KUEI/Elnev2Z9EbTuglMohfsVnYbLh5c=;
 b=eKPfOtV4fnZUe7YXzSoG6No420XBwAx18rBb1UsL1udZ60AufirIpdoTzPkiFeDjM35BkGY1ii+I6XHO4nxH8GRfNjdWppi7keTQGZH69Qojd1gjH82eFsvS1GJdKYQjciY3zJ+uZSYbWCYmTTo5R8Zp0Xr5p16v4B7U8VQdlrBWxe07k7jmvzX4L1qtg8vyQR3WR56rfvPR+ae1AYwec6yltaWS7RexlKwUHi6+KIa58l54byHQpdg5Xlup1nVv9+fknCZcgoghMHdAEhGO8Kneuo5bsE/5P/XkdAvT6grcnUUQgZQNRq7ybkjDHvuWszv76udxX8Vh8ZbyH9rXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJEC+MpHFx6KUEI/Elnev2Z9EbTuglMohfsVnYbLh5c=;
 b=HaxpjVOqoAdN/3JJaTlqbqlMmdDiOPeIk5oWeo6SEBswi/uS0QOQgQMab7ALzQ76SGbdP68RS1lCIn8pR2xMSvmxPMhfcTtUcAPpIjvJv7C5u2m3lnNcZrR5625pKnb2zPvK+Dtl8kG+fXicg5Z3YDu5tZ6JD8huZ5afeNH6cuk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:40:58 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:40:58 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: parameterize ttm BO destroy callback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210614143217.10285-1-nirmoy.das@amd.com>
 <66eef795-40bf-49a0-d98e-9ec2724b5d25@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <727d5304-e73b-59b0-21be-8b5ae9caa2ec@amd.com>
Date: Mon, 14 Jun 2021 19:40:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <66eef795-40bf-49a0-d98e-9ec2724b5d25@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM0PR02CA0187.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::24) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM0PR02CA0187.eurprd02.prod.outlook.com (2603:10a6:20b:28e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Mon, 14 Jun 2021 17:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 654c821e-f1fe-47d4-105d-08d92f5b91d6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5053C3FA752A9C05922507CE8B319@DM4PR12MB5053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7nL5fnaGpKOdrccTcofBsCn6p4LenBWPr7JEmos4DguBOU9fUH4aW3KX6Y8leUlGMd2vGZWgeDxbMG48TjyD9Fq6AELd5HR041XzsoL0kepkZ/N5yj7L4Ryz8lH/d3TDMecAFyuq9i0zHhEViFYH5/8ogmrT1vttBWW2l4dGSQxsHs2tCX3Jx0KHmljLVLIPPMnUCGywKC0y1gPHGcSnG1V7lq8lNJWRHkCjmRgJKsDxEzrbTdqMGzkmzRF4737i4YAUWTzRL+psIIiDJIqMQYm3Ar/K5fpGnttkjbAXjgBqiqRaIQGjidPVHvTZ95T4lMf4sKyUFmr26vOmcZO1MddP+N+Yc4RTNjwVBfO6fgOOHiWGtCdZv7/8GCa6DtGrumWQ6s/KJrTK1WDPoNpVRezvJM7goPNVFCgyYcdNa11uBPQleJXYASE0m9j3YwmQjEze97koOq2CpiPg/HDax+KOE5HvuuH7K0c5UfnvfcpsAwquU01UFnpO3pnXJ/uboQCCtIdU7ph+qCA/3zJ60M0HqP9ughmMK8MkAhP9iSWGmfLfqRFtdBZsYhevUd8x17FvpR/2hj5ggsbGUru3payu107fhmzELjSKjYpy2n7XElLmWCRedzHy6UI5at7dNOEGhTGjz1/gQxeFnvmqUXork9FfHaFxM7jbGZFM6YNI/yVfkTyx3x/y4PFbwAC/8t7XWWDFSChUSo5mvIy1KlGFM+Nu/pqGndfaBX0HNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(2616005)(38350700002)(53546011)(6486002)(16576012)(956004)(38100700002)(316002)(8676002)(2906002)(36756003)(86362001)(52116002)(83380400001)(186003)(478600001)(31696002)(26005)(31686004)(8936002)(66946007)(66574015)(66476007)(66556008)(6666004)(16526019)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NPekRweDU4djJ6UTZ6RFRaU3lHM0dDQXphSTlBZEw4UHJJUCtEMGkyN1V0?=
 =?utf-8?B?VHA4akpUZ3FjNHFNd2NTNmU2b0RjTi8vaTluRmdSbWlEYVpsTmh5NlVuQkF0?=
 =?utf-8?B?OXFYbDdXa3FxUHlOV21ZMDJJMTRrS2V3Yi82bHdoOUJOSTBaS1o1T0kvZUgx?=
 =?utf-8?B?ZHlLYUU3Nlo2MEo3bm9XOGR4UnNVRklHQXFCZ3FQdy8xQ3ZSV0FqMlNFZ0E0?=
 =?utf-8?B?bkxtSm1XbHhYRXlXKzdCOGZCN1BWbVluSTJuU0huMGtOcTF6NjFVRmZ2Vmw4?=
 =?utf-8?B?TmVvdE43WHNBLzJRYkg2YnowNEhZK1BtQUxPT3VYR3BIMWdYVkErZkh4TW1o?=
 =?utf-8?B?MmkyZUM2dTN5MHRhb0Nib0VJZm9RNzExdEZRdmh5S3U4N0VJZnRhYnJnRjQ2?=
 =?utf-8?B?U0FSOTBQZnhsOGJqRWJOU2lrendDcW5WQStOU1JEcWYzT0szV2dtWkZCQmNk?=
 =?utf-8?B?MTRHNTJ1NHdiRlJVQ2thQmhWNTdmcTJnUmc5dE5nT0xBN29lS2pCVTVzeDUx?=
 =?utf-8?B?Zkh0VGYyWThrUUZTR3RQWWpRZHplNEpJaEg5dnJ4R1JlSDdLWVRibW5SUlpi?=
 =?utf-8?B?ZmllOGdubDRDakZvazVKb010dGVOWWhMd0JJK2pBaEZKMmQ3OGRSTU56cWFP?=
 =?utf-8?B?VCt4WHlEYi9tNEtucGlxT0IzVUhsZEc1K3dFQVFhbUg5dkp0bEVTYXRxTVBp?=
 =?utf-8?B?RGpwcyt4aFMxdUxiODVOS2RMaW5EWERGd2dnbkFRVTVBZmgyNUQ0NldTM0Zh?=
 =?utf-8?B?VVhwU2pWNkVoN3JBWUo3amJCMjNrT2JwaTc0Mm50S0N4R05LMnhWT2VNQysr?=
 =?utf-8?B?Wi9kRktDNnJDeVAvek1SN0pCTmVuOTNMMnpTcTFyMmE3TmNYay8xNnp6UzZm?=
 =?utf-8?B?dWk5NDRBdUxvY1JCdzBkTEZKczRlbkFrbFR5UWZGdkMyL2MydFNoN0tCends?=
 =?utf-8?B?NjVTcUY2UzR4d0VGZlk1WkJDTkhvdlppVnFjbzFaeUpPS2tPNlBobUI3cVJF?=
 =?utf-8?B?ellORm1RR1piU2xnV3kydTBzRlJhdzVKWGtqcE9CdjRqUUhWblRaQmdMb213?=
 =?utf-8?B?NWNxRmg0b0E2QnMzNmEremIvQjFMdUpaZ2dFZHhWcHcvVU8xZG9yclVnMG83?=
 =?utf-8?B?OGpveXplcU96Y1N4emFPb0VYWEJpYlhqMzg1QzREK0d0eGZaRmFqaEVyZlBE?=
 =?utf-8?B?MklpeStKQmtPNHB5eXhYUUlwWXM2Tk9GakIzczFGemc0Z2lhTldNSEVyaTJq?=
 =?utf-8?B?c1h5c1RwcmU3VUtURmZOK2Q5TEJpNk1aTXBvbFhaWTVIZE83MFo2aUlSMVdo?=
 =?utf-8?B?VnNPVG5Cdm1OT2pEekhhcXF0eVFTUXByN3k0OW9WUU1sdVR6VjRGSW8rRmxi?=
 =?utf-8?B?NnpKUlEwYVZuNEVISE11TlBqVE5HV2tGWjRqNmRsY3Z5RjRScVZMRGFvSTdE?=
 =?utf-8?B?bTRPK2FnYW15MUpPRzQvUFJmTWgzWU9pOEptNEJWOWQ2bkYvUlE0azJYM2hn?=
 =?utf-8?B?QUZaSTZmUFBYL3pYSHNLTXowUk5abUsyNjZuM05IbFB2QzZKcmZ1bDAzTUtL?=
 =?utf-8?B?YzlxcmozNDc3eUlFK2ZaQmdpZlB6NnRDM0kvazR1azM1OFNnelE3YjgvWm1Y?=
 =?utf-8?B?cTRGM2tCS1drZjdEdXhRTDY0ZXhNcjBDY055ek1KclFTM29XdFVGb052WWQy?=
 =?utf-8?B?dkRQdU12a0phbEVkcFVDaWpOQXBxSkpMNVFHVGhiSjlCeko4V2VpTnVlM3k3?=
 =?utf-8?Q?+0DRaZ8p/+Gyc9FKWG2nfTYtFCPZf+FLYNFqwOg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654c821e-f1fe-47d4-105d-08d92f5b91d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:40:58.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ID3OP/sJcfNnjRP7bSJInkAiLrLo15WTliFwaMeCHAcesTWolJHux3uXfDujo1S4xk44W/w+jP0EFFrZmz2Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
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

Ck9uIDYvMTQvMjAyMSA3OjEwIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAx
NC4wNi4yMSB1bSAxNjozMiBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IE1ha2UgcHJvdmlzaW9uIHRv
IHBhc3MgZGlmZmVyZW50IHR0bSBCTyBkZXN0cm95IGNhbGxiYWNrCj4+IHdoaWxlIGNyZWF0aW5n
IGEgYW1kZ3B1X2JvLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFz
QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIAo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiBpbmRleCA5MDkyYWMxMmEyNzAuLjcx
YTY1NTI1ZWFjNCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwo+PiBAQCAtNTIyLDE1ICs1MjIsMTcgQEAgYm9vbCBhbWRncHVfYm9fc3VwcG9ydF91
c3djKHU2NCBib19mbGFncykKPj4gwqDCoCAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9iamVjdAo+
PiDCoMKgICogQGJwOiBwYXJhbWV0ZXJzIHRvIGJlIHVzZWQgZm9yIHRoZSBidWZmZXIgb2JqZWN0
Cj4+IMKgwqAgKiBAYm9fcHRyOiBwb2ludGVyIHRvIHRoZSBidWZmZXIgb2JqZWN0IHBvaW50ZXIK
Pj4gKyAqIEBkZXN0cm95OiB0dG0gYm8gZGVzdHJveSBjYWxsYmFjawo+PiDCoMKgICoKPj4gLSAq
IENyZWF0ZXMgYW4gJmFtZGdwdV9ibyBidWZmZXIgb2JqZWN0Lgo+PiArICogQ3JlYXRlcyBhbiAm
YW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3Qgd2l0aCBhIHNwZWNpZmllZCB0dG0gYm8gCj4+IGRlc3Ry
b3kgY2FsbGJhY2suCj4+IMKgwqAgKgo+PiDCoMKgICogUmV0dXJuczoKPj4gwqDCoCAqIDAgZm9y
IHN1Y2Nlc3Mgb3IgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuCj4+IMKgwqAgKi8K
Pj4gLWludCBhbWRncHVfYm9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiAr
c3RhdGljIGludCBhbWRncHVfYm9fZG9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+Cj4gUGxlYXNlIGRvbid0LiBSYXRoZXIgZXhwb3NlIGFuIGFtZGdwdV92bV9ib19jcmVhdGUg
ZnVuY3Rpb24uCj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICoqYm9fcHRyKQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIsCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAoKmRlc3Ryb3kpKHN0cnVjdCB0
dG1fYnVmZmVyX29iamVjdCAqKSkKPgo+IFRoYXQgcmF0aGVyIGJlbG9uZ3MgaW50byB0aGUgYW1k
Z3B1X2JvX3BhcmFtIHN0cnVjdHVyZS4KCgpJIG1pc2ludGVycHJldCBUZWFtcyBjb252ZXJzYXRp
b24uIEkgd2lsbCByZXNlbmQuCgoKVGhhbmtzLAoKTmlybW95CgoKPgo+Cj4+IMKgIHsKPj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4ID0gewo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgLmludGVycnVwdGlibGUgPSAoYnAtPnR5cGUgIT0gdHRtX2JvX3R5cGVfa2VybmVsKSwK
Pj4gQEAgLTU5NCw3ICs1OTYsNyBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPj4gwqAgwqDCoMKgwqDCoCByID0gdHRtX2JvX2luaXRfcmVzZXJ2ZWQo
JmFkZXYtPm1tYW4uYmRldiwgJmJvLT50Ym8sIHNpemUsIAo+PiBicC0+dHlwZSwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZiby0+cGxhY2VtZW50LCBwYWdlX2FsaWdu
LCAmY3R4LCBOVUxMLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnAtPnJl
c3YsICZhbWRncHVfYm9fZGVzdHJveSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBicC0+cmVzdiwgZGVzdHJveSk7Cj4+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHIgIT0g
MCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gwqAgQEAgLTYzOCw2ICs2NDAs
MjQgQEAgaW50IGFtZGdwdV9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgIH0KPj4gwqAgKy8qKgo+PiArICogYW1kZ3B1X2Jv
X2NyZWF0ZSAtIGNyZWF0ZSBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QKPj4gKyAqIEBhZGV2
OiBhbWRncHUgZGV2aWNlIG9iamVjdAo+PiArICogQGJwOiBwYXJhbWV0ZXJzIHRvIGJlIHVzZWQg
Zm9yIHRoZSBidWZmZXIgb2JqZWN0Cj4+ICsgKiBAYm9fcHRyOiBwb2ludGVyIHRvIHRoZSBidWZm
ZXIgb2JqZWN0IHBvaW50ZXIKPj4gKyAqCj4+ICsgKiBDcmVhdGVzIGFuICZhbWRncHVfYm8gYnVm
ZmVyIG9iamVjdC4KPj4gKyAqCj4+ICsgKiBSZXR1cm5zOgo+PiArICogMCBmb3Igc3VjY2VzcyBv
ciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KPj4gKyAqLwo+PiAraW50IGFtZGdw
dV9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqKmJv
X3B0cikKPj4gK3sKPj4gK8KgwqDCoCByZXR1cm4gYW1kZ3B1X2JvX2RvX2NyZWF0ZShhZGV2LCBi
cCwgYm9fcHRyLCAmYW1kZ3B1X2JvX2Rlc3Ryb3kpOwo+PiArfQo+PiArCj4+IMKgIC8qKgo+PiDC
oMKgICogYW1kZ3B1X2JvX2NyZWF0ZV91c2VyIC0gY3JlYXRlIGFuICZhbWRncHVfYm9fdXNlciBi
dWZmZXIgb2JqZWN0Cj4+IMKgwqAgKiBAYWRldjogYW1kZ3B1IGRldmljZSBvYmplY3QKPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
