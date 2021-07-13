Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9931AC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 19:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C6B610C7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 19:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C6B610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A42D6E116;
	Tue, 13 Jul 2021 19:19:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9CA6E116
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 19:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKmHNlIr4fmtD7K1UmKGhWzC/pQoEOYolsZ8AVYNwjOYMqe/Sx3IFnN2X/gFoFKpCNo+qEcIEHgPlfu0iPe5TZPspYVL5LAu9Hc23MbVxfVGeCszEjMTs03iLj3aKNUA5O+KRhWR6Od4iRB8HPj0oeh/ySEZVEB6bQKM2m5YLMs9PTLYadYW3B01EXJcgWnjBEga6f/UejmDvnerZOoXK9pGGyB0y4cjKNV9ngVRNH3rvy3NEBlx7Q+0tW+SgCS5Q7hwwUUzCGbGvMn7U3eyKAqE2cx1Cldb/Y5t8e8VQ8wJqoO1HUSc/prS2G4G/isdeBOkzRoYmNru10pz3cbNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNHhTrDcFIpqwGjxm85tvYY618EDwmoNmrYnF06KQ1c=;
 b=mkT6zeMJZTT/XDSQIQl1wboKW7M2LMru/14z/gbqdk7F8VqwpZJmRlYDFhk5Y4ATrqw/8kOgfIUoWwNA3VAzIxgCLDhdjTTixpmdwHJPlworCFU9Skj2beVKU/SbfzR8yQboIuJ8YZuQWT/9ROiJ6swLN6QZcAUP5RY3d1U5vkfI5xmT5sENSXxbmAAsTfrlWROW65Vo5Dkx2WAHMRMDr1as8cWnxMN9fAZKBTbo1rYxgHNKdXP2Uzg0wsltoyPPwnYkCkidu+P286pVSnzEJpOuyauSw/yiz/Lagt/IBLhuj251r9KHCNUObB9vnauplvEXe3v6EBhjCQrhy7nLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNHhTrDcFIpqwGjxm85tvYY618EDwmoNmrYnF06KQ1c=;
 b=ybJ6yPZ0pJp9wmsXnRmDPQDnLP7SMsy3HJS0xlvJKGR93fjOQcZ8BOQfzpqN2kue/A86M/xbg8urnlcc1qWX1bfHGmdWEhPvno5NLXW+WNww3/UeKZAridmLUo4xlYnvFx+ptKxXyrhSrrbBbn8nOV6d/jxoanSBTjGMDi4Pryg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 13 Jul
 2021 19:19:52 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561%4]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 19:19:51 +0000
Subject: Re: [PATCH] drm/amdgpu: further lower VRAM allocation overhead
To: amd-gfx@lists.freedesktop.org
References: <20210713191739.458131-1-jinhuieric.huang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <a1cad35e-e24d-3078-bbc2-1534a625d932@amd.com>
Date: Tue, 13 Jul 2021 15:19:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210713191739.458131-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:890e:34c4:757:cc76]
 (2607:9880:2048:122:890e:34c4:757:cc76) by
 YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 13 Jul 2021 19:19:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34eb0ba7-d7fc-4d1c-561b-08d946333033
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB512810E343A97622AF135F4082149@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPfbqafir1mjsq5WAoKEmJ+UPaRM8L5vICGPmjQB3UnduUNwh/gtUnzphuMoIVw29GFxp6tF/03izBlVtuPMRAl31wm1VnNxuRH/ZrYiYfyfC9hFz+8Ct0Kjslkay/TYhSZmtQ2MGDoumlpSoZubFdpTAQzURRvVS6Wk3Y/8b0Lq2mu7BXAjNdUHUxla5ah1JajHTK6WXvjIx9MepdYlawQEehH3SpZh5BC+0N5MCaS4hBsgMy1TNKo24QE1l4fSYbcDaien/jEjBoPrddDRJ2QqXSeQDmhj3mrUCWc+/Sxw0B+SU/3KPbJYVX3Wcbup2a+vUMoC/c3wrwfQCBlUDMTFKNuExH25ZDTxGhCVKXmSRxXOH0sQVh+hF1Kb5OqEbiCBVqBpB8hNOLOz75B1exoYSVX5ClPjiKWd/hFqCFMI08ml3bZw9Apc9KQZsI6sPAQeBORfYFHwzx4mnhunZIwBafwkojrT8aOSGulLwaOlWQjAr4/fD1N36NwAy+C9ge6YU5ZlPJC3L8HDxXy2C5SN2sR5Q3SEH4xr+t9PYkkn7Pflildcak5EBI/vxGALmp7/lTXMMZE2Zacko0tVruxdCuNWfeFLq+tTYUozmHUHkN4LwUSn8SSLBZzWgcFDjuO4173TJ++8BvcSBCp0gZ00Ee7DNzkW9KnZNmqepPpc31O3m0mlqsAtnCJ8ORI4IJR2uLiqqrVXCiI3nJSAcSCQ778HmLSIpXDoX490q70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(6916009)(8676002)(54906003)(5660300002)(4326008)(316002)(83380400001)(31696002)(86362001)(2906002)(186003)(31686004)(2616005)(6486002)(53546011)(38100700002)(36756003)(478600001)(66574015)(66556008)(66946007)(66476007)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmV4WHRDSWtUaDk5SGlFWEZoWUtPNG10NDNGNjFWdnlKWXU0aGs2N25YSk44?=
 =?utf-8?B?Um1keXVkSW5YWXBnWTdua09lZUVENStiNi8yRzhQY2RWb3JxTHRzR25xODd5?=
 =?utf-8?B?RVFFSVdjQlJzOE90cU5MZ1U0T1FOZ2twbW4vZ2V2Y1FueWFFMmhKVFZSWGw4?=
 =?utf-8?B?dlJHbG9EOUJ1RE5JV2haRm9FaE1mNzBtNnJCNzNaajRDZWRFNkE1Tm5kcDBH?=
 =?utf-8?B?ZDVUdWVEUTFiZ3hWZ0NWSTZpV05rNDlCNEU3dktQaXVYME85elFHMElXdXhK?=
 =?utf-8?B?d1ArR0syMWNtbytaUkZkU3R4K3hFQXlZcXp1TVFyTkQ4bVJYRFNUSndENXNU?=
 =?utf-8?B?L2FaY3Q1UUlPQWJwQUpuU2tFWTRYSDBhL3pEbnNEQUxjcm9pN1Y4cERUVzN1?=
 =?utf-8?B?dWxGSlk1L3FwN1c2KzlWbDY3YUJUdVF1cFlqcnRSVWlIeTFoa3hjdzdPaTVK?=
 =?utf-8?B?bnVkRm94b3dZbDVJVFRQNHQ4REkvTGN5eFRtZkJTc1JtSEtvbTNlUmx4S0VG?=
 =?utf-8?B?N1ZnV25ONkhMOGVhZzVFTVduSDVHQmQ2ZkE4VTZIUVVMaWJmSzZjZUJUWVNB?=
 =?utf-8?B?eDdyWnZxRFZmYUZSWUdkQ1FtazlmanFmNzdueDhLNTE1NWYzc2tZWjYxM3Yr?=
 =?utf-8?B?dENyd2RjMHM3UXI4QnVWdEQ1ZFdBWCtVN1Y4VGJXYS9SVjJQTUVMN2RPalRQ?=
 =?utf-8?B?VkRJS0dBd2lJK3dFQXJHeEZkRUcyRmVkMGY1SVVDM3B0VmNkSnA4QzJjZmVw?=
 =?utf-8?B?TEJGYkp6azBJS29rUkFDLzBBelo3QnRURjZiM2FkSGVtZ0JSZm9NbVQ3TlNR?=
 =?utf-8?B?c2t5VEY4elRCT21NMkRKTkFub1FVMEhvb3RFSjNaWXRUdW8zVmtHSEQ1cWR2?=
 =?utf-8?B?LzJBaTl6Q2dTTFZKdkhiSlNmTG1WSTRDcHNGVm5CV0dKclVpcVpsVThOQjh0?=
 =?utf-8?B?KzVsVVJTRTJ4U2IrYU5uL0xmSm1nRU5vUDQxcTcvbzJsYzVsN1pHT3VFYkVL?=
 =?utf-8?B?SU16VGhJakJpVjhJWmpRWWJKSEVWQVBZZzNyd29xdkREY2NzVEh4dzdPRExs?=
 =?utf-8?B?UkVuc3BWOHRMNXVUUU5CMk1FZHMwMEpYbWtFMkRHelFEdUtWOGRHZnU5SHh4?=
 =?utf-8?B?bzBhTHhEYlBYM0JJNXQ0WFNmS0gvR0Ywd0w2c051SzREejJKQ1RhTHRYVnBa?=
 =?utf-8?B?aFhBTno0dFZUZXdTSnVOY0NuNXM0dXM2OFF2blo3Zk9vcWluZjdaUnBmNmN2?=
 =?utf-8?B?N0tVb0E2N1VUYXhxRmNvV3JacFJBS29HZFpKd2VsSHczOFFUeGhrM1ZCWUY5?=
 =?utf-8?B?eTk0eEpxVHVXK3ZtMTkyTk1TVjE0dllTV1poeUQyd2MrcVllVU42Z2t0LzJi?=
 =?utf-8?B?d1lja2FPMjdkSU1oM0J5TGxQRDI1dWcxL045WS9BUENMTmRvUEllcTF6Y0tL?=
 =?utf-8?B?MmtwaG9zYUZ4Vkx4MC8xejl3bVBFMitERzFXWXdTanVMdWxiRFNQci83bkdi?=
 =?utf-8?B?eFRzVlBidWRmUXFNbS9EVmdzeEdDWEsyVHFJRmN0cEd5QThiN0lQRm9yWGFh?=
 =?utf-8?B?dU92QWE3MFoyRnNPSktWRDc2QWVPYTYySUpMVmNZclg1NnNIR1N1ekVXaWtw?=
 =?utf-8?B?QmJWbldLbWxVWDlXSXc3VVViZEk4a2ZkbHRXeFZLb2hrVTk2WkJLSE90WkJs?=
 =?utf-8?B?NWI1VkpvUkJGWjhiVndBUGkyeERaRHIveFA2YVZzci9FNllFVVpDWng1TXBU?=
 =?utf-8?B?WnRTamRjRjM5dVhabkxLQzh2MWYzZ0pzSU9uM3FDdGhkdjdOVGlnTEFqTmsz?=
 =?utf-8?B?Y3NXbzBDbDdTUDFwWmhTQ2hsYzNKV2xNMTkrMSs4bVJ0bXZNUTJPSFNyWG5V?=
 =?utf-8?Q?u195iWAMWrcQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eb0ba7-d7fc-4d1c-561b-08d946333033
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 19:19:51.7444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqOLnXd50Xv+w2bNZ2BtOakp6Oatl/cqF6zjV29zDCM90iATvwobNRdug1kT42Mi9/yFjzs7kZZHo/i1gDJZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuL0ZlbGl4LAoKSWYgeW91IGRvbid0IGhhdmUgb2JqZWN0aW9uLCBpdCB3aWxs
IGJlIHB1c2hlZCBpbnRvIAphbWQtc3RhZ2luZy1ka21zLTUuMTEgYW5kIGFtZC1zdGFnaW5nLWRy
bS1uZXh0LgoKVGhhbmtzLApFcmljCgpPbiAyMDIxLTA3LTEzIDM6MTcgcC5tLiwgRXJpYyBIdWFu
ZyB3cm90ZToKPiBGb3IgYWxsb2NhdGlvbnMgbGFyZ2VyIHRoYW4gNDhNaUIgd2UgbmVlZCBtb3Jl
IHRoYW4gYSBwYWdlIGZvciB0aGUKPiBob3VzZWtlZXBpbmcgaW4gdGhlIHdvcnN0IGNhc2UgcmVz
dWx0aW5nIGluIHRoZSB1c3VhbCB2bWFsbG9jIG92ZXJoZWFkLgo+Cj4gVHJ5IHRvIGF2b2lkIHRo
aXMgYnkgYXNzdW1pbmcgdGhlIGdvb2QgY2FzZSBhbmQgb25seSBmYWxsaW5nIGJhY2sgdG8gdGhl
Cj4gd29yc3QgY2FzZSBpZiB0aGlzIGRpZG4ndCB3b3JrZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgNzEgKysrKysrKysrKysrKysr
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJh
bV9tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4g
aW5kZXggYmU0MjYxYzQ1MTJlLi5lY2JlMDVlMWRiNjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+IEBAIC0zNjEsOSArMzYxLDExIEBAIHN0
YXRpYyB2b2lkIGFtZGdwdV92cmFtX21ncl92aXJ0X3N0YXJ0KHN0cnVjdCB0dG1fcmVzb3VyY2Ug
Km1lbSwKPiAgIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291
cmNlX21hbmFnZXIgKm1hbiwKPiAgIAkJCSAgICAgICBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3Qg
KnRibywKPiAgIAkJCSAgICAgICBjb25zdCBzdHJ1Y3QgdHRtX3BsYWNlICpwbGFjZSwKPiArCQkJ
ICAgICAgIHVuc2lnbmVkIGxvbmcgbnVtX25vZGVzLAo+ICsJCQkgICAgICAgdW5zaWduZWQgbG9u
ZyBwYWdlc19wZXJfbm9kZSwKPiAgIAkJCSAgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0p
Cj4gICB7Cj4gLQl1bnNpZ25lZCBsb25nIGxwZm4sIG51bV9ub2RlcywgcGFnZXNfcGVyX25vZGUs
IHBhZ2VzX2xlZnQsIHBhZ2VzOwo+ICsJdW5zaWduZWQgbG9uZyBscGZuLCBwYWdlc19sZWZ0LCBw
YWdlczsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZyYW1fbWdyICptZ3IgPSB0b192cmFtX21ncihtYW4p
Owo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gdG9fYW1kZ3B1X2RldmljZShtZ3Ip
Owo+ICAgCXVpbnQ2NF90IHZpc191c2FnZSA9IDAsIG1lbV9ieXRlcywgbWF4X2J5dGVzOwo+IEBA
IC0zOTMsMjEgKzM5NSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3Qg
dHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPiAgIAkJcmV0dXJuIC1FTk9TUEM7Cj4gICAJfQo+
ICAgCj4gLQlpZiAocGxhY2UtPmZsYWdzICYgVFRNX1BMX0ZMQUdfQ09OVElHVU9VUykgewo+IC0J
CXBhZ2VzX3Blcl9ub2RlID0gfjB1bDsKPiAtCQludW1fbm9kZXMgPSAxOwo+IC0JfSBlbHNlIHsK
PiAtI2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRQo+IC0JCXBhZ2VzX3Blcl9ub2Rl
ID0gSFBBR0VfUE1EX05SOwo+IC0jZWxzZQo+IC0JCS8qIGRlZmF1bHQgdG8gMk1CICovCj4gLQkJ
cGFnZXNfcGVyX25vZGUgPSAyVUwgPDwgKDIwVUwgLSBQQUdFX1NISUZUKTsKPiAtI2VuZGlmCj4g
LQkJcGFnZXNfcGVyX25vZGUgPSBtYXhfdCh1aW50MzJfdCwgcGFnZXNfcGVyX25vZGUsCj4gLQkJ
CQkgICAgICAgbWVtLT5wYWdlX2FsaWdubWVudCk7Cj4gLQkJbnVtX25vZGVzID0gRElWX1JPVU5E
X1VQKG1lbS0+bnVtX3BhZ2VzLCBwYWdlc19wZXJfbm9kZSk7Cj4gLQl9Cj4gLQo+ICAgCW5vZGVz
ID0ga3ZtYWxsb2NfYXJyYXkoKHVpbnQzMl90KW51bV9ub2Rlcywgc2l6ZW9mKCpub2RlcyksCj4g
ICAJCQkgICAgICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwo+ICAgCWlmICghbm9kZXMpIHsK
PiBAQCAtNDM1LDcgKzQyMiwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3Ry
dWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4gICAJaSA9IDA7Cj4gICAJc3Bpbl9sb2Nr
KCZtZ3ItPmxvY2spOwo+ICAgCXdoaWxlIChwYWdlc19sZWZ0KSB7Cj4gLQkJdWludDMyX3QgYWxp
Z25tZW50ID0gbWVtLT5wYWdlX2FsaWdubWVudDsKPiArCQl1bnNpZ25lZCBsb25nIGFsaWdubWVu
dCA9IG1lbS0+cGFnZV9hbGlnbm1lbnQ7Cj4gKwo+ICsJCWlmIChpID49IG51bV9ub2Rlcykgewo+
ICsJCQlyID0gLUUyQklHOwo+ICsJCQlnb3RvIGVycm9yOwo+ICsJCX0KPiAgIAo+ICAgCQlpZiAo
cGFnZXMgPj0gcGFnZXNfcGVyX25vZGUpCj4gICAJCQlhbGlnbm1lbnQgPSBwYWdlc19wZXJfbm9k
ZTsKPiBAQCAtNDkyLDYgKzQ4NCw0OSBAQCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXco
c3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4gICAJcmV0dXJuIHI7Cj4gICB9Cj4g
ICAKPiArLyoqCj4gKyAqIGFtZGdwdV92cmFtX21ncl9hbGxvYyAtIGFsbG9jYXRlIG5ldyByYW5n
ZQo+ICsgKgo+ICsgKiBAbWFuOiBUVE0gbWVtb3J5IHR5cGUgbWFuYWdlcgo+ICsgKiBAdGJvOiBU
VE0gQk8gd2UgbmVlZCB0aGlzIHJhbmdlIGZvcgo+ICsgKiBAcGxhY2U6IHBsYWNlbWVudCBmbGFn
cyBhbmQgcmVzdHJpY3Rpb25zCj4gKyAqIEBtZW06IHRoZSByZXN1bHRpbmcgbWVtIG9iamVjdAo+
ICsgKgo+ICsgKiBBbGxvY2F0ZSBWUkFNIGZvciB0aGUgZ2l2ZW4gQk8uCj4gKyAqLwo+ICtzdGF0
aWMgaW50IGFtZGdwdV92cmFtX21ncl9hbGxvYyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIg
Km1hbiwKPiArCQkJCSBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKnRibywKPiArCQkJCSBjb25z
dCBzdHJ1Y3QgdHRtX3BsYWNlICpwbGFjZSwKPiArCQkJCSBzdHJ1Y3QgdHRtX3Jlc291cmNlICpt
ZW0pCj4gK3sKPiArCXVuc2lnbmVkIGxvbmcgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZTsKPiAr
CWludCByOwo+ICsKPiArCWlmIChwbGFjZS0+ZmxhZ3MgJiBUVE1fUExfRkxBR19DT05USUdVT1VT
KQo+ICsJCXJldHVybiBhbWRncHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBwbGFjZSwgMSwgfjB1
bCwgbWVtKTsKPiArCj4gKyNpZmRlZiBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UKPiArCXBh
Z2VzX3Blcl9ub2RlID0gSFBBR0VfUE1EX05SOwo+ICsjZWxzZQo+ICsJLyogZGVmYXVsdCB0byAy
TUIgKi8KPiArCXBhZ2VzX3Blcl9ub2RlID0gMlVMIDw8ICgyMFVMIC0gUEFHRV9TSElGVCk7Cj4g
KyNlbmRpZgo+ICsJcGFnZXNfcGVyX25vZGUgPSBtYXhfdCh1aW50MzJfdCwgcGFnZXNfcGVyX25v
ZGUsCj4gKwkJCSAgICAgICBtZW0tPnBhZ2VfYWxpZ25tZW50KTsKPiArCW51bV9ub2RlcyA9IERJ
Vl9ST1VORF9VUChtZW0tPm51bV9wYWdlcywgcGFnZXNfcGVyX25vZGUpOwo+ICsKPiArCWlmIChz
aXplb2Yoc3RydWN0IGRybV9tbV9ub2RlKSAqIG51bV9ub2RlcyA+IFBBR0VfU0laRSkgewo+ICsJ
CXIgPSBhbWRncHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBwbGFjZSwKPiArCQkJCVBBR0VfU0la
RSAvIHNpemVvZihzdHJ1Y3QgZHJtX21tX25vZGUpLAo+ICsJCQkJcGFnZXNfcGVyX25vZGUsCW1l
bSk7Cj4gKwkJaWYgKHIgIT0gLUUyQklHKQo+ICsJCQlyZXR1cm4gcjsKPiArCX0KPiArCj4gKwly
ZXR1cm4gYW1kZ3B1X3ZyYW1fbWdyX25ldyhtYW4sIHRibywgcGxhY2UsIG51bV9ub2RlcywgcGFn
ZXNfcGVyX25vZGUsCj4gKwkJCQkgICBtZW0pOwo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBhbWRn
cHVfdnJhbV9tZ3JfZGVsIC0gZnJlZSByYW5nZXMKPiAgICAqCj4gQEAgLTY5Myw3ICs3MjgsNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfdnJhbV9tZ3JfZGVidWcoc3RydWN0IHR0bV9yZXNvdXJjZV9t
YW5hZ2VyICptYW4sCj4gICB9Cj4gICAKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdHRtX3Jlc291
cmNlX21hbmFnZXJfZnVuYyBhbWRncHVfdnJhbV9tZ3JfZnVuYyA9IHsKPiAtCS5hbGxvYwk9IGFt
ZGdwdV92cmFtX21ncl9uZXcsCj4gKwkuYWxsb2MJPSBhbWRncHVfdnJhbV9tZ3JfYWxsb2MsCj4g
ICAJLmZyZWUJPSBhbWRncHVfdnJhbV9tZ3JfZGVsLAo+ICAgCS5kZWJ1Zwk9IGFtZGdwdV92cmFt
X21ncl9kZWJ1Zwo+ICAgfTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
