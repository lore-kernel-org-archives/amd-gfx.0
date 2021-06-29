Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC987C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8756061D03
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8756061D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CFD6E858;
	Tue, 29 Jun 2021 11:15:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD0A6E858
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 11:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA7dJ0TH0pARpv/nexdYnKHvPZyuFWFcX9oK4gz20mKlNTU7h8Hn4AlExu6gro8FdIx/zaqa+tuu7h/+dM0ZGE1pIE5+yTL5uqAZhOgrTTyPJWV90ho10g0ciNf1eaRQO2zv3pzINSWiGYI/4Ecf1JMRhVTiX8oryM40gF91E+XNJJQVXIA9rd07AhlwIzcGaTorGH2VAQaiAy7p7QhvL6pipgV1eBcZ3i8P9PxwUaU+57TeiFTuk1ypVOYw/1Xw83zJRdTTcLgSTX1Jcl03ZVxAM7ip8bcjXTjIX9zYZy/qSf09wg0e7+ekfNk8yhJgTDArQUx7xy6GcM1noTQ3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekrq5gXvkqgMRI7gbFabV6yh0wfNhcBan0PDxhwL6Nk=;
 b=ebmsfXpwMiz7DDlyQxf6FyNrlprM6RMnpyJyJ0M0OavFGGVY26ae9m1/t2iOVYA5OMzJU8pgP/ZZvTEktX9LwFCVM/lDHrztqmZdJ6iBUDUoQrzCPetLgpjULppUR/MwLYin8h+7uHhuD6HPJZhbfEFXpd/gVcHBvy0yaudD+WyQE8TPyIIYJowiKJ4fgxm3BcWzJaIBYnxwQ4yGm9ULodf8UYxYhrEn9zWFRyadNiEzHQdAqP6netmCIBHrk3gWSZDKocE0CX5ivxTIh3MMJFYo8/fzkqBlcF7OQlBx0WpWFp7RO5E+W2yGTWSsUPm+0RtI7qBegx6+NHSGWOojzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekrq5gXvkqgMRI7gbFabV6yh0wfNhcBan0PDxhwL6Nk=;
 b=DWCK6CvD/XVMq2sfe3H+wmIqlScQk+ebP7bXMPTaP01lr3zNP1sS8dRRGRxWr1ngk5Y0ZLl//ham6vB5TPq9KGVdQx/A859QL3Dw8XbLltIhR2lXfJq95MxARnQ0PZhjIjhV7CPwGa5yunEpZ3XC0R21conGtqir/POXvh3NX64=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 11:15:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:15:50 +0000
Subject: Re: [PATCH v2 2/2] drm/amdgpu: free pasid early before converting a vm
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210629074914.4114-2-nirmoy.das@amd.com>
 <20210629075556.12090-1-nirmoy.das@amd.com>
 <088530db-f8fd-9d37-fdc5-0e810507b3f2@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <80d41631-cdc1-6b97-a3ba-004e3722e5e2@amd.com>
Date: Tue, 29 Jun 2021 13:15:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <088530db-f8fd-9d37-fdc5-0e810507b3f2@gmail.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f27:5d00:9499:a270:2927:4d86]
X-ClientProxiedBy: AM0PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f27:5d00:9499:a270:2927:4d86]
 (2003:c5:8f27:5d00:9499:a270:2927:4d86) by
 AM0PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:208:d2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.21 via Frontend Transport; Tue, 29 Jun 2021 11:15:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a527a2-df62-4b1a-714c-08d93aef4040
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51650590BF0B313DE0460A758B029@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1lb5EgCwWOW+4VY4V8mZdD1AhNsUGL79WGx5l4f9RZPyqicq2C0e3TXptcQh/1y/jnTOA2E0aoVuIhF/BnwPZ2Q3sEgk6nRxpf/jBFSW3Nl5tsw0+EE6RV5YzF3z7MuxOC+zRbGIrLDXp5bOYn++ycGAtJzQhOIEBPb/vktSVMPMSE7HgirjxFSHh8YobKmuLJ360RKJjq5lJRJAwnRL9M7+yGHL6uQdkvjUwAhLL00ig/vdIlRhdz+byb+xCpFD5PU06KU45jfcm1aLxVIBfOXrdPDCywSbJhVDaGOoRZ2C42b9kI1MANqL5I6J42hNmuShcjmxi28SLigHS9L1/VreV8xzZfaNJc/Jdd8PQy0AEvw1EyHAV6bchEN7WUJvIElxAWAJ4J/1IAcVzQJxHphGBQgtpm31QWjYzxMGNKA585TDkjkZrm/ZLmq6Eb5bdU231Ok1WSqFK5y8LFGMV5H5mXXYPyLiRmJPApz+fEicwPApmjktvofuzx8RhP7YAcrOtTrHoQ5bGJGf0vQ0vfG/L56VftSZhLYC7mGSeebEp5MS5EqpPgPB0hFBLWbK0ueaJlmdyy/hFOCwp7194JK/JNQRIVc6igRfnlcgKMmkEpL1qEC+6opGN57Fy96nqx8LZDMLmoK+02Gfbadu7GCcDSJBf3P6OdI+TOCjv0LHqEovwrle7NtfeNjFco7uIVpacGs1owdVCYQmPJCd0ERNoGnv6qVHql90eeySpZZpSV1oyAhPytwoTJ081NwZqOD9vkGyY7rfXVa2VGLqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6666004)(83380400001)(86362001)(316002)(5660300002)(31696002)(31686004)(36756003)(2906002)(53546011)(52116002)(38100700002)(4326008)(8676002)(186003)(66476007)(966005)(16526019)(2616005)(66556008)(6486002)(8936002)(66946007)(478600001)(45080400002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJ6TUJ4Rzd4bkxiaG9wTVNOUVJnbnRHeFpGbjBxM0htdlhNSHdQeWNnZVQr?=
 =?utf-8?B?WXFyN0I4dVN2M21BSlRyTWpic3dabEJvUWVxS0ZqTjdyVUdPWEtKMitnbUgy?=
 =?utf-8?B?V1lOaWxTSTkwZVdkNEVlK0hCWGtVWVRYSVNDTUhZbVlmTFZhUHNTMkdkQWt1?=
 =?utf-8?B?UUo0bnJCdEtPVjAzN1hDOXpDTGswSFlrelR6VmpqR3U2Z0RUcjVza3dnQ2Nw?=
 =?utf-8?B?RU9VTzMrR2hlc2JScWNiQnlUaElIdVU0dEc3VzBTRTRHQUFOR2VFbU8xYjhm?=
 =?utf-8?B?Ym9teEIxUlB1VGRibUk4SXNWdHorMGpMaVhTM0hnNXBWSTdUS25wNWpnOS9Z?=
 =?utf-8?B?OWNETm80eVQ2bHJHaHRqczVEVDJWU1NNZThRaFZLaFdpNDh5ZURqeVh4b0Ri?=
 =?utf-8?B?RkduWWhEK2FBM2tWL0xpVjQwaWtnUEhTSnk2SXYybks3bFZpOFZlMzRwM0Rw?=
 =?utf-8?B?WEUrRC9OM1dvd3lnSnlMWENmNnJIUFQzL0Z6R2RMaHV3Rm9FNlJWdy9XWHVt?=
 =?utf-8?B?d1JVVWhSZUxidXljMUtZWGJpQW40RVAybmUvYnFTbm1yZ1JSQlVRdFdFcGNr?=
 =?utf-8?B?VkFWOEJsdTh6RVpBRi9sbkdic3hSRDBNWGNHYmE5TVFlT0trYUFWMWZnWFFH?=
 =?utf-8?B?TkNEazl4bnBsU3k1QWpUWDgzREZHL1VVYWUxeTZTR3k0eEp5Q1Z3L1RZaDY4?=
 =?utf-8?B?bCtTVzVxUHBxZ1pVOWhRdzZGMXYrV1Bid2diQzZUeEtmT0xxNTEvOGlmM3BC?=
 =?utf-8?B?N2FibXJrRi9FejhjVDlSdi84VmdtN0NSWVU4VnJLSXN6c2x6QWVIc1BKMUhX?=
 =?utf-8?B?OTY1VExtSkpvYTBRclczQ29zR2M1Q3RwUFY3Wm9yTVpnbzlSUWtBU0RtWHZR?=
 =?utf-8?B?Z09FQ293ZkRJNUtZTThYVnJwVnVhRTM5bHhNQzJERllDbHRFWHdQVkJZK3hK?=
 =?utf-8?B?bFJYMXhjR0ZFOHd5bkhLMlk4cjc2cXN1WVQ5VTMxVmR4VTU1RFZ1ZkJxd2Yz?=
 =?utf-8?B?K2wrMWJsZ0hOeE05bGxIdDdrNXU4aUxiRm4rbDJhb2pENnJwbk1qSWk3TUxD?=
 =?utf-8?B?Y0o4NldFWHpqTzNnWjVUZ29DTlBkTzFIZmR6bDlNd0dwQVdmd1BMQ0MyUXB0?=
 =?utf-8?B?dG12elhqekNDY1BCNzZZb2VzNFdWeTFlTjFYSHRzbllSaXRMWTBoZ05neCtD?=
 =?utf-8?B?TWNoYmRRL0Jsc3NlV1VtVndlSXMxeFV3NmtjUGkxcWJRMm8rSEhmd3FVaVU1?=
 =?utf-8?B?MmowT2luSlY2VFZhZkprSVIybkR1R1Y0MVlva2ZPMG5DMy8wZGxoNFY1YlBt?=
 =?utf-8?B?czErYmg4MzFianRWSjY1M3E1M21QRUZ2dXJ0UFVhWERPV2h4UmZQYlFKYmJU?=
 =?utf-8?B?eWdZT3ZheFVOR1ZXMWJqM3ZwSE9WNHV1VFR2aFZoTGUvMVRObkpDaWI3OGpr?=
 =?utf-8?B?WHgvU2htY3U4bjFYb2ZiejczSSswc3RkVnJjYjQ4Unpma1hQMjIvbnhUM212?=
 =?utf-8?B?c0VPMDc2YjE2QVlWa1U4K2lBNnk0OFpDTnBRbzZ1Q3ZqcERjakIwVTl3aU1H?=
 =?utf-8?B?MktoWWxsclFHaHFtalFSclJEUU5pc0hTU0k4c1pTZFR6Y2RUdHlkRENqUmNU?=
 =?utf-8?B?NzZacUc0VzJQbkprRjg1MHRHZGdqQXREelUwcmVvN1FleWkwRllIMGErQ2li?=
 =?utf-8?B?RjVhbTVNbVJZNE9VK1lLVjhEd2lxNUdMdmtHbUVhZk9xbjJrSHpjOWhwSERT?=
 =?utf-8?B?RFdIaVZHVnJUejNMTDRlM283U3JKUkZFNFZZSVBOcG9mei9hZXRIZVRIMith?=
 =?utf-8?B?V0puc1dGd3NNWXB0TCt6NFRCM04rUnB5MmJGU3QrVzl4M29Pb0xYWmNQZThG?=
 =?utf-8?Q?jedzs0NbcRmFA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a527a2-df62-4b1a-714c-08d93aef4040
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:15:50.0400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajo8RfFECehK8Had6hpjz+HkZv476CV9dxjd4BbUAViP+c5ju3gobZ7bqdHYw9hjZjAKH0opO7pCpfMZ1tSAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMjkvMjAyMSAxOjEyIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDI5LjA2
LjIxIHVtIDA5OjU1IHNjaHJpZWIgTmlybW95IERhczoKPj4gVk0gY29kZSBzaG91bGQgbm90IGJl
IHJlc3BvbnNpYmxlIGZvciBmcmVlaW5nIHBhc2lkIGFzIHBhc2lkCj4+IGdldHMgYWxsb2NhdGVk
IG91dHNpZGUgb2YgVk0gY29kZSwgYmVmb3JlIGluaXRpYWxpemluZyBhIHZtLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA4ICsrKysr
KysrCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCA2IC0tLS0tLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gaW5kZXggZjk2NTk4Mjc5NTkzLi41YTkw
MDZhYWJlYzcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dwdXZtLmMKPj4gQEAgLTEyODcsNiArMTI4NywxNCBAQCBpbnQgCj4+IGFtZGdw
dV9hbWRrZmRfZ3B1dm1fYWNxdWlyZV9wcm9jZXNzX3ZtKHN0cnVjdCBrZ2RfZGV2ICprZ2QsCj4+
IMKgwqDCoMKgwqAgaWYgKGF2bS0+cHJvY2Vzc19pbmZvKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FSU5WQUw7Cj4+Cj4+ICvCoMKgwqAgLyogRnJlZSB0aGUgb3JpZ2luYWwgYW1kZ3B1
IGFsbG9jYXRlZCBwYXNpZCwKPj4gK8KgwqDCoMKgICogd2lsbCBiZSByZXBsYWNlZCB3aXRoIGtm
ZCBhbGxvY2F0ZWQgcGFzaWQuCj4+ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIGlmIChhdm0tPnBh
c2lkKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfcGFzaWRfZnJlZShhdm0tPnBhc2lkKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV92bV9zZXRfcGFzaWQoYWRldiwgYXZtLCAwKTsKPj4g
K8KgwqDCoCB9Cj4+ICsKPj4gwqDCoMKgwqDCoCAvKiBDb252ZXJ0IFZNIGludG8gYSBjb21wdXRl
IFZNICovCj4+IMKgwqDCoMKgwqAgcmV0ID0gYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShhZGV2LCBh
dm0sIHBhc2lkKTsKPgo+IEknbSByZWFsbHkgd29uZGVyaW5nIGlmIGFtZGdwdV92bV9tYWtlX2Nv
bXB1dGUoKSBhbmQgYW1kZ3B1X3ZtX2luaXQoKSAKPiBub3cgbmVlZCB0aGUgcGFzaWQgYXMgcGFy
YW1ldGVyIGFueW1vcmUuCgoKV2UgY291bGQgdXNlIHRoZSBleHBvcnRlZCBhbWRncHVfdm1fc2V0
X3Bhc2lkKCkgYW5kIHJlbW92ZSB0aGF0IHBhc2lkIApmcm9tIGJvdGggZnVuY3Rpb25zLgoKClJl
Z2FyZHMsCgpOaXJtb3kKCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+IMKgwqDCoMKgwqAgaWYgKHJldCkK
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IGluZGV4IDliMGU4
YTlkN2Y4Ni4uMGJkOTU3NWIwODcyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwo+PiBAQCAtMzA1NywxMiArMzA1Nyw2IEBAIGludCBhbWRncHVfdm1fbWFrZV9j
b21wdXRlKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAq
dm0sCj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHVucmVz
ZXJ2ZV9ibzsKPj4KPj4gLcKgwqDCoCAvKiBGcmVlIHRoZSBvcmlnaW5hbCBhbWRncHUgYWxsb2Nh
dGVkIHBhc2lkLAo+PiAtwqDCoMKgwqAgKiB3aWxsIGJlIHJlcGxhY2VkIHdpdGgga2ZkIGFsbG9j
YXRlZCBwYXNpZC4KPj4gLcKgwqDCoMKgICovCj4+IC3CoMKgwqAgaWYgKHZtLT5wYXNpZCkKPj4g
LcKgwqDCoMKgwqDCoMKgIGFtZGdwdV9wYXNpZF9mcmVlKHZtLT5wYXNpZCk7Cj4+IC0KPj4gwqDC
oMKgwqDCoCByID0gYW1kZ3B1X3ZtX3NldF9wYXNpZChhZGV2LCB2bSwgcGFzaWQpOwo+PiDCoMKg
wqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB1bnJlc2VydmVfYm87Cj4+
IC0tIAo+PiAyLjMyLjAKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbmlybW95LmRhcyU0MGFtZC5j
b20lN0MyYTM3OTA4MTY5M2I0OTBjMDlmZDA4ZDkzYWVlZDRiMyU3QzNkZDg5NjFmZTQ4ODRlNjA4
ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc2MDU2MTk3MTU2OTA2NDQlN0NVbmtub3duJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMjAwMCZhbXA7c2RhdGE9Nnp0VmRaWXk4bnNTNk9la0RG
QWpEYzJ0b0pZWW5sOVJVWkV5bDVLbjZjMCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
