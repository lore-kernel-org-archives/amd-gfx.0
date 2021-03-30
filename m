Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD61C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB1661969
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB1661969
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778776E8E3;
	Tue, 30 Mar 2021 13:17:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2316E8E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzmGu29OT78S8MiERS8iwHFJRUrVrTv7Vt2FsJb9C3H6UaM8nhRZP6QBoSM13FnpUqUeMvriYbAUfe0C7wXRQx9Mf3N7m2FiciLwD987FE3gFkBArvSD4kbedqLAvSRJ4gYQK/E5xEmsQ8fBhFJcoPiqllZaZV9mf5Q/pn/lPE/lxRFvoLyDG+Ca+QgXz6wD26Ua01yIQqU0y4VvP4+2iCMaviYUdh/WlF76Kfsuy5sum8uBHa9bfYb6PuoFtug5aewdOuio+iFX6Fd3BMawO9TRw0KWn5YakKOyTqa/9Q0oioxIEw7m7ha2IliE67ovyvuxbb7zaRJzmzO1VP7bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPf0dGTPwPHl6m3Ryg0W37KzEC20TqLvDCIEb0jixDY=;
 b=DwgR6JGmIdU556XziCWSftGfG4sj8YeTPGxPJzKgpEAIhLmWlqoRuYARczjuAaVGcj9J+jSdOMhJwMrcjlWCpKmFQmwphwkDAJCNNRTKMEYMQAPjPcBN+pnp5T60RdykuKvm5/00NGvdJetUHXxlFPDfnz3oBz5KG1QK/u4D0hQ/8UtDt6R2F3TDBZOedAUXEyfx8RebJFvft4SS7EJqk1jM85hG+4pLvrKuOK+qGTa1XEEJknr9WuOQkA068iJ38LA9OWZ66Yg9x1X4ZHBQRsVY08Eu803jW8F1pbfB5JHR2yOx0koiE+5yxwQ4xZ+OwvpwIrgtY2nTKh8ZgKXWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPf0dGTPwPHl6m3Ryg0W37KzEC20TqLvDCIEb0jixDY=;
 b=BL5IaCFsm0Nxef3n/EELQ7UJHrTT1b2XVy/LnlYqpZXL9Ym7VGD/W7BkS5KhBKx0w86jECmH6tF/BG7QSUlWVgUTRhD0OIU5BLTKkIg9s/Q6+oGVdNhvN0G8JTTSW+X22xfAQejxuwaLFL2+KljhwHEXDavuBUBolYO6/+5F8CA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 13:17:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:17:05 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix NULL pointer dereference
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210330100229.26435-1-guchun.chen@amd.com>
 <34904a56-726c-fb28-fd21-a3425f51d72b@gmail.com>
 <CY4PR12MB1287EC30BEEFE6724D395C98F17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4fbc3031-8473-ec37-bc74-914865732e7b@amd.com>
Date: Tue, 30 Mar 2021 15:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CY4PR12MB1287EC30BEEFE6724D395C98F17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM3PR05CA0116.eurprd05.prod.outlook.com
 (2603:10a6:207:2::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
 (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by
 AM3PR05CA0116.eurprd05.prod.outlook.com (2603:10a6:207:2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29 via Frontend Transport; Tue, 30 Mar 2021 13:17:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a6d84cd-830b-4389-ed5f-08d8f37e1d05
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB431866E6BE1549E672B2C208837D9@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MtmJkqRNXTRjY2WqiHUPmLhbBOJtlL+Uu2KB5LJHRPBX9RJwY+LwMyDSeEEsQ6P26ZqJK75YAQ9SZtRcoxSqiwWwhjATpeHNb1onqlsfOfiJQkhGjI5hauq0enrLeuBsp0OFWLfpK2xr6O+CPfBTr+D2H1lvjcxoZ3vYL1O5UDm1K0PgzpAxEMxy4nvynFRVp6UofZ9Q6Sesksnr61pMmI10je4F3exKJxep16uhzftTCmjbLE/a3vDTIQMzSAau3P1mb04yuQwOuKZ39UOp1tMSS+rDiJZgn2xcRNENPJk5LYEuHs70fV7Ul7jMzx6q7rIZwYwUkBse2oLBK/afA62cFLwFRY26uLPL5EO14CuYhDL4hrPEhOhTHsaHNpmV7Ldqrc40yGFg5OvlDrxvKvYChdejhEY0gUvuftkvDfe5Qi/+6SNjEE81EutpdC5oPDWM4/tCEjQg/cmMsIm1+2mLBLGl76CPFBqIV2UmFzDw5goV2g4C+JMWnu+OjpSuN83iaw+Yr4TVATGFg9OwQDuIHlmhWR/6uA0MaFqweGn1ntnRMZahJhiKgWBE9asfeYwn+6kVsbER7GmBaG0oQg0etAV8WjVBRjoo7jbYXbgZb8s4jT0hiAY2pZBxl+exCbK+ceQkT4JNgkiw8tF6D08nowFEs5YP71QByss8jTLoU9Jza0b3zoLQzclAz8UJQpB0MkP5DnxX3cU7nslf62GegcUSx9o5lnnxg0uZQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(31686004)(6636002)(6486002)(6666004)(83380400001)(38100700001)(110136005)(2616005)(8676002)(2906002)(8936002)(316002)(16526019)(186003)(66574015)(66476007)(478600001)(66556008)(31696002)(86362001)(52116002)(66946007)(5660300002)(53546011)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1U4T0ZocFQzR0tjNGd3WkJpSWEyOWNaemZQWWlpd1ZEcW5CN1hOWnlLUFhF?=
 =?utf-8?B?ckw5TkMyU3NlYW5CYXZ4ZnVqbjA1MHJiYitmSTRkb2pLZWtoNEVFY3lBQWYv?=
 =?utf-8?B?R2g5eVdWeVQwSnYwN3FHZjVGT2VQdVFIS2VJUWFZM2kvaU1QVndWZlVNUDlU?=
 =?utf-8?B?QlUzNWp1YUcvWWlySlNUTTJsZGNTa21FL1RjMW1wcFN5dWo3NVByRXEzd3Bt?=
 =?utf-8?B?SlN0aU9NckJtM051dWlpcVFwQThTeTFOWUlMTWh6bStZY0JQTlF1US9JRXdu?=
 =?utf-8?B?TmI0aVdmTlZVZzIrUDYzTmt2Z3pvcThtVUsxWHhFUHh6ZEEyL1Vla0R0aDBz?=
 =?utf-8?B?SVJYWGx1ZkpUdmc3aktRblhaSWwyMHdVMjIyeHBCc3JhRHYzMUgvMitnRitI?=
 =?utf-8?B?enBlY2FCczVsdCtBaE1TMlNHeEVIYUVuYzNZTHlPU21JK25pVURUTlBldUVP?=
 =?utf-8?B?T3hTNUVFd0ZLL0phMklRSURWbDhNRHFWVG1PemZPRnViYVkxUWNUVG1YYUdF?=
 =?utf-8?B?czhVUWc2bUlBS1lXTy96UUcrY2Vka2FMSHJLeG4yV0FPa254V3o1V3FUOHVT?=
 =?utf-8?B?TStWdGpEUU1Cd1Q0aHhpcm8rc2h2Q2YwNTc3SG1URmNVUUlpamtVcGM5bnlk?=
 =?utf-8?B?bmc2OUYzQ050aGlXL2djV1dHV1QxTU9NT0VBZG81QnV5TE1rd1RSaXRSQ2ps?=
 =?utf-8?B?RjVZNlpEMVVDVG9zOEFjdnFYY3kxOUVIalJyT0x1bUUySWY5b01tV2Nab3JS?=
 =?utf-8?B?Wm9pOWM2R01MWGpzbS8wdzVuRVNXVjJmaXhVYzFMOVFoMkIyK1pwbGxacWpT?=
 =?utf-8?B?bTVaU3IxZnNvRjF1Qk5lc1lqbmdiYTJaREV3bDJWMTR1RFdrSmZjUUcwa3gz?=
 =?utf-8?B?OHh2R2JOeVE4QUZnK0E1aEtJMmJGcEtIeHRISjFGNmF3VlNya3hRZkV6SmNl?=
 =?utf-8?B?U2l6TWFmaGY5N1Q5N0JtdlJaaTRTL1pBVjh4UmVLUFI4MUJEQVpLU2UzQXRT?=
 =?utf-8?B?UnA3YzY5a1RQSTEwb2lKS0xBdXlMaDB2TE84M3pvMlM3V01tcFpFNWE2Qnhi?=
 =?utf-8?B?OHIxTGZjd3o5OHJLcmd2NmR0VUFrSkt3V05RS1g0TWhYaW4wRnB2cU4zc3Zw?=
 =?utf-8?B?OFZDNzd5SnVFdDZnMTN3NUd3MWVCR2tMSE52M3NTNy9SR21hYi9uM3J1S3pa?=
 =?utf-8?B?aXNvZnFoaEoyZlhYUlJSU091UnM3Z2pqYmZ5YWxkNUpOWUVSV21GTmNKREFO?=
 =?utf-8?B?b2RqU3J0cnl3SWVQVHc1WFAveDVxejRlT1NiOFQ3VmVqbzQvT3pPRWZQcUlN?=
 =?utf-8?B?alY5UHcvY3Rlc21hcWdHZFhrYzYyOVRLZGh5amkvb09mT2NLcnBjVTlNOHRG?=
 =?utf-8?B?KytyK2RTYnRrUlFrUWpXY0pxV1lNZkR6SDY3NmlMM2FHdndac0lIaDRiRFVV?=
 =?utf-8?B?UC9OSVJFVVFoNzVDd21yVVRISklTRHluS0JENDJpSmFSNDJkOUtxdDJYUkcw?=
 =?utf-8?B?QWNiTXpqdkVrZGxZeGRIS1Uybm9oQnZFRVNGRFBpcFlZYXMwNjRRd2xSenN2?=
 =?utf-8?B?aFU0VU9sTU8xYzVKdFAyYS90eFMyazluUU9xSU1MMTlzTWZYejVHZ0lCYnFK?=
 =?utf-8?B?Z0c0M3hyZVdUb0Uyb25DeHBuQUR6SUF4WWhVKytINDYwbE9aQ0NzeSt2UVBm?=
 =?utf-8?B?bE1sS1RXdXkzRUlPRUlrTGNuOGxxa0RIeVRSRmJTYWZYSDlsakx3SmNBKy9P?=
 =?utf-8?B?bEQwVXRsYS8rYXludnhRN3d2bzBrbUxNWW85QXpnVVFhV21TaXZ1ZWpSNTJ5?=
 =?utf-8?B?cjFSTkFkV0JCNFFvQVdWaXE0SnZTMC9lQ3ovSUdvMGk0ak9QYmIwVEs0T1Y2?=
 =?utf-8?Q?kJ617ilXR3CsA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6d84cd-830b-4389-ed5f-08d8f37e1d05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:17:05.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qduXOdXmql7nqKwS53DFD7skHVXnh5sP5uSVBQaylCezcfyr3MJd+0vWqUwycv8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

QW0gMzAuMDMuMjEgdW0gMTU6MTUgc2NocmllYiBDaGVuLCBHdWNodW46Cj4gW0FNRCBQdWJsaWMg
VXNlXQo+Cj4gVGhhbmtzIENocmlzdGlhbiwgSSB3aWxsIHB1dCBsYXNlciBmb2N1cyBvbiB0aGlz
IHBhdGNoIGFmdGVyIG1lcmdpbmcgaXQuCj4KPiBJIG5vdGljZSB0aGUgc2FtZSBsb2dpYyBpbiBy
YWRlb24gY29kZSByYWRlb25fdHRtX3R0X3VucGluX3VzZXJwdHIuIFNoYWxsIEkgY3JlYXRlIGFu
b3RoZXIgcGF0Y2ggdG8gZml4IGl0IGFzIHdlbGw/CgpJZiB5b3UgaGF2ZSB0aW1lLCB0aGVuIHBs
ZWFzZSBkbyBzby4gQ2F1c2UgdGhvc2UgYnVncyBhcmUgb24gbXkgdG9kbyAKbGlzdCBmb3IgcXVp
dGUgYSB3aGlsZSBhbmQgSSBjb3VsZG4ndCBmaW5kIHRpbWUgdG8gZml4IHRoZW0uCgpSZWdhcmRz
LApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiBHdWNodW4KPgo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+Cj4gU2VudDogVHVlc2RheSwgTWFyY2ggMzAsIDIwMjEgNjozOSBQTQo+IFRv
OiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UKPgo+IEFt
IDMwLjAzLjIxIHVtIDEyOjAyIHNjaHJpZWIgR3VjaHVuIENoZW46Cj4+IHR0bS0+c2cgbmVlZHMg
dG8gYmUgY2hlY2tlZCBiZWZvcmUgYWNjZXNzaW5nIGl0cyBjaGlsZCBtZW1iZXIuCj4+Cj4+IENh
bGwgVHJhY2U6Cj4+ICAgIGFtZGdwdV90dG1fYmFja2VuZF9kZXN0cm95KzB4MTIvMHg3MCBbYW1k
Z3B1XQo+PiAgICB0dG1fYm9fY2xlYW51cF9tZW10eXBlX3VzZSsweDNhLzB4NjAgW3R0bV0KPj4g
ICAgdHRtX2JvX3JlbGVhc2UrMHgxN2QvMHgzMDAgW3R0bV0KPj4gICAgYW1kZ3B1X2JvX3VucmVm
KzB4MWEvMHgzMCBbYW1kZ3B1XQo+PiAgICBhbWRncHVfYW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9y
eV9vZl9ncHUrMHg3OGIvMHg4YjAgW2FtZGdwdV0KPj4gICAga2ZkX2lvY3RsX2FsbG9jX21lbW9y
eV9vZl9ncHUrMHgxMTgvMHgyMjAgW2FtZGdwdV0KPj4gICAga2ZkX2lvY3RsKzB4MjIyLzB4NDAw
IFthbWRncHVdCj4+ICAgID8ga2ZkX2Rldl9pc19sYXJnZV9iYXIrMHg5MC8weDkwIFthbWRncHVd
Cj4+ICAgIF9feDY0X3N5c19pb2N0bCsweDhlLzB4ZDAKPj4gICAgPyBfX2NvbnRleHRfdHJhY2tp
bmdfZXhpdCsweDUyLzB4OTAKPj4gICAgZG9fc3lzY2FsbF82NCsweDMzLzB4ODAKPj4gICAgZW50
cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQo+PiBSSVA6IDAwMzM6MHg3Zjk3
ZjI2NGQzMTcKPj4gQ29kZTogYjMgNjYgOTAgNDggOGIgMDUgNzEgNGIgMmQgMDAgNjQgYzcgMDAg
MjYgMDAgMDAgMDAgNDggYzcgYzAgZmYKPj4gZmYgZmYgZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAg
MDAgMDAgMDAgMDAgYjggMTAgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZAo+PiAwMSBmMCBmZiBmZiA3
MyAwMSBjMyA0OCA4YiAwZCA0MSA0YiAyZCAwMCBmNyBkOCA2NCA4OSAwMSA0OAo+PiBSU1A6IDAw
MmI6MDAwMDdmZmRiNDAyYzMzOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAw
MDAwMDEwCj4+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3Zjk3ZjNjYzYzYTAgUkNY
OiAwMDAwN2Y5N2YyNjRkMzE3Cj4+IFJEWDogMDAwMDdmZmRiNDAyYzM4MCBSU0k6IDAwMDAwMDAw
YzAyODRiMTYgUkRJOiAwMDAwMDAwMDAwMDAwMDAzCj4+IFJCUDogMDAwMDdmZmRiNDAyYzM4MCBS
MDg6IDAwMDA3ZmZkYjQwMmM0MjggUjA5OiAwMDAwMDAwMGM0MDAwMDA0Cj4+IFIxMDogMDAwMDAw
MDBjNDAwMDAwNCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMGMwMjg0YjE2Cj4+
IFIxMzogMDAwMDAwMDAwMDAwMDAwMyBSMTQ6IDAwMDA3Zjk3ZjNjYzYzYTAgUjE1OiAwMDAwN2Y4
ODM2MjAwMDAwCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBh
bWQuY29tPgo+IFllYWggSSBoYWQgdGhpcyBvbmUgb24gbXkgVE9ETyBsaXN0IGFzIHdlbGwuCj4K
PiBGb3Igbm93IHRoZSBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPiwgYnV0IEknbSBub3QgMTAwJSBzdXJlIGlmIHRoaXMgaXMgdGhl
IHJpZ2h0IGZpeC4KPgo+IFBsZWFzZSBrZWVwIGFuIGV5ZSBvcGVuIGlmIGFueWJvZHkgY29tcGxh
aW5zIGFib3V0IGlzc3VlcyB3aXRoIHRoaXMgcGF0Y2gsIGlmIHllcyB3ZSBuZWVkIHRvIGdldCBi
YWNrIHRvIHRoZSBkcmF3aW5nIGJvYXJkLgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+IC0tLQo+PiAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAyICstCj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+IGluZGV4IGUwMDI2M2JjYzg4Yi4uNzIy
ZWZkODY3MThlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
Cj4+IEBAIC04NjcsNyArODY3LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3R0bV90dF91bnBpbl91
c2VycHRyKHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+PiAgICAJCURNQV9CSURJUkVDVElPTkFM
IDogRE1BX1RPX0RFVklDRTsKPj4gICAgCj4+ICAgIAkvKiBkb3VibGUgY2hlY2sgdGhhdCB3ZSBk
b24ndCBmcmVlIHRoZSB0YWJsZSB0d2ljZSAqLwo+PiAtCWlmICghdHRtLT5zZy0+c2dsKQo+PiAr
CWlmICghdHRtLT5zZyB8fCAhdHRtLT5zZy0+c2dsKQo+PiAgICAJCXJldHVybjsKPj4gICAgCj4+
ICAgIAkvKiB1bm1hcCB0aGUgcGFnZXMgbWFwcGVkIHRvIHRoZSBkZXZpY2UgKi8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
