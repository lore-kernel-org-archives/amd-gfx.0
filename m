Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC39C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6986611CD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6986611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D60C6ED11;
	Wed, 26 May 2021 14:34:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27AD56ED11
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 14:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFRVh7xiqoULGgG0QHD/T9Gx5aMjjjG8pRD4QLIz6uJNWuS+Mf1cHz72U3oALRr2oBFDduR1AKmnm69GXACnSuHxNFf0upoO5i95c+8D6SMILPauoz/+v4Czt9NGQw1A+HW3UshAsS3WoIwBifLkblpnAaEs936B8buBYzpjjhJ1oVZlruQfOQ1ssXVHOPpG4kt8VztsLl3XgeL8iE1L612i/zudSitSxzXOKNCjHofRchA/AAswrBfUnsoL6yFRCHfGLDlsaHy0MdE8R3ZAEySxVIA1qcoLBmbcHOvOjRGxHoqOBC7yF6oOdGCj8BV3NFzHIw/bw3+i/3t78a20Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8VBQMaf7q5OWvFYJkazm/Xl12G2vSkPJdq/k3ny7rQ=;
 b=nShb6vGLJPhIJbUxxlus6CmWC5SofmSh8nGrGOltl7/uiCqWEIjXM+N0xRQRpNnK1TVp6Sref+xA8hfbprraloX9ibp1cr+9ayXGmsLSNJgxMMQPUFU58GPvuBIMdjEH0RTZ0PQVLUiyZYUFoodYDRtgyo6ue7eZMHkFWp+eSUpD/oQ2j9zPzWXlkqqt8Kb5cwr3cGwwxrLDGNKEoCB8sl2fFsadCWK41UD7PHiqjju4jAzEYrxWCvUNsqja/nZDVoxWhIbzLJGyFdF9Dcy1Rgd23PQMk/lUaJXdusHSiKlr4VsposGgy7BRkb/KLVRp8C3pXjM9ThT/iPg1H4hsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8VBQMaf7q5OWvFYJkazm/Xl12G2vSkPJdq/k3ny7rQ=;
 b=jRP6QR6XlnxheVp1crPoI/93AdWmbMK59LHa4I5JepM+hO8nYcewPgsisPs6D7wCo16uazrgP74vTfNYg3hczGCKyee8aHf/1DVTrtNiqHcgZcoYHs9M/SDXA25/RIhfPGFbUKesIuNYdRi87WXmP3C4yqSbanno2E8CL5xKmfM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 14:34:29 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 14:34:29 +0000
Subject: Re: [PATCH v2 2/5] drm/amdgpu: move shadow bo validation to VM code
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526130658.4237-1-nirmoy.das@amd.com>
 <20210526130658.4237-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <861775bd-657e-74a8-e183-3c039c8d98e9@amd.com>
Date: Wed, 26 May 2021 16:34:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526130658.4237-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:1950:35e:cae9:5bed]
X-ClientProxiedBy: AM4PR0501CA0055.eurprd05.prod.outlook.com
 (2603:10a6:200:68::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1950:35e:cae9:5bed]
 (2a02:908:1252:fb60:1950:35e:cae9:5bed) by
 AM4PR0501CA0055.eurprd05.prod.outlook.com (2603:10a6:200:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 14:34:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4473f0aa-6620-4f62-4496-08d920535eac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4206E32FCA8BEDED45BDC5A583249@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lTsCnHcn3/wzzhcuEVtPn+O2jcMQRpwjeL8VliUtt+Gsjv/N5C6N+zaFdnTep2DUgExV/2XQnTrc/yyGc5lk1I7HFUP/GG8p44n9zLaLyAz1Ic1DxiWuqbS0iu05F4EkBSbYnBM0e4VcyyVx6CqbM359V4oFTfJyKlp29O35gWczKUgdE7U95+coz+wS12UvkVh31CZRDD63ywoZ/CEzvOBL+geeEH1OtqKiOImFAx6i6NZA9ygxfePdwb2cdFSKgrsXUTkDvfKg5FzKf5mc2/u2fPuY/anmDPIDd/YpEVLUESfUQCYypHlKtvM0tjLvnwkrF61HnqSmoRN/cKSy2MhhC1K+x/O1GXvpXkvqcG+eiHjJ8q9CABcSeLp7T4Jt3BBRS2fq9WigJyiQCnH0ITh9IpiRXjXqIVxmZJBVtKaiswrr2EQaUo49gKe2Z2AjZer/VJDtS/TCiVIFEY0KKSenZqvT/ZGh7yVdEVYi8ILo6GBC300jOG6pc8dFyog6kEW4brKb0A2Di7ATvt+TY5LFpeDW8qvs2bmNYIGYjlvMtgfd0HXTjVS4c9l/DmjAOa1yAM0D+Vh/kzvzgHXEqX0P/i/r1qyHIKUohqaGuV8gcp05Io4t7qi1cdZGeD++izZihHbHwmnIDDKNLggm7tmKAXpCn1TBT45af0452nDDy6Folkpt/l42quynL7b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(8676002)(36756003)(52116002)(8936002)(186003)(66556008)(66946007)(66476007)(2616005)(16526019)(478600001)(66574015)(6486002)(31686004)(2906002)(86362001)(83380400001)(6666004)(316002)(4326008)(5660300002)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Uk1DVmlDRmNIWFNNMWFTZ3d4VmREdGUrWVowZ056ZFJROTFoR3JVcEpJZ0Vy?=
 =?utf-8?B?SWFpNHNSSjA2ME5xaXJHMnB4c1BFdFZsZDdXMm55czZjZG9pd1k4QVNqcWlM?=
 =?utf-8?B?T2hJYjVDcHM5S3RtdUl5Y3d5NFQzT0NIL1VjVSt0L3k0TzRjTVZmR0FvakJ1?=
 =?utf-8?B?N2tFWHpmaExpTGVYQWlUTEVRZkJnRGN5MkVPeXYvN0VGSmJCU2daU2kzMlBG?=
 =?utf-8?B?bkVzalI1YkdHTXg3RG50dkxaRHdCTTFYRjhCTXU1ZXI1ZU5TR2RxS2c3MW5W?=
 =?utf-8?B?U0hJS2MyeVBXMS9nYjlyNzUzWUxoelJqYUFYSVJPTVVRamZnbTArdDRLdEJs?=
 =?utf-8?B?TWlVSEo2aVBJeEZZa1pMQ3U2N1RBSFRxSnV1eE9BL2puTFFFdndrVHAxU3Rx?=
 =?utf-8?B?bTc5b25QeWFZMTBNTWtUZ0xrYkxvdERzZm52UTk2TUllRk9WaS9ZaytjRHg2?=
 =?utf-8?B?RkJtZjh3VkRjZkZjWFVxUStscTJ5eWMvdHI1RjdIdXphUGtKVFdpNTUzUXRj?=
 =?utf-8?B?VzZMbVZLN09GYklaQzFJc0lkWU96Wkc4bTRjUUVza2JCUEMweG9DN0R0aVVR?=
 =?utf-8?B?MCtTckJucmgyNUVWcWlHcmh5ajB3WkE2cmJ6NEJjOVZEdWhkT2RUaXdYL2Fi?=
 =?utf-8?B?enlzWmxnaHpKeHZtQ0NCU1VQQ3c2eFpYWmhmbWNzN2VMRWxFVVZuMEdBMkJx?=
 =?utf-8?B?VE1zTG5XdlpNU1FkOTI2aUpqNjV3L3FVUjZQV25taTNoL1NMdUN6aWlPK1Fq?=
 =?utf-8?B?T1g0NDVhbGxNd1NmOW4zbVgzcVFRU3lzbWpHeFI5Q0tmSmhhTkhBREtXVHBr?=
 =?utf-8?B?bmtRQy84Wk0vVG94Y1hyOXNpR0JpbGRFdHRDR0NhSU4zRzRkaFBQckRyVVdS?=
 =?utf-8?B?b2J1cWRQYmhkbUNWSWs0RTNGc0FVQ2U0TEJxTEJMNzdKRnYwSUJMdDM1WmRG?=
 =?utf-8?B?MW1WT1E2MU10b2RuSjBwY21OckpBeWZ0VDBHRzNLNDQ5c0laVkNqVHJyTzd5?=
 =?utf-8?B?alpneVVUT2F6bmJXNjdEbFVaL3F2aXdvTDNCTzl6Y1NJSHk1TGJYYzBkY3ls?=
 =?utf-8?B?SHUxYzZlSUgzTi9pWHRjQjBkMTlKL3ZNV2hWQmlXY3o4WFlTcDJzcGM4OVFB?=
 =?utf-8?B?Umpmd3R5aGN1RDZ0WmlkNVlQZUxGaWdldlRpZC9NMUN6enhBa21XbTkyaXJl?=
 =?utf-8?B?dmEyanFwWDZHSmRHM0l5bmdPZFV0R0E1YjFxOXdzbW5wQ3IySFVvNWcxUEpy?=
 =?utf-8?B?dHEvbzVGRFFoaVpyZkZxYWdvMHlEa0RkU3orYzNkdXVBcmViSndZank4RitS?=
 =?utf-8?B?T0tsVGplOEZUcUozaXg4MHNmVXdSQzFzS2tlUVlFOE9FT2JvNUpJeTBKbFhu?=
 =?utf-8?B?eEN2a2ZtcDlzVG42UFBTVm1OMkdGanY5dkIyNWF6cDhqTFRCV3JwZTRDQ0M1?=
 =?utf-8?B?VVhkTU55MmNMRGpia2IxKzAxQjRqcXZyZnl3eXJrRXhzT0Zmek8rdlVLcWRM?=
 =?utf-8?B?czc1L2prd1ZJcEtMUTVoQW1tbmNQUjJ2SXZDaEE0NWdYbUJ5WDVPNVhLYUhQ?=
 =?utf-8?B?N0tjeEZKemJjN1hKSkpKUXZUSTNnWDg0UVFxYVBBRDhxUCtXNkJhYklIY2xy?=
 =?utf-8?B?bSt5VGdnbExubURaMjNoSnhyQW56K2NNSHRKK3VEdTNhQkE5MmRTdWNQczh6?=
 =?utf-8?B?RFVzMi95d1lvbHJMZUlrVDZFclg2alZZSUFFdm8vVUZib25kN1c0STNHUWIz?=
 =?utf-8?B?SEZZYzhNOStRZWE5L2srYThXQS9jS08xcHJ0L0JFN0VXQnVtM1REUkZLaUFa?=
 =?utf-8?B?c0gxeE5XamthcngwSWNzWENleVFOODdjRlphMGVWWTJEVGZNbDhvRndyK25q?=
 =?utf-8?Q?r3ieUqbNoL/JU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4473f0aa-6620-4f62-4496-08d920535eac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 14:34:29.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOljLUa9sKXqPg1zVhHmmRTKHNtcqcES9aQTovFvmePOZifmUmAKqJEgn3bmYoMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyNi4wNS4yMSB1bSAxNTowNiBzY2hyaWViIE5pcm1veSBEYXM6Cj4gRG8gdGhlIHNoYWRv
dyBibyB2YWxpZGF0aW9uIGluIHRoZSBWTSBjb2RlIGFzCj4gVk0gY29kZSBrbm93cy9vd25zIHNo
YWRvdyBCT3MuCj4KPiB2MjogRml4IGEgdHlwby4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBE
YXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2NzLmMgfCAyMyArKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAgNSArKysrKwo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRleCA5MDEzNmY5ZGVkZDYuLmY2YThmMGM1YTUy
ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gQEAgLTM5Niwx
MCArMzk2LDEwIEBAIHZvaWQgYW1kZ3B1X2NzX3JlcG9ydF9tb3ZlZF9ieXRlcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgdTY0IG51bV9ieXRlcywKPiAgIAlzcGluX3VubG9jaygmYWRldi0+
bW1fc3RhdHMubG9jayk7Cj4gICB9Cj4KPiAtc3RhdGljIGludCBhbWRncHVfY3NfYm9fdmFsaWRh
dGUoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsCj4gLQkJCQkgc3RydWN0IGFtZGdwdV9ibyAq
Ym8pCj4gK3N0YXRpYyBpbnQgYW1kZ3B1X2NzX2JvX3ZhbGlkYXRlKHZvaWQgKnBhcmFtLCBzdHJ1
Y3QgYW1kZ3B1X2JvICpibykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOwo+ICsJc3RydWN0IGFtZGdwdV9jc19wYXJz
ZXIgKnAgPSBwYXJhbTsKPiAgIAlzdHJ1Y3QgdHRtX29wZXJhdGlvbl9jdHggY3R4ID0gewo+ICAg
CQkuaW50ZXJydXB0aWJsZSA9IHRydWUsCj4gICAJCS5ub193YWl0X2dwdSA9IGZhbHNlLAo+IEBA
IC00NTEsMjEgKzQ1MSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX2JvX3ZhbGlkYXRlKHN0cnVj
dCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAgCXJldHVybiByOwo+ICAgfQo+Cj4gLXN0YXRpYyBp
bnQgYW1kZ3B1X2NzX3ZhbGlkYXRlKHZvaWQgKnBhcmFtLCBzdHJ1Y3QgYW1kZ3B1X2JvICpibykK
PiAtewo+IC0Jc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAgPSBwYXJhbTsKPiAtCWludCByOwo+
IC0KPiAtCXIgPSBhbWRncHVfY3NfYm9fdmFsaWRhdGUocCwgYm8pOwo+IC0JaWYgKHIpCj4gLQkJ
cmV0dXJuIHI7Cj4gLQo+IC0JaWYgKGJvLT5zaGFkb3cpCj4gLQkJciA9IGFtZGdwdV9jc19ib192
YWxpZGF0ZShwLCBiby0+c2hhZG93KTsKPiAtCj4gLQlyZXR1cm4gcjsKPiAtfQo+IC0KPiAgIHN0
YXRpYyBpbnQgYW1kZ3B1X2NzX2xpc3RfdmFsaWRhdGUoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIg
KnAsCj4gICAJCQkgICAgc3RydWN0IGxpc3RfaGVhZCAqdmFsaWRhdGVkKQo+ICAgewo+IEBAIC00
OTMsNyArNDc4LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3NfbGlzdF92YWxpZGF0ZShzdHJ1Y3Qg
YW1kZ3B1X2NzX3BhcnNlciAqcCwKPiAgIAkJCQkJCSAgICAgbG9iai0+dXNlcl9wYWdlcyk7Cj4g
ICAJCX0KPgo+IC0JCXIgPSBhbWRncHVfY3NfdmFsaWRhdGUocCwgYm8pOwo+ICsJCXIgPSBhbWRn
cHVfY3NfYm9fdmFsaWRhdGUocCwgYm8pOwo+ICAgCQlpZiAocikKPiAgIAkJCXJldHVybiByOwo+
Cj4gQEAgLTU5Myw3ICs1NzgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfYm9zKHN0
cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAgCXAtPmJ5dGVzX21vdmVkX3ZpcyA9IDA7Cj4K
PiAgIAlyID0gYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhwLT5hZGV2LCAmZnByaXYtPnZtLAo+
IC0JCQkJICAgICAgYW1kZ3B1X2NzX3ZhbGlkYXRlLCBwKTsKPiArCQkJCSAgICAgIGFtZGdwdV9j
c19ib192YWxpZGF0ZSwgcCk7Cj4gICAJaWYgKHIpIHsKPiAgIAkJRFJNX0VSUk9SKCJhbWRncHVf
dm1fdmFsaWRhdGVfcHRfYm9zKCkgZmFpbGVkLlxuIik7Cj4gICAJCWdvdG8gZXJyb3JfdmFsaWRh
dGU7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBkYTE1NWMy
NzZjNTEuLjZiYzc1NjZjYzE5MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCj4gQEAgLTY5Niw2ICs2OTYsMTEgQEAgaW50IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9i
b3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAg
CQlyID0gdmFsaWRhdGUocGFyYW0sIGJvKTsKPiAgIAkJaWYgKHIpCj4gICAJCQlyZXR1cm4gcjsK
PiArCQlpZiAoYm8tPnNoYWRvdykgewo+ICsJCQlyID0gdmFsaWRhdGUocGFyYW0sIGJvLT5zaGFk
b3cpOwo+ICsJCQlpZiAocikKPiArCQkJCXJldHVybiByOwo+ICsJCX0KPgo+ICAgCQlpZiAoYm8t
PnRiby50eXBlICE9IHR0bV9ib190eXBlX2tlcm5lbCkgewo+ICAgCQkJYW1kZ3B1X3ZtX2JvX21v
dmVkKGJvX2Jhc2UpOwo+IC0tCj4gMi4zMS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
